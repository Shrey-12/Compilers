%{
#include <stdio.h>
#include <string.h>
%}

%%

[aA]  { printf("%s Article\n", yytext);  }
[aA][nN] { printf("%s Article\n", yytext); }
[tT][hH][eE] { printf("%s Article\n", yytext); }
[iI][sS] {printf("%s Verb\n", yytext);}
[sS][hH][aA][lL][lL] {printf("%s Verb\n", yytext);}
[dD][aA][nN][cC][eE] {printf("%s Verb\n", yytext);}
[sS][iI][nN][gG] {printf("%s Verb\n", yytext);}
[eE][aA][tT] {printf("%s Verb\n", yytext);}
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