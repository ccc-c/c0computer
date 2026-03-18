
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
   8:	00000097          	auipc	ra,0x0
   c:	2b4080e7          	jalr	692(ra) # 2bc <fork>
  10:	00a04763          	bgtz	a0,1e <main+0x1e>
    sleep(5);  // Let child exit before parent.
  exit(0);
  14:	4501                	li	a0,0
  16:	00000097          	auipc	ra,0x0
  1a:	2ae080e7          	jalr	686(ra) # 2c4 <exit>
    sleep(5);  // Let child exit before parent.
  1e:	4515                	li	a0,5
  20:	00000097          	auipc	ra,0x0
  24:	334080e7          	jalr	820(ra) # 354 <sleep>
  28:	b7f5                	j	14 <main+0x14>

000000000000002a <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
  2a:	1141                	add	sp,sp,-16
  2c:	e422                	sd	s0,8(sp)
  2e:	0800                	add	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  30:	87aa                	mv	a5,a0
  32:	0585                	add	a1,a1,1
  34:	0785                	add	a5,a5,1
  36:	fff5c703          	lbu	a4,-1(a1)
  3a:	fee78fa3          	sb	a4,-1(a5)
  3e:	fb75                	bnez	a4,32 <strcpy+0x8>
    ;
  return os;
}
  40:	6422                	ld	s0,8(sp)
  42:	0141                	add	sp,sp,16
  44:	8082                	ret

0000000000000046 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  46:	1141                	add	sp,sp,-16
  48:	e422                	sd	s0,8(sp)
  4a:	0800                	add	s0,sp,16
  while(*p && *p == *q)
  4c:	00054783          	lbu	a5,0(a0)
  50:	cb91                	beqz	a5,64 <strcmp+0x1e>
  52:	0005c703          	lbu	a4,0(a1)
  56:	00f71763          	bne	a4,a5,64 <strcmp+0x1e>
    p++, q++;
  5a:	0505                	add	a0,a0,1
  5c:	0585                	add	a1,a1,1
  while(*p && *p == *q)
  5e:	00054783          	lbu	a5,0(a0)
  62:	fbe5                	bnez	a5,52 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
  64:	0005c503          	lbu	a0,0(a1)
}
  68:	40a7853b          	subw	a0,a5,a0
  6c:	6422                	ld	s0,8(sp)
  6e:	0141                	add	sp,sp,16
  70:	8082                	ret

0000000000000072 <strlen>:

uint
strlen(const char *s)
{
  72:	1141                	add	sp,sp,-16
  74:	e422                	sd	s0,8(sp)
  76:	0800                	add	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
  78:	00054783          	lbu	a5,0(a0)
  7c:	cf91                	beqz	a5,98 <strlen+0x26>
  7e:	0505                	add	a0,a0,1
  80:	87aa                	mv	a5,a0
  82:	86be                	mv	a3,a5
  84:	0785                	add	a5,a5,1
  86:	fff7c703          	lbu	a4,-1(a5)
  8a:	ff65                	bnez	a4,82 <strlen+0x10>
  8c:	40a6853b          	subw	a0,a3,a0
  90:	2505                	addw	a0,a0,1
    ;
  return n;
}
  92:	6422                	ld	s0,8(sp)
  94:	0141                	add	sp,sp,16
  96:	8082                	ret
  for(n = 0; s[n]; n++)
  98:	4501                	li	a0,0
  9a:	bfe5                	j	92 <strlen+0x20>

000000000000009c <strcat>:

char *
strcat(char *dst, char *src)
{
  9c:	1141                	add	sp,sp,-16
  9e:	e422                	sd	s0,8(sp)
  a0:	0800                	add	s0,sp,16
  char *s = dst;
  while (*dst)
  a2:	00054783          	lbu	a5,0(a0)
  a6:	c385                	beqz	a5,c6 <strcat+0x2a>
  a8:	87aa                	mv	a5,a0
    dst++;
  aa:	0785                	add	a5,a5,1
  while (*dst)
  ac:	0007c703          	lbu	a4,0(a5)
  b0:	ff6d                	bnez	a4,aa <strcat+0xe>
  while ((*dst++ = *src++) != 0);
  b2:	0585                	add	a1,a1,1
  b4:	0785                	add	a5,a5,1
  b6:	fff5c703          	lbu	a4,-1(a1)
  ba:	fee78fa3          	sb	a4,-1(a5)
  be:	fb75                	bnez	a4,b2 <strcat+0x16>

  return s;
}
  c0:	6422                	ld	s0,8(sp)
  c2:	0141                	add	sp,sp,16
  c4:	8082                	ret
  while (*dst)
  c6:	87aa                	mv	a5,a0
  c8:	b7ed                	j	b2 <strcat+0x16>

00000000000000ca <memset>:

void*
memset(void *dst, int c, uint n)
{
  ca:	1141                	add	sp,sp,-16
  cc:	e422                	sd	s0,8(sp)
  ce:	0800                	add	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
  d0:	ca19                	beqz	a2,e6 <memset+0x1c>
  d2:	87aa                	mv	a5,a0
  d4:	1602                	sll	a2,a2,0x20
  d6:	9201                	srl	a2,a2,0x20
  d8:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
  dc:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
  e0:	0785                	add	a5,a5,1
  e2:	fee79de3          	bne	a5,a4,dc <memset+0x12>
  }
  return dst;
}
  e6:	6422                	ld	s0,8(sp)
  e8:	0141                	add	sp,sp,16
  ea:	8082                	ret

00000000000000ec <strchr>:

char*
strchr(const char *s, char c)
{
  ec:	1141                	add	sp,sp,-16
  ee:	e422                	sd	s0,8(sp)
  f0:	0800                	add	s0,sp,16
  for(; *s; s++)
  f2:	00054783          	lbu	a5,0(a0)
  f6:	cb99                	beqz	a5,10c <strchr+0x20>
    if(*s == c)
  f8:	00f58763          	beq	a1,a5,106 <strchr+0x1a>
  for(; *s; s++)
  fc:	0505                	add	a0,a0,1
  fe:	00054783          	lbu	a5,0(a0)
 102:	fbfd                	bnez	a5,f8 <strchr+0xc>
      return (char*)s;
  return 0;
 104:	4501                	li	a0,0
}
 106:	6422                	ld	s0,8(sp)
 108:	0141                	add	sp,sp,16
 10a:	8082                	ret
  return 0;
 10c:	4501                	li	a0,0
 10e:	bfe5                	j	106 <strchr+0x1a>

0000000000000110 <gets>:

char*
gets(char *buf, int max)
{
 110:	711d                	add	sp,sp,-96
 112:	ec86                	sd	ra,88(sp)
 114:	e8a2                	sd	s0,80(sp)
 116:	e4a6                	sd	s1,72(sp)
 118:	e0ca                	sd	s2,64(sp)
 11a:	fc4e                	sd	s3,56(sp)
 11c:	f852                	sd	s4,48(sp)
 11e:	f456                	sd	s5,40(sp)
 120:	f05a                	sd	s6,32(sp)
 122:	ec5e                	sd	s7,24(sp)
 124:	1080                	add	s0,sp,96
 126:	8baa                	mv	s7,a0
 128:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 12a:	892a                	mv	s2,a0
 12c:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 12e:	4aa9                	li	s5,10
 130:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 132:	89a6                	mv	s3,s1
 134:	2485                	addw	s1,s1,1
 136:	0344d863          	bge	s1,s4,166 <gets+0x56>
    cc = read(0, &c, 1);
 13a:	4605                	li	a2,1
 13c:	faf40593          	add	a1,s0,-81
 140:	4501                	li	a0,0
 142:	00000097          	auipc	ra,0x0
 146:	19a080e7          	jalr	410(ra) # 2dc <read>
    if(cc < 1)
 14a:	00a05e63          	blez	a0,166 <gets+0x56>
    buf[i++] = c;
 14e:	faf44783          	lbu	a5,-81(s0)
 152:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 156:	01578763          	beq	a5,s5,164 <gets+0x54>
 15a:	0905                	add	s2,s2,1
 15c:	fd679be3          	bne	a5,s6,132 <gets+0x22>
    buf[i++] = c;
 160:	89a6                	mv	s3,s1
 162:	a011                	j	166 <gets+0x56>
 164:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 166:	99de                	add	s3,s3,s7
 168:	00098023          	sb	zero,0(s3)
  return buf;
}
 16c:	855e                	mv	a0,s7
 16e:	60e6                	ld	ra,88(sp)
 170:	6446                	ld	s0,80(sp)
 172:	64a6                	ld	s1,72(sp)
 174:	6906                	ld	s2,64(sp)
 176:	79e2                	ld	s3,56(sp)
 178:	7a42                	ld	s4,48(sp)
 17a:	7aa2                	ld	s5,40(sp)
 17c:	7b02                	ld	s6,32(sp)
 17e:	6be2                	ld	s7,24(sp)
 180:	6125                	add	sp,sp,96
 182:	8082                	ret

0000000000000184 <stat>:

int
stat(const char *n, struct stat *st)
{
 184:	1101                	add	sp,sp,-32
 186:	ec06                	sd	ra,24(sp)
 188:	e822                	sd	s0,16(sp)
 18a:	e04a                	sd	s2,0(sp)
 18c:	1000                	add	s0,sp,32
 18e:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 190:	4581                	li	a1,0
 192:	00000097          	auipc	ra,0x0
 196:	172080e7          	jalr	370(ra) # 304 <open>
  if(fd < 0)
 19a:	02054663          	bltz	a0,1c6 <stat+0x42>
 19e:	e426                	sd	s1,8(sp)
 1a0:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 1a2:	85ca                	mv	a1,s2
 1a4:	00000097          	auipc	ra,0x0
 1a8:	178080e7          	jalr	376(ra) # 31c <fstat>
 1ac:	892a                	mv	s2,a0
  close(fd);
 1ae:	8526                	mv	a0,s1
 1b0:	00000097          	auipc	ra,0x0
 1b4:	13c080e7          	jalr	316(ra) # 2ec <close>
  return r;
 1b8:	64a2                	ld	s1,8(sp)
}
 1ba:	854a                	mv	a0,s2
 1bc:	60e2                	ld	ra,24(sp)
 1be:	6442                	ld	s0,16(sp)
 1c0:	6902                	ld	s2,0(sp)
 1c2:	6105                	add	sp,sp,32
 1c4:	8082                	ret
    return -1;
 1c6:	597d                	li	s2,-1
 1c8:	bfcd                	j	1ba <stat+0x36>

00000000000001ca <atoi>:

int
atoi(const char *s)
{
 1ca:	1141                	add	sp,sp,-16
 1cc:	e422                	sd	s0,8(sp)
 1ce:	0800                	add	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 1d0:	00054683          	lbu	a3,0(a0)
 1d4:	fd06879b          	addw	a5,a3,-48
 1d8:	0ff7f793          	zext.b	a5,a5
 1dc:	4625                	li	a2,9
 1de:	02f66863          	bltu	a2,a5,20e <atoi+0x44>
 1e2:	872a                	mv	a4,a0
  n = 0;
 1e4:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 1e6:	0705                	add	a4,a4,1
 1e8:	0025179b          	sllw	a5,a0,0x2
 1ec:	9fa9                	addw	a5,a5,a0
 1ee:	0017979b          	sllw	a5,a5,0x1
 1f2:	9fb5                	addw	a5,a5,a3
 1f4:	fd07851b          	addw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 1f8:	00074683          	lbu	a3,0(a4)
 1fc:	fd06879b          	addw	a5,a3,-48
 200:	0ff7f793          	zext.b	a5,a5
 204:	fef671e3          	bgeu	a2,a5,1e6 <atoi+0x1c>
  return n;
}
 208:	6422                	ld	s0,8(sp)
 20a:	0141                	add	sp,sp,16
 20c:	8082                	ret
  n = 0;
 20e:	4501                	li	a0,0
 210:	bfe5                	j	208 <atoi+0x3e>

0000000000000212 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 212:	1141                	add	sp,sp,-16
 214:	e422                	sd	s0,8(sp)
 216:	0800                	add	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 218:	02b57463          	bgeu	a0,a1,240 <memmove+0x2e>
    while(n-- > 0)
 21c:	00c05f63          	blez	a2,23a <memmove+0x28>
 220:	1602                	sll	a2,a2,0x20
 222:	9201                	srl	a2,a2,0x20
 224:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 228:	872a                	mv	a4,a0
      *dst++ = *src++;
 22a:	0585                	add	a1,a1,1
 22c:	0705                	add	a4,a4,1
 22e:	fff5c683          	lbu	a3,-1(a1)
 232:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 236:	fef71ae3          	bne	a4,a5,22a <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 23a:	6422                	ld	s0,8(sp)
 23c:	0141                	add	sp,sp,16
 23e:	8082                	ret
    dst += n;
 240:	00c50733          	add	a4,a0,a2
    src += n;
 244:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 246:	fec05ae3          	blez	a2,23a <memmove+0x28>
 24a:	fff6079b          	addw	a5,a2,-1
 24e:	1782                	sll	a5,a5,0x20
 250:	9381                	srl	a5,a5,0x20
 252:	fff7c793          	not	a5,a5
 256:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 258:	15fd                	add	a1,a1,-1
 25a:	177d                	add	a4,a4,-1
 25c:	0005c683          	lbu	a3,0(a1)
 260:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 264:	fee79ae3          	bne	a5,a4,258 <memmove+0x46>
 268:	bfc9                	j	23a <memmove+0x28>

000000000000026a <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 26a:	1141                	add	sp,sp,-16
 26c:	e422                	sd	s0,8(sp)
 26e:	0800                	add	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 270:	ca05                	beqz	a2,2a0 <memcmp+0x36>
 272:	fff6069b          	addw	a3,a2,-1
 276:	1682                	sll	a3,a3,0x20
 278:	9281                	srl	a3,a3,0x20
 27a:	0685                	add	a3,a3,1
 27c:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 27e:	00054783          	lbu	a5,0(a0)
 282:	0005c703          	lbu	a4,0(a1)
 286:	00e79863          	bne	a5,a4,296 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 28a:	0505                	add	a0,a0,1
    p2++;
 28c:	0585                	add	a1,a1,1
  while (n-- > 0) {
 28e:	fed518e3          	bne	a0,a3,27e <memcmp+0x14>
  }
  return 0;
 292:	4501                	li	a0,0
 294:	a019                	j	29a <memcmp+0x30>
      return *p1 - *p2;
 296:	40e7853b          	subw	a0,a5,a4
}
 29a:	6422                	ld	s0,8(sp)
 29c:	0141                	add	sp,sp,16
 29e:	8082                	ret
  return 0;
 2a0:	4501                	li	a0,0
 2a2:	bfe5                	j	29a <memcmp+0x30>

00000000000002a4 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 2a4:	1141                	add	sp,sp,-16
 2a6:	e406                	sd	ra,8(sp)
 2a8:	e022                	sd	s0,0(sp)
 2aa:	0800                	add	s0,sp,16
  return memmove(dst, src, n);
 2ac:	00000097          	auipc	ra,0x0
 2b0:	f66080e7          	jalr	-154(ra) # 212 <memmove>
}
 2b4:	60a2                	ld	ra,8(sp)
 2b6:	6402                	ld	s0,0(sp)
 2b8:	0141                	add	sp,sp,16
 2ba:	8082                	ret

00000000000002bc <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 2bc:	4885                	li	a7,1
 ecall
 2be:	00000073          	ecall
 ret
 2c2:	8082                	ret

00000000000002c4 <exit>:
.global exit
exit:
 li a7, SYS_exit
 2c4:	4889                	li	a7,2
 ecall
 2c6:	00000073          	ecall
 ret
 2ca:	8082                	ret

00000000000002cc <wait>:
.global wait
wait:
 li a7, SYS_wait
 2cc:	488d                	li	a7,3
 ecall
 2ce:	00000073          	ecall
 ret
 2d2:	8082                	ret

00000000000002d4 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 2d4:	4891                	li	a7,4
 ecall
 2d6:	00000073          	ecall
 ret
 2da:	8082                	ret

00000000000002dc <read>:
.global read
read:
 li a7, SYS_read
 2dc:	4895                	li	a7,5
 ecall
 2de:	00000073          	ecall
 ret
 2e2:	8082                	ret

00000000000002e4 <write>:
.global write
write:
 li a7, SYS_write
 2e4:	48c1                	li	a7,16
 ecall
 2e6:	00000073          	ecall
 ret
 2ea:	8082                	ret

00000000000002ec <close>:
.global close
close:
 li a7, SYS_close
 2ec:	48d5                	li	a7,21
 ecall
 2ee:	00000073          	ecall
 ret
 2f2:	8082                	ret

00000000000002f4 <kill>:
.global kill
kill:
 li a7, SYS_kill
 2f4:	4899                	li	a7,6
 ecall
 2f6:	00000073          	ecall
 ret
 2fa:	8082                	ret

00000000000002fc <exec>:
.global exec
exec:
 li a7, SYS_exec
 2fc:	489d                	li	a7,7
 ecall
 2fe:	00000073          	ecall
 ret
 302:	8082                	ret

0000000000000304 <open>:
.global open
open:
 li a7, SYS_open
 304:	48bd                	li	a7,15
 ecall
 306:	00000073          	ecall
 ret
 30a:	8082                	ret

000000000000030c <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 30c:	48c5                	li	a7,17
 ecall
 30e:	00000073          	ecall
 ret
 312:	8082                	ret

0000000000000314 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 314:	48c9                	li	a7,18
 ecall
 316:	00000073          	ecall
 ret
 31a:	8082                	ret

000000000000031c <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 31c:	48a1                	li	a7,8
 ecall
 31e:	00000073          	ecall
 ret
 322:	8082                	ret

0000000000000324 <link>:
.global link
link:
 li a7, SYS_link
 324:	48cd                	li	a7,19
 ecall
 326:	00000073          	ecall
 ret
 32a:	8082                	ret

000000000000032c <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 32c:	48d1                	li	a7,20
 ecall
 32e:	00000073          	ecall
 ret
 332:	8082                	ret

0000000000000334 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 334:	48a5                	li	a7,9
 ecall
 336:	00000073          	ecall
 ret
 33a:	8082                	ret

000000000000033c <dup>:
.global dup
dup:
 li a7, SYS_dup
 33c:	48a9                	li	a7,10
 ecall
 33e:	00000073          	ecall
 ret
 342:	8082                	ret

0000000000000344 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 344:	48ad                	li	a7,11
 ecall
 346:	00000073          	ecall
 ret
 34a:	8082                	ret

000000000000034c <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 34c:	48b1                	li	a7,12
 ecall
 34e:	00000073          	ecall
 ret
 352:	8082                	ret

0000000000000354 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 354:	48b5                	li	a7,13
 ecall
 356:	00000073          	ecall
 ret
 35a:	8082                	ret

000000000000035c <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 35c:	48b9                	li	a7,14
 ecall
 35e:	00000073          	ecall
 ret
 362:	8082                	ret

0000000000000364 <uconnect>:
.global uconnect
uconnect:
 li a7, SYS_uconnect
 364:	48f5                	li	a7,29
 ecall
 366:	00000073          	ecall
 ret
 36a:	8082                	ret

000000000000036c <socket>:
.global socket
socket:
 li a7, SYS_socket
 36c:	48f9                	li	a7,30
 ecall
 36e:	00000073          	ecall
 ret
 372:	8082                	ret

0000000000000374 <bind>:
.global bind
bind:
 li a7, SYS_bind
 374:	48fd                	li	a7,31
 ecall
 376:	00000073          	ecall
 ret
 37a:	8082                	ret

000000000000037c <listen>:
.global listen
listen:
 li a7, SYS_listen
 37c:	02000893          	li	a7,32
 ecall
 380:	00000073          	ecall
 ret
 384:	8082                	ret

0000000000000386 <accept>:
.global accept
accept:
 li a7, SYS_accept
 386:	02100893          	li	a7,33
 ecall
 38a:	00000073          	ecall
 ret
 38e:	8082                	ret

0000000000000390 <connect>:
.global connect
connect:
 li a7, SYS_connect
 390:	02200893          	li	a7,34
 ecall
 394:	00000073          	ecall
 ret
 398:	8082                	ret

000000000000039a <sprintint>:
  return 1;
}

static int
sprintint(char *s, int xx, int base, int sign)
{
 39a:	1101                	add	sp,sp,-32
 39c:	ec22                	sd	s0,24(sp)
 39e:	1000                	add	s0,sp,32
 3a0:	882a                	mv	a6,a0
  char buf[16];
  int i, n;
  uint x;

  if(sign && (sign = xx < 0))
 3a2:	c299                	beqz	a3,3a8 <sprintint+0xe>
 3a4:	0805c263          	bltz	a1,428 <sprintint+0x8e>
    x = -xx;
  else
    x = xx;
 3a8:	2581                	sext.w	a1,a1
 3aa:	4301                	li	t1,0

  i = 0;
 3ac:	fe040713          	add	a4,s0,-32
 3b0:	4501                	li	a0,0
  do {
    buf[i++] = digits[x % base];
 3b2:	2601                	sext.w	a2,a2
 3b4:	00000697          	auipc	a3,0x0
 3b8:	72c68693          	add	a3,a3,1836 # ae0 <digits>
 3bc:	88aa                	mv	a7,a0
 3be:	2505                	addw	a0,a0,1
 3c0:	02c5f7bb          	remuw	a5,a1,a2
 3c4:	1782                	sll	a5,a5,0x20
 3c6:	9381                	srl	a5,a5,0x20
 3c8:	97b6                	add	a5,a5,a3
 3ca:	0007c783          	lbu	a5,0(a5)
 3ce:	00f70023          	sb	a5,0(a4)
  } while((x /= base) != 0);
 3d2:	0005879b          	sext.w	a5,a1
 3d6:	02c5d5bb          	divuw	a1,a1,a2
 3da:	0705                	add	a4,a4,1
 3dc:	fec7f0e3          	bgeu	a5,a2,3bc <sprintint+0x22>

  if(sign)
 3e0:	00030b63          	beqz	t1,3f6 <sprintint+0x5c>
    buf[i++] = '-';
 3e4:	ff050793          	add	a5,a0,-16
 3e8:	97a2                	add	a5,a5,s0
 3ea:	02d00713          	li	a4,45
 3ee:	fee78823          	sb	a4,-16(a5)
 3f2:	0028851b          	addw	a0,a7,2

  n = 0;
  while(--i >= 0)
 3f6:	02a05d63          	blez	a0,430 <sprintint+0x96>
 3fa:	fe040793          	add	a5,s0,-32
 3fe:	00a78733          	add	a4,a5,a0
 402:	87c2                	mv	a5,a6
 404:	00180613          	add	a2,a6,1
 408:	fff5069b          	addw	a3,a0,-1
 40c:	1682                	sll	a3,a3,0x20
 40e:	9281                	srl	a3,a3,0x20
 410:	9636                	add	a2,a2,a3
  *s = c;
 412:	fff74683          	lbu	a3,-1(a4)
 416:	00d78023          	sb	a3,0(a5)
  while(--i >= 0)
 41a:	177d                	add	a4,a4,-1
 41c:	0785                	add	a5,a5,1
 41e:	fec79ae3          	bne	a5,a2,412 <sprintint+0x78>
    n += sputc(s+n, buf[i]);
  return n;
}
 422:	6462                	ld	s0,24(sp)
 424:	6105                	add	sp,sp,32
 426:	8082                	ret
    x = -xx;
 428:	40b005bb          	negw	a1,a1
  if(sign && (sign = xx < 0))
 42c:	4305                	li	t1,1
    x = -xx;
 42e:	bfbd                	j	3ac <sprintint+0x12>
  while(--i >= 0)
 430:	4501                	li	a0,0
 432:	bfc5                	j	422 <sprintint+0x88>

0000000000000434 <putc>:
{
 434:	1101                	add	sp,sp,-32
 436:	ec06                	sd	ra,24(sp)
 438:	e822                	sd	s0,16(sp)
 43a:	1000                	add	s0,sp,32
 43c:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 440:	4605                	li	a2,1
 442:	fef40593          	add	a1,s0,-17
 446:	00000097          	auipc	ra,0x0
 44a:	e9e080e7          	jalr	-354(ra) # 2e4 <write>
}
 44e:	60e2                	ld	ra,24(sp)
 450:	6442                	ld	s0,16(sp)
 452:	6105                	add	sp,sp,32
 454:	8082                	ret

0000000000000456 <printint>:
{
 456:	7139                	add	sp,sp,-64
 458:	fc06                	sd	ra,56(sp)
 45a:	f822                	sd	s0,48(sp)
 45c:	f426                	sd	s1,40(sp)
 45e:	0080                	add	s0,sp,64
 460:	84aa                	mv	s1,a0
  if(sgn && xx < 0){
 462:	c299                	beqz	a3,468 <printint+0x12>
 464:	0805cb63          	bltz	a1,4fa <printint+0xa4>
    x = xx;
 468:	2581                	sext.w	a1,a1
  neg = 0;
 46a:	4881                	li	a7,0
 46c:	fc040693          	add	a3,s0,-64
  i = 0;
 470:	4701                	li	a4,0
    buf[i++] = digits[x % base];
 472:	2601                	sext.w	a2,a2
 474:	00000517          	auipc	a0,0x0
 478:	66c50513          	add	a0,a0,1644 # ae0 <digits>
 47c:	883a                	mv	a6,a4
 47e:	2705                	addw	a4,a4,1
 480:	02c5f7bb          	remuw	a5,a1,a2
 484:	1782                	sll	a5,a5,0x20
 486:	9381                	srl	a5,a5,0x20
 488:	97aa                	add	a5,a5,a0
 48a:	0007c783          	lbu	a5,0(a5)
 48e:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 492:	0005879b          	sext.w	a5,a1
 496:	02c5d5bb          	divuw	a1,a1,a2
 49a:	0685                	add	a3,a3,1
 49c:	fec7f0e3          	bgeu	a5,a2,47c <printint+0x26>
  if(neg)
 4a0:	00088c63          	beqz	a7,4b8 <printint+0x62>
    buf[i++] = '-';
 4a4:	fd070793          	add	a5,a4,-48
 4a8:	00878733          	add	a4,a5,s0
 4ac:	02d00793          	li	a5,45
 4b0:	fef70823          	sb	a5,-16(a4)
 4b4:	0028071b          	addw	a4,a6,2
  while(--i >= 0)
 4b8:	02e05c63          	blez	a4,4f0 <printint+0x9a>
 4bc:	f04a                	sd	s2,32(sp)
 4be:	ec4e                	sd	s3,24(sp)
 4c0:	fc040793          	add	a5,s0,-64
 4c4:	00e78933          	add	s2,a5,a4
 4c8:	fff78993          	add	s3,a5,-1
 4cc:	99ba                	add	s3,s3,a4
 4ce:	377d                	addw	a4,a4,-1
 4d0:	1702                	sll	a4,a4,0x20
 4d2:	9301                	srl	a4,a4,0x20
 4d4:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 4d8:	fff94583          	lbu	a1,-1(s2)
 4dc:	8526                	mv	a0,s1
 4de:	00000097          	auipc	ra,0x0
 4e2:	f56080e7          	jalr	-170(ra) # 434 <putc>
  while(--i >= 0)
 4e6:	197d                	add	s2,s2,-1
 4e8:	ff3918e3          	bne	s2,s3,4d8 <printint+0x82>
 4ec:	7902                	ld	s2,32(sp)
 4ee:	69e2                	ld	s3,24(sp)
}
 4f0:	70e2                	ld	ra,56(sp)
 4f2:	7442                	ld	s0,48(sp)
 4f4:	74a2                	ld	s1,40(sp)
 4f6:	6121                	add	sp,sp,64
 4f8:	8082                	ret
    x = -xx;
 4fa:	40b005bb          	negw	a1,a1
    neg = 1;
 4fe:	4885                	li	a7,1
    x = -xx;
 500:	b7b5                	j	46c <printint+0x16>

0000000000000502 <vprintf>:
{
 502:	715d                	add	sp,sp,-80
 504:	e486                	sd	ra,72(sp)
 506:	e0a2                	sd	s0,64(sp)
 508:	f84a                	sd	s2,48(sp)
 50a:	0880                	add	s0,sp,80
  for(i = 0; fmt[i]; i++){
 50c:	0005c903          	lbu	s2,0(a1)
 510:	1a090a63          	beqz	s2,6c4 <vprintf+0x1c2>
 514:	fc26                	sd	s1,56(sp)
 516:	f44e                	sd	s3,40(sp)
 518:	f052                	sd	s4,32(sp)
 51a:	ec56                	sd	s5,24(sp)
 51c:	e85a                	sd	s6,16(sp)
 51e:	e45e                	sd	s7,8(sp)
 520:	8aaa                	mv	s5,a0
 522:	8bb2                	mv	s7,a2
 524:	00158493          	add	s1,a1,1
  state = 0;
 528:	4981                	li	s3,0
    } else if(state == '%'){
 52a:	02500a13          	li	s4,37
 52e:	4b55                	li	s6,21
 530:	a839                	j	54e <vprintf+0x4c>
        putc(fd, c);
 532:	85ca                	mv	a1,s2
 534:	8556                	mv	a0,s5
 536:	00000097          	auipc	ra,0x0
 53a:	efe080e7          	jalr	-258(ra) # 434 <putc>
 53e:	a019                	j	544 <vprintf+0x42>
    } else if(state == '%'){
 540:	01498d63          	beq	s3,s4,55a <vprintf+0x58>
  for(i = 0; fmt[i]; i++){
 544:	0485                	add	s1,s1,1
 546:	fff4c903          	lbu	s2,-1(s1)
 54a:	16090763          	beqz	s2,6b8 <vprintf+0x1b6>
    if(state == 0){
 54e:	fe0999e3          	bnez	s3,540 <vprintf+0x3e>
      if(c == '%'){
 552:	ff4910e3          	bne	s2,s4,532 <vprintf+0x30>
        state = '%';
 556:	89d2                	mv	s3,s4
 558:	b7f5                	j	544 <vprintf+0x42>
      if(c == 'd'){
 55a:	13490463          	beq	s2,s4,682 <vprintf+0x180>
 55e:	f9d9079b          	addw	a5,s2,-99
 562:	0ff7f793          	zext.b	a5,a5
 566:	12fb6763          	bltu	s6,a5,694 <vprintf+0x192>
 56a:	f9d9079b          	addw	a5,s2,-99
 56e:	0ff7f713          	zext.b	a4,a5
 572:	12eb6163          	bltu	s6,a4,694 <vprintf+0x192>
 576:	00271793          	sll	a5,a4,0x2
 57a:	00000717          	auipc	a4,0x0
 57e:	50e70713          	add	a4,a4,1294 # a88 <malloc+0x10c>
 582:	97ba                	add	a5,a5,a4
 584:	439c                	lw	a5,0(a5)
 586:	97ba                	add	a5,a5,a4
 588:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 58a:	008b8913          	add	s2,s7,8
 58e:	4685                	li	a3,1
 590:	4629                	li	a2,10
 592:	000ba583          	lw	a1,0(s7)
 596:	8556                	mv	a0,s5
 598:	00000097          	auipc	ra,0x0
 59c:	ebe080e7          	jalr	-322(ra) # 456 <printint>
 5a0:	8bca                	mv	s7,s2
      state = 0;
 5a2:	4981                	li	s3,0
 5a4:	b745                	j	544 <vprintf+0x42>
        printint(fd, va_arg(ap, uint64), 10, 0);
 5a6:	008b8913          	add	s2,s7,8
 5aa:	4681                	li	a3,0
 5ac:	4629                	li	a2,10
 5ae:	000ba583          	lw	a1,0(s7)
 5b2:	8556                	mv	a0,s5
 5b4:	00000097          	auipc	ra,0x0
 5b8:	ea2080e7          	jalr	-350(ra) # 456 <printint>
 5bc:	8bca                	mv	s7,s2
      state = 0;
 5be:	4981                	li	s3,0
 5c0:	b751                	j	544 <vprintf+0x42>
        printint(fd, va_arg(ap, int), 16, 0);
 5c2:	008b8913          	add	s2,s7,8
 5c6:	4681                	li	a3,0
 5c8:	4641                	li	a2,16
 5ca:	000ba583          	lw	a1,0(s7)
 5ce:	8556                	mv	a0,s5
 5d0:	00000097          	auipc	ra,0x0
 5d4:	e86080e7          	jalr	-378(ra) # 456 <printint>
 5d8:	8bca                	mv	s7,s2
      state = 0;
 5da:	4981                	li	s3,0
 5dc:	b7a5                	j	544 <vprintf+0x42>
 5de:	e062                	sd	s8,0(sp)
        printptr(fd, va_arg(ap, uint64));
 5e0:	008b8c13          	add	s8,s7,8
 5e4:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 5e8:	03000593          	li	a1,48
 5ec:	8556                	mv	a0,s5
 5ee:	00000097          	auipc	ra,0x0
 5f2:	e46080e7          	jalr	-442(ra) # 434 <putc>
  putc(fd, 'x');
 5f6:	07800593          	li	a1,120
 5fa:	8556                	mv	a0,s5
 5fc:	00000097          	auipc	ra,0x0
 600:	e38080e7          	jalr	-456(ra) # 434 <putc>
 604:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 606:	00000b97          	auipc	s7,0x0
 60a:	4dab8b93          	add	s7,s7,1242 # ae0 <digits>
 60e:	03c9d793          	srl	a5,s3,0x3c
 612:	97de                	add	a5,a5,s7
 614:	0007c583          	lbu	a1,0(a5)
 618:	8556                	mv	a0,s5
 61a:	00000097          	auipc	ra,0x0
 61e:	e1a080e7          	jalr	-486(ra) # 434 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 622:	0992                	sll	s3,s3,0x4
 624:	397d                	addw	s2,s2,-1
 626:	fe0914e3          	bnez	s2,60e <vprintf+0x10c>
        printptr(fd, va_arg(ap, uint64));
 62a:	8be2                	mv	s7,s8
      state = 0;
 62c:	4981                	li	s3,0
 62e:	6c02                	ld	s8,0(sp)
 630:	bf11                	j	544 <vprintf+0x42>
        s = va_arg(ap, char*);
 632:	008b8993          	add	s3,s7,8
 636:	000bb903          	ld	s2,0(s7)
        if(s == 0)
 63a:	02090163          	beqz	s2,65c <vprintf+0x15a>
        while(*s != 0){
 63e:	00094583          	lbu	a1,0(s2)
 642:	c9a5                	beqz	a1,6b2 <vprintf+0x1b0>
          putc(fd, *s);
 644:	8556                	mv	a0,s5
 646:	00000097          	auipc	ra,0x0
 64a:	dee080e7          	jalr	-530(ra) # 434 <putc>
          s++;
 64e:	0905                	add	s2,s2,1
        while(*s != 0){
 650:	00094583          	lbu	a1,0(s2)
 654:	f9e5                	bnez	a1,644 <vprintf+0x142>
        s = va_arg(ap, char*);
 656:	8bce                	mv	s7,s3
      state = 0;
 658:	4981                	li	s3,0
 65a:	b5ed                	j	544 <vprintf+0x42>
          s = "(null)";
 65c:	00000917          	auipc	s2,0x0
 660:	42490913          	add	s2,s2,1060 # a80 <malloc+0x104>
        while(*s != 0){
 664:	02800593          	li	a1,40
 668:	bff1                	j	644 <vprintf+0x142>
        putc(fd, va_arg(ap, uint));
 66a:	008b8913          	add	s2,s7,8
 66e:	000bc583          	lbu	a1,0(s7)
 672:	8556                	mv	a0,s5
 674:	00000097          	auipc	ra,0x0
 678:	dc0080e7          	jalr	-576(ra) # 434 <putc>
 67c:	8bca                	mv	s7,s2
      state = 0;
 67e:	4981                	li	s3,0
 680:	b5d1                	j	544 <vprintf+0x42>
        putc(fd, c);
 682:	02500593          	li	a1,37
 686:	8556                	mv	a0,s5
 688:	00000097          	auipc	ra,0x0
 68c:	dac080e7          	jalr	-596(ra) # 434 <putc>
      state = 0;
 690:	4981                	li	s3,0
 692:	bd4d                	j	544 <vprintf+0x42>
        putc(fd, '%');
 694:	02500593          	li	a1,37
 698:	8556                	mv	a0,s5
 69a:	00000097          	auipc	ra,0x0
 69e:	d9a080e7          	jalr	-614(ra) # 434 <putc>
        putc(fd, c);
 6a2:	85ca                	mv	a1,s2
 6a4:	8556                	mv	a0,s5
 6a6:	00000097          	auipc	ra,0x0
 6aa:	d8e080e7          	jalr	-626(ra) # 434 <putc>
      state = 0;
 6ae:	4981                	li	s3,0
 6b0:	bd51                	j	544 <vprintf+0x42>
        s = va_arg(ap, char*);
 6b2:	8bce                	mv	s7,s3
      state = 0;
 6b4:	4981                	li	s3,0
 6b6:	b579                	j	544 <vprintf+0x42>
 6b8:	74e2                	ld	s1,56(sp)
 6ba:	79a2                	ld	s3,40(sp)
 6bc:	7a02                	ld	s4,32(sp)
 6be:	6ae2                	ld	s5,24(sp)
 6c0:	6b42                	ld	s6,16(sp)
 6c2:	6ba2                	ld	s7,8(sp)
}
 6c4:	60a6                	ld	ra,72(sp)
 6c6:	6406                	ld	s0,64(sp)
 6c8:	7942                	ld	s2,48(sp)
 6ca:	6161                	add	sp,sp,80
 6cc:	8082                	ret

00000000000006ce <fprintf>:
{
 6ce:	715d                	add	sp,sp,-80
 6d0:	ec06                	sd	ra,24(sp)
 6d2:	e822                	sd	s0,16(sp)
 6d4:	1000                	add	s0,sp,32
 6d6:	e010                	sd	a2,0(s0)
 6d8:	e414                	sd	a3,8(s0)
 6da:	e818                	sd	a4,16(s0)
 6dc:	ec1c                	sd	a5,24(s0)
 6de:	03043023          	sd	a6,32(s0)
 6e2:	03143423          	sd	a7,40(s0)
  va_start(ap, fmt);
 6e6:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 6ea:	8622                	mv	a2,s0
 6ec:	00000097          	auipc	ra,0x0
 6f0:	e16080e7          	jalr	-490(ra) # 502 <vprintf>
}
 6f4:	60e2                	ld	ra,24(sp)
 6f6:	6442                	ld	s0,16(sp)
 6f8:	6161                	add	sp,sp,80
 6fa:	8082                	ret

00000000000006fc <printf>:
{
 6fc:	711d                	add	sp,sp,-96
 6fe:	ec06                	sd	ra,24(sp)
 700:	e822                	sd	s0,16(sp)
 702:	1000                	add	s0,sp,32
 704:	e40c                	sd	a1,8(s0)
 706:	e810                	sd	a2,16(s0)
 708:	ec14                	sd	a3,24(s0)
 70a:	f018                	sd	a4,32(s0)
 70c:	f41c                	sd	a5,40(s0)
 70e:	03043823          	sd	a6,48(s0)
 712:	03143c23          	sd	a7,56(s0)
  va_start(ap, fmt);
 716:	00840613          	add	a2,s0,8
 71a:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 71e:	85aa                	mv	a1,a0
 720:	4505                	li	a0,1
 722:	00000097          	auipc	ra,0x0
 726:	de0080e7          	jalr	-544(ra) # 502 <vprintf>
}
 72a:	60e2                	ld	ra,24(sp)
 72c:	6442                	ld	s0,16(sp)
 72e:	6125                	add	sp,sp,96
 730:	8082                	ret

0000000000000732 <snprintf>:

int
snprintf(char *buf, int sz, char *fmt, ...)
{
 732:	7135                	add	sp,sp,-160
 734:	f486                	sd	ra,104(sp)
 736:	f0a2                	sd	s0,96(sp)
 738:	eca6                	sd	s1,88(sp)
 73a:	1880                	add	s0,sp,112
 73c:	e414                	sd	a3,8(s0)
 73e:	e818                	sd	a4,16(s0)
 740:	ec1c                	sd	a5,24(s0)
 742:	03043023          	sd	a6,32(s0)
 746:	03143423          	sd	a7,40(s0)
  va_list ap;
  int i, c;
  int off = 0;
  char *s;

  if (fmt == 0)
 74a:	16060b63          	beqz	a2,8c0 <snprintf+0x18e>
 74e:	e8ca                	sd	s2,80(sp)
 750:	e4ce                	sd	s3,72(sp)
 752:	fc56                	sd	s5,56(sp)
 754:	f85a                	sd	s6,48(sp)
 756:	8b2a                	mv	s6,a0
 758:	8aae                	mv	s5,a1
 75a:	89b2                	mv	s3,a2
    return -1;

  va_start(ap, fmt);
 75c:	00840793          	add	a5,s0,8
 760:	f8f43c23          	sd	a5,-104(s0)
  int off = 0;
 764:	4481                	li	s1,0
  for(i = 0; off < sz && (c = fmt[i] & 0xff) != 0; i++){
 766:	4901                	li	s2,0
 768:	00b05f63          	blez	a1,786 <snprintf+0x54>
 76c:	e0d2                	sd	s4,64(sp)
 76e:	f45e                	sd	s7,40(sp)
 770:	f062                	sd	s8,32(sp)
 772:	ec66                	sd	s9,24(sp)
    if(c != '%'){
 774:	02500a13          	li	s4,37
      continue;
    }
    c = fmt[++i] & 0xff;
    if(c == 0)
      break;
    switch(c){
 778:	07300b93          	li	s7,115
 77c:	07800c93          	li	s9,120
 780:	06400c13          	li	s8,100
 784:	a839                	j	7a2 <snprintf+0x70>
      off += sputc(buf+off, '%');
      off += sputc(buf+off, c);
      break;
    }
  }
  return off;
 786:	4481                	li	s1,0
 788:	6946                	ld	s2,80(sp)
 78a:	69a6                	ld	s3,72(sp)
 78c:	7ae2                	ld	s5,56(sp)
 78e:	7b42                	ld	s6,48(sp)
 790:	a0cd                	j	872 <snprintf+0x140>
  *s = c;
 792:	009b0733          	add	a4,s6,s1
 796:	00f70023          	sb	a5,0(a4)
      off += sputc(buf+off, c);
 79a:	2485                	addw	s1,s1,1
  for(i = 0; off < sz && (c = fmt[i] & 0xff) != 0; i++){
 79c:	2905                	addw	s2,s2,1
 79e:	1554d563          	bge	s1,s5,8e8 <snprintf+0x1b6>
 7a2:	012987b3          	add	a5,s3,s2
 7a6:	0007c783          	lbu	a5,0(a5)
 7aa:	0007871b          	sext.w	a4,a5
 7ae:	10078063          	beqz	a5,8ae <snprintf+0x17c>
    if(c != '%'){
 7b2:	ff4710e3          	bne	a4,s4,792 <snprintf+0x60>
    c = fmt[++i] & 0xff;
 7b6:	2905                	addw	s2,s2,1
 7b8:	012987b3          	add	a5,s3,s2
 7bc:	0007c783          	lbu	a5,0(a5)
    if(c == 0)
 7c0:	10078263          	beqz	a5,8c4 <snprintf+0x192>
    switch(c){
 7c4:	05778c63          	beq	a5,s7,81c <snprintf+0xea>
 7c8:	02fbe763          	bltu	s7,a5,7f6 <snprintf+0xc4>
 7cc:	0d478063          	beq	a5,s4,88c <snprintf+0x15a>
 7d0:	0d879463          	bne	a5,s8,898 <snprintf+0x166>
      off += sprintint(buf+off, va_arg(ap, int), 10, 1);
 7d4:	f9843783          	ld	a5,-104(s0)
 7d8:	00878713          	add	a4,a5,8
 7dc:	f8e43c23          	sd	a4,-104(s0)
 7e0:	4685                	li	a3,1
 7e2:	4629                	li	a2,10
 7e4:	438c                	lw	a1,0(a5)
 7e6:	009b0533          	add	a0,s6,s1
 7ea:	00000097          	auipc	ra,0x0
 7ee:	bb0080e7          	jalr	-1104(ra) # 39a <sprintint>
 7f2:	9ca9                	addw	s1,s1,a0
      break;
 7f4:	b765                	j	79c <snprintf+0x6a>
    switch(c){
 7f6:	0b979163          	bne	a5,s9,898 <snprintf+0x166>
      off += sprintint(buf+off, va_arg(ap, int), 16, 1);
 7fa:	f9843783          	ld	a5,-104(s0)
 7fe:	00878713          	add	a4,a5,8
 802:	f8e43c23          	sd	a4,-104(s0)
 806:	4685                	li	a3,1
 808:	4641                	li	a2,16
 80a:	438c                	lw	a1,0(a5)
 80c:	009b0533          	add	a0,s6,s1
 810:	00000097          	auipc	ra,0x0
 814:	b8a080e7          	jalr	-1142(ra) # 39a <sprintint>
 818:	9ca9                	addw	s1,s1,a0
      break;
 81a:	b749                	j	79c <snprintf+0x6a>
      if((s = va_arg(ap, char*)) == 0)
 81c:	f9843783          	ld	a5,-104(s0)
 820:	00878713          	add	a4,a5,8
 824:	f8e43c23          	sd	a4,-104(s0)
 828:	6388                	ld	a0,0(a5)
 82a:	c931                	beqz	a0,87e <snprintf+0x14c>
      for(; *s && off < sz; s++)
 82c:	00054703          	lbu	a4,0(a0)
 830:	d735                	beqz	a4,79c <snprintf+0x6a>
 832:	0b54d263          	bge	s1,s5,8d6 <snprintf+0x1a4>
 836:	009b06b3          	add	a3,s6,s1
 83a:	409a863b          	subw	a2,s5,s1
 83e:	1602                	sll	a2,a2,0x20
 840:	9201                	srl	a2,a2,0x20
 842:	962a                	add	a2,a2,a0
 844:	87aa                	mv	a5,a0
        off += sputc(buf+off, *s);
 846:	0014859b          	addw	a1,s1,1
 84a:	9d89                	subw	a1,a1,a0
  *s = c;
 84c:	00e68023          	sb	a4,0(a3)
        off += sputc(buf+off, *s);
 850:	00f584bb          	addw	s1,a1,a5
      for(; *s && off < sz; s++)
 854:	0785                	add	a5,a5,1
 856:	0007c703          	lbu	a4,0(a5)
 85a:	d329                	beqz	a4,79c <snprintf+0x6a>
 85c:	0685                	add	a3,a3,1
 85e:	fec797e3          	bne	a5,a2,84c <snprintf+0x11a>
 862:	6946                	ld	s2,80(sp)
 864:	69a6                	ld	s3,72(sp)
 866:	6a06                	ld	s4,64(sp)
 868:	7ae2                	ld	s5,56(sp)
 86a:	7b42                	ld	s6,48(sp)
 86c:	7ba2                	ld	s7,40(sp)
 86e:	7c02                	ld	s8,32(sp)
 870:	6ce2                	ld	s9,24(sp)
 872:	8526                	mv	a0,s1
 874:	70a6                	ld	ra,104(sp)
 876:	7406                	ld	s0,96(sp)
 878:	64e6                	ld	s1,88(sp)
 87a:	610d                	add	sp,sp,160
 87c:	8082                	ret
      for(; *s && off < sz; s++)
 87e:	02800713          	li	a4,40
        s = "(null)";
 882:	00000517          	auipc	a0,0x0
 886:	1fe50513          	add	a0,a0,510 # a80 <malloc+0x104>
 88a:	b765                	j	832 <snprintf+0x100>
  *s = c;
 88c:	009b07b3          	add	a5,s6,s1
 890:	01478023          	sb	s4,0(a5)
      off += sputc(buf+off, '%');
 894:	2485                	addw	s1,s1,1
      break;
 896:	b719                	j	79c <snprintf+0x6a>
  *s = c;
 898:	009b0733          	add	a4,s6,s1
 89c:	01470023          	sb	s4,0(a4)
      off += sputc(buf+off, c);
 8a0:	0014871b          	addw	a4,s1,1
  *s = c;
 8a4:	975a                	add	a4,a4,s6
 8a6:	00f70023          	sb	a5,0(a4)
      off += sputc(buf+off, c);
 8aa:	2489                	addw	s1,s1,2
      break;
 8ac:	bdc5                	j	79c <snprintf+0x6a>
 8ae:	6946                	ld	s2,80(sp)
 8b0:	69a6                	ld	s3,72(sp)
 8b2:	6a06                	ld	s4,64(sp)
 8b4:	7ae2                	ld	s5,56(sp)
 8b6:	7b42                	ld	s6,48(sp)
 8b8:	7ba2                	ld	s7,40(sp)
 8ba:	7c02                	ld	s8,32(sp)
 8bc:	6ce2                	ld	s9,24(sp)
 8be:	bf55                	j	872 <snprintf+0x140>
    return -1;
 8c0:	54fd                	li	s1,-1
 8c2:	bf45                	j	872 <snprintf+0x140>
 8c4:	6946                	ld	s2,80(sp)
 8c6:	69a6                	ld	s3,72(sp)
 8c8:	6a06                	ld	s4,64(sp)
 8ca:	7ae2                	ld	s5,56(sp)
 8cc:	7b42                	ld	s6,48(sp)
 8ce:	7ba2                	ld	s7,40(sp)
 8d0:	7c02                	ld	s8,32(sp)
 8d2:	6ce2                	ld	s9,24(sp)
 8d4:	bf79                	j	872 <snprintf+0x140>
 8d6:	6946                	ld	s2,80(sp)
 8d8:	69a6                	ld	s3,72(sp)
 8da:	6a06                	ld	s4,64(sp)
 8dc:	7ae2                	ld	s5,56(sp)
 8de:	7b42                	ld	s6,48(sp)
 8e0:	7ba2                	ld	s7,40(sp)
 8e2:	7c02                	ld	s8,32(sp)
 8e4:	6ce2                	ld	s9,24(sp)
 8e6:	b771                	j	872 <snprintf+0x140>
 8e8:	6946                	ld	s2,80(sp)
 8ea:	69a6                	ld	s3,72(sp)
 8ec:	6a06                	ld	s4,64(sp)
 8ee:	7ae2                	ld	s5,56(sp)
 8f0:	7b42                	ld	s6,48(sp)
 8f2:	7ba2                	ld	s7,40(sp)
 8f4:	7c02                	ld	s8,32(sp)
 8f6:	6ce2                	ld	s9,24(sp)
 8f8:	bfad                	j	872 <snprintf+0x140>

00000000000008fa <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 8fa:	1141                	add	sp,sp,-16
 8fc:	e422                	sd	s0,8(sp)
 8fe:	0800                	add	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 900:	ff050693          	add	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 904:	00000797          	auipc	a5,0x0
 908:	1f47b783          	ld	a5,500(a5) # af8 <freep>
 90c:	a02d                	j	936 <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 90e:	4618                	lw	a4,8(a2)
 910:	9f2d                	addw	a4,a4,a1
 912:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 916:	6398                	ld	a4,0(a5)
 918:	6310                	ld	a2,0(a4)
 91a:	a83d                	j	958 <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 91c:	ff852703          	lw	a4,-8(a0)
 920:	9f31                	addw	a4,a4,a2
 922:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 924:	ff053683          	ld	a3,-16(a0)
 928:	a091                	j	96c <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 92a:	6398                	ld	a4,0(a5)
 92c:	00e7e463          	bltu	a5,a4,934 <free+0x3a>
 930:	00e6ea63          	bltu	a3,a4,944 <free+0x4a>
{
 934:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 936:	fed7fae3          	bgeu	a5,a3,92a <free+0x30>
 93a:	6398                	ld	a4,0(a5)
 93c:	00e6e463          	bltu	a3,a4,944 <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 940:	fee7eae3          	bltu	a5,a4,934 <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 944:	ff852583          	lw	a1,-8(a0)
 948:	6390                	ld	a2,0(a5)
 94a:	02059813          	sll	a6,a1,0x20
 94e:	01c85713          	srl	a4,a6,0x1c
 952:	9736                	add	a4,a4,a3
 954:	fae60de3          	beq	a2,a4,90e <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 958:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 95c:	4790                	lw	a2,8(a5)
 95e:	02061593          	sll	a1,a2,0x20
 962:	01c5d713          	srl	a4,a1,0x1c
 966:	973e                	add	a4,a4,a5
 968:	fae68ae3          	beq	a3,a4,91c <free+0x22>
    p->s.ptr = bp->s.ptr;
 96c:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 96e:	00000717          	auipc	a4,0x0
 972:	18f73523          	sd	a5,394(a4) # af8 <freep>
}
 976:	6422                	ld	s0,8(sp)
 978:	0141                	add	sp,sp,16
 97a:	8082                	ret

000000000000097c <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 97c:	7139                	add	sp,sp,-64
 97e:	fc06                	sd	ra,56(sp)
 980:	f822                	sd	s0,48(sp)
 982:	f426                	sd	s1,40(sp)
 984:	ec4e                	sd	s3,24(sp)
 986:	0080                	add	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 988:	02051493          	sll	s1,a0,0x20
 98c:	9081                	srl	s1,s1,0x20
 98e:	04bd                	add	s1,s1,15
 990:	8091                	srl	s1,s1,0x4
 992:	0014899b          	addw	s3,s1,1
 996:	0485                	add	s1,s1,1
  if((prevp = freep) == 0){
 998:	00000517          	auipc	a0,0x0
 99c:	16053503          	ld	a0,352(a0) # af8 <freep>
 9a0:	c915                	beqz	a0,9d4 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 9a2:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 9a4:	4798                	lw	a4,8(a5)
 9a6:	08977e63          	bgeu	a4,s1,a42 <malloc+0xc6>
 9aa:	f04a                	sd	s2,32(sp)
 9ac:	e852                	sd	s4,16(sp)
 9ae:	e456                	sd	s5,8(sp)
 9b0:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 9b2:	8a4e                	mv	s4,s3
 9b4:	0009871b          	sext.w	a4,s3
 9b8:	6685                	lui	a3,0x1
 9ba:	00d77363          	bgeu	a4,a3,9c0 <malloc+0x44>
 9be:	6a05                	lui	s4,0x1
 9c0:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 9c4:	004a1a1b          	sllw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 9c8:	00000917          	auipc	s2,0x0
 9cc:	13090913          	add	s2,s2,304 # af8 <freep>
  if(p == (char*)-1)
 9d0:	5afd                	li	s5,-1
 9d2:	a091                	j	a16 <malloc+0x9a>
 9d4:	f04a                	sd	s2,32(sp)
 9d6:	e852                	sd	s4,16(sp)
 9d8:	e456                	sd	s5,8(sp)
 9da:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 9dc:	00000797          	auipc	a5,0x0
 9e0:	12478793          	add	a5,a5,292 # b00 <base>
 9e4:	00000717          	auipc	a4,0x0
 9e8:	10f73a23          	sd	a5,276(a4) # af8 <freep>
 9ec:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 9ee:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 9f2:	b7c1                	j	9b2 <malloc+0x36>
        prevp->s.ptr = p->s.ptr;
 9f4:	6398                	ld	a4,0(a5)
 9f6:	e118                	sd	a4,0(a0)
 9f8:	a08d                	j	a5a <malloc+0xde>
  hp->s.size = nu;
 9fa:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 9fe:	0541                	add	a0,a0,16
 a00:	00000097          	auipc	ra,0x0
 a04:	efa080e7          	jalr	-262(ra) # 8fa <free>
  return freep;
 a08:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 a0c:	c13d                	beqz	a0,a72 <malloc+0xf6>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a0e:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 a10:	4798                	lw	a4,8(a5)
 a12:	02977463          	bgeu	a4,s1,a3a <malloc+0xbe>
    if(p == freep)
 a16:	00093703          	ld	a4,0(s2)
 a1a:	853e                	mv	a0,a5
 a1c:	fef719e3          	bne	a4,a5,a0e <malloc+0x92>
  p = sbrk(nu * sizeof(Header));
 a20:	8552                	mv	a0,s4
 a22:	00000097          	auipc	ra,0x0
 a26:	92a080e7          	jalr	-1750(ra) # 34c <sbrk>
  if(p == (char*)-1)
 a2a:	fd5518e3          	bne	a0,s5,9fa <malloc+0x7e>
        return 0;
 a2e:	4501                	li	a0,0
 a30:	7902                	ld	s2,32(sp)
 a32:	6a42                	ld	s4,16(sp)
 a34:	6aa2                	ld	s5,8(sp)
 a36:	6b02                	ld	s6,0(sp)
 a38:	a03d                	j	a66 <malloc+0xea>
 a3a:	7902                	ld	s2,32(sp)
 a3c:	6a42                	ld	s4,16(sp)
 a3e:	6aa2                	ld	s5,8(sp)
 a40:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 a42:	fae489e3          	beq	s1,a4,9f4 <malloc+0x78>
        p->s.size -= nunits;
 a46:	4137073b          	subw	a4,a4,s3
 a4a:	c798                	sw	a4,8(a5)
        p += p->s.size;
 a4c:	02071693          	sll	a3,a4,0x20
 a50:	01c6d713          	srl	a4,a3,0x1c
 a54:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 a56:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 a5a:	00000717          	auipc	a4,0x0
 a5e:	08a73f23          	sd	a0,158(a4) # af8 <freep>
      return (void*)(p + 1);
 a62:	01078513          	add	a0,a5,16
  }
}
 a66:	70e2                	ld	ra,56(sp)
 a68:	7442                	ld	s0,48(sp)
 a6a:	74a2                	ld	s1,40(sp)
 a6c:	69e2                	ld	s3,24(sp)
 a6e:	6121                	add	sp,sp,64
 a70:	8082                	ret
 a72:	7902                	ld	s2,32(sp)
 a74:	6a42                	ld	s4,16(sp)
 a76:	6aa2                	ld	s5,8(sp)
 a78:	6b02                	ld	s6,0(sp)
 a7a:	b7f5                	j	a66 <malloc+0xea>
