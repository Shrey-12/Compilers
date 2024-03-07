%{
#include <stdio.h>
#include <string.h>
int lineno=0;
%}

%%
^(.*) { printf("%4d\t%s", lineno++, yytext); }
%%
int yywrap(void) {
    return 1;
} 
int main(int argc, char *argv[]) {
    yyin = fopen(argv[1], "r");
    yylex();
    fclose(yyin);
}
