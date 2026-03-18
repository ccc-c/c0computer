
user/_telnetd:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <process_client>:
char recvbuf[1024];
char sendbuf[1024];

void
process_client(int client_sock)
{
   0:	7139                	add	sp,sp,-64
   2:	fc06                	sd	ra,56(sp)
   4:	f822                	sd	s0,48(sp)
   6:	f426                	sd	s1,40(sp)
   8:	f04a                	sd	s2,32(sp)
   a:	ec4e                	sd	s3,24(sp)
   c:	e852                	sd	s4,16(sp)
   e:	e456                	sd	s5,8(sp)
  10:	e05a                	sd	s6,0(sp)
  12:	0080                	add	s0,sp,64
  14:	89aa                	mv	s3,a0
        short ws_col;
        short ws_xpixel;
        short ws_ypixel;
    };
    
    printf("Client connected\n");
  16:	00001517          	auipc	a0,0x1
  1a:	bca50513          	add	a0,a0,-1078 # be0 <malloc+0x104>
  1e:	20b000ef          	jal	a28 <printf>
    
    const char *welcome = 
        "xv6 Telnet Server\r\n"
        "Type 'exit' to disconnect\r\n"
        "\r\n";
    send(client_sock, welcome, strlen(welcome), 0);
  22:	00001517          	auipc	a0,0x1
  26:	bd650513          	add	a0,a0,-1066 # bf8 <malloc+0x11c>
  2a:	2b2000ef          	jal	2dc <strlen>
  2e:	4681                	li	a3,0
  30:	0005061b          	sext.w	a2,a0
  34:	00001597          	auipc	a1,0x1
  38:	bc458593          	add	a1,a1,-1084 # bf8 <malloc+0x11c>
  3c:	854e                	mv	a0,s3
  3e:	642000ef          	jal	680 <send>
    
    while ((ret = recv(client_sock, recvbuf, sizeof(recvbuf) - 1, 0)) > 0) {
  42:	00001917          	auipc	s2,0x1
  46:	fce90913          	add	s2,s2,-50 # 1010 <recvbuf>
        recvbuf[ret] = '\0';
        
        if (strncmp(recvbuf, "exit", 4) == 0) {
  4a:	00001a17          	auipc	s4,0x1
  4e:	be6a0a13          	add	s4,s4,-1050 # c30 <malloc+0x154>
            const char *bye = "Goodbye!\r\n";
            send(client_sock, bye, strlen(bye), 0);
            break;
        }
        
        if (strncmp(recvbuf, "\x03", 1) == 0) {
  52:	00001a97          	auipc	s5,0x1
  56:	bf6a8a93          	add	s5,s5,-1034 # c48 <malloc+0x16c>
            break;
        }
        
        printf("Received: %s", recvbuf);
  5a:	00001b17          	auipc	s6,0x1
  5e:	bf6b0b13          	add	s6,s6,-1034 # c50 <malloc+0x174>
    while ((ret = recv(client_sock, recvbuf, sizeof(recvbuf) - 1, 0)) > 0) {
  62:	a8b1                	j	be <process_client+0xbe>
            send(client_sock, bye, strlen(bye), 0);
  64:	00001517          	auipc	a0,0x1
  68:	bd450513          	add	a0,a0,-1068 # c38 <malloc+0x15c>
  6c:	270000ef          	jal	2dc <strlen>
  70:	4681                	li	a3,0
  72:	0005061b          	sext.w	a2,a0
  76:	00001597          	auipc	a1,0x1
  7a:	bc258593          	add	a1,a1,-1086 # c38 <malloc+0x15c>
  7e:	854e                	mv	a0,s3
  80:	600000ef          	jal	680 <send>
        
        send(client_sock, recvbuf, ret, 0);
    }
    
    printf("Client disconnected\n");
  84:	00001517          	auipc	a0,0x1
  88:	bdc50513          	add	a0,a0,-1060 # c60 <malloc+0x184>
  8c:	19d000ef          	jal	a28 <printf>
    close(client_sock);
  90:	854e                	mv	a0,s3
  92:	54e000ef          	jal	5e0 <close>
}
  96:	70e2                	ld	ra,56(sp)
  98:	7442                	ld	s0,48(sp)
  9a:	74a2                	ld	s1,40(sp)
  9c:	7902                	ld	s2,32(sp)
  9e:	69e2                	ld	s3,24(sp)
  a0:	6a42                	ld	s4,16(sp)
  a2:	6aa2                	ld	s5,8(sp)
  a4:	6b02                	ld	s6,0(sp)
  a6:	6121                	add	sp,sp,64
  a8:	8082                	ret
        printf("Received: %s", recvbuf);
  aa:	85ca                	mv	a1,s2
  ac:	855a                	mv	a0,s6
  ae:	17b000ef          	jal	a28 <printf>
        send(client_sock, recvbuf, ret, 0);
  b2:	4681                	li	a3,0
  b4:	8626                	mv	a2,s1
  b6:	85ca                	mv	a1,s2
  b8:	854e                	mv	a0,s3
  ba:	5c6000ef          	jal	680 <send>
    while ((ret = recv(client_sock, recvbuf, sizeof(recvbuf) - 1, 0)) > 0) {
  be:	4681                	li	a3,0
  c0:	3ff00613          	li	a2,1023
  c4:	85ca                	mv	a1,s2
  c6:	854e                	mv	a0,s3
  c8:	5c0000ef          	jal	688 <recv>
  cc:	84aa                	mv	s1,a0
  ce:	faa05be3          	blez	a0,84 <process_client+0x84>
        recvbuf[ret] = '\0';
  d2:	009907b3          	add	a5,s2,s1
  d6:	00078023          	sb	zero,0(a5)
        if (strncmp(recvbuf, "exit", 4) == 0) {
  da:	4611                	li	a2,4
  dc:	85d2                	mv	a1,s4
  de:	854a                	mv	a0,s2
  e0:	162000ef          	jal	242 <strncmp>
  e4:	d141                	beqz	a0,64 <process_client+0x64>
        if (strncmp(recvbuf, "\x03", 1) == 0) {
  e6:	4605                	li	a2,1
  e8:	85d6                	mv	a1,s5
  ea:	854a                	mv	a0,s2
  ec:	156000ef          	jal	242 <strncmp>
  f0:	fd4d                	bnez	a0,aa <process_client+0xaa>
  f2:	bf49                	j	84 <process_client+0x84>

00000000000000f4 <main>:

int
main(int argc, char *argv[])
{
  f4:	715d                	add	sp,sp,-80
  f6:	e486                	sd	ra,72(sp)
  f8:	e0a2                	sd	s0,64(sp)
  fa:	fc26                	sd	s1,56(sp)
  fc:	f84a                	sd	s2,48(sp)
  fe:	0880                	add	s0,sp,80
    int soc, client_sock;
    struct sockaddr_in server_addr, client_addr;
    int client_addr_len;
    int port = 23;
    
    if (argc > 1) {
 100:	4785                	li	a5,1
    int port = 23;
 102:	495d                	li	s2,23
    if (argc > 1) {
 104:	06a7c863          	blt	a5,a0,174 <main+0x80>
        port = atoi(argv[1]);
    }
    
    printf("Telnet Server starting on port %d\n", port);
 108:	85ca                	mv	a1,s2
 10a:	00001517          	auipc	a0,0x1
 10e:	b6e50513          	add	a0,a0,-1170 # c78 <malloc+0x19c>
 112:	117000ef          	jal	a28 <printf>
    
    soc = socket(PF_INET, SOCK_STREAM, IPPROTO_TCP);
 116:	4601                	li	a2,0
 118:	4589                	li	a1,2
 11a:	4505                	li	a0,1
 11c:	53c000ef          	jal	658 <socket>
 120:	84aa                	mv	s1,a0
    if (soc < 0) {
 122:	04054e63          	bltz	a0,17e <main+0x8a>
        printf("telnetd: socket failed\n");
        exit(1);
    }
    
    server_addr.sin_family = AF_INET;
 126:	4785                	li	a5,1
 128:	fcf41423          	sh	a5,-56(s0)
    server_addr.sin_addr.s_addr = INADDR_ANY;
 12c:	fc042623          	sw	zero,-52(s0)
    server_addr.sin_port = htons(port);
 130:	03091513          	sll	a0,s2,0x30
 134:	9141                	srl	a0,a0,0x30
 136:	3da000ef          	jal	510 <htons>
 13a:	fca41523          	sh	a0,-54(s0)
    
    if (bind(soc, (struct sockaddr *)&server_addr, sizeof(server_addr)) < 0) {
 13e:	4621                	li	a2,8
 140:	fc840593          	add	a1,s0,-56
 144:	8526                	mv	a0,s1
 146:	51a000ef          	jal	660 <bind>
 14a:	04054463          	bltz	a0,192 <main+0x9e>
        printf("telnetd: bind failed\n");
        close(soc);
        exit(1);
    }
    
    if (listen(soc, 5) < 0) {
 14e:	4595                	li	a1,5
 150:	8526                	mv	a0,s1
 152:	516000ef          	jal	668 <listen>
 156:	04055b63          	bgez	a0,1ac <main+0xb8>
 15a:	f44e                	sd	s3,40(sp)
        printf("telnetd: listen failed\n");
 15c:	00001517          	auipc	a0,0x1
 160:	b7450513          	add	a0,a0,-1164 # cd0 <malloc+0x1f4>
 164:	0c5000ef          	jal	a28 <printf>
        close(soc);
 168:	8526                	mv	a0,s1
 16a:	476000ef          	jal	5e0 <close>
        exit(1);
 16e:	4505                	li	a0,1
 170:	448000ef          	jal	5b8 <exit>
        port = atoi(argv[1]);
 174:	6588                	ld	a0,8(a1)
 176:	280000ef          	jal	3f6 <atoi>
 17a:	892a                	mv	s2,a0
 17c:	b771                	j	108 <main+0x14>
 17e:	f44e                	sd	s3,40(sp)
        printf("telnetd: socket failed\n");
 180:	00001517          	auipc	a0,0x1
 184:	b2050513          	add	a0,a0,-1248 # ca0 <malloc+0x1c4>
 188:	0a1000ef          	jal	a28 <printf>
        exit(1);
 18c:	4505                	li	a0,1
 18e:	42a000ef          	jal	5b8 <exit>
 192:	f44e                	sd	s3,40(sp)
        printf("telnetd: bind failed\n");
 194:	00001517          	auipc	a0,0x1
 198:	b2450513          	add	a0,a0,-1244 # cb8 <malloc+0x1dc>
 19c:	08d000ef          	jal	a28 <printf>
        close(soc);
 1a0:	8526                	mv	a0,s1
 1a2:	43e000ef          	jal	5e0 <close>
        exit(1);
 1a6:	4505                	li	a0,1
 1a8:	410000ef          	jal	5b8 <exit>
 1ac:	f44e                	sd	s3,40(sp)
    }
    
    printf("Telnet Server listening on port %d\n", port);
 1ae:	85ca                	mv	a1,s2
 1b0:	00001517          	auipc	a0,0x1
 1b4:	b3850513          	add	a0,a0,-1224 # ce8 <malloc+0x20c>
 1b8:	071000ef          	jal	a28 <printf>
    
    while (1) {
        client_addr_len = sizeof(client_addr);
 1bc:	4921                	li	s2,8
        client_sock = accept(soc, (struct sockaddr *)&client_addr, &client_addr_len);
        
        if (client_sock < 0) {
            printf("telnetd: accept failed\n");
 1be:	00001997          	auipc	s3,0x1
 1c2:	b5298993          	add	s3,s3,-1198 # d10 <malloc+0x234>
 1c6:	a021                	j	1ce <main+0xda>
 1c8:	854e                	mv	a0,s3
 1ca:	05f000ef          	jal	a28 <printf>
        client_addr_len = sizeof(client_addr);
 1ce:	fb242e23          	sw	s2,-68(s0)
        client_sock = accept(soc, (struct sockaddr *)&client_addr, &client_addr_len);
 1d2:	fbc40613          	add	a2,s0,-68
 1d6:	fc040593          	add	a1,s0,-64
 1da:	8526                	mv	a0,s1
 1dc:	494000ef          	jal	670 <accept>
        if (client_sock < 0) {
 1e0:	fe0544e3          	bltz	a0,1c8 <main+0xd4>
            continue;
        }
        
        process_client(client_sock);
 1e4:	e1dff0ef          	jal	0 <process_client>
 1e8:	b7dd                	j	1ce <main+0xda>

00000000000001ea <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start(int argc, char **argv)
{
 1ea:	1141                	add	sp,sp,-16
 1ec:	e406                	sd	ra,8(sp)
 1ee:	e022                	sd	s0,0(sp)
 1f0:	0800                	add	s0,sp,16
  int r;
  extern int main(int argc, char **argv);
  r = main(argc, argv);
 1f2:	f03ff0ef          	jal	f4 <main>
  exit(r);
 1f6:	3c2000ef          	jal	5b8 <exit>

00000000000001fa <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
 1fa:	1141                	add	sp,sp,-16
 1fc:	e422                	sd	s0,8(sp)
 1fe:	0800                	add	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 200:	87aa                	mv	a5,a0
 202:	0585                	add	a1,a1,1
 204:	0785                	add	a5,a5,1
 206:	fff5c703          	lbu	a4,-1(a1)
 20a:	fee78fa3          	sb	a4,-1(a5)
 20e:	fb75                	bnez	a4,202 <strcpy+0x8>
    ;
  return os;
}
 210:	6422                	ld	s0,8(sp)
 212:	0141                	add	sp,sp,16
 214:	8082                	ret

0000000000000216 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 216:	1141                	add	sp,sp,-16
 218:	e422                	sd	s0,8(sp)
 21a:	0800                	add	s0,sp,16
  while(*p && *p == *q)
 21c:	00054783          	lbu	a5,0(a0)
 220:	cb91                	beqz	a5,234 <strcmp+0x1e>
 222:	0005c703          	lbu	a4,0(a1)
 226:	00f71763          	bne	a4,a5,234 <strcmp+0x1e>
    p++, q++;
 22a:	0505                	add	a0,a0,1
 22c:	0585                	add	a1,a1,1
  while(*p && *p == *q)
 22e:	00054783          	lbu	a5,0(a0)
 232:	fbe5                	bnez	a5,222 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 234:	0005c503          	lbu	a0,0(a1)
}
 238:	40a7853b          	subw	a0,a5,a0
 23c:	6422                	ld	s0,8(sp)
 23e:	0141                	add	sp,sp,16
 240:	8082                	ret

0000000000000242 <strncmp>:

int
strncmp(const char *p, const char *q, uint n)
{
 242:	1141                	add	sp,sp,-16
 244:	e422                	sd	s0,8(sp)
 246:	0800                	add	s0,sp,16
  while(n > 0 && *p && *p == *q) {
 248:	ce11                	beqz	a2,264 <strncmp+0x22>
 24a:	00054783          	lbu	a5,0(a0)
 24e:	cf89                	beqz	a5,268 <strncmp+0x26>
 250:	0005c703          	lbu	a4,0(a1)
 254:	00f71a63          	bne	a4,a5,268 <strncmp+0x26>
    p++, q++, n--;
 258:	0505                	add	a0,a0,1
 25a:	0585                	add	a1,a1,1
 25c:	367d                	addw	a2,a2,-1
  while(n > 0 && *p && *p == *q) {
 25e:	f675                	bnez	a2,24a <strncmp+0x8>
  }
  if (n == 0)
    return 0;
 260:	4501                	li	a0,0
 262:	a801                	j	272 <strncmp+0x30>
 264:	4501                	li	a0,0
 266:	a031                	j	272 <strncmp+0x30>
  return (uchar)*p - (uchar)*q;
 268:	00054503          	lbu	a0,0(a0)
 26c:	0005c783          	lbu	a5,0(a1)
 270:	9d1d                	subw	a0,a0,a5
}
 272:	6422                	ld	s0,8(sp)
 274:	0141                	add	sp,sp,16
 276:	8082                	ret

0000000000000278 <strcat>:

char*
strcat(char *dst, const char *src)
{
 278:	1141                	add	sp,sp,-16
 27a:	e422                	sd	s0,8(sp)
 27c:	0800                	add	s0,sp,16
  char *p = dst;
  while(*p) p++;
 27e:	00054783          	lbu	a5,0(a0)
 282:	c385                	beqz	a5,2a2 <strcat+0x2a>
  char *p = dst;
 284:	87aa                	mv	a5,a0
  while(*p) p++;
 286:	0785                	add	a5,a5,1
 288:	0007c703          	lbu	a4,0(a5)
 28c:	ff6d                	bnez	a4,286 <strcat+0xe>
  while((*p++ = *src++) != 0);
 28e:	0585                	add	a1,a1,1
 290:	0785                	add	a5,a5,1
 292:	fff5c703          	lbu	a4,-1(a1)
 296:	fee78fa3          	sb	a4,-1(a5)
 29a:	fb75                	bnez	a4,28e <strcat+0x16>
  return dst;
}
 29c:	6422                	ld	s0,8(sp)
 29e:	0141                	add	sp,sp,16
 2a0:	8082                	ret
  char *p = dst;
 2a2:	87aa                	mv	a5,a0
 2a4:	b7ed                	j	28e <strcat+0x16>

00000000000002a6 <strncpy>:

char*
strncpy(char *dst, const char *src, int n)
{
 2a6:	1141                	add	sp,sp,-16
 2a8:	e422                	sd	s0,8(sp)
 2aa:	0800                	add	s0,sp,16
  char *p = dst;
 2ac:	87aa                	mv	a5,a0
  while(n > 0 && *src) {
 2ae:	02c05463          	blez	a2,2d6 <strncpy+0x30>
 2b2:	0005c703          	lbu	a4,0(a1)
 2b6:	cb01                	beqz	a4,2c6 <strncpy+0x20>
    *p++ = *src++;
 2b8:	0585                	add	a1,a1,1
 2ba:	0785                	add	a5,a5,1
 2bc:	fee78fa3          	sb	a4,-1(a5)
    n--;
 2c0:	367d                	addw	a2,a2,-1
  while(n > 0 && *src) {
 2c2:	fa65                	bnez	a2,2b2 <strncpy+0xc>
 2c4:	a809                	j	2d6 <strncpy+0x30>
  }
  while(n > 0) {
 2c6:	1602                	sll	a2,a2,0x20
 2c8:	9201                	srl	a2,a2,0x20
 2ca:	963e                	add	a2,a2,a5
    *p++ = 0;
 2cc:	0785                	add	a5,a5,1
 2ce:	fe078fa3          	sb	zero,-1(a5)
  while(n > 0) {
 2d2:	fec79de3          	bne	a5,a2,2cc <strncpy+0x26>
    n--;
  }
  return dst;
}
 2d6:	6422                	ld	s0,8(sp)
 2d8:	0141                	add	sp,sp,16
 2da:	8082                	ret

00000000000002dc <strlen>:

uint
strlen(const char *s)
{
 2dc:	1141                	add	sp,sp,-16
 2de:	e422                	sd	s0,8(sp)
 2e0:	0800                	add	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 2e2:	00054783          	lbu	a5,0(a0)
 2e6:	cf91                	beqz	a5,302 <strlen+0x26>
 2e8:	0505                	add	a0,a0,1
 2ea:	87aa                	mv	a5,a0
 2ec:	86be                	mv	a3,a5
 2ee:	0785                	add	a5,a5,1
 2f0:	fff7c703          	lbu	a4,-1(a5)
 2f4:	ff65                	bnez	a4,2ec <strlen+0x10>
 2f6:	40a6853b          	subw	a0,a3,a0
 2fa:	2505                	addw	a0,a0,1
    ;
  return n;
}
 2fc:	6422                	ld	s0,8(sp)
 2fe:	0141                	add	sp,sp,16
 300:	8082                	ret
  for(n = 0; s[n]; n++)
 302:	4501                	li	a0,0
 304:	bfe5                	j	2fc <strlen+0x20>

0000000000000306 <memset>:

void*
memset(void *dst, int c, uint n)
{
 306:	1141                	add	sp,sp,-16
 308:	e422                	sd	s0,8(sp)
 30a:	0800                	add	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 30c:	ca19                	beqz	a2,322 <memset+0x1c>
 30e:	87aa                	mv	a5,a0
 310:	1602                	sll	a2,a2,0x20
 312:	9201                	srl	a2,a2,0x20
 314:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 318:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 31c:	0785                	add	a5,a5,1
 31e:	fee79de3          	bne	a5,a4,318 <memset+0x12>
  }
  return dst;
}
 322:	6422                	ld	s0,8(sp)
 324:	0141                	add	sp,sp,16
 326:	8082                	ret

0000000000000328 <strchr>:

char*
strchr(const char *s, char c)
{
 328:	1141                	add	sp,sp,-16
 32a:	e422                	sd	s0,8(sp)
 32c:	0800                	add	s0,sp,16
  for(; *s; s++)
 32e:	00054783          	lbu	a5,0(a0)
 332:	cb99                	beqz	a5,348 <strchr+0x20>
    if(*s == c)
 334:	00f58763          	beq	a1,a5,342 <strchr+0x1a>
  for(; *s; s++)
 338:	0505                	add	a0,a0,1
 33a:	00054783          	lbu	a5,0(a0)
 33e:	fbfd                	bnez	a5,334 <strchr+0xc>
      return (char*)s;
  return 0;
 340:	4501                	li	a0,0
}
 342:	6422                	ld	s0,8(sp)
 344:	0141                	add	sp,sp,16
 346:	8082                	ret
  return 0;
 348:	4501                	li	a0,0
 34a:	bfe5                	j	342 <strchr+0x1a>

000000000000034c <gets>:

char*
gets(char *buf, int max)
{
 34c:	711d                	add	sp,sp,-96
 34e:	ec86                	sd	ra,88(sp)
 350:	e8a2                	sd	s0,80(sp)
 352:	e4a6                	sd	s1,72(sp)
 354:	e0ca                	sd	s2,64(sp)
 356:	fc4e                	sd	s3,56(sp)
 358:	f852                	sd	s4,48(sp)
 35a:	f456                	sd	s5,40(sp)
 35c:	f05a                	sd	s6,32(sp)
 35e:	ec5e                	sd	s7,24(sp)
 360:	1080                	add	s0,sp,96
 362:	8baa                	mv	s7,a0
 364:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 366:	892a                	mv	s2,a0
 368:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 36a:	4aa9                	li	s5,10
 36c:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 36e:	89a6                	mv	s3,s1
 370:	2485                	addw	s1,s1,1
 372:	0344d663          	bge	s1,s4,39e <gets+0x52>
    cc = read(0, &c, 1);
 376:	4605                	li	a2,1
 378:	faf40593          	add	a1,s0,-81
 37c:	4501                	li	a0,0
 37e:	252000ef          	jal	5d0 <read>
    if(cc < 1)
 382:	00a05e63          	blez	a0,39e <gets+0x52>
    buf[i++] = c;
 386:	faf44783          	lbu	a5,-81(s0)
 38a:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 38e:	01578763          	beq	a5,s5,39c <gets+0x50>
 392:	0905                	add	s2,s2,1
 394:	fd679de3          	bne	a5,s6,36e <gets+0x22>
    buf[i++] = c;
 398:	89a6                	mv	s3,s1
 39a:	a011                	j	39e <gets+0x52>
 39c:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 39e:	99de                	add	s3,s3,s7
 3a0:	00098023          	sb	zero,0(s3)
  return buf;
}
 3a4:	855e                	mv	a0,s7
 3a6:	60e6                	ld	ra,88(sp)
 3a8:	6446                	ld	s0,80(sp)
 3aa:	64a6                	ld	s1,72(sp)
 3ac:	6906                	ld	s2,64(sp)
 3ae:	79e2                	ld	s3,56(sp)
 3b0:	7a42                	ld	s4,48(sp)
 3b2:	7aa2                	ld	s5,40(sp)
 3b4:	7b02                	ld	s6,32(sp)
 3b6:	6be2                	ld	s7,24(sp)
 3b8:	6125                	add	sp,sp,96
 3ba:	8082                	ret

00000000000003bc <stat>:

int
stat(const char *n, struct stat *st)
{
 3bc:	1101                	add	sp,sp,-32
 3be:	ec06                	sd	ra,24(sp)
 3c0:	e822                	sd	s0,16(sp)
 3c2:	e04a                	sd	s2,0(sp)
 3c4:	1000                	add	s0,sp,32
 3c6:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 3c8:	4581                	li	a1,0
 3ca:	22e000ef          	jal	5f8 <open>
  if(fd < 0)
 3ce:	02054263          	bltz	a0,3f2 <stat+0x36>
 3d2:	e426                	sd	s1,8(sp)
 3d4:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 3d6:	85ca                	mv	a1,s2
 3d8:	238000ef          	jal	610 <fstat>
 3dc:	892a                	mv	s2,a0
  close(fd);
 3de:	8526                	mv	a0,s1
 3e0:	200000ef          	jal	5e0 <close>
  return r;
 3e4:	64a2                	ld	s1,8(sp)
}
 3e6:	854a                	mv	a0,s2
 3e8:	60e2                	ld	ra,24(sp)
 3ea:	6442                	ld	s0,16(sp)
 3ec:	6902                	ld	s2,0(sp)
 3ee:	6105                	add	sp,sp,32
 3f0:	8082                	ret
    return -1;
 3f2:	597d                	li	s2,-1
 3f4:	bfcd                	j	3e6 <stat+0x2a>

00000000000003f6 <atoi>:

int
atoi(const char *s)
{
 3f6:	1141                	add	sp,sp,-16
 3f8:	e422                	sd	s0,8(sp)
 3fa:	0800                	add	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 3fc:	00054683          	lbu	a3,0(a0)
 400:	fd06879b          	addw	a5,a3,-48
 404:	0ff7f793          	zext.b	a5,a5
 408:	4625                	li	a2,9
 40a:	02f66863          	bltu	a2,a5,43a <atoi+0x44>
 40e:	872a                	mv	a4,a0
  n = 0;
 410:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 412:	0705                	add	a4,a4,1
 414:	0025179b          	sllw	a5,a0,0x2
 418:	9fa9                	addw	a5,a5,a0
 41a:	0017979b          	sllw	a5,a5,0x1
 41e:	9fb5                	addw	a5,a5,a3
 420:	fd07851b          	addw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 424:	00074683          	lbu	a3,0(a4)
 428:	fd06879b          	addw	a5,a3,-48
 42c:	0ff7f793          	zext.b	a5,a5
 430:	fef671e3          	bgeu	a2,a5,412 <atoi+0x1c>
  return n;
}
 434:	6422                	ld	s0,8(sp)
 436:	0141                	add	sp,sp,16
 438:	8082                	ret
  n = 0;
 43a:	4501                	li	a0,0
 43c:	bfe5                	j	434 <atoi+0x3e>

000000000000043e <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 43e:	1141                	add	sp,sp,-16
 440:	e422                	sd	s0,8(sp)
 442:	0800                	add	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 444:	02b57463          	bgeu	a0,a1,46c <memmove+0x2e>
    while(n-- > 0)
 448:	00c05f63          	blez	a2,466 <memmove+0x28>
 44c:	1602                	sll	a2,a2,0x20
 44e:	9201                	srl	a2,a2,0x20
 450:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 454:	872a                	mv	a4,a0
      *dst++ = *src++;
 456:	0585                	add	a1,a1,1
 458:	0705                	add	a4,a4,1
 45a:	fff5c683          	lbu	a3,-1(a1)
 45e:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 462:	fef71ae3          	bne	a4,a5,456 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 466:	6422                	ld	s0,8(sp)
 468:	0141                	add	sp,sp,16
 46a:	8082                	ret
    dst += n;
 46c:	00c50733          	add	a4,a0,a2
    src += n;
 470:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 472:	fec05ae3          	blez	a2,466 <memmove+0x28>
 476:	fff6079b          	addw	a5,a2,-1
 47a:	1782                	sll	a5,a5,0x20
 47c:	9381                	srl	a5,a5,0x20
 47e:	fff7c793          	not	a5,a5
 482:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 484:	15fd                	add	a1,a1,-1
 486:	177d                	add	a4,a4,-1
 488:	0005c683          	lbu	a3,0(a1)
 48c:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 490:	fee79ae3          	bne	a5,a4,484 <memmove+0x46>
 494:	bfc9                	j	466 <memmove+0x28>

0000000000000496 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 496:	1141                	add	sp,sp,-16
 498:	e422                	sd	s0,8(sp)
 49a:	0800                	add	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 49c:	ca05                	beqz	a2,4cc <memcmp+0x36>
 49e:	fff6069b          	addw	a3,a2,-1
 4a2:	1682                	sll	a3,a3,0x20
 4a4:	9281                	srl	a3,a3,0x20
 4a6:	0685                	add	a3,a3,1
 4a8:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 4aa:	00054783          	lbu	a5,0(a0)
 4ae:	0005c703          	lbu	a4,0(a1)
 4b2:	00e79863          	bne	a5,a4,4c2 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 4b6:	0505                	add	a0,a0,1
    p2++;
 4b8:	0585                	add	a1,a1,1
  while (n-- > 0) {
 4ba:	fed518e3          	bne	a0,a3,4aa <memcmp+0x14>
  }
  return 0;
 4be:	4501                	li	a0,0
 4c0:	a019                	j	4c6 <memcmp+0x30>
      return *p1 - *p2;
 4c2:	40e7853b          	subw	a0,a5,a4
}
 4c6:	6422                	ld	s0,8(sp)
 4c8:	0141                	add	sp,sp,16
 4ca:	8082                	ret
  return 0;
 4cc:	4501                	li	a0,0
 4ce:	bfe5                	j	4c6 <memcmp+0x30>

00000000000004d0 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 4d0:	1141                	add	sp,sp,-16
 4d2:	e406                	sd	ra,8(sp)
 4d4:	e022                	sd	s0,0(sp)
 4d6:	0800                	add	s0,sp,16
  return memmove(dst, src, n);
 4d8:	f67ff0ef          	jal	43e <memmove>
}
 4dc:	60a2                	ld	ra,8(sp)
 4de:	6402                	ld	s0,0(sp)
 4e0:	0141                	add	sp,sp,16
 4e2:	8082                	ret

00000000000004e4 <sbrk>:

char *
sbrk(int n) {
 4e4:	1141                	add	sp,sp,-16
 4e6:	e406                	sd	ra,8(sp)
 4e8:	e022                	sd	s0,0(sp)
 4ea:	0800                	add	s0,sp,16
  return sys_sbrk(n, SBRK_EAGER);
 4ec:	4585                	li	a1,1
 4ee:	152000ef          	jal	640 <sys_sbrk>
}
 4f2:	60a2                	ld	ra,8(sp)
 4f4:	6402                	ld	s0,0(sp)
 4f6:	0141                	add	sp,sp,16
 4f8:	8082                	ret

00000000000004fa <sbrklazy>:

char *
sbrklazy(int n) {
 4fa:	1141                	add	sp,sp,-16
 4fc:	e406                	sd	ra,8(sp)
 4fe:	e022                	sd	s0,0(sp)
 500:	0800                	add	s0,sp,16
  return sys_sbrk(n, SBRK_LAZY);
 502:	4589                	li	a1,2
 504:	13c000ef          	jal	640 <sys_sbrk>
}
 508:	60a2                	ld	ra,8(sp)
 50a:	6402                	ld	s0,0(sp)
 50c:	0141                	add	sp,sp,16
 50e:	8082                	ret

0000000000000510 <htons>:

// Byte order conversion functions
unsigned short
htons(unsigned short hostshort)
{
 510:	1141                	add	sp,sp,-16
 512:	e422                	sd	s0,8(sp)
 514:	0800                	add	s0,sp,16
  return ((hostshort >> 8) & 0xff) | ((hostshort & 0xff) << 8);
 516:	0085179b          	sllw	a5,a0,0x8
 51a:	0085551b          	srlw	a0,a0,0x8
 51e:	8d5d                	or	a0,a0,a5
}
 520:	1542                	sll	a0,a0,0x30
 522:	9141                	srl	a0,a0,0x30
 524:	6422                	ld	s0,8(sp)
 526:	0141                	add	sp,sp,16
 528:	8082                	ret

000000000000052a <ntohs>:

unsigned short
ntohs(unsigned short netshort)
{
 52a:	1141                	add	sp,sp,-16
 52c:	e422                	sd	s0,8(sp)
 52e:	0800                	add	s0,sp,16
  return ((netshort >> 8) & 0xff) | ((netshort & 0xff) << 8);
 530:	0085179b          	sllw	a5,a0,0x8
 534:	0085551b          	srlw	a0,a0,0x8
 538:	8d5d                	or	a0,a0,a5
}
 53a:	1542                	sll	a0,a0,0x30
 53c:	9141                	srl	a0,a0,0x30
 53e:	6422                	ld	s0,8(sp)
 540:	0141                	add	sp,sp,16
 542:	8082                	ret

0000000000000544 <htonl>:

unsigned long
htonl(unsigned long hostlong)
{
 544:	1141                	add	sp,sp,-16
 546:	e422                	sd	s0,8(sp)
 548:	0800                	add	s0,sp,16
  return ((hostlong >> 24) & 0xff) |
 54a:	0185579b          	srlw	a5,a0,0x18
         ((hostlong >> 8) & 0xff00) |
 54e:	00855713          	srl	a4,a0,0x8
 552:	66c1                	lui	a3,0x10
 554:	f0068693          	add	a3,a3,-256 # ff00 <base+0xe6f0>
 558:	8f75                	and	a4,a4,a3
  return ((hostlong >> 24) & 0xff) |
 55a:	8fd9                	or	a5,a5,a4
         ((hostlong & 0xff00) << 8) |
 55c:	00851713          	sll	a4,a0,0x8
 560:	00ff06b7          	lui	a3,0xff0
 564:	8f75                	and	a4,a4,a3
         ((hostlong >> 8) & 0xff00) |
 566:	8fd9                	or	a5,a5,a4
         ((hostlong & 0xff) << 24);
 568:	0562                	sll	a0,a0,0x18
 56a:	0ff00713          	li	a4,255
 56e:	0762                	sll	a4,a4,0x18
 570:	8d79                	and	a0,a0,a4
}
 572:	8d5d                	or	a0,a0,a5
 574:	6422                	ld	s0,8(sp)
 576:	0141                	add	sp,sp,16
 578:	8082                	ret

000000000000057a <ntohl>:

unsigned long
ntohl(unsigned long netlong)
{
 57a:	1141                	add	sp,sp,-16
 57c:	e422                	sd	s0,8(sp)
 57e:	0800                	add	s0,sp,16
  return ((netlong >> 24) & 0xff) |
 580:	0185579b          	srlw	a5,a0,0x18
         ((netlong >> 8) & 0xff00) |
 584:	00855713          	srl	a4,a0,0x8
 588:	66c1                	lui	a3,0x10
 58a:	f0068693          	add	a3,a3,-256 # ff00 <base+0xe6f0>
 58e:	8f75                	and	a4,a4,a3
  return ((netlong >> 24) & 0xff) |
 590:	8fd9                	or	a5,a5,a4
         ((netlong & 0xff00) << 8) |
 592:	00851713          	sll	a4,a0,0x8
 596:	00ff06b7          	lui	a3,0xff0
 59a:	8f75                	and	a4,a4,a3
         ((netlong >> 8) & 0xff00) |
 59c:	8fd9                	or	a5,a5,a4
         ((netlong & 0xff) << 24);
 59e:	0562                	sll	a0,a0,0x18
 5a0:	0ff00713          	li	a4,255
 5a4:	0762                	sll	a4,a4,0x18
 5a6:	8d79                	and	a0,a0,a4
}
 5a8:	8d5d                	or	a0,a0,a5
 5aa:	6422                	ld	s0,8(sp)
 5ac:	0141                	add	sp,sp,16
 5ae:	8082                	ret

00000000000005b0 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 5b0:	4885                	li	a7,1
 ecall
 5b2:	00000073          	ecall
 ret
 5b6:	8082                	ret

00000000000005b8 <exit>:
.global exit
exit:
 li a7, SYS_exit
 5b8:	4889                	li	a7,2
 ecall
 5ba:	00000073          	ecall
 ret
 5be:	8082                	ret

00000000000005c0 <wait>:
.global wait
wait:
 li a7, SYS_wait
 5c0:	488d                	li	a7,3
 ecall
 5c2:	00000073          	ecall
 ret
 5c6:	8082                	ret

00000000000005c8 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 5c8:	4891                	li	a7,4
 ecall
 5ca:	00000073          	ecall
 ret
 5ce:	8082                	ret

00000000000005d0 <read>:
.global read
read:
 li a7, SYS_read
 5d0:	4895                	li	a7,5
 ecall
 5d2:	00000073          	ecall
 ret
 5d6:	8082                	ret

00000000000005d8 <write>:
.global write
write:
 li a7, SYS_write
 5d8:	48c1                	li	a7,16
 ecall
 5da:	00000073          	ecall
 ret
 5de:	8082                	ret

00000000000005e0 <close>:
.global close
close:
 li a7, SYS_close
 5e0:	48d5                	li	a7,21
 ecall
 5e2:	00000073          	ecall
 ret
 5e6:	8082                	ret

00000000000005e8 <kill>:
.global kill
kill:
 li a7, SYS_kill
 5e8:	4899                	li	a7,6
 ecall
 5ea:	00000073          	ecall
 ret
 5ee:	8082                	ret

00000000000005f0 <exec>:
.global exec
exec:
 li a7, SYS_exec
 5f0:	489d                	li	a7,7
 ecall
 5f2:	00000073          	ecall
 ret
 5f6:	8082                	ret

00000000000005f8 <open>:
.global open
open:
 li a7, SYS_open
 5f8:	48bd                	li	a7,15
 ecall
 5fa:	00000073          	ecall
 ret
 5fe:	8082                	ret

0000000000000600 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 600:	48c5                	li	a7,17
 ecall
 602:	00000073          	ecall
 ret
 606:	8082                	ret

0000000000000608 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 608:	48c9                	li	a7,18
 ecall
 60a:	00000073          	ecall
 ret
 60e:	8082                	ret

0000000000000610 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 610:	48a1                	li	a7,8
 ecall
 612:	00000073          	ecall
 ret
 616:	8082                	ret

0000000000000618 <link>:
.global link
link:
 li a7, SYS_link
 618:	48cd                	li	a7,19
 ecall
 61a:	00000073          	ecall
 ret
 61e:	8082                	ret

0000000000000620 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 620:	48d1                	li	a7,20
 ecall
 622:	00000073          	ecall
 ret
 626:	8082                	ret

0000000000000628 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 628:	48a5                	li	a7,9
 ecall
 62a:	00000073          	ecall
 ret
 62e:	8082                	ret

0000000000000630 <dup>:
.global dup
dup:
 li a7, SYS_dup
 630:	48a9                	li	a7,10
 ecall
 632:	00000073          	ecall
 ret
 636:	8082                	ret

0000000000000638 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 638:	48ad                	li	a7,11
 ecall
 63a:	00000073          	ecall
 ret
 63e:	8082                	ret

0000000000000640 <sys_sbrk>:
.global sys_sbrk
sys_sbrk:
 li a7, SYS_sbrk
 640:	48b1                	li	a7,12
 ecall
 642:	00000073          	ecall
 ret
 646:	8082                	ret

0000000000000648 <pause>:
.global pause
pause:
 li a7, SYS_pause
 648:	48b5                	li	a7,13
 ecall
 64a:	00000073          	ecall
 ret
 64e:	8082                	ret

0000000000000650 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 650:	48b9                	li	a7,14
 ecall
 652:	00000073          	ecall
 ret
 656:	8082                	ret

0000000000000658 <socket>:
.global socket
socket:
 li a7, SYS_socket
 658:	48d9                	li	a7,22
 ecall
 65a:	00000073          	ecall
 ret
 65e:	8082                	ret

0000000000000660 <bind>:
.global bind
bind:
 li a7, SYS_bind
 660:	48dd                	li	a7,23
 ecall
 662:	00000073          	ecall
 ret
 666:	8082                	ret

0000000000000668 <listen>:
.global listen
listen:
 li a7, SYS_listen
 668:	48e1                	li	a7,24
 ecall
 66a:	00000073          	ecall
 ret
 66e:	8082                	ret

0000000000000670 <accept>:
.global accept
accept:
 li a7, SYS_accept
 670:	48e5                	li	a7,25
 ecall
 672:	00000073          	ecall
 ret
 676:	8082                	ret

0000000000000678 <connect>:
.global connect
connect:
 li a7, SYS_connect
 678:	48e9                	li	a7,26
 ecall
 67a:	00000073          	ecall
 ret
 67e:	8082                	ret

0000000000000680 <send>:
.global send
send:
 li a7, SYS_send
 680:	48ed                	li	a7,27
 ecall
 682:	00000073          	ecall
 ret
 686:	8082                	ret

0000000000000688 <recv>:
.global recv
recv:
 li a7, SYS_recv
 688:	48f1                	li	a7,28
 ecall
 68a:	00000073          	ecall
 ret
 68e:	8082                	ret

0000000000000690 <sendto>:
.global sendto
sendto:
 li a7, SYS_sendto
 690:	48f5                	li	a7,29
 ecall
 692:	00000073          	ecall
 ret
 696:	8082                	ret

0000000000000698 <recvfrom>:
.global recvfrom
recvfrom:
 li a7, SYS_recvfrom
 698:	48f9                	li	a7,30
 ecall
 69a:	00000073          	ecall
 ret
 69e:	8082                	ret

00000000000006a0 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 6a0:	1101                	add	sp,sp,-32
 6a2:	ec06                	sd	ra,24(sp)
 6a4:	e822                	sd	s0,16(sp)
 6a6:	1000                	add	s0,sp,32
 6a8:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 6ac:	4605                	li	a2,1
 6ae:	fef40593          	add	a1,s0,-17
 6b2:	f27ff0ef          	jal	5d8 <write>
}
 6b6:	60e2                	ld	ra,24(sp)
 6b8:	6442                	ld	s0,16(sp)
 6ba:	6105                	add	sp,sp,32
 6bc:	8082                	ret

00000000000006be <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
 6be:	715d                	add	sp,sp,-80
 6c0:	e486                	sd	ra,72(sp)
 6c2:	e0a2                	sd	s0,64(sp)
 6c4:	f84a                	sd	s2,48(sp)
 6c6:	0880                	add	s0,sp,80
 6c8:	892a                	mv	s2,a0
  char buf[20];
  int i, neg;
  unsigned long long x;

  neg = 0;
  if(sgn && xx < 0){
 6ca:	c299                	beqz	a3,6d0 <printint+0x12>
 6cc:	0805c363          	bltz	a1,752 <printint+0x94>
  neg = 0;
 6d0:	4881                	li	a7,0
 6d2:	fb840693          	add	a3,s0,-72
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
 6d6:	4781                	li	a5,0
  do{
    buf[i++] = digits[x % base];
 6d8:	00000517          	auipc	a0,0x0
 6dc:	65850513          	add	a0,a0,1624 # d30 <digits>
 6e0:	883e                	mv	a6,a5
 6e2:	2785                	addw	a5,a5,1
 6e4:	02c5f733          	remu	a4,a1,a2
 6e8:	972a                	add	a4,a4,a0
 6ea:	00074703          	lbu	a4,0(a4)
 6ee:	00e68023          	sb	a4,0(a3) # ff0000 <base+0xfee7f0>
  }while((x /= base) != 0);
 6f2:	872e                	mv	a4,a1
 6f4:	02c5d5b3          	divu	a1,a1,a2
 6f8:	0685                	add	a3,a3,1
 6fa:	fec773e3          	bgeu	a4,a2,6e0 <printint+0x22>
  if(neg)
 6fe:	00088b63          	beqz	a7,714 <printint+0x56>
    buf[i++] = '-';
 702:	fd078793          	add	a5,a5,-48
 706:	97a2                	add	a5,a5,s0
 708:	02d00713          	li	a4,45
 70c:	fee78423          	sb	a4,-24(a5)
 710:	0028079b          	addw	a5,a6,2

  while(--i >= 0)
 714:	02f05a63          	blez	a5,748 <printint+0x8a>
 718:	fc26                	sd	s1,56(sp)
 71a:	f44e                	sd	s3,40(sp)
 71c:	fb840713          	add	a4,s0,-72
 720:	00f704b3          	add	s1,a4,a5
 724:	fff70993          	add	s3,a4,-1
 728:	99be                	add	s3,s3,a5
 72a:	37fd                	addw	a5,a5,-1
 72c:	1782                	sll	a5,a5,0x20
 72e:	9381                	srl	a5,a5,0x20
 730:	40f989b3          	sub	s3,s3,a5
    putc(fd, buf[i]);
 734:	fff4c583          	lbu	a1,-1(s1)
 738:	854a                	mv	a0,s2
 73a:	f67ff0ef          	jal	6a0 <putc>
  while(--i >= 0)
 73e:	14fd                	add	s1,s1,-1
 740:	ff349ae3          	bne	s1,s3,734 <printint+0x76>
 744:	74e2                	ld	s1,56(sp)
 746:	79a2                	ld	s3,40(sp)
}
 748:	60a6                	ld	ra,72(sp)
 74a:	6406                	ld	s0,64(sp)
 74c:	7942                	ld	s2,48(sp)
 74e:	6161                	add	sp,sp,80
 750:	8082                	ret
    x = -xx;
 752:	40b005b3          	neg	a1,a1
    neg = 1;
 756:	4885                	li	a7,1
    x = -xx;
 758:	bfad                	j	6d2 <printint+0x14>

000000000000075a <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %c, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 75a:	711d                	add	sp,sp,-96
 75c:	ec86                	sd	ra,88(sp)
 75e:	e8a2                	sd	s0,80(sp)
 760:	e0ca                	sd	s2,64(sp)
 762:	1080                	add	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 764:	0005c903          	lbu	s2,0(a1)
 768:	28090663          	beqz	s2,9f4 <vprintf+0x29a>
 76c:	e4a6                	sd	s1,72(sp)
 76e:	fc4e                	sd	s3,56(sp)
 770:	f852                	sd	s4,48(sp)
 772:	f456                	sd	s5,40(sp)
 774:	f05a                	sd	s6,32(sp)
 776:	ec5e                	sd	s7,24(sp)
 778:	e862                	sd	s8,16(sp)
 77a:	e466                	sd	s9,8(sp)
 77c:	8b2a                	mv	s6,a0
 77e:	8a2e                	mv	s4,a1
 780:	8bb2                	mv	s7,a2
  state = 0;
 782:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
 784:	4481                	li	s1,0
 786:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
 788:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
 78c:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
 790:	06c00c93          	li	s9,108
 794:	a005                	j	7b4 <vprintf+0x5a>
        putc(fd, c0);
 796:	85ca                	mv	a1,s2
 798:	855a                	mv	a0,s6
 79a:	f07ff0ef          	jal	6a0 <putc>
 79e:	a019                	j	7a4 <vprintf+0x4a>
    } else if(state == '%'){
 7a0:	03598263          	beq	s3,s5,7c4 <vprintf+0x6a>
  for(i = 0; fmt[i]; i++){
 7a4:	2485                	addw	s1,s1,1
 7a6:	8726                	mv	a4,s1
 7a8:	009a07b3          	add	a5,s4,s1
 7ac:	0007c903          	lbu	s2,0(a5)
 7b0:	22090a63          	beqz	s2,9e4 <vprintf+0x28a>
    c0 = fmt[i] & 0xff;
 7b4:	0009079b          	sext.w	a5,s2
    if(state == 0){
 7b8:	fe0994e3          	bnez	s3,7a0 <vprintf+0x46>
      if(c0 == '%'){
 7bc:	fd579de3          	bne	a5,s5,796 <vprintf+0x3c>
        state = '%';
 7c0:	89be                	mv	s3,a5
 7c2:	b7cd                	j	7a4 <vprintf+0x4a>
      if(c0) c1 = fmt[i+1] & 0xff;
 7c4:	00ea06b3          	add	a3,s4,a4
 7c8:	0016c683          	lbu	a3,1(a3)
      c1 = c2 = 0;
 7cc:	8636                	mv	a2,a3
      if(c1) c2 = fmt[i+2] & 0xff;
 7ce:	c681                	beqz	a3,7d6 <vprintf+0x7c>
 7d0:	9752                	add	a4,a4,s4
 7d2:	00274603          	lbu	a2,2(a4)
      if(c0 == 'd'){
 7d6:	05878363          	beq	a5,s8,81c <vprintf+0xc2>
      } else if(c0 == 'l' && c1 == 'd'){
 7da:	05978d63          	beq	a5,s9,834 <vprintf+0xda>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
 7de:	07500713          	li	a4,117
 7e2:	0ee78763          	beq	a5,a4,8d0 <vprintf+0x176>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
 7e6:	07800713          	li	a4,120
 7ea:	12e78963          	beq	a5,a4,91c <vprintf+0x1c2>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
 7ee:	07000713          	li	a4,112
 7f2:	14e78e63          	beq	a5,a4,94e <vprintf+0x1f4>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 'c'){
 7f6:	06300713          	li	a4,99
 7fa:	18e78e63          	beq	a5,a4,996 <vprintf+0x23c>
        putc(fd, va_arg(ap, uint32));
      } else if(c0 == 's'){
 7fe:	07300713          	li	a4,115
 802:	1ae78463          	beq	a5,a4,9aa <vprintf+0x250>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
 806:	02500713          	li	a4,37
 80a:	04e79563          	bne	a5,a4,854 <vprintf+0xfa>
        putc(fd, '%');
 80e:	02500593          	li	a1,37
 812:	855a                	mv	a0,s6
 814:	e8dff0ef          	jal	6a0 <putc>
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c0);
      }

      state = 0;
 818:	4981                	li	s3,0
 81a:	b769                	j	7a4 <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 1);
 81c:	008b8913          	add	s2,s7,8
 820:	4685                	li	a3,1
 822:	4629                	li	a2,10
 824:	000ba583          	lw	a1,0(s7)
 828:	855a                	mv	a0,s6
 82a:	e95ff0ef          	jal	6be <printint>
 82e:	8bca                	mv	s7,s2
      state = 0;
 830:	4981                	li	s3,0
 832:	bf8d                	j	7a4 <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'd'){
 834:	06400793          	li	a5,100
 838:	02f68963          	beq	a3,a5,86a <vprintf+0x110>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 83c:	06c00793          	li	a5,108
 840:	04f68263          	beq	a3,a5,884 <vprintf+0x12a>
      } else if(c0 == 'l' && c1 == 'u'){
 844:	07500793          	li	a5,117
 848:	0af68063          	beq	a3,a5,8e8 <vprintf+0x18e>
      } else if(c0 == 'l' && c1 == 'x'){
 84c:	07800793          	li	a5,120
 850:	0ef68263          	beq	a3,a5,934 <vprintf+0x1da>
        putc(fd, '%');
 854:	02500593          	li	a1,37
 858:	855a                	mv	a0,s6
 85a:	e47ff0ef          	jal	6a0 <putc>
        putc(fd, c0);
 85e:	85ca                	mv	a1,s2
 860:	855a                	mv	a0,s6
 862:	e3fff0ef          	jal	6a0 <putc>
      state = 0;
 866:	4981                	li	s3,0
 868:	bf35                	j	7a4 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 86a:	008b8913          	add	s2,s7,8
 86e:	4685                	li	a3,1
 870:	4629                	li	a2,10
 872:	000bb583          	ld	a1,0(s7)
 876:	855a                	mv	a0,s6
 878:	e47ff0ef          	jal	6be <printint>
        i += 1;
 87c:	2485                	addw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 87e:	8bca                	mv	s7,s2
      state = 0;
 880:	4981                	li	s3,0
        i += 1;
 882:	b70d                	j	7a4 <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 884:	06400793          	li	a5,100
 888:	02f60763          	beq	a2,a5,8b6 <vprintf+0x15c>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 88c:	07500793          	li	a5,117
 890:	06f60963          	beq	a2,a5,902 <vprintf+0x1a8>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 894:	07800793          	li	a5,120
 898:	faf61ee3          	bne	a2,a5,854 <vprintf+0xfa>
        printint(fd, va_arg(ap, uint64), 16, 0);
 89c:	008b8913          	add	s2,s7,8
 8a0:	4681                	li	a3,0
 8a2:	4641                	li	a2,16
 8a4:	000bb583          	ld	a1,0(s7)
 8a8:	855a                	mv	a0,s6
 8aa:	e15ff0ef          	jal	6be <printint>
        i += 2;
 8ae:	2489                	addw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 8b0:	8bca                	mv	s7,s2
      state = 0;
 8b2:	4981                	li	s3,0
        i += 2;
 8b4:	bdc5                	j	7a4 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 8b6:	008b8913          	add	s2,s7,8
 8ba:	4685                	li	a3,1
 8bc:	4629                	li	a2,10
 8be:	000bb583          	ld	a1,0(s7)
 8c2:	855a                	mv	a0,s6
 8c4:	dfbff0ef          	jal	6be <printint>
        i += 2;
 8c8:	2489                	addw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 8ca:	8bca                	mv	s7,s2
      state = 0;
 8cc:	4981                	li	s3,0
        i += 2;
 8ce:	bdd9                	j	7a4 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint32), 10, 0);
 8d0:	008b8913          	add	s2,s7,8
 8d4:	4681                	li	a3,0
 8d6:	4629                	li	a2,10
 8d8:	000be583          	lwu	a1,0(s7)
 8dc:	855a                	mv	a0,s6
 8de:	de1ff0ef          	jal	6be <printint>
 8e2:	8bca                	mv	s7,s2
      state = 0;
 8e4:	4981                	li	s3,0
 8e6:	bd7d                	j	7a4 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 8e8:	008b8913          	add	s2,s7,8
 8ec:	4681                	li	a3,0
 8ee:	4629                	li	a2,10
 8f0:	000bb583          	ld	a1,0(s7)
 8f4:	855a                	mv	a0,s6
 8f6:	dc9ff0ef          	jal	6be <printint>
        i += 1;
 8fa:	2485                	addw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 8fc:	8bca                	mv	s7,s2
      state = 0;
 8fe:	4981                	li	s3,0
        i += 1;
 900:	b555                	j	7a4 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 902:	008b8913          	add	s2,s7,8
 906:	4681                	li	a3,0
 908:	4629                	li	a2,10
 90a:	000bb583          	ld	a1,0(s7)
 90e:	855a                	mv	a0,s6
 910:	dafff0ef          	jal	6be <printint>
        i += 2;
 914:	2489                	addw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 916:	8bca                	mv	s7,s2
      state = 0;
 918:	4981                	li	s3,0
        i += 2;
 91a:	b569                	j	7a4 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint32), 16, 0);
 91c:	008b8913          	add	s2,s7,8
 920:	4681                	li	a3,0
 922:	4641                	li	a2,16
 924:	000be583          	lwu	a1,0(s7)
 928:	855a                	mv	a0,s6
 92a:	d95ff0ef          	jal	6be <printint>
 92e:	8bca                	mv	s7,s2
      state = 0;
 930:	4981                	li	s3,0
 932:	bd8d                	j	7a4 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 16, 0);
 934:	008b8913          	add	s2,s7,8
 938:	4681                	li	a3,0
 93a:	4641                	li	a2,16
 93c:	000bb583          	ld	a1,0(s7)
 940:	855a                	mv	a0,s6
 942:	d7dff0ef          	jal	6be <printint>
        i += 1;
 946:	2485                	addw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 948:	8bca                	mv	s7,s2
      state = 0;
 94a:	4981                	li	s3,0
        i += 1;
 94c:	bda1                	j	7a4 <vprintf+0x4a>
 94e:	e06a                	sd	s10,0(sp)
        printptr(fd, va_arg(ap, uint64));
 950:	008b8d13          	add	s10,s7,8
 954:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 958:	03000593          	li	a1,48
 95c:	855a                	mv	a0,s6
 95e:	d43ff0ef          	jal	6a0 <putc>
  putc(fd, 'x');
 962:	07800593          	li	a1,120
 966:	855a                	mv	a0,s6
 968:	d39ff0ef          	jal	6a0 <putc>
 96c:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 96e:	00000b97          	auipc	s7,0x0
 972:	3c2b8b93          	add	s7,s7,962 # d30 <digits>
 976:	03c9d793          	srl	a5,s3,0x3c
 97a:	97de                	add	a5,a5,s7
 97c:	0007c583          	lbu	a1,0(a5)
 980:	855a                	mv	a0,s6
 982:	d1fff0ef          	jal	6a0 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 986:	0992                	sll	s3,s3,0x4
 988:	397d                	addw	s2,s2,-1
 98a:	fe0916e3          	bnez	s2,976 <vprintf+0x21c>
        printptr(fd, va_arg(ap, uint64));
 98e:	8bea                	mv	s7,s10
      state = 0;
 990:	4981                	li	s3,0
 992:	6d02                	ld	s10,0(sp)
 994:	bd01                	j	7a4 <vprintf+0x4a>
        putc(fd, va_arg(ap, uint32));
 996:	008b8913          	add	s2,s7,8
 99a:	000bc583          	lbu	a1,0(s7)
 99e:	855a                	mv	a0,s6
 9a0:	d01ff0ef          	jal	6a0 <putc>
 9a4:	8bca                	mv	s7,s2
      state = 0;
 9a6:	4981                	li	s3,0
 9a8:	bbf5                	j	7a4 <vprintf+0x4a>
        if((s = va_arg(ap, char*)) == 0)
 9aa:	008b8993          	add	s3,s7,8
 9ae:	000bb903          	ld	s2,0(s7)
 9b2:	00090f63          	beqz	s2,9d0 <vprintf+0x276>
        for(; *s; s++)
 9b6:	00094583          	lbu	a1,0(s2)
 9ba:	c195                	beqz	a1,9de <vprintf+0x284>
          putc(fd, *s);
 9bc:	855a                	mv	a0,s6
 9be:	ce3ff0ef          	jal	6a0 <putc>
        for(; *s; s++)
 9c2:	0905                	add	s2,s2,1
 9c4:	00094583          	lbu	a1,0(s2)
 9c8:	f9f5                	bnez	a1,9bc <vprintf+0x262>
        if((s = va_arg(ap, char*)) == 0)
 9ca:	8bce                	mv	s7,s3
      state = 0;
 9cc:	4981                	li	s3,0
 9ce:	bbd9                	j	7a4 <vprintf+0x4a>
          s = "(null)";
 9d0:	00000917          	auipc	s2,0x0
 9d4:	35890913          	add	s2,s2,856 # d28 <malloc+0x24c>
        for(; *s; s++)
 9d8:	02800593          	li	a1,40
 9dc:	b7c5                	j	9bc <vprintf+0x262>
        if((s = va_arg(ap, char*)) == 0)
 9de:	8bce                	mv	s7,s3
      state = 0;
 9e0:	4981                	li	s3,0
 9e2:	b3c9                	j	7a4 <vprintf+0x4a>
 9e4:	64a6                	ld	s1,72(sp)
 9e6:	79e2                	ld	s3,56(sp)
 9e8:	7a42                	ld	s4,48(sp)
 9ea:	7aa2                	ld	s5,40(sp)
 9ec:	7b02                	ld	s6,32(sp)
 9ee:	6be2                	ld	s7,24(sp)
 9f0:	6c42                	ld	s8,16(sp)
 9f2:	6ca2                	ld	s9,8(sp)
    }
  }
}
 9f4:	60e6                	ld	ra,88(sp)
 9f6:	6446                	ld	s0,80(sp)
 9f8:	6906                	ld	s2,64(sp)
 9fa:	6125                	add	sp,sp,96
 9fc:	8082                	ret

00000000000009fe <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 9fe:	715d                	add	sp,sp,-80
 a00:	ec06                	sd	ra,24(sp)
 a02:	e822                	sd	s0,16(sp)
 a04:	1000                	add	s0,sp,32
 a06:	e010                	sd	a2,0(s0)
 a08:	e414                	sd	a3,8(s0)
 a0a:	e818                	sd	a4,16(s0)
 a0c:	ec1c                	sd	a5,24(s0)
 a0e:	03043023          	sd	a6,32(s0)
 a12:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 a16:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 a1a:	8622                	mv	a2,s0
 a1c:	d3fff0ef          	jal	75a <vprintf>
}
 a20:	60e2                	ld	ra,24(sp)
 a22:	6442                	ld	s0,16(sp)
 a24:	6161                	add	sp,sp,80
 a26:	8082                	ret

0000000000000a28 <printf>:

void
printf(const char *fmt, ...)
{
 a28:	711d                	add	sp,sp,-96
 a2a:	ec06                	sd	ra,24(sp)
 a2c:	e822                	sd	s0,16(sp)
 a2e:	1000                	add	s0,sp,32
 a30:	e40c                	sd	a1,8(s0)
 a32:	e810                	sd	a2,16(s0)
 a34:	ec14                	sd	a3,24(s0)
 a36:	f018                	sd	a4,32(s0)
 a38:	f41c                	sd	a5,40(s0)
 a3a:	03043823          	sd	a6,48(s0)
 a3e:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 a42:	00840613          	add	a2,s0,8
 a46:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 a4a:	85aa                	mv	a1,a0
 a4c:	4505                	li	a0,1
 a4e:	d0dff0ef          	jal	75a <vprintf>
}
 a52:	60e2                	ld	ra,24(sp)
 a54:	6442                	ld	s0,16(sp)
 a56:	6125                	add	sp,sp,96
 a58:	8082                	ret

0000000000000a5a <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 a5a:	1141                	add	sp,sp,-16
 a5c:	e422                	sd	s0,8(sp)
 a5e:	0800                	add	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 a60:	ff050693          	add	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 a64:	00000797          	auipc	a5,0x0
 a68:	59c7b783          	ld	a5,1436(a5) # 1000 <freep>
 a6c:	a02d                	j	a96 <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 a6e:	4618                	lw	a4,8(a2)
 a70:	9f2d                	addw	a4,a4,a1
 a72:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 a76:	6398                	ld	a4,0(a5)
 a78:	6310                	ld	a2,0(a4)
 a7a:	a83d                	j	ab8 <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 a7c:	ff852703          	lw	a4,-8(a0)
 a80:	9f31                	addw	a4,a4,a2
 a82:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 a84:	ff053683          	ld	a3,-16(a0)
 a88:	a091                	j	acc <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 a8a:	6398                	ld	a4,0(a5)
 a8c:	00e7e463          	bltu	a5,a4,a94 <free+0x3a>
 a90:	00e6ea63          	bltu	a3,a4,aa4 <free+0x4a>
{
 a94:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 a96:	fed7fae3          	bgeu	a5,a3,a8a <free+0x30>
 a9a:	6398                	ld	a4,0(a5)
 a9c:	00e6e463          	bltu	a3,a4,aa4 <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 aa0:	fee7eae3          	bltu	a5,a4,a94 <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 aa4:	ff852583          	lw	a1,-8(a0)
 aa8:	6390                	ld	a2,0(a5)
 aaa:	02059813          	sll	a6,a1,0x20
 aae:	01c85713          	srl	a4,a6,0x1c
 ab2:	9736                	add	a4,a4,a3
 ab4:	fae60de3          	beq	a2,a4,a6e <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 ab8:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 abc:	4790                	lw	a2,8(a5)
 abe:	02061593          	sll	a1,a2,0x20
 ac2:	01c5d713          	srl	a4,a1,0x1c
 ac6:	973e                	add	a4,a4,a5
 ac8:	fae68ae3          	beq	a3,a4,a7c <free+0x22>
    p->s.ptr = bp->s.ptr;
 acc:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 ace:	00000717          	auipc	a4,0x0
 ad2:	52f73923          	sd	a5,1330(a4) # 1000 <freep>
}
 ad6:	6422                	ld	s0,8(sp)
 ad8:	0141                	add	sp,sp,16
 ada:	8082                	ret

0000000000000adc <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 adc:	7139                	add	sp,sp,-64
 ade:	fc06                	sd	ra,56(sp)
 ae0:	f822                	sd	s0,48(sp)
 ae2:	f426                	sd	s1,40(sp)
 ae4:	ec4e                	sd	s3,24(sp)
 ae6:	0080                	add	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 ae8:	02051493          	sll	s1,a0,0x20
 aec:	9081                	srl	s1,s1,0x20
 aee:	04bd                	add	s1,s1,15
 af0:	8091                	srl	s1,s1,0x4
 af2:	0014899b          	addw	s3,s1,1
 af6:	0485                	add	s1,s1,1
  if((prevp = freep) == 0){
 af8:	00000517          	auipc	a0,0x0
 afc:	50853503          	ld	a0,1288(a0) # 1000 <freep>
 b00:	c915                	beqz	a0,b34 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 b02:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 b04:	4798                	lw	a4,8(a5)
 b06:	08977a63          	bgeu	a4,s1,b9a <malloc+0xbe>
 b0a:	f04a                	sd	s2,32(sp)
 b0c:	e852                	sd	s4,16(sp)
 b0e:	e456                	sd	s5,8(sp)
 b10:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 b12:	8a4e                	mv	s4,s3
 b14:	0009871b          	sext.w	a4,s3
 b18:	6685                	lui	a3,0x1
 b1a:	00d77363          	bgeu	a4,a3,b20 <malloc+0x44>
 b1e:	6a05                	lui	s4,0x1
 b20:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 b24:	004a1a1b          	sllw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 b28:	00000917          	auipc	s2,0x0
 b2c:	4d890913          	add	s2,s2,1240 # 1000 <freep>
  if(p == SBRK_ERROR)
 b30:	5afd                	li	s5,-1
 b32:	a081                	j	b72 <malloc+0x96>
 b34:	f04a                	sd	s2,32(sp)
 b36:	e852                	sd	s4,16(sp)
 b38:	e456                	sd	s5,8(sp)
 b3a:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 b3c:	00001797          	auipc	a5,0x1
 b40:	cd478793          	add	a5,a5,-812 # 1810 <base>
 b44:	00000717          	auipc	a4,0x0
 b48:	4af73e23          	sd	a5,1212(a4) # 1000 <freep>
 b4c:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 b4e:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 b52:	b7c1                	j	b12 <malloc+0x36>
        prevp->s.ptr = p->s.ptr;
 b54:	6398                	ld	a4,0(a5)
 b56:	e118                	sd	a4,0(a0)
 b58:	a8a9                	j	bb2 <malloc+0xd6>
  hp->s.size = nu;
 b5a:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 b5e:	0541                	add	a0,a0,16
 b60:	efbff0ef          	jal	a5a <free>
  return freep;
 b64:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 b68:	c12d                	beqz	a0,bca <malloc+0xee>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 b6a:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 b6c:	4798                	lw	a4,8(a5)
 b6e:	02977263          	bgeu	a4,s1,b92 <malloc+0xb6>
    if(p == freep)
 b72:	00093703          	ld	a4,0(s2)
 b76:	853e                	mv	a0,a5
 b78:	fef719e3          	bne	a4,a5,b6a <malloc+0x8e>
  p = sbrk(nu * sizeof(Header));
 b7c:	8552                	mv	a0,s4
 b7e:	967ff0ef          	jal	4e4 <sbrk>
  if(p == SBRK_ERROR)
 b82:	fd551ce3          	bne	a0,s5,b5a <malloc+0x7e>
        return 0;
 b86:	4501                	li	a0,0
 b88:	7902                	ld	s2,32(sp)
 b8a:	6a42                	ld	s4,16(sp)
 b8c:	6aa2                	ld	s5,8(sp)
 b8e:	6b02                	ld	s6,0(sp)
 b90:	a03d                	j	bbe <malloc+0xe2>
 b92:	7902                	ld	s2,32(sp)
 b94:	6a42                	ld	s4,16(sp)
 b96:	6aa2                	ld	s5,8(sp)
 b98:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 b9a:	fae48de3          	beq	s1,a4,b54 <malloc+0x78>
        p->s.size -= nunits;
 b9e:	4137073b          	subw	a4,a4,s3
 ba2:	c798                	sw	a4,8(a5)
        p += p->s.size;
 ba4:	02071693          	sll	a3,a4,0x20
 ba8:	01c6d713          	srl	a4,a3,0x1c
 bac:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 bae:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 bb2:	00000717          	auipc	a4,0x0
 bb6:	44a73723          	sd	a0,1102(a4) # 1000 <freep>
      return (void*)(p + 1);
 bba:	01078513          	add	a0,a5,16
  }
}
 bbe:	70e2                	ld	ra,56(sp)
 bc0:	7442                	ld	s0,48(sp)
 bc2:	74a2                	ld	s1,40(sp)
 bc4:	69e2                	ld	s3,24(sp)
 bc6:	6121                	add	sp,sp,64
 bc8:	8082                	ret
 bca:	7902                	ld	s2,32(sp)
 bcc:	6a42                	ld	s4,16(sp)
 bce:	6aa2                	ld	s5,8(sp)
 bd0:	6b02                	ld	s6,0(sp)
 bd2:	b7f5                	j	bbe <malloc+0xe2>
