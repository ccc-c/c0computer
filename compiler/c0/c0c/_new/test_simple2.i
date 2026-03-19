typedef void FILE;
extern void *stdin;
extern void *stdout;
extern void *stderr;
extern void *fopen(char *name, char *mode);
extern int fclose(void *f);
extern int fseek(void *f, long offset, int whence);
extern long ftell(void *f);
extern int fread(void *ptr, int size, int nmemb, void *f);
extern int fputs(char *s, void *f);
extern int printf(char *fmt, ...);
extern int sprintf(char *str, char *fmt, ...);
extern int snprintf(char *str, int size, char *fmt, ...);
extern int fprintf(void *f, char *fmt, ...);
extern void perror(char *s);
int main() {
    printf("test");
    return 0;
}
