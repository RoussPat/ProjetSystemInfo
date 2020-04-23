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
char ret[4] ;

void addline(op_code code,int el1, int el2, int el3){
	element* new = malloc(sizeof(element));
	new->next = NULL;
	new->line = table.line;
	new->el1 = el1;
	new->el2 = el2;
	new->el3 = el3;
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
	if(linenumber > table.line){
		printf("error on updating element line %d\n",linenumber );
	}
	element* modify = table.head;
	while(modify->line != linenumber){
		modify=modify->next;
	}
	if(newel1 != -2){
		modify->el1 = newel1;
	}
	if(newel2 != -2){
		modify->el2 = newel2;
	}
	if(newel1 != -2){
		modify->el2 = newel2;
	}
}


void writefulltable(int num){
	Outputfile = fopen("a.out", "a+");
	element * current = table.head;
	while(current->next != NULL){
			if(current->el2 =-1){
			fprintf(Outputfile,"%s %d\n",getopcode(current->code,1),current->el1);
		}
		else{
			if(current->el3 =-1){
				fprintf(Outputfile,"%s %d %d\n",getopcode(current->code,2),current->el1,current->el2);
			}
			else{
				fprintf(Outputfile,"%s %d %d %d\n",getopcode(current->code,3),current->el1,current->el2,current->el3);
			}
		}
	}

	fclose(Outputfile);	
}


char* getopcode(int code,int nbop){
	strcpy(ret, "NAN");
	int err =0;
	switch(code){
		case ADD:
			strcpy(ret,"ADD");
			if(nbop != 3 ){
				err = 1;
			}
		break;
		case MUL:
			strcpy(ret,"MUL");
			if(nbop != 3 ){
				err = 1;
			}
		break;
		case SOU:
			strcpy(ret,"SOU");
			if(nbop != 3 ){
				err = 1;
			}
		break;
		case DIV:
			strcpy(ret,"DIV");
			if(nbop != 3 ){
				err = 1;
			}
		break;
		case COP:
			strcpy(ret,"COP");
			if(nbop != 2 ){
				err = 1;
			}
		break;
		case AFC:
			strcpy(ret,"AFC");
			if(nbop != 2 ){
				err = 1;
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
			if(nbop != 1 ){
				err = 1;
			}
		break;
		case INF:
			strcpy(ret,"INF");
			if(nbop != 3 ){
				err = 1;
			}
		break;
		case SUP:
			strcpy(ret,"SUP");
			if(nbop != 3 ){
				err = 1;
			}
		break;
		case EQU:
			strcpy(ret,"EQU");
			if(nbop != 3 ){
				err = 1;
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
		printf("erreur dans le nombre d'argument du %s, il a %d arguments\n",ret,nbop );
	}
	return ret;
}