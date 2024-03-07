%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>
    struct tag{
        char tag_name[10];
        int count;
    };
    struct tag tags[100];
%}

%%

[<]{1}[a-z|" "]+[>]{1} {
        yyleng++;
        strcat(yytext,"\0");
        int last = -1;
        for(int i=0; i< 100; i++){
            if(strcmp(yytext, tags[i].tag_name) == 0 || strcmp(tags[i].tag_name, "") == 0){
                last = i;
                break;
            }
        }
        strcpy(tags[last].tag_name, yytext);
        if(!tags[last].count)
            tags[last].count = 1;
        else
            tags[last].count ++;
        ECHO;
}

[<]{1}[ ]*[/][a-z|" "]+[>]{1} {
        yyleng++;
        strcat(yytext,"\0");
        ECHO;
}

. ;
 
%%

int yywrap(){}

int main(){
    yyin = fopen("input.html", "r");
    yylex();
    for(int i=0; i< 100; i++){
        if(strcmp(tags[i].tag_name, "")!=0)
            printf("tag: %s, count: %d\n",tags[i].tag_name, tags[i].count);
    }
 }