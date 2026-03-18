
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
   a:	02a7df63          	bge	a5,a0,48 <main+0x48>
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
  28:	00000097          	auipc	ra,0x0
  2c:	1e0080e7          	jalr	480(ra) # 208 <atoi>
  30:	00000097          	auipc	ra,0x0
  34:	302080e7          	jalr	770(ra) # 332 <kill>
  for(i=1; i<argc; i++)
  38:	04a1                	add	s1,s1,8
  3a:	ff2496e3          	bne	s1,s2,26 <main+0x26>
  exit(0);
  3e:	4501                	li	a0,0
  40:	00000097          	auipc	ra,0x0
  44:	2c2080e7          	jalr	706(ra) # 302 <exit>
  48:	e426                	sd	s1,8(sp)
  4a:	e04a                	sd	s2,0(sp)
    fprintf(2, "usage: kill pid...\n");
  4c:	00001597          	auipc	a1,0x1
  50:	a7458593          	add	a1,a1,-1420 # ac0 <malloc+0x106>
  54:	4509                	li	a0,2
  56:	00000097          	auipc	ra,0x0
  5a:	6b6080e7          	jalr	1718(ra) # 70c <fprintf>
    exit(1);
  5e:	4505                	li	a0,1
  60:	00000097          	auipc	ra,0x0
  64:	2a2080e7          	jalr	674(ra) # 302 <exit>

0000000000000068 <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
  68:	1141                	add	sp,sp,-16
  6a:	e422                	sd	s0,8(sp)
  6c:	0800                	add	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  6e:	87aa                	mv	a5,a0
  70:	0585                	add	a1,a1,1
  72:	0785                	add	a5,a5,1
  74:	fff5c703          	lbu	a4,-1(a1)
  78:	fee78fa3          	sb	a4,-1(a5)
  7c:	fb75                	bnez	a4,70 <strcpy+0x8>
    ;
  return os;
}
  7e:	6422                	ld	s0,8(sp)
  80:	0141                	add	sp,sp,16
  82:	8082                	ret

0000000000000084 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  84:	1141                	add	sp,sp,-16
  86:	e422                	sd	s0,8(sp)
  88:	0800                	add	s0,sp,16
  while(*p && *p == *q)
  8a:	00054783          	lbu	a5,0(a0)
  8e:	cb91                	beqz	a5,a2 <strcmp+0x1e>
  90:	0005c703          	lbu	a4,0(a1)
  94:	00f71763          	bne	a4,a5,a2 <strcmp+0x1e>
    p++, q++;
  98:	0505                	add	a0,a0,1
  9a:	0585                	add	a1,a1,1
  while(*p && *p == *q)
  9c:	00054783          	lbu	a5,0(a0)
  a0:	fbe5                	bnez	a5,90 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
  a2:	0005c503          	lbu	a0,0(a1)
}
  a6:	40a7853b          	subw	a0,a5,a0
  aa:	6422                	ld	s0,8(sp)
  ac:	0141                	add	sp,sp,16
  ae:	8082                	ret

00000000000000b0 <strlen>:

uint
strlen(const char *s)
{
  b0:	1141                	add	sp,sp,-16
  b2:	e422                	sd	s0,8(sp)
  b4:	0800                	add	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
  b6:	00054783          	lbu	a5,0(a0)
  ba:	cf91                	beqz	a5,d6 <strlen+0x26>
  bc:	0505                	add	a0,a0,1
  be:	87aa                	mv	a5,a0
  c0:	86be                	mv	a3,a5
  c2:	0785                	add	a5,a5,1
  c4:	fff7c703          	lbu	a4,-1(a5)
  c8:	ff65                	bnez	a4,c0 <strlen+0x10>
  ca:	40a6853b          	subw	a0,a3,a0
  ce:	2505                	addw	a0,a0,1
    ;
  return n;
}
  d0:	6422                	ld	s0,8(sp)
  d2:	0141                	add	sp,sp,16
  d4:	8082                	ret
  for(n = 0; s[n]; n++)
  d6:	4501                	li	a0,0
  d8:	bfe5                	j	d0 <strlen+0x20>

00000000000000da <strcat>:

char *
strcat(char *dst, char *src)
{
  da:	1141                	add	sp,sp,-16
  dc:	e422                	sd	s0,8(sp)
  de:	0800                	add	s0,sp,16
  char *s = dst;
  while (*dst)
  e0:	00054783          	lbu	a5,0(a0)
  e4:	c385                	beqz	a5,104 <strcat+0x2a>
  e6:	87aa                	mv	a5,a0
    dst++;
  e8:	0785                	add	a5,a5,1
  while (*dst)
  ea:	0007c703          	lbu	a4,0(a5)
  ee:	ff6d                	bnez	a4,e8 <strcat+0xe>
  while ((*dst++ = *src++) != 0);
  f0:	0585                	add	a1,a1,1
  f2:	0785                	add	a5,a5,1
  f4:	fff5c703          	lbu	a4,-1(a1)
  f8:	fee78fa3          	sb	a4,-1(a5)
  fc:	fb75                	bnez	a4,f0 <strcat+0x16>

  return s;
}
  fe:	6422                	ld	s0,8(sp)
 100:	0141                	add	sp,sp,16
 102:	8082                	ret
  while (*dst)
 104:	87aa                	mv	a5,a0
 106:	b7ed                	j	f0 <strcat+0x16>

0000000000000108 <memset>:

void*
memset(void *dst, int c, uint n)
{
 108:	1141                	add	sp,sp,-16
 10a:	e422                	sd	s0,8(sp)
 10c:	0800                	add	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 10e:	ca19                	beqz	a2,124 <memset+0x1c>
 110:	87aa                	mv	a5,a0
 112:	1602                	sll	a2,a2,0x20
 114:	9201                	srl	a2,a2,0x20
 116:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 11a:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 11e:	0785                	add	a5,a5,1
 120:	fee79de3          	bne	a5,a4,11a <memset+0x12>
  }
  return dst;
}
 124:	6422                	ld	s0,8(sp)
 126:	0141                	add	sp,sp,16
 128:	8082                	ret

000000000000012a <strchr>:

char*
strchr(const char *s, char c)
{
 12a:	1141                	add	sp,sp,-16
 12c:	e422                	sd	s0,8(sp)
 12e:	0800                	add	s0,sp,16
  for(; *s; s++)
 130:	00054783          	lbu	a5,0(a0)
 134:	cb99                	beqz	a5,14a <strchr+0x20>
    if(*s == c)
 136:	00f58763          	beq	a1,a5,144 <strchr+0x1a>
  for(; *s; s++)
 13a:	0505                	add	a0,a0,1
 13c:	00054783          	lbu	a5,0(a0)
 140:	fbfd                	bnez	a5,136 <strchr+0xc>
      return (char*)s;
  return 0;
 142:	4501                	li	a0,0
}
 144:	6422                	ld	s0,8(sp)
 146:	0141                	add	sp,sp,16
 148:	8082                	ret
  return 0;
 14a:	4501                	li	a0,0
 14c:	bfe5                	j	144 <strchr+0x1a>

000000000000014e <gets>:

char*
gets(char *buf, int max)
{
 14e:	711d                	add	sp,sp,-96
 150:	ec86                	sd	ra,88(sp)
 152:	e8a2                	sd	s0,80(sp)
 154:	e4a6                	sd	s1,72(sp)
 156:	e0ca                	sd	s2,64(sp)
 158:	fc4e                	sd	s3,56(sp)
 15a:	f852                	sd	s4,48(sp)
 15c:	f456                	sd	s5,40(sp)
 15e:	f05a                	sd	s6,32(sp)
 160:	ec5e                	sd	s7,24(sp)
 162:	1080                	add	s0,sp,96
 164:	8baa                	mv	s7,a0
 166:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 168:	892a                	mv	s2,a0
 16a:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 16c:	4aa9                	li	s5,10
 16e:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 170:	89a6                	mv	s3,s1
 172:	2485                	addw	s1,s1,1
 174:	0344d863          	bge	s1,s4,1a4 <gets+0x56>
    cc = read(0, &c, 1);
 178:	4605                	li	a2,1
 17a:	faf40593          	add	a1,s0,-81
 17e:	4501                	li	a0,0
 180:	00000097          	auipc	ra,0x0
 184:	19a080e7          	jalr	410(ra) # 31a <read>
    if(cc < 1)
 188:	00a05e63          	blez	a0,1a4 <gets+0x56>
    buf[i++] = c;
 18c:	faf44783          	lbu	a5,-81(s0)
 190:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 194:	01578763          	beq	a5,s5,1a2 <gets+0x54>
 198:	0905                	add	s2,s2,1
 19a:	fd679be3          	bne	a5,s6,170 <gets+0x22>
    buf[i++] = c;
 19e:	89a6                	mv	s3,s1
 1a0:	a011                	j	1a4 <gets+0x56>
 1a2:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 1a4:	99de                	add	s3,s3,s7
 1a6:	00098023          	sb	zero,0(s3)
  return buf;
}
 1aa:	855e                	mv	a0,s7
 1ac:	60e6                	ld	ra,88(sp)
 1ae:	6446                	ld	s0,80(sp)
 1b0:	64a6                	ld	s1,72(sp)
 1b2:	6906                	ld	s2,64(sp)
 1b4:	79e2                	ld	s3,56(sp)
 1b6:	7a42                	ld	s4,48(sp)
 1b8:	7aa2                	ld	s5,40(sp)
 1ba:	7b02                	ld	s6,32(sp)
 1bc:	6be2                	ld	s7,24(sp)
 1be:	6125                	add	sp,sp,96
 1c0:	8082                	ret

00000000000001c2 <stat>:

int
stat(const char *n, struct stat *st)
{
 1c2:	1101                	add	sp,sp,-32
 1c4:	ec06                	sd	ra,24(sp)
 1c6:	e822                	sd	s0,16(sp)
 1c8:	e04a                	sd	s2,0(sp)
 1ca:	1000                	add	s0,sp,32
 1cc:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1ce:	4581                	li	a1,0
 1d0:	00000097          	auipc	ra,0x0
 1d4:	172080e7          	jalr	370(ra) # 342 <open>
  if(fd < 0)
 1d8:	02054663          	bltz	a0,204 <stat+0x42>
 1dc:	e426                	sd	s1,8(sp)
 1de:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 1e0:	85ca                	mv	a1,s2
 1e2:	00000097          	auipc	ra,0x0
 1e6:	178080e7          	jalr	376(ra) # 35a <fstat>
 1ea:	892a                	mv	s2,a0
  close(fd);
 1ec:	8526                	mv	a0,s1
 1ee:	00000097          	auipc	ra,0x0
 1f2:	13c080e7          	jalr	316(ra) # 32a <close>
  return r;
 1f6:	64a2                	ld	s1,8(sp)
}
 1f8:	854a                	mv	a0,s2
 1fa:	60e2                	ld	ra,24(sp)
 1fc:	6442                	ld	s0,16(sp)
 1fe:	6902                	ld	s2,0(sp)
 200:	6105                	add	sp,sp,32
 202:	8082                	ret
    return -1;
 204:	597d                	li	s2,-1
 206:	bfcd                	j	1f8 <stat+0x36>

0000000000000208 <atoi>:

int
atoi(const char *s)
{
 208:	1141                	add	sp,sp,-16
 20a:	e422                	sd	s0,8(sp)
 20c:	0800                	add	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 20e:	00054683          	lbu	a3,0(a0)
 212:	fd06879b          	addw	a5,a3,-48
 216:	0ff7f793          	zext.b	a5,a5
 21a:	4625                	li	a2,9
 21c:	02f66863          	bltu	a2,a5,24c <atoi+0x44>
 220:	872a                	mv	a4,a0
  n = 0;
 222:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 224:	0705                	add	a4,a4,1
 226:	0025179b          	sllw	a5,a0,0x2
 22a:	9fa9                	addw	a5,a5,a0
 22c:	0017979b          	sllw	a5,a5,0x1
 230:	9fb5                	addw	a5,a5,a3
 232:	fd07851b          	addw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 236:	00074683          	lbu	a3,0(a4)
 23a:	fd06879b          	addw	a5,a3,-48
 23e:	0ff7f793          	zext.b	a5,a5
 242:	fef671e3          	bgeu	a2,a5,224 <atoi+0x1c>
  return n;
}
 246:	6422                	ld	s0,8(sp)
 248:	0141                	add	sp,sp,16
 24a:	8082                	ret
  n = 0;
 24c:	4501                	li	a0,0
 24e:	bfe5                	j	246 <atoi+0x3e>

0000000000000250 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 250:	1141                	add	sp,sp,-16
 252:	e422                	sd	s0,8(sp)
 254:	0800                	add	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 256:	02b57463          	bgeu	a0,a1,27e <memmove+0x2e>
    while(n-- > 0)
 25a:	00c05f63          	blez	a2,278 <memmove+0x28>
 25e:	1602                	sll	a2,a2,0x20
 260:	9201                	srl	a2,a2,0x20
 262:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 266:	872a                	mv	a4,a0
      *dst++ = *src++;
 268:	0585                	add	a1,a1,1
 26a:	0705                	add	a4,a4,1
 26c:	fff5c683          	lbu	a3,-1(a1)
 270:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 274:	fef71ae3          	bne	a4,a5,268 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 278:	6422                	ld	s0,8(sp)
 27a:	0141                	add	sp,sp,16
 27c:	8082                	ret
    dst += n;
 27e:	00c50733          	add	a4,a0,a2
    src += n;
 282:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 284:	fec05ae3          	blez	a2,278 <memmove+0x28>
 288:	fff6079b          	addw	a5,a2,-1
 28c:	1782                	sll	a5,a5,0x20
 28e:	9381                	srl	a5,a5,0x20
 290:	fff7c793          	not	a5,a5
 294:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 296:	15fd                	add	a1,a1,-1
 298:	177d                	add	a4,a4,-1
 29a:	0005c683          	lbu	a3,0(a1)
 29e:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 2a2:	fee79ae3          	bne	a5,a4,296 <memmove+0x46>
 2a6:	bfc9                	j	278 <memmove+0x28>

00000000000002a8 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 2a8:	1141                	add	sp,sp,-16
 2aa:	e422                	sd	s0,8(sp)
 2ac:	0800                	add	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 2ae:	ca05                	beqz	a2,2de <memcmp+0x36>
 2b0:	fff6069b          	addw	a3,a2,-1
 2b4:	1682                	sll	a3,a3,0x20
 2b6:	9281                	srl	a3,a3,0x20
 2b8:	0685                	add	a3,a3,1
 2ba:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 2bc:	00054783          	lbu	a5,0(a0)
 2c0:	0005c703          	lbu	a4,0(a1)
 2c4:	00e79863          	bne	a5,a4,2d4 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 2c8:	0505                	add	a0,a0,1
    p2++;
 2ca:	0585                	add	a1,a1,1
  while (n-- > 0) {
 2cc:	fed518e3          	bne	a0,a3,2bc <memcmp+0x14>
  }
  return 0;
 2d0:	4501                	li	a0,0
 2d2:	a019                	j	2d8 <memcmp+0x30>
      return *p1 - *p2;
 2d4:	40e7853b          	subw	a0,a5,a4
}
 2d8:	6422                	ld	s0,8(sp)
 2da:	0141                	add	sp,sp,16
 2dc:	8082                	ret
  return 0;
 2de:	4501                	li	a0,0
 2e0:	bfe5                	j	2d8 <memcmp+0x30>

00000000000002e2 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 2e2:	1141                	add	sp,sp,-16
 2e4:	e406                	sd	ra,8(sp)
 2e6:	e022                	sd	s0,0(sp)
 2e8:	0800                	add	s0,sp,16
  return memmove(dst, src, n);
 2ea:	00000097          	auipc	ra,0x0
 2ee:	f66080e7          	jalr	-154(ra) # 250 <memmove>
}
 2f2:	60a2                	ld	ra,8(sp)
 2f4:	6402                	ld	s0,0(sp)
 2f6:	0141                	add	sp,sp,16
 2f8:	8082                	ret

00000000000002fa <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 2fa:	4885                	li	a7,1
 ecall
 2fc:	00000073          	ecall
 ret
 300:	8082                	ret

0000000000000302 <exit>:
.global exit
exit:
 li a7, SYS_exit
 302:	4889                	li	a7,2
 ecall
 304:	00000073          	ecall
 ret
 308:	8082                	ret

000000000000030a <wait>:
.global wait
wait:
 li a7, SYS_wait
 30a:	488d                	li	a7,3
 ecall
 30c:	00000073          	ecall
 ret
 310:	8082                	ret

0000000000000312 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 312:	4891                	li	a7,4
 ecall
 314:	00000073          	ecall
 ret
 318:	8082                	ret

000000000000031a <read>:
.global read
read:
 li a7, SYS_read
 31a:	4895                	li	a7,5
 ecall
 31c:	00000073          	ecall
 ret
 320:	8082                	ret

0000000000000322 <write>:
.global write
write:
 li a7, SYS_write
 322:	48c1                	li	a7,16
 ecall
 324:	00000073          	ecall
 ret
 328:	8082                	ret

000000000000032a <close>:
.global close
close:
 li a7, SYS_close
 32a:	48d5                	li	a7,21
 ecall
 32c:	00000073          	ecall
 ret
 330:	8082                	ret

0000000000000332 <kill>:
.global kill
kill:
 li a7, SYS_kill
 332:	4899                	li	a7,6
 ecall
 334:	00000073          	ecall
 ret
 338:	8082                	ret

000000000000033a <exec>:
.global exec
exec:
 li a7, SYS_exec
 33a:	489d                	li	a7,7
 ecall
 33c:	00000073          	ecall
 ret
 340:	8082                	ret

0000000000000342 <open>:
.global open
open:
 li a7, SYS_open
 342:	48bd                	li	a7,15
 ecall
 344:	00000073          	ecall
 ret
 348:	8082                	ret

000000000000034a <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 34a:	48c5                	li	a7,17
 ecall
 34c:	00000073          	ecall
 ret
 350:	8082                	ret

0000000000000352 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 352:	48c9                	li	a7,18
 ecall
 354:	00000073          	ecall
 ret
 358:	8082                	ret

000000000000035a <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 35a:	48a1                	li	a7,8
 ecall
 35c:	00000073          	ecall
 ret
 360:	8082                	ret

0000000000000362 <link>:
.global link
link:
 li a7, SYS_link
 362:	48cd                	li	a7,19
 ecall
 364:	00000073          	ecall
 ret
 368:	8082                	ret

000000000000036a <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 36a:	48d1                	li	a7,20
 ecall
 36c:	00000073          	ecall
 ret
 370:	8082                	ret

0000000000000372 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 372:	48a5                	li	a7,9
 ecall
 374:	00000073          	ecall
 ret
 378:	8082                	ret

000000000000037a <dup>:
.global dup
dup:
 li a7, SYS_dup
 37a:	48a9                	li	a7,10
 ecall
 37c:	00000073          	ecall
 ret
 380:	8082                	ret

0000000000000382 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 382:	48ad                	li	a7,11
 ecall
 384:	00000073          	ecall
 ret
 388:	8082                	ret

000000000000038a <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 38a:	48b1                	li	a7,12
 ecall
 38c:	00000073          	ecall
 ret
 390:	8082                	ret

0000000000000392 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 392:	48b5                	li	a7,13
 ecall
 394:	00000073          	ecall
 ret
 398:	8082                	ret

000000000000039a <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 39a:	48b9                	li	a7,14
 ecall
 39c:	00000073          	ecall
 ret
 3a0:	8082                	ret

00000000000003a2 <uconnect>:
.global uconnect
uconnect:
 li a7, SYS_uconnect
 3a2:	48f5                	li	a7,29
 ecall
 3a4:	00000073          	ecall
 ret
 3a8:	8082                	ret

00000000000003aa <socket>:
.global socket
socket:
 li a7, SYS_socket
 3aa:	48f9                	li	a7,30
 ecall
 3ac:	00000073          	ecall
 ret
 3b0:	8082                	ret

00000000000003b2 <bind>:
.global bind
bind:
 li a7, SYS_bind
 3b2:	48fd                	li	a7,31
 ecall
 3b4:	00000073          	ecall
 ret
 3b8:	8082                	ret

00000000000003ba <listen>:
.global listen
listen:
 li a7, SYS_listen
 3ba:	02000893          	li	a7,32
 ecall
 3be:	00000073          	ecall
 ret
 3c2:	8082                	ret

00000000000003c4 <accept>:
.global accept
accept:
 li a7, SYS_accept
 3c4:	02100893          	li	a7,33
 ecall
 3c8:	00000073          	ecall
 ret
 3cc:	8082                	ret

00000000000003ce <connect>:
.global connect
connect:
 li a7, SYS_connect
 3ce:	02200893          	li	a7,34
 ecall
 3d2:	00000073          	ecall
 ret
 3d6:	8082                	ret

00000000000003d8 <sprintint>:
  return 1;
}

static int
sprintint(char *s, int xx, int base, int sign)
{
 3d8:	1101                	add	sp,sp,-32
 3da:	ec22                	sd	s0,24(sp)
 3dc:	1000                	add	s0,sp,32
 3de:	882a                	mv	a6,a0
  char buf[16];
  int i, n;
  uint x;

  if(sign && (sign = xx < 0))
 3e0:	c299                	beqz	a3,3e6 <sprintint+0xe>
 3e2:	0805c263          	bltz	a1,466 <sprintint+0x8e>
    x = -xx;
  else
    x = xx;
 3e6:	2581                	sext.w	a1,a1
 3e8:	4301                	li	t1,0

  i = 0;
 3ea:	fe040713          	add	a4,s0,-32
 3ee:	4501                	li	a0,0
  do {
    buf[i++] = digits[x % base];
 3f0:	2601                	sext.w	a2,a2
 3f2:	00000697          	auipc	a3,0x0
 3f6:	74668693          	add	a3,a3,1862 # b38 <digits>
 3fa:	88aa                	mv	a7,a0
 3fc:	2505                	addw	a0,a0,1
 3fe:	02c5f7bb          	remuw	a5,a1,a2
 402:	1782                	sll	a5,a5,0x20
 404:	9381                	srl	a5,a5,0x20
 406:	97b6                	add	a5,a5,a3
 408:	0007c783          	lbu	a5,0(a5)
 40c:	00f70023          	sb	a5,0(a4)
  } while((x /= base) != 0);
 410:	0005879b          	sext.w	a5,a1
 414:	02c5d5bb          	divuw	a1,a1,a2
 418:	0705                	add	a4,a4,1
 41a:	fec7f0e3          	bgeu	a5,a2,3fa <sprintint+0x22>

  if(sign)
 41e:	00030b63          	beqz	t1,434 <sprintint+0x5c>
    buf[i++] = '-';
 422:	ff050793          	add	a5,a0,-16
 426:	97a2                	add	a5,a5,s0
 428:	02d00713          	li	a4,45
 42c:	fee78823          	sb	a4,-16(a5)
 430:	0028851b          	addw	a0,a7,2

  n = 0;
  while(--i >= 0)
 434:	02a05d63          	blez	a0,46e <sprintint+0x96>
 438:	fe040793          	add	a5,s0,-32
 43c:	00a78733          	add	a4,a5,a0
 440:	87c2                	mv	a5,a6
 442:	00180613          	add	a2,a6,1
 446:	fff5069b          	addw	a3,a0,-1
 44a:	1682                	sll	a3,a3,0x20
 44c:	9281                	srl	a3,a3,0x20
 44e:	9636                	add	a2,a2,a3
  *s = c;
 450:	fff74683          	lbu	a3,-1(a4)
 454:	00d78023          	sb	a3,0(a5)
  while(--i >= 0)
 458:	177d                	add	a4,a4,-1
 45a:	0785                	add	a5,a5,1
 45c:	fec79ae3          	bne	a5,a2,450 <sprintint+0x78>
    n += sputc(s+n, buf[i]);
  return n;
}
 460:	6462                	ld	s0,24(sp)
 462:	6105                	add	sp,sp,32
 464:	8082                	ret
    x = -xx;
 466:	40b005bb          	negw	a1,a1
  if(sign && (sign = xx < 0))
 46a:	4305                	li	t1,1
    x = -xx;
 46c:	bfbd                	j	3ea <sprintint+0x12>
  while(--i >= 0)
 46e:	4501                	li	a0,0
 470:	bfc5                	j	460 <sprintint+0x88>

0000000000000472 <putc>:
{
 472:	1101                	add	sp,sp,-32
 474:	ec06                	sd	ra,24(sp)
 476:	e822                	sd	s0,16(sp)
 478:	1000                	add	s0,sp,32
 47a:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 47e:	4605                	li	a2,1
 480:	fef40593          	add	a1,s0,-17
 484:	00000097          	auipc	ra,0x0
 488:	e9e080e7          	jalr	-354(ra) # 322 <write>
}
 48c:	60e2                	ld	ra,24(sp)
 48e:	6442                	ld	s0,16(sp)
 490:	6105                	add	sp,sp,32
 492:	8082                	ret

0000000000000494 <printint>:
{
 494:	7139                	add	sp,sp,-64
 496:	fc06                	sd	ra,56(sp)
 498:	f822                	sd	s0,48(sp)
 49a:	f426                	sd	s1,40(sp)
 49c:	0080                	add	s0,sp,64
 49e:	84aa                	mv	s1,a0
  if(sgn && xx < 0){
 4a0:	c299                	beqz	a3,4a6 <printint+0x12>
 4a2:	0805cb63          	bltz	a1,538 <printint+0xa4>
    x = xx;
 4a6:	2581                	sext.w	a1,a1
  neg = 0;
 4a8:	4881                	li	a7,0
 4aa:	fc040693          	add	a3,s0,-64
  i = 0;
 4ae:	4701                	li	a4,0
    buf[i++] = digits[x % base];
 4b0:	2601                	sext.w	a2,a2
 4b2:	00000517          	auipc	a0,0x0
 4b6:	68650513          	add	a0,a0,1670 # b38 <digits>
 4ba:	883a                	mv	a6,a4
 4bc:	2705                	addw	a4,a4,1
 4be:	02c5f7bb          	remuw	a5,a1,a2
 4c2:	1782                	sll	a5,a5,0x20
 4c4:	9381                	srl	a5,a5,0x20
 4c6:	97aa                	add	a5,a5,a0
 4c8:	0007c783          	lbu	a5,0(a5)
 4cc:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 4d0:	0005879b          	sext.w	a5,a1
 4d4:	02c5d5bb          	divuw	a1,a1,a2
 4d8:	0685                	add	a3,a3,1
 4da:	fec7f0e3          	bgeu	a5,a2,4ba <printint+0x26>
  if(neg)
 4de:	00088c63          	beqz	a7,4f6 <printint+0x62>
    buf[i++] = '-';
 4e2:	fd070793          	add	a5,a4,-48
 4e6:	00878733          	add	a4,a5,s0
 4ea:	02d00793          	li	a5,45
 4ee:	fef70823          	sb	a5,-16(a4)
 4f2:	0028071b          	addw	a4,a6,2
  while(--i >= 0)
 4f6:	02e05c63          	blez	a4,52e <printint+0x9a>
 4fa:	f04a                	sd	s2,32(sp)
 4fc:	ec4e                	sd	s3,24(sp)
 4fe:	fc040793          	add	a5,s0,-64
 502:	00e78933          	add	s2,a5,a4
 506:	fff78993          	add	s3,a5,-1
 50a:	99ba                	add	s3,s3,a4
 50c:	377d                	addw	a4,a4,-1
 50e:	1702                	sll	a4,a4,0x20
 510:	9301                	srl	a4,a4,0x20
 512:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 516:	fff94583          	lbu	a1,-1(s2)
 51a:	8526                	mv	a0,s1
 51c:	00000097          	auipc	ra,0x0
 520:	f56080e7          	jalr	-170(ra) # 472 <putc>
  while(--i >= 0)
 524:	197d                	add	s2,s2,-1
 526:	ff3918e3          	bne	s2,s3,516 <printint+0x82>
 52a:	7902                	ld	s2,32(sp)
 52c:	69e2                	ld	s3,24(sp)
}
 52e:	70e2                	ld	ra,56(sp)
 530:	7442                	ld	s0,48(sp)
 532:	74a2                	ld	s1,40(sp)
 534:	6121                	add	sp,sp,64
 536:	8082                	ret
    x = -xx;
 538:	40b005bb          	negw	a1,a1
    neg = 1;
 53c:	4885                	li	a7,1
    x = -xx;
 53e:	b7b5                	j	4aa <printint+0x16>

0000000000000540 <vprintf>:
{
 540:	715d                	add	sp,sp,-80
 542:	e486                	sd	ra,72(sp)
 544:	e0a2                	sd	s0,64(sp)
 546:	f84a                	sd	s2,48(sp)
 548:	0880                	add	s0,sp,80
  for(i = 0; fmt[i]; i++){
 54a:	0005c903          	lbu	s2,0(a1)
 54e:	1a090a63          	beqz	s2,702 <vprintf+0x1c2>
 552:	fc26                	sd	s1,56(sp)
 554:	f44e                	sd	s3,40(sp)
 556:	f052                	sd	s4,32(sp)
 558:	ec56                	sd	s5,24(sp)
 55a:	e85a                	sd	s6,16(sp)
 55c:	e45e                	sd	s7,8(sp)
 55e:	8aaa                	mv	s5,a0
 560:	8bb2                	mv	s7,a2
 562:	00158493          	add	s1,a1,1
  state = 0;
 566:	4981                	li	s3,0
    } else if(state == '%'){
 568:	02500a13          	li	s4,37
 56c:	4b55                	li	s6,21
 56e:	a839                	j	58c <vprintf+0x4c>
        putc(fd, c);
 570:	85ca                	mv	a1,s2
 572:	8556                	mv	a0,s5
 574:	00000097          	auipc	ra,0x0
 578:	efe080e7          	jalr	-258(ra) # 472 <putc>
 57c:	a019                	j	582 <vprintf+0x42>
    } else if(state == '%'){
 57e:	01498d63          	beq	s3,s4,598 <vprintf+0x58>
  for(i = 0; fmt[i]; i++){
 582:	0485                	add	s1,s1,1
 584:	fff4c903          	lbu	s2,-1(s1)
 588:	16090763          	beqz	s2,6f6 <vprintf+0x1b6>
    if(state == 0){
 58c:	fe0999e3          	bnez	s3,57e <vprintf+0x3e>
      if(c == '%'){
 590:	ff4910e3          	bne	s2,s4,570 <vprintf+0x30>
        state = '%';
 594:	89d2                	mv	s3,s4
 596:	b7f5                	j	582 <vprintf+0x42>
      if(c == 'd'){
 598:	13490463          	beq	s2,s4,6c0 <vprintf+0x180>
 59c:	f9d9079b          	addw	a5,s2,-99
 5a0:	0ff7f793          	zext.b	a5,a5
 5a4:	12fb6763          	bltu	s6,a5,6d2 <vprintf+0x192>
 5a8:	f9d9079b          	addw	a5,s2,-99
 5ac:	0ff7f713          	zext.b	a4,a5
 5b0:	12eb6163          	bltu	s6,a4,6d2 <vprintf+0x192>
 5b4:	00271793          	sll	a5,a4,0x2
 5b8:	00000717          	auipc	a4,0x0
 5bc:	52870713          	add	a4,a4,1320 # ae0 <malloc+0x126>
 5c0:	97ba                	add	a5,a5,a4
 5c2:	439c                	lw	a5,0(a5)
 5c4:	97ba                	add	a5,a5,a4
 5c6:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 5c8:	008b8913          	add	s2,s7,8
 5cc:	4685                	li	a3,1
 5ce:	4629                	li	a2,10
 5d0:	000ba583          	lw	a1,0(s7)
 5d4:	8556                	mv	a0,s5
 5d6:	00000097          	auipc	ra,0x0
 5da:	ebe080e7          	jalr	-322(ra) # 494 <printint>
 5de:	8bca                	mv	s7,s2
      state = 0;
 5e0:	4981                	li	s3,0
 5e2:	b745                	j	582 <vprintf+0x42>
        printint(fd, va_arg(ap, uint64), 10, 0);
 5e4:	008b8913          	add	s2,s7,8
 5e8:	4681                	li	a3,0
 5ea:	4629                	li	a2,10
 5ec:	000ba583          	lw	a1,0(s7)
 5f0:	8556                	mv	a0,s5
 5f2:	00000097          	auipc	ra,0x0
 5f6:	ea2080e7          	jalr	-350(ra) # 494 <printint>
 5fa:	8bca                	mv	s7,s2
      state = 0;
 5fc:	4981                	li	s3,0
 5fe:	b751                	j	582 <vprintf+0x42>
        printint(fd, va_arg(ap, int), 16, 0);
 600:	008b8913          	add	s2,s7,8
 604:	4681                	li	a3,0
 606:	4641                	li	a2,16
 608:	000ba583          	lw	a1,0(s7)
 60c:	8556                	mv	a0,s5
 60e:	00000097          	auipc	ra,0x0
 612:	e86080e7          	jalr	-378(ra) # 494 <printint>
 616:	8bca                	mv	s7,s2
      state = 0;
 618:	4981                	li	s3,0
 61a:	b7a5                	j	582 <vprintf+0x42>
 61c:	e062                	sd	s8,0(sp)
        printptr(fd, va_arg(ap, uint64));
 61e:	008b8c13          	add	s8,s7,8
 622:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 626:	03000593          	li	a1,48
 62a:	8556                	mv	a0,s5
 62c:	00000097          	auipc	ra,0x0
 630:	e46080e7          	jalr	-442(ra) # 472 <putc>
  putc(fd, 'x');
 634:	07800593          	li	a1,120
 638:	8556                	mv	a0,s5
 63a:	00000097          	auipc	ra,0x0
 63e:	e38080e7          	jalr	-456(ra) # 472 <putc>
 642:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 644:	00000b97          	auipc	s7,0x0
 648:	4f4b8b93          	add	s7,s7,1268 # b38 <digits>
 64c:	03c9d793          	srl	a5,s3,0x3c
 650:	97de                	add	a5,a5,s7
 652:	0007c583          	lbu	a1,0(a5)
 656:	8556                	mv	a0,s5
 658:	00000097          	auipc	ra,0x0
 65c:	e1a080e7          	jalr	-486(ra) # 472 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 660:	0992                	sll	s3,s3,0x4
 662:	397d                	addw	s2,s2,-1
 664:	fe0914e3          	bnez	s2,64c <vprintf+0x10c>
        printptr(fd, va_arg(ap, uint64));
 668:	8be2                	mv	s7,s8
      state = 0;
 66a:	4981                	li	s3,0
 66c:	6c02                	ld	s8,0(sp)
 66e:	bf11                	j	582 <vprintf+0x42>
        s = va_arg(ap, char*);
 670:	008b8993          	add	s3,s7,8
 674:	000bb903          	ld	s2,0(s7)
        if(s == 0)
 678:	02090163          	beqz	s2,69a <vprintf+0x15a>
        while(*s != 0){
 67c:	00094583          	lbu	a1,0(s2)
 680:	c9a5                	beqz	a1,6f0 <vprintf+0x1b0>
          putc(fd, *s);
 682:	8556                	mv	a0,s5
 684:	00000097          	auipc	ra,0x0
 688:	dee080e7          	jalr	-530(ra) # 472 <putc>
          s++;
 68c:	0905                	add	s2,s2,1
        while(*s != 0){
 68e:	00094583          	lbu	a1,0(s2)
 692:	f9e5                	bnez	a1,682 <vprintf+0x142>
        s = va_arg(ap, char*);
 694:	8bce                	mv	s7,s3
      state = 0;
 696:	4981                	li	s3,0
 698:	b5ed                	j	582 <vprintf+0x42>
          s = "(null)";
 69a:	00000917          	auipc	s2,0x0
 69e:	43e90913          	add	s2,s2,1086 # ad8 <malloc+0x11e>
        while(*s != 0){
 6a2:	02800593          	li	a1,40
 6a6:	bff1                	j	682 <vprintf+0x142>
        putc(fd, va_arg(ap, uint));
 6a8:	008b8913          	add	s2,s7,8
 6ac:	000bc583          	lbu	a1,0(s7)
 6b0:	8556                	mv	a0,s5
 6b2:	00000097          	auipc	ra,0x0
 6b6:	dc0080e7          	jalr	-576(ra) # 472 <putc>
 6ba:	8bca                	mv	s7,s2
      state = 0;
 6bc:	4981                	li	s3,0
 6be:	b5d1                	j	582 <vprintf+0x42>
        putc(fd, c);
 6c0:	02500593          	li	a1,37
 6c4:	8556                	mv	a0,s5
 6c6:	00000097          	auipc	ra,0x0
 6ca:	dac080e7          	jalr	-596(ra) # 472 <putc>
      state = 0;
 6ce:	4981                	li	s3,0
 6d0:	bd4d                	j	582 <vprintf+0x42>
        putc(fd, '%');
 6d2:	02500593          	li	a1,37
 6d6:	8556                	mv	a0,s5
 6d8:	00000097          	auipc	ra,0x0
 6dc:	d9a080e7          	jalr	-614(ra) # 472 <putc>
        putc(fd, c);
 6e0:	85ca                	mv	a1,s2
 6e2:	8556                	mv	a0,s5
 6e4:	00000097          	auipc	ra,0x0
 6e8:	d8e080e7          	jalr	-626(ra) # 472 <putc>
      state = 0;
 6ec:	4981                	li	s3,0
 6ee:	bd51                	j	582 <vprintf+0x42>
        s = va_arg(ap, char*);
 6f0:	8bce                	mv	s7,s3
      state = 0;
 6f2:	4981                	li	s3,0
 6f4:	b579                	j	582 <vprintf+0x42>
 6f6:	74e2                	ld	s1,56(sp)
 6f8:	79a2                	ld	s3,40(sp)
 6fa:	7a02                	ld	s4,32(sp)
 6fc:	6ae2                	ld	s5,24(sp)
 6fe:	6b42                	ld	s6,16(sp)
 700:	6ba2                	ld	s7,8(sp)
}
 702:	60a6                	ld	ra,72(sp)
 704:	6406                	ld	s0,64(sp)
 706:	7942                	ld	s2,48(sp)
 708:	6161                	add	sp,sp,80
 70a:	8082                	ret

000000000000070c <fprintf>:
{
 70c:	715d                	add	sp,sp,-80
 70e:	ec06                	sd	ra,24(sp)
 710:	e822                	sd	s0,16(sp)
 712:	1000                	add	s0,sp,32
 714:	e010                	sd	a2,0(s0)
 716:	e414                	sd	a3,8(s0)
 718:	e818                	sd	a4,16(s0)
 71a:	ec1c                	sd	a5,24(s0)
 71c:	03043023          	sd	a6,32(s0)
 720:	03143423          	sd	a7,40(s0)
  va_start(ap, fmt);
 724:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 728:	8622                	mv	a2,s0
 72a:	00000097          	auipc	ra,0x0
 72e:	e16080e7          	jalr	-490(ra) # 540 <vprintf>
}
 732:	60e2                	ld	ra,24(sp)
 734:	6442                	ld	s0,16(sp)
 736:	6161                	add	sp,sp,80
 738:	8082                	ret

000000000000073a <printf>:
{
 73a:	711d                	add	sp,sp,-96
 73c:	ec06                	sd	ra,24(sp)
 73e:	e822                	sd	s0,16(sp)
 740:	1000                	add	s0,sp,32
 742:	e40c                	sd	a1,8(s0)
 744:	e810                	sd	a2,16(s0)
 746:	ec14                	sd	a3,24(s0)
 748:	f018                	sd	a4,32(s0)
 74a:	f41c                	sd	a5,40(s0)
 74c:	03043823          	sd	a6,48(s0)
 750:	03143c23          	sd	a7,56(s0)
  va_start(ap, fmt);
 754:	00840613          	add	a2,s0,8
 758:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 75c:	85aa                	mv	a1,a0
 75e:	4505                	li	a0,1
 760:	00000097          	auipc	ra,0x0
 764:	de0080e7          	jalr	-544(ra) # 540 <vprintf>
}
 768:	60e2                	ld	ra,24(sp)
 76a:	6442                	ld	s0,16(sp)
 76c:	6125                	add	sp,sp,96
 76e:	8082                	ret

0000000000000770 <snprintf>:

int
snprintf(char *buf, int sz, char *fmt, ...)
{
 770:	7135                	add	sp,sp,-160
 772:	f486                	sd	ra,104(sp)
 774:	f0a2                	sd	s0,96(sp)
 776:	eca6                	sd	s1,88(sp)
 778:	1880                	add	s0,sp,112
 77a:	e414                	sd	a3,8(s0)
 77c:	e818                	sd	a4,16(s0)
 77e:	ec1c                	sd	a5,24(s0)
 780:	03043023          	sd	a6,32(s0)
 784:	03143423          	sd	a7,40(s0)
  va_list ap;
  int i, c;
  int off = 0;
  char *s;

  if (fmt == 0)
 788:	16060b63          	beqz	a2,8fe <snprintf+0x18e>
 78c:	e8ca                	sd	s2,80(sp)
 78e:	e4ce                	sd	s3,72(sp)
 790:	fc56                	sd	s5,56(sp)
 792:	f85a                	sd	s6,48(sp)
 794:	8b2a                	mv	s6,a0
 796:	8aae                	mv	s5,a1
 798:	89b2                	mv	s3,a2
    return -1;

  va_start(ap, fmt);
 79a:	00840793          	add	a5,s0,8
 79e:	f8f43c23          	sd	a5,-104(s0)
  int off = 0;
 7a2:	4481                	li	s1,0
  for(i = 0; off < sz && (c = fmt[i] & 0xff) != 0; i++){
 7a4:	4901                	li	s2,0
 7a6:	00b05f63          	blez	a1,7c4 <snprintf+0x54>
 7aa:	e0d2                	sd	s4,64(sp)
 7ac:	f45e                	sd	s7,40(sp)
 7ae:	f062                	sd	s8,32(sp)
 7b0:	ec66                	sd	s9,24(sp)
    if(c != '%'){
 7b2:	02500a13          	li	s4,37
      continue;
    }
    c = fmt[++i] & 0xff;
    if(c == 0)
      break;
    switch(c){
 7b6:	07300b93          	li	s7,115
 7ba:	07800c93          	li	s9,120
 7be:	06400c13          	li	s8,100
 7c2:	a839                	j	7e0 <snprintf+0x70>
      off += sputc(buf+off, '%');
      off += sputc(buf+off, c);
      break;
    }
  }
  return off;
 7c4:	4481                	li	s1,0
 7c6:	6946                	ld	s2,80(sp)
 7c8:	69a6                	ld	s3,72(sp)
 7ca:	7ae2                	ld	s5,56(sp)
 7cc:	7b42                	ld	s6,48(sp)
 7ce:	a0cd                	j	8b0 <snprintf+0x140>
  *s = c;
 7d0:	009b0733          	add	a4,s6,s1
 7d4:	00f70023          	sb	a5,0(a4)
      off += sputc(buf+off, c);
 7d8:	2485                	addw	s1,s1,1
  for(i = 0; off < sz && (c = fmt[i] & 0xff) != 0; i++){
 7da:	2905                	addw	s2,s2,1
 7dc:	1554d563          	bge	s1,s5,926 <snprintf+0x1b6>
 7e0:	012987b3          	add	a5,s3,s2
 7e4:	0007c783          	lbu	a5,0(a5)
 7e8:	0007871b          	sext.w	a4,a5
 7ec:	10078063          	beqz	a5,8ec <snprintf+0x17c>
    if(c != '%'){
 7f0:	ff4710e3          	bne	a4,s4,7d0 <snprintf+0x60>
    c = fmt[++i] & 0xff;
 7f4:	2905                	addw	s2,s2,1
 7f6:	012987b3          	add	a5,s3,s2
 7fa:	0007c783          	lbu	a5,0(a5)
    if(c == 0)
 7fe:	10078263          	beqz	a5,902 <snprintf+0x192>
    switch(c){
 802:	05778c63          	beq	a5,s7,85a <snprintf+0xea>
 806:	02fbe763          	bltu	s7,a5,834 <snprintf+0xc4>
 80a:	0d478063          	beq	a5,s4,8ca <snprintf+0x15a>
 80e:	0d879463          	bne	a5,s8,8d6 <snprintf+0x166>
      off += sprintint(buf+off, va_arg(ap, int), 10, 1);
 812:	f9843783          	ld	a5,-104(s0)
 816:	00878713          	add	a4,a5,8
 81a:	f8e43c23          	sd	a4,-104(s0)
 81e:	4685                	li	a3,1
 820:	4629                	li	a2,10
 822:	438c                	lw	a1,0(a5)
 824:	009b0533          	add	a0,s6,s1
 828:	00000097          	auipc	ra,0x0
 82c:	bb0080e7          	jalr	-1104(ra) # 3d8 <sprintint>
 830:	9ca9                	addw	s1,s1,a0
      break;
 832:	b765                	j	7da <snprintf+0x6a>
    switch(c){
 834:	0b979163          	bne	a5,s9,8d6 <snprintf+0x166>
      off += sprintint(buf+off, va_arg(ap, int), 16, 1);
 838:	f9843783          	ld	a5,-104(s0)
 83c:	00878713          	add	a4,a5,8
 840:	f8e43c23          	sd	a4,-104(s0)
 844:	4685                	li	a3,1
 846:	4641                	li	a2,16
 848:	438c                	lw	a1,0(a5)
 84a:	009b0533          	add	a0,s6,s1
 84e:	00000097          	auipc	ra,0x0
 852:	b8a080e7          	jalr	-1142(ra) # 3d8 <sprintint>
 856:	9ca9                	addw	s1,s1,a0
      break;
 858:	b749                	j	7da <snprintf+0x6a>
      if((s = va_arg(ap, char*)) == 0)
 85a:	f9843783          	ld	a5,-104(s0)
 85e:	00878713          	add	a4,a5,8
 862:	f8e43c23          	sd	a4,-104(s0)
 866:	6388                	ld	a0,0(a5)
 868:	c931                	beqz	a0,8bc <snprintf+0x14c>
      for(; *s && off < sz; s++)
 86a:	00054703          	lbu	a4,0(a0)
 86e:	d735                	beqz	a4,7da <snprintf+0x6a>
 870:	0b54d263          	bge	s1,s5,914 <snprintf+0x1a4>
 874:	009b06b3          	add	a3,s6,s1
 878:	409a863b          	subw	a2,s5,s1
 87c:	1602                	sll	a2,a2,0x20
 87e:	9201                	srl	a2,a2,0x20
 880:	962a                	add	a2,a2,a0
 882:	87aa                	mv	a5,a0
        off += sputc(buf+off, *s);
 884:	0014859b          	addw	a1,s1,1
 888:	9d89                	subw	a1,a1,a0
  *s = c;
 88a:	00e68023          	sb	a4,0(a3)
        off += sputc(buf+off, *s);
 88e:	00f584bb          	addw	s1,a1,a5
      for(; *s && off < sz; s++)
 892:	0785                	add	a5,a5,1
 894:	0007c703          	lbu	a4,0(a5)
 898:	d329                	beqz	a4,7da <snprintf+0x6a>
 89a:	0685                	add	a3,a3,1
 89c:	fec797e3          	bne	a5,a2,88a <snprintf+0x11a>
 8a0:	6946                	ld	s2,80(sp)
 8a2:	69a6                	ld	s3,72(sp)
 8a4:	6a06                	ld	s4,64(sp)
 8a6:	7ae2                	ld	s5,56(sp)
 8a8:	7b42                	ld	s6,48(sp)
 8aa:	7ba2                	ld	s7,40(sp)
 8ac:	7c02                	ld	s8,32(sp)
 8ae:	6ce2                	ld	s9,24(sp)
 8b0:	8526                	mv	a0,s1
 8b2:	70a6                	ld	ra,104(sp)
 8b4:	7406                	ld	s0,96(sp)
 8b6:	64e6                	ld	s1,88(sp)
 8b8:	610d                	add	sp,sp,160
 8ba:	8082                	ret
      for(; *s && off < sz; s++)
 8bc:	02800713          	li	a4,40
        s = "(null)";
 8c0:	00000517          	auipc	a0,0x0
 8c4:	21850513          	add	a0,a0,536 # ad8 <malloc+0x11e>
 8c8:	b765                	j	870 <snprintf+0x100>
  *s = c;
 8ca:	009b07b3          	add	a5,s6,s1
 8ce:	01478023          	sb	s4,0(a5)
      off += sputc(buf+off, '%');
 8d2:	2485                	addw	s1,s1,1
      break;
 8d4:	b719                	j	7da <snprintf+0x6a>
  *s = c;
 8d6:	009b0733          	add	a4,s6,s1
 8da:	01470023          	sb	s4,0(a4)
      off += sputc(buf+off, c);
 8de:	0014871b          	addw	a4,s1,1
  *s = c;
 8e2:	975a                	add	a4,a4,s6
 8e4:	00f70023          	sb	a5,0(a4)
      off += sputc(buf+off, c);
 8e8:	2489                	addw	s1,s1,2
      break;
 8ea:	bdc5                	j	7da <snprintf+0x6a>
 8ec:	6946                	ld	s2,80(sp)
 8ee:	69a6                	ld	s3,72(sp)
 8f0:	6a06                	ld	s4,64(sp)
 8f2:	7ae2                	ld	s5,56(sp)
 8f4:	7b42                	ld	s6,48(sp)
 8f6:	7ba2                	ld	s7,40(sp)
 8f8:	7c02                	ld	s8,32(sp)
 8fa:	6ce2                	ld	s9,24(sp)
 8fc:	bf55                	j	8b0 <snprintf+0x140>
    return -1;
 8fe:	54fd                	li	s1,-1
 900:	bf45                	j	8b0 <snprintf+0x140>
 902:	6946                	ld	s2,80(sp)
 904:	69a6                	ld	s3,72(sp)
 906:	6a06                	ld	s4,64(sp)
 908:	7ae2                	ld	s5,56(sp)
 90a:	7b42                	ld	s6,48(sp)
 90c:	7ba2                	ld	s7,40(sp)
 90e:	7c02                	ld	s8,32(sp)
 910:	6ce2                	ld	s9,24(sp)
 912:	bf79                	j	8b0 <snprintf+0x140>
 914:	6946                	ld	s2,80(sp)
 916:	69a6                	ld	s3,72(sp)
 918:	6a06                	ld	s4,64(sp)
 91a:	7ae2                	ld	s5,56(sp)
 91c:	7b42                	ld	s6,48(sp)
 91e:	7ba2                	ld	s7,40(sp)
 920:	7c02                	ld	s8,32(sp)
 922:	6ce2                	ld	s9,24(sp)
 924:	b771                	j	8b0 <snprintf+0x140>
 926:	6946                	ld	s2,80(sp)
 928:	69a6                	ld	s3,72(sp)
 92a:	6a06                	ld	s4,64(sp)
 92c:	7ae2                	ld	s5,56(sp)
 92e:	7b42                	ld	s6,48(sp)
 930:	7ba2                	ld	s7,40(sp)
 932:	7c02                	ld	s8,32(sp)
 934:	6ce2                	ld	s9,24(sp)
 936:	bfad                	j	8b0 <snprintf+0x140>

0000000000000938 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 938:	1141                	add	sp,sp,-16
 93a:	e422                	sd	s0,8(sp)
 93c:	0800                	add	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 93e:	ff050693          	add	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 942:	00000797          	auipc	a5,0x0
 946:	20e7b783          	ld	a5,526(a5) # b50 <freep>
 94a:	a02d                	j	974 <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 94c:	4618                	lw	a4,8(a2)
 94e:	9f2d                	addw	a4,a4,a1
 950:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 954:	6398                	ld	a4,0(a5)
 956:	6310                	ld	a2,0(a4)
 958:	a83d                	j	996 <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 95a:	ff852703          	lw	a4,-8(a0)
 95e:	9f31                	addw	a4,a4,a2
 960:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 962:	ff053683          	ld	a3,-16(a0)
 966:	a091                	j	9aa <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 968:	6398                	ld	a4,0(a5)
 96a:	00e7e463          	bltu	a5,a4,972 <free+0x3a>
 96e:	00e6ea63          	bltu	a3,a4,982 <free+0x4a>
{
 972:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 974:	fed7fae3          	bgeu	a5,a3,968 <free+0x30>
 978:	6398                	ld	a4,0(a5)
 97a:	00e6e463          	bltu	a3,a4,982 <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 97e:	fee7eae3          	bltu	a5,a4,972 <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 982:	ff852583          	lw	a1,-8(a0)
 986:	6390                	ld	a2,0(a5)
 988:	02059813          	sll	a6,a1,0x20
 98c:	01c85713          	srl	a4,a6,0x1c
 990:	9736                	add	a4,a4,a3
 992:	fae60de3          	beq	a2,a4,94c <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 996:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 99a:	4790                	lw	a2,8(a5)
 99c:	02061593          	sll	a1,a2,0x20
 9a0:	01c5d713          	srl	a4,a1,0x1c
 9a4:	973e                	add	a4,a4,a5
 9a6:	fae68ae3          	beq	a3,a4,95a <free+0x22>
    p->s.ptr = bp->s.ptr;
 9aa:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 9ac:	00000717          	auipc	a4,0x0
 9b0:	1af73223          	sd	a5,420(a4) # b50 <freep>
}
 9b4:	6422                	ld	s0,8(sp)
 9b6:	0141                	add	sp,sp,16
 9b8:	8082                	ret

00000000000009ba <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 9ba:	7139                	add	sp,sp,-64
 9bc:	fc06                	sd	ra,56(sp)
 9be:	f822                	sd	s0,48(sp)
 9c0:	f426                	sd	s1,40(sp)
 9c2:	ec4e                	sd	s3,24(sp)
 9c4:	0080                	add	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 9c6:	02051493          	sll	s1,a0,0x20
 9ca:	9081                	srl	s1,s1,0x20
 9cc:	04bd                	add	s1,s1,15
 9ce:	8091                	srl	s1,s1,0x4
 9d0:	0014899b          	addw	s3,s1,1
 9d4:	0485                	add	s1,s1,1
  if((prevp = freep) == 0){
 9d6:	00000517          	auipc	a0,0x0
 9da:	17a53503          	ld	a0,378(a0) # b50 <freep>
 9de:	c915                	beqz	a0,a12 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 9e0:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 9e2:	4798                	lw	a4,8(a5)
 9e4:	08977e63          	bgeu	a4,s1,a80 <malloc+0xc6>
 9e8:	f04a                	sd	s2,32(sp)
 9ea:	e852                	sd	s4,16(sp)
 9ec:	e456                	sd	s5,8(sp)
 9ee:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 9f0:	8a4e                	mv	s4,s3
 9f2:	0009871b          	sext.w	a4,s3
 9f6:	6685                	lui	a3,0x1
 9f8:	00d77363          	bgeu	a4,a3,9fe <malloc+0x44>
 9fc:	6a05                	lui	s4,0x1
 9fe:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 a02:	004a1a1b          	sllw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 a06:	00000917          	auipc	s2,0x0
 a0a:	14a90913          	add	s2,s2,330 # b50 <freep>
  if(p == (char*)-1)
 a0e:	5afd                	li	s5,-1
 a10:	a091                	j	a54 <malloc+0x9a>
 a12:	f04a                	sd	s2,32(sp)
 a14:	e852                	sd	s4,16(sp)
 a16:	e456                	sd	s5,8(sp)
 a18:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 a1a:	00000797          	auipc	a5,0x0
 a1e:	13e78793          	add	a5,a5,318 # b58 <base>
 a22:	00000717          	auipc	a4,0x0
 a26:	12f73723          	sd	a5,302(a4) # b50 <freep>
 a2a:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 a2c:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 a30:	b7c1                	j	9f0 <malloc+0x36>
        prevp->s.ptr = p->s.ptr;
 a32:	6398                	ld	a4,0(a5)
 a34:	e118                	sd	a4,0(a0)
 a36:	a08d                	j	a98 <malloc+0xde>
  hp->s.size = nu;
 a38:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 a3c:	0541                	add	a0,a0,16
 a3e:	00000097          	auipc	ra,0x0
 a42:	efa080e7          	jalr	-262(ra) # 938 <free>
  return freep;
 a46:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 a4a:	c13d                	beqz	a0,ab0 <malloc+0xf6>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a4c:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 a4e:	4798                	lw	a4,8(a5)
 a50:	02977463          	bgeu	a4,s1,a78 <malloc+0xbe>
    if(p == freep)
 a54:	00093703          	ld	a4,0(s2)
 a58:	853e                	mv	a0,a5
 a5a:	fef719e3          	bne	a4,a5,a4c <malloc+0x92>
  p = sbrk(nu * sizeof(Header));
 a5e:	8552                	mv	a0,s4
 a60:	00000097          	auipc	ra,0x0
 a64:	92a080e7          	jalr	-1750(ra) # 38a <sbrk>
  if(p == (char*)-1)
 a68:	fd5518e3          	bne	a0,s5,a38 <malloc+0x7e>
        return 0;
 a6c:	4501                	li	a0,0
 a6e:	7902                	ld	s2,32(sp)
 a70:	6a42                	ld	s4,16(sp)
 a72:	6aa2                	ld	s5,8(sp)
 a74:	6b02                	ld	s6,0(sp)
 a76:	a03d                	j	aa4 <malloc+0xea>
 a78:	7902                	ld	s2,32(sp)
 a7a:	6a42                	ld	s4,16(sp)
 a7c:	6aa2                	ld	s5,8(sp)
 a7e:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 a80:	fae489e3          	beq	s1,a4,a32 <malloc+0x78>
        p->s.size -= nunits;
 a84:	4137073b          	subw	a4,a4,s3
 a88:	c798                	sw	a4,8(a5)
        p += p->s.size;
 a8a:	02071693          	sll	a3,a4,0x20
 a8e:	01c6d713          	srl	a4,a3,0x1c
 a92:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 a94:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 a98:	00000717          	auipc	a4,0x0
 a9c:	0aa73c23          	sd	a0,184(a4) # b50 <freep>
      return (void*)(p + 1);
 aa0:	01078513          	add	a0,a5,16
  }
}
 aa4:	70e2                	ld	ra,56(sp)
 aa6:	7442                	ld	s0,48(sp)
 aa8:	74a2                	ld	s1,40(sp)
 aaa:	69e2                	ld	s3,24(sp)
 aac:	6121                	add	sp,sp,64
 aae:	8082                	ret
 ab0:	7902                	ld	s2,32(sp)
 ab2:	6a42                	ld	s4,16(sp)
 ab4:	6aa2                	ld	s5,8(sp)
 ab6:	6b02                	ld	s6,0(sp)
 ab8:	b7f5                	j	aa4 <malloc+0xea>
