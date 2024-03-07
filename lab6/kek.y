%{
#include <stdio.h>

int yyparse(void);
int yylex(void);

void yyerror (const char *str) {
	fprintf(stderr, "error: %s\n", str);
}

int yywrap() {
	return 1;
}

int main() {
	yyparse();
}

%}

%token ARTICLE NOUN PRONOUN VERB ADVERB ADJECTIVE PREPOSITION CONJUNCTION HELPINGVERB

%%

sentence: 
  subject VERB ARTICLE object
  | subject HELPINGVERB ARTICLE ADJECTIVE object
  | subject VERB ADVERB
  | subject VERB ARTICLE ADJECTIVE object
  { printf("Sentence is valid.\n"); }
  ;

subject: 
  NOUN | 
  PRONOUN
  ;

object: 
  NOUN
  ;

%%