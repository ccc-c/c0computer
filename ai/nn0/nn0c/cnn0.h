#ifndef CNN_H
#define CNN_H

#include "nn0.h"

#define MAX_CONV_KERNELS 64
#define MAX_POOL_OUTPUTS 1000000

typedef struct {
    int in_channels;
    int out_channels;
    int kernel_size;
    int stride;
    int padding;
    Matrix* kernels;
    Value** biases;
} Conv2D;

typedef struct {
    int kernel_size;
    int stride;
    int in_h, in_w;
    int out_h, out_w;
} MaxPool2D;

typedef struct {
    int in_features;
    int out_features;
    Matrix w;
    Value** biases;
} Linear;

typedef struct {
    int type;
    Conv2D* conv;
    MaxPool2D* pool;
    Linear* linear;
} Layer;

typedef struct {
    int num_layers;
    Layer** layers;
} CNN;

void init_cnn(CNN* cnn, int num_layers);
void add_conv2d(CNN* cnn, int in_ch, int out_ch, int kernel_size, int stride, int padding);
void add_maxpool2d(CNN* cnn, int kernel_size, int stride);
void add_flatten(CNN* cnn);
void add_linear(CNN* cnn, int in_features, int out_features);

Value** forward(CNN* cnn, double* input, int batch_size, int in_h, int in_w, int in_ch);

int get_conv_out_size(int in_size, int kernel_size, int stride, int padding);
int get_pool_out_size(int in_size, int kernel_size, int stride);

void load_cnn(CNN* cnn, const char* filename);
void save_cnn(CNN* cnn, const char* filename);

void free_cnn(CNN* cnn);

#endif
