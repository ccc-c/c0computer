#ifndef NUM0_H
#define NUM0_H

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>

typedef struct {
    double *data;
    int ndim;
    int *shape;
} Num0;

Num0 *num0_zeros_ptr(int ndim, int *shape);
Num0 *num0_ones_ptr(int ndim, int *shape);
Num0 *num0_randn_ptr(int ndim, int *shape);
Num0 *num0_create_ptr(int ndim, int *shape, double *input_data);

Num0 *num0_create(int ndim, int *shape);
Num0 *num0_create_from_data(int ndim, int *shape, double *data);
void num0_free(Num0 *arr);
Num0 *num0_copy(Num0 *arr);
Num0 *num0_zeros(int ndim, int *shape);
Num0 *num0_ones(int ndim, int *shape);
Num0 *num0_randn(int ndim, int *shape);
Num0 *num0_arange(int start, int stop, int step);
Num0 *num0_add(Num0 *a, Num0 *b);
Num0 *num0_sub(Num0 *a, Num0 *b);
Num0 *num0_mul(Num0 *a, Num0 *b);
Num0 *num0_div(Num0 *a, Num0 *b);
Num0 *num0_neg(Num0 *a);
Num0 *num0_exp(Num0 *a);
Num0 *num0_log(Num0 *a);
Num0 *num0_relu(Num0 *a);
Num0 *num0_abs(Num0 *a);
Num0 *num0_sqrt(Num0 *a);
Num0 *num0_pow(Num0 *a, double p);
Num0 *num0_sum(Num0 *a);
Num0 *num0_mean(Num0 *a);
Num0 *num0_max(Num0 *a);
Num0 *num0_maximum(Num0 *a, Num0 *b);
Num0 *num0_matmul(Num0 *a, Num0 *b);
Num0 *num0_dot(Num0 *a, Num0 *b);
Num0 *num0_reshape(Num0 *a, int ndim, int *shape);
Num0 *num0_flatten(Num0 *a);
Num0 *num0_transpose(Num0 *a);
Num0 *num0_slice(Num0 *a, int start, int stop);
Num0 **num0_split(Num0 *a, int n);
Num0 *num0_concat(Num0 **arrs, int n);
Num0 *num0_pad(Num0 *a, int pad);
int num0_argmax(Num0 *a);
double num0_maxval(Num0 *a);
void num0_print(Num0 *a);

int num0_size(Num0 *arr);
int num0_total_size(Num0 *arr);

#endif
