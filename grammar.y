%{
	#include <math.h>
	#include <stdio.h>
	#include <stdlib.h>
	#include <string.h>
	#include "SymbolTable.h"
	#include "Intermediate_Code_Generator.hpp"
	int yylex (void);
	#define YYDEBUG 1 /* Debugging */
	void yyerror(char const *);
	int errors; /* Error Count */

	Intermediate_Code_Generator ICG;

install ( char *sym_name )
{
	symrec *s;
	s = getsym (sym_name);

	if (s == 0) s = putsym (sym_name);
	else
	{
		errors++;
		printf( "%s is already defined\n", sym_name );
	}
}

context_check(code_op operation, char *sym_name )
{
	symrec *identifier;
	identifier = getsym( sym_name );
	if ( identifier == 0 )
	{
		errors++;
		printf( "%s", sym_name );
		printf( "%s\n", " is an undeclared identifier" );
	}
	else
		{
			ICG.gen_code( operation );
			ICG.gen_value(identifier->offset);
		}
}


%}

%union {
        int intval;              /* Constant integer value */
        float floatval;               /* Constant floating point value */
       	char *str;              /* Ptr to constant string (strings are malloc'd) */
  //      exprT expr;             /* Expression -  constant or address */
  //      operatorT *operatorP;   /* Pointer to run-time expression operator */
    };

%token MAURO IF THEN ELSE WHILE LEFT_ARROW OU AND GLEICH MAIORGLEICH MENORGLEICH MAIOR MENOR NOT TRUE FALSE PRINTF
%token <floatval> NUMBERF
%token <intval> NUMBERI
%token <str>	ID

%error-verbose

%left '-' '+'
%left '*' '/'
%right '^'

%start init

%%

init:
	  MAURO ID ':' LEFT_ARROW { install($2); }
			'{'
				statement_list
			'}'
;
statement_list 	: 	statement			{	 }
		| 	statement_list statement	{	 }
;

statement 	: 	declaration ';'						{ ICG.setOffset();}
		|	IF '(' Logic ')' statement_if				{	printf("IF\n"); }
		|	WHILE '(' Logic ')' '{' statement_list '}'	{ printf("WHILE\n");	}
		| PRINTF '('  ID  ')' ';' { printf("%s\n",$3); }
;
statement_if	:	'{' statement_list '}'	statement_else			{	}
		|	declaration ';' statement_else				{	}
;
statement_else	:	ELSE'{'statement_list'}'				{	}
		|	ELSE declaration';'					{	}
		| %empty
;
type: NUMBERF  {   }
		| NUMBERI	 {   }
;
declaration	: type ID		{ install($2);  }
		|	type ID '=' exp	{ install($2); }
		|	ID '=' exp	{ 	}
;
Logic	:	Logic OU Logic	{	 }
		|	Logic AND Logic		{	 }
		|	comparacao_exp		{  }
		|	NOT Logic					{	 }
		|	TRUE							{	 }
		|	FALSE							{	 }
;
comparacao_exp	:	exp GLEICH exp	{ }
		|	exp MAIORGLEICH exp					{ }
		|	exp MENORGLEICH exp					{ }
		|	exp '>' exp									{ }
		|	exp '<' exp									{ }
;

exp : NUM 				{ /*ICG( LD_INT, $1 ); */	}
 		| exp '<' exp { ICG.gen_code(LT);  	}
    | exp '=' exp { ICG.gen_code(EQ);	  }
    | exp '>' exp { ICG.gen_code(GT); 	}
    | exp '+' exp { ICG.gen_code(ADD/*,"t1"*/); }
    | exp '-' exp { ICG.gen_code(SUB);	}
    | exp '*' exp { ICG.gen_code(MULT);	}
    | exp '/' exp { ICG.gen_code(DIV);	}
    | exp '^' exp { ICG.gen_code(PWR);	}
    | '(' exp ')'
		| ID 					{ context_check( LD_VAR, $1 ); }
;
NUM: NUMBERF   { ICG.gen_value($1); }
		| NUMBERI	 { ICG.gen_value($1); }
;
%%
extern int yylineno;

void yyerror(char const *errmsg)
{
	errors++;
	printf("\n Error %s at line %d \n",errmsg ,yylineno);
}
