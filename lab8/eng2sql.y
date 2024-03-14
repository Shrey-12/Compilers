%{
#include <stdio.h>
#include <stdlib.h>
extern int yylex();
void yyerror(const char *s);
int yywrap(){return 1;}
%}

%union {
    char* str;
};

%type <str> identifier
%token <str> PLZ GIVE ME ALL INFO THE OF AND TO
%token <str> STUDENTS NAME
%token <str> WHOSE 
%token <str> CPI 
%token <str> IS 
%token <str> MORE THAN 
%token <str> UPDATE 
%token <str> SET 
%token <str> EQUAL 
%token <str> WHERE HAVING
%token <str> ROLL 
%token <str> NUMBER_VAL FULLSTOP

%%

sentence : PLZ GIVE ME ALL INFO OF STUDENTS FULLSTOP
           { printf("SELECT * FROM Students;\n"); }
         | PLZ GIVE ME THE identifier AND identifier OF STUDENTS WHOSE CPI IS MORE THAN NUMBER_VAL FULLSTOP
           { printf("SELECT %s, %s FROM Students WHERE cpi > %s;", $5, $7,$15); }
         | PLZ UPDATE THE CPI OF THE STUDENTS HAVING ROLL NUMBER_VAL TO NUMBER_VAL FULLSTOP
           { printf("UPDATE Students SET cpi=%s where roll=%s",$12,$10); }
         | PLZ GIVE ME THE ROLL OF THE STUDENTS FULLSTOP
           { printf("SELECT roll FROM Students;\n"); }
         ;
identifier: ROLL
            | CPI
            | NAME

%%

void yyerror(const char *s) {
  fprintf(stderr, "Error: %s\n", s);
}

int main() {
  yyparse();
  return 0;
}