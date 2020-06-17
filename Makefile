jparse:	main.o j_parse.o j_lex.o
	gcc -o jparse main.o j_parse.o j_lex.o

debug:
	bison -d --report=all -o java_parse.c java_parse.y

j_parse.c:	j_parse.y
	bison -d -o j_parse.c j_parse.y

j_parse.h:	j_parse.y
	bison -d -o j_parse.c j_parse.y

j_parse.o:	j_parse.c j_lex.h j_parse.h
	gcc -c -o j_parse.o j_parse.c

j_lex.c:	j_lex.l
	flex -oj_lex.c j_lex.l

j_lex.o:	j_lex.c j_lex.h j_parse.h
	gcc -c -o j_lex.o j_lex.c

main.o:	main.c j_lex.h j_parse.h
	gcc -c -o main.o main.c

clean:
	rm *.o j_lex.c j_parse.c j_parse.h jparse

