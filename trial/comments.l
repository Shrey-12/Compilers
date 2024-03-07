%{
    #include<stdio.h>
    FILE* docs = NULL;
%}
%x COMMENT
%x DOCUMENTATION

%%
"//".* ;
"/*"    { BEGIN COMMENT; }
"/**"   { BEGIN DOCUMENTATION; }
<COMMENT>"*/"   {BEGIN INITIAL; }
<DOCUMENTATION>"*/" {BEGIN INITIAL;}
<COMMENT>.  ;
<DOCUMENTATION>.   {fprintf(docs,yytext);} 
%%

int yywrap(){}

int main(int argc, char** argv){
    yyin = fopen(argv[1],"r");
    yyout = fopen("output.java","w");
    docs = fopen("docs.txt","w");
    yylex();
    fclose(yyin);
    fclose(yyout);
    fclose(docs);
    return 0;
}