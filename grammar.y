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
%}

%union {
        int intval;              /* Constant integer value */
        float floatval;               /* Constant floating point value */
       	char *str;              /* Ptr to constant string (strings are malloc'd) */
  //      exprT expr;             /* Expression -  constant or address */
  //      operatorT *operatorP;   /* Pointer to run-time expression operator */
    };

%token MAURO IF THEN ELSE WHILE LEFT_ARROW OU AND GLEICH MAIORGLEICH MENORGLEICH MAIOR MENOR NOT TRUE FALSE
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
		|	IF '(' Logic ')' statement_if				{	 }
		|	WHILE '(' Logic ')' '{' statement_list '}'	{ 	}
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
		|	Logic AND Logic	{	 }
		|	comparacao_exp			{ }
		|	NOT Logic		{	 }
		|	TRUE				{	 }
		|	FALSE				{	 }
;
comparacao_exp	:	exp GLEICH exp	{/*isFirst = 1;	*/ }
		|	exp MAIORGLEICH exp	{/*isFirst = 1;	*/ }
		|	exp MENORGLEICH exp	{/*isFirst = 1;	 */}
		|	exp '>' exp	{/*isFirst = 1;	*/ }
		|	exp '<' exp	{/*isFirst = 1;	*/ }
;

exp : NUM 				{ /*ICG( LD_INT, $1 ); */	}
 		| exp '<' exp { /*ICG( LT, 0 );  			*/	}
    | exp '=' exp { /*ICG( EQ, 0 );  			*/	}
    | exp '>' exp { /*ICG( GT, 0 );  			*/	}
    | exp '+' exp { ICG.gen_code(ADD/*,"t1"*/); }
    | exp '-' exp { /*ICG( SUB, 0 ); 			*/	}
    | exp '*' exp {/* ICG( MULT, 0 );			*/	}
    | exp '/' exp { /*ICG( DIV, 0 ); 			*/	}
    | exp '^' exp { /*ICG( PWR, 0 ); 			*/	}
    | '(' exp ')'
		| ID 					{/* context_check( LD_VAR, $1 );*/ }
;
NUM: NUMBERF  {   }
		| NUMBERI	 { ICG.gen_value($1); }
;
%%
extern int yylineno;

void yyerror(char const *errmsg)
{
	errors++;
	printf("\n Error %s at line %d \n",errmsg ,yylineno);
}
