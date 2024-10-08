jar = ./more/jflex-1.9.1/lib/jflex-full-1.9.1.jar

lexer = SampleLexer.java
classLexer = SampleLexer.class
input = input.txt
flex = sample.flex

exec = java $(lexer) $(input)

all:
	java -jar $(jar) $(flex)
	javac $(lexer)
	${exec}
exec:
	${exec}
