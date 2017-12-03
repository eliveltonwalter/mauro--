#include <iostream>
#include "Intermediate_Code_Generator.hpp"

extern int yyparse();

extern int yylineno;

extern int yydebug;

extern int errors;

extern Intermediate_Code_Generator ICG;

using namespace std;

int main()
{
  //  yydebug = 1;

  errors = 0;
    int result = yyparse();
  if (/*result == 0*/ errors == 0)
  {
		cout << "The input is valid" << endl;
    ICG.gen_print();
  }
	else
  {
		cout << "The input is invalid" << endl;
  }
		cout << "The amount of lines in the input is: " << yylineno << endl;
    return result;
}
