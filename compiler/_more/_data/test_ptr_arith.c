// expected: 3
int main() {
    int arr[5] = {1, 2, 3, 4, 5};
    int *p = arr;
    p = p + 2;
    return *p;
}
