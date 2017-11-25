%option noyywrap
%x comment
%{
	#include <stdlib.h>
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
{leo}							{ return (NUMBERI);	 		}
"leo"							{	return (NUMBERI);	 		}
"girombossauro"		{	return (NUMBERF);	 		}
{girombossauro}		{ return (NUMBERF);  		}
{id}							{ return (ID); 			 		}
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
"<>"							{ return ('<>'); 			 	}
">"								{ return ('>'); 				}
">="							{ return (MAIORGLEICH); }
"NAOCARA"					{ return (NOT); 				}
"V"								{ return (TRUE); 			 	}
"F"								{ return (FALSE); 			}

{whitespace}
{linefeed}	++yylineno;



%%
#include <stdio.h>
