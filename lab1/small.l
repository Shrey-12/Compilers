%{
#include <stdio.h>
%}

%%
[a-z] { printf("%c\t", yytext[0]); }
\n   ; 
.    ; 
%%

int yywrap(void) {
    return 1;
}

int main(void) {
    yylex();
    return 0;
}
