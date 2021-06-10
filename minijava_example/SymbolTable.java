import java.util.ArrayList;

class SymbolTable {
    ArrayList <ClassEntry> classTable = new ArrayList <ClassEntry> ();
    int classNum = -1;
    String className = null;
    String methodName = null;
    // String offset = "";

    public boolean isField(String ident) {
        if (this.methodName == null)
            return false;
        // System.out.println(this.className + " " + this.methodName);
        ClassEntry c = findClass(this.className);
        while (c != null) {
            MethodEntry method = findMethod(c.getTable().getMethods(), this.methodName);
            if (method == null) {
                c = c.getInhClass();
                continue;
            }
            ArrayList <Entry> declarations = method.getTable();
            for (int i = 0; i < declarations.size(); ++i) {
                Entry e = declarations.get(i);
                if (e.getName().equals(ident))
                    return false;
            }
            ArrayList <Entry> params = method.getParam();
            for (int i = 0; i < params.size(); ++i) {
                Entry e = params.get(i);
                if (e.getName().equals(ident))
                    return false;
            }
            c = c.getInhClass();
        }
        return true;
    }

    public String printParamTypes(String className, String methodName) {
        ClassEntry c = findClass(className);
        MethodEntry method = findMethod(c.getTable().getMethods(), methodName);
        c = c.getInhClass();
        while (c != null && method == null) {
            method = findMethod(c.getTable().getMethods(), methodName);
            c = c.getInhClass();
        }
        ArrayList <Entry> params = method.getParam();


        String ret = "i8*";
        for (int i = 0; i < params.size(); ++i) {
            switch (params.get(i).getType()) {
              case "int":
                ret += ", i32";
                break;
              case "boolean":
                ret += ", i1";
                break;
              case "int[]":
                ret += ", i32*";
                break;
              default:
                ret += ", i8*";
            }
        }

        return ret;
    }

    public String findMethodRetType(String className, String methodName) {
        ClassEntry c = findClass(className);
        MethodEntry method = findMethod(c.getTable().getMethods(), methodName);
        c = c.getInhClass();
        while (c != null && method == null) {
            method = findMethod(c.getTable().getMethods(), methodName);
            c = c.getInhClass();
        }
        return method.getMethod().getType();
    }
    public String getIdentClass(String ident) {
        ClassEntry c = this.findClass(this.className);
        if (this.methodName == null) {
            ArrayList <Entry> identList = c.getTable().getTable();
            for (int i = 0; i < identList.size(); ++i) {
                  Entry e = identList.get(i);
                  if (e.getName().equals(ident))
                      return e.getType();
            }
        }
        return null;
    }

    public int getClassSize(String className) {
        for (int i = 0; i < classTable.size(); ++i) {
            ClassEntry c = classTable.get(i);
            if (c.getName().equals(className))
                return c.getSize();
        }
        return -1;
    }

    private int countOccurance(String s) {
        int counter = 0;
        for (int i = 1; i < s.length(); ++i)
            if (s.charAt(i-1) == ')' && s.charAt(i) == ',')
                counter += 1;
        return counter;
    }

    public String makeVTables() {
        String ret = "";

        for (int i = 0; i < classTable.size(); ++i) {
            ClassEntry c = classTable.get(i);
            int size = c.getTable().getMethods().size();
            if ((size == 0 && c.inheritsFrom == null) || i == 0) {
                ret += "\n@." + c.getName() + " = global [0 x i8*] []\n";
                continue;
            }

            ArrayList <ArrayList <String> > overList = new ArrayList <ArrayList <String> > ();
            overList.add(c.overrides);

            ArrayList <String> classNames = new ArrayList <String> ();
            classNames.add(c.getName());
            String vTable = c.makeVTable(overList, classNames);
            if (vTable.length() == 0) {
                ret += "\n@." + c.getName() + " = global [0 x i8*] []\n";
                continue;
            }

            size = countOccurance(vTable);
            ret += "\n@." + c.getName() + " = global [" + size + " x i8*] [" + vTable;
            ret = ret.substring(0, ret.length() -3);
            ret += "]\n";
        }

        return ret;
    }

    public int getMethodOffSet(String methodName, String className) {
        ClassEntry c;
        for (int i = 0; i < this.classTable.size(); ++i) {
            c = this.classTable.get(i);
            if (c.getName().equals(className))
                return c.getMethodOffSet(methodName);
        }

        return -1;
    }

    public int getMethodCounter(String className) {
        ClassEntry c = this.findClass(className);
        return c.getMethodCounter();
    }

    public int getFieldOffSet(String f) {
        ClassEntry c;
        for (int i = 0; i < this.classTable.size(); ++i) {
            c = this.classTable.get(i);
            if (c.getName().equals(this.className))
                return c.getFieldOffSet(f);
        }

        return -1;
    }

    public void printOffSets() {
        for (int i = 0; i < this.classTable.size(); ++i )
            this.classTable.get(i).printOffSets();
    }

    public String getClassName() {
        return this.className;
    }

    public String getMethodName() {
        return this.methodName;
    }

    // public String getOffset() {
        // return this.offset;
    // }

    public void raiseVarCounter(String var, int val) {
        ClassEntry c = this.classTable.get(this.classTable.size() -1);
        // c.raiseVarCounter(val);
        c.addVar(var, val);
    }

    public void raiseMethodCounter(String m) {
        ClassEntry c = this.classTable.get(this.classTable.size() -1);
        // c.raiseMethodCounter(val);
        c.addMethod(m);
    }

    // public void addString(String s, int flag) {
    //     ClassEntry c = this.classTable.get(this.classTable.size() -1);
    //     if (flag == 1)
    //       this.offset += s + ": " + c.getMethodCounter() + "\n";
    //     else
    //       this.offset += s + ": " + c.getVarCounter() + "\n";
    // }

    public void addExtendMethod(String methodName) {
        ClassEntry subC = this.classTable.get(this.classTable.size() -1);
        ClassEntry superC = subC.getInhClass();

        while (superC != null) {
            Table t = superC.getTable();
            ArrayList <MethodEntry> methods = t.getMethods();
            for (int i = 0; i < methods.size(); ++i)
                if (methods.get(i).getMethod().getName().equals(methodName)) {
                    subC.overrides.add(methodName);
                    return;
                }
            superC = superC.getInhClass();
        }
        // this.addString(subC.getName() + "." + methodName, 1);
        subC.addMethod(methodName);
    }

    public void enterClass(String name) {
        this.className = name;
    }

    public void enterMethod(String name) {
        this.methodName = name;
    }

    public void exitMethod() {
        this.methodName = null;
    }

    private boolean insertClass(Entry e) {

        for (int i = 0; i < this.classTable.size(); ++i)
            if (this.classTable.get(i).getName() == e.getName())
                return false;

        ClassEntry cEntry = new ClassEntry ();
        // cEntry.setCounters();
        cEntry.setType(e.getType());
        cEntry.setName(e.getName());
        this.classTable.add(cEntry);
        return true;

    }

    private boolean insertMethod(Entry e) {

        int classNum = this.classTable.size() -1;

        Table t = this.classTable.get(classNum).getTable();

        ArrayList <MethodEntry> methods = t.getMethods();
        for (int i = 0; i < methods.size(); ++i)
            if (methods.get(i).getMethod().getName() == e.getName())
                return false;


        MethodEntry mEntry = new MethodEntry();
        Entry e2 = mEntry.getMethod();
        e2.setType(e.getType());
        e2.setName(e.getName());

        methods.add(mEntry);
        return true;

    }

    private boolean insertVarParam(Entry e) {
      int classNum = this.classTable.size() -1;

      Table t = this.classTable.get(classNum).getTable();

      ArrayList <MethodEntry> methods = t.getMethods();
      int methodNum = methods.size() -1;
      MethodEntry method = methods.get(methodNum);

      ArrayList <Entry> param = method.getParam();

      for (int i = 0; i < param.size(); ++i)
          if (param.get(i).getName() == e.getName())
              return false;

      param.add(e);

      return true;

    }


    private boolean insertVar(Entry e) {
        int classNum = this.classTable.size() -1;

        Table t = this.classTable.get(classNum).getTable();

        ArrayList <MethodEntry> methods = t.getMethods();
        if (methods.size() == 0) {
            ArrayList <Entry> varDecl = t.getTable();
            for (int i = 0; i < varDecl.size(); ++i)
                if (varDecl.get(i).getName() == e.getName())
                    return false;

            varDecl.add(e);
            return true;
        }


        int methodNum = methods.size() -1;
        MethodEntry method = methods.get(methodNum);

        ArrayList <Entry> param = method.getParam();

        for (int i = 0; i < param.size(); ++i)
            if (param.get(i).getName() == e.getName())
                return false;

        ArrayList <Entry> table = method.getTable();

        for (int i = 0; i < table.size(); ++i)
            if (table.get(i).getName() == e.getName())
                return false;

        table.add(e);

        return true;
    }

    public boolean insert(Entry e, String superName) {
        ClassEntry cEntry = new ClassEntry ();

        for (int i = 0; i < this.classTable.size(); ++i) {
            ClassEntry c = this.classTable.get(i);
            if (c.getName() == e.getName())
                return false;
            if (c.getName() == superName) {
                cEntry.setInhClass(c);
                // cEntry.setCounters(c.getVarCounter(), c.getMethodCounter());
                cEntry.setFieldOffSet(c.getFieldOffSet());
                cEntry.setMethodCounter(c.getMethodCounter());
            }
        }

        cEntry.setType(e.getType());
        cEntry.setName(e.getName());
        this.classTable.add(cEntry);
        return true;

    }

    public boolean insert(Entry e, int flag) {
        switch (flag) {
            /* Class */
            case 0:
                return insertClass(e);
            /* Method */
            case 1:
                // System.out.println("Method");
                return insertMethod(e);
            /* Param */
            case 2:
                // System.out.println("Param");
                return insertVarParam(e);
            /* Var */
            case 3:
                return insertVar(e);
            default:
                return false;
        }
    }

    public ArrayList <String> getInhClasses(String cName) {
      // System.out.println(cName);
      // System.out.println(this.findClass(cName));
        ClassEntry c = this.findClass(cName).getInhClass();

        ArrayList <String> classNames = new ArrayList <String> ();

        while (c != null) {
            classNames.add(c.getName());
            c = c.getInhClass();
        }

        return classNames;
    }


    public ArrayList <String> getOverrides(String cName, String mname) {
        ClassEntry c = this.findClass(cName).getInhClass();

        ArrayList <String> classNames = new ArrayList <String> ();
        while (c != null) {
            ArrayList <MethodEntry> methods = c.getTable().getMethods();
            for (int i = 0; i < methods.size(); ++i)
                if (!methods.get(i).getMethod().getName().equals(mname)) {
                    classNames.add(c.getName());
                    break;
                }
            c = c.getInhClass();
        }

        return classNames;
    }

    private boolean paramCompare(ArrayList <Entry> p1, ArrayList <Entry> p2) {
        if (p1.size() != p2.size())
            return false;

        for (int i = 0; i < p1.size(); ++i) {
            Entry e1 = p1.get(i);
            Entry e2 = p2.get(i);
            if (e1.getType() != e2.getType())
                return false;
        }
        return true;
    }

    private boolean methodCompare(MethodEntry m1, MethodEntry m2) {
        Entry method1 = m1.getMethod();
        Entry method2 = m2.getMethod();
        if (method1.getName() == method2.getName()) {
            if (method1.getType() == method2.getType())
                return paramCompare(m1.getParam(), m2.getParam());
            else
                return false;
        }

        return true;
    }

    private boolean checkMethods(ArrayList <MethodEntry> subMethods,
                                  ArrayList <MethodEntry> superMethods) {

        for (int i = 0; i < subMethods.size(); ++i) {
            MethodEntry subMethod = subMethods.get(i);
            for (int j = 0; j < superMethods.size(); ++j) {
                MethodEntry superMethod = superMethods.get(j);
                if (!methodCompare(subMethod, superMethod))
                    return false;
            }
        }
        return true;

    }

    private boolean isClassObject(String type) {
        if (type == "int" || type == "boolean" || type == "int[]" || type == "String[]")
            return false;
        return true;
    }

    private boolean searchClass(String type) {
        for (int i = 0; i < this.classTable.size(); ++i) {
            if (this.classTable.get(i).getName() == type)
                return true;
        }
        return false;
    }

    private String checkObjects(ArrayList <Entry> objects) {
        for (int i = 0; i < objects.size(); ++i) {
            String type = objects.get(i).getType();
            if (!isClassObject(type) )
                continue;
            if (!searchClass(type))
                return type;
        }

        return null;
    }

    public String checkObjects() {
        for (int i = 0; i < this.classTable.size(); ++i) {
            Table t = this.classTable.get(i).getTable();
            ArrayList <Entry> objects = t.getTable();
            String errorType = checkObjects(objects);
            if (errorType != null)
                return errorType;

            ArrayList <MethodEntry> methods = t.getMethods();
            for (int j = 0; j < methods.size(); ++j) {
                MethodEntry method = methods.get(j);

                objects = method.getTable();
                errorType = checkObjects(objects);
                if (errorType != null)
                    return errorType;

                objects = method.getParam();
                errorType = checkObjects(objects);
                if (errorType != null)
                    return errorType;

            }


        }

        return null;
    }

    public boolean checkOverload() {
        int subClassNum = this.classTable.size() -1;
        ClassEntry subClass = this.classTable.get(subClassNum);
        ArrayList <MethodEntry> subMethods = subClass.getTable().getMethods();

        ClassEntry superClass = subClass.getInhClass();
        while (superClass != null) {
            ArrayList <MethodEntry> superMethods = superClass.getTable().getMethods();
            if (!checkMethods(subMethods, superMethods))
                return false;
            superClass = superClass.getInhClass();
        }

        return true;
    }

    private String findSuper(String name) {
        for (int i = 0; i < this.classTable.size(); ++i)
            if (this.classTable.get(i).getName() == name)
                return name;
        return null;
    }

    public boolean parseInheritance(String superC, String subC) {
      for (int i = 0; i < this.classTable.size(); ++i) {
          ClassEntry c = this.classTable.get(i);
          if (c.getName().equals(superC))
            return true;
      }
      return false;
    }

    public ClassEntry findClass(String name) {
        for (int i = 0; i < this.classTable.size(); ++i) {
            ClassEntry c = this.classTable.get(i);
            if (c.getName().equals(name))
                return c;
        }
        return null;

    }


    private MethodEntry findMethod(ArrayList <MethodEntry> methods, String name) {
        for (int i = 0; i < methods.size(); ++i) {
            MethodEntry method = methods.get(i);
            if (method.getMethod().getName().equals(name))
                return method;
        }
        return null;
    }

    private String findIdent(ArrayList <Entry> table, String name) {
        for (int i = 0; i < table.size(); ++i) {
            Entry e = table.get(i);
            if (e.getName().equals(name))
                return e.getType();
        }
        return null;
    }

    private String findType(String name) {
        if (name.equals("this"))
            return this.className;

        ClassEntry c = findClass(this.className);
        String type;

        Table t = c.getTable();
        if (this.methodName != null) {
          MethodEntry method = findMethod(t.getMethods(), this.methodName);
          type = findIdent(method.getParam(), name);
          if (type != null)
              return type;
          type = findIdent(method.getTable(), name);
          if (type != null)
              return type;
        }

        while (c != null) {
            t = c.getTable();
            type = findIdent(t.getTable(), name);
            if (type != null)
                return type;
            c = c.getInhClass();
        }

        return null;
    }

    public ArrayList <Entry> getMethodParam(String className, String methodName) {
        ClassEntry c;
        if (className != "this")
            c = findClass(className);
        else
            c = findClass(this.className);

        while (c != null) {
            ArrayList <MethodEntry> methods = c.getTable().getMethods();
            for (int i = 0; i < methods.size(); ++i) {
                MethodEntry method = methods.get(i);
                if (method.getMethod().getName() == methodName)
                    return method.getParam();
            }
            c = c.getInhClass();
        }
        return null;

    }

    public String getMethodType(String className, String methodName) {
        ClassEntry c;

        if (className != "this")
            c = findClass(className);
        else
            c = findClass(this.className);
        while (c != null) {
            ArrayList <MethodEntry> methods = c.getTable().getMethods();
            for (int i = 0; i < methods.size(); ++i) {
                MethodEntry method = methods.get(i);
                if (method.getMethod().getName() == methodName)
                    return method.getMethod().getType();
            }
            c = c.getInhClass();
        }
        return null;
    }

    public String lookup(String name, int flag) {
      switch (flag) {
          /* Class */
          case 0:
              return findSuper(name);
          case 1:
              return findType(name);
          default:
              return null;
      }
    }
}
