
user/_myhttpd:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <send_error>:
  printf("version: %s\n", hr->version);
}

static int
send_error(struct http_request *req, int code)
{
       0:	de010113          	add	sp,sp,-544
       4:	20113c23          	sd	ra,536(sp)
       8:	20813823          	sd	s0,528(sp)
       c:	21213023          	sd	s2,512(sp)
      10:	1400                	add	s0,sp,544
      12:	892a                	mv	s2,a0
  char buf[512];
  int r;

  struct error_messages *e = errors;
  while (e->code != 0 && e->msg != 0) {
      14:	00001697          	auipc	a3,0x1
      18:	4046a683          	lw	a3,1028(a3) # 1418 <errors>
  struct error_messages *e = errors;
      1c:	00001717          	auipc	a4,0x1
      20:	3fc70713          	add	a4,a4,1020 # 1418 <errors>
      break;
    e++;
  }

  if (e->code == 0)
    return -1;
      24:	557d                	li	a0,-1
  while (e->code != 0 && e->msg != 0) {
      26:	ceb5                	beqz	a3,a2 <send_error+0xa2>
      28:	20913423          	sd	s1,520(sp)
      2c:	671c                	ld	a5,8(a4)
      2e:	cf85                	beqz	a5,66 <send_error+0x66>
    if (e->code == code)
      30:	02d58b63          	beq	a1,a3,66 <send_error+0x66>
    e++;
      34:	0741                	add	a4,a4,16
  while (e->code != 0 && e->msg != 0) {
      36:	4314                	lw	a3,0(a4)
      38:	faf5                	bnez	a3,2c <send_error+0x2c>
    return -1;
      3a:	557d                	li	a0,-1
      3c:	20813483          	ld	s1,520(sp)
      40:	a08d                	j	a2 <send_error+0xa2>
  printf("[%d] %s\n", fd, m);
      42:	00001617          	auipc	a2,0x1
      46:	0c660613          	add	a2,a2,198 # 1108 <malloc+0x100>
      4a:	00092583          	lw	a1,0(s2)
      4e:	00001517          	auipc	a0,0x1
      52:	0e250513          	add	a0,a0,226 # 1130 <malloc+0x128>
      56:	00001097          	auipc	ra,0x1
      5a:	d32080e7          	jalr	-718(ra) # d88 <printf>
                          e->code, e->msg, e->code, e->msg);
  if (write(req->fd, buf, r) != r) {
    die(req->fd, "Failed to send bytes to cline");
  }

  return 0;
      5e:	4501                	li	a0,0
}
      60:	20813483          	ld	s1,520(sp)
      64:	a83d                	j	a2 <send_error+0xa2>
  r = snprintf(buf, 512, "HTTP/" HTTP_VERSION" %d %s\r\n"
      66:	6718                	ld	a4,8(a4)
      68:	883a                	mv	a6,a4
      6a:	87b6                	mv	a5,a3
      6c:	00001617          	auipc	a2,0x1
      70:	0d460613          	add	a2,a2,212 # 1140 <malloc+0x138>
      74:	20000593          	li	a1,512
      78:	de040513          	add	a0,s0,-544
      7c:	00001097          	auipc	ra,0x1
      80:	d42080e7          	jalr	-702(ra) # dbe <snprintf>
      84:	84aa                	mv	s1,a0
  if (write(req->fd, buf, r) != r) {
      86:	862a                	mv	a2,a0
      88:	de040593          	add	a1,s0,-544
      8c:	00092503          	lw	a0,0(s2)
      90:	00001097          	auipc	ra,0x1
      94:	8e0080e7          	jalr	-1824(ra) # 970 <write>
      98:	fa9515e3          	bne	a0,s1,42 <send_error+0x42>
  return 0;
      9c:	4501                	li	a0,0
      9e:	20813483          	ld	s1,520(sp)
}
      a2:	21813083          	ld	ra,536(sp)
      a6:	21013403          	ld	s0,528(sp)
      aa:	20013903          	ld	s2,512(sp)
      ae:	22010113          	add	sp,sp,544
      b2:	8082                	ret

00000000000000b4 <main>:
    http_response(&hr);
  // }
}

int main(int argc, char *argv[])
{
      b4:	a4010113          	add	sp,sp,-1472
      b8:	5a113c23          	sd	ra,1464(sp)
      bc:	5a813823          	sd	s0,1456(sp)
      c0:	5c010413          	add	s0,sp,1472

  int fd;
  if ((fd = socket(AF_INET, SOCK_STREAM, 0)) < 0) {
      c4:	4601                	li	a2,0
      c6:	4585                	li	a1,1
      c8:	4501                	li	a0,0
      ca:	00001097          	auipc	ra,0x1
      ce:	92e080e7          	jalr	-1746(ra) # 9f8 <socket>
      d2:	0a054163          	bltz	a0,174 <main+0xc0>
      d6:	59613023          	sd	s6,1408(sp)
      da:	8b2a                	mv	s6,a0
    printf("socket error !!!\n");
    exit(0);
  }
  printf("socket create success\n");
      dc:	00001517          	auipc	a0,0x1
      e0:	0ec50513          	add	a0,a0,236 # 11c8 <malloc+0x1c0>
      e4:	00001097          	auipc	ra,0x1
      e8:	ca4080e7          	jalr	-860(ra) # d88 <printf>

  struct sockaddr_in addr;
  addr.sin_family = AF_INET;
      ec:	f8041c23          	sh	zero,-104(s0)
  addr.sin_addr = INADDR_ANY;
      f0:	f8042e23          	sw	zero,-100(s0)
  addr.sin_port = htons(2222);
      f4:	77ed                	lui	a5,0xffffb
      f6:	e0878793          	add	a5,a5,-504 # ffffffffffffae08 <__global_pointer$+0xffffffffffff91f0>
      fa:	f8f41d23          	sh	a5,-102(s0)

  if (bind(fd, (struct sockaddr *)&addr, sizeof(addr)) < 0) {
      fe:	4621                	li	a2,8
     100:	f9840593          	add	a1,s0,-104
     104:	855a                	mv	a0,s6
     106:	00001097          	auipc	ra,0x1
     10a:	8fa080e7          	jalr	-1798(ra) # a00 <bind>
     10e:	0a054263          	bltz	a0,1b2 <main+0xfe>
     112:	5a913423          	sd	s1,1448(sp)
     116:	5b213023          	sd	s2,1440(sp)
     11a:	59313c23          	sd	s3,1432(sp)
     11e:	59413823          	sd	s4,1424(sp)
     122:	59513423          	sd	s5,1416(sp)
     126:	57713c23          	sd	s7,1400(sp)
     12a:	57813823          	sd	s8,1392(sp)
     12e:	57913423          	sd	s9,1384(sp)
    printf("bind error!\n");
    exit(0);
  }
  printf("bind success\n");
     132:	00001517          	auipc	a0,0x1
     136:	0be50513          	add	a0,a0,190 # 11f0 <malloc+0x1e8>
     13a:	00001097          	auipc	ra,0x1
     13e:	c4e080e7          	jalr	-946(ra) # d88 <printf>
  
  if (listen(fd, 5) < 0) {
     142:	4595                	li	a1,5
     144:	855a                	mv	a0,s6
     146:	00001097          	auipc	ra,0x1
     14a:	8c2080e7          	jalr	-1854(ra) # a08 <listen>
     14e:	08054f63          	bltz	a0,1ec <main+0x138>
    printf("listen error!\n");
    exit(0);
  }
  printf("listen success!\n");
     152:	00001517          	auipc	a0,0x1
     156:	0be50513          	add	a0,a0,190 # 1210 <malloc+0x208>
     15a:	00001097          	auipc	ra,0x1
     15e:	c2e080e7          	jalr	-978(ra) # d88 <printf>
  for (n = 1; n < maxlen; n++) {
     162:	4905                	li	s2,1
     164:	b2b40a13          	add	s4,s0,-1237
     168:	ac840a93          	add	s5,s0,-1336
  while (line[i] != ' ') i++;
     16c:	4b85                	li	s7,1
     16e:	415b8bbb          	subw	s7,s7,s5
     172:	a145                	j	612 <main+0x55e>
     174:	5a913423          	sd	s1,1448(sp)
     178:	5b213023          	sd	s2,1440(sp)
     17c:	59313c23          	sd	s3,1432(sp)
     180:	59413823          	sd	s4,1424(sp)
     184:	59513423          	sd	s5,1416(sp)
     188:	59613023          	sd	s6,1408(sp)
     18c:	57713c23          	sd	s7,1400(sp)
     190:	57813823          	sd	s8,1392(sp)
     194:	57913423          	sd	s9,1384(sp)
    printf("socket error !!!\n");
     198:	00001517          	auipc	a0,0x1
     19c:	01850513          	add	a0,a0,24 # 11b0 <malloc+0x1a8>
     1a0:	00001097          	auipc	ra,0x1
     1a4:	be8080e7          	jalr	-1048(ra) # d88 <printf>
    exit(0);
     1a8:	4501                	li	a0,0
     1aa:	00000097          	auipc	ra,0x0
     1ae:	7a6080e7          	jalr	1958(ra) # 950 <exit>
     1b2:	5a913423          	sd	s1,1448(sp)
     1b6:	5b213023          	sd	s2,1440(sp)
     1ba:	59313c23          	sd	s3,1432(sp)
     1be:	59413823          	sd	s4,1424(sp)
     1c2:	59513423          	sd	s5,1416(sp)
     1c6:	57713c23          	sd	s7,1400(sp)
     1ca:	57813823          	sd	s8,1392(sp)
     1ce:	57913423          	sd	s9,1384(sp)
    printf("bind error!\n");
     1d2:	00001517          	auipc	a0,0x1
     1d6:	00e50513          	add	a0,a0,14 # 11e0 <malloc+0x1d8>
     1da:	00001097          	auipc	ra,0x1
     1de:	bae080e7          	jalr	-1106(ra) # d88 <printf>
    exit(0);
     1e2:	4501                	li	a0,0
     1e4:	00000097          	auipc	ra,0x0
     1e8:	76c080e7          	jalr	1900(ra) # 950 <exit>
    printf("listen error!\n");
     1ec:	00001517          	auipc	a0,0x1
     1f0:	01450513          	add	a0,a0,20 # 1200 <malloc+0x1f8>
     1f4:	00001097          	auipc	ra,0x1
     1f8:	b94080e7          	jalr	-1132(ra) # d88 <printf>
    exit(0);
     1fc:	4501                	li	a0,0
     1fe:	00000097          	auipc	ra,0x0
     202:	752080e7          	jalr	1874(ra) # 950 <exit>
        n++;
     206:	2c05                	addw	s8,s8,1
  *bufp = 0;
     208:	00048023          	sb	zero,0(s1)
    if (n <= 0) {
     20c:	2b895663          	bge	s2,s8,4b8 <main+0x404>
    memset(&hr, 0, sizeof(hr));
     210:	04c00613          	li	a2,76
     214:	4581                	li	a1,0
     216:	a7840513          	add	a0,s0,-1416
     21a:	00000097          	auipc	ra,0x0
     21e:	53c080e7          	jalr	1340(ra) # 756 <memset>
    hr.fd = fd;
     222:	a7342c23          	sw	s3,-1416(s0)
  while (line[i] != ' ') i++;
     226:	ac844703          	lbu	a4,-1336(s0)
     22a:	02000793          	li	a5,32
     22e:	2af70363          	beq	a4,a5,4d4 <main+0x420>
     232:	87d6                	mv	a5,s5
     234:	02000693          	li	a3,32
     238:	863e                	mv	a2,a5
     23a:	0785                	add	a5,a5,1
     23c:	0007c703          	lbu	a4,0(a5)
     240:	fed71ce3          	bne	a4,a3,238 <main+0x184>
     244:	00cb84bb          	addw	s1,s7,a2
  memmove(hr->type, line, i);
     248:	8626                	mv	a2,s1
     24a:	85d6                	mv	a1,s5
     24c:	a7c40513          	add	a0,s0,-1412
     250:	00000097          	auipc	ra,0x0
     254:	64e080e7          	jalr	1614(ra) # 89e <memmove>
  printf("type: %s\n", hr->type);
     258:	a7c40593          	add	a1,s0,-1412
     25c:	00001517          	auipc	a0,0x1
     260:	03450513          	add	a0,a0,52 # 1290 <malloc+0x288>
     264:	00001097          	auipc	ra,0x1
     268:	b24080e7          	jalr	-1244(ra) # d88 <printf>
  i++;
     26c:	0014869b          	addw	a3,s1,1
     270:	0006849b          	sext.w	s1,a3
  while (line[i] != ' ') i++;
     274:	009a85b3          	add	a1,s5,s1
     278:	0005c703          	lbu	a4,0(a1)
     27c:	02000793          	li	a5,32
     280:	00f70d63          	beq	a4,a5,29a <main+0x1e6>
     284:	00148793          	add	a5,s1,1
     288:	97d6                	add	a5,a5,s5
     28a:	02000613          	li	a2,32
     28e:	2485                	addw	s1,s1,1
     290:	0785                	add	a5,a5,1
     292:	fff7c703          	lbu	a4,-1(a5)
     296:	fec71ce3          	bne	a4,a2,28e <main+0x1da>
  memmove(hr->url, line + s, i - s);
     29a:	40d4863b          	subw	a2,s1,a3
     29e:	a8640513          	add	a0,s0,-1402
     2a2:	00000097          	auipc	ra,0x0
     2a6:	5fc080e7          	jalr	1532(ra) # 89e <memmove>
  printf("url: %s\n", hr->url);
     2aa:	a8640593          	add	a1,s0,-1402
     2ae:	00001517          	auipc	a0,0x1
     2b2:	ff250513          	add	a0,a0,-14 # 12a0 <malloc+0x298>
     2b6:	00001097          	auipc	ra,0x1
     2ba:	ad2080e7          	jalr	-1326(ra) # d88 <printf>
  i++;
     2be:	2485                	addw	s1,s1,1
     2c0:	0004861b          	sext.w	a2,s1
  while (line[i] != '\r') i++;
     2c4:	00ca85b3          	add	a1,s5,a2
     2c8:	0005c703          	lbu	a4,0(a1)
     2cc:	47b5                	li	a5,13
     2ce:	00f70c63          	beq	a4,a5,2e6 <main+0x232>
     2d2:	00160793          	add	a5,a2,1
     2d6:	97d6                	add	a5,a5,s5
     2d8:	46b5                	li	a3,13
     2da:	2605                	addw	a2,a2,1
     2dc:	0785                	add	a5,a5,1
     2de:	fff7c703          	lbu	a4,-1(a5)
     2e2:	fed71ce3          	bne	a4,a3,2da <main+0x226>
  memmove(hr->version, line + s, i - s);
     2e6:	9e05                	subw	a2,a2,s1
     2e8:	ab840513          	add	a0,s0,-1352
     2ec:	00000097          	auipc	ra,0x0
     2f0:	5b2080e7          	jalr	1458(ra) # 89e <memmove>
  printf("version: %s\n", hr->version);
     2f4:	ab840593          	add	a1,s0,-1352
     2f8:	00001517          	auipc	a0,0x1
     2fc:	fb850513          	add	a0,a0,-72 # 12b0 <malloc+0x2a8>
     300:	00001097          	auipc	ra,0x1
     304:	a88080e7          	jalr	-1400(ra) # d88 <printf>
  if (strcmp(req->type, "GET") != 0) {
     308:	00001597          	auipc	a1,0x1
     30c:	fb858593          	add	a1,a1,-72 # 12c0 <malloc+0x2b8>
     310:	a7c40513          	add	a0,s0,-1412
     314:	00000097          	auipc	ra,0x0
     318:	3be080e7          	jalr	958(ra) # 6d2 <strcmp>
     31c:	1a051e63          	bnez	a0,4d8 <main+0x424>
  char filepath[100] = {0};
     320:	b2043823          	sd	zero,-1232(s0)
     324:	b2043c23          	sd	zero,-1224(s0)
     328:	b4043023          	sd	zero,-1216(s0)
     32c:	b4043423          	sd	zero,-1208(s0)
     330:	b4043823          	sd	zero,-1200(s0)
     334:	b4043c23          	sd	zero,-1192(s0)
     338:	b6043023          	sd	zero,-1184(s0)
     33c:	b6043423          	sd	zero,-1176(s0)
     340:	b6043823          	sd	zero,-1168(s0)
     344:	b6043c23          	sd	zero,-1160(s0)
     348:	b8043023          	sd	zero,-1152(s0)
     34c:	b8043423          	sd	zero,-1144(s0)
     350:	b8042823          	sw	zero,-1136(s0)
  int len = strlen(req->url);
     354:	a8640513          	add	a0,s0,-1402
     358:	00000097          	auipc	ra,0x0
     35c:	3a6080e7          	jalr	934(ra) # 6fe <strlen>
     360:	0005049b          	sext.w	s1,a0
  memmove(filepath, req->url, len);
     364:	8626                	mv	a2,s1
     366:	a8640593          	add	a1,s0,-1402
     36a:	b3040513          	add	a0,s0,-1232
     36e:	00000097          	auipc	ra,0x0
     372:	530080e7          	jalr	1328(ra) # 89e <memmove>
  if (req->url[len - 1] == '/')
     376:	fff4879b          	addw	a5,s1,-1
     37a:	fa078793          	add	a5,a5,-96
     37e:	97a2                	add	a5,a5,s0
     380:	ae67c703          	lbu	a4,-1306(a5)
     384:	02f00793          	li	a5,47
     388:	16f70163          	beq	a4,a5,4ea <main+0x436>
  if((filefd = open(filepath, 0)) < 0){
     38c:	4581                	li	a1,0
     38e:	b3040513          	add	a0,s0,-1232
     392:	00000097          	auipc	ra,0x0
     396:	5fe080e7          	jalr	1534(ra) # 990 <open>
     39a:	8c2a                	mv	s8,a0
     39c:	16054463          	bltz	a0,504 <main+0x450>
  if(fstat(filefd, &st) < 0){
     3a0:	a6040593          	add	a1,s0,-1440
     3a4:	00000097          	auipc	ra,0x0
     3a8:	604080e7          	jalr	1540(ra) # 9a8 <fstat>
     3ac:	18054163          	bltz	a0,52e <main+0x47a>
  if (st.type == T_DIR) {
     3b0:	a6841783          	lh	a5,-1432(s0)
     3b4:	1b278763          	beq	a5,s2,562 <main+0x4ae>
  } else if (st.type == T_FILE) {
     3b8:	4709                	li	a4,2
     3ba:	24e79763          	bne	a5,a4,608 <main+0x554>
  while (h->code != 0 && h->header != 0) {
     3be:	00001797          	auipc	a5,0x1
     3c2:	07a7a783          	lw	a5,122(a5) # 1438 <headers>
  struct responce_header *h = headers;
     3c6:	00001497          	auipc	s1,0x1
     3ca:	07248493          	add	s1,s1,114 # 1438 <headers>
    if (h->code == code)
     3ce:	0c800693          	li	a3,200
  while (h->code != 0 && h->header != 0) {
     3d2:	cb81                	beqz	a5,3e2 <main+0x32e>
     3d4:	6498                	ld	a4,8(s1)
     3d6:	c711                	beqz	a4,3e2 <main+0x32e>
    if (h->code == code)
     3d8:	00d78563          	beq	a5,a3,3e2 <main+0x32e>
    h++;
     3dc:	04c1                	add	s1,s1,16
  while (h->code != 0 && h->header != 0) {
     3de:	409c                	lw	a5,0(s1)
     3e0:	fbf5                	bnez	a5,3d4 <main+0x320>
  int len = strlen(h->header);
     3e2:	6488                	ld	a0,8(s1)
     3e4:	00000097          	auipc	ra,0x0
     3e8:	31a080e7          	jalr	794(ra) # 6fe <strlen>
     3ec:	00050c9b          	sext.w	s9,a0
  if (write(req->fd, h->header, len) != len)
     3f0:	8666                	mv	a2,s9
     3f2:	648c                	ld	a1,8(s1)
     3f4:	a7842503          	lw	a0,-1416(s0)
     3f8:	00000097          	auipc	ra,0x0
     3fc:	578080e7          	jalr	1400(ra) # 970 <write>
     400:	18ac9b63          	bne	s9,a0,596 <main+0x4e2>
  int r = snprintf(buf, 64, "Content-Length: %d\r\n", size);
     404:	a7042683          	lw	a3,-1424(s0)
     408:	00001617          	auipc	a2,0x1
     40c:	f1860613          	add	a2,a2,-232 # 1320 <malloc+0x318>
     410:	04000593          	li	a1,64
     414:	b9840513          	add	a0,s0,-1128
     418:	00001097          	auipc	ra,0x1
     41c:	9a6080e7          	jalr	-1626(ra) # dbe <snprintf>
     420:	84aa                	mv	s1,a0
  if (write(req->fd, buf, r) != r)
     422:	862a                	mv	a2,a0
     424:	b9840593          	add	a1,s0,-1128
     428:	a7842503          	lw	a0,-1416(s0)
     42c:	00000097          	auipc	ra,0x0
     430:	544080e7          	jalr	1348(ra) # 970 <write>
     434:	18a49063          	bne	s1,a0,5b4 <main+0x500>
  int fin_len = strlen(fin);
     438:	00001517          	auipc	a0,0x1
     43c:	f0050513          	add	a0,a0,-256 # 1338 <malloc+0x330>
     440:	00000097          	auipc	ra,0x0
     444:	2be080e7          	jalr	702(ra) # 6fe <strlen>
     448:	0005049b          	sext.w	s1,a0
  if (write(req->fd, fin, fin_len) != fin_len)
     44c:	8626                	mv	a2,s1
     44e:	00001597          	auipc	a1,0x1
     452:	eea58593          	add	a1,a1,-278 # 1338 <malloc+0x330>
     456:	a7842503          	lw	a0,-1416(s0)
     45a:	00000097          	auipc	ra,0x0
     45e:	516080e7          	jalr	1302(ra) # 970 <write>
     462:	16a49863          	bne	s1,a0,5d2 <main+0x51e>
    while ((n = read(filefd, buf, sizeof(buf))) > 0) {
     466:	40000613          	li	a2,1024
     46a:	b9840593          	add	a1,s0,-1128
     46e:	8562                	mv	a0,s8
     470:	00000097          	auipc	ra,0x0
     474:	4f8080e7          	jalr	1272(ra) # 968 <read>
     478:	84aa                	mv	s1,a0
     47a:	16a05b63          	blez	a0,5f0 <main+0x53c>
      if (write(req->fd, buf, n) != n)
     47e:	8626                	mv	a2,s1
     480:	b9840593          	add	a1,s0,-1128
     484:	a7842503          	lw	a0,-1416(s0)
     488:	00000097          	auipc	ra,0x0
     48c:	4e8080e7          	jalr	1256(ra) # 970 <write>
     490:	fca48be3          	beq	s1,a0,466 <main+0x3b2>
  printf("[%d] %s\n", fd, m);
     494:	00001617          	auipc	a2,0x1
     498:	c7460613          	add	a2,a2,-908 # 1108 <malloc+0x100>
     49c:	a7842583          	lw	a1,-1416(s0)
     4a0:	00001517          	auipc	a0,0x1
     4a4:	c9050513          	add	a0,a0,-880 # 1130 <malloc+0x128>
     4a8:	00001097          	auipc	ra,0x1
     4ac:	8e0080e7          	jalr	-1824(ra) # d88 <printf>
}
     4b0:	bf5d                	j	466 <main+0x3b2>
    } else if (rc == 0) {
     4b2:	e119                	bnez	a0,4b8 <main+0x404>
      if (n == 1)
     4b4:	d52c1ae3          	bne	s8,s2,208 <main+0x154>
  printf("[%d] %s\n", fd, m);
     4b8:	00001617          	auipc	a2,0x1
     4bc:	dc860613          	add	a2,a2,-568 # 1280 <malloc+0x278>
     4c0:	85ce                	mv	a1,s3
     4c2:	00001517          	auipc	a0,0x1
     4c6:	c6e50513          	add	a0,a0,-914 # 1130 <malloc+0x128>
     4ca:	00001097          	auipc	ra,0x1
     4ce:	8be080e7          	jalr	-1858(ra) # d88 <printf>
}
     4d2:	bb3d                	j	210 <main+0x15c>
  int i = 0, s = 0;
     4d4:	4481                	li	s1,0
     4d6:	bb8d                	j	248 <main+0x194>
    send_error(req, 400);
     4d8:	19000593          	li	a1,400
     4dc:	a7840513          	add	a0,s0,-1416
     4e0:	00000097          	auipc	ra,0x0
     4e4:	b20080e7          	jalr	-1248(ra) # 0 <send_error>
    return;
     4e8:	a205                	j	608 <main+0x554>
    strcat(filepath + len, DEFAULT_FILE);
     4ea:	00001597          	auipc	a1,0x1
     4ee:	dde58593          	add	a1,a1,-546 # 12c8 <malloc+0x2c0>
     4f2:	b3040793          	add	a5,s0,-1232
     4f6:	00978533          	add	a0,a5,s1
     4fa:	00000097          	auipc	ra,0x0
     4fe:	22e080e7          	jalr	558(ra) # 728 <strcat>
     502:	b569                	j	38c <main+0x2d8>
    printf("[%d] cannot open %s\n", req->fd, filepath);
     504:	b3040613          	add	a2,s0,-1232
     508:	a7842583          	lw	a1,-1416(s0)
     50c:	00001517          	auipc	a0,0x1
     510:	dcc50513          	add	a0,a0,-564 # 12d8 <malloc+0x2d0>
     514:	00001097          	auipc	ra,0x1
     518:	874080e7          	jalr	-1932(ra) # d88 <printf>
    send_error(req, 404);
     51c:	19400593          	li	a1,404
     520:	a7840513          	add	a0,s0,-1416
     524:	00000097          	auipc	ra,0x0
     528:	adc080e7          	jalr	-1316(ra) # 0 <send_error>
    return -1;
     52c:	a8f1                	j	608 <main+0x554>
    printf("[%d] cannot stat %s\n", req->fd, filepath);
     52e:	b3040613          	add	a2,s0,-1232
     532:	a7842583          	lw	a1,-1416(s0)
     536:	00001517          	auipc	a0,0x1
     53a:	dba50513          	add	a0,a0,-582 # 12f0 <malloc+0x2e8>
     53e:	00001097          	auipc	ra,0x1
     542:	84a080e7          	jalr	-1974(ra) # d88 <printf>
    send_error(req, 404);
     546:	19400593          	li	a1,404
     54a:	a7840513          	add	a0,s0,-1416
     54e:	00000097          	auipc	ra,0x0
     552:	ab2080e7          	jalr	-1358(ra) # 0 <send_error>
    close(filefd);
     556:	8562                	mv	a0,s8
     558:	00000097          	auipc	ra,0x0
     55c:	420080e7          	jalr	1056(ra) # 978 <close>
    return -1;
     560:	a065                	j	608 <main+0x554>
    printf("[%d] path:%s is a dir\n", req->fd, filepath);
     562:	b3040613          	add	a2,s0,-1232
     566:	a7842583          	lw	a1,-1416(s0)
     56a:	00001517          	auipc	a0,0x1
     56e:	d9e50513          	add	a0,a0,-610 # 1308 <malloc+0x300>
     572:	00001097          	auipc	ra,0x1
     576:	816080e7          	jalr	-2026(ra) # d88 <printf>
    send_error(req, 404);
     57a:	19400593          	li	a1,404
     57e:	a7840513          	add	a0,s0,-1416
     582:	00000097          	auipc	ra,0x0
     586:	a7e080e7          	jalr	-1410(ra) # 0 <send_error>
    close(filefd);
     58a:	8562                	mv	a0,s8
     58c:	00000097          	auipc	ra,0x0
     590:	3ec080e7          	jalr	1004(ra) # 978 <close>
    return -1;
     594:	a895                	j	608 <main+0x554>
  printf("[%d] %s\n", fd, m);
     596:	00001617          	auipc	a2,0x1
     59a:	b7260613          	add	a2,a2,-1166 # 1108 <malloc+0x100>
     59e:	a7842583          	lw	a1,-1416(s0)
     5a2:	00001517          	auipc	a0,0x1
     5a6:	b8e50513          	add	a0,a0,-1138 # 1130 <malloc+0x128>
     5aa:	00000097          	auipc	ra,0x0
     5ae:	7de080e7          	jalr	2014(ra) # d88 <printf>
}
     5b2:	bd89                	j	404 <main+0x350>
  printf("[%d] %s\n", fd, m);
     5b4:	00001617          	auipc	a2,0x1
     5b8:	b5460613          	add	a2,a2,-1196 # 1108 <malloc+0x100>
     5bc:	a7842583          	lw	a1,-1416(s0)
     5c0:	00001517          	auipc	a0,0x1
     5c4:	b7050513          	add	a0,a0,-1168 # 1130 <malloc+0x128>
     5c8:	00000097          	auipc	ra,0x0
     5cc:	7c0080e7          	jalr	1984(ra) # d88 <printf>
}
     5d0:	b5a5                	j	438 <main+0x384>
  printf("[%d] %s\n", fd, m);
     5d2:	00001617          	auipc	a2,0x1
     5d6:	b3660613          	add	a2,a2,-1226 # 1108 <malloc+0x100>
     5da:	a7842583          	lw	a1,-1416(s0)
     5de:	00001517          	auipc	a0,0x1
     5e2:	b5250513          	add	a0,a0,-1198 # 1130 <malloc+0x128>
     5e6:	00000097          	auipc	ra,0x0
     5ea:	7a2080e7          	jalr	1954(ra) # d88 <printf>
}
     5ee:	bda5                	j	466 <main+0x3b2>
    printf("[%d] send file: %s\n", req->fd, filepath);
     5f0:	b3040613          	add	a2,s0,-1232
     5f4:	a7842583          	lw	a1,-1416(s0)
     5f8:	00001517          	auipc	a0,0x1
     5fc:	d4850513          	add	a0,a0,-696 # 1340 <malloc+0x338>
     600:	00000097          	auipc	ra,0x0
     604:	788080e7          	jalr	1928(ra) # d88 <printf>

      //close(clientfd);
      //exit(0);
    //}
    
    close(clientfd);
     608:	854e                	mv	a0,s3
     60a:	00000097          	auipc	ra,0x0
     60e:	36e080e7          	jalr	878(ra) # 978 <close>
    printf("waiting accept...\n");
     612:	00001517          	auipc	a0,0x1
     616:	c1650513          	add	a0,a0,-1002 # 1228 <malloc+0x220>
     61a:	00000097          	auipc	ra,0x0
     61e:	76e080e7          	jalr	1902(ra) # d88 <printf>
    int clientfd = accept(fd, &clientsa, &salen);
     622:	a4c40613          	add	a2,s0,-1460
     626:	a5040593          	add	a1,s0,-1456
     62a:	855a                	mv	a0,s6
     62c:	00000097          	auipc	ra,0x0
     630:	3e6080e7          	jalr	998(ra) # a12 <accept>
     634:	89aa                	mv	s3,a0
      printf("[%d] accept a client!\n", clientfd);
     636:	85aa                	mv	a1,a0
     638:	00001517          	auipc	a0,0x1
     63c:	c0850513          	add	a0,a0,-1016 # 1240 <malloc+0x238>
     640:	00000097          	auipc	ra,0x0
     644:	748080e7          	jalr	1864(ra) # d88 <printf>
// endianness support
//

static inline uint16 bswaps(uint16 val)
{
  return (((val & 0x00ffU) << 8) |
     648:	a5245803          	lhu	a6,-1454(s0)
     64c:	0088179b          	sllw	a5,a6,0x8
     650:	00885813          	srl	a6,a6,0x8
     654:	00f86833          	or	a6,a6,a5
      printf("[%d] client ip: %d:%d:%d:%d  port: %d\n", clientfd, ptr[0], ptr[1], ptr[2], ptr[3], htons(si->sin_port));
     658:	1842                	sll	a6,a6,0x30
     65a:	03085813          	srl	a6,a6,0x30
     65e:	a5744783          	lbu	a5,-1449(s0)
     662:	a5644703          	lbu	a4,-1450(s0)
     666:	a5544683          	lbu	a3,-1451(s0)
     66a:	a5444603          	lbu	a2,-1452(s0)
     66e:	85ce                	mv	a1,s3
     670:	00001517          	auipc	a0,0x1
     674:	be850513          	add	a0,a0,-1048 # 1258 <malloc+0x250>
     678:	00000097          	auipc	ra,0x0
     67c:	710080e7          	jalr	1808(ra) # d88 <printf>
  for (n = 1; n < maxlen; n++) {
     680:	8c4a                	mv	s8,s2
  char c, *bufp = buf;
     682:	ac840493          	add	s1,s0,-1336
      if (c == '\n') {
     686:	4ca9                	li	s9,10
    if ((rc = read(fd, &c, 1)) == 1) {
     688:	864a                	mv	a2,s2
     68a:	b9840593          	add	a1,s0,-1128
     68e:	854e                	mv	a0,s3
     690:	00000097          	auipc	ra,0x0
     694:	2d8080e7          	jalr	728(ra) # 968 <read>
     698:	e1251de3          	bne	a0,s2,4b2 <main+0x3fe>
      *bufp++ = c;
     69c:	0485                	add	s1,s1,1
     69e:	b9844783          	lbu	a5,-1128(s0)
     6a2:	fef48fa3          	sb	a5,-1(s1)
      if (c == '\n') {
     6a6:	b79780e3          	beq	a5,s9,206 <main+0x152>
  for (n = 1; n < maxlen; n++) {
     6aa:	2c05                	addw	s8,s8,1
     6ac:	fd449ee3          	bne	s1,s4,688 <main+0x5d4>
     6b0:	b2b40493          	add	s1,s0,-1237
     6b4:	be91                	j	208 <main+0x154>

00000000000006b6 <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
     6b6:	1141                	add	sp,sp,-16
     6b8:	e422                	sd	s0,8(sp)
     6ba:	0800                	add	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
     6bc:	87aa                	mv	a5,a0
     6be:	0585                	add	a1,a1,1
     6c0:	0785                	add	a5,a5,1
     6c2:	fff5c703          	lbu	a4,-1(a1)
     6c6:	fee78fa3          	sb	a4,-1(a5)
     6ca:	fb75                	bnez	a4,6be <strcpy+0x8>
    ;
  return os;
}
     6cc:	6422                	ld	s0,8(sp)
     6ce:	0141                	add	sp,sp,16
     6d0:	8082                	ret

00000000000006d2 <strcmp>:

int
strcmp(const char *p, const char *q)
{
     6d2:	1141                	add	sp,sp,-16
     6d4:	e422                	sd	s0,8(sp)
     6d6:	0800                	add	s0,sp,16
  while(*p && *p == *q)
     6d8:	00054783          	lbu	a5,0(a0)
     6dc:	cb91                	beqz	a5,6f0 <strcmp+0x1e>
     6de:	0005c703          	lbu	a4,0(a1)
     6e2:	00f71763          	bne	a4,a5,6f0 <strcmp+0x1e>
    p++, q++;
     6e6:	0505                	add	a0,a0,1
     6e8:	0585                	add	a1,a1,1
  while(*p && *p == *q)
     6ea:	00054783          	lbu	a5,0(a0)
     6ee:	fbe5                	bnez	a5,6de <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
     6f0:	0005c503          	lbu	a0,0(a1)
}
     6f4:	40a7853b          	subw	a0,a5,a0
     6f8:	6422                	ld	s0,8(sp)
     6fa:	0141                	add	sp,sp,16
     6fc:	8082                	ret

00000000000006fe <strlen>:

uint
strlen(const char *s)
{
     6fe:	1141                	add	sp,sp,-16
     700:	e422                	sd	s0,8(sp)
     702:	0800                	add	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
     704:	00054783          	lbu	a5,0(a0)
     708:	cf91                	beqz	a5,724 <strlen+0x26>
     70a:	0505                	add	a0,a0,1
     70c:	87aa                	mv	a5,a0
     70e:	86be                	mv	a3,a5
     710:	0785                	add	a5,a5,1
     712:	fff7c703          	lbu	a4,-1(a5)
     716:	ff65                	bnez	a4,70e <strlen+0x10>
     718:	40a6853b          	subw	a0,a3,a0
     71c:	2505                	addw	a0,a0,1
    ;
  return n;
}
     71e:	6422                	ld	s0,8(sp)
     720:	0141                	add	sp,sp,16
     722:	8082                	ret
  for(n = 0; s[n]; n++)
     724:	4501                	li	a0,0
     726:	bfe5                	j	71e <strlen+0x20>

0000000000000728 <strcat>:

char *
strcat(char *dst, char *src)
{
     728:	1141                	add	sp,sp,-16
     72a:	e422                	sd	s0,8(sp)
     72c:	0800                	add	s0,sp,16
  char *s = dst;
  while (*dst)
     72e:	00054783          	lbu	a5,0(a0)
     732:	c385                	beqz	a5,752 <strcat+0x2a>
     734:	87aa                	mv	a5,a0
    dst++;
     736:	0785                	add	a5,a5,1
  while (*dst)
     738:	0007c703          	lbu	a4,0(a5)
     73c:	ff6d                	bnez	a4,736 <strcat+0xe>
  while ((*dst++ = *src++) != 0);
     73e:	0585                	add	a1,a1,1
     740:	0785                	add	a5,a5,1
     742:	fff5c703          	lbu	a4,-1(a1)
     746:	fee78fa3          	sb	a4,-1(a5)
     74a:	fb75                	bnez	a4,73e <strcat+0x16>

  return s;
}
     74c:	6422                	ld	s0,8(sp)
     74e:	0141                	add	sp,sp,16
     750:	8082                	ret
  while (*dst)
     752:	87aa                	mv	a5,a0
     754:	b7ed                	j	73e <strcat+0x16>

0000000000000756 <memset>:

void*
memset(void *dst, int c, uint n)
{
     756:	1141                	add	sp,sp,-16
     758:	e422                	sd	s0,8(sp)
     75a:	0800                	add	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
     75c:	ca19                	beqz	a2,772 <memset+0x1c>
     75e:	87aa                	mv	a5,a0
     760:	1602                	sll	a2,a2,0x20
     762:	9201                	srl	a2,a2,0x20
     764:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
     768:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
     76c:	0785                	add	a5,a5,1
     76e:	fee79de3          	bne	a5,a4,768 <memset+0x12>
  }
  return dst;
}
     772:	6422                	ld	s0,8(sp)
     774:	0141                	add	sp,sp,16
     776:	8082                	ret

0000000000000778 <strchr>:

char*
strchr(const char *s, char c)
{
     778:	1141                	add	sp,sp,-16
     77a:	e422                	sd	s0,8(sp)
     77c:	0800                	add	s0,sp,16
  for(; *s; s++)
     77e:	00054783          	lbu	a5,0(a0)
     782:	cb99                	beqz	a5,798 <strchr+0x20>
    if(*s == c)
     784:	00f58763          	beq	a1,a5,792 <strchr+0x1a>
  for(; *s; s++)
     788:	0505                	add	a0,a0,1
     78a:	00054783          	lbu	a5,0(a0)
     78e:	fbfd                	bnez	a5,784 <strchr+0xc>
      return (char*)s;
  return 0;
     790:	4501                	li	a0,0
}
     792:	6422                	ld	s0,8(sp)
     794:	0141                	add	sp,sp,16
     796:	8082                	ret
  return 0;
     798:	4501                	li	a0,0
     79a:	bfe5                	j	792 <strchr+0x1a>

000000000000079c <gets>:

char*
gets(char *buf, int max)
{
     79c:	711d                	add	sp,sp,-96
     79e:	ec86                	sd	ra,88(sp)
     7a0:	e8a2                	sd	s0,80(sp)
     7a2:	e4a6                	sd	s1,72(sp)
     7a4:	e0ca                	sd	s2,64(sp)
     7a6:	fc4e                	sd	s3,56(sp)
     7a8:	f852                	sd	s4,48(sp)
     7aa:	f456                	sd	s5,40(sp)
     7ac:	f05a                	sd	s6,32(sp)
     7ae:	ec5e                	sd	s7,24(sp)
     7b0:	1080                	add	s0,sp,96
     7b2:	8baa                	mv	s7,a0
     7b4:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     7b6:	892a                	mv	s2,a0
     7b8:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
     7ba:	4aa9                	li	s5,10
     7bc:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
     7be:	89a6                	mv	s3,s1
     7c0:	2485                	addw	s1,s1,1
     7c2:	0344d863          	bge	s1,s4,7f2 <gets+0x56>
    cc = read(0, &c, 1);
     7c6:	4605                	li	a2,1
     7c8:	faf40593          	add	a1,s0,-81
     7cc:	4501                	li	a0,0
     7ce:	00000097          	auipc	ra,0x0
     7d2:	19a080e7          	jalr	410(ra) # 968 <read>
    if(cc < 1)
     7d6:	00a05e63          	blez	a0,7f2 <gets+0x56>
    buf[i++] = c;
     7da:	faf44783          	lbu	a5,-81(s0)
     7de:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
     7e2:	01578763          	beq	a5,s5,7f0 <gets+0x54>
     7e6:	0905                	add	s2,s2,1
     7e8:	fd679be3          	bne	a5,s6,7be <gets+0x22>
    buf[i++] = c;
     7ec:	89a6                	mv	s3,s1
     7ee:	a011                	j	7f2 <gets+0x56>
     7f0:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
     7f2:	99de                	add	s3,s3,s7
     7f4:	00098023          	sb	zero,0(s3)
  return buf;
}
     7f8:	855e                	mv	a0,s7
     7fa:	60e6                	ld	ra,88(sp)
     7fc:	6446                	ld	s0,80(sp)
     7fe:	64a6                	ld	s1,72(sp)
     800:	6906                	ld	s2,64(sp)
     802:	79e2                	ld	s3,56(sp)
     804:	7a42                	ld	s4,48(sp)
     806:	7aa2                	ld	s5,40(sp)
     808:	7b02                	ld	s6,32(sp)
     80a:	6be2                	ld	s7,24(sp)
     80c:	6125                	add	sp,sp,96
     80e:	8082                	ret

0000000000000810 <stat>:

int
stat(const char *n, struct stat *st)
{
     810:	1101                	add	sp,sp,-32
     812:	ec06                	sd	ra,24(sp)
     814:	e822                	sd	s0,16(sp)
     816:	e04a                	sd	s2,0(sp)
     818:	1000                	add	s0,sp,32
     81a:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     81c:	4581                	li	a1,0
     81e:	00000097          	auipc	ra,0x0
     822:	172080e7          	jalr	370(ra) # 990 <open>
  if(fd < 0)
     826:	02054663          	bltz	a0,852 <stat+0x42>
     82a:	e426                	sd	s1,8(sp)
     82c:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
     82e:	85ca                	mv	a1,s2
     830:	00000097          	auipc	ra,0x0
     834:	178080e7          	jalr	376(ra) # 9a8 <fstat>
     838:	892a                	mv	s2,a0
  close(fd);
     83a:	8526                	mv	a0,s1
     83c:	00000097          	auipc	ra,0x0
     840:	13c080e7          	jalr	316(ra) # 978 <close>
  return r;
     844:	64a2                	ld	s1,8(sp)
}
     846:	854a                	mv	a0,s2
     848:	60e2                	ld	ra,24(sp)
     84a:	6442                	ld	s0,16(sp)
     84c:	6902                	ld	s2,0(sp)
     84e:	6105                	add	sp,sp,32
     850:	8082                	ret
    return -1;
     852:	597d                	li	s2,-1
     854:	bfcd                	j	846 <stat+0x36>

0000000000000856 <atoi>:

int
atoi(const char *s)
{
     856:	1141                	add	sp,sp,-16
     858:	e422                	sd	s0,8(sp)
     85a:	0800                	add	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
     85c:	00054683          	lbu	a3,0(a0)
     860:	fd06879b          	addw	a5,a3,-48
     864:	0ff7f793          	zext.b	a5,a5
     868:	4625                	li	a2,9
     86a:	02f66863          	bltu	a2,a5,89a <atoi+0x44>
     86e:	872a                	mv	a4,a0
  n = 0;
     870:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
     872:	0705                	add	a4,a4,1
     874:	0025179b          	sllw	a5,a0,0x2
     878:	9fa9                	addw	a5,a5,a0
     87a:	0017979b          	sllw	a5,a5,0x1
     87e:	9fb5                	addw	a5,a5,a3
     880:	fd07851b          	addw	a0,a5,-48
  while('0' <= *s && *s <= '9')
     884:	00074683          	lbu	a3,0(a4)
     888:	fd06879b          	addw	a5,a3,-48
     88c:	0ff7f793          	zext.b	a5,a5
     890:	fef671e3          	bgeu	a2,a5,872 <atoi+0x1c>
  return n;
}
     894:	6422                	ld	s0,8(sp)
     896:	0141                	add	sp,sp,16
     898:	8082                	ret
  n = 0;
     89a:	4501                	li	a0,0
     89c:	bfe5                	j	894 <atoi+0x3e>

000000000000089e <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
     89e:	1141                	add	sp,sp,-16
     8a0:	e422                	sd	s0,8(sp)
     8a2:	0800                	add	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
     8a4:	02b57463          	bgeu	a0,a1,8cc <memmove+0x2e>
    while(n-- > 0)
     8a8:	00c05f63          	blez	a2,8c6 <memmove+0x28>
     8ac:	1602                	sll	a2,a2,0x20
     8ae:	9201                	srl	a2,a2,0x20
     8b0:	00c507b3          	add	a5,a0,a2
  dst = vdst;
     8b4:	872a                	mv	a4,a0
      *dst++ = *src++;
     8b6:	0585                	add	a1,a1,1
     8b8:	0705                	add	a4,a4,1
     8ba:	fff5c683          	lbu	a3,-1(a1)
     8be:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
     8c2:	fef71ae3          	bne	a4,a5,8b6 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
     8c6:	6422                	ld	s0,8(sp)
     8c8:	0141                	add	sp,sp,16
     8ca:	8082                	ret
    dst += n;
     8cc:	00c50733          	add	a4,a0,a2
    src += n;
     8d0:	95b2                	add	a1,a1,a2
    while(n-- > 0)
     8d2:	fec05ae3          	blez	a2,8c6 <memmove+0x28>
     8d6:	fff6079b          	addw	a5,a2,-1
     8da:	1782                	sll	a5,a5,0x20
     8dc:	9381                	srl	a5,a5,0x20
     8de:	fff7c793          	not	a5,a5
     8e2:	97ba                	add	a5,a5,a4
      *--dst = *--src;
     8e4:	15fd                	add	a1,a1,-1
     8e6:	177d                	add	a4,a4,-1
     8e8:	0005c683          	lbu	a3,0(a1)
     8ec:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
     8f0:	fee79ae3          	bne	a5,a4,8e4 <memmove+0x46>
     8f4:	bfc9                	j	8c6 <memmove+0x28>

00000000000008f6 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
     8f6:	1141                	add	sp,sp,-16
     8f8:	e422                	sd	s0,8(sp)
     8fa:	0800                	add	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
     8fc:	ca05                	beqz	a2,92c <memcmp+0x36>
     8fe:	fff6069b          	addw	a3,a2,-1
     902:	1682                	sll	a3,a3,0x20
     904:	9281                	srl	a3,a3,0x20
     906:	0685                	add	a3,a3,1
     908:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
     90a:	00054783          	lbu	a5,0(a0)
     90e:	0005c703          	lbu	a4,0(a1)
     912:	00e79863          	bne	a5,a4,922 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
     916:	0505                	add	a0,a0,1
    p2++;
     918:	0585                	add	a1,a1,1
  while (n-- > 0) {
     91a:	fed518e3          	bne	a0,a3,90a <memcmp+0x14>
  }
  return 0;
     91e:	4501                	li	a0,0
     920:	a019                	j	926 <memcmp+0x30>
      return *p1 - *p2;
     922:	40e7853b          	subw	a0,a5,a4
}
     926:	6422                	ld	s0,8(sp)
     928:	0141                	add	sp,sp,16
     92a:	8082                	ret
  return 0;
     92c:	4501                	li	a0,0
     92e:	bfe5                	j	926 <memcmp+0x30>

0000000000000930 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
     930:	1141                	add	sp,sp,-16
     932:	e406                	sd	ra,8(sp)
     934:	e022                	sd	s0,0(sp)
     936:	0800                	add	s0,sp,16
  return memmove(dst, src, n);
     938:	00000097          	auipc	ra,0x0
     93c:	f66080e7          	jalr	-154(ra) # 89e <memmove>
}
     940:	60a2                	ld	ra,8(sp)
     942:	6402                	ld	s0,0(sp)
     944:	0141                	add	sp,sp,16
     946:	8082                	ret

0000000000000948 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
     948:	4885                	li	a7,1
 ecall
     94a:	00000073          	ecall
 ret
     94e:	8082                	ret

0000000000000950 <exit>:
.global exit
exit:
 li a7, SYS_exit
     950:	4889                	li	a7,2
 ecall
     952:	00000073          	ecall
 ret
     956:	8082                	ret

0000000000000958 <wait>:
.global wait
wait:
 li a7, SYS_wait
     958:	488d                	li	a7,3
 ecall
     95a:	00000073          	ecall
 ret
     95e:	8082                	ret

0000000000000960 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
     960:	4891                	li	a7,4
 ecall
     962:	00000073          	ecall
 ret
     966:	8082                	ret

0000000000000968 <read>:
.global read
read:
 li a7, SYS_read
     968:	4895                	li	a7,5
 ecall
     96a:	00000073          	ecall
 ret
     96e:	8082                	ret

0000000000000970 <write>:
.global write
write:
 li a7, SYS_write
     970:	48c1                	li	a7,16
 ecall
     972:	00000073          	ecall
 ret
     976:	8082                	ret

0000000000000978 <close>:
.global close
close:
 li a7, SYS_close
     978:	48d5                	li	a7,21
 ecall
     97a:	00000073          	ecall
 ret
     97e:	8082                	ret

0000000000000980 <kill>:
.global kill
kill:
 li a7, SYS_kill
     980:	4899                	li	a7,6
 ecall
     982:	00000073          	ecall
 ret
     986:	8082                	ret

0000000000000988 <exec>:
.global exec
exec:
 li a7, SYS_exec
     988:	489d                	li	a7,7
 ecall
     98a:	00000073          	ecall
 ret
     98e:	8082                	ret

0000000000000990 <open>:
.global open
open:
 li a7, SYS_open
     990:	48bd                	li	a7,15
 ecall
     992:	00000073          	ecall
 ret
     996:	8082                	ret

0000000000000998 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
     998:	48c5                	li	a7,17
 ecall
     99a:	00000073          	ecall
 ret
     99e:	8082                	ret

00000000000009a0 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
     9a0:	48c9                	li	a7,18
 ecall
     9a2:	00000073          	ecall
 ret
     9a6:	8082                	ret

00000000000009a8 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
     9a8:	48a1                	li	a7,8
 ecall
     9aa:	00000073          	ecall
 ret
     9ae:	8082                	ret

00000000000009b0 <link>:
.global link
link:
 li a7, SYS_link
     9b0:	48cd                	li	a7,19
 ecall
     9b2:	00000073          	ecall
 ret
     9b6:	8082                	ret

00000000000009b8 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
     9b8:	48d1                	li	a7,20
 ecall
     9ba:	00000073          	ecall
 ret
     9be:	8082                	ret

00000000000009c0 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
     9c0:	48a5                	li	a7,9
 ecall
     9c2:	00000073          	ecall
 ret
     9c6:	8082                	ret

00000000000009c8 <dup>:
.global dup
dup:
 li a7, SYS_dup
     9c8:	48a9                	li	a7,10
 ecall
     9ca:	00000073          	ecall
 ret
     9ce:	8082                	ret

00000000000009d0 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
     9d0:	48ad                	li	a7,11
 ecall
     9d2:	00000073          	ecall
 ret
     9d6:	8082                	ret

00000000000009d8 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
     9d8:	48b1                	li	a7,12
 ecall
     9da:	00000073          	ecall
 ret
     9de:	8082                	ret

00000000000009e0 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
     9e0:	48b5                	li	a7,13
 ecall
     9e2:	00000073          	ecall
 ret
     9e6:	8082                	ret

00000000000009e8 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
     9e8:	48b9                	li	a7,14
 ecall
     9ea:	00000073          	ecall
 ret
     9ee:	8082                	ret

00000000000009f0 <uconnect>:
.global uconnect
uconnect:
 li a7, SYS_uconnect
     9f0:	48f5                	li	a7,29
 ecall
     9f2:	00000073          	ecall
 ret
     9f6:	8082                	ret

00000000000009f8 <socket>:
.global socket
socket:
 li a7, SYS_socket
     9f8:	48f9                	li	a7,30
 ecall
     9fa:	00000073          	ecall
 ret
     9fe:	8082                	ret

0000000000000a00 <bind>:
.global bind
bind:
 li a7, SYS_bind
     a00:	48fd                	li	a7,31
 ecall
     a02:	00000073          	ecall
 ret
     a06:	8082                	ret

0000000000000a08 <listen>:
.global listen
listen:
 li a7, SYS_listen
     a08:	02000893          	li	a7,32
 ecall
     a0c:	00000073          	ecall
 ret
     a10:	8082                	ret

0000000000000a12 <accept>:
.global accept
accept:
 li a7, SYS_accept
     a12:	02100893          	li	a7,33
 ecall
     a16:	00000073          	ecall
 ret
     a1a:	8082                	ret

0000000000000a1c <connect>:
.global connect
connect:
 li a7, SYS_connect
     a1c:	02200893          	li	a7,34
 ecall
     a20:	00000073          	ecall
 ret
     a24:	8082                	ret

0000000000000a26 <sprintint>:
  return 1;
}

static int
sprintint(char *s, int xx, int base, int sign)
{
     a26:	1101                	add	sp,sp,-32
     a28:	ec22                	sd	s0,24(sp)
     a2a:	1000                	add	s0,sp,32
     a2c:	882a                	mv	a6,a0
  char buf[16];
  int i, n;
  uint x;

  if(sign && (sign = xx < 0))
     a2e:	c299                	beqz	a3,a34 <sprintint+0xe>
     a30:	0805c263          	bltz	a1,ab4 <sprintint+0x8e>
    x = -xx;
  else
    x = xx;
     a34:	2581                	sext.w	a1,a1
     a36:	4301                	li	t1,0

  i = 0;
     a38:	fe040713          	add	a4,s0,-32
     a3c:	4501                	li	a0,0
  do {
    buf[i++] = digits[x % base];
     a3e:	2601                	sext.w	a2,a2
     a40:	00001697          	auipc	a3,0x1
     a44:	9c068693          	add	a3,a3,-1600 # 1400 <digits>
     a48:	88aa                	mv	a7,a0
     a4a:	2505                	addw	a0,a0,1
     a4c:	02c5f7bb          	remuw	a5,a1,a2
     a50:	1782                	sll	a5,a5,0x20
     a52:	9381                	srl	a5,a5,0x20
     a54:	97b6                	add	a5,a5,a3
     a56:	0007c783          	lbu	a5,0(a5)
     a5a:	00f70023          	sb	a5,0(a4)
  } while((x /= base) != 0);
     a5e:	0005879b          	sext.w	a5,a1
     a62:	02c5d5bb          	divuw	a1,a1,a2
     a66:	0705                	add	a4,a4,1
     a68:	fec7f0e3          	bgeu	a5,a2,a48 <sprintint+0x22>

  if(sign)
     a6c:	00030b63          	beqz	t1,a82 <sprintint+0x5c>
    buf[i++] = '-';
     a70:	ff050793          	add	a5,a0,-16
     a74:	97a2                	add	a5,a5,s0
     a76:	02d00713          	li	a4,45
     a7a:	fee78823          	sb	a4,-16(a5)
     a7e:	0028851b          	addw	a0,a7,2

  n = 0;
  while(--i >= 0)
     a82:	02a05d63          	blez	a0,abc <sprintint+0x96>
     a86:	fe040793          	add	a5,s0,-32
     a8a:	00a78733          	add	a4,a5,a0
     a8e:	87c2                	mv	a5,a6
     a90:	00180613          	add	a2,a6,1
     a94:	fff5069b          	addw	a3,a0,-1
     a98:	1682                	sll	a3,a3,0x20
     a9a:	9281                	srl	a3,a3,0x20
     a9c:	9636                	add	a2,a2,a3
  *s = c;
     a9e:	fff74683          	lbu	a3,-1(a4)
     aa2:	00d78023          	sb	a3,0(a5)
  while(--i >= 0)
     aa6:	177d                	add	a4,a4,-1
     aa8:	0785                	add	a5,a5,1
     aaa:	fec79ae3          	bne	a5,a2,a9e <sprintint+0x78>
    n += sputc(s+n, buf[i]);
  return n;
}
     aae:	6462                	ld	s0,24(sp)
     ab0:	6105                	add	sp,sp,32
     ab2:	8082                	ret
    x = -xx;
     ab4:	40b005bb          	negw	a1,a1
  if(sign && (sign = xx < 0))
     ab8:	4305                	li	t1,1
    x = -xx;
     aba:	bfbd                	j	a38 <sprintint+0x12>
  while(--i >= 0)
     abc:	4501                	li	a0,0
     abe:	bfc5                	j	aae <sprintint+0x88>

0000000000000ac0 <putc>:
{
     ac0:	1101                	add	sp,sp,-32
     ac2:	ec06                	sd	ra,24(sp)
     ac4:	e822                	sd	s0,16(sp)
     ac6:	1000                	add	s0,sp,32
     ac8:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
     acc:	4605                	li	a2,1
     ace:	fef40593          	add	a1,s0,-17
     ad2:	00000097          	auipc	ra,0x0
     ad6:	e9e080e7          	jalr	-354(ra) # 970 <write>
}
     ada:	60e2                	ld	ra,24(sp)
     adc:	6442                	ld	s0,16(sp)
     ade:	6105                	add	sp,sp,32
     ae0:	8082                	ret

0000000000000ae2 <printint>:
{
     ae2:	7139                	add	sp,sp,-64
     ae4:	fc06                	sd	ra,56(sp)
     ae6:	f822                	sd	s0,48(sp)
     ae8:	f426                	sd	s1,40(sp)
     aea:	0080                	add	s0,sp,64
     aec:	84aa                	mv	s1,a0
  if(sgn && xx < 0){
     aee:	c299                	beqz	a3,af4 <printint+0x12>
     af0:	0805cb63          	bltz	a1,b86 <printint+0xa4>
    x = xx;
     af4:	2581                	sext.w	a1,a1
  neg = 0;
     af6:	4881                	li	a7,0
     af8:	fc040693          	add	a3,s0,-64
  i = 0;
     afc:	4701                	li	a4,0
    buf[i++] = digits[x % base];
     afe:	2601                	sext.w	a2,a2
     b00:	00001517          	auipc	a0,0x1
     b04:	90050513          	add	a0,a0,-1792 # 1400 <digits>
     b08:	883a                	mv	a6,a4
     b0a:	2705                	addw	a4,a4,1
     b0c:	02c5f7bb          	remuw	a5,a1,a2
     b10:	1782                	sll	a5,a5,0x20
     b12:	9381                	srl	a5,a5,0x20
     b14:	97aa                	add	a5,a5,a0
     b16:	0007c783          	lbu	a5,0(a5)
     b1a:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
     b1e:	0005879b          	sext.w	a5,a1
     b22:	02c5d5bb          	divuw	a1,a1,a2
     b26:	0685                	add	a3,a3,1
     b28:	fec7f0e3          	bgeu	a5,a2,b08 <printint+0x26>
  if(neg)
     b2c:	00088c63          	beqz	a7,b44 <printint+0x62>
    buf[i++] = '-';
     b30:	fd070793          	add	a5,a4,-48
     b34:	00878733          	add	a4,a5,s0
     b38:	02d00793          	li	a5,45
     b3c:	fef70823          	sb	a5,-16(a4)
     b40:	0028071b          	addw	a4,a6,2
  while(--i >= 0)
     b44:	02e05c63          	blez	a4,b7c <printint+0x9a>
     b48:	f04a                	sd	s2,32(sp)
     b4a:	ec4e                	sd	s3,24(sp)
     b4c:	fc040793          	add	a5,s0,-64
     b50:	00e78933          	add	s2,a5,a4
     b54:	fff78993          	add	s3,a5,-1
     b58:	99ba                	add	s3,s3,a4
     b5a:	377d                	addw	a4,a4,-1
     b5c:	1702                	sll	a4,a4,0x20
     b5e:	9301                	srl	a4,a4,0x20
     b60:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
     b64:	fff94583          	lbu	a1,-1(s2)
     b68:	8526                	mv	a0,s1
     b6a:	00000097          	auipc	ra,0x0
     b6e:	f56080e7          	jalr	-170(ra) # ac0 <putc>
  while(--i >= 0)
     b72:	197d                	add	s2,s2,-1
     b74:	ff3918e3          	bne	s2,s3,b64 <printint+0x82>
     b78:	7902                	ld	s2,32(sp)
     b7a:	69e2                	ld	s3,24(sp)
}
     b7c:	70e2                	ld	ra,56(sp)
     b7e:	7442                	ld	s0,48(sp)
     b80:	74a2                	ld	s1,40(sp)
     b82:	6121                	add	sp,sp,64
     b84:	8082                	ret
    x = -xx;
     b86:	40b005bb          	negw	a1,a1
    neg = 1;
     b8a:	4885                	li	a7,1
    x = -xx;
     b8c:	b7b5                	j	af8 <printint+0x16>

0000000000000b8e <vprintf>:
{
     b8e:	715d                	add	sp,sp,-80
     b90:	e486                	sd	ra,72(sp)
     b92:	e0a2                	sd	s0,64(sp)
     b94:	f84a                	sd	s2,48(sp)
     b96:	0880                	add	s0,sp,80
  for(i = 0; fmt[i]; i++){
     b98:	0005c903          	lbu	s2,0(a1)
     b9c:	1a090a63          	beqz	s2,d50 <vprintf+0x1c2>
     ba0:	fc26                	sd	s1,56(sp)
     ba2:	f44e                	sd	s3,40(sp)
     ba4:	f052                	sd	s4,32(sp)
     ba6:	ec56                	sd	s5,24(sp)
     ba8:	e85a                	sd	s6,16(sp)
     baa:	e45e                	sd	s7,8(sp)
     bac:	8aaa                	mv	s5,a0
     bae:	8bb2                	mv	s7,a2
     bb0:	00158493          	add	s1,a1,1
  state = 0;
     bb4:	4981                	li	s3,0
    } else if(state == '%'){
     bb6:	02500a13          	li	s4,37
     bba:	4b55                	li	s6,21
     bbc:	a839                	j	bda <vprintf+0x4c>
        putc(fd, c);
     bbe:	85ca                	mv	a1,s2
     bc0:	8556                	mv	a0,s5
     bc2:	00000097          	auipc	ra,0x0
     bc6:	efe080e7          	jalr	-258(ra) # ac0 <putc>
     bca:	a019                	j	bd0 <vprintf+0x42>
    } else if(state == '%'){
     bcc:	01498d63          	beq	s3,s4,be6 <vprintf+0x58>
  for(i = 0; fmt[i]; i++){
     bd0:	0485                	add	s1,s1,1
     bd2:	fff4c903          	lbu	s2,-1(s1)
     bd6:	16090763          	beqz	s2,d44 <vprintf+0x1b6>
    if(state == 0){
     bda:	fe0999e3          	bnez	s3,bcc <vprintf+0x3e>
      if(c == '%'){
     bde:	ff4910e3          	bne	s2,s4,bbe <vprintf+0x30>
        state = '%';
     be2:	89d2                	mv	s3,s4
     be4:	b7f5                	j	bd0 <vprintf+0x42>
      if(c == 'd'){
     be6:	13490463          	beq	s2,s4,d0e <vprintf+0x180>
     bea:	f9d9079b          	addw	a5,s2,-99
     bee:	0ff7f793          	zext.b	a5,a5
     bf2:	12fb6763          	bltu	s6,a5,d20 <vprintf+0x192>
     bf6:	f9d9079b          	addw	a5,s2,-99
     bfa:	0ff7f713          	zext.b	a4,a5
     bfe:	12eb6163          	bltu	s6,a4,d20 <vprintf+0x192>
     c02:	00271793          	sll	a5,a4,0x2
     c06:	00000717          	auipc	a4,0x0
     c0a:	7a270713          	add	a4,a4,1954 # 13a8 <malloc+0x3a0>
     c0e:	97ba                	add	a5,a5,a4
     c10:	439c                	lw	a5,0(a5)
     c12:	97ba                	add	a5,a5,a4
     c14:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
     c16:	008b8913          	add	s2,s7,8
     c1a:	4685                	li	a3,1
     c1c:	4629                	li	a2,10
     c1e:	000ba583          	lw	a1,0(s7)
     c22:	8556                	mv	a0,s5
     c24:	00000097          	auipc	ra,0x0
     c28:	ebe080e7          	jalr	-322(ra) # ae2 <printint>
     c2c:	8bca                	mv	s7,s2
      state = 0;
     c2e:	4981                	li	s3,0
     c30:	b745                	j	bd0 <vprintf+0x42>
        printint(fd, va_arg(ap, uint64), 10, 0);
     c32:	008b8913          	add	s2,s7,8
     c36:	4681                	li	a3,0
     c38:	4629                	li	a2,10
     c3a:	000ba583          	lw	a1,0(s7)
     c3e:	8556                	mv	a0,s5
     c40:	00000097          	auipc	ra,0x0
     c44:	ea2080e7          	jalr	-350(ra) # ae2 <printint>
     c48:	8bca                	mv	s7,s2
      state = 0;
     c4a:	4981                	li	s3,0
     c4c:	b751                	j	bd0 <vprintf+0x42>
        printint(fd, va_arg(ap, int), 16, 0);
     c4e:	008b8913          	add	s2,s7,8
     c52:	4681                	li	a3,0
     c54:	4641                	li	a2,16
     c56:	000ba583          	lw	a1,0(s7)
     c5a:	8556                	mv	a0,s5
     c5c:	00000097          	auipc	ra,0x0
     c60:	e86080e7          	jalr	-378(ra) # ae2 <printint>
     c64:	8bca                	mv	s7,s2
      state = 0;
     c66:	4981                	li	s3,0
     c68:	b7a5                	j	bd0 <vprintf+0x42>
     c6a:	e062                	sd	s8,0(sp)
        printptr(fd, va_arg(ap, uint64));
     c6c:	008b8c13          	add	s8,s7,8
     c70:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
     c74:	03000593          	li	a1,48
     c78:	8556                	mv	a0,s5
     c7a:	00000097          	auipc	ra,0x0
     c7e:	e46080e7          	jalr	-442(ra) # ac0 <putc>
  putc(fd, 'x');
     c82:	07800593          	li	a1,120
     c86:	8556                	mv	a0,s5
     c88:	00000097          	auipc	ra,0x0
     c8c:	e38080e7          	jalr	-456(ra) # ac0 <putc>
     c90:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
     c92:	00000b97          	auipc	s7,0x0
     c96:	76eb8b93          	add	s7,s7,1902 # 1400 <digits>
     c9a:	03c9d793          	srl	a5,s3,0x3c
     c9e:	97de                	add	a5,a5,s7
     ca0:	0007c583          	lbu	a1,0(a5)
     ca4:	8556                	mv	a0,s5
     ca6:	00000097          	auipc	ra,0x0
     caa:	e1a080e7          	jalr	-486(ra) # ac0 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
     cae:	0992                	sll	s3,s3,0x4
     cb0:	397d                	addw	s2,s2,-1
     cb2:	fe0914e3          	bnez	s2,c9a <vprintf+0x10c>
        printptr(fd, va_arg(ap, uint64));
     cb6:	8be2                	mv	s7,s8
      state = 0;
     cb8:	4981                	li	s3,0
     cba:	6c02                	ld	s8,0(sp)
     cbc:	bf11                	j	bd0 <vprintf+0x42>
        s = va_arg(ap, char*);
     cbe:	008b8993          	add	s3,s7,8
     cc2:	000bb903          	ld	s2,0(s7)
        if(s == 0)
     cc6:	02090163          	beqz	s2,ce8 <vprintf+0x15a>
        while(*s != 0){
     cca:	00094583          	lbu	a1,0(s2)
     cce:	c9a5                	beqz	a1,d3e <vprintf+0x1b0>
          putc(fd, *s);
     cd0:	8556                	mv	a0,s5
     cd2:	00000097          	auipc	ra,0x0
     cd6:	dee080e7          	jalr	-530(ra) # ac0 <putc>
          s++;
     cda:	0905                	add	s2,s2,1
        while(*s != 0){
     cdc:	00094583          	lbu	a1,0(s2)
     ce0:	f9e5                	bnez	a1,cd0 <vprintf+0x142>
        s = va_arg(ap, char*);
     ce2:	8bce                	mv	s7,s3
      state = 0;
     ce4:	4981                	li	s3,0
     ce6:	b5ed                	j	bd0 <vprintf+0x42>
          s = "(null)";
     ce8:	00000917          	auipc	s2,0x0
     cec:	6b890913          	add	s2,s2,1720 # 13a0 <malloc+0x398>
        while(*s != 0){
     cf0:	02800593          	li	a1,40
     cf4:	bff1                	j	cd0 <vprintf+0x142>
        putc(fd, va_arg(ap, uint));
     cf6:	008b8913          	add	s2,s7,8
     cfa:	000bc583          	lbu	a1,0(s7)
     cfe:	8556                	mv	a0,s5
     d00:	00000097          	auipc	ra,0x0
     d04:	dc0080e7          	jalr	-576(ra) # ac0 <putc>
     d08:	8bca                	mv	s7,s2
      state = 0;
     d0a:	4981                	li	s3,0
     d0c:	b5d1                	j	bd0 <vprintf+0x42>
        putc(fd, c);
     d0e:	02500593          	li	a1,37
     d12:	8556                	mv	a0,s5
     d14:	00000097          	auipc	ra,0x0
     d18:	dac080e7          	jalr	-596(ra) # ac0 <putc>
      state = 0;
     d1c:	4981                	li	s3,0
     d1e:	bd4d                	j	bd0 <vprintf+0x42>
        putc(fd, '%');
     d20:	02500593          	li	a1,37
     d24:	8556                	mv	a0,s5
     d26:	00000097          	auipc	ra,0x0
     d2a:	d9a080e7          	jalr	-614(ra) # ac0 <putc>
        putc(fd, c);
     d2e:	85ca                	mv	a1,s2
     d30:	8556                	mv	a0,s5
     d32:	00000097          	auipc	ra,0x0
     d36:	d8e080e7          	jalr	-626(ra) # ac0 <putc>
      state = 0;
     d3a:	4981                	li	s3,0
     d3c:	bd51                	j	bd0 <vprintf+0x42>
        s = va_arg(ap, char*);
     d3e:	8bce                	mv	s7,s3
      state = 0;
     d40:	4981                	li	s3,0
     d42:	b579                	j	bd0 <vprintf+0x42>
     d44:	74e2                	ld	s1,56(sp)
     d46:	79a2                	ld	s3,40(sp)
     d48:	7a02                	ld	s4,32(sp)
     d4a:	6ae2                	ld	s5,24(sp)
     d4c:	6b42                	ld	s6,16(sp)
     d4e:	6ba2                	ld	s7,8(sp)
}
     d50:	60a6                	ld	ra,72(sp)
     d52:	6406                	ld	s0,64(sp)
     d54:	7942                	ld	s2,48(sp)
     d56:	6161                	add	sp,sp,80
     d58:	8082                	ret

0000000000000d5a <fprintf>:
{
     d5a:	715d                	add	sp,sp,-80
     d5c:	ec06                	sd	ra,24(sp)
     d5e:	e822                	sd	s0,16(sp)
     d60:	1000                	add	s0,sp,32
     d62:	e010                	sd	a2,0(s0)
     d64:	e414                	sd	a3,8(s0)
     d66:	e818                	sd	a4,16(s0)
     d68:	ec1c                	sd	a5,24(s0)
     d6a:	03043023          	sd	a6,32(s0)
     d6e:	03143423          	sd	a7,40(s0)
  va_start(ap, fmt);
     d72:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
     d76:	8622                	mv	a2,s0
     d78:	00000097          	auipc	ra,0x0
     d7c:	e16080e7          	jalr	-490(ra) # b8e <vprintf>
}
     d80:	60e2                	ld	ra,24(sp)
     d82:	6442                	ld	s0,16(sp)
     d84:	6161                	add	sp,sp,80
     d86:	8082                	ret

0000000000000d88 <printf>:
{
     d88:	711d                	add	sp,sp,-96
     d8a:	ec06                	sd	ra,24(sp)
     d8c:	e822                	sd	s0,16(sp)
     d8e:	1000                	add	s0,sp,32
     d90:	e40c                	sd	a1,8(s0)
     d92:	e810                	sd	a2,16(s0)
     d94:	ec14                	sd	a3,24(s0)
     d96:	f018                	sd	a4,32(s0)
     d98:	f41c                	sd	a5,40(s0)
     d9a:	03043823          	sd	a6,48(s0)
     d9e:	03143c23          	sd	a7,56(s0)
  va_start(ap, fmt);
     da2:	00840613          	add	a2,s0,8
     da6:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
     daa:	85aa                	mv	a1,a0
     dac:	4505                	li	a0,1
     dae:	00000097          	auipc	ra,0x0
     db2:	de0080e7          	jalr	-544(ra) # b8e <vprintf>
}
     db6:	60e2                	ld	ra,24(sp)
     db8:	6442                	ld	s0,16(sp)
     dba:	6125                	add	sp,sp,96
     dbc:	8082                	ret

0000000000000dbe <snprintf>:

int
snprintf(char *buf, int sz, char *fmt, ...)
{
     dbe:	7135                	add	sp,sp,-160
     dc0:	f486                	sd	ra,104(sp)
     dc2:	f0a2                	sd	s0,96(sp)
     dc4:	eca6                	sd	s1,88(sp)
     dc6:	1880                	add	s0,sp,112
     dc8:	e414                	sd	a3,8(s0)
     dca:	e818                	sd	a4,16(s0)
     dcc:	ec1c                	sd	a5,24(s0)
     dce:	03043023          	sd	a6,32(s0)
     dd2:	03143423          	sd	a7,40(s0)
  va_list ap;
  int i, c;
  int off = 0;
  char *s;

  if (fmt == 0)
     dd6:	16060b63          	beqz	a2,f4c <snprintf+0x18e>
     dda:	e8ca                	sd	s2,80(sp)
     ddc:	e4ce                	sd	s3,72(sp)
     dde:	fc56                	sd	s5,56(sp)
     de0:	f85a                	sd	s6,48(sp)
     de2:	8b2a                	mv	s6,a0
     de4:	8aae                	mv	s5,a1
     de6:	89b2                	mv	s3,a2
    return -1;

  va_start(ap, fmt);
     de8:	00840793          	add	a5,s0,8
     dec:	f8f43c23          	sd	a5,-104(s0)
  int off = 0;
     df0:	4481                	li	s1,0
  for(i = 0; off < sz && (c = fmt[i] & 0xff) != 0; i++){
     df2:	4901                	li	s2,0
     df4:	00b05f63          	blez	a1,e12 <snprintf+0x54>
     df8:	e0d2                	sd	s4,64(sp)
     dfa:	f45e                	sd	s7,40(sp)
     dfc:	f062                	sd	s8,32(sp)
     dfe:	ec66                	sd	s9,24(sp)
    if(c != '%'){
     e00:	02500a13          	li	s4,37
      continue;
    }
    c = fmt[++i] & 0xff;
    if(c == 0)
      break;
    switch(c){
     e04:	07300b93          	li	s7,115
     e08:	07800c93          	li	s9,120
     e0c:	06400c13          	li	s8,100
     e10:	a839                	j	e2e <snprintf+0x70>
      off += sputc(buf+off, '%');
      off += sputc(buf+off, c);
      break;
    }
  }
  return off;
     e12:	4481                	li	s1,0
     e14:	6946                	ld	s2,80(sp)
     e16:	69a6                	ld	s3,72(sp)
     e18:	7ae2                	ld	s5,56(sp)
     e1a:	7b42                	ld	s6,48(sp)
     e1c:	a0cd                	j	efe <snprintf+0x140>
  *s = c;
     e1e:	009b0733          	add	a4,s6,s1
     e22:	00f70023          	sb	a5,0(a4)
      off += sputc(buf+off, c);
     e26:	2485                	addw	s1,s1,1
  for(i = 0; off < sz && (c = fmt[i] & 0xff) != 0; i++){
     e28:	2905                	addw	s2,s2,1
     e2a:	1554d563          	bge	s1,s5,f74 <snprintf+0x1b6>
     e2e:	012987b3          	add	a5,s3,s2
     e32:	0007c783          	lbu	a5,0(a5)
     e36:	0007871b          	sext.w	a4,a5
     e3a:	10078063          	beqz	a5,f3a <snprintf+0x17c>
    if(c != '%'){
     e3e:	ff4710e3          	bne	a4,s4,e1e <snprintf+0x60>
    c = fmt[++i] & 0xff;
     e42:	2905                	addw	s2,s2,1
     e44:	012987b3          	add	a5,s3,s2
     e48:	0007c783          	lbu	a5,0(a5)
    if(c == 0)
     e4c:	10078263          	beqz	a5,f50 <snprintf+0x192>
    switch(c){
     e50:	05778c63          	beq	a5,s7,ea8 <snprintf+0xea>
     e54:	02fbe763          	bltu	s7,a5,e82 <snprintf+0xc4>
     e58:	0d478063          	beq	a5,s4,f18 <snprintf+0x15a>
     e5c:	0d879463          	bne	a5,s8,f24 <snprintf+0x166>
      off += sprintint(buf+off, va_arg(ap, int), 10, 1);
     e60:	f9843783          	ld	a5,-104(s0)
     e64:	00878713          	add	a4,a5,8
     e68:	f8e43c23          	sd	a4,-104(s0)
     e6c:	4685                	li	a3,1
     e6e:	4629                	li	a2,10
     e70:	438c                	lw	a1,0(a5)
     e72:	009b0533          	add	a0,s6,s1
     e76:	00000097          	auipc	ra,0x0
     e7a:	bb0080e7          	jalr	-1104(ra) # a26 <sprintint>
     e7e:	9ca9                	addw	s1,s1,a0
      break;
     e80:	b765                	j	e28 <snprintf+0x6a>
    switch(c){
     e82:	0b979163          	bne	a5,s9,f24 <snprintf+0x166>
      off += sprintint(buf+off, va_arg(ap, int), 16, 1);
     e86:	f9843783          	ld	a5,-104(s0)
     e8a:	00878713          	add	a4,a5,8
     e8e:	f8e43c23          	sd	a4,-104(s0)
     e92:	4685                	li	a3,1
     e94:	4641                	li	a2,16
     e96:	438c                	lw	a1,0(a5)
     e98:	009b0533          	add	a0,s6,s1
     e9c:	00000097          	auipc	ra,0x0
     ea0:	b8a080e7          	jalr	-1142(ra) # a26 <sprintint>
     ea4:	9ca9                	addw	s1,s1,a0
      break;
     ea6:	b749                	j	e28 <snprintf+0x6a>
      if((s = va_arg(ap, char*)) == 0)
     ea8:	f9843783          	ld	a5,-104(s0)
     eac:	00878713          	add	a4,a5,8
     eb0:	f8e43c23          	sd	a4,-104(s0)
     eb4:	6388                	ld	a0,0(a5)
     eb6:	c931                	beqz	a0,f0a <snprintf+0x14c>
      for(; *s && off < sz; s++)
     eb8:	00054703          	lbu	a4,0(a0)
     ebc:	d735                	beqz	a4,e28 <snprintf+0x6a>
     ebe:	0b54d263          	bge	s1,s5,f62 <snprintf+0x1a4>
     ec2:	009b06b3          	add	a3,s6,s1
     ec6:	409a863b          	subw	a2,s5,s1
     eca:	1602                	sll	a2,a2,0x20
     ecc:	9201                	srl	a2,a2,0x20
     ece:	962a                	add	a2,a2,a0
     ed0:	87aa                	mv	a5,a0
        off += sputc(buf+off, *s);
     ed2:	0014859b          	addw	a1,s1,1
     ed6:	9d89                	subw	a1,a1,a0
  *s = c;
     ed8:	00e68023          	sb	a4,0(a3)
        off += sputc(buf+off, *s);
     edc:	00f584bb          	addw	s1,a1,a5
      for(; *s && off < sz; s++)
     ee0:	0785                	add	a5,a5,1
     ee2:	0007c703          	lbu	a4,0(a5)
     ee6:	d329                	beqz	a4,e28 <snprintf+0x6a>
     ee8:	0685                	add	a3,a3,1
     eea:	fec797e3          	bne	a5,a2,ed8 <snprintf+0x11a>
     eee:	6946                	ld	s2,80(sp)
     ef0:	69a6                	ld	s3,72(sp)
     ef2:	6a06                	ld	s4,64(sp)
     ef4:	7ae2                	ld	s5,56(sp)
     ef6:	7b42                	ld	s6,48(sp)
     ef8:	7ba2                	ld	s7,40(sp)
     efa:	7c02                	ld	s8,32(sp)
     efc:	6ce2                	ld	s9,24(sp)
     efe:	8526                	mv	a0,s1
     f00:	70a6                	ld	ra,104(sp)
     f02:	7406                	ld	s0,96(sp)
     f04:	64e6                	ld	s1,88(sp)
     f06:	610d                	add	sp,sp,160
     f08:	8082                	ret
      for(; *s && off < sz; s++)
     f0a:	02800713          	li	a4,40
        s = "(null)";
     f0e:	00000517          	auipc	a0,0x0
     f12:	49250513          	add	a0,a0,1170 # 13a0 <malloc+0x398>
     f16:	b765                	j	ebe <snprintf+0x100>
  *s = c;
     f18:	009b07b3          	add	a5,s6,s1
     f1c:	01478023          	sb	s4,0(a5)
      off += sputc(buf+off, '%');
     f20:	2485                	addw	s1,s1,1
      break;
     f22:	b719                	j	e28 <snprintf+0x6a>
  *s = c;
     f24:	009b0733          	add	a4,s6,s1
     f28:	01470023          	sb	s4,0(a4)
      off += sputc(buf+off, c);
     f2c:	0014871b          	addw	a4,s1,1
  *s = c;
     f30:	975a                	add	a4,a4,s6
     f32:	00f70023          	sb	a5,0(a4)
      off += sputc(buf+off, c);
     f36:	2489                	addw	s1,s1,2
      break;
     f38:	bdc5                	j	e28 <snprintf+0x6a>
     f3a:	6946                	ld	s2,80(sp)
     f3c:	69a6                	ld	s3,72(sp)
     f3e:	6a06                	ld	s4,64(sp)
     f40:	7ae2                	ld	s5,56(sp)
     f42:	7b42                	ld	s6,48(sp)
     f44:	7ba2                	ld	s7,40(sp)
     f46:	7c02                	ld	s8,32(sp)
     f48:	6ce2                	ld	s9,24(sp)
     f4a:	bf55                	j	efe <snprintf+0x140>
    return -1;
     f4c:	54fd                	li	s1,-1
     f4e:	bf45                	j	efe <snprintf+0x140>
     f50:	6946                	ld	s2,80(sp)
     f52:	69a6                	ld	s3,72(sp)
     f54:	6a06                	ld	s4,64(sp)
     f56:	7ae2                	ld	s5,56(sp)
     f58:	7b42                	ld	s6,48(sp)
     f5a:	7ba2                	ld	s7,40(sp)
     f5c:	7c02                	ld	s8,32(sp)
     f5e:	6ce2                	ld	s9,24(sp)
     f60:	bf79                	j	efe <snprintf+0x140>
     f62:	6946                	ld	s2,80(sp)
     f64:	69a6                	ld	s3,72(sp)
     f66:	6a06                	ld	s4,64(sp)
     f68:	7ae2                	ld	s5,56(sp)
     f6a:	7b42                	ld	s6,48(sp)
     f6c:	7ba2                	ld	s7,40(sp)
     f6e:	7c02                	ld	s8,32(sp)
     f70:	6ce2                	ld	s9,24(sp)
     f72:	b771                	j	efe <snprintf+0x140>
     f74:	6946                	ld	s2,80(sp)
     f76:	69a6                	ld	s3,72(sp)
     f78:	6a06                	ld	s4,64(sp)
     f7a:	7ae2                	ld	s5,56(sp)
     f7c:	7b42                	ld	s6,48(sp)
     f7e:	7ba2                	ld	s7,40(sp)
     f80:	7c02                	ld	s8,32(sp)
     f82:	6ce2                	ld	s9,24(sp)
     f84:	bfad                	j	efe <snprintf+0x140>

0000000000000f86 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     f86:	1141                	add	sp,sp,-16
     f88:	e422                	sd	s0,8(sp)
     f8a:	0800                	add	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
     f8c:	ff050693          	add	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     f90:	00000797          	auipc	a5,0x0
     f94:	4c87b783          	ld	a5,1224(a5) # 1458 <freep>
     f98:	a02d                	j	fc2 <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
     f9a:	4618                	lw	a4,8(a2)
     f9c:	9f2d                	addw	a4,a4,a1
     f9e:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
     fa2:	6398                	ld	a4,0(a5)
     fa4:	6310                	ld	a2,0(a4)
     fa6:	a83d                	j	fe4 <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
     fa8:	ff852703          	lw	a4,-8(a0)
     fac:	9f31                	addw	a4,a4,a2
     fae:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
     fb0:	ff053683          	ld	a3,-16(a0)
     fb4:	a091                	j	ff8 <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     fb6:	6398                	ld	a4,0(a5)
     fb8:	00e7e463          	bltu	a5,a4,fc0 <free+0x3a>
     fbc:	00e6ea63          	bltu	a3,a4,fd0 <free+0x4a>
{
     fc0:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     fc2:	fed7fae3          	bgeu	a5,a3,fb6 <free+0x30>
     fc6:	6398                	ld	a4,0(a5)
     fc8:	00e6e463          	bltu	a3,a4,fd0 <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     fcc:	fee7eae3          	bltu	a5,a4,fc0 <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
     fd0:	ff852583          	lw	a1,-8(a0)
     fd4:	6390                	ld	a2,0(a5)
     fd6:	02059813          	sll	a6,a1,0x20
     fda:	01c85713          	srl	a4,a6,0x1c
     fde:	9736                	add	a4,a4,a3
     fe0:	fae60de3          	beq	a2,a4,f9a <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
     fe4:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
     fe8:	4790                	lw	a2,8(a5)
     fea:	02061593          	sll	a1,a2,0x20
     fee:	01c5d713          	srl	a4,a1,0x1c
     ff2:	973e                	add	a4,a4,a5
     ff4:	fae68ae3          	beq	a3,a4,fa8 <free+0x22>
    p->s.ptr = bp->s.ptr;
     ff8:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
     ffa:	00000717          	auipc	a4,0x0
     ffe:	44f73f23          	sd	a5,1118(a4) # 1458 <freep>
}
    1002:	6422                	ld	s0,8(sp)
    1004:	0141                	add	sp,sp,16
    1006:	8082                	ret

0000000000001008 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    1008:	7139                	add	sp,sp,-64
    100a:	fc06                	sd	ra,56(sp)
    100c:	f822                	sd	s0,48(sp)
    100e:	f426                	sd	s1,40(sp)
    1010:	ec4e                	sd	s3,24(sp)
    1012:	0080                	add	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1014:	02051493          	sll	s1,a0,0x20
    1018:	9081                	srl	s1,s1,0x20
    101a:	04bd                	add	s1,s1,15
    101c:	8091                	srl	s1,s1,0x4
    101e:	0014899b          	addw	s3,s1,1
    1022:	0485                	add	s1,s1,1
  if((prevp = freep) == 0){
    1024:	00000517          	auipc	a0,0x0
    1028:	43453503          	ld	a0,1076(a0) # 1458 <freep>
    102c:	c915                	beqz	a0,1060 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    102e:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    1030:	4798                	lw	a4,8(a5)
    1032:	08977e63          	bgeu	a4,s1,10ce <malloc+0xc6>
    1036:	f04a                	sd	s2,32(sp)
    1038:	e852                	sd	s4,16(sp)
    103a:	e456                	sd	s5,8(sp)
    103c:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
    103e:	8a4e                	mv	s4,s3
    1040:	0009871b          	sext.w	a4,s3
    1044:	6685                	lui	a3,0x1
    1046:	00d77363          	bgeu	a4,a3,104c <malloc+0x44>
    104a:	6a05                	lui	s4,0x1
    104c:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
    1050:	004a1a1b          	sllw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    1054:	00000917          	auipc	s2,0x0
    1058:	40490913          	add	s2,s2,1028 # 1458 <freep>
  if(p == (char*)-1)
    105c:	5afd                	li	s5,-1
    105e:	a091                	j	10a2 <malloc+0x9a>
    1060:	f04a                	sd	s2,32(sp)
    1062:	e852                	sd	s4,16(sp)
    1064:	e456                	sd	s5,8(sp)
    1066:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
    1068:	00000797          	auipc	a5,0x0
    106c:	3f878793          	add	a5,a5,1016 # 1460 <base>
    1070:	00000717          	auipc	a4,0x0
    1074:	3ef73423          	sd	a5,1000(a4) # 1458 <freep>
    1078:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
    107a:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
    107e:	b7c1                	j	103e <malloc+0x36>
        prevp->s.ptr = p->s.ptr;
    1080:	6398                	ld	a4,0(a5)
    1082:	e118                	sd	a4,0(a0)
    1084:	a08d                	j	10e6 <malloc+0xde>
  hp->s.size = nu;
    1086:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
    108a:	0541                	add	a0,a0,16
    108c:	00000097          	auipc	ra,0x0
    1090:	efa080e7          	jalr	-262(ra) # f86 <free>
  return freep;
    1094:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
    1098:	c13d                	beqz	a0,10fe <malloc+0xf6>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    109a:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    109c:	4798                	lw	a4,8(a5)
    109e:	02977463          	bgeu	a4,s1,10c6 <malloc+0xbe>
    if(p == freep)
    10a2:	00093703          	ld	a4,0(s2)
    10a6:	853e                	mv	a0,a5
    10a8:	fef719e3          	bne	a4,a5,109a <malloc+0x92>
  p = sbrk(nu * sizeof(Header));
    10ac:	8552                	mv	a0,s4
    10ae:	00000097          	auipc	ra,0x0
    10b2:	92a080e7          	jalr	-1750(ra) # 9d8 <sbrk>
  if(p == (char*)-1)
    10b6:	fd5518e3          	bne	a0,s5,1086 <malloc+0x7e>
        return 0;
    10ba:	4501                	li	a0,0
    10bc:	7902                	ld	s2,32(sp)
    10be:	6a42                	ld	s4,16(sp)
    10c0:	6aa2                	ld	s5,8(sp)
    10c2:	6b02                	ld	s6,0(sp)
    10c4:	a03d                	j	10f2 <malloc+0xea>
    10c6:	7902                	ld	s2,32(sp)
    10c8:	6a42                	ld	s4,16(sp)
    10ca:	6aa2                	ld	s5,8(sp)
    10cc:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
    10ce:	fae489e3          	beq	s1,a4,1080 <malloc+0x78>
        p->s.size -= nunits;
    10d2:	4137073b          	subw	a4,a4,s3
    10d6:	c798                	sw	a4,8(a5)
        p += p->s.size;
    10d8:	02071693          	sll	a3,a4,0x20
    10dc:	01c6d713          	srl	a4,a3,0x1c
    10e0:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
    10e2:	0137a423          	sw	s3,8(a5)
      freep = prevp;
    10e6:	00000717          	auipc	a4,0x0
    10ea:	36a73923          	sd	a0,882(a4) # 1458 <freep>
      return (void*)(p + 1);
    10ee:	01078513          	add	a0,a5,16
  }
}
    10f2:	70e2                	ld	ra,56(sp)
    10f4:	7442                	ld	s0,48(sp)
    10f6:	74a2                	ld	s1,40(sp)
    10f8:	69e2                	ld	s3,24(sp)
    10fa:	6121                	add	sp,sp,64
    10fc:	8082                	ret
    10fe:	7902                	ld	s2,32(sp)
    1100:	6a42                	ld	s4,16(sp)
    1102:	6aa2                	ld	s5,8(sp)
    1104:	6b02                	ld	s6,0(sp)
    1106:	b7f5                	j	10f2 <malloc+0xea>
