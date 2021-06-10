import java.util.ArrayList;

class OffSet {
    int methodCounter = 0;
    int parentMethodCounter = 0;
    ArrayList <String> methods = new ArrayList <String> ();

    int parentOffSet = 0;
    ArrayList <Integer> fieldOffSets = new ArrayList <Integer> ();
    ArrayList <String> fields = new ArrayList <String> ();

    public boolean isOverriding(ArrayList <String> overrides, String mName) {

        for (int i = 0; i < overrides.size(); ++i)
            if (overrides.get(i).equals(mName))
                return true;

        return false;
    }

    public int getSize() {
        if (this.fieldOffSets.size() > 0)
            return this.fieldOffSets.get(this.fieldOffSets.size() -1);
        return this.parentOffSet;
    }

    private String findTypeAndParam(String methodName, ArrayList <MethodEntry> methodsList) {
        String ret = "";
        for (int i = 0; i < methodsList.size(); ++i) {
            MethodEntry m = methodsList.get(i);
            if (m.getMethod().getName().equals(methodName)) {
                String type = m.getMethod().getType();
                switch (type) {
                    case "int":
                        ret += "i32 (i8*, ";
                        break;
                    case "int[]":
                        ret += "i32* (i8*, ";
                        break;
                    case "boolean":
                        ret += "i1 (i8*, ";
                        break;
                    default:
                        ret += "i8* (i8*, ";
                }
                ArrayList <Entry> param = m.getParam();
                for (int j = 0; j < param.size(); ++j) {
                    String t = param.get(j).getType();
                    switch (t) {
                        case "int":
                            ret += "i32, ";
                            break;
                        case "int[]":
                            ret += "i32*, ";
                            break;
                        case "boolean":
                            ret += "i1, ";
                            break;
                        default:
                            ret += "i8*, ";
                    }
                }
                ret = ret.substring(0, ret.length() -2);
                ret += ")* ";
                return ret;
            }
        }

        return null;
    }

    public String addMethods(ArrayList <ArrayList <String>> overList, ArrayList <String> classNames, ArrayList <MethodEntry> methodList, String cName) {
        String ret = "";
        ArrayList <String> visited = new ArrayList <String> ();

        for (int i = 0; i < methods.size(); ++i) {
            boolean flag = true;
            String mName = methods.get(i);
            for (int j = 0; j < overList.size(); ++j) {
                if (isOverriding(overList.get(j), mName) && (!visited.contains(mName))) {
                    visited.add(mName);
                    ret += "i8* bitcast (";
                    ret += findTypeAndParam(mName, methodList);
                    ret += "@" + classNames.get(j) + "." + mName + " to i8*),\n\t";
                    flag = false;
                }
                else if (mName.equals("main") && (!visited.contains(mName))) {
                    visited.add(mName);
                    ret += "i8* bitcast (i32 (i8**)* @main to i8*),\n\t";
                    flag = false;
                }
            }

            if (flag && (!visited.contains(mName))) {
                visited.add(mName);
                ret += "i8* bitcast (";
                ret += findTypeAndParam(mName, methodList);
                ret += "@" + cName + "." + mName + " to i8*),\n\t";
            }

        }

        return ret;
    }

    public int getMethodOffSet(String m) {
        for (int i = 0; i < methods.size(); ++i) {
            String mName = methods.get(i);
            if (mName.equals(m))
                return this.parentMethodCounter+i;
        }

        return -1;
    }

    public int getFieldOffSet(String f){
        for (int i = 0; i < fields.size(); ++i) {
            String fName = fields.get(i);
            if (fName.equals(f)) {
                if (i == 0)
                    return this.parentOffSet;
                return fieldOffSets.get(i-1);
            }
        }
        return -1;
    }

    public void print(String className) {
        for (int i = 0; i < this.fields.size(); ++i) {
            if (i == 0) {
                System.out.println(className + "." + this.fields.get(i) + " : " + this.parentOffSet);
                continue;
            }
            System.out.println(className + "." + this.fields.get(i) + " : " + this.fieldOffSets.get(i-1));
        }

        for (int i = 0; i < this.methodCounter; ++i) {
            System.out.println(className + "." + this.methods.get(i) + " : " + (this.parentMethodCounter +i)*8);
        }
    }

    public void setParentOffSet(int off) {
        this.parentOffSet = off;
    }

    public void setMethodCounter(int n) {
        this.parentMethodCounter = n;
    }

    public void addMethod(String m) {
        this.methodCounter += 1;
        this.methods.add(m);
    }

    public void addField(String f, int size) {
        int idx = this.fieldOffSets.size() -1;
        if (idx == -1) {
            this.fieldOffSets.add(size+this.parentOffSet);
        }
        else {
            int offSet = this.fieldOffSets.get(idx);
            this.fieldOffSets.add(offSet+size);
        }
        this.fields.add(f);
    }

    public int getParentOffSet() {
        if (this.fieldOffSets.size() > 0)
            return this.fieldOffSets.get(this.fieldOffSets.size() -1);
        return  this.parentOffSet;
    }

    public int getMethodCounter() {
        return this.methodCounter + this.parentMethodCounter;
    }
}
