
user/_echo:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/stat.h"
#include "user/user.h"

int
main(int argc, char *argv[])
{
   0:	7139                	add	sp,sp,-64
   2:	fc06                	sd	ra,56(sp)
   4:	f822                	sd	s0,48(sp)
   6:	f426                	sd	s1,40(sp)
   8:	f04a                	sd	s2,32(sp)
   a:	ec4e                	sd	s3,24(sp)
   c:	e852                	sd	s4,16(sp)
   e:	e456                	sd	s5,8(sp)
  10:	0080                	add	s0,sp,64
  int i;

  for(i = 1; i < argc; i++){
  12:	4785                	li	a5,1
  14:	06a7d063          	bge	a5,a0,74 <main+0x74>
  18:	00858493          	add	s1,a1,8
  1c:	3579                	addw	a0,a0,-2
  1e:	02051793          	sll	a5,a0,0x20
  22:	01d7d513          	srl	a0,a5,0x1d
  26:	00a48a33          	add	s4,s1,a0
  2a:	05c1                	add	a1,a1,16
  2c:	00a589b3          	add	s3,a1,a0
    write(1, argv[i], strlen(argv[i]));
    if(i + 1 < argc){
      write(1, " ", 1);
  30:	00001a97          	auipc	s5,0x1
  34:	b30a8a93          	add	s5,s5,-1232 # b60 <malloc+0xde>
  38:	a809                	j	4a <main+0x4a>
  3a:	4605                	li	a2,1
  3c:	85d6                	mv	a1,s5
  3e:	4505                	li	a0,1
  40:	544000ef          	jal	584 <write>
  for(i = 1; i < argc; i++){
  44:	04a1                	add	s1,s1,8
  46:	03348763          	beq	s1,s3,74 <main+0x74>
    write(1, argv[i], strlen(argv[i]));
  4a:	0004b903          	ld	s2,0(s1)
  4e:	854a                	mv	a0,s2
  50:	084000ef          	jal	d4 <strlen>
  54:	0005061b          	sext.w	a2,a0
  58:	85ca                	mv	a1,s2
  5a:	4505                	li	a0,1
  5c:	528000ef          	jal	584 <write>
    if(i + 1 < argc){
  60:	fd449de3          	bne	s1,s4,3a <main+0x3a>
    } else {
      write(1, "\n", 1);
  64:	4605                	li	a2,1
  66:	00001597          	auipc	a1,0x1
  6a:	b0258593          	add	a1,a1,-1278 # b68 <malloc+0xe6>
  6e:	4505                	li	a0,1
  70:	514000ef          	jal	584 <write>
    }
  }
  exit(0);
  74:	4501                	li	a0,0
  76:	4ee000ef          	jal	564 <exit>

000000000000007a <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start()
{
  7a:	1141                	add	sp,sp,-16
  7c:	e406                	sd	ra,8(sp)
  7e:	e022                	sd	s0,0(sp)
  80:	0800                	add	s0,sp,16
  extern int main();
  main();
  82:	f7fff0ef          	jal	0 <main>
  exit(0);
  86:	4501                	li	a0,0
  88:	4dc000ef          	jal	564 <exit>

000000000000008c <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
  8c:	1141                	add	sp,sp,-16
  8e:	e422                	sd	s0,8(sp)
  90:	0800                	add	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  92:	87aa                	mv	a5,a0
  94:	0585                	add	a1,a1,1
  96:	0785                	add	a5,a5,1
  98:	fff5c703          	lbu	a4,-1(a1)
  9c:	fee78fa3          	sb	a4,-1(a5)
  a0:	fb75                	bnez	a4,94 <strcpy+0x8>
    ;
  return os;
}
  a2:	6422                	ld	s0,8(sp)
  a4:	0141                	add	sp,sp,16
  a6:	8082                	ret

00000000000000a8 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  a8:	1141                	add	sp,sp,-16
  aa:	e422                	sd	s0,8(sp)
  ac:	0800                	add	s0,sp,16
  while(*p && *p == *q)
  ae:	00054783          	lbu	a5,0(a0)
  b2:	cb91                	beqz	a5,c6 <strcmp+0x1e>
  b4:	0005c703          	lbu	a4,0(a1)
  b8:	00f71763          	bne	a4,a5,c6 <strcmp+0x1e>
    p++, q++;
  bc:	0505                	add	a0,a0,1
  be:	0585                	add	a1,a1,1
  while(*p && *p == *q)
  c0:	00054783          	lbu	a5,0(a0)
  c4:	fbe5                	bnez	a5,b4 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
  c6:	0005c503          	lbu	a0,0(a1)
}
  ca:	40a7853b          	subw	a0,a5,a0
  ce:	6422                	ld	s0,8(sp)
  d0:	0141                	add	sp,sp,16
  d2:	8082                	ret

00000000000000d4 <strlen>:

uint
strlen(const char *s)
{
  d4:	1141                	add	sp,sp,-16
  d6:	e422                	sd	s0,8(sp)
  d8:	0800                	add	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
  da:	00054783          	lbu	a5,0(a0)
  de:	cf91                	beqz	a5,fa <strlen+0x26>
  e0:	0505                	add	a0,a0,1
  e2:	87aa                	mv	a5,a0
  e4:	86be                	mv	a3,a5
  e6:	0785                	add	a5,a5,1
  e8:	fff7c703          	lbu	a4,-1(a5)
  ec:	ff65                	bnez	a4,e4 <strlen+0x10>
  ee:	40a6853b          	subw	a0,a3,a0
  f2:	2505                	addw	a0,a0,1
    ;
  return n;
}
  f4:	6422                	ld	s0,8(sp)
  f6:	0141                	add	sp,sp,16
  f8:	8082                	ret
  for(n = 0; s[n]; n++)
  fa:	4501                	li	a0,0
  fc:	bfe5                	j	f4 <strlen+0x20>

00000000000000fe <memset>:

void*
memset(void *dst, int c, uint n)
{
  fe:	1141                	add	sp,sp,-16
 100:	e422                	sd	s0,8(sp)
 102:	0800                	add	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 104:	ca19                	beqz	a2,11a <memset+0x1c>
 106:	87aa                	mv	a5,a0
 108:	1602                	sll	a2,a2,0x20
 10a:	9201                	srl	a2,a2,0x20
 10c:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 110:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 114:	0785                	add	a5,a5,1
 116:	fee79de3          	bne	a5,a4,110 <memset+0x12>
  }
  return dst;
}
 11a:	6422                	ld	s0,8(sp)
 11c:	0141                	add	sp,sp,16
 11e:	8082                	ret

0000000000000120 <strchr>:

char*
strchr(const char *s, char c)
{
 120:	1141                	add	sp,sp,-16
 122:	e422                	sd	s0,8(sp)
 124:	0800                	add	s0,sp,16
  for(; *s; s++)
 126:	00054783          	lbu	a5,0(a0)
 12a:	cb99                	beqz	a5,140 <strchr+0x20>
    if(*s == c)
 12c:	00f58763          	beq	a1,a5,13a <strchr+0x1a>
  for(; *s; s++)
 130:	0505                	add	a0,a0,1
 132:	00054783          	lbu	a5,0(a0)
 136:	fbfd                	bnez	a5,12c <strchr+0xc>
      return (char*)s;
  return 0;
 138:	4501                	li	a0,0
}
 13a:	6422                	ld	s0,8(sp)
 13c:	0141                	add	sp,sp,16
 13e:	8082                	ret
  return 0;
 140:	4501                	li	a0,0
 142:	bfe5                	j	13a <strchr+0x1a>

0000000000000144 <gets>:

char*
gets(char *buf, int max)
{
 144:	711d                	add	sp,sp,-96
 146:	ec86                	sd	ra,88(sp)
 148:	e8a2                	sd	s0,80(sp)
 14a:	e4a6                	sd	s1,72(sp)
 14c:	e0ca                	sd	s2,64(sp)
 14e:	fc4e                	sd	s3,56(sp)
 150:	f852                	sd	s4,48(sp)
 152:	f456                	sd	s5,40(sp)
 154:	f05a                	sd	s6,32(sp)
 156:	ec5e                	sd	s7,24(sp)
 158:	1080                	add	s0,sp,96
 15a:	8baa                	mv	s7,a0
 15c:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 15e:	892a                	mv	s2,a0
 160:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 162:	4aa9                	li	s5,10
 164:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 166:	89a6                	mv	s3,s1
 168:	2485                	addw	s1,s1,1
 16a:	0344d663          	bge	s1,s4,196 <gets+0x52>
    cc = read(0, &c, 1);
 16e:	4605                	li	a2,1
 170:	faf40593          	add	a1,s0,-81
 174:	4501                	li	a0,0
 176:	406000ef          	jal	57c <read>
    if(cc < 1)
 17a:	00a05e63          	blez	a0,196 <gets+0x52>
    buf[i++] = c;
 17e:	faf44783          	lbu	a5,-81(s0)
 182:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 186:	01578763          	beq	a5,s5,194 <gets+0x50>
 18a:	0905                	add	s2,s2,1
 18c:	fd679de3          	bne	a5,s6,166 <gets+0x22>
  for(i=0; i+1 < max; ){
 190:	89a6                	mv	s3,s1
 192:	a011                	j	196 <gets+0x52>
 194:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 196:	99de                	add	s3,s3,s7
 198:	00098023          	sb	zero,0(s3)
  return buf;
}
 19c:	855e                	mv	a0,s7
 19e:	60e6                	ld	ra,88(sp)
 1a0:	6446                	ld	s0,80(sp)
 1a2:	64a6                	ld	s1,72(sp)
 1a4:	6906                	ld	s2,64(sp)
 1a6:	79e2                	ld	s3,56(sp)
 1a8:	7a42                	ld	s4,48(sp)
 1aa:	7aa2                	ld	s5,40(sp)
 1ac:	7b02                	ld	s6,32(sp)
 1ae:	6be2                	ld	s7,24(sp)
 1b0:	6125                	add	sp,sp,96
 1b2:	8082                	ret

00000000000001b4 <stat>:

int
stat(const char *n, struct stat *st)
{
 1b4:	1101                	add	sp,sp,-32
 1b6:	ec06                	sd	ra,24(sp)
 1b8:	e822                	sd	s0,16(sp)
 1ba:	e426                	sd	s1,8(sp)
 1bc:	e04a                	sd	s2,0(sp)
 1be:	1000                	add	s0,sp,32
 1c0:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1c2:	4581                	li	a1,0
 1c4:	3e0000ef          	jal	5a4 <open>
  if(fd < 0)
 1c8:	02054163          	bltz	a0,1ea <stat+0x36>
 1cc:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 1ce:	85ca                	mv	a1,s2
 1d0:	3ec000ef          	jal	5bc <fstat>
 1d4:	892a                	mv	s2,a0
  close(fd);
 1d6:	8526                	mv	a0,s1
 1d8:	3b4000ef          	jal	58c <close>
  return r;
}
 1dc:	854a                	mv	a0,s2
 1de:	60e2                	ld	ra,24(sp)
 1e0:	6442                	ld	s0,16(sp)
 1e2:	64a2                	ld	s1,8(sp)
 1e4:	6902                	ld	s2,0(sp)
 1e6:	6105                	add	sp,sp,32
 1e8:	8082                	ret
    return -1;
 1ea:	597d                	li	s2,-1
 1ec:	bfc5                	j	1dc <stat+0x28>

00000000000001ee <atoi>:

int
atoi(const char *s)
{
 1ee:	1141                	add	sp,sp,-16
 1f0:	e422                	sd	s0,8(sp)
 1f2:	0800                	add	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 1f4:	00054683          	lbu	a3,0(a0)
 1f8:	fd06879b          	addw	a5,a3,-48
 1fc:	0ff7f793          	zext.b	a5,a5
 200:	4625                	li	a2,9
 202:	02f66863          	bltu	a2,a5,232 <atoi+0x44>
 206:	872a                	mv	a4,a0
  n = 0;
 208:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 20a:	0705                	add	a4,a4,1
 20c:	0025179b          	sllw	a5,a0,0x2
 210:	9fa9                	addw	a5,a5,a0
 212:	0017979b          	sllw	a5,a5,0x1
 216:	9fb5                	addw	a5,a5,a3
 218:	fd07851b          	addw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 21c:	00074683          	lbu	a3,0(a4)
 220:	fd06879b          	addw	a5,a3,-48
 224:	0ff7f793          	zext.b	a5,a5
 228:	fef671e3          	bgeu	a2,a5,20a <atoi+0x1c>
  return n;
}
 22c:	6422                	ld	s0,8(sp)
 22e:	0141                	add	sp,sp,16
 230:	8082                	ret
  n = 0;
 232:	4501                	li	a0,0
 234:	bfe5                	j	22c <atoi+0x3e>

0000000000000236 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 236:	1141                	add	sp,sp,-16
 238:	e422                	sd	s0,8(sp)
 23a:	0800                	add	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 23c:	02b57463          	bgeu	a0,a1,264 <memmove+0x2e>
    while(n-- > 0)
 240:	00c05f63          	blez	a2,25e <memmove+0x28>
 244:	1602                	sll	a2,a2,0x20
 246:	9201                	srl	a2,a2,0x20
 248:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 24c:	872a                	mv	a4,a0
      *dst++ = *src++;
 24e:	0585                	add	a1,a1,1
 250:	0705                	add	a4,a4,1
 252:	fff5c683          	lbu	a3,-1(a1)
 256:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 25a:	fee79ae3          	bne	a5,a4,24e <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 25e:	6422                	ld	s0,8(sp)
 260:	0141                	add	sp,sp,16
 262:	8082                	ret
    dst += n;
 264:	00c50733          	add	a4,a0,a2
    src += n;
 268:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 26a:	fec05ae3          	blez	a2,25e <memmove+0x28>
 26e:	fff6079b          	addw	a5,a2,-1
 272:	1782                	sll	a5,a5,0x20
 274:	9381                	srl	a5,a5,0x20
 276:	fff7c793          	not	a5,a5
 27a:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 27c:	15fd                	add	a1,a1,-1
 27e:	177d                	add	a4,a4,-1
 280:	0005c683          	lbu	a3,0(a1)
 284:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 288:	fee79ae3          	bne	a5,a4,27c <memmove+0x46>
 28c:	bfc9                	j	25e <memmove+0x28>

000000000000028e <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 28e:	1141                	add	sp,sp,-16
 290:	e422                	sd	s0,8(sp)
 292:	0800                	add	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 294:	ca05                	beqz	a2,2c4 <memcmp+0x36>
 296:	fff6069b          	addw	a3,a2,-1
 29a:	1682                	sll	a3,a3,0x20
 29c:	9281                	srl	a3,a3,0x20
 29e:	0685                	add	a3,a3,1
 2a0:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 2a2:	00054783          	lbu	a5,0(a0)
 2a6:	0005c703          	lbu	a4,0(a1)
 2aa:	00e79863          	bne	a5,a4,2ba <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 2ae:	0505                	add	a0,a0,1
    p2++;
 2b0:	0585                	add	a1,a1,1
  while (n-- > 0) {
 2b2:	fed518e3          	bne	a0,a3,2a2 <memcmp+0x14>
  }
  return 0;
 2b6:	4501                	li	a0,0
 2b8:	a019                	j	2be <memcmp+0x30>
      return *p1 - *p2;
 2ba:	40e7853b          	subw	a0,a5,a4
}
 2be:	6422                	ld	s0,8(sp)
 2c0:	0141                	add	sp,sp,16
 2c2:	8082                	ret
  return 0;
 2c4:	4501                	li	a0,0
 2c6:	bfe5                	j	2be <memcmp+0x30>

00000000000002c8 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 2c8:	1141                	add	sp,sp,-16
 2ca:	e406                	sd	ra,8(sp)
 2cc:	e022                	sd	s0,0(sp)
 2ce:	0800                	add	s0,sp,16
  return memmove(dst, src, n);
 2d0:	f67ff0ef          	jal	236 <memmove>
}
 2d4:	60a2                	ld	ra,8(sp)
 2d6:	6402                	ld	s0,0(sp)
 2d8:	0141                	add	sp,sp,16
 2da:	8082                	ret

00000000000002dc <htons>:
    return (v & 0x000000ff) << 24 | (v & 0x0000ff00) << 8 | (v & 0x00ff0000) >> 8 | (v & 0xff000000) >> 24;
}

uint16_t
htons(uint16_t h)
{
 2dc:	1141                	add	sp,sp,-16
 2de:	e422                	sd	s0,8(sp)
 2e0:	0800                	add	s0,sp,16
    if (!endian) {
 2e2:	00001797          	auipc	a5,0x1
 2e6:	d1e7a783          	lw	a5,-738(a5) # 1000 <endian>
 2ea:	e385                	bnez	a5,30a <htons+0x2e>
        endian = byteorder();
 2ec:	4d200793          	li	a5,1234
 2f0:	00001717          	auipc	a4,0x1
 2f4:	d0f72823          	sw	a5,-752(a4) # 1000 <endian>
    return (v & 0x00ff) << 8 | (v & 0xff00 ) >> 8;
 2f8:	0085579b          	srlw	a5,a0,0x8
 2fc:	0085151b          	sllw	a0,a0,0x8
 300:	8fc9                	or	a5,a5,a0
 302:	03079513          	sll	a0,a5,0x30
 306:	9141                	srl	a0,a0,0x30
 308:	a029                	j	312 <htons+0x36>
    }
    return endian == __LITTLE_ENDIAN ? byteswap16(h) : h;
 30a:	4d200713          	li	a4,1234
 30e:	fee785e3          	beq	a5,a4,2f8 <htons+0x1c>
}
 312:	6422                	ld	s0,8(sp)
 314:	0141                	add	sp,sp,16
 316:	8082                	ret

0000000000000318 <ntohs>:

uint16_t
ntohs(uint16_t n)
{
 318:	1141                	add	sp,sp,-16
 31a:	e422                	sd	s0,8(sp)
 31c:	0800                	add	s0,sp,16
    if (!endian) {
 31e:	00001797          	auipc	a5,0x1
 322:	ce27a783          	lw	a5,-798(a5) # 1000 <endian>
 326:	e385                	bnez	a5,346 <ntohs+0x2e>
        endian = byteorder();
 328:	4d200793          	li	a5,1234
 32c:	00001717          	auipc	a4,0x1
 330:	ccf72a23          	sw	a5,-812(a4) # 1000 <endian>
    return (v & 0x00ff) << 8 | (v & 0xff00 ) >> 8;
 334:	0085579b          	srlw	a5,a0,0x8
 338:	0085151b          	sllw	a0,a0,0x8
 33c:	8fc9                	or	a5,a5,a0
 33e:	03079513          	sll	a0,a5,0x30
 342:	9141                	srl	a0,a0,0x30
 344:	a029                	j	34e <ntohs+0x36>
    }
    return endian == __LITTLE_ENDIAN ? byteswap16(n) : n;
 346:	4d200713          	li	a4,1234
 34a:	fee785e3          	beq	a5,a4,334 <ntohs+0x1c>
}
 34e:	6422                	ld	s0,8(sp)
 350:	0141                	add	sp,sp,16
 352:	8082                	ret

0000000000000354 <htonl>:

uint32_t
htonl(uint32_t h)
{
 354:	1141                	add	sp,sp,-16
 356:	e422                	sd	s0,8(sp)
 358:	0800                	add	s0,sp,16
    if (!endian) {
 35a:	00001797          	auipc	a5,0x1
 35e:	ca67a783          	lw	a5,-858(a5) # 1000 <endian>
 362:	ef85                	bnez	a5,39a <htonl+0x46>
        endian = byteorder();
 364:	4d200793          	li	a5,1234
 368:	00001717          	auipc	a4,0x1
 36c:	c8f72c23          	sw	a5,-872(a4) # 1000 <endian>
    return (v & 0x000000ff) << 24 | (v & 0x0000ff00) << 8 | (v & 0x00ff0000) >> 8 | (v & 0xff000000) >> 24;
 370:	0185179b          	sllw	a5,a0,0x18
 374:	0185571b          	srlw	a4,a0,0x18
 378:	8fd9                	or	a5,a5,a4
 37a:	0085171b          	sllw	a4,a0,0x8
 37e:	00ff06b7          	lui	a3,0xff0
 382:	8f75                	and	a4,a4,a3
 384:	8fd9                	or	a5,a5,a4
 386:	0085551b          	srlw	a0,a0,0x8
 38a:	6741                	lui	a4,0x10
 38c:	f0070713          	add	a4,a4,-256 # ff00 <base+0xeef0>
 390:	8d79                	and	a0,a0,a4
 392:	8fc9                	or	a5,a5,a0
 394:	0007851b          	sext.w	a0,a5
 398:	a029                	j	3a2 <htonl+0x4e>
    }
    return endian == __LITTLE_ENDIAN ? byteswap32(h) : h;
 39a:	4d200713          	li	a4,1234
 39e:	fce789e3          	beq	a5,a4,370 <htonl+0x1c>
}
 3a2:	6422                	ld	s0,8(sp)
 3a4:	0141                	add	sp,sp,16
 3a6:	8082                	ret

00000000000003a8 <ntohl>:

uint32_t
ntohl(uint32_t n)
{
 3a8:	1141                	add	sp,sp,-16
 3aa:	e422                	sd	s0,8(sp)
 3ac:	0800                	add	s0,sp,16
    if (!endian) {
 3ae:	00001797          	auipc	a5,0x1
 3b2:	c527a783          	lw	a5,-942(a5) # 1000 <endian>
 3b6:	ef85                	bnez	a5,3ee <ntohl+0x46>
        endian = byteorder();
 3b8:	4d200793          	li	a5,1234
 3bc:	00001717          	auipc	a4,0x1
 3c0:	c4f72223          	sw	a5,-956(a4) # 1000 <endian>
    return (v & 0x000000ff) << 24 | (v & 0x0000ff00) << 8 | (v & 0x00ff0000) >> 8 | (v & 0xff000000) >> 24;
 3c4:	0185179b          	sllw	a5,a0,0x18
 3c8:	0185571b          	srlw	a4,a0,0x18
 3cc:	8fd9                	or	a5,a5,a4
 3ce:	0085171b          	sllw	a4,a0,0x8
 3d2:	00ff06b7          	lui	a3,0xff0
 3d6:	8f75                	and	a4,a4,a3
 3d8:	8fd9                	or	a5,a5,a4
 3da:	0085551b          	srlw	a0,a0,0x8
 3de:	6741                	lui	a4,0x10
 3e0:	f0070713          	add	a4,a4,-256 # ff00 <base+0xeef0>
 3e4:	8d79                	and	a0,a0,a4
 3e6:	8fc9                	or	a5,a5,a0
 3e8:	0007851b          	sext.w	a0,a5
 3ec:	a029                	j	3f6 <ntohl+0x4e>
    }
    return endian == __LITTLE_ENDIAN ? byteswap32(n) : n;
 3ee:	4d200713          	li	a4,1234
 3f2:	fce789e3          	beq	a5,a4,3c4 <ntohl+0x1c>
}
 3f6:	6422                	ld	s0,8(sp)
 3f8:	0141                	add	sp,sp,16
 3fa:	8082                	ret

00000000000003fc <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
 3fc:	1141                	add	sp,sp,-16
 3fe:	e422                	sd	s0,8(sp)
 400:	0800                	add	s0,sp,16
 402:	872a                	mv	a4,a0
    int neg = 0;
    long val = 0;

    // gobble initial whitespace
    while (*s == ' ' || *s == '\t')
 404:	02000693          	li	a3,32
 408:	4525                	li	a0,9
 40a:	a011                	j	40e <strtol+0x12>
        s++;
 40c:	0705                	add	a4,a4,1
    while (*s == ' ' || *s == '\t')
 40e:	00074783          	lbu	a5,0(a4)
 412:	fed78de3          	beq	a5,a3,40c <strtol+0x10>
 416:	fea78be3          	beq	a5,a0,40c <strtol+0x10>

    // plus/minus sign
    if (*s == '+')
 41a:	02b00693          	li	a3,43
 41e:	02d78663          	beq	a5,a3,44a <strtol+0x4e>
        s++;
    else if (*s == '-')
 422:	02d00693          	li	a3,45
    int neg = 0;
 426:	4301                	li	t1,0
    else if (*s == '-')
 428:	02d78463          	beq	a5,a3,450 <strtol+0x54>
        s++, neg = 1;

    // hex or octal base prefix
    if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
 42c:	fef67793          	and	a5,a2,-17
 430:	eb89                	bnez	a5,442 <strtol+0x46>
 432:	00074683          	lbu	a3,0(a4)
 436:	03000793          	li	a5,48
 43a:	00f68e63          	beq	a3,a5,456 <strtol+0x5a>
        s += 2, base = 16;
    else if (base == 0 && s[0] == '0')
 43e:	e211                	bnez	a2,442 <strtol+0x46>
        s++, base = 8;
    else if (base == 0)
        base = 10;
 440:	4629                	li	a2,10
 442:	4501                	li	a0,0

    // digits
    while (1) {
        int dig;

        if (*s >= '0' && *s <= '9')
 444:	4825                	li	a6,9
            dig = *s - '0';
        else if (*s >= 'a' && *s <= 'z')
 446:	48e5                	li	a7,25
 448:	a825                	j	480 <strtol+0x84>
        s++;
 44a:	0705                	add	a4,a4,1
    int neg = 0;
 44c:	4301                	li	t1,0
 44e:	bff9                	j	42c <strtol+0x30>
        s++, neg = 1;
 450:	0705                	add	a4,a4,1
 452:	4305                	li	t1,1
 454:	bfe1                	j	42c <strtol+0x30>
    if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
 456:	00174683          	lbu	a3,1(a4)
 45a:	07800793          	li	a5,120
 45e:	00f68663          	beq	a3,a5,46a <strtol+0x6e>
    else if (base == 0 && s[0] == '0')
 462:	f265                	bnez	a2,442 <strtol+0x46>
        s++, base = 8;
 464:	0705                	add	a4,a4,1
 466:	4621                	li	a2,8
 468:	bfe9                	j	442 <strtol+0x46>
        s += 2, base = 16;
 46a:	0709                	add	a4,a4,2
 46c:	4641                	li	a2,16
 46e:	bfd1                	j	442 <strtol+0x46>
            dig = *s - '0';
 470:	fd07879b          	addw	a5,a5,-48
            dig = *s - 'a' + 10;
        else if (*s >= 'A' && *s <= 'Z')
            dig = *s - 'A' + 10;
        else
            break;
        if (dig >= base)
 474:	04c7d063          	bge	a5,a2,4b4 <strtol+0xb8>
            break;
        s++, val = (val * base) + dig;
 478:	0705                	add	a4,a4,1
 47a:	02a60533          	mul	a0,a2,a0
 47e:	953e                	add	a0,a0,a5
        if (*s >= '0' && *s <= '9')
 480:	00074783          	lbu	a5,0(a4)
 484:	fd07869b          	addw	a3,a5,-48
 488:	0ff6f693          	zext.b	a3,a3
 48c:	fed872e3          	bgeu	a6,a3,470 <strtol+0x74>
        else if (*s >= 'a' && *s <= 'z')
 490:	f9f7869b          	addw	a3,a5,-97
 494:	0ff6f693          	zext.b	a3,a3
 498:	00d8e563          	bltu	a7,a3,4a2 <strtol+0xa6>
            dig = *s - 'a' + 10;
 49c:	fa97879b          	addw	a5,a5,-87
 4a0:	bfd1                	j	474 <strtol+0x78>
        else if (*s >= 'A' && *s <= 'Z')
 4a2:	fbf7869b          	addw	a3,a5,-65
 4a6:	0ff6f693          	zext.b	a3,a3
 4aa:	00d8e563          	bltu	a7,a3,4b4 <strtol+0xb8>
            dig = *s - 'A' + 10;
 4ae:	fc97879b          	addw	a5,a5,-55
 4b2:	b7c9                	j	474 <strtol+0x78>
        // we don't properly detect overflow!
    }

    if (endptr)
 4b4:	c191                	beqz	a1,4b8 <strtol+0xbc>
        *endptr = (char *) s;
 4b6:	e198                	sd	a4,0(a1)
    return (neg ? -val : val);
 4b8:	00030463          	beqz	t1,4c0 <strtol+0xc4>
 4bc:	40a00533          	neg	a0,a0
}
 4c0:	6422                	ld	s0,8(sp)
 4c2:	0141                	add	sp,sp,16
 4c4:	8082                	ret

00000000000004c6 <inet_pton>:
inet_pton (int family, const char *p, void *n) {
    char *sp, *ep;
    int idx;
    long ret;

    if (family != AF_INET) {
 4c6:	4785                	li	a5,1
 4c8:	08f51263          	bne	a0,a5,54c <inet_pton+0x86>
inet_pton (int family, const char *p, void *n) {
 4cc:	715d                	add	sp,sp,-80
 4ce:	e486                	sd	ra,72(sp)
 4d0:	e0a2                	sd	s0,64(sp)
 4d2:	fc26                	sd	s1,56(sp)
 4d4:	f84a                	sd	s2,48(sp)
 4d6:	f44e                	sd	s3,40(sp)
 4d8:	f052                	sd	s4,32(sp)
 4da:	ec56                	sd	s5,24(sp)
 4dc:	e85a                	sd	s6,16(sp)
 4de:	0880                	add	s0,sp,80
 4e0:	892e                	mv	s2,a1
 4e2:	89b2                	mv	s3,a2
 4e4:	4481                	li	s1,0
        return -1;
    }
    sp = (char *)p;
    for (idx = 0; idx < 4; idx++) {
        ret = strtol(sp, &ep, 10);
        if (ret < 0 || ret > 255) {
 4e6:	0ff00a13          	li	s4,255
            return -1;
        }
        if (ep == sp) {
            return -1;
        }
        if ((idx == 3 && *ep != '\0') || (idx != 3 && *ep != '.')) {
 4ea:	4a8d                	li	s5,3
 4ec:	02e00b13          	li	s6,46
 4f0:	a815                	j	524 <inet_pton+0x5e>
 4f2:	0007c783          	lbu	a5,0(a5)
 4f6:	e3ad                	bnez	a5,558 <inet_pton+0x92>
            return -1;
        }
        ((uint8_t *)n)[idx] = ret;
 4f8:	2481                	sext.w	s1,s1
 4fa:	99a6                	add	s3,s3,s1
 4fc:	00a98023          	sb	a0,0(s3)
        sp = ep + 1;
    }
    return 0;
 500:	4501                	li	a0,0
}
 502:	60a6                	ld	ra,72(sp)
 504:	6406                	ld	s0,64(sp)
 506:	74e2                	ld	s1,56(sp)
 508:	7942                	ld	s2,48(sp)
 50a:	79a2                	ld	s3,40(sp)
 50c:	7a02                	ld	s4,32(sp)
 50e:	6ae2                	ld	s5,24(sp)
 510:	6b42                	ld	s6,16(sp)
 512:	6161                	add	sp,sp,80
 514:	8082                	ret
        ((uint8_t *)n)[idx] = ret;
 516:	00998733          	add	a4,s3,s1
 51a:	00a70023          	sb	a0,0(a4)
        sp = ep + 1;
 51e:	00178913          	add	s2,a5,1
    for (idx = 0; idx < 4; idx++) {
 522:	0485                	add	s1,s1,1
        ret = strtol(sp, &ep, 10);
 524:	4629                	li	a2,10
 526:	fb840593          	add	a1,s0,-72
 52a:	854a                	mv	a0,s2
 52c:	ed1ff0ef          	jal	3fc <strtol>
        if (ret < 0 || ret > 255) {
 530:	02aa6063          	bltu	s4,a0,550 <inet_pton+0x8a>
        if (ep == sp) {
 534:	fb843783          	ld	a5,-72(s0)
 538:	01278e63          	beq	a5,s2,554 <inet_pton+0x8e>
        if ((idx == 3 && *ep != '\0') || (idx != 3 && *ep != '.')) {
 53c:	fb548be3          	beq	s1,s5,4f2 <inet_pton+0x2c>
 540:	0007c703          	lbu	a4,0(a5)
 544:	fd6709e3          	beq	a4,s6,516 <inet_pton+0x50>
            return -1;
 548:	557d                	li	a0,-1
 54a:	bf65                	j	502 <inet_pton+0x3c>
        return -1;
 54c:	557d                	li	a0,-1
}
 54e:	8082                	ret
            return -1;
 550:	557d                	li	a0,-1
 552:	bf45                	j	502 <inet_pton+0x3c>
            return -1;
 554:	557d                	li	a0,-1
 556:	b775                	j	502 <inet_pton+0x3c>
            return -1;
 558:	557d                	li	a0,-1
 55a:	b765                	j	502 <inet_pton+0x3c>

000000000000055c <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 55c:	4885                	li	a7,1
 ecall
 55e:	00000073          	ecall
 ret
 562:	8082                	ret

0000000000000564 <exit>:
.global exit
exit:
 li a7, SYS_exit
 564:	4889                	li	a7,2
 ecall
 566:	00000073          	ecall
 ret
 56a:	8082                	ret

000000000000056c <wait>:
.global wait
wait:
 li a7, SYS_wait
 56c:	488d                	li	a7,3
 ecall
 56e:	00000073          	ecall
 ret
 572:	8082                	ret

0000000000000574 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 574:	4891                	li	a7,4
 ecall
 576:	00000073          	ecall
 ret
 57a:	8082                	ret

000000000000057c <read>:
.global read
read:
 li a7, SYS_read
 57c:	4895                	li	a7,5
 ecall
 57e:	00000073          	ecall
 ret
 582:	8082                	ret

0000000000000584 <write>:
.global write
write:
 li a7, SYS_write
 584:	48c1                	li	a7,16
 ecall
 586:	00000073          	ecall
 ret
 58a:	8082                	ret

000000000000058c <close>:
.global close
close:
 li a7, SYS_close
 58c:	48d5                	li	a7,21
 ecall
 58e:	00000073          	ecall
 ret
 592:	8082                	ret

0000000000000594 <kill>:
.global kill
kill:
 li a7, SYS_kill
 594:	4899                	li	a7,6
 ecall
 596:	00000073          	ecall
 ret
 59a:	8082                	ret

000000000000059c <exec>:
.global exec
exec:
 li a7, SYS_exec
 59c:	489d                	li	a7,7
 ecall
 59e:	00000073          	ecall
 ret
 5a2:	8082                	ret

00000000000005a4 <open>:
.global open
open:
 li a7, SYS_open
 5a4:	48bd                	li	a7,15
 ecall
 5a6:	00000073          	ecall
 ret
 5aa:	8082                	ret

00000000000005ac <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 5ac:	48c5                	li	a7,17
 ecall
 5ae:	00000073          	ecall
 ret
 5b2:	8082                	ret

00000000000005b4 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 5b4:	48c9                	li	a7,18
 ecall
 5b6:	00000073          	ecall
 ret
 5ba:	8082                	ret

00000000000005bc <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 5bc:	48a1                	li	a7,8
 ecall
 5be:	00000073          	ecall
 ret
 5c2:	8082                	ret

00000000000005c4 <link>:
.global link
link:
 li a7, SYS_link
 5c4:	48cd                	li	a7,19
 ecall
 5c6:	00000073          	ecall
 ret
 5ca:	8082                	ret

00000000000005cc <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 5cc:	48d1                	li	a7,20
 ecall
 5ce:	00000073          	ecall
 ret
 5d2:	8082                	ret

00000000000005d4 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 5d4:	48a5                	li	a7,9
 ecall
 5d6:	00000073          	ecall
 ret
 5da:	8082                	ret

00000000000005dc <dup>:
.global dup
dup:
 li a7, SYS_dup
 5dc:	48a9                	li	a7,10
 ecall
 5de:	00000073          	ecall
 ret
 5e2:	8082                	ret

00000000000005e4 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 5e4:	48ad                	li	a7,11
 ecall
 5e6:	00000073          	ecall
 ret
 5ea:	8082                	ret

00000000000005ec <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 5ec:	48b1                	li	a7,12
 ecall
 5ee:	00000073          	ecall
 ret
 5f2:	8082                	ret

00000000000005f4 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 5f4:	48b5                	li	a7,13
 ecall
 5f6:	00000073          	ecall
 ret
 5fa:	8082                	ret

00000000000005fc <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 5fc:	48b9                	li	a7,14
 ecall
 5fe:	00000073          	ecall
 ret
 602:	8082                	ret

0000000000000604 <socket>:
.global socket
socket:
 li a7, SYS_socket
 604:	48d9                	li	a7,22
 ecall
 606:	00000073          	ecall
 ret
 60a:	8082                	ret

000000000000060c <bind>:
.global bind
bind:
 li a7, SYS_bind
 60c:	48dd                	li	a7,23
 ecall
 60e:	00000073          	ecall
 ret
 612:	8082                	ret

0000000000000614 <recvfrom>:
.global recvfrom
recvfrom:
 li a7, SYS_recvfrom
 614:	48e1                	li	a7,24
 ecall
 616:	00000073          	ecall
 ret
 61a:	8082                	ret

000000000000061c <sendto>:
.global sendto
sendto:
 li a7, SYS_sendto
 61c:	48e5                	li	a7,25
 ecall
 61e:	00000073          	ecall
 ret
 622:	8082                	ret

0000000000000624 <connect>:
.global connect
connect:
 li a7, SYS_connect
 624:	48e9                	li	a7,26
 ecall
 626:	00000073          	ecall
 ret
 62a:	8082                	ret

000000000000062c <listen>:
.global listen
listen:
 li a7, SYS_listen
 62c:	48ed                	li	a7,27
 ecall
 62e:	00000073          	ecall
 ret
 632:	8082                	ret

0000000000000634 <accept>:
.global accept
accept:
 li a7, SYS_accept
 634:	48f1                	li	a7,28
 ecall
 636:	00000073          	ecall
 ret
 63a:	8082                	ret

000000000000063c <recv>:
.global recv
recv:
 li a7, SYS_recv
 63c:	48f5                	li	a7,29
 ecall
 63e:	00000073          	ecall
 ret
 642:	8082                	ret

0000000000000644 <send>:
.global send
send:
 li a7, SYS_send
 644:	48f9                	li	a7,30
 ecall
 646:	00000073          	ecall
 ret
 64a:	8082                	ret

000000000000064c <ioctl>:
.global ioctl
ioctl:
 li a7, SYS_ioctl
 64c:	48fd                	li	a7,31
 ecall
 64e:	00000073          	ecall
 ret
 652:	8082                	ret

0000000000000654 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 654:	1101                	add	sp,sp,-32
 656:	ec06                	sd	ra,24(sp)
 658:	e822                	sd	s0,16(sp)
 65a:	1000                	add	s0,sp,32
 65c:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 660:	4605                	li	a2,1
 662:	fef40593          	add	a1,s0,-17
 666:	f1fff0ef          	jal	584 <write>
}
 66a:	60e2                	ld	ra,24(sp)
 66c:	6442                	ld	s0,16(sp)
 66e:	6105                	add	sp,sp,32
 670:	8082                	ret

0000000000000672 <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
 672:	715d                	add	sp,sp,-80
 674:	e486                	sd	ra,72(sp)
 676:	e0a2                	sd	s0,64(sp)
 678:	fc26                	sd	s1,56(sp)
 67a:	f84a                	sd	s2,48(sp)
 67c:	f44e                	sd	s3,40(sp)
 67e:	0880                	add	s0,sp,80
 680:	84aa                	mv	s1,a0
  char buf[20];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 682:	c299                	beqz	a3,688 <printint+0x16>
 684:	0805c763          	bltz	a1,712 <printint+0xa0>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 688:	2581                	sext.w	a1,a1
  neg = 0;
 68a:	4881                	li	a7,0
 68c:	fb840693          	add	a3,s0,-72
  }

  i = 0;
 690:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 692:	2601                	sext.w	a2,a2
 694:	00000517          	auipc	a0,0x0
 698:	4e450513          	add	a0,a0,1252 # b78 <digits>
 69c:	883a                	mv	a6,a4
 69e:	2705                	addw	a4,a4,1
 6a0:	02c5f7bb          	remuw	a5,a1,a2
 6a4:	1782                	sll	a5,a5,0x20
 6a6:	9381                	srl	a5,a5,0x20
 6a8:	97aa                	add	a5,a5,a0
 6aa:	0007c783          	lbu	a5,0(a5)
 6ae:	00f68023          	sb	a5,0(a3) # ff0000 <base+0xfeeff0>
  }while((x /= base) != 0);
 6b2:	0005879b          	sext.w	a5,a1
 6b6:	02c5d5bb          	divuw	a1,a1,a2
 6ba:	0685                	add	a3,a3,1
 6bc:	fec7f0e3          	bgeu	a5,a2,69c <printint+0x2a>
  if(neg)
 6c0:	00088c63          	beqz	a7,6d8 <printint+0x66>
    buf[i++] = '-';
 6c4:	fd070793          	add	a5,a4,-48
 6c8:	00878733          	add	a4,a5,s0
 6cc:	02d00793          	li	a5,45
 6d0:	fef70423          	sb	a5,-24(a4)
 6d4:	0028071b          	addw	a4,a6,2

  while(--i >= 0)
 6d8:	02e05663          	blez	a4,704 <printint+0x92>
 6dc:	fb840793          	add	a5,s0,-72
 6e0:	00e78933          	add	s2,a5,a4
 6e4:	fff78993          	add	s3,a5,-1
 6e8:	99ba                	add	s3,s3,a4
 6ea:	377d                	addw	a4,a4,-1
 6ec:	1702                	sll	a4,a4,0x20
 6ee:	9301                	srl	a4,a4,0x20
 6f0:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 6f4:	fff94583          	lbu	a1,-1(s2)
 6f8:	8526                	mv	a0,s1
 6fa:	f5bff0ef          	jal	654 <putc>
  while(--i >= 0)
 6fe:	197d                	add	s2,s2,-1
 700:	ff391ae3          	bne	s2,s3,6f4 <printint+0x82>
}
 704:	60a6                	ld	ra,72(sp)
 706:	6406                	ld	s0,64(sp)
 708:	74e2                	ld	s1,56(sp)
 70a:	7942                	ld	s2,48(sp)
 70c:	79a2                	ld	s3,40(sp)
 70e:	6161                	add	sp,sp,80
 710:	8082                	ret
    x = -xx;
 712:	40b005bb          	negw	a1,a1
    neg = 1;
 716:	4885                	li	a7,1
    x = -xx;
 718:	bf95                	j	68c <printint+0x1a>

000000000000071a <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 71a:	711d                	add	sp,sp,-96
 71c:	ec86                	sd	ra,88(sp)
 71e:	e8a2                	sd	s0,80(sp)
 720:	e4a6                	sd	s1,72(sp)
 722:	e0ca                	sd	s2,64(sp)
 724:	fc4e                	sd	s3,56(sp)
 726:	f852                	sd	s4,48(sp)
 728:	f456                	sd	s5,40(sp)
 72a:	f05a                	sd	s6,32(sp)
 72c:	ec5e                	sd	s7,24(sp)
 72e:	e862                	sd	s8,16(sp)
 730:	e466                	sd	s9,8(sp)
 732:	e06a                	sd	s10,0(sp)
 734:	1080                	add	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 736:	0005c903          	lbu	s2,0(a1)
 73a:	24090763          	beqz	s2,988 <vprintf+0x26e>
 73e:	8b2a                	mv	s6,a0
 740:	8a2e                	mv	s4,a1
 742:	8bb2                	mv	s7,a2
  state = 0;
 744:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
 746:	4481                	li	s1,0
 748:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
 74a:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
 74e:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
 752:	06c00c93          	li	s9,108
 756:	a005                	j	776 <vprintf+0x5c>
        putc(fd, c0);
 758:	85ca                	mv	a1,s2
 75a:	855a                	mv	a0,s6
 75c:	ef9ff0ef          	jal	654 <putc>
 760:	a019                	j	766 <vprintf+0x4c>
    } else if(state == '%'){
 762:	03598263          	beq	s3,s5,786 <vprintf+0x6c>
  for(i = 0; fmt[i]; i++){
 766:	2485                	addw	s1,s1,1
 768:	8726                	mv	a4,s1
 76a:	009a07b3          	add	a5,s4,s1
 76e:	0007c903          	lbu	s2,0(a5)
 772:	20090b63          	beqz	s2,988 <vprintf+0x26e>
    c0 = fmt[i] & 0xff;
 776:	0009079b          	sext.w	a5,s2
    if(state == 0){
 77a:	fe0994e3          	bnez	s3,762 <vprintf+0x48>
      if(c0 == '%'){
 77e:	fd579de3          	bne	a5,s5,758 <vprintf+0x3e>
        state = '%';
 782:	89be                	mv	s3,a5
 784:	b7cd                	j	766 <vprintf+0x4c>
      if(c0) c1 = fmt[i+1] & 0xff;
 786:	c7c9                	beqz	a5,810 <vprintf+0xf6>
 788:	00ea06b3          	add	a3,s4,a4
 78c:	0016c683          	lbu	a3,1(a3)
      c1 = c2 = 0;
 790:	8636                	mv	a2,a3
      if(c1) c2 = fmt[i+2] & 0xff;
 792:	c681                	beqz	a3,79a <vprintf+0x80>
 794:	9752                	add	a4,a4,s4
 796:	00274603          	lbu	a2,2(a4)
      if(c0 == 'd'){
 79a:	03878f63          	beq	a5,s8,7d8 <vprintf+0xbe>
      } else if(c0 == 'l' && c1 == 'd'){
 79e:	05978963          	beq	a5,s9,7f0 <vprintf+0xd6>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
 7a2:	07500713          	li	a4,117
 7a6:	0ee78363          	beq	a5,a4,88c <vprintf+0x172>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
 7aa:	07800713          	li	a4,120
 7ae:	12e78563          	beq	a5,a4,8d8 <vprintf+0x1be>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
 7b2:	07000713          	li	a4,112
 7b6:	14e78a63          	beq	a5,a4,90a <vprintf+0x1f0>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 's'){
 7ba:	07300713          	li	a4,115
 7be:	18e78863          	beq	a5,a4,94e <vprintf+0x234>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
 7c2:	02500713          	li	a4,37
 7c6:	04e79563          	bne	a5,a4,810 <vprintf+0xf6>
        putc(fd, '%');
 7ca:	02500593          	li	a1,37
 7ce:	855a                	mv	a0,s6
 7d0:	e85ff0ef          	jal	654 <putc>
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
#endif
      state = 0;
 7d4:	4981                	li	s3,0
 7d6:	bf41                	j	766 <vprintf+0x4c>
        printint(fd, va_arg(ap, int), 10, 1);
 7d8:	008b8913          	add	s2,s7,8
 7dc:	4685                	li	a3,1
 7de:	4629                	li	a2,10
 7e0:	000ba583          	lw	a1,0(s7)
 7e4:	855a                	mv	a0,s6
 7e6:	e8dff0ef          	jal	672 <printint>
 7ea:	8bca                	mv	s7,s2
      state = 0;
 7ec:	4981                	li	s3,0
 7ee:	bfa5                	j	766 <vprintf+0x4c>
      } else if(c0 == 'l' && c1 == 'd'){
 7f0:	06400793          	li	a5,100
 7f4:	02f68963          	beq	a3,a5,826 <vprintf+0x10c>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 7f8:	06c00793          	li	a5,108
 7fc:	04f68263          	beq	a3,a5,840 <vprintf+0x126>
      } else if(c0 == 'l' && c1 == 'u'){
 800:	07500793          	li	a5,117
 804:	0af68063          	beq	a3,a5,8a4 <vprintf+0x18a>
      } else if(c0 == 'l' && c1 == 'x'){
 808:	07800793          	li	a5,120
 80c:	0ef68263          	beq	a3,a5,8f0 <vprintf+0x1d6>
        putc(fd, '%');
 810:	02500593          	li	a1,37
 814:	855a                	mv	a0,s6
 816:	e3fff0ef          	jal	654 <putc>
        putc(fd, c0);
 81a:	85ca                	mv	a1,s2
 81c:	855a                	mv	a0,s6
 81e:	e37ff0ef          	jal	654 <putc>
      state = 0;
 822:	4981                	li	s3,0
 824:	b789                	j	766 <vprintf+0x4c>
        printint(fd, va_arg(ap, uint64), 10, 1);
 826:	008b8913          	add	s2,s7,8
 82a:	4685                	li	a3,1
 82c:	4629                	li	a2,10
 82e:	000bb583          	ld	a1,0(s7)
 832:	855a                	mv	a0,s6
 834:	e3fff0ef          	jal	672 <printint>
        i += 1;
 838:	2485                	addw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 83a:	8bca                	mv	s7,s2
      state = 0;
 83c:	4981                	li	s3,0
        i += 1;
 83e:	b725                	j	766 <vprintf+0x4c>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 840:	06400793          	li	a5,100
 844:	02f60763          	beq	a2,a5,872 <vprintf+0x158>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 848:	07500793          	li	a5,117
 84c:	06f60963          	beq	a2,a5,8be <vprintf+0x1a4>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 850:	07800793          	li	a5,120
 854:	faf61ee3          	bne	a2,a5,810 <vprintf+0xf6>
        printint(fd, va_arg(ap, uint64), 16, 0);
 858:	008b8913          	add	s2,s7,8
 85c:	4681                	li	a3,0
 85e:	4641                	li	a2,16
 860:	000bb583          	ld	a1,0(s7)
 864:	855a                	mv	a0,s6
 866:	e0dff0ef          	jal	672 <printint>
        i += 2;
 86a:	2489                	addw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 86c:	8bca                	mv	s7,s2
      state = 0;
 86e:	4981                	li	s3,0
        i += 2;
 870:	bddd                	j	766 <vprintf+0x4c>
        printint(fd, va_arg(ap, uint64), 10, 1);
 872:	008b8913          	add	s2,s7,8
 876:	4685                	li	a3,1
 878:	4629                	li	a2,10
 87a:	000bb583          	ld	a1,0(s7)
 87e:	855a                	mv	a0,s6
 880:	df3ff0ef          	jal	672 <printint>
        i += 2;
 884:	2489                	addw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 886:	8bca                	mv	s7,s2
      state = 0;
 888:	4981                	li	s3,0
        i += 2;
 88a:	bdf1                	j	766 <vprintf+0x4c>
        printint(fd, va_arg(ap, int), 10, 0);
 88c:	008b8913          	add	s2,s7,8
 890:	4681                	li	a3,0
 892:	4629                	li	a2,10
 894:	000ba583          	lw	a1,0(s7)
 898:	855a                	mv	a0,s6
 89a:	dd9ff0ef          	jal	672 <printint>
 89e:	8bca                	mv	s7,s2
      state = 0;
 8a0:	4981                	li	s3,0
 8a2:	b5d1                	j	766 <vprintf+0x4c>
        printint(fd, va_arg(ap, uint64), 10, 0);
 8a4:	008b8913          	add	s2,s7,8
 8a8:	4681                	li	a3,0
 8aa:	4629                	li	a2,10
 8ac:	000bb583          	ld	a1,0(s7)
 8b0:	855a                	mv	a0,s6
 8b2:	dc1ff0ef          	jal	672 <printint>
        i += 1;
 8b6:	2485                	addw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 8b8:	8bca                	mv	s7,s2
      state = 0;
 8ba:	4981                	li	s3,0
        i += 1;
 8bc:	b56d                	j	766 <vprintf+0x4c>
        printint(fd, va_arg(ap, uint64), 10, 0);
 8be:	008b8913          	add	s2,s7,8
 8c2:	4681                	li	a3,0
 8c4:	4629                	li	a2,10
 8c6:	000bb583          	ld	a1,0(s7)
 8ca:	855a                	mv	a0,s6
 8cc:	da7ff0ef          	jal	672 <printint>
        i += 2;
 8d0:	2489                	addw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 8d2:	8bca                	mv	s7,s2
      state = 0;
 8d4:	4981                	li	s3,0
        i += 2;
 8d6:	bd41                	j	766 <vprintf+0x4c>
        printint(fd, va_arg(ap, int), 16, 0);
 8d8:	008b8913          	add	s2,s7,8
 8dc:	4681                	li	a3,0
 8de:	4641                	li	a2,16
 8e0:	000ba583          	lw	a1,0(s7)
 8e4:	855a                	mv	a0,s6
 8e6:	d8dff0ef          	jal	672 <printint>
 8ea:	8bca                	mv	s7,s2
      state = 0;
 8ec:	4981                	li	s3,0
 8ee:	bda5                	j	766 <vprintf+0x4c>
        printint(fd, va_arg(ap, uint64), 16, 0);
 8f0:	008b8913          	add	s2,s7,8
 8f4:	4681                	li	a3,0
 8f6:	4641                	li	a2,16
 8f8:	000bb583          	ld	a1,0(s7)
 8fc:	855a                	mv	a0,s6
 8fe:	d75ff0ef          	jal	672 <printint>
        i += 1;
 902:	2485                	addw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 904:	8bca                	mv	s7,s2
      state = 0;
 906:	4981                	li	s3,0
        i += 1;
 908:	bdb9                	j	766 <vprintf+0x4c>
        printptr(fd, va_arg(ap, uint64));
 90a:	008b8d13          	add	s10,s7,8
 90e:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 912:	03000593          	li	a1,48
 916:	855a                	mv	a0,s6
 918:	d3dff0ef          	jal	654 <putc>
  putc(fd, 'x');
 91c:	07800593          	li	a1,120
 920:	855a                	mv	a0,s6
 922:	d33ff0ef          	jal	654 <putc>
 926:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 928:	00000b97          	auipc	s7,0x0
 92c:	250b8b93          	add	s7,s7,592 # b78 <digits>
 930:	03c9d793          	srl	a5,s3,0x3c
 934:	97de                	add	a5,a5,s7
 936:	0007c583          	lbu	a1,0(a5)
 93a:	855a                	mv	a0,s6
 93c:	d19ff0ef          	jal	654 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 940:	0992                	sll	s3,s3,0x4
 942:	397d                	addw	s2,s2,-1
 944:	fe0916e3          	bnez	s2,930 <vprintf+0x216>
        printptr(fd, va_arg(ap, uint64));
 948:	8bea                	mv	s7,s10
      state = 0;
 94a:	4981                	li	s3,0
 94c:	bd29                	j	766 <vprintf+0x4c>
        if((s = va_arg(ap, char*)) == 0)
 94e:	008b8993          	add	s3,s7,8
 952:	000bb903          	ld	s2,0(s7)
 956:	00090f63          	beqz	s2,974 <vprintf+0x25a>
        for(; *s; s++)
 95a:	00094583          	lbu	a1,0(s2)
 95e:	c195                	beqz	a1,982 <vprintf+0x268>
          putc(fd, *s);
 960:	855a                	mv	a0,s6
 962:	cf3ff0ef          	jal	654 <putc>
        for(; *s; s++)
 966:	0905                	add	s2,s2,1
 968:	00094583          	lbu	a1,0(s2)
 96c:	f9f5                	bnez	a1,960 <vprintf+0x246>
        if((s = va_arg(ap, char*)) == 0)
 96e:	8bce                	mv	s7,s3
      state = 0;
 970:	4981                	li	s3,0
 972:	bbd5                	j	766 <vprintf+0x4c>
          s = "(null)";
 974:	00000917          	auipc	s2,0x0
 978:	1fc90913          	add	s2,s2,508 # b70 <malloc+0xee>
        for(; *s; s++)
 97c:	02800593          	li	a1,40
 980:	b7c5                	j	960 <vprintf+0x246>
        if((s = va_arg(ap, char*)) == 0)
 982:	8bce                	mv	s7,s3
      state = 0;
 984:	4981                	li	s3,0
 986:	b3c5                	j	766 <vprintf+0x4c>
    }
  }
}
 988:	60e6                	ld	ra,88(sp)
 98a:	6446                	ld	s0,80(sp)
 98c:	64a6                	ld	s1,72(sp)
 98e:	6906                	ld	s2,64(sp)
 990:	79e2                	ld	s3,56(sp)
 992:	7a42                	ld	s4,48(sp)
 994:	7aa2                	ld	s5,40(sp)
 996:	7b02                	ld	s6,32(sp)
 998:	6be2                	ld	s7,24(sp)
 99a:	6c42                	ld	s8,16(sp)
 99c:	6ca2                	ld	s9,8(sp)
 99e:	6d02                	ld	s10,0(sp)
 9a0:	6125                	add	sp,sp,96
 9a2:	8082                	ret

00000000000009a4 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 9a4:	715d                	add	sp,sp,-80
 9a6:	ec06                	sd	ra,24(sp)
 9a8:	e822                	sd	s0,16(sp)
 9aa:	1000                	add	s0,sp,32
 9ac:	e010                	sd	a2,0(s0)
 9ae:	e414                	sd	a3,8(s0)
 9b0:	e818                	sd	a4,16(s0)
 9b2:	ec1c                	sd	a5,24(s0)
 9b4:	03043023          	sd	a6,32(s0)
 9b8:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 9bc:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 9c0:	8622                	mv	a2,s0
 9c2:	d59ff0ef          	jal	71a <vprintf>
}
 9c6:	60e2                	ld	ra,24(sp)
 9c8:	6442                	ld	s0,16(sp)
 9ca:	6161                	add	sp,sp,80
 9cc:	8082                	ret

00000000000009ce <printf>:

void
printf(const char *fmt, ...)
{
 9ce:	711d                	add	sp,sp,-96
 9d0:	ec06                	sd	ra,24(sp)
 9d2:	e822                	sd	s0,16(sp)
 9d4:	1000                	add	s0,sp,32
 9d6:	e40c                	sd	a1,8(s0)
 9d8:	e810                	sd	a2,16(s0)
 9da:	ec14                	sd	a3,24(s0)
 9dc:	f018                	sd	a4,32(s0)
 9de:	f41c                	sd	a5,40(s0)
 9e0:	03043823          	sd	a6,48(s0)
 9e4:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 9e8:	00840613          	add	a2,s0,8
 9ec:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 9f0:	85aa                	mv	a1,a0
 9f2:	4505                	li	a0,1
 9f4:	d27ff0ef          	jal	71a <vprintf>
}
 9f8:	60e2                	ld	ra,24(sp)
 9fa:	6442                	ld	s0,16(sp)
 9fc:	6125                	add	sp,sp,96
 9fe:	8082                	ret

0000000000000a00 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 a00:	1141                	add	sp,sp,-16
 a02:	e422                	sd	s0,8(sp)
 a04:	0800                	add	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 a06:	ff050693          	add	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 a0a:	00000797          	auipc	a5,0x0
 a0e:	5fe7b783          	ld	a5,1534(a5) # 1008 <freep>
 a12:	a02d                	j	a3c <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 a14:	4618                	lw	a4,8(a2)
 a16:	9f2d                	addw	a4,a4,a1
 a18:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 a1c:	6398                	ld	a4,0(a5)
 a1e:	6310                	ld	a2,0(a4)
 a20:	a83d                	j	a5e <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 a22:	ff852703          	lw	a4,-8(a0)
 a26:	9f31                	addw	a4,a4,a2
 a28:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 a2a:	ff053683          	ld	a3,-16(a0)
 a2e:	a091                	j	a72 <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 a30:	6398                	ld	a4,0(a5)
 a32:	00e7e463          	bltu	a5,a4,a3a <free+0x3a>
 a36:	00e6ea63          	bltu	a3,a4,a4a <free+0x4a>
{
 a3a:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 a3c:	fed7fae3          	bgeu	a5,a3,a30 <free+0x30>
 a40:	6398                	ld	a4,0(a5)
 a42:	00e6e463          	bltu	a3,a4,a4a <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 a46:	fee7eae3          	bltu	a5,a4,a3a <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 a4a:	ff852583          	lw	a1,-8(a0)
 a4e:	6390                	ld	a2,0(a5)
 a50:	02059813          	sll	a6,a1,0x20
 a54:	01c85713          	srl	a4,a6,0x1c
 a58:	9736                	add	a4,a4,a3
 a5a:	fae60de3          	beq	a2,a4,a14 <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 a5e:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 a62:	4790                	lw	a2,8(a5)
 a64:	02061593          	sll	a1,a2,0x20
 a68:	01c5d713          	srl	a4,a1,0x1c
 a6c:	973e                	add	a4,a4,a5
 a6e:	fae68ae3          	beq	a3,a4,a22 <free+0x22>
    p->s.ptr = bp->s.ptr;
 a72:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 a74:	00000717          	auipc	a4,0x0
 a78:	58f73a23          	sd	a5,1428(a4) # 1008 <freep>
}
 a7c:	6422                	ld	s0,8(sp)
 a7e:	0141                	add	sp,sp,16
 a80:	8082                	ret

0000000000000a82 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 a82:	7139                	add	sp,sp,-64
 a84:	fc06                	sd	ra,56(sp)
 a86:	f822                	sd	s0,48(sp)
 a88:	f426                	sd	s1,40(sp)
 a8a:	f04a                	sd	s2,32(sp)
 a8c:	ec4e                	sd	s3,24(sp)
 a8e:	e852                	sd	s4,16(sp)
 a90:	e456                	sd	s5,8(sp)
 a92:	e05a                	sd	s6,0(sp)
 a94:	0080                	add	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 a96:	02051493          	sll	s1,a0,0x20
 a9a:	9081                	srl	s1,s1,0x20
 a9c:	04bd                	add	s1,s1,15
 a9e:	8091                	srl	s1,s1,0x4
 aa0:	0014899b          	addw	s3,s1,1
 aa4:	0485                	add	s1,s1,1
  if((prevp = freep) == 0){
 aa6:	00000517          	auipc	a0,0x0
 aaa:	56253503          	ld	a0,1378(a0) # 1008 <freep>
 aae:	c515                	beqz	a0,ada <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 ab0:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 ab2:	4798                	lw	a4,8(a5)
 ab4:	02977f63          	bgeu	a4,s1,af2 <malloc+0x70>
  if(nu < 4096)
 ab8:	8a4e                	mv	s4,s3
 aba:	0009871b          	sext.w	a4,s3
 abe:	6685                	lui	a3,0x1
 ac0:	00d77363          	bgeu	a4,a3,ac6 <malloc+0x44>
 ac4:	6a05                	lui	s4,0x1
 ac6:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 aca:	004a1a1b          	sllw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 ace:	00000917          	auipc	s2,0x0
 ad2:	53a90913          	add	s2,s2,1338 # 1008 <freep>
  if(p == (char*)-1)
 ad6:	5afd                	li	s5,-1
 ad8:	a885                	j	b48 <malloc+0xc6>
    base.s.ptr = freep = prevp = &base;
 ada:	00000797          	auipc	a5,0x0
 ade:	53678793          	add	a5,a5,1334 # 1010 <base>
 ae2:	00000717          	auipc	a4,0x0
 ae6:	52f73323          	sd	a5,1318(a4) # 1008 <freep>
 aea:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 aec:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 af0:	b7e1                	j	ab8 <malloc+0x36>
      if(p->s.size == nunits)
 af2:	02e48c63          	beq	s1,a4,b2a <malloc+0xa8>
        p->s.size -= nunits;
 af6:	4137073b          	subw	a4,a4,s3
 afa:	c798                	sw	a4,8(a5)
        p += p->s.size;
 afc:	02071693          	sll	a3,a4,0x20
 b00:	01c6d713          	srl	a4,a3,0x1c
 b04:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 b06:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 b0a:	00000717          	auipc	a4,0x0
 b0e:	4ea73f23          	sd	a0,1278(a4) # 1008 <freep>
      return (void*)(p + 1);
 b12:	01078513          	add	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 b16:	70e2                	ld	ra,56(sp)
 b18:	7442                	ld	s0,48(sp)
 b1a:	74a2                	ld	s1,40(sp)
 b1c:	7902                	ld	s2,32(sp)
 b1e:	69e2                	ld	s3,24(sp)
 b20:	6a42                	ld	s4,16(sp)
 b22:	6aa2                	ld	s5,8(sp)
 b24:	6b02                	ld	s6,0(sp)
 b26:	6121                	add	sp,sp,64
 b28:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 b2a:	6398                	ld	a4,0(a5)
 b2c:	e118                	sd	a4,0(a0)
 b2e:	bff1                	j	b0a <malloc+0x88>
  hp->s.size = nu;
 b30:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 b34:	0541                	add	a0,a0,16
 b36:	ecbff0ef          	jal	a00 <free>
  return freep;
 b3a:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 b3e:	dd61                	beqz	a0,b16 <malloc+0x94>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 b40:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 b42:	4798                	lw	a4,8(a5)
 b44:	fa9777e3          	bgeu	a4,s1,af2 <malloc+0x70>
    if(p == freep)
 b48:	00093703          	ld	a4,0(s2)
 b4c:	853e                	mv	a0,a5
 b4e:	fef719e3          	bne	a4,a5,b40 <malloc+0xbe>
  p = sbrk(nu * sizeof(Header));
 b52:	8552                	mv	a0,s4
 b54:	a99ff0ef          	jal	5ec <sbrk>
  if(p == (char*)-1)
 b58:	fd551ce3          	bne	a0,s5,b30 <malloc+0xae>
        return 0;
 b5c:	4501                	li	a0,0
 b5e:	bf65                	j	b16 <malloc+0x94>
