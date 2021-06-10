import java.util.ArrayList;

class ClassEntry extends Entry {
    ClassEntry inheritsFrom = null;
    Table table = new Table ();
    OffSet offSets = new OffSet ();
    ArrayList <String> overrides = new ArrayList <String> ();
    // int varCounter;
    // int methodCounter;

    public int getSize() {
        return this.offSets.getSize();
    }

    public String makeVTable(ArrayList <ArrayList <String> > overList, ArrayList <String> classNames) {
        if (this.inheritsFrom == null) {
            String outPut = this.offSets.addMethods(overList, classNames, this.table.getMethods(), this.getName());
            return outPut;
        }
        overList.add(this.inheritsFrom.overrides);
        classNames.add(this.inheritsFrom.getName());
        return this.inheritsFrom.makeVTable(overList, classNames) + this.offSets.addMethods(overList, classNames, this.table.getMethods(), this.getName());
    }

    public void insertOverride(String m) {
        this.overrides.add(m);
    }

    public int getFieldOffSet(String f) {
        int offSet = this.offSets.getFieldOffSet(f);
        if (offSet >= 0)
            return offSet;

        ClassEntry c = this.inheritsFrom;
        while (c != null) {
            offSet = c.offSets.getFieldOffSet(f);
            if (offSet >= 0)
                return offSet;
            c = c.inheritsFrom;
        }

        return -1;
    }

    public int getMethodOffSet(String f) {
      int offSet = this.offSets.getMethodOffSet(f);
      if (offSet >= 0)
          return offSet;

      ClassEntry c = this.inheritsFrom;
      while (c != null) {
          offSet = c.offSets.getMethodOffSet(f);
          if (offSet >= 0)
              return offSet;
          c = c.inheritsFrom;
      }

      return -1;
    }

    public void printOffSets() {
        this.offSets.print(this.ident);
    }

    public void setFieldOffSet(int val) {
        this.offSets.setParentOffSet(val);
    }

    public void setMethodCounter(int val) {
        this.offSets.setMethodCounter(val);
    }

    public int getFieldOffSet() {
        return this.offSets.getParentOffSet();
    }

    public int getMethodCounter() {
        return this.offSets.getMethodCounter();
    }

    public void addVar(String var, int val) {
        this.offSets.addField(var, val);
    }

    public void addMethod(String m) {
        this.offSets.addMethod(m);
    }

    public Table getTable() {
        return this.table;
    }

    public ClassEntry getInhClass() {
        return this.inheritsFrom;
    }

    public void setInhClass(ClassEntry e) {
        this.inheritsFrom = e;
    }

    // public int getVarCounter() {
        // return this.varCounter;
    // }

    // public int getMethodCounter() {
        // return this.methodCounter;
    // }

    // public void raiseVarCounter(int val) {
        // this.varCounter += val;
    // }

    // public void raiseMethodCounter(int val) {
        // this.methodCounter += val;
    // }

    // public void setCounters() {
    //     this.varCounter = 0;
    //     this.methodCounter = 0;
    // }
    //
    // public void setCounters(int c1, int c2) {
    //     this.varCounter = c1;
    //     this.methodCounter = c2;
    // }
}
