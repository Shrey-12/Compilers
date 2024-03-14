%{ 
	/* Definition section*/
	#include "y.tab.h" 
	extern yylval;
	int yywrap(){return 1;}
%}

%% 
[0-9]+ { 
			yylval = atoi(yytext); 
			return NUMBER; 
			} 

[a-zA-Z]+ { return ID; } 
[ \t]+		 ; /*For skipping whitespaces*/

\n		 { return 0; } 
.		 { return yytext[0]; } 

%% 
