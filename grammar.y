%{
	#include <math.h>
	#include <stdio.h>
	#include <stdlib.h>
	int yylex (void);
	#define YYDEBUG 1 /* For Debugging */
	void yyerror(char const *);

%}

%union {
        int intval;              /* Constant integer value */
        float floatval;               /* Constant floating point value */
  //     char *str;              /* Ptr to constant string (strings are malloc'd) */
  //      exprT expr;             /* Expression -  constant or address */
  //      operatorT *operatorP;   /* Pointer to run-time expression operator */
    };

%token MAURO ID IF THEN ELSE WHILE LEFT_ARROW OU AND GLEICH MAIORGLEICH MENORGLEICH MAIOR MENOR NOT TRUE FALSE
%token <floatval> NUMBERF
%token <intval> NUMBERI

%error-verbose

%left '-' '+'
%left '*' '/'
%right '^'

%start init

%%

init:
	  MAURO ID ':' LEFT_ARROW
			'{'
				statement_list
			'}'
;
statement_list 	: 	statement			{	 }
		| 	statement_list statement	{	 }
;

statement 	: 	declaration ';'						{ 	}
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
type: NUMBERF  {  }
		| NUMBERI	 {  }
;
declaration	: type ID '=' exp	{  }
		| type ID		{  }
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

exp : type 				{ /*gen_code( LD_INT, $1 ); */}
    | ID 					{/* context_check( LD_VAR, $1 );*/ }
    | exp '<' exp { /*gen_code( LT, 0 );*/ }
    | exp '=' exp {/* gen_code( EQ, 0 ); */}
    | exp '>' exp {/* gen_code( GT, 0 ); */}
    | exp '+' exp {/* gen_code( ADD, 0 ); */ }
    | exp '-' exp {/* gen_code( SUB, 0 ); */}
    | exp '*' exp {/* gen_code( MULT, 0 );*/ }
    | exp '/' exp {/* gen_code( DIV, 0 ); */}
    | exp '^' exp {/* gen_code( PWR, 0 );*/ }
    | '(' exp ')'
;

%%
extern int yylineno;

void yyerror(char const *errmsg)
{
	printf("\n Error %s at line %d \n",errmsg ,yylineno);
	//exit(1);
}
