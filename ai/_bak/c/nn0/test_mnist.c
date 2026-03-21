#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#include <time.h>
#include <zlib.h>
#include "nn0.h"
#include "cnn0.h"

#define TRAIN_IMAGES "/Users/Shared/ccc/c0computer/ai/_data/MNIST/train-images-idx3-ubyte.gz"
#define TRAIN_LABELS "/Users/Shared/ccc/c0computer/ai/_data/MNIST/train-labels-idx1-ubyte.gz"
#define TEST_IMAGES "/Users/Shared/ccc/c0computer/ai/_data/MNIST/t10k-images-idx3-ubyte.gz"
#define TEST_LABELS "/Users/Shared/ccc/c0computer/ai/_data/MNIST/t10k-labels-idx1-ubyte.gz"
#define MODEL_FILE "mnist_cnn.bin"

typedef unsigned char uchar;

int read_int_be(gzFile f) {
    unsigned char bytes[4];
    gzread(f, bytes, 4);
    return (bytes[0] << 24) | (bytes[1] << 16) | (bytes[2] << 8) | bytes[3];
}

typedef struct {
    int num_images;
    int rows;
    int cols;
    uchar* data;
} ImageDataset;

typedef struct {
    int num_labels;
    uchar* data;
} LabelDataset;

ImageDataset load_images(const char* filename) {
    ImageDataset ds = {0};
    gzFile f = gzopen(filename, "rb");
    if (!f) { fprintf(stderr, "Cannot open %s\n", filename); exit(1); }
    
    int magic = read_int_be(f);
    ds.num_images = read_int_be(f);
    ds.rows = read_int_be(f);
    ds.cols = read_int_be(f);
    
    ds.data = malloc(ds.num_images * ds.rows * ds.cols);
    gzread(f, ds.data, ds.num_images * ds.rows * ds.cols);
    gzclose(f);
    return ds;
}

LabelDataset load_labels(const char* filename) {
    LabelDataset ds = {0};
    gzFile f = gzopen(filename, "rb");
    if (!f) { fprintf(stderr, "Cannot open %s\n", filename); exit(1); }
    
    int magic = read_int_be(f);
    ds.num_labels = read_int_be(f);
    
    ds.data = malloc(ds.num_labels);
    gzread(f, ds.data, ds.num_labels);
    gzclose(f);
    return ds;
}

double softmax_loss(Value** logits, int target, int num_classes) {
    double max_logit = logits[0]->data;
    for (int i = 1; i < num_classes; i++) {
        if (logits[i]->data > max_logit) max_logit = logits[i]->data;
    }
    
    double sum_exp = 0;
    for (int i = 0; i < num_classes; i++) {
        sum_exp += exp(logits[i]->data - max_logit);
    }
    double log_sum_exp = max_logit + log(sum_exp);
    return log_sum_exp - logits[target]->data;
}

int predict(Value** logits, int num_classes) {
    int max_idx = 0;
    double max_val = logits[0]->data;
    for (int i = 1; i < num_classes; i++) {
        if (logits[i]->data > max_val) {
            max_val = logits[i]->data;
            max_idx = i;
        }
    }
    return max_idx;
}

void shuffle_indices(int* indices, int n) {
    for (int i = n - 1; i > 0; i--) {
        int j = rand() % (i + 1);
        int tmp = indices[i];
        indices[i] = indices[j];
        indices[j] = tmp;
    }
}

void create_cnn(CNN* cnn) {
    init_nn();
    init_cnn(cnn, 64);
    
    add_conv2d(cnn, 1, 32, 3, 1, 1);
    add_maxpool2d(cnn, 2, 2);
    add_conv2d(cnn, 32, 64, 3, 1, 1);
    add_maxpool2d(cnn, 2, 2);
    add_flatten(cnn);
    add_linear(cnn, 64 * 7 * 7, 128);
    add_linear(cnn, 128, 10);
}

int main(int argc, char* argv[]) {
    srand(time(NULL));
    
    int num_train = 1000;
    int epochs = 3;
    int train_mode = 1;
    
    for (int i = 1; i < argc; i++) {
        if (strcmp(argv[i], "-train") == 0) train_mode = 1;
        else if (strcmp(argv[i], "-test") == 0) train_mode = 0;
        else if (strcmp(argv[i], "-n") == 0 && i + 1 < argc) {
            num_train = atoi(argv[++i]);
        }
        else if (strcmp(argv[i], "-e") == 0 && i + 1 < argc) {
            epochs = atoi(argv[++i]);
        }
    }
    
    printf("=== MNIST CNN Training/Test ===\n");
    
    if (train_mode) {
        CNN cnn;
        create_cnn(&cnn);
        printf("CNN created with %d parameters\n", num_params);
        
        printf("Loading training data (%d samples)...\n", num_train);
        ImageDataset train_images = load_images(TRAIN_IMAGES);
        LabelDataset train_labels = load_labels(TRAIN_LABELS);
        
        if (num_train > train_images.num_images) num_train = train_images.num_images;
        
        init_optimizer();
        
        int* indices = malloc(num_train * sizeof(int));
        for (int i = 0; i < num_train; i++) indices[i] = i;
        
        printf("Starting training...\n");
        clock_t start = clock();
        
        for (int epoch = 0; epoch < epochs; epoch++) {
            shuffle_indices(indices, num_train);
            double total_loss = 0;
            int correct = 0;
            
            for (int i = 0; i < num_train; i++) {
                int idx = indices[i];
                
                arena_reset();
                zero_grad();
                
                double* input = (double*)&train_images.data[idx * 28 * 28];
                Value** logits = forward(&cnn, input, 1, 28, 28, 1);
                
                int pred = predict(logits, 10);
                if (pred == train_labels.data[idx]) correct++;
                
                double loss = softmax_loss(logits, train_labels.data[idx], 10);
                total_loss += loss;
                
                backward(logits[train_labels.data[idx]]);
                step_adam(i + epoch * num_train, epochs * num_train, 0.001);
                
                if ((i + 1) % 500 == 0) {
                    double acc = 100.0 * correct / (i + 1);
                    double avg_loss = total_loss / (i + 1);
                    printf("Epoch %d/%d, Sample %d/%d, Loss: %.4f, Acc: %.2f%%\n",
                           epoch + 1, epochs, i + 1, num_train, avg_loss, acc);
                }
            }
            
            double acc = 100.0 * correct / num_train;
            double avg_loss = total_loss / num_train;
            printf("Epoch %d/%d, Avg Loss: %.4f, Acc: %.2f%%\n",
                   epoch + 1, epochs, avg_loss, acc);
        }
        
        clock_t end = clock();
        printf("Training time: %.2f seconds\n", (double)(end - start) / CLOCKS_PER_SEC);
        
        printf("Saving model to %s...\n", MODEL_FILE);
        save_cnn(&cnn, MODEL_FILE);
        
        free(train_images.data);
        free(train_labels.data);
        free(indices);
        free_cnn(&cnn);
    } else {
        printf("Loading test data...\n");
        ImageDataset test_images = load_images(TEST_IMAGES);
        LabelDataset test_labels = load_labels(TEST_LABELS);
        
        CNN cnn;
        create_cnn(&cnn);
        
        printf("Loading model from %s...\n", MODEL_FILE);
        FILE* f = fopen(MODEL_FILE, "rb");
        if (!f) {
            fprintf(stderr, "Cannot open model file %s\n", MODEL_FILE);
            return 1;
        }
        fclose(f);
        load_cnn(&cnn, MODEL_FILE);
        
        printf("Evaluating on %d test images...\n", test_images.num_images);
        
        int correct = 0;
        for (int i = 0; i < test_images.num_images; i++) {
            arena_reset();
            
            double* input = (double*)&test_images.data[i * 28 * 28];
            Value** logits = forward(&cnn, input, 1, 28, 28, 1);
            
            int pred = predict(logits, 10);
            if (pred == test_labels.data[i]) correct++;
            
            if ((i + 1) % 1000 == 0) {
                double acc = 100.0 * correct / (i + 1);
                printf("Processed %d/%d, Accuracy: %.2f%%\n",
                       i + 1, test_images.num_images, acc);
            }
        }
        
        double acc = 100.0 * correct / test_images.num_images;
        printf("\nFinal Accuracy: %.2f%% (%d/%d correct)\n",
               acc, correct, test_images.num_images);
        
        free(test_images.data);
        free(test_labels.data);
        free_cnn(&cnn);
    }
    
    printf("Done!\n");
    return 0;
}
