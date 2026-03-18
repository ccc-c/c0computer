
user/_wc:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <wc>:

char buf[512];

void
wc(int fd, char *name)
{
   0:	7119                	add	sp,sp,-128
   2:	fc86                	sd	ra,120(sp)
   4:	f8a2                	sd	s0,112(sp)
   6:	f4a6                	sd	s1,104(sp)
   8:	f0ca                	sd	s2,96(sp)
   a:	ecce                	sd	s3,88(sp)
   c:	e8d2                	sd	s4,80(sp)
   e:	e4d6                	sd	s5,72(sp)
  10:	e0da                	sd	s6,64(sp)
  12:	fc5e                	sd	s7,56(sp)
  14:	f862                	sd	s8,48(sp)
  16:	f466                	sd	s9,40(sp)
  18:	f06a                	sd	s10,32(sp)
  1a:	ec6e                	sd	s11,24(sp)
  1c:	0100                	add	s0,sp,128
  1e:	f8a43423          	sd	a0,-120(s0)
  22:	f8b43023          	sd	a1,-128(s0)
  int i, n;
  int l, w, c, inword;

  l = w = c = 0;
  inword = 0;
  26:	4901                	li	s2,0
  l = w = c = 0;
  28:	4d01                	li	s10,0
  2a:	4c81                	li	s9,0
  2c:	4c01                	li	s8,0
  while((n = read(fd, buf, sizeof(buf))) > 0){
  2e:	00001d97          	auipc	s11,0x1
  32:	c82d8d93          	add	s11,s11,-894 # cb0 <buf>
    for(i=0; i<n; i++){
      c++;
      if(buf[i] == '\n')
  36:	4aa9                	li	s5,10
        l++;
      if(strchr(" \r\t\n\v", buf[i]))
  38:	00001a17          	auipc	s4,0x1
  3c:	bb0a0a13          	add	s4,s4,-1104 # be8 <malloc+0x106>
        inword = 0;
  40:	4b81                	li	s7,0
  while((n = read(fd, buf, sizeof(buf))) > 0){
  42:	a805                	j	72 <wc+0x72>
      if(strchr(" \r\t\n\v", buf[i]))
  44:	8552                	mv	a0,s4
  46:	00000097          	auipc	ra,0x0
  4a:	20c080e7          	jalr	524(ra) # 252 <strchr>
  4e:	c919                	beqz	a0,64 <wc+0x64>
        inword = 0;
  50:	895e                	mv	s2,s7
    for(i=0; i<n; i++){
  52:	0485                	add	s1,s1,1
  54:	01348d63          	beq	s1,s3,6e <wc+0x6e>
      if(buf[i] == '\n')
  58:	0004c583          	lbu	a1,0(s1)
  5c:	ff5594e3          	bne	a1,s5,44 <wc+0x44>
        l++;
  60:	2c05                	addw	s8,s8,1
  62:	b7cd                	j	44 <wc+0x44>
      else if(!inword){
  64:	fe0917e3          	bnez	s2,52 <wc+0x52>
        w++;
  68:	2c85                	addw	s9,s9,1
        inword = 1;
  6a:	4905                	li	s2,1
  6c:	b7dd                	j	52 <wc+0x52>
  6e:	01ab0d3b          	addw	s10,s6,s10
  while((n = read(fd, buf, sizeof(buf))) > 0){
  72:	20000613          	li	a2,512
  76:	85ee                	mv	a1,s11
  78:	f8843503          	ld	a0,-120(s0)
  7c:	00000097          	auipc	ra,0x0
  80:	3c6080e7          	jalr	966(ra) # 442 <read>
  84:	8b2a                	mv	s6,a0
  86:	00a05963          	blez	a0,98 <wc+0x98>
    for(i=0; i<n; i++){
  8a:	00001497          	auipc	s1,0x1
  8e:	c2648493          	add	s1,s1,-986 # cb0 <buf>
  92:	009509b3          	add	s3,a0,s1
  96:	b7c9                	j	58 <wc+0x58>
      }
    }
  }
  if(n < 0){
  98:	02054e63          	bltz	a0,d4 <wc+0xd4>
    printf("wc: read error\n");
    exit(1);
  }
  printf("%d %d %d %s\n", l, w, c, name);
  9c:	f8043703          	ld	a4,-128(s0)
  a0:	86ea                	mv	a3,s10
  a2:	8666                	mv	a2,s9
  a4:	85e2                	mv	a1,s8
  a6:	00001517          	auipc	a0,0x1
  aa:	b6250513          	add	a0,a0,-1182 # c08 <malloc+0x126>
  ae:	00000097          	auipc	ra,0x0
  b2:	7b4080e7          	jalr	1972(ra) # 862 <printf>
}
  b6:	70e6                	ld	ra,120(sp)
  b8:	7446                	ld	s0,112(sp)
  ba:	74a6                	ld	s1,104(sp)
  bc:	7906                	ld	s2,96(sp)
  be:	69e6                	ld	s3,88(sp)
  c0:	6a46                	ld	s4,80(sp)
  c2:	6aa6                	ld	s5,72(sp)
  c4:	6b06                	ld	s6,64(sp)
  c6:	7be2                	ld	s7,56(sp)
  c8:	7c42                	ld	s8,48(sp)
  ca:	7ca2                	ld	s9,40(sp)
  cc:	7d02                	ld	s10,32(sp)
  ce:	6de2                	ld	s11,24(sp)
  d0:	6109                	add	sp,sp,128
  d2:	8082                	ret
    printf("wc: read error\n");
  d4:	00001517          	auipc	a0,0x1
  d8:	b2450513          	add	a0,a0,-1244 # bf8 <malloc+0x116>
  dc:	00000097          	auipc	ra,0x0
  e0:	786080e7          	jalr	1926(ra) # 862 <printf>
    exit(1);
  e4:	4505                	li	a0,1
  e6:	00000097          	auipc	ra,0x0
  ea:	344080e7          	jalr	836(ra) # 42a <exit>

00000000000000ee <main>:

int
main(int argc, char *argv[])
{
  ee:	7179                	add	sp,sp,-48
  f0:	f406                	sd	ra,40(sp)
  f2:	f022                	sd	s0,32(sp)
  f4:	1800                	add	s0,sp,48
  int fd, i;

  if(argc <= 1){
  f6:	4785                	li	a5,1
  f8:	04a7dc63          	bge	a5,a0,150 <main+0x62>
  fc:	ec26                	sd	s1,24(sp)
  fe:	e84a                	sd	s2,16(sp)
 100:	e44e                	sd	s3,8(sp)
 102:	00858913          	add	s2,a1,8
 106:	ffe5099b          	addw	s3,a0,-2
 10a:	02099793          	sll	a5,s3,0x20
 10e:	01d7d993          	srl	s3,a5,0x1d
 112:	05c1                	add	a1,a1,16
 114:	99ae                	add	s3,s3,a1
    wc(0, "");
    exit(0);
  }

  for(i = 1; i < argc; i++){
    if((fd = open(argv[i], 0)) < 0){
 116:	4581                	li	a1,0
 118:	00093503          	ld	a0,0(s2)
 11c:	00000097          	auipc	ra,0x0
 120:	34e080e7          	jalr	846(ra) # 46a <open>
 124:	84aa                	mv	s1,a0
 126:	04054663          	bltz	a0,172 <main+0x84>
      printf("wc: cannot open %s\n", argv[i]);
      exit(1);
    }
    wc(fd, argv[i]);
 12a:	00093583          	ld	a1,0(s2)
 12e:	00000097          	auipc	ra,0x0
 132:	ed2080e7          	jalr	-302(ra) # 0 <wc>
    close(fd);
 136:	8526                	mv	a0,s1
 138:	00000097          	auipc	ra,0x0
 13c:	31a080e7          	jalr	794(ra) # 452 <close>
  for(i = 1; i < argc; i++){
 140:	0921                	add	s2,s2,8
 142:	fd391ae3          	bne	s2,s3,116 <main+0x28>
  }
  exit(0);
 146:	4501                	li	a0,0
 148:	00000097          	auipc	ra,0x0
 14c:	2e2080e7          	jalr	738(ra) # 42a <exit>
 150:	ec26                	sd	s1,24(sp)
 152:	e84a                	sd	s2,16(sp)
 154:	e44e                	sd	s3,8(sp)
    wc(0, "");
 156:	00001597          	auipc	a1,0x1
 15a:	a9a58593          	add	a1,a1,-1382 # bf0 <malloc+0x10e>
 15e:	4501                	li	a0,0
 160:	00000097          	auipc	ra,0x0
 164:	ea0080e7          	jalr	-352(ra) # 0 <wc>
    exit(0);
 168:	4501                	li	a0,0
 16a:	00000097          	auipc	ra,0x0
 16e:	2c0080e7          	jalr	704(ra) # 42a <exit>
      printf("wc: cannot open %s\n", argv[i]);
 172:	00093583          	ld	a1,0(s2)
 176:	00001517          	auipc	a0,0x1
 17a:	aa250513          	add	a0,a0,-1374 # c18 <malloc+0x136>
 17e:	00000097          	auipc	ra,0x0
 182:	6e4080e7          	jalr	1764(ra) # 862 <printf>
      exit(1);
 186:	4505                	li	a0,1
 188:	00000097          	auipc	ra,0x0
 18c:	2a2080e7          	jalr	674(ra) # 42a <exit>

0000000000000190 <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
 190:	1141                	add	sp,sp,-16
 192:	e422                	sd	s0,8(sp)
 194:	0800                	add	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 196:	87aa                	mv	a5,a0
 198:	0585                	add	a1,a1,1
 19a:	0785                	add	a5,a5,1
 19c:	fff5c703          	lbu	a4,-1(a1)
 1a0:	fee78fa3          	sb	a4,-1(a5)
 1a4:	fb75                	bnez	a4,198 <strcpy+0x8>
    ;
  return os;
}
 1a6:	6422                	ld	s0,8(sp)
 1a8:	0141                	add	sp,sp,16
 1aa:	8082                	ret

00000000000001ac <strcmp>:

int
strcmp(const char *p, const char *q)
{
 1ac:	1141                	add	sp,sp,-16
 1ae:	e422                	sd	s0,8(sp)
 1b0:	0800                	add	s0,sp,16
  while(*p && *p == *q)
 1b2:	00054783          	lbu	a5,0(a0)
 1b6:	cb91                	beqz	a5,1ca <strcmp+0x1e>
 1b8:	0005c703          	lbu	a4,0(a1)
 1bc:	00f71763          	bne	a4,a5,1ca <strcmp+0x1e>
    p++, q++;
 1c0:	0505                	add	a0,a0,1
 1c2:	0585                	add	a1,a1,1
  while(*p && *p == *q)
 1c4:	00054783          	lbu	a5,0(a0)
 1c8:	fbe5                	bnez	a5,1b8 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 1ca:	0005c503          	lbu	a0,0(a1)
}
 1ce:	40a7853b          	subw	a0,a5,a0
 1d2:	6422                	ld	s0,8(sp)
 1d4:	0141                	add	sp,sp,16
 1d6:	8082                	ret

00000000000001d8 <strlen>:

uint
strlen(const char *s)
{
 1d8:	1141                	add	sp,sp,-16
 1da:	e422                	sd	s0,8(sp)
 1dc:	0800                	add	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 1de:	00054783          	lbu	a5,0(a0)
 1e2:	cf91                	beqz	a5,1fe <strlen+0x26>
 1e4:	0505                	add	a0,a0,1
 1e6:	87aa                	mv	a5,a0
 1e8:	86be                	mv	a3,a5
 1ea:	0785                	add	a5,a5,1
 1ec:	fff7c703          	lbu	a4,-1(a5)
 1f0:	ff65                	bnez	a4,1e8 <strlen+0x10>
 1f2:	40a6853b          	subw	a0,a3,a0
 1f6:	2505                	addw	a0,a0,1
    ;
  return n;
}
 1f8:	6422                	ld	s0,8(sp)
 1fa:	0141                	add	sp,sp,16
 1fc:	8082                	ret
  for(n = 0; s[n]; n++)
 1fe:	4501                	li	a0,0
 200:	bfe5                	j	1f8 <strlen+0x20>

0000000000000202 <strcat>:

char *
strcat(char *dst, char *src)
{
 202:	1141                	add	sp,sp,-16
 204:	e422                	sd	s0,8(sp)
 206:	0800                	add	s0,sp,16
  char *s = dst;
  while (*dst)
 208:	00054783          	lbu	a5,0(a0)
 20c:	c385                	beqz	a5,22c <strcat+0x2a>
 20e:	87aa                	mv	a5,a0
    dst++;
 210:	0785                	add	a5,a5,1
  while (*dst)
 212:	0007c703          	lbu	a4,0(a5)
 216:	ff6d                	bnez	a4,210 <strcat+0xe>
  while ((*dst++ = *src++) != 0);
 218:	0585                	add	a1,a1,1
 21a:	0785                	add	a5,a5,1
 21c:	fff5c703          	lbu	a4,-1(a1)
 220:	fee78fa3          	sb	a4,-1(a5)
 224:	fb75                	bnez	a4,218 <strcat+0x16>

  return s;
}
 226:	6422                	ld	s0,8(sp)
 228:	0141                	add	sp,sp,16
 22a:	8082                	ret
  while (*dst)
 22c:	87aa                	mv	a5,a0
 22e:	b7ed                	j	218 <strcat+0x16>

0000000000000230 <memset>:

void*
memset(void *dst, int c, uint n)
{
 230:	1141                	add	sp,sp,-16
 232:	e422                	sd	s0,8(sp)
 234:	0800                	add	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 236:	ca19                	beqz	a2,24c <memset+0x1c>
 238:	87aa                	mv	a5,a0
 23a:	1602                	sll	a2,a2,0x20
 23c:	9201                	srl	a2,a2,0x20
 23e:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 242:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 246:	0785                	add	a5,a5,1
 248:	fee79de3          	bne	a5,a4,242 <memset+0x12>
  }
  return dst;
}
 24c:	6422                	ld	s0,8(sp)
 24e:	0141                	add	sp,sp,16
 250:	8082                	ret

0000000000000252 <strchr>:

char*
strchr(const char *s, char c)
{
 252:	1141                	add	sp,sp,-16
 254:	e422                	sd	s0,8(sp)
 256:	0800                	add	s0,sp,16
  for(; *s; s++)
 258:	00054783          	lbu	a5,0(a0)
 25c:	cb99                	beqz	a5,272 <strchr+0x20>
    if(*s == c)
 25e:	00f58763          	beq	a1,a5,26c <strchr+0x1a>
  for(; *s; s++)
 262:	0505                	add	a0,a0,1
 264:	00054783          	lbu	a5,0(a0)
 268:	fbfd                	bnez	a5,25e <strchr+0xc>
      return (char*)s;
  return 0;
 26a:	4501                	li	a0,0
}
 26c:	6422                	ld	s0,8(sp)
 26e:	0141                	add	sp,sp,16
 270:	8082                	ret
  return 0;
 272:	4501                	li	a0,0
 274:	bfe5                	j	26c <strchr+0x1a>

0000000000000276 <gets>:

char*
gets(char *buf, int max)
{
 276:	711d                	add	sp,sp,-96
 278:	ec86                	sd	ra,88(sp)
 27a:	e8a2                	sd	s0,80(sp)
 27c:	e4a6                	sd	s1,72(sp)
 27e:	e0ca                	sd	s2,64(sp)
 280:	fc4e                	sd	s3,56(sp)
 282:	f852                	sd	s4,48(sp)
 284:	f456                	sd	s5,40(sp)
 286:	f05a                	sd	s6,32(sp)
 288:	ec5e                	sd	s7,24(sp)
 28a:	1080                	add	s0,sp,96
 28c:	8baa                	mv	s7,a0
 28e:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 290:	892a                	mv	s2,a0
 292:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 294:	4aa9                	li	s5,10
 296:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 298:	89a6                	mv	s3,s1
 29a:	2485                	addw	s1,s1,1
 29c:	0344d863          	bge	s1,s4,2cc <gets+0x56>
    cc = read(0, &c, 1);
 2a0:	4605                	li	a2,1
 2a2:	faf40593          	add	a1,s0,-81
 2a6:	4501                	li	a0,0
 2a8:	00000097          	auipc	ra,0x0
 2ac:	19a080e7          	jalr	410(ra) # 442 <read>
    if(cc < 1)
 2b0:	00a05e63          	blez	a0,2cc <gets+0x56>
    buf[i++] = c;
 2b4:	faf44783          	lbu	a5,-81(s0)
 2b8:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 2bc:	01578763          	beq	a5,s5,2ca <gets+0x54>
 2c0:	0905                	add	s2,s2,1
 2c2:	fd679be3          	bne	a5,s6,298 <gets+0x22>
    buf[i++] = c;
 2c6:	89a6                	mv	s3,s1
 2c8:	a011                	j	2cc <gets+0x56>
 2ca:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 2cc:	99de                	add	s3,s3,s7
 2ce:	00098023          	sb	zero,0(s3)
  return buf;
}
 2d2:	855e                	mv	a0,s7
 2d4:	60e6                	ld	ra,88(sp)
 2d6:	6446                	ld	s0,80(sp)
 2d8:	64a6                	ld	s1,72(sp)
 2da:	6906                	ld	s2,64(sp)
 2dc:	79e2                	ld	s3,56(sp)
 2de:	7a42                	ld	s4,48(sp)
 2e0:	7aa2                	ld	s5,40(sp)
 2e2:	7b02                	ld	s6,32(sp)
 2e4:	6be2                	ld	s7,24(sp)
 2e6:	6125                	add	sp,sp,96
 2e8:	8082                	ret

00000000000002ea <stat>:

int
stat(const char *n, struct stat *st)
{
 2ea:	1101                	add	sp,sp,-32
 2ec:	ec06                	sd	ra,24(sp)
 2ee:	e822                	sd	s0,16(sp)
 2f0:	e04a                	sd	s2,0(sp)
 2f2:	1000                	add	s0,sp,32
 2f4:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 2f6:	4581                	li	a1,0
 2f8:	00000097          	auipc	ra,0x0
 2fc:	172080e7          	jalr	370(ra) # 46a <open>
  if(fd < 0)
 300:	02054663          	bltz	a0,32c <stat+0x42>
 304:	e426                	sd	s1,8(sp)
 306:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 308:	85ca                	mv	a1,s2
 30a:	00000097          	auipc	ra,0x0
 30e:	178080e7          	jalr	376(ra) # 482 <fstat>
 312:	892a                	mv	s2,a0
  close(fd);
 314:	8526                	mv	a0,s1
 316:	00000097          	auipc	ra,0x0
 31a:	13c080e7          	jalr	316(ra) # 452 <close>
  return r;
 31e:	64a2                	ld	s1,8(sp)
}
 320:	854a                	mv	a0,s2
 322:	60e2                	ld	ra,24(sp)
 324:	6442                	ld	s0,16(sp)
 326:	6902                	ld	s2,0(sp)
 328:	6105                	add	sp,sp,32
 32a:	8082                	ret
    return -1;
 32c:	597d                	li	s2,-1
 32e:	bfcd                	j	320 <stat+0x36>

0000000000000330 <atoi>:

int
atoi(const char *s)
{
 330:	1141                	add	sp,sp,-16
 332:	e422                	sd	s0,8(sp)
 334:	0800                	add	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 336:	00054683          	lbu	a3,0(a0)
 33a:	fd06879b          	addw	a5,a3,-48
 33e:	0ff7f793          	zext.b	a5,a5
 342:	4625                	li	a2,9
 344:	02f66863          	bltu	a2,a5,374 <atoi+0x44>
 348:	872a                	mv	a4,a0
  n = 0;
 34a:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 34c:	0705                	add	a4,a4,1
 34e:	0025179b          	sllw	a5,a0,0x2
 352:	9fa9                	addw	a5,a5,a0
 354:	0017979b          	sllw	a5,a5,0x1
 358:	9fb5                	addw	a5,a5,a3
 35a:	fd07851b          	addw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 35e:	00074683          	lbu	a3,0(a4)
 362:	fd06879b          	addw	a5,a3,-48
 366:	0ff7f793          	zext.b	a5,a5
 36a:	fef671e3          	bgeu	a2,a5,34c <atoi+0x1c>
  return n;
}
 36e:	6422                	ld	s0,8(sp)
 370:	0141                	add	sp,sp,16
 372:	8082                	ret
  n = 0;
 374:	4501                	li	a0,0
 376:	bfe5                	j	36e <atoi+0x3e>

0000000000000378 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 378:	1141                	add	sp,sp,-16
 37a:	e422                	sd	s0,8(sp)
 37c:	0800                	add	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 37e:	02b57463          	bgeu	a0,a1,3a6 <memmove+0x2e>
    while(n-- > 0)
 382:	00c05f63          	blez	a2,3a0 <memmove+0x28>
 386:	1602                	sll	a2,a2,0x20
 388:	9201                	srl	a2,a2,0x20
 38a:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 38e:	872a                	mv	a4,a0
      *dst++ = *src++;
 390:	0585                	add	a1,a1,1
 392:	0705                	add	a4,a4,1
 394:	fff5c683          	lbu	a3,-1(a1)
 398:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 39c:	fef71ae3          	bne	a4,a5,390 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 3a0:	6422                	ld	s0,8(sp)
 3a2:	0141                	add	sp,sp,16
 3a4:	8082                	ret
    dst += n;
 3a6:	00c50733          	add	a4,a0,a2
    src += n;
 3aa:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 3ac:	fec05ae3          	blez	a2,3a0 <memmove+0x28>
 3b0:	fff6079b          	addw	a5,a2,-1
 3b4:	1782                	sll	a5,a5,0x20
 3b6:	9381                	srl	a5,a5,0x20
 3b8:	fff7c793          	not	a5,a5
 3bc:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 3be:	15fd                	add	a1,a1,-1
 3c0:	177d                	add	a4,a4,-1
 3c2:	0005c683          	lbu	a3,0(a1)
 3c6:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 3ca:	fee79ae3          	bne	a5,a4,3be <memmove+0x46>
 3ce:	bfc9                	j	3a0 <memmove+0x28>

00000000000003d0 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 3d0:	1141                	add	sp,sp,-16
 3d2:	e422                	sd	s0,8(sp)
 3d4:	0800                	add	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 3d6:	ca05                	beqz	a2,406 <memcmp+0x36>
 3d8:	fff6069b          	addw	a3,a2,-1
 3dc:	1682                	sll	a3,a3,0x20
 3de:	9281                	srl	a3,a3,0x20
 3e0:	0685                	add	a3,a3,1
 3e2:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 3e4:	00054783          	lbu	a5,0(a0)
 3e8:	0005c703          	lbu	a4,0(a1)
 3ec:	00e79863          	bne	a5,a4,3fc <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 3f0:	0505                	add	a0,a0,1
    p2++;
 3f2:	0585                	add	a1,a1,1
  while (n-- > 0) {
 3f4:	fed518e3          	bne	a0,a3,3e4 <memcmp+0x14>
  }
  return 0;
 3f8:	4501                	li	a0,0
 3fa:	a019                	j	400 <memcmp+0x30>
      return *p1 - *p2;
 3fc:	40e7853b          	subw	a0,a5,a4
}
 400:	6422                	ld	s0,8(sp)
 402:	0141                	add	sp,sp,16
 404:	8082                	ret
  return 0;
 406:	4501                	li	a0,0
 408:	bfe5                	j	400 <memcmp+0x30>

000000000000040a <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 40a:	1141                	add	sp,sp,-16
 40c:	e406                	sd	ra,8(sp)
 40e:	e022                	sd	s0,0(sp)
 410:	0800                	add	s0,sp,16
  return memmove(dst, src, n);
 412:	00000097          	auipc	ra,0x0
 416:	f66080e7          	jalr	-154(ra) # 378 <memmove>
}
 41a:	60a2                	ld	ra,8(sp)
 41c:	6402                	ld	s0,0(sp)
 41e:	0141                	add	sp,sp,16
 420:	8082                	ret

0000000000000422 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 422:	4885                	li	a7,1
 ecall
 424:	00000073          	ecall
 ret
 428:	8082                	ret

000000000000042a <exit>:
.global exit
exit:
 li a7, SYS_exit
 42a:	4889                	li	a7,2
 ecall
 42c:	00000073          	ecall
 ret
 430:	8082                	ret

0000000000000432 <wait>:
.global wait
wait:
 li a7, SYS_wait
 432:	488d                	li	a7,3
 ecall
 434:	00000073          	ecall
 ret
 438:	8082                	ret

000000000000043a <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 43a:	4891                	li	a7,4
 ecall
 43c:	00000073          	ecall
 ret
 440:	8082                	ret

0000000000000442 <read>:
.global read
read:
 li a7, SYS_read
 442:	4895                	li	a7,5
 ecall
 444:	00000073          	ecall
 ret
 448:	8082                	ret

000000000000044a <write>:
.global write
write:
 li a7, SYS_write
 44a:	48c1                	li	a7,16
 ecall
 44c:	00000073          	ecall
 ret
 450:	8082                	ret

0000000000000452 <close>:
.global close
close:
 li a7, SYS_close
 452:	48d5                	li	a7,21
 ecall
 454:	00000073          	ecall
 ret
 458:	8082                	ret

000000000000045a <kill>:
.global kill
kill:
 li a7, SYS_kill
 45a:	4899                	li	a7,6
 ecall
 45c:	00000073          	ecall
 ret
 460:	8082                	ret

0000000000000462 <exec>:
.global exec
exec:
 li a7, SYS_exec
 462:	489d                	li	a7,7
 ecall
 464:	00000073          	ecall
 ret
 468:	8082                	ret

000000000000046a <open>:
.global open
open:
 li a7, SYS_open
 46a:	48bd                	li	a7,15
 ecall
 46c:	00000073          	ecall
 ret
 470:	8082                	ret

0000000000000472 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 472:	48c5                	li	a7,17
 ecall
 474:	00000073          	ecall
 ret
 478:	8082                	ret

000000000000047a <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 47a:	48c9                	li	a7,18
 ecall
 47c:	00000073          	ecall
 ret
 480:	8082                	ret

0000000000000482 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 482:	48a1                	li	a7,8
 ecall
 484:	00000073          	ecall
 ret
 488:	8082                	ret

000000000000048a <link>:
.global link
link:
 li a7, SYS_link
 48a:	48cd                	li	a7,19
 ecall
 48c:	00000073          	ecall
 ret
 490:	8082                	ret

0000000000000492 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 492:	48d1                	li	a7,20
 ecall
 494:	00000073          	ecall
 ret
 498:	8082                	ret

000000000000049a <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 49a:	48a5                	li	a7,9
 ecall
 49c:	00000073          	ecall
 ret
 4a0:	8082                	ret

00000000000004a2 <dup>:
.global dup
dup:
 li a7, SYS_dup
 4a2:	48a9                	li	a7,10
 ecall
 4a4:	00000073          	ecall
 ret
 4a8:	8082                	ret

00000000000004aa <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 4aa:	48ad                	li	a7,11
 ecall
 4ac:	00000073          	ecall
 ret
 4b0:	8082                	ret

00000000000004b2 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 4b2:	48b1                	li	a7,12
 ecall
 4b4:	00000073          	ecall
 ret
 4b8:	8082                	ret

00000000000004ba <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 4ba:	48b5                	li	a7,13
 ecall
 4bc:	00000073          	ecall
 ret
 4c0:	8082                	ret

00000000000004c2 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 4c2:	48b9                	li	a7,14
 ecall
 4c4:	00000073          	ecall
 ret
 4c8:	8082                	ret

00000000000004ca <uconnect>:
.global uconnect
uconnect:
 li a7, SYS_uconnect
 4ca:	48f5                	li	a7,29
 ecall
 4cc:	00000073          	ecall
 ret
 4d0:	8082                	ret

00000000000004d2 <socket>:
.global socket
socket:
 li a7, SYS_socket
 4d2:	48f9                	li	a7,30
 ecall
 4d4:	00000073          	ecall
 ret
 4d8:	8082                	ret

00000000000004da <bind>:
.global bind
bind:
 li a7, SYS_bind
 4da:	48fd                	li	a7,31
 ecall
 4dc:	00000073          	ecall
 ret
 4e0:	8082                	ret

00000000000004e2 <listen>:
.global listen
listen:
 li a7, SYS_listen
 4e2:	02000893          	li	a7,32
 ecall
 4e6:	00000073          	ecall
 ret
 4ea:	8082                	ret

00000000000004ec <accept>:
.global accept
accept:
 li a7, SYS_accept
 4ec:	02100893          	li	a7,33
 ecall
 4f0:	00000073          	ecall
 ret
 4f4:	8082                	ret

00000000000004f6 <connect>:
.global connect
connect:
 li a7, SYS_connect
 4f6:	02200893          	li	a7,34
 ecall
 4fa:	00000073          	ecall
 ret
 4fe:	8082                	ret

0000000000000500 <sprintint>:
  return 1;
}

static int
sprintint(char *s, int xx, int base, int sign)
{
 500:	1101                	add	sp,sp,-32
 502:	ec22                	sd	s0,24(sp)
 504:	1000                	add	s0,sp,32
 506:	882a                	mv	a6,a0
  char buf[16];
  int i, n;
  uint x;

  if(sign && (sign = xx < 0))
 508:	c299                	beqz	a3,50e <sprintint+0xe>
 50a:	0805c263          	bltz	a1,58e <sprintint+0x8e>
    x = -xx;
  else
    x = xx;
 50e:	2581                	sext.w	a1,a1
 510:	4301                	li	t1,0

  i = 0;
 512:	fe040713          	add	a4,s0,-32
 516:	4501                	li	a0,0
  do {
    buf[i++] = digits[x % base];
 518:	2601                	sext.w	a2,a2
 51a:	00000697          	auipc	a3,0x0
 51e:	77668693          	add	a3,a3,1910 # c90 <digits>
 522:	88aa                	mv	a7,a0
 524:	2505                	addw	a0,a0,1
 526:	02c5f7bb          	remuw	a5,a1,a2
 52a:	1782                	sll	a5,a5,0x20
 52c:	9381                	srl	a5,a5,0x20
 52e:	97b6                	add	a5,a5,a3
 530:	0007c783          	lbu	a5,0(a5)
 534:	00f70023          	sb	a5,0(a4)
  } while((x /= base) != 0);
 538:	0005879b          	sext.w	a5,a1
 53c:	02c5d5bb          	divuw	a1,a1,a2
 540:	0705                	add	a4,a4,1
 542:	fec7f0e3          	bgeu	a5,a2,522 <sprintint+0x22>

  if(sign)
 546:	00030b63          	beqz	t1,55c <sprintint+0x5c>
    buf[i++] = '-';
 54a:	ff050793          	add	a5,a0,-16
 54e:	97a2                	add	a5,a5,s0
 550:	02d00713          	li	a4,45
 554:	fee78823          	sb	a4,-16(a5)
 558:	0028851b          	addw	a0,a7,2

  n = 0;
  while(--i >= 0)
 55c:	02a05d63          	blez	a0,596 <sprintint+0x96>
 560:	fe040793          	add	a5,s0,-32
 564:	00a78733          	add	a4,a5,a0
 568:	87c2                	mv	a5,a6
 56a:	00180613          	add	a2,a6,1
 56e:	fff5069b          	addw	a3,a0,-1
 572:	1682                	sll	a3,a3,0x20
 574:	9281                	srl	a3,a3,0x20
 576:	9636                	add	a2,a2,a3
  *s = c;
 578:	fff74683          	lbu	a3,-1(a4)
 57c:	00d78023          	sb	a3,0(a5)
  while(--i >= 0)
 580:	177d                	add	a4,a4,-1
 582:	0785                	add	a5,a5,1
 584:	fec79ae3          	bne	a5,a2,578 <sprintint+0x78>
    n += sputc(s+n, buf[i]);
  return n;
}
 588:	6462                	ld	s0,24(sp)
 58a:	6105                	add	sp,sp,32
 58c:	8082                	ret
    x = -xx;
 58e:	40b005bb          	negw	a1,a1
  if(sign && (sign = xx < 0))
 592:	4305                	li	t1,1
    x = -xx;
 594:	bfbd                	j	512 <sprintint+0x12>
  while(--i >= 0)
 596:	4501                	li	a0,0
 598:	bfc5                	j	588 <sprintint+0x88>

000000000000059a <putc>:
{
 59a:	1101                	add	sp,sp,-32
 59c:	ec06                	sd	ra,24(sp)
 59e:	e822                	sd	s0,16(sp)
 5a0:	1000                	add	s0,sp,32
 5a2:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 5a6:	4605                	li	a2,1
 5a8:	fef40593          	add	a1,s0,-17
 5ac:	00000097          	auipc	ra,0x0
 5b0:	e9e080e7          	jalr	-354(ra) # 44a <write>
}
 5b4:	60e2                	ld	ra,24(sp)
 5b6:	6442                	ld	s0,16(sp)
 5b8:	6105                	add	sp,sp,32
 5ba:	8082                	ret

00000000000005bc <printint>:
{
 5bc:	7139                	add	sp,sp,-64
 5be:	fc06                	sd	ra,56(sp)
 5c0:	f822                	sd	s0,48(sp)
 5c2:	f426                	sd	s1,40(sp)
 5c4:	0080                	add	s0,sp,64
 5c6:	84aa                	mv	s1,a0
  if(sgn && xx < 0){
 5c8:	c299                	beqz	a3,5ce <printint+0x12>
 5ca:	0805cb63          	bltz	a1,660 <printint+0xa4>
    x = xx;
 5ce:	2581                	sext.w	a1,a1
  neg = 0;
 5d0:	4881                	li	a7,0
 5d2:	fc040693          	add	a3,s0,-64
  i = 0;
 5d6:	4701                	li	a4,0
    buf[i++] = digits[x % base];
 5d8:	2601                	sext.w	a2,a2
 5da:	00000517          	auipc	a0,0x0
 5de:	6b650513          	add	a0,a0,1718 # c90 <digits>
 5e2:	883a                	mv	a6,a4
 5e4:	2705                	addw	a4,a4,1
 5e6:	02c5f7bb          	remuw	a5,a1,a2
 5ea:	1782                	sll	a5,a5,0x20
 5ec:	9381                	srl	a5,a5,0x20
 5ee:	97aa                	add	a5,a5,a0
 5f0:	0007c783          	lbu	a5,0(a5)
 5f4:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 5f8:	0005879b          	sext.w	a5,a1
 5fc:	02c5d5bb          	divuw	a1,a1,a2
 600:	0685                	add	a3,a3,1
 602:	fec7f0e3          	bgeu	a5,a2,5e2 <printint+0x26>
  if(neg)
 606:	00088c63          	beqz	a7,61e <printint+0x62>
    buf[i++] = '-';
 60a:	fd070793          	add	a5,a4,-48
 60e:	00878733          	add	a4,a5,s0
 612:	02d00793          	li	a5,45
 616:	fef70823          	sb	a5,-16(a4)
 61a:	0028071b          	addw	a4,a6,2
  while(--i >= 0)
 61e:	02e05c63          	blez	a4,656 <printint+0x9a>
 622:	f04a                	sd	s2,32(sp)
 624:	ec4e                	sd	s3,24(sp)
 626:	fc040793          	add	a5,s0,-64
 62a:	00e78933          	add	s2,a5,a4
 62e:	fff78993          	add	s3,a5,-1
 632:	99ba                	add	s3,s3,a4
 634:	377d                	addw	a4,a4,-1
 636:	1702                	sll	a4,a4,0x20
 638:	9301                	srl	a4,a4,0x20
 63a:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 63e:	fff94583          	lbu	a1,-1(s2)
 642:	8526                	mv	a0,s1
 644:	00000097          	auipc	ra,0x0
 648:	f56080e7          	jalr	-170(ra) # 59a <putc>
  while(--i >= 0)
 64c:	197d                	add	s2,s2,-1
 64e:	ff3918e3          	bne	s2,s3,63e <printint+0x82>
 652:	7902                	ld	s2,32(sp)
 654:	69e2                	ld	s3,24(sp)
}
 656:	70e2                	ld	ra,56(sp)
 658:	7442                	ld	s0,48(sp)
 65a:	74a2                	ld	s1,40(sp)
 65c:	6121                	add	sp,sp,64
 65e:	8082                	ret
    x = -xx;
 660:	40b005bb          	negw	a1,a1
    neg = 1;
 664:	4885                	li	a7,1
    x = -xx;
 666:	b7b5                	j	5d2 <printint+0x16>

0000000000000668 <vprintf>:
{
 668:	715d                	add	sp,sp,-80
 66a:	e486                	sd	ra,72(sp)
 66c:	e0a2                	sd	s0,64(sp)
 66e:	f84a                	sd	s2,48(sp)
 670:	0880                	add	s0,sp,80
  for(i = 0; fmt[i]; i++){
 672:	0005c903          	lbu	s2,0(a1)
 676:	1a090a63          	beqz	s2,82a <vprintf+0x1c2>
 67a:	fc26                	sd	s1,56(sp)
 67c:	f44e                	sd	s3,40(sp)
 67e:	f052                	sd	s4,32(sp)
 680:	ec56                	sd	s5,24(sp)
 682:	e85a                	sd	s6,16(sp)
 684:	e45e                	sd	s7,8(sp)
 686:	8aaa                	mv	s5,a0
 688:	8bb2                	mv	s7,a2
 68a:	00158493          	add	s1,a1,1
  state = 0;
 68e:	4981                	li	s3,0
    } else if(state == '%'){
 690:	02500a13          	li	s4,37
 694:	4b55                	li	s6,21
 696:	a839                	j	6b4 <vprintf+0x4c>
        putc(fd, c);
 698:	85ca                	mv	a1,s2
 69a:	8556                	mv	a0,s5
 69c:	00000097          	auipc	ra,0x0
 6a0:	efe080e7          	jalr	-258(ra) # 59a <putc>
 6a4:	a019                	j	6aa <vprintf+0x42>
    } else if(state == '%'){
 6a6:	01498d63          	beq	s3,s4,6c0 <vprintf+0x58>
  for(i = 0; fmt[i]; i++){
 6aa:	0485                	add	s1,s1,1
 6ac:	fff4c903          	lbu	s2,-1(s1)
 6b0:	16090763          	beqz	s2,81e <vprintf+0x1b6>
    if(state == 0){
 6b4:	fe0999e3          	bnez	s3,6a6 <vprintf+0x3e>
      if(c == '%'){
 6b8:	ff4910e3          	bne	s2,s4,698 <vprintf+0x30>
        state = '%';
 6bc:	89d2                	mv	s3,s4
 6be:	b7f5                	j	6aa <vprintf+0x42>
      if(c == 'd'){
 6c0:	13490463          	beq	s2,s4,7e8 <vprintf+0x180>
 6c4:	f9d9079b          	addw	a5,s2,-99
 6c8:	0ff7f793          	zext.b	a5,a5
 6cc:	12fb6763          	bltu	s6,a5,7fa <vprintf+0x192>
 6d0:	f9d9079b          	addw	a5,s2,-99
 6d4:	0ff7f713          	zext.b	a4,a5
 6d8:	12eb6163          	bltu	s6,a4,7fa <vprintf+0x192>
 6dc:	00271793          	sll	a5,a4,0x2
 6e0:	00000717          	auipc	a4,0x0
 6e4:	55870713          	add	a4,a4,1368 # c38 <malloc+0x156>
 6e8:	97ba                	add	a5,a5,a4
 6ea:	439c                	lw	a5,0(a5)
 6ec:	97ba                	add	a5,a5,a4
 6ee:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 6f0:	008b8913          	add	s2,s7,8
 6f4:	4685                	li	a3,1
 6f6:	4629                	li	a2,10
 6f8:	000ba583          	lw	a1,0(s7)
 6fc:	8556                	mv	a0,s5
 6fe:	00000097          	auipc	ra,0x0
 702:	ebe080e7          	jalr	-322(ra) # 5bc <printint>
 706:	8bca                	mv	s7,s2
      state = 0;
 708:	4981                	li	s3,0
 70a:	b745                	j	6aa <vprintf+0x42>
        printint(fd, va_arg(ap, uint64), 10, 0);
 70c:	008b8913          	add	s2,s7,8
 710:	4681                	li	a3,0
 712:	4629                	li	a2,10
 714:	000ba583          	lw	a1,0(s7)
 718:	8556                	mv	a0,s5
 71a:	00000097          	auipc	ra,0x0
 71e:	ea2080e7          	jalr	-350(ra) # 5bc <printint>
 722:	8bca                	mv	s7,s2
      state = 0;
 724:	4981                	li	s3,0
 726:	b751                	j	6aa <vprintf+0x42>
        printint(fd, va_arg(ap, int), 16, 0);
 728:	008b8913          	add	s2,s7,8
 72c:	4681                	li	a3,0
 72e:	4641                	li	a2,16
 730:	000ba583          	lw	a1,0(s7)
 734:	8556                	mv	a0,s5
 736:	00000097          	auipc	ra,0x0
 73a:	e86080e7          	jalr	-378(ra) # 5bc <printint>
 73e:	8bca                	mv	s7,s2
      state = 0;
 740:	4981                	li	s3,0
 742:	b7a5                	j	6aa <vprintf+0x42>
 744:	e062                	sd	s8,0(sp)
        printptr(fd, va_arg(ap, uint64));
 746:	008b8c13          	add	s8,s7,8
 74a:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 74e:	03000593          	li	a1,48
 752:	8556                	mv	a0,s5
 754:	00000097          	auipc	ra,0x0
 758:	e46080e7          	jalr	-442(ra) # 59a <putc>
  putc(fd, 'x');
 75c:	07800593          	li	a1,120
 760:	8556                	mv	a0,s5
 762:	00000097          	auipc	ra,0x0
 766:	e38080e7          	jalr	-456(ra) # 59a <putc>
 76a:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 76c:	00000b97          	auipc	s7,0x0
 770:	524b8b93          	add	s7,s7,1316 # c90 <digits>
 774:	03c9d793          	srl	a5,s3,0x3c
 778:	97de                	add	a5,a5,s7
 77a:	0007c583          	lbu	a1,0(a5)
 77e:	8556                	mv	a0,s5
 780:	00000097          	auipc	ra,0x0
 784:	e1a080e7          	jalr	-486(ra) # 59a <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 788:	0992                	sll	s3,s3,0x4
 78a:	397d                	addw	s2,s2,-1
 78c:	fe0914e3          	bnez	s2,774 <vprintf+0x10c>
        printptr(fd, va_arg(ap, uint64));
 790:	8be2                	mv	s7,s8
      state = 0;
 792:	4981                	li	s3,0
 794:	6c02                	ld	s8,0(sp)
 796:	bf11                	j	6aa <vprintf+0x42>
        s = va_arg(ap, char*);
 798:	008b8993          	add	s3,s7,8
 79c:	000bb903          	ld	s2,0(s7)
        if(s == 0)
 7a0:	02090163          	beqz	s2,7c2 <vprintf+0x15a>
        while(*s != 0){
 7a4:	00094583          	lbu	a1,0(s2)
 7a8:	c9a5                	beqz	a1,818 <vprintf+0x1b0>
          putc(fd, *s);
 7aa:	8556                	mv	a0,s5
 7ac:	00000097          	auipc	ra,0x0
 7b0:	dee080e7          	jalr	-530(ra) # 59a <putc>
          s++;
 7b4:	0905                	add	s2,s2,1
        while(*s != 0){
 7b6:	00094583          	lbu	a1,0(s2)
 7ba:	f9e5                	bnez	a1,7aa <vprintf+0x142>
        s = va_arg(ap, char*);
 7bc:	8bce                	mv	s7,s3
      state = 0;
 7be:	4981                	li	s3,0
 7c0:	b5ed                	j	6aa <vprintf+0x42>
          s = "(null)";
 7c2:	00000917          	auipc	s2,0x0
 7c6:	46e90913          	add	s2,s2,1134 # c30 <malloc+0x14e>
        while(*s != 0){
 7ca:	02800593          	li	a1,40
 7ce:	bff1                	j	7aa <vprintf+0x142>
        putc(fd, va_arg(ap, uint));
 7d0:	008b8913          	add	s2,s7,8
 7d4:	000bc583          	lbu	a1,0(s7)
 7d8:	8556                	mv	a0,s5
 7da:	00000097          	auipc	ra,0x0
 7de:	dc0080e7          	jalr	-576(ra) # 59a <putc>
 7e2:	8bca                	mv	s7,s2
      state = 0;
 7e4:	4981                	li	s3,0
 7e6:	b5d1                	j	6aa <vprintf+0x42>
        putc(fd, c);
 7e8:	02500593          	li	a1,37
 7ec:	8556                	mv	a0,s5
 7ee:	00000097          	auipc	ra,0x0
 7f2:	dac080e7          	jalr	-596(ra) # 59a <putc>
      state = 0;
 7f6:	4981                	li	s3,0
 7f8:	bd4d                	j	6aa <vprintf+0x42>
        putc(fd, '%');
 7fa:	02500593          	li	a1,37
 7fe:	8556                	mv	a0,s5
 800:	00000097          	auipc	ra,0x0
 804:	d9a080e7          	jalr	-614(ra) # 59a <putc>
        putc(fd, c);
 808:	85ca                	mv	a1,s2
 80a:	8556                	mv	a0,s5
 80c:	00000097          	auipc	ra,0x0
 810:	d8e080e7          	jalr	-626(ra) # 59a <putc>
      state = 0;
 814:	4981                	li	s3,0
 816:	bd51                	j	6aa <vprintf+0x42>
        s = va_arg(ap, char*);
 818:	8bce                	mv	s7,s3
      state = 0;
 81a:	4981                	li	s3,0
 81c:	b579                	j	6aa <vprintf+0x42>
 81e:	74e2                	ld	s1,56(sp)
 820:	79a2                	ld	s3,40(sp)
 822:	7a02                	ld	s4,32(sp)
 824:	6ae2                	ld	s5,24(sp)
 826:	6b42                	ld	s6,16(sp)
 828:	6ba2                	ld	s7,8(sp)
}
 82a:	60a6                	ld	ra,72(sp)
 82c:	6406                	ld	s0,64(sp)
 82e:	7942                	ld	s2,48(sp)
 830:	6161                	add	sp,sp,80
 832:	8082                	ret

0000000000000834 <fprintf>:
{
 834:	715d                	add	sp,sp,-80
 836:	ec06                	sd	ra,24(sp)
 838:	e822                	sd	s0,16(sp)
 83a:	1000                	add	s0,sp,32
 83c:	e010                	sd	a2,0(s0)
 83e:	e414                	sd	a3,8(s0)
 840:	e818                	sd	a4,16(s0)
 842:	ec1c                	sd	a5,24(s0)
 844:	03043023          	sd	a6,32(s0)
 848:	03143423          	sd	a7,40(s0)
  va_start(ap, fmt);
 84c:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 850:	8622                	mv	a2,s0
 852:	00000097          	auipc	ra,0x0
 856:	e16080e7          	jalr	-490(ra) # 668 <vprintf>
}
 85a:	60e2                	ld	ra,24(sp)
 85c:	6442                	ld	s0,16(sp)
 85e:	6161                	add	sp,sp,80
 860:	8082                	ret

0000000000000862 <printf>:
{
 862:	711d                	add	sp,sp,-96
 864:	ec06                	sd	ra,24(sp)
 866:	e822                	sd	s0,16(sp)
 868:	1000                	add	s0,sp,32
 86a:	e40c                	sd	a1,8(s0)
 86c:	e810                	sd	a2,16(s0)
 86e:	ec14                	sd	a3,24(s0)
 870:	f018                	sd	a4,32(s0)
 872:	f41c                	sd	a5,40(s0)
 874:	03043823          	sd	a6,48(s0)
 878:	03143c23          	sd	a7,56(s0)
  va_start(ap, fmt);
 87c:	00840613          	add	a2,s0,8
 880:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 884:	85aa                	mv	a1,a0
 886:	4505                	li	a0,1
 888:	00000097          	auipc	ra,0x0
 88c:	de0080e7          	jalr	-544(ra) # 668 <vprintf>
}
 890:	60e2                	ld	ra,24(sp)
 892:	6442                	ld	s0,16(sp)
 894:	6125                	add	sp,sp,96
 896:	8082                	ret

0000000000000898 <snprintf>:

int
snprintf(char *buf, int sz, char *fmt, ...)
{
 898:	7135                	add	sp,sp,-160
 89a:	f486                	sd	ra,104(sp)
 89c:	f0a2                	sd	s0,96(sp)
 89e:	eca6                	sd	s1,88(sp)
 8a0:	1880                	add	s0,sp,112
 8a2:	e414                	sd	a3,8(s0)
 8a4:	e818                	sd	a4,16(s0)
 8a6:	ec1c                	sd	a5,24(s0)
 8a8:	03043023          	sd	a6,32(s0)
 8ac:	03143423          	sd	a7,40(s0)
  va_list ap;
  int i, c;
  int off = 0;
  char *s;

  if (fmt == 0)
 8b0:	16060b63          	beqz	a2,a26 <snprintf+0x18e>
 8b4:	e8ca                	sd	s2,80(sp)
 8b6:	e4ce                	sd	s3,72(sp)
 8b8:	fc56                	sd	s5,56(sp)
 8ba:	f85a                	sd	s6,48(sp)
 8bc:	8b2a                	mv	s6,a0
 8be:	8aae                	mv	s5,a1
 8c0:	89b2                	mv	s3,a2
    return -1;

  va_start(ap, fmt);
 8c2:	00840793          	add	a5,s0,8
 8c6:	f8f43c23          	sd	a5,-104(s0)
  int off = 0;
 8ca:	4481                	li	s1,0
  for(i = 0; off < sz && (c = fmt[i] & 0xff) != 0; i++){
 8cc:	4901                	li	s2,0
 8ce:	00b05f63          	blez	a1,8ec <snprintf+0x54>
 8d2:	e0d2                	sd	s4,64(sp)
 8d4:	f45e                	sd	s7,40(sp)
 8d6:	f062                	sd	s8,32(sp)
 8d8:	ec66                	sd	s9,24(sp)
    if(c != '%'){
 8da:	02500a13          	li	s4,37
      continue;
    }
    c = fmt[++i] & 0xff;
    if(c == 0)
      break;
    switch(c){
 8de:	07300b93          	li	s7,115
 8e2:	07800c93          	li	s9,120
 8e6:	06400c13          	li	s8,100
 8ea:	a839                	j	908 <snprintf+0x70>
      off += sputc(buf+off, '%');
      off += sputc(buf+off, c);
      break;
    }
  }
  return off;
 8ec:	4481                	li	s1,0
 8ee:	6946                	ld	s2,80(sp)
 8f0:	69a6                	ld	s3,72(sp)
 8f2:	7ae2                	ld	s5,56(sp)
 8f4:	7b42                	ld	s6,48(sp)
 8f6:	a0cd                	j	9d8 <snprintf+0x140>
  *s = c;
 8f8:	009b0733          	add	a4,s6,s1
 8fc:	00f70023          	sb	a5,0(a4)
      off += sputc(buf+off, c);
 900:	2485                	addw	s1,s1,1
  for(i = 0; off < sz && (c = fmt[i] & 0xff) != 0; i++){
 902:	2905                	addw	s2,s2,1
 904:	1554d563          	bge	s1,s5,a4e <snprintf+0x1b6>
 908:	012987b3          	add	a5,s3,s2
 90c:	0007c783          	lbu	a5,0(a5)
 910:	0007871b          	sext.w	a4,a5
 914:	10078063          	beqz	a5,a14 <snprintf+0x17c>
    if(c != '%'){
 918:	ff4710e3          	bne	a4,s4,8f8 <snprintf+0x60>
    c = fmt[++i] & 0xff;
 91c:	2905                	addw	s2,s2,1
 91e:	012987b3          	add	a5,s3,s2
 922:	0007c783          	lbu	a5,0(a5)
    if(c == 0)
 926:	10078263          	beqz	a5,a2a <snprintf+0x192>
    switch(c){
 92a:	05778c63          	beq	a5,s7,982 <snprintf+0xea>
 92e:	02fbe763          	bltu	s7,a5,95c <snprintf+0xc4>
 932:	0d478063          	beq	a5,s4,9f2 <snprintf+0x15a>
 936:	0d879463          	bne	a5,s8,9fe <snprintf+0x166>
      off += sprintint(buf+off, va_arg(ap, int), 10, 1);
 93a:	f9843783          	ld	a5,-104(s0)
 93e:	00878713          	add	a4,a5,8
 942:	f8e43c23          	sd	a4,-104(s0)
 946:	4685                	li	a3,1
 948:	4629                	li	a2,10
 94a:	438c                	lw	a1,0(a5)
 94c:	009b0533          	add	a0,s6,s1
 950:	00000097          	auipc	ra,0x0
 954:	bb0080e7          	jalr	-1104(ra) # 500 <sprintint>
 958:	9ca9                	addw	s1,s1,a0
      break;
 95a:	b765                	j	902 <snprintf+0x6a>
    switch(c){
 95c:	0b979163          	bne	a5,s9,9fe <snprintf+0x166>
      off += sprintint(buf+off, va_arg(ap, int), 16, 1);
 960:	f9843783          	ld	a5,-104(s0)
 964:	00878713          	add	a4,a5,8
 968:	f8e43c23          	sd	a4,-104(s0)
 96c:	4685                	li	a3,1
 96e:	4641                	li	a2,16
 970:	438c                	lw	a1,0(a5)
 972:	009b0533          	add	a0,s6,s1
 976:	00000097          	auipc	ra,0x0
 97a:	b8a080e7          	jalr	-1142(ra) # 500 <sprintint>
 97e:	9ca9                	addw	s1,s1,a0
      break;
 980:	b749                	j	902 <snprintf+0x6a>
      if((s = va_arg(ap, char*)) == 0)
 982:	f9843783          	ld	a5,-104(s0)
 986:	00878713          	add	a4,a5,8
 98a:	f8e43c23          	sd	a4,-104(s0)
 98e:	6388                	ld	a0,0(a5)
 990:	c931                	beqz	a0,9e4 <snprintf+0x14c>
      for(; *s && off < sz; s++)
 992:	00054703          	lbu	a4,0(a0)
 996:	d735                	beqz	a4,902 <snprintf+0x6a>
 998:	0b54d263          	bge	s1,s5,a3c <snprintf+0x1a4>
 99c:	009b06b3          	add	a3,s6,s1
 9a0:	409a863b          	subw	a2,s5,s1
 9a4:	1602                	sll	a2,a2,0x20
 9a6:	9201                	srl	a2,a2,0x20
 9a8:	962a                	add	a2,a2,a0
 9aa:	87aa                	mv	a5,a0
        off += sputc(buf+off, *s);
 9ac:	0014859b          	addw	a1,s1,1
 9b0:	9d89                	subw	a1,a1,a0
  *s = c;
 9b2:	00e68023          	sb	a4,0(a3)
        off += sputc(buf+off, *s);
 9b6:	00f584bb          	addw	s1,a1,a5
      for(; *s && off < sz; s++)
 9ba:	0785                	add	a5,a5,1
 9bc:	0007c703          	lbu	a4,0(a5)
 9c0:	d329                	beqz	a4,902 <snprintf+0x6a>
 9c2:	0685                	add	a3,a3,1
 9c4:	fec797e3          	bne	a5,a2,9b2 <snprintf+0x11a>
 9c8:	6946                	ld	s2,80(sp)
 9ca:	69a6                	ld	s3,72(sp)
 9cc:	6a06                	ld	s4,64(sp)
 9ce:	7ae2                	ld	s5,56(sp)
 9d0:	7b42                	ld	s6,48(sp)
 9d2:	7ba2                	ld	s7,40(sp)
 9d4:	7c02                	ld	s8,32(sp)
 9d6:	6ce2                	ld	s9,24(sp)
 9d8:	8526                	mv	a0,s1
 9da:	70a6                	ld	ra,104(sp)
 9dc:	7406                	ld	s0,96(sp)
 9de:	64e6                	ld	s1,88(sp)
 9e0:	610d                	add	sp,sp,160
 9e2:	8082                	ret
      for(; *s && off < sz; s++)
 9e4:	02800713          	li	a4,40
        s = "(null)";
 9e8:	00000517          	auipc	a0,0x0
 9ec:	24850513          	add	a0,a0,584 # c30 <malloc+0x14e>
 9f0:	b765                	j	998 <snprintf+0x100>
  *s = c;
 9f2:	009b07b3          	add	a5,s6,s1
 9f6:	01478023          	sb	s4,0(a5)
      off += sputc(buf+off, '%');
 9fa:	2485                	addw	s1,s1,1
      break;
 9fc:	b719                	j	902 <snprintf+0x6a>
  *s = c;
 9fe:	009b0733          	add	a4,s6,s1
 a02:	01470023          	sb	s4,0(a4)
      off += sputc(buf+off, c);
 a06:	0014871b          	addw	a4,s1,1
  *s = c;
 a0a:	975a                	add	a4,a4,s6
 a0c:	00f70023          	sb	a5,0(a4)
      off += sputc(buf+off, c);
 a10:	2489                	addw	s1,s1,2
      break;
 a12:	bdc5                	j	902 <snprintf+0x6a>
 a14:	6946                	ld	s2,80(sp)
 a16:	69a6                	ld	s3,72(sp)
 a18:	6a06                	ld	s4,64(sp)
 a1a:	7ae2                	ld	s5,56(sp)
 a1c:	7b42                	ld	s6,48(sp)
 a1e:	7ba2                	ld	s7,40(sp)
 a20:	7c02                	ld	s8,32(sp)
 a22:	6ce2                	ld	s9,24(sp)
 a24:	bf55                	j	9d8 <snprintf+0x140>
    return -1;
 a26:	54fd                	li	s1,-1
 a28:	bf45                	j	9d8 <snprintf+0x140>
 a2a:	6946                	ld	s2,80(sp)
 a2c:	69a6                	ld	s3,72(sp)
 a2e:	6a06                	ld	s4,64(sp)
 a30:	7ae2                	ld	s5,56(sp)
 a32:	7b42                	ld	s6,48(sp)
 a34:	7ba2                	ld	s7,40(sp)
 a36:	7c02                	ld	s8,32(sp)
 a38:	6ce2                	ld	s9,24(sp)
 a3a:	bf79                	j	9d8 <snprintf+0x140>
 a3c:	6946                	ld	s2,80(sp)
 a3e:	69a6                	ld	s3,72(sp)
 a40:	6a06                	ld	s4,64(sp)
 a42:	7ae2                	ld	s5,56(sp)
 a44:	7b42                	ld	s6,48(sp)
 a46:	7ba2                	ld	s7,40(sp)
 a48:	7c02                	ld	s8,32(sp)
 a4a:	6ce2                	ld	s9,24(sp)
 a4c:	b771                	j	9d8 <snprintf+0x140>
 a4e:	6946                	ld	s2,80(sp)
 a50:	69a6                	ld	s3,72(sp)
 a52:	6a06                	ld	s4,64(sp)
 a54:	7ae2                	ld	s5,56(sp)
 a56:	7b42                	ld	s6,48(sp)
 a58:	7ba2                	ld	s7,40(sp)
 a5a:	7c02                	ld	s8,32(sp)
 a5c:	6ce2                	ld	s9,24(sp)
 a5e:	bfad                	j	9d8 <snprintf+0x140>

0000000000000a60 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 a60:	1141                	add	sp,sp,-16
 a62:	e422                	sd	s0,8(sp)
 a64:	0800                	add	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 a66:	ff050693          	add	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 a6a:	00000797          	auipc	a5,0x0
 a6e:	23e7b783          	ld	a5,574(a5) # ca8 <freep>
 a72:	a02d                	j	a9c <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 a74:	4618                	lw	a4,8(a2)
 a76:	9f2d                	addw	a4,a4,a1
 a78:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 a7c:	6398                	ld	a4,0(a5)
 a7e:	6310                	ld	a2,0(a4)
 a80:	a83d                	j	abe <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 a82:	ff852703          	lw	a4,-8(a0)
 a86:	9f31                	addw	a4,a4,a2
 a88:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 a8a:	ff053683          	ld	a3,-16(a0)
 a8e:	a091                	j	ad2 <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 a90:	6398                	ld	a4,0(a5)
 a92:	00e7e463          	bltu	a5,a4,a9a <free+0x3a>
 a96:	00e6ea63          	bltu	a3,a4,aaa <free+0x4a>
{
 a9a:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 a9c:	fed7fae3          	bgeu	a5,a3,a90 <free+0x30>
 aa0:	6398                	ld	a4,0(a5)
 aa2:	00e6e463          	bltu	a3,a4,aaa <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 aa6:	fee7eae3          	bltu	a5,a4,a9a <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 aaa:	ff852583          	lw	a1,-8(a0)
 aae:	6390                	ld	a2,0(a5)
 ab0:	02059813          	sll	a6,a1,0x20
 ab4:	01c85713          	srl	a4,a6,0x1c
 ab8:	9736                	add	a4,a4,a3
 aba:	fae60de3          	beq	a2,a4,a74 <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 abe:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 ac2:	4790                	lw	a2,8(a5)
 ac4:	02061593          	sll	a1,a2,0x20
 ac8:	01c5d713          	srl	a4,a1,0x1c
 acc:	973e                	add	a4,a4,a5
 ace:	fae68ae3          	beq	a3,a4,a82 <free+0x22>
    p->s.ptr = bp->s.ptr;
 ad2:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 ad4:	00000717          	auipc	a4,0x0
 ad8:	1cf73a23          	sd	a5,468(a4) # ca8 <freep>
}
 adc:	6422                	ld	s0,8(sp)
 ade:	0141                	add	sp,sp,16
 ae0:	8082                	ret

0000000000000ae2 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 ae2:	7139                	add	sp,sp,-64
 ae4:	fc06                	sd	ra,56(sp)
 ae6:	f822                	sd	s0,48(sp)
 ae8:	f426                	sd	s1,40(sp)
 aea:	ec4e                	sd	s3,24(sp)
 aec:	0080                	add	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 aee:	02051493          	sll	s1,a0,0x20
 af2:	9081                	srl	s1,s1,0x20
 af4:	04bd                	add	s1,s1,15
 af6:	8091                	srl	s1,s1,0x4
 af8:	0014899b          	addw	s3,s1,1
 afc:	0485                	add	s1,s1,1
  if((prevp = freep) == 0){
 afe:	00000517          	auipc	a0,0x0
 b02:	1aa53503          	ld	a0,426(a0) # ca8 <freep>
 b06:	c915                	beqz	a0,b3a <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 b08:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 b0a:	4798                	lw	a4,8(a5)
 b0c:	08977e63          	bgeu	a4,s1,ba8 <malloc+0xc6>
 b10:	f04a                	sd	s2,32(sp)
 b12:	e852                	sd	s4,16(sp)
 b14:	e456                	sd	s5,8(sp)
 b16:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 b18:	8a4e                	mv	s4,s3
 b1a:	0009871b          	sext.w	a4,s3
 b1e:	6685                	lui	a3,0x1
 b20:	00d77363          	bgeu	a4,a3,b26 <malloc+0x44>
 b24:	6a05                	lui	s4,0x1
 b26:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 b2a:	004a1a1b          	sllw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 b2e:	00000917          	auipc	s2,0x0
 b32:	17a90913          	add	s2,s2,378 # ca8 <freep>
  if(p == (char*)-1)
 b36:	5afd                	li	s5,-1
 b38:	a091                	j	b7c <malloc+0x9a>
 b3a:	f04a                	sd	s2,32(sp)
 b3c:	e852                	sd	s4,16(sp)
 b3e:	e456                	sd	s5,8(sp)
 b40:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 b42:	00000797          	auipc	a5,0x0
 b46:	36e78793          	add	a5,a5,878 # eb0 <base>
 b4a:	00000717          	auipc	a4,0x0
 b4e:	14f73f23          	sd	a5,350(a4) # ca8 <freep>
 b52:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 b54:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 b58:	b7c1                	j	b18 <malloc+0x36>
        prevp->s.ptr = p->s.ptr;
 b5a:	6398                	ld	a4,0(a5)
 b5c:	e118                	sd	a4,0(a0)
 b5e:	a08d                	j	bc0 <malloc+0xde>
  hp->s.size = nu;
 b60:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 b64:	0541                	add	a0,a0,16
 b66:	00000097          	auipc	ra,0x0
 b6a:	efa080e7          	jalr	-262(ra) # a60 <free>
  return freep;
 b6e:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 b72:	c13d                	beqz	a0,bd8 <malloc+0xf6>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 b74:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 b76:	4798                	lw	a4,8(a5)
 b78:	02977463          	bgeu	a4,s1,ba0 <malloc+0xbe>
    if(p == freep)
 b7c:	00093703          	ld	a4,0(s2)
 b80:	853e                	mv	a0,a5
 b82:	fef719e3          	bne	a4,a5,b74 <malloc+0x92>
  p = sbrk(nu * sizeof(Header));
 b86:	8552                	mv	a0,s4
 b88:	00000097          	auipc	ra,0x0
 b8c:	92a080e7          	jalr	-1750(ra) # 4b2 <sbrk>
  if(p == (char*)-1)
 b90:	fd5518e3          	bne	a0,s5,b60 <malloc+0x7e>
        return 0;
 b94:	4501                	li	a0,0
 b96:	7902                	ld	s2,32(sp)
 b98:	6a42                	ld	s4,16(sp)
 b9a:	6aa2                	ld	s5,8(sp)
 b9c:	6b02                	ld	s6,0(sp)
 b9e:	a03d                	j	bcc <malloc+0xea>
 ba0:	7902                	ld	s2,32(sp)
 ba2:	6a42                	ld	s4,16(sp)
 ba4:	6aa2                	ld	s5,8(sp)
 ba6:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 ba8:	fae489e3          	beq	s1,a4,b5a <malloc+0x78>
        p->s.size -= nunits;
 bac:	4137073b          	subw	a4,a4,s3
 bb0:	c798                	sw	a4,8(a5)
        p += p->s.size;
 bb2:	02071693          	sll	a3,a4,0x20
 bb6:	01c6d713          	srl	a4,a3,0x1c
 bba:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 bbc:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 bc0:	00000717          	auipc	a4,0x0
 bc4:	0ea73423          	sd	a0,232(a4) # ca8 <freep>
      return (void*)(p + 1);
 bc8:	01078513          	add	a0,a5,16
  }
}
 bcc:	70e2                	ld	ra,56(sp)
 bce:	7442                	ld	s0,48(sp)
 bd0:	74a2                	ld	s1,40(sp)
 bd2:	69e2                	ld	s3,24(sp)
 bd4:	6121                	add	sp,sp,64
 bd6:	8082                	ret
 bd8:	7902                	ld	s2,32(sp)
 bda:	6a42                	ld	s4,16(sp)
 bdc:	6aa2                	ld	s5,8(sp)
 bde:	6b02                	ld	s6,0(sp)
 be0:	b7f5                	j	bcc <malloc+0xea>
