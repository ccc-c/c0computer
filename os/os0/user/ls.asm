
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
   8:	1800                	add	s0,sp,48
   a:	84aa                	mv	s1,a0
  static char buf[DIRSIZ+1];
  char *p;

  // Find first character after last slash.
  for(p=path+strlen(path); p >= path && *p != '/'; p--)
   c:	352000ef          	jal	35e <strlen>
  10:	02051793          	sll	a5,a0,0x20
  14:	9381                	srl	a5,a5,0x20
  16:	97a6                	add	a5,a5,s1
  18:	02f00693          	li	a3,47
  1c:	0097e963          	bltu	a5,s1,2e <fmtname+0x2e>
  20:	0007c703          	lbu	a4,0(a5)
  24:	00d70563          	beq	a4,a3,2e <fmtname+0x2e>
  28:	17fd                	add	a5,a5,-1
  2a:	fe97fbe3          	bgeu	a5,s1,20 <fmtname+0x20>
    ;
  p++;
  2e:	00178493          	add	s1,a5,1

  // Return blank-padded name.
  if(strlen(p) >= DIRSIZ)
  32:	8526                	mv	a0,s1
  34:	32a000ef          	jal	35e <strlen>
  38:	2501                	sext.w	a0,a0
  3a:	47b5                	li	a5,13
  3c:	00a7f863          	bgeu	a5,a0,4c <fmtname+0x4c>
    return p;
  memmove(buf, p, strlen(p));
  memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
  buf[sizeof(buf)-1] = '\0';
  return buf;
}
  40:	8526                	mv	a0,s1
  42:	70a2                	ld	ra,40(sp)
  44:	7402                	ld	s0,32(sp)
  46:	64e2                	ld	s1,24(sp)
  48:	6145                	add	sp,sp,48
  4a:	8082                	ret
  4c:	e84a                	sd	s2,16(sp)
  4e:	e44e                	sd	s3,8(sp)
  memmove(buf, p, strlen(p));
  50:	8526                	mv	a0,s1
  52:	30c000ef          	jal	35e <strlen>
  56:	00001997          	auipc	s3,0x1
  5a:	fba98993          	add	s3,s3,-70 # 1010 <buf.0>
  5e:	0005061b          	sext.w	a2,a0
  62:	85a6                	mv	a1,s1
  64:	854e                	mv	a0,s3
  66:	45a000ef          	jal	4c0 <memmove>
  memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
  6a:	8526                	mv	a0,s1
  6c:	2f2000ef          	jal	35e <strlen>
  70:	0005091b          	sext.w	s2,a0
  74:	8526                	mv	a0,s1
  76:	2e8000ef          	jal	35e <strlen>
  7a:	1902                	sll	s2,s2,0x20
  7c:	02095913          	srl	s2,s2,0x20
  80:	4639                	li	a2,14
  82:	9e09                	subw	a2,a2,a0
  84:	02000593          	li	a1,32
  88:	01298533          	add	a0,s3,s2
  8c:	2fc000ef          	jal	388 <memset>
  buf[sizeof(buf)-1] = '\0';
  90:	00098723          	sb	zero,14(s3)
  return buf;
  94:	84ce                	mv	s1,s3
  96:	6942                	ld	s2,16(sp)
  98:	69a2                	ld	s3,8(sp)
  9a:	b75d                	j	40 <fmtname+0x40>

000000000000009c <ls>:

void
ls(char *path)
{
  9c:	d9010113          	add	sp,sp,-624
  a0:	26113423          	sd	ra,616(sp)
  a4:	26813023          	sd	s0,608(sp)
  a8:	25213823          	sd	s2,592(sp)
  ac:	1c80                	add	s0,sp,624
  ae:	892a                	mv	s2,a0
  char buf[512], *p;
  int fd;
  struct dirent de;
  struct stat st;

  if((fd = open(path, O_RDONLY)) < 0){
  b0:	4581                	li	a1,0
  b2:	5c8000ef          	jal	67a <open>
  b6:	06054363          	bltz	a0,11c <ls+0x80>
  ba:	24913c23          	sd	s1,600(sp)
  be:	84aa                	mv	s1,a0
    fprintf(2, "ls: cannot open %s\n", path);
    return;
  }

  if(fstat(fd, &st) < 0){
  c0:	d9840593          	add	a1,s0,-616
  c4:	5ce000ef          	jal	692 <fstat>
  c8:	06054363          	bltz	a0,12e <ls+0x92>
    fprintf(2, "ls: cannot stat %s\n", path);
    close(fd);
    return;
  }

  switch(st.type){
  cc:	da041783          	lh	a5,-608(s0)
  d0:	4705                	li	a4,1
  d2:	06e78c63          	beq	a5,a4,14a <ls+0xae>
  d6:	37f9                	addw	a5,a5,-2
  d8:	17c2                	sll	a5,a5,0x30
  da:	93c1                	srl	a5,a5,0x30
  dc:	02f76263          	bltu	a4,a5,100 <ls+0x64>
  case T_DEVICE:
  case T_FILE:
    printf("%s %d %d %d\n", fmtname(path), st.type, st.ino, (int) st.size);
  e0:	854a                	mv	a0,s2
  e2:	f1fff0ef          	jal	0 <fmtname>
  e6:	85aa                	mv	a1,a0
  e8:	da842703          	lw	a4,-600(s0)
  ec:	d9c42683          	lw	a3,-612(s0)
  f0:	da041603          	lh	a2,-608(s0)
  f4:	00001517          	auipc	a0,0x1
  f8:	b9c50513          	add	a0,a0,-1124 # c90 <malloc+0x132>
  fc:	1af000ef          	jal	aaa <printf>
      }
      printf("%s %d %d %d\n", fmtname(buf), st.type, st.ino, (int) st.size);
    }
    break;
  }
  close(fd);
 100:	8526                	mv	a0,s1
 102:	560000ef          	jal	662 <close>
 106:	25813483          	ld	s1,600(sp)
}
 10a:	26813083          	ld	ra,616(sp)
 10e:	26013403          	ld	s0,608(sp)
 112:	25013903          	ld	s2,592(sp)
 116:	27010113          	add	sp,sp,624
 11a:	8082                	ret
    fprintf(2, "ls: cannot open %s\n", path);
 11c:	864a                	mv	a2,s2
 11e:	00001597          	auipc	a1,0x1
 122:	b4258593          	add	a1,a1,-1214 # c60 <malloc+0x102>
 126:	4509                	li	a0,2
 128:	159000ef          	jal	a80 <fprintf>
    return;
 12c:	bff9                	j	10a <ls+0x6e>
    fprintf(2, "ls: cannot stat %s\n", path);
 12e:	864a                	mv	a2,s2
 130:	00001597          	auipc	a1,0x1
 134:	b4858593          	add	a1,a1,-1208 # c78 <malloc+0x11a>
 138:	4509                	li	a0,2
 13a:	147000ef          	jal	a80 <fprintf>
    close(fd);
 13e:	8526                	mv	a0,s1
 140:	522000ef          	jal	662 <close>
    return;
 144:	25813483          	ld	s1,600(sp)
 148:	b7c9                	j	10a <ls+0x6e>
    if(strlen(path) + 1 + DIRSIZ + 1 > sizeof buf){
 14a:	854a                	mv	a0,s2
 14c:	212000ef          	jal	35e <strlen>
 150:	2541                	addw	a0,a0,16
 152:	20000793          	li	a5,512
 156:	00a7f963          	bgeu	a5,a0,168 <ls+0xcc>
      printf("ls: path too long\n");
 15a:	00001517          	auipc	a0,0x1
 15e:	b4650513          	add	a0,a0,-1210 # ca0 <malloc+0x142>
 162:	149000ef          	jal	aaa <printf>
      break;
 166:	bf69                	j	100 <ls+0x64>
 168:	25313423          	sd	s3,584(sp)
 16c:	25413023          	sd	s4,576(sp)
 170:	23513c23          	sd	s5,568(sp)
    strcpy(buf, path);
 174:	85ca                	mv	a1,s2
 176:	dc040513          	add	a0,s0,-576
 17a:	102000ef          	jal	27c <strcpy>
    p = buf+strlen(buf);
 17e:	dc040513          	add	a0,s0,-576
 182:	1dc000ef          	jal	35e <strlen>
 186:	1502                	sll	a0,a0,0x20
 188:	9101                	srl	a0,a0,0x20
 18a:	dc040793          	add	a5,s0,-576
 18e:	00a78933          	add	s2,a5,a0
    *p++ = '/';
 192:	00190993          	add	s3,s2,1
 196:	02f00793          	li	a5,47
 19a:	00f90023          	sb	a5,0(s2)
      printf("%s %d %d %d\n", fmtname(buf), st.type, st.ino, (int) st.size);
 19e:	00001a17          	auipc	s4,0x1
 1a2:	af2a0a13          	add	s4,s4,-1294 # c90 <malloc+0x132>
        printf("ls: cannot stat %s\n", buf);
 1a6:	00001a97          	auipc	s5,0x1
 1aa:	ad2a8a93          	add	s5,s5,-1326 # c78 <malloc+0x11a>
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
 1ae:	a031                	j	1ba <ls+0x11e>
        printf("ls: cannot stat %s\n", buf);
 1b0:	dc040593          	add	a1,s0,-576
 1b4:	8556                	mv	a0,s5
 1b6:	0f5000ef          	jal	aaa <printf>
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
 1ba:	4641                	li	a2,16
 1bc:	db040593          	add	a1,s0,-592
 1c0:	8526                	mv	a0,s1
 1c2:	490000ef          	jal	652 <read>
 1c6:	47c1                	li	a5,16
 1c8:	04f51463          	bne	a0,a5,210 <ls+0x174>
      if(de.inum == 0)
 1cc:	db045783          	lhu	a5,-592(s0)
 1d0:	d7ed                	beqz	a5,1ba <ls+0x11e>
      memmove(p, de.name, DIRSIZ);
 1d2:	4639                	li	a2,14
 1d4:	db240593          	add	a1,s0,-590
 1d8:	854e                	mv	a0,s3
 1da:	2e6000ef          	jal	4c0 <memmove>
      p[DIRSIZ] = 0;
 1de:	000907a3          	sb	zero,15(s2)
      if(stat(buf, &st) < 0){
 1e2:	d9840593          	add	a1,s0,-616
 1e6:	dc040513          	add	a0,s0,-576
 1ea:	254000ef          	jal	43e <stat>
 1ee:	fc0541e3          	bltz	a0,1b0 <ls+0x114>
      printf("%s %d %d %d\n", fmtname(buf), st.type, st.ino, (int) st.size);
 1f2:	dc040513          	add	a0,s0,-576
 1f6:	e0bff0ef          	jal	0 <fmtname>
 1fa:	85aa                	mv	a1,a0
 1fc:	da842703          	lw	a4,-600(s0)
 200:	d9c42683          	lw	a3,-612(s0)
 204:	da041603          	lh	a2,-608(s0)
 208:	8552                	mv	a0,s4
 20a:	0a1000ef          	jal	aaa <printf>
 20e:	b775                	j	1ba <ls+0x11e>
 210:	24813983          	ld	s3,584(sp)
 214:	24013a03          	ld	s4,576(sp)
 218:	23813a83          	ld	s5,568(sp)
 21c:	b5d5                	j	100 <ls+0x64>

000000000000021e <main>:

int
main(int argc, char *argv[])
{
 21e:	1101                	add	sp,sp,-32
 220:	ec06                	sd	ra,24(sp)
 222:	e822                	sd	s0,16(sp)
 224:	1000                	add	s0,sp,32
  int i;

  if(argc < 2){
 226:	4785                	li	a5,1
 228:	02a7d763          	bge	a5,a0,256 <main+0x38>
 22c:	e426                	sd	s1,8(sp)
 22e:	e04a                	sd	s2,0(sp)
 230:	00858493          	add	s1,a1,8
 234:	ffe5091b          	addw	s2,a0,-2
 238:	02091793          	sll	a5,s2,0x20
 23c:	01d7d913          	srl	s2,a5,0x1d
 240:	05c1                	add	a1,a1,16
 242:	992e                	add	s2,s2,a1
    ls(".");
    exit(0);
  }
  for(i=1; i<argc; i++)
    ls(argv[i]);
 244:	6088                	ld	a0,0(s1)
 246:	e57ff0ef          	jal	9c <ls>
  for(i=1; i<argc; i++)
 24a:	04a1                	add	s1,s1,8
 24c:	ff249ce3          	bne	s1,s2,244 <main+0x26>
  exit(0);
 250:	4501                	li	a0,0
 252:	3e8000ef          	jal	63a <exit>
 256:	e426                	sd	s1,8(sp)
 258:	e04a                	sd	s2,0(sp)
    ls(".");
 25a:	00001517          	auipc	a0,0x1
 25e:	a5e50513          	add	a0,a0,-1442 # cb8 <malloc+0x15a>
 262:	e3bff0ef          	jal	9c <ls>
    exit(0);
 266:	4501                	li	a0,0
 268:	3d2000ef          	jal	63a <exit>

000000000000026c <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start(int argc, char **argv)
{
 26c:	1141                	add	sp,sp,-16
 26e:	e406                	sd	ra,8(sp)
 270:	e022                	sd	s0,0(sp)
 272:	0800                	add	s0,sp,16
  int r;
  extern int main(int argc, char **argv);
  r = main(argc, argv);
 274:	fabff0ef          	jal	21e <main>
  exit(r);
 278:	3c2000ef          	jal	63a <exit>

000000000000027c <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
 27c:	1141                	add	sp,sp,-16
 27e:	e422                	sd	s0,8(sp)
 280:	0800                	add	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 282:	87aa                	mv	a5,a0
 284:	0585                	add	a1,a1,1
 286:	0785                	add	a5,a5,1
 288:	fff5c703          	lbu	a4,-1(a1)
 28c:	fee78fa3          	sb	a4,-1(a5)
 290:	fb75                	bnez	a4,284 <strcpy+0x8>
    ;
  return os;
}
 292:	6422                	ld	s0,8(sp)
 294:	0141                	add	sp,sp,16
 296:	8082                	ret

0000000000000298 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 298:	1141                	add	sp,sp,-16
 29a:	e422                	sd	s0,8(sp)
 29c:	0800                	add	s0,sp,16
  while(*p && *p == *q)
 29e:	00054783          	lbu	a5,0(a0)
 2a2:	cb91                	beqz	a5,2b6 <strcmp+0x1e>
 2a4:	0005c703          	lbu	a4,0(a1)
 2a8:	00f71763          	bne	a4,a5,2b6 <strcmp+0x1e>
    p++, q++;
 2ac:	0505                	add	a0,a0,1
 2ae:	0585                	add	a1,a1,1
  while(*p && *p == *q)
 2b0:	00054783          	lbu	a5,0(a0)
 2b4:	fbe5                	bnez	a5,2a4 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 2b6:	0005c503          	lbu	a0,0(a1)
}
 2ba:	40a7853b          	subw	a0,a5,a0
 2be:	6422                	ld	s0,8(sp)
 2c0:	0141                	add	sp,sp,16
 2c2:	8082                	ret

00000000000002c4 <strncmp>:

int
strncmp(const char *p, const char *q, uint n)
{
 2c4:	1141                	add	sp,sp,-16
 2c6:	e422                	sd	s0,8(sp)
 2c8:	0800                	add	s0,sp,16
  while(n > 0 && *p && *p == *q) {
 2ca:	ce11                	beqz	a2,2e6 <strncmp+0x22>
 2cc:	00054783          	lbu	a5,0(a0)
 2d0:	cf89                	beqz	a5,2ea <strncmp+0x26>
 2d2:	0005c703          	lbu	a4,0(a1)
 2d6:	00f71a63          	bne	a4,a5,2ea <strncmp+0x26>
    p++, q++, n--;
 2da:	0505                	add	a0,a0,1
 2dc:	0585                	add	a1,a1,1
 2de:	367d                	addw	a2,a2,-1
  while(n > 0 && *p && *p == *q) {
 2e0:	f675                	bnez	a2,2cc <strncmp+0x8>
  }
  if (n == 0)
    return 0;
 2e2:	4501                	li	a0,0
 2e4:	a801                	j	2f4 <strncmp+0x30>
 2e6:	4501                	li	a0,0
 2e8:	a031                	j	2f4 <strncmp+0x30>
  return (uchar)*p - (uchar)*q;
 2ea:	00054503          	lbu	a0,0(a0)
 2ee:	0005c783          	lbu	a5,0(a1)
 2f2:	9d1d                	subw	a0,a0,a5
}
 2f4:	6422                	ld	s0,8(sp)
 2f6:	0141                	add	sp,sp,16
 2f8:	8082                	ret

00000000000002fa <strcat>:

char*
strcat(char *dst, const char *src)
{
 2fa:	1141                	add	sp,sp,-16
 2fc:	e422                	sd	s0,8(sp)
 2fe:	0800                	add	s0,sp,16
  char *p = dst;
  while(*p) p++;
 300:	00054783          	lbu	a5,0(a0)
 304:	c385                	beqz	a5,324 <strcat+0x2a>
  char *p = dst;
 306:	87aa                	mv	a5,a0
  while(*p) p++;
 308:	0785                	add	a5,a5,1
 30a:	0007c703          	lbu	a4,0(a5)
 30e:	ff6d                	bnez	a4,308 <strcat+0xe>
  while((*p++ = *src++) != 0);
 310:	0585                	add	a1,a1,1
 312:	0785                	add	a5,a5,1
 314:	fff5c703          	lbu	a4,-1(a1)
 318:	fee78fa3          	sb	a4,-1(a5)
 31c:	fb75                	bnez	a4,310 <strcat+0x16>
  return dst;
}
 31e:	6422                	ld	s0,8(sp)
 320:	0141                	add	sp,sp,16
 322:	8082                	ret
  char *p = dst;
 324:	87aa                	mv	a5,a0
 326:	b7ed                	j	310 <strcat+0x16>

0000000000000328 <strncpy>:

char*
strncpy(char *dst, const char *src, int n)
{
 328:	1141                	add	sp,sp,-16
 32a:	e422                	sd	s0,8(sp)
 32c:	0800                	add	s0,sp,16
  char *p = dst;
 32e:	87aa                	mv	a5,a0
  while(n > 0 && *src) {
 330:	02c05463          	blez	a2,358 <strncpy+0x30>
 334:	0005c703          	lbu	a4,0(a1)
 338:	cb01                	beqz	a4,348 <strncpy+0x20>
    *p++ = *src++;
 33a:	0585                	add	a1,a1,1
 33c:	0785                	add	a5,a5,1
 33e:	fee78fa3          	sb	a4,-1(a5)
    n--;
 342:	367d                	addw	a2,a2,-1
  while(n > 0 && *src) {
 344:	fa65                	bnez	a2,334 <strncpy+0xc>
 346:	a809                	j	358 <strncpy+0x30>
  }
  while(n > 0) {
 348:	1602                	sll	a2,a2,0x20
 34a:	9201                	srl	a2,a2,0x20
 34c:	963e                	add	a2,a2,a5
    *p++ = 0;
 34e:	0785                	add	a5,a5,1
 350:	fe078fa3          	sb	zero,-1(a5)
  while(n > 0) {
 354:	fec79de3          	bne	a5,a2,34e <strncpy+0x26>
    n--;
  }
  return dst;
}
 358:	6422                	ld	s0,8(sp)
 35a:	0141                	add	sp,sp,16
 35c:	8082                	ret

000000000000035e <strlen>:

uint
strlen(const char *s)
{
 35e:	1141                	add	sp,sp,-16
 360:	e422                	sd	s0,8(sp)
 362:	0800                	add	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 364:	00054783          	lbu	a5,0(a0)
 368:	cf91                	beqz	a5,384 <strlen+0x26>
 36a:	0505                	add	a0,a0,1
 36c:	87aa                	mv	a5,a0
 36e:	86be                	mv	a3,a5
 370:	0785                	add	a5,a5,1
 372:	fff7c703          	lbu	a4,-1(a5)
 376:	ff65                	bnez	a4,36e <strlen+0x10>
 378:	40a6853b          	subw	a0,a3,a0
 37c:	2505                	addw	a0,a0,1
    ;
  return n;
}
 37e:	6422                	ld	s0,8(sp)
 380:	0141                	add	sp,sp,16
 382:	8082                	ret
  for(n = 0; s[n]; n++)
 384:	4501                	li	a0,0
 386:	bfe5                	j	37e <strlen+0x20>

0000000000000388 <memset>:

void*
memset(void *dst, int c, uint n)
{
 388:	1141                	add	sp,sp,-16
 38a:	e422                	sd	s0,8(sp)
 38c:	0800                	add	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 38e:	ca19                	beqz	a2,3a4 <memset+0x1c>
 390:	87aa                	mv	a5,a0
 392:	1602                	sll	a2,a2,0x20
 394:	9201                	srl	a2,a2,0x20
 396:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 39a:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 39e:	0785                	add	a5,a5,1
 3a0:	fee79de3          	bne	a5,a4,39a <memset+0x12>
  }
  return dst;
}
 3a4:	6422                	ld	s0,8(sp)
 3a6:	0141                	add	sp,sp,16
 3a8:	8082                	ret

00000000000003aa <strchr>:

char*
strchr(const char *s, char c)
{
 3aa:	1141                	add	sp,sp,-16
 3ac:	e422                	sd	s0,8(sp)
 3ae:	0800                	add	s0,sp,16
  for(; *s; s++)
 3b0:	00054783          	lbu	a5,0(a0)
 3b4:	cb99                	beqz	a5,3ca <strchr+0x20>
    if(*s == c)
 3b6:	00f58763          	beq	a1,a5,3c4 <strchr+0x1a>
  for(; *s; s++)
 3ba:	0505                	add	a0,a0,1
 3bc:	00054783          	lbu	a5,0(a0)
 3c0:	fbfd                	bnez	a5,3b6 <strchr+0xc>
      return (char*)s;
  return 0;
 3c2:	4501                	li	a0,0
}
 3c4:	6422                	ld	s0,8(sp)
 3c6:	0141                	add	sp,sp,16
 3c8:	8082                	ret
  return 0;
 3ca:	4501                	li	a0,0
 3cc:	bfe5                	j	3c4 <strchr+0x1a>

00000000000003ce <gets>:

char*
gets(char *buf, int max)
{
 3ce:	711d                	add	sp,sp,-96
 3d0:	ec86                	sd	ra,88(sp)
 3d2:	e8a2                	sd	s0,80(sp)
 3d4:	e4a6                	sd	s1,72(sp)
 3d6:	e0ca                	sd	s2,64(sp)
 3d8:	fc4e                	sd	s3,56(sp)
 3da:	f852                	sd	s4,48(sp)
 3dc:	f456                	sd	s5,40(sp)
 3de:	f05a                	sd	s6,32(sp)
 3e0:	ec5e                	sd	s7,24(sp)
 3e2:	1080                	add	s0,sp,96
 3e4:	8baa                	mv	s7,a0
 3e6:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 3e8:	892a                	mv	s2,a0
 3ea:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 3ec:	4aa9                	li	s5,10
 3ee:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 3f0:	89a6                	mv	s3,s1
 3f2:	2485                	addw	s1,s1,1
 3f4:	0344d663          	bge	s1,s4,420 <gets+0x52>
    cc = read(0, &c, 1);
 3f8:	4605                	li	a2,1
 3fa:	faf40593          	add	a1,s0,-81
 3fe:	4501                	li	a0,0
 400:	252000ef          	jal	652 <read>
    if(cc < 1)
 404:	00a05e63          	blez	a0,420 <gets+0x52>
    buf[i++] = c;
 408:	faf44783          	lbu	a5,-81(s0)
 40c:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 410:	01578763          	beq	a5,s5,41e <gets+0x50>
 414:	0905                	add	s2,s2,1
 416:	fd679de3          	bne	a5,s6,3f0 <gets+0x22>
    buf[i++] = c;
 41a:	89a6                	mv	s3,s1
 41c:	a011                	j	420 <gets+0x52>
 41e:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 420:	99de                	add	s3,s3,s7
 422:	00098023          	sb	zero,0(s3)
  return buf;
}
 426:	855e                	mv	a0,s7
 428:	60e6                	ld	ra,88(sp)
 42a:	6446                	ld	s0,80(sp)
 42c:	64a6                	ld	s1,72(sp)
 42e:	6906                	ld	s2,64(sp)
 430:	79e2                	ld	s3,56(sp)
 432:	7a42                	ld	s4,48(sp)
 434:	7aa2                	ld	s5,40(sp)
 436:	7b02                	ld	s6,32(sp)
 438:	6be2                	ld	s7,24(sp)
 43a:	6125                	add	sp,sp,96
 43c:	8082                	ret

000000000000043e <stat>:

int
stat(const char *n, struct stat *st)
{
 43e:	1101                	add	sp,sp,-32
 440:	ec06                	sd	ra,24(sp)
 442:	e822                	sd	s0,16(sp)
 444:	e04a                	sd	s2,0(sp)
 446:	1000                	add	s0,sp,32
 448:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 44a:	4581                	li	a1,0
 44c:	22e000ef          	jal	67a <open>
  if(fd < 0)
 450:	02054263          	bltz	a0,474 <stat+0x36>
 454:	e426                	sd	s1,8(sp)
 456:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 458:	85ca                	mv	a1,s2
 45a:	238000ef          	jal	692 <fstat>
 45e:	892a                	mv	s2,a0
  close(fd);
 460:	8526                	mv	a0,s1
 462:	200000ef          	jal	662 <close>
  return r;
 466:	64a2                	ld	s1,8(sp)
}
 468:	854a                	mv	a0,s2
 46a:	60e2                	ld	ra,24(sp)
 46c:	6442                	ld	s0,16(sp)
 46e:	6902                	ld	s2,0(sp)
 470:	6105                	add	sp,sp,32
 472:	8082                	ret
    return -1;
 474:	597d                	li	s2,-1
 476:	bfcd                	j	468 <stat+0x2a>

0000000000000478 <atoi>:

int
atoi(const char *s)
{
 478:	1141                	add	sp,sp,-16
 47a:	e422                	sd	s0,8(sp)
 47c:	0800                	add	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 47e:	00054683          	lbu	a3,0(a0)
 482:	fd06879b          	addw	a5,a3,-48
 486:	0ff7f793          	zext.b	a5,a5
 48a:	4625                	li	a2,9
 48c:	02f66863          	bltu	a2,a5,4bc <atoi+0x44>
 490:	872a                	mv	a4,a0
  n = 0;
 492:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 494:	0705                	add	a4,a4,1
 496:	0025179b          	sllw	a5,a0,0x2
 49a:	9fa9                	addw	a5,a5,a0
 49c:	0017979b          	sllw	a5,a5,0x1
 4a0:	9fb5                	addw	a5,a5,a3
 4a2:	fd07851b          	addw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 4a6:	00074683          	lbu	a3,0(a4)
 4aa:	fd06879b          	addw	a5,a3,-48
 4ae:	0ff7f793          	zext.b	a5,a5
 4b2:	fef671e3          	bgeu	a2,a5,494 <atoi+0x1c>
  return n;
}
 4b6:	6422                	ld	s0,8(sp)
 4b8:	0141                	add	sp,sp,16
 4ba:	8082                	ret
  n = 0;
 4bc:	4501                	li	a0,0
 4be:	bfe5                	j	4b6 <atoi+0x3e>

00000000000004c0 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 4c0:	1141                	add	sp,sp,-16
 4c2:	e422                	sd	s0,8(sp)
 4c4:	0800                	add	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 4c6:	02b57463          	bgeu	a0,a1,4ee <memmove+0x2e>
    while(n-- > 0)
 4ca:	00c05f63          	blez	a2,4e8 <memmove+0x28>
 4ce:	1602                	sll	a2,a2,0x20
 4d0:	9201                	srl	a2,a2,0x20
 4d2:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 4d6:	872a                	mv	a4,a0
      *dst++ = *src++;
 4d8:	0585                	add	a1,a1,1
 4da:	0705                	add	a4,a4,1
 4dc:	fff5c683          	lbu	a3,-1(a1)
 4e0:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 4e4:	fef71ae3          	bne	a4,a5,4d8 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 4e8:	6422                	ld	s0,8(sp)
 4ea:	0141                	add	sp,sp,16
 4ec:	8082                	ret
    dst += n;
 4ee:	00c50733          	add	a4,a0,a2
    src += n;
 4f2:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 4f4:	fec05ae3          	blez	a2,4e8 <memmove+0x28>
 4f8:	fff6079b          	addw	a5,a2,-1
 4fc:	1782                	sll	a5,a5,0x20
 4fe:	9381                	srl	a5,a5,0x20
 500:	fff7c793          	not	a5,a5
 504:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 506:	15fd                	add	a1,a1,-1
 508:	177d                	add	a4,a4,-1
 50a:	0005c683          	lbu	a3,0(a1)
 50e:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 512:	fee79ae3          	bne	a5,a4,506 <memmove+0x46>
 516:	bfc9                	j	4e8 <memmove+0x28>

0000000000000518 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 518:	1141                	add	sp,sp,-16
 51a:	e422                	sd	s0,8(sp)
 51c:	0800                	add	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 51e:	ca05                	beqz	a2,54e <memcmp+0x36>
 520:	fff6069b          	addw	a3,a2,-1
 524:	1682                	sll	a3,a3,0x20
 526:	9281                	srl	a3,a3,0x20
 528:	0685                	add	a3,a3,1
 52a:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 52c:	00054783          	lbu	a5,0(a0)
 530:	0005c703          	lbu	a4,0(a1)
 534:	00e79863          	bne	a5,a4,544 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 538:	0505                	add	a0,a0,1
    p2++;
 53a:	0585                	add	a1,a1,1
  while (n-- > 0) {
 53c:	fed518e3          	bne	a0,a3,52c <memcmp+0x14>
  }
  return 0;
 540:	4501                	li	a0,0
 542:	a019                	j	548 <memcmp+0x30>
      return *p1 - *p2;
 544:	40e7853b          	subw	a0,a5,a4
}
 548:	6422                	ld	s0,8(sp)
 54a:	0141                	add	sp,sp,16
 54c:	8082                	ret
  return 0;
 54e:	4501                	li	a0,0
 550:	bfe5                	j	548 <memcmp+0x30>

0000000000000552 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 552:	1141                	add	sp,sp,-16
 554:	e406                	sd	ra,8(sp)
 556:	e022                	sd	s0,0(sp)
 558:	0800                	add	s0,sp,16
  return memmove(dst, src, n);
 55a:	f67ff0ef          	jal	4c0 <memmove>
}
 55e:	60a2                	ld	ra,8(sp)
 560:	6402                	ld	s0,0(sp)
 562:	0141                	add	sp,sp,16
 564:	8082                	ret

0000000000000566 <sbrk>:

char *
sbrk(int n) {
 566:	1141                	add	sp,sp,-16
 568:	e406                	sd	ra,8(sp)
 56a:	e022                	sd	s0,0(sp)
 56c:	0800                	add	s0,sp,16
  return sys_sbrk(n, SBRK_EAGER);
 56e:	4585                	li	a1,1
 570:	152000ef          	jal	6c2 <sys_sbrk>
}
 574:	60a2                	ld	ra,8(sp)
 576:	6402                	ld	s0,0(sp)
 578:	0141                	add	sp,sp,16
 57a:	8082                	ret

000000000000057c <sbrklazy>:

char *
sbrklazy(int n) {
 57c:	1141                	add	sp,sp,-16
 57e:	e406                	sd	ra,8(sp)
 580:	e022                	sd	s0,0(sp)
 582:	0800                	add	s0,sp,16
  return sys_sbrk(n, SBRK_LAZY);
 584:	4589                	li	a1,2
 586:	13c000ef          	jal	6c2 <sys_sbrk>
}
 58a:	60a2                	ld	ra,8(sp)
 58c:	6402                	ld	s0,0(sp)
 58e:	0141                	add	sp,sp,16
 590:	8082                	ret

0000000000000592 <htons>:

// Byte order conversion functions
unsigned short
htons(unsigned short hostshort)
{
 592:	1141                	add	sp,sp,-16
 594:	e422                	sd	s0,8(sp)
 596:	0800                	add	s0,sp,16
  return ((hostshort >> 8) & 0xff) | ((hostshort & 0xff) << 8);
 598:	0085179b          	sllw	a5,a0,0x8
 59c:	0085551b          	srlw	a0,a0,0x8
 5a0:	8d5d                	or	a0,a0,a5
}
 5a2:	1542                	sll	a0,a0,0x30
 5a4:	9141                	srl	a0,a0,0x30
 5a6:	6422                	ld	s0,8(sp)
 5a8:	0141                	add	sp,sp,16
 5aa:	8082                	ret

00000000000005ac <ntohs>:

unsigned short
ntohs(unsigned short netshort)
{
 5ac:	1141                	add	sp,sp,-16
 5ae:	e422                	sd	s0,8(sp)
 5b0:	0800                	add	s0,sp,16
  return ((netshort >> 8) & 0xff) | ((netshort & 0xff) << 8);
 5b2:	0085179b          	sllw	a5,a0,0x8
 5b6:	0085551b          	srlw	a0,a0,0x8
 5ba:	8d5d                	or	a0,a0,a5
}
 5bc:	1542                	sll	a0,a0,0x30
 5be:	9141                	srl	a0,a0,0x30
 5c0:	6422                	ld	s0,8(sp)
 5c2:	0141                	add	sp,sp,16
 5c4:	8082                	ret

00000000000005c6 <htonl>:

unsigned long
htonl(unsigned long hostlong)
{
 5c6:	1141                	add	sp,sp,-16
 5c8:	e422                	sd	s0,8(sp)
 5ca:	0800                	add	s0,sp,16
  return ((hostlong >> 24) & 0xff) |
 5cc:	0185579b          	srlw	a5,a0,0x18
         ((hostlong >> 8) & 0xff00) |
 5d0:	00855713          	srl	a4,a0,0x8
 5d4:	66c1                	lui	a3,0x10
 5d6:	f0068693          	add	a3,a3,-256 # ff00 <base+0xeee0>
 5da:	8f75                	and	a4,a4,a3
  return ((hostlong >> 24) & 0xff) |
 5dc:	8fd9                	or	a5,a5,a4
         ((hostlong & 0xff00) << 8) |
 5de:	00851713          	sll	a4,a0,0x8
 5e2:	00ff06b7          	lui	a3,0xff0
 5e6:	8f75                	and	a4,a4,a3
         ((hostlong >> 8) & 0xff00) |
 5e8:	8fd9                	or	a5,a5,a4
         ((hostlong & 0xff) << 24);
 5ea:	0562                	sll	a0,a0,0x18
 5ec:	0ff00713          	li	a4,255
 5f0:	0762                	sll	a4,a4,0x18
 5f2:	8d79                	and	a0,a0,a4
}
 5f4:	8d5d                	or	a0,a0,a5
 5f6:	6422                	ld	s0,8(sp)
 5f8:	0141                	add	sp,sp,16
 5fa:	8082                	ret

00000000000005fc <ntohl>:

unsigned long
ntohl(unsigned long netlong)
{
 5fc:	1141                	add	sp,sp,-16
 5fe:	e422                	sd	s0,8(sp)
 600:	0800                	add	s0,sp,16
  return ((netlong >> 24) & 0xff) |
 602:	0185579b          	srlw	a5,a0,0x18
         ((netlong >> 8) & 0xff00) |
 606:	00855713          	srl	a4,a0,0x8
 60a:	66c1                	lui	a3,0x10
 60c:	f0068693          	add	a3,a3,-256 # ff00 <base+0xeee0>
 610:	8f75                	and	a4,a4,a3
  return ((netlong >> 24) & 0xff) |
 612:	8fd9                	or	a5,a5,a4
         ((netlong & 0xff00) << 8) |
 614:	00851713          	sll	a4,a0,0x8
 618:	00ff06b7          	lui	a3,0xff0
 61c:	8f75                	and	a4,a4,a3
         ((netlong >> 8) & 0xff00) |
 61e:	8fd9                	or	a5,a5,a4
         ((netlong & 0xff) << 24);
 620:	0562                	sll	a0,a0,0x18
 622:	0ff00713          	li	a4,255
 626:	0762                	sll	a4,a4,0x18
 628:	8d79                	and	a0,a0,a4
}
 62a:	8d5d                	or	a0,a0,a5
 62c:	6422                	ld	s0,8(sp)
 62e:	0141                	add	sp,sp,16
 630:	8082                	ret

0000000000000632 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 632:	4885                	li	a7,1
 ecall
 634:	00000073          	ecall
 ret
 638:	8082                	ret

000000000000063a <exit>:
.global exit
exit:
 li a7, SYS_exit
 63a:	4889                	li	a7,2
 ecall
 63c:	00000073          	ecall
 ret
 640:	8082                	ret

0000000000000642 <wait>:
.global wait
wait:
 li a7, SYS_wait
 642:	488d                	li	a7,3
 ecall
 644:	00000073          	ecall
 ret
 648:	8082                	ret

000000000000064a <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 64a:	4891                	li	a7,4
 ecall
 64c:	00000073          	ecall
 ret
 650:	8082                	ret

0000000000000652 <read>:
.global read
read:
 li a7, SYS_read
 652:	4895                	li	a7,5
 ecall
 654:	00000073          	ecall
 ret
 658:	8082                	ret

000000000000065a <write>:
.global write
write:
 li a7, SYS_write
 65a:	48c1                	li	a7,16
 ecall
 65c:	00000073          	ecall
 ret
 660:	8082                	ret

0000000000000662 <close>:
.global close
close:
 li a7, SYS_close
 662:	48d5                	li	a7,21
 ecall
 664:	00000073          	ecall
 ret
 668:	8082                	ret

000000000000066a <kill>:
.global kill
kill:
 li a7, SYS_kill
 66a:	4899                	li	a7,6
 ecall
 66c:	00000073          	ecall
 ret
 670:	8082                	ret

0000000000000672 <exec>:
.global exec
exec:
 li a7, SYS_exec
 672:	489d                	li	a7,7
 ecall
 674:	00000073          	ecall
 ret
 678:	8082                	ret

000000000000067a <open>:
.global open
open:
 li a7, SYS_open
 67a:	48bd                	li	a7,15
 ecall
 67c:	00000073          	ecall
 ret
 680:	8082                	ret

0000000000000682 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 682:	48c5                	li	a7,17
 ecall
 684:	00000073          	ecall
 ret
 688:	8082                	ret

000000000000068a <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 68a:	48c9                	li	a7,18
 ecall
 68c:	00000073          	ecall
 ret
 690:	8082                	ret

0000000000000692 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 692:	48a1                	li	a7,8
 ecall
 694:	00000073          	ecall
 ret
 698:	8082                	ret

000000000000069a <link>:
.global link
link:
 li a7, SYS_link
 69a:	48cd                	li	a7,19
 ecall
 69c:	00000073          	ecall
 ret
 6a0:	8082                	ret

00000000000006a2 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 6a2:	48d1                	li	a7,20
 ecall
 6a4:	00000073          	ecall
 ret
 6a8:	8082                	ret

00000000000006aa <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 6aa:	48a5                	li	a7,9
 ecall
 6ac:	00000073          	ecall
 ret
 6b0:	8082                	ret

00000000000006b2 <dup>:
.global dup
dup:
 li a7, SYS_dup
 6b2:	48a9                	li	a7,10
 ecall
 6b4:	00000073          	ecall
 ret
 6b8:	8082                	ret

00000000000006ba <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 6ba:	48ad                	li	a7,11
 ecall
 6bc:	00000073          	ecall
 ret
 6c0:	8082                	ret

00000000000006c2 <sys_sbrk>:
.global sys_sbrk
sys_sbrk:
 li a7, SYS_sbrk
 6c2:	48b1                	li	a7,12
 ecall
 6c4:	00000073          	ecall
 ret
 6c8:	8082                	ret

00000000000006ca <pause>:
.global pause
pause:
 li a7, SYS_pause
 6ca:	48b5                	li	a7,13
 ecall
 6cc:	00000073          	ecall
 ret
 6d0:	8082                	ret

00000000000006d2 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 6d2:	48b9                	li	a7,14
 ecall
 6d4:	00000073          	ecall
 ret
 6d8:	8082                	ret

00000000000006da <socket>:
.global socket
socket:
 li a7, SYS_socket
 6da:	48d9                	li	a7,22
 ecall
 6dc:	00000073          	ecall
 ret
 6e0:	8082                	ret

00000000000006e2 <bind>:
.global bind
bind:
 li a7, SYS_bind
 6e2:	48dd                	li	a7,23
 ecall
 6e4:	00000073          	ecall
 ret
 6e8:	8082                	ret

00000000000006ea <listen>:
.global listen
listen:
 li a7, SYS_listen
 6ea:	48e1                	li	a7,24
 ecall
 6ec:	00000073          	ecall
 ret
 6f0:	8082                	ret

00000000000006f2 <accept>:
.global accept
accept:
 li a7, SYS_accept
 6f2:	48e5                	li	a7,25
 ecall
 6f4:	00000073          	ecall
 ret
 6f8:	8082                	ret

00000000000006fa <connect>:
.global connect
connect:
 li a7, SYS_connect
 6fa:	48e9                	li	a7,26
 ecall
 6fc:	00000073          	ecall
 ret
 700:	8082                	ret

0000000000000702 <send>:
.global send
send:
 li a7, SYS_send
 702:	48ed                	li	a7,27
 ecall
 704:	00000073          	ecall
 ret
 708:	8082                	ret

000000000000070a <recv>:
.global recv
recv:
 li a7, SYS_recv
 70a:	48f1                	li	a7,28
 ecall
 70c:	00000073          	ecall
 ret
 710:	8082                	ret

0000000000000712 <sendto>:
.global sendto
sendto:
 li a7, SYS_sendto
 712:	48f5                	li	a7,29
 ecall
 714:	00000073          	ecall
 ret
 718:	8082                	ret

000000000000071a <recvfrom>:
.global recvfrom
recvfrom:
 li a7, SYS_recvfrom
 71a:	48f9                	li	a7,30
 ecall
 71c:	00000073          	ecall
 ret
 720:	8082                	ret

0000000000000722 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 722:	1101                	add	sp,sp,-32
 724:	ec06                	sd	ra,24(sp)
 726:	e822                	sd	s0,16(sp)
 728:	1000                	add	s0,sp,32
 72a:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 72e:	4605                	li	a2,1
 730:	fef40593          	add	a1,s0,-17
 734:	f27ff0ef          	jal	65a <write>
}
 738:	60e2                	ld	ra,24(sp)
 73a:	6442                	ld	s0,16(sp)
 73c:	6105                	add	sp,sp,32
 73e:	8082                	ret

0000000000000740 <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
 740:	715d                	add	sp,sp,-80
 742:	e486                	sd	ra,72(sp)
 744:	e0a2                	sd	s0,64(sp)
 746:	f84a                	sd	s2,48(sp)
 748:	0880                	add	s0,sp,80
 74a:	892a                	mv	s2,a0
  char buf[20];
  int i, neg;
  unsigned long long x;

  neg = 0;
  if(sgn && xx < 0){
 74c:	c299                	beqz	a3,752 <printint+0x12>
 74e:	0805c363          	bltz	a1,7d4 <printint+0x94>
  neg = 0;
 752:	4881                	li	a7,0
 754:	fb840693          	add	a3,s0,-72
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
 758:	4781                	li	a5,0
  do{
    buf[i++] = digits[x % base];
 75a:	00000517          	auipc	a0,0x0
 75e:	56e50513          	add	a0,a0,1390 # cc8 <digits>
 762:	883e                	mv	a6,a5
 764:	2785                	addw	a5,a5,1
 766:	02c5f733          	remu	a4,a1,a2
 76a:	972a                	add	a4,a4,a0
 76c:	00074703          	lbu	a4,0(a4)
 770:	00e68023          	sb	a4,0(a3) # ff0000 <base+0xfeefe0>
  }while((x /= base) != 0);
 774:	872e                	mv	a4,a1
 776:	02c5d5b3          	divu	a1,a1,a2
 77a:	0685                	add	a3,a3,1
 77c:	fec773e3          	bgeu	a4,a2,762 <printint+0x22>
  if(neg)
 780:	00088b63          	beqz	a7,796 <printint+0x56>
    buf[i++] = '-';
 784:	fd078793          	add	a5,a5,-48
 788:	97a2                	add	a5,a5,s0
 78a:	02d00713          	li	a4,45
 78e:	fee78423          	sb	a4,-24(a5)
 792:	0028079b          	addw	a5,a6,2

  while(--i >= 0)
 796:	02f05a63          	blez	a5,7ca <printint+0x8a>
 79a:	fc26                	sd	s1,56(sp)
 79c:	f44e                	sd	s3,40(sp)
 79e:	fb840713          	add	a4,s0,-72
 7a2:	00f704b3          	add	s1,a4,a5
 7a6:	fff70993          	add	s3,a4,-1
 7aa:	99be                	add	s3,s3,a5
 7ac:	37fd                	addw	a5,a5,-1
 7ae:	1782                	sll	a5,a5,0x20
 7b0:	9381                	srl	a5,a5,0x20
 7b2:	40f989b3          	sub	s3,s3,a5
    putc(fd, buf[i]);
 7b6:	fff4c583          	lbu	a1,-1(s1)
 7ba:	854a                	mv	a0,s2
 7bc:	f67ff0ef          	jal	722 <putc>
  while(--i >= 0)
 7c0:	14fd                	add	s1,s1,-1
 7c2:	ff349ae3          	bne	s1,s3,7b6 <printint+0x76>
 7c6:	74e2                	ld	s1,56(sp)
 7c8:	79a2                	ld	s3,40(sp)
}
 7ca:	60a6                	ld	ra,72(sp)
 7cc:	6406                	ld	s0,64(sp)
 7ce:	7942                	ld	s2,48(sp)
 7d0:	6161                	add	sp,sp,80
 7d2:	8082                	ret
    x = -xx;
 7d4:	40b005b3          	neg	a1,a1
    neg = 1;
 7d8:	4885                	li	a7,1
    x = -xx;
 7da:	bfad                	j	754 <printint+0x14>

00000000000007dc <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %c, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 7dc:	711d                	add	sp,sp,-96
 7de:	ec86                	sd	ra,88(sp)
 7e0:	e8a2                	sd	s0,80(sp)
 7e2:	e0ca                	sd	s2,64(sp)
 7e4:	1080                	add	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 7e6:	0005c903          	lbu	s2,0(a1)
 7ea:	28090663          	beqz	s2,a76 <vprintf+0x29a>
 7ee:	e4a6                	sd	s1,72(sp)
 7f0:	fc4e                	sd	s3,56(sp)
 7f2:	f852                	sd	s4,48(sp)
 7f4:	f456                	sd	s5,40(sp)
 7f6:	f05a                	sd	s6,32(sp)
 7f8:	ec5e                	sd	s7,24(sp)
 7fa:	e862                	sd	s8,16(sp)
 7fc:	e466                	sd	s9,8(sp)
 7fe:	8b2a                	mv	s6,a0
 800:	8a2e                	mv	s4,a1
 802:	8bb2                	mv	s7,a2
  state = 0;
 804:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
 806:	4481                	li	s1,0
 808:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
 80a:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
 80e:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
 812:	06c00c93          	li	s9,108
 816:	a005                	j	836 <vprintf+0x5a>
        putc(fd, c0);
 818:	85ca                	mv	a1,s2
 81a:	855a                	mv	a0,s6
 81c:	f07ff0ef          	jal	722 <putc>
 820:	a019                	j	826 <vprintf+0x4a>
    } else if(state == '%'){
 822:	03598263          	beq	s3,s5,846 <vprintf+0x6a>
  for(i = 0; fmt[i]; i++){
 826:	2485                	addw	s1,s1,1
 828:	8726                	mv	a4,s1
 82a:	009a07b3          	add	a5,s4,s1
 82e:	0007c903          	lbu	s2,0(a5)
 832:	22090a63          	beqz	s2,a66 <vprintf+0x28a>
    c0 = fmt[i] & 0xff;
 836:	0009079b          	sext.w	a5,s2
    if(state == 0){
 83a:	fe0994e3          	bnez	s3,822 <vprintf+0x46>
      if(c0 == '%'){
 83e:	fd579de3          	bne	a5,s5,818 <vprintf+0x3c>
        state = '%';
 842:	89be                	mv	s3,a5
 844:	b7cd                	j	826 <vprintf+0x4a>
      if(c0) c1 = fmt[i+1] & 0xff;
 846:	00ea06b3          	add	a3,s4,a4
 84a:	0016c683          	lbu	a3,1(a3)
      c1 = c2 = 0;
 84e:	8636                	mv	a2,a3
      if(c1) c2 = fmt[i+2] & 0xff;
 850:	c681                	beqz	a3,858 <vprintf+0x7c>
 852:	9752                	add	a4,a4,s4
 854:	00274603          	lbu	a2,2(a4)
      if(c0 == 'd'){
 858:	05878363          	beq	a5,s8,89e <vprintf+0xc2>
      } else if(c0 == 'l' && c1 == 'd'){
 85c:	05978d63          	beq	a5,s9,8b6 <vprintf+0xda>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
 860:	07500713          	li	a4,117
 864:	0ee78763          	beq	a5,a4,952 <vprintf+0x176>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
 868:	07800713          	li	a4,120
 86c:	12e78963          	beq	a5,a4,99e <vprintf+0x1c2>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
 870:	07000713          	li	a4,112
 874:	14e78e63          	beq	a5,a4,9d0 <vprintf+0x1f4>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 'c'){
 878:	06300713          	li	a4,99
 87c:	18e78e63          	beq	a5,a4,a18 <vprintf+0x23c>
        putc(fd, va_arg(ap, uint32));
      } else if(c0 == 's'){
 880:	07300713          	li	a4,115
 884:	1ae78463          	beq	a5,a4,a2c <vprintf+0x250>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
 888:	02500713          	li	a4,37
 88c:	04e79563          	bne	a5,a4,8d6 <vprintf+0xfa>
        putc(fd, '%');
 890:	02500593          	li	a1,37
 894:	855a                	mv	a0,s6
 896:	e8dff0ef          	jal	722 <putc>
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c0);
      }

      state = 0;
 89a:	4981                	li	s3,0
 89c:	b769                	j	826 <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 1);
 89e:	008b8913          	add	s2,s7,8
 8a2:	4685                	li	a3,1
 8a4:	4629                	li	a2,10
 8a6:	000ba583          	lw	a1,0(s7)
 8aa:	855a                	mv	a0,s6
 8ac:	e95ff0ef          	jal	740 <printint>
 8b0:	8bca                	mv	s7,s2
      state = 0;
 8b2:	4981                	li	s3,0
 8b4:	bf8d                	j	826 <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'd'){
 8b6:	06400793          	li	a5,100
 8ba:	02f68963          	beq	a3,a5,8ec <vprintf+0x110>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 8be:	06c00793          	li	a5,108
 8c2:	04f68263          	beq	a3,a5,906 <vprintf+0x12a>
      } else if(c0 == 'l' && c1 == 'u'){
 8c6:	07500793          	li	a5,117
 8ca:	0af68063          	beq	a3,a5,96a <vprintf+0x18e>
      } else if(c0 == 'l' && c1 == 'x'){
 8ce:	07800793          	li	a5,120
 8d2:	0ef68263          	beq	a3,a5,9b6 <vprintf+0x1da>
        putc(fd, '%');
 8d6:	02500593          	li	a1,37
 8da:	855a                	mv	a0,s6
 8dc:	e47ff0ef          	jal	722 <putc>
        putc(fd, c0);
 8e0:	85ca                	mv	a1,s2
 8e2:	855a                	mv	a0,s6
 8e4:	e3fff0ef          	jal	722 <putc>
      state = 0;
 8e8:	4981                	li	s3,0
 8ea:	bf35                	j	826 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 8ec:	008b8913          	add	s2,s7,8
 8f0:	4685                	li	a3,1
 8f2:	4629                	li	a2,10
 8f4:	000bb583          	ld	a1,0(s7)
 8f8:	855a                	mv	a0,s6
 8fa:	e47ff0ef          	jal	740 <printint>
        i += 1;
 8fe:	2485                	addw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 900:	8bca                	mv	s7,s2
      state = 0;
 902:	4981                	li	s3,0
        i += 1;
 904:	b70d                	j	826 <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 906:	06400793          	li	a5,100
 90a:	02f60763          	beq	a2,a5,938 <vprintf+0x15c>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 90e:	07500793          	li	a5,117
 912:	06f60963          	beq	a2,a5,984 <vprintf+0x1a8>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 916:	07800793          	li	a5,120
 91a:	faf61ee3          	bne	a2,a5,8d6 <vprintf+0xfa>
        printint(fd, va_arg(ap, uint64), 16, 0);
 91e:	008b8913          	add	s2,s7,8
 922:	4681                	li	a3,0
 924:	4641                	li	a2,16
 926:	000bb583          	ld	a1,0(s7)
 92a:	855a                	mv	a0,s6
 92c:	e15ff0ef          	jal	740 <printint>
        i += 2;
 930:	2489                	addw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 932:	8bca                	mv	s7,s2
      state = 0;
 934:	4981                	li	s3,0
        i += 2;
 936:	bdc5                	j	826 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 938:	008b8913          	add	s2,s7,8
 93c:	4685                	li	a3,1
 93e:	4629                	li	a2,10
 940:	000bb583          	ld	a1,0(s7)
 944:	855a                	mv	a0,s6
 946:	dfbff0ef          	jal	740 <printint>
        i += 2;
 94a:	2489                	addw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 94c:	8bca                	mv	s7,s2
      state = 0;
 94e:	4981                	li	s3,0
        i += 2;
 950:	bdd9                	j	826 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint32), 10, 0);
 952:	008b8913          	add	s2,s7,8
 956:	4681                	li	a3,0
 958:	4629                	li	a2,10
 95a:	000be583          	lwu	a1,0(s7)
 95e:	855a                	mv	a0,s6
 960:	de1ff0ef          	jal	740 <printint>
 964:	8bca                	mv	s7,s2
      state = 0;
 966:	4981                	li	s3,0
 968:	bd7d                	j	826 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 96a:	008b8913          	add	s2,s7,8
 96e:	4681                	li	a3,0
 970:	4629                	li	a2,10
 972:	000bb583          	ld	a1,0(s7)
 976:	855a                	mv	a0,s6
 978:	dc9ff0ef          	jal	740 <printint>
        i += 1;
 97c:	2485                	addw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 97e:	8bca                	mv	s7,s2
      state = 0;
 980:	4981                	li	s3,0
        i += 1;
 982:	b555                	j	826 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 984:	008b8913          	add	s2,s7,8
 988:	4681                	li	a3,0
 98a:	4629                	li	a2,10
 98c:	000bb583          	ld	a1,0(s7)
 990:	855a                	mv	a0,s6
 992:	dafff0ef          	jal	740 <printint>
        i += 2;
 996:	2489                	addw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 998:	8bca                	mv	s7,s2
      state = 0;
 99a:	4981                	li	s3,0
        i += 2;
 99c:	b569                	j	826 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint32), 16, 0);
 99e:	008b8913          	add	s2,s7,8
 9a2:	4681                	li	a3,0
 9a4:	4641                	li	a2,16
 9a6:	000be583          	lwu	a1,0(s7)
 9aa:	855a                	mv	a0,s6
 9ac:	d95ff0ef          	jal	740 <printint>
 9b0:	8bca                	mv	s7,s2
      state = 0;
 9b2:	4981                	li	s3,0
 9b4:	bd8d                	j	826 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 16, 0);
 9b6:	008b8913          	add	s2,s7,8
 9ba:	4681                	li	a3,0
 9bc:	4641                	li	a2,16
 9be:	000bb583          	ld	a1,0(s7)
 9c2:	855a                	mv	a0,s6
 9c4:	d7dff0ef          	jal	740 <printint>
        i += 1;
 9c8:	2485                	addw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 9ca:	8bca                	mv	s7,s2
      state = 0;
 9cc:	4981                	li	s3,0
        i += 1;
 9ce:	bda1                	j	826 <vprintf+0x4a>
 9d0:	e06a                	sd	s10,0(sp)
        printptr(fd, va_arg(ap, uint64));
 9d2:	008b8d13          	add	s10,s7,8
 9d6:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 9da:	03000593          	li	a1,48
 9de:	855a                	mv	a0,s6
 9e0:	d43ff0ef          	jal	722 <putc>
  putc(fd, 'x');
 9e4:	07800593          	li	a1,120
 9e8:	855a                	mv	a0,s6
 9ea:	d39ff0ef          	jal	722 <putc>
 9ee:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 9f0:	00000b97          	auipc	s7,0x0
 9f4:	2d8b8b93          	add	s7,s7,728 # cc8 <digits>
 9f8:	03c9d793          	srl	a5,s3,0x3c
 9fc:	97de                	add	a5,a5,s7
 9fe:	0007c583          	lbu	a1,0(a5)
 a02:	855a                	mv	a0,s6
 a04:	d1fff0ef          	jal	722 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 a08:	0992                	sll	s3,s3,0x4
 a0a:	397d                	addw	s2,s2,-1
 a0c:	fe0916e3          	bnez	s2,9f8 <vprintf+0x21c>
        printptr(fd, va_arg(ap, uint64));
 a10:	8bea                	mv	s7,s10
      state = 0;
 a12:	4981                	li	s3,0
 a14:	6d02                	ld	s10,0(sp)
 a16:	bd01                	j	826 <vprintf+0x4a>
        putc(fd, va_arg(ap, uint32));
 a18:	008b8913          	add	s2,s7,8
 a1c:	000bc583          	lbu	a1,0(s7)
 a20:	855a                	mv	a0,s6
 a22:	d01ff0ef          	jal	722 <putc>
 a26:	8bca                	mv	s7,s2
      state = 0;
 a28:	4981                	li	s3,0
 a2a:	bbf5                	j	826 <vprintf+0x4a>
        if((s = va_arg(ap, char*)) == 0)
 a2c:	008b8993          	add	s3,s7,8
 a30:	000bb903          	ld	s2,0(s7)
 a34:	00090f63          	beqz	s2,a52 <vprintf+0x276>
        for(; *s; s++)
 a38:	00094583          	lbu	a1,0(s2)
 a3c:	c195                	beqz	a1,a60 <vprintf+0x284>
          putc(fd, *s);
 a3e:	855a                	mv	a0,s6
 a40:	ce3ff0ef          	jal	722 <putc>
        for(; *s; s++)
 a44:	0905                	add	s2,s2,1
 a46:	00094583          	lbu	a1,0(s2)
 a4a:	f9f5                	bnez	a1,a3e <vprintf+0x262>
        if((s = va_arg(ap, char*)) == 0)
 a4c:	8bce                	mv	s7,s3
      state = 0;
 a4e:	4981                	li	s3,0
 a50:	bbd9                	j	826 <vprintf+0x4a>
          s = "(null)";
 a52:	00000917          	auipc	s2,0x0
 a56:	26e90913          	add	s2,s2,622 # cc0 <malloc+0x162>
        for(; *s; s++)
 a5a:	02800593          	li	a1,40
 a5e:	b7c5                	j	a3e <vprintf+0x262>
        if((s = va_arg(ap, char*)) == 0)
 a60:	8bce                	mv	s7,s3
      state = 0;
 a62:	4981                	li	s3,0
 a64:	b3c9                	j	826 <vprintf+0x4a>
 a66:	64a6                	ld	s1,72(sp)
 a68:	79e2                	ld	s3,56(sp)
 a6a:	7a42                	ld	s4,48(sp)
 a6c:	7aa2                	ld	s5,40(sp)
 a6e:	7b02                	ld	s6,32(sp)
 a70:	6be2                	ld	s7,24(sp)
 a72:	6c42                	ld	s8,16(sp)
 a74:	6ca2                	ld	s9,8(sp)
    }
  }
}
 a76:	60e6                	ld	ra,88(sp)
 a78:	6446                	ld	s0,80(sp)
 a7a:	6906                	ld	s2,64(sp)
 a7c:	6125                	add	sp,sp,96
 a7e:	8082                	ret

0000000000000a80 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 a80:	715d                	add	sp,sp,-80
 a82:	ec06                	sd	ra,24(sp)
 a84:	e822                	sd	s0,16(sp)
 a86:	1000                	add	s0,sp,32
 a88:	e010                	sd	a2,0(s0)
 a8a:	e414                	sd	a3,8(s0)
 a8c:	e818                	sd	a4,16(s0)
 a8e:	ec1c                	sd	a5,24(s0)
 a90:	03043023          	sd	a6,32(s0)
 a94:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 a98:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 a9c:	8622                	mv	a2,s0
 a9e:	d3fff0ef          	jal	7dc <vprintf>
}
 aa2:	60e2                	ld	ra,24(sp)
 aa4:	6442                	ld	s0,16(sp)
 aa6:	6161                	add	sp,sp,80
 aa8:	8082                	ret

0000000000000aaa <printf>:

void
printf(const char *fmt, ...)
{
 aaa:	711d                	add	sp,sp,-96
 aac:	ec06                	sd	ra,24(sp)
 aae:	e822                	sd	s0,16(sp)
 ab0:	1000                	add	s0,sp,32
 ab2:	e40c                	sd	a1,8(s0)
 ab4:	e810                	sd	a2,16(s0)
 ab6:	ec14                	sd	a3,24(s0)
 ab8:	f018                	sd	a4,32(s0)
 aba:	f41c                	sd	a5,40(s0)
 abc:	03043823          	sd	a6,48(s0)
 ac0:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 ac4:	00840613          	add	a2,s0,8
 ac8:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 acc:	85aa                	mv	a1,a0
 ace:	4505                	li	a0,1
 ad0:	d0dff0ef          	jal	7dc <vprintf>
}
 ad4:	60e2                	ld	ra,24(sp)
 ad6:	6442                	ld	s0,16(sp)
 ad8:	6125                	add	sp,sp,96
 ada:	8082                	ret

0000000000000adc <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 adc:	1141                	add	sp,sp,-16
 ade:	e422                	sd	s0,8(sp)
 ae0:	0800                	add	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 ae2:	ff050693          	add	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 ae6:	00000797          	auipc	a5,0x0
 aea:	51a7b783          	ld	a5,1306(a5) # 1000 <freep>
 aee:	a02d                	j	b18 <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 af0:	4618                	lw	a4,8(a2)
 af2:	9f2d                	addw	a4,a4,a1
 af4:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 af8:	6398                	ld	a4,0(a5)
 afa:	6310                	ld	a2,0(a4)
 afc:	a83d                	j	b3a <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 afe:	ff852703          	lw	a4,-8(a0)
 b02:	9f31                	addw	a4,a4,a2
 b04:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 b06:	ff053683          	ld	a3,-16(a0)
 b0a:	a091                	j	b4e <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 b0c:	6398                	ld	a4,0(a5)
 b0e:	00e7e463          	bltu	a5,a4,b16 <free+0x3a>
 b12:	00e6ea63          	bltu	a3,a4,b26 <free+0x4a>
{
 b16:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 b18:	fed7fae3          	bgeu	a5,a3,b0c <free+0x30>
 b1c:	6398                	ld	a4,0(a5)
 b1e:	00e6e463          	bltu	a3,a4,b26 <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 b22:	fee7eae3          	bltu	a5,a4,b16 <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 b26:	ff852583          	lw	a1,-8(a0)
 b2a:	6390                	ld	a2,0(a5)
 b2c:	02059813          	sll	a6,a1,0x20
 b30:	01c85713          	srl	a4,a6,0x1c
 b34:	9736                	add	a4,a4,a3
 b36:	fae60de3          	beq	a2,a4,af0 <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 b3a:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 b3e:	4790                	lw	a2,8(a5)
 b40:	02061593          	sll	a1,a2,0x20
 b44:	01c5d713          	srl	a4,a1,0x1c
 b48:	973e                	add	a4,a4,a5
 b4a:	fae68ae3          	beq	a3,a4,afe <free+0x22>
    p->s.ptr = bp->s.ptr;
 b4e:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 b50:	00000717          	auipc	a4,0x0
 b54:	4af73823          	sd	a5,1200(a4) # 1000 <freep>
}
 b58:	6422                	ld	s0,8(sp)
 b5a:	0141                	add	sp,sp,16
 b5c:	8082                	ret

0000000000000b5e <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 b5e:	7139                	add	sp,sp,-64
 b60:	fc06                	sd	ra,56(sp)
 b62:	f822                	sd	s0,48(sp)
 b64:	f426                	sd	s1,40(sp)
 b66:	ec4e                	sd	s3,24(sp)
 b68:	0080                	add	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 b6a:	02051493          	sll	s1,a0,0x20
 b6e:	9081                	srl	s1,s1,0x20
 b70:	04bd                	add	s1,s1,15
 b72:	8091                	srl	s1,s1,0x4
 b74:	0014899b          	addw	s3,s1,1
 b78:	0485                	add	s1,s1,1
  if((prevp = freep) == 0){
 b7a:	00000517          	auipc	a0,0x0
 b7e:	48653503          	ld	a0,1158(a0) # 1000 <freep>
 b82:	c915                	beqz	a0,bb6 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 b84:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 b86:	4798                	lw	a4,8(a5)
 b88:	08977a63          	bgeu	a4,s1,c1c <malloc+0xbe>
 b8c:	f04a                	sd	s2,32(sp)
 b8e:	e852                	sd	s4,16(sp)
 b90:	e456                	sd	s5,8(sp)
 b92:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 b94:	8a4e                	mv	s4,s3
 b96:	0009871b          	sext.w	a4,s3
 b9a:	6685                	lui	a3,0x1
 b9c:	00d77363          	bgeu	a4,a3,ba2 <malloc+0x44>
 ba0:	6a05                	lui	s4,0x1
 ba2:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 ba6:	004a1a1b          	sllw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 baa:	00000917          	auipc	s2,0x0
 bae:	45690913          	add	s2,s2,1110 # 1000 <freep>
  if(p == SBRK_ERROR)
 bb2:	5afd                	li	s5,-1
 bb4:	a081                	j	bf4 <malloc+0x96>
 bb6:	f04a                	sd	s2,32(sp)
 bb8:	e852                	sd	s4,16(sp)
 bba:	e456                	sd	s5,8(sp)
 bbc:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 bbe:	00000797          	auipc	a5,0x0
 bc2:	46278793          	add	a5,a5,1122 # 1020 <base>
 bc6:	00000717          	auipc	a4,0x0
 bca:	42f73d23          	sd	a5,1082(a4) # 1000 <freep>
 bce:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 bd0:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 bd4:	b7c1                	j	b94 <malloc+0x36>
        prevp->s.ptr = p->s.ptr;
 bd6:	6398                	ld	a4,0(a5)
 bd8:	e118                	sd	a4,0(a0)
 bda:	a8a9                	j	c34 <malloc+0xd6>
  hp->s.size = nu;
 bdc:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 be0:	0541                	add	a0,a0,16
 be2:	efbff0ef          	jal	adc <free>
  return freep;
 be6:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 bea:	c12d                	beqz	a0,c4c <malloc+0xee>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 bec:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 bee:	4798                	lw	a4,8(a5)
 bf0:	02977263          	bgeu	a4,s1,c14 <malloc+0xb6>
    if(p == freep)
 bf4:	00093703          	ld	a4,0(s2)
 bf8:	853e                	mv	a0,a5
 bfa:	fef719e3          	bne	a4,a5,bec <malloc+0x8e>
  p = sbrk(nu * sizeof(Header));
 bfe:	8552                	mv	a0,s4
 c00:	967ff0ef          	jal	566 <sbrk>
  if(p == SBRK_ERROR)
 c04:	fd551ce3          	bne	a0,s5,bdc <malloc+0x7e>
        return 0;
 c08:	4501                	li	a0,0
 c0a:	7902                	ld	s2,32(sp)
 c0c:	6a42                	ld	s4,16(sp)
 c0e:	6aa2                	ld	s5,8(sp)
 c10:	6b02                	ld	s6,0(sp)
 c12:	a03d                	j	c40 <malloc+0xe2>
 c14:	7902                	ld	s2,32(sp)
 c16:	6a42                	ld	s4,16(sp)
 c18:	6aa2                	ld	s5,8(sp)
 c1a:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 c1c:	fae48de3          	beq	s1,a4,bd6 <malloc+0x78>
        p->s.size -= nunits;
 c20:	4137073b          	subw	a4,a4,s3
 c24:	c798                	sw	a4,8(a5)
        p += p->s.size;
 c26:	02071693          	sll	a3,a4,0x20
 c2a:	01c6d713          	srl	a4,a3,0x1c
 c2e:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 c30:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 c34:	00000717          	auipc	a4,0x0
 c38:	3ca73623          	sd	a0,972(a4) # 1000 <freep>
      return (void*)(p + 1);
 c3c:	01078513          	add	a0,a5,16
  }
}
 c40:	70e2                	ld	ra,56(sp)
 c42:	7442                	ld	s0,48(sp)
 c44:	74a2                	ld	s1,40(sp)
 c46:	69e2                	ld	s3,24(sp)
 c48:	6121                	add	sp,sp,64
 c4a:	8082                	ret
 c4c:	7902                	ld	s2,32(sp)
 c4e:	6a42                	ld	s4,16(sp)
 c50:	6aa2                	ld	s5,8(sp)
 c52:	6b02                	ld	s6,0(sp)
 c54:	b7f5                	j	c40 <malloc+0xe2>
