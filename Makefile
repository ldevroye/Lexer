## jflex jar path
jar = ./more/jflex-1.9.1/lib/jflex-full-1.9.1.jar

## path & files' name
path_src = ./src/
path_test = ./test/
path_doc = doc/javadoc/
path_dist = dist/

lexer = LexicalAnalyzer
symbol = Symbol
lexical_unit = LexicalUnit
main = Main

path_lexer = $(path_src)$(lexer)
path_symbol = $(path_src)$(symbol)
path_lexical_unit = $(path_src)$(lexical_unit)

jar_main = $(path_dist)$(main).jar
class_main = $(path_main).class

## files
javalexer = $(path_lexer).java
javasymbol = $(path_symbol).java
javalexunit = $(path_lexical_unit).java
all_java_src_compile = $(javalexer) $(javasymbol) $(javalexunit)
javamain = $(main).java

## info for the .jar
manifest = $(path_src)META-INF/MANIFEST.MF

flex = $(path_lexer).flex
input = $(path_test)Euclid.gls

all: 
	run_jar

compile: 
	java -jar $(jar) $(flex)
	javac $(all_java_src_compile)
	javac -d src src/*.java

doc: compile
	javadoc -d $(path_doc) $(all_java_src_compile)

jar: compile
	jar cmf $(manifest) $(jar_main) $(all_java_src_compile)

run_jar: 
	jar
	java -jar $(jar_main)

run: compile
	java -cp $(path_src) $(main) $(input)

clean:
## the 1st * is for the .java~ sometimes created
	rm -f -r $(path_lexer).java* $(path_src)*.class $(path_doc)* $(jar_main)