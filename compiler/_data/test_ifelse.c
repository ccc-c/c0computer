// expected: 3
int main() {
    int x = 10;
    int r = 0;
    if (x > 5) {
        r = r + 1;
    } else {
        r = r + 10;
    }
    if (x < 5) {
        r = r + 10;
    } else {
        r = r + 2;
    }
    return r;
}
