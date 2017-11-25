all:
	bison grammar.y -d
	flex lex.l
	g++ -std=gnu++11 -c grammar.tab.c lex.yy.c
	ar rvs lexgram.a grammar.tab.o lex.yy.o
	g++ -std=gnu++11 -Wall -Wextra main.cpp lexgram.a -o compiler.exe
	mv compiler.exe bin


	./bin/compiler.exe < test/main.m--
