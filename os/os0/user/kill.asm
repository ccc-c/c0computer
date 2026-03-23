
user/_kill:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/stat.h"
#include "user/user.h"

int
main(int argc, char **argv)
{
   0:	1101                	add	sp,sp,-32
   2:	ec06                	sd	ra,24(sp)
   4:	e822                	sd	s0,16(sp)
   6:	e426                	sd	s1,8(sp)
   8:	e04a                	sd	s2,0(sp)
   a:	1000                	add	s0,sp,32
  int i;

  if(argc < 2){
   c:	4785                	li	a5,1
   e:	02a7d763          	bge	a5,a0,3c <main+0x3c>
  12:	00858493          	add	s1,a1,8
  16:	ffe5091b          	addw	s2,a0,-2
  1a:	02091793          	sll	a5,s2,0x20
  1e:	01d7d913          	srl	s2,a5,0x1d
  22:	05c1                	add	a1,a1,16
  24:	992e                	add	s2,s2,a1
    fprintf(2, "usage: kill pid...\n");
    exit(1);
  }
  for(i=1; i<argc; i++)
    kill(atoi(argv[i]));
  26:	6088                	ld	a0,0(s1)
  28:	19c000ef          	jal	1c4 <atoi>
  2c:	53e000ef          	jal	56a <kill>
  for(i=1; i<argc; i++)
  30:	04a1                	add	s1,s1,8
  32:	ff249ae3          	bne	s1,s2,26 <main+0x26>
  exit(0);
  36:	4501                	li	a0,0
  38:	502000ef          	jal	53a <exit>
    fprintf(2, "usage: kill pid...\n");
  3c:	00001597          	auipc	a1,0x1
  40:	b0458593          	add	a1,a1,-1276 # b40 <malloc+0xe8>
  44:	4509                	li	a0,2
  46:	135000ef          	jal	97a <fprintf>
    exit(1);
  4a:	4505                	li	a0,1
  4c:	4ee000ef          	jal	53a <exit>

0000000000000050 <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start()
{
  50:	1141                	add	sp,sp,-16
  52:	e406                	sd	ra,8(sp)
  54:	e022                	sd	s0,0(sp)
  56:	0800                	add	s0,sp,16
  extern int main();
  main();
  58:	fa9ff0ef          	jal	0 <main>
  exit(0);
  5c:	4501                	li	a0,0
  5e:	4dc000ef          	jal	53a <exit>

0000000000000062 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
  62:	1141                	add	sp,sp,-16
  64:	e422                	sd	s0,8(sp)
  66:	0800                	add	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  68:	87aa                	mv	a5,a0
  6a:	0585                	add	a1,a1,1
  6c:	0785                	add	a5,a5,1
  6e:	fff5c703          	lbu	a4,-1(a1)
  72:	fee78fa3          	sb	a4,-1(a5)
  76:	fb75                	bnez	a4,6a <strcpy+0x8>
    ;
  return os;
}
  78:	6422                	ld	s0,8(sp)
  7a:	0141                	add	sp,sp,16
  7c:	8082                	ret

000000000000007e <strcmp>:

int
strcmp(const char *p, const char *q)
{
  7e:	1141                	add	sp,sp,-16
  80:	e422                	sd	s0,8(sp)
  82:	0800                	add	s0,sp,16
  while(*p && *p == *q)
  84:	00054783          	lbu	a5,0(a0)
  88:	cb91                	beqz	a5,9c <strcmp+0x1e>
  8a:	0005c703          	lbu	a4,0(a1)
  8e:	00f71763          	bne	a4,a5,9c <strcmp+0x1e>
    p++, q++;
  92:	0505                	add	a0,a0,1
  94:	0585                	add	a1,a1,1
  while(*p && *p == *q)
  96:	00054783          	lbu	a5,0(a0)
  9a:	fbe5                	bnez	a5,8a <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
  9c:	0005c503          	lbu	a0,0(a1)
}
  a0:	40a7853b          	subw	a0,a5,a0
  a4:	6422                	ld	s0,8(sp)
  a6:	0141                	add	sp,sp,16
  a8:	8082                	ret

00000000000000aa <strlen>:

uint
strlen(const char *s)
{
  aa:	1141                	add	sp,sp,-16
  ac:	e422                	sd	s0,8(sp)
  ae:	0800                	add	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
  b0:	00054783          	lbu	a5,0(a0)
  b4:	cf91                	beqz	a5,d0 <strlen+0x26>
  b6:	0505                	add	a0,a0,1
  b8:	87aa                	mv	a5,a0
  ba:	86be                	mv	a3,a5
  bc:	0785                	add	a5,a5,1
  be:	fff7c703          	lbu	a4,-1(a5)
  c2:	ff65                	bnez	a4,ba <strlen+0x10>
  c4:	40a6853b          	subw	a0,a3,a0
  c8:	2505                	addw	a0,a0,1
    ;
  return n;
}
  ca:	6422                	ld	s0,8(sp)
  cc:	0141                	add	sp,sp,16
  ce:	8082                	ret
  for(n = 0; s[n]; n++)
  d0:	4501                	li	a0,0
  d2:	bfe5                	j	ca <strlen+0x20>

00000000000000d4 <memset>:

void*
memset(void *dst, int c, uint n)
{
  d4:	1141                	add	sp,sp,-16
  d6:	e422                	sd	s0,8(sp)
  d8:	0800                	add	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
  da:	ca19                	beqz	a2,f0 <memset+0x1c>
  dc:	87aa                	mv	a5,a0
  de:	1602                	sll	a2,a2,0x20
  e0:	9201                	srl	a2,a2,0x20
  e2:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
  e6:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
  ea:	0785                	add	a5,a5,1
  ec:	fee79de3          	bne	a5,a4,e6 <memset+0x12>
  }
  return dst;
}
  f0:	6422                	ld	s0,8(sp)
  f2:	0141                	add	sp,sp,16
  f4:	8082                	ret

00000000000000f6 <strchr>:

char*
strchr(const char *s, char c)
{
  f6:	1141                	add	sp,sp,-16
  f8:	e422                	sd	s0,8(sp)
  fa:	0800                	add	s0,sp,16
  for(; *s; s++)
  fc:	00054783          	lbu	a5,0(a0)
 100:	cb99                	beqz	a5,116 <strchr+0x20>
    if(*s == c)
 102:	00f58763          	beq	a1,a5,110 <strchr+0x1a>
  for(; *s; s++)
 106:	0505                	add	a0,a0,1
 108:	00054783          	lbu	a5,0(a0)
 10c:	fbfd                	bnez	a5,102 <strchr+0xc>
      return (char*)s;
  return 0;
 10e:	4501                	li	a0,0
}
 110:	6422                	ld	s0,8(sp)
 112:	0141                	add	sp,sp,16
 114:	8082                	ret
  return 0;
 116:	4501                	li	a0,0
 118:	bfe5                	j	110 <strchr+0x1a>

000000000000011a <gets>:

char*
gets(char *buf, int max)
{
 11a:	711d                	add	sp,sp,-96
 11c:	ec86                	sd	ra,88(sp)
 11e:	e8a2                	sd	s0,80(sp)
 120:	e4a6                	sd	s1,72(sp)
 122:	e0ca                	sd	s2,64(sp)
 124:	fc4e                	sd	s3,56(sp)
 126:	f852                	sd	s4,48(sp)
 128:	f456                	sd	s5,40(sp)
 12a:	f05a                	sd	s6,32(sp)
 12c:	ec5e                	sd	s7,24(sp)
 12e:	1080                	add	s0,sp,96
 130:	8baa                	mv	s7,a0
 132:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 134:	892a                	mv	s2,a0
 136:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 138:	4aa9                	li	s5,10
 13a:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 13c:	89a6                	mv	s3,s1
 13e:	2485                	addw	s1,s1,1
 140:	0344d663          	bge	s1,s4,16c <gets+0x52>
    cc = read(0, &c, 1);
 144:	4605                	li	a2,1
 146:	faf40593          	add	a1,s0,-81
 14a:	4501                	li	a0,0
 14c:	406000ef          	jal	552 <read>
    if(cc < 1)
 150:	00a05e63          	blez	a0,16c <gets+0x52>
    buf[i++] = c;
 154:	faf44783          	lbu	a5,-81(s0)
 158:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 15c:	01578763          	beq	a5,s5,16a <gets+0x50>
 160:	0905                	add	s2,s2,1
 162:	fd679de3          	bne	a5,s6,13c <gets+0x22>
  for(i=0; i+1 < max; ){
 166:	89a6                	mv	s3,s1
 168:	a011                	j	16c <gets+0x52>
 16a:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 16c:	99de                	add	s3,s3,s7
 16e:	00098023          	sb	zero,0(s3)
  return buf;
}
 172:	855e                	mv	a0,s7
 174:	60e6                	ld	ra,88(sp)
 176:	6446                	ld	s0,80(sp)
 178:	64a6                	ld	s1,72(sp)
 17a:	6906                	ld	s2,64(sp)
 17c:	79e2                	ld	s3,56(sp)
 17e:	7a42                	ld	s4,48(sp)
 180:	7aa2                	ld	s5,40(sp)
 182:	7b02                	ld	s6,32(sp)
 184:	6be2                	ld	s7,24(sp)
 186:	6125                	add	sp,sp,96
 188:	8082                	ret

000000000000018a <stat>:

int
stat(const char *n, struct stat *st)
{
 18a:	1101                	add	sp,sp,-32
 18c:	ec06                	sd	ra,24(sp)
 18e:	e822                	sd	s0,16(sp)
 190:	e426                	sd	s1,8(sp)
 192:	e04a                	sd	s2,0(sp)
 194:	1000                	add	s0,sp,32
 196:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 198:	4581                	li	a1,0
 19a:	3e0000ef          	jal	57a <open>
  if(fd < 0)
 19e:	02054163          	bltz	a0,1c0 <stat+0x36>
 1a2:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 1a4:	85ca                	mv	a1,s2
 1a6:	3ec000ef          	jal	592 <fstat>
 1aa:	892a                	mv	s2,a0
  close(fd);
 1ac:	8526                	mv	a0,s1
 1ae:	3b4000ef          	jal	562 <close>
  return r;
}
 1b2:	854a                	mv	a0,s2
 1b4:	60e2                	ld	ra,24(sp)
 1b6:	6442                	ld	s0,16(sp)
 1b8:	64a2                	ld	s1,8(sp)
 1ba:	6902                	ld	s2,0(sp)
 1bc:	6105                	add	sp,sp,32
 1be:	8082                	ret
    return -1;
 1c0:	597d                	li	s2,-1
 1c2:	bfc5                	j	1b2 <stat+0x28>

00000000000001c4 <atoi>:

int
atoi(const char *s)
{
 1c4:	1141                	add	sp,sp,-16
 1c6:	e422                	sd	s0,8(sp)
 1c8:	0800                	add	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 1ca:	00054683          	lbu	a3,0(a0)
 1ce:	fd06879b          	addw	a5,a3,-48
 1d2:	0ff7f793          	zext.b	a5,a5
 1d6:	4625                	li	a2,9
 1d8:	02f66863          	bltu	a2,a5,208 <atoi+0x44>
 1dc:	872a                	mv	a4,a0
  n = 0;
 1de:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 1e0:	0705                	add	a4,a4,1
 1e2:	0025179b          	sllw	a5,a0,0x2
 1e6:	9fa9                	addw	a5,a5,a0
 1e8:	0017979b          	sllw	a5,a5,0x1
 1ec:	9fb5                	addw	a5,a5,a3
 1ee:	fd07851b          	addw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 1f2:	00074683          	lbu	a3,0(a4)
 1f6:	fd06879b          	addw	a5,a3,-48
 1fa:	0ff7f793          	zext.b	a5,a5
 1fe:	fef671e3          	bgeu	a2,a5,1e0 <atoi+0x1c>
  return n;
}
 202:	6422                	ld	s0,8(sp)
 204:	0141                	add	sp,sp,16
 206:	8082                	ret
  n = 0;
 208:	4501                	li	a0,0
 20a:	bfe5                	j	202 <atoi+0x3e>

000000000000020c <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 20c:	1141                	add	sp,sp,-16
 20e:	e422                	sd	s0,8(sp)
 210:	0800                	add	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 212:	02b57463          	bgeu	a0,a1,23a <memmove+0x2e>
    while(n-- > 0)
 216:	00c05f63          	blez	a2,234 <memmove+0x28>
 21a:	1602                	sll	a2,a2,0x20
 21c:	9201                	srl	a2,a2,0x20
 21e:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 222:	872a                	mv	a4,a0
      *dst++ = *src++;
 224:	0585                	add	a1,a1,1
 226:	0705                	add	a4,a4,1
 228:	fff5c683          	lbu	a3,-1(a1)
 22c:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 230:	fee79ae3          	bne	a5,a4,224 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 234:	6422                	ld	s0,8(sp)
 236:	0141                	add	sp,sp,16
 238:	8082                	ret
    dst += n;
 23a:	00c50733          	add	a4,a0,a2
    src += n;
 23e:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 240:	fec05ae3          	blez	a2,234 <memmove+0x28>
 244:	fff6079b          	addw	a5,a2,-1
 248:	1782                	sll	a5,a5,0x20
 24a:	9381                	srl	a5,a5,0x20
 24c:	fff7c793          	not	a5,a5
 250:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 252:	15fd                	add	a1,a1,-1
 254:	177d                	add	a4,a4,-1
 256:	0005c683          	lbu	a3,0(a1)
 25a:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 25e:	fee79ae3          	bne	a5,a4,252 <memmove+0x46>
 262:	bfc9                	j	234 <memmove+0x28>

0000000000000264 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 264:	1141                	add	sp,sp,-16
 266:	e422                	sd	s0,8(sp)
 268:	0800                	add	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 26a:	ca05                	beqz	a2,29a <memcmp+0x36>
 26c:	fff6069b          	addw	a3,a2,-1
 270:	1682                	sll	a3,a3,0x20
 272:	9281                	srl	a3,a3,0x20
 274:	0685                	add	a3,a3,1
 276:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 278:	00054783          	lbu	a5,0(a0)
 27c:	0005c703          	lbu	a4,0(a1)
 280:	00e79863          	bne	a5,a4,290 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 284:	0505                	add	a0,a0,1
    p2++;
 286:	0585                	add	a1,a1,1
  while (n-- > 0) {
 288:	fed518e3          	bne	a0,a3,278 <memcmp+0x14>
  }
  return 0;
 28c:	4501                	li	a0,0
 28e:	a019                	j	294 <memcmp+0x30>
      return *p1 - *p2;
 290:	40e7853b          	subw	a0,a5,a4
}
 294:	6422                	ld	s0,8(sp)
 296:	0141                	add	sp,sp,16
 298:	8082                	ret
  return 0;
 29a:	4501                	li	a0,0
 29c:	bfe5                	j	294 <memcmp+0x30>

000000000000029e <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 29e:	1141                	add	sp,sp,-16
 2a0:	e406                	sd	ra,8(sp)
 2a2:	e022                	sd	s0,0(sp)
 2a4:	0800                	add	s0,sp,16
  return memmove(dst, src, n);
 2a6:	f67ff0ef          	jal	20c <memmove>
}
 2aa:	60a2                	ld	ra,8(sp)
 2ac:	6402                	ld	s0,0(sp)
 2ae:	0141                	add	sp,sp,16
 2b0:	8082                	ret

00000000000002b2 <htons>:
    return (v & 0x000000ff) << 24 | (v & 0x0000ff00) << 8 | (v & 0x00ff0000) >> 8 | (v & 0xff000000) >> 24;
}

uint16_t
htons(uint16_t h)
{
 2b2:	1141                	add	sp,sp,-16
 2b4:	e422                	sd	s0,8(sp)
 2b6:	0800                	add	s0,sp,16
    if (!endian) {
 2b8:	00001797          	auipc	a5,0x1
 2bc:	d487a783          	lw	a5,-696(a5) # 1000 <endian>
 2c0:	e385                	bnez	a5,2e0 <htons+0x2e>
        endian = byteorder();
 2c2:	4d200793          	li	a5,1234
 2c6:	00001717          	auipc	a4,0x1
 2ca:	d2f72d23          	sw	a5,-710(a4) # 1000 <endian>
    return (v & 0x00ff) << 8 | (v & 0xff00 ) >> 8;
 2ce:	0085579b          	srlw	a5,a0,0x8
 2d2:	0085151b          	sllw	a0,a0,0x8
 2d6:	8fc9                	or	a5,a5,a0
 2d8:	03079513          	sll	a0,a5,0x30
 2dc:	9141                	srl	a0,a0,0x30
 2de:	a029                	j	2e8 <htons+0x36>
    }
    return endian == __LITTLE_ENDIAN ? byteswap16(h) : h;
 2e0:	4d200713          	li	a4,1234
 2e4:	fee785e3          	beq	a5,a4,2ce <htons+0x1c>
}
 2e8:	6422                	ld	s0,8(sp)
 2ea:	0141                	add	sp,sp,16
 2ec:	8082                	ret

00000000000002ee <ntohs>:

uint16_t
ntohs(uint16_t n)
{
 2ee:	1141                	add	sp,sp,-16
 2f0:	e422                	sd	s0,8(sp)
 2f2:	0800                	add	s0,sp,16
    if (!endian) {
 2f4:	00001797          	auipc	a5,0x1
 2f8:	d0c7a783          	lw	a5,-756(a5) # 1000 <endian>
 2fc:	e385                	bnez	a5,31c <ntohs+0x2e>
        endian = byteorder();
 2fe:	4d200793          	li	a5,1234
 302:	00001717          	auipc	a4,0x1
 306:	cef72f23          	sw	a5,-770(a4) # 1000 <endian>
    return (v & 0x00ff) << 8 | (v & 0xff00 ) >> 8;
 30a:	0085579b          	srlw	a5,a0,0x8
 30e:	0085151b          	sllw	a0,a0,0x8
 312:	8fc9                	or	a5,a5,a0
 314:	03079513          	sll	a0,a5,0x30
 318:	9141                	srl	a0,a0,0x30
 31a:	a029                	j	324 <ntohs+0x36>
    }
    return endian == __LITTLE_ENDIAN ? byteswap16(n) : n;
 31c:	4d200713          	li	a4,1234
 320:	fee785e3          	beq	a5,a4,30a <ntohs+0x1c>
}
 324:	6422                	ld	s0,8(sp)
 326:	0141                	add	sp,sp,16
 328:	8082                	ret

000000000000032a <htonl>:

uint32_t
htonl(uint32_t h)
{
 32a:	1141                	add	sp,sp,-16
 32c:	e422                	sd	s0,8(sp)
 32e:	0800                	add	s0,sp,16
    if (!endian) {
 330:	00001797          	auipc	a5,0x1
 334:	cd07a783          	lw	a5,-816(a5) # 1000 <endian>
 338:	ef85                	bnez	a5,370 <htonl+0x46>
        endian = byteorder();
 33a:	4d200793          	li	a5,1234
 33e:	00001717          	auipc	a4,0x1
 342:	ccf72123          	sw	a5,-830(a4) # 1000 <endian>
    return (v & 0x000000ff) << 24 | (v & 0x0000ff00) << 8 | (v & 0x00ff0000) >> 8 | (v & 0xff000000) >> 24;
 346:	0185179b          	sllw	a5,a0,0x18
 34a:	0185571b          	srlw	a4,a0,0x18
 34e:	8fd9                	or	a5,a5,a4
 350:	0085171b          	sllw	a4,a0,0x8
 354:	00ff06b7          	lui	a3,0xff0
 358:	8f75                	and	a4,a4,a3
 35a:	8fd9                	or	a5,a5,a4
 35c:	0085551b          	srlw	a0,a0,0x8
 360:	6741                	lui	a4,0x10
 362:	f0070713          	add	a4,a4,-256 # ff00 <base+0xeef0>
 366:	8d79                	and	a0,a0,a4
 368:	8fc9                	or	a5,a5,a0
 36a:	0007851b          	sext.w	a0,a5
 36e:	a029                	j	378 <htonl+0x4e>
    }
    return endian == __LITTLE_ENDIAN ? byteswap32(h) : h;
 370:	4d200713          	li	a4,1234
 374:	fce789e3          	beq	a5,a4,346 <htonl+0x1c>
}
 378:	6422                	ld	s0,8(sp)
 37a:	0141                	add	sp,sp,16
 37c:	8082                	ret

000000000000037e <ntohl>:

uint32_t
ntohl(uint32_t n)
{
 37e:	1141                	add	sp,sp,-16
 380:	e422                	sd	s0,8(sp)
 382:	0800                	add	s0,sp,16
    if (!endian) {
 384:	00001797          	auipc	a5,0x1
 388:	c7c7a783          	lw	a5,-900(a5) # 1000 <endian>
 38c:	ef85                	bnez	a5,3c4 <ntohl+0x46>
        endian = byteorder();
 38e:	4d200793          	li	a5,1234
 392:	00001717          	auipc	a4,0x1
 396:	c6f72723          	sw	a5,-914(a4) # 1000 <endian>
    return (v & 0x000000ff) << 24 | (v & 0x0000ff00) << 8 | (v & 0x00ff0000) >> 8 | (v & 0xff000000) >> 24;
 39a:	0185179b          	sllw	a5,a0,0x18
 39e:	0185571b          	srlw	a4,a0,0x18
 3a2:	8fd9                	or	a5,a5,a4
 3a4:	0085171b          	sllw	a4,a0,0x8
 3a8:	00ff06b7          	lui	a3,0xff0
 3ac:	8f75                	and	a4,a4,a3
 3ae:	8fd9                	or	a5,a5,a4
 3b0:	0085551b          	srlw	a0,a0,0x8
 3b4:	6741                	lui	a4,0x10
 3b6:	f0070713          	add	a4,a4,-256 # ff00 <base+0xeef0>
 3ba:	8d79                	and	a0,a0,a4
 3bc:	8fc9                	or	a5,a5,a0
 3be:	0007851b          	sext.w	a0,a5
 3c2:	a029                	j	3cc <ntohl+0x4e>
    }
    return endian == __LITTLE_ENDIAN ? byteswap32(n) : n;
 3c4:	4d200713          	li	a4,1234
 3c8:	fce789e3          	beq	a5,a4,39a <ntohl+0x1c>
}
 3cc:	6422                	ld	s0,8(sp)
 3ce:	0141                	add	sp,sp,16
 3d0:	8082                	ret

00000000000003d2 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
 3d2:	1141                	add	sp,sp,-16
 3d4:	e422                	sd	s0,8(sp)
 3d6:	0800                	add	s0,sp,16
 3d8:	872a                	mv	a4,a0
    int neg = 0;
    long val = 0;

    // gobble initial whitespace
    while (*s == ' ' || *s == '\t')
 3da:	02000693          	li	a3,32
 3de:	4525                	li	a0,9
 3e0:	a011                	j	3e4 <strtol+0x12>
        s++;
 3e2:	0705                	add	a4,a4,1
    while (*s == ' ' || *s == '\t')
 3e4:	00074783          	lbu	a5,0(a4)
 3e8:	fed78de3          	beq	a5,a3,3e2 <strtol+0x10>
 3ec:	fea78be3          	beq	a5,a0,3e2 <strtol+0x10>

    // plus/minus sign
    if (*s == '+')
 3f0:	02b00693          	li	a3,43
 3f4:	02d78663          	beq	a5,a3,420 <strtol+0x4e>
        s++;
    else if (*s == '-')
 3f8:	02d00693          	li	a3,45
    int neg = 0;
 3fc:	4301                	li	t1,0
    else if (*s == '-')
 3fe:	02d78463          	beq	a5,a3,426 <strtol+0x54>
        s++, neg = 1;

    // hex or octal base prefix
    if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
 402:	fef67793          	and	a5,a2,-17
 406:	eb89                	bnez	a5,418 <strtol+0x46>
 408:	00074683          	lbu	a3,0(a4)
 40c:	03000793          	li	a5,48
 410:	00f68e63          	beq	a3,a5,42c <strtol+0x5a>
        s += 2, base = 16;
    else if (base == 0 && s[0] == '0')
 414:	e211                	bnez	a2,418 <strtol+0x46>
        s++, base = 8;
    else if (base == 0)
        base = 10;
 416:	4629                	li	a2,10
 418:	4501                	li	a0,0

    // digits
    while (1) {
        int dig;

        if (*s >= '0' && *s <= '9')
 41a:	4825                	li	a6,9
            dig = *s - '0';
        else if (*s >= 'a' && *s <= 'z')
 41c:	48e5                	li	a7,25
 41e:	a825                	j	456 <strtol+0x84>
        s++;
 420:	0705                	add	a4,a4,1
    int neg = 0;
 422:	4301                	li	t1,0
 424:	bff9                	j	402 <strtol+0x30>
        s++, neg = 1;
 426:	0705                	add	a4,a4,1
 428:	4305                	li	t1,1
 42a:	bfe1                	j	402 <strtol+0x30>
    if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
 42c:	00174683          	lbu	a3,1(a4)
 430:	07800793          	li	a5,120
 434:	00f68663          	beq	a3,a5,440 <strtol+0x6e>
    else if (base == 0 && s[0] == '0')
 438:	f265                	bnez	a2,418 <strtol+0x46>
        s++, base = 8;
 43a:	0705                	add	a4,a4,1
 43c:	4621                	li	a2,8
 43e:	bfe9                	j	418 <strtol+0x46>
        s += 2, base = 16;
 440:	0709                	add	a4,a4,2
 442:	4641                	li	a2,16
 444:	bfd1                	j	418 <strtol+0x46>
            dig = *s - '0';
 446:	fd07879b          	addw	a5,a5,-48
            dig = *s - 'a' + 10;
        else if (*s >= 'A' && *s <= 'Z')
            dig = *s - 'A' + 10;
        else
            break;
        if (dig >= base)
 44a:	04c7d063          	bge	a5,a2,48a <strtol+0xb8>
            break;
        s++, val = (val * base) + dig;
 44e:	0705                	add	a4,a4,1
 450:	02a60533          	mul	a0,a2,a0
 454:	953e                	add	a0,a0,a5
        if (*s >= '0' && *s <= '9')
 456:	00074783          	lbu	a5,0(a4)
 45a:	fd07869b          	addw	a3,a5,-48
 45e:	0ff6f693          	zext.b	a3,a3
 462:	fed872e3          	bgeu	a6,a3,446 <strtol+0x74>
        else if (*s >= 'a' && *s <= 'z')
 466:	f9f7869b          	addw	a3,a5,-97
 46a:	0ff6f693          	zext.b	a3,a3
 46e:	00d8e563          	bltu	a7,a3,478 <strtol+0xa6>
            dig = *s - 'a' + 10;
 472:	fa97879b          	addw	a5,a5,-87
 476:	bfd1                	j	44a <strtol+0x78>
        else if (*s >= 'A' && *s <= 'Z')
 478:	fbf7869b          	addw	a3,a5,-65
 47c:	0ff6f693          	zext.b	a3,a3
 480:	00d8e563          	bltu	a7,a3,48a <strtol+0xb8>
            dig = *s - 'A' + 10;
 484:	fc97879b          	addw	a5,a5,-55
 488:	b7c9                	j	44a <strtol+0x78>
        // we don't properly detect overflow!
    }

    if (endptr)
 48a:	c191                	beqz	a1,48e <strtol+0xbc>
        *endptr = (char *) s;
 48c:	e198                	sd	a4,0(a1)
    return (neg ? -val : val);
 48e:	00030463          	beqz	t1,496 <strtol+0xc4>
 492:	40a00533          	neg	a0,a0
}
 496:	6422                	ld	s0,8(sp)
 498:	0141                	add	sp,sp,16
 49a:	8082                	ret

000000000000049c <inet_pton>:
inet_pton (int family, const char *p, void *n) {
    char *sp, *ep;
    int idx;
    long ret;

    if (family != AF_INET) {
 49c:	4785                	li	a5,1
 49e:	08f51263          	bne	a0,a5,522 <inet_pton+0x86>
inet_pton (int family, const char *p, void *n) {
 4a2:	715d                	add	sp,sp,-80
 4a4:	e486                	sd	ra,72(sp)
 4a6:	e0a2                	sd	s0,64(sp)
 4a8:	fc26                	sd	s1,56(sp)
 4aa:	f84a                	sd	s2,48(sp)
 4ac:	f44e                	sd	s3,40(sp)
 4ae:	f052                	sd	s4,32(sp)
 4b0:	ec56                	sd	s5,24(sp)
 4b2:	e85a                	sd	s6,16(sp)
 4b4:	0880                	add	s0,sp,80
 4b6:	892e                	mv	s2,a1
 4b8:	89b2                	mv	s3,a2
 4ba:	4481                	li	s1,0
        return -1;
    }
    sp = (char *)p;
    for (idx = 0; idx < 4; idx++) {
        ret = strtol(sp, &ep, 10);
        if (ret < 0 || ret > 255) {
 4bc:	0ff00a13          	li	s4,255
            return -1;
        }
        if (ep == sp) {
            return -1;
        }
        if ((idx == 3 && *ep != '\0') || (idx != 3 && *ep != '.')) {
 4c0:	4a8d                	li	s5,3
 4c2:	02e00b13          	li	s6,46
 4c6:	a815                	j	4fa <inet_pton+0x5e>
 4c8:	0007c783          	lbu	a5,0(a5)
 4cc:	e3ad                	bnez	a5,52e <inet_pton+0x92>
            return -1;
        }
        ((uint8_t *)n)[idx] = ret;
 4ce:	2481                	sext.w	s1,s1
 4d0:	99a6                	add	s3,s3,s1
 4d2:	00a98023          	sb	a0,0(s3)
        sp = ep + 1;
    }
    return 0;
 4d6:	4501                	li	a0,0
}
 4d8:	60a6                	ld	ra,72(sp)
 4da:	6406                	ld	s0,64(sp)
 4dc:	74e2                	ld	s1,56(sp)
 4de:	7942                	ld	s2,48(sp)
 4e0:	79a2                	ld	s3,40(sp)
 4e2:	7a02                	ld	s4,32(sp)
 4e4:	6ae2                	ld	s5,24(sp)
 4e6:	6b42                	ld	s6,16(sp)
 4e8:	6161                	add	sp,sp,80
 4ea:	8082                	ret
        ((uint8_t *)n)[idx] = ret;
 4ec:	00998733          	add	a4,s3,s1
 4f0:	00a70023          	sb	a0,0(a4)
        sp = ep + 1;
 4f4:	00178913          	add	s2,a5,1
    for (idx = 0; idx < 4; idx++) {
 4f8:	0485                	add	s1,s1,1
        ret = strtol(sp, &ep, 10);
 4fa:	4629                	li	a2,10
 4fc:	fb840593          	add	a1,s0,-72
 500:	854a                	mv	a0,s2
 502:	ed1ff0ef          	jal	3d2 <strtol>
        if (ret < 0 || ret > 255) {
 506:	02aa6063          	bltu	s4,a0,526 <inet_pton+0x8a>
        if (ep == sp) {
 50a:	fb843783          	ld	a5,-72(s0)
 50e:	01278e63          	beq	a5,s2,52a <inet_pton+0x8e>
        if ((idx == 3 && *ep != '\0') || (idx != 3 && *ep != '.')) {
 512:	fb548be3          	beq	s1,s5,4c8 <inet_pton+0x2c>
 516:	0007c703          	lbu	a4,0(a5)
 51a:	fd6709e3          	beq	a4,s6,4ec <inet_pton+0x50>
            return -1;
 51e:	557d                	li	a0,-1
 520:	bf65                	j	4d8 <inet_pton+0x3c>
        return -1;
 522:	557d                	li	a0,-1
}
 524:	8082                	ret
            return -1;
 526:	557d                	li	a0,-1
 528:	bf45                	j	4d8 <inet_pton+0x3c>
            return -1;
 52a:	557d                	li	a0,-1
 52c:	b775                	j	4d8 <inet_pton+0x3c>
            return -1;
 52e:	557d                	li	a0,-1
 530:	b765                	j	4d8 <inet_pton+0x3c>

0000000000000532 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 532:	4885                	li	a7,1
 ecall
 534:	00000073          	ecall
 ret
 538:	8082                	ret

000000000000053a <exit>:
.global exit
exit:
 li a7, SYS_exit
 53a:	4889                	li	a7,2
 ecall
 53c:	00000073          	ecall
 ret
 540:	8082                	ret

0000000000000542 <wait>:
.global wait
wait:
 li a7, SYS_wait
 542:	488d                	li	a7,3
 ecall
 544:	00000073          	ecall
 ret
 548:	8082                	ret

000000000000054a <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 54a:	4891                	li	a7,4
 ecall
 54c:	00000073          	ecall
 ret
 550:	8082                	ret

0000000000000552 <read>:
.global read
read:
 li a7, SYS_read
 552:	4895                	li	a7,5
 ecall
 554:	00000073          	ecall
 ret
 558:	8082                	ret

000000000000055a <write>:
.global write
write:
 li a7, SYS_write
 55a:	48c1                	li	a7,16
 ecall
 55c:	00000073          	ecall
 ret
 560:	8082                	ret

0000000000000562 <close>:
.global close
close:
 li a7, SYS_close
 562:	48d5                	li	a7,21
 ecall
 564:	00000073          	ecall
 ret
 568:	8082                	ret

000000000000056a <kill>:
.global kill
kill:
 li a7, SYS_kill
 56a:	4899                	li	a7,6
 ecall
 56c:	00000073          	ecall
 ret
 570:	8082                	ret

0000000000000572 <exec>:
.global exec
exec:
 li a7, SYS_exec
 572:	489d                	li	a7,7
 ecall
 574:	00000073          	ecall
 ret
 578:	8082                	ret

000000000000057a <open>:
.global open
open:
 li a7, SYS_open
 57a:	48bd                	li	a7,15
 ecall
 57c:	00000073          	ecall
 ret
 580:	8082                	ret

0000000000000582 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 582:	48c5                	li	a7,17
 ecall
 584:	00000073          	ecall
 ret
 588:	8082                	ret

000000000000058a <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 58a:	48c9                	li	a7,18
 ecall
 58c:	00000073          	ecall
 ret
 590:	8082                	ret

0000000000000592 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 592:	48a1                	li	a7,8
 ecall
 594:	00000073          	ecall
 ret
 598:	8082                	ret

000000000000059a <link>:
.global link
link:
 li a7, SYS_link
 59a:	48cd                	li	a7,19
 ecall
 59c:	00000073          	ecall
 ret
 5a0:	8082                	ret

00000000000005a2 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 5a2:	48d1                	li	a7,20
 ecall
 5a4:	00000073          	ecall
 ret
 5a8:	8082                	ret

00000000000005aa <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 5aa:	48a5                	li	a7,9
 ecall
 5ac:	00000073          	ecall
 ret
 5b0:	8082                	ret

00000000000005b2 <dup>:
.global dup
dup:
 li a7, SYS_dup
 5b2:	48a9                	li	a7,10
 ecall
 5b4:	00000073          	ecall
 ret
 5b8:	8082                	ret

00000000000005ba <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 5ba:	48ad                	li	a7,11
 ecall
 5bc:	00000073          	ecall
 ret
 5c0:	8082                	ret

00000000000005c2 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 5c2:	48b1                	li	a7,12
 ecall
 5c4:	00000073          	ecall
 ret
 5c8:	8082                	ret

00000000000005ca <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 5ca:	48b5                	li	a7,13
 ecall
 5cc:	00000073          	ecall
 ret
 5d0:	8082                	ret

00000000000005d2 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 5d2:	48b9                	li	a7,14
 ecall
 5d4:	00000073          	ecall
 ret
 5d8:	8082                	ret

00000000000005da <socket>:
.global socket
socket:
 li a7, SYS_socket
 5da:	48d9                	li	a7,22
 ecall
 5dc:	00000073          	ecall
 ret
 5e0:	8082                	ret

00000000000005e2 <bind>:
.global bind
bind:
 li a7, SYS_bind
 5e2:	48dd                	li	a7,23
 ecall
 5e4:	00000073          	ecall
 ret
 5e8:	8082                	ret

00000000000005ea <recvfrom>:
.global recvfrom
recvfrom:
 li a7, SYS_recvfrom
 5ea:	48e1                	li	a7,24
 ecall
 5ec:	00000073          	ecall
 ret
 5f0:	8082                	ret

00000000000005f2 <sendto>:
.global sendto
sendto:
 li a7, SYS_sendto
 5f2:	48e5                	li	a7,25
 ecall
 5f4:	00000073          	ecall
 ret
 5f8:	8082                	ret

00000000000005fa <connect>:
.global connect
connect:
 li a7, SYS_connect
 5fa:	48e9                	li	a7,26
 ecall
 5fc:	00000073          	ecall
 ret
 600:	8082                	ret

0000000000000602 <listen>:
.global listen
listen:
 li a7, SYS_listen
 602:	48ed                	li	a7,27
 ecall
 604:	00000073          	ecall
 ret
 608:	8082                	ret

000000000000060a <accept>:
.global accept
accept:
 li a7, SYS_accept
 60a:	48f1                	li	a7,28
 ecall
 60c:	00000073          	ecall
 ret
 610:	8082                	ret

0000000000000612 <recv>:
.global recv
recv:
 li a7, SYS_recv
 612:	48f5                	li	a7,29
 ecall
 614:	00000073          	ecall
 ret
 618:	8082                	ret

000000000000061a <send>:
.global send
send:
 li a7, SYS_send
 61a:	48f9                	li	a7,30
 ecall
 61c:	00000073          	ecall
 ret
 620:	8082                	ret

0000000000000622 <ioctl>:
.global ioctl
ioctl:
 li a7, SYS_ioctl
 622:	48fd                	li	a7,31
 ecall
 624:	00000073          	ecall
 ret
 628:	8082                	ret

000000000000062a <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 62a:	1101                	add	sp,sp,-32
 62c:	ec06                	sd	ra,24(sp)
 62e:	e822                	sd	s0,16(sp)
 630:	1000                	add	s0,sp,32
 632:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 636:	4605                	li	a2,1
 638:	fef40593          	add	a1,s0,-17
 63c:	f1fff0ef          	jal	55a <write>
}
 640:	60e2                	ld	ra,24(sp)
 642:	6442                	ld	s0,16(sp)
 644:	6105                	add	sp,sp,32
 646:	8082                	ret

0000000000000648 <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
 648:	715d                	add	sp,sp,-80
 64a:	e486                	sd	ra,72(sp)
 64c:	e0a2                	sd	s0,64(sp)
 64e:	fc26                	sd	s1,56(sp)
 650:	f84a                	sd	s2,48(sp)
 652:	f44e                	sd	s3,40(sp)
 654:	0880                	add	s0,sp,80
 656:	84aa                	mv	s1,a0
  char buf[20];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 658:	c299                	beqz	a3,65e <printint+0x16>
 65a:	0805c763          	bltz	a1,6e8 <printint+0xa0>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 65e:	2581                	sext.w	a1,a1
  neg = 0;
 660:	4881                	li	a7,0
 662:	fb840693          	add	a3,s0,-72
  }

  i = 0;
 666:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 668:	2601                	sext.w	a2,a2
 66a:	00000517          	auipc	a0,0x0
 66e:	4f650513          	add	a0,a0,1270 # b60 <digits>
 672:	883a                	mv	a6,a4
 674:	2705                	addw	a4,a4,1
 676:	02c5f7bb          	remuw	a5,a1,a2
 67a:	1782                	sll	a5,a5,0x20
 67c:	9381                	srl	a5,a5,0x20
 67e:	97aa                	add	a5,a5,a0
 680:	0007c783          	lbu	a5,0(a5)
 684:	00f68023          	sb	a5,0(a3) # ff0000 <base+0xfeeff0>
  }while((x /= base) != 0);
 688:	0005879b          	sext.w	a5,a1
 68c:	02c5d5bb          	divuw	a1,a1,a2
 690:	0685                	add	a3,a3,1
 692:	fec7f0e3          	bgeu	a5,a2,672 <printint+0x2a>
  if(neg)
 696:	00088c63          	beqz	a7,6ae <printint+0x66>
    buf[i++] = '-';
 69a:	fd070793          	add	a5,a4,-48
 69e:	00878733          	add	a4,a5,s0
 6a2:	02d00793          	li	a5,45
 6a6:	fef70423          	sb	a5,-24(a4)
 6aa:	0028071b          	addw	a4,a6,2

  while(--i >= 0)
 6ae:	02e05663          	blez	a4,6da <printint+0x92>
 6b2:	fb840793          	add	a5,s0,-72
 6b6:	00e78933          	add	s2,a5,a4
 6ba:	fff78993          	add	s3,a5,-1
 6be:	99ba                	add	s3,s3,a4
 6c0:	377d                	addw	a4,a4,-1
 6c2:	1702                	sll	a4,a4,0x20
 6c4:	9301                	srl	a4,a4,0x20
 6c6:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 6ca:	fff94583          	lbu	a1,-1(s2)
 6ce:	8526                	mv	a0,s1
 6d0:	f5bff0ef          	jal	62a <putc>
  while(--i >= 0)
 6d4:	197d                	add	s2,s2,-1
 6d6:	ff391ae3          	bne	s2,s3,6ca <printint+0x82>
}
 6da:	60a6                	ld	ra,72(sp)
 6dc:	6406                	ld	s0,64(sp)
 6de:	74e2                	ld	s1,56(sp)
 6e0:	7942                	ld	s2,48(sp)
 6e2:	79a2                	ld	s3,40(sp)
 6e4:	6161                	add	sp,sp,80
 6e6:	8082                	ret
    x = -xx;
 6e8:	40b005bb          	negw	a1,a1
    neg = 1;
 6ec:	4885                	li	a7,1
    x = -xx;
 6ee:	bf95                	j	662 <printint+0x1a>

00000000000006f0 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 6f0:	711d                	add	sp,sp,-96
 6f2:	ec86                	sd	ra,88(sp)
 6f4:	e8a2                	sd	s0,80(sp)
 6f6:	e4a6                	sd	s1,72(sp)
 6f8:	e0ca                	sd	s2,64(sp)
 6fa:	fc4e                	sd	s3,56(sp)
 6fc:	f852                	sd	s4,48(sp)
 6fe:	f456                	sd	s5,40(sp)
 700:	f05a                	sd	s6,32(sp)
 702:	ec5e                	sd	s7,24(sp)
 704:	e862                	sd	s8,16(sp)
 706:	e466                	sd	s9,8(sp)
 708:	e06a                	sd	s10,0(sp)
 70a:	1080                	add	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 70c:	0005c903          	lbu	s2,0(a1)
 710:	24090763          	beqz	s2,95e <vprintf+0x26e>
 714:	8b2a                	mv	s6,a0
 716:	8a2e                	mv	s4,a1
 718:	8bb2                	mv	s7,a2
  state = 0;
 71a:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
 71c:	4481                	li	s1,0
 71e:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
 720:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
 724:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
 728:	06c00c93          	li	s9,108
 72c:	a005                	j	74c <vprintf+0x5c>
        putc(fd, c0);
 72e:	85ca                	mv	a1,s2
 730:	855a                	mv	a0,s6
 732:	ef9ff0ef          	jal	62a <putc>
 736:	a019                	j	73c <vprintf+0x4c>
    } else if(state == '%'){
 738:	03598263          	beq	s3,s5,75c <vprintf+0x6c>
  for(i = 0; fmt[i]; i++){
 73c:	2485                	addw	s1,s1,1
 73e:	8726                	mv	a4,s1
 740:	009a07b3          	add	a5,s4,s1
 744:	0007c903          	lbu	s2,0(a5)
 748:	20090b63          	beqz	s2,95e <vprintf+0x26e>
    c0 = fmt[i] & 0xff;
 74c:	0009079b          	sext.w	a5,s2
    if(state == 0){
 750:	fe0994e3          	bnez	s3,738 <vprintf+0x48>
      if(c0 == '%'){
 754:	fd579de3          	bne	a5,s5,72e <vprintf+0x3e>
        state = '%';
 758:	89be                	mv	s3,a5
 75a:	b7cd                	j	73c <vprintf+0x4c>
      if(c0) c1 = fmt[i+1] & 0xff;
 75c:	c7c9                	beqz	a5,7e6 <vprintf+0xf6>
 75e:	00ea06b3          	add	a3,s4,a4
 762:	0016c683          	lbu	a3,1(a3)
      c1 = c2 = 0;
 766:	8636                	mv	a2,a3
      if(c1) c2 = fmt[i+2] & 0xff;
 768:	c681                	beqz	a3,770 <vprintf+0x80>
 76a:	9752                	add	a4,a4,s4
 76c:	00274603          	lbu	a2,2(a4)
      if(c0 == 'd'){
 770:	03878f63          	beq	a5,s8,7ae <vprintf+0xbe>
      } else if(c0 == 'l' && c1 == 'd'){
 774:	05978963          	beq	a5,s9,7c6 <vprintf+0xd6>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
 778:	07500713          	li	a4,117
 77c:	0ee78363          	beq	a5,a4,862 <vprintf+0x172>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
 780:	07800713          	li	a4,120
 784:	12e78563          	beq	a5,a4,8ae <vprintf+0x1be>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
 788:	07000713          	li	a4,112
 78c:	14e78a63          	beq	a5,a4,8e0 <vprintf+0x1f0>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 's'){
 790:	07300713          	li	a4,115
 794:	18e78863          	beq	a5,a4,924 <vprintf+0x234>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
 798:	02500713          	li	a4,37
 79c:	04e79563          	bne	a5,a4,7e6 <vprintf+0xf6>
        putc(fd, '%');
 7a0:	02500593          	li	a1,37
 7a4:	855a                	mv	a0,s6
 7a6:	e85ff0ef          	jal	62a <putc>
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
#endif
      state = 0;
 7aa:	4981                	li	s3,0
 7ac:	bf41                	j	73c <vprintf+0x4c>
        printint(fd, va_arg(ap, int), 10, 1);
 7ae:	008b8913          	add	s2,s7,8
 7b2:	4685                	li	a3,1
 7b4:	4629                	li	a2,10
 7b6:	000ba583          	lw	a1,0(s7)
 7ba:	855a                	mv	a0,s6
 7bc:	e8dff0ef          	jal	648 <printint>
 7c0:	8bca                	mv	s7,s2
      state = 0;
 7c2:	4981                	li	s3,0
 7c4:	bfa5                	j	73c <vprintf+0x4c>
      } else if(c0 == 'l' && c1 == 'd'){
 7c6:	06400793          	li	a5,100
 7ca:	02f68963          	beq	a3,a5,7fc <vprintf+0x10c>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 7ce:	06c00793          	li	a5,108
 7d2:	04f68263          	beq	a3,a5,816 <vprintf+0x126>
      } else if(c0 == 'l' && c1 == 'u'){
 7d6:	07500793          	li	a5,117
 7da:	0af68063          	beq	a3,a5,87a <vprintf+0x18a>
      } else if(c0 == 'l' && c1 == 'x'){
 7de:	07800793          	li	a5,120
 7e2:	0ef68263          	beq	a3,a5,8c6 <vprintf+0x1d6>
        putc(fd, '%');
 7e6:	02500593          	li	a1,37
 7ea:	855a                	mv	a0,s6
 7ec:	e3fff0ef          	jal	62a <putc>
        putc(fd, c0);
 7f0:	85ca                	mv	a1,s2
 7f2:	855a                	mv	a0,s6
 7f4:	e37ff0ef          	jal	62a <putc>
      state = 0;
 7f8:	4981                	li	s3,0
 7fa:	b789                	j	73c <vprintf+0x4c>
        printint(fd, va_arg(ap, uint64), 10, 1);
 7fc:	008b8913          	add	s2,s7,8
 800:	4685                	li	a3,1
 802:	4629                	li	a2,10
 804:	000bb583          	ld	a1,0(s7)
 808:	855a                	mv	a0,s6
 80a:	e3fff0ef          	jal	648 <printint>
        i += 1;
 80e:	2485                	addw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 810:	8bca                	mv	s7,s2
      state = 0;
 812:	4981                	li	s3,0
        i += 1;
 814:	b725                	j	73c <vprintf+0x4c>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 816:	06400793          	li	a5,100
 81a:	02f60763          	beq	a2,a5,848 <vprintf+0x158>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 81e:	07500793          	li	a5,117
 822:	06f60963          	beq	a2,a5,894 <vprintf+0x1a4>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 826:	07800793          	li	a5,120
 82a:	faf61ee3          	bne	a2,a5,7e6 <vprintf+0xf6>
        printint(fd, va_arg(ap, uint64), 16, 0);
 82e:	008b8913          	add	s2,s7,8
 832:	4681                	li	a3,0
 834:	4641                	li	a2,16
 836:	000bb583          	ld	a1,0(s7)
 83a:	855a                	mv	a0,s6
 83c:	e0dff0ef          	jal	648 <printint>
        i += 2;
 840:	2489                	addw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 842:	8bca                	mv	s7,s2
      state = 0;
 844:	4981                	li	s3,0
        i += 2;
 846:	bddd                	j	73c <vprintf+0x4c>
        printint(fd, va_arg(ap, uint64), 10, 1);
 848:	008b8913          	add	s2,s7,8
 84c:	4685                	li	a3,1
 84e:	4629                	li	a2,10
 850:	000bb583          	ld	a1,0(s7)
 854:	855a                	mv	a0,s6
 856:	df3ff0ef          	jal	648 <printint>
        i += 2;
 85a:	2489                	addw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 85c:	8bca                	mv	s7,s2
      state = 0;
 85e:	4981                	li	s3,0
        i += 2;
 860:	bdf1                	j	73c <vprintf+0x4c>
        printint(fd, va_arg(ap, int), 10, 0);
 862:	008b8913          	add	s2,s7,8
 866:	4681                	li	a3,0
 868:	4629                	li	a2,10
 86a:	000ba583          	lw	a1,0(s7)
 86e:	855a                	mv	a0,s6
 870:	dd9ff0ef          	jal	648 <printint>
 874:	8bca                	mv	s7,s2
      state = 0;
 876:	4981                	li	s3,0
 878:	b5d1                	j	73c <vprintf+0x4c>
        printint(fd, va_arg(ap, uint64), 10, 0);
 87a:	008b8913          	add	s2,s7,8
 87e:	4681                	li	a3,0
 880:	4629                	li	a2,10
 882:	000bb583          	ld	a1,0(s7)
 886:	855a                	mv	a0,s6
 888:	dc1ff0ef          	jal	648 <printint>
        i += 1;
 88c:	2485                	addw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 88e:	8bca                	mv	s7,s2
      state = 0;
 890:	4981                	li	s3,0
        i += 1;
 892:	b56d                	j	73c <vprintf+0x4c>
        printint(fd, va_arg(ap, uint64), 10, 0);
 894:	008b8913          	add	s2,s7,8
 898:	4681                	li	a3,0
 89a:	4629                	li	a2,10
 89c:	000bb583          	ld	a1,0(s7)
 8a0:	855a                	mv	a0,s6
 8a2:	da7ff0ef          	jal	648 <printint>
        i += 2;
 8a6:	2489                	addw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 8a8:	8bca                	mv	s7,s2
      state = 0;
 8aa:	4981                	li	s3,0
        i += 2;
 8ac:	bd41                	j	73c <vprintf+0x4c>
        printint(fd, va_arg(ap, int), 16, 0);
 8ae:	008b8913          	add	s2,s7,8
 8b2:	4681                	li	a3,0
 8b4:	4641                	li	a2,16
 8b6:	000ba583          	lw	a1,0(s7)
 8ba:	855a                	mv	a0,s6
 8bc:	d8dff0ef          	jal	648 <printint>
 8c0:	8bca                	mv	s7,s2
      state = 0;
 8c2:	4981                	li	s3,0
 8c4:	bda5                	j	73c <vprintf+0x4c>
        printint(fd, va_arg(ap, uint64), 16, 0);
 8c6:	008b8913          	add	s2,s7,8
 8ca:	4681                	li	a3,0
 8cc:	4641                	li	a2,16
 8ce:	000bb583          	ld	a1,0(s7)
 8d2:	855a                	mv	a0,s6
 8d4:	d75ff0ef          	jal	648 <printint>
        i += 1;
 8d8:	2485                	addw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 8da:	8bca                	mv	s7,s2
      state = 0;
 8dc:	4981                	li	s3,0
        i += 1;
 8de:	bdb9                	j	73c <vprintf+0x4c>
        printptr(fd, va_arg(ap, uint64));
 8e0:	008b8d13          	add	s10,s7,8
 8e4:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 8e8:	03000593          	li	a1,48
 8ec:	855a                	mv	a0,s6
 8ee:	d3dff0ef          	jal	62a <putc>
  putc(fd, 'x');
 8f2:	07800593          	li	a1,120
 8f6:	855a                	mv	a0,s6
 8f8:	d33ff0ef          	jal	62a <putc>
 8fc:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 8fe:	00000b97          	auipc	s7,0x0
 902:	262b8b93          	add	s7,s7,610 # b60 <digits>
 906:	03c9d793          	srl	a5,s3,0x3c
 90a:	97de                	add	a5,a5,s7
 90c:	0007c583          	lbu	a1,0(a5)
 910:	855a                	mv	a0,s6
 912:	d19ff0ef          	jal	62a <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 916:	0992                	sll	s3,s3,0x4
 918:	397d                	addw	s2,s2,-1
 91a:	fe0916e3          	bnez	s2,906 <vprintf+0x216>
        printptr(fd, va_arg(ap, uint64));
 91e:	8bea                	mv	s7,s10
      state = 0;
 920:	4981                	li	s3,0
 922:	bd29                	j	73c <vprintf+0x4c>
        if((s = va_arg(ap, char*)) == 0)
 924:	008b8993          	add	s3,s7,8
 928:	000bb903          	ld	s2,0(s7)
 92c:	00090f63          	beqz	s2,94a <vprintf+0x25a>
        for(; *s; s++)
 930:	00094583          	lbu	a1,0(s2)
 934:	c195                	beqz	a1,958 <vprintf+0x268>
          putc(fd, *s);
 936:	855a                	mv	a0,s6
 938:	cf3ff0ef          	jal	62a <putc>
        for(; *s; s++)
 93c:	0905                	add	s2,s2,1
 93e:	00094583          	lbu	a1,0(s2)
 942:	f9f5                	bnez	a1,936 <vprintf+0x246>
        if((s = va_arg(ap, char*)) == 0)
 944:	8bce                	mv	s7,s3
      state = 0;
 946:	4981                	li	s3,0
 948:	bbd5                	j	73c <vprintf+0x4c>
          s = "(null)";
 94a:	00000917          	auipc	s2,0x0
 94e:	20e90913          	add	s2,s2,526 # b58 <malloc+0x100>
        for(; *s; s++)
 952:	02800593          	li	a1,40
 956:	b7c5                	j	936 <vprintf+0x246>
        if((s = va_arg(ap, char*)) == 0)
 958:	8bce                	mv	s7,s3
      state = 0;
 95a:	4981                	li	s3,0
 95c:	b3c5                	j	73c <vprintf+0x4c>
    }
  }
}
 95e:	60e6                	ld	ra,88(sp)
 960:	6446                	ld	s0,80(sp)
 962:	64a6                	ld	s1,72(sp)
 964:	6906                	ld	s2,64(sp)
 966:	79e2                	ld	s3,56(sp)
 968:	7a42                	ld	s4,48(sp)
 96a:	7aa2                	ld	s5,40(sp)
 96c:	7b02                	ld	s6,32(sp)
 96e:	6be2                	ld	s7,24(sp)
 970:	6c42                	ld	s8,16(sp)
 972:	6ca2                	ld	s9,8(sp)
 974:	6d02                	ld	s10,0(sp)
 976:	6125                	add	sp,sp,96
 978:	8082                	ret

000000000000097a <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 97a:	715d                	add	sp,sp,-80
 97c:	ec06                	sd	ra,24(sp)
 97e:	e822                	sd	s0,16(sp)
 980:	1000                	add	s0,sp,32
 982:	e010                	sd	a2,0(s0)
 984:	e414                	sd	a3,8(s0)
 986:	e818                	sd	a4,16(s0)
 988:	ec1c                	sd	a5,24(s0)
 98a:	03043023          	sd	a6,32(s0)
 98e:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 992:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 996:	8622                	mv	a2,s0
 998:	d59ff0ef          	jal	6f0 <vprintf>
}
 99c:	60e2                	ld	ra,24(sp)
 99e:	6442                	ld	s0,16(sp)
 9a0:	6161                	add	sp,sp,80
 9a2:	8082                	ret

00000000000009a4 <printf>:

void
printf(const char *fmt, ...)
{
 9a4:	711d                	add	sp,sp,-96
 9a6:	ec06                	sd	ra,24(sp)
 9a8:	e822                	sd	s0,16(sp)
 9aa:	1000                	add	s0,sp,32
 9ac:	e40c                	sd	a1,8(s0)
 9ae:	e810                	sd	a2,16(s0)
 9b0:	ec14                	sd	a3,24(s0)
 9b2:	f018                	sd	a4,32(s0)
 9b4:	f41c                	sd	a5,40(s0)
 9b6:	03043823          	sd	a6,48(s0)
 9ba:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 9be:	00840613          	add	a2,s0,8
 9c2:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 9c6:	85aa                	mv	a1,a0
 9c8:	4505                	li	a0,1
 9ca:	d27ff0ef          	jal	6f0 <vprintf>
}
 9ce:	60e2                	ld	ra,24(sp)
 9d0:	6442                	ld	s0,16(sp)
 9d2:	6125                	add	sp,sp,96
 9d4:	8082                	ret

00000000000009d6 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 9d6:	1141                	add	sp,sp,-16
 9d8:	e422                	sd	s0,8(sp)
 9da:	0800                	add	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 9dc:	ff050693          	add	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 9e0:	00000797          	auipc	a5,0x0
 9e4:	6287b783          	ld	a5,1576(a5) # 1008 <freep>
 9e8:	a02d                	j	a12 <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 9ea:	4618                	lw	a4,8(a2)
 9ec:	9f2d                	addw	a4,a4,a1
 9ee:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 9f2:	6398                	ld	a4,0(a5)
 9f4:	6310                	ld	a2,0(a4)
 9f6:	a83d                	j	a34 <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 9f8:	ff852703          	lw	a4,-8(a0)
 9fc:	9f31                	addw	a4,a4,a2
 9fe:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 a00:	ff053683          	ld	a3,-16(a0)
 a04:	a091                	j	a48 <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 a06:	6398                	ld	a4,0(a5)
 a08:	00e7e463          	bltu	a5,a4,a10 <free+0x3a>
 a0c:	00e6ea63          	bltu	a3,a4,a20 <free+0x4a>
{
 a10:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 a12:	fed7fae3          	bgeu	a5,a3,a06 <free+0x30>
 a16:	6398                	ld	a4,0(a5)
 a18:	00e6e463          	bltu	a3,a4,a20 <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 a1c:	fee7eae3          	bltu	a5,a4,a10 <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 a20:	ff852583          	lw	a1,-8(a0)
 a24:	6390                	ld	a2,0(a5)
 a26:	02059813          	sll	a6,a1,0x20
 a2a:	01c85713          	srl	a4,a6,0x1c
 a2e:	9736                	add	a4,a4,a3
 a30:	fae60de3          	beq	a2,a4,9ea <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 a34:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 a38:	4790                	lw	a2,8(a5)
 a3a:	02061593          	sll	a1,a2,0x20
 a3e:	01c5d713          	srl	a4,a1,0x1c
 a42:	973e                	add	a4,a4,a5
 a44:	fae68ae3          	beq	a3,a4,9f8 <free+0x22>
    p->s.ptr = bp->s.ptr;
 a48:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 a4a:	00000717          	auipc	a4,0x0
 a4e:	5af73f23          	sd	a5,1470(a4) # 1008 <freep>
}
 a52:	6422                	ld	s0,8(sp)
 a54:	0141                	add	sp,sp,16
 a56:	8082                	ret

0000000000000a58 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 a58:	7139                	add	sp,sp,-64
 a5a:	fc06                	sd	ra,56(sp)
 a5c:	f822                	sd	s0,48(sp)
 a5e:	f426                	sd	s1,40(sp)
 a60:	f04a                	sd	s2,32(sp)
 a62:	ec4e                	sd	s3,24(sp)
 a64:	e852                	sd	s4,16(sp)
 a66:	e456                	sd	s5,8(sp)
 a68:	e05a                	sd	s6,0(sp)
 a6a:	0080                	add	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 a6c:	02051493          	sll	s1,a0,0x20
 a70:	9081                	srl	s1,s1,0x20
 a72:	04bd                	add	s1,s1,15
 a74:	8091                	srl	s1,s1,0x4
 a76:	0014899b          	addw	s3,s1,1
 a7a:	0485                	add	s1,s1,1
  if((prevp = freep) == 0){
 a7c:	00000517          	auipc	a0,0x0
 a80:	58c53503          	ld	a0,1420(a0) # 1008 <freep>
 a84:	c515                	beqz	a0,ab0 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a86:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 a88:	4798                	lw	a4,8(a5)
 a8a:	02977f63          	bgeu	a4,s1,ac8 <malloc+0x70>
  if(nu < 4096)
 a8e:	8a4e                	mv	s4,s3
 a90:	0009871b          	sext.w	a4,s3
 a94:	6685                	lui	a3,0x1
 a96:	00d77363          	bgeu	a4,a3,a9c <malloc+0x44>
 a9a:	6a05                	lui	s4,0x1
 a9c:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 aa0:	004a1a1b          	sllw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 aa4:	00000917          	auipc	s2,0x0
 aa8:	56490913          	add	s2,s2,1380 # 1008 <freep>
  if(p == (char*)-1)
 aac:	5afd                	li	s5,-1
 aae:	a885                	j	b1e <malloc+0xc6>
    base.s.ptr = freep = prevp = &base;
 ab0:	00000797          	auipc	a5,0x0
 ab4:	56078793          	add	a5,a5,1376 # 1010 <base>
 ab8:	00000717          	auipc	a4,0x0
 abc:	54f73823          	sd	a5,1360(a4) # 1008 <freep>
 ac0:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 ac2:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 ac6:	b7e1                	j	a8e <malloc+0x36>
      if(p->s.size == nunits)
 ac8:	02e48c63          	beq	s1,a4,b00 <malloc+0xa8>
        p->s.size -= nunits;
 acc:	4137073b          	subw	a4,a4,s3
 ad0:	c798                	sw	a4,8(a5)
        p += p->s.size;
 ad2:	02071693          	sll	a3,a4,0x20
 ad6:	01c6d713          	srl	a4,a3,0x1c
 ada:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 adc:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 ae0:	00000717          	auipc	a4,0x0
 ae4:	52a73423          	sd	a0,1320(a4) # 1008 <freep>
      return (void*)(p + 1);
 ae8:	01078513          	add	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 aec:	70e2                	ld	ra,56(sp)
 aee:	7442                	ld	s0,48(sp)
 af0:	74a2                	ld	s1,40(sp)
 af2:	7902                	ld	s2,32(sp)
 af4:	69e2                	ld	s3,24(sp)
 af6:	6a42                	ld	s4,16(sp)
 af8:	6aa2                	ld	s5,8(sp)
 afa:	6b02                	ld	s6,0(sp)
 afc:	6121                	add	sp,sp,64
 afe:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 b00:	6398                	ld	a4,0(a5)
 b02:	e118                	sd	a4,0(a0)
 b04:	bff1                	j	ae0 <malloc+0x88>
  hp->s.size = nu;
 b06:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 b0a:	0541                	add	a0,a0,16
 b0c:	ecbff0ef          	jal	9d6 <free>
  return freep;
 b10:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 b14:	dd61                	beqz	a0,aec <malloc+0x94>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 b16:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 b18:	4798                	lw	a4,8(a5)
 b1a:	fa9777e3          	bgeu	a4,s1,ac8 <malloc+0x70>
    if(p == freep)
 b1e:	00093703          	ld	a4,0(s2)
 b22:	853e                	mv	a0,a5
 b24:	fef719e3          	bne	a4,a5,b16 <malloc+0xbe>
  p = sbrk(nu * sizeof(Header));
 b28:	8552                	mv	a0,s4
 b2a:	a99ff0ef          	jal	5c2 <sbrk>
  if(p == (char*)-1)
 b2e:	fd551ce3          	bne	a0,s5,b06 <malloc+0xae>
        return 0;
 b32:	4501                	li	a0,0
 b34:	bf65                	j	aec <malloc+0x94>
