#include <stdio.h>
#include <assert.h>
#include <math.h>
#include "num0.h"

void test_create() {
    int shape[2] = {3, 4};
    Num0 *arr = num0_create(2, shape);
    assert(arr->ndim == 2);
    assert(arr->shape[0] == 3);
    assert(arr->shape[1] == 4);
    num0_free(arr);
    printf("test_create passed\n");
}

void test_zeros() {
    int shape[2] = {2, 3};
    Num0 *arr = num0_zeros(2, shape);
    assert(num0_total_size(arr) == 6);
    for (int i = 0; i < 6; i++) assert(fabs(arr->data[i]) < 1e-9);
    num0_free(arr);
    printf("test_zeros passed\n");
}

void test_ones() {
    int shape[2] = {2, 3};
    Num0 *arr = num0_ones(2, shape);
    assert(num0_total_size(arr) == 6);
    for (int i = 0; i < 6; i++) assert(fabs(arr->data[i] - 1.0) < 1e-9);
    num0_free(arr);
    printf("test_ones passed\n");
}

void test_randn() {
    int shape[1] = {10};
    Num0 *arr = num0_randn(1, shape);
    assert(num0_total_size(arr) == 10);
    num0_free(arr);
    printf("test_randn passed\n");
}

void test_arange() {
    Num0 *arr = num0_arange(0, 10, 1);
    assert(arr->shape[0] == 10);
    for (int i = 0; i < 10; i++) assert(fabs(arr->data[i] - i) < 1e-9);
    num0_free(arr);
    printf("test_arange passed\n");
}

void test_add() {
    double d1[3] = {1, 2, 3};
    double d2[3] = {4, 5, 6};
    int shape[1] = {3};
    Num0 *a = num0_create_from_data(1, shape, d1);
    Num0 *b = num0_create_from_data(1, shape, d2);
    Num0 *c = num0_add(a, b);
    assert(fabs(c->data[0] - 5) < 1e-9);
    assert(fabs(c->data[1] - 7) < 1e-9);
    assert(fabs(c->data[2] - 9) < 1e-9);
    num0_free(a); num0_free(b); num0_free(c);
    printf("test_add passed\n");
}

void test_add_scalar() {
    double d1[3] = {1, 2, 3};
    double d2[1] = {10};
    int shape1[1] = {3}, shape2[1] = {1};
    Num0 *a = num0_create_from_data(1, shape1, d1);
    Num0 *b = num0_create_from_data(1, shape2, d2);
    Num0 *c = num0_add(a, b);
    assert(fabs(c->data[0] - 11) < 1e-9);
    assert(fabs(c->data[1] - 12) < 1e-9);
    assert(fabs(c->data[2] - 13) < 1e-9);
    num0_free(a); num0_free(b); num0_free(c);
    printf("test_add_scalar passed\n");
}

void test_sub() {
    double d1[3] = {5, 6, 7};
    double d2[3] = {1, 2, 3};
    int shape[1] = {3};
    Num0 *a = num0_create_from_data(1, shape, d1);
    Num0 *b = num0_create_from_data(1, shape, d2);
    Num0 *c = num0_sub(a, b);
    assert(fabs(c->data[0] - 4) < 1e-9);
    assert(fabs(c->data[1] - 4) < 1e-9);
    assert(fabs(c->data[2] - 4) < 1e-9);
    num0_free(a); num0_free(b); num0_free(c);
    printf("test_sub passed\n");
}

void test_mul() {
    double d1[3] = {1, 2, 3};
    double d2[3] = {4, 5, 6};
    int shape[1] = {3};
    Num0 *a = num0_create_from_data(1, shape, d1);
    Num0 *b = num0_create_from_data(1, shape, d2);
    Num0 *c = num0_mul(a, b);
    assert(fabs(c->data[0] - 4) < 1e-9);
    assert(fabs(c->data[1] - 10) < 1e-9);
    assert(fabs(c->data[2] - 18) < 1e-9);
    num0_free(a); num0_free(b); num0_free(c);
    printf("test_mul passed\n");
}

void test_div() {
    double d1[3] = {6, 8, 10};
    double d2[3] = {2, 4, 5};
    int shape[1] = {3};
    Num0 *a = num0_create_from_data(1, shape, d1);
    Num0 *b = num0_create_from_data(1, shape, d2);
    Num0 *c = num0_div(a, b);
    assert(fabs(c->data[0] - 3) < 1e-9);
    assert(fabs(c->data[1] - 2) < 1e-9);
    assert(fabs(c->data[2] - 2) < 1e-9);
    num0_free(a); num0_free(b); num0_free(c);
    printf("test_div passed\n");
}

void test_neg() {
    double d1[3] = {1, -2, 3};
    int shape[1] = {3};
    Num0 *a = num0_create_from_data(1, shape, d1);
    Num0 *b = num0_neg(a);
    assert(fabs(b->data[0] - (-1)) < 1e-9);
    assert(fabs(b->data[1] - 2) < 1e-9);
    assert(fabs(b->data[2] - (-3)) < 1e-9);
    num0_free(a); num0_free(b);
    printf("test_neg passed\n");
}

void test_exp() {
    double d1[1] = {0};
    int shape[1] = {1};
    Num0 *a = num0_create_from_data(1, shape, d1);
    Num0 *b = num0_exp(a);
    assert(fabs(b->data[0] - 1.0) < 1e-6);
    num0_free(a); num0_free(b);
    printf("test_exp passed\n");
}

void test_log() {
    double d1[1] = {2.718281828};
    int shape[1] = {1};
    Num0 *a = num0_create_from_data(1, shape, d1);
    Num0 *b = num0_log(a);
    assert(fabs(b->data[0] - 1.0) < 1e-4);
    num0_free(a); num0_free(b);
    printf("test_log passed\n");
}

void test_relu() {
    double d1[5] = {-3, -1, 0, 2, 5};
    int shape[1] = {5};
    Num0 *a = num0_create_from_data(1, shape, d1);
    Num0 *b = num0_relu(a);
    assert(fabs(b->data[0]) < 1e-9);
    assert(fabs(b->data[1]) < 1e-9);
    assert(fabs(b->data[2]) < 1e-9);
    assert(fabs(b->data[3] - 2) < 1e-9);
    assert(fabs(b->data[4] - 5) < 1e-9);
    num0_free(a); num0_free(b);
    printf("test_relu passed\n");
}

void test_abs() {
    double d1[3] = {-1, -2, 3};
    int shape[1] = {3};
    Num0 *a = num0_create_from_data(1, shape, d1);
    Num0 *b = num0_abs(a);
    assert(fabs(b->data[0] - 1) < 1e-9);
    assert(fabs(b->data[1] - 2) < 1e-9);
    assert(fabs(b->data[2] - 3) < 1e-9);
    num0_free(a); num0_free(b);
    printf("test_abs passed\n");
}

void test_sqrt() {
    double d1[1] = {4};
    int shape[1] = {1};
    Num0 *a = num0_create_from_data(1, shape, d1);
    Num0 *b = num0_sqrt(a);
    assert(fabs(b->data[0] - 2) < 1e-9);
    num0_free(a); num0_free(b);
    printf("test_sqrt passed\n");
}

void test_pow() {
    double d1[1] = {3};
    int shape[1] = {1};
    Num0 *a = num0_create_from_data(1, shape, d1);
    Num0 *b = num0_pow(a, 2);
    assert(fabs(b->data[0] - 9) < 1e-9);
    num0_free(a); num0_free(b);
    printf("test_pow passed\n");
}

void test_sum() {
    double d1[5] = {1, 2, 3, 4, 5};
    int shape[1] = {5};
    Num0 *a = num0_create_from_data(1, shape, d1);
    Num0 *s = num0_sum(a);
    assert(fabs(s->data[0] - 15) < 1e-9);
    num0_free(a); num0_free(s);
    printf("test_sum passed\n");
}

void test_mean() {
    double d1[4] = {1, 2, 3, 4};
    int shape[1] = {4};
    Num0 *a = num0_create_from_data(1, shape, d1);
    Num0 *m = num0_mean(a);
    assert(fabs(m->data[0] - 2.5) < 1e-9);
    num0_free(a); num0_free(m);
    printf("test_mean passed\n");
}

void test_max() {
    double d1[5] = {1, 5, 3, 2, 4};
    int shape[1] = {5};
    Num0 *a = num0_create_from_data(1, shape, d1);
    Num0 *m = num0_max(a);
    assert(fabs(m->data[0] - 5) < 1e-9);
    num0_free(a); num0_free(m);
    printf("test_max passed\n");
}

void test_argmax() {
    double d1[5] = {1, 5, 3, 2, 4};
    int shape[1] = {5};
    Num0 *a = num0_create_from_data(1, shape, d1);
    int idx = num0_argmax(a);
    assert(idx == 1);
    num0_free(a);
    printf("test_argmax passed\n");
}

void test_matmul() {
    double a_data[6] = {1, 2, 3, 4, 5, 6};
    double b_data[6] = {1, 2, 3, 4, 5, 6};
    int a_shape[2] = {2, 3};
    int b_shape[2] = {3, 2};
    Num0 *a = num0_create_from_data(2, a_shape, a_data);
    Num0 *b = num0_create_from_data(2, b_shape, b_data);
    Num0 *c = num0_matmul(a, b);
    assert(c->shape[0] == 2 && c->shape[1] == 2);
    assert(fabs(c->data[0] - 22) < 1e-9);
    assert(fabs(c->data[1] - 28) < 1e-9);
    assert(fabs(c->data[2] - 49) < 1e-9);
    assert(fabs(c->data[3] - 64) < 1e-9);
    num0_free(a); num0_free(b); num0_free(c);
    printf("test_matmul passed\n");
}

void test_dot() {
    double a_data[3] = {1, 2, 3};
    double b_data[3] = {4, 5, 6};
    int shape[1] = {3};
    Num0 *a = num0_create_from_data(1, shape, a_data);
    Num0 *b = num0_create_from_data(1, shape, b_data);
    Num0 *c = num0_dot(a, b);
    assert(fabs(c->data[0] - 32) < 1e-9);
    num0_free(a); num0_free(b); num0_free(c);
    printf("test_dot passed\n");
}

void test_reshape() {
    double d1[6] = {1, 2, 3, 4, 5, 6};
    int shape1[1] = {6};
    int shape2[2] = {2, 3};
    Num0 *a = num0_create_from_data(1, shape1, d1);
    Num0 *b = num0_reshape(a, 2, shape2);
    assert(b->ndim == 2);
    assert(b->shape[0] == 2);
    assert(b->shape[1] == 3);
    assert(fabs(b->data[0] - 1) < 1e-9);
    num0_free(a); num0_free(b);
    printf("test_reshape passed\n");
}

void test_flatten() {
    double d1[6] = {1, 2, 3, 4, 5, 6};
    int shape[2] = {2, 3};
    Num0 *a = num0_create_from_data(2, shape, d1);
    Num0 *b = num0_flatten(a);
    assert(b->ndim == 1);
    assert(b->shape[0] == 6);
    num0_free(a); num0_free(b);
    printf("test_flatten passed\n");
}

void test_transpose() {
    double d1[6] = {1, 2, 3, 4, 5, 6};
    int shape[2] = {2, 3};
    Num0 *a = num0_create_from_data(2, shape, d1);
    Num0 *b = num0_transpose(a);
    assert(b->shape[0] == 3 && b->shape[1] == 2);
    assert(fabs(b->data[0] - 1) < 1e-9);
    assert(fabs(b->data[1] - 4) < 1e-9);
    num0_free(a); num0_free(b);
    printf("test_transpose passed\n");
}

void test_slice() {
    double d1[10] = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9};
    int shape[1] = {10};
    Num0 *a = num0_create_from_data(1, shape, d1);
    Num0 *b = num0_slice(a, 2, 5);
    assert(b->shape[0] == 3);
    assert(fabs(b->data[0] - 2) < 1e-9);
    assert(fabs(b->data[1] - 3) < 1e-9);
    assert(fabs(b->data[2] - 4) < 1e-9);
    num0_free(a); num0_free(b);
    printf("test_slice passed\n");
}

void test_concat() {
    double d1[3] = {1, 2, 3};
    double d2[3] = {4, 5, 6};
    int shape[1] = {3};
    Num0 *a = num0_create_from_data(1, shape, d1);
    Num0 *b = num0_create_from_data(1, shape, d2);
    Num0 *arrs[2] = {a, b};
    Num0 *c = num0_concat(arrs, 2);
    assert(c->shape[0] == 6);
    assert(fabs(c->data[0] - 1) < 1e-9);
    assert(fabs(c->data[5] - 6) < 1e-9);
    num0_free(a); num0_free(b); num0_free(c);
    printf("test_concat passed\n");
}

void test_maximum() {
    double d1[3] = {1, 5, 3};
    double d2[3] = {2, 4, 6};
    int shape[1] = {3};
    Num0 *a = num0_create_from_data(1, shape, d1);
    Num0 *b = num0_create_from_data(1, shape, d2);
    Num0 *c = num0_maximum(a, b);
    assert(fabs(c->data[0] - 2) < 1e-9);
    assert(fabs(c->data[1] - 5) < 1e-9);
    assert(fabs(c->data[2] - 6) < 1e-9);
    num0_free(a); num0_free(b); num0_free(c);
    printf("test_maximum passed\n");
}

void test_copy() {
    double d1[3] = {1, 2, 3};
    int shape[1] = {3};
    Num0 *a = num0_create_from_data(1, shape, d1);
    Num0 *b = num0_copy(a);
    assert(fabs(b->data[0] - 1) < 1e-9);
    b->data[0] = 999;
    assert(fabs(a->data[0] - 1) < 1e-9);
    num0_free(a); num0_free(b);
    printf("test_copy passed\n");
}

void test_softmax() {
    double d1[3] = {1.0, 2.0, 3.0};
    int shape[1] = {3};
    Num0 *a = num0_create_from_data(1, shape, d1);
    double maxval = num0_maxval(a);
    Num0 *shifted = num0_sub(a, num0_create_from_data(1, (int[]){1}, &maxval));
    Num0 *exps = num0_exp(shifted);
    Num0 *sum = num0_sum(exps);
    Num0 *probs = num0_div(exps, sum);
    double total = probs->data[0] + probs->data[1] + probs->data[2];
    assert(fabs(total - 1.0) < 1e-6);
    num0_free(a); num0_free(shifted); num0_free(exps); num0_free(sum); num0_free(probs);
    printf("test_softmax passed\n");
}

int main() {
    printf("Running num0 tests...\n\n");
    
    test_create();
    test_zeros();
    test_ones();
    test_randn();
    test_arange();
    test_add();
    test_add_scalar();
    test_sub();
    test_mul();
    test_div();
    test_neg();
    test_exp();
    test_log();
    test_relu();
    test_abs();
    test_sqrt();
    test_pow();
    test_sum();
    test_mean();
    test_max();
    test_argmax();
    test_matmul();
    test_dot();
    test_reshape();
    test_flatten();
    test_transpose();
    test_slice();
    test_concat();
    test_maximum();
    test_copy();
    test_softmax();
    
    printf("\nAll tests passed!\n");
    return 0;
}
