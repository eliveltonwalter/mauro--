#include <iostream>

extern int yyparse();

extern int yylineno;

extern int yydebug;

extern int errors;

using namespace std;

int main()
{
  //  yydebug = 1;
  errors = 0;
    int result = yyparse();
  if (/*result == 0*/ errors == 0)
		cout << "The input is valid" << endl;
	else
		cout << "The input is invalid" << endl;

		cout << "The amount of lines in the input is: " << yylineno << endl;
    return result;
}
