
user/_ln:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/stat.h"
#include "user/user.h"

int
main(int argc, char *argv[])
{
   0:	1101                	add	sp,sp,-32
   2:	ec06                	sd	ra,24(sp)
   4:	e822                	sd	s0,16(sp)
   6:	1000                	add	s0,sp,32
  if(argc != 3){
   8:	478d                	li	a5,3
   a:	02f50163          	beq	a0,a5,2c <main+0x2c>
   e:	e426                	sd	s1,8(sp)
    fprintf(2, "Usage: ln old new\n");
  10:	00001597          	auipc	a1,0x1
  14:	aa858593          	add	a1,a1,-1368 # ab8 <malloc+0x104>
  18:	4509                	li	a0,2
  1a:	00000097          	auipc	ra,0x0
  1e:	6ec080e7          	jalr	1772(ra) # 706 <fprintf>
    exit(1);
  22:	4505                	li	a0,1
  24:	00000097          	auipc	ra,0x0
  28:	2d8080e7          	jalr	728(ra) # 2fc <exit>
  2c:	e426                	sd	s1,8(sp)
  2e:	84ae                	mv	s1,a1
  }
  if(link(argv[1], argv[2]) < 0)
  30:	698c                	ld	a1,16(a1)
  32:	6488                	ld	a0,8(s1)
  34:	00000097          	auipc	ra,0x0
  38:	328080e7          	jalr	808(ra) # 35c <link>
  3c:	00054763          	bltz	a0,4a <main+0x4a>
    fprintf(2, "link %s %s: failed\n", argv[1], argv[2]);
  exit(0);
  40:	4501                	li	a0,0
  42:	00000097          	auipc	ra,0x0
  46:	2ba080e7          	jalr	698(ra) # 2fc <exit>
    fprintf(2, "link %s %s: failed\n", argv[1], argv[2]);
  4a:	6894                	ld	a3,16(s1)
  4c:	6490                	ld	a2,8(s1)
  4e:	00001597          	auipc	a1,0x1
  52:	a8258593          	add	a1,a1,-1406 # ad0 <malloc+0x11c>
  56:	4509                	li	a0,2
  58:	00000097          	auipc	ra,0x0
  5c:	6ae080e7          	jalr	1710(ra) # 706 <fprintf>
  60:	b7c5                	j	40 <main+0x40>

0000000000000062 <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
  62:	1141                	add	sp,sp,-16
  64:	e422                	sd	s0,8(sp)
  66:	0800                	add	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  68:	87aa                	mv	a5,a0
  6a:	0585                	add	a1,a1,1
  6c:	0785                	add	a5,a5,1
  6e:	fff5c703          	lbu	a4,-1(a1)
  72:	fee78fa3          	sb	a4,-1(a5)
  76:	fb75                	bnez	a4,6a <strcpy+0x8>
    ;
  return os;
}
  78:	6422                	ld	s0,8(sp)
  7a:	0141                	add	sp,sp,16
  7c:	8082                	ret

000000000000007e <strcmp>:

int
strcmp(const char *p, const char *q)
{
  7e:	1141                	add	sp,sp,-16
  80:	e422                	sd	s0,8(sp)
  82:	0800                	add	s0,sp,16
  while(*p && *p == *q)
  84:	00054783          	lbu	a5,0(a0)
  88:	cb91                	beqz	a5,9c <strcmp+0x1e>
  8a:	0005c703          	lbu	a4,0(a1)
  8e:	00f71763          	bne	a4,a5,9c <strcmp+0x1e>
    p++, q++;
  92:	0505                	add	a0,a0,1
  94:	0585                	add	a1,a1,1
  while(*p && *p == *q)
  96:	00054783          	lbu	a5,0(a0)
  9a:	fbe5                	bnez	a5,8a <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
  9c:	0005c503          	lbu	a0,0(a1)
}
  a0:	40a7853b          	subw	a0,a5,a0
  a4:	6422                	ld	s0,8(sp)
  a6:	0141                	add	sp,sp,16
  a8:	8082                	ret

00000000000000aa <strlen>:

uint
strlen(const char *s)
{
  aa:	1141                	add	sp,sp,-16
  ac:	e422                	sd	s0,8(sp)
  ae:	0800                	add	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
  b0:	00054783          	lbu	a5,0(a0)
  b4:	cf91                	beqz	a5,d0 <strlen+0x26>
  b6:	0505                	add	a0,a0,1
  b8:	87aa                	mv	a5,a0
  ba:	86be                	mv	a3,a5
  bc:	0785                	add	a5,a5,1
  be:	fff7c703          	lbu	a4,-1(a5)
  c2:	ff65                	bnez	a4,ba <strlen+0x10>
  c4:	40a6853b          	subw	a0,a3,a0
  c8:	2505                	addw	a0,a0,1
    ;
  return n;
}
  ca:	6422                	ld	s0,8(sp)
  cc:	0141                	add	sp,sp,16
  ce:	8082                	ret
  for(n = 0; s[n]; n++)
  d0:	4501                	li	a0,0
  d2:	bfe5                	j	ca <strlen+0x20>

00000000000000d4 <strcat>:

char *
strcat(char *dst, char *src)
{
  d4:	1141                	add	sp,sp,-16
  d6:	e422                	sd	s0,8(sp)
  d8:	0800                	add	s0,sp,16
  char *s = dst;
  while (*dst)
  da:	00054783          	lbu	a5,0(a0)
  de:	c385                	beqz	a5,fe <strcat+0x2a>
  e0:	87aa                	mv	a5,a0
    dst++;
  e2:	0785                	add	a5,a5,1
  while (*dst)
  e4:	0007c703          	lbu	a4,0(a5)
  e8:	ff6d                	bnez	a4,e2 <strcat+0xe>
  while ((*dst++ = *src++) != 0);
  ea:	0585                	add	a1,a1,1
  ec:	0785                	add	a5,a5,1
  ee:	fff5c703          	lbu	a4,-1(a1)
  f2:	fee78fa3          	sb	a4,-1(a5)
  f6:	fb75                	bnez	a4,ea <strcat+0x16>

  return s;
}
  f8:	6422                	ld	s0,8(sp)
  fa:	0141                	add	sp,sp,16
  fc:	8082                	ret
  while (*dst)
  fe:	87aa                	mv	a5,a0
 100:	b7ed                	j	ea <strcat+0x16>

0000000000000102 <memset>:

void*
memset(void *dst, int c, uint n)
{
 102:	1141                	add	sp,sp,-16
 104:	e422                	sd	s0,8(sp)
 106:	0800                	add	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 108:	ca19                	beqz	a2,11e <memset+0x1c>
 10a:	87aa                	mv	a5,a0
 10c:	1602                	sll	a2,a2,0x20
 10e:	9201                	srl	a2,a2,0x20
 110:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 114:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 118:	0785                	add	a5,a5,1
 11a:	fee79de3          	bne	a5,a4,114 <memset+0x12>
  }
  return dst;
}
 11e:	6422                	ld	s0,8(sp)
 120:	0141                	add	sp,sp,16
 122:	8082                	ret

0000000000000124 <strchr>:

char*
strchr(const char *s, char c)
{
 124:	1141                	add	sp,sp,-16
 126:	e422                	sd	s0,8(sp)
 128:	0800                	add	s0,sp,16
  for(; *s; s++)
 12a:	00054783          	lbu	a5,0(a0)
 12e:	cb99                	beqz	a5,144 <strchr+0x20>
    if(*s == c)
 130:	00f58763          	beq	a1,a5,13e <strchr+0x1a>
  for(; *s; s++)
 134:	0505                	add	a0,a0,1
 136:	00054783          	lbu	a5,0(a0)
 13a:	fbfd                	bnez	a5,130 <strchr+0xc>
      return (char*)s;
  return 0;
 13c:	4501                	li	a0,0
}
 13e:	6422                	ld	s0,8(sp)
 140:	0141                	add	sp,sp,16
 142:	8082                	ret
  return 0;
 144:	4501                	li	a0,0
 146:	bfe5                	j	13e <strchr+0x1a>

0000000000000148 <gets>:

char*
gets(char *buf, int max)
{
 148:	711d                	add	sp,sp,-96
 14a:	ec86                	sd	ra,88(sp)
 14c:	e8a2                	sd	s0,80(sp)
 14e:	e4a6                	sd	s1,72(sp)
 150:	e0ca                	sd	s2,64(sp)
 152:	fc4e                	sd	s3,56(sp)
 154:	f852                	sd	s4,48(sp)
 156:	f456                	sd	s5,40(sp)
 158:	f05a                	sd	s6,32(sp)
 15a:	ec5e                	sd	s7,24(sp)
 15c:	1080                	add	s0,sp,96
 15e:	8baa                	mv	s7,a0
 160:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 162:	892a                	mv	s2,a0
 164:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 166:	4aa9                	li	s5,10
 168:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 16a:	89a6                	mv	s3,s1
 16c:	2485                	addw	s1,s1,1
 16e:	0344d863          	bge	s1,s4,19e <gets+0x56>
    cc = read(0, &c, 1);
 172:	4605                	li	a2,1
 174:	faf40593          	add	a1,s0,-81
 178:	4501                	li	a0,0
 17a:	00000097          	auipc	ra,0x0
 17e:	19a080e7          	jalr	410(ra) # 314 <read>
    if(cc < 1)
 182:	00a05e63          	blez	a0,19e <gets+0x56>
    buf[i++] = c;
 186:	faf44783          	lbu	a5,-81(s0)
 18a:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 18e:	01578763          	beq	a5,s5,19c <gets+0x54>
 192:	0905                	add	s2,s2,1
 194:	fd679be3          	bne	a5,s6,16a <gets+0x22>
    buf[i++] = c;
 198:	89a6                	mv	s3,s1
 19a:	a011                	j	19e <gets+0x56>
 19c:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 19e:	99de                	add	s3,s3,s7
 1a0:	00098023          	sb	zero,0(s3)
  return buf;
}
 1a4:	855e                	mv	a0,s7
 1a6:	60e6                	ld	ra,88(sp)
 1a8:	6446                	ld	s0,80(sp)
 1aa:	64a6                	ld	s1,72(sp)
 1ac:	6906                	ld	s2,64(sp)
 1ae:	79e2                	ld	s3,56(sp)
 1b0:	7a42                	ld	s4,48(sp)
 1b2:	7aa2                	ld	s5,40(sp)
 1b4:	7b02                	ld	s6,32(sp)
 1b6:	6be2                	ld	s7,24(sp)
 1b8:	6125                	add	sp,sp,96
 1ba:	8082                	ret

00000000000001bc <stat>:

int
stat(const char *n, struct stat *st)
{
 1bc:	1101                	add	sp,sp,-32
 1be:	ec06                	sd	ra,24(sp)
 1c0:	e822                	sd	s0,16(sp)
 1c2:	e04a                	sd	s2,0(sp)
 1c4:	1000                	add	s0,sp,32
 1c6:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1c8:	4581                	li	a1,0
 1ca:	00000097          	auipc	ra,0x0
 1ce:	172080e7          	jalr	370(ra) # 33c <open>
  if(fd < 0)
 1d2:	02054663          	bltz	a0,1fe <stat+0x42>
 1d6:	e426                	sd	s1,8(sp)
 1d8:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 1da:	85ca                	mv	a1,s2
 1dc:	00000097          	auipc	ra,0x0
 1e0:	178080e7          	jalr	376(ra) # 354 <fstat>
 1e4:	892a                	mv	s2,a0
  close(fd);
 1e6:	8526                	mv	a0,s1
 1e8:	00000097          	auipc	ra,0x0
 1ec:	13c080e7          	jalr	316(ra) # 324 <close>
  return r;
 1f0:	64a2                	ld	s1,8(sp)
}
 1f2:	854a                	mv	a0,s2
 1f4:	60e2                	ld	ra,24(sp)
 1f6:	6442                	ld	s0,16(sp)
 1f8:	6902                	ld	s2,0(sp)
 1fa:	6105                	add	sp,sp,32
 1fc:	8082                	ret
    return -1;
 1fe:	597d                	li	s2,-1
 200:	bfcd                	j	1f2 <stat+0x36>

0000000000000202 <atoi>:

int
atoi(const char *s)
{
 202:	1141                	add	sp,sp,-16
 204:	e422                	sd	s0,8(sp)
 206:	0800                	add	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 208:	00054683          	lbu	a3,0(a0)
 20c:	fd06879b          	addw	a5,a3,-48
 210:	0ff7f793          	zext.b	a5,a5
 214:	4625                	li	a2,9
 216:	02f66863          	bltu	a2,a5,246 <atoi+0x44>
 21a:	872a                	mv	a4,a0
  n = 0;
 21c:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 21e:	0705                	add	a4,a4,1
 220:	0025179b          	sllw	a5,a0,0x2
 224:	9fa9                	addw	a5,a5,a0
 226:	0017979b          	sllw	a5,a5,0x1
 22a:	9fb5                	addw	a5,a5,a3
 22c:	fd07851b          	addw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 230:	00074683          	lbu	a3,0(a4)
 234:	fd06879b          	addw	a5,a3,-48
 238:	0ff7f793          	zext.b	a5,a5
 23c:	fef671e3          	bgeu	a2,a5,21e <atoi+0x1c>
  return n;
}
 240:	6422                	ld	s0,8(sp)
 242:	0141                	add	sp,sp,16
 244:	8082                	ret
  n = 0;
 246:	4501                	li	a0,0
 248:	bfe5                	j	240 <atoi+0x3e>

000000000000024a <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 24a:	1141                	add	sp,sp,-16
 24c:	e422                	sd	s0,8(sp)
 24e:	0800                	add	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 250:	02b57463          	bgeu	a0,a1,278 <memmove+0x2e>
    while(n-- > 0)
 254:	00c05f63          	blez	a2,272 <memmove+0x28>
 258:	1602                	sll	a2,a2,0x20
 25a:	9201                	srl	a2,a2,0x20
 25c:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 260:	872a                	mv	a4,a0
      *dst++ = *src++;
 262:	0585                	add	a1,a1,1
 264:	0705                	add	a4,a4,1
 266:	fff5c683          	lbu	a3,-1(a1)
 26a:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 26e:	fef71ae3          	bne	a4,a5,262 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 272:	6422                	ld	s0,8(sp)
 274:	0141                	add	sp,sp,16
 276:	8082                	ret
    dst += n;
 278:	00c50733          	add	a4,a0,a2
    src += n;
 27c:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 27e:	fec05ae3          	blez	a2,272 <memmove+0x28>
 282:	fff6079b          	addw	a5,a2,-1
 286:	1782                	sll	a5,a5,0x20
 288:	9381                	srl	a5,a5,0x20
 28a:	fff7c793          	not	a5,a5
 28e:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 290:	15fd                	add	a1,a1,-1
 292:	177d                	add	a4,a4,-1
 294:	0005c683          	lbu	a3,0(a1)
 298:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 29c:	fee79ae3          	bne	a5,a4,290 <memmove+0x46>
 2a0:	bfc9                	j	272 <memmove+0x28>

00000000000002a2 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 2a2:	1141                	add	sp,sp,-16
 2a4:	e422                	sd	s0,8(sp)
 2a6:	0800                	add	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 2a8:	ca05                	beqz	a2,2d8 <memcmp+0x36>
 2aa:	fff6069b          	addw	a3,a2,-1
 2ae:	1682                	sll	a3,a3,0x20
 2b0:	9281                	srl	a3,a3,0x20
 2b2:	0685                	add	a3,a3,1
 2b4:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 2b6:	00054783          	lbu	a5,0(a0)
 2ba:	0005c703          	lbu	a4,0(a1)
 2be:	00e79863          	bne	a5,a4,2ce <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 2c2:	0505                	add	a0,a0,1
    p2++;
 2c4:	0585                	add	a1,a1,1
  while (n-- > 0) {
 2c6:	fed518e3          	bne	a0,a3,2b6 <memcmp+0x14>
  }
  return 0;
 2ca:	4501                	li	a0,0
 2cc:	a019                	j	2d2 <memcmp+0x30>
      return *p1 - *p2;
 2ce:	40e7853b          	subw	a0,a5,a4
}
 2d2:	6422                	ld	s0,8(sp)
 2d4:	0141                	add	sp,sp,16
 2d6:	8082                	ret
  return 0;
 2d8:	4501                	li	a0,0
 2da:	bfe5                	j	2d2 <memcmp+0x30>

00000000000002dc <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 2dc:	1141                	add	sp,sp,-16
 2de:	e406                	sd	ra,8(sp)
 2e0:	e022                	sd	s0,0(sp)
 2e2:	0800                	add	s0,sp,16
  return memmove(dst, src, n);
 2e4:	00000097          	auipc	ra,0x0
 2e8:	f66080e7          	jalr	-154(ra) # 24a <memmove>
}
 2ec:	60a2                	ld	ra,8(sp)
 2ee:	6402                	ld	s0,0(sp)
 2f0:	0141                	add	sp,sp,16
 2f2:	8082                	ret

00000000000002f4 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 2f4:	4885                	li	a7,1
 ecall
 2f6:	00000073          	ecall
 ret
 2fa:	8082                	ret

00000000000002fc <exit>:
.global exit
exit:
 li a7, SYS_exit
 2fc:	4889                	li	a7,2
 ecall
 2fe:	00000073          	ecall
 ret
 302:	8082                	ret

0000000000000304 <wait>:
.global wait
wait:
 li a7, SYS_wait
 304:	488d                	li	a7,3
 ecall
 306:	00000073          	ecall
 ret
 30a:	8082                	ret

000000000000030c <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 30c:	4891                	li	a7,4
 ecall
 30e:	00000073          	ecall
 ret
 312:	8082                	ret

0000000000000314 <read>:
.global read
read:
 li a7, SYS_read
 314:	4895                	li	a7,5
 ecall
 316:	00000073          	ecall
 ret
 31a:	8082                	ret

000000000000031c <write>:
.global write
write:
 li a7, SYS_write
 31c:	48c1                	li	a7,16
 ecall
 31e:	00000073          	ecall
 ret
 322:	8082                	ret

0000000000000324 <close>:
.global close
close:
 li a7, SYS_close
 324:	48d5                	li	a7,21
 ecall
 326:	00000073          	ecall
 ret
 32a:	8082                	ret

000000000000032c <kill>:
.global kill
kill:
 li a7, SYS_kill
 32c:	4899                	li	a7,6
 ecall
 32e:	00000073          	ecall
 ret
 332:	8082                	ret

0000000000000334 <exec>:
.global exec
exec:
 li a7, SYS_exec
 334:	489d                	li	a7,7
 ecall
 336:	00000073          	ecall
 ret
 33a:	8082                	ret

000000000000033c <open>:
.global open
open:
 li a7, SYS_open
 33c:	48bd                	li	a7,15
 ecall
 33e:	00000073          	ecall
 ret
 342:	8082                	ret

0000000000000344 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 344:	48c5                	li	a7,17
 ecall
 346:	00000073          	ecall
 ret
 34a:	8082                	ret

000000000000034c <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 34c:	48c9                	li	a7,18
 ecall
 34e:	00000073          	ecall
 ret
 352:	8082                	ret

0000000000000354 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 354:	48a1                	li	a7,8
 ecall
 356:	00000073          	ecall
 ret
 35a:	8082                	ret

000000000000035c <link>:
.global link
link:
 li a7, SYS_link
 35c:	48cd                	li	a7,19
 ecall
 35e:	00000073          	ecall
 ret
 362:	8082                	ret

0000000000000364 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 364:	48d1                	li	a7,20
 ecall
 366:	00000073          	ecall
 ret
 36a:	8082                	ret

000000000000036c <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 36c:	48a5                	li	a7,9
 ecall
 36e:	00000073          	ecall
 ret
 372:	8082                	ret

0000000000000374 <dup>:
.global dup
dup:
 li a7, SYS_dup
 374:	48a9                	li	a7,10
 ecall
 376:	00000073          	ecall
 ret
 37a:	8082                	ret

000000000000037c <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 37c:	48ad                	li	a7,11
 ecall
 37e:	00000073          	ecall
 ret
 382:	8082                	ret

0000000000000384 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 384:	48b1                	li	a7,12
 ecall
 386:	00000073          	ecall
 ret
 38a:	8082                	ret

000000000000038c <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 38c:	48b5                	li	a7,13
 ecall
 38e:	00000073          	ecall
 ret
 392:	8082                	ret

0000000000000394 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 394:	48b9                	li	a7,14
 ecall
 396:	00000073          	ecall
 ret
 39a:	8082                	ret

000000000000039c <uconnect>:
.global uconnect
uconnect:
 li a7, SYS_uconnect
 39c:	48f5                	li	a7,29
 ecall
 39e:	00000073          	ecall
 ret
 3a2:	8082                	ret

00000000000003a4 <socket>:
.global socket
socket:
 li a7, SYS_socket
 3a4:	48f9                	li	a7,30
 ecall
 3a6:	00000073          	ecall
 ret
 3aa:	8082                	ret

00000000000003ac <bind>:
.global bind
bind:
 li a7, SYS_bind
 3ac:	48fd                	li	a7,31
 ecall
 3ae:	00000073          	ecall
 ret
 3b2:	8082                	ret

00000000000003b4 <listen>:
.global listen
listen:
 li a7, SYS_listen
 3b4:	02000893          	li	a7,32
 ecall
 3b8:	00000073          	ecall
 ret
 3bc:	8082                	ret

00000000000003be <accept>:
.global accept
accept:
 li a7, SYS_accept
 3be:	02100893          	li	a7,33
 ecall
 3c2:	00000073          	ecall
 ret
 3c6:	8082                	ret

00000000000003c8 <connect>:
.global connect
connect:
 li a7, SYS_connect
 3c8:	02200893          	li	a7,34
 ecall
 3cc:	00000073          	ecall
 ret
 3d0:	8082                	ret

00000000000003d2 <sprintint>:
  return 1;
}

static int
sprintint(char *s, int xx, int base, int sign)
{
 3d2:	1101                	add	sp,sp,-32
 3d4:	ec22                	sd	s0,24(sp)
 3d6:	1000                	add	s0,sp,32
 3d8:	882a                	mv	a6,a0
  char buf[16];
  int i, n;
  uint x;

  if(sign && (sign = xx < 0))
 3da:	c299                	beqz	a3,3e0 <sprintint+0xe>
 3dc:	0805c263          	bltz	a1,460 <sprintint+0x8e>
    x = -xx;
  else
    x = xx;
 3e0:	2581                	sext.w	a1,a1
 3e2:	4301                	li	t1,0

  i = 0;
 3e4:	fe040713          	add	a4,s0,-32
 3e8:	4501                	li	a0,0
  do {
    buf[i++] = digits[x % base];
 3ea:	2601                	sext.w	a2,a2
 3ec:	00000697          	auipc	a3,0x0
 3f0:	75c68693          	add	a3,a3,1884 # b48 <digits>
 3f4:	88aa                	mv	a7,a0
 3f6:	2505                	addw	a0,a0,1
 3f8:	02c5f7bb          	remuw	a5,a1,a2
 3fc:	1782                	sll	a5,a5,0x20
 3fe:	9381                	srl	a5,a5,0x20
 400:	97b6                	add	a5,a5,a3
 402:	0007c783          	lbu	a5,0(a5)
 406:	00f70023          	sb	a5,0(a4)
  } while((x /= base) != 0);
 40a:	0005879b          	sext.w	a5,a1
 40e:	02c5d5bb          	divuw	a1,a1,a2
 412:	0705                	add	a4,a4,1
 414:	fec7f0e3          	bgeu	a5,a2,3f4 <sprintint+0x22>

  if(sign)
 418:	00030b63          	beqz	t1,42e <sprintint+0x5c>
    buf[i++] = '-';
 41c:	ff050793          	add	a5,a0,-16
 420:	97a2                	add	a5,a5,s0
 422:	02d00713          	li	a4,45
 426:	fee78823          	sb	a4,-16(a5)
 42a:	0028851b          	addw	a0,a7,2

  n = 0;
  while(--i >= 0)
 42e:	02a05d63          	blez	a0,468 <sprintint+0x96>
 432:	fe040793          	add	a5,s0,-32
 436:	00a78733          	add	a4,a5,a0
 43a:	87c2                	mv	a5,a6
 43c:	00180613          	add	a2,a6,1
 440:	fff5069b          	addw	a3,a0,-1
 444:	1682                	sll	a3,a3,0x20
 446:	9281                	srl	a3,a3,0x20
 448:	9636                	add	a2,a2,a3
  *s = c;
 44a:	fff74683          	lbu	a3,-1(a4)
 44e:	00d78023          	sb	a3,0(a5)
  while(--i >= 0)
 452:	177d                	add	a4,a4,-1
 454:	0785                	add	a5,a5,1
 456:	fec79ae3          	bne	a5,a2,44a <sprintint+0x78>
    n += sputc(s+n, buf[i]);
  return n;
}
 45a:	6462                	ld	s0,24(sp)
 45c:	6105                	add	sp,sp,32
 45e:	8082                	ret
    x = -xx;
 460:	40b005bb          	negw	a1,a1
  if(sign && (sign = xx < 0))
 464:	4305                	li	t1,1
    x = -xx;
 466:	bfbd                	j	3e4 <sprintint+0x12>
  while(--i >= 0)
 468:	4501                	li	a0,0
 46a:	bfc5                	j	45a <sprintint+0x88>

000000000000046c <putc>:
{
 46c:	1101                	add	sp,sp,-32
 46e:	ec06                	sd	ra,24(sp)
 470:	e822                	sd	s0,16(sp)
 472:	1000                	add	s0,sp,32
 474:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 478:	4605                	li	a2,1
 47a:	fef40593          	add	a1,s0,-17
 47e:	00000097          	auipc	ra,0x0
 482:	e9e080e7          	jalr	-354(ra) # 31c <write>
}
 486:	60e2                	ld	ra,24(sp)
 488:	6442                	ld	s0,16(sp)
 48a:	6105                	add	sp,sp,32
 48c:	8082                	ret

000000000000048e <printint>:
{
 48e:	7139                	add	sp,sp,-64
 490:	fc06                	sd	ra,56(sp)
 492:	f822                	sd	s0,48(sp)
 494:	f426                	sd	s1,40(sp)
 496:	0080                	add	s0,sp,64
 498:	84aa                	mv	s1,a0
  if(sgn && xx < 0){
 49a:	c299                	beqz	a3,4a0 <printint+0x12>
 49c:	0805cb63          	bltz	a1,532 <printint+0xa4>
    x = xx;
 4a0:	2581                	sext.w	a1,a1
  neg = 0;
 4a2:	4881                	li	a7,0
 4a4:	fc040693          	add	a3,s0,-64
  i = 0;
 4a8:	4701                	li	a4,0
    buf[i++] = digits[x % base];
 4aa:	2601                	sext.w	a2,a2
 4ac:	00000517          	auipc	a0,0x0
 4b0:	69c50513          	add	a0,a0,1692 # b48 <digits>
 4b4:	883a                	mv	a6,a4
 4b6:	2705                	addw	a4,a4,1
 4b8:	02c5f7bb          	remuw	a5,a1,a2
 4bc:	1782                	sll	a5,a5,0x20
 4be:	9381                	srl	a5,a5,0x20
 4c0:	97aa                	add	a5,a5,a0
 4c2:	0007c783          	lbu	a5,0(a5)
 4c6:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 4ca:	0005879b          	sext.w	a5,a1
 4ce:	02c5d5bb          	divuw	a1,a1,a2
 4d2:	0685                	add	a3,a3,1
 4d4:	fec7f0e3          	bgeu	a5,a2,4b4 <printint+0x26>
  if(neg)
 4d8:	00088c63          	beqz	a7,4f0 <printint+0x62>
    buf[i++] = '-';
 4dc:	fd070793          	add	a5,a4,-48
 4e0:	00878733          	add	a4,a5,s0
 4e4:	02d00793          	li	a5,45
 4e8:	fef70823          	sb	a5,-16(a4)
 4ec:	0028071b          	addw	a4,a6,2
  while(--i >= 0)
 4f0:	02e05c63          	blez	a4,528 <printint+0x9a>
 4f4:	f04a                	sd	s2,32(sp)
 4f6:	ec4e                	sd	s3,24(sp)
 4f8:	fc040793          	add	a5,s0,-64
 4fc:	00e78933          	add	s2,a5,a4
 500:	fff78993          	add	s3,a5,-1
 504:	99ba                	add	s3,s3,a4
 506:	377d                	addw	a4,a4,-1
 508:	1702                	sll	a4,a4,0x20
 50a:	9301                	srl	a4,a4,0x20
 50c:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 510:	fff94583          	lbu	a1,-1(s2)
 514:	8526                	mv	a0,s1
 516:	00000097          	auipc	ra,0x0
 51a:	f56080e7          	jalr	-170(ra) # 46c <putc>
  while(--i >= 0)
 51e:	197d                	add	s2,s2,-1
 520:	ff3918e3          	bne	s2,s3,510 <printint+0x82>
 524:	7902                	ld	s2,32(sp)
 526:	69e2                	ld	s3,24(sp)
}
 528:	70e2                	ld	ra,56(sp)
 52a:	7442                	ld	s0,48(sp)
 52c:	74a2                	ld	s1,40(sp)
 52e:	6121                	add	sp,sp,64
 530:	8082                	ret
    x = -xx;
 532:	40b005bb          	negw	a1,a1
    neg = 1;
 536:	4885                	li	a7,1
    x = -xx;
 538:	b7b5                	j	4a4 <printint+0x16>

000000000000053a <vprintf>:
{
 53a:	715d                	add	sp,sp,-80
 53c:	e486                	sd	ra,72(sp)
 53e:	e0a2                	sd	s0,64(sp)
 540:	f84a                	sd	s2,48(sp)
 542:	0880                	add	s0,sp,80
  for(i = 0; fmt[i]; i++){
 544:	0005c903          	lbu	s2,0(a1)
 548:	1a090a63          	beqz	s2,6fc <vprintf+0x1c2>
 54c:	fc26                	sd	s1,56(sp)
 54e:	f44e                	sd	s3,40(sp)
 550:	f052                	sd	s4,32(sp)
 552:	ec56                	sd	s5,24(sp)
 554:	e85a                	sd	s6,16(sp)
 556:	e45e                	sd	s7,8(sp)
 558:	8aaa                	mv	s5,a0
 55a:	8bb2                	mv	s7,a2
 55c:	00158493          	add	s1,a1,1
  state = 0;
 560:	4981                	li	s3,0
    } else if(state == '%'){
 562:	02500a13          	li	s4,37
 566:	4b55                	li	s6,21
 568:	a839                	j	586 <vprintf+0x4c>
        putc(fd, c);
 56a:	85ca                	mv	a1,s2
 56c:	8556                	mv	a0,s5
 56e:	00000097          	auipc	ra,0x0
 572:	efe080e7          	jalr	-258(ra) # 46c <putc>
 576:	a019                	j	57c <vprintf+0x42>
    } else if(state == '%'){
 578:	01498d63          	beq	s3,s4,592 <vprintf+0x58>
  for(i = 0; fmt[i]; i++){
 57c:	0485                	add	s1,s1,1
 57e:	fff4c903          	lbu	s2,-1(s1)
 582:	16090763          	beqz	s2,6f0 <vprintf+0x1b6>
    if(state == 0){
 586:	fe0999e3          	bnez	s3,578 <vprintf+0x3e>
      if(c == '%'){
 58a:	ff4910e3          	bne	s2,s4,56a <vprintf+0x30>
        state = '%';
 58e:	89d2                	mv	s3,s4
 590:	b7f5                	j	57c <vprintf+0x42>
      if(c == 'd'){
 592:	13490463          	beq	s2,s4,6ba <vprintf+0x180>
 596:	f9d9079b          	addw	a5,s2,-99
 59a:	0ff7f793          	zext.b	a5,a5
 59e:	12fb6763          	bltu	s6,a5,6cc <vprintf+0x192>
 5a2:	f9d9079b          	addw	a5,s2,-99
 5a6:	0ff7f713          	zext.b	a4,a5
 5aa:	12eb6163          	bltu	s6,a4,6cc <vprintf+0x192>
 5ae:	00271793          	sll	a5,a4,0x2
 5b2:	00000717          	auipc	a4,0x0
 5b6:	53e70713          	add	a4,a4,1342 # af0 <malloc+0x13c>
 5ba:	97ba                	add	a5,a5,a4
 5bc:	439c                	lw	a5,0(a5)
 5be:	97ba                	add	a5,a5,a4
 5c0:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 5c2:	008b8913          	add	s2,s7,8
 5c6:	4685                	li	a3,1
 5c8:	4629                	li	a2,10
 5ca:	000ba583          	lw	a1,0(s7)
 5ce:	8556                	mv	a0,s5
 5d0:	00000097          	auipc	ra,0x0
 5d4:	ebe080e7          	jalr	-322(ra) # 48e <printint>
 5d8:	8bca                	mv	s7,s2
      state = 0;
 5da:	4981                	li	s3,0
 5dc:	b745                	j	57c <vprintf+0x42>
        printint(fd, va_arg(ap, uint64), 10, 0);
 5de:	008b8913          	add	s2,s7,8
 5e2:	4681                	li	a3,0
 5e4:	4629                	li	a2,10
 5e6:	000ba583          	lw	a1,0(s7)
 5ea:	8556                	mv	a0,s5
 5ec:	00000097          	auipc	ra,0x0
 5f0:	ea2080e7          	jalr	-350(ra) # 48e <printint>
 5f4:	8bca                	mv	s7,s2
      state = 0;
 5f6:	4981                	li	s3,0
 5f8:	b751                	j	57c <vprintf+0x42>
        printint(fd, va_arg(ap, int), 16, 0);
 5fa:	008b8913          	add	s2,s7,8
 5fe:	4681                	li	a3,0
 600:	4641                	li	a2,16
 602:	000ba583          	lw	a1,0(s7)
 606:	8556                	mv	a0,s5
 608:	00000097          	auipc	ra,0x0
 60c:	e86080e7          	jalr	-378(ra) # 48e <printint>
 610:	8bca                	mv	s7,s2
      state = 0;
 612:	4981                	li	s3,0
 614:	b7a5                	j	57c <vprintf+0x42>
 616:	e062                	sd	s8,0(sp)
        printptr(fd, va_arg(ap, uint64));
 618:	008b8c13          	add	s8,s7,8
 61c:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 620:	03000593          	li	a1,48
 624:	8556                	mv	a0,s5
 626:	00000097          	auipc	ra,0x0
 62a:	e46080e7          	jalr	-442(ra) # 46c <putc>
  putc(fd, 'x');
 62e:	07800593          	li	a1,120
 632:	8556                	mv	a0,s5
 634:	00000097          	auipc	ra,0x0
 638:	e38080e7          	jalr	-456(ra) # 46c <putc>
 63c:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 63e:	00000b97          	auipc	s7,0x0
 642:	50ab8b93          	add	s7,s7,1290 # b48 <digits>
 646:	03c9d793          	srl	a5,s3,0x3c
 64a:	97de                	add	a5,a5,s7
 64c:	0007c583          	lbu	a1,0(a5)
 650:	8556                	mv	a0,s5
 652:	00000097          	auipc	ra,0x0
 656:	e1a080e7          	jalr	-486(ra) # 46c <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 65a:	0992                	sll	s3,s3,0x4
 65c:	397d                	addw	s2,s2,-1
 65e:	fe0914e3          	bnez	s2,646 <vprintf+0x10c>
        printptr(fd, va_arg(ap, uint64));
 662:	8be2                	mv	s7,s8
      state = 0;
 664:	4981                	li	s3,0
 666:	6c02                	ld	s8,0(sp)
 668:	bf11                	j	57c <vprintf+0x42>
        s = va_arg(ap, char*);
 66a:	008b8993          	add	s3,s7,8
 66e:	000bb903          	ld	s2,0(s7)
        if(s == 0)
 672:	02090163          	beqz	s2,694 <vprintf+0x15a>
        while(*s != 0){
 676:	00094583          	lbu	a1,0(s2)
 67a:	c9a5                	beqz	a1,6ea <vprintf+0x1b0>
          putc(fd, *s);
 67c:	8556                	mv	a0,s5
 67e:	00000097          	auipc	ra,0x0
 682:	dee080e7          	jalr	-530(ra) # 46c <putc>
          s++;
 686:	0905                	add	s2,s2,1
        while(*s != 0){
 688:	00094583          	lbu	a1,0(s2)
 68c:	f9e5                	bnez	a1,67c <vprintf+0x142>
        s = va_arg(ap, char*);
 68e:	8bce                	mv	s7,s3
      state = 0;
 690:	4981                	li	s3,0
 692:	b5ed                	j	57c <vprintf+0x42>
          s = "(null)";
 694:	00000917          	auipc	s2,0x0
 698:	45490913          	add	s2,s2,1108 # ae8 <malloc+0x134>
        while(*s != 0){
 69c:	02800593          	li	a1,40
 6a0:	bff1                	j	67c <vprintf+0x142>
        putc(fd, va_arg(ap, uint));
 6a2:	008b8913          	add	s2,s7,8
 6a6:	000bc583          	lbu	a1,0(s7)
 6aa:	8556                	mv	a0,s5
 6ac:	00000097          	auipc	ra,0x0
 6b0:	dc0080e7          	jalr	-576(ra) # 46c <putc>
 6b4:	8bca                	mv	s7,s2
      state = 0;
 6b6:	4981                	li	s3,0
 6b8:	b5d1                	j	57c <vprintf+0x42>
        putc(fd, c);
 6ba:	02500593          	li	a1,37
 6be:	8556                	mv	a0,s5
 6c0:	00000097          	auipc	ra,0x0
 6c4:	dac080e7          	jalr	-596(ra) # 46c <putc>
      state = 0;
 6c8:	4981                	li	s3,0
 6ca:	bd4d                	j	57c <vprintf+0x42>
        putc(fd, '%');
 6cc:	02500593          	li	a1,37
 6d0:	8556                	mv	a0,s5
 6d2:	00000097          	auipc	ra,0x0
 6d6:	d9a080e7          	jalr	-614(ra) # 46c <putc>
        putc(fd, c);
 6da:	85ca                	mv	a1,s2
 6dc:	8556                	mv	a0,s5
 6de:	00000097          	auipc	ra,0x0
 6e2:	d8e080e7          	jalr	-626(ra) # 46c <putc>
      state = 0;
 6e6:	4981                	li	s3,0
 6e8:	bd51                	j	57c <vprintf+0x42>
        s = va_arg(ap, char*);
 6ea:	8bce                	mv	s7,s3
      state = 0;
 6ec:	4981                	li	s3,0
 6ee:	b579                	j	57c <vprintf+0x42>
 6f0:	74e2                	ld	s1,56(sp)
 6f2:	79a2                	ld	s3,40(sp)
 6f4:	7a02                	ld	s4,32(sp)
 6f6:	6ae2                	ld	s5,24(sp)
 6f8:	6b42                	ld	s6,16(sp)
 6fa:	6ba2                	ld	s7,8(sp)
}
 6fc:	60a6                	ld	ra,72(sp)
 6fe:	6406                	ld	s0,64(sp)
 700:	7942                	ld	s2,48(sp)
 702:	6161                	add	sp,sp,80
 704:	8082                	ret

0000000000000706 <fprintf>:
{
 706:	715d                	add	sp,sp,-80
 708:	ec06                	sd	ra,24(sp)
 70a:	e822                	sd	s0,16(sp)
 70c:	1000                	add	s0,sp,32
 70e:	e010                	sd	a2,0(s0)
 710:	e414                	sd	a3,8(s0)
 712:	e818                	sd	a4,16(s0)
 714:	ec1c                	sd	a5,24(s0)
 716:	03043023          	sd	a6,32(s0)
 71a:	03143423          	sd	a7,40(s0)
  va_start(ap, fmt);
 71e:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 722:	8622                	mv	a2,s0
 724:	00000097          	auipc	ra,0x0
 728:	e16080e7          	jalr	-490(ra) # 53a <vprintf>
}
 72c:	60e2                	ld	ra,24(sp)
 72e:	6442                	ld	s0,16(sp)
 730:	6161                	add	sp,sp,80
 732:	8082                	ret

0000000000000734 <printf>:
{
 734:	711d                	add	sp,sp,-96
 736:	ec06                	sd	ra,24(sp)
 738:	e822                	sd	s0,16(sp)
 73a:	1000                	add	s0,sp,32
 73c:	e40c                	sd	a1,8(s0)
 73e:	e810                	sd	a2,16(s0)
 740:	ec14                	sd	a3,24(s0)
 742:	f018                	sd	a4,32(s0)
 744:	f41c                	sd	a5,40(s0)
 746:	03043823          	sd	a6,48(s0)
 74a:	03143c23          	sd	a7,56(s0)
  va_start(ap, fmt);
 74e:	00840613          	add	a2,s0,8
 752:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 756:	85aa                	mv	a1,a0
 758:	4505                	li	a0,1
 75a:	00000097          	auipc	ra,0x0
 75e:	de0080e7          	jalr	-544(ra) # 53a <vprintf>
}
 762:	60e2                	ld	ra,24(sp)
 764:	6442                	ld	s0,16(sp)
 766:	6125                	add	sp,sp,96
 768:	8082                	ret

000000000000076a <snprintf>:

int
snprintf(char *buf, int sz, char *fmt, ...)
{
 76a:	7135                	add	sp,sp,-160
 76c:	f486                	sd	ra,104(sp)
 76e:	f0a2                	sd	s0,96(sp)
 770:	eca6                	sd	s1,88(sp)
 772:	1880                	add	s0,sp,112
 774:	e414                	sd	a3,8(s0)
 776:	e818                	sd	a4,16(s0)
 778:	ec1c                	sd	a5,24(s0)
 77a:	03043023          	sd	a6,32(s0)
 77e:	03143423          	sd	a7,40(s0)
  va_list ap;
  int i, c;
  int off = 0;
  char *s;

  if (fmt == 0)
 782:	16060b63          	beqz	a2,8f8 <snprintf+0x18e>
 786:	e8ca                	sd	s2,80(sp)
 788:	e4ce                	sd	s3,72(sp)
 78a:	fc56                	sd	s5,56(sp)
 78c:	f85a                	sd	s6,48(sp)
 78e:	8b2a                	mv	s6,a0
 790:	8aae                	mv	s5,a1
 792:	89b2                	mv	s3,a2
    return -1;

  va_start(ap, fmt);
 794:	00840793          	add	a5,s0,8
 798:	f8f43c23          	sd	a5,-104(s0)
  int off = 0;
 79c:	4481                	li	s1,0
  for(i = 0; off < sz && (c = fmt[i] & 0xff) != 0; i++){
 79e:	4901                	li	s2,0
 7a0:	00b05f63          	blez	a1,7be <snprintf+0x54>
 7a4:	e0d2                	sd	s4,64(sp)
 7a6:	f45e                	sd	s7,40(sp)
 7a8:	f062                	sd	s8,32(sp)
 7aa:	ec66                	sd	s9,24(sp)
    if(c != '%'){
 7ac:	02500a13          	li	s4,37
      continue;
    }
    c = fmt[++i] & 0xff;
    if(c == 0)
      break;
    switch(c){
 7b0:	07300b93          	li	s7,115
 7b4:	07800c93          	li	s9,120
 7b8:	06400c13          	li	s8,100
 7bc:	a839                	j	7da <snprintf+0x70>
      off += sputc(buf+off, '%');
      off += sputc(buf+off, c);
      break;
    }
  }
  return off;
 7be:	4481                	li	s1,0
 7c0:	6946                	ld	s2,80(sp)
 7c2:	69a6                	ld	s3,72(sp)
 7c4:	7ae2                	ld	s5,56(sp)
 7c6:	7b42                	ld	s6,48(sp)
 7c8:	a0cd                	j	8aa <snprintf+0x140>
  *s = c;
 7ca:	009b0733          	add	a4,s6,s1
 7ce:	00f70023          	sb	a5,0(a4)
      off += sputc(buf+off, c);
 7d2:	2485                	addw	s1,s1,1
  for(i = 0; off < sz && (c = fmt[i] & 0xff) != 0; i++){
 7d4:	2905                	addw	s2,s2,1
 7d6:	1554d563          	bge	s1,s5,920 <snprintf+0x1b6>
 7da:	012987b3          	add	a5,s3,s2
 7de:	0007c783          	lbu	a5,0(a5)
 7e2:	0007871b          	sext.w	a4,a5
 7e6:	10078063          	beqz	a5,8e6 <snprintf+0x17c>
    if(c != '%'){
 7ea:	ff4710e3          	bne	a4,s4,7ca <snprintf+0x60>
    c = fmt[++i] & 0xff;
 7ee:	2905                	addw	s2,s2,1
 7f0:	012987b3          	add	a5,s3,s2
 7f4:	0007c783          	lbu	a5,0(a5)
    if(c == 0)
 7f8:	10078263          	beqz	a5,8fc <snprintf+0x192>
    switch(c){
 7fc:	05778c63          	beq	a5,s7,854 <snprintf+0xea>
 800:	02fbe763          	bltu	s7,a5,82e <snprintf+0xc4>
 804:	0d478063          	beq	a5,s4,8c4 <snprintf+0x15a>
 808:	0d879463          	bne	a5,s8,8d0 <snprintf+0x166>
      off += sprintint(buf+off, va_arg(ap, int), 10, 1);
 80c:	f9843783          	ld	a5,-104(s0)
 810:	00878713          	add	a4,a5,8
 814:	f8e43c23          	sd	a4,-104(s0)
 818:	4685                	li	a3,1
 81a:	4629                	li	a2,10
 81c:	438c                	lw	a1,0(a5)
 81e:	009b0533          	add	a0,s6,s1
 822:	00000097          	auipc	ra,0x0
 826:	bb0080e7          	jalr	-1104(ra) # 3d2 <sprintint>
 82a:	9ca9                	addw	s1,s1,a0
      break;
 82c:	b765                	j	7d4 <snprintf+0x6a>
    switch(c){
 82e:	0b979163          	bne	a5,s9,8d0 <snprintf+0x166>
      off += sprintint(buf+off, va_arg(ap, int), 16, 1);
 832:	f9843783          	ld	a5,-104(s0)
 836:	00878713          	add	a4,a5,8
 83a:	f8e43c23          	sd	a4,-104(s0)
 83e:	4685                	li	a3,1
 840:	4641                	li	a2,16
 842:	438c                	lw	a1,0(a5)
 844:	009b0533          	add	a0,s6,s1
 848:	00000097          	auipc	ra,0x0
 84c:	b8a080e7          	jalr	-1142(ra) # 3d2 <sprintint>
 850:	9ca9                	addw	s1,s1,a0
      break;
 852:	b749                	j	7d4 <snprintf+0x6a>
      if((s = va_arg(ap, char*)) == 0)
 854:	f9843783          	ld	a5,-104(s0)
 858:	00878713          	add	a4,a5,8
 85c:	f8e43c23          	sd	a4,-104(s0)
 860:	6388                	ld	a0,0(a5)
 862:	c931                	beqz	a0,8b6 <snprintf+0x14c>
      for(; *s && off < sz; s++)
 864:	00054703          	lbu	a4,0(a0)
 868:	d735                	beqz	a4,7d4 <snprintf+0x6a>
 86a:	0b54d263          	bge	s1,s5,90e <snprintf+0x1a4>
 86e:	009b06b3          	add	a3,s6,s1
 872:	409a863b          	subw	a2,s5,s1
 876:	1602                	sll	a2,a2,0x20
 878:	9201                	srl	a2,a2,0x20
 87a:	962a                	add	a2,a2,a0
 87c:	87aa                	mv	a5,a0
        off += sputc(buf+off, *s);
 87e:	0014859b          	addw	a1,s1,1
 882:	9d89                	subw	a1,a1,a0
  *s = c;
 884:	00e68023          	sb	a4,0(a3)
        off += sputc(buf+off, *s);
 888:	00f584bb          	addw	s1,a1,a5
      for(; *s && off < sz; s++)
 88c:	0785                	add	a5,a5,1
 88e:	0007c703          	lbu	a4,0(a5)
 892:	d329                	beqz	a4,7d4 <snprintf+0x6a>
 894:	0685                	add	a3,a3,1
 896:	fec797e3          	bne	a5,a2,884 <snprintf+0x11a>
 89a:	6946                	ld	s2,80(sp)
 89c:	69a6                	ld	s3,72(sp)
 89e:	6a06                	ld	s4,64(sp)
 8a0:	7ae2                	ld	s5,56(sp)
 8a2:	7b42                	ld	s6,48(sp)
 8a4:	7ba2                	ld	s7,40(sp)
 8a6:	7c02                	ld	s8,32(sp)
 8a8:	6ce2                	ld	s9,24(sp)
 8aa:	8526                	mv	a0,s1
 8ac:	70a6                	ld	ra,104(sp)
 8ae:	7406                	ld	s0,96(sp)
 8b0:	64e6                	ld	s1,88(sp)
 8b2:	610d                	add	sp,sp,160
 8b4:	8082                	ret
      for(; *s && off < sz; s++)
 8b6:	02800713          	li	a4,40
        s = "(null)";
 8ba:	00000517          	auipc	a0,0x0
 8be:	22e50513          	add	a0,a0,558 # ae8 <malloc+0x134>
 8c2:	b765                	j	86a <snprintf+0x100>
  *s = c;
 8c4:	009b07b3          	add	a5,s6,s1
 8c8:	01478023          	sb	s4,0(a5)
      off += sputc(buf+off, '%');
 8cc:	2485                	addw	s1,s1,1
      break;
 8ce:	b719                	j	7d4 <snprintf+0x6a>
  *s = c;
 8d0:	009b0733          	add	a4,s6,s1
 8d4:	01470023          	sb	s4,0(a4)
      off += sputc(buf+off, c);
 8d8:	0014871b          	addw	a4,s1,1
  *s = c;
 8dc:	975a                	add	a4,a4,s6
 8de:	00f70023          	sb	a5,0(a4)
      off += sputc(buf+off, c);
 8e2:	2489                	addw	s1,s1,2
      break;
 8e4:	bdc5                	j	7d4 <snprintf+0x6a>
 8e6:	6946                	ld	s2,80(sp)
 8e8:	69a6                	ld	s3,72(sp)
 8ea:	6a06                	ld	s4,64(sp)
 8ec:	7ae2                	ld	s5,56(sp)
 8ee:	7b42                	ld	s6,48(sp)
 8f0:	7ba2                	ld	s7,40(sp)
 8f2:	7c02                	ld	s8,32(sp)
 8f4:	6ce2                	ld	s9,24(sp)
 8f6:	bf55                	j	8aa <snprintf+0x140>
    return -1;
 8f8:	54fd                	li	s1,-1
 8fa:	bf45                	j	8aa <snprintf+0x140>
 8fc:	6946                	ld	s2,80(sp)
 8fe:	69a6                	ld	s3,72(sp)
 900:	6a06                	ld	s4,64(sp)
 902:	7ae2                	ld	s5,56(sp)
 904:	7b42                	ld	s6,48(sp)
 906:	7ba2                	ld	s7,40(sp)
 908:	7c02                	ld	s8,32(sp)
 90a:	6ce2                	ld	s9,24(sp)
 90c:	bf79                	j	8aa <snprintf+0x140>
 90e:	6946                	ld	s2,80(sp)
 910:	69a6                	ld	s3,72(sp)
 912:	6a06                	ld	s4,64(sp)
 914:	7ae2                	ld	s5,56(sp)
 916:	7b42                	ld	s6,48(sp)
 918:	7ba2                	ld	s7,40(sp)
 91a:	7c02                	ld	s8,32(sp)
 91c:	6ce2                	ld	s9,24(sp)
 91e:	b771                	j	8aa <snprintf+0x140>
 920:	6946                	ld	s2,80(sp)
 922:	69a6                	ld	s3,72(sp)
 924:	6a06                	ld	s4,64(sp)
 926:	7ae2                	ld	s5,56(sp)
 928:	7b42                	ld	s6,48(sp)
 92a:	7ba2                	ld	s7,40(sp)
 92c:	7c02                	ld	s8,32(sp)
 92e:	6ce2                	ld	s9,24(sp)
 930:	bfad                	j	8aa <snprintf+0x140>

0000000000000932 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 932:	1141                	add	sp,sp,-16
 934:	e422                	sd	s0,8(sp)
 936:	0800                	add	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 938:	ff050693          	add	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 93c:	00000797          	auipc	a5,0x0
 940:	2247b783          	ld	a5,548(a5) # b60 <freep>
 944:	a02d                	j	96e <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 946:	4618                	lw	a4,8(a2)
 948:	9f2d                	addw	a4,a4,a1
 94a:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 94e:	6398                	ld	a4,0(a5)
 950:	6310                	ld	a2,0(a4)
 952:	a83d                	j	990 <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 954:	ff852703          	lw	a4,-8(a0)
 958:	9f31                	addw	a4,a4,a2
 95a:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 95c:	ff053683          	ld	a3,-16(a0)
 960:	a091                	j	9a4 <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 962:	6398                	ld	a4,0(a5)
 964:	00e7e463          	bltu	a5,a4,96c <free+0x3a>
 968:	00e6ea63          	bltu	a3,a4,97c <free+0x4a>
{
 96c:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 96e:	fed7fae3          	bgeu	a5,a3,962 <free+0x30>
 972:	6398                	ld	a4,0(a5)
 974:	00e6e463          	bltu	a3,a4,97c <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 978:	fee7eae3          	bltu	a5,a4,96c <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 97c:	ff852583          	lw	a1,-8(a0)
 980:	6390                	ld	a2,0(a5)
 982:	02059813          	sll	a6,a1,0x20
 986:	01c85713          	srl	a4,a6,0x1c
 98a:	9736                	add	a4,a4,a3
 98c:	fae60de3          	beq	a2,a4,946 <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 990:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 994:	4790                	lw	a2,8(a5)
 996:	02061593          	sll	a1,a2,0x20
 99a:	01c5d713          	srl	a4,a1,0x1c
 99e:	973e                	add	a4,a4,a5
 9a0:	fae68ae3          	beq	a3,a4,954 <free+0x22>
    p->s.ptr = bp->s.ptr;
 9a4:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 9a6:	00000717          	auipc	a4,0x0
 9aa:	1af73d23          	sd	a5,442(a4) # b60 <freep>
}
 9ae:	6422                	ld	s0,8(sp)
 9b0:	0141                	add	sp,sp,16
 9b2:	8082                	ret

00000000000009b4 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 9b4:	7139                	add	sp,sp,-64
 9b6:	fc06                	sd	ra,56(sp)
 9b8:	f822                	sd	s0,48(sp)
 9ba:	f426                	sd	s1,40(sp)
 9bc:	ec4e                	sd	s3,24(sp)
 9be:	0080                	add	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 9c0:	02051493          	sll	s1,a0,0x20
 9c4:	9081                	srl	s1,s1,0x20
 9c6:	04bd                	add	s1,s1,15
 9c8:	8091                	srl	s1,s1,0x4
 9ca:	0014899b          	addw	s3,s1,1
 9ce:	0485                	add	s1,s1,1
  if((prevp = freep) == 0){
 9d0:	00000517          	auipc	a0,0x0
 9d4:	19053503          	ld	a0,400(a0) # b60 <freep>
 9d8:	c915                	beqz	a0,a0c <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 9da:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 9dc:	4798                	lw	a4,8(a5)
 9de:	08977e63          	bgeu	a4,s1,a7a <malloc+0xc6>
 9e2:	f04a                	sd	s2,32(sp)
 9e4:	e852                	sd	s4,16(sp)
 9e6:	e456                	sd	s5,8(sp)
 9e8:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 9ea:	8a4e                	mv	s4,s3
 9ec:	0009871b          	sext.w	a4,s3
 9f0:	6685                	lui	a3,0x1
 9f2:	00d77363          	bgeu	a4,a3,9f8 <malloc+0x44>
 9f6:	6a05                	lui	s4,0x1
 9f8:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 9fc:	004a1a1b          	sllw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 a00:	00000917          	auipc	s2,0x0
 a04:	16090913          	add	s2,s2,352 # b60 <freep>
  if(p == (char*)-1)
 a08:	5afd                	li	s5,-1
 a0a:	a091                	j	a4e <malloc+0x9a>
 a0c:	f04a                	sd	s2,32(sp)
 a0e:	e852                	sd	s4,16(sp)
 a10:	e456                	sd	s5,8(sp)
 a12:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 a14:	00000797          	auipc	a5,0x0
 a18:	15478793          	add	a5,a5,340 # b68 <base>
 a1c:	00000717          	auipc	a4,0x0
 a20:	14f73223          	sd	a5,324(a4) # b60 <freep>
 a24:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 a26:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 a2a:	b7c1                	j	9ea <malloc+0x36>
        prevp->s.ptr = p->s.ptr;
 a2c:	6398                	ld	a4,0(a5)
 a2e:	e118                	sd	a4,0(a0)
 a30:	a08d                	j	a92 <malloc+0xde>
  hp->s.size = nu;
 a32:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 a36:	0541                	add	a0,a0,16
 a38:	00000097          	auipc	ra,0x0
 a3c:	efa080e7          	jalr	-262(ra) # 932 <free>
  return freep;
 a40:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 a44:	c13d                	beqz	a0,aaa <malloc+0xf6>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a46:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 a48:	4798                	lw	a4,8(a5)
 a4a:	02977463          	bgeu	a4,s1,a72 <malloc+0xbe>
    if(p == freep)
 a4e:	00093703          	ld	a4,0(s2)
 a52:	853e                	mv	a0,a5
 a54:	fef719e3          	bne	a4,a5,a46 <malloc+0x92>
  p = sbrk(nu * sizeof(Header));
 a58:	8552                	mv	a0,s4
 a5a:	00000097          	auipc	ra,0x0
 a5e:	92a080e7          	jalr	-1750(ra) # 384 <sbrk>
  if(p == (char*)-1)
 a62:	fd5518e3          	bne	a0,s5,a32 <malloc+0x7e>
        return 0;
 a66:	4501                	li	a0,0
 a68:	7902                	ld	s2,32(sp)
 a6a:	6a42                	ld	s4,16(sp)
 a6c:	6aa2                	ld	s5,8(sp)
 a6e:	6b02                	ld	s6,0(sp)
 a70:	a03d                	j	a9e <malloc+0xea>
 a72:	7902                	ld	s2,32(sp)
 a74:	6a42                	ld	s4,16(sp)
 a76:	6aa2                	ld	s5,8(sp)
 a78:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 a7a:	fae489e3          	beq	s1,a4,a2c <malloc+0x78>
        p->s.size -= nunits;
 a7e:	4137073b          	subw	a4,a4,s3
 a82:	c798                	sw	a4,8(a5)
        p += p->s.size;
 a84:	02071693          	sll	a3,a4,0x20
 a88:	01c6d713          	srl	a4,a3,0x1c
 a8c:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 a8e:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 a92:	00000717          	auipc	a4,0x0
 a96:	0ca73723          	sd	a0,206(a4) # b60 <freep>
      return (void*)(p + 1);
 a9a:	01078513          	add	a0,a5,16
  }
}
 a9e:	70e2                	ld	ra,56(sp)
 aa0:	7442                	ld	s0,48(sp)
 aa2:	74a2                	ld	s1,40(sp)
 aa4:	69e2                	ld	s3,24(sp)
 aa6:	6121                	add	sp,sp,64
 aa8:	8082                	ret
 aaa:	7902                	ld	s2,32(sp)
 aac:	6a42                	ld	s4,16(sp)
 aae:	6aa2                	ld	s5,8(sp)
 ab0:	6b02                	ld	s6,0(sp)
 ab2:	b7f5                	j	a9e <malloc+0xea>
