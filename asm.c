#include "asm.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef enum t_op_code {
	ADD, MUL, SUB, DIV, COP,
    AFC, JMP, JMF, INF, SUP,
	EQ, PRI
} op_code;

typedef struct t_element {
	int line;
	op_code code;
	short el1;
	short el2;
	short el3;
} element;

typedef struct t_asm_table {
	element[100] elem;
	int curElem;
	int size;
} asm_table;





//Créer un tableau de struct C qui stocke le code assembleur généré.
//=> Print, à la fin de yyparse (dans fonction main ou comme action à la fin du File), ce tableau dans le teminal ou dans un fichier (fprintf). DONE
//=> Mettre à jour votre makefile: ajouter le fichier ".c" dans la ligne gcc. Inclus le fichier ".h" dans Yacc, zone définition.      DONE

FILE* Outputfile;
asm_table* table;
int maxtable;
int line;

void addline(int num,op_code code,int el1,int el2,int el3){
	if(table[num].curElem +1 >= 100){
		writetablebut1st(num);
	}
	table[num].elem[curElem].line = line;
	table[num].elem[curElem].code = code;
	table[num].elem[curElem].el1 = el1;
	table[num].elem[curElem].el2 = el2;
	table[num].elem[curElem].el3 = el3;
	table[num].curElem ++;
	table[num].size ++;
	line ++;

}


int initTable(int size){
	Outputfile = fopen("a.out", "w+");
	table = malloc(size * sizeof(asm_table));
	table[0].curElem = 0;
	table[0].size =0;
	int maxtable = max;
	line = 1;
	return(0);
}

int newif(int depth,int Expression ){
	if(depth < maxsize){
		table[depth].curElem =0;
		table[depth].size =0;
		addline(depth,JMF,Expression,-1,-1);
		return depth;
	}
	else{
		printf("%s%d\n", "profondeur maximale atteinte : ", maxsize );
		return NULL;
	}
}
int endif(int depth){
	table[depth].elem[0].el2 = line;
	writefulltable(depth);
}

int newifelse(int depth,int Expression){

}
int newelse(int depth){

}
int endifelse(int depth){

}

void writefulltable(int num){
	int l;
	for(l=0;l<(table[num].curElem-1);l++){
		if(table[num].curElem.el2 =-1){
			fprintf(Outputfile,"%d %d\n",table[num].curElem.code,table[num].curElem.el1);
		}
		else{
			if(table[num].curElem.el3 =-1){
				fprintf(Outputfile,"%d %d %d\n",table[num].curElem.code,table[num].curElem.el1,table[num].curElem.el2);
			}
			else{
				fprintf(Outputfile,"%d %d %d %d\n",table[num].curElem.code,table[num].curElem.el1,table[num].curElem.el2,table[num].curElem.el3);
			}
		}
	}
}

void writetablebut1st(int num){

}
