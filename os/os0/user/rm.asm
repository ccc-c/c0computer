
user/_rm:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/stat.h"
#include "user/user.h"

int
main(int argc, char *argv[])
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
   e:	02a7d563          	bge	a5,a0,38 <main+0x38>
  12:	00858493          	add	s1,a1,8
  16:	ffe5091b          	addw	s2,a0,-2
  1a:	02091793          	sll	a5,s2,0x20
  1e:	01d7d913          	srl	s2,a5,0x1d
  22:	05c1                	add	a1,a1,16
  24:	992e                	add	s2,s2,a1
    fprintf(2, "Usage: rm files...\n");
    exit(1);
  }

  for(i = 1; i < argc; i++){
    if(unlink(argv[i]) < 0){
  26:	6088                	ld	a0,0(s1)
  28:	574000ef          	jal	59c <unlink>
  2c:	02054063          	bltz	a0,4c <main+0x4c>
  for(i = 1; i < argc; i++){
  30:	04a1                	add	s1,s1,8
  32:	ff249ae3          	bne	s1,s2,26 <main+0x26>
  36:	a01d                	j	5c <main+0x5c>
    fprintf(2, "Usage: rm files...\n");
  38:	00001597          	auipc	a1,0x1
  3c:	b1858593          	add	a1,a1,-1256 # b50 <malloc+0xe6>
  40:	4509                	li	a0,2
  42:	14b000ef          	jal	98c <fprintf>
    exit(1);
  46:	4505                	li	a0,1
  48:	504000ef          	jal	54c <exit>
      fprintf(2, "rm: %s failed to delete\n", argv[i]);
  4c:	6090                	ld	a2,0(s1)
  4e:	00001597          	auipc	a1,0x1
  52:	b1a58593          	add	a1,a1,-1254 # b68 <malloc+0xfe>
  56:	4509                	li	a0,2
  58:	135000ef          	jal	98c <fprintf>
      break;
    }
  }

  exit(0);
  5c:	4501                	li	a0,0
  5e:	4ee000ef          	jal	54c <exit>

0000000000000062 <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start()
{
  62:	1141                	add	sp,sp,-16
  64:	e406                	sd	ra,8(sp)
  66:	e022                	sd	s0,0(sp)
  68:	0800                	add	s0,sp,16
  extern int main();
  main();
  6a:	f97ff0ef          	jal	0 <main>
  exit(0);
  6e:	4501                	li	a0,0
  70:	4dc000ef          	jal	54c <exit>

0000000000000074 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
  74:	1141                	add	sp,sp,-16
  76:	e422                	sd	s0,8(sp)
  78:	0800                	add	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  7a:	87aa                	mv	a5,a0
  7c:	0585                	add	a1,a1,1
  7e:	0785                	add	a5,a5,1
  80:	fff5c703          	lbu	a4,-1(a1)
  84:	fee78fa3          	sb	a4,-1(a5)
  88:	fb75                	bnez	a4,7c <strcpy+0x8>
    ;
  return os;
}
  8a:	6422                	ld	s0,8(sp)
  8c:	0141                	add	sp,sp,16
  8e:	8082                	ret

0000000000000090 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  90:	1141                	add	sp,sp,-16
  92:	e422                	sd	s0,8(sp)
  94:	0800                	add	s0,sp,16
  while(*p && *p == *q)
  96:	00054783          	lbu	a5,0(a0)
  9a:	cb91                	beqz	a5,ae <strcmp+0x1e>
  9c:	0005c703          	lbu	a4,0(a1)
  a0:	00f71763          	bne	a4,a5,ae <strcmp+0x1e>
    p++, q++;
  a4:	0505                	add	a0,a0,1
  a6:	0585                	add	a1,a1,1
  while(*p && *p == *q)
  a8:	00054783          	lbu	a5,0(a0)
  ac:	fbe5                	bnez	a5,9c <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
  ae:	0005c503          	lbu	a0,0(a1)
}
  b2:	40a7853b          	subw	a0,a5,a0
  b6:	6422                	ld	s0,8(sp)
  b8:	0141                	add	sp,sp,16
  ba:	8082                	ret

00000000000000bc <strlen>:

uint
strlen(const char *s)
{
  bc:	1141                	add	sp,sp,-16
  be:	e422                	sd	s0,8(sp)
  c0:	0800                	add	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
  c2:	00054783          	lbu	a5,0(a0)
  c6:	cf91                	beqz	a5,e2 <strlen+0x26>
  c8:	0505                	add	a0,a0,1
  ca:	87aa                	mv	a5,a0
  cc:	86be                	mv	a3,a5
  ce:	0785                	add	a5,a5,1
  d0:	fff7c703          	lbu	a4,-1(a5)
  d4:	ff65                	bnez	a4,cc <strlen+0x10>
  d6:	40a6853b          	subw	a0,a3,a0
  da:	2505                	addw	a0,a0,1
    ;
  return n;
}
  dc:	6422                	ld	s0,8(sp)
  de:	0141                	add	sp,sp,16
  e0:	8082                	ret
  for(n = 0; s[n]; n++)
  e2:	4501                	li	a0,0
  e4:	bfe5                	j	dc <strlen+0x20>

00000000000000e6 <memset>:

void*
memset(void *dst, int c, uint n)
{
  e6:	1141                	add	sp,sp,-16
  e8:	e422                	sd	s0,8(sp)
  ea:	0800                	add	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
  ec:	ca19                	beqz	a2,102 <memset+0x1c>
  ee:	87aa                	mv	a5,a0
  f0:	1602                	sll	a2,a2,0x20
  f2:	9201                	srl	a2,a2,0x20
  f4:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
  f8:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
  fc:	0785                	add	a5,a5,1
  fe:	fee79de3          	bne	a5,a4,f8 <memset+0x12>
  }
  return dst;
}
 102:	6422                	ld	s0,8(sp)
 104:	0141                	add	sp,sp,16
 106:	8082                	ret

0000000000000108 <strchr>:

char*
strchr(const char *s, char c)
{
 108:	1141                	add	sp,sp,-16
 10a:	e422                	sd	s0,8(sp)
 10c:	0800                	add	s0,sp,16
  for(; *s; s++)
 10e:	00054783          	lbu	a5,0(a0)
 112:	cb99                	beqz	a5,128 <strchr+0x20>
    if(*s == c)
 114:	00f58763          	beq	a1,a5,122 <strchr+0x1a>
  for(; *s; s++)
 118:	0505                	add	a0,a0,1
 11a:	00054783          	lbu	a5,0(a0)
 11e:	fbfd                	bnez	a5,114 <strchr+0xc>
      return (char*)s;
  return 0;
 120:	4501                	li	a0,0
}
 122:	6422                	ld	s0,8(sp)
 124:	0141                	add	sp,sp,16
 126:	8082                	ret
  return 0;
 128:	4501                	li	a0,0
 12a:	bfe5                	j	122 <strchr+0x1a>

000000000000012c <gets>:

char*
gets(char *buf, int max)
{
 12c:	711d                	add	sp,sp,-96
 12e:	ec86                	sd	ra,88(sp)
 130:	e8a2                	sd	s0,80(sp)
 132:	e4a6                	sd	s1,72(sp)
 134:	e0ca                	sd	s2,64(sp)
 136:	fc4e                	sd	s3,56(sp)
 138:	f852                	sd	s4,48(sp)
 13a:	f456                	sd	s5,40(sp)
 13c:	f05a                	sd	s6,32(sp)
 13e:	ec5e                	sd	s7,24(sp)
 140:	1080                	add	s0,sp,96
 142:	8baa                	mv	s7,a0
 144:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 146:	892a                	mv	s2,a0
 148:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 14a:	4aa9                	li	s5,10
 14c:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 14e:	89a6                	mv	s3,s1
 150:	2485                	addw	s1,s1,1
 152:	0344d663          	bge	s1,s4,17e <gets+0x52>
    cc = read(0, &c, 1);
 156:	4605                	li	a2,1
 158:	faf40593          	add	a1,s0,-81
 15c:	4501                	li	a0,0
 15e:	406000ef          	jal	564 <read>
    if(cc < 1)
 162:	00a05e63          	blez	a0,17e <gets+0x52>
    buf[i++] = c;
 166:	faf44783          	lbu	a5,-81(s0)
 16a:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 16e:	01578763          	beq	a5,s5,17c <gets+0x50>
 172:	0905                	add	s2,s2,1
 174:	fd679de3          	bne	a5,s6,14e <gets+0x22>
  for(i=0; i+1 < max; ){
 178:	89a6                	mv	s3,s1
 17a:	a011                	j	17e <gets+0x52>
 17c:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 17e:	99de                	add	s3,s3,s7
 180:	00098023          	sb	zero,0(s3)
  return buf;
}
 184:	855e                	mv	a0,s7
 186:	60e6                	ld	ra,88(sp)
 188:	6446                	ld	s0,80(sp)
 18a:	64a6                	ld	s1,72(sp)
 18c:	6906                	ld	s2,64(sp)
 18e:	79e2                	ld	s3,56(sp)
 190:	7a42                	ld	s4,48(sp)
 192:	7aa2                	ld	s5,40(sp)
 194:	7b02                	ld	s6,32(sp)
 196:	6be2                	ld	s7,24(sp)
 198:	6125                	add	sp,sp,96
 19a:	8082                	ret

000000000000019c <stat>:

int
stat(const char *n, struct stat *st)
{
 19c:	1101                	add	sp,sp,-32
 19e:	ec06                	sd	ra,24(sp)
 1a0:	e822                	sd	s0,16(sp)
 1a2:	e426                	sd	s1,8(sp)
 1a4:	e04a                	sd	s2,0(sp)
 1a6:	1000                	add	s0,sp,32
 1a8:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1aa:	4581                	li	a1,0
 1ac:	3e0000ef          	jal	58c <open>
  if(fd < 0)
 1b0:	02054163          	bltz	a0,1d2 <stat+0x36>
 1b4:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 1b6:	85ca                	mv	a1,s2
 1b8:	3ec000ef          	jal	5a4 <fstat>
 1bc:	892a                	mv	s2,a0
  close(fd);
 1be:	8526                	mv	a0,s1
 1c0:	3b4000ef          	jal	574 <close>
  return r;
}
 1c4:	854a                	mv	a0,s2
 1c6:	60e2                	ld	ra,24(sp)
 1c8:	6442                	ld	s0,16(sp)
 1ca:	64a2                	ld	s1,8(sp)
 1cc:	6902                	ld	s2,0(sp)
 1ce:	6105                	add	sp,sp,32
 1d0:	8082                	ret
    return -1;
 1d2:	597d                	li	s2,-1
 1d4:	bfc5                	j	1c4 <stat+0x28>

00000000000001d6 <atoi>:

int
atoi(const char *s)
{
 1d6:	1141                	add	sp,sp,-16
 1d8:	e422                	sd	s0,8(sp)
 1da:	0800                	add	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 1dc:	00054683          	lbu	a3,0(a0)
 1e0:	fd06879b          	addw	a5,a3,-48
 1e4:	0ff7f793          	zext.b	a5,a5
 1e8:	4625                	li	a2,9
 1ea:	02f66863          	bltu	a2,a5,21a <atoi+0x44>
 1ee:	872a                	mv	a4,a0
  n = 0;
 1f0:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 1f2:	0705                	add	a4,a4,1
 1f4:	0025179b          	sllw	a5,a0,0x2
 1f8:	9fa9                	addw	a5,a5,a0
 1fa:	0017979b          	sllw	a5,a5,0x1
 1fe:	9fb5                	addw	a5,a5,a3
 200:	fd07851b          	addw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 204:	00074683          	lbu	a3,0(a4)
 208:	fd06879b          	addw	a5,a3,-48
 20c:	0ff7f793          	zext.b	a5,a5
 210:	fef671e3          	bgeu	a2,a5,1f2 <atoi+0x1c>
  return n;
}
 214:	6422                	ld	s0,8(sp)
 216:	0141                	add	sp,sp,16
 218:	8082                	ret
  n = 0;
 21a:	4501                	li	a0,0
 21c:	bfe5                	j	214 <atoi+0x3e>

000000000000021e <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 21e:	1141                	add	sp,sp,-16
 220:	e422                	sd	s0,8(sp)
 222:	0800                	add	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 224:	02b57463          	bgeu	a0,a1,24c <memmove+0x2e>
    while(n-- > 0)
 228:	00c05f63          	blez	a2,246 <memmove+0x28>
 22c:	1602                	sll	a2,a2,0x20
 22e:	9201                	srl	a2,a2,0x20
 230:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 234:	872a                	mv	a4,a0
      *dst++ = *src++;
 236:	0585                	add	a1,a1,1
 238:	0705                	add	a4,a4,1
 23a:	fff5c683          	lbu	a3,-1(a1)
 23e:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 242:	fee79ae3          	bne	a5,a4,236 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 246:	6422                	ld	s0,8(sp)
 248:	0141                	add	sp,sp,16
 24a:	8082                	ret
    dst += n;
 24c:	00c50733          	add	a4,a0,a2
    src += n;
 250:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 252:	fec05ae3          	blez	a2,246 <memmove+0x28>
 256:	fff6079b          	addw	a5,a2,-1
 25a:	1782                	sll	a5,a5,0x20
 25c:	9381                	srl	a5,a5,0x20
 25e:	fff7c793          	not	a5,a5
 262:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 264:	15fd                	add	a1,a1,-1
 266:	177d                	add	a4,a4,-1
 268:	0005c683          	lbu	a3,0(a1)
 26c:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 270:	fee79ae3          	bne	a5,a4,264 <memmove+0x46>
 274:	bfc9                	j	246 <memmove+0x28>

0000000000000276 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 276:	1141                	add	sp,sp,-16
 278:	e422                	sd	s0,8(sp)
 27a:	0800                	add	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 27c:	ca05                	beqz	a2,2ac <memcmp+0x36>
 27e:	fff6069b          	addw	a3,a2,-1
 282:	1682                	sll	a3,a3,0x20
 284:	9281                	srl	a3,a3,0x20
 286:	0685                	add	a3,a3,1
 288:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 28a:	00054783          	lbu	a5,0(a0)
 28e:	0005c703          	lbu	a4,0(a1)
 292:	00e79863          	bne	a5,a4,2a2 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 296:	0505                	add	a0,a0,1
    p2++;
 298:	0585                	add	a1,a1,1
  while (n-- > 0) {
 29a:	fed518e3          	bne	a0,a3,28a <memcmp+0x14>
  }
  return 0;
 29e:	4501                	li	a0,0
 2a0:	a019                	j	2a6 <memcmp+0x30>
      return *p1 - *p2;
 2a2:	40e7853b          	subw	a0,a5,a4
}
 2a6:	6422                	ld	s0,8(sp)
 2a8:	0141                	add	sp,sp,16
 2aa:	8082                	ret
  return 0;
 2ac:	4501                	li	a0,0
 2ae:	bfe5                	j	2a6 <memcmp+0x30>

00000000000002b0 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 2b0:	1141                	add	sp,sp,-16
 2b2:	e406                	sd	ra,8(sp)
 2b4:	e022                	sd	s0,0(sp)
 2b6:	0800                	add	s0,sp,16
  return memmove(dst, src, n);
 2b8:	f67ff0ef          	jal	21e <memmove>
}
 2bc:	60a2                	ld	ra,8(sp)
 2be:	6402                	ld	s0,0(sp)
 2c0:	0141                	add	sp,sp,16
 2c2:	8082                	ret

00000000000002c4 <htons>:
    return (v & 0x000000ff) << 24 | (v & 0x0000ff00) << 8 | (v & 0x00ff0000) >> 8 | (v & 0xff000000) >> 24;
}

uint16_t
htons(uint16_t h)
{
 2c4:	1141                	add	sp,sp,-16
 2c6:	e422                	sd	s0,8(sp)
 2c8:	0800                	add	s0,sp,16
    if (!endian) {
 2ca:	00001797          	auipc	a5,0x1
 2ce:	d367a783          	lw	a5,-714(a5) # 1000 <endian>
 2d2:	e385                	bnez	a5,2f2 <htons+0x2e>
        endian = byteorder();
 2d4:	4d200793          	li	a5,1234
 2d8:	00001717          	auipc	a4,0x1
 2dc:	d2f72423          	sw	a5,-728(a4) # 1000 <endian>
    return (v & 0x00ff) << 8 | (v & 0xff00 ) >> 8;
 2e0:	0085579b          	srlw	a5,a0,0x8
 2e4:	0085151b          	sllw	a0,a0,0x8
 2e8:	8fc9                	or	a5,a5,a0
 2ea:	03079513          	sll	a0,a5,0x30
 2ee:	9141                	srl	a0,a0,0x30
 2f0:	a029                	j	2fa <htons+0x36>
    }
    return endian == __LITTLE_ENDIAN ? byteswap16(h) : h;
 2f2:	4d200713          	li	a4,1234
 2f6:	fee785e3          	beq	a5,a4,2e0 <htons+0x1c>
}
 2fa:	6422                	ld	s0,8(sp)
 2fc:	0141                	add	sp,sp,16
 2fe:	8082                	ret

0000000000000300 <ntohs>:

uint16_t
ntohs(uint16_t n)
{
 300:	1141                	add	sp,sp,-16
 302:	e422                	sd	s0,8(sp)
 304:	0800                	add	s0,sp,16
    if (!endian) {
 306:	00001797          	auipc	a5,0x1
 30a:	cfa7a783          	lw	a5,-774(a5) # 1000 <endian>
 30e:	e385                	bnez	a5,32e <ntohs+0x2e>
        endian = byteorder();
 310:	4d200793          	li	a5,1234
 314:	00001717          	auipc	a4,0x1
 318:	cef72623          	sw	a5,-788(a4) # 1000 <endian>
    return (v & 0x00ff) << 8 | (v & 0xff00 ) >> 8;
 31c:	0085579b          	srlw	a5,a0,0x8
 320:	0085151b          	sllw	a0,a0,0x8
 324:	8fc9                	or	a5,a5,a0
 326:	03079513          	sll	a0,a5,0x30
 32a:	9141                	srl	a0,a0,0x30
 32c:	a029                	j	336 <ntohs+0x36>
    }
    return endian == __LITTLE_ENDIAN ? byteswap16(n) : n;
 32e:	4d200713          	li	a4,1234
 332:	fee785e3          	beq	a5,a4,31c <ntohs+0x1c>
}
 336:	6422                	ld	s0,8(sp)
 338:	0141                	add	sp,sp,16
 33a:	8082                	ret

000000000000033c <htonl>:

uint32_t
htonl(uint32_t h)
{
 33c:	1141                	add	sp,sp,-16
 33e:	e422                	sd	s0,8(sp)
 340:	0800                	add	s0,sp,16
    if (!endian) {
 342:	00001797          	auipc	a5,0x1
 346:	cbe7a783          	lw	a5,-834(a5) # 1000 <endian>
 34a:	ef85                	bnez	a5,382 <htonl+0x46>
        endian = byteorder();
 34c:	4d200793          	li	a5,1234
 350:	00001717          	auipc	a4,0x1
 354:	caf72823          	sw	a5,-848(a4) # 1000 <endian>
    return (v & 0x000000ff) << 24 | (v & 0x0000ff00) << 8 | (v & 0x00ff0000) >> 8 | (v & 0xff000000) >> 24;
 358:	0185179b          	sllw	a5,a0,0x18
 35c:	0185571b          	srlw	a4,a0,0x18
 360:	8fd9                	or	a5,a5,a4
 362:	0085171b          	sllw	a4,a0,0x8
 366:	00ff06b7          	lui	a3,0xff0
 36a:	8f75                	and	a4,a4,a3
 36c:	8fd9                	or	a5,a5,a4
 36e:	0085551b          	srlw	a0,a0,0x8
 372:	6741                	lui	a4,0x10
 374:	f0070713          	add	a4,a4,-256 # ff00 <base+0xeef0>
 378:	8d79                	and	a0,a0,a4
 37a:	8fc9                	or	a5,a5,a0
 37c:	0007851b          	sext.w	a0,a5
 380:	a029                	j	38a <htonl+0x4e>
    }
    return endian == __LITTLE_ENDIAN ? byteswap32(h) : h;
 382:	4d200713          	li	a4,1234
 386:	fce789e3          	beq	a5,a4,358 <htonl+0x1c>
}
 38a:	6422                	ld	s0,8(sp)
 38c:	0141                	add	sp,sp,16
 38e:	8082                	ret

0000000000000390 <ntohl>:

uint32_t
ntohl(uint32_t n)
{
 390:	1141                	add	sp,sp,-16
 392:	e422                	sd	s0,8(sp)
 394:	0800                	add	s0,sp,16
    if (!endian) {
 396:	00001797          	auipc	a5,0x1
 39a:	c6a7a783          	lw	a5,-918(a5) # 1000 <endian>
 39e:	ef85                	bnez	a5,3d6 <ntohl+0x46>
        endian = byteorder();
 3a0:	4d200793          	li	a5,1234
 3a4:	00001717          	auipc	a4,0x1
 3a8:	c4f72e23          	sw	a5,-932(a4) # 1000 <endian>
    return (v & 0x000000ff) << 24 | (v & 0x0000ff00) << 8 | (v & 0x00ff0000) >> 8 | (v & 0xff000000) >> 24;
 3ac:	0185179b          	sllw	a5,a0,0x18
 3b0:	0185571b          	srlw	a4,a0,0x18
 3b4:	8fd9                	or	a5,a5,a4
 3b6:	0085171b          	sllw	a4,a0,0x8
 3ba:	00ff06b7          	lui	a3,0xff0
 3be:	8f75                	and	a4,a4,a3
 3c0:	8fd9                	or	a5,a5,a4
 3c2:	0085551b          	srlw	a0,a0,0x8
 3c6:	6741                	lui	a4,0x10
 3c8:	f0070713          	add	a4,a4,-256 # ff00 <base+0xeef0>
 3cc:	8d79                	and	a0,a0,a4
 3ce:	8fc9                	or	a5,a5,a0
 3d0:	0007851b          	sext.w	a0,a5
 3d4:	a029                	j	3de <ntohl+0x4e>
    }
    return endian == __LITTLE_ENDIAN ? byteswap32(n) : n;
 3d6:	4d200713          	li	a4,1234
 3da:	fce789e3          	beq	a5,a4,3ac <ntohl+0x1c>
}
 3de:	6422                	ld	s0,8(sp)
 3e0:	0141                	add	sp,sp,16
 3e2:	8082                	ret

00000000000003e4 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
 3e4:	1141                	add	sp,sp,-16
 3e6:	e422                	sd	s0,8(sp)
 3e8:	0800                	add	s0,sp,16
 3ea:	872a                	mv	a4,a0
    int neg = 0;
    long val = 0;

    // gobble initial whitespace
    while (*s == ' ' || *s == '\t')
 3ec:	02000693          	li	a3,32
 3f0:	4525                	li	a0,9
 3f2:	a011                	j	3f6 <strtol+0x12>
        s++;
 3f4:	0705                	add	a4,a4,1
    while (*s == ' ' || *s == '\t')
 3f6:	00074783          	lbu	a5,0(a4)
 3fa:	fed78de3          	beq	a5,a3,3f4 <strtol+0x10>
 3fe:	fea78be3          	beq	a5,a0,3f4 <strtol+0x10>

    // plus/minus sign
    if (*s == '+')
 402:	02b00693          	li	a3,43
 406:	02d78663          	beq	a5,a3,432 <strtol+0x4e>
        s++;
    else if (*s == '-')
 40a:	02d00693          	li	a3,45
    int neg = 0;
 40e:	4301                	li	t1,0
    else if (*s == '-')
 410:	02d78463          	beq	a5,a3,438 <strtol+0x54>
        s++, neg = 1;

    // hex or octal base prefix
    if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
 414:	fef67793          	and	a5,a2,-17
 418:	eb89                	bnez	a5,42a <strtol+0x46>
 41a:	00074683          	lbu	a3,0(a4)
 41e:	03000793          	li	a5,48
 422:	00f68e63          	beq	a3,a5,43e <strtol+0x5a>
        s += 2, base = 16;
    else if (base == 0 && s[0] == '0')
 426:	e211                	bnez	a2,42a <strtol+0x46>
        s++, base = 8;
    else if (base == 0)
        base = 10;
 428:	4629                	li	a2,10
 42a:	4501                	li	a0,0

    // digits
    while (1) {
        int dig;

        if (*s >= '0' && *s <= '9')
 42c:	4825                	li	a6,9
            dig = *s - '0';
        else if (*s >= 'a' && *s <= 'z')
 42e:	48e5                	li	a7,25
 430:	a825                	j	468 <strtol+0x84>
        s++;
 432:	0705                	add	a4,a4,1
    int neg = 0;
 434:	4301                	li	t1,0
 436:	bff9                	j	414 <strtol+0x30>
        s++, neg = 1;
 438:	0705                	add	a4,a4,1
 43a:	4305                	li	t1,1
 43c:	bfe1                	j	414 <strtol+0x30>
    if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
 43e:	00174683          	lbu	a3,1(a4)
 442:	07800793          	li	a5,120
 446:	00f68663          	beq	a3,a5,452 <strtol+0x6e>
    else if (base == 0 && s[0] == '0')
 44a:	f265                	bnez	a2,42a <strtol+0x46>
        s++, base = 8;
 44c:	0705                	add	a4,a4,1
 44e:	4621                	li	a2,8
 450:	bfe9                	j	42a <strtol+0x46>
        s += 2, base = 16;
 452:	0709                	add	a4,a4,2
 454:	4641                	li	a2,16
 456:	bfd1                	j	42a <strtol+0x46>
            dig = *s - '0';
 458:	fd07879b          	addw	a5,a5,-48
            dig = *s - 'a' + 10;
        else if (*s >= 'A' && *s <= 'Z')
            dig = *s - 'A' + 10;
        else
            break;
        if (dig >= base)
 45c:	04c7d063          	bge	a5,a2,49c <strtol+0xb8>
            break;
        s++, val = (val * base) + dig;
 460:	0705                	add	a4,a4,1
 462:	02a60533          	mul	a0,a2,a0
 466:	953e                	add	a0,a0,a5
        if (*s >= '0' && *s <= '9')
 468:	00074783          	lbu	a5,0(a4)
 46c:	fd07869b          	addw	a3,a5,-48
 470:	0ff6f693          	zext.b	a3,a3
 474:	fed872e3          	bgeu	a6,a3,458 <strtol+0x74>
        else if (*s >= 'a' && *s <= 'z')
 478:	f9f7869b          	addw	a3,a5,-97
 47c:	0ff6f693          	zext.b	a3,a3
 480:	00d8e563          	bltu	a7,a3,48a <strtol+0xa6>
            dig = *s - 'a' + 10;
 484:	fa97879b          	addw	a5,a5,-87
 488:	bfd1                	j	45c <strtol+0x78>
        else if (*s >= 'A' && *s <= 'Z')
 48a:	fbf7869b          	addw	a3,a5,-65
 48e:	0ff6f693          	zext.b	a3,a3
 492:	00d8e563          	bltu	a7,a3,49c <strtol+0xb8>
            dig = *s - 'A' + 10;
 496:	fc97879b          	addw	a5,a5,-55
 49a:	b7c9                	j	45c <strtol+0x78>
        // we don't properly detect overflow!
    }

    if (endptr)
 49c:	c191                	beqz	a1,4a0 <strtol+0xbc>
        *endptr = (char *) s;
 49e:	e198                	sd	a4,0(a1)
    return (neg ? -val : val);
 4a0:	00030463          	beqz	t1,4a8 <strtol+0xc4>
 4a4:	40a00533          	neg	a0,a0
}
 4a8:	6422                	ld	s0,8(sp)
 4aa:	0141                	add	sp,sp,16
 4ac:	8082                	ret

00000000000004ae <inet_pton>:
inet_pton (int family, const char *p, void *n) {
    char *sp, *ep;
    int idx;
    long ret;

    if (family != AF_INET) {
 4ae:	4785                	li	a5,1
 4b0:	08f51263          	bne	a0,a5,534 <inet_pton+0x86>
inet_pton (int family, const char *p, void *n) {
 4b4:	715d                	add	sp,sp,-80
 4b6:	e486                	sd	ra,72(sp)
 4b8:	e0a2                	sd	s0,64(sp)
 4ba:	fc26                	sd	s1,56(sp)
 4bc:	f84a                	sd	s2,48(sp)
 4be:	f44e                	sd	s3,40(sp)
 4c0:	f052                	sd	s4,32(sp)
 4c2:	ec56                	sd	s5,24(sp)
 4c4:	e85a                	sd	s6,16(sp)
 4c6:	0880                	add	s0,sp,80
 4c8:	892e                	mv	s2,a1
 4ca:	89b2                	mv	s3,a2
 4cc:	4481                	li	s1,0
        return -1;
    }
    sp = (char *)p;
    for (idx = 0; idx < 4; idx++) {
        ret = strtol(sp, &ep, 10);
        if (ret < 0 || ret > 255) {
 4ce:	0ff00a13          	li	s4,255
            return -1;
        }
        if (ep == sp) {
            return -1;
        }
        if ((idx == 3 && *ep != '\0') || (idx != 3 && *ep != '.')) {
 4d2:	4a8d                	li	s5,3
 4d4:	02e00b13          	li	s6,46
 4d8:	a815                	j	50c <inet_pton+0x5e>
 4da:	0007c783          	lbu	a5,0(a5)
 4de:	e3ad                	bnez	a5,540 <inet_pton+0x92>
            return -1;
        }
        ((uint8_t *)n)[idx] = ret;
 4e0:	2481                	sext.w	s1,s1
 4e2:	99a6                	add	s3,s3,s1
 4e4:	00a98023          	sb	a0,0(s3)
        sp = ep + 1;
    }
    return 0;
 4e8:	4501                	li	a0,0
}
 4ea:	60a6                	ld	ra,72(sp)
 4ec:	6406                	ld	s0,64(sp)
 4ee:	74e2                	ld	s1,56(sp)
 4f0:	7942                	ld	s2,48(sp)
 4f2:	79a2                	ld	s3,40(sp)
 4f4:	7a02                	ld	s4,32(sp)
 4f6:	6ae2                	ld	s5,24(sp)
 4f8:	6b42                	ld	s6,16(sp)
 4fa:	6161                	add	sp,sp,80
 4fc:	8082                	ret
        ((uint8_t *)n)[idx] = ret;
 4fe:	00998733          	add	a4,s3,s1
 502:	00a70023          	sb	a0,0(a4)
        sp = ep + 1;
 506:	00178913          	add	s2,a5,1
    for (idx = 0; idx < 4; idx++) {
 50a:	0485                	add	s1,s1,1
        ret = strtol(sp, &ep, 10);
 50c:	4629                	li	a2,10
 50e:	fb840593          	add	a1,s0,-72
 512:	854a                	mv	a0,s2
 514:	ed1ff0ef          	jal	3e4 <strtol>
        if (ret < 0 || ret > 255) {
 518:	02aa6063          	bltu	s4,a0,538 <inet_pton+0x8a>
        if (ep == sp) {
 51c:	fb843783          	ld	a5,-72(s0)
 520:	01278e63          	beq	a5,s2,53c <inet_pton+0x8e>
        if ((idx == 3 && *ep != '\0') || (idx != 3 && *ep != '.')) {
 524:	fb548be3          	beq	s1,s5,4da <inet_pton+0x2c>
 528:	0007c703          	lbu	a4,0(a5)
 52c:	fd6709e3          	beq	a4,s6,4fe <inet_pton+0x50>
            return -1;
 530:	557d                	li	a0,-1
 532:	bf65                	j	4ea <inet_pton+0x3c>
        return -1;
 534:	557d                	li	a0,-1
}
 536:	8082                	ret
            return -1;
 538:	557d                	li	a0,-1
 53a:	bf45                	j	4ea <inet_pton+0x3c>
            return -1;
 53c:	557d                	li	a0,-1
 53e:	b775                	j	4ea <inet_pton+0x3c>
            return -1;
 540:	557d                	li	a0,-1
 542:	b765                	j	4ea <inet_pton+0x3c>

0000000000000544 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 544:	4885                	li	a7,1
 ecall
 546:	00000073          	ecall
 ret
 54a:	8082                	ret

000000000000054c <exit>:
.global exit
exit:
 li a7, SYS_exit
 54c:	4889                	li	a7,2
 ecall
 54e:	00000073          	ecall
 ret
 552:	8082                	ret

0000000000000554 <wait>:
.global wait
wait:
 li a7, SYS_wait
 554:	488d                	li	a7,3
 ecall
 556:	00000073          	ecall
 ret
 55a:	8082                	ret

000000000000055c <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 55c:	4891                	li	a7,4
 ecall
 55e:	00000073          	ecall
 ret
 562:	8082                	ret

0000000000000564 <read>:
.global read
read:
 li a7, SYS_read
 564:	4895                	li	a7,5
 ecall
 566:	00000073          	ecall
 ret
 56a:	8082                	ret

000000000000056c <write>:
.global write
write:
 li a7, SYS_write
 56c:	48c1                	li	a7,16
 ecall
 56e:	00000073          	ecall
 ret
 572:	8082                	ret

0000000000000574 <close>:
.global close
close:
 li a7, SYS_close
 574:	48d5                	li	a7,21
 ecall
 576:	00000073          	ecall
 ret
 57a:	8082                	ret

000000000000057c <kill>:
.global kill
kill:
 li a7, SYS_kill
 57c:	4899                	li	a7,6
 ecall
 57e:	00000073          	ecall
 ret
 582:	8082                	ret

0000000000000584 <exec>:
.global exec
exec:
 li a7, SYS_exec
 584:	489d                	li	a7,7
 ecall
 586:	00000073          	ecall
 ret
 58a:	8082                	ret

000000000000058c <open>:
.global open
open:
 li a7, SYS_open
 58c:	48bd                	li	a7,15
 ecall
 58e:	00000073          	ecall
 ret
 592:	8082                	ret

0000000000000594 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 594:	48c5                	li	a7,17
 ecall
 596:	00000073          	ecall
 ret
 59a:	8082                	ret

000000000000059c <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 59c:	48c9                	li	a7,18
 ecall
 59e:	00000073          	ecall
 ret
 5a2:	8082                	ret

00000000000005a4 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 5a4:	48a1                	li	a7,8
 ecall
 5a6:	00000073          	ecall
 ret
 5aa:	8082                	ret

00000000000005ac <link>:
.global link
link:
 li a7, SYS_link
 5ac:	48cd                	li	a7,19
 ecall
 5ae:	00000073          	ecall
 ret
 5b2:	8082                	ret

00000000000005b4 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 5b4:	48d1                	li	a7,20
 ecall
 5b6:	00000073          	ecall
 ret
 5ba:	8082                	ret

00000000000005bc <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 5bc:	48a5                	li	a7,9
 ecall
 5be:	00000073          	ecall
 ret
 5c2:	8082                	ret

00000000000005c4 <dup>:
.global dup
dup:
 li a7, SYS_dup
 5c4:	48a9                	li	a7,10
 ecall
 5c6:	00000073          	ecall
 ret
 5ca:	8082                	ret

00000000000005cc <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 5cc:	48ad                	li	a7,11
 ecall
 5ce:	00000073          	ecall
 ret
 5d2:	8082                	ret

00000000000005d4 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 5d4:	48b1                	li	a7,12
 ecall
 5d6:	00000073          	ecall
 ret
 5da:	8082                	ret

00000000000005dc <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 5dc:	48b5                	li	a7,13
 ecall
 5de:	00000073          	ecall
 ret
 5e2:	8082                	ret

00000000000005e4 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 5e4:	48b9                	li	a7,14
 ecall
 5e6:	00000073          	ecall
 ret
 5ea:	8082                	ret

00000000000005ec <socket>:
.global socket
socket:
 li a7, SYS_socket
 5ec:	48d9                	li	a7,22
 ecall
 5ee:	00000073          	ecall
 ret
 5f2:	8082                	ret

00000000000005f4 <bind>:
.global bind
bind:
 li a7, SYS_bind
 5f4:	48dd                	li	a7,23
 ecall
 5f6:	00000073          	ecall
 ret
 5fa:	8082                	ret

00000000000005fc <recvfrom>:
.global recvfrom
recvfrom:
 li a7, SYS_recvfrom
 5fc:	48e1                	li	a7,24
 ecall
 5fe:	00000073          	ecall
 ret
 602:	8082                	ret

0000000000000604 <sendto>:
.global sendto
sendto:
 li a7, SYS_sendto
 604:	48e5                	li	a7,25
 ecall
 606:	00000073          	ecall
 ret
 60a:	8082                	ret

000000000000060c <connect>:
.global connect
connect:
 li a7, SYS_connect
 60c:	48e9                	li	a7,26
 ecall
 60e:	00000073          	ecall
 ret
 612:	8082                	ret

0000000000000614 <listen>:
.global listen
listen:
 li a7, SYS_listen
 614:	48ed                	li	a7,27
 ecall
 616:	00000073          	ecall
 ret
 61a:	8082                	ret

000000000000061c <accept>:
.global accept
accept:
 li a7, SYS_accept
 61c:	48f1                	li	a7,28
 ecall
 61e:	00000073          	ecall
 ret
 622:	8082                	ret

0000000000000624 <recv>:
.global recv
recv:
 li a7, SYS_recv
 624:	48f5                	li	a7,29
 ecall
 626:	00000073          	ecall
 ret
 62a:	8082                	ret

000000000000062c <send>:
.global send
send:
 li a7, SYS_send
 62c:	48f9                	li	a7,30
 ecall
 62e:	00000073          	ecall
 ret
 632:	8082                	ret

0000000000000634 <ioctl>:
.global ioctl
ioctl:
 li a7, SYS_ioctl
 634:	48fd                	li	a7,31
 ecall
 636:	00000073          	ecall
 ret
 63a:	8082                	ret

000000000000063c <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 63c:	1101                	add	sp,sp,-32
 63e:	ec06                	sd	ra,24(sp)
 640:	e822                	sd	s0,16(sp)
 642:	1000                	add	s0,sp,32
 644:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 648:	4605                	li	a2,1
 64a:	fef40593          	add	a1,s0,-17
 64e:	f1fff0ef          	jal	56c <write>
}
 652:	60e2                	ld	ra,24(sp)
 654:	6442                	ld	s0,16(sp)
 656:	6105                	add	sp,sp,32
 658:	8082                	ret

000000000000065a <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
 65a:	715d                	add	sp,sp,-80
 65c:	e486                	sd	ra,72(sp)
 65e:	e0a2                	sd	s0,64(sp)
 660:	fc26                	sd	s1,56(sp)
 662:	f84a                	sd	s2,48(sp)
 664:	f44e                	sd	s3,40(sp)
 666:	0880                	add	s0,sp,80
 668:	84aa                	mv	s1,a0
  char buf[20];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 66a:	c299                	beqz	a3,670 <printint+0x16>
 66c:	0805c763          	bltz	a1,6fa <printint+0xa0>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 670:	2581                	sext.w	a1,a1
  neg = 0;
 672:	4881                	li	a7,0
 674:	fb840693          	add	a3,s0,-72
  }

  i = 0;
 678:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 67a:	2601                	sext.w	a2,a2
 67c:	00000517          	auipc	a0,0x0
 680:	51450513          	add	a0,a0,1300 # b90 <digits>
 684:	883a                	mv	a6,a4
 686:	2705                	addw	a4,a4,1
 688:	02c5f7bb          	remuw	a5,a1,a2
 68c:	1782                	sll	a5,a5,0x20
 68e:	9381                	srl	a5,a5,0x20
 690:	97aa                	add	a5,a5,a0
 692:	0007c783          	lbu	a5,0(a5)
 696:	00f68023          	sb	a5,0(a3) # ff0000 <base+0xfeeff0>
  }while((x /= base) != 0);
 69a:	0005879b          	sext.w	a5,a1
 69e:	02c5d5bb          	divuw	a1,a1,a2
 6a2:	0685                	add	a3,a3,1
 6a4:	fec7f0e3          	bgeu	a5,a2,684 <printint+0x2a>
  if(neg)
 6a8:	00088c63          	beqz	a7,6c0 <printint+0x66>
    buf[i++] = '-';
 6ac:	fd070793          	add	a5,a4,-48
 6b0:	00878733          	add	a4,a5,s0
 6b4:	02d00793          	li	a5,45
 6b8:	fef70423          	sb	a5,-24(a4)
 6bc:	0028071b          	addw	a4,a6,2

  while(--i >= 0)
 6c0:	02e05663          	blez	a4,6ec <printint+0x92>
 6c4:	fb840793          	add	a5,s0,-72
 6c8:	00e78933          	add	s2,a5,a4
 6cc:	fff78993          	add	s3,a5,-1
 6d0:	99ba                	add	s3,s3,a4
 6d2:	377d                	addw	a4,a4,-1
 6d4:	1702                	sll	a4,a4,0x20
 6d6:	9301                	srl	a4,a4,0x20
 6d8:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 6dc:	fff94583          	lbu	a1,-1(s2)
 6e0:	8526                	mv	a0,s1
 6e2:	f5bff0ef          	jal	63c <putc>
  while(--i >= 0)
 6e6:	197d                	add	s2,s2,-1
 6e8:	ff391ae3          	bne	s2,s3,6dc <printint+0x82>
}
 6ec:	60a6                	ld	ra,72(sp)
 6ee:	6406                	ld	s0,64(sp)
 6f0:	74e2                	ld	s1,56(sp)
 6f2:	7942                	ld	s2,48(sp)
 6f4:	79a2                	ld	s3,40(sp)
 6f6:	6161                	add	sp,sp,80
 6f8:	8082                	ret
    x = -xx;
 6fa:	40b005bb          	negw	a1,a1
    neg = 1;
 6fe:	4885                	li	a7,1
    x = -xx;
 700:	bf95                	j	674 <printint+0x1a>

0000000000000702 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 702:	711d                	add	sp,sp,-96
 704:	ec86                	sd	ra,88(sp)
 706:	e8a2                	sd	s0,80(sp)
 708:	e4a6                	sd	s1,72(sp)
 70a:	e0ca                	sd	s2,64(sp)
 70c:	fc4e                	sd	s3,56(sp)
 70e:	f852                	sd	s4,48(sp)
 710:	f456                	sd	s5,40(sp)
 712:	f05a                	sd	s6,32(sp)
 714:	ec5e                	sd	s7,24(sp)
 716:	e862                	sd	s8,16(sp)
 718:	e466                	sd	s9,8(sp)
 71a:	e06a                	sd	s10,0(sp)
 71c:	1080                	add	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 71e:	0005c903          	lbu	s2,0(a1)
 722:	24090763          	beqz	s2,970 <vprintf+0x26e>
 726:	8b2a                	mv	s6,a0
 728:	8a2e                	mv	s4,a1
 72a:	8bb2                	mv	s7,a2
  state = 0;
 72c:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
 72e:	4481                	li	s1,0
 730:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
 732:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
 736:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
 73a:	06c00c93          	li	s9,108
 73e:	a005                	j	75e <vprintf+0x5c>
        putc(fd, c0);
 740:	85ca                	mv	a1,s2
 742:	855a                	mv	a0,s6
 744:	ef9ff0ef          	jal	63c <putc>
 748:	a019                	j	74e <vprintf+0x4c>
    } else if(state == '%'){
 74a:	03598263          	beq	s3,s5,76e <vprintf+0x6c>
  for(i = 0; fmt[i]; i++){
 74e:	2485                	addw	s1,s1,1
 750:	8726                	mv	a4,s1
 752:	009a07b3          	add	a5,s4,s1
 756:	0007c903          	lbu	s2,0(a5)
 75a:	20090b63          	beqz	s2,970 <vprintf+0x26e>
    c0 = fmt[i] & 0xff;
 75e:	0009079b          	sext.w	a5,s2
    if(state == 0){
 762:	fe0994e3          	bnez	s3,74a <vprintf+0x48>
      if(c0 == '%'){
 766:	fd579de3          	bne	a5,s5,740 <vprintf+0x3e>
        state = '%';
 76a:	89be                	mv	s3,a5
 76c:	b7cd                	j	74e <vprintf+0x4c>
      if(c0) c1 = fmt[i+1] & 0xff;
 76e:	c7c9                	beqz	a5,7f8 <vprintf+0xf6>
 770:	00ea06b3          	add	a3,s4,a4
 774:	0016c683          	lbu	a3,1(a3)
      c1 = c2 = 0;
 778:	8636                	mv	a2,a3
      if(c1) c2 = fmt[i+2] & 0xff;
 77a:	c681                	beqz	a3,782 <vprintf+0x80>
 77c:	9752                	add	a4,a4,s4
 77e:	00274603          	lbu	a2,2(a4)
      if(c0 == 'd'){
 782:	03878f63          	beq	a5,s8,7c0 <vprintf+0xbe>
      } else if(c0 == 'l' && c1 == 'd'){
 786:	05978963          	beq	a5,s9,7d8 <vprintf+0xd6>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
 78a:	07500713          	li	a4,117
 78e:	0ee78363          	beq	a5,a4,874 <vprintf+0x172>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
 792:	07800713          	li	a4,120
 796:	12e78563          	beq	a5,a4,8c0 <vprintf+0x1be>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
 79a:	07000713          	li	a4,112
 79e:	14e78a63          	beq	a5,a4,8f2 <vprintf+0x1f0>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 's'){
 7a2:	07300713          	li	a4,115
 7a6:	18e78863          	beq	a5,a4,936 <vprintf+0x234>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
 7aa:	02500713          	li	a4,37
 7ae:	04e79563          	bne	a5,a4,7f8 <vprintf+0xf6>
        putc(fd, '%');
 7b2:	02500593          	li	a1,37
 7b6:	855a                	mv	a0,s6
 7b8:	e85ff0ef          	jal	63c <putc>
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
#endif
      state = 0;
 7bc:	4981                	li	s3,0
 7be:	bf41                	j	74e <vprintf+0x4c>
        printint(fd, va_arg(ap, int), 10, 1);
 7c0:	008b8913          	add	s2,s7,8
 7c4:	4685                	li	a3,1
 7c6:	4629                	li	a2,10
 7c8:	000ba583          	lw	a1,0(s7)
 7cc:	855a                	mv	a0,s6
 7ce:	e8dff0ef          	jal	65a <printint>
 7d2:	8bca                	mv	s7,s2
      state = 0;
 7d4:	4981                	li	s3,0
 7d6:	bfa5                	j	74e <vprintf+0x4c>
      } else if(c0 == 'l' && c1 == 'd'){
 7d8:	06400793          	li	a5,100
 7dc:	02f68963          	beq	a3,a5,80e <vprintf+0x10c>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 7e0:	06c00793          	li	a5,108
 7e4:	04f68263          	beq	a3,a5,828 <vprintf+0x126>
      } else if(c0 == 'l' && c1 == 'u'){
 7e8:	07500793          	li	a5,117
 7ec:	0af68063          	beq	a3,a5,88c <vprintf+0x18a>
      } else if(c0 == 'l' && c1 == 'x'){
 7f0:	07800793          	li	a5,120
 7f4:	0ef68263          	beq	a3,a5,8d8 <vprintf+0x1d6>
        putc(fd, '%');
 7f8:	02500593          	li	a1,37
 7fc:	855a                	mv	a0,s6
 7fe:	e3fff0ef          	jal	63c <putc>
        putc(fd, c0);
 802:	85ca                	mv	a1,s2
 804:	855a                	mv	a0,s6
 806:	e37ff0ef          	jal	63c <putc>
      state = 0;
 80a:	4981                	li	s3,0
 80c:	b789                	j	74e <vprintf+0x4c>
        printint(fd, va_arg(ap, uint64), 10, 1);
 80e:	008b8913          	add	s2,s7,8
 812:	4685                	li	a3,1
 814:	4629                	li	a2,10
 816:	000bb583          	ld	a1,0(s7)
 81a:	855a                	mv	a0,s6
 81c:	e3fff0ef          	jal	65a <printint>
        i += 1;
 820:	2485                	addw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 822:	8bca                	mv	s7,s2
      state = 0;
 824:	4981                	li	s3,0
        i += 1;
 826:	b725                	j	74e <vprintf+0x4c>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 828:	06400793          	li	a5,100
 82c:	02f60763          	beq	a2,a5,85a <vprintf+0x158>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 830:	07500793          	li	a5,117
 834:	06f60963          	beq	a2,a5,8a6 <vprintf+0x1a4>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 838:	07800793          	li	a5,120
 83c:	faf61ee3          	bne	a2,a5,7f8 <vprintf+0xf6>
        printint(fd, va_arg(ap, uint64), 16, 0);
 840:	008b8913          	add	s2,s7,8
 844:	4681                	li	a3,0
 846:	4641                	li	a2,16
 848:	000bb583          	ld	a1,0(s7)
 84c:	855a                	mv	a0,s6
 84e:	e0dff0ef          	jal	65a <printint>
        i += 2;
 852:	2489                	addw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 854:	8bca                	mv	s7,s2
      state = 0;
 856:	4981                	li	s3,0
        i += 2;
 858:	bddd                	j	74e <vprintf+0x4c>
        printint(fd, va_arg(ap, uint64), 10, 1);
 85a:	008b8913          	add	s2,s7,8
 85e:	4685                	li	a3,1
 860:	4629                	li	a2,10
 862:	000bb583          	ld	a1,0(s7)
 866:	855a                	mv	a0,s6
 868:	df3ff0ef          	jal	65a <printint>
        i += 2;
 86c:	2489                	addw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 86e:	8bca                	mv	s7,s2
      state = 0;
 870:	4981                	li	s3,0
        i += 2;
 872:	bdf1                	j	74e <vprintf+0x4c>
        printint(fd, va_arg(ap, int), 10, 0);
 874:	008b8913          	add	s2,s7,8
 878:	4681                	li	a3,0
 87a:	4629                	li	a2,10
 87c:	000ba583          	lw	a1,0(s7)
 880:	855a                	mv	a0,s6
 882:	dd9ff0ef          	jal	65a <printint>
 886:	8bca                	mv	s7,s2
      state = 0;
 888:	4981                	li	s3,0
 88a:	b5d1                	j	74e <vprintf+0x4c>
        printint(fd, va_arg(ap, uint64), 10, 0);
 88c:	008b8913          	add	s2,s7,8
 890:	4681                	li	a3,0
 892:	4629                	li	a2,10
 894:	000bb583          	ld	a1,0(s7)
 898:	855a                	mv	a0,s6
 89a:	dc1ff0ef          	jal	65a <printint>
        i += 1;
 89e:	2485                	addw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 8a0:	8bca                	mv	s7,s2
      state = 0;
 8a2:	4981                	li	s3,0
        i += 1;
 8a4:	b56d                	j	74e <vprintf+0x4c>
        printint(fd, va_arg(ap, uint64), 10, 0);
 8a6:	008b8913          	add	s2,s7,8
 8aa:	4681                	li	a3,0
 8ac:	4629                	li	a2,10
 8ae:	000bb583          	ld	a1,0(s7)
 8b2:	855a                	mv	a0,s6
 8b4:	da7ff0ef          	jal	65a <printint>
        i += 2;
 8b8:	2489                	addw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 8ba:	8bca                	mv	s7,s2
      state = 0;
 8bc:	4981                	li	s3,0
        i += 2;
 8be:	bd41                	j	74e <vprintf+0x4c>
        printint(fd, va_arg(ap, int), 16, 0);
 8c0:	008b8913          	add	s2,s7,8
 8c4:	4681                	li	a3,0
 8c6:	4641                	li	a2,16
 8c8:	000ba583          	lw	a1,0(s7)
 8cc:	855a                	mv	a0,s6
 8ce:	d8dff0ef          	jal	65a <printint>
 8d2:	8bca                	mv	s7,s2
      state = 0;
 8d4:	4981                	li	s3,0
 8d6:	bda5                	j	74e <vprintf+0x4c>
        printint(fd, va_arg(ap, uint64), 16, 0);
 8d8:	008b8913          	add	s2,s7,8
 8dc:	4681                	li	a3,0
 8de:	4641                	li	a2,16
 8e0:	000bb583          	ld	a1,0(s7)
 8e4:	855a                	mv	a0,s6
 8e6:	d75ff0ef          	jal	65a <printint>
        i += 1;
 8ea:	2485                	addw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 8ec:	8bca                	mv	s7,s2
      state = 0;
 8ee:	4981                	li	s3,0
        i += 1;
 8f0:	bdb9                	j	74e <vprintf+0x4c>
        printptr(fd, va_arg(ap, uint64));
 8f2:	008b8d13          	add	s10,s7,8
 8f6:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 8fa:	03000593          	li	a1,48
 8fe:	855a                	mv	a0,s6
 900:	d3dff0ef          	jal	63c <putc>
  putc(fd, 'x');
 904:	07800593          	li	a1,120
 908:	855a                	mv	a0,s6
 90a:	d33ff0ef          	jal	63c <putc>
 90e:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 910:	00000b97          	auipc	s7,0x0
 914:	280b8b93          	add	s7,s7,640 # b90 <digits>
 918:	03c9d793          	srl	a5,s3,0x3c
 91c:	97de                	add	a5,a5,s7
 91e:	0007c583          	lbu	a1,0(a5)
 922:	855a                	mv	a0,s6
 924:	d19ff0ef          	jal	63c <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 928:	0992                	sll	s3,s3,0x4
 92a:	397d                	addw	s2,s2,-1
 92c:	fe0916e3          	bnez	s2,918 <vprintf+0x216>
        printptr(fd, va_arg(ap, uint64));
 930:	8bea                	mv	s7,s10
      state = 0;
 932:	4981                	li	s3,0
 934:	bd29                	j	74e <vprintf+0x4c>
        if((s = va_arg(ap, char*)) == 0)
 936:	008b8993          	add	s3,s7,8
 93a:	000bb903          	ld	s2,0(s7)
 93e:	00090f63          	beqz	s2,95c <vprintf+0x25a>
        for(; *s; s++)
 942:	00094583          	lbu	a1,0(s2)
 946:	c195                	beqz	a1,96a <vprintf+0x268>
          putc(fd, *s);
 948:	855a                	mv	a0,s6
 94a:	cf3ff0ef          	jal	63c <putc>
        for(; *s; s++)
 94e:	0905                	add	s2,s2,1
 950:	00094583          	lbu	a1,0(s2)
 954:	f9f5                	bnez	a1,948 <vprintf+0x246>
        if((s = va_arg(ap, char*)) == 0)
 956:	8bce                	mv	s7,s3
      state = 0;
 958:	4981                	li	s3,0
 95a:	bbd5                	j	74e <vprintf+0x4c>
          s = "(null)";
 95c:	00000917          	auipc	s2,0x0
 960:	22c90913          	add	s2,s2,556 # b88 <malloc+0x11e>
        for(; *s; s++)
 964:	02800593          	li	a1,40
 968:	b7c5                	j	948 <vprintf+0x246>
        if((s = va_arg(ap, char*)) == 0)
 96a:	8bce                	mv	s7,s3
      state = 0;
 96c:	4981                	li	s3,0
 96e:	b3c5                	j	74e <vprintf+0x4c>
    }
  }
}
 970:	60e6                	ld	ra,88(sp)
 972:	6446                	ld	s0,80(sp)
 974:	64a6                	ld	s1,72(sp)
 976:	6906                	ld	s2,64(sp)
 978:	79e2                	ld	s3,56(sp)
 97a:	7a42                	ld	s4,48(sp)
 97c:	7aa2                	ld	s5,40(sp)
 97e:	7b02                	ld	s6,32(sp)
 980:	6be2                	ld	s7,24(sp)
 982:	6c42                	ld	s8,16(sp)
 984:	6ca2                	ld	s9,8(sp)
 986:	6d02                	ld	s10,0(sp)
 988:	6125                	add	sp,sp,96
 98a:	8082                	ret

000000000000098c <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 98c:	715d                	add	sp,sp,-80
 98e:	ec06                	sd	ra,24(sp)
 990:	e822                	sd	s0,16(sp)
 992:	1000                	add	s0,sp,32
 994:	e010                	sd	a2,0(s0)
 996:	e414                	sd	a3,8(s0)
 998:	e818                	sd	a4,16(s0)
 99a:	ec1c                	sd	a5,24(s0)
 99c:	03043023          	sd	a6,32(s0)
 9a0:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 9a4:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 9a8:	8622                	mv	a2,s0
 9aa:	d59ff0ef          	jal	702 <vprintf>
}
 9ae:	60e2                	ld	ra,24(sp)
 9b0:	6442                	ld	s0,16(sp)
 9b2:	6161                	add	sp,sp,80
 9b4:	8082                	ret

00000000000009b6 <printf>:

void
printf(const char *fmt, ...)
{
 9b6:	711d                	add	sp,sp,-96
 9b8:	ec06                	sd	ra,24(sp)
 9ba:	e822                	sd	s0,16(sp)
 9bc:	1000                	add	s0,sp,32
 9be:	e40c                	sd	a1,8(s0)
 9c0:	e810                	sd	a2,16(s0)
 9c2:	ec14                	sd	a3,24(s0)
 9c4:	f018                	sd	a4,32(s0)
 9c6:	f41c                	sd	a5,40(s0)
 9c8:	03043823          	sd	a6,48(s0)
 9cc:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 9d0:	00840613          	add	a2,s0,8
 9d4:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 9d8:	85aa                	mv	a1,a0
 9da:	4505                	li	a0,1
 9dc:	d27ff0ef          	jal	702 <vprintf>
}
 9e0:	60e2                	ld	ra,24(sp)
 9e2:	6442                	ld	s0,16(sp)
 9e4:	6125                	add	sp,sp,96
 9e6:	8082                	ret

00000000000009e8 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 9e8:	1141                	add	sp,sp,-16
 9ea:	e422                	sd	s0,8(sp)
 9ec:	0800                	add	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 9ee:	ff050693          	add	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 9f2:	00000797          	auipc	a5,0x0
 9f6:	6167b783          	ld	a5,1558(a5) # 1008 <freep>
 9fa:	a02d                	j	a24 <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 9fc:	4618                	lw	a4,8(a2)
 9fe:	9f2d                	addw	a4,a4,a1
 a00:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 a04:	6398                	ld	a4,0(a5)
 a06:	6310                	ld	a2,0(a4)
 a08:	a83d                	j	a46 <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 a0a:	ff852703          	lw	a4,-8(a0)
 a0e:	9f31                	addw	a4,a4,a2
 a10:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 a12:	ff053683          	ld	a3,-16(a0)
 a16:	a091                	j	a5a <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 a18:	6398                	ld	a4,0(a5)
 a1a:	00e7e463          	bltu	a5,a4,a22 <free+0x3a>
 a1e:	00e6ea63          	bltu	a3,a4,a32 <free+0x4a>
{
 a22:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 a24:	fed7fae3          	bgeu	a5,a3,a18 <free+0x30>
 a28:	6398                	ld	a4,0(a5)
 a2a:	00e6e463          	bltu	a3,a4,a32 <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 a2e:	fee7eae3          	bltu	a5,a4,a22 <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 a32:	ff852583          	lw	a1,-8(a0)
 a36:	6390                	ld	a2,0(a5)
 a38:	02059813          	sll	a6,a1,0x20
 a3c:	01c85713          	srl	a4,a6,0x1c
 a40:	9736                	add	a4,a4,a3
 a42:	fae60de3          	beq	a2,a4,9fc <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 a46:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 a4a:	4790                	lw	a2,8(a5)
 a4c:	02061593          	sll	a1,a2,0x20
 a50:	01c5d713          	srl	a4,a1,0x1c
 a54:	973e                	add	a4,a4,a5
 a56:	fae68ae3          	beq	a3,a4,a0a <free+0x22>
    p->s.ptr = bp->s.ptr;
 a5a:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 a5c:	00000717          	auipc	a4,0x0
 a60:	5af73623          	sd	a5,1452(a4) # 1008 <freep>
}
 a64:	6422                	ld	s0,8(sp)
 a66:	0141                	add	sp,sp,16
 a68:	8082                	ret

0000000000000a6a <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 a6a:	7139                	add	sp,sp,-64
 a6c:	fc06                	sd	ra,56(sp)
 a6e:	f822                	sd	s0,48(sp)
 a70:	f426                	sd	s1,40(sp)
 a72:	f04a                	sd	s2,32(sp)
 a74:	ec4e                	sd	s3,24(sp)
 a76:	e852                	sd	s4,16(sp)
 a78:	e456                	sd	s5,8(sp)
 a7a:	e05a                	sd	s6,0(sp)
 a7c:	0080                	add	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 a7e:	02051493          	sll	s1,a0,0x20
 a82:	9081                	srl	s1,s1,0x20
 a84:	04bd                	add	s1,s1,15
 a86:	8091                	srl	s1,s1,0x4
 a88:	0014899b          	addw	s3,s1,1
 a8c:	0485                	add	s1,s1,1
  if((prevp = freep) == 0){
 a8e:	00000517          	auipc	a0,0x0
 a92:	57a53503          	ld	a0,1402(a0) # 1008 <freep>
 a96:	c515                	beqz	a0,ac2 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a98:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 a9a:	4798                	lw	a4,8(a5)
 a9c:	02977f63          	bgeu	a4,s1,ada <malloc+0x70>
  if(nu < 4096)
 aa0:	8a4e                	mv	s4,s3
 aa2:	0009871b          	sext.w	a4,s3
 aa6:	6685                	lui	a3,0x1
 aa8:	00d77363          	bgeu	a4,a3,aae <malloc+0x44>
 aac:	6a05                	lui	s4,0x1
 aae:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 ab2:	004a1a1b          	sllw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 ab6:	00000917          	auipc	s2,0x0
 aba:	55290913          	add	s2,s2,1362 # 1008 <freep>
  if(p == (char*)-1)
 abe:	5afd                	li	s5,-1
 ac0:	a885                	j	b30 <malloc+0xc6>
    base.s.ptr = freep = prevp = &base;
 ac2:	00000797          	auipc	a5,0x0
 ac6:	54e78793          	add	a5,a5,1358 # 1010 <base>
 aca:	00000717          	auipc	a4,0x0
 ace:	52f73f23          	sd	a5,1342(a4) # 1008 <freep>
 ad2:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 ad4:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 ad8:	b7e1                	j	aa0 <malloc+0x36>
      if(p->s.size == nunits)
 ada:	02e48c63          	beq	s1,a4,b12 <malloc+0xa8>
        p->s.size -= nunits;
 ade:	4137073b          	subw	a4,a4,s3
 ae2:	c798                	sw	a4,8(a5)
        p += p->s.size;
 ae4:	02071693          	sll	a3,a4,0x20
 ae8:	01c6d713          	srl	a4,a3,0x1c
 aec:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 aee:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 af2:	00000717          	auipc	a4,0x0
 af6:	50a73b23          	sd	a0,1302(a4) # 1008 <freep>
      return (void*)(p + 1);
 afa:	01078513          	add	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 afe:	70e2                	ld	ra,56(sp)
 b00:	7442                	ld	s0,48(sp)
 b02:	74a2                	ld	s1,40(sp)
 b04:	7902                	ld	s2,32(sp)
 b06:	69e2                	ld	s3,24(sp)
 b08:	6a42                	ld	s4,16(sp)
 b0a:	6aa2                	ld	s5,8(sp)
 b0c:	6b02                	ld	s6,0(sp)
 b0e:	6121                	add	sp,sp,64
 b10:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 b12:	6398                	ld	a4,0(a5)
 b14:	e118                	sd	a4,0(a0)
 b16:	bff1                	j	af2 <malloc+0x88>
  hp->s.size = nu;
 b18:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 b1c:	0541                	add	a0,a0,16
 b1e:	ecbff0ef          	jal	9e8 <free>
  return freep;
 b22:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 b26:	dd61                	beqz	a0,afe <malloc+0x94>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 b28:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 b2a:	4798                	lw	a4,8(a5)
 b2c:	fa9777e3          	bgeu	a4,s1,ada <malloc+0x70>
    if(p == freep)
 b30:	00093703          	ld	a4,0(s2)
 b34:	853e                	mv	a0,a5
 b36:	fef719e3          	bne	a4,a5,b28 <malloc+0xbe>
  p = sbrk(nu * sizeof(Header));
 b3a:	8552                	mv	a0,s4
 b3c:	a99ff0ef          	jal	5d4 <sbrk>
  if(p == (char*)-1)
 b40:	fd551ce3          	bne	a0,s5,b18 <malloc+0xae>
        return 0;
 b44:	4501                	li	a0,0
 b46:	bf65                	j	afe <malloc+0x94>
