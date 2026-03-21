#ifndef NUM0AD_H
#define NUM0AD_H

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>

#define MAX_CHILDREN 16

typedef struct Num0AD Num0AD;

struct Num0AD {
    double *data;
    double *grad;
    int ndim;
    int *shape;
    int n_children;
    Num0AD **children;
    double **local_grads;
    int op_type;
};

Num0AD *num0ad_create(int ndim, int *shape);
Num0AD *num0ad_create_from_data(int ndim, int *shape, double *data);
Num0AD *num0ad_zeros(int ndim, int *shape);
Num0AD *num0ad_ones(int ndim, int *shape);
Num0AD *num0ad_randn(int ndim, int *shape);
Num0AD *num0ad_arange(int start, int stop, int step);
void num0ad_free(Num0AD *arr);
void num0ad_free_all(Num0AD *arr);

Num0AD *num0ad_add(Num0AD *a, Num0AD *b);
Num0AD *num0ad_sub(Num0AD *a, Num0AD *b);
Num0AD *num0ad_mul(Num0AD *a, Num0AD *b);
Num0AD *num0ad_div(Num0AD *a, Num0AD *b);
Num0AD *num0ad_neg(Num0AD *a);
Num0AD *num0ad_exp(Num0AD *a);
Num0AD *num0ad_log(Num0AD *a);
Num0AD *num0ad_relu(Num0AD *a);
Num0AD *num0ad_abs(Num0AD *a);
Num0AD *num0ad_sqrt(Num0AD *a);
Num0AD *num0ad_pow(Num0AD *a, double p);
Num0AD *num0ad_sum(Num0AD *a);
Num0AD *num0ad_mean(Num0AD *a);
Num0AD *num0ad_matmul(Num0AD *a, Num0AD *b);
Num0AD *num0ad_dot(Num0AD *a, Num0AD *b);
Num0AD *num0ad_reshape(Num0AD *a, int ndim, int *shape);
Num0AD *num0ad_flatten(Num0AD *a);

void num0ad_backward(Num0AD *arr);
void num0ad_zero_grad(Num0AD *arr);

int num0ad_total_size(Num0AD *arr);
void num0ad_print(Num0AD *arr);
void num0ad_print_grad(Num0AD *arr);

double num0ad_maxval(Num0AD *arr);
int num0ad_argmax(Num0AD *arr);
Num0AD *num0ad_max(Num0AD *arr);

Num0AD *num0ad_scalar_add(Num0AD *a, double b);
Num0AD *num0ad_scalar_mul(Num0AD *a, double b);

#endif
