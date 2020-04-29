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
	int type; // 1 = int, 2 = float, 0 = char, ....
	int depth;
	int temp; // temporary or not
}symbol;


extern unsigned int stackpointer;
extern unsigned int temppointer;
extern symbol* tab;
extern int tablast;
extern int templast;
extern int tabsize;
extern int depth;


int init(int maxsize){
	tabsize = maxsize;
	tab = malloc(tabsize*sizeof(symbol));
	stackpointer =0;
	temppointer = maxsize;
	tablast = 0;
	templast = maxsize;
	depth = 0;
	return(0);
}


int exist_symbol_curdepth(char* id){
	int found =0;
	int index = tablast-1;
	int ret = 0;
	while((index >= 0) && !found){
		if((strcmp(tab[index].id,id)==0) && tab[index].depth == depth){
			ret = 1;
			found =1;
		}
		index --;
	}
	return ret;
}


int exist_symbol_alldepth(char* id){
	int found =0;
	int index = tablast-1;
	int ret = 0;
	while((index >= 0) && !found){
		if(strcmp(tab[index].id,id) == 0){
			ret = 1;
			found =1;
		}
		index --;
	}
	return ret;
}

unsigned int add_temp_var(int type){
	unsigned int ret = temppointer;
	int err = 0;
	if(tablast < templast -1){
		symbol s;
		s.id = malloc(sizeof("temp"));
		strcpy(s.id , "temp");
		s.constant = 0;
		s.initialized = 1;
		s.type = type;
		s.depth = depth;
		s.temp = 1;
		s.memory = temppointer;
		printf(";[temp_var] new var :  %s @ %d\n",s.id,temppointer);
		switch(type) {
			case 0: //char 1o
				temppointer = temppointer - 1;
			break;
			case 1: //int 4o
				temppointer = temppointer - 1;
			break;
			default:
				printf(";%s\n", "[add_temp_var] Type not recognised in symbol recognition \n" );
				err = 2;
		}
		
		if(err == 0){
			tab[templast] = s;
			templast --;
		}
	}
	else{
		printf(";%s\n", "[add_temp_var] Max symbol table size reached \n" );
		err = 1;
	}
	if(err != 0){
		return(-1);
	}
	else{
		return(ret);
	}
	
}


void initalize_var(char* id){
	int found =0;
	int index = tablast-1;
	while((index >= 0) && !found){
		if(strcmp(tab[index].id,id)==0){
			found =1;
			tab[index].initialized = 1;
		}
		index --;
	}
}


int add_symbol(char* id, int constant,int initialized, int type){
	int err = 0;
	//printf("tabsize : %d  tablast : %d  tablast +1 >= tabsize : %d\n",tabsize,tablast,tablast +1 < tabsize);
	if((tablast +1) < templast){
		symbol s;
		s.id = malloc(sizeof(strlen(id)+1));
		strcpy(s.id , id);
		s.constant = constant;
		s.initialized = initialized;
		s.type = type;
		s.depth = depth;
		s.temp = 0;
		s.memory = stackpointer;
		printf(";[add_symbol] new var :  %s @ %d\n",s.id,stackpointer);
		switch(type) {
			case 0: //char 1o
				stackpointer = stackpointer + 1;
			break;
			case 1: //int 4o
				stackpointer = stackpointer + 1;
			break;
			default:
				printf(";%s\n", "[add_symbol] Type not recognised in symbol recognition \n" );
				err = 2;
		}
		
		if(err == 0){
			tab[tablast] = s;
			tablast ++;
		}
	}
	else{
		printf(";%s\n", "[add_symbol] Max symbol table size reached\n" );
		err = 1;
	}
	return(err);
}


unsigned int find_symbol(char* id){
	int found =0;
	int index = tablast-1;
	unsigned int ret = -1;
	while((index >= 0) && !found){
		if(strcmp(id,"j")==0){
			printf("[DEBUG] depth: %d memory : %d name: %s \n",tab[index].depth,tab[index].memory,tab[index].id);
		}
		if(strcmp(tab[index].id,id)==0){
			ret = tab[index].memory;
			found =1;
		}
		index --;
	}
	return ret;
}


int var_is_const(char* id){
	int found =0;
	int index = tablast-1;
	int ret = -1;
	while((index >= 0) && !found){
		if(strcmp(tab[index].id,id)==0){
			ret = tab[index].constant;
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
	int index = tablast-1;
	while((index >= 0) && (tab[index].depth == depth)){
		printf(";delete de id : %s @ %d\n",tab[index].id,tab[index].memory);
		switch(tab[index].type) {
			case 0: //char 1o
				stackpointer = stackpointer - 1;
				tablast--;
			break;
			case 1: //int 4o
				stackpointer = stackpointer - 1;
				tablast--;
			break;
			default:
				printf(";%s\n", "This should not happend \n" );
		}
		index --;
	}
	depth --;
}

void delete_temp_var(){
	int index = templast+1;
	while(index <= tabsize){
		if(tab[index].temp != 0){
			printf(";delete de id : %s @ %d\n",tab[index].id,tab[index].memory);
			switch(tab[index].type) {
			case 0: //char 1o
				temppointer = temppointer + 1;
				templast ++;
			break;
			case 1: //int 4o
				temppointer = temppointer + 1;
				templast ++;
			break;
			default:
				printf(";%s\n", "This should not happend \n" );
			}
		}
	index ++;
	}
}
int getDepth() {
	return(depth);
}

