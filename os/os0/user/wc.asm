
user/_wc:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <wc>:

char buf[512];

void
wc(int fd, char *name)
{
   0:	7119                	add	sp,sp,-128
   2:	fc86                	sd	ra,120(sp)
   4:	f8a2                	sd	s0,112(sp)
   6:	f4a6                	sd	s1,104(sp)
   8:	f0ca                	sd	s2,96(sp)
   a:	ecce                	sd	s3,88(sp)
   c:	e8d2                	sd	s4,80(sp)
   e:	e4d6                	sd	s5,72(sp)
  10:	e0da                	sd	s6,64(sp)
  12:	fc5e                	sd	s7,56(sp)
  14:	f862                	sd	s8,48(sp)
  16:	f466                	sd	s9,40(sp)
  18:	f06a                	sd	s10,32(sp)
  1a:	ec6e                	sd	s11,24(sp)
  1c:	0100                	add	s0,sp,128
  1e:	f8a43423          	sd	a0,-120(s0)
  22:	f8b43023          	sd	a1,-128(s0)
  int i, n;
  int l, w, c, inword;

  l = w = c = 0;
  inword = 0;
  26:	4901                	li	s2,0
  l = w = c = 0;
  28:	4d01                	li	s10,0
  2a:	4c81                	li	s9,0
  2c:	4c01                	li	s8,0
  while((n = read(fd, buf, sizeof(buf))) > 0){
  2e:	00001d97          	auipc	s11,0x1
  32:	fe2d8d93          	add	s11,s11,-30 # 1010 <buf>
    for(i=0; i<n; i++){
      c++;
      if(buf[i] == '\n')
  36:	4aa9                	li	s5,10
        l++;
      if(strchr(" \r\t\n\v", buf[i]))
  38:	00001a17          	auipc	s4,0x1
  3c:	b18a0a13          	add	s4,s4,-1256 # b50 <malloc+0x102>
        inword = 0;
  40:	4b81                	li	s7,0
  while((n = read(fd, buf, sizeof(buf))) > 0){
  42:	a035                	j	6e <wc+0x6e>
      if(strchr(" \r\t\n\v", buf[i]))
  44:	8552                	mv	a0,s4
  46:	254000ef          	jal	29a <strchr>
  4a:	c919                	beqz	a0,60 <wc+0x60>
        inword = 0;
  4c:	895e                	mv	s2,s7
    for(i=0; i<n; i++){
  4e:	0485                	add	s1,s1,1
  50:	01348d63          	beq	s1,s3,6a <wc+0x6a>
      if(buf[i] == '\n')
  54:	0004c583          	lbu	a1,0(s1)
  58:	ff5596e3          	bne	a1,s5,44 <wc+0x44>
        l++;
  5c:	2c05                	addw	s8,s8,1
  5e:	b7dd                	j	44 <wc+0x44>
      else if(!inword){
  60:	fe0917e3          	bnez	s2,4e <wc+0x4e>
        w++;
  64:	2c85                	addw	s9,s9,1
        inword = 1;
  66:	4905                	li	s2,1
  68:	b7dd                	j	4e <wc+0x4e>
  6a:	01ab0d3b          	addw	s10,s6,s10
  while((n = read(fd, buf, sizeof(buf))) > 0){
  6e:	20000613          	li	a2,512
  72:	85ee                	mv	a1,s11
  74:	f8843503          	ld	a0,-120(s0)
  78:	4ca000ef          	jal	542 <read>
  7c:	8b2a                	mv	s6,a0
  7e:	00a05963          	blez	a0,90 <wc+0x90>
    for(i=0; i<n; i++){
  82:	00001497          	auipc	s1,0x1
  86:	f8e48493          	add	s1,s1,-114 # 1010 <buf>
  8a:	009509b3          	add	s3,a0,s1
  8e:	b7d9                	j	54 <wc+0x54>
      }
    }
  }
  if(n < 0){
  90:	02054c63          	bltz	a0,c8 <wc+0xc8>
    printf("wc: read error\n");
    exit(1);
  }
  printf("%d %d %d %s\n", l, w, c, name);
  94:	f8043703          	ld	a4,-128(s0)
  98:	86ea                	mv	a3,s10
  9a:	8666                	mv	a2,s9
  9c:	85e2                	mv	a1,s8
  9e:	00001517          	auipc	a0,0x1
  a2:	ad250513          	add	a0,a0,-1326 # b70 <malloc+0x122>
  a6:	0f5000ef          	jal	99a <printf>
}
  aa:	70e6                	ld	ra,120(sp)
  ac:	7446                	ld	s0,112(sp)
  ae:	74a6                	ld	s1,104(sp)
  b0:	7906                	ld	s2,96(sp)
  b2:	69e6                	ld	s3,88(sp)
  b4:	6a46                	ld	s4,80(sp)
  b6:	6aa6                	ld	s5,72(sp)
  b8:	6b06                	ld	s6,64(sp)
  ba:	7be2                	ld	s7,56(sp)
  bc:	7c42                	ld	s8,48(sp)
  be:	7ca2                	ld	s9,40(sp)
  c0:	7d02                	ld	s10,32(sp)
  c2:	6de2                	ld	s11,24(sp)
  c4:	6109                	add	sp,sp,128
  c6:	8082                	ret
    printf("wc: read error\n");
  c8:	00001517          	auipc	a0,0x1
  cc:	a9850513          	add	a0,a0,-1384 # b60 <malloc+0x112>
  d0:	0cb000ef          	jal	99a <printf>
    exit(1);
  d4:	4505                	li	a0,1
  d6:	454000ef          	jal	52a <exit>

00000000000000da <main>:

int
main(int argc, char *argv[])
{
  da:	7179                	add	sp,sp,-48
  dc:	f406                	sd	ra,40(sp)
  de:	f022                	sd	s0,32(sp)
  e0:	1800                	add	s0,sp,48
  int fd, i;

  if(argc <= 1){
  e2:	4785                	li	a5,1
  e4:	04a7d463          	bge	a5,a0,12c <main+0x52>
  e8:	ec26                	sd	s1,24(sp)
  ea:	e84a                	sd	s2,16(sp)
  ec:	e44e                	sd	s3,8(sp)
  ee:	00858913          	add	s2,a1,8
  f2:	ffe5099b          	addw	s3,a0,-2
  f6:	02099793          	sll	a5,s3,0x20
  fa:	01d7d993          	srl	s3,a5,0x1d
  fe:	05c1                	add	a1,a1,16
 100:	99ae                	add	s3,s3,a1
    wc(0, "");
    exit(0);
  }

  for(i = 1; i < argc; i++){
    if((fd = open(argv[i], O_RDONLY)) < 0){
 102:	4581                	li	a1,0
 104:	00093503          	ld	a0,0(s2)
 108:	462000ef          	jal	56a <open>
 10c:	84aa                	mv	s1,a0
 10e:	02054c63          	bltz	a0,146 <main+0x6c>
      printf("wc: cannot open %s\n", argv[i]);
      exit(1);
    }
    wc(fd, argv[i]);
 112:	00093583          	ld	a1,0(s2)
 116:	eebff0ef          	jal	0 <wc>
    close(fd);
 11a:	8526                	mv	a0,s1
 11c:	436000ef          	jal	552 <close>
  for(i = 1; i < argc; i++){
 120:	0921                	add	s2,s2,8
 122:	ff3910e3          	bne	s2,s3,102 <main+0x28>
  }
  exit(0);
 126:	4501                	li	a0,0
 128:	402000ef          	jal	52a <exit>
 12c:	ec26                	sd	s1,24(sp)
 12e:	e84a                	sd	s2,16(sp)
 130:	e44e                	sd	s3,8(sp)
    wc(0, "");
 132:	00001597          	auipc	a1,0x1
 136:	a2658593          	add	a1,a1,-1498 # b58 <malloc+0x10a>
 13a:	4501                	li	a0,0
 13c:	ec5ff0ef          	jal	0 <wc>
    exit(0);
 140:	4501                	li	a0,0
 142:	3e8000ef          	jal	52a <exit>
      printf("wc: cannot open %s\n", argv[i]);
 146:	00093583          	ld	a1,0(s2)
 14a:	00001517          	auipc	a0,0x1
 14e:	a3650513          	add	a0,a0,-1482 # b80 <malloc+0x132>
 152:	049000ef          	jal	99a <printf>
      exit(1);
 156:	4505                	li	a0,1
 158:	3d2000ef          	jal	52a <exit>

000000000000015c <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start(int argc, char **argv)
{
 15c:	1141                	add	sp,sp,-16
 15e:	e406                	sd	ra,8(sp)
 160:	e022                	sd	s0,0(sp)
 162:	0800                	add	s0,sp,16
  int r;
  extern int main(int argc, char **argv);
  r = main(argc, argv);
 164:	f77ff0ef          	jal	da <main>
  exit(r);
 168:	3c2000ef          	jal	52a <exit>

000000000000016c <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
 16c:	1141                	add	sp,sp,-16
 16e:	e422                	sd	s0,8(sp)
 170:	0800                	add	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 172:	87aa                	mv	a5,a0
 174:	0585                	add	a1,a1,1
 176:	0785                	add	a5,a5,1
 178:	fff5c703          	lbu	a4,-1(a1)
 17c:	fee78fa3          	sb	a4,-1(a5)
 180:	fb75                	bnez	a4,174 <strcpy+0x8>
    ;
  return os;
}
 182:	6422                	ld	s0,8(sp)
 184:	0141                	add	sp,sp,16
 186:	8082                	ret

0000000000000188 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 188:	1141                	add	sp,sp,-16
 18a:	e422                	sd	s0,8(sp)
 18c:	0800                	add	s0,sp,16
  while(*p && *p == *q)
 18e:	00054783          	lbu	a5,0(a0)
 192:	cb91                	beqz	a5,1a6 <strcmp+0x1e>
 194:	0005c703          	lbu	a4,0(a1)
 198:	00f71763          	bne	a4,a5,1a6 <strcmp+0x1e>
    p++, q++;
 19c:	0505                	add	a0,a0,1
 19e:	0585                	add	a1,a1,1
  while(*p && *p == *q)
 1a0:	00054783          	lbu	a5,0(a0)
 1a4:	fbe5                	bnez	a5,194 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 1a6:	0005c503          	lbu	a0,0(a1)
}
 1aa:	40a7853b          	subw	a0,a5,a0
 1ae:	6422                	ld	s0,8(sp)
 1b0:	0141                	add	sp,sp,16
 1b2:	8082                	ret

00000000000001b4 <strncmp>:

int
strncmp(const char *p, const char *q, uint n)
{
 1b4:	1141                	add	sp,sp,-16
 1b6:	e422                	sd	s0,8(sp)
 1b8:	0800                	add	s0,sp,16
  while(n > 0 && *p && *p == *q) {
 1ba:	ce11                	beqz	a2,1d6 <strncmp+0x22>
 1bc:	00054783          	lbu	a5,0(a0)
 1c0:	cf89                	beqz	a5,1da <strncmp+0x26>
 1c2:	0005c703          	lbu	a4,0(a1)
 1c6:	00f71a63          	bne	a4,a5,1da <strncmp+0x26>
    p++, q++, n--;
 1ca:	0505                	add	a0,a0,1
 1cc:	0585                	add	a1,a1,1
 1ce:	367d                	addw	a2,a2,-1
  while(n > 0 && *p && *p == *q) {
 1d0:	f675                	bnez	a2,1bc <strncmp+0x8>
  }
  if (n == 0)
    return 0;
 1d2:	4501                	li	a0,0
 1d4:	a801                	j	1e4 <strncmp+0x30>
 1d6:	4501                	li	a0,0
 1d8:	a031                	j	1e4 <strncmp+0x30>
  return (uchar)*p - (uchar)*q;
 1da:	00054503          	lbu	a0,0(a0)
 1de:	0005c783          	lbu	a5,0(a1)
 1e2:	9d1d                	subw	a0,a0,a5
}
 1e4:	6422                	ld	s0,8(sp)
 1e6:	0141                	add	sp,sp,16
 1e8:	8082                	ret

00000000000001ea <strcat>:

char*
strcat(char *dst, const char *src)
{
 1ea:	1141                	add	sp,sp,-16
 1ec:	e422                	sd	s0,8(sp)
 1ee:	0800                	add	s0,sp,16
  char *p = dst;
  while(*p) p++;
 1f0:	00054783          	lbu	a5,0(a0)
 1f4:	c385                	beqz	a5,214 <strcat+0x2a>
  char *p = dst;
 1f6:	87aa                	mv	a5,a0
  while(*p) p++;
 1f8:	0785                	add	a5,a5,1
 1fa:	0007c703          	lbu	a4,0(a5)
 1fe:	ff6d                	bnez	a4,1f8 <strcat+0xe>
  while((*p++ = *src++) != 0);
 200:	0585                	add	a1,a1,1
 202:	0785                	add	a5,a5,1
 204:	fff5c703          	lbu	a4,-1(a1)
 208:	fee78fa3          	sb	a4,-1(a5)
 20c:	fb75                	bnez	a4,200 <strcat+0x16>
  return dst;
}
 20e:	6422                	ld	s0,8(sp)
 210:	0141                	add	sp,sp,16
 212:	8082                	ret
  char *p = dst;
 214:	87aa                	mv	a5,a0
 216:	b7ed                	j	200 <strcat+0x16>

0000000000000218 <strncpy>:

char*
strncpy(char *dst, const char *src, int n)
{
 218:	1141                	add	sp,sp,-16
 21a:	e422                	sd	s0,8(sp)
 21c:	0800                	add	s0,sp,16
  char *p = dst;
 21e:	87aa                	mv	a5,a0
  while(n > 0 && *src) {
 220:	02c05463          	blez	a2,248 <strncpy+0x30>
 224:	0005c703          	lbu	a4,0(a1)
 228:	cb01                	beqz	a4,238 <strncpy+0x20>
    *p++ = *src++;
 22a:	0585                	add	a1,a1,1
 22c:	0785                	add	a5,a5,1
 22e:	fee78fa3          	sb	a4,-1(a5)
    n--;
 232:	367d                	addw	a2,a2,-1
  while(n > 0 && *src) {
 234:	fa65                	bnez	a2,224 <strncpy+0xc>
 236:	a809                	j	248 <strncpy+0x30>
  }
  while(n > 0) {
 238:	1602                	sll	a2,a2,0x20
 23a:	9201                	srl	a2,a2,0x20
 23c:	963e                	add	a2,a2,a5
    *p++ = 0;
 23e:	0785                	add	a5,a5,1
 240:	fe078fa3          	sb	zero,-1(a5)
  while(n > 0) {
 244:	fec79de3          	bne	a5,a2,23e <strncpy+0x26>
    n--;
  }
  return dst;
}
 248:	6422                	ld	s0,8(sp)
 24a:	0141                	add	sp,sp,16
 24c:	8082                	ret

000000000000024e <strlen>:

uint
strlen(const char *s)
{
 24e:	1141                	add	sp,sp,-16
 250:	e422                	sd	s0,8(sp)
 252:	0800                	add	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 254:	00054783          	lbu	a5,0(a0)
 258:	cf91                	beqz	a5,274 <strlen+0x26>
 25a:	0505                	add	a0,a0,1
 25c:	87aa                	mv	a5,a0
 25e:	86be                	mv	a3,a5
 260:	0785                	add	a5,a5,1
 262:	fff7c703          	lbu	a4,-1(a5)
 266:	ff65                	bnez	a4,25e <strlen+0x10>
 268:	40a6853b          	subw	a0,a3,a0
 26c:	2505                	addw	a0,a0,1
    ;
  return n;
}
 26e:	6422                	ld	s0,8(sp)
 270:	0141                	add	sp,sp,16
 272:	8082                	ret
  for(n = 0; s[n]; n++)
 274:	4501                	li	a0,0
 276:	bfe5                	j	26e <strlen+0x20>

0000000000000278 <memset>:

void*
memset(void *dst, int c, uint n)
{
 278:	1141                	add	sp,sp,-16
 27a:	e422                	sd	s0,8(sp)
 27c:	0800                	add	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 27e:	ca19                	beqz	a2,294 <memset+0x1c>
 280:	87aa                	mv	a5,a0
 282:	1602                	sll	a2,a2,0x20
 284:	9201                	srl	a2,a2,0x20
 286:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 28a:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 28e:	0785                	add	a5,a5,1
 290:	fee79de3          	bne	a5,a4,28a <memset+0x12>
  }
  return dst;
}
 294:	6422                	ld	s0,8(sp)
 296:	0141                	add	sp,sp,16
 298:	8082                	ret

000000000000029a <strchr>:

char*
strchr(const char *s, char c)
{
 29a:	1141                	add	sp,sp,-16
 29c:	e422                	sd	s0,8(sp)
 29e:	0800                	add	s0,sp,16
  for(; *s; s++)
 2a0:	00054783          	lbu	a5,0(a0)
 2a4:	cb99                	beqz	a5,2ba <strchr+0x20>
    if(*s == c)
 2a6:	00f58763          	beq	a1,a5,2b4 <strchr+0x1a>
  for(; *s; s++)
 2aa:	0505                	add	a0,a0,1
 2ac:	00054783          	lbu	a5,0(a0)
 2b0:	fbfd                	bnez	a5,2a6 <strchr+0xc>
      return (char*)s;
  return 0;
 2b2:	4501                	li	a0,0
}
 2b4:	6422                	ld	s0,8(sp)
 2b6:	0141                	add	sp,sp,16
 2b8:	8082                	ret
  return 0;
 2ba:	4501                	li	a0,0
 2bc:	bfe5                	j	2b4 <strchr+0x1a>

00000000000002be <gets>:

char*
gets(char *buf, int max)
{
 2be:	711d                	add	sp,sp,-96
 2c0:	ec86                	sd	ra,88(sp)
 2c2:	e8a2                	sd	s0,80(sp)
 2c4:	e4a6                	sd	s1,72(sp)
 2c6:	e0ca                	sd	s2,64(sp)
 2c8:	fc4e                	sd	s3,56(sp)
 2ca:	f852                	sd	s4,48(sp)
 2cc:	f456                	sd	s5,40(sp)
 2ce:	f05a                	sd	s6,32(sp)
 2d0:	ec5e                	sd	s7,24(sp)
 2d2:	1080                	add	s0,sp,96
 2d4:	8baa                	mv	s7,a0
 2d6:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 2d8:	892a                	mv	s2,a0
 2da:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 2dc:	4aa9                	li	s5,10
 2de:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 2e0:	89a6                	mv	s3,s1
 2e2:	2485                	addw	s1,s1,1
 2e4:	0344d663          	bge	s1,s4,310 <gets+0x52>
    cc = read(0, &c, 1);
 2e8:	4605                	li	a2,1
 2ea:	faf40593          	add	a1,s0,-81
 2ee:	4501                	li	a0,0
 2f0:	252000ef          	jal	542 <read>
    if(cc < 1)
 2f4:	00a05e63          	blez	a0,310 <gets+0x52>
    buf[i++] = c;
 2f8:	faf44783          	lbu	a5,-81(s0)
 2fc:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 300:	01578763          	beq	a5,s5,30e <gets+0x50>
 304:	0905                	add	s2,s2,1
 306:	fd679de3          	bne	a5,s6,2e0 <gets+0x22>
    buf[i++] = c;
 30a:	89a6                	mv	s3,s1
 30c:	a011                	j	310 <gets+0x52>
 30e:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 310:	99de                	add	s3,s3,s7
 312:	00098023          	sb	zero,0(s3)
  return buf;
}
 316:	855e                	mv	a0,s7
 318:	60e6                	ld	ra,88(sp)
 31a:	6446                	ld	s0,80(sp)
 31c:	64a6                	ld	s1,72(sp)
 31e:	6906                	ld	s2,64(sp)
 320:	79e2                	ld	s3,56(sp)
 322:	7a42                	ld	s4,48(sp)
 324:	7aa2                	ld	s5,40(sp)
 326:	7b02                	ld	s6,32(sp)
 328:	6be2                	ld	s7,24(sp)
 32a:	6125                	add	sp,sp,96
 32c:	8082                	ret

000000000000032e <stat>:

int
stat(const char *n, struct stat *st)
{
 32e:	1101                	add	sp,sp,-32
 330:	ec06                	sd	ra,24(sp)
 332:	e822                	sd	s0,16(sp)
 334:	e04a                	sd	s2,0(sp)
 336:	1000                	add	s0,sp,32
 338:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 33a:	4581                	li	a1,0
 33c:	22e000ef          	jal	56a <open>
  if(fd < 0)
 340:	02054263          	bltz	a0,364 <stat+0x36>
 344:	e426                	sd	s1,8(sp)
 346:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 348:	85ca                	mv	a1,s2
 34a:	238000ef          	jal	582 <fstat>
 34e:	892a                	mv	s2,a0
  close(fd);
 350:	8526                	mv	a0,s1
 352:	200000ef          	jal	552 <close>
  return r;
 356:	64a2                	ld	s1,8(sp)
}
 358:	854a                	mv	a0,s2
 35a:	60e2                	ld	ra,24(sp)
 35c:	6442                	ld	s0,16(sp)
 35e:	6902                	ld	s2,0(sp)
 360:	6105                	add	sp,sp,32
 362:	8082                	ret
    return -1;
 364:	597d                	li	s2,-1
 366:	bfcd                	j	358 <stat+0x2a>

0000000000000368 <atoi>:

int
atoi(const char *s)
{
 368:	1141                	add	sp,sp,-16
 36a:	e422                	sd	s0,8(sp)
 36c:	0800                	add	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 36e:	00054683          	lbu	a3,0(a0)
 372:	fd06879b          	addw	a5,a3,-48
 376:	0ff7f793          	zext.b	a5,a5
 37a:	4625                	li	a2,9
 37c:	02f66863          	bltu	a2,a5,3ac <atoi+0x44>
 380:	872a                	mv	a4,a0
  n = 0;
 382:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 384:	0705                	add	a4,a4,1
 386:	0025179b          	sllw	a5,a0,0x2
 38a:	9fa9                	addw	a5,a5,a0
 38c:	0017979b          	sllw	a5,a5,0x1
 390:	9fb5                	addw	a5,a5,a3
 392:	fd07851b          	addw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 396:	00074683          	lbu	a3,0(a4)
 39a:	fd06879b          	addw	a5,a3,-48
 39e:	0ff7f793          	zext.b	a5,a5
 3a2:	fef671e3          	bgeu	a2,a5,384 <atoi+0x1c>
  return n;
}
 3a6:	6422                	ld	s0,8(sp)
 3a8:	0141                	add	sp,sp,16
 3aa:	8082                	ret
  n = 0;
 3ac:	4501                	li	a0,0
 3ae:	bfe5                	j	3a6 <atoi+0x3e>

00000000000003b0 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 3b0:	1141                	add	sp,sp,-16
 3b2:	e422                	sd	s0,8(sp)
 3b4:	0800                	add	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 3b6:	02b57463          	bgeu	a0,a1,3de <memmove+0x2e>
    while(n-- > 0)
 3ba:	00c05f63          	blez	a2,3d8 <memmove+0x28>
 3be:	1602                	sll	a2,a2,0x20
 3c0:	9201                	srl	a2,a2,0x20
 3c2:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 3c6:	872a                	mv	a4,a0
      *dst++ = *src++;
 3c8:	0585                	add	a1,a1,1
 3ca:	0705                	add	a4,a4,1
 3cc:	fff5c683          	lbu	a3,-1(a1)
 3d0:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 3d4:	fef71ae3          	bne	a4,a5,3c8 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 3d8:	6422                	ld	s0,8(sp)
 3da:	0141                	add	sp,sp,16
 3dc:	8082                	ret
    dst += n;
 3de:	00c50733          	add	a4,a0,a2
    src += n;
 3e2:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 3e4:	fec05ae3          	blez	a2,3d8 <memmove+0x28>
 3e8:	fff6079b          	addw	a5,a2,-1
 3ec:	1782                	sll	a5,a5,0x20
 3ee:	9381                	srl	a5,a5,0x20
 3f0:	fff7c793          	not	a5,a5
 3f4:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 3f6:	15fd                	add	a1,a1,-1
 3f8:	177d                	add	a4,a4,-1
 3fa:	0005c683          	lbu	a3,0(a1)
 3fe:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 402:	fee79ae3          	bne	a5,a4,3f6 <memmove+0x46>
 406:	bfc9                	j	3d8 <memmove+0x28>

0000000000000408 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 408:	1141                	add	sp,sp,-16
 40a:	e422                	sd	s0,8(sp)
 40c:	0800                	add	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 40e:	ca05                	beqz	a2,43e <memcmp+0x36>
 410:	fff6069b          	addw	a3,a2,-1
 414:	1682                	sll	a3,a3,0x20
 416:	9281                	srl	a3,a3,0x20
 418:	0685                	add	a3,a3,1
 41a:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 41c:	00054783          	lbu	a5,0(a0)
 420:	0005c703          	lbu	a4,0(a1)
 424:	00e79863          	bne	a5,a4,434 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 428:	0505                	add	a0,a0,1
    p2++;
 42a:	0585                	add	a1,a1,1
  while (n-- > 0) {
 42c:	fed518e3          	bne	a0,a3,41c <memcmp+0x14>
  }
  return 0;
 430:	4501                	li	a0,0
 432:	a019                	j	438 <memcmp+0x30>
      return *p1 - *p2;
 434:	40e7853b          	subw	a0,a5,a4
}
 438:	6422                	ld	s0,8(sp)
 43a:	0141                	add	sp,sp,16
 43c:	8082                	ret
  return 0;
 43e:	4501                	li	a0,0
 440:	bfe5                	j	438 <memcmp+0x30>

0000000000000442 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 442:	1141                	add	sp,sp,-16
 444:	e406                	sd	ra,8(sp)
 446:	e022                	sd	s0,0(sp)
 448:	0800                	add	s0,sp,16
  return memmove(dst, src, n);
 44a:	f67ff0ef          	jal	3b0 <memmove>
}
 44e:	60a2                	ld	ra,8(sp)
 450:	6402                	ld	s0,0(sp)
 452:	0141                	add	sp,sp,16
 454:	8082                	ret

0000000000000456 <sbrk>:

char *
sbrk(int n) {
 456:	1141                	add	sp,sp,-16
 458:	e406                	sd	ra,8(sp)
 45a:	e022                	sd	s0,0(sp)
 45c:	0800                	add	s0,sp,16
  return sys_sbrk(n, SBRK_EAGER);
 45e:	4585                	li	a1,1
 460:	152000ef          	jal	5b2 <sys_sbrk>
}
 464:	60a2                	ld	ra,8(sp)
 466:	6402                	ld	s0,0(sp)
 468:	0141                	add	sp,sp,16
 46a:	8082                	ret

000000000000046c <sbrklazy>:

char *
sbrklazy(int n) {
 46c:	1141                	add	sp,sp,-16
 46e:	e406                	sd	ra,8(sp)
 470:	e022                	sd	s0,0(sp)
 472:	0800                	add	s0,sp,16
  return sys_sbrk(n, SBRK_LAZY);
 474:	4589                	li	a1,2
 476:	13c000ef          	jal	5b2 <sys_sbrk>
}
 47a:	60a2                	ld	ra,8(sp)
 47c:	6402                	ld	s0,0(sp)
 47e:	0141                	add	sp,sp,16
 480:	8082                	ret

0000000000000482 <htons>:

// Byte order conversion functions
unsigned short
htons(unsigned short hostshort)
{
 482:	1141                	add	sp,sp,-16
 484:	e422                	sd	s0,8(sp)
 486:	0800                	add	s0,sp,16
  return ((hostshort >> 8) & 0xff) | ((hostshort & 0xff) << 8);
 488:	0085179b          	sllw	a5,a0,0x8
 48c:	0085551b          	srlw	a0,a0,0x8
 490:	8d5d                	or	a0,a0,a5
}
 492:	1542                	sll	a0,a0,0x30
 494:	9141                	srl	a0,a0,0x30
 496:	6422                	ld	s0,8(sp)
 498:	0141                	add	sp,sp,16
 49a:	8082                	ret

000000000000049c <ntohs>:

unsigned short
ntohs(unsigned short netshort)
{
 49c:	1141                	add	sp,sp,-16
 49e:	e422                	sd	s0,8(sp)
 4a0:	0800                	add	s0,sp,16
  return ((netshort >> 8) & 0xff) | ((netshort & 0xff) << 8);
 4a2:	0085179b          	sllw	a5,a0,0x8
 4a6:	0085551b          	srlw	a0,a0,0x8
 4aa:	8d5d                	or	a0,a0,a5
}
 4ac:	1542                	sll	a0,a0,0x30
 4ae:	9141                	srl	a0,a0,0x30
 4b0:	6422                	ld	s0,8(sp)
 4b2:	0141                	add	sp,sp,16
 4b4:	8082                	ret

00000000000004b6 <htonl>:

unsigned long
htonl(unsigned long hostlong)
{
 4b6:	1141                	add	sp,sp,-16
 4b8:	e422                	sd	s0,8(sp)
 4ba:	0800                	add	s0,sp,16
  return ((hostlong >> 24) & 0xff) |
 4bc:	0185579b          	srlw	a5,a0,0x18
         ((hostlong >> 8) & 0xff00) |
 4c0:	00855713          	srl	a4,a0,0x8
 4c4:	66c1                	lui	a3,0x10
 4c6:	f0068693          	add	a3,a3,-256 # ff00 <base+0xecf0>
 4ca:	8f75                	and	a4,a4,a3
  return ((hostlong >> 24) & 0xff) |
 4cc:	8fd9                	or	a5,a5,a4
         ((hostlong & 0xff00) << 8) |
 4ce:	00851713          	sll	a4,a0,0x8
 4d2:	00ff06b7          	lui	a3,0xff0
 4d6:	8f75                	and	a4,a4,a3
         ((hostlong >> 8) & 0xff00) |
 4d8:	8fd9                	or	a5,a5,a4
         ((hostlong & 0xff) << 24);
 4da:	0562                	sll	a0,a0,0x18
 4dc:	0ff00713          	li	a4,255
 4e0:	0762                	sll	a4,a4,0x18
 4e2:	8d79                	and	a0,a0,a4
}
 4e4:	8d5d                	or	a0,a0,a5
 4e6:	6422                	ld	s0,8(sp)
 4e8:	0141                	add	sp,sp,16
 4ea:	8082                	ret

00000000000004ec <ntohl>:

unsigned long
ntohl(unsigned long netlong)
{
 4ec:	1141                	add	sp,sp,-16
 4ee:	e422                	sd	s0,8(sp)
 4f0:	0800                	add	s0,sp,16
  return ((netlong >> 24) & 0xff) |
 4f2:	0185579b          	srlw	a5,a0,0x18
         ((netlong >> 8) & 0xff00) |
 4f6:	00855713          	srl	a4,a0,0x8
 4fa:	66c1                	lui	a3,0x10
 4fc:	f0068693          	add	a3,a3,-256 # ff00 <base+0xecf0>
 500:	8f75                	and	a4,a4,a3
  return ((netlong >> 24) & 0xff) |
 502:	8fd9                	or	a5,a5,a4
         ((netlong & 0xff00) << 8) |
 504:	00851713          	sll	a4,a0,0x8
 508:	00ff06b7          	lui	a3,0xff0
 50c:	8f75                	and	a4,a4,a3
         ((netlong >> 8) & 0xff00) |
 50e:	8fd9                	or	a5,a5,a4
         ((netlong & 0xff) << 24);
 510:	0562                	sll	a0,a0,0x18
 512:	0ff00713          	li	a4,255
 516:	0762                	sll	a4,a4,0x18
 518:	8d79                	and	a0,a0,a4
}
 51a:	8d5d                	or	a0,a0,a5
 51c:	6422                	ld	s0,8(sp)
 51e:	0141                	add	sp,sp,16
 520:	8082                	ret

0000000000000522 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 522:	4885                	li	a7,1
 ecall
 524:	00000073          	ecall
 ret
 528:	8082                	ret

000000000000052a <exit>:
.global exit
exit:
 li a7, SYS_exit
 52a:	4889                	li	a7,2
 ecall
 52c:	00000073          	ecall
 ret
 530:	8082                	ret

0000000000000532 <wait>:
.global wait
wait:
 li a7, SYS_wait
 532:	488d                	li	a7,3
 ecall
 534:	00000073          	ecall
 ret
 538:	8082                	ret

000000000000053a <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 53a:	4891                	li	a7,4
 ecall
 53c:	00000073          	ecall
 ret
 540:	8082                	ret

0000000000000542 <read>:
.global read
read:
 li a7, SYS_read
 542:	4895                	li	a7,5
 ecall
 544:	00000073          	ecall
 ret
 548:	8082                	ret

000000000000054a <write>:
.global write
write:
 li a7, SYS_write
 54a:	48c1                	li	a7,16
 ecall
 54c:	00000073          	ecall
 ret
 550:	8082                	ret

0000000000000552 <close>:
.global close
close:
 li a7, SYS_close
 552:	48d5                	li	a7,21
 ecall
 554:	00000073          	ecall
 ret
 558:	8082                	ret

000000000000055a <kill>:
.global kill
kill:
 li a7, SYS_kill
 55a:	4899                	li	a7,6
 ecall
 55c:	00000073          	ecall
 ret
 560:	8082                	ret

0000000000000562 <exec>:
.global exec
exec:
 li a7, SYS_exec
 562:	489d                	li	a7,7
 ecall
 564:	00000073          	ecall
 ret
 568:	8082                	ret

000000000000056a <open>:
.global open
open:
 li a7, SYS_open
 56a:	48bd                	li	a7,15
 ecall
 56c:	00000073          	ecall
 ret
 570:	8082                	ret

0000000000000572 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 572:	48c5                	li	a7,17
 ecall
 574:	00000073          	ecall
 ret
 578:	8082                	ret

000000000000057a <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 57a:	48c9                	li	a7,18
 ecall
 57c:	00000073          	ecall
 ret
 580:	8082                	ret

0000000000000582 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 582:	48a1                	li	a7,8
 ecall
 584:	00000073          	ecall
 ret
 588:	8082                	ret

000000000000058a <link>:
.global link
link:
 li a7, SYS_link
 58a:	48cd                	li	a7,19
 ecall
 58c:	00000073          	ecall
 ret
 590:	8082                	ret

0000000000000592 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 592:	48d1                	li	a7,20
 ecall
 594:	00000073          	ecall
 ret
 598:	8082                	ret

000000000000059a <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 59a:	48a5                	li	a7,9
 ecall
 59c:	00000073          	ecall
 ret
 5a0:	8082                	ret

00000000000005a2 <dup>:
.global dup
dup:
 li a7, SYS_dup
 5a2:	48a9                	li	a7,10
 ecall
 5a4:	00000073          	ecall
 ret
 5a8:	8082                	ret

00000000000005aa <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 5aa:	48ad                	li	a7,11
 ecall
 5ac:	00000073          	ecall
 ret
 5b0:	8082                	ret

00000000000005b2 <sys_sbrk>:
.global sys_sbrk
sys_sbrk:
 li a7, SYS_sbrk
 5b2:	48b1                	li	a7,12
 ecall
 5b4:	00000073          	ecall
 ret
 5b8:	8082                	ret

00000000000005ba <pause>:
.global pause
pause:
 li a7, SYS_pause
 5ba:	48b5                	li	a7,13
 ecall
 5bc:	00000073          	ecall
 ret
 5c0:	8082                	ret

00000000000005c2 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 5c2:	48b9                	li	a7,14
 ecall
 5c4:	00000073          	ecall
 ret
 5c8:	8082                	ret

00000000000005ca <socket>:
.global socket
socket:
 li a7, SYS_socket
 5ca:	48d9                	li	a7,22
 ecall
 5cc:	00000073          	ecall
 ret
 5d0:	8082                	ret

00000000000005d2 <bind>:
.global bind
bind:
 li a7, SYS_bind
 5d2:	48dd                	li	a7,23
 ecall
 5d4:	00000073          	ecall
 ret
 5d8:	8082                	ret

00000000000005da <listen>:
.global listen
listen:
 li a7, SYS_listen
 5da:	48e1                	li	a7,24
 ecall
 5dc:	00000073          	ecall
 ret
 5e0:	8082                	ret

00000000000005e2 <accept>:
.global accept
accept:
 li a7, SYS_accept
 5e2:	48e5                	li	a7,25
 ecall
 5e4:	00000073          	ecall
 ret
 5e8:	8082                	ret

00000000000005ea <connect>:
.global connect
connect:
 li a7, SYS_connect
 5ea:	48e9                	li	a7,26
 ecall
 5ec:	00000073          	ecall
 ret
 5f0:	8082                	ret

00000000000005f2 <send>:
.global send
send:
 li a7, SYS_send
 5f2:	48ed                	li	a7,27
 ecall
 5f4:	00000073          	ecall
 ret
 5f8:	8082                	ret

00000000000005fa <recv>:
.global recv
recv:
 li a7, SYS_recv
 5fa:	48f1                	li	a7,28
 ecall
 5fc:	00000073          	ecall
 ret
 600:	8082                	ret

0000000000000602 <sendto>:
.global sendto
sendto:
 li a7, SYS_sendto
 602:	48f5                	li	a7,29
 ecall
 604:	00000073          	ecall
 ret
 608:	8082                	ret

000000000000060a <recvfrom>:
.global recvfrom
recvfrom:
 li a7, SYS_recvfrom
 60a:	48f9                	li	a7,30
 ecall
 60c:	00000073          	ecall
 ret
 610:	8082                	ret

0000000000000612 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 612:	1101                	add	sp,sp,-32
 614:	ec06                	sd	ra,24(sp)
 616:	e822                	sd	s0,16(sp)
 618:	1000                	add	s0,sp,32
 61a:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 61e:	4605                	li	a2,1
 620:	fef40593          	add	a1,s0,-17
 624:	f27ff0ef          	jal	54a <write>
}
 628:	60e2                	ld	ra,24(sp)
 62a:	6442                	ld	s0,16(sp)
 62c:	6105                	add	sp,sp,32
 62e:	8082                	ret

0000000000000630 <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
 630:	715d                	add	sp,sp,-80
 632:	e486                	sd	ra,72(sp)
 634:	e0a2                	sd	s0,64(sp)
 636:	f84a                	sd	s2,48(sp)
 638:	0880                	add	s0,sp,80
 63a:	892a                	mv	s2,a0
  char buf[20];
  int i, neg;
  unsigned long long x;

  neg = 0;
  if(sgn && xx < 0){
 63c:	c299                	beqz	a3,642 <printint+0x12>
 63e:	0805c363          	bltz	a1,6c4 <printint+0x94>
  neg = 0;
 642:	4881                	li	a7,0
 644:	fb840693          	add	a3,s0,-72
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
 648:	4781                	li	a5,0
  do{
    buf[i++] = digits[x % base];
 64a:	00000517          	auipc	a0,0x0
 64e:	55650513          	add	a0,a0,1366 # ba0 <digits>
 652:	883e                	mv	a6,a5
 654:	2785                	addw	a5,a5,1
 656:	02c5f733          	remu	a4,a1,a2
 65a:	972a                	add	a4,a4,a0
 65c:	00074703          	lbu	a4,0(a4)
 660:	00e68023          	sb	a4,0(a3) # ff0000 <base+0xfeedf0>
  }while((x /= base) != 0);
 664:	872e                	mv	a4,a1
 666:	02c5d5b3          	divu	a1,a1,a2
 66a:	0685                	add	a3,a3,1
 66c:	fec773e3          	bgeu	a4,a2,652 <printint+0x22>
  if(neg)
 670:	00088b63          	beqz	a7,686 <printint+0x56>
    buf[i++] = '-';
 674:	fd078793          	add	a5,a5,-48
 678:	97a2                	add	a5,a5,s0
 67a:	02d00713          	li	a4,45
 67e:	fee78423          	sb	a4,-24(a5)
 682:	0028079b          	addw	a5,a6,2

  while(--i >= 0)
 686:	02f05a63          	blez	a5,6ba <printint+0x8a>
 68a:	fc26                	sd	s1,56(sp)
 68c:	f44e                	sd	s3,40(sp)
 68e:	fb840713          	add	a4,s0,-72
 692:	00f704b3          	add	s1,a4,a5
 696:	fff70993          	add	s3,a4,-1
 69a:	99be                	add	s3,s3,a5
 69c:	37fd                	addw	a5,a5,-1
 69e:	1782                	sll	a5,a5,0x20
 6a0:	9381                	srl	a5,a5,0x20
 6a2:	40f989b3          	sub	s3,s3,a5
    putc(fd, buf[i]);
 6a6:	fff4c583          	lbu	a1,-1(s1)
 6aa:	854a                	mv	a0,s2
 6ac:	f67ff0ef          	jal	612 <putc>
  while(--i >= 0)
 6b0:	14fd                	add	s1,s1,-1
 6b2:	ff349ae3          	bne	s1,s3,6a6 <printint+0x76>
 6b6:	74e2                	ld	s1,56(sp)
 6b8:	79a2                	ld	s3,40(sp)
}
 6ba:	60a6                	ld	ra,72(sp)
 6bc:	6406                	ld	s0,64(sp)
 6be:	7942                	ld	s2,48(sp)
 6c0:	6161                	add	sp,sp,80
 6c2:	8082                	ret
    x = -xx;
 6c4:	40b005b3          	neg	a1,a1
    neg = 1;
 6c8:	4885                	li	a7,1
    x = -xx;
 6ca:	bfad                	j	644 <printint+0x14>

00000000000006cc <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %c, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 6cc:	711d                	add	sp,sp,-96
 6ce:	ec86                	sd	ra,88(sp)
 6d0:	e8a2                	sd	s0,80(sp)
 6d2:	e0ca                	sd	s2,64(sp)
 6d4:	1080                	add	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 6d6:	0005c903          	lbu	s2,0(a1)
 6da:	28090663          	beqz	s2,966 <vprintf+0x29a>
 6de:	e4a6                	sd	s1,72(sp)
 6e0:	fc4e                	sd	s3,56(sp)
 6e2:	f852                	sd	s4,48(sp)
 6e4:	f456                	sd	s5,40(sp)
 6e6:	f05a                	sd	s6,32(sp)
 6e8:	ec5e                	sd	s7,24(sp)
 6ea:	e862                	sd	s8,16(sp)
 6ec:	e466                	sd	s9,8(sp)
 6ee:	8b2a                	mv	s6,a0
 6f0:	8a2e                	mv	s4,a1
 6f2:	8bb2                	mv	s7,a2
  state = 0;
 6f4:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
 6f6:	4481                	li	s1,0
 6f8:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
 6fa:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
 6fe:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
 702:	06c00c93          	li	s9,108
 706:	a005                	j	726 <vprintf+0x5a>
        putc(fd, c0);
 708:	85ca                	mv	a1,s2
 70a:	855a                	mv	a0,s6
 70c:	f07ff0ef          	jal	612 <putc>
 710:	a019                	j	716 <vprintf+0x4a>
    } else if(state == '%'){
 712:	03598263          	beq	s3,s5,736 <vprintf+0x6a>
  for(i = 0; fmt[i]; i++){
 716:	2485                	addw	s1,s1,1
 718:	8726                	mv	a4,s1
 71a:	009a07b3          	add	a5,s4,s1
 71e:	0007c903          	lbu	s2,0(a5)
 722:	22090a63          	beqz	s2,956 <vprintf+0x28a>
    c0 = fmt[i] & 0xff;
 726:	0009079b          	sext.w	a5,s2
    if(state == 0){
 72a:	fe0994e3          	bnez	s3,712 <vprintf+0x46>
      if(c0 == '%'){
 72e:	fd579de3          	bne	a5,s5,708 <vprintf+0x3c>
        state = '%';
 732:	89be                	mv	s3,a5
 734:	b7cd                	j	716 <vprintf+0x4a>
      if(c0) c1 = fmt[i+1] & 0xff;
 736:	00ea06b3          	add	a3,s4,a4
 73a:	0016c683          	lbu	a3,1(a3)
      c1 = c2 = 0;
 73e:	8636                	mv	a2,a3
      if(c1) c2 = fmt[i+2] & 0xff;
 740:	c681                	beqz	a3,748 <vprintf+0x7c>
 742:	9752                	add	a4,a4,s4
 744:	00274603          	lbu	a2,2(a4)
      if(c0 == 'd'){
 748:	05878363          	beq	a5,s8,78e <vprintf+0xc2>
      } else if(c0 == 'l' && c1 == 'd'){
 74c:	05978d63          	beq	a5,s9,7a6 <vprintf+0xda>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
 750:	07500713          	li	a4,117
 754:	0ee78763          	beq	a5,a4,842 <vprintf+0x176>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
 758:	07800713          	li	a4,120
 75c:	12e78963          	beq	a5,a4,88e <vprintf+0x1c2>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
 760:	07000713          	li	a4,112
 764:	14e78e63          	beq	a5,a4,8c0 <vprintf+0x1f4>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 'c'){
 768:	06300713          	li	a4,99
 76c:	18e78e63          	beq	a5,a4,908 <vprintf+0x23c>
        putc(fd, va_arg(ap, uint32));
      } else if(c0 == 's'){
 770:	07300713          	li	a4,115
 774:	1ae78463          	beq	a5,a4,91c <vprintf+0x250>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
 778:	02500713          	li	a4,37
 77c:	04e79563          	bne	a5,a4,7c6 <vprintf+0xfa>
        putc(fd, '%');
 780:	02500593          	li	a1,37
 784:	855a                	mv	a0,s6
 786:	e8dff0ef          	jal	612 <putc>
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c0);
      }

      state = 0;
 78a:	4981                	li	s3,0
 78c:	b769                	j	716 <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 1);
 78e:	008b8913          	add	s2,s7,8
 792:	4685                	li	a3,1
 794:	4629                	li	a2,10
 796:	000ba583          	lw	a1,0(s7)
 79a:	855a                	mv	a0,s6
 79c:	e95ff0ef          	jal	630 <printint>
 7a0:	8bca                	mv	s7,s2
      state = 0;
 7a2:	4981                	li	s3,0
 7a4:	bf8d                	j	716 <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'd'){
 7a6:	06400793          	li	a5,100
 7aa:	02f68963          	beq	a3,a5,7dc <vprintf+0x110>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 7ae:	06c00793          	li	a5,108
 7b2:	04f68263          	beq	a3,a5,7f6 <vprintf+0x12a>
      } else if(c0 == 'l' && c1 == 'u'){
 7b6:	07500793          	li	a5,117
 7ba:	0af68063          	beq	a3,a5,85a <vprintf+0x18e>
      } else if(c0 == 'l' && c1 == 'x'){
 7be:	07800793          	li	a5,120
 7c2:	0ef68263          	beq	a3,a5,8a6 <vprintf+0x1da>
        putc(fd, '%');
 7c6:	02500593          	li	a1,37
 7ca:	855a                	mv	a0,s6
 7cc:	e47ff0ef          	jal	612 <putc>
        putc(fd, c0);
 7d0:	85ca                	mv	a1,s2
 7d2:	855a                	mv	a0,s6
 7d4:	e3fff0ef          	jal	612 <putc>
      state = 0;
 7d8:	4981                	li	s3,0
 7da:	bf35                	j	716 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 7dc:	008b8913          	add	s2,s7,8
 7e0:	4685                	li	a3,1
 7e2:	4629                	li	a2,10
 7e4:	000bb583          	ld	a1,0(s7)
 7e8:	855a                	mv	a0,s6
 7ea:	e47ff0ef          	jal	630 <printint>
        i += 1;
 7ee:	2485                	addw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 7f0:	8bca                	mv	s7,s2
      state = 0;
 7f2:	4981                	li	s3,0
        i += 1;
 7f4:	b70d                	j	716 <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 7f6:	06400793          	li	a5,100
 7fa:	02f60763          	beq	a2,a5,828 <vprintf+0x15c>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 7fe:	07500793          	li	a5,117
 802:	06f60963          	beq	a2,a5,874 <vprintf+0x1a8>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 806:	07800793          	li	a5,120
 80a:	faf61ee3          	bne	a2,a5,7c6 <vprintf+0xfa>
        printint(fd, va_arg(ap, uint64), 16, 0);
 80e:	008b8913          	add	s2,s7,8
 812:	4681                	li	a3,0
 814:	4641                	li	a2,16
 816:	000bb583          	ld	a1,0(s7)
 81a:	855a                	mv	a0,s6
 81c:	e15ff0ef          	jal	630 <printint>
        i += 2;
 820:	2489                	addw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 822:	8bca                	mv	s7,s2
      state = 0;
 824:	4981                	li	s3,0
        i += 2;
 826:	bdc5                	j	716 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 828:	008b8913          	add	s2,s7,8
 82c:	4685                	li	a3,1
 82e:	4629                	li	a2,10
 830:	000bb583          	ld	a1,0(s7)
 834:	855a                	mv	a0,s6
 836:	dfbff0ef          	jal	630 <printint>
        i += 2;
 83a:	2489                	addw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 83c:	8bca                	mv	s7,s2
      state = 0;
 83e:	4981                	li	s3,0
        i += 2;
 840:	bdd9                	j	716 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint32), 10, 0);
 842:	008b8913          	add	s2,s7,8
 846:	4681                	li	a3,0
 848:	4629                	li	a2,10
 84a:	000be583          	lwu	a1,0(s7)
 84e:	855a                	mv	a0,s6
 850:	de1ff0ef          	jal	630 <printint>
 854:	8bca                	mv	s7,s2
      state = 0;
 856:	4981                	li	s3,0
 858:	bd7d                	j	716 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 85a:	008b8913          	add	s2,s7,8
 85e:	4681                	li	a3,0
 860:	4629                	li	a2,10
 862:	000bb583          	ld	a1,0(s7)
 866:	855a                	mv	a0,s6
 868:	dc9ff0ef          	jal	630 <printint>
        i += 1;
 86c:	2485                	addw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 86e:	8bca                	mv	s7,s2
      state = 0;
 870:	4981                	li	s3,0
        i += 1;
 872:	b555                	j	716 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 874:	008b8913          	add	s2,s7,8
 878:	4681                	li	a3,0
 87a:	4629                	li	a2,10
 87c:	000bb583          	ld	a1,0(s7)
 880:	855a                	mv	a0,s6
 882:	dafff0ef          	jal	630 <printint>
        i += 2;
 886:	2489                	addw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 888:	8bca                	mv	s7,s2
      state = 0;
 88a:	4981                	li	s3,0
        i += 2;
 88c:	b569                	j	716 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint32), 16, 0);
 88e:	008b8913          	add	s2,s7,8
 892:	4681                	li	a3,0
 894:	4641                	li	a2,16
 896:	000be583          	lwu	a1,0(s7)
 89a:	855a                	mv	a0,s6
 89c:	d95ff0ef          	jal	630 <printint>
 8a0:	8bca                	mv	s7,s2
      state = 0;
 8a2:	4981                	li	s3,0
 8a4:	bd8d                	j	716 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 16, 0);
 8a6:	008b8913          	add	s2,s7,8
 8aa:	4681                	li	a3,0
 8ac:	4641                	li	a2,16
 8ae:	000bb583          	ld	a1,0(s7)
 8b2:	855a                	mv	a0,s6
 8b4:	d7dff0ef          	jal	630 <printint>
        i += 1;
 8b8:	2485                	addw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 8ba:	8bca                	mv	s7,s2
      state = 0;
 8bc:	4981                	li	s3,0
        i += 1;
 8be:	bda1                	j	716 <vprintf+0x4a>
 8c0:	e06a                	sd	s10,0(sp)
        printptr(fd, va_arg(ap, uint64));
 8c2:	008b8d13          	add	s10,s7,8
 8c6:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 8ca:	03000593          	li	a1,48
 8ce:	855a                	mv	a0,s6
 8d0:	d43ff0ef          	jal	612 <putc>
  putc(fd, 'x');
 8d4:	07800593          	li	a1,120
 8d8:	855a                	mv	a0,s6
 8da:	d39ff0ef          	jal	612 <putc>
 8de:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 8e0:	00000b97          	auipc	s7,0x0
 8e4:	2c0b8b93          	add	s7,s7,704 # ba0 <digits>
 8e8:	03c9d793          	srl	a5,s3,0x3c
 8ec:	97de                	add	a5,a5,s7
 8ee:	0007c583          	lbu	a1,0(a5)
 8f2:	855a                	mv	a0,s6
 8f4:	d1fff0ef          	jal	612 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 8f8:	0992                	sll	s3,s3,0x4
 8fa:	397d                	addw	s2,s2,-1
 8fc:	fe0916e3          	bnez	s2,8e8 <vprintf+0x21c>
        printptr(fd, va_arg(ap, uint64));
 900:	8bea                	mv	s7,s10
      state = 0;
 902:	4981                	li	s3,0
 904:	6d02                	ld	s10,0(sp)
 906:	bd01                	j	716 <vprintf+0x4a>
        putc(fd, va_arg(ap, uint32));
 908:	008b8913          	add	s2,s7,8
 90c:	000bc583          	lbu	a1,0(s7)
 910:	855a                	mv	a0,s6
 912:	d01ff0ef          	jal	612 <putc>
 916:	8bca                	mv	s7,s2
      state = 0;
 918:	4981                	li	s3,0
 91a:	bbf5                	j	716 <vprintf+0x4a>
        if((s = va_arg(ap, char*)) == 0)
 91c:	008b8993          	add	s3,s7,8
 920:	000bb903          	ld	s2,0(s7)
 924:	00090f63          	beqz	s2,942 <vprintf+0x276>
        for(; *s; s++)
 928:	00094583          	lbu	a1,0(s2)
 92c:	c195                	beqz	a1,950 <vprintf+0x284>
          putc(fd, *s);
 92e:	855a                	mv	a0,s6
 930:	ce3ff0ef          	jal	612 <putc>
        for(; *s; s++)
 934:	0905                	add	s2,s2,1
 936:	00094583          	lbu	a1,0(s2)
 93a:	f9f5                	bnez	a1,92e <vprintf+0x262>
        if((s = va_arg(ap, char*)) == 0)
 93c:	8bce                	mv	s7,s3
      state = 0;
 93e:	4981                	li	s3,0
 940:	bbd9                	j	716 <vprintf+0x4a>
          s = "(null)";
 942:	00000917          	auipc	s2,0x0
 946:	25690913          	add	s2,s2,598 # b98 <malloc+0x14a>
        for(; *s; s++)
 94a:	02800593          	li	a1,40
 94e:	b7c5                	j	92e <vprintf+0x262>
        if((s = va_arg(ap, char*)) == 0)
 950:	8bce                	mv	s7,s3
      state = 0;
 952:	4981                	li	s3,0
 954:	b3c9                	j	716 <vprintf+0x4a>
 956:	64a6                	ld	s1,72(sp)
 958:	79e2                	ld	s3,56(sp)
 95a:	7a42                	ld	s4,48(sp)
 95c:	7aa2                	ld	s5,40(sp)
 95e:	7b02                	ld	s6,32(sp)
 960:	6be2                	ld	s7,24(sp)
 962:	6c42                	ld	s8,16(sp)
 964:	6ca2                	ld	s9,8(sp)
    }
  }
}
 966:	60e6                	ld	ra,88(sp)
 968:	6446                	ld	s0,80(sp)
 96a:	6906                	ld	s2,64(sp)
 96c:	6125                	add	sp,sp,96
 96e:	8082                	ret

0000000000000970 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 970:	715d                	add	sp,sp,-80
 972:	ec06                	sd	ra,24(sp)
 974:	e822                	sd	s0,16(sp)
 976:	1000                	add	s0,sp,32
 978:	e010                	sd	a2,0(s0)
 97a:	e414                	sd	a3,8(s0)
 97c:	e818                	sd	a4,16(s0)
 97e:	ec1c                	sd	a5,24(s0)
 980:	03043023          	sd	a6,32(s0)
 984:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 988:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 98c:	8622                	mv	a2,s0
 98e:	d3fff0ef          	jal	6cc <vprintf>
}
 992:	60e2                	ld	ra,24(sp)
 994:	6442                	ld	s0,16(sp)
 996:	6161                	add	sp,sp,80
 998:	8082                	ret

000000000000099a <printf>:

void
printf(const char *fmt, ...)
{
 99a:	711d                	add	sp,sp,-96
 99c:	ec06                	sd	ra,24(sp)
 99e:	e822                	sd	s0,16(sp)
 9a0:	1000                	add	s0,sp,32
 9a2:	e40c                	sd	a1,8(s0)
 9a4:	e810                	sd	a2,16(s0)
 9a6:	ec14                	sd	a3,24(s0)
 9a8:	f018                	sd	a4,32(s0)
 9aa:	f41c                	sd	a5,40(s0)
 9ac:	03043823          	sd	a6,48(s0)
 9b0:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 9b4:	00840613          	add	a2,s0,8
 9b8:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 9bc:	85aa                	mv	a1,a0
 9be:	4505                	li	a0,1
 9c0:	d0dff0ef          	jal	6cc <vprintf>
}
 9c4:	60e2                	ld	ra,24(sp)
 9c6:	6442                	ld	s0,16(sp)
 9c8:	6125                	add	sp,sp,96
 9ca:	8082                	ret

00000000000009cc <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 9cc:	1141                	add	sp,sp,-16
 9ce:	e422                	sd	s0,8(sp)
 9d0:	0800                	add	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 9d2:	ff050693          	add	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 9d6:	00000797          	auipc	a5,0x0
 9da:	62a7b783          	ld	a5,1578(a5) # 1000 <freep>
 9de:	a02d                	j	a08 <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 9e0:	4618                	lw	a4,8(a2)
 9e2:	9f2d                	addw	a4,a4,a1
 9e4:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 9e8:	6398                	ld	a4,0(a5)
 9ea:	6310                	ld	a2,0(a4)
 9ec:	a83d                	j	a2a <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 9ee:	ff852703          	lw	a4,-8(a0)
 9f2:	9f31                	addw	a4,a4,a2
 9f4:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 9f6:	ff053683          	ld	a3,-16(a0)
 9fa:	a091                	j	a3e <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 9fc:	6398                	ld	a4,0(a5)
 9fe:	00e7e463          	bltu	a5,a4,a06 <free+0x3a>
 a02:	00e6ea63          	bltu	a3,a4,a16 <free+0x4a>
{
 a06:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 a08:	fed7fae3          	bgeu	a5,a3,9fc <free+0x30>
 a0c:	6398                	ld	a4,0(a5)
 a0e:	00e6e463          	bltu	a3,a4,a16 <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 a12:	fee7eae3          	bltu	a5,a4,a06 <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 a16:	ff852583          	lw	a1,-8(a0)
 a1a:	6390                	ld	a2,0(a5)
 a1c:	02059813          	sll	a6,a1,0x20
 a20:	01c85713          	srl	a4,a6,0x1c
 a24:	9736                	add	a4,a4,a3
 a26:	fae60de3          	beq	a2,a4,9e0 <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 a2a:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 a2e:	4790                	lw	a2,8(a5)
 a30:	02061593          	sll	a1,a2,0x20
 a34:	01c5d713          	srl	a4,a1,0x1c
 a38:	973e                	add	a4,a4,a5
 a3a:	fae68ae3          	beq	a3,a4,9ee <free+0x22>
    p->s.ptr = bp->s.ptr;
 a3e:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 a40:	00000717          	auipc	a4,0x0
 a44:	5cf73023          	sd	a5,1472(a4) # 1000 <freep>
}
 a48:	6422                	ld	s0,8(sp)
 a4a:	0141                	add	sp,sp,16
 a4c:	8082                	ret

0000000000000a4e <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 a4e:	7139                	add	sp,sp,-64
 a50:	fc06                	sd	ra,56(sp)
 a52:	f822                	sd	s0,48(sp)
 a54:	f426                	sd	s1,40(sp)
 a56:	ec4e                	sd	s3,24(sp)
 a58:	0080                	add	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 a5a:	02051493          	sll	s1,a0,0x20
 a5e:	9081                	srl	s1,s1,0x20
 a60:	04bd                	add	s1,s1,15
 a62:	8091                	srl	s1,s1,0x4
 a64:	0014899b          	addw	s3,s1,1
 a68:	0485                	add	s1,s1,1
  if((prevp = freep) == 0){
 a6a:	00000517          	auipc	a0,0x0
 a6e:	59653503          	ld	a0,1430(a0) # 1000 <freep>
 a72:	c915                	beqz	a0,aa6 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a74:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 a76:	4798                	lw	a4,8(a5)
 a78:	08977a63          	bgeu	a4,s1,b0c <malloc+0xbe>
 a7c:	f04a                	sd	s2,32(sp)
 a7e:	e852                	sd	s4,16(sp)
 a80:	e456                	sd	s5,8(sp)
 a82:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 a84:	8a4e                	mv	s4,s3
 a86:	0009871b          	sext.w	a4,s3
 a8a:	6685                	lui	a3,0x1
 a8c:	00d77363          	bgeu	a4,a3,a92 <malloc+0x44>
 a90:	6a05                	lui	s4,0x1
 a92:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 a96:	004a1a1b          	sllw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 a9a:	00000917          	auipc	s2,0x0
 a9e:	56690913          	add	s2,s2,1382 # 1000 <freep>
  if(p == SBRK_ERROR)
 aa2:	5afd                	li	s5,-1
 aa4:	a081                	j	ae4 <malloc+0x96>
 aa6:	f04a                	sd	s2,32(sp)
 aa8:	e852                	sd	s4,16(sp)
 aaa:	e456                	sd	s5,8(sp)
 aac:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 aae:	00000797          	auipc	a5,0x0
 ab2:	76278793          	add	a5,a5,1890 # 1210 <base>
 ab6:	00000717          	auipc	a4,0x0
 aba:	54f73523          	sd	a5,1354(a4) # 1000 <freep>
 abe:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 ac0:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 ac4:	b7c1                	j	a84 <malloc+0x36>
        prevp->s.ptr = p->s.ptr;
 ac6:	6398                	ld	a4,0(a5)
 ac8:	e118                	sd	a4,0(a0)
 aca:	a8a9                	j	b24 <malloc+0xd6>
  hp->s.size = nu;
 acc:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 ad0:	0541                	add	a0,a0,16
 ad2:	efbff0ef          	jal	9cc <free>
  return freep;
 ad6:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 ada:	c12d                	beqz	a0,b3c <malloc+0xee>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 adc:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 ade:	4798                	lw	a4,8(a5)
 ae0:	02977263          	bgeu	a4,s1,b04 <malloc+0xb6>
    if(p == freep)
 ae4:	00093703          	ld	a4,0(s2)
 ae8:	853e                	mv	a0,a5
 aea:	fef719e3          	bne	a4,a5,adc <malloc+0x8e>
  p = sbrk(nu * sizeof(Header));
 aee:	8552                	mv	a0,s4
 af0:	967ff0ef          	jal	456 <sbrk>
  if(p == SBRK_ERROR)
 af4:	fd551ce3          	bne	a0,s5,acc <malloc+0x7e>
        return 0;
 af8:	4501                	li	a0,0
 afa:	7902                	ld	s2,32(sp)
 afc:	6a42                	ld	s4,16(sp)
 afe:	6aa2                	ld	s5,8(sp)
 b00:	6b02                	ld	s6,0(sp)
 b02:	a03d                	j	b30 <malloc+0xe2>
 b04:	7902                	ld	s2,32(sp)
 b06:	6a42                	ld	s4,16(sp)
 b08:	6aa2                	ld	s5,8(sp)
 b0a:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 b0c:	fae48de3          	beq	s1,a4,ac6 <malloc+0x78>
        p->s.size -= nunits;
 b10:	4137073b          	subw	a4,a4,s3
 b14:	c798                	sw	a4,8(a5)
        p += p->s.size;
 b16:	02071693          	sll	a3,a4,0x20
 b1a:	01c6d713          	srl	a4,a3,0x1c
 b1e:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 b20:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 b24:	00000717          	auipc	a4,0x0
 b28:	4ca73e23          	sd	a0,1244(a4) # 1000 <freep>
      return (void*)(p + 1);
 b2c:	01078513          	add	a0,a5,16
  }
}
 b30:	70e2                	ld	ra,56(sp)
 b32:	7442                	ld	s0,48(sp)
 b34:	74a2                	ld	s1,40(sp)
 b36:	69e2                	ld	s3,24(sp)
 b38:	6121                	add	sp,sp,64
 b3a:	8082                	ret
 b3c:	7902                	ld	s2,32(sp)
 b3e:	6a42                	ld	s4,16(sp)
 b40:	6aa2                	ld	s5,8(sp)
 b42:	6b02                	ld	s6,0(sp)
 b44:	b7f5                	j	b30 <malloc+0xe2>
