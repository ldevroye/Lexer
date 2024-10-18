import java.io.FileReader;
import java.io.IOException;
import java.io.FileNotFoundException;
import java.util.TreeMap;

/*
 * Project Part 1 : Lexical Analysis
 * 
 * @autor: 	Akli-Kodjo-Mensah Gloria, Devroye Louis
 * 
 */

public class Main {
    /*
     * This is the main method of the program. It reads the source file and
     * analyzes it using the lexical analyzer. It then prints the lexical units
     * recognized by the analyzer (and the according symbol table).
     * 
     * @param args[0] : the path to the source file to analyze
     * @throws IOException if the file is not found
     * @throws FileNotFoundException if the file is not found
     *
     */
    public static void main(String[] args) throws IOException, FileNotFoundException {
        if (args.length != 1) {
            System.err.println("Usage: java -cp src src/Main.java <sourceFile.gls>");
            return;
        }

        FileReader reader = new FileReader(args[0]); // Open the source file given as argument
        LexicalAnalyzer lexer = new LexicalAnalyzer(reader); // Create the lexical analyzer using JFlex
        
        Symbol symbol = lexer.nextToken();
        TreeMap<String, Symbol> symbolTable = new TreeMap<String, Symbol>(); // Create the symbol table
        
        while (!symbol.getType().equals(LexicalUnit.EOS)) { // While the end of the file is not reached, analyze the file and print the lexical units
            System.out.println(symbol.toString());

            // Add the variable to the symbol table
            if(symbol.getType().equals(LexicalUnit.VARNAME)){
                if(!symbolTable.containsKey(symbol.getValue())) {
                    symbolTable.put(symbol.getValue().toString(), symbol);
                }
            }
            
            symbol = lexer.nextToken();
        }

        System.out.println("\nVariables");
        // Content of the symbol table with the variables and the number of the line where they were first encountered
        for (String key : symbolTable.keySet()) {
            System.out.println(key + " " + symbolTable.get(key).getLine());
        }
    }
}
