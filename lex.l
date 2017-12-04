%option noyywrap
%x comment
%{
	#include <stdlib.h>
	#include <string.h> /* for strdup */
	#include "grammar.tab.h"
%}

letter 			[a-zA-Z]
digit				[0-9]
id				{letter}({letter}|{digit})*+
whitespace	[ \r\v\f]
linefeed		\n
leo	{digit}+
girombossauro	{digit}+(\.{digit}+)?(E[+-]?{digit}+)?

%%

"/*"						{ BEGIN comment; }
<comment>[^*\n]	{  }
<comment>"*/"		{ BEGIN INITIAL; }
<comment>"*"		{  }

"M_"							{ return (MAURO);		 		}
"POIMNATELA"		{ return (PRINTF);			}
{leo}							{ yylval.intval = atoi(yytext);  return (NUMBERI);	 		}
"leo"							{	return (NUMBERI);	 		}
"girombossauro"		{	return (NUMBERF);	 		}
{girombossauro}		{ yylval.floatval = atof(yytext);  return (NUMBERF);  	}
Seria_verdade_se 	{ return (IF); 			 		}
then							{ return (THEN); 		 		}
Nao_fosse_mentira { return (ELSE); 		 		}
"VILE" 						{ return (WHILE); 	 		}
"OR" 							{ return (OU); 			 		}
"AND"							{ return (AND); 		 		}
"=="							{ return (GLEICH); 	 		}
":"								{ return (':'); 		 		}
";"								{ return (';'); 				}
"->"							{ return (LEFT_ARROW);  }
"{"								{ return ('{'); 				}
"}"								{ return ('}'); 				}
"<"								{ return ('<'); 				}
"<="							{ return (MENORGLEICH); }
"="								{ return ('='); 				}
"("								{ return ('('); 				}
")"								{ return (')'); 				}
">"								{ return ('>'); 				}
">="							{ return (MAIORGLEICH); }
"NAOCARA"					{ return (NOT); 				}
"V"								{ return (TRUE); 			 	}
"F"								{ return (FALSE); 			}
"^" 							{ return ('^'); 				}
"+" 							{ return ('+'); 				}
"-" 							{ return ('-'); 				}
"*" 							{ return ('*'); 				}
"/" 							{ return ('/'); 				}
"%" 							{ return ('%'); 				}

{id}							{ yylval.str = (char *) strdup(yytext); return (ID); 		}//aloca e copia

{whitespace}
{linefeed}	++yylineno;


%%
#include <stdio.h>
