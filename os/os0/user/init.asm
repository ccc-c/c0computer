
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
  12:	ba250513          	add	a0,a0,-1118 # bb0 <malloc+0xec>
  16:	5d0000ef          	jal	5e6 <open>
  1a:	04054563          	bltz	a0,64 <main+0x64>
    mknod("console", CONSOLE, 0);
    open("console", O_RDWR);
  }
  dup(0);  // stdout
  1e:	4501                	li	a0,0
  20:	5fe000ef          	jal	61e <dup>
  dup(0);  // stderr
  24:	4501                	li	a0,0
  26:	5f8000ef          	jal	61e <dup>

  for(;;){
    printf("init: starting sh\n");
  2a:	00001917          	auipc	s2,0x1
  2e:	b8e90913          	add	s2,s2,-1138 # bb8 <malloc+0xf4>
  32:	854a                	mv	a0,s2
  34:	1dd000ef          	jal	a10 <printf>
    pid = fork();
  38:	566000ef          	jal	59e <fork>
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
  46:	568000ef          	jal	5ae <wait>
      if(wpid == pid){
  4a:	fea484e3          	beq	s1,a0,32 <main+0x32>
        // the shell exited; restart it.
        break;
      } else if(wpid < 0){
  4e:	fe055be3          	bgez	a0,44 <main+0x44>
        printf("init: wait returned an error\n");
  52:	00001517          	auipc	a0,0x1
  56:	bb650513          	add	a0,a0,-1098 # c08 <malloc+0x144>
  5a:	1b7000ef          	jal	a10 <printf>
        exit(1);
  5e:	4505                	li	a0,1
  60:	546000ef          	jal	5a6 <exit>
    mknod("console", CONSOLE, 0);
  64:	4601                	li	a2,0
  66:	4585                	li	a1,1
  68:	00001517          	auipc	a0,0x1
  6c:	b4850513          	add	a0,a0,-1208 # bb0 <malloc+0xec>
  70:	57e000ef          	jal	5ee <mknod>
    open("console", O_RDWR);
  74:	4589                	li	a1,2
  76:	00001517          	auipc	a0,0x1
  7a:	b3a50513          	add	a0,a0,-1222 # bb0 <malloc+0xec>
  7e:	568000ef          	jal	5e6 <open>
  82:	bf71                	j	1e <main+0x1e>
      printf("init: fork failed\n");
  84:	00001517          	auipc	a0,0x1
  88:	b4c50513          	add	a0,a0,-1204 # bd0 <malloc+0x10c>
  8c:	185000ef          	jal	a10 <printf>
      exit(1);
  90:	4505                	li	a0,1
  92:	514000ef          	jal	5a6 <exit>
      exec("sh", argv);
  96:	00001597          	auipc	a1,0x1
  9a:	f6a58593          	add	a1,a1,-150 # 1000 <argv>
  9e:	00001517          	auipc	a0,0x1
  a2:	b4a50513          	add	a0,a0,-1206 # be8 <malloc+0x124>
  a6:	538000ef          	jal	5de <exec>
      printf("init: exec sh failed\n");
  aa:	00001517          	auipc	a0,0x1
  ae:	b4650513          	add	a0,a0,-1210 # bf0 <malloc+0x12c>
  b2:	15f000ef          	jal	a10 <printf>
      exit(1);
  b6:	4505                	li	a0,1
  b8:	4ee000ef          	jal	5a6 <exit>

00000000000000bc <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start()
{
  bc:	1141                	add	sp,sp,-16
  be:	e406                	sd	ra,8(sp)
  c0:	e022                	sd	s0,0(sp)
  c2:	0800                	add	s0,sp,16
  extern int main();
  main();
  c4:	f3dff0ef          	jal	0 <main>
  exit(0);
  c8:	4501                	li	a0,0
  ca:	4dc000ef          	jal	5a6 <exit>

00000000000000ce <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
  ce:	1141                	add	sp,sp,-16
  d0:	e422                	sd	s0,8(sp)
  d2:	0800                	add	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  d4:	87aa                	mv	a5,a0
  d6:	0585                	add	a1,a1,1
  d8:	0785                	add	a5,a5,1
  da:	fff5c703          	lbu	a4,-1(a1)
  de:	fee78fa3          	sb	a4,-1(a5)
  e2:	fb75                	bnez	a4,d6 <strcpy+0x8>
    ;
  return os;
}
  e4:	6422                	ld	s0,8(sp)
  e6:	0141                	add	sp,sp,16
  e8:	8082                	ret

00000000000000ea <strcmp>:

int
strcmp(const char *p, const char *q)
{
  ea:	1141                	add	sp,sp,-16
  ec:	e422                	sd	s0,8(sp)
  ee:	0800                	add	s0,sp,16
  while(*p && *p == *q)
  f0:	00054783          	lbu	a5,0(a0)
  f4:	cb91                	beqz	a5,108 <strcmp+0x1e>
  f6:	0005c703          	lbu	a4,0(a1)
  fa:	00f71763          	bne	a4,a5,108 <strcmp+0x1e>
    p++, q++;
  fe:	0505                	add	a0,a0,1
 100:	0585                	add	a1,a1,1
  while(*p && *p == *q)
 102:	00054783          	lbu	a5,0(a0)
 106:	fbe5                	bnez	a5,f6 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 108:	0005c503          	lbu	a0,0(a1)
}
 10c:	40a7853b          	subw	a0,a5,a0
 110:	6422                	ld	s0,8(sp)
 112:	0141                	add	sp,sp,16
 114:	8082                	ret

0000000000000116 <strlen>:

uint
strlen(const char *s)
{
 116:	1141                	add	sp,sp,-16
 118:	e422                	sd	s0,8(sp)
 11a:	0800                	add	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 11c:	00054783          	lbu	a5,0(a0)
 120:	cf91                	beqz	a5,13c <strlen+0x26>
 122:	0505                	add	a0,a0,1
 124:	87aa                	mv	a5,a0
 126:	86be                	mv	a3,a5
 128:	0785                	add	a5,a5,1
 12a:	fff7c703          	lbu	a4,-1(a5)
 12e:	ff65                	bnez	a4,126 <strlen+0x10>
 130:	40a6853b          	subw	a0,a3,a0
 134:	2505                	addw	a0,a0,1
    ;
  return n;
}
 136:	6422                	ld	s0,8(sp)
 138:	0141                	add	sp,sp,16
 13a:	8082                	ret
  for(n = 0; s[n]; n++)
 13c:	4501                	li	a0,0
 13e:	bfe5                	j	136 <strlen+0x20>

0000000000000140 <memset>:

void*
memset(void *dst, int c, uint n)
{
 140:	1141                	add	sp,sp,-16
 142:	e422                	sd	s0,8(sp)
 144:	0800                	add	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 146:	ca19                	beqz	a2,15c <memset+0x1c>
 148:	87aa                	mv	a5,a0
 14a:	1602                	sll	a2,a2,0x20
 14c:	9201                	srl	a2,a2,0x20
 14e:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 152:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 156:	0785                	add	a5,a5,1
 158:	fee79de3          	bne	a5,a4,152 <memset+0x12>
  }
  return dst;
}
 15c:	6422                	ld	s0,8(sp)
 15e:	0141                	add	sp,sp,16
 160:	8082                	ret

0000000000000162 <strchr>:

char*
strchr(const char *s, char c)
{
 162:	1141                	add	sp,sp,-16
 164:	e422                	sd	s0,8(sp)
 166:	0800                	add	s0,sp,16
  for(; *s; s++)
 168:	00054783          	lbu	a5,0(a0)
 16c:	cb99                	beqz	a5,182 <strchr+0x20>
    if(*s == c)
 16e:	00f58763          	beq	a1,a5,17c <strchr+0x1a>
  for(; *s; s++)
 172:	0505                	add	a0,a0,1
 174:	00054783          	lbu	a5,0(a0)
 178:	fbfd                	bnez	a5,16e <strchr+0xc>
      return (char*)s;
  return 0;
 17a:	4501                	li	a0,0
}
 17c:	6422                	ld	s0,8(sp)
 17e:	0141                	add	sp,sp,16
 180:	8082                	ret
  return 0;
 182:	4501                	li	a0,0
 184:	bfe5                	j	17c <strchr+0x1a>

0000000000000186 <gets>:

char*
gets(char *buf, int max)
{
 186:	711d                	add	sp,sp,-96
 188:	ec86                	sd	ra,88(sp)
 18a:	e8a2                	sd	s0,80(sp)
 18c:	e4a6                	sd	s1,72(sp)
 18e:	e0ca                	sd	s2,64(sp)
 190:	fc4e                	sd	s3,56(sp)
 192:	f852                	sd	s4,48(sp)
 194:	f456                	sd	s5,40(sp)
 196:	f05a                	sd	s6,32(sp)
 198:	ec5e                	sd	s7,24(sp)
 19a:	1080                	add	s0,sp,96
 19c:	8baa                	mv	s7,a0
 19e:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1a0:	892a                	mv	s2,a0
 1a2:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 1a4:	4aa9                	li	s5,10
 1a6:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 1a8:	89a6                	mv	s3,s1
 1aa:	2485                	addw	s1,s1,1
 1ac:	0344d663          	bge	s1,s4,1d8 <gets+0x52>
    cc = read(0, &c, 1);
 1b0:	4605                	li	a2,1
 1b2:	faf40593          	add	a1,s0,-81
 1b6:	4501                	li	a0,0
 1b8:	406000ef          	jal	5be <read>
    if(cc < 1)
 1bc:	00a05e63          	blez	a0,1d8 <gets+0x52>
    buf[i++] = c;
 1c0:	faf44783          	lbu	a5,-81(s0)
 1c4:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 1c8:	01578763          	beq	a5,s5,1d6 <gets+0x50>
 1cc:	0905                	add	s2,s2,1
 1ce:	fd679de3          	bne	a5,s6,1a8 <gets+0x22>
  for(i=0; i+1 < max; ){
 1d2:	89a6                	mv	s3,s1
 1d4:	a011                	j	1d8 <gets+0x52>
 1d6:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 1d8:	99de                	add	s3,s3,s7
 1da:	00098023          	sb	zero,0(s3)
  return buf;
}
 1de:	855e                	mv	a0,s7
 1e0:	60e6                	ld	ra,88(sp)
 1e2:	6446                	ld	s0,80(sp)
 1e4:	64a6                	ld	s1,72(sp)
 1e6:	6906                	ld	s2,64(sp)
 1e8:	79e2                	ld	s3,56(sp)
 1ea:	7a42                	ld	s4,48(sp)
 1ec:	7aa2                	ld	s5,40(sp)
 1ee:	7b02                	ld	s6,32(sp)
 1f0:	6be2                	ld	s7,24(sp)
 1f2:	6125                	add	sp,sp,96
 1f4:	8082                	ret

00000000000001f6 <stat>:

int
stat(const char *n, struct stat *st)
{
 1f6:	1101                	add	sp,sp,-32
 1f8:	ec06                	sd	ra,24(sp)
 1fa:	e822                	sd	s0,16(sp)
 1fc:	e426                	sd	s1,8(sp)
 1fe:	e04a                	sd	s2,0(sp)
 200:	1000                	add	s0,sp,32
 202:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 204:	4581                	li	a1,0
 206:	3e0000ef          	jal	5e6 <open>
  if(fd < 0)
 20a:	02054163          	bltz	a0,22c <stat+0x36>
 20e:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 210:	85ca                	mv	a1,s2
 212:	3ec000ef          	jal	5fe <fstat>
 216:	892a                	mv	s2,a0
  close(fd);
 218:	8526                	mv	a0,s1
 21a:	3b4000ef          	jal	5ce <close>
  return r;
}
 21e:	854a                	mv	a0,s2
 220:	60e2                	ld	ra,24(sp)
 222:	6442                	ld	s0,16(sp)
 224:	64a2                	ld	s1,8(sp)
 226:	6902                	ld	s2,0(sp)
 228:	6105                	add	sp,sp,32
 22a:	8082                	ret
    return -1;
 22c:	597d                	li	s2,-1
 22e:	bfc5                	j	21e <stat+0x28>

0000000000000230 <atoi>:

int
atoi(const char *s)
{
 230:	1141                	add	sp,sp,-16
 232:	e422                	sd	s0,8(sp)
 234:	0800                	add	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 236:	00054683          	lbu	a3,0(a0)
 23a:	fd06879b          	addw	a5,a3,-48
 23e:	0ff7f793          	zext.b	a5,a5
 242:	4625                	li	a2,9
 244:	02f66863          	bltu	a2,a5,274 <atoi+0x44>
 248:	872a                	mv	a4,a0
  n = 0;
 24a:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 24c:	0705                	add	a4,a4,1
 24e:	0025179b          	sllw	a5,a0,0x2
 252:	9fa9                	addw	a5,a5,a0
 254:	0017979b          	sllw	a5,a5,0x1
 258:	9fb5                	addw	a5,a5,a3
 25a:	fd07851b          	addw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 25e:	00074683          	lbu	a3,0(a4)
 262:	fd06879b          	addw	a5,a3,-48
 266:	0ff7f793          	zext.b	a5,a5
 26a:	fef671e3          	bgeu	a2,a5,24c <atoi+0x1c>
  return n;
}
 26e:	6422                	ld	s0,8(sp)
 270:	0141                	add	sp,sp,16
 272:	8082                	ret
  n = 0;
 274:	4501                	li	a0,0
 276:	bfe5                	j	26e <atoi+0x3e>

0000000000000278 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 278:	1141                	add	sp,sp,-16
 27a:	e422                	sd	s0,8(sp)
 27c:	0800                	add	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 27e:	02b57463          	bgeu	a0,a1,2a6 <memmove+0x2e>
    while(n-- > 0)
 282:	00c05f63          	blez	a2,2a0 <memmove+0x28>
 286:	1602                	sll	a2,a2,0x20
 288:	9201                	srl	a2,a2,0x20
 28a:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 28e:	872a                	mv	a4,a0
      *dst++ = *src++;
 290:	0585                	add	a1,a1,1
 292:	0705                	add	a4,a4,1
 294:	fff5c683          	lbu	a3,-1(a1)
 298:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 29c:	fee79ae3          	bne	a5,a4,290 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 2a0:	6422                	ld	s0,8(sp)
 2a2:	0141                	add	sp,sp,16
 2a4:	8082                	ret
    dst += n;
 2a6:	00c50733          	add	a4,a0,a2
    src += n;
 2aa:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 2ac:	fec05ae3          	blez	a2,2a0 <memmove+0x28>
 2b0:	fff6079b          	addw	a5,a2,-1
 2b4:	1782                	sll	a5,a5,0x20
 2b6:	9381                	srl	a5,a5,0x20
 2b8:	fff7c793          	not	a5,a5
 2bc:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 2be:	15fd                	add	a1,a1,-1
 2c0:	177d                	add	a4,a4,-1
 2c2:	0005c683          	lbu	a3,0(a1)
 2c6:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 2ca:	fee79ae3          	bne	a5,a4,2be <memmove+0x46>
 2ce:	bfc9                	j	2a0 <memmove+0x28>

00000000000002d0 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 2d0:	1141                	add	sp,sp,-16
 2d2:	e422                	sd	s0,8(sp)
 2d4:	0800                	add	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 2d6:	ca05                	beqz	a2,306 <memcmp+0x36>
 2d8:	fff6069b          	addw	a3,a2,-1
 2dc:	1682                	sll	a3,a3,0x20
 2de:	9281                	srl	a3,a3,0x20
 2e0:	0685                	add	a3,a3,1
 2e2:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 2e4:	00054783          	lbu	a5,0(a0)
 2e8:	0005c703          	lbu	a4,0(a1)
 2ec:	00e79863          	bne	a5,a4,2fc <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 2f0:	0505                	add	a0,a0,1
    p2++;
 2f2:	0585                	add	a1,a1,1
  while (n-- > 0) {
 2f4:	fed518e3          	bne	a0,a3,2e4 <memcmp+0x14>
  }
  return 0;
 2f8:	4501                	li	a0,0
 2fa:	a019                	j	300 <memcmp+0x30>
      return *p1 - *p2;
 2fc:	40e7853b          	subw	a0,a5,a4
}
 300:	6422                	ld	s0,8(sp)
 302:	0141                	add	sp,sp,16
 304:	8082                	ret
  return 0;
 306:	4501                	li	a0,0
 308:	bfe5                	j	300 <memcmp+0x30>

000000000000030a <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 30a:	1141                	add	sp,sp,-16
 30c:	e406                	sd	ra,8(sp)
 30e:	e022                	sd	s0,0(sp)
 310:	0800                	add	s0,sp,16
  return memmove(dst, src, n);
 312:	f67ff0ef          	jal	278 <memmove>
}
 316:	60a2                	ld	ra,8(sp)
 318:	6402                	ld	s0,0(sp)
 31a:	0141                	add	sp,sp,16
 31c:	8082                	ret

000000000000031e <htons>:
    return (v & 0x000000ff) << 24 | (v & 0x0000ff00) << 8 | (v & 0x00ff0000) >> 8 | (v & 0xff000000) >> 24;
}

uint16_t
htons(uint16_t h)
{
 31e:	1141                	add	sp,sp,-16
 320:	e422                	sd	s0,8(sp)
 322:	0800                	add	s0,sp,16
    if (!endian) {
 324:	00001797          	auipc	a5,0x1
 328:	cec7a783          	lw	a5,-788(a5) # 1010 <endian>
 32c:	e385                	bnez	a5,34c <htons+0x2e>
        endian = byteorder();
 32e:	4d200793          	li	a5,1234
 332:	00001717          	auipc	a4,0x1
 336:	ccf72f23          	sw	a5,-802(a4) # 1010 <endian>
    return (v & 0x00ff) << 8 | (v & 0xff00 ) >> 8;
 33a:	0085579b          	srlw	a5,a0,0x8
 33e:	0085151b          	sllw	a0,a0,0x8
 342:	8fc9                	or	a5,a5,a0
 344:	03079513          	sll	a0,a5,0x30
 348:	9141                	srl	a0,a0,0x30
 34a:	a029                	j	354 <htons+0x36>
    }
    return endian == __LITTLE_ENDIAN ? byteswap16(h) : h;
 34c:	4d200713          	li	a4,1234
 350:	fee785e3          	beq	a5,a4,33a <htons+0x1c>
}
 354:	6422                	ld	s0,8(sp)
 356:	0141                	add	sp,sp,16
 358:	8082                	ret

000000000000035a <ntohs>:

uint16_t
ntohs(uint16_t n)
{
 35a:	1141                	add	sp,sp,-16
 35c:	e422                	sd	s0,8(sp)
 35e:	0800                	add	s0,sp,16
    if (!endian) {
 360:	00001797          	auipc	a5,0x1
 364:	cb07a783          	lw	a5,-848(a5) # 1010 <endian>
 368:	e385                	bnez	a5,388 <ntohs+0x2e>
        endian = byteorder();
 36a:	4d200793          	li	a5,1234
 36e:	00001717          	auipc	a4,0x1
 372:	caf72123          	sw	a5,-862(a4) # 1010 <endian>
    return (v & 0x00ff) << 8 | (v & 0xff00 ) >> 8;
 376:	0085579b          	srlw	a5,a0,0x8
 37a:	0085151b          	sllw	a0,a0,0x8
 37e:	8fc9                	or	a5,a5,a0
 380:	03079513          	sll	a0,a5,0x30
 384:	9141                	srl	a0,a0,0x30
 386:	a029                	j	390 <ntohs+0x36>
    }
    return endian == __LITTLE_ENDIAN ? byteswap16(n) : n;
 388:	4d200713          	li	a4,1234
 38c:	fee785e3          	beq	a5,a4,376 <ntohs+0x1c>
}
 390:	6422                	ld	s0,8(sp)
 392:	0141                	add	sp,sp,16
 394:	8082                	ret

0000000000000396 <htonl>:

uint32_t
htonl(uint32_t h)
{
 396:	1141                	add	sp,sp,-16
 398:	e422                	sd	s0,8(sp)
 39a:	0800                	add	s0,sp,16
    if (!endian) {
 39c:	00001797          	auipc	a5,0x1
 3a0:	c747a783          	lw	a5,-908(a5) # 1010 <endian>
 3a4:	ef85                	bnez	a5,3dc <htonl+0x46>
        endian = byteorder();
 3a6:	4d200793          	li	a5,1234
 3aa:	00001717          	auipc	a4,0x1
 3ae:	c6f72323          	sw	a5,-922(a4) # 1010 <endian>
    return (v & 0x000000ff) << 24 | (v & 0x0000ff00) << 8 | (v & 0x00ff0000) >> 8 | (v & 0xff000000) >> 24;
 3b2:	0185179b          	sllw	a5,a0,0x18
 3b6:	0185571b          	srlw	a4,a0,0x18
 3ba:	8fd9                	or	a5,a5,a4
 3bc:	0085171b          	sllw	a4,a0,0x8
 3c0:	00ff06b7          	lui	a3,0xff0
 3c4:	8f75                	and	a4,a4,a3
 3c6:	8fd9                	or	a5,a5,a4
 3c8:	0085551b          	srlw	a0,a0,0x8
 3cc:	6741                	lui	a4,0x10
 3ce:	f0070713          	add	a4,a4,-256 # ff00 <base+0xeee0>
 3d2:	8d79                	and	a0,a0,a4
 3d4:	8fc9                	or	a5,a5,a0
 3d6:	0007851b          	sext.w	a0,a5
 3da:	a029                	j	3e4 <htonl+0x4e>
    }
    return endian == __LITTLE_ENDIAN ? byteswap32(h) : h;
 3dc:	4d200713          	li	a4,1234
 3e0:	fce789e3          	beq	a5,a4,3b2 <htonl+0x1c>
}
 3e4:	6422                	ld	s0,8(sp)
 3e6:	0141                	add	sp,sp,16
 3e8:	8082                	ret

00000000000003ea <ntohl>:

uint32_t
ntohl(uint32_t n)
{
 3ea:	1141                	add	sp,sp,-16
 3ec:	e422                	sd	s0,8(sp)
 3ee:	0800                	add	s0,sp,16
    if (!endian) {
 3f0:	00001797          	auipc	a5,0x1
 3f4:	c207a783          	lw	a5,-992(a5) # 1010 <endian>
 3f8:	ef85                	bnez	a5,430 <ntohl+0x46>
        endian = byteorder();
 3fa:	4d200793          	li	a5,1234
 3fe:	00001717          	auipc	a4,0x1
 402:	c0f72923          	sw	a5,-1006(a4) # 1010 <endian>
    return (v & 0x000000ff) << 24 | (v & 0x0000ff00) << 8 | (v & 0x00ff0000) >> 8 | (v & 0xff000000) >> 24;
 406:	0185179b          	sllw	a5,a0,0x18
 40a:	0185571b          	srlw	a4,a0,0x18
 40e:	8fd9                	or	a5,a5,a4
 410:	0085171b          	sllw	a4,a0,0x8
 414:	00ff06b7          	lui	a3,0xff0
 418:	8f75                	and	a4,a4,a3
 41a:	8fd9                	or	a5,a5,a4
 41c:	0085551b          	srlw	a0,a0,0x8
 420:	6741                	lui	a4,0x10
 422:	f0070713          	add	a4,a4,-256 # ff00 <base+0xeee0>
 426:	8d79                	and	a0,a0,a4
 428:	8fc9                	or	a5,a5,a0
 42a:	0007851b          	sext.w	a0,a5
 42e:	a029                	j	438 <ntohl+0x4e>
    }
    return endian == __LITTLE_ENDIAN ? byteswap32(n) : n;
 430:	4d200713          	li	a4,1234
 434:	fce789e3          	beq	a5,a4,406 <ntohl+0x1c>
}
 438:	6422                	ld	s0,8(sp)
 43a:	0141                	add	sp,sp,16
 43c:	8082                	ret

000000000000043e <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
 43e:	1141                	add	sp,sp,-16
 440:	e422                	sd	s0,8(sp)
 442:	0800                	add	s0,sp,16
 444:	872a                	mv	a4,a0
    int neg = 0;
    long val = 0;

    // gobble initial whitespace
    while (*s == ' ' || *s == '\t')
 446:	02000693          	li	a3,32
 44a:	4525                	li	a0,9
 44c:	a011                	j	450 <strtol+0x12>
        s++;
 44e:	0705                	add	a4,a4,1
    while (*s == ' ' || *s == '\t')
 450:	00074783          	lbu	a5,0(a4)
 454:	fed78de3          	beq	a5,a3,44e <strtol+0x10>
 458:	fea78be3          	beq	a5,a0,44e <strtol+0x10>

    // plus/minus sign
    if (*s == '+')
 45c:	02b00693          	li	a3,43
 460:	02d78663          	beq	a5,a3,48c <strtol+0x4e>
        s++;
    else if (*s == '-')
 464:	02d00693          	li	a3,45
    int neg = 0;
 468:	4301                	li	t1,0
    else if (*s == '-')
 46a:	02d78463          	beq	a5,a3,492 <strtol+0x54>
        s++, neg = 1;

    // hex or octal base prefix
    if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
 46e:	fef67793          	and	a5,a2,-17
 472:	eb89                	bnez	a5,484 <strtol+0x46>
 474:	00074683          	lbu	a3,0(a4)
 478:	03000793          	li	a5,48
 47c:	00f68e63          	beq	a3,a5,498 <strtol+0x5a>
        s += 2, base = 16;
    else if (base == 0 && s[0] == '0')
 480:	e211                	bnez	a2,484 <strtol+0x46>
        s++, base = 8;
    else if (base == 0)
        base = 10;
 482:	4629                	li	a2,10
 484:	4501                	li	a0,0

    // digits
    while (1) {
        int dig;

        if (*s >= '0' && *s <= '9')
 486:	4825                	li	a6,9
            dig = *s - '0';
        else if (*s >= 'a' && *s <= 'z')
 488:	48e5                	li	a7,25
 48a:	a825                	j	4c2 <strtol+0x84>
        s++;
 48c:	0705                	add	a4,a4,1
    int neg = 0;
 48e:	4301                	li	t1,0
 490:	bff9                	j	46e <strtol+0x30>
        s++, neg = 1;
 492:	0705                	add	a4,a4,1
 494:	4305                	li	t1,1
 496:	bfe1                	j	46e <strtol+0x30>
    if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
 498:	00174683          	lbu	a3,1(a4)
 49c:	07800793          	li	a5,120
 4a0:	00f68663          	beq	a3,a5,4ac <strtol+0x6e>
    else if (base == 0 && s[0] == '0')
 4a4:	f265                	bnez	a2,484 <strtol+0x46>
        s++, base = 8;
 4a6:	0705                	add	a4,a4,1
 4a8:	4621                	li	a2,8
 4aa:	bfe9                	j	484 <strtol+0x46>
        s += 2, base = 16;
 4ac:	0709                	add	a4,a4,2
 4ae:	4641                	li	a2,16
 4b0:	bfd1                	j	484 <strtol+0x46>
            dig = *s - '0';
 4b2:	fd07879b          	addw	a5,a5,-48
            dig = *s - 'a' + 10;
        else if (*s >= 'A' && *s <= 'Z')
            dig = *s - 'A' + 10;
        else
            break;
        if (dig >= base)
 4b6:	04c7d063          	bge	a5,a2,4f6 <strtol+0xb8>
            break;
        s++, val = (val * base) + dig;
 4ba:	0705                	add	a4,a4,1
 4bc:	02a60533          	mul	a0,a2,a0
 4c0:	953e                	add	a0,a0,a5
        if (*s >= '0' && *s <= '9')
 4c2:	00074783          	lbu	a5,0(a4)
 4c6:	fd07869b          	addw	a3,a5,-48
 4ca:	0ff6f693          	zext.b	a3,a3
 4ce:	fed872e3          	bgeu	a6,a3,4b2 <strtol+0x74>
        else if (*s >= 'a' && *s <= 'z')
 4d2:	f9f7869b          	addw	a3,a5,-97
 4d6:	0ff6f693          	zext.b	a3,a3
 4da:	00d8e563          	bltu	a7,a3,4e4 <strtol+0xa6>
            dig = *s - 'a' + 10;
 4de:	fa97879b          	addw	a5,a5,-87
 4e2:	bfd1                	j	4b6 <strtol+0x78>
        else if (*s >= 'A' && *s <= 'Z')
 4e4:	fbf7869b          	addw	a3,a5,-65
 4e8:	0ff6f693          	zext.b	a3,a3
 4ec:	00d8e563          	bltu	a7,a3,4f6 <strtol+0xb8>
            dig = *s - 'A' + 10;
 4f0:	fc97879b          	addw	a5,a5,-55
 4f4:	b7c9                	j	4b6 <strtol+0x78>
        // we don't properly detect overflow!
    }

    if (endptr)
 4f6:	c191                	beqz	a1,4fa <strtol+0xbc>
        *endptr = (char *) s;
 4f8:	e198                	sd	a4,0(a1)
    return (neg ? -val : val);
 4fa:	00030463          	beqz	t1,502 <strtol+0xc4>
 4fe:	40a00533          	neg	a0,a0
}
 502:	6422                	ld	s0,8(sp)
 504:	0141                	add	sp,sp,16
 506:	8082                	ret

0000000000000508 <inet_pton>:
inet_pton (int family, const char *p, void *n) {
    char *sp, *ep;
    int idx;
    long ret;

    if (family != AF_INET) {
 508:	4785                	li	a5,1
 50a:	08f51263          	bne	a0,a5,58e <inet_pton+0x86>
inet_pton (int family, const char *p, void *n) {
 50e:	715d                	add	sp,sp,-80
 510:	e486                	sd	ra,72(sp)
 512:	e0a2                	sd	s0,64(sp)
 514:	fc26                	sd	s1,56(sp)
 516:	f84a                	sd	s2,48(sp)
 518:	f44e                	sd	s3,40(sp)
 51a:	f052                	sd	s4,32(sp)
 51c:	ec56                	sd	s5,24(sp)
 51e:	e85a                	sd	s6,16(sp)
 520:	0880                	add	s0,sp,80
 522:	892e                	mv	s2,a1
 524:	89b2                	mv	s3,a2
 526:	4481                	li	s1,0
        return -1;
    }
    sp = (char *)p;
    for (idx = 0; idx < 4; idx++) {
        ret = strtol(sp, &ep, 10);
        if (ret < 0 || ret > 255) {
 528:	0ff00a13          	li	s4,255
            return -1;
        }
        if (ep == sp) {
            return -1;
        }
        if ((idx == 3 && *ep != '\0') || (idx != 3 && *ep != '.')) {
 52c:	4a8d                	li	s5,3
 52e:	02e00b13          	li	s6,46
 532:	a815                	j	566 <inet_pton+0x5e>
 534:	0007c783          	lbu	a5,0(a5)
 538:	e3ad                	bnez	a5,59a <inet_pton+0x92>
            return -1;
        }
        ((uint8_t *)n)[idx] = ret;
 53a:	2481                	sext.w	s1,s1
 53c:	99a6                	add	s3,s3,s1
 53e:	00a98023          	sb	a0,0(s3)
        sp = ep + 1;
    }
    return 0;
 542:	4501                	li	a0,0
}
 544:	60a6                	ld	ra,72(sp)
 546:	6406                	ld	s0,64(sp)
 548:	74e2                	ld	s1,56(sp)
 54a:	7942                	ld	s2,48(sp)
 54c:	79a2                	ld	s3,40(sp)
 54e:	7a02                	ld	s4,32(sp)
 550:	6ae2                	ld	s5,24(sp)
 552:	6b42                	ld	s6,16(sp)
 554:	6161                	add	sp,sp,80
 556:	8082                	ret
        ((uint8_t *)n)[idx] = ret;
 558:	00998733          	add	a4,s3,s1
 55c:	00a70023          	sb	a0,0(a4)
        sp = ep + 1;
 560:	00178913          	add	s2,a5,1
    for (idx = 0; idx < 4; idx++) {
 564:	0485                	add	s1,s1,1
        ret = strtol(sp, &ep, 10);
 566:	4629                	li	a2,10
 568:	fb840593          	add	a1,s0,-72
 56c:	854a                	mv	a0,s2
 56e:	ed1ff0ef          	jal	43e <strtol>
        if (ret < 0 || ret > 255) {
 572:	02aa6063          	bltu	s4,a0,592 <inet_pton+0x8a>
        if (ep == sp) {
 576:	fb843783          	ld	a5,-72(s0)
 57a:	01278e63          	beq	a5,s2,596 <inet_pton+0x8e>
        if ((idx == 3 && *ep != '\0') || (idx != 3 && *ep != '.')) {
 57e:	fb548be3          	beq	s1,s5,534 <inet_pton+0x2c>
 582:	0007c703          	lbu	a4,0(a5)
 586:	fd6709e3          	beq	a4,s6,558 <inet_pton+0x50>
            return -1;
 58a:	557d                	li	a0,-1
 58c:	bf65                	j	544 <inet_pton+0x3c>
        return -1;
 58e:	557d                	li	a0,-1
}
 590:	8082                	ret
            return -1;
 592:	557d                	li	a0,-1
 594:	bf45                	j	544 <inet_pton+0x3c>
            return -1;
 596:	557d                	li	a0,-1
 598:	b775                	j	544 <inet_pton+0x3c>
            return -1;
 59a:	557d                	li	a0,-1
 59c:	b765                	j	544 <inet_pton+0x3c>

000000000000059e <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 59e:	4885                	li	a7,1
 ecall
 5a0:	00000073          	ecall
 ret
 5a4:	8082                	ret

00000000000005a6 <exit>:
.global exit
exit:
 li a7, SYS_exit
 5a6:	4889                	li	a7,2
 ecall
 5a8:	00000073          	ecall
 ret
 5ac:	8082                	ret

00000000000005ae <wait>:
.global wait
wait:
 li a7, SYS_wait
 5ae:	488d                	li	a7,3
 ecall
 5b0:	00000073          	ecall
 ret
 5b4:	8082                	ret

00000000000005b6 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 5b6:	4891                	li	a7,4
 ecall
 5b8:	00000073          	ecall
 ret
 5bc:	8082                	ret

00000000000005be <read>:
.global read
read:
 li a7, SYS_read
 5be:	4895                	li	a7,5
 ecall
 5c0:	00000073          	ecall
 ret
 5c4:	8082                	ret

00000000000005c6 <write>:
.global write
write:
 li a7, SYS_write
 5c6:	48c1                	li	a7,16
 ecall
 5c8:	00000073          	ecall
 ret
 5cc:	8082                	ret

00000000000005ce <close>:
.global close
close:
 li a7, SYS_close
 5ce:	48d5                	li	a7,21
 ecall
 5d0:	00000073          	ecall
 ret
 5d4:	8082                	ret

00000000000005d6 <kill>:
.global kill
kill:
 li a7, SYS_kill
 5d6:	4899                	li	a7,6
 ecall
 5d8:	00000073          	ecall
 ret
 5dc:	8082                	ret

00000000000005de <exec>:
.global exec
exec:
 li a7, SYS_exec
 5de:	489d                	li	a7,7
 ecall
 5e0:	00000073          	ecall
 ret
 5e4:	8082                	ret

00000000000005e6 <open>:
.global open
open:
 li a7, SYS_open
 5e6:	48bd                	li	a7,15
 ecall
 5e8:	00000073          	ecall
 ret
 5ec:	8082                	ret

00000000000005ee <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 5ee:	48c5                	li	a7,17
 ecall
 5f0:	00000073          	ecall
 ret
 5f4:	8082                	ret

00000000000005f6 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 5f6:	48c9                	li	a7,18
 ecall
 5f8:	00000073          	ecall
 ret
 5fc:	8082                	ret

00000000000005fe <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 5fe:	48a1                	li	a7,8
 ecall
 600:	00000073          	ecall
 ret
 604:	8082                	ret

0000000000000606 <link>:
.global link
link:
 li a7, SYS_link
 606:	48cd                	li	a7,19
 ecall
 608:	00000073          	ecall
 ret
 60c:	8082                	ret

000000000000060e <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 60e:	48d1                	li	a7,20
 ecall
 610:	00000073          	ecall
 ret
 614:	8082                	ret

0000000000000616 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 616:	48a5                	li	a7,9
 ecall
 618:	00000073          	ecall
 ret
 61c:	8082                	ret

000000000000061e <dup>:
.global dup
dup:
 li a7, SYS_dup
 61e:	48a9                	li	a7,10
 ecall
 620:	00000073          	ecall
 ret
 624:	8082                	ret

0000000000000626 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 626:	48ad                	li	a7,11
 ecall
 628:	00000073          	ecall
 ret
 62c:	8082                	ret

000000000000062e <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 62e:	48b1                	li	a7,12
 ecall
 630:	00000073          	ecall
 ret
 634:	8082                	ret

0000000000000636 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 636:	48b5                	li	a7,13
 ecall
 638:	00000073          	ecall
 ret
 63c:	8082                	ret

000000000000063e <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 63e:	48b9                	li	a7,14
 ecall
 640:	00000073          	ecall
 ret
 644:	8082                	ret

0000000000000646 <socket>:
.global socket
socket:
 li a7, SYS_socket
 646:	48d9                	li	a7,22
 ecall
 648:	00000073          	ecall
 ret
 64c:	8082                	ret

000000000000064e <bind>:
.global bind
bind:
 li a7, SYS_bind
 64e:	48dd                	li	a7,23
 ecall
 650:	00000073          	ecall
 ret
 654:	8082                	ret

0000000000000656 <recvfrom>:
.global recvfrom
recvfrom:
 li a7, SYS_recvfrom
 656:	48e1                	li	a7,24
 ecall
 658:	00000073          	ecall
 ret
 65c:	8082                	ret

000000000000065e <sendto>:
.global sendto
sendto:
 li a7, SYS_sendto
 65e:	48e5                	li	a7,25
 ecall
 660:	00000073          	ecall
 ret
 664:	8082                	ret

0000000000000666 <connect>:
.global connect
connect:
 li a7, SYS_connect
 666:	48e9                	li	a7,26
 ecall
 668:	00000073          	ecall
 ret
 66c:	8082                	ret

000000000000066e <listen>:
.global listen
listen:
 li a7, SYS_listen
 66e:	48ed                	li	a7,27
 ecall
 670:	00000073          	ecall
 ret
 674:	8082                	ret

0000000000000676 <accept>:
.global accept
accept:
 li a7, SYS_accept
 676:	48f1                	li	a7,28
 ecall
 678:	00000073          	ecall
 ret
 67c:	8082                	ret

000000000000067e <recv>:
.global recv
recv:
 li a7, SYS_recv
 67e:	48f5                	li	a7,29
 ecall
 680:	00000073          	ecall
 ret
 684:	8082                	ret

0000000000000686 <send>:
.global send
send:
 li a7, SYS_send
 686:	48f9                	li	a7,30
 ecall
 688:	00000073          	ecall
 ret
 68c:	8082                	ret

000000000000068e <ioctl>:
.global ioctl
ioctl:
 li a7, SYS_ioctl
 68e:	48fd                	li	a7,31
 ecall
 690:	00000073          	ecall
 ret
 694:	8082                	ret

0000000000000696 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 696:	1101                	add	sp,sp,-32
 698:	ec06                	sd	ra,24(sp)
 69a:	e822                	sd	s0,16(sp)
 69c:	1000                	add	s0,sp,32
 69e:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 6a2:	4605                	li	a2,1
 6a4:	fef40593          	add	a1,s0,-17
 6a8:	f1fff0ef          	jal	5c6 <write>
}
 6ac:	60e2                	ld	ra,24(sp)
 6ae:	6442                	ld	s0,16(sp)
 6b0:	6105                	add	sp,sp,32
 6b2:	8082                	ret

00000000000006b4 <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
 6b4:	715d                	add	sp,sp,-80
 6b6:	e486                	sd	ra,72(sp)
 6b8:	e0a2                	sd	s0,64(sp)
 6ba:	fc26                	sd	s1,56(sp)
 6bc:	f84a                	sd	s2,48(sp)
 6be:	f44e                	sd	s3,40(sp)
 6c0:	0880                	add	s0,sp,80
 6c2:	84aa                	mv	s1,a0
  char buf[20];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 6c4:	c299                	beqz	a3,6ca <printint+0x16>
 6c6:	0805c763          	bltz	a1,754 <printint+0xa0>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 6ca:	2581                	sext.w	a1,a1
  neg = 0;
 6cc:	4881                	li	a7,0
 6ce:	fb840693          	add	a3,s0,-72
  }

  i = 0;
 6d2:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 6d4:	2601                	sext.w	a2,a2
 6d6:	00000517          	auipc	a0,0x0
 6da:	55a50513          	add	a0,a0,1370 # c30 <digits>
 6de:	883a                	mv	a6,a4
 6e0:	2705                	addw	a4,a4,1
 6e2:	02c5f7bb          	remuw	a5,a1,a2
 6e6:	1782                	sll	a5,a5,0x20
 6e8:	9381                	srl	a5,a5,0x20
 6ea:	97aa                	add	a5,a5,a0
 6ec:	0007c783          	lbu	a5,0(a5)
 6f0:	00f68023          	sb	a5,0(a3) # ff0000 <base+0xfeefe0>
  }while((x /= base) != 0);
 6f4:	0005879b          	sext.w	a5,a1
 6f8:	02c5d5bb          	divuw	a1,a1,a2
 6fc:	0685                	add	a3,a3,1
 6fe:	fec7f0e3          	bgeu	a5,a2,6de <printint+0x2a>
  if(neg)
 702:	00088c63          	beqz	a7,71a <printint+0x66>
    buf[i++] = '-';
 706:	fd070793          	add	a5,a4,-48
 70a:	00878733          	add	a4,a5,s0
 70e:	02d00793          	li	a5,45
 712:	fef70423          	sb	a5,-24(a4)
 716:	0028071b          	addw	a4,a6,2

  while(--i >= 0)
 71a:	02e05663          	blez	a4,746 <printint+0x92>
 71e:	fb840793          	add	a5,s0,-72
 722:	00e78933          	add	s2,a5,a4
 726:	fff78993          	add	s3,a5,-1
 72a:	99ba                	add	s3,s3,a4
 72c:	377d                	addw	a4,a4,-1
 72e:	1702                	sll	a4,a4,0x20
 730:	9301                	srl	a4,a4,0x20
 732:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 736:	fff94583          	lbu	a1,-1(s2)
 73a:	8526                	mv	a0,s1
 73c:	f5bff0ef          	jal	696 <putc>
  while(--i >= 0)
 740:	197d                	add	s2,s2,-1
 742:	ff391ae3          	bne	s2,s3,736 <printint+0x82>
}
 746:	60a6                	ld	ra,72(sp)
 748:	6406                	ld	s0,64(sp)
 74a:	74e2                	ld	s1,56(sp)
 74c:	7942                	ld	s2,48(sp)
 74e:	79a2                	ld	s3,40(sp)
 750:	6161                	add	sp,sp,80
 752:	8082                	ret
    x = -xx;
 754:	40b005bb          	negw	a1,a1
    neg = 1;
 758:	4885                	li	a7,1
    x = -xx;
 75a:	bf95                	j	6ce <printint+0x1a>

000000000000075c <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 75c:	711d                	add	sp,sp,-96
 75e:	ec86                	sd	ra,88(sp)
 760:	e8a2                	sd	s0,80(sp)
 762:	e4a6                	sd	s1,72(sp)
 764:	e0ca                	sd	s2,64(sp)
 766:	fc4e                	sd	s3,56(sp)
 768:	f852                	sd	s4,48(sp)
 76a:	f456                	sd	s5,40(sp)
 76c:	f05a                	sd	s6,32(sp)
 76e:	ec5e                	sd	s7,24(sp)
 770:	e862                	sd	s8,16(sp)
 772:	e466                	sd	s9,8(sp)
 774:	e06a                	sd	s10,0(sp)
 776:	1080                	add	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 778:	0005c903          	lbu	s2,0(a1)
 77c:	24090763          	beqz	s2,9ca <vprintf+0x26e>
 780:	8b2a                	mv	s6,a0
 782:	8a2e                	mv	s4,a1
 784:	8bb2                	mv	s7,a2
  state = 0;
 786:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
 788:	4481                	li	s1,0
 78a:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
 78c:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
 790:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
 794:	06c00c93          	li	s9,108
 798:	a005                	j	7b8 <vprintf+0x5c>
        putc(fd, c0);
 79a:	85ca                	mv	a1,s2
 79c:	855a                	mv	a0,s6
 79e:	ef9ff0ef          	jal	696 <putc>
 7a2:	a019                	j	7a8 <vprintf+0x4c>
    } else if(state == '%'){
 7a4:	03598263          	beq	s3,s5,7c8 <vprintf+0x6c>
  for(i = 0; fmt[i]; i++){
 7a8:	2485                	addw	s1,s1,1
 7aa:	8726                	mv	a4,s1
 7ac:	009a07b3          	add	a5,s4,s1
 7b0:	0007c903          	lbu	s2,0(a5)
 7b4:	20090b63          	beqz	s2,9ca <vprintf+0x26e>
    c0 = fmt[i] & 0xff;
 7b8:	0009079b          	sext.w	a5,s2
    if(state == 0){
 7bc:	fe0994e3          	bnez	s3,7a4 <vprintf+0x48>
      if(c0 == '%'){
 7c0:	fd579de3          	bne	a5,s5,79a <vprintf+0x3e>
        state = '%';
 7c4:	89be                	mv	s3,a5
 7c6:	b7cd                	j	7a8 <vprintf+0x4c>
      if(c0) c1 = fmt[i+1] & 0xff;
 7c8:	c7c9                	beqz	a5,852 <vprintf+0xf6>
 7ca:	00ea06b3          	add	a3,s4,a4
 7ce:	0016c683          	lbu	a3,1(a3)
      c1 = c2 = 0;
 7d2:	8636                	mv	a2,a3
      if(c1) c2 = fmt[i+2] & 0xff;
 7d4:	c681                	beqz	a3,7dc <vprintf+0x80>
 7d6:	9752                	add	a4,a4,s4
 7d8:	00274603          	lbu	a2,2(a4)
      if(c0 == 'd'){
 7dc:	03878f63          	beq	a5,s8,81a <vprintf+0xbe>
      } else if(c0 == 'l' && c1 == 'd'){
 7e0:	05978963          	beq	a5,s9,832 <vprintf+0xd6>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
 7e4:	07500713          	li	a4,117
 7e8:	0ee78363          	beq	a5,a4,8ce <vprintf+0x172>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
 7ec:	07800713          	li	a4,120
 7f0:	12e78563          	beq	a5,a4,91a <vprintf+0x1be>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
 7f4:	07000713          	li	a4,112
 7f8:	14e78a63          	beq	a5,a4,94c <vprintf+0x1f0>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 's'){
 7fc:	07300713          	li	a4,115
 800:	18e78863          	beq	a5,a4,990 <vprintf+0x234>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
 804:	02500713          	li	a4,37
 808:	04e79563          	bne	a5,a4,852 <vprintf+0xf6>
        putc(fd, '%');
 80c:	02500593          	li	a1,37
 810:	855a                	mv	a0,s6
 812:	e85ff0ef          	jal	696 <putc>
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
#endif
      state = 0;
 816:	4981                	li	s3,0
 818:	bf41                	j	7a8 <vprintf+0x4c>
        printint(fd, va_arg(ap, int), 10, 1);
 81a:	008b8913          	add	s2,s7,8
 81e:	4685                	li	a3,1
 820:	4629                	li	a2,10
 822:	000ba583          	lw	a1,0(s7)
 826:	855a                	mv	a0,s6
 828:	e8dff0ef          	jal	6b4 <printint>
 82c:	8bca                	mv	s7,s2
      state = 0;
 82e:	4981                	li	s3,0
 830:	bfa5                	j	7a8 <vprintf+0x4c>
      } else if(c0 == 'l' && c1 == 'd'){
 832:	06400793          	li	a5,100
 836:	02f68963          	beq	a3,a5,868 <vprintf+0x10c>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 83a:	06c00793          	li	a5,108
 83e:	04f68263          	beq	a3,a5,882 <vprintf+0x126>
      } else if(c0 == 'l' && c1 == 'u'){
 842:	07500793          	li	a5,117
 846:	0af68063          	beq	a3,a5,8e6 <vprintf+0x18a>
      } else if(c0 == 'l' && c1 == 'x'){
 84a:	07800793          	li	a5,120
 84e:	0ef68263          	beq	a3,a5,932 <vprintf+0x1d6>
        putc(fd, '%');
 852:	02500593          	li	a1,37
 856:	855a                	mv	a0,s6
 858:	e3fff0ef          	jal	696 <putc>
        putc(fd, c0);
 85c:	85ca                	mv	a1,s2
 85e:	855a                	mv	a0,s6
 860:	e37ff0ef          	jal	696 <putc>
      state = 0;
 864:	4981                	li	s3,0
 866:	b789                	j	7a8 <vprintf+0x4c>
        printint(fd, va_arg(ap, uint64), 10, 1);
 868:	008b8913          	add	s2,s7,8
 86c:	4685                	li	a3,1
 86e:	4629                	li	a2,10
 870:	000bb583          	ld	a1,0(s7)
 874:	855a                	mv	a0,s6
 876:	e3fff0ef          	jal	6b4 <printint>
        i += 1;
 87a:	2485                	addw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 87c:	8bca                	mv	s7,s2
      state = 0;
 87e:	4981                	li	s3,0
        i += 1;
 880:	b725                	j	7a8 <vprintf+0x4c>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 882:	06400793          	li	a5,100
 886:	02f60763          	beq	a2,a5,8b4 <vprintf+0x158>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 88a:	07500793          	li	a5,117
 88e:	06f60963          	beq	a2,a5,900 <vprintf+0x1a4>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 892:	07800793          	li	a5,120
 896:	faf61ee3          	bne	a2,a5,852 <vprintf+0xf6>
        printint(fd, va_arg(ap, uint64), 16, 0);
 89a:	008b8913          	add	s2,s7,8
 89e:	4681                	li	a3,0
 8a0:	4641                	li	a2,16
 8a2:	000bb583          	ld	a1,0(s7)
 8a6:	855a                	mv	a0,s6
 8a8:	e0dff0ef          	jal	6b4 <printint>
        i += 2;
 8ac:	2489                	addw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 8ae:	8bca                	mv	s7,s2
      state = 0;
 8b0:	4981                	li	s3,0
        i += 2;
 8b2:	bddd                	j	7a8 <vprintf+0x4c>
        printint(fd, va_arg(ap, uint64), 10, 1);
 8b4:	008b8913          	add	s2,s7,8
 8b8:	4685                	li	a3,1
 8ba:	4629                	li	a2,10
 8bc:	000bb583          	ld	a1,0(s7)
 8c0:	855a                	mv	a0,s6
 8c2:	df3ff0ef          	jal	6b4 <printint>
        i += 2;
 8c6:	2489                	addw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 8c8:	8bca                	mv	s7,s2
      state = 0;
 8ca:	4981                	li	s3,0
        i += 2;
 8cc:	bdf1                	j	7a8 <vprintf+0x4c>
        printint(fd, va_arg(ap, int), 10, 0);
 8ce:	008b8913          	add	s2,s7,8
 8d2:	4681                	li	a3,0
 8d4:	4629                	li	a2,10
 8d6:	000ba583          	lw	a1,0(s7)
 8da:	855a                	mv	a0,s6
 8dc:	dd9ff0ef          	jal	6b4 <printint>
 8e0:	8bca                	mv	s7,s2
      state = 0;
 8e2:	4981                	li	s3,0
 8e4:	b5d1                	j	7a8 <vprintf+0x4c>
        printint(fd, va_arg(ap, uint64), 10, 0);
 8e6:	008b8913          	add	s2,s7,8
 8ea:	4681                	li	a3,0
 8ec:	4629                	li	a2,10
 8ee:	000bb583          	ld	a1,0(s7)
 8f2:	855a                	mv	a0,s6
 8f4:	dc1ff0ef          	jal	6b4 <printint>
        i += 1;
 8f8:	2485                	addw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 8fa:	8bca                	mv	s7,s2
      state = 0;
 8fc:	4981                	li	s3,0
        i += 1;
 8fe:	b56d                	j	7a8 <vprintf+0x4c>
        printint(fd, va_arg(ap, uint64), 10, 0);
 900:	008b8913          	add	s2,s7,8
 904:	4681                	li	a3,0
 906:	4629                	li	a2,10
 908:	000bb583          	ld	a1,0(s7)
 90c:	855a                	mv	a0,s6
 90e:	da7ff0ef          	jal	6b4 <printint>
        i += 2;
 912:	2489                	addw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 914:	8bca                	mv	s7,s2
      state = 0;
 916:	4981                	li	s3,0
        i += 2;
 918:	bd41                	j	7a8 <vprintf+0x4c>
        printint(fd, va_arg(ap, int), 16, 0);
 91a:	008b8913          	add	s2,s7,8
 91e:	4681                	li	a3,0
 920:	4641                	li	a2,16
 922:	000ba583          	lw	a1,0(s7)
 926:	855a                	mv	a0,s6
 928:	d8dff0ef          	jal	6b4 <printint>
 92c:	8bca                	mv	s7,s2
      state = 0;
 92e:	4981                	li	s3,0
 930:	bda5                	j	7a8 <vprintf+0x4c>
        printint(fd, va_arg(ap, uint64), 16, 0);
 932:	008b8913          	add	s2,s7,8
 936:	4681                	li	a3,0
 938:	4641                	li	a2,16
 93a:	000bb583          	ld	a1,0(s7)
 93e:	855a                	mv	a0,s6
 940:	d75ff0ef          	jal	6b4 <printint>
        i += 1;
 944:	2485                	addw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 946:	8bca                	mv	s7,s2
      state = 0;
 948:	4981                	li	s3,0
        i += 1;
 94a:	bdb9                	j	7a8 <vprintf+0x4c>
        printptr(fd, va_arg(ap, uint64));
 94c:	008b8d13          	add	s10,s7,8
 950:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 954:	03000593          	li	a1,48
 958:	855a                	mv	a0,s6
 95a:	d3dff0ef          	jal	696 <putc>
  putc(fd, 'x');
 95e:	07800593          	li	a1,120
 962:	855a                	mv	a0,s6
 964:	d33ff0ef          	jal	696 <putc>
 968:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 96a:	00000b97          	auipc	s7,0x0
 96e:	2c6b8b93          	add	s7,s7,710 # c30 <digits>
 972:	03c9d793          	srl	a5,s3,0x3c
 976:	97de                	add	a5,a5,s7
 978:	0007c583          	lbu	a1,0(a5)
 97c:	855a                	mv	a0,s6
 97e:	d19ff0ef          	jal	696 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 982:	0992                	sll	s3,s3,0x4
 984:	397d                	addw	s2,s2,-1
 986:	fe0916e3          	bnez	s2,972 <vprintf+0x216>
        printptr(fd, va_arg(ap, uint64));
 98a:	8bea                	mv	s7,s10
      state = 0;
 98c:	4981                	li	s3,0
 98e:	bd29                	j	7a8 <vprintf+0x4c>
        if((s = va_arg(ap, char*)) == 0)
 990:	008b8993          	add	s3,s7,8
 994:	000bb903          	ld	s2,0(s7)
 998:	00090f63          	beqz	s2,9b6 <vprintf+0x25a>
        for(; *s; s++)
 99c:	00094583          	lbu	a1,0(s2)
 9a0:	c195                	beqz	a1,9c4 <vprintf+0x268>
          putc(fd, *s);
 9a2:	855a                	mv	a0,s6
 9a4:	cf3ff0ef          	jal	696 <putc>
        for(; *s; s++)
 9a8:	0905                	add	s2,s2,1
 9aa:	00094583          	lbu	a1,0(s2)
 9ae:	f9f5                	bnez	a1,9a2 <vprintf+0x246>
        if((s = va_arg(ap, char*)) == 0)
 9b0:	8bce                	mv	s7,s3
      state = 0;
 9b2:	4981                	li	s3,0
 9b4:	bbd5                	j	7a8 <vprintf+0x4c>
          s = "(null)";
 9b6:	00000917          	auipc	s2,0x0
 9ba:	27290913          	add	s2,s2,626 # c28 <malloc+0x164>
        for(; *s; s++)
 9be:	02800593          	li	a1,40
 9c2:	b7c5                	j	9a2 <vprintf+0x246>
        if((s = va_arg(ap, char*)) == 0)
 9c4:	8bce                	mv	s7,s3
      state = 0;
 9c6:	4981                	li	s3,0
 9c8:	b3c5                	j	7a8 <vprintf+0x4c>
    }
  }
}
 9ca:	60e6                	ld	ra,88(sp)
 9cc:	6446                	ld	s0,80(sp)
 9ce:	64a6                	ld	s1,72(sp)
 9d0:	6906                	ld	s2,64(sp)
 9d2:	79e2                	ld	s3,56(sp)
 9d4:	7a42                	ld	s4,48(sp)
 9d6:	7aa2                	ld	s5,40(sp)
 9d8:	7b02                	ld	s6,32(sp)
 9da:	6be2                	ld	s7,24(sp)
 9dc:	6c42                	ld	s8,16(sp)
 9de:	6ca2                	ld	s9,8(sp)
 9e0:	6d02                	ld	s10,0(sp)
 9e2:	6125                	add	sp,sp,96
 9e4:	8082                	ret

00000000000009e6 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 9e6:	715d                	add	sp,sp,-80
 9e8:	ec06                	sd	ra,24(sp)
 9ea:	e822                	sd	s0,16(sp)
 9ec:	1000                	add	s0,sp,32
 9ee:	e010                	sd	a2,0(s0)
 9f0:	e414                	sd	a3,8(s0)
 9f2:	e818                	sd	a4,16(s0)
 9f4:	ec1c                	sd	a5,24(s0)
 9f6:	03043023          	sd	a6,32(s0)
 9fa:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 9fe:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 a02:	8622                	mv	a2,s0
 a04:	d59ff0ef          	jal	75c <vprintf>
}
 a08:	60e2                	ld	ra,24(sp)
 a0a:	6442                	ld	s0,16(sp)
 a0c:	6161                	add	sp,sp,80
 a0e:	8082                	ret

0000000000000a10 <printf>:

void
printf(const char *fmt, ...)
{
 a10:	711d                	add	sp,sp,-96
 a12:	ec06                	sd	ra,24(sp)
 a14:	e822                	sd	s0,16(sp)
 a16:	1000                	add	s0,sp,32
 a18:	e40c                	sd	a1,8(s0)
 a1a:	e810                	sd	a2,16(s0)
 a1c:	ec14                	sd	a3,24(s0)
 a1e:	f018                	sd	a4,32(s0)
 a20:	f41c                	sd	a5,40(s0)
 a22:	03043823          	sd	a6,48(s0)
 a26:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 a2a:	00840613          	add	a2,s0,8
 a2e:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 a32:	85aa                	mv	a1,a0
 a34:	4505                	li	a0,1
 a36:	d27ff0ef          	jal	75c <vprintf>
}
 a3a:	60e2                	ld	ra,24(sp)
 a3c:	6442                	ld	s0,16(sp)
 a3e:	6125                	add	sp,sp,96
 a40:	8082                	ret

0000000000000a42 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 a42:	1141                	add	sp,sp,-16
 a44:	e422                	sd	s0,8(sp)
 a46:	0800                	add	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 a48:	ff050693          	add	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 a4c:	00000797          	auipc	a5,0x0
 a50:	5cc7b783          	ld	a5,1484(a5) # 1018 <freep>
 a54:	a02d                	j	a7e <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 a56:	4618                	lw	a4,8(a2)
 a58:	9f2d                	addw	a4,a4,a1
 a5a:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 a5e:	6398                	ld	a4,0(a5)
 a60:	6310                	ld	a2,0(a4)
 a62:	a83d                	j	aa0 <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 a64:	ff852703          	lw	a4,-8(a0)
 a68:	9f31                	addw	a4,a4,a2
 a6a:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 a6c:	ff053683          	ld	a3,-16(a0)
 a70:	a091                	j	ab4 <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 a72:	6398                	ld	a4,0(a5)
 a74:	00e7e463          	bltu	a5,a4,a7c <free+0x3a>
 a78:	00e6ea63          	bltu	a3,a4,a8c <free+0x4a>
{
 a7c:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 a7e:	fed7fae3          	bgeu	a5,a3,a72 <free+0x30>
 a82:	6398                	ld	a4,0(a5)
 a84:	00e6e463          	bltu	a3,a4,a8c <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 a88:	fee7eae3          	bltu	a5,a4,a7c <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 a8c:	ff852583          	lw	a1,-8(a0)
 a90:	6390                	ld	a2,0(a5)
 a92:	02059813          	sll	a6,a1,0x20
 a96:	01c85713          	srl	a4,a6,0x1c
 a9a:	9736                	add	a4,a4,a3
 a9c:	fae60de3          	beq	a2,a4,a56 <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 aa0:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 aa4:	4790                	lw	a2,8(a5)
 aa6:	02061593          	sll	a1,a2,0x20
 aaa:	01c5d713          	srl	a4,a1,0x1c
 aae:	973e                	add	a4,a4,a5
 ab0:	fae68ae3          	beq	a3,a4,a64 <free+0x22>
    p->s.ptr = bp->s.ptr;
 ab4:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 ab6:	00000717          	auipc	a4,0x0
 aba:	56f73123          	sd	a5,1378(a4) # 1018 <freep>
}
 abe:	6422                	ld	s0,8(sp)
 ac0:	0141                	add	sp,sp,16
 ac2:	8082                	ret

0000000000000ac4 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 ac4:	7139                	add	sp,sp,-64
 ac6:	fc06                	sd	ra,56(sp)
 ac8:	f822                	sd	s0,48(sp)
 aca:	f426                	sd	s1,40(sp)
 acc:	f04a                	sd	s2,32(sp)
 ace:	ec4e                	sd	s3,24(sp)
 ad0:	e852                	sd	s4,16(sp)
 ad2:	e456                	sd	s5,8(sp)
 ad4:	e05a                	sd	s6,0(sp)
 ad6:	0080                	add	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 ad8:	02051493          	sll	s1,a0,0x20
 adc:	9081                	srl	s1,s1,0x20
 ade:	04bd                	add	s1,s1,15
 ae0:	8091                	srl	s1,s1,0x4
 ae2:	0014899b          	addw	s3,s1,1
 ae6:	0485                	add	s1,s1,1
  if((prevp = freep) == 0){
 ae8:	00000517          	auipc	a0,0x0
 aec:	53053503          	ld	a0,1328(a0) # 1018 <freep>
 af0:	c515                	beqz	a0,b1c <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 af2:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 af4:	4798                	lw	a4,8(a5)
 af6:	02977f63          	bgeu	a4,s1,b34 <malloc+0x70>
  if(nu < 4096)
 afa:	8a4e                	mv	s4,s3
 afc:	0009871b          	sext.w	a4,s3
 b00:	6685                	lui	a3,0x1
 b02:	00d77363          	bgeu	a4,a3,b08 <malloc+0x44>
 b06:	6a05                	lui	s4,0x1
 b08:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 b0c:	004a1a1b          	sllw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 b10:	00000917          	auipc	s2,0x0
 b14:	50890913          	add	s2,s2,1288 # 1018 <freep>
  if(p == (char*)-1)
 b18:	5afd                	li	s5,-1
 b1a:	a885                	j	b8a <malloc+0xc6>
    base.s.ptr = freep = prevp = &base;
 b1c:	00000797          	auipc	a5,0x0
 b20:	50478793          	add	a5,a5,1284 # 1020 <base>
 b24:	00000717          	auipc	a4,0x0
 b28:	4ef73a23          	sd	a5,1268(a4) # 1018 <freep>
 b2c:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 b2e:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 b32:	b7e1                	j	afa <malloc+0x36>
      if(p->s.size == nunits)
 b34:	02e48c63          	beq	s1,a4,b6c <malloc+0xa8>
        p->s.size -= nunits;
 b38:	4137073b          	subw	a4,a4,s3
 b3c:	c798                	sw	a4,8(a5)
        p += p->s.size;
 b3e:	02071693          	sll	a3,a4,0x20
 b42:	01c6d713          	srl	a4,a3,0x1c
 b46:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 b48:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 b4c:	00000717          	auipc	a4,0x0
 b50:	4ca73623          	sd	a0,1228(a4) # 1018 <freep>
      return (void*)(p + 1);
 b54:	01078513          	add	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 b58:	70e2                	ld	ra,56(sp)
 b5a:	7442                	ld	s0,48(sp)
 b5c:	74a2                	ld	s1,40(sp)
 b5e:	7902                	ld	s2,32(sp)
 b60:	69e2                	ld	s3,24(sp)
 b62:	6a42                	ld	s4,16(sp)
 b64:	6aa2                	ld	s5,8(sp)
 b66:	6b02                	ld	s6,0(sp)
 b68:	6121                	add	sp,sp,64
 b6a:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 b6c:	6398                	ld	a4,0(a5)
 b6e:	e118                	sd	a4,0(a0)
 b70:	bff1                	j	b4c <malloc+0x88>
  hp->s.size = nu;
 b72:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 b76:	0541                	add	a0,a0,16
 b78:	ecbff0ef          	jal	a42 <free>
  return freep;
 b7c:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 b80:	dd61                	beqz	a0,b58 <malloc+0x94>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 b82:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 b84:	4798                	lw	a4,8(a5)
 b86:	fa9777e3          	bgeu	a4,s1,b34 <malloc+0x70>
    if(p == freep)
 b8a:	00093703          	ld	a4,0(s2)
 b8e:	853e                	mv	a0,a5
 b90:	fef719e3          	bne	a4,a5,b82 <malloc+0xbe>
  p = sbrk(nu * sizeof(Header));
 b94:	8552                	mv	a0,s4
 b96:	a99ff0ef          	jal	62e <sbrk>
  if(p == (char*)-1)
 b9a:	fd551ce3          	bne	a0,s5,b72 <malloc+0xae>
        return 0;
 b9e:	4501                	li	a0,0
 ba0:	bf65                	j	b58 <malloc+0x94>
