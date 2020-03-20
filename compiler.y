%{
    #include <stdio.h>
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
    |Print {printf(" print ");} Body ;

Print:
    tPRINTF tOP String tCP Pv 
    |tPRINTF tOP tVAR tCP Pv;
String:
    tQ tVAR tQ ;                    

Definition:
    tINT tVAR DefinitionN Pv ;  
DefinitionN:
    //epsilon
    |tV tVAR DefinitionN 			{printf(" definitionN ");};
Pv:
    tPV {printf("; \n");};

Affectation:
    tVAR tAFC {printf(" aff int ");} Expression Pv			;
/*   |tVAR tEQ Boolean Pv			{printf("aff boolean");};*/

Expression:
	tNBINT							{printf(" valeur int = %d",$1 );}
	|tVAR							{printf(" variable int ");}
	|Expression tMUL Expression	    {printf(" MUL int ");}
	|Expression tDIV Expression	    {printf(" DIV int ");}
	|Expression tSUB Expression	    {printf(" SUB int ");}
	|Expression tADD Expression	    {printf(" ADD int ");}
	|tSUB Expression				{printf(" int negatif ");}
	|tOP Expression tCP				{printf(" (int) ");};
	
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
    
Return:
    tRETURN {printf(" return \n");} tOP Expression tCP     ;
%%
void yyerror(char * str){};
int main(){yyparse();return 0;}
