%{
#include <stdio.h>
%}

%token NUMBER ID
%left '+' '-'
%left '*' '/'

%% 
E : K	 {
				printf("Result = %d\n", $$);
				return 0;
			}

K : 
	K '+' K { $$ = $1 + $3; }
	| K '-' K { $$ = $1 - $3; }
	| K '*' K { $$ = $1 * $3; }
	| K '/' K { $$ = $1 / $3; }
	| '-' NUMBER { $$ = -$2; }
	| '-' ID { $$ = -$2; }
	| '(' K ')' { $$ = $2; }
	| NUMBER { $$ = $1; }
	| ID { $$ = $1; };
%%

int main() {
	printf("Enter the expression\n");
	yyparse();
}

/* For printing error messages */
int yyerror(char* s) {
	printf("\nExpression is invalid\n");
}
