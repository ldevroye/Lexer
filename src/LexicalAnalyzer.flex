import java.util.regex.PatternSyntaxException;

%%// Options of the scanner

%class LexicalAnalyzer // Name
%unicode               // Use unicode
%line                  
%column                // Enable line and column counting
%type Symbol           // Tell JFlex to use the Symbol class
%standalone


%eofval{ // value of eof
    return new Symbol(LexicalUnit.EOS, yyline, yycolumn); 
%eofval}

// States
%xstate YYINITIAL, SHORTCOMMENTS, LONGCOMMENTS

// ERE
ProgName              = [A-Z][A-Za-z]*_
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
    <<EOF>>           { throw new PatternSyntaxException("Unrecognized character", yytext(), (int) yychar);} // end of file too early
    .                 { } // Ignore characters in comments
}

// Gilles keywords
<YYINITIAL>{
    "$"               { yybegin(SHORTCOMMENTS); } // Begin of short comments
    "!!"              { yybegin(LONGCOMMENTS); } // Begin of long comments
    {ProgName}$       { return new Symbol(LexicalUnit.PROGNAME, yyline, yycolumn, yytext()); } 
    {VarName}$        { return new Symbol(LexicalUnit.VARNAME, yyline, yycolumn, yytext()); }
    {Number}$         { return new Symbol(LexicalUnit.NUMBER, yyline, yycolumn, Integer.valueOf(yytext())); } 
    "LET"             { return new Symbol(LexicalUnit.LET, yyline, yycolumn, yytext()); }
    "BE"              { return new Symbol(LexicalUnit.BE, yyline, yycolumn, yytext()); }
    "END"             { return new Symbol(LexicalUnit.END, yyline, yycolumn, yytext()); }
    ":"               { return new Symbol(LexicalUnit.COLUMN, yyline, yycolumn, yytext()); }
    "="               { return new Symbol(LexicalUnit.ASSIGN, yyline, yycolumn, yytext()); }
    "("               { return new Symbol(LexicalUnit.LPAREN, yyline, yycolumn, yytext()); }
    ")"               { return new Symbol(LexicalUnit.RPAREN, yyline, yycolumn, yytext()); }
    "-"               { return new Symbol(LexicalUnit.MINUS, yyline, yycolumn, yytext()); }
    "+"               { return new Symbol(LexicalUnit.PLUS, yyline, yycolumn, yytext()); }
    "*"               { return new Symbol(LexicalUnit.TIMES, yyline, yycolumn, yytext()); }
    "/"               { return new Symbol(LexicalUnit.DIVIDE, yyline, yycolumn, yytext()); }
    "IF"              { return new Symbol(LexicalUnit.IF, yyline, yycolumn, yytext()); }
    "THEN"            { return new Symbol(LexicalUnit.THEN, yyline, yycolumn, yytext()); }
    "ELSE"            { return new Symbol(LexicalUnit.ELSE, yyline, yycolumn, yytext()); }
    "{"               { return new Symbol(LexicalUnit.LBRACK, yyline, yycolumn, yytext()); }
    "}"               { return new Symbol(LexicalUnit.RBRACK, yyline, yycolumn, yytext()); }
    "->"              { return new Symbol(LexicalUnit.IMPLIES, yyline, yycolumn, yytext()); }
    "|"               { return new Symbol(LexicalUnit.PIPE, yyline, yycolumn, yytext()); }
    "=="              { return new Symbol(LexicalUnit.EQUAL, yyline, yycolumn, yytext()); }
    "<="              { return new Symbol(LexicalUnit.SMALEQ, yyline, yycolumn, yytext()); }
    "<"               { return new Symbol(LexicalUnit.SMALLER, yyline, yycolumn, yytext()); }
    "WHILE"           { return new Symbol(LexicalUnit.WHILE, yyline, yycolumn, yytext()); }
    "REPEAT"          { return new Symbol(LexicalUnit.REPEAT, yyline, yycolumn, yytext()); }
    "OUT"             { return new Symbol(LexicalUnit.OUTPUT, yyline, yycolumn, yytext()); }
    "IN"              { return new Symbol(LexicalUnit.INPUT, yyline, yycolumn, yytext()); }
    {WhiteSpace}+     { } // Ignore white space, tabs, newlines
    .                 { throw new PatternSyntaxException("Unrecognized character", yytext(), (int) yychar);} // Handle unmatched symbols
}