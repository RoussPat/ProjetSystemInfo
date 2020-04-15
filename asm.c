#include "asm.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>



typedef struct t_element {
	int line;
	op_code code;
	short el1;
	short el2;
	short el3;
} element;

typedef struct t_asm_table {
	struct t_element elem[100];
	int curElem;
	int size;
} asm_table;


FILE* Outputfile;
asm_table* table;
int maxtable;
int line;

void addline(int num,op_code code,int el1,int el2,int el3){
	if(table[num].curElem +1 >= 100){
		writetablebut1st(num);
	}
	table[num].elem[table[num].curElem].line = line; 
	table[num].elem[table[num].curElem].code = code;
	table[num].elem[table[num].curElem].el1 = el1;
	table[num].elem[table[num].curElem].el2 = el2;
	table[num].elem[table[num].curElem].el3 = el3;
	table[num].curElem ++;
	table[num].size ++;
	line ++;
}


int initTable(int size){
	Outputfile = fopen("a.out", "w+");
	fclose(Outputfile);
	table = malloc(size * sizeof(asm_table));
	table[0].curElem = 0; 
	table[0].size =0;
	int maxtable = size; 
	line = 1;
	return(0);
}

int newif(int depth,int Expression ){
	if(depth < maxtable){	
		table[depth].curElem =0; 
		table[depth].size =0;
		addline(depth,JMF,Expression,-1,-1);
		return depth; 
	}
	else{
		printf("%s%d\n", "profondeur maximale atteinte : ", maxtable );
		return -1;
	}
}
int endif(int depth){
	table[depth].elem[0].el2 = line;
	writefulltable(depth);
}

int newifelse(int depth,int Expression){
	if(depth < maxtable){	
		table[depth].curElem =0; 
		table[depth].size =0;
		addline(depth,JMF,Expression,-1,-1);
		return depth; 
	}
	else{
		printf("%s%d\n", "profondeur maximale atteinte : ", maxtable );
		return -1;
	}
}

int newelse(int depth){

}

int endifelse(int depth){

}

void writefulltable(int num){
	Outputfile = fopen("a.out", "a+");
	int l;
	for(l=1;l<(table[num].curElem-1);l++){
		if(table[num].elem[l].el2 =-1){
			fprintf(Outputfile,"%d %d\n",table[num].elem[l].code,table[num].elem[l].el1);
		}
		else{
			if(table[num].elem[l].el3 =-1){
				fprintf(Outputfile,"%d %d %d\n",table[num].elem[l].code,table[num].elem[l].el1,table[num].elem[l].el2);
			}
			else{
				fprintf(Outputfile,"%d %d %d %d\n",table[num].elem[l].code,table[num].elem[l].el1,table[num].elem[l].el2,table[num].elem[l].el3);
			}
		}
	}
	fclose(Outputfile);	
}

void writetablebut1st(int num){
	Outputfile = fopen("a.out", "a+");
	int l;
	for(l=1;l<(table[num].curElem-1);l++){
		if(table[num].elem[l].el2 =-1){
			fprintf(Outputfile,"%d %d\n",table[num].elem[l].code,table[num].elem[l].el1);
		}
		else{
			if(table[num].elem[l].el3 =-1){
				fprintf(Outputfile,"%d %d %d\n",table[num].elem[l].code,table[num].elem[l].el1,table[num].elem[l].el2);
			}
			else{
				fprintf(Outputfile,"%d %d %d %d\n",table[num].elem[l].code,table[num].elem[l].el1,table[num].elem[l].el2,table[num].elem[l].el3);
			}
		}
	}
	table[num].curElem = 1;
	fclose(Outputfile);	
}
