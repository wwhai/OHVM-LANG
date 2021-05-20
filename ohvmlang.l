%{
    #include <string.h>
    #include "y.tab.h"
    int cur_line = 1;
    void yyerror(const char *msg);
    void unrecognized_char(char c);
%}

OPERATOR        ([-/+*()=,;])
NUMBER          ([1-9][0-9]*)|0|([0-9]+\.[0-9]*)
VAR             ([a-z][_a-z0-9]*)
FUNCTION        ([A-Z][_A-Z0-9]*)
WHITESPACE      ([ \t]*)
ASSIGNMENT      (":=")
OUTPUT          (">:")
%%
{OPERATOR}      { return yytext[0]; }
{NUMBER}        { yylval.number = atoi(yytext); return T_NUMBER; }
{VAR}           { yylval.string = yytext; return T_VAR; }
{FUNCTION}      { yylval.string = yytext; return T_FUNCTION; }
{WHITESPACE}    {}
{ASSIGNMENT}    { return T_ASSIGNMENT;}
{OUTPUT}        { return T_OUTPUT;}
\n              { cur_line++; }
.               { unrecognized_char(yytext[0]); }
%%

int yywrap(void) {
    return 1;
}

void unrecognized_char(char c) {
    char buf[32] = "Unrecognized character: ?";
    buf[24] = c;
    yyerror(buf);
}

void yyerror(const char *msg) {
    printf("Error at line %d:\n\t%s\n", cur_line, msg);
    exit(-1);
}
//
int main(int argc, char const *argv[])
{
    if(argc == 1){
        printf("Help:\n  ohvmlang <filepath>\n");
        return 0;
    }
    FILE* fp=fopen(argv[1], "r");
	if(fp == NULL)
	{
		printf("cannot open %s\n", argv[1]);
		return -1;
	}
	yyin=fp;
	yyparse();
	fclose(fp);
	return 0;
}