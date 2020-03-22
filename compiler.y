%{
    #include <stdio.h>
    #include "symboldepth.h"
    int yylex();
    void yyeror(char* str);
%}
%union{
    int nb;
    char* str;
}

%left tADD tSUB
%left tMUL tDIV
%token tPV tV tADD tMUL tDIV tSUB tCP tOP tOB tCB tOA tCA tIE tSE tSUP tINF tEQ tAFC tTRUE tFALSE tMAIN tPRINTF tCONST tINT tCHAR tNOT tNEQ tIF tWHILE tRETURN tQ
%token <nb> tNBINT
%token <str> tVAR
%type <nb> Expression
%type <str> String
%%
%start File;
File:
    {init(100); } Main;
Main:
    tMAIN {printf(" ;main \n");} tOP tCP tOA Body Return tCA    ;
Body:
    //epsilon    
    |Definition Body
    |Constante Body                
    |Affectation  Body              	
    |Print Body 
	| tOA {increasedepth();} Body tCA {decreasedepth();};

// A FAIRE : if else while
	

Print:
    tPRINTF tOP String tCP Pv 		{printf("PRI %s\n",$3);};

String:
    tQ tVAR tQ   					{$$ = $2;};

Definition:
    tINT tVAR 						{add_symbol($2,0,0,1); printf (";Definition int: %s\n", $2);} DefinitionN Pv ;

Constante: 
	tCONST tINT tVAR 				{add_symbol($3,1,0,1); printf (";Definition int constante: %s\n", $3);}   DefinitionC Pv; 

DefinitionN:
    //epsilon
    |tV tVAR DefinitionN 			{add_symbol($2,0,0,1); printf (";Definition int: %s\n", $2);}; 

DefinitionC:
    //epsilon
    |tV tVAR DefinitionN 			{add_symbol($2,1,0,1); printf (";Definition int constante: %s\n", $2);}; 

Pv:
    tPV /*{printf("; \n");}*/ ;

Affectation:
    tVAR tAFC Expression Pv   { if(exist_symbol_alldepth($1)){
							    	if(!(var_is_const($1))){
							    		initalize_var($1);
							    		printf("AFC %d %d\n",find_symbol($1),$3);
							    	}
							    }
    							delete_temp_var(); }; 
	//j'aurais bien mis tINT au lieu de tVAR   ||| Reponse : j'ai mis tVAR pcq on ne sais pas ce que c'est au moment de l'affectation, peut importe le type on affecte a une variable ||| j'ai changer des trucs



Expression:
	tNBINT							{$$ = $1;}
	//|tCONST tVAR					{printf(" constante int ");}		//j'ai ajoute ca ||| ya pas besoin, ce sera juste une variable avec un nom je crois pas qu'il y aie besoin de preciser que c'est une constante au moment d'utiliser la variable.
	|tVAR							{$$ = find_symbol($1);}
	|Expression tMUL Expression	    {$$ = add_temp_var(1); printf("MUL %d %d %d\n",$$,$1,$3);}
	|Expression tDIV Expression	    {$$ = add_temp_var(1); printf("DIV %d %d %d\n",$$,$1,$3);}
	|Expression tSUB Expression	    {$$ = add_temp_var(1); printf("SOU %d %d %d\n",$$,$1,$3);}
	|Expression tADD Expression	    {$$ = add_temp_var(1); printf("ADD %d %d %d\n",$$,$1,$3);}
	|tSUB Expression				{$$ = add_temp_var(1); printf("SOU %d 0 %d\n",$$,$2);}
	|tOP Expression tCP				{$$ = $2;}; // je vois pas ce qu'il y a a faire ici il faut gerer la prioroté des operations
	|tNOT Expression 				{$$ = add_temp_var(1); printf("NOT %d %d\n",$$,$2);}
	|Expression tEQ Expression		{$$ = add_temp_var(1); printf("EQU %d %d %d\n",$$,$1,$3);}
	|Expression tNEQ Expression		{$$ = add_temp_var(1); printf("NEQ %d %d %d\n",$$,$1,$3);}
	|Expression tIE Expression		{$$ = add_temp_var(1); printf("IEQ %d %d %d\n",$$,$1,$3);}
	|Expression tSUP Expression		{$$ = add_temp_var(1); printf("SUP %d %d %d\n",$$,$1,$3);}
	|Expression tINF Expression		{$$ = add_temp_var(1); printf("INF %d %d %d\n",$$,$1,$3);}
	|Expression tSE Expression 		{$$ = add_temp_var(1); printf("SEQ %d %d %d\n",$$,$1,$3);};
//tINT tID tEGAL Expression tPV { affectation($2,$4) }  ;

Return:
    tRETURN {printf(" return \n");} tOP Expression tCP     ;
%%
void yyerror(char * str){};
int main(){yyparse();return 0;}

