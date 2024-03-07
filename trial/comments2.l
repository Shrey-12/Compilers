%{
    #include<stdio.h>
    int m,s=0;
%}
START "/*"
END "*/"

%%
"//" {if(!m)   s=1;}
{START}     {if(!s && !m)   m = 1;}
{END}       {if(!s && m)    m=0;}
\n      {if(!m && s)    s=0;}
.       {if(!s && !m) ECHO;}

%%

int yywrap(){}

int main(int argc, char** argv){
    yyin = fopen(argv[1],"r");
    yyout = fopen("output.java","w");
    yylex();
    fclose(yyin);
    fclose(yyout);
    return 0;
}