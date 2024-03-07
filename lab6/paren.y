%{
    #include<stdio.h>
    void yyerror(char *);
    int yylex(void);
    int yywrap(void);
%}

%union
{
    char str;
};

%type <str> S A
%token <str> OPEN CLOSE OPEN1 CLOSE1 OPEN2 CLOSE2 OPEN3 CLOSE3
%token <str> '\n'

%%
LINE:S '\n'         {
    printf("Well formed parenthesis\n");
    return 0;
    }
;
S:A
 |A S
 |OPEN S CLOSE S
 |OPEN1 S CLOSE1 S
 |OPEN2 S CLOSE2 S
 |OPEN3 S CLOSE3 S
;

A:OPEN CLOSE
 |OPEN1 CLOSE1
 |OPEN2 CLOSE2
 |OPEN3 CLOSE3
 |
 ;
%%

int yywrap(){
    return 1;
}

void yyerror(char* msg){
    printf("\nError: %s",msg);
}

int main(){
    printf("Enter the expression:\n");
    yyparse();
    return 0;
}