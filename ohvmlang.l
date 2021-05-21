%{
#include <stdlib.h>
#include "node.h"
#include "y.tab.h"

void yyerror(char *);
%}
/*------------------------------------------------------------*/
%%

"/*"([^\*]|(\*)*[^\*/])*(\*)*"*/" {}

"while"                { return WHILE; }
"if"                   { return IF; }
"else"                 { return ELSE; }
"print"                { return PRINT; }
"false"                { yylval.ivalue = 0; return INTEGER; }
"true"                 { yylval.ivalue = 1; return INTEGER; }
[a-z]                  { yylval.sindex = *yytext - 'a'; return VARIABLE; }
[0-9]+                 { yylval.ivalue = atoi(yytext); return INTEGER; }
[\+\-\*\/\(\)\%;{}=]   { return *yytext; }
":="                   { return ASSIGN; }
">="                   { return GE; }
"<="                   { return LE; }
">"                    { return GT; }
"<"                    { return LT; }
"=="                   { return EQ; }
"!="                   { return NE; }
"<>"                   { return NE; }
"&&"                   { return AND; }
"\|\|"                 { return OR; }
"!"                    { return NOT; }
[\t\n ]+               {}
.                      { printf("unknown symbol, char: %c, ascii: %d\n", *yytext, (int)*yytext); }

%%

int yywrap(void) {
    return 1;
}