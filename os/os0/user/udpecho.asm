
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
  1a:	1100                	add	s0,sp,160
  1c:	81010113          	add	sp,sp,-2032
    int soc, peerlen, ret;
    struct sockaddr_in self, peer;
    unsigned char *addr;
    char buf[2048];

    printf("Starting UDP Echo Server\n");
  20:	00001517          	auipc	a0,0x1
  24:	b8050513          	add	a0,a0,-1152 # ba0 <malloc+0xfa>
  28:	1cb000ef          	jal	9f2 <printf>
    soc = socket(PF_INET, SOCK_DGRAM, IPPROTO_UDP);
  2c:	4601                	li	a2,0
  2e:	4585                	li	a1,1
  30:	4505                	li	a0,1
  32:	5f0000ef          	jal	622 <socket>
    if (soc == -1) {
  36:	57fd                	li	a5,-1
  38:	08f50f63          	beq	a0,a5,d6 <main+0xd6>
  3c:	892a                	mv	s2,a0
        printf("socket: failure\n");
        exit(1);
    }
    printf("socket: success, soc=%d\n", soc);
  3e:	85aa                	mv	a1,a0
  40:	00001517          	auipc	a0,0x1
  44:	b9850513          	add	a0,a0,-1128 # bd8 <malloc+0x132>
  48:	1ab000ef          	jal	9f2 <printf>
    self.sin_family = AF_INET;
  4c:	4785                	li	a5,1
  4e:	f8f41823          	sh	a5,-112(s0)
    self.sin_addr.s_addr = INADDR_ANY;
  52:	f8042a23          	sw	zero,-108(s0)
    self.sin_port = htons(7);
  56:	451d                	li	a0,7
  58:	482000ef          	jal	4da <htons>
  5c:	f8a41923          	sh	a0,-110(s0)
    if (bind(soc, (struct sockaddr *)&self, sizeof(self)) == -1) {
  60:	4621                	li	a2,8
  62:	f9040593          	add	a1,s0,-112
  66:	854a                	mv	a0,s2
  68:	5c2000ef          	jal	62a <bind>
  6c:	57fd                	li	a5,-1
  6e:	06f50d63          	beq	a0,a5,e8 <main+0xe8>
        printf("bind: failure\n");
        close(soc);
        exit(1);
    }
    addr = (unsigned char *)&self.sin_addr.s_addr;
    printf("bind: success, self=%d.%d.%d.%d:%d\n",
  72:	f9444483          	lbu	s1,-108(s0)
  76:	f9544983          	lbu	s3,-107(s0)
  7a:	f9644a03          	lbu	s4,-106(s0)
  7e:	f9744a83          	lbu	s5,-105(s0)
        addr[0], addr[1], addr[2], addr[3], ntohs(self.sin_port));
  82:	f9245503          	lhu	a0,-110(s0)
  86:	46e000ef          	jal	4f4 <ntohs>
    printf("bind: success, self=%d.%d.%d.%d:%d\n",
  8a:	0005079b          	sext.w	a5,a0
  8e:	8756                	mv	a4,s5
  90:	86d2                	mv	a3,s4
  92:	864e                	mv	a2,s3
  94:	85a6                	mv	a1,s1
  96:	00001517          	auipc	a0,0x1
  9a:	b7250513          	add	a0,a0,-1166 # c08 <malloc+0x162>
  9e:	155000ef          	jal	9f2 <printf>
    printf("waiting for message...\n");
  a2:	00001517          	auipc	a0,0x1
  a6:	b8e50513          	add	a0,a0,-1138 # c30 <malloc+0x18a>
  aa:	149000ef          	jal	9f2 <printf>
    while (1) {
        peerlen = sizeof(peer);
  ae:	4c21                	li	s8,8
        ret = recvfrom(soc, buf, sizeof(buf), 0, (struct sockaddr *)&peer, &peerlen);
  b0:	77fd                	lui	a5,0xfffff
  b2:	78878793          	add	a5,a5,1928 # fffffffffffff788 <base+0xffffffffffffe778>
  b6:	97a2                	add	a5,a5,s0
  b8:	777d                	lui	a4,0xfffff
  ba:	77870713          	add	a4,a4,1912 # fffffffffffff778 <base+0xffffffffffffe768>
  be:	9722                	add	a4,a4,s0
  c0:	e31c                	sd	a5,0(a4)
  c2:	6b85                	lui	s7,0x1
  c4:	800b8b93          	add	s7,s7,-2048 # 800 <vprintf+0xdc>
        if (ret <= 0) {
            printf("EOF\n");
            break;
        }
        if (ret == 2 && buf[0] == '.' && buf[1] == '\n') {
  c8:	4c89                	li	s9,2
  ca:	7d7d                	lui	s10,0xfffff
  cc:	fa0d0793          	add	a5,s10,-96 # ffffffffffffefa0 <base+0xffffffffffffdf90>
  d0:	00878d33          	add	s10,a5,s0
  d4:	a849                	j	166 <main+0x166>
        printf("socket: failure\n");
  d6:	00001517          	auipc	a0,0x1
  da:	aea50513          	add	a0,a0,-1302 # bc0 <malloc+0x11a>
  de:	115000ef          	jal	9f2 <printf>
        exit(1);
  e2:	4505                	li	a0,1
  e4:	49e000ef          	jal	582 <exit>
        printf("bind: failure\n");
  e8:	00001517          	auipc	a0,0x1
  ec:	b1050513          	add	a0,a0,-1264 # bf8 <malloc+0x152>
  f0:	103000ef          	jal	9f2 <printf>
        close(soc);
  f4:	854a                	mv	a0,s2
  f6:	4b4000ef          	jal	5aa <close>
        exit(1);
  fa:	4505                	li	a0,1
  fc:	486000ef          	jal	582 <exit>
            printf("EOF\n");
 100:	00001517          	auipc	a0,0x1
 104:	b4850513          	add	a0,a0,-1208 # c48 <malloc+0x1a2>
 108:	0eb000ef          	jal	9f2 <printf>
        addr = (unsigned char *)&peer.sin_addr.s_addr;
        printf("recvfrom: %d bytes data received, peer=%d.%d.%d.%d:%d\n",
            ret, addr[0], addr[1], addr[2], addr[3], ntohs(peer.sin_port));
        sendto(soc, buf, ret, 0, (struct sockaddr *)&peer, peerlen);
    }
    close(soc);  
 10c:	854a                	mv	a0,s2
 10e:	49c000ef          	jal	5aa <close>
    exit(0);
 112:	4501                	li	a0,0
 114:	46e000ef          	jal	582 <exit>
        printf("recvfrom: %d bytes data received, peer=%d.%d.%d.%d:%d\n",
 118:	f8c44983          	lbu	s3,-116(s0)
 11c:	f8d44a03          	lbu	s4,-115(s0)
 120:	f8e44a83          	lbu	s5,-114(s0)
 124:	f8f44b03          	lbu	s6,-113(s0)
            ret, addr[0], addr[1], addr[2], addr[3], ntohs(peer.sin_port));
 128:	f8a45503          	lhu	a0,-118(s0)
 12c:	3c8000ef          	jal	4f4 <ntohs>
        printf("recvfrom: %d bytes data received, peer=%d.%d.%d.%d:%d\n",
 130:	0005081b          	sext.w	a6,a0
 134:	87da                	mv	a5,s6
 136:	8756                	mv	a4,s5
 138:	86d2                	mv	a3,s4
 13a:	864e                	mv	a2,s3
 13c:	85a6                	mv	a1,s1
 13e:	00001517          	auipc	a0,0x1
 142:	b1a50513          	add	a0,a0,-1254 # c58 <malloc+0x1b2>
 146:	0ad000ef          	jal	9f2 <printf>
        sendto(soc, buf, ret, 0, (struct sockaddr *)&peer, peerlen);
 14a:	f9c42783          	lw	a5,-100(s0)
 14e:	f8840713          	add	a4,s0,-120
 152:	4681                	li	a3,0
 154:	8626                	mv	a2,s1
 156:	75fd                	lui	a1,0xfffff
 158:	77858593          	add	a1,a1,1912 # fffffffffffff778 <base+0xffffffffffffe768>
 15c:	95a2                	add	a1,a1,s0
 15e:	618c                	ld	a1,0(a1)
 160:	854a                	mv	a0,s2
 162:	4f8000ef          	jal	65a <sendto>
        peerlen = sizeof(peer);
 166:	f9842e23          	sw	s8,-100(s0)
        ret = recvfrom(soc, buf, sizeof(buf), 0, (struct sockaddr *)&peer, &peerlen);
 16a:	f9c40793          	add	a5,s0,-100
 16e:	f8840713          	add	a4,s0,-120
 172:	4681                	li	a3,0
 174:	865e                	mv	a2,s7
 176:	75fd                	lui	a1,0xfffff
 178:	77858593          	add	a1,a1,1912 # fffffffffffff778 <base+0xffffffffffffe768>
 17c:	95a2                	add	a1,a1,s0
 17e:	618c                	ld	a1,0(a1)
 180:	854a                	mv	a0,s2
 182:	4e0000ef          	jal	662 <recvfrom>
 186:	84aa                	mv	s1,a0
        if (ret <= 0) {
 188:	f6a05ce3          	blez	a0,100 <main+0x100>
        if (ret == 2 && buf[0] == '.' && buf[1] == '\n') {
 18c:	f99516e3          	bne	a0,s9,118 <main+0x118>
 190:	7e8d4703          	lbu	a4,2024(s10)
 194:	02e00793          	li	a5,46
 198:	f8f710e3          	bne	a4,a5,118 <main+0x118>
 19c:	7e9d4703          	lbu	a4,2025(s10)
 1a0:	47a9                	li	a5,10
 1a2:	f6f71be3          	bne	a4,a5,118 <main+0x118>
            printf("quit\n");
 1a6:	00001517          	auipc	a0,0x1
 1aa:	aaa50513          	add	a0,a0,-1366 # c50 <malloc+0x1aa>
 1ae:	045000ef          	jal	9f2 <printf>
            break;  
 1b2:	bfa9                	j	10c <main+0x10c>

00000000000001b4 <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start(int argc, char **argv)
{
 1b4:	1141                	add	sp,sp,-16
 1b6:	e406                	sd	ra,8(sp)
 1b8:	e022                	sd	s0,0(sp)
 1ba:	0800                	add	s0,sp,16
  int r;
  extern int main(int argc, char **argv);
  r = main(argc, argv);
 1bc:	e45ff0ef          	jal	0 <main>
  exit(r);
 1c0:	3c2000ef          	jal	582 <exit>

00000000000001c4 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
 1c4:	1141                	add	sp,sp,-16
 1c6:	e422                	sd	s0,8(sp)
 1c8:	0800                	add	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 1ca:	87aa                	mv	a5,a0
 1cc:	0585                	add	a1,a1,1
 1ce:	0785                	add	a5,a5,1
 1d0:	fff5c703          	lbu	a4,-1(a1)
 1d4:	fee78fa3          	sb	a4,-1(a5)
 1d8:	fb75                	bnez	a4,1cc <strcpy+0x8>
    ;
  return os;
}
 1da:	6422                	ld	s0,8(sp)
 1dc:	0141                	add	sp,sp,16
 1de:	8082                	ret

00000000000001e0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 1e0:	1141                	add	sp,sp,-16
 1e2:	e422                	sd	s0,8(sp)
 1e4:	0800                	add	s0,sp,16
  while(*p && *p == *q)
 1e6:	00054783          	lbu	a5,0(a0)
 1ea:	cb91                	beqz	a5,1fe <strcmp+0x1e>
 1ec:	0005c703          	lbu	a4,0(a1)
 1f0:	00f71763          	bne	a4,a5,1fe <strcmp+0x1e>
    p++, q++;
 1f4:	0505                	add	a0,a0,1
 1f6:	0585                	add	a1,a1,1
  while(*p && *p == *q)
 1f8:	00054783          	lbu	a5,0(a0)
 1fc:	fbe5                	bnez	a5,1ec <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 1fe:	0005c503          	lbu	a0,0(a1)
}
 202:	40a7853b          	subw	a0,a5,a0
 206:	6422                	ld	s0,8(sp)
 208:	0141                	add	sp,sp,16
 20a:	8082                	ret

000000000000020c <strncmp>:

int
strncmp(const char *p, const char *q, uint n)
{
 20c:	1141                	add	sp,sp,-16
 20e:	e422                	sd	s0,8(sp)
 210:	0800                	add	s0,sp,16
  while(n > 0 && *p && *p == *q) {
 212:	ce11                	beqz	a2,22e <strncmp+0x22>
 214:	00054783          	lbu	a5,0(a0)
 218:	cf89                	beqz	a5,232 <strncmp+0x26>
 21a:	0005c703          	lbu	a4,0(a1)
 21e:	00f71a63          	bne	a4,a5,232 <strncmp+0x26>
    p++, q++, n--;
 222:	0505                	add	a0,a0,1
 224:	0585                	add	a1,a1,1
 226:	367d                	addw	a2,a2,-1
  while(n > 0 && *p && *p == *q) {
 228:	f675                	bnez	a2,214 <strncmp+0x8>
  }
  if (n == 0)
    return 0;
 22a:	4501                	li	a0,0
 22c:	a801                	j	23c <strncmp+0x30>
 22e:	4501                	li	a0,0
 230:	a031                	j	23c <strncmp+0x30>
  return (uchar)*p - (uchar)*q;
 232:	00054503          	lbu	a0,0(a0)
 236:	0005c783          	lbu	a5,0(a1)
 23a:	9d1d                	subw	a0,a0,a5
}
 23c:	6422                	ld	s0,8(sp)
 23e:	0141                	add	sp,sp,16
 240:	8082                	ret

0000000000000242 <strcat>:

char*
strcat(char *dst, const char *src)
{
 242:	1141                	add	sp,sp,-16
 244:	e422                	sd	s0,8(sp)
 246:	0800                	add	s0,sp,16
  char *p = dst;
  while(*p) p++;
 248:	00054783          	lbu	a5,0(a0)
 24c:	c385                	beqz	a5,26c <strcat+0x2a>
  char *p = dst;
 24e:	87aa                	mv	a5,a0
  while(*p) p++;
 250:	0785                	add	a5,a5,1
 252:	0007c703          	lbu	a4,0(a5)
 256:	ff6d                	bnez	a4,250 <strcat+0xe>
  while((*p++ = *src++) != 0);
 258:	0585                	add	a1,a1,1
 25a:	0785                	add	a5,a5,1
 25c:	fff5c703          	lbu	a4,-1(a1)
 260:	fee78fa3          	sb	a4,-1(a5)
 264:	fb75                	bnez	a4,258 <strcat+0x16>
  return dst;
}
 266:	6422                	ld	s0,8(sp)
 268:	0141                	add	sp,sp,16
 26a:	8082                	ret
  char *p = dst;
 26c:	87aa                	mv	a5,a0
 26e:	b7ed                	j	258 <strcat+0x16>

0000000000000270 <strncpy>:

char*
strncpy(char *dst, const char *src, int n)
{
 270:	1141                	add	sp,sp,-16
 272:	e422                	sd	s0,8(sp)
 274:	0800                	add	s0,sp,16
  char *p = dst;
 276:	87aa                	mv	a5,a0
  while(n > 0 && *src) {
 278:	02c05463          	blez	a2,2a0 <strncpy+0x30>
 27c:	0005c703          	lbu	a4,0(a1)
 280:	cb01                	beqz	a4,290 <strncpy+0x20>
    *p++ = *src++;
 282:	0585                	add	a1,a1,1
 284:	0785                	add	a5,a5,1
 286:	fee78fa3          	sb	a4,-1(a5)
    n--;
 28a:	367d                	addw	a2,a2,-1
  while(n > 0 && *src) {
 28c:	fa65                	bnez	a2,27c <strncpy+0xc>
 28e:	a809                	j	2a0 <strncpy+0x30>
  }
  while(n > 0) {
 290:	1602                	sll	a2,a2,0x20
 292:	9201                	srl	a2,a2,0x20
 294:	963e                	add	a2,a2,a5
    *p++ = 0;
 296:	0785                	add	a5,a5,1
 298:	fe078fa3          	sb	zero,-1(a5)
  while(n > 0) {
 29c:	fec79de3          	bne	a5,a2,296 <strncpy+0x26>
    n--;
  }
  return dst;
}
 2a0:	6422                	ld	s0,8(sp)
 2a2:	0141                	add	sp,sp,16
 2a4:	8082                	ret

00000000000002a6 <strlen>:

uint
strlen(const char *s)
{
 2a6:	1141                	add	sp,sp,-16
 2a8:	e422                	sd	s0,8(sp)
 2aa:	0800                	add	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 2ac:	00054783          	lbu	a5,0(a0)
 2b0:	cf91                	beqz	a5,2cc <strlen+0x26>
 2b2:	0505                	add	a0,a0,1
 2b4:	87aa                	mv	a5,a0
 2b6:	86be                	mv	a3,a5
 2b8:	0785                	add	a5,a5,1
 2ba:	fff7c703          	lbu	a4,-1(a5)
 2be:	ff65                	bnez	a4,2b6 <strlen+0x10>
 2c0:	40a6853b          	subw	a0,a3,a0
 2c4:	2505                	addw	a0,a0,1
    ;
  return n;
}
 2c6:	6422                	ld	s0,8(sp)
 2c8:	0141                	add	sp,sp,16
 2ca:	8082                	ret
  for(n = 0; s[n]; n++)
 2cc:	4501                	li	a0,0
 2ce:	bfe5                	j	2c6 <strlen+0x20>

00000000000002d0 <memset>:

void*
memset(void *dst, int c, uint n)
{
 2d0:	1141                	add	sp,sp,-16
 2d2:	e422                	sd	s0,8(sp)
 2d4:	0800                	add	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 2d6:	ca19                	beqz	a2,2ec <memset+0x1c>
 2d8:	87aa                	mv	a5,a0
 2da:	1602                	sll	a2,a2,0x20
 2dc:	9201                	srl	a2,a2,0x20
 2de:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 2e2:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 2e6:	0785                	add	a5,a5,1
 2e8:	fee79de3          	bne	a5,a4,2e2 <memset+0x12>
  }
  return dst;
}
 2ec:	6422                	ld	s0,8(sp)
 2ee:	0141                	add	sp,sp,16
 2f0:	8082                	ret

00000000000002f2 <strchr>:

char*
strchr(const char *s, char c)
{
 2f2:	1141                	add	sp,sp,-16
 2f4:	e422                	sd	s0,8(sp)
 2f6:	0800                	add	s0,sp,16
  for(; *s; s++)
 2f8:	00054783          	lbu	a5,0(a0)
 2fc:	cb99                	beqz	a5,312 <strchr+0x20>
    if(*s == c)
 2fe:	00f58763          	beq	a1,a5,30c <strchr+0x1a>
  for(; *s; s++)
 302:	0505                	add	a0,a0,1
 304:	00054783          	lbu	a5,0(a0)
 308:	fbfd                	bnez	a5,2fe <strchr+0xc>
      return (char*)s;
  return 0;
 30a:	4501                	li	a0,0
}
 30c:	6422                	ld	s0,8(sp)
 30e:	0141                	add	sp,sp,16
 310:	8082                	ret
  return 0;
 312:	4501                	li	a0,0
 314:	bfe5                	j	30c <strchr+0x1a>

0000000000000316 <gets>:

char*
gets(char *buf, int max)
{
 316:	711d                	add	sp,sp,-96
 318:	ec86                	sd	ra,88(sp)
 31a:	e8a2                	sd	s0,80(sp)
 31c:	e4a6                	sd	s1,72(sp)
 31e:	e0ca                	sd	s2,64(sp)
 320:	fc4e                	sd	s3,56(sp)
 322:	f852                	sd	s4,48(sp)
 324:	f456                	sd	s5,40(sp)
 326:	f05a                	sd	s6,32(sp)
 328:	ec5e                	sd	s7,24(sp)
 32a:	1080                	add	s0,sp,96
 32c:	8baa                	mv	s7,a0
 32e:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 330:	892a                	mv	s2,a0
 332:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 334:	4aa9                	li	s5,10
 336:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 338:	89a6                	mv	s3,s1
 33a:	2485                	addw	s1,s1,1
 33c:	0344d663          	bge	s1,s4,368 <gets+0x52>
    cc = read(0, &c, 1);
 340:	4605                	li	a2,1
 342:	faf40593          	add	a1,s0,-81
 346:	4501                	li	a0,0
 348:	252000ef          	jal	59a <read>
    if(cc < 1)
 34c:	00a05e63          	blez	a0,368 <gets+0x52>
    buf[i++] = c;
 350:	faf44783          	lbu	a5,-81(s0)
 354:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 358:	01578763          	beq	a5,s5,366 <gets+0x50>
 35c:	0905                	add	s2,s2,1
 35e:	fd679de3          	bne	a5,s6,338 <gets+0x22>
    buf[i++] = c;
 362:	89a6                	mv	s3,s1
 364:	a011                	j	368 <gets+0x52>
 366:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 368:	99de                	add	s3,s3,s7
 36a:	00098023          	sb	zero,0(s3)
  return buf;
}
 36e:	855e                	mv	a0,s7
 370:	60e6                	ld	ra,88(sp)
 372:	6446                	ld	s0,80(sp)
 374:	64a6                	ld	s1,72(sp)
 376:	6906                	ld	s2,64(sp)
 378:	79e2                	ld	s3,56(sp)
 37a:	7a42                	ld	s4,48(sp)
 37c:	7aa2                	ld	s5,40(sp)
 37e:	7b02                	ld	s6,32(sp)
 380:	6be2                	ld	s7,24(sp)
 382:	6125                	add	sp,sp,96
 384:	8082                	ret

0000000000000386 <stat>:

int
stat(const char *n, struct stat *st)
{
 386:	1101                	add	sp,sp,-32
 388:	ec06                	sd	ra,24(sp)
 38a:	e822                	sd	s0,16(sp)
 38c:	e04a                	sd	s2,0(sp)
 38e:	1000                	add	s0,sp,32
 390:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 392:	4581                	li	a1,0
 394:	22e000ef          	jal	5c2 <open>
  if(fd < 0)
 398:	02054263          	bltz	a0,3bc <stat+0x36>
 39c:	e426                	sd	s1,8(sp)
 39e:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 3a0:	85ca                	mv	a1,s2
 3a2:	238000ef          	jal	5da <fstat>
 3a6:	892a                	mv	s2,a0
  close(fd);
 3a8:	8526                	mv	a0,s1
 3aa:	200000ef          	jal	5aa <close>
  return r;
 3ae:	64a2                	ld	s1,8(sp)
}
 3b0:	854a                	mv	a0,s2
 3b2:	60e2                	ld	ra,24(sp)
 3b4:	6442                	ld	s0,16(sp)
 3b6:	6902                	ld	s2,0(sp)
 3b8:	6105                	add	sp,sp,32
 3ba:	8082                	ret
    return -1;
 3bc:	597d                	li	s2,-1
 3be:	bfcd                	j	3b0 <stat+0x2a>

00000000000003c0 <atoi>:

int
atoi(const char *s)
{
 3c0:	1141                	add	sp,sp,-16
 3c2:	e422                	sd	s0,8(sp)
 3c4:	0800                	add	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 3c6:	00054683          	lbu	a3,0(a0)
 3ca:	fd06879b          	addw	a5,a3,-48
 3ce:	0ff7f793          	zext.b	a5,a5
 3d2:	4625                	li	a2,9
 3d4:	02f66863          	bltu	a2,a5,404 <atoi+0x44>
 3d8:	872a                	mv	a4,a0
  n = 0;
 3da:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 3dc:	0705                	add	a4,a4,1
 3de:	0025179b          	sllw	a5,a0,0x2
 3e2:	9fa9                	addw	a5,a5,a0
 3e4:	0017979b          	sllw	a5,a5,0x1
 3e8:	9fb5                	addw	a5,a5,a3
 3ea:	fd07851b          	addw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 3ee:	00074683          	lbu	a3,0(a4)
 3f2:	fd06879b          	addw	a5,a3,-48
 3f6:	0ff7f793          	zext.b	a5,a5
 3fa:	fef671e3          	bgeu	a2,a5,3dc <atoi+0x1c>
  return n;
}
 3fe:	6422                	ld	s0,8(sp)
 400:	0141                	add	sp,sp,16
 402:	8082                	ret
  n = 0;
 404:	4501                	li	a0,0
 406:	bfe5                	j	3fe <atoi+0x3e>

0000000000000408 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 408:	1141                	add	sp,sp,-16
 40a:	e422                	sd	s0,8(sp)
 40c:	0800                	add	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 40e:	02b57463          	bgeu	a0,a1,436 <memmove+0x2e>
    while(n-- > 0)
 412:	00c05f63          	blez	a2,430 <memmove+0x28>
 416:	1602                	sll	a2,a2,0x20
 418:	9201                	srl	a2,a2,0x20
 41a:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 41e:	872a                	mv	a4,a0
      *dst++ = *src++;
 420:	0585                	add	a1,a1,1
 422:	0705                	add	a4,a4,1
 424:	fff5c683          	lbu	a3,-1(a1)
 428:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 42c:	fef71ae3          	bne	a4,a5,420 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 430:	6422                	ld	s0,8(sp)
 432:	0141                	add	sp,sp,16
 434:	8082                	ret
    dst += n;
 436:	00c50733          	add	a4,a0,a2
    src += n;
 43a:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 43c:	fec05ae3          	blez	a2,430 <memmove+0x28>
 440:	fff6079b          	addw	a5,a2,-1
 444:	1782                	sll	a5,a5,0x20
 446:	9381                	srl	a5,a5,0x20
 448:	fff7c793          	not	a5,a5
 44c:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 44e:	15fd                	add	a1,a1,-1
 450:	177d                	add	a4,a4,-1
 452:	0005c683          	lbu	a3,0(a1)
 456:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 45a:	fee79ae3          	bne	a5,a4,44e <memmove+0x46>
 45e:	bfc9                	j	430 <memmove+0x28>

0000000000000460 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 460:	1141                	add	sp,sp,-16
 462:	e422                	sd	s0,8(sp)
 464:	0800                	add	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 466:	ca05                	beqz	a2,496 <memcmp+0x36>
 468:	fff6069b          	addw	a3,a2,-1
 46c:	1682                	sll	a3,a3,0x20
 46e:	9281                	srl	a3,a3,0x20
 470:	0685                	add	a3,a3,1
 472:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 474:	00054783          	lbu	a5,0(a0)
 478:	0005c703          	lbu	a4,0(a1)
 47c:	00e79863          	bne	a5,a4,48c <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 480:	0505                	add	a0,a0,1
    p2++;
 482:	0585                	add	a1,a1,1
  while (n-- > 0) {
 484:	fed518e3          	bne	a0,a3,474 <memcmp+0x14>
  }
  return 0;
 488:	4501                	li	a0,0
 48a:	a019                	j	490 <memcmp+0x30>
      return *p1 - *p2;
 48c:	40e7853b          	subw	a0,a5,a4
}
 490:	6422                	ld	s0,8(sp)
 492:	0141                	add	sp,sp,16
 494:	8082                	ret
  return 0;
 496:	4501                	li	a0,0
 498:	bfe5                	j	490 <memcmp+0x30>

000000000000049a <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 49a:	1141                	add	sp,sp,-16
 49c:	e406                	sd	ra,8(sp)
 49e:	e022                	sd	s0,0(sp)
 4a0:	0800                	add	s0,sp,16
  return memmove(dst, src, n);
 4a2:	f67ff0ef          	jal	408 <memmove>
}
 4a6:	60a2                	ld	ra,8(sp)
 4a8:	6402                	ld	s0,0(sp)
 4aa:	0141                	add	sp,sp,16
 4ac:	8082                	ret

00000000000004ae <sbrk>:

char *
sbrk(int n) {
 4ae:	1141                	add	sp,sp,-16
 4b0:	e406                	sd	ra,8(sp)
 4b2:	e022                	sd	s0,0(sp)
 4b4:	0800                	add	s0,sp,16
  return sys_sbrk(n, SBRK_EAGER);
 4b6:	4585                	li	a1,1
 4b8:	152000ef          	jal	60a <sys_sbrk>
}
 4bc:	60a2                	ld	ra,8(sp)
 4be:	6402                	ld	s0,0(sp)
 4c0:	0141                	add	sp,sp,16
 4c2:	8082                	ret

00000000000004c4 <sbrklazy>:

char *
sbrklazy(int n) {
 4c4:	1141                	add	sp,sp,-16
 4c6:	e406                	sd	ra,8(sp)
 4c8:	e022                	sd	s0,0(sp)
 4ca:	0800                	add	s0,sp,16
  return sys_sbrk(n, SBRK_LAZY);
 4cc:	4589                	li	a1,2
 4ce:	13c000ef          	jal	60a <sys_sbrk>
}
 4d2:	60a2                	ld	ra,8(sp)
 4d4:	6402                	ld	s0,0(sp)
 4d6:	0141                	add	sp,sp,16
 4d8:	8082                	ret

00000000000004da <htons>:

// Byte order conversion functions
unsigned short
htons(unsigned short hostshort)
{
 4da:	1141                	add	sp,sp,-16
 4dc:	e422                	sd	s0,8(sp)
 4de:	0800                	add	s0,sp,16
  return ((hostshort >> 8) & 0xff) | ((hostshort & 0xff) << 8);
 4e0:	0085179b          	sllw	a5,a0,0x8
 4e4:	0085551b          	srlw	a0,a0,0x8
 4e8:	8d5d                	or	a0,a0,a5
}
 4ea:	1542                	sll	a0,a0,0x30
 4ec:	9141                	srl	a0,a0,0x30
 4ee:	6422                	ld	s0,8(sp)
 4f0:	0141                	add	sp,sp,16
 4f2:	8082                	ret

00000000000004f4 <ntohs>:

unsigned short
ntohs(unsigned short netshort)
{
 4f4:	1141                	add	sp,sp,-16
 4f6:	e422                	sd	s0,8(sp)
 4f8:	0800                	add	s0,sp,16
  return ((netshort >> 8) & 0xff) | ((netshort & 0xff) << 8);
 4fa:	0085179b          	sllw	a5,a0,0x8
 4fe:	0085551b          	srlw	a0,a0,0x8
 502:	8d5d                	or	a0,a0,a5
}
 504:	1542                	sll	a0,a0,0x30
 506:	9141                	srl	a0,a0,0x30
 508:	6422                	ld	s0,8(sp)
 50a:	0141                	add	sp,sp,16
 50c:	8082                	ret

000000000000050e <htonl>:

unsigned long
htonl(unsigned long hostlong)
{
 50e:	1141                	add	sp,sp,-16
 510:	e422                	sd	s0,8(sp)
 512:	0800                	add	s0,sp,16
  return ((hostlong >> 24) & 0xff) |
 514:	0185579b          	srlw	a5,a0,0x18
         ((hostlong >> 8) & 0xff00) |
 518:	00855713          	srl	a4,a0,0x8
 51c:	66c1                	lui	a3,0x10
 51e:	f0068693          	add	a3,a3,-256 # ff00 <base+0xeef0>
 522:	8f75                	and	a4,a4,a3
  return ((hostlong >> 24) & 0xff) |
 524:	8fd9                	or	a5,a5,a4
         ((hostlong & 0xff00) << 8) |
 526:	00851713          	sll	a4,a0,0x8
 52a:	00ff06b7          	lui	a3,0xff0
 52e:	8f75                	and	a4,a4,a3
         ((hostlong >> 8) & 0xff00) |
 530:	8fd9                	or	a5,a5,a4
         ((hostlong & 0xff) << 24);
 532:	0562                	sll	a0,a0,0x18
 534:	0ff00713          	li	a4,255
 538:	0762                	sll	a4,a4,0x18
 53a:	8d79                	and	a0,a0,a4
}
 53c:	8d5d                	or	a0,a0,a5
 53e:	6422                	ld	s0,8(sp)
 540:	0141                	add	sp,sp,16
 542:	8082                	ret

0000000000000544 <ntohl>:

unsigned long
ntohl(unsigned long netlong)
{
 544:	1141                	add	sp,sp,-16
 546:	e422                	sd	s0,8(sp)
 548:	0800                	add	s0,sp,16
  return ((netlong >> 24) & 0xff) |
 54a:	0185579b          	srlw	a5,a0,0x18
         ((netlong >> 8) & 0xff00) |
 54e:	00855713          	srl	a4,a0,0x8
 552:	66c1                	lui	a3,0x10
 554:	f0068693          	add	a3,a3,-256 # ff00 <base+0xeef0>
 558:	8f75                	and	a4,a4,a3
  return ((netlong >> 24) & 0xff) |
 55a:	8fd9                	or	a5,a5,a4
         ((netlong & 0xff00) << 8) |
 55c:	00851713          	sll	a4,a0,0x8
 560:	00ff06b7          	lui	a3,0xff0
 564:	8f75                	and	a4,a4,a3
         ((netlong >> 8) & 0xff00) |
 566:	8fd9                	or	a5,a5,a4
         ((netlong & 0xff) << 24);
 568:	0562                	sll	a0,a0,0x18
 56a:	0ff00713          	li	a4,255
 56e:	0762                	sll	a4,a4,0x18
 570:	8d79                	and	a0,a0,a4
}
 572:	8d5d                	or	a0,a0,a5
 574:	6422                	ld	s0,8(sp)
 576:	0141                	add	sp,sp,16
 578:	8082                	ret

000000000000057a <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 57a:	4885                	li	a7,1
 ecall
 57c:	00000073          	ecall
 ret
 580:	8082                	ret

0000000000000582 <exit>:
.global exit
exit:
 li a7, SYS_exit
 582:	4889                	li	a7,2
 ecall
 584:	00000073          	ecall
 ret
 588:	8082                	ret

000000000000058a <wait>:
.global wait
wait:
 li a7, SYS_wait
 58a:	488d                	li	a7,3
 ecall
 58c:	00000073          	ecall
 ret
 590:	8082                	ret

0000000000000592 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 592:	4891                	li	a7,4
 ecall
 594:	00000073          	ecall
 ret
 598:	8082                	ret

000000000000059a <read>:
.global read
read:
 li a7, SYS_read
 59a:	4895                	li	a7,5
 ecall
 59c:	00000073          	ecall
 ret
 5a0:	8082                	ret

00000000000005a2 <write>:
.global write
write:
 li a7, SYS_write
 5a2:	48c1                	li	a7,16
 ecall
 5a4:	00000073          	ecall
 ret
 5a8:	8082                	ret

00000000000005aa <close>:
.global close
close:
 li a7, SYS_close
 5aa:	48d5                	li	a7,21
 ecall
 5ac:	00000073          	ecall
 ret
 5b0:	8082                	ret

00000000000005b2 <kill>:
.global kill
kill:
 li a7, SYS_kill
 5b2:	4899                	li	a7,6
 ecall
 5b4:	00000073          	ecall
 ret
 5b8:	8082                	ret

00000000000005ba <exec>:
.global exec
exec:
 li a7, SYS_exec
 5ba:	489d                	li	a7,7
 ecall
 5bc:	00000073          	ecall
 ret
 5c0:	8082                	ret

00000000000005c2 <open>:
.global open
open:
 li a7, SYS_open
 5c2:	48bd                	li	a7,15
 ecall
 5c4:	00000073          	ecall
 ret
 5c8:	8082                	ret

00000000000005ca <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 5ca:	48c5                	li	a7,17
 ecall
 5cc:	00000073          	ecall
 ret
 5d0:	8082                	ret

00000000000005d2 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 5d2:	48c9                	li	a7,18
 ecall
 5d4:	00000073          	ecall
 ret
 5d8:	8082                	ret

00000000000005da <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 5da:	48a1                	li	a7,8
 ecall
 5dc:	00000073          	ecall
 ret
 5e0:	8082                	ret

00000000000005e2 <link>:
.global link
link:
 li a7, SYS_link
 5e2:	48cd                	li	a7,19
 ecall
 5e4:	00000073          	ecall
 ret
 5e8:	8082                	ret

00000000000005ea <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 5ea:	48d1                	li	a7,20
 ecall
 5ec:	00000073          	ecall
 ret
 5f0:	8082                	ret

00000000000005f2 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 5f2:	48a5                	li	a7,9
 ecall
 5f4:	00000073          	ecall
 ret
 5f8:	8082                	ret

00000000000005fa <dup>:
.global dup
dup:
 li a7, SYS_dup
 5fa:	48a9                	li	a7,10
 ecall
 5fc:	00000073          	ecall
 ret
 600:	8082                	ret

0000000000000602 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 602:	48ad                	li	a7,11
 ecall
 604:	00000073          	ecall
 ret
 608:	8082                	ret

000000000000060a <sys_sbrk>:
.global sys_sbrk
sys_sbrk:
 li a7, SYS_sbrk
 60a:	48b1                	li	a7,12
 ecall
 60c:	00000073          	ecall
 ret
 610:	8082                	ret

0000000000000612 <pause>:
.global pause
pause:
 li a7, SYS_pause
 612:	48b5                	li	a7,13
 ecall
 614:	00000073          	ecall
 ret
 618:	8082                	ret

000000000000061a <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 61a:	48b9                	li	a7,14
 ecall
 61c:	00000073          	ecall
 ret
 620:	8082                	ret

0000000000000622 <socket>:
.global socket
socket:
 li a7, SYS_socket
 622:	48d9                	li	a7,22
 ecall
 624:	00000073          	ecall
 ret
 628:	8082                	ret

000000000000062a <bind>:
.global bind
bind:
 li a7, SYS_bind
 62a:	48dd                	li	a7,23
 ecall
 62c:	00000073          	ecall
 ret
 630:	8082                	ret

0000000000000632 <listen>:
.global listen
listen:
 li a7, SYS_listen
 632:	48e1                	li	a7,24
 ecall
 634:	00000073          	ecall
 ret
 638:	8082                	ret

000000000000063a <accept>:
.global accept
accept:
 li a7, SYS_accept
 63a:	48e5                	li	a7,25
 ecall
 63c:	00000073          	ecall
 ret
 640:	8082                	ret

0000000000000642 <connect>:
.global connect
connect:
 li a7, SYS_connect
 642:	48e9                	li	a7,26
 ecall
 644:	00000073          	ecall
 ret
 648:	8082                	ret

000000000000064a <send>:
.global send
send:
 li a7, SYS_send
 64a:	48ed                	li	a7,27
 ecall
 64c:	00000073          	ecall
 ret
 650:	8082                	ret

0000000000000652 <recv>:
.global recv
recv:
 li a7, SYS_recv
 652:	48f1                	li	a7,28
 ecall
 654:	00000073          	ecall
 ret
 658:	8082                	ret

000000000000065a <sendto>:
.global sendto
sendto:
 li a7, SYS_sendto
 65a:	48f5                	li	a7,29
 ecall
 65c:	00000073          	ecall
 ret
 660:	8082                	ret

0000000000000662 <recvfrom>:
.global recvfrom
recvfrom:
 li a7, SYS_recvfrom
 662:	48f9                	li	a7,30
 ecall
 664:	00000073          	ecall
 ret
 668:	8082                	ret

000000000000066a <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 66a:	1101                	add	sp,sp,-32
 66c:	ec06                	sd	ra,24(sp)
 66e:	e822                	sd	s0,16(sp)
 670:	1000                	add	s0,sp,32
 672:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 676:	4605                	li	a2,1
 678:	fef40593          	add	a1,s0,-17
 67c:	f27ff0ef          	jal	5a2 <write>
}
 680:	60e2                	ld	ra,24(sp)
 682:	6442                	ld	s0,16(sp)
 684:	6105                	add	sp,sp,32
 686:	8082                	ret

0000000000000688 <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
 688:	715d                	add	sp,sp,-80
 68a:	e486                	sd	ra,72(sp)
 68c:	e0a2                	sd	s0,64(sp)
 68e:	f84a                	sd	s2,48(sp)
 690:	0880                	add	s0,sp,80
 692:	892a                	mv	s2,a0
  char buf[20];
  int i, neg;
  unsigned long long x;

  neg = 0;
  if(sgn && xx < 0){
 694:	c299                	beqz	a3,69a <printint+0x12>
 696:	0805c363          	bltz	a1,71c <printint+0x94>
  neg = 0;
 69a:	4881                	li	a7,0
 69c:	fb840693          	add	a3,s0,-72
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
 6a0:	4781                	li	a5,0
  do{
    buf[i++] = digits[x % base];
 6a2:	00000517          	auipc	a0,0x0
 6a6:	5f650513          	add	a0,a0,1526 # c98 <digits>
 6aa:	883e                	mv	a6,a5
 6ac:	2785                	addw	a5,a5,1
 6ae:	02c5f733          	remu	a4,a1,a2
 6b2:	972a                	add	a4,a4,a0
 6b4:	00074703          	lbu	a4,0(a4)
 6b8:	00e68023          	sb	a4,0(a3) # ff0000 <base+0xfeeff0>
  }while((x /= base) != 0);
 6bc:	872e                	mv	a4,a1
 6be:	02c5d5b3          	divu	a1,a1,a2
 6c2:	0685                	add	a3,a3,1
 6c4:	fec773e3          	bgeu	a4,a2,6aa <printint+0x22>
  if(neg)
 6c8:	00088b63          	beqz	a7,6de <printint+0x56>
    buf[i++] = '-';
 6cc:	fd078793          	add	a5,a5,-48
 6d0:	97a2                	add	a5,a5,s0
 6d2:	02d00713          	li	a4,45
 6d6:	fee78423          	sb	a4,-24(a5)
 6da:	0028079b          	addw	a5,a6,2

  while(--i >= 0)
 6de:	02f05a63          	blez	a5,712 <printint+0x8a>
 6e2:	fc26                	sd	s1,56(sp)
 6e4:	f44e                	sd	s3,40(sp)
 6e6:	fb840713          	add	a4,s0,-72
 6ea:	00f704b3          	add	s1,a4,a5
 6ee:	fff70993          	add	s3,a4,-1
 6f2:	99be                	add	s3,s3,a5
 6f4:	37fd                	addw	a5,a5,-1
 6f6:	1782                	sll	a5,a5,0x20
 6f8:	9381                	srl	a5,a5,0x20
 6fa:	40f989b3          	sub	s3,s3,a5
    putc(fd, buf[i]);
 6fe:	fff4c583          	lbu	a1,-1(s1)
 702:	854a                	mv	a0,s2
 704:	f67ff0ef          	jal	66a <putc>
  while(--i >= 0)
 708:	14fd                	add	s1,s1,-1
 70a:	ff349ae3          	bne	s1,s3,6fe <printint+0x76>
 70e:	74e2                	ld	s1,56(sp)
 710:	79a2                	ld	s3,40(sp)
}
 712:	60a6                	ld	ra,72(sp)
 714:	6406                	ld	s0,64(sp)
 716:	7942                	ld	s2,48(sp)
 718:	6161                	add	sp,sp,80
 71a:	8082                	ret
    x = -xx;
 71c:	40b005b3          	neg	a1,a1
    neg = 1;
 720:	4885                	li	a7,1
    x = -xx;
 722:	bfad                	j	69c <printint+0x14>

0000000000000724 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %c, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 724:	711d                	add	sp,sp,-96
 726:	ec86                	sd	ra,88(sp)
 728:	e8a2                	sd	s0,80(sp)
 72a:	e0ca                	sd	s2,64(sp)
 72c:	1080                	add	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 72e:	0005c903          	lbu	s2,0(a1)
 732:	28090663          	beqz	s2,9be <vprintf+0x29a>
 736:	e4a6                	sd	s1,72(sp)
 738:	fc4e                	sd	s3,56(sp)
 73a:	f852                	sd	s4,48(sp)
 73c:	f456                	sd	s5,40(sp)
 73e:	f05a                	sd	s6,32(sp)
 740:	ec5e                	sd	s7,24(sp)
 742:	e862                	sd	s8,16(sp)
 744:	e466                	sd	s9,8(sp)
 746:	8b2a                	mv	s6,a0
 748:	8a2e                	mv	s4,a1
 74a:	8bb2                	mv	s7,a2
  state = 0;
 74c:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
 74e:	4481                	li	s1,0
 750:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
 752:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
 756:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
 75a:	06c00c93          	li	s9,108
 75e:	a005                	j	77e <vprintf+0x5a>
        putc(fd, c0);
 760:	85ca                	mv	a1,s2
 762:	855a                	mv	a0,s6
 764:	f07ff0ef          	jal	66a <putc>
 768:	a019                	j	76e <vprintf+0x4a>
    } else if(state == '%'){
 76a:	03598263          	beq	s3,s5,78e <vprintf+0x6a>
  for(i = 0; fmt[i]; i++){
 76e:	2485                	addw	s1,s1,1
 770:	8726                	mv	a4,s1
 772:	009a07b3          	add	a5,s4,s1
 776:	0007c903          	lbu	s2,0(a5)
 77a:	22090a63          	beqz	s2,9ae <vprintf+0x28a>
    c0 = fmt[i] & 0xff;
 77e:	0009079b          	sext.w	a5,s2
    if(state == 0){
 782:	fe0994e3          	bnez	s3,76a <vprintf+0x46>
      if(c0 == '%'){
 786:	fd579de3          	bne	a5,s5,760 <vprintf+0x3c>
        state = '%';
 78a:	89be                	mv	s3,a5
 78c:	b7cd                	j	76e <vprintf+0x4a>
      if(c0) c1 = fmt[i+1] & 0xff;
 78e:	00ea06b3          	add	a3,s4,a4
 792:	0016c683          	lbu	a3,1(a3)
      c1 = c2 = 0;
 796:	8636                	mv	a2,a3
      if(c1) c2 = fmt[i+2] & 0xff;
 798:	c681                	beqz	a3,7a0 <vprintf+0x7c>
 79a:	9752                	add	a4,a4,s4
 79c:	00274603          	lbu	a2,2(a4)
      if(c0 == 'd'){
 7a0:	05878363          	beq	a5,s8,7e6 <vprintf+0xc2>
      } else if(c0 == 'l' && c1 == 'd'){
 7a4:	05978d63          	beq	a5,s9,7fe <vprintf+0xda>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
 7a8:	07500713          	li	a4,117
 7ac:	0ee78763          	beq	a5,a4,89a <vprintf+0x176>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
 7b0:	07800713          	li	a4,120
 7b4:	12e78963          	beq	a5,a4,8e6 <vprintf+0x1c2>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
 7b8:	07000713          	li	a4,112
 7bc:	14e78e63          	beq	a5,a4,918 <vprintf+0x1f4>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 'c'){
 7c0:	06300713          	li	a4,99
 7c4:	18e78e63          	beq	a5,a4,960 <vprintf+0x23c>
        putc(fd, va_arg(ap, uint32));
      } else if(c0 == 's'){
 7c8:	07300713          	li	a4,115
 7cc:	1ae78463          	beq	a5,a4,974 <vprintf+0x250>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
 7d0:	02500713          	li	a4,37
 7d4:	04e79563          	bne	a5,a4,81e <vprintf+0xfa>
        putc(fd, '%');
 7d8:	02500593          	li	a1,37
 7dc:	855a                	mv	a0,s6
 7de:	e8dff0ef          	jal	66a <putc>
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c0);
      }

      state = 0;
 7e2:	4981                	li	s3,0
 7e4:	b769                	j	76e <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 1);
 7e6:	008b8913          	add	s2,s7,8
 7ea:	4685                	li	a3,1
 7ec:	4629                	li	a2,10
 7ee:	000ba583          	lw	a1,0(s7)
 7f2:	855a                	mv	a0,s6
 7f4:	e95ff0ef          	jal	688 <printint>
 7f8:	8bca                	mv	s7,s2
      state = 0;
 7fa:	4981                	li	s3,0
 7fc:	bf8d                	j	76e <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'd'){
 7fe:	06400793          	li	a5,100
 802:	02f68963          	beq	a3,a5,834 <vprintf+0x110>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 806:	06c00793          	li	a5,108
 80a:	04f68263          	beq	a3,a5,84e <vprintf+0x12a>
      } else if(c0 == 'l' && c1 == 'u'){
 80e:	07500793          	li	a5,117
 812:	0af68063          	beq	a3,a5,8b2 <vprintf+0x18e>
      } else if(c0 == 'l' && c1 == 'x'){
 816:	07800793          	li	a5,120
 81a:	0ef68263          	beq	a3,a5,8fe <vprintf+0x1da>
        putc(fd, '%');
 81e:	02500593          	li	a1,37
 822:	855a                	mv	a0,s6
 824:	e47ff0ef          	jal	66a <putc>
        putc(fd, c0);
 828:	85ca                	mv	a1,s2
 82a:	855a                	mv	a0,s6
 82c:	e3fff0ef          	jal	66a <putc>
      state = 0;
 830:	4981                	li	s3,0
 832:	bf35                	j	76e <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 834:	008b8913          	add	s2,s7,8
 838:	4685                	li	a3,1
 83a:	4629                	li	a2,10
 83c:	000bb583          	ld	a1,0(s7)
 840:	855a                	mv	a0,s6
 842:	e47ff0ef          	jal	688 <printint>
        i += 1;
 846:	2485                	addw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 848:	8bca                	mv	s7,s2
      state = 0;
 84a:	4981                	li	s3,0
        i += 1;
 84c:	b70d                	j	76e <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 84e:	06400793          	li	a5,100
 852:	02f60763          	beq	a2,a5,880 <vprintf+0x15c>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 856:	07500793          	li	a5,117
 85a:	06f60963          	beq	a2,a5,8cc <vprintf+0x1a8>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 85e:	07800793          	li	a5,120
 862:	faf61ee3          	bne	a2,a5,81e <vprintf+0xfa>
        printint(fd, va_arg(ap, uint64), 16, 0);
 866:	008b8913          	add	s2,s7,8
 86a:	4681                	li	a3,0
 86c:	4641                	li	a2,16
 86e:	000bb583          	ld	a1,0(s7)
 872:	855a                	mv	a0,s6
 874:	e15ff0ef          	jal	688 <printint>
        i += 2;
 878:	2489                	addw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 87a:	8bca                	mv	s7,s2
      state = 0;
 87c:	4981                	li	s3,0
        i += 2;
 87e:	bdc5                	j	76e <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 880:	008b8913          	add	s2,s7,8
 884:	4685                	li	a3,1
 886:	4629                	li	a2,10
 888:	000bb583          	ld	a1,0(s7)
 88c:	855a                	mv	a0,s6
 88e:	dfbff0ef          	jal	688 <printint>
        i += 2;
 892:	2489                	addw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 894:	8bca                	mv	s7,s2
      state = 0;
 896:	4981                	li	s3,0
        i += 2;
 898:	bdd9                	j	76e <vprintf+0x4a>
        printint(fd, va_arg(ap, uint32), 10, 0);
 89a:	008b8913          	add	s2,s7,8
 89e:	4681                	li	a3,0
 8a0:	4629                	li	a2,10
 8a2:	000be583          	lwu	a1,0(s7)
 8a6:	855a                	mv	a0,s6
 8a8:	de1ff0ef          	jal	688 <printint>
 8ac:	8bca                	mv	s7,s2
      state = 0;
 8ae:	4981                	li	s3,0
 8b0:	bd7d                	j	76e <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 8b2:	008b8913          	add	s2,s7,8
 8b6:	4681                	li	a3,0
 8b8:	4629                	li	a2,10
 8ba:	000bb583          	ld	a1,0(s7)
 8be:	855a                	mv	a0,s6
 8c0:	dc9ff0ef          	jal	688 <printint>
        i += 1;
 8c4:	2485                	addw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 8c6:	8bca                	mv	s7,s2
      state = 0;
 8c8:	4981                	li	s3,0
        i += 1;
 8ca:	b555                	j	76e <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 8cc:	008b8913          	add	s2,s7,8
 8d0:	4681                	li	a3,0
 8d2:	4629                	li	a2,10
 8d4:	000bb583          	ld	a1,0(s7)
 8d8:	855a                	mv	a0,s6
 8da:	dafff0ef          	jal	688 <printint>
        i += 2;
 8de:	2489                	addw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 8e0:	8bca                	mv	s7,s2
      state = 0;
 8e2:	4981                	li	s3,0
        i += 2;
 8e4:	b569                	j	76e <vprintf+0x4a>
        printint(fd, va_arg(ap, uint32), 16, 0);
 8e6:	008b8913          	add	s2,s7,8
 8ea:	4681                	li	a3,0
 8ec:	4641                	li	a2,16
 8ee:	000be583          	lwu	a1,0(s7)
 8f2:	855a                	mv	a0,s6
 8f4:	d95ff0ef          	jal	688 <printint>
 8f8:	8bca                	mv	s7,s2
      state = 0;
 8fa:	4981                	li	s3,0
 8fc:	bd8d                	j	76e <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 16, 0);
 8fe:	008b8913          	add	s2,s7,8
 902:	4681                	li	a3,0
 904:	4641                	li	a2,16
 906:	000bb583          	ld	a1,0(s7)
 90a:	855a                	mv	a0,s6
 90c:	d7dff0ef          	jal	688 <printint>
        i += 1;
 910:	2485                	addw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 912:	8bca                	mv	s7,s2
      state = 0;
 914:	4981                	li	s3,0
        i += 1;
 916:	bda1                	j	76e <vprintf+0x4a>
 918:	e06a                	sd	s10,0(sp)
        printptr(fd, va_arg(ap, uint64));
 91a:	008b8d13          	add	s10,s7,8
 91e:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 922:	03000593          	li	a1,48
 926:	855a                	mv	a0,s6
 928:	d43ff0ef          	jal	66a <putc>
  putc(fd, 'x');
 92c:	07800593          	li	a1,120
 930:	855a                	mv	a0,s6
 932:	d39ff0ef          	jal	66a <putc>
 936:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 938:	00000b97          	auipc	s7,0x0
 93c:	360b8b93          	add	s7,s7,864 # c98 <digits>
 940:	03c9d793          	srl	a5,s3,0x3c
 944:	97de                	add	a5,a5,s7
 946:	0007c583          	lbu	a1,0(a5)
 94a:	855a                	mv	a0,s6
 94c:	d1fff0ef          	jal	66a <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 950:	0992                	sll	s3,s3,0x4
 952:	397d                	addw	s2,s2,-1
 954:	fe0916e3          	bnez	s2,940 <vprintf+0x21c>
        printptr(fd, va_arg(ap, uint64));
 958:	8bea                	mv	s7,s10
      state = 0;
 95a:	4981                	li	s3,0
 95c:	6d02                	ld	s10,0(sp)
 95e:	bd01                	j	76e <vprintf+0x4a>
        putc(fd, va_arg(ap, uint32));
 960:	008b8913          	add	s2,s7,8
 964:	000bc583          	lbu	a1,0(s7)
 968:	855a                	mv	a0,s6
 96a:	d01ff0ef          	jal	66a <putc>
 96e:	8bca                	mv	s7,s2
      state = 0;
 970:	4981                	li	s3,0
 972:	bbf5                	j	76e <vprintf+0x4a>
        if((s = va_arg(ap, char*)) == 0)
 974:	008b8993          	add	s3,s7,8
 978:	000bb903          	ld	s2,0(s7)
 97c:	00090f63          	beqz	s2,99a <vprintf+0x276>
        for(; *s; s++)
 980:	00094583          	lbu	a1,0(s2)
 984:	c195                	beqz	a1,9a8 <vprintf+0x284>
          putc(fd, *s);
 986:	855a                	mv	a0,s6
 988:	ce3ff0ef          	jal	66a <putc>
        for(; *s; s++)
 98c:	0905                	add	s2,s2,1
 98e:	00094583          	lbu	a1,0(s2)
 992:	f9f5                	bnez	a1,986 <vprintf+0x262>
        if((s = va_arg(ap, char*)) == 0)
 994:	8bce                	mv	s7,s3
      state = 0;
 996:	4981                	li	s3,0
 998:	bbd9                	j	76e <vprintf+0x4a>
          s = "(null)";
 99a:	00000917          	auipc	s2,0x0
 99e:	2f690913          	add	s2,s2,758 # c90 <malloc+0x1ea>
        for(; *s; s++)
 9a2:	02800593          	li	a1,40
 9a6:	b7c5                	j	986 <vprintf+0x262>
        if((s = va_arg(ap, char*)) == 0)
 9a8:	8bce                	mv	s7,s3
      state = 0;
 9aa:	4981                	li	s3,0
 9ac:	b3c9                	j	76e <vprintf+0x4a>
 9ae:	64a6                	ld	s1,72(sp)
 9b0:	79e2                	ld	s3,56(sp)
 9b2:	7a42                	ld	s4,48(sp)
 9b4:	7aa2                	ld	s5,40(sp)
 9b6:	7b02                	ld	s6,32(sp)
 9b8:	6be2                	ld	s7,24(sp)
 9ba:	6c42                	ld	s8,16(sp)
 9bc:	6ca2                	ld	s9,8(sp)
    }
  }
}
 9be:	60e6                	ld	ra,88(sp)
 9c0:	6446                	ld	s0,80(sp)
 9c2:	6906                	ld	s2,64(sp)
 9c4:	6125                	add	sp,sp,96
 9c6:	8082                	ret

00000000000009c8 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 9c8:	715d                	add	sp,sp,-80
 9ca:	ec06                	sd	ra,24(sp)
 9cc:	e822                	sd	s0,16(sp)
 9ce:	1000                	add	s0,sp,32
 9d0:	e010                	sd	a2,0(s0)
 9d2:	e414                	sd	a3,8(s0)
 9d4:	e818                	sd	a4,16(s0)
 9d6:	ec1c                	sd	a5,24(s0)
 9d8:	03043023          	sd	a6,32(s0)
 9dc:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 9e0:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 9e4:	8622                	mv	a2,s0
 9e6:	d3fff0ef          	jal	724 <vprintf>
}
 9ea:	60e2                	ld	ra,24(sp)
 9ec:	6442                	ld	s0,16(sp)
 9ee:	6161                	add	sp,sp,80
 9f0:	8082                	ret

00000000000009f2 <printf>:

void
printf(const char *fmt, ...)
{
 9f2:	711d                	add	sp,sp,-96
 9f4:	ec06                	sd	ra,24(sp)
 9f6:	e822                	sd	s0,16(sp)
 9f8:	1000                	add	s0,sp,32
 9fa:	e40c                	sd	a1,8(s0)
 9fc:	e810                	sd	a2,16(s0)
 9fe:	ec14                	sd	a3,24(s0)
 a00:	f018                	sd	a4,32(s0)
 a02:	f41c                	sd	a5,40(s0)
 a04:	03043823          	sd	a6,48(s0)
 a08:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 a0c:	00840613          	add	a2,s0,8
 a10:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 a14:	85aa                	mv	a1,a0
 a16:	4505                	li	a0,1
 a18:	d0dff0ef          	jal	724 <vprintf>
}
 a1c:	60e2                	ld	ra,24(sp)
 a1e:	6442                	ld	s0,16(sp)
 a20:	6125                	add	sp,sp,96
 a22:	8082                	ret

0000000000000a24 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 a24:	1141                	add	sp,sp,-16
 a26:	e422                	sd	s0,8(sp)
 a28:	0800                	add	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 a2a:	ff050693          	add	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 a2e:	00000797          	auipc	a5,0x0
 a32:	5d27b783          	ld	a5,1490(a5) # 1000 <freep>
 a36:	a02d                	j	a60 <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 a38:	4618                	lw	a4,8(a2)
 a3a:	9f2d                	addw	a4,a4,a1
 a3c:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 a40:	6398                	ld	a4,0(a5)
 a42:	6310                	ld	a2,0(a4)
 a44:	a83d                	j	a82 <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 a46:	ff852703          	lw	a4,-8(a0)
 a4a:	9f31                	addw	a4,a4,a2
 a4c:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 a4e:	ff053683          	ld	a3,-16(a0)
 a52:	a091                	j	a96 <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 a54:	6398                	ld	a4,0(a5)
 a56:	00e7e463          	bltu	a5,a4,a5e <free+0x3a>
 a5a:	00e6ea63          	bltu	a3,a4,a6e <free+0x4a>
{
 a5e:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 a60:	fed7fae3          	bgeu	a5,a3,a54 <free+0x30>
 a64:	6398                	ld	a4,0(a5)
 a66:	00e6e463          	bltu	a3,a4,a6e <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 a6a:	fee7eae3          	bltu	a5,a4,a5e <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 a6e:	ff852583          	lw	a1,-8(a0)
 a72:	6390                	ld	a2,0(a5)
 a74:	02059813          	sll	a6,a1,0x20
 a78:	01c85713          	srl	a4,a6,0x1c
 a7c:	9736                	add	a4,a4,a3
 a7e:	fae60de3          	beq	a2,a4,a38 <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 a82:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 a86:	4790                	lw	a2,8(a5)
 a88:	02061593          	sll	a1,a2,0x20
 a8c:	01c5d713          	srl	a4,a1,0x1c
 a90:	973e                	add	a4,a4,a5
 a92:	fae68ae3          	beq	a3,a4,a46 <free+0x22>
    p->s.ptr = bp->s.ptr;
 a96:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 a98:	00000717          	auipc	a4,0x0
 a9c:	56f73423          	sd	a5,1384(a4) # 1000 <freep>
}
 aa0:	6422                	ld	s0,8(sp)
 aa2:	0141                	add	sp,sp,16
 aa4:	8082                	ret

0000000000000aa6 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 aa6:	7139                	add	sp,sp,-64
 aa8:	fc06                	sd	ra,56(sp)
 aaa:	f822                	sd	s0,48(sp)
 aac:	f426                	sd	s1,40(sp)
 aae:	ec4e                	sd	s3,24(sp)
 ab0:	0080                	add	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 ab2:	02051493          	sll	s1,a0,0x20
 ab6:	9081                	srl	s1,s1,0x20
 ab8:	04bd                	add	s1,s1,15
 aba:	8091                	srl	s1,s1,0x4
 abc:	0014899b          	addw	s3,s1,1
 ac0:	0485                	add	s1,s1,1
  if((prevp = freep) == 0){
 ac2:	00000517          	auipc	a0,0x0
 ac6:	53e53503          	ld	a0,1342(a0) # 1000 <freep>
 aca:	c915                	beqz	a0,afe <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 acc:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 ace:	4798                	lw	a4,8(a5)
 ad0:	08977a63          	bgeu	a4,s1,b64 <malloc+0xbe>
 ad4:	f04a                	sd	s2,32(sp)
 ad6:	e852                	sd	s4,16(sp)
 ad8:	e456                	sd	s5,8(sp)
 ada:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 adc:	8a4e                	mv	s4,s3
 ade:	0009871b          	sext.w	a4,s3
 ae2:	6685                	lui	a3,0x1
 ae4:	00d77363          	bgeu	a4,a3,aea <malloc+0x44>
 ae8:	6a05                	lui	s4,0x1
 aea:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 aee:	004a1a1b          	sllw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 af2:	00000917          	auipc	s2,0x0
 af6:	50e90913          	add	s2,s2,1294 # 1000 <freep>
  if(p == SBRK_ERROR)
 afa:	5afd                	li	s5,-1
 afc:	a081                	j	b3c <malloc+0x96>
 afe:	f04a                	sd	s2,32(sp)
 b00:	e852                	sd	s4,16(sp)
 b02:	e456                	sd	s5,8(sp)
 b04:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 b06:	00000797          	auipc	a5,0x0
 b0a:	50a78793          	add	a5,a5,1290 # 1010 <base>
 b0e:	00000717          	auipc	a4,0x0
 b12:	4ef73923          	sd	a5,1266(a4) # 1000 <freep>
 b16:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 b18:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 b1c:	b7c1                	j	adc <malloc+0x36>
        prevp->s.ptr = p->s.ptr;
 b1e:	6398                	ld	a4,0(a5)
 b20:	e118                	sd	a4,0(a0)
 b22:	a8a9                	j	b7c <malloc+0xd6>
  hp->s.size = nu;
 b24:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 b28:	0541                	add	a0,a0,16
 b2a:	efbff0ef          	jal	a24 <free>
  return freep;
 b2e:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 b32:	c12d                	beqz	a0,b94 <malloc+0xee>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 b34:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 b36:	4798                	lw	a4,8(a5)
 b38:	02977263          	bgeu	a4,s1,b5c <malloc+0xb6>
    if(p == freep)
 b3c:	00093703          	ld	a4,0(s2)
 b40:	853e                	mv	a0,a5
 b42:	fef719e3          	bne	a4,a5,b34 <malloc+0x8e>
  p = sbrk(nu * sizeof(Header));
 b46:	8552                	mv	a0,s4
 b48:	967ff0ef          	jal	4ae <sbrk>
  if(p == SBRK_ERROR)
 b4c:	fd551ce3          	bne	a0,s5,b24 <malloc+0x7e>
        return 0;
 b50:	4501                	li	a0,0
 b52:	7902                	ld	s2,32(sp)
 b54:	6a42                	ld	s4,16(sp)
 b56:	6aa2                	ld	s5,8(sp)
 b58:	6b02                	ld	s6,0(sp)
 b5a:	a03d                	j	b88 <malloc+0xe2>
 b5c:	7902                	ld	s2,32(sp)
 b5e:	6a42                	ld	s4,16(sp)
 b60:	6aa2                	ld	s5,8(sp)
 b62:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 b64:	fae48de3          	beq	s1,a4,b1e <malloc+0x78>
        p->s.size -= nunits;
 b68:	4137073b          	subw	a4,a4,s3
 b6c:	c798                	sw	a4,8(a5)
        p += p->s.size;
 b6e:	02071693          	sll	a3,a4,0x20
 b72:	01c6d713          	srl	a4,a3,0x1c
 b76:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 b78:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 b7c:	00000717          	auipc	a4,0x0
 b80:	48a73223          	sd	a0,1156(a4) # 1000 <freep>
      return (void*)(p + 1);
 b84:	01078513          	add	a0,a5,16
  }
}
 b88:	70e2                	ld	ra,56(sp)
 b8a:	7442                	ld	s0,48(sp)
 b8c:	74a2                	ld	s1,40(sp)
 b8e:	69e2                	ld	s3,24(sp)
 b90:	6121                	add	sp,sp,64
 b92:	8082                	ret
 b94:	7902                	ld	s2,32(sp)
 b96:	6a42                	ld	s4,16(sp)
 b98:	6aa2                	ld	s5,8(sp)
 b9a:	6b02                	ld	s6,0(sp)
 b9c:	b7f5                	j	b88 <malloc+0xe2>
