%{
#include "expr.tab.h"
%}

%%

[0-9]+      { yylval = atoi(yytext); return NUM; }
[\n]        { return '\n'; }
[ \t\r]+    ;   // ignora espaços
[-+*/()]    { return yytext[0]; }

.           { /* ignora qualquer outro caractere */ }

%%
