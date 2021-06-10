import syntaxtree.*;
import visitor.*;

import java.io.FileInputStream;
import java.io.File;
import java.io.FileWriter;
import java.io.FileNotFoundException;
import java.io.IOException;

public class Main {
    public static void main(String[] args) throws Exception {
        if(args.length < 1){
            System.err.println("Usage: java Main <inputFile>");
            System.exit(1);
        }

        FileInputStream fis = null;
        for (int i = 0; i < args.length; ++i) {
            try{
                fis = new FileInputStream(args[i]);
                MiniJavaParser parser = new MiniJavaParser(fis);

                Goal root = parser.Goal();

                // System.err.println("Program: " + args[i] + " parsed successfully.");

                SymbolVisitor eval1 = new SymbolVisitor();
                root.accept(eval1, null);

                SymbolTable table = eval1.getTable();

                String type = table.checkObjects();
                if (type != null)
                    throw new Exception("Unknown type: " + type);

                TypeVisitor eval2 = new TypeVisitor(table);
                root.accept(eval2, null);

                LLVMVisitor eval3 = new LLVMVisitor(table);

                String[] names = args[i].split("/");
        	String path = "";
		if (args[i].charAt(0) != '/')
			path += '.';
		path += '/';
                for (int j = 0; j < names.length -1; ++j)
                    path += names[j] + "/";

                String name = names[names.length -1];
                name = name.split("\\.")[0];
                String fileName = name + ".ll";
                File myObj = new File ("./" + fileName);

                FileWriter writer = new FileWriter(path + fileName);
                writer.write(root.accept(eval3, null));
                writer.close();
            }
            catch(ParseException ex){
                System.out.println(ex.getMessage());
            }
            catch(FileNotFoundException ex){
                System.err.println(ex.getMessage());
            }
            catch(Exception ex) {
                System.err.println(ex.getMessage());
            }
            finally{
                continue;
            }

        }
    }
}
