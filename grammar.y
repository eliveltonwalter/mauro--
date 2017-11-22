%{
	#include <math.h>
	#include <stdio.h>
	#include <stdlib.h>
	int yylex (void);
	void yyerror(char const *);
%}

%define api.value.type {double}


%token MAURO NAME COLON RIGHT_ARROW LEFT_BRACE RIGHT_BRACE


%start input

%%

input:
	MAURO NAME COLON RIGHT_ARROW LEFT_BRACE RIGHT_BRACE
	| %empty

%%
extern int yylineno;

void yyerror(char const *x)
{
	printf("Error %s at line %d \n",x ,yylineno);
	//exit(1);
}
