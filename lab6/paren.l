%{
    #include "y.tab.h"
    #include <string.h>
    #include <stdio.h>
%}

%%
[ ]         ;
\n      {return '\n';}
"("     {return OPEN;}
"["     {return OPEN1;}
"{"     {return OPEN2;}
"<"     {return OPEN3;}
")"     {return CLOSE;}
"]"     {return CLOSE1;}
"}"     {return CLOSE2;}
">"     {return CLOSE3;}
%%




