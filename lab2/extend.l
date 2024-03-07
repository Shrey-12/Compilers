%{
#include <stdio.h>
#include <string.h>

int comm_s = 0;
int comm_m = 0;
FILE *doc_file = NULL;

void write_doc_comment(char *comment) {
    if (doc_file != NULL) {
        fprintf(doc_file, "%s", comment);
    }
}
%}

comm_start [/]{1}[*]{1}
comm_end [*]{1}[/]{1}

%%

[/]{1}[/]{1} {
    if (!comm_m) {
        comm_s = 1;
    }
}

[/]{1}[*]{1} {
    if (!comm_m && !comm_s) {
        comm_m = 1;
        if (doc_file == NULL) {
            doc_file = fopen("output.txt", "w");
        }
    }
}

[*]{1}[/]{1} {
    if (comm_m) {
        comm_m = 0;
        write_doc_comment(yytext); 
    }
}

\n {
    if (!comm_m && comm_s) {
        comm_s = 0;
        ECHO;
    } else {
        ECHO;
        write_doc_comment("");  
    }
}

. {
    if (comm_m && !comm_s) {
        write_doc_comment(yytext); 
    }
    if (!comm_m && !comm_s) {
        ECHO;
    }
}
%%

int yywrap(void) {
    if (doc_file != NULL) {
        fclose(doc_file);
    }
    return 1;
}

int main() {
    extern FILE *yyin, *yyout;
    yyin = fopen("input.java", "r");
    yyout = fopen("output.java", "w");

    yylex();
    return 0;
}
