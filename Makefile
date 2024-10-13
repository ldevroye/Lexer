## jflex jar path
jar = ./more/jflex-1.9.1/lib/jflex-full-1.9.1.jar

## path & files' name
path_src = ./src
path_test = ./test
lexer = LexicalAnalyzer
path_lexer = $(path_src)/$(lexer)

## files
JavaLexer = $(path_lexer).java
ClassLexer = $(path_lexer).class
flex = $(path_lexer).flex
input = $(path_test)/euclide.gls

## cmd
exec = java $(lexer) $(input)

all:
	java -jar $(jar) $(flex)
	echo "------------- end of 1st part ------------"
	javac $(JavaLexer)
exec:
	${exec}

clean:
	rm -f $(ClassLexer) $(JavaLexer)
	
