// expected: 21
int main() {
    int i = 0;
    int sum = 0;
    while (i < 7) {
        sum = sum + i;
        i = i + 1;
    }
    return sum;
}
