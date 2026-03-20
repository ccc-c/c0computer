/*
 * c0c_compat.c — compiled with the system C compiler.
 * Provides: __c0c_emit, __c0c_stderr/stdout/stdin, __c0c_get_tbuf.
 */
#include <stdio.h>
#include <stdarg.h>
#include <stdlib.h>
#include <string.h>

/* The central emit function */
#define EMIT_BUF 8192
static char compat_emit_buf[EMIT_BUF];

void __c0c_emit(FILE *out, const char *fmt, ...) {
    va_list ap;
    va_start(ap, fmt);
    int n = vsnprintf(compat_emit_buf, EMIT_BUF, fmt, ap);
    va_end(ap);
    if (n > 0)
        fwrite(compat_emit_buf, 1, n < EMIT_BUF ? (size_t)n : EMIT_BUF-1, out);
}

/* stderr/stdout/stdin */
FILE *__c0c_stderr(void) { return stderr; }
FILE *__c0c_stdout(void) { return stdout; }
FILE *__c0c_stdin(void)  { return stdin;  }

/* Type string rotation buffers — 8 slots of 256 bytes each.
   llvm_type() in codegen.c uses these to return temporary type strings. */
static char tbuf_storage[8][256];

char *__c0c_get_tbuf(int i) {
    return tbuf_storage[((unsigned)i) % 8];
}
