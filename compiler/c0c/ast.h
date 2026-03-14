#ifndef C0C_AST_H
#define C0C_AST_H

typedef enum {
    AST_FUNC, AST_DECL, AST_ASSIGN, AST_BINOP, AST_UNARY, AST_VAR, AST_NUM, AST_RETURN,
    AST_STR, AST_CALL, AST_EXPR_STMT, AST_IF, AST_WHILE, AST_FOR, AST_BREAK, AST_CONTINUE, AST_INCDEC,
    AST_ADDR, AST_DEREF, AST_INDEX, AST_SIZEOF, AST_BLOCK
} ASTNodeType;

typedef enum {
    TY_INT,
    TY_CHAR,
    TY_INT_PTR,
    TY_CHAR_PTR,
    TY_VOID
} CType;

typedef struct ASTNode {
    ASTNodeType type;
    CType ty;
    int val;
    char name[64];
    char str_val[256];
    int op;
    int array_len;
    int init_kind;
    int is_decl;
    struct ASTNode *left, *right;
    struct ASTNode *cond, *then_body, *else_body;
    struct ASTNode *init, *update, *body;
    int is_prefix;
    struct ASTNode *next;
} ASTNode;

ASTNode* new_node(ASTNodeType type);

#endif
