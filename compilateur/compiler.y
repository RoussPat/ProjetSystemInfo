%{
    #include <stdio.h>
	#include <stdlib.h>
    #include "symboldepth.h"
	#include "asm.h"
    int yylex();
    void yyerror(char* str);
	int yydebug = 0;
	int curentTable;
%}
%union{
    int nb;
    char* str;
}


%left tADD tSUB
%left tMUL tDIV
%token tPV tV tADD tMUL tDIV tSUB tCP tOP tOB tCB tOA tCA tIE tSE tSUP tINF tEQ tAFC tTRUE tFALSE tMAIN tPRINTF tCONST tINT tCHAR tNOT tNEQ tRETURN tQ
%token <nb> tNBINT <nb> tIF <nb> tWHILE <nb> tELSE
%token <str> tVAR
%type <nb> Expression
%%
%start File;
File:
    {init(255); initTable();} Main;
Main:
    tMAIN /*{printf(" ;main \n");}*/ tOP tCP tOA Body /*Return*/ tCA {writefulltable(0);};
Body:
    %empty //epsilon
    |Definition Body
    |Constante Body
    |Affectation  Body
    |Print Body 
	|tWHILE tOP Expression tCP tOA {increasedepth(); $1=getcurline(); addline(JMF,($3),-1,-1);} Body tCA {decreasedepth();addline(JMP,$1-1,-1,-1);update_element($1,-2,getcurline(),-2);} Body

	|tIF tOP Expression tCP tOA {increasedepth();$1=getcurline();addline(JMF,($3),-1,-1);} Body tCA tELSE tOA  {$9=getcurline();addline(JMP,-1,-1,-1),update_element($1,-2,getcurline(),-2);} Body tCA {decreasedepth();update_element($9,getcurline()+1,-2,-2);} Body

	|tIF tOP Expression tCP tOA {increasedepth();$1=getcurline();addline(JMF,($3),-1,-1);
} Body tCA {decreasedepth();update_element($1,-2,getcurline()+1,-2);} Body;
	

Print:
    tPRINTF tOP tVAR tCP Pv 		{if(exist_symbol_alldepth($3)){
										addline(PRI,find_symbol($3),-1,-1);
										//printf("PRI %d\n",find_symbol($3));
										}
									};

Definition:
    tINT tVAR 						{add_symbol($2,0,0,1);} DefinitionN Pv ;

Constante: 
	tCONST tINT tVAR 				{add_symbol($3,1,0,1); }   DefinitionC Pv; 

DefinitionN:
    %empty//epsilon
    |tV tVAR DefinitionN 			{add_symbol($2,0,0,1); }; 

DefinitionC:
    %empty//epsilon
    |tV tVAR DefinitionN 			{add_symbol($2,1,0,1); }; 

Pv:
    tPV /*{printf("; \n");}*/ ;

Affectation:
    tVAR tAFC Expression Pv   { if(exist_symbol_alldepth($1)){
							    	if(!(var_is_const($1))){
							    		initalize_var($1);
										addline(COP,find_symbol($1),$3,-1);
							    		//printf("COP %d %d\n",find_symbol($1),$3);
							    	}
							    }
    							delete_temp_var(); }; 


Expression:
	tNBINT							{$$ = add_temp_var(1); addline(AFC,$$,$1,-1); 															/*printf("AFC %d %d\n",$$,$1);*/}

	|tVAR							{$$ = find_symbol($1);}
	|Expression tMUL Expression	    {$$ = add_temp_var(1); addline(MUL,$$,$1,$3); 															/*printf("MUL %d %d %d\n",$$,$1,$3);*/}
	|Expression tDIV Expression	    {$$ = add_temp_var(1); addline(DIV,$$,$1,$3); 															/*printf("DIV %d %d %d\n",$$,$1,$3);*/}
	|Expression tSUB Expression	    {$$ = add_temp_var(1);addline(SOU,$$,$1,$3);													/*printf("SOU %d %d %d\n",$$,$1,$3);*/}
	|Expression tADD Expression	    {$$ = add_temp_var(1);addline(ADD,$$,$1,$3);													/*printf("ADD %d %d %d\n",$$,$1,$3);*/}
//	|tSUB Expression				{$$ = add_temp_var(1);addline(SOU,$$,0,$2); 															/*printf("SOU %d 0 %d\n",$$,$2);*/}
	|tOP Expression tCP				{$$ = $2;}; 

//	|tNOT Expression 				{$$ = add_temp_var(1);addline(NOT,$$,$2,-1); 														/*printf("NOT %d %d\n",$$,$2);}*/
	|Expression tEQ Expression		{$$ = add_temp_var(1);addline(EQU,$$,$1,$3); 														/*printf("EQU %d %d %d\n",$$,$1,$3);*/}
//	|Expression tNEQ Expression		{$$ = add_temp_var(1);addline(NEQ,$$,$1,$3); }
														/*printf("NEQ %d %d %d\n",$$,$1,$3);*/
//	|Expression tIE Expression		{$$ = add_temp_var(1);addline(IEQ,$$,$1,$3); 														/*printf("IEQ %d %d %d\n",$$,$1,$3);*/}
	|Expression tSUP Expression		{$$ = add_temp_var(1);addline(SUP,$$,$1,$3); 														/*printf("SUP %d %d %d\n",$$,$1,$3);*/}
	|Expression tINF Expression		{$$ = add_temp_var(1);addline(INF,$$,$1,$3); 														/*printf("INF %d %d %d\n",$$,$1,$3);*/}
//	|Expression tSE Expression 		{$$ = add_temp_var(1);addline(SEQ,$$,$1,$3); 														/*printf("SEQ %d %d %d\n",$$,$1,$3);*/};

%%
void yyerror(char * str){
	printf("Erreur de parsing\n");};
int main(){yyparse();return 0;}

