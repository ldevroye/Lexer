import java.util.regex.PatternSyntaxException;
import java.util.HashMap;

%%// Options of the scanner

%class LexicalAnalyzer // Name
%unicode               // Use unicode
%line                  
%column                // Enable line and column counting
%type Symbol           // Tell JFlex to use the Symbol class
%standalone


%eofval{ // value of eof
    PrintVarMap();
    return new Symbol(LexicalUnit.EOS, yyline, yycolumn); 
%eofval}

// couting of var's 1st encounter
%{ // Java code
    HashMap<String, Integer> variableMap = new HashMap<>();

    public void TryAddVar(String name, int index)
    {
        if(!variableMap.containsKey(name))
        {
            variableMap.put(name, index);
        }
    }

    public void PrintVarMap()
    {
        System.out.println("Variables");

        for (String key : variableMap.keySet())
        {
            System.out.printf("%s %d\n", key, variableMap.get(key));
        }
    }
%}

// States
%xstate YYINITIAL, SHORTCOMMENTS, LONGCOMMENTS

// ERE
ProgName              = [A-Z][A-Za-z]*(_[A-Za-z]+)+ //TODO : check consistency
VarName               = [a-z][A-Za-z0-9]*
Number                = [0-9]+
WhiteSpace            = (" "|"\t"|"\r"|"\n")

%% //Identification of tokens

// Comments tokens
<SHORTCOMMENTS>{
    // End of short comments
    "\n"              { yybegin(YYINITIAL); }
    .                 { } // Ignore characters in comments 
}

<LONGCOMMENTS>{
    // End of long comments
    "!!"              { yybegin(YYINITIAL); }
    <<EOF>>           { throw new PatternSyntaxException("Unexpected end of file", yytext(), (int) yychar);} // end of file too early
    .                 { } // Ignore characters in comments
}

// Gilles keywords
<YYINITIAL>{
    "$"               { yybegin(SHORTCOMMENTS); } // Begin of short comments
    "!!"              { yybegin(LONGCOMMENTS); } // Begin of long comments
    {ProgName}        { System.out.println("ProgName: " + yytext()); return new Symbol(LexicalUnit.PROGNAME, yyline, yycolumn, yytext()); } 
    {VarName}         { System.out.println("VarName: " + yytext()); 
                        TryAddVar(yytext(), yyline); // Adding the var to the dict
                        return new Symbol(LexicalUnit.VARNAME, yyline, yycolumn, yytext()); } 

    {Number}          { System.out.println("Number: " + yytext()); return new Symbol(LexicalUnit.NUMBER, yyline, yycolumn, Integer.valueOf(yytext())); } 
    "LET"             { System.out.println("LET: " + yytext()); return new Symbol(LexicalUnit.LET, yyline, yycolumn, yytext()); }
    "BE"              { System.out.println("BE: " + yytext()); return new Symbol(LexicalUnit.BE, yyline, yycolumn, yytext()); }
    "END"             { System.out.println("END: " + yytext()); return new Symbol(LexicalUnit.END, yyline, yycolumn, yytext()); }
    ":"               { System.out.println("COLUMN : " + yytext()); return new Symbol(LexicalUnit.COLUMN, yyline, yycolumn, yytext()); }
    "="               { System.out.println("ASSIGN: " + yytext()); return new Symbol(LexicalUnit.ASSIGN, yyline, yycolumn, yytext()); }
    "("               { System.out.println("LPAREN: " + yytext()); return new Symbol(LexicalUnit.LPAREN, yyline, yycolumn, yytext()); }
    ")"               { System.out.println("RPAREN: " + yytext()); return new Symbol(LexicalUnit.RPAREN, yyline, yycolumn, yytext()); }
    "-"               { System.out.println("MINUS: " + yytext()); return new Symbol(LexicalUnit.MINUS, yyline, yycolumn, yytext()); }
    "+"               { System.out.println("PLUS: " + yytext()); return new Symbol(LexicalUnit.PLUS, yyline, yycolumn, yytext()); }
    "*"               { System.out.println("TIMES: " + yytext()); return new Symbol(LexicalUnit.TIMES, yyline, yycolumn, yytext()); }
    "/"               { System.out.println("DIVIDE: " + yytext()); return new Symbol(LexicalUnit.DIVIDE, yyline, yycolumn, yytext()); }
    "IF"              { System.out.println("IF: " + yytext()); return new Symbol(LexicalUnit.IF, yyline, yycolumn, yytext()); }
    "THEN"            { System.out.println("THEN: " + yytext()); return new Symbol(LexicalUnit.THEN, yyline, yycolumn, yytext()); }
    "ELSE"            { System.out.println("ELSE: " + yytext()); return new Symbol(LexicalUnit.ELSE, yyline, yycolumn, yytext()); }
    "{"               { System.out.println("LBRACK: " + yytext()); return new Symbol(LexicalUnit.LBRACK, yyline, yycolumn, yytext()); }
    "}"               { System.out.println("RBRACK: " + yytext()); return new Symbol(LexicalUnit.RBRACK, yyline, yycolumn, yytext()); }
    "->"              { System.out.println("IMPLIES: " + yytext()); return new Symbol(LexicalUnit.IMPLIES, yyline, yycolumn, yytext()); }
    "|"               { System.out.println("PIPE: " + yytext()); return new Symbol(LexicalUnit.PIPE, yyline, yycolumn, yytext()); }
    "=="              { System.out.println("EQUAL: " + yytext()); return new Symbol(LexicalUnit.EQUAL, yyline, yycolumn, yytext()); }
    "<="              { System.out.println("SMALEQ: " + yytext()); return new Symbol(LexicalUnit.SMALEQ, yyline, yycolumn, yytext()); }
    "<"               { System.out.println("SMALLER: " + yytext()); return new Symbol(LexicalUnit.SMALLER, yyline, yycolumn, yytext()); }
    "WHILE"           { System.out.println("WHILE: " + yytext()); return new Symbol(LexicalUnit.WHILE, yyline, yycolumn, yytext()); }
    "REPEAT"          { System.out.println("REPEAT: " + yytext()); return new Symbol(LexicalUnit.REPEAT, yyline, yycolumn, yytext()); }
    "OUT"             { System.out.println("OUTPUT: " + yytext());return new Symbol(LexicalUnit.OUTPUT, yyline, yycolumn, yytext()); }
    "IN"              { System.out.println("INPUT: " + yytext()); return new Symbol(LexicalUnit.INPUT, yyline, yycolumn, yytext()); }
    {WhiteSpace}+     { } // Ignore white space, tabs, newlines
    .                 { throw new PatternSyntaxException("Unrecognized character", yytext(), (int) yychar);} // Handle unmatched symbols
}