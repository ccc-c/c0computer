// expected: 6 (true)
int main() {
    int a = 10;
    int b = 5;
    int c = 10;
    int r = 0;
    if (a > b) r = r + 1;
    if (a >= c) r = r + 1;
    if (a == c) r = r + 1;
    if (a != b) r = r + 1;
    if (b < a) r = r + 1;
    if (c <= a) r = r + 1;
    return r;
}
