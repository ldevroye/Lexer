## jflex jar path
jar = more/jflex-1.9.1/lib/jflex-full-1.9.1.jar

## path & files' name
path_src = src/
path_test = test/
path_doc = doc/
path_dist = dist/

lexer = LexicalAnalyzer
symbol = Symbol
lexical_unit = LexicalUnit
main = Main

path_lexer = $(path_src)$(lexer)
path_symbol = $(path_src)$(symbol)
path_lexical_unit = $(path_src)$(lexical_unit)

## files
java_lexer = $(path_lexer).java
java_symbol = $(path_symbol).java
java_lexical_unit = $(path_lexical_unit).java
java_main = $(path_src)$(main).java

jar_main = $(path_dist)$(main).jar

flex = $(path_lexer).flex
input = $(path_test)Euclid.gls

all: run-jar

compile: 
	java -jar $(jar) $(flex)
	javac $(java_lexer) $(java_symbol) $(java_lexical_unit)

doc: compile
	javadoc -d $(path_doc) $(path_src)*.java

jar: compile
	jar -c $(jar_main) -f $(java_main) -C $(path_src)

run-jar: jar
	java -jar $(jar_main)

run: compile
	java -cp $(path_src) $(lexer) $(input)

clean:
## the 1st * is for the .java~ sometimes created
	rm -f -r $(java_lexer)* $(path_src)*.class $(path_doc)*

