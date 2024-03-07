%{
    #include<stdio.h>
    #include<string.h>
    struct tags{
        char name[10];
        int count;
    };
    struct tags T[100];
    int counter=0;

    int search(char* s){
        for(int i=0;i<100;i++)
            if(strcmp(s,T[i].name)==0)  return i;
        return -1;
    }
%}
%%
"<"[^>/]*>|"<"[^>/]*"/>" {
    char tag_name[100];
    for(int i=0;i<yyleng;i++){
        if(yytext[i]==' '||yytext[i]=='>'||yytext[i]=='/'){
            strncpy(tag_name,yytext+1,i-1);
            tag_name[i-1] = '\0';
            break;
        }
    }
    int idx = search(tag_name);
    if (idx != -1) {
        T[idx].count+=2;
    } else {
        strcpy(T[counter].name, tag_name);
        T[counter].count = 2;
        counter++;
    }
};
.   ;

%%

int yywrap(){}

int main(int argc,char** argv){
    yyin = fopen("index.html","r");
    yylex();
    for(int i=0;i<100;i++){
        if(strcmp(T[i].name,"")!=0)
            printf("tag: %s, count: %d\n",T[i].name, T[i].count);
    }
    fclose(yyin);

    return 0;
}