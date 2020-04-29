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
	struct t_element * next;
} element;

typedef struct t_asm_table {
	struct t_element* head;
	struct t_element* curElem;
	int line;
} asm_table;


FILE* Outputfile;
asm_table table;
//char ret[4] ;

void addline(op_code code,int el1, int el2, int el3){
	printf("new line added LINE %d: %d %d %d %d\n",table.line,code,el1,el2,el3);
	element* new = malloc(sizeof(element));
	new->next = NULL;
	new->line = table.line;
	new->el1 = el1;
	new->el2 = el2;
	new->el3 = el3;
	new->code = code;
	if(table.line > 0){
		table.curElem->next = new;
	}
	else{
		table.head = new;
	}
	table.curElem = new;
	table.line ++;
}

void initTable(){
	Outputfile = fopen("a.out", "w+");
	fclose(Outputfile);
	table.line = 0;
}

int getcurline(){
	return(table.line);
}

void update_element(int linenumber,int newel1, int newel2, int newel3){ //don't update if newelX = -2
	printf("Modif ligne %d : ",linenumber);
	if(linenumber > table.line){
		printf("error on updating element line %d\n",linenumber );
	}
	element* modify = table.head;
	while(modify->line != linenumber){
		modify=modify->next;
	}
	if(newel1 != -2){
		printf(" Arg1 : %d devient %d\n",modify->el1,newel1);
		modify->el1 = newel1;

	}
	if(newel2 != -2){
		printf(" Arg2 : %d devient %d\n",modify->el2,newel2);
		modify->el2 = newel2;
	}
	if(newel3 != -2){
		printf(" Arg13: %d devient %d\n",modify->el3,newel3);
		modify->el3 = newel3;
	}
	printf("\n");
}	


void writefulltable(int num){
	Outputfile = fopen("a.out", "a+");
	element * current = table.head;
	element * tofree;
	while(current->next != NULL){
			printf("[%3d]",current->line);
			if(current->el2 ==-1){
			printf("%s %d\n",getopcode(current->code,1),current->el1);
			fprintf(Outputfile,"%x %d\n",current->code+1,current->el1);
		}
		else{
			if(current->el3 ==-1){
				printf("%s %d %d\n",getopcode(current->code,2),current->el1,current->el2);
				fprintf(Outputfile,"%x %d %d\n",current->code+1,current->el1,current->el2);
			}
			else{
				printf("%s %d %d %d\n",getopcode(current->code,3),current->el1,current->el2,current->el3);
				fprintf(Outputfile,"%x %d %d %d\n",current->code+1,current->el1,current->el2,current->el3);
			}
		}
		tofree = current;
		current = current->next;
		free(tofree);
	}
	printf("[%3d]",current->line);
	if(current->el2 ==-1){
		printf("%s %d\n",getopcode(current->code,1),current->el1);
		fprintf(Outputfile,"%x %d\n",current->code+1,current->el1);
	}
	else{
		if(current->el3 ==-1){
			printf("%s %d %d\n",getopcode(current->code,2),current->el1,current->el2);
			fprintf(Outputfile,"%x %d %d\n",current->code+1,current->el1,current->el2);
		}
		else{
			printf("%s %d %d %d\n",getopcode(current->code,3),current->el1,current->el2,current->el3);
			fprintf(Outputfile,"%x %d %d %d\n",current->code+1,current->el1,current->el2,current->el3);
		}
	}
	free(current);
	//fclose(Outputfile);
}


char* getopcode(op_code code,int nbop){
	char* ret = malloc(4*sizeof(char));
	strcpy(ret, "NAN");
	int err =0;
	switch(code){
		case ADD:
			strcpy(ret,"ADD");
			if(nbop != 3 ){
				err = 3;
			}
		break;
		case MUL:
			strcpy(ret,"MUL");
			if(nbop != 3 ){
				err = 3;
			}
		break;
		case SOU:
			strcpy(ret,"SOU");
			if(nbop != 3 ){
				err = 3;
			}
		break;
		case DIV:
			strcpy(ret,"DIV");
			if(nbop != 3 ){
				err = 3;
			}
		break;
		case COP:
			strcpy(ret,"COP");
			if(nbop != 2 ){
				err = 2;
			}
		break;
		case AFC:
			strcpy(ret,"AFC");
			if(nbop != 2 ){
				err = 2;
			}
		break;
		case JMP:
			strcpy(ret,"JMP");
			if(nbop != 1 ){
				err = 1;
			}
		break;
		case JMF:
			strcpy(ret,"JMF");
			if(nbop != 2 ){
				err = 2;
			}
		break;
		case INF:
			strcpy(ret,"INF");
			if(nbop != 3 ){
				err = 3;
			}
		break;
		case SUP:
			strcpy(ret,"SUP");
			if(nbop != 3 ){
				err = 3;
			}
		break;
		case EQU:
			strcpy(ret,"EQU");
			if(nbop != 3 ){
				err = 3;
			}
		break;
		case PRI:
			strcpy(ret,"PRI");
			if(nbop != 1 ){
				err = 1;
			}
		break;
		default:
		break;
	}
	if(err!=0){
		printf("erreur dans le nombre d'argument du %s, il a %d arguments au lieu de %d\n",ret,nbop,err );
	}
	return ret;
}