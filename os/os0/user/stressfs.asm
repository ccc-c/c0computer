
user/_stressfs:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/fs.h"
#include "kernel/fcntl.h"

int
main(int argc, char *argv[])
{
   0:	dd010113          	add	sp,sp,-560
   4:	22113423          	sd	ra,552(sp)
   8:	22813023          	sd	s0,544(sp)
   c:	20913c23          	sd	s1,536(sp)
  10:	21213823          	sd	s2,528(sp)
  14:	1c00                	add	s0,sp,560
  int fd, i;
  char path[] = "stressfs0";
  16:	00001797          	auipc	a5,0x1
  1a:	aea78793          	add	a5,a5,-1302 # b00 <malloc+0x136>
  1e:	6398                	ld	a4,0(a5)
  20:	fce43823          	sd	a4,-48(s0)
  24:	0087d783          	lhu	a5,8(a5)
  28:	fcf41c23          	sh	a5,-40(s0)
  char data[512];

  printf("stressfs starting\n");
  2c:	00001517          	auipc	a0,0x1
  30:	aa450513          	add	a0,a0,-1372 # ad0 <malloc+0x106>
  34:	0e3000ef          	jal	916 <printf>
  memset(data, 'a', sizeof(data));
  38:	20000613          	li	a2,512
  3c:	06100593          	li	a1,97
  40:	dd040513          	add	a0,s0,-560
  44:	1b0000ef          	jal	1f4 <memset>

  for(i = 0; i < 4; i++)
  48:	4481                	li	s1,0
  4a:	4911                	li	s2,4
    if(fork() > 0)
  4c:	452000ef          	jal	49e <fork>
  50:	00a04563          	bgtz	a0,5a <main+0x5a>
  for(i = 0; i < 4; i++)
  54:	2485                	addw	s1,s1,1
  56:	ff249be3          	bne	s1,s2,4c <main+0x4c>
      break;

  printf("write %d\n", i);
  5a:	85a6                	mv	a1,s1
  5c:	00001517          	auipc	a0,0x1
  60:	a8c50513          	add	a0,a0,-1396 # ae8 <malloc+0x11e>
  64:	0b3000ef          	jal	916 <printf>

  path[8] += i;
  68:	fd844783          	lbu	a5,-40(s0)
  6c:	9fa5                	addw	a5,a5,s1
  6e:	fcf40c23          	sb	a5,-40(s0)
  fd = open(path, O_CREATE | O_RDWR);
  72:	20200593          	li	a1,514
  76:	fd040513          	add	a0,s0,-48
  7a:	46c000ef          	jal	4e6 <open>
  7e:	892a                	mv	s2,a0
  80:	44d1                	li	s1,20
  for(i = 0; i < 20; i++)
//    printf(fd, "%d\n", i);
    write(fd, data, sizeof(data));
  82:	20000613          	li	a2,512
  86:	dd040593          	add	a1,s0,-560
  8a:	854a                	mv	a0,s2
  8c:	43a000ef          	jal	4c6 <write>
  for(i = 0; i < 20; i++)
  90:	34fd                	addw	s1,s1,-1
  92:	f8e5                	bnez	s1,82 <main+0x82>
  close(fd);
  94:	854a                	mv	a0,s2
  96:	438000ef          	jal	4ce <close>

  printf("read\n");
  9a:	00001517          	auipc	a0,0x1
  9e:	a5e50513          	add	a0,a0,-1442 # af8 <malloc+0x12e>
  a2:	075000ef          	jal	916 <printf>

  fd = open(path, O_RDONLY);
  a6:	4581                	li	a1,0
  a8:	fd040513          	add	a0,s0,-48
  ac:	43a000ef          	jal	4e6 <open>
  b0:	892a                	mv	s2,a0
  b2:	44d1                	li	s1,20
  for (i = 0; i < 20; i++)
    read(fd, data, sizeof(data));
  b4:	20000613          	li	a2,512
  b8:	dd040593          	add	a1,s0,-560
  bc:	854a                	mv	a0,s2
  be:	400000ef          	jal	4be <read>
  for (i = 0; i < 20; i++)
  c2:	34fd                	addw	s1,s1,-1
  c4:	f8e5                	bnez	s1,b4 <main+0xb4>
  close(fd);
  c6:	854a                	mv	a0,s2
  c8:	406000ef          	jal	4ce <close>

  wait(0);
  cc:	4501                	li	a0,0
  ce:	3e0000ef          	jal	4ae <wait>

  exit(0);
  d2:	4501                	li	a0,0
  d4:	3d2000ef          	jal	4a6 <exit>

00000000000000d8 <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start(int argc, char **argv)
{
  d8:	1141                	add	sp,sp,-16
  da:	e406                	sd	ra,8(sp)
  dc:	e022                	sd	s0,0(sp)
  de:	0800                	add	s0,sp,16
  int r;
  extern int main(int argc, char **argv);
  r = main(argc, argv);
  e0:	f21ff0ef          	jal	0 <main>
  exit(r);
  e4:	3c2000ef          	jal	4a6 <exit>

00000000000000e8 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
  e8:	1141                	add	sp,sp,-16
  ea:	e422                	sd	s0,8(sp)
  ec:	0800                	add	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  ee:	87aa                	mv	a5,a0
  f0:	0585                	add	a1,a1,1
  f2:	0785                	add	a5,a5,1
  f4:	fff5c703          	lbu	a4,-1(a1)
  f8:	fee78fa3          	sb	a4,-1(a5)
  fc:	fb75                	bnez	a4,f0 <strcpy+0x8>
    ;
  return os;
}
  fe:	6422                	ld	s0,8(sp)
 100:	0141                	add	sp,sp,16
 102:	8082                	ret

0000000000000104 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 104:	1141                	add	sp,sp,-16
 106:	e422                	sd	s0,8(sp)
 108:	0800                	add	s0,sp,16
  while(*p && *p == *q)
 10a:	00054783          	lbu	a5,0(a0)
 10e:	cb91                	beqz	a5,122 <strcmp+0x1e>
 110:	0005c703          	lbu	a4,0(a1)
 114:	00f71763          	bne	a4,a5,122 <strcmp+0x1e>
    p++, q++;
 118:	0505                	add	a0,a0,1
 11a:	0585                	add	a1,a1,1
  while(*p && *p == *q)
 11c:	00054783          	lbu	a5,0(a0)
 120:	fbe5                	bnez	a5,110 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 122:	0005c503          	lbu	a0,0(a1)
}
 126:	40a7853b          	subw	a0,a5,a0
 12a:	6422                	ld	s0,8(sp)
 12c:	0141                	add	sp,sp,16
 12e:	8082                	ret

0000000000000130 <strncmp>:

int
strncmp(const char *p, const char *q, uint n)
{
 130:	1141                	add	sp,sp,-16
 132:	e422                	sd	s0,8(sp)
 134:	0800                	add	s0,sp,16
  while(n > 0 && *p && *p == *q) {
 136:	ce11                	beqz	a2,152 <strncmp+0x22>
 138:	00054783          	lbu	a5,0(a0)
 13c:	cf89                	beqz	a5,156 <strncmp+0x26>
 13e:	0005c703          	lbu	a4,0(a1)
 142:	00f71a63          	bne	a4,a5,156 <strncmp+0x26>
    p++, q++, n--;
 146:	0505                	add	a0,a0,1
 148:	0585                	add	a1,a1,1
 14a:	367d                	addw	a2,a2,-1
  while(n > 0 && *p && *p == *q) {
 14c:	f675                	bnez	a2,138 <strncmp+0x8>
  }
  if (n == 0)
    return 0;
 14e:	4501                	li	a0,0
 150:	a801                	j	160 <strncmp+0x30>
 152:	4501                	li	a0,0
 154:	a031                	j	160 <strncmp+0x30>
  return (uchar)*p - (uchar)*q;
 156:	00054503          	lbu	a0,0(a0)
 15a:	0005c783          	lbu	a5,0(a1)
 15e:	9d1d                	subw	a0,a0,a5
}
 160:	6422                	ld	s0,8(sp)
 162:	0141                	add	sp,sp,16
 164:	8082                	ret

0000000000000166 <strcat>:

char*
strcat(char *dst, const char *src)
{
 166:	1141                	add	sp,sp,-16
 168:	e422                	sd	s0,8(sp)
 16a:	0800                	add	s0,sp,16
  char *p = dst;
  while(*p) p++;
 16c:	00054783          	lbu	a5,0(a0)
 170:	c385                	beqz	a5,190 <strcat+0x2a>
  char *p = dst;
 172:	87aa                	mv	a5,a0
  while(*p) p++;
 174:	0785                	add	a5,a5,1
 176:	0007c703          	lbu	a4,0(a5)
 17a:	ff6d                	bnez	a4,174 <strcat+0xe>
  while((*p++ = *src++) != 0);
 17c:	0585                	add	a1,a1,1
 17e:	0785                	add	a5,a5,1
 180:	fff5c703          	lbu	a4,-1(a1)
 184:	fee78fa3          	sb	a4,-1(a5)
 188:	fb75                	bnez	a4,17c <strcat+0x16>
  return dst;
}
 18a:	6422                	ld	s0,8(sp)
 18c:	0141                	add	sp,sp,16
 18e:	8082                	ret
  char *p = dst;
 190:	87aa                	mv	a5,a0
 192:	b7ed                	j	17c <strcat+0x16>

0000000000000194 <strncpy>:

char*
strncpy(char *dst, const char *src, int n)
{
 194:	1141                	add	sp,sp,-16
 196:	e422                	sd	s0,8(sp)
 198:	0800                	add	s0,sp,16
  char *p = dst;
 19a:	87aa                	mv	a5,a0
  while(n > 0 && *src) {
 19c:	02c05463          	blez	a2,1c4 <strncpy+0x30>
 1a0:	0005c703          	lbu	a4,0(a1)
 1a4:	cb01                	beqz	a4,1b4 <strncpy+0x20>
    *p++ = *src++;
 1a6:	0585                	add	a1,a1,1
 1a8:	0785                	add	a5,a5,1
 1aa:	fee78fa3          	sb	a4,-1(a5)
    n--;
 1ae:	367d                	addw	a2,a2,-1
  while(n > 0 && *src) {
 1b0:	fa65                	bnez	a2,1a0 <strncpy+0xc>
 1b2:	a809                	j	1c4 <strncpy+0x30>
  }
  while(n > 0) {
 1b4:	1602                	sll	a2,a2,0x20
 1b6:	9201                	srl	a2,a2,0x20
 1b8:	963e                	add	a2,a2,a5
    *p++ = 0;
 1ba:	0785                	add	a5,a5,1
 1bc:	fe078fa3          	sb	zero,-1(a5)
  while(n > 0) {
 1c0:	fec79de3          	bne	a5,a2,1ba <strncpy+0x26>
    n--;
  }
  return dst;
}
 1c4:	6422                	ld	s0,8(sp)
 1c6:	0141                	add	sp,sp,16
 1c8:	8082                	ret

00000000000001ca <strlen>:

uint
strlen(const char *s)
{
 1ca:	1141                	add	sp,sp,-16
 1cc:	e422                	sd	s0,8(sp)
 1ce:	0800                	add	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 1d0:	00054783          	lbu	a5,0(a0)
 1d4:	cf91                	beqz	a5,1f0 <strlen+0x26>
 1d6:	0505                	add	a0,a0,1
 1d8:	87aa                	mv	a5,a0
 1da:	86be                	mv	a3,a5
 1dc:	0785                	add	a5,a5,1
 1de:	fff7c703          	lbu	a4,-1(a5)
 1e2:	ff65                	bnez	a4,1da <strlen+0x10>
 1e4:	40a6853b          	subw	a0,a3,a0
 1e8:	2505                	addw	a0,a0,1
    ;
  return n;
}
 1ea:	6422                	ld	s0,8(sp)
 1ec:	0141                	add	sp,sp,16
 1ee:	8082                	ret
  for(n = 0; s[n]; n++)
 1f0:	4501                	li	a0,0
 1f2:	bfe5                	j	1ea <strlen+0x20>

00000000000001f4 <memset>:

void*
memset(void *dst, int c, uint n)
{
 1f4:	1141                	add	sp,sp,-16
 1f6:	e422                	sd	s0,8(sp)
 1f8:	0800                	add	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 1fa:	ca19                	beqz	a2,210 <memset+0x1c>
 1fc:	87aa                	mv	a5,a0
 1fe:	1602                	sll	a2,a2,0x20
 200:	9201                	srl	a2,a2,0x20
 202:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 206:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 20a:	0785                	add	a5,a5,1
 20c:	fee79de3          	bne	a5,a4,206 <memset+0x12>
  }
  return dst;
}
 210:	6422                	ld	s0,8(sp)
 212:	0141                	add	sp,sp,16
 214:	8082                	ret

0000000000000216 <strchr>:

char*
strchr(const char *s, char c)
{
 216:	1141                	add	sp,sp,-16
 218:	e422                	sd	s0,8(sp)
 21a:	0800                	add	s0,sp,16
  for(; *s; s++)
 21c:	00054783          	lbu	a5,0(a0)
 220:	cb99                	beqz	a5,236 <strchr+0x20>
    if(*s == c)
 222:	00f58763          	beq	a1,a5,230 <strchr+0x1a>
  for(; *s; s++)
 226:	0505                	add	a0,a0,1
 228:	00054783          	lbu	a5,0(a0)
 22c:	fbfd                	bnez	a5,222 <strchr+0xc>
      return (char*)s;
  return 0;
 22e:	4501                	li	a0,0
}
 230:	6422                	ld	s0,8(sp)
 232:	0141                	add	sp,sp,16
 234:	8082                	ret
  return 0;
 236:	4501                	li	a0,0
 238:	bfe5                	j	230 <strchr+0x1a>

000000000000023a <gets>:

char*
gets(char *buf, int max)
{
 23a:	711d                	add	sp,sp,-96
 23c:	ec86                	sd	ra,88(sp)
 23e:	e8a2                	sd	s0,80(sp)
 240:	e4a6                	sd	s1,72(sp)
 242:	e0ca                	sd	s2,64(sp)
 244:	fc4e                	sd	s3,56(sp)
 246:	f852                	sd	s4,48(sp)
 248:	f456                	sd	s5,40(sp)
 24a:	f05a                	sd	s6,32(sp)
 24c:	ec5e                	sd	s7,24(sp)
 24e:	1080                	add	s0,sp,96
 250:	8baa                	mv	s7,a0
 252:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 254:	892a                	mv	s2,a0
 256:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 258:	4aa9                	li	s5,10
 25a:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 25c:	89a6                	mv	s3,s1
 25e:	2485                	addw	s1,s1,1
 260:	0344d663          	bge	s1,s4,28c <gets+0x52>
    cc = read(0, &c, 1);
 264:	4605                	li	a2,1
 266:	faf40593          	add	a1,s0,-81
 26a:	4501                	li	a0,0
 26c:	252000ef          	jal	4be <read>
    if(cc < 1)
 270:	00a05e63          	blez	a0,28c <gets+0x52>
    buf[i++] = c;
 274:	faf44783          	lbu	a5,-81(s0)
 278:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 27c:	01578763          	beq	a5,s5,28a <gets+0x50>
 280:	0905                	add	s2,s2,1
 282:	fd679de3          	bne	a5,s6,25c <gets+0x22>
    buf[i++] = c;
 286:	89a6                	mv	s3,s1
 288:	a011                	j	28c <gets+0x52>
 28a:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 28c:	99de                	add	s3,s3,s7
 28e:	00098023          	sb	zero,0(s3)
  return buf;
}
 292:	855e                	mv	a0,s7
 294:	60e6                	ld	ra,88(sp)
 296:	6446                	ld	s0,80(sp)
 298:	64a6                	ld	s1,72(sp)
 29a:	6906                	ld	s2,64(sp)
 29c:	79e2                	ld	s3,56(sp)
 29e:	7a42                	ld	s4,48(sp)
 2a0:	7aa2                	ld	s5,40(sp)
 2a2:	7b02                	ld	s6,32(sp)
 2a4:	6be2                	ld	s7,24(sp)
 2a6:	6125                	add	sp,sp,96
 2a8:	8082                	ret

00000000000002aa <stat>:

int
stat(const char *n, struct stat *st)
{
 2aa:	1101                	add	sp,sp,-32
 2ac:	ec06                	sd	ra,24(sp)
 2ae:	e822                	sd	s0,16(sp)
 2b0:	e04a                	sd	s2,0(sp)
 2b2:	1000                	add	s0,sp,32
 2b4:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 2b6:	4581                	li	a1,0
 2b8:	22e000ef          	jal	4e6 <open>
  if(fd < 0)
 2bc:	02054263          	bltz	a0,2e0 <stat+0x36>
 2c0:	e426                	sd	s1,8(sp)
 2c2:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 2c4:	85ca                	mv	a1,s2
 2c6:	238000ef          	jal	4fe <fstat>
 2ca:	892a                	mv	s2,a0
  close(fd);
 2cc:	8526                	mv	a0,s1
 2ce:	200000ef          	jal	4ce <close>
  return r;
 2d2:	64a2                	ld	s1,8(sp)
}
 2d4:	854a                	mv	a0,s2
 2d6:	60e2                	ld	ra,24(sp)
 2d8:	6442                	ld	s0,16(sp)
 2da:	6902                	ld	s2,0(sp)
 2dc:	6105                	add	sp,sp,32
 2de:	8082                	ret
    return -1;
 2e0:	597d                	li	s2,-1
 2e2:	bfcd                	j	2d4 <stat+0x2a>

00000000000002e4 <atoi>:

int
atoi(const char *s)
{
 2e4:	1141                	add	sp,sp,-16
 2e6:	e422                	sd	s0,8(sp)
 2e8:	0800                	add	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 2ea:	00054683          	lbu	a3,0(a0)
 2ee:	fd06879b          	addw	a5,a3,-48
 2f2:	0ff7f793          	zext.b	a5,a5
 2f6:	4625                	li	a2,9
 2f8:	02f66863          	bltu	a2,a5,328 <atoi+0x44>
 2fc:	872a                	mv	a4,a0
  n = 0;
 2fe:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 300:	0705                	add	a4,a4,1
 302:	0025179b          	sllw	a5,a0,0x2
 306:	9fa9                	addw	a5,a5,a0
 308:	0017979b          	sllw	a5,a5,0x1
 30c:	9fb5                	addw	a5,a5,a3
 30e:	fd07851b          	addw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 312:	00074683          	lbu	a3,0(a4)
 316:	fd06879b          	addw	a5,a3,-48
 31a:	0ff7f793          	zext.b	a5,a5
 31e:	fef671e3          	bgeu	a2,a5,300 <atoi+0x1c>
  return n;
}
 322:	6422                	ld	s0,8(sp)
 324:	0141                	add	sp,sp,16
 326:	8082                	ret
  n = 0;
 328:	4501                	li	a0,0
 32a:	bfe5                	j	322 <atoi+0x3e>

000000000000032c <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 32c:	1141                	add	sp,sp,-16
 32e:	e422                	sd	s0,8(sp)
 330:	0800                	add	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 332:	02b57463          	bgeu	a0,a1,35a <memmove+0x2e>
    while(n-- > 0)
 336:	00c05f63          	blez	a2,354 <memmove+0x28>
 33a:	1602                	sll	a2,a2,0x20
 33c:	9201                	srl	a2,a2,0x20
 33e:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 342:	872a                	mv	a4,a0
      *dst++ = *src++;
 344:	0585                	add	a1,a1,1
 346:	0705                	add	a4,a4,1
 348:	fff5c683          	lbu	a3,-1(a1)
 34c:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 350:	fef71ae3          	bne	a4,a5,344 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 354:	6422                	ld	s0,8(sp)
 356:	0141                	add	sp,sp,16
 358:	8082                	ret
    dst += n;
 35a:	00c50733          	add	a4,a0,a2
    src += n;
 35e:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 360:	fec05ae3          	blez	a2,354 <memmove+0x28>
 364:	fff6079b          	addw	a5,a2,-1
 368:	1782                	sll	a5,a5,0x20
 36a:	9381                	srl	a5,a5,0x20
 36c:	fff7c793          	not	a5,a5
 370:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 372:	15fd                	add	a1,a1,-1
 374:	177d                	add	a4,a4,-1
 376:	0005c683          	lbu	a3,0(a1)
 37a:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 37e:	fee79ae3          	bne	a5,a4,372 <memmove+0x46>
 382:	bfc9                	j	354 <memmove+0x28>

0000000000000384 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 384:	1141                	add	sp,sp,-16
 386:	e422                	sd	s0,8(sp)
 388:	0800                	add	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 38a:	ca05                	beqz	a2,3ba <memcmp+0x36>
 38c:	fff6069b          	addw	a3,a2,-1
 390:	1682                	sll	a3,a3,0x20
 392:	9281                	srl	a3,a3,0x20
 394:	0685                	add	a3,a3,1
 396:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 398:	00054783          	lbu	a5,0(a0)
 39c:	0005c703          	lbu	a4,0(a1)
 3a0:	00e79863          	bne	a5,a4,3b0 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 3a4:	0505                	add	a0,a0,1
    p2++;
 3a6:	0585                	add	a1,a1,1
  while (n-- > 0) {
 3a8:	fed518e3          	bne	a0,a3,398 <memcmp+0x14>
  }
  return 0;
 3ac:	4501                	li	a0,0
 3ae:	a019                	j	3b4 <memcmp+0x30>
      return *p1 - *p2;
 3b0:	40e7853b          	subw	a0,a5,a4
}
 3b4:	6422                	ld	s0,8(sp)
 3b6:	0141                	add	sp,sp,16
 3b8:	8082                	ret
  return 0;
 3ba:	4501                	li	a0,0
 3bc:	bfe5                	j	3b4 <memcmp+0x30>

00000000000003be <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 3be:	1141                	add	sp,sp,-16
 3c0:	e406                	sd	ra,8(sp)
 3c2:	e022                	sd	s0,0(sp)
 3c4:	0800                	add	s0,sp,16
  return memmove(dst, src, n);
 3c6:	f67ff0ef          	jal	32c <memmove>
}
 3ca:	60a2                	ld	ra,8(sp)
 3cc:	6402                	ld	s0,0(sp)
 3ce:	0141                	add	sp,sp,16
 3d0:	8082                	ret

00000000000003d2 <sbrk>:

char *
sbrk(int n) {
 3d2:	1141                	add	sp,sp,-16
 3d4:	e406                	sd	ra,8(sp)
 3d6:	e022                	sd	s0,0(sp)
 3d8:	0800                	add	s0,sp,16
  return sys_sbrk(n, SBRK_EAGER);
 3da:	4585                	li	a1,1
 3dc:	152000ef          	jal	52e <sys_sbrk>
}
 3e0:	60a2                	ld	ra,8(sp)
 3e2:	6402                	ld	s0,0(sp)
 3e4:	0141                	add	sp,sp,16
 3e6:	8082                	ret

00000000000003e8 <sbrklazy>:

char *
sbrklazy(int n) {
 3e8:	1141                	add	sp,sp,-16
 3ea:	e406                	sd	ra,8(sp)
 3ec:	e022                	sd	s0,0(sp)
 3ee:	0800                	add	s0,sp,16
  return sys_sbrk(n, SBRK_LAZY);
 3f0:	4589                	li	a1,2
 3f2:	13c000ef          	jal	52e <sys_sbrk>
}
 3f6:	60a2                	ld	ra,8(sp)
 3f8:	6402                	ld	s0,0(sp)
 3fa:	0141                	add	sp,sp,16
 3fc:	8082                	ret

00000000000003fe <htons>:

// Byte order conversion functions
unsigned short
htons(unsigned short hostshort)
{
 3fe:	1141                	add	sp,sp,-16
 400:	e422                	sd	s0,8(sp)
 402:	0800                	add	s0,sp,16
  return ((hostshort >> 8) & 0xff) | ((hostshort & 0xff) << 8);
 404:	0085179b          	sllw	a5,a0,0x8
 408:	0085551b          	srlw	a0,a0,0x8
 40c:	8d5d                	or	a0,a0,a5
}
 40e:	1542                	sll	a0,a0,0x30
 410:	9141                	srl	a0,a0,0x30
 412:	6422                	ld	s0,8(sp)
 414:	0141                	add	sp,sp,16
 416:	8082                	ret

0000000000000418 <ntohs>:

unsigned short
ntohs(unsigned short netshort)
{
 418:	1141                	add	sp,sp,-16
 41a:	e422                	sd	s0,8(sp)
 41c:	0800                	add	s0,sp,16
  return ((netshort >> 8) & 0xff) | ((netshort & 0xff) << 8);
 41e:	0085179b          	sllw	a5,a0,0x8
 422:	0085551b          	srlw	a0,a0,0x8
 426:	8d5d                	or	a0,a0,a5
}
 428:	1542                	sll	a0,a0,0x30
 42a:	9141                	srl	a0,a0,0x30
 42c:	6422                	ld	s0,8(sp)
 42e:	0141                	add	sp,sp,16
 430:	8082                	ret

0000000000000432 <htonl>:

unsigned long
htonl(unsigned long hostlong)
{
 432:	1141                	add	sp,sp,-16
 434:	e422                	sd	s0,8(sp)
 436:	0800                	add	s0,sp,16
  return ((hostlong >> 24) & 0xff) |
 438:	0185579b          	srlw	a5,a0,0x18
         ((hostlong >> 8) & 0xff00) |
 43c:	00855713          	srl	a4,a0,0x8
 440:	66c1                	lui	a3,0x10
 442:	f0068693          	add	a3,a3,-256 # ff00 <base+0xeef0>
 446:	8f75                	and	a4,a4,a3
  return ((hostlong >> 24) & 0xff) |
 448:	8fd9                	or	a5,a5,a4
         ((hostlong & 0xff00) << 8) |
 44a:	00851713          	sll	a4,a0,0x8
 44e:	00ff06b7          	lui	a3,0xff0
 452:	8f75                	and	a4,a4,a3
         ((hostlong >> 8) & 0xff00) |
 454:	8fd9                	or	a5,a5,a4
         ((hostlong & 0xff) << 24);
 456:	0562                	sll	a0,a0,0x18
 458:	0ff00713          	li	a4,255
 45c:	0762                	sll	a4,a4,0x18
 45e:	8d79                	and	a0,a0,a4
}
 460:	8d5d                	or	a0,a0,a5
 462:	6422                	ld	s0,8(sp)
 464:	0141                	add	sp,sp,16
 466:	8082                	ret

0000000000000468 <ntohl>:

unsigned long
ntohl(unsigned long netlong)
{
 468:	1141                	add	sp,sp,-16
 46a:	e422                	sd	s0,8(sp)
 46c:	0800                	add	s0,sp,16
  return ((netlong >> 24) & 0xff) |
 46e:	0185579b          	srlw	a5,a0,0x18
         ((netlong >> 8) & 0xff00) |
 472:	00855713          	srl	a4,a0,0x8
 476:	66c1                	lui	a3,0x10
 478:	f0068693          	add	a3,a3,-256 # ff00 <base+0xeef0>
 47c:	8f75                	and	a4,a4,a3
  return ((netlong >> 24) & 0xff) |
 47e:	8fd9                	or	a5,a5,a4
         ((netlong & 0xff00) << 8) |
 480:	00851713          	sll	a4,a0,0x8
 484:	00ff06b7          	lui	a3,0xff0
 488:	8f75                	and	a4,a4,a3
         ((netlong >> 8) & 0xff00) |
 48a:	8fd9                	or	a5,a5,a4
         ((netlong & 0xff) << 24);
 48c:	0562                	sll	a0,a0,0x18
 48e:	0ff00713          	li	a4,255
 492:	0762                	sll	a4,a4,0x18
 494:	8d79                	and	a0,a0,a4
}
 496:	8d5d                	or	a0,a0,a5
 498:	6422                	ld	s0,8(sp)
 49a:	0141                	add	sp,sp,16
 49c:	8082                	ret

000000000000049e <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 49e:	4885                	li	a7,1
 ecall
 4a0:	00000073          	ecall
 ret
 4a4:	8082                	ret

00000000000004a6 <exit>:
.global exit
exit:
 li a7, SYS_exit
 4a6:	4889                	li	a7,2
 ecall
 4a8:	00000073          	ecall
 ret
 4ac:	8082                	ret

00000000000004ae <wait>:
.global wait
wait:
 li a7, SYS_wait
 4ae:	488d                	li	a7,3
 ecall
 4b0:	00000073          	ecall
 ret
 4b4:	8082                	ret

00000000000004b6 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 4b6:	4891                	li	a7,4
 ecall
 4b8:	00000073          	ecall
 ret
 4bc:	8082                	ret

00000000000004be <read>:
.global read
read:
 li a7, SYS_read
 4be:	4895                	li	a7,5
 ecall
 4c0:	00000073          	ecall
 ret
 4c4:	8082                	ret

00000000000004c6 <write>:
.global write
write:
 li a7, SYS_write
 4c6:	48c1                	li	a7,16
 ecall
 4c8:	00000073          	ecall
 ret
 4cc:	8082                	ret

00000000000004ce <close>:
.global close
close:
 li a7, SYS_close
 4ce:	48d5                	li	a7,21
 ecall
 4d0:	00000073          	ecall
 ret
 4d4:	8082                	ret

00000000000004d6 <kill>:
.global kill
kill:
 li a7, SYS_kill
 4d6:	4899                	li	a7,6
 ecall
 4d8:	00000073          	ecall
 ret
 4dc:	8082                	ret

00000000000004de <exec>:
.global exec
exec:
 li a7, SYS_exec
 4de:	489d                	li	a7,7
 ecall
 4e0:	00000073          	ecall
 ret
 4e4:	8082                	ret

00000000000004e6 <open>:
.global open
open:
 li a7, SYS_open
 4e6:	48bd                	li	a7,15
 ecall
 4e8:	00000073          	ecall
 ret
 4ec:	8082                	ret

00000000000004ee <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 4ee:	48c5                	li	a7,17
 ecall
 4f0:	00000073          	ecall
 ret
 4f4:	8082                	ret

00000000000004f6 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 4f6:	48c9                	li	a7,18
 ecall
 4f8:	00000073          	ecall
 ret
 4fc:	8082                	ret

00000000000004fe <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 4fe:	48a1                	li	a7,8
 ecall
 500:	00000073          	ecall
 ret
 504:	8082                	ret

0000000000000506 <link>:
.global link
link:
 li a7, SYS_link
 506:	48cd                	li	a7,19
 ecall
 508:	00000073          	ecall
 ret
 50c:	8082                	ret

000000000000050e <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 50e:	48d1                	li	a7,20
 ecall
 510:	00000073          	ecall
 ret
 514:	8082                	ret

0000000000000516 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 516:	48a5                	li	a7,9
 ecall
 518:	00000073          	ecall
 ret
 51c:	8082                	ret

000000000000051e <dup>:
.global dup
dup:
 li a7, SYS_dup
 51e:	48a9                	li	a7,10
 ecall
 520:	00000073          	ecall
 ret
 524:	8082                	ret

0000000000000526 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 526:	48ad                	li	a7,11
 ecall
 528:	00000073          	ecall
 ret
 52c:	8082                	ret

000000000000052e <sys_sbrk>:
.global sys_sbrk
sys_sbrk:
 li a7, SYS_sbrk
 52e:	48b1                	li	a7,12
 ecall
 530:	00000073          	ecall
 ret
 534:	8082                	ret

0000000000000536 <pause>:
.global pause
pause:
 li a7, SYS_pause
 536:	48b5                	li	a7,13
 ecall
 538:	00000073          	ecall
 ret
 53c:	8082                	ret

000000000000053e <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 53e:	48b9                	li	a7,14
 ecall
 540:	00000073          	ecall
 ret
 544:	8082                	ret

0000000000000546 <socket>:
.global socket
socket:
 li a7, SYS_socket
 546:	48d9                	li	a7,22
 ecall
 548:	00000073          	ecall
 ret
 54c:	8082                	ret

000000000000054e <bind>:
.global bind
bind:
 li a7, SYS_bind
 54e:	48dd                	li	a7,23
 ecall
 550:	00000073          	ecall
 ret
 554:	8082                	ret

0000000000000556 <listen>:
.global listen
listen:
 li a7, SYS_listen
 556:	48e1                	li	a7,24
 ecall
 558:	00000073          	ecall
 ret
 55c:	8082                	ret

000000000000055e <accept>:
.global accept
accept:
 li a7, SYS_accept
 55e:	48e5                	li	a7,25
 ecall
 560:	00000073          	ecall
 ret
 564:	8082                	ret

0000000000000566 <connect>:
.global connect
connect:
 li a7, SYS_connect
 566:	48e9                	li	a7,26
 ecall
 568:	00000073          	ecall
 ret
 56c:	8082                	ret

000000000000056e <send>:
.global send
send:
 li a7, SYS_send
 56e:	48ed                	li	a7,27
 ecall
 570:	00000073          	ecall
 ret
 574:	8082                	ret

0000000000000576 <recv>:
.global recv
recv:
 li a7, SYS_recv
 576:	48f1                	li	a7,28
 ecall
 578:	00000073          	ecall
 ret
 57c:	8082                	ret

000000000000057e <sendto>:
.global sendto
sendto:
 li a7, SYS_sendto
 57e:	48f5                	li	a7,29
 ecall
 580:	00000073          	ecall
 ret
 584:	8082                	ret

0000000000000586 <recvfrom>:
.global recvfrom
recvfrom:
 li a7, SYS_recvfrom
 586:	48f9                	li	a7,30
 ecall
 588:	00000073          	ecall
 ret
 58c:	8082                	ret

000000000000058e <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 58e:	1101                	add	sp,sp,-32
 590:	ec06                	sd	ra,24(sp)
 592:	e822                	sd	s0,16(sp)
 594:	1000                	add	s0,sp,32
 596:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 59a:	4605                	li	a2,1
 59c:	fef40593          	add	a1,s0,-17
 5a0:	f27ff0ef          	jal	4c6 <write>
}
 5a4:	60e2                	ld	ra,24(sp)
 5a6:	6442                	ld	s0,16(sp)
 5a8:	6105                	add	sp,sp,32
 5aa:	8082                	ret

00000000000005ac <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
 5ac:	715d                	add	sp,sp,-80
 5ae:	e486                	sd	ra,72(sp)
 5b0:	e0a2                	sd	s0,64(sp)
 5b2:	f84a                	sd	s2,48(sp)
 5b4:	0880                	add	s0,sp,80
 5b6:	892a                	mv	s2,a0
  char buf[20];
  int i, neg;
  unsigned long long x;

  neg = 0;
  if(sgn && xx < 0){
 5b8:	c299                	beqz	a3,5be <printint+0x12>
 5ba:	0805c363          	bltz	a1,640 <printint+0x94>
  neg = 0;
 5be:	4881                	li	a7,0
 5c0:	fb840693          	add	a3,s0,-72
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
 5c4:	4781                	li	a5,0
  do{
    buf[i++] = digits[x % base];
 5c6:	00000517          	auipc	a0,0x0
 5ca:	55250513          	add	a0,a0,1362 # b18 <digits>
 5ce:	883e                	mv	a6,a5
 5d0:	2785                	addw	a5,a5,1
 5d2:	02c5f733          	remu	a4,a1,a2
 5d6:	972a                	add	a4,a4,a0
 5d8:	00074703          	lbu	a4,0(a4)
 5dc:	00e68023          	sb	a4,0(a3) # ff0000 <base+0xfeeff0>
  }while((x /= base) != 0);
 5e0:	872e                	mv	a4,a1
 5e2:	02c5d5b3          	divu	a1,a1,a2
 5e6:	0685                	add	a3,a3,1
 5e8:	fec773e3          	bgeu	a4,a2,5ce <printint+0x22>
  if(neg)
 5ec:	00088b63          	beqz	a7,602 <printint+0x56>
    buf[i++] = '-';
 5f0:	fd078793          	add	a5,a5,-48
 5f4:	97a2                	add	a5,a5,s0
 5f6:	02d00713          	li	a4,45
 5fa:	fee78423          	sb	a4,-24(a5)
 5fe:	0028079b          	addw	a5,a6,2

  while(--i >= 0)
 602:	02f05a63          	blez	a5,636 <printint+0x8a>
 606:	fc26                	sd	s1,56(sp)
 608:	f44e                	sd	s3,40(sp)
 60a:	fb840713          	add	a4,s0,-72
 60e:	00f704b3          	add	s1,a4,a5
 612:	fff70993          	add	s3,a4,-1
 616:	99be                	add	s3,s3,a5
 618:	37fd                	addw	a5,a5,-1
 61a:	1782                	sll	a5,a5,0x20
 61c:	9381                	srl	a5,a5,0x20
 61e:	40f989b3          	sub	s3,s3,a5
    putc(fd, buf[i]);
 622:	fff4c583          	lbu	a1,-1(s1)
 626:	854a                	mv	a0,s2
 628:	f67ff0ef          	jal	58e <putc>
  while(--i >= 0)
 62c:	14fd                	add	s1,s1,-1
 62e:	ff349ae3          	bne	s1,s3,622 <printint+0x76>
 632:	74e2                	ld	s1,56(sp)
 634:	79a2                	ld	s3,40(sp)
}
 636:	60a6                	ld	ra,72(sp)
 638:	6406                	ld	s0,64(sp)
 63a:	7942                	ld	s2,48(sp)
 63c:	6161                	add	sp,sp,80
 63e:	8082                	ret
    x = -xx;
 640:	40b005b3          	neg	a1,a1
    neg = 1;
 644:	4885                	li	a7,1
    x = -xx;
 646:	bfad                	j	5c0 <printint+0x14>

0000000000000648 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %c, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 648:	711d                	add	sp,sp,-96
 64a:	ec86                	sd	ra,88(sp)
 64c:	e8a2                	sd	s0,80(sp)
 64e:	e0ca                	sd	s2,64(sp)
 650:	1080                	add	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 652:	0005c903          	lbu	s2,0(a1)
 656:	28090663          	beqz	s2,8e2 <vprintf+0x29a>
 65a:	e4a6                	sd	s1,72(sp)
 65c:	fc4e                	sd	s3,56(sp)
 65e:	f852                	sd	s4,48(sp)
 660:	f456                	sd	s5,40(sp)
 662:	f05a                	sd	s6,32(sp)
 664:	ec5e                	sd	s7,24(sp)
 666:	e862                	sd	s8,16(sp)
 668:	e466                	sd	s9,8(sp)
 66a:	8b2a                	mv	s6,a0
 66c:	8a2e                	mv	s4,a1
 66e:	8bb2                	mv	s7,a2
  state = 0;
 670:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
 672:	4481                	li	s1,0
 674:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
 676:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
 67a:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
 67e:	06c00c93          	li	s9,108
 682:	a005                	j	6a2 <vprintf+0x5a>
        putc(fd, c0);
 684:	85ca                	mv	a1,s2
 686:	855a                	mv	a0,s6
 688:	f07ff0ef          	jal	58e <putc>
 68c:	a019                	j	692 <vprintf+0x4a>
    } else if(state == '%'){
 68e:	03598263          	beq	s3,s5,6b2 <vprintf+0x6a>
  for(i = 0; fmt[i]; i++){
 692:	2485                	addw	s1,s1,1
 694:	8726                	mv	a4,s1
 696:	009a07b3          	add	a5,s4,s1
 69a:	0007c903          	lbu	s2,0(a5)
 69e:	22090a63          	beqz	s2,8d2 <vprintf+0x28a>
    c0 = fmt[i] & 0xff;
 6a2:	0009079b          	sext.w	a5,s2
    if(state == 0){
 6a6:	fe0994e3          	bnez	s3,68e <vprintf+0x46>
      if(c0 == '%'){
 6aa:	fd579de3          	bne	a5,s5,684 <vprintf+0x3c>
        state = '%';
 6ae:	89be                	mv	s3,a5
 6b0:	b7cd                	j	692 <vprintf+0x4a>
      if(c0) c1 = fmt[i+1] & 0xff;
 6b2:	00ea06b3          	add	a3,s4,a4
 6b6:	0016c683          	lbu	a3,1(a3)
      c1 = c2 = 0;
 6ba:	8636                	mv	a2,a3
      if(c1) c2 = fmt[i+2] & 0xff;
 6bc:	c681                	beqz	a3,6c4 <vprintf+0x7c>
 6be:	9752                	add	a4,a4,s4
 6c0:	00274603          	lbu	a2,2(a4)
      if(c0 == 'd'){
 6c4:	05878363          	beq	a5,s8,70a <vprintf+0xc2>
      } else if(c0 == 'l' && c1 == 'd'){
 6c8:	05978d63          	beq	a5,s9,722 <vprintf+0xda>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
 6cc:	07500713          	li	a4,117
 6d0:	0ee78763          	beq	a5,a4,7be <vprintf+0x176>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
 6d4:	07800713          	li	a4,120
 6d8:	12e78963          	beq	a5,a4,80a <vprintf+0x1c2>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
 6dc:	07000713          	li	a4,112
 6e0:	14e78e63          	beq	a5,a4,83c <vprintf+0x1f4>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 'c'){
 6e4:	06300713          	li	a4,99
 6e8:	18e78e63          	beq	a5,a4,884 <vprintf+0x23c>
        putc(fd, va_arg(ap, uint32));
      } else if(c0 == 's'){
 6ec:	07300713          	li	a4,115
 6f0:	1ae78463          	beq	a5,a4,898 <vprintf+0x250>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
 6f4:	02500713          	li	a4,37
 6f8:	04e79563          	bne	a5,a4,742 <vprintf+0xfa>
        putc(fd, '%');
 6fc:	02500593          	li	a1,37
 700:	855a                	mv	a0,s6
 702:	e8dff0ef          	jal	58e <putc>
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c0);
      }

      state = 0;
 706:	4981                	li	s3,0
 708:	b769                	j	692 <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 1);
 70a:	008b8913          	add	s2,s7,8
 70e:	4685                	li	a3,1
 710:	4629                	li	a2,10
 712:	000ba583          	lw	a1,0(s7)
 716:	855a                	mv	a0,s6
 718:	e95ff0ef          	jal	5ac <printint>
 71c:	8bca                	mv	s7,s2
      state = 0;
 71e:	4981                	li	s3,0
 720:	bf8d                	j	692 <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'd'){
 722:	06400793          	li	a5,100
 726:	02f68963          	beq	a3,a5,758 <vprintf+0x110>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 72a:	06c00793          	li	a5,108
 72e:	04f68263          	beq	a3,a5,772 <vprintf+0x12a>
      } else if(c0 == 'l' && c1 == 'u'){
 732:	07500793          	li	a5,117
 736:	0af68063          	beq	a3,a5,7d6 <vprintf+0x18e>
      } else if(c0 == 'l' && c1 == 'x'){
 73a:	07800793          	li	a5,120
 73e:	0ef68263          	beq	a3,a5,822 <vprintf+0x1da>
        putc(fd, '%');
 742:	02500593          	li	a1,37
 746:	855a                	mv	a0,s6
 748:	e47ff0ef          	jal	58e <putc>
        putc(fd, c0);
 74c:	85ca                	mv	a1,s2
 74e:	855a                	mv	a0,s6
 750:	e3fff0ef          	jal	58e <putc>
      state = 0;
 754:	4981                	li	s3,0
 756:	bf35                	j	692 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 758:	008b8913          	add	s2,s7,8
 75c:	4685                	li	a3,1
 75e:	4629                	li	a2,10
 760:	000bb583          	ld	a1,0(s7)
 764:	855a                	mv	a0,s6
 766:	e47ff0ef          	jal	5ac <printint>
        i += 1;
 76a:	2485                	addw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 76c:	8bca                	mv	s7,s2
      state = 0;
 76e:	4981                	li	s3,0
        i += 1;
 770:	b70d                	j	692 <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 772:	06400793          	li	a5,100
 776:	02f60763          	beq	a2,a5,7a4 <vprintf+0x15c>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 77a:	07500793          	li	a5,117
 77e:	06f60963          	beq	a2,a5,7f0 <vprintf+0x1a8>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 782:	07800793          	li	a5,120
 786:	faf61ee3          	bne	a2,a5,742 <vprintf+0xfa>
        printint(fd, va_arg(ap, uint64), 16, 0);
 78a:	008b8913          	add	s2,s7,8
 78e:	4681                	li	a3,0
 790:	4641                	li	a2,16
 792:	000bb583          	ld	a1,0(s7)
 796:	855a                	mv	a0,s6
 798:	e15ff0ef          	jal	5ac <printint>
        i += 2;
 79c:	2489                	addw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 79e:	8bca                	mv	s7,s2
      state = 0;
 7a0:	4981                	li	s3,0
        i += 2;
 7a2:	bdc5                	j	692 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 7a4:	008b8913          	add	s2,s7,8
 7a8:	4685                	li	a3,1
 7aa:	4629                	li	a2,10
 7ac:	000bb583          	ld	a1,0(s7)
 7b0:	855a                	mv	a0,s6
 7b2:	dfbff0ef          	jal	5ac <printint>
        i += 2;
 7b6:	2489                	addw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 7b8:	8bca                	mv	s7,s2
      state = 0;
 7ba:	4981                	li	s3,0
        i += 2;
 7bc:	bdd9                	j	692 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint32), 10, 0);
 7be:	008b8913          	add	s2,s7,8
 7c2:	4681                	li	a3,0
 7c4:	4629                	li	a2,10
 7c6:	000be583          	lwu	a1,0(s7)
 7ca:	855a                	mv	a0,s6
 7cc:	de1ff0ef          	jal	5ac <printint>
 7d0:	8bca                	mv	s7,s2
      state = 0;
 7d2:	4981                	li	s3,0
 7d4:	bd7d                	j	692 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 7d6:	008b8913          	add	s2,s7,8
 7da:	4681                	li	a3,0
 7dc:	4629                	li	a2,10
 7de:	000bb583          	ld	a1,0(s7)
 7e2:	855a                	mv	a0,s6
 7e4:	dc9ff0ef          	jal	5ac <printint>
        i += 1;
 7e8:	2485                	addw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 7ea:	8bca                	mv	s7,s2
      state = 0;
 7ec:	4981                	li	s3,0
        i += 1;
 7ee:	b555                	j	692 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 7f0:	008b8913          	add	s2,s7,8
 7f4:	4681                	li	a3,0
 7f6:	4629                	li	a2,10
 7f8:	000bb583          	ld	a1,0(s7)
 7fc:	855a                	mv	a0,s6
 7fe:	dafff0ef          	jal	5ac <printint>
        i += 2;
 802:	2489                	addw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 804:	8bca                	mv	s7,s2
      state = 0;
 806:	4981                	li	s3,0
        i += 2;
 808:	b569                	j	692 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint32), 16, 0);
 80a:	008b8913          	add	s2,s7,8
 80e:	4681                	li	a3,0
 810:	4641                	li	a2,16
 812:	000be583          	lwu	a1,0(s7)
 816:	855a                	mv	a0,s6
 818:	d95ff0ef          	jal	5ac <printint>
 81c:	8bca                	mv	s7,s2
      state = 0;
 81e:	4981                	li	s3,0
 820:	bd8d                	j	692 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 16, 0);
 822:	008b8913          	add	s2,s7,8
 826:	4681                	li	a3,0
 828:	4641                	li	a2,16
 82a:	000bb583          	ld	a1,0(s7)
 82e:	855a                	mv	a0,s6
 830:	d7dff0ef          	jal	5ac <printint>
        i += 1;
 834:	2485                	addw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 836:	8bca                	mv	s7,s2
      state = 0;
 838:	4981                	li	s3,0
        i += 1;
 83a:	bda1                	j	692 <vprintf+0x4a>
 83c:	e06a                	sd	s10,0(sp)
        printptr(fd, va_arg(ap, uint64));
 83e:	008b8d13          	add	s10,s7,8
 842:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 846:	03000593          	li	a1,48
 84a:	855a                	mv	a0,s6
 84c:	d43ff0ef          	jal	58e <putc>
  putc(fd, 'x');
 850:	07800593          	li	a1,120
 854:	855a                	mv	a0,s6
 856:	d39ff0ef          	jal	58e <putc>
 85a:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 85c:	00000b97          	auipc	s7,0x0
 860:	2bcb8b93          	add	s7,s7,700 # b18 <digits>
 864:	03c9d793          	srl	a5,s3,0x3c
 868:	97de                	add	a5,a5,s7
 86a:	0007c583          	lbu	a1,0(a5)
 86e:	855a                	mv	a0,s6
 870:	d1fff0ef          	jal	58e <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 874:	0992                	sll	s3,s3,0x4
 876:	397d                	addw	s2,s2,-1
 878:	fe0916e3          	bnez	s2,864 <vprintf+0x21c>
        printptr(fd, va_arg(ap, uint64));
 87c:	8bea                	mv	s7,s10
      state = 0;
 87e:	4981                	li	s3,0
 880:	6d02                	ld	s10,0(sp)
 882:	bd01                	j	692 <vprintf+0x4a>
        putc(fd, va_arg(ap, uint32));
 884:	008b8913          	add	s2,s7,8
 888:	000bc583          	lbu	a1,0(s7)
 88c:	855a                	mv	a0,s6
 88e:	d01ff0ef          	jal	58e <putc>
 892:	8bca                	mv	s7,s2
      state = 0;
 894:	4981                	li	s3,0
 896:	bbf5                	j	692 <vprintf+0x4a>
        if((s = va_arg(ap, char*)) == 0)
 898:	008b8993          	add	s3,s7,8
 89c:	000bb903          	ld	s2,0(s7)
 8a0:	00090f63          	beqz	s2,8be <vprintf+0x276>
        for(; *s; s++)
 8a4:	00094583          	lbu	a1,0(s2)
 8a8:	c195                	beqz	a1,8cc <vprintf+0x284>
          putc(fd, *s);
 8aa:	855a                	mv	a0,s6
 8ac:	ce3ff0ef          	jal	58e <putc>
        for(; *s; s++)
 8b0:	0905                	add	s2,s2,1
 8b2:	00094583          	lbu	a1,0(s2)
 8b6:	f9f5                	bnez	a1,8aa <vprintf+0x262>
        if((s = va_arg(ap, char*)) == 0)
 8b8:	8bce                	mv	s7,s3
      state = 0;
 8ba:	4981                	li	s3,0
 8bc:	bbd9                	j	692 <vprintf+0x4a>
          s = "(null)";
 8be:	00000917          	auipc	s2,0x0
 8c2:	25290913          	add	s2,s2,594 # b10 <malloc+0x146>
        for(; *s; s++)
 8c6:	02800593          	li	a1,40
 8ca:	b7c5                	j	8aa <vprintf+0x262>
        if((s = va_arg(ap, char*)) == 0)
 8cc:	8bce                	mv	s7,s3
      state = 0;
 8ce:	4981                	li	s3,0
 8d0:	b3c9                	j	692 <vprintf+0x4a>
 8d2:	64a6                	ld	s1,72(sp)
 8d4:	79e2                	ld	s3,56(sp)
 8d6:	7a42                	ld	s4,48(sp)
 8d8:	7aa2                	ld	s5,40(sp)
 8da:	7b02                	ld	s6,32(sp)
 8dc:	6be2                	ld	s7,24(sp)
 8de:	6c42                	ld	s8,16(sp)
 8e0:	6ca2                	ld	s9,8(sp)
    }
  }
}
 8e2:	60e6                	ld	ra,88(sp)
 8e4:	6446                	ld	s0,80(sp)
 8e6:	6906                	ld	s2,64(sp)
 8e8:	6125                	add	sp,sp,96
 8ea:	8082                	ret

00000000000008ec <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 8ec:	715d                	add	sp,sp,-80
 8ee:	ec06                	sd	ra,24(sp)
 8f0:	e822                	sd	s0,16(sp)
 8f2:	1000                	add	s0,sp,32
 8f4:	e010                	sd	a2,0(s0)
 8f6:	e414                	sd	a3,8(s0)
 8f8:	e818                	sd	a4,16(s0)
 8fa:	ec1c                	sd	a5,24(s0)
 8fc:	03043023          	sd	a6,32(s0)
 900:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 904:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 908:	8622                	mv	a2,s0
 90a:	d3fff0ef          	jal	648 <vprintf>
}
 90e:	60e2                	ld	ra,24(sp)
 910:	6442                	ld	s0,16(sp)
 912:	6161                	add	sp,sp,80
 914:	8082                	ret

0000000000000916 <printf>:

void
printf(const char *fmt, ...)
{
 916:	711d                	add	sp,sp,-96
 918:	ec06                	sd	ra,24(sp)
 91a:	e822                	sd	s0,16(sp)
 91c:	1000                	add	s0,sp,32
 91e:	e40c                	sd	a1,8(s0)
 920:	e810                	sd	a2,16(s0)
 922:	ec14                	sd	a3,24(s0)
 924:	f018                	sd	a4,32(s0)
 926:	f41c                	sd	a5,40(s0)
 928:	03043823          	sd	a6,48(s0)
 92c:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 930:	00840613          	add	a2,s0,8
 934:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 938:	85aa                	mv	a1,a0
 93a:	4505                	li	a0,1
 93c:	d0dff0ef          	jal	648 <vprintf>
}
 940:	60e2                	ld	ra,24(sp)
 942:	6442                	ld	s0,16(sp)
 944:	6125                	add	sp,sp,96
 946:	8082                	ret

0000000000000948 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 948:	1141                	add	sp,sp,-16
 94a:	e422                	sd	s0,8(sp)
 94c:	0800                	add	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 94e:	ff050693          	add	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 952:	00000797          	auipc	a5,0x0
 956:	6ae7b783          	ld	a5,1710(a5) # 1000 <freep>
 95a:	a02d                	j	984 <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 95c:	4618                	lw	a4,8(a2)
 95e:	9f2d                	addw	a4,a4,a1
 960:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 964:	6398                	ld	a4,0(a5)
 966:	6310                	ld	a2,0(a4)
 968:	a83d                	j	9a6 <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 96a:	ff852703          	lw	a4,-8(a0)
 96e:	9f31                	addw	a4,a4,a2
 970:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 972:	ff053683          	ld	a3,-16(a0)
 976:	a091                	j	9ba <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 978:	6398                	ld	a4,0(a5)
 97a:	00e7e463          	bltu	a5,a4,982 <free+0x3a>
 97e:	00e6ea63          	bltu	a3,a4,992 <free+0x4a>
{
 982:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 984:	fed7fae3          	bgeu	a5,a3,978 <free+0x30>
 988:	6398                	ld	a4,0(a5)
 98a:	00e6e463          	bltu	a3,a4,992 <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 98e:	fee7eae3          	bltu	a5,a4,982 <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 992:	ff852583          	lw	a1,-8(a0)
 996:	6390                	ld	a2,0(a5)
 998:	02059813          	sll	a6,a1,0x20
 99c:	01c85713          	srl	a4,a6,0x1c
 9a0:	9736                	add	a4,a4,a3
 9a2:	fae60de3          	beq	a2,a4,95c <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 9a6:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 9aa:	4790                	lw	a2,8(a5)
 9ac:	02061593          	sll	a1,a2,0x20
 9b0:	01c5d713          	srl	a4,a1,0x1c
 9b4:	973e                	add	a4,a4,a5
 9b6:	fae68ae3          	beq	a3,a4,96a <free+0x22>
    p->s.ptr = bp->s.ptr;
 9ba:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 9bc:	00000717          	auipc	a4,0x0
 9c0:	64f73223          	sd	a5,1604(a4) # 1000 <freep>
}
 9c4:	6422                	ld	s0,8(sp)
 9c6:	0141                	add	sp,sp,16
 9c8:	8082                	ret

00000000000009ca <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 9ca:	7139                	add	sp,sp,-64
 9cc:	fc06                	sd	ra,56(sp)
 9ce:	f822                	sd	s0,48(sp)
 9d0:	f426                	sd	s1,40(sp)
 9d2:	ec4e                	sd	s3,24(sp)
 9d4:	0080                	add	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 9d6:	02051493          	sll	s1,a0,0x20
 9da:	9081                	srl	s1,s1,0x20
 9dc:	04bd                	add	s1,s1,15
 9de:	8091                	srl	s1,s1,0x4
 9e0:	0014899b          	addw	s3,s1,1
 9e4:	0485                	add	s1,s1,1
  if((prevp = freep) == 0){
 9e6:	00000517          	auipc	a0,0x0
 9ea:	61a53503          	ld	a0,1562(a0) # 1000 <freep>
 9ee:	c915                	beqz	a0,a22 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 9f0:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 9f2:	4798                	lw	a4,8(a5)
 9f4:	08977a63          	bgeu	a4,s1,a88 <malloc+0xbe>
 9f8:	f04a                	sd	s2,32(sp)
 9fa:	e852                	sd	s4,16(sp)
 9fc:	e456                	sd	s5,8(sp)
 9fe:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 a00:	8a4e                	mv	s4,s3
 a02:	0009871b          	sext.w	a4,s3
 a06:	6685                	lui	a3,0x1
 a08:	00d77363          	bgeu	a4,a3,a0e <malloc+0x44>
 a0c:	6a05                	lui	s4,0x1
 a0e:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 a12:	004a1a1b          	sllw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 a16:	00000917          	auipc	s2,0x0
 a1a:	5ea90913          	add	s2,s2,1514 # 1000 <freep>
  if(p == SBRK_ERROR)
 a1e:	5afd                	li	s5,-1
 a20:	a081                	j	a60 <malloc+0x96>
 a22:	f04a                	sd	s2,32(sp)
 a24:	e852                	sd	s4,16(sp)
 a26:	e456                	sd	s5,8(sp)
 a28:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 a2a:	00000797          	auipc	a5,0x0
 a2e:	5e678793          	add	a5,a5,1510 # 1010 <base>
 a32:	00000717          	auipc	a4,0x0
 a36:	5cf73723          	sd	a5,1486(a4) # 1000 <freep>
 a3a:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 a3c:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 a40:	b7c1                	j	a00 <malloc+0x36>
        prevp->s.ptr = p->s.ptr;
 a42:	6398                	ld	a4,0(a5)
 a44:	e118                	sd	a4,0(a0)
 a46:	a8a9                	j	aa0 <malloc+0xd6>
  hp->s.size = nu;
 a48:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 a4c:	0541                	add	a0,a0,16
 a4e:	efbff0ef          	jal	948 <free>
  return freep;
 a52:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 a56:	c12d                	beqz	a0,ab8 <malloc+0xee>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a58:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 a5a:	4798                	lw	a4,8(a5)
 a5c:	02977263          	bgeu	a4,s1,a80 <malloc+0xb6>
    if(p == freep)
 a60:	00093703          	ld	a4,0(s2)
 a64:	853e                	mv	a0,a5
 a66:	fef719e3          	bne	a4,a5,a58 <malloc+0x8e>
  p = sbrk(nu * sizeof(Header));
 a6a:	8552                	mv	a0,s4
 a6c:	967ff0ef          	jal	3d2 <sbrk>
  if(p == SBRK_ERROR)
 a70:	fd551ce3          	bne	a0,s5,a48 <malloc+0x7e>
        return 0;
 a74:	4501                	li	a0,0
 a76:	7902                	ld	s2,32(sp)
 a78:	6a42                	ld	s4,16(sp)
 a7a:	6aa2                	ld	s5,8(sp)
 a7c:	6b02                	ld	s6,0(sp)
 a7e:	a03d                	j	aac <malloc+0xe2>
 a80:	7902                	ld	s2,32(sp)
 a82:	6a42                	ld	s4,16(sp)
 a84:	6aa2                	ld	s5,8(sp)
 a86:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 a88:	fae48de3          	beq	s1,a4,a42 <malloc+0x78>
        p->s.size -= nunits;
 a8c:	4137073b          	subw	a4,a4,s3
 a90:	c798                	sw	a4,8(a5)
        p += p->s.size;
 a92:	02071693          	sll	a3,a4,0x20
 a96:	01c6d713          	srl	a4,a3,0x1c
 a9a:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 a9c:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 aa0:	00000717          	auipc	a4,0x0
 aa4:	56a73023          	sd	a0,1376(a4) # 1000 <freep>
      return (void*)(p + 1);
 aa8:	01078513          	add	a0,a5,16
  }
}
 aac:	70e2                	ld	ra,56(sp)
 aae:	7442                	ld	s0,48(sp)
 ab0:	74a2                	ld	s1,40(sp)
 ab2:	69e2                	ld	s3,24(sp)
 ab4:	6121                	add	sp,sp,64
 ab6:	8082                	ret
 ab8:	7902                	ld	s2,32(sp)
 aba:	6a42                	ld	s4,16(sp)
 abc:	6aa2                	ld	s5,8(sp)
 abe:	6b02                	ld	s6,0(sp)
 ac0:	b7f5                	j	aac <malloc+0xe2>
