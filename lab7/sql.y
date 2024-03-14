%{
#include <stdio.h>

void yyerror(const char *str) {
    fprintf(stderr, "error: %s\n", str);
}
int yyparse(void);
int yylex(void);

int yywrap() {
    return 1;
}

int main() {
    yyparse();
}
%}

%token SELECT FROM ID WHERE AND UPDATE SET VALUES DELETE DROP DATABASE CREATE TABLE EQUAL TRUNCATE;

%%
command:
    selectCommand '\n' { printf("HELLO Select Command\n"); return 0; } |
    updateCommand '\n' { printf("Update Command\n"); return 0; } |
    dropCommand '\n' { printf("Drop Command\n"); return 0; } |
    createCommand '\n' { printf("CREATE Command\n"); return 0; } |
    TRUNCATE TABLE ID { printf("TRUNCATE Command\n"); return 0;}
    ;

selectCommand:
    SELECT items fromClause whereClause {printf("In Select");}
    ;

updateCommand:
    UPDATE ID SET updateCondition {printf("In Update");}
    ;

dropCommand:
    DROP tabledb ID
    ;

createCommand:
    CREATE tabledb ID
    ;

tabledb:
    TABLE | DATABASE
    ;

fromClause:
    FROM ID {printf("In from");}
    ;

items:
    '*' | identifiers
    ;

identifiers:
    ID | ID ',' identifiers
    ;

whereClause:
    WHERE condition {printf("In where");}
    |
    ;

updateCondition:
    condition WHERE condition {printf("In Update Condition");}
    ;

condition:
    ID EQUAL ID {printf("In update condition");} 
    | ID EQUAL ID AND condition
    |
    ;

%%

