typedef enum t_op_code {
	ADD, MUL, SOU, DIV, COP,
    AFC, JMP, JMF, INF, SUP,
	EQU, PRI
} op_code;

typedef struct t_element element;
typedef struct t_asm_table asm_table;

void addline(op_code code,int el1, int el2, int el3);
void initTable();
int getcurline();
void update_element(int linenumber,int newel1, int newel2, int newel3);
void writefulltable();
char* getopcode(op_code code,int nbop);
