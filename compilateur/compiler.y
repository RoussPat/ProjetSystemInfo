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
%token tPV tV tADD tMUL tDIV tSUB tCP tOP tOB tCB tOA tCA tIE tSE tSUP tINF tEQ tAFC tTRUE tFALSE tMAIN tPRINTF tCONST tINT tCHAR tNOT tRETURN tQ
%token <nb> tNBINT <nb> tIF <nb> tWHILE <nb> tELSE <nb> tNEQ
%token <str> tVAR
%type <nb> Expression
%type <nb> IfBlock
%%
%start File;
File:
    {init(255); initTable();} Main;
Main:
    tMAIN tOP tCP tOA Body /*Return*/ tCA {writefulltable();};
Body:
    %empty //epsilon
    |Definition Body
    |Constante Body
    |Affectation  Body
    |Print Body 
	|tWHILE tOP Expression tCP tOA {increasedepth(); $1=getcurline(); addline(JMF,($3),-1,-1);} Body tCA {addline(JMP,$1-1,-1,-1);update_element($1,-2,getcurline(),-2);decreasedepth();} Body

	|IfBlock tELSE tOA  {update_element($1,-2,getcurline()+1,-2);increasedepth();$2=getcurline();addline(JMP,-1,-1,-1);} Body tCA {update_element($2,getcurline(),-2,-2);decreasedepth();} Body

	|IfBlock {update_element($1,-2,getcurline(),-2);} Body;
	
IfBlock:
	tIF tOP Expression tCP tOA {increasedepth();$1=getcurline();addline(JMF,($3),-1,-1);} Body tCA {$$=$1;}
;


Print:
    tPRINTF tOP tVAR tCP Pv 		{if(exist_symbol_alldepth($3)){
										addline(PRI,find_symbol($3),-1,-1);
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
    tPV;

Affectation:
    tVAR tAFC Expression Pv   { if(exist_symbol_alldepth($1)){
							    	if(!(var_is_const($1))){
							    		initalize_var($1);
										addline(COP,find_symbol($1),$3,-1);
							    	}
							    }
    							delete_temp_var(); }; 


Expression:
	tNBINT							{$$ = add_temp_var(1); addline(AFC,$$,$1,-1);}

	|tVAR							{$$ = find_symbol($1);}
	|Expression tMUL Expression	    {$$ = add_temp_var(1); addline(MUL,$$,$1,$3);}

	|Expression tDIV Expression	    {$$ = add_temp_var(1); addline(DIV,$$,$1,$3);}

	|Expression tSUB Expression	    {$$ = add_temp_var(1);addline(SOU,$$,$1,$3);}

	|Expression tADD Expression	    {$$ = add_temp_var(1);addline(ADD,$$,$1,$3);}

	|tSUB Expression				{$$ = add_temp_var(1);addline(AFC,$$,0,-1);addline(SOU,$$,$$,$2);}

	|tOP Expression tCP				{$$ = $2;}; 

	|tNOT Expression 				{$$ = add_temp_var(1);addline(AFC,$$,0,-1);addline(EQU,$$,$2,$$);}

	|Expression tEQ Expression		{$$ = add_temp_var(1);addline(EQU,$$,$1,$3);}

	|Expression tNEQ Expression		{$$ = add_temp_var(1); addline(EQU,$2,$1,$3); addline(AFC,$$,0,-1); addline(EQU,$$,$2,$$); }

	|Expression tIE Expression		{$$ = add_temp_var(1); addline(AFC,$$,1,-1); addline(ADD,$$,$$,$3); addline(INF,$$,$1,$$);}

	|Expression tSUP Expression		{$$ = add_temp_var(1);addline(SUP,$$,$1,$3);}

	|Expression tINF Expression		{$$ = add_temp_var(1);addline(INF,$$,$1,$3);}

	|Expression tSE Expression 		{$$ = add_temp_var(1); addline(AFC,$$,1,-1); addline(SOU,$$,$3,$$); addline(SUP,$$,$1,$$);}

%%
void yyerror(char * str){
	printf("Erreur de parsing\n");};
int main(){yyparse();return 0;}

