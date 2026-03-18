
user/_zombie:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/stat.h"
#include "user/user.h"

int
main(void)
{
   0:	1141                	add	sp,sp,-16
   2:	e406                	sd	ra,8(sp)
   4:	e022                	sd	s0,0(sp)
   6:	0800                	add	s0,sp,16
  if(fork() > 0)
   8:	3dc000ef          	jal	3e4 <fork>
   c:	00a04563          	bgtz	a0,16 <main+0x16>
    pause(5);  // Let child exit before parent.
  exit(0);
  10:	4501                	li	a0,0
  12:	3da000ef          	jal	3ec <exit>
    pause(5);  // Let child exit before parent.
  16:	4515                	li	a0,5
  18:	464000ef          	jal	47c <pause>
  1c:	bfd5                	j	10 <main+0x10>

000000000000001e <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start(int argc, char **argv)
{
  1e:	1141                	add	sp,sp,-16
  20:	e406                	sd	ra,8(sp)
  22:	e022                	sd	s0,0(sp)
  24:	0800                	add	s0,sp,16
  int r;
  extern int main(int argc, char **argv);
  r = main(argc, argv);
  26:	fdbff0ef          	jal	0 <main>
  exit(r);
  2a:	3c2000ef          	jal	3ec <exit>

000000000000002e <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
  2e:	1141                	add	sp,sp,-16
  30:	e422                	sd	s0,8(sp)
  32:	0800                	add	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  34:	87aa                	mv	a5,a0
  36:	0585                	add	a1,a1,1
  38:	0785                	add	a5,a5,1
  3a:	fff5c703          	lbu	a4,-1(a1)
  3e:	fee78fa3          	sb	a4,-1(a5)
  42:	fb75                	bnez	a4,36 <strcpy+0x8>
    ;
  return os;
}
  44:	6422                	ld	s0,8(sp)
  46:	0141                	add	sp,sp,16
  48:	8082                	ret

000000000000004a <strcmp>:

int
strcmp(const char *p, const char *q)
{
  4a:	1141                	add	sp,sp,-16
  4c:	e422                	sd	s0,8(sp)
  4e:	0800                	add	s0,sp,16
  while(*p && *p == *q)
  50:	00054783          	lbu	a5,0(a0)
  54:	cb91                	beqz	a5,68 <strcmp+0x1e>
  56:	0005c703          	lbu	a4,0(a1)
  5a:	00f71763          	bne	a4,a5,68 <strcmp+0x1e>
    p++, q++;
  5e:	0505                	add	a0,a0,1
  60:	0585                	add	a1,a1,1
  while(*p && *p == *q)
  62:	00054783          	lbu	a5,0(a0)
  66:	fbe5                	bnez	a5,56 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
  68:	0005c503          	lbu	a0,0(a1)
}
  6c:	40a7853b          	subw	a0,a5,a0
  70:	6422                	ld	s0,8(sp)
  72:	0141                	add	sp,sp,16
  74:	8082                	ret

0000000000000076 <strncmp>:

int
strncmp(const char *p, const char *q, uint n)
{
  76:	1141                	add	sp,sp,-16
  78:	e422                	sd	s0,8(sp)
  7a:	0800                	add	s0,sp,16
  while(n > 0 && *p && *p == *q) {
  7c:	ce11                	beqz	a2,98 <strncmp+0x22>
  7e:	00054783          	lbu	a5,0(a0)
  82:	cf89                	beqz	a5,9c <strncmp+0x26>
  84:	0005c703          	lbu	a4,0(a1)
  88:	00f71a63          	bne	a4,a5,9c <strncmp+0x26>
    p++, q++, n--;
  8c:	0505                	add	a0,a0,1
  8e:	0585                	add	a1,a1,1
  90:	367d                	addw	a2,a2,-1
  while(n > 0 && *p && *p == *q) {
  92:	f675                	bnez	a2,7e <strncmp+0x8>
  }
  if (n == 0)
    return 0;
  94:	4501                	li	a0,0
  96:	a801                	j	a6 <strncmp+0x30>
  98:	4501                	li	a0,0
  9a:	a031                	j	a6 <strncmp+0x30>
  return (uchar)*p - (uchar)*q;
  9c:	00054503          	lbu	a0,0(a0)
  a0:	0005c783          	lbu	a5,0(a1)
  a4:	9d1d                	subw	a0,a0,a5
}
  a6:	6422                	ld	s0,8(sp)
  a8:	0141                	add	sp,sp,16
  aa:	8082                	ret

00000000000000ac <strcat>:

char*
strcat(char *dst, const char *src)
{
  ac:	1141                	add	sp,sp,-16
  ae:	e422                	sd	s0,8(sp)
  b0:	0800                	add	s0,sp,16
  char *p = dst;
  while(*p) p++;
  b2:	00054783          	lbu	a5,0(a0)
  b6:	c385                	beqz	a5,d6 <strcat+0x2a>
  char *p = dst;
  b8:	87aa                	mv	a5,a0
  while(*p) p++;
  ba:	0785                	add	a5,a5,1
  bc:	0007c703          	lbu	a4,0(a5)
  c0:	ff6d                	bnez	a4,ba <strcat+0xe>
  while((*p++ = *src++) != 0);
  c2:	0585                	add	a1,a1,1
  c4:	0785                	add	a5,a5,1
  c6:	fff5c703          	lbu	a4,-1(a1)
  ca:	fee78fa3          	sb	a4,-1(a5)
  ce:	fb75                	bnez	a4,c2 <strcat+0x16>
  return dst;
}
  d0:	6422                	ld	s0,8(sp)
  d2:	0141                	add	sp,sp,16
  d4:	8082                	ret
  char *p = dst;
  d6:	87aa                	mv	a5,a0
  d8:	b7ed                	j	c2 <strcat+0x16>

00000000000000da <strncpy>:

char*
strncpy(char *dst, const char *src, int n)
{
  da:	1141                	add	sp,sp,-16
  dc:	e422                	sd	s0,8(sp)
  de:	0800                	add	s0,sp,16
  char *p = dst;
  e0:	87aa                	mv	a5,a0
  while(n > 0 && *src) {
  e2:	02c05463          	blez	a2,10a <strncpy+0x30>
  e6:	0005c703          	lbu	a4,0(a1)
  ea:	cb01                	beqz	a4,fa <strncpy+0x20>
    *p++ = *src++;
  ec:	0585                	add	a1,a1,1
  ee:	0785                	add	a5,a5,1
  f0:	fee78fa3          	sb	a4,-1(a5)
    n--;
  f4:	367d                	addw	a2,a2,-1
  while(n > 0 && *src) {
  f6:	fa65                	bnez	a2,e6 <strncpy+0xc>
  f8:	a809                	j	10a <strncpy+0x30>
  }
  while(n > 0) {
  fa:	1602                	sll	a2,a2,0x20
  fc:	9201                	srl	a2,a2,0x20
  fe:	963e                	add	a2,a2,a5
    *p++ = 0;
 100:	0785                	add	a5,a5,1
 102:	fe078fa3          	sb	zero,-1(a5)
  while(n > 0) {
 106:	fec79de3          	bne	a5,a2,100 <strncpy+0x26>
    n--;
  }
  return dst;
}
 10a:	6422                	ld	s0,8(sp)
 10c:	0141                	add	sp,sp,16
 10e:	8082                	ret

0000000000000110 <strlen>:

uint
strlen(const char *s)
{
 110:	1141                	add	sp,sp,-16
 112:	e422                	sd	s0,8(sp)
 114:	0800                	add	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 116:	00054783          	lbu	a5,0(a0)
 11a:	cf91                	beqz	a5,136 <strlen+0x26>
 11c:	0505                	add	a0,a0,1
 11e:	87aa                	mv	a5,a0
 120:	86be                	mv	a3,a5
 122:	0785                	add	a5,a5,1
 124:	fff7c703          	lbu	a4,-1(a5)
 128:	ff65                	bnez	a4,120 <strlen+0x10>
 12a:	40a6853b          	subw	a0,a3,a0
 12e:	2505                	addw	a0,a0,1
    ;
  return n;
}
 130:	6422                	ld	s0,8(sp)
 132:	0141                	add	sp,sp,16
 134:	8082                	ret
  for(n = 0; s[n]; n++)
 136:	4501                	li	a0,0
 138:	bfe5                	j	130 <strlen+0x20>

000000000000013a <memset>:

void*
memset(void *dst, int c, uint n)
{
 13a:	1141                	add	sp,sp,-16
 13c:	e422                	sd	s0,8(sp)
 13e:	0800                	add	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 140:	ca19                	beqz	a2,156 <memset+0x1c>
 142:	87aa                	mv	a5,a0
 144:	1602                	sll	a2,a2,0x20
 146:	9201                	srl	a2,a2,0x20
 148:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 14c:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 150:	0785                	add	a5,a5,1
 152:	fee79de3          	bne	a5,a4,14c <memset+0x12>
  }
  return dst;
}
 156:	6422                	ld	s0,8(sp)
 158:	0141                	add	sp,sp,16
 15a:	8082                	ret

000000000000015c <strchr>:

char*
strchr(const char *s, char c)
{
 15c:	1141                	add	sp,sp,-16
 15e:	e422                	sd	s0,8(sp)
 160:	0800                	add	s0,sp,16
  for(; *s; s++)
 162:	00054783          	lbu	a5,0(a0)
 166:	cb99                	beqz	a5,17c <strchr+0x20>
    if(*s == c)
 168:	00f58763          	beq	a1,a5,176 <strchr+0x1a>
  for(; *s; s++)
 16c:	0505                	add	a0,a0,1
 16e:	00054783          	lbu	a5,0(a0)
 172:	fbfd                	bnez	a5,168 <strchr+0xc>
      return (char*)s;
  return 0;
 174:	4501                	li	a0,0
}
 176:	6422                	ld	s0,8(sp)
 178:	0141                	add	sp,sp,16
 17a:	8082                	ret
  return 0;
 17c:	4501                	li	a0,0
 17e:	bfe5                	j	176 <strchr+0x1a>

0000000000000180 <gets>:

char*
gets(char *buf, int max)
{
 180:	711d                	add	sp,sp,-96
 182:	ec86                	sd	ra,88(sp)
 184:	e8a2                	sd	s0,80(sp)
 186:	e4a6                	sd	s1,72(sp)
 188:	e0ca                	sd	s2,64(sp)
 18a:	fc4e                	sd	s3,56(sp)
 18c:	f852                	sd	s4,48(sp)
 18e:	f456                	sd	s5,40(sp)
 190:	f05a                	sd	s6,32(sp)
 192:	ec5e                	sd	s7,24(sp)
 194:	1080                	add	s0,sp,96
 196:	8baa                	mv	s7,a0
 198:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 19a:	892a                	mv	s2,a0
 19c:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 19e:	4aa9                	li	s5,10
 1a0:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 1a2:	89a6                	mv	s3,s1
 1a4:	2485                	addw	s1,s1,1
 1a6:	0344d663          	bge	s1,s4,1d2 <gets+0x52>
    cc = read(0, &c, 1);
 1aa:	4605                	li	a2,1
 1ac:	faf40593          	add	a1,s0,-81
 1b0:	4501                	li	a0,0
 1b2:	252000ef          	jal	404 <read>
    if(cc < 1)
 1b6:	00a05e63          	blez	a0,1d2 <gets+0x52>
    buf[i++] = c;
 1ba:	faf44783          	lbu	a5,-81(s0)
 1be:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 1c2:	01578763          	beq	a5,s5,1d0 <gets+0x50>
 1c6:	0905                	add	s2,s2,1
 1c8:	fd679de3          	bne	a5,s6,1a2 <gets+0x22>
    buf[i++] = c;
 1cc:	89a6                	mv	s3,s1
 1ce:	a011                	j	1d2 <gets+0x52>
 1d0:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 1d2:	99de                	add	s3,s3,s7
 1d4:	00098023          	sb	zero,0(s3)
  return buf;
}
 1d8:	855e                	mv	a0,s7
 1da:	60e6                	ld	ra,88(sp)
 1dc:	6446                	ld	s0,80(sp)
 1de:	64a6                	ld	s1,72(sp)
 1e0:	6906                	ld	s2,64(sp)
 1e2:	79e2                	ld	s3,56(sp)
 1e4:	7a42                	ld	s4,48(sp)
 1e6:	7aa2                	ld	s5,40(sp)
 1e8:	7b02                	ld	s6,32(sp)
 1ea:	6be2                	ld	s7,24(sp)
 1ec:	6125                	add	sp,sp,96
 1ee:	8082                	ret

00000000000001f0 <stat>:

int
stat(const char *n, struct stat *st)
{
 1f0:	1101                	add	sp,sp,-32
 1f2:	ec06                	sd	ra,24(sp)
 1f4:	e822                	sd	s0,16(sp)
 1f6:	e04a                	sd	s2,0(sp)
 1f8:	1000                	add	s0,sp,32
 1fa:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1fc:	4581                	li	a1,0
 1fe:	22e000ef          	jal	42c <open>
  if(fd < 0)
 202:	02054263          	bltz	a0,226 <stat+0x36>
 206:	e426                	sd	s1,8(sp)
 208:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 20a:	85ca                	mv	a1,s2
 20c:	238000ef          	jal	444 <fstat>
 210:	892a                	mv	s2,a0
  close(fd);
 212:	8526                	mv	a0,s1
 214:	200000ef          	jal	414 <close>
  return r;
 218:	64a2                	ld	s1,8(sp)
}
 21a:	854a                	mv	a0,s2
 21c:	60e2                	ld	ra,24(sp)
 21e:	6442                	ld	s0,16(sp)
 220:	6902                	ld	s2,0(sp)
 222:	6105                	add	sp,sp,32
 224:	8082                	ret
    return -1;
 226:	597d                	li	s2,-1
 228:	bfcd                	j	21a <stat+0x2a>

000000000000022a <atoi>:

int
atoi(const char *s)
{
 22a:	1141                	add	sp,sp,-16
 22c:	e422                	sd	s0,8(sp)
 22e:	0800                	add	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 230:	00054683          	lbu	a3,0(a0)
 234:	fd06879b          	addw	a5,a3,-48
 238:	0ff7f793          	zext.b	a5,a5
 23c:	4625                	li	a2,9
 23e:	02f66863          	bltu	a2,a5,26e <atoi+0x44>
 242:	872a                	mv	a4,a0
  n = 0;
 244:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 246:	0705                	add	a4,a4,1
 248:	0025179b          	sllw	a5,a0,0x2
 24c:	9fa9                	addw	a5,a5,a0
 24e:	0017979b          	sllw	a5,a5,0x1
 252:	9fb5                	addw	a5,a5,a3
 254:	fd07851b          	addw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 258:	00074683          	lbu	a3,0(a4)
 25c:	fd06879b          	addw	a5,a3,-48
 260:	0ff7f793          	zext.b	a5,a5
 264:	fef671e3          	bgeu	a2,a5,246 <atoi+0x1c>
  return n;
}
 268:	6422                	ld	s0,8(sp)
 26a:	0141                	add	sp,sp,16
 26c:	8082                	ret
  n = 0;
 26e:	4501                	li	a0,0
 270:	bfe5                	j	268 <atoi+0x3e>

0000000000000272 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 272:	1141                	add	sp,sp,-16
 274:	e422                	sd	s0,8(sp)
 276:	0800                	add	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 278:	02b57463          	bgeu	a0,a1,2a0 <memmove+0x2e>
    while(n-- > 0)
 27c:	00c05f63          	blez	a2,29a <memmove+0x28>
 280:	1602                	sll	a2,a2,0x20
 282:	9201                	srl	a2,a2,0x20
 284:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 288:	872a                	mv	a4,a0
      *dst++ = *src++;
 28a:	0585                	add	a1,a1,1
 28c:	0705                	add	a4,a4,1
 28e:	fff5c683          	lbu	a3,-1(a1)
 292:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 296:	fef71ae3          	bne	a4,a5,28a <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 29a:	6422                	ld	s0,8(sp)
 29c:	0141                	add	sp,sp,16
 29e:	8082                	ret
    dst += n;
 2a0:	00c50733          	add	a4,a0,a2
    src += n;
 2a4:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 2a6:	fec05ae3          	blez	a2,29a <memmove+0x28>
 2aa:	fff6079b          	addw	a5,a2,-1
 2ae:	1782                	sll	a5,a5,0x20
 2b0:	9381                	srl	a5,a5,0x20
 2b2:	fff7c793          	not	a5,a5
 2b6:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 2b8:	15fd                	add	a1,a1,-1
 2ba:	177d                	add	a4,a4,-1
 2bc:	0005c683          	lbu	a3,0(a1)
 2c0:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 2c4:	fee79ae3          	bne	a5,a4,2b8 <memmove+0x46>
 2c8:	bfc9                	j	29a <memmove+0x28>

00000000000002ca <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 2ca:	1141                	add	sp,sp,-16
 2cc:	e422                	sd	s0,8(sp)
 2ce:	0800                	add	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 2d0:	ca05                	beqz	a2,300 <memcmp+0x36>
 2d2:	fff6069b          	addw	a3,a2,-1
 2d6:	1682                	sll	a3,a3,0x20
 2d8:	9281                	srl	a3,a3,0x20
 2da:	0685                	add	a3,a3,1
 2dc:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 2de:	00054783          	lbu	a5,0(a0)
 2e2:	0005c703          	lbu	a4,0(a1)
 2e6:	00e79863          	bne	a5,a4,2f6 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 2ea:	0505                	add	a0,a0,1
    p2++;
 2ec:	0585                	add	a1,a1,1
  while (n-- > 0) {
 2ee:	fed518e3          	bne	a0,a3,2de <memcmp+0x14>
  }
  return 0;
 2f2:	4501                	li	a0,0
 2f4:	a019                	j	2fa <memcmp+0x30>
      return *p1 - *p2;
 2f6:	40e7853b          	subw	a0,a5,a4
}
 2fa:	6422                	ld	s0,8(sp)
 2fc:	0141                	add	sp,sp,16
 2fe:	8082                	ret
  return 0;
 300:	4501                	li	a0,0
 302:	bfe5                	j	2fa <memcmp+0x30>

0000000000000304 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 304:	1141                	add	sp,sp,-16
 306:	e406                	sd	ra,8(sp)
 308:	e022                	sd	s0,0(sp)
 30a:	0800                	add	s0,sp,16
  return memmove(dst, src, n);
 30c:	f67ff0ef          	jal	272 <memmove>
}
 310:	60a2                	ld	ra,8(sp)
 312:	6402                	ld	s0,0(sp)
 314:	0141                	add	sp,sp,16
 316:	8082                	ret

0000000000000318 <sbrk>:

char *
sbrk(int n) {
 318:	1141                	add	sp,sp,-16
 31a:	e406                	sd	ra,8(sp)
 31c:	e022                	sd	s0,0(sp)
 31e:	0800                	add	s0,sp,16
  return sys_sbrk(n, SBRK_EAGER);
 320:	4585                	li	a1,1
 322:	152000ef          	jal	474 <sys_sbrk>
}
 326:	60a2                	ld	ra,8(sp)
 328:	6402                	ld	s0,0(sp)
 32a:	0141                	add	sp,sp,16
 32c:	8082                	ret

000000000000032e <sbrklazy>:

char *
sbrklazy(int n) {
 32e:	1141                	add	sp,sp,-16
 330:	e406                	sd	ra,8(sp)
 332:	e022                	sd	s0,0(sp)
 334:	0800                	add	s0,sp,16
  return sys_sbrk(n, SBRK_LAZY);
 336:	4589                	li	a1,2
 338:	13c000ef          	jal	474 <sys_sbrk>
}
 33c:	60a2                	ld	ra,8(sp)
 33e:	6402                	ld	s0,0(sp)
 340:	0141                	add	sp,sp,16
 342:	8082                	ret

0000000000000344 <htons>:

// Byte order conversion functions
unsigned short
htons(unsigned short hostshort)
{
 344:	1141                	add	sp,sp,-16
 346:	e422                	sd	s0,8(sp)
 348:	0800                	add	s0,sp,16
  return ((hostshort >> 8) & 0xff) | ((hostshort & 0xff) << 8);
 34a:	0085179b          	sllw	a5,a0,0x8
 34e:	0085551b          	srlw	a0,a0,0x8
 352:	8d5d                	or	a0,a0,a5
}
 354:	1542                	sll	a0,a0,0x30
 356:	9141                	srl	a0,a0,0x30
 358:	6422                	ld	s0,8(sp)
 35a:	0141                	add	sp,sp,16
 35c:	8082                	ret

000000000000035e <ntohs>:

unsigned short
ntohs(unsigned short netshort)
{
 35e:	1141                	add	sp,sp,-16
 360:	e422                	sd	s0,8(sp)
 362:	0800                	add	s0,sp,16
  return ((netshort >> 8) & 0xff) | ((netshort & 0xff) << 8);
 364:	0085179b          	sllw	a5,a0,0x8
 368:	0085551b          	srlw	a0,a0,0x8
 36c:	8d5d                	or	a0,a0,a5
}
 36e:	1542                	sll	a0,a0,0x30
 370:	9141                	srl	a0,a0,0x30
 372:	6422                	ld	s0,8(sp)
 374:	0141                	add	sp,sp,16
 376:	8082                	ret

0000000000000378 <htonl>:

unsigned long
htonl(unsigned long hostlong)
{
 378:	1141                	add	sp,sp,-16
 37a:	e422                	sd	s0,8(sp)
 37c:	0800                	add	s0,sp,16
  return ((hostlong >> 24) & 0xff) |
 37e:	0185579b          	srlw	a5,a0,0x18
         ((hostlong >> 8) & 0xff00) |
 382:	00855713          	srl	a4,a0,0x8
 386:	66c1                	lui	a3,0x10
 388:	f0068693          	add	a3,a3,-256 # ff00 <base+0xeef0>
 38c:	8f75                	and	a4,a4,a3
  return ((hostlong >> 24) & 0xff) |
 38e:	8fd9                	or	a5,a5,a4
         ((hostlong & 0xff00) << 8) |
 390:	00851713          	sll	a4,a0,0x8
 394:	00ff06b7          	lui	a3,0xff0
 398:	8f75                	and	a4,a4,a3
         ((hostlong >> 8) & 0xff00) |
 39a:	8fd9                	or	a5,a5,a4
         ((hostlong & 0xff) << 24);
 39c:	0562                	sll	a0,a0,0x18
 39e:	0ff00713          	li	a4,255
 3a2:	0762                	sll	a4,a4,0x18
 3a4:	8d79                	and	a0,a0,a4
}
 3a6:	8d5d                	or	a0,a0,a5
 3a8:	6422                	ld	s0,8(sp)
 3aa:	0141                	add	sp,sp,16
 3ac:	8082                	ret

00000000000003ae <ntohl>:

unsigned long
ntohl(unsigned long netlong)
{
 3ae:	1141                	add	sp,sp,-16
 3b0:	e422                	sd	s0,8(sp)
 3b2:	0800                	add	s0,sp,16
  return ((netlong >> 24) & 0xff) |
 3b4:	0185579b          	srlw	a5,a0,0x18
         ((netlong >> 8) & 0xff00) |
 3b8:	00855713          	srl	a4,a0,0x8
 3bc:	66c1                	lui	a3,0x10
 3be:	f0068693          	add	a3,a3,-256 # ff00 <base+0xeef0>
 3c2:	8f75                	and	a4,a4,a3
  return ((netlong >> 24) & 0xff) |
 3c4:	8fd9                	or	a5,a5,a4
         ((netlong & 0xff00) << 8) |
 3c6:	00851713          	sll	a4,a0,0x8
 3ca:	00ff06b7          	lui	a3,0xff0
 3ce:	8f75                	and	a4,a4,a3
         ((netlong >> 8) & 0xff00) |
 3d0:	8fd9                	or	a5,a5,a4
         ((netlong & 0xff) << 24);
 3d2:	0562                	sll	a0,a0,0x18
 3d4:	0ff00713          	li	a4,255
 3d8:	0762                	sll	a4,a4,0x18
 3da:	8d79                	and	a0,a0,a4
}
 3dc:	8d5d                	or	a0,a0,a5
 3de:	6422                	ld	s0,8(sp)
 3e0:	0141                	add	sp,sp,16
 3e2:	8082                	ret

00000000000003e4 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 3e4:	4885                	li	a7,1
 ecall
 3e6:	00000073          	ecall
 ret
 3ea:	8082                	ret

00000000000003ec <exit>:
.global exit
exit:
 li a7, SYS_exit
 3ec:	4889                	li	a7,2
 ecall
 3ee:	00000073          	ecall
 ret
 3f2:	8082                	ret

00000000000003f4 <wait>:
.global wait
wait:
 li a7, SYS_wait
 3f4:	488d                	li	a7,3
 ecall
 3f6:	00000073          	ecall
 ret
 3fa:	8082                	ret

00000000000003fc <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 3fc:	4891                	li	a7,4
 ecall
 3fe:	00000073          	ecall
 ret
 402:	8082                	ret

0000000000000404 <read>:
.global read
read:
 li a7, SYS_read
 404:	4895                	li	a7,5
 ecall
 406:	00000073          	ecall
 ret
 40a:	8082                	ret

000000000000040c <write>:
.global write
write:
 li a7, SYS_write
 40c:	48c1                	li	a7,16
 ecall
 40e:	00000073          	ecall
 ret
 412:	8082                	ret

0000000000000414 <close>:
.global close
close:
 li a7, SYS_close
 414:	48d5                	li	a7,21
 ecall
 416:	00000073          	ecall
 ret
 41a:	8082                	ret

000000000000041c <kill>:
.global kill
kill:
 li a7, SYS_kill
 41c:	4899                	li	a7,6
 ecall
 41e:	00000073          	ecall
 ret
 422:	8082                	ret

0000000000000424 <exec>:
.global exec
exec:
 li a7, SYS_exec
 424:	489d                	li	a7,7
 ecall
 426:	00000073          	ecall
 ret
 42a:	8082                	ret

000000000000042c <open>:
.global open
open:
 li a7, SYS_open
 42c:	48bd                	li	a7,15
 ecall
 42e:	00000073          	ecall
 ret
 432:	8082                	ret

0000000000000434 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 434:	48c5                	li	a7,17
 ecall
 436:	00000073          	ecall
 ret
 43a:	8082                	ret

000000000000043c <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 43c:	48c9                	li	a7,18
 ecall
 43e:	00000073          	ecall
 ret
 442:	8082                	ret

0000000000000444 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 444:	48a1                	li	a7,8
 ecall
 446:	00000073          	ecall
 ret
 44a:	8082                	ret

000000000000044c <link>:
.global link
link:
 li a7, SYS_link
 44c:	48cd                	li	a7,19
 ecall
 44e:	00000073          	ecall
 ret
 452:	8082                	ret

0000000000000454 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 454:	48d1                	li	a7,20
 ecall
 456:	00000073          	ecall
 ret
 45a:	8082                	ret

000000000000045c <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 45c:	48a5                	li	a7,9
 ecall
 45e:	00000073          	ecall
 ret
 462:	8082                	ret

0000000000000464 <dup>:
.global dup
dup:
 li a7, SYS_dup
 464:	48a9                	li	a7,10
 ecall
 466:	00000073          	ecall
 ret
 46a:	8082                	ret

000000000000046c <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 46c:	48ad                	li	a7,11
 ecall
 46e:	00000073          	ecall
 ret
 472:	8082                	ret

0000000000000474 <sys_sbrk>:
.global sys_sbrk
sys_sbrk:
 li a7, SYS_sbrk
 474:	48b1                	li	a7,12
 ecall
 476:	00000073          	ecall
 ret
 47a:	8082                	ret

000000000000047c <pause>:
.global pause
pause:
 li a7, SYS_pause
 47c:	48b5                	li	a7,13
 ecall
 47e:	00000073          	ecall
 ret
 482:	8082                	ret

0000000000000484 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 484:	48b9                	li	a7,14
 ecall
 486:	00000073          	ecall
 ret
 48a:	8082                	ret

000000000000048c <socket>:
.global socket
socket:
 li a7, SYS_socket
 48c:	48d9                	li	a7,22
 ecall
 48e:	00000073          	ecall
 ret
 492:	8082                	ret

0000000000000494 <bind>:
.global bind
bind:
 li a7, SYS_bind
 494:	48dd                	li	a7,23
 ecall
 496:	00000073          	ecall
 ret
 49a:	8082                	ret

000000000000049c <listen>:
.global listen
listen:
 li a7, SYS_listen
 49c:	48e1                	li	a7,24
 ecall
 49e:	00000073          	ecall
 ret
 4a2:	8082                	ret

00000000000004a4 <accept>:
.global accept
accept:
 li a7, SYS_accept
 4a4:	48e5                	li	a7,25
 ecall
 4a6:	00000073          	ecall
 ret
 4aa:	8082                	ret

00000000000004ac <connect>:
.global connect
connect:
 li a7, SYS_connect
 4ac:	48e9                	li	a7,26
 ecall
 4ae:	00000073          	ecall
 ret
 4b2:	8082                	ret

00000000000004b4 <send>:
.global send
send:
 li a7, SYS_send
 4b4:	48ed                	li	a7,27
 ecall
 4b6:	00000073          	ecall
 ret
 4ba:	8082                	ret

00000000000004bc <recv>:
.global recv
recv:
 li a7, SYS_recv
 4bc:	48f1                	li	a7,28
 ecall
 4be:	00000073          	ecall
 ret
 4c2:	8082                	ret

00000000000004c4 <sendto>:
.global sendto
sendto:
 li a7, SYS_sendto
 4c4:	48f5                	li	a7,29
 ecall
 4c6:	00000073          	ecall
 ret
 4ca:	8082                	ret

00000000000004cc <recvfrom>:
.global recvfrom
recvfrom:
 li a7, SYS_recvfrom
 4cc:	48f9                	li	a7,30
 ecall
 4ce:	00000073          	ecall
 ret
 4d2:	8082                	ret

00000000000004d4 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 4d4:	1101                	add	sp,sp,-32
 4d6:	ec06                	sd	ra,24(sp)
 4d8:	e822                	sd	s0,16(sp)
 4da:	1000                	add	s0,sp,32
 4dc:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 4e0:	4605                	li	a2,1
 4e2:	fef40593          	add	a1,s0,-17
 4e6:	f27ff0ef          	jal	40c <write>
}
 4ea:	60e2                	ld	ra,24(sp)
 4ec:	6442                	ld	s0,16(sp)
 4ee:	6105                	add	sp,sp,32
 4f0:	8082                	ret

00000000000004f2 <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
 4f2:	715d                	add	sp,sp,-80
 4f4:	e486                	sd	ra,72(sp)
 4f6:	e0a2                	sd	s0,64(sp)
 4f8:	f84a                	sd	s2,48(sp)
 4fa:	0880                	add	s0,sp,80
 4fc:	892a                	mv	s2,a0
  char buf[20];
  int i, neg;
  unsigned long long x;

  neg = 0;
  if(sgn && xx < 0){
 4fe:	c299                	beqz	a3,504 <printint+0x12>
 500:	0805c363          	bltz	a1,586 <printint+0x94>
  neg = 0;
 504:	4881                	li	a7,0
 506:	fb840693          	add	a3,s0,-72
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
 50a:	4781                	li	a5,0
  do{
    buf[i++] = digits[x % base];
 50c:	00000517          	auipc	a0,0x0
 510:	50c50513          	add	a0,a0,1292 # a18 <digits>
 514:	883e                	mv	a6,a5
 516:	2785                	addw	a5,a5,1
 518:	02c5f733          	remu	a4,a1,a2
 51c:	972a                	add	a4,a4,a0
 51e:	00074703          	lbu	a4,0(a4)
 522:	00e68023          	sb	a4,0(a3) # ff0000 <base+0xfeeff0>
  }while((x /= base) != 0);
 526:	872e                	mv	a4,a1
 528:	02c5d5b3          	divu	a1,a1,a2
 52c:	0685                	add	a3,a3,1
 52e:	fec773e3          	bgeu	a4,a2,514 <printint+0x22>
  if(neg)
 532:	00088b63          	beqz	a7,548 <printint+0x56>
    buf[i++] = '-';
 536:	fd078793          	add	a5,a5,-48
 53a:	97a2                	add	a5,a5,s0
 53c:	02d00713          	li	a4,45
 540:	fee78423          	sb	a4,-24(a5)
 544:	0028079b          	addw	a5,a6,2

  while(--i >= 0)
 548:	02f05a63          	blez	a5,57c <printint+0x8a>
 54c:	fc26                	sd	s1,56(sp)
 54e:	f44e                	sd	s3,40(sp)
 550:	fb840713          	add	a4,s0,-72
 554:	00f704b3          	add	s1,a4,a5
 558:	fff70993          	add	s3,a4,-1
 55c:	99be                	add	s3,s3,a5
 55e:	37fd                	addw	a5,a5,-1
 560:	1782                	sll	a5,a5,0x20
 562:	9381                	srl	a5,a5,0x20
 564:	40f989b3          	sub	s3,s3,a5
    putc(fd, buf[i]);
 568:	fff4c583          	lbu	a1,-1(s1)
 56c:	854a                	mv	a0,s2
 56e:	f67ff0ef          	jal	4d4 <putc>
  while(--i >= 0)
 572:	14fd                	add	s1,s1,-1
 574:	ff349ae3          	bne	s1,s3,568 <printint+0x76>
 578:	74e2                	ld	s1,56(sp)
 57a:	79a2                	ld	s3,40(sp)
}
 57c:	60a6                	ld	ra,72(sp)
 57e:	6406                	ld	s0,64(sp)
 580:	7942                	ld	s2,48(sp)
 582:	6161                	add	sp,sp,80
 584:	8082                	ret
    x = -xx;
 586:	40b005b3          	neg	a1,a1
    neg = 1;
 58a:	4885                	li	a7,1
    x = -xx;
 58c:	bfad                	j	506 <printint+0x14>

000000000000058e <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %c, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 58e:	711d                	add	sp,sp,-96
 590:	ec86                	sd	ra,88(sp)
 592:	e8a2                	sd	s0,80(sp)
 594:	e0ca                	sd	s2,64(sp)
 596:	1080                	add	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 598:	0005c903          	lbu	s2,0(a1)
 59c:	28090663          	beqz	s2,828 <vprintf+0x29a>
 5a0:	e4a6                	sd	s1,72(sp)
 5a2:	fc4e                	sd	s3,56(sp)
 5a4:	f852                	sd	s4,48(sp)
 5a6:	f456                	sd	s5,40(sp)
 5a8:	f05a                	sd	s6,32(sp)
 5aa:	ec5e                	sd	s7,24(sp)
 5ac:	e862                	sd	s8,16(sp)
 5ae:	e466                	sd	s9,8(sp)
 5b0:	8b2a                	mv	s6,a0
 5b2:	8a2e                	mv	s4,a1
 5b4:	8bb2                	mv	s7,a2
  state = 0;
 5b6:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
 5b8:	4481                	li	s1,0
 5ba:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
 5bc:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
 5c0:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
 5c4:	06c00c93          	li	s9,108
 5c8:	a005                	j	5e8 <vprintf+0x5a>
        putc(fd, c0);
 5ca:	85ca                	mv	a1,s2
 5cc:	855a                	mv	a0,s6
 5ce:	f07ff0ef          	jal	4d4 <putc>
 5d2:	a019                	j	5d8 <vprintf+0x4a>
    } else if(state == '%'){
 5d4:	03598263          	beq	s3,s5,5f8 <vprintf+0x6a>
  for(i = 0; fmt[i]; i++){
 5d8:	2485                	addw	s1,s1,1
 5da:	8726                	mv	a4,s1
 5dc:	009a07b3          	add	a5,s4,s1
 5e0:	0007c903          	lbu	s2,0(a5)
 5e4:	22090a63          	beqz	s2,818 <vprintf+0x28a>
    c0 = fmt[i] & 0xff;
 5e8:	0009079b          	sext.w	a5,s2
    if(state == 0){
 5ec:	fe0994e3          	bnez	s3,5d4 <vprintf+0x46>
      if(c0 == '%'){
 5f0:	fd579de3          	bne	a5,s5,5ca <vprintf+0x3c>
        state = '%';
 5f4:	89be                	mv	s3,a5
 5f6:	b7cd                	j	5d8 <vprintf+0x4a>
      if(c0) c1 = fmt[i+1] & 0xff;
 5f8:	00ea06b3          	add	a3,s4,a4
 5fc:	0016c683          	lbu	a3,1(a3)
      c1 = c2 = 0;
 600:	8636                	mv	a2,a3
      if(c1) c2 = fmt[i+2] & 0xff;
 602:	c681                	beqz	a3,60a <vprintf+0x7c>
 604:	9752                	add	a4,a4,s4
 606:	00274603          	lbu	a2,2(a4)
      if(c0 == 'd'){
 60a:	05878363          	beq	a5,s8,650 <vprintf+0xc2>
      } else if(c0 == 'l' && c1 == 'd'){
 60e:	05978d63          	beq	a5,s9,668 <vprintf+0xda>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
 612:	07500713          	li	a4,117
 616:	0ee78763          	beq	a5,a4,704 <vprintf+0x176>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
 61a:	07800713          	li	a4,120
 61e:	12e78963          	beq	a5,a4,750 <vprintf+0x1c2>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
 622:	07000713          	li	a4,112
 626:	14e78e63          	beq	a5,a4,782 <vprintf+0x1f4>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 'c'){
 62a:	06300713          	li	a4,99
 62e:	18e78e63          	beq	a5,a4,7ca <vprintf+0x23c>
        putc(fd, va_arg(ap, uint32));
      } else if(c0 == 's'){
 632:	07300713          	li	a4,115
 636:	1ae78463          	beq	a5,a4,7de <vprintf+0x250>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
 63a:	02500713          	li	a4,37
 63e:	04e79563          	bne	a5,a4,688 <vprintf+0xfa>
        putc(fd, '%');
 642:	02500593          	li	a1,37
 646:	855a                	mv	a0,s6
 648:	e8dff0ef          	jal	4d4 <putc>
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c0);
      }

      state = 0;
 64c:	4981                	li	s3,0
 64e:	b769                	j	5d8 <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 1);
 650:	008b8913          	add	s2,s7,8
 654:	4685                	li	a3,1
 656:	4629                	li	a2,10
 658:	000ba583          	lw	a1,0(s7)
 65c:	855a                	mv	a0,s6
 65e:	e95ff0ef          	jal	4f2 <printint>
 662:	8bca                	mv	s7,s2
      state = 0;
 664:	4981                	li	s3,0
 666:	bf8d                	j	5d8 <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'd'){
 668:	06400793          	li	a5,100
 66c:	02f68963          	beq	a3,a5,69e <vprintf+0x110>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 670:	06c00793          	li	a5,108
 674:	04f68263          	beq	a3,a5,6b8 <vprintf+0x12a>
      } else if(c0 == 'l' && c1 == 'u'){
 678:	07500793          	li	a5,117
 67c:	0af68063          	beq	a3,a5,71c <vprintf+0x18e>
      } else if(c0 == 'l' && c1 == 'x'){
 680:	07800793          	li	a5,120
 684:	0ef68263          	beq	a3,a5,768 <vprintf+0x1da>
        putc(fd, '%');
 688:	02500593          	li	a1,37
 68c:	855a                	mv	a0,s6
 68e:	e47ff0ef          	jal	4d4 <putc>
        putc(fd, c0);
 692:	85ca                	mv	a1,s2
 694:	855a                	mv	a0,s6
 696:	e3fff0ef          	jal	4d4 <putc>
      state = 0;
 69a:	4981                	li	s3,0
 69c:	bf35                	j	5d8 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 69e:	008b8913          	add	s2,s7,8
 6a2:	4685                	li	a3,1
 6a4:	4629                	li	a2,10
 6a6:	000bb583          	ld	a1,0(s7)
 6aa:	855a                	mv	a0,s6
 6ac:	e47ff0ef          	jal	4f2 <printint>
        i += 1;
 6b0:	2485                	addw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 6b2:	8bca                	mv	s7,s2
      state = 0;
 6b4:	4981                	li	s3,0
        i += 1;
 6b6:	b70d                	j	5d8 <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 6b8:	06400793          	li	a5,100
 6bc:	02f60763          	beq	a2,a5,6ea <vprintf+0x15c>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 6c0:	07500793          	li	a5,117
 6c4:	06f60963          	beq	a2,a5,736 <vprintf+0x1a8>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 6c8:	07800793          	li	a5,120
 6cc:	faf61ee3          	bne	a2,a5,688 <vprintf+0xfa>
        printint(fd, va_arg(ap, uint64), 16, 0);
 6d0:	008b8913          	add	s2,s7,8
 6d4:	4681                	li	a3,0
 6d6:	4641                	li	a2,16
 6d8:	000bb583          	ld	a1,0(s7)
 6dc:	855a                	mv	a0,s6
 6de:	e15ff0ef          	jal	4f2 <printint>
        i += 2;
 6e2:	2489                	addw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 6e4:	8bca                	mv	s7,s2
      state = 0;
 6e6:	4981                	li	s3,0
        i += 2;
 6e8:	bdc5                	j	5d8 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 6ea:	008b8913          	add	s2,s7,8
 6ee:	4685                	li	a3,1
 6f0:	4629                	li	a2,10
 6f2:	000bb583          	ld	a1,0(s7)
 6f6:	855a                	mv	a0,s6
 6f8:	dfbff0ef          	jal	4f2 <printint>
        i += 2;
 6fc:	2489                	addw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 6fe:	8bca                	mv	s7,s2
      state = 0;
 700:	4981                	li	s3,0
        i += 2;
 702:	bdd9                	j	5d8 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint32), 10, 0);
 704:	008b8913          	add	s2,s7,8
 708:	4681                	li	a3,0
 70a:	4629                	li	a2,10
 70c:	000be583          	lwu	a1,0(s7)
 710:	855a                	mv	a0,s6
 712:	de1ff0ef          	jal	4f2 <printint>
 716:	8bca                	mv	s7,s2
      state = 0;
 718:	4981                	li	s3,0
 71a:	bd7d                	j	5d8 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 71c:	008b8913          	add	s2,s7,8
 720:	4681                	li	a3,0
 722:	4629                	li	a2,10
 724:	000bb583          	ld	a1,0(s7)
 728:	855a                	mv	a0,s6
 72a:	dc9ff0ef          	jal	4f2 <printint>
        i += 1;
 72e:	2485                	addw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 730:	8bca                	mv	s7,s2
      state = 0;
 732:	4981                	li	s3,0
        i += 1;
 734:	b555                	j	5d8 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 736:	008b8913          	add	s2,s7,8
 73a:	4681                	li	a3,0
 73c:	4629                	li	a2,10
 73e:	000bb583          	ld	a1,0(s7)
 742:	855a                	mv	a0,s6
 744:	dafff0ef          	jal	4f2 <printint>
        i += 2;
 748:	2489                	addw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 74a:	8bca                	mv	s7,s2
      state = 0;
 74c:	4981                	li	s3,0
        i += 2;
 74e:	b569                	j	5d8 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint32), 16, 0);
 750:	008b8913          	add	s2,s7,8
 754:	4681                	li	a3,0
 756:	4641                	li	a2,16
 758:	000be583          	lwu	a1,0(s7)
 75c:	855a                	mv	a0,s6
 75e:	d95ff0ef          	jal	4f2 <printint>
 762:	8bca                	mv	s7,s2
      state = 0;
 764:	4981                	li	s3,0
 766:	bd8d                	j	5d8 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 16, 0);
 768:	008b8913          	add	s2,s7,8
 76c:	4681                	li	a3,0
 76e:	4641                	li	a2,16
 770:	000bb583          	ld	a1,0(s7)
 774:	855a                	mv	a0,s6
 776:	d7dff0ef          	jal	4f2 <printint>
        i += 1;
 77a:	2485                	addw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 77c:	8bca                	mv	s7,s2
      state = 0;
 77e:	4981                	li	s3,0
        i += 1;
 780:	bda1                	j	5d8 <vprintf+0x4a>
 782:	e06a                	sd	s10,0(sp)
        printptr(fd, va_arg(ap, uint64));
 784:	008b8d13          	add	s10,s7,8
 788:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 78c:	03000593          	li	a1,48
 790:	855a                	mv	a0,s6
 792:	d43ff0ef          	jal	4d4 <putc>
  putc(fd, 'x');
 796:	07800593          	li	a1,120
 79a:	855a                	mv	a0,s6
 79c:	d39ff0ef          	jal	4d4 <putc>
 7a0:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 7a2:	00000b97          	auipc	s7,0x0
 7a6:	276b8b93          	add	s7,s7,630 # a18 <digits>
 7aa:	03c9d793          	srl	a5,s3,0x3c
 7ae:	97de                	add	a5,a5,s7
 7b0:	0007c583          	lbu	a1,0(a5)
 7b4:	855a                	mv	a0,s6
 7b6:	d1fff0ef          	jal	4d4 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 7ba:	0992                	sll	s3,s3,0x4
 7bc:	397d                	addw	s2,s2,-1
 7be:	fe0916e3          	bnez	s2,7aa <vprintf+0x21c>
        printptr(fd, va_arg(ap, uint64));
 7c2:	8bea                	mv	s7,s10
      state = 0;
 7c4:	4981                	li	s3,0
 7c6:	6d02                	ld	s10,0(sp)
 7c8:	bd01                	j	5d8 <vprintf+0x4a>
        putc(fd, va_arg(ap, uint32));
 7ca:	008b8913          	add	s2,s7,8
 7ce:	000bc583          	lbu	a1,0(s7)
 7d2:	855a                	mv	a0,s6
 7d4:	d01ff0ef          	jal	4d4 <putc>
 7d8:	8bca                	mv	s7,s2
      state = 0;
 7da:	4981                	li	s3,0
 7dc:	bbf5                	j	5d8 <vprintf+0x4a>
        if((s = va_arg(ap, char*)) == 0)
 7de:	008b8993          	add	s3,s7,8
 7e2:	000bb903          	ld	s2,0(s7)
 7e6:	00090f63          	beqz	s2,804 <vprintf+0x276>
        for(; *s; s++)
 7ea:	00094583          	lbu	a1,0(s2)
 7ee:	c195                	beqz	a1,812 <vprintf+0x284>
          putc(fd, *s);
 7f0:	855a                	mv	a0,s6
 7f2:	ce3ff0ef          	jal	4d4 <putc>
        for(; *s; s++)
 7f6:	0905                	add	s2,s2,1
 7f8:	00094583          	lbu	a1,0(s2)
 7fc:	f9f5                	bnez	a1,7f0 <vprintf+0x262>
        if((s = va_arg(ap, char*)) == 0)
 7fe:	8bce                	mv	s7,s3
      state = 0;
 800:	4981                	li	s3,0
 802:	bbd9                	j	5d8 <vprintf+0x4a>
          s = "(null)";
 804:	00000917          	auipc	s2,0x0
 808:	20c90913          	add	s2,s2,524 # a10 <malloc+0x100>
        for(; *s; s++)
 80c:	02800593          	li	a1,40
 810:	b7c5                	j	7f0 <vprintf+0x262>
        if((s = va_arg(ap, char*)) == 0)
 812:	8bce                	mv	s7,s3
      state = 0;
 814:	4981                	li	s3,0
 816:	b3c9                	j	5d8 <vprintf+0x4a>
 818:	64a6                	ld	s1,72(sp)
 81a:	79e2                	ld	s3,56(sp)
 81c:	7a42                	ld	s4,48(sp)
 81e:	7aa2                	ld	s5,40(sp)
 820:	7b02                	ld	s6,32(sp)
 822:	6be2                	ld	s7,24(sp)
 824:	6c42                	ld	s8,16(sp)
 826:	6ca2                	ld	s9,8(sp)
    }
  }
}
 828:	60e6                	ld	ra,88(sp)
 82a:	6446                	ld	s0,80(sp)
 82c:	6906                	ld	s2,64(sp)
 82e:	6125                	add	sp,sp,96
 830:	8082                	ret

0000000000000832 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 832:	715d                	add	sp,sp,-80
 834:	ec06                	sd	ra,24(sp)
 836:	e822                	sd	s0,16(sp)
 838:	1000                	add	s0,sp,32
 83a:	e010                	sd	a2,0(s0)
 83c:	e414                	sd	a3,8(s0)
 83e:	e818                	sd	a4,16(s0)
 840:	ec1c                	sd	a5,24(s0)
 842:	03043023          	sd	a6,32(s0)
 846:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 84a:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 84e:	8622                	mv	a2,s0
 850:	d3fff0ef          	jal	58e <vprintf>
}
 854:	60e2                	ld	ra,24(sp)
 856:	6442                	ld	s0,16(sp)
 858:	6161                	add	sp,sp,80
 85a:	8082                	ret

000000000000085c <printf>:

void
printf(const char *fmt, ...)
{
 85c:	711d                	add	sp,sp,-96
 85e:	ec06                	sd	ra,24(sp)
 860:	e822                	sd	s0,16(sp)
 862:	1000                	add	s0,sp,32
 864:	e40c                	sd	a1,8(s0)
 866:	e810                	sd	a2,16(s0)
 868:	ec14                	sd	a3,24(s0)
 86a:	f018                	sd	a4,32(s0)
 86c:	f41c                	sd	a5,40(s0)
 86e:	03043823          	sd	a6,48(s0)
 872:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 876:	00840613          	add	a2,s0,8
 87a:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 87e:	85aa                	mv	a1,a0
 880:	4505                	li	a0,1
 882:	d0dff0ef          	jal	58e <vprintf>
}
 886:	60e2                	ld	ra,24(sp)
 888:	6442                	ld	s0,16(sp)
 88a:	6125                	add	sp,sp,96
 88c:	8082                	ret

000000000000088e <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 88e:	1141                	add	sp,sp,-16
 890:	e422                	sd	s0,8(sp)
 892:	0800                	add	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 894:	ff050693          	add	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 898:	00000797          	auipc	a5,0x0
 89c:	7687b783          	ld	a5,1896(a5) # 1000 <freep>
 8a0:	a02d                	j	8ca <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 8a2:	4618                	lw	a4,8(a2)
 8a4:	9f2d                	addw	a4,a4,a1
 8a6:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 8aa:	6398                	ld	a4,0(a5)
 8ac:	6310                	ld	a2,0(a4)
 8ae:	a83d                	j	8ec <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 8b0:	ff852703          	lw	a4,-8(a0)
 8b4:	9f31                	addw	a4,a4,a2
 8b6:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 8b8:	ff053683          	ld	a3,-16(a0)
 8bc:	a091                	j	900 <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8be:	6398                	ld	a4,0(a5)
 8c0:	00e7e463          	bltu	a5,a4,8c8 <free+0x3a>
 8c4:	00e6ea63          	bltu	a3,a4,8d8 <free+0x4a>
{
 8c8:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8ca:	fed7fae3          	bgeu	a5,a3,8be <free+0x30>
 8ce:	6398                	ld	a4,0(a5)
 8d0:	00e6e463          	bltu	a3,a4,8d8 <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8d4:	fee7eae3          	bltu	a5,a4,8c8 <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 8d8:	ff852583          	lw	a1,-8(a0)
 8dc:	6390                	ld	a2,0(a5)
 8de:	02059813          	sll	a6,a1,0x20
 8e2:	01c85713          	srl	a4,a6,0x1c
 8e6:	9736                	add	a4,a4,a3
 8e8:	fae60de3          	beq	a2,a4,8a2 <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 8ec:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 8f0:	4790                	lw	a2,8(a5)
 8f2:	02061593          	sll	a1,a2,0x20
 8f6:	01c5d713          	srl	a4,a1,0x1c
 8fa:	973e                	add	a4,a4,a5
 8fc:	fae68ae3          	beq	a3,a4,8b0 <free+0x22>
    p->s.ptr = bp->s.ptr;
 900:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 902:	00000717          	auipc	a4,0x0
 906:	6ef73f23          	sd	a5,1790(a4) # 1000 <freep>
}
 90a:	6422                	ld	s0,8(sp)
 90c:	0141                	add	sp,sp,16
 90e:	8082                	ret

0000000000000910 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 910:	7139                	add	sp,sp,-64
 912:	fc06                	sd	ra,56(sp)
 914:	f822                	sd	s0,48(sp)
 916:	f426                	sd	s1,40(sp)
 918:	ec4e                	sd	s3,24(sp)
 91a:	0080                	add	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 91c:	02051493          	sll	s1,a0,0x20
 920:	9081                	srl	s1,s1,0x20
 922:	04bd                	add	s1,s1,15
 924:	8091                	srl	s1,s1,0x4
 926:	0014899b          	addw	s3,s1,1
 92a:	0485                	add	s1,s1,1
  if((prevp = freep) == 0){
 92c:	00000517          	auipc	a0,0x0
 930:	6d453503          	ld	a0,1748(a0) # 1000 <freep>
 934:	c915                	beqz	a0,968 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 936:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 938:	4798                	lw	a4,8(a5)
 93a:	08977a63          	bgeu	a4,s1,9ce <malloc+0xbe>
 93e:	f04a                	sd	s2,32(sp)
 940:	e852                	sd	s4,16(sp)
 942:	e456                	sd	s5,8(sp)
 944:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 946:	8a4e                	mv	s4,s3
 948:	0009871b          	sext.w	a4,s3
 94c:	6685                	lui	a3,0x1
 94e:	00d77363          	bgeu	a4,a3,954 <malloc+0x44>
 952:	6a05                	lui	s4,0x1
 954:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 958:	004a1a1b          	sllw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 95c:	00000917          	auipc	s2,0x0
 960:	6a490913          	add	s2,s2,1700 # 1000 <freep>
  if(p == SBRK_ERROR)
 964:	5afd                	li	s5,-1
 966:	a081                	j	9a6 <malloc+0x96>
 968:	f04a                	sd	s2,32(sp)
 96a:	e852                	sd	s4,16(sp)
 96c:	e456                	sd	s5,8(sp)
 96e:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 970:	00000797          	auipc	a5,0x0
 974:	6a078793          	add	a5,a5,1696 # 1010 <base>
 978:	00000717          	auipc	a4,0x0
 97c:	68f73423          	sd	a5,1672(a4) # 1000 <freep>
 980:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 982:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 986:	b7c1                	j	946 <malloc+0x36>
        prevp->s.ptr = p->s.ptr;
 988:	6398                	ld	a4,0(a5)
 98a:	e118                	sd	a4,0(a0)
 98c:	a8a9                	j	9e6 <malloc+0xd6>
  hp->s.size = nu;
 98e:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 992:	0541                	add	a0,a0,16
 994:	efbff0ef          	jal	88e <free>
  return freep;
 998:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 99c:	c12d                	beqz	a0,9fe <malloc+0xee>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 99e:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 9a0:	4798                	lw	a4,8(a5)
 9a2:	02977263          	bgeu	a4,s1,9c6 <malloc+0xb6>
    if(p == freep)
 9a6:	00093703          	ld	a4,0(s2)
 9aa:	853e                	mv	a0,a5
 9ac:	fef719e3          	bne	a4,a5,99e <malloc+0x8e>
  p = sbrk(nu * sizeof(Header));
 9b0:	8552                	mv	a0,s4
 9b2:	967ff0ef          	jal	318 <sbrk>
  if(p == SBRK_ERROR)
 9b6:	fd551ce3          	bne	a0,s5,98e <malloc+0x7e>
        return 0;
 9ba:	4501                	li	a0,0
 9bc:	7902                	ld	s2,32(sp)
 9be:	6a42                	ld	s4,16(sp)
 9c0:	6aa2                	ld	s5,8(sp)
 9c2:	6b02                	ld	s6,0(sp)
 9c4:	a03d                	j	9f2 <malloc+0xe2>
 9c6:	7902                	ld	s2,32(sp)
 9c8:	6a42                	ld	s4,16(sp)
 9ca:	6aa2                	ld	s5,8(sp)
 9cc:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 9ce:	fae48de3          	beq	s1,a4,988 <malloc+0x78>
        p->s.size -= nunits;
 9d2:	4137073b          	subw	a4,a4,s3
 9d6:	c798                	sw	a4,8(a5)
        p += p->s.size;
 9d8:	02071693          	sll	a3,a4,0x20
 9dc:	01c6d713          	srl	a4,a3,0x1c
 9e0:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 9e2:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 9e6:	00000717          	auipc	a4,0x0
 9ea:	60a73d23          	sd	a0,1562(a4) # 1000 <freep>
      return (void*)(p + 1);
 9ee:	01078513          	add	a0,a5,16
  }
}
 9f2:	70e2                	ld	ra,56(sp)
 9f4:	7442                	ld	s0,48(sp)
 9f6:	74a2                	ld	s1,40(sp)
 9f8:	69e2                	ld	s3,24(sp)
 9fa:	6121                	add	sp,sp,64
 9fc:	8082                	ret
 9fe:	7902                	ld	s2,32(sp)
 a00:	6a42                	ld	s4,16(sp)
 a02:	6aa2                	ld	s5,8(sp)
 a04:	6b02                	ld	s6,0(sp)
 a06:	b7f5                	j	9f2 <malloc+0xe2>
