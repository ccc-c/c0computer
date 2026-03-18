#include "kernel/types.h"
#include "kernel/stat.h"
#include "kernel/fcntl.h"
#include "kernel/riscv.h"
#include "kernel/vm.h"
#include "user/user.h"

//
// wrapper so that it's OK if main() does not call exit().
//
void
start(int argc, char **argv)
{
  int r;
  extern int main(int argc, char **argv);
  r = main(argc, argv);
  exit(r);
}

char*
strcpy(char *s, const char *t)
{
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    ;
  return os;
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    p++, q++;
  return (uchar)*p - (uchar)*q;
}

int
strncmp(const char *p, const char *q, uint n)
{
  while(n > 0 && *p && *p == *q) {
    p++, q++, n--;
  }
  if (n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
}

char*
strcat(char *dst, const char *src)
{
  char *p = dst;
  while(*p) p++;
  while((*p++ = *src++) != 0);
  return dst;
}

char*
strncpy(char *dst, const char *src, int n)
{
  char *p = dst;
  while(n > 0 && *src) {
    *p++ = *src++;
    n--;
  }
  while(n > 0) {
    *p++ = 0;
    n--;
  }
  return dst;
}

uint
strlen(const char *s)
{
  int n;

  for(n = 0; s[n]; n++)
    ;
  return n;
}

void*
memset(void *dst, int c, uint n)
{
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
    cdst[i] = c;
  }
  return dst;
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
    if(*s == c)
      return (char*)s;
  return 0;
}

char*
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
  return buf;
}

int
stat(const char *n, struct stat *st)
{
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
  r = fstat(fd, st);
  close(fd);
  return r;
}

int
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    n = n*10 + *s++ - '0';
  return n;
}

void*
memmove(void *vdst, const void *vsrc, int n)
{
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
    while(n-- > 0)
      *dst++ = *src++;
  } else {
    dst += n;
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}

int
memcmp(const void *s1, const void *s2, uint n)
{
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
    if (*p1 != *p2) {
      return *p1 - *p2;
    }
    p1++;
    p2++;
  }
  return 0;
}

void *
memcpy(void *dst, const void *src, uint n)
{
  return memmove(dst, src, n);
}

char *
sbrk(int n) {
  return sys_sbrk(n, SBRK_EAGER);
}

char *
sbrklazy(int n) {
  return sys_sbrk(n, SBRK_LAZY);
}

// Byte order conversion functions
unsigned short
htons(unsigned short hostshort)
{
  return ((hostshort >> 8) & 0xff) | ((hostshort & 0xff) << 8);
}

unsigned short
ntohs(unsigned short netshort)
{
  return ((netshort >> 8) & 0xff) | ((netshort & 0xff) << 8);
}

unsigned long
htonl(unsigned long hostlong)
{
  return ((hostlong >> 24) & 0xff) |
         ((hostlong >> 8) & 0xff00) |
         ((hostlong & 0xff00) << 8) |
         ((hostlong & 0xff) << 24);
}

unsigned long
ntohl(unsigned long netlong)
{
  return ((netlong >> 24) & 0xff) |
         ((netlong >> 8) & 0xff00) |
         ((netlong & 0xff00) << 8) |
         ((netlong & 0xff) << 24);
}

