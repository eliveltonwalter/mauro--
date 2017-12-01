
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
    int arg[3];
  }instruction;

  instruction instructions[999];
  int code_offset;

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

  void gen_code(code_op operation, void * arg1,void * arg2)
  {
    instructions[code_offset].op = operation;
    instructions[code_offset].arg[0] = arg1;
    instructions[code_offset].arg[1] = arg2;
  }
};
