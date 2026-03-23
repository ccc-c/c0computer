
user/_tcpecho:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "user/user.h"
#include "kernel/net/socket.h"

int
main (int argc, char *argv[])
{
   0:	7159                	add	sp,sp,-112
   2:	f486                	sd	ra,104(sp)
   4:	f0a2                	sd	s0,96(sp)
   6:	eca6                	sd	s1,88(sp)
   8:	e8ca                	sd	s2,80(sp)
   a:	e4ce                	sd	s3,72(sp)
   c:	e0d2                	sd	s4,64(sp)
   e:	fc56                	sd	s5,56(sp)
  10:	f85a                	sd	s6,48(sp)
  12:	1880                	add	s0,sp,112
  14:	81010113          	add	sp,sp,-2032
    int soc, acc, peerlen, ret;
    struct sockaddr_in self, peer;
    unsigned char *addr;
    char buf[2048];

    printf("Starting TCP Echo Server\n");
  18:	00001517          	auipc	a0,0x1
  1c:	c6850513          	add	a0,a0,-920 # c80 <malloc+0xe6>
  20:	2c7000ef          	jal	ae6 <printf>
    soc = socket(PF_INET, SOCK_STREAM, IPPROTO_TCP);
  24:	4601                	li	a2,0
  26:	4589                	li	a1,2
  28:	4505                	li	a0,1
  2a:	6f2000ef          	jal	71c <socket>
    if (soc == 1) {
  2e:	4785                	li	a5,1
  30:	10f50463          	beq	a0,a5,138 <main+0x138>
  34:	892a                	mv	s2,a0
        printf("socket: failure\n");
        exit(1);
    }
    printf("socket: success, soc=%d\n", soc);
  36:	85aa                	mv	a1,a0
  38:	00001517          	auipc	a0,0x1
  3c:	c8050513          	add	a0,a0,-896 # cb8 <malloc+0x11e>
  40:	2a7000ef          	jal	ae6 <printf>
    self.sin_family = AF_INET;
  44:	4785                	li	a5,1
  46:	faf41823          	sh	a5,-80(s0)
    self.sin_addr.s_addr = INADDR_ANY;
  4a:	fa042a23          	sw	zero,-76(s0)
    self.sin_port = htons(7);
  4e:	451d                	li	a0,7
  50:	3a4000ef          	jal	3f4 <htons>
  54:	faa41923          	sh	a0,-78(s0)
    if (bind(soc, (struct sockaddr *)&self, sizeof(self)) == -1) {
  58:	4621                	li	a2,8
  5a:	fb040593          	add	a1,s0,-80
  5e:	854a                	mv	a0,s2
  60:	6c4000ef          	jal	724 <bind>
  64:	57fd                	li	a5,-1
  66:	0ef50263          	beq	a0,a5,14a <main+0x14a>
        printf("bind: failure\n");
        close(soc);
        exit(1);
    }
    addr = (unsigned char *)&self.sin_addr;
    printf("bind: success, self=%d.%d.%d.%d:%d\n", addr[0], addr[1], addr[2], addr[3], ntohs(self.sin_port));
  6a:	fb444483          	lbu	s1,-76(s0)
  6e:	fb544983          	lbu	s3,-75(s0)
  72:	fb644a03          	lbu	s4,-74(s0)
  76:	fb744a83          	lbu	s5,-73(s0)
  7a:	fb245503          	lhu	a0,-78(s0)
  7e:	3b2000ef          	jal	430 <ntohs>
  82:	0005079b          	sext.w	a5,a0
  86:	8756                	mv	a4,s5
  88:	86d2                	mv	a3,s4
  8a:	864e                	mv	a2,s3
  8c:	85a6                	mv	a1,s1
  8e:	00001517          	auipc	a0,0x1
  92:	c5a50513          	add	a0,a0,-934 # ce8 <malloc+0x14e>
  96:	251000ef          	jal	ae6 <printf>
    listen(soc, 100);
  9a:	06400593          	li	a1,100
  9e:	854a                	mv	a0,s2
  a0:	6a4000ef          	jal	744 <listen>
    printf("waiting for connection...\n");
  a4:	00001517          	auipc	a0,0x1
  a8:	c6c50513          	add	a0,a0,-916 # d10 <malloc+0x176>
  ac:	23b000ef          	jal	ae6 <printf>
    peerlen = sizeof(peer);
  b0:	47a1                	li	a5,8
  b2:	faf42e23          	sw	a5,-68(s0)
    acc = accept(soc, (struct sockaddr *)&peer, &peerlen);
  b6:	fbc40613          	add	a2,s0,-68
  ba:	fa840593          	add	a1,s0,-88
  be:	854a                	mv	a0,s2
  c0:	68c000ef          	jal	74c <accept>
  c4:	89aa                	mv	s3,a0
    if (acc == -1) {
  c6:	57fd                	li	a5,-1
  c8:	08f50d63          	beq	a0,a5,162 <main+0x162>
        printf("accept: failure\n");
        close(soc);
        exit(1);
    }
    addr = (unsigned char *)&peer.sin_addr;
    printf("accept: success, peer=%d.%d.%d.%d:%d\n", addr[0], addr[1], addr[2], addr[3], ntohs(peer.sin_port));
  cc:	fac44483          	lbu	s1,-84(s0)
  d0:	fad44a03          	lbu	s4,-83(s0)
  d4:	fae44a83          	lbu	s5,-82(s0)
  d8:	faf44b03          	lbu	s6,-81(s0)
  dc:	faa45503          	lhu	a0,-86(s0)
  e0:	350000ef          	jal	430 <ntohs>
  e4:	0005079b          	sext.w	a5,a0
  e8:	875a                	mv	a4,s6
  ea:	86d6                	mv	a3,s5
  ec:	8652                	mv	a2,s4
  ee:	85a6                	mv	a1,s1
  f0:	00001517          	auipc	a0,0x1
  f4:	c5850513          	add	a0,a0,-936 # d48 <malloc+0x1ae>
  f8:	1ef000ef          	jal	ae6 <printf>
    while (1) {
        ret = recv(acc, buf, sizeof(buf));
  fc:	7a7d                	lui	s4,0xfffff
  fe:	7a8a0793          	add	a5,s4,1960 # fffffffffffff7a8 <base+0xffffffffffffe798>
 102:	00878a33          	add	s4,a5,s0
 106:	6a85                	lui	s5,0x1
 108:	800a8a93          	add	s5,s5,-2048 # 800 <printint+0x76>
        if (ret <= 0) {
            printf("EOF\n");
            break;
        }
        printf("recv: %d bytes data received\n", ret);
 10c:	00001b17          	auipc	s6,0x1
 110:	c6cb0b13          	add	s6,s6,-916 # d78 <malloc+0x1de>
        ret = recv(acc, buf, sizeof(buf));
 114:	8656                	mv	a2,s5
 116:	85d2                	mv	a1,s4
 118:	854e                	mv	a0,s3
 11a:	63a000ef          	jal	754 <recv>
 11e:	84aa                	mv	s1,a0
        if (ret <= 0) {
 120:	04a05d63          	blez	a0,17a <main+0x17a>
        printf("recv: %d bytes data received\n", ret);
 124:	85aa                	mv	a1,a0
 126:	855a                	mv	a0,s6
 128:	1bf000ef          	jal	ae6 <printf>
        send(acc, buf, ret);
 12c:	8626                	mv	a2,s1
 12e:	85d2                	mv	a1,s4
 130:	854e                	mv	a0,s3
 132:	62a000ef          	jal	75c <send>
        ret = recv(acc, buf, sizeof(buf));
 136:	bff9                	j	114 <main+0x114>
        printf("socket: failure\n");
 138:	00001517          	auipc	a0,0x1
 13c:	b6850513          	add	a0,a0,-1176 # ca0 <malloc+0x106>
 140:	1a7000ef          	jal	ae6 <printf>
        exit(1);
 144:	4505                	li	a0,1
 146:	536000ef          	jal	67c <exit>
        printf("bind: failure\n");
 14a:	00001517          	auipc	a0,0x1
 14e:	b8e50513          	add	a0,a0,-1138 # cd8 <malloc+0x13e>
 152:	195000ef          	jal	ae6 <printf>
        close(soc);
 156:	854a                	mv	a0,s2
 158:	54c000ef          	jal	6a4 <close>
        exit(1);
 15c:	4505                	li	a0,1
 15e:	51e000ef          	jal	67c <exit>
        printf("accept: failure\n");
 162:	00001517          	auipc	a0,0x1
 166:	bce50513          	add	a0,a0,-1074 # d30 <malloc+0x196>
 16a:	17d000ef          	jal	ae6 <printf>
        close(soc);
 16e:	854a                	mv	a0,s2
 170:	534000ef          	jal	6a4 <close>
        exit(1);
 174:	4505                	li	a0,1
 176:	506000ef          	jal	67c <exit>
            printf("EOF\n");
 17a:	00001517          	auipc	a0,0x1
 17e:	bf650513          	add	a0,a0,-1034 # d70 <malloc+0x1d6>
 182:	165000ef          	jal	ae6 <printf>
    }
    close(soc);  
 186:	854a                	mv	a0,s2
 188:	51c000ef          	jal	6a4 <close>
    exit(0);
 18c:	4501                	li	a0,0
 18e:	4ee000ef          	jal	67c <exit>

0000000000000192 <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start()
{
 192:	1141                	add	sp,sp,-16
 194:	e406                	sd	ra,8(sp)
 196:	e022                	sd	s0,0(sp)
 198:	0800                	add	s0,sp,16
  extern int main();
  main();
 19a:	e67ff0ef          	jal	0 <main>
  exit(0);
 19e:	4501                	li	a0,0
 1a0:	4dc000ef          	jal	67c <exit>

00000000000001a4 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
 1a4:	1141                	add	sp,sp,-16
 1a6:	e422                	sd	s0,8(sp)
 1a8:	0800                	add	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 1aa:	87aa                	mv	a5,a0
 1ac:	0585                	add	a1,a1,1
 1ae:	0785                	add	a5,a5,1
 1b0:	fff5c703          	lbu	a4,-1(a1)
 1b4:	fee78fa3          	sb	a4,-1(a5)
 1b8:	fb75                	bnez	a4,1ac <strcpy+0x8>
    ;
  return os;
}
 1ba:	6422                	ld	s0,8(sp)
 1bc:	0141                	add	sp,sp,16
 1be:	8082                	ret

00000000000001c0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 1c0:	1141                	add	sp,sp,-16
 1c2:	e422                	sd	s0,8(sp)
 1c4:	0800                	add	s0,sp,16
  while(*p && *p == *q)
 1c6:	00054783          	lbu	a5,0(a0)
 1ca:	cb91                	beqz	a5,1de <strcmp+0x1e>
 1cc:	0005c703          	lbu	a4,0(a1)
 1d0:	00f71763          	bne	a4,a5,1de <strcmp+0x1e>
    p++, q++;
 1d4:	0505                	add	a0,a0,1
 1d6:	0585                	add	a1,a1,1
  while(*p && *p == *q)
 1d8:	00054783          	lbu	a5,0(a0)
 1dc:	fbe5                	bnez	a5,1cc <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 1de:	0005c503          	lbu	a0,0(a1)
}
 1e2:	40a7853b          	subw	a0,a5,a0
 1e6:	6422                	ld	s0,8(sp)
 1e8:	0141                	add	sp,sp,16
 1ea:	8082                	ret

00000000000001ec <strlen>:

uint
strlen(const char *s)
{
 1ec:	1141                	add	sp,sp,-16
 1ee:	e422                	sd	s0,8(sp)
 1f0:	0800                	add	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 1f2:	00054783          	lbu	a5,0(a0)
 1f6:	cf91                	beqz	a5,212 <strlen+0x26>
 1f8:	0505                	add	a0,a0,1
 1fa:	87aa                	mv	a5,a0
 1fc:	86be                	mv	a3,a5
 1fe:	0785                	add	a5,a5,1
 200:	fff7c703          	lbu	a4,-1(a5)
 204:	ff65                	bnez	a4,1fc <strlen+0x10>
 206:	40a6853b          	subw	a0,a3,a0
 20a:	2505                	addw	a0,a0,1
    ;
  return n;
}
 20c:	6422                	ld	s0,8(sp)
 20e:	0141                	add	sp,sp,16
 210:	8082                	ret
  for(n = 0; s[n]; n++)
 212:	4501                	li	a0,0
 214:	bfe5                	j	20c <strlen+0x20>

0000000000000216 <memset>:

void*
memset(void *dst, int c, uint n)
{
 216:	1141                	add	sp,sp,-16
 218:	e422                	sd	s0,8(sp)
 21a:	0800                	add	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 21c:	ca19                	beqz	a2,232 <memset+0x1c>
 21e:	87aa                	mv	a5,a0
 220:	1602                	sll	a2,a2,0x20
 222:	9201                	srl	a2,a2,0x20
 224:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 228:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 22c:	0785                	add	a5,a5,1
 22e:	fee79de3          	bne	a5,a4,228 <memset+0x12>
  }
  return dst;
}
 232:	6422                	ld	s0,8(sp)
 234:	0141                	add	sp,sp,16
 236:	8082                	ret

0000000000000238 <strchr>:

char*
strchr(const char *s, char c)
{
 238:	1141                	add	sp,sp,-16
 23a:	e422                	sd	s0,8(sp)
 23c:	0800                	add	s0,sp,16
  for(; *s; s++)
 23e:	00054783          	lbu	a5,0(a0)
 242:	cb99                	beqz	a5,258 <strchr+0x20>
    if(*s == c)
 244:	00f58763          	beq	a1,a5,252 <strchr+0x1a>
  for(; *s; s++)
 248:	0505                	add	a0,a0,1
 24a:	00054783          	lbu	a5,0(a0)
 24e:	fbfd                	bnez	a5,244 <strchr+0xc>
      return (char*)s;
  return 0;
 250:	4501                	li	a0,0
}
 252:	6422                	ld	s0,8(sp)
 254:	0141                	add	sp,sp,16
 256:	8082                	ret
  return 0;
 258:	4501                	li	a0,0
 25a:	bfe5                	j	252 <strchr+0x1a>

000000000000025c <gets>:

char*
gets(char *buf, int max)
{
 25c:	711d                	add	sp,sp,-96
 25e:	ec86                	sd	ra,88(sp)
 260:	e8a2                	sd	s0,80(sp)
 262:	e4a6                	sd	s1,72(sp)
 264:	e0ca                	sd	s2,64(sp)
 266:	fc4e                	sd	s3,56(sp)
 268:	f852                	sd	s4,48(sp)
 26a:	f456                	sd	s5,40(sp)
 26c:	f05a                	sd	s6,32(sp)
 26e:	ec5e                	sd	s7,24(sp)
 270:	1080                	add	s0,sp,96
 272:	8baa                	mv	s7,a0
 274:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 276:	892a                	mv	s2,a0
 278:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 27a:	4aa9                	li	s5,10
 27c:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 27e:	89a6                	mv	s3,s1
 280:	2485                	addw	s1,s1,1
 282:	0344d663          	bge	s1,s4,2ae <gets+0x52>
    cc = read(0, &c, 1);
 286:	4605                	li	a2,1
 288:	faf40593          	add	a1,s0,-81
 28c:	4501                	li	a0,0
 28e:	406000ef          	jal	694 <read>
    if(cc < 1)
 292:	00a05e63          	blez	a0,2ae <gets+0x52>
    buf[i++] = c;
 296:	faf44783          	lbu	a5,-81(s0)
 29a:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 29e:	01578763          	beq	a5,s5,2ac <gets+0x50>
 2a2:	0905                	add	s2,s2,1
 2a4:	fd679de3          	bne	a5,s6,27e <gets+0x22>
  for(i=0; i+1 < max; ){
 2a8:	89a6                	mv	s3,s1
 2aa:	a011                	j	2ae <gets+0x52>
 2ac:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 2ae:	99de                	add	s3,s3,s7
 2b0:	00098023          	sb	zero,0(s3)
  return buf;
}
 2b4:	855e                	mv	a0,s7
 2b6:	60e6                	ld	ra,88(sp)
 2b8:	6446                	ld	s0,80(sp)
 2ba:	64a6                	ld	s1,72(sp)
 2bc:	6906                	ld	s2,64(sp)
 2be:	79e2                	ld	s3,56(sp)
 2c0:	7a42                	ld	s4,48(sp)
 2c2:	7aa2                	ld	s5,40(sp)
 2c4:	7b02                	ld	s6,32(sp)
 2c6:	6be2                	ld	s7,24(sp)
 2c8:	6125                	add	sp,sp,96
 2ca:	8082                	ret

00000000000002cc <stat>:

int
stat(const char *n, struct stat *st)
{
 2cc:	1101                	add	sp,sp,-32
 2ce:	ec06                	sd	ra,24(sp)
 2d0:	e822                	sd	s0,16(sp)
 2d2:	e426                	sd	s1,8(sp)
 2d4:	e04a                	sd	s2,0(sp)
 2d6:	1000                	add	s0,sp,32
 2d8:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 2da:	4581                	li	a1,0
 2dc:	3e0000ef          	jal	6bc <open>
  if(fd < 0)
 2e0:	02054163          	bltz	a0,302 <stat+0x36>
 2e4:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 2e6:	85ca                	mv	a1,s2
 2e8:	3ec000ef          	jal	6d4 <fstat>
 2ec:	892a                	mv	s2,a0
  close(fd);
 2ee:	8526                	mv	a0,s1
 2f0:	3b4000ef          	jal	6a4 <close>
  return r;
}
 2f4:	854a                	mv	a0,s2
 2f6:	60e2                	ld	ra,24(sp)
 2f8:	6442                	ld	s0,16(sp)
 2fa:	64a2                	ld	s1,8(sp)
 2fc:	6902                	ld	s2,0(sp)
 2fe:	6105                	add	sp,sp,32
 300:	8082                	ret
    return -1;
 302:	597d                	li	s2,-1
 304:	bfc5                	j	2f4 <stat+0x28>

0000000000000306 <atoi>:

int
atoi(const char *s)
{
 306:	1141                	add	sp,sp,-16
 308:	e422                	sd	s0,8(sp)
 30a:	0800                	add	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 30c:	00054683          	lbu	a3,0(a0)
 310:	fd06879b          	addw	a5,a3,-48
 314:	0ff7f793          	zext.b	a5,a5
 318:	4625                	li	a2,9
 31a:	02f66863          	bltu	a2,a5,34a <atoi+0x44>
 31e:	872a                	mv	a4,a0
  n = 0;
 320:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 322:	0705                	add	a4,a4,1
 324:	0025179b          	sllw	a5,a0,0x2
 328:	9fa9                	addw	a5,a5,a0
 32a:	0017979b          	sllw	a5,a5,0x1
 32e:	9fb5                	addw	a5,a5,a3
 330:	fd07851b          	addw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 334:	00074683          	lbu	a3,0(a4)
 338:	fd06879b          	addw	a5,a3,-48
 33c:	0ff7f793          	zext.b	a5,a5
 340:	fef671e3          	bgeu	a2,a5,322 <atoi+0x1c>
  return n;
}
 344:	6422                	ld	s0,8(sp)
 346:	0141                	add	sp,sp,16
 348:	8082                	ret
  n = 0;
 34a:	4501                	li	a0,0
 34c:	bfe5                	j	344 <atoi+0x3e>

000000000000034e <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 34e:	1141                	add	sp,sp,-16
 350:	e422                	sd	s0,8(sp)
 352:	0800                	add	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 354:	02b57463          	bgeu	a0,a1,37c <memmove+0x2e>
    while(n-- > 0)
 358:	00c05f63          	blez	a2,376 <memmove+0x28>
 35c:	1602                	sll	a2,a2,0x20
 35e:	9201                	srl	a2,a2,0x20
 360:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 364:	872a                	mv	a4,a0
      *dst++ = *src++;
 366:	0585                	add	a1,a1,1
 368:	0705                	add	a4,a4,1
 36a:	fff5c683          	lbu	a3,-1(a1)
 36e:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 372:	fee79ae3          	bne	a5,a4,366 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 376:	6422                	ld	s0,8(sp)
 378:	0141                	add	sp,sp,16
 37a:	8082                	ret
    dst += n;
 37c:	00c50733          	add	a4,a0,a2
    src += n;
 380:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 382:	fec05ae3          	blez	a2,376 <memmove+0x28>
 386:	fff6079b          	addw	a5,a2,-1
 38a:	1782                	sll	a5,a5,0x20
 38c:	9381                	srl	a5,a5,0x20
 38e:	fff7c793          	not	a5,a5
 392:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 394:	15fd                	add	a1,a1,-1
 396:	177d                	add	a4,a4,-1
 398:	0005c683          	lbu	a3,0(a1)
 39c:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 3a0:	fee79ae3          	bne	a5,a4,394 <memmove+0x46>
 3a4:	bfc9                	j	376 <memmove+0x28>

00000000000003a6 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 3a6:	1141                	add	sp,sp,-16
 3a8:	e422                	sd	s0,8(sp)
 3aa:	0800                	add	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 3ac:	ca05                	beqz	a2,3dc <memcmp+0x36>
 3ae:	fff6069b          	addw	a3,a2,-1
 3b2:	1682                	sll	a3,a3,0x20
 3b4:	9281                	srl	a3,a3,0x20
 3b6:	0685                	add	a3,a3,1
 3b8:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 3ba:	00054783          	lbu	a5,0(a0)
 3be:	0005c703          	lbu	a4,0(a1)
 3c2:	00e79863          	bne	a5,a4,3d2 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 3c6:	0505                	add	a0,a0,1
    p2++;
 3c8:	0585                	add	a1,a1,1
  while (n-- > 0) {
 3ca:	fed518e3          	bne	a0,a3,3ba <memcmp+0x14>
  }
  return 0;
 3ce:	4501                	li	a0,0
 3d0:	a019                	j	3d6 <memcmp+0x30>
      return *p1 - *p2;
 3d2:	40e7853b          	subw	a0,a5,a4
}
 3d6:	6422                	ld	s0,8(sp)
 3d8:	0141                	add	sp,sp,16
 3da:	8082                	ret
  return 0;
 3dc:	4501                	li	a0,0
 3de:	bfe5                	j	3d6 <memcmp+0x30>

00000000000003e0 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 3e0:	1141                	add	sp,sp,-16
 3e2:	e406                	sd	ra,8(sp)
 3e4:	e022                	sd	s0,0(sp)
 3e6:	0800                	add	s0,sp,16
  return memmove(dst, src, n);
 3e8:	f67ff0ef          	jal	34e <memmove>
}
 3ec:	60a2                	ld	ra,8(sp)
 3ee:	6402                	ld	s0,0(sp)
 3f0:	0141                	add	sp,sp,16
 3f2:	8082                	ret

00000000000003f4 <htons>:
    return (v & 0x000000ff) << 24 | (v & 0x0000ff00) << 8 | (v & 0x00ff0000) >> 8 | (v & 0xff000000) >> 24;
}

uint16_t
htons(uint16_t h)
{
 3f4:	1141                	add	sp,sp,-16
 3f6:	e422                	sd	s0,8(sp)
 3f8:	0800                	add	s0,sp,16
    if (!endian) {
 3fa:	00001797          	auipc	a5,0x1
 3fe:	c067a783          	lw	a5,-1018(a5) # 1000 <endian>
 402:	e385                	bnez	a5,422 <htons+0x2e>
        endian = byteorder();
 404:	4d200793          	li	a5,1234
 408:	00001717          	auipc	a4,0x1
 40c:	bef72c23          	sw	a5,-1032(a4) # 1000 <endian>
    return (v & 0x00ff) << 8 | (v & 0xff00 ) >> 8;
 410:	0085579b          	srlw	a5,a0,0x8
 414:	0085151b          	sllw	a0,a0,0x8
 418:	8fc9                	or	a5,a5,a0
 41a:	03079513          	sll	a0,a5,0x30
 41e:	9141                	srl	a0,a0,0x30
 420:	a029                	j	42a <htons+0x36>
    }
    return endian == __LITTLE_ENDIAN ? byteswap16(h) : h;
 422:	4d200713          	li	a4,1234
 426:	fee785e3          	beq	a5,a4,410 <htons+0x1c>
}
 42a:	6422                	ld	s0,8(sp)
 42c:	0141                	add	sp,sp,16
 42e:	8082                	ret

0000000000000430 <ntohs>:

uint16_t
ntohs(uint16_t n)
{
 430:	1141                	add	sp,sp,-16
 432:	e422                	sd	s0,8(sp)
 434:	0800                	add	s0,sp,16
    if (!endian) {
 436:	00001797          	auipc	a5,0x1
 43a:	bca7a783          	lw	a5,-1078(a5) # 1000 <endian>
 43e:	e385                	bnez	a5,45e <ntohs+0x2e>
        endian = byteorder();
 440:	4d200793          	li	a5,1234
 444:	00001717          	auipc	a4,0x1
 448:	baf72e23          	sw	a5,-1092(a4) # 1000 <endian>
    return (v & 0x00ff) << 8 | (v & 0xff00 ) >> 8;
 44c:	0085579b          	srlw	a5,a0,0x8
 450:	0085151b          	sllw	a0,a0,0x8
 454:	8fc9                	or	a5,a5,a0
 456:	03079513          	sll	a0,a5,0x30
 45a:	9141                	srl	a0,a0,0x30
 45c:	a029                	j	466 <ntohs+0x36>
    }
    return endian == __LITTLE_ENDIAN ? byteswap16(n) : n;
 45e:	4d200713          	li	a4,1234
 462:	fee785e3          	beq	a5,a4,44c <ntohs+0x1c>
}
 466:	6422                	ld	s0,8(sp)
 468:	0141                	add	sp,sp,16
 46a:	8082                	ret

000000000000046c <htonl>:

uint32_t
htonl(uint32_t h)
{
 46c:	1141                	add	sp,sp,-16
 46e:	e422                	sd	s0,8(sp)
 470:	0800                	add	s0,sp,16
    if (!endian) {
 472:	00001797          	auipc	a5,0x1
 476:	b8e7a783          	lw	a5,-1138(a5) # 1000 <endian>
 47a:	ef85                	bnez	a5,4b2 <htonl+0x46>
        endian = byteorder();
 47c:	4d200793          	li	a5,1234
 480:	00001717          	auipc	a4,0x1
 484:	b8f72023          	sw	a5,-1152(a4) # 1000 <endian>
    return (v & 0x000000ff) << 24 | (v & 0x0000ff00) << 8 | (v & 0x00ff0000) >> 8 | (v & 0xff000000) >> 24;
 488:	0185179b          	sllw	a5,a0,0x18
 48c:	0185571b          	srlw	a4,a0,0x18
 490:	8fd9                	or	a5,a5,a4
 492:	0085171b          	sllw	a4,a0,0x8
 496:	00ff06b7          	lui	a3,0xff0
 49a:	8f75                	and	a4,a4,a3
 49c:	8fd9                	or	a5,a5,a4
 49e:	0085551b          	srlw	a0,a0,0x8
 4a2:	6741                	lui	a4,0x10
 4a4:	f0070713          	add	a4,a4,-256 # ff00 <base+0xeef0>
 4a8:	8d79                	and	a0,a0,a4
 4aa:	8fc9                	or	a5,a5,a0
 4ac:	0007851b          	sext.w	a0,a5
 4b0:	a029                	j	4ba <htonl+0x4e>
    }
    return endian == __LITTLE_ENDIAN ? byteswap32(h) : h;
 4b2:	4d200713          	li	a4,1234
 4b6:	fce789e3          	beq	a5,a4,488 <htonl+0x1c>
}
 4ba:	6422                	ld	s0,8(sp)
 4bc:	0141                	add	sp,sp,16
 4be:	8082                	ret

00000000000004c0 <ntohl>:

uint32_t
ntohl(uint32_t n)
{
 4c0:	1141                	add	sp,sp,-16
 4c2:	e422                	sd	s0,8(sp)
 4c4:	0800                	add	s0,sp,16
    if (!endian) {
 4c6:	00001797          	auipc	a5,0x1
 4ca:	b3a7a783          	lw	a5,-1222(a5) # 1000 <endian>
 4ce:	ef85                	bnez	a5,506 <ntohl+0x46>
        endian = byteorder();
 4d0:	4d200793          	li	a5,1234
 4d4:	00001717          	auipc	a4,0x1
 4d8:	b2f72623          	sw	a5,-1236(a4) # 1000 <endian>
    return (v & 0x000000ff) << 24 | (v & 0x0000ff00) << 8 | (v & 0x00ff0000) >> 8 | (v & 0xff000000) >> 24;
 4dc:	0185179b          	sllw	a5,a0,0x18
 4e0:	0185571b          	srlw	a4,a0,0x18
 4e4:	8fd9                	or	a5,a5,a4
 4e6:	0085171b          	sllw	a4,a0,0x8
 4ea:	00ff06b7          	lui	a3,0xff0
 4ee:	8f75                	and	a4,a4,a3
 4f0:	8fd9                	or	a5,a5,a4
 4f2:	0085551b          	srlw	a0,a0,0x8
 4f6:	6741                	lui	a4,0x10
 4f8:	f0070713          	add	a4,a4,-256 # ff00 <base+0xeef0>
 4fc:	8d79                	and	a0,a0,a4
 4fe:	8fc9                	or	a5,a5,a0
 500:	0007851b          	sext.w	a0,a5
 504:	a029                	j	50e <ntohl+0x4e>
    }
    return endian == __LITTLE_ENDIAN ? byteswap32(n) : n;
 506:	4d200713          	li	a4,1234
 50a:	fce789e3          	beq	a5,a4,4dc <ntohl+0x1c>
}
 50e:	6422                	ld	s0,8(sp)
 510:	0141                	add	sp,sp,16
 512:	8082                	ret

0000000000000514 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
 514:	1141                	add	sp,sp,-16
 516:	e422                	sd	s0,8(sp)
 518:	0800                	add	s0,sp,16
 51a:	872a                	mv	a4,a0
    int neg = 0;
    long val = 0;

    // gobble initial whitespace
    while (*s == ' ' || *s == '\t')
 51c:	02000693          	li	a3,32
 520:	4525                	li	a0,9
 522:	a011                	j	526 <strtol+0x12>
        s++;
 524:	0705                	add	a4,a4,1
    while (*s == ' ' || *s == '\t')
 526:	00074783          	lbu	a5,0(a4)
 52a:	fed78de3          	beq	a5,a3,524 <strtol+0x10>
 52e:	fea78be3          	beq	a5,a0,524 <strtol+0x10>

    // plus/minus sign
    if (*s == '+')
 532:	02b00693          	li	a3,43
 536:	02d78663          	beq	a5,a3,562 <strtol+0x4e>
        s++;
    else if (*s == '-')
 53a:	02d00693          	li	a3,45
    int neg = 0;
 53e:	4301                	li	t1,0
    else if (*s == '-')
 540:	02d78463          	beq	a5,a3,568 <strtol+0x54>
        s++, neg = 1;

    // hex or octal base prefix
    if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
 544:	fef67793          	and	a5,a2,-17
 548:	eb89                	bnez	a5,55a <strtol+0x46>
 54a:	00074683          	lbu	a3,0(a4)
 54e:	03000793          	li	a5,48
 552:	00f68e63          	beq	a3,a5,56e <strtol+0x5a>
        s += 2, base = 16;
    else if (base == 0 && s[0] == '0')
 556:	e211                	bnez	a2,55a <strtol+0x46>
        s++, base = 8;
    else if (base == 0)
        base = 10;
 558:	4629                	li	a2,10
 55a:	4501                	li	a0,0

    // digits
    while (1) {
        int dig;

        if (*s >= '0' && *s <= '9')
 55c:	4825                	li	a6,9
            dig = *s - '0';
        else if (*s >= 'a' && *s <= 'z')
 55e:	48e5                	li	a7,25
 560:	a825                	j	598 <strtol+0x84>
        s++;
 562:	0705                	add	a4,a4,1
    int neg = 0;
 564:	4301                	li	t1,0
 566:	bff9                	j	544 <strtol+0x30>
        s++, neg = 1;
 568:	0705                	add	a4,a4,1
 56a:	4305                	li	t1,1
 56c:	bfe1                	j	544 <strtol+0x30>
    if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
 56e:	00174683          	lbu	a3,1(a4)
 572:	07800793          	li	a5,120
 576:	00f68663          	beq	a3,a5,582 <strtol+0x6e>
    else if (base == 0 && s[0] == '0')
 57a:	f265                	bnez	a2,55a <strtol+0x46>
        s++, base = 8;
 57c:	0705                	add	a4,a4,1
 57e:	4621                	li	a2,8
 580:	bfe9                	j	55a <strtol+0x46>
        s += 2, base = 16;
 582:	0709                	add	a4,a4,2
 584:	4641                	li	a2,16
 586:	bfd1                	j	55a <strtol+0x46>
            dig = *s - '0';
 588:	fd07879b          	addw	a5,a5,-48
            dig = *s - 'a' + 10;
        else if (*s >= 'A' && *s <= 'Z')
            dig = *s - 'A' + 10;
        else
            break;
        if (dig >= base)
 58c:	04c7d063          	bge	a5,a2,5cc <strtol+0xb8>
            break;
        s++, val = (val * base) + dig;
 590:	0705                	add	a4,a4,1
 592:	02a60533          	mul	a0,a2,a0
 596:	953e                	add	a0,a0,a5
        if (*s >= '0' && *s <= '9')
 598:	00074783          	lbu	a5,0(a4)
 59c:	fd07869b          	addw	a3,a5,-48
 5a0:	0ff6f693          	zext.b	a3,a3
 5a4:	fed872e3          	bgeu	a6,a3,588 <strtol+0x74>
        else if (*s >= 'a' && *s <= 'z')
 5a8:	f9f7869b          	addw	a3,a5,-97
 5ac:	0ff6f693          	zext.b	a3,a3
 5b0:	00d8e563          	bltu	a7,a3,5ba <strtol+0xa6>
            dig = *s - 'a' + 10;
 5b4:	fa97879b          	addw	a5,a5,-87
 5b8:	bfd1                	j	58c <strtol+0x78>
        else if (*s >= 'A' && *s <= 'Z')
 5ba:	fbf7869b          	addw	a3,a5,-65
 5be:	0ff6f693          	zext.b	a3,a3
 5c2:	00d8e563          	bltu	a7,a3,5cc <strtol+0xb8>
            dig = *s - 'A' + 10;
 5c6:	fc97879b          	addw	a5,a5,-55
 5ca:	b7c9                	j	58c <strtol+0x78>
        // we don't properly detect overflow!
    }

    if (endptr)
 5cc:	c191                	beqz	a1,5d0 <strtol+0xbc>
        *endptr = (char *) s;
 5ce:	e198                	sd	a4,0(a1)
    return (neg ? -val : val);
 5d0:	00030463          	beqz	t1,5d8 <strtol+0xc4>
 5d4:	40a00533          	neg	a0,a0
}
 5d8:	6422                	ld	s0,8(sp)
 5da:	0141                	add	sp,sp,16
 5dc:	8082                	ret

00000000000005de <inet_pton>:
inet_pton (int family, const char *p, void *n) {
    char *sp, *ep;
    int idx;
    long ret;

    if (family != AF_INET) {
 5de:	4785                	li	a5,1
 5e0:	08f51263          	bne	a0,a5,664 <inet_pton+0x86>
inet_pton (int family, const char *p, void *n) {
 5e4:	715d                	add	sp,sp,-80
 5e6:	e486                	sd	ra,72(sp)
 5e8:	e0a2                	sd	s0,64(sp)
 5ea:	fc26                	sd	s1,56(sp)
 5ec:	f84a                	sd	s2,48(sp)
 5ee:	f44e                	sd	s3,40(sp)
 5f0:	f052                	sd	s4,32(sp)
 5f2:	ec56                	sd	s5,24(sp)
 5f4:	e85a                	sd	s6,16(sp)
 5f6:	0880                	add	s0,sp,80
 5f8:	892e                	mv	s2,a1
 5fa:	89b2                	mv	s3,a2
 5fc:	4481                	li	s1,0
        return -1;
    }
    sp = (char *)p;
    for (idx = 0; idx < 4; idx++) {
        ret = strtol(sp, &ep, 10);
        if (ret < 0 || ret > 255) {
 5fe:	0ff00a13          	li	s4,255
            return -1;
        }
        if (ep == sp) {
            return -1;
        }
        if ((idx == 3 && *ep != '\0') || (idx != 3 && *ep != '.')) {
 602:	4a8d                	li	s5,3
 604:	02e00b13          	li	s6,46
 608:	a815                	j	63c <inet_pton+0x5e>
 60a:	0007c783          	lbu	a5,0(a5)
 60e:	e3ad                	bnez	a5,670 <inet_pton+0x92>
            return -1;
        }
        ((uint8_t *)n)[idx] = ret;
 610:	2481                	sext.w	s1,s1
 612:	99a6                	add	s3,s3,s1
 614:	00a98023          	sb	a0,0(s3)
        sp = ep + 1;
    }
    return 0;
 618:	4501                	li	a0,0
}
 61a:	60a6                	ld	ra,72(sp)
 61c:	6406                	ld	s0,64(sp)
 61e:	74e2                	ld	s1,56(sp)
 620:	7942                	ld	s2,48(sp)
 622:	79a2                	ld	s3,40(sp)
 624:	7a02                	ld	s4,32(sp)
 626:	6ae2                	ld	s5,24(sp)
 628:	6b42                	ld	s6,16(sp)
 62a:	6161                	add	sp,sp,80
 62c:	8082                	ret
        ((uint8_t *)n)[idx] = ret;
 62e:	00998733          	add	a4,s3,s1
 632:	00a70023          	sb	a0,0(a4)
        sp = ep + 1;
 636:	00178913          	add	s2,a5,1
    for (idx = 0; idx < 4; idx++) {
 63a:	0485                	add	s1,s1,1
        ret = strtol(sp, &ep, 10);
 63c:	4629                	li	a2,10
 63e:	fb840593          	add	a1,s0,-72
 642:	854a                	mv	a0,s2
 644:	ed1ff0ef          	jal	514 <strtol>
        if (ret < 0 || ret > 255) {
 648:	02aa6063          	bltu	s4,a0,668 <inet_pton+0x8a>
        if (ep == sp) {
 64c:	fb843783          	ld	a5,-72(s0)
 650:	01278e63          	beq	a5,s2,66c <inet_pton+0x8e>
        if ((idx == 3 && *ep != '\0') || (idx != 3 && *ep != '.')) {
 654:	fb548be3          	beq	s1,s5,60a <inet_pton+0x2c>
 658:	0007c703          	lbu	a4,0(a5)
 65c:	fd6709e3          	beq	a4,s6,62e <inet_pton+0x50>
            return -1;
 660:	557d                	li	a0,-1
 662:	bf65                	j	61a <inet_pton+0x3c>
        return -1;
 664:	557d                	li	a0,-1
}
 666:	8082                	ret
            return -1;
 668:	557d                	li	a0,-1
 66a:	bf45                	j	61a <inet_pton+0x3c>
            return -1;
 66c:	557d                	li	a0,-1
 66e:	b775                	j	61a <inet_pton+0x3c>
            return -1;
 670:	557d                	li	a0,-1
 672:	b765                	j	61a <inet_pton+0x3c>

0000000000000674 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 674:	4885                	li	a7,1
 ecall
 676:	00000073          	ecall
 ret
 67a:	8082                	ret

000000000000067c <exit>:
.global exit
exit:
 li a7, SYS_exit
 67c:	4889                	li	a7,2
 ecall
 67e:	00000073          	ecall
 ret
 682:	8082                	ret

0000000000000684 <wait>:
.global wait
wait:
 li a7, SYS_wait
 684:	488d                	li	a7,3
 ecall
 686:	00000073          	ecall
 ret
 68a:	8082                	ret

000000000000068c <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 68c:	4891                	li	a7,4
 ecall
 68e:	00000073          	ecall
 ret
 692:	8082                	ret

0000000000000694 <read>:
.global read
read:
 li a7, SYS_read
 694:	4895                	li	a7,5
 ecall
 696:	00000073          	ecall
 ret
 69a:	8082                	ret

000000000000069c <write>:
.global write
write:
 li a7, SYS_write
 69c:	48c1                	li	a7,16
 ecall
 69e:	00000073          	ecall
 ret
 6a2:	8082                	ret

00000000000006a4 <close>:
.global close
close:
 li a7, SYS_close
 6a4:	48d5                	li	a7,21
 ecall
 6a6:	00000073          	ecall
 ret
 6aa:	8082                	ret

00000000000006ac <kill>:
.global kill
kill:
 li a7, SYS_kill
 6ac:	4899                	li	a7,6
 ecall
 6ae:	00000073          	ecall
 ret
 6b2:	8082                	ret

00000000000006b4 <exec>:
.global exec
exec:
 li a7, SYS_exec
 6b4:	489d                	li	a7,7
 ecall
 6b6:	00000073          	ecall
 ret
 6ba:	8082                	ret

00000000000006bc <open>:
.global open
open:
 li a7, SYS_open
 6bc:	48bd                	li	a7,15
 ecall
 6be:	00000073          	ecall
 ret
 6c2:	8082                	ret

00000000000006c4 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 6c4:	48c5                	li	a7,17
 ecall
 6c6:	00000073          	ecall
 ret
 6ca:	8082                	ret

00000000000006cc <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 6cc:	48c9                	li	a7,18
 ecall
 6ce:	00000073          	ecall
 ret
 6d2:	8082                	ret

00000000000006d4 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 6d4:	48a1                	li	a7,8
 ecall
 6d6:	00000073          	ecall
 ret
 6da:	8082                	ret

00000000000006dc <link>:
.global link
link:
 li a7, SYS_link
 6dc:	48cd                	li	a7,19
 ecall
 6de:	00000073          	ecall
 ret
 6e2:	8082                	ret

00000000000006e4 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 6e4:	48d1                	li	a7,20
 ecall
 6e6:	00000073          	ecall
 ret
 6ea:	8082                	ret

00000000000006ec <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 6ec:	48a5                	li	a7,9
 ecall
 6ee:	00000073          	ecall
 ret
 6f2:	8082                	ret

00000000000006f4 <dup>:
.global dup
dup:
 li a7, SYS_dup
 6f4:	48a9                	li	a7,10
 ecall
 6f6:	00000073          	ecall
 ret
 6fa:	8082                	ret

00000000000006fc <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 6fc:	48ad                	li	a7,11
 ecall
 6fe:	00000073          	ecall
 ret
 702:	8082                	ret

0000000000000704 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 704:	48b1                	li	a7,12
 ecall
 706:	00000073          	ecall
 ret
 70a:	8082                	ret

000000000000070c <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 70c:	48b5                	li	a7,13
 ecall
 70e:	00000073          	ecall
 ret
 712:	8082                	ret

0000000000000714 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 714:	48b9                	li	a7,14
 ecall
 716:	00000073          	ecall
 ret
 71a:	8082                	ret

000000000000071c <socket>:
.global socket
socket:
 li a7, SYS_socket
 71c:	48d9                	li	a7,22
 ecall
 71e:	00000073          	ecall
 ret
 722:	8082                	ret

0000000000000724 <bind>:
.global bind
bind:
 li a7, SYS_bind
 724:	48dd                	li	a7,23
 ecall
 726:	00000073          	ecall
 ret
 72a:	8082                	ret

000000000000072c <recvfrom>:
.global recvfrom
recvfrom:
 li a7, SYS_recvfrom
 72c:	48e1                	li	a7,24
 ecall
 72e:	00000073          	ecall
 ret
 732:	8082                	ret

0000000000000734 <sendto>:
.global sendto
sendto:
 li a7, SYS_sendto
 734:	48e5                	li	a7,25
 ecall
 736:	00000073          	ecall
 ret
 73a:	8082                	ret

000000000000073c <connect>:
.global connect
connect:
 li a7, SYS_connect
 73c:	48e9                	li	a7,26
 ecall
 73e:	00000073          	ecall
 ret
 742:	8082                	ret

0000000000000744 <listen>:
.global listen
listen:
 li a7, SYS_listen
 744:	48ed                	li	a7,27
 ecall
 746:	00000073          	ecall
 ret
 74a:	8082                	ret

000000000000074c <accept>:
.global accept
accept:
 li a7, SYS_accept
 74c:	48f1                	li	a7,28
 ecall
 74e:	00000073          	ecall
 ret
 752:	8082                	ret

0000000000000754 <recv>:
.global recv
recv:
 li a7, SYS_recv
 754:	48f5                	li	a7,29
 ecall
 756:	00000073          	ecall
 ret
 75a:	8082                	ret

000000000000075c <send>:
.global send
send:
 li a7, SYS_send
 75c:	48f9                	li	a7,30
 ecall
 75e:	00000073          	ecall
 ret
 762:	8082                	ret

0000000000000764 <ioctl>:
.global ioctl
ioctl:
 li a7, SYS_ioctl
 764:	48fd                	li	a7,31
 ecall
 766:	00000073          	ecall
 ret
 76a:	8082                	ret

000000000000076c <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 76c:	1101                	add	sp,sp,-32
 76e:	ec06                	sd	ra,24(sp)
 770:	e822                	sd	s0,16(sp)
 772:	1000                	add	s0,sp,32
 774:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 778:	4605                	li	a2,1
 77a:	fef40593          	add	a1,s0,-17
 77e:	f1fff0ef          	jal	69c <write>
}
 782:	60e2                	ld	ra,24(sp)
 784:	6442                	ld	s0,16(sp)
 786:	6105                	add	sp,sp,32
 788:	8082                	ret

000000000000078a <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
 78a:	715d                	add	sp,sp,-80
 78c:	e486                	sd	ra,72(sp)
 78e:	e0a2                	sd	s0,64(sp)
 790:	fc26                	sd	s1,56(sp)
 792:	f84a                	sd	s2,48(sp)
 794:	f44e                	sd	s3,40(sp)
 796:	0880                	add	s0,sp,80
 798:	84aa                	mv	s1,a0
  char buf[20];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 79a:	c299                	beqz	a3,7a0 <printint+0x16>
 79c:	0805c763          	bltz	a1,82a <printint+0xa0>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 7a0:	2581                	sext.w	a1,a1
  neg = 0;
 7a2:	4881                	li	a7,0
 7a4:	fb840693          	add	a3,s0,-72
  }

  i = 0;
 7a8:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 7aa:	2601                	sext.w	a2,a2
 7ac:	00000517          	auipc	a0,0x0
 7b0:	5f450513          	add	a0,a0,1524 # da0 <digits>
 7b4:	883a                	mv	a6,a4
 7b6:	2705                	addw	a4,a4,1
 7b8:	02c5f7bb          	remuw	a5,a1,a2
 7bc:	1782                	sll	a5,a5,0x20
 7be:	9381                	srl	a5,a5,0x20
 7c0:	97aa                	add	a5,a5,a0
 7c2:	0007c783          	lbu	a5,0(a5)
 7c6:	00f68023          	sb	a5,0(a3) # ff0000 <base+0xfeeff0>
  }while((x /= base) != 0);
 7ca:	0005879b          	sext.w	a5,a1
 7ce:	02c5d5bb          	divuw	a1,a1,a2
 7d2:	0685                	add	a3,a3,1
 7d4:	fec7f0e3          	bgeu	a5,a2,7b4 <printint+0x2a>
  if(neg)
 7d8:	00088c63          	beqz	a7,7f0 <printint+0x66>
    buf[i++] = '-';
 7dc:	fd070793          	add	a5,a4,-48
 7e0:	00878733          	add	a4,a5,s0
 7e4:	02d00793          	li	a5,45
 7e8:	fef70423          	sb	a5,-24(a4)
 7ec:	0028071b          	addw	a4,a6,2

  while(--i >= 0)
 7f0:	02e05663          	blez	a4,81c <printint+0x92>
 7f4:	fb840793          	add	a5,s0,-72
 7f8:	00e78933          	add	s2,a5,a4
 7fc:	fff78993          	add	s3,a5,-1
 800:	99ba                	add	s3,s3,a4
 802:	377d                	addw	a4,a4,-1
 804:	1702                	sll	a4,a4,0x20
 806:	9301                	srl	a4,a4,0x20
 808:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 80c:	fff94583          	lbu	a1,-1(s2)
 810:	8526                	mv	a0,s1
 812:	f5bff0ef          	jal	76c <putc>
  while(--i >= 0)
 816:	197d                	add	s2,s2,-1
 818:	ff391ae3          	bne	s2,s3,80c <printint+0x82>
}
 81c:	60a6                	ld	ra,72(sp)
 81e:	6406                	ld	s0,64(sp)
 820:	74e2                	ld	s1,56(sp)
 822:	7942                	ld	s2,48(sp)
 824:	79a2                	ld	s3,40(sp)
 826:	6161                	add	sp,sp,80
 828:	8082                	ret
    x = -xx;
 82a:	40b005bb          	negw	a1,a1
    neg = 1;
 82e:	4885                	li	a7,1
    x = -xx;
 830:	bf95                	j	7a4 <printint+0x1a>

0000000000000832 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 832:	711d                	add	sp,sp,-96
 834:	ec86                	sd	ra,88(sp)
 836:	e8a2                	sd	s0,80(sp)
 838:	e4a6                	sd	s1,72(sp)
 83a:	e0ca                	sd	s2,64(sp)
 83c:	fc4e                	sd	s3,56(sp)
 83e:	f852                	sd	s4,48(sp)
 840:	f456                	sd	s5,40(sp)
 842:	f05a                	sd	s6,32(sp)
 844:	ec5e                	sd	s7,24(sp)
 846:	e862                	sd	s8,16(sp)
 848:	e466                	sd	s9,8(sp)
 84a:	e06a                	sd	s10,0(sp)
 84c:	1080                	add	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 84e:	0005c903          	lbu	s2,0(a1)
 852:	24090763          	beqz	s2,aa0 <vprintf+0x26e>
 856:	8b2a                	mv	s6,a0
 858:	8a2e                	mv	s4,a1
 85a:	8bb2                	mv	s7,a2
  state = 0;
 85c:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
 85e:	4481                	li	s1,0
 860:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
 862:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
 866:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
 86a:	06c00c93          	li	s9,108
 86e:	a005                	j	88e <vprintf+0x5c>
        putc(fd, c0);
 870:	85ca                	mv	a1,s2
 872:	855a                	mv	a0,s6
 874:	ef9ff0ef          	jal	76c <putc>
 878:	a019                	j	87e <vprintf+0x4c>
    } else if(state == '%'){
 87a:	03598263          	beq	s3,s5,89e <vprintf+0x6c>
  for(i = 0; fmt[i]; i++){
 87e:	2485                	addw	s1,s1,1
 880:	8726                	mv	a4,s1
 882:	009a07b3          	add	a5,s4,s1
 886:	0007c903          	lbu	s2,0(a5)
 88a:	20090b63          	beqz	s2,aa0 <vprintf+0x26e>
    c0 = fmt[i] & 0xff;
 88e:	0009079b          	sext.w	a5,s2
    if(state == 0){
 892:	fe0994e3          	bnez	s3,87a <vprintf+0x48>
      if(c0 == '%'){
 896:	fd579de3          	bne	a5,s5,870 <vprintf+0x3e>
        state = '%';
 89a:	89be                	mv	s3,a5
 89c:	b7cd                	j	87e <vprintf+0x4c>
      if(c0) c1 = fmt[i+1] & 0xff;
 89e:	c7c9                	beqz	a5,928 <vprintf+0xf6>
 8a0:	00ea06b3          	add	a3,s4,a4
 8a4:	0016c683          	lbu	a3,1(a3)
      c1 = c2 = 0;
 8a8:	8636                	mv	a2,a3
      if(c1) c2 = fmt[i+2] & 0xff;
 8aa:	c681                	beqz	a3,8b2 <vprintf+0x80>
 8ac:	9752                	add	a4,a4,s4
 8ae:	00274603          	lbu	a2,2(a4)
      if(c0 == 'd'){
 8b2:	03878f63          	beq	a5,s8,8f0 <vprintf+0xbe>
      } else if(c0 == 'l' && c1 == 'd'){
 8b6:	05978963          	beq	a5,s9,908 <vprintf+0xd6>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
 8ba:	07500713          	li	a4,117
 8be:	0ee78363          	beq	a5,a4,9a4 <vprintf+0x172>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
 8c2:	07800713          	li	a4,120
 8c6:	12e78563          	beq	a5,a4,9f0 <vprintf+0x1be>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
 8ca:	07000713          	li	a4,112
 8ce:	14e78a63          	beq	a5,a4,a22 <vprintf+0x1f0>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 's'){
 8d2:	07300713          	li	a4,115
 8d6:	18e78863          	beq	a5,a4,a66 <vprintf+0x234>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
 8da:	02500713          	li	a4,37
 8de:	04e79563          	bne	a5,a4,928 <vprintf+0xf6>
        putc(fd, '%');
 8e2:	02500593          	li	a1,37
 8e6:	855a                	mv	a0,s6
 8e8:	e85ff0ef          	jal	76c <putc>
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
#endif
      state = 0;
 8ec:	4981                	li	s3,0
 8ee:	bf41                	j	87e <vprintf+0x4c>
        printint(fd, va_arg(ap, int), 10, 1);
 8f0:	008b8913          	add	s2,s7,8
 8f4:	4685                	li	a3,1
 8f6:	4629                	li	a2,10
 8f8:	000ba583          	lw	a1,0(s7)
 8fc:	855a                	mv	a0,s6
 8fe:	e8dff0ef          	jal	78a <printint>
 902:	8bca                	mv	s7,s2
      state = 0;
 904:	4981                	li	s3,0
 906:	bfa5                	j	87e <vprintf+0x4c>
      } else if(c0 == 'l' && c1 == 'd'){
 908:	06400793          	li	a5,100
 90c:	02f68963          	beq	a3,a5,93e <vprintf+0x10c>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 910:	06c00793          	li	a5,108
 914:	04f68263          	beq	a3,a5,958 <vprintf+0x126>
      } else if(c0 == 'l' && c1 == 'u'){
 918:	07500793          	li	a5,117
 91c:	0af68063          	beq	a3,a5,9bc <vprintf+0x18a>
      } else if(c0 == 'l' && c1 == 'x'){
 920:	07800793          	li	a5,120
 924:	0ef68263          	beq	a3,a5,a08 <vprintf+0x1d6>
        putc(fd, '%');
 928:	02500593          	li	a1,37
 92c:	855a                	mv	a0,s6
 92e:	e3fff0ef          	jal	76c <putc>
        putc(fd, c0);
 932:	85ca                	mv	a1,s2
 934:	855a                	mv	a0,s6
 936:	e37ff0ef          	jal	76c <putc>
      state = 0;
 93a:	4981                	li	s3,0
 93c:	b789                	j	87e <vprintf+0x4c>
        printint(fd, va_arg(ap, uint64), 10, 1);
 93e:	008b8913          	add	s2,s7,8
 942:	4685                	li	a3,1
 944:	4629                	li	a2,10
 946:	000bb583          	ld	a1,0(s7)
 94a:	855a                	mv	a0,s6
 94c:	e3fff0ef          	jal	78a <printint>
        i += 1;
 950:	2485                	addw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 952:	8bca                	mv	s7,s2
      state = 0;
 954:	4981                	li	s3,0
        i += 1;
 956:	b725                	j	87e <vprintf+0x4c>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 958:	06400793          	li	a5,100
 95c:	02f60763          	beq	a2,a5,98a <vprintf+0x158>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 960:	07500793          	li	a5,117
 964:	06f60963          	beq	a2,a5,9d6 <vprintf+0x1a4>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 968:	07800793          	li	a5,120
 96c:	faf61ee3          	bne	a2,a5,928 <vprintf+0xf6>
        printint(fd, va_arg(ap, uint64), 16, 0);
 970:	008b8913          	add	s2,s7,8
 974:	4681                	li	a3,0
 976:	4641                	li	a2,16
 978:	000bb583          	ld	a1,0(s7)
 97c:	855a                	mv	a0,s6
 97e:	e0dff0ef          	jal	78a <printint>
        i += 2;
 982:	2489                	addw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 984:	8bca                	mv	s7,s2
      state = 0;
 986:	4981                	li	s3,0
        i += 2;
 988:	bddd                	j	87e <vprintf+0x4c>
        printint(fd, va_arg(ap, uint64), 10, 1);
 98a:	008b8913          	add	s2,s7,8
 98e:	4685                	li	a3,1
 990:	4629                	li	a2,10
 992:	000bb583          	ld	a1,0(s7)
 996:	855a                	mv	a0,s6
 998:	df3ff0ef          	jal	78a <printint>
        i += 2;
 99c:	2489                	addw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 99e:	8bca                	mv	s7,s2
      state = 0;
 9a0:	4981                	li	s3,0
        i += 2;
 9a2:	bdf1                	j	87e <vprintf+0x4c>
        printint(fd, va_arg(ap, int), 10, 0);
 9a4:	008b8913          	add	s2,s7,8
 9a8:	4681                	li	a3,0
 9aa:	4629                	li	a2,10
 9ac:	000ba583          	lw	a1,0(s7)
 9b0:	855a                	mv	a0,s6
 9b2:	dd9ff0ef          	jal	78a <printint>
 9b6:	8bca                	mv	s7,s2
      state = 0;
 9b8:	4981                	li	s3,0
 9ba:	b5d1                	j	87e <vprintf+0x4c>
        printint(fd, va_arg(ap, uint64), 10, 0);
 9bc:	008b8913          	add	s2,s7,8
 9c0:	4681                	li	a3,0
 9c2:	4629                	li	a2,10
 9c4:	000bb583          	ld	a1,0(s7)
 9c8:	855a                	mv	a0,s6
 9ca:	dc1ff0ef          	jal	78a <printint>
        i += 1;
 9ce:	2485                	addw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 9d0:	8bca                	mv	s7,s2
      state = 0;
 9d2:	4981                	li	s3,0
        i += 1;
 9d4:	b56d                	j	87e <vprintf+0x4c>
        printint(fd, va_arg(ap, uint64), 10, 0);
 9d6:	008b8913          	add	s2,s7,8
 9da:	4681                	li	a3,0
 9dc:	4629                	li	a2,10
 9de:	000bb583          	ld	a1,0(s7)
 9e2:	855a                	mv	a0,s6
 9e4:	da7ff0ef          	jal	78a <printint>
        i += 2;
 9e8:	2489                	addw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 9ea:	8bca                	mv	s7,s2
      state = 0;
 9ec:	4981                	li	s3,0
        i += 2;
 9ee:	bd41                	j	87e <vprintf+0x4c>
        printint(fd, va_arg(ap, int), 16, 0);
 9f0:	008b8913          	add	s2,s7,8
 9f4:	4681                	li	a3,0
 9f6:	4641                	li	a2,16
 9f8:	000ba583          	lw	a1,0(s7)
 9fc:	855a                	mv	a0,s6
 9fe:	d8dff0ef          	jal	78a <printint>
 a02:	8bca                	mv	s7,s2
      state = 0;
 a04:	4981                	li	s3,0
 a06:	bda5                	j	87e <vprintf+0x4c>
        printint(fd, va_arg(ap, uint64), 16, 0);
 a08:	008b8913          	add	s2,s7,8
 a0c:	4681                	li	a3,0
 a0e:	4641                	li	a2,16
 a10:	000bb583          	ld	a1,0(s7)
 a14:	855a                	mv	a0,s6
 a16:	d75ff0ef          	jal	78a <printint>
        i += 1;
 a1a:	2485                	addw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 a1c:	8bca                	mv	s7,s2
      state = 0;
 a1e:	4981                	li	s3,0
        i += 1;
 a20:	bdb9                	j	87e <vprintf+0x4c>
        printptr(fd, va_arg(ap, uint64));
 a22:	008b8d13          	add	s10,s7,8
 a26:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 a2a:	03000593          	li	a1,48
 a2e:	855a                	mv	a0,s6
 a30:	d3dff0ef          	jal	76c <putc>
  putc(fd, 'x');
 a34:	07800593          	li	a1,120
 a38:	855a                	mv	a0,s6
 a3a:	d33ff0ef          	jal	76c <putc>
 a3e:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 a40:	00000b97          	auipc	s7,0x0
 a44:	360b8b93          	add	s7,s7,864 # da0 <digits>
 a48:	03c9d793          	srl	a5,s3,0x3c
 a4c:	97de                	add	a5,a5,s7
 a4e:	0007c583          	lbu	a1,0(a5)
 a52:	855a                	mv	a0,s6
 a54:	d19ff0ef          	jal	76c <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 a58:	0992                	sll	s3,s3,0x4
 a5a:	397d                	addw	s2,s2,-1
 a5c:	fe0916e3          	bnez	s2,a48 <vprintf+0x216>
        printptr(fd, va_arg(ap, uint64));
 a60:	8bea                	mv	s7,s10
      state = 0;
 a62:	4981                	li	s3,0
 a64:	bd29                	j	87e <vprintf+0x4c>
        if((s = va_arg(ap, char*)) == 0)
 a66:	008b8993          	add	s3,s7,8
 a6a:	000bb903          	ld	s2,0(s7)
 a6e:	00090f63          	beqz	s2,a8c <vprintf+0x25a>
        for(; *s; s++)
 a72:	00094583          	lbu	a1,0(s2)
 a76:	c195                	beqz	a1,a9a <vprintf+0x268>
          putc(fd, *s);
 a78:	855a                	mv	a0,s6
 a7a:	cf3ff0ef          	jal	76c <putc>
        for(; *s; s++)
 a7e:	0905                	add	s2,s2,1
 a80:	00094583          	lbu	a1,0(s2)
 a84:	f9f5                	bnez	a1,a78 <vprintf+0x246>
        if((s = va_arg(ap, char*)) == 0)
 a86:	8bce                	mv	s7,s3
      state = 0;
 a88:	4981                	li	s3,0
 a8a:	bbd5                	j	87e <vprintf+0x4c>
          s = "(null)";
 a8c:	00000917          	auipc	s2,0x0
 a90:	30c90913          	add	s2,s2,780 # d98 <malloc+0x1fe>
        for(; *s; s++)
 a94:	02800593          	li	a1,40
 a98:	b7c5                	j	a78 <vprintf+0x246>
        if((s = va_arg(ap, char*)) == 0)
 a9a:	8bce                	mv	s7,s3
      state = 0;
 a9c:	4981                	li	s3,0
 a9e:	b3c5                	j	87e <vprintf+0x4c>
    }
  }
}
 aa0:	60e6                	ld	ra,88(sp)
 aa2:	6446                	ld	s0,80(sp)
 aa4:	64a6                	ld	s1,72(sp)
 aa6:	6906                	ld	s2,64(sp)
 aa8:	79e2                	ld	s3,56(sp)
 aaa:	7a42                	ld	s4,48(sp)
 aac:	7aa2                	ld	s5,40(sp)
 aae:	7b02                	ld	s6,32(sp)
 ab0:	6be2                	ld	s7,24(sp)
 ab2:	6c42                	ld	s8,16(sp)
 ab4:	6ca2                	ld	s9,8(sp)
 ab6:	6d02                	ld	s10,0(sp)
 ab8:	6125                	add	sp,sp,96
 aba:	8082                	ret

0000000000000abc <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 abc:	715d                	add	sp,sp,-80
 abe:	ec06                	sd	ra,24(sp)
 ac0:	e822                	sd	s0,16(sp)
 ac2:	1000                	add	s0,sp,32
 ac4:	e010                	sd	a2,0(s0)
 ac6:	e414                	sd	a3,8(s0)
 ac8:	e818                	sd	a4,16(s0)
 aca:	ec1c                	sd	a5,24(s0)
 acc:	03043023          	sd	a6,32(s0)
 ad0:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 ad4:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 ad8:	8622                	mv	a2,s0
 ada:	d59ff0ef          	jal	832 <vprintf>
}
 ade:	60e2                	ld	ra,24(sp)
 ae0:	6442                	ld	s0,16(sp)
 ae2:	6161                	add	sp,sp,80
 ae4:	8082                	ret

0000000000000ae6 <printf>:

void
printf(const char *fmt, ...)
{
 ae6:	711d                	add	sp,sp,-96
 ae8:	ec06                	sd	ra,24(sp)
 aea:	e822                	sd	s0,16(sp)
 aec:	1000                	add	s0,sp,32
 aee:	e40c                	sd	a1,8(s0)
 af0:	e810                	sd	a2,16(s0)
 af2:	ec14                	sd	a3,24(s0)
 af4:	f018                	sd	a4,32(s0)
 af6:	f41c                	sd	a5,40(s0)
 af8:	03043823          	sd	a6,48(s0)
 afc:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 b00:	00840613          	add	a2,s0,8
 b04:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 b08:	85aa                	mv	a1,a0
 b0a:	4505                	li	a0,1
 b0c:	d27ff0ef          	jal	832 <vprintf>
}
 b10:	60e2                	ld	ra,24(sp)
 b12:	6442                	ld	s0,16(sp)
 b14:	6125                	add	sp,sp,96
 b16:	8082                	ret

0000000000000b18 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 b18:	1141                	add	sp,sp,-16
 b1a:	e422                	sd	s0,8(sp)
 b1c:	0800                	add	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 b1e:	ff050693          	add	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 b22:	00000797          	auipc	a5,0x0
 b26:	4e67b783          	ld	a5,1254(a5) # 1008 <freep>
 b2a:	a02d                	j	b54 <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 b2c:	4618                	lw	a4,8(a2)
 b2e:	9f2d                	addw	a4,a4,a1
 b30:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 b34:	6398                	ld	a4,0(a5)
 b36:	6310                	ld	a2,0(a4)
 b38:	a83d                	j	b76 <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 b3a:	ff852703          	lw	a4,-8(a0)
 b3e:	9f31                	addw	a4,a4,a2
 b40:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 b42:	ff053683          	ld	a3,-16(a0)
 b46:	a091                	j	b8a <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 b48:	6398                	ld	a4,0(a5)
 b4a:	00e7e463          	bltu	a5,a4,b52 <free+0x3a>
 b4e:	00e6ea63          	bltu	a3,a4,b62 <free+0x4a>
{
 b52:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 b54:	fed7fae3          	bgeu	a5,a3,b48 <free+0x30>
 b58:	6398                	ld	a4,0(a5)
 b5a:	00e6e463          	bltu	a3,a4,b62 <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 b5e:	fee7eae3          	bltu	a5,a4,b52 <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 b62:	ff852583          	lw	a1,-8(a0)
 b66:	6390                	ld	a2,0(a5)
 b68:	02059813          	sll	a6,a1,0x20
 b6c:	01c85713          	srl	a4,a6,0x1c
 b70:	9736                	add	a4,a4,a3
 b72:	fae60de3          	beq	a2,a4,b2c <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 b76:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 b7a:	4790                	lw	a2,8(a5)
 b7c:	02061593          	sll	a1,a2,0x20
 b80:	01c5d713          	srl	a4,a1,0x1c
 b84:	973e                	add	a4,a4,a5
 b86:	fae68ae3          	beq	a3,a4,b3a <free+0x22>
    p->s.ptr = bp->s.ptr;
 b8a:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 b8c:	00000717          	auipc	a4,0x0
 b90:	46f73e23          	sd	a5,1148(a4) # 1008 <freep>
}
 b94:	6422                	ld	s0,8(sp)
 b96:	0141                	add	sp,sp,16
 b98:	8082                	ret

0000000000000b9a <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 b9a:	7139                	add	sp,sp,-64
 b9c:	fc06                	sd	ra,56(sp)
 b9e:	f822                	sd	s0,48(sp)
 ba0:	f426                	sd	s1,40(sp)
 ba2:	f04a                	sd	s2,32(sp)
 ba4:	ec4e                	sd	s3,24(sp)
 ba6:	e852                	sd	s4,16(sp)
 ba8:	e456                	sd	s5,8(sp)
 baa:	e05a                	sd	s6,0(sp)
 bac:	0080                	add	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 bae:	02051493          	sll	s1,a0,0x20
 bb2:	9081                	srl	s1,s1,0x20
 bb4:	04bd                	add	s1,s1,15
 bb6:	8091                	srl	s1,s1,0x4
 bb8:	0014899b          	addw	s3,s1,1
 bbc:	0485                	add	s1,s1,1
  if((prevp = freep) == 0){
 bbe:	00000517          	auipc	a0,0x0
 bc2:	44a53503          	ld	a0,1098(a0) # 1008 <freep>
 bc6:	c515                	beqz	a0,bf2 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 bc8:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 bca:	4798                	lw	a4,8(a5)
 bcc:	02977f63          	bgeu	a4,s1,c0a <malloc+0x70>
  if(nu < 4096)
 bd0:	8a4e                	mv	s4,s3
 bd2:	0009871b          	sext.w	a4,s3
 bd6:	6685                	lui	a3,0x1
 bd8:	00d77363          	bgeu	a4,a3,bde <malloc+0x44>
 bdc:	6a05                	lui	s4,0x1
 bde:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 be2:	004a1a1b          	sllw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 be6:	00000917          	auipc	s2,0x0
 bea:	42290913          	add	s2,s2,1058 # 1008 <freep>
  if(p == (char*)-1)
 bee:	5afd                	li	s5,-1
 bf0:	a885                	j	c60 <malloc+0xc6>
    base.s.ptr = freep = prevp = &base;
 bf2:	00000797          	auipc	a5,0x0
 bf6:	41e78793          	add	a5,a5,1054 # 1010 <base>
 bfa:	00000717          	auipc	a4,0x0
 bfe:	40f73723          	sd	a5,1038(a4) # 1008 <freep>
 c02:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 c04:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 c08:	b7e1                	j	bd0 <malloc+0x36>
      if(p->s.size == nunits)
 c0a:	02e48c63          	beq	s1,a4,c42 <malloc+0xa8>
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
 c26:	3ea73323          	sd	a0,998(a4) # 1008 <freep>
      return (void*)(p + 1);
 c2a:	01078513          	add	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 c2e:	70e2                	ld	ra,56(sp)
 c30:	7442                	ld	s0,48(sp)
 c32:	74a2                	ld	s1,40(sp)
 c34:	7902                	ld	s2,32(sp)
 c36:	69e2                	ld	s3,24(sp)
 c38:	6a42                	ld	s4,16(sp)
 c3a:	6aa2                	ld	s5,8(sp)
 c3c:	6b02                	ld	s6,0(sp)
 c3e:	6121                	add	sp,sp,64
 c40:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 c42:	6398                	ld	a4,0(a5)
 c44:	e118                	sd	a4,0(a0)
 c46:	bff1                	j	c22 <malloc+0x88>
  hp->s.size = nu;
 c48:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 c4c:	0541                	add	a0,a0,16
 c4e:	ecbff0ef          	jal	b18 <free>
  return freep;
 c52:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 c56:	dd61                	beqz	a0,c2e <malloc+0x94>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 c58:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 c5a:	4798                	lw	a4,8(a5)
 c5c:	fa9777e3          	bgeu	a4,s1,c0a <malloc+0x70>
    if(p == freep)
 c60:	00093703          	ld	a4,0(s2)
 c64:	853e                	mv	a0,a5
 c66:	fef719e3          	bne	a4,a5,c58 <malloc+0xbe>
  p = sbrk(nu * sizeof(Header));
 c6a:	8552                	mv	a0,s4
 c6c:	a99ff0ef          	jal	704 <sbrk>
  if(p == (char*)-1)
 c70:	fd551ce3          	bne	a0,s5,c48 <malloc+0xae>
        return 0;
 c74:	4501                	li	a0,0
 c76:	bf65                	j	c2e <malloc+0x94>
