%{
#include <stdio.h>
int comm_s = 0;
int comm_m = 0;
%}

comm_start [/]{1}[*]{1}
comm_end [*]{1}[/]{1}

%%

[/]{1}[/]{1} {
    if (!comm_m)
        comm_s = 1; 
}

[/]{1}[*]{1} {
    if (!comm_m && !comm_s)
        comm_m = 1;
}

[*]{1}[/]{1} {
    if (comm_m)
       comm_m = 0;
}

\n {
    if (!comm_m && comm_s)     
        comm_s = 0;
}

. {
    if (!comm_m && !comm_s)
        ECHO;
}

%%

int yywrap(void) {
    return 1;
} 

int main() {
    extern FILE *yyin, *yyout;
    yyin = fopen("input.java", "r");
    yyout = fopen("output.java", "w");
    
    yylex();
    return 0;
}
