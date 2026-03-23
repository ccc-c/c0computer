
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
  1a:	bda78793          	add	a5,a5,-1062 # bf0 <malloc+0x110>
  1e:	6398                	ld	a4,0(a5)
  20:	fce43823          	sd	a4,-48(s0)
  24:	0087d783          	lhu	a5,8(a5)
  28:	fcf41c23          	sh	a5,-40(s0)
  char data[512];

  printf("stressfs starting\n");
  2c:	00001517          	auipc	a0,0x1
  30:	b9450513          	add	a0,a0,-1132 # bc0 <malloc+0xe0>
  34:	1f9000ef          	jal	a2c <printf>
  memset(data, 'a', sizeof(data));
  38:	20000613          	li	a2,512
  3c:	06100593          	li	a1,97
  40:	dd040513          	add	a0,s0,-560
  44:	118000ef          	jal	15c <memset>

  for(i = 0; i < 4; i++)
  48:	4481                	li	s1,0
  4a:	4911                	li	s2,4
    if(fork() > 0)
  4c:	56e000ef          	jal	5ba <fork>
  50:	00a04563          	bgtz	a0,5a <main+0x5a>
  for(i = 0; i < 4; i++)
  54:	2485                	addw	s1,s1,1
  56:	ff249be3          	bne	s1,s2,4c <main+0x4c>
      break;

  printf("write %d\n", i);
  5a:	85a6                	mv	a1,s1
  5c:	00001517          	auipc	a0,0x1
  60:	b7c50513          	add	a0,a0,-1156 # bd8 <malloc+0xf8>
  64:	1c9000ef          	jal	a2c <printf>

  path[8] += i;
  68:	fd844783          	lbu	a5,-40(s0)
  6c:	9fa5                	addw	a5,a5,s1
  6e:	fcf40c23          	sb	a5,-40(s0)
  fd = open(path, O_CREATE | O_RDWR);
  72:	20200593          	li	a1,514
  76:	fd040513          	add	a0,s0,-48
  7a:	588000ef          	jal	602 <open>
  7e:	892a                	mv	s2,a0
  80:	44d1                	li	s1,20
  for(i = 0; i < 20; i++)
//    printf(fd, "%d\n", i);
    write(fd, data, sizeof(data));
  82:	20000613          	li	a2,512
  86:	dd040593          	add	a1,s0,-560
  8a:	854a                	mv	a0,s2
  8c:	556000ef          	jal	5e2 <write>
  for(i = 0; i < 20; i++)
  90:	34fd                	addw	s1,s1,-1
  92:	f8e5                	bnez	s1,82 <main+0x82>
  close(fd);
  94:	854a                	mv	a0,s2
  96:	554000ef          	jal	5ea <close>

  printf("read\n");
  9a:	00001517          	auipc	a0,0x1
  9e:	b4e50513          	add	a0,a0,-1202 # be8 <malloc+0x108>
  a2:	18b000ef          	jal	a2c <printf>

  fd = open(path, O_RDONLY);
  a6:	4581                	li	a1,0
  a8:	fd040513          	add	a0,s0,-48
  ac:	556000ef          	jal	602 <open>
  b0:	892a                	mv	s2,a0
  b2:	44d1                	li	s1,20
  for (i = 0; i < 20; i++)
    read(fd, data, sizeof(data));
  b4:	20000613          	li	a2,512
  b8:	dd040593          	add	a1,s0,-560
  bc:	854a                	mv	a0,s2
  be:	51c000ef          	jal	5da <read>
  for (i = 0; i < 20; i++)
  c2:	34fd                	addw	s1,s1,-1
  c4:	f8e5                	bnez	s1,b4 <main+0xb4>
  close(fd);
  c6:	854a                	mv	a0,s2
  c8:	522000ef          	jal	5ea <close>

  wait(0);
  cc:	4501                	li	a0,0
  ce:	4fc000ef          	jal	5ca <wait>

  exit(0);
  d2:	4501                	li	a0,0
  d4:	4ee000ef          	jal	5c2 <exit>

00000000000000d8 <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start()
{
  d8:	1141                	add	sp,sp,-16
  da:	e406                	sd	ra,8(sp)
  dc:	e022                	sd	s0,0(sp)
  de:	0800                	add	s0,sp,16
  extern int main();
  main();
  e0:	f21ff0ef          	jal	0 <main>
  exit(0);
  e4:	4501                	li	a0,0
  e6:	4dc000ef          	jal	5c2 <exit>

00000000000000ea <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
  ea:	1141                	add	sp,sp,-16
  ec:	e422                	sd	s0,8(sp)
  ee:	0800                	add	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  f0:	87aa                	mv	a5,a0
  f2:	0585                	add	a1,a1,1
  f4:	0785                	add	a5,a5,1
  f6:	fff5c703          	lbu	a4,-1(a1)
  fa:	fee78fa3          	sb	a4,-1(a5)
  fe:	fb75                	bnez	a4,f2 <strcpy+0x8>
    ;
  return os;
}
 100:	6422                	ld	s0,8(sp)
 102:	0141                	add	sp,sp,16
 104:	8082                	ret

0000000000000106 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 106:	1141                	add	sp,sp,-16
 108:	e422                	sd	s0,8(sp)
 10a:	0800                	add	s0,sp,16
  while(*p && *p == *q)
 10c:	00054783          	lbu	a5,0(a0)
 110:	cb91                	beqz	a5,124 <strcmp+0x1e>
 112:	0005c703          	lbu	a4,0(a1)
 116:	00f71763          	bne	a4,a5,124 <strcmp+0x1e>
    p++, q++;
 11a:	0505                	add	a0,a0,1
 11c:	0585                	add	a1,a1,1
  while(*p && *p == *q)
 11e:	00054783          	lbu	a5,0(a0)
 122:	fbe5                	bnez	a5,112 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 124:	0005c503          	lbu	a0,0(a1)
}
 128:	40a7853b          	subw	a0,a5,a0
 12c:	6422                	ld	s0,8(sp)
 12e:	0141                	add	sp,sp,16
 130:	8082                	ret

0000000000000132 <strlen>:

uint
strlen(const char *s)
{
 132:	1141                	add	sp,sp,-16
 134:	e422                	sd	s0,8(sp)
 136:	0800                	add	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 138:	00054783          	lbu	a5,0(a0)
 13c:	cf91                	beqz	a5,158 <strlen+0x26>
 13e:	0505                	add	a0,a0,1
 140:	87aa                	mv	a5,a0
 142:	86be                	mv	a3,a5
 144:	0785                	add	a5,a5,1
 146:	fff7c703          	lbu	a4,-1(a5)
 14a:	ff65                	bnez	a4,142 <strlen+0x10>
 14c:	40a6853b          	subw	a0,a3,a0
 150:	2505                	addw	a0,a0,1
    ;
  return n;
}
 152:	6422                	ld	s0,8(sp)
 154:	0141                	add	sp,sp,16
 156:	8082                	ret
  for(n = 0; s[n]; n++)
 158:	4501                	li	a0,0
 15a:	bfe5                	j	152 <strlen+0x20>

000000000000015c <memset>:

void*
memset(void *dst, int c, uint n)
{
 15c:	1141                	add	sp,sp,-16
 15e:	e422                	sd	s0,8(sp)
 160:	0800                	add	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 162:	ca19                	beqz	a2,178 <memset+0x1c>
 164:	87aa                	mv	a5,a0
 166:	1602                	sll	a2,a2,0x20
 168:	9201                	srl	a2,a2,0x20
 16a:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 16e:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 172:	0785                	add	a5,a5,1
 174:	fee79de3          	bne	a5,a4,16e <memset+0x12>
  }
  return dst;
}
 178:	6422                	ld	s0,8(sp)
 17a:	0141                	add	sp,sp,16
 17c:	8082                	ret

000000000000017e <strchr>:

char*
strchr(const char *s, char c)
{
 17e:	1141                	add	sp,sp,-16
 180:	e422                	sd	s0,8(sp)
 182:	0800                	add	s0,sp,16
  for(; *s; s++)
 184:	00054783          	lbu	a5,0(a0)
 188:	cb99                	beqz	a5,19e <strchr+0x20>
    if(*s == c)
 18a:	00f58763          	beq	a1,a5,198 <strchr+0x1a>
  for(; *s; s++)
 18e:	0505                	add	a0,a0,1
 190:	00054783          	lbu	a5,0(a0)
 194:	fbfd                	bnez	a5,18a <strchr+0xc>
      return (char*)s;
  return 0;
 196:	4501                	li	a0,0
}
 198:	6422                	ld	s0,8(sp)
 19a:	0141                	add	sp,sp,16
 19c:	8082                	ret
  return 0;
 19e:	4501                	li	a0,0
 1a0:	bfe5                	j	198 <strchr+0x1a>

00000000000001a2 <gets>:

char*
gets(char *buf, int max)
{
 1a2:	711d                	add	sp,sp,-96
 1a4:	ec86                	sd	ra,88(sp)
 1a6:	e8a2                	sd	s0,80(sp)
 1a8:	e4a6                	sd	s1,72(sp)
 1aa:	e0ca                	sd	s2,64(sp)
 1ac:	fc4e                	sd	s3,56(sp)
 1ae:	f852                	sd	s4,48(sp)
 1b0:	f456                	sd	s5,40(sp)
 1b2:	f05a                	sd	s6,32(sp)
 1b4:	ec5e                	sd	s7,24(sp)
 1b6:	1080                	add	s0,sp,96
 1b8:	8baa                	mv	s7,a0
 1ba:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1bc:	892a                	mv	s2,a0
 1be:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 1c0:	4aa9                	li	s5,10
 1c2:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 1c4:	89a6                	mv	s3,s1
 1c6:	2485                	addw	s1,s1,1
 1c8:	0344d663          	bge	s1,s4,1f4 <gets+0x52>
    cc = read(0, &c, 1);
 1cc:	4605                	li	a2,1
 1ce:	faf40593          	add	a1,s0,-81
 1d2:	4501                	li	a0,0
 1d4:	406000ef          	jal	5da <read>
    if(cc < 1)
 1d8:	00a05e63          	blez	a0,1f4 <gets+0x52>
    buf[i++] = c;
 1dc:	faf44783          	lbu	a5,-81(s0)
 1e0:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 1e4:	01578763          	beq	a5,s5,1f2 <gets+0x50>
 1e8:	0905                	add	s2,s2,1
 1ea:	fd679de3          	bne	a5,s6,1c4 <gets+0x22>
  for(i=0; i+1 < max; ){
 1ee:	89a6                	mv	s3,s1
 1f0:	a011                	j	1f4 <gets+0x52>
 1f2:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 1f4:	99de                	add	s3,s3,s7
 1f6:	00098023          	sb	zero,0(s3)
  return buf;
}
 1fa:	855e                	mv	a0,s7
 1fc:	60e6                	ld	ra,88(sp)
 1fe:	6446                	ld	s0,80(sp)
 200:	64a6                	ld	s1,72(sp)
 202:	6906                	ld	s2,64(sp)
 204:	79e2                	ld	s3,56(sp)
 206:	7a42                	ld	s4,48(sp)
 208:	7aa2                	ld	s5,40(sp)
 20a:	7b02                	ld	s6,32(sp)
 20c:	6be2                	ld	s7,24(sp)
 20e:	6125                	add	sp,sp,96
 210:	8082                	ret

0000000000000212 <stat>:

int
stat(const char *n, struct stat *st)
{
 212:	1101                	add	sp,sp,-32
 214:	ec06                	sd	ra,24(sp)
 216:	e822                	sd	s0,16(sp)
 218:	e426                	sd	s1,8(sp)
 21a:	e04a                	sd	s2,0(sp)
 21c:	1000                	add	s0,sp,32
 21e:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 220:	4581                	li	a1,0
 222:	3e0000ef          	jal	602 <open>
  if(fd < 0)
 226:	02054163          	bltz	a0,248 <stat+0x36>
 22a:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 22c:	85ca                	mv	a1,s2
 22e:	3ec000ef          	jal	61a <fstat>
 232:	892a                	mv	s2,a0
  close(fd);
 234:	8526                	mv	a0,s1
 236:	3b4000ef          	jal	5ea <close>
  return r;
}
 23a:	854a                	mv	a0,s2
 23c:	60e2                	ld	ra,24(sp)
 23e:	6442                	ld	s0,16(sp)
 240:	64a2                	ld	s1,8(sp)
 242:	6902                	ld	s2,0(sp)
 244:	6105                	add	sp,sp,32
 246:	8082                	ret
    return -1;
 248:	597d                	li	s2,-1
 24a:	bfc5                	j	23a <stat+0x28>

000000000000024c <atoi>:

int
atoi(const char *s)
{
 24c:	1141                	add	sp,sp,-16
 24e:	e422                	sd	s0,8(sp)
 250:	0800                	add	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 252:	00054683          	lbu	a3,0(a0)
 256:	fd06879b          	addw	a5,a3,-48
 25a:	0ff7f793          	zext.b	a5,a5
 25e:	4625                	li	a2,9
 260:	02f66863          	bltu	a2,a5,290 <atoi+0x44>
 264:	872a                	mv	a4,a0
  n = 0;
 266:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 268:	0705                	add	a4,a4,1
 26a:	0025179b          	sllw	a5,a0,0x2
 26e:	9fa9                	addw	a5,a5,a0
 270:	0017979b          	sllw	a5,a5,0x1
 274:	9fb5                	addw	a5,a5,a3
 276:	fd07851b          	addw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 27a:	00074683          	lbu	a3,0(a4)
 27e:	fd06879b          	addw	a5,a3,-48
 282:	0ff7f793          	zext.b	a5,a5
 286:	fef671e3          	bgeu	a2,a5,268 <atoi+0x1c>
  return n;
}
 28a:	6422                	ld	s0,8(sp)
 28c:	0141                	add	sp,sp,16
 28e:	8082                	ret
  n = 0;
 290:	4501                	li	a0,0
 292:	bfe5                	j	28a <atoi+0x3e>

0000000000000294 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 294:	1141                	add	sp,sp,-16
 296:	e422                	sd	s0,8(sp)
 298:	0800                	add	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 29a:	02b57463          	bgeu	a0,a1,2c2 <memmove+0x2e>
    while(n-- > 0)
 29e:	00c05f63          	blez	a2,2bc <memmove+0x28>
 2a2:	1602                	sll	a2,a2,0x20
 2a4:	9201                	srl	a2,a2,0x20
 2a6:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 2aa:	872a                	mv	a4,a0
      *dst++ = *src++;
 2ac:	0585                	add	a1,a1,1
 2ae:	0705                	add	a4,a4,1
 2b0:	fff5c683          	lbu	a3,-1(a1)
 2b4:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 2b8:	fee79ae3          	bne	a5,a4,2ac <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 2bc:	6422                	ld	s0,8(sp)
 2be:	0141                	add	sp,sp,16
 2c0:	8082                	ret
    dst += n;
 2c2:	00c50733          	add	a4,a0,a2
    src += n;
 2c6:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 2c8:	fec05ae3          	blez	a2,2bc <memmove+0x28>
 2cc:	fff6079b          	addw	a5,a2,-1
 2d0:	1782                	sll	a5,a5,0x20
 2d2:	9381                	srl	a5,a5,0x20
 2d4:	fff7c793          	not	a5,a5
 2d8:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 2da:	15fd                	add	a1,a1,-1
 2dc:	177d                	add	a4,a4,-1
 2de:	0005c683          	lbu	a3,0(a1)
 2e2:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 2e6:	fee79ae3          	bne	a5,a4,2da <memmove+0x46>
 2ea:	bfc9                	j	2bc <memmove+0x28>

00000000000002ec <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 2ec:	1141                	add	sp,sp,-16
 2ee:	e422                	sd	s0,8(sp)
 2f0:	0800                	add	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 2f2:	ca05                	beqz	a2,322 <memcmp+0x36>
 2f4:	fff6069b          	addw	a3,a2,-1
 2f8:	1682                	sll	a3,a3,0x20
 2fa:	9281                	srl	a3,a3,0x20
 2fc:	0685                	add	a3,a3,1
 2fe:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 300:	00054783          	lbu	a5,0(a0)
 304:	0005c703          	lbu	a4,0(a1)
 308:	00e79863          	bne	a5,a4,318 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 30c:	0505                	add	a0,a0,1
    p2++;
 30e:	0585                	add	a1,a1,1
  while (n-- > 0) {
 310:	fed518e3          	bne	a0,a3,300 <memcmp+0x14>
  }
  return 0;
 314:	4501                	li	a0,0
 316:	a019                	j	31c <memcmp+0x30>
      return *p1 - *p2;
 318:	40e7853b          	subw	a0,a5,a4
}
 31c:	6422                	ld	s0,8(sp)
 31e:	0141                	add	sp,sp,16
 320:	8082                	ret
  return 0;
 322:	4501                	li	a0,0
 324:	bfe5                	j	31c <memcmp+0x30>

0000000000000326 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 326:	1141                	add	sp,sp,-16
 328:	e406                	sd	ra,8(sp)
 32a:	e022                	sd	s0,0(sp)
 32c:	0800                	add	s0,sp,16
  return memmove(dst, src, n);
 32e:	f67ff0ef          	jal	294 <memmove>
}
 332:	60a2                	ld	ra,8(sp)
 334:	6402                	ld	s0,0(sp)
 336:	0141                	add	sp,sp,16
 338:	8082                	ret

000000000000033a <htons>:
    return (v & 0x000000ff) << 24 | (v & 0x0000ff00) << 8 | (v & 0x00ff0000) >> 8 | (v & 0xff000000) >> 24;
}

uint16_t
htons(uint16_t h)
{
 33a:	1141                	add	sp,sp,-16
 33c:	e422                	sd	s0,8(sp)
 33e:	0800                	add	s0,sp,16
    if (!endian) {
 340:	00001797          	auipc	a5,0x1
 344:	cc07a783          	lw	a5,-832(a5) # 1000 <endian>
 348:	e385                	bnez	a5,368 <htons+0x2e>
        endian = byteorder();
 34a:	4d200793          	li	a5,1234
 34e:	00001717          	auipc	a4,0x1
 352:	caf72923          	sw	a5,-846(a4) # 1000 <endian>
    return (v & 0x00ff) << 8 | (v & 0xff00 ) >> 8;
 356:	0085579b          	srlw	a5,a0,0x8
 35a:	0085151b          	sllw	a0,a0,0x8
 35e:	8fc9                	or	a5,a5,a0
 360:	03079513          	sll	a0,a5,0x30
 364:	9141                	srl	a0,a0,0x30
 366:	a029                	j	370 <htons+0x36>
    }
    return endian == __LITTLE_ENDIAN ? byteswap16(h) : h;
 368:	4d200713          	li	a4,1234
 36c:	fee785e3          	beq	a5,a4,356 <htons+0x1c>
}
 370:	6422                	ld	s0,8(sp)
 372:	0141                	add	sp,sp,16
 374:	8082                	ret

0000000000000376 <ntohs>:

uint16_t
ntohs(uint16_t n)
{
 376:	1141                	add	sp,sp,-16
 378:	e422                	sd	s0,8(sp)
 37a:	0800                	add	s0,sp,16
    if (!endian) {
 37c:	00001797          	auipc	a5,0x1
 380:	c847a783          	lw	a5,-892(a5) # 1000 <endian>
 384:	e385                	bnez	a5,3a4 <ntohs+0x2e>
        endian = byteorder();
 386:	4d200793          	li	a5,1234
 38a:	00001717          	auipc	a4,0x1
 38e:	c6f72b23          	sw	a5,-906(a4) # 1000 <endian>
    return (v & 0x00ff) << 8 | (v & 0xff00 ) >> 8;
 392:	0085579b          	srlw	a5,a0,0x8
 396:	0085151b          	sllw	a0,a0,0x8
 39a:	8fc9                	or	a5,a5,a0
 39c:	03079513          	sll	a0,a5,0x30
 3a0:	9141                	srl	a0,a0,0x30
 3a2:	a029                	j	3ac <ntohs+0x36>
    }
    return endian == __LITTLE_ENDIAN ? byteswap16(n) : n;
 3a4:	4d200713          	li	a4,1234
 3a8:	fee785e3          	beq	a5,a4,392 <ntohs+0x1c>
}
 3ac:	6422                	ld	s0,8(sp)
 3ae:	0141                	add	sp,sp,16
 3b0:	8082                	ret

00000000000003b2 <htonl>:

uint32_t
htonl(uint32_t h)
{
 3b2:	1141                	add	sp,sp,-16
 3b4:	e422                	sd	s0,8(sp)
 3b6:	0800                	add	s0,sp,16
    if (!endian) {
 3b8:	00001797          	auipc	a5,0x1
 3bc:	c487a783          	lw	a5,-952(a5) # 1000 <endian>
 3c0:	ef85                	bnez	a5,3f8 <htonl+0x46>
        endian = byteorder();
 3c2:	4d200793          	li	a5,1234
 3c6:	00001717          	auipc	a4,0x1
 3ca:	c2f72d23          	sw	a5,-966(a4) # 1000 <endian>
    return (v & 0x000000ff) << 24 | (v & 0x0000ff00) << 8 | (v & 0x00ff0000) >> 8 | (v & 0xff000000) >> 24;
 3ce:	0185179b          	sllw	a5,a0,0x18
 3d2:	0185571b          	srlw	a4,a0,0x18
 3d6:	8fd9                	or	a5,a5,a4
 3d8:	0085171b          	sllw	a4,a0,0x8
 3dc:	00ff06b7          	lui	a3,0xff0
 3e0:	8f75                	and	a4,a4,a3
 3e2:	8fd9                	or	a5,a5,a4
 3e4:	0085551b          	srlw	a0,a0,0x8
 3e8:	6741                	lui	a4,0x10
 3ea:	f0070713          	add	a4,a4,-256 # ff00 <base+0xeef0>
 3ee:	8d79                	and	a0,a0,a4
 3f0:	8fc9                	or	a5,a5,a0
 3f2:	0007851b          	sext.w	a0,a5
 3f6:	a029                	j	400 <htonl+0x4e>
    }
    return endian == __LITTLE_ENDIAN ? byteswap32(h) : h;
 3f8:	4d200713          	li	a4,1234
 3fc:	fce789e3          	beq	a5,a4,3ce <htonl+0x1c>
}
 400:	6422                	ld	s0,8(sp)
 402:	0141                	add	sp,sp,16
 404:	8082                	ret

0000000000000406 <ntohl>:

uint32_t
ntohl(uint32_t n)
{
 406:	1141                	add	sp,sp,-16
 408:	e422                	sd	s0,8(sp)
 40a:	0800                	add	s0,sp,16
    if (!endian) {
 40c:	00001797          	auipc	a5,0x1
 410:	bf47a783          	lw	a5,-1036(a5) # 1000 <endian>
 414:	ef85                	bnez	a5,44c <ntohl+0x46>
        endian = byteorder();
 416:	4d200793          	li	a5,1234
 41a:	00001717          	auipc	a4,0x1
 41e:	bef72323          	sw	a5,-1050(a4) # 1000 <endian>
    return (v & 0x000000ff) << 24 | (v & 0x0000ff00) << 8 | (v & 0x00ff0000) >> 8 | (v & 0xff000000) >> 24;
 422:	0185179b          	sllw	a5,a0,0x18
 426:	0185571b          	srlw	a4,a0,0x18
 42a:	8fd9                	or	a5,a5,a4
 42c:	0085171b          	sllw	a4,a0,0x8
 430:	00ff06b7          	lui	a3,0xff0
 434:	8f75                	and	a4,a4,a3
 436:	8fd9                	or	a5,a5,a4
 438:	0085551b          	srlw	a0,a0,0x8
 43c:	6741                	lui	a4,0x10
 43e:	f0070713          	add	a4,a4,-256 # ff00 <base+0xeef0>
 442:	8d79                	and	a0,a0,a4
 444:	8fc9                	or	a5,a5,a0
 446:	0007851b          	sext.w	a0,a5
 44a:	a029                	j	454 <ntohl+0x4e>
    }
    return endian == __LITTLE_ENDIAN ? byteswap32(n) : n;
 44c:	4d200713          	li	a4,1234
 450:	fce789e3          	beq	a5,a4,422 <ntohl+0x1c>
}
 454:	6422                	ld	s0,8(sp)
 456:	0141                	add	sp,sp,16
 458:	8082                	ret

000000000000045a <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
 45a:	1141                	add	sp,sp,-16
 45c:	e422                	sd	s0,8(sp)
 45e:	0800                	add	s0,sp,16
 460:	872a                	mv	a4,a0
    int neg = 0;
    long val = 0;

    // gobble initial whitespace
    while (*s == ' ' || *s == '\t')
 462:	02000693          	li	a3,32
 466:	4525                	li	a0,9
 468:	a011                	j	46c <strtol+0x12>
        s++;
 46a:	0705                	add	a4,a4,1
    while (*s == ' ' || *s == '\t')
 46c:	00074783          	lbu	a5,0(a4)
 470:	fed78de3          	beq	a5,a3,46a <strtol+0x10>
 474:	fea78be3          	beq	a5,a0,46a <strtol+0x10>

    // plus/minus sign
    if (*s == '+')
 478:	02b00693          	li	a3,43
 47c:	02d78663          	beq	a5,a3,4a8 <strtol+0x4e>
        s++;
    else if (*s == '-')
 480:	02d00693          	li	a3,45
    int neg = 0;
 484:	4301                	li	t1,0
    else if (*s == '-')
 486:	02d78463          	beq	a5,a3,4ae <strtol+0x54>
        s++, neg = 1;

    // hex or octal base prefix
    if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
 48a:	fef67793          	and	a5,a2,-17
 48e:	eb89                	bnez	a5,4a0 <strtol+0x46>
 490:	00074683          	lbu	a3,0(a4)
 494:	03000793          	li	a5,48
 498:	00f68e63          	beq	a3,a5,4b4 <strtol+0x5a>
        s += 2, base = 16;
    else if (base == 0 && s[0] == '0')
 49c:	e211                	bnez	a2,4a0 <strtol+0x46>
        s++, base = 8;
    else if (base == 0)
        base = 10;
 49e:	4629                	li	a2,10
 4a0:	4501                	li	a0,0

    // digits
    while (1) {
        int dig;

        if (*s >= '0' && *s <= '9')
 4a2:	4825                	li	a6,9
            dig = *s - '0';
        else if (*s >= 'a' && *s <= 'z')
 4a4:	48e5                	li	a7,25
 4a6:	a825                	j	4de <strtol+0x84>
        s++;
 4a8:	0705                	add	a4,a4,1
    int neg = 0;
 4aa:	4301                	li	t1,0
 4ac:	bff9                	j	48a <strtol+0x30>
        s++, neg = 1;
 4ae:	0705                	add	a4,a4,1
 4b0:	4305                	li	t1,1
 4b2:	bfe1                	j	48a <strtol+0x30>
    if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
 4b4:	00174683          	lbu	a3,1(a4)
 4b8:	07800793          	li	a5,120
 4bc:	00f68663          	beq	a3,a5,4c8 <strtol+0x6e>
    else if (base == 0 && s[0] == '0')
 4c0:	f265                	bnez	a2,4a0 <strtol+0x46>
        s++, base = 8;
 4c2:	0705                	add	a4,a4,1
 4c4:	4621                	li	a2,8
 4c6:	bfe9                	j	4a0 <strtol+0x46>
        s += 2, base = 16;
 4c8:	0709                	add	a4,a4,2
 4ca:	4641                	li	a2,16
 4cc:	bfd1                	j	4a0 <strtol+0x46>
            dig = *s - '0';
 4ce:	fd07879b          	addw	a5,a5,-48
            dig = *s - 'a' + 10;
        else if (*s >= 'A' && *s <= 'Z')
            dig = *s - 'A' + 10;
        else
            break;
        if (dig >= base)
 4d2:	04c7d063          	bge	a5,a2,512 <strtol+0xb8>
            break;
        s++, val = (val * base) + dig;
 4d6:	0705                	add	a4,a4,1
 4d8:	02a60533          	mul	a0,a2,a0
 4dc:	953e                	add	a0,a0,a5
        if (*s >= '0' && *s <= '9')
 4de:	00074783          	lbu	a5,0(a4)
 4e2:	fd07869b          	addw	a3,a5,-48
 4e6:	0ff6f693          	zext.b	a3,a3
 4ea:	fed872e3          	bgeu	a6,a3,4ce <strtol+0x74>
        else if (*s >= 'a' && *s <= 'z')
 4ee:	f9f7869b          	addw	a3,a5,-97
 4f2:	0ff6f693          	zext.b	a3,a3
 4f6:	00d8e563          	bltu	a7,a3,500 <strtol+0xa6>
            dig = *s - 'a' + 10;
 4fa:	fa97879b          	addw	a5,a5,-87
 4fe:	bfd1                	j	4d2 <strtol+0x78>
        else if (*s >= 'A' && *s <= 'Z')
 500:	fbf7869b          	addw	a3,a5,-65
 504:	0ff6f693          	zext.b	a3,a3
 508:	00d8e563          	bltu	a7,a3,512 <strtol+0xb8>
            dig = *s - 'A' + 10;
 50c:	fc97879b          	addw	a5,a5,-55
 510:	b7c9                	j	4d2 <strtol+0x78>
        // we don't properly detect overflow!
    }

    if (endptr)
 512:	c191                	beqz	a1,516 <strtol+0xbc>
        *endptr = (char *) s;
 514:	e198                	sd	a4,0(a1)
    return (neg ? -val : val);
 516:	00030463          	beqz	t1,51e <strtol+0xc4>
 51a:	40a00533          	neg	a0,a0
}
 51e:	6422                	ld	s0,8(sp)
 520:	0141                	add	sp,sp,16
 522:	8082                	ret

0000000000000524 <inet_pton>:
inet_pton (int family, const char *p, void *n) {
    char *sp, *ep;
    int idx;
    long ret;

    if (family != AF_INET) {
 524:	4785                	li	a5,1
 526:	08f51263          	bne	a0,a5,5aa <inet_pton+0x86>
inet_pton (int family, const char *p, void *n) {
 52a:	715d                	add	sp,sp,-80
 52c:	e486                	sd	ra,72(sp)
 52e:	e0a2                	sd	s0,64(sp)
 530:	fc26                	sd	s1,56(sp)
 532:	f84a                	sd	s2,48(sp)
 534:	f44e                	sd	s3,40(sp)
 536:	f052                	sd	s4,32(sp)
 538:	ec56                	sd	s5,24(sp)
 53a:	e85a                	sd	s6,16(sp)
 53c:	0880                	add	s0,sp,80
 53e:	892e                	mv	s2,a1
 540:	89b2                	mv	s3,a2
 542:	4481                	li	s1,0
        return -1;
    }
    sp = (char *)p;
    for (idx = 0; idx < 4; idx++) {
        ret = strtol(sp, &ep, 10);
        if (ret < 0 || ret > 255) {
 544:	0ff00a13          	li	s4,255
            return -1;
        }
        if (ep == sp) {
            return -1;
        }
        if ((idx == 3 && *ep != '\0') || (idx != 3 && *ep != '.')) {
 548:	4a8d                	li	s5,3
 54a:	02e00b13          	li	s6,46
 54e:	a815                	j	582 <inet_pton+0x5e>
 550:	0007c783          	lbu	a5,0(a5)
 554:	e3ad                	bnez	a5,5b6 <inet_pton+0x92>
            return -1;
        }
        ((uint8_t *)n)[idx] = ret;
 556:	2481                	sext.w	s1,s1
 558:	99a6                	add	s3,s3,s1
 55a:	00a98023          	sb	a0,0(s3)
        sp = ep + 1;
    }
    return 0;
 55e:	4501                	li	a0,0
}
 560:	60a6                	ld	ra,72(sp)
 562:	6406                	ld	s0,64(sp)
 564:	74e2                	ld	s1,56(sp)
 566:	7942                	ld	s2,48(sp)
 568:	79a2                	ld	s3,40(sp)
 56a:	7a02                	ld	s4,32(sp)
 56c:	6ae2                	ld	s5,24(sp)
 56e:	6b42                	ld	s6,16(sp)
 570:	6161                	add	sp,sp,80
 572:	8082                	ret
        ((uint8_t *)n)[idx] = ret;
 574:	00998733          	add	a4,s3,s1
 578:	00a70023          	sb	a0,0(a4)
        sp = ep + 1;
 57c:	00178913          	add	s2,a5,1
    for (idx = 0; idx < 4; idx++) {
 580:	0485                	add	s1,s1,1
        ret = strtol(sp, &ep, 10);
 582:	4629                	li	a2,10
 584:	fb840593          	add	a1,s0,-72
 588:	854a                	mv	a0,s2
 58a:	ed1ff0ef          	jal	45a <strtol>
        if (ret < 0 || ret > 255) {
 58e:	02aa6063          	bltu	s4,a0,5ae <inet_pton+0x8a>
        if (ep == sp) {
 592:	fb843783          	ld	a5,-72(s0)
 596:	01278e63          	beq	a5,s2,5b2 <inet_pton+0x8e>
        if ((idx == 3 && *ep != '\0') || (idx != 3 && *ep != '.')) {
 59a:	fb548be3          	beq	s1,s5,550 <inet_pton+0x2c>
 59e:	0007c703          	lbu	a4,0(a5)
 5a2:	fd6709e3          	beq	a4,s6,574 <inet_pton+0x50>
            return -1;
 5a6:	557d                	li	a0,-1
 5a8:	bf65                	j	560 <inet_pton+0x3c>
        return -1;
 5aa:	557d                	li	a0,-1
}
 5ac:	8082                	ret
            return -1;
 5ae:	557d                	li	a0,-1
 5b0:	bf45                	j	560 <inet_pton+0x3c>
            return -1;
 5b2:	557d                	li	a0,-1
 5b4:	b775                	j	560 <inet_pton+0x3c>
            return -1;
 5b6:	557d                	li	a0,-1
 5b8:	b765                	j	560 <inet_pton+0x3c>

00000000000005ba <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 5ba:	4885                	li	a7,1
 ecall
 5bc:	00000073          	ecall
 ret
 5c0:	8082                	ret

00000000000005c2 <exit>:
.global exit
exit:
 li a7, SYS_exit
 5c2:	4889                	li	a7,2
 ecall
 5c4:	00000073          	ecall
 ret
 5c8:	8082                	ret

00000000000005ca <wait>:
.global wait
wait:
 li a7, SYS_wait
 5ca:	488d                	li	a7,3
 ecall
 5cc:	00000073          	ecall
 ret
 5d0:	8082                	ret

00000000000005d2 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 5d2:	4891                	li	a7,4
 ecall
 5d4:	00000073          	ecall
 ret
 5d8:	8082                	ret

00000000000005da <read>:
.global read
read:
 li a7, SYS_read
 5da:	4895                	li	a7,5
 ecall
 5dc:	00000073          	ecall
 ret
 5e0:	8082                	ret

00000000000005e2 <write>:
.global write
write:
 li a7, SYS_write
 5e2:	48c1                	li	a7,16
 ecall
 5e4:	00000073          	ecall
 ret
 5e8:	8082                	ret

00000000000005ea <close>:
.global close
close:
 li a7, SYS_close
 5ea:	48d5                	li	a7,21
 ecall
 5ec:	00000073          	ecall
 ret
 5f0:	8082                	ret

00000000000005f2 <kill>:
.global kill
kill:
 li a7, SYS_kill
 5f2:	4899                	li	a7,6
 ecall
 5f4:	00000073          	ecall
 ret
 5f8:	8082                	ret

00000000000005fa <exec>:
.global exec
exec:
 li a7, SYS_exec
 5fa:	489d                	li	a7,7
 ecall
 5fc:	00000073          	ecall
 ret
 600:	8082                	ret

0000000000000602 <open>:
.global open
open:
 li a7, SYS_open
 602:	48bd                	li	a7,15
 ecall
 604:	00000073          	ecall
 ret
 608:	8082                	ret

000000000000060a <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 60a:	48c5                	li	a7,17
 ecall
 60c:	00000073          	ecall
 ret
 610:	8082                	ret

0000000000000612 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 612:	48c9                	li	a7,18
 ecall
 614:	00000073          	ecall
 ret
 618:	8082                	ret

000000000000061a <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 61a:	48a1                	li	a7,8
 ecall
 61c:	00000073          	ecall
 ret
 620:	8082                	ret

0000000000000622 <link>:
.global link
link:
 li a7, SYS_link
 622:	48cd                	li	a7,19
 ecall
 624:	00000073          	ecall
 ret
 628:	8082                	ret

000000000000062a <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 62a:	48d1                	li	a7,20
 ecall
 62c:	00000073          	ecall
 ret
 630:	8082                	ret

0000000000000632 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 632:	48a5                	li	a7,9
 ecall
 634:	00000073          	ecall
 ret
 638:	8082                	ret

000000000000063a <dup>:
.global dup
dup:
 li a7, SYS_dup
 63a:	48a9                	li	a7,10
 ecall
 63c:	00000073          	ecall
 ret
 640:	8082                	ret

0000000000000642 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 642:	48ad                	li	a7,11
 ecall
 644:	00000073          	ecall
 ret
 648:	8082                	ret

000000000000064a <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 64a:	48b1                	li	a7,12
 ecall
 64c:	00000073          	ecall
 ret
 650:	8082                	ret

0000000000000652 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 652:	48b5                	li	a7,13
 ecall
 654:	00000073          	ecall
 ret
 658:	8082                	ret

000000000000065a <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 65a:	48b9                	li	a7,14
 ecall
 65c:	00000073          	ecall
 ret
 660:	8082                	ret

0000000000000662 <socket>:
.global socket
socket:
 li a7, SYS_socket
 662:	48d9                	li	a7,22
 ecall
 664:	00000073          	ecall
 ret
 668:	8082                	ret

000000000000066a <bind>:
.global bind
bind:
 li a7, SYS_bind
 66a:	48dd                	li	a7,23
 ecall
 66c:	00000073          	ecall
 ret
 670:	8082                	ret

0000000000000672 <recvfrom>:
.global recvfrom
recvfrom:
 li a7, SYS_recvfrom
 672:	48e1                	li	a7,24
 ecall
 674:	00000073          	ecall
 ret
 678:	8082                	ret

000000000000067a <sendto>:
.global sendto
sendto:
 li a7, SYS_sendto
 67a:	48e5                	li	a7,25
 ecall
 67c:	00000073          	ecall
 ret
 680:	8082                	ret

0000000000000682 <connect>:
.global connect
connect:
 li a7, SYS_connect
 682:	48e9                	li	a7,26
 ecall
 684:	00000073          	ecall
 ret
 688:	8082                	ret

000000000000068a <listen>:
.global listen
listen:
 li a7, SYS_listen
 68a:	48ed                	li	a7,27
 ecall
 68c:	00000073          	ecall
 ret
 690:	8082                	ret

0000000000000692 <accept>:
.global accept
accept:
 li a7, SYS_accept
 692:	48f1                	li	a7,28
 ecall
 694:	00000073          	ecall
 ret
 698:	8082                	ret

000000000000069a <recv>:
.global recv
recv:
 li a7, SYS_recv
 69a:	48f5                	li	a7,29
 ecall
 69c:	00000073          	ecall
 ret
 6a0:	8082                	ret

00000000000006a2 <send>:
.global send
send:
 li a7, SYS_send
 6a2:	48f9                	li	a7,30
 ecall
 6a4:	00000073          	ecall
 ret
 6a8:	8082                	ret

00000000000006aa <ioctl>:
.global ioctl
ioctl:
 li a7, SYS_ioctl
 6aa:	48fd                	li	a7,31
 ecall
 6ac:	00000073          	ecall
 ret
 6b0:	8082                	ret

00000000000006b2 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 6b2:	1101                	add	sp,sp,-32
 6b4:	ec06                	sd	ra,24(sp)
 6b6:	e822                	sd	s0,16(sp)
 6b8:	1000                	add	s0,sp,32
 6ba:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 6be:	4605                	li	a2,1
 6c0:	fef40593          	add	a1,s0,-17
 6c4:	f1fff0ef          	jal	5e2 <write>
}
 6c8:	60e2                	ld	ra,24(sp)
 6ca:	6442                	ld	s0,16(sp)
 6cc:	6105                	add	sp,sp,32
 6ce:	8082                	ret

00000000000006d0 <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
 6d0:	715d                	add	sp,sp,-80
 6d2:	e486                	sd	ra,72(sp)
 6d4:	e0a2                	sd	s0,64(sp)
 6d6:	fc26                	sd	s1,56(sp)
 6d8:	f84a                	sd	s2,48(sp)
 6da:	f44e                	sd	s3,40(sp)
 6dc:	0880                	add	s0,sp,80
 6de:	84aa                	mv	s1,a0
  char buf[20];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 6e0:	c299                	beqz	a3,6e6 <printint+0x16>
 6e2:	0805c763          	bltz	a1,770 <printint+0xa0>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 6e6:	2581                	sext.w	a1,a1
  neg = 0;
 6e8:	4881                	li	a7,0
 6ea:	fb840693          	add	a3,s0,-72
  }

  i = 0;
 6ee:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 6f0:	2601                	sext.w	a2,a2
 6f2:	00000517          	auipc	a0,0x0
 6f6:	51650513          	add	a0,a0,1302 # c08 <digits>
 6fa:	883a                	mv	a6,a4
 6fc:	2705                	addw	a4,a4,1
 6fe:	02c5f7bb          	remuw	a5,a1,a2
 702:	1782                	sll	a5,a5,0x20
 704:	9381                	srl	a5,a5,0x20
 706:	97aa                	add	a5,a5,a0
 708:	0007c783          	lbu	a5,0(a5)
 70c:	00f68023          	sb	a5,0(a3) # ff0000 <base+0xfeeff0>
  }while((x /= base) != 0);
 710:	0005879b          	sext.w	a5,a1
 714:	02c5d5bb          	divuw	a1,a1,a2
 718:	0685                	add	a3,a3,1
 71a:	fec7f0e3          	bgeu	a5,a2,6fa <printint+0x2a>
  if(neg)
 71e:	00088c63          	beqz	a7,736 <printint+0x66>
    buf[i++] = '-';
 722:	fd070793          	add	a5,a4,-48
 726:	00878733          	add	a4,a5,s0
 72a:	02d00793          	li	a5,45
 72e:	fef70423          	sb	a5,-24(a4)
 732:	0028071b          	addw	a4,a6,2

  while(--i >= 0)
 736:	02e05663          	blez	a4,762 <printint+0x92>
 73a:	fb840793          	add	a5,s0,-72
 73e:	00e78933          	add	s2,a5,a4
 742:	fff78993          	add	s3,a5,-1
 746:	99ba                	add	s3,s3,a4
 748:	377d                	addw	a4,a4,-1
 74a:	1702                	sll	a4,a4,0x20
 74c:	9301                	srl	a4,a4,0x20
 74e:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 752:	fff94583          	lbu	a1,-1(s2)
 756:	8526                	mv	a0,s1
 758:	f5bff0ef          	jal	6b2 <putc>
  while(--i >= 0)
 75c:	197d                	add	s2,s2,-1
 75e:	ff391ae3          	bne	s2,s3,752 <printint+0x82>
}
 762:	60a6                	ld	ra,72(sp)
 764:	6406                	ld	s0,64(sp)
 766:	74e2                	ld	s1,56(sp)
 768:	7942                	ld	s2,48(sp)
 76a:	79a2                	ld	s3,40(sp)
 76c:	6161                	add	sp,sp,80
 76e:	8082                	ret
    x = -xx;
 770:	40b005bb          	negw	a1,a1
    neg = 1;
 774:	4885                	li	a7,1
    x = -xx;
 776:	bf95                	j	6ea <printint+0x1a>

0000000000000778 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 778:	711d                	add	sp,sp,-96
 77a:	ec86                	sd	ra,88(sp)
 77c:	e8a2                	sd	s0,80(sp)
 77e:	e4a6                	sd	s1,72(sp)
 780:	e0ca                	sd	s2,64(sp)
 782:	fc4e                	sd	s3,56(sp)
 784:	f852                	sd	s4,48(sp)
 786:	f456                	sd	s5,40(sp)
 788:	f05a                	sd	s6,32(sp)
 78a:	ec5e                	sd	s7,24(sp)
 78c:	e862                	sd	s8,16(sp)
 78e:	e466                	sd	s9,8(sp)
 790:	e06a                	sd	s10,0(sp)
 792:	1080                	add	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 794:	0005c903          	lbu	s2,0(a1)
 798:	24090763          	beqz	s2,9e6 <vprintf+0x26e>
 79c:	8b2a                	mv	s6,a0
 79e:	8a2e                	mv	s4,a1
 7a0:	8bb2                	mv	s7,a2
  state = 0;
 7a2:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
 7a4:	4481                	li	s1,0
 7a6:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
 7a8:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
 7ac:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
 7b0:	06c00c93          	li	s9,108
 7b4:	a005                	j	7d4 <vprintf+0x5c>
        putc(fd, c0);
 7b6:	85ca                	mv	a1,s2
 7b8:	855a                	mv	a0,s6
 7ba:	ef9ff0ef          	jal	6b2 <putc>
 7be:	a019                	j	7c4 <vprintf+0x4c>
    } else if(state == '%'){
 7c0:	03598263          	beq	s3,s5,7e4 <vprintf+0x6c>
  for(i = 0; fmt[i]; i++){
 7c4:	2485                	addw	s1,s1,1
 7c6:	8726                	mv	a4,s1
 7c8:	009a07b3          	add	a5,s4,s1
 7cc:	0007c903          	lbu	s2,0(a5)
 7d0:	20090b63          	beqz	s2,9e6 <vprintf+0x26e>
    c0 = fmt[i] & 0xff;
 7d4:	0009079b          	sext.w	a5,s2
    if(state == 0){
 7d8:	fe0994e3          	bnez	s3,7c0 <vprintf+0x48>
      if(c0 == '%'){
 7dc:	fd579de3          	bne	a5,s5,7b6 <vprintf+0x3e>
        state = '%';
 7e0:	89be                	mv	s3,a5
 7e2:	b7cd                	j	7c4 <vprintf+0x4c>
      if(c0) c1 = fmt[i+1] & 0xff;
 7e4:	c7c9                	beqz	a5,86e <vprintf+0xf6>
 7e6:	00ea06b3          	add	a3,s4,a4
 7ea:	0016c683          	lbu	a3,1(a3)
      c1 = c2 = 0;
 7ee:	8636                	mv	a2,a3
      if(c1) c2 = fmt[i+2] & 0xff;
 7f0:	c681                	beqz	a3,7f8 <vprintf+0x80>
 7f2:	9752                	add	a4,a4,s4
 7f4:	00274603          	lbu	a2,2(a4)
      if(c0 == 'd'){
 7f8:	03878f63          	beq	a5,s8,836 <vprintf+0xbe>
      } else if(c0 == 'l' && c1 == 'd'){
 7fc:	05978963          	beq	a5,s9,84e <vprintf+0xd6>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
 800:	07500713          	li	a4,117
 804:	0ee78363          	beq	a5,a4,8ea <vprintf+0x172>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
 808:	07800713          	li	a4,120
 80c:	12e78563          	beq	a5,a4,936 <vprintf+0x1be>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
 810:	07000713          	li	a4,112
 814:	14e78a63          	beq	a5,a4,968 <vprintf+0x1f0>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 's'){
 818:	07300713          	li	a4,115
 81c:	18e78863          	beq	a5,a4,9ac <vprintf+0x234>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
 820:	02500713          	li	a4,37
 824:	04e79563          	bne	a5,a4,86e <vprintf+0xf6>
        putc(fd, '%');
 828:	02500593          	li	a1,37
 82c:	855a                	mv	a0,s6
 82e:	e85ff0ef          	jal	6b2 <putc>
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
#endif
      state = 0;
 832:	4981                	li	s3,0
 834:	bf41                	j	7c4 <vprintf+0x4c>
        printint(fd, va_arg(ap, int), 10, 1);
 836:	008b8913          	add	s2,s7,8
 83a:	4685                	li	a3,1
 83c:	4629                	li	a2,10
 83e:	000ba583          	lw	a1,0(s7)
 842:	855a                	mv	a0,s6
 844:	e8dff0ef          	jal	6d0 <printint>
 848:	8bca                	mv	s7,s2
      state = 0;
 84a:	4981                	li	s3,0
 84c:	bfa5                	j	7c4 <vprintf+0x4c>
      } else if(c0 == 'l' && c1 == 'd'){
 84e:	06400793          	li	a5,100
 852:	02f68963          	beq	a3,a5,884 <vprintf+0x10c>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 856:	06c00793          	li	a5,108
 85a:	04f68263          	beq	a3,a5,89e <vprintf+0x126>
      } else if(c0 == 'l' && c1 == 'u'){
 85e:	07500793          	li	a5,117
 862:	0af68063          	beq	a3,a5,902 <vprintf+0x18a>
      } else if(c0 == 'l' && c1 == 'x'){
 866:	07800793          	li	a5,120
 86a:	0ef68263          	beq	a3,a5,94e <vprintf+0x1d6>
        putc(fd, '%');
 86e:	02500593          	li	a1,37
 872:	855a                	mv	a0,s6
 874:	e3fff0ef          	jal	6b2 <putc>
        putc(fd, c0);
 878:	85ca                	mv	a1,s2
 87a:	855a                	mv	a0,s6
 87c:	e37ff0ef          	jal	6b2 <putc>
      state = 0;
 880:	4981                	li	s3,0
 882:	b789                	j	7c4 <vprintf+0x4c>
        printint(fd, va_arg(ap, uint64), 10, 1);
 884:	008b8913          	add	s2,s7,8
 888:	4685                	li	a3,1
 88a:	4629                	li	a2,10
 88c:	000bb583          	ld	a1,0(s7)
 890:	855a                	mv	a0,s6
 892:	e3fff0ef          	jal	6d0 <printint>
        i += 1;
 896:	2485                	addw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 898:	8bca                	mv	s7,s2
      state = 0;
 89a:	4981                	li	s3,0
        i += 1;
 89c:	b725                	j	7c4 <vprintf+0x4c>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 89e:	06400793          	li	a5,100
 8a2:	02f60763          	beq	a2,a5,8d0 <vprintf+0x158>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 8a6:	07500793          	li	a5,117
 8aa:	06f60963          	beq	a2,a5,91c <vprintf+0x1a4>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 8ae:	07800793          	li	a5,120
 8b2:	faf61ee3          	bne	a2,a5,86e <vprintf+0xf6>
        printint(fd, va_arg(ap, uint64), 16, 0);
 8b6:	008b8913          	add	s2,s7,8
 8ba:	4681                	li	a3,0
 8bc:	4641                	li	a2,16
 8be:	000bb583          	ld	a1,0(s7)
 8c2:	855a                	mv	a0,s6
 8c4:	e0dff0ef          	jal	6d0 <printint>
        i += 2;
 8c8:	2489                	addw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 8ca:	8bca                	mv	s7,s2
      state = 0;
 8cc:	4981                	li	s3,0
        i += 2;
 8ce:	bddd                	j	7c4 <vprintf+0x4c>
        printint(fd, va_arg(ap, uint64), 10, 1);
 8d0:	008b8913          	add	s2,s7,8
 8d4:	4685                	li	a3,1
 8d6:	4629                	li	a2,10
 8d8:	000bb583          	ld	a1,0(s7)
 8dc:	855a                	mv	a0,s6
 8de:	df3ff0ef          	jal	6d0 <printint>
        i += 2;
 8e2:	2489                	addw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 8e4:	8bca                	mv	s7,s2
      state = 0;
 8e6:	4981                	li	s3,0
        i += 2;
 8e8:	bdf1                	j	7c4 <vprintf+0x4c>
        printint(fd, va_arg(ap, int), 10, 0);
 8ea:	008b8913          	add	s2,s7,8
 8ee:	4681                	li	a3,0
 8f0:	4629                	li	a2,10
 8f2:	000ba583          	lw	a1,0(s7)
 8f6:	855a                	mv	a0,s6
 8f8:	dd9ff0ef          	jal	6d0 <printint>
 8fc:	8bca                	mv	s7,s2
      state = 0;
 8fe:	4981                	li	s3,0
 900:	b5d1                	j	7c4 <vprintf+0x4c>
        printint(fd, va_arg(ap, uint64), 10, 0);
 902:	008b8913          	add	s2,s7,8
 906:	4681                	li	a3,0
 908:	4629                	li	a2,10
 90a:	000bb583          	ld	a1,0(s7)
 90e:	855a                	mv	a0,s6
 910:	dc1ff0ef          	jal	6d0 <printint>
        i += 1;
 914:	2485                	addw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 916:	8bca                	mv	s7,s2
      state = 0;
 918:	4981                	li	s3,0
        i += 1;
 91a:	b56d                	j	7c4 <vprintf+0x4c>
        printint(fd, va_arg(ap, uint64), 10, 0);
 91c:	008b8913          	add	s2,s7,8
 920:	4681                	li	a3,0
 922:	4629                	li	a2,10
 924:	000bb583          	ld	a1,0(s7)
 928:	855a                	mv	a0,s6
 92a:	da7ff0ef          	jal	6d0 <printint>
        i += 2;
 92e:	2489                	addw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 930:	8bca                	mv	s7,s2
      state = 0;
 932:	4981                	li	s3,0
        i += 2;
 934:	bd41                	j	7c4 <vprintf+0x4c>
        printint(fd, va_arg(ap, int), 16, 0);
 936:	008b8913          	add	s2,s7,8
 93a:	4681                	li	a3,0
 93c:	4641                	li	a2,16
 93e:	000ba583          	lw	a1,0(s7)
 942:	855a                	mv	a0,s6
 944:	d8dff0ef          	jal	6d0 <printint>
 948:	8bca                	mv	s7,s2
      state = 0;
 94a:	4981                	li	s3,0
 94c:	bda5                	j	7c4 <vprintf+0x4c>
        printint(fd, va_arg(ap, uint64), 16, 0);
 94e:	008b8913          	add	s2,s7,8
 952:	4681                	li	a3,0
 954:	4641                	li	a2,16
 956:	000bb583          	ld	a1,0(s7)
 95a:	855a                	mv	a0,s6
 95c:	d75ff0ef          	jal	6d0 <printint>
        i += 1;
 960:	2485                	addw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 962:	8bca                	mv	s7,s2
      state = 0;
 964:	4981                	li	s3,0
        i += 1;
 966:	bdb9                	j	7c4 <vprintf+0x4c>
        printptr(fd, va_arg(ap, uint64));
 968:	008b8d13          	add	s10,s7,8
 96c:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 970:	03000593          	li	a1,48
 974:	855a                	mv	a0,s6
 976:	d3dff0ef          	jal	6b2 <putc>
  putc(fd, 'x');
 97a:	07800593          	li	a1,120
 97e:	855a                	mv	a0,s6
 980:	d33ff0ef          	jal	6b2 <putc>
 984:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 986:	00000b97          	auipc	s7,0x0
 98a:	282b8b93          	add	s7,s7,642 # c08 <digits>
 98e:	03c9d793          	srl	a5,s3,0x3c
 992:	97de                	add	a5,a5,s7
 994:	0007c583          	lbu	a1,0(a5)
 998:	855a                	mv	a0,s6
 99a:	d19ff0ef          	jal	6b2 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 99e:	0992                	sll	s3,s3,0x4
 9a0:	397d                	addw	s2,s2,-1
 9a2:	fe0916e3          	bnez	s2,98e <vprintf+0x216>
        printptr(fd, va_arg(ap, uint64));
 9a6:	8bea                	mv	s7,s10
      state = 0;
 9a8:	4981                	li	s3,0
 9aa:	bd29                	j	7c4 <vprintf+0x4c>
        if((s = va_arg(ap, char*)) == 0)
 9ac:	008b8993          	add	s3,s7,8
 9b0:	000bb903          	ld	s2,0(s7)
 9b4:	00090f63          	beqz	s2,9d2 <vprintf+0x25a>
        for(; *s; s++)
 9b8:	00094583          	lbu	a1,0(s2)
 9bc:	c195                	beqz	a1,9e0 <vprintf+0x268>
          putc(fd, *s);
 9be:	855a                	mv	a0,s6
 9c0:	cf3ff0ef          	jal	6b2 <putc>
        for(; *s; s++)
 9c4:	0905                	add	s2,s2,1
 9c6:	00094583          	lbu	a1,0(s2)
 9ca:	f9f5                	bnez	a1,9be <vprintf+0x246>
        if((s = va_arg(ap, char*)) == 0)
 9cc:	8bce                	mv	s7,s3
      state = 0;
 9ce:	4981                	li	s3,0
 9d0:	bbd5                	j	7c4 <vprintf+0x4c>
          s = "(null)";
 9d2:	00000917          	auipc	s2,0x0
 9d6:	22e90913          	add	s2,s2,558 # c00 <malloc+0x120>
        for(; *s; s++)
 9da:	02800593          	li	a1,40
 9de:	b7c5                	j	9be <vprintf+0x246>
        if((s = va_arg(ap, char*)) == 0)
 9e0:	8bce                	mv	s7,s3
      state = 0;
 9e2:	4981                	li	s3,0
 9e4:	b3c5                	j	7c4 <vprintf+0x4c>
    }
  }
}
 9e6:	60e6                	ld	ra,88(sp)
 9e8:	6446                	ld	s0,80(sp)
 9ea:	64a6                	ld	s1,72(sp)
 9ec:	6906                	ld	s2,64(sp)
 9ee:	79e2                	ld	s3,56(sp)
 9f0:	7a42                	ld	s4,48(sp)
 9f2:	7aa2                	ld	s5,40(sp)
 9f4:	7b02                	ld	s6,32(sp)
 9f6:	6be2                	ld	s7,24(sp)
 9f8:	6c42                	ld	s8,16(sp)
 9fa:	6ca2                	ld	s9,8(sp)
 9fc:	6d02                	ld	s10,0(sp)
 9fe:	6125                	add	sp,sp,96
 a00:	8082                	ret

0000000000000a02 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 a02:	715d                	add	sp,sp,-80
 a04:	ec06                	sd	ra,24(sp)
 a06:	e822                	sd	s0,16(sp)
 a08:	1000                	add	s0,sp,32
 a0a:	e010                	sd	a2,0(s0)
 a0c:	e414                	sd	a3,8(s0)
 a0e:	e818                	sd	a4,16(s0)
 a10:	ec1c                	sd	a5,24(s0)
 a12:	03043023          	sd	a6,32(s0)
 a16:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 a1a:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 a1e:	8622                	mv	a2,s0
 a20:	d59ff0ef          	jal	778 <vprintf>
}
 a24:	60e2                	ld	ra,24(sp)
 a26:	6442                	ld	s0,16(sp)
 a28:	6161                	add	sp,sp,80
 a2a:	8082                	ret

0000000000000a2c <printf>:

void
printf(const char *fmt, ...)
{
 a2c:	711d                	add	sp,sp,-96
 a2e:	ec06                	sd	ra,24(sp)
 a30:	e822                	sd	s0,16(sp)
 a32:	1000                	add	s0,sp,32
 a34:	e40c                	sd	a1,8(s0)
 a36:	e810                	sd	a2,16(s0)
 a38:	ec14                	sd	a3,24(s0)
 a3a:	f018                	sd	a4,32(s0)
 a3c:	f41c                	sd	a5,40(s0)
 a3e:	03043823          	sd	a6,48(s0)
 a42:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 a46:	00840613          	add	a2,s0,8
 a4a:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 a4e:	85aa                	mv	a1,a0
 a50:	4505                	li	a0,1
 a52:	d27ff0ef          	jal	778 <vprintf>
}
 a56:	60e2                	ld	ra,24(sp)
 a58:	6442                	ld	s0,16(sp)
 a5a:	6125                	add	sp,sp,96
 a5c:	8082                	ret

0000000000000a5e <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 a5e:	1141                	add	sp,sp,-16
 a60:	e422                	sd	s0,8(sp)
 a62:	0800                	add	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 a64:	ff050693          	add	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 a68:	00000797          	auipc	a5,0x0
 a6c:	5a07b783          	ld	a5,1440(a5) # 1008 <freep>
 a70:	a02d                	j	a9a <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 a72:	4618                	lw	a4,8(a2)
 a74:	9f2d                	addw	a4,a4,a1
 a76:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 a7a:	6398                	ld	a4,0(a5)
 a7c:	6310                	ld	a2,0(a4)
 a7e:	a83d                	j	abc <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 a80:	ff852703          	lw	a4,-8(a0)
 a84:	9f31                	addw	a4,a4,a2
 a86:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 a88:	ff053683          	ld	a3,-16(a0)
 a8c:	a091                	j	ad0 <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 a8e:	6398                	ld	a4,0(a5)
 a90:	00e7e463          	bltu	a5,a4,a98 <free+0x3a>
 a94:	00e6ea63          	bltu	a3,a4,aa8 <free+0x4a>
{
 a98:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 a9a:	fed7fae3          	bgeu	a5,a3,a8e <free+0x30>
 a9e:	6398                	ld	a4,0(a5)
 aa0:	00e6e463          	bltu	a3,a4,aa8 <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 aa4:	fee7eae3          	bltu	a5,a4,a98 <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 aa8:	ff852583          	lw	a1,-8(a0)
 aac:	6390                	ld	a2,0(a5)
 aae:	02059813          	sll	a6,a1,0x20
 ab2:	01c85713          	srl	a4,a6,0x1c
 ab6:	9736                	add	a4,a4,a3
 ab8:	fae60de3          	beq	a2,a4,a72 <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 abc:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 ac0:	4790                	lw	a2,8(a5)
 ac2:	02061593          	sll	a1,a2,0x20
 ac6:	01c5d713          	srl	a4,a1,0x1c
 aca:	973e                	add	a4,a4,a5
 acc:	fae68ae3          	beq	a3,a4,a80 <free+0x22>
    p->s.ptr = bp->s.ptr;
 ad0:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 ad2:	00000717          	auipc	a4,0x0
 ad6:	52f73b23          	sd	a5,1334(a4) # 1008 <freep>
}
 ada:	6422                	ld	s0,8(sp)
 adc:	0141                	add	sp,sp,16
 ade:	8082                	ret

0000000000000ae0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 ae0:	7139                	add	sp,sp,-64
 ae2:	fc06                	sd	ra,56(sp)
 ae4:	f822                	sd	s0,48(sp)
 ae6:	f426                	sd	s1,40(sp)
 ae8:	f04a                	sd	s2,32(sp)
 aea:	ec4e                	sd	s3,24(sp)
 aec:	e852                	sd	s4,16(sp)
 aee:	e456                	sd	s5,8(sp)
 af0:	e05a                	sd	s6,0(sp)
 af2:	0080                	add	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 af4:	02051493          	sll	s1,a0,0x20
 af8:	9081                	srl	s1,s1,0x20
 afa:	04bd                	add	s1,s1,15
 afc:	8091                	srl	s1,s1,0x4
 afe:	0014899b          	addw	s3,s1,1
 b02:	0485                	add	s1,s1,1
  if((prevp = freep) == 0){
 b04:	00000517          	auipc	a0,0x0
 b08:	50453503          	ld	a0,1284(a0) # 1008 <freep>
 b0c:	c515                	beqz	a0,b38 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 b0e:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 b10:	4798                	lw	a4,8(a5)
 b12:	02977f63          	bgeu	a4,s1,b50 <malloc+0x70>
  if(nu < 4096)
 b16:	8a4e                	mv	s4,s3
 b18:	0009871b          	sext.w	a4,s3
 b1c:	6685                	lui	a3,0x1
 b1e:	00d77363          	bgeu	a4,a3,b24 <malloc+0x44>
 b22:	6a05                	lui	s4,0x1
 b24:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 b28:	004a1a1b          	sllw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 b2c:	00000917          	auipc	s2,0x0
 b30:	4dc90913          	add	s2,s2,1244 # 1008 <freep>
  if(p == (char*)-1)
 b34:	5afd                	li	s5,-1
 b36:	a885                	j	ba6 <malloc+0xc6>
    base.s.ptr = freep = prevp = &base;
 b38:	00000797          	auipc	a5,0x0
 b3c:	4d878793          	add	a5,a5,1240 # 1010 <base>
 b40:	00000717          	auipc	a4,0x0
 b44:	4cf73423          	sd	a5,1224(a4) # 1008 <freep>
 b48:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 b4a:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 b4e:	b7e1                	j	b16 <malloc+0x36>
      if(p->s.size == nunits)
 b50:	02e48c63          	beq	s1,a4,b88 <malloc+0xa8>
        p->s.size -= nunits;
 b54:	4137073b          	subw	a4,a4,s3
 b58:	c798                	sw	a4,8(a5)
        p += p->s.size;
 b5a:	02071693          	sll	a3,a4,0x20
 b5e:	01c6d713          	srl	a4,a3,0x1c
 b62:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 b64:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 b68:	00000717          	auipc	a4,0x0
 b6c:	4aa73023          	sd	a0,1184(a4) # 1008 <freep>
      return (void*)(p + 1);
 b70:	01078513          	add	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 b74:	70e2                	ld	ra,56(sp)
 b76:	7442                	ld	s0,48(sp)
 b78:	74a2                	ld	s1,40(sp)
 b7a:	7902                	ld	s2,32(sp)
 b7c:	69e2                	ld	s3,24(sp)
 b7e:	6a42                	ld	s4,16(sp)
 b80:	6aa2                	ld	s5,8(sp)
 b82:	6b02                	ld	s6,0(sp)
 b84:	6121                	add	sp,sp,64
 b86:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 b88:	6398                	ld	a4,0(a5)
 b8a:	e118                	sd	a4,0(a0)
 b8c:	bff1                	j	b68 <malloc+0x88>
  hp->s.size = nu;
 b8e:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 b92:	0541                	add	a0,a0,16
 b94:	ecbff0ef          	jal	a5e <free>
  return freep;
 b98:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 b9c:	dd61                	beqz	a0,b74 <malloc+0x94>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 b9e:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 ba0:	4798                	lw	a4,8(a5)
 ba2:	fa9777e3          	bgeu	a4,s1,b50 <malloc+0x70>
    if(p == freep)
 ba6:	00093703          	ld	a4,0(s2)
 baa:	853e                	mv	a0,a5
 bac:	fef719e3          	bne	a4,a5,b9e <malloc+0xbe>
  p = sbrk(nu * sizeof(Header));
 bb0:	8552                	mv	a0,s4
 bb2:	a99ff0ef          	jal	64a <sbrk>
  if(p == (char*)-1)
 bb6:	fd551ce3          	bne	a0,s5,b8e <malloc+0xae>
        return 0;
 bba:	4501                	li	a0,0
 bbc:	bf65                	j	b74 <malloc+0x94>
