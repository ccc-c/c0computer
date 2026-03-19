
typedef enum {
TY_INT, TY_CHAR, TY_VOID, TY_FLOAT, TY_DOUBLE, 
TY_UCHAR, TY_SHORT, TY_USHORT, TY_UINT, TY_LONG, TY_ULONG,
TY_INT_PTR, TY_CHAR_PTR, TY_VOID_PTR, TY_FLOAT_PTR, TY_DOUBLE_PTR,
TY_UCHAR_PTR, TY_SHORT_PTR, TY_USHORT_PTR, TY_UINT_PTR, TY_LONG_PTR, TY_ULONG_PTR,
TY_STRUCT, TY_STRUCT_PTR
} CType;

typedef enum {
AST_NUM, AST_FLOAT, AST_STR, AST_VAR, AST_CALL, AST_ADDR, AST_DEREF,
AST_INDEX, AST_MEMBER, AST_BINOP, AST_UNARY, AST_CAST, AST_SIZEOF,
AST_INCDEC, AST_DECL, AST_ASSIGN, AST_EXPR_STMT, AST_BLOCK, AST_IF,
AST_WHILE, AST_FOR, AST_DO, AST_SWITCH, AST_CASE, AST_BREAK,
AST_CONTINUE, AST_RETURN, AST_FUNC, AST_GLOBAL
} ASTNodeType;

typedef struct ASTNode {
ASTNodeType type;
struct ASTNode *next;
struct ASTNode *left;
struct ASTNode *right;
struct ASTNode *cond;
struct ASTNode *then_body;
struct ASTNode *else_body;
struct ASTNode *body;
struct ASTNode *init;
struct ASTNode *update;

int op;
int val; // 也在函數中用來標記 is_vararg
double fval;
char name[64];
char str_val[256];

CType ty;
int array_len;
int struct_id;
int init_kind;
int is_default;
int is_prefix;
int is_decl; // 也用來標記 extern
} ASTNode;

typedef struct {
char name[64];
CType ty;
int offset;
int struct_id;
int array_len;
} StructField;

typedef struct {
char name[64];
int size;
StructField fields[64];
int field_cnt;
} StructDef;

extern StructDef g_struct_defs[64];
extern int g_struct_def_cnt;

ASTNode* new_node(ASTNodeType type);



typedef int size_t;

typedef enum {
TK_EOF, TK_INT, TK_CHAR, TK_VOID, TK_FLOAT, TK_DOUBLE, TK_UNSIGNED, TK_SHORT, TK_LONG, TK_CONST,
TK_STRUCT, TK_TYPEDEF, TK_RETURN, TK_IF, TK_ELSE, TK_WHILE, TK_FOR, TK_DO,
TK_SWITCH, TK_CASE, TK_DEFAULT, TK_BREAK, TK_CONTINUE,
TK_SIZEOF, TK_IDENT, TK_NUM, TK_FLOAT_LIT, TK_STR, TK_CHAR_LIT,
TK_EXTERN, TK_ENUM, TK_ELLIPSIS,
TK_ASSIGN = '=', TK_PLUS = '+', TK_MINUS = '-', TK_MUL = '*', TK_DIV = '/',
TK_MOD = '%', TK_LT = '<', TK_GT = '>', TK_NOT = '!', TK_LPAREN = '(', TK_RPAREN = ')',
TK_LBRACE = '{', TK_RBRACE = '}', TK_SEMI = ';', TK_COMMA = ',',
TK_EQ = 257, TK_NE, TK_LE, TK_GE, TK_ANDAND, TK_OROR, TK_PLUSPLUS, TK_MINUSMINUS,
TK_PLUSEQ, TK_MINUSEQ, TK_MULEQ, TK_DIVEQ, TK_MODEQ, TK_ARROW
} TokenType;

typedef struct {
TokenType type;
int val;
double fval;
char name[64];
char str_val[256];
} Token;

extern char *src;
extern char *p;
extern Token cur_tok;
extern int cur_line;
extern int cur_col;

void error(const char *msg);
void next_token(void);
void expect(TokenType type, const char *msg);



ASTNode* parse_program(void);


typedef int size_t;

void macro_init(void);
void macro_free(void);

int macro_parse_line(char *line, int line_num);
char *macro_expand(const char *input);
char *macro_expand_file(const char *filename);

void macro_define(const char *name, const char *replacement);
void macro_undef(const char *name);
int macro_defined(const char *name);

void macro_enable_expand(void);
void macro_disable_expand(void);


typedef void FILE;
extern void *stdin;
extern void *stdout;
extern void *stderr;
extern void *fopen(char *name, char *mode);
extern int fclose(void *f);
extern int fseek(void *f, long offset, int whence);
extern long ftell(void *f);
extern int fread(void *ptr, int size, int nmemb, void *f);
extern int fputs(char *s, void *f);
extern int printf(char *fmt, ...);
extern int sprintf(char *str, char *fmt, ...);
extern int snprintf(char *str, int size, char *fmt, ...);
extern int fprintf(void *f, char *fmt, ...);
extern void perror(char *s);

void gen_llvm_ir(ASTNode *funcs, FILE *out);

typedef void FILE;
extern void *stdin;
extern void *stdout;
extern void *stderr;
extern void *fopen(char *name, char *mode);
extern int fclose(void *f);
extern int fseek(void *f, long offset, int whence);
extern long ftell(void *f);
extern int fread(void *ptr, int size, int nmemb, void *f);
extern int fputs(char *s, void *f);
extern int printf(char *fmt, ...);
extern int sprintf(char *str, char *fmt, ...);
extern int snprintf(char *str, int size, char *fmt, ...);
extern int fprintf(void *f, char *fmt, ...);
extern void perror(char *s);
extern void *malloc(int size);
extern void *calloc(int nmemb, int size);
extern void free(void *ptr);
extern void exit(int status);
extern long strtol(char *nptr, char *endptr, int base);
extern double strtod(char *nptr, char *endptr);
extern int strlen(char *s);
extern char *strcpy(char *dest, char *src);
extern char *strncpy(char *dest, char *src, int n);
extern char *strcat(char *dest, char *src);
extern int strcmp(char *s1, char *s2);
extern int strncmp(char *s1, char *s2, int n);
extern char *strchr(char *s, int c);
extern char *strstr(char *haystack, char *needle);
extern char *strtok(char *str, char *delim);

int main(int argc, char **argv) {
int mode_expand_only = 0;
char *input_file = NULL;
char *output_file = NULL;

for (int i = 1; i < argc; i++) {
if (strcmp(argv[i], "-E") == 0) {
mode_expand_only = 1;
} else if (strcmp(argv[i], "-o") == 0) {
if (i + 1 < argc) {
output_file = argv[i + 1];
i++;
}
} else if (argv[i][0] != '-') {
input_file = argv[i];
}
}

if (!input_file) {
fprintf(stderr, "用法: ./c0c <input.c> [-o <output.ll>]   (編譯)\n");
fprintf(stderr, "       ./c0c <input.c> -E [-o <output.i>] (僅展開巨集)\n");
return 1;
}

if (mode_expand_only) {
char *expanded = macro_expand_file(input_file);
if (!expanded) {
fprintf(stderr, "無法展開巨集: %s\n", input_file);
return 1;
}

if (output_file) {
FILE *f = fopen(output_file, "w");
if (!f) {
perror("fopen output");
free(expanded);
return 1;
}
fputs(expanded, f);
fclose(f);
printf("[成功] 已展開巨集 %s 至 %s\n", input_file, output_file);
} else {
printf("%s", expanded);
}

free(expanded);
return 0;
}

FILE *f = fopen(input_file, "rb");
if (!f) {
fprintf(stderr, "無法開啟輸入檔案: %s\n", input_file);
exit(1);
}
fseek(f, 0, SEEK_END);
long fsize = ftell(f);
fseek(f, 0, SEEK_SET);
src = malloc(fsize + 1);
fread(src, 1, fsize, f);
src[fsize] = 0;
fclose(f);

char *expanded = macro_expand(src);
free(src);
src = expanded;

if (!output_file) {
output_file = "a.ll";
}

FILE *out = fopen(output_file, "w");
if (!out) {
fprintf(stderr, "無法開啟輸出檔案: %s\n", output_file);
exit(1);
}

p = src;
cur_line = 1;
cur_col = 1;
next_token();
ASTNode *ast = parse_program();
gen_llvm_ir(ast, out);

printf("[成功] 已將 %s 編譯至 %s\n", input_file, output_file);
fclose(out);
free(src);
return 0;
}
