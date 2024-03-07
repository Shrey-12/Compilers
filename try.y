%{
#include<stdio.h>
#include<stdlib.h>
%}
%token A B NL
%%
start: S NL { return 0;}
;
S: A S B |
;
%%
int main()
{ printf("enter string\n");
if (yyparse()==0)

printf("\nValid string");
}
yyerror()
{
printf("\n Not accepted");
exit(0);
}
int yywrap()
{
return 1;
}