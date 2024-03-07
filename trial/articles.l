%%

[aA]  { printf("%s Article\n", yytext); }
[aA][nN] { printf("%s Article\n", yytext);}
[tT][hH][eE] { printf("%s Article\n", yytext);}

\n { return 0; }
[a-zA-Z]+   ;

%%

int yywrap() {
    return 1;
}

int main() {
    yylex();
    return 0;
}