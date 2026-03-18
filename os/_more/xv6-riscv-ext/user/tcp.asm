
user/_tcp:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/net.h"
#include "kernel/stat.h"
#include "user/user.h"

int main(int argc, char *argv[])
{
   0:	bc010113          	add	sp,sp,-1088
   4:	42113c23          	sd	ra,1080(sp)
   8:	42813823          	sd	s0,1072(sp)
   c:	44010413          	add	s0,sp,1088

  int fd;
  if ((fd = socket(AF_INET, SOCK_STREAM, 0)) < 0) {
  10:	4601                	li	a2,0
  12:	4585                	li	a1,1
  14:	4501                	li	a0,0
  16:	00000097          	auipc	ra,0x0
  1a:	522080e7          	jalr	1314(ra) # 538 <socket>
  1e:	16054d63          	bltz	a0,198 <main+0x198>
  22:	42913423          	sd	s1,1064(sp)
  26:	84aa                	mv	s1,a0
    printf("socket error !!!\n");
    exit(0);
  }
  printf("socket create success\n");
  28:	00001517          	auipc	a0,0x1
  2c:	c3850513          	add	a0,a0,-968 # c60 <malloc+0x118>
  30:	00001097          	auipc	ra,0x1
  34:	898080e7          	jalr	-1896(ra) # 8c8 <printf>

  struct sockaddr_in addr;
  addr.sin_family = AF_INET;
  38:	fc041c23          	sh	zero,-40(s0)
  addr.sin_addr = INADDR_ANY;
  3c:	fc042e23          	sw	zero,-36(s0)
  addr.sin_port = htons(2222);
  40:	77ed                	lui	a5,0xffffb
  42:	e0878793          	add	a5,a5,-504 # ffffffffffffae08 <__global_pointer$+0xffffffffffff9837>
  46:	fcf41d23          	sh	a5,-38(s0)

  if (bind(fd, (struct sockaddr *)&addr, sizeof(addr)) < 0) {
  4a:	4621                	li	a2,8
  4c:	fd840593          	add	a1,s0,-40
  50:	8526                	mv	a0,s1
  52:	00000097          	auipc	ra,0x0
  56:	4ee080e7          	jalr	1262(ra) # 540 <bind>
  5a:	16054063          	bltz	a0,1ba <main+0x1ba>
    printf("bind error!\n");
    exit(0);
  }
  printf("bind success\n");
  5e:	00001517          	auipc	a0,0x1
  62:	c2a50513          	add	a0,a0,-982 # c88 <malloc+0x140>
  66:	00001097          	auipc	ra,0x1
  6a:	862080e7          	jalr	-1950(ra) # 8c8 <printf>
  
  if (listen(fd, 5) < 0) {
  6e:	4595                	li	a1,5
  70:	8526                	mv	a0,s1
  72:	00000097          	auipc	ra,0x0
  76:	4d6080e7          	jalr	1238(ra) # 548 <listen>
  7a:	14054f63          	bltz	a0,1d8 <main+0x1d8>
  7e:	43213023          	sd	s2,1056(sp)
    printf("listen error!\n");
    exit(0);
  }
  printf("listen success!\n");
  82:	00001517          	auipc	a0,0x1
  86:	c2650513          	add	a0,a0,-986 # ca8 <malloc+0x160>
  8a:	00001097          	auipc	ra,0x1
  8e:	83e080e7          	jalr	-1986(ra) # 8c8 <printf>

  struct sockaddr clientsa;
  int salen;
  printf("waiting accept...\n");
  92:	00001517          	auipc	a0,0x1
  96:	c2e50513          	add	a0,a0,-978 # cc0 <malloc+0x178>
  9a:	00001097          	auipc	ra,0x1
  9e:	82e080e7          	jalr	-2002(ra) # 8c8 <printf>
  int clientfd = accept(fd, &clientsa, &salen);
  a2:	fc440613          	add	a2,s0,-60
  a6:	fc840593          	add	a1,s0,-56
  aa:	8526                	mv	a0,s1
  ac:	00000097          	auipc	ra,0x0
  b0:	4a6080e7          	jalr	1190(ra) # 552 <accept>
  b4:	892a                	mv	s2,a0

  printf("accept a client!!! fd: %d\n", clientfd);
  b6:	85aa                	mv	a1,a0
  b8:	00001517          	auipc	a0,0x1
  bc:	c2050513          	add	a0,a0,-992 # cd8 <malloc+0x190>
  c0:	00001097          	auipc	ra,0x1
  c4:	808080e7          	jalr	-2040(ra) # 8c8 <printf>
// endianness support
//

static inline uint16 bswaps(uint16 val)
{
  return (((val & 0x00ffU) << 8) |
  c8:	fca45783          	lhu	a5,-54(s0)
  cc:	0087971b          	sllw	a4,a5,0x8
  d0:	83a1                	srl	a5,a5,0x8
  d2:	8fd9                	or	a5,a5,a4
  struct sockaddr_in *si = (struct sockaddr_in *)&clientsa;
  uint8 *ptr = (uint8 *)&si->sin_addr;

  printf("client ip: %d:%d:%d:%d  port: %d\n", ptr[0], ptr[1], ptr[2], ptr[3], htons(si->sin_port));
  d4:	17c2                	sll	a5,a5,0x30
  d6:	93c1                	srl	a5,a5,0x30
  d8:	fcf44703          	lbu	a4,-49(s0)
  dc:	fce44683          	lbu	a3,-50(s0)
  e0:	fcd44603          	lbu	a2,-51(s0)
  e4:	fcc44583          	lbu	a1,-52(s0)
  e8:	00001517          	auipc	a0,0x1
  ec:	c1050513          	add	a0,a0,-1008 # cf8 <malloc+0x1b0>
  f0:	00000097          	auipc	ra,0x0
  f4:	7d8080e7          	jalr	2008(ra) # 8c8 <printf>
  char buf[1024] = {0};
  f8:	40000613          	li	a2,1024
  fc:	4581                	li	a1,0
  fe:	bc040513          	add	a0,s0,-1088
 102:	00000097          	auipc	ra,0x0
 106:	194080e7          	jalr	404(ra) # 296 <memset>
  int n = read(clientfd, buf, 1000);
 10a:	3e800613          	li	a2,1000
 10e:	bc040593          	add	a1,s0,-1088
 112:	854a                	mv	a0,s2
 114:	00000097          	auipc	ra,0x0
 118:	394080e7          	jalr	916(ra) # 4a8 <read>
 11c:	85aa                	mv	a1,a0
  printf("n: %d\n", n);
 11e:	00001517          	auipc	a0,0x1
 122:	c0250513          	add	a0,a0,-1022 # d20 <malloc+0x1d8>
 126:	00000097          	auipc	ra,0x0
 12a:	7a2080e7          	jalr	1954(ra) # 8c8 <printf>
  printf("read: %s\n", buf);
 12e:	bc040593          	add	a1,s0,-1088
 132:	00001517          	auipc	a0,0x1
 136:	bf650513          	add	a0,a0,-1034 # d28 <malloc+0x1e0>
 13a:	00000097          	auipc	ra,0x0
 13e:	78e080e7          	jalr	1934(ra) # 8c8 <printf>

  char *rep = "hhhhh I've received!!!";
  n = write(clientfd, rep, strlen(rep));
 142:	00001517          	auipc	a0,0x1
 146:	bf650513          	add	a0,a0,-1034 # d38 <malloc+0x1f0>
 14a:	00000097          	auipc	ra,0x0
 14e:	0f4080e7          	jalr	244(ra) # 23e <strlen>
 152:	0005061b          	sext.w	a2,a0
 156:	00001597          	auipc	a1,0x1
 15a:	be258593          	add	a1,a1,-1054 # d38 <malloc+0x1f0>
 15e:	854a                	mv	a0,s2
 160:	00000097          	auipc	ra,0x0
 164:	350080e7          	jalr	848(ra) # 4b0 <write>
 168:	85aa                	mv	a1,a0
  printf("write: %d\n", n);
 16a:	00001517          	auipc	a0,0x1
 16e:	be650513          	add	a0,a0,-1050 # d50 <malloc+0x208>
 172:	00000097          	auipc	ra,0x0
 176:	756080e7          	jalr	1878(ra) # 8c8 <printf>

  //sleep(20);
  close(clientfd);
 17a:	854a                	mv	a0,s2
 17c:	00000097          	auipc	ra,0x0
 180:	33c080e7          	jalr	828(ra) # 4b8 <close>
  close(fd);
 184:	8526                	mv	a0,s1
 186:	00000097          	auipc	ra,0x0
 18a:	332080e7          	jalr	818(ra) # 4b8 <close>
    
  //   close(clientfd);
  // }
  

  exit(0);
 18e:	4501                	li	a0,0
 190:	00000097          	auipc	ra,0x0
 194:	300080e7          	jalr	768(ra) # 490 <exit>
 198:	42913423          	sd	s1,1064(sp)
 19c:	43213023          	sd	s2,1056(sp)
    printf("socket error !!!\n");
 1a0:	00001517          	auipc	a0,0x1
 1a4:	aa850513          	add	a0,a0,-1368 # c48 <malloc+0x100>
 1a8:	00000097          	auipc	ra,0x0
 1ac:	720080e7          	jalr	1824(ra) # 8c8 <printf>
    exit(0);
 1b0:	4501                	li	a0,0
 1b2:	00000097          	auipc	ra,0x0
 1b6:	2de080e7          	jalr	734(ra) # 490 <exit>
 1ba:	43213023          	sd	s2,1056(sp)
    printf("bind error!\n");
 1be:	00001517          	auipc	a0,0x1
 1c2:	aba50513          	add	a0,a0,-1350 # c78 <malloc+0x130>
 1c6:	00000097          	auipc	ra,0x0
 1ca:	702080e7          	jalr	1794(ra) # 8c8 <printf>
    exit(0);
 1ce:	4501                	li	a0,0
 1d0:	00000097          	auipc	ra,0x0
 1d4:	2c0080e7          	jalr	704(ra) # 490 <exit>
 1d8:	43213023          	sd	s2,1056(sp)
    printf("listen error!\n");
 1dc:	00001517          	auipc	a0,0x1
 1e0:	abc50513          	add	a0,a0,-1348 # c98 <malloc+0x150>
 1e4:	00000097          	auipc	ra,0x0
 1e8:	6e4080e7          	jalr	1764(ra) # 8c8 <printf>
    exit(0);
 1ec:	4501                	li	a0,0
 1ee:	00000097          	auipc	ra,0x0
 1f2:	2a2080e7          	jalr	674(ra) # 490 <exit>

00000000000001f6 <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
 1f6:	1141                	add	sp,sp,-16
 1f8:	e422                	sd	s0,8(sp)
 1fa:	0800                	add	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 1fc:	87aa                	mv	a5,a0
 1fe:	0585                	add	a1,a1,1
 200:	0785                	add	a5,a5,1
 202:	fff5c703          	lbu	a4,-1(a1)
 206:	fee78fa3          	sb	a4,-1(a5)
 20a:	fb75                	bnez	a4,1fe <strcpy+0x8>
    ;
  return os;
}
 20c:	6422                	ld	s0,8(sp)
 20e:	0141                	add	sp,sp,16
 210:	8082                	ret

0000000000000212 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 212:	1141                	add	sp,sp,-16
 214:	e422                	sd	s0,8(sp)
 216:	0800                	add	s0,sp,16
  while(*p && *p == *q)
 218:	00054783          	lbu	a5,0(a0)
 21c:	cb91                	beqz	a5,230 <strcmp+0x1e>
 21e:	0005c703          	lbu	a4,0(a1)
 222:	00f71763          	bne	a4,a5,230 <strcmp+0x1e>
    p++, q++;
 226:	0505                	add	a0,a0,1
 228:	0585                	add	a1,a1,1
  while(*p && *p == *q)
 22a:	00054783          	lbu	a5,0(a0)
 22e:	fbe5                	bnez	a5,21e <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 230:	0005c503          	lbu	a0,0(a1)
}
 234:	40a7853b          	subw	a0,a5,a0
 238:	6422                	ld	s0,8(sp)
 23a:	0141                	add	sp,sp,16
 23c:	8082                	ret

000000000000023e <strlen>:

uint
strlen(const char *s)
{
 23e:	1141                	add	sp,sp,-16
 240:	e422                	sd	s0,8(sp)
 242:	0800                	add	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 244:	00054783          	lbu	a5,0(a0)
 248:	cf91                	beqz	a5,264 <strlen+0x26>
 24a:	0505                	add	a0,a0,1
 24c:	87aa                	mv	a5,a0
 24e:	86be                	mv	a3,a5
 250:	0785                	add	a5,a5,1
 252:	fff7c703          	lbu	a4,-1(a5)
 256:	ff65                	bnez	a4,24e <strlen+0x10>
 258:	40a6853b          	subw	a0,a3,a0
 25c:	2505                	addw	a0,a0,1
    ;
  return n;
}
 25e:	6422                	ld	s0,8(sp)
 260:	0141                	add	sp,sp,16
 262:	8082                	ret
  for(n = 0; s[n]; n++)
 264:	4501                	li	a0,0
 266:	bfe5                	j	25e <strlen+0x20>

0000000000000268 <strcat>:

char *
strcat(char *dst, char *src)
{
 268:	1141                	add	sp,sp,-16
 26a:	e422                	sd	s0,8(sp)
 26c:	0800                	add	s0,sp,16
  char *s = dst;
  while (*dst)
 26e:	00054783          	lbu	a5,0(a0)
 272:	c385                	beqz	a5,292 <strcat+0x2a>
 274:	87aa                	mv	a5,a0
    dst++;
 276:	0785                	add	a5,a5,1
  while (*dst)
 278:	0007c703          	lbu	a4,0(a5)
 27c:	ff6d                	bnez	a4,276 <strcat+0xe>
  while ((*dst++ = *src++) != 0);
 27e:	0585                	add	a1,a1,1
 280:	0785                	add	a5,a5,1
 282:	fff5c703          	lbu	a4,-1(a1)
 286:	fee78fa3          	sb	a4,-1(a5)
 28a:	fb75                	bnez	a4,27e <strcat+0x16>

  return s;
}
 28c:	6422                	ld	s0,8(sp)
 28e:	0141                	add	sp,sp,16
 290:	8082                	ret
  while (*dst)
 292:	87aa                	mv	a5,a0
 294:	b7ed                	j	27e <strcat+0x16>

0000000000000296 <memset>:

void*
memset(void *dst, int c, uint n)
{
 296:	1141                	add	sp,sp,-16
 298:	e422                	sd	s0,8(sp)
 29a:	0800                	add	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 29c:	ca19                	beqz	a2,2b2 <memset+0x1c>
 29e:	87aa                	mv	a5,a0
 2a0:	1602                	sll	a2,a2,0x20
 2a2:	9201                	srl	a2,a2,0x20
 2a4:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 2a8:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 2ac:	0785                	add	a5,a5,1
 2ae:	fee79de3          	bne	a5,a4,2a8 <memset+0x12>
  }
  return dst;
}
 2b2:	6422                	ld	s0,8(sp)
 2b4:	0141                	add	sp,sp,16
 2b6:	8082                	ret

00000000000002b8 <strchr>:

char*
strchr(const char *s, char c)
{
 2b8:	1141                	add	sp,sp,-16
 2ba:	e422                	sd	s0,8(sp)
 2bc:	0800                	add	s0,sp,16
  for(; *s; s++)
 2be:	00054783          	lbu	a5,0(a0)
 2c2:	cb99                	beqz	a5,2d8 <strchr+0x20>
    if(*s == c)
 2c4:	00f58763          	beq	a1,a5,2d2 <strchr+0x1a>
  for(; *s; s++)
 2c8:	0505                	add	a0,a0,1
 2ca:	00054783          	lbu	a5,0(a0)
 2ce:	fbfd                	bnez	a5,2c4 <strchr+0xc>
      return (char*)s;
  return 0;
 2d0:	4501                	li	a0,0
}
 2d2:	6422                	ld	s0,8(sp)
 2d4:	0141                	add	sp,sp,16
 2d6:	8082                	ret
  return 0;
 2d8:	4501                	li	a0,0
 2da:	bfe5                	j	2d2 <strchr+0x1a>

00000000000002dc <gets>:

char*
gets(char *buf, int max)
{
 2dc:	711d                	add	sp,sp,-96
 2de:	ec86                	sd	ra,88(sp)
 2e0:	e8a2                	sd	s0,80(sp)
 2e2:	e4a6                	sd	s1,72(sp)
 2e4:	e0ca                	sd	s2,64(sp)
 2e6:	fc4e                	sd	s3,56(sp)
 2e8:	f852                	sd	s4,48(sp)
 2ea:	f456                	sd	s5,40(sp)
 2ec:	f05a                	sd	s6,32(sp)
 2ee:	ec5e                	sd	s7,24(sp)
 2f0:	1080                	add	s0,sp,96
 2f2:	8baa                	mv	s7,a0
 2f4:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 2f6:	892a                	mv	s2,a0
 2f8:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 2fa:	4aa9                	li	s5,10
 2fc:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 2fe:	89a6                	mv	s3,s1
 300:	2485                	addw	s1,s1,1
 302:	0344d863          	bge	s1,s4,332 <gets+0x56>
    cc = read(0, &c, 1);
 306:	4605                	li	a2,1
 308:	faf40593          	add	a1,s0,-81
 30c:	4501                	li	a0,0
 30e:	00000097          	auipc	ra,0x0
 312:	19a080e7          	jalr	410(ra) # 4a8 <read>
    if(cc < 1)
 316:	00a05e63          	blez	a0,332 <gets+0x56>
    buf[i++] = c;
 31a:	faf44783          	lbu	a5,-81(s0)
 31e:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 322:	01578763          	beq	a5,s5,330 <gets+0x54>
 326:	0905                	add	s2,s2,1
 328:	fd679be3          	bne	a5,s6,2fe <gets+0x22>
    buf[i++] = c;
 32c:	89a6                	mv	s3,s1
 32e:	a011                	j	332 <gets+0x56>
 330:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 332:	99de                	add	s3,s3,s7
 334:	00098023          	sb	zero,0(s3)
  return buf;
}
 338:	855e                	mv	a0,s7
 33a:	60e6                	ld	ra,88(sp)
 33c:	6446                	ld	s0,80(sp)
 33e:	64a6                	ld	s1,72(sp)
 340:	6906                	ld	s2,64(sp)
 342:	79e2                	ld	s3,56(sp)
 344:	7a42                	ld	s4,48(sp)
 346:	7aa2                	ld	s5,40(sp)
 348:	7b02                	ld	s6,32(sp)
 34a:	6be2                	ld	s7,24(sp)
 34c:	6125                	add	sp,sp,96
 34e:	8082                	ret

0000000000000350 <stat>:

int
stat(const char *n, struct stat *st)
{
 350:	1101                	add	sp,sp,-32
 352:	ec06                	sd	ra,24(sp)
 354:	e822                	sd	s0,16(sp)
 356:	e04a                	sd	s2,0(sp)
 358:	1000                	add	s0,sp,32
 35a:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 35c:	4581                	li	a1,0
 35e:	00000097          	auipc	ra,0x0
 362:	172080e7          	jalr	370(ra) # 4d0 <open>
  if(fd < 0)
 366:	02054663          	bltz	a0,392 <stat+0x42>
 36a:	e426                	sd	s1,8(sp)
 36c:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 36e:	85ca                	mv	a1,s2
 370:	00000097          	auipc	ra,0x0
 374:	178080e7          	jalr	376(ra) # 4e8 <fstat>
 378:	892a                	mv	s2,a0
  close(fd);
 37a:	8526                	mv	a0,s1
 37c:	00000097          	auipc	ra,0x0
 380:	13c080e7          	jalr	316(ra) # 4b8 <close>
  return r;
 384:	64a2                	ld	s1,8(sp)
}
 386:	854a                	mv	a0,s2
 388:	60e2                	ld	ra,24(sp)
 38a:	6442                	ld	s0,16(sp)
 38c:	6902                	ld	s2,0(sp)
 38e:	6105                	add	sp,sp,32
 390:	8082                	ret
    return -1;
 392:	597d                	li	s2,-1
 394:	bfcd                	j	386 <stat+0x36>

0000000000000396 <atoi>:

int
atoi(const char *s)
{
 396:	1141                	add	sp,sp,-16
 398:	e422                	sd	s0,8(sp)
 39a:	0800                	add	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 39c:	00054683          	lbu	a3,0(a0)
 3a0:	fd06879b          	addw	a5,a3,-48
 3a4:	0ff7f793          	zext.b	a5,a5
 3a8:	4625                	li	a2,9
 3aa:	02f66863          	bltu	a2,a5,3da <atoi+0x44>
 3ae:	872a                	mv	a4,a0
  n = 0;
 3b0:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 3b2:	0705                	add	a4,a4,1
 3b4:	0025179b          	sllw	a5,a0,0x2
 3b8:	9fa9                	addw	a5,a5,a0
 3ba:	0017979b          	sllw	a5,a5,0x1
 3be:	9fb5                	addw	a5,a5,a3
 3c0:	fd07851b          	addw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 3c4:	00074683          	lbu	a3,0(a4)
 3c8:	fd06879b          	addw	a5,a3,-48
 3cc:	0ff7f793          	zext.b	a5,a5
 3d0:	fef671e3          	bgeu	a2,a5,3b2 <atoi+0x1c>
  return n;
}
 3d4:	6422                	ld	s0,8(sp)
 3d6:	0141                	add	sp,sp,16
 3d8:	8082                	ret
  n = 0;
 3da:	4501                	li	a0,0
 3dc:	bfe5                	j	3d4 <atoi+0x3e>

00000000000003de <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 3de:	1141                	add	sp,sp,-16
 3e0:	e422                	sd	s0,8(sp)
 3e2:	0800                	add	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 3e4:	02b57463          	bgeu	a0,a1,40c <memmove+0x2e>
    while(n-- > 0)
 3e8:	00c05f63          	blez	a2,406 <memmove+0x28>
 3ec:	1602                	sll	a2,a2,0x20
 3ee:	9201                	srl	a2,a2,0x20
 3f0:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 3f4:	872a                	mv	a4,a0
      *dst++ = *src++;
 3f6:	0585                	add	a1,a1,1
 3f8:	0705                	add	a4,a4,1
 3fa:	fff5c683          	lbu	a3,-1(a1)
 3fe:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 402:	fef71ae3          	bne	a4,a5,3f6 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 406:	6422                	ld	s0,8(sp)
 408:	0141                	add	sp,sp,16
 40a:	8082                	ret
    dst += n;
 40c:	00c50733          	add	a4,a0,a2
    src += n;
 410:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 412:	fec05ae3          	blez	a2,406 <memmove+0x28>
 416:	fff6079b          	addw	a5,a2,-1
 41a:	1782                	sll	a5,a5,0x20
 41c:	9381                	srl	a5,a5,0x20
 41e:	fff7c793          	not	a5,a5
 422:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 424:	15fd                	add	a1,a1,-1
 426:	177d                	add	a4,a4,-1
 428:	0005c683          	lbu	a3,0(a1)
 42c:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 430:	fee79ae3          	bne	a5,a4,424 <memmove+0x46>
 434:	bfc9                	j	406 <memmove+0x28>

0000000000000436 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 436:	1141                	add	sp,sp,-16
 438:	e422                	sd	s0,8(sp)
 43a:	0800                	add	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 43c:	ca05                	beqz	a2,46c <memcmp+0x36>
 43e:	fff6069b          	addw	a3,a2,-1
 442:	1682                	sll	a3,a3,0x20
 444:	9281                	srl	a3,a3,0x20
 446:	0685                	add	a3,a3,1
 448:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 44a:	00054783          	lbu	a5,0(a0)
 44e:	0005c703          	lbu	a4,0(a1)
 452:	00e79863          	bne	a5,a4,462 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 456:	0505                	add	a0,a0,1
    p2++;
 458:	0585                	add	a1,a1,1
  while (n-- > 0) {
 45a:	fed518e3          	bne	a0,a3,44a <memcmp+0x14>
  }
  return 0;
 45e:	4501                	li	a0,0
 460:	a019                	j	466 <memcmp+0x30>
      return *p1 - *p2;
 462:	40e7853b          	subw	a0,a5,a4
}
 466:	6422                	ld	s0,8(sp)
 468:	0141                	add	sp,sp,16
 46a:	8082                	ret
  return 0;
 46c:	4501                	li	a0,0
 46e:	bfe5                	j	466 <memcmp+0x30>

0000000000000470 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 470:	1141                	add	sp,sp,-16
 472:	e406                	sd	ra,8(sp)
 474:	e022                	sd	s0,0(sp)
 476:	0800                	add	s0,sp,16
  return memmove(dst, src, n);
 478:	00000097          	auipc	ra,0x0
 47c:	f66080e7          	jalr	-154(ra) # 3de <memmove>
}
 480:	60a2                	ld	ra,8(sp)
 482:	6402                	ld	s0,0(sp)
 484:	0141                	add	sp,sp,16
 486:	8082                	ret

0000000000000488 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 488:	4885                	li	a7,1
 ecall
 48a:	00000073          	ecall
 ret
 48e:	8082                	ret

0000000000000490 <exit>:
.global exit
exit:
 li a7, SYS_exit
 490:	4889                	li	a7,2
 ecall
 492:	00000073          	ecall
 ret
 496:	8082                	ret

0000000000000498 <wait>:
.global wait
wait:
 li a7, SYS_wait
 498:	488d                	li	a7,3
 ecall
 49a:	00000073          	ecall
 ret
 49e:	8082                	ret

00000000000004a0 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 4a0:	4891                	li	a7,4
 ecall
 4a2:	00000073          	ecall
 ret
 4a6:	8082                	ret

00000000000004a8 <read>:
.global read
read:
 li a7, SYS_read
 4a8:	4895                	li	a7,5
 ecall
 4aa:	00000073          	ecall
 ret
 4ae:	8082                	ret

00000000000004b0 <write>:
.global write
write:
 li a7, SYS_write
 4b0:	48c1                	li	a7,16
 ecall
 4b2:	00000073          	ecall
 ret
 4b6:	8082                	ret

00000000000004b8 <close>:
.global close
close:
 li a7, SYS_close
 4b8:	48d5                	li	a7,21
 ecall
 4ba:	00000073          	ecall
 ret
 4be:	8082                	ret

00000000000004c0 <kill>:
.global kill
kill:
 li a7, SYS_kill
 4c0:	4899                	li	a7,6
 ecall
 4c2:	00000073          	ecall
 ret
 4c6:	8082                	ret

00000000000004c8 <exec>:
.global exec
exec:
 li a7, SYS_exec
 4c8:	489d                	li	a7,7
 ecall
 4ca:	00000073          	ecall
 ret
 4ce:	8082                	ret

00000000000004d0 <open>:
.global open
open:
 li a7, SYS_open
 4d0:	48bd                	li	a7,15
 ecall
 4d2:	00000073          	ecall
 ret
 4d6:	8082                	ret

00000000000004d8 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 4d8:	48c5                	li	a7,17
 ecall
 4da:	00000073          	ecall
 ret
 4de:	8082                	ret

00000000000004e0 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 4e0:	48c9                	li	a7,18
 ecall
 4e2:	00000073          	ecall
 ret
 4e6:	8082                	ret

00000000000004e8 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 4e8:	48a1                	li	a7,8
 ecall
 4ea:	00000073          	ecall
 ret
 4ee:	8082                	ret

00000000000004f0 <link>:
.global link
link:
 li a7, SYS_link
 4f0:	48cd                	li	a7,19
 ecall
 4f2:	00000073          	ecall
 ret
 4f6:	8082                	ret

00000000000004f8 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 4f8:	48d1                	li	a7,20
 ecall
 4fa:	00000073          	ecall
 ret
 4fe:	8082                	ret

0000000000000500 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 500:	48a5                	li	a7,9
 ecall
 502:	00000073          	ecall
 ret
 506:	8082                	ret

0000000000000508 <dup>:
.global dup
dup:
 li a7, SYS_dup
 508:	48a9                	li	a7,10
 ecall
 50a:	00000073          	ecall
 ret
 50e:	8082                	ret

0000000000000510 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 510:	48ad                	li	a7,11
 ecall
 512:	00000073          	ecall
 ret
 516:	8082                	ret

0000000000000518 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 518:	48b1                	li	a7,12
 ecall
 51a:	00000073          	ecall
 ret
 51e:	8082                	ret

0000000000000520 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 520:	48b5                	li	a7,13
 ecall
 522:	00000073          	ecall
 ret
 526:	8082                	ret

0000000000000528 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 528:	48b9                	li	a7,14
 ecall
 52a:	00000073          	ecall
 ret
 52e:	8082                	ret

0000000000000530 <uconnect>:
.global uconnect
uconnect:
 li a7, SYS_uconnect
 530:	48f5                	li	a7,29
 ecall
 532:	00000073          	ecall
 ret
 536:	8082                	ret

0000000000000538 <socket>:
.global socket
socket:
 li a7, SYS_socket
 538:	48f9                	li	a7,30
 ecall
 53a:	00000073          	ecall
 ret
 53e:	8082                	ret

0000000000000540 <bind>:
.global bind
bind:
 li a7, SYS_bind
 540:	48fd                	li	a7,31
 ecall
 542:	00000073          	ecall
 ret
 546:	8082                	ret

0000000000000548 <listen>:
.global listen
listen:
 li a7, SYS_listen
 548:	02000893          	li	a7,32
 ecall
 54c:	00000073          	ecall
 ret
 550:	8082                	ret

0000000000000552 <accept>:
.global accept
accept:
 li a7, SYS_accept
 552:	02100893          	li	a7,33
 ecall
 556:	00000073          	ecall
 ret
 55a:	8082                	ret

000000000000055c <connect>:
.global connect
connect:
 li a7, SYS_connect
 55c:	02200893          	li	a7,34
 ecall
 560:	00000073          	ecall
 ret
 564:	8082                	ret

0000000000000566 <sprintint>:
  return 1;
}

static int
sprintint(char *s, int xx, int base, int sign)
{
 566:	1101                	add	sp,sp,-32
 568:	ec22                	sd	s0,24(sp)
 56a:	1000                	add	s0,sp,32
 56c:	882a                	mv	a6,a0
  char buf[16];
  int i, n;
  uint x;

  if(sign && (sign = xx < 0))
 56e:	c299                	beqz	a3,574 <sprintint+0xe>
 570:	0805c263          	bltz	a1,5f4 <sprintint+0x8e>
    x = -xx;
  else
    x = xx;
 574:	2581                	sext.w	a1,a1
 576:	4301                	li	t1,0

  i = 0;
 578:	fe040713          	add	a4,s0,-32
 57c:	4501                	li	a0,0
  do {
    buf[i++] = digits[x % base];
 57e:	2601                	sext.w	a2,a2
 580:	00001697          	auipc	a3,0x1
 584:	84068693          	add	a3,a3,-1984 # dc0 <digits>
 588:	88aa                	mv	a7,a0
 58a:	2505                	addw	a0,a0,1
 58c:	02c5f7bb          	remuw	a5,a1,a2
 590:	1782                	sll	a5,a5,0x20
 592:	9381                	srl	a5,a5,0x20
 594:	97b6                	add	a5,a5,a3
 596:	0007c783          	lbu	a5,0(a5)
 59a:	00f70023          	sb	a5,0(a4)
  } while((x /= base) != 0);
 59e:	0005879b          	sext.w	a5,a1
 5a2:	02c5d5bb          	divuw	a1,a1,a2
 5a6:	0705                	add	a4,a4,1
 5a8:	fec7f0e3          	bgeu	a5,a2,588 <sprintint+0x22>

  if(sign)
 5ac:	00030b63          	beqz	t1,5c2 <sprintint+0x5c>
    buf[i++] = '-';
 5b0:	ff050793          	add	a5,a0,-16
 5b4:	97a2                	add	a5,a5,s0
 5b6:	02d00713          	li	a4,45
 5ba:	fee78823          	sb	a4,-16(a5)
 5be:	0028851b          	addw	a0,a7,2

  n = 0;
  while(--i >= 0)
 5c2:	02a05d63          	blez	a0,5fc <sprintint+0x96>
 5c6:	fe040793          	add	a5,s0,-32
 5ca:	00a78733          	add	a4,a5,a0
 5ce:	87c2                	mv	a5,a6
 5d0:	00180613          	add	a2,a6,1
 5d4:	fff5069b          	addw	a3,a0,-1
 5d8:	1682                	sll	a3,a3,0x20
 5da:	9281                	srl	a3,a3,0x20
 5dc:	9636                	add	a2,a2,a3
  *s = c;
 5de:	fff74683          	lbu	a3,-1(a4)
 5e2:	00d78023          	sb	a3,0(a5)
  while(--i >= 0)
 5e6:	177d                	add	a4,a4,-1
 5e8:	0785                	add	a5,a5,1
 5ea:	fec79ae3          	bne	a5,a2,5de <sprintint+0x78>
    n += sputc(s+n, buf[i]);
  return n;
}
 5ee:	6462                	ld	s0,24(sp)
 5f0:	6105                	add	sp,sp,32
 5f2:	8082                	ret
    x = -xx;
 5f4:	40b005bb          	negw	a1,a1
  if(sign && (sign = xx < 0))
 5f8:	4305                	li	t1,1
    x = -xx;
 5fa:	bfbd                	j	578 <sprintint+0x12>
  while(--i >= 0)
 5fc:	4501                	li	a0,0
 5fe:	bfc5                	j	5ee <sprintint+0x88>

0000000000000600 <putc>:
{
 600:	1101                	add	sp,sp,-32
 602:	ec06                	sd	ra,24(sp)
 604:	e822                	sd	s0,16(sp)
 606:	1000                	add	s0,sp,32
 608:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 60c:	4605                	li	a2,1
 60e:	fef40593          	add	a1,s0,-17
 612:	00000097          	auipc	ra,0x0
 616:	e9e080e7          	jalr	-354(ra) # 4b0 <write>
}
 61a:	60e2                	ld	ra,24(sp)
 61c:	6442                	ld	s0,16(sp)
 61e:	6105                	add	sp,sp,32
 620:	8082                	ret

0000000000000622 <printint>:
{
 622:	7139                	add	sp,sp,-64
 624:	fc06                	sd	ra,56(sp)
 626:	f822                	sd	s0,48(sp)
 628:	f426                	sd	s1,40(sp)
 62a:	0080                	add	s0,sp,64
 62c:	84aa                	mv	s1,a0
  if(sgn && xx < 0){
 62e:	c299                	beqz	a3,634 <printint+0x12>
 630:	0805cb63          	bltz	a1,6c6 <printint+0xa4>
    x = xx;
 634:	2581                	sext.w	a1,a1
  neg = 0;
 636:	4881                	li	a7,0
 638:	fc040693          	add	a3,s0,-64
  i = 0;
 63c:	4701                	li	a4,0
    buf[i++] = digits[x % base];
 63e:	2601                	sext.w	a2,a2
 640:	00000517          	auipc	a0,0x0
 644:	78050513          	add	a0,a0,1920 # dc0 <digits>
 648:	883a                	mv	a6,a4
 64a:	2705                	addw	a4,a4,1
 64c:	02c5f7bb          	remuw	a5,a1,a2
 650:	1782                	sll	a5,a5,0x20
 652:	9381                	srl	a5,a5,0x20
 654:	97aa                	add	a5,a5,a0
 656:	0007c783          	lbu	a5,0(a5)
 65a:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 65e:	0005879b          	sext.w	a5,a1
 662:	02c5d5bb          	divuw	a1,a1,a2
 666:	0685                	add	a3,a3,1
 668:	fec7f0e3          	bgeu	a5,a2,648 <printint+0x26>
  if(neg)
 66c:	00088c63          	beqz	a7,684 <printint+0x62>
    buf[i++] = '-';
 670:	fd070793          	add	a5,a4,-48
 674:	00878733          	add	a4,a5,s0
 678:	02d00793          	li	a5,45
 67c:	fef70823          	sb	a5,-16(a4)
 680:	0028071b          	addw	a4,a6,2
  while(--i >= 0)
 684:	02e05c63          	blez	a4,6bc <printint+0x9a>
 688:	f04a                	sd	s2,32(sp)
 68a:	ec4e                	sd	s3,24(sp)
 68c:	fc040793          	add	a5,s0,-64
 690:	00e78933          	add	s2,a5,a4
 694:	fff78993          	add	s3,a5,-1
 698:	99ba                	add	s3,s3,a4
 69a:	377d                	addw	a4,a4,-1
 69c:	1702                	sll	a4,a4,0x20
 69e:	9301                	srl	a4,a4,0x20
 6a0:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 6a4:	fff94583          	lbu	a1,-1(s2)
 6a8:	8526                	mv	a0,s1
 6aa:	00000097          	auipc	ra,0x0
 6ae:	f56080e7          	jalr	-170(ra) # 600 <putc>
  while(--i >= 0)
 6b2:	197d                	add	s2,s2,-1
 6b4:	ff3918e3          	bne	s2,s3,6a4 <printint+0x82>
 6b8:	7902                	ld	s2,32(sp)
 6ba:	69e2                	ld	s3,24(sp)
}
 6bc:	70e2                	ld	ra,56(sp)
 6be:	7442                	ld	s0,48(sp)
 6c0:	74a2                	ld	s1,40(sp)
 6c2:	6121                	add	sp,sp,64
 6c4:	8082                	ret
    x = -xx;
 6c6:	40b005bb          	negw	a1,a1
    neg = 1;
 6ca:	4885                	li	a7,1
    x = -xx;
 6cc:	b7b5                	j	638 <printint+0x16>

00000000000006ce <vprintf>:
{
 6ce:	715d                	add	sp,sp,-80
 6d0:	e486                	sd	ra,72(sp)
 6d2:	e0a2                	sd	s0,64(sp)
 6d4:	f84a                	sd	s2,48(sp)
 6d6:	0880                	add	s0,sp,80
  for(i = 0; fmt[i]; i++){
 6d8:	0005c903          	lbu	s2,0(a1)
 6dc:	1a090a63          	beqz	s2,890 <vprintf+0x1c2>
 6e0:	fc26                	sd	s1,56(sp)
 6e2:	f44e                	sd	s3,40(sp)
 6e4:	f052                	sd	s4,32(sp)
 6e6:	ec56                	sd	s5,24(sp)
 6e8:	e85a                	sd	s6,16(sp)
 6ea:	e45e                	sd	s7,8(sp)
 6ec:	8aaa                	mv	s5,a0
 6ee:	8bb2                	mv	s7,a2
 6f0:	00158493          	add	s1,a1,1
  state = 0;
 6f4:	4981                	li	s3,0
    } else if(state == '%'){
 6f6:	02500a13          	li	s4,37
 6fa:	4b55                	li	s6,21
 6fc:	a839                	j	71a <vprintf+0x4c>
        putc(fd, c);
 6fe:	85ca                	mv	a1,s2
 700:	8556                	mv	a0,s5
 702:	00000097          	auipc	ra,0x0
 706:	efe080e7          	jalr	-258(ra) # 600 <putc>
 70a:	a019                	j	710 <vprintf+0x42>
    } else if(state == '%'){
 70c:	01498d63          	beq	s3,s4,726 <vprintf+0x58>
  for(i = 0; fmt[i]; i++){
 710:	0485                	add	s1,s1,1
 712:	fff4c903          	lbu	s2,-1(s1)
 716:	16090763          	beqz	s2,884 <vprintf+0x1b6>
    if(state == 0){
 71a:	fe0999e3          	bnez	s3,70c <vprintf+0x3e>
      if(c == '%'){
 71e:	ff4910e3          	bne	s2,s4,6fe <vprintf+0x30>
        state = '%';
 722:	89d2                	mv	s3,s4
 724:	b7f5                	j	710 <vprintf+0x42>
      if(c == 'd'){
 726:	13490463          	beq	s2,s4,84e <vprintf+0x180>
 72a:	f9d9079b          	addw	a5,s2,-99
 72e:	0ff7f793          	zext.b	a5,a5
 732:	12fb6763          	bltu	s6,a5,860 <vprintf+0x192>
 736:	f9d9079b          	addw	a5,s2,-99
 73a:	0ff7f713          	zext.b	a4,a5
 73e:	12eb6163          	bltu	s6,a4,860 <vprintf+0x192>
 742:	00271793          	sll	a5,a4,0x2
 746:	00000717          	auipc	a4,0x0
 74a:	62270713          	add	a4,a4,1570 # d68 <malloc+0x220>
 74e:	97ba                	add	a5,a5,a4
 750:	439c                	lw	a5,0(a5)
 752:	97ba                	add	a5,a5,a4
 754:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 756:	008b8913          	add	s2,s7,8
 75a:	4685                	li	a3,1
 75c:	4629                	li	a2,10
 75e:	000ba583          	lw	a1,0(s7)
 762:	8556                	mv	a0,s5
 764:	00000097          	auipc	ra,0x0
 768:	ebe080e7          	jalr	-322(ra) # 622 <printint>
 76c:	8bca                	mv	s7,s2
      state = 0;
 76e:	4981                	li	s3,0
 770:	b745                	j	710 <vprintf+0x42>
        printint(fd, va_arg(ap, uint64), 10, 0);
 772:	008b8913          	add	s2,s7,8
 776:	4681                	li	a3,0
 778:	4629                	li	a2,10
 77a:	000ba583          	lw	a1,0(s7)
 77e:	8556                	mv	a0,s5
 780:	00000097          	auipc	ra,0x0
 784:	ea2080e7          	jalr	-350(ra) # 622 <printint>
 788:	8bca                	mv	s7,s2
      state = 0;
 78a:	4981                	li	s3,0
 78c:	b751                	j	710 <vprintf+0x42>
        printint(fd, va_arg(ap, int), 16, 0);
 78e:	008b8913          	add	s2,s7,8
 792:	4681                	li	a3,0
 794:	4641                	li	a2,16
 796:	000ba583          	lw	a1,0(s7)
 79a:	8556                	mv	a0,s5
 79c:	00000097          	auipc	ra,0x0
 7a0:	e86080e7          	jalr	-378(ra) # 622 <printint>
 7a4:	8bca                	mv	s7,s2
      state = 0;
 7a6:	4981                	li	s3,0
 7a8:	b7a5                	j	710 <vprintf+0x42>
 7aa:	e062                	sd	s8,0(sp)
        printptr(fd, va_arg(ap, uint64));
 7ac:	008b8c13          	add	s8,s7,8
 7b0:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 7b4:	03000593          	li	a1,48
 7b8:	8556                	mv	a0,s5
 7ba:	00000097          	auipc	ra,0x0
 7be:	e46080e7          	jalr	-442(ra) # 600 <putc>
  putc(fd, 'x');
 7c2:	07800593          	li	a1,120
 7c6:	8556                	mv	a0,s5
 7c8:	00000097          	auipc	ra,0x0
 7cc:	e38080e7          	jalr	-456(ra) # 600 <putc>
 7d0:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 7d2:	00000b97          	auipc	s7,0x0
 7d6:	5eeb8b93          	add	s7,s7,1518 # dc0 <digits>
 7da:	03c9d793          	srl	a5,s3,0x3c
 7de:	97de                	add	a5,a5,s7
 7e0:	0007c583          	lbu	a1,0(a5)
 7e4:	8556                	mv	a0,s5
 7e6:	00000097          	auipc	ra,0x0
 7ea:	e1a080e7          	jalr	-486(ra) # 600 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 7ee:	0992                	sll	s3,s3,0x4
 7f0:	397d                	addw	s2,s2,-1
 7f2:	fe0914e3          	bnez	s2,7da <vprintf+0x10c>
        printptr(fd, va_arg(ap, uint64));
 7f6:	8be2                	mv	s7,s8
      state = 0;
 7f8:	4981                	li	s3,0
 7fa:	6c02                	ld	s8,0(sp)
 7fc:	bf11                	j	710 <vprintf+0x42>
        s = va_arg(ap, char*);
 7fe:	008b8993          	add	s3,s7,8
 802:	000bb903          	ld	s2,0(s7)
        if(s == 0)
 806:	02090163          	beqz	s2,828 <vprintf+0x15a>
        while(*s != 0){
 80a:	00094583          	lbu	a1,0(s2)
 80e:	c9a5                	beqz	a1,87e <vprintf+0x1b0>
          putc(fd, *s);
 810:	8556                	mv	a0,s5
 812:	00000097          	auipc	ra,0x0
 816:	dee080e7          	jalr	-530(ra) # 600 <putc>
          s++;
 81a:	0905                	add	s2,s2,1
        while(*s != 0){
 81c:	00094583          	lbu	a1,0(s2)
 820:	f9e5                	bnez	a1,810 <vprintf+0x142>
        s = va_arg(ap, char*);
 822:	8bce                	mv	s7,s3
      state = 0;
 824:	4981                	li	s3,0
 826:	b5ed                	j	710 <vprintf+0x42>
          s = "(null)";
 828:	00000917          	auipc	s2,0x0
 82c:	53890913          	add	s2,s2,1336 # d60 <malloc+0x218>
        while(*s != 0){
 830:	02800593          	li	a1,40
 834:	bff1                	j	810 <vprintf+0x142>
        putc(fd, va_arg(ap, uint));
 836:	008b8913          	add	s2,s7,8
 83a:	000bc583          	lbu	a1,0(s7)
 83e:	8556                	mv	a0,s5
 840:	00000097          	auipc	ra,0x0
 844:	dc0080e7          	jalr	-576(ra) # 600 <putc>
 848:	8bca                	mv	s7,s2
      state = 0;
 84a:	4981                	li	s3,0
 84c:	b5d1                	j	710 <vprintf+0x42>
        putc(fd, c);
 84e:	02500593          	li	a1,37
 852:	8556                	mv	a0,s5
 854:	00000097          	auipc	ra,0x0
 858:	dac080e7          	jalr	-596(ra) # 600 <putc>
      state = 0;
 85c:	4981                	li	s3,0
 85e:	bd4d                	j	710 <vprintf+0x42>
        putc(fd, '%');
 860:	02500593          	li	a1,37
 864:	8556                	mv	a0,s5
 866:	00000097          	auipc	ra,0x0
 86a:	d9a080e7          	jalr	-614(ra) # 600 <putc>
        putc(fd, c);
 86e:	85ca                	mv	a1,s2
 870:	8556                	mv	a0,s5
 872:	00000097          	auipc	ra,0x0
 876:	d8e080e7          	jalr	-626(ra) # 600 <putc>
      state = 0;
 87a:	4981                	li	s3,0
 87c:	bd51                	j	710 <vprintf+0x42>
        s = va_arg(ap, char*);
 87e:	8bce                	mv	s7,s3
      state = 0;
 880:	4981                	li	s3,0
 882:	b579                	j	710 <vprintf+0x42>
 884:	74e2                	ld	s1,56(sp)
 886:	79a2                	ld	s3,40(sp)
 888:	7a02                	ld	s4,32(sp)
 88a:	6ae2                	ld	s5,24(sp)
 88c:	6b42                	ld	s6,16(sp)
 88e:	6ba2                	ld	s7,8(sp)
}
 890:	60a6                	ld	ra,72(sp)
 892:	6406                	ld	s0,64(sp)
 894:	7942                	ld	s2,48(sp)
 896:	6161                	add	sp,sp,80
 898:	8082                	ret

000000000000089a <fprintf>:
{
 89a:	715d                	add	sp,sp,-80
 89c:	ec06                	sd	ra,24(sp)
 89e:	e822                	sd	s0,16(sp)
 8a0:	1000                	add	s0,sp,32
 8a2:	e010                	sd	a2,0(s0)
 8a4:	e414                	sd	a3,8(s0)
 8a6:	e818                	sd	a4,16(s0)
 8a8:	ec1c                	sd	a5,24(s0)
 8aa:	03043023          	sd	a6,32(s0)
 8ae:	03143423          	sd	a7,40(s0)
  va_start(ap, fmt);
 8b2:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 8b6:	8622                	mv	a2,s0
 8b8:	00000097          	auipc	ra,0x0
 8bc:	e16080e7          	jalr	-490(ra) # 6ce <vprintf>
}
 8c0:	60e2                	ld	ra,24(sp)
 8c2:	6442                	ld	s0,16(sp)
 8c4:	6161                	add	sp,sp,80
 8c6:	8082                	ret

00000000000008c8 <printf>:
{
 8c8:	711d                	add	sp,sp,-96
 8ca:	ec06                	sd	ra,24(sp)
 8cc:	e822                	sd	s0,16(sp)
 8ce:	1000                	add	s0,sp,32
 8d0:	e40c                	sd	a1,8(s0)
 8d2:	e810                	sd	a2,16(s0)
 8d4:	ec14                	sd	a3,24(s0)
 8d6:	f018                	sd	a4,32(s0)
 8d8:	f41c                	sd	a5,40(s0)
 8da:	03043823          	sd	a6,48(s0)
 8de:	03143c23          	sd	a7,56(s0)
  va_start(ap, fmt);
 8e2:	00840613          	add	a2,s0,8
 8e6:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 8ea:	85aa                	mv	a1,a0
 8ec:	4505                	li	a0,1
 8ee:	00000097          	auipc	ra,0x0
 8f2:	de0080e7          	jalr	-544(ra) # 6ce <vprintf>
}
 8f6:	60e2                	ld	ra,24(sp)
 8f8:	6442                	ld	s0,16(sp)
 8fa:	6125                	add	sp,sp,96
 8fc:	8082                	ret

00000000000008fe <snprintf>:

int
snprintf(char *buf, int sz, char *fmt, ...)
{
 8fe:	7135                	add	sp,sp,-160
 900:	f486                	sd	ra,104(sp)
 902:	f0a2                	sd	s0,96(sp)
 904:	eca6                	sd	s1,88(sp)
 906:	1880                	add	s0,sp,112
 908:	e414                	sd	a3,8(s0)
 90a:	e818                	sd	a4,16(s0)
 90c:	ec1c                	sd	a5,24(s0)
 90e:	03043023          	sd	a6,32(s0)
 912:	03143423          	sd	a7,40(s0)
  va_list ap;
  int i, c;
  int off = 0;
  char *s;

  if (fmt == 0)
 916:	16060b63          	beqz	a2,a8c <snprintf+0x18e>
 91a:	e8ca                	sd	s2,80(sp)
 91c:	e4ce                	sd	s3,72(sp)
 91e:	fc56                	sd	s5,56(sp)
 920:	f85a                	sd	s6,48(sp)
 922:	8b2a                	mv	s6,a0
 924:	8aae                	mv	s5,a1
 926:	89b2                	mv	s3,a2
    return -1;

  va_start(ap, fmt);
 928:	00840793          	add	a5,s0,8
 92c:	f8f43c23          	sd	a5,-104(s0)
  int off = 0;
 930:	4481                	li	s1,0
  for(i = 0; off < sz && (c = fmt[i] & 0xff) != 0; i++){
 932:	4901                	li	s2,0
 934:	00b05f63          	blez	a1,952 <snprintf+0x54>
 938:	e0d2                	sd	s4,64(sp)
 93a:	f45e                	sd	s7,40(sp)
 93c:	f062                	sd	s8,32(sp)
 93e:	ec66                	sd	s9,24(sp)
    if(c != '%'){
 940:	02500a13          	li	s4,37
      continue;
    }
    c = fmt[++i] & 0xff;
    if(c == 0)
      break;
    switch(c){
 944:	07300b93          	li	s7,115
 948:	07800c93          	li	s9,120
 94c:	06400c13          	li	s8,100
 950:	a839                	j	96e <snprintf+0x70>
      off += sputc(buf+off, '%');
      off += sputc(buf+off, c);
      break;
    }
  }
  return off;
 952:	4481                	li	s1,0
 954:	6946                	ld	s2,80(sp)
 956:	69a6                	ld	s3,72(sp)
 958:	7ae2                	ld	s5,56(sp)
 95a:	7b42                	ld	s6,48(sp)
 95c:	a0cd                	j	a3e <snprintf+0x140>
  *s = c;
 95e:	009b0733          	add	a4,s6,s1
 962:	00f70023          	sb	a5,0(a4)
      off += sputc(buf+off, c);
 966:	2485                	addw	s1,s1,1
  for(i = 0; off < sz && (c = fmt[i] & 0xff) != 0; i++){
 968:	2905                	addw	s2,s2,1
 96a:	1554d563          	bge	s1,s5,ab4 <snprintf+0x1b6>
 96e:	012987b3          	add	a5,s3,s2
 972:	0007c783          	lbu	a5,0(a5)
 976:	0007871b          	sext.w	a4,a5
 97a:	10078063          	beqz	a5,a7a <snprintf+0x17c>
    if(c != '%'){
 97e:	ff4710e3          	bne	a4,s4,95e <snprintf+0x60>
    c = fmt[++i] & 0xff;
 982:	2905                	addw	s2,s2,1
 984:	012987b3          	add	a5,s3,s2
 988:	0007c783          	lbu	a5,0(a5)
    if(c == 0)
 98c:	10078263          	beqz	a5,a90 <snprintf+0x192>
    switch(c){
 990:	05778c63          	beq	a5,s7,9e8 <snprintf+0xea>
 994:	02fbe763          	bltu	s7,a5,9c2 <snprintf+0xc4>
 998:	0d478063          	beq	a5,s4,a58 <snprintf+0x15a>
 99c:	0d879463          	bne	a5,s8,a64 <snprintf+0x166>
      off += sprintint(buf+off, va_arg(ap, int), 10, 1);
 9a0:	f9843783          	ld	a5,-104(s0)
 9a4:	00878713          	add	a4,a5,8
 9a8:	f8e43c23          	sd	a4,-104(s0)
 9ac:	4685                	li	a3,1
 9ae:	4629                	li	a2,10
 9b0:	438c                	lw	a1,0(a5)
 9b2:	009b0533          	add	a0,s6,s1
 9b6:	00000097          	auipc	ra,0x0
 9ba:	bb0080e7          	jalr	-1104(ra) # 566 <sprintint>
 9be:	9ca9                	addw	s1,s1,a0
      break;
 9c0:	b765                	j	968 <snprintf+0x6a>
    switch(c){
 9c2:	0b979163          	bne	a5,s9,a64 <snprintf+0x166>
      off += sprintint(buf+off, va_arg(ap, int), 16, 1);
 9c6:	f9843783          	ld	a5,-104(s0)
 9ca:	00878713          	add	a4,a5,8
 9ce:	f8e43c23          	sd	a4,-104(s0)
 9d2:	4685                	li	a3,1
 9d4:	4641                	li	a2,16
 9d6:	438c                	lw	a1,0(a5)
 9d8:	009b0533          	add	a0,s6,s1
 9dc:	00000097          	auipc	ra,0x0
 9e0:	b8a080e7          	jalr	-1142(ra) # 566 <sprintint>
 9e4:	9ca9                	addw	s1,s1,a0
      break;
 9e6:	b749                	j	968 <snprintf+0x6a>
      if((s = va_arg(ap, char*)) == 0)
 9e8:	f9843783          	ld	a5,-104(s0)
 9ec:	00878713          	add	a4,a5,8
 9f0:	f8e43c23          	sd	a4,-104(s0)
 9f4:	6388                	ld	a0,0(a5)
 9f6:	c931                	beqz	a0,a4a <snprintf+0x14c>
      for(; *s && off < sz; s++)
 9f8:	00054703          	lbu	a4,0(a0)
 9fc:	d735                	beqz	a4,968 <snprintf+0x6a>
 9fe:	0b54d263          	bge	s1,s5,aa2 <snprintf+0x1a4>
 a02:	009b06b3          	add	a3,s6,s1
 a06:	409a863b          	subw	a2,s5,s1
 a0a:	1602                	sll	a2,a2,0x20
 a0c:	9201                	srl	a2,a2,0x20
 a0e:	962a                	add	a2,a2,a0
 a10:	87aa                	mv	a5,a0
        off += sputc(buf+off, *s);
 a12:	0014859b          	addw	a1,s1,1
 a16:	9d89                	subw	a1,a1,a0
  *s = c;
 a18:	00e68023          	sb	a4,0(a3)
        off += sputc(buf+off, *s);
 a1c:	00f584bb          	addw	s1,a1,a5
      for(; *s && off < sz; s++)
 a20:	0785                	add	a5,a5,1
 a22:	0007c703          	lbu	a4,0(a5)
 a26:	d329                	beqz	a4,968 <snprintf+0x6a>
 a28:	0685                	add	a3,a3,1
 a2a:	fec797e3          	bne	a5,a2,a18 <snprintf+0x11a>
 a2e:	6946                	ld	s2,80(sp)
 a30:	69a6                	ld	s3,72(sp)
 a32:	6a06                	ld	s4,64(sp)
 a34:	7ae2                	ld	s5,56(sp)
 a36:	7b42                	ld	s6,48(sp)
 a38:	7ba2                	ld	s7,40(sp)
 a3a:	7c02                	ld	s8,32(sp)
 a3c:	6ce2                	ld	s9,24(sp)
 a3e:	8526                	mv	a0,s1
 a40:	70a6                	ld	ra,104(sp)
 a42:	7406                	ld	s0,96(sp)
 a44:	64e6                	ld	s1,88(sp)
 a46:	610d                	add	sp,sp,160
 a48:	8082                	ret
      for(; *s && off < sz; s++)
 a4a:	02800713          	li	a4,40
        s = "(null)";
 a4e:	00000517          	auipc	a0,0x0
 a52:	31250513          	add	a0,a0,786 # d60 <malloc+0x218>
 a56:	b765                	j	9fe <snprintf+0x100>
  *s = c;
 a58:	009b07b3          	add	a5,s6,s1
 a5c:	01478023          	sb	s4,0(a5)
      off += sputc(buf+off, '%');
 a60:	2485                	addw	s1,s1,1
      break;
 a62:	b719                	j	968 <snprintf+0x6a>
  *s = c;
 a64:	009b0733          	add	a4,s6,s1
 a68:	01470023          	sb	s4,0(a4)
      off += sputc(buf+off, c);
 a6c:	0014871b          	addw	a4,s1,1
  *s = c;
 a70:	975a                	add	a4,a4,s6
 a72:	00f70023          	sb	a5,0(a4)
      off += sputc(buf+off, c);
 a76:	2489                	addw	s1,s1,2
      break;
 a78:	bdc5                	j	968 <snprintf+0x6a>
 a7a:	6946                	ld	s2,80(sp)
 a7c:	69a6                	ld	s3,72(sp)
 a7e:	6a06                	ld	s4,64(sp)
 a80:	7ae2                	ld	s5,56(sp)
 a82:	7b42                	ld	s6,48(sp)
 a84:	7ba2                	ld	s7,40(sp)
 a86:	7c02                	ld	s8,32(sp)
 a88:	6ce2                	ld	s9,24(sp)
 a8a:	bf55                	j	a3e <snprintf+0x140>
    return -1;
 a8c:	54fd                	li	s1,-1
 a8e:	bf45                	j	a3e <snprintf+0x140>
 a90:	6946                	ld	s2,80(sp)
 a92:	69a6                	ld	s3,72(sp)
 a94:	6a06                	ld	s4,64(sp)
 a96:	7ae2                	ld	s5,56(sp)
 a98:	7b42                	ld	s6,48(sp)
 a9a:	7ba2                	ld	s7,40(sp)
 a9c:	7c02                	ld	s8,32(sp)
 a9e:	6ce2                	ld	s9,24(sp)
 aa0:	bf79                	j	a3e <snprintf+0x140>
 aa2:	6946                	ld	s2,80(sp)
 aa4:	69a6                	ld	s3,72(sp)
 aa6:	6a06                	ld	s4,64(sp)
 aa8:	7ae2                	ld	s5,56(sp)
 aaa:	7b42                	ld	s6,48(sp)
 aac:	7ba2                	ld	s7,40(sp)
 aae:	7c02                	ld	s8,32(sp)
 ab0:	6ce2                	ld	s9,24(sp)
 ab2:	b771                	j	a3e <snprintf+0x140>
 ab4:	6946                	ld	s2,80(sp)
 ab6:	69a6                	ld	s3,72(sp)
 ab8:	6a06                	ld	s4,64(sp)
 aba:	7ae2                	ld	s5,56(sp)
 abc:	7b42                	ld	s6,48(sp)
 abe:	7ba2                	ld	s7,40(sp)
 ac0:	7c02                	ld	s8,32(sp)
 ac2:	6ce2                	ld	s9,24(sp)
 ac4:	bfad                	j	a3e <snprintf+0x140>

0000000000000ac6 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 ac6:	1141                	add	sp,sp,-16
 ac8:	e422                	sd	s0,8(sp)
 aca:	0800                	add	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 acc:	ff050693          	add	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 ad0:	00000797          	auipc	a5,0x0
 ad4:	3087b783          	ld	a5,776(a5) # dd8 <freep>
 ad8:	a02d                	j	b02 <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 ada:	4618                	lw	a4,8(a2)
 adc:	9f2d                	addw	a4,a4,a1
 ade:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 ae2:	6398                	ld	a4,0(a5)
 ae4:	6310                	ld	a2,0(a4)
 ae6:	a83d                	j	b24 <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 ae8:	ff852703          	lw	a4,-8(a0)
 aec:	9f31                	addw	a4,a4,a2
 aee:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 af0:	ff053683          	ld	a3,-16(a0)
 af4:	a091                	j	b38 <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 af6:	6398                	ld	a4,0(a5)
 af8:	00e7e463          	bltu	a5,a4,b00 <free+0x3a>
 afc:	00e6ea63          	bltu	a3,a4,b10 <free+0x4a>
{
 b00:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 b02:	fed7fae3          	bgeu	a5,a3,af6 <free+0x30>
 b06:	6398                	ld	a4,0(a5)
 b08:	00e6e463          	bltu	a3,a4,b10 <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 b0c:	fee7eae3          	bltu	a5,a4,b00 <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 b10:	ff852583          	lw	a1,-8(a0)
 b14:	6390                	ld	a2,0(a5)
 b16:	02059813          	sll	a6,a1,0x20
 b1a:	01c85713          	srl	a4,a6,0x1c
 b1e:	9736                	add	a4,a4,a3
 b20:	fae60de3          	beq	a2,a4,ada <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 b24:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 b28:	4790                	lw	a2,8(a5)
 b2a:	02061593          	sll	a1,a2,0x20
 b2e:	01c5d713          	srl	a4,a1,0x1c
 b32:	973e                	add	a4,a4,a5
 b34:	fae68ae3          	beq	a3,a4,ae8 <free+0x22>
    p->s.ptr = bp->s.ptr;
 b38:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 b3a:	00000717          	auipc	a4,0x0
 b3e:	28f73f23          	sd	a5,670(a4) # dd8 <freep>
}
 b42:	6422                	ld	s0,8(sp)
 b44:	0141                	add	sp,sp,16
 b46:	8082                	ret

0000000000000b48 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 b48:	7139                	add	sp,sp,-64
 b4a:	fc06                	sd	ra,56(sp)
 b4c:	f822                	sd	s0,48(sp)
 b4e:	f426                	sd	s1,40(sp)
 b50:	ec4e                	sd	s3,24(sp)
 b52:	0080                	add	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 b54:	02051493          	sll	s1,a0,0x20
 b58:	9081                	srl	s1,s1,0x20
 b5a:	04bd                	add	s1,s1,15
 b5c:	8091                	srl	s1,s1,0x4
 b5e:	0014899b          	addw	s3,s1,1
 b62:	0485                	add	s1,s1,1
  if((prevp = freep) == 0){
 b64:	00000517          	auipc	a0,0x0
 b68:	27453503          	ld	a0,628(a0) # dd8 <freep>
 b6c:	c915                	beqz	a0,ba0 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 b6e:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 b70:	4798                	lw	a4,8(a5)
 b72:	08977e63          	bgeu	a4,s1,c0e <malloc+0xc6>
 b76:	f04a                	sd	s2,32(sp)
 b78:	e852                	sd	s4,16(sp)
 b7a:	e456                	sd	s5,8(sp)
 b7c:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 b7e:	8a4e                	mv	s4,s3
 b80:	0009871b          	sext.w	a4,s3
 b84:	6685                	lui	a3,0x1
 b86:	00d77363          	bgeu	a4,a3,b8c <malloc+0x44>
 b8a:	6a05                	lui	s4,0x1
 b8c:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 b90:	004a1a1b          	sllw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 b94:	00000917          	auipc	s2,0x0
 b98:	24490913          	add	s2,s2,580 # dd8 <freep>
  if(p == (char*)-1)
 b9c:	5afd                	li	s5,-1
 b9e:	a091                	j	be2 <malloc+0x9a>
 ba0:	f04a                	sd	s2,32(sp)
 ba2:	e852                	sd	s4,16(sp)
 ba4:	e456                	sd	s5,8(sp)
 ba6:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 ba8:	00000797          	auipc	a5,0x0
 bac:	23878793          	add	a5,a5,568 # de0 <base>
 bb0:	00000717          	auipc	a4,0x0
 bb4:	22f73423          	sd	a5,552(a4) # dd8 <freep>
 bb8:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 bba:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 bbe:	b7c1                	j	b7e <malloc+0x36>
        prevp->s.ptr = p->s.ptr;
 bc0:	6398                	ld	a4,0(a5)
 bc2:	e118                	sd	a4,0(a0)
 bc4:	a08d                	j	c26 <malloc+0xde>
  hp->s.size = nu;
 bc6:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 bca:	0541                	add	a0,a0,16
 bcc:	00000097          	auipc	ra,0x0
 bd0:	efa080e7          	jalr	-262(ra) # ac6 <free>
  return freep;
 bd4:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 bd8:	c13d                	beqz	a0,c3e <malloc+0xf6>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 bda:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 bdc:	4798                	lw	a4,8(a5)
 bde:	02977463          	bgeu	a4,s1,c06 <malloc+0xbe>
    if(p == freep)
 be2:	00093703          	ld	a4,0(s2)
 be6:	853e                	mv	a0,a5
 be8:	fef719e3          	bne	a4,a5,bda <malloc+0x92>
  p = sbrk(nu * sizeof(Header));
 bec:	8552                	mv	a0,s4
 bee:	00000097          	auipc	ra,0x0
 bf2:	92a080e7          	jalr	-1750(ra) # 518 <sbrk>
  if(p == (char*)-1)
 bf6:	fd5518e3          	bne	a0,s5,bc6 <malloc+0x7e>
        return 0;
 bfa:	4501                	li	a0,0
 bfc:	7902                	ld	s2,32(sp)
 bfe:	6a42                	ld	s4,16(sp)
 c00:	6aa2                	ld	s5,8(sp)
 c02:	6b02                	ld	s6,0(sp)
 c04:	a03d                	j	c32 <malloc+0xea>
 c06:	7902                	ld	s2,32(sp)
 c08:	6a42                	ld	s4,16(sp)
 c0a:	6aa2                	ld	s5,8(sp)
 c0c:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 c0e:	fae489e3          	beq	s1,a4,bc0 <malloc+0x78>
        p->s.size -= nunits;
 c12:	4137073b          	subw	a4,a4,s3
 c16:	c798                	sw	a4,8(a5)
        p += p->s.size;
 c18:	02071693          	sll	a3,a4,0x20
 c1c:	01c6d713          	srl	a4,a3,0x1c
 c20:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 c22:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 c26:	00000717          	auipc	a4,0x0
 c2a:	1aa73923          	sd	a0,434(a4) # dd8 <freep>
      return (void*)(p + 1);
 c2e:	01078513          	add	a0,a5,16
  }
}
 c32:	70e2                	ld	ra,56(sp)
 c34:	7442                	ld	s0,48(sp)
 c36:	74a2                	ld	s1,40(sp)
 c38:	69e2                	ld	s3,24(sp)
 c3a:	6121                	add	sp,sp,64
 c3c:	8082                	ret
 c3e:	7902                	ld	s2,32(sp)
 c40:	6a42                	ld	s4,16(sp)
 c42:	6aa2                	ld	s5,8(sp)
 c44:	6b02                	ld	s6,0(sp)
 c46:	b7f5                	j	c32 <malloc+0xea>
