%{
#include <stdio.h>
#include <stdlib.h>
void yyerror(const char*);
int yylex();
extern FILE * yyin;
extern FILE * yyout;
%}

%union{
    char *string;
    double number;
}

%token <number> T_NUMBER
%token <string> T_FUNCTION
%token <string> T_VAR
%token T_ASSIGNMENT T_OUTPUT

%left '+' '-'
%left '*' '/'
%right U_neg

%%

Main:
      Assign
    | Main Assign
    | OutPut
    | Main OutPut
;

OutPut:
    T_OUTPUT T_VAR ';' { printf("OutPut %s\n\n", $2); }
;
Assign:
      T_VAR T_ASSIGNMENT Factor ';'
    | T_VAR T_ASSIGNMENT Function ';'
;

Function:
      T_FUNCTION '(' Factor ')' { printf("Function %s\n\n", $1); }
    | T_FUNCTION '(' Function ')' { printf("Function %s\n\n", $1); }
;
Factor:
      Expression
    |'(' Expression ')'
;
Expression:
    T_NUMBER '+' T_NUMBER                     { printf("=> %f\n", $1); }
|   T_NUMBER '-' T_NUMBER                     { printf("=> %f\n", $1); }
|   T_NUMBER '*' T_NUMBER                     { printf("=> %f\n", $1); }
|   T_NUMBER '/' T_NUMBER                     { printf("=> %f\n", $1); }
|   '-' T_NUMBER %prec U_neg           { printf("- %f\n", $2); }
|   T_NUMBER                    { printf("Number %f\n", $1); }
|   T_VAR                       { printf("Var %s\n", $1); }
;
%%
