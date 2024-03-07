%{
    #include <stdio.h>
%}

start \/\*
end \*\/

%%
\/\/(.*)    ;
[/][*][^*]*[*]+([^*/][^*]*[*]+)*[/] ;
%%

int yywrap(void) {
    return 1;
} 

int main(int argc,char **argv){
    yyin = fopen(argv[1],"r");
    yyout = fopen("out.java","w");
    yylex();
    fclose(yyin);
    fclose(yyout);
    return 0;
}