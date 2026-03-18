// expected: 1
int main() {
    int a = 1;
    int b = 0;
    int r = 0;
    if (a && b) r = r + 1;
    if (a || b) r = r + 1;
    if (!b) r = r + 1;
    if (a && !b) r = r + 1;
    if (!a || b || !b) r = r + 1;
    return r;
}
