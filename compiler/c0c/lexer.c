#include "lexer.h"
#include <ctype.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char *src;
char *p;
Token cur_tok;

void error(const char *msg) {
    fprintf(stderr, "編譯錯誤: %s\n", msg);
    exit(1);
}

void next_token(void) {
    // 忽略 UTF-8 BOM
    if (p == src && strncmp(p, "\xEF\xBB\xBF", 3) == 0) p += 3;

    while (1) {
        while (isspace((unsigned char)*p)) p++;
        if (strncmp(p, "//", 2) == 0) { while (*p != '\0' && *p != '\n') p++; continue; }
        if (strncmp(p, "/*", 2) == 0) {
            p += 2; while (*p != '\0' && strncmp(p, "*/", 2) != 0) p++;
            if (*p != '\0') p += 2; continue;
        }
        if (*p == '#') { while (*p != '\0' && *p != '\n') p++; continue; }
        break;
    }

    if (*p == '\0') { cur_tok.type = TK_EOF; return; }

    if (*p == '"') {
        p++;
        char *s = cur_tok.str_val;
        while (*p != '\0' && *p != '"') *s++ = *p++;
        *s = '\0';
        if (*p == '"') p++;
        cur_tok.type = TK_STR;
        return;
    }

    if (isalpha((unsigned char)*p) || *p == '_') {
        char *start = p;
        while (isalnum((unsigned char)*p) || *p == '_') p++;
        int len = p - start;
        strncpy(cur_tok.name, start, len);
        cur_tok.name[len] = '\0';

        if (strcmp(cur_tok.name, "int") == 0) cur_tok.type = TK_INT;
        else if (strcmp(cur_tok.name, "char") == 0) cur_tok.type = TK_CHAR;
        else if (strcmp(cur_tok.name, "void") == 0) cur_tok.type = TK_VOID;
        else if (strcmp(cur_tok.name, "return") == 0) cur_tok.type = TK_RETURN;
        else if (strcmp(cur_tok.name, "if") == 0) cur_tok.type = TK_IF;
        else if (strcmp(cur_tok.name, "else") == 0) cur_tok.type = TK_ELSE;
        else if (strcmp(cur_tok.name, "while") == 0) cur_tok.type = TK_WHILE;
        else if (strcmp(cur_tok.name, "for") == 0) cur_tok.type = TK_FOR;
        else if (strcmp(cur_tok.name, "break") == 0) cur_tok.type = TK_BREAK;
        else if (strcmp(cur_tok.name, "continue") == 0) cur_tok.type = TK_CONTINUE;
        else if (strcmp(cur_tok.name, "sizeof") == 0) cur_tok.type = TK_SIZEOF;
        else cur_tok.type = TK_IDENT;
        return;
    }

    if (isdigit((unsigned char)*p)) {
        cur_tok.val = strtol(p, &p, 10);
        cur_tok.type = TK_NUM;
        return;
    }

    if (*p == '\'') {
        p++;
        int ch = 0;
        if (*p == '\\') {
            p++;
            if (*p == 'n') { ch = '\n'; p++; }
            else if (*p == 't') { ch = '\t'; p++; }
            else if (*p == 'r') { ch = '\r'; p++; }
            else if (*p == '\\') { ch = '\\'; p++; }
            else if (*p == '\'') { ch = '\''; p++; }
            else { ch = (unsigned char)*p++; }
        } else {
            ch = (unsigned char)*p++;
        }
        if (*p == '\'') p++;
        cur_tok.val = ch;
        cur_tok.type = TK_CHAR_LIT;
        return;
    }

    if (p[0] == '=' && p[1] == '=') { cur_tok.type = TK_EQ; p += 2; return; }
    if (p[0] == '!' && p[1] == '=') { cur_tok.type = TK_NE; p += 2; return; }
    if (p[0] == '<' && p[1] == '=') { cur_tok.type = TK_LE; p += 2; return; }
    if (p[0] == '>' && p[1] == '=') { cur_tok.type = TK_GE; p += 2; return; }
    if (p[0] == '&' && p[1] == '&') { cur_tok.type = TK_ANDAND; p += 2; return; }
    if (p[0] == '|' && p[1] == '|') { cur_tok.type = TK_OROR; p += 2; return; }
    if (p[0] == '+' && p[1] == '+') { cur_tok.type = TK_PLUSPLUS; p += 2; return; }
    if (p[0] == '-' && p[1] == '-') { cur_tok.type = TK_MINUSMINUS; p += 2; return; }
    if (p[0] == '+' && p[1] == '=') { cur_tok.type = TK_PLUSEQ; p += 2; return; }

    cur_tok.type = (TokenType)(*p++);
}

void expect(TokenType type, const char *msg) {
    if (cur_tok.type == type) next_token();
    else error(msg);
}
