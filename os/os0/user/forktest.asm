
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
   c:	1bc000ef          	jal	1c8 <strlen>
  10:	0005061b          	sext.w	a2,a0
  14:	85a6                	mv	a1,s1
  16:	4505                	li	a0,1
  18:	4ac000ef          	jal	4c4 <write>
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
  36:	55e50513          	add	a0,a0,1374 # 590 <recvfrom+0xc>
  3a:	fc7ff0ef          	jal	0 <print>

  for(n=0; n<N; n++){
  3e:	4481                	li	s1,0
  40:	3e800913          	li	s2,1000
    pid = fork();
  44:	458000ef          	jal	49c <fork>
    if(pid < 0)
  48:	04054363          	bltz	a0,8e <forktest+0x68>
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
  58:	58c50513          	add	a0,a0,1420 # 5e0 <recvfrom+0x5c>
  5c:	fa5ff0ef          	jal	0 <print>
    exit(1);
  60:	4505                	li	a0,1
  62:	442000ef          	jal	4a4 <exit>
      exit(0);
  66:	43e000ef          	jal	4a4 <exit>
  }

  for(; n > 0; n--){
    if(wait(0) < 0){
      print("wait stopped early\n");
  6a:	00000517          	auipc	a0,0x0
  6e:	53650513          	add	a0,a0,1334 # 5a0 <recvfrom+0x1c>
  72:	f8fff0ef          	jal	0 <print>
      exit(1);
  76:	4505                	li	a0,1
  78:	42c000ef          	jal	4a4 <exit>
    }
  }

  if(wait(0) != -1){
    print("wait got too many\n");
  7c:	00000517          	auipc	a0,0x0
  80:	53c50513          	add	a0,a0,1340 # 5b8 <recvfrom+0x34>
  84:	f7dff0ef          	jal	0 <print>
    exit(1);
  88:	4505                	li	a0,1
  8a:	41a000ef          	jal	4a4 <exit>
  for(; n > 0; n--){
  8e:	00905963          	blez	s1,a0 <forktest+0x7a>
    if(wait(0) < 0){
  92:	4501                	li	a0,0
  94:	418000ef          	jal	4ac <wait>
  98:	fc0549e3          	bltz	a0,6a <forktest+0x44>
  for(; n > 0; n--){
  9c:	34fd                	addw	s1,s1,-1
  9e:	f8f5                	bnez	s1,92 <forktest+0x6c>
  if(wait(0) != -1){
  a0:	4501                	li	a0,0
  a2:	40a000ef          	jal	4ac <wait>
  a6:	57fd                	li	a5,-1
  a8:	fcf51ae3          	bne	a0,a5,7c <forktest+0x56>
  }

  print("fork test OK\n");
  ac:	00000517          	auipc	a0,0x0
  b0:	52450513          	add	a0,a0,1316 # 5d0 <recvfrom+0x4c>
  b4:	f4dff0ef          	jal	0 <print>
}
  b8:	60e2                	ld	ra,24(sp)
  ba:	6442                	ld	s0,16(sp)
  bc:	64a2                	ld	s1,8(sp)
  be:	6902                	ld	s2,0(sp)
  c0:	6105                	add	sp,sp,32
  c2:	8082                	ret

00000000000000c4 <main>:

int
main(void)
{
  c4:	1141                	add	sp,sp,-16
  c6:	e406                	sd	ra,8(sp)
  c8:	e022                	sd	s0,0(sp)
  ca:	0800                	add	s0,sp,16
  forktest();
  cc:	f5bff0ef          	jal	26 <forktest>
  exit(0);
  d0:	4501                	li	a0,0
  d2:	3d2000ef          	jal	4a4 <exit>

00000000000000d6 <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start(int argc, char **argv)
{
  d6:	1141                	add	sp,sp,-16
  d8:	e406                	sd	ra,8(sp)
  da:	e022                	sd	s0,0(sp)
  dc:	0800                	add	s0,sp,16
  int r;
  extern int main(int argc, char **argv);
  r = main(argc, argv);
  de:	fe7ff0ef          	jal	c4 <main>
  exit(r);
  e2:	3c2000ef          	jal	4a4 <exit>

00000000000000e6 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
  e6:	1141                	add	sp,sp,-16
  e8:	e422                	sd	s0,8(sp)
  ea:	0800                	add	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  ec:	87aa                	mv	a5,a0
  ee:	0585                	add	a1,a1,1
  f0:	0785                	add	a5,a5,1
  f2:	fff5c703          	lbu	a4,-1(a1)
  f6:	fee78fa3          	sb	a4,-1(a5)
  fa:	fb75                	bnez	a4,ee <strcpy+0x8>
    ;
  return os;
}
  fc:	6422                	ld	s0,8(sp)
  fe:	0141                	add	sp,sp,16
 100:	8082                	ret

0000000000000102 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 102:	1141                	add	sp,sp,-16
 104:	e422                	sd	s0,8(sp)
 106:	0800                	add	s0,sp,16
  while(*p && *p == *q)
 108:	00054783          	lbu	a5,0(a0)
 10c:	cb91                	beqz	a5,120 <strcmp+0x1e>
 10e:	0005c703          	lbu	a4,0(a1)
 112:	00f71763          	bne	a4,a5,120 <strcmp+0x1e>
    p++, q++;
 116:	0505                	add	a0,a0,1
 118:	0585                	add	a1,a1,1
  while(*p && *p == *q)
 11a:	00054783          	lbu	a5,0(a0)
 11e:	fbe5                	bnez	a5,10e <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 120:	0005c503          	lbu	a0,0(a1)
}
 124:	40a7853b          	subw	a0,a5,a0
 128:	6422                	ld	s0,8(sp)
 12a:	0141                	add	sp,sp,16
 12c:	8082                	ret

000000000000012e <strncmp>:

int
strncmp(const char *p, const char *q, uint n)
{
 12e:	1141                	add	sp,sp,-16
 130:	e422                	sd	s0,8(sp)
 132:	0800                	add	s0,sp,16
  while(n > 0 && *p && *p == *q) {
 134:	ce11                	beqz	a2,150 <strncmp+0x22>
 136:	00054783          	lbu	a5,0(a0)
 13a:	cf89                	beqz	a5,154 <strncmp+0x26>
 13c:	0005c703          	lbu	a4,0(a1)
 140:	00f71a63          	bne	a4,a5,154 <strncmp+0x26>
    p++, q++, n--;
 144:	0505                	add	a0,a0,1
 146:	0585                	add	a1,a1,1
 148:	367d                	addw	a2,a2,-1
  while(n > 0 && *p && *p == *q) {
 14a:	f675                	bnez	a2,136 <strncmp+0x8>
  }
  if (n == 0)
    return 0;
 14c:	4501                	li	a0,0
 14e:	a801                	j	15e <strncmp+0x30>
 150:	4501                	li	a0,0
 152:	a031                	j	15e <strncmp+0x30>
  return (uchar)*p - (uchar)*q;
 154:	00054503          	lbu	a0,0(a0)
 158:	0005c783          	lbu	a5,0(a1)
 15c:	9d1d                	subw	a0,a0,a5
}
 15e:	6422                	ld	s0,8(sp)
 160:	0141                	add	sp,sp,16
 162:	8082                	ret

0000000000000164 <strcat>:

char*
strcat(char *dst, const char *src)
{
 164:	1141                	add	sp,sp,-16
 166:	e422                	sd	s0,8(sp)
 168:	0800                	add	s0,sp,16
  char *p = dst;
  while(*p) p++;
 16a:	00054783          	lbu	a5,0(a0)
 16e:	c385                	beqz	a5,18e <strcat+0x2a>
  char *p = dst;
 170:	87aa                	mv	a5,a0
  while(*p) p++;
 172:	0785                	add	a5,a5,1
 174:	0007c703          	lbu	a4,0(a5)
 178:	ff6d                	bnez	a4,172 <strcat+0xe>
  while((*p++ = *src++) != 0);
 17a:	0585                	add	a1,a1,1
 17c:	0785                	add	a5,a5,1
 17e:	fff5c703          	lbu	a4,-1(a1)
 182:	fee78fa3          	sb	a4,-1(a5)
 186:	fb75                	bnez	a4,17a <strcat+0x16>
  return dst;
}
 188:	6422                	ld	s0,8(sp)
 18a:	0141                	add	sp,sp,16
 18c:	8082                	ret
  char *p = dst;
 18e:	87aa                	mv	a5,a0
 190:	b7ed                	j	17a <strcat+0x16>

0000000000000192 <strncpy>:

char*
strncpy(char *dst, const char *src, int n)
{
 192:	1141                	add	sp,sp,-16
 194:	e422                	sd	s0,8(sp)
 196:	0800                	add	s0,sp,16
  char *p = dst;
 198:	87aa                	mv	a5,a0
  while(n > 0 && *src) {
 19a:	02c05463          	blez	a2,1c2 <strncpy+0x30>
 19e:	0005c703          	lbu	a4,0(a1)
 1a2:	cb01                	beqz	a4,1b2 <strncpy+0x20>
    *p++ = *src++;
 1a4:	0585                	add	a1,a1,1
 1a6:	0785                	add	a5,a5,1
 1a8:	fee78fa3          	sb	a4,-1(a5)
    n--;
 1ac:	367d                	addw	a2,a2,-1
  while(n > 0 && *src) {
 1ae:	fa65                	bnez	a2,19e <strncpy+0xc>
 1b0:	a809                	j	1c2 <strncpy+0x30>
  }
  while(n > 0) {
 1b2:	1602                	sll	a2,a2,0x20
 1b4:	9201                	srl	a2,a2,0x20
 1b6:	963e                	add	a2,a2,a5
    *p++ = 0;
 1b8:	0785                	add	a5,a5,1
 1ba:	fe078fa3          	sb	zero,-1(a5)
  while(n > 0) {
 1be:	fec79de3          	bne	a5,a2,1b8 <strncpy+0x26>
    n--;
  }
  return dst;
}
 1c2:	6422                	ld	s0,8(sp)
 1c4:	0141                	add	sp,sp,16
 1c6:	8082                	ret

00000000000001c8 <strlen>:

uint
strlen(const char *s)
{
 1c8:	1141                	add	sp,sp,-16
 1ca:	e422                	sd	s0,8(sp)
 1cc:	0800                	add	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 1ce:	00054783          	lbu	a5,0(a0)
 1d2:	cf91                	beqz	a5,1ee <strlen+0x26>
 1d4:	0505                	add	a0,a0,1
 1d6:	87aa                	mv	a5,a0
 1d8:	86be                	mv	a3,a5
 1da:	0785                	add	a5,a5,1
 1dc:	fff7c703          	lbu	a4,-1(a5)
 1e0:	ff65                	bnez	a4,1d8 <strlen+0x10>
 1e2:	40a6853b          	subw	a0,a3,a0
 1e6:	2505                	addw	a0,a0,1
    ;
  return n;
}
 1e8:	6422                	ld	s0,8(sp)
 1ea:	0141                	add	sp,sp,16
 1ec:	8082                	ret
  for(n = 0; s[n]; n++)
 1ee:	4501                	li	a0,0
 1f0:	bfe5                	j	1e8 <strlen+0x20>

00000000000001f2 <memset>:

void*
memset(void *dst, int c, uint n)
{
 1f2:	1141                	add	sp,sp,-16
 1f4:	e422                	sd	s0,8(sp)
 1f6:	0800                	add	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 1f8:	ca19                	beqz	a2,20e <memset+0x1c>
 1fa:	87aa                	mv	a5,a0
 1fc:	1602                	sll	a2,a2,0x20
 1fe:	9201                	srl	a2,a2,0x20
 200:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 204:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 208:	0785                	add	a5,a5,1
 20a:	fee79de3          	bne	a5,a4,204 <memset+0x12>
  }
  return dst;
}
 20e:	6422                	ld	s0,8(sp)
 210:	0141                	add	sp,sp,16
 212:	8082                	ret

0000000000000214 <strchr>:

char*
strchr(const char *s, char c)
{
 214:	1141                	add	sp,sp,-16
 216:	e422                	sd	s0,8(sp)
 218:	0800                	add	s0,sp,16
  for(; *s; s++)
 21a:	00054783          	lbu	a5,0(a0)
 21e:	cb99                	beqz	a5,234 <strchr+0x20>
    if(*s == c)
 220:	00f58763          	beq	a1,a5,22e <strchr+0x1a>
  for(; *s; s++)
 224:	0505                	add	a0,a0,1
 226:	00054783          	lbu	a5,0(a0)
 22a:	fbfd                	bnez	a5,220 <strchr+0xc>
      return (char*)s;
  return 0;
 22c:	4501                	li	a0,0
}
 22e:	6422                	ld	s0,8(sp)
 230:	0141                	add	sp,sp,16
 232:	8082                	ret
  return 0;
 234:	4501                	li	a0,0
 236:	bfe5                	j	22e <strchr+0x1a>

0000000000000238 <gets>:

char*
gets(char *buf, int max)
{
 238:	711d                	add	sp,sp,-96
 23a:	ec86                	sd	ra,88(sp)
 23c:	e8a2                	sd	s0,80(sp)
 23e:	e4a6                	sd	s1,72(sp)
 240:	e0ca                	sd	s2,64(sp)
 242:	fc4e                	sd	s3,56(sp)
 244:	f852                	sd	s4,48(sp)
 246:	f456                	sd	s5,40(sp)
 248:	f05a                	sd	s6,32(sp)
 24a:	ec5e                	sd	s7,24(sp)
 24c:	1080                	add	s0,sp,96
 24e:	8baa                	mv	s7,a0
 250:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 252:	892a                	mv	s2,a0
 254:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 256:	4aa9                	li	s5,10
 258:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 25a:	89a6                	mv	s3,s1
 25c:	2485                	addw	s1,s1,1
 25e:	0344d663          	bge	s1,s4,28a <gets+0x52>
    cc = read(0, &c, 1);
 262:	4605                	li	a2,1
 264:	faf40593          	add	a1,s0,-81
 268:	4501                	li	a0,0
 26a:	252000ef          	jal	4bc <read>
    if(cc < 1)
 26e:	00a05e63          	blez	a0,28a <gets+0x52>
    buf[i++] = c;
 272:	faf44783          	lbu	a5,-81(s0)
 276:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 27a:	01578763          	beq	a5,s5,288 <gets+0x50>
 27e:	0905                	add	s2,s2,1
 280:	fd679de3          	bne	a5,s6,25a <gets+0x22>
    buf[i++] = c;
 284:	89a6                	mv	s3,s1
 286:	a011                	j	28a <gets+0x52>
 288:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 28a:	99de                	add	s3,s3,s7
 28c:	00098023          	sb	zero,0(s3)
  return buf;
}
 290:	855e                	mv	a0,s7
 292:	60e6                	ld	ra,88(sp)
 294:	6446                	ld	s0,80(sp)
 296:	64a6                	ld	s1,72(sp)
 298:	6906                	ld	s2,64(sp)
 29a:	79e2                	ld	s3,56(sp)
 29c:	7a42                	ld	s4,48(sp)
 29e:	7aa2                	ld	s5,40(sp)
 2a0:	7b02                	ld	s6,32(sp)
 2a2:	6be2                	ld	s7,24(sp)
 2a4:	6125                	add	sp,sp,96
 2a6:	8082                	ret

00000000000002a8 <stat>:

int
stat(const char *n, struct stat *st)
{
 2a8:	1101                	add	sp,sp,-32
 2aa:	ec06                	sd	ra,24(sp)
 2ac:	e822                	sd	s0,16(sp)
 2ae:	e04a                	sd	s2,0(sp)
 2b0:	1000                	add	s0,sp,32
 2b2:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 2b4:	4581                	li	a1,0
 2b6:	22e000ef          	jal	4e4 <open>
  if(fd < 0)
 2ba:	02054263          	bltz	a0,2de <stat+0x36>
 2be:	e426                	sd	s1,8(sp)
 2c0:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 2c2:	85ca                	mv	a1,s2
 2c4:	238000ef          	jal	4fc <fstat>
 2c8:	892a                	mv	s2,a0
  close(fd);
 2ca:	8526                	mv	a0,s1
 2cc:	200000ef          	jal	4cc <close>
  return r;
 2d0:	64a2                	ld	s1,8(sp)
}
 2d2:	854a                	mv	a0,s2
 2d4:	60e2                	ld	ra,24(sp)
 2d6:	6442                	ld	s0,16(sp)
 2d8:	6902                	ld	s2,0(sp)
 2da:	6105                	add	sp,sp,32
 2dc:	8082                	ret
    return -1;
 2de:	597d                	li	s2,-1
 2e0:	bfcd                	j	2d2 <stat+0x2a>

00000000000002e2 <atoi>:

int
atoi(const char *s)
{
 2e2:	1141                	add	sp,sp,-16
 2e4:	e422                	sd	s0,8(sp)
 2e6:	0800                	add	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 2e8:	00054683          	lbu	a3,0(a0)
 2ec:	fd06879b          	addw	a5,a3,-48
 2f0:	0ff7f793          	zext.b	a5,a5
 2f4:	4625                	li	a2,9
 2f6:	02f66863          	bltu	a2,a5,326 <atoi+0x44>
 2fa:	872a                	mv	a4,a0
  n = 0;
 2fc:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 2fe:	0705                	add	a4,a4,1
 300:	0025179b          	sllw	a5,a0,0x2
 304:	9fa9                	addw	a5,a5,a0
 306:	0017979b          	sllw	a5,a5,0x1
 30a:	9fb5                	addw	a5,a5,a3
 30c:	fd07851b          	addw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 310:	00074683          	lbu	a3,0(a4)
 314:	fd06879b          	addw	a5,a3,-48
 318:	0ff7f793          	zext.b	a5,a5
 31c:	fef671e3          	bgeu	a2,a5,2fe <atoi+0x1c>
  return n;
}
 320:	6422                	ld	s0,8(sp)
 322:	0141                	add	sp,sp,16
 324:	8082                	ret
  n = 0;
 326:	4501                	li	a0,0
 328:	bfe5                	j	320 <atoi+0x3e>

000000000000032a <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 32a:	1141                	add	sp,sp,-16
 32c:	e422                	sd	s0,8(sp)
 32e:	0800                	add	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 330:	02b57463          	bgeu	a0,a1,358 <memmove+0x2e>
    while(n-- > 0)
 334:	00c05f63          	blez	a2,352 <memmove+0x28>
 338:	1602                	sll	a2,a2,0x20
 33a:	9201                	srl	a2,a2,0x20
 33c:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 340:	872a                	mv	a4,a0
      *dst++ = *src++;
 342:	0585                	add	a1,a1,1
 344:	0705                	add	a4,a4,1
 346:	fff5c683          	lbu	a3,-1(a1)
 34a:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 34e:	fef71ae3          	bne	a4,a5,342 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 352:	6422                	ld	s0,8(sp)
 354:	0141                	add	sp,sp,16
 356:	8082                	ret
    dst += n;
 358:	00c50733          	add	a4,a0,a2
    src += n;
 35c:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 35e:	fec05ae3          	blez	a2,352 <memmove+0x28>
 362:	fff6079b          	addw	a5,a2,-1
 366:	1782                	sll	a5,a5,0x20
 368:	9381                	srl	a5,a5,0x20
 36a:	fff7c793          	not	a5,a5
 36e:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 370:	15fd                	add	a1,a1,-1
 372:	177d                	add	a4,a4,-1
 374:	0005c683          	lbu	a3,0(a1)
 378:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 37c:	fee79ae3          	bne	a5,a4,370 <memmove+0x46>
 380:	bfc9                	j	352 <memmove+0x28>

0000000000000382 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 382:	1141                	add	sp,sp,-16
 384:	e422                	sd	s0,8(sp)
 386:	0800                	add	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 388:	ca05                	beqz	a2,3b8 <memcmp+0x36>
 38a:	fff6069b          	addw	a3,a2,-1
 38e:	1682                	sll	a3,a3,0x20
 390:	9281                	srl	a3,a3,0x20
 392:	0685                	add	a3,a3,1
 394:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 396:	00054783          	lbu	a5,0(a0)
 39a:	0005c703          	lbu	a4,0(a1)
 39e:	00e79863          	bne	a5,a4,3ae <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 3a2:	0505                	add	a0,a0,1
    p2++;
 3a4:	0585                	add	a1,a1,1
  while (n-- > 0) {
 3a6:	fed518e3          	bne	a0,a3,396 <memcmp+0x14>
  }
  return 0;
 3aa:	4501                	li	a0,0
 3ac:	a019                	j	3b2 <memcmp+0x30>
      return *p1 - *p2;
 3ae:	40e7853b          	subw	a0,a5,a4
}
 3b2:	6422                	ld	s0,8(sp)
 3b4:	0141                	add	sp,sp,16
 3b6:	8082                	ret
  return 0;
 3b8:	4501                	li	a0,0
 3ba:	bfe5                	j	3b2 <memcmp+0x30>

00000000000003bc <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 3bc:	1141                	add	sp,sp,-16
 3be:	e406                	sd	ra,8(sp)
 3c0:	e022                	sd	s0,0(sp)
 3c2:	0800                	add	s0,sp,16
  return memmove(dst, src, n);
 3c4:	f67ff0ef          	jal	32a <memmove>
}
 3c8:	60a2                	ld	ra,8(sp)
 3ca:	6402                	ld	s0,0(sp)
 3cc:	0141                	add	sp,sp,16
 3ce:	8082                	ret

00000000000003d0 <sbrk>:

char *
sbrk(int n) {
 3d0:	1141                	add	sp,sp,-16
 3d2:	e406                	sd	ra,8(sp)
 3d4:	e022                	sd	s0,0(sp)
 3d6:	0800                	add	s0,sp,16
  return sys_sbrk(n, SBRK_EAGER);
 3d8:	4585                	li	a1,1
 3da:	152000ef          	jal	52c <sys_sbrk>
}
 3de:	60a2                	ld	ra,8(sp)
 3e0:	6402                	ld	s0,0(sp)
 3e2:	0141                	add	sp,sp,16
 3e4:	8082                	ret

00000000000003e6 <sbrklazy>:

char *
sbrklazy(int n) {
 3e6:	1141                	add	sp,sp,-16
 3e8:	e406                	sd	ra,8(sp)
 3ea:	e022                	sd	s0,0(sp)
 3ec:	0800                	add	s0,sp,16
  return sys_sbrk(n, SBRK_LAZY);
 3ee:	4589                	li	a1,2
 3f0:	13c000ef          	jal	52c <sys_sbrk>
}
 3f4:	60a2                	ld	ra,8(sp)
 3f6:	6402                	ld	s0,0(sp)
 3f8:	0141                	add	sp,sp,16
 3fa:	8082                	ret

00000000000003fc <htons>:

// Byte order conversion functions
unsigned short
htons(unsigned short hostshort)
{
 3fc:	1141                	add	sp,sp,-16
 3fe:	e422                	sd	s0,8(sp)
 400:	0800                	add	s0,sp,16
  return ((hostshort >> 8) & 0xff) | ((hostshort & 0xff) << 8);
 402:	0085179b          	sllw	a5,a0,0x8
 406:	0085551b          	srlw	a0,a0,0x8
 40a:	8d5d                	or	a0,a0,a5
}
 40c:	1542                	sll	a0,a0,0x30
 40e:	9141                	srl	a0,a0,0x30
 410:	6422                	ld	s0,8(sp)
 412:	0141                	add	sp,sp,16
 414:	8082                	ret

0000000000000416 <ntohs>:

unsigned short
ntohs(unsigned short netshort)
{
 416:	1141                	add	sp,sp,-16
 418:	e422                	sd	s0,8(sp)
 41a:	0800                	add	s0,sp,16
  return ((netshort >> 8) & 0xff) | ((netshort & 0xff) << 8);
 41c:	0085179b          	sllw	a5,a0,0x8
 420:	0085551b          	srlw	a0,a0,0x8
 424:	8d5d                	or	a0,a0,a5
}
 426:	1542                	sll	a0,a0,0x30
 428:	9141                	srl	a0,a0,0x30
 42a:	6422                	ld	s0,8(sp)
 42c:	0141                	add	sp,sp,16
 42e:	8082                	ret

0000000000000430 <htonl>:

unsigned long
htonl(unsigned long hostlong)
{
 430:	1141                	add	sp,sp,-16
 432:	e422                	sd	s0,8(sp)
 434:	0800                	add	s0,sp,16
  return ((hostlong >> 24) & 0xff) |
 436:	0185579b          	srlw	a5,a0,0x18
         ((hostlong >> 8) & 0xff00) |
 43a:	00855713          	srl	a4,a0,0x8
 43e:	66c1                	lui	a3,0x10
 440:	f0068693          	add	a3,a3,-256 # ff00 <__global_pointer$+0xf101>
 444:	8f75                	and	a4,a4,a3
  return ((hostlong >> 24) & 0xff) |
 446:	8fd9                	or	a5,a5,a4
         ((hostlong & 0xff00) << 8) |
 448:	00851713          	sll	a4,a0,0x8
 44c:	00ff06b7          	lui	a3,0xff0
 450:	8f75                	and	a4,a4,a3
         ((hostlong >> 8) & 0xff00) |
 452:	8fd9                	or	a5,a5,a4
         ((hostlong & 0xff) << 24);
 454:	0562                	sll	a0,a0,0x18
 456:	0ff00713          	li	a4,255
 45a:	0762                	sll	a4,a4,0x18
 45c:	8d79                	and	a0,a0,a4
}
 45e:	8d5d                	or	a0,a0,a5
 460:	6422                	ld	s0,8(sp)
 462:	0141                	add	sp,sp,16
 464:	8082                	ret

0000000000000466 <ntohl>:

unsigned long
ntohl(unsigned long netlong)
{
 466:	1141                	add	sp,sp,-16
 468:	e422                	sd	s0,8(sp)
 46a:	0800                	add	s0,sp,16
  return ((netlong >> 24) & 0xff) |
 46c:	0185579b          	srlw	a5,a0,0x18
         ((netlong >> 8) & 0xff00) |
 470:	00855713          	srl	a4,a0,0x8
 474:	66c1                	lui	a3,0x10
 476:	f0068693          	add	a3,a3,-256 # ff00 <__global_pointer$+0xf101>
 47a:	8f75                	and	a4,a4,a3
  return ((netlong >> 24) & 0xff) |
 47c:	8fd9                	or	a5,a5,a4
         ((netlong & 0xff00) << 8) |
 47e:	00851713          	sll	a4,a0,0x8
 482:	00ff06b7          	lui	a3,0xff0
 486:	8f75                	and	a4,a4,a3
         ((netlong >> 8) & 0xff00) |
 488:	8fd9                	or	a5,a5,a4
         ((netlong & 0xff) << 24);
 48a:	0562                	sll	a0,a0,0x18
 48c:	0ff00713          	li	a4,255
 490:	0762                	sll	a4,a4,0x18
 492:	8d79                	and	a0,a0,a4
}
 494:	8d5d                	or	a0,a0,a5
 496:	6422                	ld	s0,8(sp)
 498:	0141                	add	sp,sp,16
 49a:	8082                	ret

000000000000049c <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 49c:	4885                	li	a7,1
 ecall
 49e:	00000073          	ecall
 ret
 4a2:	8082                	ret

00000000000004a4 <exit>:
.global exit
exit:
 li a7, SYS_exit
 4a4:	4889                	li	a7,2
 ecall
 4a6:	00000073          	ecall
 ret
 4aa:	8082                	ret

00000000000004ac <wait>:
.global wait
wait:
 li a7, SYS_wait
 4ac:	488d                	li	a7,3
 ecall
 4ae:	00000073          	ecall
 ret
 4b2:	8082                	ret

00000000000004b4 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 4b4:	4891                	li	a7,4
 ecall
 4b6:	00000073          	ecall
 ret
 4ba:	8082                	ret

00000000000004bc <read>:
.global read
read:
 li a7, SYS_read
 4bc:	4895                	li	a7,5
 ecall
 4be:	00000073          	ecall
 ret
 4c2:	8082                	ret

00000000000004c4 <write>:
.global write
write:
 li a7, SYS_write
 4c4:	48c1                	li	a7,16
 ecall
 4c6:	00000073          	ecall
 ret
 4ca:	8082                	ret

00000000000004cc <close>:
.global close
close:
 li a7, SYS_close
 4cc:	48d5                	li	a7,21
 ecall
 4ce:	00000073          	ecall
 ret
 4d2:	8082                	ret

00000000000004d4 <kill>:
.global kill
kill:
 li a7, SYS_kill
 4d4:	4899                	li	a7,6
 ecall
 4d6:	00000073          	ecall
 ret
 4da:	8082                	ret

00000000000004dc <exec>:
.global exec
exec:
 li a7, SYS_exec
 4dc:	489d                	li	a7,7
 ecall
 4de:	00000073          	ecall
 ret
 4e2:	8082                	ret

00000000000004e4 <open>:
.global open
open:
 li a7, SYS_open
 4e4:	48bd                	li	a7,15
 ecall
 4e6:	00000073          	ecall
 ret
 4ea:	8082                	ret

00000000000004ec <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 4ec:	48c5                	li	a7,17
 ecall
 4ee:	00000073          	ecall
 ret
 4f2:	8082                	ret

00000000000004f4 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 4f4:	48c9                	li	a7,18
 ecall
 4f6:	00000073          	ecall
 ret
 4fa:	8082                	ret

00000000000004fc <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 4fc:	48a1                	li	a7,8
 ecall
 4fe:	00000073          	ecall
 ret
 502:	8082                	ret

0000000000000504 <link>:
.global link
link:
 li a7, SYS_link
 504:	48cd                	li	a7,19
 ecall
 506:	00000073          	ecall
 ret
 50a:	8082                	ret

000000000000050c <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 50c:	48d1                	li	a7,20
 ecall
 50e:	00000073          	ecall
 ret
 512:	8082                	ret

0000000000000514 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 514:	48a5                	li	a7,9
 ecall
 516:	00000073          	ecall
 ret
 51a:	8082                	ret

000000000000051c <dup>:
.global dup
dup:
 li a7, SYS_dup
 51c:	48a9                	li	a7,10
 ecall
 51e:	00000073          	ecall
 ret
 522:	8082                	ret

0000000000000524 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 524:	48ad                	li	a7,11
 ecall
 526:	00000073          	ecall
 ret
 52a:	8082                	ret

000000000000052c <sys_sbrk>:
.global sys_sbrk
sys_sbrk:
 li a7, SYS_sbrk
 52c:	48b1                	li	a7,12
 ecall
 52e:	00000073          	ecall
 ret
 532:	8082                	ret

0000000000000534 <pause>:
.global pause
pause:
 li a7, SYS_pause
 534:	48b5                	li	a7,13
 ecall
 536:	00000073          	ecall
 ret
 53a:	8082                	ret

000000000000053c <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 53c:	48b9                	li	a7,14
 ecall
 53e:	00000073          	ecall
 ret
 542:	8082                	ret

0000000000000544 <socket>:
.global socket
socket:
 li a7, SYS_socket
 544:	48d9                	li	a7,22
 ecall
 546:	00000073          	ecall
 ret
 54a:	8082                	ret

000000000000054c <bind>:
.global bind
bind:
 li a7, SYS_bind
 54c:	48dd                	li	a7,23
 ecall
 54e:	00000073          	ecall
 ret
 552:	8082                	ret

0000000000000554 <listen>:
.global listen
listen:
 li a7, SYS_listen
 554:	48e1                	li	a7,24
 ecall
 556:	00000073          	ecall
 ret
 55a:	8082                	ret

000000000000055c <accept>:
.global accept
accept:
 li a7, SYS_accept
 55c:	48e5                	li	a7,25
 ecall
 55e:	00000073          	ecall
 ret
 562:	8082                	ret

0000000000000564 <connect>:
.global connect
connect:
 li a7, SYS_connect
 564:	48e9                	li	a7,26
 ecall
 566:	00000073          	ecall
 ret
 56a:	8082                	ret

000000000000056c <send>:
.global send
send:
 li a7, SYS_send
 56c:	48ed                	li	a7,27
 ecall
 56e:	00000073          	ecall
 ret
 572:	8082                	ret

0000000000000574 <recv>:
.global recv
recv:
 li a7, SYS_recv
 574:	48f1                	li	a7,28
 ecall
 576:	00000073          	ecall
 ret
 57a:	8082                	ret

000000000000057c <sendto>:
.global sendto
sendto:
 li a7, SYS_sendto
 57c:	48f5                	li	a7,29
 ecall
 57e:	00000073          	ecall
 ret
 582:	8082                	ret

0000000000000584 <recvfrom>:
.global recvfrom
recvfrom:
 li a7, SYS_recvfrom
 584:	48f9                	li	a7,30
 ecall
 586:	00000073          	ecall
 ret
 58a:	8082                	ret
