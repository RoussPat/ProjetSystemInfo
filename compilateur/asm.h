
typedef enum t_op_code op_code;
typedef struct t_element element;
typedef struct t_asm_table asm_table;


asm_table initTable(int taille);
asm_table newif(int depth,int Expression );
asm_table endif(int depth);