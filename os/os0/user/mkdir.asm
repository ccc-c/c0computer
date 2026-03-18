
user/_mkdir:     file format elf64-littleriscv


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
  int i;

  if(argc < 2){
   8:	4785                	li	a5,1
   a:	02a7d763          	bge	a5,a0,38 <main+0x38>
   e:	e426                	sd	s1,8(sp)
  10:	e04a                	sd	s2,0(sp)
  12:	00858493          	add	s1,a1,8
  16:	ffe5091b          	addw	s2,a0,-2
  1a:	02091793          	sll	a5,s2,0x20
  1e:	01d7d913          	srl	s2,a5,0x1d
  22:	05c1                	add	a1,a1,16
  24:	992e                	add	s2,s2,a1
    fprintf(2, "Usage: mkdir files...\n");
    exit(1);
  }

  for(i = 1; i < argc; i++){
    if(mkdir(argv[i]) < 0){
  26:	6088                	ld	a0,0(s1)
  28:	474000ef          	jal	49c <mkdir>
  2c:	02054263          	bltz	a0,50 <main+0x50>
  for(i = 1; i < argc; i++){
  30:	04a1                	add	s1,s1,8
  32:	ff249ae3          	bne	s1,s2,26 <main+0x26>
  36:	a02d                	j	60 <main+0x60>
  38:	e426                	sd	s1,8(sp)
  3a:	e04a                	sd	s2,0(sp)
    fprintf(2, "Usage: mkdir files...\n");
  3c:	00001597          	auipc	a1,0x1
  40:	a1458593          	add	a1,a1,-1516 # a50 <malloc+0xf8>
  44:	4509                	li	a0,2
  46:	035000ef          	jal	87a <fprintf>
    exit(1);
  4a:	4505                	li	a0,1
  4c:	3e8000ef          	jal	434 <exit>
      fprintf(2, "mkdir: %s failed to create\n", argv[i]);
  50:	6090                	ld	a2,0(s1)
  52:	00001597          	auipc	a1,0x1
  56:	a1658593          	add	a1,a1,-1514 # a68 <malloc+0x110>
  5a:	4509                	li	a0,2
  5c:	01f000ef          	jal	87a <fprintf>
      break;
    }
  }

  exit(0);
  60:	4501                	li	a0,0
  62:	3d2000ef          	jal	434 <exit>

0000000000000066 <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start(int argc, char **argv)
{
  66:	1141                	add	sp,sp,-16
  68:	e406                	sd	ra,8(sp)
  6a:	e022                	sd	s0,0(sp)
  6c:	0800                	add	s0,sp,16
  int r;
  extern int main(int argc, char **argv);
  r = main(argc, argv);
  6e:	f93ff0ef          	jal	0 <main>
  exit(r);
  72:	3c2000ef          	jal	434 <exit>

0000000000000076 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
  76:	1141                	add	sp,sp,-16
  78:	e422                	sd	s0,8(sp)
  7a:	0800                	add	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  7c:	87aa                	mv	a5,a0
  7e:	0585                	add	a1,a1,1
  80:	0785                	add	a5,a5,1
  82:	fff5c703          	lbu	a4,-1(a1)
  86:	fee78fa3          	sb	a4,-1(a5)
  8a:	fb75                	bnez	a4,7e <strcpy+0x8>
    ;
  return os;
}
  8c:	6422                	ld	s0,8(sp)
  8e:	0141                	add	sp,sp,16
  90:	8082                	ret

0000000000000092 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  92:	1141                	add	sp,sp,-16
  94:	e422                	sd	s0,8(sp)
  96:	0800                	add	s0,sp,16
  while(*p && *p == *q)
  98:	00054783          	lbu	a5,0(a0)
  9c:	cb91                	beqz	a5,b0 <strcmp+0x1e>
  9e:	0005c703          	lbu	a4,0(a1)
  a2:	00f71763          	bne	a4,a5,b0 <strcmp+0x1e>
    p++, q++;
  a6:	0505                	add	a0,a0,1
  a8:	0585                	add	a1,a1,1
  while(*p && *p == *q)
  aa:	00054783          	lbu	a5,0(a0)
  ae:	fbe5                	bnez	a5,9e <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
  b0:	0005c503          	lbu	a0,0(a1)
}
  b4:	40a7853b          	subw	a0,a5,a0
  b8:	6422                	ld	s0,8(sp)
  ba:	0141                	add	sp,sp,16
  bc:	8082                	ret

00000000000000be <strncmp>:

int
strncmp(const char *p, const char *q, uint n)
{
  be:	1141                	add	sp,sp,-16
  c0:	e422                	sd	s0,8(sp)
  c2:	0800                	add	s0,sp,16
  while(n > 0 && *p && *p == *q) {
  c4:	ce11                	beqz	a2,e0 <strncmp+0x22>
  c6:	00054783          	lbu	a5,0(a0)
  ca:	cf89                	beqz	a5,e4 <strncmp+0x26>
  cc:	0005c703          	lbu	a4,0(a1)
  d0:	00f71a63          	bne	a4,a5,e4 <strncmp+0x26>
    p++, q++, n--;
  d4:	0505                	add	a0,a0,1
  d6:	0585                	add	a1,a1,1
  d8:	367d                	addw	a2,a2,-1
  while(n > 0 && *p && *p == *q) {
  da:	f675                	bnez	a2,c6 <strncmp+0x8>
  }
  if (n == 0)
    return 0;
  dc:	4501                	li	a0,0
  de:	a801                	j	ee <strncmp+0x30>
  e0:	4501                	li	a0,0
  e2:	a031                	j	ee <strncmp+0x30>
  return (uchar)*p - (uchar)*q;
  e4:	00054503          	lbu	a0,0(a0)
  e8:	0005c783          	lbu	a5,0(a1)
  ec:	9d1d                	subw	a0,a0,a5
}
  ee:	6422                	ld	s0,8(sp)
  f0:	0141                	add	sp,sp,16
  f2:	8082                	ret

00000000000000f4 <strcat>:

char*
strcat(char *dst, const char *src)
{
  f4:	1141                	add	sp,sp,-16
  f6:	e422                	sd	s0,8(sp)
  f8:	0800                	add	s0,sp,16
  char *p = dst;
  while(*p) p++;
  fa:	00054783          	lbu	a5,0(a0)
  fe:	c385                	beqz	a5,11e <strcat+0x2a>
  char *p = dst;
 100:	87aa                	mv	a5,a0
  while(*p) p++;
 102:	0785                	add	a5,a5,1
 104:	0007c703          	lbu	a4,0(a5)
 108:	ff6d                	bnez	a4,102 <strcat+0xe>
  while((*p++ = *src++) != 0);
 10a:	0585                	add	a1,a1,1
 10c:	0785                	add	a5,a5,1
 10e:	fff5c703          	lbu	a4,-1(a1)
 112:	fee78fa3          	sb	a4,-1(a5)
 116:	fb75                	bnez	a4,10a <strcat+0x16>
  return dst;
}
 118:	6422                	ld	s0,8(sp)
 11a:	0141                	add	sp,sp,16
 11c:	8082                	ret
  char *p = dst;
 11e:	87aa                	mv	a5,a0
 120:	b7ed                	j	10a <strcat+0x16>

0000000000000122 <strncpy>:

char*
strncpy(char *dst, const char *src, int n)
{
 122:	1141                	add	sp,sp,-16
 124:	e422                	sd	s0,8(sp)
 126:	0800                	add	s0,sp,16
  char *p = dst;
 128:	87aa                	mv	a5,a0
  while(n > 0 && *src) {
 12a:	02c05463          	blez	a2,152 <strncpy+0x30>
 12e:	0005c703          	lbu	a4,0(a1)
 132:	cb01                	beqz	a4,142 <strncpy+0x20>
    *p++ = *src++;
 134:	0585                	add	a1,a1,1
 136:	0785                	add	a5,a5,1
 138:	fee78fa3          	sb	a4,-1(a5)
    n--;
 13c:	367d                	addw	a2,a2,-1
  while(n > 0 && *src) {
 13e:	fa65                	bnez	a2,12e <strncpy+0xc>
 140:	a809                	j	152 <strncpy+0x30>
  }
  while(n > 0) {
 142:	1602                	sll	a2,a2,0x20
 144:	9201                	srl	a2,a2,0x20
 146:	963e                	add	a2,a2,a5
    *p++ = 0;
 148:	0785                	add	a5,a5,1
 14a:	fe078fa3          	sb	zero,-1(a5)
  while(n > 0) {
 14e:	fec79de3          	bne	a5,a2,148 <strncpy+0x26>
    n--;
  }
  return dst;
}
 152:	6422                	ld	s0,8(sp)
 154:	0141                	add	sp,sp,16
 156:	8082                	ret

0000000000000158 <strlen>:

uint
strlen(const char *s)
{
 158:	1141                	add	sp,sp,-16
 15a:	e422                	sd	s0,8(sp)
 15c:	0800                	add	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 15e:	00054783          	lbu	a5,0(a0)
 162:	cf91                	beqz	a5,17e <strlen+0x26>
 164:	0505                	add	a0,a0,1
 166:	87aa                	mv	a5,a0
 168:	86be                	mv	a3,a5
 16a:	0785                	add	a5,a5,1
 16c:	fff7c703          	lbu	a4,-1(a5)
 170:	ff65                	bnez	a4,168 <strlen+0x10>
 172:	40a6853b          	subw	a0,a3,a0
 176:	2505                	addw	a0,a0,1
    ;
  return n;
}
 178:	6422                	ld	s0,8(sp)
 17a:	0141                	add	sp,sp,16
 17c:	8082                	ret
  for(n = 0; s[n]; n++)
 17e:	4501                	li	a0,0
 180:	bfe5                	j	178 <strlen+0x20>

0000000000000182 <memset>:

void*
memset(void *dst, int c, uint n)
{
 182:	1141                	add	sp,sp,-16
 184:	e422                	sd	s0,8(sp)
 186:	0800                	add	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 188:	ca19                	beqz	a2,19e <memset+0x1c>
 18a:	87aa                	mv	a5,a0
 18c:	1602                	sll	a2,a2,0x20
 18e:	9201                	srl	a2,a2,0x20
 190:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 194:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 198:	0785                	add	a5,a5,1
 19a:	fee79de3          	bne	a5,a4,194 <memset+0x12>
  }
  return dst;
}
 19e:	6422                	ld	s0,8(sp)
 1a0:	0141                	add	sp,sp,16
 1a2:	8082                	ret

00000000000001a4 <strchr>:

char*
strchr(const char *s, char c)
{
 1a4:	1141                	add	sp,sp,-16
 1a6:	e422                	sd	s0,8(sp)
 1a8:	0800                	add	s0,sp,16
  for(; *s; s++)
 1aa:	00054783          	lbu	a5,0(a0)
 1ae:	cb99                	beqz	a5,1c4 <strchr+0x20>
    if(*s == c)
 1b0:	00f58763          	beq	a1,a5,1be <strchr+0x1a>
  for(; *s; s++)
 1b4:	0505                	add	a0,a0,1
 1b6:	00054783          	lbu	a5,0(a0)
 1ba:	fbfd                	bnez	a5,1b0 <strchr+0xc>
      return (char*)s;
  return 0;
 1bc:	4501                	li	a0,0
}
 1be:	6422                	ld	s0,8(sp)
 1c0:	0141                	add	sp,sp,16
 1c2:	8082                	ret
  return 0;
 1c4:	4501                	li	a0,0
 1c6:	bfe5                	j	1be <strchr+0x1a>

00000000000001c8 <gets>:

char*
gets(char *buf, int max)
{
 1c8:	711d                	add	sp,sp,-96
 1ca:	ec86                	sd	ra,88(sp)
 1cc:	e8a2                	sd	s0,80(sp)
 1ce:	e4a6                	sd	s1,72(sp)
 1d0:	e0ca                	sd	s2,64(sp)
 1d2:	fc4e                	sd	s3,56(sp)
 1d4:	f852                	sd	s4,48(sp)
 1d6:	f456                	sd	s5,40(sp)
 1d8:	f05a                	sd	s6,32(sp)
 1da:	ec5e                	sd	s7,24(sp)
 1dc:	1080                	add	s0,sp,96
 1de:	8baa                	mv	s7,a0
 1e0:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1e2:	892a                	mv	s2,a0
 1e4:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 1e6:	4aa9                	li	s5,10
 1e8:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 1ea:	89a6                	mv	s3,s1
 1ec:	2485                	addw	s1,s1,1
 1ee:	0344d663          	bge	s1,s4,21a <gets+0x52>
    cc = read(0, &c, 1);
 1f2:	4605                	li	a2,1
 1f4:	faf40593          	add	a1,s0,-81
 1f8:	4501                	li	a0,0
 1fa:	252000ef          	jal	44c <read>
    if(cc < 1)
 1fe:	00a05e63          	blez	a0,21a <gets+0x52>
    buf[i++] = c;
 202:	faf44783          	lbu	a5,-81(s0)
 206:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 20a:	01578763          	beq	a5,s5,218 <gets+0x50>
 20e:	0905                	add	s2,s2,1
 210:	fd679de3          	bne	a5,s6,1ea <gets+0x22>
    buf[i++] = c;
 214:	89a6                	mv	s3,s1
 216:	a011                	j	21a <gets+0x52>
 218:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 21a:	99de                	add	s3,s3,s7
 21c:	00098023          	sb	zero,0(s3)
  return buf;
}
 220:	855e                	mv	a0,s7
 222:	60e6                	ld	ra,88(sp)
 224:	6446                	ld	s0,80(sp)
 226:	64a6                	ld	s1,72(sp)
 228:	6906                	ld	s2,64(sp)
 22a:	79e2                	ld	s3,56(sp)
 22c:	7a42                	ld	s4,48(sp)
 22e:	7aa2                	ld	s5,40(sp)
 230:	7b02                	ld	s6,32(sp)
 232:	6be2                	ld	s7,24(sp)
 234:	6125                	add	sp,sp,96
 236:	8082                	ret

0000000000000238 <stat>:

int
stat(const char *n, struct stat *st)
{
 238:	1101                	add	sp,sp,-32
 23a:	ec06                	sd	ra,24(sp)
 23c:	e822                	sd	s0,16(sp)
 23e:	e04a                	sd	s2,0(sp)
 240:	1000                	add	s0,sp,32
 242:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 244:	4581                	li	a1,0
 246:	22e000ef          	jal	474 <open>
  if(fd < 0)
 24a:	02054263          	bltz	a0,26e <stat+0x36>
 24e:	e426                	sd	s1,8(sp)
 250:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 252:	85ca                	mv	a1,s2
 254:	238000ef          	jal	48c <fstat>
 258:	892a                	mv	s2,a0
  close(fd);
 25a:	8526                	mv	a0,s1
 25c:	200000ef          	jal	45c <close>
  return r;
 260:	64a2                	ld	s1,8(sp)
}
 262:	854a                	mv	a0,s2
 264:	60e2                	ld	ra,24(sp)
 266:	6442                	ld	s0,16(sp)
 268:	6902                	ld	s2,0(sp)
 26a:	6105                	add	sp,sp,32
 26c:	8082                	ret
    return -1;
 26e:	597d                	li	s2,-1
 270:	bfcd                	j	262 <stat+0x2a>

0000000000000272 <atoi>:

int
atoi(const char *s)
{
 272:	1141                	add	sp,sp,-16
 274:	e422                	sd	s0,8(sp)
 276:	0800                	add	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 278:	00054683          	lbu	a3,0(a0)
 27c:	fd06879b          	addw	a5,a3,-48
 280:	0ff7f793          	zext.b	a5,a5
 284:	4625                	li	a2,9
 286:	02f66863          	bltu	a2,a5,2b6 <atoi+0x44>
 28a:	872a                	mv	a4,a0
  n = 0;
 28c:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 28e:	0705                	add	a4,a4,1
 290:	0025179b          	sllw	a5,a0,0x2
 294:	9fa9                	addw	a5,a5,a0
 296:	0017979b          	sllw	a5,a5,0x1
 29a:	9fb5                	addw	a5,a5,a3
 29c:	fd07851b          	addw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 2a0:	00074683          	lbu	a3,0(a4)
 2a4:	fd06879b          	addw	a5,a3,-48
 2a8:	0ff7f793          	zext.b	a5,a5
 2ac:	fef671e3          	bgeu	a2,a5,28e <atoi+0x1c>
  return n;
}
 2b0:	6422                	ld	s0,8(sp)
 2b2:	0141                	add	sp,sp,16
 2b4:	8082                	ret
  n = 0;
 2b6:	4501                	li	a0,0
 2b8:	bfe5                	j	2b0 <atoi+0x3e>

00000000000002ba <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 2ba:	1141                	add	sp,sp,-16
 2bc:	e422                	sd	s0,8(sp)
 2be:	0800                	add	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 2c0:	02b57463          	bgeu	a0,a1,2e8 <memmove+0x2e>
    while(n-- > 0)
 2c4:	00c05f63          	blez	a2,2e2 <memmove+0x28>
 2c8:	1602                	sll	a2,a2,0x20
 2ca:	9201                	srl	a2,a2,0x20
 2cc:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 2d0:	872a                	mv	a4,a0
      *dst++ = *src++;
 2d2:	0585                	add	a1,a1,1
 2d4:	0705                	add	a4,a4,1
 2d6:	fff5c683          	lbu	a3,-1(a1)
 2da:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 2de:	fef71ae3          	bne	a4,a5,2d2 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 2e2:	6422                	ld	s0,8(sp)
 2e4:	0141                	add	sp,sp,16
 2e6:	8082                	ret
    dst += n;
 2e8:	00c50733          	add	a4,a0,a2
    src += n;
 2ec:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 2ee:	fec05ae3          	blez	a2,2e2 <memmove+0x28>
 2f2:	fff6079b          	addw	a5,a2,-1
 2f6:	1782                	sll	a5,a5,0x20
 2f8:	9381                	srl	a5,a5,0x20
 2fa:	fff7c793          	not	a5,a5
 2fe:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 300:	15fd                	add	a1,a1,-1
 302:	177d                	add	a4,a4,-1
 304:	0005c683          	lbu	a3,0(a1)
 308:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 30c:	fee79ae3          	bne	a5,a4,300 <memmove+0x46>
 310:	bfc9                	j	2e2 <memmove+0x28>

0000000000000312 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 312:	1141                	add	sp,sp,-16
 314:	e422                	sd	s0,8(sp)
 316:	0800                	add	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 318:	ca05                	beqz	a2,348 <memcmp+0x36>
 31a:	fff6069b          	addw	a3,a2,-1
 31e:	1682                	sll	a3,a3,0x20
 320:	9281                	srl	a3,a3,0x20
 322:	0685                	add	a3,a3,1
 324:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 326:	00054783          	lbu	a5,0(a0)
 32a:	0005c703          	lbu	a4,0(a1)
 32e:	00e79863          	bne	a5,a4,33e <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 332:	0505                	add	a0,a0,1
    p2++;
 334:	0585                	add	a1,a1,1
  while (n-- > 0) {
 336:	fed518e3          	bne	a0,a3,326 <memcmp+0x14>
  }
  return 0;
 33a:	4501                	li	a0,0
 33c:	a019                	j	342 <memcmp+0x30>
      return *p1 - *p2;
 33e:	40e7853b          	subw	a0,a5,a4
}
 342:	6422                	ld	s0,8(sp)
 344:	0141                	add	sp,sp,16
 346:	8082                	ret
  return 0;
 348:	4501                	li	a0,0
 34a:	bfe5                	j	342 <memcmp+0x30>

000000000000034c <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 34c:	1141                	add	sp,sp,-16
 34e:	e406                	sd	ra,8(sp)
 350:	e022                	sd	s0,0(sp)
 352:	0800                	add	s0,sp,16
  return memmove(dst, src, n);
 354:	f67ff0ef          	jal	2ba <memmove>
}
 358:	60a2                	ld	ra,8(sp)
 35a:	6402                	ld	s0,0(sp)
 35c:	0141                	add	sp,sp,16
 35e:	8082                	ret

0000000000000360 <sbrk>:

char *
sbrk(int n) {
 360:	1141                	add	sp,sp,-16
 362:	e406                	sd	ra,8(sp)
 364:	e022                	sd	s0,0(sp)
 366:	0800                	add	s0,sp,16
  return sys_sbrk(n, SBRK_EAGER);
 368:	4585                	li	a1,1
 36a:	152000ef          	jal	4bc <sys_sbrk>
}
 36e:	60a2                	ld	ra,8(sp)
 370:	6402                	ld	s0,0(sp)
 372:	0141                	add	sp,sp,16
 374:	8082                	ret

0000000000000376 <sbrklazy>:

char *
sbrklazy(int n) {
 376:	1141                	add	sp,sp,-16
 378:	e406                	sd	ra,8(sp)
 37a:	e022                	sd	s0,0(sp)
 37c:	0800                	add	s0,sp,16
  return sys_sbrk(n, SBRK_LAZY);
 37e:	4589                	li	a1,2
 380:	13c000ef          	jal	4bc <sys_sbrk>
}
 384:	60a2                	ld	ra,8(sp)
 386:	6402                	ld	s0,0(sp)
 388:	0141                	add	sp,sp,16
 38a:	8082                	ret

000000000000038c <htons>:

// Byte order conversion functions
unsigned short
htons(unsigned short hostshort)
{
 38c:	1141                	add	sp,sp,-16
 38e:	e422                	sd	s0,8(sp)
 390:	0800                	add	s0,sp,16
  return ((hostshort >> 8) & 0xff) | ((hostshort & 0xff) << 8);
 392:	0085179b          	sllw	a5,a0,0x8
 396:	0085551b          	srlw	a0,a0,0x8
 39a:	8d5d                	or	a0,a0,a5
}
 39c:	1542                	sll	a0,a0,0x30
 39e:	9141                	srl	a0,a0,0x30
 3a0:	6422                	ld	s0,8(sp)
 3a2:	0141                	add	sp,sp,16
 3a4:	8082                	ret

00000000000003a6 <ntohs>:

unsigned short
ntohs(unsigned short netshort)
{
 3a6:	1141                	add	sp,sp,-16
 3a8:	e422                	sd	s0,8(sp)
 3aa:	0800                	add	s0,sp,16
  return ((netshort >> 8) & 0xff) | ((netshort & 0xff) << 8);
 3ac:	0085179b          	sllw	a5,a0,0x8
 3b0:	0085551b          	srlw	a0,a0,0x8
 3b4:	8d5d                	or	a0,a0,a5
}
 3b6:	1542                	sll	a0,a0,0x30
 3b8:	9141                	srl	a0,a0,0x30
 3ba:	6422                	ld	s0,8(sp)
 3bc:	0141                	add	sp,sp,16
 3be:	8082                	ret

00000000000003c0 <htonl>:

unsigned long
htonl(unsigned long hostlong)
{
 3c0:	1141                	add	sp,sp,-16
 3c2:	e422                	sd	s0,8(sp)
 3c4:	0800                	add	s0,sp,16
  return ((hostlong >> 24) & 0xff) |
 3c6:	0185579b          	srlw	a5,a0,0x18
         ((hostlong >> 8) & 0xff00) |
 3ca:	00855713          	srl	a4,a0,0x8
 3ce:	66c1                	lui	a3,0x10
 3d0:	f0068693          	add	a3,a3,-256 # ff00 <base+0xeef0>
 3d4:	8f75                	and	a4,a4,a3
  return ((hostlong >> 24) & 0xff) |
 3d6:	8fd9                	or	a5,a5,a4
         ((hostlong & 0xff00) << 8) |
 3d8:	00851713          	sll	a4,a0,0x8
 3dc:	00ff06b7          	lui	a3,0xff0
 3e0:	8f75                	and	a4,a4,a3
         ((hostlong >> 8) & 0xff00) |
 3e2:	8fd9                	or	a5,a5,a4
         ((hostlong & 0xff) << 24);
 3e4:	0562                	sll	a0,a0,0x18
 3e6:	0ff00713          	li	a4,255
 3ea:	0762                	sll	a4,a4,0x18
 3ec:	8d79                	and	a0,a0,a4
}
 3ee:	8d5d                	or	a0,a0,a5
 3f0:	6422                	ld	s0,8(sp)
 3f2:	0141                	add	sp,sp,16
 3f4:	8082                	ret

00000000000003f6 <ntohl>:

unsigned long
ntohl(unsigned long netlong)
{
 3f6:	1141                	add	sp,sp,-16
 3f8:	e422                	sd	s0,8(sp)
 3fa:	0800                	add	s0,sp,16
  return ((netlong >> 24) & 0xff) |
 3fc:	0185579b          	srlw	a5,a0,0x18
         ((netlong >> 8) & 0xff00) |
 400:	00855713          	srl	a4,a0,0x8
 404:	66c1                	lui	a3,0x10
 406:	f0068693          	add	a3,a3,-256 # ff00 <base+0xeef0>
 40a:	8f75                	and	a4,a4,a3
  return ((netlong >> 24) & 0xff) |
 40c:	8fd9                	or	a5,a5,a4
         ((netlong & 0xff00) << 8) |
 40e:	00851713          	sll	a4,a0,0x8
 412:	00ff06b7          	lui	a3,0xff0
 416:	8f75                	and	a4,a4,a3
         ((netlong >> 8) & 0xff00) |
 418:	8fd9                	or	a5,a5,a4
         ((netlong & 0xff) << 24);
 41a:	0562                	sll	a0,a0,0x18
 41c:	0ff00713          	li	a4,255
 420:	0762                	sll	a4,a4,0x18
 422:	8d79                	and	a0,a0,a4
}
 424:	8d5d                	or	a0,a0,a5
 426:	6422                	ld	s0,8(sp)
 428:	0141                	add	sp,sp,16
 42a:	8082                	ret

000000000000042c <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 42c:	4885                	li	a7,1
 ecall
 42e:	00000073          	ecall
 ret
 432:	8082                	ret

0000000000000434 <exit>:
.global exit
exit:
 li a7, SYS_exit
 434:	4889                	li	a7,2
 ecall
 436:	00000073          	ecall
 ret
 43a:	8082                	ret

000000000000043c <wait>:
.global wait
wait:
 li a7, SYS_wait
 43c:	488d                	li	a7,3
 ecall
 43e:	00000073          	ecall
 ret
 442:	8082                	ret

0000000000000444 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 444:	4891                	li	a7,4
 ecall
 446:	00000073          	ecall
 ret
 44a:	8082                	ret

000000000000044c <read>:
.global read
read:
 li a7, SYS_read
 44c:	4895                	li	a7,5
 ecall
 44e:	00000073          	ecall
 ret
 452:	8082                	ret

0000000000000454 <write>:
.global write
write:
 li a7, SYS_write
 454:	48c1                	li	a7,16
 ecall
 456:	00000073          	ecall
 ret
 45a:	8082                	ret

000000000000045c <close>:
.global close
close:
 li a7, SYS_close
 45c:	48d5                	li	a7,21
 ecall
 45e:	00000073          	ecall
 ret
 462:	8082                	ret

0000000000000464 <kill>:
.global kill
kill:
 li a7, SYS_kill
 464:	4899                	li	a7,6
 ecall
 466:	00000073          	ecall
 ret
 46a:	8082                	ret

000000000000046c <exec>:
.global exec
exec:
 li a7, SYS_exec
 46c:	489d                	li	a7,7
 ecall
 46e:	00000073          	ecall
 ret
 472:	8082                	ret

0000000000000474 <open>:
.global open
open:
 li a7, SYS_open
 474:	48bd                	li	a7,15
 ecall
 476:	00000073          	ecall
 ret
 47a:	8082                	ret

000000000000047c <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 47c:	48c5                	li	a7,17
 ecall
 47e:	00000073          	ecall
 ret
 482:	8082                	ret

0000000000000484 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 484:	48c9                	li	a7,18
 ecall
 486:	00000073          	ecall
 ret
 48a:	8082                	ret

000000000000048c <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 48c:	48a1                	li	a7,8
 ecall
 48e:	00000073          	ecall
 ret
 492:	8082                	ret

0000000000000494 <link>:
.global link
link:
 li a7, SYS_link
 494:	48cd                	li	a7,19
 ecall
 496:	00000073          	ecall
 ret
 49a:	8082                	ret

000000000000049c <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 49c:	48d1                	li	a7,20
 ecall
 49e:	00000073          	ecall
 ret
 4a2:	8082                	ret

00000000000004a4 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 4a4:	48a5                	li	a7,9
 ecall
 4a6:	00000073          	ecall
 ret
 4aa:	8082                	ret

00000000000004ac <dup>:
.global dup
dup:
 li a7, SYS_dup
 4ac:	48a9                	li	a7,10
 ecall
 4ae:	00000073          	ecall
 ret
 4b2:	8082                	ret

00000000000004b4 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 4b4:	48ad                	li	a7,11
 ecall
 4b6:	00000073          	ecall
 ret
 4ba:	8082                	ret

00000000000004bc <sys_sbrk>:
.global sys_sbrk
sys_sbrk:
 li a7, SYS_sbrk
 4bc:	48b1                	li	a7,12
 ecall
 4be:	00000073          	ecall
 ret
 4c2:	8082                	ret

00000000000004c4 <pause>:
.global pause
pause:
 li a7, SYS_pause
 4c4:	48b5                	li	a7,13
 ecall
 4c6:	00000073          	ecall
 ret
 4ca:	8082                	ret

00000000000004cc <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 4cc:	48b9                	li	a7,14
 ecall
 4ce:	00000073          	ecall
 ret
 4d2:	8082                	ret

00000000000004d4 <socket>:
.global socket
socket:
 li a7, SYS_socket
 4d4:	48d9                	li	a7,22
 ecall
 4d6:	00000073          	ecall
 ret
 4da:	8082                	ret

00000000000004dc <bind>:
.global bind
bind:
 li a7, SYS_bind
 4dc:	48dd                	li	a7,23
 ecall
 4de:	00000073          	ecall
 ret
 4e2:	8082                	ret

00000000000004e4 <listen>:
.global listen
listen:
 li a7, SYS_listen
 4e4:	48e1                	li	a7,24
 ecall
 4e6:	00000073          	ecall
 ret
 4ea:	8082                	ret

00000000000004ec <accept>:
.global accept
accept:
 li a7, SYS_accept
 4ec:	48e5                	li	a7,25
 ecall
 4ee:	00000073          	ecall
 ret
 4f2:	8082                	ret

00000000000004f4 <connect>:
.global connect
connect:
 li a7, SYS_connect
 4f4:	48e9                	li	a7,26
 ecall
 4f6:	00000073          	ecall
 ret
 4fa:	8082                	ret

00000000000004fc <send>:
.global send
send:
 li a7, SYS_send
 4fc:	48ed                	li	a7,27
 ecall
 4fe:	00000073          	ecall
 ret
 502:	8082                	ret

0000000000000504 <recv>:
.global recv
recv:
 li a7, SYS_recv
 504:	48f1                	li	a7,28
 ecall
 506:	00000073          	ecall
 ret
 50a:	8082                	ret

000000000000050c <sendto>:
.global sendto
sendto:
 li a7, SYS_sendto
 50c:	48f5                	li	a7,29
 ecall
 50e:	00000073          	ecall
 ret
 512:	8082                	ret

0000000000000514 <recvfrom>:
.global recvfrom
recvfrom:
 li a7, SYS_recvfrom
 514:	48f9                	li	a7,30
 ecall
 516:	00000073          	ecall
 ret
 51a:	8082                	ret

000000000000051c <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 51c:	1101                	add	sp,sp,-32
 51e:	ec06                	sd	ra,24(sp)
 520:	e822                	sd	s0,16(sp)
 522:	1000                	add	s0,sp,32
 524:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 528:	4605                	li	a2,1
 52a:	fef40593          	add	a1,s0,-17
 52e:	f27ff0ef          	jal	454 <write>
}
 532:	60e2                	ld	ra,24(sp)
 534:	6442                	ld	s0,16(sp)
 536:	6105                	add	sp,sp,32
 538:	8082                	ret

000000000000053a <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
 53a:	715d                	add	sp,sp,-80
 53c:	e486                	sd	ra,72(sp)
 53e:	e0a2                	sd	s0,64(sp)
 540:	f84a                	sd	s2,48(sp)
 542:	0880                	add	s0,sp,80
 544:	892a                	mv	s2,a0
  char buf[20];
  int i, neg;
  unsigned long long x;

  neg = 0;
  if(sgn && xx < 0){
 546:	c299                	beqz	a3,54c <printint+0x12>
 548:	0805c363          	bltz	a1,5ce <printint+0x94>
  neg = 0;
 54c:	4881                	li	a7,0
 54e:	fb840693          	add	a3,s0,-72
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
 552:	4781                	li	a5,0
  do{
    buf[i++] = digits[x % base];
 554:	00000517          	auipc	a0,0x0
 558:	53c50513          	add	a0,a0,1340 # a90 <digits>
 55c:	883e                	mv	a6,a5
 55e:	2785                	addw	a5,a5,1
 560:	02c5f733          	remu	a4,a1,a2
 564:	972a                	add	a4,a4,a0
 566:	00074703          	lbu	a4,0(a4)
 56a:	00e68023          	sb	a4,0(a3) # ff0000 <base+0xfeeff0>
  }while((x /= base) != 0);
 56e:	872e                	mv	a4,a1
 570:	02c5d5b3          	divu	a1,a1,a2
 574:	0685                	add	a3,a3,1
 576:	fec773e3          	bgeu	a4,a2,55c <printint+0x22>
  if(neg)
 57a:	00088b63          	beqz	a7,590 <printint+0x56>
    buf[i++] = '-';
 57e:	fd078793          	add	a5,a5,-48
 582:	97a2                	add	a5,a5,s0
 584:	02d00713          	li	a4,45
 588:	fee78423          	sb	a4,-24(a5)
 58c:	0028079b          	addw	a5,a6,2

  while(--i >= 0)
 590:	02f05a63          	blez	a5,5c4 <printint+0x8a>
 594:	fc26                	sd	s1,56(sp)
 596:	f44e                	sd	s3,40(sp)
 598:	fb840713          	add	a4,s0,-72
 59c:	00f704b3          	add	s1,a4,a5
 5a0:	fff70993          	add	s3,a4,-1
 5a4:	99be                	add	s3,s3,a5
 5a6:	37fd                	addw	a5,a5,-1
 5a8:	1782                	sll	a5,a5,0x20
 5aa:	9381                	srl	a5,a5,0x20
 5ac:	40f989b3          	sub	s3,s3,a5
    putc(fd, buf[i]);
 5b0:	fff4c583          	lbu	a1,-1(s1)
 5b4:	854a                	mv	a0,s2
 5b6:	f67ff0ef          	jal	51c <putc>
  while(--i >= 0)
 5ba:	14fd                	add	s1,s1,-1
 5bc:	ff349ae3          	bne	s1,s3,5b0 <printint+0x76>
 5c0:	74e2                	ld	s1,56(sp)
 5c2:	79a2                	ld	s3,40(sp)
}
 5c4:	60a6                	ld	ra,72(sp)
 5c6:	6406                	ld	s0,64(sp)
 5c8:	7942                	ld	s2,48(sp)
 5ca:	6161                	add	sp,sp,80
 5cc:	8082                	ret
    x = -xx;
 5ce:	40b005b3          	neg	a1,a1
    neg = 1;
 5d2:	4885                	li	a7,1
    x = -xx;
 5d4:	bfad                	j	54e <printint+0x14>

00000000000005d6 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %c, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 5d6:	711d                	add	sp,sp,-96
 5d8:	ec86                	sd	ra,88(sp)
 5da:	e8a2                	sd	s0,80(sp)
 5dc:	e0ca                	sd	s2,64(sp)
 5de:	1080                	add	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 5e0:	0005c903          	lbu	s2,0(a1)
 5e4:	28090663          	beqz	s2,870 <vprintf+0x29a>
 5e8:	e4a6                	sd	s1,72(sp)
 5ea:	fc4e                	sd	s3,56(sp)
 5ec:	f852                	sd	s4,48(sp)
 5ee:	f456                	sd	s5,40(sp)
 5f0:	f05a                	sd	s6,32(sp)
 5f2:	ec5e                	sd	s7,24(sp)
 5f4:	e862                	sd	s8,16(sp)
 5f6:	e466                	sd	s9,8(sp)
 5f8:	8b2a                	mv	s6,a0
 5fa:	8a2e                	mv	s4,a1
 5fc:	8bb2                	mv	s7,a2
  state = 0;
 5fe:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
 600:	4481                	li	s1,0
 602:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
 604:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
 608:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
 60c:	06c00c93          	li	s9,108
 610:	a005                	j	630 <vprintf+0x5a>
        putc(fd, c0);
 612:	85ca                	mv	a1,s2
 614:	855a                	mv	a0,s6
 616:	f07ff0ef          	jal	51c <putc>
 61a:	a019                	j	620 <vprintf+0x4a>
    } else if(state == '%'){
 61c:	03598263          	beq	s3,s5,640 <vprintf+0x6a>
  for(i = 0; fmt[i]; i++){
 620:	2485                	addw	s1,s1,1
 622:	8726                	mv	a4,s1
 624:	009a07b3          	add	a5,s4,s1
 628:	0007c903          	lbu	s2,0(a5)
 62c:	22090a63          	beqz	s2,860 <vprintf+0x28a>
    c0 = fmt[i] & 0xff;
 630:	0009079b          	sext.w	a5,s2
    if(state == 0){
 634:	fe0994e3          	bnez	s3,61c <vprintf+0x46>
      if(c0 == '%'){
 638:	fd579de3          	bne	a5,s5,612 <vprintf+0x3c>
        state = '%';
 63c:	89be                	mv	s3,a5
 63e:	b7cd                	j	620 <vprintf+0x4a>
      if(c0) c1 = fmt[i+1] & 0xff;
 640:	00ea06b3          	add	a3,s4,a4
 644:	0016c683          	lbu	a3,1(a3)
      c1 = c2 = 0;
 648:	8636                	mv	a2,a3
      if(c1) c2 = fmt[i+2] & 0xff;
 64a:	c681                	beqz	a3,652 <vprintf+0x7c>
 64c:	9752                	add	a4,a4,s4
 64e:	00274603          	lbu	a2,2(a4)
      if(c0 == 'd'){
 652:	05878363          	beq	a5,s8,698 <vprintf+0xc2>
      } else if(c0 == 'l' && c1 == 'd'){
 656:	05978d63          	beq	a5,s9,6b0 <vprintf+0xda>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
 65a:	07500713          	li	a4,117
 65e:	0ee78763          	beq	a5,a4,74c <vprintf+0x176>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
 662:	07800713          	li	a4,120
 666:	12e78963          	beq	a5,a4,798 <vprintf+0x1c2>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
 66a:	07000713          	li	a4,112
 66e:	14e78e63          	beq	a5,a4,7ca <vprintf+0x1f4>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 'c'){
 672:	06300713          	li	a4,99
 676:	18e78e63          	beq	a5,a4,812 <vprintf+0x23c>
        putc(fd, va_arg(ap, uint32));
      } else if(c0 == 's'){
 67a:	07300713          	li	a4,115
 67e:	1ae78463          	beq	a5,a4,826 <vprintf+0x250>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
 682:	02500713          	li	a4,37
 686:	04e79563          	bne	a5,a4,6d0 <vprintf+0xfa>
        putc(fd, '%');
 68a:	02500593          	li	a1,37
 68e:	855a                	mv	a0,s6
 690:	e8dff0ef          	jal	51c <putc>
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c0);
      }

      state = 0;
 694:	4981                	li	s3,0
 696:	b769                	j	620 <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 1);
 698:	008b8913          	add	s2,s7,8
 69c:	4685                	li	a3,1
 69e:	4629                	li	a2,10
 6a0:	000ba583          	lw	a1,0(s7)
 6a4:	855a                	mv	a0,s6
 6a6:	e95ff0ef          	jal	53a <printint>
 6aa:	8bca                	mv	s7,s2
      state = 0;
 6ac:	4981                	li	s3,0
 6ae:	bf8d                	j	620 <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'd'){
 6b0:	06400793          	li	a5,100
 6b4:	02f68963          	beq	a3,a5,6e6 <vprintf+0x110>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 6b8:	06c00793          	li	a5,108
 6bc:	04f68263          	beq	a3,a5,700 <vprintf+0x12a>
      } else if(c0 == 'l' && c1 == 'u'){
 6c0:	07500793          	li	a5,117
 6c4:	0af68063          	beq	a3,a5,764 <vprintf+0x18e>
      } else if(c0 == 'l' && c1 == 'x'){
 6c8:	07800793          	li	a5,120
 6cc:	0ef68263          	beq	a3,a5,7b0 <vprintf+0x1da>
        putc(fd, '%');
 6d0:	02500593          	li	a1,37
 6d4:	855a                	mv	a0,s6
 6d6:	e47ff0ef          	jal	51c <putc>
        putc(fd, c0);
 6da:	85ca                	mv	a1,s2
 6dc:	855a                	mv	a0,s6
 6de:	e3fff0ef          	jal	51c <putc>
      state = 0;
 6e2:	4981                	li	s3,0
 6e4:	bf35                	j	620 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 6e6:	008b8913          	add	s2,s7,8
 6ea:	4685                	li	a3,1
 6ec:	4629                	li	a2,10
 6ee:	000bb583          	ld	a1,0(s7)
 6f2:	855a                	mv	a0,s6
 6f4:	e47ff0ef          	jal	53a <printint>
        i += 1;
 6f8:	2485                	addw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 6fa:	8bca                	mv	s7,s2
      state = 0;
 6fc:	4981                	li	s3,0
        i += 1;
 6fe:	b70d                	j	620 <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 700:	06400793          	li	a5,100
 704:	02f60763          	beq	a2,a5,732 <vprintf+0x15c>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 708:	07500793          	li	a5,117
 70c:	06f60963          	beq	a2,a5,77e <vprintf+0x1a8>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 710:	07800793          	li	a5,120
 714:	faf61ee3          	bne	a2,a5,6d0 <vprintf+0xfa>
        printint(fd, va_arg(ap, uint64), 16, 0);
 718:	008b8913          	add	s2,s7,8
 71c:	4681                	li	a3,0
 71e:	4641                	li	a2,16
 720:	000bb583          	ld	a1,0(s7)
 724:	855a                	mv	a0,s6
 726:	e15ff0ef          	jal	53a <printint>
        i += 2;
 72a:	2489                	addw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 72c:	8bca                	mv	s7,s2
      state = 0;
 72e:	4981                	li	s3,0
        i += 2;
 730:	bdc5                	j	620 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 732:	008b8913          	add	s2,s7,8
 736:	4685                	li	a3,1
 738:	4629                	li	a2,10
 73a:	000bb583          	ld	a1,0(s7)
 73e:	855a                	mv	a0,s6
 740:	dfbff0ef          	jal	53a <printint>
        i += 2;
 744:	2489                	addw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 746:	8bca                	mv	s7,s2
      state = 0;
 748:	4981                	li	s3,0
        i += 2;
 74a:	bdd9                	j	620 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint32), 10, 0);
 74c:	008b8913          	add	s2,s7,8
 750:	4681                	li	a3,0
 752:	4629                	li	a2,10
 754:	000be583          	lwu	a1,0(s7)
 758:	855a                	mv	a0,s6
 75a:	de1ff0ef          	jal	53a <printint>
 75e:	8bca                	mv	s7,s2
      state = 0;
 760:	4981                	li	s3,0
 762:	bd7d                	j	620 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 764:	008b8913          	add	s2,s7,8
 768:	4681                	li	a3,0
 76a:	4629                	li	a2,10
 76c:	000bb583          	ld	a1,0(s7)
 770:	855a                	mv	a0,s6
 772:	dc9ff0ef          	jal	53a <printint>
        i += 1;
 776:	2485                	addw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 778:	8bca                	mv	s7,s2
      state = 0;
 77a:	4981                	li	s3,0
        i += 1;
 77c:	b555                	j	620 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 77e:	008b8913          	add	s2,s7,8
 782:	4681                	li	a3,0
 784:	4629                	li	a2,10
 786:	000bb583          	ld	a1,0(s7)
 78a:	855a                	mv	a0,s6
 78c:	dafff0ef          	jal	53a <printint>
        i += 2;
 790:	2489                	addw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 792:	8bca                	mv	s7,s2
      state = 0;
 794:	4981                	li	s3,0
        i += 2;
 796:	b569                	j	620 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint32), 16, 0);
 798:	008b8913          	add	s2,s7,8
 79c:	4681                	li	a3,0
 79e:	4641                	li	a2,16
 7a0:	000be583          	lwu	a1,0(s7)
 7a4:	855a                	mv	a0,s6
 7a6:	d95ff0ef          	jal	53a <printint>
 7aa:	8bca                	mv	s7,s2
      state = 0;
 7ac:	4981                	li	s3,0
 7ae:	bd8d                	j	620 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 16, 0);
 7b0:	008b8913          	add	s2,s7,8
 7b4:	4681                	li	a3,0
 7b6:	4641                	li	a2,16
 7b8:	000bb583          	ld	a1,0(s7)
 7bc:	855a                	mv	a0,s6
 7be:	d7dff0ef          	jal	53a <printint>
        i += 1;
 7c2:	2485                	addw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 7c4:	8bca                	mv	s7,s2
      state = 0;
 7c6:	4981                	li	s3,0
        i += 1;
 7c8:	bda1                	j	620 <vprintf+0x4a>
 7ca:	e06a                	sd	s10,0(sp)
        printptr(fd, va_arg(ap, uint64));
 7cc:	008b8d13          	add	s10,s7,8
 7d0:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 7d4:	03000593          	li	a1,48
 7d8:	855a                	mv	a0,s6
 7da:	d43ff0ef          	jal	51c <putc>
  putc(fd, 'x');
 7de:	07800593          	li	a1,120
 7e2:	855a                	mv	a0,s6
 7e4:	d39ff0ef          	jal	51c <putc>
 7e8:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 7ea:	00000b97          	auipc	s7,0x0
 7ee:	2a6b8b93          	add	s7,s7,678 # a90 <digits>
 7f2:	03c9d793          	srl	a5,s3,0x3c
 7f6:	97de                	add	a5,a5,s7
 7f8:	0007c583          	lbu	a1,0(a5)
 7fc:	855a                	mv	a0,s6
 7fe:	d1fff0ef          	jal	51c <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 802:	0992                	sll	s3,s3,0x4
 804:	397d                	addw	s2,s2,-1
 806:	fe0916e3          	bnez	s2,7f2 <vprintf+0x21c>
        printptr(fd, va_arg(ap, uint64));
 80a:	8bea                	mv	s7,s10
      state = 0;
 80c:	4981                	li	s3,0
 80e:	6d02                	ld	s10,0(sp)
 810:	bd01                	j	620 <vprintf+0x4a>
        putc(fd, va_arg(ap, uint32));
 812:	008b8913          	add	s2,s7,8
 816:	000bc583          	lbu	a1,0(s7)
 81a:	855a                	mv	a0,s6
 81c:	d01ff0ef          	jal	51c <putc>
 820:	8bca                	mv	s7,s2
      state = 0;
 822:	4981                	li	s3,0
 824:	bbf5                	j	620 <vprintf+0x4a>
        if((s = va_arg(ap, char*)) == 0)
 826:	008b8993          	add	s3,s7,8
 82a:	000bb903          	ld	s2,0(s7)
 82e:	00090f63          	beqz	s2,84c <vprintf+0x276>
        for(; *s; s++)
 832:	00094583          	lbu	a1,0(s2)
 836:	c195                	beqz	a1,85a <vprintf+0x284>
          putc(fd, *s);
 838:	855a                	mv	a0,s6
 83a:	ce3ff0ef          	jal	51c <putc>
        for(; *s; s++)
 83e:	0905                	add	s2,s2,1
 840:	00094583          	lbu	a1,0(s2)
 844:	f9f5                	bnez	a1,838 <vprintf+0x262>
        if((s = va_arg(ap, char*)) == 0)
 846:	8bce                	mv	s7,s3
      state = 0;
 848:	4981                	li	s3,0
 84a:	bbd9                	j	620 <vprintf+0x4a>
          s = "(null)";
 84c:	00000917          	auipc	s2,0x0
 850:	23c90913          	add	s2,s2,572 # a88 <malloc+0x130>
        for(; *s; s++)
 854:	02800593          	li	a1,40
 858:	b7c5                	j	838 <vprintf+0x262>
        if((s = va_arg(ap, char*)) == 0)
 85a:	8bce                	mv	s7,s3
      state = 0;
 85c:	4981                	li	s3,0
 85e:	b3c9                	j	620 <vprintf+0x4a>
 860:	64a6                	ld	s1,72(sp)
 862:	79e2                	ld	s3,56(sp)
 864:	7a42                	ld	s4,48(sp)
 866:	7aa2                	ld	s5,40(sp)
 868:	7b02                	ld	s6,32(sp)
 86a:	6be2                	ld	s7,24(sp)
 86c:	6c42                	ld	s8,16(sp)
 86e:	6ca2                	ld	s9,8(sp)
    }
  }
}
 870:	60e6                	ld	ra,88(sp)
 872:	6446                	ld	s0,80(sp)
 874:	6906                	ld	s2,64(sp)
 876:	6125                	add	sp,sp,96
 878:	8082                	ret

000000000000087a <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 87a:	715d                	add	sp,sp,-80
 87c:	ec06                	sd	ra,24(sp)
 87e:	e822                	sd	s0,16(sp)
 880:	1000                	add	s0,sp,32
 882:	e010                	sd	a2,0(s0)
 884:	e414                	sd	a3,8(s0)
 886:	e818                	sd	a4,16(s0)
 888:	ec1c                	sd	a5,24(s0)
 88a:	03043023          	sd	a6,32(s0)
 88e:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 892:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 896:	8622                	mv	a2,s0
 898:	d3fff0ef          	jal	5d6 <vprintf>
}
 89c:	60e2                	ld	ra,24(sp)
 89e:	6442                	ld	s0,16(sp)
 8a0:	6161                	add	sp,sp,80
 8a2:	8082                	ret

00000000000008a4 <printf>:

void
printf(const char *fmt, ...)
{
 8a4:	711d                	add	sp,sp,-96
 8a6:	ec06                	sd	ra,24(sp)
 8a8:	e822                	sd	s0,16(sp)
 8aa:	1000                	add	s0,sp,32
 8ac:	e40c                	sd	a1,8(s0)
 8ae:	e810                	sd	a2,16(s0)
 8b0:	ec14                	sd	a3,24(s0)
 8b2:	f018                	sd	a4,32(s0)
 8b4:	f41c                	sd	a5,40(s0)
 8b6:	03043823          	sd	a6,48(s0)
 8ba:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 8be:	00840613          	add	a2,s0,8
 8c2:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 8c6:	85aa                	mv	a1,a0
 8c8:	4505                	li	a0,1
 8ca:	d0dff0ef          	jal	5d6 <vprintf>
}
 8ce:	60e2                	ld	ra,24(sp)
 8d0:	6442                	ld	s0,16(sp)
 8d2:	6125                	add	sp,sp,96
 8d4:	8082                	ret

00000000000008d6 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 8d6:	1141                	add	sp,sp,-16
 8d8:	e422                	sd	s0,8(sp)
 8da:	0800                	add	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 8dc:	ff050693          	add	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8e0:	00000797          	auipc	a5,0x0
 8e4:	7207b783          	ld	a5,1824(a5) # 1000 <freep>
 8e8:	a02d                	j	912 <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 8ea:	4618                	lw	a4,8(a2)
 8ec:	9f2d                	addw	a4,a4,a1
 8ee:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 8f2:	6398                	ld	a4,0(a5)
 8f4:	6310                	ld	a2,0(a4)
 8f6:	a83d                	j	934 <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 8f8:	ff852703          	lw	a4,-8(a0)
 8fc:	9f31                	addw	a4,a4,a2
 8fe:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 900:	ff053683          	ld	a3,-16(a0)
 904:	a091                	j	948 <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 906:	6398                	ld	a4,0(a5)
 908:	00e7e463          	bltu	a5,a4,910 <free+0x3a>
 90c:	00e6ea63          	bltu	a3,a4,920 <free+0x4a>
{
 910:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 912:	fed7fae3          	bgeu	a5,a3,906 <free+0x30>
 916:	6398                	ld	a4,0(a5)
 918:	00e6e463          	bltu	a3,a4,920 <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 91c:	fee7eae3          	bltu	a5,a4,910 <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 920:	ff852583          	lw	a1,-8(a0)
 924:	6390                	ld	a2,0(a5)
 926:	02059813          	sll	a6,a1,0x20
 92a:	01c85713          	srl	a4,a6,0x1c
 92e:	9736                	add	a4,a4,a3
 930:	fae60de3          	beq	a2,a4,8ea <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 934:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 938:	4790                	lw	a2,8(a5)
 93a:	02061593          	sll	a1,a2,0x20
 93e:	01c5d713          	srl	a4,a1,0x1c
 942:	973e                	add	a4,a4,a5
 944:	fae68ae3          	beq	a3,a4,8f8 <free+0x22>
    p->s.ptr = bp->s.ptr;
 948:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 94a:	00000717          	auipc	a4,0x0
 94e:	6af73b23          	sd	a5,1718(a4) # 1000 <freep>
}
 952:	6422                	ld	s0,8(sp)
 954:	0141                	add	sp,sp,16
 956:	8082                	ret

0000000000000958 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 958:	7139                	add	sp,sp,-64
 95a:	fc06                	sd	ra,56(sp)
 95c:	f822                	sd	s0,48(sp)
 95e:	f426                	sd	s1,40(sp)
 960:	ec4e                	sd	s3,24(sp)
 962:	0080                	add	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 964:	02051493          	sll	s1,a0,0x20
 968:	9081                	srl	s1,s1,0x20
 96a:	04bd                	add	s1,s1,15
 96c:	8091                	srl	s1,s1,0x4
 96e:	0014899b          	addw	s3,s1,1
 972:	0485                	add	s1,s1,1
  if((prevp = freep) == 0){
 974:	00000517          	auipc	a0,0x0
 978:	68c53503          	ld	a0,1676(a0) # 1000 <freep>
 97c:	c915                	beqz	a0,9b0 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 97e:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 980:	4798                	lw	a4,8(a5)
 982:	08977a63          	bgeu	a4,s1,a16 <malloc+0xbe>
 986:	f04a                	sd	s2,32(sp)
 988:	e852                	sd	s4,16(sp)
 98a:	e456                	sd	s5,8(sp)
 98c:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 98e:	8a4e                	mv	s4,s3
 990:	0009871b          	sext.w	a4,s3
 994:	6685                	lui	a3,0x1
 996:	00d77363          	bgeu	a4,a3,99c <malloc+0x44>
 99a:	6a05                	lui	s4,0x1
 99c:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 9a0:	004a1a1b          	sllw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 9a4:	00000917          	auipc	s2,0x0
 9a8:	65c90913          	add	s2,s2,1628 # 1000 <freep>
  if(p == SBRK_ERROR)
 9ac:	5afd                	li	s5,-1
 9ae:	a081                	j	9ee <malloc+0x96>
 9b0:	f04a                	sd	s2,32(sp)
 9b2:	e852                	sd	s4,16(sp)
 9b4:	e456                	sd	s5,8(sp)
 9b6:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 9b8:	00000797          	auipc	a5,0x0
 9bc:	65878793          	add	a5,a5,1624 # 1010 <base>
 9c0:	00000717          	auipc	a4,0x0
 9c4:	64f73023          	sd	a5,1600(a4) # 1000 <freep>
 9c8:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 9ca:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 9ce:	b7c1                	j	98e <malloc+0x36>
        prevp->s.ptr = p->s.ptr;
 9d0:	6398                	ld	a4,0(a5)
 9d2:	e118                	sd	a4,0(a0)
 9d4:	a8a9                	j	a2e <malloc+0xd6>
  hp->s.size = nu;
 9d6:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 9da:	0541                	add	a0,a0,16
 9dc:	efbff0ef          	jal	8d6 <free>
  return freep;
 9e0:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 9e4:	c12d                	beqz	a0,a46 <malloc+0xee>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 9e6:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 9e8:	4798                	lw	a4,8(a5)
 9ea:	02977263          	bgeu	a4,s1,a0e <malloc+0xb6>
    if(p == freep)
 9ee:	00093703          	ld	a4,0(s2)
 9f2:	853e                	mv	a0,a5
 9f4:	fef719e3          	bne	a4,a5,9e6 <malloc+0x8e>
  p = sbrk(nu * sizeof(Header));
 9f8:	8552                	mv	a0,s4
 9fa:	967ff0ef          	jal	360 <sbrk>
  if(p == SBRK_ERROR)
 9fe:	fd551ce3          	bne	a0,s5,9d6 <malloc+0x7e>
        return 0;
 a02:	4501                	li	a0,0
 a04:	7902                	ld	s2,32(sp)
 a06:	6a42                	ld	s4,16(sp)
 a08:	6aa2                	ld	s5,8(sp)
 a0a:	6b02                	ld	s6,0(sp)
 a0c:	a03d                	j	a3a <malloc+0xe2>
 a0e:	7902                	ld	s2,32(sp)
 a10:	6a42                	ld	s4,16(sp)
 a12:	6aa2                	ld	s5,8(sp)
 a14:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 a16:	fae48de3          	beq	s1,a4,9d0 <malloc+0x78>
        p->s.size -= nunits;
 a1a:	4137073b          	subw	a4,a4,s3
 a1e:	c798                	sw	a4,8(a5)
        p += p->s.size;
 a20:	02071693          	sll	a3,a4,0x20
 a24:	01c6d713          	srl	a4,a3,0x1c
 a28:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 a2a:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 a2e:	00000717          	auipc	a4,0x0
 a32:	5ca73923          	sd	a0,1490(a4) # 1000 <freep>
      return (void*)(p + 1);
 a36:	01078513          	add	a0,a5,16
  }
}
 a3a:	70e2                	ld	ra,56(sp)
 a3c:	7442                	ld	s0,48(sp)
 a3e:	74a2                	ld	s1,40(sp)
 a40:	69e2                	ld	s3,24(sp)
 a42:	6121                	add	sp,sp,64
 a44:	8082                	ret
 a46:	7902                	ld	s2,32(sp)
 a48:	6a42                	ld	s4,16(sp)
 a4a:	6aa2                	ld	s5,8(sp)
 a4c:	6b02                	ld	s6,0(sp)
 a4e:	b7f5                	j	a3a <malloc+0xe2>
