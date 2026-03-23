
user/_httpd:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
    "Content-Length: 9\r\n"
    "\r\n"
    "Not Found";

int main(int argc, char *argv[])
{
   0:	7175                	add	sp,sp,-144
   2:	e506                	sd	ra,136(sp)
   4:	e122                	sd	s0,128(sp)
   6:	fca6                	sd	s1,120(sp)
   8:	f8ca                	sd	s2,112(sp)
   a:	f4ce                	sd	s3,104(sp)
   c:	f0d2                	sd	s4,96(sp)
   e:	ecd6                	sd	s5,88(sp)
  10:	e8da                	sd	s6,80(sp)
  12:	e4de                	sd	s7,72(sp)
  14:	e0e2                	sd	s8,64(sp)
  16:	fc66                	sd	s9,56(sp)
  18:	f86a                	sd	s10,48(sp)
  1a:	0900                	add	s0,sp,144
  1c:	81010113          	add	sp,sp,-2032
    struct sockaddr_in self, peer;
    unsigned char *addr;
    char buf[2048];
    int port = 8080;

    if (argc > 1) {
  20:	4785                	li	a5,1
    int port = 8080;
  22:	6489                	lui	s1,0x2
  24:	f9048493          	add	s1,s1,-112 # 1f90 <base+0xed0>
    if (argc > 1) {
  28:	06a7ca63          	blt	a5,a0,9c <main+0x9c>
        port = atoi(argv[1]);
    }

    printf("Starting HTTP Server on port %d\n", port);
  2c:	85a6                	mv	a1,s1
  2e:	00001517          	auipc	a0,0x1
  32:	cc250513          	add	a0,a0,-830 # cf0 <malloc+0xea>
  36:	31d000ef          	jal	b52 <printf>
    
    soc = socket(PF_INET, SOCK_STREAM, IPPROTO_TCP);
  3a:	4601                	li	a2,0
  3c:	4589                	li	a1,2
  3e:	4505                	li	a0,1
  40:	748000ef          	jal	788 <socket>
  44:	892a                	mv	s2,a0
    if (soc == -1) {
  46:	57fd                	li	a5,-1
  48:	04f50f63          	beq	a0,a5,a6 <main+0xa6>
        printf("socket: failure\n");
        exit(1);
    }
    printf("socket: success, soc=%d\n", soc);
  4c:	85aa                	mv	a1,a0
  4e:	00001517          	auipc	a0,0x1
  52:	ce250513          	add	a0,a0,-798 # d30 <malloc+0x12a>
  56:	2fd000ef          	jal	b52 <printf>
    
    self.sin_family = AF_INET;
  5a:	4785                	li	a5,1
  5c:	f8f41823          	sh	a5,-112(s0)
    self.sin_addr.s_addr = INADDR_ANY;
  60:	f8042a23          	sw	zero,-108(s0)
    self.sin_port = htons(port);
  64:	03049513          	sll	a0,s1,0x30
  68:	9141                	srl	a0,a0,0x30
  6a:	3f6000ef          	jal	460 <htons>
  6e:	f8a41923          	sh	a0,-110(s0)
    
    if (bind(soc, (struct sockaddr *)&self, sizeof(self)) == -1) {
  72:	4621                	li	a2,8
  74:	f9040593          	add	a1,s0,-112
  78:	854a                	mv	a0,s2
  7a:	716000ef          	jal	790 <bind>
  7e:	57fd                	li	a5,-1
  80:	02f51c63          	bne	a0,a5,b8 <main+0xb8>
        printf("bind: failure\n");
  84:	00001517          	auipc	a0,0x1
  88:	ccc50513          	add	a0,a0,-820 # d50 <malloc+0x14a>
  8c:	2c7000ef          	jal	b52 <printf>
        close(soc);
  90:	854a                	mv	a0,s2
  92:	67e000ef          	jal	710 <close>
        exit(1);
  96:	4505                	li	a0,1
  98:	650000ef          	jal	6e8 <exit>
        port = atoi(argv[1]);
  9c:	6588                	ld	a0,8(a1)
  9e:	2d4000ef          	jal	372 <atoi>
  a2:	84aa                	mv	s1,a0
  a4:	b761                	j	2c <main+0x2c>
        printf("socket: failure\n");
  a6:	00001517          	auipc	a0,0x1
  aa:	c7250513          	add	a0,a0,-910 # d18 <malloc+0x112>
  ae:	2a5000ef          	jal	b52 <printf>
        exit(1);
  b2:	4505                	li	a0,1
  b4:	634000ef          	jal	6e8 <exit>
    }
    
    addr = (unsigned char *)&self.sin_addr;
    printf("bind: success, http://%d.%d.%d.%d:%d\n", 
  b8:	f9444483          	lbu	s1,-108(s0)
  bc:	f9544983          	lbu	s3,-107(s0)
  c0:	f9644a03          	lbu	s4,-106(s0)
  c4:	f9744a83          	lbu	s5,-105(s0)
           addr[0], addr[1], addr[2], addr[3], ntohs(self.sin_port));
  c8:	f9245503          	lhu	a0,-110(s0)
  cc:	3d0000ef          	jal	49c <ntohs>
    printf("bind: success, http://%d.%d.%d.%d:%d\n", 
  d0:	0005079b          	sext.w	a5,a0
  d4:	8756                	mv	a4,s5
  d6:	86d2                	mv	a3,s4
  d8:	864e                	mv	a2,s3
  da:	85a6                	mv	a1,s1
  dc:	00001517          	auipc	a0,0x1
  e0:	c8450513          	add	a0,a0,-892 # d60 <malloc+0x15a>
  e4:	26f000ef          	jal	b52 <printf>
    
    listen(soc, 5);
  e8:	4595                	li	a1,5
  ea:	854a                	mv	a0,s2
  ec:	6c4000ef          	jal	7b0 <listen>
    printf("waiting for connection...\n");
  f0:	00001517          	auipc	a0,0x1
  f4:	c9850513          	add	a0,a0,-872 # d88 <malloc+0x182>
  f8:	25b000ef          	jal	b52 <printf>

    while (1) {
        peerlen = sizeof(peer);
  fc:	49a1                	li	s3,8
        
        addr = (unsigned char *)&peer.sin_addr;
        printf("accept: from %d.%d.%d.%d:%d\n", 
               addr[0], addr[1], addr[2], addr[3], ntohs(peer.sin_port));
        
        int ret = recv(acc, buf, sizeof(buf) - 1);
  fe:	7afd                	lui	s5,0xfffff
 100:	788a8793          	add	a5,s5,1928 # fffffffffffff788 <base+0xffffffffffffe6c8>
 104:	00878b33          	add	s6,a5,s0
        if (ret > 0) {
            buf[ret] = '\0';
 108:	fa0a8793          	add	a5,s5,-96
 10c:	00878ab3          	add	s5,a5,s0
            printf("recv: %d bytes\n", ret);
            
            if (buf[0] == 'G' && buf[1] == 'E' && buf[2] == 'T' && buf[3] == ' ') {
                send(acc, HTTP_RESPONSE, strlen(HTTP_RESPONSE));
            } else {
                send(acc, HTTP_RESPONSE_404, strlen(HTTP_RESPONSE_404));
 110:	00001b97          	auipc	s7,0x1
 114:	f40b8b93          	add	s7,s7,-192 # 1050 <HTTP_RESPONSE_404>
 118:	a039                	j	126 <main+0x126>
            printf("accept: failure\n");
 11a:	00001517          	auipc	a0,0x1
 11e:	c8e50513          	add	a0,a0,-882 # da8 <malloc+0x1a2>
 122:	231000ef          	jal	b52 <printf>
        peerlen = sizeof(peer);
 126:	f9342e23          	sw	s3,-100(s0)
        acc = accept(soc, (struct sockaddr *)&peer, &peerlen);
 12a:	f9c40613          	add	a2,s0,-100
 12e:	f8840593          	add	a1,s0,-120
 132:	854a                	mv	a0,s2
 134:	684000ef          	jal	7b8 <accept>
 138:	84aa                	mv	s1,a0
        if (acc == -1) {
 13a:	57fd                	li	a5,-1
 13c:	fcf50fe3          	beq	a0,a5,11a <main+0x11a>
        printf("accept: from %d.%d.%d.%d:%d\n", 
 140:	f8c44a03          	lbu	s4,-116(s0)
 144:	f8d44c03          	lbu	s8,-115(s0)
 148:	f8e44c83          	lbu	s9,-114(s0)
 14c:	f8f44d03          	lbu	s10,-113(s0)
               addr[0], addr[1], addr[2], addr[3], ntohs(peer.sin_port));
 150:	f8a45503          	lhu	a0,-118(s0)
 154:	348000ef          	jal	49c <ntohs>
        printf("accept: from %d.%d.%d.%d:%d\n", 
 158:	0005079b          	sext.w	a5,a0
 15c:	876a                	mv	a4,s10
 15e:	86e6                	mv	a3,s9
 160:	8662                	mv	a2,s8
 162:	85d2                	mv	a1,s4
 164:	00001517          	auipc	a0,0x1
 168:	c5c50513          	add	a0,a0,-932 # dc0 <malloc+0x1ba>
 16c:	1e7000ef          	jal	b52 <printf>
        int ret = recv(acc, buf, sizeof(buf) - 1);
 170:	7ff00613          	li	a2,2047
 174:	85da                	mv	a1,s6
 176:	8526                	mv	a0,s1
 178:	648000ef          	jal	7c0 <recv>
        if (ret > 0) {
 17c:	00a04663          	bgtz	a0,188 <main+0x188>
            }
        }
        
        close(acc);
 180:	8526                	mv	a0,s1
 182:	58e000ef          	jal	710 <close>
 186:	b745                	j	126 <main+0x126>
            buf[ret] = '\0';
 188:	00aa87b3          	add	a5,s5,a0
 18c:	7e078423          	sb	zero,2024(a5)
            printf("recv: %d bytes\n", ret);
 190:	85aa                	mv	a1,a0
 192:	00001517          	auipc	a0,0x1
 196:	c4e50513          	add	a0,a0,-946 # de0 <malloc+0x1da>
 19a:	1b9000ef          	jal	b52 <printf>
            if (buf[0] == 'G' && buf[1] == 'E' && buf[2] == 'T' && buf[3] == ' ') {
 19e:	7e8ac703          	lbu	a4,2024(s5)
 1a2:	04700793          	li	a5,71
 1a6:	00f71863          	bne	a4,a5,1b6 <main+0x1b6>
 1aa:	7e9ac703          	lbu	a4,2025(s5)
 1ae:	04500793          	li	a5,69
 1b2:	00f70c63          	beq	a4,a5,1ca <main+0x1ca>
                send(acc, HTTP_RESPONSE_404, strlen(HTTP_RESPONSE_404));
 1b6:	855e                	mv	a0,s7
 1b8:	0a0000ef          	jal	258 <strlen>
 1bc:	0005061b          	sext.w	a2,a0
 1c0:	85de                	mv	a1,s7
 1c2:	8526                	mv	a0,s1
 1c4:	604000ef          	jal	7c8 <send>
 1c8:	bf65                	j	180 <main+0x180>
            if (buf[0] == 'G' && buf[1] == 'E' && buf[2] == 'T' && buf[3] == ' ') {
 1ca:	7eaac703          	lbu	a4,2026(s5)
 1ce:	05400793          	li	a5,84
 1d2:	fef712e3          	bne	a4,a5,1b6 <main+0x1b6>
 1d6:	7ebac703          	lbu	a4,2027(s5)
 1da:	02000793          	li	a5,32
 1de:	fcf71ce3          	bne	a4,a5,1b6 <main+0x1b6>
                send(acc, HTTP_RESPONSE, strlen(HTTP_RESPONSE));
 1e2:	00001a17          	auipc	s4,0x1
 1e6:	e1ea0a13          	add	s4,s4,-482 # 1000 <HTTP_RESPONSE>
 1ea:	8552                	mv	a0,s4
 1ec:	06c000ef          	jal	258 <strlen>
 1f0:	0005061b          	sext.w	a2,a0
 1f4:	85d2                	mv	a1,s4
 1f6:	8526                	mv	a0,s1
 1f8:	5d0000ef          	jal	7c8 <send>
 1fc:	b751                	j	180 <main+0x180>

00000000000001fe <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start()
{
 1fe:	1141                	add	sp,sp,-16
 200:	e406                	sd	ra,8(sp)
 202:	e022                	sd	s0,0(sp)
 204:	0800                	add	s0,sp,16
  extern int main();
  main();
 206:	dfbff0ef          	jal	0 <main>
  exit(0);
 20a:	4501                	li	a0,0
 20c:	4dc000ef          	jal	6e8 <exit>

0000000000000210 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
 210:	1141                	add	sp,sp,-16
 212:	e422                	sd	s0,8(sp)
 214:	0800                	add	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 216:	87aa                	mv	a5,a0
 218:	0585                	add	a1,a1,1
 21a:	0785                	add	a5,a5,1
 21c:	fff5c703          	lbu	a4,-1(a1)
 220:	fee78fa3          	sb	a4,-1(a5)
 224:	fb75                	bnez	a4,218 <strcpy+0x8>
    ;
  return os;
}
 226:	6422                	ld	s0,8(sp)
 228:	0141                	add	sp,sp,16
 22a:	8082                	ret

000000000000022c <strcmp>:

int
strcmp(const char *p, const char *q)
{
 22c:	1141                	add	sp,sp,-16
 22e:	e422                	sd	s0,8(sp)
 230:	0800                	add	s0,sp,16
  while(*p && *p == *q)
 232:	00054783          	lbu	a5,0(a0)
 236:	cb91                	beqz	a5,24a <strcmp+0x1e>
 238:	0005c703          	lbu	a4,0(a1)
 23c:	00f71763          	bne	a4,a5,24a <strcmp+0x1e>
    p++, q++;
 240:	0505                	add	a0,a0,1
 242:	0585                	add	a1,a1,1
  while(*p && *p == *q)
 244:	00054783          	lbu	a5,0(a0)
 248:	fbe5                	bnez	a5,238 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 24a:	0005c503          	lbu	a0,0(a1)
}
 24e:	40a7853b          	subw	a0,a5,a0
 252:	6422                	ld	s0,8(sp)
 254:	0141                	add	sp,sp,16
 256:	8082                	ret

0000000000000258 <strlen>:

uint
strlen(const char *s)
{
 258:	1141                	add	sp,sp,-16
 25a:	e422                	sd	s0,8(sp)
 25c:	0800                	add	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 25e:	00054783          	lbu	a5,0(a0)
 262:	cf91                	beqz	a5,27e <strlen+0x26>
 264:	0505                	add	a0,a0,1
 266:	87aa                	mv	a5,a0
 268:	86be                	mv	a3,a5
 26a:	0785                	add	a5,a5,1
 26c:	fff7c703          	lbu	a4,-1(a5)
 270:	ff65                	bnez	a4,268 <strlen+0x10>
 272:	40a6853b          	subw	a0,a3,a0
 276:	2505                	addw	a0,a0,1
    ;
  return n;
}
 278:	6422                	ld	s0,8(sp)
 27a:	0141                	add	sp,sp,16
 27c:	8082                	ret
  for(n = 0; s[n]; n++)
 27e:	4501                	li	a0,0
 280:	bfe5                	j	278 <strlen+0x20>

0000000000000282 <memset>:

void*
memset(void *dst, int c, uint n)
{
 282:	1141                	add	sp,sp,-16
 284:	e422                	sd	s0,8(sp)
 286:	0800                	add	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 288:	ca19                	beqz	a2,29e <memset+0x1c>
 28a:	87aa                	mv	a5,a0
 28c:	1602                	sll	a2,a2,0x20
 28e:	9201                	srl	a2,a2,0x20
 290:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 294:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 298:	0785                	add	a5,a5,1
 29a:	fee79de3          	bne	a5,a4,294 <memset+0x12>
  }
  return dst;
}
 29e:	6422                	ld	s0,8(sp)
 2a0:	0141                	add	sp,sp,16
 2a2:	8082                	ret

00000000000002a4 <strchr>:

char*
strchr(const char *s, char c)
{
 2a4:	1141                	add	sp,sp,-16
 2a6:	e422                	sd	s0,8(sp)
 2a8:	0800                	add	s0,sp,16
  for(; *s; s++)
 2aa:	00054783          	lbu	a5,0(a0)
 2ae:	cb99                	beqz	a5,2c4 <strchr+0x20>
    if(*s == c)
 2b0:	00f58763          	beq	a1,a5,2be <strchr+0x1a>
  for(; *s; s++)
 2b4:	0505                	add	a0,a0,1
 2b6:	00054783          	lbu	a5,0(a0)
 2ba:	fbfd                	bnez	a5,2b0 <strchr+0xc>
      return (char*)s;
  return 0;
 2bc:	4501                	li	a0,0
}
 2be:	6422                	ld	s0,8(sp)
 2c0:	0141                	add	sp,sp,16
 2c2:	8082                	ret
  return 0;
 2c4:	4501                	li	a0,0
 2c6:	bfe5                	j	2be <strchr+0x1a>

00000000000002c8 <gets>:

char*
gets(char *buf, int max)
{
 2c8:	711d                	add	sp,sp,-96
 2ca:	ec86                	sd	ra,88(sp)
 2cc:	e8a2                	sd	s0,80(sp)
 2ce:	e4a6                	sd	s1,72(sp)
 2d0:	e0ca                	sd	s2,64(sp)
 2d2:	fc4e                	sd	s3,56(sp)
 2d4:	f852                	sd	s4,48(sp)
 2d6:	f456                	sd	s5,40(sp)
 2d8:	f05a                	sd	s6,32(sp)
 2da:	ec5e                	sd	s7,24(sp)
 2dc:	1080                	add	s0,sp,96
 2de:	8baa                	mv	s7,a0
 2e0:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 2e2:	892a                	mv	s2,a0
 2e4:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 2e6:	4aa9                	li	s5,10
 2e8:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 2ea:	89a6                	mv	s3,s1
 2ec:	2485                	addw	s1,s1,1
 2ee:	0344d663          	bge	s1,s4,31a <gets+0x52>
    cc = read(0, &c, 1);
 2f2:	4605                	li	a2,1
 2f4:	faf40593          	add	a1,s0,-81
 2f8:	4501                	li	a0,0
 2fa:	406000ef          	jal	700 <read>
    if(cc < 1)
 2fe:	00a05e63          	blez	a0,31a <gets+0x52>
    buf[i++] = c;
 302:	faf44783          	lbu	a5,-81(s0)
 306:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 30a:	01578763          	beq	a5,s5,318 <gets+0x50>
 30e:	0905                	add	s2,s2,1
 310:	fd679de3          	bne	a5,s6,2ea <gets+0x22>
  for(i=0; i+1 < max; ){
 314:	89a6                	mv	s3,s1
 316:	a011                	j	31a <gets+0x52>
 318:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 31a:	99de                	add	s3,s3,s7
 31c:	00098023          	sb	zero,0(s3)
  return buf;
}
 320:	855e                	mv	a0,s7
 322:	60e6                	ld	ra,88(sp)
 324:	6446                	ld	s0,80(sp)
 326:	64a6                	ld	s1,72(sp)
 328:	6906                	ld	s2,64(sp)
 32a:	79e2                	ld	s3,56(sp)
 32c:	7a42                	ld	s4,48(sp)
 32e:	7aa2                	ld	s5,40(sp)
 330:	7b02                	ld	s6,32(sp)
 332:	6be2                	ld	s7,24(sp)
 334:	6125                	add	sp,sp,96
 336:	8082                	ret

0000000000000338 <stat>:

int
stat(const char *n, struct stat *st)
{
 338:	1101                	add	sp,sp,-32
 33a:	ec06                	sd	ra,24(sp)
 33c:	e822                	sd	s0,16(sp)
 33e:	e426                	sd	s1,8(sp)
 340:	e04a                	sd	s2,0(sp)
 342:	1000                	add	s0,sp,32
 344:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 346:	4581                	li	a1,0
 348:	3e0000ef          	jal	728 <open>
  if(fd < 0)
 34c:	02054163          	bltz	a0,36e <stat+0x36>
 350:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 352:	85ca                	mv	a1,s2
 354:	3ec000ef          	jal	740 <fstat>
 358:	892a                	mv	s2,a0
  close(fd);
 35a:	8526                	mv	a0,s1
 35c:	3b4000ef          	jal	710 <close>
  return r;
}
 360:	854a                	mv	a0,s2
 362:	60e2                	ld	ra,24(sp)
 364:	6442                	ld	s0,16(sp)
 366:	64a2                	ld	s1,8(sp)
 368:	6902                	ld	s2,0(sp)
 36a:	6105                	add	sp,sp,32
 36c:	8082                	ret
    return -1;
 36e:	597d                	li	s2,-1
 370:	bfc5                	j	360 <stat+0x28>

0000000000000372 <atoi>:

int
atoi(const char *s)
{
 372:	1141                	add	sp,sp,-16
 374:	e422                	sd	s0,8(sp)
 376:	0800                	add	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 378:	00054683          	lbu	a3,0(a0)
 37c:	fd06879b          	addw	a5,a3,-48
 380:	0ff7f793          	zext.b	a5,a5
 384:	4625                	li	a2,9
 386:	02f66863          	bltu	a2,a5,3b6 <atoi+0x44>
 38a:	872a                	mv	a4,a0
  n = 0;
 38c:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 38e:	0705                	add	a4,a4,1
 390:	0025179b          	sllw	a5,a0,0x2
 394:	9fa9                	addw	a5,a5,a0
 396:	0017979b          	sllw	a5,a5,0x1
 39a:	9fb5                	addw	a5,a5,a3
 39c:	fd07851b          	addw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 3a0:	00074683          	lbu	a3,0(a4)
 3a4:	fd06879b          	addw	a5,a3,-48
 3a8:	0ff7f793          	zext.b	a5,a5
 3ac:	fef671e3          	bgeu	a2,a5,38e <atoi+0x1c>
  return n;
}
 3b0:	6422                	ld	s0,8(sp)
 3b2:	0141                	add	sp,sp,16
 3b4:	8082                	ret
  n = 0;
 3b6:	4501                	li	a0,0
 3b8:	bfe5                	j	3b0 <atoi+0x3e>

00000000000003ba <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 3ba:	1141                	add	sp,sp,-16
 3bc:	e422                	sd	s0,8(sp)
 3be:	0800                	add	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 3c0:	02b57463          	bgeu	a0,a1,3e8 <memmove+0x2e>
    while(n-- > 0)
 3c4:	00c05f63          	blez	a2,3e2 <memmove+0x28>
 3c8:	1602                	sll	a2,a2,0x20
 3ca:	9201                	srl	a2,a2,0x20
 3cc:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 3d0:	872a                	mv	a4,a0
      *dst++ = *src++;
 3d2:	0585                	add	a1,a1,1
 3d4:	0705                	add	a4,a4,1
 3d6:	fff5c683          	lbu	a3,-1(a1)
 3da:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 3de:	fee79ae3          	bne	a5,a4,3d2 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 3e2:	6422                	ld	s0,8(sp)
 3e4:	0141                	add	sp,sp,16
 3e6:	8082                	ret
    dst += n;
 3e8:	00c50733          	add	a4,a0,a2
    src += n;
 3ec:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 3ee:	fec05ae3          	blez	a2,3e2 <memmove+0x28>
 3f2:	fff6079b          	addw	a5,a2,-1
 3f6:	1782                	sll	a5,a5,0x20
 3f8:	9381                	srl	a5,a5,0x20
 3fa:	fff7c793          	not	a5,a5
 3fe:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 400:	15fd                	add	a1,a1,-1
 402:	177d                	add	a4,a4,-1
 404:	0005c683          	lbu	a3,0(a1)
 408:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 40c:	fee79ae3          	bne	a5,a4,400 <memmove+0x46>
 410:	bfc9                	j	3e2 <memmove+0x28>

0000000000000412 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 412:	1141                	add	sp,sp,-16
 414:	e422                	sd	s0,8(sp)
 416:	0800                	add	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 418:	ca05                	beqz	a2,448 <memcmp+0x36>
 41a:	fff6069b          	addw	a3,a2,-1
 41e:	1682                	sll	a3,a3,0x20
 420:	9281                	srl	a3,a3,0x20
 422:	0685                	add	a3,a3,1
 424:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 426:	00054783          	lbu	a5,0(a0)
 42a:	0005c703          	lbu	a4,0(a1)
 42e:	00e79863          	bne	a5,a4,43e <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 432:	0505                	add	a0,a0,1
    p2++;
 434:	0585                	add	a1,a1,1
  while (n-- > 0) {
 436:	fed518e3          	bne	a0,a3,426 <memcmp+0x14>
  }
  return 0;
 43a:	4501                	li	a0,0
 43c:	a019                	j	442 <memcmp+0x30>
      return *p1 - *p2;
 43e:	40e7853b          	subw	a0,a5,a4
}
 442:	6422                	ld	s0,8(sp)
 444:	0141                	add	sp,sp,16
 446:	8082                	ret
  return 0;
 448:	4501                	li	a0,0
 44a:	bfe5                	j	442 <memcmp+0x30>

000000000000044c <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 44c:	1141                	add	sp,sp,-16
 44e:	e406                	sd	ra,8(sp)
 450:	e022                	sd	s0,0(sp)
 452:	0800                	add	s0,sp,16
  return memmove(dst, src, n);
 454:	f67ff0ef          	jal	3ba <memmove>
}
 458:	60a2                	ld	ra,8(sp)
 45a:	6402                	ld	s0,0(sp)
 45c:	0141                	add	sp,sp,16
 45e:	8082                	ret

0000000000000460 <htons>:
    return (v & 0x000000ff) << 24 | (v & 0x0000ff00) << 8 | (v & 0x00ff0000) >> 8 | (v & 0xff000000) >> 24;
}

uint16_t
htons(uint16_t h)
{
 460:	1141                	add	sp,sp,-16
 462:	e422                	sd	s0,8(sp)
 464:	0800                	add	s0,sp,16
    if (!endian) {
 466:	00001797          	auipc	a5,0x1
 46a:	c4a7a783          	lw	a5,-950(a5) # 10b0 <endian>
 46e:	e385                	bnez	a5,48e <htons+0x2e>
        endian = byteorder();
 470:	4d200793          	li	a5,1234
 474:	00001717          	auipc	a4,0x1
 478:	c2f72e23          	sw	a5,-964(a4) # 10b0 <endian>
    return (v & 0x00ff) << 8 | (v & 0xff00 ) >> 8;
 47c:	0085579b          	srlw	a5,a0,0x8
 480:	0085151b          	sllw	a0,a0,0x8
 484:	8fc9                	or	a5,a5,a0
 486:	03079513          	sll	a0,a5,0x30
 48a:	9141                	srl	a0,a0,0x30
 48c:	a029                	j	496 <htons+0x36>
    }
    return endian == __LITTLE_ENDIAN ? byteswap16(h) : h;
 48e:	4d200713          	li	a4,1234
 492:	fee785e3          	beq	a5,a4,47c <htons+0x1c>
}
 496:	6422                	ld	s0,8(sp)
 498:	0141                	add	sp,sp,16
 49a:	8082                	ret

000000000000049c <ntohs>:

uint16_t
ntohs(uint16_t n)
{
 49c:	1141                	add	sp,sp,-16
 49e:	e422                	sd	s0,8(sp)
 4a0:	0800                	add	s0,sp,16
    if (!endian) {
 4a2:	00001797          	auipc	a5,0x1
 4a6:	c0e7a783          	lw	a5,-1010(a5) # 10b0 <endian>
 4aa:	e385                	bnez	a5,4ca <ntohs+0x2e>
        endian = byteorder();
 4ac:	4d200793          	li	a5,1234
 4b0:	00001717          	auipc	a4,0x1
 4b4:	c0f72023          	sw	a5,-1024(a4) # 10b0 <endian>
    return (v & 0x00ff) << 8 | (v & 0xff00 ) >> 8;
 4b8:	0085579b          	srlw	a5,a0,0x8
 4bc:	0085151b          	sllw	a0,a0,0x8
 4c0:	8fc9                	or	a5,a5,a0
 4c2:	03079513          	sll	a0,a5,0x30
 4c6:	9141                	srl	a0,a0,0x30
 4c8:	a029                	j	4d2 <ntohs+0x36>
    }
    return endian == __LITTLE_ENDIAN ? byteswap16(n) : n;
 4ca:	4d200713          	li	a4,1234
 4ce:	fee785e3          	beq	a5,a4,4b8 <ntohs+0x1c>
}
 4d2:	6422                	ld	s0,8(sp)
 4d4:	0141                	add	sp,sp,16
 4d6:	8082                	ret

00000000000004d8 <htonl>:

uint32_t
htonl(uint32_t h)
{
 4d8:	1141                	add	sp,sp,-16
 4da:	e422                	sd	s0,8(sp)
 4dc:	0800                	add	s0,sp,16
    if (!endian) {
 4de:	00001797          	auipc	a5,0x1
 4e2:	bd27a783          	lw	a5,-1070(a5) # 10b0 <endian>
 4e6:	ef85                	bnez	a5,51e <htonl+0x46>
        endian = byteorder();
 4e8:	4d200793          	li	a5,1234
 4ec:	00001717          	auipc	a4,0x1
 4f0:	bcf72223          	sw	a5,-1084(a4) # 10b0 <endian>
    return (v & 0x000000ff) << 24 | (v & 0x0000ff00) << 8 | (v & 0x00ff0000) >> 8 | (v & 0xff000000) >> 24;
 4f4:	0185179b          	sllw	a5,a0,0x18
 4f8:	0185571b          	srlw	a4,a0,0x18
 4fc:	8fd9                	or	a5,a5,a4
 4fe:	0085171b          	sllw	a4,a0,0x8
 502:	00ff06b7          	lui	a3,0xff0
 506:	8f75                	and	a4,a4,a3
 508:	8fd9                	or	a5,a5,a4
 50a:	0085551b          	srlw	a0,a0,0x8
 50e:	6741                	lui	a4,0x10
 510:	f0070713          	add	a4,a4,-256 # ff00 <base+0xee40>
 514:	8d79                	and	a0,a0,a4
 516:	8fc9                	or	a5,a5,a0
 518:	0007851b          	sext.w	a0,a5
 51c:	a029                	j	526 <htonl+0x4e>
    }
    return endian == __LITTLE_ENDIAN ? byteswap32(h) : h;
 51e:	4d200713          	li	a4,1234
 522:	fce789e3          	beq	a5,a4,4f4 <htonl+0x1c>
}
 526:	6422                	ld	s0,8(sp)
 528:	0141                	add	sp,sp,16
 52a:	8082                	ret

000000000000052c <ntohl>:

uint32_t
ntohl(uint32_t n)
{
 52c:	1141                	add	sp,sp,-16
 52e:	e422                	sd	s0,8(sp)
 530:	0800                	add	s0,sp,16
    if (!endian) {
 532:	00001797          	auipc	a5,0x1
 536:	b7e7a783          	lw	a5,-1154(a5) # 10b0 <endian>
 53a:	ef85                	bnez	a5,572 <ntohl+0x46>
        endian = byteorder();
 53c:	4d200793          	li	a5,1234
 540:	00001717          	auipc	a4,0x1
 544:	b6f72823          	sw	a5,-1168(a4) # 10b0 <endian>
    return (v & 0x000000ff) << 24 | (v & 0x0000ff00) << 8 | (v & 0x00ff0000) >> 8 | (v & 0xff000000) >> 24;
 548:	0185179b          	sllw	a5,a0,0x18
 54c:	0185571b          	srlw	a4,a0,0x18
 550:	8fd9                	or	a5,a5,a4
 552:	0085171b          	sllw	a4,a0,0x8
 556:	00ff06b7          	lui	a3,0xff0
 55a:	8f75                	and	a4,a4,a3
 55c:	8fd9                	or	a5,a5,a4
 55e:	0085551b          	srlw	a0,a0,0x8
 562:	6741                	lui	a4,0x10
 564:	f0070713          	add	a4,a4,-256 # ff00 <base+0xee40>
 568:	8d79                	and	a0,a0,a4
 56a:	8fc9                	or	a5,a5,a0
 56c:	0007851b          	sext.w	a0,a5
 570:	a029                	j	57a <ntohl+0x4e>
    }
    return endian == __LITTLE_ENDIAN ? byteswap32(n) : n;
 572:	4d200713          	li	a4,1234
 576:	fce789e3          	beq	a5,a4,548 <ntohl+0x1c>
}
 57a:	6422                	ld	s0,8(sp)
 57c:	0141                	add	sp,sp,16
 57e:	8082                	ret

0000000000000580 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
 580:	1141                	add	sp,sp,-16
 582:	e422                	sd	s0,8(sp)
 584:	0800                	add	s0,sp,16
 586:	872a                	mv	a4,a0
    int neg = 0;
    long val = 0;

    // gobble initial whitespace
    while (*s == ' ' || *s == '\t')
 588:	02000693          	li	a3,32
 58c:	4525                	li	a0,9
 58e:	a011                	j	592 <strtol+0x12>
        s++;
 590:	0705                	add	a4,a4,1
    while (*s == ' ' || *s == '\t')
 592:	00074783          	lbu	a5,0(a4)
 596:	fed78de3          	beq	a5,a3,590 <strtol+0x10>
 59a:	fea78be3          	beq	a5,a0,590 <strtol+0x10>

    // plus/minus sign
    if (*s == '+')
 59e:	02b00693          	li	a3,43
 5a2:	02d78663          	beq	a5,a3,5ce <strtol+0x4e>
        s++;
    else if (*s == '-')
 5a6:	02d00693          	li	a3,45
    int neg = 0;
 5aa:	4301                	li	t1,0
    else if (*s == '-')
 5ac:	02d78463          	beq	a5,a3,5d4 <strtol+0x54>
        s++, neg = 1;

    // hex or octal base prefix
    if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
 5b0:	fef67793          	and	a5,a2,-17
 5b4:	eb89                	bnez	a5,5c6 <strtol+0x46>
 5b6:	00074683          	lbu	a3,0(a4)
 5ba:	03000793          	li	a5,48
 5be:	00f68e63          	beq	a3,a5,5da <strtol+0x5a>
        s += 2, base = 16;
    else if (base == 0 && s[0] == '0')
 5c2:	e211                	bnez	a2,5c6 <strtol+0x46>
        s++, base = 8;
    else if (base == 0)
        base = 10;
 5c4:	4629                	li	a2,10
 5c6:	4501                	li	a0,0

    // digits
    while (1) {
        int dig;

        if (*s >= '0' && *s <= '9')
 5c8:	4825                	li	a6,9
            dig = *s - '0';
        else if (*s >= 'a' && *s <= 'z')
 5ca:	48e5                	li	a7,25
 5cc:	a825                	j	604 <strtol+0x84>
        s++;
 5ce:	0705                	add	a4,a4,1
    int neg = 0;
 5d0:	4301                	li	t1,0
 5d2:	bff9                	j	5b0 <strtol+0x30>
        s++, neg = 1;
 5d4:	0705                	add	a4,a4,1
 5d6:	4305                	li	t1,1
 5d8:	bfe1                	j	5b0 <strtol+0x30>
    if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
 5da:	00174683          	lbu	a3,1(a4)
 5de:	07800793          	li	a5,120
 5e2:	00f68663          	beq	a3,a5,5ee <strtol+0x6e>
    else if (base == 0 && s[0] == '0')
 5e6:	f265                	bnez	a2,5c6 <strtol+0x46>
        s++, base = 8;
 5e8:	0705                	add	a4,a4,1
 5ea:	4621                	li	a2,8
 5ec:	bfe9                	j	5c6 <strtol+0x46>
        s += 2, base = 16;
 5ee:	0709                	add	a4,a4,2
 5f0:	4641                	li	a2,16
 5f2:	bfd1                	j	5c6 <strtol+0x46>
            dig = *s - '0';
 5f4:	fd07879b          	addw	a5,a5,-48
            dig = *s - 'a' + 10;
        else if (*s >= 'A' && *s <= 'Z')
            dig = *s - 'A' + 10;
        else
            break;
        if (dig >= base)
 5f8:	04c7d063          	bge	a5,a2,638 <strtol+0xb8>
            break;
        s++, val = (val * base) + dig;
 5fc:	0705                	add	a4,a4,1
 5fe:	02a60533          	mul	a0,a2,a0
 602:	953e                	add	a0,a0,a5
        if (*s >= '0' && *s <= '9')
 604:	00074783          	lbu	a5,0(a4)
 608:	fd07869b          	addw	a3,a5,-48
 60c:	0ff6f693          	zext.b	a3,a3
 610:	fed872e3          	bgeu	a6,a3,5f4 <strtol+0x74>
        else if (*s >= 'a' && *s <= 'z')
 614:	f9f7869b          	addw	a3,a5,-97
 618:	0ff6f693          	zext.b	a3,a3
 61c:	00d8e563          	bltu	a7,a3,626 <strtol+0xa6>
            dig = *s - 'a' + 10;
 620:	fa97879b          	addw	a5,a5,-87
 624:	bfd1                	j	5f8 <strtol+0x78>
        else if (*s >= 'A' && *s <= 'Z')
 626:	fbf7869b          	addw	a3,a5,-65
 62a:	0ff6f693          	zext.b	a3,a3
 62e:	00d8e563          	bltu	a7,a3,638 <strtol+0xb8>
            dig = *s - 'A' + 10;
 632:	fc97879b          	addw	a5,a5,-55
 636:	b7c9                	j	5f8 <strtol+0x78>
        // we don't properly detect overflow!
    }

    if (endptr)
 638:	c191                	beqz	a1,63c <strtol+0xbc>
        *endptr = (char *) s;
 63a:	e198                	sd	a4,0(a1)
    return (neg ? -val : val);
 63c:	00030463          	beqz	t1,644 <strtol+0xc4>
 640:	40a00533          	neg	a0,a0
}
 644:	6422                	ld	s0,8(sp)
 646:	0141                	add	sp,sp,16
 648:	8082                	ret

000000000000064a <inet_pton>:
inet_pton (int family, const char *p, void *n) {
    char *sp, *ep;
    int idx;
    long ret;

    if (family != AF_INET) {
 64a:	4785                	li	a5,1
 64c:	08f51263          	bne	a0,a5,6d0 <inet_pton+0x86>
inet_pton (int family, const char *p, void *n) {
 650:	715d                	add	sp,sp,-80
 652:	e486                	sd	ra,72(sp)
 654:	e0a2                	sd	s0,64(sp)
 656:	fc26                	sd	s1,56(sp)
 658:	f84a                	sd	s2,48(sp)
 65a:	f44e                	sd	s3,40(sp)
 65c:	f052                	sd	s4,32(sp)
 65e:	ec56                	sd	s5,24(sp)
 660:	e85a                	sd	s6,16(sp)
 662:	0880                	add	s0,sp,80
 664:	892e                	mv	s2,a1
 666:	89b2                	mv	s3,a2
 668:	4481                	li	s1,0
        return -1;
    }
    sp = (char *)p;
    for (idx = 0; idx < 4; idx++) {
        ret = strtol(sp, &ep, 10);
        if (ret < 0 || ret > 255) {
 66a:	0ff00a13          	li	s4,255
            return -1;
        }
        if (ep == sp) {
            return -1;
        }
        if ((idx == 3 && *ep != '\0') || (idx != 3 && *ep != '.')) {
 66e:	4a8d                	li	s5,3
 670:	02e00b13          	li	s6,46
 674:	a815                	j	6a8 <inet_pton+0x5e>
 676:	0007c783          	lbu	a5,0(a5)
 67a:	e3ad                	bnez	a5,6dc <inet_pton+0x92>
            return -1;
        }
        ((uint8_t *)n)[idx] = ret;
 67c:	2481                	sext.w	s1,s1
 67e:	99a6                	add	s3,s3,s1
 680:	00a98023          	sb	a0,0(s3)
        sp = ep + 1;
    }
    return 0;
 684:	4501                	li	a0,0
}
 686:	60a6                	ld	ra,72(sp)
 688:	6406                	ld	s0,64(sp)
 68a:	74e2                	ld	s1,56(sp)
 68c:	7942                	ld	s2,48(sp)
 68e:	79a2                	ld	s3,40(sp)
 690:	7a02                	ld	s4,32(sp)
 692:	6ae2                	ld	s5,24(sp)
 694:	6b42                	ld	s6,16(sp)
 696:	6161                	add	sp,sp,80
 698:	8082                	ret
        ((uint8_t *)n)[idx] = ret;
 69a:	00998733          	add	a4,s3,s1
 69e:	00a70023          	sb	a0,0(a4)
        sp = ep + 1;
 6a2:	00178913          	add	s2,a5,1
    for (idx = 0; idx < 4; idx++) {
 6a6:	0485                	add	s1,s1,1
        ret = strtol(sp, &ep, 10);
 6a8:	4629                	li	a2,10
 6aa:	fb840593          	add	a1,s0,-72
 6ae:	854a                	mv	a0,s2
 6b0:	ed1ff0ef          	jal	580 <strtol>
        if (ret < 0 || ret > 255) {
 6b4:	02aa6063          	bltu	s4,a0,6d4 <inet_pton+0x8a>
        if (ep == sp) {
 6b8:	fb843783          	ld	a5,-72(s0)
 6bc:	01278e63          	beq	a5,s2,6d8 <inet_pton+0x8e>
        if ((idx == 3 && *ep != '\0') || (idx != 3 && *ep != '.')) {
 6c0:	fb548be3          	beq	s1,s5,676 <inet_pton+0x2c>
 6c4:	0007c703          	lbu	a4,0(a5)
 6c8:	fd6709e3          	beq	a4,s6,69a <inet_pton+0x50>
            return -1;
 6cc:	557d                	li	a0,-1
 6ce:	bf65                	j	686 <inet_pton+0x3c>
        return -1;
 6d0:	557d                	li	a0,-1
}
 6d2:	8082                	ret
            return -1;
 6d4:	557d                	li	a0,-1
 6d6:	bf45                	j	686 <inet_pton+0x3c>
            return -1;
 6d8:	557d                	li	a0,-1
 6da:	b775                	j	686 <inet_pton+0x3c>
            return -1;
 6dc:	557d                	li	a0,-1
 6de:	b765                	j	686 <inet_pton+0x3c>

00000000000006e0 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 6e0:	4885                	li	a7,1
 ecall
 6e2:	00000073          	ecall
 ret
 6e6:	8082                	ret

00000000000006e8 <exit>:
.global exit
exit:
 li a7, SYS_exit
 6e8:	4889                	li	a7,2
 ecall
 6ea:	00000073          	ecall
 ret
 6ee:	8082                	ret

00000000000006f0 <wait>:
.global wait
wait:
 li a7, SYS_wait
 6f0:	488d                	li	a7,3
 ecall
 6f2:	00000073          	ecall
 ret
 6f6:	8082                	ret

00000000000006f8 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 6f8:	4891                	li	a7,4
 ecall
 6fa:	00000073          	ecall
 ret
 6fe:	8082                	ret

0000000000000700 <read>:
.global read
read:
 li a7, SYS_read
 700:	4895                	li	a7,5
 ecall
 702:	00000073          	ecall
 ret
 706:	8082                	ret

0000000000000708 <write>:
.global write
write:
 li a7, SYS_write
 708:	48c1                	li	a7,16
 ecall
 70a:	00000073          	ecall
 ret
 70e:	8082                	ret

0000000000000710 <close>:
.global close
close:
 li a7, SYS_close
 710:	48d5                	li	a7,21
 ecall
 712:	00000073          	ecall
 ret
 716:	8082                	ret

0000000000000718 <kill>:
.global kill
kill:
 li a7, SYS_kill
 718:	4899                	li	a7,6
 ecall
 71a:	00000073          	ecall
 ret
 71e:	8082                	ret

0000000000000720 <exec>:
.global exec
exec:
 li a7, SYS_exec
 720:	489d                	li	a7,7
 ecall
 722:	00000073          	ecall
 ret
 726:	8082                	ret

0000000000000728 <open>:
.global open
open:
 li a7, SYS_open
 728:	48bd                	li	a7,15
 ecall
 72a:	00000073          	ecall
 ret
 72e:	8082                	ret

0000000000000730 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 730:	48c5                	li	a7,17
 ecall
 732:	00000073          	ecall
 ret
 736:	8082                	ret

0000000000000738 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 738:	48c9                	li	a7,18
 ecall
 73a:	00000073          	ecall
 ret
 73e:	8082                	ret

0000000000000740 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 740:	48a1                	li	a7,8
 ecall
 742:	00000073          	ecall
 ret
 746:	8082                	ret

0000000000000748 <link>:
.global link
link:
 li a7, SYS_link
 748:	48cd                	li	a7,19
 ecall
 74a:	00000073          	ecall
 ret
 74e:	8082                	ret

0000000000000750 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 750:	48d1                	li	a7,20
 ecall
 752:	00000073          	ecall
 ret
 756:	8082                	ret

0000000000000758 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 758:	48a5                	li	a7,9
 ecall
 75a:	00000073          	ecall
 ret
 75e:	8082                	ret

0000000000000760 <dup>:
.global dup
dup:
 li a7, SYS_dup
 760:	48a9                	li	a7,10
 ecall
 762:	00000073          	ecall
 ret
 766:	8082                	ret

0000000000000768 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 768:	48ad                	li	a7,11
 ecall
 76a:	00000073          	ecall
 ret
 76e:	8082                	ret

0000000000000770 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 770:	48b1                	li	a7,12
 ecall
 772:	00000073          	ecall
 ret
 776:	8082                	ret

0000000000000778 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 778:	48b5                	li	a7,13
 ecall
 77a:	00000073          	ecall
 ret
 77e:	8082                	ret

0000000000000780 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 780:	48b9                	li	a7,14
 ecall
 782:	00000073          	ecall
 ret
 786:	8082                	ret

0000000000000788 <socket>:
.global socket
socket:
 li a7, SYS_socket
 788:	48d9                	li	a7,22
 ecall
 78a:	00000073          	ecall
 ret
 78e:	8082                	ret

0000000000000790 <bind>:
.global bind
bind:
 li a7, SYS_bind
 790:	48dd                	li	a7,23
 ecall
 792:	00000073          	ecall
 ret
 796:	8082                	ret

0000000000000798 <recvfrom>:
.global recvfrom
recvfrom:
 li a7, SYS_recvfrom
 798:	48e1                	li	a7,24
 ecall
 79a:	00000073          	ecall
 ret
 79e:	8082                	ret

00000000000007a0 <sendto>:
.global sendto
sendto:
 li a7, SYS_sendto
 7a0:	48e5                	li	a7,25
 ecall
 7a2:	00000073          	ecall
 ret
 7a6:	8082                	ret

00000000000007a8 <connect>:
.global connect
connect:
 li a7, SYS_connect
 7a8:	48e9                	li	a7,26
 ecall
 7aa:	00000073          	ecall
 ret
 7ae:	8082                	ret

00000000000007b0 <listen>:
.global listen
listen:
 li a7, SYS_listen
 7b0:	48ed                	li	a7,27
 ecall
 7b2:	00000073          	ecall
 ret
 7b6:	8082                	ret

00000000000007b8 <accept>:
.global accept
accept:
 li a7, SYS_accept
 7b8:	48f1                	li	a7,28
 ecall
 7ba:	00000073          	ecall
 ret
 7be:	8082                	ret

00000000000007c0 <recv>:
.global recv
recv:
 li a7, SYS_recv
 7c0:	48f5                	li	a7,29
 ecall
 7c2:	00000073          	ecall
 ret
 7c6:	8082                	ret

00000000000007c8 <send>:
.global send
send:
 li a7, SYS_send
 7c8:	48f9                	li	a7,30
 ecall
 7ca:	00000073          	ecall
 ret
 7ce:	8082                	ret

00000000000007d0 <ioctl>:
.global ioctl
ioctl:
 li a7, SYS_ioctl
 7d0:	48fd                	li	a7,31
 ecall
 7d2:	00000073          	ecall
 ret
 7d6:	8082                	ret

00000000000007d8 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 7d8:	1101                	add	sp,sp,-32
 7da:	ec06                	sd	ra,24(sp)
 7dc:	e822                	sd	s0,16(sp)
 7de:	1000                	add	s0,sp,32
 7e0:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 7e4:	4605                	li	a2,1
 7e6:	fef40593          	add	a1,s0,-17
 7ea:	f1fff0ef          	jal	708 <write>
}
 7ee:	60e2                	ld	ra,24(sp)
 7f0:	6442                	ld	s0,16(sp)
 7f2:	6105                	add	sp,sp,32
 7f4:	8082                	ret

00000000000007f6 <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
 7f6:	715d                	add	sp,sp,-80
 7f8:	e486                	sd	ra,72(sp)
 7fa:	e0a2                	sd	s0,64(sp)
 7fc:	fc26                	sd	s1,56(sp)
 7fe:	f84a                	sd	s2,48(sp)
 800:	f44e                	sd	s3,40(sp)
 802:	0880                	add	s0,sp,80
 804:	84aa                	mv	s1,a0
  char buf[20];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 806:	c299                	beqz	a3,80c <printint+0x16>
 808:	0805c763          	bltz	a1,896 <printint+0xa0>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 80c:	2581                	sext.w	a1,a1
  neg = 0;
 80e:	4881                	li	a7,0
 810:	fb840693          	add	a3,s0,-72
  }

  i = 0;
 814:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 816:	2601                	sext.w	a2,a2
 818:	00000517          	auipc	a0,0x0
 81c:	5e050513          	add	a0,a0,1504 # df8 <digits>
 820:	883a                	mv	a6,a4
 822:	2705                	addw	a4,a4,1
 824:	02c5f7bb          	remuw	a5,a1,a2
 828:	1782                	sll	a5,a5,0x20
 82a:	9381                	srl	a5,a5,0x20
 82c:	97aa                	add	a5,a5,a0
 82e:	0007c783          	lbu	a5,0(a5)
 832:	00f68023          	sb	a5,0(a3) # ff0000 <base+0xfeef40>
  }while((x /= base) != 0);
 836:	0005879b          	sext.w	a5,a1
 83a:	02c5d5bb          	divuw	a1,a1,a2
 83e:	0685                	add	a3,a3,1
 840:	fec7f0e3          	bgeu	a5,a2,820 <printint+0x2a>
  if(neg)
 844:	00088c63          	beqz	a7,85c <printint+0x66>
    buf[i++] = '-';
 848:	fd070793          	add	a5,a4,-48
 84c:	00878733          	add	a4,a5,s0
 850:	02d00793          	li	a5,45
 854:	fef70423          	sb	a5,-24(a4)
 858:	0028071b          	addw	a4,a6,2

  while(--i >= 0)
 85c:	02e05663          	blez	a4,888 <printint+0x92>
 860:	fb840793          	add	a5,s0,-72
 864:	00e78933          	add	s2,a5,a4
 868:	fff78993          	add	s3,a5,-1
 86c:	99ba                	add	s3,s3,a4
 86e:	377d                	addw	a4,a4,-1
 870:	1702                	sll	a4,a4,0x20
 872:	9301                	srl	a4,a4,0x20
 874:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 878:	fff94583          	lbu	a1,-1(s2)
 87c:	8526                	mv	a0,s1
 87e:	f5bff0ef          	jal	7d8 <putc>
  while(--i >= 0)
 882:	197d                	add	s2,s2,-1
 884:	ff391ae3          	bne	s2,s3,878 <printint+0x82>
}
 888:	60a6                	ld	ra,72(sp)
 88a:	6406                	ld	s0,64(sp)
 88c:	74e2                	ld	s1,56(sp)
 88e:	7942                	ld	s2,48(sp)
 890:	79a2                	ld	s3,40(sp)
 892:	6161                	add	sp,sp,80
 894:	8082                	ret
    x = -xx;
 896:	40b005bb          	negw	a1,a1
    neg = 1;
 89a:	4885                	li	a7,1
    x = -xx;
 89c:	bf95                	j	810 <printint+0x1a>

000000000000089e <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 89e:	711d                	add	sp,sp,-96
 8a0:	ec86                	sd	ra,88(sp)
 8a2:	e8a2                	sd	s0,80(sp)
 8a4:	e4a6                	sd	s1,72(sp)
 8a6:	e0ca                	sd	s2,64(sp)
 8a8:	fc4e                	sd	s3,56(sp)
 8aa:	f852                	sd	s4,48(sp)
 8ac:	f456                	sd	s5,40(sp)
 8ae:	f05a                	sd	s6,32(sp)
 8b0:	ec5e                	sd	s7,24(sp)
 8b2:	e862                	sd	s8,16(sp)
 8b4:	e466                	sd	s9,8(sp)
 8b6:	e06a                	sd	s10,0(sp)
 8b8:	1080                	add	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 8ba:	0005c903          	lbu	s2,0(a1)
 8be:	24090763          	beqz	s2,b0c <vprintf+0x26e>
 8c2:	8b2a                	mv	s6,a0
 8c4:	8a2e                	mv	s4,a1
 8c6:	8bb2                	mv	s7,a2
  state = 0;
 8c8:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
 8ca:	4481                	li	s1,0
 8cc:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
 8ce:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
 8d2:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
 8d6:	06c00c93          	li	s9,108
 8da:	a005                	j	8fa <vprintf+0x5c>
        putc(fd, c0);
 8dc:	85ca                	mv	a1,s2
 8de:	855a                	mv	a0,s6
 8e0:	ef9ff0ef          	jal	7d8 <putc>
 8e4:	a019                	j	8ea <vprintf+0x4c>
    } else if(state == '%'){
 8e6:	03598263          	beq	s3,s5,90a <vprintf+0x6c>
  for(i = 0; fmt[i]; i++){
 8ea:	2485                	addw	s1,s1,1
 8ec:	8726                	mv	a4,s1
 8ee:	009a07b3          	add	a5,s4,s1
 8f2:	0007c903          	lbu	s2,0(a5)
 8f6:	20090b63          	beqz	s2,b0c <vprintf+0x26e>
    c0 = fmt[i] & 0xff;
 8fa:	0009079b          	sext.w	a5,s2
    if(state == 0){
 8fe:	fe0994e3          	bnez	s3,8e6 <vprintf+0x48>
      if(c0 == '%'){
 902:	fd579de3          	bne	a5,s5,8dc <vprintf+0x3e>
        state = '%';
 906:	89be                	mv	s3,a5
 908:	b7cd                	j	8ea <vprintf+0x4c>
      if(c0) c1 = fmt[i+1] & 0xff;
 90a:	c7c9                	beqz	a5,994 <vprintf+0xf6>
 90c:	00ea06b3          	add	a3,s4,a4
 910:	0016c683          	lbu	a3,1(a3)
      c1 = c2 = 0;
 914:	8636                	mv	a2,a3
      if(c1) c2 = fmt[i+2] & 0xff;
 916:	c681                	beqz	a3,91e <vprintf+0x80>
 918:	9752                	add	a4,a4,s4
 91a:	00274603          	lbu	a2,2(a4)
      if(c0 == 'd'){
 91e:	03878f63          	beq	a5,s8,95c <vprintf+0xbe>
      } else if(c0 == 'l' && c1 == 'd'){
 922:	05978963          	beq	a5,s9,974 <vprintf+0xd6>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
 926:	07500713          	li	a4,117
 92a:	0ee78363          	beq	a5,a4,a10 <vprintf+0x172>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
 92e:	07800713          	li	a4,120
 932:	12e78563          	beq	a5,a4,a5c <vprintf+0x1be>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
 936:	07000713          	li	a4,112
 93a:	14e78a63          	beq	a5,a4,a8e <vprintf+0x1f0>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 's'){
 93e:	07300713          	li	a4,115
 942:	18e78863          	beq	a5,a4,ad2 <vprintf+0x234>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
 946:	02500713          	li	a4,37
 94a:	04e79563          	bne	a5,a4,994 <vprintf+0xf6>
        putc(fd, '%');
 94e:	02500593          	li	a1,37
 952:	855a                	mv	a0,s6
 954:	e85ff0ef          	jal	7d8 <putc>
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
#endif
      state = 0;
 958:	4981                	li	s3,0
 95a:	bf41                	j	8ea <vprintf+0x4c>
        printint(fd, va_arg(ap, int), 10, 1);
 95c:	008b8913          	add	s2,s7,8
 960:	4685                	li	a3,1
 962:	4629                	li	a2,10
 964:	000ba583          	lw	a1,0(s7)
 968:	855a                	mv	a0,s6
 96a:	e8dff0ef          	jal	7f6 <printint>
 96e:	8bca                	mv	s7,s2
      state = 0;
 970:	4981                	li	s3,0
 972:	bfa5                	j	8ea <vprintf+0x4c>
      } else if(c0 == 'l' && c1 == 'd'){
 974:	06400793          	li	a5,100
 978:	02f68963          	beq	a3,a5,9aa <vprintf+0x10c>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 97c:	06c00793          	li	a5,108
 980:	04f68263          	beq	a3,a5,9c4 <vprintf+0x126>
      } else if(c0 == 'l' && c1 == 'u'){
 984:	07500793          	li	a5,117
 988:	0af68063          	beq	a3,a5,a28 <vprintf+0x18a>
      } else if(c0 == 'l' && c1 == 'x'){
 98c:	07800793          	li	a5,120
 990:	0ef68263          	beq	a3,a5,a74 <vprintf+0x1d6>
        putc(fd, '%');
 994:	02500593          	li	a1,37
 998:	855a                	mv	a0,s6
 99a:	e3fff0ef          	jal	7d8 <putc>
        putc(fd, c0);
 99e:	85ca                	mv	a1,s2
 9a0:	855a                	mv	a0,s6
 9a2:	e37ff0ef          	jal	7d8 <putc>
      state = 0;
 9a6:	4981                	li	s3,0
 9a8:	b789                	j	8ea <vprintf+0x4c>
        printint(fd, va_arg(ap, uint64), 10, 1);
 9aa:	008b8913          	add	s2,s7,8
 9ae:	4685                	li	a3,1
 9b0:	4629                	li	a2,10
 9b2:	000bb583          	ld	a1,0(s7)
 9b6:	855a                	mv	a0,s6
 9b8:	e3fff0ef          	jal	7f6 <printint>
        i += 1;
 9bc:	2485                	addw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 9be:	8bca                	mv	s7,s2
      state = 0;
 9c0:	4981                	li	s3,0
        i += 1;
 9c2:	b725                	j	8ea <vprintf+0x4c>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 9c4:	06400793          	li	a5,100
 9c8:	02f60763          	beq	a2,a5,9f6 <vprintf+0x158>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 9cc:	07500793          	li	a5,117
 9d0:	06f60963          	beq	a2,a5,a42 <vprintf+0x1a4>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 9d4:	07800793          	li	a5,120
 9d8:	faf61ee3          	bne	a2,a5,994 <vprintf+0xf6>
        printint(fd, va_arg(ap, uint64), 16, 0);
 9dc:	008b8913          	add	s2,s7,8
 9e0:	4681                	li	a3,0
 9e2:	4641                	li	a2,16
 9e4:	000bb583          	ld	a1,0(s7)
 9e8:	855a                	mv	a0,s6
 9ea:	e0dff0ef          	jal	7f6 <printint>
        i += 2;
 9ee:	2489                	addw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 9f0:	8bca                	mv	s7,s2
      state = 0;
 9f2:	4981                	li	s3,0
        i += 2;
 9f4:	bddd                	j	8ea <vprintf+0x4c>
        printint(fd, va_arg(ap, uint64), 10, 1);
 9f6:	008b8913          	add	s2,s7,8
 9fa:	4685                	li	a3,1
 9fc:	4629                	li	a2,10
 9fe:	000bb583          	ld	a1,0(s7)
 a02:	855a                	mv	a0,s6
 a04:	df3ff0ef          	jal	7f6 <printint>
        i += 2;
 a08:	2489                	addw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 a0a:	8bca                	mv	s7,s2
      state = 0;
 a0c:	4981                	li	s3,0
        i += 2;
 a0e:	bdf1                	j	8ea <vprintf+0x4c>
        printint(fd, va_arg(ap, int), 10, 0);
 a10:	008b8913          	add	s2,s7,8
 a14:	4681                	li	a3,0
 a16:	4629                	li	a2,10
 a18:	000ba583          	lw	a1,0(s7)
 a1c:	855a                	mv	a0,s6
 a1e:	dd9ff0ef          	jal	7f6 <printint>
 a22:	8bca                	mv	s7,s2
      state = 0;
 a24:	4981                	li	s3,0
 a26:	b5d1                	j	8ea <vprintf+0x4c>
        printint(fd, va_arg(ap, uint64), 10, 0);
 a28:	008b8913          	add	s2,s7,8
 a2c:	4681                	li	a3,0
 a2e:	4629                	li	a2,10
 a30:	000bb583          	ld	a1,0(s7)
 a34:	855a                	mv	a0,s6
 a36:	dc1ff0ef          	jal	7f6 <printint>
        i += 1;
 a3a:	2485                	addw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 a3c:	8bca                	mv	s7,s2
      state = 0;
 a3e:	4981                	li	s3,0
        i += 1;
 a40:	b56d                	j	8ea <vprintf+0x4c>
        printint(fd, va_arg(ap, uint64), 10, 0);
 a42:	008b8913          	add	s2,s7,8
 a46:	4681                	li	a3,0
 a48:	4629                	li	a2,10
 a4a:	000bb583          	ld	a1,0(s7)
 a4e:	855a                	mv	a0,s6
 a50:	da7ff0ef          	jal	7f6 <printint>
        i += 2;
 a54:	2489                	addw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 a56:	8bca                	mv	s7,s2
      state = 0;
 a58:	4981                	li	s3,0
        i += 2;
 a5a:	bd41                	j	8ea <vprintf+0x4c>
        printint(fd, va_arg(ap, int), 16, 0);
 a5c:	008b8913          	add	s2,s7,8
 a60:	4681                	li	a3,0
 a62:	4641                	li	a2,16
 a64:	000ba583          	lw	a1,0(s7)
 a68:	855a                	mv	a0,s6
 a6a:	d8dff0ef          	jal	7f6 <printint>
 a6e:	8bca                	mv	s7,s2
      state = 0;
 a70:	4981                	li	s3,0
 a72:	bda5                	j	8ea <vprintf+0x4c>
        printint(fd, va_arg(ap, uint64), 16, 0);
 a74:	008b8913          	add	s2,s7,8
 a78:	4681                	li	a3,0
 a7a:	4641                	li	a2,16
 a7c:	000bb583          	ld	a1,0(s7)
 a80:	855a                	mv	a0,s6
 a82:	d75ff0ef          	jal	7f6 <printint>
        i += 1;
 a86:	2485                	addw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 a88:	8bca                	mv	s7,s2
      state = 0;
 a8a:	4981                	li	s3,0
        i += 1;
 a8c:	bdb9                	j	8ea <vprintf+0x4c>
        printptr(fd, va_arg(ap, uint64));
 a8e:	008b8d13          	add	s10,s7,8
 a92:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 a96:	03000593          	li	a1,48
 a9a:	855a                	mv	a0,s6
 a9c:	d3dff0ef          	jal	7d8 <putc>
  putc(fd, 'x');
 aa0:	07800593          	li	a1,120
 aa4:	855a                	mv	a0,s6
 aa6:	d33ff0ef          	jal	7d8 <putc>
 aaa:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 aac:	00000b97          	auipc	s7,0x0
 ab0:	34cb8b93          	add	s7,s7,844 # df8 <digits>
 ab4:	03c9d793          	srl	a5,s3,0x3c
 ab8:	97de                	add	a5,a5,s7
 aba:	0007c583          	lbu	a1,0(a5)
 abe:	855a                	mv	a0,s6
 ac0:	d19ff0ef          	jal	7d8 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 ac4:	0992                	sll	s3,s3,0x4
 ac6:	397d                	addw	s2,s2,-1
 ac8:	fe0916e3          	bnez	s2,ab4 <vprintf+0x216>
        printptr(fd, va_arg(ap, uint64));
 acc:	8bea                	mv	s7,s10
      state = 0;
 ace:	4981                	li	s3,0
 ad0:	bd29                	j	8ea <vprintf+0x4c>
        if((s = va_arg(ap, char*)) == 0)
 ad2:	008b8993          	add	s3,s7,8
 ad6:	000bb903          	ld	s2,0(s7)
 ada:	00090f63          	beqz	s2,af8 <vprintf+0x25a>
        for(; *s; s++)
 ade:	00094583          	lbu	a1,0(s2)
 ae2:	c195                	beqz	a1,b06 <vprintf+0x268>
          putc(fd, *s);
 ae4:	855a                	mv	a0,s6
 ae6:	cf3ff0ef          	jal	7d8 <putc>
        for(; *s; s++)
 aea:	0905                	add	s2,s2,1
 aec:	00094583          	lbu	a1,0(s2)
 af0:	f9f5                	bnez	a1,ae4 <vprintf+0x246>
        if((s = va_arg(ap, char*)) == 0)
 af2:	8bce                	mv	s7,s3
      state = 0;
 af4:	4981                	li	s3,0
 af6:	bbd5                	j	8ea <vprintf+0x4c>
          s = "(null)";
 af8:	00000917          	auipc	s2,0x0
 afc:	2f890913          	add	s2,s2,760 # df0 <malloc+0x1ea>
        for(; *s; s++)
 b00:	02800593          	li	a1,40
 b04:	b7c5                	j	ae4 <vprintf+0x246>
        if((s = va_arg(ap, char*)) == 0)
 b06:	8bce                	mv	s7,s3
      state = 0;
 b08:	4981                	li	s3,0
 b0a:	b3c5                	j	8ea <vprintf+0x4c>
    }
  }
}
 b0c:	60e6                	ld	ra,88(sp)
 b0e:	6446                	ld	s0,80(sp)
 b10:	64a6                	ld	s1,72(sp)
 b12:	6906                	ld	s2,64(sp)
 b14:	79e2                	ld	s3,56(sp)
 b16:	7a42                	ld	s4,48(sp)
 b18:	7aa2                	ld	s5,40(sp)
 b1a:	7b02                	ld	s6,32(sp)
 b1c:	6be2                	ld	s7,24(sp)
 b1e:	6c42                	ld	s8,16(sp)
 b20:	6ca2                	ld	s9,8(sp)
 b22:	6d02                	ld	s10,0(sp)
 b24:	6125                	add	sp,sp,96
 b26:	8082                	ret

0000000000000b28 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 b28:	715d                	add	sp,sp,-80
 b2a:	ec06                	sd	ra,24(sp)
 b2c:	e822                	sd	s0,16(sp)
 b2e:	1000                	add	s0,sp,32
 b30:	e010                	sd	a2,0(s0)
 b32:	e414                	sd	a3,8(s0)
 b34:	e818                	sd	a4,16(s0)
 b36:	ec1c                	sd	a5,24(s0)
 b38:	03043023          	sd	a6,32(s0)
 b3c:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 b40:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 b44:	8622                	mv	a2,s0
 b46:	d59ff0ef          	jal	89e <vprintf>
}
 b4a:	60e2                	ld	ra,24(sp)
 b4c:	6442                	ld	s0,16(sp)
 b4e:	6161                	add	sp,sp,80
 b50:	8082                	ret

0000000000000b52 <printf>:

void
printf(const char *fmt, ...)
{
 b52:	711d                	add	sp,sp,-96
 b54:	ec06                	sd	ra,24(sp)
 b56:	e822                	sd	s0,16(sp)
 b58:	1000                	add	s0,sp,32
 b5a:	e40c                	sd	a1,8(s0)
 b5c:	e810                	sd	a2,16(s0)
 b5e:	ec14                	sd	a3,24(s0)
 b60:	f018                	sd	a4,32(s0)
 b62:	f41c                	sd	a5,40(s0)
 b64:	03043823          	sd	a6,48(s0)
 b68:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 b6c:	00840613          	add	a2,s0,8
 b70:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 b74:	85aa                	mv	a1,a0
 b76:	4505                	li	a0,1
 b78:	d27ff0ef          	jal	89e <vprintf>
}
 b7c:	60e2                	ld	ra,24(sp)
 b7e:	6442                	ld	s0,16(sp)
 b80:	6125                	add	sp,sp,96
 b82:	8082                	ret

0000000000000b84 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 b84:	1141                	add	sp,sp,-16
 b86:	e422                	sd	s0,8(sp)
 b88:	0800                	add	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 b8a:	ff050693          	add	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 b8e:	00000797          	auipc	a5,0x0
 b92:	52a7b783          	ld	a5,1322(a5) # 10b8 <freep>
 b96:	a02d                	j	bc0 <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 b98:	4618                	lw	a4,8(a2)
 b9a:	9f2d                	addw	a4,a4,a1
 b9c:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 ba0:	6398                	ld	a4,0(a5)
 ba2:	6310                	ld	a2,0(a4)
 ba4:	a83d                	j	be2 <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 ba6:	ff852703          	lw	a4,-8(a0)
 baa:	9f31                	addw	a4,a4,a2
 bac:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 bae:	ff053683          	ld	a3,-16(a0)
 bb2:	a091                	j	bf6 <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 bb4:	6398                	ld	a4,0(a5)
 bb6:	00e7e463          	bltu	a5,a4,bbe <free+0x3a>
 bba:	00e6ea63          	bltu	a3,a4,bce <free+0x4a>
{
 bbe:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 bc0:	fed7fae3          	bgeu	a5,a3,bb4 <free+0x30>
 bc4:	6398                	ld	a4,0(a5)
 bc6:	00e6e463          	bltu	a3,a4,bce <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 bca:	fee7eae3          	bltu	a5,a4,bbe <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 bce:	ff852583          	lw	a1,-8(a0)
 bd2:	6390                	ld	a2,0(a5)
 bd4:	02059813          	sll	a6,a1,0x20
 bd8:	01c85713          	srl	a4,a6,0x1c
 bdc:	9736                	add	a4,a4,a3
 bde:	fae60de3          	beq	a2,a4,b98 <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 be2:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 be6:	4790                	lw	a2,8(a5)
 be8:	02061593          	sll	a1,a2,0x20
 bec:	01c5d713          	srl	a4,a1,0x1c
 bf0:	973e                	add	a4,a4,a5
 bf2:	fae68ae3          	beq	a3,a4,ba6 <free+0x22>
    p->s.ptr = bp->s.ptr;
 bf6:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 bf8:	00000717          	auipc	a4,0x0
 bfc:	4cf73023          	sd	a5,1216(a4) # 10b8 <freep>
}
 c00:	6422                	ld	s0,8(sp)
 c02:	0141                	add	sp,sp,16
 c04:	8082                	ret

0000000000000c06 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 c06:	7139                	add	sp,sp,-64
 c08:	fc06                	sd	ra,56(sp)
 c0a:	f822                	sd	s0,48(sp)
 c0c:	f426                	sd	s1,40(sp)
 c0e:	f04a                	sd	s2,32(sp)
 c10:	ec4e                	sd	s3,24(sp)
 c12:	e852                	sd	s4,16(sp)
 c14:	e456                	sd	s5,8(sp)
 c16:	e05a                	sd	s6,0(sp)
 c18:	0080                	add	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 c1a:	02051493          	sll	s1,a0,0x20
 c1e:	9081                	srl	s1,s1,0x20
 c20:	04bd                	add	s1,s1,15
 c22:	8091                	srl	s1,s1,0x4
 c24:	0014899b          	addw	s3,s1,1
 c28:	0485                	add	s1,s1,1
  if((prevp = freep) == 0){
 c2a:	00000517          	auipc	a0,0x0
 c2e:	48e53503          	ld	a0,1166(a0) # 10b8 <freep>
 c32:	c515                	beqz	a0,c5e <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 c34:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 c36:	4798                	lw	a4,8(a5)
 c38:	02977f63          	bgeu	a4,s1,c76 <malloc+0x70>
  if(nu < 4096)
 c3c:	8a4e                	mv	s4,s3
 c3e:	0009871b          	sext.w	a4,s3
 c42:	6685                	lui	a3,0x1
 c44:	00d77363          	bgeu	a4,a3,c4a <malloc+0x44>
 c48:	6a05                	lui	s4,0x1
 c4a:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 c4e:	004a1a1b          	sllw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 c52:	00000917          	auipc	s2,0x0
 c56:	46690913          	add	s2,s2,1126 # 10b8 <freep>
  if(p == (char*)-1)
 c5a:	5afd                	li	s5,-1
 c5c:	a885                	j	ccc <malloc+0xc6>
    base.s.ptr = freep = prevp = &base;
 c5e:	00000797          	auipc	a5,0x0
 c62:	46278793          	add	a5,a5,1122 # 10c0 <base>
 c66:	00000717          	auipc	a4,0x0
 c6a:	44f73923          	sd	a5,1106(a4) # 10b8 <freep>
 c6e:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 c70:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 c74:	b7e1                	j	c3c <malloc+0x36>
      if(p->s.size == nunits)
 c76:	02e48c63          	beq	s1,a4,cae <malloc+0xa8>
        p->s.size -= nunits;
 c7a:	4137073b          	subw	a4,a4,s3
 c7e:	c798                	sw	a4,8(a5)
        p += p->s.size;
 c80:	02071693          	sll	a3,a4,0x20
 c84:	01c6d713          	srl	a4,a3,0x1c
 c88:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 c8a:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 c8e:	00000717          	auipc	a4,0x0
 c92:	42a73523          	sd	a0,1066(a4) # 10b8 <freep>
      return (void*)(p + 1);
 c96:	01078513          	add	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 c9a:	70e2                	ld	ra,56(sp)
 c9c:	7442                	ld	s0,48(sp)
 c9e:	74a2                	ld	s1,40(sp)
 ca0:	7902                	ld	s2,32(sp)
 ca2:	69e2                	ld	s3,24(sp)
 ca4:	6a42                	ld	s4,16(sp)
 ca6:	6aa2                	ld	s5,8(sp)
 ca8:	6b02                	ld	s6,0(sp)
 caa:	6121                	add	sp,sp,64
 cac:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 cae:	6398                	ld	a4,0(a5)
 cb0:	e118                	sd	a4,0(a0)
 cb2:	bff1                	j	c8e <malloc+0x88>
  hp->s.size = nu;
 cb4:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 cb8:	0541                	add	a0,a0,16
 cba:	ecbff0ef          	jal	b84 <free>
  return freep;
 cbe:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 cc2:	dd61                	beqz	a0,c9a <malloc+0x94>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 cc4:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 cc6:	4798                	lw	a4,8(a5)
 cc8:	fa9777e3          	bgeu	a4,s1,c76 <malloc+0x70>
    if(p == freep)
 ccc:	00093703          	ld	a4,0(s2)
 cd0:	853e                	mv	a0,a5
 cd2:	fef719e3          	bne	a4,a5,cc4 <malloc+0xbe>
  p = sbrk(nu * sizeof(Header));
 cd6:	8552                	mv	a0,s4
 cd8:	a99ff0ef          	jal	770 <sbrk>
  if(p == (char*)-1)
 cdc:	fd551ce3          	bne	a0,s5,cb4 <malloc+0xae>
        return 0;
 ce0:	4501                	li	a0,0
 ce2:	bf65                	j	c9a <malloc+0x94>
