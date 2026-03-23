
user/_udpecho:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "user/user.h"
#include "kernel/net/socket.h"

int
main (int argc, char *argv[])
{
   0:	7135                	add	sp,sp,-160
   2:	ed06                	sd	ra,152(sp)
   4:	e922                	sd	s0,144(sp)
   6:	e526                	sd	s1,136(sp)
   8:	e14a                	sd	s2,128(sp)
   a:	fcce                	sd	s3,120(sp)
   c:	f8d2                	sd	s4,112(sp)
   e:	f4d6                	sd	s5,104(sp)
  10:	f0da                	sd	s6,96(sp)
  12:	ecde                	sd	s7,88(sp)
  14:	e8e2                	sd	s8,80(sp)
  16:	e4e6                	sd	s9,72(sp)
  18:	e0ea                	sd	s10,64(sp)
  1a:	fc6e                	sd	s11,56(sp)
  1c:	1100                	add	s0,sp,160
  1e:	81010113          	add	sp,sp,-2032
    int soc, peerlen, ret;
    struct sockaddr_in self, peer;
    unsigned char *addr;
    char buf[2048];

    printf("Starting UDP Echo Server\n");
  22:	00001517          	auipc	a0,0x1
  26:	c5e50513          	add	a0,a0,-930 # c80 <malloc+0xe0>
  2a:	2c3000ef          	jal	aec <printf>
    soc = socket(PF_INET, SOCK_DGRAM, IPPROTO_UDP);
  2e:	4601                	li	a2,0
  30:	4585                	li	a1,1
  32:	4505                	li	a0,1
  34:	6ee000ef          	jal	722 <socket>
    if (soc == -1) {
  38:	57fd                	li	a5,-1
  3a:	08f50a63          	beq	a0,a5,ce <main+0xce>
  3e:	892a                	mv	s2,a0
        printf("socket: failure\n");
        exit(1);
    }
    printf("socket: success, soc=%d\n", soc);
  40:	85aa                	mv	a1,a0
  42:	00001517          	auipc	a0,0x1
  46:	c7650513          	add	a0,a0,-906 # cb8 <malloc+0x118>
  4a:	2a3000ef          	jal	aec <printf>
    self.sin_family = AF_INET;
  4e:	4785                	li	a5,1
  50:	f8f41023          	sh	a5,-128(s0)
    self.sin_addr.s_addr = INADDR_ANY;
  54:	f8042223          	sw	zero,-124(s0)
    self.sin_port = htons(7);
  58:	451d                	li	a0,7
  5a:	3a0000ef          	jal	3fa <htons>
  5e:	f8a41123          	sh	a0,-126(s0)
    if (bind(soc, (struct sockaddr *)&self, sizeof(self)) == -1) {
  62:	4621                	li	a2,8
  64:	f8040593          	add	a1,s0,-128
  68:	854a                	mv	a0,s2
  6a:	6c0000ef          	jal	72a <bind>
  6e:	57fd                	li	a5,-1
  70:	06f50863          	beq	a0,a5,e0 <main+0xe0>
        printf("bind: failure\n");
        close(soc);
        exit(1);
    }
    addr = (unsigned char *)&self.sin_addr.s_addr;
    printf("bind: success, self=%d.%d.%d.%d:%d\n",
  74:	f8444483          	lbu	s1,-124(s0)
  78:	f8544983          	lbu	s3,-123(s0)
  7c:	f8644a03          	lbu	s4,-122(s0)
  80:	f8744a83          	lbu	s5,-121(s0)
        addr[0], addr[1], addr[2], addr[3], ntohs(self.sin_port));
  84:	f8245503          	lhu	a0,-126(s0)
  88:	3ae000ef          	jal	436 <ntohs>
    printf("bind: success, self=%d.%d.%d.%d:%d\n",
  8c:	0005079b          	sext.w	a5,a0
  90:	8756                	mv	a4,s5
  92:	86d2                	mv	a3,s4
  94:	864e                	mv	a2,s3
  96:	85a6                	mv	a1,s1
  98:	00001517          	auipc	a0,0x1
  9c:	c5050513          	add	a0,a0,-944 # ce8 <malloc+0x148>
  a0:	24d000ef          	jal	aec <printf>
    printf("waiting for message...\n");
  a4:	00001517          	auipc	a0,0x1
  a8:	c6c50513          	add	a0,a0,-916 # d10 <malloc+0x170>
  ac:	241000ef          	jal	aec <printf>
    while (1) {
        peerlen = sizeof(peer);
  b0:	4ca1                	li	s9,8
        ret = recvfrom(soc, buf, sizeof(buf), (struct sockaddr *)&peer, &peerlen);
  b2:	7dfd                	lui	s11,0xfffff
  b4:	778d8793          	add	a5,s11,1912 # fffffffffffff778 <base+0xffffffffffffe768>
  b8:	008789b3          	add	s3,a5,s0
  bc:	6c05                	lui	s8,0x1
  be:	800c0c13          	add	s8,s8,-2048 # 800 <printint+0x70>
        if (ret <= 0) {
            printf("EOF\n");
            break;
        }
        if (ret == 2 && buf[0] == '.' && buf[1] == '\n') {
  c2:	4d09                	li	s10,2
  c4:	f90d8793          	add	a5,s11,-112
  c8:	00878db3          	add	s11,a5,s0
  cc:	a061                	j	154 <main+0x154>
        printf("socket: failure\n");
  ce:	00001517          	auipc	a0,0x1
  d2:	bd250513          	add	a0,a0,-1070 # ca0 <malloc+0x100>
  d6:	217000ef          	jal	aec <printf>
        exit(1);
  da:	4505                	li	a0,1
  dc:	5a6000ef          	jal	682 <exit>
        printf("bind: failure\n");
  e0:	00001517          	auipc	a0,0x1
  e4:	bf850513          	add	a0,a0,-1032 # cd8 <malloc+0x138>
  e8:	205000ef          	jal	aec <printf>
        close(soc);
  ec:	854a                	mv	a0,s2
  ee:	5bc000ef          	jal	6aa <close>
        exit(1);
  f2:	4505                	li	a0,1
  f4:	58e000ef          	jal	682 <exit>
            printf("EOF\n");
  f8:	00001517          	auipc	a0,0x1
  fc:	c3050513          	add	a0,a0,-976 # d28 <malloc+0x188>
 100:	1ed000ef          	jal	aec <printf>
        addr = (unsigned char *)&peer.sin_addr.s_addr;
        printf("recvfrom: %d bytes data received, peer=%d.%d.%d.%d:%d\n",
            ret, addr[0], addr[1], addr[2], addr[3], ntohs(peer.sin_port));
        sendto(soc, buf, ret, (struct sockaddr *)&peer, peerlen);
    }
    close(soc);  
 104:	854a                	mv	a0,s2
 106:	5a4000ef          	jal	6aa <close>
    exit(0);
 10a:	4501                	li	a0,0
 10c:	576000ef          	jal	682 <exit>
        printf("recvfrom: %d bytes data received, peer=%d.%d.%d.%d:%d\n",
 110:	f7c44a03          	lbu	s4,-132(s0)
 114:	f7d44a83          	lbu	s5,-131(s0)
 118:	f7e44b03          	lbu	s6,-130(s0)
 11c:	f7f44b83          	lbu	s7,-129(s0)
            ret, addr[0], addr[1], addr[2], addr[3], ntohs(peer.sin_port));
 120:	f7a45503          	lhu	a0,-134(s0)
 124:	312000ef          	jal	436 <ntohs>
        printf("recvfrom: %d bytes data received, peer=%d.%d.%d.%d:%d\n",
 128:	0005081b          	sext.w	a6,a0
 12c:	87de                	mv	a5,s7
 12e:	875a                	mv	a4,s6
 130:	86d6                	mv	a3,s5
 132:	8652                	mv	a2,s4
 134:	85a6                	mv	a1,s1
 136:	00001517          	auipc	a0,0x1
 13a:	c0250513          	add	a0,a0,-1022 # d38 <malloc+0x198>
 13e:	1af000ef          	jal	aec <printf>
        sendto(soc, buf, ret, (struct sockaddr *)&peer, peerlen);
 142:	f8c42703          	lw	a4,-116(s0)
 146:	f7840693          	add	a3,s0,-136
 14a:	8626                	mv	a2,s1
 14c:	85ce                	mv	a1,s3
 14e:	854a                	mv	a0,s2
 150:	5ea000ef          	jal	73a <sendto>
        peerlen = sizeof(peer);
 154:	f9942623          	sw	s9,-116(s0)
        ret = recvfrom(soc, buf, sizeof(buf), (struct sockaddr *)&peer, &peerlen);
 158:	f8c40713          	add	a4,s0,-116
 15c:	f7840693          	add	a3,s0,-136
 160:	8662                	mv	a2,s8
 162:	85ce                	mv	a1,s3
 164:	854a                	mv	a0,s2
 166:	5cc000ef          	jal	732 <recvfrom>
 16a:	84aa                	mv	s1,a0
        if (ret <= 0) {
 16c:	f8a056e3          	blez	a0,f8 <main+0xf8>
        if (ret == 2 && buf[0] == '.' && buf[1] == '\n') {
 170:	fba510e3          	bne	a0,s10,110 <main+0x110>
 174:	7e8dc783          	lbu	a5,2024(s11)
 178:	02e00713          	li	a4,46
 17c:	f8e79ae3          	bne	a5,a4,110 <main+0x110>
 180:	7e9dc703          	lbu	a4,2025(s11)
 184:	47a9                	li	a5,10
 186:	f8f715e3          	bne	a4,a5,110 <main+0x110>
            printf("quit\n");
 18a:	00001517          	auipc	a0,0x1
 18e:	ba650513          	add	a0,a0,-1114 # d30 <malloc+0x190>
 192:	15b000ef          	jal	aec <printf>
            break;  
 196:	b7bd                	j	104 <main+0x104>

0000000000000198 <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start()
{
 198:	1141                	add	sp,sp,-16
 19a:	e406                	sd	ra,8(sp)
 19c:	e022                	sd	s0,0(sp)
 19e:	0800                	add	s0,sp,16
  extern int main();
  main();
 1a0:	e61ff0ef          	jal	0 <main>
  exit(0);
 1a4:	4501                	li	a0,0
 1a6:	4dc000ef          	jal	682 <exit>

00000000000001aa <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
 1aa:	1141                	add	sp,sp,-16
 1ac:	e422                	sd	s0,8(sp)
 1ae:	0800                	add	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 1b0:	87aa                	mv	a5,a0
 1b2:	0585                	add	a1,a1,1
 1b4:	0785                	add	a5,a5,1
 1b6:	fff5c703          	lbu	a4,-1(a1)
 1ba:	fee78fa3          	sb	a4,-1(a5)
 1be:	fb75                	bnez	a4,1b2 <strcpy+0x8>
    ;
  return os;
}
 1c0:	6422                	ld	s0,8(sp)
 1c2:	0141                	add	sp,sp,16
 1c4:	8082                	ret

00000000000001c6 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 1c6:	1141                	add	sp,sp,-16
 1c8:	e422                	sd	s0,8(sp)
 1ca:	0800                	add	s0,sp,16
  while(*p && *p == *q)
 1cc:	00054783          	lbu	a5,0(a0)
 1d0:	cb91                	beqz	a5,1e4 <strcmp+0x1e>
 1d2:	0005c703          	lbu	a4,0(a1)
 1d6:	00f71763          	bne	a4,a5,1e4 <strcmp+0x1e>
    p++, q++;
 1da:	0505                	add	a0,a0,1
 1dc:	0585                	add	a1,a1,1
  while(*p && *p == *q)
 1de:	00054783          	lbu	a5,0(a0)
 1e2:	fbe5                	bnez	a5,1d2 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 1e4:	0005c503          	lbu	a0,0(a1)
}
 1e8:	40a7853b          	subw	a0,a5,a0
 1ec:	6422                	ld	s0,8(sp)
 1ee:	0141                	add	sp,sp,16
 1f0:	8082                	ret

00000000000001f2 <strlen>:

uint
strlen(const char *s)
{
 1f2:	1141                	add	sp,sp,-16
 1f4:	e422                	sd	s0,8(sp)
 1f6:	0800                	add	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 1f8:	00054783          	lbu	a5,0(a0)
 1fc:	cf91                	beqz	a5,218 <strlen+0x26>
 1fe:	0505                	add	a0,a0,1
 200:	87aa                	mv	a5,a0
 202:	86be                	mv	a3,a5
 204:	0785                	add	a5,a5,1
 206:	fff7c703          	lbu	a4,-1(a5)
 20a:	ff65                	bnez	a4,202 <strlen+0x10>
 20c:	40a6853b          	subw	a0,a3,a0
 210:	2505                	addw	a0,a0,1
    ;
  return n;
}
 212:	6422                	ld	s0,8(sp)
 214:	0141                	add	sp,sp,16
 216:	8082                	ret
  for(n = 0; s[n]; n++)
 218:	4501                	li	a0,0
 21a:	bfe5                	j	212 <strlen+0x20>

000000000000021c <memset>:

void*
memset(void *dst, int c, uint n)
{
 21c:	1141                	add	sp,sp,-16
 21e:	e422                	sd	s0,8(sp)
 220:	0800                	add	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 222:	ca19                	beqz	a2,238 <memset+0x1c>
 224:	87aa                	mv	a5,a0
 226:	1602                	sll	a2,a2,0x20
 228:	9201                	srl	a2,a2,0x20
 22a:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 22e:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 232:	0785                	add	a5,a5,1
 234:	fee79de3          	bne	a5,a4,22e <memset+0x12>
  }
  return dst;
}
 238:	6422                	ld	s0,8(sp)
 23a:	0141                	add	sp,sp,16
 23c:	8082                	ret

000000000000023e <strchr>:

char*
strchr(const char *s, char c)
{
 23e:	1141                	add	sp,sp,-16
 240:	e422                	sd	s0,8(sp)
 242:	0800                	add	s0,sp,16
  for(; *s; s++)
 244:	00054783          	lbu	a5,0(a0)
 248:	cb99                	beqz	a5,25e <strchr+0x20>
    if(*s == c)
 24a:	00f58763          	beq	a1,a5,258 <strchr+0x1a>
  for(; *s; s++)
 24e:	0505                	add	a0,a0,1
 250:	00054783          	lbu	a5,0(a0)
 254:	fbfd                	bnez	a5,24a <strchr+0xc>
      return (char*)s;
  return 0;
 256:	4501                	li	a0,0
}
 258:	6422                	ld	s0,8(sp)
 25a:	0141                	add	sp,sp,16
 25c:	8082                	ret
  return 0;
 25e:	4501                	li	a0,0
 260:	bfe5                	j	258 <strchr+0x1a>

0000000000000262 <gets>:

char*
gets(char *buf, int max)
{
 262:	711d                	add	sp,sp,-96
 264:	ec86                	sd	ra,88(sp)
 266:	e8a2                	sd	s0,80(sp)
 268:	e4a6                	sd	s1,72(sp)
 26a:	e0ca                	sd	s2,64(sp)
 26c:	fc4e                	sd	s3,56(sp)
 26e:	f852                	sd	s4,48(sp)
 270:	f456                	sd	s5,40(sp)
 272:	f05a                	sd	s6,32(sp)
 274:	ec5e                	sd	s7,24(sp)
 276:	1080                	add	s0,sp,96
 278:	8baa                	mv	s7,a0
 27a:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 27c:	892a                	mv	s2,a0
 27e:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 280:	4aa9                	li	s5,10
 282:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 284:	89a6                	mv	s3,s1
 286:	2485                	addw	s1,s1,1
 288:	0344d663          	bge	s1,s4,2b4 <gets+0x52>
    cc = read(0, &c, 1);
 28c:	4605                	li	a2,1
 28e:	faf40593          	add	a1,s0,-81
 292:	4501                	li	a0,0
 294:	406000ef          	jal	69a <read>
    if(cc < 1)
 298:	00a05e63          	blez	a0,2b4 <gets+0x52>
    buf[i++] = c;
 29c:	faf44783          	lbu	a5,-81(s0)
 2a0:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 2a4:	01578763          	beq	a5,s5,2b2 <gets+0x50>
 2a8:	0905                	add	s2,s2,1
 2aa:	fd679de3          	bne	a5,s6,284 <gets+0x22>
  for(i=0; i+1 < max; ){
 2ae:	89a6                	mv	s3,s1
 2b0:	a011                	j	2b4 <gets+0x52>
 2b2:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 2b4:	99de                	add	s3,s3,s7
 2b6:	00098023          	sb	zero,0(s3)
  return buf;
}
 2ba:	855e                	mv	a0,s7
 2bc:	60e6                	ld	ra,88(sp)
 2be:	6446                	ld	s0,80(sp)
 2c0:	64a6                	ld	s1,72(sp)
 2c2:	6906                	ld	s2,64(sp)
 2c4:	79e2                	ld	s3,56(sp)
 2c6:	7a42                	ld	s4,48(sp)
 2c8:	7aa2                	ld	s5,40(sp)
 2ca:	7b02                	ld	s6,32(sp)
 2cc:	6be2                	ld	s7,24(sp)
 2ce:	6125                	add	sp,sp,96
 2d0:	8082                	ret

00000000000002d2 <stat>:

int
stat(const char *n, struct stat *st)
{
 2d2:	1101                	add	sp,sp,-32
 2d4:	ec06                	sd	ra,24(sp)
 2d6:	e822                	sd	s0,16(sp)
 2d8:	e426                	sd	s1,8(sp)
 2da:	e04a                	sd	s2,0(sp)
 2dc:	1000                	add	s0,sp,32
 2de:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 2e0:	4581                	li	a1,0
 2e2:	3e0000ef          	jal	6c2 <open>
  if(fd < 0)
 2e6:	02054163          	bltz	a0,308 <stat+0x36>
 2ea:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 2ec:	85ca                	mv	a1,s2
 2ee:	3ec000ef          	jal	6da <fstat>
 2f2:	892a                	mv	s2,a0
  close(fd);
 2f4:	8526                	mv	a0,s1
 2f6:	3b4000ef          	jal	6aa <close>
  return r;
}
 2fa:	854a                	mv	a0,s2
 2fc:	60e2                	ld	ra,24(sp)
 2fe:	6442                	ld	s0,16(sp)
 300:	64a2                	ld	s1,8(sp)
 302:	6902                	ld	s2,0(sp)
 304:	6105                	add	sp,sp,32
 306:	8082                	ret
    return -1;
 308:	597d                	li	s2,-1
 30a:	bfc5                	j	2fa <stat+0x28>

000000000000030c <atoi>:

int
atoi(const char *s)
{
 30c:	1141                	add	sp,sp,-16
 30e:	e422                	sd	s0,8(sp)
 310:	0800                	add	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 312:	00054683          	lbu	a3,0(a0)
 316:	fd06879b          	addw	a5,a3,-48
 31a:	0ff7f793          	zext.b	a5,a5
 31e:	4625                	li	a2,9
 320:	02f66863          	bltu	a2,a5,350 <atoi+0x44>
 324:	872a                	mv	a4,a0
  n = 0;
 326:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 328:	0705                	add	a4,a4,1
 32a:	0025179b          	sllw	a5,a0,0x2
 32e:	9fa9                	addw	a5,a5,a0
 330:	0017979b          	sllw	a5,a5,0x1
 334:	9fb5                	addw	a5,a5,a3
 336:	fd07851b          	addw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 33a:	00074683          	lbu	a3,0(a4)
 33e:	fd06879b          	addw	a5,a3,-48
 342:	0ff7f793          	zext.b	a5,a5
 346:	fef671e3          	bgeu	a2,a5,328 <atoi+0x1c>
  return n;
}
 34a:	6422                	ld	s0,8(sp)
 34c:	0141                	add	sp,sp,16
 34e:	8082                	ret
  n = 0;
 350:	4501                	li	a0,0
 352:	bfe5                	j	34a <atoi+0x3e>

0000000000000354 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 354:	1141                	add	sp,sp,-16
 356:	e422                	sd	s0,8(sp)
 358:	0800                	add	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 35a:	02b57463          	bgeu	a0,a1,382 <memmove+0x2e>
    while(n-- > 0)
 35e:	00c05f63          	blez	a2,37c <memmove+0x28>
 362:	1602                	sll	a2,a2,0x20
 364:	9201                	srl	a2,a2,0x20
 366:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 36a:	872a                	mv	a4,a0
      *dst++ = *src++;
 36c:	0585                	add	a1,a1,1
 36e:	0705                	add	a4,a4,1
 370:	fff5c683          	lbu	a3,-1(a1)
 374:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 378:	fee79ae3          	bne	a5,a4,36c <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 37c:	6422                	ld	s0,8(sp)
 37e:	0141                	add	sp,sp,16
 380:	8082                	ret
    dst += n;
 382:	00c50733          	add	a4,a0,a2
    src += n;
 386:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 388:	fec05ae3          	blez	a2,37c <memmove+0x28>
 38c:	fff6079b          	addw	a5,a2,-1
 390:	1782                	sll	a5,a5,0x20
 392:	9381                	srl	a5,a5,0x20
 394:	fff7c793          	not	a5,a5
 398:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 39a:	15fd                	add	a1,a1,-1
 39c:	177d                	add	a4,a4,-1
 39e:	0005c683          	lbu	a3,0(a1)
 3a2:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 3a6:	fee79ae3          	bne	a5,a4,39a <memmove+0x46>
 3aa:	bfc9                	j	37c <memmove+0x28>

00000000000003ac <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 3ac:	1141                	add	sp,sp,-16
 3ae:	e422                	sd	s0,8(sp)
 3b0:	0800                	add	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 3b2:	ca05                	beqz	a2,3e2 <memcmp+0x36>
 3b4:	fff6069b          	addw	a3,a2,-1
 3b8:	1682                	sll	a3,a3,0x20
 3ba:	9281                	srl	a3,a3,0x20
 3bc:	0685                	add	a3,a3,1
 3be:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 3c0:	00054783          	lbu	a5,0(a0)
 3c4:	0005c703          	lbu	a4,0(a1)
 3c8:	00e79863          	bne	a5,a4,3d8 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 3cc:	0505                	add	a0,a0,1
    p2++;
 3ce:	0585                	add	a1,a1,1
  while (n-- > 0) {
 3d0:	fed518e3          	bne	a0,a3,3c0 <memcmp+0x14>
  }
  return 0;
 3d4:	4501                	li	a0,0
 3d6:	a019                	j	3dc <memcmp+0x30>
      return *p1 - *p2;
 3d8:	40e7853b          	subw	a0,a5,a4
}
 3dc:	6422                	ld	s0,8(sp)
 3de:	0141                	add	sp,sp,16
 3e0:	8082                	ret
  return 0;
 3e2:	4501                	li	a0,0
 3e4:	bfe5                	j	3dc <memcmp+0x30>

00000000000003e6 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 3e6:	1141                	add	sp,sp,-16
 3e8:	e406                	sd	ra,8(sp)
 3ea:	e022                	sd	s0,0(sp)
 3ec:	0800                	add	s0,sp,16
  return memmove(dst, src, n);
 3ee:	f67ff0ef          	jal	354 <memmove>
}
 3f2:	60a2                	ld	ra,8(sp)
 3f4:	6402                	ld	s0,0(sp)
 3f6:	0141                	add	sp,sp,16
 3f8:	8082                	ret

00000000000003fa <htons>:
    return (v & 0x000000ff) << 24 | (v & 0x0000ff00) << 8 | (v & 0x00ff0000) >> 8 | (v & 0xff000000) >> 24;
}

uint16_t
htons(uint16_t h)
{
 3fa:	1141                	add	sp,sp,-16
 3fc:	e422                	sd	s0,8(sp)
 3fe:	0800                	add	s0,sp,16
    if (!endian) {
 400:	00001797          	auipc	a5,0x1
 404:	c007a783          	lw	a5,-1024(a5) # 1000 <endian>
 408:	e385                	bnez	a5,428 <htons+0x2e>
        endian = byteorder();
 40a:	4d200793          	li	a5,1234
 40e:	00001717          	auipc	a4,0x1
 412:	bef72923          	sw	a5,-1038(a4) # 1000 <endian>
    return (v & 0x00ff) << 8 | (v & 0xff00 ) >> 8;
 416:	0085579b          	srlw	a5,a0,0x8
 41a:	0085151b          	sllw	a0,a0,0x8
 41e:	8fc9                	or	a5,a5,a0
 420:	03079513          	sll	a0,a5,0x30
 424:	9141                	srl	a0,a0,0x30
 426:	a029                	j	430 <htons+0x36>
    }
    return endian == __LITTLE_ENDIAN ? byteswap16(h) : h;
 428:	4d200713          	li	a4,1234
 42c:	fee785e3          	beq	a5,a4,416 <htons+0x1c>
}
 430:	6422                	ld	s0,8(sp)
 432:	0141                	add	sp,sp,16
 434:	8082                	ret

0000000000000436 <ntohs>:

uint16_t
ntohs(uint16_t n)
{
 436:	1141                	add	sp,sp,-16
 438:	e422                	sd	s0,8(sp)
 43a:	0800                	add	s0,sp,16
    if (!endian) {
 43c:	00001797          	auipc	a5,0x1
 440:	bc47a783          	lw	a5,-1084(a5) # 1000 <endian>
 444:	e385                	bnez	a5,464 <ntohs+0x2e>
        endian = byteorder();
 446:	4d200793          	li	a5,1234
 44a:	00001717          	auipc	a4,0x1
 44e:	baf72b23          	sw	a5,-1098(a4) # 1000 <endian>
    return (v & 0x00ff) << 8 | (v & 0xff00 ) >> 8;
 452:	0085579b          	srlw	a5,a0,0x8
 456:	0085151b          	sllw	a0,a0,0x8
 45a:	8fc9                	or	a5,a5,a0
 45c:	03079513          	sll	a0,a5,0x30
 460:	9141                	srl	a0,a0,0x30
 462:	a029                	j	46c <ntohs+0x36>
    }
    return endian == __LITTLE_ENDIAN ? byteswap16(n) : n;
 464:	4d200713          	li	a4,1234
 468:	fee785e3          	beq	a5,a4,452 <ntohs+0x1c>
}
 46c:	6422                	ld	s0,8(sp)
 46e:	0141                	add	sp,sp,16
 470:	8082                	ret

0000000000000472 <htonl>:

uint32_t
htonl(uint32_t h)
{
 472:	1141                	add	sp,sp,-16
 474:	e422                	sd	s0,8(sp)
 476:	0800                	add	s0,sp,16
    if (!endian) {
 478:	00001797          	auipc	a5,0x1
 47c:	b887a783          	lw	a5,-1144(a5) # 1000 <endian>
 480:	ef85                	bnez	a5,4b8 <htonl+0x46>
        endian = byteorder();
 482:	4d200793          	li	a5,1234
 486:	00001717          	auipc	a4,0x1
 48a:	b6f72d23          	sw	a5,-1158(a4) # 1000 <endian>
    return (v & 0x000000ff) << 24 | (v & 0x0000ff00) << 8 | (v & 0x00ff0000) >> 8 | (v & 0xff000000) >> 24;
 48e:	0185179b          	sllw	a5,a0,0x18
 492:	0185571b          	srlw	a4,a0,0x18
 496:	8fd9                	or	a5,a5,a4
 498:	0085171b          	sllw	a4,a0,0x8
 49c:	00ff06b7          	lui	a3,0xff0
 4a0:	8f75                	and	a4,a4,a3
 4a2:	8fd9                	or	a5,a5,a4
 4a4:	0085551b          	srlw	a0,a0,0x8
 4a8:	6741                	lui	a4,0x10
 4aa:	f0070713          	add	a4,a4,-256 # ff00 <base+0xeef0>
 4ae:	8d79                	and	a0,a0,a4
 4b0:	8fc9                	or	a5,a5,a0
 4b2:	0007851b          	sext.w	a0,a5
 4b6:	a029                	j	4c0 <htonl+0x4e>
    }
    return endian == __LITTLE_ENDIAN ? byteswap32(h) : h;
 4b8:	4d200713          	li	a4,1234
 4bc:	fce789e3          	beq	a5,a4,48e <htonl+0x1c>
}
 4c0:	6422                	ld	s0,8(sp)
 4c2:	0141                	add	sp,sp,16
 4c4:	8082                	ret

00000000000004c6 <ntohl>:

uint32_t
ntohl(uint32_t n)
{
 4c6:	1141                	add	sp,sp,-16
 4c8:	e422                	sd	s0,8(sp)
 4ca:	0800                	add	s0,sp,16
    if (!endian) {
 4cc:	00001797          	auipc	a5,0x1
 4d0:	b347a783          	lw	a5,-1228(a5) # 1000 <endian>
 4d4:	ef85                	bnez	a5,50c <ntohl+0x46>
        endian = byteorder();
 4d6:	4d200793          	li	a5,1234
 4da:	00001717          	auipc	a4,0x1
 4de:	b2f72323          	sw	a5,-1242(a4) # 1000 <endian>
    return (v & 0x000000ff) << 24 | (v & 0x0000ff00) << 8 | (v & 0x00ff0000) >> 8 | (v & 0xff000000) >> 24;
 4e2:	0185179b          	sllw	a5,a0,0x18
 4e6:	0185571b          	srlw	a4,a0,0x18
 4ea:	8fd9                	or	a5,a5,a4
 4ec:	0085171b          	sllw	a4,a0,0x8
 4f0:	00ff06b7          	lui	a3,0xff0
 4f4:	8f75                	and	a4,a4,a3
 4f6:	8fd9                	or	a5,a5,a4
 4f8:	0085551b          	srlw	a0,a0,0x8
 4fc:	6741                	lui	a4,0x10
 4fe:	f0070713          	add	a4,a4,-256 # ff00 <base+0xeef0>
 502:	8d79                	and	a0,a0,a4
 504:	8fc9                	or	a5,a5,a0
 506:	0007851b          	sext.w	a0,a5
 50a:	a029                	j	514 <ntohl+0x4e>
    }
    return endian == __LITTLE_ENDIAN ? byteswap32(n) : n;
 50c:	4d200713          	li	a4,1234
 510:	fce789e3          	beq	a5,a4,4e2 <ntohl+0x1c>
}
 514:	6422                	ld	s0,8(sp)
 516:	0141                	add	sp,sp,16
 518:	8082                	ret

000000000000051a <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
 51a:	1141                	add	sp,sp,-16
 51c:	e422                	sd	s0,8(sp)
 51e:	0800                	add	s0,sp,16
 520:	872a                	mv	a4,a0
    int neg = 0;
    long val = 0;

    // gobble initial whitespace
    while (*s == ' ' || *s == '\t')
 522:	02000693          	li	a3,32
 526:	4525                	li	a0,9
 528:	a011                	j	52c <strtol+0x12>
        s++;
 52a:	0705                	add	a4,a4,1
    while (*s == ' ' || *s == '\t')
 52c:	00074783          	lbu	a5,0(a4)
 530:	fed78de3          	beq	a5,a3,52a <strtol+0x10>
 534:	fea78be3          	beq	a5,a0,52a <strtol+0x10>

    // plus/minus sign
    if (*s == '+')
 538:	02b00693          	li	a3,43
 53c:	02d78663          	beq	a5,a3,568 <strtol+0x4e>
        s++;
    else if (*s == '-')
 540:	02d00693          	li	a3,45
    int neg = 0;
 544:	4301                	li	t1,0
    else if (*s == '-')
 546:	02d78463          	beq	a5,a3,56e <strtol+0x54>
        s++, neg = 1;

    // hex or octal base prefix
    if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
 54a:	fef67793          	and	a5,a2,-17
 54e:	eb89                	bnez	a5,560 <strtol+0x46>
 550:	00074683          	lbu	a3,0(a4)
 554:	03000793          	li	a5,48
 558:	00f68e63          	beq	a3,a5,574 <strtol+0x5a>
        s += 2, base = 16;
    else if (base == 0 && s[0] == '0')
 55c:	e211                	bnez	a2,560 <strtol+0x46>
        s++, base = 8;
    else if (base == 0)
        base = 10;
 55e:	4629                	li	a2,10
 560:	4501                	li	a0,0

    // digits
    while (1) {
        int dig;

        if (*s >= '0' && *s <= '9')
 562:	4825                	li	a6,9
            dig = *s - '0';
        else if (*s >= 'a' && *s <= 'z')
 564:	48e5                	li	a7,25
 566:	a825                	j	59e <strtol+0x84>
        s++;
 568:	0705                	add	a4,a4,1
    int neg = 0;
 56a:	4301                	li	t1,0
 56c:	bff9                	j	54a <strtol+0x30>
        s++, neg = 1;
 56e:	0705                	add	a4,a4,1
 570:	4305                	li	t1,1
 572:	bfe1                	j	54a <strtol+0x30>
    if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
 574:	00174683          	lbu	a3,1(a4)
 578:	07800793          	li	a5,120
 57c:	00f68663          	beq	a3,a5,588 <strtol+0x6e>
    else if (base == 0 && s[0] == '0')
 580:	f265                	bnez	a2,560 <strtol+0x46>
        s++, base = 8;
 582:	0705                	add	a4,a4,1
 584:	4621                	li	a2,8
 586:	bfe9                	j	560 <strtol+0x46>
        s += 2, base = 16;
 588:	0709                	add	a4,a4,2
 58a:	4641                	li	a2,16
 58c:	bfd1                	j	560 <strtol+0x46>
            dig = *s - '0';
 58e:	fd07879b          	addw	a5,a5,-48
            dig = *s - 'a' + 10;
        else if (*s >= 'A' && *s <= 'Z')
            dig = *s - 'A' + 10;
        else
            break;
        if (dig >= base)
 592:	04c7d063          	bge	a5,a2,5d2 <strtol+0xb8>
            break;
        s++, val = (val * base) + dig;
 596:	0705                	add	a4,a4,1
 598:	02a60533          	mul	a0,a2,a0
 59c:	953e                	add	a0,a0,a5
        if (*s >= '0' && *s <= '9')
 59e:	00074783          	lbu	a5,0(a4)
 5a2:	fd07869b          	addw	a3,a5,-48
 5a6:	0ff6f693          	zext.b	a3,a3
 5aa:	fed872e3          	bgeu	a6,a3,58e <strtol+0x74>
        else if (*s >= 'a' && *s <= 'z')
 5ae:	f9f7869b          	addw	a3,a5,-97
 5b2:	0ff6f693          	zext.b	a3,a3
 5b6:	00d8e563          	bltu	a7,a3,5c0 <strtol+0xa6>
            dig = *s - 'a' + 10;
 5ba:	fa97879b          	addw	a5,a5,-87
 5be:	bfd1                	j	592 <strtol+0x78>
        else if (*s >= 'A' && *s <= 'Z')
 5c0:	fbf7869b          	addw	a3,a5,-65
 5c4:	0ff6f693          	zext.b	a3,a3
 5c8:	00d8e563          	bltu	a7,a3,5d2 <strtol+0xb8>
            dig = *s - 'A' + 10;
 5cc:	fc97879b          	addw	a5,a5,-55
 5d0:	b7c9                	j	592 <strtol+0x78>
        // we don't properly detect overflow!
    }

    if (endptr)
 5d2:	c191                	beqz	a1,5d6 <strtol+0xbc>
        *endptr = (char *) s;
 5d4:	e198                	sd	a4,0(a1)
    return (neg ? -val : val);
 5d6:	00030463          	beqz	t1,5de <strtol+0xc4>
 5da:	40a00533          	neg	a0,a0
}
 5de:	6422                	ld	s0,8(sp)
 5e0:	0141                	add	sp,sp,16
 5e2:	8082                	ret

00000000000005e4 <inet_pton>:
inet_pton (int family, const char *p, void *n) {
    char *sp, *ep;
    int idx;
    long ret;

    if (family != AF_INET) {
 5e4:	4785                	li	a5,1
 5e6:	08f51263          	bne	a0,a5,66a <inet_pton+0x86>
inet_pton (int family, const char *p, void *n) {
 5ea:	715d                	add	sp,sp,-80
 5ec:	e486                	sd	ra,72(sp)
 5ee:	e0a2                	sd	s0,64(sp)
 5f0:	fc26                	sd	s1,56(sp)
 5f2:	f84a                	sd	s2,48(sp)
 5f4:	f44e                	sd	s3,40(sp)
 5f6:	f052                	sd	s4,32(sp)
 5f8:	ec56                	sd	s5,24(sp)
 5fa:	e85a                	sd	s6,16(sp)
 5fc:	0880                	add	s0,sp,80
 5fe:	892e                	mv	s2,a1
 600:	89b2                	mv	s3,a2
 602:	4481                	li	s1,0
        return -1;
    }
    sp = (char *)p;
    for (idx = 0; idx < 4; idx++) {
        ret = strtol(sp, &ep, 10);
        if (ret < 0 || ret > 255) {
 604:	0ff00a13          	li	s4,255
            return -1;
        }
        if (ep == sp) {
            return -1;
        }
        if ((idx == 3 && *ep != '\0') || (idx != 3 && *ep != '.')) {
 608:	4a8d                	li	s5,3
 60a:	02e00b13          	li	s6,46
 60e:	a815                	j	642 <inet_pton+0x5e>
 610:	0007c783          	lbu	a5,0(a5)
 614:	e3ad                	bnez	a5,676 <inet_pton+0x92>
            return -1;
        }
        ((uint8_t *)n)[idx] = ret;
 616:	2481                	sext.w	s1,s1
 618:	99a6                	add	s3,s3,s1
 61a:	00a98023          	sb	a0,0(s3)
        sp = ep + 1;
    }
    return 0;
 61e:	4501                	li	a0,0
}
 620:	60a6                	ld	ra,72(sp)
 622:	6406                	ld	s0,64(sp)
 624:	74e2                	ld	s1,56(sp)
 626:	7942                	ld	s2,48(sp)
 628:	79a2                	ld	s3,40(sp)
 62a:	7a02                	ld	s4,32(sp)
 62c:	6ae2                	ld	s5,24(sp)
 62e:	6b42                	ld	s6,16(sp)
 630:	6161                	add	sp,sp,80
 632:	8082                	ret
        ((uint8_t *)n)[idx] = ret;
 634:	00998733          	add	a4,s3,s1
 638:	00a70023          	sb	a0,0(a4)
        sp = ep + 1;
 63c:	00178913          	add	s2,a5,1
    for (idx = 0; idx < 4; idx++) {
 640:	0485                	add	s1,s1,1
        ret = strtol(sp, &ep, 10);
 642:	4629                	li	a2,10
 644:	fb840593          	add	a1,s0,-72
 648:	854a                	mv	a0,s2
 64a:	ed1ff0ef          	jal	51a <strtol>
        if (ret < 0 || ret > 255) {
 64e:	02aa6063          	bltu	s4,a0,66e <inet_pton+0x8a>
        if (ep == sp) {
 652:	fb843783          	ld	a5,-72(s0)
 656:	01278e63          	beq	a5,s2,672 <inet_pton+0x8e>
        if ((idx == 3 && *ep != '\0') || (idx != 3 && *ep != '.')) {
 65a:	fb548be3          	beq	s1,s5,610 <inet_pton+0x2c>
 65e:	0007c703          	lbu	a4,0(a5)
 662:	fd6709e3          	beq	a4,s6,634 <inet_pton+0x50>
            return -1;
 666:	557d                	li	a0,-1
 668:	bf65                	j	620 <inet_pton+0x3c>
        return -1;
 66a:	557d                	li	a0,-1
}
 66c:	8082                	ret
            return -1;
 66e:	557d                	li	a0,-1
 670:	bf45                	j	620 <inet_pton+0x3c>
            return -1;
 672:	557d                	li	a0,-1
 674:	b775                	j	620 <inet_pton+0x3c>
            return -1;
 676:	557d                	li	a0,-1
 678:	b765                	j	620 <inet_pton+0x3c>

000000000000067a <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 67a:	4885                	li	a7,1
 ecall
 67c:	00000073          	ecall
 ret
 680:	8082                	ret

0000000000000682 <exit>:
.global exit
exit:
 li a7, SYS_exit
 682:	4889                	li	a7,2
 ecall
 684:	00000073          	ecall
 ret
 688:	8082                	ret

000000000000068a <wait>:
.global wait
wait:
 li a7, SYS_wait
 68a:	488d                	li	a7,3
 ecall
 68c:	00000073          	ecall
 ret
 690:	8082                	ret

0000000000000692 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 692:	4891                	li	a7,4
 ecall
 694:	00000073          	ecall
 ret
 698:	8082                	ret

000000000000069a <read>:
.global read
read:
 li a7, SYS_read
 69a:	4895                	li	a7,5
 ecall
 69c:	00000073          	ecall
 ret
 6a0:	8082                	ret

00000000000006a2 <write>:
.global write
write:
 li a7, SYS_write
 6a2:	48c1                	li	a7,16
 ecall
 6a4:	00000073          	ecall
 ret
 6a8:	8082                	ret

00000000000006aa <close>:
.global close
close:
 li a7, SYS_close
 6aa:	48d5                	li	a7,21
 ecall
 6ac:	00000073          	ecall
 ret
 6b0:	8082                	ret

00000000000006b2 <kill>:
.global kill
kill:
 li a7, SYS_kill
 6b2:	4899                	li	a7,6
 ecall
 6b4:	00000073          	ecall
 ret
 6b8:	8082                	ret

00000000000006ba <exec>:
.global exec
exec:
 li a7, SYS_exec
 6ba:	489d                	li	a7,7
 ecall
 6bc:	00000073          	ecall
 ret
 6c0:	8082                	ret

00000000000006c2 <open>:
.global open
open:
 li a7, SYS_open
 6c2:	48bd                	li	a7,15
 ecall
 6c4:	00000073          	ecall
 ret
 6c8:	8082                	ret

00000000000006ca <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 6ca:	48c5                	li	a7,17
 ecall
 6cc:	00000073          	ecall
 ret
 6d0:	8082                	ret

00000000000006d2 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 6d2:	48c9                	li	a7,18
 ecall
 6d4:	00000073          	ecall
 ret
 6d8:	8082                	ret

00000000000006da <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 6da:	48a1                	li	a7,8
 ecall
 6dc:	00000073          	ecall
 ret
 6e0:	8082                	ret

00000000000006e2 <link>:
.global link
link:
 li a7, SYS_link
 6e2:	48cd                	li	a7,19
 ecall
 6e4:	00000073          	ecall
 ret
 6e8:	8082                	ret

00000000000006ea <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 6ea:	48d1                	li	a7,20
 ecall
 6ec:	00000073          	ecall
 ret
 6f0:	8082                	ret

00000000000006f2 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 6f2:	48a5                	li	a7,9
 ecall
 6f4:	00000073          	ecall
 ret
 6f8:	8082                	ret

00000000000006fa <dup>:
.global dup
dup:
 li a7, SYS_dup
 6fa:	48a9                	li	a7,10
 ecall
 6fc:	00000073          	ecall
 ret
 700:	8082                	ret

0000000000000702 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 702:	48ad                	li	a7,11
 ecall
 704:	00000073          	ecall
 ret
 708:	8082                	ret

000000000000070a <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 70a:	48b1                	li	a7,12
 ecall
 70c:	00000073          	ecall
 ret
 710:	8082                	ret

0000000000000712 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 712:	48b5                	li	a7,13
 ecall
 714:	00000073          	ecall
 ret
 718:	8082                	ret

000000000000071a <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 71a:	48b9                	li	a7,14
 ecall
 71c:	00000073          	ecall
 ret
 720:	8082                	ret

0000000000000722 <socket>:
.global socket
socket:
 li a7, SYS_socket
 722:	48d9                	li	a7,22
 ecall
 724:	00000073          	ecall
 ret
 728:	8082                	ret

000000000000072a <bind>:
.global bind
bind:
 li a7, SYS_bind
 72a:	48dd                	li	a7,23
 ecall
 72c:	00000073          	ecall
 ret
 730:	8082                	ret

0000000000000732 <recvfrom>:
.global recvfrom
recvfrom:
 li a7, SYS_recvfrom
 732:	48e1                	li	a7,24
 ecall
 734:	00000073          	ecall
 ret
 738:	8082                	ret

000000000000073a <sendto>:
.global sendto
sendto:
 li a7, SYS_sendto
 73a:	48e5                	li	a7,25
 ecall
 73c:	00000073          	ecall
 ret
 740:	8082                	ret

0000000000000742 <connect>:
.global connect
connect:
 li a7, SYS_connect
 742:	48e9                	li	a7,26
 ecall
 744:	00000073          	ecall
 ret
 748:	8082                	ret

000000000000074a <listen>:
.global listen
listen:
 li a7, SYS_listen
 74a:	48ed                	li	a7,27
 ecall
 74c:	00000073          	ecall
 ret
 750:	8082                	ret

0000000000000752 <accept>:
.global accept
accept:
 li a7, SYS_accept
 752:	48f1                	li	a7,28
 ecall
 754:	00000073          	ecall
 ret
 758:	8082                	ret

000000000000075a <recv>:
.global recv
recv:
 li a7, SYS_recv
 75a:	48f5                	li	a7,29
 ecall
 75c:	00000073          	ecall
 ret
 760:	8082                	ret

0000000000000762 <send>:
.global send
send:
 li a7, SYS_send
 762:	48f9                	li	a7,30
 ecall
 764:	00000073          	ecall
 ret
 768:	8082                	ret

000000000000076a <ioctl>:
.global ioctl
ioctl:
 li a7, SYS_ioctl
 76a:	48fd                	li	a7,31
 ecall
 76c:	00000073          	ecall
 ret
 770:	8082                	ret

0000000000000772 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 772:	1101                	add	sp,sp,-32
 774:	ec06                	sd	ra,24(sp)
 776:	e822                	sd	s0,16(sp)
 778:	1000                	add	s0,sp,32
 77a:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 77e:	4605                	li	a2,1
 780:	fef40593          	add	a1,s0,-17
 784:	f1fff0ef          	jal	6a2 <write>
}
 788:	60e2                	ld	ra,24(sp)
 78a:	6442                	ld	s0,16(sp)
 78c:	6105                	add	sp,sp,32
 78e:	8082                	ret

0000000000000790 <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
 790:	715d                	add	sp,sp,-80
 792:	e486                	sd	ra,72(sp)
 794:	e0a2                	sd	s0,64(sp)
 796:	fc26                	sd	s1,56(sp)
 798:	f84a                	sd	s2,48(sp)
 79a:	f44e                	sd	s3,40(sp)
 79c:	0880                	add	s0,sp,80
 79e:	84aa                	mv	s1,a0
  char buf[20];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 7a0:	c299                	beqz	a3,7a6 <printint+0x16>
 7a2:	0805c763          	bltz	a1,830 <printint+0xa0>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 7a6:	2581                	sext.w	a1,a1
  neg = 0;
 7a8:	4881                	li	a7,0
 7aa:	fb840693          	add	a3,s0,-72
  }

  i = 0;
 7ae:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 7b0:	2601                	sext.w	a2,a2
 7b2:	00000517          	auipc	a0,0x0
 7b6:	5c650513          	add	a0,a0,1478 # d78 <digits>
 7ba:	883a                	mv	a6,a4
 7bc:	2705                	addw	a4,a4,1
 7be:	02c5f7bb          	remuw	a5,a1,a2
 7c2:	1782                	sll	a5,a5,0x20
 7c4:	9381                	srl	a5,a5,0x20
 7c6:	97aa                	add	a5,a5,a0
 7c8:	0007c783          	lbu	a5,0(a5)
 7cc:	00f68023          	sb	a5,0(a3) # ff0000 <base+0xfeeff0>
  }while((x /= base) != 0);
 7d0:	0005879b          	sext.w	a5,a1
 7d4:	02c5d5bb          	divuw	a1,a1,a2
 7d8:	0685                	add	a3,a3,1
 7da:	fec7f0e3          	bgeu	a5,a2,7ba <printint+0x2a>
  if(neg)
 7de:	00088c63          	beqz	a7,7f6 <printint+0x66>
    buf[i++] = '-';
 7e2:	fd070793          	add	a5,a4,-48
 7e6:	00878733          	add	a4,a5,s0
 7ea:	02d00793          	li	a5,45
 7ee:	fef70423          	sb	a5,-24(a4)
 7f2:	0028071b          	addw	a4,a6,2

  while(--i >= 0)
 7f6:	02e05663          	blez	a4,822 <printint+0x92>
 7fa:	fb840793          	add	a5,s0,-72
 7fe:	00e78933          	add	s2,a5,a4
 802:	fff78993          	add	s3,a5,-1
 806:	99ba                	add	s3,s3,a4
 808:	377d                	addw	a4,a4,-1
 80a:	1702                	sll	a4,a4,0x20
 80c:	9301                	srl	a4,a4,0x20
 80e:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 812:	fff94583          	lbu	a1,-1(s2)
 816:	8526                	mv	a0,s1
 818:	f5bff0ef          	jal	772 <putc>
  while(--i >= 0)
 81c:	197d                	add	s2,s2,-1
 81e:	ff391ae3          	bne	s2,s3,812 <printint+0x82>
}
 822:	60a6                	ld	ra,72(sp)
 824:	6406                	ld	s0,64(sp)
 826:	74e2                	ld	s1,56(sp)
 828:	7942                	ld	s2,48(sp)
 82a:	79a2                	ld	s3,40(sp)
 82c:	6161                	add	sp,sp,80
 82e:	8082                	ret
    x = -xx;
 830:	40b005bb          	negw	a1,a1
    neg = 1;
 834:	4885                	li	a7,1
    x = -xx;
 836:	bf95                	j	7aa <printint+0x1a>

0000000000000838 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 838:	711d                	add	sp,sp,-96
 83a:	ec86                	sd	ra,88(sp)
 83c:	e8a2                	sd	s0,80(sp)
 83e:	e4a6                	sd	s1,72(sp)
 840:	e0ca                	sd	s2,64(sp)
 842:	fc4e                	sd	s3,56(sp)
 844:	f852                	sd	s4,48(sp)
 846:	f456                	sd	s5,40(sp)
 848:	f05a                	sd	s6,32(sp)
 84a:	ec5e                	sd	s7,24(sp)
 84c:	e862                	sd	s8,16(sp)
 84e:	e466                	sd	s9,8(sp)
 850:	e06a                	sd	s10,0(sp)
 852:	1080                	add	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 854:	0005c903          	lbu	s2,0(a1)
 858:	24090763          	beqz	s2,aa6 <vprintf+0x26e>
 85c:	8b2a                	mv	s6,a0
 85e:	8a2e                	mv	s4,a1
 860:	8bb2                	mv	s7,a2
  state = 0;
 862:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
 864:	4481                	li	s1,0
 866:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
 868:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
 86c:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
 870:	06c00c93          	li	s9,108
 874:	a005                	j	894 <vprintf+0x5c>
        putc(fd, c0);
 876:	85ca                	mv	a1,s2
 878:	855a                	mv	a0,s6
 87a:	ef9ff0ef          	jal	772 <putc>
 87e:	a019                	j	884 <vprintf+0x4c>
    } else if(state == '%'){
 880:	03598263          	beq	s3,s5,8a4 <vprintf+0x6c>
  for(i = 0; fmt[i]; i++){
 884:	2485                	addw	s1,s1,1
 886:	8726                	mv	a4,s1
 888:	009a07b3          	add	a5,s4,s1
 88c:	0007c903          	lbu	s2,0(a5)
 890:	20090b63          	beqz	s2,aa6 <vprintf+0x26e>
    c0 = fmt[i] & 0xff;
 894:	0009079b          	sext.w	a5,s2
    if(state == 0){
 898:	fe0994e3          	bnez	s3,880 <vprintf+0x48>
      if(c0 == '%'){
 89c:	fd579de3          	bne	a5,s5,876 <vprintf+0x3e>
        state = '%';
 8a0:	89be                	mv	s3,a5
 8a2:	b7cd                	j	884 <vprintf+0x4c>
      if(c0) c1 = fmt[i+1] & 0xff;
 8a4:	c7c9                	beqz	a5,92e <vprintf+0xf6>
 8a6:	00ea06b3          	add	a3,s4,a4
 8aa:	0016c683          	lbu	a3,1(a3)
      c1 = c2 = 0;
 8ae:	8636                	mv	a2,a3
      if(c1) c2 = fmt[i+2] & 0xff;
 8b0:	c681                	beqz	a3,8b8 <vprintf+0x80>
 8b2:	9752                	add	a4,a4,s4
 8b4:	00274603          	lbu	a2,2(a4)
      if(c0 == 'd'){
 8b8:	03878f63          	beq	a5,s8,8f6 <vprintf+0xbe>
      } else if(c0 == 'l' && c1 == 'd'){
 8bc:	05978963          	beq	a5,s9,90e <vprintf+0xd6>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
 8c0:	07500713          	li	a4,117
 8c4:	0ee78363          	beq	a5,a4,9aa <vprintf+0x172>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
 8c8:	07800713          	li	a4,120
 8cc:	12e78563          	beq	a5,a4,9f6 <vprintf+0x1be>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
 8d0:	07000713          	li	a4,112
 8d4:	14e78a63          	beq	a5,a4,a28 <vprintf+0x1f0>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 's'){
 8d8:	07300713          	li	a4,115
 8dc:	18e78863          	beq	a5,a4,a6c <vprintf+0x234>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
 8e0:	02500713          	li	a4,37
 8e4:	04e79563          	bne	a5,a4,92e <vprintf+0xf6>
        putc(fd, '%');
 8e8:	02500593          	li	a1,37
 8ec:	855a                	mv	a0,s6
 8ee:	e85ff0ef          	jal	772 <putc>
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
#endif
      state = 0;
 8f2:	4981                	li	s3,0
 8f4:	bf41                	j	884 <vprintf+0x4c>
        printint(fd, va_arg(ap, int), 10, 1);
 8f6:	008b8913          	add	s2,s7,8
 8fa:	4685                	li	a3,1
 8fc:	4629                	li	a2,10
 8fe:	000ba583          	lw	a1,0(s7)
 902:	855a                	mv	a0,s6
 904:	e8dff0ef          	jal	790 <printint>
 908:	8bca                	mv	s7,s2
      state = 0;
 90a:	4981                	li	s3,0
 90c:	bfa5                	j	884 <vprintf+0x4c>
      } else if(c0 == 'l' && c1 == 'd'){
 90e:	06400793          	li	a5,100
 912:	02f68963          	beq	a3,a5,944 <vprintf+0x10c>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 916:	06c00793          	li	a5,108
 91a:	04f68263          	beq	a3,a5,95e <vprintf+0x126>
      } else if(c0 == 'l' && c1 == 'u'){
 91e:	07500793          	li	a5,117
 922:	0af68063          	beq	a3,a5,9c2 <vprintf+0x18a>
      } else if(c0 == 'l' && c1 == 'x'){
 926:	07800793          	li	a5,120
 92a:	0ef68263          	beq	a3,a5,a0e <vprintf+0x1d6>
        putc(fd, '%');
 92e:	02500593          	li	a1,37
 932:	855a                	mv	a0,s6
 934:	e3fff0ef          	jal	772 <putc>
        putc(fd, c0);
 938:	85ca                	mv	a1,s2
 93a:	855a                	mv	a0,s6
 93c:	e37ff0ef          	jal	772 <putc>
      state = 0;
 940:	4981                	li	s3,0
 942:	b789                	j	884 <vprintf+0x4c>
        printint(fd, va_arg(ap, uint64), 10, 1);
 944:	008b8913          	add	s2,s7,8
 948:	4685                	li	a3,1
 94a:	4629                	li	a2,10
 94c:	000bb583          	ld	a1,0(s7)
 950:	855a                	mv	a0,s6
 952:	e3fff0ef          	jal	790 <printint>
        i += 1;
 956:	2485                	addw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 958:	8bca                	mv	s7,s2
      state = 0;
 95a:	4981                	li	s3,0
        i += 1;
 95c:	b725                	j	884 <vprintf+0x4c>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 95e:	06400793          	li	a5,100
 962:	02f60763          	beq	a2,a5,990 <vprintf+0x158>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 966:	07500793          	li	a5,117
 96a:	06f60963          	beq	a2,a5,9dc <vprintf+0x1a4>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 96e:	07800793          	li	a5,120
 972:	faf61ee3          	bne	a2,a5,92e <vprintf+0xf6>
        printint(fd, va_arg(ap, uint64), 16, 0);
 976:	008b8913          	add	s2,s7,8
 97a:	4681                	li	a3,0
 97c:	4641                	li	a2,16
 97e:	000bb583          	ld	a1,0(s7)
 982:	855a                	mv	a0,s6
 984:	e0dff0ef          	jal	790 <printint>
        i += 2;
 988:	2489                	addw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 98a:	8bca                	mv	s7,s2
      state = 0;
 98c:	4981                	li	s3,0
        i += 2;
 98e:	bddd                	j	884 <vprintf+0x4c>
        printint(fd, va_arg(ap, uint64), 10, 1);
 990:	008b8913          	add	s2,s7,8
 994:	4685                	li	a3,1
 996:	4629                	li	a2,10
 998:	000bb583          	ld	a1,0(s7)
 99c:	855a                	mv	a0,s6
 99e:	df3ff0ef          	jal	790 <printint>
        i += 2;
 9a2:	2489                	addw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 9a4:	8bca                	mv	s7,s2
      state = 0;
 9a6:	4981                	li	s3,0
        i += 2;
 9a8:	bdf1                	j	884 <vprintf+0x4c>
        printint(fd, va_arg(ap, int), 10, 0);
 9aa:	008b8913          	add	s2,s7,8
 9ae:	4681                	li	a3,0
 9b0:	4629                	li	a2,10
 9b2:	000ba583          	lw	a1,0(s7)
 9b6:	855a                	mv	a0,s6
 9b8:	dd9ff0ef          	jal	790 <printint>
 9bc:	8bca                	mv	s7,s2
      state = 0;
 9be:	4981                	li	s3,0
 9c0:	b5d1                	j	884 <vprintf+0x4c>
        printint(fd, va_arg(ap, uint64), 10, 0);
 9c2:	008b8913          	add	s2,s7,8
 9c6:	4681                	li	a3,0
 9c8:	4629                	li	a2,10
 9ca:	000bb583          	ld	a1,0(s7)
 9ce:	855a                	mv	a0,s6
 9d0:	dc1ff0ef          	jal	790 <printint>
        i += 1;
 9d4:	2485                	addw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 9d6:	8bca                	mv	s7,s2
      state = 0;
 9d8:	4981                	li	s3,0
        i += 1;
 9da:	b56d                	j	884 <vprintf+0x4c>
        printint(fd, va_arg(ap, uint64), 10, 0);
 9dc:	008b8913          	add	s2,s7,8
 9e0:	4681                	li	a3,0
 9e2:	4629                	li	a2,10
 9e4:	000bb583          	ld	a1,0(s7)
 9e8:	855a                	mv	a0,s6
 9ea:	da7ff0ef          	jal	790 <printint>
        i += 2;
 9ee:	2489                	addw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 9f0:	8bca                	mv	s7,s2
      state = 0;
 9f2:	4981                	li	s3,0
        i += 2;
 9f4:	bd41                	j	884 <vprintf+0x4c>
        printint(fd, va_arg(ap, int), 16, 0);
 9f6:	008b8913          	add	s2,s7,8
 9fa:	4681                	li	a3,0
 9fc:	4641                	li	a2,16
 9fe:	000ba583          	lw	a1,0(s7)
 a02:	855a                	mv	a0,s6
 a04:	d8dff0ef          	jal	790 <printint>
 a08:	8bca                	mv	s7,s2
      state = 0;
 a0a:	4981                	li	s3,0
 a0c:	bda5                	j	884 <vprintf+0x4c>
        printint(fd, va_arg(ap, uint64), 16, 0);
 a0e:	008b8913          	add	s2,s7,8
 a12:	4681                	li	a3,0
 a14:	4641                	li	a2,16
 a16:	000bb583          	ld	a1,0(s7)
 a1a:	855a                	mv	a0,s6
 a1c:	d75ff0ef          	jal	790 <printint>
        i += 1;
 a20:	2485                	addw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 a22:	8bca                	mv	s7,s2
      state = 0;
 a24:	4981                	li	s3,0
        i += 1;
 a26:	bdb9                	j	884 <vprintf+0x4c>
        printptr(fd, va_arg(ap, uint64));
 a28:	008b8d13          	add	s10,s7,8
 a2c:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 a30:	03000593          	li	a1,48
 a34:	855a                	mv	a0,s6
 a36:	d3dff0ef          	jal	772 <putc>
  putc(fd, 'x');
 a3a:	07800593          	li	a1,120
 a3e:	855a                	mv	a0,s6
 a40:	d33ff0ef          	jal	772 <putc>
 a44:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 a46:	00000b97          	auipc	s7,0x0
 a4a:	332b8b93          	add	s7,s7,818 # d78 <digits>
 a4e:	03c9d793          	srl	a5,s3,0x3c
 a52:	97de                	add	a5,a5,s7
 a54:	0007c583          	lbu	a1,0(a5)
 a58:	855a                	mv	a0,s6
 a5a:	d19ff0ef          	jal	772 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 a5e:	0992                	sll	s3,s3,0x4
 a60:	397d                	addw	s2,s2,-1
 a62:	fe0916e3          	bnez	s2,a4e <vprintf+0x216>
        printptr(fd, va_arg(ap, uint64));
 a66:	8bea                	mv	s7,s10
      state = 0;
 a68:	4981                	li	s3,0
 a6a:	bd29                	j	884 <vprintf+0x4c>
        if((s = va_arg(ap, char*)) == 0)
 a6c:	008b8993          	add	s3,s7,8
 a70:	000bb903          	ld	s2,0(s7)
 a74:	00090f63          	beqz	s2,a92 <vprintf+0x25a>
        for(; *s; s++)
 a78:	00094583          	lbu	a1,0(s2)
 a7c:	c195                	beqz	a1,aa0 <vprintf+0x268>
          putc(fd, *s);
 a7e:	855a                	mv	a0,s6
 a80:	cf3ff0ef          	jal	772 <putc>
        for(; *s; s++)
 a84:	0905                	add	s2,s2,1
 a86:	00094583          	lbu	a1,0(s2)
 a8a:	f9f5                	bnez	a1,a7e <vprintf+0x246>
        if((s = va_arg(ap, char*)) == 0)
 a8c:	8bce                	mv	s7,s3
      state = 0;
 a8e:	4981                	li	s3,0
 a90:	bbd5                	j	884 <vprintf+0x4c>
          s = "(null)";
 a92:	00000917          	auipc	s2,0x0
 a96:	2de90913          	add	s2,s2,734 # d70 <malloc+0x1d0>
        for(; *s; s++)
 a9a:	02800593          	li	a1,40
 a9e:	b7c5                	j	a7e <vprintf+0x246>
        if((s = va_arg(ap, char*)) == 0)
 aa0:	8bce                	mv	s7,s3
      state = 0;
 aa2:	4981                	li	s3,0
 aa4:	b3c5                	j	884 <vprintf+0x4c>
    }
  }
}
 aa6:	60e6                	ld	ra,88(sp)
 aa8:	6446                	ld	s0,80(sp)
 aaa:	64a6                	ld	s1,72(sp)
 aac:	6906                	ld	s2,64(sp)
 aae:	79e2                	ld	s3,56(sp)
 ab0:	7a42                	ld	s4,48(sp)
 ab2:	7aa2                	ld	s5,40(sp)
 ab4:	7b02                	ld	s6,32(sp)
 ab6:	6be2                	ld	s7,24(sp)
 ab8:	6c42                	ld	s8,16(sp)
 aba:	6ca2                	ld	s9,8(sp)
 abc:	6d02                	ld	s10,0(sp)
 abe:	6125                	add	sp,sp,96
 ac0:	8082                	ret

0000000000000ac2 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 ac2:	715d                	add	sp,sp,-80
 ac4:	ec06                	sd	ra,24(sp)
 ac6:	e822                	sd	s0,16(sp)
 ac8:	1000                	add	s0,sp,32
 aca:	e010                	sd	a2,0(s0)
 acc:	e414                	sd	a3,8(s0)
 ace:	e818                	sd	a4,16(s0)
 ad0:	ec1c                	sd	a5,24(s0)
 ad2:	03043023          	sd	a6,32(s0)
 ad6:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 ada:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 ade:	8622                	mv	a2,s0
 ae0:	d59ff0ef          	jal	838 <vprintf>
}
 ae4:	60e2                	ld	ra,24(sp)
 ae6:	6442                	ld	s0,16(sp)
 ae8:	6161                	add	sp,sp,80
 aea:	8082                	ret

0000000000000aec <printf>:

void
printf(const char *fmt, ...)
{
 aec:	711d                	add	sp,sp,-96
 aee:	ec06                	sd	ra,24(sp)
 af0:	e822                	sd	s0,16(sp)
 af2:	1000                	add	s0,sp,32
 af4:	e40c                	sd	a1,8(s0)
 af6:	e810                	sd	a2,16(s0)
 af8:	ec14                	sd	a3,24(s0)
 afa:	f018                	sd	a4,32(s0)
 afc:	f41c                	sd	a5,40(s0)
 afe:	03043823          	sd	a6,48(s0)
 b02:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 b06:	00840613          	add	a2,s0,8
 b0a:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 b0e:	85aa                	mv	a1,a0
 b10:	4505                	li	a0,1
 b12:	d27ff0ef          	jal	838 <vprintf>
}
 b16:	60e2                	ld	ra,24(sp)
 b18:	6442                	ld	s0,16(sp)
 b1a:	6125                	add	sp,sp,96
 b1c:	8082                	ret

0000000000000b1e <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 b1e:	1141                	add	sp,sp,-16
 b20:	e422                	sd	s0,8(sp)
 b22:	0800                	add	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 b24:	ff050693          	add	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 b28:	00000797          	auipc	a5,0x0
 b2c:	4e07b783          	ld	a5,1248(a5) # 1008 <freep>
 b30:	a02d                	j	b5a <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 b32:	4618                	lw	a4,8(a2)
 b34:	9f2d                	addw	a4,a4,a1
 b36:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 b3a:	6398                	ld	a4,0(a5)
 b3c:	6310                	ld	a2,0(a4)
 b3e:	a83d                	j	b7c <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 b40:	ff852703          	lw	a4,-8(a0)
 b44:	9f31                	addw	a4,a4,a2
 b46:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 b48:	ff053683          	ld	a3,-16(a0)
 b4c:	a091                	j	b90 <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 b4e:	6398                	ld	a4,0(a5)
 b50:	00e7e463          	bltu	a5,a4,b58 <free+0x3a>
 b54:	00e6ea63          	bltu	a3,a4,b68 <free+0x4a>
{
 b58:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 b5a:	fed7fae3          	bgeu	a5,a3,b4e <free+0x30>
 b5e:	6398                	ld	a4,0(a5)
 b60:	00e6e463          	bltu	a3,a4,b68 <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 b64:	fee7eae3          	bltu	a5,a4,b58 <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 b68:	ff852583          	lw	a1,-8(a0)
 b6c:	6390                	ld	a2,0(a5)
 b6e:	02059813          	sll	a6,a1,0x20
 b72:	01c85713          	srl	a4,a6,0x1c
 b76:	9736                	add	a4,a4,a3
 b78:	fae60de3          	beq	a2,a4,b32 <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 b7c:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 b80:	4790                	lw	a2,8(a5)
 b82:	02061593          	sll	a1,a2,0x20
 b86:	01c5d713          	srl	a4,a1,0x1c
 b8a:	973e                	add	a4,a4,a5
 b8c:	fae68ae3          	beq	a3,a4,b40 <free+0x22>
    p->s.ptr = bp->s.ptr;
 b90:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 b92:	00000717          	auipc	a4,0x0
 b96:	46f73b23          	sd	a5,1142(a4) # 1008 <freep>
}
 b9a:	6422                	ld	s0,8(sp)
 b9c:	0141                	add	sp,sp,16
 b9e:	8082                	ret

0000000000000ba0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 ba0:	7139                	add	sp,sp,-64
 ba2:	fc06                	sd	ra,56(sp)
 ba4:	f822                	sd	s0,48(sp)
 ba6:	f426                	sd	s1,40(sp)
 ba8:	f04a                	sd	s2,32(sp)
 baa:	ec4e                	sd	s3,24(sp)
 bac:	e852                	sd	s4,16(sp)
 bae:	e456                	sd	s5,8(sp)
 bb0:	e05a                	sd	s6,0(sp)
 bb2:	0080                	add	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 bb4:	02051493          	sll	s1,a0,0x20
 bb8:	9081                	srl	s1,s1,0x20
 bba:	04bd                	add	s1,s1,15
 bbc:	8091                	srl	s1,s1,0x4
 bbe:	0014899b          	addw	s3,s1,1
 bc2:	0485                	add	s1,s1,1
  if((prevp = freep) == 0){
 bc4:	00000517          	auipc	a0,0x0
 bc8:	44453503          	ld	a0,1092(a0) # 1008 <freep>
 bcc:	c515                	beqz	a0,bf8 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 bce:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 bd0:	4798                	lw	a4,8(a5)
 bd2:	02977f63          	bgeu	a4,s1,c10 <malloc+0x70>
  if(nu < 4096)
 bd6:	8a4e                	mv	s4,s3
 bd8:	0009871b          	sext.w	a4,s3
 bdc:	6685                	lui	a3,0x1
 bde:	00d77363          	bgeu	a4,a3,be4 <malloc+0x44>
 be2:	6a05                	lui	s4,0x1
 be4:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 be8:	004a1a1b          	sllw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 bec:	00000917          	auipc	s2,0x0
 bf0:	41c90913          	add	s2,s2,1052 # 1008 <freep>
  if(p == (char*)-1)
 bf4:	5afd                	li	s5,-1
 bf6:	a885                	j	c66 <malloc+0xc6>
    base.s.ptr = freep = prevp = &base;
 bf8:	00000797          	auipc	a5,0x0
 bfc:	41878793          	add	a5,a5,1048 # 1010 <base>
 c00:	00000717          	auipc	a4,0x0
 c04:	40f73423          	sd	a5,1032(a4) # 1008 <freep>
 c08:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 c0a:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 c0e:	b7e1                	j	bd6 <malloc+0x36>
      if(p->s.size == nunits)
 c10:	02e48c63          	beq	s1,a4,c48 <malloc+0xa8>
        p->s.size -= nunits;
 c14:	4137073b          	subw	a4,a4,s3
 c18:	c798                	sw	a4,8(a5)
        p += p->s.size;
 c1a:	02071693          	sll	a3,a4,0x20
 c1e:	01c6d713          	srl	a4,a3,0x1c
 c22:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 c24:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 c28:	00000717          	auipc	a4,0x0
 c2c:	3ea73023          	sd	a0,992(a4) # 1008 <freep>
      return (void*)(p + 1);
 c30:	01078513          	add	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 c34:	70e2                	ld	ra,56(sp)
 c36:	7442                	ld	s0,48(sp)
 c38:	74a2                	ld	s1,40(sp)
 c3a:	7902                	ld	s2,32(sp)
 c3c:	69e2                	ld	s3,24(sp)
 c3e:	6a42                	ld	s4,16(sp)
 c40:	6aa2                	ld	s5,8(sp)
 c42:	6b02                	ld	s6,0(sp)
 c44:	6121                	add	sp,sp,64
 c46:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 c48:	6398                	ld	a4,0(a5)
 c4a:	e118                	sd	a4,0(a0)
 c4c:	bff1                	j	c28 <malloc+0x88>
  hp->s.size = nu;
 c4e:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 c52:	0541                	add	a0,a0,16
 c54:	ecbff0ef          	jal	b1e <free>
  return freep;
 c58:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 c5c:	dd61                	beqz	a0,c34 <malloc+0x94>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 c5e:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 c60:	4798                	lw	a4,8(a5)
 c62:	fa9777e3          	bgeu	a4,s1,c10 <malloc+0x70>
    if(p == freep)
 c66:	00093703          	ld	a4,0(s2)
 c6a:	853e                	mv	a0,a5
 c6c:	fef719e3          	bne	a4,a5,c5e <malloc+0xbe>
  p = sbrk(nu * sizeof(Header));
 c70:	8552                	mv	a0,s4
 c72:	a99ff0ef          	jal	70a <sbrk>
  if(p == (char*)-1)
 c76:	fd551ce3          	bne	a0,s5,c4e <malloc+0xae>
        return 0;
 c7a:	4501                	li	a0,0
 c7c:	bf65                	j	c34 <malloc+0x94>
