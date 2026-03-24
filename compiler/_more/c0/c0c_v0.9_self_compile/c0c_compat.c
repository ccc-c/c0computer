/*
 * c0c_compat.c — compiled with the system C compiler.
 * Provides the variadic emit() and stdio symbols for the self-hosted c0c2/c0c3.
 */
#include <stdio.h>
#include <stdarg.h>
#include <stdlib.h>
#include <string.h>

/* The emit buffer and function — compiled natively so varargs work correctly */
#define EMIT_BUF 8192
static char compat_buf[EMIT_BUF];

void __c0c_emit(FILE *out, const char *fmt, ...) {
    va_list ap;
    va_start(ap, fmt);
    int n = vsnprintf(compat_buf, EMIT_BUF, fmt, ap);
    va_end(ap);
    if (n > 0)
        fwrite(compat_buf, 1, n < EMIT_BUF ? (size_t)n : EMIT_BUF - 1, out);
}

/* stderr/stdout/stdin as real functions (macOS: they're macros, not symbols) */
FILE *__c0c_stderr(void) { return stderr; }
FILE *__c0c_stdout(void) { return stdout; }
FILE *__c0c_stdin(void)  { return stdin;  }
