## jflex jar path
jar = ./more/jflex-1.9.1/lib/jflex-full-1.9.1.jar

## path & files' name
path_src = ./src/
path_test = ./test/

lexer = LexicalAnalyzer
symbol = Symbol
lexical_unit = LexicalUnit

path_lexer = $(path_src)$(lexer)
path_symbol = $(path_src)$(symbol)
path_lexical_unit = $(path_src)$(lexical_unit)

## files
JavaLexer = $(path_lexer).java
JavaSymbol = $(path_symbol).java
JavalexicalUnit = $(path_lexical_unit).java

ClassLexer = $(path_lexer).class
ClassSymbol = $(path_symbol).class
ClassLexicalUnit = $(path_lexical_unit).class

flex = $(path_lexer).flex
input = $(path_test)Euclid.gls


## cmd
exec = java $(lexer) $(input)

all:
	java -jar $(jar) $(flex)
	javac $(JavaLexer) $(JavaSymbol) $(JavalexicalUnit)
exec:
	${exec}

clean:
	rm -f $(JavaLexer) $(ClassLexer) $(ClassLexicalUnit) $(ClassSymbol)
	
