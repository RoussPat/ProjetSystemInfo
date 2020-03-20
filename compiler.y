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
%token tPV tV tADD tMUL tDIV tSUB tCP tOP tOB tCB tOA tCA tIE tSE tSUP tINF tEQ tAFC tNBFLOAT tTRUE tFALSE tMAIN tPRINTF tCONST tINT tFLOAT tBOOL tCHAR tNOT tNEQ tIF tWHILE tRETURN tQ
%token <nb> tNBINT
%token <str> tVAR
%type <nb> Expression

%%
%start File;
File:
    Main;
Main:
    tMAIN tOP tCP tOA Body Return tCA    {printf(" main ");};
Body:
    //epsilon    
    |{printf(" definition ");}  Definition Body                
    |{printf(" affectation ");} Affectation  Body              	
    |Print {printf(" print ");} Body 
	| tOA {increasedepth();} Body tCA {decreasedepth();};

// A FAIRE : if else while
	

Print:
    tPRINTF tOP String tCP Pv 
    |tPRINTF tOP tVAR tCP Pv;
String:
    tQ tVAR tQ ;                    

Definition:
    tINT tVAR DefinitionN Pv 
	| tCONST tINT tVAR DefinitionN Pv 
	| Constante ; 

Constante: 
	tCONST tINT tVAR DefinitionC Pv; 

DefinitionN:
    //epsilon
    |tV tVAR DefinitionN 			{add_symbol($2,0,0,1); printf ("Définition variable");}; 

DefinitionC:
    //epsilon
    |tV tVAR DefinitionN 			{add_symbol($2,1,0,1); printf ("Définition constante");}; 

Pv:
    tPV {printf("; \n");};

Affectation:
    tVAR tAFC {add_symbol($1,0,1,0/*recuperer le type*/); printf("AFC %d %d",0/* adresse ??? */,$1);} /* ATTENTION variable (pas constante)*/ Expression Pv; //j'aurais bien mis tINT au lieu de tVAR



Expression:
	tNBINT							{printf(" valeur int = %d",$1 );}
	|tCONST tVAR					{printf(" constante int ");}		//j'ai ajoute ca
	|tVAR							{printf(" variable int ");}
	|Expression tMUL Expression	    {printf(" MUL int ");}
	|Expression tDIV Expression	    {printf(" DIV int ");}
	|Expression tSUB Expression	    {printf(" SUB int ");}
	|Expression tADD Expression	    {printf(" ADD int ");}
	|tSUB Expression				{printf(" int negatif ");}
	|tOP Expression tCP				{printf(" (int) ");};
	
//tINT tID tEGAL Expression tPV { affectation($2,$4) }  ;

Return:
    tRETURN {printf(" return \n");} tOP Expression tCP     ;
%%
void yyerror(char * str){};
int main(){yyparse();return 0;}


/*
Boolean:
	tVAR							{printf("variable bool");}
    |tTRUE 							{printf("valeur bool");}
    |tFALSE							{printf("valeur bool");}
	|Boolean tEQ Boolean			{printf("operation bool");}
	|Boolean tNEQ Boolean			{printf("operation bool");}
	|Expression OpBool Expression	{printf("comparaison int -> bool");}
	|tNOT Boolean					{printf("not bool");};

OpBool:
	tEQ | tNEQ | tIE | tSE | tSUP | tINF ;*/

/*   |tVAR tEQ Boolean Pv			{printf("aff boolean");};*/
