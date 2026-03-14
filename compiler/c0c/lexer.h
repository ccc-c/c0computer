#ifndef C0C_LEXER_H
#define C0C_LEXER_H

#include <stddef.h>

typedef enum {
    TK_EOF, TK_INT, TK_CHAR, TK_VOID, TK_RETURN, TK_IF, TK_ELSE, TK_WHILE, TK_FOR, TK_BREAK, TK_CONTINUE,
    TK_SIZEOF, TK_IDENT, TK_NUM, TK_STR, TK_CHAR_LIT,
    TK_ASSIGN = '=', TK_PLUS = '+', TK_MINUS = '-', TK_MUL = '*', TK_DIV = '/',
    TK_MOD = '%', TK_LT = '<', TK_GT = '>', TK_NOT = '!', TK_LPAREN = '(', TK_RPAREN = ')',
    TK_LBRACE = '{', TK_RBRACE = '}', TK_SEMI = ';', TK_COMMA = ',',
    TK_EQ = 257, TK_NE, TK_LE, TK_GE, TK_ANDAND, TK_OROR, TK_PLUSPLUS, TK_MINUSMINUS, TK_PLUSEQ
} TokenType;

typedef struct {
    TokenType type;
    int val;
    char name[64];
    char str_val[256];
} Token;

extern char *src;
extern char *p;
extern Token cur_tok;

void error(const char *msg);
void next_token(void);
void expect(TokenType type, const char *msg);

#endif
