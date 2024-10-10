/* Part1 : User Code (any Java code, that will be added at the beginning of the generated scanner) */

    import LexicalUnit.java;
    import Symbol.java;
%%

/* Part2 : Options and declarations (some extra Java code included between %{ and %} can be generated, it will be copied verbatim inside the generated Java class (contrary to the code of the first part which appears outside of the class) + some ERE can be defined, they will be used as macros in part 3) */

%class LexicalAnalyzer
%unicode
%line
%column
%standalone
%{
// Define symbole table ()
SymboleTable symTab = new SymbolTable();
%}
%%

/* Part3 : Scanner rules (the core of the scanner, it is a series of rules that associate actions (in terms of Java code) to the regular expressions, each rule is of the form: Regex {Action} => Regex is an extended regular expression (ERE), that can use some of the regular expressions defined in part 2 as macros (using curly braces around their names); Action is a Java code snippet that will be executed each time a token matching Regex is found.) */
// Gilles keywords
LET         { return new Symbol(LexicalUnit.LET, yyline, yycolumn); }
BE          { return new Symbol(LexicalUnit.BE, yyline, yycolumn); }
END         { return new Symbol(LexicalUnit.END, yyline, yycolumn); }
IF          { return new Symbol(LexicalUnit.IF, yyline, yycolumn); }
THEN        { return new Symbol(LexicalUnit.THEN, yyline, yycolumn); }
ELSE        { return new Symbol(LexicalUnit.ELSE, yyline, yycolumn); }
WHILE       { return new Symbol(LexicalUnit.WHILE, yyline, yycolumn); }
REPEAT      { return new Symbol(LexicalUnit.REPEAT, yyline, yycolumn); }
OUT         { return new Symbol(LexicalUnit.OUTPUT, yyline, yycolumn); }
IN          { return new Symbol(LexicalUnit.INPUT, yyline, yycolumn); }
