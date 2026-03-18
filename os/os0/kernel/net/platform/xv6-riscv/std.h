#ifndef STD_H
#define STD_H

#include <stdarg.h>
#include <stddef.h>

/* uint is defined in kernel/types.h which is included in platform.h before std.h */

#define UINT16_MAX 65535

#define isascii(x) ((x >= 0x00) && (x <= 0x7f))
#define isprint(x) ((x >= 0x20) && (x <= 0x7e))

#define EINTR 1

extern int errno;

/*
 * STDIO
 */

typedef struct {
    /* dummy */
} FILE;

extern FILE *stderr;

#define fprintf(fp, ...) printf(__VA_ARGS__)
#define vfprintf(fp, ...) vcprintf(__VA_ARGS__)

extern void
flockfile(FILE *fp);
extern void
funlockfile(FILE *fp);
extern int
vfprintf(FILE *fp, const char *fmt, va_list ap);

/*
 * Time - provide stub structures
 */

struct timespec {
    long tv_sec;
    long tv_nsec;
};

struct timeval {
    long tv_sec;
    long tv_usec;
};

struct tm {
    int tm_sec;
    int tm_min;
    int tm_hour;
    int tm_mday;
    int tm_mon;
    int tm_year;
    int tm_wday;
    int tm_yday;
    int tm_isdst;
};

#define timercmp(a, b, cmp) \
    ((a)->tv_sec == (b)->tv_sec ? (a)->tv_usec cmp (b)->tv_usec : (a)->tv_sec cmp (b)->tv_sec)

/* Additional types */
typedef unsigned int uint;
typedef long ssize_t;
typedef unsigned long uintptr_t;
typedef unsigned long uint64_t;

/* Stub time functions - not available in kernel */
typedef unsigned long time_t;

static inline int gettimeofday(struct timeval *tv, void *tz)
{
    if (tv) {
        tv->tv_sec = 0;
        tv->tv_usec = 0;
    }
    return 0;
}

static inline void timersub(struct timeval *a, struct timeval *b, struct timeval *res)
{
    if (res) {
        res->tv_sec = 0;
        res->tv_usec = 0;
    }
}

static inline void timerclear(struct timeval *tv)
{
    if (tv) {
        tv->tv_sec = 0;
        tv->tv_usec = 0;
    }
}

static inline struct tm *localtime_r(long *timep, struct tm *result)
{
    if (result && timep) {
        memset(result, 0, sizeof(*result));
    }
    return result;
}

extern size_t
strftime(char *s, size_t max, const char *format, const struct tm *tm);

/*
 * Random
 */

extern void
srand(unsigned int newseed);
extern long
random(void);

/*
 * String
 */

extern void *
memcpy(void *dst, const void *src, uint n);
extern void *
memset(void *s, int c, uint n);
extern long
strtol(const char *s, char **endptr, int base);
extern char *
strrchr(const char *cp, int ch);
extern int
strcmp(const char *p, const char *q);

#endif
