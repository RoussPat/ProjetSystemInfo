
typedef enum t_op_code op_code;
typedef struct t_element element;
typedef struct t_asm_table asm_table;

/* Jd ne sais plus si on met ça
FILE* Outputfile;
asm_table* table;
int maxtable;
int line;*/


void addline(int num,op_code code,int el1,int el2,int el3);
asm_table initTable(int taille);
asm_table newif(int depth,int Expression );
asm_table endif(int depth);
int newifelse(int depth,int Expression);
int newelse(int depth);
int endifelse(int depth);
void writefulltable(int num);
void writetablebut1st(int num);
