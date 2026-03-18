
user/_grep:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <matchstar>:
  return 0;
}

// matchstar: search for c*re at beginning of text
int matchstar(int c, char *re, char *text)
{
   0:	7179                	add	sp,sp,-48
   2:	f406                	sd	ra,40(sp)
   4:	f022                	sd	s0,32(sp)
   6:	ec26                	sd	s1,24(sp)
   8:	e84a                	sd	s2,16(sp)
   a:	e44e                	sd	s3,8(sp)
   c:	e052                	sd	s4,0(sp)
   e:	1800                	add	s0,sp,48
  10:	892a                	mv	s2,a0
  12:	89ae                	mv	s3,a1
  14:	84b2                	mv	s1,a2
  do{  // a * matches zero or more instances
    if(matchhere(re, text))
      return 1;
  }while(*text!='\0' && (*text++==c || c=='.'));
  16:	02e00a13          	li	s4,46
    if(matchhere(re, text))
  1a:	85a6                	mv	a1,s1
  1c:	854e                	mv	a0,s3
  1e:	00000097          	auipc	ra,0x0
  22:	030080e7          	jalr	48(ra) # 4e <matchhere>
  26:	e919                	bnez	a0,3c <matchstar+0x3c>
  }while(*text!='\0' && (*text++==c || c=='.'));
  28:	0004c783          	lbu	a5,0(s1)
  2c:	cb89                	beqz	a5,3e <matchstar+0x3e>
  2e:	0485                	add	s1,s1,1
  30:	2781                	sext.w	a5,a5
  32:	ff2784e3          	beq	a5,s2,1a <matchstar+0x1a>
  36:	ff4902e3          	beq	s2,s4,1a <matchstar+0x1a>
  3a:	a011                	j	3e <matchstar+0x3e>
      return 1;
  3c:	4505                	li	a0,1
  return 0;
}
  3e:	70a2                	ld	ra,40(sp)
  40:	7402                	ld	s0,32(sp)
  42:	64e2                	ld	s1,24(sp)
  44:	6942                	ld	s2,16(sp)
  46:	69a2                	ld	s3,8(sp)
  48:	6a02                	ld	s4,0(sp)
  4a:	6145                	add	sp,sp,48
  4c:	8082                	ret

000000000000004e <matchhere>:
  if(re[0] == '\0')
  4e:	00054703          	lbu	a4,0(a0)
  52:	cb3d                	beqz	a4,c8 <matchhere+0x7a>
{
  54:	1141                	add	sp,sp,-16
  56:	e406                	sd	ra,8(sp)
  58:	e022                	sd	s0,0(sp)
  5a:	0800                	add	s0,sp,16
  5c:	87aa                	mv	a5,a0
  if(re[1] == '*')
  5e:	00154683          	lbu	a3,1(a0)
  62:	02a00613          	li	a2,42
  66:	02c68563          	beq	a3,a2,90 <matchhere+0x42>
  if(re[0] == '$' && re[1] == '\0')
  6a:	02400613          	li	a2,36
  6e:	02c70a63          	beq	a4,a2,a2 <matchhere+0x54>
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
  72:	0005c683          	lbu	a3,0(a1)
  return 0;
  76:	4501                	li	a0,0
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
  78:	ca81                	beqz	a3,88 <matchhere+0x3a>
  7a:	02e00613          	li	a2,46
  7e:	02c70d63          	beq	a4,a2,b8 <matchhere+0x6a>
  return 0;
  82:	4501                	li	a0,0
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
  84:	02d70a63          	beq	a4,a3,b8 <matchhere+0x6a>
}
  88:	60a2                	ld	ra,8(sp)
  8a:	6402                	ld	s0,0(sp)
  8c:	0141                	add	sp,sp,16
  8e:	8082                	ret
    return matchstar(re[0], re+2, text);
  90:	862e                	mv	a2,a1
  92:	00250593          	add	a1,a0,2
  96:	853a                	mv	a0,a4
  98:	00000097          	auipc	ra,0x0
  9c:	f68080e7          	jalr	-152(ra) # 0 <matchstar>
  a0:	b7e5                	j	88 <matchhere+0x3a>
  if(re[0] == '$' && re[1] == '\0')
  a2:	c691                	beqz	a3,ae <matchhere+0x60>
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
  a4:	0005c683          	lbu	a3,0(a1)
  a8:	fee9                	bnez	a3,82 <matchhere+0x34>
  return 0;
  aa:	4501                	li	a0,0
  ac:	bff1                	j	88 <matchhere+0x3a>
    return *text == '\0';
  ae:	0005c503          	lbu	a0,0(a1)
  b2:	00153513          	seqz	a0,a0
  b6:	bfc9                	j	88 <matchhere+0x3a>
    return matchhere(re+1, text+1);
  b8:	0585                	add	a1,a1,1
  ba:	00178513          	add	a0,a5,1
  be:	00000097          	auipc	ra,0x0
  c2:	f90080e7          	jalr	-112(ra) # 4e <matchhere>
  c6:	b7c9                	j	88 <matchhere+0x3a>
    return 1;
  c8:	4505                	li	a0,1
}
  ca:	8082                	ret

00000000000000cc <match>:
{
  cc:	1101                	add	sp,sp,-32
  ce:	ec06                	sd	ra,24(sp)
  d0:	e822                	sd	s0,16(sp)
  d2:	e426                	sd	s1,8(sp)
  d4:	e04a                	sd	s2,0(sp)
  d6:	1000                	add	s0,sp,32
  d8:	892a                	mv	s2,a0
  da:	84ae                	mv	s1,a1
  if(re[0] == '^')
  dc:	00054703          	lbu	a4,0(a0)
  e0:	05e00793          	li	a5,94
  e4:	00f70e63          	beq	a4,a5,100 <match+0x34>
    if(matchhere(re, text))
  e8:	85a6                	mv	a1,s1
  ea:	854a                	mv	a0,s2
  ec:	00000097          	auipc	ra,0x0
  f0:	f62080e7          	jalr	-158(ra) # 4e <matchhere>
  f4:	ed01                	bnez	a0,10c <match+0x40>
  }while(*text++ != '\0');
  f6:	0485                	add	s1,s1,1
  f8:	fff4c783          	lbu	a5,-1(s1)
  fc:	f7f5                	bnez	a5,e8 <match+0x1c>
  fe:	a801                	j	10e <match+0x42>
    return matchhere(re+1, text);
 100:	0505                	add	a0,a0,1
 102:	00000097          	auipc	ra,0x0
 106:	f4c080e7          	jalr	-180(ra) # 4e <matchhere>
 10a:	a011                	j	10e <match+0x42>
      return 1;
 10c:	4505                	li	a0,1
}
 10e:	60e2                	ld	ra,24(sp)
 110:	6442                	ld	s0,16(sp)
 112:	64a2                	ld	s1,8(sp)
 114:	6902                	ld	s2,0(sp)
 116:	6105                	add	sp,sp,32
 118:	8082                	ret

000000000000011a <grep>:
{
 11a:	715d                	add	sp,sp,-80
 11c:	e486                	sd	ra,72(sp)
 11e:	e0a2                	sd	s0,64(sp)
 120:	fc26                	sd	s1,56(sp)
 122:	f84a                	sd	s2,48(sp)
 124:	f44e                	sd	s3,40(sp)
 126:	f052                	sd	s4,32(sp)
 128:	ec56                	sd	s5,24(sp)
 12a:	e85a                	sd	s6,16(sp)
 12c:	e45e                	sd	s7,8(sp)
 12e:	e062                	sd	s8,0(sp)
 130:	0880                	add	s0,sp,80
 132:	89aa                	mv	s3,a0
 134:	8b2e                	mv	s6,a1
  m = 0;
 136:	4a01                	li	s4,0
  while((n = read(fd, buf+m, sizeof(buf)-m-1)) > 0){
 138:	3ff00b93          	li	s7,1023
 13c:	00001a97          	auipc	s5,0x1
 140:	c7ca8a93          	add	s5,s5,-900 # db8 <buf>
 144:	a0a1                	j	18c <grep+0x72>
      p = q+1;
 146:	00148913          	add	s2,s1,1
    while((q = strchr(p, '\n')) != 0){
 14a:	45a9                	li	a1,10
 14c:	854a                	mv	a0,s2
 14e:	00000097          	auipc	ra,0x0
 152:	21e080e7          	jalr	542(ra) # 36c <strchr>
 156:	84aa                	mv	s1,a0
 158:	c905                	beqz	a0,188 <grep+0x6e>
      *q = 0;
 15a:	00048023          	sb	zero,0(s1)
      if(match(pattern, p)){
 15e:	85ca                	mv	a1,s2
 160:	854e                	mv	a0,s3
 162:	00000097          	auipc	ra,0x0
 166:	f6a080e7          	jalr	-150(ra) # cc <match>
 16a:	dd71                	beqz	a0,146 <grep+0x2c>
        *q = '\n';
 16c:	47a9                	li	a5,10
 16e:	00f48023          	sb	a5,0(s1)
        write(1, p, q+1 - p);
 172:	00148613          	add	a2,s1,1
 176:	4126063b          	subw	a2,a2,s2
 17a:	85ca                	mv	a1,s2
 17c:	4505                	li	a0,1
 17e:	00000097          	auipc	ra,0x0
 182:	3e6080e7          	jalr	998(ra) # 564 <write>
 186:	b7c1                	j	146 <grep+0x2c>
    if(m > 0){
 188:	03404763          	bgtz	s4,1b6 <grep+0x9c>
  while((n = read(fd, buf+m, sizeof(buf)-m-1)) > 0){
 18c:	414b863b          	subw	a2,s7,s4
 190:	014a85b3          	add	a1,s5,s4
 194:	855a                	mv	a0,s6
 196:	00000097          	auipc	ra,0x0
 19a:	3c6080e7          	jalr	966(ra) # 55c <read>
 19e:	02a05b63          	blez	a0,1d4 <grep+0xba>
    m += n;
 1a2:	00aa0c3b          	addw	s8,s4,a0
 1a6:	000c0a1b          	sext.w	s4,s8
    buf[m] = '\0';
 1aa:	014a87b3          	add	a5,s5,s4
 1ae:	00078023          	sb	zero,0(a5)
    p = buf;
 1b2:	8956                	mv	s2,s5
    while((q = strchr(p, '\n')) != 0){
 1b4:	bf59                	j	14a <grep+0x30>
      m -= p - buf;
 1b6:	00001517          	auipc	a0,0x1
 1ba:	c0250513          	add	a0,a0,-1022 # db8 <buf>
 1be:	40a90a33          	sub	s4,s2,a0
 1c2:	414c0a3b          	subw	s4,s8,s4
      memmove(buf, p, m);
 1c6:	8652                	mv	a2,s4
 1c8:	85ca                	mv	a1,s2
 1ca:	00000097          	auipc	ra,0x0
 1ce:	2c8080e7          	jalr	712(ra) # 492 <memmove>
 1d2:	bf6d                	j	18c <grep+0x72>
}
 1d4:	60a6                	ld	ra,72(sp)
 1d6:	6406                	ld	s0,64(sp)
 1d8:	74e2                	ld	s1,56(sp)
 1da:	7942                	ld	s2,48(sp)
 1dc:	79a2                	ld	s3,40(sp)
 1de:	7a02                	ld	s4,32(sp)
 1e0:	6ae2                	ld	s5,24(sp)
 1e2:	6b42                	ld	s6,16(sp)
 1e4:	6ba2                	ld	s7,8(sp)
 1e6:	6c02                	ld	s8,0(sp)
 1e8:	6161                	add	sp,sp,80
 1ea:	8082                	ret

00000000000001ec <main>:
{
 1ec:	7179                	add	sp,sp,-48
 1ee:	f406                	sd	ra,40(sp)
 1f0:	f022                	sd	s0,32(sp)
 1f2:	ec26                	sd	s1,24(sp)
 1f4:	e84a                	sd	s2,16(sp)
 1f6:	e44e                	sd	s3,8(sp)
 1f8:	e052                	sd	s4,0(sp)
 1fa:	1800                	add	s0,sp,48
  if(argc <= 1){
 1fc:	4785                	li	a5,1
 1fe:	04a7de63          	bge	a5,a0,25a <main+0x6e>
  pattern = argv[1];
 202:	0085ba03          	ld	s4,8(a1)
  if(argc <= 2){
 206:	4789                	li	a5,2
 208:	06a7d763          	bge	a5,a0,276 <main+0x8a>
 20c:	01058913          	add	s2,a1,16
 210:	ffd5099b          	addw	s3,a0,-3
 214:	02099793          	sll	a5,s3,0x20
 218:	01d7d993          	srl	s3,a5,0x1d
 21c:	05e1                	add	a1,a1,24
 21e:	99ae                	add	s3,s3,a1
    if((fd = open(argv[i], 0)) < 0){
 220:	4581                	li	a1,0
 222:	00093503          	ld	a0,0(s2)
 226:	00000097          	auipc	ra,0x0
 22a:	35e080e7          	jalr	862(ra) # 584 <open>
 22e:	84aa                	mv	s1,a0
 230:	04054e63          	bltz	a0,28c <main+0xa0>
    grep(pattern, fd);
 234:	85aa                	mv	a1,a0
 236:	8552                	mv	a0,s4
 238:	00000097          	auipc	ra,0x0
 23c:	ee2080e7          	jalr	-286(ra) # 11a <grep>
    close(fd);
 240:	8526                	mv	a0,s1
 242:	00000097          	auipc	ra,0x0
 246:	32a080e7          	jalr	810(ra) # 56c <close>
  for(i = 2; i < argc; i++){
 24a:	0921                	add	s2,s2,8
 24c:	fd391ae3          	bne	s2,s3,220 <main+0x34>
  exit(0);
 250:	4501                	li	a0,0
 252:	00000097          	auipc	ra,0x0
 256:	2f2080e7          	jalr	754(ra) # 544 <exit>
    fprintf(2, "usage: grep pattern [file ...]\n");
 25a:	00001597          	auipc	a1,0x1
 25e:	aa658593          	add	a1,a1,-1370 # d00 <malloc+0x104>
 262:	4509                	li	a0,2
 264:	00000097          	auipc	ra,0x0
 268:	6ea080e7          	jalr	1770(ra) # 94e <fprintf>
    exit(1);
 26c:	4505                	li	a0,1
 26e:	00000097          	auipc	ra,0x0
 272:	2d6080e7          	jalr	726(ra) # 544 <exit>
    grep(pattern, 0);
 276:	4581                	li	a1,0
 278:	8552                	mv	a0,s4
 27a:	00000097          	auipc	ra,0x0
 27e:	ea0080e7          	jalr	-352(ra) # 11a <grep>
    exit(0);
 282:	4501                	li	a0,0
 284:	00000097          	auipc	ra,0x0
 288:	2c0080e7          	jalr	704(ra) # 544 <exit>
      printf("grep: cannot open %s\n", argv[i]);
 28c:	00093583          	ld	a1,0(s2)
 290:	00001517          	auipc	a0,0x1
 294:	a9050513          	add	a0,a0,-1392 # d20 <malloc+0x124>
 298:	00000097          	auipc	ra,0x0
 29c:	6e4080e7          	jalr	1764(ra) # 97c <printf>
      exit(1);
 2a0:	4505                	li	a0,1
 2a2:	00000097          	auipc	ra,0x0
 2a6:	2a2080e7          	jalr	674(ra) # 544 <exit>

00000000000002aa <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
 2aa:	1141                	add	sp,sp,-16
 2ac:	e422                	sd	s0,8(sp)
 2ae:	0800                	add	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 2b0:	87aa                	mv	a5,a0
 2b2:	0585                	add	a1,a1,1
 2b4:	0785                	add	a5,a5,1
 2b6:	fff5c703          	lbu	a4,-1(a1)
 2ba:	fee78fa3          	sb	a4,-1(a5)
 2be:	fb75                	bnez	a4,2b2 <strcpy+0x8>
    ;
  return os;
}
 2c0:	6422                	ld	s0,8(sp)
 2c2:	0141                	add	sp,sp,16
 2c4:	8082                	ret

00000000000002c6 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 2c6:	1141                	add	sp,sp,-16
 2c8:	e422                	sd	s0,8(sp)
 2ca:	0800                	add	s0,sp,16
  while(*p && *p == *q)
 2cc:	00054783          	lbu	a5,0(a0)
 2d0:	cb91                	beqz	a5,2e4 <strcmp+0x1e>
 2d2:	0005c703          	lbu	a4,0(a1)
 2d6:	00f71763          	bne	a4,a5,2e4 <strcmp+0x1e>
    p++, q++;
 2da:	0505                	add	a0,a0,1
 2dc:	0585                	add	a1,a1,1
  while(*p && *p == *q)
 2de:	00054783          	lbu	a5,0(a0)
 2e2:	fbe5                	bnez	a5,2d2 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 2e4:	0005c503          	lbu	a0,0(a1)
}
 2e8:	40a7853b          	subw	a0,a5,a0
 2ec:	6422                	ld	s0,8(sp)
 2ee:	0141                	add	sp,sp,16
 2f0:	8082                	ret

00000000000002f2 <strlen>:

uint
strlen(const char *s)
{
 2f2:	1141                	add	sp,sp,-16
 2f4:	e422                	sd	s0,8(sp)
 2f6:	0800                	add	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 2f8:	00054783          	lbu	a5,0(a0)
 2fc:	cf91                	beqz	a5,318 <strlen+0x26>
 2fe:	0505                	add	a0,a0,1
 300:	87aa                	mv	a5,a0
 302:	86be                	mv	a3,a5
 304:	0785                	add	a5,a5,1
 306:	fff7c703          	lbu	a4,-1(a5)
 30a:	ff65                	bnez	a4,302 <strlen+0x10>
 30c:	40a6853b          	subw	a0,a3,a0
 310:	2505                	addw	a0,a0,1
    ;
  return n;
}
 312:	6422                	ld	s0,8(sp)
 314:	0141                	add	sp,sp,16
 316:	8082                	ret
  for(n = 0; s[n]; n++)
 318:	4501                	li	a0,0
 31a:	bfe5                	j	312 <strlen+0x20>

000000000000031c <strcat>:

char *
strcat(char *dst, char *src)
{
 31c:	1141                	add	sp,sp,-16
 31e:	e422                	sd	s0,8(sp)
 320:	0800                	add	s0,sp,16
  char *s = dst;
  while (*dst)
 322:	00054783          	lbu	a5,0(a0)
 326:	c385                	beqz	a5,346 <strcat+0x2a>
 328:	87aa                	mv	a5,a0
    dst++;
 32a:	0785                	add	a5,a5,1
  while (*dst)
 32c:	0007c703          	lbu	a4,0(a5)
 330:	ff6d                	bnez	a4,32a <strcat+0xe>
  while ((*dst++ = *src++) != 0);
 332:	0585                	add	a1,a1,1
 334:	0785                	add	a5,a5,1
 336:	fff5c703          	lbu	a4,-1(a1)
 33a:	fee78fa3          	sb	a4,-1(a5)
 33e:	fb75                	bnez	a4,332 <strcat+0x16>

  return s;
}
 340:	6422                	ld	s0,8(sp)
 342:	0141                	add	sp,sp,16
 344:	8082                	ret
  while (*dst)
 346:	87aa                	mv	a5,a0
 348:	b7ed                	j	332 <strcat+0x16>

000000000000034a <memset>:

void*
memset(void *dst, int c, uint n)
{
 34a:	1141                	add	sp,sp,-16
 34c:	e422                	sd	s0,8(sp)
 34e:	0800                	add	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 350:	ca19                	beqz	a2,366 <memset+0x1c>
 352:	87aa                	mv	a5,a0
 354:	1602                	sll	a2,a2,0x20
 356:	9201                	srl	a2,a2,0x20
 358:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 35c:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 360:	0785                	add	a5,a5,1
 362:	fee79de3          	bne	a5,a4,35c <memset+0x12>
  }
  return dst;
}
 366:	6422                	ld	s0,8(sp)
 368:	0141                	add	sp,sp,16
 36a:	8082                	ret

000000000000036c <strchr>:

char*
strchr(const char *s, char c)
{
 36c:	1141                	add	sp,sp,-16
 36e:	e422                	sd	s0,8(sp)
 370:	0800                	add	s0,sp,16
  for(; *s; s++)
 372:	00054783          	lbu	a5,0(a0)
 376:	cb99                	beqz	a5,38c <strchr+0x20>
    if(*s == c)
 378:	00f58763          	beq	a1,a5,386 <strchr+0x1a>
  for(; *s; s++)
 37c:	0505                	add	a0,a0,1
 37e:	00054783          	lbu	a5,0(a0)
 382:	fbfd                	bnez	a5,378 <strchr+0xc>
      return (char*)s;
  return 0;
 384:	4501                	li	a0,0
}
 386:	6422                	ld	s0,8(sp)
 388:	0141                	add	sp,sp,16
 38a:	8082                	ret
  return 0;
 38c:	4501                	li	a0,0
 38e:	bfe5                	j	386 <strchr+0x1a>

0000000000000390 <gets>:

char*
gets(char *buf, int max)
{
 390:	711d                	add	sp,sp,-96
 392:	ec86                	sd	ra,88(sp)
 394:	e8a2                	sd	s0,80(sp)
 396:	e4a6                	sd	s1,72(sp)
 398:	e0ca                	sd	s2,64(sp)
 39a:	fc4e                	sd	s3,56(sp)
 39c:	f852                	sd	s4,48(sp)
 39e:	f456                	sd	s5,40(sp)
 3a0:	f05a                	sd	s6,32(sp)
 3a2:	ec5e                	sd	s7,24(sp)
 3a4:	1080                	add	s0,sp,96
 3a6:	8baa                	mv	s7,a0
 3a8:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 3aa:	892a                	mv	s2,a0
 3ac:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 3ae:	4aa9                	li	s5,10
 3b0:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 3b2:	89a6                	mv	s3,s1
 3b4:	2485                	addw	s1,s1,1
 3b6:	0344d863          	bge	s1,s4,3e6 <gets+0x56>
    cc = read(0, &c, 1);
 3ba:	4605                	li	a2,1
 3bc:	faf40593          	add	a1,s0,-81
 3c0:	4501                	li	a0,0
 3c2:	00000097          	auipc	ra,0x0
 3c6:	19a080e7          	jalr	410(ra) # 55c <read>
    if(cc < 1)
 3ca:	00a05e63          	blez	a0,3e6 <gets+0x56>
    buf[i++] = c;
 3ce:	faf44783          	lbu	a5,-81(s0)
 3d2:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 3d6:	01578763          	beq	a5,s5,3e4 <gets+0x54>
 3da:	0905                	add	s2,s2,1
 3dc:	fd679be3          	bne	a5,s6,3b2 <gets+0x22>
    buf[i++] = c;
 3e0:	89a6                	mv	s3,s1
 3e2:	a011                	j	3e6 <gets+0x56>
 3e4:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 3e6:	99de                	add	s3,s3,s7
 3e8:	00098023          	sb	zero,0(s3)
  return buf;
}
 3ec:	855e                	mv	a0,s7
 3ee:	60e6                	ld	ra,88(sp)
 3f0:	6446                	ld	s0,80(sp)
 3f2:	64a6                	ld	s1,72(sp)
 3f4:	6906                	ld	s2,64(sp)
 3f6:	79e2                	ld	s3,56(sp)
 3f8:	7a42                	ld	s4,48(sp)
 3fa:	7aa2                	ld	s5,40(sp)
 3fc:	7b02                	ld	s6,32(sp)
 3fe:	6be2                	ld	s7,24(sp)
 400:	6125                	add	sp,sp,96
 402:	8082                	ret

0000000000000404 <stat>:

int
stat(const char *n, struct stat *st)
{
 404:	1101                	add	sp,sp,-32
 406:	ec06                	sd	ra,24(sp)
 408:	e822                	sd	s0,16(sp)
 40a:	e04a                	sd	s2,0(sp)
 40c:	1000                	add	s0,sp,32
 40e:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 410:	4581                	li	a1,0
 412:	00000097          	auipc	ra,0x0
 416:	172080e7          	jalr	370(ra) # 584 <open>
  if(fd < 0)
 41a:	02054663          	bltz	a0,446 <stat+0x42>
 41e:	e426                	sd	s1,8(sp)
 420:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 422:	85ca                	mv	a1,s2
 424:	00000097          	auipc	ra,0x0
 428:	178080e7          	jalr	376(ra) # 59c <fstat>
 42c:	892a                	mv	s2,a0
  close(fd);
 42e:	8526                	mv	a0,s1
 430:	00000097          	auipc	ra,0x0
 434:	13c080e7          	jalr	316(ra) # 56c <close>
  return r;
 438:	64a2                	ld	s1,8(sp)
}
 43a:	854a                	mv	a0,s2
 43c:	60e2                	ld	ra,24(sp)
 43e:	6442                	ld	s0,16(sp)
 440:	6902                	ld	s2,0(sp)
 442:	6105                	add	sp,sp,32
 444:	8082                	ret
    return -1;
 446:	597d                	li	s2,-1
 448:	bfcd                	j	43a <stat+0x36>

000000000000044a <atoi>:

int
atoi(const char *s)
{
 44a:	1141                	add	sp,sp,-16
 44c:	e422                	sd	s0,8(sp)
 44e:	0800                	add	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 450:	00054683          	lbu	a3,0(a0)
 454:	fd06879b          	addw	a5,a3,-48
 458:	0ff7f793          	zext.b	a5,a5
 45c:	4625                	li	a2,9
 45e:	02f66863          	bltu	a2,a5,48e <atoi+0x44>
 462:	872a                	mv	a4,a0
  n = 0;
 464:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 466:	0705                	add	a4,a4,1
 468:	0025179b          	sllw	a5,a0,0x2
 46c:	9fa9                	addw	a5,a5,a0
 46e:	0017979b          	sllw	a5,a5,0x1
 472:	9fb5                	addw	a5,a5,a3
 474:	fd07851b          	addw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 478:	00074683          	lbu	a3,0(a4)
 47c:	fd06879b          	addw	a5,a3,-48
 480:	0ff7f793          	zext.b	a5,a5
 484:	fef671e3          	bgeu	a2,a5,466 <atoi+0x1c>
  return n;
}
 488:	6422                	ld	s0,8(sp)
 48a:	0141                	add	sp,sp,16
 48c:	8082                	ret
  n = 0;
 48e:	4501                	li	a0,0
 490:	bfe5                	j	488 <atoi+0x3e>

0000000000000492 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 492:	1141                	add	sp,sp,-16
 494:	e422                	sd	s0,8(sp)
 496:	0800                	add	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 498:	02b57463          	bgeu	a0,a1,4c0 <memmove+0x2e>
    while(n-- > 0)
 49c:	00c05f63          	blez	a2,4ba <memmove+0x28>
 4a0:	1602                	sll	a2,a2,0x20
 4a2:	9201                	srl	a2,a2,0x20
 4a4:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 4a8:	872a                	mv	a4,a0
      *dst++ = *src++;
 4aa:	0585                	add	a1,a1,1
 4ac:	0705                	add	a4,a4,1
 4ae:	fff5c683          	lbu	a3,-1(a1)
 4b2:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 4b6:	fef71ae3          	bne	a4,a5,4aa <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 4ba:	6422                	ld	s0,8(sp)
 4bc:	0141                	add	sp,sp,16
 4be:	8082                	ret
    dst += n;
 4c0:	00c50733          	add	a4,a0,a2
    src += n;
 4c4:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 4c6:	fec05ae3          	blez	a2,4ba <memmove+0x28>
 4ca:	fff6079b          	addw	a5,a2,-1
 4ce:	1782                	sll	a5,a5,0x20
 4d0:	9381                	srl	a5,a5,0x20
 4d2:	fff7c793          	not	a5,a5
 4d6:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 4d8:	15fd                	add	a1,a1,-1
 4da:	177d                	add	a4,a4,-1
 4dc:	0005c683          	lbu	a3,0(a1)
 4e0:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 4e4:	fee79ae3          	bne	a5,a4,4d8 <memmove+0x46>
 4e8:	bfc9                	j	4ba <memmove+0x28>

00000000000004ea <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 4ea:	1141                	add	sp,sp,-16
 4ec:	e422                	sd	s0,8(sp)
 4ee:	0800                	add	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 4f0:	ca05                	beqz	a2,520 <memcmp+0x36>
 4f2:	fff6069b          	addw	a3,a2,-1
 4f6:	1682                	sll	a3,a3,0x20
 4f8:	9281                	srl	a3,a3,0x20
 4fa:	0685                	add	a3,a3,1
 4fc:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 4fe:	00054783          	lbu	a5,0(a0)
 502:	0005c703          	lbu	a4,0(a1)
 506:	00e79863          	bne	a5,a4,516 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 50a:	0505                	add	a0,a0,1
    p2++;
 50c:	0585                	add	a1,a1,1
  while (n-- > 0) {
 50e:	fed518e3          	bne	a0,a3,4fe <memcmp+0x14>
  }
  return 0;
 512:	4501                	li	a0,0
 514:	a019                	j	51a <memcmp+0x30>
      return *p1 - *p2;
 516:	40e7853b          	subw	a0,a5,a4
}
 51a:	6422                	ld	s0,8(sp)
 51c:	0141                	add	sp,sp,16
 51e:	8082                	ret
  return 0;
 520:	4501                	li	a0,0
 522:	bfe5                	j	51a <memcmp+0x30>

0000000000000524 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 524:	1141                	add	sp,sp,-16
 526:	e406                	sd	ra,8(sp)
 528:	e022                	sd	s0,0(sp)
 52a:	0800                	add	s0,sp,16
  return memmove(dst, src, n);
 52c:	00000097          	auipc	ra,0x0
 530:	f66080e7          	jalr	-154(ra) # 492 <memmove>
}
 534:	60a2                	ld	ra,8(sp)
 536:	6402                	ld	s0,0(sp)
 538:	0141                	add	sp,sp,16
 53a:	8082                	ret

000000000000053c <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 53c:	4885                	li	a7,1
 ecall
 53e:	00000073          	ecall
 ret
 542:	8082                	ret

0000000000000544 <exit>:
.global exit
exit:
 li a7, SYS_exit
 544:	4889                	li	a7,2
 ecall
 546:	00000073          	ecall
 ret
 54a:	8082                	ret

000000000000054c <wait>:
.global wait
wait:
 li a7, SYS_wait
 54c:	488d                	li	a7,3
 ecall
 54e:	00000073          	ecall
 ret
 552:	8082                	ret

0000000000000554 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 554:	4891                	li	a7,4
 ecall
 556:	00000073          	ecall
 ret
 55a:	8082                	ret

000000000000055c <read>:
.global read
read:
 li a7, SYS_read
 55c:	4895                	li	a7,5
 ecall
 55e:	00000073          	ecall
 ret
 562:	8082                	ret

0000000000000564 <write>:
.global write
write:
 li a7, SYS_write
 564:	48c1                	li	a7,16
 ecall
 566:	00000073          	ecall
 ret
 56a:	8082                	ret

000000000000056c <close>:
.global close
close:
 li a7, SYS_close
 56c:	48d5                	li	a7,21
 ecall
 56e:	00000073          	ecall
 ret
 572:	8082                	ret

0000000000000574 <kill>:
.global kill
kill:
 li a7, SYS_kill
 574:	4899                	li	a7,6
 ecall
 576:	00000073          	ecall
 ret
 57a:	8082                	ret

000000000000057c <exec>:
.global exec
exec:
 li a7, SYS_exec
 57c:	489d                	li	a7,7
 ecall
 57e:	00000073          	ecall
 ret
 582:	8082                	ret

0000000000000584 <open>:
.global open
open:
 li a7, SYS_open
 584:	48bd                	li	a7,15
 ecall
 586:	00000073          	ecall
 ret
 58a:	8082                	ret

000000000000058c <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 58c:	48c5                	li	a7,17
 ecall
 58e:	00000073          	ecall
 ret
 592:	8082                	ret

0000000000000594 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 594:	48c9                	li	a7,18
 ecall
 596:	00000073          	ecall
 ret
 59a:	8082                	ret

000000000000059c <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 59c:	48a1                	li	a7,8
 ecall
 59e:	00000073          	ecall
 ret
 5a2:	8082                	ret

00000000000005a4 <link>:
.global link
link:
 li a7, SYS_link
 5a4:	48cd                	li	a7,19
 ecall
 5a6:	00000073          	ecall
 ret
 5aa:	8082                	ret

00000000000005ac <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 5ac:	48d1                	li	a7,20
 ecall
 5ae:	00000073          	ecall
 ret
 5b2:	8082                	ret

00000000000005b4 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 5b4:	48a5                	li	a7,9
 ecall
 5b6:	00000073          	ecall
 ret
 5ba:	8082                	ret

00000000000005bc <dup>:
.global dup
dup:
 li a7, SYS_dup
 5bc:	48a9                	li	a7,10
 ecall
 5be:	00000073          	ecall
 ret
 5c2:	8082                	ret

00000000000005c4 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 5c4:	48ad                	li	a7,11
 ecall
 5c6:	00000073          	ecall
 ret
 5ca:	8082                	ret

00000000000005cc <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 5cc:	48b1                	li	a7,12
 ecall
 5ce:	00000073          	ecall
 ret
 5d2:	8082                	ret

00000000000005d4 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 5d4:	48b5                	li	a7,13
 ecall
 5d6:	00000073          	ecall
 ret
 5da:	8082                	ret

00000000000005dc <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 5dc:	48b9                	li	a7,14
 ecall
 5de:	00000073          	ecall
 ret
 5e2:	8082                	ret

00000000000005e4 <uconnect>:
.global uconnect
uconnect:
 li a7, SYS_uconnect
 5e4:	48f5                	li	a7,29
 ecall
 5e6:	00000073          	ecall
 ret
 5ea:	8082                	ret

00000000000005ec <socket>:
.global socket
socket:
 li a7, SYS_socket
 5ec:	48f9                	li	a7,30
 ecall
 5ee:	00000073          	ecall
 ret
 5f2:	8082                	ret

00000000000005f4 <bind>:
.global bind
bind:
 li a7, SYS_bind
 5f4:	48fd                	li	a7,31
 ecall
 5f6:	00000073          	ecall
 ret
 5fa:	8082                	ret

00000000000005fc <listen>:
.global listen
listen:
 li a7, SYS_listen
 5fc:	02000893          	li	a7,32
 ecall
 600:	00000073          	ecall
 ret
 604:	8082                	ret

0000000000000606 <accept>:
.global accept
accept:
 li a7, SYS_accept
 606:	02100893          	li	a7,33
 ecall
 60a:	00000073          	ecall
 ret
 60e:	8082                	ret

0000000000000610 <connect>:
.global connect
connect:
 li a7, SYS_connect
 610:	02200893          	li	a7,34
 ecall
 614:	00000073          	ecall
 ret
 618:	8082                	ret

000000000000061a <sprintint>:
  return 1;
}

static int
sprintint(char *s, int xx, int base, int sign)
{
 61a:	1101                	add	sp,sp,-32
 61c:	ec22                	sd	s0,24(sp)
 61e:	1000                	add	s0,sp,32
 620:	882a                	mv	a6,a0
  char buf[16];
  int i, n;
  uint x;

  if(sign && (sign = xx < 0))
 622:	c299                	beqz	a3,628 <sprintint+0xe>
 624:	0805c263          	bltz	a1,6a8 <sprintint+0x8e>
    x = -xx;
  else
    x = xx;
 628:	2581                	sext.w	a1,a1
 62a:	4301                	li	t1,0

  i = 0;
 62c:	fe040713          	add	a4,s0,-32
 630:	4501                	li	a0,0
  do {
    buf[i++] = digits[x % base];
 632:	2601                	sext.w	a2,a2
 634:	00000697          	auipc	a3,0x0
 638:	76468693          	add	a3,a3,1892 # d98 <digits>
 63c:	88aa                	mv	a7,a0
 63e:	2505                	addw	a0,a0,1
 640:	02c5f7bb          	remuw	a5,a1,a2
 644:	1782                	sll	a5,a5,0x20
 646:	9381                	srl	a5,a5,0x20
 648:	97b6                	add	a5,a5,a3
 64a:	0007c783          	lbu	a5,0(a5)
 64e:	00f70023          	sb	a5,0(a4)
  } while((x /= base) != 0);
 652:	0005879b          	sext.w	a5,a1
 656:	02c5d5bb          	divuw	a1,a1,a2
 65a:	0705                	add	a4,a4,1
 65c:	fec7f0e3          	bgeu	a5,a2,63c <sprintint+0x22>

  if(sign)
 660:	00030b63          	beqz	t1,676 <sprintint+0x5c>
    buf[i++] = '-';
 664:	ff050793          	add	a5,a0,-16
 668:	97a2                	add	a5,a5,s0
 66a:	02d00713          	li	a4,45
 66e:	fee78823          	sb	a4,-16(a5)
 672:	0028851b          	addw	a0,a7,2

  n = 0;
  while(--i >= 0)
 676:	02a05d63          	blez	a0,6b0 <sprintint+0x96>
 67a:	fe040793          	add	a5,s0,-32
 67e:	00a78733          	add	a4,a5,a0
 682:	87c2                	mv	a5,a6
 684:	00180613          	add	a2,a6,1
 688:	fff5069b          	addw	a3,a0,-1
 68c:	1682                	sll	a3,a3,0x20
 68e:	9281                	srl	a3,a3,0x20
 690:	9636                	add	a2,a2,a3
  *s = c;
 692:	fff74683          	lbu	a3,-1(a4)
 696:	00d78023          	sb	a3,0(a5)
  while(--i >= 0)
 69a:	177d                	add	a4,a4,-1
 69c:	0785                	add	a5,a5,1
 69e:	fec79ae3          	bne	a5,a2,692 <sprintint+0x78>
    n += sputc(s+n, buf[i]);
  return n;
}
 6a2:	6462                	ld	s0,24(sp)
 6a4:	6105                	add	sp,sp,32
 6a6:	8082                	ret
    x = -xx;
 6a8:	40b005bb          	negw	a1,a1
  if(sign && (sign = xx < 0))
 6ac:	4305                	li	t1,1
    x = -xx;
 6ae:	bfbd                	j	62c <sprintint+0x12>
  while(--i >= 0)
 6b0:	4501                	li	a0,0
 6b2:	bfc5                	j	6a2 <sprintint+0x88>

00000000000006b4 <putc>:
{
 6b4:	1101                	add	sp,sp,-32
 6b6:	ec06                	sd	ra,24(sp)
 6b8:	e822                	sd	s0,16(sp)
 6ba:	1000                	add	s0,sp,32
 6bc:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 6c0:	4605                	li	a2,1
 6c2:	fef40593          	add	a1,s0,-17
 6c6:	00000097          	auipc	ra,0x0
 6ca:	e9e080e7          	jalr	-354(ra) # 564 <write>
}
 6ce:	60e2                	ld	ra,24(sp)
 6d0:	6442                	ld	s0,16(sp)
 6d2:	6105                	add	sp,sp,32
 6d4:	8082                	ret

00000000000006d6 <printint>:
{
 6d6:	7139                	add	sp,sp,-64
 6d8:	fc06                	sd	ra,56(sp)
 6da:	f822                	sd	s0,48(sp)
 6dc:	f426                	sd	s1,40(sp)
 6de:	0080                	add	s0,sp,64
 6e0:	84aa                	mv	s1,a0
  if(sgn && xx < 0){
 6e2:	c299                	beqz	a3,6e8 <printint+0x12>
 6e4:	0805cb63          	bltz	a1,77a <printint+0xa4>
    x = xx;
 6e8:	2581                	sext.w	a1,a1
  neg = 0;
 6ea:	4881                	li	a7,0
 6ec:	fc040693          	add	a3,s0,-64
  i = 0;
 6f0:	4701                	li	a4,0
    buf[i++] = digits[x % base];
 6f2:	2601                	sext.w	a2,a2
 6f4:	00000517          	auipc	a0,0x0
 6f8:	6a450513          	add	a0,a0,1700 # d98 <digits>
 6fc:	883a                	mv	a6,a4
 6fe:	2705                	addw	a4,a4,1
 700:	02c5f7bb          	remuw	a5,a1,a2
 704:	1782                	sll	a5,a5,0x20
 706:	9381                	srl	a5,a5,0x20
 708:	97aa                	add	a5,a5,a0
 70a:	0007c783          	lbu	a5,0(a5)
 70e:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 712:	0005879b          	sext.w	a5,a1
 716:	02c5d5bb          	divuw	a1,a1,a2
 71a:	0685                	add	a3,a3,1
 71c:	fec7f0e3          	bgeu	a5,a2,6fc <printint+0x26>
  if(neg)
 720:	00088c63          	beqz	a7,738 <printint+0x62>
    buf[i++] = '-';
 724:	fd070793          	add	a5,a4,-48
 728:	00878733          	add	a4,a5,s0
 72c:	02d00793          	li	a5,45
 730:	fef70823          	sb	a5,-16(a4)
 734:	0028071b          	addw	a4,a6,2
  while(--i >= 0)
 738:	02e05c63          	blez	a4,770 <printint+0x9a>
 73c:	f04a                	sd	s2,32(sp)
 73e:	ec4e                	sd	s3,24(sp)
 740:	fc040793          	add	a5,s0,-64
 744:	00e78933          	add	s2,a5,a4
 748:	fff78993          	add	s3,a5,-1
 74c:	99ba                	add	s3,s3,a4
 74e:	377d                	addw	a4,a4,-1
 750:	1702                	sll	a4,a4,0x20
 752:	9301                	srl	a4,a4,0x20
 754:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 758:	fff94583          	lbu	a1,-1(s2)
 75c:	8526                	mv	a0,s1
 75e:	00000097          	auipc	ra,0x0
 762:	f56080e7          	jalr	-170(ra) # 6b4 <putc>
  while(--i >= 0)
 766:	197d                	add	s2,s2,-1
 768:	ff3918e3          	bne	s2,s3,758 <printint+0x82>
 76c:	7902                	ld	s2,32(sp)
 76e:	69e2                	ld	s3,24(sp)
}
 770:	70e2                	ld	ra,56(sp)
 772:	7442                	ld	s0,48(sp)
 774:	74a2                	ld	s1,40(sp)
 776:	6121                	add	sp,sp,64
 778:	8082                	ret
    x = -xx;
 77a:	40b005bb          	negw	a1,a1
    neg = 1;
 77e:	4885                	li	a7,1
    x = -xx;
 780:	b7b5                	j	6ec <printint+0x16>

0000000000000782 <vprintf>:
{
 782:	715d                	add	sp,sp,-80
 784:	e486                	sd	ra,72(sp)
 786:	e0a2                	sd	s0,64(sp)
 788:	f84a                	sd	s2,48(sp)
 78a:	0880                	add	s0,sp,80
  for(i = 0; fmt[i]; i++){
 78c:	0005c903          	lbu	s2,0(a1)
 790:	1a090a63          	beqz	s2,944 <vprintf+0x1c2>
 794:	fc26                	sd	s1,56(sp)
 796:	f44e                	sd	s3,40(sp)
 798:	f052                	sd	s4,32(sp)
 79a:	ec56                	sd	s5,24(sp)
 79c:	e85a                	sd	s6,16(sp)
 79e:	e45e                	sd	s7,8(sp)
 7a0:	8aaa                	mv	s5,a0
 7a2:	8bb2                	mv	s7,a2
 7a4:	00158493          	add	s1,a1,1
  state = 0;
 7a8:	4981                	li	s3,0
    } else if(state == '%'){
 7aa:	02500a13          	li	s4,37
 7ae:	4b55                	li	s6,21
 7b0:	a839                	j	7ce <vprintf+0x4c>
        putc(fd, c);
 7b2:	85ca                	mv	a1,s2
 7b4:	8556                	mv	a0,s5
 7b6:	00000097          	auipc	ra,0x0
 7ba:	efe080e7          	jalr	-258(ra) # 6b4 <putc>
 7be:	a019                	j	7c4 <vprintf+0x42>
    } else if(state == '%'){
 7c0:	01498d63          	beq	s3,s4,7da <vprintf+0x58>
  for(i = 0; fmt[i]; i++){
 7c4:	0485                	add	s1,s1,1
 7c6:	fff4c903          	lbu	s2,-1(s1)
 7ca:	16090763          	beqz	s2,938 <vprintf+0x1b6>
    if(state == 0){
 7ce:	fe0999e3          	bnez	s3,7c0 <vprintf+0x3e>
      if(c == '%'){
 7d2:	ff4910e3          	bne	s2,s4,7b2 <vprintf+0x30>
        state = '%';
 7d6:	89d2                	mv	s3,s4
 7d8:	b7f5                	j	7c4 <vprintf+0x42>
      if(c == 'd'){
 7da:	13490463          	beq	s2,s4,902 <vprintf+0x180>
 7de:	f9d9079b          	addw	a5,s2,-99
 7e2:	0ff7f793          	zext.b	a5,a5
 7e6:	12fb6763          	bltu	s6,a5,914 <vprintf+0x192>
 7ea:	f9d9079b          	addw	a5,s2,-99
 7ee:	0ff7f713          	zext.b	a4,a5
 7f2:	12eb6163          	bltu	s6,a4,914 <vprintf+0x192>
 7f6:	00271793          	sll	a5,a4,0x2
 7fa:	00000717          	auipc	a4,0x0
 7fe:	54670713          	add	a4,a4,1350 # d40 <malloc+0x144>
 802:	97ba                	add	a5,a5,a4
 804:	439c                	lw	a5,0(a5)
 806:	97ba                	add	a5,a5,a4
 808:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 80a:	008b8913          	add	s2,s7,8
 80e:	4685                	li	a3,1
 810:	4629                	li	a2,10
 812:	000ba583          	lw	a1,0(s7)
 816:	8556                	mv	a0,s5
 818:	00000097          	auipc	ra,0x0
 81c:	ebe080e7          	jalr	-322(ra) # 6d6 <printint>
 820:	8bca                	mv	s7,s2
      state = 0;
 822:	4981                	li	s3,0
 824:	b745                	j	7c4 <vprintf+0x42>
        printint(fd, va_arg(ap, uint64), 10, 0);
 826:	008b8913          	add	s2,s7,8
 82a:	4681                	li	a3,0
 82c:	4629                	li	a2,10
 82e:	000ba583          	lw	a1,0(s7)
 832:	8556                	mv	a0,s5
 834:	00000097          	auipc	ra,0x0
 838:	ea2080e7          	jalr	-350(ra) # 6d6 <printint>
 83c:	8bca                	mv	s7,s2
      state = 0;
 83e:	4981                	li	s3,0
 840:	b751                	j	7c4 <vprintf+0x42>
        printint(fd, va_arg(ap, int), 16, 0);
 842:	008b8913          	add	s2,s7,8
 846:	4681                	li	a3,0
 848:	4641                	li	a2,16
 84a:	000ba583          	lw	a1,0(s7)
 84e:	8556                	mv	a0,s5
 850:	00000097          	auipc	ra,0x0
 854:	e86080e7          	jalr	-378(ra) # 6d6 <printint>
 858:	8bca                	mv	s7,s2
      state = 0;
 85a:	4981                	li	s3,0
 85c:	b7a5                	j	7c4 <vprintf+0x42>
 85e:	e062                	sd	s8,0(sp)
        printptr(fd, va_arg(ap, uint64));
 860:	008b8c13          	add	s8,s7,8
 864:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 868:	03000593          	li	a1,48
 86c:	8556                	mv	a0,s5
 86e:	00000097          	auipc	ra,0x0
 872:	e46080e7          	jalr	-442(ra) # 6b4 <putc>
  putc(fd, 'x');
 876:	07800593          	li	a1,120
 87a:	8556                	mv	a0,s5
 87c:	00000097          	auipc	ra,0x0
 880:	e38080e7          	jalr	-456(ra) # 6b4 <putc>
 884:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 886:	00000b97          	auipc	s7,0x0
 88a:	512b8b93          	add	s7,s7,1298 # d98 <digits>
 88e:	03c9d793          	srl	a5,s3,0x3c
 892:	97de                	add	a5,a5,s7
 894:	0007c583          	lbu	a1,0(a5)
 898:	8556                	mv	a0,s5
 89a:	00000097          	auipc	ra,0x0
 89e:	e1a080e7          	jalr	-486(ra) # 6b4 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 8a2:	0992                	sll	s3,s3,0x4
 8a4:	397d                	addw	s2,s2,-1
 8a6:	fe0914e3          	bnez	s2,88e <vprintf+0x10c>
        printptr(fd, va_arg(ap, uint64));
 8aa:	8be2                	mv	s7,s8
      state = 0;
 8ac:	4981                	li	s3,0
 8ae:	6c02                	ld	s8,0(sp)
 8b0:	bf11                	j	7c4 <vprintf+0x42>
        s = va_arg(ap, char*);
 8b2:	008b8993          	add	s3,s7,8
 8b6:	000bb903          	ld	s2,0(s7)
        if(s == 0)
 8ba:	02090163          	beqz	s2,8dc <vprintf+0x15a>
        while(*s != 0){
 8be:	00094583          	lbu	a1,0(s2)
 8c2:	c9a5                	beqz	a1,932 <vprintf+0x1b0>
          putc(fd, *s);
 8c4:	8556                	mv	a0,s5
 8c6:	00000097          	auipc	ra,0x0
 8ca:	dee080e7          	jalr	-530(ra) # 6b4 <putc>
          s++;
 8ce:	0905                	add	s2,s2,1
        while(*s != 0){
 8d0:	00094583          	lbu	a1,0(s2)
 8d4:	f9e5                	bnez	a1,8c4 <vprintf+0x142>
        s = va_arg(ap, char*);
 8d6:	8bce                	mv	s7,s3
      state = 0;
 8d8:	4981                	li	s3,0
 8da:	b5ed                	j	7c4 <vprintf+0x42>
          s = "(null)";
 8dc:	00000917          	auipc	s2,0x0
 8e0:	45c90913          	add	s2,s2,1116 # d38 <malloc+0x13c>
        while(*s != 0){
 8e4:	02800593          	li	a1,40
 8e8:	bff1                	j	8c4 <vprintf+0x142>
        putc(fd, va_arg(ap, uint));
 8ea:	008b8913          	add	s2,s7,8
 8ee:	000bc583          	lbu	a1,0(s7)
 8f2:	8556                	mv	a0,s5
 8f4:	00000097          	auipc	ra,0x0
 8f8:	dc0080e7          	jalr	-576(ra) # 6b4 <putc>
 8fc:	8bca                	mv	s7,s2
      state = 0;
 8fe:	4981                	li	s3,0
 900:	b5d1                	j	7c4 <vprintf+0x42>
        putc(fd, c);
 902:	02500593          	li	a1,37
 906:	8556                	mv	a0,s5
 908:	00000097          	auipc	ra,0x0
 90c:	dac080e7          	jalr	-596(ra) # 6b4 <putc>
      state = 0;
 910:	4981                	li	s3,0
 912:	bd4d                	j	7c4 <vprintf+0x42>
        putc(fd, '%');
 914:	02500593          	li	a1,37
 918:	8556                	mv	a0,s5
 91a:	00000097          	auipc	ra,0x0
 91e:	d9a080e7          	jalr	-614(ra) # 6b4 <putc>
        putc(fd, c);
 922:	85ca                	mv	a1,s2
 924:	8556                	mv	a0,s5
 926:	00000097          	auipc	ra,0x0
 92a:	d8e080e7          	jalr	-626(ra) # 6b4 <putc>
      state = 0;
 92e:	4981                	li	s3,0
 930:	bd51                	j	7c4 <vprintf+0x42>
        s = va_arg(ap, char*);
 932:	8bce                	mv	s7,s3
      state = 0;
 934:	4981                	li	s3,0
 936:	b579                	j	7c4 <vprintf+0x42>
 938:	74e2                	ld	s1,56(sp)
 93a:	79a2                	ld	s3,40(sp)
 93c:	7a02                	ld	s4,32(sp)
 93e:	6ae2                	ld	s5,24(sp)
 940:	6b42                	ld	s6,16(sp)
 942:	6ba2                	ld	s7,8(sp)
}
 944:	60a6                	ld	ra,72(sp)
 946:	6406                	ld	s0,64(sp)
 948:	7942                	ld	s2,48(sp)
 94a:	6161                	add	sp,sp,80
 94c:	8082                	ret

000000000000094e <fprintf>:
{
 94e:	715d                	add	sp,sp,-80
 950:	ec06                	sd	ra,24(sp)
 952:	e822                	sd	s0,16(sp)
 954:	1000                	add	s0,sp,32
 956:	e010                	sd	a2,0(s0)
 958:	e414                	sd	a3,8(s0)
 95a:	e818                	sd	a4,16(s0)
 95c:	ec1c                	sd	a5,24(s0)
 95e:	03043023          	sd	a6,32(s0)
 962:	03143423          	sd	a7,40(s0)
  va_start(ap, fmt);
 966:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 96a:	8622                	mv	a2,s0
 96c:	00000097          	auipc	ra,0x0
 970:	e16080e7          	jalr	-490(ra) # 782 <vprintf>
}
 974:	60e2                	ld	ra,24(sp)
 976:	6442                	ld	s0,16(sp)
 978:	6161                	add	sp,sp,80
 97a:	8082                	ret

000000000000097c <printf>:
{
 97c:	711d                	add	sp,sp,-96
 97e:	ec06                	sd	ra,24(sp)
 980:	e822                	sd	s0,16(sp)
 982:	1000                	add	s0,sp,32
 984:	e40c                	sd	a1,8(s0)
 986:	e810                	sd	a2,16(s0)
 988:	ec14                	sd	a3,24(s0)
 98a:	f018                	sd	a4,32(s0)
 98c:	f41c                	sd	a5,40(s0)
 98e:	03043823          	sd	a6,48(s0)
 992:	03143c23          	sd	a7,56(s0)
  va_start(ap, fmt);
 996:	00840613          	add	a2,s0,8
 99a:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 99e:	85aa                	mv	a1,a0
 9a0:	4505                	li	a0,1
 9a2:	00000097          	auipc	ra,0x0
 9a6:	de0080e7          	jalr	-544(ra) # 782 <vprintf>
}
 9aa:	60e2                	ld	ra,24(sp)
 9ac:	6442                	ld	s0,16(sp)
 9ae:	6125                	add	sp,sp,96
 9b0:	8082                	ret

00000000000009b2 <snprintf>:

int
snprintf(char *buf, int sz, char *fmt, ...)
{
 9b2:	7135                	add	sp,sp,-160
 9b4:	f486                	sd	ra,104(sp)
 9b6:	f0a2                	sd	s0,96(sp)
 9b8:	eca6                	sd	s1,88(sp)
 9ba:	1880                	add	s0,sp,112
 9bc:	e414                	sd	a3,8(s0)
 9be:	e818                	sd	a4,16(s0)
 9c0:	ec1c                	sd	a5,24(s0)
 9c2:	03043023          	sd	a6,32(s0)
 9c6:	03143423          	sd	a7,40(s0)
  va_list ap;
  int i, c;
  int off = 0;
  char *s;

  if (fmt == 0)
 9ca:	16060b63          	beqz	a2,b40 <snprintf+0x18e>
 9ce:	e8ca                	sd	s2,80(sp)
 9d0:	e4ce                	sd	s3,72(sp)
 9d2:	fc56                	sd	s5,56(sp)
 9d4:	f85a                	sd	s6,48(sp)
 9d6:	8b2a                	mv	s6,a0
 9d8:	8aae                	mv	s5,a1
 9da:	89b2                	mv	s3,a2
    return -1;

  va_start(ap, fmt);
 9dc:	00840793          	add	a5,s0,8
 9e0:	f8f43c23          	sd	a5,-104(s0)
  int off = 0;
 9e4:	4481                	li	s1,0
  for(i = 0; off < sz && (c = fmt[i] & 0xff) != 0; i++){
 9e6:	4901                	li	s2,0
 9e8:	00b05f63          	blez	a1,a06 <snprintf+0x54>
 9ec:	e0d2                	sd	s4,64(sp)
 9ee:	f45e                	sd	s7,40(sp)
 9f0:	f062                	sd	s8,32(sp)
 9f2:	ec66                	sd	s9,24(sp)
    if(c != '%'){
 9f4:	02500a13          	li	s4,37
      continue;
    }
    c = fmt[++i] & 0xff;
    if(c == 0)
      break;
    switch(c){
 9f8:	07300b93          	li	s7,115
 9fc:	07800c93          	li	s9,120
 a00:	06400c13          	li	s8,100
 a04:	a839                	j	a22 <snprintf+0x70>
      off += sputc(buf+off, '%');
      off += sputc(buf+off, c);
      break;
    }
  }
  return off;
 a06:	4481                	li	s1,0
 a08:	6946                	ld	s2,80(sp)
 a0a:	69a6                	ld	s3,72(sp)
 a0c:	7ae2                	ld	s5,56(sp)
 a0e:	7b42                	ld	s6,48(sp)
 a10:	a0cd                	j	af2 <snprintf+0x140>
  *s = c;
 a12:	009b0733          	add	a4,s6,s1
 a16:	00f70023          	sb	a5,0(a4)
      off += sputc(buf+off, c);
 a1a:	2485                	addw	s1,s1,1
  for(i = 0; off < sz && (c = fmt[i] & 0xff) != 0; i++){
 a1c:	2905                	addw	s2,s2,1
 a1e:	1554d563          	bge	s1,s5,b68 <snprintf+0x1b6>
 a22:	012987b3          	add	a5,s3,s2
 a26:	0007c783          	lbu	a5,0(a5)
 a2a:	0007871b          	sext.w	a4,a5
 a2e:	10078063          	beqz	a5,b2e <snprintf+0x17c>
    if(c != '%'){
 a32:	ff4710e3          	bne	a4,s4,a12 <snprintf+0x60>
    c = fmt[++i] & 0xff;
 a36:	2905                	addw	s2,s2,1
 a38:	012987b3          	add	a5,s3,s2
 a3c:	0007c783          	lbu	a5,0(a5)
    if(c == 0)
 a40:	10078263          	beqz	a5,b44 <snprintf+0x192>
    switch(c){
 a44:	05778c63          	beq	a5,s7,a9c <snprintf+0xea>
 a48:	02fbe763          	bltu	s7,a5,a76 <snprintf+0xc4>
 a4c:	0d478063          	beq	a5,s4,b0c <snprintf+0x15a>
 a50:	0d879463          	bne	a5,s8,b18 <snprintf+0x166>
      off += sprintint(buf+off, va_arg(ap, int), 10, 1);
 a54:	f9843783          	ld	a5,-104(s0)
 a58:	00878713          	add	a4,a5,8
 a5c:	f8e43c23          	sd	a4,-104(s0)
 a60:	4685                	li	a3,1
 a62:	4629                	li	a2,10
 a64:	438c                	lw	a1,0(a5)
 a66:	009b0533          	add	a0,s6,s1
 a6a:	00000097          	auipc	ra,0x0
 a6e:	bb0080e7          	jalr	-1104(ra) # 61a <sprintint>
 a72:	9ca9                	addw	s1,s1,a0
      break;
 a74:	b765                	j	a1c <snprintf+0x6a>
    switch(c){
 a76:	0b979163          	bne	a5,s9,b18 <snprintf+0x166>
      off += sprintint(buf+off, va_arg(ap, int), 16, 1);
 a7a:	f9843783          	ld	a5,-104(s0)
 a7e:	00878713          	add	a4,a5,8
 a82:	f8e43c23          	sd	a4,-104(s0)
 a86:	4685                	li	a3,1
 a88:	4641                	li	a2,16
 a8a:	438c                	lw	a1,0(a5)
 a8c:	009b0533          	add	a0,s6,s1
 a90:	00000097          	auipc	ra,0x0
 a94:	b8a080e7          	jalr	-1142(ra) # 61a <sprintint>
 a98:	9ca9                	addw	s1,s1,a0
      break;
 a9a:	b749                	j	a1c <snprintf+0x6a>
      if((s = va_arg(ap, char*)) == 0)
 a9c:	f9843783          	ld	a5,-104(s0)
 aa0:	00878713          	add	a4,a5,8
 aa4:	f8e43c23          	sd	a4,-104(s0)
 aa8:	6388                	ld	a0,0(a5)
 aaa:	c931                	beqz	a0,afe <snprintf+0x14c>
      for(; *s && off < sz; s++)
 aac:	00054703          	lbu	a4,0(a0)
 ab0:	d735                	beqz	a4,a1c <snprintf+0x6a>
 ab2:	0b54d263          	bge	s1,s5,b56 <snprintf+0x1a4>
 ab6:	009b06b3          	add	a3,s6,s1
 aba:	409a863b          	subw	a2,s5,s1
 abe:	1602                	sll	a2,a2,0x20
 ac0:	9201                	srl	a2,a2,0x20
 ac2:	962a                	add	a2,a2,a0
 ac4:	87aa                	mv	a5,a0
        off += sputc(buf+off, *s);
 ac6:	0014859b          	addw	a1,s1,1
 aca:	9d89                	subw	a1,a1,a0
  *s = c;
 acc:	00e68023          	sb	a4,0(a3)
        off += sputc(buf+off, *s);
 ad0:	00f584bb          	addw	s1,a1,a5
      for(; *s && off < sz; s++)
 ad4:	0785                	add	a5,a5,1
 ad6:	0007c703          	lbu	a4,0(a5)
 ada:	d329                	beqz	a4,a1c <snprintf+0x6a>
 adc:	0685                	add	a3,a3,1
 ade:	fec797e3          	bne	a5,a2,acc <snprintf+0x11a>
 ae2:	6946                	ld	s2,80(sp)
 ae4:	69a6                	ld	s3,72(sp)
 ae6:	6a06                	ld	s4,64(sp)
 ae8:	7ae2                	ld	s5,56(sp)
 aea:	7b42                	ld	s6,48(sp)
 aec:	7ba2                	ld	s7,40(sp)
 aee:	7c02                	ld	s8,32(sp)
 af0:	6ce2                	ld	s9,24(sp)
 af2:	8526                	mv	a0,s1
 af4:	70a6                	ld	ra,104(sp)
 af6:	7406                	ld	s0,96(sp)
 af8:	64e6                	ld	s1,88(sp)
 afa:	610d                	add	sp,sp,160
 afc:	8082                	ret
      for(; *s && off < sz; s++)
 afe:	02800713          	li	a4,40
        s = "(null)";
 b02:	00000517          	auipc	a0,0x0
 b06:	23650513          	add	a0,a0,566 # d38 <malloc+0x13c>
 b0a:	b765                	j	ab2 <snprintf+0x100>
  *s = c;
 b0c:	009b07b3          	add	a5,s6,s1
 b10:	01478023          	sb	s4,0(a5)
      off += sputc(buf+off, '%');
 b14:	2485                	addw	s1,s1,1
      break;
 b16:	b719                	j	a1c <snprintf+0x6a>
  *s = c;
 b18:	009b0733          	add	a4,s6,s1
 b1c:	01470023          	sb	s4,0(a4)
      off += sputc(buf+off, c);
 b20:	0014871b          	addw	a4,s1,1
  *s = c;
 b24:	975a                	add	a4,a4,s6
 b26:	00f70023          	sb	a5,0(a4)
      off += sputc(buf+off, c);
 b2a:	2489                	addw	s1,s1,2
      break;
 b2c:	bdc5                	j	a1c <snprintf+0x6a>
 b2e:	6946                	ld	s2,80(sp)
 b30:	69a6                	ld	s3,72(sp)
 b32:	6a06                	ld	s4,64(sp)
 b34:	7ae2                	ld	s5,56(sp)
 b36:	7b42                	ld	s6,48(sp)
 b38:	7ba2                	ld	s7,40(sp)
 b3a:	7c02                	ld	s8,32(sp)
 b3c:	6ce2                	ld	s9,24(sp)
 b3e:	bf55                	j	af2 <snprintf+0x140>
    return -1;
 b40:	54fd                	li	s1,-1
 b42:	bf45                	j	af2 <snprintf+0x140>
 b44:	6946                	ld	s2,80(sp)
 b46:	69a6                	ld	s3,72(sp)
 b48:	6a06                	ld	s4,64(sp)
 b4a:	7ae2                	ld	s5,56(sp)
 b4c:	7b42                	ld	s6,48(sp)
 b4e:	7ba2                	ld	s7,40(sp)
 b50:	7c02                	ld	s8,32(sp)
 b52:	6ce2                	ld	s9,24(sp)
 b54:	bf79                	j	af2 <snprintf+0x140>
 b56:	6946                	ld	s2,80(sp)
 b58:	69a6                	ld	s3,72(sp)
 b5a:	6a06                	ld	s4,64(sp)
 b5c:	7ae2                	ld	s5,56(sp)
 b5e:	7b42                	ld	s6,48(sp)
 b60:	7ba2                	ld	s7,40(sp)
 b62:	7c02                	ld	s8,32(sp)
 b64:	6ce2                	ld	s9,24(sp)
 b66:	b771                	j	af2 <snprintf+0x140>
 b68:	6946                	ld	s2,80(sp)
 b6a:	69a6                	ld	s3,72(sp)
 b6c:	6a06                	ld	s4,64(sp)
 b6e:	7ae2                	ld	s5,56(sp)
 b70:	7b42                	ld	s6,48(sp)
 b72:	7ba2                	ld	s7,40(sp)
 b74:	7c02                	ld	s8,32(sp)
 b76:	6ce2                	ld	s9,24(sp)
 b78:	bfad                	j	af2 <snprintf+0x140>

0000000000000b7a <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 b7a:	1141                	add	sp,sp,-16
 b7c:	e422                	sd	s0,8(sp)
 b7e:	0800                	add	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 b80:	ff050693          	add	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 b84:	00000797          	auipc	a5,0x0
 b88:	22c7b783          	ld	a5,556(a5) # db0 <freep>
 b8c:	a02d                	j	bb6 <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 b8e:	4618                	lw	a4,8(a2)
 b90:	9f2d                	addw	a4,a4,a1
 b92:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 b96:	6398                	ld	a4,0(a5)
 b98:	6310                	ld	a2,0(a4)
 b9a:	a83d                	j	bd8 <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 b9c:	ff852703          	lw	a4,-8(a0)
 ba0:	9f31                	addw	a4,a4,a2
 ba2:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 ba4:	ff053683          	ld	a3,-16(a0)
 ba8:	a091                	j	bec <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 baa:	6398                	ld	a4,0(a5)
 bac:	00e7e463          	bltu	a5,a4,bb4 <free+0x3a>
 bb0:	00e6ea63          	bltu	a3,a4,bc4 <free+0x4a>
{
 bb4:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 bb6:	fed7fae3          	bgeu	a5,a3,baa <free+0x30>
 bba:	6398                	ld	a4,0(a5)
 bbc:	00e6e463          	bltu	a3,a4,bc4 <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 bc0:	fee7eae3          	bltu	a5,a4,bb4 <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 bc4:	ff852583          	lw	a1,-8(a0)
 bc8:	6390                	ld	a2,0(a5)
 bca:	02059813          	sll	a6,a1,0x20
 bce:	01c85713          	srl	a4,a6,0x1c
 bd2:	9736                	add	a4,a4,a3
 bd4:	fae60de3          	beq	a2,a4,b8e <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 bd8:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 bdc:	4790                	lw	a2,8(a5)
 bde:	02061593          	sll	a1,a2,0x20
 be2:	01c5d713          	srl	a4,a1,0x1c
 be6:	973e                	add	a4,a4,a5
 be8:	fae68ae3          	beq	a3,a4,b9c <free+0x22>
    p->s.ptr = bp->s.ptr;
 bec:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 bee:	00000717          	auipc	a4,0x0
 bf2:	1cf73123          	sd	a5,450(a4) # db0 <freep>
}
 bf6:	6422                	ld	s0,8(sp)
 bf8:	0141                	add	sp,sp,16
 bfa:	8082                	ret

0000000000000bfc <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 bfc:	7139                	add	sp,sp,-64
 bfe:	fc06                	sd	ra,56(sp)
 c00:	f822                	sd	s0,48(sp)
 c02:	f426                	sd	s1,40(sp)
 c04:	ec4e                	sd	s3,24(sp)
 c06:	0080                	add	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 c08:	02051493          	sll	s1,a0,0x20
 c0c:	9081                	srl	s1,s1,0x20
 c0e:	04bd                	add	s1,s1,15
 c10:	8091                	srl	s1,s1,0x4
 c12:	0014899b          	addw	s3,s1,1
 c16:	0485                	add	s1,s1,1
  if((prevp = freep) == 0){
 c18:	00000517          	auipc	a0,0x0
 c1c:	19853503          	ld	a0,408(a0) # db0 <freep>
 c20:	c915                	beqz	a0,c54 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 c22:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 c24:	4798                	lw	a4,8(a5)
 c26:	08977e63          	bgeu	a4,s1,cc2 <malloc+0xc6>
 c2a:	f04a                	sd	s2,32(sp)
 c2c:	e852                	sd	s4,16(sp)
 c2e:	e456                	sd	s5,8(sp)
 c30:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 c32:	8a4e                	mv	s4,s3
 c34:	0009871b          	sext.w	a4,s3
 c38:	6685                	lui	a3,0x1
 c3a:	00d77363          	bgeu	a4,a3,c40 <malloc+0x44>
 c3e:	6a05                	lui	s4,0x1
 c40:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 c44:	004a1a1b          	sllw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 c48:	00000917          	auipc	s2,0x0
 c4c:	16890913          	add	s2,s2,360 # db0 <freep>
  if(p == (char*)-1)
 c50:	5afd                	li	s5,-1
 c52:	a091                	j	c96 <malloc+0x9a>
 c54:	f04a                	sd	s2,32(sp)
 c56:	e852                	sd	s4,16(sp)
 c58:	e456                	sd	s5,8(sp)
 c5a:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 c5c:	00000797          	auipc	a5,0x0
 c60:	55c78793          	add	a5,a5,1372 # 11b8 <base>
 c64:	00000717          	auipc	a4,0x0
 c68:	14f73623          	sd	a5,332(a4) # db0 <freep>
 c6c:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 c6e:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 c72:	b7c1                	j	c32 <malloc+0x36>
        prevp->s.ptr = p->s.ptr;
 c74:	6398                	ld	a4,0(a5)
 c76:	e118                	sd	a4,0(a0)
 c78:	a08d                	j	cda <malloc+0xde>
  hp->s.size = nu;
 c7a:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 c7e:	0541                	add	a0,a0,16
 c80:	00000097          	auipc	ra,0x0
 c84:	efa080e7          	jalr	-262(ra) # b7a <free>
  return freep;
 c88:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 c8c:	c13d                	beqz	a0,cf2 <malloc+0xf6>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 c8e:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 c90:	4798                	lw	a4,8(a5)
 c92:	02977463          	bgeu	a4,s1,cba <malloc+0xbe>
    if(p == freep)
 c96:	00093703          	ld	a4,0(s2)
 c9a:	853e                	mv	a0,a5
 c9c:	fef719e3          	bne	a4,a5,c8e <malloc+0x92>
  p = sbrk(nu * sizeof(Header));
 ca0:	8552                	mv	a0,s4
 ca2:	00000097          	auipc	ra,0x0
 ca6:	92a080e7          	jalr	-1750(ra) # 5cc <sbrk>
  if(p == (char*)-1)
 caa:	fd5518e3          	bne	a0,s5,c7a <malloc+0x7e>
        return 0;
 cae:	4501                	li	a0,0
 cb0:	7902                	ld	s2,32(sp)
 cb2:	6a42                	ld	s4,16(sp)
 cb4:	6aa2                	ld	s5,8(sp)
 cb6:	6b02                	ld	s6,0(sp)
 cb8:	a03d                	j	ce6 <malloc+0xea>
 cba:	7902                	ld	s2,32(sp)
 cbc:	6a42                	ld	s4,16(sp)
 cbe:	6aa2                	ld	s5,8(sp)
 cc0:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 cc2:	fae489e3          	beq	s1,a4,c74 <malloc+0x78>
        p->s.size -= nunits;
 cc6:	4137073b          	subw	a4,a4,s3
 cca:	c798                	sw	a4,8(a5)
        p += p->s.size;
 ccc:	02071693          	sll	a3,a4,0x20
 cd0:	01c6d713          	srl	a4,a3,0x1c
 cd4:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 cd6:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 cda:	00000717          	auipc	a4,0x0
 cde:	0ca73b23          	sd	a0,214(a4) # db0 <freep>
      return (void*)(p + 1);
 ce2:	01078513          	add	a0,a5,16
  }
}
 ce6:	70e2                	ld	ra,56(sp)
 ce8:	7442                	ld	s0,48(sp)
 cea:	74a2                	ld	s1,40(sp)
 cec:	69e2                	ld	s3,24(sp)
 cee:	6121                	add	sp,sp,64
 cf0:	8082                	ret
 cf2:	7902                	ld	s2,32(sp)
 cf4:	6a42                	ld	s4,16(sp)
 cf6:	6aa2                	ld	s5,8(sp)
 cf8:	6b02                	ld	s6,0(sp)
 cfa:	b7f5                	j	ce6 <malloc+0xea>
