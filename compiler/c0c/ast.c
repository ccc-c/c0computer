#include "ast.h"
#include <stdlib.h>

ASTNode* new_node(ASTNodeType type) {
    ASTNode *n = calloc(1, sizeof(ASTNode));
    n->type = type;
    return n;
}
