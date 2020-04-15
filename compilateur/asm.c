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
char ret[4];

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
	writetablebut1st(depth-1);
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
	table[depth].elem[0].el2=line;
	writefulltable(depth);
	table[depth].curElem =0; 
	addline(depth,JMP,-1,-1,-1);
	return depth;

}

int endifelse(int depth){
	table[depth].elem[0].el2 = line;
	writefulltable(depth);
}

void writefulltable(int num){
	Outputfile = fopen("a.out", "a+");
	int l;
	for(l=1;l<(table[num].curElem-1);l++){
		if(table[num].elem[l].el2 =-1){
			fprintf(Outputfile,"%s %d\n",getopcode(table[num].elem[l].code),table[num].elem[l].el1);
		}
		else{
			if(table[num].elem[l].el3 =-1){
				fprintf(Outputfile,"%s %d %d\n",getopcode(table[num].elem[l].code),table[num].elem[l].el1,table[num].elem[l].el2);
			}
			else{
				fprintf(Outputfile,"%s %d %d %d\n",getopcode(table[num].elem[l].code),table[num].elem[l].el1,table[num].elem[l].el2,table[num].elem[l].el3);
			}
		}
	}
	fclose(Outputfile);	
}

void writetablebut1st(int num){
	Outputfile = fopen("a.out", "a+");
	int l;
	for(l=1;l<(table[num].curElem-1);l++){
		if(table[num].elem[l].el2 == -1){
			fprintf(Outputfile,"%s %d\n",getopcode(table[num].elem[l].code),table[num].elem[l].el1);
		}
		else{
			if(table[num].elem[l].el3 == -1){
				fprintf(Outputfile,"%s %d %d\n",getopcode(table[num].elem[l].code),table[num].elem[l].el1,table[num].elem[l].el2);
			}
			else{
				fprintf(Outputfile,"%s %d %d %d\n",getopcode(table[num].elem[l].code),table[num].elem[l].el1,table[num].elem[l].el2,table[num].elem[l].el3);
			}
		}
	}
	table[num].curElem = 1;
	fclose(Outputfile);	
}

char* getopcode(int code){
	strcpy(ret,"NAN");
	switch(code){
		case ADD:
			strcpy(ret,"ADD");
		break;
		case MUL:
			strcpy(ret,"MUL");
		break;
		case SOU:
			strcpy(ret,"SOU");
		break;
		case DIV:
			strcpy(ret,"DIV");
		break;
		case COP:
			strcpy(ret,"COP");
		break;
		case AFC:
			strcpy(ret,"AFC");
		break;
		case JMP:
			strcpy(ret,"JMP");
		break;
		case JMF:
			strcpy(ret,"JMF");
		break;
		case INF:
			strcpy(ret,"INF");
		break;
		case SUP:
			strcpy(ret,"SUP");
		break;
		case EQU:
			strcpy(ret,"EQU");
		break;
		case PRI:
			strcpy(ret,"PRI");
		break;
		default:
		break;
	}
	return ret;
}