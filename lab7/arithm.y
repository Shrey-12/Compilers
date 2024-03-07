%{
    #include<stdio.h>
    int yyparse(void);
    int yylex(void);
    int yyerror(char *);
    int yywrap(void);
%}

%token NUMBER ID

%left '+' '-'
%left '*' '/'

%%
E:T     { 
    printf("Result = %d\n", $$);
    return 0;
}
T: T '+' T { $$ = $1 + $3;}
 |T '-' T { $$ = $1 - $3;}
 |T '*' T { $$ = $1 / $3;}
 |'-' NUMBER { $$ = -$2; }
 |'-' ID { $$ = -$2; }
 |'(' T ')' { $$ = $2; }
 |NUMBER { $$ = $1; }
 |ID { $$ = $1; };
%%

int main(){
    printf("Enter expression\n");
    yyparse();
    return 0;
}

int yyerror(char* s){
    printf("Expression is invalid\n");
}

int yywrap(){
    return 1;
}
