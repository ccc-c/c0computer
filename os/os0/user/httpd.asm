
user/_httpd:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <parse_request>:
char recvbuf[1024];

int
parse_request(char *buf, int len)
{
    if (len < 4)
   0:	478d                	li	a5,3
   2:	00b7c463          	blt	a5,a1,a <parse_request+0xa>
        return 0;
   6:	4501                	li	a0,0
    if (strncmp(buf, "GET", 3) == 0)
        return 1;
    return 0;
}
   8:	8082                	ret
{
   a:	1141                	add	sp,sp,-16
   c:	e406                	sd	ra,8(sp)
   e:	e022                	sd	s0,0(sp)
  10:	0800                	add	s0,sp,16
    if (strncmp(buf, "GET", 3) == 0)
  12:	460d                	li	a2,3
  14:	00001597          	auipc	a1,0x1
  18:	b9c58593          	add	a1,a1,-1124 # bb0 <malloc+0x100>
  1c:	1fa000ef          	jal	216 <strncmp>
  20:	00153513          	seqz	a0,a0
}
  24:	60a2                	ld	ra,8(sp)
  26:	6402                	ld	s0,0(sp)
  28:	0141                	add	sp,sp,16
  2a:	8082                	ret

000000000000002c <main>:

int
main(int argc, char *argv[])
{
  2c:	7159                	add	sp,sp,-112
  2e:	f486                	sd	ra,104(sp)
  30:	f0a2                	sd	s0,96(sp)
  32:	eca6                	sd	s1,88(sp)
  34:	e8ca                	sd	s2,80(sp)
  36:	1880                	add	s0,sp,112
    struct sockaddr_in server_addr, client_addr;
    int client_addr_len;
    int ret;
    int port = 80;

    if (argc > 1) {
  38:	4785                	li	a5,1
    int port = 80;
  3a:	05000493          	li	s1,80
    if (argc > 1) {
  3e:	06a7cd63          	blt	a5,a0,b8 <main+0x8c>
        port = atoi(argv[1]);
    }

    printf("HTTP Server starting on port %d\n", port);
  42:	85a6                	mv	a1,s1
  44:	00001517          	auipc	a0,0x1
  48:	b7450513          	add	a0,a0,-1164 # bb8 <malloc+0x108>
  4c:	1b1000ef          	jal	9fc <printf>

    soc = socket(PF_INET, SOCK_STREAM, IPPROTO_TCP);
  50:	4601                	li	a2,0
  52:	4589                	li	a1,2
  54:	4505                	li	a0,1
  56:	5d6000ef          	jal	62c <socket>
  5a:	892a                	mv	s2,a0
    if (soc < 0) {
  5c:	06054363          	bltz	a0,c2 <main+0x96>
        printf("httpd: socket failed\n");
        exit(1);
    }

    server_addr.sin_family = AF_INET;
  60:	4785                	li	a5,1
  62:	faf41423          	sh	a5,-88(s0)
    server_addr.sin_addr.s_addr = INADDR_ANY;
  66:	fa042623          	sw	zero,-84(s0)
    server_addr.sin_port = htons(port);
  6a:	03049513          	sll	a0,s1,0x30
  6e:	9141                	srl	a0,a0,0x30
  70:	474000ef          	jal	4e4 <htons>
  74:	faa41523          	sh	a0,-86(s0)

    if (bind(soc, (struct sockaddr *)&server_addr, sizeof(server_addr)) < 0) {
  78:	4621                	li	a2,8
  7a:	fa840593          	add	a1,s0,-88
  7e:	854a                	mv	a0,s2
  80:	5b4000ef          	jal	634 <bind>
  84:	04054e63          	bltz	a0,e0 <main+0xb4>
        printf("httpd: bind failed\n");
        close(soc);
        exit(1);
    }

    if (listen(soc, 5) < 0) {
  88:	4595                	li	a1,5
  8a:	854a                	mv	a0,s2
  8c:	5b0000ef          	jal	63c <listen>
  90:	06055a63          	bgez	a0,104 <main+0xd8>
  94:	e4ce                	sd	s3,72(sp)
  96:	e0d2                	sd	s4,64(sp)
  98:	fc56                	sd	s5,56(sp)
  9a:	f85a                	sd	s6,48(sp)
  9c:	f45e                	sd	s7,40(sp)
  9e:	f062                	sd	s8,32(sp)
        printf("httpd: listen failed\n");
  a0:	00001517          	auipc	a0,0x1
  a4:	b7050513          	add	a0,a0,-1168 # c10 <malloc+0x160>
  a8:	155000ef          	jal	9fc <printf>
        close(soc);
  ac:	854a                	mv	a0,s2
  ae:	506000ef          	jal	5b4 <close>
        exit(1);
  b2:	4505                	li	a0,1
  b4:	4d8000ef          	jal	58c <exit>
        port = atoi(argv[1]);
  b8:	6588                	ld	a0,8(a1)
  ba:	310000ef          	jal	3ca <atoi>
  be:	84aa                	mv	s1,a0
  c0:	b749                	j	42 <main+0x16>
  c2:	e4ce                	sd	s3,72(sp)
  c4:	e0d2                	sd	s4,64(sp)
  c6:	fc56                	sd	s5,56(sp)
  c8:	f85a                	sd	s6,48(sp)
  ca:	f45e                	sd	s7,40(sp)
  cc:	f062                	sd	s8,32(sp)
        printf("httpd: socket failed\n");
  ce:	00001517          	auipc	a0,0x1
  d2:	b1250513          	add	a0,a0,-1262 # be0 <malloc+0x130>
  d6:	127000ef          	jal	9fc <printf>
        exit(1);
  da:	4505                	li	a0,1
  dc:	4b0000ef          	jal	58c <exit>
  e0:	e4ce                	sd	s3,72(sp)
  e2:	e0d2                	sd	s4,64(sp)
  e4:	fc56                	sd	s5,56(sp)
  e6:	f85a                	sd	s6,48(sp)
  e8:	f45e                	sd	s7,40(sp)
  ea:	f062                	sd	s8,32(sp)
        printf("httpd: bind failed\n");
  ec:	00001517          	auipc	a0,0x1
  f0:	b0c50513          	add	a0,a0,-1268 # bf8 <malloc+0x148>
  f4:	109000ef          	jal	9fc <printf>
        close(soc);
  f8:	854a                	mv	a0,s2
  fa:	4ba000ef          	jal	5b4 <close>
        exit(1);
  fe:	4505                	li	a0,1
 100:	48c000ef          	jal	58c <exit>
 104:	e4ce                	sd	s3,72(sp)
 106:	e0d2                	sd	s4,64(sp)
 108:	fc56                	sd	s5,56(sp)
 10a:	f85a                	sd	s6,48(sp)
 10c:	f45e                	sd	s7,40(sp)
 10e:	f062                	sd	s8,32(sp)
    }

    printf("HTTP Server listening on port %d\n", port);
 110:	85a6                	mv	a1,s1
 112:	00001517          	auipc	a0,0x1
 116:	b1650513          	add	a0,a0,-1258 # c28 <malloc+0x178>
 11a:	0e3000ef          	jal	9fc <printf>

    while (1) {
        client_addr_len = sizeof(client_addr);
 11e:	49a1                	li	s3,8
        if (client_sock < 0) {
            printf("httpd: accept failed\n");
            continue;
        }

        ret = recv(client_sock, recvbuf, sizeof(recvbuf) - 1, 0);
 120:	00001a17          	auipc	s4,0x1
 124:	f00a0a13          	add	s4,s4,-256 # 1020 <recvbuf>
            recvbuf[ret] = '\0';
            
            if (parse_request(recvbuf, ret)) {
                send(client_sock, html_response, strlen(html_response), 0);
            } else {
                send(client_sock, not_found_response, strlen(not_found_response), 0);
 128:	00001b97          	auipc	s7,0x1
 12c:	ed8b8b93          	add	s7,s7,-296 # 1000 <not_found_response>
                send(client_sock, html_response, strlen(html_response), 0);
 130:	00001b17          	auipc	s6,0x1
 134:	ed8b0b13          	add	s6,s6,-296 # 1008 <html_response>
            printf("httpd: accept failed\n");
 138:	00001a97          	auipc	s5,0x1
 13c:	b18a8a93          	add	s5,s5,-1256 # c50 <malloc+0x1a0>
 140:	a021                	j	148 <main+0x11c>
 142:	8556                	mv	a0,s5
 144:	0b9000ef          	jal	9fc <printf>
        client_addr_len = sizeof(client_addr);
 148:	f9342e23          	sw	s3,-100(s0)
        client_sock = accept(soc, (struct sockaddr *)&client_addr, &client_addr_len);
 14c:	f9c40613          	add	a2,s0,-100
 150:	fa040593          	add	a1,s0,-96
 154:	854a                	mv	a0,s2
 156:	4ee000ef          	jal	644 <accept>
 15a:	84aa                	mv	s1,a0
        if (client_sock < 0) {
 15c:	fe0543e3          	bltz	a0,142 <main+0x116>
        ret = recv(client_sock, recvbuf, sizeof(recvbuf) - 1, 0);
 160:	4681                	li	a3,0
 162:	3ff00613          	li	a2,1023
 166:	85d2                	mv	a1,s4
 168:	4f4000ef          	jal	65c <recv>
        if (ret > 0) {
 16c:	00a04663          	bgtz	a0,178 <main+0x14c>
            }
        }

        close(client_sock);
 170:	8526                	mv	a0,s1
 172:	442000ef          	jal	5b4 <close>
 176:	bfc9                	j	148 <main+0x11c>
            recvbuf[ret] = '\0';
 178:	00aa07b3          	add	a5,s4,a0
 17c:	00078023          	sb	zero,0(a5)
            if (parse_request(recvbuf, ret)) {
 180:	85aa                	mv	a1,a0
 182:	8552                	mv	a0,s4
 184:	e7dff0ef          	jal	0 <parse_request>
 188:	cd11                	beqz	a0,1a4 <main+0x178>
                send(client_sock, html_response, strlen(html_response), 0);
 18a:	000b3c03          	ld	s8,0(s6)
 18e:	8562                	mv	a0,s8
 190:	120000ef          	jal	2b0 <strlen>
 194:	4681                	li	a3,0
 196:	0005061b          	sext.w	a2,a0
 19a:	85e2                	mv	a1,s8
 19c:	8526                	mv	a0,s1
 19e:	4b6000ef          	jal	654 <send>
 1a2:	b7f9                	j	170 <main+0x144>
                send(client_sock, not_found_response, strlen(not_found_response), 0);
 1a4:	000bbc03          	ld	s8,0(s7)
 1a8:	8562                	mv	a0,s8
 1aa:	106000ef          	jal	2b0 <strlen>
 1ae:	4681                	li	a3,0
 1b0:	0005061b          	sext.w	a2,a0
 1b4:	85e2                	mv	a1,s8
 1b6:	8526                	mv	a0,s1
 1b8:	49c000ef          	jal	654 <send>
 1bc:	bf55                	j	170 <main+0x144>

00000000000001be <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start(int argc, char **argv)
{
 1be:	1141                	add	sp,sp,-16
 1c0:	e406                	sd	ra,8(sp)
 1c2:	e022                	sd	s0,0(sp)
 1c4:	0800                	add	s0,sp,16
  int r;
  extern int main(int argc, char **argv);
  r = main(argc, argv);
 1c6:	e67ff0ef          	jal	2c <main>
  exit(r);
 1ca:	3c2000ef          	jal	58c <exit>

00000000000001ce <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
 1ce:	1141                	add	sp,sp,-16
 1d0:	e422                	sd	s0,8(sp)
 1d2:	0800                	add	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 1d4:	87aa                	mv	a5,a0
 1d6:	0585                	add	a1,a1,1
 1d8:	0785                	add	a5,a5,1
 1da:	fff5c703          	lbu	a4,-1(a1)
 1de:	fee78fa3          	sb	a4,-1(a5)
 1e2:	fb75                	bnez	a4,1d6 <strcpy+0x8>
    ;
  return os;
}
 1e4:	6422                	ld	s0,8(sp)
 1e6:	0141                	add	sp,sp,16
 1e8:	8082                	ret

00000000000001ea <strcmp>:

int
strcmp(const char *p, const char *q)
{
 1ea:	1141                	add	sp,sp,-16
 1ec:	e422                	sd	s0,8(sp)
 1ee:	0800                	add	s0,sp,16
  while(*p && *p == *q)
 1f0:	00054783          	lbu	a5,0(a0)
 1f4:	cb91                	beqz	a5,208 <strcmp+0x1e>
 1f6:	0005c703          	lbu	a4,0(a1)
 1fa:	00f71763          	bne	a4,a5,208 <strcmp+0x1e>
    p++, q++;
 1fe:	0505                	add	a0,a0,1
 200:	0585                	add	a1,a1,1
  while(*p && *p == *q)
 202:	00054783          	lbu	a5,0(a0)
 206:	fbe5                	bnez	a5,1f6 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 208:	0005c503          	lbu	a0,0(a1)
}
 20c:	40a7853b          	subw	a0,a5,a0
 210:	6422                	ld	s0,8(sp)
 212:	0141                	add	sp,sp,16
 214:	8082                	ret

0000000000000216 <strncmp>:

int
strncmp(const char *p, const char *q, uint n)
{
 216:	1141                	add	sp,sp,-16
 218:	e422                	sd	s0,8(sp)
 21a:	0800                	add	s0,sp,16
  while(n > 0 && *p && *p == *q) {
 21c:	ce11                	beqz	a2,238 <strncmp+0x22>
 21e:	00054783          	lbu	a5,0(a0)
 222:	cf89                	beqz	a5,23c <strncmp+0x26>
 224:	0005c703          	lbu	a4,0(a1)
 228:	00f71a63          	bne	a4,a5,23c <strncmp+0x26>
    p++, q++, n--;
 22c:	0505                	add	a0,a0,1
 22e:	0585                	add	a1,a1,1
 230:	367d                	addw	a2,a2,-1
  while(n > 0 && *p && *p == *q) {
 232:	f675                	bnez	a2,21e <strncmp+0x8>
  }
  if (n == 0)
    return 0;
 234:	4501                	li	a0,0
 236:	a801                	j	246 <strncmp+0x30>
 238:	4501                	li	a0,0
 23a:	a031                	j	246 <strncmp+0x30>
  return (uchar)*p - (uchar)*q;
 23c:	00054503          	lbu	a0,0(a0)
 240:	0005c783          	lbu	a5,0(a1)
 244:	9d1d                	subw	a0,a0,a5
}
 246:	6422                	ld	s0,8(sp)
 248:	0141                	add	sp,sp,16
 24a:	8082                	ret

000000000000024c <strcat>:

char*
strcat(char *dst, const char *src)
{
 24c:	1141                	add	sp,sp,-16
 24e:	e422                	sd	s0,8(sp)
 250:	0800                	add	s0,sp,16
  char *p = dst;
  while(*p) p++;
 252:	00054783          	lbu	a5,0(a0)
 256:	c385                	beqz	a5,276 <strcat+0x2a>
  char *p = dst;
 258:	87aa                	mv	a5,a0
  while(*p) p++;
 25a:	0785                	add	a5,a5,1
 25c:	0007c703          	lbu	a4,0(a5)
 260:	ff6d                	bnez	a4,25a <strcat+0xe>
  while((*p++ = *src++) != 0);
 262:	0585                	add	a1,a1,1
 264:	0785                	add	a5,a5,1
 266:	fff5c703          	lbu	a4,-1(a1)
 26a:	fee78fa3          	sb	a4,-1(a5)
 26e:	fb75                	bnez	a4,262 <strcat+0x16>
  return dst;
}
 270:	6422                	ld	s0,8(sp)
 272:	0141                	add	sp,sp,16
 274:	8082                	ret
  char *p = dst;
 276:	87aa                	mv	a5,a0
 278:	b7ed                	j	262 <strcat+0x16>

000000000000027a <strncpy>:

char*
strncpy(char *dst, const char *src, int n)
{
 27a:	1141                	add	sp,sp,-16
 27c:	e422                	sd	s0,8(sp)
 27e:	0800                	add	s0,sp,16
  char *p = dst;
 280:	87aa                	mv	a5,a0
  while(n > 0 && *src) {
 282:	02c05463          	blez	a2,2aa <strncpy+0x30>
 286:	0005c703          	lbu	a4,0(a1)
 28a:	cb01                	beqz	a4,29a <strncpy+0x20>
    *p++ = *src++;
 28c:	0585                	add	a1,a1,1
 28e:	0785                	add	a5,a5,1
 290:	fee78fa3          	sb	a4,-1(a5)
    n--;
 294:	367d                	addw	a2,a2,-1
  while(n > 0 && *src) {
 296:	fa65                	bnez	a2,286 <strncpy+0xc>
 298:	a809                	j	2aa <strncpy+0x30>
  }
  while(n > 0) {
 29a:	1602                	sll	a2,a2,0x20
 29c:	9201                	srl	a2,a2,0x20
 29e:	963e                	add	a2,a2,a5
    *p++ = 0;
 2a0:	0785                	add	a5,a5,1
 2a2:	fe078fa3          	sb	zero,-1(a5)
  while(n > 0) {
 2a6:	fec79de3          	bne	a5,a2,2a0 <strncpy+0x26>
    n--;
  }
  return dst;
}
 2aa:	6422                	ld	s0,8(sp)
 2ac:	0141                	add	sp,sp,16
 2ae:	8082                	ret

00000000000002b0 <strlen>:

uint
strlen(const char *s)
{
 2b0:	1141                	add	sp,sp,-16
 2b2:	e422                	sd	s0,8(sp)
 2b4:	0800                	add	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 2b6:	00054783          	lbu	a5,0(a0)
 2ba:	cf91                	beqz	a5,2d6 <strlen+0x26>
 2bc:	0505                	add	a0,a0,1
 2be:	87aa                	mv	a5,a0
 2c0:	86be                	mv	a3,a5
 2c2:	0785                	add	a5,a5,1
 2c4:	fff7c703          	lbu	a4,-1(a5)
 2c8:	ff65                	bnez	a4,2c0 <strlen+0x10>
 2ca:	40a6853b          	subw	a0,a3,a0
 2ce:	2505                	addw	a0,a0,1
    ;
  return n;
}
 2d0:	6422                	ld	s0,8(sp)
 2d2:	0141                	add	sp,sp,16
 2d4:	8082                	ret
  for(n = 0; s[n]; n++)
 2d6:	4501                	li	a0,0
 2d8:	bfe5                	j	2d0 <strlen+0x20>

00000000000002da <memset>:

void*
memset(void *dst, int c, uint n)
{
 2da:	1141                	add	sp,sp,-16
 2dc:	e422                	sd	s0,8(sp)
 2de:	0800                	add	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 2e0:	ca19                	beqz	a2,2f6 <memset+0x1c>
 2e2:	87aa                	mv	a5,a0
 2e4:	1602                	sll	a2,a2,0x20
 2e6:	9201                	srl	a2,a2,0x20
 2e8:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 2ec:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 2f0:	0785                	add	a5,a5,1
 2f2:	fee79de3          	bne	a5,a4,2ec <memset+0x12>
  }
  return dst;
}
 2f6:	6422                	ld	s0,8(sp)
 2f8:	0141                	add	sp,sp,16
 2fa:	8082                	ret

00000000000002fc <strchr>:

char*
strchr(const char *s, char c)
{
 2fc:	1141                	add	sp,sp,-16
 2fe:	e422                	sd	s0,8(sp)
 300:	0800                	add	s0,sp,16
  for(; *s; s++)
 302:	00054783          	lbu	a5,0(a0)
 306:	cb99                	beqz	a5,31c <strchr+0x20>
    if(*s == c)
 308:	00f58763          	beq	a1,a5,316 <strchr+0x1a>
  for(; *s; s++)
 30c:	0505                	add	a0,a0,1
 30e:	00054783          	lbu	a5,0(a0)
 312:	fbfd                	bnez	a5,308 <strchr+0xc>
      return (char*)s;
  return 0;
 314:	4501                	li	a0,0
}
 316:	6422                	ld	s0,8(sp)
 318:	0141                	add	sp,sp,16
 31a:	8082                	ret
  return 0;
 31c:	4501                	li	a0,0
 31e:	bfe5                	j	316 <strchr+0x1a>

0000000000000320 <gets>:

char*
gets(char *buf, int max)
{
 320:	711d                	add	sp,sp,-96
 322:	ec86                	sd	ra,88(sp)
 324:	e8a2                	sd	s0,80(sp)
 326:	e4a6                	sd	s1,72(sp)
 328:	e0ca                	sd	s2,64(sp)
 32a:	fc4e                	sd	s3,56(sp)
 32c:	f852                	sd	s4,48(sp)
 32e:	f456                	sd	s5,40(sp)
 330:	f05a                	sd	s6,32(sp)
 332:	ec5e                	sd	s7,24(sp)
 334:	1080                	add	s0,sp,96
 336:	8baa                	mv	s7,a0
 338:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 33a:	892a                	mv	s2,a0
 33c:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 33e:	4aa9                	li	s5,10
 340:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 342:	89a6                	mv	s3,s1
 344:	2485                	addw	s1,s1,1
 346:	0344d663          	bge	s1,s4,372 <gets+0x52>
    cc = read(0, &c, 1);
 34a:	4605                	li	a2,1
 34c:	faf40593          	add	a1,s0,-81
 350:	4501                	li	a0,0
 352:	252000ef          	jal	5a4 <read>
    if(cc < 1)
 356:	00a05e63          	blez	a0,372 <gets+0x52>
    buf[i++] = c;
 35a:	faf44783          	lbu	a5,-81(s0)
 35e:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 362:	01578763          	beq	a5,s5,370 <gets+0x50>
 366:	0905                	add	s2,s2,1
 368:	fd679de3          	bne	a5,s6,342 <gets+0x22>
    buf[i++] = c;
 36c:	89a6                	mv	s3,s1
 36e:	a011                	j	372 <gets+0x52>
 370:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 372:	99de                	add	s3,s3,s7
 374:	00098023          	sb	zero,0(s3)
  return buf;
}
 378:	855e                	mv	a0,s7
 37a:	60e6                	ld	ra,88(sp)
 37c:	6446                	ld	s0,80(sp)
 37e:	64a6                	ld	s1,72(sp)
 380:	6906                	ld	s2,64(sp)
 382:	79e2                	ld	s3,56(sp)
 384:	7a42                	ld	s4,48(sp)
 386:	7aa2                	ld	s5,40(sp)
 388:	7b02                	ld	s6,32(sp)
 38a:	6be2                	ld	s7,24(sp)
 38c:	6125                	add	sp,sp,96
 38e:	8082                	ret

0000000000000390 <stat>:

int
stat(const char *n, struct stat *st)
{
 390:	1101                	add	sp,sp,-32
 392:	ec06                	sd	ra,24(sp)
 394:	e822                	sd	s0,16(sp)
 396:	e04a                	sd	s2,0(sp)
 398:	1000                	add	s0,sp,32
 39a:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 39c:	4581                	li	a1,0
 39e:	22e000ef          	jal	5cc <open>
  if(fd < 0)
 3a2:	02054263          	bltz	a0,3c6 <stat+0x36>
 3a6:	e426                	sd	s1,8(sp)
 3a8:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 3aa:	85ca                	mv	a1,s2
 3ac:	238000ef          	jal	5e4 <fstat>
 3b0:	892a                	mv	s2,a0
  close(fd);
 3b2:	8526                	mv	a0,s1
 3b4:	200000ef          	jal	5b4 <close>
  return r;
 3b8:	64a2                	ld	s1,8(sp)
}
 3ba:	854a                	mv	a0,s2
 3bc:	60e2                	ld	ra,24(sp)
 3be:	6442                	ld	s0,16(sp)
 3c0:	6902                	ld	s2,0(sp)
 3c2:	6105                	add	sp,sp,32
 3c4:	8082                	ret
    return -1;
 3c6:	597d                	li	s2,-1
 3c8:	bfcd                	j	3ba <stat+0x2a>

00000000000003ca <atoi>:

int
atoi(const char *s)
{
 3ca:	1141                	add	sp,sp,-16
 3cc:	e422                	sd	s0,8(sp)
 3ce:	0800                	add	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 3d0:	00054683          	lbu	a3,0(a0)
 3d4:	fd06879b          	addw	a5,a3,-48
 3d8:	0ff7f793          	zext.b	a5,a5
 3dc:	4625                	li	a2,9
 3de:	02f66863          	bltu	a2,a5,40e <atoi+0x44>
 3e2:	872a                	mv	a4,a0
  n = 0;
 3e4:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 3e6:	0705                	add	a4,a4,1
 3e8:	0025179b          	sllw	a5,a0,0x2
 3ec:	9fa9                	addw	a5,a5,a0
 3ee:	0017979b          	sllw	a5,a5,0x1
 3f2:	9fb5                	addw	a5,a5,a3
 3f4:	fd07851b          	addw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 3f8:	00074683          	lbu	a3,0(a4)
 3fc:	fd06879b          	addw	a5,a3,-48
 400:	0ff7f793          	zext.b	a5,a5
 404:	fef671e3          	bgeu	a2,a5,3e6 <atoi+0x1c>
  return n;
}
 408:	6422                	ld	s0,8(sp)
 40a:	0141                	add	sp,sp,16
 40c:	8082                	ret
  n = 0;
 40e:	4501                	li	a0,0
 410:	bfe5                	j	408 <atoi+0x3e>

0000000000000412 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 412:	1141                	add	sp,sp,-16
 414:	e422                	sd	s0,8(sp)
 416:	0800                	add	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 418:	02b57463          	bgeu	a0,a1,440 <memmove+0x2e>
    while(n-- > 0)
 41c:	00c05f63          	blez	a2,43a <memmove+0x28>
 420:	1602                	sll	a2,a2,0x20
 422:	9201                	srl	a2,a2,0x20
 424:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 428:	872a                	mv	a4,a0
      *dst++ = *src++;
 42a:	0585                	add	a1,a1,1
 42c:	0705                	add	a4,a4,1
 42e:	fff5c683          	lbu	a3,-1(a1)
 432:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 436:	fef71ae3          	bne	a4,a5,42a <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 43a:	6422                	ld	s0,8(sp)
 43c:	0141                	add	sp,sp,16
 43e:	8082                	ret
    dst += n;
 440:	00c50733          	add	a4,a0,a2
    src += n;
 444:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 446:	fec05ae3          	blez	a2,43a <memmove+0x28>
 44a:	fff6079b          	addw	a5,a2,-1
 44e:	1782                	sll	a5,a5,0x20
 450:	9381                	srl	a5,a5,0x20
 452:	fff7c793          	not	a5,a5
 456:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 458:	15fd                	add	a1,a1,-1
 45a:	177d                	add	a4,a4,-1
 45c:	0005c683          	lbu	a3,0(a1)
 460:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 464:	fee79ae3          	bne	a5,a4,458 <memmove+0x46>
 468:	bfc9                	j	43a <memmove+0x28>

000000000000046a <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 46a:	1141                	add	sp,sp,-16
 46c:	e422                	sd	s0,8(sp)
 46e:	0800                	add	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 470:	ca05                	beqz	a2,4a0 <memcmp+0x36>
 472:	fff6069b          	addw	a3,a2,-1
 476:	1682                	sll	a3,a3,0x20
 478:	9281                	srl	a3,a3,0x20
 47a:	0685                	add	a3,a3,1
 47c:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 47e:	00054783          	lbu	a5,0(a0)
 482:	0005c703          	lbu	a4,0(a1)
 486:	00e79863          	bne	a5,a4,496 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 48a:	0505                	add	a0,a0,1
    p2++;
 48c:	0585                	add	a1,a1,1
  while (n-- > 0) {
 48e:	fed518e3          	bne	a0,a3,47e <memcmp+0x14>
  }
  return 0;
 492:	4501                	li	a0,0
 494:	a019                	j	49a <memcmp+0x30>
      return *p1 - *p2;
 496:	40e7853b          	subw	a0,a5,a4
}
 49a:	6422                	ld	s0,8(sp)
 49c:	0141                	add	sp,sp,16
 49e:	8082                	ret
  return 0;
 4a0:	4501                	li	a0,0
 4a2:	bfe5                	j	49a <memcmp+0x30>

00000000000004a4 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 4a4:	1141                	add	sp,sp,-16
 4a6:	e406                	sd	ra,8(sp)
 4a8:	e022                	sd	s0,0(sp)
 4aa:	0800                	add	s0,sp,16
  return memmove(dst, src, n);
 4ac:	f67ff0ef          	jal	412 <memmove>
}
 4b0:	60a2                	ld	ra,8(sp)
 4b2:	6402                	ld	s0,0(sp)
 4b4:	0141                	add	sp,sp,16
 4b6:	8082                	ret

00000000000004b8 <sbrk>:

char *
sbrk(int n) {
 4b8:	1141                	add	sp,sp,-16
 4ba:	e406                	sd	ra,8(sp)
 4bc:	e022                	sd	s0,0(sp)
 4be:	0800                	add	s0,sp,16
  return sys_sbrk(n, SBRK_EAGER);
 4c0:	4585                	li	a1,1
 4c2:	152000ef          	jal	614 <sys_sbrk>
}
 4c6:	60a2                	ld	ra,8(sp)
 4c8:	6402                	ld	s0,0(sp)
 4ca:	0141                	add	sp,sp,16
 4cc:	8082                	ret

00000000000004ce <sbrklazy>:

char *
sbrklazy(int n) {
 4ce:	1141                	add	sp,sp,-16
 4d0:	e406                	sd	ra,8(sp)
 4d2:	e022                	sd	s0,0(sp)
 4d4:	0800                	add	s0,sp,16
  return sys_sbrk(n, SBRK_LAZY);
 4d6:	4589                	li	a1,2
 4d8:	13c000ef          	jal	614 <sys_sbrk>
}
 4dc:	60a2                	ld	ra,8(sp)
 4de:	6402                	ld	s0,0(sp)
 4e0:	0141                	add	sp,sp,16
 4e2:	8082                	ret

00000000000004e4 <htons>:

// Byte order conversion functions
unsigned short
htons(unsigned short hostshort)
{
 4e4:	1141                	add	sp,sp,-16
 4e6:	e422                	sd	s0,8(sp)
 4e8:	0800                	add	s0,sp,16
  return ((hostshort >> 8) & 0xff) | ((hostshort & 0xff) << 8);
 4ea:	0085179b          	sllw	a5,a0,0x8
 4ee:	0085551b          	srlw	a0,a0,0x8
 4f2:	8d5d                	or	a0,a0,a5
}
 4f4:	1542                	sll	a0,a0,0x30
 4f6:	9141                	srl	a0,a0,0x30
 4f8:	6422                	ld	s0,8(sp)
 4fa:	0141                	add	sp,sp,16
 4fc:	8082                	ret

00000000000004fe <ntohs>:

unsigned short
ntohs(unsigned short netshort)
{
 4fe:	1141                	add	sp,sp,-16
 500:	e422                	sd	s0,8(sp)
 502:	0800                	add	s0,sp,16
  return ((netshort >> 8) & 0xff) | ((netshort & 0xff) << 8);
 504:	0085179b          	sllw	a5,a0,0x8
 508:	0085551b          	srlw	a0,a0,0x8
 50c:	8d5d                	or	a0,a0,a5
}
 50e:	1542                	sll	a0,a0,0x30
 510:	9141                	srl	a0,a0,0x30
 512:	6422                	ld	s0,8(sp)
 514:	0141                	add	sp,sp,16
 516:	8082                	ret

0000000000000518 <htonl>:

unsigned long
htonl(unsigned long hostlong)
{
 518:	1141                	add	sp,sp,-16
 51a:	e422                	sd	s0,8(sp)
 51c:	0800                	add	s0,sp,16
  return ((hostlong >> 24) & 0xff) |
 51e:	0185579b          	srlw	a5,a0,0x18
         ((hostlong >> 8) & 0xff00) |
 522:	00855713          	srl	a4,a0,0x8
 526:	66c1                	lui	a3,0x10
 528:	f0068693          	add	a3,a3,-256 # ff00 <base+0xeae0>
 52c:	8f75                	and	a4,a4,a3
  return ((hostlong >> 24) & 0xff) |
 52e:	8fd9                	or	a5,a5,a4
         ((hostlong & 0xff00) << 8) |
 530:	00851713          	sll	a4,a0,0x8
 534:	00ff06b7          	lui	a3,0xff0
 538:	8f75                	and	a4,a4,a3
         ((hostlong >> 8) & 0xff00) |
 53a:	8fd9                	or	a5,a5,a4
         ((hostlong & 0xff) << 24);
 53c:	0562                	sll	a0,a0,0x18
 53e:	0ff00713          	li	a4,255
 542:	0762                	sll	a4,a4,0x18
 544:	8d79                	and	a0,a0,a4
}
 546:	8d5d                	or	a0,a0,a5
 548:	6422                	ld	s0,8(sp)
 54a:	0141                	add	sp,sp,16
 54c:	8082                	ret

000000000000054e <ntohl>:

unsigned long
ntohl(unsigned long netlong)
{
 54e:	1141                	add	sp,sp,-16
 550:	e422                	sd	s0,8(sp)
 552:	0800                	add	s0,sp,16
  return ((netlong >> 24) & 0xff) |
 554:	0185579b          	srlw	a5,a0,0x18
         ((netlong >> 8) & 0xff00) |
 558:	00855713          	srl	a4,a0,0x8
 55c:	66c1                	lui	a3,0x10
 55e:	f0068693          	add	a3,a3,-256 # ff00 <base+0xeae0>
 562:	8f75                	and	a4,a4,a3
  return ((netlong >> 24) & 0xff) |
 564:	8fd9                	or	a5,a5,a4
         ((netlong & 0xff00) << 8) |
 566:	00851713          	sll	a4,a0,0x8
 56a:	00ff06b7          	lui	a3,0xff0
 56e:	8f75                	and	a4,a4,a3
         ((netlong >> 8) & 0xff00) |
 570:	8fd9                	or	a5,a5,a4
         ((netlong & 0xff) << 24);
 572:	0562                	sll	a0,a0,0x18
 574:	0ff00713          	li	a4,255
 578:	0762                	sll	a4,a4,0x18
 57a:	8d79                	and	a0,a0,a4
}
 57c:	8d5d                	or	a0,a0,a5
 57e:	6422                	ld	s0,8(sp)
 580:	0141                	add	sp,sp,16
 582:	8082                	ret

0000000000000584 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 584:	4885                	li	a7,1
 ecall
 586:	00000073          	ecall
 ret
 58a:	8082                	ret

000000000000058c <exit>:
.global exit
exit:
 li a7, SYS_exit
 58c:	4889                	li	a7,2
 ecall
 58e:	00000073          	ecall
 ret
 592:	8082                	ret

0000000000000594 <wait>:
.global wait
wait:
 li a7, SYS_wait
 594:	488d                	li	a7,3
 ecall
 596:	00000073          	ecall
 ret
 59a:	8082                	ret

000000000000059c <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 59c:	4891                	li	a7,4
 ecall
 59e:	00000073          	ecall
 ret
 5a2:	8082                	ret

00000000000005a4 <read>:
.global read
read:
 li a7, SYS_read
 5a4:	4895                	li	a7,5
 ecall
 5a6:	00000073          	ecall
 ret
 5aa:	8082                	ret

00000000000005ac <write>:
.global write
write:
 li a7, SYS_write
 5ac:	48c1                	li	a7,16
 ecall
 5ae:	00000073          	ecall
 ret
 5b2:	8082                	ret

00000000000005b4 <close>:
.global close
close:
 li a7, SYS_close
 5b4:	48d5                	li	a7,21
 ecall
 5b6:	00000073          	ecall
 ret
 5ba:	8082                	ret

00000000000005bc <kill>:
.global kill
kill:
 li a7, SYS_kill
 5bc:	4899                	li	a7,6
 ecall
 5be:	00000073          	ecall
 ret
 5c2:	8082                	ret

00000000000005c4 <exec>:
.global exec
exec:
 li a7, SYS_exec
 5c4:	489d                	li	a7,7
 ecall
 5c6:	00000073          	ecall
 ret
 5ca:	8082                	ret

00000000000005cc <open>:
.global open
open:
 li a7, SYS_open
 5cc:	48bd                	li	a7,15
 ecall
 5ce:	00000073          	ecall
 ret
 5d2:	8082                	ret

00000000000005d4 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 5d4:	48c5                	li	a7,17
 ecall
 5d6:	00000073          	ecall
 ret
 5da:	8082                	ret

00000000000005dc <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 5dc:	48c9                	li	a7,18
 ecall
 5de:	00000073          	ecall
 ret
 5e2:	8082                	ret

00000000000005e4 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 5e4:	48a1                	li	a7,8
 ecall
 5e6:	00000073          	ecall
 ret
 5ea:	8082                	ret

00000000000005ec <link>:
.global link
link:
 li a7, SYS_link
 5ec:	48cd                	li	a7,19
 ecall
 5ee:	00000073          	ecall
 ret
 5f2:	8082                	ret

00000000000005f4 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 5f4:	48d1                	li	a7,20
 ecall
 5f6:	00000073          	ecall
 ret
 5fa:	8082                	ret

00000000000005fc <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 5fc:	48a5                	li	a7,9
 ecall
 5fe:	00000073          	ecall
 ret
 602:	8082                	ret

0000000000000604 <dup>:
.global dup
dup:
 li a7, SYS_dup
 604:	48a9                	li	a7,10
 ecall
 606:	00000073          	ecall
 ret
 60a:	8082                	ret

000000000000060c <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 60c:	48ad                	li	a7,11
 ecall
 60e:	00000073          	ecall
 ret
 612:	8082                	ret

0000000000000614 <sys_sbrk>:
.global sys_sbrk
sys_sbrk:
 li a7, SYS_sbrk
 614:	48b1                	li	a7,12
 ecall
 616:	00000073          	ecall
 ret
 61a:	8082                	ret

000000000000061c <pause>:
.global pause
pause:
 li a7, SYS_pause
 61c:	48b5                	li	a7,13
 ecall
 61e:	00000073          	ecall
 ret
 622:	8082                	ret

0000000000000624 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 624:	48b9                	li	a7,14
 ecall
 626:	00000073          	ecall
 ret
 62a:	8082                	ret

000000000000062c <socket>:
.global socket
socket:
 li a7, SYS_socket
 62c:	48d9                	li	a7,22
 ecall
 62e:	00000073          	ecall
 ret
 632:	8082                	ret

0000000000000634 <bind>:
.global bind
bind:
 li a7, SYS_bind
 634:	48dd                	li	a7,23
 ecall
 636:	00000073          	ecall
 ret
 63a:	8082                	ret

000000000000063c <listen>:
.global listen
listen:
 li a7, SYS_listen
 63c:	48e1                	li	a7,24
 ecall
 63e:	00000073          	ecall
 ret
 642:	8082                	ret

0000000000000644 <accept>:
.global accept
accept:
 li a7, SYS_accept
 644:	48e5                	li	a7,25
 ecall
 646:	00000073          	ecall
 ret
 64a:	8082                	ret

000000000000064c <connect>:
.global connect
connect:
 li a7, SYS_connect
 64c:	48e9                	li	a7,26
 ecall
 64e:	00000073          	ecall
 ret
 652:	8082                	ret

0000000000000654 <send>:
.global send
send:
 li a7, SYS_send
 654:	48ed                	li	a7,27
 ecall
 656:	00000073          	ecall
 ret
 65a:	8082                	ret

000000000000065c <recv>:
.global recv
recv:
 li a7, SYS_recv
 65c:	48f1                	li	a7,28
 ecall
 65e:	00000073          	ecall
 ret
 662:	8082                	ret

0000000000000664 <sendto>:
.global sendto
sendto:
 li a7, SYS_sendto
 664:	48f5                	li	a7,29
 ecall
 666:	00000073          	ecall
 ret
 66a:	8082                	ret

000000000000066c <recvfrom>:
.global recvfrom
recvfrom:
 li a7, SYS_recvfrom
 66c:	48f9                	li	a7,30
 ecall
 66e:	00000073          	ecall
 ret
 672:	8082                	ret

0000000000000674 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 674:	1101                	add	sp,sp,-32
 676:	ec06                	sd	ra,24(sp)
 678:	e822                	sd	s0,16(sp)
 67a:	1000                	add	s0,sp,32
 67c:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 680:	4605                	li	a2,1
 682:	fef40593          	add	a1,s0,-17
 686:	f27ff0ef          	jal	5ac <write>
}
 68a:	60e2                	ld	ra,24(sp)
 68c:	6442                	ld	s0,16(sp)
 68e:	6105                	add	sp,sp,32
 690:	8082                	ret

0000000000000692 <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
 692:	715d                	add	sp,sp,-80
 694:	e486                	sd	ra,72(sp)
 696:	e0a2                	sd	s0,64(sp)
 698:	f84a                	sd	s2,48(sp)
 69a:	0880                	add	s0,sp,80
 69c:	892a                	mv	s2,a0
  char buf[20];
  int i, neg;
  unsigned long long x;

  neg = 0;
  if(sgn && xx < 0){
 69e:	c299                	beqz	a3,6a4 <printint+0x12>
 6a0:	0805c363          	bltz	a1,726 <printint+0x94>
  neg = 0;
 6a4:	4881                	li	a7,0
 6a6:	fb840693          	add	a3,s0,-72
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
 6aa:	4781                	li	a5,0
  do{
    buf[i++] = digits[x % base];
 6ac:	00000517          	auipc	a0,0x0
 6b0:	75450513          	add	a0,a0,1876 # e00 <digits>
 6b4:	883e                	mv	a6,a5
 6b6:	2785                	addw	a5,a5,1
 6b8:	02c5f733          	remu	a4,a1,a2
 6bc:	972a                	add	a4,a4,a0
 6be:	00074703          	lbu	a4,0(a4)
 6c2:	00e68023          	sb	a4,0(a3) # ff0000 <base+0xfeebe0>
  }while((x /= base) != 0);
 6c6:	872e                	mv	a4,a1
 6c8:	02c5d5b3          	divu	a1,a1,a2
 6cc:	0685                	add	a3,a3,1
 6ce:	fec773e3          	bgeu	a4,a2,6b4 <printint+0x22>
  if(neg)
 6d2:	00088b63          	beqz	a7,6e8 <printint+0x56>
    buf[i++] = '-';
 6d6:	fd078793          	add	a5,a5,-48
 6da:	97a2                	add	a5,a5,s0
 6dc:	02d00713          	li	a4,45
 6e0:	fee78423          	sb	a4,-24(a5)
 6e4:	0028079b          	addw	a5,a6,2

  while(--i >= 0)
 6e8:	02f05a63          	blez	a5,71c <printint+0x8a>
 6ec:	fc26                	sd	s1,56(sp)
 6ee:	f44e                	sd	s3,40(sp)
 6f0:	fb840713          	add	a4,s0,-72
 6f4:	00f704b3          	add	s1,a4,a5
 6f8:	fff70993          	add	s3,a4,-1
 6fc:	99be                	add	s3,s3,a5
 6fe:	37fd                	addw	a5,a5,-1
 700:	1782                	sll	a5,a5,0x20
 702:	9381                	srl	a5,a5,0x20
 704:	40f989b3          	sub	s3,s3,a5
    putc(fd, buf[i]);
 708:	fff4c583          	lbu	a1,-1(s1)
 70c:	854a                	mv	a0,s2
 70e:	f67ff0ef          	jal	674 <putc>
  while(--i >= 0)
 712:	14fd                	add	s1,s1,-1
 714:	ff349ae3          	bne	s1,s3,708 <printint+0x76>
 718:	74e2                	ld	s1,56(sp)
 71a:	79a2                	ld	s3,40(sp)
}
 71c:	60a6                	ld	ra,72(sp)
 71e:	6406                	ld	s0,64(sp)
 720:	7942                	ld	s2,48(sp)
 722:	6161                	add	sp,sp,80
 724:	8082                	ret
    x = -xx;
 726:	40b005b3          	neg	a1,a1
    neg = 1;
 72a:	4885                	li	a7,1
    x = -xx;
 72c:	bfad                	j	6a6 <printint+0x14>

000000000000072e <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %c, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 72e:	711d                	add	sp,sp,-96
 730:	ec86                	sd	ra,88(sp)
 732:	e8a2                	sd	s0,80(sp)
 734:	e0ca                	sd	s2,64(sp)
 736:	1080                	add	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 738:	0005c903          	lbu	s2,0(a1)
 73c:	28090663          	beqz	s2,9c8 <vprintf+0x29a>
 740:	e4a6                	sd	s1,72(sp)
 742:	fc4e                	sd	s3,56(sp)
 744:	f852                	sd	s4,48(sp)
 746:	f456                	sd	s5,40(sp)
 748:	f05a                	sd	s6,32(sp)
 74a:	ec5e                	sd	s7,24(sp)
 74c:	e862                	sd	s8,16(sp)
 74e:	e466                	sd	s9,8(sp)
 750:	8b2a                	mv	s6,a0
 752:	8a2e                	mv	s4,a1
 754:	8bb2                	mv	s7,a2
  state = 0;
 756:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
 758:	4481                	li	s1,0
 75a:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
 75c:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
 760:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
 764:	06c00c93          	li	s9,108
 768:	a005                	j	788 <vprintf+0x5a>
        putc(fd, c0);
 76a:	85ca                	mv	a1,s2
 76c:	855a                	mv	a0,s6
 76e:	f07ff0ef          	jal	674 <putc>
 772:	a019                	j	778 <vprintf+0x4a>
    } else if(state == '%'){
 774:	03598263          	beq	s3,s5,798 <vprintf+0x6a>
  for(i = 0; fmt[i]; i++){
 778:	2485                	addw	s1,s1,1
 77a:	8726                	mv	a4,s1
 77c:	009a07b3          	add	a5,s4,s1
 780:	0007c903          	lbu	s2,0(a5)
 784:	22090a63          	beqz	s2,9b8 <vprintf+0x28a>
    c0 = fmt[i] & 0xff;
 788:	0009079b          	sext.w	a5,s2
    if(state == 0){
 78c:	fe0994e3          	bnez	s3,774 <vprintf+0x46>
      if(c0 == '%'){
 790:	fd579de3          	bne	a5,s5,76a <vprintf+0x3c>
        state = '%';
 794:	89be                	mv	s3,a5
 796:	b7cd                	j	778 <vprintf+0x4a>
      if(c0) c1 = fmt[i+1] & 0xff;
 798:	00ea06b3          	add	a3,s4,a4
 79c:	0016c683          	lbu	a3,1(a3)
      c1 = c2 = 0;
 7a0:	8636                	mv	a2,a3
      if(c1) c2 = fmt[i+2] & 0xff;
 7a2:	c681                	beqz	a3,7aa <vprintf+0x7c>
 7a4:	9752                	add	a4,a4,s4
 7a6:	00274603          	lbu	a2,2(a4)
      if(c0 == 'd'){
 7aa:	05878363          	beq	a5,s8,7f0 <vprintf+0xc2>
      } else if(c0 == 'l' && c1 == 'd'){
 7ae:	05978d63          	beq	a5,s9,808 <vprintf+0xda>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
 7b2:	07500713          	li	a4,117
 7b6:	0ee78763          	beq	a5,a4,8a4 <vprintf+0x176>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
 7ba:	07800713          	li	a4,120
 7be:	12e78963          	beq	a5,a4,8f0 <vprintf+0x1c2>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
 7c2:	07000713          	li	a4,112
 7c6:	14e78e63          	beq	a5,a4,922 <vprintf+0x1f4>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 'c'){
 7ca:	06300713          	li	a4,99
 7ce:	18e78e63          	beq	a5,a4,96a <vprintf+0x23c>
        putc(fd, va_arg(ap, uint32));
      } else if(c0 == 's'){
 7d2:	07300713          	li	a4,115
 7d6:	1ae78463          	beq	a5,a4,97e <vprintf+0x250>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
 7da:	02500713          	li	a4,37
 7de:	04e79563          	bne	a5,a4,828 <vprintf+0xfa>
        putc(fd, '%');
 7e2:	02500593          	li	a1,37
 7e6:	855a                	mv	a0,s6
 7e8:	e8dff0ef          	jal	674 <putc>
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c0);
      }

      state = 0;
 7ec:	4981                	li	s3,0
 7ee:	b769                	j	778 <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 1);
 7f0:	008b8913          	add	s2,s7,8
 7f4:	4685                	li	a3,1
 7f6:	4629                	li	a2,10
 7f8:	000ba583          	lw	a1,0(s7)
 7fc:	855a                	mv	a0,s6
 7fe:	e95ff0ef          	jal	692 <printint>
 802:	8bca                	mv	s7,s2
      state = 0;
 804:	4981                	li	s3,0
 806:	bf8d                	j	778 <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'd'){
 808:	06400793          	li	a5,100
 80c:	02f68963          	beq	a3,a5,83e <vprintf+0x110>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 810:	06c00793          	li	a5,108
 814:	04f68263          	beq	a3,a5,858 <vprintf+0x12a>
      } else if(c0 == 'l' && c1 == 'u'){
 818:	07500793          	li	a5,117
 81c:	0af68063          	beq	a3,a5,8bc <vprintf+0x18e>
      } else if(c0 == 'l' && c1 == 'x'){
 820:	07800793          	li	a5,120
 824:	0ef68263          	beq	a3,a5,908 <vprintf+0x1da>
        putc(fd, '%');
 828:	02500593          	li	a1,37
 82c:	855a                	mv	a0,s6
 82e:	e47ff0ef          	jal	674 <putc>
        putc(fd, c0);
 832:	85ca                	mv	a1,s2
 834:	855a                	mv	a0,s6
 836:	e3fff0ef          	jal	674 <putc>
      state = 0;
 83a:	4981                	li	s3,0
 83c:	bf35                	j	778 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 83e:	008b8913          	add	s2,s7,8
 842:	4685                	li	a3,1
 844:	4629                	li	a2,10
 846:	000bb583          	ld	a1,0(s7)
 84a:	855a                	mv	a0,s6
 84c:	e47ff0ef          	jal	692 <printint>
        i += 1;
 850:	2485                	addw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 852:	8bca                	mv	s7,s2
      state = 0;
 854:	4981                	li	s3,0
        i += 1;
 856:	b70d                	j	778 <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 858:	06400793          	li	a5,100
 85c:	02f60763          	beq	a2,a5,88a <vprintf+0x15c>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 860:	07500793          	li	a5,117
 864:	06f60963          	beq	a2,a5,8d6 <vprintf+0x1a8>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 868:	07800793          	li	a5,120
 86c:	faf61ee3          	bne	a2,a5,828 <vprintf+0xfa>
        printint(fd, va_arg(ap, uint64), 16, 0);
 870:	008b8913          	add	s2,s7,8
 874:	4681                	li	a3,0
 876:	4641                	li	a2,16
 878:	000bb583          	ld	a1,0(s7)
 87c:	855a                	mv	a0,s6
 87e:	e15ff0ef          	jal	692 <printint>
        i += 2;
 882:	2489                	addw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 884:	8bca                	mv	s7,s2
      state = 0;
 886:	4981                	li	s3,0
        i += 2;
 888:	bdc5                	j	778 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 88a:	008b8913          	add	s2,s7,8
 88e:	4685                	li	a3,1
 890:	4629                	li	a2,10
 892:	000bb583          	ld	a1,0(s7)
 896:	855a                	mv	a0,s6
 898:	dfbff0ef          	jal	692 <printint>
        i += 2;
 89c:	2489                	addw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 89e:	8bca                	mv	s7,s2
      state = 0;
 8a0:	4981                	li	s3,0
        i += 2;
 8a2:	bdd9                	j	778 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint32), 10, 0);
 8a4:	008b8913          	add	s2,s7,8
 8a8:	4681                	li	a3,0
 8aa:	4629                	li	a2,10
 8ac:	000be583          	lwu	a1,0(s7)
 8b0:	855a                	mv	a0,s6
 8b2:	de1ff0ef          	jal	692 <printint>
 8b6:	8bca                	mv	s7,s2
      state = 0;
 8b8:	4981                	li	s3,0
 8ba:	bd7d                	j	778 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 8bc:	008b8913          	add	s2,s7,8
 8c0:	4681                	li	a3,0
 8c2:	4629                	li	a2,10
 8c4:	000bb583          	ld	a1,0(s7)
 8c8:	855a                	mv	a0,s6
 8ca:	dc9ff0ef          	jal	692 <printint>
        i += 1;
 8ce:	2485                	addw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 8d0:	8bca                	mv	s7,s2
      state = 0;
 8d2:	4981                	li	s3,0
        i += 1;
 8d4:	b555                	j	778 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 8d6:	008b8913          	add	s2,s7,8
 8da:	4681                	li	a3,0
 8dc:	4629                	li	a2,10
 8de:	000bb583          	ld	a1,0(s7)
 8e2:	855a                	mv	a0,s6
 8e4:	dafff0ef          	jal	692 <printint>
        i += 2;
 8e8:	2489                	addw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 8ea:	8bca                	mv	s7,s2
      state = 0;
 8ec:	4981                	li	s3,0
        i += 2;
 8ee:	b569                	j	778 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint32), 16, 0);
 8f0:	008b8913          	add	s2,s7,8
 8f4:	4681                	li	a3,0
 8f6:	4641                	li	a2,16
 8f8:	000be583          	lwu	a1,0(s7)
 8fc:	855a                	mv	a0,s6
 8fe:	d95ff0ef          	jal	692 <printint>
 902:	8bca                	mv	s7,s2
      state = 0;
 904:	4981                	li	s3,0
 906:	bd8d                	j	778 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 16, 0);
 908:	008b8913          	add	s2,s7,8
 90c:	4681                	li	a3,0
 90e:	4641                	li	a2,16
 910:	000bb583          	ld	a1,0(s7)
 914:	855a                	mv	a0,s6
 916:	d7dff0ef          	jal	692 <printint>
        i += 1;
 91a:	2485                	addw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 91c:	8bca                	mv	s7,s2
      state = 0;
 91e:	4981                	li	s3,0
        i += 1;
 920:	bda1                	j	778 <vprintf+0x4a>
 922:	e06a                	sd	s10,0(sp)
        printptr(fd, va_arg(ap, uint64));
 924:	008b8d13          	add	s10,s7,8
 928:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 92c:	03000593          	li	a1,48
 930:	855a                	mv	a0,s6
 932:	d43ff0ef          	jal	674 <putc>
  putc(fd, 'x');
 936:	07800593          	li	a1,120
 93a:	855a                	mv	a0,s6
 93c:	d39ff0ef          	jal	674 <putc>
 940:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 942:	00000b97          	auipc	s7,0x0
 946:	4beb8b93          	add	s7,s7,1214 # e00 <digits>
 94a:	03c9d793          	srl	a5,s3,0x3c
 94e:	97de                	add	a5,a5,s7
 950:	0007c583          	lbu	a1,0(a5)
 954:	855a                	mv	a0,s6
 956:	d1fff0ef          	jal	674 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 95a:	0992                	sll	s3,s3,0x4
 95c:	397d                	addw	s2,s2,-1
 95e:	fe0916e3          	bnez	s2,94a <vprintf+0x21c>
        printptr(fd, va_arg(ap, uint64));
 962:	8bea                	mv	s7,s10
      state = 0;
 964:	4981                	li	s3,0
 966:	6d02                	ld	s10,0(sp)
 968:	bd01                	j	778 <vprintf+0x4a>
        putc(fd, va_arg(ap, uint32));
 96a:	008b8913          	add	s2,s7,8
 96e:	000bc583          	lbu	a1,0(s7)
 972:	855a                	mv	a0,s6
 974:	d01ff0ef          	jal	674 <putc>
 978:	8bca                	mv	s7,s2
      state = 0;
 97a:	4981                	li	s3,0
 97c:	bbf5                	j	778 <vprintf+0x4a>
        if((s = va_arg(ap, char*)) == 0)
 97e:	008b8993          	add	s3,s7,8
 982:	000bb903          	ld	s2,0(s7)
 986:	00090f63          	beqz	s2,9a4 <vprintf+0x276>
        for(; *s; s++)
 98a:	00094583          	lbu	a1,0(s2)
 98e:	c195                	beqz	a1,9b2 <vprintf+0x284>
          putc(fd, *s);
 990:	855a                	mv	a0,s6
 992:	ce3ff0ef          	jal	674 <putc>
        for(; *s; s++)
 996:	0905                	add	s2,s2,1
 998:	00094583          	lbu	a1,0(s2)
 99c:	f9f5                	bnez	a1,990 <vprintf+0x262>
        if((s = va_arg(ap, char*)) == 0)
 99e:	8bce                	mv	s7,s3
      state = 0;
 9a0:	4981                	li	s3,0
 9a2:	bbd9                	j	778 <vprintf+0x4a>
          s = "(null)";
 9a4:	00000917          	auipc	s2,0x0
 9a8:	45490913          	add	s2,s2,1108 # df8 <malloc+0x348>
        for(; *s; s++)
 9ac:	02800593          	li	a1,40
 9b0:	b7c5                	j	990 <vprintf+0x262>
        if((s = va_arg(ap, char*)) == 0)
 9b2:	8bce                	mv	s7,s3
      state = 0;
 9b4:	4981                	li	s3,0
 9b6:	b3c9                	j	778 <vprintf+0x4a>
 9b8:	64a6                	ld	s1,72(sp)
 9ba:	79e2                	ld	s3,56(sp)
 9bc:	7a42                	ld	s4,48(sp)
 9be:	7aa2                	ld	s5,40(sp)
 9c0:	7b02                	ld	s6,32(sp)
 9c2:	6be2                	ld	s7,24(sp)
 9c4:	6c42                	ld	s8,16(sp)
 9c6:	6ca2                	ld	s9,8(sp)
    }
  }
}
 9c8:	60e6                	ld	ra,88(sp)
 9ca:	6446                	ld	s0,80(sp)
 9cc:	6906                	ld	s2,64(sp)
 9ce:	6125                	add	sp,sp,96
 9d0:	8082                	ret

00000000000009d2 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 9d2:	715d                	add	sp,sp,-80
 9d4:	ec06                	sd	ra,24(sp)
 9d6:	e822                	sd	s0,16(sp)
 9d8:	1000                	add	s0,sp,32
 9da:	e010                	sd	a2,0(s0)
 9dc:	e414                	sd	a3,8(s0)
 9de:	e818                	sd	a4,16(s0)
 9e0:	ec1c                	sd	a5,24(s0)
 9e2:	03043023          	sd	a6,32(s0)
 9e6:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 9ea:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 9ee:	8622                	mv	a2,s0
 9f0:	d3fff0ef          	jal	72e <vprintf>
}
 9f4:	60e2                	ld	ra,24(sp)
 9f6:	6442                	ld	s0,16(sp)
 9f8:	6161                	add	sp,sp,80
 9fa:	8082                	ret

00000000000009fc <printf>:

void
printf(const char *fmt, ...)
{
 9fc:	711d                	add	sp,sp,-96
 9fe:	ec06                	sd	ra,24(sp)
 a00:	e822                	sd	s0,16(sp)
 a02:	1000                	add	s0,sp,32
 a04:	e40c                	sd	a1,8(s0)
 a06:	e810                	sd	a2,16(s0)
 a08:	ec14                	sd	a3,24(s0)
 a0a:	f018                	sd	a4,32(s0)
 a0c:	f41c                	sd	a5,40(s0)
 a0e:	03043823          	sd	a6,48(s0)
 a12:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 a16:	00840613          	add	a2,s0,8
 a1a:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 a1e:	85aa                	mv	a1,a0
 a20:	4505                	li	a0,1
 a22:	d0dff0ef          	jal	72e <vprintf>
}
 a26:	60e2                	ld	ra,24(sp)
 a28:	6442                	ld	s0,16(sp)
 a2a:	6125                	add	sp,sp,96
 a2c:	8082                	ret

0000000000000a2e <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 a2e:	1141                	add	sp,sp,-16
 a30:	e422                	sd	s0,8(sp)
 a32:	0800                	add	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 a34:	ff050693          	add	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 a38:	00000797          	auipc	a5,0x0
 a3c:	5d87b783          	ld	a5,1496(a5) # 1010 <freep>
 a40:	a02d                	j	a6a <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 a42:	4618                	lw	a4,8(a2)
 a44:	9f2d                	addw	a4,a4,a1
 a46:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 a4a:	6398                	ld	a4,0(a5)
 a4c:	6310                	ld	a2,0(a4)
 a4e:	a83d                	j	a8c <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 a50:	ff852703          	lw	a4,-8(a0)
 a54:	9f31                	addw	a4,a4,a2
 a56:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 a58:	ff053683          	ld	a3,-16(a0)
 a5c:	a091                	j	aa0 <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 a5e:	6398                	ld	a4,0(a5)
 a60:	00e7e463          	bltu	a5,a4,a68 <free+0x3a>
 a64:	00e6ea63          	bltu	a3,a4,a78 <free+0x4a>
{
 a68:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 a6a:	fed7fae3          	bgeu	a5,a3,a5e <free+0x30>
 a6e:	6398                	ld	a4,0(a5)
 a70:	00e6e463          	bltu	a3,a4,a78 <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 a74:	fee7eae3          	bltu	a5,a4,a68 <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 a78:	ff852583          	lw	a1,-8(a0)
 a7c:	6390                	ld	a2,0(a5)
 a7e:	02059813          	sll	a6,a1,0x20
 a82:	01c85713          	srl	a4,a6,0x1c
 a86:	9736                	add	a4,a4,a3
 a88:	fae60de3          	beq	a2,a4,a42 <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 a8c:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 a90:	4790                	lw	a2,8(a5)
 a92:	02061593          	sll	a1,a2,0x20
 a96:	01c5d713          	srl	a4,a1,0x1c
 a9a:	973e                	add	a4,a4,a5
 a9c:	fae68ae3          	beq	a3,a4,a50 <free+0x22>
    p->s.ptr = bp->s.ptr;
 aa0:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 aa2:	00000717          	auipc	a4,0x0
 aa6:	56f73723          	sd	a5,1390(a4) # 1010 <freep>
}
 aaa:	6422                	ld	s0,8(sp)
 aac:	0141                	add	sp,sp,16
 aae:	8082                	ret

0000000000000ab0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 ab0:	7139                	add	sp,sp,-64
 ab2:	fc06                	sd	ra,56(sp)
 ab4:	f822                	sd	s0,48(sp)
 ab6:	f426                	sd	s1,40(sp)
 ab8:	ec4e                	sd	s3,24(sp)
 aba:	0080                	add	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 abc:	02051493          	sll	s1,a0,0x20
 ac0:	9081                	srl	s1,s1,0x20
 ac2:	04bd                	add	s1,s1,15
 ac4:	8091                	srl	s1,s1,0x4
 ac6:	0014899b          	addw	s3,s1,1
 aca:	0485                	add	s1,s1,1
  if((prevp = freep) == 0){
 acc:	00000517          	auipc	a0,0x0
 ad0:	54453503          	ld	a0,1348(a0) # 1010 <freep>
 ad4:	c915                	beqz	a0,b08 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 ad6:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 ad8:	4798                	lw	a4,8(a5)
 ada:	08977a63          	bgeu	a4,s1,b6e <malloc+0xbe>
 ade:	f04a                	sd	s2,32(sp)
 ae0:	e852                	sd	s4,16(sp)
 ae2:	e456                	sd	s5,8(sp)
 ae4:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 ae6:	8a4e                	mv	s4,s3
 ae8:	0009871b          	sext.w	a4,s3
 aec:	6685                	lui	a3,0x1
 aee:	00d77363          	bgeu	a4,a3,af4 <malloc+0x44>
 af2:	6a05                	lui	s4,0x1
 af4:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 af8:	004a1a1b          	sllw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 afc:	00000917          	auipc	s2,0x0
 b00:	51490913          	add	s2,s2,1300 # 1010 <freep>
  if(p == SBRK_ERROR)
 b04:	5afd                	li	s5,-1
 b06:	a081                	j	b46 <malloc+0x96>
 b08:	f04a                	sd	s2,32(sp)
 b0a:	e852                	sd	s4,16(sp)
 b0c:	e456                	sd	s5,8(sp)
 b0e:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 b10:	00001797          	auipc	a5,0x1
 b14:	91078793          	add	a5,a5,-1776 # 1420 <base>
 b18:	00000717          	auipc	a4,0x0
 b1c:	4ef73c23          	sd	a5,1272(a4) # 1010 <freep>
 b20:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 b22:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 b26:	b7c1                	j	ae6 <malloc+0x36>
        prevp->s.ptr = p->s.ptr;
 b28:	6398                	ld	a4,0(a5)
 b2a:	e118                	sd	a4,0(a0)
 b2c:	a8a9                	j	b86 <malloc+0xd6>
  hp->s.size = nu;
 b2e:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 b32:	0541                	add	a0,a0,16
 b34:	efbff0ef          	jal	a2e <free>
  return freep;
 b38:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 b3c:	c12d                	beqz	a0,b9e <malloc+0xee>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 b3e:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 b40:	4798                	lw	a4,8(a5)
 b42:	02977263          	bgeu	a4,s1,b66 <malloc+0xb6>
    if(p == freep)
 b46:	00093703          	ld	a4,0(s2)
 b4a:	853e                	mv	a0,a5
 b4c:	fef719e3          	bne	a4,a5,b3e <malloc+0x8e>
  p = sbrk(nu * sizeof(Header));
 b50:	8552                	mv	a0,s4
 b52:	967ff0ef          	jal	4b8 <sbrk>
  if(p == SBRK_ERROR)
 b56:	fd551ce3          	bne	a0,s5,b2e <malloc+0x7e>
        return 0;
 b5a:	4501                	li	a0,0
 b5c:	7902                	ld	s2,32(sp)
 b5e:	6a42                	ld	s4,16(sp)
 b60:	6aa2                	ld	s5,8(sp)
 b62:	6b02                	ld	s6,0(sp)
 b64:	a03d                	j	b92 <malloc+0xe2>
 b66:	7902                	ld	s2,32(sp)
 b68:	6a42                	ld	s4,16(sp)
 b6a:	6aa2                	ld	s5,8(sp)
 b6c:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 b6e:	fae48de3          	beq	s1,a4,b28 <malloc+0x78>
        p->s.size -= nunits;
 b72:	4137073b          	subw	a4,a4,s3
 b76:	c798                	sw	a4,8(a5)
        p += p->s.size;
 b78:	02071693          	sll	a3,a4,0x20
 b7c:	01c6d713          	srl	a4,a3,0x1c
 b80:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 b82:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 b86:	00000717          	auipc	a4,0x0
 b8a:	48a73523          	sd	a0,1162(a4) # 1010 <freep>
      return (void*)(p + 1);
 b8e:	01078513          	add	a0,a5,16
  }
}
 b92:	70e2                	ld	ra,56(sp)
 b94:	7442                	ld	s0,48(sp)
 b96:	74a2                	ld	s1,40(sp)
 b98:	69e2                	ld	s3,24(sp)
 b9a:	6121                	add	sp,sp,64
 b9c:	8082                	ret
 b9e:	7902                	ld	s2,32(sp)
 ba0:	6a42                	ld	s4,16(sp)
 ba2:	6aa2                	ld	s5,8(sp)
 ba4:	6b02                	ld	s6,0(sp)
 ba6:	b7f5                	j	b92 <malloc+0xe2>
