%{
#include <stdio.h>
#include <stdlib.h>

int yylex(void);
void yyerror(const char *s);

void emit(const char *instr);
void emit2(const char *instr, int arg);
%}

%token NUM
%left '+' '-'
%left '*' '/'
%nonassoc UMINUS

%%

program:
    /* vazio */
  | program expr '\n'  { emit("print"); emit("halt"); printf("\n"); }
  ;

expr:
    NUM               { emit2("pushi", $1); }
  | expr '+' expr     { emit("popr1"); emit("popr0"); emit("add"); emit("push"); }
  | expr '-' expr     { emit("popr1"); emit("popr0"); emit("sub"); emit("push"); }
  | expr '*' expr     { emit("popr1"); emit("popr0"); emit("mul"); emit("push"); }
  | expr '/' expr     { emit("popr1"); emit("popr0"); emit("div"); emit("push"); }
  | '(' expr ')'      { /* já tratado */ }
  | '-' expr %prec UMINUS { emit2("pushi", 0); emit("popr1"); emit("popr0"); emit("sub"); emit("push"); }
  ;
%%

void emit(const char *instr) {
    if (strcmp(instr, "halt") == 0) printf("00 ");
    else if (strcmp(instr, "add") == 0) printf("01 ");
    else if (strcmp(instr, "sub") == 0) printf("02 ");
    else if (strcmp(instr, "mul") == 0) printf("03 ");
    else if (strcmp(instr, "div") == 0) printf("04 ");
    else if (strcmp(instr, "push") == 0) printf("05 ");
    else if (strcmp(instr, "popr0") == 0) printf("06 ");
    else if (strcmp(instr, "popr1") == 0) printf("07 ");
    else if (strcmp(instr, "print") == 0) printf("08 ");
    else fprintf(stderr, "ERRO: instrução desconhecida %s\n", instr);
}

void emit2(const char *instr, int arg) {
    if (strcmp(instr, "pushi") == 0) printf("12 %d ", arg);
    else fprintf(stderr, "ERRO: instrução 2-palavras %s\n", instr);
}

void yyerror(const char *s) {
    fprintf(stderr, "Erro: %s\n", s);
}

int main(void) {
    return yyparse();
}
