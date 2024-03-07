%{
#include <stdio.h>
#include <string.h>
%}

%%

[aA]  { printf("%s Article\n", yytext); }
[aA][nN] { printf("%s Article\n", yytext);}
[tT][hH][eE] { printf("%s Article\n", yytext);}
[\t]+ 
\n { return 0; }
[A-Za-z]+    ;

%%

int yywrap() {
    return 1;
}

int main() {
    yylex();
    return 0;
}