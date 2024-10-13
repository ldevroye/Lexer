jar = ./more/jflex-1.9.1/lib/jflex-full-1.9.1.jar

path = ./src/
lexer = LexicalAnalyzer

JavaLexer = $(path)$(lexer).java
ClassLexer = $(path)$(lexer).class
flex = $(path)$(lexer).flex
input = $(path)input.txt

exec = java $(lexer) $(input)

all:
	java -jar $(jar) $(flex)
	javac $(JavaLexer)
	${exec}
exec:
	${exec}

clean:
	rm -f $(ClassLexer) $(JavaLexer)
