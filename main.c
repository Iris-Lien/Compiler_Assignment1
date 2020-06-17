#include <stdio.h>
#include "j_lex.h"
#include "j_parse.h"

char name[16];
int val;

int main(int argc,char *argv[]) {
    int t;

    yyin = fopen(argv[1],"r");
    yyparse();
}
