
user/_ls:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <fmtname>:
#include "user/user.h"
#include "kernel/fs.h"

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
   c:	00000097          	auipc	ra,0x0
  10:	314080e7          	jalr	788(ra) # 320 <strlen>
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
  38:	00000097          	auipc	ra,0x0
  3c:	2e8080e7          	jalr	744(ra) # 320 <strlen>
  40:	2501                	sext.w	a0,a0
  42:	47b5                	li	a5,13
  44:	00a7f863          	bgeu	a5,a0,54 <fmtname+0x54>
    return p;
  memmove(buf, p, strlen(p));
  memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
  return buf;
}
  48:	8526                	mv	a0,s1
  4a:	70a2                	ld	ra,40(sp)
  4c:	7402                	ld	s0,32(sp)
  4e:	64e2                	ld	s1,24(sp)
  50:	6145                	add	sp,sp,48
  52:	8082                	ret
  54:	e84a                	sd	s2,16(sp)
  56:	e44e                	sd	s3,8(sp)
  memmove(buf, p, strlen(p));
  58:	8526                	mv	a0,s1
  5a:	00000097          	auipc	ra,0x0
  5e:	2c6080e7          	jalr	710(ra) # 320 <strlen>
  62:	00001997          	auipc	s3,0x1
  66:	dbe98993          	add	s3,s3,-578 # e20 <buf.0>
  6a:	0005061b          	sext.w	a2,a0
  6e:	85a6                	mv	a1,s1
  70:	854e                	mv	a0,s3
  72:	00000097          	auipc	ra,0x0
  76:	44e080e7          	jalr	1102(ra) # 4c0 <memmove>
  memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
  7a:	8526                	mv	a0,s1
  7c:	00000097          	auipc	ra,0x0
  80:	2a4080e7          	jalr	676(ra) # 320 <strlen>
  84:	0005091b          	sext.w	s2,a0
  88:	8526                	mv	a0,s1
  8a:	00000097          	auipc	ra,0x0
  8e:	296080e7          	jalr	662(ra) # 320 <strlen>
  92:	1902                	sll	s2,s2,0x20
  94:	02095913          	srl	s2,s2,0x20
  98:	4639                	li	a2,14
  9a:	9e09                	subw	a2,a2,a0
  9c:	02000593          	li	a1,32
  a0:	01298533          	add	a0,s3,s2
  a4:	00000097          	auipc	ra,0x0
  a8:	2d4080e7          	jalr	724(ra) # 378 <memset>
  return buf;
  ac:	84ce                	mv	s1,s3
  ae:	6942                	ld	s2,16(sp)
  b0:	69a2                	ld	s3,8(sp)
  b2:	bf59                	j	48 <fmtname+0x48>

00000000000000b4 <ls>:

void
ls(char *path)
{
  b4:	d9010113          	add	sp,sp,-624
  b8:	26113423          	sd	ra,616(sp)
  bc:	26813023          	sd	s0,608(sp)
  c0:	25213823          	sd	s2,592(sp)
  c4:	1c80                	add	s0,sp,624
  c6:	892a                	mv	s2,a0
  char buf[512], *p;
  int fd;
  struct dirent de;
  struct stat st;

  if((fd = open(path, 0)) < 0){
  c8:	4581                	li	a1,0
  ca:	00000097          	auipc	ra,0x0
  ce:	4e8080e7          	jalr	1256(ra) # 5b2 <open>
  d2:	06054963          	bltz	a0,144 <ls+0x90>
  d6:	24913c23          	sd	s1,600(sp)
  da:	84aa                	mv	s1,a0
    fprintf(2, "ls: cannot open %s\n", path);
    return;
  }

  if(fstat(fd, &st) < 0){
  dc:	d9840593          	add	a1,s0,-616
  e0:	00000097          	auipc	ra,0x0
  e4:	4ea080e7          	jalr	1258(ra) # 5ca <fstat>
  e8:	06054963          	bltz	a0,15a <ls+0xa6>
    fprintf(2, "ls: cannot stat %s\n", path);
    close(fd);
    return;
  }

  switch(st.type){
  ec:	da041783          	lh	a5,-608(s0)
  f0:	4705                	li	a4,1
  f2:	08e78663          	beq	a5,a4,17e <ls+0xca>
  f6:	4709                	li	a4,2
  f8:	02e79663          	bne	a5,a4,124 <ls+0x70>
  case T_FILE:
    printf("%s %d %d %l\n", fmtname(path), st.type, st.ino, st.size);
  fc:	854a                	mv	a0,s2
  fe:	00000097          	auipc	ra,0x0
 102:	f02080e7          	jalr	-254(ra) # 0 <fmtname>
 106:	85aa                	mv	a1,a0
 108:	da843703          	ld	a4,-600(s0)
 10c:	d9c42683          	lw	a3,-612(s0)
 110:	da041603          	lh	a2,-608(s0)
 114:	00001517          	auipc	a0,0x1
 118:	c4c50513          	add	a0,a0,-948 # d60 <malloc+0x136>
 11c:	00001097          	auipc	ra,0x1
 120:	88e080e7          	jalr	-1906(ra) # 9aa <printf>
      }
      printf("%s %d %d %d\n", fmtname(buf), st.type, st.ino, st.size);
    }
    break;
  }
  close(fd);
 124:	8526                	mv	a0,s1
 126:	00000097          	auipc	ra,0x0
 12a:	474080e7          	jalr	1140(ra) # 59a <close>
 12e:	25813483          	ld	s1,600(sp)
}
 132:	26813083          	ld	ra,616(sp)
 136:	26013403          	ld	s0,608(sp)
 13a:	25013903          	ld	s2,592(sp)
 13e:	27010113          	add	sp,sp,624
 142:	8082                	ret
    fprintf(2, "ls: cannot open %s\n", path);
 144:	864a                	mv	a2,s2
 146:	00001597          	auipc	a1,0x1
 14a:	bea58593          	add	a1,a1,-1046 # d30 <malloc+0x106>
 14e:	4509                	li	a0,2
 150:	00001097          	auipc	ra,0x1
 154:	82c080e7          	jalr	-2004(ra) # 97c <fprintf>
    return;
 158:	bfe9                	j	132 <ls+0x7e>
    fprintf(2, "ls: cannot stat %s\n", path);
 15a:	864a                	mv	a2,s2
 15c:	00001597          	auipc	a1,0x1
 160:	bec58593          	add	a1,a1,-1044 # d48 <malloc+0x11e>
 164:	4509                	li	a0,2
 166:	00001097          	auipc	ra,0x1
 16a:	816080e7          	jalr	-2026(ra) # 97c <fprintf>
    close(fd);
 16e:	8526                	mv	a0,s1
 170:	00000097          	auipc	ra,0x0
 174:	42a080e7          	jalr	1066(ra) # 59a <close>
    return;
 178:	25813483          	ld	s1,600(sp)
 17c:	bf5d                	j	132 <ls+0x7e>
    if(strlen(path) + 1 + DIRSIZ + 1 > sizeof buf){
 17e:	854a                	mv	a0,s2
 180:	00000097          	auipc	ra,0x0
 184:	1a0080e7          	jalr	416(ra) # 320 <strlen>
 188:	2541                	addw	a0,a0,16
 18a:	20000793          	li	a5,512
 18e:	00a7fb63          	bgeu	a5,a0,1a4 <ls+0xf0>
      printf("ls: path too long\n");
 192:	00001517          	auipc	a0,0x1
 196:	bde50513          	add	a0,a0,-1058 # d70 <malloc+0x146>
 19a:	00001097          	auipc	ra,0x1
 19e:	810080e7          	jalr	-2032(ra) # 9aa <printf>
      break;
 1a2:	b749                	j	124 <ls+0x70>
 1a4:	25313423          	sd	s3,584(sp)
 1a8:	25413023          	sd	s4,576(sp)
 1ac:	23513c23          	sd	s5,568(sp)
    strcpy(buf, path);
 1b0:	85ca                	mv	a1,s2
 1b2:	dc040513          	add	a0,s0,-576
 1b6:	00000097          	auipc	ra,0x0
 1ba:	122080e7          	jalr	290(ra) # 2d8 <strcpy>
    p = buf+strlen(buf);
 1be:	dc040513          	add	a0,s0,-576
 1c2:	00000097          	auipc	ra,0x0
 1c6:	15e080e7          	jalr	350(ra) # 320 <strlen>
 1ca:	1502                	sll	a0,a0,0x20
 1cc:	9101                	srl	a0,a0,0x20
 1ce:	dc040793          	add	a5,s0,-576
 1d2:	00a78933          	add	s2,a5,a0
    *p++ = '/';
 1d6:	00190993          	add	s3,s2,1
 1da:	02f00793          	li	a5,47
 1de:	00f90023          	sb	a5,0(s2)
      printf("%s %d %d %d\n", fmtname(buf), st.type, st.ino, st.size);
 1e2:	00001a17          	auipc	s4,0x1
 1e6:	ba6a0a13          	add	s4,s4,-1114 # d88 <malloc+0x15e>
        printf("ls: cannot stat %s\n", buf);
 1ea:	00001a97          	auipc	s5,0x1
 1ee:	b5ea8a93          	add	s5,s5,-1186 # d48 <malloc+0x11e>
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
 1f2:	a801                	j	202 <ls+0x14e>
        printf("ls: cannot stat %s\n", buf);
 1f4:	dc040593          	add	a1,s0,-576
 1f8:	8556                	mv	a0,s5
 1fa:	00000097          	auipc	ra,0x0
 1fe:	7b0080e7          	jalr	1968(ra) # 9aa <printf>
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
 202:	4641                	li	a2,16
 204:	db040593          	add	a1,s0,-592
 208:	8526                	mv	a0,s1
 20a:	00000097          	auipc	ra,0x0
 20e:	380080e7          	jalr	896(ra) # 58a <read>
 212:	47c1                	li	a5,16
 214:	04f51c63          	bne	a0,a5,26c <ls+0x1b8>
      if(de.inum == 0)
 218:	db045783          	lhu	a5,-592(s0)
 21c:	d3fd                	beqz	a5,202 <ls+0x14e>
      memmove(p, de.name, DIRSIZ);
 21e:	4639                	li	a2,14
 220:	db240593          	add	a1,s0,-590
 224:	854e                	mv	a0,s3
 226:	00000097          	auipc	ra,0x0
 22a:	29a080e7          	jalr	666(ra) # 4c0 <memmove>
      p[DIRSIZ] = 0;
 22e:	000907a3          	sb	zero,15(s2)
      if(stat(buf, &st) < 0){
 232:	d9840593          	add	a1,s0,-616
 236:	dc040513          	add	a0,s0,-576
 23a:	00000097          	auipc	ra,0x0
 23e:	1f8080e7          	jalr	504(ra) # 432 <stat>
 242:	fa0549e3          	bltz	a0,1f4 <ls+0x140>
      printf("%s %d %d %d\n", fmtname(buf), st.type, st.ino, st.size);
 246:	dc040513          	add	a0,s0,-576
 24a:	00000097          	auipc	ra,0x0
 24e:	db6080e7          	jalr	-586(ra) # 0 <fmtname>
 252:	85aa                	mv	a1,a0
 254:	da843703          	ld	a4,-600(s0)
 258:	d9c42683          	lw	a3,-612(s0)
 25c:	da041603          	lh	a2,-608(s0)
 260:	8552                	mv	a0,s4
 262:	00000097          	auipc	ra,0x0
 266:	748080e7          	jalr	1864(ra) # 9aa <printf>
 26a:	bf61                	j	202 <ls+0x14e>
 26c:	24813983          	ld	s3,584(sp)
 270:	24013a03          	ld	s4,576(sp)
 274:	23813a83          	ld	s5,568(sp)
 278:	b575                	j	124 <ls+0x70>

000000000000027a <main>:

int
main(int argc, char *argv[])
{
 27a:	1101                	add	sp,sp,-32
 27c:	ec06                	sd	ra,24(sp)
 27e:	e822                	sd	s0,16(sp)
 280:	1000                	add	s0,sp,32
  int i;

  if(argc < 2){
 282:	4785                	li	a5,1
 284:	02a7db63          	bge	a5,a0,2ba <main+0x40>
 288:	e426                	sd	s1,8(sp)
 28a:	e04a                	sd	s2,0(sp)
 28c:	00858493          	add	s1,a1,8
 290:	ffe5091b          	addw	s2,a0,-2
 294:	02091793          	sll	a5,s2,0x20
 298:	01d7d913          	srl	s2,a5,0x1d
 29c:	05c1                	add	a1,a1,16
 29e:	992e                	add	s2,s2,a1
    ls(".");
    exit(0);
  }
  for(i=1; i<argc; i++)
    ls(argv[i]);
 2a0:	6088                	ld	a0,0(s1)
 2a2:	00000097          	auipc	ra,0x0
 2a6:	e12080e7          	jalr	-494(ra) # b4 <ls>
  for(i=1; i<argc; i++)
 2aa:	04a1                	add	s1,s1,8
 2ac:	ff249ae3          	bne	s1,s2,2a0 <main+0x26>
  exit(0);
 2b0:	4501                	li	a0,0
 2b2:	00000097          	auipc	ra,0x0
 2b6:	2c0080e7          	jalr	704(ra) # 572 <exit>
 2ba:	e426                	sd	s1,8(sp)
 2bc:	e04a                	sd	s2,0(sp)
    ls(".");
 2be:	00001517          	auipc	a0,0x1
 2c2:	ada50513          	add	a0,a0,-1318 # d98 <malloc+0x16e>
 2c6:	00000097          	auipc	ra,0x0
 2ca:	dee080e7          	jalr	-530(ra) # b4 <ls>
    exit(0);
 2ce:	4501                	li	a0,0
 2d0:	00000097          	auipc	ra,0x0
 2d4:	2a2080e7          	jalr	674(ra) # 572 <exit>

00000000000002d8 <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
 2d8:	1141                	add	sp,sp,-16
 2da:	e422                	sd	s0,8(sp)
 2dc:	0800                	add	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 2de:	87aa                	mv	a5,a0
 2e0:	0585                	add	a1,a1,1
 2e2:	0785                	add	a5,a5,1
 2e4:	fff5c703          	lbu	a4,-1(a1)
 2e8:	fee78fa3          	sb	a4,-1(a5)
 2ec:	fb75                	bnez	a4,2e0 <strcpy+0x8>
    ;
  return os;
}
 2ee:	6422                	ld	s0,8(sp)
 2f0:	0141                	add	sp,sp,16
 2f2:	8082                	ret

00000000000002f4 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 2f4:	1141                	add	sp,sp,-16
 2f6:	e422                	sd	s0,8(sp)
 2f8:	0800                	add	s0,sp,16
  while(*p && *p == *q)
 2fa:	00054783          	lbu	a5,0(a0)
 2fe:	cb91                	beqz	a5,312 <strcmp+0x1e>
 300:	0005c703          	lbu	a4,0(a1)
 304:	00f71763          	bne	a4,a5,312 <strcmp+0x1e>
    p++, q++;
 308:	0505                	add	a0,a0,1
 30a:	0585                	add	a1,a1,1
  while(*p && *p == *q)
 30c:	00054783          	lbu	a5,0(a0)
 310:	fbe5                	bnez	a5,300 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 312:	0005c503          	lbu	a0,0(a1)
}
 316:	40a7853b          	subw	a0,a5,a0
 31a:	6422                	ld	s0,8(sp)
 31c:	0141                	add	sp,sp,16
 31e:	8082                	ret

0000000000000320 <strlen>:

uint
strlen(const char *s)
{
 320:	1141                	add	sp,sp,-16
 322:	e422                	sd	s0,8(sp)
 324:	0800                	add	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 326:	00054783          	lbu	a5,0(a0)
 32a:	cf91                	beqz	a5,346 <strlen+0x26>
 32c:	0505                	add	a0,a0,1
 32e:	87aa                	mv	a5,a0
 330:	86be                	mv	a3,a5
 332:	0785                	add	a5,a5,1
 334:	fff7c703          	lbu	a4,-1(a5)
 338:	ff65                	bnez	a4,330 <strlen+0x10>
 33a:	40a6853b          	subw	a0,a3,a0
 33e:	2505                	addw	a0,a0,1
    ;
  return n;
}
 340:	6422                	ld	s0,8(sp)
 342:	0141                	add	sp,sp,16
 344:	8082                	ret
  for(n = 0; s[n]; n++)
 346:	4501                	li	a0,0
 348:	bfe5                	j	340 <strlen+0x20>

000000000000034a <strcat>:

char *
strcat(char *dst, char *src)
{
 34a:	1141                	add	sp,sp,-16
 34c:	e422                	sd	s0,8(sp)
 34e:	0800                	add	s0,sp,16
  char *s = dst;
  while (*dst)
 350:	00054783          	lbu	a5,0(a0)
 354:	c385                	beqz	a5,374 <strcat+0x2a>
 356:	87aa                	mv	a5,a0
    dst++;
 358:	0785                	add	a5,a5,1
  while (*dst)
 35a:	0007c703          	lbu	a4,0(a5)
 35e:	ff6d                	bnez	a4,358 <strcat+0xe>
  while ((*dst++ = *src++) != 0);
 360:	0585                	add	a1,a1,1
 362:	0785                	add	a5,a5,1
 364:	fff5c703          	lbu	a4,-1(a1)
 368:	fee78fa3          	sb	a4,-1(a5)
 36c:	fb75                	bnez	a4,360 <strcat+0x16>

  return s;
}
 36e:	6422                	ld	s0,8(sp)
 370:	0141                	add	sp,sp,16
 372:	8082                	ret
  while (*dst)
 374:	87aa                	mv	a5,a0
 376:	b7ed                	j	360 <strcat+0x16>

0000000000000378 <memset>:

void*
memset(void *dst, int c, uint n)
{
 378:	1141                	add	sp,sp,-16
 37a:	e422                	sd	s0,8(sp)
 37c:	0800                	add	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 37e:	ca19                	beqz	a2,394 <memset+0x1c>
 380:	87aa                	mv	a5,a0
 382:	1602                	sll	a2,a2,0x20
 384:	9201                	srl	a2,a2,0x20
 386:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 38a:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 38e:	0785                	add	a5,a5,1
 390:	fee79de3          	bne	a5,a4,38a <memset+0x12>
  }
  return dst;
}
 394:	6422                	ld	s0,8(sp)
 396:	0141                	add	sp,sp,16
 398:	8082                	ret

000000000000039a <strchr>:

char*
strchr(const char *s, char c)
{
 39a:	1141                	add	sp,sp,-16
 39c:	e422                	sd	s0,8(sp)
 39e:	0800                	add	s0,sp,16
  for(; *s; s++)
 3a0:	00054783          	lbu	a5,0(a0)
 3a4:	cb99                	beqz	a5,3ba <strchr+0x20>
    if(*s == c)
 3a6:	00f58763          	beq	a1,a5,3b4 <strchr+0x1a>
  for(; *s; s++)
 3aa:	0505                	add	a0,a0,1
 3ac:	00054783          	lbu	a5,0(a0)
 3b0:	fbfd                	bnez	a5,3a6 <strchr+0xc>
      return (char*)s;
  return 0;
 3b2:	4501                	li	a0,0
}
 3b4:	6422                	ld	s0,8(sp)
 3b6:	0141                	add	sp,sp,16
 3b8:	8082                	ret
  return 0;
 3ba:	4501                	li	a0,0
 3bc:	bfe5                	j	3b4 <strchr+0x1a>

00000000000003be <gets>:

char*
gets(char *buf, int max)
{
 3be:	711d                	add	sp,sp,-96
 3c0:	ec86                	sd	ra,88(sp)
 3c2:	e8a2                	sd	s0,80(sp)
 3c4:	e4a6                	sd	s1,72(sp)
 3c6:	e0ca                	sd	s2,64(sp)
 3c8:	fc4e                	sd	s3,56(sp)
 3ca:	f852                	sd	s4,48(sp)
 3cc:	f456                	sd	s5,40(sp)
 3ce:	f05a                	sd	s6,32(sp)
 3d0:	ec5e                	sd	s7,24(sp)
 3d2:	1080                	add	s0,sp,96
 3d4:	8baa                	mv	s7,a0
 3d6:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 3d8:	892a                	mv	s2,a0
 3da:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 3dc:	4aa9                	li	s5,10
 3de:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 3e0:	89a6                	mv	s3,s1
 3e2:	2485                	addw	s1,s1,1
 3e4:	0344d863          	bge	s1,s4,414 <gets+0x56>
    cc = read(0, &c, 1);
 3e8:	4605                	li	a2,1
 3ea:	faf40593          	add	a1,s0,-81
 3ee:	4501                	li	a0,0
 3f0:	00000097          	auipc	ra,0x0
 3f4:	19a080e7          	jalr	410(ra) # 58a <read>
    if(cc < 1)
 3f8:	00a05e63          	blez	a0,414 <gets+0x56>
    buf[i++] = c;
 3fc:	faf44783          	lbu	a5,-81(s0)
 400:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 404:	01578763          	beq	a5,s5,412 <gets+0x54>
 408:	0905                	add	s2,s2,1
 40a:	fd679be3          	bne	a5,s6,3e0 <gets+0x22>
    buf[i++] = c;
 40e:	89a6                	mv	s3,s1
 410:	a011                	j	414 <gets+0x56>
 412:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 414:	99de                	add	s3,s3,s7
 416:	00098023          	sb	zero,0(s3)
  return buf;
}
 41a:	855e                	mv	a0,s7
 41c:	60e6                	ld	ra,88(sp)
 41e:	6446                	ld	s0,80(sp)
 420:	64a6                	ld	s1,72(sp)
 422:	6906                	ld	s2,64(sp)
 424:	79e2                	ld	s3,56(sp)
 426:	7a42                	ld	s4,48(sp)
 428:	7aa2                	ld	s5,40(sp)
 42a:	7b02                	ld	s6,32(sp)
 42c:	6be2                	ld	s7,24(sp)
 42e:	6125                	add	sp,sp,96
 430:	8082                	ret

0000000000000432 <stat>:

int
stat(const char *n, struct stat *st)
{
 432:	1101                	add	sp,sp,-32
 434:	ec06                	sd	ra,24(sp)
 436:	e822                	sd	s0,16(sp)
 438:	e04a                	sd	s2,0(sp)
 43a:	1000                	add	s0,sp,32
 43c:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 43e:	4581                	li	a1,0
 440:	00000097          	auipc	ra,0x0
 444:	172080e7          	jalr	370(ra) # 5b2 <open>
  if(fd < 0)
 448:	02054663          	bltz	a0,474 <stat+0x42>
 44c:	e426                	sd	s1,8(sp)
 44e:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 450:	85ca                	mv	a1,s2
 452:	00000097          	auipc	ra,0x0
 456:	178080e7          	jalr	376(ra) # 5ca <fstat>
 45a:	892a                	mv	s2,a0
  close(fd);
 45c:	8526                	mv	a0,s1
 45e:	00000097          	auipc	ra,0x0
 462:	13c080e7          	jalr	316(ra) # 59a <close>
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
 476:	bfcd                	j	468 <stat+0x36>

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
 55a:	00000097          	auipc	ra,0x0
 55e:	f66080e7          	jalr	-154(ra) # 4c0 <memmove>
}
 562:	60a2                	ld	ra,8(sp)
 564:	6402                	ld	s0,0(sp)
 566:	0141                	add	sp,sp,16
 568:	8082                	ret

000000000000056a <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 56a:	4885                	li	a7,1
 ecall
 56c:	00000073          	ecall
 ret
 570:	8082                	ret

0000000000000572 <exit>:
.global exit
exit:
 li a7, SYS_exit
 572:	4889                	li	a7,2
 ecall
 574:	00000073          	ecall
 ret
 578:	8082                	ret

000000000000057a <wait>:
.global wait
wait:
 li a7, SYS_wait
 57a:	488d                	li	a7,3
 ecall
 57c:	00000073          	ecall
 ret
 580:	8082                	ret

0000000000000582 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 582:	4891                	li	a7,4
 ecall
 584:	00000073          	ecall
 ret
 588:	8082                	ret

000000000000058a <read>:
.global read
read:
 li a7, SYS_read
 58a:	4895                	li	a7,5
 ecall
 58c:	00000073          	ecall
 ret
 590:	8082                	ret

0000000000000592 <write>:
.global write
write:
 li a7, SYS_write
 592:	48c1                	li	a7,16
 ecall
 594:	00000073          	ecall
 ret
 598:	8082                	ret

000000000000059a <close>:
.global close
close:
 li a7, SYS_close
 59a:	48d5                	li	a7,21
 ecall
 59c:	00000073          	ecall
 ret
 5a0:	8082                	ret

00000000000005a2 <kill>:
.global kill
kill:
 li a7, SYS_kill
 5a2:	4899                	li	a7,6
 ecall
 5a4:	00000073          	ecall
 ret
 5a8:	8082                	ret

00000000000005aa <exec>:
.global exec
exec:
 li a7, SYS_exec
 5aa:	489d                	li	a7,7
 ecall
 5ac:	00000073          	ecall
 ret
 5b0:	8082                	ret

00000000000005b2 <open>:
.global open
open:
 li a7, SYS_open
 5b2:	48bd                	li	a7,15
 ecall
 5b4:	00000073          	ecall
 ret
 5b8:	8082                	ret

00000000000005ba <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 5ba:	48c5                	li	a7,17
 ecall
 5bc:	00000073          	ecall
 ret
 5c0:	8082                	ret

00000000000005c2 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 5c2:	48c9                	li	a7,18
 ecall
 5c4:	00000073          	ecall
 ret
 5c8:	8082                	ret

00000000000005ca <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 5ca:	48a1                	li	a7,8
 ecall
 5cc:	00000073          	ecall
 ret
 5d0:	8082                	ret

00000000000005d2 <link>:
.global link
link:
 li a7, SYS_link
 5d2:	48cd                	li	a7,19
 ecall
 5d4:	00000073          	ecall
 ret
 5d8:	8082                	ret

00000000000005da <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 5da:	48d1                	li	a7,20
 ecall
 5dc:	00000073          	ecall
 ret
 5e0:	8082                	ret

00000000000005e2 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 5e2:	48a5                	li	a7,9
 ecall
 5e4:	00000073          	ecall
 ret
 5e8:	8082                	ret

00000000000005ea <dup>:
.global dup
dup:
 li a7, SYS_dup
 5ea:	48a9                	li	a7,10
 ecall
 5ec:	00000073          	ecall
 ret
 5f0:	8082                	ret

00000000000005f2 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 5f2:	48ad                	li	a7,11
 ecall
 5f4:	00000073          	ecall
 ret
 5f8:	8082                	ret

00000000000005fa <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 5fa:	48b1                	li	a7,12
 ecall
 5fc:	00000073          	ecall
 ret
 600:	8082                	ret

0000000000000602 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 602:	48b5                	li	a7,13
 ecall
 604:	00000073          	ecall
 ret
 608:	8082                	ret

000000000000060a <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 60a:	48b9                	li	a7,14
 ecall
 60c:	00000073          	ecall
 ret
 610:	8082                	ret

0000000000000612 <uconnect>:
.global uconnect
uconnect:
 li a7, SYS_uconnect
 612:	48f5                	li	a7,29
 ecall
 614:	00000073          	ecall
 ret
 618:	8082                	ret

000000000000061a <socket>:
.global socket
socket:
 li a7, SYS_socket
 61a:	48f9                	li	a7,30
 ecall
 61c:	00000073          	ecall
 ret
 620:	8082                	ret

0000000000000622 <bind>:
.global bind
bind:
 li a7, SYS_bind
 622:	48fd                	li	a7,31
 ecall
 624:	00000073          	ecall
 ret
 628:	8082                	ret

000000000000062a <listen>:
.global listen
listen:
 li a7, SYS_listen
 62a:	02000893          	li	a7,32
 ecall
 62e:	00000073          	ecall
 ret
 632:	8082                	ret

0000000000000634 <accept>:
.global accept
accept:
 li a7, SYS_accept
 634:	02100893          	li	a7,33
 ecall
 638:	00000073          	ecall
 ret
 63c:	8082                	ret

000000000000063e <connect>:
.global connect
connect:
 li a7, SYS_connect
 63e:	02200893          	li	a7,34
 ecall
 642:	00000073          	ecall
 ret
 646:	8082                	ret

0000000000000648 <sprintint>:
  return 1;
}

static int
sprintint(char *s, int xx, int base, int sign)
{
 648:	1101                	add	sp,sp,-32
 64a:	ec22                	sd	s0,24(sp)
 64c:	1000                	add	s0,sp,32
 64e:	882a                	mv	a6,a0
  char buf[16];
  int i, n;
  uint x;

  if(sign && (sign = xx < 0))
 650:	c299                	beqz	a3,656 <sprintint+0xe>
 652:	0805c263          	bltz	a1,6d6 <sprintint+0x8e>
    x = -xx;
  else
    x = xx;
 656:	2581                	sext.w	a1,a1
 658:	4301                	li	t1,0

  i = 0;
 65a:	fe040713          	add	a4,s0,-32
 65e:	4501                	li	a0,0
  do {
    buf[i++] = digits[x % base];
 660:	2601                	sext.w	a2,a2
 662:	00000697          	auipc	a3,0x0
 666:	79e68693          	add	a3,a3,1950 # e00 <digits>
 66a:	88aa                	mv	a7,a0
 66c:	2505                	addw	a0,a0,1
 66e:	02c5f7bb          	remuw	a5,a1,a2
 672:	1782                	sll	a5,a5,0x20
 674:	9381                	srl	a5,a5,0x20
 676:	97b6                	add	a5,a5,a3
 678:	0007c783          	lbu	a5,0(a5)
 67c:	00f70023          	sb	a5,0(a4)
  } while((x /= base) != 0);
 680:	0005879b          	sext.w	a5,a1
 684:	02c5d5bb          	divuw	a1,a1,a2
 688:	0705                	add	a4,a4,1
 68a:	fec7f0e3          	bgeu	a5,a2,66a <sprintint+0x22>

  if(sign)
 68e:	00030b63          	beqz	t1,6a4 <sprintint+0x5c>
    buf[i++] = '-';
 692:	ff050793          	add	a5,a0,-16
 696:	97a2                	add	a5,a5,s0
 698:	02d00713          	li	a4,45
 69c:	fee78823          	sb	a4,-16(a5)
 6a0:	0028851b          	addw	a0,a7,2

  n = 0;
  while(--i >= 0)
 6a4:	02a05d63          	blez	a0,6de <sprintint+0x96>
 6a8:	fe040793          	add	a5,s0,-32
 6ac:	00a78733          	add	a4,a5,a0
 6b0:	87c2                	mv	a5,a6
 6b2:	00180613          	add	a2,a6,1
 6b6:	fff5069b          	addw	a3,a0,-1
 6ba:	1682                	sll	a3,a3,0x20
 6bc:	9281                	srl	a3,a3,0x20
 6be:	9636                	add	a2,a2,a3
  *s = c;
 6c0:	fff74683          	lbu	a3,-1(a4)
 6c4:	00d78023          	sb	a3,0(a5)
  while(--i >= 0)
 6c8:	177d                	add	a4,a4,-1
 6ca:	0785                	add	a5,a5,1
 6cc:	fec79ae3          	bne	a5,a2,6c0 <sprintint+0x78>
    n += sputc(s+n, buf[i]);
  return n;
}
 6d0:	6462                	ld	s0,24(sp)
 6d2:	6105                	add	sp,sp,32
 6d4:	8082                	ret
    x = -xx;
 6d6:	40b005bb          	negw	a1,a1
  if(sign && (sign = xx < 0))
 6da:	4305                	li	t1,1
    x = -xx;
 6dc:	bfbd                	j	65a <sprintint+0x12>
  while(--i >= 0)
 6de:	4501                	li	a0,0
 6e0:	bfc5                	j	6d0 <sprintint+0x88>

00000000000006e2 <putc>:
{
 6e2:	1101                	add	sp,sp,-32
 6e4:	ec06                	sd	ra,24(sp)
 6e6:	e822                	sd	s0,16(sp)
 6e8:	1000                	add	s0,sp,32
 6ea:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 6ee:	4605                	li	a2,1
 6f0:	fef40593          	add	a1,s0,-17
 6f4:	00000097          	auipc	ra,0x0
 6f8:	e9e080e7          	jalr	-354(ra) # 592 <write>
}
 6fc:	60e2                	ld	ra,24(sp)
 6fe:	6442                	ld	s0,16(sp)
 700:	6105                	add	sp,sp,32
 702:	8082                	ret

0000000000000704 <printint>:
{
 704:	7139                	add	sp,sp,-64
 706:	fc06                	sd	ra,56(sp)
 708:	f822                	sd	s0,48(sp)
 70a:	f426                	sd	s1,40(sp)
 70c:	0080                	add	s0,sp,64
 70e:	84aa                	mv	s1,a0
  if(sgn && xx < 0){
 710:	c299                	beqz	a3,716 <printint+0x12>
 712:	0805cb63          	bltz	a1,7a8 <printint+0xa4>
    x = xx;
 716:	2581                	sext.w	a1,a1
  neg = 0;
 718:	4881                	li	a7,0
 71a:	fc040693          	add	a3,s0,-64
  i = 0;
 71e:	4701                	li	a4,0
    buf[i++] = digits[x % base];
 720:	2601                	sext.w	a2,a2
 722:	00000517          	auipc	a0,0x0
 726:	6de50513          	add	a0,a0,1758 # e00 <digits>
 72a:	883a                	mv	a6,a4
 72c:	2705                	addw	a4,a4,1
 72e:	02c5f7bb          	remuw	a5,a1,a2
 732:	1782                	sll	a5,a5,0x20
 734:	9381                	srl	a5,a5,0x20
 736:	97aa                	add	a5,a5,a0
 738:	0007c783          	lbu	a5,0(a5)
 73c:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 740:	0005879b          	sext.w	a5,a1
 744:	02c5d5bb          	divuw	a1,a1,a2
 748:	0685                	add	a3,a3,1
 74a:	fec7f0e3          	bgeu	a5,a2,72a <printint+0x26>
  if(neg)
 74e:	00088c63          	beqz	a7,766 <printint+0x62>
    buf[i++] = '-';
 752:	fd070793          	add	a5,a4,-48
 756:	00878733          	add	a4,a5,s0
 75a:	02d00793          	li	a5,45
 75e:	fef70823          	sb	a5,-16(a4)
 762:	0028071b          	addw	a4,a6,2
  while(--i >= 0)
 766:	02e05c63          	blez	a4,79e <printint+0x9a>
 76a:	f04a                	sd	s2,32(sp)
 76c:	ec4e                	sd	s3,24(sp)
 76e:	fc040793          	add	a5,s0,-64
 772:	00e78933          	add	s2,a5,a4
 776:	fff78993          	add	s3,a5,-1
 77a:	99ba                	add	s3,s3,a4
 77c:	377d                	addw	a4,a4,-1
 77e:	1702                	sll	a4,a4,0x20
 780:	9301                	srl	a4,a4,0x20
 782:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 786:	fff94583          	lbu	a1,-1(s2)
 78a:	8526                	mv	a0,s1
 78c:	00000097          	auipc	ra,0x0
 790:	f56080e7          	jalr	-170(ra) # 6e2 <putc>
  while(--i >= 0)
 794:	197d                	add	s2,s2,-1
 796:	ff3918e3          	bne	s2,s3,786 <printint+0x82>
 79a:	7902                	ld	s2,32(sp)
 79c:	69e2                	ld	s3,24(sp)
}
 79e:	70e2                	ld	ra,56(sp)
 7a0:	7442                	ld	s0,48(sp)
 7a2:	74a2                	ld	s1,40(sp)
 7a4:	6121                	add	sp,sp,64
 7a6:	8082                	ret
    x = -xx;
 7a8:	40b005bb          	negw	a1,a1
    neg = 1;
 7ac:	4885                	li	a7,1
    x = -xx;
 7ae:	b7b5                	j	71a <printint+0x16>

00000000000007b0 <vprintf>:
{
 7b0:	715d                	add	sp,sp,-80
 7b2:	e486                	sd	ra,72(sp)
 7b4:	e0a2                	sd	s0,64(sp)
 7b6:	f84a                	sd	s2,48(sp)
 7b8:	0880                	add	s0,sp,80
  for(i = 0; fmt[i]; i++){
 7ba:	0005c903          	lbu	s2,0(a1)
 7be:	1a090a63          	beqz	s2,972 <vprintf+0x1c2>
 7c2:	fc26                	sd	s1,56(sp)
 7c4:	f44e                	sd	s3,40(sp)
 7c6:	f052                	sd	s4,32(sp)
 7c8:	ec56                	sd	s5,24(sp)
 7ca:	e85a                	sd	s6,16(sp)
 7cc:	e45e                	sd	s7,8(sp)
 7ce:	8aaa                	mv	s5,a0
 7d0:	8bb2                	mv	s7,a2
 7d2:	00158493          	add	s1,a1,1
  state = 0;
 7d6:	4981                	li	s3,0
    } else if(state == '%'){
 7d8:	02500a13          	li	s4,37
 7dc:	4b55                	li	s6,21
 7de:	a839                	j	7fc <vprintf+0x4c>
        putc(fd, c);
 7e0:	85ca                	mv	a1,s2
 7e2:	8556                	mv	a0,s5
 7e4:	00000097          	auipc	ra,0x0
 7e8:	efe080e7          	jalr	-258(ra) # 6e2 <putc>
 7ec:	a019                	j	7f2 <vprintf+0x42>
    } else if(state == '%'){
 7ee:	01498d63          	beq	s3,s4,808 <vprintf+0x58>
  for(i = 0; fmt[i]; i++){
 7f2:	0485                	add	s1,s1,1
 7f4:	fff4c903          	lbu	s2,-1(s1)
 7f8:	16090763          	beqz	s2,966 <vprintf+0x1b6>
    if(state == 0){
 7fc:	fe0999e3          	bnez	s3,7ee <vprintf+0x3e>
      if(c == '%'){
 800:	ff4910e3          	bne	s2,s4,7e0 <vprintf+0x30>
        state = '%';
 804:	89d2                	mv	s3,s4
 806:	b7f5                	j	7f2 <vprintf+0x42>
      if(c == 'd'){
 808:	13490463          	beq	s2,s4,930 <vprintf+0x180>
 80c:	f9d9079b          	addw	a5,s2,-99
 810:	0ff7f793          	zext.b	a5,a5
 814:	12fb6763          	bltu	s6,a5,942 <vprintf+0x192>
 818:	f9d9079b          	addw	a5,s2,-99
 81c:	0ff7f713          	zext.b	a4,a5
 820:	12eb6163          	bltu	s6,a4,942 <vprintf+0x192>
 824:	00271793          	sll	a5,a4,0x2
 828:	00000717          	auipc	a4,0x0
 82c:	58070713          	add	a4,a4,1408 # da8 <malloc+0x17e>
 830:	97ba                	add	a5,a5,a4
 832:	439c                	lw	a5,0(a5)
 834:	97ba                	add	a5,a5,a4
 836:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 838:	008b8913          	add	s2,s7,8
 83c:	4685                	li	a3,1
 83e:	4629                	li	a2,10
 840:	000ba583          	lw	a1,0(s7)
 844:	8556                	mv	a0,s5
 846:	00000097          	auipc	ra,0x0
 84a:	ebe080e7          	jalr	-322(ra) # 704 <printint>
 84e:	8bca                	mv	s7,s2
      state = 0;
 850:	4981                	li	s3,0
 852:	b745                	j	7f2 <vprintf+0x42>
        printint(fd, va_arg(ap, uint64), 10, 0);
 854:	008b8913          	add	s2,s7,8
 858:	4681                	li	a3,0
 85a:	4629                	li	a2,10
 85c:	000ba583          	lw	a1,0(s7)
 860:	8556                	mv	a0,s5
 862:	00000097          	auipc	ra,0x0
 866:	ea2080e7          	jalr	-350(ra) # 704 <printint>
 86a:	8bca                	mv	s7,s2
      state = 0;
 86c:	4981                	li	s3,0
 86e:	b751                	j	7f2 <vprintf+0x42>
        printint(fd, va_arg(ap, int), 16, 0);
 870:	008b8913          	add	s2,s7,8
 874:	4681                	li	a3,0
 876:	4641                	li	a2,16
 878:	000ba583          	lw	a1,0(s7)
 87c:	8556                	mv	a0,s5
 87e:	00000097          	auipc	ra,0x0
 882:	e86080e7          	jalr	-378(ra) # 704 <printint>
 886:	8bca                	mv	s7,s2
      state = 0;
 888:	4981                	li	s3,0
 88a:	b7a5                	j	7f2 <vprintf+0x42>
 88c:	e062                	sd	s8,0(sp)
        printptr(fd, va_arg(ap, uint64));
 88e:	008b8c13          	add	s8,s7,8
 892:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 896:	03000593          	li	a1,48
 89a:	8556                	mv	a0,s5
 89c:	00000097          	auipc	ra,0x0
 8a0:	e46080e7          	jalr	-442(ra) # 6e2 <putc>
  putc(fd, 'x');
 8a4:	07800593          	li	a1,120
 8a8:	8556                	mv	a0,s5
 8aa:	00000097          	auipc	ra,0x0
 8ae:	e38080e7          	jalr	-456(ra) # 6e2 <putc>
 8b2:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 8b4:	00000b97          	auipc	s7,0x0
 8b8:	54cb8b93          	add	s7,s7,1356 # e00 <digits>
 8bc:	03c9d793          	srl	a5,s3,0x3c
 8c0:	97de                	add	a5,a5,s7
 8c2:	0007c583          	lbu	a1,0(a5)
 8c6:	8556                	mv	a0,s5
 8c8:	00000097          	auipc	ra,0x0
 8cc:	e1a080e7          	jalr	-486(ra) # 6e2 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 8d0:	0992                	sll	s3,s3,0x4
 8d2:	397d                	addw	s2,s2,-1
 8d4:	fe0914e3          	bnez	s2,8bc <vprintf+0x10c>
        printptr(fd, va_arg(ap, uint64));
 8d8:	8be2                	mv	s7,s8
      state = 0;
 8da:	4981                	li	s3,0
 8dc:	6c02                	ld	s8,0(sp)
 8de:	bf11                	j	7f2 <vprintf+0x42>
        s = va_arg(ap, char*);
 8e0:	008b8993          	add	s3,s7,8
 8e4:	000bb903          	ld	s2,0(s7)
        if(s == 0)
 8e8:	02090163          	beqz	s2,90a <vprintf+0x15a>
        while(*s != 0){
 8ec:	00094583          	lbu	a1,0(s2)
 8f0:	c9a5                	beqz	a1,960 <vprintf+0x1b0>
          putc(fd, *s);
 8f2:	8556                	mv	a0,s5
 8f4:	00000097          	auipc	ra,0x0
 8f8:	dee080e7          	jalr	-530(ra) # 6e2 <putc>
          s++;
 8fc:	0905                	add	s2,s2,1
        while(*s != 0){
 8fe:	00094583          	lbu	a1,0(s2)
 902:	f9e5                	bnez	a1,8f2 <vprintf+0x142>
        s = va_arg(ap, char*);
 904:	8bce                	mv	s7,s3
      state = 0;
 906:	4981                	li	s3,0
 908:	b5ed                	j	7f2 <vprintf+0x42>
          s = "(null)";
 90a:	00000917          	auipc	s2,0x0
 90e:	49690913          	add	s2,s2,1174 # da0 <malloc+0x176>
        while(*s != 0){
 912:	02800593          	li	a1,40
 916:	bff1                	j	8f2 <vprintf+0x142>
        putc(fd, va_arg(ap, uint));
 918:	008b8913          	add	s2,s7,8
 91c:	000bc583          	lbu	a1,0(s7)
 920:	8556                	mv	a0,s5
 922:	00000097          	auipc	ra,0x0
 926:	dc0080e7          	jalr	-576(ra) # 6e2 <putc>
 92a:	8bca                	mv	s7,s2
      state = 0;
 92c:	4981                	li	s3,0
 92e:	b5d1                	j	7f2 <vprintf+0x42>
        putc(fd, c);
 930:	02500593          	li	a1,37
 934:	8556                	mv	a0,s5
 936:	00000097          	auipc	ra,0x0
 93a:	dac080e7          	jalr	-596(ra) # 6e2 <putc>
      state = 0;
 93e:	4981                	li	s3,0
 940:	bd4d                	j	7f2 <vprintf+0x42>
        putc(fd, '%');
 942:	02500593          	li	a1,37
 946:	8556                	mv	a0,s5
 948:	00000097          	auipc	ra,0x0
 94c:	d9a080e7          	jalr	-614(ra) # 6e2 <putc>
        putc(fd, c);
 950:	85ca                	mv	a1,s2
 952:	8556                	mv	a0,s5
 954:	00000097          	auipc	ra,0x0
 958:	d8e080e7          	jalr	-626(ra) # 6e2 <putc>
      state = 0;
 95c:	4981                	li	s3,0
 95e:	bd51                	j	7f2 <vprintf+0x42>
        s = va_arg(ap, char*);
 960:	8bce                	mv	s7,s3
      state = 0;
 962:	4981                	li	s3,0
 964:	b579                	j	7f2 <vprintf+0x42>
 966:	74e2                	ld	s1,56(sp)
 968:	79a2                	ld	s3,40(sp)
 96a:	7a02                	ld	s4,32(sp)
 96c:	6ae2                	ld	s5,24(sp)
 96e:	6b42                	ld	s6,16(sp)
 970:	6ba2                	ld	s7,8(sp)
}
 972:	60a6                	ld	ra,72(sp)
 974:	6406                	ld	s0,64(sp)
 976:	7942                	ld	s2,48(sp)
 978:	6161                	add	sp,sp,80
 97a:	8082                	ret

000000000000097c <fprintf>:
{
 97c:	715d                	add	sp,sp,-80
 97e:	ec06                	sd	ra,24(sp)
 980:	e822                	sd	s0,16(sp)
 982:	1000                	add	s0,sp,32
 984:	e010                	sd	a2,0(s0)
 986:	e414                	sd	a3,8(s0)
 988:	e818                	sd	a4,16(s0)
 98a:	ec1c                	sd	a5,24(s0)
 98c:	03043023          	sd	a6,32(s0)
 990:	03143423          	sd	a7,40(s0)
  va_start(ap, fmt);
 994:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 998:	8622                	mv	a2,s0
 99a:	00000097          	auipc	ra,0x0
 99e:	e16080e7          	jalr	-490(ra) # 7b0 <vprintf>
}
 9a2:	60e2                	ld	ra,24(sp)
 9a4:	6442                	ld	s0,16(sp)
 9a6:	6161                	add	sp,sp,80
 9a8:	8082                	ret

00000000000009aa <printf>:
{
 9aa:	711d                	add	sp,sp,-96
 9ac:	ec06                	sd	ra,24(sp)
 9ae:	e822                	sd	s0,16(sp)
 9b0:	1000                	add	s0,sp,32
 9b2:	e40c                	sd	a1,8(s0)
 9b4:	e810                	sd	a2,16(s0)
 9b6:	ec14                	sd	a3,24(s0)
 9b8:	f018                	sd	a4,32(s0)
 9ba:	f41c                	sd	a5,40(s0)
 9bc:	03043823          	sd	a6,48(s0)
 9c0:	03143c23          	sd	a7,56(s0)
  va_start(ap, fmt);
 9c4:	00840613          	add	a2,s0,8
 9c8:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 9cc:	85aa                	mv	a1,a0
 9ce:	4505                	li	a0,1
 9d0:	00000097          	auipc	ra,0x0
 9d4:	de0080e7          	jalr	-544(ra) # 7b0 <vprintf>
}
 9d8:	60e2                	ld	ra,24(sp)
 9da:	6442                	ld	s0,16(sp)
 9dc:	6125                	add	sp,sp,96
 9de:	8082                	ret

00000000000009e0 <snprintf>:

int
snprintf(char *buf, int sz, char *fmt, ...)
{
 9e0:	7135                	add	sp,sp,-160
 9e2:	f486                	sd	ra,104(sp)
 9e4:	f0a2                	sd	s0,96(sp)
 9e6:	eca6                	sd	s1,88(sp)
 9e8:	1880                	add	s0,sp,112
 9ea:	e414                	sd	a3,8(s0)
 9ec:	e818                	sd	a4,16(s0)
 9ee:	ec1c                	sd	a5,24(s0)
 9f0:	03043023          	sd	a6,32(s0)
 9f4:	03143423          	sd	a7,40(s0)
  va_list ap;
  int i, c;
  int off = 0;
  char *s;

  if (fmt == 0)
 9f8:	16060b63          	beqz	a2,b6e <snprintf+0x18e>
 9fc:	e8ca                	sd	s2,80(sp)
 9fe:	e4ce                	sd	s3,72(sp)
 a00:	fc56                	sd	s5,56(sp)
 a02:	f85a                	sd	s6,48(sp)
 a04:	8b2a                	mv	s6,a0
 a06:	8aae                	mv	s5,a1
 a08:	89b2                	mv	s3,a2
    return -1;

  va_start(ap, fmt);
 a0a:	00840793          	add	a5,s0,8
 a0e:	f8f43c23          	sd	a5,-104(s0)
  int off = 0;
 a12:	4481                	li	s1,0
  for(i = 0; off < sz && (c = fmt[i] & 0xff) != 0; i++){
 a14:	4901                	li	s2,0
 a16:	00b05f63          	blez	a1,a34 <snprintf+0x54>
 a1a:	e0d2                	sd	s4,64(sp)
 a1c:	f45e                	sd	s7,40(sp)
 a1e:	f062                	sd	s8,32(sp)
 a20:	ec66                	sd	s9,24(sp)
    if(c != '%'){
 a22:	02500a13          	li	s4,37
      continue;
    }
    c = fmt[++i] & 0xff;
    if(c == 0)
      break;
    switch(c){
 a26:	07300b93          	li	s7,115
 a2a:	07800c93          	li	s9,120
 a2e:	06400c13          	li	s8,100
 a32:	a839                	j	a50 <snprintf+0x70>
      off += sputc(buf+off, '%');
      off += sputc(buf+off, c);
      break;
    }
  }
  return off;
 a34:	4481                	li	s1,0
 a36:	6946                	ld	s2,80(sp)
 a38:	69a6                	ld	s3,72(sp)
 a3a:	7ae2                	ld	s5,56(sp)
 a3c:	7b42                	ld	s6,48(sp)
 a3e:	a0cd                	j	b20 <snprintf+0x140>
  *s = c;
 a40:	009b0733          	add	a4,s6,s1
 a44:	00f70023          	sb	a5,0(a4)
      off += sputc(buf+off, c);
 a48:	2485                	addw	s1,s1,1
  for(i = 0; off < sz && (c = fmt[i] & 0xff) != 0; i++){
 a4a:	2905                	addw	s2,s2,1
 a4c:	1554d563          	bge	s1,s5,b96 <snprintf+0x1b6>
 a50:	012987b3          	add	a5,s3,s2
 a54:	0007c783          	lbu	a5,0(a5)
 a58:	0007871b          	sext.w	a4,a5
 a5c:	10078063          	beqz	a5,b5c <snprintf+0x17c>
    if(c != '%'){
 a60:	ff4710e3          	bne	a4,s4,a40 <snprintf+0x60>
    c = fmt[++i] & 0xff;
 a64:	2905                	addw	s2,s2,1
 a66:	012987b3          	add	a5,s3,s2
 a6a:	0007c783          	lbu	a5,0(a5)
    if(c == 0)
 a6e:	10078263          	beqz	a5,b72 <snprintf+0x192>
    switch(c){
 a72:	05778c63          	beq	a5,s7,aca <snprintf+0xea>
 a76:	02fbe763          	bltu	s7,a5,aa4 <snprintf+0xc4>
 a7a:	0d478063          	beq	a5,s4,b3a <snprintf+0x15a>
 a7e:	0d879463          	bne	a5,s8,b46 <snprintf+0x166>
      off += sprintint(buf+off, va_arg(ap, int), 10, 1);
 a82:	f9843783          	ld	a5,-104(s0)
 a86:	00878713          	add	a4,a5,8
 a8a:	f8e43c23          	sd	a4,-104(s0)
 a8e:	4685                	li	a3,1
 a90:	4629                	li	a2,10
 a92:	438c                	lw	a1,0(a5)
 a94:	009b0533          	add	a0,s6,s1
 a98:	00000097          	auipc	ra,0x0
 a9c:	bb0080e7          	jalr	-1104(ra) # 648 <sprintint>
 aa0:	9ca9                	addw	s1,s1,a0
      break;
 aa2:	b765                	j	a4a <snprintf+0x6a>
    switch(c){
 aa4:	0b979163          	bne	a5,s9,b46 <snprintf+0x166>
      off += sprintint(buf+off, va_arg(ap, int), 16, 1);
 aa8:	f9843783          	ld	a5,-104(s0)
 aac:	00878713          	add	a4,a5,8
 ab0:	f8e43c23          	sd	a4,-104(s0)
 ab4:	4685                	li	a3,1
 ab6:	4641                	li	a2,16
 ab8:	438c                	lw	a1,0(a5)
 aba:	009b0533          	add	a0,s6,s1
 abe:	00000097          	auipc	ra,0x0
 ac2:	b8a080e7          	jalr	-1142(ra) # 648 <sprintint>
 ac6:	9ca9                	addw	s1,s1,a0
      break;
 ac8:	b749                	j	a4a <snprintf+0x6a>
      if((s = va_arg(ap, char*)) == 0)
 aca:	f9843783          	ld	a5,-104(s0)
 ace:	00878713          	add	a4,a5,8
 ad2:	f8e43c23          	sd	a4,-104(s0)
 ad6:	6388                	ld	a0,0(a5)
 ad8:	c931                	beqz	a0,b2c <snprintf+0x14c>
      for(; *s && off < sz; s++)
 ada:	00054703          	lbu	a4,0(a0)
 ade:	d735                	beqz	a4,a4a <snprintf+0x6a>
 ae0:	0b54d263          	bge	s1,s5,b84 <snprintf+0x1a4>
 ae4:	009b06b3          	add	a3,s6,s1
 ae8:	409a863b          	subw	a2,s5,s1
 aec:	1602                	sll	a2,a2,0x20
 aee:	9201                	srl	a2,a2,0x20
 af0:	962a                	add	a2,a2,a0
 af2:	87aa                	mv	a5,a0
        off += sputc(buf+off, *s);
 af4:	0014859b          	addw	a1,s1,1
 af8:	9d89                	subw	a1,a1,a0
  *s = c;
 afa:	00e68023          	sb	a4,0(a3)
        off += sputc(buf+off, *s);
 afe:	00f584bb          	addw	s1,a1,a5
      for(; *s && off < sz; s++)
 b02:	0785                	add	a5,a5,1
 b04:	0007c703          	lbu	a4,0(a5)
 b08:	d329                	beqz	a4,a4a <snprintf+0x6a>
 b0a:	0685                	add	a3,a3,1
 b0c:	fec797e3          	bne	a5,a2,afa <snprintf+0x11a>
 b10:	6946                	ld	s2,80(sp)
 b12:	69a6                	ld	s3,72(sp)
 b14:	6a06                	ld	s4,64(sp)
 b16:	7ae2                	ld	s5,56(sp)
 b18:	7b42                	ld	s6,48(sp)
 b1a:	7ba2                	ld	s7,40(sp)
 b1c:	7c02                	ld	s8,32(sp)
 b1e:	6ce2                	ld	s9,24(sp)
 b20:	8526                	mv	a0,s1
 b22:	70a6                	ld	ra,104(sp)
 b24:	7406                	ld	s0,96(sp)
 b26:	64e6                	ld	s1,88(sp)
 b28:	610d                	add	sp,sp,160
 b2a:	8082                	ret
      for(; *s && off < sz; s++)
 b2c:	02800713          	li	a4,40
        s = "(null)";
 b30:	00000517          	auipc	a0,0x0
 b34:	27050513          	add	a0,a0,624 # da0 <malloc+0x176>
 b38:	b765                	j	ae0 <snprintf+0x100>
  *s = c;
 b3a:	009b07b3          	add	a5,s6,s1
 b3e:	01478023          	sb	s4,0(a5)
      off += sputc(buf+off, '%');
 b42:	2485                	addw	s1,s1,1
      break;
 b44:	b719                	j	a4a <snprintf+0x6a>
  *s = c;
 b46:	009b0733          	add	a4,s6,s1
 b4a:	01470023          	sb	s4,0(a4)
      off += sputc(buf+off, c);
 b4e:	0014871b          	addw	a4,s1,1
  *s = c;
 b52:	975a                	add	a4,a4,s6
 b54:	00f70023          	sb	a5,0(a4)
      off += sputc(buf+off, c);
 b58:	2489                	addw	s1,s1,2
      break;
 b5a:	bdc5                	j	a4a <snprintf+0x6a>
 b5c:	6946                	ld	s2,80(sp)
 b5e:	69a6                	ld	s3,72(sp)
 b60:	6a06                	ld	s4,64(sp)
 b62:	7ae2                	ld	s5,56(sp)
 b64:	7b42                	ld	s6,48(sp)
 b66:	7ba2                	ld	s7,40(sp)
 b68:	7c02                	ld	s8,32(sp)
 b6a:	6ce2                	ld	s9,24(sp)
 b6c:	bf55                	j	b20 <snprintf+0x140>
    return -1;
 b6e:	54fd                	li	s1,-1
 b70:	bf45                	j	b20 <snprintf+0x140>
 b72:	6946                	ld	s2,80(sp)
 b74:	69a6                	ld	s3,72(sp)
 b76:	6a06                	ld	s4,64(sp)
 b78:	7ae2                	ld	s5,56(sp)
 b7a:	7b42                	ld	s6,48(sp)
 b7c:	7ba2                	ld	s7,40(sp)
 b7e:	7c02                	ld	s8,32(sp)
 b80:	6ce2                	ld	s9,24(sp)
 b82:	bf79                	j	b20 <snprintf+0x140>
 b84:	6946                	ld	s2,80(sp)
 b86:	69a6                	ld	s3,72(sp)
 b88:	6a06                	ld	s4,64(sp)
 b8a:	7ae2                	ld	s5,56(sp)
 b8c:	7b42                	ld	s6,48(sp)
 b8e:	7ba2                	ld	s7,40(sp)
 b90:	7c02                	ld	s8,32(sp)
 b92:	6ce2                	ld	s9,24(sp)
 b94:	b771                	j	b20 <snprintf+0x140>
 b96:	6946                	ld	s2,80(sp)
 b98:	69a6                	ld	s3,72(sp)
 b9a:	6a06                	ld	s4,64(sp)
 b9c:	7ae2                	ld	s5,56(sp)
 b9e:	7b42                	ld	s6,48(sp)
 ba0:	7ba2                	ld	s7,40(sp)
 ba2:	7c02                	ld	s8,32(sp)
 ba4:	6ce2                	ld	s9,24(sp)
 ba6:	bfad                	j	b20 <snprintf+0x140>

0000000000000ba8 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 ba8:	1141                	add	sp,sp,-16
 baa:	e422                	sd	s0,8(sp)
 bac:	0800                	add	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 bae:	ff050693          	add	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 bb2:	00000797          	auipc	a5,0x0
 bb6:	2667b783          	ld	a5,614(a5) # e18 <freep>
 bba:	a02d                	j	be4 <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 bbc:	4618                	lw	a4,8(a2)
 bbe:	9f2d                	addw	a4,a4,a1
 bc0:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 bc4:	6398                	ld	a4,0(a5)
 bc6:	6310                	ld	a2,0(a4)
 bc8:	a83d                	j	c06 <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 bca:	ff852703          	lw	a4,-8(a0)
 bce:	9f31                	addw	a4,a4,a2
 bd0:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 bd2:	ff053683          	ld	a3,-16(a0)
 bd6:	a091                	j	c1a <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 bd8:	6398                	ld	a4,0(a5)
 bda:	00e7e463          	bltu	a5,a4,be2 <free+0x3a>
 bde:	00e6ea63          	bltu	a3,a4,bf2 <free+0x4a>
{
 be2:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 be4:	fed7fae3          	bgeu	a5,a3,bd8 <free+0x30>
 be8:	6398                	ld	a4,0(a5)
 bea:	00e6e463          	bltu	a3,a4,bf2 <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 bee:	fee7eae3          	bltu	a5,a4,be2 <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 bf2:	ff852583          	lw	a1,-8(a0)
 bf6:	6390                	ld	a2,0(a5)
 bf8:	02059813          	sll	a6,a1,0x20
 bfc:	01c85713          	srl	a4,a6,0x1c
 c00:	9736                	add	a4,a4,a3
 c02:	fae60de3          	beq	a2,a4,bbc <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 c06:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 c0a:	4790                	lw	a2,8(a5)
 c0c:	02061593          	sll	a1,a2,0x20
 c10:	01c5d713          	srl	a4,a1,0x1c
 c14:	973e                	add	a4,a4,a5
 c16:	fae68ae3          	beq	a3,a4,bca <free+0x22>
    p->s.ptr = bp->s.ptr;
 c1a:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 c1c:	00000717          	auipc	a4,0x0
 c20:	1ef73e23          	sd	a5,508(a4) # e18 <freep>
}
 c24:	6422                	ld	s0,8(sp)
 c26:	0141                	add	sp,sp,16
 c28:	8082                	ret

0000000000000c2a <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 c2a:	7139                	add	sp,sp,-64
 c2c:	fc06                	sd	ra,56(sp)
 c2e:	f822                	sd	s0,48(sp)
 c30:	f426                	sd	s1,40(sp)
 c32:	ec4e                	sd	s3,24(sp)
 c34:	0080                	add	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 c36:	02051493          	sll	s1,a0,0x20
 c3a:	9081                	srl	s1,s1,0x20
 c3c:	04bd                	add	s1,s1,15
 c3e:	8091                	srl	s1,s1,0x4
 c40:	0014899b          	addw	s3,s1,1
 c44:	0485                	add	s1,s1,1
  if((prevp = freep) == 0){
 c46:	00000517          	auipc	a0,0x0
 c4a:	1d253503          	ld	a0,466(a0) # e18 <freep>
 c4e:	c915                	beqz	a0,c82 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 c50:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 c52:	4798                	lw	a4,8(a5)
 c54:	08977e63          	bgeu	a4,s1,cf0 <malloc+0xc6>
 c58:	f04a                	sd	s2,32(sp)
 c5a:	e852                	sd	s4,16(sp)
 c5c:	e456                	sd	s5,8(sp)
 c5e:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 c60:	8a4e                	mv	s4,s3
 c62:	0009871b          	sext.w	a4,s3
 c66:	6685                	lui	a3,0x1
 c68:	00d77363          	bgeu	a4,a3,c6e <malloc+0x44>
 c6c:	6a05                	lui	s4,0x1
 c6e:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 c72:	004a1a1b          	sllw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 c76:	00000917          	auipc	s2,0x0
 c7a:	1a290913          	add	s2,s2,418 # e18 <freep>
  if(p == (char*)-1)
 c7e:	5afd                	li	s5,-1
 c80:	a091                	j	cc4 <malloc+0x9a>
 c82:	f04a                	sd	s2,32(sp)
 c84:	e852                	sd	s4,16(sp)
 c86:	e456                	sd	s5,8(sp)
 c88:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 c8a:	00000797          	auipc	a5,0x0
 c8e:	1a678793          	add	a5,a5,422 # e30 <base>
 c92:	00000717          	auipc	a4,0x0
 c96:	18f73323          	sd	a5,390(a4) # e18 <freep>
 c9a:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 c9c:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 ca0:	b7c1                	j	c60 <malloc+0x36>
        prevp->s.ptr = p->s.ptr;
 ca2:	6398                	ld	a4,0(a5)
 ca4:	e118                	sd	a4,0(a0)
 ca6:	a08d                	j	d08 <malloc+0xde>
  hp->s.size = nu;
 ca8:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 cac:	0541                	add	a0,a0,16
 cae:	00000097          	auipc	ra,0x0
 cb2:	efa080e7          	jalr	-262(ra) # ba8 <free>
  return freep;
 cb6:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 cba:	c13d                	beqz	a0,d20 <malloc+0xf6>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 cbc:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 cbe:	4798                	lw	a4,8(a5)
 cc0:	02977463          	bgeu	a4,s1,ce8 <malloc+0xbe>
    if(p == freep)
 cc4:	00093703          	ld	a4,0(s2)
 cc8:	853e                	mv	a0,a5
 cca:	fef719e3          	bne	a4,a5,cbc <malloc+0x92>
  p = sbrk(nu * sizeof(Header));
 cce:	8552                	mv	a0,s4
 cd0:	00000097          	auipc	ra,0x0
 cd4:	92a080e7          	jalr	-1750(ra) # 5fa <sbrk>
  if(p == (char*)-1)
 cd8:	fd5518e3          	bne	a0,s5,ca8 <malloc+0x7e>
        return 0;
 cdc:	4501                	li	a0,0
 cde:	7902                	ld	s2,32(sp)
 ce0:	6a42                	ld	s4,16(sp)
 ce2:	6aa2                	ld	s5,8(sp)
 ce4:	6b02                	ld	s6,0(sp)
 ce6:	a03d                	j	d14 <malloc+0xea>
 ce8:	7902                	ld	s2,32(sp)
 cea:	6a42                	ld	s4,16(sp)
 cec:	6aa2                	ld	s5,8(sp)
 cee:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 cf0:	fae489e3          	beq	s1,a4,ca2 <malloc+0x78>
        p->s.size -= nunits;
 cf4:	4137073b          	subw	a4,a4,s3
 cf8:	c798                	sw	a4,8(a5)
        p += p->s.size;
 cfa:	02071693          	sll	a3,a4,0x20
 cfe:	01c6d713          	srl	a4,a3,0x1c
 d02:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 d04:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 d08:	00000717          	auipc	a4,0x0
 d0c:	10a73823          	sd	a0,272(a4) # e18 <freep>
      return (void*)(p + 1);
 d10:	01078513          	add	a0,a5,16
  }
}
 d14:	70e2                	ld	ra,56(sp)
 d16:	7442                	ld	s0,48(sp)
 d18:	74a2                	ld	s1,40(sp)
 d1a:	69e2                	ld	s3,24(sp)
 d1c:	6121                	add	sp,sp,64
 d1e:	8082                	ret
 d20:	7902                	ld	s2,32(sp)
 d22:	6a42                	ld	s4,16(sp)
 d24:	6aa2                	ld	s5,8(sp)
 d26:	6b02                	ld	s6,0(sp)
 d28:	b7f5                	j	d14 <malloc+0xea>
