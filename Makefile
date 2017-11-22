all:
	flex lex.l
	bison grammar.y -d
	gcc -c grammar.tab.c lex.yy.c
	ar rvs lexgram.a grammar.tab.o lex.yy.o
	g++ -std=c++11 -Wall -Wextra main.cpp lexgram.a -o compiler.exe
	mv compiler.exe bin


	./bin/compiler.exe < test/main.m--
