build: expr.l expr.y
	bison -d expr.y
	flex expr.l
	gcc -o expr expr.tab.c lex.yy.c -lfl

clean: 
	rm -f expr expr.tab.* lex.yy.c
