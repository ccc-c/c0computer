
user/_cat:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <cat>:

char buf[512];

void
cat(int fd)
{
   0:	7179                	add	sp,sp,-48
   2:	f406                	sd	ra,40(sp)
   4:	f022                	sd	s0,32(sp)
   6:	ec26                	sd	s1,24(sp)
   8:	e84a                	sd	s2,16(sp)
   a:	e44e                	sd	s3,8(sp)
   c:	1800                	add	s0,sp,48
   e:	89aa                	mv	s3,a0
  int n;

  while((n = read(fd, buf, sizeof(buf))) > 0) {
  10:	00001917          	auipc	s2,0x1
  14:	c3090913          	add	s2,s2,-976 # c40 <buf>
  18:	20000613          	li	a2,512
  1c:	85ca                	mv	a1,s2
  1e:	854e                	mv	a0,s3
  20:	00000097          	auipc	ra,0x0
  24:	3b4080e7          	jalr	948(ra) # 3d4 <read>
  28:	84aa                	mv	s1,a0
  2a:	02a05963          	blez	a0,5c <cat+0x5c>
    if (write(1, buf, n) != n) {
  2e:	8626                	mv	a2,s1
  30:	85ca                	mv	a1,s2
  32:	4505                	li	a0,1
  34:	00000097          	auipc	ra,0x0
  38:	3a8080e7          	jalr	936(ra) # 3dc <write>
  3c:	fc950ee3          	beq	a0,s1,18 <cat+0x18>
      fprintf(2, "cat: write error\n");
  40:	00001597          	auipc	a1,0x1
  44:	b3858593          	add	a1,a1,-1224 # b78 <malloc+0x104>
  48:	4509                	li	a0,2
  4a:	00000097          	auipc	ra,0x0
  4e:	77c080e7          	jalr	1916(ra) # 7c6 <fprintf>
      exit(1);
  52:	4505                	li	a0,1
  54:	00000097          	auipc	ra,0x0
  58:	368080e7          	jalr	872(ra) # 3bc <exit>
    }
  }
  if(n < 0){
  5c:	00054963          	bltz	a0,6e <cat+0x6e>
    fprintf(2, "cat: read error\n");
    exit(1);
  }
}
  60:	70a2                	ld	ra,40(sp)
  62:	7402                	ld	s0,32(sp)
  64:	64e2                	ld	s1,24(sp)
  66:	6942                	ld	s2,16(sp)
  68:	69a2                	ld	s3,8(sp)
  6a:	6145                	add	sp,sp,48
  6c:	8082                	ret
    fprintf(2, "cat: read error\n");
  6e:	00001597          	auipc	a1,0x1
  72:	b2258593          	add	a1,a1,-1246 # b90 <malloc+0x11c>
  76:	4509                	li	a0,2
  78:	00000097          	auipc	ra,0x0
  7c:	74e080e7          	jalr	1870(ra) # 7c6 <fprintf>
    exit(1);
  80:	4505                	li	a0,1
  82:	00000097          	auipc	ra,0x0
  86:	33a080e7          	jalr	826(ra) # 3bc <exit>

000000000000008a <main>:

int
main(int argc, char *argv[])
{
  8a:	7179                	add	sp,sp,-48
  8c:	f406                	sd	ra,40(sp)
  8e:	f022                	sd	s0,32(sp)
  90:	1800                	add	s0,sp,48
  int fd, i;

  if(argc <= 1){
  92:	4785                	li	a5,1
  94:	04a7da63          	bge	a5,a0,e8 <main+0x5e>
  98:	ec26                	sd	s1,24(sp)
  9a:	e84a                	sd	s2,16(sp)
  9c:	e44e                	sd	s3,8(sp)
  9e:	00858913          	add	s2,a1,8
  a2:	ffe5099b          	addw	s3,a0,-2
  a6:	02099793          	sll	a5,s3,0x20
  aa:	01d7d993          	srl	s3,a5,0x1d
  ae:	05c1                	add	a1,a1,16
  b0:	99ae                	add	s3,s3,a1
    cat(0);
    exit(0);
  }

  for(i = 1; i < argc; i++){
    if((fd = open(argv[i], 0)) < 0){
  b2:	4581                	li	a1,0
  b4:	00093503          	ld	a0,0(s2)
  b8:	00000097          	auipc	ra,0x0
  bc:	344080e7          	jalr	836(ra) # 3fc <open>
  c0:	84aa                	mv	s1,a0
  c2:	04054063          	bltz	a0,102 <main+0x78>
      fprintf(2, "cat: cannot open %s\n", argv[i]);
      exit(1);
    }
    cat(fd);
  c6:	00000097          	auipc	ra,0x0
  ca:	f3a080e7          	jalr	-198(ra) # 0 <cat>
    close(fd);
  ce:	8526                	mv	a0,s1
  d0:	00000097          	auipc	ra,0x0
  d4:	314080e7          	jalr	788(ra) # 3e4 <close>
  for(i = 1; i < argc; i++){
  d8:	0921                	add	s2,s2,8
  da:	fd391ce3          	bne	s2,s3,b2 <main+0x28>
  }
  exit(0);
  de:	4501                	li	a0,0
  e0:	00000097          	auipc	ra,0x0
  e4:	2dc080e7          	jalr	732(ra) # 3bc <exit>
  e8:	ec26                	sd	s1,24(sp)
  ea:	e84a                	sd	s2,16(sp)
  ec:	e44e                	sd	s3,8(sp)
    cat(0);
  ee:	4501                	li	a0,0
  f0:	00000097          	auipc	ra,0x0
  f4:	f10080e7          	jalr	-240(ra) # 0 <cat>
    exit(0);
  f8:	4501                	li	a0,0
  fa:	00000097          	auipc	ra,0x0
  fe:	2c2080e7          	jalr	706(ra) # 3bc <exit>
      fprintf(2, "cat: cannot open %s\n", argv[i]);
 102:	00093603          	ld	a2,0(s2)
 106:	00001597          	auipc	a1,0x1
 10a:	aa258593          	add	a1,a1,-1374 # ba8 <malloc+0x134>
 10e:	4509                	li	a0,2
 110:	00000097          	auipc	ra,0x0
 114:	6b6080e7          	jalr	1718(ra) # 7c6 <fprintf>
      exit(1);
 118:	4505                	li	a0,1
 11a:	00000097          	auipc	ra,0x0
 11e:	2a2080e7          	jalr	674(ra) # 3bc <exit>

0000000000000122 <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
 122:	1141                	add	sp,sp,-16
 124:	e422                	sd	s0,8(sp)
 126:	0800                	add	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 128:	87aa                	mv	a5,a0
 12a:	0585                	add	a1,a1,1
 12c:	0785                	add	a5,a5,1
 12e:	fff5c703          	lbu	a4,-1(a1)
 132:	fee78fa3          	sb	a4,-1(a5)
 136:	fb75                	bnez	a4,12a <strcpy+0x8>
    ;
  return os;
}
 138:	6422                	ld	s0,8(sp)
 13a:	0141                	add	sp,sp,16
 13c:	8082                	ret

000000000000013e <strcmp>:

int
strcmp(const char *p, const char *q)
{
 13e:	1141                	add	sp,sp,-16
 140:	e422                	sd	s0,8(sp)
 142:	0800                	add	s0,sp,16
  while(*p && *p == *q)
 144:	00054783          	lbu	a5,0(a0)
 148:	cb91                	beqz	a5,15c <strcmp+0x1e>
 14a:	0005c703          	lbu	a4,0(a1)
 14e:	00f71763          	bne	a4,a5,15c <strcmp+0x1e>
    p++, q++;
 152:	0505                	add	a0,a0,1
 154:	0585                	add	a1,a1,1
  while(*p && *p == *q)
 156:	00054783          	lbu	a5,0(a0)
 15a:	fbe5                	bnez	a5,14a <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 15c:	0005c503          	lbu	a0,0(a1)
}
 160:	40a7853b          	subw	a0,a5,a0
 164:	6422                	ld	s0,8(sp)
 166:	0141                	add	sp,sp,16
 168:	8082                	ret

000000000000016a <strlen>:

uint
strlen(const char *s)
{
 16a:	1141                	add	sp,sp,-16
 16c:	e422                	sd	s0,8(sp)
 16e:	0800                	add	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 170:	00054783          	lbu	a5,0(a0)
 174:	cf91                	beqz	a5,190 <strlen+0x26>
 176:	0505                	add	a0,a0,1
 178:	87aa                	mv	a5,a0
 17a:	86be                	mv	a3,a5
 17c:	0785                	add	a5,a5,1
 17e:	fff7c703          	lbu	a4,-1(a5)
 182:	ff65                	bnez	a4,17a <strlen+0x10>
 184:	40a6853b          	subw	a0,a3,a0
 188:	2505                	addw	a0,a0,1
    ;
  return n;
}
 18a:	6422                	ld	s0,8(sp)
 18c:	0141                	add	sp,sp,16
 18e:	8082                	ret
  for(n = 0; s[n]; n++)
 190:	4501                	li	a0,0
 192:	bfe5                	j	18a <strlen+0x20>

0000000000000194 <strcat>:

char *
strcat(char *dst, char *src)
{
 194:	1141                	add	sp,sp,-16
 196:	e422                	sd	s0,8(sp)
 198:	0800                	add	s0,sp,16
  char *s = dst;
  while (*dst)
 19a:	00054783          	lbu	a5,0(a0)
 19e:	c385                	beqz	a5,1be <strcat+0x2a>
 1a0:	87aa                	mv	a5,a0
    dst++;
 1a2:	0785                	add	a5,a5,1
  while (*dst)
 1a4:	0007c703          	lbu	a4,0(a5)
 1a8:	ff6d                	bnez	a4,1a2 <strcat+0xe>
  while ((*dst++ = *src++) != 0);
 1aa:	0585                	add	a1,a1,1
 1ac:	0785                	add	a5,a5,1
 1ae:	fff5c703          	lbu	a4,-1(a1)
 1b2:	fee78fa3          	sb	a4,-1(a5)
 1b6:	fb75                	bnez	a4,1aa <strcat+0x16>

  return s;
}
 1b8:	6422                	ld	s0,8(sp)
 1ba:	0141                	add	sp,sp,16
 1bc:	8082                	ret
  while (*dst)
 1be:	87aa                	mv	a5,a0
 1c0:	b7ed                	j	1aa <strcat+0x16>

00000000000001c2 <memset>:

void*
memset(void *dst, int c, uint n)
{
 1c2:	1141                	add	sp,sp,-16
 1c4:	e422                	sd	s0,8(sp)
 1c6:	0800                	add	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 1c8:	ca19                	beqz	a2,1de <memset+0x1c>
 1ca:	87aa                	mv	a5,a0
 1cc:	1602                	sll	a2,a2,0x20
 1ce:	9201                	srl	a2,a2,0x20
 1d0:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 1d4:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 1d8:	0785                	add	a5,a5,1
 1da:	fee79de3          	bne	a5,a4,1d4 <memset+0x12>
  }
  return dst;
}
 1de:	6422                	ld	s0,8(sp)
 1e0:	0141                	add	sp,sp,16
 1e2:	8082                	ret

00000000000001e4 <strchr>:

char*
strchr(const char *s, char c)
{
 1e4:	1141                	add	sp,sp,-16
 1e6:	e422                	sd	s0,8(sp)
 1e8:	0800                	add	s0,sp,16
  for(; *s; s++)
 1ea:	00054783          	lbu	a5,0(a0)
 1ee:	cb99                	beqz	a5,204 <strchr+0x20>
    if(*s == c)
 1f0:	00f58763          	beq	a1,a5,1fe <strchr+0x1a>
  for(; *s; s++)
 1f4:	0505                	add	a0,a0,1
 1f6:	00054783          	lbu	a5,0(a0)
 1fa:	fbfd                	bnez	a5,1f0 <strchr+0xc>
      return (char*)s;
  return 0;
 1fc:	4501                	li	a0,0
}
 1fe:	6422                	ld	s0,8(sp)
 200:	0141                	add	sp,sp,16
 202:	8082                	ret
  return 0;
 204:	4501                	li	a0,0
 206:	bfe5                	j	1fe <strchr+0x1a>

0000000000000208 <gets>:

char*
gets(char *buf, int max)
{
 208:	711d                	add	sp,sp,-96
 20a:	ec86                	sd	ra,88(sp)
 20c:	e8a2                	sd	s0,80(sp)
 20e:	e4a6                	sd	s1,72(sp)
 210:	e0ca                	sd	s2,64(sp)
 212:	fc4e                	sd	s3,56(sp)
 214:	f852                	sd	s4,48(sp)
 216:	f456                	sd	s5,40(sp)
 218:	f05a                	sd	s6,32(sp)
 21a:	ec5e                	sd	s7,24(sp)
 21c:	1080                	add	s0,sp,96
 21e:	8baa                	mv	s7,a0
 220:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 222:	892a                	mv	s2,a0
 224:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 226:	4aa9                	li	s5,10
 228:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 22a:	89a6                	mv	s3,s1
 22c:	2485                	addw	s1,s1,1
 22e:	0344d863          	bge	s1,s4,25e <gets+0x56>
    cc = read(0, &c, 1);
 232:	4605                	li	a2,1
 234:	faf40593          	add	a1,s0,-81
 238:	4501                	li	a0,0
 23a:	00000097          	auipc	ra,0x0
 23e:	19a080e7          	jalr	410(ra) # 3d4 <read>
    if(cc < 1)
 242:	00a05e63          	blez	a0,25e <gets+0x56>
    buf[i++] = c;
 246:	faf44783          	lbu	a5,-81(s0)
 24a:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 24e:	01578763          	beq	a5,s5,25c <gets+0x54>
 252:	0905                	add	s2,s2,1
 254:	fd679be3          	bne	a5,s6,22a <gets+0x22>
    buf[i++] = c;
 258:	89a6                	mv	s3,s1
 25a:	a011                	j	25e <gets+0x56>
 25c:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 25e:	99de                	add	s3,s3,s7
 260:	00098023          	sb	zero,0(s3)
  return buf;
}
 264:	855e                	mv	a0,s7
 266:	60e6                	ld	ra,88(sp)
 268:	6446                	ld	s0,80(sp)
 26a:	64a6                	ld	s1,72(sp)
 26c:	6906                	ld	s2,64(sp)
 26e:	79e2                	ld	s3,56(sp)
 270:	7a42                	ld	s4,48(sp)
 272:	7aa2                	ld	s5,40(sp)
 274:	7b02                	ld	s6,32(sp)
 276:	6be2                	ld	s7,24(sp)
 278:	6125                	add	sp,sp,96
 27a:	8082                	ret

000000000000027c <stat>:

int
stat(const char *n, struct stat *st)
{
 27c:	1101                	add	sp,sp,-32
 27e:	ec06                	sd	ra,24(sp)
 280:	e822                	sd	s0,16(sp)
 282:	e04a                	sd	s2,0(sp)
 284:	1000                	add	s0,sp,32
 286:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 288:	4581                	li	a1,0
 28a:	00000097          	auipc	ra,0x0
 28e:	172080e7          	jalr	370(ra) # 3fc <open>
  if(fd < 0)
 292:	02054663          	bltz	a0,2be <stat+0x42>
 296:	e426                	sd	s1,8(sp)
 298:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 29a:	85ca                	mv	a1,s2
 29c:	00000097          	auipc	ra,0x0
 2a0:	178080e7          	jalr	376(ra) # 414 <fstat>
 2a4:	892a                	mv	s2,a0
  close(fd);
 2a6:	8526                	mv	a0,s1
 2a8:	00000097          	auipc	ra,0x0
 2ac:	13c080e7          	jalr	316(ra) # 3e4 <close>
  return r;
 2b0:	64a2                	ld	s1,8(sp)
}
 2b2:	854a                	mv	a0,s2
 2b4:	60e2                	ld	ra,24(sp)
 2b6:	6442                	ld	s0,16(sp)
 2b8:	6902                	ld	s2,0(sp)
 2ba:	6105                	add	sp,sp,32
 2bc:	8082                	ret
    return -1;
 2be:	597d                	li	s2,-1
 2c0:	bfcd                	j	2b2 <stat+0x36>

00000000000002c2 <atoi>:

int
atoi(const char *s)
{
 2c2:	1141                	add	sp,sp,-16
 2c4:	e422                	sd	s0,8(sp)
 2c6:	0800                	add	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 2c8:	00054683          	lbu	a3,0(a0)
 2cc:	fd06879b          	addw	a5,a3,-48
 2d0:	0ff7f793          	zext.b	a5,a5
 2d4:	4625                	li	a2,9
 2d6:	02f66863          	bltu	a2,a5,306 <atoi+0x44>
 2da:	872a                	mv	a4,a0
  n = 0;
 2dc:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 2de:	0705                	add	a4,a4,1
 2e0:	0025179b          	sllw	a5,a0,0x2
 2e4:	9fa9                	addw	a5,a5,a0
 2e6:	0017979b          	sllw	a5,a5,0x1
 2ea:	9fb5                	addw	a5,a5,a3
 2ec:	fd07851b          	addw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 2f0:	00074683          	lbu	a3,0(a4)
 2f4:	fd06879b          	addw	a5,a3,-48
 2f8:	0ff7f793          	zext.b	a5,a5
 2fc:	fef671e3          	bgeu	a2,a5,2de <atoi+0x1c>
  return n;
}
 300:	6422                	ld	s0,8(sp)
 302:	0141                	add	sp,sp,16
 304:	8082                	ret
  n = 0;
 306:	4501                	li	a0,0
 308:	bfe5                	j	300 <atoi+0x3e>

000000000000030a <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 30a:	1141                	add	sp,sp,-16
 30c:	e422                	sd	s0,8(sp)
 30e:	0800                	add	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 310:	02b57463          	bgeu	a0,a1,338 <memmove+0x2e>
    while(n-- > 0)
 314:	00c05f63          	blez	a2,332 <memmove+0x28>
 318:	1602                	sll	a2,a2,0x20
 31a:	9201                	srl	a2,a2,0x20
 31c:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 320:	872a                	mv	a4,a0
      *dst++ = *src++;
 322:	0585                	add	a1,a1,1
 324:	0705                	add	a4,a4,1
 326:	fff5c683          	lbu	a3,-1(a1)
 32a:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 32e:	fef71ae3          	bne	a4,a5,322 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 332:	6422                	ld	s0,8(sp)
 334:	0141                	add	sp,sp,16
 336:	8082                	ret
    dst += n;
 338:	00c50733          	add	a4,a0,a2
    src += n;
 33c:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 33e:	fec05ae3          	blez	a2,332 <memmove+0x28>
 342:	fff6079b          	addw	a5,a2,-1
 346:	1782                	sll	a5,a5,0x20
 348:	9381                	srl	a5,a5,0x20
 34a:	fff7c793          	not	a5,a5
 34e:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 350:	15fd                	add	a1,a1,-1
 352:	177d                	add	a4,a4,-1
 354:	0005c683          	lbu	a3,0(a1)
 358:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 35c:	fee79ae3          	bne	a5,a4,350 <memmove+0x46>
 360:	bfc9                	j	332 <memmove+0x28>

0000000000000362 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 362:	1141                	add	sp,sp,-16
 364:	e422                	sd	s0,8(sp)
 366:	0800                	add	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 368:	ca05                	beqz	a2,398 <memcmp+0x36>
 36a:	fff6069b          	addw	a3,a2,-1
 36e:	1682                	sll	a3,a3,0x20
 370:	9281                	srl	a3,a3,0x20
 372:	0685                	add	a3,a3,1
 374:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 376:	00054783          	lbu	a5,0(a0)
 37a:	0005c703          	lbu	a4,0(a1)
 37e:	00e79863          	bne	a5,a4,38e <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 382:	0505                	add	a0,a0,1
    p2++;
 384:	0585                	add	a1,a1,1
  while (n-- > 0) {
 386:	fed518e3          	bne	a0,a3,376 <memcmp+0x14>
  }
  return 0;
 38a:	4501                	li	a0,0
 38c:	a019                	j	392 <memcmp+0x30>
      return *p1 - *p2;
 38e:	40e7853b          	subw	a0,a5,a4
}
 392:	6422                	ld	s0,8(sp)
 394:	0141                	add	sp,sp,16
 396:	8082                	ret
  return 0;
 398:	4501                	li	a0,0
 39a:	bfe5                	j	392 <memcmp+0x30>

000000000000039c <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 39c:	1141                	add	sp,sp,-16
 39e:	e406                	sd	ra,8(sp)
 3a0:	e022                	sd	s0,0(sp)
 3a2:	0800                	add	s0,sp,16
  return memmove(dst, src, n);
 3a4:	00000097          	auipc	ra,0x0
 3a8:	f66080e7          	jalr	-154(ra) # 30a <memmove>
}
 3ac:	60a2                	ld	ra,8(sp)
 3ae:	6402                	ld	s0,0(sp)
 3b0:	0141                	add	sp,sp,16
 3b2:	8082                	ret

00000000000003b4 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 3b4:	4885                	li	a7,1
 ecall
 3b6:	00000073          	ecall
 ret
 3ba:	8082                	ret

00000000000003bc <exit>:
.global exit
exit:
 li a7, SYS_exit
 3bc:	4889                	li	a7,2
 ecall
 3be:	00000073          	ecall
 ret
 3c2:	8082                	ret

00000000000003c4 <wait>:
.global wait
wait:
 li a7, SYS_wait
 3c4:	488d                	li	a7,3
 ecall
 3c6:	00000073          	ecall
 ret
 3ca:	8082                	ret

00000000000003cc <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 3cc:	4891                	li	a7,4
 ecall
 3ce:	00000073          	ecall
 ret
 3d2:	8082                	ret

00000000000003d4 <read>:
.global read
read:
 li a7, SYS_read
 3d4:	4895                	li	a7,5
 ecall
 3d6:	00000073          	ecall
 ret
 3da:	8082                	ret

00000000000003dc <write>:
.global write
write:
 li a7, SYS_write
 3dc:	48c1                	li	a7,16
 ecall
 3de:	00000073          	ecall
 ret
 3e2:	8082                	ret

00000000000003e4 <close>:
.global close
close:
 li a7, SYS_close
 3e4:	48d5                	li	a7,21
 ecall
 3e6:	00000073          	ecall
 ret
 3ea:	8082                	ret

00000000000003ec <kill>:
.global kill
kill:
 li a7, SYS_kill
 3ec:	4899                	li	a7,6
 ecall
 3ee:	00000073          	ecall
 ret
 3f2:	8082                	ret

00000000000003f4 <exec>:
.global exec
exec:
 li a7, SYS_exec
 3f4:	489d                	li	a7,7
 ecall
 3f6:	00000073          	ecall
 ret
 3fa:	8082                	ret

00000000000003fc <open>:
.global open
open:
 li a7, SYS_open
 3fc:	48bd                	li	a7,15
 ecall
 3fe:	00000073          	ecall
 ret
 402:	8082                	ret

0000000000000404 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 404:	48c5                	li	a7,17
 ecall
 406:	00000073          	ecall
 ret
 40a:	8082                	ret

000000000000040c <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 40c:	48c9                	li	a7,18
 ecall
 40e:	00000073          	ecall
 ret
 412:	8082                	ret

0000000000000414 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 414:	48a1                	li	a7,8
 ecall
 416:	00000073          	ecall
 ret
 41a:	8082                	ret

000000000000041c <link>:
.global link
link:
 li a7, SYS_link
 41c:	48cd                	li	a7,19
 ecall
 41e:	00000073          	ecall
 ret
 422:	8082                	ret

0000000000000424 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 424:	48d1                	li	a7,20
 ecall
 426:	00000073          	ecall
 ret
 42a:	8082                	ret

000000000000042c <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 42c:	48a5                	li	a7,9
 ecall
 42e:	00000073          	ecall
 ret
 432:	8082                	ret

0000000000000434 <dup>:
.global dup
dup:
 li a7, SYS_dup
 434:	48a9                	li	a7,10
 ecall
 436:	00000073          	ecall
 ret
 43a:	8082                	ret

000000000000043c <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 43c:	48ad                	li	a7,11
 ecall
 43e:	00000073          	ecall
 ret
 442:	8082                	ret

0000000000000444 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 444:	48b1                	li	a7,12
 ecall
 446:	00000073          	ecall
 ret
 44a:	8082                	ret

000000000000044c <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 44c:	48b5                	li	a7,13
 ecall
 44e:	00000073          	ecall
 ret
 452:	8082                	ret

0000000000000454 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 454:	48b9                	li	a7,14
 ecall
 456:	00000073          	ecall
 ret
 45a:	8082                	ret

000000000000045c <uconnect>:
.global uconnect
uconnect:
 li a7, SYS_uconnect
 45c:	48f5                	li	a7,29
 ecall
 45e:	00000073          	ecall
 ret
 462:	8082                	ret

0000000000000464 <socket>:
.global socket
socket:
 li a7, SYS_socket
 464:	48f9                	li	a7,30
 ecall
 466:	00000073          	ecall
 ret
 46a:	8082                	ret

000000000000046c <bind>:
.global bind
bind:
 li a7, SYS_bind
 46c:	48fd                	li	a7,31
 ecall
 46e:	00000073          	ecall
 ret
 472:	8082                	ret

0000000000000474 <listen>:
.global listen
listen:
 li a7, SYS_listen
 474:	02000893          	li	a7,32
 ecall
 478:	00000073          	ecall
 ret
 47c:	8082                	ret

000000000000047e <accept>:
.global accept
accept:
 li a7, SYS_accept
 47e:	02100893          	li	a7,33
 ecall
 482:	00000073          	ecall
 ret
 486:	8082                	ret

0000000000000488 <connect>:
.global connect
connect:
 li a7, SYS_connect
 488:	02200893          	li	a7,34
 ecall
 48c:	00000073          	ecall
 ret
 490:	8082                	ret

0000000000000492 <sprintint>:
  return 1;
}

static int
sprintint(char *s, int xx, int base, int sign)
{
 492:	1101                	add	sp,sp,-32
 494:	ec22                	sd	s0,24(sp)
 496:	1000                	add	s0,sp,32
 498:	882a                	mv	a6,a0
  char buf[16];
  int i, n;
  uint x;

  if(sign && (sign = xx < 0))
 49a:	c299                	beqz	a3,4a0 <sprintint+0xe>
 49c:	0805c263          	bltz	a1,520 <sprintint+0x8e>
    x = -xx;
  else
    x = xx;
 4a0:	2581                	sext.w	a1,a1
 4a2:	4301                	li	t1,0

  i = 0;
 4a4:	fe040713          	add	a4,s0,-32
 4a8:	4501                	li	a0,0
  do {
    buf[i++] = digits[x % base];
 4aa:	2601                	sext.w	a2,a2
 4ac:	00000697          	auipc	a3,0x0
 4b0:	77468693          	add	a3,a3,1908 # c20 <digits>
 4b4:	88aa                	mv	a7,a0
 4b6:	2505                	addw	a0,a0,1
 4b8:	02c5f7bb          	remuw	a5,a1,a2
 4bc:	1782                	sll	a5,a5,0x20
 4be:	9381                	srl	a5,a5,0x20
 4c0:	97b6                	add	a5,a5,a3
 4c2:	0007c783          	lbu	a5,0(a5)
 4c6:	00f70023          	sb	a5,0(a4)
  } while((x /= base) != 0);
 4ca:	0005879b          	sext.w	a5,a1
 4ce:	02c5d5bb          	divuw	a1,a1,a2
 4d2:	0705                	add	a4,a4,1
 4d4:	fec7f0e3          	bgeu	a5,a2,4b4 <sprintint+0x22>

  if(sign)
 4d8:	00030b63          	beqz	t1,4ee <sprintint+0x5c>
    buf[i++] = '-';
 4dc:	ff050793          	add	a5,a0,-16
 4e0:	97a2                	add	a5,a5,s0
 4e2:	02d00713          	li	a4,45
 4e6:	fee78823          	sb	a4,-16(a5)
 4ea:	0028851b          	addw	a0,a7,2

  n = 0;
  while(--i >= 0)
 4ee:	02a05d63          	blez	a0,528 <sprintint+0x96>
 4f2:	fe040793          	add	a5,s0,-32
 4f6:	00a78733          	add	a4,a5,a0
 4fa:	87c2                	mv	a5,a6
 4fc:	00180613          	add	a2,a6,1
 500:	fff5069b          	addw	a3,a0,-1
 504:	1682                	sll	a3,a3,0x20
 506:	9281                	srl	a3,a3,0x20
 508:	9636                	add	a2,a2,a3
  *s = c;
 50a:	fff74683          	lbu	a3,-1(a4)
 50e:	00d78023          	sb	a3,0(a5)
  while(--i >= 0)
 512:	177d                	add	a4,a4,-1
 514:	0785                	add	a5,a5,1
 516:	fec79ae3          	bne	a5,a2,50a <sprintint+0x78>
    n += sputc(s+n, buf[i]);
  return n;
}
 51a:	6462                	ld	s0,24(sp)
 51c:	6105                	add	sp,sp,32
 51e:	8082                	ret
    x = -xx;
 520:	40b005bb          	negw	a1,a1
  if(sign && (sign = xx < 0))
 524:	4305                	li	t1,1
    x = -xx;
 526:	bfbd                	j	4a4 <sprintint+0x12>
  while(--i >= 0)
 528:	4501                	li	a0,0
 52a:	bfc5                	j	51a <sprintint+0x88>

000000000000052c <putc>:
{
 52c:	1101                	add	sp,sp,-32
 52e:	ec06                	sd	ra,24(sp)
 530:	e822                	sd	s0,16(sp)
 532:	1000                	add	s0,sp,32
 534:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 538:	4605                	li	a2,1
 53a:	fef40593          	add	a1,s0,-17
 53e:	00000097          	auipc	ra,0x0
 542:	e9e080e7          	jalr	-354(ra) # 3dc <write>
}
 546:	60e2                	ld	ra,24(sp)
 548:	6442                	ld	s0,16(sp)
 54a:	6105                	add	sp,sp,32
 54c:	8082                	ret

000000000000054e <printint>:
{
 54e:	7139                	add	sp,sp,-64
 550:	fc06                	sd	ra,56(sp)
 552:	f822                	sd	s0,48(sp)
 554:	f426                	sd	s1,40(sp)
 556:	0080                	add	s0,sp,64
 558:	84aa                	mv	s1,a0
  if(sgn && xx < 0){
 55a:	c299                	beqz	a3,560 <printint+0x12>
 55c:	0805cb63          	bltz	a1,5f2 <printint+0xa4>
    x = xx;
 560:	2581                	sext.w	a1,a1
  neg = 0;
 562:	4881                	li	a7,0
 564:	fc040693          	add	a3,s0,-64
  i = 0;
 568:	4701                	li	a4,0
    buf[i++] = digits[x % base];
 56a:	2601                	sext.w	a2,a2
 56c:	00000517          	auipc	a0,0x0
 570:	6b450513          	add	a0,a0,1716 # c20 <digits>
 574:	883a                	mv	a6,a4
 576:	2705                	addw	a4,a4,1
 578:	02c5f7bb          	remuw	a5,a1,a2
 57c:	1782                	sll	a5,a5,0x20
 57e:	9381                	srl	a5,a5,0x20
 580:	97aa                	add	a5,a5,a0
 582:	0007c783          	lbu	a5,0(a5)
 586:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 58a:	0005879b          	sext.w	a5,a1
 58e:	02c5d5bb          	divuw	a1,a1,a2
 592:	0685                	add	a3,a3,1
 594:	fec7f0e3          	bgeu	a5,a2,574 <printint+0x26>
  if(neg)
 598:	00088c63          	beqz	a7,5b0 <printint+0x62>
    buf[i++] = '-';
 59c:	fd070793          	add	a5,a4,-48
 5a0:	00878733          	add	a4,a5,s0
 5a4:	02d00793          	li	a5,45
 5a8:	fef70823          	sb	a5,-16(a4)
 5ac:	0028071b          	addw	a4,a6,2
  while(--i >= 0)
 5b0:	02e05c63          	blez	a4,5e8 <printint+0x9a>
 5b4:	f04a                	sd	s2,32(sp)
 5b6:	ec4e                	sd	s3,24(sp)
 5b8:	fc040793          	add	a5,s0,-64
 5bc:	00e78933          	add	s2,a5,a4
 5c0:	fff78993          	add	s3,a5,-1
 5c4:	99ba                	add	s3,s3,a4
 5c6:	377d                	addw	a4,a4,-1
 5c8:	1702                	sll	a4,a4,0x20
 5ca:	9301                	srl	a4,a4,0x20
 5cc:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 5d0:	fff94583          	lbu	a1,-1(s2)
 5d4:	8526                	mv	a0,s1
 5d6:	00000097          	auipc	ra,0x0
 5da:	f56080e7          	jalr	-170(ra) # 52c <putc>
  while(--i >= 0)
 5de:	197d                	add	s2,s2,-1
 5e0:	ff3918e3          	bne	s2,s3,5d0 <printint+0x82>
 5e4:	7902                	ld	s2,32(sp)
 5e6:	69e2                	ld	s3,24(sp)
}
 5e8:	70e2                	ld	ra,56(sp)
 5ea:	7442                	ld	s0,48(sp)
 5ec:	74a2                	ld	s1,40(sp)
 5ee:	6121                	add	sp,sp,64
 5f0:	8082                	ret
    x = -xx;
 5f2:	40b005bb          	negw	a1,a1
    neg = 1;
 5f6:	4885                	li	a7,1
    x = -xx;
 5f8:	b7b5                	j	564 <printint+0x16>

00000000000005fa <vprintf>:
{
 5fa:	715d                	add	sp,sp,-80
 5fc:	e486                	sd	ra,72(sp)
 5fe:	e0a2                	sd	s0,64(sp)
 600:	f84a                	sd	s2,48(sp)
 602:	0880                	add	s0,sp,80
  for(i = 0; fmt[i]; i++){
 604:	0005c903          	lbu	s2,0(a1)
 608:	1a090a63          	beqz	s2,7bc <vprintf+0x1c2>
 60c:	fc26                	sd	s1,56(sp)
 60e:	f44e                	sd	s3,40(sp)
 610:	f052                	sd	s4,32(sp)
 612:	ec56                	sd	s5,24(sp)
 614:	e85a                	sd	s6,16(sp)
 616:	e45e                	sd	s7,8(sp)
 618:	8aaa                	mv	s5,a0
 61a:	8bb2                	mv	s7,a2
 61c:	00158493          	add	s1,a1,1
  state = 0;
 620:	4981                	li	s3,0
    } else if(state == '%'){
 622:	02500a13          	li	s4,37
 626:	4b55                	li	s6,21
 628:	a839                	j	646 <vprintf+0x4c>
        putc(fd, c);
 62a:	85ca                	mv	a1,s2
 62c:	8556                	mv	a0,s5
 62e:	00000097          	auipc	ra,0x0
 632:	efe080e7          	jalr	-258(ra) # 52c <putc>
 636:	a019                	j	63c <vprintf+0x42>
    } else if(state == '%'){
 638:	01498d63          	beq	s3,s4,652 <vprintf+0x58>
  for(i = 0; fmt[i]; i++){
 63c:	0485                	add	s1,s1,1
 63e:	fff4c903          	lbu	s2,-1(s1)
 642:	16090763          	beqz	s2,7b0 <vprintf+0x1b6>
    if(state == 0){
 646:	fe0999e3          	bnez	s3,638 <vprintf+0x3e>
      if(c == '%'){
 64a:	ff4910e3          	bne	s2,s4,62a <vprintf+0x30>
        state = '%';
 64e:	89d2                	mv	s3,s4
 650:	b7f5                	j	63c <vprintf+0x42>
      if(c == 'd'){
 652:	13490463          	beq	s2,s4,77a <vprintf+0x180>
 656:	f9d9079b          	addw	a5,s2,-99
 65a:	0ff7f793          	zext.b	a5,a5
 65e:	12fb6763          	bltu	s6,a5,78c <vprintf+0x192>
 662:	f9d9079b          	addw	a5,s2,-99
 666:	0ff7f713          	zext.b	a4,a5
 66a:	12eb6163          	bltu	s6,a4,78c <vprintf+0x192>
 66e:	00271793          	sll	a5,a4,0x2
 672:	00000717          	auipc	a4,0x0
 676:	55670713          	add	a4,a4,1366 # bc8 <malloc+0x154>
 67a:	97ba                	add	a5,a5,a4
 67c:	439c                	lw	a5,0(a5)
 67e:	97ba                	add	a5,a5,a4
 680:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 682:	008b8913          	add	s2,s7,8
 686:	4685                	li	a3,1
 688:	4629                	li	a2,10
 68a:	000ba583          	lw	a1,0(s7)
 68e:	8556                	mv	a0,s5
 690:	00000097          	auipc	ra,0x0
 694:	ebe080e7          	jalr	-322(ra) # 54e <printint>
 698:	8bca                	mv	s7,s2
      state = 0;
 69a:	4981                	li	s3,0
 69c:	b745                	j	63c <vprintf+0x42>
        printint(fd, va_arg(ap, uint64), 10, 0);
 69e:	008b8913          	add	s2,s7,8
 6a2:	4681                	li	a3,0
 6a4:	4629                	li	a2,10
 6a6:	000ba583          	lw	a1,0(s7)
 6aa:	8556                	mv	a0,s5
 6ac:	00000097          	auipc	ra,0x0
 6b0:	ea2080e7          	jalr	-350(ra) # 54e <printint>
 6b4:	8bca                	mv	s7,s2
      state = 0;
 6b6:	4981                	li	s3,0
 6b8:	b751                	j	63c <vprintf+0x42>
        printint(fd, va_arg(ap, int), 16, 0);
 6ba:	008b8913          	add	s2,s7,8
 6be:	4681                	li	a3,0
 6c0:	4641                	li	a2,16
 6c2:	000ba583          	lw	a1,0(s7)
 6c6:	8556                	mv	a0,s5
 6c8:	00000097          	auipc	ra,0x0
 6cc:	e86080e7          	jalr	-378(ra) # 54e <printint>
 6d0:	8bca                	mv	s7,s2
      state = 0;
 6d2:	4981                	li	s3,0
 6d4:	b7a5                	j	63c <vprintf+0x42>
 6d6:	e062                	sd	s8,0(sp)
        printptr(fd, va_arg(ap, uint64));
 6d8:	008b8c13          	add	s8,s7,8
 6dc:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 6e0:	03000593          	li	a1,48
 6e4:	8556                	mv	a0,s5
 6e6:	00000097          	auipc	ra,0x0
 6ea:	e46080e7          	jalr	-442(ra) # 52c <putc>
  putc(fd, 'x');
 6ee:	07800593          	li	a1,120
 6f2:	8556                	mv	a0,s5
 6f4:	00000097          	auipc	ra,0x0
 6f8:	e38080e7          	jalr	-456(ra) # 52c <putc>
 6fc:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 6fe:	00000b97          	auipc	s7,0x0
 702:	522b8b93          	add	s7,s7,1314 # c20 <digits>
 706:	03c9d793          	srl	a5,s3,0x3c
 70a:	97de                	add	a5,a5,s7
 70c:	0007c583          	lbu	a1,0(a5)
 710:	8556                	mv	a0,s5
 712:	00000097          	auipc	ra,0x0
 716:	e1a080e7          	jalr	-486(ra) # 52c <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 71a:	0992                	sll	s3,s3,0x4
 71c:	397d                	addw	s2,s2,-1
 71e:	fe0914e3          	bnez	s2,706 <vprintf+0x10c>
        printptr(fd, va_arg(ap, uint64));
 722:	8be2                	mv	s7,s8
      state = 0;
 724:	4981                	li	s3,0
 726:	6c02                	ld	s8,0(sp)
 728:	bf11                	j	63c <vprintf+0x42>
        s = va_arg(ap, char*);
 72a:	008b8993          	add	s3,s7,8
 72e:	000bb903          	ld	s2,0(s7)
        if(s == 0)
 732:	02090163          	beqz	s2,754 <vprintf+0x15a>
        while(*s != 0){
 736:	00094583          	lbu	a1,0(s2)
 73a:	c9a5                	beqz	a1,7aa <vprintf+0x1b0>
          putc(fd, *s);
 73c:	8556                	mv	a0,s5
 73e:	00000097          	auipc	ra,0x0
 742:	dee080e7          	jalr	-530(ra) # 52c <putc>
          s++;
 746:	0905                	add	s2,s2,1
        while(*s != 0){
 748:	00094583          	lbu	a1,0(s2)
 74c:	f9e5                	bnez	a1,73c <vprintf+0x142>
        s = va_arg(ap, char*);
 74e:	8bce                	mv	s7,s3
      state = 0;
 750:	4981                	li	s3,0
 752:	b5ed                	j	63c <vprintf+0x42>
          s = "(null)";
 754:	00000917          	auipc	s2,0x0
 758:	46c90913          	add	s2,s2,1132 # bc0 <malloc+0x14c>
        while(*s != 0){
 75c:	02800593          	li	a1,40
 760:	bff1                	j	73c <vprintf+0x142>
        putc(fd, va_arg(ap, uint));
 762:	008b8913          	add	s2,s7,8
 766:	000bc583          	lbu	a1,0(s7)
 76a:	8556                	mv	a0,s5
 76c:	00000097          	auipc	ra,0x0
 770:	dc0080e7          	jalr	-576(ra) # 52c <putc>
 774:	8bca                	mv	s7,s2
      state = 0;
 776:	4981                	li	s3,0
 778:	b5d1                	j	63c <vprintf+0x42>
        putc(fd, c);
 77a:	02500593          	li	a1,37
 77e:	8556                	mv	a0,s5
 780:	00000097          	auipc	ra,0x0
 784:	dac080e7          	jalr	-596(ra) # 52c <putc>
      state = 0;
 788:	4981                	li	s3,0
 78a:	bd4d                	j	63c <vprintf+0x42>
        putc(fd, '%');
 78c:	02500593          	li	a1,37
 790:	8556                	mv	a0,s5
 792:	00000097          	auipc	ra,0x0
 796:	d9a080e7          	jalr	-614(ra) # 52c <putc>
        putc(fd, c);
 79a:	85ca                	mv	a1,s2
 79c:	8556                	mv	a0,s5
 79e:	00000097          	auipc	ra,0x0
 7a2:	d8e080e7          	jalr	-626(ra) # 52c <putc>
      state = 0;
 7a6:	4981                	li	s3,0
 7a8:	bd51                	j	63c <vprintf+0x42>
        s = va_arg(ap, char*);
 7aa:	8bce                	mv	s7,s3
      state = 0;
 7ac:	4981                	li	s3,0
 7ae:	b579                	j	63c <vprintf+0x42>
 7b0:	74e2                	ld	s1,56(sp)
 7b2:	79a2                	ld	s3,40(sp)
 7b4:	7a02                	ld	s4,32(sp)
 7b6:	6ae2                	ld	s5,24(sp)
 7b8:	6b42                	ld	s6,16(sp)
 7ba:	6ba2                	ld	s7,8(sp)
}
 7bc:	60a6                	ld	ra,72(sp)
 7be:	6406                	ld	s0,64(sp)
 7c0:	7942                	ld	s2,48(sp)
 7c2:	6161                	add	sp,sp,80
 7c4:	8082                	ret

00000000000007c6 <fprintf>:
{
 7c6:	715d                	add	sp,sp,-80
 7c8:	ec06                	sd	ra,24(sp)
 7ca:	e822                	sd	s0,16(sp)
 7cc:	1000                	add	s0,sp,32
 7ce:	e010                	sd	a2,0(s0)
 7d0:	e414                	sd	a3,8(s0)
 7d2:	e818                	sd	a4,16(s0)
 7d4:	ec1c                	sd	a5,24(s0)
 7d6:	03043023          	sd	a6,32(s0)
 7da:	03143423          	sd	a7,40(s0)
  va_start(ap, fmt);
 7de:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 7e2:	8622                	mv	a2,s0
 7e4:	00000097          	auipc	ra,0x0
 7e8:	e16080e7          	jalr	-490(ra) # 5fa <vprintf>
}
 7ec:	60e2                	ld	ra,24(sp)
 7ee:	6442                	ld	s0,16(sp)
 7f0:	6161                	add	sp,sp,80
 7f2:	8082                	ret

00000000000007f4 <printf>:
{
 7f4:	711d                	add	sp,sp,-96
 7f6:	ec06                	sd	ra,24(sp)
 7f8:	e822                	sd	s0,16(sp)
 7fa:	1000                	add	s0,sp,32
 7fc:	e40c                	sd	a1,8(s0)
 7fe:	e810                	sd	a2,16(s0)
 800:	ec14                	sd	a3,24(s0)
 802:	f018                	sd	a4,32(s0)
 804:	f41c                	sd	a5,40(s0)
 806:	03043823          	sd	a6,48(s0)
 80a:	03143c23          	sd	a7,56(s0)
  va_start(ap, fmt);
 80e:	00840613          	add	a2,s0,8
 812:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 816:	85aa                	mv	a1,a0
 818:	4505                	li	a0,1
 81a:	00000097          	auipc	ra,0x0
 81e:	de0080e7          	jalr	-544(ra) # 5fa <vprintf>
}
 822:	60e2                	ld	ra,24(sp)
 824:	6442                	ld	s0,16(sp)
 826:	6125                	add	sp,sp,96
 828:	8082                	ret

000000000000082a <snprintf>:

int
snprintf(char *buf, int sz, char *fmt, ...)
{
 82a:	7135                	add	sp,sp,-160
 82c:	f486                	sd	ra,104(sp)
 82e:	f0a2                	sd	s0,96(sp)
 830:	eca6                	sd	s1,88(sp)
 832:	1880                	add	s0,sp,112
 834:	e414                	sd	a3,8(s0)
 836:	e818                	sd	a4,16(s0)
 838:	ec1c                	sd	a5,24(s0)
 83a:	03043023          	sd	a6,32(s0)
 83e:	03143423          	sd	a7,40(s0)
  va_list ap;
  int i, c;
  int off = 0;
  char *s;

  if (fmt == 0)
 842:	16060b63          	beqz	a2,9b8 <snprintf+0x18e>
 846:	e8ca                	sd	s2,80(sp)
 848:	e4ce                	sd	s3,72(sp)
 84a:	fc56                	sd	s5,56(sp)
 84c:	f85a                	sd	s6,48(sp)
 84e:	8b2a                	mv	s6,a0
 850:	8aae                	mv	s5,a1
 852:	89b2                	mv	s3,a2
    return -1;

  va_start(ap, fmt);
 854:	00840793          	add	a5,s0,8
 858:	f8f43c23          	sd	a5,-104(s0)
  int off = 0;
 85c:	4481                	li	s1,0
  for(i = 0; off < sz && (c = fmt[i] & 0xff) != 0; i++){
 85e:	4901                	li	s2,0
 860:	00b05f63          	blez	a1,87e <snprintf+0x54>
 864:	e0d2                	sd	s4,64(sp)
 866:	f45e                	sd	s7,40(sp)
 868:	f062                	sd	s8,32(sp)
 86a:	ec66                	sd	s9,24(sp)
    if(c != '%'){
 86c:	02500a13          	li	s4,37
      continue;
    }
    c = fmt[++i] & 0xff;
    if(c == 0)
      break;
    switch(c){
 870:	07300b93          	li	s7,115
 874:	07800c93          	li	s9,120
 878:	06400c13          	li	s8,100
 87c:	a839                	j	89a <snprintf+0x70>
      off += sputc(buf+off, '%');
      off += sputc(buf+off, c);
      break;
    }
  }
  return off;
 87e:	4481                	li	s1,0
 880:	6946                	ld	s2,80(sp)
 882:	69a6                	ld	s3,72(sp)
 884:	7ae2                	ld	s5,56(sp)
 886:	7b42                	ld	s6,48(sp)
 888:	a0cd                	j	96a <snprintf+0x140>
  *s = c;
 88a:	009b0733          	add	a4,s6,s1
 88e:	00f70023          	sb	a5,0(a4)
      off += sputc(buf+off, c);
 892:	2485                	addw	s1,s1,1
  for(i = 0; off < sz && (c = fmt[i] & 0xff) != 0; i++){
 894:	2905                	addw	s2,s2,1
 896:	1554d563          	bge	s1,s5,9e0 <snprintf+0x1b6>
 89a:	012987b3          	add	a5,s3,s2
 89e:	0007c783          	lbu	a5,0(a5)
 8a2:	0007871b          	sext.w	a4,a5
 8a6:	10078063          	beqz	a5,9a6 <snprintf+0x17c>
    if(c != '%'){
 8aa:	ff4710e3          	bne	a4,s4,88a <snprintf+0x60>
    c = fmt[++i] & 0xff;
 8ae:	2905                	addw	s2,s2,1
 8b0:	012987b3          	add	a5,s3,s2
 8b4:	0007c783          	lbu	a5,0(a5)
    if(c == 0)
 8b8:	10078263          	beqz	a5,9bc <snprintf+0x192>
    switch(c){
 8bc:	05778c63          	beq	a5,s7,914 <snprintf+0xea>
 8c0:	02fbe763          	bltu	s7,a5,8ee <snprintf+0xc4>
 8c4:	0d478063          	beq	a5,s4,984 <snprintf+0x15a>
 8c8:	0d879463          	bne	a5,s8,990 <snprintf+0x166>
      off += sprintint(buf+off, va_arg(ap, int), 10, 1);
 8cc:	f9843783          	ld	a5,-104(s0)
 8d0:	00878713          	add	a4,a5,8
 8d4:	f8e43c23          	sd	a4,-104(s0)
 8d8:	4685                	li	a3,1
 8da:	4629                	li	a2,10
 8dc:	438c                	lw	a1,0(a5)
 8de:	009b0533          	add	a0,s6,s1
 8e2:	00000097          	auipc	ra,0x0
 8e6:	bb0080e7          	jalr	-1104(ra) # 492 <sprintint>
 8ea:	9ca9                	addw	s1,s1,a0
      break;
 8ec:	b765                	j	894 <snprintf+0x6a>
    switch(c){
 8ee:	0b979163          	bne	a5,s9,990 <snprintf+0x166>
      off += sprintint(buf+off, va_arg(ap, int), 16, 1);
 8f2:	f9843783          	ld	a5,-104(s0)
 8f6:	00878713          	add	a4,a5,8
 8fa:	f8e43c23          	sd	a4,-104(s0)
 8fe:	4685                	li	a3,1
 900:	4641                	li	a2,16
 902:	438c                	lw	a1,0(a5)
 904:	009b0533          	add	a0,s6,s1
 908:	00000097          	auipc	ra,0x0
 90c:	b8a080e7          	jalr	-1142(ra) # 492 <sprintint>
 910:	9ca9                	addw	s1,s1,a0
      break;
 912:	b749                	j	894 <snprintf+0x6a>
      if((s = va_arg(ap, char*)) == 0)
 914:	f9843783          	ld	a5,-104(s0)
 918:	00878713          	add	a4,a5,8
 91c:	f8e43c23          	sd	a4,-104(s0)
 920:	6388                	ld	a0,0(a5)
 922:	c931                	beqz	a0,976 <snprintf+0x14c>
      for(; *s && off < sz; s++)
 924:	00054703          	lbu	a4,0(a0)
 928:	d735                	beqz	a4,894 <snprintf+0x6a>
 92a:	0b54d263          	bge	s1,s5,9ce <snprintf+0x1a4>
 92e:	009b06b3          	add	a3,s6,s1
 932:	409a863b          	subw	a2,s5,s1
 936:	1602                	sll	a2,a2,0x20
 938:	9201                	srl	a2,a2,0x20
 93a:	962a                	add	a2,a2,a0
 93c:	87aa                	mv	a5,a0
        off += sputc(buf+off, *s);
 93e:	0014859b          	addw	a1,s1,1
 942:	9d89                	subw	a1,a1,a0
  *s = c;
 944:	00e68023          	sb	a4,0(a3)
        off += sputc(buf+off, *s);
 948:	00f584bb          	addw	s1,a1,a5
      for(; *s && off < sz; s++)
 94c:	0785                	add	a5,a5,1
 94e:	0007c703          	lbu	a4,0(a5)
 952:	d329                	beqz	a4,894 <snprintf+0x6a>
 954:	0685                	add	a3,a3,1
 956:	fec797e3          	bne	a5,a2,944 <snprintf+0x11a>
 95a:	6946                	ld	s2,80(sp)
 95c:	69a6                	ld	s3,72(sp)
 95e:	6a06                	ld	s4,64(sp)
 960:	7ae2                	ld	s5,56(sp)
 962:	7b42                	ld	s6,48(sp)
 964:	7ba2                	ld	s7,40(sp)
 966:	7c02                	ld	s8,32(sp)
 968:	6ce2                	ld	s9,24(sp)
 96a:	8526                	mv	a0,s1
 96c:	70a6                	ld	ra,104(sp)
 96e:	7406                	ld	s0,96(sp)
 970:	64e6                	ld	s1,88(sp)
 972:	610d                	add	sp,sp,160
 974:	8082                	ret
      for(; *s && off < sz; s++)
 976:	02800713          	li	a4,40
        s = "(null)";
 97a:	00000517          	auipc	a0,0x0
 97e:	24650513          	add	a0,a0,582 # bc0 <malloc+0x14c>
 982:	b765                	j	92a <snprintf+0x100>
  *s = c;
 984:	009b07b3          	add	a5,s6,s1
 988:	01478023          	sb	s4,0(a5)
      off += sputc(buf+off, '%');
 98c:	2485                	addw	s1,s1,1
      break;
 98e:	b719                	j	894 <snprintf+0x6a>
  *s = c;
 990:	009b0733          	add	a4,s6,s1
 994:	01470023          	sb	s4,0(a4)
      off += sputc(buf+off, c);
 998:	0014871b          	addw	a4,s1,1
  *s = c;
 99c:	975a                	add	a4,a4,s6
 99e:	00f70023          	sb	a5,0(a4)
      off += sputc(buf+off, c);
 9a2:	2489                	addw	s1,s1,2
      break;
 9a4:	bdc5                	j	894 <snprintf+0x6a>
 9a6:	6946                	ld	s2,80(sp)
 9a8:	69a6                	ld	s3,72(sp)
 9aa:	6a06                	ld	s4,64(sp)
 9ac:	7ae2                	ld	s5,56(sp)
 9ae:	7b42                	ld	s6,48(sp)
 9b0:	7ba2                	ld	s7,40(sp)
 9b2:	7c02                	ld	s8,32(sp)
 9b4:	6ce2                	ld	s9,24(sp)
 9b6:	bf55                	j	96a <snprintf+0x140>
    return -1;
 9b8:	54fd                	li	s1,-1
 9ba:	bf45                	j	96a <snprintf+0x140>
 9bc:	6946                	ld	s2,80(sp)
 9be:	69a6                	ld	s3,72(sp)
 9c0:	6a06                	ld	s4,64(sp)
 9c2:	7ae2                	ld	s5,56(sp)
 9c4:	7b42                	ld	s6,48(sp)
 9c6:	7ba2                	ld	s7,40(sp)
 9c8:	7c02                	ld	s8,32(sp)
 9ca:	6ce2                	ld	s9,24(sp)
 9cc:	bf79                	j	96a <snprintf+0x140>
 9ce:	6946                	ld	s2,80(sp)
 9d0:	69a6                	ld	s3,72(sp)
 9d2:	6a06                	ld	s4,64(sp)
 9d4:	7ae2                	ld	s5,56(sp)
 9d6:	7b42                	ld	s6,48(sp)
 9d8:	7ba2                	ld	s7,40(sp)
 9da:	7c02                	ld	s8,32(sp)
 9dc:	6ce2                	ld	s9,24(sp)
 9de:	b771                	j	96a <snprintf+0x140>
 9e0:	6946                	ld	s2,80(sp)
 9e2:	69a6                	ld	s3,72(sp)
 9e4:	6a06                	ld	s4,64(sp)
 9e6:	7ae2                	ld	s5,56(sp)
 9e8:	7b42                	ld	s6,48(sp)
 9ea:	7ba2                	ld	s7,40(sp)
 9ec:	7c02                	ld	s8,32(sp)
 9ee:	6ce2                	ld	s9,24(sp)
 9f0:	bfad                	j	96a <snprintf+0x140>

00000000000009f2 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 9f2:	1141                	add	sp,sp,-16
 9f4:	e422                	sd	s0,8(sp)
 9f6:	0800                	add	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 9f8:	ff050693          	add	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 9fc:	00000797          	auipc	a5,0x0
 a00:	23c7b783          	ld	a5,572(a5) # c38 <freep>
 a04:	a02d                	j	a2e <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 a06:	4618                	lw	a4,8(a2)
 a08:	9f2d                	addw	a4,a4,a1
 a0a:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 a0e:	6398                	ld	a4,0(a5)
 a10:	6310                	ld	a2,0(a4)
 a12:	a83d                	j	a50 <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 a14:	ff852703          	lw	a4,-8(a0)
 a18:	9f31                	addw	a4,a4,a2
 a1a:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 a1c:	ff053683          	ld	a3,-16(a0)
 a20:	a091                	j	a64 <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 a22:	6398                	ld	a4,0(a5)
 a24:	00e7e463          	bltu	a5,a4,a2c <free+0x3a>
 a28:	00e6ea63          	bltu	a3,a4,a3c <free+0x4a>
{
 a2c:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 a2e:	fed7fae3          	bgeu	a5,a3,a22 <free+0x30>
 a32:	6398                	ld	a4,0(a5)
 a34:	00e6e463          	bltu	a3,a4,a3c <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 a38:	fee7eae3          	bltu	a5,a4,a2c <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 a3c:	ff852583          	lw	a1,-8(a0)
 a40:	6390                	ld	a2,0(a5)
 a42:	02059813          	sll	a6,a1,0x20
 a46:	01c85713          	srl	a4,a6,0x1c
 a4a:	9736                	add	a4,a4,a3
 a4c:	fae60de3          	beq	a2,a4,a06 <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 a50:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 a54:	4790                	lw	a2,8(a5)
 a56:	02061593          	sll	a1,a2,0x20
 a5a:	01c5d713          	srl	a4,a1,0x1c
 a5e:	973e                	add	a4,a4,a5
 a60:	fae68ae3          	beq	a3,a4,a14 <free+0x22>
    p->s.ptr = bp->s.ptr;
 a64:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 a66:	00000717          	auipc	a4,0x0
 a6a:	1cf73923          	sd	a5,466(a4) # c38 <freep>
}
 a6e:	6422                	ld	s0,8(sp)
 a70:	0141                	add	sp,sp,16
 a72:	8082                	ret

0000000000000a74 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 a74:	7139                	add	sp,sp,-64
 a76:	fc06                	sd	ra,56(sp)
 a78:	f822                	sd	s0,48(sp)
 a7a:	f426                	sd	s1,40(sp)
 a7c:	ec4e                	sd	s3,24(sp)
 a7e:	0080                	add	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 a80:	02051493          	sll	s1,a0,0x20
 a84:	9081                	srl	s1,s1,0x20
 a86:	04bd                	add	s1,s1,15
 a88:	8091                	srl	s1,s1,0x4
 a8a:	0014899b          	addw	s3,s1,1
 a8e:	0485                	add	s1,s1,1
  if((prevp = freep) == 0){
 a90:	00000517          	auipc	a0,0x0
 a94:	1a853503          	ld	a0,424(a0) # c38 <freep>
 a98:	c915                	beqz	a0,acc <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a9a:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 a9c:	4798                	lw	a4,8(a5)
 a9e:	08977e63          	bgeu	a4,s1,b3a <malloc+0xc6>
 aa2:	f04a                	sd	s2,32(sp)
 aa4:	e852                	sd	s4,16(sp)
 aa6:	e456                	sd	s5,8(sp)
 aa8:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 aaa:	8a4e                	mv	s4,s3
 aac:	0009871b          	sext.w	a4,s3
 ab0:	6685                	lui	a3,0x1
 ab2:	00d77363          	bgeu	a4,a3,ab8 <malloc+0x44>
 ab6:	6a05                	lui	s4,0x1
 ab8:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 abc:	004a1a1b          	sllw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 ac0:	00000917          	auipc	s2,0x0
 ac4:	17890913          	add	s2,s2,376 # c38 <freep>
  if(p == (char*)-1)
 ac8:	5afd                	li	s5,-1
 aca:	a091                	j	b0e <malloc+0x9a>
 acc:	f04a                	sd	s2,32(sp)
 ace:	e852                	sd	s4,16(sp)
 ad0:	e456                	sd	s5,8(sp)
 ad2:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 ad4:	00000797          	auipc	a5,0x0
 ad8:	36c78793          	add	a5,a5,876 # e40 <base>
 adc:	00000717          	auipc	a4,0x0
 ae0:	14f73e23          	sd	a5,348(a4) # c38 <freep>
 ae4:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 ae6:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 aea:	b7c1                	j	aaa <malloc+0x36>
        prevp->s.ptr = p->s.ptr;
 aec:	6398                	ld	a4,0(a5)
 aee:	e118                	sd	a4,0(a0)
 af0:	a08d                	j	b52 <malloc+0xde>
  hp->s.size = nu;
 af2:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 af6:	0541                	add	a0,a0,16
 af8:	00000097          	auipc	ra,0x0
 afc:	efa080e7          	jalr	-262(ra) # 9f2 <free>
  return freep;
 b00:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 b04:	c13d                	beqz	a0,b6a <malloc+0xf6>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 b06:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 b08:	4798                	lw	a4,8(a5)
 b0a:	02977463          	bgeu	a4,s1,b32 <malloc+0xbe>
    if(p == freep)
 b0e:	00093703          	ld	a4,0(s2)
 b12:	853e                	mv	a0,a5
 b14:	fef719e3          	bne	a4,a5,b06 <malloc+0x92>
  p = sbrk(nu * sizeof(Header));
 b18:	8552                	mv	a0,s4
 b1a:	00000097          	auipc	ra,0x0
 b1e:	92a080e7          	jalr	-1750(ra) # 444 <sbrk>
  if(p == (char*)-1)
 b22:	fd5518e3          	bne	a0,s5,af2 <malloc+0x7e>
        return 0;
 b26:	4501                	li	a0,0
 b28:	7902                	ld	s2,32(sp)
 b2a:	6a42                	ld	s4,16(sp)
 b2c:	6aa2                	ld	s5,8(sp)
 b2e:	6b02                	ld	s6,0(sp)
 b30:	a03d                	j	b5e <malloc+0xea>
 b32:	7902                	ld	s2,32(sp)
 b34:	6a42                	ld	s4,16(sp)
 b36:	6aa2                	ld	s5,8(sp)
 b38:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 b3a:	fae489e3          	beq	s1,a4,aec <malloc+0x78>
        p->s.size -= nunits;
 b3e:	4137073b          	subw	a4,a4,s3
 b42:	c798                	sw	a4,8(a5)
        p += p->s.size;
 b44:	02071693          	sll	a3,a4,0x20
 b48:	01c6d713          	srl	a4,a3,0x1c
 b4c:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 b4e:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 b52:	00000717          	auipc	a4,0x0
 b56:	0ea73323          	sd	a0,230(a4) # c38 <freep>
      return (void*)(p + 1);
 b5a:	01078513          	add	a0,a5,16
  }
}
 b5e:	70e2                	ld	ra,56(sp)
 b60:	7442                	ld	s0,48(sp)
 b62:	74a2                	ld	s1,40(sp)
 b64:	69e2                	ld	s3,24(sp)
 b66:	6121                	add	sp,sp,64
 b68:	8082                	ret
 b6a:	7902                	ld	s2,32(sp)
 b6c:	6a42                	ld	s4,16(sp)
 b6e:	6aa2                	ld	s5,8(sp)
 b70:	6b02                	ld	s6,0(sp)
 b72:	b7f5                	j	b5e <malloc+0xea>
