#include "symboldepth.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

typedef struct symbol_t{
	char * id;
	int constant; //constant or not
	int initialized; // initialized or not
	unsigned int memory; // adresse memoire
	int type; // 0 = int, 1 = float, 2 = char, ....
	int depth;
}symbol;


unsigned int stackpointer;
symbol* tab;
int tablast;
int tabsize;
int depth;


int init(int maxsize){
	tabsize = maxsize;
	tab = malloc(tabsize*sizeof(symbol));
	stackpointer =0;
	tablast = 0;
	depth = 0;
}


int exist_symbol_curdepth(char* id){
	int found =0;
	int index = tablast;
	int ret = 0;
	while((index > 0) && !found){
		if(strcmp(tab[index].id,id) && tab[index].depth == depth){
			ret = 1;
			found =1;
		}
		index --;
	}
	return ret;
}


int exist_symbol_alldepth(char* id){
	int found =0;
	int index = tablast;
	int ret = 0;
	while((index > 0) && !found){
		if(strcmp(tab[index].id,id)){
			ret = 1;
			found =1;
		}
		index --;
	}
	return ret;
}


int add_symbol( char* id, int constant,int initialized, int type){
	int err = 0;
	if(tablast +1 < tabsize){
		symbol s;
		s.id = malloc(sizeof(id));
		strcpy(s.id , id);
		s.constant = constant;
		s.initialized = initialized;
		s.type = type;
		s.depth = depth;
		s.memory = stackpointer;
		switch(type) {
			case 0: //char 1o
				stackpointer = stackpointer + 1;
			break;
			case 1: //int 4o
				stackpointer = stackpointer + 4;
			break;
			case 2: //float 4o
				stackpointer = stackpointer + 4;
			break;
			default:
				printf("%s\n", "Type not recognised in symbol recognition \n" );
				err = 2;
		}
		
		if(err == 0){
			tab[tablast] = s;
			tablast ++;
		}
	}
	else{
		printf("%s\n", "Max symbol table size reached\n" );
		err = 1;
	}
	return(err);
}


unsigned int find_symbol(char* id){
	int found =0;
	int index = tablast;
	unsigned int ret = -1;
	while((index > 0) && !found){
		if(strcmp(tab[index].id,id)){
			ret = tab[index].memory;
			found =1;
		}
		index --;
	}
	return ret;
}


void increasedepth(){
	depth ++;
}


void decreasedepth(){
	int index = tablast;
	while((index > 0) & tab[index].depth == depth){
		switch(tab[index].type) {
			case 0: //char 1o
				stackpointer = stackpointer - 1;
			break;
			case 1: //int 4o
				stackpointer = stackpointer - 4;
			break;
			case 2: //float 4o
				stackpointer = stackpointer - 4;
			break;
			default:
				printf("%s\n", "This should not happend \n" );
		}
	}
	tablast = index;
}
