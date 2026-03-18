
user/_ping:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <parse_ip>:
#include "user/user.h"
#include "kernel/net/socket.h"

uint32_t
parse_ip(char *ip)
{
   0:	7179                	add	sp,sp,-48
   2:	f406                	sd	ra,40(sp)
   4:	f022                	sd	s0,32(sp)
   6:	ec26                	sd	s1,24(sp)
   8:	e84a                	sd	s2,16(sp)
   a:	1800                	add	s0,sp,48
   c:	84aa                	mv	s1,a0
    int a, b, c, d;
    char *p = ip;
    
    a = atoi(p);
   e:	4bc000ef          	jal	4ca <atoi>
  12:	892a                	mv	s2,a0
    p = strchr(p, '.');
  14:	02e00593          	li	a1,46
  18:	8526                	mv	a0,s1
  1a:	3e2000ef          	jal	3fc <strchr>
    if (!p) return 0;
  1e:	c141                	beqz	a0,9e <parse_ip+0x9e>
  20:	e44e                	sd	s3,8(sp)
    p++;
  22:	00150493          	add	s1,a0,1
    
    b = atoi(p);
  26:	8526                	mv	a0,s1
  28:	4a2000ef          	jal	4ca <atoi>
  2c:	89aa                	mv	s3,a0
    p = strchr(p, '.');
  2e:	02e00593          	li	a1,46
  32:	8526                	mv	a0,s1
  34:	3c8000ef          	jal	3fc <strchr>
  38:	87aa                	mv	a5,a0
    if (!p) return 0;
  3a:	4501                	li	a0,0
  3c:	c3bd                	beqz	a5,a2 <parse_ip+0xa2>
  3e:	e052                	sd	s4,0(sp)
    p++;
  40:	00178493          	add	s1,a5,1
    
    c = atoi(p);
  44:	8526                	mv	a0,s1
  46:	484000ef          	jal	4ca <atoi>
  4a:	8a2a                	mv	s4,a0
    p = strchr(p, '.');
  4c:	02e00593          	li	a1,46
  50:	8526                	mv	a0,s1
  52:	3aa000ef          	jal	3fc <strchr>
  56:	872a                	mv	a4,a0
    if (!p) return 0;
  58:	4501                	li	a0,0
  5a:	c731                	beqz	a4,a6 <parse_ip+0xa6>
    p++;
    
    d = atoi(p);
  5c:	00170513          	add	a0,a4,1
  60:	46a000ef          	jal	4ca <atoi>
    
    return ((a & 0xff) | ((b & 0xff) << 8) | ((c & 0xff) << 16) | ((d & 0xff) << 24));
  64:	0089979b          	sllw	a5,s3,0x8
  68:	6741                	lui	a4,0x10
  6a:	f0070713          	add	a4,a4,-256 # ff00 <base+0xeef0>
  6e:	8ff9                	and	a5,a5,a4
  70:	0ff97913          	zext.b	s2,s2
  74:	0127e7b3          	or	a5,a5,s2
  78:	010a171b          	sllw	a4,s4,0x10
  7c:	00ff06b7          	lui	a3,0xff0
  80:	8f75                	and	a4,a4,a3
  82:	8fd9                	or	a5,a5,a4
  84:	0185151b          	sllw	a0,a0,0x18
  88:	8fc9                	or	a5,a5,a0
  8a:	0007851b          	sext.w	a0,a5
  8e:	69a2                	ld	s3,8(sp)
  90:	6a02                	ld	s4,0(sp)
}
  92:	70a2                	ld	ra,40(sp)
  94:	7402                	ld	s0,32(sp)
  96:	64e2                	ld	s1,24(sp)
  98:	6942                	ld	s2,16(sp)
  9a:	6145                	add	sp,sp,48
  9c:	8082                	ret
    if (!p) return 0;
  9e:	4501                	li	a0,0
  a0:	bfcd                	j	92 <parse_ip+0x92>
  a2:	69a2                	ld	s3,8(sp)
  a4:	b7fd                	j	92 <parse_ip+0x92>
  a6:	69a2                	ld	s3,8(sp)
  a8:	6a02                	ld	s4,0(sp)
  aa:	b7e5                	j	92 <parse_ip+0x92>

00000000000000ac <main>:

int
main(int argc, char *argv[])
{
  ac:	7169                	add	sp,sp,-304
  ae:	f606                	sd	ra,296(sp)
  b0:	f222                	sd	s0,288(sp)
  b2:	1a00                	add	s0,sp,304
    int sock;
    struct sockaddr_in dest, src;
    char sendbuf[64] = "PING";
  b4:	474e57b7          	lui	a5,0x474e5
  b8:	95078793          	add	a5,a5,-1712 # 474e4950 <base+0x474e3940>
  bc:	f6f43023          	sd	a5,-160(s0)
  c0:	f6043423          	sd	zero,-152(s0)
  c4:	f6043823          	sd	zero,-144(s0)
  c8:	f6043c23          	sd	zero,-136(s0)
  cc:	f8043023          	sd	zero,-128(s0)
  d0:	f8043423          	sd	zero,-120(s0)
  d4:	f8043823          	sd	zero,-112(s0)
  d8:	f8043c23          	sd	zero,-104(s0)
    int ret, addrlen;
    uint32_t start, end;
    uint32_t dst_ip;
    int port = 9999;
    
    if (argc < 2) {
  dc:	4785                	li	a5,1
  de:	02a7dc63          	bge	a5,a0,116 <main+0x6a>
  e2:	ee26                	sd	s1,280(sp)
  e4:	ea4a                	sd	s2,272(sp)
  e6:	e64e                	sd	s3,264(sp)
  e8:	e252                	sd	s4,256(sp)
  ea:	fdd6                	sd	s5,248(sp)
  ec:	f9da                	sd	s6,240(sp)
  ee:	f5de                	sd	s7,232(sp)
  f0:	f1e2                	sd	s8,224(sp)
  f2:	84ae                	mv	s1,a1
        printf("Usage: ping <IP address>\n");
        printf("Example: ping 10.0.2.2\n");
        exit(1);
    }

    dst_ip = parse_ip(argv[1]);
  f4:	6588                	ld	a0,8(a1)
  f6:	f0bff0ef          	jal	0 <parse_ip>
  fa:	0005091b          	sext.w	s2,a0
    if (dst_ip == 0) {
  fe:	04091363          	bnez	s2,144 <main+0x98>
        printf("ping: invalid IP address: %s\n", argv[1]);
 102:	648c                	ld	a1,8(s1)
 104:	00001517          	auipc	a0,0x1
 108:	be450513          	add	a0,a0,-1052 # ce8 <malloc+0x138>
 10c:	1f1000ef          	jal	afc <printf>
        exit(1);
 110:	4505                	li	a0,1
 112:	57a000ef          	jal	68c <exit>
 116:	ee26                	sd	s1,280(sp)
 118:	ea4a                	sd	s2,272(sp)
 11a:	e64e                	sd	s3,264(sp)
 11c:	e252                	sd	s4,256(sp)
 11e:	fdd6                	sd	s5,248(sp)
 120:	f9da                	sd	s6,240(sp)
 122:	f5de                	sd	s7,232(sp)
 124:	f1e2                	sd	s8,224(sp)
        printf("Usage: ping <IP address>\n");
 126:	00001517          	auipc	a0,0x1
 12a:	b8a50513          	add	a0,a0,-1142 # cb0 <malloc+0x100>
 12e:	1cf000ef          	jal	afc <printf>
        printf("Example: ping 10.0.2.2\n");
 132:	00001517          	auipc	a0,0x1
 136:	b9e50513          	add	a0,a0,-1122 # cd0 <malloc+0x120>
 13a:	1c3000ef          	jal	afc <printf>
        exit(1);
 13e:	4505                	li	a0,1
 140:	54c000ef          	jal	68c <exit>
    }

    printf("PING %s: 56 data bytes\n", argv[1]);
 144:	648c                	ld	a1,8(s1)
 146:	00001517          	auipc	a0,0x1
 14a:	bc250513          	add	a0,a0,-1086 # d08 <malloc+0x158>
 14e:	1af000ef          	jal	afc <printf>

    sock = socket(PF_INET, SOCK_DGRAM, IPPROTO_UDP);
 152:	4601                	li	a2,0
 154:	4585                	li	a1,1
 156:	4505                	li	a0,1
 158:	5d4000ef          	jal	72c <socket>
 15c:	89aa                	mv	s3,a0
    if (sock < 0) {
 15e:	06054363          	bltz	a0,1c4 <main+0x118>
        printf("ping: socket failed\n");
        exit(1);
    }

    dest.sin_family = AF_INET;
 162:	4485                	li	s1,1
 164:	fa941423          	sh	s1,-88(s0)
    dest.sin_addr.s_addr = htonl(dst_ip);
 168:	02091513          	sll	a0,s2,0x20
 16c:	9101                	srl	a0,a0,0x20
 16e:	4aa000ef          	jal	618 <htonl>
 172:	faa42623          	sw	a0,-84(s0)
    dest.sin_port = htons(port);
 176:	6509                	lui	a0,0x2
 178:	70f50513          	add	a0,a0,1807 # 270f <base+0x16ff>
 17c:	468000ef          	jal	5e4 <htons>
 180:	faa41523          	sh	a0,-86(s0)

    src.sin_family = AF_INET;
 184:	fa941023          	sh	s1,-96(s0)
    src.sin_addr.s_addr = INADDR_ANY;
 188:	fa042223          	sw	zero,-92(s0)
    src.sin_port = htons(port);
 18c:	6509                	lui	a0,0x2
 18e:	70f50513          	add	a0,a0,1807 # 270f <base+0x16ff>
 192:	452000ef          	jal	5e4 <htons>
 196:	faa41123          	sh	a0,-94(s0)
    
    if (bind(sock, (struct sockaddr *)&src, sizeof(src)) < 0) {
 19a:	4621                	li	a2,8
 19c:	fa040593          	add	a1,s0,-96
 1a0:	854e                	mv	a0,s3
 1a2:	592000ef          	jal	734 <bind>
        printf("ping: bind failed\n");
        close(sock);
        exit(1);
    }

    for (int i = 0; i < 4; i++) {
 1a6:	4a01                	li	s4,0
    if (bind(sock, (struct sockaddr *)&src, sizeof(src)) < 0) {
 1a8:	02054763          	bltz	a0,1d6 <main+0x12a>
                   (ip >> 8) & 0xff,
                   (ip >> 16) & 0xff,
                   (ip >> 24) & 0xff,
                   i, end - start);
        } else {
            printf("Request timeout for icmp_seq %d\n", i);
 1ac:	00001b17          	auipc	s6,0x1
 1b0:	bf4b0b13          	add	s6,s6,-1036 # da0 <malloc+0x1f0>
            printf("%d bytes from %d.%d.%d.%d: icmp_seq=%d time=%d ms\n",
 1b4:	00001a97          	auipc	s5,0x1
 1b8:	bb4a8a93          	add	s5,s5,-1100 # d68 <malloc+0x1b8>
        }

        for (volatile int j = 0; j < 100000; j++);
 1bc:	64e1                	lui	s1,0x18
 1be:	69f48493          	add	s1,s1,1695 # 1869f <base+0x1768f>
 1c2:	a871                	j	25e <main+0x1b2>
        printf("ping: socket failed\n");
 1c4:	00001517          	auipc	a0,0x1
 1c8:	b5c50513          	add	a0,a0,-1188 # d20 <malloc+0x170>
 1cc:	131000ef          	jal	afc <printf>
        exit(1);
 1d0:	4505                	li	a0,1
 1d2:	4ba000ef          	jal	68c <exit>
        printf("ping: bind failed\n");
 1d6:	00001517          	auipc	a0,0x1
 1da:	b6250513          	add	a0,a0,-1182 # d38 <malloc+0x188>
 1de:	11f000ef          	jal	afc <printf>
        close(sock);
 1e2:	854e                	mv	a0,s3
 1e4:	4d0000ef          	jal	6b4 <close>
        exit(1);
 1e8:	4505                	li	a0,1
 1ea:	4a2000ef          	jal	68c <exit>
            printf("ping: sendto failed\n");
 1ee:	00001517          	auipc	a0,0x1
 1f2:	b6250513          	add	a0,a0,-1182 # d50 <malloc+0x1a0>
 1f6:	107000ef          	jal	afc <printf>
            close(sock);
 1fa:	854e                	mv	a0,s3
 1fc:	4b8000ef          	jal	6b4 <close>
            exit(1);
 200:	4505                	li	a0,1
 202:	48a000ef          	jal	68c <exit>
            uint32_t ip = ntohl(src.sin_addr.s_addr);
 206:	fa446503          	lwu	a0,-92(s0)
 20a:	444000ef          	jal	64e <ntohl>
                   (ip >> 16) & 0xff,
 20e:	0105571b          	srlw	a4,a0,0x10
                   (ip >> 8) & 0xff,
 212:	0085569b          	srlw	a3,a0,0x8
            printf("%d bytes from %d.%d.%d.%d: icmp_seq=%d time=%d ms\n",
 216:	418b88bb          	subw	a7,s7,s8
 21a:	8852                	mv	a6,s4
 21c:	0185579b          	srlw	a5,a0,0x18
 220:	0ff77713          	zext.b	a4,a4
 224:	0ff6f693          	zext.b	a3,a3
 228:	0ff57613          	zext.b	a2,a0
 22c:	85ca                	mv	a1,s2
 22e:	8556                	mv	a0,s5
 230:	0cd000ef          	jal	afc <printf>
        for (volatile int j = 0; j < 100000; j++);
 234:	ec042c23          	sw	zero,-296(s0)
 238:	ed842783          	lw	a5,-296(s0)
 23c:	2781                	sext.w	a5,a5
 23e:	00f4cc63          	blt	s1,a5,256 <main+0x1aa>
 242:	ed842783          	lw	a5,-296(s0)
 246:	2785                	addw	a5,a5,1
 248:	ecf42c23          	sw	a5,-296(s0)
 24c:	ed842783          	lw	a5,-296(s0)
 250:	2781                	sext.w	a5,a5
 252:	fef4d8e3          	bge	s1,a5,242 <main+0x196>
    for (int i = 0; i < 4; i++) {
 256:	2a05                	addw	s4,s4,1
 258:	4791                	li	a5,4
 25a:	04fa0c63          	beq	s4,a5,2b2 <main+0x206>
        start = uptime();
 25e:	4c6000ef          	jal	724 <uptime>
 262:	8c2a                	mv	s8,a0
        ret = sendto(sock, sendbuf, sizeof(sendbuf), 0, 
 264:	47a1                	li	a5,8
 266:	fa840713          	add	a4,s0,-88
 26a:	4681                	li	a3,0
 26c:	04000613          	li	a2,64
 270:	f6040593          	add	a1,s0,-160
 274:	854e                	mv	a0,s3
 276:	4ee000ef          	jal	764 <sendto>
        if (ret < 0) {
 27a:	f6054ae3          	bltz	a0,1ee <main+0x142>
        addrlen = sizeof(src);
 27e:	47a1                	li	a5,8
 280:	ecf42e23          	sw	a5,-292(s0)
        ret = recvfrom(sock, recvbuf, sizeof(recvbuf), 0,
 284:	edc40793          	add	a5,s0,-292
 288:	fa040713          	add	a4,s0,-96
 28c:	4681                	li	a3,0
 28e:	08000613          	li	a2,128
 292:	ee040593          	add	a1,s0,-288
 296:	854e                	mv	a0,s3
 298:	4d4000ef          	jal	76c <recvfrom>
 29c:	892a                	mv	s2,a0
        end = uptime();
 29e:	486000ef          	jal	724 <uptime>
 2a2:	8baa                	mv	s7,a0
        if (ret > 0) {
 2a4:	f72041e3          	bgtz	s2,206 <main+0x15a>
            printf("Request timeout for icmp_seq %d\n", i);
 2a8:	85d2                	mv	a1,s4
 2aa:	855a                	mv	a0,s6
 2ac:	051000ef          	jal	afc <printf>
 2b0:	b751                	j	234 <main+0x188>
    }

    close(sock);
 2b2:	854e                	mv	a0,s3
 2b4:	400000ef          	jal	6b4 <close>
    exit(0);
 2b8:	4501                	li	a0,0
 2ba:	3d2000ef          	jal	68c <exit>

00000000000002be <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start(int argc, char **argv)
{
 2be:	1141                	add	sp,sp,-16
 2c0:	e406                	sd	ra,8(sp)
 2c2:	e022                	sd	s0,0(sp)
 2c4:	0800                	add	s0,sp,16
  int r;
  extern int main(int argc, char **argv);
  r = main(argc, argv);
 2c6:	de7ff0ef          	jal	ac <main>
  exit(r);
 2ca:	3c2000ef          	jal	68c <exit>

00000000000002ce <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
 2ce:	1141                	add	sp,sp,-16
 2d0:	e422                	sd	s0,8(sp)
 2d2:	0800                	add	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 2d4:	87aa                	mv	a5,a0
 2d6:	0585                	add	a1,a1,1
 2d8:	0785                	add	a5,a5,1
 2da:	fff5c703          	lbu	a4,-1(a1)
 2de:	fee78fa3          	sb	a4,-1(a5)
 2e2:	fb75                	bnez	a4,2d6 <strcpy+0x8>
    ;
  return os;
}
 2e4:	6422                	ld	s0,8(sp)
 2e6:	0141                	add	sp,sp,16
 2e8:	8082                	ret

00000000000002ea <strcmp>:

int
strcmp(const char *p, const char *q)
{
 2ea:	1141                	add	sp,sp,-16
 2ec:	e422                	sd	s0,8(sp)
 2ee:	0800                	add	s0,sp,16
  while(*p && *p == *q)
 2f0:	00054783          	lbu	a5,0(a0)
 2f4:	cb91                	beqz	a5,308 <strcmp+0x1e>
 2f6:	0005c703          	lbu	a4,0(a1)
 2fa:	00f71763          	bne	a4,a5,308 <strcmp+0x1e>
    p++, q++;
 2fe:	0505                	add	a0,a0,1
 300:	0585                	add	a1,a1,1
  while(*p && *p == *q)
 302:	00054783          	lbu	a5,0(a0)
 306:	fbe5                	bnez	a5,2f6 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 308:	0005c503          	lbu	a0,0(a1)
}
 30c:	40a7853b          	subw	a0,a5,a0
 310:	6422                	ld	s0,8(sp)
 312:	0141                	add	sp,sp,16
 314:	8082                	ret

0000000000000316 <strncmp>:

int
strncmp(const char *p, const char *q, uint n)
{
 316:	1141                	add	sp,sp,-16
 318:	e422                	sd	s0,8(sp)
 31a:	0800                	add	s0,sp,16
  while(n > 0 && *p && *p == *q) {
 31c:	ce11                	beqz	a2,338 <strncmp+0x22>
 31e:	00054783          	lbu	a5,0(a0)
 322:	cf89                	beqz	a5,33c <strncmp+0x26>
 324:	0005c703          	lbu	a4,0(a1)
 328:	00f71a63          	bne	a4,a5,33c <strncmp+0x26>
    p++, q++, n--;
 32c:	0505                	add	a0,a0,1
 32e:	0585                	add	a1,a1,1
 330:	367d                	addw	a2,a2,-1
  while(n > 0 && *p && *p == *q) {
 332:	f675                	bnez	a2,31e <strncmp+0x8>
  }
  if (n == 0)
    return 0;
 334:	4501                	li	a0,0
 336:	a801                	j	346 <strncmp+0x30>
 338:	4501                	li	a0,0
 33a:	a031                	j	346 <strncmp+0x30>
  return (uchar)*p - (uchar)*q;
 33c:	00054503          	lbu	a0,0(a0)
 340:	0005c783          	lbu	a5,0(a1)
 344:	9d1d                	subw	a0,a0,a5
}
 346:	6422                	ld	s0,8(sp)
 348:	0141                	add	sp,sp,16
 34a:	8082                	ret

000000000000034c <strcat>:

char*
strcat(char *dst, const char *src)
{
 34c:	1141                	add	sp,sp,-16
 34e:	e422                	sd	s0,8(sp)
 350:	0800                	add	s0,sp,16
  char *p = dst;
  while(*p) p++;
 352:	00054783          	lbu	a5,0(a0)
 356:	c385                	beqz	a5,376 <strcat+0x2a>
  char *p = dst;
 358:	87aa                	mv	a5,a0
  while(*p) p++;
 35a:	0785                	add	a5,a5,1
 35c:	0007c703          	lbu	a4,0(a5)
 360:	ff6d                	bnez	a4,35a <strcat+0xe>
  while((*p++ = *src++) != 0);
 362:	0585                	add	a1,a1,1
 364:	0785                	add	a5,a5,1
 366:	fff5c703          	lbu	a4,-1(a1)
 36a:	fee78fa3          	sb	a4,-1(a5)
 36e:	fb75                	bnez	a4,362 <strcat+0x16>
  return dst;
}
 370:	6422                	ld	s0,8(sp)
 372:	0141                	add	sp,sp,16
 374:	8082                	ret
  char *p = dst;
 376:	87aa                	mv	a5,a0
 378:	b7ed                	j	362 <strcat+0x16>

000000000000037a <strncpy>:

char*
strncpy(char *dst, const char *src, int n)
{
 37a:	1141                	add	sp,sp,-16
 37c:	e422                	sd	s0,8(sp)
 37e:	0800                	add	s0,sp,16
  char *p = dst;
 380:	87aa                	mv	a5,a0
  while(n > 0 && *src) {
 382:	02c05463          	blez	a2,3aa <strncpy+0x30>
 386:	0005c703          	lbu	a4,0(a1)
 38a:	cb01                	beqz	a4,39a <strncpy+0x20>
    *p++ = *src++;
 38c:	0585                	add	a1,a1,1
 38e:	0785                	add	a5,a5,1
 390:	fee78fa3          	sb	a4,-1(a5)
    n--;
 394:	367d                	addw	a2,a2,-1
  while(n > 0 && *src) {
 396:	fa65                	bnez	a2,386 <strncpy+0xc>
 398:	a809                	j	3aa <strncpy+0x30>
  }
  while(n > 0) {
 39a:	1602                	sll	a2,a2,0x20
 39c:	9201                	srl	a2,a2,0x20
 39e:	963e                	add	a2,a2,a5
    *p++ = 0;
 3a0:	0785                	add	a5,a5,1
 3a2:	fe078fa3          	sb	zero,-1(a5)
  while(n > 0) {
 3a6:	fec79de3          	bne	a5,a2,3a0 <strncpy+0x26>
    n--;
  }
  return dst;
}
 3aa:	6422                	ld	s0,8(sp)
 3ac:	0141                	add	sp,sp,16
 3ae:	8082                	ret

00000000000003b0 <strlen>:

uint
strlen(const char *s)
{
 3b0:	1141                	add	sp,sp,-16
 3b2:	e422                	sd	s0,8(sp)
 3b4:	0800                	add	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 3b6:	00054783          	lbu	a5,0(a0)
 3ba:	cf91                	beqz	a5,3d6 <strlen+0x26>
 3bc:	0505                	add	a0,a0,1
 3be:	87aa                	mv	a5,a0
 3c0:	86be                	mv	a3,a5
 3c2:	0785                	add	a5,a5,1
 3c4:	fff7c703          	lbu	a4,-1(a5)
 3c8:	ff65                	bnez	a4,3c0 <strlen+0x10>
 3ca:	40a6853b          	subw	a0,a3,a0
 3ce:	2505                	addw	a0,a0,1
    ;
  return n;
}
 3d0:	6422                	ld	s0,8(sp)
 3d2:	0141                	add	sp,sp,16
 3d4:	8082                	ret
  for(n = 0; s[n]; n++)
 3d6:	4501                	li	a0,0
 3d8:	bfe5                	j	3d0 <strlen+0x20>

00000000000003da <memset>:

void*
memset(void *dst, int c, uint n)
{
 3da:	1141                	add	sp,sp,-16
 3dc:	e422                	sd	s0,8(sp)
 3de:	0800                	add	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 3e0:	ca19                	beqz	a2,3f6 <memset+0x1c>
 3e2:	87aa                	mv	a5,a0
 3e4:	1602                	sll	a2,a2,0x20
 3e6:	9201                	srl	a2,a2,0x20
 3e8:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 3ec:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 3f0:	0785                	add	a5,a5,1
 3f2:	fee79de3          	bne	a5,a4,3ec <memset+0x12>
  }
  return dst;
}
 3f6:	6422                	ld	s0,8(sp)
 3f8:	0141                	add	sp,sp,16
 3fa:	8082                	ret

00000000000003fc <strchr>:

char*
strchr(const char *s, char c)
{
 3fc:	1141                	add	sp,sp,-16
 3fe:	e422                	sd	s0,8(sp)
 400:	0800                	add	s0,sp,16
  for(; *s; s++)
 402:	00054783          	lbu	a5,0(a0)
 406:	cb99                	beqz	a5,41c <strchr+0x20>
    if(*s == c)
 408:	00f58763          	beq	a1,a5,416 <strchr+0x1a>
  for(; *s; s++)
 40c:	0505                	add	a0,a0,1
 40e:	00054783          	lbu	a5,0(a0)
 412:	fbfd                	bnez	a5,408 <strchr+0xc>
      return (char*)s;
  return 0;
 414:	4501                	li	a0,0
}
 416:	6422                	ld	s0,8(sp)
 418:	0141                	add	sp,sp,16
 41a:	8082                	ret
  return 0;
 41c:	4501                	li	a0,0
 41e:	bfe5                	j	416 <strchr+0x1a>

0000000000000420 <gets>:

char*
gets(char *buf, int max)
{
 420:	711d                	add	sp,sp,-96
 422:	ec86                	sd	ra,88(sp)
 424:	e8a2                	sd	s0,80(sp)
 426:	e4a6                	sd	s1,72(sp)
 428:	e0ca                	sd	s2,64(sp)
 42a:	fc4e                	sd	s3,56(sp)
 42c:	f852                	sd	s4,48(sp)
 42e:	f456                	sd	s5,40(sp)
 430:	f05a                	sd	s6,32(sp)
 432:	ec5e                	sd	s7,24(sp)
 434:	1080                	add	s0,sp,96
 436:	8baa                	mv	s7,a0
 438:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 43a:	892a                	mv	s2,a0
 43c:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 43e:	4aa9                	li	s5,10
 440:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 442:	89a6                	mv	s3,s1
 444:	2485                	addw	s1,s1,1
 446:	0344d663          	bge	s1,s4,472 <gets+0x52>
    cc = read(0, &c, 1);
 44a:	4605                	li	a2,1
 44c:	faf40593          	add	a1,s0,-81
 450:	4501                	li	a0,0
 452:	252000ef          	jal	6a4 <read>
    if(cc < 1)
 456:	00a05e63          	blez	a0,472 <gets+0x52>
    buf[i++] = c;
 45a:	faf44783          	lbu	a5,-81(s0)
 45e:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 462:	01578763          	beq	a5,s5,470 <gets+0x50>
 466:	0905                	add	s2,s2,1
 468:	fd679de3          	bne	a5,s6,442 <gets+0x22>
    buf[i++] = c;
 46c:	89a6                	mv	s3,s1
 46e:	a011                	j	472 <gets+0x52>
 470:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 472:	99de                	add	s3,s3,s7
 474:	00098023          	sb	zero,0(s3)
  return buf;
}
 478:	855e                	mv	a0,s7
 47a:	60e6                	ld	ra,88(sp)
 47c:	6446                	ld	s0,80(sp)
 47e:	64a6                	ld	s1,72(sp)
 480:	6906                	ld	s2,64(sp)
 482:	79e2                	ld	s3,56(sp)
 484:	7a42                	ld	s4,48(sp)
 486:	7aa2                	ld	s5,40(sp)
 488:	7b02                	ld	s6,32(sp)
 48a:	6be2                	ld	s7,24(sp)
 48c:	6125                	add	sp,sp,96
 48e:	8082                	ret

0000000000000490 <stat>:

int
stat(const char *n, struct stat *st)
{
 490:	1101                	add	sp,sp,-32
 492:	ec06                	sd	ra,24(sp)
 494:	e822                	sd	s0,16(sp)
 496:	e04a                	sd	s2,0(sp)
 498:	1000                	add	s0,sp,32
 49a:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 49c:	4581                	li	a1,0
 49e:	22e000ef          	jal	6cc <open>
  if(fd < 0)
 4a2:	02054263          	bltz	a0,4c6 <stat+0x36>
 4a6:	e426                	sd	s1,8(sp)
 4a8:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 4aa:	85ca                	mv	a1,s2
 4ac:	238000ef          	jal	6e4 <fstat>
 4b0:	892a                	mv	s2,a0
  close(fd);
 4b2:	8526                	mv	a0,s1
 4b4:	200000ef          	jal	6b4 <close>
  return r;
 4b8:	64a2                	ld	s1,8(sp)
}
 4ba:	854a                	mv	a0,s2
 4bc:	60e2                	ld	ra,24(sp)
 4be:	6442                	ld	s0,16(sp)
 4c0:	6902                	ld	s2,0(sp)
 4c2:	6105                	add	sp,sp,32
 4c4:	8082                	ret
    return -1;
 4c6:	597d                	li	s2,-1
 4c8:	bfcd                	j	4ba <stat+0x2a>

00000000000004ca <atoi>:

int
atoi(const char *s)
{
 4ca:	1141                	add	sp,sp,-16
 4cc:	e422                	sd	s0,8(sp)
 4ce:	0800                	add	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 4d0:	00054683          	lbu	a3,0(a0)
 4d4:	fd06879b          	addw	a5,a3,-48 # feffd0 <base+0xfeefc0>
 4d8:	0ff7f793          	zext.b	a5,a5
 4dc:	4625                	li	a2,9
 4de:	02f66863          	bltu	a2,a5,50e <atoi+0x44>
 4e2:	872a                	mv	a4,a0
  n = 0;
 4e4:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 4e6:	0705                	add	a4,a4,1
 4e8:	0025179b          	sllw	a5,a0,0x2
 4ec:	9fa9                	addw	a5,a5,a0
 4ee:	0017979b          	sllw	a5,a5,0x1
 4f2:	9fb5                	addw	a5,a5,a3
 4f4:	fd07851b          	addw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 4f8:	00074683          	lbu	a3,0(a4)
 4fc:	fd06879b          	addw	a5,a3,-48
 500:	0ff7f793          	zext.b	a5,a5
 504:	fef671e3          	bgeu	a2,a5,4e6 <atoi+0x1c>
  return n;
}
 508:	6422                	ld	s0,8(sp)
 50a:	0141                	add	sp,sp,16
 50c:	8082                	ret
  n = 0;
 50e:	4501                	li	a0,0
 510:	bfe5                	j	508 <atoi+0x3e>

0000000000000512 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 512:	1141                	add	sp,sp,-16
 514:	e422                	sd	s0,8(sp)
 516:	0800                	add	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 518:	02b57463          	bgeu	a0,a1,540 <memmove+0x2e>
    while(n-- > 0)
 51c:	00c05f63          	blez	a2,53a <memmove+0x28>
 520:	1602                	sll	a2,a2,0x20
 522:	9201                	srl	a2,a2,0x20
 524:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 528:	872a                	mv	a4,a0
      *dst++ = *src++;
 52a:	0585                	add	a1,a1,1
 52c:	0705                	add	a4,a4,1
 52e:	fff5c683          	lbu	a3,-1(a1)
 532:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 536:	fef71ae3          	bne	a4,a5,52a <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 53a:	6422                	ld	s0,8(sp)
 53c:	0141                	add	sp,sp,16
 53e:	8082                	ret
    dst += n;
 540:	00c50733          	add	a4,a0,a2
    src += n;
 544:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 546:	fec05ae3          	blez	a2,53a <memmove+0x28>
 54a:	fff6079b          	addw	a5,a2,-1
 54e:	1782                	sll	a5,a5,0x20
 550:	9381                	srl	a5,a5,0x20
 552:	fff7c793          	not	a5,a5
 556:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 558:	15fd                	add	a1,a1,-1
 55a:	177d                	add	a4,a4,-1
 55c:	0005c683          	lbu	a3,0(a1)
 560:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 564:	fee79ae3          	bne	a5,a4,558 <memmove+0x46>
 568:	bfc9                	j	53a <memmove+0x28>

000000000000056a <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 56a:	1141                	add	sp,sp,-16
 56c:	e422                	sd	s0,8(sp)
 56e:	0800                	add	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 570:	ca05                	beqz	a2,5a0 <memcmp+0x36>
 572:	fff6069b          	addw	a3,a2,-1
 576:	1682                	sll	a3,a3,0x20
 578:	9281                	srl	a3,a3,0x20
 57a:	0685                	add	a3,a3,1
 57c:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 57e:	00054783          	lbu	a5,0(a0)
 582:	0005c703          	lbu	a4,0(a1)
 586:	00e79863          	bne	a5,a4,596 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 58a:	0505                	add	a0,a0,1
    p2++;
 58c:	0585                	add	a1,a1,1
  while (n-- > 0) {
 58e:	fed518e3          	bne	a0,a3,57e <memcmp+0x14>
  }
  return 0;
 592:	4501                	li	a0,0
 594:	a019                	j	59a <memcmp+0x30>
      return *p1 - *p2;
 596:	40e7853b          	subw	a0,a5,a4
}
 59a:	6422                	ld	s0,8(sp)
 59c:	0141                	add	sp,sp,16
 59e:	8082                	ret
  return 0;
 5a0:	4501                	li	a0,0
 5a2:	bfe5                	j	59a <memcmp+0x30>

00000000000005a4 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 5a4:	1141                	add	sp,sp,-16
 5a6:	e406                	sd	ra,8(sp)
 5a8:	e022                	sd	s0,0(sp)
 5aa:	0800                	add	s0,sp,16
  return memmove(dst, src, n);
 5ac:	f67ff0ef          	jal	512 <memmove>
}
 5b0:	60a2                	ld	ra,8(sp)
 5b2:	6402                	ld	s0,0(sp)
 5b4:	0141                	add	sp,sp,16
 5b6:	8082                	ret

00000000000005b8 <sbrk>:

char *
sbrk(int n) {
 5b8:	1141                	add	sp,sp,-16
 5ba:	e406                	sd	ra,8(sp)
 5bc:	e022                	sd	s0,0(sp)
 5be:	0800                	add	s0,sp,16
  return sys_sbrk(n, SBRK_EAGER);
 5c0:	4585                	li	a1,1
 5c2:	152000ef          	jal	714 <sys_sbrk>
}
 5c6:	60a2                	ld	ra,8(sp)
 5c8:	6402                	ld	s0,0(sp)
 5ca:	0141                	add	sp,sp,16
 5cc:	8082                	ret

00000000000005ce <sbrklazy>:

char *
sbrklazy(int n) {
 5ce:	1141                	add	sp,sp,-16
 5d0:	e406                	sd	ra,8(sp)
 5d2:	e022                	sd	s0,0(sp)
 5d4:	0800                	add	s0,sp,16
  return sys_sbrk(n, SBRK_LAZY);
 5d6:	4589                	li	a1,2
 5d8:	13c000ef          	jal	714 <sys_sbrk>
}
 5dc:	60a2                	ld	ra,8(sp)
 5de:	6402                	ld	s0,0(sp)
 5e0:	0141                	add	sp,sp,16
 5e2:	8082                	ret

00000000000005e4 <htons>:

// Byte order conversion functions
unsigned short
htons(unsigned short hostshort)
{
 5e4:	1141                	add	sp,sp,-16
 5e6:	e422                	sd	s0,8(sp)
 5e8:	0800                	add	s0,sp,16
  return ((hostshort >> 8) & 0xff) | ((hostshort & 0xff) << 8);
 5ea:	0085179b          	sllw	a5,a0,0x8
 5ee:	0085551b          	srlw	a0,a0,0x8
 5f2:	8d5d                	or	a0,a0,a5
}
 5f4:	1542                	sll	a0,a0,0x30
 5f6:	9141                	srl	a0,a0,0x30
 5f8:	6422                	ld	s0,8(sp)
 5fa:	0141                	add	sp,sp,16
 5fc:	8082                	ret

00000000000005fe <ntohs>:

unsigned short
ntohs(unsigned short netshort)
{
 5fe:	1141                	add	sp,sp,-16
 600:	e422                	sd	s0,8(sp)
 602:	0800                	add	s0,sp,16
  return ((netshort >> 8) & 0xff) | ((netshort & 0xff) << 8);
 604:	0085179b          	sllw	a5,a0,0x8
 608:	0085551b          	srlw	a0,a0,0x8
 60c:	8d5d                	or	a0,a0,a5
}
 60e:	1542                	sll	a0,a0,0x30
 610:	9141                	srl	a0,a0,0x30
 612:	6422                	ld	s0,8(sp)
 614:	0141                	add	sp,sp,16
 616:	8082                	ret

0000000000000618 <htonl>:

unsigned long
htonl(unsigned long hostlong)
{
 618:	1141                	add	sp,sp,-16
 61a:	e422                	sd	s0,8(sp)
 61c:	0800                	add	s0,sp,16
  return ((hostlong >> 24) & 0xff) |
 61e:	0185579b          	srlw	a5,a0,0x18
         ((hostlong >> 8) & 0xff00) |
 622:	00855713          	srl	a4,a0,0x8
 626:	66c1                	lui	a3,0x10
 628:	f0068693          	add	a3,a3,-256 # ff00 <base+0xeef0>
 62c:	8f75                	and	a4,a4,a3
  return ((hostlong >> 24) & 0xff) |
 62e:	8fd9                	or	a5,a5,a4
         ((hostlong & 0xff00) << 8) |
 630:	00851713          	sll	a4,a0,0x8
 634:	00ff06b7          	lui	a3,0xff0
 638:	8f75                	and	a4,a4,a3
         ((hostlong >> 8) & 0xff00) |
 63a:	8fd9                	or	a5,a5,a4
         ((hostlong & 0xff) << 24);
 63c:	0562                	sll	a0,a0,0x18
 63e:	0ff00713          	li	a4,255
 642:	0762                	sll	a4,a4,0x18
 644:	8d79                	and	a0,a0,a4
}
 646:	8d5d                	or	a0,a0,a5
 648:	6422                	ld	s0,8(sp)
 64a:	0141                	add	sp,sp,16
 64c:	8082                	ret

000000000000064e <ntohl>:

unsigned long
ntohl(unsigned long netlong)
{
 64e:	1141                	add	sp,sp,-16
 650:	e422                	sd	s0,8(sp)
 652:	0800                	add	s0,sp,16
  return ((netlong >> 24) & 0xff) |
 654:	0185579b          	srlw	a5,a0,0x18
         ((netlong >> 8) & 0xff00) |
 658:	00855713          	srl	a4,a0,0x8
 65c:	66c1                	lui	a3,0x10
 65e:	f0068693          	add	a3,a3,-256 # ff00 <base+0xeef0>
 662:	8f75                	and	a4,a4,a3
  return ((netlong >> 24) & 0xff) |
 664:	8fd9                	or	a5,a5,a4
         ((netlong & 0xff00) << 8) |
 666:	00851713          	sll	a4,a0,0x8
 66a:	00ff06b7          	lui	a3,0xff0
 66e:	8f75                	and	a4,a4,a3
         ((netlong >> 8) & 0xff00) |
 670:	8fd9                	or	a5,a5,a4
         ((netlong & 0xff) << 24);
 672:	0562                	sll	a0,a0,0x18
 674:	0ff00713          	li	a4,255
 678:	0762                	sll	a4,a4,0x18
 67a:	8d79                	and	a0,a0,a4
}
 67c:	8d5d                	or	a0,a0,a5
 67e:	6422                	ld	s0,8(sp)
 680:	0141                	add	sp,sp,16
 682:	8082                	ret

0000000000000684 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 684:	4885                	li	a7,1
 ecall
 686:	00000073          	ecall
 ret
 68a:	8082                	ret

000000000000068c <exit>:
.global exit
exit:
 li a7, SYS_exit
 68c:	4889                	li	a7,2
 ecall
 68e:	00000073          	ecall
 ret
 692:	8082                	ret

0000000000000694 <wait>:
.global wait
wait:
 li a7, SYS_wait
 694:	488d                	li	a7,3
 ecall
 696:	00000073          	ecall
 ret
 69a:	8082                	ret

000000000000069c <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 69c:	4891                	li	a7,4
 ecall
 69e:	00000073          	ecall
 ret
 6a2:	8082                	ret

00000000000006a4 <read>:
.global read
read:
 li a7, SYS_read
 6a4:	4895                	li	a7,5
 ecall
 6a6:	00000073          	ecall
 ret
 6aa:	8082                	ret

00000000000006ac <write>:
.global write
write:
 li a7, SYS_write
 6ac:	48c1                	li	a7,16
 ecall
 6ae:	00000073          	ecall
 ret
 6b2:	8082                	ret

00000000000006b4 <close>:
.global close
close:
 li a7, SYS_close
 6b4:	48d5                	li	a7,21
 ecall
 6b6:	00000073          	ecall
 ret
 6ba:	8082                	ret

00000000000006bc <kill>:
.global kill
kill:
 li a7, SYS_kill
 6bc:	4899                	li	a7,6
 ecall
 6be:	00000073          	ecall
 ret
 6c2:	8082                	ret

00000000000006c4 <exec>:
.global exec
exec:
 li a7, SYS_exec
 6c4:	489d                	li	a7,7
 ecall
 6c6:	00000073          	ecall
 ret
 6ca:	8082                	ret

00000000000006cc <open>:
.global open
open:
 li a7, SYS_open
 6cc:	48bd                	li	a7,15
 ecall
 6ce:	00000073          	ecall
 ret
 6d2:	8082                	ret

00000000000006d4 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 6d4:	48c5                	li	a7,17
 ecall
 6d6:	00000073          	ecall
 ret
 6da:	8082                	ret

00000000000006dc <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 6dc:	48c9                	li	a7,18
 ecall
 6de:	00000073          	ecall
 ret
 6e2:	8082                	ret

00000000000006e4 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 6e4:	48a1                	li	a7,8
 ecall
 6e6:	00000073          	ecall
 ret
 6ea:	8082                	ret

00000000000006ec <link>:
.global link
link:
 li a7, SYS_link
 6ec:	48cd                	li	a7,19
 ecall
 6ee:	00000073          	ecall
 ret
 6f2:	8082                	ret

00000000000006f4 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 6f4:	48d1                	li	a7,20
 ecall
 6f6:	00000073          	ecall
 ret
 6fa:	8082                	ret

00000000000006fc <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 6fc:	48a5                	li	a7,9
 ecall
 6fe:	00000073          	ecall
 ret
 702:	8082                	ret

0000000000000704 <dup>:
.global dup
dup:
 li a7, SYS_dup
 704:	48a9                	li	a7,10
 ecall
 706:	00000073          	ecall
 ret
 70a:	8082                	ret

000000000000070c <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 70c:	48ad                	li	a7,11
 ecall
 70e:	00000073          	ecall
 ret
 712:	8082                	ret

0000000000000714 <sys_sbrk>:
.global sys_sbrk
sys_sbrk:
 li a7, SYS_sbrk
 714:	48b1                	li	a7,12
 ecall
 716:	00000073          	ecall
 ret
 71a:	8082                	ret

000000000000071c <pause>:
.global pause
pause:
 li a7, SYS_pause
 71c:	48b5                	li	a7,13
 ecall
 71e:	00000073          	ecall
 ret
 722:	8082                	ret

0000000000000724 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 724:	48b9                	li	a7,14
 ecall
 726:	00000073          	ecall
 ret
 72a:	8082                	ret

000000000000072c <socket>:
.global socket
socket:
 li a7, SYS_socket
 72c:	48d9                	li	a7,22
 ecall
 72e:	00000073          	ecall
 ret
 732:	8082                	ret

0000000000000734 <bind>:
.global bind
bind:
 li a7, SYS_bind
 734:	48dd                	li	a7,23
 ecall
 736:	00000073          	ecall
 ret
 73a:	8082                	ret

000000000000073c <listen>:
.global listen
listen:
 li a7, SYS_listen
 73c:	48e1                	li	a7,24
 ecall
 73e:	00000073          	ecall
 ret
 742:	8082                	ret

0000000000000744 <accept>:
.global accept
accept:
 li a7, SYS_accept
 744:	48e5                	li	a7,25
 ecall
 746:	00000073          	ecall
 ret
 74a:	8082                	ret

000000000000074c <connect>:
.global connect
connect:
 li a7, SYS_connect
 74c:	48e9                	li	a7,26
 ecall
 74e:	00000073          	ecall
 ret
 752:	8082                	ret

0000000000000754 <send>:
.global send
send:
 li a7, SYS_send
 754:	48ed                	li	a7,27
 ecall
 756:	00000073          	ecall
 ret
 75a:	8082                	ret

000000000000075c <recv>:
.global recv
recv:
 li a7, SYS_recv
 75c:	48f1                	li	a7,28
 ecall
 75e:	00000073          	ecall
 ret
 762:	8082                	ret

0000000000000764 <sendto>:
.global sendto
sendto:
 li a7, SYS_sendto
 764:	48f5                	li	a7,29
 ecall
 766:	00000073          	ecall
 ret
 76a:	8082                	ret

000000000000076c <recvfrom>:
.global recvfrom
recvfrom:
 li a7, SYS_recvfrom
 76c:	48f9                	li	a7,30
 ecall
 76e:	00000073          	ecall
 ret
 772:	8082                	ret

0000000000000774 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 774:	1101                	add	sp,sp,-32
 776:	ec06                	sd	ra,24(sp)
 778:	e822                	sd	s0,16(sp)
 77a:	1000                	add	s0,sp,32
 77c:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 780:	4605                	li	a2,1
 782:	fef40593          	add	a1,s0,-17
 786:	f27ff0ef          	jal	6ac <write>
}
 78a:	60e2                	ld	ra,24(sp)
 78c:	6442                	ld	s0,16(sp)
 78e:	6105                	add	sp,sp,32
 790:	8082                	ret

0000000000000792 <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
 792:	715d                	add	sp,sp,-80
 794:	e486                	sd	ra,72(sp)
 796:	e0a2                	sd	s0,64(sp)
 798:	f84a                	sd	s2,48(sp)
 79a:	0880                	add	s0,sp,80
 79c:	892a                	mv	s2,a0
  char buf[20];
  int i, neg;
  unsigned long long x;

  neg = 0;
  if(sgn && xx < 0){
 79e:	c299                	beqz	a3,7a4 <printint+0x12>
 7a0:	0805c363          	bltz	a1,826 <printint+0x94>
  neg = 0;
 7a4:	4881                	li	a7,0
 7a6:	fb840693          	add	a3,s0,-72
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
 7aa:	4781                	li	a5,0
  do{
    buf[i++] = digits[x % base];
 7ac:	00000517          	auipc	a0,0x0
 7b0:	62450513          	add	a0,a0,1572 # dd0 <digits>
 7b4:	883e                	mv	a6,a5
 7b6:	2785                	addw	a5,a5,1
 7b8:	02c5f733          	remu	a4,a1,a2
 7bc:	972a                	add	a4,a4,a0
 7be:	00074703          	lbu	a4,0(a4)
 7c2:	00e68023          	sb	a4,0(a3) # ff0000 <base+0xfeeff0>
  }while((x /= base) != 0);
 7c6:	872e                	mv	a4,a1
 7c8:	02c5d5b3          	divu	a1,a1,a2
 7cc:	0685                	add	a3,a3,1
 7ce:	fec773e3          	bgeu	a4,a2,7b4 <printint+0x22>
  if(neg)
 7d2:	00088b63          	beqz	a7,7e8 <printint+0x56>
    buf[i++] = '-';
 7d6:	fd078793          	add	a5,a5,-48
 7da:	97a2                	add	a5,a5,s0
 7dc:	02d00713          	li	a4,45
 7e0:	fee78423          	sb	a4,-24(a5)
 7e4:	0028079b          	addw	a5,a6,2

  while(--i >= 0)
 7e8:	02f05a63          	blez	a5,81c <printint+0x8a>
 7ec:	fc26                	sd	s1,56(sp)
 7ee:	f44e                	sd	s3,40(sp)
 7f0:	fb840713          	add	a4,s0,-72
 7f4:	00f704b3          	add	s1,a4,a5
 7f8:	fff70993          	add	s3,a4,-1
 7fc:	99be                	add	s3,s3,a5
 7fe:	37fd                	addw	a5,a5,-1
 800:	1782                	sll	a5,a5,0x20
 802:	9381                	srl	a5,a5,0x20
 804:	40f989b3          	sub	s3,s3,a5
    putc(fd, buf[i]);
 808:	fff4c583          	lbu	a1,-1(s1)
 80c:	854a                	mv	a0,s2
 80e:	f67ff0ef          	jal	774 <putc>
  while(--i >= 0)
 812:	14fd                	add	s1,s1,-1
 814:	ff349ae3          	bne	s1,s3,808 <printint+0x76>
 818:	74e2                	ld	s1,56(sp)
 81a:	79a2                	ld	s3,40(sp)
}
 81c:	60a6                	ld	ra,72(sp)
 81e:	6406                	ld	s0,64(sp)
 820:	7942                	ld	s2,48(sp)
 822:	6161                	add	sp,sp,80
 824:	8082                	ret
    x = -xx;
 826:	40b005b3          	neg	a1,a1
    neg = 1;
 82a:	4885                	li	a7,1
    x = -xx;
 82c:	bfad                	j	7a6 <printint+0x14>

000000000000082e <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %c, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 82e:	711d                	add	sp,sp,-96
 830:	ec86                	sd	ra,88(sp)
 832:	e8a2                	sd	s0,80(sp)
 834:	e0ca                	sd	s2,64(sp)
 836:	1080                	add	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 838:	0005c903          	lbu	s2,0(a1)
 83c:	28090663          	beqz	s2,ac8 <vprintf+0x29a>
 840:	e4a6                	sd	s1,72(sp)
 842:	fc4e                	sd	s3,56(sp)
 844:	f852                	sd	s4,48(sp)
 846:	f456                	sd	s5,40(sp)
 848:	f05a                	sd	s6,32(sp)
 84a:	ec5e                	sd	s7,24(sp)
 84c:	e862                	sd	s8,16(sp)
 84e:	e466                	sd	s9,8(sp)
 850:	8b2a                	mv	s6,a0
 852:	8a2e                	mv	s4,a1
 854:	8bb2                	mv	s7,a2
  state = 0;
 856:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
 858:	4481                	li	s1,0
 85a:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
 85c:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
 860:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
 864:	06c00c93          	li	s9,108
 868:	a005                	j	888 <vprintf+0x5a>
        putc(fd, c0);
 86a:	85ca                	mv	a1,s2
 86c:	855a                	mv	a0,s6
 86e:	f07ff0ef          	jal	774 <putc>
 872:	a019                	j	878 <vprintf+0x4a>
    } else if(state == '%'){
 874:	03598263          	beq	s3,s5,898 <vprintf+0x6a>
  for(i = 0; fmt[i]; i++){
 878:	2485                	addw	s1,s1,1
 87a:	8726                	mv	a4,s1
 87c:	009a07b3          	add	a5,s4,s1
 880:	0007c903          	lbu	s2,0(a5)
 884:	22090a63          	beqz	s2,ab8 <vprintf+0x28a>
    c0 = fmt[i] & 0xff;
 888:	0009079b          	sext.w	a5,s2
    if(state == 0){
 88c:	fe0994e3          	bnez	s3,874 <vprintf+0x46>
      if(c0 == '%'){
 890:	fd579de3          	bne	a5,s5,86a <vprintf+0x3c>
        state = '%';
 894:	89be                	mv	s3,a5
 896:	b7cd                	j	878 <vprintf+0x4a>
      if(c0) c1 = fmt[i+1] & 0xff;
 898:	00ea06b3          	add	a3,s4,a4
 89c:	0016c683          	lbu	a3,1(a3)
      c1 = c2 = 0;
 8a0:	8636                	mv	a2,a3
      if(c1) c2 = fmt[i+2] & 0xff;
 8a2:	c681                	beqz	a3,8aa <vprintf+0x7c>
 8a4:	9752                	add	a4,a4,s4
 8a6:	00274603          	lbu	a2,2(a4)
      if(c0 == 'd'){
 8aa:	05878363          	beq	a5,s8,8f0 <vprintf+0xc2>
      } else if(c0 == 'l' && c1 == 'd'){
 8ae:	05978d63          	beq	a5,s9,908 <vprintf+0xda>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
 8b2:	07500713          	li	a4,117
 8b6:	0ee78763          	beq	a5,a4,9a4 <vprintf+0x176>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
 8ba:	07800713          	li	a4,120
 8be:	12e78963          	beq	a5,a4,9f0 <vprintf+0x1c2>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
 8c2:	07000713          	li	a4,112
 8c6:	14e78e63          	beq	a5,a4,a22 <vprintf+0x1f4>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 'c'){
 8ca:	06300713          	li	a4,99
 8ce:	18e78e63          	beq	a5,a4,a6a <vprintf+0x23c>
        putc(fd, va_arg(ap, uint32));
      } else if(c0 == 's'){
 8d2:	07300713          	li	a4,115
 8d6:	1ae78463          	beq	a5,a4,a7e <vprintf+0x250>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
 8da:	02500713          	li	a4,37
 8de:	04e79563          	bne	a5,a4,928 <vprintf+0xfa>
        putc(fd, '%');
 8e2:	02500593          	li	a1,37
 8e6:	855a                	mv	a0,s6
 8e8:	e8dff0ef          	jal	774 <putc>
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c0);
      }

      state = 0;
 8ec:	4981                	li	s3,0
 8ee:	b769                	j	878 <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 1);
 8f0:	008b8913          	add	s2,s7,8
 8f4:	4685                	li	a3,1
 8f6:	4629                	li	a2,10
 8f8:	000ba583          	lw	a1,0(s7)
 8fc:	855a                	mv	a0,s6
 8fe:	e95ff0ef          	jal	792 <printint>
 902:	8bca                	mv	s7,s2
      state = 0;
 904:	4981                	li	s3,0
 906:	bf8d                	j	878 <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'd'){
 908:	06400793          	li	a5,100
 90c:	02f68963          	beq	a3,a5,93e <vprintf+0x110>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 910:	06c00793          	li	a5,108
 914:	04f68263          	beq	a3,a5,958 <vprintf+0x12a>
      } else if(c0 == 'l' && c1 == 'u'){
 918:	07500793          	li	a5,117
 91c:	0af68063          	beq	a3,a5,9bc <vprintf+0x18e>
      } else if(c0 == 'l' && c1 == 'x'){
 920:	07800793          	li	a5,120
 924:	0ef68263          	beq	a3,a5,a08 <vprintf+0x1da>
        putc(fd, '%');
 928:	02500593          	li	a1,37
 92c:	855a                	mv	a0,s6
 92e:	e47ff0ef          	jal	774 <putc>
        putc(fd, c0);
 932:	85ca                	mv	a1,s2
 934:	855a                	mv	a0,s6
 936:	e3fff0ef          	jal	774 <putc>
      state = 0;
 93a:	4981                	li	s3,0
 93c:	bf35                	j	878 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 93e:	008b8913          	add	s2,s7,8
 942:	4685                	li	a3,1
 944:	4629                	li	a2,10
 946:	000bb583          	ld	a1,0(s7)
 94a:	855a                	mv	a0,s6
 94c:	e47ff0ef          	jal	792 <printint>
        i += 1;
 950:	2485                	addw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 952:	8bca                	mv	s7,s2
      state = 0;
 954:	4981                	li	s3,0
        i += 1;
 956:	b70d                	j	878 <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 958:	06400793          	li	a5,100
 95c:	02f60763          	beq	a2,a5,98a <vprintf+0x15c>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 960:	07500793          	li	a5,117
 964:	06f60963          	beq	a2,a5,9d6 <vprintf+0x1a8>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 968:	07800793          	li	a5,120
 96c:	faf61ee3          	bne	a2,a5,928 <vprintf+0xfa>
        printint(fd, va_arg(ap, uint64), 16, 0);
 970:	008b8913          	add	s2,s7,8
 974:	4681                	li	a3,0
 976:	4641                	li	a2,16
 978:	000bb583          	ld	a1,0(s7)
 97c:	855a                	mv	a0,s6
 97e:	e15ff0ef          	jal	792 <printint>
        i += 2;
 982:	2489                	addw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 984:	8bca                	mv	s7,s2
      state = 0;
 986:	4981                	li	s3,0
        i += 2;
 988:	bdc5                	j	878 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 98a:	008b8913          	add	s2,s7,8
 98e:	4685                	li	a3,1
 990:	4629                	li	a2,10
 992:	000bb583          	ld	a1,0(s7)
 996:	855a                	mv	a0,s6
 998:	dfbff0ef          	jal	792 <printint>
        i += 2;
 99c:	2489                	addw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 99e:	8bca                	mv	s7,s2
      state = 0;
 9a0:	4981                	li	s3,0
        i += 2;
 9a2:	bdd9                	j	878 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint32), 10, 0);
 9a4:	008b8913          	add	s2,s7,8
 9a8:	4681                	li	a3,0
 9aa:	4629                	li	a2,10
 9ac:	000be583          	lwu	a1,0(s7)
 9b0:	855a                	mv	a0,s6
 9b2:	de1ff0ef          	jal	792 <printint>
 9b6:	8bca                	mv	s7,s2
      state = 0;
 9b8:	4981                	li	s3,0
 9ba:	bd7d                	j	878 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 9bc:	008b8913          	add	s2,s7,8
 9c0:	4681                	li	a3,0
 9c2:	4629                	li	a2,10
 9c4:	000bb583          	ld	a1,0(s7)
 9c8:	855a                	mv	a0,s6
 9ca:	dc9ff0ef          	jal	792 <printint>
        i += 1;
 9ce:	2485                	addw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 9d0:	8bca                	mv	s7,s2
      state = 0;
 9d2:	4981                	li	s3,0
        i += 1;
 9d4:	b555                	j	878 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 9d6:	008b8913          	add	s2,s7,8
 9da:	4681                	li	a3,0
 9dc:	4629                	li	a2,10
 9de:	000bb583          	ld	a1,0(s7)
 9e2:	855a                	mv	a0,s6
 9e4:	dafff0ef          	jal	792 <printint>
        i += 2;
 9e8:	2489                	addw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 9ea:	8bca                	mv	s7,s2
      state = 0;
 9ec:	4981                	li	s3,0
        i += 2;
 9ee:	b569                	j	878 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint32), 16, 0);
 9f0:	008b8913          	add	s2,s7,8
 9f4:	4681                	li	a3,0
 9f6:	4641                	li	a2,16
 9f8:	000be583          	lwu	a1,0(s7)
 9fc:	855a                	mv	a0,s6
 9fe:	d95ff0ef          	jal	792 <printint>
 a02:	8bca                	mv	s7,s2
      state = 0;
 a04:	4981                	li	s3,0
 a06:	bd8d                	j	878 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 16, 0);
 a08:	008b8913          	add	s2,s7,8
 a0c:	4681                	li	a3,0
 a0e:	4641                	li	a2,16
 a10:	000bb583          	ld	a1,0(s7)
 a14:	855a                	mv	a0,s6
 a16:	d7dff0ef          	jal	792 <printint>
        i += 1;
 a1a:	2485                	addw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 a1c:	8bca                	mv	s7,s2
      state = 0;
 a1e:	4981                	li	s3,0
        i += 1;
 a20:	bda1                	j	878 <vprintf+0x4a>
 a22:	e06a                	sd	s10,0(sp)
        printptr(fd, va_arg(ap, uint64));
 a24:	008b8d13          	add	s10,s7,8
 a28:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 a2c:	03000593          	li	a1,48
 a30:	855a                	mv	a0,s6
 a32:	d43ff0ef          	jal	774 <putc>
  putc(fd, 'x');
 a36:	07800593          	li	a1,120
 a3a:	855a                	mv	a0,s6
 a3c:	d39ff0ef          	jal	774 <putc>
 a40:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 a42:	00000b97          	auipc	s7,0x0
 a46:	38eb8b93          	add	s7,s7,910 # dd0 <digits>
 a4a:	03c9d793          	srl	a5,s3,0x3c
 a4e:	97de                	add	a5,a5,s7
 a50:	0007c583          	lbu	a1,0(a5)
 a54:	855a                	mv	a0,s6
 a56:	d1fff0ef          	jal	774 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 a5a:	0992                	sll	s3,s3,0x4
 a5c:	397d                	addw	s2,s2,-1
 a5e:	fe0916e3          	bnez	s2,a4a <vprintf+0x21c>
        printptr(fd, va_arg(ap, uint64));
 a62:	8bea                	mv	s7,s10
      state = 0;
 a64:	4981                	li	s3,0
 a66:	6d02                	ld	s10,0(sp)
 a68:	bd01                	j	878 <vprintf+0x4a>
        putc(fd, va_arg(ap, uint32));
 a6a:	008b8913          	add	s2,s7,8
 a6e:	000bc583          	lbu	a1,0(s7)
 a72:	855a                	mv	a0,s6
 a74:	d01ff0ef          	jal	774 <putc>
 a78:	8bca                	mv	s7,s2
      state = 0;
 a7a:	4981                	li	s3,0
 a7c:	bbf5                	j	878 <vprintf+0x4a>
        if((s = va_arg(ap, char*)) == 0)
 a7e:	008b8993          	add	s3,s7,8
 a82:	000bb903          	ld	s2,0(s7)
 a86:	00090f63          	beqz	s2,aa4 <vprintf+0x276>
        for(; *s; s++)
 a8a:	00094583          	lbu	a1,0(s2)
 a8e:	c195                	beqz	a1,ab2 <vprintf+0x284>
          putc(fd, *s);
 a90:	855a                	mv	a0,s6
 a92:	ce3ff0ef          	jal	774 <putc>
        for(; *s; s++)
 a96:	0905                	add	s2,s2,1
 a98:	00094583          	lbu	a1,0(s2)
 a9c:	f9f5                	bnez	a1,a90 <vprintf+0x262>
        if((s = va_arg(ap, char*)) == 0)
 a9e:	8bce                	mv	s7,s3
      state = 0;
 aa0:	4981                	li	s3,0
 aa2:	bbd9                	j	878 <vprintf+0x4a>
          s = "(null)";
 aa4:	00000917          	auipc	s2,0x0
 aa8:	32490913          	add	s2,s2,804 # dc8 <malloc+0x218>
        for(; *s; s++)
 aac:	02800593          	li	a1,40
 ab0:	b7c5                	j	a90 <vprintf+0x262>
        if((s = va_arg(ap, char*)) == 0)
 ab2:	8bce                	mv	s7,s3
      state = 0;
 ab4:	4981                	li	s3,0
 ab6:	b3c9                	j	878 <vprintf+0x4a>
 ab8:	64a6                	ld	s1,72(sp)
 aba:	79e2                	ld	s3,56(sp)
 abc:	7a42                	ld	s4,48(sp)
 abe:	7aa2                	ld	s5,40(sp)
 ac0:	7b02                	ld	s6,32(sp)
 ac2:	6be2                	ld	s7,24(sp)
 ac4:	6c42                	ld	s8,16(sp)
 ac6:	6ca2                	ld	s9,8(sp)
    }
  }
}
 ac8:	60e6                	ld	ra,88(sp)
 aca:	6446                	ld	s0,80(sp)
 acc:	6906                	ld	s2,64(sp)
 ace:	6125                	add	sp,sp,96
 ad0:	8082                	ret

0000000000000ad2 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 ad2:	715d                	add	sp,sp,-80
 ad4:	ec06                	sd	ra,24(sp)
 ad6:	e822                	sd	s0,16(sp)
 ad8:	1000                	add	s0,sp,32
 ada:	e010                	sd	a2,0(s0)
 adc:	e414                	sd	a3,8(s0)
 ade:	e818                	sd	a4,16(s0)
 ae0:	ec1c                	sd	a5,24(s0)
 ae2:	03043023          	sd	a6,32(s0)
 ae6:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 aea:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 aee:	8622                	mv	a2,s0
 af0:	d3fff0ef          	jal	82e <vprintf>
}
 af4:	60e2                	ld	ra,24(sp)
 af6:	6442                	ld	s0,16(sp)
 af8:	6161                	add	sp,sp,80
 afa:	8082                	ret

0000000000000afc <printf>:

void
printf(const char *fmt, ...)
{
 afc:	711d                	add	sp,sp,-96
 afe:	ec06                	sd	ra,24(sp)
 b00:	e822                	sd	s0,16(sp)
 b02:	1000                	add	s0,sp,32
 b04:	e40c                	sd	a1,8(s0)
 b06:	e810                	sd	a2,16(s0)
 b08:	ec14                	sd	a3,24(s0)
 b0a:	f018                	sd	a4,32(s0)
 b0c:	f41c                	sd	a5,40(s0)
 b0e:	03043823          	sd	a6,48(s0)
 b12:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 b16:	00840613          	add	a2,s0,8
 b1a:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 b1e:	85aa                	mv	a1,a0
 b20:	4505                	li	a0,1
 b22:	d0dff0ef          	jal	82e <vprintf>
}
 b26:	60e2                	ld	ra,24(sp)
 b28:	6442                	ld	s0,16(sp)
 b2a:	6125                	add	sp,sp,96
 b2c:	8082                	ret

0000000000000b2e <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 b2e:	1141                	add	sp,sp,-16
 b30:	e422                	sd	s0,8(sp)
 b32:	0800                	add	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 b34:	ff050693          	add	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 b38:	00000797          	auipc	a5,0x0
 b3c:	4c87b783          	ld	a5,1224(a5) # 1000 <freep>
 b40:	a02d                	j	b6a <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 b42:	4618                	lw	a4,8(a2)
 b44:	9f2d                	addw	a4,a4,a1
 b46:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 b4a:	6398                	ld	a4,0(a5)
 b4c:	6310                	ld	a2,0(a4)
 b4e:	a83d                	j	b8c <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 b50:	ff852703          	lw	a4,-8(a0)
 b54:	9f31                	addw	a4,a4,a2
 b56:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 b58:	ff053683          	ld	a3,-16(a0)
 b5c:	a091                	j	ba0 <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 b5e:	6398                	ld	a4,0(a5)
 b60:	00e7e463          	bltu	a5,a4,b68 <free+0x3a>
 b64:	00e6ea63          	bltu	a3,a4,b78 <free+0x4a>
{
 b68:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 b6a:	fed7fae3          	bgeu	a5,a3,b5e <free+0x30>
 b6e:	6398                	ld	a4,0(a5)
 b70:	00e6e463          	bltu	a3,a4,b78 <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 b74:	fee7eae3          	bltu	a5,a4,b68 <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 b78:	ff852583          	lw	a1,-8(a0)
 b7c:	6390                	ld	a2,0(a5)
 b7e:	02059813          	sll	a6,a1,0x20
 b82:	01c85713          	srl	a4,a6,0x1c
 b86:	9736                	add	a4,a4,a3
 b88:	fae60de3          	beq	a2,a4,b42 <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 b8c:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 b90:	4790                	lw	a2,8(a5)
 b92:	02061593          	sll	a1,a2,0x20
 b96:	01c5d713          	srl	a4,a1,0x1c
 b9a:	973e                	add	a4,a4,a5
 b9c:	fae68ae3          	beq	a3,a4,b50 <free+0x22>
    p->s.ptr = bp->s.ptr;
 ba0:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 ba2:	00000717          	auipc	a4,0x0
 ba6:	44f73f23          	sd	a5,1118(a4) # 1000 <freep>
}
 baa:	6422                	ld	s0,8(sp)
 bac:	0141                	add	sp,sp,16
 bae:	8082                	ret

0000000000000bb0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 bb0:	7139                	add	sp,sp,-64
 bb2:	fc06                	sd	ra,56(sp)
 bb4:	f822                	sd	s0,48(sp)
 bb6:	f426                	sd	s1,40(sp)
 bb8:	ec4e                	sd	s3,24(sp)
 bba:	0080                	add	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 bbc:	02051493          	sll	s1,a0,0x20
 bc0:	9081                	srl	s1,s1,0x20
 bc2:	04bd                	add	s1,s1,15
 bc4:	8091                	srl	s1,s1,0x4
 bc6:	0014899b          	addw	s3,s1,1
 bca:	0485                	add	s1,s1,1
  if((prevp = freep) == 0){
 bcc:	00000517          	auipc	a0,0x0
 bd0:	43453503          	ld	a0,1076(a0) # 1000 <freep>
 bd4:	c915                	beqz	a0,c08 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 bd6:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 bd8:	4798                	lw	a4,8(a5)
 bda:	08977a63          	bgeu	a4,s1,c6e <malloc+0xbe>
 bde:	f04a                	sd	s2,32(sp)
 be0:	e852                	sd	s4,16(sp)
 be2:	e456                	sd	s5,8(sp)
 be4:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 be6:	8a4e                	mv	s4,s3
 be8:	0009871b          	sext.w	a4,s3
 bec:	6685                	lui	a3,0x1
 bee:	00d77363          	bgeu	a4,a3,bf4 <malloc+0x44>
 bf2:	6a05                	lui	s4,0x1
 bf4:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 bf8:	004a1a1b          	sllw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 bfc:	00000917          	auipc	s2,0x0
 c00:	40490913          	add	s2,s2,1028 # 1000 <freep>
  if(p == SBRK_ERROR)
 c04:	5afd                	li	s5,-1
 c06:	a081                	j	c46 <malloc+0x96>
 c08:	f04a                	sd	s2,32(sp)
 c0a:	e852                	sd	s4,16(sp)
 c0c:	e456                	sd	s5,8(sp)
 c0e:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 c10:	00000797          	auipc	a5,0x0
 c14:	40078793          	add	a5,a5,1024 # 1010 <base>
 c18:	00000717          	auipc	a4,0x0
 c1c:	3ef73423          	sd	a5,1000(a4) # 1000 <freep>
 c20:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 c22:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 c26:	b7c1                	j	be6 <malloc+0x36>
        prevp->s.ptr = p->s.ptr;
 c28:	6398                	ld	a4,0(a5)
 c2a:	e118                	sd	a4,0(a0)
 c2c:	a8a9                	j	c86 <malloc+0xd6>
  hp->s.size = nu;
 c2e:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 c32:	0541                	add	a0,a0,16
 c34:	efbff0ef          	jal	b2e <free>
  return freep;
 c38:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 c3c:	c12d                	beqz	a0,c9e <malloc+0xee>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 c3e:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 c40:	4798                	lw	a4,8(a5)
 c42:	02977263          	bgeu	a4,s1,c66 <malloc+0xb6>
    if(p == freep)
 c46:	00093703          	ld	a4,0(s2)
 c4a:	853e                	mv	a0,a5
 c4c:	fef719e3          	bne	a4,a5,c3e <malloc+0x8e>
  p = sbrk(nu * sizeof(Header));
 c50:	8552                	mv	a0,s4
 c52:	967ff0ef          	jal	5b8 <sbrk>
  if(p == SBRK_ERROR)
 c56:	fd551ce3          	bne	a0,s5,c2e <malloc+0x7e>
        return 0;
 c5a:	4501                	li	a0,0
 c5c:	7902                	ld	s2,32(sp)
 c5e:	6a42                	ld	s4,16(sp)
 c60:	6aa2                	ld	s5,8(sp)
 c62:	6b02                	ld	s6,0(sp)
 c64:	a03d                	j	c92 <malloc+0xe2>
 c66:	7902                	ld	s2,32(sp)
 c68:	6a42                	ld	s4,16(sp)
 c6a:	6aa2                	ld	s5,8(sp)
 c6c:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 c6e:	fae48de3          	beq	s1,a4,c28 <malloc+0x78>
        p->s.size -= nunits;
 c72:	4137073b          	subw	a4,a4,s3
 c76:	c798                	sw	a4,8(a5)
        p += p->s.size;
 c78:	02071693          	sll	a3,a4,0x20
 c7c:	01c6d713          	srl	a4,a3,0x1c
 c80:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 c82:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 c86:	00000717          	auipc	a4,0x0
 c8a:	36a73d23          	sd	a0,890(a4) # 1000 <freep>
      return (void*)(p + 1);
 c8e:	01078513          	add	a0,a5,16
  }
}
 c92:	70e2                	ld	ra,56(sp)
 c94:	7442                	ld	s0,48(sp)
 c96:	74a2                	ld	s1,40(sp)
 c98:	69e2                	ld	s3,24(sp)
 c9a:	6121                	add	sp,sp,64
 c9c:	8082                	ret
 c9e:	7902                	ld	s2,32(sp)
 ca0:	6a42                	ld	s4,16(sp)
 ca2:	6aa2                	ld	s5,8(sp)
 ca4:	6b02                	ld	s6,0(sp)
 ca6:	b7f5                	j	c92 <malloc+0xe2>
