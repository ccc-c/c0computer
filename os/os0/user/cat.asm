
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
  14:	00090913          	mv	s2,s2
  18:	20000613          	li	a2,512
  1c:	85ca                	mv	a1,s2
  1e:	854e                	mv	a0,s3
  20:	5c6000ef          	jal	5e6 <read>
  24:	84aa                	mv	s1,a0
  26:	02a05363          	blez	a0,4c <cat+0x4c>
    if (write(1, buf, n) != n) {
  2a:	8626                	mv	a2,s1
  2c:	85ca                	mv	a1,s2
  2e:	4505                	li	a0,1
  30:	5be000ef          	jal	5ee <write>
  34:	fe9502e3          	beq	a0,s1,18 <cat+0x18>
      fprintf(2, "cat: write error\n");
  38:	00001597          	auipc	a1,0x1
  3c:	b9858593          	add	a1,a1,-1128 # bd0 <malloc+0xe4>
  40:	4509                	li	a0,2
  42:	1cd000ef          	jal	a0e <fprintf>
      exit(1);
  46:	4505                	li	a0,1
  48:	586000ef          	jal	5ce <exit>
    }
  }
  if(n < 0){
  4c:	00054963          	bltz	a0,5e <cat+0x5e>
    fprintf(2, "cat: read error\n");
    exit(1);
  }
}
  50:	70a2                	ld	ra,40(sp)
  52:	7402                	ld	s0,32(sp)
  54:	64e2                	ld	s1,24(sp)
  56:	6942                	ld	s2,16(sp)
  58:	69a2                	ld	s3,8(sp)
  5a:	6145                	add	sp,sp,48
  5c:	8082                	ret
    fprintf(2, "cat: read error\n");
  5e:	00001597          	auipc	a1,0x1
  62:	b8a58593          	add	a1,a1,-1142 # be8 <malloc+0xfc>
  66:	4509                	li	a0,2
  68:	1a7000ef          	jal	a0e <fprintf>
    exit(1);
  6c:	4505                	li	a0,1
  6e:	560000ef          	jal	5ce <exit>

0000000000000072 <main>:

int
main(int argc, char *argv[])
{
  72:	7179                	add	sp,sp,-48
  74:	f406                	sd	ra,40(sp)
  76:	f022                	sd	s0,32(sp)
  78:	ec26                	sd	s1,24(sp)
  7a:	e84a                	sd	s2,16(sp)
  7c:	e44e                	sd	s3,8(sp)
  7e:	1800                	add	s0,sp,48
  int fd, i;

  if(argc <= 1){
  80:	4785                	li	a5,1
  82:	02a7df63          	bge	a5,a0,c0 <main+0x4e>
  86:	00858913          	add	s2,a1,8
  8a:	ffe5099b          	addw	s3,a0,-2
  8e:	02099793          	sll	a5,s3,0x20
  92:	01d7d993          	srl	s3,a5,0x1d
  96:	05c1                	add	a1,a1,16
  98:	99ae                	add	s3,s3,a1
    cat(0);
    exit(0);
  }

  for(i = 1; i < argc; i++){
    if((fd = open(argv[i], O_RDONLY)) < 0){
  9a:	4581                	li	a1,0
  9c:	00093503          	ld	a0,0(s2) # 1010 <buf>
  a0:	56e000ef          	jal	60e <open>
  a4:	84aa                	mv	s1,a0
  a6:	02054363          	bltz	a0,cc <main+0x5a>
      fprintf(2, "cat: cannot open %s\n", argv[i]);
      exit(1);
    }
    cat(fd);
  aa:	f57ff0ef          	jal	0 <cat>
    close(fd);
  ae:	8526                	mv	a0,s1
  b0:	546000ef          	jal	5f6 <close>
  for(i = 1; i < argc; i++){
  b4:	0921                	add	s2,s2,8
  b6:	ff3912e3          	bne	s2,s3,9a <main+0x28>
  }
  exit(0);
  ba:	4501                	li	a0,0
  bc:	512000ef          	jal	5ce <exit>
    cat(0);
  c0:	4501                	li	a0,0
  c2:	f3fff0ef          	jal	0 <cat>
    exit(0);
  c6:	4501                	li	a0,0
  c8:	506000ef          	jal	5ce <exit>
      fprintf(2, "cat: cannot open %s\n", argv[i]);
  cc:	00093603          	ld	a2,0(s2)
  d0:	00001597          	auipc	a1,0x1
  d4:	b3058593          	add	a1,a1,-1232 # c00 <malloc+0x114>
  d8:	4509                	li	a0,2
  da:	135000ef          	jal	a0e <fprintf>
      exit(1);
  de:	4505                	li	a0,1
  e0:	4ee000ef          	jal	5ce <exit>

00000000000000e4 <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start()
{
  e4:	1141                	add	sp,sp,-16
  e6:	e406                	sd	ra,8(sp)
  e8:	e022                	sd	s0,0(sp)
  ea:	0800                	add	s0,sp,16
  extern int main();
  main();
  ec:	f87ff0ef          	jal	72 <main>
  exit(0);
  f0:	4501                	li	a0,0
  f2:	4dc000ef          	jal	5ce <exit>

00000000000000f6 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
  f6:	1141                	add	sp,sp,-16
  f8:	e422                	sd	s0,8(sp)
  fa:	0800                	add	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  fc:	87aa                	mv	a5,a0
  fe:	0585                	add	a1,a1,1
 100:	0785                	add	a5,a5,1
 102:	fff5c703          	lbu	a4,-1(a1)
 106:	fee78fa3          	sb	a4,-1(a5)
 10a:	fb75                	bnez	a4,fe <strcpy+0x8>
    ;
  return os;
}
 10c:	6422                	ld	s0,8(sp)
 10e:	0141                	add	sp,sp,16
 110:	8082                	ret

0000000000000112 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 112:	1141                	add	sp,sp,-16
 114:	e422                	sd	s0,8(sp)
 116:	0800                	add	s0,sp,16
  while(*p && *p == *q)
 118:	00054783          	lbu	a5,0(a0)
 11c:	cb91                	beqz	a5,130 <strcmp+0x1e>
 11e:	0005c703          	lbu	a4,0(a1)
 122:	00f71763          	bne	a4,a5,130 <strcmp+0x1e>
    p++, q++;
 126:	0505                	add	a0,a0,1
 128:	0585                	add	a1,a1,1
  while(*p && *p == *q)
 12a:	00054783          	lbu	a5,0(a0)
 12e:	fbe5                	bnez	a5,11e <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 130:	0005c503          	lbu	a0,0(a1)
}
 134:	40a7853b          	subw	a0,a5,a0
 138:	6422                	ld	s0,8(sp)
 13a:	0141                	add	sp,sp,16
 13c:	8082                	ret

000000000000013e <strlen>:

uint
strlen(const char *s)
{
 13e:	1141                	add	sp,sp,-16
 140:	e422                	sd	s0,8(sp)
 142:	0800                	add	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 144:	00054783          	lbu	a5,0(a0)
 148:	cf91                	beqz	a5,164 <strlen+0x26>
 14a:	0505                	add	a0,a0,1
 14c:	87aa                	mv	a5,a0
 14e:	86be                	mv	a3,a5
 150:	0785                	add	a5,a5,1
 152:	fff7c703          	lbu	a4,-1(a5)
 156:	ff65                	bnez	a4,14e <strlen+0x10>
 158:	40a6853b          	subw	a0,a3,a0
 15c:	2505                	addw	a0,a0,1
    ;
  return n;
}
 15e:	6422                	ld	s0,8(sp)
 160:	0141                	add	sp,sp,16
 162:	8082                	ret
  for(n = 0; s[n]; n++)
 164:	4501                	li	a0,0
 166:	bfe5                	j	15e <strlen+0x20>

0000000000000168 <memset>:

void*
memset(void *dst, int c, uint n)
{
 168:	1141                	add	sp,sp,-16
 16a:	e422                	sd	s0,8(sp)
 16c:	0800                	add	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 16e:	ca19                	beqz	a2,184 <memset+0x1c>
 170:	87aa                	mv	a5,a0
 172:	1602                	sll	a2,a2,0x20
 174:	9201                	srl	a2,a2,0x20
 176:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 17a:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 17e:	0785                	add	a5,a5,1
 180:	fee79de3          	bne	a5,a4,17a <memset+0x12>
  }
  return dst;
}
 184:	6422                	ld	s0,8(sp)
 186:	0141                	add	sp,sp,16
 188:	8082                	ret

000000000000018a <strchr>:

char*
strchr(const char *s, char c)
{
 18a:	1141                	add	sp,sp,-16
 18c:	e422                	sd	s0,8(sp)
 18e:	0800                	add	s0,sp,16
  for(; *s; s++)
 190:	00054783          	lbu	a5,0(a0)
 194:	cb99                	beqz	a5,1aa <strchr+0x20>
    if(*s == c)
 196:	00f58763          	beq	a1,a5,1a4 <strchr+0x1a>
  for(; *s; s++)
 19a:	0505                	add	a0,a0,1
 19c:	00054783          	lbu	a5,0(a0)
 1a0:	fbfd                	bnez	a5,196 <strchr+0xc>
      return (char*)s;
  return 0;
 1a2:	4501                	li	a0,0
}
 1a4:	6422                	ld	s0,8(sp)
 1a6:	0141                	add	sp,sp,16
 1a8:	8082                	ret
  return 0;
 1aa:	4501                	li	a0,0
 1ac:	bfe5                	j	1a4 <strchr+0x1a>

00000000000001ae <gets>:

char*
gets(char *buf, int max)
{
 1ae:	711d                	add	sp,sp,-96
 1b0:	ec86                	sd	ra,88(sp)
 1b2:	e8a2                	sd	s0,80(sp)
 1b4:	e4a6                	sd	s1,72(sp)
 1b6:	e0ca                	sd	s2,64(sp)
 1b8:	fc4e                	sd	s3,56(sp)
 1ba:	f852                	sd	s4,48(sp)
 1bc:	f456                	sd	s5,40(sp)
 1be:	f05a                	sd	s6,32(sp)
 1c0:	ec5e                	sd	s7,24(sp)
 1c2:	1080                	add	s0,sp,96
 1c4:	8baa                	mv	s7,a0
 1c6:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1c8:	892a                	mv	s2,a0
 1ca:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 1cc:	4aa9                	li	s5,10
 1ce:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 1d0:	89a6                	mv	s3,s1
 1d2:	2485                	addw	s1,s1,1
 1d4:	0344d663          	bge	s1,s4,200 <gets+0x52>
    cc = read(0, &c, 1);
 1d8:	4605                	li	a2,1
 1da:	faf40593          	add	a1,s0,-81
 1de:	4501                	li	a0,0
 1e0:	406000ef          	jal	5e6 <read>
    if(cc < 1)
 1e4:	00a05e63          	blez	a0,200 <gets+0x52>
    buf[i++] = c;
 1e8:	faf44783          	lbu	a5,-81(s0)
 1ec:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 1f0:	01578763          	beq	a5,s5,1fe <gets+0x50>
 1f4:	0905                	add	s2,s2,1
 1f6:	fd679de3          	bne	a5,s6,1d0 <gets+0x22>
  for(i=0; i+1 < max; ){
 1fa:	89a6                	mv	s3,s1
 1fc:	a011                	j	200 <gets+0x52>
 1fe:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 200:	99de                	add	s3,s3,s7
 202:	00098023          	sb	zero,0(s3)
  return buf;
}
 206:	855e                	mv	a0,s7
 208:	60e6                	ld	ra,88(sp)
 20a:	6446                	ld	s0,80(sp)
 20c:	64a6                	ld	s1,72(sp)
 20e:	6906                	ld	s2,64(sp)
 210:	79e2                	ld	s3,56(sp)
 212:	7a42                	ld	s4,48(sp)
 214:	7aa2                	ld	s5,40(sp)
 216:	7b02                	ld	s6,32(sp)
 218:	6be2                	ld	s7,24(sp)
 21a:	6125                	add	sp,sp,96
 21c:	8082                	ret

000000000000021e <stat>:

int
stat(const char *n, struct stat *st)
{
 21e:	1101                	add	sp,sp,-32
 220:	ec06                	sd	ra,24(sp)
 222:	e822                	sd	s0,16(sp)
 224:	e426                	sd	s1,8(sp)
 226:	e04a                	sd	s2,0(sp)
 228:	1000                	add	s0,sp,32
 22a:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 22c:	4581                	li	a1,0
 22e:	3e0000ef          	jal	60e <open>
  if(fd < 0)
 232:	02054163          	bltz	a0,254 <stat+0x36>
 236:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 238:	85ca                	mv	a1,s2
 23a:	3ec000ef          	jal	626 <fstat>
 23e:	892a                	mv	s2,a0
  close(fd);
 240:	8526                	mv	a0,s1
 242:	3b4000ef          	jal	5f6 <close>
  return r;
}
 246:	854a                	mv	a0,s2
 248:	60e2                	ld	ra,24(sp)
 24a:	6442                	ld	s0,16(sp)
 24c:	64a2                	ld	s1,8(sp)
 24e:	6902                	ld	s2,0(sp)
 250:	6105                	add	sp,sp,32
 252:	8082                	ret
    return -1;
 254:	597d                	li	s2,-1
 256:	bfc5                	j	246 <stat+0x28>

0000000000000258 <atoi>:

int
atoi(const char *s)
{
 258:	1141                	add	sp,sp,-16
 25a:	e422                	sd	s0,8(sp)
 25c:	0800                	add	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 25e:	00054683          	lbu	a3,0(a0)
 262:	fd06879b          	addw	a5,a3,-48
 266:	0ff7f793          	zext.b	a5,a5
 26a:	4625                	li	a2,9
 26c:	02f66863          	bltu	a2,a5,29c <atoi+0x44>
 270:	872a                	mv	a4,a0
  n = 0;
 272:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 274:	0705                	add	a4,a4,1
 276:	0025179b          	sllw	a5,a0,0x2
 27a:	9fa9                	addw	a5,a5,a0
 27c:	0017979b          	sllw	a5,a5,0x1
 280:	9fb5                	addw	a5,a5,a3
 282:	fd07851b          	addw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 286:	00074683          	lbu	a3,0(a4)
 28a:	fd06879b          	addw	a5,a3,-48
 28e:	0ff7f793          	zext.b	a5,a5
 292:	fef671e3          	bgeu	a2,a5,274 <atoi+0x1c>
  return n;
}
 296:	6422                	ld	s0,8(sp)
 298:	0141                	add	sp,sp,16
 29a:	8082                	ret
  n = 0;
 29c:	4501                	li	a0,0
 29e:	bfe5                	j	296 <atoi+0x3e>

00000000000002a0 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 2a0:	1141                	add	sp,sp,-16
 2a2:	e422                	sd	s0,8(sp)
 2a4:	0800                	add	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 2a6:	02b57463          	bgeu	a0,a1,2ce <memmove+0x2e>
    while(n-- > 0)
 2aa:	00c05f63          	blez	a2,2c8 <memmove+0x28>
 2ae:	1602                	sll	a2,a2,0x20
 2b0:	9201                	srl	a2,a2,0x20
 2b2:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 2b6:	872a                	mv	a4,a0
      *dst++ = *src++;
 2b8:	0585                	add	a1,a1,1
 2ba:	0705                	add	a4,a4,1
 2bc:	fff5c683          	lbu	a3,-1(a1)
 2c0:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 2c4:	fee79ae3          	bne	a5,a4,2b8 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 2c8:	6422                	ld	s0,8(sp)
 2ca:	0141                	add	sp,sp,16
 2cc:	8082                	ret
    dst += n;
 2ce:	00c50733          	add	a4,a0,a2
    src += n;
 2d2:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 2d4:	fec05ae3          	blez	a2,2c8 <memmove+0x28>
 2d8:	fff6079b          	addw	a5,a2,-1
 2dc:	1782                	sll	a5,a5,0x20
 2de:	9381                	srl	a5,a5,0x20
 2e0:	fff7c793          	not	a5,a5
 2e4:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 2e6:	15fd                	add	a1,a1,-1
 2e8:	177d                	add	a4,a4,-1
 2ea:	0005c683          	lbu	a3,0(a1)
 2ee:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 2f2:	fee79ae3          	bne	a5,a4,2e6 <memmove+0x46>
 2f6:	bfc9                	j	2c8 <memmove+0x28>

00000000000002f8 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 2f8:	1141                	add	sp,sp,-16
 2fa:	e422                	sd	s0,8(sp)
 2fc:	0800                	add	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 2fe:	ca05                	beqz	a2,32e <memcmp+0x36>
 300:	fff6069b          	addw	a3,a2,-1
 304:	1682                	sll	a3,a3,0x20
 306:	9281                	srl	a3,a3,0x20
 308:	0685                	add	a3,a3,1
 30a:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 30c:	00054783          	lbu	a5,0(a0)
 310:	0005c703          	lbu	a4,0(a1)
 314:	00e79863          	bne	a5,a4,324 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 318:	0505                	add	a0,a0,1
    p2++;
 31a:	0585                	add	a1,a1,1
  while (n-- > 0) {
 31c:	fed518e3          	bne	a0,a3,30c <memcmp+0x14>
  }
  return 0;
 320:	4501                	li	a0,0
 322:	a019                	j	328 <memcmp+0x30>
      return *p1 - *p2;
 324:	40e7853b          	subw	a0,a5,a4
}
 328:	6422                	ld	s0,8(sp)
 32a:	0141                	add	sp,sp,16
 32c:	8082                	ret
  return 0;
 32e:	4501                	li	a0,0
 330:	bfe5                	j	328 <memcmp+0x30>

0000000000000332 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 332:	1141                	add	sp,sp,-16
 334:	e406                	sd	ra,8(sp)
 336:	e022                	sd	s0,0(sp)
 338:	0800                	add	s0,sp,16
  return memmove(dst, src, n);
 33a:	f67ff0ef          	jal	2a0 <memmove>
}
 33e:	60a2                	ld	ra,8(sp)
 340:	6402                	ld	s0,0(sp)
 342:	0141                	add	sp,sp,16
 344:	8082                	ret

0000000000000346 <htons>:
    return (v & 0x000000ff) << 24 | (v & 0x0000ff00) << 8 | (v & 0x00ff0000) >> 8 | (v & 0xff000000) >> 24;
}

uint16_t
htons(uint16_t h)
{
 346:	1141                	add	sp,sp,-16
 348:	e422                	sd	s0,8(sp)
 34a:	0800                	add	s0,sp,16
    if (!endian) {
 34c:	00001797          	auipc	a5,0x1
 350:	cb47a783          	lw	a5,-844(a5) # 1000 <endian>
 354:	e385                	bnez	a5,374 <htons+0x2e>
        endian = byteorder();
 356:	4d200793          	li	a5,1234
 35a:	00001717          	auipc	a4,0x1
 35e:	caf72323          	sw	a5,-858(a4) # 1000 <endian>
    return (v & 0x00ff) << 8 | (v & 0xff00 ) >> 8;
 362:	0085579b          	srlw	a5,a0,0x8
 366:	0085151b          	sllw	a0,a0,0x8
 36a:	8fc9                	or	a5,a5,a0
 36c:	03079513          	sll	a0,a5,0x30
 370:	9141                	srl	a0,a0,0x30
 372:	a029                	j	37c <htons+0x36>
    }
    return endian == __LITTLE_ENDIAN ? byteswap16(h) : h;
 374:	4d200713          	li	a4,1234
 378:	fee785e3          	beq	a5,a4,362 <htons+0x1c>
}
 37c:	6422                	ld	s0,8(sp)
 37e:	0141                	add	sp,sp,16
 380:	8082                	ret

0000000000000382 <ntohs>:

uint16_t
ntohs(uint16_t n)
{
 382:	1141                	add	sp,sp,-16
 384:	e422                	sd	s0,8(sp)
 386:	0800                	add	s0,sp,16
    if (!endian) {
 388:	00001797          	auipc	a5,0x1
 38c:	c787a783          	lw	a5,-904(a5) # 1000 <endian>
 390:	e385                	bnez	a5,3b0 <ntohs+0x2e>
        endian = byteorder();
 392:	4d200793          	li	a5,1234
 396:	00001717          	auipc	a4,0x1
 39a:	c6f72523          	sw	a5,-918(a4) # 1000 <endian>
    return (v & 0x00ff) << 8 | (v & 0xff00 ) >> 8;
 39e:	0085579b          	srlw	a5,a0,0x8
 3a2:	0085151b          	sllw	a0,a0,0x8
 3a6:	8fc9                	or	a5,a5,a0
 3a8:	03079513          	sll	a0,a5,0x30
 3ac:	9141                	srl	a0,a0,0x30
 3ae:	a029                	j	3b8 <ntohs+0x36>
    }
    return endian == __LITTLE_ENDIAN ? byteswap16(n) : n;
 3b0:	4d200713          	li	a4,1234
 3b4:	fee785e3          	beq	a5,a4,39e <ntohs+0x1c>
}
 3b8:	6422                	ld	s0,8(sp)
 3ba:	0141                	add	sp,sp,16
 3bc:	8082                	ret

00000000000003be <htonl>:

uint32_t
htonl(uint32_t h)
{
 3be:	1141                	add	sp,sp,-16
 3c0:	e422                	sd	s0,8(sp)
 3c2:	0800                	add	s0,sp,16
    if (!endian) {
 3c4:	00001797          	auipc	a5,0x1
 3c8:	c3c7a783          	lw	a5,-964(a5) # 1000 <endian>
 3cc:	ef85                	bnez	a5,404 <htonl+0x46>
        endian = byteorder();
 3ce:	4d200793          	li	a5,1234
 3d2:	00001717          	auipc	a4,0x1
 3d6:	c2f72723          	sw	a5,-978(a4) # 1000 <endian>
    return (v & 0x000000ff) << 24 | (v & 0x0000ff00) << 8 | (v & 0x00ff0000) >> 8 | (v & 0xff000000) >> 24;
 3da:	0185179b          	sllw	a5,a0,0x18
 3de:	0185571b          	srlw	a4,a0,0x18
 3e2:	8fd9                	or	a5,a5,a4
 3e4:	0085171b          	sllw	a4,a0,0x8
 3e8:	00ff06b7          	lui	a3,0xff0
 3ec:	8f75                	and	a4,a4,a3
 3ee:	8fd9                	or	a5,a5,a4
 3f0:	0085551b          	srlw	a0,a0,0x8
 3f4:	6741                	lui	a4,0x10
 3f6:	f0070713          	add	a4,a4,-256 # ff00 <base+0xecf0>
 3fa:	8d79                	and	a0,a0,a4
 3fc:	8fc9                	or	a5,a5,a0
 3fe:	0007851b          	sext.w	a0,a5
 402:	a029                	j	40c <htonl+0x4e>
    }
    return endian == __LITTLE_ENDIAN ? byteswap32(h) : h;
 404:	4d200713          	li	a4,1234
 408:	fce789e3          	beq	a5,a4,3da <htonl+0x1c>
}
 40c:	6422                	ld	s0,8(sp)
 40e:	0141                	add	sp,sp,16
 410:	8082                	ret

0000000000000412 <ntohl>:

uint32_t
ntohl(uint32_t n)
{
 412:	1141                	add	sp,sp,-16
 414:	e422                	sd	s0,8(sp)
 416:	0800                	add	s0,sp,16
    if (!endian) {
 418:	00001797          	auipc	a5,0x1
 41c:	be87a783          	lw	a5,-1048(a5) # 1000 <endian>
 420:	ef85                	bnez	a5,458 <ntohl+0x46>
        endian = byteorder();
 422:	4d200793          	li	a5,1234
 426:	00001717          	auipc	a4,0x1
 42a:	bcf72d23          	sw	a5,-1062(a4) # 1000 <endian>
    return (v & 0x000000ff) << 24 | (v & 0x0000ff00) << 8 | (v & 0x00ff0000) >> 8 | (v & 0xff000000) >> 24;
 42e:	0185179b          	sllw	a5,a0,0x18
 432:	0185571b          	srlw	a4,a0,0x18
 436:	8fd9                	or	a5,a5,a4
 438:	0085171b          	sllw	a4,a0,0x8
 43c:	00ff06b7          	lui	a3,0xff0
 440:	8f75                	and	a4,a4,a3
 442:	8fd9                	or	a5,a5,a4
 444:	0085551b          	srlw	a0,a0,0x8
 448:	6741                	lui	a4,0x10
 44a:	f0070713          	add	a4,a4,-256 # ff00 <base+0xecf0>
 44e:	8d79                	and	a0,a0,a4
 450:	8fc9                	or	a5,a5,a0
 452:	0007851b          	sext.w	a0,a5
 456:	a029                	j	460 <ntohl+0x4e>
    }
    return endian == __LITTLE_ENDIAN ? byteswap32(n) : n;
 458:	4d200713          	li	a4,1234
 45c:	fce789e3          	beq	a5,a4,42e <ntohl+0x1c>
}
 460:	6422                	ld	s0,8(sp)
 462:	0141                	add	sp,sp,16
 464:	8082                	ret

0000000000000466 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
 466:	1141                	add	sp,sp,-16
 468:	e422                	sd	s0,8(sp)
 46a:	0800                	add	s0,sp,16
 46c:	872a                	mv	a4,a0
    int neg = 0;
    long val = 0;

    // gobble initial whitespace
    while (*s == ' ' || *s == '\t')
 46e:	02000693          	li	a3,32
 472:	4525                	li	a0,9
 474:	a011                	j	478 <strtol+0x12>
        s++;
 476:	0705                	add	a4,a4,1
    while (*s == ' ' || *s == '\t')
 478:	00074783          	lbu	a5,0(a4)
 47c:	fed78de3          	beq	a5,a3,476 <strtol+0x10>
 480:	fea78be3          	beq	a5,a0,476 <strtol+0x10>

    // plus/minus sign
    if (*s == '+')
 484:	02b00693          	li	a3,43
 488:	02d78663          	beq	a5,a3,4b4 <strtol+0x4e>
        s++;
    else if (*s == '-')
 48c:	02d00693          	li	a3,45
    int neg = 0;
 490:	4301                	li	t1,0
    else if (*s == '-')
 492:	02d78463          	beq	a5,a3,4ba <strtol+0x54>
        s++, neg = 1;

    // hex or octal base prefix
    if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
 496:	fef67793          	and	a5,a2,-17
 49a:	eb89                	bnez	a5,4ac <strtol+0x46>
 49c:	00074683          	lbu	a3,0(a4)
 4a0:	03000793          	li	a5,48
 4a4:	00f68e63          	beq	a3,a5,4c0 <strtol+0x5a>
        s += 2, base = 16;
    else if (base == 0 && s[0] == '0')
 4a8:	e211                	bnez	a2,4ac <strtol+0x46>
        s++, base = 8;
    else if (base == 0)
        base = 10;
 4aa:	4629                	li	a2,10
 4ac:	4501                	li	a0,0

    // digits
    while (1) {
        int dig;

        if (*s >= '0' && *s <= '9')
 4ae:	4825                	li	a6,9
            dig = *s - '0';
        else if (*s >= 'a' && *s <= 'z')
 4b0:	48e5                	li	a7,25
 4b2:	a825                	j	4ea <strtol+0x84>
        s++;
 4b4:	0705                	add	a4,a4,1
    int neg = 0;
 4b6:	4301                	li	t1,0
 4b8:	bff9                	j	496 <strtol+0x30>
        s++, neg = 1;
 4ba:	0705                	add	a4,a4,1
 4bc:	4305                	li	t1,1
 4be:	bfe1                	j	496 <strtol+0x30>
    if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
 4c0:	00174683          	lbu	a3,1(a4)
 4c4:	07800793          	li	a5,120
 4c8:	00f68663          	beq	a3,a5,4d4 <strtol+0x6e>
    else if (base == 0 && s[0] == '0')
 4cc:	f265                	bnez	a2,4ac <strtol+0x46>
        s++, base = 8;
 4ce:	0705                	add	a4,a4,1
 4d0:	4621                	li	a2,8
 4d2:	bfe9                	j	4ac <strtol+0x46>
        s += 2, base = 16;
 4d4:	0709                	add	a4,a4,2
 4d6:	4641                	li	a2,16
 4d8:	bfd1                	j	4ac <strtol+0x46>
            dig = *s - '0';
 4da:	fd07879b          	addw	a5,a5,-48
            dig = *s - 'a' + 10;
        else if (*s >= 'A' && *s <= 'Z')
            dig = *s - 'A' + 10;
        else
            break;
        if (dig >= base)
 4de:	04c7d063          	bge	a5,a2,51e <strtol+0xb8>
            break;
        s++, val = (val * base) + dig;
 4e2:	0705                	add	a4,a4,1
 4e4:	02a60533          	mul	a0,a2,a0
 4e8:	953e                	add	a0,a0,a5
        if (*s >= '0' && *s <= '9')
 4ea:	00074783          	lbu	a5,0(a4)
 4ee:	fd07869b          	addw	a3,a5,-48
 4f2:	0ff6f693          	zext.b	a3,a3
 4f6:	fed872e3          	bgeu	a6,a3,4da <strtol+0x74>
        else if (*s >= 'a' && *s <= 'z')
 4fa:	f9f7869b          	addw	a3,a5,-97
 4fe:	0ff6f693          	zext.b	a3,a3
 502:	00d8e563          	bltu	a7,a3,50c <strtol+0xa6>
            dig = *s - 'a' + 10;
 506:	fa97879b          	addw	a5,a5,-87
 50a:	bfd1                	j	4de <strtol+0x78>
        else if (*s >= 'A' && *s <= 'Z')
 50c:	fbf7869b          	addw	a3,a5,-65
 510:	0ff6f693          	zext.b	a3,a3
 514:	00d8e563          	bltu	a7,a3,51e <strtol+0xb8>
            dig = *s - 'A' + 10;
 518:	fc97879b          	addw	a5,a5,-55
 51c:	b7c9                	j	4de <strtol+0x78>
        // we don't properly detect overflow!
    }

    if (endptr)
 51e:	c191                	beqz	a1,522 <strtol+0xbc>
        *endptr = (char *) s;
 520:	e198                	sd	a4,0(a1)
    return (neg ? -val : val);
 522:	00030463          	beqz	t1,52a <strtol+0xc4>
 526:	40a00533          	neg	a0,a0
}
 52a:	6422                	ld	s0,8(sp)
 52c:	0141                	add	sp,sp,16
 52e:	8082                	ret

0000000000000530 <inet_pton>:
inet_pton (int family, const char *p, void *n) {
    char *sp, *ep;
    int idx;
    long ret;

    if (family != AF_INET) {
 530:	4785                	li	a5,1
 532:	08f51263          	bne	a0,a5,5b6 <inet_pton+0x86>
inet_pton (int family, const char *p, void *n) {
 536:	715d                	add	sp,sp,-80
 538:	e486                	sd	ra,72(sp)
 53a:	e0a2                	sd	s0,64(sp)
 53c:	fc26                	sd	s1,56(sp)
 53e:	f84a                	sd	s2,48(sp)
 540:	f44e                	sd	s3,40(sp)
 542:	f052                	sd	s4,32(sp)
 544:	ec56                	sd	s5,24(sp)
 546:	e85a                	sd	s6,16(sp)
 548:	0880                	add	s0,sp,80
 54a:	892e                	mv	s2,a1
 54c:	89b2                	mv	s3,a2
 54e:	4481                	li	s1,0
        return -1;
    }
    sp = (char *)p;
    for (idx = 0; idx < 4; idx++) {
        ret = strtol(sp, &ep, 10);
        if (ret < 0 || ret > 255) {
 550:	0ff00a13          	li	s4,255
            return -1;
        }
        if (ep == sp) {
            return -1;
        }
        if ((idx == 3 && *ep != '\0') || (idx != 3 && *ep != '.')) {
 554:	4a8d                	li	s5,3
 556:	02e00b13          	li	s6,46
 55a:	a815                	j	58e <inet_pton+0x5e>
 55c:	0007c783          	lbu	a5,0(a5)
 560:	e3ad                	bnez	a5,5c2 <inet_pton+0x92>
            return -1;
        }
        ((uint8_t *)n)[idx] = ret;
 562:	2481                	sext.w	s1,s1
 564:	99a6                	add	s3,s3,s1
 566:	00a98023          	sb	a0,0(s3)
        sp = ep + 1;
    }
    return 0;
 56a:	4501                	li	a0,0
}
 56c:	60a6                	ld	ra,72(sp)
 56e:	6406                	ld	s0,64(sp)
 570:	74e2                	ld	s1,56(sp)
 572:	7942                	ld	s2,48(sp)
 574:	79a2                	ld	s3,40(sp)
 576:	7a02                	ld	s4,32(sp)
 578:	6ae2                	ld	s5,24(sp)
 57a:	6b42                	ld	s6,16(sp)
 57c:	6161                	add	sp,sp,80
 57e:	8082                	ret
        ((uint8_t *)n)[idx] = ret;
 580:	00998733          	add	a4,s3,s1
 584:	00a70023          	sb	a0,0(a4)
        sp = ep + 1;
 588:	00178913          	add	s2,a5,1
    for (idx = 0; idx < 4; idx++) {
 58c:	0485                	add	s1,s1,1
        ret = strtol(sp, &ep, 10);
 58e:	4629                	li	a2,10
 590:	fb840593          	add	a1,s0,-72
 594:	854a                	mv	a0,s2
 596:	ed1ff0ef          	jal	466 <strtol>
        if (ret < 0 || ret > 255) {
 59a:	02aa6063          	bltu	s4,a0,5ba <inet_pton+0x8a>
        if (ep == sp) {
 59e:	fb843783          	ld	a5,-72(s0)
 5a2:	01278e63          	beq	a5,s2,5be <inet_pton+0x8e>
        if ((idx == 3 && *ep != '\0') || (idx != 3 && *ep != '.')) {
 5a6:	fb548be3          	beq	s1,s5,55c <inet_pton+0x2c>
 5aa:	0007c703          	lbu	a4,0(a5)
 5ae:	fd6709e3          	beq	a4,s6,580 <inet_pton+0x50>
            return -1;
 5b2:	557d                	li	a0,-1
 5b4:	bf65                	j	56c <inet_pton+0x3c>
        return -1;
 5b6:	557d                	li	a0,-1
}
 5b8:	8082                	ret
            return -1;
 5ba:	557d                	li	a0,-1
 5bc:	bf45                	j	56c <inet_pton+0x3c>
            return -1;
 5be:	557d                	li	a0,-1
 5c0:	b775                	j	56c <inet_pton+0x3c>
            return -1;
 5c2:	557d                	li	a0,-1
 5c4:	b765                	j	56c <inet_pton+0x3c>

00000000000005c6 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 5c6:	4885                	li	a7,1
 ecall
 5c8:	00000073          	ecall
 ret
 5cc:	8082                	ret

00000000000005ce <exit>:
.global exit
exit:
 li a7, SYS_exit
 5ce:	4889                	li	a7,2
 ecall
 5d0:	00000073          	ecall
 ret
 5d4:	8082                	ret

00000000000005d6 <wait>:
.global wait
wait:
 li a7, SYS_wait
 5d6:	488d                	li	a7,3
 ecall
 5d8:	00000073          	ecall
 ret
 5dc:	8082                	ret

00000000000005de <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 5de:	4891                	li	a7,4
 ecall
 5e0:	00000073          	ecall
 ret
 5e4:	8082                	ret

00000000000005e6 <read>:
.global read
read:
 li a7, SYS_read
 5e6:	4895                	li	a7,5
 ecall
 5e8:	00000073          	ecall
 ret
 5ec:	8082                	ret

00000000000005ee <write>:
.global write
write:
 li a7, SYS_write
 5ee:	48c1                	li	a7,16
 ecall
 5f0:	00000073          	ecall
 ret
 5f4:	8082                	ret

00000000000005f6 <close>:
.global close
close:
 li a7, SYS_close
 5f6:	48d5                	li	a7,21
 ecall
 5f8:	00000073          	ecall
 ret
 5fc:	8082                	ret

00000000000005fe <kill>:
.global kill
kill:
 li a7, SYS_kill
 5fe:	4899                	li	a7,6
 ecall
 600:	00000073          	ecall
 ret
 604:	8082                	ret

0000000000000606 <exec>:
.global exec
exec:
 li a7, SYS_exec
 606:	489d                	li	a7,7
 ecall
 608:	00000073          	ecall
 ret
 60c:	8082                	ret

000000000000060e <open>:
.global open
open:
 li a7, SYS_open
 60e:	48bd                	li	a7,15
 ecall
 610:	00000073          	ecall
 ret
 614:	8082                	ret

0000000000000616 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 616:	48c5                	li	a7,17
 ecall
 618:	00000073          	ecall
 ret
 61c:	8082                	ret

000000000000061e <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 61e:	48c9                	li	a7,18
 ecall
 620:	00000073          	ecall
 ret
 624:	8082                	ret

0000000000000626 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 626:	48a1                	li	a7,8
 ecall
 628:	00000073          	ecall
 ret
 62c:	8082                	ret

000000000000062e <link>:
.global link
link:
 li a7, SYS_link
 62e:	48cd                	li	a7,19
 ecall
 630:	00000073          	ecall
 ret
 634:	8082                	ret

0000000000000636 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 636:	48d1                	li	a7,20
 ecall
 638:	00000073          	ecall
 ret
 63c:	8082                	ret

000000000000063e <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 63e:	48a5                	li	a7,9
 ecall
 640:	00000073          	ecall
 ret
 644:	8082                	ret

0000000000000646 <dup>:
.global dup
dup:
 li a7, SYS_dup
 646:	48a9                	li	a7,10
 ecall
 648:	00000073          	ecall
 ret
 64c:	8082                	ret

000000000000064e <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 64e:	48ad                	li	a7,11
 ecall
 650:	00000073          	ecall
 ret
 654:	8082                	ret

0000000000000656 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 656:	48b1                	li	a7,12
 ecall
 658:	00000073          	ecall
 ret
 65c:	8082                	ret

000000000000065e <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 65e:	48b5                	li	a7,13
 ecall
 660:	00000073          	ecall
 ret
 664:	8082                	ret

0000000000000666 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 666:	48b9                	li	a7,14
 ecall
 668:	00000073          	ecall
 ret
 66c:	8082                	ret

000000000000066e <socket>:
.global socket
socket:
 li a7, SYS_socket
 66e:	48d9                	li	a7,22
 ecall
 670:	00000073          	ecall
 ret
 674:	8082                	ret

0000000000000676 <bind>:
.global bind
bind:
 li a7, SYS_bind
 676:	48dd                	li	a7,23
 ecall
 678:	00000073          	ecall
 ret
 67c:	8082                	ret

000000000000067e <recvfrom>:
.global recvfrom
recvfrom:
 li a7, SYS_recvfrom
 67e:	48e1                	li	a7,24
 ecall
 680:	00000073          	ecall
 ret
 684:	8082                	ret

0000000000000686 <sendto>:
.global sendto
sendto:
 li a7, SYS_sendto
 686:	48e5                	li	a7,25
 ecall
 688:	00000073          	ecall
 ret
 68c:	8082                	ret

000000000000068e <connect>:
.global connect
connect:
 li a7, SYS_connect
 68e:	48e9                	li	a7,26
 ecall
 690:	00000073          	ecall
 ret
 694:	8082                	ret

0000000000000696 <listen>:
.global listen
listen:
 li a7, SYS_listen
 696:	48ed                	li	a7,27
 ecall
 698:	00000073          	ecall
 ret
 69c:	8082                	ret

000000000000069e <accept>:
.global accept
accept:
 li a7, SYS_accept
 69e:	48f1                	li	a7,28
 ecall
 6a0:	00000073          	ecall
 ret
 6a4:	8082                	ret

00000000000006a6 <recv>:
.global recv
recv:
 li a7, SYS_recv
 6a6:	48f5                	li	a7,29
 ecall
 6a8:	00000073          	ecall
 ret
 6ac:	8082                	ret

00000000000006ae <send>:
.global send
send:
 li a7, SYS_send
 6ae:	48f9                	li	a7,30
 ecall
 6b0:	00000073          	ecall
 ret
 6b4:	8082                	ret

00000000000006b6 <ioctl>:
.global ioctl
ioctl:
 li a7, SYS_ioctl
 6b6:	48fd                	li	a7,31
 ecall
 6b8:	00000073          	ecall
 ret
 6bc:	8082                	ret

00000000000006be <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 6be:	1101                	add	sp,sp,-32
 6c0:	ec06                	sd	ra,24(sp)
 6c2:	e822                	sd	s0,16(sp)
 6c4:	1000                	add	s0,sp,32
 6c6:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 6ca:	4605                	li	a2,1
 6cc:	fef40593          	add	a1,s0,-17
 6d0:	f1fff0ef          	jal	5ee <write>
}
 6d4:	60e2                	ld	ra,24(sp)
 6d6:	6442                	ld	s0,16(sp)
 6d8:	6105                	add	sp,sp,32
 6da:	8082                	ret

00000000000006dc <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
 6dc:	715d                	add	sp,sp,-80
 6de:	e486                	sd	ra,72(sp)
 6e0:	e0a2                	sd	s0,64(sp)
 6e2:	fc26                	sd	s1,56(sp)
 6e4:	f84a                	sd	s2,48(sp)
 6e6:	f44e                	sd	s3,40(sp)
 6e8:	0880                	add	s0,sp,80
 6ea:	84aa                	mv	s1,a0
  char buf[20];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 6ec:	c299                	beqz	a3,6f2 <printint+0x16>
 6ee:	0805c763          	bltz	a1,77c <printint+0xa0>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 6f2:	2581                	sext.w	a1,a1
  neg = 0;
 6f4:	4881                	li	a7,0
 6f6:	fb840693          	add	a3,s0,-72
  }

  i = 0;
 6fa:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 6fc:	2601                	sext.w	a2,a2
 6fe:	00000517          	auipc	a0,0x0
 702:	52250513          	add	a0,a0,1314 # c20 <digits>
 706:	883a                	mv	a6,a4
 708:	2705                	addw	a4,a4,1
 70a:	02c5f7bb          	remuw	a5,a1,a2
 70e:	1782                	sll	a5,a5,0x20
 710:	9381                	srl	a5,a5,0x20
 712:	97aa                	add	a5,a5,a0
 714:	0007c783          	lbu	a5,0(a5)
 718:	00f68023          	sb	a5,0(a3) # ff0000 <base+0xfeedf0>
  }while((x /= base) != 0);
 71c:	0005879b          	sext.w	a5,a1
 720:	02c5d5bb          	divuw	a1,a1,a2
 724:	0685                	add	a3,a3,1
 726:	fec7f0e3          	bgeu	a5,a2,706 <printint+0x2a>
  if(neg)
 72a:	00088c63          	beqz	a7,742 <printint+0x66>
    buf[i++] = '-';
 72e:	fd070793          	add	a5,a4,-48
 732:	00878733          	add	a4,a5,s0
 736:	02d00793          	li	a5,45
 73a:	fef70423          	sb	a5,-24(a4)
 73e:	0028071b          	addw	a4,a6,2

  while(--i >= 0)
 742:	02e05663          	blez	a4,76e <printint+0x92>
 746:	fb840793          	add	a5,s0,-72
 74a:	00e78933          	add	s2,a5,a4
 74e:	fff78993          	add	s3,a5,-1
 752:	99ba                	add	s3,s3,a4
 754:	377d                	addw	a4,a4,-1
 756:	1702                	sll	a4,a4,0x20
 758:	9301                	srl	a4,a4,0x20
 75a:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 75e:	fff94583          	lbu	a1,-1(s2)
 762:	8526                	mv	a0,s1
 764:	f5bff0ef          	jal	6be <putc>
  while(--i >= 0)
 768:	197d                	add	s2,s2,-1
 76a:	ff391ae3          	bne	s2,s3,75e <printint+0x82>
}
 76e:	60a6                	ld	ra,72(sp)
 770:	6406                	ld	s0,64(sp)
 772:	74e2                	ld	s1,56(sp)
 774:	7942                	ld	s2,48(sp)
 776:	79a2                	ld	s3,40(sp)
 778:	6161                	add	sp,sp,80
 77a:	8082                	ret
    x = -xx;
 77c:	40b005bb          	negw	a1,a1
    neg = 1;
 780:	4885                	li	a7,1
    x = -xx;
 782:	bf95                	j	6f6 <printint+0x1a>

0000000000000784 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 784:	711d                	add	sp,sp,-96
 786:	ec86                	sd	ra,88(sp)
 788:	e8a2                	sd	s0,80(sp)
 78a:	e4a6                	sd	s1,72(sp)
 78c:	e0ca                	sd	s2,64(sp)
 78e:	fc4e                	sd	s3,56(sp)
 790:	f852                	sd	s4,48(sp)
 792:	f456                	sd	s5,40(sp)
 794:	f05a                	sd	s6,32(sp)
 796:	ec5e                	sd	s7,24(sp)
 798:	e862                	sd	s8,16(sp)
 79a:	e466                	sd	s9,8(sp)
 79c:	e06a                	sd	s10,0(sp)
 79e:	1080                	add	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 7a0:	0005c903          	lbu	s2,0(a1)
 7a4:	24090763          	beqz	s2,9f2 <vprintf+0x26e>
 7a8:	8b2a                	mv	s6,a0
 7aa:	8a2e                	mv	s4,a1
 7ac:	8bb2                	mv	s7,a2
  state = 0;
 7ae:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
 7b0:	4481                	li	s1,0
 7b2:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
 7b4:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
 7b8:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
 7bc:	06c00c93          	li	s9,108
 7c0:	a005                	j	7e0 <vprintf+0x5c>
        putc(fd, c0);
 7c2:	85ca                	mv	a1,s2
 7c4:	855a                	mv	a0,s6
 7c6:	ef9ff0ef          	jal	6be <putc>
 7ca:	a019                	j	7d0 <vprintf+0x4c>
    } else if(state == '%'){
 7cc:	03598263          	beq	s3,s5,7f0 <vprintf+0x6c>
  for(i = 0; fmt[i]; i++){
 7d0:	2485                	addw	s1,s1,1
 7d2:	8726                	mv	a4,s1
 7d4:	009a07b3          	add	a5,s4,s1
 7d8:	0007c903          	lbu	s2,0(a5)
 7dc:	20090b63          	beqz	s2,9f2 <vprintf+0x26e>
    c0 = fmt[i] & 0xff;
 7e0:	0009079b          	sext.w	a5,s2
    if(state == 0){
 7e4:	fe0994e3          	bnez	s3,7cc <vprintf+0x48>
      if(c0 == '%'){
 7e8:	fd579de3          	bne	a5,s5,7c2 <vprintf+0x3e>
        state = '%';
 7ec:	89be                	mv	s3,a5
 7ee:	b7cd                	j	7d0 <vprintf+0x4c>
      if(c0) c1 = fmt[i+1] & 0xff;
 7f0:	c7c9                	beqz	a5,87a <vprintf+0xf6>
 7f2:	00ea06b3          	add	a3,s4,a4
 7f6:	0016c683          	lbu	a3,1(a3)
      c1 = c2 = 0;
 7fa:	8636                	mv	a2,a3
      if(c1) c2 = fmt[i+2] & 0xff;
 7fc:	c681                	beqz	a3,804 <vprintf+0x80>
 7fe:	9752                	add	a4,a4,s4
 800:	00274603          	lbu	a2,2(a4)
      if(c0 == 'd'){
 804:	03878f63          	beq	a5,s8,842 <vprintf+0xbe>
      } else if(c0 == 'l' && c1 == 'd'){
 808:	05978963          	beq	a5,s9,85a <vprintf+0xd6>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
 80c:	07500713          	li	a4,117
 810:	0ee78363          	beq	a5,a4,8f6 <vprintf+0x172>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
 814:	07800713          	li	a4,120
 818:	12e78563          	beq	a5,a4,942 <vprintf+0x1be>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
 81c:	07000713          	li	a4,112
 820:	14e78a63          	beq	a5,a4,974 <vprintf+0x1f0>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 's'){
 824:	07300713          	li	a4,115
 828:	18e78863          	beq	a5,a4,9b8 <vprintf+0x234>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
 82c:	02500713          	li	a4,37
 830:	04e79563          	bne	a5,a4,87a <vprintf+0xf6>
        putc(fd, '%');
 834:	02500593          	li	a1,37
 838:	855a                	mv	a0,s6
 83a:	e85ff0ef          	jal	6be <putc>
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
#endif
      state = 0;
 83e:	4981                	li	s3,0
 840:	bf41                	j	7d0 <vprintf+0x4c>
        printint(fd, va_arg(ap, int), 10, 1);
 842:	008b8913          	add	s2,s7,8
 846:	4685                	li	a3,1
 848:	4629                	li	a2,10
 84a:	000ba583          	lw	a1,0(s7)
 84e:	855a                	mv	a0,s6
 850:	e8dff0ef          	jal	6dc <printint>
 854:	8bca                	mv	s7,s2
      state = 0;
 856:	4981                	li	s3,0
 858:	bfa5                	j	7d0 <vprintf+0x4c>
      } else if(c0 == 'l' && c1 == 'd'){
 85a:	06400793          	li	a5,100
 85e:	02f68963          	beq	a3,a5,890 <vprintf+0x10c>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 862:	06c00793          	li	a5,108
 866:	04f68263          	beq	a3,a5,8aa <vprintf+0x126>
      } else if(c0 == 'l' && c1 == 'u'){
 86a:	07500793          	li	a5,117
 86e:	0af68063          	beq	a3,a5,90e <vprintf+0x18a>
      } else if(c0 == 'l' && c1 == 'x'){
 872:	07800793          	li	a5,120
 876:	0ef68263          	beq	a3,a5,95a <vprintf+0x1d6>
        putc(fd, '%');
 87a:	02500593          	li	a1,37
 87e:	855a                	mv	a0,s6
 880:	e3fff0ef          	jal	6be <putc>
        putc(fd, c0);
 884:	85ca                	mv	a1,s2
 886:	855a                	mv	a0,s6
 888:	e37ff0ef          	jal	6be <putc>
      state = 0;
 88c:	4981                	li	s3,0
 88e:	b789                	j	7d0 <vprintf+0x4c>
        printint(fd, va_arg(ap, uint64), 10, 1);
 890:	008b8913          	add	s2,s7,8
 894:	4685                	li	a3,1
 896:	4629                	li	a2,10
 898:	000bb583          	ld	a1,0(s7)
 89c:	855a                	mv	a0,s6
 89e:	e3fff0ef          	jal	6dc <printint>
        i += 1;
 8a2:	2485                	addw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 8a4:	8bca                	mv	s7,s2
      state = 0;
 8a6:	4981                	li	s3,0
        i += 1;
 8a8:	b725                	j	7d0 <vprintf+0x4c>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 8aa:	06400793          	li	a5,100
 8ae:	02f60763          	beq	a2,a5,8dc <vprintf+0x158>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 8b2:	07500793          	li	a5,117
 8b6:	06f60963          	beq	a2,a5,928 <vprintf+0x1a4>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 8ba:	07800793          	li	a5,120
 8be:	faf61ee3          	bne	a2,a5,87a <vprintf+0xf6>
        printint(fd, va_arg(ap, uint64), 16, 0);
 8c2:	008b8913          	add	s2,s7,8
 8c6:	4681                	li	a3,0
 8c8:	4641                	li	a2,16
 8ca:	000bb583          	ld	a1,0(s7)
 8ce:	855a                	mv	a0,s6
 8d0:	e0dff0ef          	jal	6dc <printint>
        i += 2;
 8d4:	2489                	addw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 8d6:	8bca                	mv	s7,s2
      state = 0;
 8d8:	4981                	li	s3,0
        i += 2;
 8da:	bddd                	j	7d0 <vprintf+0x4c>
        printint(fd, va_arg(ap, uint64), 10, 1);
 8dc:	008b8913          	add	s2,s7,8
 8e0:	4685                	li	a3,1
 8e2:	4629                	li	a2,10
 8e4:	000bb583          	ld	a1,0(s7)
 8e8:	855a                	mv	a0,s6
 8ea:	df3ff0ef          	jal	6dc <printint>
        i += 2;
 8ee:	2489                	addw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 8f0:	8bca                	mv	s7,s2
      state = 0;
 8f2:	4981                	li	s3,0
        i += 2;
 8f4:	bdf1                	j	7d0 <vprintf+0x4c>
        printint(fd, va_arg(ap, int), 10, 0);
 8f6:	008b8913          	add	s2,s7,8
 8fa:	4681                	li	a3,0
 8fc:	4629                	li	a2,10
 8fe:	000ba583          	lw	a1,0(s7)
 902:	855a                	mv	a0,s6
 904:	dd9ff0ef          	jal	6dc <printint>
 908:	8bca                	mv	s7,s2
      state = 0;
 90a:	4981                	li	s3,0
 90c:	b5d1                	j	7d0 <vprintf+0x4c>
        printint(fd, va_arg(ap, uint64), 10, 0);
 90e:	008b8913          	add	s2,s7,8
 912:	4681                	li	a3,0
 914:	4629                	li	a2,10
 916:	000bb583          	ld	a1,0(s7)
 91a:	855a                	mv	a0,s6
 91c:	dc1ff0ef          	jal	6dc <printint>
        i += 1;
 920:	2485                	addw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 922:	8bca                	mv	s7,s2
      state = 0;
 924:	4981                	li	s3,0
        i += 1;
 926:	b56d                	j	7d0 <vprintf+0x4c>
        printint(fd, va_arg(ap, uint64), 10, 0);
 928:	008b8913          	add	s2,s7,8
 92c:	4681                	li	a3,0
 92e:	4629                	li	a2,10
 930:	000bb583          	ld	a1,0(s7)
 934:	855a                	mv	a0,s6
 936:	da7ff0ef          	jal	6dc <printint>
        i += 2;
 93a:	2489                	addw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 93c:	8bca                	mv	s7,s2
      state = 0;
 93e:	4981                	li	s3,0
        i += 2;
 940:	bd41                	j	7d0 <vprintf+0x4c>
        printint(fd, va_arg(ap, int), 16, 0);
 942:	008b8913          	add	s2,s7,8
 946:	4681                	li	a3,0
 948:	4641                	li	a2,16
 94a:	000ba583          	lw	a1,0(s7)
 94e:	855a                	mv	a0,s6
 950:	d8dff0ef          	jal	6dc <printint>
 954:	8bca                	mv	s7,s2
      state = 0;
 956:	4981                	li	s3,0
 958:	bda5                	j	7d0 <vprintf+0x4c>
        printint(fd, va_arg(ap, uint64), 16, 0);
 95a:	008b8913          	add	s2,s7,8
 95e:	4681                	li	a3,0
 960:	4641                	li	a2,16
 962:	000bb583          	ld	a1,0(s7)
 966:	855a                	mv	a0,s6
 968:	d75ff0ef          	jal	6dc <printint>
        i += 1;
 96c:	2485                	addw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 96e:	8bca                	mv	s7,s2
      state = 0;
 970:	4981                	li	s3,0
        i += 1;
 972:	bdb9                	j	7d0 <vprintf+0x4c>
        printptr(fd, va_arg(ap, uint64));
 974:	008b8d13          	add	s10,s7,8
 978:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 97c:	03000593          	li	a1,48
 980:	855a                	mv	a0,s6
 982:	d3dff0ef          	jal	6be <putc>
  putc(fd, 'x');
 986:	07800593          	li	a1,120
 98a:	855a                	mv	a0,s6
 98c:	d33ff0ef          	jal	6be <putc>
 990:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 992:	00000b97          	auipc	s7,0x0
 996:	28eb8b93          	add	s7,s7,654 # c20 <digits>
 99a:	03c9d793          	srl	a5,s3,0x3c
 99e:	97de                	add	a5,a5,s7
 9a0:	0007c583          	lbu	a1,0(a5)
 9a4:	855a                	mv	a0,s6
 9a6:	d19ff0ef          	jal	6be <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 9aa:	0992                	sll	s3,s3,0x4
 9ac:	397d                	addw	s2,s2,-1
 9ae:	fe0916e3          	bnez	s2,99a <vprintf+0x216>
        printptr(fd, va_arg(ap, uint64));
 9b2:	8bea                	mv	s7,s10
      state = 0;
 9b4:	4981                	li	s3,0
 9b6:	bd29                	j	7d0 <vprintf+0x4c>
        if((s = va_arg(ap, char*)) == 0)
 9b8:	008b8993          	add	s3,s7,8
 9bc:	000bb903          	ld	s2,0(s7)
 9c0:	00090f63          	beqz	s2,9de <vprintf+0x25a>
        for(; *s; s++)
 9c4:	00094583          	lbu	a1,0(s2)
 9c8:	c195                	beqz	a1,9ec <vprintf+0x268>
          putc(fd, *s);
 9ca:	855a                	mv	a0,s6
 9cc:	cf3ff0ef          	jal	6be <putc>
        for(; *s; s++)
 9d0:	0905                	add	s2,s2,1
 9d2:	00094583          	lbu	a1,0(s2)
 9d6:	f9f5                	bnez	a1,9ca <vprintf+0x246>
        if((s = va_arg(ap, char*)) == 0)
 9d8:	8bce                	mv	s7,s3
      state = 0;
 9da:	4981                	li	s3,0
 9dc:	bbd5                	j	7d0 <vprintf+0x4c>
          s = "(null)";
 9de:	00000917          	auipc	s2,0x0
 9e2:	23a90913          	add	s2,s2,570 # c18 <malloc+0x12c>
        for(; *s; s++)
 9e6:	02800593          	li	a1,40
 9ea:	b7c5                	j	9ca <vprintf+0x246>
        if((s = va_arg(ap, char*)) == 0)
 9ec:	8bce                	mv	s7,s3
      state = 0;
 9ee:	4981                	li	s3,0
 9f0:	b3c5                	j	7d0 <vprintf+0x4c>
    }
  }
}
 9f2:	60e6                	ld	ra,88(sp)
 9f4:	6446                	ld	s0,80(sp)
 9f6:	64a6                	ld	s1,72(sp)
 9f8:	6906                	ld	s2,64(sp)
 9fa:	79e2                	ld	s3,56(sp)
 9fc:	7a42                	ld	s4,48(sp)
 9fe:	7aa2                	ld	s5,40(sp)
 a00:	7b02                	ld	s6,32(sp)
 a02:	6be2                	ld	s7,24(sp)
 a04:	6c42                	ld	s8,16(sp)
 a06:	6ca2                	ld	s9,8(sp)
 a08:	6d02                	ld	s10,0(sp)
 a0a:	6125                	add	sp,sp,96
 a0c:	8082                	ret

0000000000000a0e <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 a0e:	715d                	add	sp,sp,-80
 a10:	ec06                	sd	ra,24(sp)
 a12:	e822                	sd	s0,16(sp)
 a14:	1000                	add	s0,sp,32
 a16:	e010                	sd	a2,0(s0)
 a18:	e414                	sd	a3,8(s0)
 a1a:	e818                	sd	a4,16(s0)
 a1c:	ec1c                	sd	a5,24(s0)
 a1e:	03043023          	sd	a6,32(s0)
 a22:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 a26:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 a2a:	8622                	mv	a2,s0
 a2c:	d59ff0ef          	jal	784 <vprintf>
}
 a30:	60e2                	ld	ra,24(sp)
 a32:	6442                	ld	s0,16(sp)
 a34:	6161                	add	sp,sp,80
 a36:	8082                	ret

0000000000000a38 <printf>:

void
printf(const char *fmt, ...)
{
 a38:	711d                	add	sp,sp,-96
 a3a:	ec06                	sd	ra,24(sp)
 a3c:	e822                	sd	s0,16(sp)
 a3e:	1000                	add	s0,sp,32
 a40:	e40c                	sd	a1,8(s0)
 a42:	e810                	sd	a2,16(s0)
 a44:	ec14                	sd	a3,24(s0)
 a46:	f018                	sd	a4,32(s0)
 a48:	f41c                	sd	a5,40(s0)
 a4a:	03043823          	sd	a6,48(s0)
 a4e:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 a52:	00840613          	add	a2,s0,8
 a56:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 a5a:	85aa                	mv	a1,a0
 a5c:	4505                	li	a0,1
 a5e:	d27ff0ef          	jal	784 <vprintf>
}
 a62:	60e2                	ld	ra,24(sp)
 a64:	6442                	ld	s0,16(sp)
 a66:	6125                	add	sp,sp,96
 a68:	8082                	ret

0000000000000a6a <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 a6a:	1141                	add	sp,sp,-16
 a6c:	e422                	sd	s0,8(sp)
 a6e:	0800                	add	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 a70:	ff050693          	add	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 a74:	00000797          	auipc	a5,0x0
 a78:	5947b783          	ld	a5,1428(a5) # 1008 <freep>
 a7c:	a02d                	j	aa6 <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 a7e:	4618                	lw	a4,8(a2)
 a80:	9f2d                	addw	a4,a4,a1
 a82:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 a86:	6398                	ld	a4,0(a5)
 a88:	6310                	ld	a2,0(a4)
 a8a:	a83d                	j	ac8 <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 a8c:	ff852703          	lw	a4,-8(a0)
 a90:	9f31                	addw	a4,a4,a2
 a92:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 a94:	ff053683          	ld	a3,-16(a0)
 a98:	a091                	j	adc <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 a9a:	6398                	ld	a4,0(a5)
 a9c:	00e7e463          	bltu	a5,a4,aa4 <free+0x3a>
 aa0:	00e6ea63          	bltu	a3,a4,ab4 <free+0x4a>
{
 aa4:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 aa6:	fed7fae3          	bgeu	a5,a3,a9a <free+0x30>
 aaa:	6398                	ld	a4,0(a5)
 aac:	00e6e463          	bltu	a3,a4,ab4 <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 ab0:	fee7eae3          	bltu	a5,a4,aa4 <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 ab4:	ff852583          	lw	a1,-8(a0)
 ab8:	6390                	ld	a2,0(a5)
 aba:	02059813          	sll	a6,a1,0x20
 abe:	01c85713          	srl	a4,a6,0x1c
 ac2:	9736                	add	a4,a4,a3
 ac4:	fae60de3          	beq	a2,a4,a7e <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 ac8:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 acc:	4790                	lw	a2,8(a5)
 ace:	02061593          	sll	a1,a2,0x20
 ad2:	01c5d713          	srl	a4,a1,0x1c
 ad6:	973e                	add	a4,a4,a5
 ad8:	fae68ae3          	beq	a3,a4,a8c <free+0x22>
    p->s.ptr = bp->s.ptr;
 adc:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 ade:	00000717          	auipc	a4,0x0
 ae2:	52f73523          	sd	a5,1322(a4) # 1008 <freep>
}
 ae6:	6422                	ld	s0,8(sp)
 ae8:	0141                	add	sp,sp,16
 aea:	8082                	ret

0000000000000aec <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 aec:	7139                	add	sp,sp,-64
 aee:	fc06                	sd	ra,56(sp)
 af0:	f822                	sd	s0,48(sp)
 af2:	f426                	sd	s1,40(sp)
 af4:	f04a                	sd	s2,32(sp)
 af6:	ec4e                	sd	s3,24(sp)
 af8:	e852                	sd	s4,16(sp)
 afa:	e456                	sd	s5,8(sp)
 afc:	e05a                	sd	s6,0(sp)
 afe:	0080                	add	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 b00:	02051493          	sll	s1,a0,0x20
 b04:	9081                	srl	s1,s1,0x20
 b06:	04bd                	add	s1,s1,15
 b08:	8091                	srl	s1,s1,0x4
 b0a:	0014899b          	addw	s3,s1,1
 b0e:	0485                	add	s1,s1,1
  if((prevp = freep) == 0){
 b10:	00000517          	auipc	a0,0x0
 b14:	4f853503          	ld	a0,1272(a0) # 1008 <freep>
 b18:	c515                	beqz	a0,b44 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 b1a:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 b1c:	4798                	lw	a4,8(a5)
 b1e:	02977f63          	bgeu	a4,s1,b5c <malloc+0x70>
  if(nu < 4096)
 b22:	8a4e                	mv	s4,s3
 b24:	0009871b          	sext.w	a4,s3
 b28:	6685                	lui	a3,0x1
 b2a:	00d77363          	bgeu	a4,a3,b30 <malloc+0x44>
 b2e:	6a05                	lui	s4,0x1
 b30:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 b34:	004a1a1b          	sllw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 b38:	00000917          	auipc	s2,0x0
 b3c:	4d090913          	add	s2,s2,1232 # 1008 <freep>
  if(p == (char*)-1)
 b40:	5afd                	li	s5,-1
 b42:	a885                	j	bb2 <malloc+0xc6>
    base.s.ptr = freep = prevp = &base;
 b44:	00000797          	auipc	a5,0x0
 b48:	6cc78793          	add	a5,a5,1740 # 1210 <base>
 b4c:	00000717          	auipc	a4,0x0
 b50:	4af73e23          	sd	a5,1212(a4) # 1008 <freep>
 b54:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 b56:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 b5a:	b7e1                	j	b22 <malloc+0x36>
      if(p->s.size == nunits)
 b5c:	02e48c63          	beq	s1,a4,b94 <malloc+0xa8>
        p->s.size -= nunits;
 b60:	4137073b          	subw	a4,a4,s3
 b64:	c798                	sw	a4,8(a5)
        p += p->s.size;
 b66:	02071693          	sll	a3,a4,0x20
 b6a:	01c6d713          	srl	a4,a3,0x1c
 b6e:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 b70:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 b74:	00000717          	auipc	a4,0x0
 b78:	48a73a23          	sd	a0,1172(a4) # 1008 <freep>
      return (void*)(p + 1);
 b7c:	01078513          	add	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 b80:	70e2                	ld	ra,56(sp)
 b82:	7442                	ld	s0,48(sp)
 b84:	74a2                	ld	s1,40(sp)
 b86:	7902                	ld	s2,32(sp)
 b88:	69e2                	ld	s3,24(sp)
 b8a:	6a42                	ld	s4,16(sp)
 b8c:	6aa2                	ld	s5,8(sp)
 b8e:	6b02                	ld	s6,0(sp)
 b90:	6121                	add	sp,sp,64
 b92:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 b94:	6398                	ld	a4,0(a5)
 b96:	e118                	sd	a4,0(a0)
 b98:	bff1                	j	b74 <malloc+0x88>
  hp->s.size = nu;
 b9a:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 b9e:	0541                	add	a0,a0,16
 ba0:	ecbff0ef          	jal	a6a <free>
  return freep;
 ba4:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 ba8:	dd61                	beqz	a0,b80 <malloc+0x94>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 baa:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 bac:	4798                	lw	a4,8(a5)
 bae:	fa9777e3          	bgeu	a4,s1,b5c <malloc+0x70>
    if(p == freep)
 bb2:	00093703          	ld	a4,0(s2)
 bb6:	853e                	mv	a0,a5
 bb8:	fef719e3          	bne	a4,a5,baa <malloc+0xbe>
  p = sbrk(nu * sizeof(Header));
 bbc:	8552                	mv	a0,s4
 bbe:	a99ff0ef          	jal	656 <sbrk>
  if(p == (char*)-1)
 bc2:	fd551ce3          	bne	a0,s5,b9a <malloc+0xae>
        return 0;
 bc6:	4501                	li	a0,0
 bc8:	bf65                	j	b80 <malloc+0x94>
