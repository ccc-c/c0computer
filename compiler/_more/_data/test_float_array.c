// expected: 30 (test float array)
int main() {
    float arr[5];
    arr[0] = 10.0f;
    arr[1] = 20.0f;
    int sum = (int)(arr[0] + arr[1]);
    return sum;
}
