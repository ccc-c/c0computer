#include "lexer.h"
#include <ctype.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char *src;
char *p;
Token cur_tok;
int cur_line = 1;
int cur_col = 1;

static void advance_char(void) {
    if (*p == '\0') return;
    if (*p == '\n') { cur_line++; cur_col = 1; }
    else cur_col++;
    p++;
}

void error(const char *msg) {
    fprintf(stderr, "編譯錯誤(%d:%d): %s\n", cur_line, cur_col, msg);
    exit(1);
}

void next_token(void) {
    // 忽略 UTF-8 BOM
    if (p == src && strncmp(p, "\xEF\xBB\xBF", 3) == 0) { advance_char(); advance_char(); advance_char(); }

    while (1) {
        while (isspace((unsigned char)*p)) advance_char();
        if (strncmp(p, "//", 2) == 0) { while (*p != '\0' && *p != '\n') advance_char(); continue; }
        if (strncmp(p, "/*", 2) == 0) {
            advance_char(); advance_char();
            while (*p != '\0' && strncmp(p, "*/", 2) != 0) advance_char();
            if (*p != '\0') { advance_char(); advance_char(); }
            continue;
        }
        if (*p == '#') { while (*p != '\0' && *p != '\n') advance_char(); continue; }
        break;
    }

    if (*p == '\0') { cur_tok.type = TK_EOF; return; }

    if (*p == '"') {
        advance_char();
        char *s = cur_tok.str_val;
        while (*p != '\0' && *p != '"') {
            if (*p == '\\') {
                advance_char();
                if (*p == 'n') { *s++ = '\n'; advance_char(); }
                else if (*p == 't') { *s++ = '\t'; advance_char(); }
                else if (*p == 'r') { *s++ = '\r'; advance_char(); }
                else if (*p == '\\') { *s++ = '\\'; advance_char(); }
                else if (*p == '"') { *s++ = '"'; advance_char(); }
                else { *s++ = *p; advance_char(); }
            } else {
                *s++ = *p;
                advance_char();
            }
        }
        *s = '\0';
        if (*p == '"') advance_char();
        cur_tok.type = TK_STR;
        return;
    }

    if (isalpha((unsigned char)*p) || *p == '_') {
        char *start = p;
        while (isalnum((unsigned char)*p) || *p == '_') advance_char();
        int len = p - start;
        strncpy(cur_tok.name, start, len);
        cur_tok.name[len] = '\0';

        if (strcmp(cur_tok.name, "int") == 0) cur_tok.type = TK_INT;
        else if (strcmp(cur_tok.name, "char") == 0) cur_tok.type = TK_CHAR;
        else if (strcmp(cur_tok.name, "void") == 0) cur_tok.type = TK_VOID;
        else if (strcmp(cur_tok.name, "struct") == 0) cur_tok.type = TK_STRUCT;
        else if (strcmp(cur_tok.name, "typedef") == 0) cur_tok.type = TK_TYPEDEF;
        else if (strcmp(cur_tok.name, "return") == 0) cur_tok.type = TK_RETURN;
        else if (strcmp(cur_tok.name, "if") == 0) cur_tok.type = TK_IF;
        else if (strcmp(cur_tok.name, "else") == 0) cur_tok.type = TK_ELSE;
        else if (strcmp(cur_tok.name, "while") == 0) cur_tok.type = TK_WHILE;
        else if (strcmp(cur_tok.name, "for") == 0) cur_tok.type = TK_FOR;
        else if (strcmp(cur_tok.name, "do") == 0) cur_tok.type = TK_DO;
        else if (strcmp(cur_tok.name, "switch") == 0) cur_tok.type = TK_SWITCH;
        else if (strcmp(cur_tok.name, "case") == 0) cur_tok.type = TK_CASE;
        else if (strcmp(cur_tok.name, "default") == 0) cur_tok.type = TK_DEFAULT;
        else if (strcmp(cur_tok.name, "break") == 0) cur_tok.type = TK_BREAK;
        else if (strcmp(cur_tok.name, "continue") == 0) cur_tok.type = TK_CONTINUE;
        else if (strcmp(cur_tok.name, "sizeof") == 0) cur_tok.type = TK_SIZEOF;
        else cur_tok.type = TK_IDENT;
        return;
    }

    if (isdigit((unsigned char)*p)) {
        char *start = p;
        cur_tok.val = strtol(p, &p, 10);
        cur_col += (int)(p - start);
        cur_tok.type = TK_NUM;
        return;
    }

    if (*p == '\'') {
        advance_char();
        int ch = 0;
        if (*p == '\\') {
            advance_char();
            if (*p == 'n') { ch = '\n'; advance_char(); }
            else if (*p == 't') { ch = '\t'; advance_char(); }
            else if (*p == 'r') { ch = '\r'; advance_char(); }
            else if (*p == '\\') { ch = '\\'; advance_char(); }
            else if (*p == '\'') { ch = '\''; advance_char(); }
            else { ch = (unsigned char)*p; advance_char(); }
        } else {
            ch = (unsigned char)*p; advance_char();
        }
        if (*p == '\'') advance_char();
        cur_tok.val = ch;
        cur_tok.type = TK_CHAR_LIT;
        return;
    }

    if (p[0] == '=' && p[1] == '=') { cur_tok.type = TK_EQ; advance_char(); advance_char(); return; }
    if (p[0] == '!' && p[1] == '=') { cur_tok.type = TK_NE; advance_char(); advance_char(); return; }
    if (p[0] == '<' && p[1] == '=') { cur_tok.type = TK_LE; advance_char(); advance_char(); return; }
    if (p[0] == '>' && p[1] == '=') { cur_tok.type = TK_GE; advance_char(); advance_char(); return; }
    if (p[0] == '&' && p[1] == '&') { cur_tok.type = TK_ANDAND; advance_char(); advance_char(); return; }
    if (p[0] == '|' && p[1] == '|') { cur_tok.type = TK_OROR; advance_char(); advance_char(); return; }
    if (p[0] == '+' && p[1] == '+') { cur_tok.type = TK_PLUSPLUS; advance_char(); advance_char(); return; }
    if (p[0] == '-' && p[1] == '-') { cur_tok.type = TK_MINUSMINUS; advance_char(); advance_char(); return; }
    if (p[0] == '-' && p[1] == '>') { cur_tok.type = TK_ARROW; advance_char(); advance_char(); return; }
    if (p[0] == '+' && p[1] == '=') { cur_tok.type = TK_PLUSEQ; advance_char(); advance_char(); return; }

    cur_tok.type = (TokenType)(*p);
    advance_char();
}

void expect(TokenType type, const char *msg) {
    if (cur_tok.type == type) next_token();
    else error(msg);
}
