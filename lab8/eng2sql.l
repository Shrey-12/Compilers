%{
#include "y.tab.h"
#include <string.h>
%}

%%

"Please"        { return PLZ; }
"give"          { return GIVE; }
"me"            { return ME; }
"the"           { return THE; }
"all"           { return ALL; }
"information"  { return INFO; }
"of"            { return OF; }
"students"       { return STUDENTS; }
"name"          { return NAME; }
"roll"           { yylval.str = strdup(yytext); return ROLL; }
"whose"         { return WHOSE; }
"set"            { return SET;}
"cpi"             { yylval.str = strdup(yytext); return CPI; }
"is"            { return IS; }
"more"          { return MORE; }
"to"            { return TO; }
"than"          { return THAN; }
"update"         { return UPDATE; }
"having"        { return HAVING; }
"and"            { return AND;}
"where"          {return WHERE;}
[=]              { return EQUAL;}
[0-9]+[.]?[0-9]*          { yylval.str = strdup(yytext); return NUMBER_VAL; }
[.]             {return FULLSTOP;}

.|\n             { /* ignore anything else */ }

%%
