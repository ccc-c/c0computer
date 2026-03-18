
user/_tcpecho:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "user/user.h"
#include "kernel/net/socket.h"

int
main (int argc, char *argv[])
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
  12:	0100                	add	s0,sp,128
  14:	81010113          	add	sp,sp,-2032
    int soc, acc, peerlen, ret;
    struct sockaddr_in self, peer;
    unsigned char *addr;
    char buf[2048];

    printf("Starting TCP Echo Server\n");
  18:	00001517          	auipc	a0,0x1
  1c:	b8850513          	add	a0,a0,-1144 # ba0 <malloc+0x100>
  20:	1cd000ef          	jal	9ec <printf>
    soc = socket(PF_INET, SOCK_STREAM, IPPROTO_TCP);
  24:	4601                	li	a2,0
  26:	4589                	li	a1,2
  28:	4505                	li	a0,1
  2a:	5f2000ef          	jal	61c <socket>
    if (soc == 1) {
  2e:	4785                	li	a5,1
  30:	12f50263          	beq	a0,a5,154 <main+0x154>
  34:	892a                	mv	s2,a0
        printf("socket: failure\n");
        exit(1);
    }
    printf("socket: success, soc=%d\n", soc);
  36:	85aa                	mv	a1,a0
  38:	00001517          	auipc	a0,0x1
  3c:	ba050513          	add	a0,a0,-1120 # bd8 <malloc+0x138>
  40:	1ad000ef          	jal	9ec <printf>
    self.sin_family = AF_INET;
  44:	4785                	li	a5,1
  46:	faf41823          	sh	a5,-80(s0)
    self.sin_addr.s_addr = INADDR_ANY;
  4a:	fa042a23          	sw	zero,-76(s0)
    self.sin_port = htons(7);
  4e:	451d                	li	a0,7
  50:	484000ef          	jal	4d4 <htons>
  54:	faa41923          	sh	a0,-78(s0)
    if (bind(soc, (struct sockaddr *)&self, sizeof(self)) == -1) {
  58:	4621                	li	a2,8
  5a:	fb040593          	add	a1,s0,-80
  5e:	854a                	mv	a0,s2
  60:	5c4000ef          	jal	624 <bind>
  64:	57fd                	li	a5,-1
  66:	10f50063          	beq	a0,a5,166 <main+0x166>
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
  7e:	470000ef          	jal	4ee <ntohs>
  82:	0005079b          	sext.w	a5,a0
  86:	8756                	mv	a4,s5
  88:	86d2                	mv	a3,s4
  8a:	864e                	mv	a2,s3
  8c:	85a6                	mv	a1,s1
  8e:	00001517          	auipc	a0,0x1
  92:	b7a50513          	add	a0,a0,-1158 # c08 <malloc+0x168>
  96:	157000ef          	jal	9ec <printf>
    listen(soc, 100);
  9a:	06400593          	li	a1,100
  9e:	854a                	mv	a0,s2
  a0:	58c000ef          	jal	62c <listen>
    printf("waiting for connection...\n");
  a4:	00001517          	auipc	a0,0x1
  a8:	b8c50513          	add	a0,a0,-1140 # c30 <malloc+0x190>
  ac:	141000ef          	jal	9ec <printf>
    peerlen = sizeof(peer);
  b0:	47a1                	li	a5,8
  b2:	faf42e23          	sw	a5,-68(s0)
    acc = accept(soc, (struct sockaddr *)&peer, &peerlen);
  b6:	fbc40613          	add	a2,s0,-68
  ba:	fa840593          	add	a1,s0,-88
  be:	854a                	mv	a0,s2
  c0:	574000ef          	jal	634 <accept>
  c4:	89aa                	mv	s3,a0
    if (acc == -1) {
  c6:	57fd                	li	a5,-1
  c8:	0af50b63          	beq	a0,a5,17e <main+0x17e>
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
  e0:	40e000ef          	jal	4ee <ntohs>
  e4:	0005079b          	sext.w	a5,a0
  e8:	875a                	mv	a4,s6
  ea:	86d6                	mv	a3,s5
  ec:	8652                	mv	a2,s4
  ee:	85a6                	mv	a1,s1
  f0:	00001517          	auipc	a0,0x1
  f4:	b7850513          	add	a0,a0,-1160 # c68 <malloc+0x1c8>
  f8:	0f5000ef          	jal	9ec <printf>
    while (1) {
        ret = recv(acc, buf, sizeof(buf), 0);
  fc:	77fd                	lui	a5,0xfffff
  fe:	7a878793          	add	a5,a5,1960 # fffffffffffff7a8 <base+0xffffffffffffe798>
 102:	97a2                	add	a5,a5,s0
 104:	777d                	lui	a4,0xfffff
 106:	79870713          	add	a4,a4,1944 # fffffffffffff798 <base+0xffffffffffffe788>
 10a:	9722                	add	a4,a4,s0
 10c:	e31c                	sd	a5,0(a4)
 10e:	6a05                	lui	s4,0x1
 110:	800a0a13          	add	s4,s4,-2048 # 800 <vprintf+0xe2>
        if (ret <= 0) {
            printf("EOF\n");
            break;
        }
        printf("recv: %d bytes data received\n", ret);
 114:	00001a97          	auipc	s5,0x1
 118:	b84a8a93          	add	s5,s5,-1148 # c98 <malloc+0x1f8>
        ret = recv(acc, buf, sizeof(buf), 0);
 11c:	4681                	li	a3,0
 11e:	8652                	mv	a2,s4
 120:	77fd                	lui	a5,0xfffff
 122:	79878793          	add	a5,a5,1944 # fffffffffffff798 <base+0xffffffffffffe788>
 126:	97a2                	add	a5,a5,s0
 128:	638c                	ld	a1,0(a5)
 12a:	854e                	mv	a0,s3
 12c:	520000ef          	jal	64c <recv>
 130:	84aa                	mv	s1,a0
        if (ret <= 0) {
 132:	06a05263          	blez	a0,196 <main+0x196>
        printf("recv: %d bytes data received\n", ret);
 136:	85aa                	mv	a1,a0
 138:	8556                	mv	a0,s5
 13a:	0b3000ef          	jal	9ec <printf>
        send(acc, buf, ret, 0);
 13e:	4681                	li	a3,0
 140:	8626                	mv	a2,s1
 142:	77fd                	lui	a5,0xfffff
 144:	79878793          	add	a5,a5,1944 # fffffffffffff798 <base+0xffffffffffffe788>
 148:	97a2                	add	a5,a5,s0
 14a:	638c                	ld	a1,0(a5)
 14c:	854e                	mv	a0,s3
 14e:	4f6000ef          	jal	644 <send>
        ret = recv(acc, buf, sizeof(buf), 0);
 152:	b7e9                	j	11c <main+0x11c>
        printf("socket: failure\n");
 154:	00001517          	auipc	a0,0x1
 158:	a6c50513          	add	a0,a0,-1428 # bc0 <malloc+0x120>
 15c:	091000ef          	jal	9ec <printf>
        exit(1);
 160:	4505                	li	a0,1
 162:	41a000ef          	jal	57c <exit>
        printf("bind: failure\n");
 166:	00001517          	auipc	a0,0x1
 16a:	a9250513          	add	a0,a0,-1390 # bf8 <malloc+0x158>
 16e:	07f000ef          	jal	9ec <printf>
        close(soc);
 172:	854a                	mv	a0,s2
 174:	430000ef          	jal	5a4 <close>
        exit(1);
 178:	4505                	li	a0,1
 17a:	402000ef          	jal	57c <exit>
        printf("accept: failure\n");
 17e:	00001517          	auipc	a0,0x1
 182:	ad250513          	add	a0,a0,-1326 # c50 <malloc+0x1b0>
 186:	067000ef          	jal	9ec <printf>
        close(soc);
 18a:	854a                	mv	a0,s2
 18c:	418000ef          	jal	5a4 <close>
        exit(1);
 190:	4505                	li	a0,1
 192:	3ea000ef          	jal	57c <exit>
            printf("EOF\n");
 196:	00001517          	auipc	a0,0x1
 19a:	afa50513          	add	a0,a0,-1286 # c90 <malloc+0x1f0>
 19e:	04f000ef          	jal	9ec <printf>
    }
    close(soc);  
 1a2:	854a                	mv	a0,s2
 1a4:	400000ef          	jal	5a4 <close>
    exit(0);
 1a8:	4501                	li	a0,0
 1aa:	3d2000ef          	jal	57c <exit>

00000000000001ae <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start(int argc, char **argv)
{
 1ae:	1141                	add	sp,sp,-16
 1b0:	e406                	sd	ra,8(sp)
 1b2:	e022                	sd	s0,0(sp)
 1b4:	0800                	add	s0,sp,16
  int r;
  extern int main(int argc, char **argv);
  r = main(argc, argv);
 1b6:	e4bff0ef          	jal	0 <main>
  exit(r);
 1ba:	3c2000ef          	jal	57c <exit>

00000000000001be <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
 1be:	1141                	add	sp,sp,-16
 1c0:	e422                	sd	s0,8(sp)
 1c2:	0800                	add	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 1c4:	87aa                	mv	a5,a0
 1c6:	0585                	add	a1,a1,1
 1c8:	0785                	add	a5,a5,1
 1ca:	fff5c703          	lbu	a4,-1(a1)
 1ce:	fee78fa3          	sb	a4,-1(a5)
 1d2:	fb75                	bnez	a4,1c6 <strcpy+0x8>
    ;
  return os;
}
 1d4:	6422                	ld	s0,8(sp)
 1d6:	0141                	add	sp,sp,16
 1d8:	8082                	ret

00000000000001da <strcmp>:

int
strcmp(const char *p, const char *q)
{
 1da:	1141                	add	sp,sp,-16
 1dc:	e422                	sd	s0,8(sp)
 1de:	0800                	add	s0,sp,16
  while(*p && *p == *q)
 1e0:	00054783          	lbu	a5,0(a0)
 1e4:	cb91                	beqz	a5,1f8 <strcmp+0x1e>
 1e6:	0005c703          	lbu	a4,0(a1)
 1ea:	00f71763          	bne	a4,a5,1f8 <strcmp+0x1e>
    p++, q++;
 1ee:	0505                	add	a0,a0,1
 1f0:	0585                	add	a1,a1,1
  while(*p && *p == *q)
 1f2:	00054783          	lbu	a5,0(a0)
 1f6:	fbe5                	bnez	a5,1e6 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 1f8:	0005c503          	lbu	a0,0(a1)
}
 1fc:	40a7853b          	subw	a0,a5,a0
 200:	6422                	ld	s0,8(sp)
 202:	0141                	add	sp,sp,16
 204:	8082                	ret

0000000000000206 <strncmp>:

int
strncmp(const char *p, const char *q, uint n)
{
 206:	1141                	add	sp,sp,-16
 208:	e422                	sd	s0,8(sp)
 20a:	0800                	add	s0,sp,16
  while(n > 0 && *p && *p == *q) {
 20c:	ce11                	beqz	a2,228 <strncmp+0x22>
 20e:	00054783          	lbu	a5,0(a0)
 212:	cf89                	beqz	a5,22c <strncmp+0x26>
 214:	0005c703          	lbu	a4,0(a1)
 218:	00f71a63          	bne	a4,a5,22c <strncmp+0x26>
    p++, q++, n--;
 21c:	0505                	add	a0,a0,1
 21e:	0585                	add	a1,a1,1
 220:	367d                	addw	a2,a2,-1
  while(n > 0 && *p && *p == *q) {
 222:	f675                	bnez	a2,20e <strncmp+0x8>
  }
  if (n == 0)
    return 0;
 224:	4501                	li	a0,0
 226:	a801                	j	236 <strncmp+0x30>
 228:	4501                	li	a0,0
 22a:	a031                	j	236 <strncmp+0x30>
  return (uchar)*p - (uchar)*q;
 22c:	00054503          	lbu	a0,0(a0)
 230:	0005c783          	lbu	a5,0(a1)
 234:	9d1d                	subw	a0,a0,a5
}
 236:	6422                	ld	s0,8(sp)
 238:	0141                	add	sp,sp,16
 23a:	8082                	ret

000000000000023c <strcat>:

char*
strcat(char *dst, const char *src)
{
 23c:	1141                	add	sp,sp,-16
 23e:	e422                	sd	s0,8(sp)
 240:	0800                	add	s0,sp,16
  char *p = dst;
  while(*p) p++;
 242:	00054783          	lbu	a5,0(a0)
 246:	c385                	beqz	a5,266 <strcat+0x2a>
  char *p = dst;
 248:	87aa                	mv	a5,a0
  while(*p) p++;
 24a:	0785                	add	a5,a5,1
 24c:	0007c703          	lbu	a4,0(a5)
 250:	ff6d                	bnez	a4,24a <strcat+0xe>
  while((*p++ = *src++) != 0);
 252:	0585                	add	a1,a1,1
 254:	0785                	add	a5,a5,1
 256:	fff5c703          	lbu	a4,-1(a1)
 25a:	fee78fa3          	sb	a4,-1(a5)
 25e:	fb75                	bnez	a4,252 <strcat+0x16>
  return dst;
}
 260:	6422                	ld	s0,8(sp)
 262:	0141                	add	sp,sp,16
 264:	8082                	ret
  char *p = dst;
 266:	87aa                	mv	a5,a0
 268:	b7ed                	j	252 <strcat+0x16>

000000000000026a <strncpy>:

char*
strncpy(char *dst, const char *src, int n)
{
 26a:	1141                	add	sp,sp,-16
 26c:	e422                	sd	s0,8(sp)
 26e:	0800                	add	s0,sp,16
  char *p = dst;
 270:	87aa                	mv	a5,a0
  while(n > 0 && *src) {
 272:	02c05463          	blez	a2,29a <strncpy+0x30>
 276:	0005c703          	lbu	a4,0(a1)
 27a:	cb01                	beqz	a4,28a <strncpy+0x20>
    *p++ = *src++;
 27c:	0585                	add	a1,a1,1
 27e:	0785                	add	a5,a5,1
 280:	fee78fa3          	sb	a4,-1(a5)
    n--;
 284:	367d                	addw	a2,a2,-1
  while(n > 0 && *src) {
 286:	fa65                	bnez	a2,276 <strncpy+0xc>
 288:	a809                	j	29a <strncpy+0x30>
  }
  while(n > 0) {
 28a:	1602                	sll	a2,a2,0x20
 28c:	9201                	srl	a2,a2,0x20
 28e:	963e                	add	a2,a2,a5
    *p++ = 0;
 290:	0785                	add	a5,a5,1
 292:	fe078fa3          	sb	zero,-1(a5)
  while(n > 0) {
 296:	fec79de3          	bne	a5,a2,290 <strncpy+0x26>
    n--;
  }
  return dst;
}
 29a:	6422                	ld	s0,8(sp)
 29c:	0141                	add	sp,sp,16
 29e:	8082                	ret

00000000000002a0 <strlen>:

uint
strlen(const char *s)
{
 2a0:	1141                	add	sp,sp,-16
 2a2:	e422                	sd	s0,8(sp)
 2a4:	0800                	add	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 2a6:	00054783          	lbu	a5,0(a0)
 2aa:	cf91                	beqz	a5,2c6 <strlen+0x26>
 2ac:	0505                	add	a0,a0,1
 2ae:	87aa                	mv	a5,a0
 2b0:	86be                	mv	a3,a5
 2b2:	0785                	add	a5,a5,1
 2b4:	fff7c703          	lbu	a4,-1(a5)
 2b8:	ff65                	bnez	a4,2b0 <strlen+0x10>
 2ba:	40a6853b          	subw	a0,a3,a0
 2be:	2505                	addw	a0,a0,1
    ;
  return n;
}
 2c0:	6422                	ld	s0,8(sp)
 2c2:	0141                	add	sp,sp,16
 2c4:	8082                	ret
  for(n = 0; s[n]; n++)
 2c6:	4501                	li	a0,0
 2c8:	bfe5                	j	2c0 <strlen+0x20>

00000000000002ca <memset>:

void*
memset(void *dst, int c, uint n)
{
 2ca:	1141                	add	sp,sp,-16
 2cc:	e422                	sd	s0,8(sp)
 2ce:	0800                	add	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 2d0:	ca19                	beqz	a2,2e6 <memset+0x1c>
 2d2:	87aa                	mv	a5,a0
 2d4:	1602                	sll	a2,a2,0x20
 2d6:	9201                	srl	a2,a2,0x20
 2d8:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 2dc:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 2e0:	0785                	add	a5,a5,1
 2e2:	fee79de3          	bne	a5,a4,2dc <memset+0x12>
  }
  return dst;
}
 2e6:	6422                	ld	s0,8(sp)
 2e8:	0141                	add	sp,sp,16
 2ea:	8082                	ret

00000000000002ec <strchr>:

char*
strchr(const char *s, char c)
{
 2ec:	1141                	add	sp,sp,-16
 2ee:	e422                	sd	s0,8(sp)
 2f0:	0800                	add	s0,sp,16
  for(; *s; s++)
 2f2:	00054783          	lbu	a5,0(a0)
 2f6:	cb99                	beqz	a5,30c <strchr+0x20>
    if(*s == c)
 2f8:	00f58763          	beq	a1,a5,306 <strchr+0x1a>
  for(; *s; s++)
 2fc:	0505                	add	a0,a0,1
 2fe:	00054783          	lbu	a5,0(a0)
 302:	fbfd                	bnez	a5,2f8 <strchr+0xc>
      return (char*)s;
  return 0;
 304:	4501                	li	a0,0
}
 306:	6422                	ld	s0,8(sp)
 308:	0141                	add	sp,sp,16
 30a:	8082                	ret
  return 0;
 30c:	4501                	li	a0,0
 30e:	bfe5                	j	306 <strchr+0x1a>

0000000000000310 <gets>:

char*
gets(char *buf, int max)
{
 310:	711d                	add	sp,sp,-96
 312:	ec86                	sd	ra,88(sp)
 314:	e8a2                	sd	s0,80(sp)
 316:	e4a6                	sd	s1,72(sp)
 318:	e0ca                	sd	s2,64(sp)
 31a:	fc4e                	sd	s3,56(sp)
 31c:	f852                	sd	s4,48(sp)
 31e:	f456                	sd	s5,40(sp)
 320:	f05a                	sd	s6,32(sp)
 322:	ec5e                	sd	s7,24(sp)
 324:	1080                	add	s0,sp,96
 326:	8baa                	mv	s7,a0
 328:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 32a:	892a                	mv	s2,a0
 32c:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 32e:	4aa9                	li	s5,10
 330:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 332:	89a6                	mv	s3,s1
 334:	2485                	addw	s1,s1,1
 336:	0344d663          	bge	s1,s4,362 <gets+0x52>
    cc = read(0, &c, 1);
 33a:	4605                	li	a2,1
 33c:	faf40593          	add	a1,s0,-81
 340:	4501                	li	a0,0
 342:	252000ef          	jal	594 <read>
    if(cc < 1)
 346:	00a05e63          	blez	a0,362 <gets+0x52>
    buf[i++] = c;
 34a:	faf44783          	lbu	a5,-81(s0)
 34e:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 352:	01578763          	beq	a5,s5,360 <gets+0x50>
 356:	0905                	add	s2,s2,1
 358:	fd679de3          	bne	a5,s6,332 <gets+0x22>
    buf[i++] = c;
 35c:	89a6                	mv	s3,s1
 35e:	a011                	j	362 <gets+0x52>
 360:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 362:	99de                	add	s3,s3,s7
 364:	00098023          	sb	zero,0(s3)
  return buf;
}
 368:	855e                	mv	a0,s7
 36a:	60e6                	ld	ra,88(sp)
 36c:	6446                	ld	s0,80(sp)
 36e:	64a6                	ld	s1,72(sp)
 370:	6906                	ld	s2,64(sp)
 372:	79e2                	ld	s3,56(sp)
 374:	7a42                	ld	s4,48(sp)
 376:	7aa2                	ld	s5,40(sp)
 378:	7b02                	ld	s6,32(sp)
 37a:	6be2                	ld	s7,24(sp)
 37c:	6125                	add	sp,sp,96
 37e:	8082                	ret

0000000000000380 <stat>:

int
stat(const char *n, struct stat *st)
{
 380:	1101                	add	sp,sp,-32
 382:	ec06                	sd	ra,24(sp)
 384:	e822                	sd	s0,16(sp)
 386:	e04a                	sd	s2,0(sp)
 388:	1000                	add	s0,sp,32
 38a:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 38c:	4581                	li	a1,0
 38e:	22e000ef          	jal	5bc <open>
  if(fd < 0)
 392:	02054263          	bltz	a0,3b6 <stat+0x36>
 396:	e426                	sd	s1,8(sp)
 398:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 39a:	85ca                	mv	a1,s2
 39c:	238000ef          	jal	5d4 <fstat>
 3a0:	892a                	mv	s2,a0
  close(fd);
 3a2:	8526                	mv	a0,s1
 3a4:	200000ef          	jal	5a4 <close>
  return r;
 3a8:	64a2                	ld	s1,8(sp)
}
 3aa:	854a                	mv	a0,s2
 3ac:	60e2                	ld	ra,24(sp)
 3ae:	6442                	ld	s0,16(sp)
 3b0:	6902                	ld	s2,0(sp)
 3b2:	6105                	add	sp,sp,32
 3b4:	8082                	ret
    return -1;
 3b6:	597d                	li	s2,-1
 3b8:	bfcd                	j	3aa <stat+0x2a>

00000000000003ba <atoi>:

int
atoi(const char *s)
{
 3ba:	1141                	add	sp,sp,-16
 3bc:	e422                	sd	s0,8(sp)
 3be:	0800                	add	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 3c0:	00054683          	lbu	a3,0(a0)
 3c4:	fd06879b          	addw	a5,a3,-48
 3c8:	0ff7f793          	zext.b	a5,a5
 3cc:	4625                	li	a2,9
 3ce:	02f66863          	bltu	a2,a5,3fe <atoi+0x44>
 3d2:	872a                	mv	a4,a0
  n = 0;
 3d4:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 3d6:	0705                	add	a4,a4,1
 3d8:	0025179b          	sllw	a5,a0,0x2
 3dc:	9fa9                	addw	a5,a5,a0
 3de:	0017979b          	sllw	a5,a5,0x1
 3e2:	9fb5                	addw	a5,a5,a3
 3e4:	fd07851b          	addw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 3e8:	00074683          	lbu	a3,0(a4)
 3ec:	fd06879b          	addw	a5,a3,-48
 3f0:	0ff7f793          	zext.b	a5,a5
 3f4:	fef671e3          	bgeu	a2,a5,3d6 <atoi+0x1c>
  return n;
}
 3f8:	6422                	ld	s0,8(sp)
 3fa:	0141                	add	sp,sp,16
 3fc:	8082                	ret
  n = 0;
 3fe:	4501                	li	a0,0
 400:	bfe5                	j	3f8 <atoi+0x3e>

0000000000000402 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 402:	1141                	add	sp,sp,-16
 404:	e422                	sd	s0,8(sp)
 406:	0800                	add	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 408:	02b57463          	bgeu	a0,a1,430 <memmove+0x2e>
    while(n-- > 0)
 40c:	00c05f63          	blez	a2,42a <memmove+0x28>
 410:	1602                	sll	a2,a2,0x20
 412:	9201                	srl	a2,a2,0x20
 414:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 418:	872a                	mv	a4,a0
      *dst++ = *src++;
 41a:	0585                	add	a1,a1,1
 41c:	0705                	add	a4,a4,1
 41e:	fff5c683          	lbu	a3,-1(a1)
 422:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 426:	fef71ae3          	bne	a4,a5,41a <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 42a:	6422                	ld	s0,8(sp)
 42c:	0141                	add	sp,sp,16
 42e:	8082                	ret
    dst += n;
 430:	00c50733          	add	a4,a0,a2
    src += n;
 434:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 436:	fec05ae3          	blez	a2,42a <memmove+0x28>
 43a:	fff6079b          	addw	a5,a2,-1
 43e:	1782                	sll	a5,a5,0x20
 440:	9381                	srl	a5,a5,0x20
 442:	fff7c793          	not	a5,a5
 446:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 448:	15fd                	add	a1,a1,-1
 44a:	177d                	add	a4,a4,-1
 44c:	0005c683          	lbu	a3,0(a1)
 450:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 454:	fee79ae3          	bne	a5,a4,448 <memmove+0x46>
 458:	bfc9                	j	42a <memmove+0x28>

000000000000045a <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 45a:	1141                	add	sp,sp,-16
 45c:	e422                	sd	s0,8(sp)
 45e:	0800                	add	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 460:	ca05                	beqz	a2,490 <memcmp+0x36>
 462:	fff6069b          	addw	a3,a2,-1
 466:	1682                	sll	a3,a3,0x20
 468:	9281                	srl	a3,a3,0x20
 46a:	0685                	add	a3,a3,1
 46c:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 46e:	00054783          	lbu	a5,0(a0)
 472:	0005c703          	lbu	a4,0(a1)
 476:	00e79863          	bne	a5,a4,486 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 47a:	0505                	add	a0,a0,1
    p2++;
 47c:	0585                	add	a1,a1,1
  while (n-- > 0) {
 47e:	fed518e3          	bne	a0,a3,46e <memcmp+0x14>
  }
  return 0;
 482:	4501                	li	a0,0
 484:	a019                	j	48a <memcmp+0x30>
      return *p1 - *p2;
 486:	40e7853b          	subw	a0,a5,a4
}
 48a:	6422                	ld	s0,8(sp)
 48c:	0141                	add	sp,sp,16
 48e:	8082                	ret
  return 0;
 490:	4501                	li	a0,0
 492:	bfe5                	j	48a <memcmp+0x30>

0000000000000494 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 494:	1141                	add	sp,sp,-16
 496:	e406                	sd	ra,8(sp)
 498:	e022                	sd	s0,0(sp)
 49a:	0800                	add	s0,sp,16
  return memmove(dst, src, n);
 49c:	f67ff0ef          	jal	402 <memmove>
}
 4a0:	60a2                	ld	ra,8(sp)
 4a2:	6402                	ld	s0,0(sp)
 4a4:	0141                	add	sp,sp,16
 4a6:	8082                	ret

00000000000004a8 <sbrk>:

char *
sbrk(int n) {
 4a8:	1141                	add	sp,sp,-16
 4aa:	e406                	sd	ra,8(sp)
 4ac:	e022                	sd	s0,0(sp)
 4ae:	0800                	add	s0,sp,16
  return sys_sbrk(n, SBRK_EAGER);
 4b0:	4585                	li	a1,1
 4b2:	152000ef          	jal	604 <sys_sbrk>
}
 4b6:	60a2                	ld	ra,8(sp)
 4b8:	6402                	ld	s0,0(sp)
 4ba:	0141                	add	sp,sp,16
 4bc:	8082                	ret

00000000000004be <sbrklazy>:

char *
sbrklazy(int n) {
 4be:	1141                	add	sp,sp,-16
 4c0:	e406                	sd	ra,8(sp)
 4c2:	e022                	sd	s0,0(sp)
 4c4:	0800                	add	s0,sp,16
  return sys_sbrk(n, SBRK_LAZY);
 4c6:	4589                	li	a1,2
 4c8:	13c000ef          	jal	604 <sys_sbrk>
}
 4cc:	60a2                	ld	ra,8(sp)
 4ce:	6402                	ld	s0,0(sp)
 4d0:	0141                	add	sp,sp,16
 4d2:	8082                	ret

00000000000004d4 <htons>:

// Byte order conversion functions
unsigned short
htons(unsigned short hostshort)
{
 4d4:	1141                	add	sp,sp,-16
 4d6:	e422                	sd	s0,8(sp)
 4d8:	0800                	add	s0,sp,16
  return ((hostshort >> 8) & 0xff) | ((hostshort & 0xff) << 8);
 4da:	0085179b          	sllw	a5,a0,0x8
 4de:	0085551b          	srlw	a0,a0,0x8
 4e2:	8d5d                	or	a0,a0,a5
}
 4e4:	1542                	sll	a0,a0,0x30
 4e6:	9141                	srl	a0,a0,0x30
 4e8:	6422                	ld	s0,8(sp)
 4ea:	0141                	add	sp,sp,16
 4ec:	8082                	ret

00000000000004ee <ntohs>:

unsigned short
ntohs(unsigned short netshort)
{
 4ee:	1141                	add	sp,sp,-16
 4f0:	e422                	sd	s0,8(sp)
 4f2:	0800                	add	s0,sp,16
  return ((netshort >> 8) & 0xff) | ((netshort & 0xff) << 8);
 4f4:	0085179b          	sllw	a5,a0,0x8
 4f8:	0085551b          	srlw	a0,a0,0x8
 4fc:	8d5d                	or	a0,a0,a5
}
 4fe:	1542                	sll	a0,a0,0x30
 500:	9141                	srl	a0,a0,0x30
 502:	6422                	ld	s0,8(sp)
 504:	0141                	add	sp,sp,16
 506:	8082                	ret

0000000000000508 <htonl>:

unsigned long
htonl(unsigned long hostlong)
{
 508:	1141                	add	sp,sp,-16
 50a:	e422                	sd	s0,8(sp)
 50c:	0800                	add	s0,sp,16
  return ((hostlong >> 24) & 0xff) |
 50e:	0185579b          	srlw	a5,a0,0x18
         ((hostlong >> 8) & 0xff00) |
 512:	00855713          	srl	a4,a0,0x8
 516:	66c1                	lui	a3,0x10
 518:	f0068693          	add	a3,a3,-256 # ff00 <base+0xeef0>
 51c:	8f75                	and	a4,a4,a3
  return ((hostlong >> 24) & 0xff) |
 51e:	8fd9                	or	a5,a5,a4
         ((hostlong & 0xff00) << 8) |
 520:	00851713          	sll	a4,a0,0x8
 524:	00ff06b7          	lui	a3,0xff0
 528:	8f75                	and	a4,a4,a3
         ((hostlong >> 8) & 0xff00) |
 52a:	8fd9                	or	a5,a5,a4
         ((hostlong & 0xff) << 24);
 52c:	0562                	sll	a0,a0,0x18
 52e:	0ff00713          	li	a4,255
 532:	0762                	sll	a4,a4,0x18
 534:	8d79                	and	a0,a0,a4
}
 536:	8d5d                	or	a0,a0,a5
 538:	6422                	ld	s0,8(sp)
 53a:	0141                	add	sp,sp,16
 53c:	8082                	ret

000000000000053e <ntohl>:

unsigned long
ntohl(unsigned long netlong)
{
 53e:	1141                	add	sp,sp,-16
 540:	e422                	sd	s0,8(sp)
 542:	0800                	add	s0,sp,16
  return ((netlong >> 24) & 0xff) |
 544:	0185579b          	srlw	a5,a0,0x18
         ((netlong >> 8) & 0xff00) |
 548:	00855713          	srl	a4,a0,0x8
 54c:	66c1                	lui	a3,0x10
 54e:	f0068693          	add	a3,a3,-256 # ff00 <base+0xeef0>
 552:	8f75                	and	a4,a4,a3
  return ((netlong >> 24) & 0xff) |
 554:	8fd9                	or	a5,a5,a4
         ((netlong & 0xff00) << 8) |
 556:	00851713          	sll	a4,a0,0x8
 55a:	00ff06b7          	lui	a3,0xff0
 55e:	8f75                	and	a4,a4,a3
         ((netlong >> 8) & 0xff00) |
 560:	8fd9                	or	a5,a5,a4
         ((netlong & 0xff) << 24);
 562:	0562                	sll	a0,a0,0x18
 564:	0ff00713          	li	a4,255
 568:	0762                	sll	a4,a4,0x18
 56a:	8d79                	and	a0,a0,a4
}
 56c:	8d5d                	or	a0,a0,a5
 56e:	6422                	ld	s0,8(sp)
 570:	0141                	add	sp,sp,16
 572:	8082                	ret

0000000000000574 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 574:	4885                	li	a7,1
 ecall
 576:	00000073          	ecall
 ret
 57a:	8082                	ret

000000000000057c <exit>:
.global exit
exit:
 li a7, SYS_exit
 57c:	4889                	li	a7,2
 ecall
 57e:	00000073          	ecall
 ret
 582:	8082                	ret

0000000000000584 <wait>:
.global wait
wait:
 li a7, SYS_wait
 584:	488d                	li	a7,3
 ecall
 586:	00000073          	ecall
 ret
 58a:	8082                	ret

000000000000058c <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 58c:	4891                	li	a7,4
 ecall
 58e:	00000073          	ecall
 ret
 592:	8082                	ret

0000000000000594 <read>:
.global read
read:
 li a7, SYS_read
 594:	4895                	li	a7,5
 ecall
 596:	00000073          	ecall
 ret
 59a:	8082                	ret

000000000000059c <write>:
.global write
write:
 li a7, SYS_write
 59c:	48c1                	li	a7,16
 ecall
 59e:	00000073          	ecall
 ret
 5a2:	8082                	ret

00000000000005a4 <close>:
.global close
close:
 li a7, SYS_close
 5a4:	48d5                	li	a7,21
 ecall
 5a6:	00000073          	ecall
 ret
 5aa:	8082                	ret

00000000000005ac <kill>:
.global kill
kill:
 li a7, SYS_kill
 5ac:	4899                	li	a7,6
 ecall
 5ae:	00000073          	ecall
 ret
 5b2:	8082                	ret

00000000000005b4 <exec>:
.global exec
exec:
 li a7, SYS_exec
 5b4:	489d                	li	a7,7
 ecall
 5b6:	00000073          	ecall
 ret
 5ba:	8082                	ret

00000000000005bc <open>:
.global open
open:
 li a7, SYS_open
 5bc:	48bd                	li	a7,15
 ecall
 5be:	00000073          	ecall
 ret
 5c2:	8082                	ret

00000000000005c4 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 5c4:	48c5                	li	a7,17
 ecall
 5c6:	00000073          	ecall
 ret
 5ca:	8082                	ret

00000000000005cc <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 5cc:	48c9                	li	a7,18
 ecall
 5ce:	00000073          	ecall
 ret
 5d2:	8082                	ret

00000000000005d4 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 5d4:	48a1                	li	a7,8
 ecall
 5d6:	00000073          	ecall
 ret
 5da:	8082                	ret

00000000000005dc <link>:
.global link
link:
 li a7, SYS_link
 5dc:	48cd                	li	a7,19
 ecall
 5de:	00000073          	ecall
 ret
 5e2:	8082                	ret

00000000000005e4 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 5e4:	48d1                	li	a7,20
 ecall
 5e6:	00000073          	ecall
 ret
 5ea:	8082                	ret

00000000000005ec <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 5ec:	48a5                	li	a7,9
 ecall
 5ee:	00000073          	ecall
 ret
 5f2:	8082                	ret

00000000000005f4 <dup>:
.global dup
dup:
 li a7, SYS_dup
 5f4:	48a9                	li	a7,10
 ecall
 5f6:	00000073          	ecall
 ret
 5fa:	8082                	ret

00000000000005fc <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 5fc:	48ad                	li	a7,11
 ecall
 5fe:	00000073          	ecall
 ret
 602:	8082                	ret

0000000000000604 <sys_sbrk>:
.global sys_sbrk
sys_sbrk:
 li a7, SYS_sbrk
 604:	48b1                	li	a7,12
 ecall
 606:	00000073          	ecall
 ret
 60a:	8082                	ret

000000000000060c <pause>:
.global pause
pause:
 li a7, SYS_pause
 60c:	48b5                	li	a7,13
 ecall
 60e:	00000073          	ecall
 ret
 612:	8082                	ret

0000000000000614 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 614:	48b9                	li	a7,14
 ecall
 616:	00000073          	ecall
 ret
 61a:	8082                	ret

000000000000061c <socket>:
.global socket
socket:
 li a7, SYS_socket
 61c:	48d9                	li	a7,22
 ecall
 61e:	00000073          	ecall
 ret
 622:	8082                	ret

0000000000000624 <bind>:
.global bind
bind:
 li a7, SYS_bind
 624:	48dd                	li	a7,23
 ecall
 626:	00000073          	ecall
 ret
 62a:	8082                	ret

000000000000062c <listen>:
.global listen
listen:
 li a7, SYS_listen
 62c:	48e1                	li	a7,24
 ecall
 62e:	00000073          	ecall
 ret
 632:	8082                	ret

0000000000000634 <accept>:
.global accept
accept:
 li a7, SYS_accept
 634:	48e5                	li	a7,25
 ecall
 636:	00000073          	ecall
 ret
 63a:	8082                	ret

000000000000063c <connect>:
.global connect
connect:
 li a7, SYS_connect
 63c:	48e9                	li	a7,26
 ecall
 63e:	00000073          	ecall
 ret
 642:	8082                	ret

0000000000000644 <send>:
.global send
send:
 li a7, SYS_send
 644:	48ed                	li	a7,27
 ecall
 646:	00000073          	ecall
 ret
 64a:	8082                	ret

000000000000064c <recv>:
.global recv
recv:
 li a7, SYS_recv
 64c:	48f1                	li	a7,28
 ecall
 64e:	00000073          	ecall
 ret
 652:	8082                	ret

0000000000000654 <sendto>:
.global sendto
sendto:
 li a7, SYS_sendto
 654:	48f5                	li	a7,29
 ecall
 656:	00000073          	ecall
 ret
 65a:	8082                	ret

000000000000065c <recvfrom>:
.global recvfrom
recvfrom:
 li a7, SYS_recvfrom
 65c:	48f9                	li	a7,30
 ecall
 65e:	00000073          	ecall
 ret
 662:	8082                	ret

0000000000000664 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 664:	1101                	add	sp,sp,-32
 666:	ec06                	sd	ra,24(sp)
 668:	e822                	sd	s0,16(sp)
 66a:	1000                	add	s0,sp,32
 66c:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 670:	4605                	li	a2,1
 672:	fef40593          	add	a1,s0,-17
 676:	f27ff0ef          	jal	59c <write>
}
 67a:	60e2                	ld	ra,24(sp)
 67c:	6442                	ld	s0,16(sp)
 67e:	6105                	add	sp,sp,32
 680:	8082                	ret

0000000000000682 <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
 682:	715d                	add	sp,sp,-80
 684:	e486                	sd	ra,72(sp)
 686:	e0a2                	sd	s0,64(sp)
 688:	f84a                	sd	s2,48(sp)
 68a:	0880                	add	s0,sp,80
 68c:	892a                	mv	s2,a0
  char buf[20];
  int i, neg;
  unsigned long long x;

  neg = 0;
  if(sgn && xx < 0){
 68e:	c299                	beqz	a3,694 <printint+0x12>
 690:	0805c363          	bltz	a1,716 <printint+0x94>
  neg = 0;
 694:	4881                	li	a7,0
 696:	fb840693          	add	a3,s0,-72
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
 69a:	4781                	li	a5,0
  do{
    buf[i++] = digits[x % base];
 69c:	00000517          	auipc	a0,0x0
 6a0:	62450513          	add	a0,a0,1572 # cc0 <digits>
 6a4:	883e                	mv	a6,a5
 6a6:	2785                	addw	a5,a5,1
 6a8:	02c5f733          	remu	a4,a1,a2
 6ac:	972a                	add	a4,a4,a0
 6ae:	00074703          	lbu	a4,0(a4)
 6b2:	00e68023          	sb	a4,0(a3) # ff0000 <base+0xfeeff0>
  }while((x /= base) != 0);
 6b6:	872e                	mv	a4,a1
 6b8:	02c5d5b3          	divu	a1,a1,a2
 6bc:	0685                	add	a3,a3,1
 6be:	fec773e3          	bgeu	a4,a2,6a4 <printint+0x22>
  if(neg)
 6c2:	00088b63          	beqz	a7,6d8 <printint+0x56>
    buf[i++] = '-';
 6c6:	fd078793          	add	a5,a5,-48
 6ca:	97a2                	add	a5,a5,s0
 6cc:	02d00713          	li	a4,45
 6d0:	fee78423          	sb	a4,-24(a5)
 6d4:	0028079b          	addw	a5,a6,2

  while(--i >= 0)
 6d8:	02f05a63          	blez	a5,70c <printint+0x8a>
 6dc:	fc26                	sd	s1,56(sp)
 6de:	f44e                	sd	s3,40(sp)
 6e0:	fb840713          	add	a4,s0,-72
 6e4:	00f704b3          	add	s1,a4,a5
 6e8:	fff70993          	add	s3,a4,-1
 6ec:	99be                	add	s3,s3,a5
 6ee:	37fd                	addw	a5,a5,-1
 6f0:	1782                	sll	a5,a5,0x20
 6f2:	9381                	srl	a5,a5,0x20
 6f4:	40f989b3          	sub	s3,s3,a5
    putc(fd, buf[i]);
 6f8:	fff4c583          	lbu	a1,-1(s1)
 6fc:	854a                	mv	a0,s2
 6fe:	f67ff0ef          	jal	664 <putc>
  while(--i >= 0)
 702:	14fd                	add	s1,s1,-1
 704:	ff349ae3          	bne	s1,s3,6f8 <printint+0x76>
 708:	74e2                	ld	s1,56(sp)
 70a:	79a2                	ld	s3,40(sp)
}
 70c:	60a6                	ld	ra,72(sp)
 70e:	6406                	ld	s0,64(sp)
 710:	7942                	ld	s2,48(sp)
 712:	6161                	add	sp,sp,80
 714:	8082                	ret
    x = -xx;
 716:	40b005b3          	neg	a1,a1
    neg = 1;
 71a:	4885                	li	a7,1
    x = -xx;
 71c:	bfad                	j	696 <printint+0x14>

000000000000071e <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %c, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 71e:	711d                	add	sp,sp,-96
 720:	ec86                	sd	ra,88(sp)
 722:	e8a2                	sd	s0,80(sp)
 724:	e0ca                	sd	s2,64(sp)
 726:	1080                	add	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 728:	0005c903          	lbu	s2,0(a1)
 72c:	28090663          	beqz	s2,9b8 <vprintf+0x29a>
 730:	e4a6                	sd	s1,72(sp)
 732:	fc4e                	sd	s3,56(sp)
 734:	f852                	sd	s4,48(sp)
 736:	f456                	sd	s5,40(sp)
 738:	f05a                	sd	s6,32(sp)
 73a:	ec5e                	sd	s7,24(sp)
 73c:	e862                	sd	s8,16(sp)
 73e:	e466                	sd	s9,8(sp)
 740:	8b2a                	mv	s6,a0
 742:	8a2e                	mv	s4,a1
 744:	8bb2                	mv	s7,a2
  state = 0;
 746:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
 748:	4481                	li	s1,0
 74a:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
 74c:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
 750:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
 754:	06c00c93          	li	s9,108
 758:	a005                	j	778 <vprintf+0x5a>
        putc(fd, c0);
 75a:	85ca                	mv	a1,s2
 75c:	855a                	mv	a0,s6
 75e:	f07ff0ef          	jal	664 <putc>
 762:	a019                	j	768 <vprintf+0x4a>
    } else if(state == '%'){
 764:	03598263          	beq	s3,s5,788 <vprintf+0x6a>
  for(i = 0; fmt[i]; i++){
 768:	2485                	addw	s1,s1,1
 76a:	8726                	mv	a4,s1
 76c:	009a07b3          	add	a5,s4,s1
 770:	0007c903          	lbu	s2,0(a5)
 774:	22090a63          	beqz	s2,9a8 <vprintf+0x28a>
    c0 = fmt[i] & 0xff;
 778:	0009079b          	sext.w	a5,s2
    if(state == 0){
 77c:	fe0994e3          	bnez	s3,764 <vprintf+0x46>
      if(c0 == '%'){
 780:	fd579de3          	bne	a5,s5,75a <vprintf+0x3c>
        state = '%';
 784:	89be                	mv	s3,a5
 786:	b7cd                	j	768 <vprintf+0x4a>
      if(c0) c1 = fmt[i+1] & 0xff;
 788:	00ea06b3          	add	a3,s4,a4
 78c:	0016c683          	lbu	a3,1(a3)
      c1 = c2 = 0;
 790:	8636                	mv	a2,a3
      if(c1) c2 = fmt[i+2] & 0xff;
 792:	c681                	beqz	a3,79a <vprintf+0x7c>
 794:	9752                	add	a4,a4,s4
 796:	00274603          	lbu	a2,2(a4)
      if(c0 == 'd'){
 79a:	05878363          	beq	a5,s8,7e0 <vprintf+0xc2>
      } else if(c0 == 'l' && c1 == 'd'){
 79e:	05978d63          	beq	a5,s9,7f8 <vprintf+0xda>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
 7a2:	07500713          	li	a4,117
 7a6:	0ee78763          	beq	a5,a4,894 <vprintf+0x176>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
 7aa:	07800713          	li	a4,120
 7ae:	12e78963          	beq	a5,a4,8e0 <vprintf+0x1c2>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
 7b2:	07000713          	li	a4,112
 7b6:	14e78e63          	beq	a5,a4,912 <vprintf+0x1f4>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 'c'){
 7ba:	06300713          	li	a4,99
 7be:	18e78e63          	beq	a5,a4,95a <vprintf+0x23c>
        putc(fd, va_arg(ap, uint32));
      } else if(c0 == 's'){
 7c2:	07300713          	li	a4,115
 7c6:	1ae78463          	beq	a5,a4,96e <vprintf+0x250>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
 7ca:	02500713          	li	a4,37
 7ce:	04e79563          	bne	a5,a4,818 <vprintf+0xfa>
        putc(fd, '%');
 7d2:	02500593          	li	a1,37
 7d6:	855a                	mv	a0,s6
 7d8:	e8dff0ef          	jal	664 <putc>
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c0);
      }

      state = 0;
 7dc:	4981                	li	s3,0
 7de:	b769                	j	768 <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 1);
 7e0:	008b8913          	add	s2,s7,8
 7e4:	4685                	li	a3,1
 7e6:	4629                	li	a2,10
 7e8:	000ba583          	lw	a1,0(s7)
 7ec:	855a                	mv	a0,s6
 7ee:	e95ff0ef          	jal	682 <printint>
 7f2:	8bca                	mv	s7,s2
      state = 0;
 7f4:	4981                	li	s3,0
 7f6:	bf8d                	j	768 <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'd'){
 7f8:	06400793          	li	a5,100
 7fc:	02f68963          	beq	a3,a5,82e <vprintf+0x110>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 800:	06c00793          	li	a5,108
 804:	04f68263          	beq	a3,a5,848 <vprintf+0x12a>
      } else if(c0 == 'l' && c1 == 'u'){
 808:	07500793          	li	a5,117
 80c:	0af68063          	beq	a3,a5,8ac <vprintf+0x18e>
      } else if(c0 == 'l' && c1 == 'x'){
 810:	07800793          	li	a5,120
 814:	0ef68263          	beq	a3,a5,8f8 <vprintf+0x1da>
        putc(fd, '%');
 818:	02500593          	li	a1,37
 81c:	855a                	mv	a0,s6
 81e:	e47ff0ef          	jal	664 <putc>
        putc(fd, c0);
 822:	85ca                	mv	a1,s2
 824:	855a                	mv	a0,s6
 826:	e3fff0ef          	jal	664 <putc>
      state = 0;
 82a:	4981                	li	s3,0
 82c:	bf35                	j	768 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 82e:	008b8913          	add	s2,s7,8
 832:	4685                	li	a3,1
 834:	4629                	li	a2,10
 836:	000bb583          	ld	a1,0(s7)
 83a:	855a                	mv	a0,s6
 83c:	e47ff0ef          	jal	682 <printint>
        i += 1;
 840:	2485                	addw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 842:	8bca                	mv	s7,s2
      state = 0;
 844:	4981                	li	s3,0
        i += 1;
 846:	b70d                	j	768 <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 848:	06400793          	li	a5,100
 84c:	02f60763          	beq	a2,a5,87a <vprintf+0x15c>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 850:	07500793          	li	a5,117
 854:	06f60963          	beq	a2,a5,8c6 <vprintf+0x1a8>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 858:	07800793          	li	a5,120
 85c:	faf61ee3          	bne	a2,a5,818 <vprintf+0xfa>
        printint(fd, va_arg(ap, uint64), 16, 0);
 860:	008b8913          	add	s2,s7,8
 864:	4681                	li	a3,0
 866:	4641                	li	a2,16
 868:	000bb583          	ld	a1,0(s7)
 86c:	855a                	mv	a0,s6
 86e:	e15ff0ef          	jal	682 <printint>
        i += 2;
 872:	2489                	addw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 874:	8bca                	mv	s7,s2
      state = 0;
 876:	4981                	li	s3,0
        i += 2;
 878:	bdc5                	j	768 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 87a:	008b8913          	add	s2,s7,8
 87e:	4685                	li	a3,1
 880:	4629                	li	a2,10
 882:	000bb583          	ld	a1,0(s7)
 886:	855a                	mv	a0,s6
 888:	dfbff0ef          	jal	682 <printint>
        i += 2;
 88c:	2489                	addw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 88e:	8bca                	mv	s7,s2
      state = 0;
 890:	4981                	li	s3,0
        i += 2;
 892:	bdd9                	j	768 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint32), 10, 0);
 894:	008b8913          	add	s2,s7,8
 898:	4681                	li	a3,0
 89a:	4629                	li	a2,10
 89c:	000be583          	lwu	a1,0(s7)
 8a0:	855a                	mv	a0,s6
 8a2:	de1ff0ef          	jal	682 <printint>
 8a6:	8bca                	mv	s7,s2
      state = 0;
 8a8:	4981                	li	s3,0
 8aa:	bd7d                	j	768 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 8ac:	008b8913          	add	s2,s7,8
 8b0:	4681                	li	a3,0
 8b2:	4629                	li	a2,10
 8b4:	000bb583          	ld	a1,0(s7)
 8b8:	855a                	mv	a0,s6
 8ba:	dc9ff0ef          	jal	682 <printint>
        i += 1;
 8be:	2485                	addw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 8c0:	8bca                	mv	s7,s2
      state = 0;
 8c2:	4981                	li	s3,0
        i += 1;
 8c4:	b555                	j	768 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 8c6:	008b8913          	add	s2,s7,8
 8ca:	4681                	li	a3,0
 8cc:	4629                	li	a2,10
 8ce:	000bb583          	ld	a1,0(s7)
 8d2:	855a                	mv	a0,s6
 8d4:	dafff0ef          	jal	682 <printint>
        i += 2;
 8d8:	2489                	addw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 8da:	8bca                	mv	s7,s2
      state = 0;
 8dc:	4981                	li	s3,0
        i += 2;
 8de:	b569                	j	768 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint32), 16, 0);
 8e0:	008b8913          	add	s2,s7,8
 8e4:	4681                	li	a3,0
 8e6:	4641                	li	a2,16
 8e8:	000be583          	lwu	a1,0(s7)
 8ec:	855a                	mv	a0,s6
 8ee:	d95ff0ef          	jal	682 <printint>
 8f2:	8bca                	mv	s7,s2
      state = 0;
 8f4:	4981                	li	s3,0
 8f6:	bd8d                	j	768 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 16, 0);
 8f8:	008b8913          	add	s2,s7,8
 8fc:	4681                	li	a3,0
 8fe:	4641                	li	a2,16
 900:	000bb583          	ld	a1,0(s7)
 904:	855a                	mv	a0,s6
 906:	d7dff0ef          	jal	682 <printint>
        i += 1;
 90a:	2485                	addw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 90c:	8bca                	mv	s7,s2
      state = 0;
 90e:	4981                	li	s3,0
        i += 1;
 910:	bda1                	j	768 <vprintf+0x4a>
 912:	e06a                	sd	s10,0(sp)
        printptr(fd, va_arg(ap, uint64));
 914:	008b8d13          	add	s10,s7,8
 918:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 91c:	03000593          	li	a1,48
 920:	855a                	mv	a0,s6
 922:	d43ff0ef          	jal	664 <putc>
  putc(fd, 'x');
 926:	07800593          	li	a1,120
 92a:	855a                	mv	a0,s6
 92c:	d39ff0ef          	jal	664 <putc>
 930:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 932:	00000b97          	auipc	s7,0x0
 936:	38eb8b93          	add	s7,s7,910 # cc0 <digits>
 93a:	03c9d793          	srl	a5,s3,0x3c
 93e:	97de                	add	a5,a5,s7
 940:	0007c583          	lbu	a1,0(a5)
 944:	855a                	mv	a0,s6
 946:	d1fff0ef          	jal	664 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 94a:	0992                	sll	s3,s3,0x4
 94c:	397d                	addw	s2,s2,-1
 94e:	fe0916e3          	bnez	s2,93a <vprintf+0x21c>
        printptr(fd, va_arg(ap, uint64));
 952:	8bea                	mv	s7,s10
      state = 0;
 954:	4981                	li	s3,0
 956:	6d02                	ld	s10,0(sp)
 958:	bd01                	j	768 <vprintf+0x4a>
        putc(fd, va_arg(ap, uint32));
 95a:	008b8913          	add	s2,s7,8
 95e:	000bc583          	lbu	a1,0(s7)
 962:	855a                	mv	a0,s6
 964:	d01ff0ef          	jal	664 <putc>
 968:	8bca                	mv	s7,s2
      state = 0;
 96a:	4981                	li	s3,0
 96c:	bbf5                	j	768 <vprintf+0x4a>
        if((s = va_arg(ap, char*)) == 0)
 96e:	008b8993          	add	s3,s7,8
 972:	000bb903          	ld	s2,0(s7)
 976:	00090f63          	beqz	s2,994 <vprintf+0x276>
        for(; *s; s++)
 97a:	00094583          	lbu	a1,0(s2)
 97e:	c195                	beqz	a1,9a2 <vprintf+0x284>
          putc(fd, *s);
 980:	855a                	mv	a0,s6
 982:	ce3ff0ef          	jal	664 <putc>
        for(; *s; s++)
 986:	0905                	add	s2,s2,1
 988:	00094583          	lbu	a1,0(s2)
 98c:	f9f5                	bnez	a1,980 <vprintf+0x262>
        if((s = va_arg(ap, char*)) == 0)
 98e:	8bce                	mv	s7,s3
      state = 0;
 990:	4981                	li	s3,0
 992:	bbd9                	j	768 <vprintf+0x4a>
          s = "(null)";
 994:	00000917          	auipc	s2,0x0
 998:	32490913          	add	s2,s2,804 # cb8 <malloc+0x218>
        for(; *s; s++)
 99c:	02800593          	li	a1,40
 9a0:	b7c5                	j	980 <vprintf+0x262>
        if((s = va_arg(ap, char*)) == 0)
 9a2:	8bce                	mv	s7,s3
      state = 0;
 9a4:	4981                	li	s3,0
 9a6:	b3c9                	j	768 <vprintf+0x4a>
 9a8:	64a6                	ld	s1,72(sp)
 9aa:	79e2                	ld	s3,56(sp)
 9ac:	7a42                	ld	s4,48(sp)
 9ae:	7aa2                	ld	s5,40(sp)
 9b0:	7b02                	ld	s6,32(sp)
 9b2:	6be2                	ld	s7,24(sp)
 9b4:	6c42                	ld	s8,16(sp)
 9b6:	6ca2                	ld	s9,8(sp)
    }
  }
}
 9b8:	60e6                	ld	ra,88(sp)
 9ba:	6446                	ld	s0,80(sp)
 9bc:	6906                	ld	s2,64(sp)
 9be:	6125                	add	sp,sp,96
 9c0:	8082                	ret

00000000000009c2 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 9c2:	715d                	add	sp,sp,-80
 9c4:	ec06                	sd	ra,24(sp)
 9c6:	e822                	sd	s0,16(sp)
 9c8:	1000                	add	s0,sp,32
 9ca:	e010                	sd	a2,0(s0)
 9cc:	e414                	sd	a3,8(s0)
 9ce:	e818                	sd	a4,16(s0)
 9d0:	ec1c                	sd	a5,24(s0)
 9d2:	03043023          	sd	a6,32(s0)
 9d6:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 9da:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 9de:	8622                	mv	a2,s0
 9e0:	d3fff0ef          	jal	71e <vprintf>
}
 9e4:	60e2                	ld	ra,24(sp)
 9e6:	6442                	ld	s0,16(sp)
 9e8:	6161                	add	sp,sp,80
 9ea:	8082                	ret

00000000000009ec <printf>:

void
printf(const char *fmt, ...)
{
 9ec:	711d                	add	sp,sp,-96
 9ee:	ec06                	sd	ra,24(sp)
 9f0:	e822                	sd	s0,16(sp)
 9f2:	1000                	add	s0,sp,32
 9f4:	e40c                	sd	a1,8(s0)
 9f6:	e810                	sd	a2,16(s0)
 9f8:	ec14                	sd	a3,24(s0)
 9fa:	f018                	sd	a4,32(s0)
 9fc:	f41c                	sd	a5,40(s0)
 9fe:	03043823          	sd	a6,48(s0)
 a02:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 a06:	00840613          	add	a2,s0,8
 a0a:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 a0e:	85aa                	mv	a1,a0
 a10:	4505                	li	a0,1
 a12:	d0dff0ef          	jal	71e <vprintf>
}
 a16:	60e2                	ld	ra,24(sp)
 a18:	6442                	ld	s0,16(sp)
 a1a:	6125                	add	sp,sp,96
 a1c:	8082                	ret

0000000000000a1e <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 a1e:	1141                	add	sp,sp,-16
 a20:	e422                	sd	s0,8(sp)
 a22:	0800                	add	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 a24:	ff050693          	add	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 a28:	00000797          	auipc	a5,0x0
 a2c:	5d87b783          	ld	a5,1496(a5) # 1000 <freep>
 a30:	a02d                	j	a5a <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 a32:	4618                	lw	a4,8(a2)
 a34:	9f2d                	addw	a4,a4,a1
 a36:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 a3a:	6398                	ld	a4,0(a5)
 a3c:	6310                	ld	a2,0(a4)
 a3e:	a83d                	j	a7c <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 a40:	ff852703          	lw	a4,-8(a0)
 a44:	9f31                	addw	a4,a4,a2
 a46:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 a48:	ff053683          	ld	a3,-16(a0)
 a4c:	a091                	j	a90 <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 a4e:	6398                	ld	a4,0(a5)
 a50:	00e7e463          	bltu	a5,a4,a58 <free+0x3a>
 a54:	00e6ea63          	bltu	a3,a4,a68 <free+0x4a>
{
 a58:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 a5a:	fed7fae3          	bgeu	a5,a3,a4e <free+0x30>
 a5e:	6398                	ld	a4,0(a5)
 a60:	00e6e463          	bltu	a3,a4,a68 <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 a64:	fee7eae3          	bltu	a5,a4,a58 <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 a68:	ff852583          	lw	a1,-8(a0)
 a6c:	6390                	ld	a2,0(a5)
 a6e:	02059813          	sll	a6,a1,0x20
 a72:	01c85713          	srl	a4,a6,0x1c
 a76:	9736                	add	a4,a4,a3
 a78:	fae60de3          	beq	a2,a4,a32 <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 a7c:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 a80:	4790                	lw	a2,8(a5)
 a82:	02061593          	sll	a1,a2,0x20
 a86:	01c5d713          	srl	a4,a1,0x1c
 a8a:	973e                	add	a4,a4,a5
 a8c:	fae68ae3          	beq	a3,a4,a40 <free+0x22>
    p->s.ptr = bp->s.ptr;
 a90:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 a92:	00000717          	auipc	a4,0x0
 a96:	56f73723          	sd	a5,1390(a4) # 1000 <freep>
}
 a9a:	6422                	ld	s0,8(sp)
 a9c:	0141                	add	sp,sp,16
 a9e:	8082                	ret

0000000000000aa0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 aa0:	7139                	add	sp,sp,-64
 aa2:	fc06                	sd	ra,56(sp)
 aa4:	f822                	sd	s0,48(sp)
 aa6:	f426                	sd	s1,40(sp)
 aa8:	ec4e                	sd	s3,24(sp)
 aaa:	0080                	add	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 aac:	02051493          	sll	s1,a0,0x20
 ab0:	9081                	srl	s1,s1,0x20
 ab2:	04bd                	add	s1,s1,15
 ab4:	8091                	srl	s1,s1,0x4
 ab6:	0014899b          	addw	s3,s1,1
 aba:	0485                	add	s1,s1,1
  if((prevp = freep) == 0){
 abc:	00000517          	auipc	a0,0x0
 ac0:	54453503          	ld	a0,1348(a0) # 1000 <freep>
 ac4:	c915                	beqz	a0,af8 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 ac6:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 ac8:	4798                	lw	a4,8(a5)
 aca:	08977a63          	bgeu	a4,s1,b5e <malloc+0xbe>
 ace:	f04a                	sd	s2,32(sp)
 ad0:	e852                	sd	s4,16(sp)
 ad2:	e456                	sd	s5,8(sp)
 ad4:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 ad6:	8a4e                	mv	s4,s3
 ad8:	0009871b          	sext.w	a4,s3
 adc:	6685                	lui	a3,0x1
 ade:	00d77363          	bgeu	a4,a3,ae4 <malloc+0x44>
 ae2:	6a05                	lui	s4,0x1
 ae4:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 ae8:	004a1a1b          	sllw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 aec:	00000917          	auipc	s2,0x0
 af0:	51490913          	add	s2,s2,1300 # 1000 <freep>
  if(p == SBRK_ERROR)
 af4:	5afd                	li	s5,-1
 af6:	a081                	j	b36 <malloc+0x96>
 af8:	f04a                	sd	s2,32(sp)
 afa:	e852                	sd	s4,16(sp)
 afc:	e456                	sd	s5,8(sp)
 afe:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 b00:	00000797          	auipc	a5,0x0
 b04:	51078793          	add	a5,a5,1296 # 1010 <base>
 b08:	00000717          	auipc	a4,0x0
 b0c:	4ef73c23          	sd	a5,1272(a4) # 1000 <freep>
 b10:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 b12:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 b16:	b7c1                	j	ad6 <malloc+0x36>
        prevp->s.ptr = p->s.ptr;
 b18:	6398                	ld	a4,0(a5)
 b1a:	e118                	sd	a4,0(a0)
 b1c:	a8a9                	j	b76 <malloc+0xd6>
  hp->s.size = nu;
 b1e:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 b22:	0541                	add	a0,a0,16
 b24:	efbff0ef          	jal	a1e <free>
  return freep;
 b28:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 b2c:	c12d                	beqz	a0,b8e <malloc+0xee>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 b2e:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 b30:	4798                	lw	a4,8(a5)
 b32:	02977263          	bgeu	a4,s1,b56 <malloc+0xb6>
    if(p == freep)
 b36:	00093703          	ld	a4,0(s2)
 b3a:	853e                	mv	a0,a5
 b3c:	fef719e3          	bne	a4,a5,b2e <malloc+0x8e>
  p = sbrk(nu * sizeof(Header));
 b40:	8552                	mv	a0,s4
 b42:	967ff0ef          	jal	4a8 <sbrk>
  if(p == SBRK_ERROR)
 b46:	fd551ce3          	bne	a0,s5,b1e <malloc+0x7e>
        return 0;
 b4a:	4501                	li	a0,0
 b4c:	7902                	ld	s2,32(sp)
 b4e:	6a42                	ld	s4,16(sp)
 b50:	6aa2                	ld	s5,8(sp)
 b52:	6b02                	ld	s6,0(sp)
 b54:	a03d                	j	b82 <malloc+0xe2>
 b56:	7902                	ld	s2,32(sp)
 b58:	6a42                	ld	s4,16(sp)
 b5a:	6aa2                	ld	s5,8(sp)
 b5c:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 b5e:	fae48de3          	beq	s1,a4,b18 <malloc+0x78>
        p->s.size -= nunits;
 b62:	4137073b          	subw	a4,a4,s3
 b66:	c798                	sw	a4,8(a5)
        p += p->s.size;
 b68:	02071693          	sll	a3,a4,0x20
 b6c:	01c6d713          	srl	a4,a3,0x1c
 b70:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 b72:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 b76:	00000717          	auipc	a4,0x0
 b7a:	48a73523          	sd	a0,1162(a4) # 1000 <freep>
      return (void*)(p + 1);
 b7e:	01078513          	add	a0,a5,16
  }
}
 b82:	70e2                	ld	ra,56(sp)
 b84:	7442                	ld	s0,48(sp)
 b86:	74a2                	ld	s1,40(sp)
 b88:	69e2                	ld	s3,24(sp)
 b8a:	6121                	add	sp,sp,64
 b8c:	8082                	ret
 b8e:	7902                	ld	s2,32(sp)
 b90:	6a42                	ld	s4,16(sp)
 b92:	6aa2                	ld	s5,8(sp)
 b94:	6b02                	ld	s6,0(sp)
 b96:	b7f5                	j	b82 <malloc+0xe2>
