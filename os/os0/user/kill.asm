
user/_kill:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/stat.h"
#include "user/user.h"

int
main(int argc, char **argv)
{
   0:	1101                	add	sp,sp,-32
   2:	ec06                	sd	ra,24(sp)
   4:	e822                	sd	s0,16(sp)
   6:	1000                	add	s0,sp,32
  int i;

  if(argc < 2){
   8:	4785                	li	a5,1
   a:	02a7d963          	bge	a5,a0,3c <main+0x3c>
   e:	e426                	sd	s1,8(sp)
  10:	e04a                	sd	s2,0(sp)
  12:	00858493          	add	s1,a1,8
  16:	ffe5091b          	addw	s2,a0,-2
  1a:	02091793          	sll	a5,s2,0x20
  1e:	01d7d913          	srl	s2,a5,0x1d
  22:	05c1                	add	a1,a1,16
  24:	992e                	add	s2,s2,a1
    fprintf(2, "usage: kill pid...\n");
    exit(1);
  }
  for(i=1; i<argc; i++)
    kill(atoi(argv[i]));
  26:	6088                	ld	a0,0(s1)
  28:	238000ef          	jal	260 <atoi>
  2c:	426000ef          	jal	452 <kill>
  for(i=1; i<argc; i++)
  30:	04a1                	add	s1,s1,8
  32:	ff249ae3          	bne	s1,s2,26 <main+0x26>
  exit(0);
  36:	4501                	li	a0,0
  38:	3ea000ef          	jal	422 <exit>
  3c:	e426                	sd	s1,8(sp)
  3e:	e04a                	sd	s2,0(sp)
    fprintf(2, "usage: kill pid...\n");
  40:	00001597          	auipc	a1,0x1
  44:	a0058593          	add	a1,a1,-1536 # a40 <malloc+0xfa>
  48:	4509                	li	a0,2
  4a:	01f000ef          	jal	868 <fprintf>
    exit(1);
  4e:	4505                	li	a0,1
  50:	3d2000ef          	jal	422 <exit>

0000000000000054 <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start(int argc, char **argv)
{
  54:	1141                	add	sp,sp,-16
  56:	e406                	sd	ra,8(sp)
  58:	e022                	sd	s0,0(sp)
  5a:	0800                	add	s0,sp,16
  int r;
  extern int main(int argc, char **argv);
  r = main(argc, argv);
  5c:	fa5ff0ef          	jal	0 <main>
  exit(r);
  60:	3c2000ef          	jal	422 <exit>

0000000000000064 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
  64:	1141                	add	sp,sp,-16
  66:	e422                	sd	s0,8(sp)
  68:	0800                	add	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  6a:	87aa                	mv	a5,a0
  6c:	0585                	add	a1,a1,1
  6e:	0785                	add	a5,a5,1
  70:	fff5c703          	lbu	a4,-1(a1)
  74:	fee78fa3          	sb	a4,-1(a5)
  78:	fb75                	bnez	a4,6c <strcpy+0x8>
    ;
  return os;
}
  7a:	6422                	ld	s0,8(sp)
  7c:	0141                	add	sp,sp,16
  7e:	8082                	ret

0000000000000080 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  80:	1141                	add	sp,sp,-16
  82:	e422                	sd	s0,8(sp)
  84:	0800                	add	s0,sp,16
  while(*p && *p == *q)
  86:	00054783          	lbu	a5,0(a0)
  8a:	cb91                	beqz	a5,9e <strcmp+0x1e>
  8c:	0005c703          	lbu	a4,0(a1)
  90:	00f71763          	bne	a4,a5,9e <strcmp+0x1e>
    p++, q++;
  94:	0505                	add	a0,a0,1
  96:	0585                	add	a1,a1,1
  while(*p && *p == *q)
  98:	00054783          	lbu	a5,0(a0)
  9c:	fbe5                	bnez	a5,8c <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
  9e:	0005c503          	lbu	a0,0(a1)
}
  a2:	40a7853b          	subw	a0,a5,a0
  a6:	6422                	ld	s0,8(sp)
  a8:	0141                	add	sp,sp,16
  aa:	8082                	ret

00000000000000ac <strncmp>:

int
strncmp(const char *p, const char *q, uint n)
{
  ac:	1141                	add	sp,sp,-16
  ae:	e422                	sd	s0,8(sp)
  b0:	0800                	add	s0,sp,16
  while(n > 0 && *p && *p == *q) {
  b2:	ce11                	beqz	a2,ce <strncmp+0x22>
  b4:	00054783          	lbu	a5,0(a0)
  b8:	cf89                	beqz	a5,d2 <strncmp+0x26>
  ba:	0005c703          	lbu	a4,0(a1)
  be:	00f71a63          	bne	a4,a5,d2 <strncmp+0x26>
    p++, q++, n--;
  c2:	0505                	add	a0,a0,1
  c4:	0585                	add	a1,a1,1
  c6:	367d                	addw	a2,a2,-1
  while(n > 0 && *p && *p == *q) {
  c8:	f675                	bnez	a2,b4 <strncmp+0x8>
  }
  if (n == 0)
    return 0;
  ca:	4501                	li	a0,0
  cc:	a801                	j	dc <strncmp+0x30>
  ce:	4501                	li	a0,0
  d0:	a031                	j	dc <strncmp+0x30>
  return (uchar)*p - (uchar)*q;
  d2:	00054503          	lbu	a0,0(a0)
  d6:	0005c783          	lbu	a5,0(a1)
  da:	9d1d                	subw	a0,a0,a5
}
  dc:	6422                	ld	s0,8(sp)
  de:	0141                	add	sp,sp,16
  e0:	8082                	ret

00000000000000e2 <strcat>:

char*
strcat(char *dst, const char *src)
{
  e2:	1141                	add	sp,sp,-16
  e4:	e422                	sd	s0,8(sp)
  e6:	0800                	add	s0,sp,16
  char *p = dst;
  while(*p) p++;
  e8:	00054783          	lbu	a5,0(a0)
  ec:	c385                	beqz	a5,10c <strcat+0x2a>
  char *p = dst;
  ee:	87aa                	mv	a5,a0
  while(*p) p++;
  f0:	0785                	add	a5,a5,1
  f2:	0007c703          	lbu	a4,0(a5)
  f6:	ff6d                	bnez	a4,f0 <strcat+0xe>
  while((*p++ = *src++) != 0);
  f8:	0585                	add	a1,a1,1
  fa:	0785                	add	a5,a5,1
  fc:	fff5c703          	lbu	a4,-1(a1)
 100:	fee78fa3          	sb	a4,-1(a5)
 104:	fb75                	bnez	a4,f8 <strcat+0x16>
  return dst;
}
 106:	6422                	ld	s0,8(sp)
 108:	0141                	add	sp,sp,16
 10a:	8082                	ret
  char *p = dst;
 10c:	87aa                	mv	a5,a0
 10e:	b7ed                	j	f8 <strcat+0x16>

0000000000000110 <strncpy>:

char*
strncpy(char *dst, const char *src, int n)
{
 110:	1141                	add	sp,sp,-16
 112:	e422                	sd	s0,8(sp)
 114:	0800                	add	s0,sp,16
  char *p = dst;
 116:	87aa                	mv	a5,a0
  while(n > 0 && *src) {
 118:	02c05463          	blez	a2,140 <strncpy+0x30>
 11c:	0005c703          	lbu	a4,0(a1)
 120:	cb01                	beqz	a4,130 <strncpy+0x20>
    *p++ = *src++;
 122:	0585                	add	a1,a1,1
 124:	0785                	add	a5,a5,1
 126:	fee78fa3          	sb	a4,-1(a5)
    n--;
 12a:	367d                	addw	a2,a2,-1
  while(n > 0 && *src) {
 12c:	fa65                	bnez	a2,11c <strncpy+0xc>
 12e:	a809                	j	140 <strncpy+0x30>
  }
  while(n > 0) {
 130:	1602                	sll	a2,a2,0x20
 132:	9201                	srl	a2,a2,0x20
 134:	963e                	add	a2,a2,a5
    *p++ = 0;
 136:	0785                	add	a5,a5,1
 138:	fe078fa3          	sb	zero,-1(a5)
  while(n > 0) {
 13c:	fec79de3          	bne	a5,a2,136 <strncpy+0x26>
    n--;
  }
  return dst;
}
 140:	6422                	ld	s0,8(sp)
 142:	0141                	add	sp,sp,16
 144:	8082                	ret

0000000000000146 <strlen>:

uint
strlen(const char *s)
{
 146:	1141                	add	sp,sp,-16
 148:	e422                	sd	s0,8(sp)
 14a:	0800                	add	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 14c:	00054783          	lbu	a5,0(a0)
 150:	cf91                	beqz	a5,16c <strlen+0x26>
 152:	0505                	add	a0,a0,1
 154:	87aa                	mv	a5,a0
 156:	86be                	mv	a3,a5
 158:	0785                	add	a5,a5,1
 15a:	fff7c703          	lbu	a4,-1(a5)
 15e:	ff65                	bnez	a4,156 <strlen+0x10>
 160:	40a6853b          	subw	a0,a3,a0
 164:	2505                	addw	a0,a0,1
    ;
  return n;
}
 166:	6422                	ld	s0,8(sp)
 168:	0141                	add	sp,sp,16
 16a:	8082                	ret
  for(n = 0; s[n]; n++)
 16c:	4501                	li	a0,0
 16e:	bfe5                	j	166 <strlen+0x20>

0000000000000170 <memset>:

void*
memset(void *dst, int c, uint n)
{
 170:	1141                	add	sp,sp,-16
 172:	e422                	sd	s0,8(sp)
 174:	0800                	add	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 176:	ca19                	beqz	a2,18c <memset+0x1c>
 178:	87aa                	mv	a5,a0
 17a:	1602                	sll	a2,a2,0x20
 17c:	9201                	srl	a2,a2,0x20
 17e:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 182:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 186:	0785                	add	a5,a5,1
 188:	fee79de3          	bne	a5,a4,182 <memset+0x12>
  }
  return dst;
}
 18c:	6422                	ld	s0,8(sp)
 18e:	0141                	add	sp,sp,16
 190:	8082                	ret

0000000000000192 <strchr>:

char*
strchr(const char *s, char c)
{
 192:	1141                	add	sp,sp,-16
 194:	e422                	sd	s0,8(sp)
 196:	0800                	add	s0,sp,16
  for(; *s; s++)
 198:	00054783          	lbu	a5,0(a0)
 19c:	cb99                	beqz	a5,1b2 <strchr+0x20>
    if(*s == c)
 19e:	00f58763          	beq	a1,a5,1ac <strchr+0x1a>
  for(; *s; s++)
 1a2:	0505                	add	a0,a0,1
 1a4:	00054783          	lbu	a5,0(a0)
 1a8:	fbfd                	bnez	a5,19e <strchr+0xc>
      return (char*)s;
  return 0;
 1aa:	4501                	li	a0,0
}
 1ac:	6422                	ld	s0,8(sp)
 1ae:	0141                	add	sp,sp,16
 1b0:	8082                	ret
  return 0;
 1b2:	4501                	li	a0,0
 1b4:	bfe5                	j	1ac <strchr+0x1a>

00000000000001b6 <gets>:

char*
gets(char *buf, int max)
{
 1b6:	711d                	add	sp,sp,-96
 1b8:	ec86                	sd	ra,88(sp)
 1ba:	e8a2                	sd	s0,80(sp)
 1bc:	e4a6                	sd	s1,72(sp)
 1be:	e0ca                	sd	s2,64(sp)
 1c0:	fc4e                	sd	s3,56(sp)
 1c2:	f852                	sd	s4,48(sp)
 1c4:	f456                	sd	s5,40(sp)
 1c6:	f05a                	sd	s6,32(sp)
 1c8:	ec5e                	sd	s7,24(sp)
 1ca:	1080                	add	s0,sp,96
 1cc:	8baa                	mv	s7,a0
 1ce:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1d0:	892a                	mv	s2,a0
 1d2:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 1d4:	4aa9                	li	s5,10
 1d6:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 1d8:	89a6                	mv	s3,s1
 1da:	2485                	addw	s1,s1,1
 1dc:	0344d663          	bge	s1,s4,208 <gets+0x52>
    cc = read(0, &c, 1);
 1e0:	4605                	li	a2,1
 1e2:	faf40593          	add	a1,s0,-81
 1e6:	4501                	li	a0,0
 1e8:	252000ef          	jal	43a <read>
    if(cc < 1)
 1ec:	00a05e63          	blez	a0,208 <gets+0x52>
    buf[i++] = c;
 1f0:	faf44783          	lbu	a5,-81(s0)
 1f4:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 1f8:	01578763          	beq	a5,s5,206 <gets+0x50>
 1fc:	0905                	add	s2,s2,1
 1fe:	fd679de3          	bne	a5,s6,1d8 <gets+0x22>
    buf[i++] = c;
 202:	89a6                	mv	s3,s1
 204:	a011                	j	208 <gets+0x52>
 206:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 208:	99de                	add	s3,s3,s7
 20a:	00098023          	sb	zero,0(s3)
  return buf;
}
 20e:	855e                	mv	a0,s7
 210:	60e6                	ld	ra,88(sp)
 212:	6446                	ld	s0,80(sp)
 214:	64a6                	ld	s1,72(sp)
 216:	6906                	ld	s2,64(sp)
 218:	79e2                	ld	s3,56(sp)
 21a:	7a42                	ld	s4,48(sp)
 21c:	7aa2                	ld	s5,40(sp)
 21e:	7b02                	ld	s6,32(sp)
 220:	6be2                	ld	s7,24(sp)
 222:	6125                	add	sp,sp,96
 224:	8082                	ret

0000000000000226 <stat>:

int
stat(const char *n, struct stat *st)
{
 226:	1101                	add	sp,sp,-32
 228:	ec06                	sd	ra,24(sp)
 22a:	e822                	sd	s0,16(sp)
 22c:	e04a                	sd	s2,0(sp)
 22e:	1000                	add	s0,sp,32
 230:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 232:	4581                	li	a1,0
 234:	22e000ef          	jal	462 <open>
  if(fd < 0)
 238:	02054263          	bltz	a0,25c <stat+0x36>
 23c:	e426                	sd	s1,8(sp)
 23e:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 240:	85ca                	mv	a1,s2
 242:	238000ef          	jal	47a <fstat>
 246:	892a                	mv	s2,a0
  close(fd);
 248:	8526                	mv	a0,s1
 24a:	200000ef          	jal	44a <close>
  return r;
 24e:	64a2                	ld	s1,8(sp)
}
 250:	854a                	mv	a0,s2
 252:	60e2                	ld	ra,24(sp)
 254:	6442                	ld	s0,16(sp)
 256:	6902                	ld	s2,0(sp)
 258:	6105                	add	sp,sp,32
 25a:	8082                	ret
    return -1;
 25c:	597d                	li	s2,-1
 25e:	bfcd                	j	250 <stat+0x2a>

0000000000000260 <atoi>:

int
atoi(const char *s)
{
 260:	1141                	add	sp,sp,-16
 262:	e422                	sd	s0,8(sp)
 264:	0800                	add	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 266:	00054683          	lbu	a3,0(a0)
 26a:	fd06879b          	addw	a5,a3,-48
 26e:	0ff7f793          	zext.b	a5,a5
 272:	4625                	li	a2,9
 274:	02f66863          	bltu	a2,a5,2a4 <atoi+0x44>
 278:	872a                	mv	a4,a0
  n = 0;
 27a:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 27c:	0705                	add	a4,a4,1
 27e:	0025179b          	sllw	a5,a0,0x2
 282:	9fa9                	addw	a5,a5,a0
 284:	0017979b          	sllw	a5,a5,0x1
 288:	9fb5                	addw	a5,a5,a3
 28a:	fd07851b          	addw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 28e:	00074683          	lbu	a3,0(a4)
 292:	fd06879b          	addw	a5,a3,-48
 296:	0ff7f793          	zext.b	a5,a5
 29a:	fef671e3          	bgeu	a2,a5,27c <atoi+0x1c>
  return n;
}
 29e:	6422                	ld	s0,8(sp)
 2a0:	0141                	add	sp,sp,16
 2a2:	8082                	ret
  n = 0;
 2a4:	4501                	li	a0,0
 2a6:	bfe5                	j	29e <atoi+0x3e>

00000000000002a8 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 2a8:	1141                	add	sp,sp,-16
 2aa:	e422                	sd	s0,8(sp)
 2ac:	0800                	add	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 2ae:	02b57463          	bgeu	a0,a1,2d6 <memmove+0x2e>
    while(n-- > 0)
 2b2:	00c05f63          	blez	a2,2d0 <memmove+0x28>
 2b6:	1602                	sll	a2,a2,0x20
 2b8:	9201                	srl	a2,a2,0x20
 2ba:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 2be:	872a                	mv	a4,a0
      *dst++ = *src++;
 2c0:	0585                	add	a1,a1,1
 2c2:	0705                	add	a4,a4,1
 2c4:	fff5c683          	lbu	a3,-1(a1)
 2c8:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 2cc:	fef71ae3          	bne	a4,a5,2c0 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 2d0:	6422                	ld	s0,8(sp)
 2d2:	0141                	add	sp,sp,16
 2d4:	8082                	ret
    dst += n;
 2d6:	00c50733          	add	a4,a0,a2
    src += n;
 2da:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 2dc:	fec05ae3          	blez	a2,2d0 <memmove+0x28>
 2e0:	fff6079b          	addw	a5,a2,-1
 2e4:	1782                	sll	a5,a5,0x20
 2e6:	9381                	srl	a5,a5,0x20
 2e8:	fff7c793          	not	a5,a5
 2ec:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 2ee:	15fd                	add	a1,a1,-1
 2f0:	177d                	add	a4,a4,-1
 2f2:	0005c683          	lbu	a3,0(a1)
 2f6:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 2fa:	fee79ae3          	bne	a5,a4,2ee <memmove+0x46>
 2fe:	bfc9                	j	2d0 <memmove+0x28>

0000000000000300 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 300:	1141                	add	sp,sp,-16
 302:	e422                	sd	s0,8(sp)
 304:	0800                	add	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 306:	ca05                	beqz	a2,336 <memcmp+0x36>
 308:	fff6069b          	addw	a3,a2,-1
 30c:	1682                	sll	a3,a3,0x20
 30e:	9281                	srl	a3,a3,0x20
 310:	0685                	add	a3,a3,1
 312:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 314:	00054783          	lbu	a5,0(a0)
 318:	0005c703          	lbu	a4,0(a1)
 31c:	00e79863          	bne	a5,a4,32c <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 320:	0505                	add	a0,a0,1
    p2++;
 322:	0585                	add	a1,a1,1
  while (n-- > 0) {
 324:	fed518e3          	bne	a0,a3,314 <memcmp+0x14>
  }
  return 0;
 328:	4501                	li	a0,0
 32a:	a019                	j	330 <memcmp+0x30>
      return *p1 - *p2;
 32c:	40e7853b          	subw	a0,a5,a4
}
 330:	6422                	ld	s0,8(sp)
 332:	0141                	add	sp,sp,16
 334:	8082                	ret
  return 0;
 336:	4501                	li	a0,0
 338:	bfe5                	j	330 <memcmp+0x30>

000000000000033a <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 33a:	1141                	add	sp,sp,-16
 33c:	e406                	sd	ra,8(sp)
 33e:	e022                	sd	s0,0(sp)
 340:	0800                	add	s0,sp,16
  return memmove(dst, src, n);
 342:	f67ff0ef          	jal	2a8 <memmove>
}
 346:	60a2                	ld	ra,8(sp)
 348:	6402                	ld	s0,0(sp)
 34a:	0141                	add	sp,sp,16
 34c:	8082                	ret

000000000000034e <sbrk>:

char *
sbrk(int n) {
 34e:	1141                	add	sp,sp,-16
 350:	e406                	sd	ra,8(sp)
 352:	e022                	sd	s0,0(sp)
 354:	0800                	add	s0,sp,16
  return sys_sbrk(n, SBRK_EAGER);
 356:	4585                	li	a1,1
 358:	152000ef          	jal	4aa <sys_sbrk>
}
 35c:	60a2                	ld	ra,8(sp)
 35e:	6402                	ld	s0,0(sp)
 360:	0141                	add	sp,sp,16
 362:	8082                	ret

0000000000000364 <sbrklazy>:

char *
sbrklazy(int n) {
 364:	1141                	add	sp,sp,-16
 366:	e406                	sd	ra,8(sp)
 368:	e022                	sd	s0,0(sp)
 36a:	0800                	add	s0,sp,16
  return sys_sbrk(n, SBRK_LAZY);
 36c:	4589                	li	a1,2
 36e:	13c000ef          	jal	4aa <sys_sbrk>
}
 372:	60a2                	ld	ra,8(sp)
 374:	6402                	ld	s0,0(sp)
 376:	0141                	add	sp,sp,16
 378:	8082                	ret

000000000000037a <htons>:

// Byte order conversion functions
unsigned short
htons(unsigned short hostshort)
{
 37a:	1141                	add	sp,sp,-16
 37c:	e422                	sd	s0,8(sp)
 37e:	0800                	add	s0,sp,16
  return ((hostshort >> 8) & 0xff) | ((hostshort & 0xff) << 8);
 380:	0085179b          	sllw	a5,a0,0x8
 384:	0085551b          	srlw	a0,a0,0x8
 388:	8d5d                	or	a0,a0,a5
}
 38a:	1542                	sll	a0,a0,0x30
 38c:	9141                	srl	a0,a0,0x30
 38e:	6422                	ld	s0,8(sp)
 390:	0141                	add	sp,sp,16
 392:	8082                	ret

0000000000000394 <ntohs>:

unsigned short
ntohs(unsigned short netshort)
{
 394:	1141                	add	sp,sp,-16
 396:	e422                	sd	s0,8(sp)
 398:	0800                	add	s0,sp,16
  return ((netshort >> 8) & 0xff) | ((netshort & 0xff) << 8);
 39a:	0085179b          	sllw	a5,a0,0x8
 39e:	0085551b          	srlw	a0,a0,0x8
 3a2:	8d5d                	or	a0,a0,a5
}
 3a4:	1542                	sll	a0,a0,0x30
 3a6:	9141                	srl	a0,a0,0x30
 3a8:	6422                	ld	s0,8(sp)
 3aa:	0141                	add	sp,sp,16
 3ac:	8082                	ret

00000000000003ae <htonl>:

unsigned long
htonl(unsigned long hostlong)
{
 3ae:	1141                	add	sp,sp,-16
 3b0:	e422                	sd	s0,8(sp)
 3b2:	0800                	add	s0,sp,16
  return ((hostlong >> 24) & 0xff) |
 3b4:	0185579b          	srlw	a5,a0,0x18
         ((hostlong >> 8) & 0xff00) |
 3b8:	00855713          	srl	a4,a0,0x8
 3bc:	66c1                	lui	a3,0x10
 3be:	f0068693          	add	a3,a3,-256 # ff00 <base+0xeef0>
 3c2:	8f75                	and	a4,a4,a3
  return ((hostlong >> 24) & 0xff) |
 3c4:	8fd9                	or	a5,a5,a4
         ((hostlong & 0xff00) << 8) |
 3c6:	00851713          	sll	a4,a0,0x8
 3ca:	00ff06b7          	lui	a3,0xff0
 3ce:	8f75                	and	a4,a4,a3
         ((hostlong >> 8) & 0xff00) |
 3d0:	8fd9                	or	a5,a5,a4
         ((hostlong & 0xff) << 24);
 3d2:	0562                	sll	a0,a0,0x18
 3d4:	0ff00713          	li	a4,255
 3d8:	0762                	sll	a4,a4,0x18
 3da:	8d79                	and	a0,a0,a4
}
 3dc:	8d5d                	or	a0,a0,a5
 3de:	6422                	ld	s0,8(sp)
 3e0:	0141                	add	sp,sp,16
 3e2:	8082                	ret

00000000000003e4 <ntohl>:

unsigned long
ntohl(unsigned long netlong)
{
 3e4:	1141                	add	sp,sp,-16
 3e6:	e422                	sd	s0,8(sp)
 3e8:	0800                	add	s0,sp,16
  return ((netlong >> 24) & 0xff) |
 3ea:	0185579b          	srlw	a5,a0,0x18
         ((netlong >> 8) & 0xff00) |
 3ee:	00855713          	srl	a4,a0,0x8
 3f2:	66c1                	lui	a3,0x10
 3f4:	f0068693          	add	a3,a3,-256 # ff00 <base+0xeef0>
 3f8:	8f75                	and	a4,a4,a3
  return ((netlong >> 24) & 0xff) |
 3fa:	8fd9                	or	a5,a5,a4
         ((netlong & 0xff00) << 8) |
 3fc:	00851713          	sll	a4,a0,0x8
 400:	00ff06b7          	lui	a3,0xff0
 404:	8f75                	and	a4,a4,a3
         ((netlong >> 8) & 0xff00) |
 406:	8fd9                	or	a5,a5,a4
         ((netlong & 0xff) << 24);
 408:	0562                	sll	a0,a0,0x18
 40a:	0ff00713          	li	a4,255
 40e:	0762                	sll	a4,a4,0x18
 410:	8d79                	and	a0,a0,a4
}
 412:	8d5d                	or	a0,a0,a5
 414:	6422                	ld	s0,8(sp)
 416:	0141                	add	sp,sp,16
 418:	8082                	ret

000000000000041a <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 41a:	4885                	li	a7,1
 ecall
 41c:	00000073          	ecall
 ret
 420:	8082                	ret

0000000000000422 <exit>:
.global exit
exit:
 li a7, SYS_exit
 422:	4889                	li	a7,2
 ecall
 424:	00000073          	ecall
 ret
 428:	8082                	ret

000000000000042a <wait>:
.global wait
wait:
 li a7, SYS_wait
 42a:	488d                	li	a7,3
 ecall
 42c:	00000073          	ecall
 ret
 430:	8082                	ret

0000000000000432 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 432:	4891                	li	a7,4
 ecall
 434:	00000073          	ecall
 ret
 438:	8082                	ret

000000000000043a <read>:
.global read
read:
 li a7, SYS_read
 43a:	4895                	li	a7,5
 ecall
 43c:	00000073          	ecall
 ret
 440:	8082                	ret

0000000000000442 <write>:
.global write
write:
 li a7, SYS_write
 442:	48c1                	li	a7,16
 ecall
 444:	00000073          	ecall
 ret
 448:	8082                	ret

000000000000044a <close>:
.global close
close:
 li a7, SYS_close
 44a:	48d5                	li	a7,21
 ecall
 44c:	00000073          	ecall
 ret
 450:	8082                	ret

0000000000000452 <kill>:
.global kill
kill:
 li a7, SYS_kill
 452:	4899                	li	a7,6
 ecall
 454:	00000073          	ecall
 ret
 458:	8082                	ret

000000000000045a <exec>:
.global exec
exec:
 li a7, SYS_exec
 45a:	489d                	li	a7,7
 ecall
 45c:	00000073          	ecall
 ret
 460:	8082                	ret

0000000000000462 <open>:
.global open
open:
 li a7, SYS_open
 462:	48bd                	li	a7,15
 ecall
 464:	00000073          	ecall
 ret
 468:	8082                	ret

000000000000046a <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 46a:	48c5                	li	a7,17
 ecall
 46c:	00000073          	ecall
 ret
 470:	8082                	ret

0000000000000472 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 472:	48c9                	li	a7,18
 ecall
 474:	00000073          	ecall
 ret
 478:	8082                	ret

000000000000047a <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 47a:	48a1                	li	a7,8
 ecall
 47c:	00000073          	ecall
 ret
 480:	8082                	ret

0000000000000482 <link>:
.global link
link:
 li a7, SYS_link
 482:	48cd                	li	a7,19
 ecall
 484:	00000073          	ecall
 ret
 488:	8082                	ret

000000000000048a <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 48a:	48d1                	li	a7,20
 ecall
 48c:	00000073          	ecall
 ret
 490:	8082                	ret

0000000000000492 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 492:	48a5                	li	a7,9
 ecall
 494:	00000073          	ecall
 ret
 498:	8082                	ret

000000000000049a <dup>:
.global dup
dup:
 li a7, SYS_dup
 49a:	48a9                	li	a7,10
 ecall
 49c:	00000073          	ecall
 ret
 4a0:	8082                	ret

00000000000004a2 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 4a2:	48ad                	li	a7,11
 ecall
 4a4:	00000073          	ecall
 ret
 4a8:	8082                	ret

00000000000004aa <sys_sbrk>:
.global sys_sbrk
sys_sbrk:
 li a7, SYS_sbrk
 4aa:	48b1                	li	a7,12
 ecall
 4ac:	00000073          	ecall
 ret
 4b0:	8082                	ret

00000000000004b2 <pause>:
.global pause
pause:
 li a7, SYS_pause
 4b2:	48b5                	li	a7,13
 ecall
 4b4:	00000073          	ecall
 ret
 4b8:	8082                	ret

00000000000004ba <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 4ba:	48b9                	li	a7,14
 ecall
 4bc:	00000073          	ecall
 ret
 4c0:	8082                	ret

00000000000004c2 <socket>:
.global socket
socket:
 li a7, SYS_socket
 4c2:	48d9                	li	a7,22
 ecall
 4c4:	00000073          	ecall
 ret
 4c8:	8082                	ret

00000000000004ca <bind>:
.global bind
bind:
 li a7, SYS_bind
 4ca:	48dd                	li	a7,23
 ecall
 4cc:	00000073          	ecall
 ret
 4d0:	8082                	ret

00000000000004d2 <listen>:
.global listen
listen:
 li a7, SYS_listen
 4d2:	48e1                	li	a7,24
 ecall
 4d4:	00000073          	ecall
 ret
 4d8:	8082                	ret

00000000000004da <accept>:
.global accept
accept:
 li a7, SYS_accept
 4da:	48e5                	li	a7,25
 ecall
 4dc:	00000073          	ecall
 ret
 4e0:	8082                	ret

00000000000004e2 <connect>:
.global connect
connect:
 li a7, SYS_connect
 4e2:	48e9                	li	a7,26
 ecall
 4e4:	00000073          	ecall
 ret
 4e8:	8082                	ret

00000000000004ea <send>:
.global send
send:
 li a7, SYS_send
 4ea:	48ed                	li	a7,27
 ecall
 4ec:	00000073          	ecall
 ret
 4f0:	8082                	ret

00000000000004f2 <recv>:
.global recv
recv:
 li a7, SYS_recv
 4f2:	48f1                	li	a7,28
 ecall
 4f4:	00000073          	ecall
 ret
 4f8:	8082                	ret

00000000000004fa <sendto>:
.global sendto
sendto:
 li a7, SYS_sendto
 4fa:	48f5                	li	a7,29
 ecall
 4fc:	00000073          	ecall
 ret
 500:	8082                	ret

0000000000000502 <recvfrom>:
.global recvfrom
recvfrom:
 li a7, SYS_recvfrom
 502:	48f9                	li	a7,30
 ecall
 504:	00000073          	ecall
 ret
 508:	8082                	ret

000000000000050a <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 50a:	1101                	add	sp,sp,-32
 50c:	ec06                	sd	ra,24(sp)
 50e:	e822                	sd	s0,16(sp)
 510:	1000                	add	s0,sp,32
 512:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 516:	4605                	li	a2,1
 518:	fef40593          	add	a1,s0,-17
 51c:	f27ff0ef          	jal	442 <write>
}
 520:	60e2                	ld	ra,24(sp)
 522:	6442                	ld	s0,16(sp)
 524:	6105                	add	sp,sp,32
 526:	8082                	ret

0000000000000528 <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
 528:	715d                	add	sp,sp,-80
 52a:	e486                	sd	ra,72(sp)
 52c:	e0a2                	sd	s0,64(sp)
 52e:	f84a                	sd	s2,48(sp)
 530:	0880                	add	s0,sp,80
 532:	892a                	mv	s2,a0
  char buf[20];
  int i, neg;
  unsigned long long x;

  neg = 0;
  if(sgn && xx < 0){
 534:	c299                	beqz	a3,53a <printint+0x12>
 536:	0805c363          	bltz	a1,5bc <printint+0x94>
  neg = 0;
 53a:	4881                	li	a7,0
 53c:	fb840693          	add	a3,s0,-72
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
 540:	4781                	li	a5,0
  do{
    buf[i++] = digits[x % base];
 542:	00000517          	auipc	a0,0x0
 546:	51e50513          	add	a0,a0,1310 # a60 <digits>
 54a:	883e                	mv	a6,a5
 54c:	2785                	addw	a5,a5,1
 54e:	02c5f733          	remu	a4,a1,a2
 552:	972a                	add	a4,a4,a0
 554:	00074703          	lbu	a4,0(a4)
 558:	00e68023          	sb	a4,0(a3) # ff0000 <base+0xfeeff0>
  }while((x /= base) != 0);
 55c:	872e                	mv	a4,a1
 55e:	02c5d5b3          	divu	a1,a1,a2
 562:	0685                	add	a3,a3,1
 564:	fec773e3          	bgeu	a4,a2,54a <printint+0x22>
  if(neg)
 568:	00088b63          	beqz	a7,57e <printint+0x56>
    buf[i++] = '-';
 56c:	fd078793          	add	a5,a5,-48
 570:	97a2                	add	a5,a5,s0
 572:	02d00713          	li	a4,45
 576:	fee78423          	sb	a4,-24(a5)
 57a:	0028079b          	addw	a5,a6,2

  while(--i >= 0)
 57e:	02f05a63          	blez	a5,5b2 <printint+0x8a>
 582:	fc26                	sd	s1,56(sp)
 584:	f44e                	sd	s3,40(sp)
 586:	fb840713          	add	a4,s0,-72
 58a:	00f704b3          	add	s1,a4,a5
 58e:	fff70993          	add	s3,a4,-1
 592:	99be                	add	s3,s3,a5
 594:	37fd                	addw	a5,a5,-1
 596:	1782                	sll	a5,a5,0x20
 598:	9381                	srl	a5,a5,0x20
 59a:	40f989b3          	sub	s3,s3,a5
    putc(fd, buf[i]);
 59e:	fff4c583          	lbu	a1,-1(s1)
 5a2:	854a                	mv	a0,s2
 5a4:	f67ff0ef          	jal	50a <putc>
  while(--i >= 0)
 5a8:	14fd                	add	s1,s1,-1
 5aa:	ff349ae3          	bne	s1,s3,59e <printint+0x76>
 5ae:	74e2                	ld	s1,56(sp)
 5b0:	79a2                	ld	s3,40(sp)
}
 5b2:	60a6                	ld	ra,72(sp)
 5b4:	6406                	ld	s0,64(sp)
 5b6:	7942                	ld	s2,48(sp)
 5b8:	6161                	add	sp,sp,80
 5ba:	8082                	ret
    x = -xx;
 5bc:	40b005b3          	neg	a1,a1
    neg = 1;
 5c0:	4885                	li	a7,1
    x = -xx;
 5c2:	bfad                	j	53c <printint+0x14>

00000000000005c4 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %c, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 5c4:	711d                	add	sp,sp,-96
 5c6:	ec86                	sd	ra,88(sp)
 5c8:	e8a2                	sd	s0,80(sp)
 5ca:	e0ca                	sd	s2,64(sp)
 5cc:	1080                	add	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 5ce:	0005c903          	lbu	s2,0(a1)
 5d2:	28090663          	beqz	s2,85e <vprintf+0x29a>
 5d6:	e4a6                	sd	s1,72(sp)
 5d8:	fc4e                	sd	s3,56(sp)
 5da:	f852                	sd	s4,48(sp)
 5dc:	f456                	sd	s5,40(sp)
 5de:	f05a                	sd	s6,32(sp)
 5e0:	ec5e                	sd	s7,24(sp)
 5e2:	e862                	sd	s8,16(sp)
 5e4:	e466                	sd	s9,8(sp)
 5e6:	8b2a                	mv	s6,a0
 5e8:	8a2e                	mv	s4,a1
 5ea:	8bb2                	mv	s7,a2
  state = 0;
 5ec:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
 5ee:	4481                	li	s1,0
 5f0:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
 5f2:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
 5f6:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
 5fa:	06c00c93          	li	s9,108
 5fe:	a005                	j	61e <vprintf+0x5a>
        putc(fd, c0);
 600:	85ca                	mv	a1,s2
 602:	855a                	mv	a0,s6
 604:	f07ff0ef          	jal	50a <putc>
 608:	a019                	j	60e <vprintf+0x4a>
    } else if(state == '%'){
 60a:	03598263          	beq	s3,s5,62e <vprintf+0x6a>
  for(i = 0; fmt[i]; i++){
 60e:	2485                	addw	s1,s1,1
 610:	8726                	mv	a4,s1
 612:	009a07b3          	add	a5,s4,s1
 616:	0007c903          	lbu	s2,0(a5)
 61a:	22090a63          	beqz	s2,84e <vprintf+0x28a>
    c0 = fmt[i] & 0xff;
 61e:	0009079b          	sext.w	a5,s2
    if(state == 0){
 622:	fe0994e3          	bnez	s3,60a <vprintf+0x46>
      if(c0 == '%'){
 626:	fd579de3          	bne	a5,s5,600 <vprintf+0x3c>
        state = '%';
 62a:	89be                	mv	s3,a5
 62c:	b7cd                	j	60e <vprintf+0x4a>
      if(c0) c1 = fmt[i+1] & 0xff;
 62e:	00ea06b3          	add	a3,s4,a4
 632:	0016c683          	lbu	a3,1(a3)
      c1 = c2 = 0;
 636:	8636                	mv	a2,a3
      if(c1) c2 = fmt[i+2] & 0xff;
 638:	c681                	beqz	a3,640 <vprintf+0x7c>
 63a:	9752                	add	a4,a4,s4
 63c:	00274603          	lbu	a2,2(a4)
      if(c0 == 'd'){
 640:	05878363          	beq	a5,s8,686 <vprintf+0xc2>
      } else if(c0 == 'l' && c1 == 'd'){
 644:	05978d63          	beq	a5,s9,69e <vprintf+0xda>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
 648:	07500713          	li	a4,117
 64c:	0ee78763          	beq	a5,a4,73a <vprintf+0x176>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
 650:	07800713          	li	a4,120
 654:	12e78963          	beq	a5,a4,786 <vprintf+0x1c2>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
 658:	07000713          	li	a4,112
 65c:	14e78e63          	beq	a5,a4,7b8 <vprintf+0x1f4>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 'c'){
 660:	06300713          	li	a4,99
 664:	18e78e63          	beq	a5,a4,800 <vprintf+0x23c>
        putc(fd, va_arg(ap, uint32));
      } else if(c0 == 's'){
 668:	07300713          	li	a4,115
 66c:	1ae78463          	beq	a5,a4,814 <vprintf+0x250>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
 670:	02500713          	li	a4,37
 674:	04e79563          	bne	a5,a4,6be <vprintf+0xfa>
        putc(fd, '%');
 678:	02500593          	li	a1,37
 67c:	855a                	mv	a0,s6
 67e:	e8dff0ef          	jal	50a <putc>
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c0);
      }

      state = 0;
 682:	4981                	li	s3,0
 684:	b769                	j	60e <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 1);
 686:	008b8913          	add	s2,s7,8
 68a:	4685                	li	a3,1
 68c:	4629                	li	a2,10
 68e:	000ba583          	lw	a1,0(s7)
 692:	855a                	mv	a0,s6
 694:	e95ff0ef          	jal	528 <printint>
 698:	8bca                	mv	s7,s2
      state = 0;
 69a:	4981                	li	s3,0
 69c:	bf8d                	j	60e <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'd'){
 69e:	06400793          	li	a5,100
 6a2:	02f68963          	beq	a3,a5,6d4 <vprintf+0x110>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 6a6:	06c00793          	li	a5,108
 6aa:	04f68263          	beq	a3,a5,6ee <vprintf+0x12a>
      } else if(c0 == 'l' && c1 == 'u'){
 6ae:	07500793          	li	a5,117
 6b2:	0af68063          	beq	a3,a5,752 <vprintf+0x18e>
      } else if(c0 == 'l' && c1 == 'x'){
 6b6:	07800793          	li	a5,120
 6ba:	0ef68263          	beq	a3,a5,79e <vprintf+0x1da>
        putc(fd, '%');
 6be:	02500593          	li	a1,37
 6c2:	855a                	mv	a0,s6
 6c4:	e47ff0ef          	jal	50a <putc>
        putc(fd, c0);
 6c8:	85ca                	mv	a1,s2
 6ca:	855a                	mv	a0,s6
 6cc:	e3fff0ef          	jal	50a <putc>
      state = 0;
 6d0:	4981                	li	s3,0
 6d2:	bf35                	j	60e <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 6d4:	008b8913          	add	s2,s7,8
 6d8:	4685                	li	a3,1
 6da:	4629                	li	a2,10
 6dc:	000bb583          	ld	a1,0(s7)
 6e0:	855a                	mv	a0,s6
 6e2:	e47ff0ef          	jal	528 <printint>
        i += 1;
 6e6:	2485                	addw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 6e8:	8bca                	mv	s7,s2
      state = 0;
 6ea:	4981                	li	s3,0
        i += 1;
 6ec:	b70d                	j	60e <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 6ee:	06400793          	li	a5,100
 6f2:	02f60763          	beq	a2,a5,720 <vprintf+0x15c>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 6f6:	07500793          	li	a5,117
 6fa:	06f60963          	beq	a2,a5,76c <vprintf+0x1a8>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 6fe:	07800793          	li	a5,120
 702:	faf61ee3          	bne	a2,a5,6be <vprintf+0xfa>
        printint(fd, va_arg(ap, uint64), 16, 0);
 706:	008b8913          	add	s2,s7,8
 70a:	4681                	li	a3,0
 70c:	4641                	li	a2,16
 70e:	000bb583          	ld	a1,0(s7)
 712:	855a                	mv	a0,s6
 714:	e15ff0ef          	jal	528 <printint>
        i += 2;
 718:	2489                	addw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 71a:	8bca                	mv	s7,s2
      state = 0;
 71c:	4981                	li	s3,0
        i += 2;
 71e:	bdc5                	j	60e <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 720:	008b8913          	add	s2,s7,8
 724:	4685                	li	a3,1
 726:	4629                	li	a2,10
 728:	000bb583          	ld	a1,0(s7)
 72c:	855a                	mv	a0,s6
 72e:	dfbff0ef          	jal	528 <printint>
        i += 2;
 732:	2489                	addw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 734:	8bca                	mv	s7,s2
      state = 0;
 736:	4981                	li	s3,0
        i += 2;
 738:	bdd9                	j	60e <vprintf+0x4a>
        printint(fd, va_arg(ap, uint32), 10, 0);
 73a:	008b8913          	add	s2,s7,8
 73e:	4681                	li	a3,0
 740:	4629                	li	a2,10
 742:	000be583          	lwu	a1,0(s7)
 746:	855a                	mv	a0,s6
 748:	de1ff0ef          	jal	528 <printint>
 74c:	8bca                	mv	s7,s2
      state = 0;
 74e:	4981                	li	s3,0
 750:	bd7d                	j	60e <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 752:	008b8913          	add	s2,s7,8
 756:	4681                	li	a3,0
 758:	4629                	li	a2,10
 75a:	000bb583          	ld	a1,0(s7)
 75e:	855a                	mv	a0,s6
 760:	dc9ff0ef          	jal	528 <printint>
        i += 1;
 764:	2485                	addw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 766:	8bca                	mv	s7,s2
      state = 0;
 768:	4981                	li	s3,0
        i += 1;
 76a:	b555                	j	60e <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 76c:	008b8913          	add	s2,s7,8
 770:	4681                	li	a3,0
 772:	4629                	li	a2,10
 774:	000bb583          	ld	a1,0(s7)
 778:	855a                	mv	a0,s6
 77a:	dafff0ef          	jal	528 <printint>
        i += 2;
 77e:	2489                	addw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 780:	8bca                	mv	s7,s2
      state = 0;
 782:	4981                	li	s3,0
        i += 2;
 784:	b569                	j	60e <vprintf+0x4a>
        printint(fd, va_arg(ap, uint32), 16, 0);
 786:	008b8913          	add	s2,s7,8
 78a:	4681                	li	a3,0
 78c:	4641                	li	a2,16
 78e:	000be583          	lwu	a1,0(s7)
 792:	855a                	mv	a0,s6
 794:	d95ff0ef          	jal	528 <printint>
 798:	8bca                	mv	s7,s2
      state = 0;
 79a:	4981                	li	s3,0
 79c:	bd8d                	j	60e <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 16, 0);
 79e:	008b8913          	add	s2,s7,8
 7a2:	4681                	li	a3,0
 7a4:	4641                	li	a2,16
 7a6:	000bb583          	ld	a1,0(s7)
 7aa:	855a                	mv	a0,s6
 7ac:	d7dff0ef          	jal	528 <printint>
        i += 1;
 7b0:	2485                	addw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 7b2:	8bca                	mv	s7,s2
      state = 0;
 7b4:	4981                	li	s3,0
        i += 1;
 7b6:	bda1                	j	60e <vprintf+0x4a>
 7b8:	e06a                	sd	s10,0(sp)
        printptr(fd, va_arg(ap, uint64));
 7ba:	008b8d13          	add	s10,s7,8
 7be:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 7c2:	03000593          	li	a1,48
 7c6:	855a                	mv	a0,s6
 7c8:	d43ff0ef          	jal	50a <putc>
  putc(fd, 'x');
 7cc:	07800593          	li	a1,120
 7d0:	855a                	mv	a0,s6
 7d2:	d39ff0ef          	jal	50a <putc>
 7d6:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 7d8:	00000b97          	auipc	s7,0x0
 7dc:	288b8b93          	add	s7,s7,648 # a60 <digits>
 7e0:	03c9d793          	srl	a5,s3,0x3c
 7e4:	97de                	add	a5,a5,s7
 7e6:	0007c583          	lbu	a1,0(a5)
 7ea:	855a                	mv	a0,s6
 7ec:	d1fff0ef          	jal	50a <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 7f0:	0992                	sll	s3,s3,0x4
 7f2:	397d                	addw	s2,s2,-1
 7f4:	fe0916e3          	bnez	s2,7e0 <vprintf+0x21c>
        printptr(fd, va_arg(ap, uint64));
 7f8:	8bea                	mv	s7,s10
      state = 0;
 7fa:	4981                	li	s3,0
 7fc:	6d02                	ld	s10,0(sp)
 7fe:	bd01                	j	60e <vprintf+0x4a>
        putc(fd, va_arg(ap, uint32));
 800:	008b8913          	add	s2,s7,8
 804:	000bc583          	lbu	a1,0(s7)
 808:	855a                	mv	a0,s6
 80a:	d01ff0ef          	jal	50a <putc>
 80e:	8bca                	mv	s7,s2
      state = 0;
 810:	4981                	li	s3,0
 812:	bbf5                	j	60e <vprintf+0x4a>
        if((s = va_arg(ap, char*)) == 0)
 814:	008b8993          	add	s3,s7,8
 818:	000bb903          	ld	s2,0(s7)
 81c:	00090f63          	beqz	s2,83a <vprintf+0x276>
        for(; *s; s++)
 820:	00094583          	lbu	a1,0(s2)
 824:	c195                	beqz	a1,848 <vprintf+0x284>
          putc(fd, *s);
 826:	855a                	mv	a0,s6
 828:	ce3ff0ef          	jal	50a <putc>
        for(; *s; s++)
 82c:	0905                	add	s2,s2,1
 82e:	00094583          	lbu	a1,0(s2)
 832:	f9f5                	bnez	a1,826 <vprintf+0x262>
        if((s = va_arg(ap, char*)) == 0)
 834:	8bce                	mv	s7,s3
      state = 0;
 836:	4981                	li	s3,0
 838:	bbd9                	j	60e <vprintf+0x4a>
          s = "(null)";
 83a:	00000917          	auipc	s2,0x0
 83e:	21e90913          	add	s2,s2,542 # a58 <malloc+0x112>
        for(; *s; s++)
 842:	02800593          	li	a1,40
 846:	b7c5                	j	826 <vprintf+0x262>
        if((s = va_arg(ap, char*)) == 0)
 848:	8bce                	mv	s7,s3
      state = 0;
 84a:	4981                	li	s3,0
 84c:	b3c9                	j	60e <vprintf+0x4a>
 84e:	64a6                	ld	s1,72(sp)
 850:	79e2                	ld	s3,56(sp)
 852:	7a42                	ld	s4,48(sp)
 854:	7aa2                	ld	s5,40(sp)
 856:	7b02                	ld	s6,32(sp)
 858:	6be2                	ld	s7,24(sp)
 85a:	6c42                	ld	s8,16(sp)
 85c:	6ca2                	ld	s9,8(sp)
    }
  }
}
 85e:	60e6                	ld	ra,88(sp)
 860:	6446                	ld	s0,80(sp)
 862:	6906                	ld	s2,64(sp)
 864:	6125                	add	sp,sp,96
 866:	8082                	ret

0000000000000868 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 868:	715d                	add	sp,sp,-80
 86a:	ec06                	sd	ra,24(sp)
 86c:	e822                	sd	s0,16(sp)
 86e:	1000                	add	s0,sp,32
 870:	e010                	sd	a2,0(s0)
 872:	e414                	sd	a3,8(s0)
 874:	e818                	sd	a4,16(s0)
 876:	ec1c                	sd	a5,24(s0)
 878:	03043023          	sd	a6,32(s0)
 87c:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 880:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 884:	8622                	mv	a2,s0
 886:	d3fff0ef          	jal	5c4 <vprintf>
}
 88a:	60e2                	ld	ra,24(sp)
 88c:	6442                	ld	s0,16(sp)
 88e:	6161                	add	sp,sp,80
 890:	8082                	ret

0000000000000892 <printf>:

void
printf(const char *fmt, ...)
{
 892:	711d                	add	sp,sp,-96
 894:	ec06                	sd	ra,24(sp)
 896:	e822                	sd	s0,16(sp)
 898:	1000                	add	s0,sp,32
 89a:	e40c                	sd	a1,8(s0)
 89c:	e810                	sd	a2,16(s0)
 89e:	ec14                	sd	a3,24(s0)
 8a0:	f018                	sd	a4,32(s0)
 8a2:	f41c                	sd	a5,40(s0)
 8a4:	03043823          	sd	a6,48(s0)
 8a8:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 8ac:	00840613          	add	a2,s0,8
 8b0:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 8b4:	85aa                	mv	a1,a0
 8b6:	4505                	li	a0,1
 8b8:	d0dff0ef          	jal	5c4 <vprintf>
}
 8bc:	60e2                	ld	ra,24(sp)
 8be:	6442                	ld	s0,16(sp)
 8c0:	6125                	add	sp,sp,96
 8c2:	8082                	ret

00000000000008c4 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 8c4:	1141                	add	sp,sp,-16
 8c6:	e422                	sd	s0,8(sp)
 8c8:	0800                	add	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 8ca:	ff050693          	add	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8ce:	00000797          	auipc	a5,0x0
 8d2:	7327b783          	ld	a5,1842(a5) # 1000 <freep>
 8d6:	a02d                	j	900 <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 8d8:	4618                	lw	a4,8(a2)
 8da:	9f2d                	addw	a4,a4,a1
 8dc:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 8e0:	6398                	ld	a4,0(a5)
 8e2:	6310                	ld	a2,0(a4)
 8e4:	a83d                	j	922 <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 8e6:	ff852703          	lw	a4,-8(a0)
 8ea:	9f31                	addw	a4,a4,a2
 8ec:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 8ee:	ff053683          	ld	a3,-16(a0)
 8f2:	a091                	j	936 <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8f4:	6398                	ld	a4,0(a5)
 8f6:	00e7e463          	bltu	a5,a4,8fe <free+0x3a>
 8fa:	00e6ea63          	bltu	a3,a4,90e <free+0x4a>
{
 8fe:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 900:	fed7fae3          	bgeu	a5,a3,8f4 <free+0x30>
 904:	6398                	ld	a4,0(a5)
 906:	00e6e463          	bltu	a3,a4,90e <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 90a:	fee7eae3          	bltu	a5,a4,8fe <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 90e:	ff852583          	lw	a1,-8(a0)
 912:	6390                	ld	a2,0(a5)
 914:	02059813          	sll	a6,a1,0x20
 918:	01c85713          	srl	a4,a6,0x1c
 91c:	9736                	add	a4,a4,a3
 91e:	fae60de3          	beq	a2,a4,8d8 <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 922:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 926:	4790                	lw	a2,8(a5)
 928:	02061593          	sll	a1,a2,0x20
 92c:	01c5d713          	srl	a4,a1,0x1c
 930:	973e                	add	a4,a4,a5
 932:	fae68ae3          	beq	a3,a4,8e6 <free+0x22>
    p->s.ptr = bp->s.ptr;
 936:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 938:	00000717          	auipc	a4,0x0
 93c:	6cf73423          	sd	a5,1736(a4) # 1000 <freep>
}
 940:	6422                	ld	s0,8(sp)
 942:	0141                	add	sp,sp,16
 944:	8082                	ret

0000000000000946 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 946:	7139                	add	sp,sp,-64
 948:	fc06                	sd	ra,56(sp)
 94a:	f822                	sd	s0,48(sp)
 94c:	f426                	sd	s1,40(sp)
 94e:	ec4e                	sd	s3,24(sp)
 950:	0080                	add	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 952:	02051493          	sll	s1,a0,0x20
 956:	9081                	srl	s1,s1,0x20
 958:	04bd                	add	s1,s1,15
 95a:	8091                	srl	s1,s1,0x4
 95c:	0014899b          	addw	s3,s1,1
 960:	0485                	add	s1,s1,1
  if((prevp = freep) == 0){
 962:	00000517          	auipc	a0,0x0
 966:	69e53503          	ld	a0,1694(a0) # 1000 <freep>
 96a:	c915                	beqz	a0,99e <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 96c:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 96e:	4798                	lw	a4,8(a5)
 970:	08977a63          	bgeu	a4,s1,a04 <malloc+0xbe>
 974:	f04a                	sd	s2,32(sp)
 976:	e852                	sd	s4,16(sp)
 978:	e456                	sd	s5,8(sp)
 97a:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 97c:	8a4e                	mv	s4,s3
 97e:	0009871b          	sext.w	a4,s3
 982:	6685                	lui	a3,0x1
 984:	00d77363          	bgeu	a4,a3,98a <malloc+0x44>
 988:	6a05                	lui	s4,0x1
 98a:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 98e:	004a1a1b          	sllw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 992:	00000917          	auipc	s2,0x0
 996:	66e90913          	add	s2,s2,1646 # 1000 <freep>
  if(p == SBRK_ERROR)
 99a:	5afd                	li	s5,-1
 99c:	a081                	j	9dc <malloc+0x96>
 99e:	f04a                	sd	s2,32(sp)
 9a0:	e852                	sd	s4,16(sp)
 9a2:	e456                	sd	s5,8(sp)
 9a4:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 9a6:	00000797          	auipc	a5,0x0
 9aa:	66a78793          	add	a5,a5,1642 # 1010 <base>
 9ae:	00000717          	auipc	a4,0x0
 9b2:	64f73923          	sd	a5,1618(a4) # 1000 <freep>
 9b6:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 9b8:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 9bc:	b7c1                	j	97c <malloc+0x36>
        prevp->s.ptr = p->s.ptr;
 9be:	6398                	ld	a4,0(a5)
 9c0:	e118                	sd	a4,0(a0)
 9c2:	a8a9                	j	a1c <malloc+0xd6>
  hp->s.size = nu;
 9c4:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 9c8:	0541                	add	a0,a0,16
 9ca:	efbff0ef          	jal	8c4 <free>
  return freep;
 9ce:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 9d2:	c12d                	beqz	a0,a34 <malloc+0xee>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 9d4:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 9d6:	4798                	lw	a4,8(a5)
 9d8:	02977263          	bgeu	a4,s1,9fc <malloc+0xb6>
    if(p == freep)
 9dc:	00093703          	ld	a4,0(s2)
 9e0:	853e                	mv	a0,a5
 9e2:	fef719e3          	bne	a4,a5,9d4 <malloc+0x8e>
  p = sbrk(nu * sizeof(Header));
 9e6:	8552                	mv	a0,s4
 9e8:	967ff0ef          	jal	34e <sbrk>
  if(p == SBRK_ERROR)
 9ec:	fd551ce3          	bne	a0,s5,9c4 <malloc+0x7e>
        return 0;
 9f0:	4501                	li	a0,0
 9f2:	7902                	ld	s2,32(sp)
 9f4:	6a42                	ld	s4,16(sp)
 9f6:	6aa2                	ld	s5,8(sp)
 9f8:	6b02                	ld	s6,0(sp)
 9fa:	a03d                	j	a28 <malloc+0xe2>
 9fc:	7902                	ld	s2,32(sp)
 9fe:	6a42                	ld	s4,16(sp)
 a00:	6aa2                	ld	s5,8(sp)
 a02:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 a04:	fae48de3          	beq	s1,a4,9be <malloc+0x78>
        p->s.size -= nunits;
 a08:	4137073b          	subw	a4,a4,s3
 a0c:	c798                	sw	a4,8(a5)
        p += p->s.size;
 a0e:	02071693          	sll	a3,a4,0x20
 a12:	01c6d713          	srl	a4,a3,0x1c
 a16:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 a18:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 a1c:	00000717          	auipc	a4,0x0
 a20:	5ea73223          	sd	a0,1508(a4) # 1000 <freep>
      return (void*)(p + 1);
 a24:	01078513          	add	a0,a5,16
  }
}
 a28:	70e2                	ld	ra,56(sp)
 a2a:	7442                	ld	s0,48(sp)
 a2c:	74a2                	ld	s1,40(sp)
 a2e:	69e2                	ld	s3,24(sp)
 a30:	6121                	add	sp,sp,64
 a32:	8082                	ret
 a34:	7902                	ld	s2,32(sp)
 a36:	6a42                	ld	s4,16(sp)
 a38:	6aa2                	ld	s5,8(sp)
 a3a:	6b02                	ld	s6,0(sp)
 a3c:	b7f5                	j	a28 <malloc+0xe2>
