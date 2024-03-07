%{
#include<stdio.h>
int lc=0,sc=0,ch=0,wc=0,eol=0;	
%}

%%
[\n] { lc++; ch+=yyleng;eol++;}
[ \t] { sc++; ch+=yyleng;}
[^\t\n ]+ { wc++; ch+=yyleng;} 
%%

int yywrap(){ return 1; }


int main(int argc, char *argv[]) {
    if (argc != 2) {
        fprintf(stderr, "Usage: %s <input_file>\n", argv[0]);
        return 1;
    }

    // Open the file for reading
    FILE *file = fopen(argv[1], "r");
    if (file == NULL) {
        perror("Error opening file");
        return 1;
    }

    // Set yyin to the file stream
    yyin = file;

    printf("Enter the Sentence : ");
    yylex();
    printf("Number of lines : %d\n", lc);
    printf("Number of spaces : %d\n", sc);
    printf("Number of words, charc : %d , %d\n", wc, ch);
    printf("Number of end of lines : %d\n", eol);

    // Close the file
    fclose(file);

    return 0;
}
