%{
    #include<stdio.h>
    int cc=0,wc=0,sc=0,eol=0;
%}
%%
[\n] {eol++;}
[ \t]   {sc++;}
[^\t\n ]+ {wc++;cc+=yyleng;}

%%
int yywrap(){
}
int main(int argc,char* argv[]){
    if(argc!=2){
        fprintf(stderr,"Usage %s <input.txt>",argv[0]);
        return 1;
    }
    FILE* f = fopen(argv[1],"r");
    if(f==NULL){
        perror("error opening file");
        return 1;
    }
    yyin = f;
    printf("Enter the sentence: ");
    yylex();
    printf("char count: %d\tword count: %d\t space count: %d\t end of line count: %d\t",cc,wc,sc,eol);
    fclose(f);
    return 0;
}