#include "num0.h"

static int seed = 42;

static double rand_double(void) {
    seed = seed * 1103515245 + 12345;
    return (double)(seed / 65536) / 32768.0 - 1.0;
}

Num0 *num0_zeros_ptr(int ndim, int *shape) {
    Num0 *arr = num0_create(ndim, shape);
    int total = num0_total_size(arr);
    memset(arr->data, 0, total * sizeof(double));
    return arr;
}

Num0 *num0_ones_ptr(int ndim, int *shape) {
    Num0 *arr = num0_create(ndim, shape);
    int total = num0_total_size(arr);
    for (int i = 0; i < total; i++) arr->data[i] = 1.0;
    return arr;
}

Num0 *num0_randn_ptr(int ndim, int *shape) {
    Num0 *arr = num0_create(ndim, shape);
    int total = num0_total_size(arr);
    for (int i = 0; i < total; i++) arr->data[i] = rand_double();
    return arr;
}

Num0 *num0_create_ptr(int ndim, int *shape, double *input_data) {
    Num0 *arr = num0_create(ndim, shape);
    int total = num0_total_size(arr);
    memcpy(arr->data, input_data, total * sizeof(double));
    return arr;
}

Num0 *num0_create(int ndim, int *shape) {
    Num0 *arr = (Num0 *)malloc(sizeof(Num0));
    arr->ndim = ndim;
    arr->shape = (int *)malloc(ndim * sizeof(int));
    memcpy(arr->shape, shape, ndim * sizeof(int));
    
    int total = 1;
    for (int i = 0; i < ndim; i++) total *= shape[i];
    arr->data = (double *)calloc(total, sizeof(double));
    return arr;
}

Num0 *num0_create_from_data(int ndim, int *shape, double *data) {
    Num0 *arr = num0_create(ndim, shape);
    memcpy(arr->data, data, num0_total_size(arr) * sizeof(double));
    return arr;
}

void num0_free(Num0 *arr) {
    if (arr) {
        free(arr->data);
        free(arr->shape);
        free(arr);
    }
}

Num0 *num0_copy(Num0 *arr) {
    return num0_create_from_data(arr->ndim, arr->shape, arr->data);
}

int num0_size(Num0 *arr) {
    if (arr->ndim == 0) return 1;
    return arr->shape[arr->ndim - 1];
}

int num0_total_size(Num0 *arr) {
    int total = 1;
    for (int i = 0; i < arr->ndim; i++) total *= arr->shape[i];
    return total;
}

Num0 *num0_zeros(int ndim, int *shape) {
    Num0 *arr = num0_create(ndim, shape);
    memset(arr->data, 0, num0_total_size(arr) * sizeof(double));
    return arr;
}

Num0 *num0_ones(int ndim, int *shape) {
    Num0 *arr = num0_create(ndim, shape);
    int total = num0_total_size(arr);
    for (int i = 0; i < total; i++) arr->data[i] = 1.0;
    return arr;
}

Num0 *num0_randn(int ndim, int *shape) {
    Num0 *arr = num0_create(ndim, shape);
    int total = num0_total_size(arr);
    for (int i = 0; i < total; i++) arr->data[i] = rand_double();
    return arr;
}

Num0 *num0_arange(int start, int stop, int step) {
    int count = (stop - start + step - 1) / step;
    int shape[1] = {count};
    Num0 *arr = num0_create(1, shape);
    for (int i = 0; i < count; i++) {
        arr->data[i] = start + i * step;
    }
    return arr;
}

Num0 *num0_add(Num0 *a, Num0 *b) {
    int size = num0_total_size(a);
    int bsize = num0_total_size(b);
    
    if (bsize == 1) {
        Num0 *res = num0_copy(a);
        for (int i = 0; i < size; i++) res->data[i] += b->data[0];
        return res;
    }
    
    Num0 *res = num0_copy(a);
    for (int i = 0; i < size; i++) res->data[i] += b->data[i];
    return res;
}

Num0 *num0_sub(Num0 *a, Num0 *b) {
    int size = num0_total_size(a);
    int bsize = num0_total_size(b);
    
    if (bsize == 1) {
        Num0 *res = num0_copy(a);
        for (int i = 0; i < size; i++) res->data[i] -= b->data[0];
        return res;
    }
    
    Num0 *res = num0_copy(a);
    for (int i = 0; i < size; i++) res->data[i] -= b->data[i];
    return res;
}

Num0 *num0_mul(Num0 *a, Num0 *b) {
    int size = num0_total_size(a);
    int bsize = num0_total_size(b);
    
    if (bsize == 1) {
        Num0 *res = num0_copy(a);
        for (int i = 0; i < size; i++) res->data[i] *= b->data[0];
        return res;
    }
    
    Num0 *res = num0_copy(a);
    for (int i = 0; i < size; i++) res->data[i] *= b->data[i];
    return res;
}

Num0 *num0_div(Num0 *a, Num0 *b) {
    int size = num0_total_size(a);
    int bsize = num0_total_size(b);
    
    if (bsize == 1) {
        Num0 *res = num0_copy(a);
        for (int i = 0; i < size; i++) res->data[i] /= b->data[0];
        return res;
    }
    
    Num0 *res = num0_copy(a);
    for (int i = 0; i < size; i++) res->data[i] /= b->data[i];
    return res;
}

Num0 *num0_neg(Num0 *a) {
    Num0 *res = num0_copy(a);
    int size = num0_total_size(res);
    for (int i = 0; i < size; i++) res->data[i] = -res->data[i];
    return res;
}

Num0 *num0_exp(Num0 *a) {
    Num0 *res = num0_copy(a);
    int size = num0_total_size(res);
    for (int i = 0; i < size; i++) res->data[i] = exp(res->data[i]);
    return res;
}

Num0 *num0_log(Num0 *a) {
    Num0 *res = num0_copy(a);
    int size = num0_total_size(res);
    for (int i = 0; i < size; i++) res->data[i] = log(res->data[i]);
    return res;
}

Num0 *num0_relu(Num0 *a) {
    Num0 *res = num0_copy(a);
    int size = num0_total_size(res);
    for (int i = 0; i < size; i++) {
        if (res->data[i] < 0) res->data[i] = 0;
    }
    return res;
}

Num0 *num0_abs(Num0 *a) {
    Num0 *res = num0_copy(a);
    int size = num0_total_size(res);
    for (int i = 0; i < size; i++) {
        if (res->data[i] < 0) res->data[i] = -res->data[i];
    }
    return res;
}

Num0 *num0_sqrt(Num0 *a) {
    Num0 *res = num0_copy(a);
    int size = num0_total_size(res);
    for (int i = 0; i < size; i++) res->data[i] = sqrt(res->data[i]);
    return res;
}

Num0 *num0_pow(Num0 *a, double p) {
    Num0 *res = num0_copy(a);
    int size = num0_total_size(res);
    for (int i = 0; i < size; i++) res->data[i] = pow(res->data[i], p);
    return res;
}

Num0 *num0_sum(Num0 *a) {
    int size = num0_total_size(a);
    double s = 0;
    for (int i = 0; i < size; i++) s += a->data[i];
    int shape[1] = {1};
    return num0_create_from_data(1, shape, &s);
}

Num0 *num0_mean(Num0 *a) {
    int size = num0_total_size(a);
    double s = 0;
    for (int i = 0; i < size; i++) s += a->data[i];
    double m = s / size;
    int shape[1] = {1};
    return num0_create_from_data(1, shape, &m);
}

Num0 *num0_max(Num0 *a) {
    int size = num0_total_size(a);
    double m = a->data[0];
    for (int i = 1; i < size; i++) {
        if (a->data[i] > m) m = a->data[i];
    }
    int shape[1] = {1};
    return num0_create_from_data(1, shape, &m);
}

double num0_maxval(Num0 *a) {
    int size = num0_total_size(a);
    double m = a->data[0];
    for (int i = 1; i < size; i++) {
        if (a->data[i] > m) m = a->data[i];
    }
    return m;
}

Num0 *num0_maximum(Num0 *a, Num0 *b) {
    int size = num0_total_size(a);
    int bsize = num0_total_size(b);
    Num0 *res = num0_copy(a);
    
    if (bsize == 1) {
        for (int i = 0; i < size; i++) {
            if (b->data[0] > res->data[i]) res->data[i] = b->data[0];
        }
    } else {
        for (int i = 0; i < size; i++) {
            if (b->data[i] > res->data[i]) res->data[i] = b->data[i];
        }
    }
    return res;
}

int num0_argmax(Num0 *a) {
    int size = num0_total_size(a);
    int idx = 0;
    double m = a->data[0];
    for (int i = 1; i < size; i++) {
        if (a->data[i] > m) {
            m = a->data[i];
            idx = i;
        }
    }
    return idx;
}

Num0 *num0_matmul(Num0 *a, Num0 *b) {
    if (a->ndim != 2 || b->ndim != 2) {
        fprintf(stderr, "matmul requires 2D arrays\n");
        return NULL;
    }
    
    int a_rows = a->shape[0];
    int a_cols = a->shape[1];
    int b_cols = b->shape[1];
    
    int shape[2] = {a_rows, b_cols};
    Num0 *res = num0_zeros(2, shape);
    
    for (int i = 0; i < a_rows; i++) {
        for (int j = 0; j < b_cols; j++) {
            double sum = 0;
            for (int k = 0; k < a_cols; k++) {
                sum += a->data[i * a_cols + k] * b->data[k * b_cols + j];
            }
            res->data[i * b_cols + j] = sum;
        }
    }
    return res;
}

Num0 *num0_dot(Num0 *a, Num0 *b) {
    if (a->ndim == 1 && b->ndim == 1) {
        int size = a->shape[0];
        double sum = 0;
        for (int i = 0; i < size; i++) sum += a->data[i] * b->data[i];
        int shape[1] = {1};
        return num0_create_from_data(1, shape, &sum);
    }
    return num0_matmul(a, b);
}

Num0 *num0_reshape(Num0 *a, int ndim, int *shape) {
    int total = num0_total_size(a);
    int new_size = 1;
    for (int i = 0; i < ndim; i++) new_size *= shape[i];
    
    if (total != new_size) {
        fprintf(stderr, "reshape: size mismatch %d vs %d\n", total, new_size);
        return NULL;
    }
    
    Num0 *res = num0_create(ndim, shape);
    memcpy(res->data, a->data, total * sizeof(double));
    return res;
}

Num0 *num0_flatten(Num0 *a) {
    int total = num0_total_size(a);
    int shape[1] = {total};
    return num0_create_from_data(1, shape, a->data);
}

Num0 *num0_transpose(Num0 *a) {
    if (a->ndim != 2) {
        fprintf(stderr, "transpose requires 2D array\n");
        return NULL;
    }
    
    int rows = a->shape[0];
    int cols = a->shape[1];
    int shape[2] = {cols, rows};
    Num0 *res = num0_create(2, shape);
    
    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            res->data[j * rows + i] = a->data[i * cols + j];
        }
    }
    return res;
}

Num0 *num0_slice(Num0 *a, int start, int stop) {
    int size = a->shape[0];
    int len = stop - start;
    int shape[1] = {len};
    Num0 *res = num0_create(1, shape);
    memcpy(res->data, a->data + start, len * sizeof(double));
    return res;
}

Num0 **num0_split(Num0 *a, int n) {
    int size = a->shape[0];
    int chunk = size / n;
    Num0 **arrs = (Num0 **)malloc(n * sizeof(Num0 *));
    
    for (int i = 0; i < n; i++) {
        int shape[1] = {chunk};
        arrs[i] = num0_create(1, shape);
        memcpy(arrs[i]->data, a->data + i * chunk, chunk * sizeof(double));
    }
    return arrs;
}

Num0 *num0_concat(Num0 **arrs, int n) {
    int total = 0;
    for (int i = 0; i < n; i++) total += num0_total_size(arrs[i]);
    
    int shape[1] = {total};
    Num0 *res = num0_create(1, shape);
    
    int idx = 0;
    for (int i = 0; i < n; i++) {
        int sz = num0_total_size(arrs[i]);
        memcpy(res->data + idx, arrs[i]->data, sz * sizeof(double));
        idx += sz;
    }
    return res;
}

Num0 *num0_pad(Num0 *a, int pad) {
    if (a->ndim == 1) {
        int new_shape[1] = {a->shape[0] + 2 * pad};
        Num0 *res = num0_zeros(1, new_shape);
        memcpy(res->data + pad, a->data, a->shape[0] * sizeof(double));
        return res;
    }
    return num0_copy(a);
}

void num0_print(Num0 *a) {
    printf("Num0[");
    for (int i = 0; i < a->ndim; i++) {
        printf("%d", a->shape[i]);
        if (i < a->ndim - 1) printf(",");
    }
    printf("] = [");
    
    int total = num0_total_size(a);
    for (int i = 0; i < total; i++) {
        printf("%.4f", a->data[i]);
        if (i < total - 1) printf(", ");
    }
    printf("]\n");
}
