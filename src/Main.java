import java.io.FileReader;
import java.io.IOException;
import java.io.FileNotFoundException;

/*
 * Project Part 1 : Lexical Analysis
 * 
 * @autor: 	Akli-Kodjo-Mensah Gloria, xxxxxxxx
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
    public static void main(String[] args) throws IOException {
        if (args.length != 1) {
            System.err.println("Usage: java Main <sourceFile.gls>");
            return;
        }

        FileReader reader = new FileReader(args[0]); // Open the source file given as argument
        LexicalAnalyzer lexer = new LexicalAnalyzer(reader); // Create the lexical analyzer using JFlex
        
        while (!lexer.yyatEOF()) { // While the end of the file is not reached, analyze the file and print the lexical units
            LexicalUnit token = lexer.yylex();
            System.out.println("Lexical Unit: " + token);
        }
        
        // Affichez la table des symboles (à implémenter)
        // symbolTable.print();
    }
}
