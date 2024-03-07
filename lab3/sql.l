%{
    #include<stdio.h>
    int ddl = 0;
    int dml = 0;
%}

%%
CREATE|ALTER|DROP   {ddl++;}
SELECT|INSERT|UPDATE|DELETE     {dml++;}
.|\n    ;
%%

int yywrap(){}

int main(int argc,char** argv){
    yyin=fopen(argv[1],"r");
    yylex();
    printf("DDL Queries: %d\n",ddl);
    printf("DML Queries: %d\n",dml);
    fclose(yyin);
    return 0;
}