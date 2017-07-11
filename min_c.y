%{
#include <stdio.h>
#include <string.h>

void yyerror(const char *str) {
fprintf(stderr,"error %s\n",str);
}

int yywrap() {
return 1
}

extern FILE *yyin;

static int return_code;

void write_skeleton() {
FILE *out = fopen("out.s", "wb");

fprintf(out, ".text\n");
fprintf(out, "        .global_start\n\n");
fprintf(out, "_start:\n");

fprintf(out, "   movl   $%d, %%ebx\n", return_code);
fprintf(out, "   int    $0x80\n");

fclose(out);
}

int main(int arc, char *argv[]) {
++argv, --argc;
if(argc > 0) {
yyin = fopen(argv[0], "r");
}
else {
yyin = stdin;
}

yyparse();

write_skeleton();
printf("Written out.s.\n");
printf("Build it with:\n");
printf("   $ as work.s -o work.o\n");
printf("   $ ld -s -o work work.o\n");

return 0;
}

%}

%token INCLUDE HEADER_NAME
%token TYPE IDENTIDIER RETURN NUMBER
%token OPEN_BRACE CLOSE_BRACE

%%

program:
	header function
	;

header:
	INCLUDE HEADER_NAME
	;

function:
	TYPE IDENTIFIER '(' ')' OPEN_BRACE expression CLOSE_BRACE
	;

expression:
	RETURN NUMBER ';'
	{ return_code = $2; }
	;
