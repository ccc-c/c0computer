#include <stdarg.h>
#include <stddef.h>
#include <stdint.h>

#include "types.h"
#include "riscv.h"
#include "defs.h"

#ifndef NULL
#define NULL ((void*)0)
#endif

static void
printnum(void (*putch)(int, void*), void *putdat,
   unsigned long long num, unsigned base, int width, int padc)
{
  if (num >= base) {
    printnum(putch, putdat, num / base, base, width - 1, padc);
  } else {
    while (--width > 0)
      putch(padc, putdat);
  }
  putch("0123456789abcdef"[num % base], putdat);
}

static unsigned long long
getuint(va_list *ap, int lflag)
{
  if (lflag >= 2)
    return va_arg(*ap, unsigned long long);
  else if (lflag)
    return va_arg(*ap, unsigned long);
  else
    return va_arg(*ap, unsigned int);
}

static long long
getint(va_list *ap, int lflag)
{
  if (lflag >= 2)
    return va_arg(*ap, long long);
  else if (lflag)
    return va_arg(*ap, long);
  else
    return va_arg(*ap, int);
}

void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  register const char *p;
  register int ch;
  unsigned long long num;
  int base, lflag, width, precision, altflag;
  char padc;

  while (1) {
    while ((ch = *(unsigned char *) fmt++) != '%') {
      if (ch == '\0')
        return;
      putch(ch, putdat);
    }

    padc = ' ';
    width = -1;
    precision = -1;
    lflag = 0;
    altflag = 0;
  reswitch:
    switch (ch = *(unsigned char *) fmt++) {

    case '-':
      padc = '-';
      goto reswitch;

    case '0':
      padc = '0';
      goto reswitch;

    case '1':
    case '2':
    case '3':
    case '4':
    case '5':
    case '6':
    case '7':
    case '8':
    case '9':
      for (precision = 0; ; ++fmt) {
        precision = precision * 10 + ch - '0';
        ch = *fmt;
        if (ch < '0' || ch > '9')
          break;
      }
      goto process_precision;

    case '*':
      precision = va_arg(ap, int);
      goto process_precision;

    case '.':
      if (width < 0)
        width = 0;
      goto reswitch;

    case '#':
      altflag = 1;
      goto reswitch;

    process_precision:
      if (width < 0)
        width = precision, precision = -1;
      goto reswitch;

    case 'l':
    case 'z':
      lflag++;
      goto reswitch;

    case 'c':
      putch(va_arg(ap, int), putdat);
      break;

    case 's':
      if ((p = va_arg(ap, char *)) == NULL)
        p = "(null)";
      if (width > 0 && padc != '-')
        for (width -= strlen(p); width > 0; width--)
          putch(padc, putdat);
      for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
        if (altflag && (ch < ' ' || ch > '~'))
          putch('?', putdat);
        else
          putch(ch, putdat);
      for (; width > 0; width--)
        putch(' ', putdat);
      break;

    case 'd':
      num = getint(&ap, lflag);
      if ((long long) num < 0) {
        putch('-', putdat);
        num = -(long long) num;
      }
      base = 10;
      goto number;

    case 'u':
      num = getuint(&ap, lflag);
      base = 10;
      goto number;

    case 'o':
      num = getuint(&ap, lflag);
      base = 8;
      goto number;

    case 'p':
      putch('0', putdat);
      putch('x', putdat);
      num = (unsigned long long)(uintptr_t) va_arg(ap, void *);
      base = 16;
      goto number;

    case 'x':
      num = getuint(&ap, lflag);
      base = 16;
    number:
      printnum(putch, putdat, num, base, width, padc);
      break;

    case '%':
      putch(ch, putdat);
      break;

    default:
      putch('%', putdat);
      for (fmt--; fmt[-1] != '%'; fmt--)
        /* do nothing */;
      break;
    }
  }
}

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  va_list ap;

  va_start(ap, fmt);
  vprintfmt(putch, putdat, fmt, ap);
  va_end(ap);
}

struct sprintbuf {
  char *buf;
  char *ebuf;
  int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  b->cnt++;
  if (b->buf < b->ebuf)
    *b->buf++ = ch;
}

int
vsnprintf(char *buf, size_t n, const char *fmt, va_list ap)
{
  struct sprintbuf b = {buf, buf+n-1, 0};

  if (buf == NULL || n < 1)
    return -1;

  vprintfmt((void*)sprintputch, &b, fmt, ap);

  *b.buf = '\0';

  return b.cnt;
}

int
snprintf(char *buf, size_t n, const char *fmt, ...)
{
  va_list ap;
  int rc;

  va_start(ap, fmt);
  rc = vsnprintf(buf, n, fmt, ap);
  va_end(ap);

  return rc;
}
