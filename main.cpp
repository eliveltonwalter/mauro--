#include <iostream>

extern "C"
{
	int yyparse();
	void yyerror(const char *);
	int yylex();
}
extern int yylineno;

int main()
{
    int result = yyparse();
  if (result == 0)
		std::cout << "The input is valid" << std::endl;
	else
		std::cout << "The input is invalid" << std::endl;

		std::cout << "The amount of lines in the input is: " << yylineno << std::endl;
    return result;
}
