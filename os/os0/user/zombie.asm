
user/_zombie:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/stat.h"
#include "user/user.h"

int
main(void)
{
   0:	1141                	add	sp,sp,-16
   2:	e406                	sd	ra,8(sp)
   4:	e022                	sd	s0,0(sp)
   6:	0800                	add	s0,sp,16
  if(fork() > 0)
   8:	4f8000ef          	jal	500 <fork>
   c:	00a04563          	bgtz	a0,16 <main+0x16>
    sleep(5);  // Let child exit before parent.
  exit(0);
  10:	4501                	li	a0,0
  12:	4f6000ef          	jal	508 <exit>
    sleep(5);  // Let child exit before parent.
  16:	4515                	li	a0,5
  18:	580000ef          	jal	598 <sleep>
  1c:	bfd5                	j	10 <main+0x10>

000000000000001e <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start()
{
  1e:	1141                	add	sp,sp,-16
  20:	e406                	sd	ra,8(sp)
  22:	e022                	sd	s0,0(sp)
  24:	0800                	add	s0,sp,16
  extern int main();
  main();
  26:	fdbff0ef          	jal	0 <main>
  exit(0);
  2a:	4501                	li	a0,0
  2c:	4dc000ef          	jal	508 <exit>

0000000000000030 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
  30:	1141                	add	sp,sp,-16
  32:	e422                	sd	s0,8(sp)
  34:	0800                	add	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  36:	87aa                	mv	a5,a0
  38:	0585                	add	a1,a1,1
  3a:	0785                	add	a5,a5,1
  3c:	fff5c703          	lbu	a4,-1(a1)
  40:	fee78fa3          	sb	a4,-1(a5)
  44:	fb75                	bnez	a4,38 <strcpy+0x8>
    ;
  return os;
}
  46:	6422                	ld	s0,8(sp)
  48:	0141                	add	sp,sp,16
  4a:	8082                	ret

000000000000004c <strcmp>:

int
strcmp(const char *p, const char *q)
{
  4c:	1141                	add	sp,sp,-16
  4e:	e422                	sd	s0,8(sp)
  50:	0800                	add	s0,sp,16
  while(*p && *p == *q)
  52:	00054783          	lbu	a5,0(a0)
  56:	cb91                	beqz	a5,6a <strcmp+0x1e>
  58:	0005c703          	lbu	a4,0(a1)
  5c:	00f71763          	bne	a4,a5,6a <strcmp+0x1e>
    p++, q++;
  60:	0505                	add	a0,a0,1
  62:	0585                	add	a1,a1,1
  while(*p && *p == *q)
  64:	00054783          	lbu	a5,0(a0)
  68:	fbe5                	bnez	a5,58 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
  6a:	0005c503          	lbu	a0,0(a1)
}
  6e:	40a7853b          	subw	a0,a5,a0
  72:	6422                	ld	s0,8(sp)
  74:	0141                	add	sp,sp,16
  76:	8082                	ret

0000000000000078 <strlen>:

uint
strlen(const char *s)
{
  78:	1141                	add	sp,sp,-16
  7a:	e422                	sd	s0,8(sp)
  7c:	0800                	add	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
  7e:	00054783          	lbu	a5,0(a0)
  82:	cf91                	beqz	a5,9e <strlen+0x26>
  84:	0505                	add	a0,a0,1
  86:	87aa                	mv	a5,a0
  88:	86be                	mv	a3,a5
  8a:	0785                	add	a5,a5,1
  8c:	fff7c703          	lbu	a4,-1(a5)
  90:	ff65                	bnez	a4,88 <strlen+0x10>
  92:	40a6853b          	subw	a0,a3,a0
  96:	2505                	addw	a0,a0,1
    ;
  return n;
}
  98:	6422                	ld	s0,8(sp)
  9a:	0141                	add	sp,sp,16
  9c:	8082                	ret
  for(n = 0; s[n]; n++)
  9e:	4501                	li	a0,0
  a0:	bfe5                	j	98 <strlen+0x20>

00000000000000a2 <memset>:

void*
memset(void *dst, int c, uint n)
{
  a2:	1141                	add	sp,sp,-16
  a4:	e422                	sd	s0,8(sp)
  a6:	0800                	add	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
  a8:	ca19                	beqz	a2,be <memset+0x1c>
  aa:	87aa                	mv	a5,a0
  ac:	1602                	sll	a2,a2,0x20
  ae:	9201                	srl	a2,a2,0x20
  b0:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
  b4:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
  b8:	0785                	add	a5,a5,1
  ba:	fee79de3          	bne	a5,a4,b4 <memset+0x12>
  }
  return dst;
}
  be:	6422                	ld	s0,8(sp)
  c0:	0141                	add	sp,sp,16
  c2:	8082                	ret

00000000000000c4 <strchr>:

char*
strchr(const char *s, char c)
{
  c4:	1141                	add	sp,sp,-16
  c6:	e422                	sd	s0,8(sp)
  c8:	0800                	add	s0,sp,16
  for(; *s; s++)
  ca:	00054783          	lbu	a5,0(a0)
  ce:	cb99                	beqz	a5,e4 <strchr+0x20>
    if(*s == c)
  d0:	00f58763          	beq	a1,a5,de <strchr+0x1a>
  for(; *s; s++)
  d4:	0505                	add	a0,a0,1
  d6:	00054783          	lbu	a5,0(a0)
  da:	fbfd                	bnez	a5,d0 <strchr+0xc>
      return (char*)s;
  return 0;
  dc:	4501                	li	a0,0
}
  de:	6422                	ld	s0,8(sp)
  e0:	0141                	add	sp,sp,16
  e2:	8082                	ret
  return 0;
  e4:	4501                	li	a0,0
  e6:	bfe5                	j	de <strchr+0x1a>

00000000000000e8 <gets>:

char*
gets(char *buf, int max)
{
  e8:	711d                	add	sp,sp,-96
  ea:	ec86                	sd	ra,88(sp)
  ec:	e8a2                	sd	s0,80(sp)
  ee:	e4a6                	sd	s1,72(sp)
  f0:	e0ca                	sd	s2,64(sp)
  f2:	fc4e                	sd	s3,56(sp)
  f4:	f852                	sd	s4,48(sp)
  f6:	f456                	sd	s5,40(sp)
  f8:	f05a                	sd	s6,32(sp)
  fa:	ec5e                	sd	s7,24(sp)
  fc:	1080                	add	s0,sp,96
  fe:	8baa                	mv	s7,a0
 100:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 102:	892a                	mv	s2,a0
 104:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 106:	4aa9                	li	s5,10
 108:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 10a:	89a6                	mv	s3,s1
 10c:	2485                	addw	s1,s1,1
 10e:	0344d663          	bge	s1,s4,13a <gets+0x52>
    cc = read(0, &c, 1);
 112:	4605                	li	a2,1
 114:	faf40593          	add	a1,s0,-81
 118:	4501                	li	a0,0
 11a:	406000ef          	jal	520 <read>
    if(cc < 1)
 11e:	00a05e63          	blez	a0,13a <gets+0x52>
    buf[i++] = c;
 122:	faf44783          	lbu	a5,-81(s0)
 126:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 12a:	01578763          	beq	a5,s5,138 <gets+0x50>
 12e:	0905                	add	s2,s2,1
 130:	fd679de3          	bne	a5,s6,10a <gets+0x22>
  for(i=0; i+1 < max; ){
 134:	89a6                	mv	s3,s1
 136:	a011                	j	13a <gets+0x52>
 138:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 13a:	99de                	add	s3,s3,s7
 13c:	00098023          	sb	zero,0(s3)
  return buf;
}
 140:	855e                	mv	a0,s7
 142:	60e6                	ld	ra,88(sp)
 144:	6446                	ld	s0,80(sp)
 146:	64a6                	ld	s1,72(sp)
 148:	6906                	ld	s2,64(sp)
 14a:	79e2                	ld	s3,56(sp)
 14c:	7a42                	ld	s4,48(sp)
 14e:	7aa2                	ld	s5,40(sp)
 150:	7b02                	ld	s6,32(sp)
 152:	6be2                	ld	s7,24(sp)
 154:	6125                	add	sp,sp,96
 156:	8082                	ret

0000000000000158 <stat>:

int
stat(const char *n, struct stat *st)
{
 158:	1101                	add	sp,sp,-32
 15a:	ec06                	sd	ra,24(sp)
 15c:	e822                	sd	s0,16(sp)
 15e:	e426                	sd	s1,8(sp)
 160:	e04a                	sd	s2,0(sp)
 162:	1000                	add	s0,sp,32
 164:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 166:	4581                	li	a1,0
 168:	3e0000ef          	jal	548 <open>
  if(fd < 0)
 16c:	02054163          	bltz	a0,18e <stat+0x36>
 170:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 172:	85ca                	mv	a1,s2
 174:	3ec000ef          	jal	560 <fstat>
 178:	892a                	mv	s2,a0
  close(fd);
 17a:	8526                	mv	a0,s1
 17c:	3b4000ef          	jal	530 <close>
  return r;
}
 180:	854a                	mv	a0,s2
 182:	60e2                	ld	ra,24(sp)
 184:	6442                	ld	s0,16(sp)
 186:	64a2                	ld	s1,8(sp)
 188:	6902                	ld	s2,0(sp)
 18a:	6105                	add	sp,sp,32
 18c:	8082                	ret
    return -1;
 18e:	597d                	li	s2,-1
 190:	bfc5                	j	180 <stat+0x28>

0000000000000192 <atoi>:

int
atoi(const char *s)
{
 192:	1141                	add	sp,sp,-16
 194:	e422                	sd	s0,8(sp)
 196:	0800                	add	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 198:	00054683          	lbu	a3,0(a0)
 19c:	fd06879b          	addw	a5,a3,-48
 1a0:	0ff7f793          	zext.b	a5,a5
 1a4:	4625                	li	a2,9
 1a6:	02f66863          	bltu	a2,a5,1d6 <atoi+0x44>
 1aa:	872a                	mv	a4,a0
  n = 0;
 1ac:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 1ae:	0705                	add	a4,a4,1
 1b0:	0025179b          	sllw	a5,a0,0x2
 1b4:	9fa9                	addw	a5,a5,a0
 1b6:	0017979b          	sllw	a5,a5,0x1
 1ba:	9fb5                	addw	a5,a5,a3
 1bc:	fd07851b          	addw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 1c0:	00074683          	lbu	a3,0(a4)
 1c4:	fd06879b          	addw	a5,a3,-48
 1c8:	0ff7f793          	zext.b	a5,a5
 1cc:	fef671e3          	bgeu	a2,a5,1ae <atoi+0x1c>
  return n;
}
 1d0:	6422                	ld	s0,8(sp)
 1d2:	0141                	add	sp,sp,16
 1d4:	8082                	ret
  n = 0;
 1d6:	4501                	li	a0,0
 1d8:	bfe5                	j	1d0 <atoi+0x3e>

00000000000001da <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 1da:	1141                	add	sp,sp,-16
 1dc:	e422                	sd	s0,8(sp)
 1de:	0800                	add	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 1e0:	02b57463          	bgeu	a0,a1,208 <memmove+0x2e>
    while(n-- > 0)
 1e4:	00c05f63          	blez	a2,202 <memmove+0x28>
 1e8:	1602                	sll	a2,a2,0x20
 1ea:	9201                	srl	a2,a2,0x20
 1ec:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 1f0:	872a                	mv	a4,a0
      *dst++ = *src++;
 1f2:	0585                	add	a1,a1,1
 1f4:	0705                	add	a4,a4,1
 1f6:	fff5c683          	lbu	a3,-1(a1)
 1fa:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 1fe:	fee79ae3          	bne	a5,a4,1f2 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 202:	6422                	ld	s0,8(sp)
 204:	0141                	add	sp,sp,16
 206:	8082                	ret
    dst += n;
 208:	00c50733          	add	a4,a0,a2
    src += n;
 20c:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 20e:	fec05ae3          	blez	a2,202 <memmove+0x28>
 212:	fff6079b          	addw	a5,a2,-1
 216:	1782                	sll	a5,a5,0x20
 218:	9381                	srl	a5,a5,0x20
 21a:	fff7c793          	not	a5,a5
 21e:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 220:	15fd                	add	a1,a1,-1
 222:	177d                	add	a4,a4,-1
 224:	0005c683          	lbu	a3,0(a1)
 228:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 22c:	fee79ae3          	bne	a5,a4,220 <memmove+0x46>
 230:	bfc9                	j	202 <memmove+0x28>

0000000000000232 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 232:	1141                	add	sp,sp,-16
 234:	e422                	sd	s0,8(sp)
 236:	0800                	add	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 238:	ca05                	beqz	a2,268 <memcmp+0x36>
 23a:	fff6069b          	addw	a3,a2,-1
 23e:	1682                	sll	a3,a3,0x20
 240:	9281                	srl	a3,a3,0x20
 242:	0685                	add	a3,a3,1
 244:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 246:	00054783          	lbu	a5,0(a0)
 24a:	0005c703          	lbu	a4,0(a1)
 24e:	00e79863          	bne	a5,a4,25e <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 252:	0505                	add	a0,a0,1
    p2++;
 254:	0585                	add	a1,a1,1
  while (n-- > 0) {
 256:	fed518e3          	bne	a0,a3,246 <memcmp+0x14>
  }
  return 0;
 25a:	4501                	li	a0,0
 25c:	a019                	j	262 <memcmp+0x30>
      return *p1 - *p2;
 25e:	40e7853b          	subw	a0,a5,a4
}
 262:	6422                	ld	s0,8(sp)
 264:	0141                	add	sp,sp,16
 266:	8082                	ret
  return 0;
 268:	4501                	li	a0,0
 26a:	bfe5                	j	262 <memcmp+0x30>

000000000000026c <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 26c:	1141                	add	sp,sp,-16
 26e:	e406                	sd	ra,8(sp)
 270:	e022                	sd	s0,0(sp)
 272:	0800                	add	s0,sp,16
  return memmove(dst, src, n);
 274:	f67ff0ef          	jal	1da <memmove>
}
 278:	60a2                	ld	ra,8(sp)
 27a:	6402                	ld	s0,0(sp)
 27c:	0141                	add	sp,sp,16
 27e:	8082                	ret

0000000000000280 <htons>:
    return (v & 0x000000ff) << 24 | (v & 0x0000ff00) << 8 | (v & 0x00ff0000) >> 8 | (v & 0xff000000) >> 24;
}

uint16_t
htons(uint16_t h)
{
 280:	1141                	add	sp,sp,-16
 282:	e422                	sd	s0,8(sp)
 284:	0800                	add	s0,sp,16
    if (!endian) {
 286:	00001797          	auipc	a5,0x1
 28a:	d7a7a783          	lw	a5,-646(a5) # 1000 <endian>
 28e:	e385                	bnez	a5,2ae <htons+0x2e>
        endian = byteorder();
 290:	4d200793          	li	a5,1234
 294:	00001717          	auipc	a4,0x1
 298:	d6f72623          	sw	a5,-660(a4) # 1000 <endian>
    return (v & 0x00ff) << 8 | (v & 0xff00 ) >> 8;
 29c:	0085579b          	srlw	a5,a0,0x8
 2a0:	0085151b          	sllw	a0,a0,0x8
 2a4:	8fc9                	or	a5,a5,a0
 2a6:	03079513          	sll	a0,a5,0x30
 2aa:	9141                	srl	a0,a0,0x30
 2ac:	a029                	j	2b6 <htons+0x36>
    }
    return endian == __LITTLE_ENDIAN ? byteswap16(h) : h;
 2ae:	4d200713          	li	a4,1234
 2b2:	fee785e3          	beq	a5,a4,29c <htons+0x1c>
}
 2b6:	6422                	ld	s0,8(sp)
 2b8:	0141                	add	sp,sp,16
 2ba:	8082                	ret

00000000000002bc <ntohs>:

uint16_t
ntohs(uint16_t n)
{
 2bc:	1141                	add	sp,sp,-16
 2be:	e422                	sd	s0,8(sp)
 2c0:	0800                	add	s0,sp,16
    if (!endian) {
 2c2:	00001797          	auipc	a5,0x1
 2c6:	d3e7a783          	lw	a5,-706(a5) # 1000 <endian>
 2ca:	e385                	bnez	a5,2ea <ntohs+0x2e>
        endian = byteorder();
 2cc:	4d200793          	li	a5,1234
 2d0:	00001717          	auipc	a4,0x1
 2d4:	d2f72823          	sw	a5,-720(a4) # 1000 <endian>
    return (v & 0x00ff) << 8 | (v & 0xff00 ) >> 8;
 2d8:	0085579b          	srlw	a5,a0,0x8
 2dc:	0085151b          	sllw	a0,a0,0x8
 2e0:	8fc9                	or	a5,a5,a0
 2e2:	03079513          	sll	a0,a5,0x30
 2e6:	9141                	srl	a0,a0,0x30
 2e8:	a029                	j	2f2 <ntohs+0x36>
    }
    return endian == __LITTLE_ENDIAN ? byteswap16(n) : n;
 2ea:	4d200713          	li	a4,1234
 2ee:	fee785e3          	beq	a5,a4,2d8 <ntohs+0x1c>
}
 2f2:	6422                	ld	s0,8(sp)
 2f4:	0141                	add	sp,sp,16
 2f6:	8082                	ret

00000000000002f8 <htonl>:

uint32_t
htonl(uint32_t h)
{
 2f8:	1141                	add	sp,sp,-16
 2fa:	e422                	sd	s0,8(sp)
 2fc:	0800                	add	s0,sp,16
    if (!endian) {
 2fe:	00001797          	auipc	a5,0x1
 302:	d027a783          	lw	a5,-766(a5) # 1000 <endian>
 306:	ef85                	bnez	a5,33e <htonl+0x46>
        endian = byteorder();
 308:	4d200793          	li	a5,1234
 30c:	00001717          	auipc	a4,0x1
 310:	cef72a23          	sw	a5,-780(a4) # 1000 <endian>
    return (v & 0x000000ff) << 24 | (v & 0x0000ff00) << 8 | (v & 0x00ff0000) >> 8 | (v & 0xff000000) >> 24;
 314:	0185179b          	sllw	a5,a0,0x18
 318:	0185571b          	srlw	a4,a0,0x18
 31c:	8fd9                	or	a5,a5,a4
 31e:	0085171b          	sllw	a4,a0,0x8
 322:	00ff06b7          	lui	a3,0xff0
 326:	8f75                	and	a4,a4,a3
 328:	8fd9                	or	a5,a5,a4
 32a:	0085551b          	srlw	a0,a0,0x8
 32e:	6741                	lui	a4,0x10
 330:	f0070713          	add	a4,a4,-256 # ff00 <base+0xeef0>
 334:	8d79                	and	a0,a0,a4
 336:	8fc9                	or	a5,a5,a0
 338:	0007851b          	sext.w	a0,a5
 33c:	a029                	j	346 <htonl+0x4e>
    }
    return endian == __LITTLE_ENDIAN ? byteswap32(h) : h;
 33e:	4d200713          	li	a4,1234
 342:	fce789e3          	beq	a5,a4,314 <htonl+0x1c>
}
 346:	6422                	ld	s0,8(sp)
 348:	0141                	add	sp,sp,16
 34a:	8082                	ret

000000000000034c <ntohl>:

uint32_t
ntohl(uint32_t n)
{
 34c:	1141                	add	sp,sp,-16
 34e:	e422                	sd	s0,8(sp)
 350:	0800                	add	s0,sp,16
    if (!endian) {
 352:	00001797          	auipc	a5,0x1
 356:	cae7a783          	lw	a5,-850(a5) # 1000 <endian>
 35a:	ef85                	bnez	a5,392 <ntohl+0x46>
        endian = byteorder();
 35c:	4d200793          	li	a5,1234
 360:	00001717          	auipc	a4,0x1
 364:	caf72023          	sw	a5,-864(a4) # 1000 <endian>
    return (v & 0x000000ff) << 24 | (v & 0x0000ff00) << 8 | (v & 0x00ff0000) >> 8 | (v & 0xff000000) >> 24;
 368:	0185179b          	sllw	a5,a0,0x18
 36c:	0185571b          	srlw	a4,a0,0x18
 370:	8fd9                	or	a5,a5,a4
 372:	0085171b          	sllw	a4,a0,0x8
 376:	00ff06b7          	lui	a3,0xff0
 37a:	8f75                	and	a4,a4,a3
 37c:	8fd9                	or	a5,a5,a4
 37e:	0085551b          	srlw	a0,a0,0x8
 382:	6741                	lui	a4,0x10
 384:	f0070713          	add	a4,a4,-256 # ff00 <base+0xeef0>
 388:	8d79                	and	a0,a0,a4
 38a:	8fc9                	or	a5,a5,a0
 38c:	0007851b          	sext.w	a0,a5
 390:	a029                	j	39a <ntohl+0x4e>
    }
    return endian == __LITTLE_ENDIAN ? byteswap32(n) : n;
 392:	4d200713          	li	a4,1234
 396:	fce789e3          	beq	a5,a4,368 <ntohl+0x1c>
}
 39a:	6422                	ld	s0,8(sp)
 39c:	0141                	add	sp,sp,16
 39e:	8082                	ret

00000000000003a0 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
 3a0:	1141                	add	sp,sp,-16
 3a2:	e422                	sd	s0,8(sp)
 3a4:	0800                	add	s0,sp,16
 3a6:	872a                	mv	a4,a0
    int neg = 0;
    long val = 0;

    // gobble initial whitespace
    while (*s == ' ' || *s == '\t')
 3a8:	02000693          	li	a3,32
 3ac:	4525                	li	a0,9
 3ae:	a011                	j	3b2 <strtol+0x12>
        s++;
 3b0:	0705                	add	a4,a4,1
    while (*s == ' ' || *s == '\t')
 3b2:	00074783          	lbu	a5,0(a4)
 3b6:	fed78de3          	beq	a5,a3,3b0 <strtol+0x10>
 3ba:	fea78be3          	beq	a5,a0,3b0 <strtol+0x10>

    // plus/minus sign
    if (*s == '+')
 3be:	02b00693          	li	a3,43
 3c2:	02d78663          	beq	a5,a3,3ee <strtol+0x4e>
        s++;
    else if (*s == '-')
 3c6:	02d00693          	li	a3,45
    int neg = 0;
 3ca:	4301                	li	t1,0
    else if (*s == '-')
 3cc:	02d78463          	beq	a5,a3,3f4 <strtol+0x54>
        s++, neg = 1;

    // hex or octal base prefix
    if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
 3d0:	fef67793          	and	a5,a2,-17
 3d4:	eb89                	bnez	a5,3e6 <strtol+0x46>
 3d6:	00074683          	lbu	a3,0(a4)
 3da:	03000793          	li	a5,48
 3de:	00f68e63          	beq	a3,a5,3fa <strtol+0x5a>
        s += 2, base = 16;
    else if (base == 0 && s[0] == '0')
 3e2:	e211                	bnez	a2,3e6 <strtol+0x46>
        s++, base = 8;
    else if (base == 0)
        base = 10;
 3e4:	4629                	li	a2,10
 3e6:	4501                	li	a0,0

    // digits
    while (1) {
        int dig;

        if (*s >= '0' && *s <= '9')
 3e8:	4825                	li	a6,9
            dig = *s - '0';
        else if (*s >= 'a' && *s <= 'z')
 3ea:	48e5                	li	a7,25
 3ec:	a825                	j	424 <strtol+0x84>
        s++;
 3ee:	0705                	add	a4,a4,1
    int neg = 0;
 3f0:	4301                	li	t1,0
 3f2:	bff9                	j	3d0 <strtol+0x30>
        s++, neg = 1;
 3f4:	0705                	add	a4,a4,1
 3f6:	4305                	li	t1,1
 3f8:	bfe1                	j	3d0 <strtol+0x30>
    if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
 3fa:	00174683          	lbu	a3,1(a4)
 3fe:	07800793          	li	a5,120
 402:	00f68663          	beq	a3,a5,40e <strtol+0x6e>
    else if (base == 0 && s[0] == '0')
 406:	f265                	bnez	a2,3e6 <strtol+0x46>
        s++, base = 8;
 408:	0705                	add	a4,a4,1
 40a:	4621                	li	a2,8
 40c:	bfe9                	j	3e6 <strtol+0x46>
        s += 2, base = 16;
 40e:	0709                	add	a4,a4,2
 410:	4641                	li	a2,16
 412:	bfd1                	j	3e6 <strtol+0x46>
            dig = *s - '0';
 414:	fd07879b          	addw	a5,a5,-48
            dig = *s - 'a' + 10;
        else if (*s >= 'A' && *s <= 'Z')
            dig = *s - 'A' + 10;
        else
            break;
        if (dig >= base)
 418:	04c7d063          	bge	a5,a2,458 <strtol+0xb8>
            break;
        s++, val = (val * base) + dig;
 41c:	0705                	add	a4,a4,1
 41e:	02a60533          	mul	a0,a2,a0
 422:	953e                	add	a0,a0,a5
        if (*s >= '0' && *s <= '9')
 424:	00074783          	lbu	a5,0(a4)
 428:	fd07869b          	addw	a3,a5,-48
 42c:	0ff6f693          	zext.b	a3,a3
 430:	fed872e3          	bgeu	a6,a3,414 <strtol+0x74>
        else if (*s >= 'a' && *s <= 'z')
 434:	f9f7869b          	addw	a3,a5,-97
 438:	0ff6f693          	zext.b	a3,a3
 43c:	00d8e563          	bltu	a7,a3,446 <strtol+0xa6>
            dig = *s - 'a' + 10;
 440:	fa97879b          	addw	a5,a5,-87
 444:	bfd1                	j	418 <strtol+0x78>
        else if (*s >= 'A' && *s <= 'Z')
 446:	fbf7869b          	addw	a3,a5,-65
 44a:	0ff6f693          	zext.b	a3,a3
 44e:	00d8e563          	bltu	a7,a3,458 <strtol+0xb8>
            dig = *s - 'A' + 10;
 452:	fc97879b          	addw	a5,a5,-55
 456:	b7c9                	j	418 <strtol+0x78>
        // we don't properly detect overflow!
    }

    if (endptr)
 458:	c191                	beqz	a1,45c <strtol+0xbc>
        *endptr = (char *) s;
 45a:	e198                	sd	a4,0(a1)
    return (neg ? -val : val);
 45c:	00030463          	beqz	t1,464 <strtol+0xc4>
 460:	40a00533          	neg	a0,a0
}
 464:	6422                	ld	s0,8(sp)
 466:	0141                	add	sp,sp,16
 468:	8082                	ret

000000000000046a <inet_pton>:
inet_pton (int family, const char *p, void *n) {
    char *sp, *ep;
    int idx;
    long ret;

    if (family != AF_INET) {
 46a:	4785                	li	a5,1
 46c:	08f51263          	bne	a0,a5,4f0 <inet_pton+0x86>
inet_pton (int family, const char *p, void *n) {
 470:	715d                	add	sp,sp,-80
 472:	e486                	sd	ra,72(sp)
 474:	e0a2                	sd	s0,64(sp)
 476:	fc26                	sd	s1,56(sp)
 478:	f84a                	sd	s2,48(sp)
 47a:	f44e                	sd	s3,40(sp)
 47c:	f052                	sd	s4,32(sp)
 47e:	ec56                	sd	s5,24(sp)
 480:	e85a                	sd	s6,16(sp)
 482:	0880                	add	s0,sp,80
 484:	892e                	mv	s2,a1
 486:	89b2                	mv	s3,a2
 488:	4481                	li	s1,0
        return -1;
    }
    sp = (char *)p;
    for (idx = 0; idx < 4; idx++) {
        ret = strtol(sp, &ep, 10);
        if (ret < 0 || ret > 255) {
 48a:	0ff00a13          	li	s4,255
            return -1;
        }
        if (ep == sp) {
            return -1;
        }
        if ((idx == 3 && *ep != '\0') || (idx != 3 && *ep != '.')) {
 48e:	4a8d                	li	s5,3
 490:	02e00b13          	li	s6,46
 494:	a815                	j	4c8 <inet_pton+0x5e>
 496:	0007c783          	lbu	a5,0(a5)
 49a:	e3ad                	bnez	a5,4fc <inet_pton+0x92>
            return -1;
        }
        ((uint8_t *)n)[idx] = ret;
 49c:	2481                	sext.w	s1,s1
 49e:	99a6                	add	s3,s3,s1
 4a0:	00a98023          	sb	a0,0(s3)
        sp = ep + 1;
    }
    return 0;
 4a4:	4501                	li	a0,0
}
 4a6:	60a6                	ld	ra,72(sp)
 4a8:	6406                	ld	s0,64(sp)
 4aa:	74e2                	ld	s1,56(sp)
 4ac:	7942                	ld	s2,48(sp)
 4ae:	79a2                	ld	s3,40(sp)
 4b0:	7a02                	ld	s4,32(sp)
 4b2:	6ae2                	ld	s5,24(sp)
 4b4:	6b42                	ld	s6,16(sp)
 4b6:	6161                	add	sp,sp,80
 4b8:	8082                	ret
        ((uint8_t *)n)[idx] = ret;
 4ba:	00998733          	add	a4,s3,s1
 4be:	00a70023          	sb	a0,0(a4)
        sp = ep + 1;
 4c2:	00178913          	add	s2,a5,1
    for (idx = 0; idx < 4; idx++) {
 4c6:	0485                	add	s1,s1,1
        ret = strtol(sp, &ep, 10);
 4c8:	4629                	li	a2,10
 4ca:	fb840593          	add	a1,s0,-72
 4ce:	854a                	mv	a0,s2
 4d0:	ed1ff0ef          	jal	3a0 <strtol>
        if (ret < 0 || ret > 255) {
 4d4:	02aa6063          	bltu	s4,a0,4f4 <inet_pton+0x8a>
        if (ep == sp) {
 4d8:	fb843783          	ld	a5,-72(s0)
 4dc:	01278e63          	beq	a5,s2,4f8 <inet_pton+0x8e>
        if ((idx == 3 && *ep != '\0') || (idx != 3 && *ep != '.')) {
 4e0:	fb548be3          	beq	s1,s5,496 <inet_pton+0x2c>
 4e4:	0007c703          	lbu	a4,0(a5)
 4e8:	fd6709e3          	beq	a4,s6,4ba <inet_pton+0x50>
            return -1;
 4ec:	557d                	li	a0,-1
 4ee:	bf65                	j	4a6 <inet_pton+0x3c>
        return -1;
 4f0:	557d                	li	a0,-1
}
 4f2:	8082                	ret
            return -1;
 4f4:	557d                	li	a0,-1
 4f6:	bf45                	j	4a6 <inet_pton+0x3c>
            return -1;
 4f8:	557d                	li	a0,-1
 4fa:	b775                	j	4a6 <inet_pton+0x3c>
            return -1;
 4fc:	557d                	li	a0,-1
 4fe:	b765                	j	4a6 <inet_pton+0x3c>

0000000000000500 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 500:	4885                	li	a7,1
 ecall
 502:	00000073          	ecall
 ret
 506:	8082                	ret

0000000000000508 <exit>:
.global exit
exit:
 li a7, SYS_exit
 508:	4889                	li	a7,2
 ecall
 50a:	00000073          	ecall
 ret
 50e:	8082                	ret

0000000000000510 <wait>:
.global wait
wait:
 li a7, SYS_wait
 510:	488d                	li	a7,3
 ecall
 512:	00000073          	ecall
 ret
 516:	8082                	ret

0000000000000518 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 518:	4891                	li	a7,4
 ecall
 51a:	00000073          	ecall
 ret
 51e:	8082                	ret

0000000000000520 <read>:
.global read
read:
 li a7, SYS_read
 520:	4895                	li	a7,5
 ecall
 522:	00000073          	ecall
 ret
 526:	8082                	ret

0000000000000528 <write>:
.global write
write:
 li a7, SYS_write
 528:	48c1                	li	a7,16
 ecall
 52a:	00000073          	ecall
 ret
 52e:	8082                	ret

0000000000000530 <close>:
.global close
close:
 li a7, SYS_close
 530:	48d5                	li	a7,21
 ecall
 532:	00000073          	ecall
 ret
 536:	8082                	ret

0000000000000538 <kill>:
.global kill
kill:
 li a7, SYS_kill
 538:	4899                	li	a7,6
 ecall
 53a:	00000073          	ecall
 ret
 53e:	8082                	ret

0000000000000540 <exec>:
.global exec
exec:
 li a7, SYS_exec
 540:	489d                	li	a7,7
 ecall
 542:	00000073          	ecall
 ret
 546:	8082                	ret

0000000000000548 <open>:
.global open
open:
 li a7, SYS_open
 548:	48bd                	li	a7,15
 ecall
 54a:	00000073          	ecall
 ret
 54e:	8082                	ret

0000000000000550 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 550:	48c5                	li	a7,17
 ecall
 552:	00000073          	ecall
 ret
 556:	8082                	ret

0000000000000558 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 558:	48c9                	li	a7,18
 ecall
 55a:	00000073          	ecall
 ret
 55e:	8082                	ret

0000000000000560 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 560:	48a1                	li	a7,8
 ecall
 562:	00000073          	ecall
 ret
 566:	8082                	ret

0000000000000568 <link>:
.global link
link:
 li a7, SYS_link
 568:	48cd                	li	a7,19
 ecall
 56a:	00000073          	ecall
 ret
 56e:	8082                	ret

0000000000000570 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 570:	48d1                	li	a7,20
 ecall
 572:	00000073          	ecall
 ret
 576:	8082                	ret

0000000000000578 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 578:	48a5                	li	a7,9
 ecall
 57a:	00000073          	ecall
 ret
 57e:	8082                	ret

0000000000000580 <dup>:
.global dup
dup:
 li a7, SYS_dup
 580:	48a9                	li	a7,10
 ecall
 582:	00000073          	ecall
 ret
 586:	8082                	ret

0000000000000588 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 588:	48ad                	li	a7,11
 ecall
 58a:	00000073          	ecall
 ret
 58e:	8082                	ret

0000000000000590 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 590:	48b1                	li	a7,12
 ecall
 592:	00000073          	ecall
 ret
 596:	8082                	ret

0000000000000598 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 598:	48b5                	li	a7,13
 ecall
 59a:	00000073          	ecall
 ret
 59e:	8082                	ret

00000000000005a0 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 5a0:	48b9                	li	a7,14
 ecall
 5a2:	00000073          	ecall
 ret
 5a6:	8082                	ret

00000000000005a8 <socket>:
.global socket
socket:
 li a7, SYS_socket
 5a8:	48d9                	li	a7,22
 ecall
 5aa:	00000073          	ecall
 ret
 5ae:	8082                	ret

00000000000005b0 <bind>:
.global bind
bind:
 li a7, SYS_bind
 5b0:	48dd                	li	a7,23
 ecall
 5b2:	00000073          	ecall
 ret
 5b6:	8082                	ret

00000000000005b8 <recvfrom>:
.global recvfrom
recvfrom:
 li a7, SYS_recvfrom
 5b8:	48e1                	li	a7,24
 ecall
 5ba:	00000073          	ecall
 ret
 5be:	8082                	ret

00000000000005c0 <sendto>:
.global sendto
sendto:
 li a7, SYS_sendto
 5c0:	48e5                	li	a7,25
 ecall
 5c2:	00000073          	ecall
 ret
 5c6:	8082                	ret

00000000000005c8 <connect>:
.global connect
connect:
 li a7, SYS_connect
 5c8:	48e9                	li	a7,26
 ecall
 5ca:	00000073          	ecall
 ret
 5ce:	8082                	ret

00000000000005d0 <listen>:
.global listen
listen:
 li a7, SYS_listen
 5d0:	48ed                	li	a7,27
 ecall
 5d2:	00000073          	ecall
 ret
 5d6:	8082                	ret

00000000000005d8 <accept>:
.global accept
accept:
 li a7, SYS_accept
 5d8:	48f1                	li	a7,28
 ecall
 5da:	00000073          	ecall
 ret
 5de:	8082                	ret

00000000000005e0 <recv>:
.global recv
recv:
 li a7, SYS_recv
 5e0:	48f5                	li	a7,29
 ecall
 5e2:	00000073          	ecall
 ret
 5e6:	8082                	ret

00000000000005e8 <send>:
.global send
send:
 li a7, SYS_send
 5e8:	48f9                	li	a7,30
 ecall
 5ea:	00000073          	ecall
 ret
 5ee:	8082                	ret

00000000000005f0 <ioctl>:
.global ioctl
ioctl:
 li a7, SYS_ioctl
 5f0:	48fd                	li	a7,31
 ecall
 5f2:	00000073          	ecall
 ret
 5f6:	8082                	ret

00000000000005f8 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 5f8:	1101                	add	sp,sp,-32
 5fa:	ec06                	sd	ra,24(sp)
 5fc:	e822                	sd	s0,16(sp)
 5fe:	1000                	add	s0,sp,32
 600:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 604:	4605                	li	a2,1
 606:	fef40593          	add	a1,s0,-17
 60a:	f1fff0ef          	jal	528 <write>
}
 60e:	60e2                	ld	ra,24(sp)
 610:	6442                	ld	s0,16(sp)
 612:	6105                	add	sp,sp,32
 614:	8082                	ret

0000000000000616 <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
 616:	715d                	add	sp,sp,-80
 618:	e486                	sd	ra,72(sp)
 61a:	e0a2                	sd	s0,64(sp)
 61c:	fc26                	sd	s1,56(sp)
 61e:	f84a                	sd	s2,48(sp)
 620:	f44e                	sd	s3,40(sp)
 622:	0880                	add	s0,sp,80
 624:	84aa                	mv	s1,a0
  char buf[20];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 626:	c299                	beqz	a3,62c <printint+0x16>
 628:	0805c763          	bltz	a1,6b6 <printint+0xa0>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 62c:	2581                	sext.w	a1,a1
  neg = 0;
 62e:	4881                	li	a7,0
 630:	fb840693          	add	a3,s0,-72
  }

  i = 0;
 634:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 636:	2601                	sext.w	a2,a2
 638:	00000517          	auipc	a0,0x0
 63c:	4e050513          	add	a0,a0,1248 # b18 <digits>
 640:	883a                	mv	a6,a4
 642:	2705                	addw	a4,a4,1
 644:	02c5f7bb          	remuw	a5,a1,a2
 648:	1782                	sll	a5,a5,0x20
 64a:	9381                	srl	a5,a5,0x20
 64c:	97aa                	add	a5,a5,a0
 64e:	0007c783          	lbu	a5,0(a5)
 652:	00f68023          	sb	a5,0(a3) # ff0000 <base+0xfeeff0>
  }while((x /= base) != 0);
 656:	0005879b          	sext.w	a5,a1
 65a:	02c5d5bb          	divuw	a1,a1,a2
 65e:	0685                	add	a3,a3,1
 660:	fec7f0e3          	bgeu	a5,a2,640 <printint+0x2a>
  if(neg)
 664:	00088c63          	beqz	a7,67c <printint+0x66>
    buf[i++] = '-';
 668:	fd070793          	add	a5,a4,-48
 66c:	00878733          	add	a4,a5,s0
 670:	02d00793          	li	a5,45
 674:	fef70423          	sb	a5,-24(a4)
 678:	0028071b          	addw	a4,a6,2

  while(--i >= 0)
 67c:	02e05663          	blez	a4,6a8 <printint+0x92>
 680:	fb840793          	add	a5,s0,-72
 684:	00e78933          	add	s2,a5,a4
 688:	fff78993          	add	s3,a5,-1
 68c:	99ba                	add	s3,s3,a4
 68e:	377d                	addw	a4,a4,-1
 690:	1702                	sll	a4,a4,0x20
 692:	9301                	srl	a4,a4,0x20
 694:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 698:	fff94583          	lbu	a1,-1(s2)
 69c:	8526                	mv	a0,s1
 69e:	f5bff0ef          	jal	5f8 <putc>
  while(--i >= 0)
 6a2:	197d                	add	s2,s2,-1
 6a4:	ff391ae3          	bne	s2,s3,698 <printint+0x82>
}
 6a8:	60a6                	ld	ra,72(sp)
 6aa:	6406                	ld	s0,64(sp)
 6ac:	74e2                	ld	s1,56(sp)
 6ae:	7942                	ld	s2,48(sp)
 6b0:	79a2                	ld	s3,40(sp)
 6b2:	6161                	add	sp,sp,80
 6b4:	8082                	ret
    x = -xx;
 6b6:	40b005bb          	negw	a1,a1
    neg = 1;
 6ba:	4885                	li	a7,1
    x = -xx;
 6bc:	bf95                	j	630 <printint+0x1a>

00000000000006be <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 6be:	711d                	add	sp,sp,-96
 6c0:	ec86                	sd	ra,88(sp)
 6c2:	e8a2                	sd	s0,80(sp)
 6c4:	e4a6                	sd	s1,72(sp)
 6c6:	e0ca                	sd	s2,64(sp)
 6c8:	fc4e                	sd	s3,56(sp)
 6ca:	f852                	sd	s4,48(sp)
 6cc:	f456                	sd	s5,40(sp)
 6ce:	f05a                	sd	s6,32(sp)
 6d0:	ec5e                	sd	s7,24(sp)
 6d2:	e862                	sd	s8,16(sp)
 6d4:	e466                	sd	s9,8(sp)
 6d6:	e06a                	sd	s10,0(sp)
 6d8:	1080                	add	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 6da:	0005c903          	lbu	s2,0(a1)
 6de:	24090763          	beqz	s2,92c <vprintf+0x26e>
 6e2:	8b2a                	mv	s6,a0
 6e4:	8a2e                	mv	s4,a1
 6e6:	8bb2                	mv	s7,a2
  state = 0;
 6e8:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
 6ea:	4481                	li	s1,0
 6ec:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
 6ee:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
 6f2:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
 6f6:	06c00c93          	li	s9,108
 6fa:	a005                	j	71a <vprintf+0x5c>
        putc(fd, c0);
 6fc:	85ca                	mv	a1,s2
 6fe:	855a                	mv	a0,s6
 700:	ef9ff0ef          	jal	5f8 <putc>
 704:	a019                	j	70a <vprintf+0x4c>
    } else if(state == '%'){
 706:	03598263          	beq	s3,s5,72a <vprintf+0x6c>
  for(i = 0; fmt[i]; i++){
 70a:	2485                	addw	s1,s1,1
 70c:	8726                	mv	a4,s1
 70e:	009a07b3          	add	a5,s4,s1
 712:	0007c903          	lbu	s2,0(a5)
 716:	20090b63          	beqz	s2,92c <vprintf+0x26e>
    c0 = fmt[i] & 0xff;
 71a:	0009079b          	sext.w	a5,s2
    if(state == 0){
 71e:	fe0994e3          	bnez	s3,706 <vprintf+0x48>
      if(c0 == '%'){
 722:	fd579de3          	bne	a5,s5,6fc <vprintf+0x3e>
        state = '%';
 726:	89be                	mv	s3,a5
 728:	b7cd                	j	70a <vprintf+0x4c>
      if(c0) c1 = fmt[i+1] & 0xff;
 72a:	c7c9                	beqz	a5,7b4 <vprintf+0xf6>
 72c:	00ea06b3          	add	a3,s4,a4
 730:	0016c683          	lbu	a3,1(a3)
      c1 = c2 = 0;
 734:	8636                	mv	a2,a3
      if(c1) c2 = fmt[i+2] & 0xff;
 736:	c681                	beqz	a3,73e <vprintf+0x80>
 738:	9752                	add	a4,a4,s4
 73a:	00274603          	lbu	a2,2(a4)
      if(c0 == 'd'){
 73e:	03878f63          	beq	a5,s8,77c <vprintf+0xbe>
      } else if(c0 == 'l' && c1 == 'd'){
 742:	05978963          	beq	a5,s9,794 <vprintf+0xd6>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
 746:	07500713          	li	a4,117
 74a:	0ee78363          	beq	a5,a4,830 <vprintf+0x172>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
 74e:	07800713          	li	a4,120
 752:	12e78563          	beq	a5,a4,87c <vprintf+0x1be>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
 756:	07000713          	li	a4,112
 75a:	14e78a63          	beq	a5,a4,8ae <vprintf+0x1f0>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 's'){
 75e:	07300713          	li	a4,115
 762:	18e78863          	beq	a5,a4,8f2 <vprintf+0x234>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
 766:	02500713          	li	a4,37
 76a:	04e79563          	bne	a5,a4,7b4 <vprintf+0xf6>
        putc(fd, '%');
 76e:	02500593          	li	a1,37
 772:	855a                	mv	a0,s6
 774:	e85ff0ef          	jal	5f8 <putc>
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
#endif
      state = 0;
 778:	4981                	li	s3,0
 77a:	bf41                	j	70a <vprintf+0x4c>
        printint(fd, va_arg(ap, int), 10, 1);
 77c:	008b8913          	add	s2,s7,8
 780:	4685                	li	a3,1
 782:	4629                	li	a2,10
 784:	000ba583          	lw	a1,0(s7)
 788:	855a                	mv	a0,s6
 78a:	e8dff0ef          	jal	616 <printint>
 78e:	8bca                	mv	s7,s2
      state = 0;
 790:	4981                	li	s3,0
 792:	bfa5                	j	70a <vprintf+0x4c>
      } else if(c0 == 'l' && c1 == 'd'){
 794:	06400793          	li	a5,100
 798:	02f68963          	beq	a3,a5,7ca <vprintf+0x10c>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 79c:	06c00793          	li	a5,108
 7a0:	04f68263          	beq	a3,a5,7e4 <vprintf+0x126>
      } else if(c0 == 'l' && c1 == 'u'){
 7a4:	07500793          	li	a5,117
 7a8:	0af68063          	beq	a3,a5,848 <vprintf+0x18a>
      } else if(c0 == 'l' && c1 == 'x'){
 7ac:	07800793          	li	a5,120
 7b0:	0ef68263          	beq	a3,a5,894 <vprintf+0x1d6>
        putc(fd, '%');
 7b4:	02500593          	li	a1,37
 7b8:	855a                	mv	a0,s6
 7ba:	e3fff0ef          	jal	5f8 <putc>
        putc(fd, c0);
 7be:	85ca                	mv	a1,s2
 7c0:	855a                	mv	a0,s6
 7c2:	e37ff0ef          	jal	5f8 <putc>
      state = 0;
 7c6:	4981                	li	s3,0
 7c8:	b789                	j	70a <vprintf+0x4c>
        printint(fd, va_arg(ap, uint64), 10, 1);
 7ca:	008b8913          	add	s2,s7,8
 7ce:	4685                	li	a3,1
 7d0:	4629                	li	a2,10
 7d2:	000bb583          	ld	a1,0(s7)
 7d6:	855a                	mv	a0,s6
 7d8:	e3fff0ef          	jal	616 <printint>
        i += 1;
 7dc:	2485                	addw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 7de:	8bca                	mv	s7,s2
      state = 0;
 7e0:	4981                	li	s3,0
        i += 1;
 7e2:	b725                	j	70a <vprintf+0x4c>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 7e4:	06400793          	li	a5,100
 7e8:	02f60763          	beq	a2,a5,816 <vprintf+0x158>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 7ec:	07500793          	li	a5,117
 7f0:	06f60963          	beq	a2,a5,862 <vprintf+0x1a4>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 7f4:	07800793          	li	a5,120
 7f8:	faf61ee3          	bne	a2,a5,7b4 <vprintf+0xf6>
        printint(fd, va_arg(ap, uint64), 16, 0);
 7fc:	008b8913          	add	s2,s7,8
 800:	4681                	li	a3,0
 802:	4641                	li	a2,16
 804:	000bb583          	ld	a1,0(s7)
 808:	855a                	mv	a0,s6
 80a:	e0dff0ef          	jal	616 <printint>
        i += 2;
 80e:	2489                	addw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 810:	8bca                	mv	s7,s2
      state = 0;
 812:	4981                	li	s3,0
        i += 2;
 814:	bddd                	j	70a <vprintf+0x4c>
        printint(fd, va_arg(ap, uint64), 10, 1);
 816:	008b8913          	add	s2,s7,8
 81a:	4685                	li	a3,1
 81c:	4629                	li	a2,10
 81e:	000bb583          	ld	a1,0(s7)
 822:	855a                	mv	a0,s6
 824:	df3ff0ef          	jal	616 <printint>
        i += 2;
 828:	2489                	addw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 82a:	8bca                	mv	s7,s2
      state = 0;
 82c:	4981                	li	s3,0
        i += 2;
 82e:	bdf1                	j	70a <vprintf+0x4c>
        printint(fd, va_arg(ap, int), 10, 0);
 830:	008b8913          	add	s2,s7,8
 834:	4681                	li	a3,0
 836:	4629                	li	a2,10
 838:	000ba583          	lw	a1,0(s7)
 83c:	855a                	mv	a0,s6
 83e:	dd9ff0ef          	jal	616 <printint>
 842:	8bca                	mv	s7,s2
      state = 0;
 844:	4981                	li	s3,0
 846:	b5d1                	j	70a <vprintf+0x4c>
        printint(fd, va_arg(ap, uint64), 10, 0);
 848:	008b8913          	add	s2,s7,8
 84c:	4681                	li	a3,0
 84e:	4629                	li	a2,10
 850:	000bb583          	ld	a1,0(s7)
 854:	855a                	mv	a0,s6
 856:	dc1ff0ef          	jal	616 <printint>
        i += 1;
 85a:	2485                	addw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 85c:	8bca                	mv	s7,s2
      state = 0;
 85e:	4981                	li	s3,0
        i += 1;
 860:	b56d                	j	70a <vprintf+0x4c>
        printint(fd, va_arg(ap, uint64), 10, 0);
 862:	008b8913          	add	s2,s7,8
 866:	4681                	li	a3,0
 868:	4629                	li	a2,10
 86a:	000bb583          	ld	a1,0(s7)
 86e:	855a                	mv	a0,s6
 870:	da7ff0ef          	jal	616 <printint>
        i += 2;
 874:	2489                	addw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 876:	8bca                	mv	s7,s2
      state = 0;
 878:	4981                	li	s3,0
        i += 2;
 87a:	bd41                	j	70a <vprintf+0x4c>
        printint(fd, va_arg(ap, int), 16, 0);
 87c:	008b8913          	add	s2,s7,8
 880:	4681                	li	a3,0
 882:	4641                	li	a2,16
 884:	000ba583          	lw	a1,0(s7)
 888:	855a                	mv	a0,s6
 88a:	d8dff0ef          	jal	616 <printint>
 88e:	8bca                	mv	s7,s2
      state = 0;
 890:	4981                	li	s3,0
 892:	bda5                	j	70a <vprintf+0x4c>
        printint(fd, va_arg(ap, uint64), 16, 0);
 894:	008b8913          	add	s2,s7,8
 898:	4681                	li	a3,0
 89a:	4641                	li	a2,16
 89c:	000bb583          	ld	a1,0(s7)
 8a0:	855a                	mv	a0,s6
 8a2:	d75ff0ef          	jal	616 <printint>
        i += 1;
 8a6:	2485                	addw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 8a8:	8bca                	mv	s7,s2
      state = 0;
 8aa:	4981                	li	s3,0
        i += 1;
 8ac:	bdb9                	j	70a <vprintf+0x4c>
        printptr(fd, va_arg(ap, uint64));
 8ae:	008b8d13          	add	s10,s7,8
 8b2:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 8b6:	03000593          	li	a1,48
 8ba:	855a                	mv	a0,s6
 8bc:	d3dff0ef          	jal	5f8 <putc>
  putc(fd, 'x');
 8c0:	07800593          	li	a1,120
 8c4:	855a                	mv	a0,s6
 8c6:	d33ff0ef          	jal	5f8 <putc>
 8ca:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 8cc:	00000b97          	auipc	s7,0x0
 8d0:	24cb8b93          	add	s7,s7,588 # b18 <digits>
 8d4:	03c9d793          	srl	a5,s3,0x3c
 8d8:	97de                	add	a5,a5,s7
 8da:	0007c583          	lbu	a1,0(a5)
 8de:	855a                	mv	a0,s6
 8e0:	d19ff0ef          	jal	5f8 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 8e4:	0992                	sll	s3,s3,0x4
 8e6:	397d                	addw	s2,s2,-1
 8e8:	fe0916e3          	bnez	s2,8d4 <vprintf+0x216>
        printptr(fd, va_arg(ap, uint64));
 8ec:	8bea                	mv	s7,s10
      state = 0;
 8ee:	4981                	li	s3,0
 8f0:	bd29                	j	70a <vprintf+0x4c>
        if((s = va_arg(ap, char*)) == 0)
 8f2:	008b8993          	add	s3,s7,8
 8f6:	000bb903          	ld	s2,0(s7)
 8fa:	00090f63          	beqz	s2,918 <vprintf+0x25a>
        for(; *s; s++)
 8fe:	00094583          	lbu	a1,0(s2)
 902:	c195                	beqz	a1,926 <vprintf+0x268>
          putc(fd, *s);
 904:	855a                	mv	a0,s6
 906:	cf3ff0ef          	jal	5f8 <putc>
        for(; *s; s++)
 90a:	0905                	add	s2,s2,1
 90c:	00094583          	lbu	a1,0(s2)
 910:	f9f5                	bnez	a1,904 <vprintf+0x246>
        if((s = va_arg(ap, char*)) == 0)
 912:	8bce                	mv	s7,s3
      state = 0;
 914:	4981                	li	s3,0
 916:	bbd5                	j	70a <vprintf+0x4c>
          s = "(null)";
 918:	00000917          	auipc	s2,0x0
 91c:	1f890913          	add	s2,s2,504 # b10 <malloc+0xea>
        for(; *s; s++)
 920:	02800593          	li	a1,40
 924:	b7c5                	j	904 <vprintf+0x246>
        if((s = va_arg(ap, char*)) == 0)
 926:	8bce                	mv	s7,s3
      state = 0;
 928:	4981                	li	s3,0
 92a:	b3c5                	j	70a <vprintf+0x4c>
    }
  }
}
 92c:	60e6                	ld	ra,88(sp)
 92e:	6446                	ld	s0,80(sp)
 930:	64a6                	ld	s1,72(sp)
 932:	6906                	ld	s2,64(sp)
 934:	79e2                	ld	s3,56(sp)
 936:	7a42                	ld	s4,48(sp)
 938:	7aa2                	ld	s5,40(sp)
 93a:	7b02                	ld	s6,32(sp)
 93c:	6be2                	ld	s7,24(sp)
 93e:	6c42                	ld	s8,16(sp)
 940:	6ca2                	ld	s9,8(sp)
 942:	6d02                	ld	s10,0(sp)
 944:	6125                	add	sp,sp,96
 946:	8082                	ret

0000000000000948 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 948:	715d                	add	sp,sp,-80
 94a:	ec06                	sd	ra,24(sp)
 94c:	e822                	sd	s0,16(sp)
 94e:	1000                	add	s0,sp,32
 950:	e010                	sd	a2,0(s0)
 952:	e414                	sd	a3,8(s0)
 954:	e818                	sd	a4,16(s0)
 956:	ec1c                	sd	a5,24(s0)
 958:	03043023          	sd	a6,32(s0)
 95c:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 960:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 964:	8622                	mv	a2,s0
 966:	d59ff0ef          	jal	6be <vprintf>
}
 96a:	60e2                	ld	ra,24(sp)
 96c:	6442                	ld	s0,16(sp)
 96e:	6161                	add	sp,sp,80
 970:	8082                	ret

0000000000000972 <printf>:

void
printf(const char *fmt, ...)
{
 972:	711d                	add	sp,sp,-96
 974:	ec06                	sd	ra,24(sp)
 976:	e822                	sd	s0,16(sp)
 978:	1000                	add	s0,sp,32
 97a:	e40c                	sd	a1,8(s0)
 97c:	e810                	sd	a2,16(s0)
 97e:	ec14                	sd	a3,24(s0)
 980:	f018                	sd	a4,32(s0)
 982:	f41c                	sd	a5,40(s0)
 984:	03043823          	sd	a6,48(s0)
 988:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 98c:	00840613          	add	a2,s0,8
 990:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 994:	85aa                	mv	a1,a0
 996:	4505                	li	a0,1
 998:	d27ff0ef          	jal	6be <vprintf>
}
 99c:	60e2                	ld	ra,24(sp)
 99e:	6442                	ld	s0,16(sp)
 9a0:	6125                	add	sp,sp,96
 9a2:	8082                	ret

00000000000009a4 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 9a4:	1141                	add	sp,sp,-16
 9a6:	e422                	sd	s0,8(sp)
 9a8:	0800                	add	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 9aa:	ff050693          	add	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 9ae:	00000797          	auipc	a5,0x0
 9b2:	65a7b783          	ld	a5,1626(a5) # 1008 <freep>
 9b6:	a02d                	j	9e0 <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 9b8:	4618                	lw	a4,8(a2)
 9ba:	9f2d                	addw	a4,a4,a1
 9bc:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 9c0:	6398                	ld	a4,0(a5)
 9c2:	6310                	ld	a2,0(a4)
 9c4:	a83d                	j	a02 <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 9c6:	ff852703          	lw	a4,-8(a0)
 9ca:	9f31                	addw	a4,a4,a2
 9cc:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 9ce:	ff053683          	ld	a3,-16(a0)
 9d2:	a091                	j	a16 <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 9d4:	6398                	ld	a4,0(a5)
 9d6:	00e7e463          	bltu	a5,a4,9de <free+0x3a>
 9da:	00e6ea63          	bltu	a3,a4,9ee <free+0x4a>
{
 9de:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 9e0:	fed7fae3          	bgeu	a5,a3,9d4 <free+0x30>
 9e4:	6398                	ld	a4,0(a5)
 9e6:	00e6e463          	bltu	a3,a4,9ee <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 9ea:	fee7eae3          	bltu	a5,a4,9de <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 9ee:	ff852583          	lw	a1,-8(a0)
 9f2:	6390                	ld	a2,0(a5)
 9f4:	02059813          	sll	a6,a1,0x20
 9f8:	01c85713          	srl	a4,a6,0x1c
 9fc:	9736                	add	a4,a4,a3
 9fe:	fae60de3          	beq	a2,a4,9b8 <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 a02:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 a06:	4790                	lw	a2,8(a5)
 a08:	02061593          	sll	a1,a2,0x20
 a0c:	01c5d713          	srl	a4,a1,0x1c
 a10:	973e                	add	a4,a4,a5
 a12:	fae68ae3          	beq	a3,a4,9c6 <free+0x22>
    p->s.ptr = bp->s.ptr;
 a16:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 a18:	00000717          	auipc	a4,0x0
 a1c:	5ef73823          	sd	a5,1520(a4) # 1008 <freep>
}
 a20:	6422                	ld	s0,8(sp)
 a22:	0141                	add	sp,sp,16
 a24:	8082                	ret

0000000000000a26 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 a26:	7139                	add	sp,sp,-64
 a28:	fc06                	sd	ra,56(sp)
 a2a:	f822                	sd	s0,48(sp)
 a2c:	f426                	sd	s1,40(sp)
 a2e:	f04a                	sd	s2,32(sp)
 a30:	ec4e                	sd	s3,24(sp)
 a32:	e852                	sd	s4,16(sp)
 a34:	e456                	sd	s5,8(sp)
 a36:	e05a                	sd	s6,0(sp)
 a38:	0080                	add	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 a3a:	02051493          	sll	s1,a0,0x20
 a3e:	9081                	srl	s1,s1,0x20
 a40:	04bd                	add	s1,s1,15
 a42:	8091                	srl	s1,s1,0x4
 a44:	0014899b          	addw	s3,s1,1
 a48:	0485                	add	s1,s1,1
  if((prevp = freep) == 0){
 a4a:	00000517          	auipc	a0,0x0
 a4e:	5be53503          	ld	a0,1470(a0) # 1008 <freep>
 a52:	c515                	beqz	a0,a7e <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a54:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 a56:	4798                	lw	a4,8(a5)
 a58:	02977f63          	bgeu	a4,s1,a96 <malloc+0x70>
  if(nu < 4096)
 a5c:	8a4e                	mv	s4,s3
 a5e:	0009871b          	sext.w	a4,s3
 a62:	6685                	lui	a3,0x1
 a64:	00d77363          	bgeu	a4,a3,a6a <malloc+0x44>
 a68:	6a05                	lui	s4,0x1
 a6a:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 a6e:	004a1a1b          	sllw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 a72:	00000917          	auipc	s2,0x0
 a76:	59690913          	add	s2,s2,1430 # 1008 <freep>
  if(p == (char*)-1)
 a7a:	5afd                	li	s5,-1
 a7c:	a885                	j	aec <malloc+0xc6>
    base.s.ptr = freep = prevp = &base;
 a7e:	00000797          	auipc	a5,0x0
 a82:	59278793          	add	a5,a5,1426 # 1010 <base>
 a86:	00000717          	auipc	a4,0x0
 a8a:	58f73123          	sd	a5,1410(a4) # 1008 <freep>
 a8e:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 a90:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 a94:	b7e1                	j	a5c <malloc+0x36>
      if(p->s.size == nunits)
 a96:	02e48c63          	beq	s1,a4,ace <malloc+0xa8>
        p->s.size -= nunits;
 a9a:	4137073b          	subw	a4,a4,s3
 a9e:	c798                	sw	a4,8(a5)
        p += p->s.size;
 aa0:	02071693          	sll	a3,a4,0x20
 aa4:	01c6d713          	srl	a4,a3,0x1c
 aa8:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 aaa:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 aae:	00000717          	auipc	a4,0x0
 ab2:	54a73d23          	sd	a0,1370(a4) # 1008 <freep>
      return (void*)(p + 1);
 ab6:	01078513          	add	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 aba:	70e2                	ld	ra,56(sp)
 abc:	7442                	ld	s0,48(sp)
 abe:	74a2                	ld	s1,40(sp)
 ac0:	7902                	ld	s2,32(sp)
 ac2:	69e2                	ld	s3,24(sp)
 ac4:	6a42                	ld	s4,16(sp)
 ac6:	6aa2                	ld	s5,8(sp)
 ac8:	6b02                	ld	s6,0(sp)
 aca:	6121                	add	sp,sp,64
 acc:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 ace:	6398                	ld	a4,0(a5)
 ad0:	e118                	sd	a4,0(a0)
 ad2:	bff1                	j	aae <malloc+0x88>
  hp->s.size = nu;
 ad4:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 ad8:	0541                	add	a0,a0,16
 ada:	ecbff0ef          	jal	9a4 <free>
  return freep;
 ade:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 ae2:	dd61                	beqz	a0,aba <malloc+0x94>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 ae4:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 ae6:	4798                	lw	a4,8(a5)
 ae8:	fa9777e3          	bgeu	a4,s1,a96 <malloc+0x70>
    if(p == freep)
 aec:	00093703          	ld	a4,0(s2)
 af0:	853e                	mv	a0,a5
 af2:	fef719e3          	bne	a4,a5,ae4 <malloc+0xbe>
  p = sbrk(nu * sizeof(Header));
 af6:	8552                	mv	a0,s4
 af8:	a99ff0ef          	jal	590 <sbrk>
  if(p == (char*)-1)
 afc:	fd551ce3          	bne	a0,s5,ad4 <malloc+0xae>
        return 0;
 b00:	4501                	li	a0,0
 b02:	bf65                	j	aba <malloc+0x94>
