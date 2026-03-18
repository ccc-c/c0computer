// expected: 3
int main() {
    int x = 2;
    int r = 0;
    switch (x) {
        case 1:
            r = 1;
            break;
        case 2:
            r = 3;
            break;
        case 3:
            r = 5;
            break;
        default:
            r = 0;
    }
    return r;
}
