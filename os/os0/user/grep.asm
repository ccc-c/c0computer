
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
 13a:	25e000ef          	jal	398 <strchr>
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
 162:	4e6000ef          	jal	648 <write>
 166:	b7f1                	j	132 <grep+0x2c>
    if(m > 0){
 168:	03404563          	bgtz	s4,192 <grep+0x8c>
  while((n = read(fd, buf+m, sizeof(buf)-m-1)) > 0){
 16c:	414b863b          	subw	a2,s7,s4
 170:	014a85b3          	add	a1,s5,s4
 174:	855a                	mv	a0,s6
 176:	4ca000ef          	jal	640 <read>
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
 1a6:	308000ef          	jal	4ae <memmove>
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
 1fe:	46a000ef          	jal	668 <open>
 202:	84aa                	mv	s1,a0
 204:	04054063          	bltz	a0,244 <main+0x80>
    grep(pattern, fd);
 208:	85aa                	mv	a1,a0
 20a:	8552                	mv	a0,s4
 20c:	efbff0ef          	jal	106 <grep>
    close(fd);
 210:	8526                	mv	a0,s1
 212:	43e000ef          	jal	650 <close>
  for(i = 2; i < argc; i++){
 216:	0921                	add	s2,s2,8
 218:	ff3910e3          	bne	s2,s3,1f8 <main+0x34>
  exit(0);
 21c:	4501                	li	a0,0
 21e:	40a000ef          	jal	628 <exit>
    fprintf(2, "usage: grep pattern [file ...]\n");
 222:	00001597          	auipc	a1,0x1
 226:	a2e58593          	add	a1,a1,-1490 # c50 <malloc+0x104>
 22a:	4509                	li	a0,2
 22c:	043000ef          	jal	a6e <fprintf>
    exit(1);
 230:	4505                	li	a0,1
 232:	3f6000ef          	jal	628 <exit>
    grep(pattern, 0);
 236:	4581                	li	a1,0
 238:	8552                	mv	a0,s4
 23a:	ecdff0ef          	jal	106 <grep>
    exit(0);
 23e:	4501                	li	a0,0
 240:	3e8000ef          	jal	628 <exit>
      printf("grep: cannot open %s\n", argv[i]);
 244:	00093583          	ld	a1,0(s2)
 248:	00001517          	auipc	a0,0x1
 24c:	a2850513          	add	a0,a0,-1496 # c70 <malloc+0x124>
 250:	049000ef          	jal	a98 <printf>
      exit(1);
 254:	4505                	li	a0,1
 256:	3d2000ef          	jal	628 <exit>

000000000000025a <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start(int argc, char **argv)
{
 25a:	1141                	add	sp,sp,-16
 25c:	e406                	sd	ra,8(sp)
 25e:	e022                	sd	s0,0(sp)
 260:	0800                	add	s0,sp,16
  int r;
  extern int main(int argc, char **argv);
  r = main(argc, argv);
 262:	f63ff0ef          	jal	1c4 <main>
  exit(r);
 266:	3c2000ef          	jal	628 <exit>

000000000000026a <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
 26a:	1141                	add	sp,sp,-16
 26c:	e422                	sd	s0,8(sp)
 26e:	0800                	add	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 270:	87aa                	mv	a5,a0
 272:	0585                	add	a1,a1,1
 274:	0785                	add	a5,a5,1
 276:	fff5c703          	lbu	a4,-1(a1)
 27a:	fee78fa3          	sb	a4,-1(a5)
 27e:	fb75                	bnez	a4,272 <strcpy+0x8>
    ;
  return os;
}
 280:	6422                	ld	s0,8(sp)
 282:	0141                	add	sp,sp,16
 284:	8082                	ret

0000000000000286 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 286:	1141                	add	sp,sp,-16
 288:	e422                	sd	s0,8(sp)
 28a:	0800                	add	s0,sp,16
  while(*p && *p == *q)
 28c:	00054783          	lbu	a5,0(a0)
 290:	cb91                	beqz	a5,2a4 <strcmp+0x1e>
 292:	0005c703          	lbu	a4,0(a1)
 296:	00f71763          	bne	a4,a5,2a4 <strcmp+0x1e>
    p++, q++;
 29a:	0505                	add	a0,a0,1
 29c:	0585                	add	a1,a1,1
  while(*p && *p == *q)
 29e:	00054783          	lbu	a5,0(a0)
 2a2:	fbe5                	bnez	a5,292 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 2a4:	0005c503          	lbu	a0,0(a1)
}
 2a8:	40a7853b          	subw	a0,a5,a0
 2ac:	6422                	ld	s0,8(sp)
 2ae:	0141                	add	sp,sp,16
 2b0:	8082                	ret

00000000000002b2 <strncmp>:

int
strncmp(const char *p, const char *q, uint n)
{
 2b2:	1141                	add	sp,sp,-16
 2b4:	e422                	sd	s0,8(sp)
 2b6:	0800                	add	s0,sp,16
  while(n > 0 && *p && *p == *q) {
 2b8:	ce11                	beqz	a2,2d4 <strncmp+0x22>
 2ba:	00054783          	lbu	a5,0(a0)
 2be:	cf89                	beqz	a5,2d8 <strncmp+0x26>
 2c0:	0005c703          	lbu	a4,0(a1)
 2c4:	00f71a63          	bne	a4,a5,2d8 <strncmp+0x26>
    p++, q++, n--;
 2c8:	0505                	add	a0,a0,1
 2ca:	0585                	add	a1,a1,1
 2cc:	367d                	addw	a2,a2,-1
  while(n > 0 && *p && *p == *q) {
 2ce:	f675                	bnez	a2,2ba <strncmp+0x8>
  }
  if (n == 0)
    return 0;
 2d0:	4501                	li	a0,0
 2d2:	a801                	j	2e2 <strncmp+0x30>
 2d4:	4501                	li	a0,0
 2d6:	a031                	j	2e2 <strncmp+0x30>
  return (uchar)*p - (uchar)*q;
 2d8:	00054503          	lbu	a0,0(a0)
 2dc:	0005c783          	lbu	a5,0(a1)
 2e0:	9d1d                	subw	a0,a0,a5
}
 2e2:	6422                	ld	s0,8(sp)
 2e4:	0141                	add	sp,sp,16
 2e6:	8082                	ret

00000000000002e8 <strcat>:

char*
strcat(char *dst, const char *src)
{
 2e8:	1141                	add	sp,sp,-16
 2ea:	e422                	sd	s0,8(sp)
 2ec:	0800                	add	s0,sp,16
  char *p = dst;
  while(*p) p++;
 2ee:	00054783          	lbu	a5,0(a0)
 2f2:	c385                	beqz	a5,312 <strcat+0x2a>
  char *p = dst;
 2f4:	87aa                	mv	a5,a0
  while(*p) p++;
 2f6:	0785                	add	a5,a5,1
 2f8:	0007c703          	lbu	a4,0(a5)
 2fc:	ff6d                	bnez	a4,2f6 <strcat+0xe>
  while((*p++ = *src++) != 0);
 2fe:	0585                	add	a1,a1,1
 300:	0785                	add	a5,a5,1
 302:	fff5c703          	lbu	a4,-1(a1)
 306:	fee78fa3          	sb	a4,-1(a5)
 30a:	fb75                	bnez	a4,2fe <strcat+0x16>
  return dst;
}
 30c:	6422                	ld	s0,8(sp)
 30e:	0141                	add	sp,sp,16
 310:	8082                	ret
  char *p = dst;
 312:	87aa                	mv	a5,a0
 314:	b7ed                	j	2fe <strcat+0x16>

0000000000000316 <strncpy>:

char*
strncpy(char *dst, const char *src, int n)
{
 316:	1141                	add	sp,sp,-16
 318:	e422                	sd	s0,8(sp)
 31a:	0800                	add	s0,sp,16
  char *p = dst;
 31c:	87aa                	mv	a5,a0
  while(n > 0 && *src) {
 31e:	02c05463          	blez	a2,346 <strncpy+0x30>
 322:	0005c703          	lbu	a4,0(a1)
 326:	cb01                	beqz	a4,336 <strncpy+0x20>
    *p++ = *src++;
 328:	0585                	add	a1,a1,1
 32a:	0785                	add	a5,a5,1
 32c:	fee78fa3          	sb	a4,-1(a5)
    n--;
 330:	367d                	addw	a2,a2,-1
  while(n > 0 && *src) {
 332:	fa65                	bnez	a2,322 <strncpy+0xc>
 334:	a809                	j	346 <strncpy+0x30>
  }
  while(n > 0) {
 336:	1602                	sll	a2,a2,0x20
 338:	9201                	srl	a2,a2,0x20
 33a:	963e                	add	a2,a2,a5
    *p++ = 0;
 33c:	0785                	add	a5,a5,1
 33e:	fe078fa3          	sb	zero,-1(a5)
  while(n > 0) {
 342:	fec79de3          	bne	a5,a2,33c <strncpy+0x26>
    n--;
  }
  return dst;
}
 346:	6422                	ld	s0,8(sp)
 348:	0141                	add	sp,sp,16
 34a:	8082                	ret

000000000000034c <strlen>:

uint
strlen(const char *s)
{
 34c:	1141                	add	sp,sp,-16
 34e:	e422                	sd	s0,8(sp)
 350:	0800                	add	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 352:	00054783          	lbu	a5,0(a0)
 356:	cf91                	beqz	a5,372 <strlen+0x26>
 358:	0505                	add	a0,a0,1
 35a:	87aa                	mv	a5,a0
 35c:	86be                	mv	a3,a5
 35e:	0785                	add	a5,a5,1
 360:	fff7c703          	lbu	a4,-1(a5)
 364:	ff65                	bnez	a4,35c <strlen+0x10>
 366:	40a6853b          	subw	a0,a3,a0
 36a:	2505                	addw	a0,a0,1
    ;
  return n;
}
 36c:	6422                	ld	s0,8(sp)
 36e:	0141                	add	sp,sp,16
 370:	8082                	ret
  for(n = 0; s[n]; n++)
 372:	4501                	li	a0,0
 374:	bfe5                	j	36c <strlen+0x20>

0000000000000376 <memset>:

void*
memset(void *dst, int c, uint n)
{
 376:	1141                	add	sp,sp,-16
 378:	e422                	sd	s0,8(sp)
 37a:	0800                	add	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 37c:	ca19                	beqz	a2,392 <memset+0x1c>
 37e:	87aa                	mv	a5,a0
 380:	1602                	sll	a2,a2,0x20
 382:	9201                	srl	a2,a2,0x20
 384:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 388:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 38c:	0785                	add	a5,a5,1
 38e:	fee79de3          	bne	a5,a4,388 <memset+0x12>
  }
  return dst;
}
 392:	6422                	ld	s0,8(sp)
 394:	0141                	add	sp,sp,16
 396:	8082                	ret

0000000000000398 <strchr>:

char*
strchr(const char *s, char c)
{
 398:	1141                	add	sp,sp,-16
 39a:	e422                	sd	s0,8(sp)
 39c:	0800                	add	s0,sp,16
  for(; *s; s++)
 39e:	00054783          	lbu	a5,0(a0)
 3a2:	cb99                	beqz	a5,3b8 <strchr+0x20>
    if(*s == c)
 3a4:	00f58763          	beq	a1,a5,3b2 <strchr+0x1a>
  for(; *s; s++)
 3a8:	0505                	add	a0,a0,1
 3aa:	00054783          	lbu	a5,0(a0)
 3ae:	fbfd                	bnez	a5,3a4 <strchr+0xc>
      return (char*)s;
  return 0;
 3b0:	4501                	li	a0,0
}
 3b2:	6422                	ld	s0,8(sp)
 3b4:	0141                	add	sp,sp,16
 3b6:	8082                	ret
  return 0;
 3b8:	4501                	li	a0,0
 3ba:	bfe5                	j	3b2 <strchr+0x1a>

00000000000003bc <gets>:

char*
gets(char *buf, int max)
{
 3bc:	711d                	add	sp,sp,-96
 3be:	ec86                	sd	ra,88(sp)
 3c0:	e8a2                	sd	s0,80(sp)
 3c2:	e4a6                	sd	s1,72(sp)
 3c4:	e0ca                	sd	s2,64(sp)
 3c6:	fc4e                	sd	s3,56(sp)
 3c8:	f852                	sd	s4,48(sp)
 3ca:	f456                	sd	s5,40(sp)
 3cc:	f05a                	sd	s6,32(sp)
 3ce:	ec5e                	sd	s7,24(sp)
 3d0:	1080                	add	s0,sp,96
 3d2:	8baa                	mv	s7,a0
 3d4:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 3d6:	892a                	mv	s2,a0
 3d8:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 3da:	4aa9                	li	s5,10
 3dc:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 3de:	89a6                	mv	s3,s1
 3e0:	2485                	addw	s1,s1,1
 3e2:	0344d663          	bge	s1,s4,40e <gets+0x52>
    cc = read(0, &c, 1);
 3e6:	4605                	li	a2,1
 3e8:	faf40593          	add	a1,s0,-81
 3ec:	4501                	li	a0,0
 3ee:	252000ef          	jal	640 <read>
    if(cc < 1)
 3f2:	00a05e63          	blez	a0,40e <gets+0x52>
    buf[i++] = c;
 3f6:	faf44783          	lbu	a5,-81(s0)
 3fa:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 3fe:	01578763          	beq	a5,s5,40c <gets+0x50>
 402:	0905                	add	s2,s2,1
 404:	fd679de3          	bne	a5,s6,3de <gets+0x22>
    buf[i++] = c;
 408:	89a6                	mv	s3,s1
 40a:	a011                	j	40e <gets+0x52>
 40c:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 40e:	99de                	add	s3,s3,s7
 410:	00098023          	sb	zero,0(s3)
  return buf;
}
 414:	855e                	mv	a0,s7
 416:	60e6                	ld	ra,88(sp)
 418:	6446                	ld	s0,80(sp)
 41a:	64a6                	ld	s1,72(sp)
 41c:	6906                	ld	s2,64(sp)
 41e:	79e2                	ld	s3,56(sp)
 420:	7a42                	ld	s4,48(sp)
 422:	7aa2                	ld	s5,40(sp)
 424:	7b02                	ld	s6,32(sp)
 426:	6be2                	ld	s7,24(sp)
 428:	6125                	add	sp,sp,96
 42a:	8082                	ret

000000000000042c <stat>:

int
stat(const char *n, struct stat *st)
{
 42c:	1101                	add	sp,sp,-32
 42e:	ec06                	sd	ra,24(sp)
 430:	e822                	sd	s0,16(sp)
 432:	e04a                	sd	s2,0(sp)
 434:	1000                	add	s0,sp,32
 436:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 438:	4581                	li	a1,0
 43a:	22e000ef          	jal	668 <open>
  if(fd < 0)
 43e:	02054263          	bltz	a0,462 <stat+0x36>
 442:	e426                	sd	s1,8(sp)
 444:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 446:	85ca                	mv	a1,s2
 448:	238000ef          	jal	680 <fstat>
 44c:	892a                	mv	s2,a0
  close(fd);
 44e:	8526                	mv	a0,s1
 450:	200000ef          	jal	650 <close>
  return r;
 454:	64a2                	ld	s1,8(sp)
}
 456:	854a                	mv	a0,s2
 458:	60e2                	ld	ra,24(sp)
 45a:	6442                	ld	s0,16(sp)
 45c:	6902                	ld	s2,0(sp)
 45e:	6105                	add	sp,sp,32
 460:	8082                	ret
    return -1;
 462:	597d                	li	s2,-1
 464:	bfcd                	j	456 <stat+0x2a>

0000000000000466 <atoi>:

int
atoi(const char *s)
{
 466:	1141                	add	sp,sp,-16
 468:	e422                	sd	s0,8(sp)
 46a:	0800                	add	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 46c:	00054683          	lbu	a3,0(a0)
 470:	fd06879b          	addw	a5,a3,-48
 474:	0ff7f793          	zext.b	a5,a5
 478:	4625                	li	a2,9
 47a:	02f66863          	bltu	a2,a5,4aa <atoi+0x44>
 47e:	872a                	mv	a4,a0
  n = 0;
 480:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 482:	0705                	add	a4,a4,1
 484:	0025179b          	sllw	a5,a0,0x2
 488:	9fa9                	addw	a5,a5,a0
 48a:	0017979b          	sllw	a5,a5,0x1
 48e:	9fb5                	addw	a5,a5,a3
 490:	fd07851b          	addw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 494:	00074683          	lbu	a3,0(a4)
 498:	fd06879b          	addw	a5,a3,-48
 49c:	0ff7f793          	zext.b	a5,a5
 4a0:	fef671e3          	bgeu	a2,a5,482 <atoi+0x1c>
  return n;
}
 4a4:	6422                	ld	s0,8(sp)
 4a6:	0141                	add	sp,sp,16
 4a8:	8082                	ret
  n = 0;
 4aa:	4501                	li	a0,0
 4ac:	bfe5                	j	4a4 <atoi+0x3e>

00000000000004ae <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 4ae:	1141                	add	sp,sp,-16
 4b0:	e422                	sd	s0,8(sp)
 4b2:	0800                	add	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 4b4:	02b57463          	bgeu	a0,a1,4dc <memmove+0x2e>
    while(n-- > 0)
 4b8:	00c05f63          	blez	a2,4d6 <memmove+0x28>
 4bc:	1602                	sll	a2,a2,0x20
 4be:	9201                	srl	a2,a2,0x20
 4c0:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 4c4:	872a                	mv	a4,a0
      *dst++ = *src++;
 4c6:	0585                	add	a1,a1,1
 4c8:	0705                	add	a4,a4,1
 4ca:	fff5c683          	lbu	a3,-1(a1)
 4ce:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 4d2:	fef71ae3          	bne	a4,a5,4c6 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 4d6:	6422                	ld	s0,8(sp)
 4d8:	0141                	add	sp,sp,16
 4da:	8082                	ret
    dst += n;
 4dc:	00c50733          	add	a4,a0,a2
    src += n;
 4e0:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 4e2:	fec05ae3          	blez	a2,4d6 <memmove+0x28>
 4e6:	fff6079b          	addw	a5,a2,-1
 4ea:	1782                	sll	a5,a5,0x20
 4ec:	9381                	srl	a5,a5,0x20
 4ee:	fff7c793          	not	a5,a5
 4f2:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 4f4:	15fd                	add	a1,a1,-1
 4f6:	177d                	add	a4,a4,-1
 4f8:	0005c683          	lbu	a3,0(a1)
 4fc:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 500:	fee79ae3          	bne	a5,a4,4f4 <memmove+0x46>
 504:	bfc9                	j	4d6 <memmove+0x28>

0000000000000506 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 506:	1141                	add	sp,sp,-16
 508:	e422                	sd	s0,8(sp)
 50a:	0800                	add	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 50c:	ca05                	beqz	a2,53c <memcmp+0x36>
 50e:	fff6069b          	addw	a3,a2,-1
 512:	1682                	sll	a3,a3,0x20
 514:	9281                	srl	a3,a3,0x20
 516:	0685                	add	a3,a3,1
 518:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 51a:	00054783          	lbu	a5,0(a0)
 51e:	0005c703          	lbu	a4,0(a1)
 522:	00e79863          	bne	a5,a4,532 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 526:	0505                	add	a0,a0,1
    p2++;
 528:	0585                	add	a1,a1,1
  while (n-- > 0) {
 52a:	fed518e3          	bne	a0,a3,51a <memcmp+0x14>
  }
  return 0;
 52e:	4501                	li	a0,0
 530:	a019                	j	536 <memcmp+0x30>
      return *p1 - *p2;
 532:	40e7853b          	subw	a0,a5,a4
}
 536:	6422                	ld	s0,8(sp)
 538:	0141                	add	sp,sp,16
 53a:	8082                	ret
  return 0;
 53c:	4501                	li	a0,0
 53e:	bfe5                	j	536 <memcmp+0x30>

0000000000000540 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 540:	1141                	add	sp,sp,-16
 542:	e406                	sd	ra,8(sp)
 544:	e022                	sd	s0,0(sp)
 546:	0800                	add	s0,sp,16
  return memmove(dst, src, n);
 548:	f67ff0ef          	jal	4ae <memmove>
}
 54c:	60a2                	ld	ra,8(sp)
 54e:	6402                	ld	s0,0(sp)
 550:	0141                	add	sp,sp,16
 552:	8082                	ret

0000000000000554 <sbrk>:

char *
sbrk(int n) {
 554:	1141                	add	sp,sp,-16
 556:	e406                	sd	ra,8(sp)
 558:	e022                	sd	s0,0(sp)
 55a:	0800                	add	s0,sp,16
  return sys_sbrk(n, SBRK_EAGER);
 55c:	4585                	li	a1,1
 55e:	152000ef          	jal	6b0 <sys_sbrk>
}
 562:	60a2                	ld	ra,8(sp)
 564:	6402                	ld	s0,0(sp)
 566:	0141                	add	sp,sp,16
 568:	8082                	ret

000000000000056a <sbrklazy>:

char *
sbrklazy(int n) {
 56a:	1141                	add	sp,sp,-16
 56c:	e406                	sd	ra,8(sp)
 56e:	e022                	sd	s0,0(sp)
 570:	0800                	add	s0,sp,16
  return sys_sbrk(n, SBRK_LAZY);
 572:	4589                	li	a1,2
 574:	13c000ef          	jal	6b0 <sys_sbrk>
}
 578:	60a2                	ld	ra,8(sp)
 57a:	6402                	ld	s0,0(sp)
 57c:	0141                	add	sp,sp,16
 57e:	8082                	ret

0000000000000580 <htons>:

// Byte order conversion functions
unsigned short
htons(unsigned short hostshort)
{
 580:	1141                	add	sp,sp,-16
 582:	e422                	sd	s0,8(sp)
 584:	0800                	add	s0,sp,16
  return ((hostshort >> 8) & 0xff) | ((hostshort & 0xff) << 8);
 586:	0085179b          	sllw	a5,a0,0x8
 58a:	0085551b          	srlw	a0,a0,0x8
 58e:	8d5d                	or	a0,a0,a5
}
 590:	1542                	sll	a0,a0,0x30
 592:	9141                	srl	a0,a0,0x30
 594:	6422                	ld	s0,8(sp)
 596:	0141                	add	sp,sp,16
 598:	8082                	ret

000000000000059a <ntohs>:

unsigned short
ntohs(unsigned short netshort)
{
 59a:	1141                	add	sp,sp,-16
 59c:	e422                	sd	s0,8(sp)
 59e:	0800                	add	s0,sp,16
  return ((netshort >> 8) & 0xff) | ((netshort & 0xff) << 8);
 5a0:	0085179b          	sllw	a5,a0,0x8
 5a4:	0085551b          	srlw	a0,a0,0x8
 5a8:	8d5d                	or	a0,a0,a5
}
 5aa:	1542                	sll	a0,a0,0x30
 5ac:	9141                	srl	a0,a0,0x30
 5ae:	6422                	ld	s0,8(sp)
 5b0:	0141                	add	sp,sp,16
 5b2:	8082                	ret

00000000000005b4 <htonl>:

unsigned long
htonl(unsigned long hostlong)
{
 5b4:	1141                	add	sp,sp,-16
 5b6:	e422                	sd	s0,8(sp)
 5b8:	0800                	add	s0,sp,16
  return ((hostlong >> 24) & 0xff) |
 5ba:	0185579b          	srlw	a5,a0,0x18
         ((hostlong >> 8) & 0xff00) |
 5be:	00855713          	srl	a4,a0,0x8
 5c2:	66c1                	lui	a3,0x10
 5c4:	f0068693          	add	a3,a3,-256 # ff00 <base+0xeaf0>
 5c8:	8f75                	and	a4,a4,a3
  return ((hostlong >> 24) & 0xff) |
 5ca:	8fd9                	or	a5,a5,a4
         ((hostlong & 0xff00) << 8) |
 5cc:	00851713          	sll	a4,a0,0x8
 5d0:	00ff06b7          	lui	a3,0xff0
 5d4:	8f75                	and	a4,a4,a3
         ((hostlong >> 8) & 0xff00) |
 5d6:	8fd9                	or	a5,a5,a4
         ((hostlong & 0xff) << 24);
 5d8:	0562                	sll	a0,a0,0x18
 5da:	0ff00713          	li	a4,255
 5de:	0762                	sll	a4,a4,0x18
 5e0:	8d79                	and	a0,a0,a4
}
 5e2:	8d5d                	or	a0,a0,a5
 5e4:	6422                	ld	s0,8(sp)
 5e6:	0141                	add	sp,sp,16
 5e8:	8082                	ret

00000000000005ea <ntohl>:

unsigned long
ntohl(unsigned long netlong)
{
 5ea:	1141                	add	sp,sp,-16
 5ec:	e422                	sd	s0,8(sp)
 5ee:	0800                	add	s0,sp,16
  return ((netlong >> 24) & 0xff) |
 5f0:	0185579b          	srlw	a5,a0,0x18
         ((netlong >> 8) & 0xff00) |
 5f4:	00855713          	srl	a4,a0,0x8
 5f8:	66c1                	lui	a3,0x10
 5fa:	f0068693          	add	a3,a3,-256 # ff00 <base+0xeaf0>
 5fe:	8f75                	and	a4,a4,a3
  return ((netlong >> 24) & 0xff) |
 600:	8fd9                	or	a5,a5,a4
         ((netlong & 0xff00) << 8) |
 602:	00851713          	sll	a4,a0,0x8
 606:	00ff06b7          	lui	a3,0xff0
 60a:	8f75                	and	a4,a4,a3
         ((netlong >> 8) & 0xff00) |
 60c:	8fd9                	or	a5,a5,a4
         ((netlong & 0xff) << 24);
 60e:	0562                	sll	a0,a0,0x18
 610:	0ff00713          	li	a4,255
 614:	0762                	sll	a4,a4,0x18
 616:	8d79                	and	a0,a0,a4
}
 618:	8d5d                	or	a0,a0,a5
 61a:	6422                	ld	s0,8(sp)
 61c:	0141                	add	sp,sp,16
 61e:	8082                	ret

0000000000000620 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 620:	4885                	li	a7,1
 ecall
 622:	00000073          	ecall
 ret
 626:	8082                	ret

0000000000000628 <exit>:
.global exit
exit:
 li a7, SYS_exit
 628:	4889                	li	a7,2
 ecall
 62a:	00000073          	ecall
 ret
 62e:	8082                	ret

0000000000000630 <wait>:
.global wait
wait:
 li a7, SYS_wait
 630:	488d                	li	a7,3
 ecall
 632:	00000073          	ecall
 ret
 636:	8082                	ret

0000000000000638 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 638:	4891                	li	a7,4
 ecall
 63a:	00000073          	ecall
 ret
 63e:	8082                	ret

0000000000000640 <read>:
.global read
read:
 li a7, SYS_read
 640:	4895                	li	a7,5
 ecall
 642:	00000073          	ecall
 ret
 646:	8082                	ret

0000000000000648 <write>:
.global write
write:
 li a7, SYS_write
 648:	48c1                	li	a7,16
 ecall
 64a:	00000073          	ecall
 ret
 64e:	8082                	ret

0000000000000650 <close>:
.global close
close:
 li a7, SYS_close
 650:	48d5                	li	a7,21
 ecall
 652:	00000073          	ecall
 ret
 656:	8082                	ret

0000000000000658 <kill>:
.global kill
kill:
 li a7, SYS_kill
 658:	4899                	li	a7,6
 ecall
 65a:	00000073          	ecall
 ret
 65e:	8082                	ret

0000000000000660 <exec>:
.global exec
exec:
 li a7, SYS_exec
 660:	489d                	li	a7,7
 ecall
 662:	00000073          	ecall
 ret
 666:	8082                	ret

0000000000000668 <open>:
.global open
open:
 li a7, SYS_open
 668:	48bd                	li	a7,15
 ecall
 66a:	00000073          	ecall
 ret
 66e:	8082                	ret

0000000000000670 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 670:	48c5                	li	a7,17
 ecall
 672:	00000073          	ecall
 ret
 676:	8082                	ret

0000000000000678 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 678:	48c9                	li	a7,18
 ecall
 67a:	00000073          	ecall
 ret
 67e:	8082                	ret

0000000000000680 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 680:	48a1                	li	a7,8
 ecall
 682:	00000073          	ecall
 ret
 686:	8082                	ret

0000000000000688 <link>:
.global link
link:
 li a7, SYS_link
 688:	48cd                	li	a7,19
 ecall
 68a:	00000073          	ecall
 ret
 68e:	8082                	ret

0000000000000690 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 690:	48d1                	li	a7,20
 ecall
 692:	00000073          	ecall
 ret
 696:	8082                	ret

0000000000000698 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 698:	48a5                	li	a7,9
 ecall
 69a:	00000073          	ecall
 ret
 69e:	8082                	ret

00000000000006a0 <dup>:
.global dup
dup:
 li a7, SYS_dup
 6a0:	48a9                	li	a7,10
 ecall
 6a2:	00000073          	ecall
 ret
 6a6:	8082                	ret

00000000000006a8 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 6a8:	48ad                	li	a7,11
 ecall
 6aa:	00000073          	ecall
 ret
 6ae:	8082                	ret

00000000000006b0 <sys_sbrk>:
.global sys_sbrk
sys_sbrk:
 li a7, SYS_sbrk
 6b0:	48b1                	li	a7,12
 ecall
 6b2:	00000073          	ecall
 ret
 6b6:	8082                	ret

00000000000006b8 <pause>:
.global pause
pause:
 li a7, SYS_pause
 6b8:	48b5                	li	a7,13
 ecall
 6ba:	00000073          	ecall
 ret
 6be:	8082                	ret

00000000000006c0 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 6c0:	48b9                	li	a7,14
 ecall
 6c2:	00000073          	ecall
 ret
 6c6:	8082                	ret

00000000000006c8 <socket>:
.global socket
socket:
 li a7, SYS_socket
 6c8:	48d9                	li	a7,22
 ecall
 6ca:	00000073          	ecall
 ret
 6ce:	8082                	ret

00000000000006d0 <bind>:
.global bind
bind:
 li a7, SYS_bind
 6d0:	48dd                	li	a7,23
 ecall
 6d2:	00000073          	ecall
 ret
 6d6:	8082                	ret

00000000000006d8 <listen>:
.global listen
listen:
 li a7, SYS_listen
 6d8:	48e1                	li	a7,24
 ecall
 6da:	00000073          	ecall
 ret
 6de:	8082                	ret

00000000000006e0 <accept>:
.global accept
accept:
 li a7, SYS_accept
 6e0:	48e5                	li	a7,25
 ecall
 6e2:	00000073          	ecall
 ret
 6e6:	8082                	ret

00000000000006e8 <connect>:
.global connect
connect:
 li a7, SYS_connect
 6e8:	48e9                	li	a7,26
 ecall
 6ea:	00000073          	ecall
 ret
 6ee:	8082                	ret

00000000000006f0 <send>:
.global send
send:
 li a7, SYS_send
 6f0:	48ed                	li	a7,27
 ecall
 6f2:	00000073          	ecall
 ret
 6f6:	8082                	ret

00000000000006f8 <recv>:
.global recv
recv:
 li a7, SYS_recv
 6f8:	48f1                	li	a7,28
 ecall
 6fa:	00000073          	ecall
 ret
 6fe:	8082                	ret

0000000000000700 <sendto>:
.global sendto
sendto:
 li a7, SYS_sendto
 700:	48f5                	li	a7,29
 ecall
 702:	00000073          	ecall
 ret
 706:	8082                	ret

0000000000000708 <recvfrom>:
.global recvfrom
recvfrom:
 li a7, SYS_recvfrom
 708:	48f9                	li	a7,30
 ecall
 70a:	00000073          	ecall
 ret
 70e:	8082                	ret

0000000000000710 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 710:	1101                	add	sp,sp,-32
 712:	ec06                	sd	ra,24(sp)
 714:	e822                	sd	s0,16(sp)
 716:	1000                	add	s0,sp,32
 718:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 71c:	4605                	li	a2,1
 71e:	fef40593          	add	a1,s0,-17
 722:	f27ff0ef          	jal	648 <write>
}
 726:	60e2                	ld	ra,24(sp)
 728:	6442                	ld	s0,16(sp)
 72a:	6105                	add	sp,sp,32
 72c:	8082                	ret

000000000000072e <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
 72e:	715d                	add	sp,sp,-80
 730:	e486                	sd	ra,72(sp)
 732:	e0a2                	sd	s0,64(sp)
 734:	f84a                	sd	s2,48(sp)
 736:	0880                	add	s0,sp,80
 738:	892a                	mv	s2,a0
  char buf[20];
  int i, neg;
  unsigned long long x;

  neg = 0;
  if(sgn && xx < 0){
 73a:	c299                	beqz	a3,740 <printint+0x12>
 73c:	0805c363          	bltz	a1,7c2 <printint+0x94>
  neg = 0;
 740:	4881                	li	a7,0
 742:	fb840693          	add	a3,s0,-72
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
 746:	4781                	li	a5,0
  do{
    buf[i++] = digits[x % base];
 748:	00000517          	auipc	a0,0x0
 74c:	54850513          	add	a0,a0,1352 # c90 <digits>
 750:	883e                	mv	a6,a5
 752:	2785                	addw	a5,a5,1
 754:	02c5f733          	remu	a4,a1,a2
 758:	972a                	add	a4,a4,a0
 75a:	00074703          	lbu	a4,0(a4)
 75e:	00e68023          	sb	a4,0(a3) # ff0000 <base+0xfeebf0>
  }while((x /= base) != 0);
 762:	872e                	mv	a4,a1
 764:	02c5d5b3          	divu	a1,a1,a2
 768:	0685                	add	a3,a3,1
 76a:	fec773e3          	bgeu	a4,a2,750 <printint+0x22>
  if(neg)
 76e:	00088b63          	beqz	a7,784 <printint+0x56>
    buf[i++] = '-';
 772:	fd078793          	add	a5,a5,-48
 776:	97a2                	add	a5,a5,s0
 778:	02d00713          	li	a4,45
 77c:	fee78423          	sb	a4,-24(a5)
 780:	0028079b          	addw	a5,a6,2

  while(--i >= 0)
 784:	02f05a63          	blez	a5,7b8 <printint+0x8a>
 788:	fc26                	sd	s1,56(sp)
 78a:	f44e                	sd	s3,40(sp)
 78c:	fb840713          	add	a4,s0,-72
 790:	00f704b3          	add	s1,a4,a5
 794:	fff70993          	add	s3,a4,-1
 798:	99be                	add	s3,s3,a5
 79a:	37fd                	addw	a5,a5,-1
 79c:	1782                	sll	a5,a5,0x20
 79e:	9381                	srl	a5,a5,0x20
 7a0:	40f989b3          	sub	s3,s3,a5
    putc(fd, buf[i]);
 7a4:	fff4c583          	lbu	a1,-1(s1)
 7a8:	854a                	mv	a0,s2
 7aa:	f67ff0ef          	jal	710 <putc>
  while(--i >= 0)
 7ae:	14fd                	add	s1,s1,-1
 7b0:	ff349ae3          	bne	s1,s3,7a4 <printint+0x76>
 7b4:	74e2                	ld	s1,56(sp)
 7b6:	79a2                	ld	s3,40(sp)
}
 7b8:	60a6                	ld	ra,72(sp)
 7ba:	6406                	ld	s0,64(sp)
 7bc:	7942                	ld	s2,48(sp)
 7be:	6161                	add	sp,sp,80
 7c0:	8082                	ret
    x = -xx;
 7c2:	40b005b3          	neg	a1,a1
    neg = 1;
 7c6:	4885                	li	a7,1
    x = -xx;
 7c8:	bfad                	j	742 <printint+0x14>

00000000000007ca <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %c, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 7ca:	711d                	add	sp,sp,-96
 7cc:	ec86                	sd	ra,88(sp)
 7ce:	e8a2                	sd	s0,80(sp)
 7d0:	e0ca                	sd	s2,64(sp)
 7d2:	1080                	add	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 7d4:	0005c903          	lbu	s2,0(a1)
 7d8:	28090663          	beqz	s2,a64 <vprintf+0x29a>
 7dc:	e4a6                	sd	s1,72(sp)
 7de:	fc4e                	sd	s3,56(sp)
 7e0:	f852                	sd	s4,48(sp)
 7e2:	f456                	sd	s5,40(sp)
 7e4:	f05a                	sd	s6,32(sp)
 7e6:	ec5e                	sd	s7,24(sp)
 7e8:	e862                	sd	s8,16(sp)
 7ea:	e466                	sd	s9,8(sp)
 7ec:	8b2a                	mv	s6,a0
 7ee:	8a2e                	mv	s4,a1
 7f0:	8bb2                	mv	s7,a2
  state = 0;
 7f2:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
 7f4:	4481                	li	s1,0
 7f6:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
 7f8:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
 7fc:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
 800:	06c00c93          	li	s9,108
 804:	a005                	j	824 <vprintf+0x5a>
        putc(fd, c0);
 806:	85ca                	mv	a1,s2
 808:	855a                	mv	a0,s6
 80a:	f07ff0ef          	jal	710 <putc>
 80e:	a019                	j	814 <vprintf+0x4a>
    } else if(state == '%'){
 810:	03598263          	beq	s3,s5,834 <vprintf+0x6a>
  for(i = 0; fmt[i]; i++){
 814:	2485                	addw	s1,s1,1
 816:	8726                	mv	a4,s1
 818:	009a07b3          	add	a5,s4,s1
 81c:	0007c903          	lbu	s2,0(a5)
 820:	22090a63          	beqz	s2,a54 <vprintf+0x28a>
    c0 = fmt[i] & 0xff;
 824:	0009079b          	sext.w	a5,s2
    if(state == 0){
 828:	fe0994e3          	bnez	s3,810 <vprintf+0x46>
      if(c0 == '%'){
 82c:	fd579de3          	bne	a5,s5,806 <vprintf+0x3c>
        state = '%';
 830:	89be                	mv	s3,a5
 832:	b7cd                	j	814 <vprintf+0x4a>
      if(c0) c1 = fmt[i+1] & 0xff;
 834:	00ea06b3          	add	a3,s4,a4
 838:	0016c683          	lbu	a3,1(a3)
      c1 = c2 = 0;
 83c:	8636                	mv	a2,a3
      if(c1) c2 = fmt[i+2] & 0xff;
 83e:	c681                	beqz	a3,846 <vprintf+0x7c>
 840:	9752                	add	a4,a4,s4
 842:	00274603          	lbu	a2,2(a4)
      if(c0 == 'd'){
 846:	05878363          	beq	a5,s8,88c <vprintf+0xc2>
      } else if(c0 == 'l' && c1 == 'd'){
 84a:	05978d63          	beq	a5,s9,8a4 <vprintf+0xda>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
 84e:	07500713          	li	a4,117
 852:	0ee78763          	beq	a5,a4,940 <vprintf+0x176>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
 856:	07800713          	li	a4,120
 85a:	12e78963          	beq	a5,a4,98c <vprintf+0x1c2>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
 85e:	07000713          	li	a4,112
 862:	14e78e63          	beq	a5,a4,9be <vprintf+0x1f4>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 'c'){
 866:	06300713          	li	a4,99
 86a:	18e78e63          	beq	a5,a4,a06 <vprintf+0x23c>
        putc(fd, va_arg(ap, uint32));
      } else if(c0 == 's'){
 86e:	07300713          	li	a4,115
 872:	1ae78463          	beq	a5,a4,a1a <vprintf+0x250>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
 876:	02500713          	li	a4,37
 87a:	04e79563          	bne	a5,a4,8c4 <vprintf+0xfa>
        putc(fd, '%');
 87e:	02500593          	li	a1,37
 882:	855a                	mv	a0,s6
 884:	e8dff0ef          	jal	710 <putc>
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c0);
      }

      state = 0;
 888:	4981                	li	s3,0
 88a:	b769                	j	814 <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 1);
 88c:	008b8913          	add	s2,s7,8
 890:	4685                	li	a3,1
 892:	4629                	li	a2,10
 894:	000ba583          	lw	a1,0(s7)
 898:	855a                	mv	a0,s6
 89a:	e95ff0ef          	jal	72e <printint>
 89e:	8bca                	mv	s7,s2
      state = 0;
 8a0:	4981                	li	s3,0
 8a2:	bf8d                	j	814 <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'd'){
 8a4:	06400793          	li	a5,100
 8a8:	02f68963          	beq	a3,a5,8da <vprintf+0x110>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 8ac:	06c00793          	li	a5,108
 8b0:	04f68263          	beq	a3,a5,8f4 <vprintf+0x12a>
      } else if(c0 == 'l' && c1 == 'u'){
 8b4:	07500793          	li	a5,117
 8b8:	0af68063          	beq	a3,a5,958 <vprintf+0x18e>
      } else if(c0 == 'l' && c1 == 'x'){
 8bc:	07800793          	li	a5,120
 8c0:	0ef68263          	beq	a3,a5,9a4 <vprintf+0x1da>
        putc(fd, '%');
 8c4:	02500593          	li	a1,37
 8c8:	855a                	mv	a0,s6
 8ca:	e47ff0ef          	jal	710 <putc>
        putc(fd, c0);
 8ce:	85ca                	mv	a1,s2
 8d0:	855a                	mv	a0,s6
 8d2:	e3fff0ef          	jal	710 <putc>
      state = 0;
 8d6:	4981                	li	s3,0
 8d8:	bf35                	j	814 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 8da:	008b8913          	add	s2,s7,8
 8de:	4685                	li	a3,1
 8e0:	4629                	li	a2,10
 8e2:	000bb583          	ld	a1,0(s7)
 8e6:	855a                	mv	a0,s6
 8e8:	e47ff0ef          	jal	72e <printint>
        i += 1;
 8ec:	2485                	addw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 8ee:	8bca                	mv	s7,s2
      state = 0;
 8f0:	4981                	li	s3,0
        i += 1;
 8f2:	b70d                	j	814 <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 8f4:	06400793          	li	a5,100
 8f8:	02f60763          	beq	a2,a5,926 <vprintf+0x15c>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 8fc:	07500793          	li	a5,117
 900:	06f60963          	beq	a2,a5,972 <vprintf+0x1a8>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 904:	07800793          	li	a5,120
 908:	faf61ee3          	bne	a2,a5,8c4 <vprintf+0xfa>
        printint(fd, va_arg(ap, uint64), 16, 0);
 90c:	008b8913          	add	s2,s7,8
 910:	4681                	li	a3,0
 912:	4641                	li	a2,16
 914:	000bb583          	ld	a1,0(s7)
 918:	855a                	mv	a0,s6
 91a:	e15ff0ef          	jal	72e <printint>
        i += 2;
 91e:	2489                	addw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 920:	8bca                	mv	s7,s2
      state = 0;
 922:	4981                	li	s3,0
        i += 2;
 924:	bdc5                	j	814 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 926:	008b8913          	add	s2,s7,8
 92a:	4685                	li	a3,1
 92c:	4629                	li	a2,10
 92e:	000bb583          	ld	a1,0(s7)
 932:	855a                	mv	a0,s6
 934:	dfbff0ef          	jal	72e <printint>
        i += 2;
 938:	2489                	addw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 93a:	8bca                	mv	s7,s2
      state = 0;
 93c:	4981                	li	s3,0
        i += 2;
 93e:	bdd9                	j	814 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint32), 10, 0);
 940:	008b8913          	add	s2,s7,8
 944:	4681                	li	a3,0
 946:	4629                	li	a2,10
 948:	000be583          	lwu	a1,0(s7)
 94c:	855a                	mv	a0,s6
 94e:	de1ff0ef          	jal	72e <printint>
 952:	8bca                	mv	s7,s2
      state = 0;
 954:	4981                	li	s3,0
 956:	bd7d                	j	814 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 958:	008b8913          	add	s2,s7,8
 95c:	4681                	li	a3,0
 95e:	4629                	li	a2,10
 960:	000bb583          	ld	a1,0(s7)
 964:	855a                	mv	a0,s6
 966:	dc9ff0ef          	jal	72e <printint>
        i += 1;
 96a:	2485                	addw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 96c:	8bca                	mv	s7,s2
      state = 0;
 96e:	4981                	li	s3,0
        i += 1;
 970:	b555                	j	814 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 972:	008b8913          	add	s2,s7,8
 976:	4681                	li	a3,0
 978:	4629                	li	a2,10
 97a:	000bb583          	ld	a1,0(s7)
 97e:	855a                	mv	a0,s6
 980:	dafff0ef          	jal	72e <printint>
        i += 2;
 984:	2489                	addw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 986:	8bca                	mv	s7,s2
      state = 0;
 988:	4981                	li	s3,0
        i += 2;
 98a:	b569                	j	814 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint32), 16, 0);
 98c:	008b8913          	add	s2,s7,8
 990:	4681                	li	a3,0
 992:	4641                	li	a2,16
 994:	000be583          	lwu	a1,0(s7)
 998:	855a                	mv	a0,s6
 99a:	d95ff0ef          	jal	72e <printint>
 99e:	8bca                	mv	s7,s2
      state = 0;
 9a0:	4981                	li	s3,0
 9a2:	bd8d                	j	814 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 16, 0);
 9a4:	008b8913          	add	s2,s7,8
 9a8:	4681                	li	a3,0
 9aa:	4641                	li	a2,16
 9ac:	000bb583          	ld	a1,0(s7)
 9b0:	855a                	mv	a0,s6
 9b2:	d7dff0ef          	jal	72e <printint>
        i += 1;
 9b6:	2485                	addw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 9b8:	8bca                	mv	s7,s2
      state = 0;
 9ba:	4981                	li	s3,0
        i += 1;
 9bc:	bda1                	j	814 <vprintf+0x4a>
 9be:	e06a                	sd	s10,0(sp)
        printptr(fd, va_arg(ap, uint64));
 9c0:	008b8d13          	add	s10,s7,8
 9c4:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 9c8:	03000593          	li	a1,48
 9cc:	855a                	mv	a0,s6
 9ce:	d43ff0ef          	jal	710 <putc>
  putc(fd, 'x');
 9d2:	07800593          	li	a1,120
 9d6:	855a                	mv	a0,s6
 9d8:	d39ff0ef          	jal	710 <putc>
 9dc:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 9de:	00000b97          	auipc	s7,0x0
 9e2:	2b2b8b93          	add	s7,s7,690 # c90 <digits>
 9e6:	03c9d793          	srl	a5,s3,0x3c
 9ea:	97de                	add	a5,a5,s7
 9ec:	0007c583          	lbu	a1,0(a5)
 9f0:	855a                	mv	a0,s6
 9f2:	d1fff0ef          	jal	710 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 9f6:	0992                	sll	s3,s3,0x4
 9f8:	397d                	addw	s2,s2,-1
 9fa:	fe0916e3          	bnez	s2,9e6 <vprintf+0x21c>
        printptr(fd, va_arg(ap, uint64));
 9fe:	8bea                	mv	s7,s10
      state = 0;
 a00:	4981                	li	s3,0
 a02:	6d02                	ld	s10,0(sp)
 a04:	bd01                	j	814 <vprintf+0x4a>
        putc(fd, va_arg(ap, uint32));
 a06:	008b8913          	add	s2,s7,8
 a0a:	000bc583          	lbu	a1,0(s7)
 a0e:	855a                	mv	a0,s6
 a10:	d01ff0ef          	jal	710 <putc>
 a14:	8bca                	mv	s7,s2
      state = 0;
 a16:	4981                	li	s3,0
 a18:	bbf5                	j	814 <vprintf+0x4a>
        if((s = va_arg(ap, char*)) == 0)
 a1a:	008b8993          	add	s3,s7,8
 a1e:	000bb903          	ld	s2,0(s7)
 a22:	00090f63          	beqz	s2,a40 <vprintf+0x276>
        for(; *s; s++)
 a26:	00094583          	lbu	a1,0(s2)
 a2a:	c195                	beqz	a1,a4e <vprintf+0x284>
          putc(fd, *s);
 a2c:	855a                	mv	a0,s6
 a2e:	ce3ff0ef          	jal	710 <putc>
        for(; *s; s++)
 a32:	0905                	add	s2,s2,1
 a34:	00094583          	lbu	a1,0(s2)
 a38:	f9f5                	bnez	a1,a2c <vprintf+0x262>
        if((s = va_arg(ap, char*)) == 0)
 a3a:	8bce                	mv	s7,s3
      state = 0;
 a3c:	4981                	li	s3,0
 a3e:	bbd9                	j	814 <vprintf+0x4a>
          s = "(null)";
 a40:	00000917          	auipc	s2,0x0
 a44:	24890913          	add	s2,s2,584 # c88 <malloc+0x13c>
        for(; *s; s++)
 a48:	02800593          	li	a1,40
 a4c:	b7c5                	j	a2c <vprintf+0x262>
        if((s = va_arg(ap, char*)) == 0)
 a4e:	8bce                	mv	s7,s3
      state = 0;
 a50:	4981                	li	s3,0
 a52:	b3c9                	j	814 <vprintf+0x4a>
 a54:	64a6                	ld	s1,72(sp)
 a56:	79e2                	ld	s3,56(sp)
 a58:	7a42                	ld	s4,48(sp)
 a5a:	7aa2                	ld	s5,40(sp)
 a5c:	7b02                	ld	s6,32(sp)
 a5e:	6be2                	ld	s7,24(sp)
 a60:	6c42                	ld	s8,16(sp)
 a62:	6ca2                	ld	s9,8(sp)
    }
  }
}
 a64:	60e6                	ld	ra,88(sp)
 a66:	6446                	ld	s0,80(sp)
 a68:	6906                	ld	s2,64(sp)
 a6a:	6125                	add	sp,sp,96
 a6c:	8082                	ret

0000000000000a6e <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 a6e:	715d                	add	sp,sp,-80
 a70:	ec06                	sd	ra,24(sp)
 a72:	e822                	sd	s0,16(sp)
 a74:	1000                	add	s0,sp,32
 a76:	e010                	sd	a2,0(s0)
 a78:	e414                	sd	a3,8(s0)
 a7a:	e818                	sd	a4,16(s0)
 a7c:	ec1c                	sd	a5,24(s0)
 a7e:	03043023          	sd	a6,32(s0)
 a82:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 a86:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 a8a:	8622                	mv	a2,s0
 a8c:	d3fff0ef          	jal	7ca <vprintf>
}
 a90:	60e2                	ld	ra,24(sp)
 a92:	6442                	ld	s0,16(sp)
 a94:	6161                	add	sp,sp,80
 a96:	8082                	ret

0000000000000a98 <printf>:

void
printf(const char *fmt, ...)
{
 a98:	711d                	add	sp,sp,-96
 a9a:	ec06                	sd	ra,24(sp)
 a9c:	e822                	sd	s0,16(sp)
 a9e:	1000                	add	s0,sp,32
 aa0:	e40c                	sd	a1,8(s0)
 aa2:	e810                	sd	a2,16(s0)
 aa4:	ec14                	sd	a3,24(s0)
 aa6:	f018                	sd	a4,32(s0)
 aa8:	f41c                	sd	a5,40(s0)
 aaa:	03043823          	sd	a6,48(s0)
 aae:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 ab2:	00840613          	add	a2,s0,8
 ab6:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 aba:	85aa                	mv	a1,a0
 abc:	4505                	li	a0,1
 abe:	d0dff0ef          	jal	7ca <vprintf>
}
 ac2:	60e2                	ld	ra,24(sp)
 ac4:	6442                	ld	s0,16(sp)
 ac6:	6125                	add	sp,sp,96
 ac8:	8082                	ret

0000000000000aca <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 aca:	1141                	add	sp,sp,-16
 acc:	e422                	sd	s0,8(sp)
 ace:	0800                	add	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 ad0:	ff050693          	add	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 ad4:	00000797          	auipc	a5,0x0
 ad8:	52c7b783          	ld	a5,1324(a5) # 1000 <freep>
 adc:	a02d                	j	b06 <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 ade:	4618                	lw	a4,8(a2)
 ae0:	9f2d                	addw	a4,a4,a1
 ae2:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 ae6:	6398                	ld	a4,0(a5)
 ae8:	6310                	ld	a2,0(a4)
 aea:	a83d                	j	b28 <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 aec:	ff852703          	lw	a4,-8(a0)
 af0:	9f31                	addw	a4,a4,a2
 af2:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 af4:	ff053683          	ld	a3,-16(a0)
 af8:	a091                	j	b3c <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 afa:	6398                	ld	a4,0(a5)
 afc:	00e7e463          	bltu	a5,a4,b04 <free+0x3a>
 b00:	00e6ea63          	bltu	a3,a4,b14 <free+0x4a>
{
 b04:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 b06:	fed7fae3          	bgeu	a5,a3,afa <free+0x30>
 b0a:	6398                	ld	a4,0(a5)
 b0c:	00e6e463          	bltu	a3,a4,b14 <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 b10:	fee7eae3          	bltu	a5,a4,b04 <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 b14:	ff852583          	lw	a1,-8(a0)
 b18:	6390                	ld	a2,0(a5)
 b1a:	02059813          	sll	a6,a1,0x20
 b1e:	01c85713          	srl	a4,a6,0x1c
 b22:	9736                	add	a4,a4,a3
 b24:	fae60de3          	beq	a2,a4,ade <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 b28:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 b2c:	4790                	lw	a2,8(a5)
 b2e:	02061593          	sll	a1,a2,0x20
 b32:	01c5d713          	srl	a4,a1,0x1c
 b36:	973e                	add	a4,a4,a5
 b38:	fae68ae3          	beq	a3,a4,aec <free+0x22>
    p->s.ptr = bp->s.ptr;
 b3c:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 b3e:	00000717          	auipc	a4,0x0
 b42:	4cf73123          	sd	a5,1218(a4) # 1000 <freep>
}
 b46:	6422                	ld	s0,8(sp)
 b48:	0141                	add	sp,sp,16
 b4a:	8082                	ret

0000000000000b4c <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 b4c:	7139                	add	sp,sp,-64
 b4e:	fc06                	sd	ra,56(sp)
 b50:	f822                	sd	s0,48(sp)
 b52:	f426                	sd	s1,40(sp)
 b54:	ec4e                	sd	s3,24(sp)
 b56:	0080                	add	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 b58:	02051493          	sll	s1,a0,0x20
 b5c:	9081                	srl	s1,s1,0x20
 b5e:	04bd                	add	s1,s1,15
 b60:	8091                	srl	s1,s1,0x4
 b62:	0014899b          	addw	s3,s1,1
 b66:	0485                	add	s1,s1,1
  if((prevp = freep) == 0){
 b68:	00000517          	auipc	a0,0x0
 b6c:	49853503          	ld	a0,1176(a0) # 1000 <freep>
 b70:	c915                	beqz	a0,ba4 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 b72:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 b74:	4798                	lw	a4,8(a5)
 b76:	08977a63          	bgeu	a4,s1,c0a <malloc+0xbe>
 b7a:	f04a                	sd	s2,32(sp)
 b7c:	e852                	sd	s4,16(sp)
 b7e:	e456                	sd	s5,8(sp)
 b80:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 b82:	8a4e                	mv	s4,s3
 b84:	0009871b          	sext.w	a4,s3
 b88:	6685                	lui	a3,0x1
 b8a:	00d77363          	bgeu	a4,a3,b90 <malloc+0x44>
 b8e:	6a05                	lui	s4,0x1
 b90:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 b94:	004a1a1b          	sllw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 b98:	00000917          	auipc	s2,0x0
 b9c:	46890913          	add	s2,s2,1128 # 1000 <freep>
  if(p == SBRK_ERROR)
 ba0:	5afd                	li	s5,-1
 ba2:	a081                	j	be2 <malloc+0x96>
 ba4:	f04a                	sd	s2,32(sp)
 ba6:	e852                	sd	s4,16(sp)
 ba8:	e456                	sd	s5,8(sp)
 baa:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 bac:	00001797          	auipc	a5,0x1
 bb0:	86478793          	add	a5,a5,-1948 # 1410 <base>
 bb4:	00000717          	auipc	a4,0x0
 bb8:	44f73623          	sd	a5,1100(a4) # 1000 <freep>
 bbc:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 bbe:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 bc2:	b7c1                	j	b82 <malloc+0x36>
        prevp->s.ptr = p->s.ptr;
 bc4:	6398                	ld	a4,0(a5)
 bc6:	e118                	sd	a4,0(a0)
 bc8:	a8a9                	j	c22 <malloc+0xd6>
  hp->s.size = nu;
 bca:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 bce:	0541                	add	a0,a0,16
 bd0:	efbff0ef          	jal	aca <free>
  return freep;
 bd4:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 bd8:	c12d                	beqz	a0,c3a <malloc+0xee>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 bda:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 bdc:	4798                	lw	a4,8(a5)
 bde:	02977263          	bgeu	a4,s1,c02 <malloc+0xb6>
    if(p == freep)
 be2:	00093703          	ld	a4,0(s2)
 be6:	853e                	mv	a0,a5
 be8:	fef719e3          	bne	a4,a5,bda <malloc+0x8e>
  p = sbrk(nu * sizeof(Header));
 bec:	8552                	mv	a0,s4
 bee:	967ff0ef          	jal	554 <sbrk>
  if(p == SBRK_ERROR)
 bf2:	fd551ce3          	bne	a0,s5,bca <malloc+0x7e>
        return 0;
 bf6:	4501                	li	a0,0
 bf8:	7902                	ld	s2,32(sp)
 bfa:	6a42                	ld	s4,16(sp)
 bfc:	6aa2                	ld	s5,8(sp)
 bfe:	6b02                	ld	s6,0(sp)
 c00:	a03d                	j	c2e <malloc+0xe2>
 c02:	7902                	ld	s2,32(sp)
 c04:	6a42                	ld	s4,16(sp)
 c06:	6aa2                	ld	s5,8(sp)
 c08:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 c0a:	fae48de3          	beq	s1,a4,bc4 <malloc+0x78>
        p->s.size -= nunits;
 c0e:	4137073b          	subw	a4,a4,s3
 c12:	c798                	sw	a4,8(a5)
        p += p->s.size;
 c14:	02071693          	sll	a3,a4,0x20
 c18:	01c6d713          	srl	a4,a3,0x1c
 c1c:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 c1e:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 c22:	00000717          	auipc	a4,0x0
 c26:	3ca73f23          	sd	a0,990(a4) # 1000 <freep>
      return (void*)(p + 1);
 c2a:	01078513          	add	a0,a5,16
  }
}
 c2e:	70e2                	ld	ra,56(sp)
 c30:	7442                	ld	s0,48(sp)
 c32:	74a2                	ld	s1,40(sp)
 c34:	69e2                	ld	s3,24(sp)
 c36:	6121                	add	sp,sp,64
 c38:	8082                	ret
 c3a:	7902                	ld	s2,32(sp)
 c3c:	6a42                	ld	s4,16(sp)
 c3e:	6aa2                	ld	s5,8(sp)
 c40:	6b02                	ld	s6,0(sp)
 c42:	b7f5                	j	c2e <malloc+0xe2>
