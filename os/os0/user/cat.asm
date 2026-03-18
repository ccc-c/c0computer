
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
  20:	4b0000ef          	jal	4d0 <read>
  24:	84aa                	mv	s1,a0
  26:	02a05363          	blez	a0,4c <cat+0x4c>
    if (write(1, buf, n) != n) {
  2a:	8626                	mv	a2,s1
  2c:	85ca                	mv	a1,s2
  2e:	4505                	li	a0,1
  30:	4a8000ef          	jal	4d8 <write>
  34:	fe9502e3          	beq	a0,s1,18 <cat+0x18>
      fprintf(2, "cat: write error\n");
  38:	00001597          	auipc	a1,0x1
  3c:	aa858593          	add	a1,a1,-1368 # ae0 <malloc+0x104>
  40:	4509                	li	a0,2
  42:	0bd000ef          	jal	8fe <fprintf>
      exit(1);
  46:	4505                	li	a0,1
  48:	470000ef          	jal	4b8 <exit>
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
  62:	a9a58593          	add	a1,a1,-1382 # af8 <malloc+0x11c>
  66:	4509                	li	a0,2
  68:	097000ef          	jal	8fe <fprintf>
    exit(1);
  6c:	4505                	li	a0,1
  6e:	44a000ef          	jal	4b8 <exit>

0000000000000072 <main>:

int
main(int argc, char *argv[])
{
  72:	7179                	add	sp,sp,-48
  74:	f406                	sd	ra,40(sp)
  76:	f022                	sd	s0,32(sp)
  78:	1800                	add	s0,sp,48
  int fd, i;

  if(argc <= 1){
  7a:	4785                	li	a5,1
  7c:	04a7d263          	bge	a5,a0,c0 <main+0x4e>
  80:	ec26                	sd	s1,24(sp)
  82:	e84a                	sd	s2,16(sp)
  84:	e44e                	sd	s3,8(sp)
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
  a0:	458000ef          	jal	4f8 <open>
  a4:	84aa                	mv	s1,a0
  a6:	02054663          	bltz	a0,d2 <main+0x60>
      fprintf(2, "cat: cannot open %s\n", argv[i]);
      exit(1);
    }
    cat(fd);
  aa:	f57ff0ef          	jal	0 <cat>
    close(fd);
  ae:	8526                	mv	a0,s1
  b0:	430000ef          	jal	4e0 <close>
  for(i = 1; i < argc; i++){
  b4:	0921                	add	s2,s2,8
  b6:	ff3912e3          	bne	s2,s3,9a <main+0x28>
  }
  exit(0);
  ba:	4501                	li	a0,0
  bc:	3fc000ef          	jal	4b8 <exit>
  c0:	ec26                	sd	s1,24(sp)
  c2:	e84a                	sd	s2,16(sp)
  c4:	e44e                	sd	s3,8(sp)
    cat(0);
  c6:	4501                	li	a0,0
  c8:	f39ff0ef          	jal	0 <cat>
    exit(0);
  cc:	4501                	li	a0,0
  ce:	3ea000ef          	jal	4b8 <exit>
      fprintf(2, "cat: cannot open %s\n", argv[i]);
  d2:	00093603          	ld	a2,0(s2)
  d6:	00001597          	auipc	a1,0x1
  da:	a3a58593          	add	a1,a1,-1478 # b10 <malloc+0x134>
  de:	4509                	li	a0,2
  e0:	01f000ef          	jal	8fe <fprintf>
      exit(1);
  e4:	4505                	li	a0,1
  e6:	3d2000ef          	jal	4b8 <exit>

00000000000000ea <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start(int argc, char **argv)
{
  ea:	1141                	add	sp,sp,-16
  ec:	e406                	sd	ra,8(sp)
  ee:	e022                	sd	s0,0(sp)
  f0:	0800                	add	s0,sp,16
  int r;
  extern int main(int argc, char **argv);
  r = main(argc, argv);
  f2:	f81ff0ef          	jal	72 <main>
  exit(r);
  f6:	3c2000ef          	jal	4b8 <exit>

00000000000000fa <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
  fa:	1141                	add	sp,sp,-16
  fc:	e422                	sd	s0,8(sp)
  fe:	0800                	add	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 100:	87aa                	mv	a5,a0
 102:	0585                	add	a1,a1,1
 104:	0785                	add	a5,a5,1
 106:	fff5c703          	lbu	a4,-1(a1)
 10a:	fee78fa3          	sb	a4,-1(a5)
 10e:	fb75                	bnez	a4,102 <strcpy+0x8>
    ;
  return os;
}
 110:	6422                	ld	s0,8(sp)
 112:	0141                	add	sp,sp,16
 114:	8082                	ret

0000000000000116 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 116:	1141                	add	sp,sp,-16
 118:	e422                	sd	s0,8(sp)
 11a:	0800                	add	s0,sp,16
  while(*p && *p == *q)
 11c:	00054783          	lbu	a5,0(a0)
 120:	cb91                	beqz	a5,134 <strcmp+0x1e>
 122:	0005c703          	lbu	a4,0(a1)
 126:	00f71763          	bne	a4,a5,134 <strcmp+0x1e>
    p++, q++;
 12a:	0505                	add	a0,a0,1
 12c:	0585                	add	a1,a1,1
  while(*p && *p == *q)
 12e:	00054783          	lbu	a5,0(a0)
 132:	fbe5                	bnez	a5,122 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 134:	0005c503          	lbu	a0,0(a1)
}
 138:	40a7853b          	subw	a0,a5,a0
 13c:	6422                	ld	s0,8(sp)
 13e:	0141                	add	sp,sp,16
 140:	8082                	ret

0000000000000142 <strncmp>:

int
strncmp(const char *p, const char *q, uint n)
{
 142:	1141                	add	sp,sp,-16
 144:	e422                	sd	s0,8(sp)
 146:	0800                	add	s0,sp,16
  while(n > 0 && *p && *p == *q) {
 148:	ce11                	beqz	a2,164 <strncmp+0x22>
 14a:	00054783          	lbu	a5,0(a0)
 14e:	cf89                	beqz	a5,168 <strncmp+0x26>
 150:	0005c703          	lbu	a4,0(a1)
 154:	00f71a63          	bne	a4,a5,168 <strncmp+0x26>
    p++, q++, n--;
 158:	0505                	add	a0,a0,1
 15a:	0585                	add	a1,a1,1
 15c:	367d                	addw	a2,a2,-1
  while(n > 0 && *p && *p == *q) {
 15e:	f675                	bnez	a2,14a <strncmp+0x8>
  }
  if (n == 0)
    return 0;
 160:	4501                	li	a0,0
 162:	a801                	j	172 <strncmp+0x30>
 164:	4501                	li	a0,0
 166:	a031                	j	172 <strncmp+0x30>
  return (uchar)*p - (uchar)*q;
 168:	00054503          	lbu	a0,0(a0)
 16c:	0005c783          	lbu	a5,0(a1)
 170:	9d1d                	subw	a0,a0,a5
}
 172:	6422                	ld	s0,8(sp)
 174:	0141                	add	sp,sp,16
 176:	8082                	ret

0000000000000178 <strcat>:

char*
strcat(char *dst, const char *src)
{
 178:	1141                	add	sp,sp,-16
 17a:	e422                	sd	s0,8(sp)
 17c:	0800                	add	s0,sp,16
  char *p = dst;
  while(*p) p++;
 17e:	00054783          	lbu	a5,0(a0)
 182:	c385                	beqz	a5,1a2 <strcat+0x2a>
  char *p = dst;
 184:	87aa                	mv	a5,a0
  while(*p) p++;
 186:	0785                	add	a5,a5,1
 188:	0007c703          	lbu	a4,0(a5)
 18c:	ff6d                	bnez	a4,186 <strcat+0xe>
  while((*p++ = *src++) != 0);
 18e:	0585                	add	a1,a1,1
 190:	0785                	add	a5,a5,1
 192:	fff5c703          	lbu	a4,-1(a1)
 196:	fee78fa3          	sb	a4,-1(a5)
 19a:	fb75                	bnez	a4,18e <strcat+0x16>
  return dst;
}
 19c:	6422                	ld	s0,8(sp)
 19e:	0141                	add	sp,sp,16
 1a0:	8082                	ret
  char *p = dst;
 1a2:	87aa                	mv	a5,a0
 1a4:	b7ed                	j	18e <strcat+0x16>

00000000000001a6 <strncpy>:

char*
strncpy(char *dst, const char *src, int n)
{
 1a6:	1141                	add	sp,sp,-16
 1a8:	e422                	sd	s0,8(sp)
 1aa:	0800                	add	s0,sp,16
  char *p = dst;
 1ac:	87aa                	mv	a5,a0
  while(n > 0 && *src) {
 1ae:	02c05463          	blez	a2,1d6 <strncpy+0x30>
 1b2:	0005c703          	lbu	a4,0(a1)
 1b6:	cb01                	beqz	a4,1c6 <strncpy+0x20>
    *p++ = *src++;
 1b8:	0585                	add	a1,a1,1
 1ba:	0785                	add	a5,a5,1
 1bc:	fee78fa3          	sb	a4,-1(a5)
    n--;
 1c0:	367d                	addw	a2,a2,-1
  while(n > 0 && *src) {
 1c2:	fa65                	bnez	a2,1b2 <strncpy+0xc>
 1c4:	a809                	j	1d6 <strncpy+0x30>
  }
  while(n > 0) {
 1c6:	1602                	sll	a2,a2,0x20
 1c8:	9201                	srl	a2,a2,0x20
 1ca:	963e                	add	a2,a2,a5
    *p++ = 0;
 1cc:	0785                	add	a5,a5,1
 1ce:	fe078fa3          	sb	zero,-1(a5)
  while(n > 0) {
 1d2:	fec79de3          	bne	a5,a2,1cc <strncpy+0x26>
    n--;
  }
  return dst;
}
 1d6:	6422                	ld	s0,8(sp)
 1d8:	0141                	add	sp,sp,16
 1da:	8082                	ret

00000000000001dc <strlen>:

uint
strlen(const char *s)
{
 1dc:	1141                	add	sp,sp,-16
 1de:	e422                	sd	s0,8(sp)
 1e0:	0800                	add	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 1e2:	00054783          	lbu	a5,0(a0)
 1e6:	cf91                	beqz	a5,202 <strlen+0x26>
 1e8:	0505                	add	a0,a0,1
 1ea:	87aa                	mv	a5,a0
 1ec:	86be                	mv	a3,a5
 1ee:	0785                	add	a5,a5,1
 1f0:	fff7c703          	lbu	a4,-1(a5)
 1f4:	ff65                	bnez	a4,1ec <strlen+0x10>
 1f6:	40a6853b          	subw	a0,a3,a0
 1fa:	2505                	addw	a0,a0,1
    ;
  return n;
}
 1fc:	6422                	ld	s0,8(sp)
 1fe:	0141                	add	sp,sp,16
 200:	8082                	ret
  for(n = 0; s[n]; n++)
 202:	4501                	li	a0,0
 204:	bfe5                	j	1fc <strlen+0x20>

0000000000000206 <memset>:

void*
memset(void *dst, int c, uint n)
{
 206:	1141                	add	sp,sp,-16
 208:	e422                	sd	s0,8(sp)
 20a:	0800                	add	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 20c:	ca19                	beqz	a2,222 <memset+0x1c>
 20e:	87aa                	mv	a5,a0
 210:	1602                	sll	a2,a2,0x20
 212:	9201                	srl	a2,a2,0x20
 214:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 218:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 21c:	0785                	add	a5,a5,1
 21e:	fee79de3          	bne	a5,a4,218 <memset+0x12>
  }
  return dst;
}
 222:	6422                	ld	s0,8(sp)
 224:	0141                	add	sp,sp,16
 226:	8082                	ret

0000000000000228 <strchr>:

char*
strchr(const char *s, char c)
{
 228:	1141                	add	sp,sp,-16
 22a:	e422                	sd	s0,8(sp)
 22c:	0800                	add	s0,sp,16
  for(; *s; s++)
 22e:	00054783          	lbu	a5,0(a0)
 232:	cb99                	beqz	a5,248 <strchr+0x20>
    if(*s == c)
 234:	00f58763          	beq	a1,a5,242 <strchr+0x1a>
  for(; *s; s++)
 238:	0505                	add	a0,a0,1
 23a:	00054783          	lbu	a5,0(a0)
 23e:	fbfd                	bnez	a5,234 <strchr+0xc>
      return (char*)s;
  return 0;
 240:	4501                	li	a0,0
}
 242:	6422                	ld	s0,8(sp)
 244:	0141                	add	sp,sp,16
 246:	8082                	ret
  return 0;
 248:	4501                	li	a0,0
 24a:	bfe5                	j	242 <strchr+0x1a>

000000000000024c <gets>:

char*
gets(char *buf, int max)
{
 24c:	711d                	add	sp,sp,-96
 24e:	ec86                	sd	ra,88(sp)
 250:	e8a2                	sd	s0,80(sp)
 252:	e4a6                	sd	s1,72(sp)
 254:	e0ca                	sd	s2,64(sp)
 256:	fc4e                	sd	s3,56(sp)
 258:	f852                	sd	s4,48(sp)
 25a:	f456                	sd	s5,40(sp)
 25c:	f05a                	sd	s6,32(sp)
 25e:	ec5e                	sd	s7,24(sp)
 260:	1080                	add	s0,sp,96
 262:	8baa                	mv	s7,a0
 264:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 266:	892a                	mv	s2,a0
 268:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 26a:	4aa9                	li	s5,10
 26c:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 26e:	89a6                	mv	s3,s1
 270:	2485                	addw	s1,s1,1
 272:	0344d663          	bge	s1,s4,29e <gets+0x52>
    cc = read(0, &c, 1);
 276:	4605                	li	a2,1
 278:	faf40593          	add	a1,s0,-81
 27c:	4501                	li	a0,0
 27e:	252000ef          	jal	4d0 <read>
    if(cc < 1)
 282:	00a05e63          	blez	a0,29e <gets+0x52>
    buf[i++] = c;
 286:	faf44783          	lbu	a5,-81(s0)
 28a:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 28e:	01578763          	beq	a5,s5,29c <gets+0x50>
 292:	0905                	add	s2,s2,1
 294:	fd679de3          	bne	a5,s6,26e <gets+0x22>
    buf[i++] = c;
 298:	89a6                	mv	s3,s1
 29a:	a011                	j	29e <gets+0x52>
 29c:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 29e:	99de                	add	s3,s3,s7
 2a0:	00098023          	sb	zero,0(s3)
  return buf;
}
 2a4:	855e                	mv	a0,s7
 2a6:	60e6                	ld	ra,88(sp)
 2a8:	6446                	ld	s0,80(sp)
 2aa:	64a6                	ld	s1,72(sp)
 2ac:	6906                	ld	s2,64(sp)
 2ae:	79e2                	ld	s3,56(sp)
 2b0:	7a42                	ld	s4,48(sp)
 2b2:	7aa2                	ld	s5,40(sp)
 2b4:	7b02                	ld	s6,32(sp)
 2b6:	6be2                	ld	s7,24(sp)
 2b8:	6125                	add	sp,sp,96
 2ba:	8082                	ret

00000000000002bc <stat>:

int
stat(const char *n, struct stat *st)
{
 2bc:	1101                	add	sp,sp,-32
 2be:	ec06                	sd	ra,24(sp)
 2c0:	e822                	sd	s0,16(sp)
 2c2:	e04a                	sd	s2,0(sp)
 2c4:	1000                	add	s0,sp,32
 2c6:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 2c8:	4581                	li	a1,0
 2ca:	22e000ef          	jal	4f8 <open>
  if(fd < 0)
 2ce:	02054263          	bltz	a0,2f2 <stat+0x36>
 2d2:	e426                	sd	s1,8(sp)
 2d4:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 2d6:	85ca                	mv	a1,s2
 2d8:	238000ef          	jal	510 <fstat>
 2dc:	892a                	mv	s2,a0
  close(fd);
 2de:	8526                	mv	a0,s1
 2e0:	200000ef          	jal	4e0 <close>
  return r;
 2e4:	64a2                	ld	s1,8(sp)
}
 2e6:	854a                	mv	a0,s2
 2e8:	60e2                	ld	ra,24(sp)
 2ea:	6442                	ld	s0,16(sp)
 2ec:	6902                	ld	s2,0(sp)
 2ee:	6105                	add	sp,sp,32
 2f0:	8082                	ret
    return -1;
 2f2:	597d                	li	s2,-1
 2f4:	bfcd                	j	2e6 <stat+0x2a>

00000000000002f6 <atoi>:

int
atoi(const char *s)
{
 2f6:	1141                	add	sp,sp,-16
 2f8:	e422                	sd	s0,8(sp)
 2fa:	0800                	add	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 2fc:	00054683          	lbu	a3,0(a0)
 300:	fd06879b          	addw	a5,a3,-48
 304:	0ff7f793          	zext.b	a5,a5
 308:	4625                	li	a2,9
 30a:	02f66863          	bltu	a2,a5,33a <atoi+0x44>
 30e:	872a                	mv	a4,a0
  n = 0;
 310:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 312:	0705                	add	a4,a4,1
 314:	0025179b          	sllw	a5,a0,0x2
 318:	9fa9                	addw	a5,a5,a0
 31a:	0017979b          	sllw	a5,a5,0x1
 31e:	9fb5                	addw	a5,a5,a3
 320:	fd07851b          	addw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 324:	00074683          	lbu	a3,0(a4)
 328:	fd06879b          	addw	a5,a3,-48
 32c:	0ff7f793          	zext.b	a5,a5
 330:	fef671e3          	bgeu	a2,a5,312 <atoi+0x1c>
  return n;
}
 334:	6422                	ld	s0,8(sp)
 336:	0141                	add	sp,sp,16
 338:	8082                	ret
  n = 0;
 33a:	4501                	li	a0,0
 33c:	bfe5                	j	334 <atoi+0x3e>

000000000000033e <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 33e:	1141                	add	sp,sp,-16
 340:	e422                	sd	s0,8(sp)
 342:	0800                	add	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 344:	02b57463          	bgeu	a0,a1,36c <memmove+0x2e>
    while(n-- > 0)
 348:	00c05f63          	blez	a2,366 <memmove+0x28>
 34c:	1602                	sll	a2,a2,0x20
 34e:	9201                	srl	a2,a2,0x20
 350:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 354:	872a                	mv	a4,a0
      *dst++ = *src++;
 356:	0585                	add	a1,a1,1
 358:	0705                	add	a4,a4,1
 35a:	fff5c683          	lbu	a3,-1(a1)
 35e:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 362:	fef71ae3          	bne	a4,a5,356 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 366:	6422                	ld	s0,8(sp)
 368:	0141                	add	sp,sp,16
 36a:	8082                	ret
    dst += n;
 36c:	00c50733          	add	a4,a0,a2
    src += n;
 370:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 372:	fec05ae3          	blez	a2,366 <memmove+0x28>
 376:	fff6079b          	addw	a5,a2,-1
 37a:	1782                	sll	a5,a5,0x20
 37c:	9381                	srl	a5,a5,0x20
 37e:	fff7c793          	not	a5,a5
 382:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 384:	15fd                	add	a1,a1,-1
 386:	177d                	add	a4,a4,-1
 388:	0005c683          	lbu	a3,0(a1)
 38c:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 390:	fee79ae3          	bne	a5,a4,384 <memmove+0x46>
 394:	bfc9                	j	366 <memmove+0x28>

0000000000000396 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 396:	1141                	add	sp,sp,-16
 398:	e422                	sd	s0,8(sp)
 39a:	0800                	add	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 39c:	ca05                	beqz	a2,3cc <memcmp+0x36>
 39e:	fff6069b          	addw	a3,a2,-1
 3a2:	1682                	sll	a3,a3,0x20
 3a4:	9281                	srl	a3,a3,0x20
 3a6:	0685                	add	a3,a3,1
 3a8:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 3aa:	00054783          	lbu	a5,0(a0)
 3ae:	0005c703          	lbu	a4,0(a1)
 3b2:	00e79863          	bne	a5,a4,3c2 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 3b6:	0505                	add	a0,a0,1
    p2++;
 3b8:	0585                	add	a1,a1,1
  while (n-- > 0) {
 3ba:	fed518e3          	bne	a0,a3,3aa <memcmp+0x14>
  }
  return 0;
 3be:	4501                	li	a0,0
 3c0:	a019                	j	3c6 <memcmp+0x30>
      return *p1 - *p2;
 3c2:	40e7853b          	subw	a0,a5,a4
}
 3c6:	6422                	ld	s0,8(sp)
 3c8:	0141                	add	sp,sp,16
 3ca:	8082                	ret
  return 0;
 3cc:	4501                	li	a0,0
 3ce:	bfe5                	j	3c6 <memcmp+0x30>

00000000000003d0 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 3d0:	1141                	add	sp,sp,-16
 3d2:	e406                	sd	ra,8(sp)
 3d4:	e022                	sd	s0,0(sp)
 3d6:	0800                	add	s0,sp,16
  return memmove(dst, src, n);
 3d8:	f67ff0ef          	jal	33e <memmove>
}
 3dc:	60a2                	ld	ra,8(sp)
 3de:	6402                	ld	s0,0(sp)
 3e0:	0141                	add	sp,sp,16
 3e2:	8082                	ret

00000000000003e4 <sbrk>:

char *
sbrk(int n) {
 3e4:	1141                	add	sp,sp,-16
 3e6:	e406                	sd	ra,8(sp)
 3e8:	e022                	sd	s0,0(sp)
 3ea:	0800                	add	s0,sp,16
  return sys_sbrk(n, SBRK_EAGER);
 3ec:	4585                	li	a1,1
 3ee:	152000ef          	jal	540 <sys_sbrk>
}
 3f2:	60a2                	ld	ra,8(sp)
 3f4:	6402                	ld	s0,0(sp)
 3f6:	0141                	add	sp,sp,16
 3f8:	8082                	ret

00000000000003fa <sbrklazy>:

char *
sbrklazy(int n) {
 3fa:	1141                	add	sp,sp,-16
 3fc:	e406                	sd	ra,8(sp)
 3fe:	e022                	sd	s0,0(sp)
 400:	0800                	add	s0,sp,16
  return sys_sbrk(n, SBRK_LAZY);
 402:	4589                	li	a1,2
 404:	13c000ef          	jal	540 <sys_sbrk>
}
 408:	60a2                	ld	ra,8(sp)
 40a:	6402                	ld	s0,0(sp)
 40c:	0141                	add	sp,sp,16
 40e:	8082                	ret

0000000000000410 <htons>:

// Byte order conversion functions
unsigned short
htons(unsigned short hostshort)
{
 410:	1141                	add	sp,sp,-16
 412:	e422                	sd	s0,8(sp)
 414:	0800                	add	s0,sp,16
  return ((hostshort >> 8) & 0xff) | ((hostshort & 0xff) << 8);
 416:	0085179b          	sllw	a5,a0,0x8
 41a:	0085551b          	srlw	a0,a0,0x8
 41e:	8d5d                	or	a0,a0,a5
}
 420:	1542                	sll	a0,a0,0x30
 422:	9141                	srl	a0,a0,0x30
 424:	6422                	ld	s0,8(sp)
 426:	0141                	add	sp,sp,16
 428:	8082                	ret

000000000000042a <ntohs>:

unsigned short
ntohs(unsigned short netshort)
{
 42a:	1141                	add	sp,sp,-16
 42c:	e422                	sd	s0,8(sp)
 42e:	0800                	add	s0,sp,16
  return ((netshort >> 8) & 0xff) | ((netshort & 0xff) << 8);
 430:	0085179b          	sllw	a5,a0,0x8
 434:	0085551b          	srlw	a0,a0,0x8
 438:	8d5d                	or	a0,a0,a5
}
 43a:	1542                	sll	a0,a0,0x30
 43c:	9141                	srl	a0,a0,0x30
 43e:	6422                	ld	s0,8(sp)
 440:	0141                	add	sp,sp,16
 442:	8082                	ret

0000000000000444 <htonl>:

unsigned long
htonl(unsigned long hostlong)
{
 444:	1141                	add	sp,sp,-16
 446:	e422                	sd	s0,8(sp)
 448:	0800                	add	s0,sp,16
  return ((hostlong >> 24) & 0xff) |
 44a:	0185579b          	srlw	a5,a0,0x18
         ((hostlong >> 8) & 0xff00) |
 44e:	00855713          	srl	a4,a0,0x8
 452:	66c1                	lui	a3,0x10
 454:	f0068693          	add	a3,a3,-256 # ff00 <base+0xecf0>
 458:	8f75                	and	a4,a4,a3
  return ((hostlong >> 24) & 0xff) |
 45a:	8fd9                	or	a5,a5,a4
         ((hostlong & 0xff00) << 8) |
 45c:	00851713          	sll	a4,a0,0x8
 460:	00ff06b7          	lui	a3,0xff0
 464:	8f75                	and	a4,a4,a3
         ((hostlong >> 8) & 0xff00) |
 466:	8fd9                	or	a5,a5,a4
         ((hostlong & 0xff) << 24);
 468:	0562                	sll	a0,a0,0x18
 46a:	0ff00713          	li	a4,255
 46e:	0762                	sll	a4,a4,0x18
 470:	8d79                	and	a0,a0,a4
}
 472:	8d5d                	or	a0,a0,a5
 474:	6422                	ld	s0,8(sp)
 476:	0141                	add	sp,sp,16
 478:	8082                	ret

000000000000047a <ntohl>:

unsigned long
ntohl(unsigned long netlong)
{
 47a:	1141                	add	sp,sp,-16
 47c:	e422                	sd	s0,8(sp)
 47e:	0800                	add	s0,sp,16
  return ((netlong >> 24) & 0xff) |
 480:	0185579b          	srlw	a5,a0,0x18
         ((netlong >> 8) & 0xff00) |
 484:	00855713          	srl	a4,a0,0x8
 488:	66c1                	lui	a3,0x10
 48a:	f0068693          	add	a3,a3,-256 # ff00 <base+0xecf0>
 48e:	8f75                	and	a4,a4,a3
  return ((netlong >> 24) & 0xff) |
 490:	8fd9                	or	a5,a5,a4
         ((netlong & 0xff00) << 8) |
 492:	00851713          	sll	a4,a0,0x8
 496:	00ff06b7          	lui	a3,0xff0
 49a:	8f75                	and	a4,a4,a3
         ((netlong >> 8) & 0xff00) |
 49c:	8fd9                	or	a5,a5,a4
         ((netlong & 0xff) << 24);
 49e:	0562                	sll	a0,a0,0x18
 4a0:	0ff00713          	li	a4,255
 4a4:	0762                	sll	a4,a4,0x18
 4a6:	8d79                	and	a0,a0,a4
}
 4a8:	8d5d                	or	a0,a0,a5
 4aa:	6422                	ld	s0,8(sp)
 4ac:	0141                	add	sp,sp,16
 4ae:	8082                	ret

00000000000004b0 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 4b0:	4885                	li	a7,1
 ecall
 4b2:	00000073          	ecall
 ret
 4b6:	8082                	ret

00000000000004b8 <exit>:
.global exit
exit:
 li a7, SYS_exit
 4b8:	4889                	li	a7,2
 ecall
 4ba:	00000073          	ecall
 ret
 4be:	8082                	ret

00000000000004c0 <wait>:
.global wait
wait:
 li a7, SYS_wait
 4c0:	488d                	li	a7,3
 ecall
 4c2:	00000073          	ecall
 ret
 4c6:	8082                	ret

00000000000004c8 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 4c8:	4891                	li	a7,4
 ecall
 4ca:	00000073          	ecall
 ret
 4ce:	8082                	ret

00000000000004d0 <read>:
.global read
read:
 li a7, SYS_read
 4d0:	4895                	li	a7,5
 ecall
 4d2:	00000073          	ecall
 ret
 4d6:	8082                	ret

00000000000004d8 <write>:
.global write
write:
 li a7, SYS_write
 4d8:	48c1                	li	a7,16
 ecall
 4da:	00000073          	ecall
 ret
 4de:	8082                	ret

00000000000004e0 <close>:
.global close
close:
 li a7, SYS_close
 4e0:	48d5                	li	a7,21
 ecall
 4e2:	00000073          	ecall
 ret
 4e6:	8082                	ret

00000000000004e8 <kill>:
.global kill
kill:
 li a7, SYS_kill
 4e8:	4899                	li	a7,6
 ecall
 4ea:	00000073          	ecall
 ret
 4ee:	8082                	ret

00000000000004f0 <exec>:
.global exec
exec:
 li a7, SYS_exec
 4f0:	489d                	li	a7,7
 ecall
 4f2:	00000073          	ecall
 ret
 4f6:	8082                	ret

00000000000004f8 <open>:
.global open
open:
 li a7, SYS_open
 4f8:	48bd                	li	a7,15
 ecall
 4fa:	00000073          	ecall
 ret
 4fe:	8082                	ret

0000000000000500 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 500:	48c5                	li	a7,17
 ecall
 502:	00000073          	ecall
 ret
 506:	8082                	ret

0000000000000508 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 508:	48c9                	li	a7,18
 ecall
 50a:	00000073          	ecall
 ret
 50e:	8082                	ret

0000000000000510 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 510:	48a1                	li	a7,8
 ecall
 512:	00000073          	ecall
 ret
 516:	8082                	ret

0000000000000518 <link>:
.global link
link:
 li a7, SYS_link
 518:	48cd                	li	a7,19
 ecall
 51a:	00000073          	ecall
 ret
 51e:	8082                	ret

0000000000000520 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 520:	48d1                	li	a7,20
 ecall
 522:	00000073          	ecall
 ret
 526:	8082                	ret

0000000000000528 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 528:	48a5                	li	a7,9
 ecall
 52a:	00000073          	ecall
 ret
 52e:	8082                	ret

0000000000000530 <dup>:
.global dup
dup:
 li a7, SYS_dup
 530:	48a9                	li	a7,10
 ecall
 532:	00000073          	ecall
 ret
 536:	8082                	ret

0000000000000538 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 538:	48ad                	li	a7,11
 ecall
 53a:	00000073          	ecall
 ret
 53e:	8082                	ret

0000000000000540 <sys_sbrk>:
.global sys_sbrk
sys_sbrk:
 li a7, SYS_sbrk
 540:	48b1                	li	a7,12
 ecall
 542:	00000073          	ecall
 ret
 546:	8082                	ret

0000000000000548 <pause>:
.global pause
pause:
 li a7, SYS_pause
 548:	48b5                	li	a7,13
 ecall
 54a:	00000073          	ecall
 ret
 54e:	8082                	ret

0000000000000550 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 550:	48b9                	li	a7,14
 ecall
 552:	00000073          	ecall
 ret
 556:	8082                	ret

0000000000000558 <socket>:
.global socket
socket:
 li a7, SYS_socket
 558:	48d9                	li	a7,22
 ecall
 55a:	00000073          	ecall
 ret
 55e:	8082                	ret

0000000000000560 <bind>:
.global bind
bind:
 li a7, SYS_bind
 560:	48dd                	li	a7,23
 ecall
 562:	00000073          	ecall
 ret
 566:	8082                	ret

0000000000000568 <listen>:
.global listen
listen:
 li a7, SYS_listen
 568:	48e1                	li	a7,24
 ecall
 56a:	00000073          	ecall
 ret
 56e:	8082                	ret

0000000000000570 <accept>:
.global accept
accept:
 li a7, SYS_accept
 570:	48e5                	li	a7,25
 ecall
 572:	00000073          	ecall
 ret
 576:	8082                	ret

0000000000000578 <connect>:
.global connect
connect:
 li a7, SYS_connect
 578:	48e9                	li	a7,26
 ecall
 57a:	00000073          	ecall
 ret
 57e:	8082                	ret

0000000000000580 <send>:
.global send
send:
 li a7, SYS_send
 580:	48ed                	li	a7,27
 ecall
 582:	00000073          	ecall
 ret
 586:	8082                	ret

0000000000000588 <recv>:
.global recv
recv:
 li a7, SYS_recv
 588:	48f1                	li	a7,28
 ecall
 58a:	00000073          	ecall
 ret
 58e:	8082                	ret

0000000000000590 <sendto>:
.global sendto
sendto:
 li a7, SYS_sendto
 590:	48f5                	li	a7,29
 ecall
 592:	00000073          	ecall
 ret
 596:	8082                	ret

0000000000000598 <recvfrom>:
.global recvfrom
recvfrom:
 li a7, SYS_recvfrom
 598:	48f9                	li	a7,30
 ecall
 59a:	00000073          	ecall
 ret
 59e:	8082                	ret

00000000000005a0 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 5a0:	1101                	add	sp,sp,-32
 5a2:	ec06                	sd	ra,24(sp)
 5a4:	e822                	sd	s0,16(sp)
 5a6:	1000                	add	s0,sp,32
 5a8:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 5ac:	4605                	li	a2,1
 5ae:	fef40593          	add	a1,s0,-17
 5b2:	f27ff0ef          	jal	4d8 <write>
}
 5b6:	60e2                	ld	ra,24(sp)
 5b8:	6442                	ld	s0,16(sp)
 5ba:	6105                	add	sp,sp,32
 5bc:	8082                	ret

00000000000005be <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
 5be:	715d                	add	sp,sp,-80
 5c0:	e486                	sd	ra,72(sp)
 5c2:	e0a2                	sd	s0,64(sp)
 5c4:	f84a                	sd	s2,48(sp)
 5c6:	0880                	add	s0,sp,80
 5c8:	892a                	mv	s2,a0
  char buf[20];
  int i, neg;
  unsigned long long x;

  neg = 0;
  if(sgn && xx < 0){
 5ca:	c299                	beqz	a3,5d0 <printint+0x12>
 5cc:	0805c363          	bltz	a1,652 <printint+0x94>
  neg = 0;
 5d0:	4881                	li	a7,0
 5d2:	fb840693          	add	a3,s0,-72
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
 5d6:	4781                	li	a5,0
  do{
    buf[i++] = digits[x % base];
 5d8:	00000517          	auipc	a0,0x0
 5dc:	55850513          	add	a0,a0,1368 # b30 <digits>
 5e0:	883e                	mv	a6,a5
 5e2:	2785                	addw	a5,a5,1
 5e4:	02c5f733          	remu	a4,a1,a2
 5e8:	972a                	add	a4,a4,a0
 5ea:	00074703          	lbu	a4,0(a4)
 5ee:	00e68023          	sb	a4,0(a3) # ff0000 <base+0xfeedf0>
  }while((x /= base) != 0);
 5f2:	872e                	mv	a4,a1
 5f4:	02c5d5b3          	divu	a1,a1,a2
 5f8:	0685                	add	a3,a3,1
 5fa:	fec773e3          	bgeu	a4,a2,5e0 <printint+0x22>
  if(neg)
 5fe:	00088b63          	beqz	a7,614 <printint+0x56>
    buf[i++] = '-';
 602:	fd078793          	add	a5,a5,-48
 606:	97a2                	add	a5,a5,s0
 608:	02d00713          	li	a4,45
 60c:	fee78423          	sb	a4,-24(a5)
 610:	0028079b          	addw	a5,a6,2

  while(--i >= 0)
 614:	02f05a63          	blez	a5,648 <printint+0x8a>
 618:	fc26                	sd	s1,56(sp)
 61a:	f44e                	sd	s3,40(sp)
 61c:	fb840713          	add	a4,s0,-72
 620:	00f704b3          	add	s1,a4,a5
 624:	fff70993          	add	s3,a4,-1
 628:	99be                	add	s3,s3,a5
 62a:	37fd                	addw	a5,a5,-1
 62c:	1782                	sll	a5,a5,0x20
 62e:	9381                	srl	a5,a5,0x20
 630:	40f989b3          	sub	s3,s3,a5
    putc(fd, buf[i]);
 634:	fff4c583          	lbu	a1,-1(s1)
 638:	854a                	mv	a0,s2
 63a:	f67ff0ef          	jal	5a0 <putc>
  while(--i >= 0)
 63e:	14fd                	add	s1,s1,-1
 640:	ff349ae3          	bne	s1,s3,634 <printint+0x76>
 644:	74e2                	ld	s1,56(sp)
 646:	79a2                	ld	s3,40(sp)
}
 648:	60a6                	ld	ra,72(sp)
 64a:	6406                	ld	s0,64(sp)
 64c:	7942                	ld	s2,48(sp)
 64e:	6161                	add	sp,sp,80
 650:	8082                	ret
    x = -xx;
 652:	40b005b3          	neg	a1,a1
    neg = 1;
 656:	4885                	li	a7,1
    x = -xx;
 658:	bfad                	j	5d2 <printint+0x14>

000000000000065a <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %c, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 65a:	711d                	add	sp,sp,-96
 65c:	ec86                	sd	ra,88(sp)
 65e:	e8a2                	sd	s0,80(sp)
 660:	e0ca                	sd	s2,64(sp)
 662:	1080                	add	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 664:	0005c903          	lbu	s2,0(a1)
 668:	28090663          	beqz	s2,8f4 <vprintf+0x29a>
 66c:	e4a6                	sd	s1,72(sp)
 66e:	fc4e                	sd	s3,56(sp)
 670:	f852                	sd	s4,48(sp)
 672:	f456                	sd	s5,40(sp)
 674:	f05a                	sd	s6,32(sp)
 676:	ec5e                	sd	s7,24(sp)
 678:	e862                	sd	s8,16(sp)
 67a:	e466                	sd	s9,8(sp)
 67c:	8b2a                	mv	s6,a0
 67e:	8a2e                	mv	s4,a1
 680:	8bb2                	mv	s7,a2
  state = 0;
 682:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
 684:	4481                	li	s1,0
 686:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
 688:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
 68c:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
 690:	06c00c93          	li	s9,108
 694:	a005                	j	6b4 <vprintf+0x5a>
        putc(fd, c0);
 696:	85ca                	mv	a1,s2
 698:	855a                	mv	a0,s6
 69a:	f07ff0ef          	jal	5a0 <putc>
 69e:	a019                	j	6a4 <vprintf+0x4a>
    } else if(state == '%'){
 6a0:	03598263          	beq	s3,s5,6c4 <vprintf+0x6a>
  for(i = 0; fmt[i]; i++){
 6a4:	2485                	addw	s1,s1,1
 6a6:	8726                	mv	a4,s1
 6a8:	009a07b3          	add	a5,s4,s1
 6ac:	0007c903          	lbu	s2,0(a5)
 6b0:	22090a63          	beqz	s2,8e4 <vprintf+0x28a>
    c0 = fmt[i] & 0xff;
 6b4:	0009079b          	sext.w	a5,s2
    if(state == 0){
 6b8:	fe0994e3          	bnez	s3,6a0 <vprintf+0x46>
      if(c0 == '%'){
 6bc:	fd579de3          	bne	a5,s5,696 <vprintf+0x3c>
        state = '%';
 6c0:	89be                	mv	s3,a5
 6c2:	b7cd                	j	6a4 <vprintf+0x4a>
      if(c0) c1 = fmt[i+1] & 0xff;
 6c4:	00ea06b3          	add	a3,s4,a4
 6c8:	0016c683          	lbu	a3,1(a3)
      c1 = c2 = 0;
 6cc:	8636                	mv	a2,a3
      if(c1) c2 = fmt[i+2] & 0xff;
 6ce:	c681                	beqz	a3,6d6 <vprintf+0x7c>
 6d0:	9752                	add	a4,a4,s4
 6d2:	00274603          	lbu	a2,2(a4)
      if(c0 == 'd'){
 6d6:	05878363          	beq	a5,s8,71c <vprintf+0xc2>
      } else if(c0 == 'l' && c1 == 'd'){
 6da:	05978d63          	beq	a5,s9,734 <vprintf+0xda>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
 6de:	07500713          	li	a4,117
 6e2:	0ee78763          	beq	a5,a4,7d0 <vprintf+0x176>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
 6e6:	07800713          	li	a4,120
 6ea:	12e78963          	beq	a5,a4,81c <vprintf+0x1c2>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
 6ee:	07000713          	li	a4,112
 6f2:	14e78e63          	beq	a5,a4,84e <vprintf+0x1f4>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 'c'){
 6f6:	06300713          	li	a4,99
 6fa:	18e78e63          	beq	a5,a4,896 <vprintf+0x23c>
        putc(fd, va_arg(ap, uint32));
      } else if(c0 == 's'){
 6fe:	07300713          	li	a4,115
 702:	1ae78463          	beq	a5,a4,8aa <vprintf+0x250>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
 706:	02500713          	li	a4,37
 70a:	04e79563          	bne	a5,a4,754 <vprintf+0xfa>
        putc(fd, '%');
 70e:	02500593          	li	a1,37
 712:	855a                	mv	a0,s6
 714:	e8dff0ef          	jal	5a0 <putc>
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c0);
      }

      state = 0;
 718:	4981                	li	s3,0
 71a:	b769                	j	6a4 <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 1);
 71c:	008b8913          	add	s2,s7,8
 720:	4685                	li	a3,1
 722:	4629                	li	a2,10
 724:	000ba583          	lw	a1,0(s7)
 728:	855a                	mv	a0,s6
 72a:	e95ff0ef          	jal	5be <printint>
 72e:	8bca                	mv	s7,s2
      state = 0;
 730:	4981                	li	s3,0
 732:	bf8d                	j	6a4 <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'd'){
 734:	06400793          	li	a5,100
 738:	02f68963          	beq	a3,a5,76a <vprintf+0x110>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 73c:	06c00793          	li	a5,108
 740:	04f68263          	beq	a3,a5,784 <vprintf+0x12a>
      } else if(c0 == 'l' && c1 == 'u'){
 744:	07500793          	li	a5,117
 748:	0af68063          	beq	a3,a5,7e8 <vprintf+0x18e>
      } else if(c0 == 'l' && c1 == 'x'){
 74c:	07800793          	li	a5,120
 750:	0ef68263          	beq	a3,a5,834 <vprintf+0x1da>
        putc(fd, '%');
 754:	02500593          	li	a1,37
 758:	855a                	mv	a0,s6
 75a:	e47ff0ef          	jal	5a0 <putc>
        putc(fd, c0);
 75e:	85ca                	mv	a1,s2
 760:	855a                	mv	a0,s6
 762:	e3fff0ef          	jal	5a0 <putc>
      state = 0;
 766:	4981                	li	s3,0
 768:	bf35                	j	6a4 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 76a:	008b8913          	add	s2,s7,8
 76e:	4685                	li	a3,1
 770:	4629                	li	a2,10
 772:	000bb583          	ld	a1,0(s7)
 776:	855a                	mv	a0,s6
 778:	e47ff0ef          	jal	5be <printint>
        i += 1;
 77c:	2485                	addw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 77e:	8bca                	mv	s7,s2
      state = 0;
 780:	4981                	li	s3,0
        i += 1;
 782:	b70d                	j	6a4 <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 784:	06400793          	li	a5,100
 788:	02f60763          	beq	a2,a5,7b6 <vprintf+0x15c>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 78c:	07500793          	li	a5,117
 790:	06f60963          	beq	a2,a5,802 <vprintf+0x1a8>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 794:	07800793          	li	a5,120
 798:	faf61ee3          	bne	a2,a5,754 <vprintf+0xfa>
        printint(fd, va_arg(ap, uint64), 16, 0);
 79c:	008b8913          	add	s2,s7,8
 7a0:	4681                	li	a3,0
 7a2:	4641                	li	a2,16
 7a4:	000bb583          	ld	a1,0(s7)
 7a8:	855a                	mv	a0,s6
 7aa:	e15ff0ef          	jal	5be <printint>
        i += 2;
 7ae:	2489                	addw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 7b0:	8bca                	mv	s7,s2
      state = 0;
 7b2:	4981                	li	s3,0
        i += 2;
 7b4:	bdc5                	j	6a4 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 7b6:	008b8913          	add	s2,s7,8
 7ba:	4685                	li	a3,1
 7bc:	4629                	li	a2,10
 7be:	000bb583          	ld	a1,0(s7)
 7c2:	855a                	mv	a0,s6
 7c4:	dfbff0ef          	jal	5be <printint>
        i += 2;
 7c8:	2489                	addw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 7ca:	8bca                	mv	s7,s2
      state = 0;
 7cc:	4981                	li	s3,0
        i += 2;
 7ce:	bdd9                	j	6a4 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint32), 10, 0);
 7d0:	008b8913          	add	s2,s7,8
 7d4:	4681                	li	a3,0
 7d6:	4629                	li	a2,10
 7d8:	000be583          	lwu	a1,0(s7)
 7dc:	855a                	mv	a0,s6
 7de:	de1ff0ef          	jal	5be <printint>
 7e2:	8bca                	mv	s7,s2
      state = 0;
 7e4:	4981                	li	s3,0
 7e6:	bd7d                	j	6a4 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 7e8:	008b8913          	add	s2,s7,8
 7ec:	4681                	li	a3,0
 7ee:	4629                	li	a2,10
 7f0:	000bb583          	ld	a1,0(s7)
 7f4:	855a                	mv	a0,s6
 7f6:	dc9ff0ef          	jal	5be <printint>
        i += 1;
 7fa:	2485                	addw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 7fc:	8bca                	mv	s7,s2
      state = 0;
 7fe:	4981                	li	s3,0
        i += 1;
 800:	b555                	j	6a4 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 802:	008b8913          	add	s2,s7,8
 806:	4681                	li	a3,0
 808:	4629                	li	a2,10
 80a:	000bb583          	ld	a1,0(s7)
 80e:	855a                	mv	a0,s6
 810:	dafff0ef          	jal	5be <printint>
        i += 2;
 814:	2489                	addw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 816:	8bca                	mv	s7,s2
      state = 0;
 818:	4981                	li	s3,0
        i += 2;
 81a:	b569                	j	6a4 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint32), 16, 0);
 81c:	008b8913          	add	s2,s7,8
 820:	4681                	li	a3,0
 822:	4641                	li	a2,16
 824:	000be583          	lwu	a1,0(s7)
 828:	855a                	mv	a0,s6
 82a:	d95ff0ef          	jal	5be <printint>
 82e:	8bca                	mv	s7,s2
      state = 0;
 830:	4981                	li	s3,0
 832:	bd8d                	j	6a4 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 16, 0);
 834:	008b8913          	add	s2,s7,8
 838:	4681                	li	a3,0
 83a:	4641                	li	a2,16
 83c:	000bb583          	ld	a1,0(s7)
 840:	855a                	mv	a0,s6
 842:	d7dff0ef          	jal	5be <printint>
        i += 1;
 846:	2485                	addw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 848:	8bca                	mv	s7,s2
      state = 0;
 84a:	4981                	li	s3,0
        i += 1;
 84c:	bda1                	j	6a4 <vprintf+0x4a>
 84e:	e06a                	sd	s10,0(sp)
        printptr(fd, va_arg(ap, uint64));
 850:	008b8d13          	add	s10,s7,8
 854:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 858:	03000593          	li	a1,48
 85c:	855a                	mv	a0,s6
 85e:	d43ff0ef          	jal	5a0 <putc>
  putc(fd, 'x');
 862:	07800593          	li	a1,120
 866:	855a                	mv	a0,s6
 868:	d39ff0ef          	jal	5a0 <putc>
 86c:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 86e:	00000b97          	auipc	s7,0x0
 872:	2c2b8b93          	add	s7,s7,706 # b30 <digits>
 876:	03c9d793          	srl	a5,s3,0x3c
 87a:	97de                	add	a5,a5,s7
 87c:	0007c583          	lbu	a1,0(a5)
 880:	855a                	mv	a0,s6
 882:	d1fff0ef          	jal	5a0 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 886:	0992                	sll	s3,s3,0x4
 888:	397d                	addw	s2,s2,-1
 88a:	fe0916e3          	bnez	s2,876 <vprintf+0x21c>
        printptr(fd, va_arg(ap, uint64));
 88e:	8bea                	mv	s7,s10
      state = 0;
 890:	4981                	li	s3,0
 892:	6d02                	ld	s10,0(sp)
 894:	bd01                	j	6a4 <vprintf+0x4a>
        putc(fd, va_arg(ap, uint32));
 896:	008b8913          	add	s2,s7,8
 89a:	000bc583          	lbu	a1,0(s7)
 89e:	855a                	mv	a0,s6
 8a0:	d01ff0ef          	jal	5a0 <putc>
 8a4:	8bca                	mv	s7,s2
      state = 0;
 8a6:	4981                	li	s3,0
 8a8:	bbf5                	j	6a4 <vprintf+0x4a>
        if((s = va_arg(ap, char*)) == 0)
 8aa:	008b8993          	add	s3,s7,8
 8ae:	000bb903          	ld	s2,0(s7)
 8b2:	00090f63          	beqz	s2,8d0 <vprintf+0x276>
        for(; *s; s++)
 8b6:	00094583          	lbu	a1,0(s2)
 8ba:	c195                	beqz	a1,8de <vprintf+0x284>
          putc(fd, *s);
 8bc:	855a                	mv	a0,s6
 8be:	ce3ff0ef          	jal	5a0 <putc>
        for(; *s; s++)
 8c2:	0905                	add	s2,s2,1
 8c4:	00094583          	lbu	a1,0(s2)
 8c8:	f9f5                	bnez	a1,8bc <vprintf+0x262>
        if((s = va_arg(ap, char*)) == 0)
 8ca:	8bce                	mv	s7,s3
      state = 0;
 8cc:	4981                	li	s3,0
 8ce:	bbd9                	j	6a4 <vprintf+0x4a>
          s = "(null)";
 8d0:	00000917          	auipc	s2,0x0
 8d4:	25890913          	add	s2,s2,600 # b28 <malloc+0x14c>
        for(; *s; s++)
 8d8:	02800593          	li	a1,40
 8dc:	b7c5                	j	8bc <vprintf+0x262>
        if((s = va_arg(ap, char*)) == 0)
 8de:	8bce                	mv	s7,s3
      state = 0;
 8e0:	4981                	li	s3,0
 8e2:	b3c9                	j	6a4 <vprintf+0x4a>
 8e4:	64a6                	ld	s1,72(sp)
 8e6:	79e2                	ld	s3,56(sp)
 8e8:	7a42                	ld	s4,48(sp)
 8ea:	7aa2                	ld	s5,40(sp)
 8ec:	7b02                	ld	s6,32(sp)
 8ee:	6be2                	ld	s7,24(sp)
 8f0:	6c42                	ld	s8,16(sp)
 8f2:	6ca2                	ld	s9,8(sp)
    }
  }
}
 8f4:	60e6                	ld	ra,88(sp)
 8f6:	6446                	ld	s0,80(sp)
 8f8:	6906                	ld	s2,64(sp)
 8fa:	6125                	add	sp,sp,96
 8fc:	8082                	ret

00000000000008fe <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 8fe:	715d                	add	sp,sp,-80
 900:	ec06                	sd	ra,24(sp)
 902:	e822                	sd	s0,16(sp)
 904:	1000                	add	s0,sp,32
 906:	e010                	sd	a2,0(s0)
 908:	e414                	sd	a3,8(s0)
 90a:	e818                	sd	a4,16(s0)
 90c:	ec1c                	sd	a5,24(s0)
 90e:	03043023          	sd	a6,32(s0)
 912:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 916:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 91a:	8622                	mv	a2,s0
 91c:	d3fff0ef          	jal	65a <vprintf>
}
 920:	60e2                	ld	ra,24(sp)
 922:	6442                	ld	s0,16(sp)
 924:	6161                	add	sp,sp,80
 926:	8082                	ret

0000000000000928 <printf>:

void
printf(const char *fmt, ...)
{
 928:	711d                	add	sp,sp,-96
 92a:	ec06                	sd	ra,24(sp)
 92c:	e822                	sd	s0,16(sp)
 92e:	1000                	add	s0,sp,32
 930:	e40c                	sd	a1,8(s0)
 932:	e810                	sd	a2,16(s0)
 934:	ec14                	sd	a3,24(s0)
 936:	f018                	sd	a4,32(s0)
 938:	f41c                	sd	a5,40(s0)
 93a:	03043823          	sd	a6,48(s0)
 93e:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 942:	00840613          	add	a2,s0,8
 946:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 94a:	85aa                	mv	a1,a0
 94c:	4505                	li	a0,1
 94e:	d0dff0ef          	jal	65a <vprintf>
}
 952:	60e2                	ld	ra,24(sp)
 954:	6442                	ld	s0,16(sp)
 956:	6125                	add	sp,sp,96
 958:	8082                	ret

000000000000095a <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 95a:	1141                	add	sp,sp,-16
 95c:	e422                	sd	s0,8(sp)
 95e:	0800                	add	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 960:	ff050693          	add	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 964:	00000797          	auipc	a5,0x0
 968:	69c7b783          	ld	a5,1692(a5) # 1000 <freep>
 96c:	a02d                	j	996 <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 96e:	4618                	lw	a4,8(a2)
 970:	9f2d                	addw	a4,a4,a1
 972:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 976:	6398                	ld	a4,0(a5)
 978:	6310                	ld	a2,0(a4)
 97a:	a83d                	j	9b8 <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 97c:	ff852703          	lw	a4,-8(a0)
 980:	9f31                	addw	a4,a4,a2
 982:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 984:	ff053683          	ld	a3,-16(a0)
 988:	a091                	j	9cc <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 98a:	6398                	ld	a4,0(a5)
 98c:	00e7e463          	bltu	a5,a4,994 <free+0x3a>
 990:	00e6ea63          	bltu	a3,a4,9a4 <free+0x4a>
{
 994:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 996:	fed7fae3          	bgeu	a5,a3,98a <free+0x30>
 99a:	6398                	ld	a4,0(a5)
 99c:	00e6e463          	bltu	a3,a4,9a4 <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 9a0:	fee7eae3          	bltu	a5,a4,994 <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 9a4:	ff852583          	lw	a1,-8(a0)
 9a8:	6390                	ld	a2,0(a5)
 9aa:	02059813          	sll	a6,a1,0x20
 9ae:	01c85713          	srl	a4,a6,0x1c
 9b2:	9736                	add	a4,a4,a3
 9b4:	fae60de3          	beq	a2,a4,96e <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 9b8:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 9bc:	4790                	lw	a2,8(a5)
 9be:	02061593          	sll	a1,a2,0x20
 9c2:	01c5d713          	srl	a4,a1,0x1c
 9c6:	973e                	add	a4,a4,a5
 9c8:	fae68ae3          	beq	a3,a4,97c <free+0x22>
    p->s.ptr = bp->s.ptr;
 9cc:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 9ce:	00000717          	auipc	a4,0x0
 9d2:	62f73923          	sd	a5,1586(a4) # 1000 <freep>
}
 9d6:	6422                	ld	s0,8(sp)
 9d8:	0141                	add	sp,sp,16
 9da:	8082                	ret

00000000000009dc <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 9dc:	7139                	add	sp,sp,-64
 9de:	fc06                	sd	ra,56(sp)
 9e0:	f822                	sd	s0,48(sp)
 9e2:	f426                	sd	s1,40(sp)
 9e4:	ec4e                	sd	s3,24(sp)
 9e6:	0080                	add	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 9e8:	02051493          	sll	s1,a0,0x20
 9ec:	9081                	srl	s1,s1,0x20
 9ee:	04bd                	add	s1,s1,15
 9f0:	8091                	srl	s1,s1,0x4
 9f2:	0014899b          	addw	s3,s1,1
 9f6:	0485                	add	s1,s1,1
  if((prevp = freep) == 0){
 9f8:	00000517          	auipc	a0,0x0
 9fc:	60853503          	ld	a0,1544(a0) # 1000 <freep>
 a00:	c915                	beqz	a0,a34 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a02:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 a04:	4798                	lw	a4,8(a5)
 a06:	08977a63          	bgeu	a4,s1,a9a <malloc+0xbe>
 a0a:	f04a                	sd	s2,32(sp)
 a0c:	e852                	sd	s4,16(sp)
 a0e:	e456                	sd	s5,8(sp)
 a10:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 a12:	8a4e                	mv	s4,s3
 a14:	0009871b          	sext.w	a4,s3
 a18:	6685                	lui	a3,0x1
 a1a:	00d77363          	bgeu	a4,a3,a20 <malloc+0x44>
 a1e:	6a05                	lui	s4,0x1
 a20:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 a24:	004a1a1b          	sllw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 a28:	00000917          	auipc	s2,0x0
 a2c:	5d890913          	add	s2,s2,1496 # 1000 <freep>
  if(p == SBRK_ERROR)
 a30:	5afd                	li	s5,-1
 a32:	a081                	j	a72 <malloc+0x96>
 a34:	f04a                	sd	s2,32(sp)
 a36:	e852                	sd	s4,16(sp)
 a38:	e456                	sd	s5,8(sp)
 a3a:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 a3c:	00000797          	auipc	a5,0x0
 a40:	7d478793          	add	a5,a5,2004 # 1210 <base>
 a44:	00000717          	auipc	a4,0x0
 a48:	5af73e23          	sd	a5,1468(a4) # 1000 <freep>
 a4c:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 a4e:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 a52:	b7c1                	j	a12 <malloc+0x36>
        prevp->s.ptr = p->s.ptr;
 a54:	6398                	ld	a4,0(a5)
 a56:	e118                	sd	a4,0(a0)
 a58:	a8a9                	j	ab2 <malloc+0xd6>
  hp->s.size = nu;
 a5a:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 a5e:	0541                	add	a0,a0,16
 a60:	efbff0ef          	jal	95a <free>
  return freep;
 a64:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 a68:	c12d                	beqz	a0,aca <malloc+0xee>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a6a:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 a6c:	4798                	lw	a4,8(a5)
 a6e:	02977263          	bgeu	a4,s1,a92 <malloc+0xb6>
    if(p == freep)
 a72:	00093703          	ld	a4,0(s2)
 a76:	853e                	mv	a0,a5
 a78:	fef719e3          	bne	a4,a5,a6a <malloc+0x8e>
  p = sbrk(nu * sizeof(Header));
 a7c:	8552                	mv	a0,s4
 a7e:	967ff0ef          	jal	3e4 <sbrk>
  if(p == SBRK_ERROR)
 a82:	fd551ce3          	bne	a0,s5,a5a <malloc+0x7e>
        return 0;
 a86:	4501                	li	a0,0
 a88:	7902                	ld	s2,32(sp)
 a8a:	6a42                	ld	s4,16(sp)
 a8c:	6aa2                	ld	s5,8(sp)
 a8e:	6b02                	ld	s6,0(sp)
 a90:	a03d                	j	abe <malloc+0xe2>
 a92:	7902                	ld	s2,32(sp)
 a94:	6a42                	ld	s4,16(sp)
 a96:	6aa2                	ld	s5,8(sp)
 a98:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 a9a:	fae48de3          	beq	s1,a4,a54 <malloc+0x78>
        p->s.size -= nunits;
 a9e:	4137073b          	subw	a4,a4,s3
 aa2:	c798                	sw	a4,8(a5)
        p += p->s.size;
 aa4:	02071693          	sll	a3,a4,0x20
 aa8:	01c6d713          	srl	a4,a3,0x1c
 aac:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 aae:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 ab2:	00000717          	auipc	a4,0x0
 ab6:	54a73723          	sd	a0,1358(a4) # 1000 <freep>
      return (void*)(p + 1);
 aba:	01078513          	add	a0,a5,16
  }
}
 abe:	70e2                	ld	ra,56(sp)
 ac0:	7442                	ld	s0,48(sp)
 ac2:	74a2                	ld	s1,40(sp)
 ac4:	69e2                	ld	s3,24(sp)
 ac6:	6121                	add	sp,sp,64
 ac8:	8082                	ret
 aca:	7902                	ld	s2,32(sp)
 acc:	6a42                	ld	s4,16(sp)
 ace:	6aa2                	ld	s5,8(sp)
 ad0:	6b02                	ld	s6,0(sp)
 ad2:	b7f5                	j	abe <malloc+0xe2>
