#include <stdio.h>

typedef enum {
  HALT, STORE, JMP_FALSE, GOTO,
  DATA, LD_INT, LD_VAR,
  READ_INT, WRITE_INT,
  LT, EQ, GT, ADD, SUB, MULT, DIV, PWR
  }code_op;


class Intermediate_Code_Generator{
private:
  typedef struct
  {
    code_op op;
    int arg[2];
  //  char result[2];
  }instruction;

  instruction instructions[999];
  int code_offset;
  int flag=0;

public:

  Intermediate_Code_Generator()
    {
      code_offset = 0;
    }
  ~Intermediate_Code_Generator() {}

  void setOffset()
  {
    code_offset++;
  }
  int getOffset()
  {
    return code_offset;
  }

  void gen_code(code_op operation/*, char result[2]*/)
  {
  //  printf("Code offset: %d\n",code_offset);
    instructions[code_offset].op = operation;
  //  printf("%d\n", instructions[code_offset].op );
  //  instructions[code_offset].result[0] = result[0];
  //  instructions[code_offset].result[1] = result[1];

  }
  void gen_value(int arg)
  {
  //  printf("Code offset: %d\n",code_offset);
  if(flag == 0)
  {
    instructions[code_offset].arg[0] = arg;
  }
  if(flag == 1)
  {
    instructions[code_offset].arg[1] = arg;
    flag = 0;
  }
  else flag = 1;
  }

  void gen_print()
  {
    int i=0;
    printf("Code:\n");
    do{

        //printf("operation %d\n",instructions[i].op);
        gen_printOP(instructions[i].op);
        //printf("result %s\n",instructions[i].result);
        printf(" %d | %d |\n",instructions[i].arg[0],instructions[i].arg[1]);
        i++;
      }while(i < code_offset);
  }

  void gen_printOP(code_op op)
  {
    switch (op) {
      case HALT :

      break;
      case READ_INT :

      break;
      case WRITE_INT :

      break;
      case STORE :

      break;
      case JMP_FALSE :

      break;
      case GOTO :

      break;
      case DATA :

      break;
      case LD_INT :

      break;
      case LD_VAR :

      break;
      case LT :

      break;
      case EQ :

      break;
      case GT :

      break;
      case ADD :
        printf("ADD |");
      break;
      case SUB :

      break;
      case MULT :

      break;
      case DIV :

      break;
      case PWR :

      break;
      default :
        printf( "%sInternal Error: Memory Dump\n" );
      break;
}
}




};
