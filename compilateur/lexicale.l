%%
[ \t\n]							{}
";"								{ printf(" tPV");}
","								{ printf(" tV ");}

"+" 							{ printf(" tADD ");}
"*"								{ printf(" tMUL ");}
"/"								{ printf(" tDIV ");}
"-"								{ printf(" tSUB ");}

")"								{ printf(" tCP ");}
"("								{ printf(" tOP ");}
"["								{ printf(" tOB ");}
"]"								{ printf(" tCB ");}
"{"								{ printf(" tOA ");}
"}"								{ printf(" tCA ");}

"<="							{ printf(" tIE ");}
">="							{ printf(" tSE ");}
">"								{ printf(" tSUP ");}
"<"								{ printf(" tINF ");}
"=="							{ printf(" tEQ ");}
"="								{ printf(" tAFC ");}
"!="                            { printf(" tNEQ ");}
"!"                             { printf(" tNOT ");}


-?[0-9].[0-9]+e-?[0-9]+			{ printf(" tNBFLOAT ");}
-?[0-9]							{ printf(" tNBINT ");}
true 							{ printf(" tTRUE ");}
false							{ printf(" tFALSE ");}


main							{ printf(" tMAIN ");}
printf							{ printf(" tPRINTF ");}
if  							{ printf(" tIF ");}
while 							{ printf(" tWHILE ");}
return                          { printf(" tRETRUN ");}

const							{ printf(" tCONST ");}
int  							{ printf(" tINT ");}
float  							{ printf(" tFLOAT ");}
bool  							{ printf(" tBOOL ");}
char  							{ printf(" tCHAR ");}

[A-Za-z0-9_]+ 					{ printf(" tVAR ");}

%%

int yywrap(void) {return 1;}
int main () {while(yylex()!=0); return 0;}
