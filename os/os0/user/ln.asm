
user/_ln:     file format elf64-littleriscv


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
   8:	1000                	add	s0,sp,32
  if(argc != 3){
   a:	478d                	li	a5,3
   c:	00f50c63          	beq	a0,a5,24 <main+0x24>
    fprintf(2, "Usage: ln old new\n");
  10:	00001597          	auipc	a1,0x1
  14:	b3058593          	add	a1,a1,-1232 # b40 <malloc+0xec>
  18:	4509                	li	a0,2
  1a:	15d000ef          	jal	976 <fprintf>
    exit(1);
  1e:	4505                	li	a0,1
  20:	516000ef          	jal	536 <exit>
  24:	84ae                	mv	s1,a1
  }
  if(link(argv[1], argv[2]) < 0)
  26:	698c                	ld	a1,16(a1)
  28:	6488                	ld	a0,8(s1)
  2a:	56c000ef          	jal	596 <link>
  2e:	00054563          	bltz	a0,38 <main+0x38>
    fprintf(2, "link %s %s: failed\n", argv[1], argv[2]);
  exit(0);
  32:	4501                	li	a0,0
  34:	502000ef          	jal	536 <exit>
    fprintf(2, "link %s %s: failed\n", argv[1], argv[2]);
  38:	6894                	ld	a3,16(s1)
  3a:	6490                	ld	a2,8(s1)
  3c:	00001597          	auipc	a1,0x1
  40:	b1c58593          	add	a1,a1,-1252 # b58 <malloc+0x104>
  44:	4509                	li	a0,2
  46:	131000ef          	jal	976 <fprintf>
  4a:	b7e5                	j	32 <main+0x32>

000000000000004c <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start()
{
  4c:	1141                	add	sp,sp,-16
  4e:	e406                	sd	ra,8(sp)
  50:	e022                	sd	s0,0(sp)
  52:	0800                	add	s0,sp,16
  extern int main();
  main();
  54:	fadff0ef          	jal	0 <main>
  exit(0);
  58:	4501                	li	a0,0
  5a:	4dc000ef          	jal	536 <exit>

000000000000005e <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
  5e:	1141                	add	sp,sp,-16
  60:	e422                	sd	s0,8(sp)
  62:	0800                	add	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  64:	87aa                	mv	a5,a0
  66:	0585                	add	a1,a1,1
  68:	0785                	add	a5,a5,1
  6a:	fff5c703          	lbu	a4,-1(a1)
  6e:	fee78fa3          	sb	a4,-1(a5)
  72:	fb75                	bnez	a4,66 <strcpy+0x8>
    ;
  return os;
}
  74:	6422                	ld	s0,8(sp)
  76:	0141                	add	sp,sp,16
  78:	8082                	ret

000000000000007a <strcmp>:

int
strcmp(const char *p, const char *q)
{
  7a:	1141                	add	sp,sp,-16
  7c:	e422                	sd	s0,8(sp)
  7e:	0800                	add	s0,sp,16
  while(*p && *p == *q)
  80:	00054783          	lbu	a5,0(a0)
  84:	cb91                	beqz	a5,98 <strcmp+0x1e>
  86:	0005c703          	lbu	a4,0(a1)
  8a:	00f71763          	bne	a4,a5,98 <strcmp+0x1e>
    p++, q++;
  8e:	0505                	add	a0,a0,1
  90:	0585                	add	a1,a1,1
  while(*p && *p == *q)
  92:	00054783          	lbu	a5,0(a0)
  96:	fbe5                	bnez	a5,86 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
  98:	0005c503          	lbu	a0,0(a1)
}
  9c:	40a7853b          	subw	a0,a5,a0
  a0:	6422                	ld	s0,8(sp)
  a2:	0141                	add	sp,sp,16
  a4:	8082                	ret

00000000000000a6 <strlen>:

uint
strlen(const char *s)
{
  a6:	1141                	add	sp,sp,-16
  a8:	e422                	sd	s0,8(sp)
  aa:	0800                	add	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
  ac:	00054783          	lbu	a5,0(a0)
  b0:	cf91                	beqz	a5,cc <strlen+0x26>
  b2:	0505                	add	a0,a0,1
  b4:	87aa                	mv	a5,a0
  b6:	86be                	mv	a3,a5
  b8:	0785                	add	a5,a5,1
  ba:	fff7c703          	lbu	a4,-1(a5)
  be:	ff65                	bnez	a4,b6 <strlen+0x10>
  c0:	40a6853b          	subw	a0,a3,a0
  c4:	2505                	addw	a0,a0,1
    ;
  return n;
}
  c6:	6422                	ld	s0,8(sp)
  c8:	0141                	add	sp,sp,16
  ca:	8082                	ret
  for(n = 0; s[n]; n++)
  cc:	4501                	li	a0,0
  ce:	bfe5                	j	c6 <strlen+0x20>

00000000000000d0 <memset>:

void*
memset(void *dst, int c, uint n)
{
  d0:	1141                	add	sp,sp,-16
  d2:	e422                	sd	s0,8(sp)
  d4:	0800                	add	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
  d6:	ca19                	beqz	a2,ec <memset+0x1c>
  d8:	87aa                	mv	a5,a0
  da:	1602                	sll	a2,a2,0x20
  dc:	9201                	srl	a2,a2,0x20
  de:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
  e2:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
  e6:	0785                	add	a5,a5,1
  e8:	fee79de3          	bne	a5,a4,e2 <memset+0x12>
  }
  return dst;
}
  ec:	6422                	ld	s0,8(sp)
  ee:	0141                	add	sp,sp,16
  f0:	8082                	ret

00000000000000f2 <strchr>:

char*
strchr(const char *s, char c)
{
  f2:	1141                	add	sp,sp,-16
  f4:	e422                	sd	s0,8(sp)
  f6:	0800                	add	s0,sp,16
  for(; *s; s++)
  f8:	00054783          	lbu	a5,0(a0)
  fc:	cb99                	beqz	a5,112 <strchr+0x20>
    if(*s == c)
  fe:	00f58763          	beq	a1,a5,10c <strchr+0x1a>
  for(; *s; s++)
 102:	0505                	add	a0,a0,1
 104:	00054783          	lbu	a5,0(a0)
 108:	fbfd                	bnez	a5,fe <strchr+0xc>
      return (char*)s;
  return 0;
 10a:	4501                	li	a0,0
}
 10c:	6422                	ld	s0,8(sp)
 10e:	0141                	add	sp,sp,16
 110:	8082                	ret
  return 0;
 112:	4501                	li	a0,0
 114:	bfe5                	j	10c <strchr+0x1a>

0000000000000116 <gets>:

char*
gets(char *buf, int max)
{
 116:	711d                	add	sp,sp,-96
 118:	ec86                	sd	ra,88(sp)
 11a:	e8a2                	sd	s0,80(sp)
 11c:	e4a6                	sd	s1,72(sp)
 11e:	e0ca                	sd	s2,64(sp)
 120:	fc4e                	sd	s3,56(sp)
 122:	f852                	sd	s4,48(sp)
 124:	f456                	sd	s5,40(sp)
 126:	f05a                	sd	s6,32(sp)
 128:	ec5e                	sd	s7,24(sp)
 12a:	1080                	add	s0,sp,96
 12c:	8baa                	mv	s7,a0
 12e:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 130:	892a                	mv	s2,a0
 132:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 134:	4aa9                	li	s5,10
 136:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 138:	89a6                	mv	s3,s1
 13a:	2485                	addw	s1,s1,1
 13c:	0344d663          	bge	s1,s4,168 <gets+0x52>
    cc = read(0, &c, 1);
 140:	4605                	li	a2,1
 142:	faf40593          	add	a1,s0,-81
 146:	4501                	li	a0,0
 148:	406000ef          	jal	54e <read>
    if(cc < 1)
 14c:	00a05e63          	blez	a0,168 <gets+0x52>
    buf[i++] = c;
 150:	faf44783          	lbu	a5,-81(s0)
 154:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 158:	01578763          	beq	a5,s5,166 <gets+0x50>
 15c:	0905                	add	s2,s2,1
 15e:	fd679de3          	bne	a5,s6,138 <gets+0x22>
  for(i=0; i+1 < max; ){
 162:	89a6                	mv	s3,s1
 164:	a011                	j	168 <gets+0x52>
 166:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 168:	99de                	add	s3,s3,s7
 16a:	00098023          	sb	zero,0(s3)
  return buf;
}
 16e:	855e                	mv	a0,s7
 170:	60e6                	ld	ra,88(sp)
 172:	6446                	ld	s0,80(sp)
 174:	64a6                	ld	s1,72(sp)
 176:	6906                	ld	s2,64(sp)
 178:	79e2                	ld	s3,56(sp)
 17a:	7a42                	ld	s4,48(sp)
 17c:	7aa2                	ld	s5,40(sp)
 17e:	7b02                	ld	s6,32(sp)
 180:	6be2                	ld	s7,24(sp)
 182:	6125                	add	sp,sp,96
 184:	8082                	ret

0000000000000186 <stat>:

int
stat(const char *n, struct stat *st)
{
 186:	1101                	add	sp,sp,-32
 188:	ec06                	sd	ra,24(sp)
 18a:	e822                	sd	s0,16(sp)
 18c:	e426                	sd	s1,8(sp)
 18e:	e04a                	sd	s2,0(sp)
 190:	1000                	add	s0,sp,32
 192:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 194:	4581                	li	a1,0
 196:	3e0000ef          	jal	576 <open>
  if(fd < 0)
 19a:	02054163          	bltz	a0,1bc <stat+0x36>
 19e:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 1a0:	85ca                	mv	a1,s2
 1a2:	3ec000ef          	jal	58e <fstat>
 1a6:	892a                	mv	s2,a0
  close(fd);
 1a8:	8526                	mv	a0,s1
 1aa:	3b4000ef          	jal	55e <close>
  return r;
}
 1ae:	854a                	mv	a0,s2
 1b0:	60e2                	ld	ra,24(sp)
 1b2:	6442                	ld	s0,16(sp)
 1b4:	64a2                	ld	s1,8(sp)
 1b6:	6902                	ld	s2,0(sp)
 1b8:	6105                	add	sp,sp,32
 1ba:	8082                	ret
    return -1;
 1bc:	597d                	li	s2,-1
 1be:	bfc5                	j	1ae <stat+0x28>

00000000000001c0 <atoi>:

int
atoi(const char *s)
{
 1c0:	1141                	add	sp,sp,-16
 1c2:	e422                	sd	s0,8(sp)
 1c4:	0800                	add	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 1c6:	00054683          	lbu	a3,0(a0)
 1ca:	fd06879b          	addw	a5,a3,-48
 1ce:	0ff7f793          	zext.b	a5,a5
 1d2:	4625                	li	a2,9
 1d4:	02f66863          	bltu	a2,a5,204 <atoi+0x44>
 1d8:	872a                	mv	a4,a0
  n = 0;
 1da:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 1dc:	0705                	add	a4,a4,1
 1de:	0025179b          	sllw	a5,a0,0x2
 1e2:	9fa9                	addw	a5,a5,a0
 1e4:	0017979b          	sllw	a5,a5,0x1
 1e8:	9fb5                	addw	a5,a5,a3
 1ea:	fd07851b          	addw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 1ee:	00074683          	lbu	a3,0(a4)
 1f2:	fd06879b          	addw	a5,a3,-48
 1f6:	0ff7f793          	zext.b	a5,a5
 1fa:	fef671e3          	bgeu	a2,a5,1dc <atoi+0x1c>
  return n;
}
 1fe:	6422                	ld	s0,8(sp)
 200:	0141                	add	sp,sp,16
 202:	8082                	ret
  n = 0;
 204:	4501                	li	a0,0
 206:	bfe5                	j	1fe <atoi+0x3e>

0000000000000208 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 208:	1141                	add	sp,sp,-16
 20a:	e422                	sd	s0,8(sp)
 20c:	0800                	add	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 20e:	02b57463          	bgeu	a0,a1,236 <memmove+0x2e>
    while(n-- > 0)
 212:	00c05f63          	blez	a2,230 <memmove+0x28>
 216:	1602                	sll	a2,a2,0x20
 218:	9201                	srl	a2,a2,0x20
 21a:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 21e:	872a                	mv	a4,a0
      *dst++ = *src++;
 220:	0585                	add	a1,a1,1
 222:	0705                	add	a4,a4,1
 224:	fff5c683          	lbu	a3,-1(a1)
 228:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 22c:	fee79ae3          	bne	a5,a4,220 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 230:	6422                	ld	s0,8(sp)
 232:	0141                	add	sp,sp,16
 234:	8082                	ret
    dst += n;
 236:	00c50733          	add	a4,a0,a2
    src += n;
 23a:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 23c:	fec05ae3          	blez	a2,230 <memmove+0x28>
 240:	fff6079b          	addw	a5,a2,-1
 244:	1782                	sll	a5,a5,0x20
 246:	9381                	srl	a5,a5,0x20
 248:	fff7c793          	not	a5,a5
 24c:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 24e:	15fd                	add	a1,a1,-1
 250:	177d                	add	a4,a4,-1
 252:	0005c683          	lbu	a3,0(a1)
 256:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 25a:	fee79ae3          	bne	a5,a4,24e <memmove+0x46>
 25e:	bfc9                	j	230 <memmove+0x28>

0000000000000260 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 260:	1141                	add	sp,sp,-16
 262:	e422                	sd	s0,8(sp)
 264:	0800                	add	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 266:	ca05                	beqz	a2,296 <memcmp+0x36>
 268:	fff6069b          	addw	a3,a2,-1
 26c:	1682                	sll	a3,a3,0x20
 26e:	9281                	srl	a3,a3,0x20
 270:	0685                	add	a3,a3,1
 272:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 274:	00054783          	lbu	a5,0(a0)
 278:	0005c703          	lbu	a4,0(a1)
 27c:	00e79863          	bne	a5,a4,28c <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 280:	0505                	add	a0,a0,1
    p2++;
 282:	0585                	add	a1,a1,1
  while (n-- > 0) {
 284:	fed518e3          	bne	a0,a3,274 <memcmp+0x14>
  }
  return 0;
 288:	4501                	li	a0,0
 28a:	a019                	j	290 <memcmp+0x30>
      return *p1 - *p2;
 28c:	40e7853b          	subw	a0,a5,a4
}
 290:	6422                	ld	s0,8(sp)
 292:	0141                	add	sp,sp,16
 294:	8082                	ret
  return 0;
 296:	4501                	li	a0,0
 298:	bfe5                	j	290 <memcmp+0x30>

000000000000029a <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 29a:	1141                	add	sp,sp,-16
 29c:	e406                	sd	ra,8(sp)
 29e:	e022                	sd	s0,0(sp)
 2a0:	0800                	add	s0,sp,16
  return memmove(dst, src, n);
 2a2:	f67ff0ef          	jal	208 <memmove>
}
 2a6:	60a2                	ld	ra,8(sp)
 2a8:	6402                	ld	s0,0(sp)
 2aa:	0141                	add	sp,sp,16
 2ac:	8082                	ret

00000000000002ae <htons>:
    return (v & 0x000000ff) << 24 | (v & 0x0000ff00) << 8 | (v & 0x00ff0000) >> 8 | (v & 0xff000000) >> 24;
}

uint16_t
htons(uint16_t h)
{
 2ae:	1141                	add	sp,sp,-16
 2b0:	e422                	sd	s0,8(sp)
 2b2:	0800                	add	s0,sp,16
    if (!endian) {
 2b4:	00001797          	auipc	a5,0x1
 2b8:	d4c7a783          	lw	a5,-692(a5) # 1000 <endian>
 2bc:	e385                	bnez	a5,2dc <htons+0x2e>
        endian = byteorder();
 2be:	4d200793          	li	a5,1234
 2c2:	00001717          	auipc	a4,0x1
 2c6:	d2f72f23          	sw	a5,-706(a4) # 1000 <endian>
    return (v & 0x00ff) << 8 | (v & 0xff00 ) >> 8;
 2ca:	0085579b          	srlw	a5,a0,0x8
 2ce:	0085151b          	sllw	a0,a0,0x8
 2d2:	8fc9                	or	a5,a5,a0
 2d4:	03079513          	sll	a0,a5,0x30
 2d8:	9141                	srl	a0,a0,0x30
 2da:	a029                	j	2e4 <htons+0x36>
    }
    return endian == __LITTLE_ENDIAN ? byteswap16(h) : h;
 2dc:	4d200713          	li	a4,1234
 2e0:	fee785e3          	beq	a5,a4,2ca <htons+0x1c>
}
 2e4:	6422                	ld	s0,8(sp)
 2e6:	0141                	add	sp,sp,16
 2e8:	8082                	ret

00000000000002ea <ntohs>:

uint16_t
ntohs(uint16_t n)
{
 2ea:	1141                	add	sp,sp,-16
 2ec:	e422                	sd	s0,8(sp)
 2ee:	0800                	add	s0,sp,16
    if (!endian) {
 2f0:	00001797          	auipc	a5,0x1
 2f4:	d107a783          	lw	a5,-752(a5) # 1000 <endian>
 2f8:	e385                	bnez	a5,318 <ntohs+0x2e>
        endian = byteorder();
 2fa:	4d200793          	li	a5,1234
 2fe:	00001717          	auipc	a4,0x1
 302:	d0f72123          	sw	a5,-766(a4) # 1000 <endian>
    return (v & 0x00ff) << 8 | (v & 0xff00 ) >> 8;
 306:	0085579b          	srlw	a5,a0,0x8
 30a:	0085151b          	sllw	a0,a0,0x8
 30e:	8fc9                	or	a5,a5,a0
 310:	03079513          	sll	a0,a5,0x30
 314:	9141                	srl	a0,a0,0x30
 316:	a029                	j	320 <ntohs+0x36>
    }
    return endian == __LITTLE_ENDIAN ? byteswap16(n) : n;
 318:	4d200713          	li	a4,1234
 31c:	fee785e3          	beq	a5,a4,306 <ntohs+0x1c>
}
 320:	6422                	ld	s0,8(sp)
 322:	0141                	add	sp,sp,16
 324:	8082                	ret

0000000000000326 <htonl>:

uint32_t
htonl(uint32_t h)
{
 326:	1141                	add	sp,sp,-16
 328:	e422                	sd	s0,8(sp)
 32a:	0800                	add	s0,sp,16
    if (!endian) {
 32c:	00001797          	auipc	a5,0x1
 330:	cd47a783          	lw	a5,-812(a5) # 1000 <endian>
 334:	ef85                	bnez	a5,36c <htonl+0x46>
        endian = byteorder();
 336:	4d200793          	li	a5,1234
 33a:	00001717          	auipc	a4,0x1
 33e:	ccf72323          	sw	a5,-826(a4) # 1000 <endian>
    return (v & 0x000000ff) << 24 | (v & 0x0000ff00) << 8 | (v & 0x00ff0000) >> 8 | (v & 0xff000000) >> 24;
 342:	0185179b          	sllw	a5,a0,0x18
 346:	0185571b          	srlw	a4,a0,0x18
 34a:	8fd9                	or	a5,a5,a4
 34c:	0085171b          	sllw	a4,a0,0x8
 350:	00ff06b7          	lui	a3,0xff0
 354:	8f75                	and	a4,a4,a3
 356:	8fd9                	or	a5,a5,a4
 358:	0085551b          	srlw	a0,a0,0x8
 35c:	6741                	lui	a4,0x10
 35e:	f0070713          	add	a4,a4,-256 # ff00 <base+0xeef0>
 362:	8d79                	and	a0,a0,a4
 364:	8fc9                	or	a5,a5,a0
 366:	0007851b          	sext.w	a0,a5
 36a:	a029                	j	374 <htonl+0x4e>
    }
    return endian == __LITTLE_ENDIAN ? byteswap32(h) : h;
 36c:	4d200713          	li	a4,1234
 370:	fce789e3          	beq	a5,a4,342 <htonl+0x1c>
}
 374:	6422                	ld	s0,8(sp)
 376:	0141                	add	sp,sp,16
 378:	8082                	ret

000000000000037a <ntohl>:

uint32_t
ntohl(uint32_t n)
{
 37a:	1141                	add	sp,sp,-16
 37c:	e422                	sd	s0,8(sp)
 37e:	0800                	add	s0,sp,16
    if (!endian) {
 380:	00001797          	auipc	a5,0x1
 384:	c807a783          	lw	a5,-896(a5) # 1000 <endian>
 388:	ef85                	bnez	a5,3c0 <ntohl+0x46>
        endian = byteorder();
 38a:	4d200793          	li	a5,1234
 38e:	00001717          	auipc	a4,0x1
 392:	c6f72923          	sw	a5,-910(a4) # 1000 <endian>
    return (v & 0x000000ff) << 24 | (v & 0x0000ff00) << 8 | (v & 0x00ff0000) >> 8 | (v & 0xff000000) >> 24;
 396:	0185179b          	sllw	a5,a0,0x18
 39a:	0185571b          	srlw	a4,a0,0x18
 39e:	8fd9                	or	a5,a5,a4
 3a0:	0085171b          	sllw	a4,a0,0x8
 3a4:	00ff06b7          	lui	a3,0xff0
 3a8:	8f75                	and	a4,a4,a3
 3aa:	8fd9                	or	a5,a5,a4
 3ac:	0085551b          	srlw	a0,a0,0x8
 3b0:	6741                	lui	a4,0x10
 3b2:	f0070713          	add	a4,a4,-256 # ff00 <base+0xeef0>
 3b6:	8d79                	and	a0,a0,a4
 3b8:	8fc9                	or	a5,a5,a0
 3ba:	0007851b          	sext.w	a0,a5
 3be:	a029                	j	3c8 <ntohl+0x4e>
    }
    return endian == __LITTLE_ENDIAN ? byteswap32(n) : n;
 3c0:	4d200713          	li	a4,1234
 3c4:	fce789e3          	beq	a5,a4,396 <ntohl+0x1c>
}
 3c8:	6422                	ld	s0,8(sp)
 3ca:	0141                	add	sp,sp,16
 3cc:	8082                	ret

00000000000003ce <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
 3ce:	1141                	add	sp,sp,-16
 3d0:	e422                	sd	s0,8(sp)
 3d2:	0800                	add	s0,sp,16
 3d4:	872a                	mv	a4,a0
    int neg = 0;
    long val = 0;

    // gobble initial whitespace
    while (*s == ' ' || *s == '\t')
 3d6:	02000693          	li	a3,32
 3da:	4525                	li	a0,9
 3dc:	a011                	j	3e0 <strtol+0x12>
        s++;
 3de:	0705                	add	a4,a4,1
    while (*s == ' ' || *s == '\t')
 3e0:	00074783          	lbu	a5,0(a4)
 3e4:	fed78de3          	beq	a5,a3,3de <strtol+0x10>
 3e8:	fea78be3          	beq	a5,a0,3de <strtol+0x10>

    // plus/minus sign
    if (*s == '+')
 3ec:	02b00693          	li	a3,43
 3f0:	02d78663          	beq	a5,a3,41c <strtol+0x4e>
        s++;
    else if (*s == '-')
 3f4:	02d00693          	li	a3,45
    int neg = 0;
 3f8:	4301                	li	t1,0
    else if (*s == '-')
 3fa:	02d78463          	beq	a5,a3,422 <strtol+0x54>
        s++, neg = 1;

    // hex or octal base prefix
    if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
 3fe:	fef67793          	and	a5,a2,-17
 402:	eb89                	bnez	a5,414 <strtol+0x46>
 404:	00074683          	lbu	a3,0(a4)
 408:	03000793          	li	a5,48
 40c:	00f68e63          	beq	a3,a5,428 <strtol+0x5a>
        s += 2, base = 16;
    else if (base == 0 && s[0] == '0')
 410:	e211                	bnez	a2,414 <strtol+0x46>
        s++, base = 8;
    else if (base == 0)
        base = 10;
 412:	4629                	li	a2,10
 414:	4501                	li	a0,0

    // digits
    while (1) {
        int dig;

        if (*s >= '0' && *s <= '9')
 416:	4825                	li	a6,9
            dig = *s - '0';
        else if (*s >= 'a' && *s <= 'z')
 418:	48e5                	li	a7,25
 41a:	a825                	j	452 <strtol+0x84>
        s++;
 41c:	0705                	add	a4,a4,1
    int neg = 0;
 41e:	4301                	li	t1,0
 420:	bff9                	j	3fe <strtol+0x30>
        s++, neg = 1;
 422:	0705                	add	a4,a4,1
 424:	4305                	li	t1,1
 426:	bfe1                	j	3fe <strtol+0x30>
    if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
 428:	00174683          	lbu	a3,1(a4)
 42c:	07800793          	li	a5,120
 430:	00f68663          	beq	a3,a5,43c <strtol+0x6e>
    else if (base == 0 && s[0] == '0')
 434:	f265                	bnez	a2,414 <strtol+0x46>
        s++, base = 8;
 436:	0705                	add	a4,a4,1
 438:	4621                	li	a2,8
 43a:	bfe9                	j	414 <strtol+0x46>
        s += 2, base = 16;
 43c:	0709                	add	a4,a4,2
 43e:	4641                	li	a2,16
 440:	bfd1                	j	414 <strtol+0x46>
            dig = *s - '0';
 442:	fd07879b          	addw	a5,a5,-48
            dig = *s - 'a' + 10;
        else if (*s >= 'A' && *s <= 'Z')
            dig = *s - 'A' + 10;
        else
            break;
        if (dig >= base)
 446:	04c7d063          	bge	a5,a2,486 <strtol+0xb8>
            break;
        s++, val = (val * base) + dig;
 44a:	0705                	add	a4,a4,1
 44c:	02a60533          	mul	a0,a2,a0
 450:	953e                	add	a0,a0,a5
        if (*s >= '0' && *s <= '9')
 452:	00074783          	lbu	a5,0(a4)
 456:	fd07869b          	addw	a3,a5,-48
 45a:	0ff6f693          	zext.b	a3,a3
 45e:	fed872e3          	bgeu	a6,a3,442 <strtol+0x74>
        else if (*s >= 'a' && *s <= 'z')
 462:	f9f7869b          	addw	a3,a5,-97
 466:	0ff6f693          	zext.b	a3,a3
 46a:	00d8e563          	bltu	a7,a3,474 <strtol+0xa6>
            dig = *s - 'a' + 10;
 46e:	fa97879b          	addw	a5,a5,-87
 472:	bfd1                	j	446 <strtol+0x78>
        else if (*s >= 'A' && *s <= 'Z')
 474:	fbf7869b          	addw	a3,a5,-65
 478:	0ff6f693          	zext.b	a3,a3
 47c:	00d8e563          	bltu	a7,a3,486 <strtol+0xb8>
            dig = *s - 'A' + 10;
 480:	fc97879b          	addw	a5,a5,-55
 484:	b7c9                	j	446 <strtol+0x78>
        // we don't properly detect overflow!
    }

    if (endptr)
 486:	c191                	beqz	a1,48a <strtol+0xbc>
        *endptr = (char *) s;
 488:	e198                	sd	a4,0(a1)
    return (neg ? -val : val);
 48a:	00030463          	beqz	t1,492 <strtol+0xc4>
 48e:	40a00533          	neg	a0,a0
}
 492:	6422                	ld	s0,8(sp)
 494:	0141                	add	sp,sp,16
 496:	8082                	ret

0000000000000498 <inet_pton>:
inet_pton (int family, const char *p, void *n) {
    char *sp, *ep;
    int idx;
    long ret;

    if (family != AF_INET) {
 498:	4785                	li	a5,1
 49a:	08f51263          	bne	a0,a5,51e <inet_pton+0x86>
inet_pton (int family, const char *p, void *n) {
 49e:	715d                	add	sp,sp,-80
 4a0:	e486                	sd	ra,72(sp)
 4a2:	e0a2                	sd	s0,64(sp)
 4a4:	fc26                	sd	s1,56(sp)
 4a6:	f84a                	sd	s2,48(sp)
 4a8:	f44e                	sd	s3,40(sp)
 4aa:	f052                	sd	s4,32(sp)
 4ac:	ec56                	sd	s5,24(sp)
 4ae:	e85a                	sd	s6,16(sp)
 4b0:	0880                	add	s0,sp,80
 4b2:	892e                	mv	s2,a1
 4b4:	89b2                	mv	s3,a2
 4b6:	4481                	li	s1,0
        return -1;
    }
    sp = (char *)p;
    for (idx = 0; idx < 4; idx++) {
        ret = strtol(sp, &ep, 10);
        if (ret < 0 || ret > 255) {
 4b8:	0ff00a13          	li	s4,255
            return -1;
        }
        if (ep == sp) {
            return -1;
        }
        if ((idx == 3 && *ep != '\0') || (idx != 3 && *ep != '.')) {
 4bc:	4a8d                	li	s5,3
 4be:	02e00b13          	li	s6,46
 4c2:	a815                	j	4f6 <inet_pton+0x5e>
 4c4:	0007c783          	lbu	a5,0(a5)
 4c8:	e3ad                	bnez	a5,52a <inet_pton+0x92>
            return -1;
        }
        ((uint8_t *)n)[idx] = ret;
 4ca:	2481                	sext.w	s1,s1
 4cc:	99a6                	add	s3,s3,s1
 4ce:	00a98023          	sb	a0,0(s3)
        sp = ep + 1;
    }
    return 0;
 4d2:	4501                	li	a0,0
}
 4d4:	60a6                	ld	ra,72(sp)
 4d6:	6406                	ld	s0,64(sp)
 4d8:	74e2                	ld	s1,56(sp)
 4da:	7942                	ld	s2,48(sp)
 4dc:	79a2                	ld	s3,40(sp)
 4de:	7a02                	ld	s4,32(sp)
 4e0:	6ae2                	ld	s5,24(sp)
 4e2:	6b42                	ld	s6,16(sp)
 4e4:	6161                	add	sp,sp,80
 4e6:	8082                	ret
        ((uint8_t *)n)[idx] = ret;
 4e8:	00998733          	add	a4,s3,s1
 4ec:	00a70023          	sb	a0,0(a4)
        sp = ep + 1;
 4f0:	00178913          	add	s2,a5,1
    for (idx = 0; idx < 4; idx++) {
 4f4:	0485                	add	s1,s1,1
        ret = strtol(sp, &ep, 10);
 4f6:	4629                	li	a2,10
 4f8:	fb840593          	add	a1,s0,-72
 4fc:	854a                	mv	a0,s2
 4fe:	ed1ff0ef          	jal	3ce <strtol>
        if (ret < 0 || ret > 255) {
 502:	02aa6063          	bltu	s4,a0,522 <inet_pton+0x8a>
        if (ep == sp) {
 506:	fb843783          	ld	a5,-72(s0)
 50a:	01278e63          	beq	a5,s2,526 <inet_pton+0x8e>
        if ((idx == 3 && *ep != '\0') || (idx != 3 && *ep != '.')) {
 50e:	fb548be3          	beq	s1,s5,4c4 <inet_pton+0x2c>
 512:	0007c703          	lbu	a4,0(a5)
 516:	fd6709e3          	beq	a4,s6,4e8 <inet_pton+0x50>
            return -1;
 51a:	557d                	li	a0,-1
 51c:	bf65                	j	4d4 <inet_pton+0x3c>
        return -1;
 51e:	557d                	li	a0,-1
}
 520:	8082                	ret
            return -1;
 522:	557d                	li	a0,-1
 524:	bf45                	j	4d4 <inet_pton+0x3c>
            return -1;
 526:	557d                	li	a0,-1
 528:	b775                	j	4d4 <inet_pton+0x3c>
            return -1;
 52a:	557d                	li	a0,-1
 52c:	b765                	j	4d4 <inet_pton+0x3c>

000000000000052e <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 52e:	4885                	li	a7,1
 ecall
 530:	00000073          	ecall
 ret
 534:	8082                	ret

0000000000000536 <exit>:
.global exit
exit:
 li a7, SYS_exit
 536:	4889                	li	a7,2
 ecall
 538:	00000073          	ecall
 ret
 53c:	8082                	ret

000000000000053e <wait>:
.global wait
wait:
 li a7, SYS_wait
 53e:	488d                	li	a7,3
 ecall
 540:	00000073          	ecall
 ret
 544:	8082                	ret

0000000000000546 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 546:	4891                	li	a7,4
 ecall
 548:	00000073          	ecall
 ret
 54c:	8082                	ret

000000000000054e <read>:
.global read
read:
 li a7, SYS_read
 54e:	4895                	li	a7,5
 ecall
 550:	00000073          	ecall
 ret
 554:	8082                	ret

0000000000000556 <write>:
.global write
write:
 li a7, SYS_write
 556:	48c1                	li	a7,16
 ecall
 558:	00000073          	ecall
 ret
 55c:	8082                	ret

000000000000055e <close>:
.global close
close:
 li a7, SYS_close
 55e:	48d5                	li	a7,21
 ecall
 560:	00000073          	ecall
 ret
 564:	8082                	ret

0000000000000566 <kill>:
.global kill
kill:
 li a7, SYS_kill
 566:	4899                	li	a7,6
 ecall
 568:	00000073          	ecall
 ret
 56c:	8082                	ret

000000000000056e <exec>:
.global exec
exec:
 li a7, SYS_exec
 56e:	489d                	li	a7,7
 ecall
 570:	00000073          	ecall
 ret
 574:	8082                	ret

0000000000000576 <open>:
.global open
open:
 li a7, SYS_open
 576:	48bd                	li	a7,15
 ecall
 578:	00000073          	ecall
 ret
 57c:	8082                	ret

000000000000057e <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 57e:	48c5                	li	a7,17
 ecall
 580:	00000073          	ecall
 ret
 584:	8082                	ret

0000000000000586 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 586:	48c9                	li	a7,18
 ecall
 588:	00000073          	ecall
 ret
 58c:	8082                	ret

000000000000058e <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 58e:	48a1                	li	a7,8
 ecall
 590:	00000073          	ecall
 ret
 594:	8082                	ret

0000000000000596 <link>:
.global link
link:
 li a7, SYS_link
 596:	48cd                	li	a7,19
 ecall
 598:	00000073          	ecall
 ret
 59c:	8082                	ret

000000000000059e <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 59e:	48d1                	li	a7,20
 ecall
 5a0:	00000073          	ecall
 ret
 5a4:	8082                	ret

00000000000005a6 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 5a6:	48a5                	li	a7,9
 ecall
 5a8:	00000073          	ecall
 ret
 5ac:	8082                	ret

00000000000005ae <dup>:
.global dup
dup:
 li a7, SYS_dup
 5ae:	48a9                	li	a7,10
 ecall
 5b0:	00000073          	ecall
 ret
 5b4:	8082                	ret

00000000000005b6 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 5b6:	48ad                	li	a7,11
 ecall
 5b8:	00000073          	ecall
 ret
 5bc:	8082                	ret

00000000000005be <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 5be:	48b1                	li	a7,12
 ecall
 5c0:	00000073          	ecall
 ret
 5c4:	8082                	ret

00000000000005c6 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 5c6:	48b5                	li	a7,13
 ecall
 5c8:	00000073          	ecall
 ret
 5cc:	8082                	ret

00000000000005ce <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 5ce:	48b9                	li	a7,14
 ecall
 5d0:	00000073          	ecall
 ret
 5d4:	8082                	ret

00000000000005d6 <socket>:
.global socket
socket:
 li a7, SYS_socket
 5d6:	48d9                	li	a7,22
 ecall
 5d8:	00000073          	ecall
 ret
 5dc:	8082                	ret

00000000000005de <bind>:
.global bind
bind:
 li a7, SYS_bind
 5de:	48dd                	li	a7,23
 ecall
 5e0:	00000073          	ecall
 ret
 5e4:	8082                	ret

00000000000005e6 <recvfrom>:
.global recvfrom
recvfrom:
 li a7, SYS_recvfrom
 5e6:	48e1                	li	a7,24
 ecall
 5e8:	00000073          	ecall
 ret
 5ec:	8082                	ret

00000000000005ee <sendto>:
.global sendto
sendto:
 li a7, SYS_sendto
 5ee:	48e5                	li	a7,25
 ecall
 5f0:	00000073          	ecall
 ret
 5f4:	8082                	ret

00000000000005f6 <connect>:
.global connect
connect:
 li a7, SYS_connect
 5f6:	48e9                	li	a7,26
 ecall
 5f8:	00000073          	ecall
 ret
 5fc:	8082                	ret

00000000000005fe <listen>:
.global listen
listen:
 li a7, SYS_listen
 5fe:	48ed                	li	a7,27
 ecall
 600:	00000073          	ecall
 ret
 604:	8082                	ret

0000000000000606 <accept>:
.global accept
accept:
 li a7, SYS_accept
 606:	48f1                	li	a7,28
 ecall
 608:	00000073          	ecall
 ret
 60c:	8082                	ret

000000000000060e <recv>:
.global recv
recv:
 li a7, SYS_recv
 60e:	48f5                	li	a7,29
 ecall
 610:	00000073          	ecall
 ret
 614:	8082                	ret

0000000000000616 <send>:
.global send
send:
 li a7, SYS_send
 616:	48f9                	li	a7,30
 ecall
 618:	00000073          	ecall
 ret
 61c:	8082                	ret

000000000000061e <ioctl>:
.global ioctl
ioctl:
 li a7, SYS_ioctl
 61e:	48fd                	li	a7,31
 ecall
 620:	00000073          	ecall
 ret
 624:	8082                	ret

0000000000000626 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 626:	1101                	add	sp,sp,-32
 628:	ec06                	sd	ra,24(sp)
 62a:	e822                	sd	s0,16(sp)
 62c:	1000                	add	s0,sp,32
 62e:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 632:	4605                	li	a2,1
 634:	fef40593          	add	a1,s0,-17
 638:	f1fff0ef          	jal	556 <write>
}
 63c:	60e2                	ld	ra,24(sp)
 63e:	6442                	ld	s0,16(sp)
 640:	6105                	add	sp,sp,32
 642:	8082                	ret

0000000000000644 <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
 644:	715d                	add	sp,sp,-80
 646:	e486                	sd	ra,72(sp)
 648:	e0a2                	sd	s0,64(sp)
 64a:	fc26                	sd	s1,56(sp)
 64c:	f84a                	sd	s2,48(sp)
 64e:	f44e                	sd	s3,40(sp)
 650:	0880                	add	s0,sp,80
 652:	84aa                	mv	s1,a0
  char buf[20];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 654:	c299                	beqz	a3,65a <printint+0x16>
 656:	0805c763          	bltz	a1,6e4 <printint+0xa0>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 65a:	2581                	sext.w	a1,a1
  neg = 0;
 65c:	4881                	li	a7,0
 65e:	fb840693          	add	a3,s0,-72
  }

  i = 0;
 662:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 664:	2601                	sext.w	a2,a2
 666:	00000517          	auipc	a0,0x0
 66a:	51250513          	add	a0,a0,1298 # b78 <digits>
 66e:	883a                	mv	a6,a4
 670:	2705                	addw	a4,a4,1
 672:	02c5f7bb          	remuw	a5,a1,a2
 676:	1782                	sll	a5,a5,0x20
 678:	9381                	srl	a5,a5,0x20
 67a:	97aa                	add	a5,a5,a0
 67c:	0007c783          	lbu	a5,0(a5)
 680:	00f68023          	sb	a5,0(a3) # ff0000 <base+0xfeeff0>
  }while((x /= base) != 0);
 684:	0005879b          	sext.w	a5,a1
 688:	02c5d5bb          	divuw	a1,a1,a2
 68c:	0685                	add	a3,a3,1
 68e:	fec7f0e3          	bgeu	a5,a2,66e <printint+0x2a>
  if(neg)
 692:	00088c63          	beqz	a7,6aa <printint+0x66>
    buf[i++] = '-';
 696:	fd070793          	add	a5,a4,-48
 69a:	00878733          	add	a4,a5,s0
 69e:	02d00793          	li	a5,45
 6a2:	fef70423          	sb	a5,-24(a4)
 6a6:	0028071b          	addw	a4,a6,2

  while(--i >= 0)
 6aa:	02e05663          	blez	a4,6d6 <printint+0x92>
 6ae:	fb840793          	add	a5,s0,-72
 6b2:	00e78933          	add	s2,a5,a4
 6b6:	fff78993          	add	s3,a5,-1
 6ba:	99ba                	add	s3,s3,a4
 6bc:	377d                	addw	a4,a4,-1
 6be:	1702                	sll	a4,a4,0x20
 6c0:	9301                	srl	a4,a4,0x20
 6c2:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 6c6:	fff94583          	lbu	a1,-1(s2)
 6ca:	8526                	mv	a0,s1
 6cc:	f5bff0ef          	jal	626 <putc>
  while(--i >= 0)
 6d0:	197d                	add	s2,s2,-1
 6d2:	ff391ae3          	bne	s2,s3,6c6 <printint+0x82>
}
 6d6:	60a6                	ld	ra,72(sp)
 6d8:	6406                	ld	s0,64(sp)
 6da:	74e2                	ld	s1,56(sp)
 6dc:	7942                	ld	s2,48(sp)
 6de:	79a2                	ld	s3,40(sp)
 6e0:	6161                	add	sp,sp,80
 6e2:	8082                	ret
    x = -xx;
 6e4:	40b005bb          	negw	a1,a1
    neg = 1;
 6e8:	4885                	li	a7,1
    x = -xx;
 6ea:	bf95                	j	65e <printint+0x1a>

00000000000006ec <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 6ec:	711d                	add	sp,sp,-96
 6ee:	ec86                	sd	ra,88(sp)
 6f0:	e8a2                	sd	s0,80(sp)
 6f2:	e4a6                	sd	s1,72(sp)
 6f4:	e0ca                	sd	s2,64(sp)
 6f6:	fc4e                	sd	s3,56(sp)
 6f8:	f852                	sd	s4,48(sp)
 6fa:	f456                	sd	s5,40(sp)
 6fc:	f05a                	sd	s6,32(sp)
 6fe:	ec5e                	sd	s7,24(sp)
 700:	e862                	sd	s8,16(sp)
 702:	e466                	sd	s9,8(sp)
 704:	e06a                	sd	s10,0(sp)
 706:	1080                	add	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 708:	0005c903          	lbu	s2,0(a1)
 70c:	24090763          	beqz	s2,95a <vprintf+0x26e>
 710:	8b2a                	mv	s6,a0
 712:	8a2e                	mv	s4,a1
 714:	8bb2                	mv	s7,a2
  state = 0;
 716:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
 718:	4481                	li	s1,0
 71a:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
 71c:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
 720:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
 724:	06c00c93          	li	s9,108
 728:	a005                	j	748 <vprintf+0x5c>
        putc(fd, c0);
 72a:	85ca                	mv	a1,s2
 72c:	855a                	mv	a0,s6
 72e:	ef9ff0ef          	jal	626 <putc>
 732:	a019                	j	738 <vprintf+0x4c>
    } else if(state == '%'){
 734:	03598263          	beq	s3,s5,758 <vprintf+0x6c>
  for(i = 0; fmt[i]; i++){
 738:	2485                	addw	s1,s1,1
 73a:	8726                	mv	a4,s1
 73c:	009a07b3          	add	a5,s4,s1
 740:	0007c903          	lbu	s2,0(a5)
 744:	20090b63          	beqz	s2,95a <vprintf+0x26e>
    c0 = fmt[i] & 0xff;
 748:	0009079b          	sext.w	a5,s2
    if(state == 0){
 74c:	fe0994e3          	bnez	s3,734 <vprintf+0x48>
      if(c0 == '%'){
 750:	fd579de3          	bne	a5,s5,72a <vprintf+0x3e>
        state = '%';
 754:	89be                	mv	s3,a5
 756:	b7cd                	j	738 <vprintf+0x4c>
      if(c0) c1 = fmt[i+1] & 0xff;
 758:	c7c9                	beqz	a5,7e2 <vprintf+0xf6>
 75a:	00ea06b3          	add	a3,s4,a4
 75e:	0016c683          	lbu	a3,1(a3)
      c1 = c2 = 0;
 762:	8636                	mv	a2,a3
      if(c1) c2 = fmt[i+2] & 0xff;
 764:	c681                	beqz	a3,76c <vprintf+0x80>
 766:	9752                	add	a4,a4,s4
 768:	00274603          	lbu	a2,2(a4)
      if(c0 == 'd'){
 76c:	03878f63          	beq	a5,s8,7aa <vprintf+0xbe>
      } else if(c0 == 'l' && c1 == 'd'){
 770:	05978963          	beq	a5,s9,7c2 <vprintf+0xd6>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
 774:	07500713          	li	a4,117
 778:	0ee78363          	beq	a5,a4,85e <vprintf+0x172>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
 77c:	07800713          	li	a4,120
 780:	12e78563          	beq	a5,a4,8aa <vprintf+0x1be>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
 784:	07000713          	li	a4,112
 788:	14e78a63          	beq	a5,a4,8dc <vprintf+0x1f0>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 's'){
 78c:	07300713          	li	a4,115
 790:	18e78863          	beq	a5,a4,920 <vprintf+0x234>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
 794:	02500713          	li	a4,37
 798:	04e79563          	bne	a5,a4,7e2 <vprintf+0xf6>
        putc(fd, '%');
 79c:	02500593          	li	a1,37
 7a0:	855a                	mv	a0,s6
 7a2:	e85ff0ef          	jal	626 <putc>
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
#endif
      state = 0;
 7a6:	4981                	li	s3,0
 7a8:	bf41                	j	738 <vprintf+0x4c>
        printint(fd, va_arg(ap, int), 10, 1);
 7aa:	008b8913          	add	s2,s7,8
 7ae:	4685                	li	a3,1
 7b0:	4629                	li	a2,10
 7b2:	000ba583          	lw	a1,0(s7)
 7b6:	855a                	mv	a0,s6
 7b8:	e8dff0ef          	jal	644 <printint>
 7bc:	8bca                	mv	s7,s2
      state = 0;
 7be:	4981                	li	s3,0
 7c0:	bfa5                	j	738 <vprintf+0x4c>
      } else if(c0 == 'l' && c1 == 'd'){
 7c2:	06400793          	li	a5,100
 7c6:	02f68963          	beq	a3,a5,7f8 <vprintf+0x10c>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 7ca:	06c00793          	li	a5,108
 7ce:	04f68263          	beq	a3,a5,812 <vprintf+0x126>
      } else if(c0 == 'l' && c1 == 'u'){
 7d2:	07500793          	li	a5,117
 7d6:	0af68063          	beq	a3,a5,876 <vprintf+0x18a>
      } else if(c0 == 'l' && c1 == 'x'){
 7da:	07800793          	li	a5,120
 7de:	0ef68263          	beq	a3,a5,8c2 <vprintf+0x1d6>
        putc(fd, '%');
 7e2:	02500593          	li	a1,37
 7e6:	855a                	mv	a0,s6
 7e8:	e3fff0ef          	jal	626 <putc>
        putc(fd, c0);
 7ec:	85ca                	mv	a1,s2
 7ee:	855a                	mv	a0,s6
 7f0:	e37ff0ef          	jal	626 <putc>
      state = 0;
 7f4:	4981                	li	s3,0
 7f6:	b789                	j	738 <vprintf+0x4c>
        printint(fd, va_arg(ap, uint64), 10, 1);
 7f8:	008b8913          	add	s2,s7,8
 7fc:	4685                	li	a3,1
 7fe:	4629                	li	a2,10
 800:	000bb583          	ld	a1,0(s7)
 804:	855a                	mv	a0,s6
 806:	e3fff0ef          	jal	644 <printint>
        i += 1;
 80a:	2485                	addw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 80c:	8bca                	mv	s7,s2
      state = 0;
 80e:	4981                	li	s3,0
        i += 1;
 810:	b725                	j	738 <vprintf+0x4c>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 812:	06400793          	li	a5,100
 816:	02f60763          	beq	a2,a5,844 <vprintf+0x158>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 81a:	07500793          	li	a5,117
 81e:	06f60963          	beq	a2,a5,890 <vprintf+0x1a4>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 822:	07800793          	li	a5,120
 826:	faf61ee3          	bne	a2,a5,7e2 <vprintf+0xf6>
        printint(fd, va_arg(ap, uint64), 16, 0);
 82a:	008b8913          	add	s2,s7,8
 82e:	4681                	li	a3,0
 830:	4641                	li	a2,16
 832:	000bb583          	ld	a1,0(s7)
 836:	855a                	mv	a0,s6
 838:	e0dff0ef          	jal	644 <printint>
        i += 2;
 83c:	2489                	addw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 83e:	8bca                	mv	s7,s2
      state = 0;
 840:	4981                	li	s3,0
        i += 2;
 842:	bddd                	j	738 <vprintf+0x4c>
        printint(fd, va_arg(ap, uint64), 10, 1);
 844:	008b8913          	add	s2,s7,8
 848:	4685                	li	a3,1
 84a:	4629                	li	a2,10
 84c:	000bb583          	ld	a1,0(s7)
 850:	855a                	mv	a0,s6
 852:	df3ff0ef          	jal	644 <printint>
        i += 2;
 856:	2489                	addw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 858:	8bca                	mv	s7,s2
      state = 0;
 85a:	4981                	li	s3,0
        i += 2;
 85c:	bdf1                	j	738 <vprintf+0x4c>
        printint(fd, va_arg(ap, int), 10, 0);
 85e:	008b8913          	add	s2,s7,8
 862:	4681                	li	a3,0
 864:	4629                	li	a2,10
 866:	000ba583          	lw	a1,0(s7)
 86a:	855a                	mv	a0,s6
 86c:	dd9ff0ef          	jal	644 <printint>
 870:	8bca                	mv	s7,s2
      state = 0;
 872:	4981                	li	s3,0
 874:	b5d1                	j	738 <vprintf+0x4c>
        printint(fd, va_arg(ap, uint64), 10, 0);
 876:	008b8913          	add	s2,s7,8
 87a:	4681                	li	a3,0
 87c:	4629                	li	a2,10
 87e:	000bb583          	ld	a1,0(s7)
 882:	855a                	mv	a0,s6
 884:	dc1ff0ef          	jal	644 <printint>
        i += 1;
 888:	2485                	addw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 88a:	8bca                	mv	s7,s2
      state = 0;
 88c:	4981                	li	s3,0
        i += 1;
 88e:	b56d                	j	738 <vprintf+0x4c>
        printint(fd, va_arg(ap, uint64), 10, 0);
 890:	008b8913          	add	s2,s7,8
 894:	4681                	li	a3,0
 896:	4629                	li	a2,10
 898:	000bb583          	ld	a1,0(s7)
 89c:	855a                	mv	a0,s6
 89e:	da7ff0ef          	jal	644 <printint>
        i += 2;
 8a2:	2489                	addw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 8a4:	8bca                	mv	s7,s2
      state = 0;
 8a6:	4981                	li	s3,0
        i += 2;
 8a8:	bd41                	j	738 <vprintf+0x4c>
        printint(fd, va_arg(ap, int), 16, 0);
 8aa:	008b8913          	add	s2,s7,8
 8ae:	4681                	li	a3,0
 8b0:	4641                	li	a2,16
 8b2:	000ba583          	lw	a1,0(s7)
 8b6:	855a                	mv	a0,s6
 8b8:	d8dff0ef          	jal	644 <printint>
 8bc:	8bca                	mv	s7,s2
      state = 0;
 8be:	4981                	li	s3,0
 8c0:	bda5                	j	738 <vprintf+0x4c>
        printint(fd, va_arg(ap, uint64), 16, 0);
 8c2:	008b8913          	add	s2,s7,8
 8c6:	4681                	li	a3,0
 8c8:	4641                	li	a2,16
 8ca:	000bb583          	ld	a1,0(s7)
 8ce:	855a                	mv	a0,s6
 8d0:	d75ff0ef          	jal	644 <printint>
        i += 1;
 8d4:	2485                	addw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 8d6:	8bca                	mv	s7,s2
      state = 0;
 8d8:	4981                	li	s3,0
        i += 1;
 8da:	bdb9                	j	738 <vprintf+0x4c>
        printptr(fd, va_arg(ap, uint64));
 8dc:	008b8d13          	add	s10,s7,8
 8e0:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 8e4:	03000593          	li	a1,48
 8e8:	855a                	mv	a0,s6
 8ea:	d3dff0ef          	jal	626 <putc>
  putc(fd, 'x');
 8ee:	07800593          	li	a1,120
 8f2:	855a                	mv	a0,s6
 8f4:	d33ff0ef          	jal	626 <putc>
 8f8:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 8fa:	00000b97          	auipc	s7,0x0
 8fe:	27eb8b93          	add	s7,s7,638 # b78 <digits>
 902:	03c9d793          	srl	a5,s3,0x3c
 906:	97de                	add	a5,a5,s7
 908:	0007c583          	lbu	a1,0(a5)
 90c:	855a                	mv	a0,s6
 90e:	d19ff0ef          	jal	626 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 912:	0992                	sll	s3,s3,0x4
 914:	397d                	addw	s2,s2,-1
 916:	fe0916e3          	bnez	s2,902 <vprintf+0x216>
        printptr(fd, va_arg(ap, uint64));
 91a:	8bea                	mv	s7,s10
      state = 0;
 91c:	4981                	li	s3,0
 91e:	bd29                	j	738 <vprintf+0x4c>
        if((s = va_arg(ap, char*)) == 0)
 920:	008b8993          	add	s3,s7,8
 924:	000bb903          	ld	s2,0(s7)
 928:	00090f63          	beqz	s2,946 <vprintf+0x25a>
        for(; *s; s++)
 92c:	00094583          	lbu	a1,0(s2)
 930:	c195                	beqz	a1,954 <vprintf+0x268>
          putc(fd, *s);
 932:	855a                	mv	a0,s6
 934:	cf3ff0ef          	jal	626 <putc>
        for(; *s; s++)
 938:	0905                	add	s2,s2,1
 93a:	00094583          	lbu	a1,0(s2)
 93e:	f9f5                	bnez	a1,932 <vprintf+0x246>
        if((s = va_arg(ap, char*)) == 0)
 940:	8bce                	mv	s7,s3
      state = 0;
 942:	4981                	li	s3,0
 944:	bbd5                	j	738 <vprintf+0x4c>
          s = "(null)";
 946:	00000917          	auipc	s2,0x0
 94a:	22a90913          	add	s2,s2,554 # b70 <malloc+0x11c>
        for(; *s; s++)
 94e:	02800593          	li	a1,40
 952:	b7c5                	j	932 <vprintf+0x246>
        if((s = va_arg(ap, char*)) == 0)
 954:	8bce                	mv	s7,s3
      state = 0;
 956:	4981                	li	s3,0
 958:	b3c5                	j	738 <vprintf+0x4c>
    }
  }
}
 95a:	60e6                	ld	ra,88(sp)
 95c:	6446                	ld	s0,80(sp)
 95e:	64a6                	ld	s1,72(sp)
 960:	6906                	ld	s2,64(sp)
 962:	79e2                	ld	s3,56(sp)
 964:	7a42                	ld	s4,48(sp)
 966:	7aa2                	ld	s5,40(sp)
 968:	7b02                	ld	s6,32(sp)
 96a:	6be2                	ld	s7,24(sp)
 96c:	6c42                	ld	s8,16(sp)
 96e:	6ca2                	ld	s9,8(sp)
 970:	6d02                	ld	s10,0(sp)
 972:	6125                	add	sp,sp,96
 974:	8082                	ret

0000000000000976 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 976:	715d                	add	sp,sp,-80
 978:	ec06                	sd	ra,24(sp)
 97a:	e822                	sd	s0,16(sp)
 97c:	1000                	add	s0,sp,32
 97e:	e010                	sd	a2,0(s0)
 980:	e414                	sd	a3,8(s0)
 982:	e818                	sd	a4,16(s0)
 984:	ec1c                	sd	a5,24(s0)
 986:	03043023          	sd	a6,32(s0)
 98a:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 98e:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 992:	8622                	mv	a2,s0
 994:	d59ff0ef          	jal	6ec <vprintf>
}
 998:	60e2                	ld	ra,24(sp)
 99a:	6442                	ld	s0,16(sp)
 99c:	6161                	add	sp,sp,80
 99e:	8082                	ret

00000000000009a0 <printf>:

void
printf(const char *fmt, ...)
{
 9a0:	711d                	add	sp,sp,-96
 9a2:	ec06                	sd	ra,24(sp)
 9a4:	e822                	sd	s0,16(sp)
 9a6:	1000                	add	s0,sp,32
 9a8:	e40c                	sd	a1,8(s0)
 9aa:	e810                	sd	a2,16(s0)
 9ac:	ec14                	sd	a3,24(s0)
 9ae:	f018                	sd	a4,32(s0)
 9b0:	f41c                	sd	a5,40(s0)
 9b2:	03043823          	sd	a6,48(s0)
 9b6:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 9ba:	00840613          	add	a2,s0,8
 9be:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 9c2:	85aa                	mv	a1,a0
 9c4:	4505                	li	a0,1
 9c6:	d27ff0ef          	jal	6ec <vprintf>
}
 9ca:	60e2                	ld	ra,24(sp)
 9cc:	6442                	ld	s0,16(sp)
 9ce:	6125                	add	sp,sp,96
 9d0:	8082                	ret

00000000000009d2 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 9d2:	1141                	add	sp,sp,-16
 9d4:	e422                	sd	s0,8(sp)
 9d6:	0800                	add	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 9d8:	ff050693          	add	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 9dc:	00000797          	auipc	a5,0x0
 9e0:	62c7b783          	ld	a5,1580(a5) # 1008 <freep>
 9e4:	a02d                	j	a0e <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 9e6:	4618                	lw	a4,8(a2)
 9e8:	9f2d                	addw	a4,a4,a1
 9ea:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 9ee:	6398                	ld	a4,0(a5)
 9f0:	6310                	ld	a2,0(a4)
 9f2:	a83d                	j	a30 <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 9f4:	ff852703          	lw	a4,-8(a0)
 9f8:	9f31                	addw	a4,a4,a2
 9fa:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 9fc:	ff053683          	ld	a3,-16(a0)
 a00:	a091                	j	a44 <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 a02:	6398                	ld	a4,0(a5)
 a04:	00e7e463          	bltu	a5,a4,a0c <free+0x3a>
 a08:	00e6ea63          	bltu	a3,a4,a1c <free+0x4a>
{
 a0c:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 a0e:	fed7fae3          	bgeu	a5,a3,a02 <free+0x30>
 a12:	6398                	ld	a4,0(a5)
 a14:	00e6e463          	bltu	a3,a4,a1c <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 a18:	fee7eae3          	bltu	a5,a4,a0c <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 a1c:	ff852583          	lw	a1,-8(a0)
 a20:	6390                	ld	a2,0(a5)
 a22:	02059813          	sll	a6,a1,0x20
 a26:	01c85713          	srl	a4,a6,0x1c
 a2a:	9736                	add	a4,a4,a3
 a2c:	fae60de3          	beq	a2,a4,9e6 <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 a30:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 a34:	4790                	lw	a2,8(a5)
 a36:	02061593          	sll	a1,a2,0x20
 a3a:	01c5d713          	srl	a4,a1,0x1c
 a3e:	973e                	add	a4,a4,a5
 a40:	fae68ae3          	beq	a3,a4,9f4 <free+0x22>
    p->s.ptr = bp->s.ptr;
 a44:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 a46:	00000717          	auipc	a4,0x0
 a4a:	5cf73123          	sd	a5,1474(a4) # 1008 <freep>
}
 a4e:	6422                	ld	s0,8(sp)
 a50:	0141                	add	sp,sp,16
 a52:	8082                	ret

0000000000000a54 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 a54:	7139                	add	sp,sp,-64
 a56:	fc06                	sd	ra,56(sp)
 a58:	f822                	sd	s0,48(sp)
 a5a:	f426                	sd	s1,40(sp)
 a5c:	f04a                	sd	s2,32(sp)
 a5e:	ec4e                	sd	s3,24(sp)
 a60:	e852                	sd	s4,16(sp)
 a62:	e456                	sd	s5,8(sp)
 a64:	e05a                	sd	s6,0(sp)
 a66:	0080                	add	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 a68:	02051493          	sll	s1,a0,0x20
 a6c:	9081                	srl	s1,s1,0x20
 a6e:	04bd                	add	s1,s1,15
 a70:	8091                	srl	s1,s1,0x4
 a72:	0014899b          	addw	s3,s1,1
 a76:	0485                	add	s1,s1,1
  if((prevp = freep) == 0){
 a78:	00000517          	auipc	a0,0x0
 a7c:	59053503          	ld	a0,1424(a0) # 1008 <freep>
 a80:	c515                	beqz	a0,aac <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a82:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 a84:	4798                	lw	a4,8(a5)
 a86:	02977f63          	bgeu	a4,s1,ac4 <malloc+0x70>
  if(nu < 4096)
 a8a:	8a4e                	mv	s4,s3
 a8c:	0009871b          	sext.w	a4,s3
 a90:	6685                	lui	a3,0x1
 a92:	00d77363          	bgeu	a4,a3,a98 <malloc+0x44>
 a96:	6a05                	lui	s4,0x1
 a98:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 a9c:	004a1a1b          	sllw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 aa0:	00000917          	auipc	s2,0x0
 aa4:	56890913          	add	s2,s2,1384 # 1008 <freep>
  if(p == (char*)-1)
 aa8:	5afd                	li	s5,-1
 aaa:	a885                	j	b1a <malloc+0xc6>
    base.s.ptr = freep = prevp = &base;
 aac:	00000797          	auipc	a5,0x0
 ab0:	56478793          	add	a5,a5,1380 # 1010 <base>
 ab4:	00000717          	auipc	a4,0x0
 ab8:	54f73a23          	sd	a5,1364(a4) # 1008 <freep>
 abc:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 abe:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 ac2:	b7e1                	j	a8a <malloc+0x36>
      if(p->s.size == nunits)
 ac4:	02e48c63          	beq	s1,a4,afc <malloc+0xa8>
        p->s.size -= nunits;
 ac8:	4137073b          	subw	a4,a4,s3
 acc:	c798                	sw	a4,8(a5)
        p += p->s.size;
 ace:	02071693          	sll	a3,a4,0x20
 ad2:	01c6d713          	srl	a4,a3,0x1c
 ad6:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 ad8:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 adc:	00000717          	auipc	a4,0x0
 ae0:	52a73623          	sd	a0,1324(a4) # 1008 <freep>
      return (void*)(p + 1);
 ae4:	01078513          	add	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 ae8:	70e2                	ld	ra,56(sp)
 aea:	7442                	ld	s0,48(sp)
 aec:	74a2                	ld	s1,40(sp)
 aee:	7902                	ld	s2,32(sp)
 af0:	69e2                	ld	s3,24(sp)
 af2:	6a42                	ld	s4,16(sp)
 af4:	6aa2                	ld	s5,8(sp)
 af6:	6b02                	ld	s6,0(sp)
 af8:	6121                	add	sp,sp,64
 afa:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 afc:	6398                	ld	a4,0(a5)
 afe:	e118                	sd	a4,0(a0)
 b00:	bff1                	j	adc <malloc+0x88>
  hp->s.size = nu;
 b02:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 b06:	0541                	add	a0,a0,16
 b08:	ecbff0ef          	jal	9d2 <free>
  return freep;
 b0c:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 b10:	dd61                	beqz	a0,ae8 <malloc+0x94>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 b12:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 b14:	4798                	lw	a4,8(a5)
 b16:	fa9777e3          	bgeu	a4,s1,ac4 <malloc+0x70>
    if(p == freep)
 b1a:	00093703          	ld	a4,0(s2)
 b1e:	853e                	mv	a0,a5
 b20:	fef719e3          	bne	a4,a5,b12 <malloc+0xbe>
  p = sbrk(nu * sizeof(Header));
 b24:	8552                	mv	a0,s4
 b26:	a99ff0ef          	jal	5be <sbrk>
  if(p == (char*)-1)
 b2a:	fd551ce3          	bne	a0,s5,b02 <malloc+0xae>
        return 0;
 b2e:	4501                	li	a0,0
 b30:	bf65                	j	ae8 <malloc+0x94>
