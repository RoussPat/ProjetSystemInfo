all:
	yacc -d -t -v compiler.y
	flex compiler.l
	gcc lex.yy.c y.tab.c symboldepth.c -o compiler

lexicale:
	flex lexicale.l
	gcc lex.yy.c -o lexer
   
clean:
	rm -f lex.yy.c lexer
