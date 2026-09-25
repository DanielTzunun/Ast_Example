%{
#include "ast.h"
#include "parser.tab.h"
#include <string.h>
#include <stdlib.h>
%}

%option noyywrap

%%

[ \t\r\n]+             ; /* Skip whitespace */

"var"                  { return TOKEN_VAR; }
"const"                { return TOKEN_CONST; }
"int"                  { yylval.str_val = strdup(yytext); return TOKEN_TYPE; }
"char"                 { yylval.str_val = strdup(yytext); return TOKEN_TYPE; }
"bool"                 { yylval.str_val = strdup(yytext); return TOKEN_TYPE; }
"str"                  { yylval.str_val = strdup(yytext); return TOKEN_TYPE; }
"true"                 { yylval.int_val = 1; return TOKEN_BOOL_LITERAL; }
"false"                { yylval.int_val = 0; return TOKEN_BOOL_LITERAL; }

":"                    { return ':'; }
"="                    { return '='; }
";"                    { return ';'; }


\"([^\\\"]|\\.)*\"     {
                         /* Strip quotes */
                         yytext[yyleng - 1] = '\0';
                         yylval.str_val = strdup(yytext + 1);
                         return TOKEN_STRING_LITERAL;
                       }

'([^\\']|\\.)'       {
                         yytext[yyleng - 1] = '\0';
                         yylval.str_val = strdup(yytext + 1);
                         return TOKEN_STRING_LITERAL;
                       }

[0-9]+                 { yylval.int_val = atoi(yytext); return TOKEN_INT_LITERAL; }
[a-zA-Z_][a-zA-Z0-9_]* { yylval.str_val = strdup(yytext); return TOKEN_IDENTIFIER; }

.                      { fprintf(stderr, "Unexpected char: %s\n", yytext); }

%%
