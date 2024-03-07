%%
[a-z] {printf("%c",yytext[0]);}
\n|.    ;
%%

int yywrap(){}
int main(){
    yylex();
    return 0;
}