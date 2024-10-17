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
path_main = $(path_src)$(main)

## files
jar_main = $(path_dist)$(main).jar
class_main = $(path_main).class
all_java_src = $(path_src)*.java 

## info for the .jar
manifest = $(path_src)META-INF/MANIFEST.MF

flex = $(path_lexer).flex
input = $(path_test)Euclid.gls

all: run_jar

compile: 
	java -jar $(jar) $(flex)
	javac $(all_java_src)

doc: compile
	javadoc -d $(path_doc) $(all_java_src)

jar: compile
	jar cmf $(manifest) $(jar_main) $(all_java_src)

run_jar: jar
	java -jar $(jar_main)

run:
	java -cp $(path_src) $(lexer) $(input)

clean:
## the 1st * is for the .java~ sometimes created
	rm -f -r $(path_lexer).java* $(path_src)*.class $(path_doc)* $(jar_main)

