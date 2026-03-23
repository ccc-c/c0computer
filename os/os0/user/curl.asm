
user/_curl:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/types.h"
#include "user/user.h"
#include "kernel/net/socket.h"

int main(int argc, char *argv[])
{
   0:	7129                	add	sp,sp,-320
   2:	fe06                	sd	ra,312(sp)
   4:	fa22                	sd	s0,304(sp)
   6:	f626                	sd	s1,296(sp)
   8:	f24a                	sd	s2,288(sp)
   a:	ee4e                	sd	s3,280(sp)
   c:	0280                	add	s0,sp,320
   e:	72fd                	lui	t0,0xfffff
  10:	9116                	add	sp,sp,t0
    char buf[4096];
    char request[256];
    int i, port = 8080;
    char *host = "192.0.2.2";

    if (argc > 1) {
  12:	4785                	li	a5,1
  14:	00a7df63          	bge	a5,a0,32 <main+0x32>
        host = argv[1];
  18:	6584                	ld	s1,8(a1)
    }
    if (argc > 2) {
  1a:	4789                	li	a5,2
  1c:	00a7c663          	blt	a5,a0,28 <main+0x28>
    int i, port = 8080;
  20:	6989                	lui	s3,0x2
  22:	f9098993          	add	s3,s3,-112 # 1f90 <base+0xf80>
  26:	a829                	j	40 <main+0x40>
        port = atoi(argv[2]);
  28:	6988                	ld	a0,16(a1)
  2a:	3ac000ef          	jal	3d6 <atoi>
  2e:	89aa                	mv	s3,a0
  30:	a801                	j	40 <main+0x40>
    char *host = "192.0.2.2";
  32:	00001497          	auipc	s1,0x1
  36:	d1e48493          	add	s1,s1,-738 # d50 <malloc+0xe6>
    int i, port = 8080;
  3a:	6989                	lui	s3,0x2
  3c:	f9098993          	add	s3,s3,-112 # 1f90 <base+0xf80>
    }

    printf("curl: connecting to %s:%d\n", host, port);
  40:	864e                	mv	a2,s3
  42:	85a6                	mv	a1,s1
  44:	00001517          	auipc	a0,0x1
  48:	d1c50513          	add	a0,a0,-740 # d60 <malloc+0xf6>
  4c:	36b000ef          	jal	bb6 <printf>

    soc = socket(PF_INET, SOCK_STREAM, IPPROTO_TCP);
  50:	4601                	li	a2,0
  52:	4589                	li	a1,2
  54:	4505                	li	a0,1
  56:	796000ef          	jal	7ec <socket>
  5a:	892a                	mv	s2,a0
    if (soc == -1) {
  5c:	57fd                	li	a5,-1
  5e:	1af50963          	beq	a0,a5,210 <main+0x210>
        printf("curl: socket failed\n");
        exit(1);
    }
    printf("curl: socket created\n");
  62:	00001517          	auipc	a0,0x1
  66:	d3650513          	add	a0,a0,-714 # d98 <malloc+0x12e>
  6a:	34d000ef          	jal	bb6 <printf>

    server.sin_family = AF_INET;
  6e:	4785                	li	a5,1
  70:	fcf41423          	sh	a5,-56(s0)
    server.sin_port = htons(port);
  74:	03099513          	sll	a0,s3,0x30
  78:	9141                	srl	a0,a0,0x30
  7a:	44a000ef          	jal	4c4 <htons>
  7e:	fca41523          	sh	a0,-54(s0)
    inet_pton(AF_INET, host, &server.sin_addr);
  82:	fcc40613          	add	a2,s0,-52
  86:	85a6                	mv	a1,s1
  88:	4505                	li	a0,1
  8a:	624000ef          	jal	6ae <inet_pton>

    printf("curl: calling connect...\n");
  8e:	00001517          	auipc	a0,0x1
  92:	d2250513          	add	a0,a0,-734 # db0 <malloc+0x146>
  96:	321000ef          	jal	bb6 <printf>
    if (connect(soc, (struct sockaddr *)&server, sizeof(server)) == -1) {
  9a:	4621                	li	a2,8
  9c:	fc840593          	add	a1,s0,-56
  a0:	854a                	mv	a0,s2
  a2:	76a000ef          	jal	80c <connect>
  a6:	57fd                	li	a5,-1
  a8:	16f50d63          	beq	a0,a5,222 <main+0x222>
        printf("curl: connect failed\n");
        close(soc);
        exit(1);
    }
    printf("curl: connected!\n");
  ac:	00001517          	auipc	a0,0x1
  b0:	d3c50513          	add	a0,a0,-708 # de8 <malloc+0x17e>
  b4:	303000ef          	jal	bb6 <printf>

    i = 0;
    request[i++] = 'G';
  b8:	77fd                	lui	a5,0xfffff
  ba:	fd078793          	add	a5,a5,-48 # ffffffffffffefd0 <base+0xffffffffffffdfc0>
  be:	97a2                	add	a5,a5,s0
  c0:	04700713          	li	a4,71
  c4:	eee78c23          	sb	a4,-264(a5)
    request[i++] = 'E';
  c8:	04500713          	li	a4,69
  cc:	eee78ca3          	sb	a4,-263(a5)
    request[i++] = 'T';
  d0:	05400693          	li	a3,84
  d4:	eed78d23          	sb	a3,-262(a5)
    request[i++] = ' ';
  d8:	02000713          	li	a4,32
  dc:	eee78da3          	sb	a4,-261(a5)
    request[i++] = '/';
  e0:	02f00593          	li	a1,47
  e4:	eeb78e23          	sb	a1,-260(a5)
    request[i++] = ' ';
  e8:	eee78ea3          	sb	a4,-259(a5)
    request[i++] = 'H';
  ec:	04800613          	li	a2,72
  f0:	eec78f23          	sb	a2,-258(a5)
    request[i++] = 'T';
  f4:	eed78fa3          	sb	a3,-257(a5)
    request[i++] = 'T';
  f8:	f0d78023          	sb	a3,-256(a5)
    request[i++] = 'P';
  fc:	05000693          	li	a3,80
 100:	f0d780a3          	sb	a3,-255(a5)
    request[i++] = '/';
 104:	f0b78123          	sb	a1,-254(a5)
    request[i++] = '1';
 108:	03100693          	li	a3,49
 10c:	f0d781a3          	sb	a3,-253(a5)
    request[i++] = '.';
 110:	02e00593          	li	a1,46
 114:	f0b78223          	sb	a1,-252(a5)
    request[i++] = '1';
 118:	f0d782a3          	sb	a3,-251(a5)
    request[i++] = '\r';
 11c:	46b5                	li	a3,13
 11e:	f0d78323          	sb	a3,-250(a5)
    request[i++] = '\n';
 122:	46a9                	li	a3,10
 124:	f0d783a3          	sb	a3,-249(a5)
    request[i++] = 'H';
 128:	f0c78423          	sb	a2,-248(a5)
    request[i++] = 'o';
 12c:	06f00693          	li	a3,111
 130:	f0d784a3          	sb	a3,-247(a5)
    request[i++] = 's';
 134:	07300693          	li	a3,115
 138:	f0d78523          	sb	a3,-246(a5)
    request[i++] = 't';
 13c:	07400693          	li	a3,116
 140:	f0d785a3          	sb	a3,-245(a5)
    request[i++] = ':';
 144:	03a00693          	li	a3,58
 148:	f0d78623          	sb	a3,-244(a5)
    request[i++] = ' ';
 14c:	f0e786a3          	sb	a4,-243(a5)
    {
        char *h = host;
        while (*h && i < 250) {
 150:	0004c703          	lbu	a4,0(s1)
 154:	0e070363          	beqz	a4,23a <main+0x23a>
 158:	47dd                	li	a5,23
            request[i++] = *h++;
 15a:	75fd                	lui	a1,0xfffff
 15c:	ec858693          	add	a3,a1,-312 # ffffffffffffeec8 <base+0xffffffffffffdeb8>
 160:	008685b3          	add	a1,a3,s0
        while (*h && i < 250) {
 164:	0fb00513          	li	a0,251
            request[i++] = *h++;
 168:	0007861b          	sext.w	a2,a5
 16c:	00f586b3          	add	a3,a1,a5
 170:	fee68fa3          	sb	a4,-1(a3)
        while (*h && i < 250) {
 174:	00f48733          	add	a4,s1,a5
 178:	fea74703          	lbu	a4,-22(a4)
 17c:	c701                	beqz	a4,184 <main+0x184>
 17e:	0785                	add	a5,a5,1
 180:	fea794e3          	bne	a5,a0,168 <main+0x168>
        }
    }
    request[i++] = '\r';
 184:	74fd                	lui	s1,0xfffff
 186:	79fd                	lui	s3,0xfffff
 188:	fd098793          	add	a5,s3,-48 # ffffffffffffefd0 <base+0xffffffffffffdfc0>
 18c:	97a2                	add	a5,a5,s0
 18e:	97b2                	add	a5,a5,a2
 190:	46b5                	li	a3,13
 192:	eed78c23          	sb	a3,-264(a5)
    request[i++] = '\n';
 196:	0016079b          	addw	a5,a2,1
 19a:	fd098713          	add	a4,s3,-48
 19e:	9722                	add	a4,a4,s0
 1a0:	97ba                	add	a5,a5,a4
 1a2:	4729                	li	a4,10
 1a4:	eee78c23          	sb	a4,-264(a5)
    request[i++] = '\r';
 1a8:	0026079b          	addw	a5,a2,2
 1ac:	fd098593          	add	a1,s3,-48
 1b0:	95a2                	add	a1,a1,s0
 1b2:	97ae                	add	a5,a5,a1
 1b4:	eed78c23          	sb	a3,-264(a5)
    request[i++] = '\n';
 1b8:	0036079b          	addw	a5,a2,3
 1bc:	97ae                	add	a5,a5,a1
 1be:	eee78c23          	sb	a4,-264(a5)
    
    send(soc, request, i);
 1c2:	2611                	addw	a2,a2,4
 1c4:	ec848793          	add	a5,s1,-312 # ffffffffffffeec8 <base+0xffffffffffffdeb8>
 1c8:	008785b3          	add	a1,a5,s0
 1cc:	854a                	mv	a0,s2
 1ce:	65e000ef          	jal	82c <send>
    printf("curl: request sent\n");
 1d2:	00001517          	auipc	a0,0x1
 1d6:	c2e50513          	add	a0,a0,-978 # e00 <malloc+0x196>
 1da:	1dd000ef          	jal	bb6 <printf>

    int n = recv(soc, buf, sizeof(buf) - 1);
 1de:	6605                	lui	a2,0x1
 1e0:	167d                	add	a2,a2,-1 # fff <digits+0x1b7>
 1e2:	fc848793          	add	a5,s1,-56
 1e6:	008785b3          	add	a1,a5,s0
 1ea:	854a                	mv	a0,s2
 1ec:	638000ef          	jal	824 <recv>
 1f0:	84aa                	mv	s1,a0
    printf("curl: received %d bytes\n", n);
 1f2:	85aa                	mv	a1,a0
 1f4:	00001517          	auipc	a0,0x1
 1f8:	c2450513          	add	a0,a0,-988 # e18 <malloc+0x1ae>
 1fc:	1bb000ef          	jal	bb6 <printf>
    if (n > 0) {
 200:	02904f63          	bgtz	s1,23e <main+0x23e>
        buf[n] = '\0';
        printf("%s\n", buf);
    }

    close(soc);
 204:	854a                	mv	a0,s2
 206:	56e000ef          	jal	774 <close>
    exit(0);
 20a:	4501                	li	a0,0
 20c:	540000ef          	jal	74c <exit>
        printf("curl: socket failed\n");
 210:	00001517          	auipc	a0,0x1
 214:	b7050513          	add	a0,a0,-1168 # d80 <malloc+0x116>
 218:	19f000ef          	jal	bb6 <printf>
        exit(1);
 21c:	4505                	li	a0,1
 21e:	52e000ef          	jal	74c <exit>
        printf("curl: connect failed\n");
 222:	00001517          	auipc	a0,0x1
 226:	bae50513          	add	a0,a0,-1106 # dd0 <malloc+0x166>
 22a:	18d000ef          	jal	bb6 <printf>
        close(soc);
 22e:	854a                	mv	a0,s2
 230:	544000ef          	jal	774 <close>
        exit(1);
 234:	4505                	li	a0,1
 236:	516000ef          	jal	74c <exit>
    request[i++] = ' ';
 23a:	4659                	li	a2,22
 23c:	b7a1                	j	184 <main+0x184>
        buf[n] = '\0';
 23e:	75fd                	lui	a1,0xfffff
 240:	fd098793          	add	a5,s3,-48
 244:	97a2                	add	a5,a5,s0
 246:	97a6                	add	a5,a5,s1
 248:	fe078c23          	sb	zero,-8(a5)
        printf("%s\n", buf);
 24c:	fc858793          	add	a5,a1,-56 # ffffffffffffefc8 <base+0xffffffffffffdfb8>
 250:	008785b3          	add	a1,a5,s0
 254:	00001517          	auipc	a0,0x1
 258:	be450513          	add	a0,a0,-1052 # e38 <malloc+0x1ce>
 25c:	15b000ef          	jal	bb6 <printf>
 260:	b755                	j	204 <main+0x204>

0000000000000262 <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start()
{
 262:	1141                	add	sp,sp,-16
 264:	e406                	sd	ra,8(sp)
 266:	e022                	sd	s0,0(sp)
 268:	0800                	add	s0,sp,16
  extern int main();
  main();
 26a:	d97ff0ef          	jal	0 <main>
  exit(0);
 26e:	4501                	li	a0,0
 270:	4dc000ef          	jal	74c <exit>

0000000000000274 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
 274:	1141                	add	sp,sp,-16
 276:	e422                	sd	s0,8(sp)
 278:	0800                	add	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 27a:	87aa                	mv	a5,a0
 27c:	0585                	add	a1,a1,1
 27e:	0785                	add	a5,a5,1
 280:	fff5c703          	lbu	a4,-1(a1)
 284:	fee78fa3          	sb	a4,-1(a5)
 288:	fb75                	bnez	a4,27c <strcpy+0x8>
    ;
  return os;
}
 28a:	6422                	ld	s0,8(sp)
 28c:	0141                	add	sp,sp,16
 28e:	8082                	ret

0000000000000290 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 290:	1141                	add	sp,sp,-16
 292:	e422                	sd	s0,8(sp)
 294:	0800                	add	s0,sp,16
  while(*p && *p == *q)
 296:	00054783          	lbu	a5,0(a0)
 29a:	cb91                	beqz	a5,2ae <strcmp+0x1e>
 29c:	0005c703          	lbu	a4,0(a1)
 2a0:	00f71763          	bne	a4,a5,2ae <strcmp+0x1e>
    p++, q++;
 2a4:	0505                	add	a0,a0,1
 2a6:	0585                	add	a1,a1,1
  while(*p && *p == *q)
 2a8:	00054783          	lbu	a5,0(a0)
 2ac:	fbe5                	bnez	a5,29c <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 2ae:	0005c503          	lbu	a0,0(a1)
}
 2b2:	40a7853b          	subw	a0,a5,a0
 2b6:	6422                	ld	s0,8(sp)
 2b8:	0141                	add	sp,sp,16
 2ba:	8082                	ret

00000000000002bc <strlen>:

uint
strlen(const char *s)
{
 2bc:	1141                	add	sp,sp,-16
 2be:	e422                	sd	s0,8(sp)
 2c0:	0800                	add	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 2c2:	00054783          	lbu	a5,0(a0)
 2c6:	cf91                	beqz	a5,2e2 <strlen+0x26>
 2c8:	0505                	add	a0,a0,1
 2ca:	87aa                	mv	a5,a0
 2cc:	86be                	mv	a3,a5
 2ce:	0785                	add	a5,a5,1
 2d0:	fff7c703          	lbu	a4,-1(a5)
 2d4:	ff65                	bnez	a4,2cc <strlen+0x10>
 2d6:	40a6853b          	subw	a0,a3,a0
 2da:	2505                	addw	a0,a0,1
    ;
  return n;
}
 2dc:	6422                	ld	s0,8(sp)
 2de:	0141                	add	sp,sp,16
 2e0:	8082                	ret
  for(n = 0; s[n]; n++)
 2e2:	4501                	li	a0,0
 2e4:	bfe5                	j	2dc <strlen+0x20>

00000000000002e6 <memset>:

void*
memset(void *dst, int c, uint n)
{
 2e6:	1141                	add	sp,sp,-16
 2e8:	e422                	sd	s0,8(sp)
 2ea:	0800                	add	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 2ec:	ca19                	beqz	a2,302 <memset+0x1c>
 2ee:	87aa                	mv	a5,a0
 2f0:	1602                	sll	a2,a2,0x20
 2f2:	9201                	srl	a2,a2,0x20
 2f4:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 2f8:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 2fc:	0785                	add	a5,a5,1
 2fe:	fee79de3          	bne	a5,a4,2f8 <memset+0x12>
  }
  return dst;
}
 302:	6422                	ld	s0,8(sp)
 304:	0141                	add	sp,sp,16
 306:	8082                	ret

0000000000000308 <strchr>:

char*
strchr(const char *s, char c)
{
 308:	1141                	add	sp,sp,-16
 30a:	e422                	sd	s0,8(sp)
 30c:	0800                	add	s0,sp,16
  for(; *s; s++)
 30e:	00054783          	lbu	a5,0(a0)
 312:	cb99                	beqz	a5,328 <strchr+0x20>
    if(*s == c)
 314:	00f58763          	beq	a1,a5,322 <strchr+0x1a>
  for(; *s; s++)
 318:	0505                	add	a0,a0,1
 31a:	00054783          	lbu	a5,0(a0)
 31e:	fbfd                	bnez	a5,314 <strchr+0xc>
      return (char*)s;
  return 0;
 320:	4501                	li	a0,0
}
 322:	6422                	ld	s0,8(sp)
 324:	0141                	add	sp,sp,16
 326:	8082                	ret
  return 0;
 328:	4501                	li	a0,0
 32a:	bfe5                	j	322 <strchr+0x1a>

000000000000032c <gets>:

char*
gets(char *buf, int max)
{
 32c:	711d                	add	sp,sp,-96
 32e:	ec86                	sd	ra,88(sp)
 330:	e8a2                	sd	s0,80(sp)
 332:	e4a6                	sd	s1,72(sp)
 334:	e0ca                	sd	s2,64(sp)
 336:	fc4e                	sd	s3,56(sp)
 338:	f852                	sd	s4,48(sp)
 33a:	f456                	sd	s5,40(sp)
 33c:	f05a                	sd	s6,32(sp)
 33e:	ec5e                	sd	s7,24(sp)
 340:	1080                	add	s0,sp,96
 342:	8baa                	mv	s7,a0
 344:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 346:	892a                	mv	s2,a0
 348:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 34a:	4aa9                	li	s5,10
 34c:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 34e:	89a6                	mv	s3,s1
 350:	2485                	addw	s1,s1,1
 352:	0344d663          	bge	s1,s4,37e <gets+0x52>
    cc = read(0, &c, 1);
 356:	4605                	li	a2,1
 358:	faf40593          	add	a1,s0,-81
 35c:	4501                	li	a0,0
 35e:	406000ef          	jal	764 <read>
    if(cc < 1)
 362:	00a05e63          	blez	a0,37e <gets+0x52>
    buf[i++] = c;
 366:	faf44783          	lbu	a5,-81(s0)
 36a:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 36e:	01578763          	beq	a5,s5,37c <gets+0x50>
 372:	0905                	add	s2,s2,1
 374:	fd679de3          	bne	a5,s6,34e <gets+0x22>
  for(i=0; i+1 < max; ){
 378:	89a6                	mv	s3,s1
 37a:	a011                	j	37e <gets+0x52>
 37c:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 37e:	99de                	add	s3,s3,s7
 380:	00098023          	sb	zero,0(s3)
  return buf;
}
 384:	855e                	mv	a0,s7
 386:	60e6                	ld	ra,88(sp)
 388:	6446                	ld	s0,80(sp)
 38a:	64a6                	ld	s1,72(sp)
 38c:	6906                	ld	s2,64(sp)
 38e:	79e2                	ld	s3,56(sp)
 390:	7a42                	ld	s4,48(sp)
 392:	7aa2                	ld	s5,40(sp)
 394:	7b02                	ld	s6,32(sp)
 396:	6be2                	ld	s7,24(sp)
 398:	6125                	add	sp,sp,96
 39a:	8082                	ret

000000000000039c <stat>:

int
stat(const char *n, struct stat *st)
{
 39c:	1101                	add	sp,sp,-32
 39e:	ec06                	sd	ra,24(sp)
 3a0:	e822                	sd	s0,16(sp)
 3a2:	e426                	sd	s1,8(sp)
 3a4:	e04a                	sd	s2,0(sp)
 3a6:	1000                	add	s0,sp,32
 3a8:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 3aa:	4581                	li	a1,0
 3ac:	3e0000ef          	jal	78c <open>
  if(fd < 0)
 3b0:	02054163          	bltz	a0,3d2 <stat+0x36>
 3b4:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 3b6:	85ca                	mv	a1,s2
 3b8:	3ec000ef          	jal	7a4 <fstat>
 3bc:	892a                	mv	s2,a0
  close(fd);
 3be:	8526                	mv	a0,s1
 3c0:	3b4000ef          	jal	774 <close>
  return r;
}
 3c4:	854a                	mv	a0,s2
 3c6:	60e2                	ld	ra,24(sp)
 3c8:	6442                	ld	s0,16(sp)
 3ca:	64a2                	ld	s1,8(sp)
 3cc:	6902                	ld	s2,0(sp)
 3ce:	6105                	add	sp,sp,32
 3d0:	8082                	ret
    return -1;
 3d2:	597d                	li	s2,-1
 3d4:	bfc5                	j	3c4 <stat+0x28>

00000000000003d6 <atoi>:

int
atoi(const char *s)
{
 3d6:	1141                	add	sp,sp,-16
 3d8:	e422                	sd	s0,8(sp)
 3da:	0800                	add	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 3dc:	00054683          	lbu	a3,0(a0)
 3e0:	fd06879b          	addw	a5,a3,-48
 3e4:	0ff7f793          	zext.b	a5,a5
 3e8:	4625                	li	a2,9
 3ea:	02f66863          	bltu	a2,a5,41a <atoi+0x44>
 3ee:	872a                	mv	a4,a0
  n = 0;
 3f0:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 3f2:	0705                	add	a4,a4,1
 3f4:	0025179b          	sllw	a5,a0,0x2
 3f8:	9fa9                	addw	a5,a5,a0
 3fa:	0017979b          	sllw	a5,a5,0x1
 3fe:	9fb5                	addw	a5,a5,a3
 400:	fd07851b          	addw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 404:	00074683          	lbu	a3,0(a4)
 408:	fd06879b          	addw	a5,a3,-48
 40c:	0ff7f793          	zext.b	a5,a5
 410:	fef671e3          	bgeu	a2,a5,3f2 <atoi+0x1c>
  return n;
}
 414:	6422                	ld	s0,8(sp)
 416:	0141                	add	sp,sp,16
 418:	8082                	ret
  n = 0;
 41a:	4501                	li	a0,0
 41c:	bfe5                	j	414 <atoi+0x3e>

000000000000041e <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 41e:	1141                	add	sp,sp,-16
 420:	e422                	sd	s0,8(sp)
 422:	0800                	add	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 424:	02b57463          	bgeu	a0,a1,44c <memmove+0x2e>
    while(n-- > 0)
 428:	00c05f63          	blez	a2,446 <memmove+0x28>
 42c:	1602                	sll	a2,a2,0x20
 42e:	9201                	srl	a2,a2,0x20
 430:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 434:	872a                	mv	a4,a0
      *dst++ = *src++;
 436:	0585                	add	a1,a1,1
 438:	0705                	add	a4,a4,1
 43a:	fff5c683          	lbu	a3,-1(a1)
 43e:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 442:	fee79ae3          	bne	a5,a4,436 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 446:	6422                	ld	s0,8(sp)
 448:	0141                	add	sp,sp,16
 44a:	8082                	ret
    dst += n;
 44c:	00c50733          	add	a4,a0,a2
    src += n;
 450:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 452:	fec05ae3          	blez	a2,446 <memmove+0x28>
 456:	fff6079b          	addw	a5,a2,-1
 45a:	1782                	sll	a5,a5,0x20
 45c:	9381                	srl	a5,a5,0x20
 45e:	fff7c793          	not	a5,a5
 462:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 464:	15fd                	add	a1,a1,-1
 466:	177d                	add	a4,a4,-1
 468:	0005c683          	lbu	a3,0(a1)
 46c:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 470:	fee79ae3          	bne	a5,a4,464 <memmove+0x46>
 474:	bfc9                	j	446 <memmove+0x28>

0000000000000476 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 476:	1141                	add	sp,sp,-16
 478:	e422                	sd	s0,8(sp)
 47a:	0800                	add	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 47c:	ca05                	beqz	a2,4ac <memcmp+0x36>
 47e:	fff6069b          	addw	a3,a2,-1
 482:	1682                	sll	a3,a3,0x20
 484:	9281                	srl	a3,a3,0x20
 486:	0685                	add	a3,a3,1
 488:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 48a:	00054783          	lbu	a5,0(a0)
 48e:	0005c703          	lbu	a4,0(a1)
 492:	00e79863          	bne	a5,a4,4a2 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 496:	0505                	add	a0,a0,1
    p2++;
 498:	0585                	add	a1,a1,1
  while (n-- > 0) {
 49a:	fed518e3          	bne	a0,a3,48a <memcmp+0x14>
  }
  return 0;
 49e:	4501                	li	a0,0
 4a0:	a019                	j	4a6 <memcmp+0x30>
      return *p1 - *p2;
 4a2:	40e7853b          	subw	a0,a5,a4
}
 4a6:	6422                	ld	s0,8(sp)
 4a8:	0141                	add	sp,sp,16
 4aa:	8082                	ret
  return 0;
 4ac:	4501                	li	a0,0
 4ae:	bfe5                	j	4a6 <memcmp+0x30>

00000000000004b0 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 4b0:	1141                	add	sp,sp,-16
 4b2:	e406                	sd	ra,8(sp)
 4b4:	e022                	sd	s0,0(sp)
 4b6:	0800                	add	s0,sp,16
  return memmove(dst, src, n);
 4b8:	f67ff0ef          	jal	41e <memmove>
}
 4bc:	60a2                	ld	ra,8(sp)
 4be:	6402                	ld	s0,0(sp)
 4c0:	0141                	add	sp,sp,16
 4c2:	8082                	ret

00000000000004c4 <htons>:
    return (v & 0x000000ff) << 24 | (v & 0x0000ff00) << 8 | (v & 0x00ff0000) >> 8 | (v & 0xff000000) >> 24;
}

uint16_t
htons(uint16_t h)
{
 4c4:	1141                	add	sp,sp,-16
 4c6:	e422                	sd	s0,8(sp)
 4c8:	0800                	add	s0,sp,16
    if (!endian) {
 4ca:	00001797          	auipc	a5,0x1
 4ce:	b367a783          	lw	a5,-1226(a5) # 1000 <endian>
 4d2:	e385                	bnez	a5,4f2 <htons+0x2e>
        endian = byteorder();
 4d4:	4d200793          	li	a5,1234
 4d8:	00001717          	auipc	a4,0x1
 4dc:	b2f72423          	sw	a5,-1240(a4) # 1000 <endian>
    return (v & 0x00ff) << 8 | (v & 0xff00 ) >> 8;
 4e0:	0085579b          	srlw	a5,a0,0x8
 4e4:	0085151b          	sllw	a0,a0,0x8
 4e8:	8fc9                	or	a5,a5,a0
 4ea:	03079513          	sll	a0,a5,0x30
 4ee:	9141                	srl	a0,a0,0x30
 4f0:	a029                	j	4fa <htons+0x36>
    }
    return endian == __LITTLE_ENDIAN ? byteswap16(h) : h;
 4f2:	4d200713          	li	a4,1234
 4f6:	fee785e3          	beq	a5,a4,4e0 <htons+0x1c>
}
 4fa:	6422                	ld	s0,8(sp)
 4fc:	0141                	add	sp,sp,16
 4fe:	8082                	ret

0000000000000500 <ntohs>:

uint16_t
ntohs(uint16_t n)
{
 500:	1141                	add	sp,sp,-16
 502:	e422                	sd	s0,8(sp)
 504:	0800                	add	s0,sp,16
    if (!endian) {
 506:	00001797          	auipc	a5,0x1
 50a:	afa7a783          	lw	a5,-1286(a5) # 1000 <endian>
 50e:	e385                	bnez	a5,52e <ntohs+0x2e>
        endian = byteorder();
 510:	4d200793          	li	a5,1234
 514:	00001717          	auipc	a4,0x1
 518:	aef72623          	sw	a5,-1300(a4) # 1000 <endian>
    return (v & 0x00ff) << 8 | (v & 0xff00 ) >> 8;
 51c:	0085579b          	srlw	a5,a0,0x8
 520:	0085151b          	sllw	a0,a0,0x8
 524:	8fc9                	or	a5,a5,a0
 526:	03079513          	sll	a0,a5,0x30
 52a:	9141                	srl	a0,a0,0x30
 52c:	a029                	j	536 <ntohs+0x36>
    }
    return endian == __LITTLE_ENDIAN ? byteswap16(n) : n;
 52e:	4d200713          	li	a4,1234
 532:	fee785e3          	beq	a5,a4,51c <ntohs+0x1c>
}
 536:	6422                	ld	s0,8(sp)
 538:	0141                	add	sp,sp,16
 53a:	8082                	ret

000000000000053c <htonl>:

uint32_t
htonl(uint32_t h)
{
 53c:	1141                	add	sp,sp,-16
 53e:	e422                	sd	s0,8(sp)
 540:	0800                	add	s0,sp,16
    if (!endian) {
 542:	00001797          	auipc	a5,0x1
 546:	abe7a783          	lw	a5,-1346(a5) # 1000 <endian>
 54a:	ef85                	bnez	a5,582 <htonl+0x46>
        endian = byteorder();
 54c:	4d200793          	li	a5,1234
 550:	00001717          	auipc	a4,0x1
 554:	aaf72823          	sw	a5,-1360(a4) # 1000 <endian>
    return (v & 0x000000ff) << 24 | (v & 0x0000ff00) << 8 | (v & 0x00ff0000) >> 8 | (v & 0xff000000) >> 24;
 558:	0185179b          	sllw	a5,a0,0x18
 55c:	0185571b          	srlw	a4,a0,0x18
 560:	8fd9                	or	a5,a5,a4
 562:	0085171b          	sllw	a4,a0,0x8
 566:	00ff06b7          	lui	a3,0xff0
 56a:	8f75                	and	a4,a4,a3
 56c:	8fd9                	or	a5,a5,a4
 56e:	0085551b          	srlw	a0,a0,0x8
 572:	6741                	lui	a4,0x10
 574:	f0070713          	add	a4,a4,-256 # ff00 <base+0xeef0>
 578:	8d79                	and	a0,a0,a4
 57a:	8fc9                	or	a5,a5,a0
 57c:	0007851b          	sext.w	a0,a5
 580:	a029                	j	58a <htonl+0x4e>
    }
    return endian == __LITTLE_ENDIAN ? byteswap32(h) : h;
 582:	4d200713          	li	a4,1234
 586:	fce789e3          	beq	a5,a4,558 <htonl+0x1c>
}
 58a:	6422                	ld	s0,8(sp)
 58c:	0141                	add	sp,sp,16
 58e:	8082                	ret

0000000000000590 <ntohl>:

uint32_t
ntohl(uint32_t n)
{
 590:	1141                	add	sp,sp,-16
 592:	e422                	sd	s0,8(sp)
 594:	0800                	add	s0,sp,16
    if (!endian) {
 596:	00001797          	auipc	a5,0x1
 59a:	a6a7a783          	lw	a5,-1430(a5) # 1000 <endian>
 59e:	ef85                	bnez	a5,5d6 <ntohl+0x46>
        endian = byteorder();
 5a0:	4d200793          	li	a5,1234
 5a4:	00001717          	auipc	a4,0x1
 5a8:	a4f72e23          	sw	a5,-1444(a4) # 1000 <endian>
    return (v & 0x000000ff) << 24 | (v & 0x0000ff00) << 8 | (v & 0x00ff0000) >> 8 | (v & 0xff000000) >> 24;
 5ac:	0185179b          	sllw	a5,a0,0x18
 5b0:	0185571b          	srlw	a4,a0,0x18
 5b4:	8fd9                	or	a5,a5,a4
 5b6:	0085171b          	sllw	a4,a0,0x8
 5ba:	00ff06b7          	lui	a3,0xff0
 5be:	8f75                	and	a4,a4,a3
 5c0:	8fd9                	or	a5,a5,a4
 5c2:	0085551b          	srlw	a0,a0,0x8
 5c6:	6741                	lui	a4,0x10
 5c8:	f0070713          	add	a4,a4,-256 # ff00 <base+0xeef0>
 5cc:	8d79                	and	a0,a0,a4
 5ce:	8fc9                	or	a5,a5,a0
 5d0:	0007851b          	sext.w	a0,a5
 5d4:	a029                	j	5de <ntohl+0x4e>
    }
    return endian == __LITTLE_ENDIAN ? byteswap32(n) : n;
 5d6:	4d200713          	li	a4,1234
 5da:	fce789e3          	beq	a5,a4,5ac <ntohl+0x1c>
}
 5de:	6422                	ld	s0,8(sp)
 5e0:	0141                	add	sp,sp,16
 5e2:	8082                	ret

00000000000005e4 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
 5e4:	1141                	add	sp,sp,-16
 5e6:	e422                	sd	s0,8(sp)
 5e8:	0800                	add	s0,sp,16
 5ea:	872a                	mv	a4,a0
    int neg = 0;
    long val = 0;

    // gobble initial whitespace
    while (*s == ' ' || *s == '\t')
 5ec:	02000693          	li	a3,32
 5f0:	4525                	li	a0,9
 5f2:	a011                	j	5f6 <strtol+0x12>
        s++;
 5f4:	0705                	add	a4,a4,1
    while (*s == ' ' || *s == '\t')
 5f6:	00074783          	lbu	a5,0(a4)
 5fa:	fed78de3          	beq	a5,a3,5f4 <strtol+0x10>
 5fe:	fea78be3          	beq	a5,a0,5f4 <strtol+0x10>

    // plus/minus sign
    if (*s == '+')
 602:	02b00693          	li	a3,43
 606:	02d78663          	beq	a5,a3,632 <strtol+0x4e>
        s++;
    else if (*s == '-')
 60a:	02d00693          	li	a3,45
    int neg = 0;
 60e:	4301                	li	t1,0
    else if (*s == '-')
 610:	02d78463          	beq	a5,a3,638 <strtol+0x54>
        s++, neg = 1;

    // hex or octal base prefix
    if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
 614:	fef67793          	and	a5,a2,-17
 618:	eb89                	bnez	a5,62a <strtol+0x46>
 61a:	00074683          	lbu	a3,0(a4)
 61e:	03000793          	li	a5,48
 622:	00f68e63          	beq	a3,a5,63e <strtol+0x5a>
        s += 2, base = 16;
    else if (base == 0 && s[0] == '0')
 626:	e211                	bnez	a2,62a <strtol+0x46>
        s++, base = 8;
    else if (base == 0)
        base = 10;
 628:	4629                	li	a2,10
 62a:	4501                	li	a0,0

    // digits
    while (1) {
        int dig;

        if (*s >= '0' && *s <= '9')
 62c:	4825                	li	a6,9
            dig = *s - '0';
        else if (*s >= 'a' && *s <= 'z')
 62e:	48e5                	li	a7,25
 630:	a825                	j	668 <strtol+0x84>
        s++;
 632:	0705                	add	a4,a4,1
    int neg = 0;
 634:	4301                	li	t1,0
 636:	bff9                	j	614 <strtol+0x30>
        s++, neg = 1;
 638:	0705                	add	a4,a4,1
 63a:	4305                	li	t1,1
 63c:	bfe1                	j	614 <strtol+0x30>
    if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
 63e:	00174683          	lbu	a3,1(a4)
 642:	07800793          	li	a5,120
 646:	00f68663          	beq	a3,a5,652 <strtol+0x6e>
    else if (base == 0 && s[0] == '0')
 64a:	f265                	bnez	a2,62a <strtol+0x46>
        s++, base = 8;
 64c:	0705                	add	a4,a4,1
 64e:	4621                	li	a2,8
 650:	bfe9                	j	62a <strtol+0x46>
        s += 2, base = 16;
 652:	0709                	add	a4,a4,2
 654:	4641                	li	a2,16
 656:	bfd1                	j	62a <strtol+0x46>
            dig = *s - '0';
 658:	fd07879b          	addw	a5,a5,-48
            dig = *s - 'a' + 10;
        else if (*s >= 'A' && *s <= 'Z')
            dig = *s - 'A' + 10;
        else
            break;
        if (dig >= base)
 65c:	04c7d063          	bge	a5,a2,69c <strtol+0xb8>
            break;
        s++, val = (val * base) + dig;
 660:	0705                	add	a4,a4,1
 662:	02a60533          	mul	a0,a2,a0
 666:	953e                	add	a0,a0,a5
        if (*s >= '0' && *s <= '9')
 668:	00074783          	lbu	a5,0(a4)
 66c:	fd07869b          	addw	a3,a5,-48
 670:	0ff6f693          	zext.b	a3,a3
 674:	fed872e3          	bgeu	a6,a3,658 <strtol+0x74>
        else if (*s >= 'a' && *s <= 'z')
 678:	f9f7869b          	addw	a3,a5,-97
 67c:	0ff6f693          	zext.b	a3,a3
 680:	00d8e563          	bltu	a7,a3,68a <strtol+0xa6>
            dig = *s - 'a' + 10;
 684:	fa97879b          	addw	a5,a5,-87
 688:	bfd1                	j	65c <strtol+0x78>
        else if (*s >= 'A' && *s <= 'Z')
 68a:	fbf7869b          	addw	a3,a5,-65
 68e:	0ff6f693          	zext.b	a3,a3
 692:	00d8e563          	bltu	a7,a3,69c <strtol+0xb8>
            dig = *s - 'A' + 10;
 696:	fc97879b          	addw	a5,a5,-55
 69a:	b7c9                	j	65c <strtol+0x78>
        // we don't properly detect overflow!
    }

    if (endptr)
 69c:	c191                	beqz	a1,6a0 <strtol+0xbc>
        *endptr = (char *) s;
 69e:	e198                	sd	a4,0(a1)
    return (neg ? -val : val);
 6a0:	00030463          	beqz	t1,6a8 <strtol+0xc4>
 6a4:	40a00533          	neg	a0,a0
}
 6a8:	6422                	ld	s0,8(sp)
 6aa:	0141                	add	sp,sp,16
 6ac:	8082                	ret

00000000000006ae <inet_pton>:
inet_pton (int family, const char *p, void *n) {
    char *sp, *ep;
    int idx;
    long ret;

    if (family != AF_INET) {
 6ae:	4785                	li	a5,1
 6b0:	08f51263          	bne	a0,a5,734 <inet_pton+0x86>
inet_pton (int family, const char *p, void *n) {
 6b4:	715d                	add	sp,sp,-80
 6b6:	e486                	sd	ra,72(sp)
 6b8:	e0a2                	sd	s0,64(sp)
 6ba:	fc26                	sd	s1,56(sp)
 6bc:	f84a                	sd	s2,48(sp)
 6be:	f44e                	sd	s3,40(sp)
 6c0:	f052                	sd	s4,32(sp)
 6c2:	ec56                	sd	s5,24(sp)
 6c4:	e85a                	sd	s6,16(sp)
 6c6:	0880                	add	s0,sp,80
 6c8:	892e                	mv	s2,a1
 6ca:	89b2                	mv	s3,a2
 6cc:	4481                	li	s1,0
        return -1;
    }
    sp = (char *)p;
    for (idx = 0; idx < 4; idx++) {
        ret = strtol(sp, &ep, 10);
        if (ret < 0 || ret > 255) {
 6ce:	0ff00a13          	li	s4,255
            return -1;
        }
        if (ep == sp) {
            return -1;
        }
        if ((idx == 3 && *ep != '\0') || (idx != 3 && *ep != '.')) {
 6d2:	4a8d                	li	s5,3
 6d4:	02e00b13          	li	s6,46
 6d8:	a815                	j	70c <inet_pton+0x5e>
 6da:	0007c783          	lbu	a5,0(a5)
 6de:	e3ad                	bnez	a5,740 <inet_pton+0x92>
            return -1;
        }
        ((uint8_t *)n)[idx] = ret;
 6e0:	2481                	sext.w	s1,s1
 6e2:	99a6                	add	s3,s3,s1
 6e4:	00a98023          	sb	a0,0(s3)
        sp = ep + 1;
    }
    return 0;
 6e8:	4501                	li	a0,0
}
 6ea:	60a6                	ld	ra,72(sp)
 6ec:	6406                	ld	s0,64(sp)
 6ee:	74e2                	ld	s1,56(sp)
 6f0:	7942                	ld	s2,48(sp)
 6f2:	79a2                	ld	s3,40(sp)
 6f4:	7a02                	ld	s4,32(sp)
 6f6:	6ae2                	ld	s5,24(sp)
 6f8:	6b42                	ld	s6,16(sp)
 6fa:	6161                	add	sp,sp,80
 6fc:	8082                	ret
        ((uint8_t *)n)[idx] = ret;
 6fe:	00998733          	add	a4,s3,s1
 702:	00a70023          	sb	a0,0(a4)
        sp = ep + 1;
 706:	00178913          	add	s2,a5,1
    for (idx = 0; idx < 4; idx++) {
 70a:	0485                	add	s1,s1,1
        ret = strtol(sp, &ep, 10);
 70c:	4629                	li	a2,10
 70e:	fb840593          	add	a1,s0,-72
 712:	854a                	mv	a0,s2
 714:	ed1ff0ef          	jal	5e4 <strtol>
        if (ret < 0 || ret > 255) {
 718:	02aa6063          	bltu	s4,a0,738 <inet_pton+0x8a>
        if (ep == sp) {
 71c:	fb843783          	ld	a5,-72(s0)
 720:	01278e63          	beq	a5,s2,73c <inet_pton+0x8e>
        if ((idx == 3 && *ep != '\0') || (idx != 3 && *ep != '.')) {
 724:	fb548be3          	beq	s1,s5,6da <inet_pton+0x2c>
 728:	0007c703          	lbu	a4,0(a5)
 72c:	fd6709e3          	beq	a4,s6,6fe <inet_pton+0x50>
            return -1;
 730:	557d                	li	a0,-1
 732:	bf65                	j	6ea <inet_pton+0x3c>
        return -1;
 734:	557d                	li	a0,-1
}
 736:	8082                	ret
            return -1;
 738:	557d                	li	a0,-1
 73a:	bf45                	j	6ea <inet_pton+0x3c>
            return -1;
 73c:	557d                	li	a0,-1
 73e:	b775                	j	6ea <inet_pton+0x3c>
            return -1;
 740:	557d                	li	a0,-1
 742:	b765                	j	6ea <inet_pton+0x3c>

0000000000000744 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 744:	4885                	li	a7,1
 ecall
 746:	00000073          	ecall
 ret
 74a:	8082                	ret

000000000000074c <exit>:
.global exit
exit:
 li a7, SYS_exit
 74c:	4889                	li	a7,2
 ecall
 74e:	00000073          	ecall
 ret
 752:	8082                	ret

0000000000000754 <wait>:
.global wait
wait:
 li a7, SYS_wait
 754:	488d                	li	a7,3
 ecall
 756:	00000073          	ecall
 ret
 75a:	8082                	ret

000000000000075c <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 75c:	4891                	li	a7,4
 ecall
 75e:	00000073          	ecall
 ret
 762:	8082                	ret

0000000000000764 <read>:
.global read
read:
 li a7, SYS_read
 764:	4895                	li	a7,5
 ecall
 766:	00000073          	ecall
 ret
 76a:	8082                	ret

000000000000076c <write>:
.global write
write:
 li a7, SYS_write
 76c:	48c1                	li	a7,16
 ecall
 76e:	00000073          	ecall
 ret
 772:	8082                	ret

0000000000000774 <close>:
.global close
close:
 li a7, SYS_close
 774:	48d5                	li	a7,21
 ecall
 776:	00000073          	ecall
 ret
 77a:	8082                	ret

000000000000077c <kill>:
.global kill
kill:
 li a7, SYS_kill
 77c:	4899                	li	a7,6
 ecall
 77e:	00000073          	ecall
 ret
 782:	8082                	ret

0000000000000784 <exec>:
.global exec
exec:
 li a7, SYS_exec
 784:	489d                	li	a7,7
 ecall
 786:	00000073          	ecall
 ret
 78a:	8082                	ret

000000000000078c <open>:
.global open
open:
 li a7, SYS_open
 78c:	48bd                	li	a7,15
 ecall
 78e:	00000073          	ecall
 ret
 792:	8082                	ret

0000000000000794 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 794:	48c5                	li	a7,17
 ecall
 796:	00000073          	ecall
 ret
 79a:	8082                	ret

000000000000079c <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 79c:	48c9                	li	a7,18
 ecall
 79e:	00000073          	ecall
 ret
 7a2:	8082                	ret

00000000000007a4 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 7a4:	48a1                	li	a7,8
 ecall
 7a6:	00000073          	ecall
 ret
 7aa:	8082                	ret

00000000000007ac <link>:
.global link
link:
 li a7, SYS_link
 7ac:	48cd                	li	a7,19
 ecall
 7ae:	00000073          	ecall
 ret
 7b2:	8082                	ret

00000000000007b4 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 7b4:	48d1                	li	a7,20
 ecall
 7b6:	00000073          	ecall
 ret
 7ba:	8082                	ret

00000000000007bc <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 7bc:	48a5                	li	a7,9
 ecall
 7be:	00000073          	ecall
 ret
 7c2:	8082                	ret

00000000000007c4 <dup>:
.global dup
dup:
 li a7, SYS_dup
 7c4:	48a9                	li	a7,10
 ecall
 7c6:	00000073          	ecall
 ret
 7ca:	8082                	ret

00000000000007cc <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 7cc:	48ad                	li	a7,11
 ecall
 7ce:	00000073          	ecall
 ret
 7d2:	8082                	ret

00000000000007d4 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 7d4:	48b1                	li	a7,12
 ecall
 7d6:	00000073          	ecall
 ret
 7da:	8082                	ret

00000000000007dc <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 7dc:	48b5                	li	a7,13
 ecall
 7de:	00000073          	ecall
 ret
 7e2:	8082                	ret

00000000000007e4 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 7e4:	48b9                	li	a7,14
 ecall
 7e6:	00000073          	ecall
 ret
 7ea:	8082                	ret

00000000000007ec <socket>:
.global socket
socket:
 li a7, SYS_socket
 7ec:	48d9                	li	a7,22
 ecall
 7ee:	00000073          	ecall
 ret
 7f2:	8082                	ret

00000000000007f4 <bind>:
.global bind
bind:
 li a7, SYS_bind
 7f4:	48dd                	li	a7,23
 ecall
 7f6:	00000073          	ecall
 ret
 7fa:	8082                	ret

00000000000007fc <recvfrom>:
.global recvfrom
recvfrom:
 li a7, SYS_recvfrom
 7fc:	48e1                	li	a7,24
 ecall
 7fe:	00000073          	ecall
 ret
 802:	8082                	ret

0000000000000804 <sendto>:
.global sendto
sendto:
 li a7, SYS_sendto
 804:	48e5                	li	a7,25
 ecall
 806:	00000073          	ecall
 ret
 80a:	8082                	ret

000000000000080c <connect>:
.global connect
connect:
 li a7, SYS_connect
 80c:	48e9                	li	a7,26
 ecall
 80e:	00000073          	ecall
 ret
 812:	8082                	ret

0000000000000814 <listen>:
.global listen
listen:
 li a7, SYS_listen
 814:	48ed                	li	a7,27
 ecall
 816:	00000073          	ecall
 ret
 81a:	8082                	ret

000000000000081c <accept>:
.global accept
accept:
 li a7, SYS_accept
 81c:	48f1                	li	a7,28
 ecall
 81e:	00000073          	ecall
 ret
 822:	8082                	ret

0000000000000824 <recv>:
.global recv
recv:
 li a7, SYS_recv
 824:	48f5                	li	a7,29
 ecall
 826:	00000073          	ecall
 ret
 82a:	8082                	ret

000000000000082c <send>:
.global send
send:
 li a7, SYS_send
 82c:	48f9                	li	a7,30
 ecall
 82e:	00000073          	ecall
 ret
 832:	8082                	ret

0000000000000834 <ioctl>:
.global ioctl
ioctl:
 li a7, SYS_ioctl
 834:	48fd                	li	a7,31
 ecall
 836:	00000073          	ecall
 ret
 83a:	8082                	ret

000000000000083c <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 83c:	1101                	add	sp,sp,-32
 83e:	ec06                	sd	ra,24(sp)
 840:	e822                	sd	s0,16(sp)
 842:	1000                	add	s0,sp,32
 844:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 848:	4605                	li	a2,1
 84a:	fef40593          	add	a1,s0,-17
 84e:	f1fff0ef          	jal	76c <write>
}
 852:	60e2                	ld	ra,24(sp)
 854:	6442                	ld	s0,16(sp)
 856:	6105                	add	sp,sp,32
 858:	8082                	ret

000000000000085a <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
 85a:	715d                	add	sp,sp,-80
 85c:	e486                	sd	ra,72(sp)
 85e:	e0a2                	sd	s0,64(sp)
 860:	fc26                	sd	s1,56(sp)
 862:	f84a                	sd	s2,48(sp)
 864:	f44e                	sd	s3,40(sp)
 866:	0880                	add	s0,sp,80
 868:	84aa                	mv	s1,a0
  char buf[20];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 86a:	c299                	beqz	a3,870 <printint+0x16>
 86c:	0805c763          	bltz	a1,8fa <printint+0xa0>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 870:	2581                	sext.w	a1,a1
  neg = 0;
 872:	4881                	li	a7,0
 874:	fb840693          	add	a3,s0,-72
  }

  i = 0;
 878:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 87a:	2601                	sext.w	a2,a2
 87c:	00000517          	auipc	a0,0x0
 880:	5cc50513          	add	a0,a0,1484 # e48 <digits>
 884:	883a                	mv	a6,a4
 886:	2705                	addw	a4,a4,1
 888:	02c5f7bb          	remuw	a5,a1,a2
 88c:	1782                	sll	a5,a5,0x20
 88e:	9381                	srl	a5,a5,0x20
 890:	97aa                	add	a5,a5,a0
 892:	0007c783          	lbu	a5,0(a5)
 896:	00f68023          	sb	a5,0(a3) # ff0000 <base+0xfeeff0>
  }while((x /= base) != 0);
 89a:	0005879b          	sext.w	a5,a1
 89e:	02c5d5bb          	divuw	a1,a1,a2
 8a2:	0685                	add	a3,a3,1
 8a4:	fec7f0e3          	bgeu	a5,a2,884 <printint+0x2a>
  if(neg)
 8a8:	00088c63          	beqz	a7,8c0 <printint+0x66>
    buf[i++] = '-';
 8ac:	fd070793          	add	a5,a4,-48
 8b0:	00878733          	add	a4,a5,s0
 8b4:	02d00793          	li	a5,45
 8b8:	fef70423          	sb	a5,-24(a4)
 8bc:	0028071b          	addw	a4,a6,2

  while(--i >= 0)
 8c0:	02e05663          	blez	a4,8ec <printint+0x92>
 8c4:	fb840793          	add	a5,s0,-72
 8c8:	00e78933          	add	s2,a5,a4
 8cc:	fff78993          	add	s3,a5,-1
 8d0:	99ba                	add	s3,s3,a4
 8d2:	377d                	addw	a4,a4,-1
 8d4:	1702                	sll	a4,a4,0x20
 8d6:	9301                	srl	a4,a4,0x20
 8d8:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 8dc:	fff94583          	lbu	a1,-1(s2)
 8e0:	8526                	mv	a0,s1
 8e2:	f5bff0ef          	jal	83c <putc>
  while(--i >= 0)
 8e6:	197d                	add	s2,s2,-1
 8e8:	ff391ae3          	bne	s2,s3,8dc <printint+0x82>
}
 8ec:	60a6                	ld	ra,72(sp)
 8ee:	6406                	ld	s0,64(sp)
 8f0:	74e2                	ld	s1,56(sp)
 8f2:	7942                	ld	s2,48(sp)
 8f4:	79a2                	ld	s3,40(sp)
 8f6:	6161                	add	sp,sp,80
 8f8:	8082                	ret
    x = -xx;
 8fa:	40b005bb          	negw	a1,a1
    neg = 1;
 8fe:	4885                	li	a7,1
    x = -xx;
 900:	bf95                	j	874 <printint+0x1a>

0000000000000902 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 902:	711d                	add	sp,sp,-96
 904:	ec86                	sd	ra,88(sp)
 906:	e8a2                	sd	s0,80(sp)
 908:	e4a6                	sd	s1,72(sp)
 90a:	e0ca                	sd	s2,64(sp)
 90c:	fc4e                	sd	s3,56(sp)
 90e:	f852                	sd	s4,48(sp)
 910:	f456                	sd	s5,40(sp)
 912:	f05a                	sd	s6,32(sp)
 914:	ec5e                	sd	s7,24(sp)
 916:	e862                	sd	s8,16(sp)
 918:	e466                	sd	s9,8(sp)
 91a:	e06a                	sd	s10,0(sp)
 91c:	1080                	add	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 91e:	0005c903          	lbu	s2,0(a1)
 922:	24090763          	beqz	s2,b70 <vprintf+0x26e>
 926:	8b2a                	mv	s6,a0
 928:	8a2e                	mv	s4,a1
 92a:	8bb2                	mv	s7,a2
  state = 0;
 92c:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
 92e:	4481                	li	s1,0
 930:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
 932:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
 936:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
 93a:	06c00c93          	li	s9,108
 93e:	a005                	j	95e <vprintf+0x5c>
        putc(fd, c0);
 940:	85ca                	mv	a1,s2
 942:	855a                	mv	a0,s6
 944:	ef9ff0ef          	jal	83c <putc>
 948:	a019                	j	94e <vprintf+0x4c>
    } else if(state == '%'){
 94a:	03598263          	beq	s3,s5,96e <vprintf+0x6c>
  for(i = 0; fmt[i]; i++){
 94e:	2485                	addw	s1,s1,1
 950:	8726                	mv	a4,s1
 952:	009a07b3          	add	a5,s4,s1
 956:	0007c903          	lbu	s2,0(a5)
 95a:	20090b63          	beqz	s2,b70 <vprintf+0x26e>
    c0 = fmt[i] & 0xff;
 95e:	0009079b          	sext.w	a5,s2
    if(state == 0){
 962:	fe0994e3          	bnez	s3,94a <vprintf+0x48>
      if(c0 == '%'){
 966:	fd579de3          	bne	a5,s5,940 <vprintf+0x3e>
        state = '%';
 96a:	89be                	mv	s3,a5
 96c:	b7cd                	j	94e <vprintf+0x4c>
      if(c0) c1 = fmt[i+1] & 0xff;
 96e:	c7c9                	beqz	a5,9f8 <vprintf+0xf6>
 970:	00ea06b3          	add	a3,s4,a4
 974:	0016c683          	lbu	a3,1(a3)
      c1 = c2 = 0;
 978:	8636                	mv	a2,a3
      if(c1) c2 = fmt[i+2] & 0xff;
 97a:	c681                	beqz	a3,982 <vprintf+0x80>
 97c:	9752                	add	a4,a4,s4
 97e:	00274603          	lbu	a2,2(a4)
      if(c0 == 'd'){
 982:	03878f63          	beq	a5,s8,9c0 <vprintf+0xbe>
      } else if(c0 == 'l' && c1 == 'd'){
 986:	05978963          	beq	a5,s9,9d8 <vprintf+0xd6>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
 98a:	07500713          	li	a4,117
 98e:	0ee78363          	beq	a5,a4,a74 <vprintf+0x172>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
 992:	07800713          	li	a4,120
 996:	12e78563          	beq	a5,a4,ac0 <vprintf+0x1be>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
 99a:	07000713          	li	a4,112
 99e:	14e78a63          	beq	a5,a4,af2 <vprintf+0x1f0>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 's'){
 9a2:	07300713          	li	a4,115
 9a6:	18e78863          	beq	a5,a4,b36 <vprintf+0x234>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
 9aa:	02500713          	li	a4,37
 9ae:	04e79563          	bne	a5,a4,9f8 <vprintf+0xf6>
        putc(fd, '%');
 9b2:	02500593          	li	a1,37
 9b6:	855a                	mv	a0,s6
 9b8:	e85ff0ef          	jal	83c <putc>
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
#endif
      state = 0;
 9bc:	4981                	li	s3,0
 9be:	bf41                	j	94e <vprintf+0x4c>
        printint(fd, va_arg(ap, int), 10, 1);
 9c0:	008b8913          	add	s2,s7,8
 9c4:	4685                	li	a3,1
 9c6:	4629                	li	a2,10
 9c8:	000ba583          	lw	a1,0(s7)
 9cc:	855a                	mv	a0,s6
 9ce:	e8dff0ef          	jal	85a <printint>
 9d2:	8bca                	mv	s7,s2
      state = 0;
 9d4:	4981                	li	s3,0
 9d6:	bfa5                	j	94e <vprintf+0x4c>
      } else if(c0 == 'l' && c1 == 'd'){
 9d8:	06400793          	li	a5,100
 9dc:	02f68963          	beq	a3,a5,a0e <vprintf+0x10c>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 9e0:	06c00793          	li	a5,108
 9e4:	04f68263          	beq	a3,a5,a28 <vprintf+0x126>
      } else if(c0 == 'l' && c1 == 'u'){
 9e8:	07500793          	li	a5,117
 9ec:	0af68063          	beq	a3,a5,a8c <vprintf+0x18a>
      } else if(c0 == 'l' && c1 == 'x'){
 9f0:	07800793          	li	a5,120
 9f4:	0ef68263          	beq	a3,a5,ad8 <vprintf+0x1d6>
        putc(fd, '%');
 9f8:	02500593          	li	a1,37
 9fc:	855a                	mv	a0,s6
 9fe:	e3fff0ef          	jal	83c <putc>
        putc(fd, c0);
 a02:	85ca                	mv	a1,s2
 a04:	855a                	mv	a0,s6
 a06:	e37ff0ef          	jal	83c <putc>
      state = 0;
 a0a:	4981                	li	s3,0
 a0c:	b789                	j	94e <vprintf+0x4c>
        printint(fd, va_arg(ap, uint64), 10, 1);
 a0e:	008b8913          	add	s2,s7,8
 a12:	4685                	li	a3,1
 a14:	4629                	li	a2,10
 a16:	000bb583          	ld	a1,0(s7)
 a1a:	855a                	mv	a0,s6
 a1c:	e3fff0ef          	jal	85a <printint>
        i += 1;
 a20:	2485                	addw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 a22:	8bca                	mv	s7,s2
      state = 0;
 a24:	4981                	li	s3,0
        i += 1;
 a26:	b725                	j	94e <vprintf+0x4c>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 a28:	06400793          	li	a5,100
 a2c:	02f60763          	beq	a2,a5,a5a <vprintf+0x158>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 a30:	07500793          	li	a5,117
 a34:	06f60963          	beq	a2,a5,aa6 <vprintf+0x1a4>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 a38:	07800793          	li	a5,120
 a3c:	faf61ee3          	bne	a2,a5,9f8 <vprintf+0xf6>
        printint(fd, va_arg(ap, uint64), 16, 0);
 a40:	008b8913          	add	s2,s7,8
 a44:	4681                	li	a3,0
 a46:	4641                	li	a2,16
 a48:	000bb583          	ld	a1,0(s7)
 a4c:	855a                	mv	a0,s6
 a4e:	e0dff0ef          	jal	85a <printint>
        i += 2;
 a52:	2489                	addw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 a54:	8bca                	mv	s7,s2
      state = 0;
 a56:	4981                	li	s3,0
        i += 2;
 a58:	bddd                	j	94e <vprintf+0x4c>
        printint(fd, va_arg(ap, uint64), 10, 1);
 a5a:	008b8913          	add	s2,s7,8
 a5e:	4685                	li	a3,1
 a60:	4629                	li	a2,10
 a62:	000bb583          	ld	a1,0(s7)
 a66:	855a                	mv	a0,s6
 a68:	df3ff0ef          	jal	85a <printint>
        i += 2;
 a6c:	2489                	addw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 a6e:	8bca                	mv	s7,s2
      state = 0;
 a70:	4981                	li	s3,0
        i += 2;
 a72:	bdf1                	j	94e <vprintf+0x4c>
        printint(fd, va_arg(ap, int), 10, 0);
 a74:	008b8913          	add	s2,s7,8
 a78:	4681                	li	a3,0
 a7a:	4629                	li	a2,10
 a7c:	000ba583          	lw	a1,0(s7)
 a80:	855a                	mv	a0,s6
 a82:	dd9ff0ef          	jal	85a <printint>
 a86:	8bca                	mv	s7,s2
      state = 0;
 a88:	4981                	li	s3,0
 a8a:	b5d1                	j	94e <vprintf+0x4c>
        printint(fd, va_arg(ap, uint64), 10, 0);
 a8c:	008b8913          	add	s2,s7,8
 a90:	4681                	li	a3,0
 a92:	4629                	li	a2,10
 a94:	000bb583          	ld	a1,0(s7)
 a98:	855a                	mv	a0,s6
 a9a:	dc1ff0ef          	jal	85a <printint>
        i += 1;
 a9e:	2485                	addw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 aa0:	8bca                	mv	s7,s2
      state = 0;
 aa2:	4981                	li	s3,0
        i += 1;
 aa4:	b56d                	j	94e <vprintf+0x4c>
        printint(fd, va_arg(ap, uint64), 10, 0);
 aa6:	008b8913          	add	s2,s7,8
 aaa:	4681                	li	a3,0
 aac:	4629                	li	a2,10
 aae:	000bb583          	ld	a1,0(s7)
 ab2:	855a                	mv	a0,s6
 ab4:	da7ff0ef          	jal	85a <printint>
        i += 2;
 ab8:	2489                	addw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 aba:	8bca                	mv	s7,s2
      state = 0;
 abc:	4981                	li	s3,0
        i += 2;
 abe:	bd41                	j	94e <vprintf+0x4c>
        printint(fd, va_arg(ap, int), 16, 0);
 ac0:	008b8913          	add	s2,s7,8
 ac4:	4681                	li	a3,0
 ac6:	4641                	li	a2,16
 ac8:	000ba583          	lw	a1,0(s7)
 acc:	855a                	mv	a0,s6
 ace:	d8dff0ef          	jal	85a <printint>
 ad2:	8bca                	mv	s7,s2
      state = 0;
 ad4:	4981                	li	s3,0
 ad6:	bda5                	j	94e <vprintf+0x4c>
        printint(fd, va_arg(ap, uint64), 16, 0);
 ad8:	008b8913          	add	s2,s7,8
 adc:	4681                	li	a3,0
 ade:	4641                	li	a2,16
 ae0:	000bb583          	ld	a1,0(s7)
 ae4:	855a                	mv	a0,s6
 ae6:	d75ff0ef          	jal	85a <printint>
        i += 1;
 aea:	2485                	addw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 aec:	8bca                	mv	s7,s2
      state = 0;
 aee:	4981                	li	s3,0
        i += 1;
 af0:	bdb9                	j	94e <vprintf+0x4c>
        printptr(fd, va_arg(ap, uint64));
 af2:	008b8d13          	add	s10,s7,8
 af6:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 afa:	03000593          	li	a1,48
 afe:	855a                	mv	a0,s6
 b00:	d3dff0ef          	jal	83c <putc>
  putc(fd, 'x');
 b04:	07800593          	li	a1,120
 b08:	855a                	mv	a0,s6
 b0a:	d33ff0ef          	jal	83c <putc>
 b0e:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 b10:	00000b97          	auipc	s7,0x0
 b14:	338b8b93          	add	s7,s7,824 # e48 <digits>
 b18:	03c9d793          	srl	a5,s3,0x3c
 b1c:	97de                	add	a5,a5,s7
 b1e:	0007c583          	lbu	a1,0(a5)
 b22:	855a                	mv	a0,s6
 b24:	d19ff0ef          	jal	83c <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 b28:	0992                	sll	s3,s3,0x4
 b2a:	397d                	addw	s2,s2,-1
 b2c:	fe0916e3          	bnez	s2,b18 <vprintf+0x216>
        printptr(fd, va_arg(ap, uint64));
 b30:	8bea                	mv	s7,s10
      state = 0;
 b32:	4981                	li	s3,0
 b34:	bd29                	j	94e <vprintf+0x4c>
        if((s = va_arg(ap, char*)) == 0)
 b36:	008b8993          	add	s3,s7,8
 b3a:	000bb903          	ld	s2,0(s7)
 b3e:	00090f63          	beqz	s2,b5c <vprintf+0x25a>
        for(; *s; s++)
 b42:	00094583          	lbu	a1,0(s2)
 b46:	c195                	beqz	a1,b6a <vprintf+0x268>
          putc(fd, *s);
 b48:	855a                	mv	a0,s6
 b4a:	cf3ff0ef          	jal	83c <putc>
        for(; *s; s++)
 b4e:	0905                	add	s2,s2,1
 b50:	00094583          	lbu	a1,0(s2)
 b54:	f9f5                	bnez	a1,b48 <vprintf+0x246>
        if((s = va_arg(ap, char*)) == 0)
 b56:	8bce                	mv	s7,s3
      state = 0;
 b58:	4981                	li	s3,0
 b5a:	bbd5                	j	94e <vprintf+0x4c>
          s = "(null)";
 b5c:	00000917          	auipc	s2,0x0
 b60:	2e490913          	add	s2,s2,740 # e40 <malloc+0x1d6>
        for(; *s; s++)
 b64:	02800593          	li	a1,40
 b68:	b7c5                	j	b48 <vprintf+0x246>
        if((s = va_arg(ap, char*)) == 0)
 b6a:	8bce                	mv	s7,s3
      state = 0;
 b6c:	4981                	li	s3,0
 b6e:	b3c5                	j	94e <vprintf+0x4c>
    }
  }
}
 b70:	60e6                	ld	ra,88(sp)
 b72:	6446                	ld	s0,80(sp)
 b74:	64a6                	ld	s1,72(sp)
 b76:	6906                	ld	s2,64(sp)
 b78:	79e2                	ld	s3,56(sp)
 b7a:	7a42                	ld	s4,48(sp)
 b7c:	7aa2                	ld	s5,40(sp)
 b7e:	7b02                	ld	s6,32(sp)
 b80:	6be2                	ld	s7,24(sp)
 b82:	6c42                	ld	s8,16(sp)
 b84:	6ca2                	ld	s9,8(sp)
 b86:	6d02                	ld	s10,0(sp)
 b88:	6125                	add	sp,sp,96
 b8a:	8082                	ret

0000000000000b8c <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 b8c:	715d                	add	sp,sp,-80
 b8e:	ec06                	sd	ra,24(sp)
 b90:	e822                	sd	s0,16(sp)
 b92:	1000                	add	s0,sp,32
 b94:	e010                	sd	a2,0(s0)
 b96:	e414                	sd	a3,8(s0)
 b98:	e818                	sd	a4,16(s0)
 b9a:	ec1c                	sd	a5,24(s0)
 b9c:	03043023          	sd	a6,32(s0)
 ba0:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 ba4:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 ba8:	8622                	mv	a2,s0
 baa:	d59ff0ef          	jal	902 <vprintf>
}
 bae:	60e2                	ld	ra,24(sp)
 bb0:	6442                	ld	s0,16(sp)
 bb2:	6161                	add	sp,sp,80
 bb4:	8082                	ret

0000000000000bb6 <printf>:

void
printf(const char *fmt, ...)
{
 bb6:	711d                	add	sp,sp,-96
 bb8:	ec06                	sd	ra,24(sp)
 bba:	e822                	sd	s0,16(sp)
 bbc:	1000                	add	s0,sp,32
 bbe:	e40c                	sd	a1,8(s0)
 bc0:	e810                	sd	a2,16(s0)
 bc2:	ec14                	sd	a3,24(s0)
 bc4:	f018                	sd	a4,32(s0)
 bc6:	f41c                	sd	a5,40(s0)
 bc8:	03043823          	sd	a6,48(s0)
 bcc:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 bd0:	00840613          	add	a2,s0,8
 bd4:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 bd8:	85aa                	mv	a1,a0
 bda:	4505                	li	a0,1
 bdc:	d27ff0ef          	jal	902 <vprintf>
}
 be0:	60e2                	ld	ra,24(sp)
 be2:	6442                	ld	s0,16(sp)
 be4:	6125                	add	sp,sp,96
 be6:	8082                	ret

0000000000000be8 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 be8:	1141                	add	sp,sp,-16
 bea:	e422                	sd	s0,8(sp)
 bec:	0800                	add	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 bee:	ff050693          	add	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 bf2:	00000797          	auipc	a5,0x0
 bf6:	4167b783          	ld	a5,1046(a5) # 1008 <freep>
 bfa:	a02d                	j	c24 <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 bfc:	4618                	lw	a4,8(a2)
 bfe:	9f2d                	addw	a4,a4,a1
 c00:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 c04:	6398                	ld	a4,0(a5)
 c06:	6310                	ld	a2,0(a4)
 c08:	a83d                	j	c46 <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 c0a:	ff852703          	lw	a4,-8(a0)
 c0e:	9f31                	addw	a4,a4,a2
 c10:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 c12:	ff053683          	ld	a3,-16(a0)
 c16:	a091                	j	c5a <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 c18:	6398                	ld	a4,0(a5)
 c1a:	00e7e463          	bltu	a5,a4,c22 <free+0x3a>
 c1e:	00e6ea63          	bltu	a3,a4,c32 <free+0x4a>
{
 c22:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 c24:	fed7fae3          	bgeu	a5,a3,c18 <free+0x30>
 c28:	6398                	ld	a4,0(a5)
 c2a:	00e6e463          	bltu	a3,a4,c32 <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 c2e:	fee7eae3          	bltu	a5,a4,c22 <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 c32:	ff852583          	lw	a1,-8(a0)
 c36:	6390                	ld	a2,0(a5)
 c38:	02059813          	sll	a6,a1,0x20
 c3c:	01c85713          	srl	a4,a6,0x1c
 c40:	9736                	add	a4,a4,a3
 c42:	fae60de3          	beq	a2,a4,bfc <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 c46:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 c4a:	4790                	lw	a2,8(a5)
 c4c:	02061593          	sll	a1,a2,0x20
 c50:	01c5d713          	srl	a4,a1,0x1c
 c54:	973e                	add	a4,a4,a5
 c56:	fae68ae3          	beq	a3,a4,c0a <free+0x22>
    p->s.ptr = bp->s.ptr;
 c5a:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 c5c:	00000717          	auipc	a4,0x0
 c60:	3af73623          	sd	a5,940(a4) # 1008 <freep>
}
 c64:	6422                	ld	s0,8(sp)
 c66:	0141                	add	sp,sp,16
 c68:	8082                	ret

0000000000000c6a <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 c6a:	7139                	add	sp,sp,-64
 c6c:	fc06                	sd	ra,56(sp)
 c6e:	f822                	sd	s0,48(sp)
 c70:	f426                	sd	s1,40(sp)
 c72:	f04a                	sd	s2,32(sp)
 c74:	ec4e                	sd	s3,24(sp)
 c76:	e852                	sd	s4,16(sp)
 c78:	e456                	sd	s5,8(sp)
 c7a:	e05a                	sd	s6,0(sp)
 c7c:	0080                	add	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 c7e:	02051493          	sll	s1,a0,0x20
 c82:	9081                	srl	s1,s1,0x20
 c84:	04bd                	add	s1,s1,15
 c86:	8091                	srl	s1,s1,0x4
 c88:	0014899b          	addw	s3,s1,1
 c8c:	0485                	add	s1,s1,1
  if((prevp = freep) == 0){
 c8e:	00000517          	auipc	a0,0x0
 c92:	37a53503          	ld	a0,890(a0) # 1008 <freep>
 c96:	c515                	beqz	a0,cc2 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 c98:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 c9a:	4798                	lw	a4,8(a5)
 c9c:	02977f63          	bgeu	a4,s1,cda <malloc+0x70>
  if(nu < 4096)
 ca0:	8a4e                	mv	s4,s3
 ca2:	0009871b          	sext.w	a4,s3
 ca6:	6685                	lui	a3,0x1
 ca8:	00d77363          	bgeu	a4,a3,cae <malloc+0x44>
 cac:	6a05                	lui	s4,0x1
 cae:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 cb2:	004a1a1b          	sllw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 cb6:	00000917          	auipc	s2,0x0
 cba:	35290913          	add	s2,s2,850 # 1008 <freep>
  if(p == (char*)-1)
 cbe:	5afd                	li	s5,-1
 cc0:	a885                	j	d30 <malloc+0xc6>
    base.s.ptr = freep = prevp = &base;
 cc2:	00000797          	auipc	a5,0x0
 cc6:	34e78793          	add	a5,a5,846 # 1010 <base>
 cca:	00000717          	auipc	a4,0x0
 cce:	32f73f23          	sd	a5,830(a4) # 1008 <freep>
 cd2:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 cd4:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 cd8:	b7e1                	j	ca0 <malloc+0x36>
      if(p->s.size == nunits)
 cda:	02e48c63          	beq	s1,a4,d12 <malloc+0xa8>
        p->s.size -= nunits;
 cde:	4137073b          	subw	a4,a4,s3
 ce2:	c798                	sw	a4,8(a5)
        p += p->s.size;
 ce4:	02071693          	sll	a3,a4,0x20
 ce8:	01c6d713          	srl	a4,a3,0x1c
 cec:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 cee:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 cf2:	00000717          	auipc	a4,0x0
 cf6:	30a73b23          	sd	a0,790(a4) # 1008 <freep>
      return (void*)(p + 1);
 cfa:	01078513          	add	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 cfe:	70e2                	ld	ra,56(sp)
 d00:	7442                	ld	s0,48(sp)
 d02:	74a2                	ld	s1,40(sp)
 d04:	7902                	ld	s2,32(sp)
 d06:	69e2                	ld	s3,24(sp)
 d08:	6a42                	ld	s4,16(sp)
 d0a:	6aa2                	ld	s5,8(sp)
 d0c:	6b02                	ld	s6,0(sp)
 d0e:	6121                	add	sp,sp,64
 d10:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 d12:	6398                	ld	a4,0(a5)
 d14:	e118                	sd	a4,0(a0)
 d16:	bff1                	j	cf2 <malloc+0x88>
  hp->s.size = nu;
 d18:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 d1c:	0541                	add	a0,a0,16
 d1e:	ecbff0ef          	jal	be8 <free>
  return freep;
 d22:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 d26:	dd61                	beqz	a0,cfe <malloc+0x94>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 d28:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 d2a:	4798                	lw	a4,8(a5)
 d2c:	fa9777e3          	bgeu	a4,s1,cda <malloc+0x70>
    if(p == freep)
 d30:	00093703          	ld	a4,0(s2)
 d34:	853e                	mv	a0,a5
 d36:	fef719e3          	bne	a4,a5,d28 <malloc+0xbe>
  p = sbrk(nu * sizeof(Header));
 d3a:	8552                	mv	a0,s4
 d3c:	a99ff0ef          	jal	7d4 <sbrk>
  if(p == (char*)-1)
 d40:	fd551ce3          	bne	a0,s5,d18 <malloc+0xae>
        return 0;
 d44:	4501                	li	a0,0
 d46:	bf65                	j	cfe <malloc+0x94>
