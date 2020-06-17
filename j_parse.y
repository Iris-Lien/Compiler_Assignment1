%{
	#include <stdio.h>
	#include <stdlib.h>
	#include "j_lex.h"
	#include "j_parse.h"
%}

%token CLASS PUB STATIC
%left  AND OR
%left  LT LE EQ
%left  ADD MINUS
%left  TIMES
%token LBP RBP LSP RSP LP RP
%token INT
%token BOOLEAN
%token NOT TRUE FALSE
%token IF ELSE
%token WHILE PRINT
%token ASSIGN
%token VOID MAIN STR
%token RETURN
%token SEMI COMMA
%token THIS NEW DOT
%token ID LIT
%token COMMENT

%expect 32

%%
prog	:	mainc cdcls
		{ printf("Program -> MainClass ClassDecl*\n");
		  printf("Parsed OK!\n"); }
	|
		{ printf("****** Parsing failed!\n"); }	
	;

mainc	:	CLASS ID LBP PUB STATIC VOID MAIN LP STR LSP RSP ID RP LBP stmts RBP RBP
		{ printf("MainClass -> class id lbp public static void main lp string lsp rsp id rp lbp Statemet* rbp rbp\n"); }
	;

cdcls	:	cdcl cdcls
		{ printf("(for ClassDecl*) cdcls : cdcl cdcls\n"); }
	|
		{ printf("(for ClassDecl*) cdcls : \n"); }
	;

cdcl	:	CLASS ID LBP vdcls mdcls RBP
		{ printf("ClassDecl -> class id lbp VarDecl* MethodDecl* rbp\n"); }
	;

vdcls	:	vdcl vdcls
		{ printf("(for VarDecl*) vdcls : vdcl vdcls\n"); }
	|
		{ printf("(for VarDecl*) vdcls : \n"); }
	;

vdcl	:	type ID SEMI
		{ printf("VarDecl -> Type id semi\n"); }
	;

mdcls	:	mdcl mdcls
		{ printf("(for MethodDecl*) mdcls : mdcl mdcls\n"); }
	|
		{ printf("(for MethodDecl*) mdcls : \n"); }
	;

mdcl	:	PUB type ID LP formals RP LBP vdcls stmts RETURN exp SEMI RBP
		{ printf("MethodDecl -> public Type id lp FormalList rp lbp Statements* return Exp semi rbp\n"); }
	;

formals	:	type ID frest
		{ printf("FormalList -> Type id FormalRest*\n"); }
	|
		{ printf("FormalList -> \n"); }
	;

frest	:	COMMA type ID frest
		{ printf("FormalRest -> comma Type id FormalRest\n"); }
	|
		{ printf("FormalRest -> \n"); }
	;

// Write the grammar rules for type, statement, exp, explist, exprest

type : 	INT LSP RSP
		{ printf("TYPE -> INT LSP RSP \n"); }
	|	BOOLEAN
		{ printf("TYPE -> BOOLEAN \n"); }
	|	INT
		{ printf("TYPE -> INT \n"); }
	|	ID
		{ printf("TYPE -> ID \n"); }
	;

stmts : stmt stmts
		{ printf("(for Statements*) stmts : stmt stmts\n");}
	|
		{ printf("(for Statements*) stmts : \n");}
	;

stmt : LBP stmts RBP
		{ printf("Statement -> LBP stmts RBP\n");}
	|	IF LP exp RP stmt ELSE stmt
		{ printf("Statement -> IF LP exp RP stmt ELSE stmt\n"); }
	|	WHILE LP exp RP stmt
		{ printf("Statement -> WHILE LP exp RP stmt\n"); }
	|	PRINT LP exp RP SEMI
		{ printf("Statement -> PRINT LP exp RP SEMI\n"); }
	|	ID ASSIGN exp SEMI
		{ printf("Statement -> ID ASSIGN exp SEMI\n"); }
	|	ID LSP exp RSP ASSIGN exp SEMI
		{ printf("Statement -> ID LSP exp RSP ASSIGN exp SEMI\n"); }
	|	vdcl
		{ printf("Statement -> vdcl\n"); }
	;

exp : exp ADD exp
		{ printf("EXP -> exp ADD exp \n"); }
	|	exp MINUS exp
		{ printf("EXP -> exp MINUS exp \n"); }
	|	exp TIMES exp
		{ printf("EXP -> exp TIMES exp \n"); }
	|	exp AND exp
		{ printf("EXP -> exp AND exp \n"); }
	|	exp OR exp
		{ printf("EXP -> exp OR exp \n"); }
	|	exp LT exp
		{ printf("EXP -> exp LT exp \n"); }
	|	exp LE exp
		{ printf("EXP -> exp LE exp \n"); }
	|	exp EQ exp
		{ printf("EXP -> exp EQ exp \n"); }
	|	ID LSP exp RSP
		{ printf("EXP -> ID LSP exp RSP \n"); }
	|	ID LP explist RP
		{ printf("EXP -> ID LP explist RP \n"); }
	|	LP exp RP
		{ printf("EXP -> LP exp RP \n"); }
	|	exp DOT exp
		{ printf("EXP -> exp DOT exp \n"); }
	|	LIT
		{ printf("EXP -> LIT \n"); }
	|	TRUE
		{ printf("EXP -> TRUE \n"); }
	|	FALSE
		{ printf("EXP -> FALSE \n"); }
	|	ID
		{ printf("EXP -> ID \n"); }
	|	THIS
		{ printf("EXP -> THIS \n"); }
	|	NEW INT LSP exp RSP
		{ printf("EXP -> NEW INT LSP exp RSP \n"); }
	|	NEW ID LP RP
		{ printf("EXP -> NEW ID LP RP \n"); }
	|	NOT exp
		{ printf("EXP -> NOT exp  \n"); }
	;
	
explist : exp exprests
		{ printf("EXPLIST -> NOT exp \n"); }
	|	
		{ printf("EXPLIST -> \n"); }
	;

exprests : exprest exprests
		{ printf("(for ExpRests*) exprests : exprest exprests\n"); }
	|
		{ printf("(for ExpRests*) exprests : \n"); }
	;

exprest : COMMA exp
		{ printf("ExpRests -> COMMA exp\n"); }
	;

%%

int yyerror(char *s)
{
	printf("%s\n",s);
	return 1;
}

