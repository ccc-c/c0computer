
user/_ls:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <fmtname>:
#include "kernel/fs.h"
#include "kernel/fcntl.h"

char*
fmtname(char *path)
{
   0:	7179                	add	sp,sp,-48
   2:	f406                	sd	ra,40(sp)
   4:	f022                	sd	s0,32(sp)
   6:	ec26                	sd	s1,24(sp)
   8:	e84a                	sd	s2,16(sp)
   a:	e44e                	sd	s3,8(sp)
   c:	1800                	add	s0,sp,48
   e:	84aa                	mv	s1,a0
  static char buf[DIRSIZ+1];
  char *p;

  // Find first character after last slash.
  for(p=path+strlen(path); p >= path && *p != '/'; p--)
  10:	2a8000ef          	jal	2b8 <strlen>
  14:	02051793          	sll	a5,a0,0x20
  18:	9381                	srl	a5,a5,0x20
  1a:	97a6                	add	a5,a5,s1
  1c:	02f00693          	li	a3,47
  20:	0097e963          	bltu	a5,s1,32 <fmtname+0x32>
  24:	0007c703          	lbu	a4,0(a5)
  28:	00d70563          	beq	a4,a3,32 <fmtname+0x32>
  2c:	17fd                	add	a5,a5,-1
  2e:	fe97fbe3          	bgeu	a5,s1,24 <fmtname+0x24>
    ;
  p++;
  32:	00178493          	add	s1,a5,1

  // Return blank-padded name.
  if(strlen(p) >= DIRSIZ)
  36:	8526                	mv	a0,s1
  38:	280000ef          	jal	2b8 <strlen>
  3c:	2501                	sext.w	a0,a0
  3e:	47b5                	li	a5,13
  40:	00a7fa63          	bgeu	a5,a0,54 <fmtname+0x54>
    return p;
  memmove(buf, p, strlen(p));
  memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
  return buf;
}
  44:	8526                	mv	a0,s1
  46:	70a2                	ld	ra,40(sp)
  48:	7402                	ld	s0,32(sp)
  4a:	64e2                	ld	s1,24(sp)
  4c:	6942                	ld	s2,16(sp)
  4e:	69a2                	ld	s3,8(sp)
  50:	6145                	add	sp,sp,48
  52:	8082                	ret
  memmove(buf, p, strlen(p));
  54:	8526                	mv	a0,s1
  56:	262000ef          	jal	2b8 <strlen>
  5a:	00001997          	auipc	s3,0x1
  5e:	fb698993          	add	s3,s3,-74 # 1010 <buf.0>
  62:	0005061b          	sext.w	a2,a0
  66:	85a6                	mv	a1,s1
  68:	854e                	mv	a0,s3
  6a:	3b0000ef          	jal	41a <memmove>
  memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
  6e:	8526                	mv	a0,s1
  70:	248000ef          	jal	2b8 <strlen>
  74:	0005091b          	sext.w	s2,a0
  78:	8526                	mv	a0,s1
  7a:	23e000ef          	jal	2b8 <strlen>
  7e:	1902                	sll	s2,s2,0x20
  80:	02095913          	srl	s2,s2,0x20
  84:	4639                	li	a2,14
  86:	9e09                	subw	a2,a2,a0
  88:	02000593          	li	a1,32
  8c:	01298533          	add	a0,s3,s2
  90:	252000ef          	jal	2e2 <memset>
  return buf;
  94:	84ce                	mv	s1,s3
  96:	b77d                	j	44 <fmtname+0x44>

0000000000000098 <ls>:

void
ls(char *path)
{
  98:	d9010113          	add	sp,sp,-624
  9c:	26113423          	sd	ra,616(sp)
  a0:	26813023          	sd	s0,608(sp)
  a4:	24913c23          	sd	s1,600(sp)
  a8:	25213823          	sd	s2,592(sp)
  ac:	25313423          	sd	s3,584(sp)
  b0:	25413023          	sd	s4,576(sp)
  b4:	23513c23          	sd	s5,568(sp)
  b8:	1c80                	add	s0,sp,624
  ba:	892a                	mv	s2,a0
  char buf[512], *p;
  int fd;
  struct dirent de;
  struct stat st;

  if((fd = open(path, O_RDONLY)) < 0){
  bc:	4581                	li	a1,0
  be:	6ca000ef          	jal	788 <open>
  c2:	06054763          	bltz	a0,130 <ls+0x98>
  c6:	84aa                	mv	s1,a0
    fprintf(2, "ls: cannot open %s\n", path);
    return;
  }

  if(fstat(fd, &st) < 0){
  c8:	d9840593          	add	a1,s0,-616
  cc:	6d4000ef          	jal	7a0 <fstat>
  d0:	06054963          	bltz	a0,142 <ls+0xaa>
    fprintf(2, "ls: cannot stat %s\n", path);
    close(fd);
    return;
  }

  switch(st.type){
  d4:	da041783          	lh	a5,-608(s0)
  d8:	4705                	li	a4,1
  da:	08e78063          	beq	a5,a4,15a <ls+0xc2>
  de:	37f9                	addw	a5,a5,-2
  e0:	17c2                	sll	a5,a5,0x30
  e2:	93c1                	srl	a5,a5,0x30
  e4:	02f76263          	bltu	a4,a5,108 <ls+0x70>
  case T_DEVICE:
  case T_FILE:
    printf("%s %d %d %d\n", fmtname(path), st.type, st.ino, (int) st.size);
  e8:	854a                	mv	a0,s2
  ea:	f17ff0ef          	jal	0 <fmtname>
  ee:	85aa                	mv	a1,a0
  f0:	da842703          	lw	a4,-600(s0)
  f4:	d9c42683          	lw	a3,-612(s0)
  f8:	da041603          	lh	a2,-608(s0)
  fc:	00001517          	auipc	a0,0x1
 100:	c8450513          	add	a0,a0,-892 # d80 <malloc+0x11a>
 104:	2af000ef          	jal	bb2 <printf>
      }
      printf("%s %d %d %d\n", fmtname(buf), st.type, st.ino, (int) st.size);
    }
    break;
  }
  close(fd);
 108:	8526                	mv	a0,s1
 10a:	666000ef          	jal	770 <close>
}
 10e:	26813083          	ld	ra,616(sp)
 112:	26013403          	ld	s0,608(sp)
 116:	25813483          	ld	s1,600(sp)
 11a:	25013903          	ld	s2,592(sp)
 11e:	24813983          	ld	s3,584(sp)
 122:	24013a03          	ld	s4,576(sp)
 126:	23813a83          	ld	s5,568(sp)
 12a:	27010113          	add	sp,sp,624
 12e:	8082                	ret
    fprintf(2, "ls: cannot open %s\n", path);
 130:	864a                	mv	a2,s2
 132:	00001597          	auipc	a1,0x1
 136:	c1e58593          	add	a1,a1,-994 # d50 <malloc+0xea>
 13a:	4509                	li	a0,2
 13c:	24d000ef          	jal	b88 <fprintf>
    return;
 140:	b7f9                	j	10e <ls+0x76>
    fprintf(2, "ls: cannot stat %s\n", path);
 142:	864a                	mv	a2,s2
 144:	00001597          	auipc	a1,0x1
 148:	c2458593          	add	a1,a1,-988 # d68 <malloc+0x102>
 14c:	4509                	li	a0,2
 14e:	23b000ef          	jal	b88 <fprintf>
    close(fd);
 152:	8526                	mv	a0,s1
 154:	61c000ef          	jal	770 <close>
    return;
 158:	bf5d                	j	10e <ls+0x76>
    if(strlen(path) + 1 + DIRSIZ + 1 > sizeof buf){
 15a:	854a                	mv	a0,s2
 15c:	15c000ef          	jal	2b8 <strlen>
 160:	2541                	addw	a0,a0,16
 162:	20000793          	li	a5,512
 166:	00a7f963          	bgeu	a5,a0,178 <ls+0xe0>
      printf("ls: path too long\n");
 16a:	00001517          	auipc	a0,0x1
 16e:	c2650513          	add	a0,a0,-986 # d90 <malloc+0x12a>
 172:	241000ef          	jal	bb2 <printf>
      break;
 176:	bf49                	j	108 <ls+0x70>
    strcpy(buf, path);
 178:	85ca                	mv	a1,s2
 17a:	dc040513          	add	a0,s0,-576
 17e:	0f2000ef          	jal	270 <strcpy>
    p = buf+strlen(buf);
 182:	dc040513          	add	a0,s0,-576
 186:	132000ef          	jal	2b8 <strlen>
 18a:	1502                	sll	a0,a0,0x20
 18c:	9101                	srl	a0,a0,0x20
 18e:	dc040793          	add	a5,s0,-576
 192:	00a78933          	add	s2,a5,a0
    *p++ = '/';
 196:	00190993          	add	s3,s2,1
 19a:	02f00793          	li	a5,47
 19e:	00f90023          	sb	a5,0(s2)
      printf("%s %d %d %d\n", fmtname(buf), st.type, st.ino, (int) st.size);
 1a2:	00001a17          	auipc	s4,0x1
 1a6:	bdea0a13          	add	s4,s4,-1058 # d80 <malloc+0x11a>
        printf("ls: cannot stat %s\n", buf);
 1aa:	00001a97          	auipc	s5,0x1
 1ae:	bbea8a93          	add	s5,s5,-1090 # d68 <malloc+0x102>
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
 1b2:	a031                	j	1be <ls+0x126>
        printf("ls: cannot stat %s\n", buf);
 1b4:	dc040593          	add	a1,s0,-576
 1b8:	8556                	mv	a0,s5
 1ba:	1f9000ef          	jal	bb2 <printf>
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
 1be:	4641                	li	a2,16
 1c0:	db040593          	add	a1,s0,-592
 1c4:	8526                	mv	a0,s1
 1c6:	59a000ef          	jal	760 <read>
 1ca:	47c1                	li	a5,16
 1cc:	f2f51ee3          	bne	a0,a5,108 <ls+0x70>
      if(de.inum == 0)
 1d0:	db045783          	lhu	a5,-592(s0)
 1d4:	d7ed                	beqz	a5,1be <ls+0x126>
      memmove(p, de.name, DIRSIZ);
 1d6:	4639                	li	a2,14
 1d8:	db240593          	add	a1,s0,-590
 1dc:	854e                	mv	a0,s3
 1de:	23c000ef          	jal	41a <memmove>
      p[DIRSIZ] = 0;
 1e2:	000907a3          	sb	zero,15(s2)
      if(stat(buf, &st) < 0){
 1e6:	d9840593          	add	a1,s0,-616
 1ea:	dc040513          	add	a0,s0,-576
 1ee:	1aa000ef          	jal	398 <stat>
 1f2:	fc0541e3          	bltz	a0,1b4 <ls+0x11c>
      printf("%s %d %d %d\n", fmtname(buf), st.type, st.ino, (int) st.size);
 1f6:	dc040513          	add	a0,s0,-576
 1fa:	e07ff0ef          	jal	0 <fmtname>
 1fe:	85aa                	mv	a1,a0
 200:	da842703          	lw	a4,-600(s0)
 204:	d9c42683          	lw	a3,-612(s0)
 208:	da041603          	lh	a2,-608(s0)
 20c:	8552                	mv	a0,s4
 20e:	1a5000ef          	jal	bb2 <printf>
 212:	b775                	j	1be <ls+0x126>

0000000000000214 <main>:

int
main(int argc, char *argv[])
{
 214:	1101                	add	sp,sp,-32
 216:	ec06                	sd	ra,24(sp)
 218:	e822                	sd	s0,16(sp)
 21a:	e426                	sd	s1,8(sp)
 21c:	e04a                	sd	s2,0(sp)
 21e:	1000                	add	s0,sp,32
  int i;

  if(argc < 2){
 220:	4785                	li	a5,1
 222:	02a7d563          	bge	a5,a0,24c <main+0x38>
 226:	00858493          	add	s1,a1,8
 22a:	ffe5091b          	addw	s2,a0,-2
 22e:	02091793          	sll	a5,s2,0x20
 232:	01d7d913          	srl	s2,a5,0x1d
 236:	05c1                	add	a1,a1,16
 238:	992e                	add	s2,s2,a1
    ls(".");
    exit(0);
  }
  for(i=1; i<argc; i++)
    ls(argv[i]);
 23a:	6088                	ld	a0,0(s1)
 23c:	e5dff0ef          	jal	98 <ls>
  for(i=1; i<argc; i++)
 240:	04a1                	add	s1,s1,8
 242:	ff249ce3          	bne	s1,s2,23a <main+0x26>
  exit(0);
 246:	4501                	li	a0,0
 248:	500000ef          	jal	748 <exit>
    ls(".");
 24c:	00001517          	auipc	a0,0x1
 250:	b5c50513          	add	a0,a0,-1188 # da8 <malloc+0x142>
 254:	e45ff0ef          	jal	98 <ls>
    exit(0);
 258:	4501                	li	a0,0
 25a:	4ee000ef          	jal	748 <exit>

000000000000025e <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start()
{
 25e:	1141                	add	sp,sp,-16
 260:	e406                	sd	ra,8(sp)
 262:	e022                	sd	s0,0(sp)
 264:	0800                	add	s0,sp,16
  extern int main();
  main();
 266:	fafff0ef          	jal	214 <main>
  exit(0);
 26a:	4501                	li	a0,0
 26c:	4dc000ef          	jal	748 <exit>

0000000000000270 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
 270:	1141                	add	sp,sp,-16
 272:	e422                	sd	s0,8(sp)
 274:	0800                	add	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 276:	87aa                	mv	a5,a0
 278:	0585                	add	a1,a1,1
 27a:	0785                	add	a5,a5,1
 27c:	fff5c703          	lbu	a4,-1(a1)
 280:	fee78fa3          	sb	a4,-1(a5)
 284:	fb75                	bnez	a4,278 <strcpy+0x8>
    ;
  return os;
}
 286:	6422                	ld	s0,8(sp)
 288:	0141                	add	sp,sp,16
 28a:	8082                	ret

000000000000028c <strcmp>:

int
strcmp(const char *p, const char *q)
{
 28c:	1141                	add	sp,sp,-16
 28e:	e422                	sd	s0,8(sp)
 290:	0800                	add	s0,sp,16
  while(*p && *p == *q)
 292:	00054783          	lbu	a5,0(a0)
 296:	cb91                	beqz	a5,2aa <strcmp+0x1e>
 298:	0005c703          	lbu	a4,0(a1)
 29c:	00f71763          	bne	a4,a5,2aa <strcmp+0x1e>
    p++, q++;
 2a0:	0505                	add	a0,a0,1
 2a2:	0585                	add	a1,a1,1
  while(*p && *p == *q)
 2a4:	00054783          	lbu	a5,0(a0)
 2a8:	fbe5                	bnez	a5,298 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 2aa:	0005c503          	lbu	a0,0(a1)
}
 2ae:	40a7853b          	subw	a0,a5,a0
 2b2:	6422                	ld	s0,8(sp)
 2b4:	0141                	add	sp,sp,16
 2b6:	8082                	ret

00000000000002b8 <strlen>:

uint
strlen(const char *s)
{
 2b8:	1141                	add	sp,sp,-16
 2ba:	e422                	sd	s0,8(sp)
 2bc:	0800                	add	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 2be:	00054783          	lbu	a5,0(a0)
 2c2:	cf91                	beqz	a5,2de <strlen+0x26>
 2c4:	0505                	add	a0,a0,1
 2c6:	87aa                	mv	a5,a0
 2c8:	86be                	mv	a3,a5
 2ca:	0785                	add	a5,a5,1
 2cc:	fff7c703          	lbu	a4,-1(a5)
 2d0:	ff65                	bnez	a4,2c8 <strlen+0x10>
 2d2:	40a6853b          	subw	a0,a3,a0
 2d6:	2505                	addw	a0,a0,1
    ;
  return n;
}
 2d8:	6422                	ld	s0,8(sp)
 2da:	0141                	add	sp,sp,16
 2dc:	8082                	ret
  for(n = 0; s[n]; n++)
 2de:	4501                	li	a0,0
 2e0:	bfe5                	j	2d8 <strlen+0x20>

00000000000002e2 <memset>:

void*
memset(void *dst, int c, uint n)
{
 2e2:	1141                	add	sp,sp,-16
 2e4:	e422                	sd	s0,8(sp)
 2e6:	0800                	add	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 2e8:	ca19                	beqz	a2,2fe <memset+0x1c>
 2ea:	87aa                	mv	a5,a0
 2ec:	1602                	sll	a2,a2,0x20
 2ee:	9201                	srl	a2,a2,0x20
 2f0:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 2f4:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 2f8:	0785                	add	a5,a5,1
 2fa:	fee79de3          	bne	a5,a4,2f4 <memset+0x12>
  }
  return dst;
}
 2fe:	6422                	ld	s0,8(sp)
 300:	0141                	add	sp,sp,16
 302:	8082                	ret

0000000000000304 <strchr>:

char*
strchr(const char *s, char c)
{
 304:	1141                	add	sp,sp,-16
 306:	e422                	sd	s0,8(sp)
 308:	0800                	add	s0,sp,16
  for(; *s; s++)
 30a:	00054783          	lbu	a5,0(a0)
 30e:	cb99                	beqz	a5,324 <strchr+0x20>
    if(*s == c)
 310:	00f58763          	beq	a1,a5,31e <strchr+0x1a>
  for(; *s; s++)
 314:	0505                	add	a0,a0,1
 316:	00054783          	lbu	a5,0(a0)
 31a:	fbfd                	bnez	a5,310 <strchr+0xc>
      return (char*)s;
  return 0;
 31c:	4501                	li	a0,0
}
 31e:	6422                	ld	s0,8(sp)
 320:	0141                	add	sp,sp,16
 322:	8082                	ret
  return 0;
 324:	4501                	li	a0,0
 326:	bfe5                	j	31e <strchr+0x1a>

0000000000000328 <gets>:

char*
gets(char *buf, int max)
{
 328:	711d                	add	sp,sp,-96
 32a:	ec86                	sd	ra,88(sp)
 32c:	e8a2                	sd	s0,80(sp)
 32e:	e4a6                	sd	s1,72(sp)
 330:	e0ca                	sd	s2,64(sp)
 332:	fc4e                	sd	s3,56(sp)
 334:	f852                	sd	s4,48(sp)
 336:	f456                	sd	s5,40(sp)
 338:	f05a                	sd	s6,32(sp)
 33a:	ec5e                	sd	s7,24(sp)
 33c:	1080                	add	s0,sp,96
 33e:	8baa                	mv	s7,a0
 340:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 342:	892a                	mv	s2,a0
 344:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 346:	4aa9                	li	s5,10
 348:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 34a:	89a6                	mv	s3,s1
 34c:	2485                	addw	s1,s1,1
 34e:	0344d663          	bge	s1,s4,37a <gets+0x52>
    cc = read(0, &c, 1);
 352:	4605                	li	a2,1
 354:	faf40593          	add	a1,s0,-81
 358:	4501                	li	a0,0
 35a:	406000ef          	jal	760 <read>
    if(cc < 1)
 35e:	00a05e63          	blez	a0,37a <gets+0x52>
    buf[i++] = c;
 362:	faf44783          	lbu	a5,-81(s0)
 366:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 36a:	01578763          	beq	a5,s5,378 <gets+0x50>
 36e:	0905                	add	s2,s2,1
 370:	fd679de3          	bne	a5,s6,34a <gets+0x22>
  for(i=0; i+1 < max; ){
 374:	89a6                	mv	s3,s1
 376:	a011                	j	37a <gets+0x52>
 378:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 37a:	99de                	add	s3,s3,s7
 37c:	00098023          	sb	zero,0(s3)
  return buf;
}
 380:	855e                	mv	a0,s7
 382:	60e6                	ld	ra,88(sp)
 384:	6446                	ld	s0,80(sp)
 386:	64a6                	ld	s1,72(sp)
 388:	6906                	ld	s2,64(sp)
 38a:	79e2                	ld	s3,56(sp)
 38c:	7a42                	ld	s4,48(sp)
 38e:	7aa2                	ld	s5,40(sp)
 390:	7b02                	ld	s6,32(sp)
 392:	6be2                	ld	s7,24(sp)
 394:	6125                	add	sp,sp,96
 396:	8082                	ret

0000000000000398 <stat>:

int
stat(const char *n, struct stat *st)
{
 398:	1101                	add	sp,sp,-32
 39a:	ec06                	sd	ra,24(sp)
 39c:	e822                	sd	s0,16(sp)
 39e:	e426                	sd	s1,8(sp)
 3a0:	e04a                	sd	s2,0(sp)
 3a2:	1000                	add	s0,sp,32
 3a4:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 3a6:	4581                	li	a1,0
 3a8:	3e0000ef          	jal	788 <open>
  if(fd < 0)
 3ac:	02054163          	bltz	a0,3ce <stat+0x36>
 3b0:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 3b2:	85ca                	mv	a1,s2
 3b4:	3ec000ef          	jal	7a0 <fstat>
 3b8:	892a                	mv	s2,a0
  close(fd);
 3ba:	8526                	mv	a0,s1
 3bc:	3b4000ef          	jal	770 <close>
  return r;
}
 3c0:	854a                	mv	a0,s2
 3c2:	60e2                	ld	ra,24(sp)
 3c4:	6442                	ld	s0,16(sp)
 3c6:	64a2                	ld	s1,8(sp)
 3c8:	6902                	ld	s2,0(sp)
 3ca:	6105                	add	sp,sp,32
 3cc:	8082                	ret
    return -1;
 3ce:	597d                	li	s2,-1
 3d0:	bfc5                	j	3c0 <stat+0x28>

00000000000003d2 <atoi>:

int
atoi(const char *s)
{
 3d2:	1141                	add	sp,sp,-16
 3d4:	e422                	sd	s0,8(sp)
 3d6:	0800                	add	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 3d8:	00054683          	lbu	a3,0(a0)
 3dc:	fd06879b          	addw	a5,a3,-48
 3e0:	0ff7f793          	zext.b	a5,a5
 3e4:	4625                	li	a2,9
 3e6:	02f66863          	bltu	a2,a5,416 <atoi+0x44>
 3ea:	872a                	mv	a4,a0
  n = 0;
 3ec:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 3ee:	0705                	add	a4,a4,1
 3f0:	0025179b          	sllw	a5,a0,0x2
 3f4:	9fa9                	addw	a5,a5,a0
 3f6:	0017979b          	sllw	a5,a5,0x1
 3fa:	9fb5                	addw	a5,a5,a3
 3fc:	fd07851b          	addw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 400:	00074683          	lbu	a3,0(a4)
 404:	fd06879b          	addw	a5,a3,-48
 408:	0ff7f793          	zext.b	a5,a5
 40c:	fef671e3          	bgeu	a2,a5,3ee <atoi+0x1c>
  return n;
}
 410:	6422                	ld	s0,8(sp)
 412:	0141                	add	sp,sp,16
 414:	8082                	ret
  n = 0;
 416:	4501                	li	a0,0
 418:	bfe5                	j	410 <atoi+0x3e>

000000000000041a <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 41a:	1141                	add	sp,sp,-16
 41c:	e422                	sd	s0,8(sp)
 41e:	0800                	add	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 420:	02b57463          	bgeu	a0,a1,448 <memmove+0x2e>
    while(n-- > 0)
 424:	00c05f63          	blez	a2,442 <memmove+0x28>
 428:	1602                	sll	a2,a2,0x20
 42a:	9201                	srl	a2,a2,0x20
 42c:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 430:	872a                	mv	a4,a0
      *dst++ = *src++;
 432:	0585                	add	a1,a1,1
 434:	0705                	add	a4,a4,1
 436:	fff5c683          	lbu	a3,-1(a1)
 43a:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 43e:	fee79ae3          	bne	a5,a4,432 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 442:	6422                	ld	s0,8(sp)
 444:	0141                	add	sp,sp,16
 446:	8082                	ret
    dst += n;
 448:	00c50733          	add	a4,a0,a2
    src += n;
 44c:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 44e:	fec05ae3          	blez	a2,442 <memmove+0x28>
 452:	fff6079b          	addw	a5,a2,-1
 456:	1782                	sll	a5,a5,0x20
 458:	9381                	srl	a5,a5,0x20
 45a:	fff7c793          	not	a5,a5
 45e:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 460:	15fd                	add	a1,a1,-1
 462:	177d                	add	a4,a4,-1
 464:	0005c683          	lbu	a3,0(a1)
 468:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 46c:	fee79ae3          	bne	a5,a4,460 <memmove+0x46>
 470:	bfc9                	j	442 <memmove+0x28>

0000000000000472 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 472:	1141                	add	sp,sp,-16
 474:	e422                	sd	s0,8(sp)
 476:	0800                	add	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 478:	ca05                	beqz	a2,4a8 <memcmp+0x36>
 47a:	fff6069b          	addw	a3,a2,-1
 47e:	1682                	sll	a3,a3,0x20
 480:	9281                	srl	a3,a3,0x20
 482:	0685                	add	a3,a3,1
 484:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 486:	00054783          	lbu	a5,0(a0)
 48a:	0005c703          	lbu	a4,0(a1)
 48e:	00e79863          	bne	a5,a4,49e <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 492:	0505                	add	a0,a0,1
    p2++;
 494:	0585                	add	a1,a1,1
  while (n-- > 0) {
 496:	fed518e3          	bne	a0,a3,486 <memcmp+0x14>
  }
  return 0;
 49a:	4501                	li	a0,0
 49c:	a019                	j	4a2 <memcmp+0x30>
      return *p1 - *p2;
 49e:	40e7853b          	subw	a0,a5,a4
}
 4a2:	6422                	ld	s0,8(sp)
 4a4:	0141                	add	sp,sp,16
 4a6:	8082                	ret
  return 0;
 4a8:	4501                	li	a0,0
 4aa:	bfe5                	j	4a2 <memcmp+0x30>

00000000000004ac <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 4ac:	1141                	add	sp,sp,-16
 4ae:	e406                	sd	ra,8(sp)
 4b0:	e022                	sd	s0,0(sp)
 4b2:	0800                	add	s0,sp,16
  return memmove(dst, src, n);
 4b4:	f67ff0ef          	jal	41a <memmove>
}
 4b8:	60a2                	ld	ra,8(sp)
 4ba:	6402                	ld	s0,0(sp)
 4bc:	0141                	add	sp,sp,16
 4be:	8082                	ret

00000000000004c0 <htons>:
    return (v & 0x000000ff) << 24 | (v & 0x0000ff00) << 8 | (v & 0x00ff0000) >> 8 | (v & 0xff000000) >> 24;
}

uint16_t
htons(uint16_t h)
{
 4c0:	1141                	add	sp,sp,-16
 4c2:	e422                	sd	s0,8(sp)
 4c4:	0800                	add	s0,sp,16
    if (!endian) {
 4c6:	00001797          	auipc	a5,0x1
 4ca:	b3a7a783          	lw	a5,-1222(a5) # 1000 <endian>
 4ce:	e385                	bnez	a5,4ee <htons+0x2e>
        endian = byteorder();
 4d0:	4d200793          	li	a5,1234
 4d4:	00001717          	auipc	a4,0x1
 4d8:	b2f72623          	sw	a5,-1236(a4) # 1000 <endian>
    return (v & 0x00ff) << 8 | (v & 0xff00 ) >> 8;
 4dc:	0085579b          	srlw	a5,a0,0x8
 4e0:	0085151b          	sllw	a0,a0,0x8
 4e4:	8fc9                	or	a5,a5,a0
 4e6:	03079513          	sll	a0,a5,0x30
 4ea:	9141                	srl	a0,a0,0x30
 4ec:	a029                	j	4f6 <htons+0x36>
    }
    return endian == __LITTLE_ENDIAN ? byteswap16(h) : h;
 4ee:	4d200713          	li	a4,1234
 4f2:	fee785e3          	beq	a5,a4,4dc <htons+0x1c>
}
 4f6:	6422                	ld	s0,8(sp)
 4f8:	0141                	add	sp,sp,16
 4fa:	8082                	ret

00000000000004fc <ntohs>:

uint16_t
ntohs(uint16_t n)
{
 4fc:	1141                	add	sp,sp,-16
 4fe:	e422                	sd	s0,8(sp)
 500:	0800                	add	s0,sp,16
    if (!endian) {
 502:	00001797          	auipc	a5,0x1
 506:	afe7a783          	lw	a5,-1282(a5) # 1000 <endian>
 50a:	e385                	bnez	a5,52a <ntohs+0x2e>
        endian = byteorder();
 50c:	4d200793          	li	a5,1234
 510:	00001717          	auipc	a4,0x1
 514:	aef72823          	sw	a5,-1296(a4) # 1000 <endian>
    return (v & 0x00ff) << 8 | (v & 0xff00 ) >> 8;
 518:	0085579b          	srlw	a5,a0,0x8
 51c:	0085151b          	sllw	a0,a0,0x8
 520:	8fc9                	or	a5,a5,a0
 522:	03079513          	sll	a0,a5,0x30
 526:	9141                	srl	a0,a0,0x30
 528:	a029                	j	532 <ntohs+0x36>
    }
    return endian == __LITTLE_ENDIAN ? byteswap16(n) : n;
 52a:	4d200713          	li	a4,1234
 52e:	fee785e3          	beq	a5,a4,518 <ntohs+0x1c>
}
 532:	6422                	ld	s0,8(sp)
 534:	0141                	add	sp,sp,16
 536:	8082                	ret

0000000000000538 <htonl>:

uint32_t
htonl(uint32_t h)
{
 538:	1141                	add	sp,sp,-16
 53a:	e422                	sd	s0,8(sp)
 53c:	0800                	add	s0,sp,16
    if (!endian) {
 53e:	00001797          	auipc	a5,0x1
 542:	ac27a783          	lw	a5,-1342(a5) # 1000 <endian>
 546:	ef85                	bnez	a5,57e <htonl+0x46>
        endian = byteorder();
 548:	4d200793          	li	a5,1234
 54c:	00001717          	auipc	a4,0x1
 550:	aaf72a23          	sw	a5,-1356(a4) # 1000 <endian>
    return (v & 0x000000ff) << 24 | (v & 0x0000ff00) << 8 | (v & 0x00ff0000) >> 8 | (v & 0xff000000) >> 24;
 554:	0185179b          	sllw	a5,a0,0x18
 558:	0185571b          	srlw	a4,a0,0x18
 55c:	8fd9                	or	a5,a5,a4
 55e:	0085171b          	sllw	a4,a0,0x8
 562:	00ff06b7          	lui	a3,0xff0
 566:	8f75                	and	a4,a4,a3
 568:	8fd9                	or	a5,a5,a4
 56a:	0085551b          	srlw	a0,a0,0x8
 56e:	6741                	lui	a4,0x10
 570:	f0070713          	add	a4,a4,-256 # ff00 <base+0xeee0>
 574:	8d79                	and	a0,a0,a4
 576:	8fc9                	or	a5,a5,a0
 578:	0007851b          	sext.w	a0,a5
 57c:	a029                	j	586 <htonl+0x4e>
    }
    return endian == __LITTLE_ENDIAN ? byteswap32(h) : h;
 57e:	4d200713          	li	a4,1234
 582:	fce789e3          	beq	a5,a4,554 <htonl+0x1c>
}
 586:	6422                	ld	s0,8(sp)
 588:	0141                	add	sp,sp,16
 58a:	8082                	ret

000000000000058c <ntohl>:

uint32_t
ntohl(uint32_t n)
{
 58c:	1141                	add	sp,sp,-16
 58e:	e422                	sd	s0,8(sp)
 590:	0800                	add	s0,sp,16
    if (!endian) {
 592:	00001797          	auipc	a5,0x1
 596:	a6e7a783          	lw	a5,-1426(a5) # 1000 <endian>
 59a:	ef85                	bnez	a5,5d2 <ntohl+0x46>
        endian = byteorder();
 59c:	4d200793          	li	a5,1234
 5a0:	00001717          	auipc	a4,0x1
 5a4:	a6f72023          	sw	a5,-1440(a4) # 1000 <endian>
    return (v & 0x000000ff) << 24 | (v & 0x0000ff00) << 8 | (v & 0x00ff0000) >> 8 | (v & 0xff000000) >> 24;
 5a8:	0185179b          	sllw	a5,a0,0x18
 5ac:	0185571b          	srlw	a4,a0,0x18
 5b0:	8fd9                	or	a5,a5,a4
 5b2:	0085171b          	sllw	a4,a0,0x8
 5b6:	00ff06b7          	lui	a3,0xff0
 5ba:	8f75                	and	a4,a4,a3
 5bc:	8fd9                	or	a5,a5,a4
 5be:	0085551b          	srlw	a0,a0,0x8
 5c2:	6741                	lui	a4,0x10
 5c4:	f0070713          	add	a4,a4,-256 # ff00 <base+0xeee0>
 5c8:	8d79                	and	a0,a0,a4
 5ca:	8fc9                	or	a5,a5,a0
 5cc:	0007851b          	sext.w	a0,a5
 5d0:	a029                	j	5da <ntohl+0x4e>
    }
    return endian == __LITTLE_ENDIAN ? byteswap32(n) : n;
 5d2:	4d200713          	li	a4,1234
 5d6:	fce789e3          	beq	a5,a4,5a8 <ntohl+0x1c>
}
 5da:	6422                	ld	s0,8(sp)
 5dc:	0141                	add	sp,sp,16
 5de:	8082                	ret

00000000000005e0 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
 5e0:	1141                	add	sp,sp,-16
 5e2:	e422                	sd	s0,8(sp)
 5e4:	0800                	add	s0,sp,16
 5e6:	872a                	mv	a4,a0
    int neg = 0;
    long val = 0;

    // gobble initial whitespace
    while (*s == ' ' || *s == '\t')
 5e8:	02000693          	li	a3,32
 5ec:	4525                	li	a0,9
 5ee:	a011                	j	5f2 <strtol+0x12>
        s++;
 5f0:	0705                	add	a4,a4,1
    while (*s == ' ' || *s == '\t')
 5f2:	00074783          	lbu	a5,0(a4)
 5f6:	fed78de3          	beq	a5,a3,5f0 <strtol+0x10>
 5fa:	fea78be3          	beq	a5,a0,5f0 <strtol+0x10>

    // plus/minus sign
    if (*s == '+')
 5fe:	02b00693          	li	a3,43
 602:	02d78663          	beq	a5,a3,62e <strtol+0x4e>
        s++;
    else if (*s == '-')
 606:	02d00693          	li	a3,45
    int neg = 0;
 60a:	4301                	li	t1,0
    else if (*s == '-')
 60c:	02d78463          	beq	a5,a3,634 <strtol+0x54>
        s++, neg = 1;

    // hex or octal base prefix
    if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
 610:	fef67793          	and	a5,a2,-17
 614:	eb89                	bnez	a5,626 <strtol+0x46>
 616:	00074683          	lbu	a3,0(a4)
 61a:	03000793          	li	a5,48
 61e:	00f68e63          	beq	a3,a5,63a <strtol+0x5a>
        s += 2, base = 16;
    else if (base == 0 && s[0] == '0')
 622:	e211                	bnez	a2,626 <strtol+0x46>
        s++, base = 8;
    else if (base == 0)
        base = 10;
 624:	4629                	li	a2,10
 626:	4501                	li	a0,0

    // digits
    while (1) {
        int dig;

        if (*s >= '0' && *s <= '9')
 628:	4825                	li	a6,9
            dig = *s - '0';
        else if (*s >= 'a' && *s <= 'z')
 62a:	48e5                	li	a7,25
 62c:	a825                	j	664 <strtol+0x84>
        s++;
 62e:	0705                	add	a4,a4,1
    int neg = 0;
 630:	4301                	li	t1,0
 632:	bff9                	j	610 <strtol+0x30>
        s++, neg = 1;
 634:	0705                	add	a4,a4,1
 636:	4305                	li	t1,1
 638:	bfe1                	j	610 <strtol+0x30>
    if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
 63a:	00174683          	lbu	a3,1(a4)
 63e:	07800793          	li	a5,120
 642:	00f68663          	beq	a3,a5,64e <strtol+0x6e>
    else if (base == 0 && s[0] == '0')
 646:	f265                	bnez	a2,626 <strtol+0x46>
        s++, base = 8;
 648:	0705                	add	a4,a4,1
 64a:	4621                	li	a2,8
 64c:	bfe9                	j	626 <strtol+0x46>
        s += 2, base = 16;
 64e:	0709                	add	a4,a4,2
 650:	4641                	li	a2,16
 652:	bfd1                	j	626 <strtol+0x46>
            dig = *s - '0';
 654:	fd07879b          	addw	a5,a5,-48
            dig = *s - 'a' + 10;
        else if (*s >= 'A' && *s <= 'Z')
            dig = *s - 'A' + 10;
        else
            break;
        if (dig >= base)
 658:	04c7d063          	bge	a5,a2,698 <strtol+0xb8>
            break;
        s++, val = (val * base) + dig;
 65c:	0705                	add	a4,a4,1
 65e:	02a60533          	mul	a0,a2,a0
 662:	953e                	add	a0,a0,a5
        if (*s >= '0' && *s <= '9')
 664:	00074783          	lbu	a5,0(a4)
 668:	fd07869b          	addw	a3,a5,-48
 66c:	0ff6f693          	zext.b	a3,a3
 670:	fed872e3          	bgeu	a6,a3,654 <strtol+0x74>
        else if (*s >= 'a' && *s <= 'z')
 674:	f9f7869b          	addw	a3,a5,-97
 678:	0ff6f693          	zext.b	a3,a3
 67c:	00d8e563          	bltu	a7,a3,686 <strtol+0xa6>
            dig = *s - 'a' + 10;
 680:	fa97879b          	addw	a5,a5,-87
 684:	bfd1                	j	658 <strtol+0x78>
        else if (*s >= 'A' && *s <= 'Z')
 686:	fbf7869b          	addw	a3,a5,-65
 68a:	0ff6f693          	zext.b	a3,a3
 68e:	00d8e563          	bltu	a7,a3,698 <strtol+0xb8>
            dig = *s - 'A' + 10;
 692:	fc97879b          	addw	a5,a5,-55
 696:	b7c9                	j	658 <strtol+0x78>
        // we don't properly detect overflow!
    }

    if (endptr)
 698:	c191                	beqz	a1,69c <strtol+0xbc>
        *endptr = (char *) s;
 69a:	e198                	sd	a4,0(a1)
    return (neg ? -val : val);
 69c:	00030463          	beqz	t1,6a4 <strtol+0xc4>
 6a0:	40a00533          	neg	a0,a0
}
 6a4:	6422                	ld	s0,8(sp)
 6a6:	0141                	add	sp,sp,16
 6a8:	8082                	ret

00000000000006aa <inet_pton>:
inet_pton (int family, const char *p, void *n) {
    char *sp, *ep;
    int idx;
    long ret;

    if (family != AF_INET) {
 6aa:	4785                	li	a5,1
 6ac:	08f51263          	bne	a0,a5,730 <inet_pton+0x86>
inet_pton (int family, const char *p, void *n) {
 6b0:	715d                	add	sp,sp,-80
 6b2:	e486                	sd	ra,72(sp)
 6b4:	e0a2                	sd	s0,64(sp)
 6b6:	fc26                	sd	s1,56(sp)
 6b8:	f84a                	sd	s2,48(sp)
 6ba:	f44e                	sd	s3,40(sp)
 6bc:	f052                	sd	s4,32(sp)
 6be:	ec56                	sd	s5,24(sp)
 6c0:	e85a                	sd	s6,16(sp)
 6c2:	0880                	add	s0,sp,80
 6c4:	892e                	mv	s2,a1
 6c6:	89b2                	mv	s3,a2
 6c8:	4481                	li	s1,0
        return -1;
    }
    sp = (char *)p;
    for (idx = 0; idx < 4; idx++) {
        ret = strtol(sp, &ep, 10);
        if (ret < 0 || ret > 255) {
 6ca:	0ff00a13          	li	s4,255
            return -1;
        }
        if (ep == sp) {
            return -1;
        }
        if ((idx == 3 && *ep != '\0') || (idx != 3 && *ep != '.')) {
 6ce:	4a8d                	li	s5,3
 6d0:	02e00b13          	li	s6,46
 6d4:	a815                	j	708 <inet_pton+0x5e>
 6d6:	0007c783          	lbu	a5,0(a5)
 6da:	e3ad                	bnez	a5,73c <inet_pton+0x92>
            return -1;
        }
        ((uint8_t *)n)[idx] = ret;
 6dc:	2481                	sext.w	s1,s1
 6de:	99a6                	add	s3,s3,s1
 6e0:	00a98023          	sb	a0,0(s3)
        sp = ep + 1;
    }
    return 0;
 6e4:	4501                	li	a0,0
}
 6e6:	60a6                	ld	ra,72(sp)
 6e8:	6406                	ld	s0,64(sp)
 6ea:	74e2                	ld	s1,56(sp)
 6ec:	7942                	ld	s2,48(sp)
 6ee:	79a2                	ld	s3,40(sp)
 6f0:	7a02                	ld	s4,32(sp)
 6f2:	6ae2                	ld	s5,24(sp)
 6f4:	6b42                	ld	s6,16(sp)
 6f6:	6161                	add	sp,sp,80
 6f8:	8082                	ret
        ((uint8_t *)n)[idx] = ret;
 6fa:	00998733          	add	a4,s3,s1
 6fe:	00a70023          	sb	a0,0(a4)
        sp = ep + 1;
 702:	00178913          	add	s2,a5,1
    for (idx = 0; idx < 4; idx++) {
 706:	0485                	add	s1,s1,1
        ret = strtol(sp, &ep, 10);
 708:	4629                	li	a2,10
 70a:	fb840593          	add	a1,s0,-72
 70e:	854a                	mv	a0,s2
 710:	ed1ff0ef          	jal	5e0 <strtol>
        if (ret < 0 || ret > 255) {
 714:	02aa6063          	bltu	s4,a0,734 <inet_pton+0x8a>
        if (ep == sp) {
 718:	fb843783          	ld	a5,-72(s0)
 71c:	01278e63          	beq	a5,s2,738 <inet_pton+0x8e>
        if ((idx == 3 && *ep != '\0') || (idx != 3 && *ep != '.')) {
 720:	fb548be3          	beq	s1,s5,6d6 <inet_pton+0x2c>
 724:	0007c703          	lbu	a4,0(a5)
 728:	fd6709e3          	beq	a4,s6,6fa <inet_pton+0x50>
            return -1;
 72c:	557d                	li	a0,-1
 72e:	bf65                	j	6e6 <inet_pton+0x3c>
        return -1;
 730:	557d                	li	a0,-1
}
 732:	8082                	ret
            return -1;
 734:	557d                	li	a0,-1
 736:	bf45                	j	6e6 <inet_pton+0x3c>
            return -1;
 738:	557d                	li	a0,-1
 73a:	b775                	j	6e6 <inet_pton+0x3c>
            return -1;
 73c:	557d                	li	a0,-1
 73e:	b765                	j	6e6 <inet_pton+0x3c>

0000000000000740 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 740:	4885                	li	a7,1
 ecall
 742:	00000073          	ecall
 ret
 746:	8082                	ret

0000000000000748 <exit>:
.global exit
exit:
 li a7, SYS_exit
 748:	4889                	li	a7,2
 ecall
 74a:	00000073          	ecall
 ret
 74e:	8082                	ret

0000000000000750 <wait>:
.global wait
wait:
 li a7, SYS_wait
 750:	488d                	li	a7,3
 ecall
 752:	00000073          	ecall
 ret
 756:	8082                	ret

0000000000000758 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 758:	4891                	li	a7,4
 ecall
 75a:	00000073          	ecall
 ret
 75e:	8082                	ret

0000000000000760 <read>:
.global read
read:
 li a7, SYS_read
 760:	4895                	li	a7,5
 ecall
 762:	00000073          	ecall
 ret
 766:	8082                	ret

0000000000000768 <write>:
.global write
write:
 li a7, SYS_write
 768:	48c1                	li	a7,16
 ecall
 76a:	00000073          	ecall
 ret
 76e:	8082                	ret

0000000000000770 <close>:
.global close
close:
 li a7, SYS_close
 770:	48d5                	li	a7,21
 ecall
 772:	00000073          	ecall
 ret
 776:	8082                	ret

0000000000000778 <kill>:
.global kill
kill:
 li a7, SYS_kill
 778:	4899                	li	a7,6
 ecall
 77a:	00000073          	ecall
 ret
 77e:	8082                	ret

0000000000000780 <exec>:
.global exec
exec:
 li a7, SYS_exec
 780:	489d                	li	a7,7
 ecall
 782:	00000073          	ecall
 ret
 786:	8082                	ret

0000000000000788 <open>:
.global open
open:
 li a7, SYS_open
 788:	48bd                	li	a7,15
 ecall
 78a:	00000073          	ecall
 ret
 78e:	8082                	ret

0000000000000790 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 790:	48c5                	li	a7,17
 ecall
 792:	00000073          	ecall
 ret
 796:	8082                	ret

0000000000000798 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 798:	48c9                	li	a7,18
 ecall
 79a:	00000073          	ecall
 ret
 79e:	8082                	ret

00000000000007a0 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 7a0:	48a1                	li	a7,8
 ecall
 7a2:	00000073          	ecall
 ret
 7a6:	8082                	ret

00000000000007a8 <link>:
.global link
link:
 li a7, SYS_link
 7a8:	48cd                	li	a7,19
 ecall
 7aa:	00000073          	ecall
 ret
 7ae:	8082                	ret

00000000000007b0 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 7b0:	48d1                	li	a7,20
 ecall
 7b2:	00000073          	ecall
 ret
 7b6:	8082                	ret

00000000000007b8 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 7b8:	48a5                	li	a7,9
 ecall
 7ba:	00000073          	ecall
 ret
 7be:	8082                	ret

00000000000007c0 <dup>:
.global dup
dup:
 li a7, SYS_dup
 7c0:	48a9                	li	a7,10
 ecall
 7c2:	00000073          	ecall
 ret
 7c6:	8082                	ret

00000000000007c8 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 7c8:	48ad                	li	a7,11
 ecall
 7ca:	00000073          	ecall
 ret
 7ce:	8082                	ret

00000000000007d0 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 7d0:	48b1                	li	a7,12
 ecall
 7d2:	00000073          	ecall
 ret
 7d6:	8082                	ret

00000000000007d8 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 7d8:	48b5                	li	a7,13
 ecall
 7da:	00000073          	ecall
 ret
 7de:	8082                	ret

00000000000007e0 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 7e0:	48b9                	li	a7,14
 ecall
 7e2:	00000073          	ecall
 ret
 7e6:	8082                	ret

00000000000007e8 <socket>:
.global socket
socket:
 li a7, SYS_socket
 7e8:	48d9                	li	a7,22
 ecall
 7ea:	00000073          	ecall
 ret
 7ee:	8082                	ret

00000000000007f0 <bind>:
.global bind
bind:
 li a7, SYS_bind
 7f0:	48dd                	li	a7,23
 ecall
 7f2:	00000073          	ecall
 ret
 7f6:	8082                	ret

00000000000007f8 <recvfrom>:
.global recvfrom
recvfrom:
 li a7, SYS_recvfrom
 7f8:	48e1                	li	a7,24
 ecall
 7fa:	00000073          	ecall
 ret
 7fe:	8082                	ret

0000000000000800 <sendto>:
.global sendto
sendto:
 li a7, SYS_sendto
 800:	48e5                	li	a7,25
 ecall
 802:	00000073          	ecall
 ret
 806:	8082                	ret

0000000000000808 <connect>:
.global connect
connect:
 li a7, SYS_connect
 808:	48e9                	li	a7,26
 ecall
 80a:	00000073          	ecall
 ret
 80e:	8082                	ret

0000000000000810 <listen>:
.global listen
listen:
 li a7, SYS_listen
 810:	48ed                	li	a7,27
 ecall
 812:	00000073          	ecall
 ret
 816:	8082                	ret

0000000000000818 <accept>:
.global accept
accept:
 li a7, SYS_accept
 818:	48f1                	li	a7,28
 ecall
 81a:	00000073          	ecall
 ret
 81e:	8082                	ret

0000000000000820 <recv>:
.global recv
recv:
 li a7, SYS_recv
 820:	48f5                	li	a7,29
 ecall
 822:	00000073          	ecall
 ret
 826:	8082                	ret

0000000000000828 <send>:
.global send
send:
 li a7, SYS_send
 828:	48f9                	li	a7,30
 ecall
 82a:	00000073          	ecall
 ret
 82e:	8082                	ret

0000000000000830 <ioctl>:
.global ioctl
ioctl:
 li a7, SYS_ioctl
 830:	48fd                	li	a7,31
 ecall
 832:	00000073          	ecall
 ret
 836:	8082                	ret

0000000000000838 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 838:	1101                	add	sp,sp,-32
 83a:	ec06                	sd	ra,24(sp)
 83c:	e822                	sd	s0,16(sp)
 83e:	1000                	add	s0,sp,32
 840:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 844:	4605                	li	a2,1
 846:	fef40593          	add	a1,s0,-17
 84a:	f1fff0ef          	jal	768 <write>
}
 84e:	60e2                	ld	ra,24(sp)
 850:	6442                	ld	s0,16(sp)
 852:	6105                	add	sp,sp,32
 854:	8082                	ret

0000000000000856 <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
 856:	715d                	add	sp,sp,-80
 858:	e486                	sd	ra,72(sp)
 85a:	e0a2                	sd	s0,64(sp)
 85c:	fc26                	sd	s1,56(sp)
 85e:	f84a                	sd	s2,48(sp)
 860:	f44e                	sd	s3,40(sp)
 862:	0880                	add	s0,sp,80
 864:	84aa                	mv	s1,a0
  char buf[20];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 866:	c299                	beqz	a3,86c <printint+0x16>
 868:	0805c763          	bltz	a1,8f6 <printint+0xa0>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 86c:	2581                	sext.w	a1,a1
  neg = 0;
 86e:	4881                	li	a7,0
 870:	fb840693          	add	a3,s0,-72
  }

  i = 0;
 874:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 876:	2601                	sext.w	a2,a2
 878:	00000517          	auipc	a0,0x0
 87c:	54050513          	add	a0,a0,1344 # db8 <digits>
 880:	883a                	mv	a6,a4
 882:	2705                	addw	a4,a4,1
 884:	02c5f7bb          	remuw	a5,a1,a2
 888:	1782                	sll	a5,a5,0x20
 88a:	9381                	srl	a5,a5,0x20
 88c:	97aa                	add	a5,a5,a0
 88e:	0007c783          	lbu	a5,0(a5)
 892:	00f68023          	sb	a5,0(a3) # ff0000 <base+0xfeefe0>
  }while((x /= base) != 0);
 896:	0005879b          	sext.w	a5,a1
 89a:	02c5d5bb          	divuw	a1,a1,a2
 89e:	0685                	add	a3,a3,1
 8a0:	fec7f0e3          	bgeu	a5,a2,880 <printint+0x2a>
  if(neg)
 8a4:	00088c63          	beqz	a7,8bc <printint+0x66>
    buf[i++] = '-';
 8a8:	fd070793          	add	a5,a4,-48
 8ac:	00878733          	add	a4,a5,s0
 8b0:	02d00793          	li	a5,45
 8b4:	fef70423          	sb	a5,-24(a4)
 8b8:	0028071b          	addw	a4,a6,2

  while(--i >= 0)
 8bc:	02e05663          	blez	a4,8e8 <printint+0x92>
 8c0:	fb840793          	add	a5,s0,-72
 8c4:	00e78933          	add	s2,a5,a4
 8c8:	fff78993          	add	s3,a5,-1
 8cc:	99ba                	add	s3,s3,a4
 8ce:	377d                	addw	a4,a4,-1
 8d0:	1702                	sll	a4,a4,0x20
 8d2:	9301                	srl	a4,a4,0x20
 8d4:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 8d8:	fff94583          	lbu	a1,-1(s2)
 8dc:	8526                	mv	a0,s1
 8de:	f5bff0ef          	jal	838 <putc>
  while(--i >= 0)
 8e2:	197d                	add	s2,s2,-1
 8e4:	ff391ae3          	bne	s2,s3,8d8 <printint+0x82>
}
 8e8:	60a6                	ld	ra,72(sp)
 8ea:	6406                	ld	s0,64(sp)
 8ec:	74e2                	ld	s1,56(sp)
 8ee:	7942                	ld	s2,48(sp)
 8f0:	79a2                	ld	s3,40(sp)
 8f2:	6161                	add	sp,sp,80
 8f4:	8082                	ret
    x = -xx;
 8f6:	40b005bb          	negw	a1,a1
    neg = 1;
 8fa:	4885                	li	a7,1
    x = -xx;
 8fc:	bf95                	j	870 <printint+0x1a>

00000000000008fe <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 8fe:	711d                	add	sp,sp,-96
 900:	ec86                	sd	ra,88(sp)
 902:	e8a2                	sd	s0,80(sp)
 904:	e4a6                	sd	s1,72(sp)
 906:	e0ca                	sd	s2,64(sp)
 908:	fc4e                	sd	s3,56(sp)
 90a:	f852                	sd	s4,48(sp)
 90c:	f456                	sd	s5,40(sp)
 90e:	f05a                	sd	s6,32(sp)
 910:	ec5e                	sd	s7,24(sp)
 912:	e862                	sd	s8,16(sp)
 914:	e466                	sd	s9,8(sp)
 916:	e06a                	sd	s10,0(sp)
 918:	1080                	add	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 91a:	0005c903          	lbu	s2,0(a1)
 91e:	24090763          	beqz	s2,b6c <vprintf+0x26e>
 922:	8b2a                	mv	s6,a0
 924:	8a2e                	mv	s4,a1
 926:	8bb2                	mv	s7,a2
  state = 0;
 928:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
 92a:	4481                	li	s1,0
 92c:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
 92e:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
 932:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
 936:	06c00c93          	li	s9,108
 93a:	a005                	j	95a <vprintf+0x5c>
        putc(fd, c0);
 93c:	85ca                	mv	a1,s2
 93e:	855a                	mv	a0,s6
 940:	ef9ff0ef          	jal	838 <putc>
 944:	a019                	j	94a <vprintf+0x4c>
    } else if(state == '%'){
 946:	03598263          	beq	s3,s5,96a <vprintf+0x6c>
  for(i = 0; fmt[i]; i++){
 94a:	2485                	addw	s1,s1,1
 94c:	8726                	mv	a4,s1
 94e:	009a07b3          	add	a5,s4,s1
 952:	0007c903          	lbu	s2,0(a5)
 956:	20090b63          	beqz	s2,b6c <vprintf+0x26e>
    c0 = fmt[i] & 0xff;
 95a:	0009079b          	sext.w	a5,s2
    if(state == 0){
 95e:	fe0994e3          	bnez	s3,946 <vprintf+0x48>
      if(c0 == '%'){
 962:	fd579de3          	bne	a5,s5,93c <vprintf+0x3e>
        state = '%';
 966:	89be                	mv	s3,a5
 968:	b7cd                	j	94a <vprintf+0x4c>
      if(c0) c1 = fmt[i+1] & 0xff;
 96a:	c7c9                	beqz	a5,9f4 <vprintf+0xf6>
 96c:	00ea06b3          	add	a3,s4,a4
 970:	0016c683          	lbu	a3,1(a3)
      c1 = c2 = 0;
 974:	8636                	mv	a2,a3
      if(c1) c2 = fmt[i+2] & 0xff;
 976:	c681                	beqz	a3,97e <vprintf+0x80>
 978:	9752                	add	a4,a4,s4
 97a:	00274603          	lbu	a2,2(a4)
      if(c0 == 'd'){
 97e:	03878f63          	beq	a5,s8,9bc <vprintf+0xbe>
      } else if(c0 == 'l' && c1 == 'd'){
 982:	05978963          	beq	a5,s9,9d4 <vprintf+0xd6>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
 986:	07500713          	li	a4,117
 98a:	0ee78363          	beq	a5,a4,a70 <vprintf+0x172>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
 98e:	07800713          	li	a4,120
 992:	12e78563          	beq	a5,a4,abc <vprintf+0x1be>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
 996:	07000713          	li	a4,112
 99a:	14e78a63          	beq	a5,a4,aee <vprintf+0x1f0>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 's'){
 99e:	07300713          	li	a4,115
 9a2:	18e78863          	beq	a5,a4,b32 <vprintf+0x234>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
 9a6:	02500713          	li	a4,37
 9aa:	04e79563          	bne	a5,a4,9f4 <vprintf+0xf6>
        putc(fd, '%');
 9ae:	02500593          	li	a1,37
 9b2:	855a                	mv	a0,s6
 9b4:	e85ff0ef          	jal	838 <putc>
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
#endif
      state = 0;
 9b8:	4981                	li	s3,0
 9ba:	bf41                	j	94a <vprintf+0x4c>
        printint(fd, va_arg(ap, int), 10, 1);
 9bc:	008b8913          	add	s2,s7,8
 9c0:	4685                	li	a3,1
 9c2:	4629                	li	a2,10
 9c4:	000ba583          	lw	a1,0(s7)
 9c8:	855a                	mv	a0,s6
 9ca:	e8dff0ef          	jal	856 <printint>
 9ce:	8bca                	mv	s7,s2
      state = 0;
 9d0:	4981                	li	s3,0
 9d2:	bfa5                	j	94a <vprintf+0x4c>
      } else if(c0 == 'l' && c1 == 'd'){
 9d4:	06400793          	li	a5,100
 9d8:	02f68963          	beq	a3,a5,a0a <vprintf+0x10c>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 9dc:	06c00793          	li	a5,108
 9e0:	04f68263          	beq	a3,a5,a24 <vprintf+0x126>
      } else if(c0 == 'l' && c1 == 'u'){
 9e4:	07500793          	li	a5,117
 9e8:	0af68063          	beq	a3,a5,a88 <vprintf+0x18a>
      } else if(c0 == 'l' && c1 == 'x'){
 9ec:	07800793          	li	a5,120
 9f0:	0ef68263          	beq	a3,a5,ad4 <vprintf+0x1d6>
        putc(fd, '%');
 9f4:	02500593          	li	a1,37
 9f8:	855a                	mv	a0,s6
 9fa:	e3fff0ef          	jal	838 <putc>
        putc(fd, c0);
 9fe:	85ca                	mv	a1,s2
 a00:	855a                	mv	a0,s6
 a02:	e37ff0ef          	jal	838 <putc>
      state = 0;
 a06:	4981                	li	s3,0
 a08:	b789                	j	94a <vprintf+0x4c>
        printint(fd, va_arg(ap, uint64), 10, 1);
 a0a:	008b8913          	add	s2,s7,8
 a0e:	4685                	li	a3,1
 a10:	4629                	li	a2,10
 a12:	000bb583          	ld	a1,0(s7)
 a16:	855a                	mv	a0,s6
 a18:	e3fff0ef          	jal	856 <printint>
        i += 1;
 a1c:	2485                	addw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 a1e:	8bca                	mv	s7,s2
      state = 0;
 a20:	4981                	li	s3,0
        i += 1;
 a22:	b725                	j	94a <vprintf+0x4c>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 a24:	06400793          	li	a5,100
 a28:	02f60763          	beq	a2,a5,a56 <vprintf+0x158>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 a2c:	07500793          	li	a5,117
 a30:	06f60963          	beq	a2,a5,aa2 <vprintf+0x1a4>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 a34:	07800793          	li	a5,120
 a38:	faf61ee3          	bne	a2,a5,9f4 <vprintf+0xf6>
        printint(fd, va_arg(ap, uint64), 16, 0);
 a3c:	008b8913          	add	s2,s7,8
 a40:	4681                	li	a3,0
 a42:	4641                	li	a2,16
 a44:	000bb583          	ld	a1,0(s7)
 a48:	855a                	mv	a0,s6
 a4a:	e0dff0ef          	jal	856 <printint>
        i += 2;
 a4e:	2489                	addw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 a50:	8bca                	mv	s7,s2
      state = 0;
 a52:	4981                	li	s3,0
        i += 2;
 a54:	bddd                	j	94a <vprintf+0x4c>
        printint(fd, va_arg(ap, uint64), 10, 1);
 a56:	008b8913          	add	s2,s7,8
 a5a:	4685                	li	a3,1
 a5c:	4629                	li	a2,10
 a5e:	000bb583          	ld	a1,0(s7)
 a62:	855a                	mv	a0,s6
 a64:	df3ff0ef          	jal	856 <printint>
        i += 2;
 a68:	2489                	addw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 a6a:	8bca                	mv	s7,s2
      state = 0;
 a6c:	4981                	li	s3,0
        i += 2;
 a6e:	bdf1                	j	94a <vprintf+0x4c>
        printint(fd, va_arg(ap, int), 10, 0);
 a70:	008b8913          	add	s2,s7,8
 a74:	4681                	li	a3,0
 a76:	4629                	li	a2,10
 a78:	000ba583          	lw	a1,0(s7)
 a7c:	855a                	mv	a0,s6
 a7e:	dd9ff0ef          	jal	856 <printint>
 a82:	8bca                	mv	s7,s2
      state = 0;
 a84:	4981                	li	s3,0
 a86:	b5d1                	j	94a <vprintf+0x4c>
        printint(fd, va_arg(ap, uint64), 10, 0);
 a88:	008b8913          	add	s2,s7,8
 a8c:	4681                	li	a3,0
 a8e:	4629                	li	a2,10
 a90:	000bb583          	ld	a1,0(s7)
 a94:	855a                	mv	a0,s6
 a96:	dc1ff0ef          	jal	856 <printint>
        i += 1;
 a9a:	2485                	addw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 a9c:	8bca                	mv	s7,s2
      state = 0;
 a9e:	4981                	li	s3,0
        i += 1;
 aa0:	b56d                	j	94a <vprintf+0x4c>
        printint(fd, va_arg(ap, uint64), 10, 0);
 aa2:	008b8913          	add	s2,s7,8
 aa6:	4681                	li	a3,0
 aa8:	4629                	li	a2,10
 aaa:	000bb583          	ld	a1,0(s7)
 aae:	855a                	mv	a0,s6
 ab0:	da7ff0ef          	jal	856 <printint>
        i += 2;
 ab4:	2489                	addw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 ab6:	8bca                	mv	s7,s2
      state = 0;
 ab8:	4981                	li	s3,0
        i += 2;
 aba:	bd41                	j	94a <vprintf+0x4c>
        printint(fd, va_arg(ap, int), 16, 0);
 abc:	008b8913          	add	s2,s7,8
 ac0:	4681                	li	a3,0
 ac2:	4641                	li	a2,16
 ac4:	000ba583          	lw	a1,0(s7)
 ac8:	855a                	mv	a0,s6
 aca:	d8dff0ef          	jal	856 <printint>
 ace:	8bca                	mv	s7,s2
      state = 0;
 ad0:	4981                	li	s3,0
 ad2:	bda5                	j	94a <vprintf+0x4c>
        printint(fd, va_arg(ap, uint64), 16, 0);
 ad4:	008b8913          	add	s2,s7,8
 ad8:	4681                	li	a3,0
 ada:	4641                	li	a2,16
 adc:	000bb583          	ld	a1,0(s7)
 ae0:	855a                	mv	a0,s6
 ae2:	d75ff0ef          	jal	856 <printint>
        i += 1;
 ae6:	2485                	addw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 ae8:	8bca                	mv	s7,s2
      state = 0;
 aea:	4981                	li	s3,0
        i += 1;
 aec:	bdb9                	j	94a <vprintf+0x4c>
        printptr(fd, va_arg(ap, uint64));
 aee:	008b8d13          	add	s10,s7,8
 af2:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 af6:	03000593          	li	a1,48
 afa:	855a                	mv	a0,s6
 afc:	d3dff0ef          	jal	838 <putc>
  putc(fd, 'x');
 b00:	07800593          	li	a1,120
 b04:	855a                	mv	a0,s6
 b06:	d33ff0ef          	jal	838 <putc>
 b0a:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 b0c:	00000b97          	auipc	s7,0x0
 b10:	2acb8b93          	add	s7,s7,684 # db8 <digits>
 b14:	03c9d793          	srl	a5,s3,0x3c
 b18:	97de                	add	a5,a5,s7
 b1a:	0007c583          	lbu	a1,0(a5)
 b1e:	855a                	mv	a0,s6
 b20:	d19ff0ef          	jal	838 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 b24:	0992                	sll	s3,s3,0x4
 b26:	397d                	addw	s2,s2,-1
 b28:	fe0916e3          	bnez	s2,b14 <vprintf+0x216>
        printptr(fd, va_arg(ap, uint64));
 b2c:	8bea                	mv	s7,s10
      state = 0;
 b2e:	4981                	li	s3,0
 b30:	bd29                	j	94a <vprintf+0x4c>
        if((s = va_arg(ap, char*)) == 0)
 b32:	008b8993          	add	s3,s7,8
 b36:	000bb903          	ld	s2,0(s7)
 b3a:	00090f63          	beqz	s2,b58 <vprintf+0x25a>
        for(; *s; s++)
 b3e:	00094583          	lbu	a1,0(s2)
 b42:	c195                	beqz	a1,b66 <vprintf+0x268>
          putc(fd, *s);
 b44:	855a                	mv	a0,s6
 b46:	cf3ff0ef          	jal	838 <putc>
        for(; *s; s++)
 b4a:	0905                	add	s2,s2,1
 b4c:	00094583          	lbu	a1,0(s2)
 b50:	f9f5                	bnez	a1,b44 <vprintf+0x246>
        if((s = va_arg(ap, char*)) == 0)
 b52:	8bce                	mv	s7,s3
      state = 0;
 b54:	4981                	li	s3,0
 b56:	bbd5                	j	94a <vprintf+0x4c>
          s = "(null)";
 b58:	00000917          	auipc	s2,0x0
 b5c:	25890913          	add	s2,s2,600 # db0 <malloc+0x14a>
        for(; *s; s++)
 b60:	02800593          	li	a1,40
 b64:	b7c5                	j	b44 <vprintf+0x246>
        if((s = va_arg(ap, char*)) == 0)
 b66:	8bce                	mv	s7,s3
      state = 0;
 b68:	4981                	li	s3,0
 b6a:	b3c5                	j	94a <vprintf+0x4c>
    }
  }
}
 b6c:	60e6                	ld	ra,88(sp)
 b6e:	6446                	ld	s0,80(sp)
 b70:	64a6                	ld	s1,72(sp)
 b72:	6906                	ld	s2,64(sp)
 b74:	79e2                	ld	s3,56(sp)
 b76:	7a42                	ld	s4,48(sp)
 b78:	7aa2                	ld	s5,40(sp)
 b7a:	7b02                	ld	s6,32(sp)
 b7c:	6be2                	ld	s7,24(sp)
 b7e:	6c42                	ld	s8,16(sp)
 b80:	6ca2                	ld	s9,8(sp)
 b82:	6d02                	ld	s10,0(sp)
 b84:	6125                	add	sp,sp,96
 b86:	8082                	ret

0000000000000b88 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 b88:	715d                	add	sp,sp,-80
 b8a:	ec06                	sd	ra,24(sp)
 b8c:	e822                	sd	s0,16(sp)
 b8e:	1000                	add	s0,sp,32
 b90:	e010                	sd	a2,0(s0)
 b92:	e414                	sd	a3,8(s0)
 b94:	e818                	sd	a4,16(s0)
 b96:	ec1c                	sd	a5,24(s0)
 b98:	03043023          	sd	a6,32(s0)
 b9c:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 ba0:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 ba4:	8622                	mv	a2,s0
 ba6:	d59ff0ef          	jal	8fe <vprintf>
}
 baa:	60e2                	ld	ra,24(sp)
 bac:	6442                	ld	s0,16(sp)
 bae:	6161                	add	sp,sp,80
 bb0:	8082                	ret

0000000000000bb2 <printf>:

void
printf(const char *fmt, ...)
{
 bb2:	711d                	add	sp,sp,-96
 bb4:	ec06                	sd	ra,24(sp)
 bb6:	e822                	sd	s0,16(sp)
 bb8:	1000                	add	s0,sp,32
 bba:	e40c                	sd	a1,8(s0)
 bbc:	e810                	sd	a2,16(s0)
 bbe:	ec14                	sd	a3,24(s0)
 bc0:	f018                	sd	a4,32(s0)
 bc2:	f41c                	sd	a5,40(s0)
 bc4:	03043823          	sd	a6,48(s0)
 bc8:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 bcc:	00840613          	add	a2,s0,8
 bd0:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 bd4:	85aa                	mv	a1,a0
 bd6:	4505                	li	a0,1
 bd8:	d27ff0ef          	jal	8fe <vprintf>
}
 bdc:	60e2                	ld	ra,24(sp)
 bde:	6442                	ld	s0,16(sp)
 be0:	6125                	add	sp,sp,96
 be2:	8082                	ret

0000000000000be4 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 be4:	1141                	add	sp,sp,-16
 be6:	e422                	sd	s0,8(sp)
 be8:	0800                	add	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 bea:	ff050693          	add	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 bee:	00000797          	auipc	a5,0x0
 bf2:	41a7b783          	ld	a5,1050(a5) # 1008 <freep>
 bf6:	a02d                	j	c20 <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 bf8:	4618                	lw	a4,8(a2)
 bfa:	9f2d                	addw	a4,a4,a1
 bfc:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 c00:	6398                	ld	a4,0(a5)
 c02:	6310                	ld	a2,0(a4)
 c04:	a83d                	j	c42 <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 c06:	ff852703          	lw	a4,-8(a0)
 c0a:	9f31                	addw	a4,a4,a2
 c0c:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 c0e:	ff053683          	ld	a3,-16(a0)
 c12:	a091                	j	c56 <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 c14:	6398                	ld	a4,0(a5)
 c16:	00e7e463          	bltu	a5,a4,c1e <free+0x3a>
 c1a:	00e6ea63          	bltu	a3,a4,c2e <free+0x4a>
{
 c1e:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 c20:	fed7fae3          	bgeu	a5,a3,c14 <free+0x30>
 c24:	6398                	ld	a4,0(a5)
 c26:	00e6e463          	bltu	a3,a4,c2e <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 c2a:	fee7eae3          	bltu	a5,a4,c1e <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 c2e:	ff852583          	lw	a1,-8(a0)
 c32:	6390                	ld	a2,0(a5)
 c34:	02059813          	sll	a6,a1,0x20
 c38:	01c85713          	srl	a4,a6,0x1c
 c3c:	9736                	add	a4,a4,a3
 c3e:	fae60de3          	beq	a2,a4,bf8 <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 c42:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 c46:	4790                	lw	a2,8(a5)
 c48:	02061593          	sll	a1,a2,0x20
 c4c:	01c5d713          	srl	a4,a1,0x1c
 c50:	973e                	add	a4,a4,a5
 c52:	fae68ae3          	beq	a3,a4,c06 <free+0x22>
    p->s.ptr = bp->s.ptr;
 c56:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 c58:	00000717          	auipc	a4,0x0
 c5c:	3af73823          	sd	a5,944(a4) # 1008 <freep>
}
 c60:	6422                	ld	s0,8(sp)
 c62:	0141                	add	sp,sp,16
 c64:	8082                	ret

0000000000000c66 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 c66:	7139                	add	sp,sp,-64
 c68:	fc06                	sd	ra,56(sp)
 c6a:	f822                	sd	s0,48(sp)
 c6c:	f426                	sd	s1,40(sp)
 c6e:	f04a                	sd	s2,32(sp)
 c70:	ec4e                	sd	s3,24(sp)
 c72:	e852                	sd	s4,16(sp)
 c74:	e456                	sd	s5,8(sp)
 c76:	e05a                	sd	s6,0(sp)
 c78:	0080                	add	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 c7a:	02051493          	sll	s1,a0,0x20
 c7e:	9081                	srl	s1,s1,0x20
 c80:	04bd                	add	s1,s1,15
 c82:	8091                	srl	s1,s1,0x4
 c84:	0014899b          	addw	s3,s1,1
 c88:	0485                	add	s1,s1,1
  if((prevp = freep) == 0){
 c8a:	00000517          	auipc	a0,0x0
 c8e:	37e53503          	ld	a0,894(a0) # 1008 <freep>
 c92:	c515                	beqz	a0,cbe <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 c94:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 c96:	4798                	lw	a4,8(a5)
 c98:	02977f63          	bgeu	a4,s1,cd6 <malloc+0x70>
  if(nu < 4096)
 c9c:	8a4e                	mv	s4,s3
 c9e:	0009871b          	sext.w	a4,s3
 ca2:	6685                	lui	a3,0x1
 ca4:	00d77363          	bgeu	a4,a3,caa <malloc+0x44>
 ca8:	6a05                	lui	s4,0x1
 caa:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 cae:	004a1a1b          	sllw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 cb2:	00000917          	auipc	s2,0x0
 cb6:	35690913          	add	s2,s2,854 # 1008 <freep>
  if(p == (char*)-1)
 cba:	5afd                	li	s5,-1
 cbc:	a885                	j	d2c <malloc+0xc6>
    base.s.ptr = freep = prevp = &base;
 cbe:	00000797          	auipc	a5,0x0
 cc2:	36278793          	add	a5,a5,866 # 1020 <base>
 cc6:	00000717          	auipc	a4,0x0
 cca:	34f73123          	sd	a5,834(a4) # 1008 <freep>
 cce:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 cd0:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 cd4:	b7e1                	j	c9c <malloc+0x36>
      if(p->s.size == nunits)
 cd6:	02e48c63          	beq	s1,a4,d0e <malloc+0xa8>
        p->s.size -= nunits;
 cda:	4137073b          	subw	a4,a4,s3
 cde:	c798                	sw	a4,8(a5)
        p += p->s.size;
 ce0:	02071693          	sll	a3,a4,0x20
 ce4:	01c6d713          	srl	a4,a3,0x1c
 ce8:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 cea:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 cee:	00000717          	auipc	a4,0x0
 cf2:	30a73d23          	sd	a0,794(a4) # 1008 <freep>
      return (void*)(p + 1);
 cf6:	01078513          	add	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 cfa:	70e2                	ld	ra,56(sp)
 cfc:	7442                	ld	s0,48(sp)
 cfe:	74a2                	ld	s1,40(sp)
 d00:	7902                	ld	s2,32(sp)
 d02:	69e2                	ld	s3,24(sp)
 d04:	6a42                	ld	s4,16(sp)
 d06:	6aa2                	ld	s5,8(sp)
 d08:	6b02                	ld	s6,0(sp)
 d0a:	6121                	add	sp,sp,64
 d0c:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 d0e:	6398                	ld	a4,0(a5)
 d10:	e118                	sd	a4,0(a0)
 d12:	bff1                	j	cee <malloc+0x88>
  hp->s.size = nu;
 d14:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 d18:	0541                	add	a0,a0,16
 d1a:	ecbff0ef          	jal	be4 <free>
  return freep;
 d1e:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 d22:	dd61                	beqz	a0,cfa <malloc+0x94>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 d24:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 d26:	4798                	lw	a4,8(a5)
 d28:	fa9777e3          	bgeu	a4,s1,cd6 <malloc+0x70>
    if(p == freep)
 d2c:	00093703          	ld	a4,0(s2)
 d30:	853e                	mv	a0,a5
 d32:	fef719e3          	bne	a4,a5,d24 <malloc+0xbe>
  p = sbrk(nu * sizeof(Header));
 d36:	8552                	mv	a0,s4
 d38:	a99ff0ef          	jal	7d0 <sbrk>
  if(p == (char*)-1)
 d3c:	fd551ce3          	bne	a0,s5,d14 <malloc+0xae>
        return 0;
 d40:	4501                	li	a0,0
 d42:	bf65                	j	cfa <malloc+0x94>
