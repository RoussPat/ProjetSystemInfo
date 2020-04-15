typedef enum t_op_code {
	ADD, MUL, SOU, DIV, COP,
    AFC, JMP, JMF, INF, SUP,
	EQU, PRI
} op_code;
typedef struct t_element element;
typedef struct t_asm_table asm_table;


int initTable(int taille);
int newif(int depth,int Expression );
int endif(int depth);
int newifelse(int depth,int Expression);
int newelse(int depth);
int endifelse(int depth);
void writefulltable(int num);
void writetablebut1st(int num);
char* getopcode(int code);
void addline(int num,op_code code,int el1,int el2,int el3);