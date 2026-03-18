
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
  12:	aa250513          	add	a0,a0,-1374 # ab0 <malloc+0x102>
  16:	4b4000ef          	jal	4ca <open>
  1a:	04054563          	bltz	a0,64 <main+0x64>
    mknod("console", CONSOLE, 0);
    open("console", O_RDWR);
  }
  dup(0);  // stdout
  1e:	4501                	li	a0,0
  20:	4e2000ef          	jal	502 <dup>
  dup(0);  // stderr
  24:	4501                	li	a0,0
  26:	4dc000ef          	jal	502 <dup>

  for(;;){
    printf("init: starting sh\n");
  2a:	00001917          	auipc	s2,0x1
  2e:	a8e90913          	add	s2,s2,-1394 # ab8 <malloc+0x10a>
  32:	854a                	mv	a0,s2
  34:	0c7000ef          	jal	8fa <printf>
    pid = fork();
  38:	44a000ef          	jal	482 <fork>
  3c:	84aa                	mv	s1,a0
    if(pid < 0){
  3e:	04054363          	bltz	a0,84 <main+0x84>
      printf("init: fork failed\n");
      exit(1);
    }
    if(pid == 0){
  42:	c931                	beqz	a0,96 <main+0x96>
    }

    for(;;){
      // this call to wait() returns if the shell exits,
      // or if a parentless process exits.
      wpid = wait((int *) 0);
  44:	4501                	li	a0,0
  46:	44c000ef          	jal	492 <wait>
      if(wpid == pid){
  4a:	fea484e3          	beq	s1,a0,32 <main+0x32>
        // the shell exited; restart it.
        break;
      } else if(wpid < 0){
  4e:	fe055be3          	bgez	a0,44 <main+0x44>
        printf("init: wait returned an error\n");
  52:	00001517          	auipc	a0,0x1
  56:	ab650513          	add	a0,a0,-1354 # b08 <malloc+0x15a>
  5a:	0a1000ef          	jal	8fa <printf>
        exit(1);
  5e:	4505                	li	a0,1
  60:	42a000ef          	jal	48a <exit>
    mknod("console", CONSOLE, 0);
  64:	4601                	li	a2,0
  66:	4585                	li	a1,1
  68:	00001517          	auipc	a0,0x1
  6c:	a4850513          	add	a0,a0,-1464 # ab0 <malloc+0x102>
  70:	462000ef          	jal	4d2 <mknod>
    open("console", O_RDWR);
  74:	4589                	li	a1,2
  76:	00001517          	auipc	a0,0x1
  7a:	a3a50513          	add	a0,a0,-1478 # ab0 <malloc+0x102>
  7e:	44c000ef          	jal	4ca <open>
  82:	bf71                	j	1e <main+0x1e>
      printf("init: fork failed\n");
  84:	00001517          	auipc	a0,0x1
  88:	a4c50513          	add	a0,a0,-1460 # ad0 <malloc+0x122>
  8c:	06f000ef          	jal	8fa <printf>
      exit(1);
  90:	4505                	li	a0,1
  92:	3f8000ef          	jal	48a <exit>
      exec("sh", argv);
  96:	00001597          	auipc	a1,0x1
  9a:	f6a58593          	add	a1,a1,-150 # 1000 <argv>
  9e:	00001517          	auipc	a0,0x1
  a2:	a4a50513          	add	a0,a0,-1462 # ae8 <malloc+0x13a>
  a6:	41c000ef          	jal	4c2 <exec>
      printf("init: exec sh failed\n");
  aa:	00001517          	auipc	a0,0x1
  ae:	a4650513          	add	a0,a0,-1466 # af0 <malloc+0x142>
  b2:	049000ef          	jal	8fa <printf>
      exit(1);
  b6:	4505                	li	a0,1
  b8:	3d2000ef          	jal	48a <exit>

00000000000000bc <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start(int argc, char **argv)
{
  bc:	1141                	add	sp,sp,-16
  be:	e406                	sd	ra,8(sp)
  c0:	e022                	sd	s0,0(sp)
  c2:	0800                	add	s0,sp,16
  int r;
  extern int main(int argc, char **argv);
  r = main(argc, argv);
  c4:	f3dff0ef          	jal	0 <main>
  exit(r);
  c8:	3c2000ef          	jal	48a <exit>

00000000000000cc <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
  cc:	1141                	add	sp,sp,-16
  ce:	e422                	sd	s0,8(sp)
  d0:	0800                	add	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  d2:	87aa                	mv	a5,a0
  d4:	0585                	add	a1,a1,1
  d6:	0785                	add	a5,a5,1
  d8:	fff5c703          	lbu	a4,-1(a1)
  dc:	fee78fa3          	sb	a4,-1(a5)
  e0:	fb75                	bnez	a4,d4 <strcpy+0x8>
    ;
  return os;
}
  e2:	6422                	ld	s0,8(sp)
  e4:	0141                	add	sp,sp,16
  e6:	8082                	ret

00000000000000e8 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  e8:	1141                	add	sp,sp,-16
  ea:	e422                	sd	s0,8(sp)
  ec:	0800                	add	s0,sp,16
  while(*p && *p == *q)
  ee:	00054783          	lbu	a5,0(a0)
  f2:	cb91                	beqz	a5,106 <strcmp+0x1e>
  f4:	0005c703          	lbu	a4,0(a1)
  f8:	00f71763          	bne	a4,a5,106 <strcmp+0x1e>
    p++, q++;
  fc:	0505                	add	a0,a0,1
  fe:	0585                	add	a1,a1,1
  while(*p && *p == *q)
 100:	00054783          	lbu	a5,0(a0)
 104:	fbe5                	bnez	a5,f4 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 106:	0005c503          	lbu	a0,0(a1)
}
 10a:	40a7853b          	subw	a0,a5,a0
 10e:	6422                	ld	s0,8(sp)
 110:	0141                	add	sp,sp,16
 112:	8082                	ret

0000000000000114 <strncmp>:

int
strncmp(const char *p, const char *q, uint n)
{
 114:	1141                	add	sp,sp,-16
 116:	e422                	sd	s0,8(sp)
 118:	0800                	add	s0,sp,16
  while(n > 0 && *p && *p == *q) {
 11a:	ce11                	beqz	a2,136 <strncmp+0x22>
 11c:	00054783          	lbu	a5,0(a0)
 120:	cf89                	beqz	a5,13a <strncmp+0x26>
 122:	0005c703          	lbu	a4,0(a1)
 126:	00f71a63          	bne	a4,a5,13a <strncmp+0x26>
    p++, q++, n--;
 12a:	0505                	add	a0,a0,1
 12c:	0585                	add	a1,a1,1
 12e:	367d                	addw	a2,a2,-1
  while(n > 0 && *p && *p == *q) {
 130:	f675                	bnez	a2,11c <strncmp+0x8>
  }
  if (n == 0)
    return 0;
 132:	4501                	li	a0,0
 134:	a801                	j	144 <strncmp+0x30>
 136:	4501                	li	a0,0
 138:	a031                	j	144 <strncmp+0x30>
  return (uchar)*p - (uchar)*q;
 13a:	00054503          	lbu	a0,0(a0)
 13e:	0005c783          	lbu	a5,0(a1)
 142:	9d1d                	subw	a0,a0,a5
}
 144:	6422                	ld	s0,8(sp)
 146:	0141                	add	sp,sp,16
 148:	8082                	ret

000000000000014a <strcat>:

char*
strcat(char *dst, const char *src)
{
 14a:	1141                	add	sp,sp,-16
 14c:	e422                	sd	s0,8(sp)
 14e:	0800                	add	s0,sp,16
  char *p = dst;
  while(*p) p++;
 150:	00054783          	lbu	a5,0(a0)
 154:	c385                	beqz	a5,174 <strcat+0x2a>
  char *p = dst;
 156:	87aa                	mv	a5,a0
  while(*p) p++;
 158:	0785                	add	a5,a5,1
 15a:	0007c703          	lbu	a4,0(a5)
 15e:	ff6d                	bnez	a4,158 <strcat+0xe>
  while((*p++ = *src++) != 0);
 160:	0585                	add	a1,a1,1
 162:	0785                	add	a5,a5,1
 164:	fff5c703          	lbu	a4,-1(a1)
 168:	fee78fa3          	sb	a4,-1(a5)
 16c:	fb75                	bnez	a4,160 <strcat+0x16>
  return dst;
}
 16e:	6422                	ld	s0,8(sp)
 170:	0141                	add	sp,sp,16
 172:	8082                	ret
  char *p = dst;
 174:	87aa                	mv	a5,a0
 176:	b7ed                	j	160 <strcat+0x16>

0000000000000178 <strncpy>:

char*
strncpy(char *dst, const char *src, int n)
{
 178:	1141                	add	sp,sp,-16
 17a:	e422                	sd	s0,8(sp)
 17c:	0800                	add	s0,sp,16
  char *p = dst;
 17e:	87aa                	mv	a5,a0
  while(n > 0 && *src) {
 180:	02c05463          	blez	a2,1a8 <strncpy+0x30>
 184:	0005c703          	lbu	a4,0(a1)
 188:	cb01                	beqz	a4,198 <strncpy+0x20>
    *p++ = *src++;
 18a:	0585                	add	a1,a1,1
 18c:	0785                	add	a5,a5,1
 18e:	fee78fa3          	sb	a4,-1(a5)
    n--;
 192:	367d                	addw	a2,a2,-1
  while(n > 0 && *src) {
 194:	fa65                	bnez	a2,184 <strncpy+0xc>
 196:	a809                	j	1a8 <strncpy+0x30>
  }
  while(n > 0) {
 198:	1602                	sll	a2,a2,0x20
 19a:	9201                	srl	a2,a2,0x20
 19c:	963e                	add	a2,a2,a5
    *p++ = 0;
 19e:	0785                	add	a5,a5,1
 1a0:	fe078fa3          	sb	zero,-1(a5)
  while(n > 0) {
 1a4:	fec79de3          	bne	a5,a2,19e <strncpy+0x26>
    n--;
  }
  return dst;
}
 1a8:	6422                	ld	s0,8(sp)
 1aa:	0141                	add	sp,sp,16
 1ac:	8082                	ret

00000000000001ae <strlen>:

uint
strlen(const char *s)
{
 1ae:	1141                	add	sp,sp,-16
 1b0:	e422                	sd	s0,8(sp)
 1b2:	0800                	add	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 1b4:	00054783          	lbu	a5,0(a0)
 1b8:	cf91                	beqz	a5,1d4 <strlen+0x26>
 1ba:	0505                	add	a0,a0,1
 1bc:	87aa                	mv	a5,a0
 1be:	86be                	mv	a3,a5
 1c0:	0785                	add	a5,a5,1
 1c2:	fff7c703          	lbu	a4,-1(a5)
 1c6:	ff65                	bnez	a4,1be <strlen+0x10>
 1c8:	40a6853b          	subw	a0,a3,a0
 1cc:	2505                	addw	a0,a0,1
    ;
  return n;
}
 1ce:	6422                	ld	s0,8(sp)
 1d0:	0141                	add	sp,sp,16
 1d2:	8082                	ret
  for(n = 0; s[n]; n++)
 1d4:	4501                	li	a0,0
 1d6:	bfe5                	j	1ce <strlen+0x20>

00000000000001d8 <memset>:

void*
memset(void *dst, int c, uint n)
{
 1d8:	1141                	add	sp,sp,-16
 1da:	e422                	sd	s0,8(sp)
 1dc:	0800                	add	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 1de:	ca19                	beqz	a2,1f4 <memset+0x1c>
 1e0:	87aa                	mv	a5,a0
 1e2:	1602                	sll	a2,a2,0x20
 1e4:	9201                	srl	a2,a2,0x20
 1e6:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 1ea:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 1ee:	0785                	add	a5,a5,1
 1f0:	fee79de3          	bne	a5,a4,1ea <memset+0x12>
  }
  return dst;
}
 1f4:	6422                	ld	s0,8(sp)
 1f6:	0141                	add	sp,sp,16
 1f8:	8082                	ret

00000000000001fa <strchr>:

char*
strchr(const char *s, char c)
{
 1fa:	1141                	add	sp,sp,-16
 1fc:	e422                	sd	s0,8(sp)
 1fe:	0800                	add	s0,sp,16
  for(; *s; s++)
 200:	00054783          	lbu	a5,0(a0)
 204:	cb99                	beqz	a5,21a <strchr+0x20>
    if(*s == c)
 206:	00f58763          	beq	a1,a5,214 <strchr+0x1a>
  for(; *s; s++)
 20a:	0505                	add	a0,a0,1
 20c:	00054783          	lbu	a5,0(a0)
 210:	fbfd                	bnez	a5,206 <strchr+0xc>
      return (char*)s;
  return 0;
 212:	4501                	li	a0,0
}
 214:	6422                	ld	s0,8(sp)
 216:	0141                	add	sp,sp,16
 218:	8082                	ret
  return 0;
 21a:	4501                	li	a0,0
 21c:	bfe5                	j	214 <strchr+0x1a>

000000000000021e <gets>:

char*
gets(char *buf, int max)
{
 21e:	711d                	add	sp,sp,-96
 220:	ec86                	sd	ra,88(sp)
 222:	e8a2                	sd	s0,80(sp)
 224:	e4a6                	sd	s1,72(sp)
 226:	e0ca                	sd	s2,64(sp)
 228:	fc4e                	sd	s3,56(sp)
 22a:	f852                	sd	s4,48(sp)
 22c:	f456                	sd	s5,40(sp)
 22e:	f05a                	sd	s6,32(sp)
 230:	ec5e                	sd	s7,24(sp)
 232:	1080                	add	s0,sp,96
 234:	8baa                	mv	s7,a0
 236:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 238:	892a                	mv	s2,a0
 23a:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 23c:	4aa9                	li	s5,10
 23e:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 240:	89a6                	mv	s3,s1
 242:	2485                	addw	s1,s1,1
 244:	0344d663          	bge	s1,s4,270 <gets+0x52>
    cc = read(0, &c, 1);
 248:	4605                	li	a2,1
 24a:	faf40593          	add	a1,s0,-81
 24e:	4501                	li	a0,0
 250:	252000ef          	jal	4a2 <read>
    if(cc < 1)
 254:	00a05e63          	blez	a0,270 <gets+0x52>
    buf[i++] = c;
 258:	faf44783          	lbu	a5,-81(s0)
 25c:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 260:	01578763          	beq	a5,s5,26e <gets+0x50>
 264:	0905                	add	s2,s2,1
 266:	fd679de3          	bne	a5,s6,240 <gets+0x22>
    buf[i++] = c;
 26a:	89a6                	mv	s3,s1
 26c:	a011                	j	270 <gets+0x52>
 26e:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 270:	99de                	add	s3,s3,s7
 272:	00098023          	sb	zero,0(s3)
  return buf;
}
 276:	855e                	mv	a0,s7
 278:	60e6                	ld	ra,88(sp)
 27a:	6446                	ld	s0,80(sp)
 27c:	64a6                	ld	s1,72(sp)
 27e:	6906                	ld	s2,64(sp)
 280:	79e2                	ld	s3,56(sp)
 282:	7a42                	ld	s4,48(sp)
 284:	7aa2                	ld	s5,40(sp)
 286:	7b02                	ld	s6,32(sp)
 288:	6be2                	ld	s7,24(sp)
 28a:	6125                	add	sp,sp,96
 28c:	8082                	ret

000000000000028e <stat>:

int
stat(const char *n, struct stat *st)
{
 28e:	1101                	add	sp,sp,-32
 290:	ec06                	sd	ra,24(sp)
 292:	e822                	sd	s0,16(sp)
 294:	e04a                	sd	s2,0(sp)
 296:	1000                	add	s0,sp,32
 298:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 29a:	4581                	li	a1,0
 29c:	22e000ef          	jal	4ca <open>
  if(fd < 0)
 2a0:	02054263          	bltz	a0,2c4 <stat+0x36>
 2a4:	e426                	sd	s1,8(sp)
 2a6:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 2a8:	85ca                	mv	a1,s2
 2aa:	238000ef          	jal	4e2 <fstat>
 2ae:	892a                	mv	s2,a0
  close(fd);
 2b0:	8526                	mv	a0,s1
 2b2:	200000ef          	jal	4b2 <close>
  return r;
 2b6:	64a2                	ld	s1,8(sp)
}
 2b8:	854a                	mv	a0,s2
 2ba:	60e2                	ld	ra,24(sp)
 2bc:	6442                	ld	s0,16(sp)
 2be:	6902                	ld	s2,0(sp)
 2c0:	6105                	add	sp,sp,32
 2c2:	8082                	ret
    return -1;
 2c4:	597d                	li	s2,-1
 2c6:	bfcd                	j	2b8 <stat+0x2a>

00000000000002c8 <atoi>:

int
atoi(const char *s)
{
 2c8:	1141                	add	sp,sp,-16
 2ca:	e422                	sd	s0,8(sp)
 2cc:	0800                	add	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 2ce:	00054683          	lbu	a3,0(a0)
 2d2:	fd06879b          	addw	a5,a3,-48
 2d6:	0ff7f793          	zext.b	a5,a5
 2da:	4625                	li	a2,9
 2dc:	02f66863          	bltu	a2,a5,30c <atoi+0x44>
 2e0:	872a                	mv	a4,a0
  n = 0;
 2e2:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 2e4:	0705                	add	a4,a4,1
 2e6:	0025179b          	sllw	a5,a0,0x2
 2ea:	9fa9                	addw	a5,a5,a0
 2ec:	0017979b          	sllw	a5,a5,0x1
 2f0:	9fb5                	addw	a5,a5,a3
 2f2:	fd07851b          	addw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 2f6:	00074683          	lbu	a3,0(a4)
 2fa:	fd06879b          	addw	a5,a3,-48
 2fe:	0ff7f793          	zext.b	a5,a5
 302:	fef671e3          	bgeu	a2,a5,2e4 <atoi+0x1c>
  return n;
}
 306:	6422                	ld	s0,8(sp)
 308:	0141                	add	sp,sp,16
 30a:	8082                	ret
  n = 0;
 30c:	4501                	li	a0,0
 30e:	bfe5                	j	306 <atoi+0x3e>

0000000000000310 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 310:	1141                	add	sp,sp,-16
 312:	e422                	sd	s0,8(sp)
 314:	0800                	add	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 316:	02b57463          	bgeu	a0,a1,33e <memmove+0x2e>
    while(n-- > 0)
 31a:	00c05f63          	blez	a2,338 <memmove+0x28>
 31e:	1602                	sll	a2,a2,0x20
 320:	9201                	srl	a2,a2,0x20
 322:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 326:	872a                	mv	a4,a0
      *dst++ = *src++;
 328:	0585                	add	a1,a1,1
 32a:	0705                	add	a4,a4,1
 32c:	fff5c683          	lbu	a3,-1(a1)
 330:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 334:	fef71ae3          	bne	a4,a5,328 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 338:	6422                	ld	s0,8(sp)
 33a:	0141                	add	sp,sp,16
 33c:	8082                	ret
    dst += n;
 33e:	00c50733          	add	a4,a0,a2
    src += n;
 342:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 344:	fec05ae3          	blez	a2,338 <memmove+0x28>
 348:	fff6079b          	addw	a5,a2,-1
 34c:	1782                	sll	a5,a5,0x20
 34e:	9381                	srl	a5,a5,0x20
 350:	fff7c793          	not	a5,a5
 354:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 356:	15fd                	add	a1,a1,-1
 358:	177d                	add	a4,a4,-1
 35a:	0005c683          	lbu	a3,0(a1)
 35e:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 362:	fee79ae3          	bne	a5,a4,356 <memmove+0x46>
 366:	bfc9                	j	338 <memmove+0x28>

0000000000000368 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 368:	1141                	add	sp,sp,-16
 36a:	e422                	sd	s0,8(sp)
 36c:	0800                	add	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 36e:	ca05                	beqz	a2,39e <memcmp+0x36>
 370:	fff6069b          	addw	a3,a2,-1
 374:	1682                	sll	a3,a3,0x20
 376:	9281                	srl	a3,a3,0x20
 378:	0685                	add	a3,a3,1
 37a:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 37c:	00054783          	lbu	a5,0(a0)
 380:	0005c703          	lbu	a4,0(a1)
 384:	00e79863          	bne	a5,a4,394 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 388:	0505                	add	a0,a0,1
    p2++;
 38a:	0585                	add	a1,a1,1
  while (n-- > 0) {
 38c:	fed518e3          	bne	a0,a3,37c <memcmp+0x14>
  }
  return 0;
 390:	4501                	li	a0,0
 392:	a019                	j	398 <memcmp+0x30>
      return *p1 - *p2;
 394:	40e7853b          	subw	a0,a5,a4
}
 398:	6422                	ld	s0,8(sp)
 39a:	0141                	add	sp,sp,16
 39c:	8082                	ret
  return 0;
 39e:	4501                	li	a0,0
 3a0:	bfe5                	j	398 <memcmp+0x30>

00000000000003a2 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 3a2:	1141                	add	sp,sp,-16
 3a4:	e406                	sd	ra,8(sp)
 3a6:	e022                	sd	s0,0(sp)
 3a8:	0800                	add	s0,sp,16
  return memmove(dst, src, n);
 3aa:	f67ff0ef          	jal	310 <memmove>
}
 3ae:	60a2                	ld	ra,8(sp)
 3b0:	6402                	ld	s0,0(sp)
 3b2:	0141                	add	sp,sp,16
 3b4:	8082                	ret

00000000000003b6 <sbrk>:

char *
sbrk(int n) {
 3b6:	1141                	add	sp,sp,-16
 3b8:	e406                	sd	ra,8(sp)
 3ba:	e022                	sd	s0,0(sp)
 3bc:	0800                	add	s0,sp,16
  return sys_sbrk(n, SBRK_EAGER);
 3be:	4585                	li	a1,1
 3c0:	152000ef          	jal	512 <sys_sbrk>
}
 3c4:	60a2                	ld	ra,8(sp)
 3c6:	6402                	ld	s0,0(sp)
 3c8:	0141                	add	sp,sp,16
 3ca:	8082                	ret

00000000000003cc <sbrklazy>:

char *
sbrklazy(int n) {
 3cc:	1141                	add	sp,sp,-16
 3ce:	e406                	sd	ra,8(sp)
 3d0:	e022                	sd	s0,0(sp)
 3d2:	0800                	add	s0,sp,16
  return sys_sbrk(n, SBRK_LAZY);
 3d4:	4589                	li	a1,2
 3d6:	13c000ef          	jal	512 <sys_sbrk>
}
 3da:	60a2                	ld	ra,8(sp)
 3dc:	6402                	ld	s0,0(sp)
 3de:	0141                	add	sp,sp,16
 3e0:	8082                	ret

00000000000003e2 <htons>:

// Byte order conversion functions
unsigned short
htons(unsigned short hostshort)
{
 3e2:	1141                	add	sp,sp,-16
 3e4:	e422                	sd	s0,8(sp)
 3e6:	0800                	add	s0,sp,16
  return ((hostshort >> 8) & 0xff) | ((hostshort & 0xff) << 8);
 3e8:	0085179b          	sllw	a5,a0,0x8
 3ec:	0085551b          	srlw	a0,a0,0x8
 3f0:	8d5d                	or	a0,a0,a5
}
 3f2:	1542                	sll	a0,a0,0x30
 3f4:	9141                	srl	a0,a0,0x30
 3f6:	6422                	ld	s0,8(sp)
 3f8:	0141                	add	sp,sp,16
 3fa:	8082                	ret

00000000000003fc <ntohs>:

unsigned short
ntohs(unsigned short netshort)
{
 3fc:	1141                	add	sp,sp,-16
 3fe:	e422                	sd	s0,8(sp)
 400:	0800                	add	s0,sp,16
  return ((netshort >> 8) & 0xff) | ((netshort & 0xff) << 8);
 402:	0085179b          	sllw	a5,a0,0x8
 406:	0085551b          	srlw	a0,a0,0x8
 40a:	8d5d                	or	a0,a0,a5
}
 40c:	1542                	sll	a0,a0,0x30
 40e:	9141                	srl	a0,a0,0x30
 410:	6422                	ld	s0,8(sp)
 412:	0141                	add	sp,sp,16
 414:	8082                	ret

0000000000000416 <htonl>:

unsigned long
htonl(unsigned long hostlong)
{
 416:	1141                	add	sp,sp,-16
 418:	e422                	sd	s0,8(sp)
 41a:	0800                	add	s0,sp,16
  return ((hostlong >> 24) & 0xff) |
 41c:	0185579b          	srlw	a5,a0,0x18
         ((hostlong >> 8) & 0xff00) |
 420:	00855713          	srl	a4,a0,0x8
 424:	66c1                	lui	a3,0x10
 426:	f0068693          	add	a3,a3,-256 # ff00 <base+0xeee0>
 42a:	8f75                	and	a4,a4,a3
  return ((hostlong >> 24) & 0xff) |
 42c:	8fd9                	or	a5,a5,a4
         ((hostlong & 0xff00) << 8) |
 42e:	00851713          	sll	a4,a0,0x8
 432:	00ff06b7          	lui	a3,0xff0
 436:	8f75                	and	a4,a4,a3
         ((hostlong >> 8) & 0xff00) |
 438:	8fd9                	or	a5,a5,a4
         ((hostlong & 0xff) << 24);
 43a:	0562                	sll	a0,a0,0x18
 43c:	0ff00713          	li	a4,255
 440:	0762                	sll	a4,a4,0x18
 442:	8d79                	and	a0,a0,a4
}
 444:	8d5d                	or	a0,a0,a5
 446:	6422                	ld	s0,8(sp)
 448:	0141                	add	sp,sp,16
 44a:	8082                	ret

000000000000044c <ntohl>:

unsigned long
ntohl(unsigned long netlong)
{
 44c:	1141                	add	sp,sp,-16
 44e:	e422                	sd	s0,8(sp)
 450:	0800                	add	s0,sp,16
  return ((netlong >> 24) & 0xff) |
 452:	0185579b          	srlw	a5,a0,0x18
         ((netlong >> 8) & 0xff00) |
 456:	00855713          	srl	a4,a0,0x8
 45a:	66c1                	lui	a3,0x10
 45c:	f0068693          	add	a3,a3,-256 # ff00 <base+0xeee0>
 460:	8f75                	and	a4,a4,a3
  return ((netlong >> 24) & 0xff) |
 462:	8fd9                	or	a5,a5,a4
         ((netlong & 0xff00) << 8) |
 464:	00851713          	sll	a4,a0,0x8
 468:	00ff06b7          	lui	a3,0xff0
 46c:	8f75                	and	a4,a4,a3
         ((netlong >> 8) & 0xff00) |
 46e:	8fd9                	or	a5,a5,a4
         ((netlong & 0xff) << 24);
 470:	0562                	sll	a0,a0,0x18
 472:	0ff00713          	li	a4,255
 476:	0762                	sll	a4,a4,0x18
 478:	8d79                	and	a0,a0,a4
}
 47a:	8d5d                	or	a0,a0,a5
 47c:	6422                	ld	s0,8(sp)
 47e:	0141                	add	sp,sp,16
 480:	8082                	ret

0000000000000482 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 482:	4885                	li	a7,1
 ecall
 484:	00000073          	ecall
 ret
 488:	8082                	ret

000000000000048a <exit>:
.global exit
exit:
 li a7, SYS_exit
 48a:	4889                	li	a7,2
 ecall
 48c:	00000073          	ecall
 ret
 490:	8082                	ret

0000000000000492 <wait>:
.global wait
wait:
 li a7, SYS_wait
 492:	488d                	li	a7,3
 ecall
 494:	00000073          	ecall
 ret
 498:	8082                	ret

000000000000049a <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 49a:	4891                	li	a7,4
 ecall
 49c:	00000073          	ecall
 ret
 4a0:	8082                	ret

00000000000004a2 <read>:
.global read
read:
 li a7, SYS_read
 4a2:	4895                	li	a7,5
 ecall
 4a4:	00000073          	ecall
 ret
 4a8:	8082                	ret

00000000000004aa <write>:
.global write
write:
 li a7, SYS_write
 4aa:	48c1                	li	a7,16
 ecall
 4ac:	00000073          	ecall
 ret
 4b0:	8082                	ret

00000000000004b2 <close>:
.global close
close:
 li a7, SYS_close
 4b2:	48d5                	li	a7,21
 ecall
 4b4:	00000073          	ecall
 ret
 4b8:	8082                	ret

00000000000004ba <kill>:
.global kill
kill:
 li a7, SYS_kill
 4ba:	4899                	li	a7,6
 ecall
 4bc:	00000073          	ecall
 ret
 4c0:	8082                	ret

00000000000004c2 <exec>:
.global exec
exec:
 li a7, SYS_exec
 4c2:	489d                	li	a7,7
 ecall
 4c4:	00000073          	ecall
 ret
 4c8:	8082                	ret

00000000000004ca <open>:
.global open
open:
 li a7, SYS_open
 4ca:	48bd                	li	a7,15
 ecall
 4cc:	00000073          	ecall
 ret
 4d0:	8082                	ret

00000000000004d2 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 4d2:	48c5                	li	a7,17
 ecall
 4d4:	00000073          	ecall
 ret
 4d8:	8082                	ret

00000000000004da <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 4da:	48c9                	li	a7,18
 ecall
 4dc:	00000073          	ecall
 ret
 4e0:	8082                	ret

00000000000004e2 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 4e2:	48a1                	li	a7,8
 ecall
 4e4:	00000073          	ecall
 ret
 4e8:	8082                	ret

00000000000004ea <link>:
.global link
link:
 li a7, SYS_link
 4ea:	48cd                	li	a7,19
 ecall
 4ec:	00000073          	ecall
 ret
 4f0:	8082                	ret

00000000000004f2 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 4f2:	48d1                	li	a7,20
 ecall
 4f4:	00000073          	ecall
 ret
 4f8:	8082                	ret

00000000000004fa <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 4fa:	48a5                	li	a7,9
 ecall
 4fc:	00000073          	ecall
 ret
 500:	8082                	ret

0000000000000502 <dup>:
.global dup
dup:
 li a7, SYS_dup
 502:	48a9                	li	a7,10
 ecall
 504:	00000073          	ecall
 ret
 508:	8082                	ret

000000000000050a <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 50a:	48ad                	li	a7,11
 ecall
 50c:	00000073          	ecall
 ret
 510:	8082                	ret

0000000000000512 <sys_sbrk>:
.global sys_sbrk
sys_sbrk:
 li a7, SYS_sbrk
 512:	48b1                	li	a7,12
 ecall
 514:	00000073          	ecall
 ret
 518:	8082                	ret

000000000000051a <pause>:
.global pause
pause:
 li a7, SYS_pause
 51a:	48b5                	li	a7,13
 ecall
 51c:	00000073          	ecall
 ret
 520:	8082                	ret

0000000000000522 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 522:	48b9                	li	a7,14
 ecall
 524:	00000073          	ecall
 ret
 528:	8082                	ret

000000000000052a <socket>:
.global socket
socket:
 li a7, SYS_socket
 52a:	48d9                	li	a7,22
 ecall
 52c:	00000073          	ecall
 ret
 530:	8082                	ret

0000000000000532 <bind>:
.global bind
bind:
 li a7, SYS_bind
 532:	48dd                	li	a7,23
 ecall
 534:	00000073          	ecall
 ret
 538:	8082                	ret

000000000000053a <listen>:
.global listen
listen:
 li a7, SYS_listen
 53a:	48e1                	li	a7,24
 ecall
 53c:	00000073          	ecall
 ret
 540:	8082                	ret

0000000000000542 <accept>:
.global accept
accept:
 li a7, SYS_accept
 542:	48e5                	li	a7,25
 ecall
 544:	00000073          	ecall
 ret
 548:	8082                	ret

000000000000054a <connect>:
.global connect
connect:
 li a7, SYS_connect
 54a:	48e9                	li	a7,26
 ecall
 54c:	00000073          	ecall
 ret
 550:	8082                	ret

0000000000000552 <send>:
.global send
send:
 li a7, SYS_send
 552:	48ed                	li	a7,27
 ecall
 554:	00000073          	ecall
 ret
 558:	8082                	ret

000000000000055a <recv>:
.global recv
recv:
 li a7, SYS_recv
 55a:	48f1                	li	a7,28
 ecall
 55c:	00000073          	ecall
 ret
 560:	8082                	ret

0000000000000562 <sendto>:
.global sendto
sendto:
 li a7, SYS_sendto
 562:	48f5                	li	a7,29
 ecall
 564:	00000073          	ecall
 ret
 568:	8082                	ret

000000000000056a <recvfrom>:
.global recvfrom
recvfrom:
 li a7, SYS_recvfrom
 56a:	48f9                	li	a7,30
 ecall
 56c:	00000073          	ecall
 ret
 570:	8082                	ret

0000000000000572 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 572:	1101                	add	sp,sp,-32
 574:	ec06                	sd	ra,24(sp)
 576:	e822                	sd	s0,16(sp)
 578:	1000                	add	s0,sp,32
 57a:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 57e:	4605                	li	a2,1
 580:	fef40593          	add	a1,s0,-17
 584:	f27ff0ef          	jal	4aa <write>
}
 588:	60e2                	ld	ra,24(sp)
 58a:	6442                	ld	s0,16(sp)
 58c:	6105                	add	sp,sp,32
 58e:	8082                	ret

0000000000000590 <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
 590:	715d                	add	sp,sp,-80
 592:	e486                	sd	ra,72(sp)
 594:	e0a2                	sd	s0,64(sp)
 596:	f84a                	sd	s2,48(sp)
 598:	0880                	add	s0,sp,80
 59a:	892a                	mv	s2,a0
  char buf[20];
  int i, neg;
  unsigned long long x;

  neg = 0;
  if(sgn && xx < 0){
 59c:	c299                	beqz	a3,5a2 <printint+0x12>
 59e:	0805c363          	bltz	a1,624 <printint+0x94>
  neg = 0;
 5a2:	4881                	li	a7,0
 5a4:	fb840693          	add	a3,s0,-72
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
 5a8:	4781                	li	a5,0
  do{
    buf[i++] = digits[x % base];
 5aa:	00000517          	auipc	a0,0x0
 5ae:	58650513          	add	a0,a0,1414 # b30 <digits>
 5b2:	883e                	mv	a6,a5
 5b4:	2785                	addw	a5,a5,1
 5b6:	02c5f733          	remu	a4,a1,a2
 5ba:	972a                	add	a4,a4,a0
 5bc:	00074703          	lbu	a4,0(a4)
 5c0:	00e68023          	sb	a4,0(a3) # ff0000 <base+0xfeefe0>
  }while((x /= base) != 0);
 5c4:	872e                	mv	a4,a1
 5c6:	02c5d5b3          	divu	a1,a1,a2
 5ca:	0685                	add	a3,a3,1
 5cc:	fec773e3          	bgeu	a4,a2,5b2 <printint+0x22>
  if(neg)
 5d0:	00088b63          	beqz	a7,5e6 <printint+0x56>
    buf[i++] = '-';
 5d4:	fd078793          	add	a5,a5,-48
 5d8:	97a2                	add	a5,a5,s0
 5da:	02d00713          	li	a4,45
 5de:	fee78423          	sb	a4,-24(a5)
 5e2:	0028079b          	addw	a5,a6,2

  while(--i >= 0)
 5e6:	02f05a63          	blez	a5,61a <printint+0x8a>
 5ea:	fc26                	sd	s1,56(sp)
 5ec:	f44e                	sd	s3,40(sp)
 5ee:	fb840713          	add	a4,s0,-72
 5f2:	00f704b3          	add	s1,a4,a5
 5f6:	fff70993          	add	s3,a4,-1
 5fa:	99be                	add	s3,s3,a5
 5fc:	37fd                	addw	a5,a5,-1
 5fe:	1782                	sll	a5,a5,0x20
 600:	9381                	srl	a5,a5,0x20
 602:	40f989b3          	sub	s3,s3,a5
    putc(fd, buf[i]);
 606:	fff4c583          	lbu	a1,-1(s1)
 60a:	854a                	mv	a0,s2
 60c:	f67ff0ef          	jal	572 <putc>
  while(--i >= 0)
 610:	14fd                	add	s1,s1,-1
 612:	ff349ae3          	bne	s1,s3,606 <printint+0x76>
 616:	74e2                	ld	s1,56(sp)
 618:	79a2                	ld	s3,40(sp)
}
 61a:	60a6                	ld	ra,72(sp)
 61c:	6406                	ld	s0,64(sp)
 61e:	7942                	ld	s2,48(sp)
 620:	6161                	add	sp,sp,80
 622:	8082                	ret
    x = -xx;
 624:	40b005b3          	neg	a1,a1
    neg = 1;
 628:	4885                	li	a7,1
    x = -xx;
 62a:	bfad                	j	5a4 <printint+0x14>

000000000000062c <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %c, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 62c:	711d                	add	sp,sp,-96
 62e:	ec86                	sd	ra,88(sp)
 630:	e8a2                	sd	s0,80(sp)
 632:	e0ca                	sd	s2,64(sp)
 634:	1080                	add	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 636:	0005c903          	lbu	s2,0(a1)
 63a:	28090663          	beqz	s2,8c6 <vprintf+0x29a>
 63e:	e4a6                	sd	s1,72(sp)
 640:	fc4e                	sd	s3,56(sp)
 642:	f852                	sd	s4,48(sp)
 644:	f456                	sd	s5,40(sp)
 646:	f05a                	sd	s6,32(sp)
 648:	ec5e                	sd	s7,24(sp)
 64a:	e862                	sd	s8,16(sp)
 64c:	e466                	sd	s9,8(sp)
 64e:	8b2a                	mv	s6,a0
 650:	8a2e                	mv	s4,a1
 652:	8bb2                	mv	s7,a2
  state = 0;
 654:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
 656:	4481                	li	s1,0
 658:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
 65a:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
 65e:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
 662:	06c00c93          	li	s9,108
 666:	a005                	j	686 <vprintf+0x5a>
        putc(fd, c0);
 668:	85ca                	mv	a1,s2
 66a:	855a                	mv	a0,s6
 66c:	f07ff0ef          	jal	572 <putc>
 670:	a019                	j	676 <vprintf+0x4a>
    } else if(state == '%'){
 672:	03598263          	beq	s3,s5,696 <vprintf+0x6a>
  for(i = 0; fmt[i]; i++){
 676:	2485                	addw	s1,s1,1
 678:	8726                	mv	a4,s1
 67a:	009a07b3          	add	a5,s4,s1
 67e:	0007c903          	lbu	s2,0(a5)
 682:	22090a63          	beqz	s2,8b6 <vprintf+0x28a>
    c0 = fmt[i] & 0xff;
 686:	0009079b          	sext.w	a5,s2
    if(state == 0){
 68a:	fe0994e3          	bnez	s3,672 <vprintf+0x46>
      if(c0 == '%'){
 68e:	fd579de3          	bne	a5,s5,668 <vprintf+0x3c>
        state = '%';
 692:	89be                	mv	s3,a5
 694:	b7cd                	j	676 <vprintf+0x4a>
      if(c0) c1 = fmt[i+1] & 0xff;
 696:	00ea06b3          	add	a3,s4,a4
 69a:	0016c683          	lbu	a3,1(a3)
      c1 = c2 = 0;
 69e:	8636                	mv	a2,a3
      if(c1) c2 = fmt[i+2] & 0xff;
 6a0:	c681                	beqz	a3,6a8 <vprintf+0x7c>
 6a2:	9752                	add	a4,a4,s4
 6a4:	00274603          	lbu	a2,2(a4)
      if(c0 == 'd'){
 6a8:	05878363          	beq	a5,s8,6ee <vprintf+0xc2>
      } else if(c0 == 'l' && c1 == 'd'){
 6ac:	05978d63          	beq	a5,s9,706 <vprintf+0xda>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
 6b0:	07500713          	li	a4,117
 6b4:	0ee78763          	beq	a5,a4,7a2 <vprintf+0x176>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
 6b8:	07800713          	li	a4,120
 6bc:	12e78963          	beq	a5,a4,7ee <vprintf+0x1c2>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
 6c0:	07000713          	li	a4,112
 6c4:	14e78e63          	beq	a5,a4,820 <vprintf+0x1f4>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 'c'){
 6c8:	06300713          	li	a4,99
 6cc:	18e78e63          	beq	a5,a4,868 <vprintf+0x23c>
        putc(fd, va_arg(ap, uint32));
      } else if(c0 == 's'){
 6d0:	07300713          	li	a4,115
 6d4:	1ae78463          	beq	a5,a4,87c <vprintf+0x250>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
 6d8:	02500713          	li	a4,37
 6dc:	04e79563          	bne	a5,a4,726 <vprintf+0xfa>
        putc(fd, '%');
 6e0:	02500593          	li	a1,37
 6e4:	855a                	mv	a0,s6
 6e6:	e8dff0ef          	jal	572 <putc>
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c0);
      }

      state = 0;
 6ea:	4981                	li	s3,0
 6ec:	b769                	j	676 <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 1);
 6ee:	008b8913          	add	s2,s7,8
 6f2:	4685                	li	a3,1
 6f4:	4629                	li	a2,10
 6f6:	000ba583          	lw	a1,0(s7)
 6fa:	855a                	mv	a0,s6
 6fc:	e95ff0ef          	jal	590 <printint>
 700:	8bca                	mv	s7,s2
      state = 0;
 702:	4981                	li	s3,0
 704:	bf8d                	j	676 <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'd'){
 706:	06400793          	li	a5,100
 70a:	02f68963          	beq	a3,a5,73c <vprintf+0x110>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 70e:	06c00793          	li	a5,108
 712:	04f68263          	beq	a3,a5,756 <vprintf+0x12a>
      } else if(c0 == 'l' && c1 == 'u'){
 716:	07500793          	li	a5,117
 71a:	0af68063          	beq	a3,a5,7ba <vprintf+0x18e>
      } else if(c0 == 'l' && c1 == 'x'){
 71e:	07800793          	li	a5,120
 722:	0ef68263          	beq	a3,a5,806 <vprintf+0x1da>
        putc(fd, '%');
 726:	02500593          	li	a1,37
 72a:	855a                	mv	a0,s6
 72c:	e47ff0ef          	jal	572 <putc>
        putc(fd, c0);
 730:	85ca                	mv	a1,s2
 732:	855a                	mv	a0,s6
 734:	e3fff0ef          	jal	572 <putc>
      state = 0;
 738:	4981                	li	s3,0
 73a:	bf35                	j	676 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 73c:	008b8913          	add	s2,s7,8
 740:	4685                	li	a3,1
 742:	4629                	li	a2,10
 744:	000bb583          	ld	a1,0(s7)
 748:	855a                	mv	a0,s6
 74a:	e47ff0ef          	jal	590 <printint>
        i += 1;
 74e:	2485                	addw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 750:	8bca                	mv	s7,s2
      state = 0;
 752:	4981                	li	s3,0
        i += 1;
 754:	b70d                	j	676 <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 756:	06400793          	li	a5,100
 75a:	02f60763          	beq	a2,a5,788 <vprintf+0x15c>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 75e:	07500793          	li	a5,117
 762:	06f60963          	beq	a2,a5,7d4 <vprintf+0x1a8>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 766:	07800793          	li	a5,120
 76a:	faf61ee3          	bne	a2,a5,726 <vprintf+0xfa>
        printint(fd, va_arg(ap, uint64), 16, 0);
 76e:	008b8913          	add	s2,s7,8
 772:	4681                	li	a3,0
 774:	4641                	li	a2,16
 776:	000bb583          	ld	a1,0(s7)
 77a:	855a                	mv	a0,s6
 77c:	e15ff0ef          	jal	590 <printint>
        i += 2;
 780:	2489                	addw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 782:	8bca                	mv	s7,s2
      state = 0;
 784:	4981                	li	s3,0
        i += 2;
 786:	bdc5                	j	676 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 788:	008b8913          	add	s2,s7,8
 78c:	4685                	li	a3,1
 78e:	4629                	li	a2,10
 790:	000bb583          	ld	a1,0(s7)
 794:	855a                	mv	a0,s6
 796:	dfbff0ef          	jal	590 <printint>
        i += 2;
 79a:	2489                	addw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 79c:	8bca                	mv	s7,s2
      state = 0;
 79e:	4981                	li	s3,0
        i += 2;
 7a0:	bdd9                	j	676 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint32), 10, 0);
 7a2:	008b8913          	add	s2,s7,8
 7a6:	4681                	li	a3,0
 7a8:	4629                	li	a2,10
 7aa:	000be583          	lwu	a1,0(s7)
 7ae:	855a                	mv	a0,s6
 7b0:	de1ff0ef          	jal	590 <printint>
 7b4:	8bca                	mv	s7,s2
      state = 0;
 7b6:	4981                	li	s3,0
 7b8:	bd7d                	j	676 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 7ba:	008b8913          	add	s2,s7,8
 7be:	4681                	li	a3,0
 7c0:	4629                	li	a2,10
 7c2:	000bb583          	ld	a1,0(s7)
 7c6:	855a                	mv	a0,s6
 7c8:	dc9ff0ef          	jal	590 <printint>
        i += 1;
 7cc:	2485                	addw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 7ce:	8bca                	mv	s7,s2
      state = 0;
 7d0:	4981                	li	s3,0
        i += 1;
 7d2:	b555                	j	676 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 7d4:	008b8913          	add	s2,s7,8
 7d8:	4681                	li	a3,0
 7da:	4629                	li	a2,10
 7dc:	000bb583          	ld	a1,0(s7)
 7e0:	855a                	mv	a0,s6
 7e2:	dafff0ef          	jal	590 <printint>
        i += 2;
 7e6:	2489                	addw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 7e8:	8bca                	mv	s7,s2
      state = 0;
 7ea:	4981                	li	s3,0
        i += 2;
 7ec:	b569                	j	676 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint32), 16, 0);
 7ee:	008b8913          	add	s2,s7,8
 7f2:	4681                	li	a3,0
 7f4:	4641                	li	a2,16
 7f6:	000be583          	lwu	a1,0(s7)
 7fa:	855a                	mv	a0,s6
 7fc:	d95ff0ef          	jal	590 <printint>
 800:	8bca                	mv	s7,s2
      state = 0;
 802:	4981                	li	s3,0
 804:	bd8d                	j	676 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 16, 0);
 806:	008b8913          	add	s2,s7,8
 80a:	4681                	li	a3,0
 80c:	4641                	li	a2,16
 80e:	000bb583          	ld	a1,0(s7)
 812:	855a                	mv	a0,s6
 814:	d7dff0ef          	jal	590 <printint>
        i += 1;
 818:	2485                	addw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 81a:	8bca                	mv	s7,s2
      state = 0;
 81c:	4981                	li	s3,0
        i += 1;
 81e:	bda1                	j	676 <vprintf+0x4a>
 820:	e06a                	sd	s10,0(sp)
        printptr(fd, va_arg(ap, uint64));
 822:	008b8d13          	add	s10,s7,8
 826:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 82a:	03000593          	li	a1,48
 82e:	855a                	mv	a0,s6
 830:	d43ff0ef          	jal	572 <putc>
  putc(fd, 'x');
 834:	07800593          	li	a1,120
 838:	855a                	mv	a0,s6
 83a:	d39ff0ef          	jal	572 <putc>
 83e:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 840:	00000b97          	auipc	s7,0x0
 844:	2f0b8b93          	add	s7,s7,752 # b30 <digits>
 848:	03c9d793          	srl	a5,s3,0x3c
 84c:	97de                	add	a5,a5,s7
 84e:	0007c583          	lbu	a1,0(a5)
 852:	855a                	mv	a0,s6
 854:	d1fff0ef          	jal	572 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 858:	0992                	sll	s3,s3,0x4
 85a:	397d                	addw	s2,s2,-1
 85c:	fe0916e3          	bnez	s2,848 <vprintf+0x21c>
        printptr(fd, va_arg(ap, uint64));
 860:	8bea                	mv	s7,s10
      state = 0;
 862:	4981                	li	s3,0
 864:	6d02                	ld	s10,0(sp)
 866:	bd01                	j	676 <vprintf+0x4a>
        putc(fd, va_arg(ap, uint32));
 868:	008b8913          	add	s2,s7,8
 86c:	000bc583          	lbu	a1,0(s7)
 870:	855a                	mv	a0,s6
 872:	d01ff0ef          	jal	572 <putc>
 876:	8bca                	mv	s7,s2
      state = 0;
 878:	4981                	li	s3,0
 87a:	bbf5                	j	676 <vprintf+0x4a>
        if((s = va_arg(ap, char*)) == 0)
 87c:	008b8993          	add	s3,s7,8
 880:	000bb903          	ld	s2,0(s7)
 884:	00090f63          	beqz	s2,8a2 <vprintf+0x276>
        for(; *s; s++)
 888:	00094583          	lbu	a1,0(s2)
 88c:	c195                	beqz	a1,8b0 <vprintf+0x284>
          putc(fd, *s);
 88e:	855a                	mv	a0,s6
 890:	ce3ff0ef          	jal	572 <putc>
        for(; *s; s++)
 894:	0905                	add	s2,s2,1
 896:	00094583          	lbu	a1,0(s2)
 89a:	f9f5                	bnez	a1,88e <vprintf+0x262>
        if((s = va_arg(ap, char*)) == 0)
 89c:	8bce                	mv	s7,s3
      state = 0;
 89e:	4981                	li	s3,0
 8a0:	bbd9                	j	676 <vprintf+0x4a>
          s = "(null)";
 8a2:	00000917          	auipc	s2,0x0
 8a6:	28690913          	add	s2,s2,646 # b28 <malloc+0x17a>
        for(; *s; s++)
 8aa:	02800593          	li	a1,40
 8ae:	b7c5                	j	88e <vprintf+0x262>
        if((s = va_arg(ap, char*)) == 0)
 8b0:	8bce                	mv	s7,s3
      state = 0;
 8b2:	4981                	li	s3,0
 8b4:	b3c9                	j	676 <vprintf+0x4a>
 8b6:	64a6                	ld	s1,72(sp)
 8b8:	79e2                	ld	s3,56(sp)
 8ba:	7a42                	ld	s4,48(sp)
 8bc:	7aa2                	ld	s5,40(sp)
 8be:	7b02                	ld	s6,32(sp)
 8c0:	6be2                	ld	s7,24(sp)
 8c2:	6c42                	ld	s8,16(sp)
 8c4:	6ca2                	ld	s9,8(sp)
    }
  }
}
 8c6:	60e6                	ld	ra,88(sp)
 8c8:	6446                	ld	s0,80(sp)
 8ca:	6906                	ld	s2,64(sp)
 8cc:	6125                	add	sp,sp,96
 8ce:	8082                	ret

00000000000008d0 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 8d0:	715d                	add	sp,sp,-80
 8d2:	ec06                	sd	ra,24(sp)
 8d4:	e822                	sd	s0,16(sp)
 8d6:	1000                	add	s0,sp,32
 8d8:	e010                	sd	a2,0(s0)
 8da:	e414                	sd	a3,8(s0)
 8dc:	e818                	sd	a4,16(s0)
 8de:	ec1c                	sd	a5,24(s0)
 8e0:	03043023          	sd	a6,32(s0)
 8e4:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 8e8:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 8ec:	8622                	mv	a2,s0
 8ee:	d3fff0ef          	jal	62c <vprintf>
}
 8f2:	60e2                	ld	ra,24(sp)
 8f4:	6442                	ld	s0,16(sp)
 8f6:	6161                	add	sp,sp,80
 8f8:	8082                	ret

00000000000008fa <printf>:

void
printf(const char *fmt, ...)
{
 8fa:	711d                	add	sp,sp,-96
 8fc:	ec06                	sd	ra,24(sp)
 8fe:	e822                	sd	s0,16(sp)
 900:	1000                	add	s0,sp,32
 902:	e40c                	sd	a1,8(s0)
 904:	e810                	sd	a2,16(s0)
 906:	ec14                	sd	a3,24(s0)
 908:	f018                	sd	a4,32(s0)
 90a:	f41c                	sd	a5,40(s0)
 90c:	03043823          	sd	a6,48(s0)
 910:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 914:	00840613          	add	a2,s0,8
 918:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 91c:	85aa                	mv	a1,a0
 91e:	4505                	li	a0,1
 920:	d0dff0ef          	jal	62c <vprintf>
}
 924:	60e2                	ld	ra,24(sp)
 926:	6442                	ld	s0,16(sp)
 928:	6125                	add	sp,sp,96
 92a:	8082                	ret

000000000000092c <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 92c:	1141                	add	sp,sp,-16
 92e:	e422                	sd	s0,8(sp)
 930:	0800                	add	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 932:	ff050693          	add	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 936:	00000797          	auipc	a5,0x0
 93a:	6da7b783          	ld	a5,1754(a5) # 1010 <freep>
 93e:	a02d                	j	968 <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 940:	4618                	lw	a4,8(a2)
 942:	9f2d                	addw	a4,a4,a1
 944:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 948:	6398                	ld	a4,0(a5)
 94a:	6310                	ld	a2,0(a4)
 94c:	a83d                	j	98a <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 94e:	ff852703          	lw	a4,-8(a0)
 952:	9f31                	addw	a4,a4,a2
 954:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 956:	ff053683          	ld	a3,-16(a0)
 95a:	a091                	j	99e <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 95c:	6398                	ld	a4,0(a5)
 95e:	00e7e463          	bltu	a5,a4,966 <free+0x3a>
 962:	00e6ea63          	bltu	a3,a4,976 <free+0x4a>
{
 966:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 968:	fed7fae3          	bgeu	a5,a3,95c <free+0x30>
 96c:	6398                	ld	a4,0(a5)
 96e:	00e6e463          	bltu	a3,a4,976 <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 972:	fee7eae3          	bltu	a5,a4,966 <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 976:	ff852583          	lw	a1,-8(a0)
 97a:	6390                	ld	a2,0(a5)
 97c:	02059813          	sll	a6,a1,0x20
 980:	01c85713          	srl	a4,a6,0x1c
 984:	9736                	add	a4,a4,a3
 986:	fae60de3          	beq	a2,a4,940 <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 98a:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 98e:	4790                	lw	a2,8(a5)
 990:	02061593          	sll	a1,a2,0x20
 994:	01c5d713          	srl	a4,a1,0x1c
 998:	973e                	add	a4,a4,a5
 99a:	fae68ae3          	beq	a3,a4,94e <free+0x22>
    p->s.ptr = bp->s.ptr;
 99e:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 9a0:	00000717          	auipc	a4,0x0
 9a4:	66f73823          	sd	a5,1648(a4) # 1010 <freep>
}
 9a8:	6422                	ld	s0,8(sp)
 9aa:	0141                	add	sp,sp,16
 9ac:	8082                	ret

00000000000009ae <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 9ae:	7139                	add	sp,sp,-64
 9b0:	fc06                	sd	ra,56(sp)
 9b2:	f822                	sd	s0,48(sp)
 9b4:	f426                	sd	s1,40(sp)
 9b6:	ec4e                	sd	s3,24(sp)
 9b8:	0080                	add	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 9ba:	02051493          	sll	s1,a0,0x20
 9be:	9081                	srl	s1,s1,0x20
 9c0:	04bd                	add	s1,s1,15
 9c2:	8091                	srl	s1,s1,0x4
 9c4:	0014899b          	addw	s3,s1,1
 9c8:	0485                	add	s1,s1,1
  if((prevp = freep) == 0){
 9ca:	00000517          	auipc	a0,0x0
 9ce:	64653503          	ld	a0,1606(a0) # 1010 <freep>
 9d2:	c915                	beqz	a0,a06 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 9d4:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 9d6:	4798                	lw	a4,8(a5)
 9d8:	08977a63          	bgeu	a4,s1,a6c <malloc+0xbe>
 9dc:	f04a                	sd	s2,32(sp)
 9de:	e852                	sd	s4,16(sp)
 9e0:	e456                	sd	s5,8(sp)
 9e2:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 9e4:	8a4e                	mv	s4,s3
 9e6:	0009871b          	sext.w	a4,s3
 9ea:	6685                	lui	a3,0x1
 9ec:	00d77363          	bgeu	a4,a3,9f2 <malloc+0x44>
 9f0:	6a05                	lui	s4,0x1
 9f2:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 9f6:	004a1a1b          	sllw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 9fa:	00000917          	auipc	s2,0x0
 9fe:	61690913          	add	s2,s2,1558 # 1010 <freep>
  if(p == SBRK_ERROR)
 a02:	5afd                	li	s5,-1
 a04:	a081                	j	a44 <malloc+0x96>
 a06:	f04a                	sd	s2,32(sp)
 a08:	e852                	sd	s4,16(sp)
 a0a:	e456                	sd	s5,8(sp)
 a0c:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 a0e:	00000797          	auipc	a5,0x0
 a12:	61278793          	add	a5,a5,1554 # 1020 <base>
 a16:	00000717          	auipc	a4,0x0
 a1a:	5ef73d23          	sd	a5,1530(a4) # 1010 <freep>
 a1e:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 a20:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 a24:	b7c1                	j	9e4 <malloc+0x36>
        prevp->s.ptr = p->s.ptr;
 a26:	6398                	ld	a4,0(a5)
 a28:	e118                	sd	a4,0(a0)
 a2a:	a8a9                	j	a84 <malloc+0xd6>
  hp->s.size = nu;
 a2c:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 a30:	0541                	add	a0,a0,16
 a32:	efbff0ef          	jal	92c <free>
  return freep;
 a36:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 a3a:	c12d                	beqz	a0,a9c <malloc+0xee>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a3c:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 a3e:	4798                	lw	a4,8(a5)
 a40:	02977263          	bgeu	a4,s1,a64 <malloc+0xb6>
    if(p == freep)
 a44:	00093703          	ld	a4,0(s2)
 a48:	853e                	mv	a0,a5
 a4a:	fef719e3          	bne	a4,a5,a3c <malloc+0x8e>
  p = sbrk(nu * sizeof(Header));
 a4e:	8552                	mv	a0,s4
 a50:	967ff0ef          	jal	3b6 <sbrk>
  if(p == SBRK_ERROR)
 a54:	fd551ce3          	bne	a0,s5,a2c <malloc+0x7e>
        return 0;
 a58:	4501                	li	a0,0
 a5a:	7902                	ld	s2,32(sp)
 a5c:	6a42                	ld	s4,16(sp)
 a5e:	6aa2                	ld	s5,8(sp)
 a60:	6b02                	ld	s6,0(sp)
 a62:	a03d                	j	a90 <malloc+0xe2>
 a64:	7902                	ld	s2,32(sp)
 a66:	6a42                	ld	s4,16(sp)
 a68:	6aa2                	ld	s5,8(sp)
 a6a:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 a6c:	fae48de3          	beq	s1,a4,a26 <malloc+0x78>
        p->s.size -= nunits;
 a70:	4137073b          	subw	a4,a4,s3
 a74:	c798                	sw	a4,8(a5)
        p += p->s.size;
 a76:	02071693          	sll	a3,a4,0x20
 a7a:	01c6d713          	srl	a4,a3,0x1c
 a7e:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 a80:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 a84:	00000717          	auipc	a4,0x0
 a88:	58a73623          	sd	a0,1420(a4) # 1010 <freep>
      return (void*)(p + 1);
 a8c:	01078513          	add	a0,a5,16
  }
}
 a90:	70e2                	ld	ra,56(sp)
 a92:	7442                	ld	s0,48(sp)
 a94:	74a2                	ld	s1,40(sp)
 a96:	69e2                	ld	s3,24(sp)
 a98:	6121                	add	sp,sp,64
 a9a:	8082                	ret
 a9c:	7902                	ld	s2,32(sp)
 a9e:	6a42                	ld	s4,16(sp)
 aa0:	6aa2                	ld	s5,8(sp)
 aa2:	6b02                	ld	s6,0(sp)
 aa4:	b7f5                	j	a90 <malloc+0xe2>
