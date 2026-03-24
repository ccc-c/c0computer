// expected: 55 (sum of 1+2+...+10)
int main() {
    int sum = 0;
    for (int i = 1; i <= 10; i = i + 1) {
        sum = sum + i;
    }
    return sum;
}
