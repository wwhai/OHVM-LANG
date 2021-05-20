%{
#include <stdio.h>
#include <stdlib.h>
void yyerror(const char*);
int yylex();
%}

%union{
    char *string;
    double number;
}

%token <number> T_NUMBER
%token <string> T_FUNCTION
%token <string> T_VAR
%token T_ASSIGNMENT

%left '+' '-'
%left '*' '/'
%right U_neg

%%

Main:
    Stmt          { }
    |   Main Stmt { }
;

Stmt: Assign { }
;

Assign:
    T_VAR T_ASSIGNMENT Factor ';'
    | T_VAR T_ASSIGNMENT Function ';'
;

Function:
    T_FUNCTION '(' Factor ')' { printf("Function %s\n\n", $1); }
;
Factor: Expression
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
