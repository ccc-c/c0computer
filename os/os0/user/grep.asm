
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
  1e:	02c000ef          	jal	4a <matchhere>
  22:	e919                	bnez	a0,38 <matchstar+0x38>
  }while(*text!='\0' && (*text++==c || c=='.'));
  24:	0004c783          	lbu	a5,0(s1)
  28:	cb89                	beqz	a5,3a <matchstar+0x3a>
  2a:	0485                	add	s1,s1,1
  2c:	2781                	sext.w	a5,a5
  2e:	ff2786e3          	beq	a5,s2,1a <matchstar+0x1a>
  32:	ff4904e3          	beq	s2,s4,1a <matchstar+0x1a>
  36:	a011                	j	3a <matchstar+0x3a>
      return 1;
  38:	4505                	li	a0,1
  return 0;
}
  3a:	70a2                	ld	ra,40(sp)
  3c:	7402                	ld	s0,32(sp)
  3e:	64e2                	ld	s1,24(sp)
  40:	6942                	ld	s2,16(sp)
  42:	69a2                	ld	s3,8(sp)
  44:	6a02                	ld	s4,0(sp)
  46:	6145                	add	sp,sp,48
  48:	8082                	ret

000000000000004a <matchhere>:
  if(re[0] == '\0')
  4a:	00054703          	lbu	a4,0(a0)
  4e:	c73d                	beqz	a4,bc <matchhere+0x72>
{
  50:	1141                	add	sp,sp,-16
  52:	e406                	sd	ra,8(sp)
  54:	e022                	sd	s0,0(sp)
  56:	0800                	add	s0,sp,16
  58:	87aa                	mv	a5,a0
  if(re[1] == '*')
  5a:	00154683          	lbu	a3,1(a0)
  5e:	02a00613          	li	a2,42
  62:	02c68563          	beq	a3,a2,8c <matchhere+0x42>
  if(re[0] == '$' && re[1] == '\0')
  66:	02400613          	li	a2,36
  6a:	02c70863          	beq	a4,a2,9a <matchhere+0x50>
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
  6e:	0005c683          	lbu	a3,0(a1)
  return 0;
  72:	4501                	li	a0,0
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
  74:	ca81                	beqz	a3,84 <matchhere+0x3a>
  76:	02e00613          	li	a2,46
  7a:	02c70b63          	beq	a4,a2,b0 <matchhere+0x66>
  return 0;
  7e:	4501                	li	a0,0
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
  80:	02d70863          	beq	a4,a3,b0 <matchhere+0x66>
}
  84:	60a2                	ld	ra,8(sp)
  86:	6402                	ld	s0,0(sp)
  88:	0141                	add	sp,sp,16
  8a:	8082                	ret
    return matchstar(re[0], re+2, text);
  8c:	862e                	mv	a2,a1
  8e:	00250593          	add	a1,a0,2
  92:	853a                	mv	a0,a4
  94:	f6dff0ef          	jal	0 <matchstar>
  98:	b7f5                	j	84 <matchhere+0x3a>
  if(re[0] == '$' && re[1] == '\0')
  9a:	c691                	beqz	a3,a6 <matchhere+0x5c>
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
  9c:	0005c683          	lbu	a3,0(a1)
  a0:	fef9                	bnez	a3,7e <matchhere+0x34>
  return 0;
  a2:	4501                	li	a0,0
  a4:	b7c5                	j	84 <matchhere+0x3a>
    return *text == '\0';
  a6:	0005c503          	lbu	a0,0(a1)
  aa:	00153513          	seqz	a0,a0
  ae:	bfd9                	j	84 <matchhere+0x3a>
    return matchhere(re+1, text+1);
  b0:	0585                	add	a1,a1,1
  b2:	00178513          	add	a0,a5,1
  b6:	f95ff0ef          	jal	4a <matchhere>
  ba:	b7e9                	j	84 <matchhere+0x3a>
    return 1;
  bc:	4505                	li	a0,1
}
  be:	8082                	ret

00000000000000c0 <match>:
{
  c0:	1101                	add	sp,sp,-32
  c2:	ec06                	sd	ra,24(sp)
  c4:	e822                	sd	s0,16(sp)
  c6:	e426                	sd	s1,8(sp)
  c8:	e04a                	sd	s2,0(sp)
  ca:	1000                	add	s0,sp,32
  cc:	892a                	mv	s2,a0
  ce:	84ae                	mv	s1,a1
  if(re[0] == '^')
  d0:	00054703          	lbu	a4,0(a0)
  d4:	05e00793          	li	a5,94
  d8:	00f70c63          	beq	a4,a5,f0 <match+0x30>
    if(matchhere(re, text))
  dc:	85a6                	mv	a1,s1
  de:	854a                	mv	a0,s2
  e0:	f6bff0ef          	jal	4a <matchhere>
  e4:	e911                	bnez	a0,f8 <match+0x38>
  }while(*text++ != '\0');
  e6:	0485                	add	s1,s1,1
  e8:	fff4c783          	lbu	a5,-1(s1)
  ec:	fbe5                	bnez	a5,dc <match+0x1c>
  ee:	a031                	j	fa <match+0x3a>
    return matchhere(re+1, text);
  f0:	0505                	add	a0,a0,1
  f2:	f59ff0ef          	jal	4a <matchhere>
  f6:	a011                	j	fa <match+0x3a>
      return 1;
  f8:	4505                	li	a0,1
}
  fa:	60e2                	ld	ra,24(sp)
  fc:	6442                	ld	s0,16(sp)
  fe:	64a2                	ld	s1,8(sp)
 100:	6902                	ld	s2,0(sp)
 102:	6105                	add	sp,sp,32
 104:	8082                	ret

0000000000000106 <grep>:
{
 106:	715d                	add	sp,sp,-80
 108:	e486                	sd	ra,72(sp)
 10a:	e0a2                	sd	s0,64(sp)
 10c:	fc26                	sd	s1,56(sp)
 10e:	f84a                	sd	s2,48(sp)
 110:	f44e                	sd	s3,40(sp)
 112:	f052                	sd	s4,32(sp)
 114:	ec56                	sd	s5,24(sp)
 116:	e85a                	sd	s6,16(sp)
 118:	e45e                	sd	s7,8(sp)
 11a:	e062                	sd	s8,0(sp)
 11c:	0880                	add	s0,sp,80
 11e:	89aa                	mv	s3,a0
 120:	8b2e                	mv	s6,a1
  m = 0;
 122:	4a01                	li	s4,0
  while((n = read(fd, buf+m, sizeof(buf)-m-1)) > 0){
 124:	3ff00b93          	li	s7,1023
 128:	00001a97          	auipc	s5,0x1
 12c:	ee8a8a93          	add	s5,s5,-280 # 1010 <buf>
 130:	a835                	j	16c <grep+0x66>
      p = q+1;
 132:	00148913          	add	s2,s1,1
    while((q = strchr(p, '\n')) != 0){
 136:	45a9                	li	a1,10
 138:	854a                	mv	a0,s2
 13a:	1c6000ef          	jal	300 <strchr>
 13e:	84aa                	mv	s1,a0
 140:	c505                	beqz	a0,168 <grep+0x62>
      *q = 0;
 142:	00048023          	sb	zero,0(s1)
      if(match(pattern, p)){
 146:	85ca                	mv	a1,s2
 148:	854e                	mv	a0,s3
 14a:	f77ff0ef          	jal	c0 <match>
 14e:	d175                	beqz	a0,132 <grep+0x2c>
        *q = '\n';
 150:	47a9                	li	a5,10
 152:	00f48023          	sb	a5,0(s1)
        write(1, p, q+1 - p);
 156:	00148613          	add	a2,s1,1
 15a:	4126063b          	subw	a2,a2,s2
 15e:	85ca                	mv	a1,s2
 160:	4505                	li	a0,1
 162:	602000ef          	jal	764 <write>
 166:	b7f1                	j	132 <grep+0x2c>
    if(m > 0){
 168:	03404563          	bgtz	s4,192 <grep+0x8c>
  while((n = read(fd, buf+m, sizeof(buf)-m-1)) > 0){
 16c:	414b863b          	subw	a2,s7,s4
 170:	014a85b3          	add	a1,s5,s4
 174:	855a                	mv	a0,s6
 176:	5e6000ef          	jal	75c <read>
 17a:	02a05963          	blez	a0,1ac <grep+0xa6>
    m += n;
 17e:	00aa0c3b          	addw	s8,s4,a0
 182:	000c0a1b          	sext.w	s4,s8
    buf[m] = '\0';
 186:	014a87b3          	add	a5,s5,s4
 18a:	00078023          	sb	zero,0(a5)
    p = buf;
 18e:	8956                	mv	s2,s5
    while((q = strchr(p, '\n')) != 0){
 190:	b75d                	j	136 <grep+0x30>
      m -= p - buf;
 192:	00001517          	auipc	a0,0x1
 196:	e7e50513          	add	a0,a0,-386 # 1010 <buf>
 19a:	40a90a33          	sub	s4,s2,a0
 19e:	414c0a3b          	subw	s4,s8,s4
      memmove(buf, p, m);
 1a2:	8652                	mv	a2,s4
 1a4:	85ca                	mv	a1,s2
 1a6:	270000ef          	jal	416 <memmove>
 1aa:	b7c9                	j	16c <grep+0x66>
}
 1ac:	60a6                	ld	ra,72(sp)
 1ae:	6406                	ld	s0,64(sp)
 1b0:	74e2                	ld	s1,56(sp)
 1b2:	7942                	ld	s2,48(sp)
 1b4:	79a2                	ld	s3,40(sp)
 1b6:	7a02                	ld	s4,32(sp)
 1b8:	6ae2                	ld	s5,24(sp)
 1ba:	6b42                	ld	s6,16(sp)
 1bc:	6ba2                	ld	s7,8(sp)
 1be:	6c02                	ld	s8,0(sp)
 1c0:	6161                	add	sp,sp,80
 1c2:	8082                	ret

00000000000001c4 <main>:
{
 1c4:	7179                	add	sp,sp,-48
 1c6:	f406                	sd	ra,40(sp)
 1c8:	f022                	sd	s0,32(sp)
 1ca:	ec26                	sd	s1,24(sp)
 1cc:	e84a                	sd	s2,16(sp)
 1ce:	e44e                	sd	s3,8(sp)
 1d0:	e052                	sd	s4,0(sp)
 1d2:	1800                	add	s0,sp,48
  if(argc <= 1){
 1d4:	4785                	li	a5,1
 1d6:	04a7d663          	bge	a5,a0,222 <main+0x5e>
  pattern = argv[1];
 1da:	0085ba03          	ld	s4,8(a1)
  if(argc <= 2){
 1de:	4789                	li	a5,2
 1e0:	04a7db63          	bge	a5,a0,236 <main+0x72>
 1e4:	01058913          	add	s2,a1,16
 1e8:	ffd5099b          	addw	s3,a0,-3
 1ec:	02099793          	sll	a5,s3,0x20
 1f0:	01d7d993          	srl	s3,a5,0x1d
 1f4:	05e1                	add	a1,a1,24
 1f6:	99ae                	add	s3,s3,a1
    if((fd = open(argv[i], O_RDONLY)) < 0){
 1f8:	4581                	li	a1,0
 1fa:	00093503          	ld	a0,0(s2)
 1fe:	586000ef          	jal	784 <open>
 202:	84aa                	mv	s1,a0
 204:	04054063          	bltz	a0,244 <main+0x80>
    grep(pattern, fd);
 208:	85aa                	mv	a1,a0
 20a:	8552                	mv	a0,s4
 20c:	efbff0ef          	jal	106 <grep>
    close(fd);
 210:	8526                	mv	a0,s1
 212:	55a000ef          	jal	76c <close>
  for(i = 2; i < argc; i++){
 216:	0921                	add	s2,s2,8
 218:	ff3910e3          	bne	s2,s3,1f8 <main+0x34>
  exit(0);
 21c:	4501                	li	a0,0
 21e:	526000ef          	jal	744 <exit>
    fprintf(2, "usage: grep pattern [file ...]\n");
 222:	00001597          	auipc	a1,0x1
 226:	b1e58593          	add	a1,a1,-1250 # d40 <malloc+0xde>
 22a:	4509                	li	a0,2
 22c:	159000ef          	jal	b84 <fprintf>
    exit(1);
 230:	4505                	li	a0,1
 232:	512000ef          	jal	744 <exit>
    grep(pattern, 0);
 236:	4581                	li	a1,0
 238:	8552                	mv	a0,s4
 23a:	ecdff0ef          	jal	106 <grep>
    exit(0);
 23e:	4501                	li	a0,0
 240:	504000ef          	jal	744 <exit>
      printf("grep: cannot open %s\n", argv[i]);
 244:	00093583          	ld	a1,0(s2)
 248:	00001517          	auipc	a0,0x1
 24c:	b1850513          	add	a0,a0,-1256 # d60 <malloc+0xfe>
 250:	15f000ef          	jal	bae <printf>
      exit(1);
 254:	4505                	li	a0,1
 256:	4ee000ef          	jal	744 <exit>

000000000000025a <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start()
{
 25a:	1141                	add	sp,sp,-16
 25c:	e406                	sd	ra,8(sp)
 25e:	e022                	sd	s0,0(sp)
 260:	0800                	add	s0,sp,16
  extern int main();
  main();
 262:	f63ff0ef          	jal	1c4 <main>
  exit(0);
 266:	4501                	li	a0,0
 268:	4dc000ef          	jal	744 <exit>

000000000000026c <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
 26c:	1141                	add	sp,sp,-16
 26e:	e422                	sd	s0,8(sp)
 270:	0800                	add	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 272:	87aa                	mv	a5,a0
 274:	0585                	add	a1,a1,1
 276:	0785                	add	a5,a5,1
 278:	fff5c703          	lbu	a4,-1(a1)
 27c:	fee78fa3          	sb	a4,-1(a5)
 280:	fb75                	bnez	a4,274 <strcpy+0x8>
    ;
  return os;
}
 282:	6422                	ld	s0,8(sp)
 284:	0141                	add	sp,sp,16
 286:	8082                	ret

0000000000000288 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 288:	1141                	add	sp,sp,-16
 28a:	e422                	sd	s0,8(sp)
 28c:	0800                	add	s0,sp,16
  while(*p && *p == *q)
 28e:	00054783          	lbu	a5,0(a0)
 292:	cb91                	beqz	a5,2a6 <strcmp+0x1e>
 294:	0005c703          	lbu	a4,0(a1)
 298:	00f71763          	bne	a4,a5,2a6 <strcmp+0x1e>
    p++, q++;
 29c:	0505                	add	a0,a0,1
 29e:	0585                	add	a1,a1,1
  while(*p && *p == *q)
 2a0:	00054783          	lbu	a5,0(a0)
 2a4:	fbe5                	bnez	a5,294 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 2a6:	0005c503          	lbu	a0,0(a1)
}
 2aa:	40a7853b          	subw	a0,a5,a0
 2ae:	6422                	ld	s0,8(sp)
 2b0:	0141                	add	sp,sp,16
 2b2:	8082                	ret

00000000000002b4 <strlen>:

uint
strlen(const char *s)
{
 2b4:	1141                	add	sp,sp,-16
 2b6:	e422                	sd	s0,8(sp)
 2b8:	0800                	add	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 2ba:	00054783          	lbu	a5,0(a0)
 2be:	cf91                	beqz	a5,2da <strlen+0x26>
 2c0:	0505                	add	a0,a0,1
 2c2:	87aa                	mv	a5,a0
 2c4:	86be                	mv	a3,a5
 2c6:	0785                	add	a5,a5,1
 2c8:	fff7c703          	lbu	a4,-1(a5)
 2cc:	ff65                	bnez	a4,2c4 <strlen+0x10>
 2ce:	40a6853b          	subw	a0,a3,a0
 2d2:	2505                	addw	a0,a0,1
    ;
  return n;
}
 2d4:	6422                	ld	s0,8(sp)
 2d6:	0141                	add	sp,sp,16
 2d8:	8082                	ret
  for(n = 0; s[n]; n++)
 2da:	4501                	li	a0,0
 2dc:	bfe5                	j	2d4 <strlen+0x20>

00000000000002de <memset>:

void*
memset(void *dst, int c, uint n)
{
 2de:	1141                	add	sp,sp,-16
 2e0:	e422                	sd	s0,8(sp)
 2e2:	0800                	add	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 2e4:	ca19                	beqz	a2,2fa <memset+0x1c>
 2e6:	87aa                	mv	a5,a0
 2e8:	1602                	sll	a2,a2,0x20
 2ea:	9201                	srl	a2,a2,0x20
 2ec:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 2f0:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 2f4:	0785                	add	a5,a5,1
 2f6:	fee79de3          	bne	a5,a4,2f0 <memset+0x12>
  }
  return dst;
}
 2fa:	6422                	ld	s0,8(sp)
 2fc:	0141                	add	sp,sp,16
 2fe:	8082                	ret

0000000000000300 <strchr>:

char*
strchr(const char *s, char c)
{
 300:	1141                	add	sp,sp,-16
 302:	e422                	sd	s0,8(sp)
 304:	0800                	add	s0,sp,16
  for(; *s; s++)
 306:	00054783          	lbu	a5,0(a0)
 30a:	cb99                	beqz	a5,320 <strchr+0x20>
    if(*s == c)
 30c:	00f58763          	beq	a1,a5,31a <strchr+0x1a>
  for(; *s; s++)
 310:	0505                	add	a0,a0,1
 312:	00054783          	lbu	a5,0(a0)
 316:	fbfd                	bnez	a5,30c <strchr+0xc>
      return (char*)s;
  return 0;
 318:	4501                	li	a0,0
}
 31a:	6422                	ld	s0,8(sp)
 31c:	0141                	add	sp,sp,16
 31e:	8082                	ret
  return 0;
 320:	4501                	li	a0,0
 322:	bfe5                	j	31a <strchr+0x1a>

0000000000000324 <gets>:

char*
gets(char *buf, int max)
{
 324:	711d                	add	sp,sp,-96
 326:	ec86                	sd	ra,88(sp)
 328:	e8a2                	sd	s0,80(sp)
 32a:	e4a6                	sd	s1,72(sp)
 32c:	e0ca                	sd	s2,64(sp)
 32e:	fc4e                	sd	s3,56(sp)
 330:	f852                	sd	s4,48(sp)
 332:	f456                	sd	s5,40(sp)
 334:	f05a                	sd	s6,32(sp)
 336:	ec5e                	sd	s7,24(sp)
 338:	1080                	add	s0,sp,96
 33a:	8baa                	mv	s7,a0
 33c:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 33e:	892a                	mv	s2,a0
 340:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 342:	4aa9                	li	s5,10
 344:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 346:	89a6                	mv	s3,s1
 348:	2485                	addw	s1,s1,1
 34a:	0344d663          	bge	s1,s4,376 <gets+0x52>
    cc = read(0, &c, 1);
 34e:	4605                	li	a2,1
 350:	faf40593          	add	a1,s0,-81
 354:	4501                	li	a0,0
 356:	406000ef          	jal	75c <read>
    if(cc < 1)
 35a:	00a05e63          	blez	a0,376 <gets+0x52>
    buf[i++] = c;
 35e:	faf44783          	lbu	a5,-81(s0)
 362:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 366:	01578763          	beq	a5,s5,374 <gets+0x50>
 36a:	0905                	add	s2,s2,1
 36c:	fd679de3          	bne	a5,s6,346 <gets+0x22>
  for(i=0; i+1 < max; ){
 370:	89a6                	mv	s3,s1
 372:	a011                	j	376 <gets+0x52>
 374:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 376:	99de                	add	s3,s3,s7
 378:	00098023          	sb	zero,0(s3)
  return buf;
}
 37c:	855e                	mv	a0,s7
 37e:	60e6                	ld	ra,88(sp)
 380:	6446                	ld	s0,80(sp)
 382:	64a6                	ld	s1,72(sp)
 384:	6906                	ld	s2,64(sp)
 386:	79e2                	ld	s3,56(sp)
 388:	7a42                	ld	s4,48(sp)
 38a:	7aa2                	ld	s5,40(sp)
 38c:	7b02                	ld	s6,32(sp)
 38e:	6be2                	ld	s7,24(sp)
 390:	6125                	add	sp,sp,96
 392:	8082                	ret

0000000000000394 <stat>:

int
stat(const char *n, struct stat *st)
{
 394:	1101                	add	sp,sp,-32
 396:	ec06                	sd	ra,24(sp)
 398:	e822                	sd	s0,16(sp)
 39a:	e426                	sd	s1,8(sp)
 39c:	e04a                	sd	s2,0(sp)
 39e:	1000                	add	s0,sp,32
 3a0:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 3a2:	4581                	li	a1,0
 3a4:	3e0000ef          	jal	784 <open>
  if(fd < 0)
 3a8:	02054163          	bltz	a0,3ca <stat+0x36>
 3ac:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 3ae:	85ca                	mv	a1,s2
 3b0:	3ec000ef          	jal	79c <fstat>
 3b4:	892a                	mv	s2,a0
  close(fd);
 3b6:	8526                	mv	a0,s1
 3b8:	3b4000ef          	jal	76c <close>
  return r;
}
 3bc:	854a                	mv	a0,s2
 3be:	60e2                	ld	ra,24(sp)
 3c0:	6442                	ld	s0,16(sp)
 3c2:	64a2                	ld	s1,8(sp)
 3c4:	6902                	ld	s2,0(sp)
 3c6:	6105                	add	sp,sp,32
 3c8:	8082                	ret
    return -1;
 3ca:	597d                	li	s2,-1
 3cc:	bfc5                	j	3bc <stat+0x28>

00000000000003ce <atoi>:

int
atoi(const char *s)
{
 3ce:	1141                	add	sp,sp,-16
 3d0:	e422                	sd	s0,8(sp)
 3d2:	0800                	add	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 3d4:	00054683          	lbu	a3,0(a0)
 3d8:	fd06879b          	addw	a5,a3,-48
 3dc:	0ff7f793          	zext.b	a5,a5
 3e0:	4625                	li	a2,9
 3e2:	02f66863          	bltu	a2,a5,412 <atoi+0x44>
 3e6:	872a                	mv	a4,a0
  n = 0;
 3e8:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 3ea:	0705                	add	a4,a4,1
 3ec:	0025179b          	sllw	a5,a0,0x2
 3f0:	9fa9                	addw	a5,a5,a0
 3f2:	0017979b          	sllw	a5,a5,0x1
 3f6:	9fb5                	addw	a5,a5,a3
 3f8:	fd07851b          	addw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 3fc:	00074683          	lbu	a3,0(a4)
 400:	fd06879b          	addw	a5,a3,-48
 404:	0ff7f793          	zext.b	a5,a5
 408:	fef671e3          	bgeu	a2,a5,3ea <atoi+0x1c>
  return n;
}
 40c:	6422                	ld	s0,8(sp)
 40e:	0141                	add	sp,sp,16
 410:	8082                	ret
  n = 0;
 412:	4501                	li	a0,0
 414:	bfe5                	j	40c <atoi+0x3e>

0000000000000416 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 416:	1141                	add	sp,sp,-16
 418:	e422                	sd	s0,8(sp)
 41a:	0800                	add	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 41c:	02b57463          	bgeu	a0,a1,444 <memmove+0x2e>
    while(n-- > 0)
 420:	00c05f63          	blez	a2,43e <memmove+0x28>
 424:	1602                	sll	a2,a2,0x20
 426:	9201                	srl	a2,a2,0x20
 428:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 42c:	872a                	mv	a4,a0
      *dst++ = *src++;
 42e:	0585                	add	a1,a1,1
 430:	0705                	add	a4,a4,1
 432:	fff5c683          	lbu	a3,-1(a1)
 436:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 43a:	fee79ae3          	bne	a5,a4,42e <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 43e:	6422                	ld	s0,8(sp)
 440:	0141                	add	sp,sp,16
 442:	8082                	ret
    dst += n;
 444:	00c50733          	add	a4,a0,a2
    src += n;
 448:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 44a:	fec05ae3          	blez	a2,43e <memmove+0x28>
 44e:	fff6079b          	addw	a5,a2,-1
 452:	1782                	sll	a5,a5,0x20
 454:	9381                	srl	a5,a5,0x20
 456:	fff7c793          	not	a5,a5
 45a:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 45c:	15fd                	add	a1,a1,-1
 45e:	177d                	add	a4,a4,-1
 460:	0005c683          	lbu	a3,0(a1)
 464:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 468:	fee79ae3          	bne	a5,a4,45c <memmove+0x46>
 46c:	bfc9                	j	43e <memmove+0x28>

000000000000046e <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 46e:	1141                	add	sp,sp,-16
 470:	e422                	sd	s0,8(sp)
 472:	0800                	add	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 474:	ca05                	beqz	a2,4a4 <memcmp+0x36>
 476:	fff6069b          	addw	a3,a2,-1
 47a:	1682                	sll	a3,a3,0x20
 47c:	9281                	srl	a3,a3,0x20
 47e:	0685                	add	a3,a3,1
 480:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 482:	00054783          	lbu	a5,0(a0)
 486:	0005c703          	lbu	a4,0(a1)
 48a:	00e79863          	bne	a5,a4,49a <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 48e:	0505                	add	a0,a0,1
    p2++;
 490:	0585                	add	a1,a1,1
  while (n-- > 0) {
 492:	fed518e3          	bne	a0,a3,482 <memcmp+0x14>
  }
  return 0;
 496:	4501                	li	a0,0
 498:	a019                	j	49e <memcmp+0x30>
      return *p1 - *p2;
 49a:	40e7853b          	subw	a0,a5,a4
}
 49e:	6422                	ld	s0,8(sp)
 4a0:	0141                	add	sp,sp,16
 4a2:	8082                	ret
  return 0;
 4a4:	4501                	li	a0,0
 4a6:	bfe5                	j	49e <memcmp+0x30>

00000000000004a8 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 4a8:	1141                	add	sp,sp,-16
 4aa:	e406                	sd	ra,8(sp)
 4ac:	e022                	sd	s0,0(sp)
 4ae:	0800                	add	s0,sp,16
  return memmove(dst, src, n);
 4b0:	f67ff0ef          	jal	416 <memmove>
}
 4b4:	60a2                	ld	ra,8(sp)
 4b6:	6402                	ld	s0,0(sp)
 4b8:	0141                	add	sp,sp,16
 4ba:	8082                	ret

00000000000004bc <htons>:
    return (v & 0x000000ff) << 24 | (v & 0x0000ff00) << 8 | (v & 0x00ff0000) >> 8 | (v & 0xff000000) >> 24;
}

uint16_t
htons(uint16_t h)
{
 4bc:	1141                	add	sp,sp,-16
 4be:	e422                	sd	s0,8(sp)
 4c0:	0800                	add	s0,sp,16
    if (!endian) {
 4c2:	00001797          	auipc	a5,0x1
 4c6:	b3e7a783          	lw	a5,-1218(a5) # 1000 <endian>
 4ca:	e385                	bnez	a5,4ea <htons+0x2e>
        endian = byteorder();
 4cc:	4d200793          	li	a5,1234
 4d0:	00001717          	auipc	a4,0x1
 4d4:	b2f72823          	sw	a5,-1232(a4) # 1000 <endian>
    return (v & 0x00ff) << 8 | (v & 0xff00 ) >> 8;
 4d8:	0085579b          	srlw	a5,a0,0x8
 4dc:	0085151b          	sllw	a0,a0,0x8
 4e0:	8fc9                	or	a5,a5,a0
 4e2:	03079513          	sll	a0,a5,0x30
 4e6:	9141                	srl	a0,a0,0x30
 4e8:	a029                	j	4f2 <htons+0x36>
    }
    return endian == __LITTLE_ENDIAN ? byteswap16(h) : h;
 4ea:	4d200713          	li	a4,1234
 4ee:	fee785e3          	beq	a5,a4,4d8 <htons+0x1c>
}
 4f2:	6422                	ld	s0,8(sp)
 4f4:	0141                	add	sp,sp,16
 4f6:	8082                	ret

00000000000004f8 <ntohs>:

uint16_t
ntohs(uint16_t n)
{
 4f8:	1141                	add	sp,sp,-16
 4fa:	e422                	sd	s0,8(sp)
 4fc:	0800                	add	s0,sp,16
    if (!endian) {
 4fe:	00001797          	auipc	a5,0x1
 502:	b027a783          	lw	a5,-1278(a5) # 1000 <endian>
 506:	e385                	bnez	a5,526 <ntohs+0x2e>
        endian = byteorder();
 508:	4d200793          	li	a5,1234
 50c:	00001717          	auipc	a4,0x1
 510:	aef72a23          	sw	a5,-1292(a4) # 1000 <endian>
    return (v & 0x00ff) << 8 | (v & 0xff00 ) >> 8;
 514:	0085579b          	srlw	a5,a0,0x8
 518:	0085151b          	sllw	a0,a0,0x8
 51c:	8fc9                	or	a5,a5,a0
 51e:	03079513          	sll	a0,a5,0x30
 522:	9141                	srl	a0,a0,0x30
 524:	a029                	j	52e <ntohs+0x36>
    }
    return endian == __LITTLE_ENDIAN ? byteswap16(n) : n;
 526:	4d200713          	li	a4,1234
 52a:	fee785e3          	beq	a5,a4,514 <ntohs+0x1c>
}
 52e:	6422                	ld	s0,8(sp)
 530:	0141                	add	sp,sp,16
 532:	8082                	ret

0000000000000534 <htonl>:

uint32_t
htonl(uint32_t h)
{
 534:	1141                	add	sp,sp,-16
 536:	e422                	sd	s0,8(sp)
 538:	0800                	add	s0,sp,16
    if (!endian) {
 53a:	00001797          	auipc	a5,0x1
 53e:	ac67a783          	lw	a5,-1338(a5) # 1000 <endian>
 542:	ef85                	bnez	a5,57a <htonl+0x46>
        endian = byteorder();
 544:	4d200793          	li	a5,1234
 548:	00001717          	auipc	a4,0x1
 54c:	aaf72c23          	sw	a5,-1352(a4) # 1000 <endian>
    return (v & 0x000000ff) << 24 | (v & 0x0000ff00) << 8 | (v & 0x00ff0000) >> 8 | (v & 0xff000000) >> 24;
 550:	0185179b          	sllw	a5,a0,0x18
 554:	0185571b          	srlw	a4,a0,0x18
 558:	8fd9                	or	a5,a5,a4
 55a:	0085171b          	sllw	a4,a0,0x8
 55e:	00ff06b7          	lui	a3,0xff0
 562:	8f75                	and	a4,a4,a3
 564:	8fd9                	or	a5,a5,a4
 566:	0085551b          	srlw	a0,a0,0x8
 56a:	6741                	lui	a4,0x10
 56c:	f0070713          	add	a4,a4,-256 # ff00 <base+0xeaf0>
 570:	8d79                	and	a0,a0,a4
 572:	8fc9                	or	a5,a5,a0
 574:	0007851b          	sext.w	a0,a5
 578:	a029                	j	582 <htonl+0x4e>
    }
    return endian == __LITTLE_ENDIAN ? byteswap32(h) : h;
 57a:	4d200713          	li	a4,1234
 57e:	fce789e3          	beq	a5,a4,550 <htonl+0x1c>
}
 582:	6422                	ld	s0,8(sp)
 584:	0141                	add	sp,sp,16
 586:	8082                	ret

0000000000000588 <ntohl>:

uint32_t
ntohl(uint32_t n)
{
 588:	1141                	add	sp,sp,-16
 58a:	e422                	sd	s0,8(sp)
 58c:	0800                	add	s0,sp,16
    if (!endian) {
 58e:	00001797          	auipc	a5,0x1
 592:	a727a783          	lw	a5,-1422(a5) # 1000 <endian>
 596:	ef85                	bnez	a5,5ce <ntohl+0x46>
        endian = byteorder();
 598:	4d200793          	li	a5,1234
 59c:	00001717          	auipc	a4,0x1
 5a0:	a6f72223          	sw	a5,-1436(a4) # 1000 <endian>
    return (v & 0x000000ff) << 24 | (v & 0x0000ff00) << 8 | (v & 0x00ff0000) >> 8 | (v & 0xff000000) >> 24;
 5a4:	0185179b          	sllw	a5,a0,0x18
 5a8:	0185571b          	srlw	a4,a0,0x18
 5ac:	8fd9                	or	a5,a5,a4
 5ae:	0085171b          	sllw	a4,a0,0x8
 5b2:	00ff06b7          	lui	a3,0xff0
 5b6:	8f75                	and	a4,a4,a3
 5b8:	8fd9                	or	a5,a5,a4
 5ba:	0085551b          	srlw	a0,a0,0x8
 5be:	6741                	lui	a4,0x10
 5c0:	f0070713          	add	a4,a4,-256 # ff00 <base+0xeaf0>
 5c4:	8d79                	and	a0,a0,a4
 5c6:	8fc9                	or	a5,a5,a0
 5c8:	0007851b          	sext.w	a0,a5
 5cc:	a029                	j	5d6 <ntohl+0x4e>
    }
    return endian == __LITTLE_ENDIAN ? byteswap32(n) : n;
 5ce:	4d200713          	li	a4,1234
 5d2:	fce789e3          	beq	a5,a4,5a4 <ntohl+0x1c>
}
 5d6:	6422                	ld	s0,8(sp)
 5d8:	0141                	add	sp,sp,16
 5da:	8082                	ret

00000000000005dc <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
 5dc:	1141                	add	sp,sp,-16
 5de:	e422                	sd	s0,8(sp)
 5e0:	0800                	add	s0,sp,16
 5e2:	872a                	mv	a4,a0
    int neg = 0;
    long val = 0;

    // gobble initial whitespace
    while (*s == ' ' || *s == '\t')
 5e4:	02000693          	li	a3,32
 5e8:	4525                	li	a0,9
 5ea:	a011                	j	5ee <strtol+0x12>
        s++;
 5ec:	0705                	add	a4,a4,1
    while (*s == ' ' || *s == '\t')
 5ee:	00074783          	lbu	a5,0(a4)
 5f2:	fed78de3          	beq	a5,a3,5ec <strtol+0x10>
 5f6:	fea78be3          	beq	a5,a0,5ec <strtol+0x10>

    // plus/minus sign
    if (*s == '+')
 5fa:	02b00693          	li	a3,43
 5fe:	02d78663          	beq	a5,a3,62a <strtol+0x4e>
        s++;
    else if (*s == '-')
 602:	02d00693          	li	a3,45
    int neg = 0;
 606:	4301                	li	t1,0
    else if (*s == '-')
 608:	02d78463          	beq	a5,a3,630 <strtol+0x54>
        s++, neg = 1;

    // hex or octal base prefix
    if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
 60c:	fef67793          	and	a5,a2,-17
 610:	eb89                	bnez	a5,622 <strtol+0x46>
 612:	00074683          	lbu	a3,0(a4)
 616:	03000793          	li	a5,48
 61a:	00f68e63          	beq	a3,a5,636 <strtol+0x5a>
        s += 2, base = 16;
    else if (base == 0 && s[0] == '0')
 61e:	e211                	bnez	a2,622 <strtol+0x46>
        s++, base = 8;
    else if (base == 0)
        base = 10;
 620:	4629                	li	a2,10
 622:	4501                	li	a0,0

    // digits
    while (1) {
        int dig;

        if (*s >= '0' && *s <= '9')
 624:	4825                	li	a6,9
            dig = *s - '0';
        else if (*s >= 'a' && *s <= 'z')
 626:	48e5                	li	a7,25
 628:	a825                	j	660 <strtol+0x84>
        s++;
 62a:	0705                	add	a4,a4,1
    int neg = 0;
 62c:	4301                	li	t1,0
 62e:	bff9                	j	60c <strtol+0x30>
        s++, neg = 1;
 630:	0705                	add	a4,a4,1
 632:	4305                	li	t1,1
 634:	bfe1                	j	60c <strtol+0x30>
    if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
 636:	00174683          	lbu	a3,1(a4)
 63a:	07800793          	li	a5,120
 63e:	00f68663          	beq	a3,a5,64a <strtol+0x6e>
    else if (base == 0 && s[0] == '0')
 642:	f265                	bnez	a2,622 <strtol+0x46>
        s++, base = 8;
 644:	0705                	add	a4,a4,1
 646:	4621                	li	a2,8
 648:	bfe9                	j	622 <strtol+0x46>
        s += 2, base = 16;
 64a:	0709                	add	a4,a4,2
 64c:	4641                	li	a2,16
 64e:	bfd1                	j	622 <strtol+0x46>
            dig = *s - '0';
 650:	fd07879b          	addw	a5,a5,-48
            dig = *s - 'a' + 10;
        else if (*s >= 'A' && *s <= 'Z')
            dig = *s - 'A' + 10;
        else
            break;
        if (dig >= base)
 654:	04c7d063          	bge	a5,a2,694 <strtol+0xb8>
            break;
        s++, val = (val * base) + dig;
 658:	0705                	add	a4,a4,1
 65a:	02a60533          	mul	a0,a2,a0
 65e:	953e                	add	a0,a0,a5
        if (*s >= '0' && *s <= '9')
 660:	00074783          	lbu	a5,0(a4)
 664:	fd07869b          	addw	a3,a5,-48
 668:	0ff6f693          	zext.b	a3,a3
 66c:	fed872e3          	bgeu	a6,a3,650 <strtol+0x74>
        else if (*s >= 'a' && *s <= 'z')
 670:	f9f7869b          	addw	a3,a5,-97
 674:	0ff6f693          	zext.b	a3,a3
 678:	00d8e563          	bltu	a7,a3,682 <strtol+0xa6>
            dig = *s - 'a' + 10;
 67c:	fa97879b          	addw	a5,a5,-87
 680:	bfd1                	j	654 <strtol+0x78>
        else if (*s >= 'A' && *s <= 'Z')
 682:	fbf7869b          	addw	a3,a5,-65
 686:	0ff6f693          	zext.b	a3,a3
 68a:	00d8e563          	bltu	a7,a3,694 <strtol+0xb8>
            dig = *s - 'A' + 10;
 68e:	fc97879b          	addw	a5,a5,-55
 692:	b7c9                	j	654 <strtol+0x78>
        // we don't properly detect overflow!
    }

    if (endptr)
 694:	c191                	beqz	a1,698 <strtol+0xbc>
        *endptr = (char *) s;
 696:	e198                	sd	a4,0(a1)
    return (neg ? -val : val);
 698:	00030463          	beqz	t1,6a0 <strtol+0xc4>
 69c:	40a00533          	neg	a0,a0
}
 6a0:	6422                	ld	s0,8(sp)
 6a2:	0141                	add	sp,sp,16
 6a4:	8082                	ret

00000000000006a6 <inet_pton>:
inet_pton (int family, const char *p, void *n) {
    char *sp, *ep;
    int idx;
    long ret;

    if (family != AF_INET) {
 6a6:	4785                	li	a5,1
 6a8:	08f51263          	bne	a0,a5,72c <inet_pton+0x86>
inet_pton (int family, const char *p, void *n) {
 6ac:	715d                	add	sp,sp,-80
 6ae:	e486                	sd	ra,72(sp)
 6b0:	e0a2                	sd	s0,64(sp)
 6b2:	fc26                	sd	s1,56(sp)
 6b4:	f84a                	sd	s2,48(sp)
 6b6:	f44e                	sd	s3,40(sp)
 6b8:	f052                	sd	s4,32(sp)
 6ba:	ec56                	sd	s5,24(sp)
 6bc:	e85a                	sd	s6,16(sp)
 6be:	0880                	add	s0,sp,80
 6c0:	892e                	mv	s2,a1
 6c2:	89b2                	mv	s3,a2
 6c4:	4481                	li	s1,0
        return -1;
    }
    sp = (char *)p;
    for (idx = 0; idx < 4; idx++) {
        ret = strtol(sp, &ep, 10);
        if (ret < 0 || ret > 255) {
 6c6:	0ff00a13          	li	s4,255
            return -1;
        }
        if (ep == sp) {
            return -1;
        }
        if ((idx == 3 && *ep != '\0') || (idx != 3 && *ep != '.')) {
 6ca:	4a8d                	li	s5,3
 6cc:	02e00b13          	li	s6,46
 6d0:	a815                	j	704 <inet_pton+0x5e>
 6d2:	0007c783          	lbu	a5,0(a5)
 6d6:	e3ad                	bnez	a5,738 <inet_pton+0x92>
            return -1;
        }
        ((uint8_t *)n)[idx] = ret;
 6d8:	2481                	sext.w	s1,s1
 6da:	99a6                	add	s3,s3,s1
 6dc:	00a98023          	sb	a0,0(s3)
        sp = ep + 1;
    }
    return 0;
 6e0:	4501                	li	a0,0
}
 6e2:	60a6                	ld	ra,72(sp)
 6e4:	6406                	ld	s0,64(sp)
 6e6:	74e2                	ld	s1,56(sp)
 6e8:	7942                	ld	s2,48(sp)
 6ea:	79a2                	ld	s3,40(sp)
 6ec:	7a02                	ld	s4,32(sp)
 6ee:	6ae2                	ld	s5,24(sp)
 6f0:	6b42                	ld	s6,16(sp)
 6f2:	6161                	add	sp,sp,80
 6f4:	8082                	ret
        ((uint8_t *)n)[idx] = ret;
 6f6:	00998733          	add	a4,s3,s1
 6fa:	00a70023          	sb	a0,0(a4)
        sp = ep + 1;
 6fe:	00178913          	add	s2,a5,1
    for (idx = 0; idx < 4; idx++) {
 702:	0485                	add	s1,s1,1
        ret = strtol(sp, &ep, 10);
 704:	4629                	li	a2,10
 706:	fb840593          	add	a1,s0,-72
 70a:	854a                	mv	a0,s2
 70c:	ed1ff0ef          	jal	5dc <strtol>
        if (ret < 0 || ret > 255) {
 710:	02aa6063          	bltu	s4,a0,730 <inet_pton+0x8a>
        if (ep == sp) {
 714:	fb843783          	ld	a5,-72(s0)
 718:	01278e63          	beq	a5,s2,734 <inet_pton+0x8e>
        if ((idx == 3 && *ep != '\0') || (idx != 3 && *ep != '.')) {
 71c:	fb548be3          	beq	s1,s5,6d2 <inet_pton+0x2c>
 720:	0007c703          	lbu	a4,0(a5)
 724:	fd6709e3          	beq	a4,s6,6f6 <inet_pton+0x50>
            return -1;
 728:	557d                	li	a0,-1
 72a:	bf65                	j	6e2 <inet_pton+0x3c>
        return -1;
 72c:	557d                	li	a0,-1
}
 72e:	8082                	ret
            return -1;
 730:	557d                	li	a0,-1
 732:	bf45                	j	6e2 <inet_pton+0x3c>
            return -1;
 734:	557d                	li	a0,-1
 736:	b775                	j	6e2 <inet_pton+0x3c>
            return -1;
 738:	557d                	li	a0,-1
 73a:	b765                	j	6e2 <inet_pton+0x3c>

000000000000073c <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 73c:	4885                	li	a7,1
 ecall
 73e:	00000073          	ecall
 ret
 742:	8082                	ret

0000000000000744 <exit>:
.global exit
exit:
 li a7, SYS_exit
 744:	4889                	li	a7,2
 ecall
 746:	00000073          	ecall
 ret
 74a:	8082                	ret

000000000000074c <wait>:
.global wait
wait:
 li a7, SYS_wait
 74c:	488d                	li	a7,3
 ecall
 74e:	00000073          	ecall
 ret
 752:	8082                	ret

0000000000000754 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 754:	4891                	li	a7,4
 ecall
 756:	00000073          	ecall
 ret
 75a:	8082                	ret

000000000000075c <read>:
.global read
read:
 li a7, SYS_read
 75c:	4895                	li	a7,5
 ecall
 75e:	00000073          	ecall
 ret
 762:	8082                	ret

0000000000000764 <write>:
.global write
write:
 li a7, SYS_write
 764:	48c1                	li	a7,16
 ecall
 766:	00000073          	ecall
 ret
 76a:	8082                	ret

000000000000076c <close>:
.global close
close:
 li a7, SYS_close
 76c:	48d5                	li	a7,21
 ecall
 76e:	00000073          	ecall
 ret
 772:	8082                	ret

0000000000000774 <kill>:
.global kill
kill:
 li a7, SYS_kill
 774:	4899                	li	a7,6
 ecall
 776:	00000073          	ecall
 ret
 77a:	8082                	ret

000000000000077c <exec>:
.global exec
exec:
 li a7, SYS_exec
 77c:	489d                	li	a7,7
 ecall
 77e:	00000073          	ecall
 ret
 782:	8082                	ret

0000000000000784 <open>:
.global open
open:
 li a7, SYS_open
 784:	48bd                	li	a7,15
 ecall
 786:	00000073          	ecall
 ret
 78a:	8082                	ret

000000000000078c <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 78c:	48c5                	li	a7,17
 ecall
 78e:	00000073          	ecall
 ret
 792:	8082                	ret

0000000000000794 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 794:	48c9                	li	a7,18
 ecall
 796:	00000073          	ecall
 ret
 79a:	8082                	ret

000000000000079c <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 79c:	48a1                	li	a7,8
 ecall
 79e:	00000073          	ecall
 ret
 7a2:	8082                	ret

00000000000007a4 <link>:
.global link
link:
 li a7, SYS_link
 7a4:	48cd                	li	a7,19
 ecall
 7a6:	00000073          	ecall
 ret
 7aa:	8082                	ret

00000000000007ac <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 7ac:	48d1                	li	a7,20
 ecall
 7ae:	00000073          	ecall
 ret
 7b2:	8082                	ret

00000000000007b4 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 7b4:	48a5                	li	a7,9
 ecall
 7b6:	00000073          	ecall
 ret
 7ba:	8082                	ret

00000000000007bc <dup>:
.global dup
dup:
 li a7, SYS_dup
 7bc:	48a9                	li	a7,10
 ecall
 7be:	00000073          	ecall
 ret
 7c2:	8082                	ret

00000000000007c4 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 7c4:	48ad                	li	a7,11
 ecall
 7c6:	00000073          	ecall
 ret
 7ca:	8082                	ret

00000000000007cc <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 7cc:	48b1                	li	a7,12
 ecall
 7ce:	00000073          	ecall
 ret
 7d2:	8082                	ret

00000000000007d4 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 7d4:	48b5                	li	a7,13
 ecall
 7d6:	00000073          	ecall
 ret
 7da:	8082                	ret

00000000000007dc <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 7dc:	48b9                	li	a7,14
 ecall
 7de:	00000073          	ecall
 ret
 7e2:	8082                	ret

00000000000007e4 <socket>:
.global socket
socket:
 li a7, SYS_socket
 7e4:	48d9                	li	a7,22
 ecall
 7e6:	00000073          	ecall
 ret
 7ea:	8082                	ret

00000000000007ec <bind>:
.global bind
bind:
 li a7, SYS_bind
 7ec:	48dd                	li	a7,23
 ecall
 7ee:	00000073          	ecall
 ret
 7f2:	8082                	ret

00000000000007f4 <recvfrom>:
.global recvfrom
recvfrom:
 li a7, SYS_recvfrom
 7f4:	48e1                	li	a7,24
 ecall
 7f6:	00000073          	ecall
 ret
 7fa:	8082                	ret

00000000000007fc <sendto>:
.global sendto
sendto:
 li a7, SYS_sendto
 7fc:	48e5                	li	a7,25
 ecall
 7fe:	00000073          	ecall
 ret
 802:	8082                	ret

0000000000000804 <connect>:
.global connect
connect:
 li a7, SYS_connect
 804:	48e9                	li	a7,26
 ecall
 806:	00000073          	ecall
 ret
 80a:	8082                	ret

000000000000080c <listen>:
.global listen
listen:
 li a7, SYS_listen
 80c:	48ed                	li	a7,27
 ecall
 80e:	00000073          	ecall
 ret
 812:	8082                	ret

0000000000000814 <accept>:
.global accept
accept:
 li a7, SYS_accept
 814:	48f1                	li	a7,28
 ecall
 816:	00000073          	ecall
 ret
 81a:	8082                	ret

000000000000081c <recv>:
.global recv
recv:
 li a7, SYS_recv
 81c:	48f5                	li	a7,29
 ecall
 81e:	00000073          	ecall
 ret
 822:	8082                	ret

0000000000000824 <send>:
.global send
send:
 li a7, SYS_send
 824:	48f9                	li	a7,30
 ecall
 826:	00000073          	ecall
 ret
 82a:	8082                	ret

000000000000082c <ioctl>:
.global ioctl
ioctl:
 li a7, SYS_ioctl
 82c:	48fd                	li	a7,31
 ecall
 82e:	00000073          	ecall
 ret
 832:	8082                	ret

0000000000000834 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 834:	1101                	add	sp,sp,-32
 836:	ec06                	sd	ra,24(sp)
 838:	e822                	sd	s0,16(sp)
 83a:	1000                	add	s0,sp,32
 83c:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 840:	4605                	li	a2,1
 842:	fef40593          	add	a1,s0,-17
 846:	f1fff0ef          	jal	764 <write>
}
 84a:	60e2                	ld	ra,24(sp)
 84c:	6442                	ld	s0,16(sp)
 84e:	6105                	add	sp,sp,32
 850:	8082                	ret

0000000000000852 <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
 852:	715d                	add	sp,sp,-80
 854:	e486                	sd	ra,72(sp)
 856:	e0a2                	sd	s0,64(sp)
 858:	fc26                	sd	s1,56(sp)
 85a:	f84a                	sd	s2,48(sp)
 85c:	f44e                	sd	s3,40(sp)
 85e:	0880                	add	s0,sp,80
 860:	84aa                	mv	s1,a0
  char buf[20];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 862:	c299                	beqz	a3,868 <printint+0x16>
 864:	0805c763          	bltz	a1,8f2 <printint+0xa0>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 868:	2581                	sext.w	a1,a1
  neg = 0;
 86a:	4881                	li	a7,0
 86c:	fb840693          	add	a3,s0,-72
  }

  i = 0;
 870:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 872:	2601                	sext.w	a2,a2
 874:	00000517          	auipc	a0,0x0
 878:	50c50513          	add	a0,a0,1292 # d80 <digits>
 87c:	883a                	mv	a6,a4
 87e:	2705                	addw	a4,a4,1
 880:	02c5f7bb          	remuw	a5,a1,a2
 884:	1782                	sll	a5,a5,0x20
 886:	9381                	srl	a5,a5,0x20
 888:	97aa                	add	a5,a5,a0
 88a:	0007c783          	lbu	a5,0(a5)
 88e:	00f68023          	sb	a5,0(a3) # ff0000 <base+0xfeebf0>
  }while((x /= base) != 0);
 892:	0005879b          	sext.w	a5,a1
 896:	02c5d5bb          	divuw	a1,a1,a2
 89a:	0685                	add	a3,a3,1
 89c:	fec7f0e3          	bgeu	a5,a2,87c <printint+0x2a>
  if(neg)
 8a0:	00088c63          	beqz	a7,8b8 <printint+0x66>
    buf[i++] = '-';
 8a4:	fd070793          	add	a5,a4,-48
 8a8:	00878733          	add	a4,a5,s0
 8ac:	02d00793          	li	a5,45
 8b0:	fef70423          	sb	a5,-24(a4)
 8b4:	0028071b          	addw	a4,a6,2

  while(--i >= 0)
 8b8:	02e05663          	blez	a4,8e4 <printint+0x92>
 8bc:	fb840793          	add	a5,s0,-72
 8c0:	00e78933          	add	s2,a5,a4
 8c4:	fff78993          	add	s3,a5,-1
 8c8:	99ba                	add	s3,s3,a4
 8ca:	377d                	addw	a4,a4,-1
 8cc:	1702                	sll	a4,a4,0x20
 8ce:	9301                	srl	a4,a4,0x20
 8d0:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 8d4:	fff94583          	lbu	a1,-1(s2)
 8d8:	8526                	mv	a0,s1
 8da:	f5bff0ef          	jal	834 <putc>
  while(--i >= 0)
 8de:	197d                	add	s2,s2,-1
 8e0:	ff391ae3          	bne	s2,s3,8d4 <printint+0x82>
}
 8e4:	60a6                	ld	ra,72(sp)
 8e6:	6406                	ld	s0,64(sp)
 8e8:	74e2                	ld	s1,56(sp)
 8ea:	7942                	ld	s2,48(sp)
 8ec:	79a2                	ld	s3,40(sp)
 8ee:	6161                	add	sp,sp,80
 8f0:	8082                	ret
    x = -xx;
 8f2:	40b005bb          	negw	a1,a1
    neg = 1;
 8f6:	4885                	li	a7,1
    x = -xx;
 8f8:	bf95                	j	86c <printint+0x1a>

00000000000008fa <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 8fa:	711d                	add	sp,sp,-96
 8fc:	ec86                	sd	ra,88(sp)
 8fe:	e8a2                	sd	s0,80(sp)
 900:	e4a6                	sd	s1,72(sp)
 902:	e0ca                	sd	s2,64(sp)
 904:	fc4e                	sd	s3,56(sp)
 906:	f852                	sd	s4,48(sp)
 908:	f456                	sd	s5,40(sp)
 90a:	f05a                	sd	s6,32(sp)
 90c:	ec5e                	sd	s7,24(sp)
 90e:	e862                	sd	s8,16(sp)
 910:	e466                	sd	s9,8(sp)
 912:	e06a                	sd	s10,0(sp)
 914:	1080                	add	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 916:	0005c903          	lbu	s2,0(a1)
 91a:	24090763          	beqz	s2,b68 <vprintf+0x26e>
 91e:	8b2a                	mv	s6,a0
 920:	8a2e                	mv	s4,a1
 922:	8bb2                	mv	s7,a2
  state = 0;
 924:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
 926:	4481                	li	s1,0
 928:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
 92a:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
 92e:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
 932:	06c00c93          	li	s9,108
 936:	a005                	j	956 <vprintf+0x5c>
        putc(fd, c0);
 938:	85ca                	mv	a1,s2
 93a:	855a                	mv	a0,s6
 93c:	ef9ff0ef          	jal	834 <putc>
 940:	a019                	j	946 <vprintf+0x4c>
    } else if(state == '%'){
 942:	03598263          	beq	s3,s5,966 <vprintf+0x6c>
  for(i = 0; fmt[i]; i++){
 946:	2485                	addw	s1,s1,1
 948:	8726                	mv	a4,s1
 94a:	009a07b3          	add	a5,s4,s1
 94e:	0007c903          	lbu	s2,0(a5)
 952:	20090b63          	beqz	s2,b68 <vprintf+0x26e>
    c0 = fmt[i] & 0xff;
 956:	0009079b          	sext.w	a5,s2
    if(state == 0){
 95a:	fe0994e3          	bnez	s3,942 <vprintf+0x48>
      if(c0 == '%'){
 95e:	fd579de3          	bne	a5,s5,938 <vprintf+0x3e>
        state = '%';
 962:	89be                	mv	s3,a5
 964:	b7cd                	j	946 <vprintf+0x4c>
      if(c0) c1 = fmt[i+1] & 0xff;
 966:	c7c9                	beqz	a5,9f0 <vprintf+0xf6>
 968:	00ea06b3          	add	a3,s4,a4
 96c:	0016c683          	lbu	a3,1(a3)
      c1 = c2 = 0;
 970:	8636                	mv	a2,a3
      if(c1) c2 = fmt[i+2] & 0xff;
 972:	c681                	beqz	a3,97a <vprintf+0x80>
 974:	9752                	add	a4,a4,s4
 976:	00274603          	lbu	a2,2(a4)
      if(c0 == 'd'){
 97a:	03878f63          	beq	a5,s8,9b8 <vprintf+0xbe>
      } else if(c0 == 'l' && c1 == 'd'){
 97e:	05978963          	beq	a5,s9,9d0 <vprintf+0xd6>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
 982:	07500713          	li	a4,117
 986:	0ee78363          	beq	a5,a4,a6c <vprintf+0x172>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
 98a:	07800713          	li	a4,120
 98e:	12e78563          	beq	a5,a4,ab8 <vprintf+0x1be>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
 992:	07000713          	li	a4,112
 996:	14e78a63          	beq	a5,a4,aea <vprintf+0x1f0>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 's'){
 99a:	07300713          	li	a4,115
 99e:	18e78863          	beq	a5,a4,b2e <vprintf+0x234>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
 9a2:	02500713          	li	a4,37
 9a6:	04e79563          	bne	a5,a4,9f0 <vprintf+0xf6>
        putc(fd, '%');
 9aa:	02500593          	li	a1,37
 9ae:	855a                	mv	a0,s6
 9b0:	e85ff0ef          	jal	834 <putc>
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
#endif
      state = 0;
 9b4:	4981                	li	s3,0
 9b6:	bf41                	j	946 <vprintf+0x4c>
        printint(fd, va_arg(ap, int), 10, 1);
 9b8:	008b8913          	add	s2,s7,8
 9bc:	4685                	li	a3,1
 9be:	4629                	li	a2,10
 9c0:	000ba583          	lw	a1,0(s7)
 9c4:	855a                	mv	a0,s6
 9c6:	e8dff0ef          	jal	852 <printint>
 9ca:	8bca                	mv	s7,s2
      state = 0;
 9cc:	4981                	li	s3,0
 9ce:	bfa5                	j	946 <vprintf+0x4c>
      } else if(c0 == 'l' && c1 == 'd'){
 9d0:	06400793          	li	a5,100
 9d4:	02f68963          	beq	a3,a5,a06 <vprintf+0x10c>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 9d8:	06c00793          	li	a5,108
 9dc:	04f68263          	beq	a3,a5,a20 <vprintf+0x126>
      } else if(c0 == 'l' && c1 == 'u'){
 9e0:	07500793          	li	a5,117
 9e4:	0af68063          	beq	a3,a5,a84 <vprintf+0x18a>
      } else if(c0 == 'l' && c1 == 'x'){
 9e8:	07800793          	li	a5,120
 9ec:	0ef68263          	beq	a3,a5,ad0 <vprintf+0x1d6>
        putc(fd, '%');
 9f0:	02500593          	li	a1,37
 9f4:	855a                	mv	a0,s6
 9f6:	e3fff0ef          	jal	834 <putc>
        putc(fd, c0);
 9fa:	85ca                	mv	a1,s2
 9fc:	855a                	mv	a0,s6
 9fe:	e37ff0ef          	jal	834 <putc>
      state = 0;
 a02:	4981                	li	s3,0
 a04:	b789                	j	946 <vprintf+0x4c>
        printint(fd, va_arg(ap, uint64), 10, 1);
 a06:	008b8913          	add	s2,s7,8
 a0a:	4685                	li	a3,1
 a0c:	4629                	li	a2,10
 a0e:	000bb583          	ld	a1,0(s7)
 a12:	855a                	mv	a0,s6
 a14:	e3fff0ef          	jal	852 <printint>
        i += 1;
 a18:	2485                	addw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 a1a:	8bca                	mv	s7,s2
      state = 0;
 a1c:	4981                	li	s3,0
        i += 1;
 a1e:	b725                	j	946 <vprintf+0x4c>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 a20:	06400793          	li	a5,100
 a24:	02f60763          	beq	a2,a5,a52 <vprintf+0x158>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 a28:	07500793          	li	a5,117
 a2c:	06f60963          	beq	a2,a5,a9e <vprintf+0x1a4>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 a30:	07800793          	li	a5,120
 a34:	faf61ee3          	bne	a2,a5,9f0 <vprintf+0xf6>
        printint(fd, va_arg(ap, uint64), 16, 0);
 a38:	008b8913          	add	s2,s7,8
 a3c:	4681                	li	a3,0
 a3e:	4641                	li	a2,16
 a40:	000bb583          	ld	a1,0(s7)
 a44:	855a                	mv	a0,s6
 a46:	e0dff0ef          	jal	852 <printint>
        i += 2;
 a4a:	2489                	addw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 a4c:	8bca                	mv	s7,s2
      state = 0;
 a4e:	4981                	li	s3,0
        i += 2;
 a50:	bddd                	j	946 <vprintf+0x4c>
        printint(fd, va_arg(ap, uint64), 10, 1);
 a52:	008b8913          	add	s2,s7,8
 a56:	4685                	li	a3,1
 a58:	4629                	li	a2,10
 a5a:	000bb583          	ld	a1,0(s7)
 a5e:	855a                	mv	a0,s6
 a60:	df3ff0ef          	jal	852 <printint>
        i += 2;
 a64:	2489                	addw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 a66:	8bca                	mv	s7,s2
      state = 0;
 a68:	4981                	li	s3,0
        i += 2;
 a6a:	bdf1                	j	946 <vprintf+0x4c>
        printint(fd, va_arg(ap, int), 10, 0);
 a6c:	008b8913          	add	s2,s7,8
 a70:	4681                	li	a3,0
 a72:	4629                	li	a2,10
 a74:	000ba583          	lw	a1,0(s7)
 a78:	855a                	mv	a0,s6
 a7a:	dd9ff0ef          	jal	852 <printint>
 a7e:	8bca                	mv	s7,s2
      state = 0;
 a80:	4981                	li	s3,0
 a82:	b5d1                	j	946 <vprintf+0x4c>
        printint(fd, va_arg(ap, uint64), 10, 0);
 a84:	008b8913          	add	s2,s7,8
 a88:	4681                	li	a3,0
 a8a:	4629                	li	a2,10
 a8c:	000bb583          	ld	a1,0(s7)
 a90:	855a                	mv	a0,s6
 a92:	dc1ff0ef          	jal	852 <printint>
        i += 1;
 a96:	2485                	addw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 a98:	8bca                	mv	s7,s2
      state = 0;
 a9a:	4981                	li	s3,0
        i += 1;
 a9c:	b56d                	j	946 <vprintf+0x4c>
        printint(fd, va_arg(ap, uint64), 10, 0);
 a9e:	008b8913          	add	s2,s7,8
 aa2:	4681                	li	a3,0
 aa4:	4629                	li	a2,10
 aa6:	000bb583          	ld	a1,0(s7)
 aaa:	855a                	mv	a0,s6
 aac:	da7ff0ef          	jal	852 <printint>
        i += 2;
 ab0:	2489                	addw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 ab2:	8bca                	mv	s7,s2
      state = 0;
 ab4:	4981                	li	s3,0
        i += 2;
 ab6:	bd41                	j	946 <vprintf+0x4c>
        printint(fd, va_arg(ap, int), 16, 0);
 ab8:	008b8913          	add	s2,s7,8
 abc:	4681                	li	a3,0
 abe:	4641                	li	a2,16
 ac0:	000ba583          	lw	a1,0(s7)
 ac4:	855a                	mv	a0,s6
 ac6:	d8dff0ef          	jal	852 <printint>
 aca:	8bca                	mv	s7,s2
      state = 0;
 acc:	4981                	li	s3,0
 ace:	bda5                	j	946 <vprintf+0x4c>
        printint(fd, va_arg(ap, uint64), 16, 0);
 ad0:	008b8913          	add	s2,s7,8
 ad4:	4681                	li	a3,0
 ad6:	4641                	li	a2,16
 ad8:	000bb583          	ld	a1,0(s7)
 adc:	855a                	mv	a0,s6
 ade:	d75ff0ef          	jal	852 <printint>
        i += 1;
 ae2:	2485                	addw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 ae4:	8bca                	mv	s7,s2
      state = 0;
 ae6:	4981                	li	s3,0
        i += 1;
 ae8:	bdb9                	j	946 <vprintf+0x4c>
        printptr(fd, va_arg(ap, uint64));
 aea:	008b8d13          	add	s10,s7,8
 aee:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 af2:	03000593          	li	a1,48
 af6:	855a                	mv	a0,s6
 af8:	d3dff0ef          	jal	834 <putc>
  putc(fd, 'x');
 afc:	07800593          	li	a1,120
 b00:	855a                	mv	a0,s6
 b02:	d33ff0ef          	jal	834 <putc>
 b06:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 b08:	00000b97          	auipc	s7,0x0
 b0c:	278b8b93          	add	s7,s7,632 # d80 <digits>
 b10:	03c9d793          	srl	a5,s3,0x3c
 b14:	97de                	add	a5,a5,s7
 b16:	0007c583          	lbu	a1,0(a5)
 b1a:	855a                	mv	a0,s6
 b1c:	d19ff0ef          	jal	834 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 b20:	0992                	sll	s3,s3,0x4
 b22:	397d                	addw	s2,s2,-1
 b24:	fe0916e3          	bnez	s2,b10 <vprintf+0x216>
        printptr(fd, va_arg(ap, uint64));
 b28:	8bea                	mv	s7,s10
      state = 0;
 b2a:	4981                	li	s3,0
 b2c:	bd29                	j	946 <vprintf+0x4c>
        if((s = va_arg(ap, char*)) == 0)
 b2e:	008b8993          	add	s3,s7,8
 b32:	000bb903          	ld	s2,0(s7)
 b36:	00090f63          	beqz	s2,b54 <vprintf+0x25a>
        for(; *s; s++)
 b3a:	00094583          	lbu	a1,0(s2)
 b3e:	c195                	beqz	a1,b62 <vprintf+0x268>
          putc(fd, *s);
 b40:	855a                	mv	a0,s6
 b42:	cf3ff0ef          	jal	834 <putc>
        for(; *s; s++)
 b46:	0905                	add	s2,s2,1
 b48:	00094583          	lbu	a1,0(s2)
 b4c:	f9f5                	bnez	a1,b40 <vprintf+0x246>
        if((s = va_arg(ap, char*)) == 0)
 b4e:	8bce                	mv	s7,s3
      state = 0;
 b50:	4981                	li	s3,0
 b52:	bbd5                	j	946 <vprintf+0x4c>
          s = "(null)";
 b54:	00000917          	auipc	s2,0x0
 b58:	22490913          	add	s2,s2,548 # d78 <malloc+0x116>
        for(; *s; s++)
 b5c:	02800593          	li	a1,40
 b60:	b7c5                	j	b40 <vprintf+0x246>
        if((s = va_arg(ap, char*)) == 0)
 b62:	8bce                	mv	s7,s3
      state = 0;
 b64:	4981                	li	s3,0
 b66:	b3c5                	j	946 <vprintf+0x4c>
    }
  }
}
 b68:	60e6                	ld	ra,88(sp)
 b6a:	6446                	ld	s0,80(sp)
 b6c:	64a6                	ld	s1,72(sp)
 b6e:	6906                	ld	s2,64(sp)
 b70:	79e2                	ld	s3,56(sp)
 b72:	7a42                	ld	s4,48(sp)
 b74:	7aa2                	ld	s5,40(sp)
 b76:	7b02                	ld	s6,32(sp)
 b78:	6be2                	ld	s7,24(sp)
 b7a:	6c42                	ld	s8,16(sp)
 b7c:	6ca2                	ld	s9,8(sp)
 b7e:	6d02                	ld	s10,0(sp)
 b80:	6125                	add	sp,sp,96
 b82:	8082                	ret

0000000000000b84 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 b84:	715d                	add	sp,sp,-80
 b86:	ec06                	sd	ra,24(sp)
 b88:	e822                	sd	s0,16(sp)
 b8a:	1000                	add	s0,sp,32
 b8c:	e010                	sd	a2,0(s0)
 b8e:	e414                	sd	a3,8(s0)
 b90:	e818                	sd	a4,16(s0)
 b92:	ec1c                	sd	a5,24(s0)
 b94:	03043023          	sd	a6,32(s0)
 b98:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 b9c:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 ba0:	8622                	mv	a2,s0
 ba2:	d59ff0ef          	jal	8fa <vprintf>
}
 ba6:	60e2                	ld	ra,24(sp)
 ba8:	6442                	ld	s0,16(sp)
 baa:	6161                	add	sp,sp,80
 bac:	8082                	ret

0000000000000bae <printf>:

void
printf(const char *fmt, ...)
{
 bae:	711d                	add	sp,sp,-96
 bb0:	ec06                	sd	ra,24(sp)
 bb2:	e822                	sd	s0,16(sp)
 bb4:	1000                	add	s0,sp,32
 bb6:	e40c                	sd	a1,8(s0)
 bb8:	e810                	sd	a2,16(s0)
 bba:	ec14                	sd	a3,24(s0)
 bbc:	f018                	sd	a4,32(s0)
 bbe:	f41c                	sd	a5,40(s0)
 bc0:	03043823          	sd	a6,48(s0)
 bc4:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 bc8:	00840613          	add	a2,s0,8
 bcc:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 bd0:	85aa                	mv	a1,a0
 bd2:	4505                	li	a0,1
 bd4:	d27ff0ef          	jal	8fa <vprintf>
}
 bd8:	60e2                	ld	ra,24(sp)
 bda:	6442                	ld	s0,16(sp)
 bdc:	6125                	add	sp,sp,96
 bde:	8082                	ret

0000000000000be0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 be0:	1141                	add	sp,sp,-16
 be2:	e422                	sd	s0,8(sp)
 be4:	0800                	add	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 be6:	ff050693          	add	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 bea:	00000797          	auipc	a5,0x0
 bee:	41e7b783          	ld	a5,1054(a5) # 1008 <freep>
 bf2:	a02d                	j	c1c <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 bf4:	4618                	lw	a4,8(a2)
 bf6:	9f2d                	addw	a4,a4,a1
 bf8:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 bfc:	6398                	ld	a4,0(a5)
 bfe:	6310                	ld	a2,0(a4)
 c00:	a83d                	j	c3e <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 c02:	ff852703          	lw	a4,-8(a0)
 c06:	9f31                	addw	a4,a4,a2
 c08:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 c0a:	ff053683          	ld	a3,-16(a0)
 c0e:	a091                	j	c52 <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 c10:	6398                	ld	a4,0(a5)
 c12:	00e7e463          	bltu	a5,a4,c1a <free+0x3a>
 c16:	00e6ea63          	bltu	a3,a4,c2a <free+0x4a>
{
 c1a:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 c1c:	fed7fae3          	bgeu	a5,a3,c10 <free+0x30>
 c20:	6398                	ld	a4,0(a5)
 c22:	00e6e463          	bltu	a3,a4,c2a <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 c26:	fee7eae3          	bltu	a5,a4,c1a <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 c2a:	ff852583          	lw	a1,-8(a0)
 c2e:	6390                	ld	a2,0(a5)
 c30:	02059813          	sll	a6,a1,0x20
 c34:	01c85713          	srl	a4,a6,0x1c
 c38:	9736                	add	a4,a4,a3
 c3a:	fae60de3          	beq	a2,a4,bf4 <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 c3e:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 c42:	4790                	lw	a2,8(a5)
 c44:	02061593          	sll	a1,a2,0x20
 c48:	01c5d713          	srl	a4,a1,0x1c
 c4c:	973e                	add	a4,a4,a5
 c4e:	fae68ae3          	beq	a3,a4,c02 <free+0x22>
    p->s.ptr = bp->s.ptr;
 c52:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 c54:	00000717          	auipc	a4,0x0
 c58:	3af73a23          	sd	a5,948(a4) # 1008 <freep>
}
 c5c:	6422                	ld	s0,8(sp)
 c5e:	0141                	add	sp,sp,16
 c60:	8082                	ret

0000000000000c62 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 c62:	7139                	add	sp,sp,-64
 c64:	fc06                	sd	ra,56(sp)
 c66:	f822                	sd	s0,48(sp)
 c68:	f426                	sd	s1,40(sp)
 c6a:	f04a                	sd	s2,32(sp)
 c6c:	ec4e                	sd	s3,24(sp)
 c6e:	e852                	sd	s4,16(sp)
 c70:	e456                	sd	s5,8(sp)
 c72:	e05a                	sd	s6,0(sp)
 c74:	0080                	add	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 c76:	02051493          	sll	s1,a0,0x20
 c7a:	9081                	srl	s1,s1,0x20
 c7c:	04bd                	add	s1,s1,15
 c7e:	8091                	srl	s1,s1,0x4
 c80:	0014899b          	addw	s3,s1,1
 c84:	0485                	add	s1,s1,1
  if((prevp = freep) == 0){
 c86:	00000517          	auipc	a0,0x0
 c8a:	38253503          	ld	a0,898(a0) # 1008 <freep>
 c8e:	c515                	beqz	a0,cba <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 c90:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 c92:	4798                	lw	a4,8(a5)
 c94:	02977f63          	bgeu	a4,s1,cd2 <malloc+0x70>
  if(nu < 4096)
 c98:	8a4e                	mv	s4,s3
 c9a:	0009871b          	sext.w	a4,s3
 c9e:	6685                	lui	a3,0x1
 ca0:	00d77363          	bgeu	a4,a3,ca6 <malloc+0x44>
 ca4:	6a05                	lui	s4,0x1
 ca6:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 caa:	004a1a1b          	sllw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 cae:	00000917          	auipc	s2,0x0
 cb2:	35a90913          	add	s2,s2,858 # 1008 <freep>
  if(p == (char*)-1)
 cb6:	5afd                	li	s5,-1
 cb8:	a885                	j	d28 <malloc+0xc6>
    base.s.ptr = freep = prevp = &base;
 cba:	00000797          	auipc	a5,0x0
 cbe:	75678793          	add	a5,a5,1878 # 1410 <base>
 cc2:	00000717          	auipc	a4,0x0
 cc6:	34f73323          	sd	a5,838(a4) # 1008 <freep>
 cca:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 ccc:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 cd0:	b7e1                	j	c98 <malloc+0x36>
      if(p->s.size == nunits)
 cd2:	02e48c63          	beq	s1,a4,d0a <malloc+0xa8>
        p->s.size -= nunits;
 cd6:	4137073b          	subw	a4,a4,s3
 cda:	c798                	sw	a4,8(a5)
        p += p->s.size;
 cdc:	02071693          	sll	a3,a4,0x20
 ce0:	01c6d713          	srl	a4,a3,0x1c
 ce4:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 ce6:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 cea:	00000717          	auipc	a4,0x0
 cee:	30a73f23          	sd	a0,798(a4) # 1008 <freep>
      return (void*)(p + 1);
 cf2:	01078513          	add	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 cf6:	70e2                	ld	ra,56(sp)
 cf8:	7442                	ld	s0,48(sp)
 cfa:	74a2                	ld	s1,40(sp)
 cfc:	7902                	ld	s2,32(sp)
 cfe:	69e2                	ld	s3,24(sp)
 d00:	6a42                	ld	s4,16(sp)
 d02:	6aa2                	ld	s5,8(sp)
 d04:	6b02                	ld	s6,0(sp)
 d06:	6121                	add	sp,sp,64
 d08:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 d0a:	6398                	ld	a4,0(a5)
 d0c:	e118                	sd	a4,0(a0)
 d0e:	bff1                	j	cea <malloc+0x88>
  hp->s.size = nu;
 d10:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 d14:	0541                	add	a0,a0,16
 d16:	ecbff0ef          	jal	be0 <free>
  return freep;
 d1a:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 d1e:	dd61                	beqz	a0,cf6 <malloc+0x94>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 d20:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 d22:	4798                	lw	a4,8(a5)
 d24:	fa9777e3          	bgeu	a4,s1,cd2 <malloc+0x70>
    if(p == freep)
 d28:	00093703          	ld	a4,0(s2)
 d2c:	853e                	mv	a0,a5
 d2e:	fef719e3          	bne	a4,a5,d20 <malloc+0xbe>
  p = sbrk(nu * sizeof(Header));
 d32:	8552                	mv	a0,s4
 d34:	a99ff0ef          	jal	7cc <sbrk>
  if(p == (char*)-1)
 d38:	fd551ce3          	bne	a0,s5,d10 <malloc+0xae>
        return 0;
 d3c:	4501                	li	a0,0
 d3e:	bf65                	j	cf6 <malloc+0x94>
