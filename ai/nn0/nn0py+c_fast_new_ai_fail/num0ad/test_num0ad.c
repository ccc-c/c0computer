#include <stdio.h>
#include <assert.h>
#include <math.h>
#include "num0ad.h"

void test_create() {
    int shape[2] = {3, 4};
    Num0AD *arr = num0ad_create(2, shape);
    assert(arr->ndim == 2);
    assert(arr->shape[0] == 3);
    assert(arr->shape[1] == 4);
    num0ad_free(arr);
    printf("test_create passed\n");
}

void test_zeros() {
    int shape[2] = {2, 3};
    Num0AD *arr = num0ad_zeros(2, shape);
    assert(num0ad_total_size(arr) == 6);
    for (int i = 0; i < 6; i++) assert(fabs(arr->data[i]) < 1e-9);
    num0ad_free(arr);
    printf("test_zeros passed\n");
}

void test_ones() {
    int shape[2] = {2, 3};
    Num0AD *arr = num0ad_ones(2, shape);
    assert(num0ad_total_size(arr) == 6);
    for (int i = 0; i < 6; i++) assert(fabs(arr->data[i] - 1.0) < 1e-9);
    num0ad_free(arr);
    printf("test_ones passed\n");
}

void test_arange() {
    Num0AD *arr = num0ad_arange(0, 10, 1);
    assert(arr->shape[0] == 10);
    for (int i = 0; i < 10; i++) assert(fabs(arr->data[i] - i) < 1e-9);
    num0ad_free(arr);
    printf("test_arange passed\n");
}

void test_add() {
    double d1[3] = {1, 2, 3};
    double d2[3] = {4, 5, 6};
    int shape[1] = {3};
    Num0AD *a = num0ad_create_from_data(1, shape, d1);
    Num0AD *b = num0ad_create_from_data(1, shape, d2);
    Num0AD *c = num0ad_add(a, b);
    assert(fabs(c->data[0] - 5) < 1e-9);
    assert(fabs(c->data[1] - 7) < 1e-9);
    assert(fabs(c->data[2] - 9) < 1e-9);
    num0ad_free_all(c);
    printf("test_add passed\n");
}

void test_sub() {
    double d1[3] = {5, 6, 7};
    double d2[3] = {1, 2, 3};
    int shape[1] = {3};
    Num0AD *a = num0ad_create_from_data(1, shape, d1);
    Num0AD *b = num0ad_create_from_data(1, shape, d2);
    Num0AD *c = num0ad_sub(a, b);
    assert(fabs(c->data[0] - 4) < 1e-9);
    assert(fabs(c->data[1] - 4) < 1e-9);
    assert(fabs(c->data[2] - 4) < 1e-9);
    num0ad_free_all(c);
    printf("test_sub passed\n");
}

void test_mul() {
    double d1[3] = {1, 2, 3};
    double d2[3] = {4, 5, 6};
    int shape[1] = {3};
    Num0AD *a = num0ad_create_from_data(1, shape, d1);
    Num0AD *b = num0ad_create_from_data(1, shape, d2);
    Num0AD *c = num0ad_mul(a, b);
    assert(fabs(c->data[0] - 4) < 1e-9);
    assert(fabs(c->data[1] - 10) < 1e-9);
    assert(fabs(c->data[2] - 18) < 1e-9);
    num0ad_free_all(c);
    printf("test_mul passed\n");
}

void test_neg() {
    double d1[3] = {1, -2, 3};
    int shape[1] = {3};
    Num0AD *a = num0ad_create_from_data(1, shape, d1);
    Num0AD *b = num0ad_neg(a);
    assert(fabs(b->data[0] - (-1)) < 1e-9);
    assert(fabs(b->data[1] - 2) < 1e-9);
    assert(fabs(b->data[2] - (-3)) < 1e-9);
    num0ad_free_all(b);
    printf("test_neg passed\n");
}

void test_exp() {
    double d1[1] = {0};
    int shape[1] = {1};
    Num0AD *a = num0ad_create_from_data(1, shape, d1);
    Num0AD *b = num0ad_exp(a);
    assert(fabs(b->data[0] - 1.0) < 1e-6);
    num0ad_free_all(b);
    printf("test_exp passed\n");
}

void test_log() {
    double d1[1] = {2.71828};
    int shape[1] = {1};
    Num0AD *a = num0ad_create_from_data(1, shape, d1);
    Num0AD *b = num0ad_log(a);
    assert(fabs(b->data[0] - 1.0) < 1e-4);
    num0ad_free_all(b);
    printf("test_log passed\n");
}

void test_relu() {
    double d1[5] = {-3, -1, 0, 2, 5};
    int shape[1] = {5};
    Num0AD *a = num0ad_create_from_data(1, shape, d1);
    Num0AD *b = num0ad_relu(a);
    assert(fabs(b->data[0]) < 1e-9);
    assert(fabs(b->data[1]) < 1e-9);
    assert(fabs(b->data[2]) < 1e-9);
    assert(fabs(b->data[3] - 2) < 1e-9);
    assert(fabs(b->data[4] - 5) < 1e-9);
    num0ad_free_all(b);
    printf("test_relu passed\n");
}

void test_pow() {
    double d1[1] = {3};
    int shape[1] = {1};
    Num0AD *a = num0ad_create_from_data(1, shape, d1);
    Num0AD *b = num0ad_pow(a, 2);
    assert(fabs(b->data[0] - 9) < 1e-9);
    num0ad_free_all(b);
    printf("test_pow passed\n");
}

void test_sum() {
    double d1[5] = {1, 2, 3, 4, 5};
    int shape[1] = {5};
    Num0AD *a = num0ad_create_from_data(1, shape, d1);
    Num0AD *s = num0ad_sum(a);
    assert(fabs(s->data[0] - 15) < 1e-9);
    num0ad_free_all(s);
    printf("test_sum passed\n");
}

void test_mean() {
    double d1[4] = {1, 2, 3, 4};
    int shape[1] = {4};
    Num0AD *a = num0ad_create_from_data(1, shape, d1);
    Num0AD *m = num0ad_mean(a);
    assert(fabs(m->data[0] - 2.5) < 1e-9);
    num0ad_free_all(m);
    printf("test_mean passed\n");
}

void test_backward_add() {
    double d1[2] = {1, 2};
    double d2[2] = {3, 4};
    int shape[1] = {2};
    Num0AD *a = num0ad_create_from_data(1, shape, d1);
    Num0AD *b = num0ad_create_from_data(1, shape, d2);
    Num0AD *c = num0ad_add(a, b);
    
    num0ad_backward(c);
    
    assert(fabs(a->grad[0] - 1) < 1e-9);
    assert(fabs(a->grad[1] - 1) < 1e-9);
    assert(fabs(b->grad[0] - 1) < 1e-9);
    assert(fabs(b->grad[1] - 1) < 1e-9);
    
    num0ad_free_all(c);
    printf("test_backward_add passed\n");
}

void test_backward_mul() {
    double d1[2] = {2, 3};
    double d2[2] = {4, 5};
    int shape[1] = {2};
    Num0AD *a = num0ad_create_from_data(1, shape, d1);
    Num0AD *b = num0ad_create_from_data(1, shape, d2);
    Num0AD *c = num0ad_mul(a, b);
    
    num0ad_backward(c);
    
    assert(fabs(a->grad[0] - 4) < 1e-9);
    assert(fabs(a->grad[1] - 5) < 1e-9);
    assert(fabs(b->grad[0] - 2) < 1e-9);
    assert(fabs(b->grad[1] - 3) < 1e-9);
    
    num0ad_free_all(c);
    printf("test_backward_mul passed\n");
}

void test_backward_pow() {
    double d1[1] = {2};
    int shape[1] = {1};
    Num0AD *a = num0ad_create_from_data(1, shape, d1);
    Num0AD *b = num0ad_pow(a, 3);
    
    num0ad_backward(b);
    
    assert(fabs(a->grad[0] - 12) < 1e-9);
    
    num0ad_free_all(b);
    printf("test_backward_pow passed\n");
}

void test_backward_exp() {
    double d1[1] = {0};
    int shape[1] = {1};
    Num0AD *a = num0ad_create_from_data(1, shape, d1);
    Num0AD *b = num0ad_exp(a);
    Num0AD *c = num0ad_sum(b);
    
    num0ad_backward(c);
    
    assert(fabs(a->grad[0] - 1.0) < 1e-6);
    
    num0ad_free_all(c);
    printf("test_backward_exp passed\n");
}

void test_backward_relu() {
    double d1[3] = {-1, 2, -3};
    int shape[1] = {3};
    Num0AD *a = num0ad_create_from_data(1, shape, d1);
    Num0AD *b = num0ad_relu(a);
    Num0AD *c = num0ad_sum(b);
    
    num0ad_backward(c);
    
    assert(fabs(a->grad[0] - 0) < 1e-9);
    assert(fabs(a->grad[1] - 1) < 1e-9);
    assert(fabs(a->grad[2] - 0) < 1e-9);
    
    num0ad_free_all(c);
    printf("test_backward_relu passed\n");
}

void test_backward_complex() {
    double d1[2] = {2, 3};
    double d2[2] = {4, 5};
    int shape[1] = {2};
    Num0AD *a = num0ad_create_from_data(1, shape, d1);
    Num0AD *b = num0ad_create_from_data(1, shape, d2);
    Num0AD *c = num0ad_add(num0ad_mul(a, b), num0ad_pow(a, 2));
    Num0AD *s = num0ad_sum(c);
    
    num0ad_backward(s);
    
    assert(fabs(a->grad[0] - (4 + 4)) < 1e-6);
    assert(fabs(a->grad[1] - (5 + 6)) < 1e-6);
    assert(fabs(b->grad[0] - 2) < 1e-9);
    assert(fabs(b->grad[1] - 3) < 1e-9);
    
    num0ad_free_all(s);
    printf("test_backward_complex passed\n");
}

void test_matmul() {
    double a_data[4] = {1, 2, 3, 4};
    double b_data[4] = {5, 6, 7, 8};
    int a_shape[2] = {2, 2};
    int b_shape[2] = {2, 2};
    Num0AD *a = num0ad_create_from_data(2, a_shape, a_data);
    Num0AD *b = num0ad_create_from_data(2, b_shape, b_data);
    Num0AD *c = num0ad_matmul(a, b);
    
    assert(fabs(c->data[0] - 19) < 1e-9);
    assert(fabs(c->data[1] - 22) < 1e-9);
    assert(fabs(c->data[2] - 43) < 1e-9);
    assert(fabs(c->data[3] - 50) < 1e-9);
    
    num0ad_free_all(c);
    printf("test_matmul passed\n");
}

void test_dot() {
    double a_data[3] = {1, 2, 3};
    double b_data[3] = {4, 5, 6};
    int a_shape[1] = {3};
    int b_shape[1] = {3};
    Num0AD *a = num0ad_create_from_data(1, a_shape, a_data);
    Num0AD *b = num0ad_create_from_data(1, b_shape, b_data);
    Num0AD *c = num0ad_dot(a, b);
    
    assert(fabs(c->data[0] - 32) < 1e-9);
    
    num0ad_free_all(c);
    printf("test_dot passed\n");
}

void test_scalar_add() {
    double d1[3] = {1, 2, 3};
    int shape[1] = {3};
    Num0AD *a = num0ad_create_from_data(1, shape, d1);
    Num0AD *b = num0ad_scalar_add(a, 10);
    
    assert(fabs(b->data[0] - 11) < 1e-9);
    assert(fabs(b->data[1] - 12) < 1e-9);
    assert(fabs(b->data[2] - 13) < 1e-9);
    
    num0ad_free_all(b);
    printf("test_scalar_add passed\n");
}

void test_scalar_mul() {
    double d1[3] = {1, 2, 3};
    int shape[1] = {3};
    Num0AD *a = num0ad_create_from_data(1, shape, d1);
    Num0AD *b = num0ad_scalar_mul(a, 3);
    
    assert(fabs(b->data[0] - 3) < 1e-9);
    assert(fabs(b->data[1] - 6) < 1e-9);
    assert(fabs(b->data[2] - 9) < 1e-9);
    
    num0ad_free_all(b);
    printf("test_scalar_mul passed\n");
}

int main() {
    printf("Running num0ad tests...\n\n");
    
    test_create();
    test_zeros();
    test_ones();
    test_arange();
    test_add();
    test_sub();
    test_mul();
    test_neg();
    test_exp();
    test_log();
    test_relu();
    test_pow();
    test_sum();
    test_mean();
    test_backward_add();
    test_backward_mul();
    test_backward_pow();
    test_backward_exp();
    test_backward_relu();
    test_backward_complex();
    test_matmul();
    test_dot();
    test_scalar_add();
    test_scalar_mul();
    
    printf("\nAll tests passed!\n");
    return 0;
}
