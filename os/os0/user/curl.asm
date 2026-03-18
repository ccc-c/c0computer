
user/_curl:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
char recvbuf[4096];
char request[1024];

int
main(int argc, char *argv[])
{
   0:	7139                	add	sp,sp,-64
   2:	fc06                	sd	ra,56(sp)
   4:	f822                	sd	s0,48(sp)
   6:	0080                	add	s0,sp,64
    char *url;
    int port = 80;
    int ret;
    uint32_t server_ip;
    
    if (argc < 2) {
   8:	4785                	li	a5,1
   a:	14a7d763          	bge	a5,a0,158 <main+0x158>
   e:	f426                	sd	s1,40(sp)
  10:	f04a                	sd	s2,32(sp)
  12:	ec4e                	sd	s3,24(sp)
  14:	e852                	sd	s4,16(sp)
        printf("Example: curl http://example.com\n");
        printf("        curl http://10.0.2.2/\n");
        exit(1);
    }
    
    url = argv[1];
  16:	0085b983          	ld	s3,8(a1)
    if (strncmp(url, "http://", 7) == 0) {
  1a:	461d                	li	a2,7
  1c:	00001597          	auipc	a1,0x1
  20:	c2c58593          	add	a1,a1,-980 # c48 <malloc+0x16e>
  24:	854e                	mv	a0,s3
  26:	21a000ef          	jal	240 <strncmp>
  2a:	e111                	bnez	a0,2e <main+0x2e>
        url += 7;
  2c:	099d                	add	s3,s3,7
    }
    
    host = url;
    path = strchr(host, '/');
  2e:	02f00593          	li	a1,47
  32:	854e                	mv	a0,s3
  34:	2f2000ef          	jal	326 <strchr>
    if (path) {
  38:	14050963          	beqz	a0,18a <main+0x18a>
        *path = '\0';
  3c:	00050023          	sb	zero,0(a0)
        path++;
  40:	00150493          	add	s1,a0,1
    } else {
        path = "";
    }
    
    char *port_str = strchr(host, ':');
  44:	03a00593          	li	a1,58
  48:	854e                	mv	a0,s3
  4a:	2dc000ef          	jal	326 <strchr>
    int port = 80;
  4e:	05000a13          	li	s4,80
    if (port_str) {
  52:	c519                	beqz	a0,60 <main+0x60>
        *port_str = '\0';
  54:	00050023          	sb	zero,0(a0)
        port_str++;
        port = atoi(port_str);
  58:	0505                	add	a0,a0,1
  5a:	39a000ef          	jal	3f4 <atoi>
  5e:	8a2a                	mv	s4,a0
    }
    
    server_ip = 0x0100007F;
    
    printf("Connecting to %s:%d...\n", host, port);
  60:	8652                	mv	a2,s4
  62:	85ce                	mv	a1,s3
  64:	00001517          	auipc	a0,0x1
  68:	bec50513          	add	a0,a0,-1044 # c50 <malloc+0x176>
  6c:	1bb000ef          	jal	a26 <printf>
    
    sock = socket(PF_INET, SOCK_STREAM, IPPROTO_TCP);
  70:	4601                	li	a2,0
  72:	4589                	li	a1,2
  74:	4505                	li	a0,1
  76:	5e0000ef          	jal	656 <socket>
  7a:	892a                	mv	s2,a0
    if (sock < 0) {
  7c:	10054c63          	bltz	a0,194 <main+0x194>
        printf("curl: socket failed\n");
        exit(1);
    }
    
    server_addr.sin_family = AF_INET;
  80:	4785                	li	a5,1
  82:	fcf41423          	sh	a5,-56(s0)
    server_addr.sin_addr.s_addr = htonl(server_ip);
  86:	01000537          	lui	a0,0x1000
  8a:	07f50513          	add	a0,a0,127 # 100007f <base+0xffdc6f>
  8e:	4b4000ef          	jal	542 <htonl>
  92:	fca42623          	sw	a0,-52(s0)
    server_addr.sin_port = htons(port);
  96:	030a1513          	sll	a0,s4,0x30
  9a:	9141                	srl	a0,a0,0x30
  9c:	472000ef          	jal	50e <htons>
  a0:	fca41523          	sh	a0,-54(s0)
    
    if (connect(sock, (struct sockaddr *)&server_addr, sizeof(server_addr)) < 0) {
  a4:	4621                	li	a2,8
  a6:	fc840593          	add	a1,s0,-56
  aa:	854a                	mv	a0,s2
  ac:	5ca000ef          	jal	676 <connect>
  b0:	0e054b63          	bltz	a0,1a6 <main+0x1a6>
        printf("curl: connect failed\n");
        close(sock);
        exit(1);
    }
    
    strcpy(request, "GET /");
  b4:	00001a17          	auipc	s4,0x1
  b8:	f5ca0a13          	add	s4,s4,-164 # 1010 <request>
  bc:	00001597          	auipc	a1,0x1
  c0:	bdc58593          	add	a1,a1,-1060 # c98 <malloc+0x1be>
  c4:	8552                	mv	a0,s4
  c6:	132000ef          	jal	1f8 <strcpy>
    strcat(request, path);
  ca:	85a6                	mv	a1,s1
  cc:	8552                	mv	a0,s4
  ce:	1a8000ef          	jal	276 <strcat>
    strcat(request, " HTTP/1.0\r\n");
  d2:	00001597          	auipc	a1,0x1
  d6:	bce58593          	add	a1,a1,-1074 # ca0 <malloc+0x1c6>
  da:	8552                	mv	a0,s4
  dc:	19a000ef          	jal	276 <strcat>
    strcat(request, "Host: ");
  e0:	00001597          	auipc	a1,0x1
  e4:	bd058593          	add	a1,a1,-1072 # cb0 <malloc+0x1d6>
  e8:	8552                	mv	a0,s4
  ea:	18c000ef          	jal	276 <strcat>
    strcat(request, host);
  ee:	85ce                	mv	a1,s3
  f0:	8552                	mv	a0,s4
  f2:	184000ef          	jal	276 <strcat>
    strcat(request, "\r\n");
  f6:	00001597          	auipc	a1,0x1
  fa:	bda58593          	add	a1,a1,-1062 # cd0 <malloc+0x1f6>
  fe:	8552                	mv	a0,s4
 100:	176000ef          	jal	276 <strcat>
    strcat(request, "User-Agent: xv6-curl/1.0\r\n");
 104:	00001597          	auipc	a1,0x1
 108:	bb458593          	add	a1,a1,-1100 # cb8 <malloc+0x1de>
 10c:	8552                	mv	a0,s4
 10e:	168000ef          	jal	276 <strcat>
    strcat(request, "Connection: close\r\n");
 112:	00001597          	auipc	a1,0x1
 116:	bc658593          	add	a1,a1,-1082 # cd8 <malloc+0x1fe>
 11a:	8552                	mv	a0,s4
 11c:	15a000ef          	jal	276 <strcat>
    strcat(request, "\r\n");
 120:	00001597          	auipc	a1,0x1
 124:	bb058593          	add	a1,a1,-1104 # cd0 <malloc+0x1f6>
 128:	8552                	mv	a0,s4
 12a:	14c000ef          	jal	276 <strcat>
    
    send(sock, request, strlen(request), 0);
 12e:	8552                	mv	a0,s4
 130:	1aa000ef          	jal	2da <strlen>
 134:	4681                	li	a3,0
 136:	0005061b          	sext.w	a2,a0
 13a:	85d2                	mv	a1,s4
 13c:	854a                	mv	a0,s2
 13e:	540000ef          	jal	67e <send>
    
    while ((ret = recv(sock, recvbuf, sizeof(recvbuf) - 1, 0)) > 0) {
 142:	6985                	lui	s3,0x1
 144:	19fd                	add	s3,s3,-1 # fff <digits+0x2ff>
 146:	00001497          	auipc	s1,0x1
 14a:	2ca48493          	add	s1,s1,714 # 1410 <recvbuf>
        recvbuf[ret] = '\0';
        printf("%s", recvbuf);
 14e:	00001a17          	auipc	s4,0x1
 152:	ba2a0a13          	add	s4,s4,-1118 # cf0 <malloc+0x216>
    while ((ret = recv(sock, recvbuf, sizeof(recvbuf) - 1, 0)) > 0) {
 156:	a89d                	j	1cc <main+0x1cc>
 158:	f426                	sd	s1,40(sp)
 15a:	f04a                	sd	s2,32(sp)
 15c:	ec4e                	sd	s3,24(sp)
 15e:	e852                	sd	s4,16(sp)
        printf("Usage: curl <URL>\n");
 160:	00001517          	auipc	a0,0x1
 164:	a8850513          	add	a0,a0,-1400 # be8 <malloc+0x10e>
 168:	0bf000ef          	jal	a26 <printf>
        printf("Example: curl http://example.com\n");
 16c:	00001517          	auipc	a0,0x1
 170:	a9450513          	add	a0,a0,-1388 # c00 <malloc+0x126>
 174:	0b3000ef          	jal	a26 <printf>
        printf("        curl http://10.0.2.2/\n");
 178:	00001517          	auipc	a0,0x1
 17c:	ab050513          	add	a0,a0,-1360 # c28 <malloc+0x14e>
 180:	0a7000ef          	jal	a26 <printf>
        exit(1);
 184:	4505                	li	a0,1
 186:	430000ef          	jal	5b6 <exit>
        path = "";
 18a:	00001497          	auipc	s1,0x1
 18e:	a5648493          	add	s1,s1,-1450 # be0 <malloc+0x106>
 192:	bd4d                	j	44 <main+0x44>
        printf("curl: socket failed\n");
 194:	00001517          	auipc	a0,0x1
 198:	ad450513          	add	a0,a0,-1324 # c68 <malloc+0x18e>
 19c:	08b000ef          	jal	a26 <printf>
        exit(1);
 1a0:	4505                	li	a0,1
 1a2:	414000ef          	jal	5b6 <exit>
        printf("curl: connect failed\n");
 1a6:	00001517          	auipc	a0,0x1
 1aa:	ada50513          	add	a0,a0,-1318 # c80 <malloc+0x1a6>
 1ae:	079000ef          	jal	a26 <printf>
        close(sock);
 1b2:	854a                	mv	a0,s2
 1b4:	42a000ef          	jal	5de <close>
        exit(1);
 1b8:	4505                	li	a0,1
 1ba:	3fc000ef          	jal	5b6 <exit>
        recvbuf[ret] = '\0';
 1be:	9526                	add	a0,a0,s1
 1c0:	00050023          	sb	zero,0(a0)
        printf("%s", recvbuf);
 1c4:	85a6                	mv	a1,s1
 1c6:	8552                	mv	a0,s4
 1c8:	05f000ef          	jal	a26 <printf>
    while ((ret = recv(sock, recvbuf, sizeof(recvbuf) - 1, 0)) > 0) {
 1cc:	4681                	li	a3,0
 1ce:	864e                	mv	a2,s3
 1d0:	85a6                	mv	a1,s1
 1d2:	854a                	mv	a0,s2
 1d4:	4b2000ef          	jal	686 <recv>
 1d8:	fea043e3          	bgtz	a0,1be <main+0x1be>
    }
    
    close(sock);
 1dc:	854a                	mv	a0,s2
 1de:	400000ef          	jal	5de <close>
    exit(0);
 1e2:	4501                	li	a0,0
 1e4:	3d2000ef          	jal	5b6 <exit>

00000000000001e8 <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start(int argc, char **argv)
{
 1e8:	1141                	add	sp,sp,-16
 1ea:	e406                	sd	ra,8(sp)
 1ec:	e022                	sd	s0,0(sp)
 1ee:	0800                	add	s0,sp,16
  int r;
  extern int main(int argc, char **argv);
  r = main(argc, argv);
 1f0:	e11ff0ef          	jal	0 <main>
  exit(r);
 1f4:	3c2000ef          	jal	5b6 <exit>

00000000000001f8 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
 1f8:	1141                	add	sp,sp,-16
 1fa:	e422                	sd	s0,8(sp)
 1fc:	0800                	add	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 1fe:	87aa                	mv	a5,a0
 200:	0585                	add	a1,a1,1
 202:	0785                	add	a5,a5,1
 204:	fff5c703          	lbu	a4,-1(a1)
 208:	fee78fa3          	sb	a4,-1(a5)
 20c:	fb75                	bnez	a4,200 <strcpy+0x8>
    ;
  return os;
}
 20e:	6422                	ld	s0,8(sp)
 210:	0141                	add	sp,sp,16
 212:	8082                	ret

0000000000000214 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 214:	1141                	add	sp,sp,-16
 216:	e422                	sd	s0,8(sp)
 218:	0800                	add	s0,sp,16
  while(*p && *p == *q)
 21a:	00054783          	lbu	a5,0(a0)
 21e:	cb91                	beqz	a5,232 <strcmp+0x1e>
 220:	0005c703          	lbu	a4,0(a1)
 224:	00f71763          	bne	a4,a5,232 <strcmp+0x1e>
    p++, q++;
 228:	0505                	add	a0,a0,1
 22a:	0585                	add	a1,a1,1
  while(*p && *p == *q)
 22c:	00054783          	lbu	a5,0(a0)
 230:	fbe5                	bnez	a5,220 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 232:	0005c503          	lbu	a0,0(a1)
}
 236:	40a7853b          	subw	a0,a5,a0
 23a:	6422                	ld	s0,8(sp)
 23c:	0141                	add	sp,sp,16
 23e:	8082                	ret

0000000000000240 <strncmp>:

int
strncmp(const char *p, const char *q, uint n)
{
 240:	1141                	add	sp,sp,-16
 242:	e422                	sd	s0,8(sp)
 244:	0800                	add	s0,sp,16
  while(n > 0 && *p && *p == *q) {
 246:	ce11                	beqz	a2,262 <strncmp+0x22>
 248:	00054783          	lbu	a5,0(a0)
 24c:	cf89                	beqz	a5,266 <strncmp+0x26>
 24e:	0005c703          	lbu	a4,0(a1)
 252:	00f71a63          	bne	a4,a5,266 <strncmp+0x26>
    p++, q++, n--;
 256:	0505                	add	a0,a0,1
 258:	0585                	add	a1,a1,1
 25a:	367d                	addw	a2,a2,-1
  while(n > 0 && *p && *p == *q) {
 25c:	f675                	bnez	a2,248 <strncmp+0x8>
  }
  if (n == 0)
    return 0;
 25e:	4501                	li	a0,0
 260:	a801                	j	270 <strncmp+0x30>
 262:	4501                	li	a0,0
 264:	a031                	j	270 <strncmp+0x30>
  return (uchar)*p - (uchar)*q;
 266:	00054503          	lbu	a0,0(a0)
 26a:	0005c783          	lbu	a5,0(a1)
 26e:	9d1d                	subw	a0,a0,a5
}
 270:	6422                	ld	s0,8(sp)
 272:	0141                	add	sp,sp,16
 274:	8082                	ret

0000000000000276 <strcat>:

char*
strcat(char *dst, const char *src)
{
 276:	1141                	add	sp,sp,-16
 278:	e422                	sd	s0,8(sp)
 27a:	0800                	add	s0,sp,16
  char *p = dst;
  while(*p) p++;
 27c:	00054783          	lbu	a5,0(a0)
 280:	c385                	beqz	a5,2a0 <strcat+0x2a>
  char *p = dst;
 282:	87aa                	mv	a5,a0
  while(*p) p++;
 284:	0785                	add	a5,a5,1
 286:	0007c703          	lbu	a4,0(a5)
 28a:	ff6d                	bnez	a4,284 <strcat+0xe>
  while((*p++ = *src++) != 0);
 28c:	0585                	add	a1,a1,1
 28e:	0785                	add	a5,a5,1
 290:	fff5c703          	lbu	a4,-1(a1)
 294:	fee78fa3          	sb	a4,-1(a5)
 298:	fb75                	bnez	a4,28c <strcat+0x16>
  return dst;
}
 29a:	6422                	ld	s0,8(sp)
 29c:	0141                	add	sp,sp,16
 29e:	8082                	ret
  char *p = dst;
 2a0:	87aa                	mv	a5,a0
 2a2:	b7ed                	j	28c <strcat+0x16>

00000000000002a4 <strncpy>:

char*
strncpy(char *dst, const char *src, int n)
{
 2a4:	1141                	add	sp,sp,-16
 2a6:	e422                	sd	s0,8(sp)
 2a8:	0800                	add	s0,sp,16
  char *p = dst;
 2aa:	87aa                	mv	a5,a0
  while(n > 0 && *src) {
 2ac:	02c05463          	blez	a2,2d4 <strncpy+0x30>
 2b0:	0005c703          	lbu	a4,0(a1)
 2b4:	cb01                	beqz	a4,2c4 <strncpy+0x20>
    *p++ = *src++;
 2b6:	0585                	add	a1,a1,1
 2b8:	0785                	add	a5,a5,1
 2ba:	fee78fa3          	sb	a4,-1(a5)
    n--;
 2be:	367d                	addw	a2,a2,-1
  while(n > 0 && *src) {
 2c0:	fa65                	bnez	a2,2b0 <strncpy+0xc>
 2c2:	a809                	j	2d4 <strncpy+0x30>
  }
  while(n > 0) {
 2c4:	1602                	sll	a2,a2,0x20
 2c6:	9201                	srl	a2,a2,0x20
 2c8:	963e                	add	a2,a2,a5
    *p++ = 0;
 2ca:	0785                	add	a5,a5,1
 2cc:	fe078fa3          	sb	zero,-1(a5)
  while(n > 0) {
 2d0:	fec79de3          	bne	a5,a2,2ca <strncpy+0x26>
    n--;
  }
  return dst;
}
 2d4:	6422                	ld	s0,8(sp)
 2d6:	0141                	add	sp,sp,16
 2d8:	8082                	ret

00000000000002da <strlen>:

uint
strlen(const char *s)
{
 2da:	1141                	add	sp,sp,-16
 2dc:	e422                	sd	s0,8(sp)
 2de:	0800                	add	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 2e0:	00054783          	lbu	a5,0(a0)
 2e4:	cf91                	beqz	a5,300 <strlen+0x26>
 2e6:	0505                	add	a0,a0,1
 2e8:	87aa                	mv	a5,a0
 2ea:	86be                	mv	a3,a5
 2ec:	0785                	add	a5,a5,1
 2ee:	fff7c703          	lbu	a4,-1(a5)
 2f2:	ff65                	bnez	a4,2ea <strlen+0x10>
 2f4:	40a6853b          	subw	a0,a3,a0
 2f8:	2505                	addw	a0,a0,1
    ;
  return n;
}
 2fa:	6422                	ld	s0,8(sp)
 2fc:	0141                	add	sp,sp,16
 2fe:	8082                	ret
  for(n = 0; s[n]; n++)
 300:	4501                	li	a0,0
 302:	bfe5                	j	2fa <strlen+0x20>

0000000000000304 <memset>:

void*
memset(void *dst, int c, uint n)
{
 304:	1141                	add	sp,sp,-16
 306:	e422                	sd	s0,8(sp)
 308:	0800                	add	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 30a:	ca19                	beqz	a2,320 <memset+0x1c>
 30c:	87aa                	mv	a5,a0
 30e:	1602                	sll	a2,a2,0x20
 310:	9201                	srl	a2,a2,0x20
 312:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 316:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 31a:	0785                	add	a5,a5,1
 31c:	fee79de3          	bne	a5,a4,316 <memset+0x12>
  }
  return dst;
}
 320:	6422                	ld	s0,8(sp)
 322:	0141                	add	sp,sp,16
 324:	8082                	ret

0000000000000326 <strchr>:

char*
strchr(const char *s, char c)
{
 326:	1141                	add	sp,sp,-16
 328:	e422                	sd	s0,8(sp)
 32a:	0800                	add	s0,sp,16
  for(; *s; s++)
 32c:	00054783          	lbu	a5,0(a0)
 330:	cb99                	beqz	a5,346 <strchr+0x20>
    if(*s == c)
 332:	00f58763          	beq	a1,a5,340 <strchr+0x1a>
  for(; *s; s++)
 336:	0505                	add	a0,a0,1
 338:	00054783          	lbu	a5,0(a0)
 33c:	fbfd                	bnez	a5,332 <strchr+0xc>
      return (char*)s;
  return 0;
 33e:	4501                	li	a0,0
}
 340:	6422                	ld	s0,8(sp)
 342:	0141                	add	sp,sp,16
 344:	8082                	ret
  return 0;
 346:	4501                	li	a0,0
 348:	bfe5                	j	340 <strchr+0x1a>

000000000000034a <gets>:

char*
gets(char *buf, int max)
{
 34a:	711d                	add	sp,sp,-96
 34c:	ec86                	sd	ra,88(sp)
 34e:	e8a2                	sd	s0,80(sp)
 350:	e4a6                	sd	s1,72(sp)
 352:	e0ca                	sd	s2,64(sp)
 354:	fc4e                	sd	s3,56(sp)
 356:	f852                	sd	s4,48(sp)
 358:	f456                	sd	s5,40(sp)
 35a:	f05a                	sd	s6,32(sp)
 35c:	ec5e                	sd	s7,24(sp)
 35e:	1080                	add	s0,sp,96
 360:	8baa                	mv	s7,a0
 362:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 364:	892a                	mv	s2,a0
 366:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 368:	4aa9                	li	s5,10
 36a:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 36c:	89a6                	mv	s3,s1
 36e:	2485                	addw	s1,s1,1
 370:	0344d663          	bge	s1,s4,39c <gets+0x52>
    cc = read(0, &c, 1);
 374:	4605                	li	a2,1
 376:	faf40593          	add	a1,s0,-81
 37a:	4501                	li	a0,0
 37c:	252000ef          	jal	5ce <read>
    if(cc < 1)
 380:	00a05e63          	blez	a0,39c <gets+0x52>
    buf[i++] = c;
 384:	faf44783          	lbu	a5,-81(s0)
 388:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 38c:	01578763          	beq	a5,s5,39a <gets+0x50>
 390:	0905                	add	s2,s2,1
 392:	fd679de3          	bne	a5,s6,36c <gets+0x22>
    buf[i++] = c;
 396:	89a6                	mv	s3,s1
 398:	a011                	j	39c <gets+0x52>
 39a:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 39c:	99de                	add	s3,s3,s7
 39e:	00098023          	sb	zero,0(s3)
  return buf;
}
 3a2:	855e                	mv	a0,s7
 3a4:	60e6                	ld	ra,88(sp)
 3a6:	6446                	ld	s0,80(sp)
 3a8:	64a6                	ld	s1,72(sp)
 3aa:	6906                	ld	s2,64(sp)
 3ac:	79e2                	ld	s3,56(sp)
 3ae:	7a42                	ld	s4,48(sp)
 3b0:	7aa2                	ld	s5,40(sp)
 3b2:	7b02                	ld	s6,32(sp)
 3b4:	6be2                	ld	s7,24(sp)
 3b6:	6125                	add	sp,sp,96
 3b8:	8082                	ret

00000000000003ba <stat>:

int
stat(const char *n, struct stat *st)
{
 3ba:	1101                	add	sp,sp,-32
 3bc:	ec06                	sd	ra,24(sp)
 3be:	e822                	sd	s0,16(sp)
 3c0:	e04a                	sd	s2,0(sp)
 3c2:	1000                	add	s0,sp,32
 3c4:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 3c6:	4581                	li	a1,0
 3c8:	22e000ef          	jal	5f6 <open>
  if(fd < 0)
 3cc:	02054263          	bltz	a0,3f0 <stat+0x36>
 3d0:	e426                	sd	s1,8(sp)
 3d2:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 3d4:	85ca                	mv	a1,s2
 3d6:	238000ef          	jal	60e <fstat>
 3da:	892a                	mv	s2,a0
  close(fd);
 3dc:	8526                	mv	a0,s1
 3de:	200000ef          	jal	5de <close>
  return r;
 3e2:	64a2                	ld	s1,8(sp)
}
 3e4:	854a                	mv	a0,s2
 3e6:	60e2                	ld	ra,24(sp)
 3e8:	6442                	ld	s0,16(sp)
 3ea:	6902                	ld	s2,0(sp)
 3ec:	6105                	add	sp,sp,32
 3ee:	8082                	ret
    return -1;
 3f0:	597d                	li	s2,-1
 3f2:	bfcd                	j	3e4 <stat+0x2a>

00000000000003f4 <atoi>:

int
atoi(const char *s)
{
 3f4:	1141                	add	sp,sp,-16
 3f6:	e422                	sd	s0,8(sp)
 3f8:	0800                	add	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 3fa:	00054683          	lbu	a3,0(a0)
 3fe:	fd06879b          	addw	a5,a3,-48
 402:	0ff7f793          	zext.b	a5,a5
 406:	4625                	li	a2,9
 408:	02f66863          	bltu	a2,a5,438 <atoi+0x44>
 40c:	872a                	mv	a4,a0
  n = 0;
 40e:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 410:	0705                	add	a4,a4,1
 412:	0025179b          	sllw	a5,a0,0x2
 416:	9fa9                	addw	a5,a5,a0
 418:	0017979b          	sllw	a5,a5,0x1
 41c:	9fb5                	addw	a5,a5,a3
 41e:	fd07851b          	addw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 422:	00074683          	lbu	a3,0(a4)
 426:	fd06879b          	addw	a5,a3,-48
 42a:	0ff7f793          	zext.b	a5,a5
 42e:	fef671e3          	bgeu	a2,a5,410 <atoi+0x1c>
  return n;
}
 432:	6422                	ld	s0,8(sp)
 434:	0141                	add	sp,sp,16
 436:	8082                	ret
  n = 0;
 438:	4501                	li	a0,0
 43a:	bfe5                	j	432 <atoi+0x3e>

000000000000043c <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 43c:	1141                	add	sp,sp,-16
 43e:	e422                	sd	s0,8(sp)
 440:	0800                	add	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 442:	02b57463          	bgeu	a0,a1,46a <memmove+0x2e>
    while(n-- > 0)
 446:	00c05f63          	blez	a2,464 <memmove+0x28>
 44a:	1602                	sll	a2,a2,0x20
 44c:	9201                	srl	a2,a2,0x20
 44e:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 452:	872a                	mv	a4,a0
      *dst++ = *src++;
 454:	0585                	add	a1,a1,1
 456:	0705                	add	a4,a4,1
 458:	fff5c683          	lbu	a3,-1(a1)
 45c:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 460:	fef71ae3          	bne	a4,a5,454 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 464:	6422                	ld	s0,8(sp)
 466:	0141                	add	sp,sp,16
 468:	8082                	ret
    dst += n;
 46a:	00c50733          	add	a4,a0,a2
    src += n;
 46e:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 470:	fec05ae3          	blez	a2,464 <memmove+0x28>
 474:	fff6079b          	addw	a5,a2,-1
 478:	1782                	sll	a5,a5,0x20
 47a:	9381                	srl	a5,a5,0x20
 47c:	fff7c793          	not	a5,a5
 480:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 482:	15fd                	add	a1,a1,-1
 484:	177d                	add	a4,a4,-1
 486:	0005c683          	lbu	a3,0(a1)
 48a:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 48e:	fee79ae3          	bne	a5,a4,482 <memmove+0x46>
 492:	bfc9                	j	464 <memmove+0x28>

0000000000000494 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 494:	1141                	add	sp,sp,-16
 496:	e422                	sd	s0,8(sp)
 498:	0800                	add	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 49a:	ca05                	beqz	a2,4ca <memcmp+0x36>
 49c:	fff6069b          	addw	a3,a2,-1
 4a0:	1682                	sll	a3,a3,0x20
 4a2:	9281                	srl	a3,a3,0x20
 4a4:	0685                	add	a3,a3,1
 4a6:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 4a8:	00054783          	lbu	a5,0(a0)
 4ac:	0005c703          	lbu	a4,0(a1)
 4b0:	00e79863          	bne	a5,a4,4c0 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 4b4:	0505                	add	a0,a0,1
    p2++;
 4b6:	0585                	add	a1,a1,1
  while (n-- > 0) {
 4b8:	fed518e3          	bne	a0,a3,4a8 <memcmp+0x14>
  }
  return 0;
 4bc:	4501                	li	a0,0
 4be:	a019                	j	4c4 <memcmp+0x30>
      return *p1 - *p2;
 4c0:	40e7853b          	subw	a0,a5,a4
}
 4c4:	6422                	ld	s0,8(sp)
 4c6:	0141                	add	sp,sp,16
 4c8:	8082                	ret
  return 0;
 4ca:	4501                	li	a0,0
 4cc:	bfe5                	j	4c4 <memcmp+0x30>

00000000000004ce <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 4ce:	1141                	add	sp,sp,-16
 4d0:	e406                	sd	ra,8(sp)
 4d2:	e022                	sd	s0,0(sp)
 4d4:	0800                	add	s0,sp,16
  return memmove(dst, src, n);
 4d6:	f67ff0ef          	jal	43c <memmove>
}
 4da:	60a2                	ld	ra,8(sp)
 4dc:	6402                	ld	s0,0(sp)
 4de:	0141                	add	sp,sp,16
 4e0:	8082                	ret

00000000000004e2 <sbrk>:

char *
sbrk(int n) {
 4e2:	1141                	add	sp,sp,-16
 4e4:	e406                	sd	ra,8(sp)
 4e6:	e022                	sd	s0,0(sp)
 4e8:	0800                	add	s0,sp,16
  return sys_sbrk(n, SBRK_EAGER);
 4ea:	4585                	li	a1,1
 4ec:	152000ef          	jal	63e <sys_sbrk>
}
 4f0:	60a2                	ld	ra,8(sp)
 4f2:	6402                	ld	s0,0(sp)
 4f4:	0141                	add	sp,sp,16
 4f6:	8082                	ret

00000000000004f8 <sbrklazy>:

char *
sbrklazy(int n) {
 4f8:	1141                	add	sp,sp,-16
 4fa:	e406                	sd	ra,8(sp)
 4fc:	e022                	sd	s0,0(sp)
 4fe:	0800                	add	s0,sp,16
  return sys_sbrk(n, SBRK_LAZY);
 500:	4589                	li	a1,2
 502:	13c000ef          	jal	63e <sys_sbrk>
}
 506:	60a2                	ld	ra,8(sp)
 508:	6402                	ld	s0,0(sp)
 50a:	0141                	add	sp,sp,16
 50c:	8082                	ret

000000000000050e <htons>:

// Byte order conversion functions
unsigned short
htons(unsigned short hostshort)
{
 50e:	1141                	add	sp,sp,-16
 510:	e422                	sd	s0,8(sp)
 512:	0800                	add	s0,sp,16
  return ((hostshort >> 8) & 0xff) | ((hostshort & 0xff) << 8);
 514:	0085179b          	sllw	a5,a0,0x8
 518:	0085551b          	srlw	a0,a0,0x8
 51c:	8d5d                	or	a0,a0,a5
}
 51e:	1542                	sll	a0,a0,0x30
 520:	9141                	srl	a0,a0,0x30
 522:	6422                	ld	s0,8(sp)
 524:	0141                	add	sp,sp,16
 526:	8082                	ret

0000000000000528 <ntohs>:

unsigned short
ntohs(unsigned short netshort)
{
 528:	1141                	add	sp,sp,-16
 52a:	e422                	sd	s0,8(sp)
 52c:	0800                	add	s0,sp,16
  return ((netshort >> 8) & 0xff) | ((netshort & 0xff) << 8);
 52e:	0085179b          	sllw	a5,a0,0x8
 532:	0085551b          	srlw	a0,a0,0x8
 536:	8d5d                	or	a0,a0,a5
}
 538:	1542                	sll	a0,a0,0x30
 53a:	9141                	srl	a0,a0,0x30
 53c:	6422                	ld	s0,8(sp)
 53e:	0141                	add	sp,sp,16
 540:	8082                	ret

0000000000000542 <htonl>:

unsigned long
htonl(unsigned long hostlong)
{
 542:	1141                	add	sp,sp,-16
 544:	e422                	sd	s0,8(sp)
 546:	0800                	add	s0,sp,16
  return ((hostlong >> 24) & 0xff) |
 548:	0185579b          	srlw	a5,a0,0x18
         ((hostlong >> 8) & 0xff00) |
 54c:	00855713          	srl	a4,a0,0x8
 550:	66c1                	lui	a3,0x10
 552:	f0068693          	add	a3,a3,-256 # ff00 <base+0xdaf0>
 556:	8f75                	and	a4,a4,a3
  return ((hostlong >> 24) & 0xff) |
 558:	8fd9                	or	a5,a5,a4
         ((hostlong & 0xff00) << 8) |
 55a:	00851713          	sll	a4,a0,0x8
 55e:	00ff06b7          	lui	a3,0xff0
 562:	8f75                	and	a4,a4,a3
         ((hostlong >> 8) & 0xff00) |
 564:	8fd9                	or	a5,a5,a4
         ((hostlong & 0xff) << 24);
 566:	0562                	sll	a0,a0,0x18
 568:	0ff00713          	li	a4,255
 56c:	0762                	sll	a4,a4,0x18
 56e:	8d79                	and	a0,a0,a4
}
 570:	8d5d                	or	a0,a0,a5
 572:	6422                	ld	s0,8(sp)
 574:	0141                	add	sp,sp,16
 576:	8082                	ret

0000000000000578 <ntohl>:

unsigned long
ntohl(unsigned long netlong)
{
 578:	1141                	add	sp,sp,-16
 57a:	e422                	sd	s0,8(sp)
 57c:	0800                	add	s0,sp,16
  return ((netlong >> 24) & 0xff) |
 57e:	0185579b          	srlw	a5,a0,0x18
         ((netlong >> 8) & 0xff00) |
 582:	00855713          	srl	a4,a0,0x8
 586:	66c1                	lui	a3,0x10
 588:	f0068693          	add	a3,a3,-256 # ff00 <base+0xdaf0>
 58c:	8f75                	and	a4,a4,a3
  return ((netlong >> 24) & 0xff) |
 58e:	8fd9                	or	a5,a5,a4
         ((netlong & 0xff00) << 8) |
 590:	00851713          	sll	a4,a0,0x8
 594:	00ff06b7          	lui	a3,0xff0
 598:	8f75                	and	a4,a4,a3
         ((netlong >> 8) & 0xff00) |
 59a:	8fd9                	or	a5,a5,a4
         ((netlong & 0xff) << 24);
 59c:	0562                	sll	a0,a0,0x18
 59e:	0ff00713          	li	a4,255
 5a2:	0762                	sll	a4,a4,0x18
 5a4:	8d79                	and	a0,a0,a4
}
 5a6:	8d5d                	or	a0,a0,a5
 5a8:	6422                	ld	s0,8(sp)
 5aa:	0141                	add	sp,sp,16
 5ac:	8082                	ret

00000000000005ae <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 5ae:	4885                	li	a7,1
 ecall
 5b0:	00000073          	ecall
 ret
 5b4:	8082                	ret

00000000000005b6 <exit>:
.global exit
exit:
 li a7, SYS_exit
 5b6:	4889                	li	a7,2
 ecall
 5b8:	00000073          	ecall
 ret
 5bc:	8082                	ret

00000000000005be <wait>:
.global wait
wait:
 li a7, SYS_wait
 5be:	488d                	li	a7,3
 ecall
 5c0:	00000073          	ecall
 ret
 5c4:	8082                	ret

00000000000005c6 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 5c6:	4891                	li	a7,4
 ecall
 5c8:	00000073          	ecall
 ret
 5cc:	8082                	ret

00000000000005ce <read>:
.global read
read:
 li a7, SYS_read
 5ce:	4895                	li	a7,5
 ecall
 5d0:	00000073          	ecall
 ret
 5d4:	8082                	ret

00000000000005d6 <write>:
.global write
write:
 li a7, SYS_write
 5d6:	48c1                	li	a7,16
 ecall
 5d8:	00000073          	ecall
 ret
 5dc:	8082                	ret

00000000000005de <close>:
.global close
close:
 li a7, SYS_close
 5de:	48d5                	li	a7,21
 ecall
 5e0:	00000073          	ecall
 ret
 5e4:	8082                	ret

00000000000005e6 <kill>:
.global kill
kill:
 li a7, SYS_kill
 5e6:	4899                	li	a7,6
 ecall
 5e8:	00000073          	ecall
 ret
 5ec:	8082                	ret

00000000000005ee <exec>:
.global exec
exec:
 li a7, SYS_exec
 5ee:	489d                	li	a7,7
 ecall
 5f0:	00000073          	ecall
 ret
 5f4:	8082                	ret

00000000000005f6 <open>:
.global open
open:
 li a7, SYS_open
 5f6:	48bd                	li	a7,15
 ecall
 5f8:	00000073          	ecall
 ret
 5fc:	8082                	ret

00000000000005fe <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 5fe:	48c5                	li	a7,17
 ecall
 600:	00000073          	ecall
 ret
 604:	8082                	ret

0000000000000606 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 606:	48c9                	li	a7,18
 ecall
 608:	00000073          	ecall
 ret
 60c:	8082                	ret

000000000000060e <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 60e:	48a1                	li	a7,8
 ecall
 610:	00000073          	ecall
 ret
 614:	8082                	ret

0000000000000616 <link>:
.global link
link:
 li a7, SYS_link
 616:	48cd                	li	a7,19
 ecall
 618:	00000073          	ecall
 ret
 61c:	8082                	ret

000000000000061e <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 61e:	48d1                	li	a7,20
 ecall
 620:	00000073          	ecall
 ret
 624:	8082                	ret

0000000000000626 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 626:	48a5                	li	a7,9
 ecall
 628:	00000073          	ecall
 ret
 62c:	8082                	ret

000000000000062e <dup>:
.global dup
dup:
 li a7, SYS_dup
 62e:	48a9                	li	a7,10
 ecall
 630:	00000073          	ecall
 ret
 634:	8082                	ret

0000000000000636 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 636:	48ad                	li	a7,11
 ecall
 638:	00000073          	ecall
 ret
 63c:	8082                	ret

000000000000063e <sys_sbrk>:
.global sys_sbrk
sys_sbrk:
 li a7, SYS_sbrk
 63e:	48b1                	li	a7,12
 ecall
 640:	00000073          	ecall
 ret
 644:	8082                	ret

0000000000000646 <pause>:
.global pause
pause:
 li a7, SYS_pause
 646:	48b5                	li	a7,13
 ecall
 648:	00000073          	ecall
 ret
 64c:	8082                	ret

000000000000064e <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 64e:	48b9                	li	a7,14
 ecall
 650:	00000073          	ecall
 ret
 654:	8082                	ret

0000000000000656 <socket>:
.global socket
socket:
 li a7, SYS_socket
 656:	48d9                	li	a7,22
 ecall
 658:	00000073          	ecall
 ret
 65c:	8082                	ret

000000000000065e <bind>:
.global bind
bind:
 li a7, SYS_bind
 65e:	48dd                	li	a7,23
 ecall
 660:	00000073          	ecall
 ret
 664:	8082                	ret

0000000000000666 <listen>:
.global listen
listen:
 li a7, SYS_listen
 666:	48e1                	li	a7,24
 ecall
 668:	00000073          	ecall
 ret
 66c:	8082                	ret

000000000000066e <accept>:
.global accept
accept:
 li a7, SYS_accept
 66e:	48e5                	li	a7,25
 ecall
 670:	00000073          	ecall
 ret
 674:	8082                	ret

0000000000000676 <connect>:
.global connect
connect:
 li a7, SYS_connect
 676:	48e9                	li	a7,26
 ecall
 678:	00000073          	ecall
 ret
 67c:	8082                	ret

000000000000067e <send>:
.global send
send:
 li a7, SYS_send
 67e:	48ed                	li	a7,27
 ecall
 680:	00000073          	ecall
 ret
 684:	8082                	ret

0000000000000686 <recv>:
.global recv
recv:
 li a7, SYS_recv
 686:	48f1                	li	a7,28
 ecall
 688:	00000073          	ecall
 ret
 68c:	8082                	ret

000000000000068e <sendto>:
.global sendto
sendto:
 li a7, SYS_sendto
 68e:	48f5                	li	a7,29
 ecall
 690:	00000073          	ecall
 ret
 694:	8082                	ret

0000000000000696 <recvfrom>:
.global recvfrom
recvfrom:
 li a7, SYS_recvfrom
 696:	48f9                	li	a7,30
 ecall
 698:	00000073          	ecall
 ret
 69c:	8082                	ret

000000000000069e <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 69e:	1101                	add	sp,sp,-32
 6a0:	ec06                	sd	ra,24(sp)
 6a2:	e822                	sd	s0,16(sp)
 6a4:	1000                	add	s0,sp,32
 6a6:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 6aa:	4605                	li	a2,1
 6ac:	fef40593          	add	a1,s0,-17
 6b0:	f27ff0ef          	jal	5d6 <write>
}
 6b4:	60e2                	ld	ra,24(sp)
 6b6:	6442                	ld	s0,16(sp)
 6b8:	6105                	add	sp,sp,32
 6ba:	8082                	ret

00000000000006bc <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
 6bc:	715d                	add	sp,sp,-80
 6be:	e486                	sd	ra,72(sp)
 6c0:	e0a2                	sd	s0,64(sp)
 6c2:	f84a                	sd	s2,48(sp)
 6c4:	0880                	add	s0,sp,80
 6c6:	892a                	mv	s2,a0
  char buf[20];
  int i, neg;
  unsigned long long x;

  neg = 0;
  if(sgn && xx < 0){
 6c8:	c299                	beqz	a3,6ce <printint+0x12>
 6ca:	0805c363          	bltz	a1,750 <printint+0x94>
  neg = 0;
 6ce:	4881                	li	a7,0
 6d0:	fb840693          	add	a3,s0,-72
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
 6d4:	4781                	li	a5,0
  do{
    buf[i++] = digits[x % base];
 6d6:	00000517          	auipc	a0,0x0
 6da:	62a50513          	add	a0,a0,1578 # d00 <digits>
 6de:	883e                	mv	a6,a5
 6e0:	2785                	addw	a5,a5,1
 6e2:	02c5f733          	remu	a4,a1,a2
 6e6:	972a                	add	a4,a4,a0
 6e8:	00074703          	lbu	a4,0(a4)
 6ec:	00e68023          	sb	a4,0(a3) # ff0000 <base+0xfedbf0>
  }while((x /= base) != 0);
 6f0:	872e                	mv	a4,a1
 6f2:	02c5d5b3          	divu	a1,a1,a2
 6f6:	0685                	add	a3,a3,1
 6f8:	fec773e3          	bgeu	a4,a2,6de <printint+0x22>
  if(neg)
 6fc:	00088b63          	beqz	a7,712 <printint+0x56>
    buf[i++] = '-';
 700:	fd078793          	add	a5,a5,-48
 704:	97a2                	add	a5,a5,s0
 706:	02d00713          	li	a4,45
 70a:	fee78423          	sb	a4,-24(a5)
 70e:	0028079b          	addw	a5,a6,2

  while(--i >= 0)
 712:	02f05a63          	blez	a5,746 <printint+0x8a>
 716:	fc26                	sd	s1,56(sp)
 718:	f44e                	sd	s3,40(sp)
 71a:	fb840713          	add	a4,s0,-72
 71e:	00f704b3          	add	s1,a4,a5
 722:	fff70993          	add	s3,a4,-1
 726:	99be                	add	s3,s3,a5
 728:	37fd                	addw	a5,a5,-1
 72a:	1782                	sll	a5,a5,0x20
 72c:	9381                	srl	a5,a5,0x20
 72e:	40f989b3          	sub	s3,s3,a5
    putc(fd, buf[i]);
 732:	fff4c583          	lbu	a1,-1(s1)
 736:	854a                	mv	a0,s2
 738:	f67ff0ef          	jal	69e <putc>
  while(--i >= 0)
 73c:	14fd                	add	s1,s1,-1
 73e:	ff349ae3          	bne	s1,s3,732 <printint+0x76>
 742:	74e2                	ld	s1,56(sp)
 744:	79a2                	ld	s3,40(sp)
}
 746:	60a6                	ld	ra,72(sp)
 748:	6406                	ld	s0,64(sp)
 74a:	7942                	ld	s2,48(sp)
 74c:	6161                	add	sp,sp,80
 74e:	8082                	ret
    x = -xx;
 750:	40b005b3          	neg	a1,a1
    neg = 1;
 754:	4885                	li	a7,1
    x = -xx;
 756:	bfad                	j	6d0 <printint+0x14>

0000000000000758 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %c, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 758:	711d                	add	sp,sp,-96
 75a:	ec86                	sd	ra,88(sp)
 75c:	e8a2                	sd	s0,80(sp)
 75e:	e0ca                	sd	s2,64(sp)
 760:	1080                	add	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 762:	0005c903          	lbu	s2,0(a1)
 766:	28090663          	beqz	s2,9f2 <vprintf+0x29a>
 76a:	e4a6                	sd	s1,72(sp)
 76c:	fc4e                	sd	s3,56(sp)
 76e:	f852                	sd	s4,48(sp)
 770:	f456                	sd	s5,40(sp)
 772:	f05a                	sd	s6,32(sp)
 774:	ec5e                	sd	s7,24(sp)
 776:	e862                	sd	s8,16(sp)
 778:	e466                	sd	s9,8(sp)
 77a:	8b2a                	mv	s6,a0
 77c:	8a2e                	mv	s4,a1
 77e:	8bb2                	mv	s7,a2
  state = 0;
 780:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
 782:	4481                	li	s1,0
 784:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
 786:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
 78a:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
 78e:	06c00c93          	li	s9,108
 792:	a005                	j	7b2 <vprintf+0x5a>
        putc(fd, c0);
 794:	85ca                	mv	a1,s2
 796:	855a                	mv	a0,s6
 798:	f07ff0ef          	jal	69e <putc>
 79c:	a019                	j	7a2 <vprintf+0x4a>
    } else if(state == '%'){
 79e:	03598263          	beq	s3,s5,7c2 <vprintf+0x6a>
  for(i = 0; fmt[i]; i++){
 7a2:	2485                	addw	s1,s1,1
 7a4:	8726                	mv	a4,s1
 7a6:	009a07b3          	add	a5,s4,s1
 7aa:	0007c903          	lbu	s2,0(a5)
 7ae:	22090a63          	beqz	s2,9e2 <vprintf+0x28a>
    c0 = fmt[i] & 0xff;
 7b2:	0009079b          	sext.w	a5,s2
    if(state == 0){
 7b6:	fe0994e3          	bnez	s3,79e <vprintf+0x46>
      if(c0 == '%'){
 7ba:	fd579de3          	bne	a5,s5,794 <vprintf+0x3c>
        state = '%';
 7be:	89be                	mv	s3,a5
 7c0:	b7cd                	j	7a2 <vprintf+0x4a>
      if(c0) c1 = fmt[i+1] & 0xff;
 7c2:	00ea06b3          	add	a3,s4,a4
 7c6:	0016c683          	lbu	a3,1(a3)
      c1 = c2 = 0;
 7ca:	8636                	mv	a2,a3
      if(c1) c2 = fmt[i+2] & 0xff;
 7cc:	c681                	beqz	a3,7d4 <vprintf+0x7c>
 7ce:	9752                	add	a4,a4,s4
 7d0:	00274603          	lbu	a2,2(a4)
      if(c0 == 'd'){
 7d4:	05878363          	beq	a5,s8,81a <vprintf+0xc2>
      } else if(c0 == 'l' && c1 == 'd'){
 7d8:	05978d63          	beq	a5,s9,832 <vprintf+0xda>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
 7dc:	07500713          	li	a4,117
 7e0:	0ee78763          	beq	a5,a4,8ce <vprintf+0x176>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
 7e4:	07800713          	li	a4,120
 7e8:	12e78963          	beq	a5,a4,91a <vprintf+0x1c2>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
 7ec:	07000713          	li	a4,112
 7f0:	14e78e63          	beq	a5,a4,94c <vprintf+0x1f4>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 'c'){
 7f4:	06300713          	li	a4,99
 7f8:	18e78e63          	beq	a5,a4,994 <vprintf+0x23c>
        putc(fd, va_arg(ap, uint32));
      } else if(c0 == 's'){
 7fc:	07300713          	li	a4,115
 800:	1ae78463          	beq	a5,a4,9a8 <vprintf+0x250>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
 804:	02500713          	li	a4,37
 808:	04e79563          	bne	a5,a4,852 <vprintf+0xfa>
        putc(fd, '%');
 80c:	02500593          	li	a1,37
 810:	855a                	mv	a0,s6
 812:	e8dff0ef          	jal	69e <putc>
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c0);
      }

      state = 0;
 816:	4981                	li	s3,0
 818:	b769                	j	7a2 <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 1);
 81a:	008b8913          	add	s2,s7,8
 81e:	4685                	li	a3,1
 820:	4629                	li	a2,10
 822:	000ba583          	lw	a1,0(s7)
 826:	855a                	mv	a0,s6
 828:	e95ff0ef          	jal	6bc <printint>
 82c:	8bca                	mv	s7,s2
      state = 0;
 82e:	4981                	li	s3,0
 830:	bf8d                	j	7a2 <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'd'){
 832:	06400793          	li	a5,100
 836:	02f68963          	beq	a3,a5,868 <vprintf+0x110>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 83a:	06c00793          	li	a5,108
 83e:	04f68263          	beq	a3,a5,882 <vprintf+0x12a>
      } else if(c0 == 'l' && c1 == 'u'){
 842:	07500793          	li	a5,117
 846:	0af68063          	beq	a3,a5,8e6 <vprintf+0x18e>
      } else if(c0 == 'l' && c1 == 'x'){
 84a:	07800793          	li	a5,120
 84e:	0ef68263          	beq	a3,a5,932 <vprintf+0x1da>
        putc(fd, '%');
 852:	02500593          	li	a1,37
 856:	855a                	mv	a0,s6
 858:	e47ff0ef          	jal	69e <putc>
        putc(fd, c0);
 85c:	85ca                	mv	a1,s2
 85e:	855a                	mv	a0,s6
 860:	e3fff0ef          	jal	69e <putc>
      state = 0;
 864:	4981                	li	s3,0
 866:	bf35                	j	7a2 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 868:	008b8913          	add	s2,s7,8
 86c:	4685                	li	a3,1
 86e:	4629                	li	a2,10
 870:	000bb583          	ld	a1,0(s7)
 874:	855a                	mv	a0,s6
 876:	e47ff0ef          	jal	6bc <printint>
        i += 1;
 87a:	2485                	addw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 87c:	8bca                	mv	s7,s2
      state = 0;
 87e:	4981                	li	s3,0
        i += 1;
 880:	b70d                	j	7a2 <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 882:	06400793          	li	a5,100
 886:	02f60763          	beq	a2,a5,8b4 <vprintf+0x15c>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 88a:	07500793          	li	a5,117
 88e:	06f60963          	beq	a2,a5,900 <vprintf+0x1a8>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 892:	07800793          	li	a5,120
 896:	faf61ee3          	bne	a2,a5,852 <vprintf+0xfa>
        printint(fd, va_arg(ap, uint64), 16, 0);
 89a:	008b8913          	add	s2,s7,8
 89e:	4681                	li	a3,0
 8a0:	4641                	li	a2,16
 8a2:	000bb583          	ld	a1,0(s7)
 8a6:	855a                	mv	a0,s6
 8a8:	e15ff0ef          	jal	6bc <printint>
        i += 2;
 8ac:	2489                	addw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 8ae:	8bca                	mv	s7,s2
      state = 0;
 8b0:	4981                	li	s3,0
        i += 2;
 8b2:	bdc5                	j	7a2 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 8b4:	008b8913          	add	s2,s7,8
 8b8:	4685                	li	a3,1
 8ba:	4629                	li	a2,10
 8bc:	000bb583          	ld	a1,0(s7)
 8c0:	855a                	mv	a0,s6
 8c2:	dfbff0ef          	jal	6bc <printint>
        i += 2;
 8c6:	2489                	addw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 8c8:	8bca                	mv	s7,s2
      state = 0;
 8ca:	4981                	li	s3,0
        i += 2;
 8cc:	bdd9                	j	7a2 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint32), 10, 0);
 8ce:	008b8913          	add	s2,s7,8
 8d2:	4681                	li	a3,0
 8d4:	4629                	li	a2,10
 8d6:	000be583          	lwu	a1,0(s7)
 8da:	855a                	mv	a0,s6
 8dc:	de1ff0ef          	jal	6bc <printint>
 8e0:	8bca                	mv	s7,s2
      state = 0;
 8e2:	4981                	li	s3,0
 8e4:	bd7d                	j	7a2 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 8e6:	008b8913          	add	s2,s7,8
 8ea:	4681                	li	a3,0
 8ec:	4629                	li	a2,10
 8ee:	000bb583          	ld	a1,0(s7)
 8f2:	855a                	mv	a0,s6
 8f4:	dc9ff0ef          	jal	6bc <printint>
        i += 1;
 8f8:	2485                	addw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 8fa:	8bca                	mv	s7,s2
      state = 0;
 8fc:	4981                	li	s3,0
        i += 1;
 8fe:	b555                	j	7a2 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 900:	008b8913          	add	s2,s7,8
 904:	4681                	li	a3,0
 906:	4629                	li	a2,10
 908:	000bb583          	ld	a1,0(s7)
 90c:	855a                	mv	a0,s6
 90e:	dafff0ef          	jal	6bc <printint>
        i += 2;
 912:	2489                	addw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 914:	8bca                	mv	s7,s2
      state = 0;
 916:	4981                	li	s3,0
        i += 2;
 918:	b569                	j	7a2 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint32), 16, 0);
 91a:	008b8913          	add	s2,s7,8
 91e:	4681                	li	a3,0
 920:	4641                	li	a2,16
 922:	000be583          	lwu	a1,0(s7)
 926:	855a                	mv	a0,s6
 928:	d95ff0ef          	jal	6bc <printint>
 92c:	8bca                	mv	s7,s2
      state = 0;
 92e:	4981                	li	s3,0
 930:	bd8d                	j	7a2 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 16, 0);
 932:	008b8913          	add	s2,s7,8
 936:	4681                	li	a3,0
 938:	4641                	li	a2,16
 93a:	000bb583          	ld	a1,0(s7)
 93e:	855a                	mv	a0,s6
 940:	d7dff0ef          	jal	6bc <printint>
        i += 1;
 944:	2485                	addw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 946:	8bca                	mv	s7,s2
      state = 0;
 948:	4981                	li	s3,0
        i += 1;
 94a:	bda1                	j	7a2 <vprintf+0x4a>
 94c:	e06a                	sd	s10,0(sp)
        printptr(fd, va_arg(ap, uint64));
 94e:	008b8d13          	add	s10,s7,8
 952:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 956:	03000593          	li	a1,48
 95a:	855a                	mv	a0,s6
 95c:	d43ff0ef          	jal	69e <putc>
  putc(fd, 'x');
 960:	07800593          	li	a1,120
 964:	855a                	mv	a0,s6
 966:	d39ff0ef          	jal	69e <putc>
 96a:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 96c:	00000b97          	auipc	s7,0x0
 970:	394b8b93          	add	s7,s7,916 # d00 <digits>
 974:	03c9d793          	srl	a5,s3,0x3c
 978:	97de                	add	a5,a5,s7
 97a:	0007c583          	lbu	a1,0(a5)
 97e:	855a                	mv	a0,s6
 980:	d1fff0ef          	jal	69e <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 984:	0992                	sll	s3,s3,0x4
 986:	397d                	addw	s2,s2,-1
 988:	fe0916e3          	bnez	s2,974 <vprintf+0x21c>
        printptr(fd, va_arg(ap, uint64));
 98c:	8bea                	mv	s7,s10
      state = 0;
 98e:	4981                	li	s3,0
 990:	6d02                	ld	s10,0(sp)
 992:	bd01                	j	7a2 <vprintf+0x4a>
        putc(fd, va_arg(ap, uint32));
 994:	008b8913          	add	s2,s7,8
 998:	000bc583          	lbu	a1,0(s7)
 99c:	855a                	mv	a0,s6
 99e:	d01ff0ef          	jal	69e <putc>
 9a2:	8bca                	mv	s7,s2
      state = 0;
 9a4:	4981                	li	s3,0
 9a6:	bbf5                	j	7a2 <vprintf+0x4a>
        if((s = va_arg(ap, char*)) == 0)
 9a8:	008b8993          	add	s3,s7,8
 9ac:	000bb903          	ld	s2,0(s7)
 9b0:	00090f63          	beqz	s2,9ce <vprintf+0x276>
        for(; *s; s++)
 9b4:	00094583          	lbu	a1,0(s2)
 9b8:	c195                	beqz	a1,9dc <vprintf+0x284>
          putc(fd, *s);
 9ba:	855a                	mv	a0,s6
 9bc:	ce3ff0ef          	jal	69e <putc>
        for(; *s; s++)
 9c0:	0905                	add	s2,s2,1
 9c2:	00094583          	lbu	a1,0(s2)
 9c6:	f9f5                	bnez	a1,9ba <vprintf+0x262>
        if((s = va_arg(ap, char*)) == 0)
 9c8:	8bce                	mv	s7,s3
      state = 0;
 9ca:	4981                	li	s3,0
 9cc:	bbd9                	j	7a2 <vprintf+0x4a>
          s = "(null)";
 9ce:	00000917          	auipc	s2,0x0
 9d2:	32a90913          	add	s2,s2,810 # cf8 <malloc+0x21e>
        for(; *s; s++)
 9d6:	02800593          	li	a1,40
 9da:	b7c5                	j	9ba <vprintf+0x262>
        if((s = va_arg(ap, char*)) == 0)
 9dc:	8bce                	mv	s7,s3
      state = 0;
 9de:	4981                	li	s3,0
 9e0:	b3c9                	j	7a2 <vprintf+0x4a>
 9e2:	64a6                	ld	s1,72(sp)
 9e4:	79e2                	ld	s3,56(sp)
 9e6:	7a42                	ld	s4,48(sp)
 9e8:	7aa2                	ld	s5,40(sp)
 9ea:	7b02                	ld	s6,32(sp)
 9ec:	6be2                	ld	s7,24(sp)
 9ee:	6c42                	ld	s8,16(sp)
 9f0:	6ca2                	ld	s9,8(sp)
    }
  }
}
 9f2:	60e6                	ld	ra,88(sp)
 9f4:	6446                	ld	s0,80(sp)
 9f6:	6906                	ld	s2,64(sp)
 9f8:	6125                	add	sp,sp,96
 9fa:	8082                	ret

00000000000009fc <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 9fc:	715d                	add	sp,sp,-80
 9fe:	ec06                	sd	ra,24(sp)
 a00:	e822                	sd	s0,16(sp)
 a02:	1000                	add	s0,sp,32
 a04:	e010                	sd	a2,0(s0)
 a06:	e414                	sd	a3,8(s0)
 a08:	e818                	sd	a4,16(s0)
 a0a:	ec1c                	sd	a5,24(s0)
 a0c:	03043023          	sd	a6,32(s0)
 a10:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 a14:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 a18:	8622                	mv	a2,s0
 a1a:	d3fff0ef          	jal	758 <vprintf>
}
 a1e:	60e2                	ld	ra,24(sp)
 a20:	6442                	ld	s0,16(sp)
 a22:	6161                	add	sp,sp,80
 a24:	8082                	ret

0000000000000a26 <printf>:

void
printf(const char *fmt, ...)
{
 a26:	711d                	add	sp,sp,-96
 a28:	ec06                	sd	ra,24(sp)
 a2a:	e822                	sd	s0,16(sp)
 a2c:	1000                	add	s0,sp,32
 a2e:	e40c                	sd	a1,8(s0)
 a30:	e810                	sd	a2,16(s0)
 a32:	ec14                	sd	a3,24(s0)
 a34:	f018                	sd	a4,32(s0)
 a36:	f41c                	sd	a5,40(s0)
 a38:	03043823          	sd	a6,48(s0)
 a3c:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 a40:	00840613          	add	a2,s0,8
 a44:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 a48:	85aa                	mv	a1,a0
 a4a:	4505                	li	a0,1
 a4c:	d0dff0ef          	jal	758 <vprintf>
}
 a50:	60e2                	ld	ra,24(sp)
 a52:	6442                	ld	s0,16(sp)
 a54:	6125                	add	sp,sp,96
 a56:	8082                	ret

0000000000000a58 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 a58:	1141                	add	sp,sp,-16
 a5a:	e422                	sd	s0,8(sp)
 a5c:	0800                	add	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 a5e:	ff050693          	add	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 a62:	00000797          	auipc	a5,0x0
 a66:	59e7b783          	ld	a5,1438(a5) # 1000 <freep>
 a6a:	a02d                	j	a94 <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 a6c:	4618                	lw	a4,8(a2)
 a6e:	9f2d                	addw	a4,a4,a1
 a70:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 a74:	6398                	ld	a4,0(a5)
 a76:	6310                	ld	a2,0(a4)
 a78:	a83d                	j	ab6 <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 a7a:	ff852703          	lw	a4,-8(a0)
 a7e:	9f31                	addw	a4,a4,a2
 a80:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 a82:	ff053683          	ld	a3,-16(a0)
 a86:	a091                	j	aca <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 a88:	6398                	ld	a4,0(a5)
 a8a:	00e7e463          	bltu	a5,a4,a92 <free+0x3a>
 a8e:	00e6ea63          	bltu	a3,a4,aa2 <free+0x4a>
{
 a92:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 a94:	fed7fae3          	bgeu	a5,a3,a88 <free+0x30>
 a98:	6398                	ld	a4,0(a5)
 a9a:	00e6e463          	bltu	a3,a4,aa2 <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 a9e:	fee7eae3          	bltu	a5,a4,a92 <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 aa2:	ff852583          	lw	a1,-8(a0)
 aa6:	6390                	ld	a2,0(a5)
 aa8:	02059813          	sll	a6,a1,0x20
 aac:	01c85713          	srl	a4,a6,0x1c
 ab0:	9736                	add	a4,a4,a3
 ab2:	fae60de3          	beq	a2,a4,a6c <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 ab6:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 aba:	4790                	lw	a2,8(a5)
 abc:	02061593          	sll	a1,a2,0x20
 ac0:	01c5d713          	srl	a4,a1,0x1c
 ac4:	973e                	add	a4,a4,a5
 ac6:	fae68ae3          	beq	a3,a4,a7a <free+0x22>
    p->s.ptr = bp->s.ptr;
 aca:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 acc:	00000717          	auipc	a4,0x0
 ad0:	52f73a23          	sd	a5,1332(a4) # 1000 <freep>
}
 ad4:	6422                	ld	s0,8(sp)
 ad6:	0141                	add	sp,sp,16
 ad8:	8082                	ret

0000000000000ada <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 ada:	7139                	add	sp,sp,-64
 adc:	fc06                	sd	ra,56(sp)
 ade:	f822                	sd	s0,48(sp)
 ae0:	f426                	sd	s1,40(sp)
 ae2:	ec4e                	sd	s3,24(sp)
 ae4:	0080                	add	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 ae6:	02051493          	sll	s1,a0,0x20
 aea:	9081                	srl	s1,s1,0x20
 aec:	04bd                	add	s1,s1,15
 aee:	8091                	srl	s1,s1,0x4
 af0:	0014899b          	addw	s3,s1,1
 af4:	0485                	add	s1,s1,1
  if((prevp = freep) == 0){
 af6:	00000517          	auipc	a0,0x0
 afa:	50a53503          	ld	a0,1290(a0) # 1000 <freep>
 afe:	c915                	beqz	a0,b32 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 b00:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 b02:	4798                	lw	a4,8(a5)
 b04:	08977a63          	bgeu	a4,s1,b98 <malloc+0xbe>
 b08:	f04a                	sd	s2,32(sp)
 b0a:	e852                	sd	s4,16(sp)
 b0c:	e456                	sd	s5,8(sp)
 b0e:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 b10:	8a4e                	mv	s4,s3
 b12:	0009871b          	sext.w	a4,s3
 b16:	6685                	lui	a3,0x1
 b18:	00d77363          	bgeu	a4,a3,b1e <malloc+0x44>
 b1c:	6a05                	lui	s4,0x1
 b1e:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 b22:	004a1a1b          	sllw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 b26:	00000917          	auipc	s2,0x0
 b2a:	4da90913          	add	s2,s2,1242 # 1000 <freep>
  if(p == SBRK_ERROR)
 b2e:	5afd                	li	s5,-1
 b30:	a081                	j	b70 <malloc+0x96>
 b32:	f04a                	sd	s2,32(sp)
 b34:	e852                	sd	s4,16(sp)
 b36:	e456                	sd	s5,8(sp)
 b38:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 b3a:	00002797          	auipc	a5,0x2
 b3e:	8d678793          	add	a5,a5,-1834 # 2410 <base>
 b42:	00000717          	auipc	a4,0x0
 b46:	4af73f23          	sd	a5,1214(a4) # 1000 <freep>
 b4a:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 b4c:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 b50:	b7c1                	j	b10 <malloc+0x36>
        prevp->s.ptr = p->s.ptr;
 b52:	6398                	ld	a4,0(a5)
 b54:	e118                	sd	a4,0(a0)
 b56:	a8a9                	j	bb0 <malloc+0xd6>
  hp->s.size = nu;
 b58:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 b5c:	0541                	add	a0,a0,16
 b5e:	efbff0ef          	jal	a58 <free>
  return freep;
 b62:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 b66:	c12d                	beqz	a0,bc8 <malloc+0xee>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 b68:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 b6a:	4798                	lw	a4,8(a5)
 b6c:	02977263          	bgeu	a4,s1,b90 <malloc+0xb6>
    if(p == freep)
 b70:	00093703          	ld	a4,0(s2)
 b74:	853e                	mv	a0,a5
 b76:	fef719e3          	bne	a4,a5,b68 <malloc+0x8e>
  p = sbrk(nu * sizeof(Header));
 b7a:	8552                	mv	a0,s4
 b7c:	967ff0ef          	jal	4e2 <sbrk>
  if(p == SBRK_ERROR)
 b80:	fd551ce3          	bne	a0,s5,b58 <malloc+0x7e>
        return 0;
 b84:	4501                	li	a0,0
 b86:	7902                	ld	s2,32(sp)
 b88:	6a42                	ld	s4,16(sp)
 b8a:	6aa2                	ld	s5,8(sp)
 b8c:	6b02                	ld	s6,0(sp)
 b8e:	a03d                	j	bbc <malloc+0xe2>
 b90:	7902                	ld	s2,32(sp)
 b92:	6a42                	ld	s4,16(sp)
 b94:	6aa2                	ld	s5,8(sp)
 b96:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 b98:	fae48de3          	beq	s1,a4,b52 <malloc+0x78>
        p->s.size -= nunits;
 b9c:	4137073b          	subw	a4,a4,s3
 ba0:	c798                	sw	a4,8(a5)
        p += p->s.size;
 ba2:	02071693          	sll	a3,a4,0x20
 ba6:	01c6d713          	srl	a4,a3,0x1c
 baa:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 bac:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 bb0:	00000717          	auipc	a4,0x0
 bb4:	44a73823          	sd	a0,1104(a4) # 1000 <freep>
      return (void*)(p + 1);
 bb8:	01078513          	add	a0,a5,16
  }
}
 bbc:	70e2                	ld	ra,56(sp)
 bbe:	7442                	ld	s0,48(sp)
 bc0:	74a2                	ld	s1,40(sp)
 bc2:	69e2                	ld	s3,24(sp)
 bc4:	6121                	add	sp,sp,64
 bc6:	8082                	ret
 bc8:	7902                	ld	s2,32(sp)
 bca:	6a42                	ld	s4,16(sp)
 bcc:	6aa2                	ld	s5,8(sp)
 bce:	6b02                	ld	s6,0(sp)
 bd0:	b7f5                	j	bbc <malloc+0xe2>
