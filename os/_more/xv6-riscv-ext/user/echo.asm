
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
  14:	06a7d863          	bge	a5,a0,84 <main+0x84>
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
  34:	ab0a8a93          	add	s5,s5,-1360 # ae0 <malloc+0x100>
  38:	a819                	j	4e <main+0x4e>
  3a:	4605                	li	a2,1
  3c:	85d6                	mv	a1,s5
  3e:	4505                	li	a0,1
  40:	00000097          	auipc	ra,0x0
  44:	308080e7          	jalr	776(ra) # 348 <write>
  for(i = 1; i < argc; i++){
  48:	04a1                	add	s1,s1,8
  4a:	03348d63          	beq	s1,s3,84 <main+0x84>
    write(1, argv[i], strlen(argv[i]));
  4e:	0004b903          	ld	s2,0(s1)
  52:	854a                	mv	a0,s2
  54:	00000097          	auipc	ra,0x0
  58:	082080e7          	jalr	130(ra) # d6 <strlen>
  5c:	0005061b          	sext.w	a2,a0
  60:	85ca                	mv	a1,s2
  62:	4505                	li	a0,1
  64:	00000097          	auipc	ra,0x0
  68:	2e4080e7          	jalr	740(ra) # 348 <write>
    if(i + 1 < argc){
  6c:	fd4497e3          	bne	s1,s4,3a <main+0x3a>
    } else {
      write(1, "\n", 1);
  70:	4605                	li	a2,1
  72:	00001597          	auipc	a1,0x1
  76:	a7658593          	add	a1,a1,-1418 # ae8 <malloc+0x108>
  7a:	4505                	li	a0,1
  7c:	00000097          	auipc	ra,0x0
  80:	2cc080e7          	jalr	716(ra) # 348 <write>
    }
  }
  exit(0);
  84:	4501                	li	a0,0
  86:	00000097          	auipc	ra,0x0
  8a:	2a2080e7          	jalr	674(ra) # 328 <exit>

000000000000008e <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
  8e:	1141                	add	sp,sp,-16
  90:	e422                	sd	s0,8(sp)
  92:	0800                	add	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  94:	87aa                	mv	a5,a0
  96:	0585                	add	a1,a1,1
  98:	0785                	add	a5,a5,1
  9a:	fff5c703          	lbu	a4,-1(a1)
  9e:	fee78fa3          	sb	a4,-1(a5)
  a2:	fb75                	bnez	a4,96 <strcpy+0x8>
    ;
  return os;
}
  a4:	6422                	ld	s0,8(sp)
  a6:	0141                	add	sp,sp,16
  a8:	8082                	ret

00000000000000aa <strcmp>:

int
strcmp(const char *p, const char *q)
{
  aa:	1141                	add	sp,sp,-16
  ac:	e422                	sd	s0,8(sp)
  ae:	0800                	add	s0,sp,16
  while(*p && *p == *q)
  b0:	00054783          	lbu	a5,0(a0)
  b4:	cb91                	beqz	a5,c8 <strcmp+0x1e>
  b6:	0005c703          	lbu	a4,0(a1)
  ba:	00f71763          	bne	a4,a5,c8 <strcmp+0x1e>
    p++, q++;
  be:	0505                	add	a0,a0,1
  c0:	0585                	add	a1,a1,1
  while(*p && *p == *q)
  c2:	00054783          	lbu	a5,0(a0)
  c6:	fbe5                	bnez	a5,b6 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
  c8:	0005c503          	lbu	a0,0(a1)
}
  cc:	40a7853b          	subw	a0,a5,a0
  d0:	6422                	ld	s0,8(sp)
  d2:	0141                	add	sp,sp,16
  d4:	8082                	ret

00000000000000d6 <strlen>:

uint
strlen(const char *s)
{
  d6:	1141                	add	sp,sp,-16
  d8:	e422                	sd	s0,8(sp)
  da:	0800                	add	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
  dc:	00054783          	lbu	a5,0(a0)
  e0:	cf91                	beqz	a5,fc <strlen+0x26>
  e2:	0505                	add	a0,a0,1
  e4:	87aa                	mv	a5,a0
  e6:	86be                	mv	a3,a5
  e8:	0785                	add	a5,a5,1
  ea:	fff7c703          	lbu	a4,-1(a5)
  ee:	ff65                	bnez	a4,e6 <strlen+0x10>
  f0:	40a6853b          	subw	a0,a3,a0
  f4:	2505                	addw	a0,a0,1
    ;
  return n;
}
  f6:	6422                	ld	s0,8(sp)
  f8:	0141                	add	sp,sp,16
  fa:	8082                	ret
  for(n = 0; s[n]; n++)
  fc:	4501                	li	a0,0
  fe:	bfe5                	j	f6 <strlen+0x20>

0000000000000100 <strcat>:

char *
strcat(char *dst, char *src)
{
 100:	1141                	add	sp,sp,-16
 102:	e422                	sd	s0,8(sp)
 104:	0800                	add	s0,sp,16
  char *s = dst;
  while (*dst)
 106:	00054783          	lbu	a5,0(a0)
 10a:	c385                	beqz	a5,12a <strcat+0x2a>
 10c:	87aa                	mv	a5,a0
    dst++;
 10e:	0785                	add	a5,a5,1
  while (*dst)
 110:	0007c703          	lbu	a4,0(a5)
 114:	ff6d                	bnez	a4,10e <strcat+0xe>
  while ((*dst++ = *src++) != 0);
 116:	0585                	add	a1,a1,1
 118:	0785                	add	a5,a5,1
 11a:	fff5c703          	lbu	a4,-1(a1)
 11e:	fee78fa3          	sb	a4,-1(a5)
 122:	fb75                	bnez	a4,116 <strcat+0x16>

  return s;
}
 124:	6422                	ld	s0,8(sp)
 126:	0141                	add	sp,sp,16
 128:	8082                	ret
  while (*dst)
 12a:	87aa                	mv	a5,a0
 12c:	b7ed                	j	116 <strcat+0x16>

000000000000012e <memset>:

void*
memset(void *dst, int c, uint n)
{
 12e:	1141                	add	sp,sp,-16
 130:	e422                	sd	s0,8(sp)
 132:	0800                	add	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 134:	ca19                	beqz	a2,14a <memset+0x1c>
 136:	87aa                	mv	a5,a0
 138:	1602                	sll	a2,a2,0x20
 13a:	9201                	srl	a2,a2,0x20
 13c:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 140:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 144:	0785                	add	a5,a5,1
 146:	fee79de3          	bne	a5,a4,140 <memset+0x12>
  }
  return dst;
}
 14a:	6422                	ld	s0,8(sp)
 14c:	0141                	add	sp,sp,16
 14e:	8082                	ret

0000000000000150 <strchr>:

char*
strchr(const char *s, char c)
{
 150:	1141                	add	sp,sp,-16
 152:	e422                	sd	s0,8(sp)
 154:	0800                	add	s0,sp,16
  for(; *s; s++)
 156:	00054783          	lbu	a5,0(a0)
 15a:	cb99                	beqz	a5,170 <strchr+0x20>
    if(*s == c)
 15c:	00f58763          	beq	a1,a5,16a <strchr+0x1a>
  for(; *s; s++)
 160:	0505                	add	a0,a0,1
 162:	00054783          	lbu	a5,0(a0)
 166:	fbfd                	bnez	a5,15c <strchr+0xc>
      return (char*)s;
  return 0;
 168:	4501                	li	a0,0
}
 16a:	6422                	ld	s0,8(sp)
 16c:	0141                	add	sp,sp,16
 16e:	8082                	ret
  return 0;
 170:	4501                	li	a0,0
 172:	bfe5                	j	16a <strchr+0x1a>

0000000000000174 <gets>:

char*
gets(char *buf, int max)
{
 174:	711d                	add	sp,sp,-96
 176:	ec86                	sd	ra,88(sp)
 178:	e8a2                	sd	s0,80(sp)
 17a:	e4a6                	sd	s1,72(sp)
 17c:	e0ca                	sd	s2,64(sp)
 17e:	fc4e                	sd	s3,56(sp)
 180:	f852                	sd	s4,48(sp)
 182:	f456                	sd	s5,40(sp)
 184:	f05a                	sd	s6,32(sp)
 186:	ec5e                	sd	s7,24(sp)
 188:	1080                	add	s0,sp,96
 18a:	8baa                	mv	s7,a0
 18c:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 18e:	892a                	mv	s2,a0
 190:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 192:	4aa9                	li	s5,10
 194:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 196:	89a6                	mv	s3,s1
 198:	2485                	addw	s1,s1,1
 19a:	0344d863          	bge	s1,s4,1ca <gets+0x56>
    cc = read(0, &c, 1);
 19e:	4605                	li	a2,1
 1a0:	faf40593          	add	a1,s0,-81
 1a4:	4501                	li	a0,0
 1a6:	00000097          	auipc	ra,0x0
 1aa:	19a080e7          	jalr	410(ra) # 340 <read>
    if(cc < 1)
 1ae:	00a05e63          	blez	a0,1ca <gets+0x56>
    buf[i++] = c;
 1b2:	faf44783          	lbu	a5,-81(s0)
 1b6:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 1ba:	01578763          	beq	a5,s5,1c8 <gets+0x54>
 1be:	0905                	add	s2,s2,1
 1c0:	fd679be3          	bne	a5,s6,196 <gets+0x22>
    buf[i++] = c;
 1c4:	89a6                	mv	s3,s1
 1c6:	a011                	j	1ca <gets+0x56>
 1c8:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 1ca:	99de                	add	s3,s3,s7
 1cc:	00098023          	sb	zero,0(s3)
  return buf;
}
 1d0:	855e                	mv	a0,s7
 1d2:	60e6                	ld	ra,88(sp)
 1d4:	6446                	ld	s0,80(sp)
 1d6:	64a6                	ld	s1,72(sp)
 1d8:	6906                	ld	s2,64(sp)
 1da:	79e2                	ld	s3,56(sp)
 1dc:	7a42                	ld	s4,48(sp)
 1de:	7aa2                	ld	s5,40(sp)
 1e0:	7b02                	ld	s6,32(sp)
 1e2:	6be2                	ld	s7,24(sp)
 1e4:	6125                	add	sp,sp,96
 1e6:	8082                	ret

00000000000001e8 <stat>:

int
stat(const char *n, struct stat *st)
{
 1e8:	1101                	add	sp,sp,-32
 1ea:	ec06                	sd	ra,24(sp)
 1ec:	e822                	sd	s0,16(sp)
 1ee:	e04a                	sd	s2,0(sp)
 1f0:	1000                	add	s0,sp,32
 1f2:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1f4:	4581                	li	a1,0
 1f6:	00000097          	auipc	ra,0x0
 1fa:	172080e7          	jalr	370(ra) # 368 <open>
  if(fd < 0)
 1fe:	02054663          	bltz	a0,22a <stat+0x42>
 202:	e426                	sd	s1,8(sp)
 204:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 206:	85ca                	mv	a1,s2
 208:	00000097          	auipc	ra,0x0
 20c:	178080e7          	jalr	376(ra) # 380 <fstat>
 210:	892a                	mv	s2,a0
  close(fd);
 212:	8526                	mv	a0,s1
 214:	00000097          	auipc	ra,0x0
 218:	13c080e7          	jalr	316(ra) # 350 <close>
  return r;
 21c:	64a2                	ld	s1,8(sp)
}
 21e:	854a                	mv	a0,s2
 220:	60e2                	ld	ra,24(sp)
 222:	6442                	ld	s0,16(sp)
 224:	6902                	ld	s2,0(sp)
 226:	6105                	add	sp,sp,32
 228:	8082                	ret
    return -1;
 22a:	597d                	li	s2,-1
 22c:	bfcd                	j	21e <stat+0x36>

000000000000022e <atoi>:

int
atoi(const char *s)
{
 22e:	1141                	add	sp,sp,-16
 230:	e422                	sd	s0,8(sp)
 232:	0800                	add	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 234:	00054683          	lbu	a3,0(a0)
 238:	fd06879b          	addw	a5,a3,-48
 23c:	0ff7f793          	zext.b	a5,a5
 240:	4625                	li	a2,9
 242:	02f66863          	bltu	a2,a5,272 <atoi+0x44>
 246:	872a                	mv	a4,a0
  n = 0;
 248:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 24a:	0705                	add	a4,a4,1
 24c:	0025179b          	sllw	a5,a0,0x2
 250:	9fa9                	addw	a5,a5,a0
 252:	0017979b          	sllw	a5,a5,0x1
 256:	9fb5                	addw	a5,a5,a3
 258:	fd07851b          	addw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 25c:	00074683          	lbu	a3,0(a4)
 260:	fd06879b          	addw	a5,a3,-48
 264:	0ff7f793          	zext.b	a5,a5
 268:	fef671e3          	bgeu	a2,a5,24a <atoi+0x1c>
  return n;
}
 26c:	6422                	ld	s0,8(sp)
 26e:	0141                	add	sp,sp,16
 270:	8082                	ret
  n = 0;
 272:	4501                	li	a0,0
 274:	bfe5                	j	26c <atoi+0x3e>

0000000000000276 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 276:	1141                	add	sp,sp,-16
 278:	e422                	sd	s0,8(sp)
 27a:	0800                	add	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 27c:	02b57463          	bgeu	a0,a1,2a4 <memmove+0x2e>
    while(n-- > 0)
 280:	00c05f63          	blez	a2,29e <memmove+0x28>
 284:	1602                	sll	a2,a2,0x20
 286:	9201                	srl	a2,a2,0x20
 288:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 28c:	872a                	mv	a4,a0
      *dst++ = *src++;
 28e:	0585                	add	a1,a1,1
 290:	0705                	add	a4,a4,1
 292:	fff5c683          	lbu	a3,-1(a1)
 296:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 29a:	fef71ae3          	bne	a4,a5,28e <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 29e:	6422                	ld	s0,8(sp)
 2a0:	0141                	add	sp,sp,16
 2a2:	8082                	ret
    dst += n;
 2a4:	00c50733          	add	a4,a0,a2
    src += n;
 2a8:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 2aa:	fec05ae3          	blez	a2,29e <memmove+0x28>
 2ae:	fff6079b          	addw	a5,a2,-1
 2b2:	1782                	sll	a5,a5,0x20
 2b4:	9381                	srl	a5,a5,0x20
 2b6:	fff7c793          	not	a5,a5
 2ba:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 2bc:	15fd                	add	a1,a1,-1
 2be:	177d                	add	a4,a4,-1
 2c0:	0005c683          	lbu	a3,0(a1)
 2c4:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 2c8:	fee79ae3          	bne	a5,a4,2bc <memmove+0x46>
 2cc:	bfc9                	j	29e <memmove+0x28>

00000000000002ce <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 2ce:	1141                	add	sp,sp,-16
 2d0:	e422                	sd	s0,8(sp)
 2d2:	0800                	add	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 2d4:	ca05                	beqz	a2,304 <memcmp+0x36>
 2d6:	fff6069b          	addw	a3,a2,-1
 2da:	1682                	sll	a3,a3,0x20
 2dc:	9281                	srl	a3,a3,0x20
 2de:	0685                	add	a3,a3,1
 2e0:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 2e2:	00054783          	lbu	a5,0(a0)
 2e6:	0005c703          	lbu	a4,0(a1)
 2ea:	00e79863          	bne	a5,a4,2fa <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 2ee:	0505                	add	a0,a0,1
    p2++;
 2f0:	0585                	add	a1,a1,1
  while (n-- > 0) {
 2f2:	fed518e3          	bne	a0,a3,2e2 <memcmp+0x14>
  }
  return 0;
 2f6:	4501                	li	a0,0
 2f8:	a019                	j	2fe <memcmp+0x30>
      return *p1 - *p2;
 2fa:	40e7853b          	subw	a0,a5,a4
}
 2fe:	6422                	ld	s0,8(sp)
 300:	0141                	add	sp,sp,16
 302:	8082                	ret
  return 0;
 304:	4501                	li	a0,0
 306:	bfe5                	j	2fe <memcmp+0x30>

0000000000000308 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 308:	1141                	add	sp,sp,-16
 30a:	e406                	sd	ra,8(sp)
 30c:	e022                	sd	s0,0(sp)
 30e:	0800                	add	s0,sp,16
  return memmove(dst, src, n);
 310:	00000097          	auipc	ra,0x0
 314:	f66080e7          	jalr	-154(ra) # 276 <memmove>
}
 318:	60a2                	ld	ra,8(sp)
 31a:	6402                	ld	s0,0(sp)
 31c:	0141                	add	sp,sp,16
 31e:	8082                	ret

0000000000000320 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 320:	4885                	li	a7,1
 ecall
 322:	00000073          	ecall
 ret
 326:	8082                	ret

0000000000000328 <exit>:
.global exit
exit:
 li a7, SYS_exit
 328:	4889                	li	a7,2
 ecall
 32a:	00000073          	ecall
 ret
 32e:	8082                	ret

0000000000000330 <wait>:
.global wait
wait:
 li a7, SYS_wait
 330:	488d                	li	a7,3
 ecall
 332:	00000073          	ecall
 ret
 336:	8082                	ret

0000000000000338 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 338:	4891                	li	a7,4
 ecall
 33a:	00000073          	ecall
 ret
 33e:	8082                	ret

0000000000000340 <read>:
.global read
read:
 li a7, SYS_read
 340:	4895                	li	a7,5
 ecall
 342:	00000073          	ecall
 ret
 346:	8082                	ret

0000000000000348 <write>:
.global write
write:
 li a7, SYS_write
 348:	48c1                	li	a7,16
 ecall
 34a:	00000073          	ecall
 ret
 34e:	8082                	ret

0000000000000350 <close>:
.global close
close:
 li a7, SYS_close
 350:	48d5                	li	a7,21
 ecall
 352:	00000073          	ecall
 ret
 356:	8082                	ret

0000000000000358 <kill>:
.global kill
kill:
 li a7, SYS_kill
 358:	4899                	li	a7,6
 ecall
 35a:	00000073          	ecall
 ret
 35e:	8082                	ret

0000000000000360 <exec>:
.global exec
exec:
 li a7, SYS_exec
 360:	489d                	li	a7,7
 ecall
 362:	00000073          	ecall
 ret
 366:	8082                	ret

0000000000000368 <open>:
.global open
open:
 li a7, SYS_open
 368:	48bd                	li	a7,15
 ecall
 36a:	00000073          	ecall
 ret
 36e:	8082                	ret

0000000000000370 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 370:	48c5                	li	a7,17
 ecall
 372:	00000073          	ecall
 ret
 376:	8082                	ret

0000000000000378 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 378:	48c9                	li	a7,18
 ecall
 37a:	00000073          	ecall
 ret
 37e:	8082                	ret

0000000000000380 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 380:	48a1                	li	a7,8
 ecall
 382:	00000073          	ecall
 ret
 386:	8082                	ret

0000000000000388 <link>:
.global link
link:
 li a7, SYS_link
 388:	48cd                	li	a7,19
 ecall
 38a:	00000073          	ecall
 ret
 38e:	8082                	ret

0000000000000390 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 390:	48d1                	li	a7,20
 ecall
 392:	00000073          	ecall
 ret
 396:	8082                	ret

0000000000000398 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 398:	48a5                	li	a7,9
 ecall
 39a:	00000073          	ecall
 ret
 39e:	8082                	ret

00000000000003a0 <dup>:
.global dup
dup:
 li a7, SYS_dup
 3a0:	48a9                	li	a7,10
 ecall
 3a2:	00000073          	ecall
 ret
 3a6:	8082                	ret

00000000000003a8 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 3a8:	48ad                	li	a7,11
 ecall
 3aa:	00000073          	ecall
 ret
 3ae:	8082                	ret

00000000000003b0 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 3b0:	48b1                	li	a7,12
 ecall
 3b2:	00000073          	ecall
 ret
 3b6:	8082                	ret

00000000000003b8 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 3b8:	48b5                	li	a7,13
 ecall
 3ba:	00000073          	ecall
 ret
 3be:	8082                	ret

00000000000003c0 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 3c0:	48b9                	li	a7,14
 ecall
 3c2:	00000073          	ecall
 ret
 3c6:	8082                	ret

00000000000003c8 <uconnect>:
.global uconnect
uconnect:
 li a7, SYS_uconnect
 3c8:	48f5                	li	a7,29
 ecall
 3ca:	00000073          	ecall
 ret
 3ce:	8082                	ret

00000000000003d0 <socket>:
.global socket
socket:
 li a7, SYS_socket
 3d0:	48f9                	li	a7,30
 ecall
 3d2:	00000073          	ecall
 ret
 3d6:	8082                	ret

00000000000003d8 <bind>:
.global bind
bind:
 li a7, SYS_bind
 3d8:	48fd                	li	a7,31
 ecall
 3da:	00000073          	ecall
 ret
 3de:	8082                	ret

00000000000003e0 <listen>:
.global listen
listen:
 li a7, SYS_listen
 3e0:	02000893          	li	a7,32
 ecall
 3e4:	00000073          	ecall
 ret
 3e8:	8082                	ret

00000000000003ea <accept>:
.global accept
accept:
 li a7, SYS_accept
 3ea:	02100893          	li	a7,33
 ecall
 3ee:	00000073          	ecall
 ret
 3f2:	8082                	ret

00000000000003f4 <connect>:
.global connect
connect:
 li a7, SYS_connect
 3f4:	02200893          	li	a7,34
 ecall
 3f8:	00000073          	ecall
 ret
 3fc:	8082                	ret

00000000000003fe <sprintint>:
  return 1;
}

static int
sprintint(char *s, int xx, int base, int sign)
{
 3fe:	1101                	add	sp,sp,-32
 400:	ec22                	sd	s0,24(sp)
 402:	1000                	add	s0,sp,32
 404:	882a                	mv	a6,a0
  char buf[16];
  int i, n;
  uint x;

  if(sign && (sign = xx < 0))
 406:	c299                	beqz	a3,40c <sprintint+0xe>
 408:	0805c263          	bltz	a1,48c <sprintint+0x8e>
    x = -xx;
  else
    x = xx;
 40c:	2581                	sext.w	a1,a1
 40e:	4301                	li	t1,0

  i = 0;
 410:	fe040713          	add	a4,s0,-32
 414:	4501                	li	a0,0
  do {
    buf[i++] = digits[x % base];
 416:	2601                	sext.w	a2,a2
 418:	00000697          	auipc	a3,0x0
 41c:	73868693          	add	a3,a3,1848 # b50 <digits>
 420:	88aa                	mv	a7,a0
 422:	2505                	addw	a0,a0,1
 424:	02c5f7bb          	remuw	a5,a1,a2
 428:	1782                	sll	a5,a5,0x20
 42a:	9381                	srl	a5,a5,0x20
 42c:	97b6                	add	a5,a5,a3
 42e:	0007c783          	lbu	a5,0(a5)
 432:	00f70023          	sb	a5,0(a4)
  } while((x /= base) != 0);
 436:	0005879b          	sext.w	a5,a1
 43a:	02c5d5bb          	divuw	a1,a1,a2
 43e:	0705                	add	a4,a4,1
 440:	fec7f0e3          	bgeu	a5,a2,420 <sprintint+0x22>

  if(sign)
 444:	00030b63          	beqz	t1,45a <sprintint+0x5c>
    buf[i++] = '-';
 448:	ff050793          	add	a5,a0,-16
 44c:	97a2                	add	a5,a5,s0
 44e:	02d00713          	li	a4,45
 452:	fee78823          	sb	a4,-16(a5)
 456:	0028851b          	addw	a0,a7,2

  n = 0;
  while(--i >= 0)
 45a:	02a05d63          	blez	a0,494 <sprintint+0x96>
 45e:	fe040793          	add	a5,s0,-32
 462:	00a78733          	add	a4,a5,a0
 466:	87c2                	mv	a5,a6
 468:	00180613          	add	a2,a6,1
 46c:	fff5069b          	addw	a3,a0,-1
 470:	1682                	sll	a3,a3,0x20
 472:	9281                	srl	a3,a3,0x20
 474:	9636                	add	a2,a2,a3
  *s = c;
 476:	fff74683          	lbu	a3,-1(a4)
 47a:	00d78023          	sb	a3,0(a5)
  while(--i >= 0)
 47e:	177d                	add	a4,a4,-1
 480:	0785                	add	a5,a5,1
 482:	fec79ae3          	bne	a5,a2,476 <sprintint+0x78>
    n += sputc(s+n, buf[i]);
  return n;
}
 486:	6462                	ld	s0,24(sp)
 488:	6105                	add	sp,sp,32
 48a:	8082                	ret
    x = -xx;
 48c:	40b005bb          	negw	a1,a1
  if(sign && (sign = xx < 0))
 490:	4305                	li	t1,1
    x = -xx;
 492:	bfbd                	j	410 <sprintint+0x12>
  while(--i >= 0)
 494:	4501                	li	a0,0
 496:	bfc5                	j	486 <sprintint+0x88>

0000000000000498 <putc>:
{
 498:	1101                	add	sp,sp,-32
 49a:	ec06                	sd	ra,24(sp)
 49c:	e822                	sd	s0,16(sp)
 49e:	1000                	add	s0,sp,32
 4a0:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 4a4:	4605                	li	a2,1
 4a6:	fef40593          	add	a1,s0,-17
 4aa:	00000097          	auipc	ra,0x0
 4ae:	e9e080e7          	jalr	-354(ra) # 348 <write>
}
 4b2:	60e2                	ld	ra,24(sp)
 4b4:	6442                	ld	s0,16(sp)
 4b6:	6105                	add	sp,sp,32
 4b8:	8082                	ret

00000000000004ba <printint>:
{
 4ba:	7139                	add	sp,sp,-64
 4bc:	fc06                	sd	ra,56(sp)
 4be:	f822                	sd	s0,48(sp)
 4c0:	f426                	sd	s1,40(sp)
 4c2:	0080                	add	s0,sp,64
 4c4:	84aa                	mv	s1,a0
  if(sgn && xx < 0){
 4c6:	c299                	beqz	a3,4cc <printint+0x12>
 4c8:	0805cb63          	bltz	a1,55e <printint+0xa4>
    x = xx;
 4cc:	2581                	sext.w	a1,a1
  neg = 0;
 4ce:	4881                	li	a7,0
 4d0:	fc040693          	add	a3,s0,-64
  i = 0;
 4d4:	4701                	li	a4,0
    buf[i++] = digits[x % base];
 4d6:	2601                	sext.w	a2,a2
 4d8:	00000517          	auipc	a0,0x0
 4dc:	67850513          	add	a0,a0,1656 # b50 <digits>
 4e0:	883a                	mv	a6,a4
 4e2:	2705                	addw	a4,a4,1
 4e4:	02c5f7bb          	remuw	a5,a1,a2
 4e8:	1782                	sll	a5,a5,0x20
 4ea:	9381                	srl	a5,a5,0x20
 4ec:	97aa                	add	a5,a5,a0
 4ee:	0007c783          	lbu	a5,0(a5)
 4f2:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 4f6:	0005879b          	sext.w	a5,a1
 4fa:	02c5d5bb          	divuw	a1,a1,a2
 4fe:	0685                	add	a3,a3,1
 500:	fec7f0e3          	bgeu	a5,a2,4e0 <printint+0x26>
  if(neg)
 504:	00088c63          	beqz	a7,51c <printint+0x62>
    buf[i++] = '-';
 508:	fd070793          	add	a5,a4,-48
 50c:	00878733          	add	a4,a5,s0
 510:	02d00793          	li	a5,45
 514:	fef70823          	sb	a5,-16(a4)
 518:	0028071b          	addw	a4,a6,2
  while(--i >= 0)
 51c:	02e05c63          	blez	a4,554 <printint+0x9a>
 520:	f04a                	sd	s2,32(sp)
 522:	ec4e                	sd	s3,24(sp)
 524:	fc040793          	add	a5,s0,-64
 528:	00e78933          	add	s2,a5,a4
 52c:	fff78993          	add	s3,a5,-1
 530:	99ba                	add	s3,s3,a4
 532:	377d                	addw	a4,a4,-1
 534:	1702                	sll	a4,a4,0x20
 536:	9301                	srl	a4,a4,0x20
 538:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 53c:	fff94583          	lbu	a1,-1(s2)
 540:	8526                	mv	a0,s1
 542:	00000097          	auipc	ra,0x0
 546:	f56080e7          	jalr	-170(ra) # 498 <putc>
  while(--i >= 0)
 54a:	197d                	add	s2,s2,-1
 54c:	ff3918e3          	bne	s2,s3,53c <printint+0x82>
 550:	7902                	ld	s2,32(sp)
 552:	69e2                	ld	s3,24(sp)
}
 554:	70e2                	ld	ra,56(sp)
 556:	7442                	ld	s0,48(sp)
 558:	74a2                	ld	s1,40(sp)
 55a:	6121                	add	sp,sp,64
 55c:	8082                	ret
    x = -xx;
 55e:	40b005bb          	negw	a1,a1
    neg = 1;
 562:	4885                	li	a7,1
    x = -xx;
 564:	b7b5                	j	4d0 <printint+0x16>

0000000000000566 <vprintf>:
{
 566:	715d                	add	sp,sp,-80
 568:	e486                	sd	ra,72(sp)
 56a:	e0a2                	sd	s0,64(sp)
 56c:	f84a                	sd	s2,48(sp)
 56e:	0880                	add	s0,sp,80
  for(i = 0; fmt[i]; i++){
 570:	0005c903          	lbu	s2,0(a1)
 574:	1a090a63          	beqz	s2,728 <vprintf+0x1c2>
 578:	fc26                	sd	s1,56(sp)
 57a:	f44e                	sd	s3,40(sp)
 57c:	f052                	sd	s4,32(sp)
 57e:	ec56                	sd	s5,24(sp)
 580:	e85a                	sd	s6,16(sp)
 582:	e45e                	sd	s7,8(sp)
 584:	8aaa                	mv	s5,a0
 586:	8bb2                	mv	s7,a2
 588:	00158493          	add	s1,a1,1
  state = 0;
 58c:	4981                	li	s3,0
    } else if(state == '%'){
 58e:	02500a13          	li	s4,37
 592:	4b55                	li	s6,21
 594:	a839                	j	5b2 <vprintf+0x4c>
        putc(fd, c);
 596:	85ca                	mv	a1,s2
 598:	8556                	mv	a0,s5
 59a:	00000097          	auipc	ra,0x0
 59e:	efe080e7          	jalr	-258(ra) # 498 <putc>
 5a2:	a019                	j	5a8 <vprintf+0x42>
    } else if(state == '%'){
 5a4:	01498d63          	beq	s3,s4,5be <vprintf+0x58>
  for(i = 0; fmt[i]; i++){
 5a8:	0485                	add	s1,s1,1
 5aa:	fff4c903          	lbu	s2,-1(s1)
 5ae:	16090763          	beqz	s2,71c <vprintf+0x1b6>
    if(state == 0){
 5b2:	fe0999e3          	bnez	s3,5a4 <vprintf+0x3e>
      if(c == '%'){
 5b6:	ff4910e3          	bne	s2,s4,596 <vprintf+0x30>
        state = '%';
 5ba:	89d2                	mv	s3,s4
 5bc:	b7f5                	j	5a8 <vprintf+0x42>
      if(c == 'd'){
 5be:	13490463          	beq	s2,s4,6e6 <vprintf+0x180>
 5c2:	f9d9079b          	addw	a5,s2,-99
 5c6:	0ff7f793          	zext.b	a5,a5
 5ca:	12fb6763          	bltu	s6,a5,6f8 <vprintf+0x192>
 5ce:	f9d9079b          	addw	a5,s2,-99
 5d2:	0ff7f713          	zext.b	a4,a5
 5d6:	12eb6163          	bltu	s6,a4,6f8 <vprintf+0x192>
 5da:	00271793          	sll	a5,a4,0x2
 5de:	00000717          	auipc	a4,0x0
 5e2:	51a70713          	add	a4,a4,1306 # af8 <malloc+0x118>
 5e6:	97ba                	add	a5,a5,a4
 5e8:	439c                	lw	a5,0(a5)
 5ea:	97ba                	add	a5,a5,a4
 5ec:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 5ee:	008b8913          	add	s2,s7,8
 5f2:	4685                	li	a3,1
 5f4:	4629                	li	a2,10
 5f6:	000ba583          	lw	a1,0(s7)
 5fa:	8556                	mv	a0,s5
 5fc:	00000097          	auipc	ra,0x0
 600:	ebe080e7          	jalr	-322(ra) # 4ba <printint>
 604:	8bca                	mv	s7,s2
      state = 0;
 606:	4981                	li	s3,0
 608:	b745                	j	5a8 <vprintf+0x42>
        printint(fd, va_arg(ap, uint64), 10, 0);
 60a:	008b8913          	add	s2,s7,8
 60e:	4681                	li	a3,0
 610:	4629                	li	a2,10
 612:	000ba583          	lw	a1,0(s7)
 616:	8556                	mv	a0,s5
 618:	00000097          	auipc	ra,0x0
 61c:	ea2080e7          	jalr	-350(ra) # 4ba <printint>
 620:	8bca                	mv	s7,s2
      state = 0;
 622:	4981                	li	s3,0
 624:	b751                	j	5a8 <vprintf+0x42>
        printint(fd, va_arg(ap, int), 16, 0);
 626:	008b8913          	add	s2,s7,8
 62a:	4681                	li	a3,0
 62c:	4641                	li	a2,16
 62e:	000ba583          	lw	a1,0(s7)
 632:	8556                	mv	a0,s5
 634:	00000097          	auipc	ra,0x0
 638:	e86080e7          	jalr	-378(ra) # 4ba <printint>
 63c:	8bca                	mv	s7,s2
      state = 0;
 63e:	4981                	li	s3,0
 640:	b7a5                	j	5a8 <vprintf+0x42>
 642:	e062                	sd	s8,0(sp)
        printptr(fd, va_arg(ap, uint64));
 644:	008b8c13          	add	s8,s7,8
 648:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 64c:	03000593          	li	a1,48
 650:	8556                	mv	a0,s5
 652:	00000097          	auipc	ra,0x0
 656:	e46080e7          	jalr	-442(ra) # 498 <putc>
  putc(fd, 'x');
 65a:	07800593          	li	a1,120
 65e:	8556                	mv	a0,s5
 660:	00000097          	auipc	ra,0x0
 664:	e38080e7          	jalr	-456(ra) # 498 <putc>
 668:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 66a:	00000b97          	auipc	s7,0x0
 66e:	4e6b8b93          	add	s7,s7,1254 # b50 <digits>
 672:	03c9d793          	srl	a5,s3,0x3c
 676:	97de                	add	a5,a5,s7
 678:	0007c583          	lbu	a1,0(a5)
 67c:	8556                	mv	a0,s5
 67e:	00000097          	auipc	ra,0x0
 682:	e1a080e7          	jalr	-486(ra) # 498 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 686:	0992                	sll	s3,s3,0x4
 688:	397d                	addw	s2,s2,-1
 68a:	fe0914e3          	bnez	s2,672 <vprintf+0x10c>
        printptr(fd, va_arg(ap, uint64));
 68e:	8be2                	mv	s7,s8
      state = 0;
 690:	4981                	li	s3,0
 692:	6c02                	ld	s8,0(sp)
 694:	bf11                	j	5a8 <vprintf+0x42>
        s = va_arg(ap, char*);
 696:	008b8993          	add	s3,s7,8
 69a:	000bb903          	ld	s2,0(s7)
        if(s == 0)
 69e:	02090163          	beqz	s2,6c0 <vprintf+0x15a>
        while(*s != 0){
 6a2:	00094583          	lbu	a1,0(s2)
 6a6:	c9a5                	beqz	a1,716 <vprintf+0x1b0>
          putc(fd, *s);
 6a8:	8556                	mv	a0,s5
 6aa:	00000097          	auipc	ra,0x0
 6ae:	dee080e7          	jalr	-530(ra) # 498 <putc>
          s++;
 6b2:	0905                	add	s2,s2,1
        while(*s != 0){
 6b4:	00094583          	lbu	a1,0(s2)
 6b8:	f9e5                	bnez	a1,6a8 <vprintf+0x142>
        s = va_arg(ap, char*);
 6ba:	8bce                	mv	s7,s3
      state = 0;
 6bc:	4981                	li	s3,0
 6be:	b5ed                	j	5a8 <vprintf+0x42>
          s = "(null)";
 6c0:	00000917          	auipc	s2,0x0
 6c4:	43090913          	add	s2,s2,1072 # af0 <malloc+0x110>
        while(*s != 0){
 6c8:	02800593          	li	a1,40
 6cc:	bff1                	j	6a8 <vprintf+0x142>
        putc(fd, va_arg(ap, uint));
 6ce:	008b8913          	add	s2,s7,8
 6d2:	000bc583          	lbu	a1,0(s7)
 6d6:	8556                	mv	a0,s5
 6d8:	00000097          	auipc	ra,0x0
 6dc:	dc0080e7          	jalr	-576(ra) # 498 <putc>
 6e0:	8bca                	mv	s7,s2
      state = 0;
 6e2:	4981                	li	s3,0
 6e4:	b5d1                	j	5a8 <vprintf+0x42>
        putc(fd, c);
 6e6:	02500593          	li	a1,37
 6ea:	8556                	mv	a0,s5
 6ec:	00000097          	auipc	ra,0x0
 6f0:	dac080e7          	jalr	-596(ra) # 498 <putc>
      state = 0;
 6f4:	4981                	li	s3,0
 6f6:	bd4d                	j	5a8 <vprintf+0x42>
        putc(fd, '%');
 6f8:	02500593          	li	a1,37
 6fc:	8556                	mv	a0,s5
 6fe:	00000097          	auipc	ra,0x0
 702:	d9a080e7          	jalr	-614(ra) # 498 <putc>
        putc(fd, c);
 706:	85ca                	mv	a1,s2
 708:	8556                	mv	a0,s5
 70a:	00000097          	auipc	ra,0x0
 70e:	d8e080e7          	jalr	-626(ra) # 498 <putc>
      state = 0;
 712:	4981                	li	s3,0
 714:	bd51                	j	5a8 <vprintf+0x42>
        s = va_arg(ap, char*);
 716:	8bce                	mv	s7,s3
      state = 0;
 718:	4981                	li	s3,0
 71a:	b579                	j	5a8 <vprintf+0x42>
 71c:	74e2                	ld	s1,56(sp)
 71e:	79a2                	ld	s3,40(sp)
 720:	7a02                	ld	s4,32(sp)
 722:	6ae2                	ld	s5,24(sp)
 724:	6b42                	ld	s6,16(sp)
 726:	6ba2                	ld	s7,8(sp)
}
 728:	60a6                	ld	ra,72(sp)
 72a:	6406                	ld	s0,64(sp)
 72c:	7942                	ld	s2,48(sp)
 72e:	6161                	add	sp,sp,80
 730:	8082                	ret

0000000000000732 <fprintf>:
{
 732:	715d                	add	sp,sp,-80
 734:	ec06                	sd	ra,24(sp)
 736:	e822                	sd	s0,16(sp)
 738:	1000                	add	s0,sp,32
 73a:	e010                	sd	a2,0(s0)
 73c:	e414                	sd	a3,8(s0)
 73e:	e818                	sd	a4,16(s0)
 740:	ec1c                	sd	a5,24(s0)
 742:	03043023          	sd	a6,32(s0)
 746:	03143423          	sd	a7,40(s0)
  va_start(ap, fmt);
 74a:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 74e:	8622                	mv	a2,s0
 750:	00000097          	auipc	ra,0x0
 754:	e16080e7          	jalr	-490(ra) # 566 <vprintf>
}
 758:	60e2                	ld	ra,24(sp)
 75a:	6442                	ld	s0,16(sp)
 75c:	6161                	add	sp,sp,80
 75e:	8082                	ret

0000000000000760 <printf>:
{
 760:	711d                	add	sp,sp,-96
 762:	ec06                	sd	ra,24(sp)
 764:	e822                	sd	s0,16(sp)
 766:	1000                	add	s0,sp,32
 768:	e40c                	sd	a1,8(s0)
 76a:	e810                	sd	a2,16(s0)
 76c:	ec14                	sd	a3,24(s0)
 76e:	f018                	sd	a4,32(s0)
 770:	f41c                	sd	a5,40(s0)
 772:	03043823          	sd	a6,48(s0)
 776:	03143c23          	sd	a7,56(s0)
  va_start(ap, fmt);
 77a:	00840613          	add	a2,s0,8
 77e:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 782:	85aa                	mv	a1,a0
 784:	4505                	li	a0,1
 786:	00000097          	auipc	ra,0x0
 78a:	de0080e7          	jalr	-544(ra) # 566 <vprintf>
}
 78e:	60e2                	ld	ra,24(sp)
 790:	6442                	ld	s0,16(sp)
 792:	6125                	add	sp,sp,96
 794:	8082                	ret

0000000000000796 <snprintf>:

int
snprintf(char *buf, int sz, char *fmt, ...)
{
 796:	7135                	add	sp,sp,-160
 798:	f486                	sd	ra,104(sp)
 79a:	f0a2                	sd	s0,96(sp)
 79c:	eca6                	sd	s1,88(sp)
 79e:	1880                	add	s0,sp,112
 7a0:	e414                	sd	a3,8(s0)
 7a2:	e818                	sd	a4,16(s0)
 7a4:	ec1c                	sd	a5,24(s0)
 7a6:	03043023          	sd	a6,32(s0)
 7aa:	03143423          	sd	a7,40(s0)
  va_list ap;
  int i, c;
  int off = 0;
  char *s;

  if (fmt == 0)
 7ae:	16060b63          	beqz	a2,924 <snprintf+0x18e>
 7b2:	e8ca                	sd	s2,80(sp)
 7b4:	e4ce                	sd	s3,72(sp)
 7b6:	fc56                	sd	s5,56(sp)
 7b8:	f85a                	sd	s6,48(sp)
 7ba:	8b2a                	mv	s6,a0
 7bc:	8aae                	mv	s5,a1
 7be:	89b2                	mv	s3,a2
    return -1;

  va_start(ap, fmt);
 7c0:	00840793          	add	a5,s0,8
 7c4:	f8f43c23          	sd	a5,-104(s0)
  int off = 0;
 7c8:	4481                	li	s1,0
  for(i = 0; off < sz && (c = fmt[i] & 0xff) != 0; i++){
 7ca:	4901                	li	s2,0
 7cc:	00b05f63          	blez	a1,7ea <snprintf+0x54>
 7d0:	e0d2                	sd	s4,64(sp)
 7d2:	f45e                	sd	s7,40(sp)
 7d4:	f062                	sd	s8,32(sp)
 7d6:	ec66                	sd	s9,24(sp)
    if(c != '%'){
 7d8:	02500a13          	li	s4,37
      continue;
    }
    c = fmt[++i] & 0xff;
    if(c == 0)
      break;
    switch(c){
 7dc:	07300b93          	li	s7,115
 7e0:	07800c93          	li	s9,120
 7e4:	06400c13          	li	s8,100
 7e8:	a839                	j	806 <snprintf+0x70>
      off += sputc(buf+off, '%');
      off += sputc(buf+off, c);
      break;
    }
  }
  return off;
 7ea:	4481                	li	s1,0
 7ec:	6946                	ld	s2,80(sp)
 7ee:	69a6                	ld	s3,72(sp)
 7f0:	7ae2                	ld	s5,56(sp)
 7f2:	7b42                	ld	s6,48(sp)
 7f4:	a0cd                	j	8d6 <snprintf+0x140>
  *s = c;
 7f6:	009b0733          	add	a4,s6,s1
 7fa:	00f70023          	sb	a5,0(a4)
      off += sputc(buf+off, c);
 7fe:	2485                	addw	s1,s1,1
  for(i = 0; off < sz && (c = fmt[i] & 0xff) != 0; i++){
 800:	2905                	addw	s2,s2,1
 802:	1554d563          	bge	s1,s5,94c <snprintf+0x1b6>
 806:	012987b3          	add	a5,s3,s2
 80a:	0007c783          	lbu	a5,0(a5)
 80e:	0007871b          	sext.w	a4,a5
 812:	10078063          	beqz	a5,912 <snprintf+0x17c>
    if(c != '%'){
 816:	ff4710e3          	bne	a4,s4,7f6 <snprintf+0x60>
    c = fmt[++i] & 0xff;
 81a:	2905                	addw	s2,s2,1
 81c:	012987b3          	add	a5,s3,s2
 820:	0007c783          	lbu	a5,0(a5)
    if(c == 0)
 824:	10078263          	beqz	a5,928 <snprintf+0x192>
    switch(c){
 828:	05778c63          	beq	a5,s7,880 <snprintf+0xea>
 82c:	02fbe763          	bltu	s7,a5,85a <snprintf+0xc4>
 830:	0d478063          	beq	a5,s4,8f0 <snprintf+0x15a>
 834:	0d879463          	bne	a5,s8,8fc <snprintf+0x166>
      off += sprintint(buf+off, va_arg(ap, int), 10, 1);
 838:	f9843783          	ld	a5,-104(s0)
 83c:	00878713          	add	a4,a5,8
 840:	f8e43c23          	sd	a4,-104(s0)
 844:	4685                	li	a3,1
 846:	4629                	li	a2,10
 848:	438c                	lw	a1,0(a5)
 84a:	009b0533          	add	a0,s6,s1
 84e:	00000097          	auipc	ra,0x0
 852:	bb0080e7          	jalr	-1104(ra) # 3fe <sprintint>
 856:	9ca9                	addw	s1,s1,a0
      break;
 858:	b765                	j	800 <snprintf+0x6a>
    switch(c){
 85a:	0b979163          	bne	a5,s9,8fc <snprintf+0x166>
      off += sprintint(buf+off, va_arg(ap, int), 16, 1);
 85e:	f9843783          	ld	a5,-104(s0)
 862:	00878713          	add	a4,a5,8
 866:	f8e43c23          	sd	a4,-104(s0)
 86a:	4685                	li	a3,1
 86c:	4641                	li	a2,16
 86e:	438c                	lw	a1,0(a5)
 870:	009b0533          	add	a0,s6,s1
 874:	00000097          	auipc	ra,0x0
 878:	b8a080e7          	jalr	-1142(ra) # 3fe <sprintint>
 87c:	9ca9                	addw	s1,s1,a0
      break;
 87e:	b749                	j	800 <snprintf+0x6a>
      if((s = va_arg(ap, char*)) == 0)
 880:	f9843783          	ld	a5,-104(s0)
 884:	00878713          	add	a4,a5,8
 888:	f8e43c23          	sd	a4,-104(s0)
 88c:	6388                	ld	a0,0(a5)
 88e:	c931                	beqz	a0,8e2 <snprintf+0x14c>
      for(; *s && off < sz; s++)
 890:	00054703          	lbu	a4,0(a0)
 894:	d735                	beqz	a4,800 <snprintf+0x6a>
 896:	0b54d263          	bge	s1,s5,93a <snprintf+0x1a4>
 89a:	009b06b3          	add	a3,s6,s1
 89e:	409a863b          	subw	a2,s5,s1
 8a2:	1602                	sll	a2,a2,0x20
 8a4:	9201                	srl	a2,a2,0x20
 8a6:	962a                	add	a2,a2,a0
 8a8:	87aa                	mv	a5,a0
        off += sputc(buf+off, *s);
 8aa:	0014859b          	addw	a1,s1,1
 8ae:	9d89                	subw	a1,a1,a0
  *s = c;
 8b0:	00e68023          	sb	a4,0(a3)
        off += sputc(buf+off, *s);
 8b4:	00f584bb          	addw	s1,a1,a5
      for(; *s && off < sz; s++)
 8b8:	0785                	add	a5,a5,1
 8ba:	0007c703          	lbu	a4,0(a5)
 8be:	d329                	beqz	a4,800 <snprintf+0x6a>
 8c0:	0685                	add	a3,a3,1
 8c2:	fec797e3          	bne	a5,a2,8b0 <snprintf+0x11a>
 8c6:	6946                	ld	s2,80(sp)
 8c8:	69a6                	ld	s3,72(sp)
 8ca:	6a06                	ld	s4,64(sp)
 8cc:	7ae2                	ld	s5,56(sp)
 8ce:	7b42                	ld	s6,48(sp)
 8d0:	7ba2                	ld	s7,40(sp)
 8d2:	7c02                	ld	s8,32(sp)
 8d4:	6ce2                	ld	s9,24(sp)
 8d6:	8526                	mv	a0,s1
 8d8:	70a6                	ld	ra,104(sp)
 8da:	7406                	ld	s0,96(sp)
 8dc:	64e6                	ld	s1,88(sp)
 8de:	610d                	add	sp,sp,160
 8e0:	8082                	ret
      for(; *s && off < sz; s++)
 8e2:	02800713          	li	a4,40
        s = "(null)";
 8e6:	00000517          	auipc	a0,0x0
 8ea:	20a50513          	add	a0,a0,522 # af0 <malloc+0x110>
 8ee:	b765                	j	896 <snprintf+0x100>
  *s = c;
 8f0:	009b07b3          	add	a5,s6,s1
 8f4:	01478023          	sb	s4,0(a5)
      off += sputc(buf+off, '%');
 8f8:	2485                	addw	s1,s1,1
      break;
 8fa:	b719                	j	800 <snprintf+0x6a>
  *s = c;
 8fc:	009b0733          	add	a4,s6,s1
 900:	01470023          	sb	s4,0(a4)
      off += sputc(buf+off, c);
 904:	0014871b          	addw	a4,s1,1
  *s = c;
 908:	975a                	add	a4,a4,s6
 90a:	00f70023          	sb	a5,0(a4)
      off += sputc(buf+off, c);
 90e:	2489                	addw	s1,s1,2
      break;
 910:	bdc5                	j	800 <snprintf+0x6a>
 912:	6946                	ld	s2,80(sp)
 914:	69a6                	ld	s3,72(sp)
 916:	6a06                	ld	s4,64(sp)
 918:	7ae2                	ld	s5,56(sp)
 91a:	7b42                	ld	s6,48(sp)
 91c:	7ba2                	ld	s7,40(sp)
 91e:	7c02                	ld	s8,32(sp)
 920:	6ce2                	ld	s9,24(sp)
 922:	bf55                	j	8d6 <snprintf+0x140>
    return -1;
 924:	54fd                	li	s1,-1
 926:	bf45                	j	8d6 <snprintf+0x140>
 928:	6946                	ld	s2,80(sp)
 92a:	69a6                	ld	s3,72(sp)
 92c:	6a06                	ld	s4,64(sp)
 92e:	7ae2                	ld	s5,56(sp)
 930:	7b42                	ld	s6,48(sp)
 932:	7ba2                	ld	s7,40(sp)
 934:	7c02                	ld	s8,32(sp)
 936:	6ce2                	ld	s9,24(sp)
 938:	bf79                	j	8d6 <snprintf+0x140>
 93a:	6946                	ld	s2,80(sp)
 93c:	69a6                	ld	s3,72(sp)
 93e:	6a06                	ld	s4,64(sp)
 940:	7ae2                	ld	s5,56(sp)
 942:	7b42                	ld	s6,48(sp)
 944:	7ba2                	ld	s7,40(sp)
 946:	7c02                	ld	s8,32(sp)
 948:	6ce2                	ld	s9,24(sp)
 94a:	b771                	j	8d6 <snprintf+0x140>
 94c:	6946                	ld	s2,80(sp)
 94e:	69a6                	ld	s3,72(sp)
 950:	6a06                	ld	s4,64(sp)
 952:	7ae2                	ld	s5,56(sp)
 954:	7b42                	ld	s6,48(sp)
 956:	7ba2                	ld	s7,40(sp)
 958:	7c02                	ld	s8,32(sp)
 95a:	6ce2                	ld	s9,24(sp)
 95c:	bfad                	j	8d6 <snprintf+0x140>

000000000000095e <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 95e:	1141                	add	sp,sp,-16
 960:	e422                	sd	s0,8(sp)
 962:	0800                	add	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 964:	ff050693          	add	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 968:	00000797          	auipc	a5,0x0
 96c:	2007b783          	ld	a5,512(a5) # b68 <freep>
 970:	a02d                	j	99a <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 972:	4618                	lw	a4,8(a2)
 974:	9f2d                	addw	a4,a4,a1
 976:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 97a:	6398                	ld	a4,0(a5)
 97c:	6310                	ld	a2,0(a4)
 97e:	a83d                	j	9bc <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 980:	ff852703          	lw	a4,-8(a0)
 984:	9f31                	addw	a4,a4,a2
 986:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 988:	ff053683          	ld	a3,-16(a0)
 98c:	a091                	j	9d0 <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 98e:	6398                	ld	a4,0(a5)
 990:	00e7e463          	bltu	a5,a4,998 <free+0x3a>
 994:	00e6ea63          	bltu	a3,a4,9a8 <free+0x4a>
{
 998:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 99a:	fed7fae3          	bgeu	a5,a3,98e <free+0x30>
 99e:	6398                	ld	a4,0(a5)
 9a0:	00e6e463          	bltu	a3,a4,9a8 <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 9a4:	fee7eae3          	bltu	a5,a4,998 <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 9a8:	ff852583          	lw	a1,-8(a0)
 9ac:	6390                	ld	a2,0(a5)
 9ae:	02059813          	sll	a6,a1,0x20
 9b2:	01c85713          	srl	a4,a6,0x1c
 9b6:	9736                	add	a4,a4,a3
 9b8:	fae60de3          	beq	a2,a4,972 <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 9bc:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 9c0:	4790                	lw	a2,8(a5)
 9c2:	02061593          	sll	a1,a2,0x20
 9c6:	01c5d713          	srl	a4,a1,0x1c
 9ca:	973e                	add	a4,a4,a5
 9cc:	fae68ae3          	beq	a3,a4,980 <free+0x22>
    p->s.ptr = bp->s.ptr;
 9d0:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 9d2:	00000717          	auipc	a4,0x0
 9d6:	18f73b23          	sd	a5,406(a4) # b68 <freep>
}
 9da:	6422                	ld	s0,8(sp)
 9dc:	0141                	add	sp,sp,16
 9de:	8082                	ret

00000000000009e0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 9e0:	7139                	add	sp,sp,-64
 9e2:	fc06                	sd	ra,56(sp)
 9e4:	f822                	sd	s0,48(sp)
 9e6:	f426                	sd	s1,40(sp)
 9e8:	ec4e                	sd	s3,24(sp)
 9ea:	0080                	add	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 9ec:	02051493          	sll	s1,a0,0x20
 9f0:	9081                	srl	s1,s1,0x20
 9f2:	04bd                	add	s1,s1,15
 9f4:	8091                	srl	s1,s1,0x4
 9f6:	0014899b          	addw	s3,s1,1
 9fa:	0485                	add	s1,s1,1
  if((prevp = freep) == 0){
 9fc:	00000517          	auipc	a0,0x0
 a00:	16c53503          	ld	a0,364(a0) # b68 <freep>
 a04:	c915                	beqz	a0,a38 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a06:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 a08:	4798                	lw	a4,8(a5)
 a0a:	08977e63          	bgeu	a4,s1,aa6 <malloc+0xc6>
 a0e:	f04a                	sd	s2,32(sp)
 a10:	e852                	sd	s4,16(sp)
 a12:	e456                	sd	s5,8(sp)
 a14:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 a16:	8a4e                	mv	s4,s3
 a18:	0009871b          	sext.w	a4,s3
 a1c:	6685                	lui	a3,0x1
 a1e:	00d77363          	bgeu	a4,a3,a24 <malloc+0x44>
 a22:	6a05                	lui	s4,0x1
 a24:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 a28:	004a1a1b          	sllw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 a2c:	00000917          	auipc	s2,0x0
 a30:	13c90913          	add	s2,s2,316 # b68 <freep>
  if(p == (char*)-1)
 a34:	5afd                	li	s5,-1
 a36:	a091                	j	a7a <malloc+0x9a>
 a38:	f04a                	sd	s2,32(sp)
 a3a:	e852                	sd	s4,16(sp)
 a3c:	e456                	sd	s5,8(sp)
 a3e:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 a40:	00000797          	auipc	a5,0x0
 a44:	13078793          	add	a5,a5,304 # b70 <base>
 a48:	00000717          	auipc	a4,0x0
 a4c:	12f73023          	sd	a5,288(a4) # b68 <freep>
 a50:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 a52:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 a56:	b7c1                	j	a16 <malloc+0x36>
        prevp->s.ptr = p->s.ptr;
 a58:	6398                	ld	a4,0(a5)
 a5a:	e118                	sd	a4,0(a0)
 a5c:	a08d                	j	abe <malloc+0xde>
  hp->s.size = nu;
 a5e:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 a62:	0541                	add	a0,a0,16
 a64:	00000097          	auipc	ra,0x0
 a68:	efa080e7          	jalr	-262(ra) # 95e <free>
  return freep;
 a6c:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 a70:	c13d                	beqz	a0,ad6 <malloc+0xf6>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a72:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 a74:	4798                	lw	a4,8(a5)
 a76:	02977463          	bgeu	a4,s1,a9e <malloc+0xbe>
    if(p == freep)
 a7a:	00093703          	ld	a4,0(s2)
 a7e:	853e                	mv	a0,a5
 a80:	fef719e3          	bne	a4,a5,a72 <malloc+0x92>
  p = sbrk(nu * sizeof(Header));
 a84:	8552                	mv	a0,s4
 a86:	00000097          	auipc	ra,0x0
 a8a:	92a080e7          	jalr	-1750(ra) # 3b0 <sbrk>
  if(p == (char*)-1)
 a8e:	fd5518e3          	bne	a0,s5,a5e <malloc+0x7e>
        return 0;
 a92:	4501                	li	a0,0
 a94:	7902                	ld	s2,32(sp)
 a96:	6a42                	ld	s4,16(sp)
 a98:	6aa2                	ld	s5,8(sp)
 a9a:	6b02                	ld	s6,0(sp)
 a9c:	a03d                	j	aca <malloc+0xea>
 a9e:	7902                	ld	s2,32(sp)
 aa0:	6a42                	ld	s4,16(sp)
 aa2:	6aa2                	ld	s5,8(sp)
 aa4:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 aa6:	fae489e3          	beq	s1,a4,a58 <malloc+0x78>
        p->s.size -= nunits;
 aaa:	4137073b          	subw	a4,a4,s3
 aae:	c798                	sw	a4,8(a5)
        p += p->s.size;
 ab0:	02071693          	sll	a3,a4,0x20
 ab4:	01c6d713          	srl	a4,a3,0x1c
 ab8:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 aba:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 abe:	00000717          	auipc	a4,0x0
 ac2:	0aa73523          	sd	a0,170(a4) # b68 <freep>
      return (void*)(p + 1);
 ac6:	01078513          	add	a0,a5,16
  }
}
 aca:	70e2                	ld	ra,56(sp)
 acc:	7442                	ld	s0,48(sp)
 ace:	74a2                	ld	s1,40(sp)
 ad0:	69e2                	ld	s3,24(sp)
 ad2:	6121                	add	sp,sp,64
 ad4:	8082                	ret
 ad6:	7902                	ld	s2,32(sp)
 ad8:	6a42                	ld	s4,16(sp)
 ada:	6aa2                	ld	s5,8(sp)
 adc:	6b02                	ld	s6,0(sp)
 ade:	b7f5                	j	aca <malloc+0xea>
