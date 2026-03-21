#include <stdio.h>
#include <stdlib.h>
#include "num0ad.h"

int main() {
    double d1[2] = {1, 2};
    int shape[1] = {2};
    Num0AD *a = num0ad_create_from_data(1, shape, d1);
    Num0AD *b = num0ad_create_from_data(1, shape, d1);
    Num0AD *c = num0ad_add(a, b);
    num0ad_backward(c);
    printf("a->grad: %f, %f\n", a->grad[0], a->grad[1]);
    printf("b->grad: %f, %f\n", b->grad[0], b->grad[1]);
    num0ad_free_all(c);
    return 0;
}
