/* Part1 : User Code (any Java code, that will be added at the beginning of the generated scanner) */
    
import java.util.regex.PatternSyntaxException;
%%

/* Part2 : Options and declarations (some extra Java code included between %{ and %} can be generated, it will be copied verbatim inside the generated Java class (contrary to the code of the first part which appears outside of the class) + some ERE can be defined, they will be used as macros in part 3) */

%class LexicalAnalyzer
%unicode
%line
%column
%type Symbol
%yylexthrow PatternSyntaxException
%standalone

%eofval{ 
    return new Symbol(LexicalUnit.END_OF_STREAM, yyline, yycolumn);
%eofval}

// States
%xstate YYINITIAL, SHORTCOMMENTS, LONGCOMMENTS

// ERE
ProgName              = [A-Z][A-Za-z_]*
VarName               = [a-z][A-Za-z0-9]*
Number                = [0-9]*
//BadProgName           = [a-z][A-Za-z_]* // Invalid program name (case sensitive)
//BadVarName            = [A-Z][A-Za-z0-9]* // Invalid variable name (case sensitive)
WhiteSpace            = [ \t\r\n]+
%%

/* Part3 : Scanner rules (the core of the scanner, it is a series of rules that associate actions (in terms of Java code) to the regular expressions, each rule is of the form: Regex {Action} => Regex is an extended regular expression (ERE), that can use some of the regular expressions defined in part 2 as macros (using curly braces around their names); Action is a Java code snippet that will be executed each time a token matching Regex is found.) */

// Comments tokens
<SHORTCOMMENTS>{
    // End of short comments
    "\n"              { yybegin(YYINITIAL); }
    .                 { } // Ignore characters in comments
}
<LONGCOMMENTS>{
    // End of long comments
    "!!"              { yybegin(YYINITIAL); }
    <<EOF>>           { throw new PatternSyntexException("A long comment must be closed.", yytext(), yychar); } // Throw exception when a long comment is never closed
    .                 { } // Ignore characters in comments
}

// Gilles keywords
<YYINITIAL>{
    "\\$"             { yybegin(SHORTCOMMENTS); } // Begin of short comments
    "!!"              { yybegin(LONGCOMMENTS); } // Begin of long comments
    {ProgName}        { return new Symbol(LexicalUnit.PROGNAME, yyline, yycolumn, yytext()); } 
    {VarName}         { return new Symbol(LexicalUnit.VARNAME, yyline, yycolumn, yytext()); }
    {Number}          { return new Symbol(LexicalUnit.NUMBER, yyline, yycolumn, Integer.valueOf(yytext())); } 
    LET               { return new Symbol(LexicalUnit.LET, yyline, yycolumn, yytext()); }
    BE                { return new Symbol(LexicalUnit.BE, yyline, yycolumn, yytext()); }
    END               { return new Symbol(LexicalUnit.END, yyline, yycolumn, yytext()); }
    ":"               { return new Symbol(LexicalUnit.COLUMN, yyline, yycolumn, yytext()); }
    "="               { return new Symbol(LexicalUnit.ASSIGN, yyline, yycolumn, yytext()); }
    "("               { return new Symbol(LexicalUnit.LPAREN, yyline, yycolumn, yytext()); }
    ")"               { return new Symbol(LexicalUnit.RPAREN, yyline, yycolumn, yytext()); }
    "-"               { return new Symbol(LexicalUnit.MINUS, yyline, yycolumn, yytext()); }
    "+"               { return new Symbol(LexicalUnit.PLUS, yyline, yycolumn, yytext()); }
    "*"               { return new Symbol(LexicalUnit.TIMES, yyline, yycolumn, yytext()); }
    "/"               { return new Symbol(LexicalUnit.DIVIDE, yyline, yycolumn, yytext()); }
    IF                { return new Symbol(LexicalUnit.IF, yyline, yycolumn, yytext()); }
    THEN              { return new Symbol(LexicalUnit.THEN, yyline, yycolumn, yytext()); }
    ELSE              { return new Symbol(LexicalUnit.ELSE, yyline, yycolumn, yytext()); }
    "{"               { return new Symbol(LexicalUnit.LBRACK, yyline, yycolumn, yytext()); }
    "}"               { return new Symbol(LexicalUnit.RBRACK, yyline, yycolumn, yytext()); }
    "->"              { return new Symbol(LexicalUnit.IMPLIES, yyline, yycolumn, yytext()); }
    "|"               { return new Symbol(LexicalUnit.PIPE, yyline, yycolumn, yytext()); }
    "=="              { return new Symbol(LexicalUnit.EQUAL, yyline, yycolumn, yytext()); }
    "<="              { return new Symbol(LexicalUnit.SMALEQ, yyline, yycolumn, yytext()); }
    "<"               { return new Symbol(LexicalUnit.SMALLER, yyline, yycolumn, yytext()); }
    WHILE             { return new Symbol(LexicalUnit.WHILE, yyline, yycolumn, yytext()); }
    REPEAT            { return new Symbol(LexicalUnit.REPEAT, yyline, yycolumn, yytext()); }
    OUT               { return new Symbol(LexicalUnit.OUTPUT, yyline, yycolumn, yytext()); }
    IN                { return new Symbol(LexicalUnit.INPUT, yyline, yycolumn, yytext()); }
    // BadVar and BADProg Names
    {WhiteSpace}       { } // white space, tab, newlines must be ignore
    .                 { throw new PatternSyntaxException("Unrecognized character", yytext(), yychar); } // handle unmatched symbols
}
%%
