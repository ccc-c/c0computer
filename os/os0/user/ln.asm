
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
   6:	1000                	add	s0,sp,32
  if(argc != 3){
   8:	478d                	li	a5,3
   a:	00f50d63          	beq	a0,a5,24 <main+0x24>
   e:	e426                	sd	s1,8(sp)
    fprintf(2, "Usage: ln old new\n");
  10:	00001597          	auipc	a1,0x1
  14:	a3058593          	add	a1,a1,-1488 # a40 <malloc+0x100>
  18:	4509                	li	a0,2
  1a:	049000ef          	jal	862 <fprintf>
    exit(1);
  1e:	4505                	li	a0,1
  20:	3fc000ef          	jal	41c <exit>
  24:	e426                	sd	s1,8(sp)
  26:	84ae                	mv	s1,a1
  }
  if(link(argv[1], argv[2]) < 0)
  28:	698c                	ld	a1,16(a1)
  2a:	6488                	ld	a0,8(s1)
  2c:	450000ef          	jal	47c <link>
  30:	00054563          	bltz	a0,3a <main+0x3a>
    fprintf(2, "link %s %s: failed\n", argv[1], argv[2]);
  exit(0);
  34:	4501                	li	a0,0
  36:	3e6000ef          	jal	41c <exit>
    fprintf(2, "link %s %s: failed\n", argv[1], argv[2]);
  3a:	6894                	ld	a3,16(s1)
  3c:	6490                	ld	a2,8(s1)
  3e:	00001597          	auipc	a1,0x1
  42:	a1a58593          	add	a1,a1,-1510 # a58 <malloc+0x118>
  46:	4509                	li	a0,2
  48:	01b000ef          	jal	862 <fprintf>
  4c:	b7e5                	j	34 <main+0x34>

000000000000004e <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start(int argc, char **argv)
{
  4e:	1141                	add	sp,sp,-16
  50:	e406                	sd	ra,8(sp)
  52:	e022                	sd	s0,0(sp)
  54:	0800                	add	s0,sp,16
  int r;
  extern int main(int argc, char **argv);
  r = main(argc, argv);
  56:	fabff0ef          	jal	0 <main>
  exit(r);
  5a:	3c2000ef          	jal	41c <exit>

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

00000000000000a6 <strncmp>:

int
strncmp(const char *p, const char *q, uint n)
{
  a6:	1141                	add	sp,sp,-16
  a8:	e422                	sd	s0,8(sp)
  aa:	0800                	add	s0,sp,16
  while(n > 0 && *p && *p == *q) {
  ac:	ce11                	beqz	a2,c8 <strncmp+0x22>
  ae:	00054783          	lbu	a5,0(a0)
  b2:	cf89                	beqz	a5,cc <strncmp+0x26>
  b4:	0005c703          	lbu	a4,0(a1)
  b8:	00f71a63          	bne	a4,a5,cc <strncmp+0x26>
    p++, q++, n--;
  bc:	0505                	add	a0,a0,1
  be:	0585                	add	a1,a1,1
  c0:	367d                	addw	a2,a2,-1
  while(n > 0 && *p && *p == *q) {
  c2:	f675                	bnez	a2,ae <strncmp+0x8>
  }
  if (n == 0)
    return 0;
  c4:	4501                	li	a0,0
  c6:	a801                	j	d6 <strncmp+0x30>
  c8:	4501                	li	a0,0
  ca:	a031                	j	d6 <strncmp+0x30>
  return (uchar)*p - (uchar)*q;
  cc:	00054503          	lbu	a0,0(a0)
  d0:	0005c783          	lbu	a5,0(a1)
  d4:	9d1d                	subw	a0,a0,a5
}
  d6:	6422                	ld	s0,8(sp)
  d8:	0141                	add	sp,sp,16
  da:	8082                	ret

00000000000000dc <strcat>:

char*
strcat(char *dst, const char *src)
{
  dc:	1141                	add	sp,sp,-16
  de:	e422                	sd	s0,8(sp)
  e0:	0800                	add	s0,sp,16
  char *p = dst;
  while(*p) p++;
  e2:	00054783          	lbu	a5,0(a0)
  e6:	c385                	beqz	a5,106 <strcat+0x2a>
  char *p = dst;
  e8:	87aa                	mv	a5,a0
  while(*p) p++;
  ea:	0785                	add	a5,a5,1
  ec:	0007c703          	lbu	a4,0(a5)
  f0:	ff6d                	bnez	a4,ea <strcat+0xe>
  while((*p++ = *src++) != 0);
  f2:	0585                	add	a1,a1,1
  f4:	0785                	add	a5,a5,1
  f6:	fff5c703          	lbu	a4,-1(a1)
  fa:	fee78fa3          	sb	a4,-1(a5)
  fe:	fb75                	bnez	a4,f2 <strcat+0x16>
  return dst;
}
 100:	6422                	ld	s0,8(sp)
 102:	0141                	add	sp,sp,16
 104:	8082                	ret
  char *p = dst;
 106:	87aa                	mv	a5,a0
 108:	b7ed                	j	f2 <strcat+0x16>

000000000000010a <strncpy>:

char*
strncpy(char *dst, const char *src, int n)
{
 10a:	1141                	add	sp,sp,-16
 10c:	e422                	sd	s0,8(sp)
 10e:	0800                	add	s0,sp,16
  char *p = dst;
 110:	87aa                	mv	a5,a0
  while(n > 0 && *src) {
 112:	02c05463          	blez	a2,13a <strncpy+0x30>
 116:	0005c703          	lbu	a4,0(a1)
 11a:	cb01                	beqz	a4,12a <strncpy+0x20>
    *p++ = *src++;
 11c:	0585                	add	a1,a1,1
 11e:	0785                	add	a5,a5,1
 120:	fee78fa3          	sb	a4,-1(a5)
    n--;
 124:	367d                	addw	a2,a2,-1
  while(n > 0 && *src) {
 126:	fa65                	bnez	a2,116 <strncpy+0xc>
 128:	a809                	j	13a <strncpy+0x30>
  }
  while(n > 0) {
 12a:	1602                	sll	a2,a2,0x20
 12c:	9201                	srl	a2,a2,0x20
 12e:	963e                	add	a2,a2,a5
    *p++ = 0;
 130:	0785                	add	a5,a5,1
 132:	fe078fa3          	sb	zero,-1(a5)
  while(n > 0) {
 136:	fec79de3          	bne	a5,a2,130 <strncpy+0x26>
    n--;
  }
  return dst;
}
 13a:	6422                	ld	s0,8(sp)
 13c:	0141                	add	sp,sp,16
 13e:	8082                	ret

0000000000000140 <strlen>:

uint
strlen(const char *s)
{
 140:	1141                	add	sp,sp,-16
 142:	e422                	sd	s0,8(sp)
 144:	0800                	add	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 146:	00054783          	lbu	a5,0(a0)
 14a:	cf91                	beqz	a5,166 <strlen+0x26>
 14c:	0505                	add	a0,a0,1
 14e:	87aa                	mv	a5,a0
 150:	86be                	mv	a3,a5
 152:	0785                	add	a5,a5,1
 154:	fff7c703          	lbu	a4,-1(a5)
 158:	ff65                	bnez	a4,150 <strlen+0x10>
 15a:	40a6853b          	subw	a0,a3,a0
 15e:	2505                	addw	a0,a0,1
    ;
  return n;
}
 160:	6422                	ld	s0,8(sp)
 162:	0141                	add	sp,sp,16
 164:	8082                	ret
  for(n = 0; s[n]; n++)
 166:	4501                	li	a0,0
 168:	bfe5                	j	160 <strlen+0x20>

000000000000016a <memset>:

void*
memset(void *dst, int c, uint n)
{
 16a:	1141                	add	sp,sp,-16
 16c:	e422                	sd	s0,8(sp)
 16e:	0800                	add	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 170:	ca19                	beqz	a2,186 <memset+0x1c>
 172:	87aa                	mv	a5,a0
 174:	1602                	sll	a2,a2,0x20
 176:	9201                	srl	a2,a2,0x20
 178:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 17c:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 180:	0785                	add	a5,a5,1
 182:	fee79de3          	bne	a5,a4,17c <memset+0x12>
  }
  return dst;
}
 186:	6422                	ld	s0,8(sp)
 188:	0141                	add	sp,sp,16
 18a:	8082                	ret

000000000000018c <strchr>:

char*
strchr(const char *s, char c)
{
 18c:	1141                	add	sp,sp,-16
 18e:	e422                	sd	s0,8(sp)
 190:	0800                	add	s0,sp,16
  for(; *s; s++)
 192:	00054783          	lbu	a5,0(a0)
 196:	cb99                	beqz	a5,1ac <strchr+0x20>
    if(*s == c)
 198:	00f58763          	beq	a1,a5,1a6 <strchr+0x1a>
  for(; *s; s++)
 19c:	0505                	add	a0,a0,1
 19e:	00054783          	lbu	a5,0(a0)
 1a2:	fbfd                	bnez	a5,198 <strchr+0xc>
      return (char*)s;
  return 0;
 1a4:	4501                	li	a0,0
}
 1a6:	6422                	ld	s0,8(sp)
 1a8:	0141                	add	sp,sp,16
 1aa:	8082                	ret
  return 0;
 1ac:	4501                	li	a0,0
 1ae:	bfe5                	j	1a6 <strchr+0x1a>

00000000000001b0 <gets>:

char*
gets(char *buf, int max)
{
 1b0:	711d                	add	sp,sp,-96
 1b2:	ec86                	sd	ra,88(sp)
 1b4:	e8a2                	sd	s0,80(sp)
 1b6:	e4a6                	sd	s1,72(sp)
 1b8:	e0ca                	sd	s2,64(sp)
 1ba:	fc4e                	sd	s3,56(sp)
 1bc:	f852                	sd	s4,48(sp)
 1be:	f456                	sd	s5,40(sp)
 1c0:	f05a                	sd	s6,32(sp)
 1c2:	ec5e                	sd	s7,24(sp)
 1c4:	1080                	add	s0,sp,96
 1c6:	8baa                	mv	s7,a0
 1c8:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1ca:	892a                	mv	s2,a0
 1cc:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 1ce:	4aa9                	li	s5,10
 1d0:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 1d2:	89a6                	mv	s3,s1
 1d4:	2485                	addw	s1,s1,1
 1d6:	0344d663          	bge	s1,s4,202 <gets+0x52>
    cc = read(0, &c, 1);
 1da:	4605                	li	a2,1
 1dc:	faf40593          	add	a1,s0,-81
 1e0:	4501                	li	a0,0
 1e2:	252000ef          	jal	434 <read>
    if(cc < 1)
 1e6:	00a05e63          	blez	a0,202 <gets+0x52>
    buf[i++] = c;
 1ea:	faf44783          	lbu	a5,-81(s0)
 1ee:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 1f2:	01578763          	beq	a5,s5,200 <gets+0x50>
 1f6:	0905                	add	s2,s2,1
 1f8:	fd679de3          	bne	a5,s6,1d2 <gets+0x22>
    buf[i++] = c;
 1fc:	89a6                	mv	s3,s1
 1fe:	a011                	j	202 <gets+0x52>
 200:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 202:	99de                	add	s3,s3,s7
 204:	00098023          	sb	zero,0(s3)
  return buf;
}
 208:	855e                	mv	a0,s7
 20a:	60e6                	ld	ra,88(sp)
 20c:	6446                	ld	s0,80(sp)
 20e:	64a6                	ld	s1,72(sp)
 210:	6906                	ld	s2,64(sp)
 212:	79e2                	ld	s3,56(sp)
 214:	7a42                	ld	s4,48(sp)
 216:	7aa2                	ld	s5,40(sp)
 218:	7b02                	ld	s6,32(sp)
 21a:	6be2                	ld	s7,24(sp)
 21c:	6125                	add	sp,sp,96
 21e:	8082                	ret

0000000000000220 <stat>:

int
stat(const char *n, struct stat *st)
{
 220:	1101                	add	sp,sp,-32
 222:	ec06                	sd	ra,24(sp)
 224:	e822                	sd	s0,16(sp)
 226:	e04a                	sd	s2,0(sp)
 228:	1000                	add	s0,sp,32
 22a:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 22c:	4581                	li	a1,0
 22e:	22e000ef          	jal	45c <open>
  if(fd < 0)
 232:	02054263          	bltz	a0,256 <stat+0x36>
 236:	e426                	sd	s1,8(sp)
 238:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 23a:	85ca                	mv	a1,s2
 23c:	238000ef          	jal	474 <fstat>
 240:	892a                	mv	s2,a0
  close(fd);
 242:	8526                	mv	a0,s1
 244:	200000ef          	jal	444 <close>
  return r;
 248:	64a2                	ld	s1,8(sp)
}
 24a:	854a                	mv	a0,s2
 24c:	60e2                	ld	ra,24(sp)
 24e:	6442                	ld	s0,16(sp)
 250:	6902                	ld	s2,0(sp)
 252:	6105                	add	sp,sp,32
 254:	8082                	ret
    return -1;
 256:	597d                	li	s2,-1
 258:	bfcd                	j	24a <stat+0x2a>

000000000000025a <atoi>:

int
atoi(const char *s)
{
 25a:	1141                	add	sp,sp,-16
 25c:	e422                	sd	s0,8(sp)
 25e:	0800                	add	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 260:	00054683          	lbu	a3,0(a0)
 264:	fd06879b          	addw	a5,a3,-48
 268:	0ff7f793          	zext.b	a5,a5
 26c:	4625                	li	a2,9
 26e:	02f66863          	bltu	a2,a5,29e <atoi+0x44>
 272:	872a                	mv	a4,a0
  n = 0;
 274:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 276:	0705                	add	a4,a4,1
 278:	0025179b          	sllw	a5,a0,0x2
 27c:	9fa9                	addw	a5,a5,a0
 27e:	0017979b          	sllw	a5,a5,0x1
 282:	9fb5                	addw	a5,a5,a3
 284:	fd07851b          	addw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 288:	00074683          	lbu	a3,0(a4)
 28c:	fd06879b          	addw	a5,a3,-48
 290:	0ff7f793          	zext.b	a5,a5
 294:	fef671e3          	bgeu	a2,a5,276 <atoi+0x1c>
  return n;
}
 298:	6422                	ld	s0,8(sp)
 29a:	0141                	add	sp,sp,16
 29c:	8082                	ret
  n = 0;
 29e:	4501                	li	a0,0
 2a0:	bfe5                	j	298 <atoi+0x3e>

00000000000002a2 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 2a2:	1141                	add	sp,sp,-16
 2a4:	e422                	sd	s0,8(sp)
 2a6:	0800                	add	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 2a8:	02b57463          	bgeu	a0,a1,2d0 <memmove+0x2e>
    while(n-- > 0)
 2ac:	00c05f63          	blez	a2,2ca <memmove+0x28>
 2b0:	1602                	sll	a2,a2,0x20
 2b2:	9201                	srl	a2,a2,0x20
 2b4:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 2b8:	872a                	mv	a4,a0
      *dst++ = *src++;
 2ba:	0585                	add	a1,a1,1
 2bc:	0705                	add	a4,a4,1
 2be:	fff5c683          	lbu	a3,-1(a1)
 2c2:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 2c6:	fef71ae3          	bne	a4,a5,2ba <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 2ca:	6422                	ld	s0,8(sp)
 2cc:	0141                	add	sp,sp,16
 2ce:	8082                	ret
    dst += n;
 2d0:	00c50733          	add	a4,a0,a2
    src += n;
 2d4:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 2d6:	fec05ae3          	blez	a2,2ca <memmove+0x28>
 2da:	fff6079b          	addw	a5,a2,-1
 2de:	1782                	sll	a5,a5,0x20
 2e0:	9381                	srl	a5,a5,0x20
 2e2:	fff7c793          	not	a5,a5
 2e6:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 2e8:	15fd                	add	a1,a1,-1
 2ea:	177d                	add	a4,a4,-1
 2ec:	0005c683          	lbu	a3,0(a1)
 2f0:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 2f4:	fee79ae3          	bne	a5,a4,2e8 <memmove+0x46>
 2f8:	bfc9                	j	2ca <memmove+0x28>

00000000000002fa <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 2fa:	1141                	add	sp,sp,-16
 2fc:	e422                	sd	s0,8(sp)
 2fe:	0800                	add	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 300:	ca05                	beqz	a2,330 <memcmp+0x36>
 302:	fff6069b          	addw	a3,a2,-1
 306:	1682                	sll	a3,a3,0x20
 308:	9281                	srl	a3,a3,0x20
 30a:	0685                	add	a3,a3,1
 30c:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 30e:	00054783          	lbu	a5,0(a0)
 312:	0005c703          	lbu	a4,0(a1)
 316:	00e79863          	bne	a5,a4,326 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 31a:	0505                	add	a0,a0,1
    p2++;
 31c:	0585                	add	a1,a1,1
  while (n-- > 0) {
 31e:	fed518e3          	bne	a0,a3,30e <memcmp+0x14>
  }
  return 0;
 322:	4501                	li	a0,0
 324:	a019                	j	32a <memcmp+0x30>
      return *p1 - *p2;
 326:	40e7853b          	subw	a0,a5,a4
}
 32a:	6422                	ld	s0,8(sp)
 32c:	0141                	add	sp,sp,16
 32e:	8082                	ret
  return 0;
 330:	4501                	li	a0,0
 332:	bfe5                	j	32a <memcmp+0x30>

0000000000000334 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 334:	1141                	add	sp,sp,-16
 336:	e406                	sd	ra,8(sp)
 338:	e022                	sd	s0,0(sp)
 33a:	0800                	add	s0,sp,16
  return memmove(dst, src, n);
 33c:	f67ff0ef          	jal	2a2 <memmove>
}
 340:	60a2                	ld	ra,8(sp)
 342:	6402                	ld	s0,0(sp)
 344:	0141                	add	sp,sp,16
 346:	8082                	ret

0000000000000348 <sbrk>:

char *
sbrk(int n) {
 348:	1141                	add	sp,sp,-16
 34a:	e406                	sd	ra,8(sp)
 34c:	e022                	sd	s0,0(sp)
 34e:	0800                	add	s0,sp,16
  return sys_sbrk(n, SBRK_EAGER);
 350:	4585                	li	a1,1
 352:	152000ef          	jal	4a4 <sys_sbrk>
}
 356:	60a2                	ld	ra,8(sp)
 358:	6402                	ld	s0,0(sp)
 35a:	0141                	add	sp,sp,16
 35c:	8082                	ret

000000000000035e <sbrklazy>:

char *
sbrklazy(int n) {
 35e:	1141                	add	sp,sp,-16
 360:	e406                	sd	ra,8(sp)
 362:	e022                	sd	s0,0(sp)
 364:	0800                	add	s0,sp,16
  return sys_sbrk(n, SBRK_LAZY);
 366:	4589                	li	a1,2
 368:	13c000ef          	jal	4a4 <sys_sbrk>
}
 36c:	60a2                	ld	ra,8(sp)
 36e:	6402                	ld	s0,0(sp)
 370:	0141                	add	sp,sp,16
 372:	8082                	ret

0000000000000374 <htons>:

// Byte order conversion functions
unsigned short
htons(unsigned short hostshort)
{
 374:	1141                	add	sp,sp,-16
 376:	e422                	sd	s0,8(sp)
 378:	0800                	add	s0,sp,16
  return ((hostshort >> 8) & 0xff) | ((hostshort & 0xff) << 8);
 37a:	0085179b          	sllw	a5,a0,0x8
 37e:	0085551b          	srlw	a0,a0,0x8
 382:	8d5d                	or	a0,a0,a5
}
 384:	1542                	sll	a0,a0,0x30
 386:	9141                	srl	a0,a0,0x30
 388:	6422                	ld	s0,8(sp)
 38a:	0141                	add	sp,sp,16
 38c:	8082                	ret

000000000000038e <ntohs>:

unsigned short
ntohs(unsigned short netshort)
{
 38e:	1141                	add	sp,sp,-16
 390:	e422                	sd	s0,8(sp)
 392:	0800                	add	s0,sp,16
  return ((netshort >> 8) & 0xff) | ((netshort & 0xff) << 8);
 394:	0085179b          	sllw	a5,a0,0x8
 398:	0085551b          	srlw	a0,a0,0x8
 39c:	8d5d                	or	a0,a0,a5
}
 39e:	1542                	sll	a0,a0,0x30
 3a0:	9141                	srl	a0,a0,0x30
 3a2:	6422                	ld	s0,8(sp)
 3a4:	0141                	add	sp,sp,16
 3a6:	8082                	ret

00000000000003a8 <htonl>:

unsigned long
htonl(unsigned long hostlong)
{
 3a8:	1141                	add	sp,sp,-16
 3aa:	e422                	sd	s0,8(sp)
 3ac:	0800                	add	s0,sp,16
  return ((hostlong >> 24) & 0xff) |
 3ae:	0185579b          	srlw	a5,a0,0x18
         ((hostlong >> 8) & 0xff00) |
 3b2:	00855713          	srl	a4,a0,0x8
 3b6:	66c1                	lui	a3,0x10
 3b8:	f0068693          	add	a3,a3,-256 # ff00 <base+0xeef0>
 3bc:	8f75                	and	a4,a4,a3
  return ((hostlong >> 24) & 0xff) |
 3be:	8fd9                	or	a5,a5,a4
         ((hostlong & 0xff00) << 8) |
 3c0:	00851713          	sll	a4,a0,0x8
 3c4:	00ff06b7          	lui	a3,0xff0
 3c8:	8f75                	and	a4,a4,a3
         ((hostlong >> 8) & 0xff00) |
 3ca:	8fd9                	or	a5,a5,a4
         ((hostlong & 0xff) << 24);
 3cc:	0562                	sll	a0,a0,0x18
 3ce:	0ff00713          	li	a4,255
 3d2:	0762                	sll	a4,a4,0x18
 3d4:	8d79                	and	a0,a0,a4
}
 3d6:	8d5d                	or	a0,a0,a5
 3d8:	6422                	ld	s0,8(sp)
 3da:	0141                	add	sp,sp,16
 3dc:	8082                	ret

00000000000003de <ntohl>:

unsigned long
ntohl(unsigned long netlong)
{
 3de:	1141                	add	sp,sp,-16
 3e0:	e422                	sd	s0,8(sp)
 3e2:	0800                	add	s0,sp,16
  return ((netlong >> 24) & 0xff) |
 3e4:	0185579b          	srlw	a5,a0,0x18
         ((netlong >> 8) & 0xff00) |
 3e8:	00855713          	srl	a4,a0,0x8
 3ec:	66c1                	lui	a3,0x10
 3ee:	f0068693          	add	a3,a3,-256 # ff00 <base+0xeef0>
 3f2:	8f75                	and	a4,a4,a3
  return ((netlong >> 24) & 0xff) |
 3f4:	8fd9                	or	a5,a5,a4
         ((netlong & 0xff00) << 8) |
 3f6:	00851713          	sll	a4,a0,0x8
 3fa:	00ff06b7          	lui	a3,0xff0
 3fe:	8f75                	and	a4,a4,a3
         ((netlong >> 8) & 0xff00) |
 400:	8fd9                	or	a5,a5,a4
         ((netlong & 0xff) << 24);
 402:	0562                	sll	a0,a0,0x18
 404:	0ff00713          	li	a4,255
 408:	0762                	sll	a4,a4,0x18
 40a:	8d79                	and	a0,a0,a4
}
 40c:	8d5d                	or	a0,a0,a5
 40e:	6422                	ld	s0,8(sp)
 410:	0141                	add	sp,sp,16
 412:	8082                	ret

0000000000000414 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 414:	4885                	li	a7,1
 ecall
 416:	00000073          	ecall
 ret
 41a:	8082                	ret

000000000000041c <exit>:
.global exit
exit:
 li a7, SYS_exit
 41c:	4889                	li	a7,2
 ecall
 41e:	00000073          	ecall
 ret
 422:	8082                	ret

0000000000000424 <wait>:
.global wait
wait:
 li a7, SYS_wait
 424:	488d                	li	a7,3
 ecall
 426:	00000073          	ecall
 ret
 42a:	8082                	ret

000000000000042c <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 42c:	4891                	li	a7,4
 ecall
 42e:	00000073          	ecall
 ret
 432:	8082                	ret

0000000000000434 <read>:
.global read
read:
 li a7, SYS_read
 434:	4895                	li	a7,5
 ecall
 436:	00000073          	ecall
 ret
 43a:	8082                	ret

000000000000043c <write>:
.global write
write:
 li a7, SYS_write
 43c:	48c1                	li	a7,16
 ecall
 43e:	00000073          	ecall
 ret
 442:	8082                	ret

0000000000000444 <close>:
.global close
close:
 li a7, SYS_close
 444:	48d5                	li	a7,21
 ecall
 446:	00000073          	ecall
 ret
 44a:	8082                	ret

000000000000044c <kill>:
.global kill
kill:
 li a7, SYS_kill
 44c:	4899                	li	a7,6
 ecall
 44e:	00000073          	ecall
 ret
 452:	8082                	ret

0000000000000454 <exec>:
.global exec
exec:
 li a7, SYS_exec
 454:	489d                	li	a7,7
 ecall
 456:	00000073          	ecall
 ret
 45a:	8082                	ret

000000000000045c <open>:
.global open
open:
 li a7, SYS_open
 45c:	48bd                	li	a7,15
 ecall
 45e:	00000073          	ecall
 ret
 462:	8082                	ret

0000000000000464 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 464:	48c5                	li	a7,17
 ecall
 466:	00000073          	ecall
 ret
 46a:	8082                	ret

000000000000046c <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 46c:	48c9                	li	a7,18
 ecall
 46e:	00000073          	ecall
 ret
 472:	8082                	ret

0000000000000474 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 474:	48a1                	li	a7,8
 ecall
 476:	00000073          	ecall
 ret
 47a:	8082                	ret

000000000000047c <link>:
.global link
link:
 li a7, SYS_link
 47c:	48cd                	li	a7,19
 ecall
 47e:	00000073          	ecall
 ret
 482:	8082                	ret

0000000000000484 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 484:	48d1                	li	a7,20
 ecall
 486:	00000073          	ecall
 ret
 48a:	8082                	ret

000000000000048c <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 48c:	48a5                	li	a7,9
 ecall
 48e:	00000073          	ecall
 ret
 492:	8082                	ret

0000000000000494 <dup>:
.global dup
dup:
 li a7, SYS_dup
 494:	48a9                	li	a7,10
 ecall
 496:	00000073          	ecall
 ret
 49a:	8082                	ret

000000000000049c <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 49c:	48ad                	li	a7,11
 ecall
 49e:	00000073          	ecall
 ret
 4a2:	8082                	ret

00000000000004a4 <sys_sbrk>:
.global sys_sbrk
sys_sbrk:
 li a7, SYS_sbrk
 4a4:	48b1                	li	a7,12
 ecall
 4a6:	00000073          	ecall
 ret
 4aa:	8082                	ret

00000000000004ac <pause>:
.global pause
pause:
 li a7, SYS_pause
 4ac:	48b5                	li	a7,13
 ecall
 4ae:	00000073          	ecall
 ret
 4b2:	8082                	ret

00000000000004b4 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 4b4:	48b9                	li	a7,14
 ecall
 4b6:	00000073          	ecall
 ret
 4ba:	8082                	ret

00000000000004bc <socket>:
.global socket
socket:
 li a7, SYS_socket
 4bc:	48d9                	li	a7,22
 ecall
 4be:	00000073          	ecall
 ret
 4c2:	8082                	ret

00000000000004c4 <bind>:
.global bind
bind:
 li a7, SYS_bind
 4c4:	48dd                	li	a7,23
 ecall
 4c6:	00000073          	ecall
 ret
 4ca:	8082                	ret

00000000000004cc <listen>:
.global listen
listen:
 li a7, SYS_listen
 4cc:	48e1                	li	a7,24
 ecall
 4ce:	00000073          	ecall
 ret
 4d2:	8082                	ret

00000000000004d4 <accept>:
.global accept
accept:
 li a7, SYS_accept
 4d4:	48e5                	li	a7,25
 ecall
 4d6:	00000073          	ecall
 ret
 4da:	8082                	ret

00000000000004dc <connect>:
.global connect
connect:
 li a7, SYS_connect
 4dc:	48e9                	li	a7,26
 ecall
 4de:	00000073          	ecall
 ret
 4e2:	8082                	ret

00000000000004e4 <send>:
.global send
send:
 li a7, SYS_send
 4e4:	48ed                	li	a7,27
 ecall
 4e6:	00000073          	ecall
 ret
 4ea:	8082                	ret

00000000000004ec <recv>:
.global recv
recv:
 li a7, SYS_recv
 4ec:	48f1                	li	a7,28
 ecall
 4ee:	00000073          	ecall
 ret
 4f2:	8082                	ret

00000000000004f4 <sendto>:
.global sendto
sendto:
 li a7, SYS_sendto
 4f4:	48f5                	li	a7,29
 ecall
 4f6:	00000073          	ecall
 ret
 4fa:	8082                	ret

00000000000004fc <recvfrom>:
.global recvfrom
recvfrom:
 li a7, SYS_recvfrom
 4fc:	48f9                	li	a7,30
 ecall
 4fe:	00000073          	ecall
 ret
 502:	8082                	ret

0000000000000504 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 504:	1101                	add	sp,sp,-32
 506:	ec06                	sd	ra,24(sp)
 508:	e822                	sd	s0,16(sp)
 50a:	1000                	add	s0,sp,32
 50c:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 510:	4605                	li	a2,1
 512:	fef40593          	add	a1,s0,-17
 516:	f27ff0ef          	jal	43c <write>
}
 51a:	60e2                	ld	ra,24(sp)
 51c:	6442                	ld	s0,16(sp)
 51e:	6105                	add	sp,sp,32
 520:	8082                	ret

0000000000000522 <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
 522:	715d                	add	sp,sp,-80
 524:	e486                	sd	ra,72(sp)
 526:	e0a2                	sd	s0,64(sp)
 528:	f84a                	sd	s2,48(sp)
 52a:	0880                	add	s0,sp,80
 52c:	892a                	mv	s2,a0
  char buf[20];
  int i, neg;
  unsigned long long x;

  neg = 0;
  if(sgn && xx < 0){
 52e:	c299                	beqz	a3,534 <printint+0x12>
 530:	0805c363          	bltz	a1,5b6 <printint+0x94>
  neg = 0;
 534:	4881                	li	a7,0
 536:	fb840693          	add	a3,s0,-72
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
 53a:	4781                	li	a5,0
  do{
    buf[i++] = digits[x % base];
 53c:	00000517          	auipc	a0,0x0
 540:	53c50513          	add	a0,a0,1340 # a78 <digits>
 544:	883e                	mv	a6,a5
 546:	2785                	addw	a5,a5,1
 548:	02c5f733          	remu	a4,a1,a2
 54c:	972a                	add	a4,a4,a0
 54e:	00074703          	lbu	a4,0(a4)
 552:	00e68023          	sb	a4,0(a3) # ff0000 <base+0xfeeff0>
  }while((x /= base) != 0);
 556:	872e                	mv	a4,a1
 558:	02c5d5b3          	divu	a1,a1,a2
 55c:	0685                	add	a3,a3,1
 55e:	fec773e3          	bgeu	a4,a2,544 <printint+0x22>
  if(neg)
 562:	00088b63          	beqz	a7,578 <printint+0x56>
    buf[i++] = '-';
 566:	fd078793          	add	a5,a5,-48
 56a:	97a2                	add	a5,a5,s0
 56c:	02d00713          	li	a4,45
 570:	fee78423          	sb	a4,-24(a5)
 574:	0028079b          	addw	a5,a6,2

  while(--i >= 0)
 578:	02f05a63          	blez	a5,5ac <printint+0x8a>
 57c:	fc26                	sd	s1,56(sp)
 57e:	f44e                	sd	s3,40(sp)
 580:	fb840713          	add	a4,s0,-72
 584:	00f704b3          	add	s1,a4,a5
 588:	fff70993          	add	s3,a4,-1
 58c:	99be                	add	s3,s3,a5
 58e:	37fd                	addw	a5,a5,-1
 590:	1782                	sll	a5,a5,0x20
 592:	9381                	srl	a5,a5,0x20
 594:	40f989b3          	sub	s3,s3,a5
    putc(fd, buf[i]);
 598:	fff4c583          	lbu	a1,-1(s1)
 59c:	854a                	mv	a0,s2
 59e:	f67ff0ef          	jal	504 <putc>
  while(--i >= 0)
 5a2:	14fd                	add	s1,s1,-1
 5a4:	ff349ae3          	bne	s1,s3,598 <printint+0x76>
 5a8:	74e2                	ld	s1,56(sp)
 5aa:	79a2                	ld	s3,40(sp)
}
 5ac:	60a6                	ld	ra,72(sp)
 5ae:	6406                	ld	s0,64(sp)
 5b0:	7942                	ld	s2,48(sp)
 5b2:	6161                	add	sp,sp,80
 5b4:	8082                	ret
    x = -xx;
 5b6:	40b005b3          	neg	a1,a1
    neg = 1;
 5ba:	4885                	li	a7,1
    x = -xx;
 5bc:	bfad                	j	536 <printint+0x14>

00000000000005be <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %c, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 5be:	711d                	add	sp,sp,-96
 5c0:	ec86                	sd	ra,88(sp)
 5c2:	e8a2                	sd	s0,80(sp)
 5c4:	e0ca                	sd	s2,64(sp)
 5c6:	1080                	add	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 5c8:	0005c903          	lbu	s2,0(a1)
 5cc:	28090663          	beqz	s2,858 <vprintf+0x29a>
 5d0:	e4a6                	sd	s1,72(sp)
 5d2:	fc4e                	sd	s3,56(sp)
 5d4:	f852                	sd	s4,48(sp)
 5d6:	f456                	sd	s5,40(sp)
 5d8:	f05a                	sd	s6,32(sp)
 5da:	ec5e                	sd	s7,24(sp)
 5dc:	e862                	sd	s8,16(sp)
 5de:	e466                	sd	s9,8(sp)
 5e0:	8b2a                	mv	s6,a0
 5e2:	8a2e                	mv	s4,a1
 5e4:	8bb2                	mv	s7,a2
  state = 0;
 5e6:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
 5e8:	4481                	li	s1,0
 5ea:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
 5ec:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
 5f0:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
 5f4:	06c00c93          	li	s9,108
 5f8:	a005                	j	618 <vprintf+0x5a>
        putc(fd, c0);
 5fa:	85ca                	mv	a1,s2
 5fc:	855a                	mv	a0,s6
 5fe:	f07ff0ef          	jal	504 <putc>
 602:	a019                	j	608 <vprintf+0x4a>
    } else if(state == '%'){
 604:	03598263          	beq	s3,s5,628 <vprintf+0x6a>
  for(i = 0; fmt[i]; i++){
 608:	2485                	addw	s1,s1,1
 60a:	8726                	mv	a4,s1
 60c:	009a07b3          	add	a5,s4,s1
 610:	0007c903          	lbu	s2,0(a5)
 614:	22090a63          	beqz	s2,848 <vprintf+0x28a>
    c0 = fmt[i] & 0xff;
 618:	0009079b          	sext.w	a5,s2
    if(state == 0){
 61c:	fe0994e3          	bnez	s3,604 <vprintf+0x46>
      if(c0 == '%'){
 620:	fd579de3          	bne	a5,s5,5fa <vprintf+0x3c>
        state = '%';
 624:	89be                	mv	s3,a5
 626:	b7cd                	j	608 <vprintf+0x4a>
      if(c0) c1 = fmt[i+1] & 0xff;
 628:	00ea06b3          	add	a3,s4,a4
 62c:	0016c683          	lbu	a3,1(a3)
      c1 = c2 = 0;
 630:	8636                	mv	a2,a3
      if(c1) c2 = fmt[i+2] & 0xff;
 632:	c681                	beqz	a3,63a <vprintf+0x7c>
 634:	9752                	add	a4,a4,s4
 636:	00274603          	lbu	a2,2(a4)
      if(c0 == 'd'){
 63a:	05878363          	beq	a5,s8,680 <vprintf+0xc2>
      } else if(c0 == 'l' && c1 == 'd'){
 63e:	05978d63          	beq	a5,s9,698 <vprintf+0xda>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
 642:	07500713          	li	a4,117
 646:	0ee78763          	beq	a5,a4,734 <vprintf+0x176>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
 64a:	07800713          	li	a4,120
 64e:	12e78963          	beq	a5,a4,780 <vprintf+0x1c2>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
 652:	07000713          	li	a4,112
 656:	14e78e63          	beq	a5,a4,7b2 <vprintf+0x1f4>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 'c'){
 65a:	06300713          	li	a4,99
 65e:	18e78e63          	beq	a5,a4,7fa <vprintf+0x23c>
        putc(fd, va_arg(ap, uint32));
      } else if(c0 == 's'){
 662:	07300713          	li	a4,115
 666:	1ae78463          	beq	a5,a4,80e <vprintf+0x250>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
 66a:	02500713          	li	a4,37
 66e:	04e79563          	bne	a5,a4,6b8 <vprintf+0xfa>
        putc(fd, '%');
 672:	02500593          	li	a1,37
 676:	855a                	mv	a0,s6
 678:	e8dff0ef          	jal	504 <putc>
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c0);
      }

      state = 0;
 67c:	4981                	li	s3,0
 67e:	b769                	j	608 <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 1);
 680:	008b8913          	add	s2,s7,8
 684:	4685                	li	a3,1
 686:	4629                	li	a2,10
 688:	000ba583          	lw	a1,0(s7)
 68c:	855a                	mv	a0,s6
 68e:	e95ff0ef          	jal	522 <printint>
 692:	8bca                	mv	s7,s2
      state = 0;
 694:	4981                	li	s3,0
 696:	bf8d                	j	608 <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'd'){
 698:	06400793          	li	a5,100
 69c:	02f68963          	beq	a3,a5,6ce <vprintf+0x110>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 6a0:	06c00793          	li	a5,108
 6a4:	04f68263          	beq	a3,a5,6e8 <vprintf+0x12a>
      } else if(c0 == 'l' && c1 == 'u'){
 6a8:	07500793          	li	a5,117
 6ac:	0af68063          	beq	a3,a5,74c <vprintf+0x18e>
      } else if(c0 == 'l' && c1 == 'x'){
 6b0:	07800793          	li	a5,120
 6b4:	0ef68263          	beq	a3,a5,798 <vprintf+0x1da>
        putc(fd, '%');
 6b8:	02500593          	li	a1,37
 6bc:	855a                	mv	a0,s6
 6be:	e47ff0ef          	jal	504 <putc>
        putc(fd, c0);
 6c2:	85ca                	mv	a1,s2
 6c4:	855a                	mv	a0,s6
 6c6:	e3fff0ef          	jal	504 <putc>
      state = 0;
 6ca:	4981                	li	s3,0
 6cc:	bf35                	j	608 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 6ce:	008b8913          	add	s2,s7,8
 6d2:	4685                	li	a3,1
 6d4:	4629                	li	a2,10
 6d6:	000bb583          	ld	a1,0(s7)
 6da:	855a                	mv	a0,s6
 6dc:	e47ff0ef          	jal	522 <printint>
        i += 1;
 6e0:	2485                	addw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 6e2:	8bca                	mv	s7,s2
      state = 0;
 6e4:	4981                	li	s3,0
        i += 1;
 6e6:	b70d                	j	608 <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 6e8:	06400793          	li	a5,100
 6ec:	02f60763          	beq	a2,a5,71a <vprintf+0x15c>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 6f0:	07500793          	li	a5,117
 6f4:	06f60963          	beq	a2,a5,766 <vprintf+0x1a8>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 6f8:	07800793          	li	a5,120
 6fc:	faf61ee3          	bne	a2,a5,6b8 <vprintf+0xfa>
        printint(fd, va_arg(ap, uint64), 16, 0);
 700:	008b8913          	add	s2,s7,8
 704:	4681                	li	a3,0
 706:	4641                	li	a2,16
 708:	000bb583          	ld	a1,0(s7)
 70c:	855a                	mv	a0,s6
 70e:	e15ff0ef          	jal	522 <printint>
        i += 2;
 712:	2489                	addw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 714:	8bca                	mv	s7,s2
      state = 0;
 716:	4981                	li	s3,0
        i += 2;
 718:	bdc5                	j	608 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 71a:	008b8913          	add	s2,s7,8
 71e:	4685                	li	a3,1
 720:	4629                	li	a2,10
 722:	000bb583          	ld	a1,0(s7)
 726:	855a                	mv	a0,s6
 728:	dfbff0ef          	jal	522 <printint>
        i += 2;
 72c:	2489                	addw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 72e:	8bca                	mv	s7,s2
      state = 0;
 730:	4981                	li	s3,0
        i += 2;
 732:	bdd9                	j	608 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint32), 10, 0);
 734:	008b8913          	add	s2,s7,8
 738:	4681                	li	a3,0
 73a:	4629                	li	a2,10
 73c:	000be583          	lwu	a1,0(s7)
 740:	855a                	mv	a0,s6
 742:	de1ff0ef          	jal	522 <printint>
 746:	8bca                	mv	s7,s2
      state = 0;
 748:	4981                	li	s3,0
 74a:	bd7d                	j	608 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 74c:	008b8913          	add	s2,s7,8
 750:	4681                	li	a3,0
 752:	4629                	li	a2,10
 754:	000bb583          	ld	a1,0(s7)
 758:	855a                	mv	a0,s6
 75a:	dc9ff0ef          	jal	522 <printint>
        i += 1;
 75e:	2485                	addw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 760:	8bca                	mv	s7,s2
      state = 0;
 762:	4981                	li	s3,0
        i += 1;
 764:	b555                	j	608 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 766:	008b8913          	add	s2,s7,8
 76a:	4681                	li	a3,0
 76c:	4629                	li	a2,10
 76e:	000bb583          	ld	a1,0(s7)
 772:	855a                	mv	a0,s6
 774:	dafff0ef          	jal	522 <printint>
        i += 2;
 778:	2489                	addw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 77a:	8bca                	mv	s7,s2
      state = 0;
 77c:	4981                	li	s3,0
        i += 2;
 77e:	b569                	j	608 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint32), 16, 0);
 780:	008b8913          	add	s2,s7,8
 784:	4681                	li	a3,0
 786:	4641                	li	a2,16
 788:	000be583          	lwu	a1,0(s7)
 78c:	855a                	mv	a0,s6
 78e:	d95ff0ef          	jal	522 <printint>
 792:	8bca                	mv	s7,s2
      state = 0;
 794:	4981                	li	s3,0
 796:	bd8d                	j	608 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 16, 0);
 798:	008b8913          	add	s2,s7,8
 79c:	4681                	li	a3,0
 79e:	4641                	li	a2,16
 7a0:	000bb583          	ld	a1,0(s7)
 7a4:	855a                	mv	a0,s6
 7a6:	d7dff0ef          	jal	522 <printint>
        i += 1;
 7aa:	2485                	addw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 7ac:	8bca                	mv	s7,s2
      state = 0;
 7ae:	4981                	li	s3,0
        i += 1;
 7b0:	bda1                	j	608 <vprintf+0x4a>
 7b2:	e06a                	sd	s10,0(sp)
        printptr(fd, va_arg(ap, uint64));
 7b4:	008b8d13          	add	s10,s7,8
 7b8:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 7bc:	03000593          	li	a1,48
 7c0:	855a                	mv	a0,s6
 7c2:	d43ff0ef          	jal	504 <putc>
  putc(fd, 'x');
 7c6:	07800593          	li	a1,120
 7ca:	855a                	mv	a0,s6
 7cc:	d39ff0ef          	jal	504 <putc>
 7d0:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 7d2:	00000b97          	auipc	s7,0x0
 7d6:	2a6b8b93          	add	s7,s7,678 # a78 <digits>
 7da:	03c9d793          	srl	a5,s3,0x3c
 7de:	97de                	add	a5,a5,s7
 7e0:	0007c583          	lbu	a1,0(a5)
 7e4:	855a                	mv	a0,s6
 7e6:	d1fff0ef          	jal	504 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 7ea:	0992                	sll	s3,s3,0x4
 7ec:	397d                	addw	s2,s2,-1
 7ee:	fe0916e3          	bnez	s2,7da <vprintf+0x21c>
        printptr(fd, va_arg(ap, uint64));
 7f2:	8bea                	mv	s7,s10
      state = 0;
 7f4:	4981                	li	s3,0
 7f6:	6d02                	ld	s10,0(sp)
 7f8:	bd01                	j	608 <vprintf+0x4a>
        putc(fd, va_arg(ap, uint32));
 7fa:	008b8913          	add	s2,s7,8
 7fe:	000bc583          	lbu	a1,0(s7)
 802:	855a                	mv	a0,s6
 804:	d01ff0ef          	jal	504 <putc>
 808:	8bca                	mv	s7,s2
      state = 0;
 80a:	4981                	li	s3,0
 80c:	bbf5                	j	608 <vprintf+0x4a>
        if((s = va_arg(ap, char*)) == 0)
 80e:	008b8993          	add	s3,s7,8
 812:	000bb903          	ld	s2,0(s7)
 816:	00090f63          	beqz	s2,834 <vprintf+0x276>
        for(; *s; s++)
 81a:	00094583          	lbu	a1,0(s2)
 81e:	c195                	beqz	a1,842 <vprintf+0x284>
          putc(fd, *s);
 820:	855a                	mv	a0,s6
 822:	ce3ff0ef          	jal	504 <putc>
        for(; *s; s++)
 826:	0905                	add	s2,s2,1
 828:	00094583          	lbu	a1,0(s2)
 82c:	f9f5                	bnez	a1,820 <vprintf+0x262>
        if((s = va_arg(ap, char*)) == 0)
 82e:	8bce                	mv	s7,s3
      state = 0;
 830:	4981                	li	s3,0
 832:	bbd9                	j	608 <vprintf+0x4a>
          s = "(null)";
 834:	00000917          	auipc	s2,0x0
 838:	23c90913          	add	s2,s2,572 # a70 <malloc+0x130>
        for(; *s; s++)
 83c:	02800593          	li	a1,40
 840:	b7c5                	j	820 <vprintf+0x262>
        if((s = va_arg(ap, char*)) == 0)
 842:	8bce                	mv	s7,s3
      state = 0;
 844:	4981                	li	s3,0
 846:	b3c9                	j	608 <vprintf+0x4a>
 848:	64a6                	ld	s1,72(sp)
 84a:	79e2                	ld	s3,56(sp)
 84c:	7a42                	ld	s4,48(sp)
 84e:	7aa2                	ld	s5,40(sp)
 850:	7b02                	ld	s6,32(sp)
 852:	6be2                	ld	s7,24(sp)
 854:	6c42                	ld	s8,16(sp)
 856:	6ca2                	ld	s9,8(sp)
    }
  }
}
 858:	60e6                	ld	ra,88(sp)
 85a:	6446                	ld	s0,80(sp)
 85c:	6906                	ld	s2,64(sp)
 85e:	6125                	add	sp,sp,96
 860:	8082                	ret

0000000000000862 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 862:	715d                	add	sp,sp,-80
 864:	ec06                	sd	ra,24(sp)
 866:	e822                	sd	s0,16(sp)
 868:	1000                	add	s0,sp,32
 86a:	e010                	sd	a2,0(s0)
 86c:	e414                	sd	a3,8(s0)
 86e:	e818                	sd	a4,16(s0)
 870:	ec1c                	sd	a5,24(s0)
 872:	03043023          	sd	a6,32(s0)
 876:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 87a:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 87e:	8622                	mv	a2,s0
 880:	d3fff0ef          	jal	5be <vprintf>
}
 884:	60e2                	ld	ra,24(sp)
 886:	6442                	ld	s0,16(sp)
 888:	6161                	add	sp,sp,80
 88a:	8082                	ret

000000000000088c <printf>:

void
printf(const char *fmt, ...)
{
 88c:	711d                	add	sp,sp,-96
 88e:	ec06                	sd	ra,24(sp)
 890:	e822                	sd	s0,16(sp)
 892:	1000                	add	s0,sp,32
 894:	e40c                	sd	a1,8(s0)
 896:	e810                	sd	a2,16(s0)
 898:	ec14                	sd	a3,24(s0)
 89a:	f018                	sd	a4,32(s0)
 89c:	f41c                	sd	a5,40(s0)
 89e:	03043823          	sd	a6,48(s0)
 8a2:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 8a6:	00840613          	add	a2,s0,8
 8aa:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 8ae:	85aa                	mv	a1,a0
 8b0:	4505                	li	a0,1
 8b2:	d0dff0ef          	jal	5be <vprintf>
}
 8b6:	60e2                	ld	ra,24(sp)
 8b8:	6442                	ld	s0,16(sp)
 8ba:	6125                	add	sp,sp,96
 8bc:	8082                	ret

00000000000008be <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 8be:	1141                	add	sp,sp,-16
 8c0:	e422                	sd	s0,8(sp)
 8c2:	0800                	add	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 8c4:	ff050693          	add	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8c8:	00000797          	auipc	a5,0x0
 8cc:	7387b783          	ld	a5,1848(a5) # 1000 <freep>
 8d0:	a02d                	j	8fa <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 8d2:	4618                	lw	a4,8(a2)
 8d4:	9f2d                	addw	a4,a4,a1
 8d6:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 8da:	6398                	ld	a4,0(a5)
 8dc:	6310                	ld	a2,0(a4)
 8de:	a83d                	j	91c <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 8e0:	ff852703          	lw	a4,-8(a0)
 8e4:	9f31                	addw	a4,a4,a2
 8e6:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 8e8:	ff053683          	ld	a3,-16(a0)
 8ec:	a091                	j	930 <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8ee:	6398                	ld	a4,0(a5)
 8f0:	00e7e463          	bltu	a5,a4,8f8 <free+0x3a>
 8f4:	00e6ea63          	bltu	a3,a4,908 <free+0x4a>
{
 8f8:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8fa:	fed7fae3          	bgeu	a5,a3,8ee <free+0x30>
 8fe:	6398                	ld	a4,0(a5)
 900:	00e6e463          	bltu	a3,a4,908 <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 904:	fee7eae3          	bltu	a5,a4,8f8 <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 908:	ff852583          	lw	a1,-8(a0)
 90c:	6390                	ld	a2,0(a5)
 90e:	02059813          	sll	a6,a1,0x20
 912:	01c85713          	srl	a4,a6,0x1c
 916:	9736                	add	a4,a4,a3
 918:	fae60de3          	beq	a2,a4,8d2 <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 91c:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 920:	4790                	lw	a2,8(a5)
 922:	02061593          	sll	a1,a2,0x20
 926:	01c5d713          	srl	a4,a1,0x1c
 92a:	973e                	add	a4,a4,a5
 92c:	fae68ae3          	beq	a3,a4,8e0 <free+0x22>
    p->s.ptr = bp->s.ptr;
 930:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 932:	00000717          	auipc	a4,0x0
 936:	6cf73723          	sd	a5,1742(a4) # 1000 <freep>
}
 93a:	6422                	ld	s0,8(sp)
 93c:	0141                	add	sp,sp,16
 93e:	8082                	ret

0000000000000940 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 940:	7139                	add	sp,sp,-64
 942:	fc06                	sd	ra,56(sp)
 944:	f822                	sd	s0,48(sp)
 946:	f426                	sd	s1,40(sp)
 948:	ec4e                	sd	s3,24(sp)
 94a:	0080                	add	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 94c:	02051493          	sll	s1,a0,0x20
 950:	9081                	srl	s1,s1,0x20
 952:	04bd                	add	s1,s1,15
 954:	8091                	srl	s1,s1,0x4
 956:	0014899b          	addw	s3,s1,1
 95a:	0485                	add	s1,s1,1
  if((prevp = freep) == 0){
 95c:	00000517          	auipc	a0,0x0
 960:	6a453503          	ld	a0,1700(a0) # 1000 <freep>
 964:	c915                	beqz	a0,998 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 966:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 968:	4798                	lw	a4,8(a5)
 96a:	08977a63          	bgeu	a4,s1,9fe <malloc+0xbe>
 96e:	f04a                	sd	s2,32(sp)
 970:	e852                	sd	s4,16(sp)
 972:	e456                	sd	s5,8(sp)
 974:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 976:	8a4e                	mv	s4,s3
 978:	0009871b          	sext.w	a4,s3
 97c:	6685                	lui	a3,0x1
 97e:	00d77363          	bgeu	a4,a3,984 <malloc+0x44>
 982:	6a05                	lui	s4,0x1
 984:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 988:	004a1a1b          	sllw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 98c:	00000917          	auipc	s2,0x0
 990:	67490913          	add	s2,s2,1652 # 1000 <freep>
  if(p == SBRK_ERROR)
 994:	5afd                	li	s5,-1
 996:	a081                	j	9d6 <malloc+0x96>
 998:	f04a                	sd	s2,32(sp)
 99a:	e852                	sd	s4,16(sp)
 99c:	e456                	sd	s5,8(sp)
 99e:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 9a0:	00000797          	auipc	a5,0x0
 9a4:	67078793          	add	a5,a5,1648 # 1010 <base>
 9a8:	00000717          	auipc	a4,0x0
 9ac:	64f73c23          	sd	a5,1624(a4) # 1000 <freep>
 9b0:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 9b2:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 9b6:	b7c1                	j	976 <malloc+0x36>
        prevp->s.ptr = p->s.ptr;
 9b8:	6398                	ld	a4,0(a5)
 9ba:	e118                	sd	a4,0(a0)
 9bc:	a8a9                	j	a16 <malloc+0xd6>
  hp->s.size = nu;
 9be:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 9c2:	0541                	add	a0,a0,16
 9c4:	efbff0ef          	jal	8be <free>
  return freep;
 9c8:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 9cc:	c12d                	beqz	a0,a2e <malloc+0xee>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 9ce:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 9d0:	4798                	lw	a4,8(a5)
 9d2:	02977263          	bgeu	a4,s1,9f6 <malloc+0xb6>
    if(p == freep)
 9d6:	00093703          	ld	a4,0(s2)
 9da:	853e                	mv	a0,a5
 9dc:	fef719e3          	bne	a4,a5,9ce <malloc+0x8e>
  p = sbrk(nu * sizeof(Header));
 9e0:	8552                	mv	a0,s4
 9e2:	967ff0ef          	jal	348 <sbrk>
  if(p == SBRK_ERROR)
 9e6:	fd551ce3          	bne	a0,s5,9be <malloc+0x7e>
        return 0;
 9ea:	4501                	li	a0,0
 9ec:	7902                	ld	s2,32(sp)
 9ee:	6a42                	ld	s4,16(sp)
 9f0:	6aa2                	ld	s5,8(sp)
 9f2:	6b02                	ld	s6,0(sp)
 9f4:	a03d                	j	a22 <malloc+0xe2>
 9f6:	7902                	ld	s2,32(sp)
 9f8:	6a42                	ld	s4,16(sp)
 9fa:	6aa2                	ld	s5,8(sp)
 9fc:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 9fe:	fae48de3          	beq	s1,a4,9b8 <malloc+0x78>
        p->s.size -= nunits;
 a02:	4137073b          	subw	a4,a4,s3
 a06:	c798                	sw	a4,8(a5)
        p += p->s.size;
 a08:	02071693          	sll	a3,a4,0x20
 a0c:	01c6d713          	srl	a4,a3,0x1c
 a10:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 a12:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 a16:	00000717          	auipc	a4,0x0
 a1a:	5ea73523          	sd	a0,1514(a4) # 1000 <freep>
      return (void*)(p + 1);
 a1e:	01078513          	add	a0,a5,16
  }
}
 a22:	70e2                	ld	ra,56(sp)
 a24:	7442                	ld	s0,48(sp)
 a26:	74a2                	ld	s1,40(sp)
 a28:	69e2                	ld	s3,24(sp)
 a2a:	6121                	add	sp,sp,64
 a2c:	8082                	ret
 a2e:	7902                	ld	s2,32(sp)
 a30:	6a42                	ld	s4,16(sp)
 a32:	6aa2                	ld	s5,8(sp)
 a34:	6b02                	ld	s6,0(sp)
 a36:	b7f5                	j	a22 <malloc+0xe2>
