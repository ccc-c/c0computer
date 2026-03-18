
user/_telnet:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <parse_ip>:

char recvbuf[1024];

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
   e:	498000ef          	jal	4a6 <atoi>
  12:	892a                	mv	s2,a0
    p = strchr(p, '.');
  14:	02e00593          	li	a1,46
  18:	8526                	mv	a0,s1
  1a:	3be000ef          	jal	3d8 <strchr>
    if (!p) return 0;
  1e:	c141                	beqz	a0,9e <parse_ip+0x9e>
  20:	e44e                	sd	s3,8(sp)
    p++;
  22:	00150493          	add	s1,a0,1
    
    b = atoi(p);
  26:	8526                	mv	a0,s1
  28:	47e000ef          	jal	4a6 <atoi>
  2c:	89aa                	mv	s3,a0
    p = strchr(p, '.');
  2e:	02e00593          	li	a1,46
  32:	8526                	mv	a0,s1
  34:	3a4000ef          	jal	3d8 <strchr>
  38:	87aa                	mv	a5,a0
    if (!p) return 0;
  3a:	4501                	li	a0,0
  3c:	c3bd                	beqz	a5,a2 <parse_ip+0xa2>
  3e:	e052                	sd	s4,0(sp)
    p++;
  40:	00178493          	add	s1,a5,1
    
    c = atoi(p);
  44:	8526                	mv	a0,s1
  46:	460000ef          	jal	4a6 <atoi>
  4a:	8a2a                	mv	s4,a0
    p = strchr(p, '.');
  4c:	02e00593          	li	a1,46
  50:	8526                	mv	a0,s1
  52:	386000ef          	jal	3d8 <strchr>
  56:	872a                	mv	a4,a0
    if (!p) return 0;
  58:	4501                	li	a0,0
  5a:	c731                	beqz	a4,a6 <parse_ip+0xa6>
    p++;
    
    d = atoi(p);
  5c:	00170513          	add	a0,a4,1
  60:	446000ef          	jal	4a6 <atoi>
    
    return ((a & 0xff) | ((b & 0xff) << 8) | ((c & 0xff) << 16) | ((d & 0xff) << 24));
  64:	0089979b          	sllw	a5,s3,0x8
  68:	6741                	lui	a4,0x10
  6a:	f0070713          	add	a4,a4,-256 # ff00 <base+0xeaf0>
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
  ac:	710d                	add	sp,sp,-352
  ae:	ee86                	sd	ra,344(sp)
  b0:	eaa2                	sd	s0,336(sp)
  b2:	1280                	add	s0,sp,352
    struct sockaddr_in server_addr;
    uint32_t server_ip;
    int port = 23;
    int ret;
    
    if (argc < 2) {
  b4:	4785                	li	a5,1
  b6:	14a7d263          	bge	a5,a0,1fa <main+0x14e>
  ba:	e6a6                	sd	s1,328(sp)
  bc:	e2ca                	sd	s2,320(sp)
  be:	fe4e                	sd	s3,312(sp)
  c0:	84aa                	mv	s1,a0
  c2:	892e                	mv	s2,a1
        printf("Example: telnet 10.0.2.2\n");
        printf("         telnet 10.0.2.2 23\n");
        exit(1);
    }
    
    server_ip = parse_ip(argv[1]);
  c4:	6588                	ld	a0,8(a1)
  c6:	f3bff0ef          	jal	0 <parse_ip>
  ca:	0005099b          	sext.w	s3,a0
    if (server_ip == 0) {
  ce:	16098263          	beqz	s3,232 <main+0x186>
  d2:	fa52                	sd	s4,304(sp)
  d4:	f656                	sd	s5,296(sp)
  d6:	f25a                	sd	s6,288(sp)
  d8:	ee5e                	sd	s7,280(sp)
        printf("telnet: invalid IP address\n");
        exit(1);
    }
    
    if (argc > 2) {
  da:	4789                	li	a5,2
    int port = 23;
  dc:	4b5d                	li	s6,23
    if (argc > 2) {
  de:	1697c763          	blt	a5,s1,24c <main+0x1a0>
        port = atoi(argv[2]);
    }
    
    printf("Connecting to %d.%d.%d.%d:%d...\n",
  e2:	0ff9fb93          	zext.b	s7,s3
           (server_ip >> 0) & 0xff,
           (server_ip >> 8) & 0xff,
  e6:	0089d49b          	srlw	s1,s3,0x8
    printf("Connecting to %d.%d.%d.%d:%d...\n",
  ea:	0ff4f493          	zext.b	s1,s1
           (server_ip >> 16) & 0xff,
  ee:	0109da1b          	srlw	s4,s3,0x10
    printf("Connecting to %d.%d.%d.%d:%d...\n",
  f2:	0ffa7a13          	zext.b	s4,s4
  f6:	0189da9b          	srlw	s5,s3,0x18
  fa:	87da                	mv	a5,s6
  fc:	8756                	mv	a4,s5
  fe:	86d2                	mv	a3,s4
 100:	8626                	mv	a2,s1
 102:	85de                	mv	a1,s7
 104:	00001517          	auipc	a0,0x1
 108:	c1450513          	add	a0,a0,-1004 # d18 <malloc+0x18c>
 10c:	1cd000ef          	jal	ad8 <printf>
           (server_ip >> 24) & 0xff,
           port);
    
    sock = socket(PF_INET, SOCK_STREAM, IPPROTO_TCP);
 110:	4601                	li	a2,0
 112:	4589                	li	a1,2
 114:	4505                	li	a0,1
 116:	5f2000ef          	jal	708 <socket>
 11a:	892a                	mv	s2,a0
    if (sock < 0) {
 11c:	12054e63          	bltz	a0,258 <main+0x1ac>
        printf("telnet: socket failed\n");
        exit(1);
    }
    
    server_addr.sin_family = AF_INET;
 120:	4785                	li	a5,1
 122:	faf41423          	sh	a5,-88(s0)
    server_addr.sin_addr.s_addr = htonl(server_ip);
 126:	02099513          	sll	a0,s3,0x20
 12a:	9101                	srl	a0,a0,0x20
 12c:	4c8000ef          	jal	5f4 <htonl>
 130:	faa42623          	sw	a0,-84(s0)
    server_addr.sin_port = htons(port);
 134:	030b1513          	sll	a0,s6,0x30
 138:	9141                	srl	a0,a0,0x30
 13a:	486000ef          	jal	5c0 <htons>
 13e:	faa41523          	sh	a0,-86(s0)
    
    if (connect(sock, (struct sockaddr *)&server_addr, sizeof(server_addr)) < 0) {
 142:	4621                	li	a2,8
 144:	fa840593          	add	a1,s0,-88
 148:	854a                	mv	a0,s2
 14a:	5de000ef          	jal	728 <connect>
 14e:	10054e63          	bltz	a0,26a <main+0x1be>
        printf("telnet: connection failed\n");
        close(sock);
        exit(1);
    }
    
    printf("Connected to %d.%d.%d.%d\n",
 152:	8756                	mv	a4,s5
 154:	86d2                	mv	a3,s4
 156:	8626                	mv	a2,s1
 158:	85de                	mv	a1,s7
 15a:	00001517          	auipc	a0,0x1
 15e:	c1e50513          	add	a0,a0,-994 # d78 <malloc+0x1ec>
 162:	177000ef          	jal	ad8 <printf>
           (server_ip >> 0) & 0xff,
           (server_ip >> 8) & 0xff,
           (server_ip >> 16) & 0xff,
           (server_ip >> 24) & 0xff);
    
    printf("Type 'exit' to disconnect\n");
 166:	00001517          	auipc	a0,0x1
 16a:	c3250513          	add	a0,a0,-974 # d98 <malloc+0x20c>
 16e:	16b000ef          	jal	ad8 <printf>
    
    char input[256];
    
    while (1) {
        ret = recv(sock, recvbuf, sizeof(recvbuf) - 1, 0);
 172:	00001497          	auipc	s1,0x1
 176:	e9e48493          	add	s1,s1,-354 # 1010 <recvbuf>
        if (ret <= 0) {
            printf("\nConnection closed\n");
            break;
        }
        recvbuf[ret] = '\0';
        printf("%s", recvbuf);
 17a:	00001997          	auipc	s3,0x1
 17e:	c5698993          	add	s3,s3,-938 # dd0 <malloc+0x244>
        ret = recv(sock, recvbuf, sizeof(recvbuf) - 1, 0);
 182:	4681                	li	a3,0
 184:	3ff00613          	li	a2,1023
 188:	85a6                	mv	a1,s1
 18a:	854a                	mv	a0,s2
 18c:	5ac000ef          	jal	738 <recv>
        if (ret <= 0) {
 190:	0ea05963          	blez	a0,282 <main+0x1d6>
        recvbuf[ret] = '\0';
 194:	9526                	add	a0,a0,s1
 196:	00050023          	sb	zero,0(a0)
        printf("%s", recvbuf);
 19a:	85a6                	mv	a1,s1
 19c:	854e                	mv	a0,s3
 19e:	13b000ef          	jal	ad8 <printf>
        
        if (gets(input, sizeof(input))) {
 1a2:	10000593          	li	a1,256
 1a6:	ea840513          	add	a0,s0,-344
 1aa:	252000ef          	jal	3fc <gets>
 1ae:	d971                	beqz	a0,182 <main+0xd6>
            ret = send(sock, input, strlen(input), 0);
 1b0:	ea840513          	add	a0,s0,-344
 1b4:	1d8000ef          	jal	38c <strlen>
 1b8:	4681                	li	a3,0
 1ba:	0005061b          	sext.w	a2,a0
 1be:	ea840593          	add	a1,s0,-344
 1c2:	854a                	mv	a0,s2
 1c4:	56c000ef          	jal	730 <send>
            send(sock, "\r\n", 2, 0);
 1c8:	4681                	li	a3,0
 1ca:	4609                	li	a2,2
 1cc:	00001597          	auipc	a1,0x1
 1d0:	c0c58593          	add	a1,a1,-1012 # dd8 <malloc+0x24c>
 1d4:	854a                	mv	a0,s2
 1d6:	55a000ef          	jal	730 <send>
            
            if (strcmp(input, "exit") == 0) {
 1da:	00001597          	auipc	a1,0x1
 1de:	c0658593          	add	a1,a1,-1018 # de0 <malloc+0x254>
 1e2:	ea840513          	add	a0,s0,-344
 1e6:	0e0000ef          	jal	2c6 <strcmp>
 1ea:	fd41                	bnez	a0,182 <main+0xd6>
                printf("Disconnecting...\n");
 1ec:	00001517          	auipc	a0,0x1
 1f0:	bfc50513          	add	a0,a0,-1028 # de8 <malloc+0x25c>
 1f4:	0e5000ef          	jal	ad8 <printf>
                break;
 1f8:	a859                	j	28e <main+0x1e2>
 1fa:	e6a6                	sd	s1,328(sp)
 1fc:	e2ca                	sd	s2,320(sp)
 1fe:	fe4e                	sd	s3,312(sp)
 200:	fa52                	sd	s4,304(sp)
 202:	f656                	sd	s5,296(sp)
 204:	f25a                	sd	s6,288(sp)
 206:	ee5e                	sd	s7,280(sp)
        printf("Usage: telnet <IP address> [port]\n");
 208:	00001517          	auipc	a0,0x1
 20c:	a8850513          	add	a0,a0,-1400 # c90 <malloc+0x104>
 210:	0c9000ef          	jal	ad8 <printf>
        printf("Example: telnet 10.0.2.2\n");
 214:	00001517          	auipc	a0,0x1
 218:	aa450513          	add	a0,a0,-1372 # cb8 <malloc+0x12c>
 21c:	0bd000ef          	jal	ad8 <printf>
        printf("         telnet 10.0.2.2 23\n");
 220:	00001517          	auipc	a0,0x1
 224:	ab850513          	add	a0,a0,-1352 # cd8 <malloc+0x14c>
 228:	0b1000ef          	jal	ad8 <printf>
        exit(1);
 22c:	4505                	li	a0,1
 22e:	43a000ef          	jal	668 <exit>
 232:	fa52                	sd	s4,304(sp)
 234:	f656                	sd	s5,296(sp)
 236:	f25a                	sd	s6,288(sp)
 238:	ee5e                	sd	s7,280(sp)
        printf("telnet: invalid IP address\n");
 23a:	00001517          	auipc	a0,0x1
 23e:	abe50513          	add	a0,a0,-1346 # cf8 <malloc+0x16c>
 242:	097000ef          	jal	ad8 <printf>
        exit(1);
 246:	4505                	li	a0,1
 248:	420000ef          	jal	668 <exit>
        port = atoi(argv[2]);
 24c:	01093503          	ld	a0,16(s2)
 250:	256000ef          	jal	4a6 <atoi>
 254:	8b2a                	mv	s6,a0
 256:	b571                	j	e2 <main+0x36>
        printf("telnet: socket failed\n");
 258:	00001517          	auipc	a0,0x1
 25c:	ae850513          	add	a0,a0,-1304 # d40 <malloc+0x1b4>
 260:	079000ef          	jal	ad8 <printf>
        exit(1);
 264:	4505                	li	a0,1
 266:	402000ef          	jal	668 <exit>
        printf("telnet: connection failed\n");
 26a:	00001517          	auipc	a0,0x1
 26e:	aee50513          	add	a0,a0,-1298 # d58 <malloc+0x1cc>
 272:	067000ef          	jal	ad8 <printf>
        close(sock);
 276:	854a                	mv	a0,s2
 278:	418000ef          	jal	690 <close>
        exit(1);
 27c:	4505                	li	a0,1
 27e:	3ea000ef          	jal	668 <exit>
            printf("\nConnection closed\n");
 282:	00001517          	auipc	a0,0x1
 286:	b3650513          	add	a0,a0,-1226 # db8 <malloc+0x22c>
 28a:	04f000ef          	jal	ad8 <printf>
            }
        }
    }
    
    close(sock);
 28e:	854a                	mv	a0,s2
 290:	400000ef          	jal	690 <close>
    exit(0);
 294:	4501                	li	a0,0
 296:	3d2000ef          	jal	668 <exit>

000000000000029a <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start(int argc, char **argv)
{
 29a:	1141                	add	sp,sp,-16
 29c:	e406                	sd	ra,8(sp)
 29e:	e022                	sd	s0,0(sp)
 2a0:	0800                	add	s0,sp,16
  int r;
  extern int main(int argc, char **argv);
  r = main(argc, argv);
 2a2:	e0bff0ef          	jal	ac <main>
  exit(r);
 2a6:	3c2000ef          	jal	668 <exit>

00000000000002aa <strcpy>:
}

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

00000000000002f2 <strncmp>:

int
strncmp(const char *p, const char *q, uint n)
{
 2f2:	1141                	add	sp,sp,-16
 2f4:	e422                	sd	s0,8(sp)
 2f6:	0800                	add	s0,sp,16
  while(n > 0 && *p && *p == *q) {
 2f8:	ce11                	beqz	a2,314 <strncmp+0x22>
 2fa:	00054783          	lbu	a5,0(a0)
 2fe:	cf89                	beqz	a5,318 <strncmp+0x26>
 300:	0005c703          	lbu	a4,0(a1)
 304:	00f71a63          	bne	a4,a5,318 <strncmp+0x26>
    p++, q++, n--;
 308:	0505                	add	a0,a0,1
 30a:	0585                	add	a1,a1,1
 30c:	367d                	addw	a2,a2,-1
  while(n > 0 && *p && *p == *q) {
 30e:	f675                	bnez	a2,2fa <strncmp+0x8>
  }
  if (n == 0)
    return 0;
 310:	4501                	li	a0,0
 312:	a801                	j	322 <strncmp+0x30>
 314:	4501                	li	a0,0
 316:	a031                	j	322 <strncmp+0x30>
  return (uchar)*p - (uchar)*q;
 318:	00054503          	lbu	a0,0(a0)
 31c:	0005c783          	lbu	a5,0(a1)
 320:	9d1d                	subw	a0,a0,a5
}
 322:	6422                	ld	s0,8(sp)
 324:	0141                	add	sp,sp,16
 326:	8082                	ret

0000000000000328 <strcat>:

char*
strcat(char *dst, const char *src)
{
 328:	1141                	add	sp,sp,-16
 32a:	e422                	sd	s0,8(sp)
 32c:	0800                	add	s0,sp,16
  char *p = dst;
  while(*p) p++;
 32e:	00054783          	lbu	a5,0(a0)
 332:	c385                	beqz	a5,352 <strcat+0x2a>
  char *p = dst;
 334:	87aa                	mv	a5,a0
  while(*p) p++;
 336:	0785                	add	a5,a5,1
 338:	0007c703          	lbu	a4,0(a5)
 33c:	ff6d                	bnez	a4,336 <strcat+0xe>
  while((*p++ = *src++) != 0);
 33e:	0585                	add	a1,a1,1
 340:	0785                	add	a5,a5,1
 342:	fff5c703          	lbu	a4,-1(a1)
 346:	fee78fa3          	sb	a4,-1(a5)
 34a:	fb75                	bnez	a4,33e <strcat+0x16>
  return dst;
}
 34c:	6422                	ld	s0,8(sp)
 34e:	0141                	add	sp,sp,16
 350:	8082                	ret
  char *p = dst;
 352:	87aa                	mv	a5,a0
 354:	b7ed                	j	33e <strcat+0x16>

0000000000000356 <strncpy>:

char*
strncpy(char *dst, const char *src, int n)
{
 356:	1141                	add	sp,sp,-16
 358:	e422                	sd	s0,8(sp)
 35a:	0800                	add	s0,sp,16
  char *p = dst;
 35c:	87aa                	mv	a5,a0
  while(n > 0 && *src) {
 35e:	02c05463          	blez	a2,386 <strncpy+0x30>
 362:	0005c703          	lbu	a4,0(a1)
 366:	cb01                	beqz	a4,376 <strncpy+0x20>
    *p++ = *src++;
 368:	0585                	add	a1,a1,1
 36a:	0785                	add	a5,a5,1
 36c:	fee78fa3          	sb	a4,-1(a5)
    n--;
 370:	367d                	addw	a2,a2,-1
  while(n > 0 && *src) {
 372:	fa65                	bnez	a2,362 <strncpy+0xc>
 374:	a809                	j	386 <strncpy+0x30>
  }
  while(n > 0) {
 376:	1602                	sll	a2,a2,0x20
 378:	9201                	srl	a2,a2,0x20
 37a:	963e                	add	a2,a2,a5
    *p++ = 0;
 37c:	0785                	add	a5,a5,1
 37e:	fe078fa3          	sb	zero,-1(a5)
  while(n > 0) {
 382:	fec79de3          	bne	a5,a2,37c <strncpy+0x26>
    n--;
  }
  return dst;
}
 386:	6422                	ld	s0,8(sp)
 388:	0141                	add	sp,sp,16
 38a:	8082                	ret

000000000000038c <strlen>:

uint
strlen(const char *s)
{
 38c:	1141                	add	sp,sp,-16
 38e:	e422                	sd	s0,8(sp)
 390:	0800                	add	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 392:	00054783          	lbu	a5,0(a0)
 396:	cf91                	beqz	a5,3b2 <strlen+0x26>
 398:	0505                	add	a0,a0,1
 39a:	87aa                	mv	a5,a0
 39c:	86be                	mv	a3,a5
 39e:	0785                	add	a5,a5,1
 3a0:	fff7c703          	lbu	a4,-1(a5)
 3a4:	ff65                	bnez	a4,39c <strlen+0x10>
 3a6:	40a6853b          	subw	a0,a3,a0
 3aa:	2505                	addw	a0,a0,1
    ;
  return n;
}
 3ac:	6422                	ld	s0,8(sp)
 3ae:	0141                	add	sp,sp,16
 3b0:	8082                	ret
  for(n = 0; s[n]; n++)
 3b2:	4501                	li	a0,0
 3b4:	bfe5                	j	3ac <strlen+0x20>

00000000000003b6 <memset>:

void*
memset(void *dst, int c, uint n)
{
 3b6:	1141                	add	sp,sp,-16
 3b8:	e422                	sd	s0,8(sp)
 3ba:	0800                	add	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 3bc:	ca19                	beqz	a2,3d2 <memset+0x1c>
 3be:	87aa                	mv	a5,a0
 3c0:	1602                	sll	a2,a2,0x20
 3c2:	9201                	srl	a2,a2,0x20
 3c4:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 3c8:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 3cc:	0785                	add	a5,a5,1
 3ce:	fee79de3          	bne	a5,a4,3c8 <memset+0x12>
  }
  return dst;
}
 3d2:	6422                	ld	s0,8(sp)
 3d4:	0141                	add	sp,sp,16
 3d6:	8082                	ret

00000000000003d8 <strchr>:

char*
strchr(const char *s, char c)
{
 3d8:	1141                	add	sp,sp,-16
 3da:	e422                	sd	s0,8(sp)
 3dc:	0800                	add	s0,sp,16
  for(; *s; s++)
 3de:	00054783          	lbu	a5,0(a0)
 3e2:	cb99                	beqz	a5,3f8 <strchr+0x20>
    if(*s == c)
 3e4:	00f58763          	beq	a1,a5,3f2 <strchr+0x1a>
  for(; *s; s++)
 3e8:	0505                	add	a0,a0,1
 3ea:	00054783          	lbu	a5,0(a0)
 3ee:	fbfd                	bnez	a5,3e4 <strchr+0xc>
      return (char*)s;
  return 0;
 3f0:	4501                	li	a0,0
}
 3f2:	6422                	ld	s0,8(sp)
 3f4:	0141                	add	sp,sp,16
 3f6:	8082                	ret
  return 0;
 3f8:	4501                	li	a0,0
 3fa:	bfe5                	j	3f2 <strchr+0x1a>

00000000000003fc <gets>:

char*
gets(char *buf, int max)
{
 3fc:	711d                	add	sp,sp,-96
 3fe:	ec86                	sd	ra,88(sp)
 400:	e8a2                	sd	s0,80(sp)
 402:	e4a6                	sd	s1,72(sp)
 404:	e0ca                	sd	s2,64(sp)
 406:	fc4e                	sd	s3,56(sp)
 408:	f852                	sd	s4,48(sp)
 40a:	f456                	sd	s5,40(sp)
 40c:	f05a                	sd	s6,32(sp)
 40e:	ec5e                	sd	s7,24(sp)
 410:	1080                	add	s0,sp,96
 412:	8baa                	mv	s7,a0
 414:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 416:	892a                	mv	s2,a0
 418:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 41a:	4aa9                	li	s5,10
 41c:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 41e:	89a6                	mv	s3,s1
 420:	2485                	addw	s1,s1,1
 422:	0344d663          	bge	s1,s4,44e <gets+0x52>
    cc = read(0, &c, 1);
 426:	4605                	li	a2,1
 428:	faf40593          	add	a1,s0,-81
 42c:	4501                	li	a0,0
 42e:	252000ef          	jal	680 <read>
    if(cc < 1)
 432:	00a05e63          	blez	a0,44e <gets+0x52>
    buf[i++] = c;
 436:	faf44783          	lbu	a5,-81(s0)
 43a:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 43e:	01578763          	beq	a5,s5,44c <gets+0x50>
 442:	0905                	add	s2,s2,1
 444:	fd679de3          	bne	a5,s6,41e <gets+0x22>
    buf[i++] = c;
 448:	89a6                	mv	s3,s1
 44a:	a011                	j	44e <gets+0x52>
 44c:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 44e:	99de                	add	s3,s3,s7
 450:	00098023          	sb	zero,0(s3)
  return buf;
}
 454:	855e                	mv	a0,s7
 456:	60e6                	ld	ra,88(sp)
 458:	6446                	ld	s0,80(sp)
 45a:	64a6                	ld	s1,72(sp)
 45c:	6906                	ld	s2,64(sp)
 45e:	79e2                	ld	s3,56(sp)
 460:	7a42                	ld	s4,48(sp)
 462:	7aa2                	ld	s5,40(sp)
 464:	7b02                	ld	s6,32(sp)
 466:	6be2                	ld	s7,24(sp)
 468:	6125                	add	sp,sp,96
 46a:	8082                	ret

000000000000046c <stat>:

int
stat(const char *n, struct stat *st)
{
 46c:	1101                	add	sp,sp,-32
 46e:	ec06                	sd	ra,24(sp)
 470:	e822                	sd	s0,16(sp)
 472:	e04a                	sd	s2,0(sp)
 474:	1000                	add	s0,sp,32
 476:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 478:	4581                	li	a1,0
 47a:	22e000ef          	jal	6a8 <open>
  if(fd < 0)
 47e:	02054263          	bltz	a0,4a2 <stat+0x36>
 482:	e426                	sd	s1,8(sp)
 484:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 486:	85ca                	mv	a1,s2
 488:	238000ef          	jal	6c0 <fstat>
 48c:	892a                	mv	s2,a0
  close(fd);
 48e:	8526                	mv	a0,s1
 490:	200000ef          	jal	690 <close>
  return r;
 494:	64a2                	ld	s1,8(sp)
}
 496:	854a                	mv	a0,s2
 498:	60e2                	ld	ra,24(sp)
 49a:	6442                	ld	s0,16(sp)
 49c:	6902                	ld	s2,0(sp)
 49e:	6105                	add	sp,sp,32
 4a0:	8082                	ret
    return -1;
 4a2:	597d                	li	s2,-1
 4a4:	bfcd                	j	496 <stat+0x2a>

00000000000004a6 <atoi>:

int
atoi(const char *s)
{
 4a6:	1141                	add	sp,sp,-16
 4a8:	e422                	sd	s0,8(sp)
 4aa:	0800                	add	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 4ac:	00054683          	lbu	a3,0(a0)
 4b0:	fd06879b          	addw	a5,a3,-48 # feffd0 <base+0xfeebc0>
 4b4:	0ff7f793          	zext.b	a5,a5
 4b8:	4625                	li	a2,9
 4ba:	02f66863          	bltu	a2,a5,4ea <atoi+0x44>
 4be:	872a                	mv	a4,a0
  n = 0;
 4c0:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 4c2:	0705                	add	a4,a4,1
 4c4:	0025179b          	sllw	a5,a0,0x2
 4c8:	9fa9                	addw	a5,a5,a0
 4ca:	0017979b          	sllw	a5,a5,0x1
 4ce:	9fb5                	addw	a5,a5,a3
 4d0:	fd07851b          	addw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 4d4:	00074683          	lbu	a3,0(a4)
 4d8:	fd06879b          	addw	a5,a3,-48
 4dc:	0ff7f793          	zext.b	a5,a5
 4e0:	fef671e3          	bgeu	a2,a5,4c2 <atoi+0x1c>
  return n;
}
 4e4:	6422                	ld	s0,8(sp)
 4e6:	0141                	add	sp,sp,16
 4e8:	8082                	ret
  n = 0;
 4ea:	4501                	li	a0,0
 4ec:	bfe5                	j	4e4 <atoi+0x3e>

00000000000004ee <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 4ee:	1141                	add	sp,sp,-16
 4f0:	e422                	sd	s0,8(sp)
 4f2:	0800                	add	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 4f4:	02b57463          	bgeu	a0,a1,51c <memmove+0x2e>
    while(n-- > 0)
 4f8:	00c05f63          	blez	a2,516 <memmove+0x28>
 4fc:	1602                	sll	a2,a2,0x20
 4fe:	9201                	srl	a2,a2,0x20
 500:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 504:	872a                	mv	a4,a0
      *dst++ = *src++;
 506:	0585                	add	a1,a1,1
 508:	0705                	add	a4,a4,1
 50a:	fff5c683          	lbu	a3,-1(a1)
 50e:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 512:	fef71ae3          	bne	a4,a5,506 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 516:	6422                	ld	s0,8(sp)
 518:	0141                	add	sp,sp,16
 51a:	8082                	ret
    dst += n;
 51c:	00c50733          	add	a4,a0,a2
    src += n;
 520:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 522:	fec05ae3          	blez	a2,516 <memmove+0x28>
 526:	fff6079b          	addw	a5,a2,-1
 52a:	1782                	sll	a5,a5,0x20
 52c:	9381                	srl	a5,a5,0x20
 52e:	fff7c793          	not	a5,a5
 532:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 534:	15fd                	add	a1,a1,-1
 536:	177d                	add	a4,a4,-1
 538:	0005c683          	lbu	a3,0(a1)
 53c:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 540:	fee79ae3          	bne	a5,a4,534 <memmove+0x46>
 544:	bfc9                	j	516 <memmove+0x28>

0000000000000546 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 546:	1141                	add	sp,sp,-16
 548:	e422                	sd	s0,8(sp)
 54a:	0800                	add	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 54c:	ca05                	beqz	a2,57c <memcmp+0x36>
 54e:	fff6069b          	addw	a3,a2,-1
 552:	1682                	sll	a3,a3,0x20
 554:	9281                	srl	a3,a3,0x20
 556:	0685                	add	a3,a3,1
 558:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 55a:	00054783          	lbu	a5,0(a0)
 55e:	0005c703          	lbu	a4,0(a1)
 562:	00e79863          	bne	a5,a4,572 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 566:	0505                	add	a0,a0,1
    p2++;
 568:	0585                	add	a1,a1,1
  while (n-- > 0) {
 56a:	fed518e3          	bne	a0,a3,55a <memcmp+0x14>
  }
  return 0;
 56e:	4501                	li	a0,0
 570:	a019                	j	576 <memcmp+0x30>
      return *p1 - *p2;
 572:	40e7853b          	subw	a0,a5,a4
}
 576:	6422                	ld	s0,8(sp)
 578:	0141                	add	sp,sp,16
 57a:	8082                	ret
  return 0;
 57c:	4501                	li	a0,0
 57e:	bfe5                	j	576 <memcmp+0x30>

0000000000000580 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 580:	1141                	add	sp,sp,-16
 582:	e406                	sd	ra,8(sp)
 584:	e022                	sd	s0,0(sp)
 586:	0800                	add	s0,sp,16
  return memmove(dst, src, n);
 588:	f67ff0ef          	jal	4ee <memmove>
}
 58c:	60a2                	ld	ra,8(sp)
 58e:	6402                	ld	s0,0(sp)
 590:	0141                	add	sp,sp,16
 592:	8082                	ret

0000000000000594 <sbrk>:

char *
sbrk(int n) {
 594:	1141                	add	sp,sp,-16
 596:	e406                	sd	ra,8(sp)
 598:	e022                	sd	s0,0(sp)
 59a:	0800                	add	s0,sp,16
  return sys_sbrk(n, SBRK_EAGER);
 59c:	4585                	li	a1,1
 59e:	152000ef          	jal	6f0 <sys_sbrk>
}
 5a2:	60a2                	ld	ra,8(sp)
 5a4:	6402                	ld	s0,0(sp)
 5a6:	0141                	add	sp,sp,16
 5a8:	8082                	ret

00000000000005aa <sbrklazy>:

char *
sbrklazy(int n) {
 5aa:	1141                	add	sp,sp,-16
 5ac:	e406                	sd	ra,8(sp)
 5ae:	e022                	sd	s0,0(sp)
 5b0:	0800                	add	s0,sp,16
  return sys_sbrk(n, SBRK_LAZY);
 5b2:	4589                	li	a1,2
 5b4:	13c000ef          	jal	6f0 <sys_sbrk>
}
 5b8:	60a2                	ld	ra,8(sp)
 5ba:	6402                	ld	s0,0(sp)
 5bc:	0141                	add	sp,sp,16
 5be:	8082                	ret

00000000000005c0 <htons>:

// Byte order conversion functions
unsigned short
htons(unsigned short hostshort)
{
 5c0:	1141                	add	sp,sp,-16
 5c2:	e422                	sd	s0,8(sp)
 5c4:	0800                	add	s0,sp,16
  return ((hostshort >> 8) & 0xff) | ((hostshort & 0xff) << 8);
 5c6:	0085179b          	sllw	a5,a0,0x8
 5ca:	0085551b          	srlw	a0,a0,0x8
 5ce:	8d5d                	or	a0,a0,a5
}
 5d0:	1542                	sll	a0,a0,0x30
 5d2:	9141                	srl	a0,a0,0x30
 5d4:	6422                	ld	s0,8(sp)
 5d6:	0141                	add	sp,sp,16
 5d8:	8082                	ret

00000000000005da <ntohs>:

unsigned short
ntohs(unsigned short netshort)
{
 5da:	1141                	add	sp,sp,-16
 5dc:	e422                	sd	s0,8(sp)
 5de:	0800                	add	s0,sp,16
  return ((netshort >> 8) & 0xff) | ((netshort & 0xff) << 8);
 5e0:	0085179b          	sllw	a5,a0,0x8
 5e4:	0085551b          	srlw	a0,a0,0x8
 5e8:	8d5d                	or	a0,a0,a5
}
 5ea:	1542                	sll	a0,a0,0x30
 5ec:	9141                	srl	a0,a0,0x30
 5ee:	6422                	ld	s0,8(sp)
 5f0:	0141                	add	sp,sp,16
 5f2:	8082                	ret

00000000000005f4 <htonl>:

unsigned long
htonl(unsigned long hostlong)
{
 5f4:	1141                	add	sp,sp,-16
 5f6:	e422                	sd	s0,8(sp)
 5f8:	0800                	add	s0,sp,16
  return ((hostlong >> 24) & 0xff) |
 5fa:	0185579b          	srlw	a5,a0,0x18
         ((hostlong >> 8) & 0xff00) |
 5fe:	00855713          	srl	a4,a0,0x8
 602:	66c1                	lui	a3,0x10
 604:	f0068693          	add	a3,a3,-256 # ff00 <base+0xeaf0>
 608:	8f75                	and	a4,a4,a3
  return ((hostlong >> 24) & 0xff) |
 60a:	8fd9                	or	a5,a5,a4
         ((hostlong & 0xff00) << 8) |
 60c:	00851713          	sll	a4,a0,0x8
 610:	00ff06b7          	lui	a3,0xff0
 614:	8f75                	and	a4,a4,a3
         ((hostlong >> 8) & 0xff00) |
 616:	8fd9                	or	a5,a5,a4
         ((hostlong & 0xff) << 24);
 618:	0562                	sll	a0,a0,0x18
 61a:	0ff00713          	li	a4,255
 61e:	0762                	sll	a4,a4,0x18
 620:	8d79                	and	a0,a0,a4
}
 622:	8d5d                	or	a0,a0,a5
 624:	6422                	ld	s0,8(sp)
 626:	0141                	add	sp,sp,16
 628:	8082                	ret

000000000000062a <ntohl>:

unsigned long
ntohl(unsigned long netlong)
{
 62a:	1141                	add	sp,sp,-16
 62c:	e422                	sd	s0,8(sp)
 62e:	0800                	add	s0,sp,16
  return ((netlong >> 24) & 0xff) |
 630:	0185579b          	srlw	a5,a0,0x18
         ((netlong >> 8) & 0xff00) |
 634:	00855713          	srl	a4,a0,0x8
 638:	66c1                	lui	a3,0x10
 63a:	f0068693          	add	a3,a3,-256 # ff00 <base+0xeaf0>
 63e:	8f75                	and	a4,a4,a3
  return ((netlong >> 24) & 0xff) |
 640:	8fd9                	or	a5,a5,a4
         ((netlong & 0xff00) << 8) |
 642:	00851713          	sll	a4,a0,0x8
 646:	00ff06b7          	lui	a3,0xff0
 64a:	8f75                	and	a4,a4,a3
         ((netlong >> 8) & 0xff00) |
 64c:	8fd9                	or	a5,a5,a4
         ((netlong & 0xff) << 24);
 64e:	0562                	sll	a0,a0,0x18
 650:	0ff00713          	li	a4,255
 654:	0762                	sll	a4,a4,0x18
 656:	8d79                	and	a0,a0,a4
}
 658:	8d5d                	or	a0,a0,a5
 65a:	6422                	ld	s0,8(sp)
 65c:	0141                	add	sp,sp,16
 65e:	8082                	ret

0000000000000660 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 660:	4885                	li	a7,1
 ecall
 662:	00000073          	ecall
 ret
 666:	8082                	ret

0000000000000668 <exit>:
.global exit
exit:
 li a7, SYS_exit
 668:	4889                	li	a7,2
 ecall
 66a:	00000073          	ecall
 ret
 66e:	8082                	ret

0000000000000670 <wait>:
.global wait
wait:
 li a7, SYS_wait
 670:	488d                	li	a7,3
 ecall
 672:	00000073          	ecall
 ret
 676:	8082                	ret

0000000000000678 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 678:	4891                	li	a7,4
 ecall
 67a:	00000073          	ecall
 ret
 67e:	8082                	ret

0000000000000680 <read>:
.global read
read:
 li a7, SYS_read
 680:	4895                	li	a7,5
 ecall
 682:	00000073          	ecall
 ret
 686:	8082                	ret

0000000000000688 <write>:
.global write
write:
 li a7, SYS_write
 688:	48c1                	li	a7,16
 ecall
 68a:	00000073          	ecall
 ret
 68e:	8082                	ret

0000000000000690 <close>:
.global close
close:
 li a7, SYS_close
 690:	48d5                	li	a7,21
 ecall
 692:	00000073          	ecall
 ret
 696:	8082                	ret

0000000000000698 <kill>:
.global kill
kill:
 li a7, SYS_kill
 698:	4899                	li	a7,6
 ecall
 69a:	00000073          	ecall
 ret
 69e:	8082                	ret

00000000000006a0 <exec>:
.global exec
exec:
 li a7, SYS_exec
 6a0:	489d                	li	a7,7
 ecall
 6a2:	00000073          	ecall
 ret
 6a6:	8082                	ret

00000000000006a8 <open>:
.global open
open:
 li a7, SYS_open
 6a8:	48bd                	li	a7,15
 ecall
 6aa:	00000073          	ecall
 ret
 6ae:	8082                	ret

00000000000006b0 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 6b0:	48c5                	li	a7,17
 ecall
 6b2:	00000073          	ecall
 ret
 6b6:	8082                	ret

00000000000006b8 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 6b8:	48c9                	li	a7,18
 ecall
 6ba:	00000073          	ecall
 ret
 6be:	8082                	ret

00000000000006c0 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 6c0:	48a1                	li	a7,8
 ecall
 6c2:	00000073          	ecall
 ret
 6c6:	8082                	ret

00000000000006c8 <link>:
.global link
link:
 li a7, SYS_link
 6c8:	48cd                	li	a7,19
 ecall
 6ca:	00000073          	ecall
 ret
 6ce:	8082                	ret

00000000000006d0 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 6d0:	48d1                	li	a7,20
 ecall
 6d2:	00000073          	ecall
 ret
 6d6:	8082                	ret

00000000000006d8 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 6d8:	48a5                	li	a7,9
 ecall
 6da:	00000073          	ecall
 ret
 6de:	8082                	ret

00000000000006e0 <dup>:
.global dup
dup:
 li a7, SYS_dup
 6e0:	48a9                	li	a7,10
 ecall
 6e2:	00000073          	ecall
 ret
 6e6:	8082                	ret

00000000000006e8 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 6e8:	48ad                	li	a7,11
 ecall
 6ea:	00000073          	ecall
 ret
 6ee:	8082                	ret

00000000000006f0 <sys_sbrk>:
.global sys_sbrk
sys_sbrk:
 li a7, SYS_sbrk
 6f0:	48b1                	li	a7,12
 ecall
 6f2:	00000073          	ecall
 ret
 6f6:	8082                	ret

00000000000006f8 <pause>:
.global pause
pause:
 li a7, SYS_pause
 6f8:	48b5                	li	a7,13
 ecall
 6fa:	00000073          	ecall
 ret
 6fe:	8082                	ret

0000000000000700 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 700:	48b9                	li	a7,14
 ecall
 702:	00000073          	ecall
 ret
 706:	8082                	ret

0000000000000708 <socket>:
.global socket
socket:
 li a7, SYS_socket
 708:	48d9                	li	a7,22
 ecall
 70a:	00000073          	ecall
 ret
 70e:	8082                	ret

0000000000000710 <bind>:
.global bind
bind:
 li a7, SYS_bind
 710:	48dd                	li	a7,23
 ecall
 712:	00000073          	ecall
 ret
 716:	8082                	ret

0000000000000718 <listen>:
.global listen
listen:
 li a7, SYS_listen
 718:	48e1                	li	a7,24
 ecall
 71a:	00000073          	ecall
 ret
 71e:	8082                	ret

0000000000000720 <accept>:
.global accept
accept:
 li a7, SYS_accept
 720:	48e5                	li	a7,25
 ecall
 722:	00000073          	ecall
 ret
 726:	8082                	ret

0000000000000728 <connect>:
.global connect
connect:
 li a7, SYS_connect
 728:	48e9                	li	a7,26
 ecall
 72a:	00000073          	ecall
 ret
 72e:	8082                	ret

0000000000000730 <send>:
.global send
send:
 li a7, SYS_send
 730:	48ed                	li	a7,27
 ecall
 732:	00000073          	ecall
 ret
 736:	8082                	ret

0000000000000738 <recv>:
.global recv
recv:
 li a7, SYS_recv
 738:	48f1                	li	a7,28
 ecall
 73a:	00000073          	ecall
 ret
 73e:	8082                	ret

0000000000000740 <sendto>:
.global sendto
sendto:
 li a7, SYS_sendto
 740:	48f5                	li	a7,29
 ecall
 742:	00000073          	ecall
 ret
 746:	8082                	ret

0000000000000748 <recvfrom>:
.global recvfrom
recvfrom:
 li a7, SYS_recvfrom
 748:	48f9                	li	a7,30
 ecall
 74a:	00000073          	ecall
 ret
 74e:	8082                	ret

0000000000000750 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 750:	1101                	add	sp,sp,-32
 752:	ec06                	sd	ra,24(sp)
 754:	e822                	sd	s0,16(sp)
 756:	1000                	add	s0,sp,32
 758:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 75c:	4605                	li	a2,1
 75e:	fef40593          	add	a1,s0,-17
 762:	f27ff0ef          	jal	688 <write>
}
 766:	60e2                	ld	ra,24(sp)
 768:	6442                	ld	s0,16(sp)
 76a:	6105                	add	sp,sp,32
 76c:	8082                	ret

000000000000076e <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
 76e:	715d                	add	sp,sp,-80
 770:	e486                	sd	ra,72(sp)
 772:	e0a2                	sd	s0,64(sp)
 774:	f84a                	sd	s2,48(sp)
 776:	0880                	add	s0,sp,80
 778:	892a                	mv	s2,a0
  char buf[20];
  int i, neg;
  unsigned long long x;

  neg = 0;
  if(sgn && xx < 0){
 77a:	c299                	beqz	a3,780 <printint+0x12>
 77c:	0805c363          	bltz	a1,802 <printint+0x94>
  neg = 0;
 780:	4881                	li	a7,0
 782:	fb840693          	add	a3,s0,-72
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
 786:	4781                	li	a5,0
  do{
    buf[i++] = digits[x % base];
 788:	00000517          	auipc	a0,0x0
 78c:	68050513          	add	a0,a0,1664 # e08 <digits>
 790:	883e                	mv	a6,a5
 792:	2785                	addw	a5,a5,1
 794:	02c5f733          	remu	a4,a1,a2
 798:	972a                	add	a4,a4,a0
 79a:	00074703          	lbu	a4,0(a4)
 79e:	00e68023          	sb	a4,0(a3) # ff0000 <base+0xfeebf0>
  }while((x /= base) != 0);
 7a2:	872e                	mv	a4,a1
 7a4:	02c5d5b3          	divu	a1,a1,a2
 7a8:	0685                	add	a3,a3,1
 7aa:	fec773e3          	bgeu	a4,a2,790 <printint+0x22>
  if(neg)
 7ae:	00088b63          	beqz	a7,7c4 <printint+0x56>
    buf[i++] = '-';
 7b2:	fd078793          	add	a5,a5,-48
 7b6:	97a2                	add	a5,a5,s0
 7b8:	02d00713          	li	a4,45
 7bc:	fee78423          	sb	a4,-24(a5)
 7c0:	0028079b          	addw	a5,a6,2

  while(--i >= 0)
 7c4:	02f05a63          	blez	a5,7f8 <printint+0x8a>
 7c8:	fc26                	sd	s1,56(sp)
 7ca:	f44e                	sd	s3,40(sp)
 7cc:	fb840713          	add	a4,s0,-72
 7d0:	00f704b3          	add	s1,a4,a5
 7d4:	fff70993          	add	s3,a4,-1
 7d8:	99be                	add	s3,s3,a5
 7da:	37fd                	addw	a5,a5,-1
 7dc:	1782                	sll	a5,a5,0x20
 7de:	9381                	srl	a5,a5,0x20
 7e0:	40f989b3          	sub	s3,s3,a5
    putc(fd, buf[i]);
 7e4:	fff4c583          	lbu	a1,-1(s1)
 7e8:	854a                	mv	a0,s2
 7ea:	f67ff0ef          	jal	750 <putc>
  while(--i >= 0)
 7ee:	14fd                	add	s1,s1,-1
 7f0:	ff349ae3          	bne	s1,s3,7e4 <printint+0x76>
 7f4:	74e2                	ld	s1,56(sp)
 7f6:	79a2                	ld	s3,40(sp)
}
 7f8:	60a6                	ld	ra,72(sp)
 7fa:	6406                	ld	s0,64(sp)
 7fc:	7942                	ld	s2,48(sp)
 7fe:	6161                	add	sp,sp,80
 800:	8082                	ret
    x = -xx;
 802:	40b005b3          	neg	a1,a1
    neg = 1;
 806:	4885                	li	a7,1
    x = -xx;
 808:	bfad                	j	782 <printint+0x14>

000000000000080a <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %c, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 80a:	711d                	add	sp,sp,-96
 80c:	ec86                	sd	ra,88(sp)
 80e:	e8a2                	sd	s0,80(sp)
 810:	e0ca                	sd	s2,64(sp)
 812:	1080                	add	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 814:	0005c903          	lbu	s2,0(a1)
 818:	28090663          	beqz	s2,aa4 <vprintf+0x29a>
 81c:	e4a6                	sd	s1,72(sp)
 81e:	fc4e                	sd	s3,56(sp)
 820:	f852                	sd	s4,48(sp)
 822:	f456                	sd	s5,40(sp)
 824:	f05a                	sd	s6,32(sp)
 826:	ec5e                	sd	s7,24(sp)
 828:	e862                	sd	s8,16(sp)
 82a:	e466                	sd	s9,8(sp)
 82c:	8b2a                	mv	s6,a0
 82e:	8a2e                	mv	s4,a1
 830:	8bb2                	mv	s7,a2
  state = 0;
 832:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
 834:	4481                	li	s1,0
 836:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
 838:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
 83c:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
 840:	06c00c93          	li	s9,108
 844:	a005                	j	864 <vprintf+0x5a>
        putc(fd, c0);
 846:	85ca                	mv	a1,s2
 848:	855a                	mv	a0,s6
 84a:	f07ff0ef          	jal	750 <putc>
 84e:	a019                	j	854 <vprintf+0x4a>
    } else if(state == '%'){
 850:	03598263          	beq	s3,s5,874 <vprintf+0x6a>
  for(i = 0; fmt[i]; i++){
 854:	2485                	addw	s1,s1,1
 856:	8726                	mv	a4,s1
 858:	009a07b3          	add	a5,s4,s1
 85c:	0007c903          	lbu	s2,0(a5)
 860:	22090a63          	beqz	s2,a94 <vprintf+0x28a>
    c0 = fmt[i] & 0xff;
 864:	0009079b          	sext.w	a5,s2
    if(state == 0){
 868:	fe0994e3          	bnez	s3,850 <vprintf+0x46>
      if(c0 == '%'){
 86c:	fd579de3          	bne	a5,s5,846 <vprintf+0x3c>
        state = '%';
 870:	89be                	mv	s3,a5
 872:	b7cd                	j	854 <vprintf+0x4a>
      if(c0) c1 = fmt[i+1] & 0xff;
 874:	00ea06b3          	add	a3,s4,a4
 878:	0016c683          	lbu	a3,1(a3)
      c1 = c2 = 0;
 87c:	8636                	mv	a2,a3
      if(c1) c2 = fmt[i+2] & 0xff;
 87e:	c681                	beqz	a3,886 <vprintf+0x7c>
 880:	9752                	add	a4,a4,s4
 882:	00274603          	lbu	a2,2(a4)
      if(c0 == 'd'){
 886:	05878363          	beq	a5,s8,8cc <vprintf+0xc2>
      } else if(c0 == 'l' && c1 == 'd'){
 88a:	05978d63          	beq	a5,s9,8e4 <vprintf+0xda>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
 88e:	07500713          	li	a4,117
 892:	0ee78763          	beq	a5,a4,980 <vprintf+0x176>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
 896:	07800713          	li	a4,120
 89a:	12e78963          	beq	a5,a4,9cc <vprintf+0x1c2>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
 89e:	07000713          	li	a4,112
 8a2:	14e78e63          	beq	a5,a4,9fe <vprintf+0x1f4>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 'c'){
 8a6:	06300713          	li	a4,99
 8aa:	18e78e63          	beq	a5,a4,a46 <vprintf+0x23c>
        putc(fd, va_arg(ap, uint32));
      } else if(c0 == 's'){
 8ae:	07300713          	li	a4,115
 8b2:	1ae78463          	beq	a5,a4,a5a <vprintf+0x250>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
 8b6:	02500713          	li	a4,37
 8ba:	04e79563          	bne	a5,a4,904 <vprintf+0xfa>
        putc(fd, '%');
 8be:	02500593          	li	a1,37
 8c2:	855a                	mv	a0,s6
 8c4:	e8dff0ef          	jal	750 <putc>
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c0);
      }

      state = 0;
 8c8:	4981                	li	s3,0
 8ca:	b769                	j	854 <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 1);
 8cc:	008b8913          	add	s2,s7,8
 8d0:	4685                	li	a3,1
 8d2:	4629                	li	a2,10
 8d4:	000ba583          	lw	a1,0(s7)
 8d8:	855a                	mv	a0,s6
 8da:	e95ff0ef          	jal	76e <printint>
 8de:	8bca                	mv	s7,s2
      state = 0;
 8e0:	4981                	li	s3,0
 8e2:	bf8d                	j	854 <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'd'){
 8e4:	06400793          	li	a5,100
 8e8:	02f68963          	beq	a3,a5,91a <vprintf+0x110>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 8ec:	06c00793          	li	a5,108
 8f0:	04f68263          	beq	a3,a5,934 <vprintf+0x12a>
      } else if(c0 == 'l' && c1 == 'u'){
 8f4:	07500793          	li	a5,117
 8f8:	0af68063          	beq	a3,a5,998 <vprintf+0x18e>
      } else if(c0 == 'l' && c1 == 'x'){
 8fc:	07800793          	li	a5,120
 900:	0ef68263          	beq	a3,a5,9e4 <vprintf+0x1da>
        putc(fd, '%');
 904:	02500593          	li	a1,37
 908:	855a                	mv	a0,s6
 90a:	e47ff0ef          	jal	750 <putc>
        putc(fd, c0);
 90e:	85ca                	mv	a1,s2
 910:	855a                	mv	a0,s6
 912:	e3fff0ef          	jal	750 <putc>
      state = 0;
 916:	4981                	li	s3,0
 918:	bf35                	j	854 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 91a:	008b8913          	add	s2,s7,8
 91e:	4685                	li	a3,1
 920:	4629                	li	a2,10
 922:	000bb583          	ld	a1,0(s7)
 926:	855a                	mv	a0,s6
 928:	e47ff0ef          	jal	76e <printint>
        i += 1;
 92c:	2485                	addw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 92e:	8bca                	mv	s7,s2
      state = 0;
 930:	4981                	li	s3,0
        i += 1;
 932:	b70d                	j	854 <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 934:	06400793          	li	a5,100
 938:	02f60763          	beq	a2,a5,966 <vprintf+0x15c>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 93c:	07500793          	li	a5,117
 940:	06f60963          	beq	a2,a5,9b2 <vprintf+0x1a8>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 944:	07800793          	li	a5,120
 948:	faf61ee3          	bne	a2,a5,904 <vprintf+0xfa>
        printint(fd, va_arg(ap, uint64), 16, 0);
 94c:	008b8913          	add	s2,s7,8
 950:	4681                	li	a3,0
 952:	4641                	li	a2,16
 954:	000bb583          	ld	a1,0(s7)
 958:	855a                	mv	a0,s6
 95a:	e15ff0ef          	jal	76e <printint>
        i += 2;
 95e:	2489                	addw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 960:	8bca                	mv	s7,s2
      state = 0;
 962:	4981                	li	s3,0
        i += 2;
 964:	bdc5                	j	854 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 966:	008b8913          	add	s2,s7,8
 96a:	4685                	li	a3,1
 96c:	4629                	li	a2,10
 96e:	000bb583          	ld	a1,0(s7)
 972:	855a                	mv	a0,s6
 974:	dfbff0ef          	jal	76e <printint>
        i += 2;
 978:	2489                	addw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 97a:	8bca                	mv	s7,s2
      state = 0;
 97c:	4981                	li	s3,0
        i += 2;
 97e:	bdd9                	j	854 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint32), 10, 0);
 980:	008b8913          	add	s2,s7,8
 984:	4681                	li	a3,0
 986:	4629                	li	a2,10
 988:	000be583          	lwu	a1,0(s7)
 98c:	855a                	mv	a0,s6
 98e:	de1ff0ef          	jal	76e <printint>
 992:	8bca                	mv	s7,s2
      state = 0;
 994:	4981                	li	s3,0
 996:	bd7d                	j	854 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 998:	008b8913          	add	s2,s7,8
 99c:	4681                	li	a3,0
 99e:	4629                	li	a2,10
 9a0:	000bb583          	ld	a1,0(s7)
 9a4:	855a                	mv	a0,s6
 9a6:	dc9ff0ef          	jal	76e <printint>
        i += 1;
 9aa:	2485                	addw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 9ac:	8bca                	mv	s7,s2
      state = 0;
 9ae:	4981                	li	s3,0
        i += 1;
 9b0:	b555                	j	854 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 9b2:	008b8913          	add	s2,s7,8
 9b6:	4681                	li	a3,0
 9b8:	4629                	li	a2,10
 9ba:	000bb583          	ld	a1,0(s7)
 9be:	855a                	mv	a0,s6
 9c0:	dafff0ef          	jal	76e <printint>
        i += 2;
 9c4:	2489                	addw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 9c6:	8bca                	mv	s7,s2
      state = 0;
 9c8:	4981                	li	s3,0
        i += 2;
 9ca:	b569                	j	854 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint32), 16, 0);
 9cc:	008b8913          	add	s2,s7,8
 9d0:	4681                	li	a3,0
 9d2:	4641                	li	a2,16
 9d4:	000be583          	lwu	a1,0(s7)
 9d8:	855a                	mv	a0,s6
 9da:	d95ff0ef          	jal	76e <printint>
 9de:	8bca                	mv	s7,s2
      state = 0;
 9e0:	4981                	li	s3,0
 9e2:	bd8d                	j	854 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 16, 0);
 9e4:	008b8913          	add	s2,s7,8
 9e8:	4681                	li	a3,0
 9ea:	4641                	li	a2,16
 9ec:	000bb583          	ld	a1,0(s7)
 9f0:	855a                	mv	a0,s6
 9f2:	d7dff0ef          	jal	76e <printint>
        i += 1;
 9f6:	2485                	addw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 9f8:	8bca                	mv	s7,s2
      state = 0;
 9fa:	4981                	li	s3,0
        i += 1;
 9fc:	bda1                	j	854 <vprintf+0x4a>
 9fe:	e06a                	sd	s10,0(sp)
        printptr(fd, va_arg(ap, uint64));
 a00:	008b8d13          	add	s10,s7,8
 a04:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 a08:	03000593          	li	a1,48
 a0c:	855a                	mv	a0,s6
 a0e:	d43ff0ef          	jal	750 <putc>
  putc(fd, 'x');
 a12:	07800593          	li	a1,120
 a16:	855a                	mv	a0,s6
 a18:	d39ff0ef          	jal	750 <putc>
 a1c:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 a1e:	00000b97          	auipc	s7,0x0
 a22:	3eab8b93          	add	s7,s7,1002 # e08 <digits>
 a26:	03c9d793          	srl	a5,s3,0x3c
 a2a:	97de                	add	a5,a5,s7
 a2c:	0007c583          	lbu	a1,0(a5)
 a30:	855a                	mv	a0,s6
 a32:	d1fff0ef          	jal	750 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 a36:	0992                	sll	s3,s3,0x4
 a38:	397d                	addw	s2,s2,-1
 a3a:	fe0916e3          	bnez	s2,a26 <vprintf+0x21c>
        printptr(fd, va_arg(ap, uint64));
 a3e:	8bea                	mv	s7,s10
      state = 0;
 a40:	4981                	li	s3,0
 a42:	6d02                	ld	s10,0(sp)
 a44:	bd01                	j	854 <vprintf+0x4a>
        putc(fd, va_arg(ap, uint32));
 a46:	008b8913          	add	s2,s7,8
 a4a:	000bc583          	lbu	a1,0(s7)
 a4e:	855a                	mv	a0,s6
 a50:	d01ff0ef          	jal	750 <putc>
 a54:	8bca                	mv	s7,s2
      state = 0;
 a56:	4981                	li	s3,0
 a58:	bbf5                	j	854 <vprintf+0x4a>
        if((s = va_arg(ap, char*)) == 0)
 a5a:	008b8993          	add	s3,s7,8
 a5e:	000bb903          	ld	s2,0(s7)
 a62:	00090f63          	beqz	s2,a80 <vprintf+0x276>
        for(; *s; s++)
 a66:	00094583          	lbu	a1,0(s2)
 a6a:	c195                	beqz	a1,a8e <vprintf+0x284>
          putc(fd, *s);
 a6c:	855a                	mv	a0,s6
 a6e:	ce3ff0ef          	jal	750 <putc>
        for(; *s; s++)
 a72:	0905                	add	s2,s2,1
 a74:	00094583          	lbu	a1,0(s2)
 a78:	f9f5                	bnez	a1,a6c <vprintf+0x262>
        if((s = va_arg(ap, char*)) == 0)
 a7a:	8bce                	mv	s7,s3
      state = 0;
 a7c:	4981                	li	s3,0
 a7e:	bbd9                	j	854 <vprintf+0x4a>
          s = "(null)";
 a80:	00000917          	auipc	s2,0x0
 a84:	38090913          	add	s2,s2,896 # e00 <malloc+0x274>
        for(; *s; s++)
 a88:	02800593          	li	a1,40
 a8c:	b7c5                	j	a6c <vprintf+0x262>
        if((s = va_arg(ap, char*)) == 0)
 a8e:	8bce                	mv	s7,s3
      state = 0;
 a90:	4981                	li	s3,0
 a92:	b3c9                	j	854 <vprintf+0x4a>
 a94:	64a6                	ld	s1,72(sp)
 a96:	79e2                	ld	s3,56(sp)
 a98:	7a42                	ld	s4,48(sp)
 a9a:	7aa2                	ld	s5,40(sp)
 a9c:	7b02                	ld	s6,32(sp)
 a9e:	6be2                	ld	s7,24(sp)
 aa0:	6c42                	ld	s8,16(sp)
 aa2:	6ca2                	ld	s9,8(sp)
    }
  }
}
 aa4:	60e6                	ld	ra,88(sp)
 aa6:	6446                	ld	s0,80(sp)
 aa8:	6906                	ld	s2,64(sp)
 aaa:	6125                	add	sp,sp,96
 aac:	8082                	ret

0000000000000aae <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 aae:	715d                	add	sp,sp,-80
 ab0:	ec06                	sd	ra,24(sp)
 ab2:	e822                	sd	s0,16(sp)
 ab4:	1000                	add	s0,sp,32
 ab6:	e010                	sd	a2,0(s0)
 ab8:	e414                	sd	a3,8(s0)
 aba:	e818                	sd	a4,16(s0)
 abc:	ec1c                	sd	a5,24(s0)
 abe:	03043023          	sd	a6,32(s0)
 ac2:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 ac6:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 aca:	8622                	mv	a2,s0
 acc:	d3fff0ef          	jal	80a <vprintf>
}
 ad0:	60e2                	ld	ra,24(sp)
 ad2:	6442                	ld	s0,16(sp)
 ad4:	6161                	add	sp,sp,80
 ad6:	8082                	ret

0000000000000ad8 <printf>:

void
printf(const char *fmt, ...)
{
 ad8:	711d                	add	sp,sp,-96
 ada:	ec06                	sd	ra,24(sp)
 adc:	e822                	sd	s0,16(sp)
 ade:	1000                	add	s0,sp,32
 ae0:	e40c                	sd	a1,8(s0)
 ae2:	e810                	sd	a2,16(s0)
 ae4:	ec14                	sd	a3,24(s0)
 ae6:	f018                	sd	a4,32(s0)
 ae8:	f41c                	sd	a5,40(s0)
 aea:	03043823          	sd	a6,48(s0)
 aee:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 af2:	00840613          	add	a2,s0,8
 af6:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 afa:	85aa                	mv	a1,a0
 afc:	4505                	li	a0,1
 afe:	d0dff0ef          	jal	80a <vprintf>
}
 b02:	60e2                	ld	ra,24(sp)
 b04:	6442                	ld	s0,16(sp)
 b06:	6125                	add	sp,sp,96
 b08:	8082                	ret

0000000000000b0a <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 b0a:	1141                	add	sp,sp,-16
 b0c:	e422                	sd	s0,8(sp)
 b0e:	0800                	add	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 b10:	ff050693          	add	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 b14:	00000797          	auipc	a5,0x0
 b18:	4ec7b783          	ld	a5,1260(a5) # 1000 <freep>
 b1c:	a02d                	j	b46 <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 b1e:	4618                	lw	a4,8(a2)
 b20:	9f2d                	addw	a4,a4,a1
 b22:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 b26:	6398                	ld	a4,0(a5)
 b28:	6310                	ld	a2,0(a4)
 b2a:	a83d                	j	b68 <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 b2c:	ff852703          	lw	a4,-8(a0)
 b30:	9f31                	addw	a4,a4,a2
 b32:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 b34:	ff053683          	ld	a3,-16(a0)
 b38:	a091                	j	b7c <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 b3a:	6398                	ld	a4,0(a5)
 b3c:	00e7e463          	bltu	a5,a4,b44 <free+0x3a>
 b40:	00e6ea63          	bltu	a3,a4,b54 <free+0x4a>
{
 b44:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 b46:	fed7fae3          	bgeu	a5,a3,b3a <free+0x30>
 b4a:	6398                	ld	a4,0(a5)
 b4c:	00e6e463          	bltu	a3,a4,b54 <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 b50:	fee7eae3          	bltu	a5,a4,b44 <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 b54:	ff852583          	lw	a1,-8(a0)
 b58:	6390                	ld	a2,0(a5)
 b5a:	02059813          	sll	a6,a1,0x20
 b5e:	01c85713          	srl	a4,a6,0x1c
 b62:	9736                	add	a4,a4,a3
 b64:	fae60de3          	beq	a2,a4,b1e <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 b68:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 b6c:	4790                	lw	a2,8(a5)
 b6e:	02061593          	sll	a1,a2,0x20
 b72:	01c5d713          	srl	a4,a1,0x1c
 b76:	973e                	add	a4,a4,a5
 b78:	fae68ae3          	beq	a3,a4,b2c <free+0x22>
    p->s.ptr = bp->s.ptr;
 b7c:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 b7e:	00000717          	auipc	a4,0x0
 b82:	48f73123          	sd	a5,1154(a4) # 1000 <freep>
}
 b86:	6422                	ld	s0,8(sp)
 b88:	0141                	add	sp,sp,16
 b8a:	8082                	ret

0000000000000b8c <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 b8c:	7139                	add	sp,sp,-64
 b8e:	fc06                	sd	ra,56(sp)
 b90:	f822                	sd	s0,48(sp)
 b92:	f426                	sd	s1,40(sp)
 b94:	ec4e                	sd	s3,24(sp)
 b96:	0080                	add	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 b98:	02051493          	sll	s1,a0,0x20
 b9c:	9081                	srl	s1,s1,0x20
 b9e:	04bd                	add	s1,s1,15
 ba0:	8091                	srl	s1,s1,0x4
 ba2:	0014899b          	addw	s3,s1,1
 ba6:	0485                	add	s1,s1,1
  if((prevp = freep) == 0){
 ba8:	00000517          	auipc	a0,0x0
 bac:	45853503          	ld	a0,1112(a0) # 1000 <freep>
 bb0:	c915                	beqz	a0,be4 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 bb2:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 bb4:	4798                	lw	a4,8(a5)
 bb6:	08977a63          	bgeu	a4,s1,c4a <malloc+0xbe>
 bba:	f04a                	sd	s2,32(sp)
 bbc:	e852                	sd	s4,16(sp)
 bbe:	e456                	sd	s5,8(sp)
 bc0:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 bc2:	8a4e                	mv	s4,s3
 bc4:	0009871b          	sext.w	a4,s3
 bc8:	6685                	lui	a3,0x1
 bca:	00d77363          	bgeu	a4,a3,bd0 <malloc+0x44>
 bce:	6a05                	lui	s4,0x1
 bd0:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 bd4:	004a1a1b          	sllw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 bd8:	00000917          	auipc	s2,0x0
 bdc:	42890913          	add	s2,s2,1064 # 1000 <freep>
  if(p == SBRK_ERROR)
 be0:	5afd                	li	s5,-1
 be2:	a081                	j	c22 <malloc+0x96>
 be4:	f04a                	sd	s2,32(sp)
 be6:	e852                	sd	s4,16(sp)
 be8:	e456                	sd	s5,8(sp)
 bea:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 bec:	00001797          	auipc	a5,0x1
 bf0:	82478793          	add	a5,a5,-2012 # 1410 <base>
 bf4:	00000717          	auipc	a4,0x0
 bf8:	40f73623          	sd	a5,1036(a4) # 1000 <freep>
 bfc:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 bfe:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 c02:	b7c1                	j	bc2 <malloc+0x36>
        prevp->s.ptr = p->s.ptr;
 c04:	6398                	ld	a4,0(a5)
 c06:	e118                	sd	a4,0(a0)
 c08:	a8a9                	j	c62 <malloc+0xd6>
  hp->s.size = nu;
 c0a:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 c0e:	0541                	add	a0,a0,16
 c10:	efbff0ef          	jal	b0a <free>
  return freep;
 c14:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 c18:	c12d                	beqz	a0,c7a <malloc+0xee>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 c1a:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 c1c:	4798                	lw	a4,8(a5)
 c1e:	02977263          	bgeu	a4,s1,c42 <malloc+0xb6>
    if(p == freep)
 c22:	00093703          	ld	a4,0(s2)
 c26:	853e                	mv	a0,a5
 c28:	fef719e3          	bne	a4,a5,c1a <malloc+0x8e>
  p = sbrk(nu * sizeof(Header));
 c2c:	8552                	mv	a0,s4
 c2e:	967ff0ef          	jal	594 <sbrk>
  if(p == SBRK_ERROR)
 c32:	fd551ce3          	bne	a0,s5,c0a <malloc+0x7e>
        return 0;
 c36:	4501                	li	a0,0
 c38:	7902                	ld	s2,32(sp)
 c3a:	6a42                	ld	s4,16(sp)
 c3c:	6aa2                	ld	s5,8(sp)
 c3e:	6b02                	ld	s6,0(sp)
 c40:	a03d                	j	c6e <malloc+0xe2>
 c42:	7902                	ld	s2,32(sp)
 c44:	6a42                	ld	s4,16(sp)
 c46:	6aa2                	ld	s5,8(sp)
 c48:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 c4a:	fae48de3          	beq	s1,a4,c04 <malloc+0x78>
        p->s.size -= nunits;
 c4e:	4137073b          	subw	a4,a4,s3
 c52:	c798                	sw	a4,8(a5)
        p += p->s.size;
 c54:	02071693          	sll	a3,a4,0x20
 c58:	01c6d713          	srl	a4,a3,0x1c
 c5c:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 c5e:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 c62:	00000717          	auipc	a4,0x0
 c66:	38a73f23          	sd	a0,926(a4) # 1000 <freep>
      return (void*)(p + 1);
 c6a:	01078513          	add	a0,a5,16
  }
}
 c6e:	70e2                	ld	ra,56(sp)
 c70:	7442                	ld	s0,48(sp)
 c72:	74a2                	ld	s1,40(sp)
 c74:	69e2                	ld	s3,24(sp)
 c76:	6121                	add	sp,sp,64
 c78:	8082                	ret
 c7a:	7902                	ld	s2,32(sp)
 c7c:	6a42                	ld	s4,16(sp)
 c7e:	6aa2                	ld	s5,8(sp)
 c80:	6b02                	ld	s6,0(sp)
 c82:	b7f5                	j	c6e <malloc+0xe2>
