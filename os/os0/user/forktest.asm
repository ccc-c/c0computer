
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
   c:	12c000ef          	jal	138 <strlen>
  10:	0005061b          	sext.w	a2,a0
  14:	85a6                	mv	a1,s1
  16:	4505                	li	a0,1
  18:	5b0000ef          	jal	5c8 <write>
}
  1c:	60e2                	ld	ra,24(sp)
  1e:	6442                	ld	s0,16(sp)
  20:	64a2                	ld	s1,8(sp)
  22:	6105                	add	sp,sp,32
  24:	8082                	ret

0000000000000026 <forktest>:

void
forktest(void)
{
  26:	1101                	add	sp,sp,-32
  28:	ec06                	sd	ra,24(sp)
  2a:	e822                	sd	s0,16(sp)
  2c:	e426                	sd	s1,8(sp)
  2e:	e04a                	sd	s2,0(sp)
  30:	1000                	add	s0,sp,32
  int n, pid;

  print("fork test\n");
  32:	00000517          	auipc	a0,0x0
  36:	66650513          	add	a0,a0,1638 # 698 <ioctl+0x8>
  3a:	fc7ff0ef          	jal	0 <print>

  for(n=0; n<N; n++){
  3e:	4481                	li	s1,0
  40:	3e800913          	li	s2,1000
    pid = fork();
  44:	55c000ef          	jal	5a0 <fork>
    if(pid < 0)
  48:	02054163          	bltz	a0,6a <forktest+0x44>
      break;
    if(pid == 0)
  4c:	cd09                	beqz	a0,66 <forktest+0x40>
  for(n=0; n<N; n++){
  4e:	2485                	addw	s1,s1,1
  50:	ff249ae3          	bne	s1,s2,44 <forktest+0x1e>
      exit(0);
  }

  if(n == N){
    print("fork claimed to work N times!\n");
  54:	00000517          	auipc	a0,0x0
  58:	65450513          	add	a0,a0,1620 # 6a8 <ioctl+0x18>
  5c:	fa5ff0ef          	jal	0 <print>
    exit(1);
  60:	4505                	li	a0,1
  62:	546000ef          	jal	5a8 <exit>
      exit(0);
  66:	542000ef          	jal	5a8 <exit>
  if(n == N){
  6a:	3e800793          	li	a5,1000
  6e:	fef483e3          	beq	s1,a5,54 <forktest+0x2e>
  }

  for(; n > 0; n--){
  72:	00905963          	blez	s1,84 <forktest+0x5e>
    if(wait(0) < 0){
  76:	4501                	li	a0,0
  78:	538000ef          	jal	5b0 <wait>
  7c:	02054663          	bltz	a0,a8 <forktest+0x82>
  for(; n > 0; n--){
  80:	34fd                	addw	s1,s1,-1
  82:	f8f5                	bnez	s1,76 <forktest+0x50>
      print("wait stopped early\n");
      exit(1);
    }
  }

  if(wait(0) != -1){
  84:	4501                	li	a0,0
  86:	52a000ef          	jal	5b0 <wait>
  8a:	57fd                	li	a5,-1
  8c:	02f51763          	bne	a0,a5,ba <forktest+0x94>
    print("wait got too many\n");
    exit(1);
  }

  print("fork test OK\n");
  90:	00000517          	auipc	a0,0x0
  94:	66850513          	add	a0,a0,1640 # 6f8 <ioctl+0x68>
  98:	f69ff0ef          	jal	0 <print>
}
  9c:	60e2                	ld	ra,24(sp)
  9e:	6442                	ld	s0,16(sp)
  a0:	64a2                	ld	s1,8(sp)
  a2:	6902                	ld	s2,0(sp)
  a4:	6105                	add	sp,sp,32
  a6:	8082                	ret
      print("wait stopped early\n");
  a8:	00000517          	auipc	a0,0x0
  ac:	62050513          	add	a0,a0,1568 # 6c8 <ioctl+0x38>
  b0:	f51ff0ef          	jal	0 <print>
      exit(1);
  b4:	4505                	li	a0,1
  b6:	4f2000ef          	jal	5a8 <exit>
    print("wait got too many\n");
  ba:	00000517          	auipc	a0,0x0
  be:	62650513          	add	a0,a0,1574 # 6e0 <ioctl+0x50>
  c2:	f3fff0ef          	jal	0 <print>
    exit(1);
  c6:	4505                	li	a0,1
  c8:	4e0000ef          	jal	5a8 <exit>

00000000000000cc <main>:

int
main(void)
{
  cc:	1141                	add	sp,sp,-16
  ce:	e406                	sd	ra,8(sp)
  d0:	e022                	sd	s0,0(sp)
  d2:	0800                	add	s0,sp,16
  forktest();
  d4:	f53ff0ef          	jal	26 <forktest>
  exit(0);
  d8:	4501                	li	a0,0
  da:	4ce000ef          	jal	5a8 <exit>

00000000000000de <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start()
{
  de:	1141                	add	sp,sp,-16
  e0:	e406                	sd	ra,8(sp)
  e2:	e022                	sd	s0,0(sp)
  e4:	0800                	add	s0,sp,16
  extern int main();
  main();
  e6:	fe7ff0ef          	jal	cc <main>
  exit(0);
  ea:	4501                	li	a0,0
  ec:	4bc000ef          	jal	5a8 <exit>

00000000000000f0 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
  f0:	1141                	add	sp,sp,-16
  f2:	e422                	sd	s0,8(sp)
  f4:	0800                	add	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  f6:	87aa                	mv	a5,a0
  f8:	0585                	add	a1,a1,1
  fa:	0785                	add	a5,a5,1
  fc:	fff5c703          	lbu	a4,-1(a1)
 100:	fee78fa3          	sb	a4,-1(a5)
 104:	fb75                	bnez	a4,f8 <strcpy+0x8>
    ;
  return os;
}
 106:	6422                	ld	s0,8(sp)
 108:	0141                	add	sp,sp,16
 10a:	8082                	ret

000000000000010c <strcmp>:

int
strcmp(const char *p, const char *q)
{
 10c:	1141                	add	sp,sp,-16
 10e:	e422                	sd	s0,8(sp)
 110:	0800                	add	s0,sp,16
  while(*p && *p == *q)
 112:	00054783          	lbu	a5,0(a0)
 116:	cb91                	beqz	a5,12a <strcmp+0x1e>
 118:	0005c703          	lbu	a4,0(a1)
 11c:	00f71763          	bne	a4,a5,12a <strcmp+0x1e>
    p++, q++;
 120:	0505                	add	a0,a0,1
 122:	0585                	add	a1,a1,1
  while(*p && *p == *q)
 124:	00054783          	lbu	a5,0(a0)
 128:	fbe5                	bnez	a5,118 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 12a:	0005c503          	lbu	a0,0(a1)
}
 12e:	40a7853b          	subw	a0,a5,a0
 132:	6422                	ld	s0,8(sp)
 134:	0141                	add	sp,sp,16
 136:	8082                	ret

0000000000000138 <strlen>:

uint
strlen(const char *s)
{
 138:	1141                	add	sp,sp,-16
 13a:	e422                	sd	s0,8(sp)
 13c:	0800                	add	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 13e:	00054783          	lbu	a5,0(a0)
 142:	cf91                	beqz	a5,15e <strlen+0x26>
 144:	0505                	add	a0,a0,1
 146:	87aa                	mv	a5,a0
 148:	86be                	mv	a3,a5
 14a:	0785                	add	a5,a5,1
 14c:	fff7c703          	lbu	a4,-1(a5)
 150:	ff65                	bnez	a4,148 <strlen+0x10>
 152:	40a6853b          	subw	a0,a3,a0
 156:	2505                	addw	a0,a0,1
    ;
  return n;
}
 158:	6422                	ld	s0,8(sp)
 15a:	0141                	add	sp,sp,16
 15c:	8082                	ret
  for(n = 0; s[n]; n++)
 15e:	4501                	li	a0,0
 160:	bfe5                	j	158 <strlen+0x20>

0000000000000162 <memset>:

void*
memset(void *dst, int c, uint n)
{
 162:	1141                	add	sp,sp,-16
 164:	e422                	sd	s0,8(sp)
 166:	0800                	add	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 168:	ca19                	beqz	a2,17e <memset+0x1c>
 16a:	87aa                	mv	a5,a0
 16c:	1602                	sll	a2,a2,0x20
 16e:	9201                	srl	a2,a2,0x20
 170:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 174:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 178:	0785                	add	a5,a5,1
 17a:	fee79de3          	bne	a5,a4,174 <memset+0x12>
  }
  return dst;
}
 17e:	6422                	ld	s0,8(sp)
 180:	0141                	add	sp,sp,16
 182:	8082                	ret

0000000000000184 <strchr>:

char*
strchr(const char *s, char c)
{
 184:	1141                	add	sp,sp,-16
 186:	e422                	sd	s0,8(sp)
 188:	0800                	add	s0,sp,16
  for(; *s; s++)
 18a:	00054783          	lbu	a5,0(a0)
 18e:	cb99                	beqz	a5,1a4 <strchr+0x20>
    if(*s == c)
 190:	00f58763          	beq	a1,a5,19e <strchr+0x1a>
  for(; *s; s++)
 194:	0505                	add	a0,a0,1
 196:	00054783          	lbu	a5,0(a0)
 19a:	fbfd                	bnez	a5,190 <strchr+0xc>
      return (char*)s;
  return 0;
 19c:	4501                	li	a0,0
}
 19e:	6422                	ld	s0,8(sp)
 1a0:	0141                	add	sp,sp,16
 1a2:	8082                	ret
  return 0;
 1a4:	4501                	li	a0,0
 1a6:	bfe5                	j	19e <strchr+0x1a>

00000000000001a8 <gets>:

char*
gets(char *buf, int max)
{
 1a8:	711d                	add	sp,sp,-96
 1aa:	ec86                	sd	ra,88(sp)
 1ac:	e8a2                	sd	s0,80(sp)
 1ae:	e4a6                	sd	s1,72(sp)
 1b0:	e0ca                	sd	s2,64(sp)
 1b2:	fc4e                	sd	s3,56(sp)
 1b4:	f852                	sd	s4,48(sp)
 1b6:	f456                	sd	s5,40(sp)
 1b8:	f05a                	sd	s6,32(sp)
 1ba:	ec5e                	sd	s7,24(sp)
 1bc:	1080                	add	s0,sp,96
 1be:	8baa                	mv	s7,a0
 1c0:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1c2:	892a                	mv	s2,a0
 1c4:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 1c6:	4aa9                	li	s5,10
 1c8:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 1ca:	89a6                	mv	s3,s1
 1cc:	2485                	addw	s1,s1,1
 1ce:	0344d663          	bge	s1,s4,1fa <gets+0x52>
    cc = read(0, &c, 1);
 1d2:	4605                	li	a2,1
 1d4:	faf40593          	add	a1,s0,-81
 1d8:	4501                	li	a0,0
 1da:	3e6000ef          	jal	5c0 <read>
    if(cc < 1)
 1de:	00a05e63          	blez	a0,1fa <gets+0x52>
    buf[i++] = c;
 1e2:	faf44783          	lbu	a5,-81(s0)
 1e6:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 1ea:	01578763          	beq	a5,s5,1f8 <gets+0x50>
 1ee:	0905                	add	s2,s2,1
 1f0:	fd679de3          	bne	a5,s6,1ca <gets+0x22>
  for(i=0; i+1 < max; ){
 1f4:	89a6                	mv	s3,s1
 1f6:	a011                	j	1fa <gets+0x52>
 1f8:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 1fa:	99de                	add	s3,s3,s7
 1fc:	00098023          	sb	zero,0(s3)
  return buf;
}
 200:	855e                	mv	a0,s7
 202:	60e6                	ld	ra,88(sp)
 204:	6446                	ld	s0,80(sp)
 206:	64a6                	ld	s1,72(sp)
 208:	6906                	ld	s2,64(sp)
 20a:	79e2                	ld	s3,56(sp)
 20c:	7a42                	ld	s4,48(sp)
 20e:	7aa2                	ld	s5,40(sp)
 210:	7b02                	ld	s6,32(sp)
 212:	6be2                	ld	s7,24(sp)
 214:	6125                	add	sp,sp,96
 216:	8082                	ret

0000000000000218 <stat>:

int
stat(const char *n, struct stat *st)
{
 218:	1101                	add	sp,sp,-32
 21a:	ec06                	sd	ra,24(sp)
 21c:	e822                	sd	s0,16(sp)
 21e:	e426                	sd	s1,8(sp)
 220:	e04a                	sd	s2,0(sp)
 222:	1000                	add	s0,sp,32
 224:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 226:	4581                	li	a1,0
 228:	3c0000ef          	jal	5e8 <open>
  if(fd < 0)
 22c:	02054163          	bltz	a0,24e <stat+0x36>
 230:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 232:	85ca                	mv	a1,s2
 234:	3cc000ef          	jal	600 <fstat>
 238:	892a                	mv	s2,a0
  close(fd);
 23a:	8526                	mv	a0,s1
 23c:	394000ef          	jal	5d0 <close>
  return r;
}
 240:	854a                	mv	a0,s2
 242:	60e2                	ld	ra,24(sp)
 244:	6442                	ld	s0,16(sp)
 246:	64a2                	ld	s1,8(sp)
 248:	6902                	ld	s2,0(sp)
 24a:	6105                	add	sp,sp,32
 24c:	8082                	ret
    return -1;
 24e:	597d                	li	s2,-1
 250:	bfc5                	j	240 <stat+0x28>

0000000000000252 <atoi>:

int
atoi(const char *s)
{
 252:	1141                	add	sp,sp,-16
 254:	e422                	sd	s0,8(sp)
 256:	0800                	add	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 258:	00054683          	lbu	a3,0(a0)
 25c:	fd06879b          	addw	a5,a3,-48
 260:	0ff7f793          	zext.b	a5,a5
 264:	4625                	li	a2,9
 266:	02f66863          	bltu	a2,a5,296 <atoi+0x44>
 26a:	872a                	mv	a4,a0
  n = 0;
 26c:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 26e:	0705                	add	a4,a4,1
 270:	0025179b          	sllw	a5,a0,0x2
 274:	9fa9                	addw	a5,a5,a0
 276:	0017979b          	sllw	a5,a5,0x1
 27a:	9fb5                	addw	a5,a5,a3
 27c:	fd07851b          	addw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 280:	00074683          	lbu	a3,0(a4)
 284:	fd06879b          	addw	a5,a3,-48
 288:	0ff7f793          	zext.b	a5,a5
 28c:	fef671e3          	bgeu	a2,a5,26e <atoi+0x1c>
  return n;
}
 290:	6422                	ld	s0,8(sp)
 292:	0141                	add	sp,sp,16
 294:	8082                	ret
  n = 0;
 296:	4501                	li	a0,0
 298:	bfe5                	j	290 <atoi+0x3e>

000000000000029a <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 29a:	1141                	add	sp,sp,-16
 29c:	e422                	sd	s0,8(sp)
 29e:	0800                	add	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 2a0:	02b57463          	bgeu	a0,a1,2c8 <memmove+0x2e>
    while(n-- > 0)
 2a4:	00c05f63          	blez	a2,2c2 <memmove+0x28>
 2a8:	1602                	sll	a2,a2,0x20
 2aa:	9201                	srl	a2,a2,0x20
 2ac:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 2b0:	872a                	mv	a4,a0
      *dst++ = *src++;
 2b2:	0585                	add	a1,a1,1
 2b4:	0705                	add	a4,a4,1
 2b6:	fff5c683          	lbu	a3,-1(a1)
 2ba:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 2be:	fee79ae3          	bne	a5,a4,2b2 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 2c2:	6422                	ld	s0,8(sp)
 2c4:	0141                	add	sp,sp,16
 2c6:	8082                	ret
    dst += n;
 2c8:	00c50733          	add	a4,a0,a2
    src += n;
 2cc:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 2ce:	fec05ae3          	blez	a2,2c2 <memmove+0x28>
 2d2:	fff6079b          	addw	a5,a2,-1
 2d6:	1782                	sll	a5,a5,0x20
 2d8:	9381                	srl	a5,a5,0x20
 2da:	fff7c793          	not	a5,a5
 2de:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 2e0:	15fd                	add	a1,a1,-1
 2e2:	177d                	add	a4,a4,-1
 2e4:	0005c683          	lbu	a3,0(a1)
 2e8:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 2ec:	fee79ae3          	bne	a5,a4,2e0 <memmove+0x46>
 2f0:	bfc9                	j	2c2 <memmove+0x28>

00000000000002f2 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 2f2:	1141                	add	sp,sp,-16
 2f4:	e422                	sd	s0,8(sp)
 2f6:	0800                	add	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 2f8:	ca05                	beqz	a2,328 <memcmp+0x36>
 2fa:	fff6069b          	addw	a3,a2,-1
 2fe:	1682                	sll	a3,a3,0x20
 300:	9281                	srl	a3,a3,0x20
 302:	0685                	add	a3,a3,1
 304:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 306:	00054783          	lbu	a5,0(a0)
 30a:	0005c703          	lbu	a4,0(a1)
 30e:	00e79863          	bne	a5,a4,31e <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 312:	0505                	add	a0,a0,1
    p2++;
 314:	0585                	add	a1,a1,1
  while (n-- > 0) {
 316:	fed518e3          	bne	a0,a3,306 <memcmp+0x14>
  }
  return 0;
 31a:	4501                	li	a0,0
 31c:	a019                	j	322 <memcmp+0x30>
      return *p1 - *p2;
 31e:	40e7853b          	subw	a0,a5,a4
}
 322:	6422                	ld	s0,8(sp)
 324:	0141                	add	sp,sp,16
 326:	8082                	ret
  return 0;
 328:	4501                	li	a0,0
 32a:	bfe5                	j	322 <memcmp+0x30>

000000000000032c <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 32c:	1141                	add	sp,sp,-16
 32e:	e406                	sd	ra,8(sp)
 330:	e022                	sd	s0,0(sp)
 332:	0800                	add	s0,sp,16
  return memmove(dst, src, n);
 334:	f67ff0ef          	jal	29a <memmove>
}
 338:	60a2                	ld	ra,8(sp)
 33a:	6402                	ld	s0,0(sp)
 33c:	0141                	add	sp,sp,16
 33e:	8082                	ret

0000000000000340 <htons>:
    return (v & 0x000000ff) << 24 | (v & 0x0000ff00) << 8 | (v & 0x00ff0000) >> 8 | (v & 0xff000000) >> 24;
}

uint16_t
htons(uint16_t h)
{
 340:	1141                	add	sp,sp,-16
 342:	e422                	sd	s0,8(sp)
 344:	0800                	add	s0,sp,16
    if (!endian) {
 346:	70802783          	lw	a5,1800(zero) # 708 <endian>
 34a:	ef91                	bnez	a5,366 <htons+0x26>
        endian = byteorder();
 34c:	4d200793          	li	a5,1234
 350:	70f02423          	sw	a5,1800(zero) # 708 <endian>
    return (v & 0x00ff) << 8 | (v & 0xff00 ) >> 8;
 354:	0085579b          	srlw	a5,a0,0x8
 358:	0085151b          	sllw	a0,a0,0x8
 35c:	8fc9                	or	a5,a5,a0
 35e:	03079513          	sll	a0,a5,0x30
 362:	9141                	srl	a0,a0,0x30
 364:	a029                	j	36e <htons+0x2e>
    }
    return endian == __LITTLE_ENDIAN ? byteswap16(h) : h;
 366:	4d200713          	li	a4,1234
 36a:	fee785e3          	beq	a5,a4,354 <htons+0x14>
}
 36e:	6422                	ld	s0,8(sp)
 370:	0141                	add	sp,sp,16
 372:	8082                	ret

0000000000000374 <ntohs>:

uint16_t
ntohs(uint16_t n)
{
 374:	1141                	add	sp,sp,-16
 376:	e422                	sd	s0,8(sp)
 378:	0800                	add	s0,sp,16
    if (!endian) {
 37a:	70802783          	lw	a5,1800(zero) # 708 <endian>
 37e:	ef91                	bnez	a5,39a <ntohs+0x26>
        endian = byteorder();
 380:	4d200793          	li	a5,1234
 384:	70f02423          	sw	a5,1800(zero) # 708 <endian>
    return (v & 0x00ff) << 8 | (v & 0xff00 ) >> 8;
 388:	0085579b          	srlw	a5,a0,0x8
 38c:	0085151b          	sllw	a0,a0,0x8
 390:	8fc9                	or	a5,a5,a0
 392:	03079513          	sll	a0,a5,0x30
 396:	9141                	srl	a0,a0,0x30
 398:	a029                	j	3a2 <ntohs+0x2e>
    }
    return endian == __LITTLE_ENDIAN ? byteswap16(n) : n;
 39a:	4d200713          	li	a4,1234
 39e:	fee785e3          	beq	a5,a4,388 <ntohs+0x14>
}
 3a2:	6422                	ld	s0,8(sp)
 3a4:	0141                	add	sp,sp,16
 3a6:	8082                	ret

00000000000003a8 <htonl>:

uint32_t
htonl(uint32_t h)
{
 3a8:	1141                	add	sp,sp,-16
 3aa:	e422                	sd	s0,8(sp)
 3ac:	0800                	add	s0,sp,16
    if (!endian) {
 3ae:	70802783          	lw	a5,1800(zero) # 708 <endian>
 3b2:	eb95                	bnez	a5,3e6 <htonl+0x3e>
        endian = byteorder();
 3b4:	4d200793          	li	a5,1234
 3b8:	70f02423          	sw	a5,1800(zero) # 708 <endian>
    return (v & 0x000000ff) << 24 | (v & 0x0000ff00) << 8 | (v & 0x00ff0000) >> 8 | (v & 0xff000000) >> 24;
 3bc:	0185179b          	sllw	a5,a0,0x18
 3c0:	0185571b          	srlw	a4,a0,0x18
 3c4:	8fd9                	or	a5,a5,a4
 3c6:	0085171b          	sllw	a4,a0,0x8
 3ca:	00ff06b7          	lui	a3,0xff0
 3ce:	8f75                	and	a4,a4,a3
 3d0:	8fd9                	or	a5,a5,a4
 3d2:	0085551b          	srlw	a0,a0,0x8
 3d6:	6741                	lui	a4,0x10
 3d8:	f0070713          	add	a4,a4,-256 # ff00 <__global_pointer$+0xeffa>
 3dc:	8d79                	and	a0,a0,a4
 3de:	8fc9                	or	a5,a5,a0
 3e0:	0007851b          	sext.w	a0,a5
 3e4:	a029                	j	3ee <htonl+0x46>
    }
    return endian == __LITTLE_ENDIAN ? byteswap32(h) : h;
 3e6:	4d200713          	li	a4,1234
 3ea:	fce789e3          	beq	a5,a4,3bc <htonl+0x14>
}
 3ee:	6422                	ld	s0,8(sp)
 3f0:	0141                	add	sp,sp,16
 3f2:	8082                	ret

00000000000003f4 <ntohl>:

uint32_t
ntohl(uint32_t n)
{
 3f4:	1141                	add	sp,sp,-16
 3f6:	e422                	sd	s0,8(sp)
 3f8:	0800                	add	s0,sp,16
    if (!endian) {
 3fa:	70802783          	lw	a5,1800(zero) # 708 <endian>
 3fe:	eb95                	bnez	a5,432 <ntohl+0x3e>
        endian = byteorder();
 400:	4d200793          	li	a5,1234
 404:	70f02423          	sw	a5,1800(zero) # 708 <endian>
    return (v & 0x000000ff) << 24 | (v & 0x0000ff00) << 8 | (v & 0x00ff0000) >> 8 | (v & 0xff000000) >> 24;
 408:	0185179b          	sllw	a5,a0,0x18
 40c:	0185571b          	srlw	a4,a0,0x18
 410:	8fd9                	or	a5,a5,a4
 412:	0085171b          	sllw	a4,a0,0x8
 416:	00ff06b7          	lui	a3,0xff0
 41a:	8f75                	and	a4,a4,a3
 41c:	8fd9                	or	a5,a5,a4
 41e:	0085551b          	srlw	a0,a0,0x8
 422:	6741                	lui	a4,0x10
 424:	f0070713          	add	a4,a4,-256 # ff00 <__global_pointer$+0xeffa>
 428:	8d79                	and	a0,a0,a4
 42a:	8fc9                	or	a5,a5,a0
 42c:	0007851b          	sext.w	a0,a5
 430:	a029                	j	43a <ntohl+0x46>
    }
    return endian == __LITTLE_ENDIAN ? byteswap32(n) : n;
 432:	4d200713          	li	a4,1234
 436:	fce789e3          	beq	a5,a4,408 <ntohl+0x14>
}
 43a:	6422                	ld	s0,8(sp)
 43c:	0141                	add	sp,sp,16
 43e:	8082                	ret

0000000000000440 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
 440:	1141                	add	sp,sp,-16
 442:	e422                	sd	s0,8(sp)
 444:	0800                	add	s0,sp,16
 446:	872a                	mv	a4,a0
    int neg = 0;
    long val = 0;

    // gobble initial whitespace
    while (*s == ' ' || *s == '\t')
 448:	02000693          	li	a3,32
 44c:	4525                	li	a0,9
 44e:	a011                	j	452 <strtol+0x12>
        s++;
 450:	0705                	add	a4,a4,1
    while (*s == ' ' || *s == '\t')
 452:	00074783          	lbu	a5,0(a4)
 456:	fed78de3          	beq	a5,a3,450 <strtol+0x10>
 45a:	fea78be3          	beq	a5,a0,450 <strtol+0x10>

    // plus/minus sign
    if (*s == '+')
 45e:	02b00693          	li	a3,43
 462:	02d78663          	beq	a5,a3,48e <strtol+0x4e>
        s++;
    else if (*s == '-')
 466:	02d00693          	li	a3,45
    int neg = 0;
 46a:	4301                	li	t1,0
    else if (*s == '-')
 46c:	02d78463          	beq	a5,a3,494 <strtol+0x54>
        s++, neg = 1;

    // hex or octal base prefix
    if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
 470:	fef67793          	and	a5,a2,-17
 474:	eb89                	bnez	a5,486 <strtol+0x46>
 476:	00074683          	lbu	a3,0(a4)
 47a:	03000793          	li	a5,48
 47e:	00f68e63          	beq	a3,a5,49a <strtol+0x5a>
        s += 2, base = 16;
    else if (base == 0 && s[0] == '0')
 482:	e211                	bnez	a2,486 <strtol+0x46>
        s++, base = 8;
    else if (base == 0)
        base = 10;
 484:	4629                	li	a2,10
 486:	4501                	li	a0,0

    // digits
    while (1) {
        int dig;

        if (*s >= '0' && *s <= '9')
 488:	4825                	li	a6,9
            dig = *s - '0';
        else if (*s >= 'a' && *s <= 'z')
 48a:	48e5                	li	a7,25
 48c:	a825                	j	4c4 <strtol+0x84>
        s++;
 48e:	0705                	add	a4,a4,1
    int neg = 0;
 490:	4301                	li	t1,0
 492:	bff9                	j	470 <strtol+0x30>
        s++, neg = 1;
 494:	0705                	add	a4,a4,1
 496:	4305                	li	t1,1
 498:	bfe1                	j	470 <strtol+0x30>
    if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
 49a:	00174683          	lbu	a3,1(a4)
 49e:	07800793          	li	a5,120
 4a2:	00f68663          	beq	a3,a5,4ae <strtol+0x6e>
    else if (base == 0 && s[0] == '0')
 4a6:	f265                	bnez	a2,486 <strtol+0x46>
        s++, base = 8;
 4a8:	0705                	add	a4,a4,1
 4aa:	4621                	li	a2,8
 4ac:	bfe9                	j	486 <strtol+0x46>
        s += 2, base = 16;
 4ae:	0709                	add	a4,a4,2
 4b0:	4641                	li	a2,16
 4b2:	bfd1                	j	486 <strtol+0x46>
            dig = *s - '0';
 4b4:	fd07879b          	addw	a5,a5,-48
            dig = *s - 'a' + 10;
        else if (*s >= 'A' && *s <= 'Z')
            dig = *s - 'A' + 10;
        else
            break;
        if (dig >= base)
 4b8:	04c7d063          	bge	a5,a2,4f8 <strtol+0xb8>
            break;
        s++, val = (val * base) + dig;
 4bc:	0705                	add	a4,a4,1
 4be:	02a60533          	mul	a0,a2,a0
 4c2:	953e                	add	a0,a0,a5
        if (*s >= '0' && *s <= '9')
 4c4:	00074783          	lbu	a5,0(a4)
 4c8:	fd07869b          	addw	a3,a5,-48
 4cc:	0ff6f693          	zext.b	a3,a3
 4d0:	fed872e3          	bgeu	a6,a3,4b4 <strtol+0x74>
        else if (*s >= 'a' && *s <= 'z')
 4d4:	f9f7869b          	addw	a3,a5,-97
 4d8:	0ff6f693          	zext.b	a3,a3
 4dc:	00d8e563          	bltu	a7,a3,4e6 <strtol+0xa6>
            dig = *s - 'a' + 10;
 4e0:	fa97879b          	addw	a5,a5,-87
 4e4:	bfd1                	j	4b8 <strtol+0x78>
        else if (*s >= 'A' && *s <= 'Z')
 4e6:	fbf7869b          	addw	a3,a5,-65
 4ea:	0ff6f693          	zext.b	a3,a3
 4ee:	00d8e563          	bltu	a7,a3,4f8 <strtol+0xb8>
            dig = *s - 'A' + 10;
 4f2:	fc97879b          	addw	a5,a5,-55
 4f6:	b7c9                	j	4b8 <strtol+0x78>
        // we don't properly detect overflow!
    }

    if (endptr)
 4f8:	c191                	beqz	a1,4fc <strtol+0xbc>
        *endptr = (char *) s;
 4fa:	e198                	sd	a4,0(a1)
    return (neg ? -val : val);
 4fc:	00030463          	beqz	t1,504 <strtol+0xc4>
 500:	40a00533          	neg	a0,a0
}
 504:	6422                	ld	s0,8(sp)
 506:	0141                	add	sp,sp,16
 508:	8082                	ret

000000000000050a <inet_pton>:
inet_pton (int family, const char *p, void *n) {
    char *sp, *ep;
    int idx;
    long ret;

    if (family != AF_INET) {
 50a:	4785                	li	a5,1
 50c:	08f51263          	bne	a0,a5,590 <inet_pton+0x86>
inet_pton (int family, const char *p, void *n) {
 510:	715d                	add	sp,sp,-80
 512:	e486                	sd	ra,72(sp)
 514:	e0a2                	sd	s0,64(sp)
 516:	fc26                	sd	s1,56(sp)
 518:	f84a                	sd	s2,48(sp)
 51a:	f44e                	sd	s3,40(sp)
 51c:	f052                	sd	s4,32(sp)
 51e:	ec56                	sd	s5,24(sp)
 520:	e85a                	sd	s6,16(sp)
 522:	0880                	add	s0,sp,80
 524:	892e                	mv	s2,a1
 526:	89b2                	mv	s3,a2
 528:	4481                	li	s1,0
        return -1;
    }
    sp = (char *)p;
    for (idx = 0; idx < 4; idx++) {
        ret = strtol(sp, &ep, 10);
        if (ret < 0 || ret > 255) {
 52a:	0ff00a13          	li	s4,255
            return -1;
        }
        if (ep == sp) {
            return -1;
        }
        if ((idx == 3 && *ep != '\0') || (idx != 3 && *ep != '.')) {
 52e:	4a8d                	li	s5,3
 530:	02e00b13          	li	s6,46
 534:	a815                	j	568 <inet_pton+0x5e>
 536:	0007c783          	lbu	a5,0(a5)
 53a:	e3ad                	bnez	a5,59c <inet_pton+0x92>
            return -1;
        }
        ((uint8_t *)n)[idx] = ret;
 53c:	2481                	sext.w	s1,s1
 53e:	99a6                	add	s3,s3,s1
 540:	00a98023          	sb	a0,0(s3)
        sp = ep + 1;
    }
    return 0;
 544:	4501                	li	a0,0
}
 546:	60a6                	ld	ra,72(sp)
 548:	6406                	ld	s0,64(sp)
 54a:	74e2                	ld	s1,56(sp)
 54c:	7942                	ld	s2,48(sp)
 54e:	79a2                	ld	s3,40(sp)
 550:	7a02                	ld	s4,32(sp)
 552:	6ae2                	ld	s5,24(sp)
 554:	6b42                	ld	s6,16(sp)
 556:	6161                	add	sp,sp,80
 558:	8082                	ret
        ((uint8_t *)n)[idx] = ret;
 55a:	00998733          	add	a4,s3,s1
 55e:	00a70023          	sb	a0,0(a4)
        sp = ep + 1;
 562:	00178913          	add	s2,a5,1
    for (idx = 0; idx < 4; idx++) {
 566:	0485                	add	s1,s1,1
        ret = strtol(sp, &ep, 10);
 568:	4629                	li	a2,10
 56a:	fb840593          	add	a1,s0,-72
 56e:	854a                	mv	a0,s2
 570:	ed1ff0ef          	jal	440 <strtol>
        if (ret < 0 || ret > 255) {
 574:	02aa6063          	bltu	s4,a0,594 <inet_pton+0x8a>
        if (ep == sp) {
 578:	fb843783          	ld	a5,-72(s0)
 57c:	01278e63          	beq	a5,s2,598 <inet_pton+0x8e>
        if ((idx == 3 && *ep != '\0') || (idx != 3 && *ep != '.')) {
 580:	fb548be3          	beq	s1,s5,536 <inet_pton+0x2c>
 584:	0007c703          	lbu	a4,0(a5)
 588:	fd6709e3          	beq	a4,s6,55a <inet_pton+0x50>
            return -1;
 58c:	557d                	li	a0,-1
 58e:	bf65                	j	546 <inet_pton+0x3c>
        return -1;
 590:	557d                	li	a0,-1
}
 592:	8082                	ret
            return -1;
 594:	557d                	li	a0,-1
 596:	bf45                	j	546 <inet_pton+0x3c>
            return -1;
 598:	557d                	li	a0,-1
 59a:	b775                	j	546 <inet_pton+0x3c>
            return -1;
 59c:	557d                	li	a0,-1
 59e:	b765                	j	546 <inet_pton+0x3c>

00000000000005a0 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 5a0:	4885                	li	a7,1
 ecall
 5a2:	00000073          	ecall
 ret
 5a6:	8082                	ret

00000000000005a8 <exit>:
.global exit
exit:
 li a7, SYS_exit
 5a8:	4889                	li	a7,2
 ecall
 5aa:	00000073          	ecall
 ret
 5ae:	8082                	ret

00000000000005b0 <wait>:
.global wait
wait:
 li a7, SYS_wait
 5b0:	488d                	li	a7,3
 ecall
 5b2:	00000073          	ecall
 ret
 5b6:	8082                	ret

00000000000005b8 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 5b8:	4891                	li	a7,4
 ecall
 5ba:	00000073          	ecall
 ret
 5be:	8082                	ret

00000000000005c0 <read>:
.global read
read:
 li a7, SYS_read
 5c0:	4895                	li	a7,5
 ecall
 5c2:	00000073          	ecall
 ret
 5c6:	8082                	ret

00000000000005c8 <write>:
.global write
write:
 li a7, SYS_write
 5c8:	48c1                	li	a7,16
 ecall
 5ca:	00000073          	ecall
 ret
 5ce:	8082                	ret

00000000000005d0 <close>:
.global close
close:
 li a7, SYS_close
 5d0:	48d5                	li	a7,21
 ecall
 5d2:	00000073          	ecall
 ret
 5d6:	8082                	ret

00000000000005d8 <kill>:
.global kill
kill:
 li a7, SYS_kill
 5d8:	4899                	li	a7,6
 ecall
 5da:	00000073          	ecall
 ret
 5de:	8082                	ret

00000000000005e0 <exec>:
.global exec
exec:
 li a7, SYS_exec
 5e0:	489d                	li	a7,7
 ecall
 5e2:	00000073          	ecall
 ret
 5e6:	8082                	ret

00000000000005e8 <open>:
.global open
open:
 li a7, SYS_open
 5e8:	48bd                	li	a7,15
 ecall
 5ea:	00000073          	ecall
 ret
 5ee:	8082                	ret

00000000000005f0 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 5f0:	48c5                	li	a7,17
 ecall
 5f2:	00000073          	ecall
 ret
 5f6:	8082                	ret

00000000000005f8 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 5f8:	48c9                	li	a7,18
 ecall
 5fa:	00000073          	ecall
 ret
 5fe:	8082                	ret

0000000000000600 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 600:	48a1                	li	a7,8
 ecall
 602:	00000073          	ecall
 ret
 606:	8082                	ret

0000000000000608 <link>:
.global link
link:
 li a7, SYS_link
 608:	48cd                	li	a7,19
 ecall
 60a:	00000073          	ecall
 ret
 60e:	8082                	ret

0000000000000610 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 610:	48d1                	li	a7,20
 ecall
 612:	00000073          	ecall
 ret
 616:	8082                	ret

0000000000000618 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 618:	48a5                	li	a7,9
 ecall
 61a:	00000073          	ecall
 ret
 61e:	8082                	ret

0000000000000620 <dup>:
.global dup
dup:
 li a7, SYS_dup
 620:	48a9                	li	a7,10
 ecall
 622:	00000073          	ecall
 ret
 626:	8082                	ret

0000000000000628 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 628:	48ad                	li	a7,11
 ecall
 62a:	00000073          	ecall
 ret
 62e:	8082                	ret

0000000000000630 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 630:	48b1                	li	a7,12
 ecall
 632:	00000073          	ecall
 ret
 636:	8082                	ret

0000000000000638 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 638:	48b5                	li	a7,13
 ecall
 63a:	00000073          	ecall
 ret
 63e:	8082                	ret

0000000000000640 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 640:	48b9                	li	a7,14
 ecall
 642:	00000073          	ecall
 ret
 646:	8082                	ret

0000000000000648 <socket>:
.global socket
socket:
 li a7, SYS_socket
 648:	48d9                	li	a7,22
 ecall
 64a:	00000073          	ecall
 ret
 64e:	8082                	ret

0000000000000650 <bind>:
.global bind
bind:
 li a7, SYS_bind
 650:	48dd                	li	a7,23
 ecall
 652:	00000073          	ecall
 ret
 656:	8082                	ret

0000000000000658 <recvfrom>:
.global recvfrom
recvfrom:
 li a7, SYS_recvfrom
 658:	48e1                	li	a7,24
 ecall
 65a:	00000073          	ecall
 ret
 65e:	8082                	ret

0000000000000660 <sendto>:
.global sendto
sendto:
 li a7, SYS_sendto
 660:	48e5                	li	a7,25
 ecall
 662:	00000073          	ecall
 ret
 666:	8082                	ret

0000000000000668 <connect>:
.global connect
connect:
 li a7, SYS_connect
 668:	48e9                	li	a7,26
 ecall
 66a:	00000073          	ecall
 ret
 66e:	8082                	ret

0000000000000670 <listen>:
.global listen
listen:
 li a7, SYS_listen
 670:	48ed                	li	a7,27
 ecall
 672:	00000073          	ecall
 ret
 676:	8082                	ret

0000000000000678 <accept>:
.global accept
accept:
 li a7, SYS_accept
 678:	48f1                	li	a7,28
 ecall
 67a:	00000073          	ecall
 ret
 67e:	8082                	ret

0000000000000680 <recv>:
.global recv
recv:
 li a7, SYS_recv
 680:	48f5                	li	a7,29
 ecall
 682:	00000073          	ecall
 ret
 686:	8082                	ret

0000000000000688 <send>:
.global send
send:
 li a7, SYS_send
 688:	48f9                	li	a7,30
 ecall
 68a:	00000073          	ecall
 ret
 68e:	8082                	ret

0000000000000690 <ioctl>:
.global ioctl
ioctl:
 li a7, SYS_ioctl
 690:	48fd                	li	a7,31
 ecall
 692:	00000073          	ecall
 ret
 696:	8082                	ret
