%{
    #include "y.tab.h"
%}
%%
[ \t\n]							{}
";"								{ return tPV;}
","								{ return tV ;}
"\""                            { return tQ ;}

"+" 							{ return tADD ;}
"*"								{ return tMUL ;}
"/"								{ return tDIV ;}
"-"								{ return tSUB ;}
                                
")"								{ return tCP ;}
"("								{ return tOP ;}
"["								{ return tOB ;}
"]"								{ return tCB ;}
"{"								{ return tOA ;}
"}"								{ return tCA ;}

"<="							{ return tIE ;}
">="							{ return tSE ;}
">"								{ return tSUP ;}
"<"								{ return tINF ;}
"=="							{ return tEQ ;}
"="								{ return tAFC ;}
"!="                            { return tNEQ ;}
"!"                             { return tNOT ;}


-?[0-9][.,][0-9]+e-?[0-9]+	    { yylval.nb = atof(yytext) ; return tNBFLOAT ;}
-?[0-9]+						{ yylval.nb = (int)atof(yytext) ; return tNBINT ;}
true 							{ return tTRUE ;}
false							{ return tFALSE ;}


main							{ return tMAIN ;}
printf							{ return tPRINTF ;}
if  							{ return tIF ;}
while 							{ return tWHILE ;}
return                          { return tRETURN ;}

const							{ return tCONST ;}
int  							{ return tINT ;}
float  							{ return tFLOAT ;}
bool  							{ return tBOOL ;}
char  							{ return tCHAR ;}

[A-Za-z0-9_]+ 					{ yylval.str = strdup(yytext) ; return tVAR ;}
. {printf("Oh no!!\n");}
%%

int yywrap(void) {return 1;}
