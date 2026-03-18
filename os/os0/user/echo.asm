
user/_echo:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/stat.h"
#include "user/user.h"

int
main(int argc, char *argv[])
{
   0:	7139                	add	sp,sp,-64
   2:	fc06                	sd	ra,56(sp)
   4:	f822                	sd	s0,48(sp)
   6:	f426                	sd	s1,40(sp)
   8:	f04a                	sd	s2,32(sp)
   a:	ec4e                	sd	s3,24(sp)
   c:	e852                	sd	s4,16(sp)
   e:	e456                	sd	s5,8(sp)
  10:	0080                	add	s0,sp,64
  int i;

  for(i = 1; i < argc; i++){
  12:	4785                	li	a5,1
  14:	06a7d063          	bge	a5,a0,74 <main+0x74>
  18:	00858493          	add	s1,a1,8
  1c:	3579                	addw	a0,a0,-2
  1e:	02051793          	sll	a5,a0,0x20
  22:	01d7d513          	srl	a0,a5,0x1d
  26:	00a48a33          	add	s4,s1,a0
  2a:	05c1                	add	a1,a1,16
  2c:	00a589b3          	add	s3,a1,a0
    write(1, argv[i], strlen(argv[i]));
    if(i + 1 < argc){
      write(1, " ", 1);
  30:	00001a97          	auipc	s5,0x1
  34:	a40a8a93          	add	s5,s5,-1472 # a70 <malloc+0x104>
  38:	a809                	j	4a <main+0x4a>
  3a:	4605                	li	a2,1
  3c:	85d6                	mv	a1,s5
  3e:	4505                	li	a0,1
  40:	428000ef          	jal	468 <write>
  for(i = 1; i < argc; i++){
  44:	04a1                	add	s1,s1,8
  46:	03348763          	beq	s1,s3,74 <main+0x74>
    write(1, argv[i], strlen(argv[i]));
  4a:	0004b903          	ld	s2,0(s1)
  4e:	854a                	mv	a0,s2
  50:	11c000ef          	jal	16c <strlen>
  54:	0005061b          	sext.w	a2,a0
  58:	85ca                	mv	a1,s2
  5a:	4505                	li	a0,1
  5c:	40c000ef          	jal	468 <write>
    if(i + 1 < argc){
  60:	fd449de3          	bne	s1,s4,3a <main+0x3a>
    } else {
      write(1, "\n", 1);
  64:	4605                	li	a2,1
  66:	00001597          	auipc	a1,0x1
  6a:	a1258593          	add	a1,a1,-1518 # a78 <malloc+0x10c>
  6e:	4505                	li	a0,1
  70:	3f8000ef          	jal	468 <write>
    }
  }
  exit(0);
  74:	4501                	li	a0,0
  76:	3d2000ef          	jal	448 <exit>

000000000000007a <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start(int argc, char **argv)
{
  7a:	1141                	add	sp,sp,-16
  7c:	e406                	sd	ra,8(sp)
  7e:	e022                	sd	s0,0(sp)
  80:	0800                	add	s0,sp,16
  int r;
  extern int main(int argc, char **argv);
  r = main(argc, argv);
  82:	f7fff0ef          	jal	0 <main>
  exit(r);
  86:	3c2000ef          	jal	448 <exit>

000000000000008a <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
  8a:	1141                	add	sp,sp,-16
  8c:	e422                	sd	s0,8(sp)
  8e:	0800                	add	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  90:	87aa                	mv	a5,a0
  92:	0585                	add	a1,a1,1
  94:	0785                	add	a5,a5,1
  96:	fff5c703          	lbu	a4,-1(a1)
  9a:	fee78fa3          	sb	a4,-1(a5)
  9e:	fb75                	bnez	a4,92 <strcpy+0x8>
    ;
  return os;
}
  a0:	6422                	ld	s0,8(sp)
  a2:	0141                	add	sp,sp,16
  a4:	8082                	ret

00000000000000a6 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  a6:	1141                	add	sp,sp,-16
  a8:	e422                	sd	s0,8(sp)
  aa:	0800                	add	s0,sp,16
  while(*p && *p == *q)
  ac:	00054783          	lbu	a5,0(a0)
  b0:	cb91                	beqz	a5,c4 <strcmp+0x1e>
  b2:	0005c703          	lbu	a4,0(a1)
  b6:	00f71763          	bne	a4,a5,c4 <strcmp+0x1e>
    p++, q++;
  ba:	0505                	add	a0,a0,1
  bc:	0585                	add	a1,a1,1
  while(*p && *p == *q)
  be:	00054783          	lbu	a5,0(a0)
  c2:	fbe5                	bnez	a5,b2 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
  c4:	0005c503          	lbu	a0,0(a1)
}
  c8:	40a7853b          	subw	a0,a5,a0
  cc:	6422                	ld	s0,8(sp)
  ce:	0141                	add	sp,sp,16
  d0:	8082                	ret

00000000000000d2 <strncmp>:

int
strncmp(const char *p, const char *q, uint n)
{
  d2:	1141                	add	sp,sp,-16
  d4:	e422                	sd	s0,8(sp)
  d6:	0800                	add	s0,sp,16
  while(n > 0 && *p && *p == *q) {
  d8:	ce11                	beqz	a2,f4 <strncmp+0x22>
  da:	00054783          	lbu	a5,0(a0)
  de:	cf89                	beqz	a5,f8 <strncmp+0x26>
  e0:	0005c703          	lbu	a4,0(a1)
  e4:	00f71a63          	bne	a4,a5,f8 <strncmp+0x26>
    p++, q++, n--;
  e8:	0505                	add	a0,a0,1
  ea:	0585                	add	a1,a1,1
  ec:	367d                	addw	a2,a2,-1
  while(n > 0 && *p && *p == *q) {
  ee:	f675                	bnez	a2,da <strncmp+0x8>
  }
  if (n == 0)
    return 0;
  f0:	4501                	li	a0,0
  f2:	a801                	j	102 <strncmp+0x30>
  f4:	4501                	li	a0,0
  f6:	a031                	j	102 <strncmp+0x30>
  return (uchar)*p - (uchar)*q;
  f8:	00054503          	lbu	a0,0(a0)
  fc:	0005c783          	lbu	a5,0(a1)
 100:	9d1d                	subw	a0,a0,a5
}
 102:	6422                	ld	s0,8(sp)
 104:	0141                	add	sp,sp,16
 106:	8082                	ret

0000000000000108 <strcat>:

char*
strcat(char *dst, const char *src)
{
 108:	1141                	add	sp,sp,-16
 10a:	e422                	sd	s0,8(sp)
 10c:	0800                	add	s0,sp,16
  char *p = dst;
  while(*p) p++;
 10e:	00054783          	lbu	a5,0(a0)
 112:	c385                	beqz	a5,132 <strcat+0x2a>
  char *p = dst;
 114:	87aa                	mv	a5,a0
  while(*p) p++;
 116:	0785                	add	a5,a5,1
 118:	0007c703          	lbu	a4,0(a5)
 11c:	ff6d                	bnez	a4,116 <strcat+0xe>
  while((*p++ = *src++) != 0);
 11e:	0585                	add	a1,a1,1
 120:	0785                	add	a5,a5,1
 122:	fff5c703          	lbu	a4,-1(a1)
 126:	fee78fa3          	sb	a4,-1(a5)
 12a:	fb75                	bnez	a4,11e <strcat+0x16>
  return dst;
}
 12c:	6422                	ld	s0,8(sp)
 12e:	0141                	add	sp,sp,16
 130:	8082                	ret
  char *p = dst;
 132:	87aa                	mv	a5,a0
 134:	b7ed                	j	11e <strcat+0x16>

0000000000000136 <strncpy>:

char*
strncpy(char *dst, const char *src, int n)
{
 136:	1141                	add	sp,sp,-16
 138:	e422                	sd	s0,8(sp)
 13a:	0800                	add	s0,sp,16
  char *p = dst;
 13c:	87aa                	mv	a5,a0
  while(n > 0 && *src) {
 13e:	02c05463          	blez	a2,166 <strncpy+0x30>
 142:	0005c703          	lbu	a4,0(a1)
 146:	cb01                	beqz	a4,156 <strncpy+0x20>
    *p++ = *src++;
 148:	0585                	add	a1,a1,1
 14a:	0785                	add	a5,a5,1
 14c:	fee78fa3          	sb	a4,-1(a5)
    n--;
 150:	367d                	addw	a2,a2,-1
  while(n > 0 && *src) {
 152:	fa65                	bnez	a2,142 <strncpy+0xc>
 154:	a809                	j	166 <strncpy+0x30>
  }
  while(n > 0) {
 156:	1602                	sll	a2,a2,0x20
 158:	9201                	srl	a2,a2,0x20
 15a:	963e                	add	a2,a2,a5
    *p++ = 0;
 15c:	0785                	add	a5,a5,1
 15e:	fe078fa3          	sb	zero,-1(a5)
  while(n > 0) {
 162:	fec79de3          	bne	a5,a2,15c <strncpy+0x26>
    n--;
  }
  return dst;
}
 166:	6422                	ld	s0,8(sp)
 168:	0141                	add	sp,sp,16
 16a:	8082                	ret

000000000000016c <strlen>:

uint
strlen(const char *s)
{
 16c:	1141                	add	sp,sp,-16
 16e:	e422                	sd	s0,8(sp)
 170:	0800                	add	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 172:	00054783          	lbu	a5,0(a0)
 176:	cf91                	beqz	a5,192 <strlen+0x26>
 178:	0505                	add	a0,a0,1
 17a:	87aa                	mv	a5,a0
 17c:	86be                	mv	a3,a5
 17e:	0785                	add	a5,a5,1
 180:	fff7c703          	lbu	a4,-1(a5)
 184:	ff65                	bnez	a4,17c <strlen+0x10>
 186:	40a6853b          	subw	a0,a3,a0
 18a:	2505                	addw	a0,a0,1
    ;
  return n;
}
 18c:	6422                	ld	s0,8(sp)
 18e:	0141                	add	sp,sp,16
 190:	8082                	ret
  for(n = 0; s[n]; n++)
 192:	4501                	li	a0,0
 194:	bfe5                	j	18c <strlen+0x20>

0000000000000196 <memset>:

void*
memset(void *dst, int c, uint n)
{
 196:	1141                	add	sp,sp,-16
 198:	e422                	sd	s0,8(sp)
 19a:	0800                	add	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 19c:	ca19                	beqz	a2,1b2 <memset+0x1c>
 19e:	87aa                	mv	a5,a0
 1a0:	1602                	sll	a2,a2,0x20
 1a2:	9201                	srl	a2,a2,0x20
 1a4:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 1a8:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 1ac:	0785                	add	a5,a5,1
 1ae:	fee79de3          	bne	a5,a4,1a8 <memset+0x12>
  }
  return dst;
}
 1b2:	6422                	ld	s0,8(sp)
 1b4:	0141                	add	sp,sp,16
 1b6:	8082                	ret

00000000000001b8 <strchr>:

char*
strchr(const char *s, char c)
{
 1b8:	1141                	add	sp,sp,-16
 1ba:	e422                	sd	s0,8(sp)
 1bc:	0800                	add	s0,sp,16
  for(; *s; s++)
 1be:	00054783          	lbu	a5,0(a0)
 1c2:	cb99                	beqz	a5,1d8 <strchr+0x20>
    if(*s == c)
 1c4:	00f58763          	beq	a1,a5,1d2 <strchr+0x1a>
  for(; *s; s++)
 1c8:	0505                	add	a0,a0,1
 1ca:	00054783          	lbu	a5,0(a0)
 1ce:	fbfd                	bnez	a5,1c4 <strchr+0xc>
      return (char*)s;
  return 0;
 1d0:	4501                	li	a0,0
}
 1d2:	6422                	ld	s0,8(sp)
 1d4:	0141                	add	sp,sp,16
 1d6:	8082                	ret
  return 0;
 1d8:	4501                	li	a0,0
 1da:	bfe5                	j	1d2 <strchr+0x1a>

00000000000001dc <gets>:

char*
gets(char *buf, int max)
{
 1dc:	711d                	add	sp,sp,-96
 1de:	ec86                	sd	ra,88(sp)
 1e0:	e8a2                	sd	s0,80(sp)
 1e2:	e4a6                	sd	s1,72(sp)
 1e4:	e0ca                	sd	s2,64(sp)
 1e6:	fc4e                	sd	s3,56(sp)
 1e8:	f852                	sd	s4,48(sp)
 1ea:	f456                	sd	s5,40(sp)
 1ec:	f05a                	sd	s6,32(sp)
 1ee:	ec5e                	sd	s7,24(sp)
 1f0:	1080                	add	s0,sp,96
 1f2:	8baa                	mv	s7,a0
 1f4:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1f6:	892a                	mv	s2,a0
 1f8:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 1fa:	4aa9                	li	s5,10
 1fc:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 1fe:	89a6                	mv	s3,s1
 200:	2485                	addw	s1,s1,1
 202:	0344d663          	bge	s1,s4,22e <gets+0x52>
    cc = read(0, &c, 1);
 206:	4605                	li	a2,1
 208:	faf40593          	add	a1,s0,-81
 20c:	4501                	li	a0,0
 20e:	252000ef          	jal	460 <read>
    if(cc < 1)
 212:	00a05e63          	blez	a0,22e <gets+0x52>
    buf[i++] = c;
 216:	faf44783          	lbu	a5,-81(s0)
 21a:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 21e:	01578763          	beq	a5,s5,22c <gets+0x50>
 222:	0905                	add	s2,s2,1
 224:	fd679de3          	bne	a5,s6,1fe <gets+0x22>
    buf[i++] = c;
 228:	89a6                	mv	s3,s1
 22a:	a011                	j	22e <gets+0x52>
 22c:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 22e:	99de                	add	s3,s3,s7
 230:	00098023          	sb	zero,0(s3)
  return buf;
}
 234:	855e                	mv	a0,s7
 236:	60e6                	ld	ra,88(sp)
 238:	6446                	ld	s0,80(sp)
 23a:	64a6                	ld	s1,72(sp)
 23c:	6906                	ld	s2,64(sp)
 23e:	79e2                	ld	s3,56(sp)
 240:	7a42                	ld	s4,48(sp)
 242:	7aa2                	ld	s5,40(sp)
 244:	7b02                	ld	s6,32(sp)
 246:	6be2                	ld	s7,24(sp)
 248:	6125                	add	sp,sp,96
 24a:	8082                	ret

000000000000024c <stat>:

int
stat(const char *n, struct stat *st)
{
 24c:	1101                	add	sp,sp,-32
 24e:	ec06                	sd	ra,24(sp)
 250:	e822                	sd	s0,16(sp)
 252:	e04a                	sd	s2,0(sp)
 254:	1000                	add	s0,sp,32
 256:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 258:	4581                	li	a1,0
 25a:	22e000ef          	jal	488 <open>
  if(fd < 0)
 25e:	02054263          	bltz	a0,282 <stat+0x36>
 262:	e426                	sd	s1,8(sp)
 264:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 266:	85ca                	mv	a1,s2
 268:	238000ef          	jal	4a0 <fstat>
 26c:	892a                	mv	s2,a0
  close(fd);
 26e:	8526                	mv	a0,s1
 270:	200000ef          	jal	470 <close>
  return r;
 274:	64a2                	ld	s1,8(sp)
}
 276:	854a                	mv	a0,s2
 278:	60e2                	ld	ra,24(sp)
 27a:	6442                	ld	s0,16(sp)
 27c:	6902                	ld	s2,0(sp)
 27e:	6105                	add	sp,sp,32
 280:	8082                	ret
    return -1;
 282:	597d                	li	s2,-1
 284:	bfcd                	j	276 <stat+0x2a>

0000000000000286 <atoi>:

int
atoi(const char *s)
{
 286:	1141                	add	sp,sp,-16
 288:	e422                	sd	s0,8(sp)
 28a:	0800                	add	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 28c:	00054683          	lbu	a3,0(a0)
 290:	fd06879b          	addw	a5,a3,-48
 294:	0ff7f793          	zext.b	a5,a5
 298:	4625                	li	a2,9
 29a:	02f66863          	bltu	a2,a5,2ca <atoi+0x44>
 29e:	872a                	mv	a4,a0
  n = 0;
 2a0:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 2a2:	0705                	add	a4,a4,1
 2a4:	0025179b          	sllw	a5,a0,0x2
 2a8:	9fa9                	addw	a5,a5,a0
 2aa:	0017979b          	sllw	a5,a5,0x1
 2ae:	9fb5                	addw	a5,a5,a3
 2b0:	fd07851b          	addw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 2b4:	00074683          	lbu	a3,0(a4)
 2b8:	fd06879b          	addw	a5,a3,-48
 2bc:	0ff7f793          	zext.b	a5,a5
 2c0:	fef671e3          	bgeu	a2,a5,2a2 <atoi+0x1c>
  return n;
}
 2c4:	6422                	ld	s0,8(sp)
 2c6:	0141                	add	sp,sp,16
 2c8:	8082                	ret
  n = 0;
 2ca:	4501                	li	a0,0
 2cc:	bfe5                	j	2c4 <atoi+0x3e>

00000000000002ce <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 2ce:	1141                	add	sp,sp,-16
 2d0:	e422                	sd	s0,8(sp)
 2d2:	0800                	add	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 2d4:	02b57463          	bgeu	a0,a1,2fc <memmove+0x2e>
    while(n-- > 0)
 2d8:	00c05f63          	blez	a2,2f6 <memmove+0x28>
 2dc:	1602                	sll	a2,a2,0x20
 2de:	9201                	srl	a2,a2,0x20
 2e0:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 2e4:	872a                	mv	a4,a0
      *dst++ = *src++;
 2e6:	0585                	add	a1,a1,1
 2e8:	0705                	add	a4,a4,1
 2ea:	fff5c683          	lbu	a3,-1(a1)
 2ee:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 2f2:	fef71ae3          	bne	a4,a5,2e6 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 2f6:	6422                	ld	s0,8(sp)
 2f8:	0141                	add	sp,sp,16
 2fa:	8082                	ret
    dst += n;
 2fc:	00c50733          	add	a4,a0,a2
    src += n;
 300:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 302:	fec05ae3          	blez	a2,2f6 <memmove+0x28>
 306:	fff6079b          	addw	a5,a2,-1
 30a:	1782                	sll	a5,a5,0x20
 30c:	9381                	srl	a5,a5,0x20
 30e:	fff7c793          	not	a5,a5
 312:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 314:	15fd                	add	a1,a1,-1
 316:	177d                	add	a4,a4,-1
 318:	0005c683          	lbu	a3,0(a1)
 31c:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 320:	fee79ae3          	bne	a5,a4,314 <memmove+0x46>
 324:	bfc9                	j	2f6 <memmove+0x28>

0000000000000326 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 326:	1141                	add	sp,sp,-16
 328:	e422                	sd	s0,8(sp)
 32a:	0800                	add	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 32c:	ca05                	beqz	a2,35c <memcmp+0x36>
 32e:	fff6069b          	addw	a3,a2,-1
 332:	1682                	sll	a3,a3,0x20
 334:	9281                	srl	a3,a3,0x20
 336:	0685                	add	a3,a3,1
 338:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 33a:	00054783          	lbu	a5,0(a0)
 33e:	0005c703          	lbu	a4,0(a1)
 342:	00e79863          	bne	a5,a4,352 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 346:	0505                	add	a0,a0,1
    p2++;
 348:	0585                	add	a1,a1,1
  while (n-- > 0) {
 34a:	fed518e3          	bne	a0,a3,33a <memcmp+0x14>
  }
  return 0;
 34e:	4501                	li	a0,0
 350:	a019                	j	356 <memcmp+0x30>
      return *p1 - *p2;
 352:	40e7853b          	subw	a0,a5,a4
}
 356:	6422                	ld	s0,8(sp)
 358:	0141                	add	sp,sp,16
 35a:	8082                	ret
  return 0;
 35c:	4501                	li	a0,0
 35e:	bfe5                	j	356 <memcmp+0x30>

0000000000000360 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 360:	1141                	add	sp,sp,-16
 362:	e406                	sd	ra,8(sp)
 364:	e022                	sd	s0,0(sp)
 366:	0800                	add	s0,sp,16
  return memmove(dst, src, n);
 368:	f67ff0ef          	jal	2ce <memmove>
}
 36c:	60a2                	ld	ra,8(sp)
 36e:	6402                	ld	s0,0(sp)
 370:	0141                	add	sp,sp,16
 372:	8082                	ret

0000000000000374 <sbrk>:

char *
sbrk(int n) {
 374:	1141                	add	sp,sp,-16
 376:	e406                	sd	ra,8(sp)
 378:	e022                	sd	s0,0(sp)
 37a:	0800                	add	s0,sp,16
  return sys_sbrk(n, SBRK_EAGER);
 37c:	4585                	li	a1,1
 37e:	152000ef          	jal	4d0 <sys_sbrk>
}
 382:	60a2                	ld	ra,8(sp)
 384:	6402                	ld	s0,0(sp)
 386:	0141                	add	sp,sp,16
 388:	8082                	ret

000000000000038a <sbrklazy>:

char *
sbrklazy(int n) {
 38a:	1141                	add	sp,sp,-16
 38c:	e406                	sd	ra,8(sp)
 38e:	e022                	sd	s0,0(sp)
 390:	0800                	add	s0,sp,16
  return sys_sbrk(n, SBRK_LAZY);
 392:	4589                	li	a1,2
 394:	13c000ef          	jal	4d0 <sys_sbrk>
}
 398:	60a2                	ld	ra,8(sp)
 39a:	6402                	ld	s0,0(sp)
 39c:	0141                	add	sp,sp,16
 39e:	8082                	ret

00000000000003a0 <htons>:

// Byte order conversion functions
unsigned short
htons(unsigned short hostshort)
{
 3a0:	1141                	add	sp,sp,-16
 3a2:	e422                	sd	s0,8(sp)
 3a4:	0800                	add	s0,sp,16
  return ((hostshort >> 8) & 0xff) | ((hostshort & 0xff) << 8);
 3a6:	0085179b          	sllw	a5,a0,0x8
 3aa:	0085551b          	srlw	a0,a0,0x8
 3ae:	8d5d                	or	a0,a0,a5
}
 3b0:	1542                	sll	a0,a0,0x30
 3b2:	9141                	srl	a0,a0,0x30
 3b4:	6422                	ld	s0,8(sp)
 3b6:	0141                	add	sp,sp,16
 3b8:	8082                	ret

00000000000003ba <ntohs>:

unsigned short
ntohs(unsigned short netshort)
{
 3ba:	1141                	add	sp,sp,-16
 3bc:	e422                	sd	s0,8(sp)
 3be:	0800                	add	s0,sp,16
  return ((netshort >> 8) & 0xff) | ((netshort & 0xff) << 8);
 3c0:	0085179b          	sllw	a5,a0,0x8
 3c4:	0085551b          	srlw	a0,a0,0x8
 3c8:	8d5d                	or	a0,a0,a5
}
 3ca:	1542                	sll	a0,a0,0x30
 3cc:	9141                	srl	a0,a0,0x30
 3ce:	6422                	ld	s0,8(sp)
 3d0:	0141                	add	sp,sp,16
 3d2:	8082                	ret

00000000000003d4 <htonl>:

unsigned long
htonl(unsigned long hostlong)
{
 3d4:	1141                	add	sp,sp,-16
 3d6:	e422                	sd	s0,8(sp)
 3d8:	0800                	add	s0,sp,16
  return ((hostlong >> 24) & 0xff) |
 3da:	0185579b          	srlw	a5,a0,0x18
         ((hostlong >> 8) & 0xff00) |
 3de:	00855713          	srl	a4,a0,0x8
 3e2:	66c1                	lui	a3,0x10
 3e4:	f0068693          	add	a3,a3,-256 # ff00 <base+0xeef0>
 3e8:	8f75                	and	a4,a4,a3
  return ((hostlong >> 24) & 0xff) |
 3ea:	8fd9                	or	a5,a5,a4
         ((hostlong & 0xff00) << 8) |
 3ec:	00851713          	sll	a4,a0,0x8
 3f0:	00ff06b7          	lui	a3,0xff0
 3f4:	8f75                	and	a4,a4,a3
         ((hostlong >> 8) & 0xff00) |
 3f6:	8fd9                	or	a5,a5,a4
         ((hostlong & 0xff) << 24);
 3f8:	0562                	sll	a0,a0,0x18
 3fa:	0ff00713          	li	a4,255
 3fe:	0762                	sll	a4,a4,0x18
 400:	8d79                	and	a0,a0,a4
}
 402:	8d5d                	or	a0,a0,a5
 404:	6422                	ld	s0,8(sp)
 406:	0141                	add	sp,sp,16
 408:	8082                	ret

000000000000040a <ntohl>:

unsigned long
ntohl(unsigned long netlong)
{
 40a:	1141                	add	sp,sp,-16
 40c:	e422                	sd	s0,8(sp)
 40e:	0800                	add	s0,sp,16
  return ((netlong >> 24) & 0xff) |
 410:	0185579b          	srlw	a5,a0,0x18
         ((netlong >> 8) & 0xff00) |
 414:	00855713          	srl	a4,a0,0x8
 418:	66c1                	lui	a3,0x10
 41a:	f0068693          	add	a3,a3,-256 # ff00 <base+0xeef0>
 41e:	8f75                	and	a4,a4,a3
  return ((netlong >> 24) & 0xff) |
 420:	8fd9                	or	a5,a5,a4
         ((netlong & 0xff00) << 8) |
 422:	00851713          	sll	a4,a0,0x8
 426:	00ff06b7          	lui	a3,0xff0
 42a:	8f75                	and	a4,a4,a3
         ((netlong >> 8) & 0xff00) |
 42c:	8fd9                	or	a5,a5,a4
         ((netlong & 0xff) << 24);
 42e:	0562                	sll	a0,a0,0x18
 430:	0ff00713          	li	a4,255
 434:	0762                	sll	a4,a4,0x18
 436:	8d79                	and	a0,a0,a4
}
 438:	8d5d                	or	a0,a0,a5
 43a:	6422                	ld	s0,8(sp)
 43c:	0141                	add	sp,sp,16
 43e:	8082                	ret

0000000000000440 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 440:	4885                	li	a7,1
 ecall
 442:	00000073          	ecall
 ret
 446:	8082                	ret

0000000000000448 <exit>:
.global exit
exit:
 li a7, SYS_exit
 448:	4889                	li	a7,2
 ecall
 44a:	00000073          	ecall
 ret
 44e:	8082                	ret

0000000000000450 <wait>:
.global wait
wait:
 li a7, SYS_wait
 450:	488d                	li	a7,3
 ecall
 452:	00000073          	ecall
 ret
 456:	8082                	ret

0000000000000458 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 458:	4891                	li	a7,4
 ecall
 45a:	00000073          	ecall
 ret
 45e:	8082                	ret

0000000000000460 <read>:
.global read
read:
 li a7, SYS_read
 460:	4895                	li	a7,5
 ecall
 462:	00000073          	ecall
 ret
 466:	8082                	ret

0000000000000468 <write>:
.global write
write:
 li a7, SYS_write
 468:	48c1                	li	a7,16
 ecall
 46a:	00000073          	ecall
 ret
 46e:	8082                	ret

0000000000000470 <close>:
.global close
close:
 li a7, SYS_close
 470:	48d5                	li	a7,21
 ecall
 472:	00000073          	ecall
 ret
 476:	8082                	ret

0000000000000478 <kill>:
.global kill
kill:
 li a7, SYS_kill
 478:	4899                	li	a7,6
 ecall
 47a:	00000073          	ecall
 ret
 47e:	8082                	ret

0000000000000480 <exec>:
.global exec
exec:
 li a7, SYS_exec
 480:	489d                	li	a7,7
 ecall
 482:	00000073          	ecall
 ret
 486:	8082                	ret

0000000000000488 <open>:
.global open
open:
 li a7, SYS_open
 488:	48bd                	li	a7,15
 ecall
 48a:	00000073          	ecall
 ret
 48e:	8082                	ret

0000000000000490 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 490:	48c5                	li	a7,17
 ecall
 492:	00000073          	ecall
 ret
 496:	8082                	ret

0000000000000498 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 498:	48c9                	li	a7,18
 ecall
 49a:	00000073          	ecall
 ret
 49e:	8082                	ret

00000000000004a0 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 4a0:	48a1                	li	a7,8
 ecall
 4a2:	00000073          	ecall
 ret
 4a6:	8082                	ret

00000000000004a8 <link>:
.global link
link:
 li a7, SYS_link
 4a8:	48cd                	li	a7,19
 ecall
 4aa:	00000073          	ecall
 ret
 4ae:	8082                	ret

00000000000004b0 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 4b0:	48d1                	li	a7,20
 ecall
 4b2:	00000073          	ecall
 ret
 4b6:	8082                	ret

00000000000004b8 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 4b8:	48a5                	li	a7,9
 ecall
 4ba:	00000073          	ecall
 ret
 4be:	8082                	ret

00000000000004c0 <dup>:
.global dup
dup:
 li a7, SYS_dup
 4c0:	48a9                	li	a7,10
 ecall
 4c2:	00000073          	ecall
 ret
 4c6:	8082                	ret

00000000000004c8 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 4c8:	48ad                	li	a7,11
 ecall
 4ca:	00000073          	ecall
 ret
 4ce:	8082                	ret

00000000000004d0 <sys_sbrk>:
.global sys_sbrk
sys_sbrk:
 li a7, SYS_sbrk
 4d0:	48b1                	li	a7,12
 ecall
 4d2:	00000073          	ecall
 ret
 4d6:	8082                	ret

00000000000004d8 <pause>:
.global pause
pause:
 li a7, SYS_pause
 4d8:	48b5                	li	a7,13
 ecall
 4da:	00000073          	ecall
 ret
 4de:	8082                	ret

00000000000004e0 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 4e0:	48b9                	li	a7,14
 ecall
 4e2:	00000073          	ecall
 ret
 4e6:	8082                	ret

00000000000004e8 <socket>:
.global socket
socket:
 li a7, SYS_socket
 4e8:	48d9                	li	a7,22
 ecall
 4ea:	00000073          	ecall
 ret
 4ee:	8082                	ret

00000000000004f0 <bind>:
.global bind
bind:
 li a7, SYS_bind
 4f0:	48dd                	li	a7,23
 ecall
 4f2:	00000073          	ecall
 ret
 4f6:	8082                	ret

00000000000004f8 <listen>:
.global listen
listen:
 li a7, SYS_listen
 4f8:	48e1                	li	a7,24
 ecall
 4fa:	00000073          	ecall
 ret
 4fe:	8082                	ret

0000000000000500 <accept>:
.global accept
accept:
 li a7, SYS_accept
 500:	48e5                	li	a7,25
 ecall
 502:	00000073          	ecall
 ret
 506:	8082                	ret

0000000000000508 <connect>:
.global connect
connect:
 li a7, SYS_connect
 508:	48e9                	li	a7,26
 ecall
 50a:	00000073          	ecall
 ret
 50e:	8082                	ret

0000000000000510 <send>:
.global send
send:
 li a7, SYS_send
 510:	48ed                	li	a7,27
 ecall
 512:	00000073          	ecall
 ret
 516:	8082                	ret

0000000000000518 <recv>:
.global recv
recv:
 li a7, SYS_recv
 518:	48f1                	li	a7,28
 ecall
 51a:	00000073          	ecall
 ret
 51e:	8082                	ret

0000000000000520 <sendto>:
.global sendto
sendto:
 li a7, SYS_sendto
 520:	48f5                	li	a7,29
 ecall
 522:	00000073          	ecall
 ret
 526:	8082                	ret

0000000000000528 <recvfrom>:
.global recvfrom
recvfrom:
 li a7, SYS_recvfrom
 528:	48f9                	li	a7,30
 ecall
 52a:	00000073          	ecall
 ret
 52e:	8082                	ret

0000000000000530 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 530:	1101                	add	sp,sp,-32
 532:	ec06                	sd	ra,24(sp)
 534:	e822                	sd	s0,16(sp)
 536:	1000                	add	s0,sp,32
 538:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 53c:	4605                	li	a2,1
 53e:	fef40593          	add	a1,s0,-17
 542:	f27ff0ef          	jal	468 <write>
}
 546:	60e2                	ld	ra,24(sp)
 548:	6442                	ld	s0,16(sp)
 54a:	6105                	add	sp,sp,32
 54c:	8082                	ret

000000000000054e <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
 54e:	715d                	add	sp,sp,-80
 550:	e486                	sd	ra,72(sp)
 552:	e0a2                	sd	s0,64(sp)
 554:	f84a                	sd	s2,48(sp)
 556:	0880                	add	s0,sp,80
 558:	892a                	mv	s2,a0
  char buf[20];
  int i, neg;
  unsigned long long x;

  neg = 0;
  if(sgn && xx < 0){
 55a:	c299                	beqz	a3,560 <printint+0x12>
 55c:	0805c363          	bltz	a1,5e2 <printint+0x94>
  neg = 0;
 560:	4881                	li	a7,0
 562:	fb840693          	add	a3,s0,-72
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
 566:	4781                	li	a5,0
  do{
    buf[i++] = digits[x % base];
 568:	00000517          	auipc	a0,0x0
 56c:	52050513          	add	a0,a0,1312 # a88 <digits>
 570:	883e                	mv	a6,a5
 572:	2785                	addw	a5,a5,1
 574:	02c5f733          	remu	a4,a1,a2
 578:	972a                	add	a4,a4,a0
 57a:	00074703          	lbu	a4,0(a4)
 57e:	00e68023          	sb	a4,0(a3) # ff0000 <base+0xfeeff0>
  }while((x /= base) != 0);
 582:	872e                	mv	a4,a1
 584:	02c5d5b3          	divu	a1,a1,a2
 588:	0685                	add	a3,a3,1
 58a:	fec773e3          	bgeu	a4,a2,570 <printint+0x22>
  if(neg)
 58e:	00088b63          	beqz	a7,5a4 <printint+0x56>
    buf[i++] = '-';
 592:	fd078793          	add	a5,a5,-48
 596:	97a2                	add	a5,a5,s0
 598:	02d00713          	li	a4,45
 59c:	fee78423          	sb	a4,-24(a5)
 5a0:	0028079b          	addw	a5,a6,2

  while(--i >= 0)
 5a4:	02f05a63          	blez	a5,5d8 <printint+0x8a>
 5a8:	fc26                	sd	s1,56(sp)
 5aa:	f44e                	sd	s3,40(sp)
 5ac:	fb840713          	add	a4,s0,-72
 5b0:	00f704b3          	add	s1,a4,a5
 5b4:	fff70993          	add	s3,a4,-1
 5b8:	99be                	add	s3,s3,a5
 5ba:	37fd                	addw	a5,a5,-1
 5bc:	1782                	sll	a5,a5,0x20
 5be:	9381                	srl	a5,a5,0x20
 5c0:	40f989b3          	sub	s3,s3,a5
    putc(fd, buf[i]);
 5c4:	fff4c583          	lbu	a1,-1(s1)
 5c8:	854a                	mv	a0,s2
 5ca:	f67ff0ef          	jal	530 <putc>
  while(--i >= 0)
 5ce:	14fd                	add	s1,s1,-1
 5d0:	ff349ae3          	bne	s1,s3,5c4 <printint+0x76>
 5d4:	74e2                	ld	s1,56(sp)
 5d6:	79a2                	ld	s3,40(sp)
}
 5d8:	60a6                	ld	ra,72(sp)
 5da:	6406                	ld	s0,64(sp)
 5dc:	7942                	ld	s2,48(sp)
 5de:	6161                	add	sp,sp,80
 5e0:	8082                	ret
    x = -xx;
 5e2:	40b005b3          	neg	a1,a1
    neg = 1;
 5e6:	4885                	li	a7,1
    x = -xx;
 5e8:	bfad                	j	562 <printint+0x14>

00000000000005ea <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %c, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 5ea:	711d                	add	sp,sp,-96
 5ec:	ec86                	sd	ra,88(sp)
 5ee:	e8a2                	sd	s0,80(sp)
 5f0:	e0ca                	sd	s2,64(sp)
 5f2:	1080                	add	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 5f4:	0005c903          	lbu	s2,0(a1)
 5f8:	28090663          	beqz	s2,884 <vprintf+0x29a>
 5fc:	e4a6                	sd	s1,72(sp)
 5fe:	fc4e                	sd	s3,56(sp)
 600:	f852                	sd	s4,48(sp)
 602:	f456                	sd	s5,40(sp)
 604:	f05a                	sd	s6,32(sp)
 606:	ec5e                	sd	s7,24(sp)
 608:	e862                	sd	s8,16(sp)
 60a:	e466                	sd	s9,8(sp)
 60c:	8b2a                	mv	s6,a0
 60e:	8a2e                	mv	s4,a1
 610:	8bb2                	mv	s7,a2
  state = 0;
 612:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
 614:	4481                	li	s1,0
 616:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
 618:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
 61c:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
 620:	06c00c93          	li	s9,108
 624:	a005                	j	644 <vprintf+0x5a>
        putc(fd, c0);
 626:	85ca                	mv	a1,s2
 628:	855a                	mv	a0,s6
 62a:	f07ff0ef          	jal	530 <putc>
 62e:	a019                	j	634 <vprintf+0x4a>
    } else if(state == '%'){
 630:	03598263          	beq	s3,s5,654 <vprintf+0x6a>
  for(i = 0; fmt[i]; i++){
 634:	2485                	addw	s1,s1,1
 636:	8726                	mv	a4,s1
 638:	009a07b3          	add	a5,s4,s1
 63c:	0007c903          	lbu	s2,0(a5)
 640:	22090a63          	beqz	s2,874 <vprintf+0x28a>
    c0 = fmt[i] & 0xff;
 644:	0009079b          	sext.w	a5,s2
    if(state == 0){
 648:	fe0994e3          	bnez	s3,630 <vprintf+0x46>
      if(c0 == '%'){
 64c:	fd579de3          	bne	a5,s5,626 <vprintf+0x3c>
        state = '%';
 650:	89be                	mv	s3,a5
 652:	b7cd                	j	634 <vprintf+0x4a>
      if(c0) c1 = fmt[i+1] & 0xff;
 654:	00ea06b3          	add	a3,s4,a4
 658:	0016c683          	lbu	a3,1(a3)
      c1 = c2 = 0;
 65c:	8636                	mv	a2,a3
      if(c1) c2 = fmt[i+2] & 0xff;
 65e:	c681                	beqz	a3,666 <vprintf+0x7c>
 660:	9752                	add	a4,a4,s4
 662:	00274603          	lbu	a2,2(a4)
      if(c0 == 'd'){
 666:	05878363          	beq	a5,s8,6ac <vprintf+0xc2>
      } else if(c0 == 'l' && c1 == 'd'){
 66a:	05978d63          	beq	a5,s9,6c4 <vprintf+0xda>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
 66e:	07500713          	li	a4,117
 672:	0ee78763          	beq	a5,a4,760 <vprintf+0x176>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
 676:	07800713          	li	a4,120
 67a:	12e78963          	beq	a5,a4,7ac <vprintf+0x1c2>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
 67e:	07000713          	li	a4,112
 682:	14e78e63          	beq	a5,a4,7de <vprintf+0x1f4>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 'c'){
 686:	06300713          	li	a4,99
 68a:	18e78e63          	beq	a5,a4,826 <vprintf+0x23c>
        putc(fd, va_arg(ap, uint32));
      } else if(c0 == 's'){
 68e:	07300713          	li	a4,115
 692:	1ae78463          	beq	a5,a4,83a <vprintf+0x250>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
 696:	02500713          	li	a4,37
 69a:	04e79563          	bne	a5,a4,6e4 <vprintf+0xfa>
        putc(fd, '%');
 69e:	02500593          	li	a1,37
 6a2:	855a                	mv	a0,s6
 6a4:	e8dff0ef          	jal	530 <putc>
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c0);
      }

      state = 0;
 6a8:	4981                	li	s3,0
 6aa:	b769                	j	634 <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 1);
 6ac:	008b8913          	add	s2,s7,8
 6b0:	4685                	li	a3,1
 6b2:	4629                	li	a2,10
 6b4:	000ba583          	lw	a1,0(s7)
 6b8:	855a                	mv	a0,s6
 6ba:	e95ff0ef          	jal	54e <printint>
 6be:	8bca                	mv	s7,s2
      state = 0;
 6c0:	4981                	li	s3,0
 6c2:	bf8d                	j	634 <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'd'){
 6c4:	06400793          	li	a5,100
 6c8:	02f68963          	beq	a3,a5,6fa <vprintf+0x110>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 6cc:	06c00793          	li	a5,108
 6d0:	04f68263          	beq	a3,a5,714 <vprintf+0x12a>
      } else if(c0 == 'l' && c1 == 'u'){
 6d4:	07500793          	li	a5,117
 6d8:	0af68063          	beq	a3,a5,778 <vprintf+0x18e>
      } else if(c0 == 'l' && c1 == 'x'){
 6dc:	07800793          	li	a5,120
 6e0:	0ef68263          	beq	a3,a5,7c4 <vprintf+0x1da>
        putc(fd, '%');
 6e4:	02500593          	li	a1,37
 6e8:	855a                	mv	a0,s6
 6ea:	e47ff0ef          	jal	530 <putc>
        putc(fd, c0);
 6ee:	85ca                	mv	a1,s2
 6f0:	855a                	mv	a0,s6
 6f2:	e3fff0ef          	jal	530 <putc>
      state = 0;
 6f6:	4981                	li	s3,0
 6f8:	bf35                	j	634 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 6fa:	008b8913          	add	s2,s7,8
 6fe:	4685                	li	a3,1
 700:	4629                	li	a2,10
 702:	000bb583          	ld	a1,0(s7)
 706:	855a                	mv	a0,s6
 708:	e47ff0ef          	jal	54e <printint>
        i += 1;
 70c:	2485                	addw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 70e:	8bca                	mv	s7,s2
      state = 0;
 710:	4981                	li	s3,0
        i += 1;
 712:	b70d                	j	634 <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 714:	06400793          	li	a5,100
 718:	02f60763          	beq	a2,a5,746 <vprintf+0x15c>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 71c:	07500793          	li	a5,117
 720:	06f60963          	beq	a2,a5,792 <vprintf+0x1a8>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 724:	07800793          	li	a5,120
 728:	faf61ee3          	bne	a2,a5,6e4 <vprintf+0xfa>
        printint(fd, va_arg(ap, uint64), 16, 0);
 72c:	008b8913          	add	s2,s7,8
 730:	4681                	li	a3,0
 732:	4641                	li	a2,16
 734:	000bb583          	ld	a1,0(s7)
 738:	855a                	mv	a0,s6
 73a:	e15ff0ef          	jal	54e <printint>
        i += 2;
 73e:	2489                	addw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 740:	8bca                	mv	s7,s2
      state = 0;
 742:	4981                	li	s3,0
        i += 2;
 744:	bdc5                	j	634 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 746:	008b8913          	add	s2,s7,8
 74a:	4685                	li	a3,1
 74c:	4629                	li	a2,10
 74e:	000bb583          	ld	a1,0(s7)
 752:	855a                	mv	a0,s6
 754:	dfbff0ef          	jal	54e <printint>
        i += 2;
 758:	2489                	addw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 75a:	8bca                	mv	s7,s2
      state = 0;
 75c:	4981                	li	s3,0
        i += 2;
 75e:	bdd9                	j	634 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint32), 10, 0);
 760:	008b8913          	add	s2,s7,8
 764:	4681                	li	a3,0
 766:	4629                	li	a2,10
 768:	000be583          	lwu	a1,0(s7)
 76c:	855a                	mv	a0,s6
 76e:	de1ff0ef          	jal	54e <printint>
 772:	8bca                	mv	s7,s2
      state = 0;
 774:	4981                	li	s3,0
 776:	bd7d                	j	634 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 778:	008b8913          	add	s2,s7,8
 77c:	4681                	li	a3,0
 77e:	4629                	li	a2,10
 780:	000bb583          	ld	a1,0(s7)
 784:	855a                	mv	a0,s6
 786:	dc9ff0ef          	jal	54e <printint>
        i += 1;
 78a:	2485                	addw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 78c:	8bca                	mv	s7,s2
      state = 0;
 78e:	4981                	li	s3,0
        i += 1;
 790:	b555                	j	634 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 792:	008b8913          	add	s2,s7,8
 796:	4681                	li	a3,0
 798:	4629                	li	a2,10
 79a:	000bb583          	ld	a1,0(s7)
 79e:	855a                	mv	a0,s6
 7a0:	dafff0ef          	jal	54e <printint>
        i += 2;
 7a4:	2489                	addw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 7a6:	8bca                	mv	s7,s2
      state = 0;
 7a8:	4981                	li	s3,0
        i += 2;
 7aa:	b569                	j	634 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint32), 16, 0);
 7ac:	008b8913          	add	s2,s7,8
 7b0:	4681                	li	a3,0
 7b2:	4641                	li	a2,16
 7b4:	000be583          	lwu	a1,0(s7)
 7b8:	855a                	mv	a0,s6
 7ba:	d95ff0ef          	jal	54e <printint>
 7be:	8bca                	mv	s7,s2
      state = 0;
 7c0:	4981                	li	s3,0
 7c2:	bd8d                	j	634 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 16, 0);
 7c4:	008b8913          	add	s2,s7,8
 7c8:	4681                	li	a3,0
 7ca:	4641                	li	a2,16
 7cc:	000bb583          	ld	a1,0(s7)
 7d0:	855a                	mv	a0,s6
 7d2:	d7dff0ef          	jal	54e <printint>
        i += 1;
 7d6:	2485                	addw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 7d8:	8bca                	mv	s7,s2
      state = 0;
 7da:	4981                	li	s3,0
        i += 1;
 7dc:	bda1                	j	634 <vprintf+0x4a>
 7de:	e06a                	sd	s10,0(sp)
        printptr(fd, va_arg(ap, uint64));
 7e0:	008b8d13          	add	s10,s7,8
 7e4:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 7e8:	03000593          	li	a1,48
 7ec:	855a                	mv	a0,s6
 7ee:	d43ff0ef          	jal	530 <putc>
  putc(fd, 'x');
 7f2:	07800593          	li	a1,120
 7f6:	855a                	mv	a0,s6
 7f8:	d39ff0ef          	jal	530 <putc>
 7fc:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 7fe:	00000b97          	auipc	s7,0x0
 802:	28ab8b93          	add	s7,s7,650 # a88 <digits>
 806:	03c9d793          	srl	a5,s3,0x3c
 80a:	97de                	add	a5,a5,s7
 80c:	0007c583          	lbu	a1,0(a5)
 810:	855a                	mv	a0,s6
 812:	d1fff0ef          	jal	530 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 816:	0992                	sll	s3,s3,0x4
 818:	397d                	addw	s2,s2,-1
 81a:	fe0916e3          	bnez	s2,806 <vprintf+0x21c>
        printptr(fd, va_arg(ap, uint64));
 81e:	8bea                	mv	s7,s10
      state = 0;
 820:	4981                	li	s3,0
 822:	6d02                	ld	s10,0(sp)
 824:	bd01                	j	634 <vprintf+0x4a>
        putc(fd, va_arg(ap, uint32));
 826:	008b8913          	add	s2,s7,8
 82a:	000bc583          	lbu	a1,0(s7)
 82e:	855a                	mv	a0,s6
 830:	d01ff0ef          	jal	530 <putc>
 834:	8bca                	mv	s7,s2
      state = 0;
 836:	4981                	li	s3,0
 838:	bbf5                	j	634 <vprintf+0x4a>
        if((s = va_arg(ap, char*)) == 0)
 83a:	008b8993          	add	s3,s7,8
 83e:	000bb903          	ld	s2,0(s7)
 842:	00090f63          	beqz	s2,860 <vprintf+0x276>
        for(; *s; s++)
 846:	00094583          	lbu	a1,0(s2)
 84a:	c195                	beqz	a1,86e <vprintf+0x284>
          putc(fd, *s);
 84c:	855a                	mv	a0,s6
 84e:	ce3ff0ef          	jal	530 <putc>
        for(; *s; s++)
 852:	0905                	add	s2,s2,1
 854:	00094583          	lbu	a1,0(s2)
 858:	f9f5                	bnez	a1,84c <vprintf+0x262>
        if((s = va_arg(ap, char*)) == 0)
 85a:	8bce                	mv	s7,s3
      state = 0;
 85c:	4981                	li	s3,0
 85e:	bbd9                	j	634 <vprintf+0x4a>
          s = "(null)";
 860:	00000917          	auipc	s2,0x0
 864:	22090913          	add	s2,s2,544 # a80 <malloc+0x114>
        for(; *s; s++)
 868:	02800593          	li	a1,40
 86c:	b7c5                	j	84c <vprintf+0x262>
        if((s = va_arg(ap, char*)) == 0)
 86e:	8bce                	mv	s7,s3
      state = 0;
 870:	4981                	li	s3,0
 872:	b3c9                	j	634 <vprintf+0x4a>
 874:	64a6                	ld	s1,72(sp)
 876:	79e2                	ld	s3,56(sp)
 878:	7a42                	ld	s4,48(sp)
 87a:	7aa2                	ld	s5,40(sp)
 87c:	7b02                	ld	s6,32(sp)
 87e:	6be2                	ld	s7,24(sp)
 880:	6c42                	ld	s8,16(sp)
 882:	6ca2                	ld	s9,8(sp)
    }
  }
}
 884:	60e6                	ld	ra,88(sp)
 886:	6446                	ld	s0,80(sp)
 888:	6906                	ld	s2,64(sp)
 88a:	6125                	add	sp,sp,96
 88c:	8082                	ret

000000000000088e <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 88e:	715d                	add	sp,sp,-80
 890:	ec06                	sd	ra,24(sp)
 892:	e822                	sd	s0,16(sp)
 894:	1000                	add	s0,sp,32
 896:	e010                	sd	a2,0(s0)
 898:	e414                	sd	a3,8(s0)
 89a:	e818                	sd	a4,16(s0)
 89c:	ec1c                	sd	a5,24(s0)
 89e:	03043023          	sd	a6,32(s0)
 8a2:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 8a6:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 8aa:	8622                	mv	a2,s0
 8ac:	d3fff0ef          	jal	5ea <vprintf>
}
 8b0:	60e2                	ld	ra,24(sp)
 8b2:	6442                	ld	s0,16(sp)
 8b4:	6161                	add	sp,sp,80
 8b6:	8082                	ret

00000000000008b8 <printf>:

void
printf(const char *fmt, ...)
{
 8b8:	711d                	add	sp,sp,-96
 8ba:	ec06                	sd	ra,24(sp)
 8bc:	e822                	sd	s0,16(sp)
 8be:	1000                	add	s0,sp,32
 8c0:	e40c                	sd	a1,8(s0)
 8c2:	e810                	sd	a2,16(s0)
 8c4:	ec14                	sd	a3,24(s0)
 8c6:	f018                	sd	a4,32(s0)
 8c8:	f41c                	sd	a5,40(s0)
 8ca:	03043823          	sd	a6,48(s0)
 8ce:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 8d2:	00840613          	add	a2,s0,8
 8d6:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 8da:	85aa                	mv	a1,a0
 8dc:	4505                	li	a0,1
 8de:	d0dff0ef          	jal	5ea <vprintf>
}
 8e2:	60e2                	ld	ra,24(sp)
 8e4:	6442                	ld	s0,16(sp)
 8e6:	6125                	add	sp,sp,96
 8e8:	8082                	ret

00000000000008ea <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 8ea:	1141                	add	sp,sp,-16
 8ec:	e422                	sd	s0,8(sp)
 8ee:	0800                	add	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 8f0:	ff050693          	add	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8f4:	00000797          	auipc	a5,0x0
 8f8:	70c7b783          	ld	a5,1804(a5) # 1000 <freep>
 8fc:	a02d                	j	926 <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 8fe:	4618                	lw	a4,8(a2)
 900:	9f2d                	addw	a4,a4,a1
 902:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 906:	6398                	ld	a4,0(a5)
 908:	6310                	ld	a2,0(a4)
 90a:	a83d                	j	948 <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 90c:	ff852703          	lw	a4,-8(a0)
 910:	9f31                	addw	a4,a4,a2
 912:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 914:	ff053683          	ld	a3,-16(a0)
 918:	a091                	j	95c <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 91a:	6398                	ld	a4,0(a5)
 91c:	00e7e463          	bltu	a5,a4,924 <free+0x3a>
 920:	00e6ea63          	bltu	a3,a4,934 <free+0x4a>
{
 924:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 926:	fed7fae3          	bgeu	a5,a3,91a <free+0x30>
 92a:	6398                	ld	a4,0(a5)
 92c:	00e6e463          	bltu	a3,a4,934 <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 930:	fee7eae3          	bltu	a5,a4,924 <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 934:	ff852583          	lw	a1,-8(a0)
 938:	6390                	ld	a2,0(a5)
 93a:	02059813          	sll	a6,a1,0x20
 93e:	01c85713          	srl	a4,a6,0x1c
 942:	9736                	add	a4,a4,a3
 944:	fae60de3          	beq	a2,a4,8fe <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 948:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 94c:	4790                	lw	a2,8(a5)
 94e:	02061593          	sll	a1,a2,0x20
 952:	01c5d713          	srl	a4,a1,0x1c
 956:	973e                	add	a4,a4,a5
 958:	fae68ae3          	beq	a3,a4,90c <free+0x22>
    p->s.ptr = bp->s.ptr;
 95c:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 95e:	00000717          	auipc	a4,0x0
 962:	6af73123          	sd	a5,1698(a4) # 1000 <freep>
}
 966:	6422                	ld	s0,8(sp)
 968:	0141                	add	sp,sp,16
 96a:	8082                	ret

000000000000096c <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 96c:	7139                	add	sp,sp,-64
 96e:	fc06                	sd	ra,56(sp)
 970:	f822                	sd	s0,48(sp)
 972:	f426                	sd	s1,40(sp)
 974:	ec4e                	sd	s3,24(sp)
 976:	0080                	add	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 978:	02051493          	sll	s1,a0,0x20
 97c:	9081                	srl	s1,s1,0x20
 97e:	04bd                	add	s1,s1,15
 980:	8091                	srl	s1,s1,0x4
 982:	0014899b          	addw	s3,s1,1
 986:	0485                	add	s1,s1,1
  if((prevp = freep) == 0){
 988:	00000517          	auipc	a0,0x0
 98c:	67853503          	ld	a0,1656(a0) # 1000 <freep>
 990:	c915                	beqz	a0,9c4 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 992:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 994:	4798                	lw	a4,8(a5)
 996:	08977a63          	bgeu	a4,s1,a2a <malloc+0xbe>
 99a:	f04a                	sd	s2,32(sp)
 99c:	e852                	sd	s4,16(sp)
 99e:	e456                	sd	s5,8(sp)
 9a0:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 9a2:	8a4e                	mv	s4,s3
 9a4:	0009871b          	sext.w	a4,s3
 9a8:	6685                	lui	a3,0x1
 9aa:	00d77363          	bgeu	a4,a3,9b0 <malloc+0x44>
 9ae:	6a05                	lui	s4,0x1
 9b0:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 9b4:	004a1a1b          	sllw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 9b8:	00000917          	auipc	s2,0x0
 9bc:	64890913          	add	s2,s2,1608 # 1000 <freep>
  if(p == SBRK_ERROR)
 9c0:	5afd                	li	s5,-1
 9c2:	a081                	j	a02 <malloc+0x96>
 9c4:	f04a                	sd	s2,32(sp)
 9c6:	e852                	sd	s4,16(sp)
 9c8:	e456                	sd	s5,8(sp)
 9ca:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 9cc:	00000797          	auipc	a5,0x0
 9d0:	64478793          	add	a5,a5,1604 # 1010 <base>
 9d4:	00000717          	auipc	a4,0x0
 9d8:	62f73623          	sd	a5,1580(a4) # 1000 <freep>
 9dc:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 9de:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 9e2:	b7c1                	j	9a2 <malloc+0x36>
        prevp->s.ptr = p->s.ptr;
 9e4:	6398                	ld	a4,0(a5)
 9e6:	e118                	sd	a4,0(a0)
 9e8:	a8a9                	j	a42 <malloc+0xd6>
  hp->s.size = nu;
 9ea:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 9ee:	0541                	add	a0,a0,16
 9f0:	efbff0ef          	jal	8ea <free>
  return freep;
 9f4:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 9f8:	c12d                	beqz	a0,a5a <malloc+0xee>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 9fa:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 9fc:	4798                	lw	a4,8(a5)
 9fe:	02977263          	bgeu	a4,s1,a22 <malloc+0xb6>
    if(p == freep)
 a02:	00093703          	ld	a4,0(s2)
 a06:	853e                	mv	a0,a5
 a08:	fef719e3          	bne	a4,a5,9fa <malloc+0x8e>
  p = sbrk(nu * sizeof(Header));
 a0c:	8552                	mv	a0,s4
 a0e:	967ff0ef          	jal	374 <sbrk>
  if(p == SBRK_ERROR)
 a12:	fd551ce3          	bne	a0,s5,9ea <malloc+0x7e>
        return 0;
 a16:	4501                	li	a0,0
 a18:	7902                	ld	s2,32(sp)
 a1a:	6a42                	ld	s4,16(sp)
 a1c:	6aa2                	ld	s5,8(sp)
 a1e:	6b02                	ld	s6,0(sp)
 a20:	a03d                	j	a4e <malloc+0xe2>
 a22:	7902                	ld	s2,32(sp)
 a24:	6a42                	ld	s4,16(sp)
 a26:	6aa2                	ld	s5,8(sp)
 a28:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 a2a:	fae48de3          	beq	s1,a4,9e4 <malloc+0x78>
        p->s.size -= nunits;
 a2e:	4137073b          	subw	a4,a4,s3
 a32:	c798                	sw	a4,8(a5)
        p += p->s.size;
 a34:	02071693          	sll	a3,a4,0x20
 a38:	01c6d713          	srl	a4,a3,0x1c
 a3c:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 a3e:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 a42:	00000717          	auipc	a4,0x0
 a46:	5aa73f23          	sd	a0,1470(a4) # 1000 <freep>
      return (void*)(p + 1);
 a4a:	01078513          	add	a0,a5,16
  }
}
 a4e:	70e2                	ld	ra,56(sp)
 a50:	7442                	ld	s0,48(sp)
 a52:	74a2                	ld	s1,40(sp)
 a54:	69e2                	ld	s3,24(sp)
 a56:	6121                	add	sp,sp,64
 a58:	8082                	ret
 a5a:	7902                	ld	s2,32(sp)
 a5c:	6a42                	ld	s4,16(sp)
 a5e:	6aa2                	ld	s5,8(sp)
 a60:	6b02                	ld	s6,0(sp)
 a62:	b7f5                	j	a4e <malloc+0xe2>
