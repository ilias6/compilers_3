import syntaxtree.*;
import visitor.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Arrays;


class LLVMVisitor extends GJDepthFirst<String, Boolean>{

    SymbolTable table = null;
    long regCounter = 0;
    long labelCounter = 0;
    HashMap <String, String> nameMap = new HashMap <String, String> ();
    HashMap <String, String> regMap = new HashMap <String, String> ();
    HashMap <String, String> typeMap = new HashMap <String, String> ();
    String outPut = "";

    public LLVMVisitor(SymbolTable t) {
        this.table = t;
    }

    /**
     * f0 -> MainClass()
     * f1 -> ( TypeDeclaration() )*
     * f2 -> <EOF>
     */
    @Override
    public String visit(Goal n, Boolean argu) throws Exception {
       this.outPut += "declare i8* @calloc(i32, i32)\n";
       this.outPut += "declare i32 @printf(i8*, ...)\n";
       this.outPut += "declare void @exit(i32)\n";
       this.outPut += "\n";
       this.outPut += "@_cint = constant [4 x i8] c\"%d\\0a\\00\"\n";
       this.outPut += "@_cOOB = constant [15 x i8] c\"Out of bounds\\0a\\00\"\n";
       this.outPut += "@_cNSZ = constant [15 x i8] c\"Negative size\\0a\\00\"\n\n";
       this.outPut += "define void @print_int(i32 %i) {\n";
       this.outPut += "\t%_str = bitcast [4 x i8]* @_cint to i8*\n";
       this.outPut += "\tcall i32 (i8*, ...) @printf(i8* %_str, i32 %i)\n";
       this.outPut += "\tret void\n";
       this.outPut += "}\n\n";
       this.outPut += "define void @throw_oob() {\n";
       this.outPut += "\t%_str = bitcast [15 x i8]* @_cOOB to i8*\n";
       this.outPut += "\tcall i32 (i8*, ...) @printf(i8* %_str)\n";
       this.outPut += "\tcall void @exit(i32 1)\n";
       this.outPut += "\tret void\n";
       this.outPut += "}\n\n";
       this.outPut += "define void @throw_nsz() {\n";
       this.outPut += "\t%_str = bitcast [15 x i8]* @_cNSZ to i8*\n";
       this.outPut += "\tcall i32 (i8*, ...) @printf(i8* %_str)\n";
       this.outPut += "\tcall void @exit(i32 1)\n";
       this.outPut += "\tret void\n";
       this.outPut += "}\n\n";


       this.outPut += this.table.makeVTables() + "\n\n";

       n.f0.accept(this, false);
       for (Node node: n.f1.nodes)
          node.accept(this, false);

       n.f2.accept(this, false);
       return this.outPut;
    }

    /**
     * f0 -> "class"
     * f1 -> Identifier()
     * f2 -> "{"
     * f3 -> "public"
     * f4 -> "static"
     * f5 -> "void"
     * f6 -> "main"
     * f7 -> "("
     * f8 -> "String"
     * f9 -> "["
     * f10 -> "]"
     * f11 -> Identifier()
     * f12 -> ")"
     * f13 -> "{"
     * f14 -> ( VarDeclaration() )*
     * f15 -> ( Statement() )*
     * f16 -> "}"
     * f17 -> "}"
     */
    @Override
    public String visit(MainClass n, Boolean argu) throws Exception {

        String classname = n.f1.accept(this, true);
        this.table.enterClass(classname);

        String argsName = n.f11.accept(this, true);
        this.outPut += "define i32 @main (i8** %" + argsName + ") {";
        for (Node node: n.f14.nodes)
            node.accept(this, argu);


        for (Node node: n.f15.nodes)
            node.accept(this, argu);


        this.outPut += "\n\n\tret i32 0";
        this.outPut += "\n}\n\n";
        return null;
    }

    /**
     * f0 -> "class"
     * f1 -> Identifier()
     * f2 -> "{"
     * f3 -> ( VarDeclaration() )*
     * f4 -> ( MethodDeclaration() )*
     * f5 -> "}"
     */
    @Override
    public String visit(ClassDeclaration n, Boolean argu) throws Exception {

        String classname = n.f1.accept(this, true);
        this.table.enterClass(classname);

        for (Node node: n.f4.nodes)
            node.accept(this, argu);

        return null;
    }

    /**
     * f0 -> "class"
     * f1 -> Identifier()
     * f2 -> "extends"
     * f3 -> Identifier()
     * f4 -> "{"
     * f5 -> ( VarDeclaration() )*
     * f6 -> ( MethodDeclaration() )*
     * f7 -> "}"
     */
    @Override
    public String visit(ClassExtendsDeclaration n, Boolean argu) throws Exception {

        String classname = n.f1.accept(this, true);
        this.table.enterClass(classname);

        for (Node node: n.f6.nodes)
            node.accept(this, argu);

        return null;
    }

    /**
     * f0 -> "public"
     * f1 -> Type()
     * f2 -> Identifier()
     * f3 -> "("
     * f4 -> ( FormalParameterList() )?
     * f5 -> ")"
     * f6 -> "{"
     * f7 -> ( VarDeclaration() )*
     * f8 -> ( Statement() )*
     * f9 -> "return"
     * f10 -> Expression()
     * f11 -> ";"
     * f12 -> "}"
     */
    @Override
    public String visit(MethodDeclaration n, Boolean argu) throws Exception {
        this.nameMap = new HashMap <String, String> ();
        this.regMap = new HashMap <String, String> ();
        this.typeMap = new HashMap <String, String> ();
        this.regCounter = 0;
        this.labelCounter = 0;

        String myType = n.f1.accept(this, true);
        String myName = n.f2.accept(this, true);
        this.table.enterMethod(myName);

        this.outPut += "\ndefine";
        if (myType == "int")
          this.outPut += " i32";
        else if (myType == "boolean")
          this.outPut += " i1";
        else if (myType == "int[]")
          this.outPut += " i32*";
        else
          this.outPut += " i8*";

        this.outPut += " @" + this.table.getClassName() + "." + myName;
        this.outPut += "(i8* %this";
        this.nameMap.put("this", "%this");
        this.typeMap.put("%this", "i8*");

        String s1 = n.f4.accept(this, argu);
        if (s1 != null)
            this.outPut += s1;
        this.outPut += ") {";
        if (s1 != null) {
          String[] params = s1.split(", ");
          String[] parts = null;
          String[] name = null;
          params = Arrays.copyOfRange(params, 1, params.length);
          for (String str: params) {
              /* parts[0] : type
                 parts[1] : name */
                parts = str.split(" ");
                name = parts[1].split("%");
                // if ((!parts[0].equals("i8*")) && (!parts[0].equals("i32*"))) {
                    this.outPut += "\n\t%__" + name[1] + " = alloca " + parts[0];
                    this.outPut += "\n\tstore " + parts[0] + " %" + name[1] + ", " + parts[0] + "* %__" + name[1];
                    this.nameMap.put(name[1], "%__" + name[1]);
                    this.typeMap.put("%__" + name[1], parts[0]);
                // }
                // else {
                    // this.nameMap.put(name[1], "%" + name[1]);
                    // this.typeMap.put("%" + name[1], parts[0]);
                // }
          }
        }

        for (Node node: n.f7.nodes)
            node.accept(this, argu);

        for (Node node: n.f8.nodes)
            node.accept(this, argu);

        String retReg = n.f10.accept(this, argu);

        this.outPut += "\n\tret";
        if (myType == "int")
          this.outPut += " i32 ";
        else if (myType == "boolean")
          this.outPut += " i1 ";
        else if (myType == "int[]")
          this.outPut += " i32* ";
        else
          this.outPut += " i8* ";

        this.outPut += retReg;
        this.outPut += "\n}\n";

        this.table.exitMethod();

        return null;
    }

    /**
     * f0 -> FormalParameter()
     * f1 -> FormalParameterTail()
     */
     @Override

    public String visit(FormalParameterList n, Boolean argu) throws Exception {
        String ret = n.f0.accept(this, argu);
        if (ret == null)
          return "";
        return n.f0.accept(this, argu) + n.f1.accept(this, argu);
    }

    /**
     * f0 -> Type()
     * f1 -> Identifier()
     */
     @Override

    public String visit(FormalParameter n, Boolean argu) throws Exception {
        String outPut = "";
        String type = n.f0.accept(this, true);
        String name = n.f1.accept(this, true);

        if (type == "int")
            outPut += ", i32 %" + name;
        else if (type == "boolean")
            outPut += ", i1 %" + name;
        else if (type == "int[]")
            outPut += ", i32* %" + name;
        else
            outPut += ", i8* %" + name;

        return outPut;
    }

    /**
     * f0 -> ( FormalParameterTerm() )*
     */
     @Override

    public String visit(FormalParameterTail n, Boolean argu) throws Exception {
        String ret = "";
        for (Node node: n.f0.nodes)
            ret += node.accept(this, argu);

        if (ret == null)
            return "";

        return ret;
    }

    /**
     * f0 -> ","
     * f1 -> FormalParameter()
     */
     @Override

    public String visit(FormalParameterTerm n, Boolean argu) throws Exception {
       return n.f1.accept(this, argu);
    }

    /**
     * f0 -> Block()
     *       | AssignmentStatement()
     *       | ArrayAssignmentStatement()
     *       | IfStatement()
     *       | WhileStatement()
     *       | PrintStatement()
     */
     @Override
    public String visit(Statement n, Boolean argu) throws Exception {
       return n.f0.accept(this, argu);
    }

    /**
     * f0 -> Identifier()
     * f1 -> "="
     * f2 -> Expression()
     * f3 -> ";"
     */
    @Override
    public String visit(AssignmentStatement n, Boolean argu) throws Exception {
        String reg1 = n.f0.accept(this, false);
        // String reg1 = this.nameMap.get(ident);
        String memReg = this.regMap.get(reg1);
        if (memReg != null)
            reg1 = memReg;

        String reg2 = n.f2.accept(this, argu);
        this.outPut += "\n\t";

        String type = this.typeMap.get(reg1);

        if (reg2.equals("this"))
            reg2 = "%this";

        if (type.charAt(0) != 'i')
            type = "i8*";

        this.outPut += "\n\tstore " + type + " " + reg2 + ", " + type + "* " + reg1;


        return null;
    }

    /**
     * f0 -> Identifier()
     * f1 -> "["
     * f2 -> Expression()
     * f3 -> "]"
     * f4 -> "="
     * f5 -> Expression()
     * f6 -> ";"
     */
    @Override
    public String visit(ArrayAssignmentStatement n, Boolean argu) throws Exception {
        String reg1 = n.f0.accept(this, false);
        String reg2 = n.f2.accept(this, argu);
        String reg3 = n.f5.accept(this, argu);

        this.outPut += "\n\t";
        String size = "%_" + this.regCounter;
        this.outPut += size + " = load i32, i32* " + reg1;
        this.regCounter += 1;

        this.outPut += "\n\t%_" + this.regCounter + " = icmp slt i32 " + reg2 + ", " + size;
        String cond1 = "%_" + this.regCounter;
        this.regCounter += 1;

        this.outPut += "\n\t%_" + this.regCounter + " = icmp slt i32 -1, " + reg2;
        String cond2 = "%_" + this.regCounter;
        this.regCounter += 1;

        this.outPut += "\n\t%_" + this.regCounter + " = xor i1 " + cond1 + ", " + cond2;
        String cond = "%_" + this.regCounter;
        this.regCounter += 1;

        this.outPut += "\n\tbr i1 " + cond + ", label %indexing_error_" + this.labelCounter;
        this.outPut += ", label %indexing_ok_" + this.labelCounter;

        this.outPut += "\n\tindexing_error_" + this.labelCounter + ":";
        this.outPut += "\n\tcall void @throw_oob()";
        this.outPut += "\n\tbr label %indexing_ok_" + this.labelCounter;

        this.outPut += "\n\tindexing_ok_" + this.labelCounter + ":";
        this.labelCounter += 1;

        String indexReg = "%_" + this.regCounter;
        this.regCounter += 1;

        this.outPut += "\n\t" + indexReg + " = add i32 " + reg2 + ", 1";

        this.outPut += "\n\t";
        this.outPut += "%_" + this.regCounter + " = getelementptr i32, i32* " + reg1 + ", i32 " + indexReg;

        this.outPut += "\n\t";

        this.outPut += "store i32 " + reg3 + ", i32* %_" + this.regCounter;

        this.regCounter += 1;

        return null;
    }

    /**
     * f0 -> "if"
     * f1 -> "("
     * f2 -> Expression()
     * f3 -> ")"
     * f4 -> Statement()
     * f5 -> "else"
     * f6 -> Statement()
     */
    @Override
    public String visit(IfStatement n, Boolean argu) throws Exception {
        String reg = n.f2.accept(this, argu);

        long label = this.labelCounter;

        this.outPut += "\n";
        this.outPut += "\n\t";
        this.outPut += "br i1 " + reg + ", label %if_then_" + label;
        this.outPut += ", label %if_else_" + label;

        this.labelCounter += 1;

        this.outPut += "\n";
        this.outPut += "\n\tif_then_" + label + ":";
        n.f4.accept(this, argu);
        this.outPut += "\n\tbr label %if_end_" + label;

        this.outPut += "\n";
        this.outPut += "\n\tif_else_" + label + ":";
        n.f6.accept(this, argu);
        this.outPut += "\n";
        this.outPut += "\n\tbr label %if_end_" + label;

        this.outPut += "\n";
        this.outPut += "\n\tif_end_" + label + ":";

        return null;
    }

    /**
     * f0 -> "while"
     * f1 -> "("
     * f2 -> Expression()
     * f3 -> ")"
     * f4 -> Statement()
     */
    @Override
    public String visit(WhileStatement n, Boolean argu) throws Exception {

        long label = this.labelCounter;
        this.labelCounter += 1;

        this.outPut += "\n";
        this.outPut += "\n\t";
        this.outPut += "br label %while_" + label;
        this.outPut += "\n\twhile_" + label + ":";
        String reg = n.f2.accept(this, argu);

        this.outPut += "\n\tbr i1 " + reg + ", label %continue_" + label;
        this.outPut += ", label %while_end_" + label;
        this.outPut += "\n\tcontinue_" + label + ":";
        n.f4.accept(this, argu);
        this.outPut += "\n\t";
        this.outPut += "br label %while_" + label;
        this.outPut += "\n";
        this.outPut += "\n\twhile_end_" + label + ":";

        return null;
    }

    /**
     * f0 -> "System.out.println"
     * f1 -> "("
     * f2 -> Expression()
     * f3 -> ")"
     * f4 -> ";"
     */
    @Override
    public String visit(PrintStatement n, Boolean argu) throws Exception {
        String reg = n.f2.accept(this, argu);
        this.outPut += "\n\tcall void (i32) @print_int(i32 " + reg + ")";

        return null;
    }

    /**
     * f0 -> AndExpression()
     *       | CompareExpression()
     *       | PlusExpression()
     *       | MinusExpression()
     *       | TimesExpression()
     *       | ArrayLookup()
     *       | ArrayLength()
     *       | MessageSend()
     *       | PrimaryExpression()
     */
    @Override
    public String visit(Expression n, Boolean argu) throws Exception {
        return n.f0.accept(this, argu);
    }

    /**
     * f0 -> PrimaryExpression()
     * f1 -> "&&"
     * f2 -> PrimaryExpression()
     */
    @Override
    public String visit(AndExpression n, Boolean argu) throws Exception {
       String reg1 = n.f0.accept(this, argu);
       String type = this.typeMap.get(reg1);

       String label1 = "exp_and_" + this.labelCounter;
       this.labelCounter += 1;
       String label2 = "exp_and_" + this.labelCounter;
       this.labelCounter += 1;
       String label3 = "exp_and_" + this.labelCounter;
       this.labelCounter += 1;
       String label4 = "exp_and_" + this.labelCounter;
       this.labelCounter += 1;

       this.outPut += "\n";
       this.outPut += "\n\tbr i1 " + reg1 + ", label %" + label2;
       this.outPut += ", label %" + label1;
       this.outPut += "\n";


       this.outPut += "\n\t" + label1 + ":";
       this.outPut += "\n\tbr label %" + label4;
       this.outPut += "\n";


       this.outPut += "\n\t" + label2 + ":";
       String reg2 = n.f2.accept(this, argu);

       this.outPut += "\n\tbr label %" + label3;
       this.outPut += "\n";

       String retReg = "%_" + this.regCounter;
       this.regCounter += 1;

       this.outPut += "\n\t" + label3 + ":";
       this.outPut += "\n\tbr label %" + label4;

       this.outPut += "\n\t" + label4 + ":";

       this.outPut += "\n\t" + retReg + " = phi i1 [ " + reg1 + ", %" + label1 + " ]";
       this.outPut += ", [ " + reg2 + ", %" + label3 + " ]";
       this.outPut += "\n";


       this.typeMap.put(retReg, "i1");
       return retReg;
    }

    /**
     * f0 -> PrimaryExpression()
     * f1 -> "<"
     * f2 -> PrimaryExpression()
     */
    @Override
    public String visit(CompareExpression n, Boolean argu) throws Exception {
      String reg1 = n.f0.accept(this, argu);
      String reg2 = n.f2.accept(this, argu);

      this.outPut += "\n";
      this.outPut += "\n\t";
      this.outPut += "%_" + this.regCounter + " = icmp";
      String retReg = "%_" + this.regCounter;
      this.outPut += " slt i32 " + reg1 + ", " + reg2;
      this.regCounter += 1;

      this.typeMap.put(retReg, "i1");
      return retReg;
    }

    /**
     * f0 -> PrimaryExpression()
     * f1 -> "+"
     * f2 -> PrimaryExpression()
     */
    @Override
    public String visit(PlusExpression n, Boolean argu) throws Exception {
      String reg1 = n.f0.accept(this, argu);
      String reg2 = n.f2.accept(this, argu);

      this.outPut += "\n";
      this.outPut += "\n\t";
      this.outPut += "%_" + this.regCounter + " = add i32" + " " + reg1 + ", " + reg2;

      this.regCounter += 1;

      String retReg = "%_" + (this.regCounter -1);
      this.typeMap.put(retReg, "i32");
      return retReg;
    }

    /**
     * f0 -> PrimaryExpression()
     * f1 -> "-"
     * f2 -> PrimaryExpression()
     */
    @Override
    public String visit(MinusExpression n, Boolean argu) throws Exception {
      String reg1 = n.f0.accept(this, argu);
      String reg2 = n.f2.accept(this, argu);

      this.outPut += "\n";
      this.outPut += "\n\t";
      this.outPut += "%_" + this.regCounter + " = sub i32" + " " + reg1 + ", " + reg2;

      this.regCounter += 1;

      String retReg = "%_" + (this.regCounter -1);
      this.typeMap.put(retReg, "i32");
      return retReg;
    }

    /**
     * f0 -> PrimaryExpression()
     * f1 -> "*"
     * f2 -> PrimaryExpression()
     */
    @Override
    public String visit(TimesExpression n, Boolean argu) throws Exception {
      String reg1 = n.f0.accept(this, argu);
      String reg2 = n.f2.accept(this, argu);

      String type = this.typeMap.get(reg1);

      this.outPut += "\n";
      this.outPut += "\n\t";
      this.outPut += "%_" + this.regCounter + " = mul i32" + " " + reg1 + ", " + reg2;

      this.regCounter += 1;

      String retReg = "%_" + (this.regCounter -1);
      this.typeMap.put(retReg, "i32");
      return retReg;
    }

    /**
     * f0 -> PrimaryExpression()
     * f1 -> "["
     * f2 -> PrimaryExpression()
     * f3 -> "]"
     */
    @Override
    public String visit(ArrayLookup n, Boolean argu) throws Exception {
      String reg1 = n.f0.accept(this, argu);
      String reg2 = n.f2.accept(this, argu);

      this.outPut += "\n";
      this.outPut += "\n\t";
      String size = "%_" + this.regCounter;
      this.outPut += size + " = load i32, i32* " + reg1;
      this.regCounter += 1;

      this.outPut += "\n\t%_" + this.regCounter + " = icmp slt i32 " + reg2 + ", " + size;
      String cond1 = "%_" + this.regCounter;
      this.regCounter += 1;

      this.outPut += "\n\t%_" + this.regCounter + " = icmp slt i32 -1, " + reg2;
      String cond2 = "%_" + this.regCounter;
      this.regCounter += 1;

      this.outPut += "\n\t%_" + this.regCounter + " = xor i1 " + cond1 + ", " + cond2;
      String cond = "%_" + this.regCounter;
      this.regCounter += 1;

      this.outPut += "\n\tbr i1 " + cond + ", label %indexing_error_" + this.labelCounter;
      this.outPut += ", label %indexing_ok_" + this.labelCounter;

      this.outPut += "\n\tindexing_error_" + this.labelCounter + ":";
      this.outPut += "\n\tcall void @throw_oob()";
      this.outPut += "\n\tbr label %indexing_ok_" + this.labelCounter;

      this.outPut += "\n\tindexing_ok_" + this.labelCounter + ":";
      this.labelCounter += 1;


      String indexReg = "%_" + this.regCounter;
      this.regCounter += 1;

      this.outPut += "\n\t" + indexReg + " = add i32 " + reg2 + ", 1";
      this.outPut += "\n\t";
      this.outPut += "%_" + this.regCounter + " = getelementptr i32, i32* " + reg1 + ", i32 " + indexReg;
      this.regCounter += 1;

      this.outPut += "\n\t";
      String retReg = "%_" + this.regCounter;
      this.typeMap.put(retReg, "i32");
      this.outPut += retReg + " = load i32, i32* %_" + (this.regCounter -1);
      this.regCounter += 1;

      return retReg;
    }

    /**
     * f0 -> PrimaryExpression()
     * f1 -> "."
     * f2 -> "length"
     */

    @Override
    public String visit(ArrayLength n, Boolean argu) throws Exception {
      String reg = n.f0.accept(this, argu);

      this.outPut += "\n";
      this.outPut += "\n\t";
      String size = "%_" + this.regCounter;
      this.outPut += size + " = load i32, i32* " + reg;
      this.regCounter += 1;

      this.typeMap.put(size, "132");

      return size;
    }

    /**
     * f0 -> PrimaryExpression()
     * f1 -> "."
     * f2 -> Identifier()
     * f3 -> "("
     * f4 -> ( ExpressionList() )?
     * f5 -> ")"
     */

    @Override
    public String visit(MessageSend n, Boolean argu) throws Exception {
      String clName = n.f0.accept(this, true);
      String methodName = n.f2.accept(this, true);
      String className = null;

      this.outPut += "\n";
      if (clName.charAt(0) == '%') {
          className = this.typeMap.get(clName);
      }
      else if (clName.equals("this")) {
            className = this.table.lookup(clName, 1);
            clName = "%this";
      }
      else {
          className = this.table.lookup(clName, 1);
          String temp = this.nameMap.get(clName);
          clName = "%_" + this.regCounter;
          this.regCounter += 1;
          this.outPut += "\n\t";
          this.outPut += clName + " = load i8*, i8** " + temp;
          this.typeMap.put(clName, className);
      }
      int arraySize = this.table.getMethodCounter(className);
      int index = this.table.getMethodOffSet(methodName, className);

      // this.outPut += "\n\t%_" + this.regCounter + " = getelementptr ";
      // this.outPut += "[" + arraySize + " x i8*]," + " [" + arraySize + " x i8*]*";
      // this.outPut += " @."+className + ", i32 0, i32 " + index;
      // this.regCounter += 1;

      String ptr = "%_" + this.regCounter;
      this.regCounter += 1;

      this.outPut += "\n\t" + ptr + " = bitcast i8* " + clName + " to i8***";
      String vTable = "%_" + this.regCounter;

      this.regCounter += 1;

      this.outPut += "\n\t" + vTable + " = load i8**, i8*** " + ptr;
      String methodReg = "%_"  + this.regCounter;
      this.outPut += "\n\t" + methodReg + " = getelementptr i8*, i8** " + vTable + ", i32 " + index;
      this.regCounter += 1;

      this.outPut += "\n\t%_" + this.regCounter + " = load i8*, i8** " + methodReg;
      this.regCounter += 1;



      String retType = this.table.findMethodRetType(className, methodName);
      this.outPut += "\n\t%_" + this.regCounter + " = bitcast i8* %_" + (this.regCounter -1);
      this.outPut += " to ";
      switch (retType) {
          case "int":
            this.outPut += "i32 ";
            retType = "i32";
            break;
          case "boolean":
            this.outPut += "i1 ";
            retType = "i1";
            break;
          case "int[]":
            this.outPut += "i32* ";
            retType = "i32*";
            break;
          default:
            this.outPut += "i8* ";
            // retType = "i8*";
      }
      this.regCounter += 1;

      this.outPut += "(";
      this.outPut += this.table.printParamTypes(className, methodName);
      this.outPut += ")*";

      String t = retType;
      if (retType.charAt(0) != 'i')
          retType = "i8*";

      String call = "\n\t%_" + this.regCounter + " = call " + retType;
      String retReg = "%_" + this.regCounter;
      call += " %_" + (this.regCounter -1);
      this.regCounter += 1;

      call += "(i8* " + clName;
      if (n.f4.present())
          call += n.f4.accept(this, argu);
      else
          call += ")";

      this.outPut += call;

      this.typeMap.put(retReg, t);


      return retReg;
    }

    /**
     * f0 -> Expression()
     * f1 -> ExpressionTail()
     */
    @Override
    public String visit(ExpressionList n, Boolean argu) throws Exception {
        String reg = n.f0.accept(this, argu);
        if (reg.equals("this"))
            reg = "%this";
        String type = this.typeMap.get(reg);
        String ret = ", ";

        if (type.charAt(0) != 'i')
            type = "i8*";

        ret += type + " " + reg;

        ret += n.f1.accept(this, argu);
        ret += ")";
        return ret;
    }

    /**
     * f0 -> ( ExpressionTerm() )*
     */
    @Override
    public String visit(ExpressionTail n, Boolean argu) throws Exception {
      String ret = "";
      for (Node node: n.f0.nodes)
          ret += node.accept(this, argu);
       return ret;
    }

    /**
     * f0 -> ","
     * f1 -> Expression()
     */
    @Override
    public String visit(ExpressionTerm n, Boolean argu) throws Exception {
        String reg = n.f1.accept(this, argu);
        String type = this.typeMap.get(reg);
        if (type.charAt(0) != 'i')
            type = "i8*";

        return  ", " + type + " " + reg;
    }


    /**
     * f0 -> IntegerLiteral()
     *       | TrueLiteral()
     *       | FalseLiteral()
     *       | Identifier()
     *       | ThisExpression()
     *       | ArrayAllocationExpression()
     *       | AllocationExpression()
     *       | NotExpression()
     *       | BracketExpression()
     */
    @Override
    public String visit(PrimaryExpression n, Boolean argu) throws Exception {
       return n.f0.accept(this, argu);
    }

    /**
     * f0 -> "new"
     * f1 -> "int"
     * f2 -> "["
     * f3 -> Expression()
     * f4 -> "]"
     */
    @Override
    public String visit(ArrayAllocationExpression n, Boolean argu) throws Exception {
       String reg = n.f3.accept(this, argu);

       this.outPut += "\n";
       this.outPut += "\n\t";
       this.outPut += "%_" + this.regCounter + " = add i32 1, " + reg;
       String size = "%_" + this.regCounter;
       this.regCounter += 1;

       long label = this.labelCounter;
       this.outPut += "\n\t%_" + this.regCounter + " = icmp sge i32 " + size + ", 1";
       this.outPut += "\n\tbr i1 %_" + this.regCounter + ", label %nsz_ok_" + label;
       this.outPut += ", label %nsz_err_" + label;
       this.regCounter += 1;

       this.outPut += "\n\tnsz_err_" + label + ":";
       this.outPut += "\n\tcall void @throw_nsz()";
       this.outPut += "\n\tbr label %nsz_ok_" + label;
       this.outPut += "\n\tnsz_ok_" + label + ":";

       this.labelCounter += 1;

       this.outPut += "\n\n\t";
       this.outPut += "%_" + this.regCounter + " = call i8* @calloc(i32 " + size + ", i32 4)";

       this.regCounter += 1;
       this.outPut += "\n\t%_"  + this.regCounter + " = bitcast i8* %_" + (this.regCounter -1);
       this.outPut += " to i32*";

       this.outPut += "\n\tstore i32 " + reg + ", i32* %_" + this.regCounter;
       this.regCounter += 1;


       String retReg = "%_" + (this.regCounter -1);
       this.typeMap.put(retReg, "i32*");
       return retReg;
    }

    /**
     * f0 -> "new"
     * f1 -> Identifier()
     * f2 -> "("
     * f3 -> ")"
     */
    @Override
    public String visit(AllocationExpression n, Boolean argu) throws Exception {
        String className = n.f1.accept(this, true);
        int allocSize = this.table.getClassSize(className);

        this.outPut += "\n";
        this.outPut += "\n\t%_" + this.regCounter + " = add i32 8, " + allocSize;
        String size = "%_" + this.regCounter;
        this.regCounter += 1;

        String objReg = "%_" + this.regCounter;
        this.outPut += "\n\t" + objReg + " = call i8* @calloc(i32 " + size + ", i32 1)";
        this.regCounter += 1;

        this.outPut += "\n\t";
        String objReg2 = "%_" + this.regCounter;
        this.outPut += objReg2 + " = bitcast i8* %_" + (this.regCounter -1);
        this.outPut += " to i8***";
        this.regCounter += 1;

        int arraySize = this.table.getMethodCounter(className);
        String ptrReg = "%_" + this.regCounter;
        this.outPut += "\n\t" + ptrReg + " = getelementptr ";
        this.outPut += "[" + arraySize + " x i8*]," + " [" + arraySize + " x i8*]*";
        this.outPut += " @." + className + ", i32 0, i32 0";
        this.regCounter += 1;

        this.outPut += "\n\tstore i8** " + ptrReg + ", i8*** " + objReg2;

        this.typeMap.put(objReg, className);
        return objReg;
    }

    /**
     * f0 -> "!"
     * f1 -> PrimaryExpression()
     */
    @Override
    public String visit(NotExpression n, Boolean argu) throws Exception {
        String reg = n.f1.accept(this, argu);
        String retReg = "%_" + this.regCounter;

        this.outPut += "\n";
        this.outPut += "\n\t" + retReg + " = xor i1 1, " + reg;
        this.regCounter += 1;

        this.typeMap.put(retReg, "i1");
        return retReg;
    }


    @Override
    public String visit(VarDeclaration n, Boolean argu) throws Exception {
        String myType = n.f0.accept(this, true);
        String myName = n.f1.accept(this, true);

        this.outPut += "\n";
        this.nameMap.put(myName, "%_" + this.regCounter);
        this.outPut += "\n\t";

        if (myType == "int") {
            this.typeMap.put("%_" + this.regCounter, "i32");
            this.outPut += "%_" + this.regCounter + " = alloca i32";
            this.outPut += "\n\tstore i32 0, i32* %_" + this.regCounter;
        }
        else if (myType == "boolean") {
            this.typeMap.put("%_" + this.regCounter, "i1");
            this.outPut += "%_" + this.regCounter + " = alloca i1";
            this.outPut += "\n\tstore i1 0, i1* %_" + this.regCounter;

        }
        else if (myType == "int[]") {
            this.typeMap.put("%_" + this.regCounter, "i32*");
            this.outPut += "%_" + this.regCounter + " = alloca i32*";
        }
        else {
            this.typeMap.put("%_" + this.regCounter, myType);
            this.outPut += "%_" + this.regCounter + " = alloca i8*";
        }

        this.regCounter += 1;

        return null;
    }

    /**
     * f0 -> "("
     * f1 -> Expression()
     * f2 -> ")"
     */
    @Override
    public String visit(BracketExpression n, Boolean argu) throws Exception {
       return n.f1.accept(this, argu);
    }

    @Override
    public String visit(ArrayType n, Boolean argu) {
        return "int[]";
    }
    @Override
    public String visit(BooleanType n, Boolean argu) {
        return "boolean";
    }
    @Override
    public String visit(IntegerType n, Boolean argu) {
        return "int";
    }


    @Override
    public String visit(Identifier n, Boolean argu) throws Exception {
        if (argu)
            return n.f0.toString();

        String ident = n.f0.toString();
        String memReg = this.nameMap.get(ident);

        boolean isField = this.table.isField(ident);
        String type = null;
        String retReg = null;
        if (memReg == null || isField) {
            int offSet = this.table.getFieldOffSet(ident) + 8;
            type = this.table.lookup(ident, 1);
            switch (type) {
              case "int":
                type = "i32";
                break;
              case "boolean":
                type = "i1";
                break;
              case "int[]":
                type = "i32*";
                break;
              default:
                type = "i8*";
            }
            this.outPut += "\n\t";
            String struct_ptr = "%_" + this.regCounter;
            this.outPut += struct_ptr + " = getelementptr i8, i8* %this, ";
            this.outPut += "i32 " + offSet;
            this.regCounter += 1;

            memReg = "%_" + this.regCounter;
            this.outPut += "\n\t" + memReg + " = bitcast i8* " + struct_ptr + " to " + type +"*";
            this.regCounter += 1;

            retReg = "%_" + this.regCounter;
            if (type.charAt(0) != 'i')
                type = "i8*";
            this.outPut += "\n\t"+ retReg + " = load " + type + ", "  + type + "* " + memReg;

            this.nameMap.put(ident, memReg);
            this.typeMap.put(memReg, type);
            this.regMap.put(retReg, memReg);
        }
        else {
          retReg = "%_" + this.regCounter;
          type = this.typeMap.get(memReg);

          if (type.charAt(0) != 'i')
              type = "i8*";
          this.outPut += "\n\t"+ retReg + " = load " + type + ", "  + type + "* " + memReg;
          this.regMap.put(retReg, memReg);
        }
        this.typeMap.put(retReg, type);
        this.regCounter += 1;

        return retReg;

    }

    @Override
    public String visit(IntegerLiteral n, Boolean argu) throws Exception {
            String retReg = "%_" + this.regCounter;
            this.regCounter += 1;

            this.typeMap.put(retReg, "i32");
            this.outPut += "\n\t" + retReg + " = add i32 0, " + n.f0.toString();
            return retReg;
    }

    @Override
    public String visit(TrueLiteral n, Boolean argu) {
      String retReg = "%_" + this.regCounter;
      this.regCounter += 1;

      this.typeMap.put(retReg, "i1");
      this.outPut += "\n\t" + retReg + " = add i1 0, 1";
      return retReg;
    }

    @Override
    public String visit(FalseLiteral n, Boolean argu) {
      String retReg = "%_" + this.regCounter;
      this.regCounter += 1;

      this.typeMap.put(retReg, "i1");
      this.outPut += "\n\t" + retReg + " = add i1 0, 0";
      return retReg;
    }

    @Override
    public String visit(ThisExpression n, Boolean argu) {
            return n.f0.toString();
    }
}
