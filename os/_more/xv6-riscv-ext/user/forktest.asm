
user/_forktest:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <print>:

#define N  1000

void
print(const char *s)
{
   0:	1101                	add	sp,sp,-32
   2:	ec06                	sd	ra,24(sp)
   4:	e822                	sd	s0,16(sp)
   6:	e426                	sd	s1,8(sp)
   8:	1000                	add	s0,sp,32
   a:	84aa                	mv	s1,a0
  write(1, s, strlen(s));
   c:	00000097          	auipc	ra,0x0
  10:	152080e7          	jalr	338(ra) # 15e <strlen>
  14:	0005061b          	sext.w	a2,a0
  18:	85a6                	mv	a1,s1
  1a:	4505                	li	a0,1
  1c:	00000097          	auipc	ra,0x0
  20:	3b4080e7          	jalr	948(ra) # 3d0 <write>
}
  24:	60e2                	ld	ra,24(sp)
  26:	6442                	ld	s0,16(sp)
  28:	64a2                	ld	s1,8(sp)
  2a:	6105                	add	sp,sp,32
  2c:	8082                	ret

000000000000002e <forktest>:

void
forktest(void)
{
  2e:	1101                	add	sp,sp,-32
  30:	ec06                	sd	ra,24(sp)
  32:	e822                	sd	s0,16(sp)
  34:	e426                	sd	s1,8(sp)
  36:	e04a                	sd	s2,0(sp)
  38:	1000                	add	s0,sp,32
  int n, pid;

  print("fork test\n");
  3a:	00000517          	auipc	a0,0x0
  3e:	44e50513          	add	a0,a0,1102 # 488 <connect+0xc>
  42:	00000097          	auipc	ra,0x0
  46:	fbe080e7          	jalr	-66(ra) # 0 <print>

  for(n=0; n<N; n++){
  4a:	4481                	li	s1,0
  4c:	3e800913          	li	s2,1000
    pid = fork();
  50:	00000097          	auipc	ra,0x0
  54:	358080e7          	jalr	856(ra) # 3a8 <fork>
    if(pid < 0)
  58:	06054163          	bltz	a0,ba <forktest+0x8c>
      break;
    if(pid == 0)
  5c:	c10d                	beqz	a0,7e <forktest+0x50>
  for(n=0; n<N; n++){
  5e:	2485                	addw	s1,s1,1
  60:	ff2498e3          	bne	s1,s2,50 <forktest+0x22>
      exit(0);
  }

  if(n == N){
    print("fork claimed to work N times!\n");
  64:	00000517          	auipc	a0,0x0
  68:	47450513          	add	a0,a0,1140 # 4d8 <connect+0x5c>
  6c:	00000097          	auipc	ra,0x0
  70:	f94080e7          	jalr	-108(ra) # 0 <print>
    exit(1);
  74:	4505                	li	a0,1
  76:	00000097          	auipc	ra,0x0
  7a:	33a080e7          	jalr	826(ra) # 3b0 <exit>
      exit(0);
  7e:	00000097          	auipc	ra,0x0
  82:	332080e7          	jalr	818(ra) # 3b0 <exit>
  }

  for(; n > 0; n--){
    if(wait(0) < 0){
      print("wait stopped early\n");
  86:	00000517          	auipc	a0,0x0
  8a:	41250513          	add	a0,a0,1042 # 498 <connect+0x1c>
  8e:	00000097          	auipc	ra,0x0
  92:	f72080e7          	jalr	-142(ra) # 0 <print>
      exit(1);
  96:	4505                	li	a0,1
  98:	00000097          	auipc	ra,0x0
  9c:	318080e7          	jalr	792(ra) # 3b0 <exit>
    }
  }

  if(wait(0) != -1){
    print("wait got too many\n");
  a0:	00000517          	auipc	a0,0x0
  a4:	41050513          	add	a0,a0,1040 # 4b0 <connect+0x34>
  a8:	00000097          	auipc	ra,0x0
  ac:	f58080e7          	jalr	-168(ra) # 0 <print>
    exit(1);
  b0:	4505                	li	a0,1
  b2:	00000097          	auipc	ra,0x0
  b6:	2fe080e7          	jalr	766(ra) # 3b0 <exit>
  for(; n > 0; n--){
  ba:	00905b63          	blez	s1,d0 <forktest+0xa2>
    if(wait(0) < 0){
  be:	4501                	li	a0,0
  c0:	00000097          	auipc	ra,0x0
  c4:	2f8080e7          	jalr	760(ra) # 3b8 <wait>
  c8:	fa054fe3          	bltz	a0,86 <forktest+0x58>
  for(; n > 0; n--){
  cc:	34fd                	addw	s1,s1,-1
  ce:	f8e5                	bnez	s1,be <forktest+0x90>
  if(wait(0) != -1){
  d0:	4501                	li	a0,0
  d2:	00000097          	auipc	ra,0x0
  d6:	2e6080e7          	jalr	742(ra) # 3b8 <wait>
  da:	57fd                	li	a5,-1
  dc:	fcf512e3          	bne	a0,a5,a0 <forktest+0x72>
  }

  print("fork test OK\n");
  e0:	00000517          	auipc	a0,0x0
  e4:	3e850513          	add	a0,a0,1000 # 4c8 <connect+0x4c>
  e8:	00000097          	auipc	ra,0x0
  ec:	f18080e7          	jalr	-232(ra) # 0 <print>
}
  f0:	60e2                	ld	ra,24(sp)
  f2:	6442                	ld	s0,16(sp)
  f4:	64a2                	ld	s1,8(sp)
  f6:	6902                	ld	s2,0(sp)
  f8:	6105                	add	sp,sp,32
  fa:	8082                	ret

00000000000000fc <main>:

int
main(void)
{
  fc:	1141                	add	sp,sp,-16
  fe:	e406                	sd	ra,8(sp)
 100:	e022                	sd	s0,0(sp)
 102:	0800                	add	s0,sp,16
  forktest();
 104:	00000097          	auipc	ra,0x0
 108:	f2a080e7          	jalr	-214(ra) # 2e <forktest>
  exit(0);
 10c:	4501                	li	a0,0
 10e:	00000097          	auipc	ra,0x0
 112:	2a2080e7          	jalr	674(ra) # 3b0 <exit>

0000000000000116 <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
 116:	1141                	add	sp,sp,-16
 118:	e422                	sd	s0,8(sp)
 11a:	0800                	add	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 11c:	87aa                	mv	a5,a0
 11e:	0585                	add	a1,a1,1
 120:	0785                	add	a5,a5,1
 122:	fff5c703          	lbu	a4,-1(a1)
 126:	fee78fa3          	sb	a4,-1(a5)
 12a:	fb75                	bnez	a4,11e <strcpy+0x8>
    ;
  return os;
}
 12c:	6422                	ld	s0,8(sp)
 12e:	0141                	add	sp,sp,16
 130:	8082                	ret

0000000000000132 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 132:	1141                	add	sp,sp,-16
 134:	e422                	sd	s0,8(sp)
 136:	0800                	add	s0,sp,16
  while(*p && *p == *q)
 138:	00054783          	lbu	a5,0(a0)
 13c:	cb91                	beqz	a5,150 <strcmp+0x1e>
 13e:	0005c703          	lbu	a4,0(a1)
 142:	00f71763          	bne	a4,a5,150 <strcmp+0x1e>
    p++, q++;
 146:	0505                	add	a0,a0,1
 148:	0585                	add	a1,a1,1
  while(*p && *p == *q)
 14a:	00054783          	lbu	a5,0(a0)
 14e:	fbe5                	bnez	a5,13e <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 150:	0005c503          	lbu	a0,0(a1)
}
 154:	40a7853b          	subw	a0,a5,a0
 158:	6422                	ld	s0,8(sp)
 15a:	0141                	add	sp,sp,16
 15c:	8082                	ret

000000000000015e <strlen>:

uint
strlen(const char *s)
{
 15e:	1141                	add	sp,sp,-16
 160:	e422                	sd	s0,8(sp)
 162:	0800                	add	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 164:	00054783          	lbu	a5,0(a0)
 168:	cf91                	beqz	a5,184 <strlen+0x26>
 16a:	0505                	add	a0,a0,1
 16c:	87aa                	mv	a5,a0
 16e:	86be                	mv	a3,a5
 170:	0785                	add	a5,a5,1
 172:	fff7c703          	lbu	a4,-1(a5)
 176:	ff65                	bnez	a4,16e <strlen+0x10>
 178:	40a6853b          	subw	a0,a3,a0
 17c:	2505                	addw	a0,a0,1
    ;
  return n;
}
 17e:	6422                	ld	s0,8(sp)
 180:	0141                	add	sp,sp,16
 182:	8082                	ret
  for(n = 0; s[n]; n++)
 184:	4501                	li	a0,0
 186:	bfe5                	j	17e <strlen+0x20>

0000000000000188 <strcat>:

char *
strcat(char *dst, char *src)
{
 188:	1141                	add	sp,sp,-16
 18a:	e422                	sd	s0,8(sp)
 18c:	0800                	add	s0,sp,16
  char *s = dst;
  while (*dst)
 18e:	00054783          	lbu	a5,0(a0)
 192:	c385                	beqz	a5,1b2 <strcat+0x2a>
 194:	87aa                	mv	a5,a0
    dst++;
 196:	0785                	add	a5,a5,1
  while (*dst)
 198:	0007c703          	lbu	a4,0(a5)
 19c:	ff6d                	bnez	a4,196 <strcat+0xe>
  while ((*dst++ = *src++) != 0);
 19e:	0585                	add	a1,a1,1
 1a0:	0785                	add	a5,a5,1
 1a2:	fff5c703          	lbu	a4,-1(a1)
 1a6:	fee78fa3          	sb	a4,-1(a5)
 1aa:	fb75                	bnez	a4,19e <strcat+0x16>

  return s;
}
 1ac:	6422                	ld	s0,8(sp)
 1ae:	0141                	add	sp,sp,16
 1b0:	8082                	ret
  while (*dst)
 1b2:	87aa                	mv	a5,a0
 1b4:	b7ed                	j	19e <strcat+0x16>

00000000000001b6 <memset>:

void*
memset(void *dst, int c, uint n)
{
 1b6:	1141                	add	sp,sp,-16
 1b8:	e422                	sd	s0,8(sp)
 1ba:	0800                	add	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 1bc:	ca19                	beqz	a2,1d2 <memset+0x1c>
 1be:	87aa                	mv	a5,a0
 1c0:	1602                	sll	a2,a2,0x20
 1c2:	9201                	srl	a2,a2,0x20
 1c4:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 1c8:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 1cc:	0785                	add	a5,a5,1
 1ce:	fee79de3          	bne	a5,a4,1c8 <memset+0x12>
  }
  return dst;
}
 1d2:	6422                	ld	s0,8(sp)
 1d4:	0141                	add	sp,sp,16
 1d6:	8082                	ret

00000000000001d8 <strchr>:

char*
strchr(const char *s, char c)
{
 1d8:	1141                	add	sp,sp,-16
 1da:	e422                	sd	s0,8(sp)
 1dc:	0800                	add	s0,sp,16
  for(; *s; s++)
 1de:	00054783          	lbu	a5,0(a0)
 1e2:	cb99                	beqz	a5,1f8 <strchr+0x20>
    if(*s == c)
 1e4:	00f58763          	beq	a1,a5,1f2 <strchr+0x1a>
  for(; *s; s++)
 1e8:	0505                	add	a0,a0,1
 1ea:	00054783          	lbu	a5,0(a0)
 1ee:	fbfd                	bnez	a5,1e4 <strchr+0xc>
      return (char*)s;
  return 0;
 1f0:	4501                	li	a0,0
}
 1f2:	6422                	ld	s0,8(sp)
 1f4:	0141                	add	sp,sp,16
 1f6:	8082                	ret
  return 0;
 1f8:	4501                	li	a0,0
 1fa:	bfe5                	j	1f2 <strchr+0x1a>

00000000000001fc <gets>:

char*
gets(char *buf, int max)
{
 1fc:	711d                	add	sp,sp,-96
 1fe:	ec86                	sd	ra,88(sp)
 200:	e8a2                	sd	s0,80(sp)
 202:	e4a6                	sd	s1,72(sp)
 204:	e0ca                	sd	s2,64(sp)
 206:	fc4e                	sd	s3,56(sp)
 208:	f852                	sd	s4,48(sp)
 20a:	f456                	sd	s5,40(sp)
 20c:	f05a                	sd	s6,32(sp)
 20e:	ec5e                	sd	s7,24(sp)
 210:	1080                	add	s0,sp,96
 212:	8baa                	mv	s7,a0
 214:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 216:	892a                	mv	s2,a0
 218:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 21a:	4aa9                	li	s5,10
 21c:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 21e:	89a6                	mv	s3,s1
 220:	2485                	addw	s1,s1,1
 222:	0344d863          	bge	s1,s4,252 <gets+0x56>
    cc = read(0, &c, 1);
 226:	4605                	li	a2,1
 228:	faf40593          	add	a1,s0,-81
 22c:	4501                	li	a0,0
 22e:	00000097          	auipc	ra,0x0
 232:	19a080e7          	jalr	410(ra) # 3c8 <read>
    if(cc < 1)
 236:	00a05e63          	blez	a0,252 <gets+0x56>
    buf[i++] = c;
 23a:	faf44783          	lbu	a5,-81(s0)
 23e:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 242:	01578763          	beq	a5,s5,250 <gets+0x54>
 246:	0905                	add	s2,s2,1
 248:	fd679be3          	bne	a5,s6,21e <gets+0x22>
    buf[i++] = c;
 24c:	89a6                	mv	s3,s1
 24e:	a011                	j	252 <gets+0x56>
 250:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 252:	99de                	add	s3,s3,s7
 254:	00098023          	sb	zero,0(s3)
  return buf;
}
 258:	855e                	mv	a0,s7
 25a:	60e6                	ld	ra,88(sp)
 25c:	6446                	ld	s0,80(sp)
 25e:	64a6                	ld	s1,72(sp)
 260:	6906                	ld	s2,64(sp)
 262:	79e2                	ld	s3,56(sp)
 264:	7a42                	ld	s4,48(sp)
 266:	7aa2                	ld	s5,40(sp)
 268:	7b02                	ld	s6,32(sp)
 26a:	6be2                	ld	s7,24(sp)
 26c:	6125                	add	sp,sp,96
 26e:	8082                	ret

0000000000000270 <stat>:

int
stat(const char *n, struct stat *st)
{
 270:	1101                	add	sp,sp,-32
 272:	ec06                	sd	ra,24(sp)
 274:	e822                	sd	s0,16(sp)
 276:	e04a                	sd	s2,0(sp)
 278:	1000                	add	s0,sp,32
 27a:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 27c:	4581                	li	a1,0
 27e:	00000097          	auipc	ra,0x0
 282:	172080e7          	jalr	370(ra) # 3f0 <open>
  if(fd < 0)
 286:	02054663          	bltz	a0,2b2 <stat+0x42>
 28a:	e426                	sd	s1,8(sp)
 28c:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 28e:	85ca                	mv	a1,s2
 290:	00000097          	auipc	ra,0x0
 294:	178080e7          	jalr	376(ra) # 408 <fstat>
 298:	892a                	mv	s2,a0
  close(fd);
 29a:	8526                	mv	a0,s1
 29c:	00000097          	auipc	ra,0x0
 2a0:	13c080e7          	jalr	316(ra) # 3d8 <close>
  return r;
 2a4:	64a2                	ld	s1,8(sp)
}
 2a6:	854a                	mv	a0,s2
 2a8:	60e2                	ld	ra,24(sp)
 2aa:	6442                	ld	s0,16(sp)
 2ac:	6902                	ld	s2,0(sp)
 2ae:	6105                	add	sp,sp,32
 2b0:	8082                	ret
    return -1;
 2b2:	597d                	li	s2,-1
 2b4:	bfcd                	j	2a6 <stat+0x36>

00000000000002b6 <atoi>:

int
atoi(const char *s)
{
 2b6:	1141                	add	sp,sp,-16
 2b8:	e422                	sd	s0,8(sp)
 2ba:	0800                	add	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 2bc:	00054683          	lbu	a3,0(a0)
 2c0:	fd06879b          	addw	a5,a3,-48
 2c4:	0ff7f793          	zext.b	a5,a5
 2c8:	4625                	li	a2,9
 2ca:	02f66863          	bltu	a2,a5,2fa <atoi+0x44>
 2ce:	872a                	mv	a4,a0
  n = 0;
 2d0:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 2d2:	0705                	add	a4,a4,1
 2d4:	0025179b          	sllw	a5,a0,0x2
 2d8:	9fa9                	addw	a5,a5,a0
 2da:	0017979b          	sllw	a5,a5,0x1
 2de:	9fb5                	addw	a5,a5,a3
 2e0:	fd07851b          	addw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 2e4:	00074683          	lbu	a3,0(a4)
 2e8:	fd06879b          	addw	a5,a3,-48
 2ec:	0ff7f793          	zext.b	a5,a5
 2f0:	fef671e3          	bgeu	a2,a5,2d2 <atoi+0x1c>
  return n;
}
 2f4:	6422                	ld	s0,8(sp)
 2f6:	0141                	add	sp,sp,16
 2f8:	8082                	ret
  n = 0;
 2fa:	4501                	li	a0,0
 2fc:	bfe5                	j	2f4 <atoi+0x3e>

00000000000002fe <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 2fe:	1141                	add	sp,sp,-16
 300:	e422                	sd	s0,8(sp)
 302:	0800                	add	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 304:	02b57463          	bgeu	a0,a1,32c <memmove+0x2e>
    while(n-- > 0)
 308:	00c05f63          	blez	a2,326 <memmove+0x28>
 30c:	1602                	sll	a2,a2,0x20
 30e:	9201                	srl	a2,a2,0x20
 310:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 314:	872a                	mv	a4,a0
      *dst++ = *src++;
 316:	0585                	add	a1,a1,1
 318:	0705                	add	a4,a4,1
 31a:	fff5c683          	lbu	a3,-1(a1)
 31e:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 322:	fef71ae3          	bne	a4,a5,316 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 326:	6422                	ld	s0,8(sp)
 328:	0141                	add	sp,sp,16
 32a:	8082                	ret
    dst += n;
 32c:	00c50733          	add	a4,a0,a2
    src += n;
 330:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 332:	fec05ae3          	blez	a2,326 <memmove+0x28>
 336:	fff6079b          	addw	a5,a2,-1
 33a:	1782                	sll	a5,a5,0x20
 33c:	9381                	srl	a5,a5,0x20
 33e:	fff7c793          	not	a5,a5
 342:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 344:	15fd                	add	a1,a1,-1
 346:	177d                	add	a4,a4,-1
 348:	0005c683          	lbu	a3,0(a1)
 34c:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 350:	fee79ae3          	bne	a5,a4,344 <memmove+0x46>
 354:	bfc9                	j	326 <memmove+0x28>

0000000000000356 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 356:	1141                	add	sp,sp,-16
 358:	e422                	sd	s0,8(sp)
 35a:	0800                	add	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 35c:	ca05                	beqz	a2,38c <memcmp+0x36>
 35e:	fff6069b          	addw	a3,a2,-1
 362:	1682                	sll	a3,a3,0x20
 364:	9281                	srl	a3,a3,0x20
 366:	0685                	add	a3,a3,1
 368:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 36a:	00054783          	lbu	a5,0(a0)
 36e:	0005c703          	lbu	a4,0(a1)
 372:	00e79863          	bne	a5,a4,382 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 376:	0505                	add	a0,a0,1
    p2++;
 378:	0585                	add	a1,a1,1
  while (n-- > 0) {
 37a:	fed518e3          	bne	a0,a3,36a <memcmp+0x14>
  }
  return 0;
 37e:	4501                	li	a0,0
 380:	a019                	j	386 <memcmp+0x30>
      return *p1 - *p2;
 382:	40e7853b          	subw	a0,a5,a4
}
 386:	6422                	ld	s0,8(sp)
 388:	0141                	add	sp,sp,16
 38a:	8082                	ret
  return 0;
 38c:	4501                	li	a0,0
 38e:	bfe5                	j	386 <memcmp+0x30>

0000000000000390 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 390:	1141                	add	sp,sp,-16
 392:	e406                	sd	ra,8(sp)
 394:	e022                	sd	s0,0(sp)
 396:	0800                	add	s0,sp,16
  return memmove(dst, src, n);
 398:	00000097          	auipc	ra,0x0
 39c:	f66080e7          	jalr	-154(ra) # 2fe <memmove>
}
 3a0:	60a2                	ld	ra,8(sp)
 3a2:	6402                	ld	s0,0(sp)
 3a4:	0141                	add	sp,sp,16
 3a6:	8082                	ret

00000000000003a8 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 3a8:	4885                	li	a7,1
 ecall
 3aa:	00000073          	ecall
 ret
 3ae:	8082                	ret

00000000000003b0 <exit>:
.global exit
exit:
 li a7, SYS_exit
 3b0:	4889                	li	a7,2
 ecall
 3b2:	00000073          	ecall
 ret
 3b6:	8082                	ret

00000000000003b8 <wait>:
.global wait
wait:
 li a7, SYS_wait
 3b8:	488d                	li	a7,3
 ecall
 3ba:	00000073          	ecall
 ret
 3be:	8082                	ret

00000000000003c0 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 3c0:	4891                	li	a7,4
 ecall
 3c2:	00000073          	ecall
 ret
 3c6:	8082                	ret

00000000000003c8 <read>:
.global read
read:
 li a7, SYS_read
 3c8:	4895                	li	a7,5
 ecall
 3ca:	00000073          	ecall
 ret
 3ce:	8082                	ret

00000000000003d0 <write>:
.global write
write:
 li a7, SYS_write
 3d0:	48c1                	li	a7,16
 ecall
 3d2:	00000073          	ecall
 ret
 3d6:	8082                	ret

00000000000003d8 <close>:
.global close
close:
 li a7, SYS_close
 3d8:	48d5                	li	a7,21
 ecall
 3da:	00000073          	ecall
 ret
 3de:	8082                	ret

00000000000003e0 <kill>:
.global kill
kill:
 li a7, SYS_kill
 3e0:	4899                	li	a7,6
 ecall
 3e2:	00000073          	ecall
 ret
 3e6:	8082                	ret

00000000000003e8 <exec>:
.global exec
exec:
 li a7, SYS_exec
 3e8:	489d                	li	a7,7
 ecall
 3ea:	00000073          	ecall
 ret
 3ee:	8082                	ret

00000000000003f0 <open>:
.global open
open:
 li a7, SYS_open
 3f0:	48bd                	li	a7,15
 ecall
 3f2:	00000073          	ecall
 ret
 3f6:	8082                	ret

00000000000003f8 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 3f8:	48c5                	li	a7,17
 ecall
 3fa:	00000073          	ecall
 ret
 3fe:	8082                	ret

0000000000000400 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 400:	48c9                	li	a7,18
 ecall
 402:	00000073          	ecall
 ret
 406:	8082                	ret

0000000000000408 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 408:	48a1                	li	a7,8
 ecall
 40a:	00000073          	ecall
 ret
 40e:	8082                	ret

0000000000000410 <link>:
.global link
link:
 li a7, SYS_link
 410:	48cd                	li	a7,19
 ecall
 412:	00000073          	ecall
 ret
 416:	8082                	ret

0000000000000418 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 418:	48d1                	li	a7,20
 ecall
 41a:	00000073          	ecall
 ret
 41e:	8082                	ret

0000000000000420 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 420:	48a5                	li	a7,9
 ecall
 422:	00000073          	ecall
 ret
 426:	8082                	ret

0000000000000428 <dup>:
.global dup
dup:
 li a7, SYS_dup
 428:	48a9                	li	a7,10
 ecall
 42a:	00000073          	ecall
 ret
 42e:	8082                	ret

0000000000000430 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 430:	48ad                	li	a7,11
 ecall
 432:	00000073          	ecall
 ret
 436:	8082                	ret

0000000000000438 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 438:	48b1                	li	a7,12
 ecall
 43a:	00000073          	ecall
 ret
 43e:	8082                	ret

0000000000000440 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 440:	48b5                	li	a7,13
 ecall
 442:	00000073          	ecall
 ret
 446:	8082                	ret

0000000000000448 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 448:	48b9                	li	a7,14
 ecall
 44a:	00000073          	ecall
 ret
 44e:	8082                	ret

0000000000000450 <uconnect>:
.global uconnect
uconnect:
 li a7, SYS_uconnect
 450:	48f5                	li	a7,29
 ecall
 452:	00000073          	ecall
 ret
 456:	8082                	ret

0000000000000458 <socket>:
.global socket
socket:
 li a7, SYS_socket
 458:	48f9                	li	a7,30
 ecall
 45a:	00000073          	ecall
 ret
 45e:	8082                	ret

0000000000000460 <bind>:
.global bind
bind:
 li a7, SYS_bind
 460:	48fd                	li	a7,31
 ecall
 462:	00000073          	ecall
 ret
 466:	8082                	ret

0000000000000468 <listen>:
.global listen
listen:
 li a7, SYS_listen
 468:	02000893          	li	a7,32
 ecall
 46c:	00000073          	ecall
 ret
 470:	8082                	ret

0000000000000472 <accept>:
.global accept
accept:
 li a7, SYS_accept
 472:	02100893          	li	a7,33
 ecall
 476:	00000073          	ecall
 ret
 47a:	8082                	ret

000000000000047c <connect>:
.global connect
connect:
 li a7, SYS_connect
 47c:	02200893          	li	a7,34
 ecall
 480:	00000073          	ecall
 ret
 484:	8082                	ret
