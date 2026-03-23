
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
  32:	fe2d8d93          	add	s11,s11,-30 # 1010 <buf>
    for(i=0; i<n; i++){
      c++;
      if(buf[i] == '\n')
  36:	4aa9                	li	s5,10
        l++;
      if(strchr(" \r\t\n\v", buf[i]))
  38:	00001a17          	auipc	s4,0x1
  3c:	c08a0a13          	add	s4,s4,-1016 # c40 <malloc+0xe2>
        inword = 0;
  40:	4b81                	li	s7,0
  while((n = read(fd, buf, sizeof(buf))) > 0){
  42:	a035                	j	6e <wc+0x6e>
      if(strchr(" \r\t\n\v", buf[i]))
  44:	8552                	mv	a0,s4
  46:	1b6000ef          	jal	1fc <strchr>
  4a:	c919                	beqz	a0,60 <wc+0x60>
        inword = 0;
  4c:	895e                	mv	s2,s7
    for(i=0; i<n; i++){
  4e:	0485                	add	s1,s1,1
  50:	00998d63          	beq	s3,s1,6a <wc+0x6a>
      if(buf[i] == '\n')
  54:	0004c583          	lbu	a1,0(s1)
  58:	ff5596e3          	bne	a1,s5,44 <wc+0x44>
        l++;
  5c:	2c05                	addw	s8,s8,1
  5e:	b7dd                	j	44 <wc+0x44>
      else if(!inword){
  60:	fe0917e3          	bnez	s2,4e <wc+0x4e>
        w++;
  64:	2c85                	addw	s9,s9,1
        inword = 1;
  66:	4905                	li	s2,1
  68:	b7dd                	j	4e <wc+0x4e>
      c++;
  6a:	01ab0d3b          	addw	s10,s6,s10
  while((n = read(fd, buf, sizeof(buf))) > 0){
  6e:	20000613          	li	a2,512
  72:	85ee                	mv	a1,s11
  74:	f8843503          	ld	a0,-120(s0)
  78:	5e0000ef          	jal	658 <read>
  7c:	8b2a                	mv	s6,a0
  7e:	00a05963          	blez	a0,90 <wc+0x90>
    for(i=0; i<n; i++){
  82:	00001497          	auipc	s1,0x1
  86:	f8e48493          	add	s1,s1,-114 # 1010 <buf>
  8a:	009509b3          	add	s3,a0,s1
  8e:	b7d9                	j	54 <wc+0x54>
      }
    }
  }
  if(n < 0){
  90:	02054c63          	bltz	a0,c8 <wc+0xc8>
    printf("wc: read error\n");
    exit(1);
  }
  printf("%d %d %d %s\n", l, w, c, name);
  94:	f8043703          	ld	a4,-128(s0)
  98:	86ea                	mv	a3,s10
  9a:	8666                	mv	a2,s9
  9c:	85e2                	mv	a1,s8
  9e:	00001517          	auipc	a0,0x1
  a2:	bba50513          	add	a0,a0,-1094 # c58 <malloc+0xfa>
  a6:	205000ef          	jal	aaa <printf>
}
  aa:	70e6                	ld	ra,120(sp)
  ac:	7446                	ld	s0,112(sp)
  ae:	74a6                	ld	s1,104(sp)
  b0:	7906                	ld	s2,96(sp)
  b2:	69e6                	ld	s3,88(sp)
  b4:	6a46                	ld	s4,80(sp)
  b6:	6aa6                	ld	s5,72(sp)
  b8:	6b06                	ld	s6,64(sp)
  ba:	7be2                	ld	s7,56(sp)
  bc:	7c42                	ld	s8,48(sp)
  be:	7ca2                	ld	s9,40(sp)
  c0:	7d02                	ld	s10,32(sp)
  c2:	6de2                	ld	s11,24(sp)
  c4:	6109                	add	sp,sp,128
  c6:	8082                	ret
    printf("wc: read error\n");
  c8:	00001517          	auipc	a0,0x1
  cc:	b8050513          	add	a0,a0,-1152 # c48 <malloc+0xea>
  d0:	1db000ef          	jal	aaa <printf>
    exit(1);
  d4:	4505                	li	a0,1
  d6:	56a000ef          	jal	640 <exit>

00000000000000da <main>:

int
main(int argc, char *argv[])
{
  da:	7179                	add	sp,sp,-48
  dc:	f406                	sd	ra,40(sp)
  de:	f022                	sd	s0,32(sp)
  e0:	ec26                	sd	s1,24(sp)
  e2:	e84a                	sd	s2,16(sp)
  e4:	e44e                	sd	s3,8(sp)
  e6:	1800                	add	s0,sp,48
  int fd, i;

  if(argc <= 1){
  e8:	4785                	li	a5,1
  ea:	04a7d163          	bge	a5,a0,12c <main+0x52>
  ee:	00858913          	add	s2,a1,8
  f2:	ffe5099b          	addw	s3,a0,-2
  f6:	02099793          	sll	a5,s3,0x20
  fa:	01d7d993          	srl	s3,a5,0x1d
  fe:	05c1                	add	a1,a1,16
 100:	99ae                	add	s3,s3,a1
    wc(0, "");
    exit(0);
  }

  for(i = 1; i < argc; i++){
    if((fd = open(argv[i], O_RDONLY)) < 0){
 102:	4581                	li	a1,0
 104:	00093503          	ld	a0,0(s2)
 108:	578000ef          	jal	680 <open>
 10c:	84aa                	mv	s1,a0
 10e:	02054963          	bltz	a0,140 <main+0x66>
      printf("wc: cannot open %s\n", argv[i]);
      exit(1);
    }
    wc(fd, argv[i]);
 112:	00093583          	ld	a1,0(s2)
 116:	eebff0ef          	jal	0 <wc>
    close(fd);
 11a:	8526                	mv	a0,s1
 11c:	54c000ef          	jal	668 <close>
  for(i = 1; i < argc; i++){
 120:	0921                	add	s2,s2,8
 122:	ff3910e3          	bne	s2,s3,102 <main+0x28>
  }
  exit(0);
 126:	4501                	li	a0,0
 128:	518000ef          	jal	640 <exit>
    wc(0, "");
 12c:	00001597          	auipc	a1,0x1
 130:	b3c58593          	add	a1,a1,-1220 # c68 <malloc+0x10a>
 134:	4501                	li	a0,0
 136:	ecbff0ef          	jal	0 <wc>
    exit(0);
 13a:	4501                	li	a0,0
 13c:	504000ef          	jal	640 <exit>
      printf("wc: cannot open %s\n", argv[i]);
 140:	00093583          	ld	a1,0(s2)
 144:	00001517          	auipc	a0,0x1
 148:	b2c50513          	add	a0,a0,-1236 # c70 <malloc+0x112>
 14c:	15f000ef          	jal	aaa <printf>
      exit(1);
 150:	4505                	li	a0,1
 152:	4ee000ef          	jal	640 <exit>

0000000000000156 <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start()
{
 156:	1141                	add	sp,sp,-16
 158:	e406                	sd	ra,8(sp)
 15a:	e022                	sd	s0,0(sp)
 15c:	0800                	add	s0,sp,16
  extern int main();
  main();
 15e:	f7dff0ef          	jal	da <main>
  exit(0);
 162:	4501                	li	a0,0
 164:	4dc000ef          	jal	640 <exit>

0000000000000168 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
 168:	1141                	add	sp,sp,-16
 16a:	e422                	sd	s0,8(sp)
 16c:	0800                	add	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 16e:	87aa                	mv	a5,a0
 170:	0585                	add	a1,a1,1
 172:	0785                	add	a5,a5,1
 174:	fff5c703          	lbu	a4,-1(a1)
 178:	fee78fa3          	sb	a4,-1(a5)
 17c:	fb75                	bnez	a4,170 <strcpy+0x8>
    ;
  return os;
}
 17e:	6422                	ld	s0,8(sp)
 180:	0141                	add	sp,sp,16
 182:	8082                	ret

0000000000000184 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 184:	1141                	add	sp,sp,-16
 186:	e422                	sd	s0,8(sp)
 188:	0800                	add	s0,sp,16
  while(*p && *p == *q)
 18a:	00054783          	lbu	a5,0(a0)
 18e:	cb91                	beqz	a5,1a2 <strcmp+0x1e>
 190:	0005c703          	lbu	a4,0(a1)
 194:	00f71763          	bne	a4,a5,1a2 <strcmp+0x1e>
    p++, q++;
 198:	0505                	add	a0,a0,1
 19a:	0585                	add	a1,a1,1
  while(*p && *p == *q)
 19c:	00054783          	lbu	a5,0(a0)
 1a0:	fbe5                	bnez	a5,190 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 1a2:	0005c503          	lbu	a0,0(a1)
}
 1a6:	40a7853b          	subw	a0,a5,a0
 1aa:	6422                	ld	s0,8(sp)
 1ac:	0141                	add	sp,sp,16
 1ae:	8082                	ret

00000000000001b0 <strlen>:

uint
strlen(const char *s)
{
 1b0:	1141                	add	sp,sp,-16
 1b2:	e422                	sd	s0,8(sp)
 1b4:	0800                	add	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 1b6:	00054783          	lbu	a5,0(a0)
 1ba:	cf91                	beqz	a5,1d6 <strlen+0x26>
 1bc:	0505                	add	a0,a0,1
 1be:	87aa                	mv	a5,a0
 1c0:	86be                	mv	a3,a5
 1c2:	0785                	add	a5,a5,1
 1c4:	fff7c703          	lbu	a4,-1(a5)
 1c8:	ff65                	bnez	a4,1c0 <strlen+0x10>
 1ca:	40a6853b          	subw	a0,a3,a0
 1ce:	2505                	addw	a0,a0,1
    ;
  return n;
}
 1d0:	6422                	ld	s0,8(sp)
 1d2:	0141                	add	sp,sp,16
 1d4:	8082                	ret
  for(n = 0; s[n]; n++)
 1d6:	4501                	li	a0,0
 1d8:	bfe5                	j	1d0 <strlen+0x20>

00000000000001da <memset>:

void*
memset(void *dst, int c, uint n)
{
 1da:	1141                	add	sp,sp,-16
 1dc:	e422                	sd	s0,8(sp)
 1de:	0800                	add	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 1e0:	ca19                	beqz	a2,1f6 <memset+0x1c>
 1e2:	87aa                	mv	a5,a0
 1e4:	1602                	sll	a2,a2,0x20
 1e6:	9201                	srl	a2,a2,0x20
 1e8:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 1ec:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 1f0:	0785                	add	a5,a5,1
 1f2:	fee79de3          	bne	a5,a4,1ec <memset+0x12>
  }
  return dst;
}
 1f6:	6422                	ld	s0,8(sp)
 1f8:	0141                	add	sp,sp,16
 1fa:	8082                	ret

00000000000001fc <strchr>:

char*
strchr(const char *s, char c)
{
 1fc:	1141                	add	sp,sp,-16
 1fe:	e422                	sd	s0,8(sp)
 200:	0800                	add	s0,sp,16
  for(; *s; s++)
 202:	00054783          	lbu	a5,0(a0)
 206:	cb99                	beqz	a5,21c <strchr+0x20>
    if(*s == c)
 208:	00f58763          	beq	a1,a5,216 <strchr+0x1a>
  for(; *s; s++)
 20c:	0505                	add	a0,a0,1
 20e:	00054783          	lbu	a5,0(a0)
 212:	fbfd                	bnez	a5,208 <strchr+0xc>
      return (char*)s;
  return 0;
 214:	4501                	li	a0,0
}
 216:	6422                	ld	s0,8(sp)
 218:	0141                	add	sp,sp,16
 21a:	8082                	ret
  return 0;
 21c:	4501                	li	a0,0
 21e:	bfe5                	j	216 <strchr+0x1a>

0000000000000220 <gets>:

char*
gets(char *buf, int max)
{
 220:	711d                	add	sp,sp,-96
 222:	ec86                	sd	ra,88(sp)
 224:	e8a2                	sd	s0,80(sp)
 226:	e4a6                	sd	s1,72(sp)
 228:	e0ca                	sd	s2,64(sp)
 22a:	fc4e                	sd	s3,56(sp)
 22c:	f852                	sd	s4,48(sp)
 22e:	f456                	sd	s5,40(sp)
 230:	f05a                	sd	s6,32(sp)
 232:	ec5e                	sd	s7,24(sp)
 234:	1080                	add	s0,sp,96
 236:	8baa                	mv	s7,a0
 238:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 23a:	892a                	mv	s2,a0
 23c:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 23e:	4aa9                	li	s5,10
 240:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 242:	89a6                	mv	s3,s1
 244:	2485                	addw	s1,s1,1
 246:	0344d663          	bge	s1,s4,272 <gets+0x52>
    cc = read(0, &c, 1);
 24a:	4605                	li	a2,1
 24c:	faf40593          	add	a1,s0,-81
 250:	4501                	li	a0,0
 252:	406000ef          	jal	658 <read>
    if(cc < 1)
 256:	00a05e63          	blez	a0,272 <gets+0x52>
    buf[i++] = c;
 25a:	faf44783          	lbu	a5,-81(s0)
 25e:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 262:	01578763          	beq	a5,s5,270 <gets+0x50>
 266:	0905                	add	s2,s2,1
 268:	fd679de3          	bne	a5,s6,242 <gets+0x22>
  for(i=0; i+1 < max; ){
 26c:	89a6                	mv	s3,s1
 26e:	a011                	j	272 <gets+0x52>
 270:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 272:	99de                	add	s3,s3,s7
 274:	00098023          	sb	zero,0(s3)
  return buf;
}
 278:	855e                	mv	a0,s7
 27a:	60e6                	ld	ra,88(sp)
 27c:	6446                	ld	s0,80(sp)
 27e:	64a6                	ld	s1,72(sp)
 280:	6906                	ld	s2,64(sp)
 282:	79e2                	ld	s3,56(sp)
 284:	7a42                	ld	s4,48(sp)
 286:	7aa2                	ld	s5,40(sp)
 288:	7b02                	ld	s6,32(sp)
 28a:	6be2                	ld	s7,24(sp)
 28c:	6125                	add	sp,sp,96
 28e:	8082                	ret

0000000000000290 <stat>:

int
stat(const char *n, struct stat *st)
{
 290:	1101                	add	sp,sp,-32
 292:	ec06                	sd	ra,24(sp)
 294:	e822                	sd	s0,16(sp)
 296:	e426                	sd	s1,8(sp)
 298:	e04a                	sd	s2,0(sp)
 29a:	1000                	add	s0,sp,32
 29c:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 29e:	4581                	li	a1,0
 2a0:	3e0000ef          	jal	680 <open>
  if(fd < 0)
 2a4:	02054163          	bltz	a0,2c6 <stat+0x36>
 2a8:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 2aa:	85ca                	mv	a1,s2
 2ac:	3ec000ef          	jal	698 <fstat>
 2b0:	892a                	mv	s2,a0
  close(fd);
 2b2:	8526                	mv	a0,s1
 2b4:	3b4000ef          	jal	668 <close>
  return r;
}
 2b8:	854a                	mv	a0,s2
 2ba:	60e2                	ld	ra,24(sp)
 2bc:	6442                	ld	s0,16(sp)
 2be:	64a2                	ld	s1,8(sp)
 2c0:	6902                	ld	s2,0(sp)
 2c2:	6105                	add	sp,sp,32
 2c4:	8082                	ret
    return -1;
 2c6:	597d                	li	s2,-1
 2c8:	bfc5                	j	2b8 <stat+0x28>

00000000000002ca <atoi>:

int
atoi(const char *s)
{
 2ca:	1141                	add	sp,sp,-16
 2cc:	e422                	sd	s0,8(sp)
 2ce:	0800                	add	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 2d0:	00054683          	lbu	a3,0(a0)
 2d4:	fd06879b          	addw	a5,a3,-48
 2d8:	0ff7f793          	zext.b	a5,a5
 2dc:	4625                	li	a2,9
 2de:	02f66863          	bltu	a2,a5,30e <atoi+0x44>
 2e2:	872a                	mv	a4,a0
  n = 0;
 2e4:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 2e6:	0705                	add	a4,a4,1
 2e8:	0025179b          	sllw	a5,a0,0x2
 2ec:	9fa9                	addw	a5,a5,a0
 2ee:	0017979b          	sllw	a5,a5,0x1
 2f2:	9fb5                	addw	a5,a5,a3
 2f4:	fd07851b          	addw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 2f8:	00074683          	lbu	a3,0(a4)
 2fc:	fd06879b          	addw	a5,a3,-48
 300:	0ff7f793          	zext.b	a5,a5
 304:	fef671e3          	bgeu	a2,a5,2e6 <atoi+0x1c>
  return n;
}
 308:	6422                	ld	s0,8(sp)
 30a:	0141                	add	sp,sp,16
 30c:	8082                	ret
  n = 0;
 30e:	4501                	li	a0,0
 310:	bfe5                	j	308 <atoi+0x3e>

0000000000000312 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 312:	1141                	add	sp,sp,-16
 314:	e422                	sd	s0,8(sp)
 316:	0800                	add	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 318:	02b57463          	bgeu	a0,a1,340 <memmove+0x2e>
    while(n-- > 0)
 31c:	00c05f63          	blez	a2,33a <memmove+0x28>
 320:	1602                	sll	a2,a2,0x20
 322:	9201                	srl	a2,a2,0x20
 324:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 328:	872a                	mv	a4,a0
      *dst++ = *src++;
 32a:	0585                	add	a1,a1,1
 32c:	0705                	add	a4,a4,1
 32e:	fff5c683          	lbu	a3,-1(a1)
 332:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 336:	fee79ae3          	bne	a5,a4,32a <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 33a:	6422                	ld	s0,8(sp)
 33c:	0141                	add	sp,sp,16
 33e:	8082                	ret
    dst += n;
 340:	00c50733          	add	a4,a0,a2
    src += n;
 344:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 346:	fec05ae3          	blez	a2,33a <memmove+0x28>
 34a:	fff6079b          	addw	a5,a2,-1
 34e:	1782                	sll	a5,a5,0x20
 350:	9381                	srl	a5,a5,0x20
 352:	fff7c793          	not	a5,a5
 356:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 358:	15fd                	add	a1,a1,-1
 35a:	177d                	add	a4,a4,-1
 35c:	0005c683          	lbu	a3,0(a1)
 360:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 364:	fee79ae3          	bne	a5,a4,358 <memmove+0x46>
 368:	bfc9                	j	33a <memmove+0x28>

000000000000036a <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 36a:	1141                	add	sp,sp,-16
 36c:	e422                	sd	s0,8(sp)
 36e:	0800                	add	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 370:	ca05                	beqz	a2,3a0 <memcmp+0x36>
 372:	fff6069b          	addw	a3,a2,-1
 376:	1682                	sll	a3,a3,0x20
 378:	9281                	srl	a3,a3,0x20
 37a:	0685                	add	a3,a3,1
 37c:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 37e:	00054783          	lbu	a5,0(a0)
 382:	0005c703          	lbu	a4,0(a1)
 386:	00e79863          	bne	a5,a4,396 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 38a:	0505                	add	a0,a0,1
    p2++;
 38c:	0585                	add	a1,a1,1
  while (n-- > 0) {
 38e:	fed518e3          	bne	a0,a3,37e <memcmp+0x14>
  }
  return 0;
 392:	4501                	li	a0,0
 394:	a019                	j	39a <memcmp+0x30>
      return *p1 - *p2;
 396:	40e7853b          	subw	a0,a5,a4
}
 39a:	6422                	ld	s0,8(sp)
 39c:	0141                	add	sp,sp,16
 39e:	8082                	ret
  return 0;
 3a0:	4501                	li	a0,0
 3a2:	bfe5                	j	39a <memcmp+0x30>

00000000000003a4 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 3a4:	1141                	add	sp,sp,-16
 3a6:	e406                	sd	ra,8(sp)
 3a8:	e022                	sd	s0,0(sp)
 3aa:	0800                	add	s0,sp,16
  return memmove(dst, src, n);
 3ac:	f67ff0ef          	jal	312 <memmove>
}
 3b0:	60a2                	ld	ra,8(sp)
 3b2:	6402                	ld	s0,0(sp)
 3b4:	0141                	add	sp,sp,16
 3b6:	8082                	ret

00000000000003b8 <htons>:
    return (v & 0x000000ff) << 24 | (v & 0x0000ff00) << 8 | (v & 0x00ff0000) >> 8 | (v & 0xff000000) >> 24;
}

uint16_t
htons(uint16_t h)
{
 3b8:	1141                	add	sp,sp,-16
 3ba:	e422                	sd	s0,8(sp)
 3bc:	0800                	add	s0,sp,16
    if (!endian) {
 3be:	00001797          	auipc	a5,0x1
 3c2:	c427a783          	lw	a5,-958(a5) # 1000 <endian>
 3c6:	e385                	bnez	a5,3e6 <htons+0x2e>
        endian = byteorder();
 3c8:	4d200793          	li	a5,1234
 3cc:	00001717          	auipc	a4,0x1
 3d0:	c2f72a23          	sw	a5,-972(a4) # 1000 <endian>
    return (v & 0x00ff) << 8 | (v & 0xff00 ) >> 8;
 3d4:	0085579b          	srlw	a5,a0,0x8
 3d8:	0085151b          	sllw	a0,a0,0x8
 3dc:	8fc9                	or	a5,a5,a0
 3de:	03079513          	sll	a0,a5,0x30
 3e2:	9141                	srl	a0,a0,0x30
 3e4:	a029                	j	3ee <htons+0x36>
    }
    return endian == __LITTLE_ENDIAN ? byteswap16(h) : h;
 3e6:	4d200713          	li	a4,1234
 3ea:	fee785e3          	beq	a5,a4,3d4 <htons+0x1c>
}
 3ee:	6422                	ld	s0,8(sp)
 3f0:	0141                	add	sp,sp,16
 3f2:	8082                	ret

00000000000003f4 <ntohs>:

uint16_t
ntohs(uint16_t n)
{
 3f4:	1141                	add	sp,sp,-16
 3f6:	e422                	sd	s0,8(sp)
 3f8:	0800                	add	s0,sp,16
    if (!endian) {
 3fa:	00001797          	auipc	a5,0x1
 3fe:	c067a783          	lw	a5,-1018(a5) # 1000 <endian>
 402:	e385                	bnez	a5,422 <ntohs+0x2e>
        endian = byteorder();
 404:	4d200793          	li	a5,1234
 408:	00001717          	auipc	a4,0x1
 40c:	bef72c23          	sw	a5,-1032(a4) # 1000 <endian>
    return (v & 0x00ff) << 8 | (v & 0xff00 ) >> 8;
 410:	0085579b          	srlw	a5,a0,0x8
 414:	0085151b          	sllw	a0,a0,0x8
 418:	8fc9                	or	a5,a5,a0
 41a:	03079513          	sll	a0,a5,0x30
 41e:	9141                	srl	a0,a0,0x30
 420:	a029                	j	42a <ntohs+0x36>
    }
    return endian == __LITTLE_ENDIAN ? byteswap16(n) : n;
 422:	4d200713          	li	a4,1234
 426:	fee785e3          	beq	a5,a4,410 <ntohs+0x1c>
}
 42a:	6422                	ld	s0,8(sp)
 42c:	0141                	add	sp,sp,16
 42e:	8082                	ret

0000000000000430 <htonl>:

uint32_t
htonl(uint32_t h)
{
 430:	1141                	add	sp,sp,-16
 432:	e422                	sd	s0,8(sp)
 434:	0800                	add	s0,sp,16
    if (!endian) {
 436:	00001797          	auipc	a5,0x1
 43a:	bca7a783          	lw	a5,-1078(a5) # 1000 <endian>
 43e:	ef85                	bnez	a5,476 <htonl+0x46>
        endian = byteorder();
 440:	4d200793          	li	a5,1234
 444:	00001717          	auipc	a4,0x1
 448:	baf72e23          	sw	a5,-1092(a4) # 1000 <endian>
    return (v & 0x000000ff) << 24 | (v & 0x0000ff00) << 8 | (v & 0x00ff0000) >> 8 | (v & 0xff000000) >> 24;
 44c:	0185179b          	sllw	a5,a0,0x18
 450:	0185571b          	srlw	a4,a0,0x18
 454:	8fd9                	or	a5,a5,a4
 456:	0085171b          	sllw	a4,a0,0x8
 45a:	00ff06b7          	lui	a3,0xff0
 45e:	8f75                	and	a4,a4,a3
 460:	8fd9                	or	a5,a5,a4
 462:	0085551b          	srlw	a0,a0,0x8
 466:	6741                	lui	a4,0x10
 468:	f0070713          	add	a4,a4,-256 # ff00 <base+0xecf0>
 46c:	8d79                	and	a0,a0,a4
 46e:	8fc9                	or	a5,a5,a0
 470:	0007851b          	sext.w	a0,a5
 474:	a029                	j	47e <htonl+0x4e>
    }
    return endian == __LITTLE_ENDIAN ? byteswap32(h) : h;
 476:	4d200713          	li	a4,1234
 47a:	fce789e3          	beq	a5,a4,44c <htonl+0x1c>
}
 47e:	6422                	ld	s0,8(sp)
 480:	0141                	add	sp,sp,16
 482:	8082                	ret

0000000000000484 <ntohl>:

uint32_t
ntohl(uint32_t n)
{
 484:	1141                	add	sp,sp,-16
 486:	e422                	sd	s0,8(sp)
 488:	0800                	add	s0,sp,16
    if (!endian) {
 48a:	00001797          	auipc	a5,0x1
 48e:	b767a783          	lw	a5,-1162(a5) # 1000 <endian>
 492:	ef85                	bnez	a5,4ca <ntohl+0x46>
        endian = byteorder();
 494:	4d200793          	li	a5,1234
 498:	00001717          	auipc	a4,0x1
 49c:	b6f72423          	sw	a5,-1176(a4) # 1000 <endian>
    return (v & 0x000000ff) << 24 | (v & 0x0000ff00) << 8 | (v & 0x00ff0000) >> 8 | (v & 0xff000000) >> 24;
 4a0:	0185179b          	sllw	a5,a0,0x18
 4a4:	0185571b          	srlw	a4,a0,0x18
 4a8:	8fd9                	or	a5,a5,a4
 4aa:	0085171b          	sllw	a4,a0,0x8
 4ae:	00ff06b7          	lui	a3,0xff0
 4b2:	8f75                	and	a4,a4,a3
 4b4:	8fd9                	or	a5,a5,a4
 4b6:	0085551b          	srlw	a0,a0,0x8
 4ba:	6741                	lui	a4,0x10
 4bc:	f0070713          	add	a4,a4,-256 # ff00 <base+0xecf0>
 4c0:	8d79                	and	a0,a0,a4
 4c2:	8fc9                	or	a5,a5,a0
 4c4:	0007851b          	sext.w	a0,a5
 4c8:	a029                	j	4d2 <ntohl+0x4e>
    }
    return endian == __LITTLE_ENDIAN ? byteswap32(n) : n;
 4ca:	4d200713          	li	a4,1234
 4ce:	fce789e3          	beq	a5,a4,4a0 <ntohl+0x1c>
}
 4d2:	6422                	ld	s0,8(sp)
 4d4:	0141                	add	sp,sp,16
 4d6:	8082                	ret

00000000000004d8 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
 4d8:	1141                	add	sp,sp,-16
 4da:	e422                	sd	s0,8(sp)
 4dc:	0800                	add	s0,sp,16
 4de:	872a                	mv	a4,a0
    int neg = 0;
    long val = 0;

    // gobble initial whitespace
    while (*s == ' ' || *s == '\t')
 4e0:	02000693          	li	a3,32
 4e4:	4525                	li	a0,9
 4e6:	a011                	j	4ea <strtol+0x12>
        s++;
 4e8:	0705                	add	a4,a4,1
    while (*s == ' ' || *s == '\t')
 4ea:	00074783          	lbu	a5,0(a4)
 4ee:	fed78de3          	beq	a5,a3,4e8 <strtol+0x10>
 4f2:	fea78be3          	beq	a5,a0,4e8 <strtol+0x10>

    // plus/minus sign
    if (*s == '+')
 4f6:	02b00693          	li	a3,43
 4fa:	02d78663          	beq	a5,a3,526 <strtol+0x4e>
        s++;
    else if (*s == '-')
 4fe:	02d00693          	li	a3,45
    int neg = 0;
 502:	4301                	li	t1,0
    else if (*s == '-')
 504:	02d78463          	beq	a5,a3,52c <strtol+0x54>
        s++, neg = 1;

    // hex or octal base prefix
    if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
 508:	fef67793          	and	a5,a2,-17
 50c:	eb89                	bnez	a5,51e <strtol+0x46>
 50e:	00074683          	lbu	a3,0(a4)
 512:	03000793          	li	a5,48
 516:	00f68e63          	beq	a3,a5,532 <strtol+0x5a>
        s += 2, base = 16;
    else if (base == 0 && s[0] == '0')
 51a:	e211                	bnez	a2,51e <strtol+0x46>
        s++, base = 8;
    else if (base == 0)
        base = 10;
 51c:	4629                	li	a2,10
 51e:	4501                	li	a0,0

    // digits
    while (1) {
        int dig;

        if (*s >= '0' && *s <= '9')
 520:	4825                	li	a6,9
            dig = *s - '0';
        else if (*s >= 'a' && *s <= 'z')
 522:	48e5                	li	a7,25
 524:	a825                	j	55c <strtol+0x84>
        s++;
 526:	0705                	add	a4,a4,1
    int neg = 0;
 528:	4301                	li	t1,0
 52a:	bff9                	j	508 <strtol+0x30>
        s++, neg = 1;
 52c:	0705                	add	a4,a4,1
 52e:	4305                	li	t1,1
 530:	bfe1                	j	508 <strtol+0x30>
    if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
 532:	00174683          	lbu	a3,1(a4)
 536:	07800793          	li	a5,120
 53a:	00f68663          	beq	a3,a5,546 <strtol+0x6e>
    else if (base == 0 && s[0] == '0')
 53e:	f265                	bnez	a2,51e <strtol+0x46>
        s++, base = 8;
 540:	0705                	add	a4,a4,1
 542:	4621                	li	a2,8
 544:	bfe9                	j	51e <strtol+0x46>
        s += 2, base = 16;
 546:	0709                	add	a4,a4,2
 548:	4641                	li	a2,16
 54a:	bfd1                	j	51e <strtol+0x46>
            dig = *s - '0';
 54c:	fd07879b          	addw	a5,a5,-48
            dig = *s - 'a' + 10;
        else if (*s >= 'A' && *s <= 'Z')
            dig = *s - 'A' + 10;
        else
            break;
        if (dig >= base)
 550:	04c7d063          	bge	a5,a2,590 <strtol+0xb8>
            break;
        s++, val = (val * base) + dig;
 554:	0705                	add	a4,a4,1
 556:	02a60533          	mul	a0,a2,a0
 55a:	953e                	add	a0,a0,a5
        if (*s >= '0' && *s <= '9')
 55c:	00074783          	lbu	a5,0(a4)
 560:	fd07869b          	addw	a3,a5,-48
 564:	0ff6f693          	zext.b	a3,a3
 568:	fed872e3          	bgeu	a6,a3,54c <strtol+0x74>
        else if (*s >= 'a' && *s <= 'z')
 56c:	f9f7869b          	addw	a3,a5,-97
 570:	0ff6f693          	zext.b	a3,a3
 574:	00d8e563          	bltu	a7,a3,57e <strtol+0xa6>
            dig = *s - 'a' + 10;
 578:	fa97879b          	addw	a5,a5,-87
 57c:	bfd1                	j	550 <strtol+0x78>
        else if (*s >= 'A' && *s <= 'Z')
 57e:	fbf7869b          	addw	a3,a5,-65
 582:	0ff6f693          	zext.b	a3,a3
 586:	00d8e563          	bltu	a7,a3,590 <strtol+0xb8>
            dig = *s - 'A' + 10;
 58a:	fc97879b          	addw	a5,a5,-55
 58e:	b7c9                	j	550 <strtol+0x78>
        // we don't properly detect overflow!
    }

    if (endptr)
 590:	c191                	beqz	a1,594 <strtol+0xbc>
        *endptr = (char *) s;
 592:	e198                	sd	a4,0(a1)
    return (neg ? -val : val);
 594:	00030463          	beqz	t1,59c <strtol+0xc4>
 598:	40a00533          	neg	a0,a0
}
 59c:	6422                	ld	s0,8(sp)
 59e:	0141                	add	sp,sp,16
 5a0:	8082                	ret

00000000000005a2 <inet_pton>:
inet_pton (int family, const char *p, void *n) {
    char *sp, *ep;
    int idx;
    long ret;

    if (family != AF_INET) {
 5a2:	4785                	li	a5,1
 5a4:	08f51263          	bne	a0,a5,628 <inet_pton+0x86>
inet_pton (int family, const char *p, void *n) {
 5a8:	715d                	add	sp,sp,-80
 5aa:	e486                	sd	ra,72(sp)
 5ac:	e0a2                	sd	s0,64(sp)
 5ae:	fc26                	sd	s1,56(sp)
 5b0:	f84a                	sd	s2,48(sp)
 5b2:	f44e                	sd	s3,40(sp)
 5b4:	f052                	sd	s4,32(sp)
 5b6:	ec56                	sd	s5,24(sp)
 5b8:	e85a                	sd	s6,16(sp)
 5ba:	0880                	add	s0,sp,80
 5bc:	892e                	mv	s2,a1
 5be:	89b2                	mv	s3,a2
 5c0:	4481                	li	s1,0
        return -1;
    }
    sp = (char *)p;
    for (idx = 0; idx < 4; idx++) {
        ret = strtol(sp, &ep, 10);
        if (ret < 0 || ret > 255) {
 5c2:	0ff00a13          	li	s4,255
            return -1;
        }
        if (ep == sp) {
            return -1;
        }
        if ((idx == 3 && *ep != '\0') || (idx != 3 && *ep != '.')) {
 5c6:	4a8d                	li	s5,3
 5c8:	02e00b13          	li	s6,46
 5cc:	a815                	j	600 <inet_pton+0x5e>
 5ce:	0007c783          	lbu	a5,0(a5)
 5d2:	e3ad                	bnez	a5,634 <inet_pton+0x92>
            return -1;
        }
        ((uint8_t *)n)[idx] = ret;
 5d4:	2481                	sext.w	s1,s1
 5d6:	99a6                	add	s3,s3,s1
 5d8:	00a98023          	sb	a0,0(s3)
        sp = ep + 1;
    }
    return 0;
 5dc:	4501                	li	a0,0
}
 5de:	60a6                	ld	ra,72(sp)
 5e0:	6406                	ld	s0,64(sp)
 5e2:	74e2                	ld	s1,56(sp)
 5e4:	7942                	ld	s2,48(sp)
 5e6:	79a2                	ld	s3,40(sp)
 5e8:	7a02                	ld	s4,32(sp)
 5ea:	6ae2                	ld	s5,24(sp)
 5ec:	6b42                	ld	s6,16(sp)
 5ee:	6161                	add	sp,sp,80
 5f0:	8082                	ret
        ((uint8_t *)n)[idx] = ret;
 5f2:	00998733          	add	a4,s3,s1
 5f6:	00a70023          	sb	a0,0(a4)
        sp = ep + 1;
 5fa:	00178913          	add	s2,a5,1
    for (idx = 0; idx < 4; idx++) {
 5fe:	0485                	add	s1,s1,1
        ret = strtol(sp, &ep, 10);
 600:	4629                	li	a2,10
 602:	fb840593          	add	a1,s0,-72
 606:	854a                	mv	a0,s2
 608:	ed1ff0ef          	jal	4d8 <strtol>
        if (ret < 0 || ret > 255) {
 60c:	02aa6063          	bltu	s4,a0,62c <inet_pton+0x8a>
        if (ep == sp) {
 610:	fb843783          	ld	a5,-72(s0)
 614:	01278e63          	beq	a5,s2,630 <inet_pton+0x8e>
        if ((idx == 3 && *ep != '\0') || (idx != 3 && *ep != '.')) {
 618:	fb548be3          	beq	s1,s5,5ce <inet_pton+0x2c>
 61c:	0007c703          	lbu	a4,0(a5)
 620:	fd6709e3          	beq	a4,s6,5f2 <inet_pton+0x50>
            return -1;
 624:	557d                	li	a0,-1
 626:	bf65                	j	5de <inet_pton+0x3c>
        return -1;
 628:	557d                	li	a0,-1
}
 62a:	8082                	ret
            return -1;
 62c:	557d                	li	a0,-1
 62e:	bf45                	j	5de <inet_pton+0x3c>
            return -1;
 630:	557d                	li	a0,-1
 632:	b775                	j	5de <inet_pton+0x3c>
            return -1;
 634:	557d                	li	a0,-1
 636:	b765                	j	5de <inet_pton+0x3c>

0000000000000638 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 638:	4885                	li	a7,1
 ecall
 63a:	00000073          	ecall
 ret
 63e:	8082                	ret

0000000000000640 <exit>:
.global exit
exit:
 li a7, SYS_exit
 640:	4889                	li	a7,2
 ecall
 642:	00000073          	ecall
 ret
 646:	8082                	ret

0000000000000648 <wait>:
.global wait
wait:
 li a7, SYS_wait
 648:	488d                	li	a7,3
 ecall
 64a:	00000073          	ecall
 ret
 64e:	8082                	ret

0000000000000650 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 650:	4891                	li	a7,4
 ecall
 652:	00000073          	ecall
 ret
 656:	8082                	ret

0000000000000658 <read>:
.global read
read:
 li a7, SYS_read
 658:	4895                	li	a7,5
 ecall
 65a:	00000073          	ecall
 ret
 65e:	8082                	ret

0000000000000660 <write>:
.global write
write:
 li a7, SYS_write
 660:	48c1                	li	a7,16
 ecall
 662:	00000073          	ecall
 ret
 666:	8082                	ret

0000000000000668 <close>:
.global close
close:
 li a7, SYS_close
 668:	48d5                	li	a7,21
 ecall
 66a:	00000073          	ecall
 ret
 66e:	8082                	ret

0000000000000670 <kill>:
.global kill
kill:
 li a7, SYS_kill
 670:	4899                	li	a7,6
 ecall
 672:	00000073          	ecall
 ret
 676:	8082                	ret

0000000000000678 <exec>:
.global exec
exec:
 li a7, SYS_exec
 678:	489d                	li	a7,7
 ecall
 67a:	00000073          	ecall
 ret
 67e:	8082                	ret

0000000000000680 <open>:
.global open
open:
 li a7, SYS_open
 680:	48bd                	li	a7,15
 ecall
 682:	00000073          	ecall
 ret
 686:	8082                	ret

0000000000000688 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 688:	48c5                	li	a7,17
 ecall
 68a:	00000073          	ecall
 ret
 68e:	8082                	ret

0000000000000690 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 690:	48c9                	li	a7,18
 ecall
 692:	00000073          	ecall
 ret
 696:	8082                	ret

0000000000000698 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 698:	48a1                	li	a7,8
 ecall
 69a:	00000073          	ecall
 ret
 69e:	8082                	ret

00000000000006a0 <link>:
.global link
link:
 li a7, SYS_link
 6a0:	48cd                	li	a7,19
 ecall
 6a2:	00000073          	ecall
 ret
 6a6:	8082                	ret

00000000000006a8 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 6a8:	48d1                	li	a7,20
 ecall
 6aa:	00000073          	ecall
 ret
 6ae:	8082                	ret

00000000000006b0 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 6b0:	48a5                	li	a7,9
 ecall
 6b2:	00000073          	ecall
 ret
 6b6:	8082                	ret

00000000000006b8 <dup>:
.global dup
dup:
 li a7, SYS_dup
 6b8:	48a9                	li	a7,10
 ecall
 6ba:	00000073          	ecall
 ret
 6be:	8082                	ret

00000000000006c0 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 6c0:	48ad                	li	a7,11
 ecall
 6c2:	00000073          	ecall
 ret
 6c6:	8082                	ret

00000000000006c8 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 6c8:	48b1                	li	a7,12
 ecall
 6ca:	00000073          	ecall
 ret
 6ce:	8082                	ret

00000000000006d0 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 6d0:	48b5                	li	a7,13
 ecall
 6d2:	00000073          	ecall
 ret
 6d6:	8082                	ret

00000000000006d8 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 6d8:	48b9                	li	a7,14
 ecall
 6da:	00000073          	ecall
 ret
 6de:	8082                	ret

00000000000006e0 <socket>:
.global socket
socket:
 li a7, SYS_socket
 6e0:	48d9                	li	a7,22
 ecall
 6e2:	00000073          	ecall
 ret
 6e6:	8082                	ret

00000000000006e8 <bind>:
.global bind
bind:
 li a7, SYS_bind
 6e8:	48dd                	li	a7,23
 ecall
 6ea:	00000073          	ecall
 ret
 6ee:	8082                	ret

00000000000006f0 <recvfrom>:
.global recvfrom
recvfrom:
 li a7, SYS_recvfrom
 6f0:	48e1                	li	a7,24
 ecall
 6f2:	00000073          	ecall
 ret
 6f6:	8082                	ret

00000000000006f8 <sendto>:
.global sendto
sendto:
 li a7, SYS_sendto
 6f8:	48e5                	li	a7,25
 ecall
 6fa:	00000073          	ecall
 ret
 6fe:	8082                	ret

0000000000000700 <connect>:
.global connect
connect:
 li a7, SYS_connect
 700:	48e9                	li	a7,26
 ecall
 702:	00000073          	ecall
 ret
 706:	8082                	ret

0000000000000708 <listen>:
.global listen
listen:
 li a7, SYS_listen
 708:	48ed                	li	a7,27
 ecall
 70a:	00000073          	ecall
 ret
 70e:	8082                	ret

0000000000000710 <accept>:
.global accept
accept:
 li a7, SYS_accept
 710:	48f1                	li	a7,28
 ecall
 712:	00000073          	ecall
 ret
 716:	8082                	ret

0000000000000718 <recv>:
.global recv
recv:
 li a7, SYS_recv
 718:	48f5                	li	a7,29
 ecall
 71a:	00000073          	ecall
 ret
 71e:	8082                	ret

0000000000000720 <send>:
.global send
send:
 li a7, SYS_send
 720:	48f9                	li	a7,30
 ecall
 722:	00000073          	ecall
 ret
 726:	8082                	ret

0000000000000728 <ioctl>:
.global ioctl
ioctl:
 li a7, SYS_ioctl
 728:	48fd                	li	a7,31
 ecall
 72a:	00000073          	ecall
 ret
 72e:	8082                	ret

0000000000000730 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 730:	1101                	add	sp,sp,-32
 732:	ec06                	sd	ra,24(sp)
 734:	e822                	sd	s0,16(sp)
 736:	1000                	add	s0,sp,32
 738:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 73c:	4605                	li	a2,1
 73e:	fef40593          	add	a1,s0,-17
 742:	f1fff0ef          	jal	660 <write>
}
 746:	60e2                	ld	ra,24(sp)
 748:	6442                	ld	s0,16(sp)
 74a:	6105                	add	sp,sp,32
 74c:	8082                	ret

000000000000074e <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
 74e:	715d                	add	sp,sp,-80
 750:	e486                	sd	ra,72(sp)
 752:	e0a2                	sd	s0,64(sp)
 754:	fc26                	sd	s1,56(sp)
 756:	f84a                	sd	s2,48(sp)
 758:	f44e                	sd	s3,40(sp)
 75a:	0880                	add	s0,sp,80
 75c:	84aa                	mv	s1,a0
  char buf[20];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 75e:	c299                	beqz	a3,764 <printint+0x16>
 760:	0805c763          	bltz	a1,7ee <printint+0xa0>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 764:	2581                	sext.w	a1,a1
  neg = 0;
 766:	4881                	li	a7,0
 768:	fb840693          	add	a3,s0,-72
  }

  i = 0;
 76c:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 76e:	2601                	sext.w	a2,a2
 770:	00000517          	auipc	a0,0x0
 774:	52050513          	add	a0,a0,1312 # c90 <digits>
 778:	883a                	mv	a6,a4
 77a:	2705                	addw	a4,a4,1
 77c:	02c5f7bb          	remuw	a5,a1,a2
 780:	1782                	sll	a5,a5,0x20
 782:	9381                	srl	a5,a5,0x20
 784:	97aa                	add	a5,a5,a0
 786:	0007c783          	lbu	a5,0(a5)
 78a:	00f68023          	sb	a5,0(a3) # ff0000 <base+0xfeedf0>
  }while((x /= base) != 0);
 78e:	0005879b          	sext.w	a5,a1
 792:	02c5d5bb          	divuw	a1,a1,a2
 796:	0685                	add	a3,a3,1
 798:	fec7f0e3          	bgeu	a5,a2,778 <printint+0x2a>
  if(neg)
 79c:	00088c63          	beqz	a7,7b4 <printint+0x66>
    buf[i++] = '-';
 7a0:	fd070793          	add	a5,a4,-48
 7a4:	00878733          	add	a4,a5,s0
 7a8:	02d00793          	li	a5,45
 7ac:	fef70423          	sb	a5,-24(a4)
 7b0:	0028071b          	addw	a4,a6,2

  while(--i >= 0)
 7b4:	02e05663          	blez	a4,7e0 <printint+0x92>
 7b8:	fb840793          	add	a5,s0,-72
 7bc:	00e78933          	add	s2,a5,a4
 7c0:	fff78993          	add	s3,a5,-1
 7c4:	99ba                	add	s3,s3,a4
 7c6:	377d                	addw	a4,a4,-1
 7c8:	1702                	sll	a4,a4,0x20
 7ca:	9301                	srl	a4,a4,0x20
 7cc:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 7d0:	fff94583          	lbu	a1,-1(s2)
 7d4:	8526                	mv	a0,s1
 7d6:	f5bff0ef          	jal	730 <putc>
  while(--i >= 0)
 7da:	197d                	add	s2,s2,-1
 7dc:	ff391ae3          	bne	s2,s3,7d0 <printint+0x82>
}
 7e0:	60a6                	ld	ra,72(sp)
 7e2:	6406                	ld	s0,64(sp)
 7e4:	74e2                	ld	s1,56(sp)
 7e6:	7942                	ld	s2,48(sp)
 7e8:	79a2                	ld	s3,40(sp)
 7ea:	6161                	add	sp,sp,80
 7ec:	8082                	ret
    x = -xx;
 7ee:	40b005bb          	negw	a1,a1
    neg = 1;
 7f2:	4885                	li	a7,1
    x = -xx;
 7f4:	bf95                	j	768 <printint+0x1a>

00000000000007f6 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 7f6:	711d                	add	sp,sp,-96
 7f8:	ec86                	sd	ra,88(sp)
 7fa:	e8a2                	sd	s0,80(sp)
 7fc:	e4a6                	sd	s1,72(sp)
 7fe:	e0ca                	sd	s2,64(sp)
 800:	fc4e                	sd	s3,56(sp)
 802:	f852                	sd	s4,48(sp)
 804:	f456                	sd	s5,40(sp)
 806:	f05a                	sd	s6,32(sp)
 808:	ec5e                	sd	s7,24(sp)
 80a:	e862                	sd	s8,16(sp)
 80c:	e466                	sd	s9,8(sp)
 80e:	e06a                	sd	s10,0(sp)
 810:	1080                	add	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 812:	0005c903          	lbu	s2,0(a1)
 816:	24090763          	beqz	s2,a64 <vprintf+0x26e>
 81a:	8b2a                	mv	s6,a0
 81c:	8a2e                	mv	s4,a1
 81e:	8bb2                	mv	s7,a2
  state = 0;
 820:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
 822:	4481                	li	s1,0
 824:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
 826:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
 82a:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
 82e:	06c00c93          	li	s9,108
 832:	a005                	j	852 <vprintf+0x5c>
        putc(fd, c0);
 834:	85ca                	mv	a1,s2
 836:	855a                	mv	a0,s6
 838:	ef9ff0ef          	jal	730 <putc>
 83c:	a019                	j	842 <vprintf+0x4c>
    } else if(state == '%'){
 83e:	03598263          	beq	s3,s5,862 <vprintf+0x6c>
  for(i = 0; fmt[i]; i++){
 842:	2485                	addw	s1,s1,1
 844:	8726                	mv	a4,s1
 846:	009a07b3          	add	a5,s4,s1
 84a:	0007c903          	lbu	s2,0(a5)
 84e:	20090b63          	beqz	s2,a64 <vprintf+0x26e>
    c0 = fmt[i] & 0xff;
 852:	0009079b          	sext.w	a5,s2
    if(state == 0){
 856:	fe0994e3          	bnez	s3,83e <vprintf+0x48>
      if(c0 == '%'){
 85a:	fd579de3          	bne	a5,s5,834 <vprintf+0x3e>
        state = '%';
 85e:	89be                	mv	s3,a5
 860:	b7cd                	j	842 <vprintf+0x4c>
      if(c0) c1 = fmt[i+1] & 0xff;
 862:	c7c9                	beqz	a5,8ec <vprintf+0xf6>
 864:	00ea06b3          	add	a3,s4,a4
 868:	0016c683          	lbu	a3,1(a3)
      c1 = c2 = 0;
 86c:	8636                	mv	a2,a3
      if(c1) c2 = fmt[i+2] & 0xff;
 86e:	c681                	beqz	a3,876 <vprintf+0x80>
 870:	9752                	add	a4,a4,s4
 872:	00274603          	lbu	a2,2(a4)
      if(c0 == 'd'){
 876:	03878f63          	beq	a5,s8,8b4 <vprintf+0xbe>
      } else if(c0 == 'l' && c1 == 'd'){
 87a:	05978963          	beq	a5,s9,8cc <vprintf+0xd6>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
 87e:	07500713          	li	a4,117
 882:	0ee78363          	beq	a5,a4,968 <vprintf+0x172>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
 886:	07800713          	li	a4,120
 88a:	12e78563          	beq	a5,a4,9b4 <vprintf+0x1be>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
 88e:	07000713          	li	a4,112
 892:	14e78a63          	beq	a5,a4,9e6 <vprintf+0x1f0>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 's'){
 896:	07300713          	li	a4,115
 89a:	18e78863          	beq	a5,a4,a2a <vprintf+0x234>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
 89e:	02500713          	li	a4,37
 8a2:	04e79563          	bne	a5,a4,8ec <vprintf+0xf6>
        putc(fd, '%');
 8a6:	02500593          	li	a1,37
 8aa:	855a                	mv	a0,s6
 8ac:	e85ff0ef          	jal	730 <putc>
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
#endif
      state = 0;
 8b0:	4981                	li	s3,0
 8b2:	bf41                	j	842 <vprintf+0x4c>
        printint(fd, va_arg(ap, int), 10, 1);
 8b4:	008b8913          	add	s2,s7,8
 8b8:	4685                	li	a3,1
 8ba:	4629                	li	a2,10
 8bc:	000ba583          	lw	a1,0(s7)
 8c0:	855a                	mv	a0,s6
 8c2:	e8dff0ef          	jal	74e <printint>
 8c6:	8bca                	mv	s7,s2
      state = 0;
 8c8:	4981                	li	s3,0
 8ca:	bfa5                	j	842 <vprintf+0x4c>
      } else if(c0 == 'l' && c1 == 'd'){
 8cc:	06400793          	li	a5,100
 8d0:	02f68963          	beq	a3,a5,902 <vprintf+0x10c>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 8d4:	06c00793          	li	a5,108
 8d8:	04f68263          	beq	a3,a5,91c <vprintf+0x126>
      } else if(c0 == 'l' && c1 == 'u'){
 8dc:	07500793          	li	a5,117
 8e0:	0af68063          	beq	a3,a5,980 <vprintf+0x18a>
      } else if(c0 == 'l' && c1 == 'x'){
 8e4:	07800793          	li	a5,120
 8e8:	0ef68263          	beq	a3,a5,9cc <vprintf+0x1d6>
        putc(fd, '%');
 8ec:	02500593          	li	a1,37
 8f0:	855a                	mv	a0,s6
 8f2:	e3fff0ef          	jal	730 <putc>
        putc(fd, c0);
 8f6:	85ca                	mv	a1,s2
 8f8:	855a                	mv	a0,s6
 8fa:	e37ff0ef          	jal	730 <putc>
      state = 0;
 8fe:	4981                	li	s3,0
 900:	b789                	j	842 <vprintf+0x4c>
        printint(fd, va_arg(ap, uint64), 10, 1);
 902:	008b8913          	add	s2,s7,8
 906:	4685                	li	a3,1
 908:	4629                	li	a2,10
 90a:	000bb583          	ld	a1,0(s7)
 90e:	855a                	mv	a0,s6
 910:	e3fff0ef          	jal	74e <printint>
        i += 1;
 914:	2485                	addw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 916:	8bca                	mv	s7,s2
      state = 0;
 918:	4981                	li	s3,0
        i += 1;
 91a:	b725                	j	842 <vprintf+0x4c>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 91c:	06400793          	li	a5,100
 920:	02f60763          	beq	a2,a5,94e <vprintf+0x158>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 924:	07500793          	li	a5,117
 928:	06f60963          	beq	a2,a5,99a <vprintf+0x1a4>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 92c:	07800793          	li	a5,120
 930:	faf61ee3          	bne	a2,a5,8ec <vprintf+0xf6>
        printint(fd, va_arg(ap, uint64), 16, 0);
 934:	008b8913          	add	s2,s7,8
 938:	4681                	li	a3,0
 93a:	4641                	li	a2,16
 93c:	000bb583          	ld	a1,0(s7)
 940:	855a                	mv	a0,s6
 942:	e0dff0ef          	jal	74e <printint>
        i += 2;
 946:	2489                	addw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 948:	8bca                	mv	s7,s2
      state = 0;
 94a:	4981                	li	s3,0
        i += 2;
 94c:	bddd                	j	842 <vprintf+0x4c>
        printint(fd, va_arg(ap, uint64), 10, 1);
 94e:	008b8913          	add	s2,s7,8
 952:	4685                	li	a3,1
 954:	4629                	li	a2,10
 956:	000bb583          	ld	a1,0(s7)
 95a:	855a                	mv	a0,s6
 95c:	df3ff0ef          	jal	74e <printint>
        i += 2;
 960:	2489                	addw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 962:	8bca                	mv	s7,s2
      state = 0;
 964:	4981                	li	s3,0
        i += 2;
 966:	bdf1                	j	842 <vprintf+0x4c>
        printint(fd, va_arg(ap, int), 10, 0);
 968:	008b8913          	add	s2,s7,8
 96c:	4681                	li	a3,0
 96e:	4629                	li	a2,10
 970:	000ba583          	lw	a1,0(s7)
 974:	855a                	mv	a0,s6
 976:	dd9ff0ef          	jal	74e <printint>
 97a:	8bca                	mv	s7,s2
      state = 0;
 97c:	4981                	li	s3,0
 97e:	b5d1                	j	842 <vprintf+0x4c>
        printint(fd, va_arg(ap, uint64), 10, 0);
 980:	008b8913          	add	s2,s7,8
 984:	4681                	li	a3,0
 986:	4629                	li	a2,10
 988:	000bb583          	ld	a1,0(s7)
 98c:	855a                	mv	a0,s6
 98e:	dc1ff0ef          	jal	74e <printint>
        i += 1;
 992:	2485                	addw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 994:	8bca                	mv	s7,s2
      state = 0;
 996:	4981                	li	s3,0
        i += 1;
 998:	b56d                	j	842 <vprintf+0x4c>
        printint(fd, va_arg(ap, uint64), 10, 0);
 99a:	008b8913          	add	s2,s7,8
 99e:	4681                	li	a3,0
 9a0:	4629                	li	a2,10
 9a2:	000bb583          	ld	a1,0(s7)
 9a6:	855a                	mv	a0,s6
 9a8:	da7ff0ef          	jal	74e <printint>
        i += 2;
 9ac:	2489                	addw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 9ae:	8bca                	mv	s7,s2
      state = 0;
 9b0:	4981                	li	s3,0
        i += 2;
 9b2:	bd41                	j	842 <vprintf+0x4c>
        printint(fd, va_arg(ap, int), 16, 0);
 9b4:	008b8913          	add	s2,s7,8
 9b8:	4681                	li	a3,0
 9ba:	4641                	li	a2,16
 9bc:	000ba583          	lw	a1,0(s7)
 9c0:	855a                	mv	a0,s6
 9c2:	d8dff0ef          	jal	74e <printint>
 9c6:	8bca                	mv	s7,s2
      state = 0;
 9c8:	4981                	li	s3,0
 9ca:	bda5                	j	842 <vprintf+0x4c>
        printint(fd, va_arg(ap, uint64), 16, 0);
 9cc:	008b8913          	add	s2,s7,8
 9d0:	4681                	li	a3,0
 9d2:	4641                	li	a2,16
 9d4:	000bb583          	ld	a1,0(s7)
 9d8:	855a                	mv	a0,s6
 9da:	d75ff0ef          	jal	74e <printint>
        i += 1;
 9de:	2485                	addw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 9e0:	8bca                	mv	s7,s2
      state = 0;
 9e2:	4981                	li	s3,0
        i += 1;
 9e4:	bdb9                	j	842 <vprintf+0x4c>
        printptr(fd, va_arg(ap, uint64));
 9e6:	008b8d13          	add	s10,s7,8
 9ea:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 9ee:	03000593          	li	a1,48
 9f2:	855a                	mv	a0,s6
 9f4:	d3dff0ef          	jal	730 <putc>
  putc(fd, 'x');
 9f8:	07800593          	li	a1,120
 9fc:	855a                	mv	a0,s6
 9fe:	d33ff0ef          	jal	730 <putc>
 a02:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 a04:	00000b97          	auipc	s7,0x0
 a08:	28cb8b93          	add	s7,s7,652 # c90 <digits>
 a0c:	03c9d793          	srl	a5,s3,0x3c
 a10:	97de                	add	a5,a5,s7
 a12:	0007c583          	lbu	a1,0(a5)
 a16:	855a                	mv	a0,s6
 a18:	d19ff0ef          	jal	730 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 a1c:	0992                	sll	s3,s3,0x4
 a1e:	397d                	addw	s2,s2,-1
 a20:	fe0916e3          	bnez	s2,a0c <vprintf+0x216>
        printptr(fd, va_arg(ap, uint64));
 a24:	8bea                	mv	s7,s10
      state = 0;
 a26:	4981                	li	s3,0
 a28:	bd29                	j	842 <vprintf+0x4c>
        if((s = va_arg(ap, char*)) == 0)
 a2a:	008b8993          	add	s3,s7,8
 a2e:	000bb903          	ld	s2,0(s7)
 a32:	00090f63          	beqz	s2,a50 <vprintf+0x25a>
        for(; *s; s++)
 a36:	00094583          	lbu	a1,0(s2)
 a3a:	c195                	beqz	a1,a5e <vprintf+0x268>
          putc(fd, *s);
 a3c:	855a                	mv	a0,s6
 a3e:	cf3ff0ef          	jal	730 <putc>
        for(; *s; s++)
 a42:	0905                	add	s2,s2,1
 a44:	00094583          	lbu	a1,0(s2)
 a48:	f9f5                	bnez	a1,a3c <vprintf+0x246>
        if((s = va_arg(ap, char*)) == 0)
 a4a:	8bce                	mv	s7,s3
      state = 0;
 a4c:	4981                	li	s3,0
 a4e:	bbd5                	j	842 <vprintf+0x4c>
          s = "(null)";
 a50:	00000917          	auipc	s2,0x0
 a54:	23890913          	add	s2,s2,568 # c88 <malloc+0x12a>
        for(; *s; s++)
 a58:	02800593          	li	a1,40
 a5c:	b7c5                	j	a3c <vprintf+0x246>
        if((s = va_arg(ap, char*)) == 0)
 a5e:	8bce                	mv	s7,s3
      state = 0;
 a60:	4981                	li	s3,0
 a62:	b3c5                	j	842 <vprintf+0x4c>
    }
  }
}
 a64:	60e6                	ld	ra,88(sp)
 a66:	6446                	ld	s0,80(sp)
 a68:	64a6                	ld	s1,72(sp)
 a6a:	6906                	ld	s2,64(sp)
 a6c:	79e2                	ld	s3,56(sp)
 a6e:	7a42                	ld	s4,48(sp)
 a70:	7aa2                	ld	s5,40(sp)
 a72:	7b02                	ld	s6,32(sp)
 a74:	6be2                	ld	s7,24(sp)
 a76:	6c42                	ld	s8,16(sp)
 a78:	6ca2                	ld	s9,8(sp)
 a7a:	6d02                	ld	s10,0(sp)
 a7c:	6125                	add	sp,sp,96
 a7e:	8082                	ret

0000000000000a80 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 a80:	715d                	add	sp,sp,-80
 a82:	ec06                	sd	ra,24(sp)
 a84:	e822                	sd	s0,16(sp)
 a86:	1000                	add	s0,sp,32
 a88:	e010                	sd	a2,0(s0)
 a8a:	e414                	sd	a3,8(s0)
 a8c:	e818                	sd	a4,16(s0)
 a8e:	ec1c                	sd	a5,24(s0)
 a90:	03043023          	sd	a6,32(s0)
 a94:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 a98:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 a9c:	8622                	mv	a2,s0
 a9e:	d59ff0ef          	jal	7f6 <vprintf>
}
 aa2:	60e2                	ld	ra,24(sp)
 aa4:	6442                	ld	s0,16(sp)
 aa6:	6161                	add	sp,sp,80
 aa8:	8082                	ret

0000000000000aaa <printf>:

void
printf(const char *fmt, ...)
{
 aaa:	711d                	add	sp,sp,-96
 aac:	ec06                	sd	ra,24(sp)
 aae:	e822                	sd	s0,16(sp)
 ab0:	1000                	add	s0,sp,32
 ab2:	e40c                	sd	a1,8(s0)
 ab4:	e810                	sd	a2,16(s0)
 ab6:	ec14                	sd	a3,24(s0)
 ab8:	f018                	sd	a4,32(s0)
 aba:	f41c                	sd	a5,40(s0)
 abc:	03043823          	sd	a6,48(s0)
 ac0:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 ac4:	00840613          	add	a2,s0,8
 ac8:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 acc:	85aa                	mv	a1,a0
 ace:	4505                	li	a0,1
 ad0:	d27ff0ef          	jal	7f6 <vprintf>
}
 ad4:	60e2                	ld	ra,24(sp)
 ad6:	6442                	ld	s0,16(sp)
 ad8:	6125                	add	sp,sp,96
 ada:	8082                	ret

0000000000000adc <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 adc:	1141                	add	sp,sp,-16
 ade:	e422                	sd	s0,8(sp)
 ae0:	0800                	add	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 ae2:	ff050693          	add	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 ae6:	00000797          	auipc	a5,0x0
 aea:	5227b783          	ld	a5,1314(a5) # 1008 <freep>
 aee:	a02d                	j	b18 <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 af0:	4618                	lw	a4,8(a2)
 af2:	9f2d                	addw	a4,a4,a1
 af4:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 af8:	6398                	ld	a4,0(a5)
 afa:	6310                	ld	a2,0(a4)
 afc:	a83d                	j	b3a <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 afe:	ff852703          	lw	a4,-8(a0)
 b02:	9f31                	addw	a4,a4,a2
 b04:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 b06:	ff053683          	ld	a3,-16(a0)
 b0a:	a091                	j	b4e <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 b0c:	6398                	ld	a4,0(a5)
 b0e:	00e7e463          	bltu	a5,a4,b16 <free+0x3a>
 b12:	00e6ea63          	bltu	a3,a4,b26 <free+0x4a>
{
 b16:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 b18:	fed7fae3          	bgeu	a5,a3,b0c <free+0x30>
 b1c:	6398                	ld	a4,0(a5)
 b1e:	00e6e463          	bltu	a3,a4,b26 <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 b22:	fee7eae3          	bltu	a5,a4,b16 <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 b26:	ff852583          	lw	a1,-8(a0)
 b2a:	6390                	ld	a2,0(a5)
 b2c:	02059813          	sll	a6,a1,0x20
 b30:	01c85713          	srl	a4,a6,0x1c
 b34:	9736                	add	a4,a4,a3
 b36:	fae60de3          	beq	a2,a4,af0 <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 b3a:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 b3e:	4790                	lw	a2,8(a5)
 b40:	02061593          	sll	a1,a2,0x20
 b44:	01c5d713          	srl	a4,a1,0x1c
 b48:	973e                	add	a4,a4,a5
 b4a:	fae68ae3          	beq	a3,a4,afe <free+0x22>
    p->s.ptr = bp->s.ptr;
 b4e:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 b50:	00000717          	auipc	a4,0x0
 b54:	4af73c23          	sd	a5,1208(a4) # 1008 <freep>
}
 b58:	6422                	ld	s0,8(sp)
 b5a:	0141                	add	sp,sp,16
 b5c:	8082                	ret

0000000000000b5e <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 b5e:	7139                	add	sp,sp,-64
 b60:	fc06                	sd	ra,56(sp)
 b62:	f822                	sd	s0,48(sp)
 b64:	f426                	sd	s1,40(sp)
 b66:	f04a                	sd	s2,32(sp)
 b68:	ec4e                	sd	s3,24(sp)
 b6a:	e852                	sd	s4,16(sp)
 b6c:	e456                	sd	s5,8(sp)
 b6e:	e05a                	sd	s6,0(sp)
 b70:	0080                	add	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 b72:	02051493          	sll	s1,a0,0x20
 b76:	9081                	srl	s1,s1,0x20
 b78:	04bd                	add	s1,s1,15
 b7a:	8091                	srl	s1,s1,0x4
 b7c:	0014899b          	addw	s3,s1,1
 b80:	0485                	add	s1,s1,1
  if((prevp = freep) == 0){
 b82:	00000517          	auipc	a0,0x0
 b86:	48653503          	ld	a0,1158(a0) # 1008 <freep>
 b8a:	c515                	beqz	a0,bb6 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 b8c:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 b8e:	4798                	lw	a4,8(a5)
 b90:	02977f63          	bgeu	a4,s1,bce <malloc+0x70>
  if(nu < 4096)
 b94:	8a4e                	mv	s4,s3
 b96:	0009871b          	sext.w	a4,s3
 b9a:	6685                	lui	a3,0x1
 b9c:	00d77363          	bgeu	a4,a3,ba2 <malloc+0x44>
 ba0:	6a05                	lui	s4,0x1
 ba2:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 ba6:	004a1a1b          	sllw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 baa:	00000917          	auipc	s2,0x0
 bae:	45e90913          	add	s2,s2,1118 # 1008 <freep>
  if(p == (char*)-1)
 bb2:	5afd                	li	s5,-1
 bb4:	a885                	j	c24 <malloc+0xc6>
    base.s.ptr = freep = prevp = &base;
 bb6:	00000797          	auipc	a5,0x0
 bba:	65a78793          	add	a5,a5,1626 # 1210 <base>
 bbe:	00000717          	auipc	a4,0x0
 bc2:	44f73523          	sd	a5,1098(a4) # 1008 <freep>
 bc6:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 bc8:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 bcc:	b7e1                	j	b94 <malloc+0x36>
      if(p->s.size == nunits)
 bce:	02e48c63          	beq	s1,a4,c06 <malloc+0xa8>
        p->s.size -= nunits;
 bd2:	4137073b          	subw	a4,a4,s3
 bd6:	c798                	sw	a4,8(a5)
        p += p->s.size;
 bd8:	02071693          	sll	a3,a4,0x20
 bdc:	01c6d713          	srl	a4,a3,0x1c
 be0:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 be2:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 be6:	00000717          	auipc	a4,0x0
 bea:	42a73123          	sd	a0,1058(a4) # 1008 <freep>
      return (void*)(p + 1);
 bee:	01078513          	add	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 bf2:	70e2                	ld	ra,56(sp)
 bf4:	7442                	ld	s0,48(sp)
 bf6:	74a2                	ld	s1,40(sp)
 bf8:	7902                	ld	s2,32(sp)
 bfa:	69e2                	ld	s3,24(sp)
 bfc:	6a42                	ld	s4,16(sp)
 bfe:	6aa2                	ld	s5,8(sp)
 c00:	6b02                	ld	s6,0(sp)
 c02:	6121                	add	sp,sp,64
 c04:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 c06:	6398                	ld	a4,0(a5)
 c08:	e118                	sd	a4,0(a0)
 c0a:	bff1                	j	be6 <malloc+0x88>
  hp->s.size = nu;
 c0c:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 c10:	0541                	add	a0,a0,16
 c12:	ecbff0ef          	jal	adc <free>
  return freep;
 c16:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 c1a:	dd61                	beqz	a0,bf2 <malloc+0x94>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 c1c:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 c1e:	4798                	lw	a4,8(a5)
 c20:	fa9777e3          	bgeu	a4,s1,bce <malloc+0x70>
    if(p == freep)
 c24:	00093703          	ld	a4,0(s2)
 c28:	853e                	mv	a0,a5
 c2a:	fef719e3          	bne	a4,a5,c1c <malloc+0xbe>
  p = sbrk(nu * sizeof(Header));
 c2e:	8552                	mv	a0,s4
 c30:	a99ff0ef          	jal	6c8 <sbrk>
  if(p == (char*)-1)
 c34:	fd551ce3          	bne	a0,s5,c0c <malloc+0xae>
        return 0;
 c38:	4501                	li	a0,0
 c3a:	bf65                	j	bf2 <malloc+0x94>
