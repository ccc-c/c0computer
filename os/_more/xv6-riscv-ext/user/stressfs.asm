
user/_stressfs:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/fs.h"
#include "kernel/fcntl.h"

int
main(int argc, char *argv[])
{
   0:	dd010113          	add	sp,sp,-560
   4:	22113423          	sd	ra,552(sp)
   8:	22813023          	sd	s0,544(sp)
   c:	20913c23          	sd	s1,536(sp)
  10:	21213823          	sd	s2,528(sp)
  14:	1c00                	add	s0,sp,560
  int fd, i;
  char path[] = "stressfs0";
  16:	00001797          	auipc	a5,0x1
  1a:	b7a78793          	add	a5,a5,-1158 # b90 <malloc+0x132>
  1e:	6398                	ld	a4,0(a5)
  20:	fce43823          	sd	a4,-48(s0)
  24:	0087d783          	lhu	a5,8(a5)
  28:	fcf41c23          	sh	a5,-40(s0)
  char data[512];

  printf("stressfs starting\n");
  2c:	00001517          	auipc	a0,0x1
  30:	b3450513          	add	a0,a0,-1228 # b60 <malloc+0x102>
  34:	00000097          	auipc	ra,0x0
  38:	7aa080e7          	jalr	1962(ra) # 7de <printf>
  memset(data, 'a', sizeof(data));
  3c:	20000613          	li	a2,512
  40:	06100593          	li	a1,97
  44:	dd040513          	add	a0,s0,-560
  48:	00000097          	auipc	ra,0x0
  4c:	164080e7          	jalr	356(ra) # 1ac <memset>

  for(i = 0; i < 4; i++)
  50:	4481                	li	s1,0
  52:	4911                	li	s2,4
    if(fork() > 0)
  54:	00000097          	auipc	ra,0x0
  58:	34a080e7          	jalr	842(ra) # 39e <fork>
  5c:	00a04563          	bgtz	a0,66 <main+0x66>
  for(i = 0; i < 4; i++)
  60:	2485                	addw	s1,s1,1
  62:	ff2499e3          	bne	s1,s2,54 <main+0x54>
      break;

  printf("write %d\n", i);
  66:	85a6                	mv	a1,s1
  68:	00001517          	auipc	a0,0x1
  6c:	b1050513          	add	a0,a0,-1264 # b78 <malloc+0x11a>
  70:	00000097          	auipc	ra,0x0
  74:	76e080e7          	jalr	1902(ra) # 7de <printf>

  path[8] += i;
  78:	fd844783          	lbu	a5,-40(s0)
  7c:	9fa5                	addw	a5,a5,s1
  7e:	fcf40c23          	sb	a5,-40(s0)
  fd = open(path, O_CREATE | O_RDWR);
  82:	20200593          	li	a1,514
  86:	fd040513          	add	a0,s0,-48
  8a:	00000097          	auipc	ra,0x0
  8e:	35c080e7          	jalr	860(ra) # 3e6 <open>
  92:	892a                	mv	s2,a0
  94:	44d1                	li	s1,20
  for(i = 0; i < 20; i++)
//    printf(fd, "%d\n", i);
    write(fd, data, sizeof(data));
  96:	20000613          	li	a2,512
  9a:	dd040593          	add	a1,s0,-560
  9e:	854a                	mv	a0,s2
  a0:	00000097          	auipc	ra,0x0
  a4:	326080e7          	jalr	806(ra) # 3c6 <write>
  for(i = 0; i < 20; i++)
  a8:	34fd                	addw	s1,s1,-1
  aa:	f4f5                	bnez	s1,96 <main+0x96>
  close(fd);
  ac:	854a                	mv	a0,s2
  ae:	00000097          	auipc	ra,0x0
  b2:	320080e7          	jalr	800(ra) # 3ce <close>

  printf("read\n");
  b6:	00001517          	auipc	a0,0x1
  ba:	ad250513          	add	a0,a0,-1326 # b88 <malloc+0x12a>
  be:	00000097          	auipc	ra,0x0
  c2:	720080e7          	jalr	1824(ra) # 7de <printf>

  fd = open(path, O_RDONLY);
  c6:	4581                	li	a1,0
  c8:	fd040513          	add	a0,s0,-48
  cc:	00000097          	auipc	ra,0x0
  d0:	31a080e7          	jalr	794(ra) # 3e6 <open>
  d4:	892a                	mv	s2,a0
  d6:	44d1                	li	s1,20
  for (i = 0; i < 20; i++)
    read(fd, data, sizeof(data));
  d8:	20000613          	li	a2,512
  dc:	dd040593          	add	a1,s0,-560
  e0:	854a                	mv	a0,s2
  e2:	00000097          	auipc	ra,0x0
  e6:	2dc080e7          	jalr	732(ra) # 3be <read>
  for (i = 0; i < 20; i++)
  ea:	34fd                	addw	s1,s1,-1
  ec:	f4f5                	bnez	s1,d8 <main+0xd8>
  close(fd);
  ee:	854a                	mv	a0,s2
  f0:	00000097          	auipc	ra,0x0
  f4:	2de080e7          	jalr	734(ra) # 3ce <close>

  wait(0);
  f8:	4501                	li	a0,0
  fa:	00000097          	auipc	ra,0x0
  fe:	2b4080e7          	jalr	692(ra) # 3ae <wait>

  exit(0);
 102:	4501                	li	a0,0
 104:	00000097          	auipc	ra,0x0
 108:	2a2080e7          	jalr	674(ra) # 3a6 <exit>

000000000000010c <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
 10c:	1141                	add	sp,sp,-16
 10e:	e422                	sd	s0,8(sp)
 110:	0800                	add	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 112:	87aa                	mv	a5,a0
 114:	0585                	add	a1,a1,1
 116:	0785                	add	a5,a5,1
 118:	fff5c703          	lbu	a4,-1(a1)
 11c:	fee78fa3          	sb	a4,-1(a5)
 120:	fb75                	bnez	a4,114 <strcpy+0x8>
    ;
  return os;
}
 122:	6422                	ld	s0,8(sp)
 124:	0141                	add	sp,sp,16
 126:	8082                	ret

0000000000000128 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 128:	1141                	add	sp,sp,-16
 12a:	e422                	sd	s0,8(sp)
 12c:	0800                	add	s0,sp,16
  while(*p && *p == *q)
 12e:	00054783          	lbu	a5,0(a0)
 132:	cb91                	beqz	a5,146 <strcmp+0x1e>
 134:	0005c703          	lbu	a4,0(a1)
 138:	00f71763          	bne	a4,a5,146 <strcmp+0x1e>
    p++, q++;
 13c:	0505                	add	a0,a0,1
 13e:	0585                	add	a1,a1,1
  while(*p && *p == *q)
 140:	00054783          	lbu	a5,0(a0)
 144:	fbe5                	bnez	a5,134 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 146:	0005c503          	lbu	a0,0(a1)
}
 14a:	40a7853b          	subw	a0,a5,a0
 14e:	6422                	ld	s0,8(sp)
 150:	0141                	add	sp,sp,16
 152:	8082                	ret

0000000000000154 <strlen>:

uint
strlen(const char *s)
{
 154:	1141                	add	sp,sp,-16
 156:	e422                	sd	s0,8(sp)
 158:	0800                	add	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 15a:	00054783          	lbu	a5,0(a0)
 15e:	cf91                	beqz	a5,17a <strlen+0x26>
 160:	0505                	add	a0,a0,1
 162:	87aa                	mv	a5,a0
 164:	86be                	mv	a3,a5
 166:	0785                	add	a5,a5,1
 168:	fff7c703          	lbu	a4,-1(a5)
 16c:	ff65                	bnez	a4,164 <strlen+0x10>
 16e:	40a6853b          	subw	a0,a3,a0
 172:	2505                	addw	a0,a0,1
    ;
  return n;
}
 174:	6422                	ld	s0,8(sp)
 176:	0141                	add	sp,sp,16
 178:	8082                	ret
  for(n = 0; s[n]; n++)
 17a:	4501                	li	a0,0
 17c:	bfe5                	j	174 <strlen+0x20>

000000000000017e <strcat>:

char *
strcat(char *dst, char *src)
{
 17e:	1141                	add	sp,sp,-16
 180:	e422                	sd	s0,8(sp)
 182:	0800                	add	s0,sp,16
  char *s = dst;
  while (*dst)
 184:	00054783          	lbu	a5,0(a0)
 188:	c385                	beqz	a5,1a8 <strcat+0x2a>
 18a:	87aa                	mv	a5,a0
    dst++;
 18c:	0785                	add	a5,a5,1
  while (*dst)
 18e:	0007c703          	lbu	a4,0(a5)
 192:	ff6d                	bnez	a4,18c <strcat+0xe>
  while ((*dst++ = *src++) != 0);
 194:	0585                	add	a1,a1,1
 196:	0785                	add	a5,a5,1
 198:	fff5c703          	lbu	a4,-1(a1)
 19c:	fee78fa3          	sb	a4,-1(a5)
 1a0:	fb75                	bnez	a4,194 <strcat+0x16>

  return s;
}
 1a2:	6422                	ld	s0,8(sp)
 1a4:	0141                	add	sp,sp,16
 1a6:	8082                	ret
  while (*dst)
 1a8:	87aa                	mv	a5,a0
 1aa:	b7ed                	j	194 <strcat+0x16>

00000000000001ac <memset>:

void*
memset(void *dst, int c, uint n)
{
 1ac:	1141                	add	sp,sp,-16
 1ae:	e422                	sd	s0,8(sp)
 1b0:	0800                	add	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 1b2:	ca19                	beqz	a2,1c8 <memset+0x1c>
 1b4:	87aa                	mv	a5,a0
 1b6:	1602                	sll	a2,a2,0x20
 1b8:	9201                	srl	a2,a2,0x20
 1ba:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 1be:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 1c2:	0785                	add	a5,a5,1
 1c4:	fee79de3          	bne	a5,a4,1be <memset+0x12>
  }
  return dst;
}
 1c8:	6422                	ld	s0,8(sp)
 1ca:	0141                	add	sp,sp,16
 1cc:	8082                	ret

00000000000001ce <strchr>:

char*
strchr(const char *s, char c)
{
 1ce:	1141                	add	sp,sp,-16
 1d0:	e422                	sd	s0,8(sp)
 1d2:	0800                	add	s0,sp,16
  for(; *s; s++)
 1d4:	00054783          	lbu	a5,0(a0)
 1d8:	cb99                	beqz	a5,1ee <strchr+0x20>
    if(*s == c)
 1da:	00f58763          	beq	a1,a5,1e8 <strchr+0x1a>
  for(; *s; s++)
 1de:	0505                	add	a0,a0,1
 1e0:	00054783          	lbu	a5,0(a0)
 1e4:	fbfd                	bnez	a5,1da <strchr+0xc>
      return (char*)s;
  return 0;
 1e6:	4501                	li	a0,0
}
 1e8:	6422                	ld	s0,8(sp)
 1ea:	0141                	add	sp,sp,16
 1ec:	8082                	ret
  return 0;
 1ee:	4501                	li	a0,0
 1f0:	bfe5                	j	1e8 <strchr+0x1a>

00000000000001f2 <gets>:

char*
gets(char *buf, int max)
{
 1f2:	711d                	add	sp,sp,-96
 1f4:	ec86                	sd	ra,88(sp)
 1f6:	e8a2                	sd	s0,80(sp)
 1f8:	e4a6                	sd	s1,72(sp)
 1fa:	e0ca                	sd	s2,64(sp)
 1fc:	fc4e                	sd	s3,56(sp)
 1fe:	f852                	sd	s4,48(sp)
 200:	f456                	sd	s5,40(sp)
 202:	f05a                	sd	s6,32(sp)
 204:	ec5e                	sd	s7,24(sp)
 206:	1080                	add	s0,sp,96
 208:	8baa                	mv	s7,a0
 20a:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 20c:	892a                	mv	s2,a0
 20e:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 210:	4aa9                	li	s5,10
 212:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 214:	89a6                	mv	s3,s1
 216:	2485                	addw	s1,s1,1
 218:	0344d863          	bge	s1,s4,248 <gets+0x56>
    cc = read(0, &c, 1);
 21c:	4605                	li	a2,1
 21e:	faf40593          	add	a1,s0,-81
 222:	4501                	li	a0,0
 224:	00000097          	auipc	ra,0x0
 228:	19a080e7          	jalr	410(ra) # 3be <read>
    if(cc < 1)
 22c:	00a05e63          	blez	a0,248 <gets+0x56>
    buf[i++] = c;
 230:	faf44783          	lbu	a5,-81(s0)
 234:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 238:	01578763          	beq	a5,s5,246 <gets+0x54>
 23c:	0905                	add	s2,s2,1
 23e:	fd679be3          	bne	a5,s6,214 <gets+0x22>
    buf[i++] = c;
 242:	89a6                	mv	s3,s1
 244:	a011                	j	248 <gets+0x56>
 246:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 248:	99de                	add	s3,s3,s7
 24a:	00098023          	sb	zero,0(s3)
  return buf;
}
 24e:	855e                	mv	a0,s7
 250:	60e6                	ld	ra,88(sp)
 252:	6446                	ld	s0,80(sp)
 254:	64a6                	ld	s1,72(sp)
 256:	6906                	ld	s2,64(sp)
 258:	79e2                	ld	s3,56(sp)
 25a:	7a42                	ld	s4,48(sp)
 25c:	7aa2                	ld	s5,40(sp)
 25e:	7b02                	ld	s6,32(sp)
 260:	6be2                	ld	s7,24(sp)
 262:	6125                	add	sp,sp,96
 264:	8082                	ret

0000000000000266 <stat>:

int
stat(const char *n, struct stat *st)
{
 266:	1101                	add	sp,sp,-32
 268:	ec06                	sd	ra,24(sp)
 26a:	e822                	sd	s0,16(sp)
 26c:	e04a                	sd	s2,0(sp)
 26e:	1000                	add	s0,sp,32
 270:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 272:	4581                	li	a1,0
 274:	00000097          	auipc	ra,0x0
 278:	172080e7          	jalr	370(ra) # 3e6 <open>
  if(fd < 0)
 27c:	02054663          	bltz	a0,2a8 <stat+0x42>
 280:	e426                	sd	s1,8(sp)
 282:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 284:	85ca                	mv	a1,s2
 286:	00000097          	auipc	ra,0x0
 28a:	178080e7          	jalr	376(ra) # 3fe <fstat>
 28e:	892a                	mv	s2,a0
  close(fd);
 290:	8526                	mv	a0,s1
 292:	00000097          	auipc	ra,0x0
 296:	13c080e7          	jalr	316(ra) # 3ce <close>
  return r;
 29a:	64a2                	ld	s1,8(sp)
}
 29c:	854a                	mv	a0,s2
 29e:	60e2                	ld	ra,24(sp)
 2a0:	6442                	ld	s0,16(sp)
 2a2:	6902                	ld	s2,0(sp)
 2a4:	6105                	add	sp,sp,32
 2a6:	8082                	ret
    return -1;
 2a8:	597d                	li	s2,-1
 2aa:	bfcd                	j	29c <stat+0x36>

00000000000002ac <atoi>:

int
atoi(const char *s)
{
 2ac:	1141                	add	sp,sp,-16
 2ae:	e422                	sd	s0,8(sp)
 2b0:	0800                	add	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 2b2:	00054683          	lbu	a3,0(a0)
 2b6:	fd06879b          	addw	a5,a3,-48
 2ba:	0ff7f793          	zext.b	a5,a5
 2be:	4625                	li	a2,9
 2c0:	02f66863          	bltu	a2,a5,2f0 <atoi+0x44>
 2c4:	872a                	mv	a4,a0
  n = 0;
 2c6:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 2c8:	0705                	add	a4,a4,1
 2ca:	0025179b          	sllw	a5,a0,0x2
 2ce:	9fa9                	addw	a5,a5,a0
 2d0:	0017979b          	sllw	a5,a5,0x1
 2d4:	9fb5                	addw	a5,a5,a3
 2d6:	fd07851b          	addw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 2da:	00074683          	lbu	a3,0(a4)
 2de:	fd06879b          	addw	a5,a3,-48
 2e2:	0ff7f793          	zext.b	a5,a5
 2e6:	fef671e3          	bgeu	a2,a5,2c8 <atoi+0x1c>
  return n;
}
 2ea:	6422                	ld	s0,8(sp)
 2ec:	0141                	add	sp,sp,16
 2ee:	8082                	ret
  n = 0;
 2f0:	4501                	li	a0,0
 2f2:	bfe5                	j	2ea <atoi+0x3e>

00000000000002f4 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 2f4:	1141                	add	sp,sp,-16
 2f6:	e422                	sd	s0,8(sp)
 2f8:	0800                	add	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 2fa:	02b57463          	bgeu	a0,a1,322 <memmove+0x2e>
    while(n-- > 0)
 2fe:	00c05f63          	blez	a2,31c <memmove+0x28>
 302:	1602                	sll	a2,a2,0x20
 304:	9201                	srl	a2,a2,0x20
 306:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 30a:	872a                	mv	a4,a0
      *dst++ = *src++;
 30c:	0585                	add	a1,a1,1
 30e:	0705                	add	a4,a4,1
 310:	fff5c683          	lbu	a3,-1(a1)
 314:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 318:	fef71ae3          	bne	a4,a5,30c <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 31c:	6422                	ld	s0,8(sp)
 31e:	0141                	add	sp,sp,16
 320:	8082                	ret
    dst += n;
 322:	00c50733          	add	a4,a0,a2
    src += n;
 326:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 328:	fec05ae3          	blez	a2,31c <memmove+0x28>
 32c:	fff6079b          	addw	a5,a2,-1
 330:	1782                	sll	a5,a5,0x20
 332:	9381                	srl	a5,a5,0x20
 334:	fff7c793          	not	a5,a5
 338:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 33a:	15fd                	add	a1,a1,-1
 33c:	177d                	add	a4,a4,-1
 33e:	0005c683          	lbu	a3,0(a1)
 342:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 346:	fee79ae3          	bne	a5,a4,33a <memmove+0x46>
 34a:	bfc9                	j	31c <memmove+0x28>

000000000000034c <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 34c:	1141                	add	sp,sp,-16
 34e:	e422                	sd	s0,8(sp)
 350:	0800                	add	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 352:	ca05                	beqz	a2,382 <memcmp+0x36>
 354:	fff6069b          	addw	a3,a2,-1
 358:	1682                	sll	a3,a3,0x20
 35a:	9281                	srl	a3,a3,0x20
 35c:	0685                	add	a3,a3,1
 35e:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 360:	00054783          	lbu	a5,0(a0)
 364:	0005c703          	lbu	a4,0(a1)
 368:	00e79863          	bne	a5,a4,378 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 36c:	0505                	add	a0,a0,1
    p2++;
 36e:	0585                	add	a1,a1,1
  while (n-- > 0) {
 370:	fed518e3          	bne	a0,a3,360 <memcmp+0x14>
  }
  return 0;
 374:	4501                	li	a0,0
 376:	a019                	j	37c <memcmp+0x30>
      return *p1 - *p2;
 378:	40e7853b          	subw	a0,a5,a4
}
 37c:	6422                	ld	s0,8(sp)
 37e:	0141                	add	sp,sp,16
 380:	8082                	ret
  return 0;
 382:	4501                	li	a0,0
 384:	bfe5                	j	37c <memcmp+0x30>

0000000000000386 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 386:	1141                	add	sp,sp,-16
 388:	e406                	sd	ra,8(sp)
 38a:	e022                	sd	s0,0(sp)
 38c:	0800                	add	s0,sp,16
  return memmove(dst, src, n);
 38e:	00000097          	auipc	ra,0x0
 392:	f66080e7          	jalr	-154(ra) # 2f4 <memmove>
}
 396:	60a2                	ld	ra,8(sp)
 398:	6402                	ld	s0,0(sp)
 39a:	0141                	add	sp,sp,16
 39c:	8082                	ret

000000000000039e <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 39e:	4885                	li	a7,1
 ecall
 3a0:	00000073          	ecall
 ret
 3a4:	8082                	ret

00000000000003a6 <exit>:
.global exit
exit:
 li a7, SYS_exit
 3a6:	4889                	li	a7,2
 ecall
 3a8:	00000073          	ecall
 ret
 3ac:	8082                	ret

00000000000003ae <wait>:
.global wait
wait:
 li a7, SYS_wait
 3ae:	488d                	li	a7,3
 ecall
 3b0:	00000073          	ecall
 ret
 3b4:	8082                	ret

00000000000003b6 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 3b6:	4891                	li	a7,4
 ecall
 3b8:	00000073          	ecall
 ret
 3bc:	8082                	ret

00000000000003be <read>:
.global read
read:
 li a7, SYS_read
 3be:	4895                	li	a7,5
 ecall
 3c0:	00000073          	ecall
 ret
 3c4:	8082                	ret

00000000000003c6 <write>:
.global write
write:
 li a7, SYS_write
 3c6:	48c1                	li	a7,16
 ecall
 3c8:	00000073          	ecall
 ret
 3cc:	8082                	ret

00000000000003ce <close>:
.global close
close:
 li a7, SYS_close
 3ce:	48d5                	li	a7,21
 ecall
 3d0:	00000073          	ecall
 ret
 3d4:	8082                	ret

00000000000003d6 <kill>:
.global kill
kill:
 li a7, SYS_kill
 3d6:	4899                	li	a7,6
 ecall
 3d8:	00000073          	ecall
 ret
 3dc:	8082                	ret

00000000000003de <exec>:
.global exec
exec:
 li a7, SYS_exec
 3de:	489d                	li	a7,7
 ecall
 3e0:	00000073          	ecall
 ret
 3e4:	8082                	ret

00000000000003e6 <open>:
.global open
open:
 li a7, SYS_open
 3e6:	48bd                	li	a7,15
 ecall
 3e8:	00000073          	ecall
 ret
 3ec:	8082                	ret

00000000000003ee <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 3ee:	48c5                	li	a7,17
 ecall
 3f0:	00000073          	ecall
 ret
 3f4:	8082                	ret

00000000000003f6 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 3f6:	48c9                	li	a7,18
 ecall
 3f8:	00000073          	ecall
 ret
 3fc:	8082                	ret

00000000000003fe <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 3fe:	48a1                	li	a7,8
 ecall
 400:	00000073          	ecall
 ret
 404:	8082                	ret

0000000000000406 <link>:
.global link
link:
 li a7, SYS_link
 406:	48cd                	li	a7,19
 ecall
 408:	00000073          	ecall
 ret
 40c:	8082                	ret

000000000000040e <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 40e:	48d1                	li	a7,20
 ecall
 410:	00000073          	ecall
 ret
 414:	8082                	ret

0000000000000416 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 416:	48a5                	li	a7,9
 ecall
 418:	00000073          	ecall
 ret
 41c:	8082                	ret

000000000000041e <dup>:
.global dup
dup:
 li a7, SYS_dup
 41e:	48a9                	li	a7,10
 ecall
 420:	00000073          	ecall
 ret
 424:	8082                	ret

0000000000000426 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 426:	48ad                	li	a7,11
 ecall
 428:	00000073          	ecall
 ret
 42c:	8082                	ret

000000000000042e <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 42e:	48b1                	li	a7,12
 ecall
 430:	00000073          	ecall
 ret
 434:	8082                	ret

0000000000000436 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 436:	48b5                	li	a7,13
 ecall
 438:	00000073          	ecall
 ret
 43c:	8082                	ret

000000000000043e <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 43e:	48b9                	li	a7,14
 ecall
 440:	00000073          	ecall
 ret
 444:	8082                	ret

0000000000000446 <uconnect>:
.global uconnect
uconnect:
 li a7, SYS_uconnect
 446:	48f5                	li	a7,29
 ecall
 448:	00000073          	ecall
 ret
 44c:	8082                	ret

000000000000044e <socket>:
.global socket
socket:
 li a7, SYS_socket
 44e:	48f9                	li	a7,30
 ecall
 450:	00000073          	ecall
 ret
 454:	8082                	ret

0000000000000456 <bind>:
.global bind
bind:
 li a7, SYS_bind
 456:	48fd                	li	a7,31
 ecall
 458:	00000073          	ecall
 ret
 45c:	8082                	ret

000000000000045e <listen>:
.global listen
listen:
 li a7, SYS_listen
 45e:	02000893          	li	a7,32
 ecall
 462:	00000073          	ecall
 ret
 466:	8082                	ret

0000000000000468 <accept>:
.global accept
accept:
 li a7, SYS_accept
 468:	02100893          	li	a7,33
 ecall
 46c:	00000073          	ecall
 ret
 470:	8082                	ret

0000000000000472 <connect>:
.global connect
connect:
 li a7, SYS_connect
 472:	02200893          	li	a7,34
 ecall
 476:	00000073          	ecall
 ret
 47a:	8082                	ret

000000000000047c <sprintint>:
  return 1;
}

static int
sprintint(char *s, int xx, int base, int sign)
{
 47c:	1101                	add	sp,sp,-32
 47e:	ec22                	sd	s0,24(sp)
 480:	1000                	add	s0,sp,32
 482:	882a                	mv	a6,a0
  char buf[16];
  int i, n;
  uint x;

  if(sign && (sign = xx < 0))
 484:	c299                	beqz	a3,48a <sprintint+0xe>
 486:	0805c263          	bltz	a1,50a <sprintint+0x8e>
    x = -xx;
  else
    x = xx;
 48a:	2581                	sext.w	a1,a1
 48c:	4301                	li	t1,0

  i = 0;
 48e:	fe040713          	add	a4,s0,-32
 492:	4501                	li	a0,0
  do {
    buf[i++] = digits[x % base];
 494:	2601                	sext.w	a2,a2
 496:	00000697          	auipc	a3,0x0
 49a:	76a68693          	add	a3,a3,1898 # c00 <digits>
 49e:	88aa                	mv	a7,a0
 4a0:	2505                	addw	a0,a0,1
 4a2:	02c5f7bb          	remuw	a5,a1,a2
 4a6:	1782                	sll	a5,a5,0x20
 4a8:	9381                	srl	a5,a5,0x20
 4aa:	97b6                	add	a5,a5,a3
 4ac:	0007c783          	lbu	a5,0(a5)
 4b0:	00f70023          	sb	a5,0(a4)
  } while((x /= base) != 0);
 4b4:	0005879b          	sext.w	a5,a1
 4b8:	02c5d5bb          	divuw	a1,a1,a2
 4bc:	0705                	add	a4,a4,1
 4be:	fec7f0e3          	bgeu	a5,a2,49e <sprintint+0x22>

  if(sign)
 4c2:	00030b63          	beqz	t1,4d8 <sprintint+0x5c>
    buf[i++] = '-';
 4c6:	ff050793          	add	a5,a0,-16
 4ca:	97a2                	add	a5,a5,s0
 4cc:	02d00713          	li	a4,45
 4d0:	fee78823          	sb	a4,-16(a5)
 4d4:	0028851b          	addw	a0,a7,2

  n = 0;
  while(--i >= 0)
 4d8:	02a05d63          	blez	a0,512 <sprintint+0x96>
 4dc:	fe040793          	add	a5,s0,-32
 4e0:	00a78733          	add	a4,a5,a0
 4e4:	87c2                	mv	a5,a6
 4e6:	00180613          	add	a2,a6,1
 4ea:	fff5069b          	addw	a3,a0,-1
 4ee:	1682                	sll	a3,a3,0x20
 4f0:	9281                	srl	a3,a3,0x20
 4f2:	9636                	add	a2,a2,a3
  *s = c;
 4f4:	fff74683          	lbu	a3,-1(a4)
 4f8:	00d78023          	sb	a3,0(a5)
  while(--i >= 0)
 4fc:	177d                	add	a4,a4,-1
 4fe:	0785                	add	a5,a5,1
 500:	fec79ae3          	bne	a5,a2,4f4 <sprintint+0x78>
    n += sputc(s+n, buf[i]);
  return n;
}
 504:	6462                	ld	s0,24(sp)
 506:	6105                	add	sp,sp,32
 508:	8082                	ret
    x = -xx;
 50a:	40b005bb          	negw	a1,a1
  if(sign && (sign = xx < 0))
 50e:	4305                	li	t1,1
    x = -xx;
 510:	bfbd                	j	48e <sprintint+0x12>
  while(--i >= 0)
 512:	4501                	li	a0,0
 514:	bfc5                	j	504 <sprintint+0x88>

0000000000000516 <putc>:
{
 516:	1101                	add	sp,sp,-32
 518:	ec06                	sd	ra,24(sp)
 51a:	e822                	sd	s0,16(sp)
 51c:	1000                	add	s0,sp,32
 51e:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 522:	4605                	li	a2,1
 524:	fef40593          	add	a1,s0,-17
 528:	00000097          	auipc	ra,0x0
 52c:	e9e080e7          	jalr	-354(ra) # 3c6 <write>
}
 530:	60e2                	ld	ra,24(sp)
 532:	6442                	ld	s0,16(sp)
 534:	6105                	add	sp,sp,32
 536:	8082                	ret

0000000000000538 <printint>:
{
 538:	7139                	add	sp,sp,-64
 53a:	fc06                	sd	ra,56(sp)
 53c:	f822                	sd	s0,48(sp)
 53e:	f426                	sd	s1,40(sp)
 540:	0080                	add	s0,sp,64
 542:	84aa                	mv	s1,a0
  if(sgn && xx < 0){
 544:	c299                	beqz	a3,54a <printint+0x12>
 546:	0805cb63          	bltz	a1,5dc <printint+0xa4>
    x = xx;
 54a:	2581                	sext.w	a1,a1
  neg = 0;
 54c:	4881                	li	a7,0
 54e:	fc040693          	add	a3,s0,-64
  i = 0;
 552:	4701                	li	a4,0
    buf[i++] = digits[x % base];
 554:	2601                	sext.w	a2,a2
 556:	00000517          	auipc	a0,0x0
 55a:	6aa50513          	add	a0,a0,1706 # c00 <digits>
 55e:	883a                	mv	a6,a4
 560:	2705                	addw	a4,a4,1
 562:	02c5f7bb          	remuw	a5,a1,a2
 566:	1782                	sll	a5,a5,0x20
 568:	9381                	srl	a5,a5,0x20
 56a:	97aa                	add	a5,a5,a0
 56c:	0007c783          	lbu	a5,0(a5)
 570:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 574:	0005879b          	sext.w	a5,a1
 578:	02c5d5bb          	divuw	a1,a1,a2
 57c:	0685                	add	a3,a3,1
 57e:	fec7f0e3          	bgeu	a5,a2,55e <printint+0x26>
  if(neg)
 582:	00088c63          	beqz	a7,59a <printint+0x62>
    buf[i++] = '-';
 586:	fd070793          	add	a5,a4,-48
 58a:	00878733          	add	a4,a5,s0
 58e:	02d00793          	li	a5,45
 592:	fef70823          	sb	a5,-16(a4)
 596:	0028071b          	addw	a4,a6,2
  while(--i >= 0)
 59a:	02e05c63          	blez	a4,5d2 <printint+0x9a>
 59e:	f04a                	sd	s2,32(sp)
 5a0:	ec4e                	sd	s3,24(sp)
 5a2:	fc040793          	add	a5,s0,-64
 5a6:	00e78933          	add	s2,a5,a4
 5aa:	fff78993          	add	s3,a5,-1
 5ae:	99ba                	add	s3,s3,a4
 5b0:	377d                	addw	a4,a4,-1
 5b2:	1702                	sll	a4,a4,0x20
 5b4:	9301                	srl	a4,a4,0x20
 5b6:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 5ba:	fff94583          	lbu	a1,-1(s2)
 5be:	8526                	mv	a0,s1
 5c0:	00000097          	auipc	ra,0x0
 5c4:	f56080e7          	jalr	-170(ra) # 516 <putc>
  while(--i >= 0)
 5c8:	197d                	add	s2,s2,-1
 5ca:	ff3918e3          	bne	s2,s3,5ba <printint+0x82>
 5ce:	7902                	ld	s2,32(sp)
 5d0:	69e2                	ld	s3,24(sp)
}
 5d2:	70e2                	ld	ra,56(sp)
 5d4:	7442                	ld	s0,48(sp)
 5d6:	74a2                	ld	s1,40(sp)
 5d8:	6121                	add	sp,sp,64
 5da:	8082                	ret
    x = -xx;
 5dc:	40b005bb          	negw	a1,a1
    neg = 1;
 5e0:	4885                	li	a7,1
    x = -xx;
 5e2:	b7b5                	j	54e <printint+0x16>

00000000000005e4 <vprintf>:
{
 5e4:	715d                	add	sp,sp,-80
 5e6:	e486                	sd	ra,72(sp)
 5e8:	e0a2                	sd	s0,64(sp)
 5ea:	f84a                	sd	s2,48(sp)
 5ec:	0880                	add	s0,sp,80
  for(i = 0; fmt[i]; i++){
 5ee:	0005c903          	lbu	s2,0(a1)
 5f2:	1a090a63          	beqz	s2,7a6 <vprintf+0x1c2>
 5f6:	fc26                	sd	s1,56(sp)
 5f8:	f44e                	sd	s3,40(sp)
 5fa:	f052                	sd	s4,32(sp)
 5fc:	ec56                	sd	s5,24(sp)
 5fe:	e85a                	sd	s6,16(sp)
 600:	e45e                	sd	s7,8(sp)
 602:	8aaa                	mv	s5,a0
 604:	8bb2                	mv	s7,a2
 606:	00158493          	add	s1,a1,1
  state = 0;
 60a:	4981                	li	s3,0
    } else if(state == '%'){
 60c:	02500a13          	li	s4,37
 610:	4b55                	li	s6,21
 612:	a839                	j	630 <vprintf+0x4c>
        putc(fd, c);
 614:	85ca                	mv	a1,s2
 616:	8556                	mv	a0,s5
 618:	00000097          	auipc	ra,0x0
 61c:	efe080e7          	jalr	-258(ra) # 516 <putc>
 620:	a019                	j	626 <vprintf+0x42>
    } else if(state == '%'){
 622:	01498d63          	beq	s3,s4,63c <vprintf+0x58>
  for(i = 0; fmt[i]; i++){
 626:	0485                	add	s1,s1,1
 628:	fff4c903          	lbu	s2,-1(s1)
 62c:	16090763          	beqz	s2,79a <vprintf+0x1b6>
    if(state == 0){
 630:	fe0999e3          	bnez	s3,622 <vprintf+0x3e>
      if(c == '%'){
 634:	ff4910e3          	bne	s2,s4,614 <vprintf+0x30>
        state = '%';
 638:	89d2                	mv	s3,s4
 63a:	b7f5                	j	626 <vprintf+0x42>
      if(c == 'd'){
 63c:	13490463          	beq	s2,s4,764 <vprintf+0x180>
 640:	f9d9079b          	addw	a5,s2,-99
 644:	0ff7f793          	zext.b	a5,a5
 648:	12fb6763          	bltu	s6,a5,776 <vprintf+0x192>
 64c:	f9d9079b          	addw	a5,s2,-99
 650:	0ff7f713          	zext.b	a4,a5
 654:	12eb6163          	bltu	s6,a4,776 <vprintf+0x192>
 658:	00271793          	sll	a5,a4,0x2
 65c:	00000717          	auipc	a4,0x0
 660:	54c70713          	add	a4,a4,1356 # ba8 <malloc+0x14a>
 664:	97ba                	add	a5,a5,a4
 666:	439c                	lw	a5,0(a5)
 668:	97ba                	add	a5,a5,a4
 66a:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 66c:	008b8913          	add	s2,s7,8
 670:	4685                	li	a3,1
 672:	4629                	li	a2,10
 674:	000ba583          	lw	a1,0(s7)
 678:	8556                	mv	a0,s5
 67a:	00000097          	auipc	ra,0x0
 67e:	ebe080e7          	jalr	-322(ra) # 538 <printint>
 682:	8bca                	mv	s7,s2
      state = 0;
 684:	4981                	li	s3,0
 686:	b745                	j	626 <vprintf+0x42>
        printint(fd, va_arg(ap, uint64), 10, 0);
 688:	008b8913          	add	s2,s7,8
 68c:	4681                	li	a3,0
 68e:	4629                	li	a2,10
 690:	000ba583          	lw	a1,0(s7)
 694:	8556                	mv	a0,s5
 696:	00000097          	auipc	ra,0x0
 69a:	ea2080e7          	jalr	-350(ra) # 538 <printint>
 69e:	8bca                	mv	s7,s2
      state = 0;
 6a0:	4981                	li	s3,0
 6a2:	b751                	j	626 <vprintf+0x42>
        printint(fd, va_arg(ap, int), 16, 0);
 6a4:	008b8913          	add	s2,s7,8
 6a8:	4681                	li	a3,0
 6aa:	4641                	li	a2,16
 6ac:	000ba583          	lw	a1,0(s7)
 6b0:	8556                	mv	a0,s5
 6b2:	00000097          	auipc	ra,0x0
 6b6:	e86080e7          	jalr	-378(ra) # 538 <printint>
 6ba:	8bca                	mv	s7,s2
      state = 0;
 6bc:	4981                	li	s3,0
 6be:	b7a5                	j	626 <vprintf+0x42>
 6c0:	e062                	sd	s8,0(sp)
        printptr(fd, va_arg(ap, uint64));
 6c2:	008b8c13          	add	s8,s7,8
 6c6:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 6ca:	03000593          	li	a1,48
 6ce:	8556                	mv	a0,s5
 6d0:	00000097          	auipc	ra,0x0
 6d4:	e46080e7          	jalr	-442(ra) # 516 <putc>
  putc(fd, 'x');
 6d8:	07800593          	li	a1,120
 6dc:	8556                	mv	a0,s5
 6de:	00000097          	auipc	ra,0x0
 6e2:	e38080e7          	jalr	-456(ra) # 516 <putc>
 6e6:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 6e8:	00000b97          	auipc	s7,0x0
 6ec:	518b8b93          	add	s7,s7,1304 # c00 <digits>
 6f0:	03c9d793          	srl	a5,s3,0x3c
 6f4:	97de                	add	a5,a5,s7
 6f6:	0007c583          	lbu	a1,0(a5)
 6fa:	8556                	mv	a0,s5
 6fc:	00000097          	auipc	ra,0x0
 700:	e1a080e7          	jalr	-486(ra) # 516 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 704:	0992                	sll	s3,s3,0x4
 706:	397d                	addw	s2,s2,-1
 708:	fe0914e3          	bnez	s2,6f0 <vprintf+0x10c>
        printptr(fd, va_arg(ap, uint64));
 70c:	8be2                	mv	s7,s8
      state = 0;
 70e:	4981                	li	s3,0
 710:	6c02                	ld	s8,0(sp)
 712:	bf11                	j	626 <vprintf+0x42>
        s = va_arg(ap, char*);
 714:	008b8993          	add	s3,s7,8
 718:	000bb903          	ld	s2,0(s7)
        if(s == 0)
 71c:	02090163          	beqz	s2,73e <vprintf+0x15a>
        while(*s != 0){
 720:	00094583          	lbu	a1,0(s2)
 724:	c9a5                	beqz	a1,794 <vprintf+0x1b0>
          putc(fd, *s);
 726:	8556                	mv	a0,s5
 728:	00000097          	auipc	ra,0x0
 72c:	dee080e7          	jalr	-530(ra) # 516 <putc>
          s++;
 730:	0905                	add	s2,s2,1
        while(*s != 0){
 732:	00094583          	lbu	a1,0(s2)
 736:	f9e5                	bnez	a1,726 <vprintf+0x142>
        s = va_arg(ap, char*);
 738:	8bce                	mv	s7,s3
      state = 0;
 73a:	4981                	li	s3,0
 73c:	b5ed                	j	626 <vprintf+0x42>
          s = "(null)";
 73e:	00000917          	auipc	s2,0x0
 742:	46290913          	add	s2,s2,1122 # ba0 <malloc+0x142>
        while(*s != 0){
 746:	02800593          	li	a1,40
 74a:	bff1                	j	726 <vprintf+0x142>
        putc(fd, va_arg(ap, uint));
 74c:	008b8913          	add	s2,s7,8
 750:	000bc583          	lbu	a1,0(s7)
 754:	8556                	mv	a0,s5
 756:	00000097          	auipc	ra,0x0
 75a:	dc0080e7          	jalr	-576(ra) # 516 <putc>
 75e:	8bca                	mv	s7,s2
      state = 0;
 760:	4981                	li	s3,0
 762:	b5d1                	j	626 <vprintf+0x42>
        putc(fd, c);
 764:	02500593          	li	a1,37
 768:	8556                	mv	a0,s5
 76a:	00000097          	auipc	ra,0x0
 76e:	dac080e7          	jalr	-596(ra) # 516 <putc>
      state = 0;
 772:	4981                	li	s3,0
 774:	bd4d                	j	626 <vprintf+0x42>
        putc(fd, '%');
 776:	02500593          	li	a1,37
 77a:	8556                	mv	a0,s5
 77c:	00000097          	auipc	ra,0x0
 780:	d9a080e7          	jalr	-614(ra) # 516 <putc>
        putc(fd, c);
 784:	85ca                	mv	a1,s2
 786:	8556                	mv	a0,s5
 788:	00000097          	auipc	ra,0x0
 78c:	d8e080e7          	jalr	-626(ra) # 516 <putc>
      state = 0;
 790:	4981                	li	s3,0
 792:	bd51                	j	626 <vprintf+0x42>
        s = va_arg(ap, char*);
 794:	8bce                	mv	s7,s3
      state = 0;
 796:	4981                	li	s3,0
 798:	b579                	j	626 <vprintf+0x42>
 79a:	74e2                	ld	s1,56(sp)
 79c:	79a2                	ld	s3,40(sp)
 79e:	7a02                	ld	s4,32(sp)
 7a0:	6ae2                	ld	s5,24(sp)
 7a2:	6b42                	ld	s6,16(sp)
 7a4:	6ba2                	ld	s7,8(sp)
}
 7a6:	60a6                	ld	ra,72(sp)
 7a8:	6406                	ld	s0,64(sp)
 7aa:	7942                	ld	s2,48(sp)
 7ac:	6161                	add	sp,sp,80
 7ae:	8082                	ret

00000000000007b0 <fprintf>:
{
 7b0:	715d                	add	sp,sp,-80
 7b2:	ec06                	sd	ra,24(sp)
 7b4:	e822                	sd	s0,16(sp)
 7b6:	1000                	add	s0,sp,32
 7b8:	e010                	sd	a2,0(s0)
 7ba:	e414                	sd	a3,8(s0)
 7bc:	e818                	sd	a4,16(s0)
 7be:	ec1c                	sd	a5,24(s0)
 7c0:	03043023          	sd	a6,32(s0)
 7c4:	03143423          	sd	a7,40(s0)
  va_start(ap, fmt);
 7c8:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 7cc:	8622                	mv	a2,s0
 7ce:	00000097          	auipc	ra,0x0
 7d2:	e16080e7          	jalr	-490(ra) # 5e4 <vprintf>
}
 7d6:	60e2                	ld	ra,24(sp)
 7d8:	6442                	ld	s0,16(sp)
 7da:	6161                	add	sp,sp,80
 7dc:	8082                	ret

00000000000007de <printf>:
{
 7de:	711d                	add	sp,sp,-96
 7e0:	ec06                	sd	ra,24(sp)
 7e2:	e822                	sd	s0,16(sp)
 7e4:	1000                	add	s0,sp,32
 7e6:	e40c                	sd	a1,8(s0)
 7e8:	e810                	sd	a2,16(s0)
 7ea:	ec14                	sd	a3,24(s0)
 7ec:	f018                	sd	a4,32(s0)
 7ee:	f41c                	sd	a5,40(s0)
 7f0:	03043823          	sd	a6,48(s0)
 7f4:	03143c23          	sd	a7,56(s0)
  va_start(ap, fmt);
 7f8:	00840613          	add	a2,s0,8
 7fc:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 800:	85aa                	mv	a1,a0
 802:	4505                	li	a0,1
 804:	00000097          	auipc	ra,0x0
 808:	de0080e7          	jalr	-544(ra) # 5e4 <vprintf>
}
 80c:	60e2                	ld	ra,24(sp)
 80e:	6442                	ld	s0,16(sp)
 810:	6125                	add	sp,sp,96
 812:	8082                	ret

0000000000000814 <snprintf>:

int
snprintf(char *buf, int sz, char *fmt, ...)
{
 814:	7135                	add	sp,sp,-160
 816:	f486                	sd	ra,104(sp)
 818:	f0a2                	sd	s0,96(sp)
 81a:	eca6                	sd	s1,88(sp)
 81c:	1880                	add	s0,sp,112
 81e:	e414                	sd	a3,8(s0)
 820:	e818                	sd	a4,16(s0)
 822:	ec1c                	sd	a5,24(s0)
 824:	03043023          	sd	a6,32(s0)
 828:	03143423          	sd	a7,40(s0)
  va_list ap;
  int i, c;
  int off = 0;
  char *s;

  if (fmt == 0)
 82c:	16060b63          	beqz	a2,9a2 <snprintf+0x18e>
 830:	e8ca                	sd	s2,80(sp)
 832:	e4ce                	sd	s3,72(sp)
 834:	fc56                	sd	s5,56(sp)
 836:	f85a                	sd	s6,48(sp)
 838:	8b2a                	mv	s6,a0
 83a:	8aae                	mv	s5,a1
 83c:	89b2                	mv	s3,a2
    return -1;

  va_start(ap, fmt);
 83e:	00840793          	add	a5,s0,8
 842:	f8f43c23          	sd	a5,-104(s0)
  int off = 0;
 846:	4481                	li	s1,0
  for(i = 0; off < sz && (c = fmt[i] & 0xff) != 0; i++){
 848:	4901                	li	s2,0
 84a:	00b05f63          	blez	a1,868 <snprintf+0x54>
 84e:	e0d2                	sd	s4,64(sp)
 850:	f45e                	sd	s7,40(sp)
 852:	f062                	sd	s8,32(sp)
 854:	ec66                	sd	s9,24(sp)
    if(c != '%'){
 856:	02500a13          	li	s4,37
      continue;
    }
    c = fmt[++i] & 0xff;
    if(c == 0)
      break;
    switch(c){
 85a:	07300b93          	li	s7,115
 85e:	07800c93          	li	s9,120
 862:	06400c13          	li	s8,100
 866:	a839                	j	884 <snprintf+0x70>
      off += sputc(buf+off, '%');
      off += sputc(buf+off, c);
      break;
    }
  }
  return off;
 868:	4481                	li	s1,0
 86a:	6946                	ld	s2,80(sp)
 86c:	69a6                	ld	s3,72(sp)
 86e:	7ae2                	ld	s5,56(sp)
 870:	7b42                	ld	s6,48(sp)
 872:	a0cd                	j	954 <snprintf+0x140>
  *s = c;
 874:	009b0733          	add	a4,s6,s1
 878:	00f70023          	sb	a5,0(a4)
      off += sputc(buf+off, c);
 87c:	2485                	addw	s1,s1,1
  for(i = 0; off < sz && (c = fmt[i] & 0xff) != 0; i++){
 87e:	2905                	addw	s2,s2,1
 880:	1554d563          	bge	s1,s5,9ca <snprintf+0x1b6>
 884:	012987b3          	add	a5,s3,s2
 888:	0007c783          	lbu	a5,0(a5)
 88c:	0007871b          	sext.w	a4,a5
 890:	10078063          	beqz	a5,990 <snprintf+0x17c>
    if(c != '%'){
 894:	ff4710e3          	bne	a4,s4,874 <snprintf+0x60>
    c = fmt[++i] & 0xff;
 898:	2905                	addw	s2,s2,1
 89a:	012987b3          	add	a5,s3,s2
 89e:	0007c783          	lbu	a5,0(a5)
    if(c == 0)
 8a2:	10078263          	beqz	a5,9a6 <snprintf+0x192>
    switch(c){
 8a6:	05778c63          	beq	a5,s7,8fe <snprintf+0xea>
 8aa:	02fbe763          	bltu	s7,a5,8d8 <snprintf+0xc4>
 8ae:	0d478063          	beq	a5,s4,96e <snprintf+0x15a>
 8b2:	0d879463          	bne	a5,s8,97a <snprintf+0x166>
      off += sprintint(buf+off, va_arg(ap, int), 10, 1);
 8b6:	f9843783          	ld	a5,-104(s0)
 8ba:	00878713          	add	a4,a5,8
 8be:	f8e43c23          	sd	a4,-104(s0)
 8c2:	4685                	li	a3,1
 8c4:	4629                	li	a2,10
 8c6:	438c                	lw	a1,0(a5)
 8c8:	009b0533          	add	a0,s6,s1
 8cc:	00000097          	auipc	ra,0x0
 8d0:	bb0080e7          	jalr	-1104(ra) # 47c <sprintint>
 8d4:	9ca9                	addw	s1,s1,a0
      break;
 8d6:	b765                	j	87e <snprintf+0x6a>
    switch(c){
 8d8:	0b979163          	bne	a5,s9,97a <snprintf+0x166>
      off += sprintint(buf+off, va_arg(ap, int), 16, 1);
 8dc:	f9843783          	ld	a5,-104(s0)
 8e0:	00878713          	add	a4,a5,8
 8e4:	f8e43c23          	sd	a4,-104(s0)
 8e8:	4685                	li	a3,1
 8ea:	4641                	li	a2,16
 8ec:	438c                	lw	a1,0(a5)
 8ee:	009b0533          	add	a0,s6,s1
 8f2:	00000097          	auipc	ra,0x0
 8f6:	b8a080e7          	jalr	-1142(ra) # 47c <sprintint>
 8fa:	9ca9                	addw	s1,s1,a0
      break;
 8fc:	b749                	j	87e <snprintf+0x6a>
      if((s = va_arg(ap, char*)) == 0)
 8fe:	f9843783          	ld	a5,-104(s0)
 902:	00878713          	add	a4,a5,8
 906:	f8e43c23          	sd	a4,-104(s0)
 90a:	6388                	ld	a0,0(a5)
 90c:	c931                	beqz	a0,960 <snprintf+0x14c>
      for(; *s && off < sz; s++)
 90e:	00054703          	lbu	a4,0(a0)
 912:	d735                	beqz	a4,87e <snprintf+0x6a>
 914:	0b54d263          	bge	s1,s5,9b8 <snprintf+0x1a4>
 918:	009b06b3          	add	a3,s6,s1
 91c:	409a863b          	subw	a2,s5,s1
 920:	1602                	sll	a2,a2,0x20
 922:	9201                	srl	a2,a2,0x20
 924:	962a                	add	a2,a2,a0
 926:	87aa                	mv	a5,a0
        off += sputc(buf+off, *s);
 928:	0014859b          	addw	a1,s1,1
 92c:	9d89                	subw	a1,a1,a0
  *s = c;
 92e:	00e68023          	sb	a4,0(a3)
        off += sputc(buf+off, *s);
 932:	00f584bb          	addw	s1,a1,a5
      for(; *s && off < sz; s++)
 936:	0785                	add	a5,a5,1
 938:	0007c703          	lbu	a4,0(a5)
 93c:	d329                	beqz	a4,87e <snprintf+0x6a>
 93e:	0685                	add	a3,a3,1
 940:	fec797e3          	bne	a5,a2,92e <snprintf+0x11a>
 944:	6946                	ld	s2,80(sp)
 946:	69a6                	ld	s3,72(sp)
 948:	6a06                	ld	s4,64(sp)
 94a:	7ae2                	ld	s5,56(sp)
 94c:	7b42                	ld	s6,48(sp)
 94e:	7ba2                	ld	s7,40(sp)
 950:	7c02                	ld	s8,32(sp)
 952:	6ce2                	ld	s9,24(sp)
 954:	8526                	mv	a0,s1
 956:	70a6                	ld	ra,104(sp)
 958:	7406                	ld	s0,96(sp)
 95a:	64e6                	ld	s1,88(sp)
 95c:	610d                	add	sp,sp,160
 95e:	8082                	ret
      for(; *s && off < sz; s++)
 960:	02800713          	li	a4,40
        s = "(null)";
 964:	00000517          	auipc	a0,0x0
 968:	23c50513          	add	a0,a0,572 # ba0 <malloc+0x142>
 96c:	b765                	j	914 <snprintf+0x100>
  *s = c;
 96e:	009b07b3          	add	a5,s6,s1
 972:	01478023          	sb	s4,0(a5)
      off += sputc(buf+off, '%');
 976:	2485                	addw	s1,s1,1
      break;
 978:	b719                	j	87e <snprintf+0x6a>
  *s = c;
 97a:	009b0733          	add	a4,s6,s1
 97e:	01470023          	sb	s4,0(a4)
      off += sputc(buf+off, c);
 982:	0014871b          	addw	a4,s1,1
  *s = c;
 986:	975a                	add	a4,a4,s6
 988:	00f70023          	sb	a5,0(a4)
      off += sputc(buf+off, c);
 98c:	2489                	addw	s1,s1,2
      break;
 98e:	bdc5                	j	87e <snprintf+0x6a>
 990:	6946                	ld	s2,80(sp)
 992:	69a6                	ld	s3,72(sp)
 994:	6a06                	ld	s4,64(sp)
 996:	7ae2                	ld	s5,56(sp)
 998:	7b42                	ld	s6,48(sp)
 99a:	7ba2                	ld	s7,40(sp)
 99c:	7c02                	ld	s8,32(sp)
 99e:	6ce2                	ld	s9,24(sp)
 9a0:	bf55                	j	954 <snprintf+0x140>
    return -1;
 9a2:	54fd                	li	s1,-1
 9a4:	bf45                	j	954 <snprintf+0x140>
 9a6:	6946                	ld	s2,80(sp)
 9a8:	69a6                	ld	s3,72(sp)
 9aa:	6a06                	ld	s4,64(sp)
 9ac:	7ae2                	ld	s5,56(sp)
 9ae:	7b42                	ld	s6,48(sp)
 9b0:	7ba2                	ld	s7,40(sp)
 9b2:	7c02                	ld	s8,32(sp)
 9b4:	6ce2                	ld	s9,24(sp)
 9b6:	bf79                	j	954 <snprintf+0x140>
 9b8:	6946                	ld	s2,80(sp)
 9ba:	69a6                	ld	s3,72(sp)
 9bc:	6a06                	ld	s4,64(sp)
 9be:	7ae2                	ld	s5,56(sp)
 9c0:	7b42                	ld	s6,48(sp)
 9c2:	7ba2                	ld	s7,40(sp)
 9c4:	7c02                	ld	s8,32(sp)
 9c6:	6ce2                	ld	s9,24(sp)
 9c8:	b771                	j	954 <snprintf+0x140>
 9ca:	6946                	ld	s2,80(sp)
 9cc:	69a6                	ld	s3,72(sp)
 9ce:	6a06                	ld	s4,64(sp)
 9d0:	7ae2                	ld	s5,56(sp)
 9d2:	7b42                	ld	s6,48(sp)
 9d4:	7ba2                	ld	s7,40(sp)
 9d6:	7c02                	ld	s8,32(sp)
 9d8:	6ce2                	ld	s9,24(sp)
 9da:	bfad                	j	954 <snprintf+0x140>

00000000000009dc <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 9dc:	1141                	add	sp,sp,-16
 9de:	e422                	sd	s0,8(sp)
 9e0:	0800                	add	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 9e2:	ff050693          	add	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 9e6:	00000797          	auipc	a5,0x0
 9ea:	2327b783          	ld	a5,562(a5) # c18 <freep>
 9ee:	a02d                	j	a18 <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 9f0:	4618                	lw	a4,8(a2)
 9f2:	9f2d                	addw	a4,a4,a1
 9f4:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 9f8:	6398                	ld	a4,0(a5)
 9fa:	6310                	ld	a2,0(a4)
 9fc:	a83d                	j	a3a <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 9fe:	ff852703          	lw	a4,-8(a0)
 a02:	9f31                	addw	a4,a4,a2
 a04:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 a06:	ff053683          	ld	a3,-16(a0)
 a0a:	a091                	j	a4e <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 a0c:	6398                	ld	a4,0(a5)
 a0e:	00e7e463          	bltu	a5,a4,a16 <free+0x3a>
 a12:	00e6ea63          	bltu	a3,a4,a26 <free+0x4a>
{
 a16:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 a18:	fed7fae3          	bgeu	a5,a3,a0c <free+0x30>
 a1c:	6398                	ld	a4,0(a5)
 a1e:	00e6e463          	bltu	a3,a4,a26 <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 a22:	fee7eae3          	bltu	a5,a4,a16 <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 a26:	ff852583          	lw	a1,-8(a0)
 a2a:	6390                	ld	a2,0(a5)
 a2c:	02059813          	sll	a6,a1,0x20
 a30:	01c85713          	srl	a4,a6,0x1c
 a34:	9736                	add	a4,a4,a3
 a36:	fae60de3          	beq	a2,a4,9f0 <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 a3a:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 a3e:	4790                	lw	a2,8(a5)
 a40:	02061593          	sll	a1,a2,0x20
 a44:	01c5d713          	srl	a4,a1,0x1c
 a48:	973e                	add	a4,a4,a5
 a4a:	fae68ae3          	beq	a3,a4,9fe <free+0x22>
    p->s.ptr = bp->s.ptr;
 a4e:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 a50:	00000717          	auipc	a4,0x0
 a54:	1cf73423          	sd	a5,456(a4) # c18 <freep>
}
 a58:	6422                	ld	s0,8(sp)
 a5a:	0141                	add	sp,sp,16
 a5c:	8082                	ret

0000000000000a5e <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 a5e:	7139                	add	sp,sp,-64
 a60:	fc06                	sd	ra,56(sp)
 a62:	f822                	sd	s0,48(sp)
 a64:	f426                	sd	s1,40(sp)
 a66:	ec4e                	sd	s3,24(sp)
 a68:	0080                	add	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 a6a:	02051493          	sll	s1,a0,0x20
 a6e:	9081                	srl	s1,s1,0x20
 a70:	04bd                	add	s1,s1,15
 a72:	8091                	srl	s1,s1,0x4
 a74:	0014899b          	addw	s3,s1,1
 a78:	0485                	add	s1,s1,1
  if((prevp = freep) == 0){
 a7a:	00000517          	auipc	a0,0x0
 a7e:	19e53503          	ld	a0,414(a0) # c18 <freep>
 a82:	c915                	beqz	a0,ab6 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a84:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 a86:	4798                	lw	a4,8(a5)
 a88:	08977e63          	bgeu	a4,s1,b24 <malloc+0xc6>
 a8c:	f04a                	sd	s2,32(sp)
 a8e:	e852                	sd	s4,16(sp)
 a90:	e456                	sd	s5,8(sp)
 a92:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 a94:	8a4e                	mv	s4,s3
 a96:	0009871b          	sext.w	a4,s3
 a9a:	6685                	lui	a3,0x1
 a9c:	00d77363          	bgeu	a4,a3,aa2 <malloc+0x44>
 aa0:	6a05                	lui	s4,0x1
 aa2:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 aa6:	004a1a1b          	sllw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 aaa:	00000917          	auipc	s2,0x0
 aae:	16e90913          	add	s2,s2,366 # c18 <freep>
  if(p == (char*)-1)
 ab2:	5afd                	li	s5,-1
 ab4:	a091                	j	af8 <malloc+0x9a>
 ab6:	f04a                	sd	s2,32(sp)
 ab8:	e852                	sd	s4,16(sp)
 aba:	e456                	sd	s5,8(sp)
 abc:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 abe:	00000797          	auipc	a5,0x0
 ac2:	16278793          	add	a5,a5,354 # c20 <base>
 ac6:	00000717          	auipc	a4,0x0
 aca:	14f73923          	sd	a5,338(a4) # c18 <freep>
 ace:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 ad0:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 ad4:	b7c1                	j	a94 <malloc+0x36>
        prevp->s.ptr = p->s.ptr;
 ad6:	6398                	ld	a4,0(a5)
 ad8:	e118                	sd	a4,0(a0)
 ada:	a08d                	j	b3c <malloc+0xde>
  hp->s.size = nu;
 adc:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 ae0:	0541                	add	a0,a0,16
 ae2:	00000097          	auipc	ra,0x0
 ae6:	efa080e7          	jalr	-262(ra) # 9dc <free>
  return freep;
 aea:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 aee:	c13d                	beqz	a0,b54 <malloc+0xf6>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 af0:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 af2:	4798                	lw	a4,8(a5)
 af4:	02977463          	bgeu	a4,s1,b1c <malloc+0xbe>
    if(p == freep)
 af8:	00093703          	ld	a4,0(s2)
 afc:	853e                	mv	a0,a5
 afe:	fef719e3          	bne	a4,a5,af0 <malloc+0x92>
  p = sbrk(nu * sizeof(Header));
 b02:	8552                	mv	a0,s4
 b04:	00000097          	auipc	ra,0x0
 b08:	92a080e7          	jalr	-1750(ra) # 42e <sbrk>
  if(p == (char*)-1)
 b0c:	fd5518e3          	bne	a0,s5,adc <malloc+0x7e>
        return 0;
 b10:	4501                	li	a0,0
 b12:	7902                	ld	s2,32(sp)
 b14:	6a42                	ld	s4,16(sp)
 b16:	6aa2                	ld	s5,8(sp)
 b18:	6b02                	ld	s6,0(sp)
 b1a:	a03d                	j	b48 <malloc+0xea>
 b1c:	7902                	ld	s2,32(sp)
 b1e:	6a42                	ld	s4,16(sp)
 b20:	6aa2                	ld	s5,8(sp)
 b22:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 b24:	fae489e3          	beq	s1,a4,ad6 <malloc+0x78>
        p->s.size -= nunits;
 b28:	4137073b          	subw	a4,a4,s3
 b2c:	c798                	sw	a4,8(a5)
        p += p->s.size;
 b2e:	02071693          	sll	a3,a4,0x20
 b32:	01c6d713          	srl	a4,a3,0x1c
 b36:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 b38:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 b3c:	00000717          	auipc	a4,0x0
 b40:	0ca73e23          	sd	a0,220(a4) # c18 <freep>
      return (void*)(p + 1);
 b44:	01078513          	add	a0,a5,16
  }
}
 b48:	70e2                	ld	ra,56(sp)
 b4a:	7442                	ld	s0,48(sp)
 b4c:	74a2                	ld	s1,40(sp)
 b4e:	69e2                	ld	s3,24(sp)
 b50:	6121                	add	sp,sp,64
 b52:	8082                	ret
 b54:	7902                	ld	s2,32(sp)
 b56:	6a42                	ld	s4,16(sp)
 b58:	6aa2                	ld	s5,8(sp)
 b5a:	6b02                	ld	s6,0(sp)
 b5c:	b7f5                	j	b48 <malloc+0xea>
