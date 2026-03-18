
user/_init:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:

char *argv[] = { "sh", 0 };

int
main(void)
{
   0:	1101                	add	sp,sp,-32
   2:	ec06                	sd	ra,24(sp)
   4:	e822                	sd	s0,16(sp)
   6:	e426                	sd	s1,8(sp)
   8:	e04a                	sd	s2,0(sp)
   a:	1000                	add	s0,sp,32
  int pid, wpid;

  if(open("console", O_RDWR) < 0){
   c:	4589                	li	a1,2
   e:	00001517          	auipc	a0,0x1
  12:	b4250513          	add	a0,a0,-1214 # b50 <malloc+0x106>
  16:	00000097          	auipc	ra,0x0
  1a:	3bc080e7          	jalr	956(ra) # 3d2 <open>
  1e:	06054363          	bltz	a0,84 <main+0x84>
    mknod("console", CONSOLE, 0);
    open("console", O_RDWR);
  }
  dup(0);  // stdout
  22:	4501                	li	a0,0
  24:	00000097          	auipc	ra,0x0
  28:	3e6080e7          	jalr	998(ra) # 40a <dup>
  dup(0);  // stderr
  2c:	4501                	li	a0,0
  2e:	00000097          	auipc	ra,0x0
  32:	3dc080e7          	jalr	988(ra) # 40a <dup>

  for(;;){
    printf("init: starting sh\n");
  36:	00001917          	auipc	s2,0x1
  3a:	b2290913          	add	s2,s2,-1246 # b58 <malloc+0x10e>
  3e:	854a                	mv	a0,s2
  40:	00000097          	auipc	ra,0x0
  44:	78a080e7          	jalr	1930(ra) # 7ca <printf>
    pid = fork();
  48:	00000097          	auipc	ra,0x0
  4c:	342080e7          	jalr	834(ra) # 38a <fork>
  50:	84aa                	mv	s1,a0
    if(pid < 0){
  52:	04054d63          	bltz	a0,ac <main+0xac>
      printf("init: fork failed\n");
      exit(1);
    }
    if(pid == 0){
  56:	c925                	beqz	a0,c6 <main+0xc6>
    }

    for(;;){
      // this call to wait() returns if the shell exits,
      // or if a parentless process exits.
      wpid = wait((int *) 0);
  58:	4501                	li	a0,0
  5a:	00000097          	auipc	ra,0x0
  5e:	340080e7          	jalr	832(ra) # 39a <wait>
      if(wpid == pid){
  62:	fca48ee3          	beq	s1,a0,3e <main+0x3e>
        // the shell exited; restart it.
        break;
      } else if(wpid < 0){
  66:	fe0559e3          	bgez	a0,58 <main+0x58>
        printf("init: wait returned an error\n");
  6a:	00001517          	auipc	a0,0x1
  6e:	b3e50513          	add	a0,a0,-1218 # ba8 <malloc+0x15e>
  72:	00000097          	auipc	ra,0x0
  76:	758080e7          	jalr	1880(ra) # 7ca <printf>
        exit(1);
  7a:	4505                	li	a0,1
  7c:	00000097          	auipc	ra,0x0
  80:	316080e7          	jalr	790(ra) # 392 <exit>
    mknod("console", CONSOLE, 0);
  84:	4601                	li	a2,0
  86:	4585                	li	a1,1
  88:	00001517          	auipc	a0,0x1
  8c:	ac850513          	add	a0,a0,-1336 # b50 <malloc+0x106>
  90:	00000097          	auipc	ra,0x0
  94:	34a080e7          	jalr	842(ra) # 3da <mknod>
    open("console", O_RDWR);
  98:	4589                	li	a1,2
  9a:	00001517          	auipc	a0,0x1
  9e:	ab650513          	add	a0,a0,-1354 # b50 <malloc+0x106>
  a2:	00000097          	auipc	ra,0x0
  a6:	330080e7          	jalr	816(ra) # 3d2 <open>
  aa:	bfa5                	j	22 <main+0x22>
      printf("init: fork failed\n");
  ac:	00001517          	auipc	a0,0x1
  b0:	ac450513          	add	a0,a0,-1340 # b70 <malloc+0x126>
  b4:	00000097          	auipc	ra,0x0
  b8:	716080e7          	jalr	1814(ra) # 7ca <printf>
      exit(1);
  bc:	4505                	li	a0,1
  be:	00000097          	auipc	ra,0x0
  c2:	2d4080e7          	jalr	724(ra) # 392 <exit>
      exec("sh", argv);
  c6:	00001597          	auipc	a1,0x1
  ca:	b7a58593          	add	a1,a1,-1158 # c40 <argv>
  ce:	00001517          	auipc	a0,0x1
  d2:	aba50513          	add	a0,a0,-1350 # b88 <malloc+0x13e>
  d6:	00000097          	auipc	ra,0x0
  da:	2f4080e7          	jalr	756(ra) # 3ca <exec>
      printf("init: exec sh failed\n");
  de:	00001517          	auipc	a0,0x1
  e2:	ab250513          	add	a0,a0,-1358 # b90 <malloc+0x146>
  e6:	00000097          	auipc	ra,0x0
  ea:	6e4080e7          	jalr	1764(ra) # 7ca <printf>
      exit(1);
  ee:	4505                	li	a0,1
  f0:	00000097          	auipc	ra,0x0
  f4:	2a2080e7          	jalr	674(ra) # 392 <exit>

00000000000000f8 <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
  f8:	1141                	add	sp,sp,-16
  fa:	e422                	sd	s0,8(sp)
  fc:	0800                	add	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  fe:	87aa                	mv	a5,a0
 100:	0585                	add	a1,a1,1
 102:	0785                	add	a5,a5,1
 104:	fff5c703          	lbu	a4,-1(a1)
 108:	fee78fa3          	sb	a4,-1(a5)
 10c:	fb75                	bnez	a4,100 <strcpy+0x8>
    ;
  return os;
}
 10e:	6422                	ld	s0,8(sp)
 110:	0141                	add	sp,sp,16
 112:	8082                	ret

0000000000000114 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 114:	1141                	add	sp,sp,-16
 116:	e422                	sd	s0,8(sp)
 118:	0800                	add	s0,sp,16
  while(*p && *p == *q)
 11a:	00054783          	lbu	a5,0(a0)
 11e:	cb91                	beqz	a5,132 <strcmp+0x1e>
 120:	0005c703          	lbu	a4,0(a1)
 124:	00f71763          	bne	a4,a5,132 <strcmp+0x1e>
    p++, q++;
 128:	0505                	add	a0,a0,1
 12a:	0585                	add	a1,a1,1
  while(*p && *p == *q)
 12c:	00054783          	lbu	a5,0(a0)
 130:	fbe5                	bnez	a5,120 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 132:	0005c503          	lbu	a0,0(a1)
}
 136:	40a7853b          	subw	a0,a5,a0
 13a:	6422                	ld	s0,8(sp)
 13c:	0141                	add	sp,sp,16
 13e:	8082                	ret

0000000000000140 <strlen>:

uint
strlen(const char *s)
{
 140:	1141                	add	sp,sp,-16
 142:	e422                	sd	s0,8(sp)
 144:	0800                	add	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 146:	00054783          	lbu	a5,0(a0)
 14a:	cf91                	beqz	a5,166 <strlen+0x26>
 14c:	0505                	add	a0,a0,1
 14e:	87aa                	mv	a5,a0
 150:	86be                	mv	a3,a5
 152:	0785                	add	a5,a5,1
 154:	fff7c703          	lbu	a4,-1(a5)
 158:	ff65                	bnez	a4,150 <strlen+0x10>
 15a:	40a6853b          	subw	a0,a3,a0
 15e:	2505                	addw	a0,a0,1
    ;
  return n;
}
 160:	6422                	ld	s0,8(sp)
 162:	0141                	add	sp,sp,16
 164:	8082                	ret
  for(n = 0; s[n]; n++)
 166:	4501                	li	a0,0
 168:	bfe5                	j	160 <strlen+0x20>

000000000000016a <strcat>:

char *
strcat(char *dst, char *src)
{
 16a:	1141                	add	sp,sp,-16
 16c:	e422                	sd	s0,8(sp)
 16e:	0800                	add	s0,sp,16
  char *s = dst;
  while (*dst)
 170:	00054783          	lbu	a5,0(a0)
 174:	c385                	beqz	a5,194 <strcat+0x2a>
 176:	87aa                	mv	a5,a0
    dst++;
 178:	0785                	add	a5,a5,1
  while (*dst)
 17a:	0007c703          	lbu	a4,0(a5)
 17e:	ff6d                	bnez	a4,178 <strcat+0xe>
  while ((*dst++ = *src++) != 0);
 180:	0585                	add	a1,a1,1
 182:	0785                	add	a5,a5,1
 184:	fff5c703          	lbu	a4,-1(a1)
 188:	fee78fa3          	sb	a4,-1(a5)
 18c:	fb75                	bnez	a4,180 <strcat+0x16>

  return s;
}
 18e:	6422                	ld	s0,8(sp)
 190:	0141                	add	sp,sp,16
 192:	8082                	ret
  while (*dst)
 194:	87aa                	mv	a5,a0
 196:	b7ed                	j	180 <strcat+0x16>

0000000000000198 <memset>:

void*
memset(void *dst, int c, uint n)
{
 198:	1141                	add	sp,sp,-16
 19a:	e422                	sd	s0,8(sp)
 19c:	0800                	add	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 19e:	ca19                	beqz	a2,1b4 <memset+0x1c>
 1a0:	87aa                	mv	a5,a0
 1a2:	1602                	sll	a2,a2,0x20
 1a4:	9201                	srl	a2,a2,0x20
 1a6:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 1aa:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 1ae:	0785                	add	a5,a5,1
 1b0:	fee79de3          	bne	a5,a4,1aa <memset+0x12>
  }
  return dst;
}
 1b4:	6422                	ld	s0,8(sp)
 1b6:	0141                	add	sp,sp,16
 1b8:	8082                	ret

00000000000001ba <strchr>:

char*
strchr(const char *s, char c)
{
 1ba:	1141                	add	sp,sp,-16
 1bc:	e422                	sd	s0,8(sp)
 1be:	0800                	add	s0,sp,16
  for(; *s; s++)
 1c0:	00054783          	lbu	a5,0(a0)
 1c4:	cb99                	beqz	a5,1da <strchr+0x20>
    if(*s == c)
 1c6:	00f58763          	beq	a1,a5,1d4 <strchr+0x1a>
  for(; *s; s++)
 1ca:	0505                	add	a0,a0,1
 1cc:	00054783          	lbu	a5,0(a0)
 1d0:	fbfd                	bnez	a5,1c6 <strchr+0xc>
      return (char*)s;
  return 0;
 1d2:	4501                	li	a0,0
}
 1d4:	6422                	ld	s0,8(sp)
 1d6:	0141                	add	sp,sp,16
 1d8:	8082                	ret
  return 0;
 1da:	4501                	li	a0,0
 1dc:	bfe5                	j	1d4 <strchr+0x1a>

00000000000001de <gets>:

char*
gets(char *buf, int max)
{
 1de:	711d                	add	sp,sp,-96
 1e0:	ec86                	sd	ra,88(sp)
 1e2:	e8a2                	sd	s0,80(sp)
 1e4:	e4a6                	sd	s1,72(sp)
 1e6:	e0ca                	sd	s2,64(sp)
 1e8:	fc4e                	sd	s3,56(sp)
 1ea:	f852                	sd	s4,48(sp)
 1ec:	f456                	sd	s5,40(sp)
 1ee:	f05a                	sd	s6,32(sp)
 1f0:	ec5e                	sd	s7,24(sp)
 1f2:	1080                	add	s0,sp,96
 1f4:	8baa                	mv	s7,a0
 1f6:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1f8:	892a                	mv	s2,a0
 1fa:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 1fc:	4aa9                	li	s5,10
 1fe:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 200:	89a6                	mv	s3,s1
 202:	2485                	addw	s1,s1,1
 204:	0344d863          	bge	s1,s4,234 <gets+0x56>
    cc = read(0, &c, 1);
 208:	4605                	li	a2,1
 20a:	faf40593          	add	a1,s0,-81
 20e:	4501                	li	a0,0
 210:	00000097          	auipc	ra,0x0
 214:	19a080e7          	jalr	410(ra) # 3aa <read>
    if(cc < 1)
 218:	00a05e63          	blez	a0,234 <gets+0x56>
    buf[i++] = c;
 21c:	faf44783          	lbu	a5,-81(s0)
 220:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 224:	01578763          	beq	a5,s5,232 <gets+0x54>
 228:	0905                	add	s2,s2,1
 22a:	fd679be3          	bne	a5,s6,200 <gets+0x22>
    buf[i++] = c;
 22e:	89a6                	mv	s3,s1
 230:	a011                	j	234 <gets+0x56>
 232:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 234:	99de                	add	s3,s3,s7
 236:	00098023          	sb	zero,0(s3)
  return buf;
}
 23a:	855e                	mv	a0,s7
 23c:	60e6                	ld	ra,88(sp)
 23e:	6446                	ld	s0,80(sp)
 240:	64a6                	ld	s1,72(sp)
 242:	6906                	ld	s2,64(sp)
 244:	79e2                	ld	s3,56(sp)
 246:	7a42                	ld	s4,48(sp)
 248:	7aa2                	ld	s5,40(sp)
 24a:	7b02                	ld	s6,32(sp)
 24c:	6be2                	ld	s7,24(sp)
 24e:	6125                	add	sp,sp,96
 250:	8082                	ret

0000000000000252 <stat>:

int
stat(const char *n, struct stat *st)
{
 252:	1101                	add	sp,sp,-32
 254:	ec06                	sd	ra,24(sp)
 256:	e822                	sd	s0,16(sp)
 258:	e04a                	sd	s2,0(sp)
 25a:	1000                	add	s0,sp,32
 25c:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 25e:	4581                	li	a1,0
 260:	00000097          	auipc	ra,0x0
 264:	172080e7          	jalr	370(ra) # 3d2 <open>
  if(fd < 0)
 268:	02054663          	bltz	a0,294 <stat+0x42>
 26c:	e426                	sd	s1,8(sp)
 26e:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 270:	85ca                	mv	a1,s2
 272:	00000097          	auipc	ra,0x0
 276:	178080e7          	jalr	376(ra) # 3ea <fstat>
 27a:	892a                	mv	s2,a0
  close(fd);
 27c:	8526                	mv	a0,s1
 27e:	00000097          	auipc	ra,0x0
 282:	13c080e7          	jalr	316(ra) # 3ba <close>
  return r;
 286:	64a2                	ld	s1,8(sp)
}
 288:	854a                	mv	a0,s2
 28a:	60e2                	ld	ra,24(sp)
 28c:	6442                	ld	s0,16(sp)
 28e:	6902                	ld	s2,0(sp)
 290:	6105                	add	sp,sp,32
 292:	8082                	ret
    return -1;
 294:	597d                	li	s2,-1
 296:	bfcd                	j	288 <stat+0x36>

0000000000000298 <atoi>:

int
atoi(const char *s)
{
 298:	1141                	add	sp,sp,-16
 29a:	e422                	sd	s0,8(sp)
 29c:	0800                	add	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 29e:	00054683          	lbu	a3,0(a0)
 2a2:	fd06879b          	addw	a5,a3,-48
 2a6:	0ff7f793          	zext.b	a5,a5
 2aa:	4625                	li	a2,9
 2ac:	02f66863          	bltu	a2,a5,2dc <atoi+0x44>
 2b0:	872a                	mv	a4,a0
  n = 0;
 2b2:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 2b4:	0705                	add	a4,a4,1
 2b6:	0025179b          	sllw	a5,a0,0x2
 2ba:	9fa9                	addw	a5,a5,a0
 2bc:	0017979b          	sllw	a5,a5,0x1
 2c0:	9fb5                	addw	a5,a5,a3
 2c2:	fd07851b          	addw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 2c6:	00074683          	lbu	a3,0(a4)
 2ca:	fd06879b          	addw	a5,a3,-48
 2ce:	0ff7f793          	zext.b	a5,a5
 2d2:	fef671e3          	bgeu	a2,a5,2b4 <atoi+0x1c>
  return n;
}
 2d6:	6422                	ld	s0,8(sp)
 2d8:	0141                	add	sp,sp,16
 2da:	8082                	ret
  n = 0;
 2dc:	4501                	li	a0,0
 2de:	bfe5                	j	2d6 <atoi+0x3e>

00000000000002e0 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 2e0:	1141                	add	sp,sp,-16
 2e2:	e422                	sd	s0,8(sp)
 2e4:	0800                	add	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 2e6:	02b57463          	bgeu	a0,a1,30e <memmove+0x2e>
    while(n-- > 0)
 2ea:	00c05f63          	blez	a2,308 <memmove+0x28>
 2ee:	1602                	sll	a2,a2,0x20
 2f0:	9201                	srl	a2,a2,0x20
 2f2:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 2f6:	872a                	mv	a4,a0
      *dst++ = *src++;
 2f8:	0585                	add	a1,a1,1
 2fa:	0705                	add	a4,a4,1
 2fc:	fff5c683          	lbu	a3,-1(a1)
 300:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 304:	fef71ae3          	bne	a4,a5,2f8 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 308:	6422                	ld	s0,8(sp)
 30a:	0141                	add	sp,sp,16
 30c:	8082                	ret
    dst += n;
 30e:	00c50733          	add	a4,a0,a2
    src += n;
 312:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 314:	fec05ae3          	blez	a2,308 <memmove+0x28>
 318:	fff6079b          	addw	a5,a2,-1
 31c:	1782                	sll	a5,a5,0x20
 31e:	9381                	srl	a5,a5,0x20
 320:	fff7c793          	not	a5,a5
 324:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 326:	15fd                	add	a1,a1,-1
 328:	177d                	add	a4,a4,-1
 32a:	0005c683          	lbu	a3,0(a1)
 32e:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 332:	fee79ae3          	bne	a5,a4,326 <memmove+0x46>
 336:	bfc9                	j	308 <memmove+0x28>

0000000000000338 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 338:	1141                	add	sp,sp,-16
 33a:	e422                	sd	s0,8(sp)
 33c:	0800                	add	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 33e:	ca05                	beqz	a2,36e <memcmp+0x36>
 340:	fff6069b          	addw	a3,a2,-1
 344:	1682                	sll	a3,a3,0x20
 346:	9281                	srl	a3,a3,0x20
 348:	0685                	add	a3,a3,1
 34a:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 34c:	00054783          	lbu	a5,0(a0)
 350:	0005c703          	lbu	a4,0(a1)
 354:	00e79863          	bne	a5,a4,364 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 358:	0505                	add	a0,a0,1
    p2++;
 35a:	0585                	add	a1,a1,1
  while (n-- > 0) {
 35c:	fed518e3          	bne	a0,a3,34c <memcmp+0x14>
  }
  return 0;
 360:	4501                	li	a0,0
 362:	a019                	j	368 <memcmp+0x30>
      return *p1 - *p2;
 364:	40e7853b          	subw	a0,a5,a4
}
 368:	6422                	ld	s0,8(sp)
 36a:	0141                	add	sp,sp,16
 36c:	8082                	ret
  return 0;
 36e:	4501                	li	a0,0
 370:	bfe5                	j	368 <memcmp+0x30>

0000000000000372 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 372:	1141                	add	sp,sp,-16
 374:	e406                	sd	ra,8(sp)
 376:	e022                	sd	s0,0(sp)
 378:	0800                	add	s0,sp,16
  return memmove(dst, src, n);
 37a:	00000097          	auipc	ra,0x0
 37e:	f66080e7          	jalr	-154(ra) # 2e0 <memmove>
}
 382:	60a2                	ld	ra,8(sp)
 384:	6402                	ld	s0,0(sp)
 386:	0141                	add	sp,sp,16
 388:	8082                	ret

000000000000038a <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 38a:	4885                	li	a7,1
 ecall
 38c:	00000073          	ecall
 ret
 390:	8082                	ret

0000000000000392 <exit>:
.global exit
exit:
 li a7, SYS_exit
 392:	4889                	li	a7,2
 ecall
 394:	00000073          	ecall
 ret
 398:	8082                	ret

000000000000039a <wait>:
.global wait
wait:
 li a7, SYS_wait
 39a:	488d                	li	a7,3
 ecall
 39c:	00000073          	ecall
 ret
 3a0:	8082                	ret

00000000000003a2 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 3a2:	4891                	li	a7,4
 ecall
 3a4:	00000073          	ecall
 ret
 3a8:	8082                	ret

00000000000003aa <read>:
.global read
read:
 li a7, SYS_read
 3aa:	4895                	li	a7,5
 ecall
 3ac:	00000073          	ecall
 ret
 3b0:	8082                	ret

00000000000003b2 <write>:
.global write
write:
 li a7, SYS_write
 3b2:	48c1                	li	a7,16
 ecall
 3b4:	00000073          	ecall
 ret
 3b8:	8082                	ret

00000000000003ba <close>:
.global close
close:
 li a7, SYS_close
 3ba:	48d5                	li	a7,21
 ecall
 3bc:	00000073          	ecall
 ret
 3c0:	8082                	ret

00000000000003c2 <kill>:
.global kill
kill:
 li a7, SYS_kill
 3c2:	4899                	li	a7,6
 ecall
 3c4:	00000073          	ecall
 ret
 3c8:	8082                	ret

00000000000003ca <exec>:
.global exec
exec:
 li a7, SYS_exec
 3ca:	489d                	li	a7,7
 ecall
 3cc:	00000073          	ecall
 ret
 3d0:	8082                	ret

00000000000003d2 <open>:
.global open
open:
 li a7, SYS_open
 3d2:	48bd                	li	a7,15
 ecall
 3d4:	00000073          	ecall
 ret
 3d8:	8082                	ret

00000000000003da <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 3da:	48c5                	li	a7,17
 ecall
 3dc:	00000073          	ecall
 ret
 3e0:	8082                	ret

00000000000003e2 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 3e2:	48c9                	li	a7,18
 ecall
 3e4:	00000073          	ecall
 ret
 3e8:	8082                	ret

00000000000003ea <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 3ea:	48a1                	li	a7,8
 ecall
 3ec:	00000073          	ecall
 ret
 3f0:	8082                	ret

00000000000003f2 <link>:
.global link
link:
 li a7, SYS_link
 3f2:	48cd                	li	a7,19
 ecall
 3f4:	00000073          	ecall
 ret
 3f8:	8082                	ret

00000000000003fa <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 3fa:	48d1                	li	a7,20
 ecall
 3fc:	00000073          	ecall
 ret
 400:	8082                	ret

0000000000000402 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 402:	48a5                	li	a7,9
 ecall
 404:	00000073          	ecall
 ret
 408:	8082                	ret

000000000000040a <dup>:
.global dup
dup:
 li a7, SYS_dup
 40a:	48a9                	li	a7,10
 ecall
 40c:	00000073          	ecall
 ret
 410:	8082                	ret

0000000000000412 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 412:	48ad                	li	a7,11
 ecall
 414:	00000073          	ecall
 ret
 418:	8082                	ret

000000000000041a <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 41a:	48b1                	li	a7,12
 ecall
 41c:	00000073          	ecall
 ret
 420:	8082                	ret

0000000000000422 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 422:	48b5                	li	a7,13
 ecall
 424:	00000073          	ecall
 ret
 428:	8082                	ret

000000000000042a <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 42a:	48b9                	li	a7,14
 ecall
 42c:	00000073          	ecall
 ret
 430:	8082                	ret

0000000000000432 <uconnect>:
.global uconnect
uconnect:
 li a7, SYS_uconnect
 432:	48f5                	li	a7,29
 ecall
 434:	00000073          	ecall
 ret
 438:	8082                	ret

000000000000043a <socket>:
.global socket
socket:
 li a7, SYS_socket
 43a:	48f9                	li	a7,30
 ecall
 43c:	00000073          	ecall
 ret
 440:	8082                	ret

0000000000000442 <bind>:
.global bind
bind:
 li a7, SYS_bind
 442:	48fd                	li	a7,31
 ecall
 444:	00000073          	ecall
 ret
 448:	8082                	ret

000000000000044a <listen>:
.global listen
listen:
 li a7, SYS_listen
 44a:	02000893          	li	a7,32
 ecall
 44e:	00000073          	ecall
 ret
 452:	8082                	ret

0000000000000454 <accept>:
.global accept
accept:
 li a7, SYS_accept
 454:	02100893          	li	a7,33
 ecall
 458:	00000073          	ecall
 ret
 45c:	8082                	ret

000000000000045e <connect>:
.global connect
connect:
 li a7, SYS_connect
 45e:	02200893          	li	a7,34
 ecall
 462:	00000073          	ecall
 ret
 466:	8082                	ret

0000000000000468 <sprintint>:
  return 1;
}

static int
sprintint(char *s, int xx, int base, int sign)
{
 468:	1101                	add	sp,sp,-32
 46a:	ec22                	sd	s0,24(sp)
 46c:	1000                	add	s0,sp,32
 46e:	882a                	mv	a6,a0
  char buf[16];
  int i, n;
  uint x;

  if(sign && (sign = xx < 0))
 470:	c299                	beqz	a3,476 <sprintint+0xe>
 472:	0805c263          	bltz	a1,4f6 <sprintint+0x8e>
    x = -xx;
  else
    x = xx;
 476:	2581                	sext.w	a1,a1
 478:	4301                	li	t1,0

  i = 0;
 47a:	fe040713          	add	a4,s0,-32
 47e:	4501                	li	a0,0
  do {
    buf[i++] = digits[x % base];
 480:	2601                	sext.w	a2,a2
 482:	00000697          	auipc	a3,0x0
 486:	7a668693          	add	a3,a3,1958 # c28 <digits>
 48a:	88aa                	mv	a7,a0
 48c:	2505                	addw	a0,a0,1
 48e:	02c5f7bb          	remuw	a5,a1,a2
 492:	1782                	sll	a5,a5,0x20
 494:	9381                	srl	a5,a5,0x20
 496:	97b6                	add	a5,a5,a3
 498:	0007c783          	lbu	a5,0(a5)
 49c:	00f70023          	sb	a5,0(a4)
  } while((x /= base) != 0);
 4a0:	0005879b          	sext.w	a5,a1
 4a4:	02c5d5bb          	divuw	a1,a1,a2
 4a8:	0705                	add	a4,a4,1
 4aa:	fec7f0e3          	bgeu	a5,a2,48a <sprintint+0x22>

  if(sign)
 4ae:	00030b63          	beqz	t1,4c4 <sprintint+0x5c>
    buf[i++] = '-';
 4b2:	ff050793          	add	a5,a0,-16
 4b6:	97a2                	add	a5,a5,s0
 4b8:	02d00713          	li	a4,45
 4bc:	fee78823          	sb	a4,-16(a5)
 4c0:	0028851b          	addw	a0,a7,2

  n = 0;
  while(--i >= 0)
 4c4:	02a05d63          	blez	a0,4fe <sprintint+0x96>
 4c8:	fe040793          	add	a5,s0,-32
 4cc:	00a78733          	add	a4,a5,a0
 4d0:	87c2                	mv	a5,a6
 4d2:	00180613          	add	a2,a6,1
 4d6:	fff5069b          	addw	a3,a0,-1
 4da:	1682                	sll	a3,a3,0x20
 4dc:	9281                	srl	a3,a3,0x20
 4de:	9636                	add	a2,a2,a3
  *s = c;
 4e0:	fff74683          	lbu	a3,-1(a4)
 4e4:	00d78023          	sb	a3,0(a5)
  while(--i >= 0)
 4e8:	177d                	add	a4,a4,-1
 4ea:	0785                	add	a5,a5,1
 4ec:	fec79ae3          	bne	a5,a2,4e0 <sprintint+0x78>
    n += sputc(s+n, buf[i]);
  return n;
}
 4f0:	6462                	ld	s0,24(sp)
 4f2:	6105                	add	sp,sp,32
 4f4:	8082                	ret
    x = -xx;
 4f6:	40b005bb          	negw	a1,a1
  if(sign && (sign = xx < 0))
 4fa:	4305                	li	t1,1
    x = -xx;
 4fc:	bfbd                	j	47a <sprintint+0x12>
  while(--i >= 0)
 4fe:	4501                	li	a0,0
 500:	bfc5                	j	4f0 <sprintint+0x88>

0000000000000502 <putc>:
{
 502:	1101                	add	sp,sp,-32
 504:	ec06                	sd	ra,24(sp)
 506:	e822                	sd	s0,16(sp)
 508:	1000                	add	s0,sp,32
 50a:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 50e:	4605                	li	a2,1
 510:	fef40593          	add	a1,s0,-17
 514:	00000097          	auipc	ra,0x0
 518:	e9e080e7          	jalr	-354(ra) # 3b2 <write>
}
 51c:	60e2                	ld	ra,24(sp)
 51e:	6442                	ld	s0,16(sp)
 520:	6105                	add	sp,sp,32
 522:	8082                	ret

0000000000000524 <printint>:
{
 524:	7139                	add	sp,sp,-64
 526:	fc06                	sd	ra,56(sp)
 528:	f822                	sd	s0,48(sp)
 52a:	f426                	sd	s1,40(sp)
 52c:	0080                	add	s0,sp,64
 52e:	84aa                	mv	s1,a0
  if(sgn && xx < 0){
 530:	c299                	beqz	a3,536 <printint+0x12>
 532:	0805cb63          	bltz	a1,5c8 <printint+0xa4>
    x = xx;
 536:	2581                	sext.w	a1,a1
  neg = 0;
 538:	4881                	li	a7,0
 53a:	fc040693          	add	a3,s0,-64
  i = 0;
 53e:	4701                	li	a4,0
    buf[i++] = digits[x % base];
 540:	2601                	sext.w	a2,a2
 542:	00000517          	auipc	a0,0x0
 546:	6e650513          	add	a0,a0,1766 # c28 <digits>
 54a:	883a                	mv	a6,a4
 54c:	2705                	addw	a4,a4,1
 54e:	02c5f7bb          	remuw	a5,a1,a2
 552:	1782                	sll	a5,a5,0x20
 554:	9381                	srl	a5,a5,0x20
 556:	97aa                	add	a5,a5,a0
 558:	0007c783          	lbu	a5,0(a5)
 55c:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 560:	0005879b          	sext.w	a5,a1
 564:	02c5d5bb          	divuw	a1,a1,a2
 568:	0685                	add	a3,a3,1
 56a:	fec7f0e3          	bgeu	a5,a2,54a <printint+0x26>
  if(neg)
 56e:	00088c63          	beqz	a7,586 <printint+0x62>
    buf[i++] = '-';
 572:	fd070793          	add	a5,a4,-48
 576:	00878733          	add	a4,a5,s0
 57a:	02d00793          	li	a5,45
 57e:	fef70823          	sb	a5,-16(a4)
 582:	0028071b          	addw	a4,a6,2
  while(--i >= 0)
 586:	02e05c63          	blez	a4,5be <printint+0x9a>
 58a:	f04a                	sd	s2,32(sp)
 58c:	ec4e                	sd	s3,24(sp)
 58e:	fc040793          	add	a5,s0,-64
 592:	00e78933          	add	s2,a5,a4
 596:	fff78993          	add	s3,a5,-1
 59a:	99ba                	add	s3,s3,a4
 59c:	377d                	addw	a4,a4,-1
 59e:	1702                	sll	a4,a4,0x20
 5a0:	9301                	srl	a4,a4,0x20
 5a2:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 5a6:	fff94583          	lbu	a1,-1(s2)
 5aa:	8526                	mv	a0,s1
 5ac:	00000097          	auipc	ra,0x0
 5b0:	f56080e7          	jalr	-170(ra) # 502 <putc>
  while(--i >= 0)
 5b4:	197d                	add	s2,s2,-1
 5b6:	ff3918e3          	bne	s2,s3,5a6 <printint+0x82>
 5ba:	7902                	ld	s2,32(sp)
 5bc:	69e2                	ld	s3,24(sp)
}
 5be:	70e2                	ld	ra,56(sp)
 5c0:	7442                	ld	s0,48(sp)
 5c2:	74a2                	ld	s1,40(sp)
 5c4:	6121                	add	sp,sp,64
 5c6:	8082                	ret
    x = -xx;
 5c8:	40b005bb          	negw	a1,a1
    neg = 1;
 5cc:	4885                	li	a7,1
    x = -xx;
 5ce:	b7b5                	j	53a <printint+0x16>

00000000000005d0 <vprintf>:
{
 5d0:	715d                	add	sp,sp,-80
 5d2:	e486                	sd	ra,72(sp)
 5d4:	e0a2                	sd	s0,64(sp)
 5d6:	f84a                	sd	s2,48(sp)
 5d8:	0880                	add	s0,sp,80
  for(i = 0; fmt[i]; i++){
 5da:	0005c903          	lbu	s2,0(a1)
 5de:	1a090a63          	beqz	s2,792 <vprintf+0x1c2>
 5e2:	fc26                	sd	s1,56(sp)
 5e4:	f44e                	sd	s3,40(sp)
 5e6:	f052                	sd	s4,32(sp)
 5e8:	ec56                	sd	s5,24(sp)
 5ea:	e85a                	sd	s6,16(sp)
 5ec:	e45e                	sd	s7,8(sp)
 5ee:	8aaa                	mv	s5,a0
 5f0:	8bb2                	mv	s7,a2
 5f2:	00158493          	add	s1,a1,1
  state = 0;
 5f6:	4981                	li	s3,0
    } else if(state == '%'){
 5f8:	02500a13          	li	s4,37
 5fc:	4b55                	li	s6,21
 5fe:	a839                	j	61c <vprintf+0x4c>
        putc(fd, c);
 600:	85ca                	mv	a1,s2
 602:	8556                	mv	a0,s5
 604:	00000097          	auipc	ra,0x0
 608:	efe080e7          	jalr	-258(ra) # 502 <putc>
 60c:	a019                	j	612 <vprintf+0x42>
    } else if(state == '%'){
 60e:	01498d63          	beq	s3,s4,628 <vprintf+0x58>
  for(i = 0; fmt[i]; i++){
 612:	0485                	add	s1,s1,1
 614:	fff4c903          	lbu	s2,-1(s1)
 618:	16090763          	beqz	s2,786 <vprintf+0x1b6>
    if(state == 0){
 61c:	fe0999e3          	bnez	s3,60e <vprintf+0x3e>
      if(c == '%'){
 620:	ff4910e3          	bne	s2,s4,600 <vprintf+0x30>
        state = '%';
 624:	89d2                	mv	s3,s4
 626:	b7f5                	j	612 <vprintf+0x42>
      if(c == 'd'){
 628:	13490463          	beq	s2,s4,750 <vprintf+0x180>
 62c:	f9d9079b          	addw	a5,s2,-99
 630:	0ff7f793          	zext.b	a5,a5
 634:	12fb6763          	bltu	s6,a5,762 <vprintf+0x192>
 638:	f9d9079b          	addw	a5,s2,-99
 63c:	0ff7f713          	zext.b	a4,a5
 640:	12eb6163          	bltu	s6,a4,762 <vprintf+0x192>
 644:	00271793          	sll	a5,a4,0x2
 648:	00000717          	auipc	a4,0x0
 64c:	58870713          	add	a4,a4,1416 # bd0 <malloc+0x186>
 650:	97ba                	add	a5,a5,a4
 652:	439c                	lw	a5,0(a5)
 654:	97ba                	add	a5,a5,a4
 656:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 658:	008b8913          	add	s2,s7,8
 65c:	4685                	li	a3,1
 65e:	4629                	li	a2,10
 660:	000ba583          	lw	a1,0(s7)
 664:	8556                	mv	a0,s5
 666:	00000097          	auipc	ra,0x0
 66a:	ebe080e7          	jalr	-322(ra) # 524 <printint>
 66e:	8bca                	mv	s7,s2
      state = 0;
 670:	4981                	li	s3,0
 672:	b745                	j	612 <vprintf+0x42>
        printint(fd, va_arg(ap, uint64), 10, 0);
 674:	008b8913          	add	s2,s7,8
 678:	4681                	li	a3,0
 67a:	4629                	li	a2,10
 67c:	000ba583          	lw	a1,0(s7)
 680:	8556                	mv	a0,s5
 682:	00000097          	auipc	ra,0x0
 686:	ea2080e7          	jalr	-350(ra) # 524 <printint>
 68a:	8bca                	mv	s7,s2
      state = 0;
 68c:	4981                	li	s3,0
 68e:	b751                	j	612 <vprintf+0x42>
        printint(fd, va_arg(ap, int), 16, 0);
 690:	008b8913          	add	s2,s7,8
 694:	4681                	li	a3,0
 696:	4641                	li	a2,16
 698:	000ba583          	lw	a1,0(s7)
 69c:	8556                	mv	a0,s5
 69e:	00000097          	auipc	ra,0x0
 6a2:	e86080e7          	jalr	-378(ra) # 524 <printint>
 6a6:	8bca                	mv	s7,s2
      state = 0;
 6a8:	4981                	li	s3,0
 6aa:	b7a5                	j	612 <vprintf+0x42>
 6ac:	e062                	sd	s8,0(sp)
        printptr(fd, va_arg(ap, uint64));
 6ae:	008b8c13          	add	s8,s7,8
 6b2:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 6b6:	03000593          	li	a1,48
 6ba:	8556                	mv	a0,s5
 6bc:	00000097          	auipc	ra,0x0
 6c0:	e46080e7          	jalr	-442(ra) # 502 <putc>
  putc(fd, 'x');
 6c4:	07800593          	li	a1,120
 6c8:	8556                	mv	a0,s5
 6ca:	00000097          	auipc	ra,0x0
 6ce:	e38080e7          	jalr	-456(ra) # 502 <putc>
 6d2:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 6d4:	00000b97          	auipc	s7,0x0
 6d8:	554b8b93          	add	s7,s7,1364 # c28 <digits>
 6dc:	03c9d793          	srl	a5,s3,0x3c
 6e0:	97de                	add	a5,a5,s7
 6e2:	0007c583          	lbu	a1,0(a5)
 6e6:	8556                	mv	a0,s5
 6e8:	00000097          	auipc	ra,0x0
 6ec:	e1a080e7          	jalr	-486(ra) # 502 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 6f0:	0992                	sll	s3,s3,0x4
 6f2:	397d                	addw	s2,s2,-1
 6f4:	fe0914e3          	bnez	s2,6dc <vprintf+0x10c>
        printptr(fd, va_arg(ap, uint64));
 6f8:	8be2                	mv	s7,s8
      state = 0;
 6fa:	4981                	li	s3,0
 6fc:	6c02                	ld	s8,0(sp)
 6fe:	bf11                	j	612 <vprintf+0x42>
        s = va_arg(ap, char*);
 700:	008b8993          	add	s3,s7,8
 704:	000bb903          	ld	s2,0(s7)
        if(s == 0)
 708:	02090163          	beqz	s2,72a <vprintf+0x15a>
        while(*s != 0){
 70c:	00094583          	lbu	a1,0(s2)
 710:	c9a5                	beqz	a1,780 <vprintf+0x1b0>
          putc(fd, *s);
 712:	8556                	mv	a0,s5
 714:	00000097          	auipc	ra,0x0
 718:	dee080e7          	jalr	-530(ra) # 502 <putc>
          s++;
 71c:	0905                	add	s2,s2,1
        while(*s != 0){
 71e:	00094583          	lbu	a1,0(s2)
 722:	f9e5                	bnez	a1,712 <vprintf+0x142>
        s = va_arg(ap, char*);
 724:	8bce                	mv	s7,s3
      state = 0;
 726:	4981                	li	s3,0
 728:	b5ed                	j	612 <vprintf+0x42>
          s = "(null)";
 72a:	00000917          	auipc	s2,0x0
 72e:	49e90913          	add	s2,s2,1182 # bc8 <malloc+0x17e>
        while(*s != 0){
 732:	02800593          	li	a1,40
 736:	bff1                	j	712 <vprintf+0x142>
        putc(fd, va_arg(ap, uint));
 738:	008b8913          	add	s2,s7,8
 73c:	000bc583          	lbu	a1,0(s7)
 740:	8556                	mv	a0,s5
 742:	00000097          	auipc	ra,0x0
 746:	dc0080e7          	jalr	-576(ra) # 502 <putc>
 74a:	8bca                	mv	s7,s2
      state = 0;
 74c:	4981                	li	s3,0
 74e:	b5d1                	j	612 <vprintf+0x42>
        putc(fd, c);
 750:	02500593          	li	a1,37
 754:	8556                	mv	a0,s5
 756:	00000097          	auipc	ra,0x0
 75a:	dac080e7          	jalr	-596(ra) # 502 <putc>
      state = 0;
 75e:	4981                	li	s3,0
 760:	bd4d                	j	612 <vprintf+0x42>
        putc(fd, '%');
 762:	02500593          	li	a1,37
 766:	8556                	mv	a0,s5
 768:	00000097          	auipc	ra,0x0
 76c:	d9a080e7          	jalr	-614(ra) # 502 <putc>
        putc(fd, c);
 770:	85ca                	mv	a1,s2
 772:	8556                	mv	a0,s5
 774:	00000097          	auipc	ra,0x0
 778:	d8e080e7          	jalr	-626(ra) # 502 <putc>
      state = 0;
 77c:	4981                	li	s3,0
 77e:	bd51                	j	612 <vprintf+0x42>
        s = va_arg(ap, char*);
 780:	8bce                	mv	s7,s3
      state = 0;
 782:	4981                	li	s3,0
 784:	b579                	j	612 <vprintf+0x42>
 786:	74e2                	ld	s1,56(sp)
 788:	79a2                	ld	s3,40(sp)
 78a:	7a02                	ld	s4,32(sp)
 78c:	6ae2                	ld	s5,24(sp)
 78e:	6b42                	ld	s6,16(sp)
 790:	6ba2                	ld	s7,8(sp)
}
 792:	60a6                	ld	ra,72(sp)
 794:	6406                	ld	s0,64(sp)
 796:	7942                	ld	s2,48(sp)
 798:	6161                	add	sp,sp,80
 79a:	8082                	ret

000000000000079c <fprintf>:
{
 79c:	715d                	add	sp,sp,-80
 79e:	ec06                	sd	ra,24(sp)
 7a0:	e822                	sd	s0,16(sp)
 7a2:	1000                	add	s0,sp,32
 7a4:	e010                	sd	a2,0(s0)
 7a6:	e414                	sd	a3,8(s0)
 7a8:	e818                	sd	a4,16(s0)
 7aa:	ec1c                	sd	a5,24(s0)
 7ac:	03043023          	sd	a6,32(s0)
 7b0:	03143423          	sd	a7,40(s0)
  va_start(ap, fmt);
 7b4:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 7b8:	8622                	mv	a2,s0
 7ba:	00000097          	auipc	ra,0x0
 7be:	e16080e7          	jalr	-490(ra) # 5d0 <vprintf>
}
 7c2:	60e2                	ld	ra,24(sp)
 7c4:	6442                	ld	s0,16(sp)
 7c6:	6161                	add	sp,sp,80
 7c8:	8082                	ret

00000000000007ca <printf>:
{
 7ca:	711d                	add	sp,sp,-96
 7cc:	ec06                	sd	ra,24(sp)
 7ce:	e822                	sd	s0,16(sp)
 7d0:	1000                	add	s0,sp,32
 7d2:	e40c                	sd	a1,8(s0)
 7d4:	e810                	sd	a2,16(s0)
 7d6:	ec14                	sd	a3,24(s0)
 7d8:	f018                	sd	a4,32(s0)
 7da:	f41c                	sd	a5,40(s0)
 7dc:	03043823          	sd	a6,48(s0)
 7e0:	03143c23          	sd	a7,56(s0)
  va_start(ap, fmt);
 7e4:	00840613          	add	a2,s0,8
 7e8:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 7ec:	85aa                	mv	a1,a0
 7ee:	4505                	li	a0,1
 7f0:	00000097          	auipc	ra,0x0
 7f4:	de0080e7          	jalr	-544(ra) # 5d0 <vprintf>
}
 7f8:	60e2                	ld	ra,24(sp)
 7fa:	6442                	ld	s0,16(sp)
 7fc:	6125                	add	sp,sp,96
 7fe:	8082                	ret

0000000000000800 <snprintf>:

int
snprintf(char *buf, int sz, char *fmt, ...)
{
 800:	7135                	add	sp,sp,-160
 802:	f486                	sd	ra,104(sp)
 804:	f0a2                	sd	s0,96(sp)
 806:	eca6                	sd	s1,88(sp)
 808:	1880                	add	s0,sp,112
 80a:	e414                	sd	a3,8(s0)
 80c:	e818                	sd	a4,16(s0)
 80e:	ec1c                	sd	a5,24(s0)
 810:	03043023          	sd	a6,32(s0)
 814:	03143423          	sd	a7,40(s0)
  va_list ap;
  int i, c;
  int off = 0;
  char *s;

  if (fmt == 0)
 818:	16060b63          	beqz	a2,98e <snprintf+0x18e>
 81c:	e8ca                	sd	s2,80(sp)
 81e:	e4ce                	sd	s3,72(sp)
 820:	fc56                	sd	s5,56(sp)
 822:	f85a                	sd	s6,48(sp)
 824:	8b2a                	mv	s6,a0
 826:	8aae                	mv	s5,a1
 828:	89b2                	mv	s3,a2
    return -1;

  va_start(ap, fmt);
 82a:	00840793          	add	a5,s0,8
 82e:	f8f43c23          	sd	a5,-104(s0)
  int off = 0;
 832:	4481                	li	s1,0
  for(i = 0; off < sz && (c = fmt[i] & 0xff) != 0; i++){
 834:	4901                	li	s2,0
 836:	00b05f63          	blez	a1,854 <snprintf+0x54>
 83a:	e0d2                	sd	s4,64(sp)
 83c:	f45e                	sd	s7,40(sp)
 83e:	f062                	sd	s8,32(sp)
 840:	ec66                	sd	s9,24(sp)
    if(c != '%'){
 842:	02500a13          	li	s4,37
      continue;
    }
    c = fmt[++i] & 0xff;
    if(c == 0)
      break;
    switch(c){
 846:	07300b93          	li	s7,115
 84a:	07800c93          	li	s9,120
 84e:	06400c13          	li	s8,100
 852:	a839                	j	870 <snprintf+0x70>
      off += sputc(buf+off, '%');
      off += sputc(buf+off, c);
      break;
    }
  }
  return off;
 854:	4481                	li	s1,0
 856:	6946                	ld	s2,80(sp)
 858:	69a6                	ld	s3,72(sp)
 85a:	7ae2                	ld	s5,56(sp)
 85c:	7b42                	ld	s6,48(sp)
 85e:	a0cd                	j	940 <snprintf+0x140>
  *s = c;
 860:	009b0733          	add	a4,s6,s1
 864:	00f70023          	sb	a5,0(a4)
      off += sputc(buf+off, c);
 868:	2485                	addw	s1,s1,1
  for(i = 0; off < sz && (c = fmt[i] & 0xff) != 0; i++){
 86a:	2905                	addw	s2,s2,1
 86c:	1554d563          	bge	s1,s5,9b6 <snprintf+0x1b6>
 870:	012987b3          	add	a5,s3,s2
 874:	0007c783          	lbu	a5,0(a5)
 878:	0007871b          	sext.w	a4,a5
 87c:	10078063          	beqz	a5,97c <snprintf+0x17c>
    if(c != '%'){
 880:	ff4710e3          	bne	a4,s4,860 <snprintf+0x60>
    c = fmt[++i] & 0xff;
 884:	2905                	addw	s2,s2,1
 886:	012987b3          	add	a5,s3,s2
 88a:	0007c783          	lbu	a5,0(a5)
    if(c == 0)
 88e:	10078263          	beqz	a5,992 <snprintf+0x192>
    switch(c){
 892:	05778c63          	beq	a5,s7,8ea <snprintf+0xea>
 896:	02fbe763          	bltu	s7,a5,8c4 <snprintf+0xc4>
 89a:	0d478063          	beq	a5,s4,95a <snprintf+0x15a>
 89e:	0d879463          	bne	a5,s8,966 <snprintf+0x166>
      off += sprintint(buf+off, va_arg(ap, int), 10, 1);
 8a2:	f9843783          	ld	a5,-104(s0)
 8a6:	00878713          	add	a4,a5,8
 8aa:	f8e43c23          	sd	a4,-104(s0)
 8ae:	4685                	li	a3,1
 8b0:	4629                	li	a2,10
 8b2:	438c                	lw	a1,0(a5)
 8b4:	009b0533          	add	a0,s6,s1
 8b8:	00000097          	auipc	ra,0x0
 8bc:	bb0080e7          	jalr	-1104(ra) # 468 <sprintint>
 8c0:	9ca9                	addw	s1,s1,a0
      break;
 8c2:	b765                	j	86a <snprintf+0x6a>
    switch(c){
 8c4:	0b979163          	bne	a5,s9,966 <snprintf+0x166>
      off += sprintint(buf+off, va_arg(ap, int), 16, 1);
 8c8:	f9843783          	ld	a5,-104(s0)
 8cc:	00878713          	add	a4,a5,8
 8d0:	f8e43c23          	sd	a4,-104(s0)
 8d4:	4685                	li	a3,1
 8d6:	4641                	li	a2,16
 8d8:	438c                	lw	a1,0(a5)
 8da:	009b0533          	add	a0,s6,s1
 8de:	00000097          	auipc	ra,0x0
 8e2:	b8a080e7          	jalr	-1142(ra) # 468 <sprintint>
 8e6:	9ca9                	addw	s1,s1,a0
      break;
 8e8:	b749                	j	86a <snprintf+0x6a>
      if((s = va_arg(ap, char*)) == 0)
 8ea:	f9843783          	ld	a5,-104(s0)
 8ee:	00878713          	add	a4,a5,8
 8f2:	f8e43c23          	sd	a4,-104(s0)
 8f6:	6388                	ld	a0,0(a5)
 8f8:	c931                	beqz	a0,94c <snprintf+0x14c>
      for(; *s && off < sz; s++)
 8fa:	00054703          	lbu	a4,0(a0)
 8fe:	d735                	beqz	a4,86a <snprintf+0x6a>
 900:	0b54d263          	bge	s1,s5,9a4 <snprintf+0x1a4>
 904:	009b06b3          	add	a3,s6,s1
 908:	409a863b          	subw	a2,s5,s1
 90c:	1602                	sll	a2,a2,0x20
 90e:	9201                	srl	a2,a2,0x20
 910:	962a                	add	a2,a2,a0
 912:	87aa                	mv	a5,a0
        off += sputc(buf+off, *s);
 914:	0014859b          	addw	a1,s1,1
 918:	9d89                	subw	a1,a1,a0
  *s = c;
 91a:	00e68023          	sb	a4,0(a3)
        off += sputc(buf+off, *s);
 91e:	00f584bb          	addw	s1,a1,a5
      for(; *s && off < sz; s++)
 922:	0785                	add	a5,a5,1
 924:	0007c703          	lbu	a4,0(a5)
 928:	d329                	beqz	a4,86a <snprintf+0x6a>
 92a:	0685                	add	a3,a3,1
 92c:	fec797e3          	bne	a5,a2,91a <snprintf+0x11a>
 930:	6946                	ld	s2,80(sp)
 932:	69a6                	ld	s3,72(sp)
 934:	6a06                	ld	s4,64(sp)
 936:	7ae2                	ld	s5,56(sp)
 938:	7b42                	ld	s6,48(sp)
 93a:	7ba2                	ld	s7,40(sp)
 93c:	7c02                	ld	s8,32(sp)
 93e:	6ce2                	ld	s9,24(sp)
 940:	8526                	mv	a0,s1
 942:	70a6                	ld	ra,104(sp)
 944:	7406                	ld	s0,96(sp)
 946:	64e6                	ld	s1,88(sp)
 948:	610d                	add	sp,sp,160
 94a:	8082                	ret
      for(; *s && off < sz; s++)
 94c:	02800713          	li	a4,40
        s = "(null)";
 950:	00000517          	auipc	a0,0x0
 954:	27850513          	add	a0,a0,632 # bc8 <malloc+0x17e>
 958:	b765                	j	900 <snprintf+0x100>
  *s = c;
 95a:	009b07b3          	add	a5,s6,s1
 95e:	01478023          	sb	s4,0(a5)
      off += sputc(buf+off, '%');
 962:	2485                	addw	s1,s1,1
      break;
 964:	b719                	j	86a <snprintf+0x6a>
  *s = c;
 966:	009b0733          	add	a4,s6,s1
 96a:	01470023          	sb	s4,0(a4)
      off += sputc(buf+off, c);
 96e:	0014871b          	addw	a4,s1,1
  *s = c;
 972:	975a                	add	a4,a4,s6
 974:	00f70023          	sb	a5,0(a4)
      off += sputc(buf+off, c);
 978:	2489                	addw	s1,s1,2
      break;
 97a:	bdc5                	j	86a <snprintf+0x6a>
 97c:	6946                	ld	s2,80(sp)
 97e:	69a6                	ld	s3,72(sp)
 980:	6a06                	ld	s4,64(sp)
 982:	7ae2                	ld	s5,56(sp)
 984:	7b42                	ld	s6,48(sp)
 986:	7ba2                	ld	s7,40(sp)
 988:	7c02                	ld	s8,32(sp)
 98a:	6ce2                	ld	s9,24(sp)
 98c:	bf55                	j	940 <snprintf+0x140>
    return -1;
 98e:	54fd                	li	s1,-1
 990:	bf45                	j	940 <snprintf+0x140>
 992:	6946                	ld	s2,80(sp)
 994:	69a6                	ld	s3,72(sp)
 996:	6a06                	ld	s4,64(sp)
 998:	7ae2                	ld	s5,56(sp)
 99a:	7b42                	ld	s6,48(sp)
 99c:	7ba2                	ld	s7,40(sp)
 99e:	7c02                	ld	s8,32(sp)
 9a0:	6ce2                	ld	s9,24(sp)
 9a2:	bf79                	j	940 <snprintf+0x140>
 9a4:	6946                	ld	s2,80(sp)
 9a6:	69a6                	ld	s3,72(sp)
 9a8:	6a06                	ld	s4,64(sp)
 9aa:	7ae2                	ld	s5,56(sp)
 9ac:	7b42                	ld	s6,48(sp)
 9ae:	7ba2                	ld	s7,40(sp)
 9b0:	7c02                	ld	s8,32(sp)
 9b2:	6ce2                	ld	s9,24(sp)
 9b4:	b771                	j	940 <snprintf+0x140>
 9b6:	6946                	ld	s2,80(sp)
 9b8:	69a6                	ld	s3,72(sp)
 9ba:	6a06                	ld	s4,64(sp)
 9bc:	7ae2                	ld	s5,56(sp)
 9be:	7b42                	ld	s6,48(sp)
 9c0:	7ba2                	ld	s7,40(sp)
 9c2:	7c02                	ld	s8,32(sp)
 9c4:	6ce2                	ld	s9,24(sp)
 9c6:	bfad                	j	940 <snprintf+0x140>

00000000000009c8 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 9c8:	1141                	add	sp,sp,-16
 9ca:	e422                	sd	s0,8(sp)
 9cc:	0800                	add	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 9ce:	ff050693          	add	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 9d2:	00000797          	auipc	a5,0x0
 9d6:	27e7b783          	ld	a5,638(a5) # c50 <freep>
 9da:	a02d                	j	a04 <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 9dc:	4618                	lw	a4,8(a2)
 9de:	9f2d                	addw	a4,a4,a1
 9e0:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 9e4:	6398                	ld	a4,0(a5)
 9e6:	6310                	ld	a2,0(a4)
 9e8:	a83d                	j	a26 <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 9ea:	ff852703          	lw	a4,-8(a0)
 9ee:	9f31                	addw	a4,a4,a2
 9f0:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 9f2:	ff053683          	ld	a3,-16(a0)
 9f6:	a091                	j	a3a <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 9f8:	6398                	ld	a4,0(a5)
 9fa:	00e7e463          	bltu	a5,a4,a02 <free+0x3a>
 9fe:	00e6ea63          	bltu	a3,a4,a12 <free+0x4a>
{
 a02:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 a04:	fed7fae3          	bgeu	a5,a3,9f8 <free+0x30>
 a08:	6398                	ld	a4,0(a5)
 a0a:	00e6e463          	bltu	a3,a4,a12 <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 a0e:	fee7eae3          	bltu	a5,a4,a02 <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 a12:	ff852583          	lw	a1,-8(a0)
 a16:	6390                	ld	a2,0(a5)
 a18:	02059813          	sll	a6,a1,0x20
 a1c:	01c85713          	srl	a4,a6,0x1c
 a20:	9736                	add	a4,a4,a3
 a22:	fae60de3          	beq	a2,a4,9dc <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 a26:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 a2a:	4790                	lw	a2,8(a5)
 a2c:	02061593          	sll	a1,a2,0x20
 a30:	01c5d713          	srl	a4,a1,0x1c
 a34:	973e                	add	a4,a4,a5
 a36:	fae68ae3          	beq	a3,a4,9ea <free+0x22>
    p->s.ptr = bp->s.ptr;
 a3a:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 a3c:	00000717          	auipc	a4,0x0
 a40:	20f73a23          	sd	a5,532(a4) # c50 <freep>
}
 a44:	6422                	ld	s0,8(sp)
 a46:	0141                	add	sp,sp,16
 a48:	8082                	ret

0000000000000a4a <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 a4a:	7139                	add	sp,sp,-64
 a4c:	fc06                	sd	ra,56(sp)
 a4e:	f822                	sd	s0,48(sp)
 a50:	f426                	sd	s1,40(sp)
 a52:	ec4e                	sd	s3,24(sp)
 a54:	0080                	add	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 a56:	02051493          	sll	s1,a0,0x20
 a5a:	9081                	srl	s1,s1,0x20
 a5c:	04bd                	add	s1,s1,15
 a5e:	8091                	srl	s1,s1,0x4
 a60:	0014899b          	addw	s3,s1,1
 a64:	0485                	add	s1,s1,1
  if((prevp = freep) == 0){
 a66:	00000517          	auipc	a0,0x0
 a6a:	1ea53503          	ld	a0,490(a0) # c50 <freep>
 a6e:	c915                	beqz	a0,aa2 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a70:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 a72:	4798                	lw	a4,8(a5)
 a74:	08977e63          	bgeu	a4,s1,b10 <malloc+0xc6>
 a78:	f04a                	sd	s2,32(sp)
 a7a:	e852                	sd	s4,16(sp)
 a7c:	e456                	sd	s5,8(sp)
 a7e:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 a80:	8a4e                	mv	s4,s3
 a82:	0009871b          	sext.w	a4,s3
 a86:	6685                	lui	a3,0x1
 a88:	00d77363          	bgeu	a4,a3,a8e <malloc+0x44>
 a8c:	6a05                	lui	s4,0x1
 a8e:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 a92:	004a1a1b          	sllw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 a96:	00000917          	auipc	s2,0x0
 a9a:	1ba90913          	add	s2,s2,442 # c50 <freep>
  if(p == (char*)-1)
 a9e:	5afd                	li	s5,-1
 aa0:	a091                	j	ae4 <malloc+0x9a>
 aa2:	f04a                	sd	s2,32(sp)
 aa4:	e852                	sd	s4,16(sp)
 aa6:	e456                	sd	s5,8(sp)
 aa8:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 aaa:	00000797          	auipc	a5,0x0
 aae:	1ae78793          	add	a5,a5,430 # c58 <base>
 ab2:	00000717          	auipc	a4,0x0
 ab6:	18f73f23          	sd	a5,414(a4) # c50 <freep>
 aba:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 abc:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 ac0:	b7c1                	j	a80 <malloc+0x36>
        prevp->s.ptr = p->s.ptr;
 ac2:	6398                	ld	a4,0(a5)
 ac4:	e118                	sd	a4,0(a0)
 ac6:	a08d                	j	b28 <malloc+0xde>
  hp->s.size = nu;
 ac8:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 acc:	0541                	add	a0,a0,16
 ace:	00000097          	auipc	ra,0x0
 ad2:	efa080e7          	jalr	-262(ra) # 9c8 <free>
  return freep;
 ad6:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 ada:	c13d                	beqz	a0,b40 <malloc+0xf6>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 adc:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 ade:	4798                	lw	a4,8(a5)
 ae0:	02977463          	bgeu	a4,s1,b08 <malloc+0xbe>
    if(p == freep)
 ae4:	00093703          	ld	a4,0(s2)
 ae8:	853e                	mv	a0,a5
 aea:	fef719e3          	bne	a4,a5,adc <malloc+0x92>
  p = sbrk(nu * sizeof(Header));
 aee:	8552                	mv	a0,s4
 af0:	00000097          	auipc	ra,0x0
 af4:	92a080e7          	jalr	-1750(ra) # 41a <sbrk>
  if(p == (char*)-1)
 af8:	fd5518e3          	bne	a0,s5,ac8 <malloc+0x7e>
        return 0;
 afc:	4501                	li	a0,0
 afe:	7902                	ld	s2,32(sp)
 b00:	6a42                	ld	s4,16(sp)
 b02:	6aa2                	ld	s5,8(sp)
 b04:	6b02                	ld	s6,0(sp)
 b06:	a03d                	j	b34 <malloc+0xea>
 b08:	7902                	ld	s2,32(sp)
 b0a:	6a42                	ld	s4,16(sp)
 b0c:	6aa2                	ld	s5,8(sp)
 b0e:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 b10:	fae489e3          	beq	s1,a4,ac2 <malloc+0x78>
        p->s.size -= nunits;
 b14:	4137073b          	subw	a4,a4,s3
 b18:	c798                	sw	a4,8(a5)
        p += p->s.size;
 b1a:	02071693          	sll	a3,a4,0x20
 b1e:	01c6d713          	srl	a4,a3,0x1c
 b22:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 b24:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 b28:	00000717          	auipc	a4,0x0
 b2c:	12a73423          	sd	a0,296(a4) # c50 <freep>
      return (void*)(p + 1);
 b30:	01078513          	add	a0,a5,16
  }
}
 b34:	70e2                	ld	ra,56(sp)
 b36:	7442                	ld	s0,48(sp)
 b38:	74a2                	ld	s1,40(sp)
 b3a:	69e2                	ld	s3,24(sp)
 b3c:	6121                	add	sp,sp,64
 b3e:	8082                	ret
 b40:	7902                	ld	s2,32(sp)
 b42:	6a42                	ld	s4,16(sp)
 b44:	6aa2                	ld	s5,8(sp)
 b46:	6b02                	ld	s6,0(sp)
 b48:	b7f5                	j	b34 <malloc+0xea>
