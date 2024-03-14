%{
    #include <stdio.h>
    #include "y.tab.h"
    extern int yylval;
%}

%%
SELECT          return SELECT;
FROM            return FROM;
AND			    return AND;
UPDATE			return UPDATE;
TRUNCATE        return TRUNCATE;
SET   			return SET;
VALUES 		    return VALUES;
DROP 			return DROP;
DATABASE 		return DATABASE;
DELETE 			return DELETE;
CREATE 			return CREATE;
TABLE 			return TABLE;
WHERE           return WHERE;
[*]             return *yytext;
[,]             return *yytext;
[=]             return EQUAL;
[a-zA-Z][a-zA-Z0-9]+    return ID;
\n              return *yytext;
[ \t]+              ;
%%