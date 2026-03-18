
user/_rm:     file format elf64-littleriscv


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
    fprintf(2, "Usage: rm files...\n");
    exit(1);
  }

  for(i = 1; i < argc; i++){
    if(unlink(argv[i]) < 0){
  26:	6088                	ld	a0,0(s1)
  28:	00000097          	auipc	ra,0x0
  2c:	33c080e7          	jalr	828(ra) # 364 <unlink>
  30:	02054663          	bltz	a0,5c <main+0x5c>
  for(i = 1; i < argc; i++){
  34:	04a1                	add	s1,s1,8
  36:	ff2498e3          	bne	s1,s2,26 <main+0x26>
  3a:	a81d                	j	70 <main+0x70>
  3c:	e426                	sd	s1,8(sp)
  3e:	e04a                	sd	s2,0(sp)
    fprintf(2, "Usage: rm files...\n");
  40:	00001597          	auipc	a1,0x1
  44:	a9058593          	add	a1,a1,-1392 # ad0 <malloc+0x104>
  48:	4509                	li	a0,2
  4a:	00000097          	auipc	ra,0x0
  4e:	6d4080e7          	jalr	1748(ra) # 71e <fprintf>
    exit(1);
  52:	4505                	li	a0,1
  54:	00000097          	auipc	ra,0x0
  58:	2c0080e7          	jalr	704(ra) # 314 <exit>
      fprintf(2, "rm: %s failed to delete\n", argv[i]);
  5c:	6090                	ld	a2,0(s1)
  5e:	00001597          	auipc	a1,0x1
  62:	a8a58593          	add	a1,a1,-1398 # ae8 <malloc+0x11c>
  66:	4509                	li	a0,2
  68:	00000097          	auipc	ra,0x0
  6c:	6b6080e7          	jalr	1718(ra) # 71e <fprintf>
      break;
    }
  }

  exit(0);
  70:	4501                	li	a0,0
  72:	00000097          	auipc	ra,0x0
  76:	2a2080e7          	jalr	674(ra) # 314 <exit>

000000000000007a <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
  7a:	1141                	add	sp,sp,-16
  7c:	e422                	sd	s0,8(sp)
  7e:	0800                	add	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  80:	87aa                	mv	a5,a0
  82:	0585                	add	a1,a1,1
  84:	0785                	add	a5,a5,1
  86:	fff5c703          	lbu	a4,-1(a1)
  8a:	fee78fa3          	sb	a4,-1(a5)
  8e:	fb75                	bnez	a4,82 <strcpy+0x8>
    ;
  return os;
}
  90:	6422                	ld	s0,8(sp)
  92:	0141                	add	sp,sp,16
  94:	8082                	ret

0000000000000096 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  96:	1141                	add	sp,sp,-16
  98:	e422                	sd	s0,8(sp)
  9a:	0800                	add	s0,sp,16
  while(*p && *p == *q)
  9c:	00054783          	lbu	a5,0(a0)
  a0:	cb91                	beqz	a5,b4 <strcmp+0x1e>
  a2:	0005c703          	lbu	a4,0(a1)
  a6:	00f71763          	bne	a4,a5,b4 <strcmp+0x1e>
    p++, q++;
  aa:	0505                	add	a0,a0,1
  ac:	0585                	add	a1,a1,1
  while(*p && *p == *q)
  ae:	00054783          	lbu	a5,0(a0)
  b2:	fbe5                	bnez	a5,a2 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
  b4:	0005c503          	lbu	a0,0(a1)
}
  b8:	40a7853b          	subw	a0,a5,a0
  bc:	6422                	ld	s0,8(sp)
  be:	0141                	add	sp,sp,16
  c0:	8082                	ret

00000000000000c2 <strlen>:

uint
strlen(const char *s)
{
  c2:	1141                	add	sp,sp,-16
  c4:	e422                	sd	s0,8(sp)
  c6:	0800                	add	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
  c8:	00054783          	lbu	a5,0(a0)
  cc:	cf91                	beqz	a5,e8 <strlen+0x26>
  ce:	0505                	add	a0,a0,1
  d0:	87aa                	mv	a5,a0
  d2:	86be                	mv	a3,a5
  d4:	0785                	add	a5,a5,1
  d6:	fff7c703          	lbu	a4,-1(a5)
  da:	ff65                	bnez	a4,d2 <strlen+0x10>
  dc:	40a6853b          	subw	a0,a3,a0
  e0:	2505                	addw	a0,a0,1
    ;
  return n;
}
  e2:	6422                	ld	s0,8(sp)
  e4:	0141                	add	sp,sp,16
  e6:	8082                	ret
  for(n = 0; s[n]; n++)
  e8:	4501                	li	a0,0
  ea:	bfe5                	j	e2 <strlen+0x20>

00000000000000ec <strcat>:

char *
strcat(char *dst, char *src)
{
  ec:	1141                	add	sp,sp,-16
  ee:	e422                	sd	s0,8(sp)
  f0:	0800                	add	s0,sp,16
  char *s = dst;
  while (*dst)
  f2:	00054783          	lbu	a5,0(a0)
  f6:	c385                	beqz	a5,116 <strcat+0x2a>
  f8:	87aa                	mv	a5,a0
    dst++;
  fa:	0785                	add	a5,a5,1
  while (*dst)
  fc:	0007c703          	lbu	a4,0(a5)
 100:	ff6d                	bnez	a4,fa <strcat+0xe>
  while ((*dst++ = *src++) != 0);
 102:	0585                	add	a1,a1,1
 104:	0785                	add	a5,a5,1
 106:	fff5c703          	lbu	a4,-1(a1)
 10a:	fee78fa3          	sb	a4,-1(a5)
 10e:	fb75                	bnez	a4,102 <strcat+0x16>

  return s;
}
 110:	6422                	ld	s0,8(sp)
 112:	0141                	add	sp,sp,16
 114:	8082                	ret
  while (*dst)
 116:	87aa                	mv	a5,a0
 118:	b7ed                	j	102 <strcat+0x16>

000000000000011a <memset>:

void*
memset(void *dst, int c, uint n)
{
 11a:	1141                	add	sp,sp,-16
 11c:	e422                	sd	s0,8(sp)
 11e:	0800                	add	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 120:	ca19                	beqz	a2,136 <memset+0x1c>
 122:	87aa                	mv	a5,a0
 124:	1602                	sll	a2,a2,0x20
 126:	9201                	srl	a2,a2,0x20
 128:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 12c:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 130:	0785                	add	a5,a5,1
 132:	fee79de3          	bne	a5,a4,12c <memset+0x12>
  }
  return dst;
}
 136:	6422                	ld	s0,8(sp)
 138:	0141                	add	sp,sp,16
 13a:	8082                	ret

000000000000013c <strchr>:

char*
strchr(const char *s, char c)
{
 13c:	1141                	add	sp,sp,-16
 13e:	e422                	sd	s0,8(sp)
 140:	0800                	add	s0,sp,16
  for(; *s; s++)
 142:	00054783          	lbu	a5,0(a0)
 146:	cb99                	beqz	a5,15c <strchr+0x20>
    if(*s == c)
 148:	00f58763          	beq	a1,a5,156 <strchr+0x1a>
  for(; *s; s++)
 14c:	0505                	add	a0,a0,1
 14e:	00054783          	lbu	a5,0(a0)
 152:	fbfd                	bnez	a5,148 <strchr+0xc>
      return (char*)s;
  return 0;
 154:	4501                	li	a0,0
}
 156:	6422                	ld	s0,8(sp)
 158:	0141                	add	sp,sp,16
 15a:	8082                	ret
  return 0;
 15c:	4501                	li	a0,0
 15e:	bfe5                	j	156 <strchr+0x1a>

0000000000000160 <gets>:

char*
gets(char *buf, int max)
{
 160:	711d                	add	sp,sp,-96
 162:	ec86                	sd	ra,88(sp)
 164:	e8a2                	sd	s0,80(sp)
 166:	e4a6                	sd	s1,72(sp)
 168:	e0ca                	sd	s2,64(sp)
 16a:	fc4e                	sd	s3,56(sp)
 16c:	f852                	sd	s4,48(sp)
 16e:	f456                	sd	s5,40(sp)
 170:	f05a                	sd	s6,32(sp)
 172:	ec5e                	sd	s7,24(sp)
 174:	1080                	add	s0,sp,96
 176:	8baa                	mv	s7,a0
 178:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 17a:	892a                	mv	s2,a0
 17c:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 17e:	4aa9                	li	s5,10
 180:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 182:	89a6                	mv	s3,s1
 184:	2485                	addw	s1,s1,1
 186:	0344d863          	bge	s1,s4,1b6 <gets+0x56>
    cc = read(0, &c, 1);
 18a:	4605                	li	a2,1
 18c:	faf40593          	add	a1,s0,-81
 190:	4501                	li	a0,0
 192:	00000097          	auipc	ra,0x0
 196:	19a080e7          	jalr	410(ra) # 32c <read>
    if(cc < 1)
 19a:	00a05e63          	blez	a0,1b6 <gets+0x56>
    buf[i++] = c;
 19e:	faf44783          	lbu	a5,-81(s0)
 1a2:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 1a6:	01578763          	beq	a5,s5,1b4 <gets+0x54>
 1aa:	0905                	add	s2,s2,1
 1ac:	fd679be3          	bne	a5,s6,182 <gets+0x22>
    buf[i++] = c;
 1b0:	89a6                	mv	s3,s1
 1b2:	a011                	j	1b6 <gets+0x56>
 1b4:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 1b6:	99de                	add	s3,s3,s7
 1b8:	00098023          	sb	zero,0(s3)
  return buf;
}
 1bc:	855e                	mv	a0,s7
 1be:	60e6                	ld	ra,88(sp)
 1c0:	6446                	ld	s0,80(sp)
 1c2:	64a6                	ld	s1,72(sp)
 1c4:	6906                	ld	s2,64(sp)
 1c6:	79e2                	ld	s3,56(sp)
 1c8:	7a42                	ld	s4,48(sp)
 1ca:	7aa2                	ld	s5,40(sp)
 1cc:	7b02                	ld	s6,32(sp)
 1ce:	6be2                	ld	s7,24(sp)
 1d0:	6125                	add	sp,sp,96
 1d2:	8082                	ret

00000000000001d4 <stat>:

int
stat(const char *n, struct stat *st)
{
 1d4:	1101                	add	sp,sp,-32
 1d6:	ec06                	sd	ra,24(sp)
 1d8:	e822                	sd	s0,16(sp)
 1da:	e04a                	sd	s2,0(sp)
 1dc:	1000                	add	s0,sp,32
 1de:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1e0:	4581                	li	a1,0
 1e2:	00000097          	auipc	ra,0x0
 1e6:	172080e7          	jalr	370(ra) # 354 <open>
  if(fd < 0)
 1ea:	02054663          	bltz	a0,216 <stat+0x42>
 1ee:	e426                	sd	s1,8(sp)
 1f0:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 1f2:	85ca                	mv	a1,s2
 1f4:	00000097          	auipc	ra,0x0
 1f8:	178080e7          	jalr	376(ra) # 36c <fstat>
 1fc:	892a                	mv	s2,a0
  close(fd);
 1fe:	8526                	mv	a0,s1
 200:	00000097          	auipc	ra,0x0
 204:	13c080e7          	jalr	316(ra) # 33c <close>
  return r;
 208:	64a2                	ld	s1,8(sp)
}
 20a:	854a                	mv	a0,s2
 20c:	60e2                	ld	ra,24(sp)
 20e:	6442                	ld	s0,16(sp)
 210:	6902                	ld	s2,0(sp)
 212:	6105                	add	sp,sp,32
 214:	8082                	ret
    return -1;
 216:	597d                	li	s2,-1
 218:	bfcd                	j	20a <stat+0x36>

000000000000021a <atoi>:

int
atoi(const char *s)
{
 21a:	1141                	add	sp,sp,-16
 21c:	e422                	sd	s0,8(sp)
 21e:	0800                	add	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 220:	00054683          	lbu	a3,0(a0)
 224:	fd06879b          	addw	a5,a3,-48
 228:	0ff7f793          	zext.b	a5,a5
 22c:	4625                	li	a2,9
 22e:	02f66863          	bltu	a2,a5,25e <atoi+0x44>
 232:	872a                	mv	a4,a0
  n = 0;
 234:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 236:	0705                	add	a4,a4,1
 238:	0025179b          	sllw	a5,a0,0x2
 23c:	9fa9                	addw	a5,a5,a0
 23e:	0017979b          	sllw	a5,a5,0x1
 242:	9fb5                	addw	a5,a5,a3
 244:	fd07851b          	addw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 248:	00074683          	lbu	a3,0(a4)
 24c:	fd06879b          	addw	a5,a3,-48
 250:	0ff7f793          	zext.b	a5,a5
 254:	fef671e3          	bgeu	a2,a5,236 <atoi+0x1c>
  return n;
}
 258:	6422                	ld	s0,8(sp)
 25a:	0141                	add	sp,sp,16
 25c:	8082                	ret
  n = 0;
 25e:	4501                	li	a0,0
 260:	bfe5                	j	258 <atoi+0x3e>

0000000000000262 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 262:	1141                	add	sp,sp,-16
 264:	e422                	sd	s0,8(sp)
 266:	0800                	add	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 268:	02b57463          	bgeu	a0,a1,290 <memmove+0x2e>
    while(n-- > 0)
 26c:	00c05f63          	blez	a2,28a <memmove+0x28>
 270:	1602                	sll	a2,a2,0x20
 272:	9201                	srl	a2,a2,0x20
 274:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 278:	872a                	mv	a4,a0
      *dst++ = *src++;
 27a:	0585                	add	a1,a1,1
 27c:	0705                	add	a4,a4,1
 27e:	fff5c683          	lbu	a3,-1(a1)
 282:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 286:	fef71ae3          	bne	a4,a5,27a <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 28a:	6422                	ld	s0,8(sp)
 28c:	0141                	add	sp,sp,16
 28e:	8082                	ret
    dst += n;
 290:	00c50733          	add	a4,a0,a2
    src += n;
 294:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 296:	fec05ae3          	blez	a2,28a <memmove+0x28>
 29a:	fff6079b          	addw	a5,a2,-1
 29e:	1782                	sll	a5,a5,0x20
 2a0:	9381                	srl	a5,a5,0x20
 2a2:	fff7c793          	not	a5,a5
 2a6:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 2a8:	15fd                	add	a1,a1,-1
 2aa:	177d                	add	a4,a4,-1
 2ac:	0005c683          	lbu	a3,0(a1)
 2b0:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 2b4:	fee79ae3          	bne	a5,a4,2a8 <memmove+0x46>
 2b8:	bfc9                	j	28a <memmove+0x28>

00000000000002ba <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 2ba:	1141                	add	sp,sp,-16
 2bc:	e422                	sd	s0,8(sp)
 2be:	0800                	add	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 2c0:	ca05                	beqz	a2,2f0 <memcmp+0x36>
 2c2:	fff6069b          	addw	a3,a2,-1
 2c6:	1682                	sll	a3,a3,0x20
 2c8:	9281                	srl	a3,a3,0x20
 2ca:	0685                	add	a3,a3,1
 2cc:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 2ce:	00054783          	lbu	a5,0(a0)
 2d2:	0005c703          	lbu	a4,0(a1)
 2d6:	00e79863          	bne	a5,a4,2e6 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 2da:	0505                	add	a0,a0,1
    p2++;
 2dc:	0585                	add	a1,a1,1
  while (n-- > 0) {
 2de:	fed518e3          	bne	a0,a3,2ce <memcmp+0x14>
  }
  return 0;
 2e2:	4501                	li	a0,0
 2e4:	a019                	j	2ea <memcmp+0x30>
      return *p1 - *p2;
 2e6:	40e7853b          	subw	a0,a5,a4
}
 2ea:	6422                	ld	s0,8(sp)
 2ec:	0141                	add	sp,sp,16
 2ee:	8082                	ret
  return 0;
 2f0:	4501                	li	a0,0
 2f2:	bfe5                	j	2ea <memcmp+0x30>

00000000000002f4 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 2f4:	1141                	add	sp,sp,-16
 2f6:	e406                	sd	ra,8(sp)
 2f8:	e022                	sd	s0,0(sp)
 2fa:	0800                	add	s0,sp,16
  return memmove(dst, src, n);
 2fc:	00000097          	auipc	ra,0x0
 300:	f66080e7          	jalr	-154(ra) # 262 <memmove>
}
 304:	60a2                	ld	ra,8(sp)
 306:	6402                	ld	s0,0(sp)
 308:	0141                	add	sp,sp,16
 30a:	8082                	ret

000000000000030c <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 30c:	4885                	li	a7,1
 ecall
 30e:	00000073          	ecall
 ret
 312:	8082                	ret

0000000000000314 <exit>:
.global exit
exit:
 li a7, SYS_exit
 314:	4889                	li	a7,2
 ecall
 316:	00000073          	ecall
 ret
 31a:	8082                	ret

000000000000031c <wait>:
.global wait
wait:
 li a7, SYS_wait
 31c:	488d                	li	a7,3
 ecall
 31e:	00000073          	ecall
 ret
 322:	8082                	ret

0000000000000324 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 324:	4891                	li	a7,4
 ecall
 326:	00000073          	ecall
 ret
 32a:	8082                	ret

000000000000032c <read>:
.global read
read:
 li a7, SYS_read
 32c:	4895                	li	a7,5
 ecall
 32e:	00000073          	ecall
 ret
 332:	8082                	ret

0000000000000334 <write>:
.global write
write:
 li a7, SYS_write
 334:	48c1                	li	a7,16
 ecall
 336:	00000073          	ecall
 ret
 33a:	8082                	ret

000000000000033c <close>:
.global close
close:
 li a7, SYS_close
 33c:	48d5                	li	a7,21
 ecall
 33e:	00000073          	ecall
 ret
 342:	8082                	ret

0000000000000344 <kill>:
.global kill
kill:
 li a7, SYS_kill
 344:	4899                	li	a7,6
 ecall
 346:	00000073          	ecall
 ret
 34a:	8082                	ret

000000000000034c <exec>:
.global exec
exec:
 li a7, SYS_exec
 34c:	489d                	li	a7,7
 ecall
 34e:	00000073          	ecall
 ret
 352:	8082                	ret

0000000000000354 <open>:
.global open
open:
 li a7, SYS_open
 354:	48bd                	li	a7,15
 ecall
 356:	00000073          	ecall
 ret
 35a:	8082                	ret

000000000000035c <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 35c:	48c5                	li	a7,17
 ecall
 35e:	00000073          	ecall
 ret
 362:	8082                	ret

0000000000000364 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 364:	48c9                	li	a7,18
 ecall
 366:	00000073          	ecall
 ret
 36a:	8082                	ret

000000000000036c <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 36c:	48a1                	li	a7,8
 ecall
 36e:	00000073          	ecall
 ret
 372:	8082                	ret

0000000000000374 <link>:
.global link
link:
 li a7, SYS_link
 374:	48cd                	li	a7,19
 ecall
 376:	00000073          	ecall
 ret
 37a:	8082                	ret

000000000000037c <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 37c:	48d1                	li	a7,20
 ecall
 37e:	00000073          	ecall
 ret
 382:	8082                	ret

0000000000000384 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 384:	48a5                	li	a7,9
 ecall
 386:	00000073          	ecall
 ret
 38a:	8082                	ret

000000000000038c <dup>:
.global dup
dup:
 li a7, SYS_dup
 38c:	48a9                	li	a7,10
 ecall
 38e:	00000073          	ecall
 ret
 392:	8082                	ret

0000000000000394 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 394:	48ad                	li	a7,11
 ecall
 396:	00000073          	ecall
 ret
 39a:	8082                	ret

000000000000039c <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 39c:	48b1                	li	a7,12
 ecall
 39e:	00000073          	ecall
 ret
 3a2:	8082                	ret

00000000000003a4 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 3a4:	48b5                	li	a7,13
 ecall
 3a6:	00000073          	ecall
 ret
 3aa:	8082                	ret

00000000000003ac <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 3ac:	48b9                	li	a7,14
 ecall
 3ae:	00000073          	ecall
 ret
 3b2:	8082                	ret

00000000000003b4 <uconnect>:
.global uconnect
uconnect:
 li a7, SYS_uconnect
 3b4:	48f5                	li	a7,29
 ecall
 3b6:	00000073          	ecall
 ret
 3ba:	8082                	ret

00000000000003bc <socket>:
.global socket
socket:
 li a7, SYS_socket
 3bc:	48f9                	li	a7,30
 ecall
 3be:	00000073          	ecall
 ret
 3c2:	8082                	ret

00000000000003c4 <bind>:
.global bind
bind:
 li a7, SYS_bind
 3c4:	48fd                	li	a7,31
 ecall
 3c6:	00000073          	ecall
 ret
 3ca:	8082                	ret

00000000000003cc <listen>:
.global listen
listen:
 li a7, SYS_listen
 3cc:	02000893          	li	a7,32
 ecall
 3d0:	00000073          	ecall
 ret
 3d4:	8082                	ret

00000000000003d6 <accept>:
.global accept
accept:
 li a7, SYS_accept
 3d6:	02100893          	li	a7,33
 ecall
 3da:	00000073          	ecall
 ret
 3de:	8082                	ret

00000000000003e0 <connect>:
.global connect
connect:
 li a7, SYS_connect
 3e0:	02200893          	li	a7,34
 ecall
 3e4:	00000073          	ecall
 ret
 3e8:	8082                	ret

00000000000003ea <sprintint>:
  return 1;
}

static int
sprintint(char *s, int xx, int base, int sign)
{
 3ea:	1101                	add	sp,sp,-32
 3ec:	ec22                	sd	s0,24(sp)
 3ee:	1000                	add	s0,sp,32
 3f0:	882a                	mv	a6,a0
  char buf[16];
  int i, n;
  uint x;

  if(sign && (sign = xx < 0))
 3f2:	c299                	beqz	a3,3f8 <sprintint+0xe>
 3f4:	0805c263          	bltz	a1,478 <sprintint+0x8e>
    x = -xx;
  else
    x = xx;
 3f8:	2581                	sext.w	a1,a1
 3fa:	4301                	li	t1,0

  i = 0;
 3fc:	fe040713          	add	a4,s0,-32
 400:	4501                	li	a0,0
  do {
    buf[i++] = digits[x % base];
 402:	2601                	sext.w	a2,a2
 404:	00000697          	auipc	a3,0x0
 408:	76468693          	add	a3,a3,1892 # b68 <digits>
 40c:	88aa                	mv	a7,a0
 40e:	2505                	addw	a0,a0,1
 410:	02c5f7bb          	remuw	a5,a1,a2
 414:	1782                	sll	a5,a5,0x20
 416:	9381                	srl	a5,a5,0x20
 418:	97b6                	add	a5,a5,a3
 41a:	0007c783          	lbu	a5,0(a5)
 41e:	00f70023          	sb	a5,0(a4)
  } while((x /= base) != 0);
 422:	0005879b          	sext.w	a5,a1
 426:	02c5d5bb          	divuw	a1,a1,a2
 42a:	0705                	add	a4,a4,1
 42c:	fec7f0e3          	bgeu	a5,a2,40c <sprintint+0x22>

  if(sign)
 430:	00030b63          	beqz	t1,446 <sprintint+0x5c>
    buf[i++] = '-';
 434:	ff050793          	add	a5,a0,-16
 438:	97a2                	add	a5,a5,s0
 43a:	02d00713          	li	a4,45
 43e:	fee78823          	sb	a4,-16(a5)
 442:	0028851b          	addw	a0,a7,2

  n = 0;
  while(--i >= 0)
 446:	02a05d63          	blez	a0,480 <sprintint+0x96>
 44a:	fe040793          	add	a5,s0,-32
 44e:	00a78733          	add	a4,a5,a0
 452:	87c2                	mv	a5,a6
 454:	00180613          	add	a2,a6,1
 458:	fff5069b          	addw	a3,a0,-1
 45c:	1682                	sll	a3,a3,0x20
 45e:	9281                	srl	a3,a3,0x20
 460:	9636                	add	a2,a2,a3
  *s = c;
 462:	fff74683          	lbu	a3,-1(a4)
 466:	00d78023          	sb	a3,0(a5)
  while(--i >= 0)
 46a:	177d                	add	a4,a4,-1
 46c:	0785                	add	a5,a5,1
 46e:	fec79ae3          	bne	a5,a2,462 <sprintint+0x78>
    n += sputc(s+n, buf[i]);
  return n;
}
 472:	6462                	ld	s0,24(sp)
 474:	6105                	add	sp,sp,32
 476:	8082                	ret
    x = -xx;
 478:	40b005bb          	negw	a1,a1
  if(sign && (sign = xx < 0))
 47c:	4305                	li	t1,1
    x = -xx;
 47e:	bfbd                	j	3fc <sprintint+0x12>
  while(--i >= 0)
 480:	4501                	li	a0,0
 482:	bfc5                	j	472 <sprintint+0x88>

0000000000000484 <putc>:
{
 484:	1101                	add	sp,sp,-32
 486:	ec06                	sd	ra,24(sp)
 488:	e822                	sd	s0,16(sp)
 48a:	1000                	add	s0,sp,32
 48c:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 490:	4605                	li	a2,1
 492:	fef40593          	add	a1,s0,-17
 496:	00000097          	auipc	ra,0x0
 49a:	e9e080e7          	jalr	-354(ra) # 334 <write>
}
 49e:	60e2                	ld	ra,24(sp)
 4a0:	6442                	ld	s0,16(sp)
 4a2:	6105                	add	sp,sp,32
 4a4:	8082                	ret

00000000000004a6 <printint>:
{
 4a6:	7139                	add	sp,sp,-64
 4a8:	fc06                	sd	ra,56(sp)
 4aa:	f822                	sd	s0,48(sp)
 4ac:	f426                	sd	s1,40(sp)
 4ae:	0080                	add	s0,sp,64
 4b0:	84aa                	mv	s1,a0
  if(sgn && xx < 0){
 4b2:	c299                	beqz	a3,4b8 <printint+0x12>
 4b4:	0805cb63          	bltz	a1,54a <printint+0xa4>
    x = xx;
 4b8:	2581                	sext.w	a1,a1
  neg = 0;
 4ba:	4881                	li	a7,0
 4bc:	fc040693          	add	a3,s0,-64
  i = 0;
 4c0:	4701                	li	a4,0
    buf[i++] = digits[x % base];
 4c2:	2601                	sext.w	a2,a2
 4c4:	00000517          	auipc	a0,0x0
 4c8:	6a450513          	add	a0,a0,1700 # b68 <digits>
 4cc:	883a                	mv	a6,a4
 4ce:	2705                	addw	a4,a4,1
 4d0:	02c5f7bb          	remuw	a5,a1,a2
 4d4:	1782                	sll	a5,a5,0x20
 4d6:	9381                	srl	a5,a5,0x20
 4d8:	97aa                	add	a5,a5,a0
 4da:	0007c783          	lbu	a5,0(a5)
 4de:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 4e2:	0005879b          	sext.w	a5,a1
 4e6:	02c5d5bb          	divuw	a1,a1,a2
 4ea:	0685                	add	a3,a3,1
 4ec:	fec7f0e3          	bgeu	a5,a2,4cc <printint+0x26>
  if(neg)
 4f0:	00088c63          	beqz	a7,508 <printint+0x62>
    buf[i++] = '-';
 4f4:	fd070793          	add	a5,a4,-48
 4f8:	00878733          	add	a4,a5,s0
 4fc:	02d00793          	li	a5,45
 500:	fef70823          	sb	a5,-16(a4)
 504:	0028071b          	addw	a4,a6,2
  while(--i >= 0)
 508:	02e05c63          	blez	a4,540 <printint+0x9a>
 50c:	f04a                	sd	s2,32(sp)
 50e:	ec4e                	sd	s3,24(sp)
 510:	fc040793          	add	a5,s0,-64
 514:	00e78933          	add	s2,a5,a4
 518:	fff78993          	add	s3,a5,-1
 51c:	99ba                	add	s3,s3,a4
 51e:	377d                	addw	a4,a4,-1
 520:	1702                	sll	a4,a4,0x20
 522:	9301                	srl	a4,a4,0x20
 524:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 528:	fff94583          	lbu	a1,-1(s2)
 52c:	8526                	mv	a0,s1
 52e:	00000097          	auipc	ra,0x0
 532:	f56080e7          	jalr	-170(ra) # 484 <putc>
  while(--i >= 0)
 536:	197d                	add	s2,s2,-1
 538:	ff3918e3          	bne	s2,s3,528 <printint+0x82>
 53c:	7902                	ld	s2,32(sp)
 53e:	69e2                	ld	s3,24(sp)
}
 540:	70e2                	ld	ra,56(sp)
 542:	7442                	ld	s0,48(sp)
 544:	74a2                	ld	s1,40(sp)
 546:	6121                	add	sp,sp,64
 548:	8082                	ret
    x = -xx;
 54a:	40b005bb          	negw	a1,a1
    neg = 1;
 54e:	4885                	li	a7,1
    x = -xx;
 550:	b7b5                	j	4bc <printint+0x16>

0000000000000552 <vprintf>:
{
 552:	715d                	add	sp,sp,-80
 554:	e486                	sd	ra,72(sp)
 556:	e0a2                	sd	s0,64(sp)
 558:	f84a                	sd	s2,48(sp)
 55a:	0880                	add	s0,sp,80
  for(i = 0; fmt[i]; i++){
 55c:	0005c903          	lbu	s2,0(a1)
 560:	1a090a63          	beqz	s2,714 <vprintf+0x1c2>
 564:	fc26                	sd	s1,56(sp)
 566:	f44e                	sd	s3,40(sp)
 568:	f052                	sd	s4,32(sp)
 56a:	ec56                	sd	s5,24(sp)
 56c:	e85a                	sd	s6,16(sp)
 56e:	e45e                	sd	s7,8(sp)
 570:	8aaa                	mv	s5,a0
 572:	8bb2                	mv	s7,a2
 574:	00158493          	add	s1,a1,1
  state = 0;
 578:	4981                	li	s3,0
    } else if(state == '%'){
 57a:	02500a13          	li	s4,37
 57e:	4b55                	li	s6,21
 580:	a839                	j	59e <vprintf+0x4c>
        putc(fd, c);
 582:	85ca                	mv	a1,s2
 584:	8556                	mv	a0,s5
 586:	00000097          	auipc	ra,0x0
 58a:	efe080e7          	jalr	-258(ra) # 484 <putc>
 58e:	a019                	j	594 <vprintf+0x42>
    } else if(state == '%'){
 590:	01498d63          	beq	s3,s4,5aa <vprintf+0x58>
  for(i = 0; fmt[i]; i++){
 594:	0485                	add	s1,s1,1
 596:	fff4c903          	lbu	s2,-1(s1)
 59a:	16090763          	beqz	s2,708 <vprintf+0x1b6>
    if(state == 0){
 59e:	fe0999e3          	bnez	s3,590 <vprintf+0x3e>
      if(c == '%'){
 5a2:	ff4910e3          	bne	s2,s4,582 <vprintf+0x30>
        state = '%';
 5a6:	89d2                	mv	s3,s4
 5a8:	b7f5                	j	594 <vprintf+0x42>
      if(c == 'd'){
 5aa:	13490463          	beq	s2,s4,6d2 <vprintf+0x180>
 5ae:	f9d9079b          	addw	a5,s2,-99
 5b2:	0ff7f793          	zext.b	a5,a5
 5b6:	12fb6763          	bltu	s6,a5,6e4 <vprintf+0x192>
 5ba:	f9d9079b          	addw	a5,s2,-99
 5be:	0ff7f713          	zext.b	a4,a5
 5c2:	12eb6163          	bltu	s6,a4,6e4 <vprintf+0x192>
 5c6:	00271793          	sll	a5,a4,0x2
 5ca:	00000717          	auipc	a4,0x0
 5ce:	54670713          	add	a4,a4,1350 # b10 <malloc+0x144>
 5d2:	97ba                	add	a5,a5,a4
 5d4:	439c                	lw	a5,0(a5)
 5d6:	97ba                	add	a5,a5,a4
 5d8:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 5da:	008b8913          	add	s2,s7,8
 5de:	4685                	li	a3,1
 5e0:	4629                	li	a2,10
 5e2:	000ba583          	lw	a1,0(s7)
 5e6:	8556                	mv	a0,s5
 5e8:	00000097          	auipc	ra,0x0
 5ec:	ebe080e7          	jalr	-322(ra) # 4a6 <printint>
 5f0:	8bca                	mv	s7,s2
      state = 0;
 5f2:	4981                	li	s3,0
 5f4:	b745                	j	594 <vprintf+0x42>
        printint(fd, va_arg(ap, uint64), 10, 0);
 5f6:	008b8913          	add	s2,s7,8
 5fa:	4681                	li	a3,0
 5fc:	4629                	li	a2,10
 5fe:	000ba583          	lw	a1,0(s7)
 602:	8556                	mv	a0,s5
 604:	00000097          	auipc	ra,0x0
 608:	ea2080e7          	jalr	-350(ra) # 4a6 <printint>
 60c:	8bca                	mv	s7,s2
      state = 0;
 60e:	4981                	li	s3,0
 610:	b751                	j	594 <vprintf+0x42>
        printint(fd, va_arg(ap, int), 16, 0);
 612:	008b8913          	add	s2,s7,8
 616:	4681                	li	a3,0
 618:	4641                	li	a2,16
 61a:	000ba583          	lw	a1,0(s7)
 61e:	8556                	mv	a0,s5
 620:	00000097          	auipc	ra,0x0
 624:	e86080e7          	jalr	-378(ra) # 4a6 <printint>
 628:	8bca                	mv	s7,s2
      state = 0;
 62a:	4981                	li	s3,0
 62c:	b7a5                	j	594 <vprintf+0x42>
 62e:	e062                	sd	s8,0(sp)
        printptr(fd, va_arg(ap, uint64));
 630:	008b8c13          	add	s8,s7,8
 634:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 638:	03000593          	li	a1,48
 63c:	8556                	mv	a0,s5
 63e:	00000097          	auipc	ra,0x0
 642:	e46080e7          	jalr	-442(ra) # 484 <putc>
  putc(fd, 'x');
 646:	07800593          	li	a1,120
 64a:	8556                	mv	a0,s5
 64c:	00000097          	auipc	ra,0x0
 650:	e38080e7          	jalr	-456(ra) # 484 <putc>
 654:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 656:	00000b97          	auipc	s7,0x0
 65a:	512b8b93          	add	s7,s7,1298 # b68 <digits>
 65e:	03c9d793          	srl	a5,s3,0x3c
 662:	97de                	add	a5,a5,s7
 664:	0007c583          	lbu	a1,0(a5)
 668:	8556                	mv	a0,s5
 66a:	00000097          	auipc	ra,0x0
 66e:	e1a080e7          	jalr	-486(ra) # 484 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 672:	0992                	sll	s3,s3,0x4
 674:	397d                	addw	s2,s2,-1
 676:	fe0914e3          	bnez	s2,65e <vprintf+0x10c>
        printptr(fd, va_arg(ap, uint64));
 67a:	8be2                	mv	s7,s8
      state = 0;
 67c:	4981                	li	s3,0
 67e:	6c02                	ld	s8,0(sp)
 680:	bf11                	j	594 <vprintf+0x42>
        s = va_arg(ap, char*);
 682:	008b8993          	add	s3,s7,8
 686:	000bb903          	ld	s2,0(s7)
        if(s == 0)
 68a:	02090163          	beqz	s2,6ac <vprintf+0x15a>
        while(*s != 0){
 68e:	00094583          	lbu	a1,0(s2)
 692:	c9a5                	beqz	a1,702 <vprintf+0x1b0>
          putc(fd, *s);
 694:	8556                	mv	a0,s5
 696:	00000097          	auipc	ra,0x0
 69a:	dee080e7          	jalr	-530(ra) # 484 <putc>
          s++;
 69e:	0905                	add	s2,s2,1
        while(*s != 0){
 6a0:	00094583          	lbu	a1,0(s2)
 6a4:	f9e5                	bnez	a1,694 <vprintf+0x142>
        s = va_arg(ap, char*);
 6a6:	8bce                	mv	s7,s3
      state = 0;
 6a8:	4981                	li	s3,0
 6aa:	b5ed                	j	594 <vprintf+0x42>
          s = "(null)";
 6ac:	00000917          	auipc	s2,0x0
 6b0:	45c90913          	add	s2,s2,1116 # b08 <malloc+0x13c>
        while(*s != 0){
 6b4:	02800593          	li	a1,40
 6b8:	bff1                	j	694 <vprintf+0x142>
        putc(fd, va_arg(ap, uint));
 6ba:	008b8913          	add	s2,s7,8
 6be:	000bc583          	lbu	a1,0(s7)
 6c2:	8556                	mv	a0,s5
 6c4:	00000097          	auipc	ra,0x0
 6c8:	dc0080e7          	jalr	-576(ra) # 484 <putc>
 6cc:	8bca                	mv	s7,s2
      state = 0;
 6ce:	4981                	li	s3,0
 6d0:	b5d1                	j	594 <vprintf+0x42>
        putc(fd, c);
 6d2:	02500593          	li	a1,37
 6d6:	8556                	mv	a0,s5
 6d8:	00000097          	auipc	ra,0x0
 6dc:	dac080e7          	jalr	-596(ra) # 484 <putc>
      state = 0;
 6e0:	4981                	li	s3,0
 6e2:	bd4d                	j	594 <vprintf+0x42>
        putc(fd, '%');
 6e4:	02500593          	li	a1,37
 6e8:	8556                	mv	a0,s5
 6ea:	00000097          	auipc	ra,0x0
 6ee:	d9a080e7          	jalr	-614(ra) # 484 <putc>
        putc(fd, c);
 6f2:	85ca                	mv	a1,s2
 6f4:	8556                	mv	a0,s5
 6f6:	00000097          	auipc	ra,0x0
 6fa:	d8e080e7          	jalr	-626(ra) # 484 <putc>
      state = 0;
 6fe:	4981                	li	s3,0
 700:	bd51                	j	594 <vprintf+0x42>
        s = va_arg(ap, char*);
 702:	8bce                	mv	s7,s3
      state = 0;
 704:	4981                	li	s3,0
 706:	b579                	j	594 <vprintf+0x42>
 708:	74e2                	ld	s1,56(sp)
 70a:	79a2                	ld	s3,40(sp)
 70c:	7a02                	ld	s4,32(sp)
 70e:	6ae2                	ld	s5,24(sp)
 710:	6b42                	ld	s6,16(sp)
 712:	6ba2                	ld	s7,8(sp)
}
 714:	60a6                	ld	ra,72(sp)
 716:	6406                	ld	s0,64(sp)
 718:	7942                	ld	s2,48(sp)
 71a:	6161                	add	sp,sp,80
 71c:	8082                	ret

000000000000071e <fprintf>:
{
 71e:	715d                	add	sp,sp,-80
 720:	ec06                	sd	ra,24(sp)
 722:	e822                	sd	s0,16(sp)
 724:	1000                	add	s0,sp,32
 726:	e010                	sd	a2,0(s0)
 728:	e414                	sd	a3,8(s0)
 72a:	e818                	sd	a4,16(s0)
 72c:	ec1c                	sd	a5,24(s0)
 72e:	03043023          	sd	a6,32(s0)
 732:	03143423          	sd	a7,40(s0)
  va_start(ap, fmt);
 736:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 73a:	8622                	mv	a2,s0
 73c:	00000097          	auipc	ra,0x0
 740:	e16080e7          	jalr	-490(ra) # 552 <vprintf>
}
 744:	60e2                	ld	ra,24(sp)
 746:	6442                	ld	s0,16(sp)
 748:	6161                	add	sp,sp,80
 74a:	8082                	ret

000000000000074c <printf>:
{
 74c:	711d                	add	sp,sp,-96
 74e:	ec06                	sd	ra,24(sp)
 750:	e822                	sd	s0,16(sp)
 752:	1000                	add	s0,sp,32
 754:	e40c                	sd	a1,8(s0)
 756:	e810                	sd	a2,16(s0)
 758:	ec14                	sd	a3,24(s0)
 75a:	f018                	sd	a4,32(s0)
 75c:	f41c                	sd	a5,40(s0)
 75e:	03043823          	sd	a6,48(s0)
 762:	03143c23          	sd	a7,56(s0)
  va_start(ap, fmt);
 766:	00840613          	add	a2,s0,8
 76a:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 76e:	85aa                	mv	a1,a0
 770:	4505                	li	a0,1
 772:	00000097          	auipc	ra,0x0
 776:	de0080e7          	jalr	-544(ra) # 552 <vprintf>
}
 77a:	60e2                	ld	ra,24(sp)
 77c:	6442                	ld	s0,16(sp)
 77e:	6125                	add	sp,sp,96
 780:	8082                	ret

0000000000000782 <snprintf>:

int
snprintf(char *buf, int sz, char *fmt, ...)
{
 782:	7135                	add	sp,sp,-160
 784:	f486                	sd	ra,104(sp)
 786:	f0a2                	sd	s0,96(sp)
 788:	eca6                	sd	s1,88(sp)
 78a:	1880                	add	s0,sp,112
 78c:	e414                	sd	a3,8(s0)
 78e:	e818                	sd	a4,16(s0)
 790:	ec1c                	sd	a5,24(s0)
 792:	03043023          	sd	a6,32(s0)
 796:	03143423          	sd	a7,40(s0)
  va_list ap;
  int i, c;
  int off = 0;
  char *s;

  if (fmt == 0)
 79a:	16060b63          	beqz	a2,910 <snprintf+0x18e>
 79e:	e8ca                	sd	s2,80(sp)
 7a0:	e4ce                	sd	s3,72(sp)
 7a2:	fc56                	sd	s5,56(sp)
 7a4:	f85a                	sd	s6,48(sp)
 7a6:	8b2a                	mv	s6,a0
 7a8:	8aae                	mv	s5,a1
 7aa:	89b2                	mv	s3,a2
    return -1;

  va_start(ap, fmt);
 7ac:	00840793          	add	a5,s0,8
 7b0:	f8f43c23          	sd	a5,-104(s0)
  int off = 0;
 7b4:	4481                	li	s1,0
  for(i = 0; off < sz && (c = fmt[i] & 0xff) != 0; i++){
 7b6:	4901                	li	s2,0
 7b8:	00b05f63          	blez	a1,7d6 <snprintf+0x54>
 7bc:	e0d2                	sd	s4,64(sp)
 7be:	f45e                	sd	s7,40(sp)
 7c0:	f062                	sd	s8,32(sp)
 7c2:	ec66                	sd	s9,24(sp)
    if(c != '%'){
 7c4:	02500a13          	li	s4,37
      continue;
    }
    c = fmt[++i] & 0xff;
    if(c == 0)
      break;
    switch(c){
 7c8:	07300b93          	li	s7,115
 7cc:	07800c93          	li	s9,120
 7d0:	06400c13          	li	s8,100
 7d4:	a839                	j	7f2 <snprintf+0x70>
      off += sputc(buf+off, '%');
      off += sputc(buf+off, c);
      break;
    }
  }
  return off;
 7d6:	4481                	li	s1,0
 7d8:	6946                	ld	s2,80(sp)
 7da:	69a6                	ld	s3,72(sp)
 7dc:	7ae2                	ld	s5,56(sp)
 7de:	7b42                	ld	s6,48(sp)
 7e0:	a0cd                	j	8c2 <snprintf+0x140>
  *s = c;
 7e2:	009b0733          	add	a4,s6,s1
 7e6:	00f70023          	sb	a5,0(a4)
      off += sputc(buf+off, c);
 7ea:	2485                	addw	s1,s1,1
  for(i = 0; off < sz && (c = fmt[i] & 0xff) != 0; i++){
 7ec:	2905                	addw	s2,s2,1
 7ee:	1554d563          	bge	s1,s5,938 <snprintf+0x1b6>
 7f2:	012987b3          	add	a5,s3,s2
 7f6:	0007c783          	lbu	a5,0(a5)
 7fa:	0007871b          	sext.w	a4,a5
 7fe:	10078063          	beqz	a5,8fe <snprintf+0x17c>
    if(c != '%'){
 802:	ff4710e3          	bne	a4,s4,7e2 <snprintf+0x60>
    c = fmt[++i] & 0xff;
 806:	2905                	addw	s2,s2,1
 808:	012987b3          	add	a5,s3,s2
 80c:	0007c783          	lbu	a5,0(a5)
    if(c == 0)
 810:	10078263          	beqz	a5,914 <snprintf+0x192>
    switch(c){
 814:	05778c63          	beq	a5,s7,86c <snprintf+0xea>
 818:	02fbe763          	bltu	s7,a5,846 <snprintf+0xc4>
 81c:	0d478063          	beq	a5,s4,8dc <snprintf+0x15a>
 820:	0d879463          	bne	a5,s8,8e8 <snprintf+0x166>
      off += sprintint(buf+off, va_arg(ap, int), 10, 1);
 824:	f9843783          	ld	a5,-104(s0)
 828:	00878713          	add	a4,a5,8
 82c:	f8e43c23          	sd	a4,-104(s0)
 830:	4685                	li	a3,1
 832:	4629                	li	a2,10
 834:	438c                	lw	a1,0(a5)
 836:	009b0533          	add	a0,s6,s1
 83a:	00000097          	auipc	ra,0x0
 83e:	bb0080e7          	jalr	-1104(ra) # 3ea <sprintint>
 842:	9ca9                	addw	s1,s1,a0
      break;
 844:	b765                	j	7ec <snprintf+0x6a>
    switch(c){
 846:	0b979163          	bne	a5,s9,8e8 <snprintf+0x166>
      off += sprintint(buf+off, va_arg(ap, int), 16, 1);
 84a:	f9843783          	ld	a5,-104(s0)
 84e:	00878713          	add	a4,a5,8
 852:	f8e43c23          	sd	a4,-104(s0)
 856:	4685                	li	a3,1
 858:	4641                	li	a2,16
 85a:	438c                	lw	a1,0(a5)
 85c:	009b0533          	add	a0,s6,s1
 860:	00000097          	auipc	ra,0x0
 864:	b8a080e7          	jalr	-1142(ra) # 3ea <sprintint>
 868:	9ca9                	addw	s1,s1,a0
      break;
 86a:	b749                	j	7ec <snprintf+0x6a>
      if((s = va_arg(ap, char*)) == 0)
 86c:	f9843783          	ld	a5,-104(s0)
 870:	00878713          	add	a4,a5,8
 874:	f8e43c23          	sd	a4,-104(s0)
 878:	6388                	ld	a0,0(a5)
 87a:	c931                	beqz	a0,8ce <snprintf+0x14c>
      for(; *s && off < sz; s++)
 87c:	00054703          	lbu	a4,0(a0)
 880:	d735                	beqz	a4,7ec <snprintf+0x6a>
 882:	0b54d263          	bge	s1,s5,926 <snprintf+0x1a4>
 886:	009b06b3          	add	a3,s6,s1
 88a:	409a863b          	subw	a2,s5,s1
 88e:	1602                	sll	a2,a2,0x20
 890:	9201                	srl	a2,a2,0x20
 892:	962a                	add	a2,a2,a0
 894:	87aa                	mv	a5,a0
        off += sputc(buf+off, *s);
 896:	0014859b          	addw	a1,s1,1
 89a:	9d89                	subw	a1,a1,a0
  *s = c;
 89c:	00e68023          	sb	a4,0(a3)
        off += sputc(buf+off, *s);
 8a0:	00f584bb          	addw	s1,a1,a5
      for(; *s && off < sz; s++)
 8a4:	0785                	add	a5,a5,1
 8a6:	0007c703          	lbu	a4,0(a5)
 8aa:	d329                	beqz	a4,7ec <snprintf+0x6a>
 8ac:	0685                	add	a3,a3,1
 8ae:	fec797e3          	bne	a5,a2,89c <snprintf+0x11a>
 8b2:	6946                	ld	s2,80(sp)
 8b4:	69a6                	ld	s3,72(sp)
 8b6:	6a06                	ld	s4,64(sp)
 8b8:	7ae2                	ld	s5,56(sp)
 8ba:	7b42                	ld	s6,48(sp)
 8bc:	7ba2                	ld	s7,40(sp)
 8be:	7c02                	ld	s8,32(sp)
 8c0:	6ce2                	ld	s9,24(sp)
 8c2:	8526                	mv	a0,s1
 8c4:	70a6                	ld	ra,104(sp)
 8c6:	7406                	ld	s0,96(sp)
 8c8:	64e6                	ld	s1,88(sp)
 8ca:	610d                	add	sp,sp,160
 8cc:	8082                	ret
      for(; *s && off < sz; s++)
 8ce:	02800713          	li	a4,40
        s = "(null)";
 8d2:	00000517          	auipc	a0,0x0
 8d6:	23650513          	add	a0,a0,566 # b08 <malloc+0x13c>
 8da:	b765                	j	882 <snprintf+0x100>
  *s = c;
 8dc:	009b07b3          	add	a5,s6,s1
 8e0:	01478023          	sb	s4,0(a5)
      off += sputc(buf+off, '%');
 8e4:	2485                	addw	s1,s1,1
      break;
 8e6:	b719                	j	7ec <snprintf+0x6a>
  *s = c;
 8e8:	009b0733          	add	a4,s6,s1
 8ec:	01470023          	sb	s4,0(a4)
      off += sputc(buf+off, c);
 8f0:	0014871b          	addw	a4,s1,1
  *s = c;
 8f4:	975a                	add	a4,a4,s6
 8f6:	00f70023          	sb	a5,0(a4)
      off += sputc(buf+off, c);
 8fa:	2489                	addw	s1,s1,2
      break;
 8fc:	bdc5                	j	7ec <snprintf+0x6a>
 8fe:	6946                	ld	s2,80(sp)
 900:	69a6                	ld	s3,72(sp)
 902:	6a06                	ld	s4,64(sp)
 904:	7ae2                	ld	s5,56(sp)
 906:	7b42                	ld	s6,48(sp)
 908:	7ba2                	ld	s7,40(sp)
 90a:	7c02                	ld	s8,32(sp)
 90c:	6ce2                	ld	s9,24(sp)
 90e:	bf55                	j	8c2 <snprintf+0x140>
    return -1;
 910:	54fd                	li	s1,-1
 912:	bf45                	j	8c2 <snprintf+0x140>
 914:	6946                	ld	s2,80(sp)
 916:	69a6                	ld	s3,72(sp)
 918:	6a06                	ld	s4,64(sp)
 91a:	7ae2                	ld	s5,56(sp)
 91c:	7b42                	ld	s6,48(sp)
 91e:	7ba2                	ld	s7,40(sp)
 920:	7c02                	ld	s8,32(sp)
 922:	6ce2                	ld	s9,24(sp)
 924:	bf79                	j	8c2 <snprintf+0x140>
 926:	6946                	ld	s2,80(sp)
 928:	69a6                	ld	s3,72(sp)
 92a:	6a06                	ld	s4,64(sp)
 92c:	7ae2                	ld	s5,56(sp)
 92e:	7b42                	ld	s6,48(sp)
 930:	7ba2                	ld	s7,40(sp)
 932:	7c02                	ld	s8,32(sp)
 934:	6ce2                	ld	s9,24(sp)
 936:	b771                	j	8c2 <snprintf+0x140>
 938:	6946                	ld	s2,80(sp)
 93a:	69a6                	ld	s3,72(sp)
 93c:	6a06                	ld	s4,64(sp)
 93e:	7ae2                	ld	s5,56(sp)
 940:	7b42                	ld	s6,48(sp)
 942:	7ba2                	ld	s7,40(sp)
 944:	7c02                	ld	s8,32(sp)
 946:	6ce2                	ld	s9,24(sp)
 948:	bfad                	j	8c2 <snprintf+0x140>

000000000000094a <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 94a:	1141                	add	sp,sp,-16
 94c:	e422                	sd	s0,8(sp)
 94e:	0800                	add	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 950:	ff050693          	add	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 954:	00000797          	auipc	a5,0x0
 958:	22c7b783          	ld	a5,556(a5) # b80 <freep>
 95c:	a02d                	j	986 <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 95e:	4618                	lw	a4,8(a2)
 960:	9f2d                	addw	a4,a4,a1
 962:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 966:	6398                	ld	a4,0(a5)
 968:	6310                	ld	a2,0(a4)
 96a:	a83d                	j	9a8 <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 96c:	ff852703          	lw	a4,-8(a0)
 970:	9f31                	addw	a4,a4,a2
 972:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 974:	ff053683          	ld	a3,-16(a0)
 978:	a091                	j	9bc <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 97a:	6398                	ld	a4,0(a5)
 97c:	00e7e463          	bltu	a5,a4,984 <free+0x3a>
 980:	00e6ea63          	bltu	a3,a4,994 <free+0x4a>
{
 984:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 986:	fed7fae3          	bgeu	a5,a3,97a <free+0x30>
 98a:	6398                	ld	a4,0(a5)
 98c:	00e6e463          	bltu	a3,a4,994 <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 990:	fee7eae3          	bltu	a5,a4,984 <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 994:	ff852583          	lw	a1,-8(a0)
 998:	6390                	ld	a2,0(a5)
 99a:	02059813          	sll	a6,a1,0x20
 99e:	01c85713          	srl	a4,a6,0x1c
 9a2:	9736                	add	a4,a4,a3
 9a4:	fae60de3          	beq	a2,a4,95e <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 9a8:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 9ac:	4790                	lw	a2,8(a5)
 9ae:	02061593          	sll	a1,a2,0x20
 9b2:	01c5d713          	srl	a4,a1,0x1c
 9b6:	973e                	add	a4,a4,a5
 9b8:	fae68ae3          	beq	a3,a4,96c <free+0x22>
    p->s.ptr = bp->s.ptr;
 9bc:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 9be:	00000717          	auipc	a4,0x0
 9c2:	1cf73123          	sd	a5,450(a4) # b80 <freep>
}
 9c6:	6422                	ld	s0,8(sp)
 9c8:	0141                	add	sp,sp,16
 9ca:	8082                	ret

00000000000009cc <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 9cc:	7139                	add	sp,sp,-64
 9ce:	fc06                	sd	ra,56(sp)
 9d0:	f822                	sd	s0,48(sp)
 9d2:	f426                	sd	s1,40(sp)
 9d4:	ec4e                	sd	s3,24(sp)
 9d6:	0080                	add	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 9d8:	02051493          	sll	s1,a0,0x20
 9dc:	9081                	srl	s1,s1,0x20
 9de:	04bd                	add	s1,s1,15
 9e0:	8091                	srl	s1,s1,0x4
 9e2:	0014899b          	addw	s3,s1,1
 9e6:	0485                	add	s1,s1,1
  if((prevp = freep) == 0){
 9e8:	00000517          	auipc	a0,0x0
 9ec:	19853503          	ld	a0,408(a0) # b80 <freep>
 9f0:	c915                	beqz	a0,a24 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 9f2:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 9f4:	4798                	lw	a4,8(a5)
 9f6:	08977e63          	bgeu	a4,s1,a92 <malloc+0xc6>
 9fa:	f04a                	sd	s2,32(sp)
 9fc:	e852                	sd	s4,16(sp)
 9fe:	e456                	sd	s5,8(sp)
 a00:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 a02:	8a4e                	mv	s4,s3
 a04:	0009871b          	sext.w	a4,s3
 a08:	6685                	lui	a3,0x1
 a0a:	00d77363          	bgeu	a4,a3,a10 <malloc+0x44>
 a0e:	6a05                	lui	s4,0x1
 a10:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 a14:	004a1a1b          	sllw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 a18:	00000917          	auipc	s2,0x0
 a1c:	16890913          	add	s2,s2,360 # b80 <freep>
  if(p == (char*)-1)
 a20:	5afd                	li	s5,-1
 a22:	a091                	j	a66 <malloc+0x9a>
 a24:	f04a                	sd	s2,32(sp)
 a26:	e852                	sd	s4,16(sp)
 a28:	e456                	sd	s5,8(sp)
 a2a:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 a2c:	00000797          	auipc	a5,0x0
 a30:	15c78793          	add	a5,a5,348 # b88 <base>
 a34:	00000717          	auipc	a4,0x0
 a38:	14f73623          	sd	a5,332(a4) # b80 <freep>
 a3c:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 a3e:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 a42:	b7c1                	j	a02 <malloc+0x36>
        prevp->s.ptr = p->s.ptr;
 a44:	6398                	ld	a4,0(a5)
 a46:	e118                	sd	a4,0(a0)
 a48:	a08d                	j	aaa <malloc+0xde>
  hp->s.size = nu;
 a4a:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 a4e:	0541                	add	a0,a0,16
 a50:	00000097          	auipc	ra,0x0
 a54:	efa080e7          	jalr	-262(ra) # 94a <free>
  return freep;
 a58:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 a5c:	c13d                	beqz	a0,ac2 <malloc+0xf6>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a5e:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 a60:	4798                	lw	a4,8(a5)
 a62:	02977463          	bgeu	a4,s1,a8a <malloc+0xbe>
    if(p == freep)
 a66:	00093703          	ld	a4,0(s2)
 a6a:	853e                	mv	a0,a5
 a6c:	fef719e3          	bne	a4,a5,a5e <malloc+0x92>
  p = sbrk(nu * sizeof(Header));
 a70:	8552                	mv	a0,s4
 a72:	00000097          	auipc	ra,0x0
 a76:	92a080e7          	jalr	-1750(ra) # 39c <sbrk>
  if(p == (char*)-1)
 a7a:	fd5518e3          	bne	a0,s5,a4a <malloc+0x7e>
        return 0;
 a7e:	4501                	li	a0,0
 a80:	7902                	ld	s2,32(sp)
 a82:	6a42                	ld	s4,16(sp)
 a84:	6aa2                	ld	s5,8(sp)
 a86:	6b02                	ld	s6,0(sp)
 a88:	a03d                	j	ab6 <malloc+0xea>
 a8a:	7902                	ld	s2,32(sp)
 a8c:	6a42                	ld	s4,16(sp)
 a8e:	6aa2                	ld	s5,8(sp)
 a90:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 a92:	fae489e3          	beq	s1,a4,a44 <malloc+0x78>
        p->s.size -= nunits;
 a96:	4137073b          	subw	a4,a4,s3
 a9a:	c798                	sw	a4,8(a5)
        p += p->s.size;
 a9c:	02071693          	sll	a3,a4,0x20
 aa0:	01c6d713          	srl	a4,a3,0x1c
 aa4:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 aa6:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 aaa:	00000717          	auipc	a4,0x0
 aae:	0ca73b23          	sd	a0,214(a4) # b80 <freep>
      return (void*)(p + 1);
 ab2:	01078513          	add	a0,a5,16
  }
}
 ab6:	70e2                	ld	ra,56(sp)
 ab8:	7442                	ld	s0,48(sp)
 aba:	74a2                	ld	s1,40(sp)
 abc:	69e2                	ld	s3,24(sp)
 abe:	6121                	add	sp,sp,64
 ac0:	8082                	ret
 ac2:	7902                	ld	s2,32(sp)
 ac4:	6a42                	ld	s4,16(sp)
 ac6:	6aa2                	ld	s5,8(sp)
 ac8:	6b02                	ld	s6,0(sp)
 aca:	b7f5                	j	ab6 <malloc+0xea>
