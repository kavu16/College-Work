%{
#include <iostream>
#include <math.h>
#include <string>
#include <map>
#include "util.h"

std::map<std::string, double> vars;

int yylex(); 
void yyerror(const char *p) { std::cerr << "ERROR: undefined symbol" << std::endl; };
%}

%union {
    double dval;
    std::string* sval;
};

%start program_input

%token EOL
%token L_BRACKET R_BRACKET
%token FACTORIAL GBP_TO_USD USD_TO_GBP GBP_TO_EURO EURO_TO_GBP EURO_TO_USD USD_TO_EURO CEL_TO_FAH FAH_TO_CEL MI_TO_KM KM_TO_MI
%token SQRT ABS FLOOR CEIL COS SIN TAN LOG2 LOG10
%token ADD SUB MUL DIV POW MOD
%token VAR_KEYWORD EQUALS
%token <dval> NUMBER PI  
%token <sval> VARIABLE



%type <dval> expr constant function trig_function log_function conversion temp_conversion dist_conversion line calculation assignment

%left ADD SUB
%left MUL DIV MOD
%right POW
%nonassoc FACTORIAL GBP_TO_USD USD_TO_GBP GBP_TO_EURO EURO_TO_GBP EURO_TO_USD USD_TO_EURO CEL_TO_FAH FAH_TO_CEL MI_TO_KM KM_TO_MI SQRT ABS FLOOR CEIL COS SIN TAN LOG2 LOG10

%%

program_input : /* Epsilon */
              | program_input line      { std::cout << "=" << $2 << std::endl; }
              ;

line : EOL
     | calculation EOL
     ;

calculation : expr
            | assignment                { $$ = $1; }
            ;

constant : PI                           { $$ = 3.14; }
         ;

expr : SUB expr                         { $$ = -$2; }         
     | NUMBER                           
     | VARIABLE                         { $$ = vars[*$1]; }
     | constant
     | function
     | expr DIV expr                    { $$ = $1 / $3; }
     | expr MUL expr                    { $$ = $1 * $3; }
     | expr ADD expr                    { $$ = $1 + $3; }
     | expr SUB expr                    { $$ = $1 - $3; }
     | expr POW expr                    { $$ = pow($1,$3); }
     | expr MOD expr                    { $$ = modulo($1, $3); }
     | L_BRACKET expr R_BRACKET         { $$ = $2; }
     ;

function : conversion
         | log_function
         | trig_function
         | expr FACTORIAL               { $$ = factorial($1); }
         | SQRT expr                    { $$ = sqrt($2); }
         | ABS expr                     { $$ = abs($2); }
         | FLOOR expr                   { $$ = floor($2); }
         | CEIL expr                    { $$ = ceil($2); }
         ;

trig_function : COS expr                { $$ = cos($2); }
              | SIN expr                { $$ = sin($2); }
              | TAN expr                { $$ = tan($2); }
              ;

log_function : LOG2 expr                { $$ = log($2)/log(2); }
             | LOG10 expr               { $$ = log10($2); }
             ;

conversion : temp_conversion
           | dist_conversion
           | expr GBP_TO_USD            { $$ = gbp_to_usd($1); }
           | expr USD_TO_GBP            { $$ = usd_to_gbp($1); }
           | expr GBP_TO_EURO           { $$ = gbp_to_euro($1); }
           | expr EURO_TO_GBP           { $$ = euro_to_gbp($1); }
           | expr EURO_TO_USD           { $$ = euro_to_usd($1); }
           | expr USD_TO_EURO           { $$ = usd_to_euro($1); }
           ;

temp_conversion : expr CEL_TO_FAH       { $$ = cel_to_fah($1); }
                | expr FAH_TO_CEL       { $$ = fah_to_cel($1); }
                ;

dist_conversion : expr MI_TO_KM         { $$ = m_to_km($1); }
                | expr KM_TO_MI         { $$ = km_to_m($1); }
                ;

assignment : VAR_KEYWORD VARIABLE EQUALS calculation { vars[*$2] = $4; $$ = $4; }
           ;
%%

int main()
{
    yyparse(); // A parsing function that will be generated by Bison.
}
