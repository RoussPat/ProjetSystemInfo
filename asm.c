#include "asm.h"
#include <stdio.h>
#include <stdlib.h>

typedef enum t_op_code {
	ADD, MUL, SUB, DIV, COP,
    AFC, JMP, JMF, INF, SUP,
	EQ, PRI
} op_code;

typedef struct t_element {
	short size;
	op_code OP_CODE;
	short el1;
	short el2;
	short el3;
} element;

typedef struct t_asm_table {
	element* first;
	int size;
	int next;
} asm_table;



//Créer un tableau de struct C qui stocke le code assembleur généré.
//=> Print, à la fin de yyparse (dans fonction main ou comme action à la fin du File), ce tableau dans le teminal ou dans un fichier (fprintf).
//=> Mettre à jour votre makefile: ajouter le fichier ".c" dans la ligne gcc. Inclus le fichier ".h" dans Yacc, zone définition.
