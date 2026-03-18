
user/_usertests:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <copyinstr1>:
}

// what if you pass ridiculous string pointers to system calls?
void
copyinstr1(char *s)
{
       0:	1141                	add	sp,sp,-16
       2:	e406                	sd	ra,8(sp)
       4:	e022                	sd	s0,0(sp)
       6:	0800                	add	s0,sp,16
  uint64 addrs[] = { 0x80000000LL, 0xffffffffffffffff };

  for(int ai = 0; ai < 2; ai++){
    uint64 addr = addrs[ai];

    int fd = open((char *)addr, O_CREATE|O_WRONLY);
       8:	20100593          	li	a1,513
       c:	4505                	li	a0,1
       e:	057e                	sll	a0,a0,0x1f
      10:	00005097          	auipc	ra,0x5
      14:	6f6080e7          	jalr	1782(ra) # 5706 <open>
    if(fd >= 0){
      18:	02055063          	bgez	a0,38 <copyinstr1+0x38>
    int fd = open((char *)addr, O_CREATE|O_WRONLY);
      1c:	20100593          	li	a1,513
      20:	557d                	li	a0,-1
      22:	00005097          	auipc	ra,0x5
      26:	6e4080e7          	jalr	1764(ra) # 5706 <open>
    if(fd >= 0){
      2a:	55fd                	li	a1,-1
      2c:	00055863          	bgez	a0,3c <copyinstr1+0x3c>
      printf("open(%p) returned %d, not -1\n", addr, fd);
      exit(1);
    }
  }
}
      30:	60a2                	ld	ra,8(sp)
      32:	6402                	ld	s0,0(sp)
      34:	0141                	add	sp,sp,16
      36:	8082                	ret
    uint64 addr = addrs[ai];
      38:	4585                	li	a1,1
      3a:	05fe                	sll	a1,a1,0x1f
      printf("open(%p) returned %d, not -1\n", addr, fd);
      3c:	862a                	mv	a2,a0
      3e:	00006517          	auipc	a0,0x6
      42:	e4250513          	add	a0,a0,-446 # 5e80 <malloc+0x102>
      46:	00006097          	auipc	ra,0x6
      4a:	ab8080e7          	jalr	-1352(ra) # 5afe <printf>
      exit(1);
      4e:	4505                	li	a0,1
      50:	00005097          	auipc	ra,0x5
      54:	676080e7          	jalr	1654(ra) # 56c6 <exit>

0000000000000058 <bsstest>:
void
bsstest(char *s)
{
  int i;

  for(i = 0; i < sizeof(uninit); i++){
      58:	00009797          	auipc	a5,0x9
      5c:	6e878793          	add	a5,a5,1768 # 9740 <uninit>
      60:	0000c697          	auipc	a3,0xc
      64:	df068693          	add	a3,a3,-528 # be50 <buf>
    if(uninit[i] != '\0'){
      68:	0007c703          	lbu	a4,0(a5)
      6c:	e709                	bnez	a4,76 <bsstest+0x1e>
  for(i = 0; i < sizeof(uninit); i++){
      6e:	0785                	add	a5,a5,1
      70:	fed79ce3          	bne	a5,a3,68 <bsstest+0x10>
      74:	8082                	ret
{
      76:	1141                	add	sp,sp,-16
      78:	e406                	sd	ra,8(sp)
      7a:	e022                	sd	s0,0(sp)
      7c:	0800                	add	s0,sp,16
      printf("%s: bss test failed\n", s);
      7e:	85aa                	mv	a1,a0
      80:	00006517          	auipc	a0,0x6
      84:	e2050513          	add	a0,a0,-480 # 5ea0 <malloc+0x122>
      88:	00006097          	auipc	ra,0x6
      8c:	a76080e7          	jalr	-1418(ra) # 5afe <printf>
      exit(1);
      90:	4505                	li	a0,1
      92:	00005097          	auipc	ra,0x5
      96:	634080e7          	jalr	1588(ra) # 56c6 <exit>

000000000000009a <opentest>:
{
      9a:	1101                	add	sp,sp,-32
      9c:	ec06                	sd	ra,24(sp)
      9e:	e822                	sd	s0,16(sp)
      a0:	e426                	sd	s1,8(sp)
      a2:	1000                	add	s0,sp,32
      a4:	84aa                	mv	s1,a0
  fd = open("echo", 0);
      a6:	4581                	li	a1,0
      a8:	00006517          	auipc	a0,0x6
      ac:	e1050513          	add	a0,a0,-496 # 5eb8 <malloc+0x13a>
      b0:	00005097          	auipc	ra,0x5
      b4:	656080e7          	jalr	1622(ra) # 5706 <open>
  if(fd < 0){
      b8:	02054663          	bltz	a0,e4 <opentest+0x4a>
  close(fd);
      bc:	00005097          	auipc	ra,0x5
      c0:	632080e7          	jalr	1586(ra) # 56ee <close>
  fd = open("doesnotexist", 0);
      c4:	4581                	li	a1,0
      c6:	00006517          	auipc	a0,0x6
      ca:	e1250513          	add	a0,a0,-494 # 5ed8 <malloc+0x15a>
      ce:	00005097          	auipc	ra,0x5
      d2:	638080e7          	jalr	1592(ra) # 5706 <open>
  if(fd >= 0){
      d6:	02055563          	bgez	a0,100 <opentest+0x66>
}
      da:	60e2                	ld	ra,24(sp)
      dc:	6442                	ld	s0,16(sp)
      de:	64a2                	ld	s1,8(sp)
      e0:	6105                	add	sp,sp,32
      e2:	8082                	ret
    printf("%s: open echo failed!\n", s);
      e4:	85a6                	mv	a1,s1
      e6:	00006517          	auipc	a0,0x6
      ea:	dda50513          	add	a0,a0,-550 # 5ec0 <malloc+0x142>
      ee:	00006097          	auipc	ra,0x6
      f2:	a10080e7          	jalr	-1520(ra) # 5afe <printf>
    exit(1);
      f6:	4505                	li	a0,1
      f8:	00005097          	auipc	ra,0x5
      fc:	5ce080e7          	jalr	1486(ra) # 56c6 <exit>
    printf("%s: open doesnotexist succeeded!\n", s);
     100:	85a6                	mv	a1,s1
     102:	00006517          	auipc	a0,0x6
     106:	de650513          	add	a0,a0,-538 # 5ee8 <malloc+0x16a>
     10a:	00006097          	auipc	ra,0x6
     10e:	9f4080e7          	jalr	-1548(ra) # 5afe <printf>
    exit(1);
     112:	4505                	li	a0,1
     114:	00005097          	auipc	ra,0x5
     118:	5b2080e7          	jalr	1458(ra) # 56c6 <exit>

000000000000011c <truncate2>:
{
     11c:	7179                	add	sp,sp,-48
     11e:	f406                	sd	ra,40(sp)
     120:	f022                	sd	s0,32(sp)
     122:	ec26                	sd	s1,24(sp)
     124:	e84a                	sd	s2,16(sp)
     126:	e44e                	sd	s3,8(sp)
     128:	1800                	add	s0,sp,48
     12a:	89aa                	mv	s3,a0
  unlink("truncfile");
     12c:	00006517          	auipc	a0,0x6
     130:	de450513          	add	a0,a0,-540 # 5f10 <malloc+0x192>
     134:	00005097          	auipc	ra,0x5
     138:	5e2080e7          	jalr	1506(ra) # 5716 <unlink>
  int fd1 = open("truncfile", O_CREATE|O_TRUNC|O_WRONLY);
     13c:	60100593          	li	a1,1537
     140:	00006517          	auipc	a0,0x6
     144:	dd050513          	add	a0,a0,-560 # 5f10 <malloc+0x192>
     148:	00005097          	auipc	ra,0x5
     14c:	5be080e7          	jalr	1470(ra) # 5706 <open>
     150:	84aa                	mv	s1,a0
  write(fd1, "abcd", 4);
     152:	4611                	li	a2,4
     154:	00006597          	auipc	a1,0x6
     158:	dcc58593          	add	a1,a1,-564 # 5f20 <malloc+0x1a2>
     15c:	00005097          	auipc	ra,0x5
     160:	58a080e7          	jalr	1418(ra) # 56e6 <write>
  int fd2 = open("truncfile", O_TRUNC|O_WRONLY);
     164:	40100593          	li	a1,1025
     168:	00006517          	auipc	a0,0x6
     16c:	da850513          	add	a0,a0,-600 # 5f10 <malloc+0x192>
     170:	00005097          	auipc	ra,0x5
     174:	596080e7          	jalr	1430(ra) # 5706 <open>
     178:	892a                	mv	s2,a0
  int n = write(fd1, "x", 1);
     17a:	4605                	li	a2,1
     17c:	00006597          	auipc	a1,0x6
     180:	dac58593          	add	a1,a1,-596 # 5f28 <malloc+0x1aa>
     184:	8526                	mv	a0,s1
     186:	00005097          	auipc	ra,0x5
     18a:	560080e7          	jalr	1376(ra) # 56e6 <write>
  if(n != -1){
     18e:	57fd                	li	a5,-1
     190:	02f51b63          	bne	a0,a5,1c6 <truncate2+0xaa>
  unlink("truncfile");
     194:	00006517          	auipc	a0,0x6
     198:	d7c50513          	add	a0,a0,-644 # 5f10 <malloc+0x192>
     19c:	00005097          	auipc	ra,0x5
     1a0:	57a080e7          	jalr	1402(ra) # 5716 <unlink>
  close(fd1);
     1a4:	8526                	mv	a0,s1
     1a6:	00005097          	auipc	ra,0x5
     1aa:	548080e7          	jalr	1352(ra) # 56ee <close>
  close(fd2);
     1ae:	854a                	mv	a0,s2
     1b0:	00005097          	auipc	ra,0x5
     1b4:	53e080e7          	jalr	1342(ra) # 56ee <close>
}
     1b8:	70a2                	ld	ra,40(sp)
     1ba:	7402                	ld	s0,32(sp)
     1bc:	64e2                	ld	s1,24(sp)
     1be:	6942                	ld	s2,16(sp)
     1c0:	69a2                	ld	s3,8(sp)
     1c2:	6145                	add	sp,sp,48
     1c4:	8082                	ret
    printf("%s: write returned %d, expected -1\n", s, n);
     1c6:	862a                	mv	a2,a0
     1c8:	85ce                	mv	a1,s3
     1ca:	00006517          	auipc	a0,0x6
     1ce:	d6650513          	add	a0,a0,-666 # 5f30 <malloc+0x1b2>
     1d2:	00006097          	auipc	ra,0x6
     1d6:	92c080e7          	jalr	-1748(ra) # 5afe <printf>
    exit(1);
     1da:	4505                	li	a0,1
     1dc:	00005097          	auipc	ra,0x5
     1e0:	4ea080e7          	jalr	1258(ra) # 56c6 <exit>

00000000000001e4 <createtest>:
{
     1e4:	7179                	add	sp,sp,-48
     1e6:	f406                	sd	ra,40(sp)
     1e8:	f022                	sd	s0,32(sp)
     1ea:	ec26                	sd	s1,24(sp)
     1ec:	e84a                	sd	s2,16(sp)
     1ee:	1800                	add	s0,sp,48
  name[0] = 'a';
     1f0:	06100793          	li	a5,97
     1f4:	fcf40c23          	sb	a5,-40(s0)
  name[2] = '\0';
     1f8:	fc040d23          	sb	zero,-38(s0)
     1fc:	03000493          	li	s1,48
  for(i = 0; i < N; i++){
     200:	06400913          	li	s2,100
    name[1] = '0' + i;
     204:	fc940ca3          	sb	s1,-39(s0)
    fd = open(name, O_CREATE|O_RDWR);
     208:	20200593          	li	a1,514
     20c:	fd840513          	add	a0,s0,-40
     210:	00005097          	auipc	ra,0x5
     214:	4f6080e7          	jalr	1270(ra) # 5706 <open>
    close(fd);
     218:	00005097          	auipc	ra,0x5
     21c:	4d6080e7          	jalr	1238(ra) # 56ee <close>
  for(i = 0; i < N; i++){
     220:	2485                	addw	s1,s1,1
     222:	0ff4f493          	zext.b	s1,s1
     226:	fd249fe3          	bne	s1,s2,204 <createtest+0x20>
  name[0] = 'a';
     22a:	06100793          	li	a5,97
     22e:	fcf40c23          	sb	a5,-40(s0)
  name[2] = '\0';
     232:	fc040d23          	sb	zero,-38(s0)
     236:	03000493          	li	s1,48
  for(i = 0; i < N; i++){
     23a:	06400913          	li	s2,100
    name[1] = '0' + i;
     23e:	fc940ca3          	sb	s1,-39(s0)
    unlink(name);
     242:	fd840513          	add	a0,s0,-40
     246:	00005097          	auipc	ra,0x5
     24a:	4d0080e7          	jalr	1232(ra) # 5716 <unlink>
  for(i = 0; i < N; i++){
     24e:	2485                	addw	s1,s1,1
     250:	0ff4f493          	zext.b	s1,s1
     254:	ff2495e3          	bne	s1,s2,23e <createtest+0x5a>
}
     258:	70a2                	ld	ra,40(sp)
     25a:	7402                	ld	s0,32(sp)
     25c:	64e2                	ld	s1,24(sp)
     25e:	6942                	ld	s2,16(sp)
     260:	6145                	add	sp,sp,48
     262:	8082                	ret

0000000000000264 <bigwrite>:
{
     264:	715d                	add	sp,sp,-80
     266:	e486                	sd	ra,72(sp)
     268:	e0a2                	sd	s0,64(sp)
     26a:	fc26                	sd	s1,56(sp)
     26c:	f84a                	sd	s2,48(sp)
     26e:	f44e                	sd	s3,40(sp)
     270:	f052                	sd	s4,32(sp)
     272:	ec56                	sd	s5,24(sp)
     274:	e85a                	sd	s6,16(sp)
     276:	e45e                	sd	s7,8(sp)
     278:	0880                	add	s0,sp,80
     27a:	8baa                	mv	s7,a0
  unlink("bigwrite");
     27c:	00006517          	auipc	a0,0x6
     280:	cdc50513          	add	a0,a0,-804 # 5f58 <malloc+0x1da>
     284:	00005097          	auipc	ra,0x5
     288:	492080e7          	jalr	1170(ra) # 5716 <unlink>
  for(sz = 499; sz < (MAXOPBLOCKS+2)*BSIZE; sz += 471){
     28c:	1f300493          	li	s1,499
    fd = open("bigwrite", O_CREATE | O_RDWR);
     290:	00006a97          	auipc	s5,0x6
     294:	cc8a8a93          	add	s5,s5,-824 # 5f58 <malloc+0x1da>
      int cc = write(fd, buf, sz);
     298:	0000ca17          	auipc	s4,0xc
     29c:	bb8a0a13          	add	s4,s4,-1096 # be50 <buf>
  for(sz = 499; sz < (MAXOPBLOCKS+2)*BSIZE; sz += 471){
     2a0:	6b0d                	lui	s6,0x3
     2a2:	1c9b0b13          	add	s6,s6,457 # 31c9 <subdir+0x11b>
    fd = open("bigwrite", O_CREATE | O_RDWR);
     2a6:	20200593          	li	a1,514
     2aa:	8556                	mv	a0,s5
     2ac:	00005097          	auipc	ra,0x5
     2b0:	45a080e7          	jalr	1114(ra) # 5706 <open>
     2b4:	892a                	mv	s2,a0
    if(fd < 0){
     2b6:	04054d63          	bltz	a0,310 <bigwrite+0xac>
      int cc = write(fd, buf, sz);
     2ba:	8626                	mv	a2,s1
     2bc:	85d2                	mv	a1,s4
     2be:	00005097          	auipc	ra,0x5
     2c2:	428080e7          	jalr	1064(ra) # 56e6 <write>
     2c6:	89aa                	mv	s3,a0
      if(cc != sz){
     2c8:	06a49263          	bne	s1,a0,32c <bigwrite+0xc8>
      int cc = write(fd, buf, sz);
     2cc:	8626                	mv	a2,s1
     2ce:	85d2                	mv	a1,s4
     2d0:	854a                	mv	a0,s2
     2d2:	00005097          	auipc	ra,0x5
     2d6:	414080e7          	jalr	1044(ra) # 56e6 <write>
      if(cc != sz){
     2da:	04951a63          	bne	a0,s1,32e <bigwrite+0xca>
    close(fd);
     2de:	854a                	mv	a0,s2
     2e0:	00005097          	auipc	ra,0x5
     2e4:	40e080e7          	jalr	1038(ra) # 56ee <close>
    unlink("bigwrite");
     2e8:	8556                	mv	a0,s5
     2ea:	00005097          	auipc	ra,0x5
     2ee:	42c080e7          	jalr	1068(ra) # 5716 <unlink>
  for(sz = 499; sz < (MAXOPBLOCKS+2)*BSIZE; sz += 471){
     2f2:	1d74849b          	addw	s1,s1,471
     2f6:	fb6498e3          	bne	s1,s6,2a6 <bigwrite+0x42>
}
     2fa:	60a6                	ld	ra,72(sp)
     2fc:	6406                	ld	s0,64(sp)
     2fe:	74e2                	ld	s1,56(sp)
     300:	7942                	ld	s2,48(sp)
     302:	79a2                	ld	s3,40(sp)
     304:	7a02                	ld	s4,32(sp)
     306:	6ae2                	ld	s5,24(sp)
     308:	6b42                	ld	s6,16(sp)
     30a:	6ba2                	ld	s7,8(sp)
     30c:	6161                	add	sp,sp,80
     30e:	8082                	ret
      printf("%s: cannot create bigwrite\n", s);
     310:	85de                	mv	a1,s7
     312:	00006517          	auipc	a0,0x6
     316:	c5650513          	add	a0,a0,-938 # 5f68 <malloc+0x1ea>
     31a:	00005097          	auipc	ra,0x5
     31e:	7e4080e7          	jalr	2020(ra) # 5afe <printf>
      exit(1);
     322:	4505                	li	a0,1
     324:	00005097          	auipc	ra,0x5
     328:	3a2080e7          	jalr	930(ra) # 56c6 <exit>
      if(cc != sz){
     32c:	89a6                	mv	s3,s1
        printf("%s: write(%d) ret %d\n", s, sz, cc);
     32e:	86aa                	mv	a3,a0
     330:	864e                	mv	a2,s3
     332:	85de                	mv	a1,s7
     334:	00006517          	auipc	a0,0x6
     338:	c5450513          	add	a0,a0,-940 # 5f88 <malloc+0x20a>
     33c:	00005097          	auipc	ra,0x5
     340:	7c2080e7          	jalr	1986(ra) # 5afe <printf>
        exit(1);
     344:	4505                	li	a0,1
     346:	00005097          	auipc	ra,0x5
     34a:	380080e7          	jalr	896(ra) # 56c6 <exit>

000000000000034e <copyin>:
{
     34e:	715d                	add	sp,sp,-80
     350:	e486                	sd	ra,72(sp)
     352:	e0a2                	sd	s0,64(sp)
     354:	fc26                	sd	s1,56(sp)
     356:	f84a                	sd	s2,48(sp)
     358:	f44e                	sd	s3,40(sp)
     35a:	f052                	sd	s4,32(sp)
     35c:	0880                	add	s0,sp,80
  uint64 addrs[] = { 0x80000000LL, 0xffffffffffffffff };
     35e:	4785                	li	a5,1
     360:	07fe                	sll	a5,a5,0x1f
     362:	fcf43023          	sd	a5,-64(s0)
     366:	57fd                	li	a5,-1
     368:	fcf43423          	sd	a5,-56(s0)
  for(int ai = 0; ai < 2; ai++){
     36c:	fc040913          	add	s2,s0,-64
    int fd = open("copyin1", O_CREATE|O_WRONLY);
     370:	00006a17          	auipc	s4,0x6
     374:	c30a0a13          	add	s4,s4,-976 # 5fa0 <malloc+0x222>
    uint64 addr = addrs[ai];
     378:	00093983          	ld	s3,0(s2)
    int fd = open("copyin1", O_CREATE|O_WRONLY);
     37c:	20100593          	li	a1,513
     380:	8552                	mv	a0,s4
     382:	00005097          	auipc	ra,0x5
     386:	384080e7          	jalr	900(ra) # 5706 <open>
     38a:	84aa                	mv	s1,a0
    if(fd < 0){
     38c:	08054863          	bltz	a0,41c <copyin+0xce>
    int n = write(fd, (void*)addr, 8192);
     390:	6609                	lui	a2,0x2
     392:	85ce                	mv	a1,s3
     394:	00005097          	auipc	ra,0x5
     398:	352080e7          	jalr	850(ra) # 56e6 <write>
    if(n >= 0){
     39c:	08055d63          	bgez	a0,436 <copyin+0xe8>
    close(fd);
     3a0:	8526                	mv	a0,s1
     3a2:	00005097          	auipc	ra,0x5
     3a6:	34c080e7          	jalr	844(ra) # 56ee <close>
    unlink("copyin1");
     3aa:	8552                	mv	a0,s4
     3ac:	00005097          	auipc	ra,0x5
     3b0:	36a080e7          	jalr	874(ra) # 5716 <unlink>
    n = write(1, (char*)addr, 8192);
     3b4:	6609                	lui	a2,0x2
     3b6:	85ce                	mv	a1,s3
     3b8:	4505                	li	a0,1
     3ba:	00005097          	auipc	ra,0x5
     3be:	32c080e7          	jalr	812(ra) # 56e6 <write>
    if(n > 0){
     3c2:	08a04963          	bgtz	a0,454 <copyin+0x106>
    if(pipe(fds) < 0){
     3c6:	fb840513          	add	a0,s0,-72
     3ca:	00005097          	auipc	ra,0x5
     3ce:	30c080e7          	jalr	780(ra) # 56d6 <pipe>
     3d2:	0a054063          	bltz	a0,472 <copyin+0x124>
    n = write(fds[1], (char*)addr, 8192);
     3d6:	6609                	lui	a2,0x2
     3d8:	85ce                	mv	a1,s3
     3da:	fbc42503          	lw	a0,-68(s0)
     3de:	00005097          	auipc	ra,0x5
     3e2:	308080e7          	jalr	776(ra) # 56e6 <write>
    if(n > 0){
     3e6:	0aa04363          	bgtz	a0,48c <copyin+0x13e>
    close(fds[0]);
     3ea:	fb842503          	lw	a0,-72(s0)
     3ee:	00005097          	auipc	ra,0x5
     3f2:	300080e7          	jalr	768(ra) # 56ee <close>
    close(fds[1]);
     3f6:	fbc42503          	lw	a0,-68(s0)
     3fa:	00005097          	auipc	ra,0x5
     3fe:	2f4080e7          	jalr	756(ra) # 56ee <close>
  for(int ai = 0; ai < 2; ai++){
     402:	0921                	add	s2,s2,8
     404:	fd040793          	add	a5,s0,-48
     408:	f6f918e3          	bne	s2,a5,378 <copyin+0x2a>
}
     40c:	60a6                	ld	ra,72(sp)
     40e:	6406                	ld	s0,64(sp)
     410:	74e2                	ld	s1,56(sp)
     412:	7942                	ld	s2,48(sp)
     414:	79a2                	ld	s3,40(sp)
     416:	7a02                	ld	s4,32(sp)
     418:	6161                	add	sp,sp,80
     41a:	8082                	ret
      printf("open(copyin1) failed\n");
     41c:	00006517          	auipc	a0,0x6
     420:	b8c50513          	add	a0,a0,-1140 # 5fa8 <malloc+0x22a>
     424:	00005097          	auipc	ra,0x5
     428:	6da080e7          	jalr	1754(ra) # 5afe <printf>
      exit(1);
     42c:	4505                	li	a0,1
     42e:	00005097          	auipc	ra,0x5
     432:	298080e7          	jalr	664(ra) # 56c6 <exit>
      printf("write(fd, %p, 8192) returned %d, not -1\n", addr, n);
     436:	862a                	mv	a2,a0
     438:	85ce                	mv	a1,s3
     43a:	00006517          	auipc	a0,0x6
     43e:	b8650513          	add	a0,a0,-1146 # 5fc0 <malloc+0x242>
     442:	00005097          	auipc	ra,0x5
     446:	6bc080e7          	jalr	1724(ra) # 5afe <printf>
      exit(1);
     44a:	4505                	li	a0,1
     44c:	00005097          	auipc	ra,0x5
     450:	27a080e7          	jalr	634(ra) # 56c6 <exit>
      printf("write(1, %p, 8192) returned %d, not -1 or 0\n", addr, n);
     454:	862a                	mv	a2,a0
     456:	85ce                	mv	a1,s3
     458:	00006517          	auipc	a0,0x6
     45c:	b9850513          	add	a0,a0,-1128 # 5ff0 <malloc+0x272>
     460:	00005097          	auipc	ra,0x5
     464:	69e080e7          	jalr	1694(ra) # 5afe <printf>
      exit(1);
     468:	4505                	li	a0,1
     46a:	00005097          	auipc	ra,0x5
     46e:	25c080e7          	jalr	604(ra) # 56c6 <exit>
      printf("pipe() failed\n");
     472:	00006517          	auipc	a0,0x6
     476:	bae50513          	add	a0,a0,-1106 # 6020 <malloc+0x2a2>
     47a:	00005097          	auipc	ra,0x5
     47e:	684080e7          	jalr	1668(ra) # 5afe <printf>
      exit(1);
     482:	4505                	li	a0,1
     484:	00005097          	auipc	ra,0x5
     488:	242080e7          	jalr	578(ra) # 56c6 <exit>
      printf("write(pipe, %p, 8192) returned %d, not -1 or 0\n", addr, n);
     48c:	862a                	mv	a2,a0
     48e:	85ce                	mv	a1,s3
     490:	00006517          	auipc	a0,0x6
     494:	ba050513          	add	a0,a0,-1120 # 6030 <malloc+0x2b2>
     498:	00005097          	auipc	ra,0x5
     49c:	666080e7          	jalr	1638(ra) # 5afe <printf>
      exit(1);
     4a0:	4505                	li	a0,1
     4a2:	00005097          	auipc	ra,0x5
     4a6:	224080e7          	jalr	548(ra) # 56c6 <exit>

00000000000004aa <copyout>:
{
     4aa:	711d                	add	sp,sp,-96
     4ac:	ec86                	sd	ra,88(sp)
     4ae:	e8a2                	sd	s0,80(sp)
     4b0:	e4a6                	sd	s1,72(sp)
     4b2:	e0ca                	sd	s2,64(sp)
     4b4:	fc4e                	sd	s3,56(sp)
     4b6:	f852                	sd	s4,48(sp)
     4b8:	f456                	sd	s5,40(sp)
     4ba:	1080                	add	s0,sp,96
  uint64 addrs[] = { 0x80000000LL, 0xffffffffffffffff };
     4bc:	4785                	li	a5,1
     4be:	07fe                	sll	a5,a5,0x1f
     4c0:	faf43823          	sd	a5,-80(s0)
     4c4:	57fd                	li	a5,-1
     4c6:	faf43c23          	sd	a5,-72(s0)
  for(int ai = 0; ai < 2; ai++){
     4ca:	fb040913          	add	s2,s0,-80
    int fd = open("XV6-README", 0);
     4ce:	00006a17          	auipc	s4,0x6
     4d2:	b92a0a13          	add	s4,s4,-1134 # 6060 <malloc+0x2e2>
    n = write(fds[1], "x", 1);
     4d6:	00006a97          	auipc	s5,0x6
     4da:	a52a8a93          	add	s5,s5,-1454 # 5f28 <malloc+0x1aa>
    uint64 addr = addrs[ai];
     4de:	00093983          	ld	s3,0(s2)
    int fd = open("XV6-README", 0);
     4e2:	4581                	li	a1,0
     4e4:	8552                	mv	a0,s4
     4e6:	00005097          	auipc	ra,0x5
     4ea:	220080e7          	jalr	544(ra) # 5706 <open>
     4ee:	84aa                	mv	s1,a0
    if(fd < 0){
     4f0:	08054663          	bltz	a0,57c <copyout+0xd2>
    int n = read(fd, (void*)addr, 8192);
     4f4:	6609                	lui	a2,0x2
     4f6:	85ce                	mv	a1,s3
     4f8:	00005097          	auipc	ra,0x5
     4fc:	1e6080e7          	jalr	486(ra) # 56de <read>
    if(n > 0){
     500:	08a04b63          	bgtz	a0,596 <copyout+0xec>
    close(fd);
     504:	8526                	mv	a0,s1
     506:	00005097          	auipc	ra,0x5
     50a:	1e8080e7          	jalr	488(ra) # 56ee <close>
    if(pipe(fds) < 0){
     50e:	fa840513          	add	a0,s0,-88
     512:	00005097          	auipc	ra,0x5
     516:	1c4080e7          	jalr	452(ra) # 56d6 <pipe>
     51a:	08054d63          	bltz	a0,5b4 <copyout+0x10a>
    n = write(fds[1], "x", 1);
     51e:	4605                	li	a2,1
     520:	85d6                	mv	a1,s5
     522:	fac42503          	lw	a0,-84(s0)
     526:	00005097          	auipc	ra,0x5
     52a:	1c0080e7          	jalr	448(ra) # 56e6 <write>
    if(n != 1){
     52e:	4785                	li	a5,1
     530:	08f51f63          	bne	a0,a5,5ce <copyout+0x124>
    n = read(fds[0], (void*)addr, 8192);
     534:	6609                	lui	a2,0x2
     536:	85ce                	mv	a1,s3
     538:	fa842503          	lw	a0,-88(s0)
     53c:	00005097          	auipc	ra,0x5
     540:	1a2080e7          	jalr	418(ra) # 56de <read>
    if(n > 0){
     544:	0aa04263          	bgtz	a0,5e8 <copyout+0x13e>
    close(fds[0]);
     548:	fa842503          	lw	a0,-88(s0)
     54c:	00005097          	auipc	ra,0x5
     550:	1a2080e7          	jalr	418(ra) # 56ee <close>
    close(fds[1]);
     554:	fac42503          	lw	a0,-84(s0)
     558:	00005097          	auipc	ra,0x5
     55c:	196080e7          	jalr	406(ra) # 56ee <close>
  for(int ai = 0; ai < 2; ai++){
     560:	0921                	add	s2,s2,8
     562:	fc040793          	add	a5,s0,-64
     566:	f6f91ce3          	bne	s2,a5,4de <copyout+0x34>
}
     56a:	60e6                	ld	ra,88(sp)
     56c:	6446                	ld	s0,80(sp)
     56e:	64a6                	ld	s1,72(sp)
     570:	6906                	ld	s2,64(sp)
     572:	79e2                	ld	s3,56(sp)
     574:	7a42                	ld	s4,48(sp)
     576:	7aa2                	ld	s5,40(sp)
     578:	6125                	add	sp,sp,96
     57a:	8082                	ret
      printf("open(XV6-README) failed\n");
     57c:	00006517          	auipc	a0,0x6
     580:	af450513          	add	a0,a0,-1292 # 6070 <malloc+0x2f2>
     584:	00005097          	auipc	ra,0x5
     588:	57a080e7          	jalr	1402(ra) # 5afe <printf>
      exit(1);
     58c:	4505                	li	a0,1
     58e:	00005097          	auipc	ra,0x5
     592:	138080e7          	jalr	312(ra) # 56c6 <exit>
      printf("read(fd, %p, 8192) returned %d, not -1 or 0\n", addr, n);
     596:	862a                	mv	a2,a0
     598:	85ce                	mv	a1,s3
     59a:	00006517          	auipc	a0,0x6
     59e:	af650513          	add	a0,a0,-1290 # 6090 <malloc+0x312>
     5a2:	00005097          	auipc	ra,0x5
     5a6:	55c080e7          	jalr	1372(ra) # 5afe <printf>
      exit(1);
     5aa:	4505                	li	a0,1
     5ac:	00005097          	auipc	ra,0x5
     5b0:	11a080e7          	jalr	282(ra) # 56c6 <exit>
      printf("pipe() failed\n");
     5b4:	00006517          	auipc	a0,0x6
     5b8:	a6c50513          	add	a0,a0,-1428 # 6020 <malloc+0x2a2>
     5bc:	00005097          	auipc	ra,0x5
     5c0:	542080e7          	jalr	1346(ra) # 5afe <printf>
      exit(1);
     5c4:	4505                	li	a0,1
     5c6:	00005097          	auipc	ra,0x5
     5ca:	100080e7          	jalr	256(ra) # 56c6 <exit>
      printf("pipe write failed\n");
     5ce:	00006517          	auipc	a0,0x6
     5d2:	af250513          	add	a0,a0,-1294 # 60c0 <malloc+0x342>
     5d6:	00005097          	auipc	ra,0x5
     5da:	528080e7          	jalr	1320(ra) # 5afe <printf>
      exit(1);
     5de:	4505                	li	a0,1
     5e0:	00005097          	auipc	ra,0x5
     5e4:	0e6080e7          	jalr	230(ra) # 56c6 <exit>
      printf("read(pipe, %p, 8192) returned %d, not -1 or 0\n", addr, n);
     5e8:	862a                	mv	a2,a0
     5ea:	85ce                	mv	a1,s3
     5ec:	00006517          	auipc	a0,0x6
     5f0:	aec50513          	add	a0,a0,-1300 # 60d8 <malloc+0x35a>
     5f4:	00005097          	auipc	ra,0x5
     5f8:	50a080e7          	jalr	1290(ra) # 5afe <printf>
      exit(1);
     5fc:	4505                	li	a0,1
     5fe:	00005097          	auipc	ra,0x5
     602:	0c8080e7          	jalr	200(ra) # 56c6 <exit>

0000000000000606 <truncate1>:
{
     606:	711d                	add	sp,sp,-96
     608:	ec86                	sd	ra,88(sp)
     60a:	e8a2                	sd	s0,80(sp)
     60c:	e4a6                	sd	s1,72(sp)
     60e:	e0ca                	sd	s2,64(sp)
     610:	fc4e                	sd	s3,56(sp)
     612:	f852                	sd	s4,48(sp)
     614:	f456                	sd	s5,40(sp)
     616:	1080                	add	s0,sp,96
     618:	8aaa                	mv	s5,a0
  unlink("truncfile");
     61a:	00006517          	auipc	a0,0x6
     61e:	8f650513          	add	a0,a0,-1802 # 5f10 <malloc+0x192>
     622:	00005097          	auipc	ra,0x5
     626:	0f4080e7          	jalr	244(ra) # 5716 <unlink>
  int fd1 = open("truncfile", O_CREATE|O_WRONLY|O_TRUNC);
     62a:	60100593          	li	a1,1537
     62e:	00006517          	auipc	a0,0x6
     632:	8e250513          	add	a0,a0,-1822 # 5f10 <malloc+0x192>
     636:	00005097          	auipc	ra,0x5
     63a:	0d0080e7          	jalr	208(ra) # 5706 <open>
     63e:	84aa                	mv	s1,a0
  write(fd1, "abcd", 4);
     640:	4611                	li	a2,4
     642:	00006597          	auipc	a1,0x6
     646:	8de58593          	add	a1,a1,-1826 # 5f20 <malloc+0x1a2>
     64a:	00005097          	auipc	ra,0x5
     64e:	09c080e7          	jalr	156(ra) # 56e6 <write>
  close(fd1);
     652:	8526                	mv	a0,s1
     654:	00005097          	auipc	ra,0x5
     658:	09a080e7          	jalr	154(ra) # 56ee <close>
  int fd2 = open("truncfile", O_RDONLY);
     65c:	4581                	li	a1,0
     65e:	00006517          	auipc	a0,0x6
     662:	8b250513          	add	a0,a0,-1870 # 5f10 <malloc+0x192>
     666:	00005097          	auipc	ra,0x5
     66a:	0a0080e7          	jalr	160(ra) # 5706 <open>
     66e:	84aa                	mv	s1,a0
  int n = read(fd2, buf, sizeof(buf));
     670:	02000613          	li	a2,32
     674:	fa040593          	add	a1,s0,-96
     678:	00005097          	auipc	ra,0x5
     67c:	066080e7          	jalr	102(ra) # 56de <read>
  if(n != 4){
     680:	4791                	li	a5,4
     682:	0cf51e63          	bne	a0,a5,75e <truncate1+0x158>
  fd1 = open("truncfile", O_WRONLY|O_TRUNC);
     686:	40100593          	li	a1,1025
     68a:	00006517          	auipc	a0,0x6
     68e:	88650513          	add	a0,a0,-1914 # 5f10 <malloc+0x192>
     692:	00005097          	auipc	ra,0x5
     696:	074080e7          	jalr	116(ra) # 5706 <open>
     69a:	89aa                	mv	s3,a0
  int fd3 = open("truncfile", O_RDONLY);
     69c:	4581                	li	a1,0
     69e:	00006517          	auipc	a0,0x6
     6a2:	87250513          	add	a0,a0,-1934 # 5f10 <malloc+0x192>
     6a6:	00005097          	auipc	ra,0x5
     6aa:	060080e7          	jalr	96(ra) # 5706 <open>
     6ae:	892a                	mv	s2,a0
  n = read(fd3, buf, sizeof(buf));
     6b0:	02000613          	li	a2,32
     6b4:	fa040593          	add	a1,s0,-96
     6b8:	00005097          	auipc	ra,0x5
     6bc:	026080e7          	jalr	38(ra) # 56de <read>
     6c0:	8a2a                	mv	s4,a0
  if(n != 0){
     6c2:	ed4d                	bnez	a0,77c <truncate1+0x176>
  n = read(fd2, buf, sizeof(buf));
     6c4:	02000613          	li	a2,32
     6c8:	fa040593          	add	a1,s0,-96
     6cc:	8526                	mv	a0,s1
     6ce:	00005097          	auipc	ra,0x5
     6d2:	010080e7          	jalr	16(ra) # 56de <read>
     6d6:	8a2a                	mv	s4,a0
  if(n != 0){
     6d8:	e971                	bnez	a0,7ac <truncate1+0x1a6>
  write(fd1, "abcdef", 6);
     6da:	4619                	li	a2,6
     6dc:	00006597          	auipc	a1,0x6
     6e0:	a8c58593          	add	a1,a1,-1396 # 6168 <malloc+0x3ea>
     6e4:	854e                	mv	a0,s3
     6e6:	00005097          	auipc	ra,0x5
     6ea:	000080e7          	jalr	ra # 56e6 <write>
  n = read(fd3, buf, sizeof(buf));
     6ee:	02000613          	li	a2,32
     6f2:	fa040593          	add	a1,s0,-96
     6f6:	854a                	mv	a0,s2
     6f8:	00005097          	auipc	ra,0x5
     6fc:	fe6080e7          	jalr	-26(ra) # 56de <read>
  if(n != 6){
     700:	4799                	li	a5,6
     702:	0cf51d63          	bne	a0,a5,7dc <truncate1+0x1d6>
  n = read(fd2, buf, sizeof(buf));
     706:	02000613          	li	a2,32
     70a:	fa040593          	add	a1,s0,-96
     70e:	8526                	mv	a0,s1
     710:	00005097          	auipc	ra,0x5
     714:	fce080e7          	jalr	-50(ra) # 56de <read>
  if(n != 2){
     718:	4789                	li	a5,2
     71a:	0ef51063          	bne	a0,a5,7fa <truncate1+0x1f4>
  unlink("truncfile");
     71e:	00005517          	auipc	a0,0x5
     722:	7f250513          	add	a0,a0,2034 # 5f10 <malloc+0x192>
     726:	00005097          	auipc	ra,0x5
     72a:	ff0080e7          	jalr	-16(ra) # 5716 <unlink>
  close(fd1);
     72e:	854e                	mv	a0,s3
     730:	00005097          	auipc	ra,0x5
     734:	fbe080e7          	jalr	-66(ra) # 56ee <close>
  close(fd2);
     738:	8526                	mv	a0,s1
     73a:	00005097          	auipc	ra,0x5
     73e:	fb4080e7          	jalr	-76(ra) # 56ee <close>
  close(fd3);
     742:	854a                	mv	a0,s2
     744:	00005097          	auipc	ra,0x5
     748:	faa080e7          	jalr	-86(ra) # 56ee <close>
}
     74c:	60e6                	ld	ra,88(sp)
     74e:	6446                	ld	s0,80(sp)
     750:	64a6                	ld	s1,72(sp)
     752:	6906                	ld	s2,64(sp)
     754:	79e2                	ld	s3,56(sp)
     756:	7a42                	ld	s4,48(sp)
     758:	7aa2                	ld	s5,40(sp)
     75a:	6125                	add	sp,sp,96
     75c:	8082                	ret
    printf("%s: read %d bytes, wanted 4\n", s, n);
     75e:	862a                	mv	a2,a0
     760:	85d6                	mv	a1,s5
     762:	00006517          	auipc	a0,0x6
     766:	9a650513          	add	a0,a0,-1626 # 6108 <malloc+0x38a>
     76a:	00005097          	auipc	ra,0x5
     76e:	394080e7          	jalr	916(ra) # 5afe <printf>
    exit(1);
     772:	4505                	li	a0,1
     774:	00005097          	auipc	ra,0x5
     778:	f52080e7          	jalr	-174(ra) # 56c6 <exit>
    printf("aaa fd3=%d\n", fd3);
     77c:	85ca                	mv	a1,s2
     77e:	00006517          	auipc	a0,0x6
     782:	9aa50513          	add	a0,a0,-1622 # 6128 <malloc+0x3aa>
     786:	00005097          	auipc	ra,0x5
     78a:	378080e7          	jalr	888(ra) # 5afe <printf>
    printf("%s: read %d bytes, wanted 0\n", s, n);
     78e:	8652                	mv	a2,s4
     790:	85d6                	mv	a1,s5
     792:	00006517          	auipc	a0,0x6
     796:	9a650513          	add	a0,a0,-1626 # 6138 <malloc+0x3ba>
     79a:	00005097          	auipc	ra,0x5
     79e:	364080e7          	jalr	868(ra) # 5afe <printf>
    exit(1);
     7a2:	4505                	li	a0,1
     7a4:	00005097          	auipc	ra,0x5
     7a8:	f22080e7          	jalr	-222(ra) # 56c6 <exit>
    printf("bbb fd2=%d\n", fd2);
     7ac:	85a6                	mv	a1,s1
     7ae:	00006517          	auipc	a0,0x6
     7b2:	9aa50513          	add	a0,a0,-1622 # 6158 <malloc+0x3da>
     7b6:	00005097          	auipc	ra,0x5
     7ba:	348080e7          	jalr	840(ra) # 5afe <printf>
    printf("%s: read %d bytes, wanted 0\n", s, n);
     7be:	8652                	mv	a2,s4
     7c0:	85d6                	mv	a1,s5
     7c2:	00006517          	auipc	a0,0x6
     7c6:	97650513          	add	a0,a0,-1674 # 6138 <malloc+0x3ba>
     7ca:	00005097          	auipc	ra,0x5
     7ce:	334080e7          	jalr	820(ra) # 5afe <printf>
    exit(1);
     7d2:	4505                	li	a0,1
     7d4:	00005097          	auipc	ra,0x5
     7d8:	ef2080e7          	jalr	-270(ra) # 56c6 <exit>
    printf("%s: read %d bytes, wanted 6\n", s, n);
     7dc:	862a                	mv	a2,a0
     7de:	85d6                	mv	a1,s5
     7e0:	00006517          	auipc	a0,0x6
     7e4:	99050513          	add	a0,a0,-1648 # 6170 <malloc+0x3f2>
     7e8:	00005097          	auipc	ra,0x5
     7ec:	316080e7          	jalr	790(ra) # 5afe <printf>
    exit(1);
     7f0:	4505                	li	a0,1
     7f2:	00005097          	auipc	ra,0x5
     7f6:	ed4080e7          	jalr	-300(ra) # 56c6 <exit>
    printf("%s: read %d bytes, wanted 2\n", s, n);
     7fa:	862a                	mv	a2,a0
     7fc:	85d6                	mv	a1,s5
     7fe:	00006517          	auipc	a0,0x6
     802:	99250513          	add	a0,a0,-1646 # 6190 <malloc+0x412>
     806:	00005097          	auipc	ra,0x5
     80a:	2f8080e7          	jalr	760(ra) # 5afe <printf>
    exit(1);
     80e:	4505                	li	a0,1
     810:	00005097          	auipc	ra,0x5
     814:	eb6080e7          	jalr	-330(ra) # 56c6 <exit>

0000000000000818 <writetest>:
{
     818:	7139                	add	sp,sp,-64
     81a:	fc06                	sd	ra,56(sp)
     81c:	f822                	sd	s0,48(sp)
     81e:	f426                	sd	s1,40(sp)
     820:	f04a                	sd	s2,32(sp)
     822:	ec4e                	sd	s3,24(sp)
     824:	e852                	sd	s4,16(sp)
     826:	e456                	sd	s5,8(sp)
     828:	e05a                	sd	s6,0(sp)
     82a:	0080                	add	s0,sp,64
     82c:	8b2a                	mv	s6,a0
  fd = open("small", O_CREATE|O_RDWR);
     82e:	20200593          	li	a1,514
     832:	00006517          	auipc	a0,0x6
     836:	97e50513          	add	a0,a0,-1666 # 61b0 <malloc+0x432>
     83a:	00005097          	auipc	ra,0x5
     83e:	ecc080e7          	jalr	-308(ra) # 5706 <open>
  if(fd < 0){
     842:	0a054d63          	bltz	a0,8fc <writetest+0xe4>
     846:	892a                	mv	s2,a0
     848:	4481                	li	s1,0
    if(write(fd, "aaaaaaaaaa", SZ) != SZ){
     84a:	00006997          	auipc	s3,0x6
     84e:	98e98993          	add	s3,s3,-1650 # 61d8 <malloc+0x45a>
    if(write(fd, "bbbbbbbbbb", SZ) != SZ){
     852:	00006a97          	auipc	s5,0x6
     856:	9bea8a93          	add	s5,s5,-1602 # 6210 <malloc+0x492>
  for(i = 0; i < N; i++){
     85a:	06400a13          	li	s4,100
    if(write(fd, "aaaaaaaaaa", SZ) != SZ){
     85e:	4629                	li	a2,10
     860:	85ce                	mv	a1,s3
     862:	854a                	mv	a0,s2
     864:	00005097          	auipc	ra,0x5
     868:	e82080e7          	jalr	-382(ra) # 56e6 <write>
     86c:	47a9                	li	a5,10
     86e:	0af51563          	bne	a0,a5,918 <writetest+0x100>
    if(write(fd, "bbbbbbbbbb", SZ) != SZ){
     872:	4629                	li	a2,10
     874:	85d6                	mv	a1,s5
     876:	854a                	mv	a0,s2
     878:	00005097          	auipc	ra,0x5
     87c:	e6e080e7          	jalr	-402(ra) # 56e6 <write>
     880:	47a9                	li	a5,10
     882:	0af51a63          	bne	a0,a5,936 <writetest+0x11e>
  for(i = 0; i < N; i++){
     886:	2485                	addw	s1,s1,1
     888:	fd449be3          	bne	s1,s4,85e <writetest+0x46>
  close(fd);
     88c:	854a                	mv	a0,s2
     88e:	00005097          	auipc	ra,0x5
     892:	e60080e7          	jalr	-416(ra) # 56ee <close>
  fd = open("small", O_RDONLY);
     896:	4581                	li	a1,0
     898:	00006517          	auipc	a0,0x6
     89c:	91850513          	add	a0,a0,-1768 # 61b0 <malloc+0x432>
     8a0:	00005097          	auipc	ra,0x5
     8a4:	e66080e7          	jalr	-410(ra) # 5706 <open>
     8a8:	84aa                	mv	s1,a0
  if(fd < 0){
     8aa:	0a054563          	bltz	a0,954 <writetest+0x13c>
  i = read(fd, buf, N*SZ*2);
     8ae:	7d000613          	li	a2,2000
     8b2:	0000b597          	auipc	a1,0xb
     8b6:	59e58593          	add	a1,a1,1438 # be50 <buf>
     8ba:	00005097          	auipc	ra,0x5
     8be:	e24080e7          	jalr	-476(ra) # 56de <read>
  if(i != N*SZ*2){
     8c2:	7d000793          	li	a5,2000
     8c6:	0af51563          	bne	a0,a5,970 <writetest+0x158>
  close(fd);
     8ca:	8526                	mv	a0,s1
     8cc:	00005097          	auipc	ra,0x5
     8d0:	e22080e7          	jalr	-478(ra) # 56ee <close>
  if(unlink("small") < 0){
     8d4:	00006517          	auipc	a0,0x6
     8d8:	8dc50513          	add	a0,a0,-1828 # 61b0 <malloc+0x432>
     8dc:	00005097          	auipc	ra,0x5
     8e0:	e3a080e7          	jalr	-454(ra) # 5716 <unlink>
     8e4:	0a054463          	bltz	a0,98c <writetest+0x174>
}
     8e8:	70e2                	ld	ra,56(sp)
     8ea:	7442                	ld	s0,48(sp)
     8ec:	74a2                	ld	s1,40(sp)
     8ee:	7902                	ld	s2,32(sp)
     8f0:	69e2                	ld	s3,24(sp)
     8f2:	6a42                	ld	s4,16(sp)
     8f4:	6aa2                	ld	s5,8(sp)
     8f6:	6b02                	ld	s6,0(sp)
     8f8:	6121                	add	sp,sp,64
     8fa:	8082                	ret
    printf("%s: error: creat small failed!\n", s);
     8fc:	85da                	mv	a1,s6
     8fe:	00006517          	auipc	a0,0x6
     902:	8ba50513          	add	a0,a0,-1862 # 61b8 <malloc+0x43a>
     906:	00005097          	auipc	ra,0x5
     90a:	1f8080e7          	jalr	504(ra) # 5afe <printf>
    exit(1);
     90e:	4505                	li	a0,1
     910:	00005097          	auipc	ra,0x5
     914:	db6080e7          	jalr	-586(ra) # 56c6 <exit>
      printf("%s: error: write aa %d new file failed\n", s, i);
     918:	8626                	mv	a2,s1
     91a:	85da                	mv	a1,s6
     91c:	00006517          	auipc	a0,0x6
     920:	8cc50513          	add	a0,a0,-1844 # 61e8 <malloc+0x46a>
     924:	00005097          	auipc	ra,0x5
     928:	1da080e7          	jalr	474(ra) # 5afe <printf>
      exit(1);
     92c:	4505                	li	a0,1
     92e:	00005097          	auipc	ra,0x5
     932:	d98080e7          	jalr	-616(ra) # 56c6 <exit>
      printf("%s: error: write bb %d new file failed\n", s, i);
     936:	8626                	mv	a2,s1
     938:	85da                	mv	a1,s6
     93a:	00006517          	auipc	a0,0x6
     93e:	8e650513          	add	a0,a0,-1818 # 6220 <malloc+0x4a2>
     942:	00005097          	auipc	ra,0x5
     946:	1bc080e7          	jalr	444(ra) # 5afe <printf>
      exit(1);
     94a:	4505                	li	a0,1
     94c:	00005097          	auipc	ra,0x5
     950:	d7a080e7          	jalr	-646(ra) # 56c6 <exit>
    printf("%s: error: open small failed!\n", s);
     954:	85da                	mv	a1,s6
     956:	00006517          	auipc	a0,0x6
     95a:	8f250513          	add	a0,a0,-1806 # 6248 <malloc+0x4ca>
     95e:	00005097          	auipc	ra,0x5
     962:	1a0080e7          	jalr	416(ra) # 5afe <printf>
    exit(1);
     966:	4505                	li	a0,1
     968:	00005097          	auipc	ra,0x5
     96c:	d5e080e7          	jalr	-674(ra) # 56c6 <exit>
    printf("%s: read failed\n", s);
     970:	85da                	mv	a1,s6
     972:	00006517          	auipc	a0,0x6
     976:	8f650513          	add	a0,a0,-1802 # 6268 <malloc+0x4ea>
     97a:	00005097          	auipc	ra,0x5
     97e:	184080e7          	jalr	388(ra) # 5afe <printf>
    exit(1);
     982:	4505                	li	a0,1
     984:	00005097          	auipc	ra,0x5
     988:	d42080e7          	jalr	-702(ra) # 56c6 <exit>
    printf("%s: unlink small failed\n", s);
     98c:	85da                	mv	a1,s6
     98e:	00006517          	auipc	a0,0x6
     992:	8f250513          	add	a0,a0,-1806 # 6280 <malloc+0x502>
     996:	00005097          	auipc	ra,0x5
     99a:	168080e7          	jalr	360(ra) # 5afe <printf>
    exit(1);
     99e:	4505                	li	a0,1
     9a0:	00005097          	auipc	ra,0x5
     9a4:	d26080e7          	jalr	-730(ra) # 56c6 <exit>

00000000000009a8 <writebig>:
{
     9a8:	7139                	add	sp,sp,-64
     9aa:	fc06                	sd	ra,56(sp)
     9ac:	f822                	sd	s0,48(sp)
     9ae:	f426                	sd	s1,40(sp)
     9b0:	f04a                	sd	s2,32(sp)
     9b2:	ec4e                	sd	s3,24(sp)
     9b4:	e852                	sd	s4,16(sp)
     9b6:	e456                	sd	s5,8(sp)
     9b8:	0080                	add	s0,sp,64
     9ba:	8aaa                	mv	s5,a0
  fd = open("big", O_CREATE|O_RDWR);
     9bc:	20200593          	li	a1,514
     9c0:	00006517          	auipc	a0,0x6
     9c4:	8e050513          	add	a0,a0,-1824 # 62a0 <malloc+0x522>
     9c8:	00005097          	auipc	ra,0x5
     9cc:	d3e080e7          	jalr	-706(ra) # 5706 <open>
     9d0:	89aa                	mv	s3,a0
  for(i = 0; i < MAXFILE; i++){
     9d2:	4481                	li	s1,0
    ((int*)buf)[0] = i;
     9d4:	0000b917          	auipc	s2,0xb
     9d8:	47c90913          	add	s2,s2,1148 # be50 <buf>
  for(i = 0; i < MAXFILE; i++){
     9dc:	10c00a13          	li	s4,268
  if(fd < 0){
     9e0:	06054c63          	bltz	a0,a58 <writebig+0xb0>
    ((int*)buf)[0] = i;
     9e4:	00992023          	sw	s1,0(s2)
    if(write(fd, buf, BSIZE) != BSIZE){
     9e8:	40000613          	li	a2,1024
     9ec:	85ca                	mv	a1,s2
     9ee:	854e                	mv	a0,s3
     9f0:	00005097          	auipc	ra,0x5
     9f4:	cf6080e7          	jalr	-778(ra) # 56e6 <write>
     9f8:	40000793          	li	a5,1024
     9fc:	06f51c63          	bne	a0,a5,a74 <writebig+0xcc>
  for(i = 0; i < MAXFILE; i++){
     a00:	2485                	addw	s1,s1,1
     a02:	ff4491e3          	bne	s1,s4,9e4 <writebig+0x3c>
  close(fd);
     a06:	854e                	mv	a0,s3
     a08:	00005097          	auipc	ra,0x5
     a0c:	ce6080e7          	jalr	-794(ra) # 56ee <close>
  fd = open("big", O_RDONLY);
     a10:	4581                	li	a1,0
     a12:	00006517          	auipc	a0,0x6
     a16:	88e50513          	add	a0,a0,-1906 # 62a0 <malloc+0x522>
     a1a:	00005097          	auipc	ra,0x5
     a1e:	cec080e7          	jalr	-788(ra) # 5706 <open>
     a22:	89aa                	mv	s3,a0
  n = 0;
     a24:	4481                	li	s1,0
    i = read(fd, buf, BSIZE);
     a26:	0000b917          	auipc	s2,0xb
     a2a:	42a90913          	add	s2,s2,1066 # be50 <buf>
  if(fd < 0){
     a2e:	06054263          	bltz	a0,a92 <writebig+0xea>
    i = read(fd, buf, BSIZE);
     a32:	40000613          	li	a2,1024
     a36:	85ca                	mv	a1,s2
     a38:	854e                	mv	a0,s3
     a3a:	00005097          	auipc	ra,0x5
     a3e:	ca4080e7          	jalr	-860(ra) # 56de <read>
    if(i == 0){
     a42:	c535                	beqz	a0,aae <writebig+0x106>
    } else if(i != BSIZE){
     a44:	40000793          	li	a5,1024
     a48:	0af51f63          	bne	a0,a5,b06 <writebig+0x15e>
    if(((int*)buf)[0] != n){
     a4c:	00092683          	lw	a3,0(s2)
     a50:	0c969a63          	bne	a3,s1,b24 <writebig+0x17c>
    n++;
     a54:	2485                	addw	s1,s1,1
    i = read(fd, buf, BSIZE);
     a56:	bff1                	j	a32 <writebig+0x8a>
    printf("%s: error: creat big failed!\n", s);
     a58:	85d6                	mv	a1,s5
     a5a:	00006517          	auipc	a0,0x6
     a5e:	84e50513          	add	a0,a0,-1970 # 62a8 <malloc+0x52a>
     a62:	00005097          	auipc	ra,0x5
     a66:	09c080e7          	jalr	156(ra) # 5afe <printf>
    exit(1);
     a6a:	4505                	li	a0,1
     a6c:	00005097          	auipc	ra,0x5
     a70:	c5a080e7          	jalr	-934(ra) # 56c6 <exit>
      printf("%s: error: write big file failed\n", s, i);
     a74:	8626                	mv	a2,s1
     a76:	85d6                	mv	a1,s5
     a78:	00006517          	auipc	a0,0x6
     a7c:	85050513          	add	a0,a0,-1968 # 62c8 <malloc+0x54a>
     a80:	00005097          	auipc	ra,0x5
     a84:	07e080e7          	jalr	126(ra) # 5afe <printf>
      exit(1);
     a88:	4505                	li	a0,1
     a8a:	00005097          	auipc	ra,0x5
     a8e:	c3c080e7          	jalr	-964(ra) # 56c6 <exit>
    printf("%s: error: open big failed!\n", s);
     a92:	85d6                	mv	a1,s5
     a94:	00006517          	auipc	a0,0x6
     a98:	85c50513          	add	a0,a0,-1956 # 62f0 <malloc+0x572>
     a9c:	00005097          	auipc	ra,0x5
     aa0:	062080e7          	jalr	98(ra) # 5afe <printf>
    exit(1);
     aa4:	4505                	li	a0,1
     aa6:	00005097          	auipc	ra,0x5
     aaa:	c20080e7          	jalr	-992(ra) # 56c6 <exit>
      if(n == MAXFILE - 1){
     aae:	10b00793          	li	a5,267
     ab2:	02f48a63          	beq	s1,a5,ae6 <writebig+0x13e>
  close(fd);
     ab6:	854e                	mv	a0,s3
     ab8:	00005097          	auipc	ra,0x5
     abc:	c36080e7          	jalr	-970(ra) # 56ee <close>
  if(unlink("big") < 0){
     ac0:	00005517          	auipc	a0,0x5
     ac4:	7e050513          	add	a0,a0,2016 # 62a0 <malloc+0x522>
     ac8:	00005097          	auipc	ra,0x5
     acc:	c4e080e7          	jalr	-946(ra) # 5716 <unlink>
     ad0:	06054963          	bltz	a0,b42 <writebig+0x19a>
}
     ad4:	70e2                	ld	ra,56(sp)
     ad6:	7442                	ld	s0,48(sp)
     ad8:	74a2                	ld	s1,40(sp)
     ada:	7902                	ld	s2,32(sp)
     adc:	69e2                	ld	s3,24(sp)
     ade:	6a42                	ld	s4,16(sp)
     ae0:	6aa2                	ld	s5,8(sp)
     ae2:	6121                	add	sp,sp,64
     ae4:	8082                	ret
        printf("%s: read only %d blocks from big", s, n);
     ae6:	10b00613          	li	a2,267
     aea:	85d6                	mv	a1,s5
     aec:	00006517          	auipc	a0,0x6
     af0:	82450513          	add	a0,a0,-2012 # 6310 <malloc+0x592>
     af4:	00005097          	auipc	ra,0x5
     af8:	00a080e7          	jalr	10(ra) # 5afe <printf>
        exit(1);
     afc:	4505                	li	a0,1
     afe:	00005097          	auipc	ra,0x5
     b02:	bc8080e7          	jalr	-1080(ra) # 56c6 <exit>
      printf("%s: read failed %d\n", s, i);
     b06:	862a                	mv	a2,a0
     b08:	85d6                	mv	a1,s5
     b0a:	00006517          	auipc	a0,0x6
     b0e:	82e50513          	add	a0,a0,-2002 # 6338 <malloc+0x5ba>
     b12:	00005097          	auipc	ra,0x5
     b16:	fec080e7          	jalr	-20(ra) # 5afe <printf>
      exit(1);
     b1a:	4505                	li	a0,1
     b1c:	00005097          	auipc	ra,0x5
     b20:	baa080e7          	jalr	-1110(ra) # 56c6 <exit>
      printf("%s: read content of block %d is %d\n", s,
     b24:	8626                	mv	a2,s1
     b26:	85d6                	mv	a1,s5
     b28:	00006517          	auipc	a0,0x6
     b2c:	82850513          	add	a0,a0,-2008 # 6350 <malloc+0x5d2>
     b30:	00005097          	auipc	ra,0x5
     b34:	fce080e7          	jalr	-50(ra) # 5afe <printf>
      exit(1);
     b38:	4505                	li	a0,1
     b3a:	00005097          	auipc	ra,0x5
     b3e:	b8c080e7          	jalr	-1140(ra) # 56c6 <exit>
    printf("%s: unlink big failed\n", s);
     b42:	85d6                	mv	a1,s5
     b44:	00006517          	auipc	a0,0x6
     b48:	83450513          	add	a0,a0,-1996 # 6378 <malloc+0x5fa>
     b4c:	00005097          	auipc	ra,0x5
     b50:	fb2080e7          	jalr	-78(ra) # 5afe <printf>
    exit(1);
     b54:	4505                	li	a0,1
     b56:	00005097          	auipc	ra,0x5
     b5a:	b70080e7          	jalr	-1168(ra) # 56c6 <exit>

0000000000000b5e <unlinkread>:
{
     b5e:	7179                	add	sp,sp,-48
     b60:	f406                	sd	ra,40(sp)
     b62:	f022                	sd	s0,32(sp)
     b64:	ec26                	sd	s1,24(sp)
     b66:	e84a                	sd	s2,16(sp)
     b68:	e44e                	sd	s3,8(sp)
     b6a:	1800                	add	s0,sp,48
     b6c:	89aa                	mv	s3,a0
  fd = open("unlinkread", O_CREATE | O_RDWR);
     b6e:	20200593          	li	a1,514
     b72:	00006517          	auipc	a0,0x6
     b76:	81e50513          	add	a0,a0,-2018 # 6390 <malloc+0x612>
     b7a:	00005097          	auipc	ra,0x5
     b7e:	b8c080e7          	jalr	-1140(ra) # 5706 <open>
  if(fd < 0){
     b82:	0e054563          	bltz	a0,c6c <unlinkread+0x10e>
     b86:	84aa                	mv	s1,a0
  write(fd, "hello", SZ);
     b88:	4615                	li	a2,5
     b8a:	00006597          	auipc	a1,0x6
     b8e:	83658593          	add	a1,a1,-1994 # 63c0 <malloc+0x642>
     b92:	00005097          	auipc	ra,0x5
     b96:	b54080e7          	jalr	-1196(ra) # 56e6 <write>
  close(fd);
     b9a:	8526                	mv	a0,s1
     b9c:	00005097          	auipc	ra,0x5
     ba0:	b52080e7          	jalr	-1198(ra) # 56ee <close>
  fd = open("unlinkread", O_RDWR);
     ba4:	4589                	li	a1,2
     ba6:	00005517          	auipc	a0,0x5
     baa:	7ea50513          	add	a0,a0,2026 # 6390 <malloc+0x612>
     bae:	00005097          	auipc	ra,0x5
     bb2:	b58080e7          	jalr	-1192(ra) # 5706 <open>
     bb6:	84aa                	mv	s1,a0
  if(fd < 0){
     bb8:	0c054863          	bltz	a0,c88 <unlinkread+0x12a>
  if(unlink("unlinkread") != 0){
     bbc:	00005517          	auipc	a0,0x5
     bc0:	7d450513          	add	a0,a0,2004 # 6390 <malloc+0x612>
     bc4:	00005097          	auipc	ra,0x5
     bc8:	b52080e7          	jalr	-1198(ra) # 5716 <unlink>
     bcc:	ed61                	bnez	a0,ca4 <unlinkread+0x146>
  fd1 = open("unlinkread", O_CREATE | O_RDWR);
     bce:	20200593          	li	a1,514
     bd2:	00005517          	auipc	a0,0x5
     bd6:	7be50513          	add	a0,a0,1982 # 6390 <malloc+0x612>
     bda:	00005097          	auipc	ra,0x5
     bde:	b2c080e7          	jalr	-1236(ra) # 5706 <open>
     be2:	892a                	mv	s2,a0
  write(fd1, "yyy", 3);
     be4:	460d                	li	a2,3
     be6:	00006597          	auipc	a1,0x6
     bea:	82258593          	add	a1,a1,-2014 # 6408 <malloc+0x68a>
     bee:	00005097          	auipc	ra,0x5
     bf2:	af8080e7          	jalr	-1288(ra) # 56e6 <write>
  close(fd1);
     bf6:	854a                	mv	a0,s2
     bf8:	00005097          	auipc	ra,0x5
     bfc:	af6080e7          	jalr	-1290(ra) # 56ee <close>
  if(read(fd, buf, sizeof(buf)) != SZ){
     c00:	660d                	lui	a2,0x3
     c02:	0000b597          	auipc	a1,0xb
     c06:	24e58593          	add	a1,a1,590 # be50 <buf>
     c0a:	8526                	mv	a0,s1
     c0c:	00005097          	auipc	ra,0x5
     c10:	ad2080e7          	jalr	-1326(ra) # 56de <read>
     c14:	4795                	li	a5,5
     c16:	0af51563          	bne	a0,a5,cc0 <unlinkread+0x162>
  if(buf[0] != 'h'){
     c1a:	0000b717          	auipc	a4,0xb
     c1e:	23674703          	lbu	a4,566(a4) # be50 <buf>
     c22:	06800793          	li	a5,104
     c26:	0af71b63          	bne	a4,a5,cdc <unlinkread+0x17e>
  if(write(fd, buf, 10) != 10){
     c2a:	4629                	li	a2,10
     c2c:	0000b597          	auipc	a1,0xb
     c30:	22458593          	add	a1,a1,548 # be50 <buf>
     c34:	8526                	mv	a0,s1
     c36:	00005097          	auipc	ra,0x5
     c3a:	ab0080e7          	jalr	-1360(ra) # 56e6 <write>
     c3e:	47a9                	li	a5,10
     c40:	0af51c63          	bne	a0,a5,cf8 <unlinkread+0x19a>
  close(fd);
     c44:	8526                	mv	a0,s1
     c46:	00005097          	auipc	ra,0x5
     c4a:	aa8080e7          	jalr	-1368(ra) # 56ee <close>
  unlink("unlinkread");
     c4e:	00005517          	auipc	a0,0x5
     c52:	74250513          	add	a0,a0,1858 # 6390 <malloc+0x612>
     c56:	00005097          	auipc	ra,0x5
     c5a:	ac0080e7          	jalr	-1344(ra) # 5716 <unlink>
}
     c5e:	70a2                	ld	ra,40(sp)
     c60:	7402                	ld	s0,32(sp)
     c62:	64e2                	ld	s1,24(sp)
     c64:	6942                	ld	s2,16(sp)
     c66:	69a2                	ld	s3,8(sp)
     c68:	6145                	add	sp,sp,48
     c6a:	8082                	ret
    printf("%s: create unlinkread failed\n", s);
     c6c:	85ce                	mv	a1,s3
     c6e:	00005517          	auipc	a0,0x5
     c72:	73250513          	add	a0,a0,1842 # 63a0 <malloc+0x622>
     c76:	00005097          	auipc	ra,0x5
     c7a:	e88080e7          	jalr	-376(ra) # 5afe <printf>
    exit(1);
     c7e:	4505                	li	a0,1
     c80:	00005097          	auipc	ra,0x5
     c84:	a46080e7          	jalr	-1466(ra) # 56c6 <exit>
    printf("%s: open unlinkread failed\n", s);
     c88:	85ce                	mv	a1,s3
     c8a:	00005517          	auipc	a0,0x5
     c8e:	73e50513          	add	a0,a0,1854 # 63c8 <malloc+0x64a>
     c92:	00005097          	auipc	ra,0x5
     c96:	e6c080e7          	jalr	-404(ra) # 5afe <printf>
    exit(1);
     c9a:	4505                	li	a0,1
     c9c:	00005097          	auipc	ra,0x5
     ca0:	a2a080e7          	jalr	-1494(ra) # 56c6 <exit>
    printf("%s: unlink unlinkread failed\n", s);
     ca4:	85ce                	mv	a1,s3
     ca6:	00005517          	auipc	a0,0x5
     caa:	74250513          	add	a0,a0,1858 # 63e8 <malloc+0x66a>
     cae:	00005097          	auipc	ra,0x5
     cb2:	e50080e7          	jalr	-432(ra) # 5afe <printf>
    exit(1);
     cb6:	4505                	li	a0,1
     cb8:	00005097          	auipc	ra,0x5
     cbc:	a0e080e7          	jalr	-1522(ra) # 56c6 <exit>
    printf("%s: unlinkread read failed", s);
     cc0:	85ce                	mv	a1,s3
     cc2:	00005517          	auipc	a0,0x5
     cc6:	74e50513          	add	a0,a0,1870 # 6410 <malloc+0x692>
     cca:	00005097          	auipc	ra,0x5
     cce:	e34080e7          	jalr	-460(ra) # 5afe <printf>
    exit(1);
     cd2:	4505                	li	a0,1
     cd4:	00005097          	auipc	ra,0x5
     cd8:	9f2080e7          	jalr	-1550(ra) # 56c6 <exit>
    printf("%s: unlinkread wrong data\n", s);
     cdc:	85ce                	mv	a1,s3
     cde:	00005517          	auipc	a0,0x5
     ce2:	75250513          	add	a0,a0,1874 # 6430 <malloc+0x6b2>
     ce6:	00005097          	auipc	ra,0x5
     cea:	e18080e7          	jalr	-488(ra) # 5afe <printf>
    exit(1);
     cee:	4505                	li	a0,1
     cf0:	00005097          	auipc	ra,0x5
     cf4:	9d6080e7          	jalr	-1578(ra) # 56c6 <exit>
    printf("%s: unlinkread write failed\n", s);
     cf8:	85ce                	mv	a1,s3
     cfa:	00005517          	auipc	a0,0x5
     cfe:	75650513          	add	a0,a0,1878 # 6450 <malloc+0x6d2>
     d02:	00005097          	auipc	ra,0x5
     d06:	dfc080e7          	jalr	-516(ra) # 5afe <printf>
    exit(1);
     d0a:	4505                	li	a0,1
     d0c:	00005097          	auipc	ra,0x5
     d10:	9ba080e7          	jalr	-1606(ra) # 56c6 <exit>

0000000000000d14 <linktest>:
{
     d14:	1101                	add	sp,sp,-32
     d16:	ec06                	sd	ra,24(sp)
     d18:	e822                	sd	s0,16(sp)
     d1a:	e426                	sd	s1,8(sp)
     d1c:	e04a                	sd	s2,0(sp)
     d1e:	1000                	add	s0,sp,32
     d20:	892a                	mv	s2,a0
  unlink("lf1");
     d22:	00005517          	auipc	a0,0x5
     d26:	74e50513          	add	a0,a0,1870 # 6470 <malloc+0x6f2>
     d2a:	00005097          	auipc	ra,0x5
     d2e:	9ec080e7          	jalr	-1556(ra) # 5716 <unlink>
  unlink("lf2");
     d32:	00005517          	auipc	a0,0x5
     d36:	74650513          	add	a0,a0,1862 # 6478 <malloc+0x6fa>
     d3a:	00005097          	auipc	ra,0x5
     d3e:	9dc080e7          	jalr	-1572(ra) # 5716 <unlink>
  fd = open("lf1", O_CREATE|O_RDWR);
     d42:	20200593          	li	a1,514
     d46:	00005517          	auipc	a0,0x5
     d4a:	72a50513          	add	a0,a0,1834 # 6470 <malloc+0x6f2>
     d4e:	00005097          	auipc	ra,0x5
     d52:	9b8080e7          	jalr	-1608(ra) # 5706 <open>
  if(fd < 0){
     d56:	10054763          	bltz	a0,e64 <linktest+0x150>
     d5a:	84aa                	mv	s1,a0
  if(write(fd, "hello", SZ) != SZ){
     d5c:	4615                	li	a2,5
     d5e:	00005597          	auipc	a1,0x5
     d62:	66258593          	add	a1,a1,1634 # 63c0 <malloc+0x642>
     d66:	00005097          	auipc	ra,0x5
     d6a:	980080e7          	jalr	-1664(ra) # 56e6 <write>
     d6e:	4795                	li	a5,5
     d70:	10f51863          	bne	a0,a5,e80 <linktest+0x16c>
  close(fd);
     d74:	8526                	mv	a0,s1
     d76:	00005097          	auipc	ra,0x5
     d7a:	978080e7          	jalr	-1672(ra) # 56ee <close>
  if(link("lf1", "lf2") < 0){
     d7e:	00005597          	auipc	a1,0x5
     d82:	6fa58593          	add	a1,a1,1786 # 6478 <malloc+0x6fa>
     d86:	00005517          	auipc	a0,0x5
     d8a:	6ea50513          	add	a0,a0,1770 # 6470 <malloc+0x6f2>
     d8e:	00005097          	auipc	ra,0x5
     d92:	998080e7          	jalr	-1640(ra) # 5726 <link>
     d96:	10054363          	bltz	a0,e9c <linktest+0x188>
  unlink("lf1");
     d9a:	00005517          	auipc	a0,0x5
     d9e:	6d650513          	add	a0,a0,1750 # 6470 <malloc+0x6f2>
     da2:	00005097          	auipc	ra,0x5
     da6:	974080e7          	jalr	-1676(ra) # 5716 <unlink>
  if(open("lf1", 0) >= 0){
     daa:	4581                	li	a1,0
     dac:	00005517          	auipc	a0,0x5
     db0:	6c450513          	add	a0,a0,1732 # 6470 <malloc+0x6f2>
     db4:	00005097          	auipc	ra,0x5
     db8:	952080e7          	jalr	-1710(ra) # 5706 <open>
     dbc:	0e055e63          	bgez	a0,eb8 <linktest+0x1a4>
  fd = open("lf2", 0);
     dc0:	4581                	li	a1,0
     dc2:	00005517          	auipc	a0,0x5
     dc6:	6b650513          	add	a0,a0,1718 # 6478 <malloc+0x6fa>
     dca:	00005097          	auipc	ra,0x5
     dce:	93c080e7          	jalr	-1732(ra) # 5706 <open>
     dd2:	84aa                	mv	s1,a0
  if(fd < 0){
     dd4:	10054063          	bltz	a0,ed4 <linktest+0x1c0>
  if(read(fd, buf, sizeof(buf)) != SZ){
     dd8:	660d                	lui	a2,0x3
     dda:	0000b597          	auipc	a1,0xb
     dde:	07658593          	add	a1,a1,118 # be50 <buf>
     de2:	00005097          	auipc	ra,0x5
     de6:	8fc080e7          	jalr	-1796(ra) # 56de <read>
     dea:	4795                	li	a5,5
     dec:	10f51263          	bne	a0,a5,ef0 <linktest+0x1dc>
  close(fd);
     df0:	8526                	mv	a0,s1
     df2:	00005097          	auipc	ra,0x5
     df6:	8fc080e7          	jalr	-1796(ra) # 56ee <close>
  if(link("lf2", "lf2") >= 0){
     dfa:	00005597          	auipc	a1,0x5
     dfe:	67e58593          	add	a1,a1,1662 # 6478 <malloc+0x6fa>
     e02:	852e                	mv	a0,a1
     e04:	00005097          	auipc	ra,0x5
     e08:	922080e7          	jalr	-1758(ra) # 5726 <link>
     e0c:	10055063          	bgez	a0,f0c <linktest+0x1f8>
  unlink("lf2");
     e10:	00005517          	auipc	a0,0x5
     e14:	66850513          	add	a0,a0,1640 # 6478 <malloc+0x6fa>
     e18:	00005097          	auipc	ra,0x5
     e1c:	8fe080e7          	jalr	-1794(ra) # 5716 <unlink>
  if(link("lf2", "lf1") >= 0){
     e20:	00005597          	auipc	a1,0x5
     e24:	65058593          	add	a1,a1,1616 # 6470 <malloc+0x6f2>
     e28:	00005517          	auipc	a0,0x5
     e2c:	65050513          	add	a0,a0,1616 # 6478 <malloc+0x6fa>
     e30:	00005097          	auipc	ra,0x5
     e34:	8f6080e7          	jalr	-1802(ra) # 5726 <link>
     e38:	0e055863          	bgez	a0,f28 <linktest+0x214>
  if(link(".", "lf1") >= 0){
     e3c:	00005597          	auipc	a1,0x5
     e40:	63458593          	add	a1,a1,1588 # 6470 <malloc+0x6f2>
     e44:	00005517          	auipc	a0,0x5
     e48:	73c50513          	add	a0,a0,1852 # 6580 <malloc+0x802>
     e4c:	00005097          	auipc	ra,0x5
     e50:	8da080e7          	jalr	-1830(ra) # 5726 <link>
     e54:	0e055863          	bgez	a0,f44 <linktest+0x230>
}
     e58:	60e2                	ld	ra,24(sp)
     e5a:	6442                	ld	s0,16(sp)
     e5c:	64a2                	ld	s1,8(sp)
     e5e:	6902                	ld	s2,0(sp)
     e60:	6105                	add	sp,sp,32
     e62:	8082                	ret
    printf("%s: create lf1 failed\n", s);
     e64:	85ca                	mv	a1,s2
     e66:	00005517          	auipc	a0,0x5
     e6a:	61a50513          	add	a0,a0,1562 # 6480 <malloc+0x702>
     e6e:	00005097          	auipc	ra,0x5
     e72:	c90080e7          	jalr	-880(ra) # 5afe <printf>
    exit(1);
     e76:	4505                	li	a0,1
     e78:	00005097          	auipc	ra,0x5
     e7c:	84e080e7          	jalr	-1970(ra) # 56c6 <exit>
    printf("%s: write lf1 failed\n", s);
     e80:	85ca                	mv	a1,s2
     e82:	00005517          	auipc	a0,0x5
     e86:	61650513          	add	a0,a0,1558 # 6498 <malloc+0x71a>
     e8a:	00005097          	auipc	ra,0x5
     e8e:	c74080e7          	jalr	-908(ra) # 5afe <printf>
    exit(1);
     e92:	4505                	li	a0,1
     e94:	00005097          	auipc	ra,0x5
     e98:	832080e7          	jalr	-1998(ra) # 56c6 <exit>
    printf("%s: link lf1 lf2 failed\n", s);
     e9c:	85ca                	mv	a1,s2
     e9e:	00005517          	auipc	a0,0x5
     ea2:	61250513          	add	a0,a0,1554 # 64b0 <malloc+0x732>
     ea6:	00005097          	auipc	ra,0x5
     eaa:	c58080e7          	jalr	-936(ra) # 5afe <printf>
    exit(1);
     eae:	4505                	li	a0,1
     eb0:	00005097          	auipc	ra,0x5
     eb4:	816080e7          	jalr	-2026(ra) # 56c6 <exit>
    printf("%s: unlinked lf1 but it is still there!\n", s);
     eb8:	85ca                	mv	a1,s2
     eba:	00005517          	auipc	a0,0x5
     ebe:	61650513          	add	a0,a0,1558 # 64d0 <malloc+0x752>
     ec2:	00005097          	auipc	ra,0x5
     ec6:	c3c080e7          	jalr	-964(ra) # 5afe <printf>
    exit(1);
     eca:	4505                	li	a0,1
     ecc:	00004097          	auipc	ra,0x4
     ed0:	7fa080e7          	jalr	2042(ra) # 56c6 <exit>
    printf("%s: open lf2 failed\n", s);
     ed4:	85ca                	mv	a1,s2
     ed6:	00005517          	auipc	a0,0x5
     eda:	62a50513          	add	a0,a0,1578 # 6500 <malloc+0x782>
     ede:	00005097          	auipc	ra,0x5
     ee2:	c20080e7          	jalr	-992(ra) # 5afe <printf>
    exit(1);
     ee6:	4505                	li	a0,1
     ee8:	00004097          	auipc	ra,0x4
     eec:	7de080e7          	jalr	2014(ra) # 56c6 <exit>
    printf("%s: read lf2 failed\n", s);
     ef0:	85ca                	mv	a1,s2
     ef2:	00005517          	auipc	a0,0x5
     ef6:	62650513          	add	a0,a0,1574 # 6518 <malloc+0x79a>
     efa:	00005097          	auipc	ra,0x5
     efe:	c04080e7          	jalr	-1020(ra) # 5afe <printf>
    exit(1);
     f02:	4505                	li	a0,1
     f04:	00004097          	auipc	ra,0x4
     f08:	7c2080e7          	jalr	1986(ra) # 56c6 <exit>
    printf("%s: link lf2 lf2 succeeded! oops\n", s);
     f0c:	85ca                	mv	a1,s2
     f0e:	00005517          	auipc	a0,0x5
     f12:	62250513          	add	a0,a0,1570 # 6530 <malloc+0x7b2>
     f16:	00005097          	auipc	ra,0x5
     f1a:	be8080e7          	jalr	-1048(ra) # 5afe <printf>
    exit(1);
     f1e:	4505                	li	a0,1
     f20:	00004097          	auipc	ra,0x4
     f24:	7a6080e7          	jalr	1958(ra) # 56c6 <exit>
    printf("%s: link non-existant succeeded! oops\n", s);
     f28:	85ca                	mv	a1,s2
     f2a:	00005517          	auipc	a0,0x5
     f2e:	62e50513          	add	a0,a0,1582 # 6558 <malloc+0x7da>
     f32:	00005097          	auipc	ra,0x5
     f36:	bcc080e7          	jalr	-1076(ra) # 5afe <printf>
    exit(1);
     f3a:	4505                	li	a0,1
     f3c:	00004097          	auipc	ra,0x4
     f40:	78a080e7          	jalr	1930(ra) # 56c6 <exit>
    printf("%s: link . lf1 succeeded! oops\n", s);
     f44:	85ca                	mv	a1,s2
     f46:	00005517          	auipc	a0,0x5
     f4a:	64250513          	add	a0,a0,1602 # 6588 <malloc+0x80a>
     f4e:	00005097          	auipc	ra,0x5
     f52:	bb0080e7          	jalr	-1104(ra) # 5afe <printf>
    exit(1);
     f56:	4505                	li	a0,1
     f58:	00004097          	auipc	ra,0x4
     f5c:	76e080e7          	jalr	1902(ra) # 56c6 <exit>

0000000000000f60 <bigdir>:
{
     f60:	715d                	add	sp,sp,-80
     f62:	e486                	sd	ra,72(sp)
     f64:	e0a2                	sd	s0,64(sp)
     f66:	fc26                	sd	s1,56(sp)
     f68:	f84a                	sd	s2,48(sp)
     f6a:	f44e                	sd	s3,40(sp)
     f6c:	f052                	sd	s4,32(sp)
     f6e:	ec56                	sd	s5,24(sp)
     f70:	e85a                	sd	s6,16(sp)
     f72:	0880                	add	s0,sp,80
     f74:	89aa                	mv	s3,a0
  unlink("bd");
     f76:	00005517          	auipc	a0,0x5
     f7a:	63250513          	add	a0,a0,1586 # 65a8 <malloc+0x82a>
     f7e:	00004097          	auipc	ra,0x4
     f82:	798080e7          	jalr	1944(ra) # 5716 <unlink>
  fd = open("bd", O_CREATE);
     f86:	20000593          	li	a1,512
     f8a:	00005517          	auipc	a0,0x5
     f8e:	61e50513          	add	a0,a0,1566 # 65a8 <malloc+0x82a>
     f92:	00004097          	auipc	ra,0x4
     f96:	774080e7          	jalr	1908(ra) # 5706 <open>
  if(fd < 0){
     f9a:	0c054963          	bltz	a0,106c <bigdir+0x10c>
  close(fd);
     f9e:	00004097          	auipc	ra,0x4
     fa2:	750080e7          	jalr	1872(ra) # 56ee <close>
  for(i = 0; i < N; i++){
     fa6:	4901                	li	s2,0
    name[0] = 'x';
     fa8:	07800a93          	li	s5,120
    if(link("bd", name) != 0){
     fac:	00005a17          	auipc	s4,0x5
     fb0:	5fca0a13          	add	s4,s4,1532 # 65a8 <malloc+0x82a>
  for(i = 0; i < N; i++){
     fb4:	1f400b13          	li	s6,500
    name[0] = 'x';
     fb8:	fb540823          	sb	s5,-80(s0)
    name[1] = '0' + (i / 64);
     fbc:	41f9571b          	sraw	a4,s2,0x1f
     fc0:	01a7571b          	srlw	a4,a4,0x1a
     fc4:	012707bb          	addw	a5,a4,s2
     fc8:	4067d69b          	sraw	a3,a5,0x6
     fcc:	0306869b          	addw	a3,a3,48
     fd0:	fad408a3          	sb	a3,-79(s0)
    name[2] = '0' + (i % 64);
     fd4:	03f7f793          	and	a5,a5,63
     fd8:	9f99                	subw	a5,a5,a4
     fda:	0307879b          	addw	a5,a5,48
     fde:	faf40923          	sb	a5,-78(s0)
    name[3] = '\0';
     fe2:	fa0409a3          	sb	zero,-77(s0)
    if(link("bd", name) != 0){
     fe6:	fb040593          	add	a1,s0,-80
     fea:	8552                	mv	a0,s4
     fec:	00004097          	auipc	ra,0x4
     ff0:	73a080e7          	jalr	1850(ra) # 5726 <link>
     ff4:	84aa                	mv	s1,a0
     ff6:	e949                	bnez	a0,1088 <bigdir+0x128>
  for(i = 0; i < N; i++){
     ff8:	2905                	addw	s2,s2,1
     ffa:	fb691fe3          	bne	s2,s6,fb8 <bigdir+0x58>
  unlink("bd");
     ffe:	00005517          	auipc	a0,0x5
    1002:	5aa50513          	add	a0,a0,1450 # 65a8 <malloc+0x82a>
    1006:	00004097          	auipc	ra,0x4
    100a:	710080e7          	jalr	1808(ra) # 5716 <unlink>
    name[0] = 'x';
    100e:	07800913          	li	s2,120
  for(i = 0; i < N; i++){
    1012:	1f400a13          	li	s4,500
    name[0] = 'x';
    1016:	fb240823          	sb	s2,-80(s0)
    name[1] = '0' + (i / 64);
    101a:	41f4d71b          	sraw	a4,s1,0x1f
    101e:	01a7571b          	srlw	a4,a4,0x1a
    1022:	009707bb          	addw	a5,a4,s1
    1026:	4067d69b          	sraw	a3,a5,0x6
    102a:	0306869b          	addw	a3,a3,48
    102e:	fad408a3          	sb	a3,-79(s0)
    name[2] = '0' + (i % 64);
    1032:	03f7f793          	and	a5,a5,63
    1036:	9f99                	subw	a5,a5,a4
    1038:	0307879b          	addw	a5,a5,48
    103c:	faf40923          	sb	a5,-78(s0)
    name[3] = '\0';
    1040:	fa0409a3          	sb	zero,-77(s0)
    if(unlink(name) != 0){
    1044:	fb040513          	add	a0,s0,-80
    1048:	00004097          	auipc	ra,0x4
    104c:	6ce080e7          	jalr	1742(ra) # 5716 <unlink>
    1050:	ed21                	bnez	a0,10a8 <bigdir+0x148>
  for(i = 0; i < N; i++){
    1052:	2485                	addw	s1,s1,1
    1054:	fd4491e3          	bne	s1,s4,1016 <bigdir+0xb6>
}
    1058:	60a6                	ld	ra,72(sp)
    105a:	6406                	ld	s0,64(sp)
    105c:	74e2                	ld	s1,56(sp)
    105e:	7942                	ld	s2,48(sp)
    1060:	79a2                	ld	s3,40(sp)
    1062:	7a02                	ld	s4,32(sp)
    1064:	6ae2                	ld	s5,24(sp)
    1066:	6b42                	ld	s6,16(sp)
    1068:	6161                	add	sp,sp,80
    106a:	8082                	ret
    printf("%s: bigdir create failed\n", s);
    106c:	85ce                	mv	a1,s3
    106e:	00005517          	auipc	a0,0x5
    1072:	54250513          	add	a0,a0,1346 # 65b0 <malloc+0x832>
    1076:	00005097          	auipc	ra,0x5
    107a:	a88080e7          	jalr	-1400(ra) # 5afe <printf>
    exit(1);
    107e:	4505                	li	a0,1
    1080:	00004097          	auipc	ra,0x4
    1084:	646080e7          	jalr	1606(ra) # 56c6 <exit>
      printf("%s: bigdir link(bd, %s) failed\n", s, name);
    1088:	fb040613          	add	a2,s0,-80
    108c:	85ce                	mv	a1,s3
    108e:	00005517          	auipc	a0,0x5
    1092:	54250513          	add	a0,a0,1346 # 65d0 <malloc+0x852>
    1096:	00005097          	auipc	ra,0x5
    109a:	a68080e7          	jalr	-1432(ra) # 5afe <printf>
      exit(1);
    109e:	4505                	li	a0,1
    10a0:	00004097          	auipc	ra,0x4
    10a4:	626080e7          	jalr	1574(ra) # 56c6 <exit>
      printf("%s: bigdir unlink failed", s);
    10a8:	85ce                	mv	a1,s3
    10aa:	00005517          	auipc	a0,0x5
    10ae:	54650513          	add	a0,a0,1350 # 65f0 <malloc+0x872>
    10b2:	00005097          	auipc	ra,0x5
    10b6:	a4c080e7          	jalr	-1460(ra) # 5afe <printf>
      exit(1);
    10ba:	4505                	li	a0,1
    10bc:	00004097          	auipc	ra,0x4
    10c0:	60a080e7          	jalr	1546(ra) # 56c6 <exit>

00000000000010c4 <validatetest>:
{
    10c4:	7139                	add	sp,sp,-64
    10c6:	fc06                	sd	ra,56(sp)
    10c8:	f822                	sd	s0,48(sp)
    10ca:	f426                	sd	s1,40(sp)
    10cc:	f04a                	sd	s2,32(sp)
    10ce:	ec4e                	sd	s3,24(sp)
    10d0:	e852                	sd	s4,16(sp)
    10d2:	e456                	sd	s5,8(sp)
    10d4:	e05a                	sd	s6,0(sp)
    10d6:	0080                	add	s0,sp,64
    10d8:	8b2a                	mv	s6,a0
  for(p = 0; p <= (uint)hi; p += PGSIZE){
    10da:	4481                	li	s1,0
    if(link("nosuchfile", (char*)p) != -1){
    10dc:	00005997          	auipc	s3,0x5
    10e0:	53498993          	add	s3,s3,1332 # 6610 <malloc+0x892>
    10e4:	597d                	li	s2,-1
  for(p = 0; p <= (uint)hi; p += PGSIZE){
    10e6:	6a85                	lui	s5,0x1
    10e8:	00114a37          	lui	s4,0x114
    if(link("nosuchfile", (char*)p) != -1){
    10ec:	85a6                	mv	a1,s1
    10ee:	854e                	mv	a0,s3
    10f0:	00004097          	auipc	ra,0x4
    10f4:	636080e7          	jalr	1590(ra) # 5726 <link>
    10f8:	01251f63          	bne	a0,s2,1116 <validatetest+0x52>
  for(p = 0; p <= (uint)hi; p += PGSIZE){
    10fc:	94d6                	add	s1,s1,s5
    10fe:	ff4497e3          	bne	s1,s4,10ec <validatetest+0x28>
}
    1102:	70e2                	ld	ra,56(sp)
    1104:	7442                	ld	s0,48(sp)
    1106:	74a2                	ld	s1,40(sp)
    1108:	7902                	ld	s2,32(sp)
    110a:	69e2                	ld	s3,24(sp)
    110c:	6a42                	ld	s4,16(sp)
    110e:	6aa2                	ld	s5,8(sp)
    1110:	6b02                	ld	s6,0(sp)
    1112:	6121                	add	sp,sp,64
    1114:	8082                	ret
      printf("%s: link should not succeed\n", s);
    1116:	85da                	mv	a1,s6
    1118:	00005517          	auipc	a0,0x5
    111c:	50850513          	add	a0,a0,1288 # 6620 <malloc+0x8a2>
    1120:	00005097          	auipc	ra,0x5
    1124:	9de080e7          	jalr	-1570(ra) # 5afe <printf>
      exit(1);
    1128:	4505                	li	a0,1
    112a:	00004097          	auipc	ra,0x4
    112e:	59c080e7          	jalr	1436(ra) # 56c6 <exit>

0000000000001132 <pgbug>:
// regression test. copyin(), copyout(), and copyinstr() used to cast
// the virtual page address to uint, which (with certain wild system
// call arguments) resulted in a kernel page faults.
void
pgbug(char *s)
{
    1132:	7179                	add	sp,sp,-48
    1134:	f406                	sd	ra,40(sp)
    1136:	f022                	sd	s0,32(sp)
    1138:	ec26                	sd	s1,24(sp)
    113a:	1800                	add	s0,sp,48
  char *argv[1];
  argv[0] = 0;
    113c:	fc043c23          	sd	zero,-40(s0)
  exec((char*)0xeaeb0b5b00002f5e, argv);
    1140:	eaeb14b7          	lui	s1,0xeaeb1
    1144:	b5b48493          	add	s1,s1,-1189 # ffffffffeaeb0b5b <__BSS_END__+0xffffffffeaea1cfb>
    1148:	04d2                	sll	s1,s1,0x14
    114a:	048d                	add	s1,s1,3
    114c:	04b2                	sll	s1,s1,0xc
    114e:	f5e48493          	add	s1,s1,-162
    1152:	fd840593          	add	a1,s0,-40
    1156:	8526                	mv	a0,s1
    1158:	00004097          	auipc	ra,0x4
    115c:	5a6080e7          	jalr	1446(ra) # 56fe <exec>

  pipe((int*)0xeaeb0b5b00002f5e);
    1160:	8526                	mv	a0,s1
    1162:	00004097          	auipc	ra,0x4
    1166:	574080e7          	jalr	1396(ra) # 56d6 <pipe>

  exit(0);
    116a:	4501                	li	a0,0
    116c:	00004097          	auipc	ra,0x4
    1170:	55a080e7          	jalr	1370(ra) # 56c6 <exit>

0000000000001174 <badarg>:

// regression test. test whether exec() leaks memory if one of the
// arguments is invalid. the test passes if the kernel doesn't panic.
void
badarg(char *s)
{
    1174:	7139                	add	sp,sp,-64
    1176:	fc06                	sd	ra,56(sp)
    1178:	f822                	sd	s0,48(sp)
    117a:	f426                	sd	s1,40(sp)
    117c:	f04a                	sd	s2,32(sp)
    117e:	ec4e                	sd	s3,24(sp)
    1180:	0080                	add	s0,sp,64
    1182:	64b1                	lui	s1,0xc
    1184:	35048493          	add	s1,s1,848 # c350 <buf+0x500>
  for(int i = 0; i < 50000; i++){
    char *argv[2];
    argv[0] = (char*)0xffffffff;
    1188:	597d                	li	s2,-1
    118a:	02095913          	srl	s2,s2,0x20
    argv[1] = 0;
    exec("echo", argv);
    118e:	00005997          	auipc	s3,0x5
    1192:	d2a98993          	add	s3,s3,-726 # 5eb8 <malloc+0x13a>
    argv[0] = (char*)0xffffffff;
    1196:	fd243023          	sd	s2,-64(s0)
    argv[1] = 0;
    119a:	fc043423          	sd	zero,-56(s0)
    exec("echo", argv);
    119e:	fc040593          	add	a1,s0,-64
    11a2:	854e                	mv	a0,s3
    11a4:	00004097          	auipc	ra,0x4
    11a8:	55a080e7          	jalr	1370(ra) # 56fe <exec>
  for(int i = 0; i < 50000; i++){
    11ac:	34fd                	addw	s1,s1,-1
    11ae:	f4e5                	bnez	s1,1196 <badarg+0x22>
  }
  
  exit(0);
    11b0:	4501                	li	a0,0
    11b2:	00004097          	auipc	ra,0x4
    11b6:	514080e7          	jalr	1300(ra) # 56c6 <exit>

00000000000011ba <copyinstr2>:
{
    11ba:	7155                	add	sp,sp,-208
    11bc:	e586                	sd	ra,200(sp)
    11be:	e1a2                	sd	s0,192(sp)
    11c0:	0980                	add	s0,sp,208
  for(int i = 0; i < MAXPATH; i++)
    11c2:	f6840793          	add	a5,s0,-152
    11c6:	fe840693          	add	a3,s0,-24
    b[i] = 'x';
    11ca:	07800713          	li	a4,120
    11ce:	00e78023          	sb	a4,0(a5)
  for(int i = 0; i < MAXPATH; i++)
    11d2:	0785                	add	a5,a5,1
    11d4:	fed79de3          	bne	a5,a3,11ce <copyinstr2+0x14>
  b[MAXPATH] = '\0';
    11d8:	fe040423          	sb	zero,-24(s0)
  int ret = unlink(b);
    11dc:	f6840513          	add	a0,s0,-152
    11e0:	00004097          	auipc	ra,0x4
    11e4:	536080e7          	jalr	1334(ra) # 5716 <unlink>
  if(ret != -1){
    11e8:	57fd                	li	a5,-1
    11ea:	0ef51063          	bne	a0,a5,12ca <copyinstr2+0x110>
  int fd = open(b, O_CREATE | O_WRONLY);
    11ee:	20100593          	li	a1,513
    11f2:	f6840513          	add	a0,s0,-152
    11f6:	00004097          	auipc	ra,0x4
    11fa:	510080e7          	jalr	1296(ra) # 5706 <open>
  if(fd != -1){
    11fe:	57fd                	li	a5,-1
    1200:	0ef51563          	bne	a0,a5,12ea <copyinstr2+0x130>
  ret = link(b, b);
    1204:	f6840593          	add	a1,s0,-152
    1208:	852e                	mv	a0,a1
    120a:	00004097          	auipc	ra,0x4
    120e:	51c080e7          	jalr	1308(ra) # 5726 <link>
  if(ret != -1){
    1212:	57fd                	li	a5,-1
    1214:	0ef51b63          	bne	a0,a5,130a <copyinstr2+0x150>
  char *args[] = { "xx", 0 };
    1218:	00006797          	auipc	a5,0x6
    121c:	5e878793          	add	a5,a5,1512 # 7800 <malloc+0x1a82>
    1220:	f4f43c23          	sd	a5,-168(s0)
    1224:	f6043023          	sd	zero,-160(s0)
  ret = exec(b, args);
    1228:	f5840593          	add	a1,s0,-168
    122c:	f6840513          	add	a0,s0,-152
    1230:	00004097          	auipc	ra,0x4
    1234:	4ce080e7          	jalr	1230(ra) # 56fe <exec>
  if(ret != -1){
    1238:	57fd                	li	a5,-1
    123a:	0ef51963          	bne	a0,a5,132c <copyinstr2+0x172>
  int pid = fork();
    123e:	00004097          	auipc	ra,0x4
    1242:	480080e7          	jalr	1152(ra) # 56be <fork>
  if(pid < 0){
    1246:	10054363          	bltz	a0,134c <copyinstr2+0x192>
  if(pid == 0){
    124a:	12051463          	bnez	a0,1372 <copyinstr2+0x1b8>
    124e:	00007797          	auipc	a5,0x7
    1252:	4ea78793          	add	a5,a5,1258 # 8738 <big.0>
    1256:	00008697          	auipc	a3,0x8
    125a:	4e268693          	add	a3,a3,1250 # 9738 <__global_pointer$+0x910>
      big[i] = 'x';
    125e:	07800713          	li	a4,120
    1262:	00e78023          	sb	a4,0(a5)
    for(int i = 0; i < PGSIZE; i++)
    1266:	0785                	add	a5,a5,1
    1268:	fed79de3          	bne	a5,a3,1262 <copyinstr2+0xa8>
    big[PGSIZE] = '\0';
    126c:	00008797          	auipc	a5,0x8
    1270:	4c078623          	sb	zero,1228(a5) # 9738 <__global_pointer$+0x910>
    char *args2[] = { big, big, big, 0 };
    1274:	00007797          	auipc	a5,0x7
    1278:	f7478793          	add	a5,a5,-140 # 81e8 <malloc+0x246a>
    127c:	6390                	ld	a2,0(a5)
    127e:	6794                	ld	a3,8(a5)
    1280:	6b98                	ld	a4,16(a5)
    1282:	6f9c                	ld	a5,24(a5)
    1284:	f2c43823          	sd	a2,-208(s0)
    1288:	f2d43c23          	sd	a3,-200(s0)
    128c:	f4e43023          	sd	a4,-192(s0)
    1290:	f4f43423          	sd	a5,-184(s0)
    ret = exec("echo", args2);
    1294:	f3040593          	add	a1,s0,-208
    1298:	00005517          	auipc	a0,0x5
    129c:	c2050513          	add	a0,a0,-992 # 5eb8 <malloc+0x13a>
    12a0:	00004097          	auipc	ra,0x4
    12a4:	45e080e7          	jalr	1118(ra) # 56fe <exec>
    if(ret != -1){
    12a8:	57fd                	li	a5,-1
    12aa:	0af50e63          	beq	a0,a5,1366 <copyinstr2+0x1ac>
      printf("exec(echo, BIG) returned %d, not -1\n", fd);
    12ae:	55fd                	li	a1,-1
    12b0:	00005517          	auipc	a0,0x5
    12b4:	41850513          	add	a0,a0,1048 # 66c8 <malloc+0x94a>
    12b8:	00005097          	auipc	ra,0x5
    12bc:	846080e7          	jalr	-1978(ra) # 5afe <printf>
      exit(1);
    12c0:	4505                	li	a0,1
    12c2:	00004097          	auipc	ra,0x4
    12c6:	404080e7          	jalr	1028(ra) # 56c6 <exit>
    printf("unlink(%s) returned %d, not -1\n", b, ret);
    12ca:	862a                	mv	a2,a0
    12cc:	f6840593          	add	a1,s0,-152
    12d0:	00005517          	auipc	a0,0x5
    12d4:	37050513          	add	a0,a0,880 # 6640 <malloc+0x8c2>
    12d8:	00005097          	auipc	ra,0x5
    12dc:	826080e7          	jalr	-2010(ra) # 5afe <printf>
    exit(1);
    12e0:	4505                	li	a0,1
    12e2:	00004097          	auipc	ra,0x4
    12e6:	3e4080e7          	jalr	996(ra) # 56c6 <exit>
    printf("open(%s) returned %d, not -1\n", b, fd);
    12ea:	862a                	mv	a2,a0
    12ec:	f6840593          	add	a1,s0,-152
    12f0:	00005517          	auipc	a0,0x5
    12f4:	37050513          	add	a0,a0,880 # 6660 <malloc+0x8e2>
    12f8:	00005097          	auipc	ra,0x5
    12fc:	806080e7          	jalr	-2042(ra) # 5afe <printf>
    exit(1);
    1300:	4505                	li	a0,1
    1302:	00004097          	auipc	ra,0x4
    1306:	3c4080e7          	jalr	964(ra) # 56c6 <exit>
    printf("link(%s, %s) returned %d, not -1\n", b, b, ret);
    130a:	86aa                	mv	a3,a0
    130c:	f6840613          	add	a2,s0,-152
    1310:	85b2                	mv	a1,a2
    1312:	00005517          	auipc	a0,0x5
    1316:	36e50513          	add	a0,a0,878 # 6680 <malloc+0x902>
    131a:	00004097          	auipc	ra,0x4
    131e:	7e4080e7          	jalr	2020(ra) # 5afe <printf>
    exit(1);
    1322:	4505                	li	a0,1
    1324:	00004097          	auipc	ra,0x4
    1328:	3a2080e7          	jalr	930(ra) # 56c6 <exit>
    printf("exec(%s) returned %d, not -1\n", b, fd);
    132c:	567d                	li	a2,-1
    132e:	f6840593          	add	a1,s0,-152
    1332:	00005517          	auipc	a0,0x5
    1336:	37650513          	add	a0,a0,886 # 66a8 <malloc+0x92a>
    133a:	00004097          	auipc	ra,0x4
    133e:	7c4080e7          	jalr	1988(ra) # 5afe <printf>
    exit(1);
    1342:	4505                	li	a0,1
    1344:	00004097          	auipc	ra,0x4
    1348:	382080e7          	jalr	898(ra) # 56c6 <exit>
    printf("fork failed\n");
    134c:	00005517          	auipc	a0,0x5
    1350:	7dc50513          	add	a0,a0,2012 # 6b28 <malloc+0xdaa>
    1354:	00004097          	auipc	ra,0x4
    1358:	7aa080e7          	jalr	1962(ra) # 5afe <printf>
    exit(1);
    135c:	4505                	li	a0,1
    135e:	00004097          	auipc	ra,0x4
    1362:	368080e7          	jalr	872(ra) # 56c6 <exit>
    exit(747); // OK
    1366:	2eb00513          	li	a0,747
    136a:	00004097          	auipc	ra,0x4
    136e:	35c080e7          	jalr	860(ra) # 56c6 <exit>
  int st = 0;
    1372:	f4042a23          	sw	zero,-172(s0)
  wait(&st);
    1376:	f5440513          	add	a0,s0,-172
    137a:	00004097          	auipc	ra,0x4
    137e:	354080e7          	jalr	852(ra) # 56ce <wait>
  if(st != 747){
    1382:	f5442703          	lw	a4,-172(s0)
    1386:	2eb00793          	li	a5,747
    138a:	00f71663          	bne	a4,a5,1396 <copyinstr2+0x1dc>
}
    138e:	60ae                	ld	ra,200(sp)
    1390:	640e                	ld	s0,192(sp)
    1392:	6169                	add	sp,sp,208
    1394:	8082                	ret
    printf("exec(echo, BIG) succeeded, should have failed\n");
    1396:	00005517          	auipc	a0,0x5
    139a:	35a50513          	add	a0,a0,858 # 66f0 <malloc+0x972>
    139e:	00004097          	auipc	ra,0x4
    13a2:	760080e7          	jalr	1888(ra) # 5afe <printf>
    exit(1);
    13a6:	4505                	li	a0,1
    13a8:	00004097          	auipc	ra,0x4
    13ac:	31e080e7          	jalr	798(ra) # 56c6 <exit>

00000000000013b0 <truncate3>:
{
    13b0:	7159                	add	sp,sp,-112
    13b2:	f486                	sd	ra,104(sp)
    13b4:	f0a2                	sd	s0,96(sp)
    13b6:	e8ca                	sd	s2,80(sp)
    13b8:	1880                	add	s0,sp,112
    13ba:	892a                	mv	s2,a0
  close(open("truncfile", O_CREATE|O_TRUNC|O_WRONLY));
    13bc:	60100593          	li	a1,1537
    13c0:	00005517          	auipc	a0,0x5
    13c4:	b5050513          	add	a0,a0,-1200 # 5f10 <malloc+0x192>
    13c8:	00004097          	auipc	ra,0x4
    13cc:	33e080e7          	jalr	830(ra) # 5706 <open>
    13d0:	00004097          	auipc	ra,0x4
    13d4:	31e080e7          	jalr	798(ra) # 56ee <close>
  pid = fork();
    13d8:	00004097          	auipc	ra,0x4
    13dc:	2e6080e7          	jalr	742(ra) # 56be <fork>
  if(pid < 0){
    13e0:	08054463          	bltz	a0,1468 <truncate3+0xb8>
  if(pid == 0){
    13e4:	e16d                	bnez	a0,14c6 <truncate3+0x116>
    13e6:	eca6                	sd	s1,88(sp)
    13e8:	e4ce                	sd	s3,72(sp)
    13ea:	e0d2                	sd	s4,64(sp)
    13ec:	fc56                	sd	s5,56(sp)
    13ee:	06400993          	li	s3,100
      int fd = open("truncfile", O_WRONLY);
    13f2:	00005a17          	auipc	s4,0x5
    13f6:	b1ea0a13          	add	s4,s4,-1250 # 5f10 <malloc+0x192>
      int n = write(fd, "1234567890", 10);
    13fa:	00005a97          	auipc	s5,0x5
    13fe:	356a8a93          	add	s5,s5,854 # 6750 <malloc+0x9d2>
      int fd = open("truncfile", O_WRONLY);
    1402:	4585                	li	a1,1
    1404:	8552                	mv	a0,s4
    1406:	00004097          	auipc	ra,0x4
    140a:	300080e7          	jalr	768(ra) # 5706 <open>
    140e:	84aa                	mv	s1,a0
      if(fd < 0){
    1410:	06054e63          	bltz	a0,148c <truncate3+0xdc>
      int n = write(fd, "1234567890", 10);
    1414:	4629                	li	a2,10
    1416:	85d6                	mv	a1,s5
    1418:	00004097          	auipc	ra,0x4
    141c:	2ce080e7          	jalr	718(ra) # 56e6 <write>
      if(n != 10){
    1420:	47a9                	li	a5,10
    1422:	08f51363          	bne	a0,a5,14a8 <truncate3+0xf8>
      close(fd);
    1426:	8526                	mv	a0,s1
    1428:	00004097          	auipc	ra,0x4
    142c:	2c6080e7          	jalr	710(ra) # 56ee <close>
      fd = open("truncfile", O_RDONLY);
    1430:	4581                	li	a1,0
    1432:	8552                	mv	a0,s4
    1434:	00004097          	auipc	ra,0x4
    1438:	2d2080e7          	jalr	722(ra) # 5706 <open>
    143c:	84aa                	mv	s1,a0
      read(fd, buf, sizeof(buf));
    143e:	02000613          	li	a2,32
    1442:	f9840593          	add	a1,s0,-104
    1446:	00004097          	auipc	ra,0x4
    144a:	298080e7          	jalr	664(ra) # 56de <read>
      close(fd);
    144e:	8526                	mv	a0,s1
    1450:	00004097          	auipc	ra,0x4
    1454:	29e080e7          	jalr	670(ra) # 56ee <close>
    for(int i = 0; i < 100; i++){
    1458:	39fd                	addw	s3,s3,-1
    145a:	fa0994e3          	bnez	s3,1402 <truncate3+0x52>
    exit(0);
    145e:	4501                	li	a0,0
    1460:	00004097          	auipc	ra,0x4
    1464:	266080e7          	jalr	614(ra) # 56c6 <exit>
    1468:	eca6                	sd	s1,88(sp)
    146a:	e4ce                	sd	s3,72(sp)
    146c:	e0d2                	sd	s4,64(sp)
    146e:	fc56                	sd	s5,56(sp)
    printf("%s: fork failed\n", s);
    1470:	85ca                	mv	a1,s2
    1472:	00005517          	auipc	a0,0x5
    1476:	2ae50513          	add	a0,a0,686 # 6720 <malloc+0x9a2>
    147a:	00004097          	auipc	ra,0x4
    147e:	684080e7          	jalr	1668(ra) # 5afe <printf>
    exit(1);
    1482:	4505                	li	a0,1
    1484:	00004097          	auipc	ra,0x4
    1488:	242080e7          	jalr	578(ra) # 56c6 <exit>
        printf("%s: open failed\n", s);
    148c:	85ca                	mv	a1,s2
    148e:	00005517          	auipc	a0,0x5
    1492:	2aa50513          	add	a0,a0,682 # 6738 <malloc+0x9ba>
    1496:	00004097          	auipc	ra,0x4
    149a:	668080e7          	jalr	1640(ra) # 5afe <printf>
        exit(1);
    149e:	4505                	li	a0,1
    14a0:	00004097          	auipc	ra,0x4
    14a4:	226080e7          	jalr	550(ra) # 56c6 <exit>
        printf("%s: write got %d, expected 10\n", s, n);
    14a8:	862a                	mv	a2,a0
    14aa:	85ca                	mv	a1,s2
    14ac:	00005517          	auipc	a0,0x5
    14b0:	2b450513          	add	a0,a0,692 # 6760 <malloc+0x9e2>
    14b4:	00004097          	auipc	ra,0x4
    14b8:	64a080e7          	jalr	1610(ra) # 5afe <printf>
        exit(1);
    14bc:	4505                	li	a0,1
    14be:	00004097          	auipc	ra,0x4
    14c2:	208080e7          	jalr	520(ra) # 56c6 <exit>
    14c6:	eca6                	sd	s1,88(sp)
    14c8:	e4ce                	sd	s3,72(sp)
    14ca:	e0d2                	sd	s4,64(sp)
    14cc:	fc56                	sd	s5,56(sp)
    14ce:	09600993          	li	s3,150
    int fd = open("truncfile", O_CREATE|O_WRONLY|O_TRUNC);
    14d2:	00005a17          	auipc	s4,0x5
    14d6:	a3ea0a13          	add	s4,s4,-1474 # 5f10 <malloc+0x192>
    int n = write(fd, "xxx", 3);
    14da:	00005a97          	auipc	s5,0x5
    14de:	2a6a8a93          	add	s5,s5,678 # 6780 <malloc+0xa02>
    int fd = open("truncfile", O_CREATE|O_WRONLY|O_TRUNC);
    14e2:	60100593          	li	a1,1537
    14e6:	8552                	mv	a0,s4
    14e8:	00004097          	auipc	ra,0x4
    14ec:	21e080e7          	jalr	542(ra) # 5706 <open>
    14f0:	84aa                	mv	s1,a0
    if(fd < 0){
    14f2:	04054763          	bltz	a0,1540 <truncate3+0x190>
    int n = write(fd, "xxx", 3);
    14f6:	460d                	li	a2,3
    14f8:	85d6                	mv	a1,s5
    14fa:	00004097          	auipc	ra,0x4
    14fe:	1ec080e7          	jalr	492(ra) # 56e6 <write>
    if(n != 3){
    1502:	478d                	li	a5,3
    1504:	04f51c63          	bne	a0,a5,155c <truncate3+0x1ac>
    close(fd);
    1508:	8526                	mv	a0,s1
    150a:	00004097          	auipc	ra,0x4
    150e:	1e4080e7          	jalr	484(ra) # 56ee <close>
  for(int i = 0; i < 150; i++){
    1512:	39fd                	addw	s3,s3,-1
    1514:	fc0997e3          	bnez	s3,14e2 <truncate3+0x132>
  wait(&xstatus);
    1518:	fbc40513          	add	a0,s0,-68
    151c:	00004097          	auipc	ra,0x4
    1520:	1b2080e7          	jalr	434(ra) # 56ce <wait>
  unlink("truncfile");
    1524:	00005517          	auipc	a0,0x5
    1528:	9ec50513          	add	a0,a0,-1556 # 5f10 <malloc+0x192>
    152c:	00004097          	auipc	ra,0x4
    1530:	1ea080e7          	jalr	490(ra) # 5716 <unlink>
  exit(xstatus);
    1534:	fbc42503          	lw	a0,-68(s0)
    1538:	00004097          	auipc	ra,0x4
    153c:	18e080e7          	jalr	398(ra) # 56c6 <exit>
      printf("%s: open failed\n", s);
    1540:	85ca                	mv	a1,s2
    1542:	00005517          	auipc	a0,0x5
    1546:	1f650513          	add	a0,a0,502 # 6738 <malloc+0x9ba>
    154a:	00004097          	auipc	ra,0x4
    154e:	5b4080e7          	jalr	1460(ra) # 5afe <printf>
      exit(1);
    1552:	4505                	li	a0,1
    1554:	00004097          	auipc	ra,0x4
    1558:	172080e7          	jalr	370(ra) # 56c6 <exit>
      printf("%s: write got %d, expected 3\n", s, n);
    155c:	862a                	mv	a2,a0
    155e:	85ca                	mv	a1,s2
    1560:	00005517          	auipc	a0,0x5
    1564:	22850513          	add	a0,a0,552 # 6788 <malloc+0xa0a>
    1568:	00004097          	auipc	ra,0x4
    156c:	596080e7          	jalr	1430(ra) # 5afe <printf>
      exit(1);
    1570:	4505                	li	a0,1
    1572:	00004097          	auipc	ra,0x4
    1576:	154080e7          	jalr	340(ra) # 56c6 <exit>

000000000000157a <exectest>:
{
    157a:	715d                	add	sp,sp,-80
    157c:	e486                	sd	ra,72(sp)
    157e:	e0a2                	sd	s0,64(sp)
    1580:	f84a                	sd	s2,48(sp)
    1582:	0880                	add	s0,sp,80
    1584:	892a                	mv	s2,a0
  char *echoargv[] = { "echo", "OK", 0 };
    1586:	00005797          	auipc	a5,0x5
    158a:	93278793          	add	a5,a5,-1742 # 5eb8 <malloc+0x13a>
    158e:	fcf43023          	sd	a5,-64(s0)
    1592:	00005797          	auipc	a5,0x5
    1596:	21678793          	add	a5,a5,534 # 67a8 <malloc+0xa2a>
    159a:	fcf43423          	sd	a5,-56(s0)
    159e:	fc043823          	sd	zero,-48(s0)
  unlink("echo-ok");
    15a2:	00005517          	auipc	a0,0x5
    15a6:	20e50513          	add	a0,a0,526 # 67b0 <malloc+0xa32>
    15aa:	00004097          	auipc	ra,0x4
    15ae:	16c080e7          	jalr	364(ra) # 5716 <unlink>
  pid = fork();
    15b2:	00004097          	auipc	ra,0x4
    15b6:	10c080e7          	jalr	268(ra) # 56be <fork>
  if(pid < 0) {
    15ba:	04054763          	bltz	a0,1608 <exectest+0x8e>
    15be:	fc26                	sd	s1,56(sp)
    15c0:	84aa                	mv	s1,a0
  if(pid == 0) {
    15c2:	ed41                	bnez	a0,165a <exectest+0xe0>
    close(1);
    15c4:	4505                	li	a0,1
    15c6:	00004097          	auipc	ra,0x4
    15ca:	128080e7          	jalr	296(ra) # 56ee <close>
    fd = open("echo-ok", O_CREATE|O_WRONLY);
    15ce:	20100593          	li	a1,513
    15d2:	00005517          	auipc	a0,0x5
    15d6:	1de50513          	add	a0,a0,478 # 67b0 <malloc+0xa32>
    15da:	00004097          	auipc	ra,0x4
    15de:	12c080e7          	jalr	300(ra) # 5706 <open>
    if(fd < 0) {
    15e2:	04054263          	bltz	a0,1626 <exectest+0xac>
    if(fd != 1) {
    15e6:	4785                	li	a5,1
    15e8:	04f50d63          	beq	a0,a5,1642 <exectest+0xc8>
      printf("%s: wrong fd\n", s);
    15ec:	85ca                	mv	a1,s2
    15ee:	00005517          	auipc	a0,0x5
    15f2:	1e250513          	add	a0,a0,482 # 67d0 <malloc+0xa52>
    15f6:	00004097          	auipc	ra,0x4
    15fa:	508080e7          	jalr	1288(ra) # 5afe <printf>
      exit(1);
    15fe:	4505                	li	a0,1
    1600:	00004097          	auipc	ra,0x4
    1604:	0c6080e7          	jalr	198(ra) # 56c6 <exit>
    1608:	fc26                	sd	s1,56(sp)
     printf("%s: fork failed\n", s);
    160a:	85ca                	mv	a1,s2
    160c:	00005517          	auipc	a0,0x5
    1610:	11450513          	add	a0,a0,276 # 6720 <malloc+0x9a2>
    1614:	00004097          	auipc	ra,0x4
    1618:	4ea080e7          	jalr	1258(ra) # 5afe <printf>
     exit(1);
    161c:	4505                	li	a0,1
    161e:	00004097          	auipc	ra,0x4
    1622:	0a8080e7          	jalr	168(ra) # 56c6 <exit>
      printf("%s: create failed\n", s);
    1626:	85ca                	mv	a1,s2
    1628:	00005517          	auipc	a0,0x5
    162c:	19050513          	add	a0,a0,400 # 67b8 <malloc+0xa3a>
    1630:	00004097          	auipc	ra,0x4
    1634:	4ce080e7          	jalr	1230(ra) # 5afe <printf>
      exit(1);
    1638:	4505                	li	a0,1
    163a:	00004097          	auipc	ra,0x4
    163e:	08c080e7          	jalr	140(ra) # 56c6 <exit>
    if(exec("echo", echoargv) < 0){
    1642:	fc040593          	add	a1,s0,-64
    1646:	00005517          	auipc	a0,0x5
    164a:	87250513          	add	a0,a0,-1934 # 5eb8 <malloc+0x13a>
    164e:	00004097          	auipc	ra,0x4
    1652:	0b0080e7          	jalr	176(ra) # 56fe <exec>
    1656:	02054163          	bltz	a0,1678 <exectest+0xfe>
  if (wait(&xstatus) != pid) {
    165a:	fdc40513          	add	a0,s0,-36
    165e:	00004097          	auipc	ra,0x4
    1662:	070080e7          	jalr	112(ra) # 56ce <wait>
    1666:	02951763          	bne	a0,s1,1694 <exectest+0x11a>
  if(xstatus != 0)
    166a:	fdc42503          	lw	a0,-36(s0)
    166e:	cd0d                	beqz	a0,16a8 <exectest+0x12e>
    exit(xstatus);
    1670:	00004097          	auipc	ra,0x4
    1674:	056080e7          	jalr	86(ra) # 56c6 <exit>
      printf("%s: exec echo failed\n", s);
    1678:	85ca                	mv	a1,s2
    167a:	00005517          	auipc	a0,0x5
    167e:	16650513          	add	a0,a0,358 # 67e0 <malloc+0xa62>
    1682:	00004097          	auipc	ra,0x4
    1686:	47c080e7          	jalr	1148(ra) # 5afe <printf>
      exit(1);
    168a:	4505                	li	a0,1
    168c:	00004097          	auipc	ra,0x4
    1690:	03a080e7          	jalr	58(ra) # 56c6 <exit>
    printf("%s: wait failed!\n", s);
    1694:	85ca                	mv	a1,s2
    1696:	00005517          	auipc	a0,0x5
    169a:	16250513          	add	a0,a0,354 # 67f8 <malloc+0xa7a>
    169e:	00004097          	auipc	ra,0x4
    16a2:	460080e7          	jalr	1120(ra) # 5afe <printf>
    16a6:	b7d1                	j	166a <exectest+0xf0>
  fd = open("echo-ok", O_RDONLY);
    16a8:	4581                	li	a1,0
    16aa:	00005517          	auipc	a0,0x5
    16ae:	10650513          	add	a0,a0,262 # 67b0 <malloc+0xa32>
    16b2:	00004097          	auipc	ra,0x4
    16b6:	054080e7          	jalr	84(ra) # 5706 <open>
  if(fd < 0) {
    16ba:	02054a63          	bltz	a0,16ee <exectest+0x174>
  if (read(fd, buf, 2) != 2) {
    16be:	4609                	li	a2,2
    16c0:	fb840593          	add	a1,s0,-72
    16c4:	00004097          	auipc	ra,0x4
    16c8:	01a080e7          	jalr	26(ra) # 56de <read>
    16cc:	4789                	li	a5,2
    16ce:	02f50e63          	beq	a0,a5,170a <exectest+0x190>
    printf("%s: read failed\n", s);
    16d2:	85ca                	mv	a1,s2
    16d4:	00005517          	auipc	a0,0x5
    16d8:	b9450513          	add	a0,a0,-1132 # 6268 <malloc+0x4ea>
    16dc:	00004097          	auipc	ra,0x4
    16e0:	422080e7          	jalr	1058(ra) # 5afe <printf>
    exit(1);
    16e4:	4505                	li	a0,1
    16e6:	00004097          	auipc	ra,0x4
    16ea:	fe0080e7          	jalr	-32(ra) # 56c6 <exit>
    printf("%s: open failed\n", s);
    16ee:	85ca                	mv	a1,s2
    16f0:	00005517          	auipc	a0,0x5
    16f4:	04850513          	add	a0,a0,72 # 6738 <malloc+0x9ba>
    16f8:	00004097          	auipc	ra,0x4
    16fc:	406080e7          	jalr	1030(ra) # 5afe <printf>
    exit(1);
    1700:	4505                	li	a0,1
    1702:	00004097          	auipc	ra,0x4
    1706:	fc4080e7          	jalr	-60(ra) # 56c6 <exit>
  unlink("echo-ok");
    170a:	00005517          	auipc	a0,0x5
    170e:	0a650513          	add	a0,a0,166 # 67b0 <malloc+0xa32>
    1712:	00004097          	auipc	ra,0x4
    1716:	004080e7          	jalr	4(ra) # 5716 <unlink>
  if(buf[0] == 'O' && buf[1] == 'K')
    171a:	fb844703          	lbu	a4,-72(s0)
    171e:	04f00793          	li	a5,79
    1722:	00f71863          	bne	a4,a5,1732 <exectest+0x1b8>
    1726:	fb944703          	lbu	a4,-71(s0)
    172a:	04b00793          	li	a5,75
    172e:	02f70063          	beq	a4,a5,174e <exectest+0x1d4>
    printf("%s: wrong output\n", s);
    1732:	85ca                	mv	a1,s2
    1734:	00005517          	auipc	a0,0x5
    1738:	0dc50513          	add	a0,a0,220 # 6810 <malloc+0xa92>
    173c:	00004097          	auipc	ra,0x4
    1740:	3c2080e7          	jalr	962(ra) # 5afe <printf>
    exit(1);
    1744:	4505                	li	a0,1
    1746:	00004097          	auipc	ra,0x4
    174a:	f80080e7          	jalr	-128(ra) # 56c6 <exit>
    exit(0);
    174e:	4501                	li	a0,0
    1750:	00004097          	auipc	ra,0x4
    1754:	f76080e7          	jalr	-138(ra) # 56c6 <exit>

0000000000001758 <pipe1>:
{
    1758:	711d                	add	sp,sp,-96
    175a:	ec86                	sd	ra,88(sp)
    175c:	e8a2                	sd	s0,80(sp)
    175e:	fc4e                	sd	s3,56(sp)
    1760:	1080                	add	s0,sp,96
    1762:	89aa                	mv	s3,a0
  if(pipe(fds) != 0){
    1764:	fa840513          	add	a0,s0,-88
    1768:	00004097          	auipc	ra,0x4
    176c:	f6e080e7          	jalr	-146(ra) # 56d6 <pipe>
    1770:	ed3d                	bnez	a0,17ee <pipe1+0x96>
    1772:	e4a6                	sd	s1,72(sp)
    1774:	f852                	sd	s4,48(sp)
    1776:	84aa                	mv	s1,a0
  pid = fork();
    1778:	00004097          	auipc	ra,0x4
    177c:	f46080e7          	jalr	-186(ra) # 56be <fork>
    1780:	8a2a                	mv	s4,a0
  if(pid == 0){
    1782:	c951                	beqz	a0,1816 <pipe1+0xbe>
  } else if(pid > 0){
    1784:	18a05b63          	blez	a0,191a <pipe1+0x1c2>
    1788:	e0ca                	sd	s2,64(sp)
    178a:	f456                	sd	s5,40(sp)
    close(fds[1]);
    178c:	fac42503          	lw	a0,-84(s0)
    1790:	00004097          	auipc	ra,0x4
    1794:	f5e080e7          	jalr	-162(ra) # 56ee <close>
    total = 0;
    1798:	8a26                	mv	s4,s1
    cc = 1;
    179a:	4905                	li	s2,1
    while((n = read(fds[0], buf, cc)) > 0){
    179c:	0000aa97          	auipc	s5,0xa
    17a0:	6b4a8a93          	add	s5,s5,1716 # be50 <buf>
    17a4:	864a                	mv	a2,s2
    17a6:	85d6                	mv	a1,s5
    17a8:	fa842503          	lw	a0,-88(s0)
    17ac:	00004097          	auipc	ra,0x4
    17b0:	f32080e7          	jalr	-206(ra) # 56de <read>
    17b4:	10a05a63          	blez	a0,18c8 <pipe1+0x170>
      for(i = 0; i < n; i++){
    17b8:	0000a717          	auipc	a4,0xa
    17bc:	69870713          	add	a4,a4,1688 # be50 <buf>
    17c0:	00a4863b          	addw	a2,s1,a0
        if((buf[i] & 0xff) != (seq++ & 0xff)){
    17c4:	00074683          	lbu	a3,0(a4)
    17c8:	0ff4f793          	zext.b	a5,s1
    17cc:	2485                	addw	s1,s1,1
    17ce:	0cf69b63          	bne	a3,a5,18a4 <pipe1+0x14c>
      for(i = 0; i < n; i++){
    17d2:	0705                	add	a4,a4,1
    17d4:	fec498e3          	bne	s1,a2,17c4 <pipe1+0x6c>
      total += n;
    17d8:	00aa0a3b          	addw	s4,s4,a0
      cc = cc * 2;
    17dc:	0019179b          	sllw	a5,s2,0x1
    17e0:	0007891b          	sext.w	s2,a5
      if(cc > sizeof(buf))
    17e4:	670d                	lui	a4,0x3
    17e6:	fb277fe3          	bgeu	a4,s2,17a4 <pipe1+0x4c>
        cc = sizeof(buf);
    17ea:	690d                	lui	s2,0x3
    17ec:	bf65                	j	17a4 <pipe1+0x4c>
    17ee:	e4a6                	sd	s1,72(sp)
    17f0:	e0ca                	sd	s2,64(sp)
    17f2:	f852                	sd	s4,48(sp)
    17f4:	f456                	sd	s5,40(sp)
    17f6:	f05a                	sd	s6,32(sp)
    17f8:	ec5e                	sd	s7,24(sp)
    printf("%s: pipe() failed\n", s);
    17fa:	85ce                	mv	a1,s3
    17fc:	00005517          	auipc	a0,0x5
    1800:	02c50513          	add	a0,a0,44 # 6828 <malloc+0xaaa>
    1804:	00004097          	auipc	ra,0x4
    1808:	2fa080e7          	jalr	762(ra) # 5afe <printf>
    exit(1);
    180c:	4505                	li	a0,1
    180e:	00004097          	auipc	ra,0x4
    1812:	eb8080e7          	jalr	-328(ra) # 56c6 <exit>
    1816:	e0ca                	sd	s2,64(sp)
    1818:	f456                	sd	s5,40(sp)
    181a:	f05a                	sd	s6,32(sp)
    181c:	ec5e                	sd	s7,24(sp)
    close(fds[0]);
    181e:	fa842503          	lw	a0,-88(s0)
    1822:	00004097          	auipc	ra,0x4
    1826:	ecc080e7          	jalr	-308(ra) # 56ee <close>
    for(n = 0; n < N; n++){
    182a:	0000ab17          	auipc	s6,0xa
    182e:	626b0b13          	add	s6,s6,1574 # be50 <buf>
    1832:	416004bb          	negw	s1,s6
    1836:	0ff4f493          	zext.b	s1,s1
    183a:	409b0913          	add	s2,s6,1033
      if(write(fds[1], buf, SZ) != SZ){
    183e:	8bda                	mv	s7,s6
    for(n = 0; n < N; n++){
    1840:	6a85                	lui	s5,0x1
    1842:	42da8a93          	add	s5,s5,1069 # 142d <truncate3+0x7d>
{
    1846:	87da                	mv	a5,s6
        buf[i] = seq++;
    1848:	0097873b          	addw	a4,a5,s1
    184c:	00e78023          	sb	a4,0(a5)
      for(i = 0; i < SZ; i++)
    1850:	0785                	add	a5,a5,1
    1852:	ff279be3          	bne	a5,s2,1848 <pipe1+0xf0>
    1856:	409a0a1b          	addw	s4,s4,1033
      if(write(fds[1], buf, SZ) != SZ){
    185a:	40900613          	li	a2,1033
    185e:	85de                	mv	a1,s7
    1860:	fac42503          	lw	a0,-84(s0)
    1864:	00004097          	auipc	ra,0x4
    1868:	e82080e7          	jalr	-382(ra) # 56e6 <write>
    186c:	40900793          	li	a5,1033
    1870:	00f51c63          	bne	a0,a5,1888 <pipe1+0x130>
    for(n = 0; n < N; n++){
    1874:	24a5                	addw	s1,s1,9
    1876:	0ff4f493          	zext.b	s1,s1
    187a:	fd5a16e3          	bne	s4,s5,1846 <pipe1+0xee>
    exit(0);
    187e:	4501                	li	a0,0
    1880:	00004097          	auipc	ra,0x4
    1884:	e46080e7          	jalr	-442(ra) # 56c6 <exit>
        printf("%s: pipe1 oops 1\n", s);
    1888:	85ce                	mv	a1,s3
    188a:	00005517          	auipc	a0,0x5
    188e:	fb650513          	add	a0,a0,-74 # 6840 <malloc+0xac2>
    1892:	00004097          	auipc	ra,0x4
    1896:	26c080e7          	jalr	620(ra) # 5afe <printf>
        exit(1);
    189a:	4505                	li	a0,1
    189c:	00004097          	auipc	ra,0x4
    18a0:	e2a080e7          	jalr	-470(ra) # 56c6 <exit>
          printf("%s: pipe1 oops 2\n", s);
    18a4:	85ce                	mv	a1,s3
    18a6:	00005517          	auipc	a0,0x5
    18aa:	fb250513          	add	a0,a0,-78 # 6858 <malloc+0xada>
    18ae:	00004097          	auipc	ra,0x4
    18b2:	250080e7          	jalr	592(ra) # 5afe <printf>
          return;
    18b6:	64a6                	ld	s1,72(sp)
    18b8:	6906                	ld	s2,64(sp)
    18ba:	7a42                	ld	s4,48(sp)
    18bc:	7aa2                	ld	s5,40(sp)
}
    18be:	60e6                	ld	ra,88(sp)
    18c0:	6446                	ld	s0,80(sp)
    18c2:	79e2                	ld	s3,56(sp)
    18c4:	6125                	add	sp,sp,96
    18c6:	8082                	ret
    if(total != N * SZ){
    18c8:	6785                	lui	a5,0x1
    18ca:	42d78793          	add	a5,a5,1069 # 142d <truncate3+0x7d>
    18ce:	02fa0263          	beq	s4,a5,18f2 <pipe1+0x19a>
    18d2:	f05a                	sd	s6,32(sp)
    18d4:	ec5e                	sd	s7,24(sp)
      printf("%s: pipe1 oops 3 total %d\n", total);
    18d6:	85d2                	mv	a1,s4
    18d8:	00005517          	auipc	a0,0x5
    18dc:	f9850513          	add	a0,a0,-104 # 6870 <malloc+0xaf2>
    18e0:	00004097          	auipc	ra,0x4
    18e4:	21e080e7          	jalr	542(ra) # 5afe <printf>
      exit(1);
    18e8:	4505                	li	a0,1
    18ea:	00004097          	auipc	ra,0x4
    18ee:	ddc080e7          	jalr	-548(ra) # 56c6 <exit>
    18f2:	f05a                	sd	s6,32(sp)
    18f4:	ec5e                	sd	s7,24(sp)
    close(fds[0]);
    18f6:	fa842503          	lw	a0,-88(s0)
    18fa:	00004097          	auipc	ra,0x4
    18fe:	df4080e7          	jalr	-524(ra) # 56ee <close>
    wait(&xstatus);
    1902:	fa440513          	add	a0,s0,-92
    1906:	00004097          	auipc	ra,0x4
    190a:	dc8080e7          	jalr	-568(ra) # 56ce <wait>
    exit(xstatus);
    190e:	fa442503          	lw	a0,-92(s0)
    1912:	00004097          	auipc	ra,0x4
    1916:	db4080e7          	jalr	-588(ra) # 56c6 <exit>
    191a:	e0ca                	sd	s2,64(sp)
    191c:	f456                	sd	s5,40(sp)
    191e:	f05a                	sd	s6,32(sp)
    1920:	ec5e                	sd	s7,24(sp)
    printf("%s: fork() failed\n", s);
    1922:	85ce                	mv	a1,s3
    1924:	00005517          	auipc	a0,0x5
    1928:	f6c50513          	add	a0,a0,-148 # 6890 <malloc+0xb12>
    192c:	00004097          	auipc	ra,0x4
    1930:	1d2080e7          	jalr	466(ra) # 5afe <printf>
    exit(1);
    1934:	4505                	li	a0,1
    1936:	00004097          	auipc	ra,0x4
    193a:	d90080e7          	jalr	-624(ra) # 56c6 <exit>

000000000000193e <exitwait>:
{
    193e:	7139                	add	sp,sp,-64
    1940:	fc06                	sd	ra,56(sp)
    1942:	f822                	sd	s0,48(sp)
    1944:	f426                	sd	s1,40(sp)
    1946:	f04a                	sd	s2,32(sp)
    1948:	ec4e                	sd	s3,24(sp)
    194a:	e852                	sd	s4,16(sp)
    194c:	0080                	add	s0,sp,64
    194e:	8a2a                	mv	s4,a0
  for(i = 0; i < 100; i++){
    1950:	4901                	li	s2,0
    1952:	06400993          	li	s3,100
    pid = fork();
    1956:	00004097          	auipc	ra,0x4
    195a:	d68080e7          	jalr	-664(ra) # 56be <fork>
    195e:	84aa                	mv	s1,a0
    if(pid < 0){
    1960:	02054a63          	bltz	a0,1994 <exitwait+0x56>
    if(pid){
    1964:	c151                	beqz	a0,19e8 <exitwait+0xaa>
      if(wait(&xstate) != pid){
    1966:	fcc40513          	add	a0,s0,-52
    196a:	00004097          	auipc	ra,0x4
    196e:	d64080e7          	jalr	-668(ra) # 56ce <wait>
    1972:	02951f63          	bne	a0,s1,19b0 <exitwait+0x72>
      if(i != xstate) {
    1976:	fcc42783          	lw	a5,-52(s0)
    197a:	05279963          	bne	a5,s2,19cc <exitwait+0x8e>
  for(i = 0; i < 100; i++){
    197e:	2905                	addw	s2,s2,1 # 3001 <dirtest+0x29>
    1980:	fd391be3          	bne	s2,s3,1956 <exitwait+0x18>
}
    1984:	70e2                	ld	ra,56(sp)
    1986:	7442                	ld	s0,48(sp)
    1988:	74a2                	ld	s1,40(sp)
    198a:	7902                	ld	s2,32(sp)
    198c:	69e2                	ld	s3,24(sp)
    198e:	6a42                	ld	s4,16(sp)
    1990:	6121                	add	sp,sp,64
    1992:	8082                	ret
      printf("%s: fork failed\n", s);
    1994:	85d2                	mv	a1,s4
    1996:	00005517          	auipc	a0,0x5
    199a:	d8a50513          	add	a0,a0,-630 # 6720 <malloc+0x9a2>
    199e:	00004097          	auipc	ra,0x4
    19a2:	160080e7          	jalr	352(ra) # 5afe <printf>
      exit(1);
    19a6:	4505                	li	a0,1
    19a8:	00004097          	auipc	ra,0x4
    19ac:	d1e080e7          	jalr	-738(ra) # 56c6 <exit>
        printf("%s: wait wrong pid\n", s);
    19b0:	85d2                	mv	a1,s4
    19b2:	00005517          	auipc	a0,0x5
    19b6:	ef650513          	add	a0,a0,-266 # 68a8 <malloc+0xb2a>
    19ba:	00004097          	auipc	ra,0x4
    19be:	144080e7          	jalr	324(ra) # 5afe <printf>
        exit(1);
    19c2:	4505                	li	a0,1
    19c4:	00004097          	auipc	ra,0x4
    19c8:	d02080e7          	jalr	-766(ra) # 56c6 <exit>
        printf("%s: wait wrong exit status\n", s);
    19cc:	85d2                	mv	a1,s4
    19ce:	00005517          	auipc	a0,0x5
    19d2:	ef250513          	add	a0,a0,-270 # 68c0 <malloc+0xb42>
    19d6:	00004097          	auipc	ra,0x4
    19da:	128080e7          	jalr	296(ra) # 5afe <printf>
        exit(1);
    19de:	4505                	li	a0,1
    19e0:	00004097          	auipc	ra,0x4
    19e4:	ce6080e7          	jalr	-794(ra) # 56c6 <exit>
      exit(i);
    19e8:	854a                	mv	a0,s2
    19ea:	00004097          	auipc	ra,0x4
    19ee:	cdc080e7          	jalr	-804(ra) # 56c6 <exit>

00000000000019f2 <twochildren>:
{
    19f2:	1101                	add	sp,sp,-32
    19f4:	ec06                	sd	ra,24(sp)
    19f6:	e822                	sd	s0,16(sp)
    19f8:	e426                	sd	s1,8(sp)
    19fa:	e04a                	sd	s2,0(sp)
    19fc:	1000                	add	s0,sp,32
    19fe:	892a                	mv	s2,a0
    1a00:	3e800493          	li	s1,1000
    int pid1 = fork();
    1a04:	00004097          	auipc	ra,0x4
    1a08:	cba080e7          	jalr	-838(ra) # 56be <fork>
    if(pid1 < 0){
    1a0c:	02054c63          	bltz	a0,1a44 <twochildren+0x52>
    if(pid1 == 0){
    1a10:	c921                	beqz	a0,1a60 <twochildren+0x6e>
      int pid2 = fork();
    1a12:	00004097          	auipc	ra,0x4
    1a16:	cac080e7          	jalr	-852(ra) # 56be <fork>
      if(pid2 < 0){
    1a1a:	04054763          	bltz	a0,1a68 <twochildren+0x76>
      if(pid2 == 0){
    1a1e:	c13d                	beqz	a0,1a84 <twochildren+0x92>
        wait(0);
    1a20:	4501                	li	a0,0
    1a22:	00004097          	auipc	ra,0x4
    1a26:	cac080e7          	jalr	-852(ra) # 56ce <wait>
        wait(0);
    1a2a:	4501                	li	a0,0
    1a2c:	00004097          	auipc	ra,0x4
    1a30:	ca2080e7          	jalr	-862(ra) # 56ce <wait>
  for(int i = 0; i < 1000; i++){
    1a34:	34fd                	addw	s1,s1,-1
    1a36:	f4f9                	bnez	s1,1a04 <twochildren+0x12>
}
    1a38:	60e2                	ld	ra,24(sp)
    1a3a:	6442                	ld	s0,16(sp)
    1a3c:	64a2                	ld	s1,8(sp)
    1a3e:	6902                	ld	s2,0(sp)
    1a40:	6105                	add	sp,sp,32
    1a42:	8082                	ret
      printf("%s: fork failed\n", s);
    1a44:	85ca                	mv	a1,s2
    1a46:	00005517          	auipc	a0,0x5
    1a4a:	cda50513          	add	a0,a0,-806 # 6720 <malloc+0x9a2>
    1a4e:	00004097          	auipc	ra,0x4
    1a52:	0b0080e7          	jalr	176(ra) # 5afe <printf>
      exit(1);
    1a56:	4505                	li	a0,1
    1a58:	00004097          	auipc	ra,0x4
    1a5c:	c6e080e7          	jalr	-914(ra) # 56c6 <exit>
      exit(0);
    1a60:	00004097          	auipc	ra,0x4
    1a64:	c66080e7          	jalr	-922(ra) # 56c6 <exit>
        printf("%s: fork failed\n", s);
    1a68:	85ca                	mv	a1,s2
    1a6a:	00005517          	auipc	a0,0x5
    1a6e:	cb650513          	add	a0,a0,-842 # 6720 <malloc+0x9a2>
    1a72:	00004097          	auipc	ra,0x4
    1a76:	08c080e7          	jalr	140(ra) # 5afe <printf>
        exit(1);
    1a7a:	4505                	li	a0,1
    1a7c:	00004097          	auipc	ra,0x4
    1a80:	c4a080e7          	jalr	-950(ra) # 56c6 <exit>
        exit(0);
    1a84:	00004097          	auipc	ra,0x4
    1a88:	c42080e7          	jalr	-958(ra) # 56c6 <exit>

0000000000001a8c <forkfork>:
{
    1a8c:	7179                	add	sp,sp,-48
    1a8e:	f406                	sd	ra,40(sp)
    1a90:	f022                	sd	s0,32(sp)
    1a92:	ec26                	sd	s1,24(sp)
    1a94:	1800                	add	s0,sp,48
    1a96:	84aa                	mv	s1,a0
    int pid = fork();
    1a98:	00004097          	auipc	ra,0x4
    1a9c:	c26080e7          	jalr	-986(ra) # 56be <fork>
    if(pid < 0){
    1aa0:	04054163          	bltz	a0,1ae2 <forkfork+0x56>
    if(pid == 0){
    1aa4:	cd29                	beqz	a0,1afe <forkfork+0x72>
    int pid = fork();
    1aa6:	00004097          	auipc	ra,0x4
    1aaa:	c18080e7          	jalr	-1000(ra) # 56be <fork>
    if(pid < 0){
    1aae:	02054a63          	bltz	a0,1ae2 <forkfork+0x56>
    if(pid == 0){
    1ab2:	c531                	beqz	a0,1afe <forkfork+0x72>
    wait(&xstatus);
    1ab4:	fdc40513          	add	a0,s0,-36
    1ab8:	00004097          	auipc	ra,0x4
    1abc:	c16080e7          	jalr	-1002(ra) # 56ce <wait>
    if(xstatus != 0) {
    1ac0:	fdc42783          	lw	a5,-36(s0)
    1ac4:	ebbd                	bnez	a5,1b3a <forkfork+0xae>
    wait(&xstatus);
    1ac6:	fdc40513          	add	a0,s0,-36
    1aca:	00004097          	auipc	ra,0x4
    1ace:	c04080e7          	jalr	-1020(ra) # 56ce <wait>
    if(xstatus != 0) {
    1ad2:	fdc42783          	lw	a5,-36(s0)
    1ad6:	e3b5                	bnez	a5,1b3a <forkfork+0xae>
}
    1ad8:	70a2                	ld	ra,40(sp)
    1ada:	7402                	ld	s0,32(sp)
    1adc:	64e2                	ld	s1,24(sp)
    1ade:	6145                	add	sp,sp,48
    1ae0:	8082                	ret
      printf("%s: fork failed", s);
    1ae2:	85a6                	mv	a1,s1
    1ae4:	00005517          	auipc	a0,0x5
    1ae8:	dfc50513          	add	a0,a0,-516 # 68e0 <malloc+0xb62>
    1aec:	00004097          	auipc	ra,0x4
    1af0:	012080e7          	jalr	18(ra) # 5afe <printf>
      exit(1);
    1af4:	4505                	li	a0,1
    1af6:	00004097          	auipc	ra,0x4
    1afa:	bd0080e7          	jalr	-1072(ra) # 56c6 <exit>
{
    1afe:	0c800493          	li	s1,200
        int pid1 = fork();
    1b02:	00004097          	auipc	ra,0x4
    1b06:	bbc080e7          	jalr	-1092(ra) # 56be <fork>
        if(pid1 < 0){
    1b0a:	00054f63          	bltz	a0,1b28 <forkfork+0x9c>
        if(pid1 == 0){
    1b0e:	c115                	beqz	a0,1b32 <forkfork+0xa6>
        wait(0);
    1b10:	4501                	li	a0,0
    1b12:	00004097          	auipc	ra,0x4
    1b16:	bbc080e7          	jalr	-1092(ra) # 56ce <wait>
      for(int j = 0; j < 200; j++){
    1b1a:	34fd                	addw	s1,s1,-1
    1b1c:	f0fd                	bnez	s1,1b02 <forkfork+0x76>
      exit(0);
    1b1e:	4501                	li	a0,0
    1b20:	00004097          	auipc	ra,0x4
    1b24:	ba6080e7          	jalr	-1114(ra) # 56c6 <exit>
          exit(1);
    1b28:	4505                	li	a0,1
    1b2a:	00004097          	auipc	ra,0x4
    1b2e:	b9c080e7          	jalr	-1124(ra) # 56c6 <exit>
          exit(0);
    1b32:	00004097          	auipc	ra,0x4
    1b36:	b94080e7          	jalr	-1132(ra) # 56c6 <exit>
      printf("%s: fork in child failed", s);
    1b3a:	85a6                	mv	a1,s1
    1b3c:	00005517          	auipc	a0,0x5
    1b40:	db450513          	add	a0,a0,-588 # 68f0 <malloc+0xb72>
    1b44:	00004097          	auipc	ra,0x4
    1b48:	fba080e7          	jalr	-70(ra) # 5afe <printf>
      exit(1);
    1b4c:	4505                	li	a0,1
    1b4e:	00004097          	auipc	ra,0x4
    1b52:	b78080e7          	jalr	-1160(ra) # 56c6 <exit>

0000000000001b56 <reparent2>:
{
    1b56:	1101                	add	sp,sp,-32
    1b58:	ec06                	sd	ra,24(sp)
    1b5a:	e822                	sd	s0,16(sp)
    1b5c:	e426                	sd	s1,8(sp)
    1b5e:	1000                	add	s0,sp,32
    1b60:	32000493          	li	s1,800
    int pid1 = fork();
    1b64:	00004097          	auipc	ra,0x4
    1b68:	b5a080e7          	jalr	-1190(ra) # 56be <fork>
    if(pid1 < 0){
    1b6c:	00054f63          	bltz	a0,1b8a <reparent2+0x34>
    if(pid1 == 0){
    1b70:	c915                	beqz	a0,1ba4 <reparent2+0x4e>
    wait(0);
    1b72:	4501                	li	a0,0
    1b74:	00004097          	auipc	ra,0x4
    1b78:	b5a080e7          	jalr	-1190(ra) # 56ce <wait>
  for(int i = 0; i < 800; i++){
    1b7c:	34fd                	addw	s1,s1,-1
    1b7e:	f0fd                	bnez	s1,1b64 <reparent2+0xe>
  exit(0);
    1b80:	4501                	li	a0,0
    1b82:	00004097          	auipc	ra,0x4
    1b86:	b44080e7          	jalr	-1212(ra) # 56c6 <exit>
      printf("fork failed\n");
    1b8a:	00005517          	auipc	a0,0x5
    1b8e:	f9e50513          	add	a0,a0,-98 # 6b28 <malloc+0xdaa>
    1b92:	00004097          	auipc	ra,0x4
    1b96:	f6c080e7          	jalr	-148(ra) # 5afe <printf>
      exit(1);
    1b9a:	4505                	li	a0,1
    1b9c:	00004097          	auipc	ra,0x4
    1ba0:	b2a080e7          	jalr	-1238(ra) # 56c6 <exit>
      fork();
    1ba4:	00004097          	auipc	ra,0x4
    1ba8:	b1a080e7          	jalr	-1254(ra) # 56be <fork>
      fork();
    1bac:	00004097          	auipc	ra,0x4
    1bb0:	b12080e7          	jalr	-1262(ra) # 56be <fork>
      exit(0);
    1bb4:	4501                	li	a0,0
    1bb6:	00004097          	auipc	ra,0x4
    1bba:	b10080e7          	jalr	-1264(ra) # 56c6 <exit>

0000000000001bbe <createdelete>:
{
    1bbe:	7175                	add	sp,sp,-144
    1bc0:	e506                	sd	ra,136(sp)
    1bc2:	e122                	sd	s0,128(sp)
    1bc4:	fca6                	sd	s1,120(sp)
    1bc6:	f8ca                	sd	s2,112(sp)
    1bc8:	f4ce                	sd	s3,104(sp)
    1bca:	f0d2                	sd	s4,96(sp)
    1bcc:	ecd6                	sd	s5,88(sp)
    1bce:	e8da                	sd	s6,80(sp)
    1bd0:	e4de                	sd	s7,72(sp)
    1bd2:	e0e2                	sd	s8,64(sp)
    1bd4:	fc66                	sd	s9,56(sp)
    1bd6:	0900                	add	s0,sp,144
    1bd8:	8caa                	mv	s9,a0
  for(pi = 0; pi < NCHILD; pi++){
    1bda:	4901                	li	s2,0
    1bdc:	4991                	li	s3,4
    pid = fork();
    1bde:	00004097          	auipc	ra,0x4
    1be2:	ae0080e7          	jalr	-1312(ra) # 56be <fork>
    1be6:	84aa                	mv	s1,a0
    if(pid < 0){
    1be8:	02054f63          	bltz	a0,1c26 <createdelete+0x68>
    if(pid == 0){
    1bec:	c939                	beqz	a0,1c42 <createdelete+0x84>
  for(pi = 0; pi < NCHILD; pi++){
    1bee:	2905                	addw	s2,s2,1
    1bf0:	ff3917e3          	bne	s2,s3,1bde <createdelete+0x20>
    1bf4:	4491                	li	s1,4
    wait(&xstatus);
    1bf6:	f7c40513          	add	a0,s0,-132
    1bfa:	00004097          	auipc	ra,0x4
    1bfe:	ad4080e7          	jalr	-1324(ra) # 56ce <wait>
    if(xstatus != 0)
    1c02:	f7c42903          	lw	s2,-132(s0)
    1c06:	0e091263          	bnez	s2,1cea <createdelete+0x12c>
  for(pi = 0; pi < NCHILD; pi++){
    1c0a:	34fd                	addw	s1,s1,-1
    1c0c:	f4ed                	bnez	s1,1bf6 <createdelete+0x38>
  name[0] = name[1] = name[2] = 0;
    1c0e:	f8040123          	sb	zero,-126(s0)
    1c12:	03000993          	li	s3,48
    1c16:	5a7d                	li	s4,-1
    1c18:	07000c13          	li	s8,112
      if((i == 0 || i >= N/2) && fd < 0){
    1c1c:	4b25                	li	s6,9
      } else if((i >= 1 && i < N/2) && fd >= 0){
    1c1e:	4ba1                	li	s7,8
    for(pi = 0; pi < NCHILD; pi++){
    1c20:	07400a93          	li	s5,116
    1c24:	a28d                	j	1d86 <createdelete+0x1c8>
      printf("fork failed\n", s);
    1c26:	85e6                	mv	a1,s9
    1c28:	00005517          	auipc	a0,0x5
    1c2c:	f0050513          	add	a0,a0,-256 # 6b28 <malloc+0xdaa>
    1c30:	00004097          	auipc	ra,0x4
    1c34:	ece080e7          	jalr	-306(ra) # 5afe <printf>
      exit(1);
    1c38:	4505                	li	a0,1
    1c3a:	00004097          	auipc	ra,0x4
    1c3e:	a8c080e7          	jalr	-1396(ra) # 56c6 <exit>
      name[0] = 'p' + pi;
    1c42:	0709091b          	addw	s2,s2,112
    1c46:	f9240023          	sb	s2,-128(s0)
      name[2] = '\0';
    1c4a:	f8040123          	sb	zero,-126(s0)
      for(i = 0; i < N; i++){
    1c4e:	4951                	li	s2,20
    1c50:	a015                	j	1c74 <createdelete+0xb6>
          printf("%s: create failed\n", s);
    1c52:	85e6                	mv	a1,s9
    1c54:	00005517          	auipc	a0,0x5
    1c58:	b6450513          	add	a0,a0,-1180 # 67b8 <malloc+0xa3a>
    1c5c:	00004097          	auipc	ra,0x4
    1c60:	ea2080e7          	jalr	-350(ra) # 5afe <printf>
          exit(1);
    1c64:	4505                	li	a0,1
    1c66:	00004097          	auipc	ra,0x4
    1c6a:	a60080e7          	jalr	-1440(ra) # 56c6 <exit>
      for(i = 0; i < N; i++){
    1c6e:	2485                	addw	s1,s1,1
    1c70:	07248863          	beq	s1,s2,1ce0 <createdelete+0x122>
        name[1] = '0' + i;
    1c74:	0304879b          	addw	a5,s1,48
    1c78:	f8f400a3          	sb	a5,-127(s0)
        fd = open(name, O_CREATE | O_RDWR);
    1c7c:	20200593          	li	a1,514
    1c80:	f8040513          	add	a0,s0,-128
    1c84:	00004097          	auipc	ra,0x4
    1c88:	a82080e7          	jalr	-1406(ra) # 5706 <open>
        if(fd < 0){
    1c8c:	fc0543e3          	bltz	a0,1c52 <createdelete+0x94>
        close(fd);
    1c90:	00004097          	auipc	ra,0x4
    1c94:	a5e080e7          	jalr	-1442(ra) # 56ee <close>
        if(i > 0 && (i % 2 ) == 0){
    1c98:	12905763          	blez	s1,1dc6 <createdelete+0x208>
    1c9c:	0014f793          	and	a5,s1,1
    1ca0:	f7f9                	bnez	a5,1c6e <createdelete+0xb0>
          name[1] = '0' + (i / 2);
    1ca2:	01f4d79b          	srlw	a5,s1,0x1f
    1ca6:	9fa5                	addw	a5,a5,s1
    1ca8:	4017d79b          	sraw	a5,a5,0x1
    1cac:	0307879b          	addw	a5,a5,48
    1cb0:	f8f400a3          	sb	a5,-127(s0)
          if(unlink(name) < 0){
    1cb4:	f8040513          	add	a0,s0,-128
    1cb8:	00004097          	auipc	ra,0x4
    1cbc:	a5e080e7          	jalr	-1442(ra) # 5716 <unlink>
    1cc0:	fa0557e3          	bgez	a0,1c6e <createdelete+0xb0>
            printf("%s: unlink failed\n", s);
    1cc4:	85e6                	mv	a1,s9
    1cc6:	00005517          	auipc	a0,0x5
    1cca:	c4a50513          	add	a0,a0,-950 # 6910 <malloc+0xb92>
    1cce:	00004097          	auipc	ra,0x4
    1cd2:	e30080e7          	jalr	-464(ra) # 5afe <printf>
            exit(1);
    1cd6:	4505                	li	a0,1
    1cd8:	00004097          	auipc	ra,0x4
    1cdc:	9ee080e7          	jalr	-1554(ra) # 56c6 <exit>
      exit(0);
    1ce0:	4501                	li	a0,0
    1ce2:	00004097          	auipc	ra,0x4
    1ce6:	9e4080e7          	jalr	-1564(ra) # 56c6 <exit>
      exit(1);
    1cea:	4505                	li	a0,1
    1cec:	00004097          	auipc	ra,0x4
    1cf0:	9da080e7          	jalr	-1574(ra) # 56c6 <exit>
        printf("%s: oops createdelete %s didn't exist\n", s, name);
    1cf4:	f8040613          	add	a2,s0,-128
    1cf8:	85e6                	mv	a1,s9
    1cfa:	00005517          	auipc	a0,0x5
    1cfe:	c2e50513          	add	a0,a0,-978 # 6928 <malloc+0xbaa>
    1d02:	00004097          	auipc	ra,0x4
    1d06:	dfc080e7          	jalr	-516(ra) # 5afe <printf>
        exit(1);
    1d0a:	4505                	li	a0,1
    1d0c:	00004097          	auipc	ra,0x4
    1d10:	9ba080e7          	jalr	-1606(ra) # 56c6 <exit>
      } else if((i >= 1 && i < N/2) && fd >= 0){
    1d14:	034bff63          	bgeu	s7,s4,1d52 <createdelete+0x194>
      if(fd >= 0)
    1d18:	02055863          	bgez	a0,1d48 <createdelete+0x18a>
    for(pi = 0; pi < NCHILD; pi++){
    1d1c:	2485                	addw	s1,s1,1
    1d1e:	0ff4f493          	zext.b	s1,s1
    1d22:	05548a63          	beq	s1,s5,1d76 <createdelete+0x1b8>
      name[0] = 'p' + pi;
    1d26:	f8940023          	sb	s1,-128(s0)
      name[1] = '0' + i;
    1d2a:	f93400a3          	sb	s3,-127(s0)
      fd = open(name, 0);
    1d2e:	4581                	li	a1,0
    1d30:	f8040513          	add	a0,s0,-128
    1d34:	00004097          	auipc	ra,0x4
    1d38:	9d2080e7          	jalr	-1582(ra) # 5706 <open>
      if((i == 0 || i >= N/2) && fd < 0){
    1d3c:	00090463          	beqz	s2,1d44 <createdelete+0x186>
    1d40:	fd2b5ae3          	bge	s6,s2,1d14 <createdelete+0x156>
    1d44:	fa0548e3          	bltz	a0,1cf4 <createdelete+0x136>
        close(fd);
    1d48:	00004097          	auipc	ra,0x4
    1d4c:	9a6080e7          	jalr	-1626(ra) # 56ee <close>
    1d50:	b7f1                	j	1d1c <createdelete+0x15e>
      } else if((i >= 1 && i < N/2) && fd >= 0){
    1d52:	fc0545e3          	bltz	a0,1d1c <createdelete+0x15e>
        printf("%s: oops createdelete %s did exist\n", s, name);
    1d56:	f8040613          	add	a2,s0,-128
    1d5a:	85e6                	mv	a1,s9
    1d5c:	00005517          	auipc	a0,0x5
    1d60:	bf450513          	add	a0,a0,-1036 # 6950 <malloc+0xbd2>
    1d64:	00004097          	auipc	ra,0x4
    1d68:	d9a080e7          	jalr	-614(ra) # 5afe <printf>
        exit(1);
    1d6c:	4505                	li	a0,1
    1d6e:	00004097          	auipc	ra,0x4
    1d72:	958080e7          	jalr	-1704(ra) # 56c6 <exit>
  for(i = 0; i < N; i++){
    1d76:	2905                	addw	s2,s2,1
    1d78:	2a05                	addw	s4,s4,1
    1d7a:	2985                	addw	s3,s3,1
    1d7c:	0ff9f993          	zext.b	s3,s3
    1d80:	47d1                	li	a5,20
    1d82:	02f90a63          	beq	s2,a5,1db6 <createdelete+0x1f8>
    for(pi = 0; pi < NCHILD; pi++){
    1d86:	84e2                	mv	s1,s8
    1d88:	bf79                	j	1d26 <createdelete+0x168>
  for(i = 0; i < N; i++){
    1d8a:	2905                	addw	s2,s2,1
    1d8c:	0ff97913          	zext.b	s2,s2
    1d90:	2985                	addw	s3,s3,1
    1d92:	0ff9f993          	zext.b	s3,s3
    1d96:	03490a63          	beq	s2,s4,1dca <createdelete+0x20c>
  name[0] = name[1] = name[2] = 0;
    1d9a:	84d6                	mv	s1,s5
      name[0] = 'p' + i;
    1d9c:	f9240023          	sb	s2,-128(s0)
      name[1] = '0' + i;
    1da0:	f93400a3          	sb	s3,-127(s0)
      unlink(name);
    1da4:	f8040513          	add	a0,s0,-128
    1da8:	00004097          	auipc	ra,0x4
    1dac:	96e080e7          	jalr	-1682(ra) # 5716 <unlink>
    for(pi = 0; pi < NCHILD; pi++){
    1db0:	34fd                	addw	s1,s1,-1
    1db2:	f4ed                	bnez	s1,1d9c <createdelete+0x1de>
    1db4:	bfd9                	j	1d8a <createdelete+0x1cc>
    1db6:	03000993          	li	s3,48
    1dba:	07000913          	li	s2,112
  name[0] = name[1] = name[2] = 0;
    1dbe:	4a91                	li	s5,4
  for(i = 0; i < N; i++){
    1dc0:	08400a13          	li	s4,132
    1dc4:	bfd9                	j	1d9a <createdelete+0x1dc>
      for(i = 0; i < N; i++){
    1dc6:	2485                	addw	s1,s1,1
    1dc8:	b575                	j	1c74 <createdelete+0xb6>
}
    1dca:	60aa                	ld	ra,136(sp)
    1dcc:	640a                	ld	s0,128(sp)
    1dce:	74e6                	ld	s1,120(sp)
    1dd0:	7946                	ld	s2,112(sp)
    1dd2:	79a6                	ld	s3,104(sp)
    1dd4:	7a06                	ld	s4,96(sp)
    1dd6:	6ae6                	ld	s5,88(sp)
    1dd8:	6b46                	ld	s6,80(sp)
    1dda:	6ba6                	ld	s7,72(sp)
    1ddc:	6c06                	ld	s8,64(sp)
    1dde:	7ce2                	ld	s9,56(sp)
    1de0:	6149                	add	sp,sp,144
    1de2:	8082                	ret

0000000000001de4 <linkunlink>:
{
    1de4:	711d                	add	sp,sp,-96
    1de6:	ec86                	sd	ra,88(sp)
    1de8:	e8a2                	sd	s0,80(sp)
    1dea:	e4a6                	sd	s1,72(sp)
    1dec:	e0ca                	sd	s2,64(sp)
    1dee:	fc4e                	sd	s3,56(sp)
    1df0:	f852                	sd	s4,48(sp)
    1df2:	f456                	sd	s5,40(sp)
    1df4:	f05a                	sd	s6,32(sp)
    1df6:	ec5e                	sd	s7,24(sp)
    1df8:	e862                	sd	s8,16(sp)
    1dfa:	e466                	sd	s9,8(sp)
    1dfc:	1080                	add	s0,sp,96
    1dfe:	84aa                	mv	s1,a0
  unlink("x");
    1e00:	00004517          	auipc	a0,0x4
    1e04:	12850513          	add	a0,a0,296 # 5f28 <malloc+0x1aa>
    1e08:	00004097          	auipc	ra,0x4
    1e0c:	90e080e7          	jalr	-1778(ra) # 5716 <unlink>
  pid = fork();
    1e10:	00004097          	auipc	ra,0x4
    1e14:	8ae080e7          	jalr	-1874(ra) # 56be <fork>
  if(pid < 0){
    1e18:	02054b63          	bltz	a0,1e4e <linkunlink+0x6a>
    1e1c:	8caa                	mv	s9,a0
  unsigned int x = (pid ? 1 : 97);
    1e1e:	06100913          	li	s2,97
    1e22:	c111                	beqz	a0,1e26 <linkunlink+0x42>
    1e24:	4905                	li	s2,1
    1e26:	06400493          	li	s1,100
    x = x * 1103515245 + 12345;
    1e2a:	41c65a37          	lui	s4,0x41c65
    1e2e:	e6da0a1b          	addw	s4,s4,-403 # 41c64e6d <__BSS_END__+0x41c5600d>
    1e32:	698d                	lui	s3,0x3
    1e34:	0399899b          	addw	s3,s3,57 # 3039 <dirtest+0x61>
    if((x % 3) == 0){
    1e38:	4a8d                	li	s5,3
    } else if((x % 3) == 1){
    1e3a:	4b85                	li	s7,1
      unlink("x");
    1e3c:	00004b17          	auipc	s6,0x4
    1e40:	0ecb0b13          	add	s6,s6,236 # 5f28 <malloc+0x1aa>
      link("cat", "x");
    1e44:	00005c17          	auipc	s8,0x5
    1e48:	b34c0c13          	add	s8,s8,-1228 # 6978 <malloc+0xbfa>
    1e4c:	a825                	j	1e84 <linkunlink+0xa0>
    printf("%s: fork failed\n", s);
    1e4e:	85a6                	mv	a1,s1
    1e50:	00005517          	auipc	a0,0x5
    1e54:	8d050513          	add	a0,a0,-1840 # 6720 <malloc+0x9a2>
    1e58:	00004097          	auipc	ra,0x4
    1e5c:	ca6080e7          	jalr	-858(ra) # 5afe <printf>
    exit(1);
    1e60:	4505                	li	a0,1
    1e62:	00004097          	auipc	ra,0x4
    1e66:	864080e7          	jalr	-1948(ra) # 56c6 <exit>
      close(open("x", O_RDWR | O_CREATE));
    1e6a:	20200593          	li	a1,514
    1e6e:	855a                	mv	a0,s6
    1e70:	00004097          	auipc	ra,0x4
    1e74:	896080e7          	jalr	-1898(ra) # 5706 <open>
    1e78:	00004097          	auipc	ra,0x4
    1e7c:	876080e7          	jalr	-1930(ra) # 56ee <close>
  for(i = 0; i < 100; i++){
    1e80:	34fd                	addw	s1,s1,-1
    1e82:	c895                	beqz	s1,1eb6 <linkunlink+0xd2>
    x = x * 1103515245 + 12345;
    1e84:	034907bb          	mulw	a5,s2,s4
    1e88:	013787bb          	addw	a5,a5,s3
    1e8c:	0007891b          	sext.w	s2,a5
    if((x % 3) == 0){
    1e90:	0357f7bb          	remuw	a5,a5,s5
    1e94:	2781                	sext.w	a5,a5
    1e96:	dbf1                	beqz	a5,1e6a <linkunlink+0x86>
    } else if((x % 3) == 1){
    1e98:	01778863          	beq	a5,s7,1ea8 <linkunlink+0xc4>
      unlink("x");
    1e9c:	855a                	mv	a0,s6
    1e9e:	00004097          	auipc	ra,0x4
    1ea2:	878080e7          	jalr	-1928(ra) # 5716 <unlink>
    1ea6:	bfe9                	j	1e80 <linkunlink+0x9c>
      link("cat", "x");
    1ea8:	85da                	mv	a1,s6
    1eaa:	8562                	mv	a0,s8
    1eac:	00004097          	auipc	ra,0x4
    1eb0:	87a080e7          	jalr	-1926(ra) # 5726 <link>
    1eb4:	b7f1                	j	1e80 <linkunlink+0x9c>
  if(pid)
    1eb6:	020c8463          	beqz	s9,1ede <linkunlink+0xfa>
    wait(0);
    1eba:	4501                	li	a0,0
    1ebc:	00004097          	auipc	ra,0x4
    1ec0:	812080e7          	jalr	-2030(ra) # 56ce <wait>
}
    1ec4:	60e6                	ld	ra,88(sp)
    1ec6:	6446                	ld	s0,80(sp)
    1ec8:	64a6                	ld	s1,72(sp)
    1eca:	6906                	ld	s2,64(sp)
    1ecc:	79e2                	ld	s3,56(sp)
    1ece:	7a42                	ld	s4,48(sp)
    1ed0:	7aa2                	ld	s5,40(sp)
    1ed2:	7b02                	ld	s6,32(sp)
    1ed4:	6be2                	ld	s7,24(sp)
    1ed6:	6c42                	ld	s8,16(sp)
    1ed8:	6ca2                	ld	s9,8(sp)
    1eda:	6125                	add	sp,sp,96
    1edc:	8082                	ret
    exit(0);
    1ede:	4501                	li	a0,0
    1ee0:	00003097          	auipc	ra,0x3
    1ee4:	7e6080e7          	jalr	2022(ra) # 56c6 <exit>

0000000000001ee8 <manywrites>:
{
    1ee8:	711d                	add	sp,sp,-96
    1eea:	ec86                	sd	ra,88(sp)
    1eec:	e8a2                	sd	s0,80(sp)
    1eee:	e4a6                	sd	s1,72(sp)
    1ef0:	e0ca                	sd	s2,64(sp)
    1ef2:	fc4e                	sd	s3,56(sp)
    1ef4:	f456                	sd	s5,40(sp)
    1ef6:	1080                	add	s0,sp,96
    1ef8:	8aaa                	mv	s5,a0
  for(int ci = 0; ci < nchildren; ci++){
    1efa:	4981                	li	s3,0
    1efc:	4911                	li	s2,4
    int pid = fork();
    1efe:	00003097          	auipc	ra,0x3
    1f02:	7c0080e7          	jalr	1984(ra) # 56be <fork>
    1f06:	84aa                	mv	s1,a0
    if(pid < 0){
    1f08:	02054d63          	bltz	a0,1f42 <manywrites+0x5a>
    if(pid == 0){
    1f0c:	c939                	beqz	a0,1f62 <manywrites+0x7a>
  for(int ci = 0; ci < nchildren; ci++){
    1f0e:	2985                	addw	s3,s3,1
    1f10:	ff2997e3          	bne	s3,s2,1efe <manywrites+0x16>
    1f14:	f852                	sd	s4,48(sp)
    1f16:	f05a                	sd	s6,32(sp)
    1f18:	ec5e                	sd	s7,24(sp)
    1f1a:	4491                	li	s1,4
    int st = 0;
    1f1c:	fa042423          	sw	zero,-88(s0)
    wait(&st);
    1f20:	fa840513          	add	a0,s0,-88
    1f24:	00003097          	auipc	ra,0x3
    1f28:	7aa080e7          	jalr	1962(ra) # 56ce <wait>
    if(st != 0)
    1f2c:	fa842503          	lw	a0,-88(s0)
    1f30:	10051463          	bnez	a0,2038 <manywrites+0x150>
  for(int ci = 0; ci < nchildren; ci++){
    1f34:	34fd                	addw	s1,s1,-1
    1f36:	f0fd                	bnez	s1,1f1c <manywrites+0x34>
  exit(0);
    1f38:	4501                	li	a0,0
    1f3a:	00003097          	auipc	ra,0x3
    1f3e:	78c080e7          	jalr	1932(ra) # 56c6 <exit>
    1f42:	f852                	sd	s4,48(sp)
    1f44:	f05a                	sd	s6,32(sp)
    1f46:	ec5e                	sd	s7,24(sp)
      printf("fork failed\n");
    1f48:	00005517          	auipc	a0,0x5
    1f4c:	be050513          	add	a0,a0,-1056 # 6b28 <malloc+0xdaa>
    1f50:	00004097          	auipc	ra,0x4
    1f54:	bae080e7          	jalr	-1106(ra) # 5afe <printf>
      exit(1);
    1f58:	4505                	li	a0,1
    1f5a:	00003097          	auipc	ra,0x3
    1f5e:	76c080e7          	jalr	1900(ra) # 56c6 <exit>
    1f62:	f852                	sd	s4,48(sp)
    1f64:	f05a                	sd	s6,32(sp)
    1f66:	ec5e                	sd	s7,24(sp)
      name[0] = 'b';
    1f68:	06200793          	li	a5,98
    1f6c:	faf40423          	sb	a5,-88(s0)
      name[1] = 'a' + ci;
    1f70:	0619879b          	addw	a5,s3,97
    1f74:	faf404a3          	sb	a5,-87(s0)
      name[2] = '\0';
    1f78:	fa040523          	sb	zero,-86(s0)
      unlink(name);
    1f7c:	fa840513          	add	a0,s0,-88
    1f80:	00003097          	auipc	ra,0x3
    1f84:	796080e7          	jalr	1942(ra) # 5716 <unlink>
    1f88:	4bf9                	li	s7,30
          int cc = write(fd, buf, sz);
    1f8a:	0000ab17          	auipc	s6,0xa
    1f8e:	ec6b0b13          	add	s6,s6,-314 # be50 <buf>
        for(int i = 0; i < ci+1; i++){
    1f92:	8a26                	mv	s4,s1
    1f94:	0209ce63          	bltz	s3,1fd0 <manywrites+0xe8>
          int fd = open(name, O_CREATE | O_RDWR);
    1f98:	20200593          	li	a1,514
    1f9c:	fa840513          	add	a0,s0,-88
    1fa0:	00003097          	auipc	ra,0x3
    1fa4:	766080e7          	jalr	1894(ra) # 5706 <open>
    1fa8:	892a                	mv	s2,a0
          if(fd < 0){
    1faa:	04054763          	bltz	a0,1ff8 <manywrites+0x110>
          int cc = write(fd, buf, sz);
    1fae:	660d                	lui	a2,0x3
    1fb0:	85da                	mv	a1,s6
    1fb2:	00003097          	auipc	ra,0x3
    1fb6:	734080e7          	jalr	1844(ra) # 56e6 <write>
          if(cc != sz){
    1fba:	678d                	lui	a5,0x3
    1fbc:	04f51e63          	bne	a0,a5,2018 <manywrites+0x130>
          close(fd);
    1fc0:	854a                	mv	a0,s2
    1fc2:	00003097          	auipc	ra,0x3
    1fc6:	72c080e7          	jalr	1836(ra) # 56ee <close>
        for(int i = 0; i < ci+1; i++){
    1fca:	2a05                	addw	s4,s4,1
    1fcc:	fd49d6e3          	bge	s3,s4,1f98 <manywrites+0xb0>
        unlink(name);
    1fd0:	fa840513          	add	a0,s0,-88
    1fd4:	00003097          	auipc	ra,0x3
    1fd8:	742080e7          	jalr	1858(ra) # 5716 <unlink>
      for(int iters = 0; iters < howmany; iters++){
    1fdc:	3bfd                	addw	s7,s7,-1
    1fde:	fa0b9ae3          	bnez	s7,1f92 <manywrites+0xaa>
      unlink(name);
    1fe2:	fa840513          	add	a0,s0,-88
    1fe6:	00003097          	auipc	ra,0x3
    1fea:	730080e7          	jalr	1840(ra) # 5716 <unlink>
      exit(0);
    1fee:	4501                	li	a0,0
    1ff0:	00003097          	auipc	ra,0x3
    1ff4:	6d6080e7          	jalr	1750(ra) # 56c6 <exit>
            printf("%s: cannot create %s\n", s, name);
    1ff8:	fa840613          	add	a2,s0,-88
    1ffc:	85d6                	mv	a1,s5
    1ffe:	00005517          	auipc	a0,0x5
    2002:	98250513          	add	a0,a0,-1662 # 6980 <malloc+0xc02>
    2006:	00004097          	auipc	ra,0x4
    200a:	af8080e7          	jalr	-1288(ra) # 5afe <printf>
            exit(1);
    200e:	4505                	li	a0,1
    2010:	00003097          	auipc	ra,0x3
    2014:	6b6080e7          	jalr	1718(ra) # 56c6 <exit>
            printf("%s: write(%d) ret %d\n", s, sz, cc);
    2018:	86aa                	mv	a3,a0
    201a:	660d                	lui	a2,0x3
    201c:	85d6                	mv	a1,s5
    201e:	00004517          	auipc	a0,0x4
    2022:	f6a50513          	add	a0,a0,-150 # 5f88 <malloc+0x20a>
    2026:	00004097          	auipc	ra,0x4
    202a:	ad8080e7          	jalr	-1320(ra) # 5afe <printf>
            exit(1);
    202e:	4505                	li	a0,1
    2030:	00003097          	auipc	ra,0x3
    2034:	696080e7          	jalr	1686(ra) # 56c6 <exit>
      exit(st);
    2038:	00003097          	auipc	ra,0x3
    203c:	68e080e7          	jalr	1678(ra) # 56c6 <exit>

0000000000002040 <forktest>:
{
    2040:	7179                	add	sp,sp,-48
    2042:	f406                	sd	ra,40(sp)
    2044:	f022                	sd	s0,32(sp)
    2046:	ec26                	sd	s1,24(sp)
    2048:	e84a                	sd	s2,16(sp)
    204a:	e44e                	sd	s3,8(sp)
    204c:	1800                	add	s0,sp,48
    204e:	89aa                	mv	s3,a0
  for(n=0; n<N; n++){
    2050:	4481                	li	s1,0
    2052:	3e800913          	li	s2,1000
    pid = fork();
    2056:	00003097          	auipc	ra,0x3
    205a:	668080e7          	jalr	1640(ra) # 56be <fork>
    if(pid < 0)
    205e:	08054263          	bltz	a0,20e2 <forktest+0xa2>
    if(pid == 0)
    2062:	c115                	beqz	a0,2086 <forktest+0x46>
  for(n=0; n<N; n++){
    2064:	2485                	addw	s1,s1,1
    2066:	ff2498e3          	bne	s1,s2,2056 <forktest+0x16>
    printf("%s: fork claimed to work 1000 times!\n", s);
    206a:	85ce                	mv	a1,s3
    206c:	00005517          	auipc	a0,0x5
    2070:	97450513          	add	a0,a0,-1676 # 69e0 <malloc+0xc62>
    2074:	00004097          	auipc	ra,0x4
    2078:	a8a080e7          	jalr	-1398(ra) # 5afe <printf>
    exit(1);
    207c:	4505                	li	a0,1
    207e:	00003097          	auipc	ra,0x3
    2082:	648080e7          	jalr	1608(ra) # 56c6 <exit>
      exit(0);
    2086:	00003097          	auipc	ra,0x3
    208a:	640080e7          	jalr	1600(ra) # 56c6 <exit>
    printf("%s: no fork at all!\n", s);
    208e:	85ce                	mv	a1,s3
    2090:	00005517          	auipc	a0,0x5
    2094:	90850513          	add	a0,a0,-1784 # 6998 <malloc+0xc1a>
    2098:	00004097          	auipc	ra,0x4
    209c:	a66080e7          	jalr	-1434(ra) # 5afe <printf>
    exit(1);
    20a0:	4505                	li	a0,1
    20a2:	00003097          	auipc	ra,0x3
    20a6:	624080e7          	jalr	1572(ra) # 56c6 <exit>
      printf("%s: wait stopped early\n", s);
    20aa:	85ce                	mv	a1,s3
    20ac:	00005517          	auipc	a0,0x5
    20b0:	90450513          	add	a0,a0,-1788 # 69b0 <malloc+0xc32>
    20b4:	00004097          	auipc	ra,0x4
    20b8:	a4a080e7          	jalr	-1462(ra) # 5afe <printf>
      exit(1);
    20bc:	4505                	li	a0,1
    20be:	00003097          	auipc	ra,0x3
    20c2:	608080e7          	jalr	1544(ra) # 56c6 <exit>
    printf("%s: wait got too many\n", s);
    20c6:	85ce                	mv	a1,s3
    20c8:	00005517          	auipc	a0,0x5
    20cc:	90050513          	add	a0,a0,-1792 # 69c8 <malloc+0xc4a>
    20d0:	00004097          	auipc	ra,0x4
    20d4:	a2e080e7          	jalr	-1490(ra) # 5afe <printf>
    exit(1);
    20d8:	4505                	li	a0,1
    20da:	00003097          	auipc	ra,0x3
    20de:	5ec080e7          	jalr	1516(ra) # 56c6 <exit>
  if (n == 0) {
    20e2:	d4d5                	beqz	s1,208e <forktest+0x4e>
  for(; n > 0; n--){
    20e4:	00905b63          	blez	s1,20fa <forktest+0xba>
    if(wait(0) < 0){
    20e8:	4501                	li	a0,0
    20ea:	00003097          	auipc	ra,0x3
    20ee:	5e4080e7          	jalr	1508(ra) # 56ce <wait>
    20f2:	fa054ce3          	bltz	a0,20aa <forktest+0x6a>
  for(; n > 0; n--){
    20f6:	34fd                	addw	s1,s1,-1
    20f8:	f8e5                	bnez	s1,20e8 <forktest+0xa8>
  if(wait(0) != -1){
    20fa:	4501                	li	a0,0
    20fc:	00003097          	auipc	ra,0x3
    2100:	5d2080e7          	jalr	1490(ra) # 56ce <wait>
    2104:	57fd                	li	a5,-1
    2106:	fcf510e3          	bne	a0,a5,20c6 <forktest+0x86>
}
    210a:	70a2                	ld	ra,40(sp)
    210c:	7402                	ld	s0,32(sp)
    210e:	64e2                	ld	s1,24(sp)
    2110:	6942                	ld	s2,16(sp)
    2112:	69a2                	ld	s3,8(sp)
    2114:	6145                	add	sp,sp,48
    2116:	8082                	ret

0000000000002118 <kernmem>:
{
    2118:	715d                	add	sp,sp,-80
    211a:	e486                	sd	ra,72(sp)
    211c:	e0a2                	sd	s0,64(sp)
    211e:	fc26                	sd	s1,56(sp)
    2120:	f84a                	sd	s2,48(sp)
    2122:	f44e                	sd	s3,40(sp)
    2124:	f052                	sd	s4,32(sp)
    2126:	ec56                	sd	s5,24(sp)
    2128:	0880                	add	s0,sp,80
    212a:	8aaa                	mv	s5,a0
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    212c:	4485                	li	s1,1
    212e:	04fe                	sll	s1,s1,0x1f
    if(xstatus != -1)  // did kernel kill child?
    2130:	5a7d                	li	s4,-1
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    2132:	69b1                	lui	s3,0xc
    2134:	35098993          	add	s3,s3,848 # c350 <buf+0x500>
    2138:	1003d937          	lui	s2,0x1003d
    213c:	090e                	sll	s2,s2,0x3
    213e:	48090913          	add	s2,s2,1152 # 1003d480 <__BSS_END__+0x1002e620>
    pid = fork();
    2142:	00003097          	auipc	ra,0x3
    2146:	57c080e7          	jalr	1404(ra) # 56be <fork>
    if(pid < 0){
    214a:	02054963          	bltz	a0,217c <kernmem+0x64>
    if(pid == 0){
    214e:	c529                	beqz	a0,2198 <kernmem+0x80>
    wait(&xstatus);
    2150:	fbc40513          	add	a0,s0,-68
    2154:	00003097          	auipc	ra,0x3
    2158:	57a080e7          	jalr	1402(ra) # 56ce <wait>
    if(xstatus != -1)  // did kernel kill child?
    215c:	fbc42783          	lw	a5,-68(s0)
    2160:	05479d63          	bne	a5,s4,21ba <kernmem+0xa2>
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    2164:	94ce                	add	s1,s1,s3
    2166:	fd249ee3          	bne	s1,s2,2142 <kernmem+0x2a>
}
    216a:	60a6                	ld	ra,72(sp)
    216c:	6406                	ld	s0,64(sp)
    216e:	74e2                	ld	s1,56(sp)
    2170:	7942                	ld	s2,48(sp)
    2172:	79a2                	ld	s3,40(sp)
    2174:	7a02                	ld	s4,32(sp)
    2176:	6ae2                	ld	s5,24(sp)
    2178:	6161                	add	sp,sp,80
    217a:	8082                	ret
      printf("%s: fork failed\n", s);
    217c:	85d6                	mv	a1,s5
    217e:	00004517          	auipc	a0,0x4
    2182:	5a250513          	add	a0,a0,1442 # 6720 <malloc+0x9a2>
    2186:	00004097          	auipc	ra,0x4
    218a:	978080e7          	jalr	-1672(ra) # 5afe <printf>
      exit(1);
    218e:	4505                	li	a0,1
    2190:	00003097          	auipc	ra,0x3
    2194:	536080e7          	jalr	1334(ra) # 56c6 <exit>
      printf("%s: oops could read %x = %x\n", s, a, *a);
    2198:	0004c683          	lbu	a3,0(s1)
    219c:	8626                	mv	a2,s1
    219e:	85d6                	mv	a1,s5
    21a0:	00005517          	auipc	a0,0x5
    21a4:	86850513          	add	a0,a0,-1944 # 6a08 <malloc+0xc8a>
    21a8:	00004097          	auipc	ra,0x4
    21ac:	956080e7          	jalr	-1706(ra) # 5afe <printf>
      exit(1);
    21b0:	4505                	li	a0,1
    21b2:	00003097          	auipc	ra,0x3
    21b6:	514080e7          	jalr	1300(ra) # 56c6 <exit>
      exit(1);
    21ba:	4505                	li	a0,1
    21bc:	00003097          	auipc	ra,0x3
    21c0:	50a080e7          	jalr	1290(ra) # 56c6 <exit>

00000000000021c4 <bigargtest>:
{
    21c4:	7179                	add	sp,sp,-48
    21c6:	f406                	sd	ra,40(sp)
    21c8:	f022                	sd	s0,32(sp)
    21ca:	ec26                	sd	s1,24(sp)
    21cc:	1800                	add	s0,sp,48
    21ce:	84aa                	mv	s1,a0
  unlink("bigarg-ok");
    21d0:	00005517          	auipc	a0,0x5
    21d4:	85850513          	add	a0,a0,-1960 # 6a28 <malloc+0xcaa>
    21d8:	00003097          	auipc	ra,0x3
    21dc:	53e080e7          	jalr	1342(ra) # 5716 <unlink>
  pid = fork();
    21e0:	00003097          	auipc	ra,0x3
    21e4:	4de080e7          	jalr	1246(ra) # 56be <fork>
  if(pid == 0){
    21e8:	c121                	beqz	a0,2228 <bigargtest+0x64>
  } else if(pid < 0){
    21ea:	0a054063          	bltz	a0,228a <bigargtest+0xc6>
  wait(&xstatus);
    21ee:	fdc40513          	add	a0,s0,-36
    21f2:	00003097          	auipc	ra,0x3
    21f6:	4dc080e7          	jalr	1244(ra) # 56ce <wait>
  if(xstatus != 0)
    21fa:	fdc42503          	lw	a0,-36(s0)
    21fe:	e545                	bnez	a0,22a6 <bigargtest+0xe2>
  fd = open("bigarg-ok", 0);
    2200:	4581                	li	a1,0
    2202:	00005517          	auipc	a0,0x5
    2206:	82650513          	add	a0,a0,-2010 # 6a28 <malloc+0xcaa>
    220a:	00003097          	auipc	ra,0x3
    220e:	4fc080e7          	jalr	1276(ra) # 5706 <open>
  if(fd < 0){
    2212:	08054e63          	bltz	a0,22ae <bigargtest+0xea>
  close(fd);
    2216:	00003097          	auipc	ra,0x3
    221a:	4d8080e7          	jalr	1240(ra) # 56ee <close>
}
    221e:	70a2                	ld	ra,40(sp)
    2220:	7402                	ld	s0,32(sp)
    2222:	64e2                	ld	s1,24(sp)
    2224:	6145                	add	sp,sp,48
    2226:	8082                	ret
    2228:	00006797          	auipc	a5,0x6
    222c:	41078793          	add	a5,a5,1040 # 8638 <args.1>
    2230:	00006697          	auipc	a3,0x6
    2234:	50068693          	add	a3,a3,1280 # 8730 <args.1+0xf8>
      args[i] = "bigargs test: failed\n                                                                                                                                                                                                       ";
    2238:	00005717          	auipc	a4,0x5
    223c:	80070713          	add	a4,a4,-2048 # 6a38 <malloc+0xcba>
    2240:	e398                	sd	a4,0(a5)
    for(i = 0; i < MAXARG-1; i++)
    2242:	07a1                	add	a5,a5,8
    2244:	fed79ee3          	bne	a5,a3,2240 <bigargtest+0x7c>
    args[MAXARG-1] = 0;
    2248:	00006597          	auipc	a1,0x6
    224c:	3f058593          	add	a1,a1,1008 # 8638 <args.1>
    2250:	0e05bc23          	sd	zero,248(a1)
    exec("echo", args);
    2254:	00004517          	auipc	a0,0x4
    2258:	c6450513          	add	a0,a0,-924 # 5eb8 <malloc+0x13a>
    225c:	00003097          	auipc	ra,0x3
    2260:	4a2080e7          	jalr	1186(ra) # 56fe <exec>
    fd = open("bigarg-ok", O_CREATE);
    2264:	20000593          	li	a1,512
    2268:	00004517          	auipc	a0,0x4
    226c:	7c050513          	add	a0,a0,1984 # 6a28 <malloc+0xcaa>
    2270:	00003097          	auipc	ra,0x3
    2274:	496080e7          	jalr	1174(ra) # 5706 <open>
    close(fd);
    2278:	00003097          	auipc	ra,0x3
    227c:	476080e7          	jalr	1142(ra) # 56ee <close>
    exit(0);
    2280:	4501                	li	a0,0
    2282:	00003097          	auipc	ra,0x3
    2286:	444080e7          	jalr	1092(ra) # 56c6 <exit>
    printf("%s: bigargtest: fork failed\n", s);
    228a:	85a6                	mv	a1,s1
    228c:	00005517          	auipc	a0,0x5
    2290:	88c50513          	add	a0,a0,-1908 # 6b18 <malloc+0xd9a>
    2294:	00004097          	auipc	ra,0x4
    2298:	86a080e7          	jalr	-1942(ra) # 5afe <printf>
    exit(1);
    229c:	4505                	li	a0,1
    229e:	00003097          	auipc	ra,0x3
    22a2:	428080e7          	jalr	1064(ra) # 56c6 <exit>
    exit(xstatus);
    22a6:	00003097          	auipc	ra,0x3
    22aa:	420080e7          	jalr	1056(ra) # 56c6 <exit>
    printf("%s: bigarg test failed!\n", s);
    22ae:	85a6                	mv	a1,s1
    22b0:	00005517          	auipc	a0,0x5
    22b4:	88850513          	add	a0,a0,-1912 # 6b38 <malloc+0xdba>
    22b8:	00004097          	auipc	ra,0x4
    22bc:	846080e7          	jalr	-1978(ra) # 5afe <printf>
    exit(1);
    22c0:	4505                	li	a0,1
    22c2:	00003097          	auipc	ra,0x3
    22c6:	404080e7          	jalr	1028(ra) # 56c6 <exit>

00000000000022ca <stacktest>:
{
    22ca:	7179                	add	sp,sp,-48
    22cc:	f406                	sd	ra,40(sp)
    22ce:	f022                	sd	s0,32(sp)
    22d0:	ec26                	sd	s1,24(sp)
    22d2:	1800                	add	s0,sp,48
    22d4:	84aa                	mv	s1,a0
  pid = fork();
    22d6:	00003097          	auipc	ra,0x3
    22da:	3e8080e7          	jalr	1000(ra) # 56be <fork>
  if(pid == 0) {
    22de:	c115                	beqz	a0,2302 <stacktest+0x38>
  } else if(pid < 0){
    22e0:	04054463          	bltz	a0,2328 <stacktest+0x5e>
  wait(&xstatus);
    22e4:	fdc40513          	add	a0,s0,-36
    22e8:	00003097          	auipc	ra,0x3
    22ec:	3e6080e7          	jalr	998(ra) # 56ce <wait>
  if(xstatus == -1)  // kernel killed child?
    22f0:	fdc42503          	lw	a0,-36(s0)
    22f4:	57fd                	li	a5,-1
    22f6:	04f50763          	beq	a0,a5,2344 <stacktest+0x7a>
    exit(xstatus);
    22fa:	00003097          	auipc	ra,0x3
    22fe:	3cc080e7          	jalr	972(ra) # 56c6 <exit>

static inline uint64
r_sp()
{
  uint64 x;
  asm volatile("mv %0, sp" : "=r" (x) );
    2302:	870a                	mv	a4,sp
    printf("%s: stacktest: read below stack %p\n", s, *sp);
    2304:	77fd                	lui	a5,0xfffff
    2306:	97ba                	add	a5,a5,a4
    2308:	0007c603          	lbu	a2,0(a5) # fffffffffffff000 <__BSS_END__+0xffffffffffff01a0>
    230c:	85a6                	mv	a1,s1
    230e:	00005517          	auipc	a0,0x5
    2312:	84a50513          	add	a0,a0,-1974 # 6b58 <malloc+0xdda>
    2316:	00003097          	auipc	ra,0x3
    231a:	7e8080e7          	jalr	2024(ra) # 5afe <printf>
    exit(1);
    231e:	4505                	li	a0,1
    2320:	00003097          	auipc	ra,0x3
    2324:	3a6080e7          	jalr	934(ra) # 56c6 <exit>
    printf("%s: fork failed\n", s);
    2328:	85a6                	mv	a1,s1
    232a:	00004517          	auipc	a0,0x4
    232e:	3f650513          	add	a0,a0,1014 # 6720 <malloc+0x9a2>
    2332:	00003097          	auipc	ra,0x3
    2336:	7cc080e7          	jalr	1996(ra) # 5afe <printf>
    exit(1);
    233a:	4505                	li	a0,1
    233c:	00003097          	auipc	ra,0x3
    2340:	38a080e7          	jalr	906(ra) # 56c6 <exit>
    exit(0);
    2344:	4501                	li	a0,0
    2346:	00003097          	auipc	ra,0x3
    234a:	380080e7          	jalr	896(ra) # 56c6 <exit>

000000000000234e <copyinstr3>:
{
    234e:	7179                	add	sp,sp,-48
    2350:	f406                	sd	ra,40(sp)
    2352:	f022                	sd	s0,32(sp)
    2354:	ec26                	sd	s1,24(sp)
    2356:	1800                	add	s0,sp,48
  sbrk(8192);
    2358:	6509                	lui	a0,0x2
    235a:	00003097          	auipc	ra,0x3
    235e:	3f4080e7          	jalr	1012(ra) # 574e <sbrk>
  uint64 top = (uint64) sbrk(0);
    2362:	4501                	li	a0,0
    2364:	00003097          	auipc	ra,0x3
    2368:	3ea080e7          	jalr	1002(ra) # 574e <sbrk>
  if((top % PGSIZE) != 0){
    236c:	03451793          	sll	a5,a0,0x34
    2370:	e3c9                	bnez	a5,23f2 <copyinstr3+0xa4>
  top = (uint64) sbrk(0);
    2372:	4501                	li	a0,0
    2374:	00003097          	auipc	ra,0x3
    2378:	3da080e7          	jalr	986(ra) # 574e <sbrk>
  if(top % PGSIZE){
    237c:	03451793          	sll	a5,a0,0x34
    2380:	e3d9                	bnez	a5,2406 <copyinstr3+0xb8>
  char *b = (char *) (top - 1);
    2382:	fff50493          	add	s1,a0,-1 # 1fff <manywrites+0x117>
  *b = 'x';
    2386:	07800793          	li	a5,120
    238a:	fef50fa3          	sb	a5,-1(a0)
  int ret = unlink(b);
    238e:	8526                	mv	a0,s1
    2390:	00003097          	auipc	ra,0x3
    2394:	386080e7          	jalr	902(ra) # 5716 <unlink>
  if(ret != -1){
    2398:	57fd                	li	a5,-1
    239a:	08f51363          	bne	a0,a5,2420 <copyinstr3+0xd2>
  int fd = open(b, O_CREATE | O_WRONLY);
    239e:	20100593          	li	a1,513
    23a2:	8526                	mv	a0,s1
    23a4:	00003097          	auipc	ra,0x3
    23a8:	362080e7          	jalr	866(ra) # 5706 <open>
  if(fd != -1){
    23ac:	57fd                	li	a5,-1
    23ae:	08f51863          	bne	a0,a5,243e <copyinstr3+0xf0>
  ret = link(b, b);
    23b2:	85a6                	mv	a1,s1
    23b4:	8526                	mv	a0,s1
    23b6:	00003097          	auipc	ra,0x3
    23ba:	370080e7          	jalr	880(ra) # 5726 <link>
  if(ret != -1){
    23be:	57fd                	li	a5,-1
    23c0:	08f51e63          	bne	a0,a5,245c <copyinstr3+0x10e>
  char *args[] = { "xx", 0 };
    23c4:	00005797          	auipc	a5,0x5
    23c8:	43c78793          	add	a5,a5,1084 # 7800 <malloc+0x1a82>
    23cc:	fcf43823          	sd	a5,-48(s0)
    23d0:	fc043c23          	sd	zero,-40(s0)
  ret = exec(b, args);
    23d4:	fd040593          	add	a1,s0,-48
    23d8:	8526                	mv	a0,s1
    23da:	00003097          	auipc	ra,0x3
    23de:	324080e7          	jalr	804(ra) # 56fe <exec>
  if(ret != -1){
    23e2:	57fd                	li	a5,-1
    23e4:	08f51c63          	bne	a0,a5,247c <copyinstr3+0x12e>
}
    23e8:	70a2                	ld	ra,40(sp)
    23ea:	7402                	ld	s0,32(sp)
    23ec:	64e2                	ld	s1,24(sp)
    23ee:	6145                	add	sp,sp,48
    23f0:	8082                	ret
    sbrk(PGSIZE - (top % PGSIZE));
    23f2:	0347d513          	srl	a0,a5,0x34
    23f6:	6785                	lui	a5,0x1
    23f8:	40a7853b          	subw	a0,a5,a0
    23fc:	00003097          	auipc	ra,0x3
    2400:	352080e7          	jalr	850(ra) # 574e <sbrk>
    2404:	b7bd                	j	2372 <copyinstr3+0x24>
    printf("oops\n");
    2406:	00004517          	auipc	a0,0x4
    240a:	77a50513          	add	a0,a0,1914 # 6b80 <malloc+0xe02>
    240e:	00003097          	auipc	ra,0x3
    2412:	6f0080e7          	jalr	1776(ra) # 5afe <printf>
    exit(1);
    2416:	4505                	li	a0,1
    2418:	00003097          	auipc	ra,0x3
    241c:	2ae080e7          	jalr	686(ra) # 56c6 <exit>
    printf("unlink(%s) returned %d, not -1\n", b, ret);
    2420:	862a                	mv	a2,a0
    2422:	85a6                	mv	a1,s1
    2424:	00004517          	auipc	a0,0x4
    2428:	21c50513          	add	a0,a0,540 # 6640 <malloc+0x8c2>
    242c:	00003097          	auipc	ra,0x3
    2430:	6d2080e7          	jalr	1746(ra) # 5afe <printf>
    exit(1);
    2434:	4505                	li	a0,1
    2436:	00003097          	auipc	ra,0x3
    243a:	290080e7          	jalr	656(ra) # 56c6 <exit>
    printf("open(%s) returned %d, not -1\n", b, fd);
    243e:	862a                	mv	a2,a0
    2440:	85a6                	mv	a1,s1
    2442:	00004517          	auipc	a0,0x4
    2446:	21e50513          	add	a0,a0,542 # 6660 <malloc+0x8e2>
    244a:	00003097          	auipc	ra,0x3
    244e:	6b4080e7          	jalr	1716(ra) # 5afe <printf>
    exit(1);
    2452:	4505                	li	a0,1
    2454:	00003097          	auipc	ra,0x3
    2458:	272080e7          	jalr	626(ra) # 56c6 <exit>
    printf("link(%s, %s) returned %d, not -1\n", b, b, ret);
    245c:	86aa                	mv	a3,a0
    245e:	8626                	mv	a2,s1
    2460:	85a6                	mv	a1,s1
    2462:	00004517          	auipc	a0,0x4
    2466:	21e50513          	add	a0,a0,542 # 6680 <malloc+0x902>
    246a:	00003097          	auipc	ra,0x3
    246e:	694080e7          	jalr	1684(ra) # 5afe <printf>
    exit(1);
    2472:	4505                	li	a0,1
    2474:	00003097          	auipc	ra,0x3
    2478:	252080e7          	jalr	594(ra) # 56c6 <exit>
    printf("exec(%s) returned %d, not -1\n", b, fd);
    247c:	567d                	li	a2,-1
    247e:	85a6                	mv	a1,s1
    2480:	00004517          	auipc	a0,0x4
    2484:	22850513          	add	a0,a0,552 # 66a8 <malloc+0x92a>
    2488:	00003097          	auipc	ra,0x3
    248c:	676080e7          	jalr	1654(ra) # 5afe <printf>
    exit(1);
    2490:	4505                	li	a0,1
    2492:	00003097          	auipc	ra,0x3
    2496:	234080e7          	jalr	564(ra) # 56c6 <exit>

000000000000249a <rwsbrk>:
{
    249a:	1101                	add	sp,sp,-32
    249c:	ec06                	sd	ra,24(sp)
    249e:	e822                	sd	s0,16(sp)
    24a0:	1000                	add	s0,sp,32
  uint64 a = (uint64) sbrk(8192);
    24a2:	6509                	lui	a0,0x2
    24a4:	00003097          	auipc	ra,0x3
    24a8:	2aa080e7          	jalr	682(ra) # 574e <sbrk>
  if(a == 0xffffffffffffffffLL) {
    24ac:	57fd                	li	a5,-1
    24ae:	06f50463          	beq	a0,a5,2516 <rwsbrk+0x7c>
    24b2:	e426                	sd	s1,8(sp)
    24b4:	84aa                	mv	s1,a0
  if ((uint64) sbrk(-8192) ==  0xffffffffffffffffLL) {
    24b6:	7579                	lui	a0,0xffffe
    24b8:	00003097          	auipc	ra,0x3
    24bc:	296080e7          	jalr	662(ra) # 574e <sbrk>
    24c0:	57fd                	li	a5,-1
    24c2:	06f50963          	beq	a0,a5,2534 <rwsbrk+0x9a>
    24c6:	e04a                	sd	s2,0(sp)
  fd = open("rwsbrk", O_CREATE|O_WRONLY);
    24c8:	20100593          	li	a1,513
    24cc:	00004517          	auipc	a0,0x4
    24d0:	6f450513          	add	a0,a0,1780 # 6bc0 <malloc+0xe42>
    24d4:	00003097          	auipc	ra,0x3
    24d8:	232080e7          	jalr	562(ra) # 5706 <open>
    24dc:	892a                	mv	s2,a0
  if(fd < 0){
    24de:	06054963          	bltz	a0,2550 <rwsbrk+0xb6>
  n = write(fd, (void*)(a+4096), 1024);
    24e2:	6785                	lui	a5,0x1
    24e4:	94be                	add	s1,s1,a5
    24e6:	40000613          	li	a2,1024
    24ea:	85a6                	mv	a1,s1
    24ec:	00003097          	auipc	ra,0x3
    24f0:	1fa080e7          	jalr	506(ra) # 56e6 <write>
    24f4:	862a                	mv	a2,a0
  if(n >= 0){
    24f6:	06054a63          	bltz	a0,256a <rwsbrk+0xd0>
    printf("write(fd, %p, 1024) returned %d, not -1\n", a+4096, n);
    24fa:	85a6                	mv	a1,s1
    24fc:	00004517          	auipc	a0,0x4
    2500:	6e450513          	add	a0,a0,1764 # 6be0 <malloc+0xe62>
    2504:	00003097          	auipc	ra,0x3
    2508:	5fa080e7          	jalr	1530(ra) # 5afe <printf>
    exit(1);
    250c:	4505                	li	a0,1
    250e:	00003097          	auipc	ra,0x3
    2512:	1b8080e7          	jalr	440(ra) # 56c6 <exit>
    2516:	e426                	sd	s1,8(sp)
    2518:	e04a                	sd	s2,0(sp)
    printf("sbrk(rwsbrk) failed\n");
    251a:	00004517          	auipc	a0,0x4
    251e:	66e50513          	add	a0,a0,1646 # 6b88 <malloc+0xe0a>
    2522:	00003097          	auipc	ra,0x3
    2526:	5dc080e7          	jalr	1500(ra) # 5afe <printf>
    exit(1);
    252a:	4505                	li	a0,1
    252c:	00003097          	auipc	ra,0x3
    2530:	19a080e7          	jalr	410(ra) # 56c6 <exit>
    2534:	e04a                	sd	s2,0(sp)
    printf("sbrk(rwsbrk) shrink failed\n");
    2536:	00004517          	auipc	a0,0x4
    253a:	66a50513          	add	a0,a0,1642 # 6ba0 <malloc+0xe22>
    253e:	00003097          	auipc	ra,0x3
    2542:	5c0080e7          	jalr	1472(ra) # 5afe <printf>
    exit(1);
    2546:	4505                	li	a0,1
    2548:	00003097          	auipc	ra,0x3
    254c:	17e080e7          	jalr	382(ra) # 56c6 <exit>
    printf("open(rwsbrk) failed\n");
    2550:	00004517          	auipc	a0,0x4
    2554:	67850513          	add	a0,a0,1656 # 6bc8 <malloc+0xe4a>
    2558:	00003097          	auipc	ra,0x3
    255c:	5a6080e7          	jalr	1446(ra) # 5afe <printf>
    exit(1);
    2560:	4505                	li	a0,1
    2562:	00003097          	auipc	ra,0x3
    2566:	164080e7          	jalr	356(ra) # 56c6 <exit>
  close(fd);
    256a:	854a                	mv	a0,s2
    256c:	00003097          	auipc	ra,0x3
    2570:	182080e7          	jalr	386(ra) # 56ee <close>
  unlink("rwsbrk");
    2574:	00004517          	auipc	a0,0x4
    2578:	64c50513          	add	a0,a0,1612 # 6bc0 <malloc+0xe42>
    257c:	00003097          	auipc	ra,0x3
    2580:	19a080e7          	jalr	410(ra) # 5716 <unlink>
  fd = open("XV6-README", O_RDONLY);
    2584:	4581                	li	a1,0
    2586:	00004517          	auipc	a0,0x4
    258a:	ada50513          	add	a0,a0,-1318 # 6060 <malloc+0x2e2>
    258e:	00003097          	auipc	ra,0x3
    2592:	178080e7          	jalr	376(ra) # 5706 <open>
    2596:	892a                	mv	s2,a0
  if(fd < 0){
    2598:	02054963          	bltz	a0,25ca <rwsbrk+0x130>
  n = read(fd, (void*)(a+4096), 10);
    259c:	4629                	li	a2,10
    259e:	85a6                	mv	a1,s1
    25a0:	00003097          	auipc	ra,0x3
    25a4:	13e080e7          	jalr	318(ra) # 56de <read>
    25a8:	862a                	mv	a2,a0
  if(n >= 0){
    25aa:	02054d63          	bltz	a0,25e4 <rwsbrk+0x14a>
    printf("read(fd, %p, 10) returned %d, not -1\n", a+4096, n);
    25ae:	85a6                	mv	a1,s1
    25b0:	00004517          	auipc	a0,0x4
    25b4:	66050513          	add	a0,a0,1632 # 6c10 <malloc+0xe92>
    25b8:	00003097          	auipc	ra,0x3
    25bc:	546080e7          	jalr	1350(ra) # 5afe <printf>
    exit(1);
    25c0:	4505                	li	a0,1
    25c2:	00003097          	auipc	ra,0x3
    25c6:	104080e7          	jalr	260(ra) # 56c6 <exit>
    printf("open(rwsbrk) failed\n");
    25ca:	00004517          	auipc	a0,0x4
    25ce:	5fe50513          	add	a0,a0,1534 # 6bc8 <malloc+0xe4a>
    25d2:	00003097          	auipc	ra,0x3
    25d6:	52c080e7          	jalr	1324(ra) # 5afe <printf>
    exit(1);
    25da:	4505                	li	a0,1
    25dc:	00003097          	auipc	ra,0x3
    25e0:	0ea080e7          	jalr	234(ra) # 56c6 <exit>
  close(fd);
    25e4:	854a                	mv	a0,s2
    25e6:	00003097          	auipc	ra,0x3
    25ea:	108080e7          	jalr	264(ra) # 56ee <close>
  exit(0);
    25ee:	4501                	li	a0,0
    25f0:	00003097          	auipc	ra,0x3
    25f4:	0d6080e7          	jalr	214(ra) # 56c6 <exit>

00000000000025f8 <sbrkbasic>:
{
    25f8:	7139                	add	sp,sp,-64
    25fa:	fc06                	sd	ra,56(sp)
    25fc:	f822                	sd	s0,48(sp)
    25fe:	ec4e                	sd	s3,24(sp)
    2600:	0080                	add	s0,sp,64
    2602:	89aa                	mv	s3,a0
  pid = fork();
    2604:	00003097          	auipc	ra,0x3
    2608:	0ba080e7          	jalr	186(ra) # 56be <fork>
  if(pid < 0){
    260c:	02054f63          	bltz	a0,264a <sbrkbasic+0x52>
  if(pid == 0){
    2610:	e52d                	bnez	a0,267a <sbrkbasic+0x82>
    a = sbrk(TOOMUCH);
    2612:	40000537          	lui	a0,0x40000
    2616:	00003097          	auipc	ra,0x3
    261a:	138080e7          	jalr	312(ra) # 574e <sbrk>
    if(a == (char*)0xffffffffffffffffL){
    261e:	57fd                	li	a5,-1
    2620:	04f50563          	beq	a0,a5,266a <sbrkbasic+0x72>
    2624:	f426                	sd	s1,40(sp)
    2626:	f04a                	sd	s2,32(sp)
    2628:	e852                	sd	s4,16(sp)
    for(b = a; b < a+TOOMUCH; b += 4096){
    262a:	400007b7          	lui	a5,0x40000
    262e:	97aa                	add	a5,a5,a0
      *b = 99;
    2630:	06300693          	li	a3,99
    for(b = a; b < a+TOOMUCH; b += 4096){
    2634:	6705                	lui	a4,0x1
      *b = 99;
    2636:	00d50023          	sb	a3,0(a0) # 40000000 <__BSS_END__+0x3fff11a0>
    for(b = a; b < a+TOOMUCH; b += 4096){
    263a:	953a                	add	a0,a0,a4
    263c:	fef51de3          	bne	a0,a5,2636 <sbrkbasic+0x3e>
    exit(1);
    2640:	4505                	li	a0,1
    2642:	00003097          	auipc	ra,0x3
    2646:	084080e7          	jalr	132(ra) # 56c6 <exit>
    264a:	f426                	sd	s1,40(sp)
    264c:	f04a                	sd	s2,32(sp)
    264e:	e852                	sd	s4,16(sp)
    printf("fork failed in sbrkbasic\n");
    2650:	00004517          	auipc	a0,0x4
    2654:	5e850513          	add	a0,a0,1512 # 6c38 <malloc+0xeba>
    2658:	00003097          	auipc	ra,0x3
    265c:	4a6080e7          	jalr	1190(ra) # 5afe <printf>
    exit(1);
    2660:	4505                	li	a0,1
    2662:	00003097          	auipc	ra,0x3
    2666:	064080e7          	jalr	100(ra) # 56c6 <exit>
    266a:	f426                	sd	s1,40(sp)
    266c:	f04a                	sd	s2,32(sp)
    266e:	e852                	sd	s4,16(sp)
      exit(0);
    2670:	4501                	li	a0,0
    2672:	00003097          	auipc	ra,0x3
    2676:	054080e7          	jalr	84(ra) # 56c6 <exit>
  wait(&xstatus);
    267a:	fcc40513          	add	a0,s0,-52
    267e:	00003097          	auipc	ra,0x3
    2682:	050080e7          	jalr	80(ra) # 56ce <wait>
  if(xstatus == 1){
    2686:	fcc42703          	lw	a4,-52(s0)
    268a:	4785                	li	a5,1
    268c:	02f70063          	beq	a4,a5,26ac <sbrkbasic+0xb4>
    2690:	f426                	sd	s1,40(sp)
    2692:	f04a                	sd	s2,32(sp)
    2694:	e852                	sd	s4,16(sp)
  a = sbrk(0);
    2696:	4501                	li	a0,0
    2698:	00003097          	auipc	ra,0x3
    269c:	0b6080e7          	jalr	182(ra) # 574e <sbrk>
    26a0:	84aa                	mv	s1,a0
  for(i = 0; i < 5000; i++){
    26a2:	4901                	li	s2,0
    26a4:	6a05                	lui	s4,0x1
    26a6:	388a0a13          	add	s4,s4,904 # 1388 <copyinstr2+0x1ce>
    26aa:	a01d                	j	26d0 <sbrkbasic+0xd8>
    26ac:	f426                	sd	s1,40(sp)
    26ae:	f04a                	sd	s2,32(sp)
    26b0:	e852                	sd	s4,16(sp)
    printf("%s: too much memory allocated!\n", s);
    26b2:	85ce                	mv	a1,s3
    26b4:	00004517          	auipc	a0,0x4
    26b8:	5a450513          	add	a0,a0,1444 # 6c58 <malloc+0xeda>
    26bc:	00003097          	auipc	ra,0x3
    26c0:	442080e7          	jalr	1090(ra) # 5afe <printf>
    exit(1);
    26c4:	4505                	li	a0,1
    26c6:	00003097          	auipc	ra,0x3
    26ca:	000080e7          	jalr	ra # 56c6 <exit>
    26ce:	84be                	mv	s1,a5
    b = sbrk(1);
    26d0:	4505                	li	a0,1
    26d2:	00003097          	auipc	ra,0x3
    26d6:	07c080e7          	jalr	124(ra) # 574e <sbrk>
    if(b != a){
    26da:	04951c63          	bne	a0,s1,2732 <sbrkbasic+0x13a>
    *b = 1;
    26de:	4785                	li	a5,1
    26e0:	00f48023          	sb	a5,0(s1)
    a = b + 1;
    26e4:	00148793          	add	a5,s1,1
  for(i = 0; i < 5000; i++){
    26e8:	2905                	addw	s2,s2,1
    26ea:	ff4912e3          	bne	s2,s4,26ce <sbrkbasic+0xd6>
  pid = fork();
    26ee:	00003097          	auipc	ra,0x3
    26f2:	fd0080e7          	jalr	-48(ra) # 56be <fork>
    26f6:	892a                	mv	s2,a0
  if(pid < 0){
    26f8:	04054d63          	bltz	a0,2752 <sbrkbasic+0x15a>
  c = sbrk(1);
    26fc:	4505                	li	a0,1
    26fe:	00003097          	auipc	ra,0x3
    2702:	050080e7          	jalr	80(ra) # 574e <sbrk>
  c = sbrk(1);
    2706:	4505                	li	a0,1
    2708:	00003097          	auipc	ra,0x3
    270c:	046080e7          	jalr	70(ra) # 574e <sbrk>
  if(c != a + 1){
    2710:	0489                	add	s1,s1,2
    2712:	04a48e63          	beq	s1,a0,276e <sbrkbasic+0x176>
    printf("%s: sbrk test failed post-fork\n", s);
    2716:	85ce                	mv	a1,s3
    2718:	00004517          	auipc	a0,0x4
    271c:	5a050513          	add	a0,a0,1440 # 6cb8 <malloc+0xf3a>
    2720:	00003097          	auipc	ra,0x3
    2724:	3de080e7          	jalr	990(ra) # 5afe <printf>
    exit(1);
    2728:	4505                	li	a0,1
    272a:	00003097          	auipc	ra,0x3
    272e:	f9c080e7          	jalr	-100(ra) # 56c6 <exit>
      printf("%s: sbrk test failed %d %x %x\n", i, a, b);
    2732:	86aa                	mv	a3,a0
    2734:	8626                	mv	a2,s1
    2736:	85ca                	mv	a1,s2
    2738:	00004517          	auipc	a0,0x4
    273c:	54050513          	add	a0,a0,1344 # 6c78 <malloc+0xefa>
    2740:	00003097          	auipc	ra,0x3
    2744:	3be080e7          	jalr	958(ra) # 5afe <printf>
      exit(1);
    2748:	4505                	li	a0,1
    274a:	00003097          	auipc	ra,0x3
    274e:	f7c080e7          	jalr	-132(ra) # 56c6 <exit>
    printf("%s: sbrk test fork failed\n", s);
    2752:	85ce                	mv	a1,s3
    2754:	00004517          	auipc	a0,0x4
    2758:	54450513          	add	a0,a0,1348 # 6c98 <malloc+0xf1a>
    275c:	00003097          	auipc	ra,0x3
    2760:	3a2080e7          	jalr	930(ra) # 5afe <printf>
    exit(1);
    2764:	4505                	li	a0,1
    2766:	00003097          	auipc	ra,0x3
    276a:	f60080e7          	jalr	-160(ra) # 56c6 <exit>
  if(pid == 0)
    276e:	00091763          	bnez	s2,277c <sbrkbasic+0x184>
    exit(0);
    2772:	4501                	li	a0,0
    2774:	00003097          	auipc	ra,0x3
    2778:	f52080e7          	jalr	-174(ra) # 56c6 <exit>
  wait(&xstatus);
    277c:	fcc40513          	add	a0,s0,-52
    2780:	00003097          	auipc	ra,0x3
    2784:	f4e080e7          	jalr	-178(ra) # 56ce <wait>
  exit(xstatus);
    2788:	fcc42503          	lw	a0,-52(s0)
    278c:	00003097          	auipc	ra,0x3
    2790:	f3a080e7          	jalr	-198(ra) # 56c6 <exit>

0000000000002794 <sbrkmuch>:
{
    2794:	7179                	add	sp,sp,-48
    2796:	f406                	sd	ra,40(sp)
    2798:	f022                	sd	s0,32(sp)
    279a:	ec26                	sd	s1,24(sp)
    279c:	e84a                	sd	s2,16(sp)
    279e:	e44e                	sd	s3,8(sp)
    27a0:	e052                	sd	s4,0(sp)
    27a2:	1800                	add	s0,sp,48
    27a4:	89aa                	mv	s3,a0
  oldbrk = sbrk(0);
    27a6:	4501                	li	a0,0
    27a8:	00003097          	auipc	ra,0x3
    27ac:	fa6080e7          	jalr	-90(ra) # 574e <sbrk>
    27b0:	892a                	mv	s2,a0
  a = sbrk(0);
    27b2:	4501                	li	a0,0
    27b4:	00003097          	auipc	ra,0x3
    27b8:	f9a080e7          	jalr	-102(ra) # 574e <sbrk>
    27bc:	84aa                	mv	s1,a0
  p = sbrk(amt);
    27be:	06400537          	lui	a0,0x6400
    27c2:	9d05                	subw	a0,a0,s1
    27c4:	00003097          	auipc	ra,0x3
    27c8:	f8a080e7          	jalr	-118(ra) # 574e <sbrk>
  if (p != a) {
    27cc:	0ca49863          	bne	s1,a0,289c <sbrkmuch+0x108>
  char *eee = sbrk(0);
    27d0:	4501                	li	a0,0
    27d2:	00003097          	auipc	ra,0x3
    27d6:	f7c080e7          	jalr	-132(ra) # 574e <sbrk>
    27da:	87aa                	mv	a5,a0
  for(char *pp = a; pp < eee; pp += 4096)
    27dc:	00a4f963          	bgeu	s1,a0,27ee <sbrkmuch+0x5a>
    *pp = 1;
    27e0:	4685                	li	a3,1
  for(char *pp = a; pp < eee; pp += 4096)
    27e2:	6705                	lui	a4,0x1
    *pp = 1;
    27e4:	00d48023          	sb	a3,0(s1)
  for(char *pp = a; pp < eee; pp += 4096)
    27e8:	94ba                	add	s1,s1,a4
    27ea:	fef4ede3          	bltu	s1,a5,27e4 <sbrkmuch+0x50>
  *lastaddr = 99;
    27ee:	064007b7          	lui	a5,0x6400
    27f2:	06300713          	li	a4,99
    27f6:	fee78fa3          	sb	a4,-1(a5) # 63fffff <__BSS_END__+0x63f119f>
  a = sbrk(0);
    27fa:	4501                	li	a0,0
    27fc:	00003097          	auipc	ra,0x3
    2800:	f52080e7          	jalr	-174(ra) # 574e <sbrk>
    2804:	84aa                	mv	s1,a0
  c = sbrk(-PGSIZE);
    2806:	757d                	lui	a0,0xfffff
    2808:	00003097          	auipc	ra,0x3
    280c:	f46080e7          	jalr	-186(ra) # 574e <sbrk>
  if(c == (char*)0xffffffffffffffffL){
    2810:	57fd                	li	a5,-1
    2812:	0af50363          	beq	a0,a5,28b8 <sbrkmuch+0x124>
  c = sbrk(0);
    2816:	4501                	li	a0,0
    2818:	00003097          	auipc	ra,0x3
    281c:	f36080e7          	jalr	-202(ra) # 574e <sbrk>
  if(c != a - PGSIZE){
    2820:	77fd                	lui	a5,0xfffff
    2822:	97a6                	add	a5,a5,s1
    2824:	0af51863          	bne	a0,a5,28d4 <sbrkmuch+0x140>
  a = sbrk(0);
    2828:	4501                	li	a0,0
    282a:	00003097          	auipc	ra,0x3
    282e:	f24080e7          	jalr	-220(ra) # 574e <sbrk>
    2832:	84aa                	mv	s1,a0
  c = sbrk(PGSIZE);
    2834:	6505                	lui	a0,0x1
    2836:	00003097          	auipc	ra,0x3
    283a:	f18080e7          	jalr	-232(ra) # 574e <sbrk>
    283e:	8a2a                	mv	s4,a0
  if(c != a || sbrk(0) != a + PGSIZE){
    2840:	0aa49a63          	bne	s1,a0,28f4 <sbrkmuch+0x160>
    2844:	4501                	li	a0,0
    2846:	00003097          	auipc	ra,0x3
    284a:	f08080e7          	jalr	-248(ra) # 574e <sbrk>
    284e:	6785                	lui	a5,0x1
    2850:	97a6                	add	a5,a5,s1
    2852:	0af51163          	bne	a0,a5,28f4 <sbrkmuch+0x160>
  if(*lastaddr == 99){
    2856:	064007b7          	lui	a5,0x6400
    285a:	fff7c703          	lbu	a4,-1(a5) # 63fffff <__BSS_END__+0x63f119f>
    285e:	06300793          	li	a5,99
    2862:	0af70963          	beq	a4,a5,2914 <sbrkmuch+0x180>
  a = sbrk(0);
    2866:	4501                	li	a0,0
    2868:	00003097          	auipc	ra,0x3
    286c:	ee6080e7          	jalr	-282(ra) # 574e <sbrk>
    2870:	84aa                	mv	s1,a0
  c = sbrk(-(sbrk(0) - oldbrk));
    2872:	4501                	li	a0,0
    2874:	00003097          	auipc	ra,0x3
    2878:	eda080e7          	jalr	-294(ra) # 574e <sbrk>
    287c:	40a9053b          	subw	a0,s2,a0
    2880:	00003097          	auipc	ra,0x3
    2884:	ece080e7          	jalr	-306(ra) # 574e <sbrk>
  if(c != a){
    2888:	0aa49463          	bne	s1,a0,2930 <sbrkmuch+0x19c>
}
    288c:	70a2                	ld	ra,40(sp)
    288e:	7402                	ld	s0,32(sp)
    2890:	64e2                	ld	s1,24(sp)
    2892:	6942                	ld	s2,16(sp)
    2894:	69a2                	ld	s3,8(sp)
    2896:	6a02                	ld	s4,0(sp)
    2898:	6145                	add	sp,sp,48
    289a:	8082                	ret
    printf("%s: sbrk test failed to grow big address space; enough phys mem?\n", s);
    289c:	85ce                	mv	a1,s3
    289e:	00004517          	auipc	a0,0x4
    28a2:	43a50513          	add	a0,a0,1082 # 6cd8 <malloc+0xf5a>
    28a6:	00003097          	auipc	ra,0x3
    28aa:	258080e7          	jalr	600(ra) # 5afe <printf>
    exit(1);
    28ae:	4505                	li	a0,1
    28b0:	00003097          	auipc	ra,0x3
    28b4:	e16080e7          	jalr	-490(ra) # 56c6 <exit>
    printf("%s: sbrk could not deallocate\n", s);
    28b8:	85ce                	mv	a1,s3
    28ba:	00004517          	auipc	a0,0x4
    28be:	46650513          	add	a0,a0,1126 # 6d20 <malloc+0xfa2>
    28c2:	00003097          	auipc	ra,0x3
    28c6:	23c080e7          	jalr	572(ra) # 5afe <printf>
    exit(1);
    28ca:	4505                	li	a0,1
    28cc:	00003097          	auipc	ra,0x3
    28d0:	dfa080e7          	jalr	-518(ra) # 56c6 <exit>
    printf("%s: sbrk deallocation produced wrong address, a %x c %x\n", s, a, c);
    28d4:	86aa                	mv	a3,a0
    28d6:	8626                	mv	a2,s1
    28d8:	85ce                	mv	a1,s3
    28da:	00004517          	auipc	a0,0x4
    28de:	46650513          	add	a0,a0,1126 # 6d40 <malloc+0xfc2>
    28e2:	00003097          	auipc	ra,0x3
    28e6:	21c080e7          	jalr	540(ra) # 5afe <printf>
    exit(1);
    28ea:	4505                	li	a0,1
    28ec:	00003097          	auipc	ra,0x3
    28f0:	dda080e7          	jalr	-550(ra) # 56c6 <exit>
    printf("%s: sbrk re-allocation failed, a %x c %x\n", s, a, c);
    28f4:	86d2                	mv	a3,s4
    28f6:	8626                	mv	a2,s1
    28f8:	85ce                	mv	a1,s3
    28fa:	00004517          	auipc	a0,0x4
    28fe:	48650513          	add	a0,a0,1158 # 6d80 <malloc+0x1002>
    2902:	00003097          	auipc	ra,0x3
    2906:	1fc080e7          	jalr	508(ra) # 5afe <printf>
    exit(1);
    290a:	4505                	li	a0,1
    290c:	00003097          	auipc	ra,0x3
    2910:	dba080e7          	jalr	-582(ra) # 56c6 <exit>
    printf("%s: sbrk de-allocation didn't really deallocate\n", s);
    2914:	85ce                	mv	a1,s3
    2916:	00004517          	auipc	a0,0x4
    291a:	49a50513          	add	a0,a0,1178 # 6db0 <malloc+0x1032>
    291e:	00003097          	auipc	ra,0x3
    2922:	1e0080e7          	jalr	480(ra) # 5afe <printf>
    exit(1);
    2926:	4505                	li	a0,1
    2928:	00003097          	auipc	ra,0x3
    292c:	d9e080e7          	jalr	-610(ra) # 56c6 <exit>
    printf("%s: sbrk downsize failed, a %x c %x\n", s, a, c);
    2930:	86aa                	mv	a3,a0
    2932:	8626                	mv	a2,s1
    2934:	85ce                	mv	a1,s3
    2936:	00004517          	auipc	a0,0x4
    293a:	4b250513          	add	a0,a0,1202 # 6de8 <malloc+0x106a>
    293e:	00003097          	auipc	ra,0x3
    2942:	1c0080e7          	jalr	448(ra) # 5afe <printf>
    exit(1);
    2946:	4505                	li	a0,1
    2948:	00003097          	auipc	ra,0x3
    294c:	d7e080e7          	jalr	-642(ra) # 56c6 <exit>

0000000000002950 <sbrkarg>:
{
    2950:	7179                	add	sp,sp,-48
    2952:	f406                	sd	ra,40(sp)
    2954:	f022                	sd	s0,32(sp)
    2956:	ec26                	sd	s1,24(sp)
    2958:	e84a                	sd	s2,16(sp)
    295a:	e44e                	sd	s3,8(sp)
    295c:	1800                	add	s0,sp,48
    295e:	89aa                	mv	s3,a0
  a = sbrk(PGSIZE);
    2960:	6505                	lui	a0,0x1
    2962:	00003097          	auipc	ra,0x3
    2966:	dec080e7          	jalr	-532(ra) # 574e <sbrk>
    296a:	892a                	mv	s2,a0
  fd = open("sbrk", O_CREATE|O_WRONLY);
    296c:	20100593          	li	a1,513
    2970:	00004517          	auipc	a0,0x4
    2974:	4a050513          	add	a0,a0,1184 # 6e10 <malloc+0x1092>
    2978:	00003097          	auipc	ra,0x3
    297c:	d8e080e7          	jalr	-626(ra) # 5706 <open>
    2980:	84aa                	mv	s1,a0
  unlink("sbrk");
    2982:	00004517          	auipc	a0,0x4
    2986:	48e50513          	add	a0,a0,1166 # 6e10 <malloc+0x1092>
    298a:	00003097          	auipc	ra,0x3
    298e:	d8c080e7          	jalr	-628(ra) # 5716 <unlink>
  if(fd < 0)  {
    2992:	0404c163          	bltz	s1,29d4 <sbrkarg+0x84>
  if ((n = write(fd, a, PGSIZE)) < 0) {
    2996:	6605                	lui	a2,0x1
    2998:	85ca                	mv	a1,s2
    299a:	8526                	mv	a0,s1
    299c:	00003097          	auipc	ra,0x3
    29a0:	d4a080e7          	jalr	-694(ra) # 56e6 <write>
    29a4:	04054663          	bltz	a0,29f0 <sbrkarg+0xa0>
  close(fd);
    29a8:	8526                	mv	a0,s1
    29aa:	00003097          	auipc	ra,0x3
    29ae:	d44080e7          	jalr	-700(ra) # 56ee <close>
  a = sbrk(PGSIZE);
    29b2:	6505                	lui	a0,0x1
    29b4:	00003097          	auipc	ra,0x3
    29b8:	d9a080e7          	jalr	-614(ra) # 574e <sbrk>
  if(pipe((int *) a) != 0){
    29bc:	00003097          	auipc	ra,0x3
    29c0:	d1a080e7          	jalr	-742(ra) # 56d6 <pipe>
    29c4:	e521                	bnez	a0,2a0c <sbrkarg+0xbc>
}
    29c6:	70a2                	ld	ra,40(sp)
    29c8:	7402                	ld	s0,32(sp)
    29ca:	64e2                	ld	s1,24(sp)
    29cc:	6942                	ld	s2,16(sp)
    29ce:	69a2                	ld	s3,8(sp)
    29d0:	6145                	add	sp,sp,48
    29d2:	8082                	ret
    printf("%s: open sbrk failed\n", s);
    29d4:	85ce                	mv	a1,s3
    29d6:	00004517          	auipc	a0,0x4
    29da:	44250513          	add	a0,a0,1090 # 6e18 <malloc+0x109a>
    29de:	00003097          	auipc	ra,0x3
    29e2:	120080e7          	jalr	288(ra) # 5afe <printf>
    exit(1);
    29e6:	4505                	li	a0,1
    29e8:	00003097          	auipc	ra,0x3
    29ec:	cde080e7          	jalr	-802(ra) # 56c6 <exit>
    printf("%s: write sbrk failed\n", s);
    29f0:	85ce                	mv	a1,s3
    29f2:	00004517          	auipc	a0,0x4
    29f6:	43e50513          	add	a0,a0,1086 # 6e30 <malloc+0x10b2>
    29fa:	00003097          	auipc	ra,0x3
    29fe:	104080e7          	jalr	260(ra) # 5afe <printf>
    exit(1);
    2a02:	4505                	li	a0,1
    2a04:	00003097          	auipc	ra,0x3
    2a08:	cc2080e7          	jalr	-830(ra) # 56c6 <exit>
    printf("%s: pipe() failed\n", s);
    2a0c:	85ce                	mv	a1,s3
    2a0e:	00004517          	auipc	a0,0x4
    2a12:	e1a50513          	add	a0,a0,-486 # 6828 <malloc+0xaaa>
    2a16:	00003097          	auipc	ra,0x3
    2a1a:	0e8080e7          	jalr	232(ra) # 5afe <printf>
    exit(1);
    2a1e:	4505                	li	a0,1
    2a20:	00003097          	auipc	ra,0x3
    2a24:	ca6080e7          	jalr	-858(ra) # 56c6 <exit>

0000000000002a28 <argptest>:
{
    2a28:	1101                	add	sp,sp,-32
    2a2a:	ec06                	sd	ra,24(sp)
    2a2c:	e822                	sd	s0,16(sp)
    2a2e:	e426                	sd	s1,8(sp)
    2a30:	e04a                	sd	s2,0(sp)
    2a32:	1000                	add	s0,sp,32
    2a34:	892a                	mv	s2,a0
  fd = open("init", O_RDONLY);
    2a36:	4581                	li	a1,0
    2a38:	00004517          	auipc	a0,0x4
    2a3c:	41050513          	add	a0,a0,1040 # 6e48 <malloc+0x10ca>
    2a40:	00003097          	auipc	ra,0x3
    2a44:	cc6080e7          	jalr	-826(ra) # 5706 <open>
  if (fd < 0) {
    2a48:	02054b63          	bltz	a0,2a7e <argptest+0x56>
    2a4c:	84aa                	mv	s1,a0
  read(fd, sbrk(0) - 1, -1);
    2a4e:	4501                	li	a0,0
    2a50:	00003097          	auipc	ra,0x3
    2a54:	cfe080e7          	jalr	-770(ra) # 574e <sbrk>
    2a58:	567d                	li	a2,-1
    2a5a:	fff50593          	add	a1,a0,-1
    2a5e:	8526                	mv	a0,s1
    2a60:	00003097          	auipc	ra,0x3
    2a64:	c7e080e7          	jalr	-898(ra) # 56de <read>
  close(fd);
    2a68:	8526                	mv	a0,s1
    2a6a:	00003097          	auipc	ra,0x3
    2a6e:	c84080e7          	jalr	-892(ra) # 56ee <close>
}
    2a72:	60e2                	ld	ra,24(sp)
    2a74:	6442                	ld	s0,16(sp)
    2a76:	64a2                	ld	s1,8(sp)
    2a78:	6902                	ld	s2,0(sp)
    2a7a:	6105                	add	sp,sp,32
    2a7c:	8082                	ret
    printf("%s: open failed\n", s);
    2a7e:	85ca                	mv	a1,s2
    2a80:	00004517          	auipc	a0,0x4
    2a84:	cb850513          	add	a0,a0,-840 # 6738 <malloc+0x9ba>
    2a88:	00003097          	auipc	ra,0x3
    2a8c:	076080e7          	jalr	118(ra) # 5afe <printf>
    exit(1);
    2a90:	4505                	li	a0,1
    2a92:	00003097          	auipc	ra,0x3
    2a96:	c34080e7          	jalr	-972(ra) # 56c6 <exit>

0000000000002a9a <sbrkbugs>:
{
    2a9a:	1141                	add	sp,sp,-16
    2a9c:	e406                	sd	ra,8(sp)
    2a9e:	e022                	sd	s0,0(sp)
    2aa0:	0800                	add	s0,sp,16
  int pid = fork();
    2aa2:	00003097          	auipc	ra,0x3
    2aa6:	c1c080e7          	jalr	-996(ra) # 56be <fork>
  if(pid < 0){
    2aaa:	02054263          	bltz	a0,2ace <sbrkbugs+0x34>
  if(pid == 0){
    2aae:	ed0d                	bnez	a0,2ae8 <sbrkbugs+0x4e>
    int sz = (uint64) sbrk(0);
    2ab0:	00003097          	auipc	ra,0x3
    2ab4:	c9e080e7          	jalr	-866(ra) # 574e <sbrk>
    sbrk(-sz);
    2ab8:	40a0053b          	negw	a0,a0
    2abc:	00003097          	auipc	ra,0x3
    2ac0:	c92080e7          	jalr	-878(ra) # 574e <sbrk>
    exit(0);
    2ac4:	4501                	li	a0,0
    2ac6:	00003097          	auipc	ra,0x3
    2aca:	c00080e7          	jalr	-1024(ra) # 56c6 <exit>
    printf("fork failed\n");
    2ace:	00004517          	auipc	a0,0x4
    2ad2:	05a50513          	add	a0,a0,90 # 6b28 <malloc+0xdaa>
    2ad6:	00003097          	auipc	ra,0x3
    2ada:	028080e7          	jalr	40(ra) # 5afe <printf>
    exit(1);
    2ade:	4505                	li	a0,1
    2ae0:	00003097          	auipc	ra,0x3
    2ae4:	be6080e7          	jalr	-1050(ra) # 56c6 <exit>
  wait(0);
    2ae8:	4501                	li	a0,0
    2aea:	00003097          	auipc	ra,0x3
    2aee:	be4080e7          	jalr	-1052(ra) # 56ce <wait>
  pid = fork();
    2af2:	00003097          	auipc	ra,0x3
    2af6:	bcc080e7          	jalr	-1076(ra) # 56be <fork>
  if(pid < 0){
    2afa:	02054563          	bltz	a0,2b24 <sbrkbugs+0x8a>
  if(pid == 0){
    2afe:	e121                	bnez	a0,2b3e <sbrkbugs+0xa4>
    int sz = (uint64) sbrk(0);
    2b00:	00003097          	auipc	ra,0x3
    2b04:	c4e080e7          	jalr	-946(ra) # 574e <sbrk>
    sbrk(-(sz - 3500));
    2b08:	6785                	lui	a5,0x1
    2b0a:	dac7879b          	addw	a5,a5,-596 # dac <linktest+0x98>
    2b0e:	40a7853b          	subw	a0,a5,a0
    2b12:	00003097          	auipc	ra,0x3
    2b16:	c3c080e7          	jalr	-964(ra) # 574e <sbrk>
    exit(0);
    2b1a:	4501                	li	a0,0
    2b1c:	00003097          	auipc	ra,0x3
    2b20:	baa080e7          	jalr	-1110(ra) # 56c6 <exit>
    printf("fork failed\n");
    2b24:	00004517          	auipc	a0,0x4
    2b28:	00450513          	add	a0,a0,4 # 6b28 <malloc+0xdaa>
    2b2c:	00003097          	auipc	ra,0x3
    2b30:	fd2080e7          	jalr	-46(ra) # 5afe <printf>
    exit(1);
    2b34:	4505                	li	a0,1
    2b36:	00003097          	auipc	ra,0x3
    2b3a:	b90080e7          	jalr	-1136(ra) # 56c6 <exit>
  wait(0);
    2b3e:	4501                	li	a0,0
    2b40:	00003097          	auipc	ra,0x3
    2b44:	b8e080e7          	jalr	-1138(ra) # 56ce <wait>
  pid = fork();
    2b48:	00003097          	auipc	ra,0x3
    2b4c:	b76080e7          	jalr	-1162(ra) # 56be <fork>
  if(pid < 0){
    2b50:	02054a63          	bltz	a0,2b84 <sbrkbugs+0xea>
  if(pid == 0){
    2b54:	e529                	bnez	a0,2b9e <sbrkbugs+0x104>
    sbrk((10*4096 + 2048) - (uint64)sbrk(0));
    2b56:	00003097          	auipc	ra,0x3
    2b5a:	bf8080e7          	jalr	-1032(ra) # 574e <sbrk>
    2b5e:	67ad                	lui	a5,0xb
    2b60:	8007879b          	addw	a5,a5,-2048 # a800 <uninit+0x10c0>
    2b64:	40a7853b          	subw	a0,a5,a0
    2b68:	00003097          	auipc	ra,0x3
    2b6c:	be6080e7          	jalr	-1050(ra) # 574e <sbrk>
    sbrk(-10);
    2b70:	5559                	li	a0,-10
    2b72:	00003097          	auipc	ra,0x3
    2b76:	bdc080e7          	jalr	-1060(ra) # 574e <sbrk>
    exit(0);
    2b7a:	4501                	li	a0,0
    2b7c:	00003097          	auipc	ra,0x3
    2b80:	b4a080e7          	jalr	-1206(ra) # 56c6 <exit>
    printf("fork failed\n");
    2b84:	00004517          	auipc	a0,0x4
    2b88:	fa450513          	add	a0,a0,-92 # 6b28 <malloc+0xdaa>
    2b8c:	00003097          	auipc	ra,0x3
    2b90:	f72080e7          	jalr	-142(ra) # 5afe <printf>
    exit(1);
    2b94:	4505                	li	a0,1
    2b96:	00003097          	auipc	ra,0x3
    2b9a:	b30080e7          	jalr	-1232(ra) # 56c6 <exit>
  wait(0);
    2b9e:	4501                	li	a0,0
    2ba0:	00003097          	auipc	ra,0x3
    2ba4:	b2e080e7          	jalr	-1234(ra) # 56ce <wait>
  exit(0);
    2ba8:	4501                	li	a0,0
    2baa:	00003097          	auipc	ra,0x3
    2bae:	b1c080e7          	jalr	-1252(ra) # 56c6 <exit>

0000000000002bb2 <execout>:
// test the exec() code that cleans up if it runs out
// of memory. it's really a test that such a condition
// doesn't cause a panic.
void
execout(char *s)
{
    2bb2:	715d                	add	sp,sp,-80
    2bb4:	e486                	sd	ra,72(sp)
    2bb6:	e0a2                	sd	s0,64(sp)
    2bb8:	fc26                	sd	s1,56(sp)
    2bba:	f84a                	sd	s2,48(sp)
    2bbc:	f44e                	sd	s3,40(sp)
    2bbe:	f052                	sd	s4,32(sp)
    2bc0:	0880                	add	s0,sp,80
  for(int avail = 0; avail < 15; avail++){
    2bc2:	4901                	li	s2,0
    2bc4:	49bd                	li	s3,15
    int pid = fork();
    2bc6:	00003097          	auipc	ra,0x3
    2bca:	af8080e7          	jalr	-1288(ra) # 56be <fork>
    2bce:	84aa                	mv	s1,a0
    if(pid < 0){
    2bd0:	02054063          	bltz	a0,2bf0 <execout+0x3e>
      printf("fork failed\n");
      exit(1);
    } else if(pid == 0){
    2bd4:	c91d                	beqz	a0,2c0a <execout+0x58>
      close(1);
      char *args[] = { "echo", "x", 0 };
      exec("echo", args);
      exit(0);
    } else {
      wait((int*)0);
    2bd6:	4501                	li	a0,0
    2bd8:	00003097          	auipc	ra,0x3
    2bdc:	af6080e7          	jalr	-1290(ra) # 56ce <wait>
  for(int avail = 0; avail < 15; avail++){
    2be0:	2905                	addw	s2,s2,1
    2be2:	ff3912e3          	bne	s2,s3,2bc6 <execout+0x14>
    }
  }

  exit(0);
    2be6:	4501                	li	a0,0
    2be8:	00003097          	auipc	ra,0x3
    2bec:	ade080e7          	jalr	-1314(ra) # 56c6 <exit>
      printf("fork failed\n");
    2bf0:	00004517          	auipc	a0,0x4
    2bf4:	f3850513          	add	a0,a0,-200 # 6b28 <malloc+0xdaa>
    2bf8:	00003097          	auipc	ra,0x3
    2bfc:	f06080e7          	jalr	-250(ra) # 5afe <printf>
      exit(1);
    2c00:	4505                	li	a0,1
    2c02:	00003097          	auipc	ra,0x3
    2c06:	ac4080e7          	jalr	-1340(ra) # 56c6 <exit>
        if(a == 0xffffffffffffffffLL)
    2c0a:	59fd                	li	s3,-1
        *(char*)(a + 4096 - 1) = 1;
    2c0c:	4a05                	li	s4,1
        uint64 a = (uint64) sbrk(4096);
    2c0e:	6505                	lui	a0,0x1
    2c10:	00003097          	auipc	ra,0x3
    2c14:	b3e080e7          	jalr	-1218(ra) # 574e <sbrk>
        if(a == 0xffffffffffffffffLL)
    2c18:	01350763          	beq	a0,s3,2c26 <execout+0x74>
        *(char*)(a + 4096 - 1) = 1;
    2c1c:	6785                	lui	a5,0x1
    2c1e:	97aa                	add	a5,a5,a0
    2c20:	ff478fa3          	sb	s4,-1(a5) # fff <bigdir+0x9f>
      while(1){
    2c24:	b7ed                	j	2c0e <execout+0x5c>
      for(int i = 0; i < avail; i++)
    2c26:	01205a63          	blez	s2,2c3a <execout+0x88>
        sbrk(-4096);
    2c2a:	757d                	lui	a0,0xfffff
    2c2c:	00003097          	auipc	ra,0x3
    2c30:	b22080e7          	jalr	-1246(ra) # 574e <sbrk>
      for(int i = 0; i < avail; i++)
    2c34:	2485                	addw	s1,s1,1
    2c36:	ff249ae3          	bne	s1,s2,2c2a <execout+0x78>
      close(1);
    2c3a:	4505                	li	a0,1
    2c3c:	00003097          	auipc	ra,0x3
    2c40:	ab2080e7          	jalr	-1358(ra) # 56ee <close>
      char *args[] = { "echo", "x", 0 };
    2c44:	00003517          	auipc	a0,0x3
    2c48:	27450513          	add	a0,a0,628 # 5eb8 <malloc+0x13a>
    2c4c:	faa43c23          	sd	a0,-72(s0)
    2c50:	00003797          	auipc	a5,0x3
    2c54:	2d878793          	add	a5,a5,728 # 5f28 <malloc+0x1aa>
    2c58:	fcf43023          	sd	a5,-64(s0)
    2c5c:	fc043423          	sd	zero,-56(s0)
      exec("echo", args);
    2c60:	fb840593          	add	a1,s0,-72
    2c64:	00003097          	auipc	ra,0x3
    2c68:	a9a080e7          	jalr	-1382(ra) # 56fe <exec>
      exit(0);
    2c6c:	4501                	li	a0,0
    2c6e:	00003097          	auipc	ra,0x3
    2c72:	a58080e7          	jalr	-1448(ra) # 56c6 <exit>

0000000000002c76 <fourteen>:
{
    2c76:	1101                	add	sp,sp,-32
    2c78:	ec06                	sd	ra,24(sp)
    2c7a:	e822                	sd	s0,16(sp)
    2c7c:	e426                	sd	s1,8(sp)
    2c7e:	1000                	add	s0,sp,32
    2c80:	84aa                	mv	s1,a0
  if(mkdir("12345678901234") != 0){
    2c82:	00004517          	auipc	a0,0x4
    2c86:	39e50513          	add	a0,a0,926 # 7020 <malloc+0x12a2>
    2c8a:	00003097          	auipc	ra,0x3
    2c8e:	aa4080e7          	jalr	-1372(ra) # 572e <mkdir>
    2c92:	e165                	bnez	a0,2d72 <fourteen+0xfc>
  if(mkdir("12345678901234/123456789012345") != 0){
    2c94:	00004517          	auipc	a0,0x4
    2c98:	1e450513          	add	a0,a0,484 # 6e78 <malloc+0x10fa>
    2c9c:	00003097          	auipc	ra,0x3
    2ca0:	a92080e7          	jalr	-1390(ra) # 572e <mkdir>
    2ca4:	e56d                	bnez	a0,2d8e <fourteen+0x118>
  fd = open("123456789012345/123456789012345/123456789012345", O_CREATE);
    2ca6:	20000593          	li	a1,512
    2caa:	00004517          	auipc	a0,0x4
    2cae:	22650513          	add	a0,a0,550 # 6ed0 <malloc+0x1152>
    2cb2:	00003097          	auipc	ra,0x3
    2cb6:	a54080e7          	jalr	-1452(ra) # 5706 <open>
  if(fd < 0){
    2cba:	0e054863          	bltz	a0,2daa <fourteen+0x134>
  close(fd);
    2cbe:	00003097          	auipc	ra,0x3
    2cc2:	a30080e7          	jalr	-1488(ra) # 56ee <close>
  fd = open("12345678901234/12345678901234/12345678901234", 0);
    2cc6:	4581                	li	a1,0
    2cc8:	00004517          	auipc	a0,0x4
    2ccc:	28050513          	add	a0,a0,640 # 6f48 <malloc+0x11ca>
    2cd0:	00003097          	auipc	ra,0x3
    2cd4:	a36080e7          	jalr	-1482(ra) # 5706 <open>
  if(fd < 0){
    2cd8:	0e054763          	bltz	a0,2dc6 <fourteen+0x150>
  close(fd);
    2cdc:	00003097          	auipc	ra,0x3
    2ce0:	a12080e7          	jalr	-1518(ra) # 56ee <close>
  if(mkdir("12345678901234/12345678901234") == 0){
    2ce4:	00004517          	auipc	a0,0x4
    2ce8:	2d450513          	add	a0,a0,724 # 6fb8 <malloc+0x123a>
    2cec:	00003097          	auipc	ra,0x3
    2cf0:	a42080e7          	jalr	-1470(ra) # 572e <mkdir>
    2cf4:	c57d                	beqz	a0,2de2 <fourteen+0x16c>
  if(mkdir("123456789012345/12345678901234") == 0){
    2cf6:	00004517          	auipc	a0,0x4
    2cfa:	31a50513          	add	a0,a0,794 # 7010 <malloc+0x1292>
    2cfe:	00003097          	auipc	ra,0x3
    2d02:	a30080e7          	jalr	-1488(ra) # 572e <mkdir>
    2d06:	cd65                	beqz	a0,2dfe <fourteen+0x188>
  unlink("123456789012345/12345678901234");
    2d08:	00004517          	auipc	a0,0x4
    2d0c:	30850513          	add	a0,a0,776 # 7010 <malloc+0x1292>
    2d10:	00003097          	auipc	ra,0x3
    2d14:	a06080e7          	jalr	-1530(ra) # 5716 <unlink>
  unlink("12345678901234/12345678901234");
    2d18:	00004517          	auipc	a0,0x4
    2d1c:	2a050513          	add	a0,a0,672 # 6fb8 <malloc+0x123a>
    2d20:	00003097          	auipc	ra,0x3
    2d24:	9f6080e7          	jalr	-1546(ra) # 5716 <unlink>
  unlink("12345678901234/12345678901234/12345678901234");
    2d28:	00004517          	auipc	a0,0x4
    2d2c:	22050513          	add	a0,a0,544 # 6f48 <malloc+0x11ca>
    2d30:	00003097          	auipc	ra,0x3
    2d34:	9e6080e7          	jalr	-1562(ra) # 5716 <unlink>
  unlink("123456789012345/123456789012345/123456789012345");
    2d38:	00004517          	auipc	a0,0x4
    2d3c:	19850513          	add	a0,a0,408 # 6ed0 <malloc+0x1152>
    2d40:	00003097          	auipc	ra,0x3
    2d44:	9d6080e7          	jalr	-1578(ra) # 5716 <unlink>
  unlink("12345678901234/123456789012345");
    2d48:	00004517          	auipc	a0,0x4
    2d4c:	13050513          	add	a0,a0,304 # 6e78 <malloc+0x10fa>
    2d50:	00003097          	auipc	ra,0x3
    2d54:	9c6080e7          	jalr	-1594(ra) # 5716 <unlink>
  unlink("12345678901234");
    2d58:	00004517          	auipc	a0,0x4
    2d5c:	2c850513          	add	a0,a0,712 # 7020 <malloc+0x12a2>
    2d60:	00003097          	auipc	ra,0x3
    2d64:	9b6080e7          	jalr	-1610(ra) # 5716 <unlink>
}
    2d68:	60e2                	ld	ra,24(sp)
    2d6a:	6442                	ld	s0,16(sp)
    2d6c:	64a2                	ld	s1,8(sp)
    2d6e:	6105                	add	sp,sp,32
    2d70:	8082                	ret
    printf("%s: mkdir 12345678901234 failed\n", s);
    2d72:	85a6                	mv	a1,s1
    2d74:	00004517          	auipc	a0,0x4
    2d78:	0dc50513          	add	a0,a0,220 # 6e50 <malloc+0x10d2>
    2d7c:	00003097          	auipc	ra,0x3
    2d80:	d82080e7          	jalr	-638(ra) # 5afe <printf>
    exit(1);
    2d84:	4505                	li	a0,1
    2d86:	00003097          	auipc	ra,0x3
    2d8a:	940080e7          	jalr	-1728(ra) # 56c6 <exit>
    printf("%s: mkdir 12345678901234/123456789012345 failed\n", s);
    2d8e:	85a6                	mv	a1,s1
    2d90:	00004517          	auipc	a0,0x4
    2d94:	10850513          	add	a0,a0,264 # 6e98 <malloc+0x111a>
    2d98:	00003097          	auipc	ra,0x3
    2d9c:	d66080e7          	jalr	-666(ra) # 5afe <printf>
    exit(1);
    2da0:	4505                	li	a0,1
    2da2:	00003097          	auipc	ra,0x3
    2da6:	924080e7          	jalr	-1756(ra) # 56c6 <exit>
    printf("%s: create 123456789012345/123456789012345/123456789012345 failed\n", s);
    2daa:	85a6                	mv	a1,s1
    2dac:	00004517          	auipc	a0,0x4
    2db0:	15450513          	add	a0,a0,340 # 6f00 <malloc+0x1182>
    2db4:	00003097          	auipc	ra,0x3
    2db8:	d4a080e7          	jalr	-694(ra) # 5afe <printf>
    exit(1);
    2dbc:	4505                	li	a0,1
    2dbe:	00003097          	auipc	ra,0x3
    2dc2:	908080e7          	jalr	-1784(ra) # 56c6 <exit>
    printf("%s: open 12345678901234/12345678901234/12345678901234 failed\n", s);
    2dc6:	85a6                	mv	a1,s1
    2dc8:	00004517          	auipc	a0,0x4
    2dcc:	1b050513          	add	a0,a0,432 # 6f78 <malloc+0x11fa>
    2dd0:	00003097          	auipc	ra,0x3
    2dd4:	d2e080e7          	jalr	-722(ra) # 5afe <printf>
    exit(1);
    2dd8:	4505                	li	a0,1
    2dda:	00003097          	auipc	ra,0x3
    2dde:	8ec080e7          	jalr	-1812(ra) # 56c6 <exit>
    printf("%s: mkdir 12345678901234/12345678901234 succeeded!\n", s);
    2de2:	85a6                	mv	a1,s1
    2de4:	00004517          	auipc	a0,0x4
    2de8:	1f450513          	add	a0,a0,500 # 6fd8 <malloc+0x125a>
    2dec:	00003097          	auipc	ra,0x3
    2df0:	d12080e7          	jalr	-750(ra) # 5afe <printf>
    exit(1);
    2df4:	4505                	li	a0,1
    2df6:	00003097          	auipc	ra,0x3
    2dfa:	8d0080e7          	jalr	-1840(ra) # 56c6 <exit>
    printf("%s: mkdir 12345678901234/123456789012345 succeeded!\n", s);
    2dfe:	85a6                	mv	a1,s1
    2e00:	00004517          	auipc	a0,0x4
    2e04:	23050513          	add	a0,a0,560 # 7030 <malloc+0x12b2>
    2e08:	00003097          	auipc	ra,0x3
    2e0c:	cf6080e7          	jalr	-778(ra) # 5afe <printf>
    exit(1);
    2e10:	4505                	li	a0,1
    2e12:	00003097          	auipc	ra,0x3
    2e16:	8b4080e7          	jalr	-1868(ra) # 56c6 <exit>

0000000000002e1a <iputtest>:
{
    2e1a:	1101                	add	sp,sp,-32
    2e1c:	ec06                	sd	ra,24(sp)
    2e1e:	e822                	sd	s0,16(sp)
    2e20:	e426                	sd	s1,8(sp)
    2e22:	1000                	add	s0,sp,32
    2e24:	84aa                	mv	s1,a0
  if(mkdir("iputdir") < 0){
    2e26:	00004517          	auipc	a0,0x4
    2e2a:	24250513          	add	a0,a0,578 # 7068 <malloc+0x12ea>
    2e2e:	00003097          	auipc	ra,0x3
    2e32:	900080e7          	jalr	-1792(ra) # 572e <mkdir>
    2e36:	04054563          	bltz	a0,2e80 <iputtest+0x66>
  if(chdir("iputdir") < 0){
    2e3a:	00004517          	auipc	a0,0x4
    2e3e:	22e50513          	add	a0,a0,558 # 7068 <malloc+0x12ea>
    2e42:	00003097          	auipc	ra,0x3
    2e46:	8f4080e7          	jalr	-1804(ra) # 5736 <chdir>
    2e4a:	04054963          	bltz	a0,2e9c <iputtest+0x82>
  if(unlink("../iputdir") < 0){
    2e4e:	00004517          	auipc	a0,0x4
    2e52:	25a50513          	add	a0,a0,602 # 70a8 <malloc+0x132a>
    2e56:	00003097          	auipc	ra,0x3
    2e5a:	8c0080e7          	jalr	-1856(ra) # 5716 <unlink>
    2e5e:	04054d63          	bltz	a0,2eb8 <iputtest+0x9e>
  if(chdir("/") < 0){
    2e62:	00004517          	auipc	a0,0x4
    2e66:	27650513          	add	a0,a0,630 # 70d8 <malloc+0x135a>
    2e6a:	00003097          	auipc	ra,0x3
    2e6e:	8cc080e7          	jalr	-1844(ra) # 5736 <chdir>
    2e72:	06054163          	bltz	a0,2ed4 <iputtest+0xba>
}
    2e76:	60e2                	ld	ra,24(sp)
    2e78:	6442                	ld	s0,16(sp)
    2e7a:	64a2                	ld	s1,8(sp)
    2e7c:	6105                	add	sp,sp,32
    2e7e:	8082                	ret
    printf("%s: mkdir failed\n", s);
    2e80:	85a6                	mv	a1,s1
    2e82:	00004517          	auipc	a0,0x4
    2e86:	1ee50513          	add	a0,a0,494 # 7070 <malloc+0x12f2>
    2e8a:	00003097          	auipc	ra,0x3
    2e8e:	c74080e7          	jalr	-908(ra) # 5afe <printf>
    exit(1);
    2e92:	4505                	li	a0,1
    2e94:	00003097          	auipc	ra,0x3
    2e98:	832080e7          	jalr	-1998(ra) # 56c6 <exit>
    printf("%s: chdir iputdir failed\n", s);
    2e9c:	85a6                	mv	a1,s1
    2e9e:	00004517          	auipc	a0,0x4
    2ea2:	1ea50513          	add	a0,a0,490 # 7088 <malloc+0x130a>
    2ea6:	00003097          	auipc	ra,0x3
    2eaa:	c58080e7          	jalr	-936(ra) # 5afe <printf>
    exit(1);
    2eae:	4505                	li	a0,1
    2eb0:	00003097          	auipc	ra,0x3
    2eb4:	816080e7          	jalr	-2026(ra) # 56c6 <exit>
    printf("%s: unlink ../iputdir failed\n", s);
    2eb8:	85a6                	mv	a1,s1
    2eba:	00004517          	auipc	a0,0x4
    2ebe:	1fe50513          	add	a0,a0,510 # 70b8 <malloc+0x133a>
    2ec2:	00003097          	auipc	ra,0x3
    2ec6:	c3c080e7          	jalr	-964(ra) # 5afe <printf>
    exit(1);
    2eca:	4505                	li	a0,1
    2ecc:	00002097          	auipc	ra,0x2
    2ed0:	7fa080e7          	jalr	2042(ra) # 56c6 <exit>
    printf("%s: chdir / failed\n", s);
    2ed4:	85a6                	mv	a1,s1
    2ed6:	00004517          	auipc	a0,0x4
    2eda:	20a50513          	add	a0,a0,522 # 70e0 <malloc+0x1362>
    2ede:	00003097          	auipc	ra,0x3
    2ee2:	c20080e7          	jalr	-992(ra) # 5afe <printf>
    exit(1);
    2ee6:	4505                	li	a0,1
    2ee8:	00002097          	auipc	ra,0x2
    2eec:	7de080e7          	jalr	2014(ra) # 56c6 <exit>

0000000000002ef0 <exitiputtest>:
{
    2ef0:	7179                	add	sp,sp,-48
    2ef2:	f406                	sd	ra,40(sp)
    2ef4:	f022                	sd	s0,32(sp)
    2ef6:	ec26                	sd	s1,24(sp)
    2ef8:	1800                	add	s0,sp,48
    2efa:	84aa                	mv	s1,a0
  pid = fork();
    2efc:	00002097          	auipc	ra,0x2
    2f00:	7c2080e7          	jalr	1986(ra) # 56be <fork>
  if(pid < 0){
    2f04:	04054663          	bltz	a0,2f50 <exitiputtest+0x60>
  if(pid == 0){
    2f08:	ed45                	bnez	a0,2fc0 <exitiputtest+0xd0>
    if(mkdir("iputdir") < 0){
    2f0a:	00004517          	auipc	a0,0x4
    2f0e:	15e50513          	add	a0,a0,350 # 7068 <malloc+0x12ea>
    2f12:	00003097          	auipc	ra,0x3
    2f16:	81c080e7          	jalr	-2020(ra) # 572e <mkdir>
    2f1a:	04054963          	bltz	a0,2f6c <exitiputtest+0x7c>
    if(chdir("iputdir") < 0){
    2f1e:	00004517          	auipc	a0,0x4
    2f22:	14a50513          	add	a0,a0,330 # 7068 <malloc+0x12ea>
    2f26:	00003097          	auipc	ra,0x3
    2f2a:	810080e7          	jalr	-2032(ra) # 5736 <chdir>
    2f2e:	04054d63          	bltz	a0,2f88 <exitiputtest+0x98>
    if(unlink("../iputdir") < 0){
    2f32:	00004517          	auipc	a0,0x4
    2f36:	17650513          	add	a0,a0,374 # 70a8 <malloc+0x132a>
    2f3a:	00002097          	auipc	ra,0x2
    2f3e:	7dc080e7          	jalr	2012(ra) # 5716 <unlink>
    2f42:	06054163          	bltz	a0,2fa4 <exitiputtest+0xb4>
    exit(0);
    2f46:	4501                	li	a0,0
    2f48:	00002097          	auipc	ra,0x2
    2f4c:	77e080e7          	jalr	1918(ra) # 56c6 <exit>
    printf("%s: fork failed\n", s);
    2f50:	85a6                	mv	a1,s1
    2f52:	00003517          	auipc	a0,0x3
    2f56:	7ce50513          	add	a0,a0,1998 # 6720 <malloc+0x9a2>
    2f5a:	00003097          	auipc	ra,0x3
    2f5e:	ba4080e7          	jalr	-1116(ra) # 5afe <printf>
    exit(1);
    2f62:	4505                	li	a0,1
    2f64:	00002097          	auipc	ra,0x2
    2f68:	762080e7          	jalr	1890(ra) # 56c6 <exit>
      printf("%s: mkdir failed\n", s);
    2f6c:	85a6                	mv	a1,s1
    2f6e:	00004517          	auipc	a0,0x4
    2f72:	10250513          	add	a0,a0,258 # 7070 <malloc+0x12f2>
    2f76:	00003097          	auipc	ra,0x3
    2f7a:	b88080e7          	jalr	-1144(ra) # 5afe <printf>
      exit(1);
    2f7e:	4505                	li	a0,1
    2f80:	00002097          	auipc	ra,0x2
    2f84:	746080e7          	jalr	1862(ra) # 56c6 <exit>
      printf("%s: child chdir failed\n", s);
    2f88:	85a6                	mv	a1,s1
    2f8a:	00004517          	auipc	a0,0x4
    2f8e:	16e50513          	add	a0,a0,366 # 70f8 <malloc+0x137a>
    2f92:	00003097          	auipc	ra,0x3
    2f96:	b6c080e7          	jalr	-1172(ra) # 5afe <printf>
      exit(1);
    2f9a:	4505                	li	a0,1
    2f9c:	00002097          	auipc	ra,0x2
    2fa0:	72a080e7          	jalr	1834(ra) # 56c6 <exit>
      printf("%s: unlink ../iputdir failed\n", s);
    2fa4:	85a6                	mv	a1,s1
    2fa6:	00004517          	auipc	a0,0x4
    2faa:	11250513          	add	a0,a0,274 # 70b8 <malloc+0x133a>
    2fae:	00003097          	auipc	ra,0x3
    2fb2:	b50080e7          	jalr	-1200(ra) # 5afe <printf>
      exit(1);
    2fb6:	4505                	li	a0,1
    2fb8:	00002097          	auipc	ra,0x2
    2fbc:	70e080e7          	jalr	1806(ra) # 56c6 <exit>
  wait(&xstatus);
    2fc0:	fdc40513          	add	a0,s0,-36
    2fc4:	00002097          	auipc	ra,0x2
    2fc8:	70a080e7          	jalr	1802(ra) # 56ce <wait>
  exit(xstatus);
    2fcc:	fdc42503          	lw	a0,-36(s0)
    2fd0:	00002097          	auipc	ra,0x2
    2fd4:	6f6080e7          	jalr	1782(ra) # 56c6 <exit>

0000000000002fd8 <dirtest>:
{
    2fd8:	1101                	add	sp,sp,-32
    2fda:	ec06                	sd	ra,24(sp)
    2fdc:	e822                	sd	s0,16(sp)
    2fde:	e426                	sd	s1,8(sp)
    2fe0:	1000                	add	s0,sp,32
    2fe2:	84aa                	mv	s1,a0
  if(mkdir("dir0") < 0){
    2fe4:	00004517          	auipc	a0,0x4
    2fe8:	12c50513          	add	a0,a0,300 # 7110 <malloc+0x1392>
    2fec:	00002097          	auipc	ra,0x2
    2ff0:	742080e7          	jalr	1858(ra) # 572e <mkdir>
    2ff4:	04054563          	bltz	a0,303e <dirtest+0x66>
  if(chdir("dir0") < 0){
    2ff8:	00004517          	auipc	a0,0x4
    2ffc:	11850513          	add	a0,a0,280 # 7110 <malloc+0x1392>
    3000:	00002097          	auipc	ra,0x2
    3004:	736080e7          	jalr	1846(ra) # 5736 <chdir>
    3008:	04054963          	bltz	a0,305a <dirtest+0x82>
  if(chdir("..") < 0){
    300c:	00004517          	auipc	a0,0x4
    3010:	12450513          	add	a0,a0,292 # 7130 <malloc+0x13b2>
    3014:	00002097          	auipc	ra,0x2
    3018:	722080e7          	jalr	1826(ra) # 5736 <chdir>
    301c:	04054d63          	bltz	a0,3076 <dirtest+0x9e>
  if(unlink("dir0") < 0){
    3020:	00004517          	auipc	a0,0x4
    3024:	0f050513          	add	a0,a0,240 # 7110 <malloc+0x1392>
    3028:	00002097          	auipc	ra,0x2
    302c:	6ee080e7          	jalr	1774(ra) # 5716 <unlink>
    3030:	06054163          	bltz	a0,3092 <dirtest+0xba>
}
    3034:	60e2                	ld	ra,24(sp)
    3036:	6442                	ld	s0,16(sp)
    3038:	64a2                	ld	s1,8(sp)
    303a:	6105                	add	sp,sp,32
    303c:	8082                	ret
    printf("%s: mkdir failed\n", s);
    303e:	85a6                	mv	a1,s1
    3040:	00004517          	auipc	a0,0x4
    3044:	03050513          	add	a0,a0,48 # 7070 <malloc+0x12f2>
    3048:	00003097          	auipc	ra,0x3
    304c:	ab6080e7          	jalr	-1354(ra) # 5afe <printf>
    exit(1);
    3050:	4505                	li	a0,1
    3052:	00002097          	auipc	ra,0x2
    3056:	674080e7          	jalr	1652(ra) # 56c6 <exit>
    printf("%s: chdir dir0 failed\n", s);
    305a:	85a6                	mv	a1,s1
    305c:	00004517          	auipc	a0,0x4
    3060:	0bc50513          	add	a0,a0,188 # 7118 <malloc+0x139a>
    3064:	00003097          	auipc	ra,0x3
    3068:	a9a080e7          	jalr	-1382(ra) # 5afe <printf>
    exit(1);
    306c:	4505                	li	a0,1
    306e:	00002097          	auipc	ra,0x2
    3072:	658080e7          	jalr	1624(ra) # 56c6 <exit>
    printf("%s: chdir .. failed\n", s);
    3076:	85a6                	mv	a1,s1
    3078:	00004517          	auipc	a0,0x4
    307c:	0c050513          	add	a0,a0,192 # 7138 <malloc+0x13ba>
    3080:	00003097          	auipc	ra,0x3
    3084:	a7e080e7          	jalr	-1410(ra) # 5afe <printf>
    exit(1);
    3088:	4505                	li	a0,1
    308a:	00002097          	auipc	ra,0x2
    308e:	63c080e7          	jalr	1596(ra) # 56c6 <exit>
    printf("%s: unlink dir0 failed\n", s);
    3092:	85a6                	mv	a1,s1
    3094:	00004517          	auipc	a0,0x4
    3098:	0bc50513          	add	a0,a0,188 # 7150 <malloc+0x13d2>
    309c:	00003097          	auipc	ra,0x3
    30a0:	a62080e7          	jalr	-1438(ra) # 5afe <printf>
    exit(1);
    30a4:	4505                	li	a0,1
    30a6:	00002097          	auipc	ra,0x2
    30aa:	620080e7          	jalr	1568(ra) # 56c6 <exit>

00000000000030ae <subdir>:
{
    30ae:	1101                	add	sp,sp,-32
    30b0:	ec06                	sd	ra,24(sp)
    30b2:	e822                	sd	s0,16(sp)
    30b4:	e426                	sd	s1,8(sp)
    30b6:	e04a                	sd	s2,0(sp)
    30b8:	1000                	add	s0,sp,32
    30ba:	892a                	mv	s2,a0
  unlink("ff");
    30bc:	00004517          	auipc	a0,0x4
    30c0:	1dc50513          	add	a0,a0,476 # 7298 <malloc+0x151a>
    30c4:	00002097          	auipc	ra,0x2
    30c8:	652080e7          	jalr	1618(ra) # 5716 <unlink>
  if(mkdir("dd") != 0){
    30cc:	00004517          	auipc	a0,0x4
    30d0:	09c50513          	add	a0,a0,156 # 7168 <malloc+0x13ea>
    30d4:	00002097          	auipc	ra,0x2
    30d8:	65a080e7          	jalr	1626(ra) # 572e <mkdir>
    30dc:	38051663          	bnez	a0,3468 <subdir+0x3ba>
  fd = open("dd/ff", O_CREATE | O_RDWR);
    30e0:	20200593          	li	a1,514
    30e4:	00004517          	auipc	a0,0x4
    30e8:	0a450513          	add	a0,a0,164 # 7188 <malloc+0x140a>
    30ec:	00002097          	auipc	ra,0x2
    30f0:	61a080e7          	jalr	1562(ra) # 5706 <open>
    30f4:	84aa                	mv	s1,a0
  if(fd < 0){
    30f6:	38054763          	bltz	a0,3484 <subdir+0x3d6>
  write(fd, "ff", 2);
    30fa:	4609                	li	a2,2
    30fc:	00004597          	auipc	a1,0x4
    3100:	19c58593          	add	a1,a1,412 # 7298 <malloc+0x151a>
    3104:	00002097          	auipc	ra,0x2
    3108:	5e2080e7          	jalr	1506(ra) # 56e6 <write>
  close(fd);
    310c:	8526                	mv	a0,s1
    310e:	00002097          	auipc	ra,0x2
    3112:	5e0080e7          	jalr	1504(ra) # 56ee <close>
  if(unlink("dd") >= 0){
    3116:	00004517          	auipc	a0,0x4
    311a:	05250513          	add	a0,a0,82 # 7168 <malloc+0x13ea>
    311e:	00002097          	auipc	ra,0x2
    3122:	5f8080e7          	jalr	1528(ra) # 5716 <unlink>
    3126:	36055d63          	bgez	a0,34a0 <subdir+0x3f2>
  if(mkdir("/dd/dd") != 0){
    312a:	00004517          	auipc	a0,0x4
    312e:	0b650513          	add	a0,a0,182 # 71e0 <malloc+0x1462>
    3132:	00002097          	auipc	ra,0x2
    3136:	5fc080e7          	jalr	1532(ra) # 572e <mkdir>
    313a:	38051163          	bnez	a0,34bc <subdir+0x40e>
  fd = open("dd/dd/ff", O_CREATE | O_RDWR);
    313e:	20200593          	li	a1,514
    3142:	00004517          	auipc	a0,0x4
    3146:	0c650513          	add	a0,a0,198 # 7208 <malloc+0x148a>
    314a:	00002097          	auipc	ra,0x2
    314e:	5bc080e7          	jalr	1468(ra) # 5706 <open>
    3152:	84aa                	mv	s1,a0
  if(fd < 0){
    3154:	38054263          	bltz	a0,34d8 <subdir+0x42a>
  write(fd, "FF", 2);
    3158:	4609                	li	a2,2
    315a:	00004597          	auipc	a1,0x4
    315e:	0de58593          	add	a1,a1,222 # 7238 <malloc+0x14ba>
    3162:	00002097          	auipc	ra,0x2
    3166:	584080e7          	jalr	1412(ra) # 56e6 <write>
  close(fd);
    316a:	8526                	mv	a0,s1
    316c:	00002097          	auipc	ra,0x2
    3170:	582080e7          	jalr	1410(ra) # 56ee <close>
  fd = open("dd/dd/../ff", 0);
    3174:	4581                	li	a1,0
    3176:	00004517          	auipc	a0,0x4
    317a:	0ca50513          	add	a0,a0,202 # 7240 <malloc+0x14c2>
    317e:	00002097          	auipc	ra,0x2
    3182:	588080e7          	jalr	1416(ra) # 5706 <open>
    3186:	84aa                	mv	s1,a0
  if(fd < 0){
    3188:	36054663          	bltz	a0,34f4 <subdir+0x446>
  cc = read(fd, buf, sizeof(buf));
    318c:	660d                	lui	a2,0x3
    318e:	00009597          	auipc	a1,0x9
    3192:	cc258593          	add	a1,a1,-830 # be50 <buf>
    3196:	00002097          	auipc	ra,0x2
    319a:	548080e7          	jalr	1352(ra) # 56de <read>
  if(cc != 2 || buf[0] != 'f'){
    319e:	4789                	li	a5,2
    31a0:	36f51863          	bne	a0,a5,3510 <subdir+0x462>
    31a4:	00009717          	auipc	a4,0x9
    31a8:	cac74703          	lbu	a4,-852(a4) # be50 <buf>
    31ac:	06600793          	li	a5,102
    31b0:	36f71063          	bne	a4,a5,3510 <subdir+0x462>
  close(fd);
    31b4:	8526                	mv	a0,s1
    31b6:	00002097          	auipc	ra,0x2
    31ba:	538080e7          	jalr	1336(ra) # 56ee <close>
  if(link("dd/dd/ff", "dd/dd/ffff") != 0){
    31be:	00004597          	auipc	a1,0x4
    31c2:	0d258593          	add	a1,a1,210 # 7290 <malloc+0x1512>
    31c6:	00004517          	auipc	a0,0x4
    31ca:	04250513          	add	a0,a0,66 # 7208 <malloc+0x148a>
    31ce:	00002097          	auipc	ra,0x2
    31d2:	558080e7          	jalr	1368(ra) # 5726 <link>
    31d6:	34051b63          	bnez	a0,352c <subdir+0x47e>
  if(unlink("dd/dd/ff") != 0){
    31da:	00004517          	auipc	a0,0x4
    31de:	02e50513          	add	a0,a0,46 # 7208 <malloc+0x148a>
    31e2:	00002097          	auipc	ra,0x2
    31e6:	534080e7          	jalr	1332(ra) # 5716 <unlink>
    31ea:	34051f63          	bnez	a0,3548 <subdir+0x49a>
  if(open("dd/dd/ff", O_RDONLY) >= 0){
    31ee:	4581                	li	a1,0
    31f0:	00004517          	auipc	a0,0x4
    31f4:	01850513          	add	a0,a0,24 # 7208 <malloc+0x148a>
    31f8:	00002097          	auipc	ra,0x2
    31fc:	50e080e7          	jalr	1294(ra) # 5706 <open>
    3200:	36055263          	bgez	a0,3564 <subdir+0x4b6>
  if(chdir("dd") != 0){
    3204:	00004517          	auipc	a0,0x4
    3208:	f6450513          	add	a0,a0,-156 # 7168 <malloc+0x13ea>
    320c:	00002097          	auipc	ra,0x2
    3210:	52a080e7          	jalr	1322(ra) # 5736 <chdir>
    3214:	36051663          	bnez	a0,3580 <subdir+0x4d2>
  if(chdir("dd/../../dd") != 0){
    3218:	00004517          	auipc	a0,0x4
    321c:	11050513          	add	a0,a0,272 # 7328 <malloc+0x15aa>
    3220:	00002097          	auipc	ra,0x2
    3224:	516080e7          	jalr	1302(ra) # 5736 <chdir>
    3228:	36051a63          	bnez	a0,359c <subdir+0x4ee>
  if(chdir("dd/../../../dd") != 0){
    322c:	00004517          	auipc	a0,0x4
    3230:	12c50513          	add	a0,a0,300 # 7358 <malloc+0x15da>
    3234:	00002097          	auipc	ra,0x2
    3238:	502080e7          	jalr	1282(ra) # 5736 <chdir>
    323c:	36051e63          	bnez	a0,35b8 <subdir+0x50a>
  if(chdir("./..") != 0){
    3240:	00004517          	auipc	a0,0x4
    3244:	14850513          	add	a0,a0,328 # 7388 <malloc+0x160a>
    3248:	00002097          	auipc	ra,0x2
    324c:	4ee080e7          	jalr	1262(ra) # 5736 <chdir>
    3250:	38051263          	bnez	a0,35d4 <subdir+0x526>
  fd = open("dd/dd/ffff", 0);
    3254:	4581                	li	a1,0
    3256:	00004517          	auipc	a0,0x4
    325a:	03a50513          	add	a0,a0,58 # 7290 <malloc+0x1512>
    325e:	00002097          	auipc	ra,0x2
    3262:	4a8080e7          	jalr	1192(ra) # 5706 <open>
    3266:	84aa                	mv	s1,a0
  if(fd < 0){
    3268:	38054463          	bltz	a0,35f0 <subdir+0x542>
  if(read(fd, buf, sizeof(buf)) != 2){
    326c:	660d                	lui	a2,0x3
    326e:	00009597          	auipc	a1,0x9
    3272:	be258593          	add	a1,a1,-1054 # be50 <buf>
    3276:	00002097          	auipc	ra,0x2
    327a:	468080e7          	jalr	1128(ra) # 56de <read>
    327e:	4789                	li	a5,2
    3280:	38f51663          	bne	a0,a5,360c <subdir+0x55e>
  close(fd);
    3284:	8526                	mv	a0,s1
    3286:	00002097          	auipc	ra,0x2
    328a:	468080e7          	jalr	1128(ra) # 56ee <close>
  if(open("dd/dd/ff", O_RDONLY) >= 0){
    328e:	4581                	li	a1,0
    3290:	00004517          	auipc	a0,0x4
    3294:	f7850513          	add	a0,a0,-136 # 7208 <malloc+0x148a>
    3298:	00002097          	auipc	ra,0x2
    329c:	46e080e7          	jalr	1134(ra) # 5706 <open>
    32a0:	38055463          	bgez	a0,3628 <subdir+0x57a>
  if(open("dd/ff/ff", O_CREATE|O_RDWR) >= 0){
    32a4:	20200593          	li	a1,514
    32a8:	00004517          	auipc	a0,0x4
    32ac:	17050513          	add	a0,a0,368 # 7418 <malloc+0x169a>
    32b0:	00002097          	auipc	ra,0x2
    32b4:	456080e7          	jalr	1110(ra) # 5706 <open>
    32b8:	38055663          	bgez	a0,3644 <subdir+0x596>
  if(open("dd/xx/ff", O_CREATE|O_RDWR) >= 0){
    32bc:	20200593          	li	a1,514
    32c0:	00004517          	auipc	a0,0x4
    32c4:	18850513          	add	a0,a0,392 # 7448 <malloc+0x16ca>
    32c8:	00002097          	auipc	ra,0x2
    32cc:	43e080e7          	jalr	1086(ra) # 5706 <open>
    32d0:	38055863          	bgez	a0,3660 <subdir+0x5b2>
  if(open("dd", O_CREATE) >= 0){
    32d4:	20000593          	li	a1,512
    32d8:	00004517          	auipc	a0,0x4
    32dc:	e9050513          	add	a0,a0,-368 # 7168 <malloc+0x13ea>
    32e0:	00002097          	auipc	ra,0x2
    32e4:	426080e7          	jalr	1062(ra) # 5706 <open>
    32e8:	38055a63          	bgez	a0,367c <subdir+0x5ce>
  if(open("dd", O_RDWR) >= 0){
    32ec:	4589                	li	a1,2
    32ee:	00004517          	auipc	a0,0x4
    32f2:	e7a50513          	add	a0,a0,-390 # 7168 <malloc+0x13ea>
    32f6:	00002097          	auipc	ra,0x2
    32fa:	410080e7          	jalr	1040(ra) # 5706 <open>
    32fe:	38055d63          	bgez	a0,3698 <subdir+0x5ea>
  if(open("dd", O_WRONLY) >= 0){
    3302:	4585                	li	a1,1
    3304:	00004517          	auipc	a0,0x4
    3308:	e6450513          	add	a0,a0,-412 # 7168 <malloc+0x13ea>
    330c:	00002097          	auipc	ra,0x2
    3310:	3fa080e7          	jalr	1018(ra) # 5706 <open>
    3314:	3a055063          	bgez	a0,36b4 <subdir+0x606>
  if(link("dd/ff/ff", "dd/dd/xx") == 0){
    3318:	00004597          	auipc	a1,0x4
    331c:	1c058593          	add	a1,a1,448 # 74d8 <malloc+0x175a>
    3320:	00004517          	auipc	a0,0x4
    3324:	0f850513          	add	a0,a0,248 # 7418 <malloc+0x169a>
    3328:	00002097          	auipc	ra,0x2
    332c:	3fe080e7          	jalr	1022(ra) # 5726 <link>
    3330:	3a050063          	beqz	a0,36d0 <subdir+0x622>
  if(link("dd/xx/ff", "dd/dd/xx") == 0){
    3334:	00004597          	auipc	a1,0x4
    3338:	1a458593          	add	a1,a1,420 # 74d8 <malloc+0x175a>
    333c:	00004517          	auipc	a0,0x4
    3340:	10c50513          	add	a0,a0,268 # 7448 <malloc+0x16ca>
    3344:	00002097          	auipc	ra,0x2
    3348:	3e2080e7          	jalr	994(ra) # 5726 <link>
    334c:	3a050063          	beqz	a0,36ec <subdir+0x63e>
  if(link("dd/ff", "dd/dd/ffff") == 0){
    3350:	00004597          	auipc	a1,0x4
    3354:	f4058593          	add	a1,a1,-192 # 7290 <malloc+0x1512>
    3358:	00004517          	auipc	a0,0x4
    335c:	e3050513          	add	a0,a0,-464 # 7188 <malloc+0x140a>
    3360:	00002097          	auipc	ra,0x2
    3364:	3c6080e7          	jalr	966(ra) # 5726 <link>
    3368:	3a050063          	beqz	a0,3708 <subdir+0x65a>
  if(mkdir("dd/ff/ff") == 0){
    336c:	00004517          	auipc	a0,0x4
    3370:	0ac50513          	add	a0,a0,172 # 7418 <malloc+0x169a>
    3374:	00002097          	auipc	ra,0x2
    3378:	3ba080e7          	jalr	954(ra) # 572e <mkdir>
    337c:	3a050463          	beqz	a0,3724 <subdir+0x676>
  if(mkdir("dd/xx/ff") == 0){
    3380:	00004517          	auipc	a0,0x4
    3384:	0c850513          	add	a0,a0,200 # 7448 <malloc+0x16ca>
    3388:	00002097          	auipc	ra,0x2
    338c:	3a6080e7          	jalr	934(ra) # 572e <mkdir>
    3390:	3a050863          	beqz	a0,3740 <subdir+0x692>
  if(mkdir("dd/dd/ffff") == 0){
    3394:	00004517          	auipc	a0,0x4
    3398:	efc50513          	add	a0,a0,-260 # 7290 <malloc+0x1512>
    339c:	00002097          	auipc	ra,0x2
    33a0:	392080e7          	jalr	914(ra) # 572e <mkdir>
    33a4:	3a050c63          	beqz	a0,375c <subdir+0x6ae>
  if(unlink("dd/xx/ff") == 0){
    33a8:	00004517          	auipc	a0,0x4
    33ac:	0a050513          	add	a0,a0,160 # 7448 <malloc+0x16ca>
    33b0:	00002097          	auipc	ra,0x2
    33b4:	366080e7          	jalr	870(ra) # 5716 <unlink>
    33b8:	3c050063          	beqz	a0,3778 <subdir+0x6ca>
  if(unlink("dd/ff/ff") == 0){
    33bc:	00004517          	auipc	a0,0x4
    33c0:	05c50513          	add	a0,a0,92 # 7418 <malloc+0x169a>
    33c4:	00002097          	auipc	ra,0x2
    33c8:	352080e7          	jalr	850(ra) # 5716 <unlink>
    33cc:	3c050463          	beqz	a0,3794 <subdir+0x6e6>
  if(chdir("dd/ff") == 0){
    33d0:	00004517          	auipc	a0,0x4
    33d4:	db850513          	add	a0,a0,-584 # 7188 <malloc+0x140a>
    33d8:	00002097          	auipc	ra,0x2
    33dc:	35e080e7          	jalr	862(ra) # 5736 <chdir>
    33e0:	3c050863          	beqz	a0,37b0 <subdir+0x702>
  if(chdir("dd/xx") == 0){
    33e4:	00004517          	auipc	a0,0x4
    33e8:	24450513          	add	a0,a0,580 # 7628 <malloc+0x18aa>
    33ec:	00002097          	auipc	ra,0x2
    33f0:	34a080e7          	jalr	842(ra) # 5736 <chdir>
    33f4:	3c050c63          	beqz	a0,37cc <subdir+0x71e>
  if(unlink("dd/dd/ffff") != 0){
    33f8:	00004517          	auipc	a0,0x4
    33fc:	e9850513          	add	a0,a0,-360 # 7290 <malloc+0x1512>
    3400:	00002097          	auipc	ra,0x2
    3404:	316080e7          	jalr	790(ra) # 5716 <unlink>
    3408:	3e051063          	bnez	a0,37e8 <subdir+0x73a>
  if(unlink("dd/ff") != 0){
    340c:	00004517          	auipc	a0,0x4
    3410:	d7c50513          	add	a0,a0,-644 # 7188 <malloc+0x140a>
    3414:	00002097          	auipc	ra,0x2
    3418:	302080e7          	jalr	770(ra) # 5716 <unlink>
    341c:	3e051463          	bnez	a0,3804 <subdir+0x756>
  if(unlink("dd") == 0){
    3420:	00004517          	auipc	a0,0x4
    3424:	d4850513          	add	a0,a0,-696 # 7168 <malloc+0x13ea>
    3428:	00002097          	auipc	ra,0x2
    342c:	2ee080e7          	jalr	750(ra) # 5716 <unlink>
    3430:	3e050863          	beqz	a0,3820 <subdir+0x772>
  if(unlink("dd/dd") < 0){
    3434:	00004517          	auipc	a0,0x4
    3438:	26450513          	add	a0,a0,612 # 7698 <malloc+0x191a>
    343c:	00002097          	auipc	ra,0x2
    3440:	2da080e7          	jalr	730(ra) # 5716 <unlink>
    3444:	3e054c63          	bltz	a0,383c <subdir+0x78e>
  if(unlink("dd") < 0){
    3448:	00004517          	auipc	a0,0x4
    344c:	d2050513          	add	a0,a0,-736 # 7168 <malloc+0x13ea>
    3450:	00002097          	auipc	ra,0x2
    3454:	2c6080e7          	jalr	710(ra) # 5716 <unlink>
    3458:	40054063          	bltz	a0,3858 <subdir+0x7aa>
}
    345c:	60e2                	ld	ra,24(sp)
    345e:	6442                	ld	s0,16(sp)
    3460:	64a2                	ld	s1,8(sp)
    3462:	6902                	ld	s2,0(sp)
    3464:	6105                	add	sp,sp,32
    3466:	8082                	ret
    printf("%s: mkdir dd failed\n", s);
    3468:	85ca                	mv	a1,s2
    346a:	00004517          	auipc	a0,0x4
    346e:	d0650513          	add	a0,a0,-762 # 7170 <malloc+0x13f2>
    3472:	00002097          	auipc	ra,0x2
    3476:	68c080e7          	jalr	1676(ra) # 5afe <printf>
    exit(1);
    347a:	4505                	li	a0,1
    347c:	00002097          	auipc	ra,0x2
    3480:	24a080e7          	jalr	586(ra) # 56c6 <exit>
    printf("%s: create dd/ff failed\n", s);
    3484:	85ca                	mv	a1,s2
    3486:	00004517          	auipc	a0,0x4
    348a:	d0a50513          	add	a0,a0,-758 # 7190 <malloc+0x1412>
    348e:	00002097          	auipc	ra,0x2
    3492:	670080e7          	jalr	1648(ra) # 5afe <printf>
    exit(1);
    3496:	4505                	li	a0,1
    3498:	00002097          	auipc	ra,0x2
    349c:	22e080e7          	jalr	558(ra) # 56c6 <exit>
    printf("%s: unlink dd (non-empty dir) succeeded!\n", s);
    34a0:	85ca                	mv	a1,s2
    34a2:	00004517          	auipc	a0,0x4
    34a6:	d0e50513          	add	a0,a0,-754 # 71b0 <malloc+0x1432>
    34aa:	00002097          	auipc	ra,0x2
    34ae:	654080e7          	jalr	1620(ra) # 5afe <printf>
    exit(1);
    34b2:	4505                	li	a0,1
    34b4:	00002097          	auipc	ra,0x2
    34b8:	212080e7          	jalr	530(ra) # 56c6 <exit>
    printf("subdir mkdir dd/dd failed\n", s);
    34bc:	85ca                	mv	a1,s2
    34be:	00004517          	auipc	a0,0x4
    34c2:	d2a50513          	add	a0,a0,-726 # 71e8 <malloc+0x146a>
    34c6:	00002097          	auipc	ra,0x2
    34ca:	638080e7          	jalr	1592(ra) # 5afe <printf>
    exit(1);
    34ce:	4505                	li	a0,1
    34d0:	00002097          	auipc	ra,0x2
    34d4:	1f6080e7          	jalr	502(ra) # 56c6 <exit>
    printf("%s: create dd/dd/ff failed\n", s);
    34d8:	85ca                	mv	a1,s2
    34da:	00004517          	auipc	a0,0x4
    34de:	d3e50513          	add	a0,a0,-706 # 7218 <malloc+0x149a>
    34e2:	00002097          	auipc	ra,0x2
    34e6:	61c080e7          	jalr	1564(ra) # 5afe <printf>
    exit(1);
    34ea:	4505                	li	a0,1
    34ec:	00002097          	auipc	ra,0x2
    34f0:	1da080e7          	jalr	474(ra) # 56c6 <exit>
    printf("%s: open dd/dd/../ff failed\n", s);
    34f4:	85ca                	mv	a1,s2
    34f6:	00004517          	auipc	a0,0x4
    34fa:	d5a50513          	add	a0,a0,-678 # 7250 <malloc+0x14d2>
    34fe:	00002097          	auipc	ra,0x2
    3502:	600080e7          	jalr	1536(ra) # 5afe <printf>
    exit(1);
    3506:	4505                	li	a0,1
    3508:	00002097          	auipc	ra,0x2
    350c:	1be080e7          	jalr	446(ra) # 56c6 <exit>
    printf("%s: dd/dd/../ff wrong content\n", s);
    3510:	85ca                	mv	a1,s2
    3512:	00004517          	auipc	a0,0x4
    3516:	d5e50513          	add	a0,a0,-674 # 7270 <malloc+0x14f2>
    351a:	00002097          	auipc	ra,0x2
    351e:	5e4080e7          	jalr	1508(ra) # 5afe <printf>
    exit(1);
    3522:	4505                	li	a0,1
    3524:	00002097          	auipc	ra,0x2
    3528:	1a2080e7          	jalr	418(ra) # 56c6 <exit>
    printf("link dd/dd/ff dd/dd/ffff failed\n", s);
    352c:	85ca                	mv	a1,s2
    352e:	00004517          	auipc	a0,0x4
    3532:	d7250513          	add	a0,a0,-654 # 72a0 <malloc+0x1522>
    3536:	00002097          	auipc	ra,0x2
    353a:	5c8080e7          	jalr	1480(ra) # 5afe <printf>
    exit(1);
    353e:	4505                	li	a0,1
    3540:	00002097          	auipc	ra,0x2
    3544:	186080e7          	jalr	390(ra) # 56c6 <exit>
    printf("%s: unlink dd/dd/ff failed\n", s);
    3548:	85ca                	mv	a1,s2
    354a:	00004517          	auipc	a0,0x4
    354e:	d7e50513          	add	a0,a0,-642 # 72c8 <malloc+0x154a>
    3552:	00002097          	auipc	ra,0x2
    3556:	5ac080e7          	jalr	1452(ra) # 5afe <printf>
    exit(1);
    355a:	4505                	li	a0,1
    355c:	00002097          	auipc	ra,0x2
    3560:	16a080e7          	jalr	362(ra) # 56c6 <exit>
    printf("%s: open (unlinked) dd/dd/ff succeeded\n", s);
    3564:	85ca                	mv	a1,s2
    3566:	00004517          	auipc	a0,0x4
    356a:	d8250513          	add	a0,a0,-638 # 72e8 <malloc+0x156a>
    356e:	00002097          	auipc	ra,0x2
    3572:	590080e7          	jalr	1424(ra) # 5afe <printf>
    exit(1);
    3576:	4505                	li	a0,1
    3578:	00002097          	auipc	ra,0x2
    357c:	14e080e7          	jalr	334(ra) # 56c6 <exit>
    printf("%s: chdir dd failed\n", s);
    3580:	85ca                	mv	a1,s2
    3582:	00004517          	auipc	a0,0x4
    3586:	d8e50513          	add	a0,a0,-626 # 7310 <malloc+0x1592>
    358a:	00002097          	auipc	ra,0x2
    358e:	574080e7          	jalr	1396(ra) # 5afe <printf>
    exit(1);
    3592:	4505                	li	a0,1
    3594:	00002097          	auipc	ra,0x2
    3598:	132080e7          	jalr	306(ra) # 56c6 <exit>
    printf("%s: chdir dd/../../dd failed\n", s);
    359c:	85ca                	mv	a1,s2
    359e:	00004517          	auipc	a0,0x4
    35a2:	d9a50513          	add	a0,a0,-614 # 7338 <malloc+0x15ba>
    35a6:	00002097          	auipc	ra,0x2
    35aa:	558080e7          	jalr	1368(ra) # 5afe <printf>
    exit(1);
    35ae:	4505                	li	a0,1
    35b0:	00002097          	auipc	ra,0x2
    35b4:	116080e7          	jalr	278(ra) # 56c6 <exit>
    printf("chdir dd/../../dd failed\n", s);
    35b8:	85ca                	mv	a1,s2
    35ba:	00004517          	auipc	a0,0x4
    35be:	dae50513          	add	a0,a0,-594 # 7368 <malloc+0x15ea>
    35c2:	00002097          	auipc	ra,0x2
    35c6:	53c080e7          	jalr	1340(ra) # 5afe <printf>
    exit(1);
    35ca:	4505                	li	a0,1
    35cc:	00002097          	auipc	ra,0x2
    35d0:	0fa080e7          	jalr	250(ra) # 56c6 <exit>
    printf("%s: chdir ./.. failed\n", s);
    35d4:	85ca                	mv	a1,s2
    35d6:	00004517          	auipc	a0,0x4
    35da:	dba50513          	add	a0,a0,-582 # 7390 <malloc+0x1612>
    35de:	00002097          	auipc	ra,0x2
    35e2:	520080e7          	jalr	1312(ra) # 5afe <printf>
    exit(1);
    35e6:	4505                	li	a0,1
    35e8:	00002097          	auipc	ra,0x2
    35ec:	0de080e7          	jalr	222(ra) # 56c6 <exit>
    printf("%s: open dd/dd/ffff failed\n", s);
    35f0:	85ca                	mv	a1,s2
    35f2:	00004517          	auipc	a0,0x4
    35f6:	db650513          	add	a0,a0,-586 # 73a8 <malloc+0x162a>
    35fa:	00002097          	auipc	ra,0x2
    35fe:	504080e7          	jalr	1284(ra) # 5afe <printf>
    exit(1);
    3602:	4505                	li	a0,1
    3604:	00002097          	auipc	ra,0x2
    3608:	0c2080e7          	jalr	194(ra) # 56c6 <exit>
    printf("%s: read dd/dd/ffff wrong len\n", s);
    360c:	85ca                	mv	a1,s2
    360e:	00004517          	auipc	a0,0x4
    3612:	dba50513          	add	a0,a0,-582 # 73c8 <malloc+0x164a>
    3616:	00002097          	auipc	ra,0x2
    361a:	4e8080e7          	jalr	1256(ra) # 5afe <printf>
    exit(1);
    361e:	4505                	li	a0,1
    3620:	00002097          	auipc	ra,0x2
    3624:	0a6080e7          	jalr	166(ra) # 56c6 <exit>
    printf("%s: open (unlinked) dd/dd/ff succeeded!\n", s);
    3628:	85ca                	mv	a1,s2
    362a:	00004517          	auipc	a0,0x4
    362e:	dbe50513          	add	a0,a0,-578 # 73e8 <malloc+0x166a>
    3632:	00002097          	auipc	ra,0x2
    3636:	4cc080e7          	jalr	1228(ra) # 5afe <printf>
    exit(1);
    363a:	4505                	li	a0,1
    363c:	00002097          	auipc	ra,0x2
    3640:	08a080e7          	jalr	138(ra) # 56c6 <exit>
    printf("%s: create dd/ff/ff succeeded!\n", s);
    3644:	85ca                	mv	a1,s2
    3646:	00004517          	auipc	a0,0x4
    364a:	de250513          	add	a0,a0,-542 # 7428 <malloc+0x16aa>
    364e:	00002097          	auipc	ra,0x2
    3652:	4b0080e7          	jalr	1200(ra) # 5afe <printf>
    exit(1);
    3656:	4505                	li	a0,1
    3658:	00002097          	auipc	ra,0x2
    365c:	06e080e7          	jalr	110(ra) # 56c6 <exit>
    printf("%s: create dd/xx/ff succeeded!\n", s);
    3660:	85ca                	mv	a1,s2
    3662:	00004517          	auipc	a0,0x4
    3666:	df650513          	add	a0,a0,-522 # 7458 <malloc+0x16da>
    366a:	00002097          	auipc	ra,0x2
    366e:	494080e7          	jalr	1172(ra) # 5afe <printf>
    exit(1);
    3672:	4505                	li	a0,1
    3674:	00002097          	auipc	ra,0x2
    3678:	052080e7          	jalr	82(ra) # 56c6 <exit>
    printf("%s: create dd succeeded!\n", s);
    367c:	85ca                	mv	a1,s2
    367e:	00004517          	auipc	a0,0x4
    3682:	dfa50513          	add	a0,a0,-518 # 7478 <malloc+0x16fa>
    3686:	00002097          	auipc	ra,0x2
    368a:	478080e7          	jalr	1144(ra) # 5afe <printf>
    exit(1);
    368e:	4505                	li	a0,1
    3690:	00002097          	auipc	ra,0x2
    3694:	036080e7          	jalr	54(ra) # 56c6 <exit>
    printf("%s: open dd rdwr succeeded!\n", s);
    3698:	85ca                	mv	a1,s2
    369a:	00004517          	auipc	a0,0x4
    369e:	dfe50513          	add	a0,a0,-514 # 7498 <malloc+0x171a>
    36a2:	00002097          	auipc	ra,0x2
    36a6:	45c080e7          	jalr	1116(ra) # 5afe <printf>
    exit(1);
    36aa:	4505                	li	a0,1
    36ac:	00002097          	auipc	ra,0x2
    36b0:	01a080e7          	jalr	26(ra) # 56c6 <exit>
    printf("%s: open dd wronly succeeded!\n", s);
    36b4:	85ca                	mv	a1,s2
    36b6:	00004517          	auipc	a0,0x4
    36ba:	e0250513          	add	a0,a0,-510 # 74b8 <malloc+0x173a>
    36be:	00002097          	auipc	ra,0x2
    36c2:	440080e7          	jalr	1088(ra) # 5afe <printf>
    exit(1);
    36c6:	4505                	li	a0,1
    36c8:	00002097          	auipc	ra,0x2
    36cc:	ffe080e7          	jalr	-2(ra) # 56c6 <exit>
    printf("%s: link dd/ff/ff dd/dd/xx succeeded!\n", s);
    36d0:	85ca                	mv	a1,s2
    36d2:	00004517          	auipc	a0,0x4
    36d6:	e1650513          	add	a0,a0,-490 # 74e8 <malloc+0x176a>
    36da:	00002097          	auipc	ra,0x2
    36de:	424080e7          	jalr	1060(ra) # 5afe <printf>
    exit(1);
    36e2:	4505                	li	a0,1
    36e4:	00002097          	auipc	ra,0x2
    36e8:	fe2080e7          	jalr	-30(ra) # 56c6 <exit>
    printf("%s: link dd/xx/ff dd/dd/xx succeeded!\n", s);
    36ec:	85ca                	mv	a1,s2
    36ee:	00004517          	auipc	a0,0x4
    36f2:	e2250513          	add	a0,a0,-478 # 7510 <malloc+0x1792>
    36f6:	00002097          	auipc	ra,0x2
    36fa:	408080e7          	jalr	1032(ra) # 5afe <printf>
    exit(1);
    36fe:	4505                	li	a0,1
    3700:	00002097          	auipc	ra,0x2
    3704:	fc6080e7          	jalr	-58(ra) # 56c6 <exit>
    printf("%s: link dd/ff dd/dd/ffff succeeded!\n", s);
    3708:	85ca                	mv	a1,s2
    370a:	00004517          	auipc	a0,0x4
    370e:	e2e50513          	add	a0,a0,-466 # 7538 <malloc+0x17ba>
    3712:	00002097          	auipc	ra,0x2
    3716:	3ec080e7          	jalr	1004(ra) # 5afe <printf>
    exit(1);
    371a:	4505                	li	a0,1
    371c:	00002097          	auipc	ra,0x2
    3720:	faa080e7          	jalr	-86(ra) # 56c6 <exit>
    printf("%s: mkdir dd/ff/ff succeeded!\n", s);
    3724:	85ca                	mv	a1,s2
    3726:	00004517          	auipc	a0,0x4
    372a:	e3a50513          	add	a0,a0,-454 # 7560 <malloc+0x17e2>
    372e:	00002097          	auipc	ra,0x2
    3732:	3d0080e7          	jalr	976(ra) # 5afe <printf>
    exit(1);
    3736:	4505                	li	a0,1
    3738:	00002097          	auipc	ra,0x2
    373c:	f8e080e7          	jalr	-114(ra) # 56c6 <exit>
    printf("%s: mkdir dd/xx/ff succeeded!\n", s);
    3740:	85ca                	mv	a1,s2
    3742:	00004517          	auipc	a0,0x4
    3746:	e3e50513          	add	a0,a0,-450 # 7580 <malloc+0x1802>
    374a:	00002097          	auipc	ra,0x2
    374e:	3b4080e7          	jalr	948(ra) # 5afe <printf>
    exit(1);
    3752:	4505                	li	a0,1
    3754:	00002097          	auipc	ra,0x2
    3758:	f72080e7          	jalr	-142(ra) # 56c6 <exit>
    printf("%s: mkdir dd/dd/ffff succeeded!\n", s);
    375c:	85ca                	mv	a1,s2
    375e:	00004517          	auipc	a0,0x4
    3762:	e4250513          	add	a0,a0,-446 # 75a0 <malloc+0x1822>
    3766:	00002097          	auipc	ra,0x2
    376a:	398080e7          	jalr	920(ra) # 5afe <printf>
    exit(1);
    376e:	4505                	li	a0,1
    3770:	00002097          	auipc	ra,0x2
    3774:	f56080e7          	jalr	-170(ra) # 56c6 <exit>
    printf("%s: unlink dd/xx/ff succeeded!\n", s);
    3778:	85ca                	mv	a1,s2
    377a:	00004517          	auipc	a0,0x4
    377e:	e4e50513          	add	a0,a0,-434 # 75c8 <malloc+0x184a>
    3782:	00002097          	auipc	ra,0x2
    3786:	37c080e7          	jalr	892(ra) # 5afe <printf>
    exit(1);
    378a:	4505                	li	a0,1
    378c:	00002097          	auipc	ra,0x2
    3790:	f3a080e7          	jalr	-198(ra) # 56c6 <exit>
    printf("%s: unlink dd/ff/ff succeeded!\n", s);
    3794:	85ca                	mv	a1,s2
    3796:	00004517          	auipc	a0,0x4
    379a:	e5250513          	add	a0,a0,-430 # 75e8 <malloc+0x186a>
    379e:	00002097          	auipc	ra,0x2
    37a2:	360080e7          	jalr	864(ra) # 5afe <printf>
    exit(1);
    37a6:	4505                	li	a0,1
    37a8:	00002097          	auipc	ra,0x2
    37ac:	f1e080e7          	jalr	-226(ra) # 56c6 <exit>
    printf("%s: chdir dd/ff succeeded!\n", s);
    37b0:	85ca                	mv	a1,s2
    37b2:	00004517          	auipc	a0,0x4
    37b6:	e5650513          	add	a0,a0,-426 # 7608 <malloc+0x188a>
    37ba:	00002097          	auipc	ra,0x2
    37be:	344080e7          	jalr	836(ra) # 5afe <printf>
    exit(1);
    37c2:	4505                	li	a0,1
    37c4:	00002097          	auipc	ra,0x2
    37c8:	f02080e7          	jalr	-254(ra) # 56c6 <exit>
    printf("%s: chdir dd/xx succeeded!\n", s);
    37cc:	85ca                	mv	a1,s2
    37ce:	00004517          	auipc	a0,0x4
    37d2:	e6250513          	add	a0,a0,-414 # 7630 <malloc+0x18b2>
    37d6:	00002097          	auipc	ra,0x2
    37da:	328080e7          	jalr	808(ra) # 5afe <printf>
    exit(1);
    37de:	4505                	li	a0,1
    37e0:	00002097          	auipc	ra,0x2
    37e4:	ee6080e7          	jalr	-282(ra) # 56c6 <exit>
    printf("%s: unlink dd/dd/ff failed\n", s);
    37e8:	85ca                	mv	a1,s2
    37ea:	00004517          	auipc	a0,0x4
    37ee:	ade50513          	add	a0,a0,-1314 # 72c8 <malloc+0x154a>
    37f2:	00002097          	auipc	ra,0x2
    37f6:	30c080e7          	jalr	780(ra) # 5afe <printf>
    exit(1);
    37fa:	4505                	li	a0,1
    37fc:	00002097          	auipc	ra,0x2
    3800:	eca080e7          	jalr	-310(ra) # 56c6 <exit>
    printf("%s: unlink dd/ff failed\n", s);
    3804:	85ca                	mv	a1,s2
    3806:	00004517          	auipc	a0,0x4
    380a:	e4a50513          	add	a0,a0,-438 # 7650 <malloc+0x18d2>
    380e:	00002097          	auipc	ra,0x2
    3812:	2f0080e7          	jalr	752(ra) # 5afe <printf>
    exit(1);
    3816:	4505                	li	a0,1
    3818:	00002097          	auipc	ra,0x2
    381c:	eae080e7          	jalr	-338(ra) # 56c6 <exit>
    printf("%s: unlink non-empty dd succeeded!\n", s);
    3820:	85ca                	mv	a1,s2
    3822:	00004517          	auipc	a0,0x4
    3826:	e4e50513          	add	a0,a0,-434 # 7670 <malloc+0x18f2>
    382a:	00002097          	auipc	ra,0x2
    382e:	2d4080e7          	jalr	724(ra) # 5afe <printf>
    exit(1);
    3832:	4505                	li	a0,1
    3834:	00002097          	auipc	ra,0x2
    3838:	e92080e7          	jalr	-366(ra) # 56c6 <exit>
    printf("%s: unlink dd/dd failed\n", s);
    383c:	85ca                	mv	a1,s2
    383e:	00004517          	auipc	a0,0x4
    3842:	e6250513          	add	a0,a0,-414 # 76a0 <malloc+0x1922>
    3846:	00002097          	auipc	ra,0x2
    384a:	2b8080e7          	jalr	696(ra) # 5afe <printf>
    exit(1);
    384e:	4505                	li	a0,1
    3850:	00002097          	auipc	ra,0x2
    3854:	e76080e7          	jalr	-394(ra) # 56c6 <exit>
    printf("%s: unlink dd failed\n", s);
    3858:	85ca                	mv	a1,s2
    385a:	00004517          	auipc	a0,0x4
    385e:	e6650513          	add	a0,a0,-410 # 76c0 <malloc+0x1942>
    3862:	00002097          	auipc	ra,0x2
    3866:	29c080e7          	jalr	668(ra) # 5afe <printf>
    exit(1);
    386a:	4505                	li	a0,1
    386c:	00002097          	auipc	ra,0x2
    3870:	e5a080e7          	jalr	-422(ra) # 56c6 <exit>

0000000000003874 <rmdot>:
{
    3874:	1101                	add	sp,sp,-32
    3876:	ec06                	sd	ra,24(sp)
    3878:	e822                	sd	s0,16(sp)
    387a:	e426                	sd	s1,8(sp)
    387c:	1000                	add	s0,sp,32
    387e:	84aa                	mv	s1,a0
  if(mkdir("dots") != 0){
    3880:	00004517          	auipc	a0,0x4
    3884:	e5850513          	add	a0,a0,-424 # 76d8 <malloc+0x195a>
    3888:	00002097          	auipc	ra,0x2
    388c:	ea6080e7          	jalr	-346(ra) # 572e <mkdir>
    3890:	e549                	bnez	a0,391a <rmdot+0xa6>
  if(chdir("dots") != 0){
    3892:	00004517          	auipc	a0,0x4
    3896:	e4650513          	add	a0,a0,-442 # 76d8 <malloc+0x195a>
    389a:	00002097          	auipc	ra,0x2
    389e:	e9c080e7          	jalr	-356(ra) # 5736 <chdir>
    38a2:	e951                	bnez	a0,3936 <rmdot+0xc2>
  if(unlink(".") == 0){
    38a4:	00003517          	auipc	a0,0x3
    38a8:	cdc50513          	add	a0,a0,-804 # 6580 <malloc+0x802>
    38ac:	00002097          	auipc	ra,0x2
    38b0:	e6a080e7          	jalr	-406(ra) # 5716 <unlink>
    38b4:	cd59                	beqz	a0,3952 <rmdot+0xde>
  if(unlink("..") == 0){
    38b6:	00004517          	auipc	a0,0x4
    38ba:	87a50513          	add	a0,a0,-1926 # 7130 <malloc+0x13b2>
    38be:	00002097          	auipc	ra,0x2
    38c2:	e58080e7          	jalr	-424(ra) # 5716 <unlink>
    38c6:	c545                	beqz	a0,396e <rmdot+0xfa>
  if(chdir("/") != 0){
    38c8:	00004517          	auipc	a0,0x4
    38cc:	81050513          	add	a0,a0,-2032 # 70d8 <malloc+0x135a>
    38d0:	00002097          	auipc	ra,0x2
    38d4:	e66080e7          	jalr	-410(ra) # 5736 <chdir>
    38d8:	e94d                	bnez	a0,398a <rmdot+0x116>
  if(unlink("dots/.") == 0){
    38da:	00004517          	auipc	a0,0x4
    38de:	e6650513          	add	a0,a0,-410 # 7740 <malloc+0x19c2>
    38e2:	00002097          	auipc	ra,0x2
    38e6:	e34080e7          	jalr	-460(ra) # 5716 <unlink>
    38ea:	cd55                	beqz	a0,39a6 <rmdot+0x132>
  if(unlink("dots/..") == 0){
    38ec:	00004517          	auipc	a0,0x4
    38f0:	e7c50513          	add	a0,a0,-388 # 7768 <malloc+0x19ea>
    38f4:	00002097          	auipc	ra,0x2
    38f8:	e22080e7          	jalr	-478(ra) # 5716 <unlink>
    38fc:	c179                	beqz	a0,39c2 <rmdot+0x14e>
  if(unlink("dots") != 0){
    38fe:	00004517          	auipc	a0,0x4
    3902:	dda50513          	add	a0,a0,-550 # 76d8 <malloc+0x195a>
    3906:	00002097          	auipc	ra,0x2
    390a:	e10080e7          	jalr	-496(ra) # 5716 <unlink>
    390e:	e961                	bnez	a0,39de <rmdot+0x16a>
}
    3910:	60e2                	ld	ra,24(sp)
    3912:	6442                	ld	s0,16(sp)
    3914:	64a2                	ld	s1,8(sp)
    3916:	6105                	add	sp,sp,32
    3918:	8082                	ret
    printf("%s: mkdir dots failed\n", s);
    391a:	85a6                	mv	a1,s1
    391c:	00004517          	auipc	a0,0x4
    3920:	dc450513          	add	a0,a0,-572 # 76e0 <malloc+0x1962>
    3924:	00002097          	auipc	ra,0x2
    3928:	1da080e7          	jalr	474(ra) # 5afe <printf>
    exit(1);
    392c:	4505                	li	a0,1
    392e:	00002097          	auipc	ra,0x2
    3932:	d98080e7          	jalr	-616(ra) # 56c6 <exit>
    printf("%s: chdir dots failed\n", s);
    3936:	85a6                	mv	a1,s1
    3938:	00004517          	auipc	a0,0x4
    393c:	dc050513          	add	a0,a0,-576 # 76f8 <malloc+0x197a>
    3940:	00002097          	auipc	ra,0x2
    3944:	1be080e7          	jalr	446(ra) # 5afe <printf>
    exit(1);
    3948:	4505                	li	a0,1
    394a:	00002097          	auipc	ra,0x2
    394e:	d7c080e7          	jalr	-644(ra) # 56c6 <exit>
    printf("%s: rm . worked!\n", s);
    3952:	85a6                	mv	a1,s1
    3954:	00004517          	auipc	a0,0x4
    3958:	dbc50513          	add	a0,a0,-580 # 7710 <malloc+0x1992>
    395c:	00002097          	auipc	ra,0x2
    3960:	1a2080e7          	jalr	418(ra) # 5afe <printf>
    exit(1);
    3964:	4505                	li	a0,1
    3966:	00002097          	auipc	ra,0x2
    396a:	d60080e7          	jalr	-672(ra) # 56c6 <exit>
    printf("%s: rm .. worked!\n", s);
    396e:	85a6                	mv	a1,s1
    3970:	00004517          	auipc	a0,0x4
    3974:	db850513          	add	a0,a0,-584 # 7728 <malloc+0x19aa>
    3978:	00002097          	auipc	ra,0x2
    397c:	186080e7          	jalr	390(ra) # 5afe <printf>
    exit(1);
    3980:	4505                	li	a0,1
    3982:	00002097          	auipc	ra,0x2
    3986:	d44080e7          	jalr	-700(ra) # 56c6 <exit>
    printf("%s: chdir / failed\n", s);
    398a:	85a6                	mv	a1,s1
    398c:	00003517          	auipc	a0,0x3
    3990:	75450513          	add	a0,a0,1876 # 70e0 <malloc+0x1362>
    3994:	00002097          	auipc	ra,0x2
    3998:	16a080e7          	jalr	362(ra) # 5afe <printf>
    exit(1);
    399c:	4505                	li	a0,1
    399e:	00002097          	auipc	ra,0x2
    39a2:	d28080e7          	jalr	-728(ra) # 56c6 <exit>
    printf("%s: unlink dots/. worked!\n", s);
    39a6:	85a6                	mv	a1,s1
    39a8:	00004517          	auipc	a0,0x4
    39ac:	da050513          	add	a0,a0,-608 # 7748 <malloc+0x19ca>
    39b0:	00002097          	auipc	ra,0x2
    39b4:	14e080e7          	jalr	334(ra) # 5afe <printf>
    exit(1);
    39b8:	4505                	li	a0,1
    39ba:	00002097          	auipc	ra,0x2
    39be:	d0c080e7          	jalr	-756(ra) # 56c6 <exit>
    printf("%s: unlink dots/.. worked!\n", s);
    39c2:	85a6                	mv	a1,s1
    39c4:	00004517          	auipc	a0,0x4
    39c8:	dac50513          	add	a0,a0,-596 # 7770 <malloc+0x19f2>
    39cc:	00002097          	auipc	ra,0x2
    39d0:	132080e7          	jalr	306(ra) # 5afe <printf>
    exit(1);
    39d4:	4505                	li	a0,1
    39d6:	00002097          	auipc	ra,0x2
    39da:	cf0080e7          	jalr	-784(ra) # 56c6 <exit>
    printf("%s: unlink dots failed!\n", s);
    39de:	85a6                	mv	a1,s1
    39e0:	00004517          	auipc	a0,0x4
    39e4:	db050513          	add	a0,a0,-592 # 7790 <malloc+0x1a12>
    39e8:	00002097          	auipc	ra,0x2
    39ec:	116080e7          	jalr	278(ra) # 5afe <printf>
    exit(1);
    39f0:	4505                	li	a0,1
    39f2:	00002097          	auipc	ra,0x2
    39f6:	cd4080e7          	jalr	-812(ra) # 56c6 <exit>

00000000000039fa <dirfile>:
{
    39fa:	1101                	add	sp,sp,-32
    39fc:	ec06                	sd	ra,24(sp)
    39fe:	e822                	sd	s0,16(sp)
    3a00:	e426                	sd	s1,8(sp)
    3a02:	e04a                	sd	s2,0(sp)
    3a04:	1000                	add	s0,sp,32
    3a06:	892a                	mv	s2,a0
  fd = open("dirfile", O_CREATE);
    3a08:	20000593          	li	a1,512
    3a0c:	00004517          	auipc	a0,0x4
    3a10:	da450513          	add	a0,a0,-604 # 77b0 <malloc+0x1a32>
    3a14:	00002097          	auipc	ra,0x2
    3a18:	cf2080e7          	jalr	-782(ra) # 5706 <open>
  if(fd < 0){
    3a1c:	0e054d63          	bltz	a0,3b16 <dirfile+0x11c>
  close(fd);
    3a20:	00002097          	auipc	ra,0x2
    3a24:	cce080e7          	jalr	-818(ra) # 56ee <close>
  if(chdir("dirfile") == 0){
    3a28:	00004517          	auipc	a0,0x4
    3a2c:	d8850513          	add	a0,a0,-632 # 77b0 <malloc+0x1a32>
    3a30:	00002097          	auipc	ra,0x2
    3a34:	d06080e7          	jalr	-762(ra) # 5736 <chdir>
    3a38:	cd6d                	beqz	a0,3b32 <dirfile+0x138>
  fd = open("dirfile/xx", 0);
    3a3a:	4581                	li	a1,0
    3a3c:	00004517          	auipc	a0,0x4
    3a40:	dbc50513          	add	a0,a0,-580 # 77f8 <malloc+0x1a7a>
    3a44:	00002097          	auipc	ra,0x2
    3a48:	cc2080e7          	jalr	-830(ra) # 5706 <open>
  if(fd >= 0){
    3a4c:	10055163          	bgez	a0,3b4e <dirfile+0x154>
  fd = open("dirfile/xx", O_CREATE);
    3a50:	20000593          	li	a1,512
    3a54:	00004517          	auipc	a0,0x4
    3a58:	da450513          	add	a0,a0,-604 # 77f8 <malloc+0x1a7a>
    3a5c:	00002097          	auipc	ra,0x2
    3a60:	caa080e7          	jalr	-854(ra) # 5706 <open>
  if(fd >= 0){
    3a64:	10055363          	bgez	a0,3b6a <dirfile+0x170>
  if(mkdir("dirfile/xx") == 0){
    3a68:	00004517          	auipc	a0,0x4
    3a6c:	d9050513          	add	a0,a0,-624 # 77f8 <malloc+0x1a7a>
    3a70:	00002097          	auipc	ra,0x2
    3a74:	cbe080e7          	jalr	-834(ra) # 572e <mkdir>
    3a78:	10050763          	beqz	a0,3b86 <dirfile+0x18c>
  if(unlink("dirfile/xx") == 0){
    3a7c:	00004517          	auipc	a0,0x4
    3a80:	d7c50513          	add	a0,a0,-644 # 77f8 <malloc+0x1a7a>
    3a84:	00002097          	auipc	ra,0x2
    3a88:	c92080e7          	jalr	-878(ra) # 5716 <unlink>
    3a8c:	10050b63          	beqz	a0,3ba2 <dirfile+0x1a8>
  if(link("XV6-README", "dirfile/xx") == 0){
    3a90:	00004597          	auipc	a1,0x4
    3a94:	d6858593          	add	a1,a1,-664 # 77f8 <malloc+0x1a7a>
    3a98:	00002517          	auipc	a0,0x2
    3a9c:	5c850513          	add	a0,a0,1480 # 6060 <malloc+0x2e2>
    3aa0:	00002097          	auipc	ra,0x2
    3aa4:	c86080e7          	jalr	-890(ra) # 5726 <link>
    3aa8:	10050b63          	beqz	a0,3bbe <dirfile+0x1c4>
  if(unlink("dirfile") != 0){
    3aac:	00004517          	auipc	a0,0x4
    3ab0:	d0450513          	add	a0,a0,-764 # 77b0 <malloc+0x1a32>
    3ab4:	00002097          	auipc	ra,0x2
    3ab8:	c62080e7          	jalr	-926(ra) # 5716 <unlink>
    3abc:	10051f63          	bnez	a0,3bda <dirfile+0x1e0>
  fd = open(".", O_RDWR);
    3ac0:	4589                	li	a1,2
    3ac2:	00003517          	auipc	a0,0x3
    3ac6:	abe50513          	add	a0,a0,-1346 # 6580 <malloc+0x802>
    3aca:	00002097          	auipc	ra,0x2
    3ace:	c3c080e7          	jalr	-964(ra) # 5706 <open>
  if(fd >= 0){
    3ad2:	12055263          	bgez	a0,3bf6 <dirfile+0x1fc>
  fd = open(".", 0);
    3ad6:	4581                	li	a1,0
    3ad8:	00003517          	auipc	a0,0x3
    3adc:	aa850513          	add	a0,a0,-1368 # 6580 <malloc+0x802>
    3ae0:	00002097          	auipc	ra,0x2
    3ae4:	c26080e7          	jalr	-986(ra) # 5706 <open>
    3ae8:	84aa                	mv	s1,a0
  if(write(fd, "x", 1) > 0){
    3aea:	4605                	li	a2,1
    3aec:	00002597          	auipc	a1,0x2
    3af0:	43c58593          	add	a1,a1,1084 # 5f28 <malloc+0x1aa>
    3af4:	00002097          	auipc	ra,0x2
    3af8:	bf2080e7          	jalr	-1038(ra) # 56e6 <write>
    3afc:	10a04b63          	bgtz	a0,3c12 <dirfile+0x218>
  close(fd);
    3b00:	8526                	mv	a0,s1
    3b02:	00002097          	auipc	ra,0x2
    3b06:	bec080e7          	jalr	-1044(ra) # 56ee <close>
}
    3b0a:	60e2                	ld	ra,24(sp)
    3b0c:	6442                	ld	s0,16(sp)
    3b0e:	64a2                	ld	s1,8(sp)
    3b10:	6902                	ld	s2,0(sp)
    3b12:	6105                	add	sp,sp,32
    3b14:	8082                	ret
    printf("%s: create dirfile failed\n", s);
    3b16:	85ca                	mv	a1,s2
    3b18:	00004517          	auipc	a0,0x4
    3b1c:	ca050513          	add	a0,a0,-864 # 77b8 <malloc+0x1a3a>
    3b20:	00002097          	auipc	ra,0x2
    3b24:	fde080e7          	jalr	-34(ra) # 5afe <printf>
    exit(1);
    3b28:	4505                	li	a0,1
    3b2a:	00002097          	auipc	ra,0x2
    3b2e:	b9c080e7          	jalr	-1124(ra) # 56c6 <exit>
    printf("%s: chdir dirfile succeeded!\n", s);
    3b32:	85ca                	mv	a1,s2
    3b34:	00004517          	auipc	a0,0x4
    3b38:	ca450513          	add	a0,a0,-860 # 77d8 <malloc+0x1a5a>
    3b3c:	00002097          	auipc	ra,0x2
    3b40:	fc2080e7          	jalr	-62(ra) # 5afe <printf>
    exit(1);
    3b44:	4505                	li	a0,1
    3b46:	00002097          	auipc	ra,0x2
    3b4a:	b80080e7          	jalr	-1152(ra) # 56c6 <exit>
    printf("%s: create dirfile/xx succeeded!\n", s);
    3b4e:	85ca                	mv	a1,s2
    3b50:	00004517          	auipc	a0,0x4
    3b54:	cb850513          	add	a0,a0,-840 # 7808 <malloc+0x1a8a>
    3b58:	00002097          	auipc	ra,0x2
    3b5c:	fa6080e7          	jalr	-90(ra) # 5afe <printf>
    exit(1);
    3b60:	4505                	li	a0,1
    3b62:	00002097          	auipc	ra,0x2
    3b66:	b64080e7          	jalr	-1180(ra) # 56c6 <exit>
    printf("%s: create dirfile/xx succeeded!\n", s);
    3b6a:	85ca                	mv	a1,s2
    3b6c:	00004517          	auipc	a0,0x4
    3b70:	c9c50513          	add	a0,a0,-868 # 7808 <malloc+0x1a8a>
    3b74:	00002097          	auipc	ra,0x2
    3b78:	f8a080e7          	jalr	-118(ra) # 5afe <printf>
    exit(1);
    3b7c:	4505                	li	a0,1
    3b7e:	00002097          	auipc	ra,0x2
    3b82:	b48080e7          	jalr	-1208(ra) # 56c6 <exit>
    printf("%s: mkdir dirfile/xx succeeded!\n", s);
    3b86:	85ca                	mv	a1,s2
    3b88:	00004517          	auipc	a0,0x4
    3b8c:	ca850513          	add	a0,a0,-856 # 7830 <malloc+0x1ab2>
    3b90:	00002097          	auipc	ra,0x2
    3b94:	f6e080e7          	jalr	-146(ra) # 5afe <printf>
    exit(1);
    3b98:	4505                	li	a0,1
    3b9a:	00002097          	auipc	ra,0x2
    3b9e:	b2c080e7          	jalr	-1236(ra) # 56c6 <exit>
    printf("%s: unlink dirfile/xx succeeded!\n", s);
    3ba2:	85ca                	mv	a1,s2
    3ba4:	00004517          	auipc	a0,0x4
    3ba8:	cb450513          	add	a0,a0,-844 # 7858 <malloc+0x1ada>
    3bac:	00002097          	auipc	ra,0x2
    3bb0:	f52080e7          	jalr	-174(ra) # 5afe <printf>
    exit(1);
    3bb4:	4505                	li	a0,1
    3bb6:	00002097          	auipc	ra,0x2
    3bba:	b10080e7          	jalr	-1264(ra) # 56c6 <exit>
    printf("%s: link to dirfile/xx succeeded!\n", s);
    3bbe:	85ca                	mv	a1,s2
    3bc0:	00004517          	auipc	a0,0x4
    3bc4:	cc050513          	add	a0,a0,-832 # 7880 <malloc+0x1b02>
    3bc8:	00002097          	auipc	ra,0x2
    3bcc:	f36080e7          	jalr	-202(ra) # 5afe <printf>
    exit(1);
    3bd0:	4505                	li	a0,1
    3bd2:	00002097          	auipc	ra,0x2
    3bd6:	af4080e7          	jalr	-1292(ra) # 56c6 <exit>
    printf("%s: unlink dirfile failed!\n", s);
    3bda:	85ca                	mv	a1,s2
    3bdc:	00004517          	auipc	a0,0x4
    3be0:	ccc50513          	add	a0,a0,-820 # 78a8 <malloc+0x1b2a>
    3be4:	00002097          	auipc	ra,0x2
    3be8:	f1a080e7          	jalr	-230(ra) # 5afe <printf>
    exit(1);
    3bec:	4505                	li	a0,1
    3bee:	00002097          	auipc	ra,0x2
    3bf2:	ad8080e7          	jalr	-1320(ra) # 56c6 <exit>
    printf("%s: open . for writing succeeded!\n", s);
    3bf6:	85ca                	mv	a1,s2
    3bf8:	00004517          	auipc	a0,0x4
    3bfc:	cd050513          	add	a0,a0,-816 # 78c8 <malloc+0x1b4a>
    3c00:	00002097          	auipc	ra,0x2
    3c04:	efe080e7          	jalr	-258(ra) # 5afe <printf>
    exit(1);
    3c08:	4505                	li	a0,1
    3c0a:	00002097          	auipc	ra,0x2
    3c0e:	abc080e7          	jalr	-1348(ra) # 56c6 <exit>
    printf("%s: write . succeeded!\n", s);
    3c12:	85ca                	mv	a1,s2
    3c14:	00004517          	auipc	a0,0x4
    3c18:	cdc50513          	add	a0,a0,-804 # 78f0 <malloc+0x1b72>
    3c1c:	00002097          	auipc	ra,0x2
    3c20:	ee2080e7          	jalr	-286(ra) # 5afe <printf>
    exit(1);
    3c24:	4505                	li	a0,1
    3c26:	00002097          	auipc	ra,0x2
    3c2a:	aa0080e7          	jalr	-1376(ra) # 56c6 <exit>

0000000000003c2e <iref>:
{
    3c2e:	7139                	add	sp,sp,-64
    3c30:	fc06                	sd	ra,56(sp)
    3c32:	f822                	sd	s0,48(sp)
    3c34:	f426                	sd	s1,40(sp)
    3c36:	f04a                	sd	s2,32(sp)
    3c38:	ec4e                	sd	s3,24(sp)
    3c3a:	e852                	sd	s4,16(sp)
    3c3c:	e456                	sd	s5,8(sp)
    3c3e:	e05a                	sd	s6,0(sp)
    3c40:	0080                	add	s0,sp,64
    3c42:	8b2a                	mv	s6,a0
    3c44:	03300913          	li	s2,51
    if(mkdir("irefd") != 0){
    3c48:	00004a17          	auipc	s4,0x4
    3c4c:	cc0a0a13          	add	s4,s4,-832 # 7908 <malloc+0x1b8a>
    mkdir("");
    3c50:	00003497          	auipc	s1,0x3
    3c54:	7c048493          	add	s1,s1,1984 # 7410 <malloc+0x1692>
    link("XV6-README", "");
    3c58:	00002a97          	auipc	s5,0x2
    3c5c:	408a8a93          	add	s5,s5,1032 # 6060 <malloc+0x2e2>
    fd = open("xx", O_CREATE);
    3c60:	00004997          	auipc	s3,0x4
    3c64:	ba098993          	add	s3,s3,-1120 # 7800 <malloc+0x1a82>
    3c68:	a891                	j	3cbc <iref+0x8e>
      printf("%s: mkdir irefd failed\n", s);
    3c6a:	85da                	mv	a1,s6
    3c6c:	00004517          	auipc	a0,0x4
    3c70:	ca450513          	add	a0,a0,-860 # 7910 <malloc+0x1b92>
    3c74:	00002097          	auipc	ra,0x2
    3c78:	e8a080e7          	jalr	-374(ra) # 5afe <printf>
      exit(1);
    3c7c:	4505                	li	a0,1
    3c7e:	00002097          	auipc	ra,0x2
    3c82:	a48080e7          	jalr	-1464(ra) # 56c6 <exit>
      printf("%s: chdir irefd failed\n", s);
    3c86:	85da                	mv	a1,s6
    3c88:	00004517          	auipc	a0,0x4
    3c8c:	ca050513          	add	a0,a0,-864 # 7928 <malloc+0x1baa>
    3c90:	00002097          	auipc	ra,0x2
    3c94:	e6e080e7          	jalr	-402(ra) # 5afe <printf>
      exit(1);
    3c98:	4505                	li	a0,1
    3c9a:	00002097          	auipc	ra,0x2
    3c9e:	a2c080e7          	jalr	-1492(ra) # 56c6 <exit>
      close(fd);
    3ca2:	00002097          	auipc	ra,0x2
    3ca6:	a4c080e7          	jalr	-1460(ra) # 56ee <close>
    3caa:	a889                	j	3cfc <iref+0xce>
    unlink("xx");
    3cac:	854e                	mv	a0,s3
    3cae:	00002097          	auipc	ra,0x2
    3cb2:	a68080e7          	jalr	-1432(ra) # 5716 <unlink>
  for(i = 0; i < NINODE + 1; i++){
    3cb6:	397d                	addw	s2,s2,-1
    3cb8:	06090063          	beqz	s2,3d18 <iref+0xea>
    if(mkdir("irefd") != 0){
    3cbc:	8552                	mv	a0,s4
    3cbe:	00002097          	auipc	ra,0x2
    3cc2:	a70080e7          	jalr	-1424(ra) # 572e <mkdir>
    3cc6:	f155                	bnez	a0,3c6a <iref+0x3c>
    if(chdir("irefd") != 0){
    3cc8:	8552                	mv	a0,s4
    3cca:	00002097          	auipc	ra,0x2
    3cce:	a6c080e7          	jalr	-1428(ra) # 5736 <chdir>
    3cd2:	f955                	bnez	a0,3c86 <iref+0x58>
    mkdir("");
    3cd4:	8526                	mv	a0,s1
    3cd6:	00002097          	auipc	ra,0x2
    3cda:	a58080e7          	jalr	-1448(ra) # 572e <mkdir>
    link("XV6-README", "");
    3cde:	85a6                	mv	a1,s1
    3ce0:	8556                	mv	a0,s5
    3ce2:	00002097          	auipc	ra,0x2
    3ce6:	a44080e7          	jalr	-1468(ra) # 5726 <link>
    fd = open("", O_CREATE);
    3cea:	20000593          	li	a1,512
    3cee:	8526                	mv	a0,s1
    3cf0:	00002097          	auipc	ra,0x2
    3cf4:	a16080e7          	jalr	-1514(ra) # 5706 <open>
    if(fd >= 0)
    3cf8:	fa0555e3          	bgez	a0,3ca2 <iref+0x74>
    fd = open("xx", O_CREATE);
    3cfc:	20000593          	li	a1,512
    3d00:	854e                	mv	a0,s3
    3d02:	00002097          	auipc	ra,0x2
    3d06:	a04080e7          	jalr	-1532(ra) # 5706 <open>
    if(fd >= 0)
    3d0a:	fa0541e3          	bltz	a0,3cac <iref+0x7e>
      close(fd);
    3d0e:	00002097          	auipc	ra,0x2
    3d12:	9e0080e7          	jalr	-1568(ra) # 56ee <close>
    3d16:	bf59                	j	3cac <iref+0x7e>
    3d18:	03300493          	li	s1,51
    chdir("..");
    3d1c:	00003997          	auipc	s3,0x3
    3d20:	41498993          	add	s3,s3,1044 # 7130 <malloc+0x13b2>
    unlink("irefd");
    3d24:	00004917          	auipc	s2,0x4
    3d28:	be490913          	add	s2,s2,-1052 # 7908 <malloc+0x1b8a>
    chdir("..");
    3d2c:	854e                	mv	a0,s3
    3d2e:	00002097          	auipc	ra,0x2
    3d32:	a08080e7          	jalr	-1528(ra) # 5736 <chdir>
    unlink("irefd");
    3d36:	854a                	mv	a0,s2
    3d38:	00002097          	auipc	ra,0x2
    3d3c:	9de080e7          	jalr	-1570(ra) # 5716 <unlink>
  for(i = 0; i < NINODE + 1; i++){
    3d40:	34fd                	addw	s1,s1,-1
    3d42:	f4ed                	bnez	s1,3d2c <iref+0xfe>
  chdir("/");
    3d44:	00003517          	auipc	a0,0x3
    3d48:	39450513          	add	a0,a0,916 # 70d8 <malloc+0x135a>
    3d4c:	00002097          	auipc	ra,0x2
    3d50:	9ea080e7          	jalr	-1558(ra) # 5736 <chdir>
}
    3d54:	70e2                	ld	ra,56(sp)
    3d56:	7442                	ld	s0,48(sp)
    3d58:	74a2                	ld	s1,40(sp)
    3d5a:	7902                	ld	s2,32(sp)
    3d5c:	69e2                	ld	s3,24(sp)
    3d5e:	6a42                	ld	s4,16(sp)
    3d60:	6aa2                	ld	s5,8(sp)
    3d62:	6b02                	ld	s6,0(sp)
    3d64:	6121                	add	sp,sp,64
    3d66:	8082                	ret

0000000000003d68 <openiputtest>:
{
    3d68:	7179                	add	sp,sp,-48
    3d6a:	f406                	sd	ra,40(sp)
    3d6c:	f022                	sd	s0,32(sp)
    3d6e:	ec26                	sd	s1,24(sp)
    3d70:	1800                	add	s0,sp,48
    3d72:	84aa                	mv	s1,a0
  if(mkdir("oidir") < 0){
    3d74:	00004517          	auipc	a0,0x4
    3d78:	bcc50513          	add	a0,a0,-1076 # 7940 <malloc+0x1bc2>
    3d7c:	00002097          	auipc	ra,0x2
    3d80:	9b2080e7          	jalr	-1614(ra) # 572e <mkdir>
    3d84:	04054263          	bltz	a0,3dc8 <openiputtest+0x60>
  pid = fork();
    3d88:	00002097          	auipc	ra,0x2
    3d8c:	936080e7          	jalr	-1738(ra) # 56be <fork>
  if(pid < 0){
    3d90:	04054a63          	bltz	a0,3de4 <openiputtest+0x7c>
  if(pid == 0){
    3d94:	e93d                	bnez	a0,3e0a <openiputtest+0xa2>
    int fd = open("oidir", O_RDWR);
    3d96:	4589                	li	a1,2
    3d98:	00004517          	auipc	a0,0x4
    3d9c:	ba850513          	add	a0,a0,-1112 # 7940 <malloc+0x1bc2>
    3da0:	00002097          	auipc	ra,0x2
    3da4:	966080e7          	jalr	-1690(ra) # 5706 <open>
    if(fd >= 0){
    3da8:	04054c63          	bltz	a0,3e00 <openiputtest+0x98>
      printf("%s: open directory for write succeeded\n", s);
    3dac:	85a6                	mv	a1,s1
    3dae:	00004517          	auipc	a0,0x4
    3db2:	bb250513          	add	a0,a0,-1102 # 7960 <malloc+0x1be2>
    3db6:	00002097          	auipc	ra,0x2
    3dba:	d48080e7          	jalr	-696(ra) # 5afe <printf>
      exit(1);
    3dbe:	4505                	li	a0,1
    3dc0:	00002097          	auipc	ra,0x2
    3dc4:	906080e7          	jalr	-1786(ra) # 56c6 <exit>
    printf("%s: mkdir oidir failed\n", s);
    3dc8:	85a6                	mv	a1,s1
    3dca:	00004517          	auipc	a0,0x4
    3dce:	b7e50513          	add	a0,a0,-1154 # 7948 <malloc+0x1bca>
    3dd2:	00002097          	auipc	ra,0x2
    3dd6:	d2c080e7          	jalr	-724(ra) # 5afe <printf>
    exit(1);
    3dda:	4505                	li	a0,1
    3ddc:	00002097          	auipc	ra,0x2
    3de0:	8ea080e7          	jalr	-1814(ra) # 56c6 <exit>
    printf("%s: fork failed\n", s);
    3de4:	85a6                	mv	a1,s1
    3de6:	00003517          	auipc	a0,0x3
    3dea:	93a50513          	add	a0,a0,-1734 # 6720 <malloc+0x9a2>
    3dee:	00002097          	auipc	ra,0x2
    3df2:	d10080e7          	jalr	-752(ra) # 5afe <printf>
    exit(1);
    3df6:	4505                	li	a0,1
    3df8:	00002097          	auipc	ra,0x2
    3dfc:	8ce080e7          	jalr	-1842(ra) # 56c6 <exit>
    exit(0);
    3e00:	4501                	li	a0,0
    3e02:	00002097          	auipc	ra,0x2
    3e06:	8c4080e7          	jalr	-1852(ra) # 56c6 <exit>
  sleep(1);
    3e0a:	4505                	li	a0,1
    3e0c:	00002097          	auipc	ra,0x2
    3e10:	94a080e7          	jalr	-1718(ra) # 5756 <sleep>
  if(unlink("oidir") != 0){
    3e14:	00004517          	auipc	a0,0x4
    3e18:	b2c50513          	add	a0,a0,-1236 # 7940 <malloc+0x1bc2>
    3e1c:	00002097          	auipc	ra,0x2
    3e20:	8fa080e7          	jalr	-1798(ra) # 5716 <unlink>
    3e24:	cd19                	beqz	a0,3e42 <openiputtest+0xda>
    printf("%s: unlink failed\n", s);
    3e26:	85a6                	mv	a1,s1
    3e28:	00003517          	auipc	a0,0x3
    3e2c:	ae850513          	add	a0,a0,-1304 # 6910 <malloc+0xb92>
    3e30:	00002097          	auipc	ra,0x2
    3e34:	cce080e7          	jalr	-818(ra) # 5afe <printf>
    exit(1);
    3e38:	4505                	li	a0,1
    3e3a:	00002097          	auipc	ra,0x2
    3e3e:	88c080e7          	jalr	-1908(ra) # 56c6 <exit>
  wait(&xstatus);
    3e42:	fdc40513          	add	a0,s0,-36
    3e46:	00002097          	auipc	ra,0x2
    3e4a:	888080e7          	jalr	-1912(ra) # 56ce <wait>
  exit(xstatus);
    3e4e:	fdc42503          	lw	a0,-36(s0)
    3e52:	00002097          	auipc	ra,0x2
    3e56:	874080e7          	jalr	-1932(ra) # 56c6 <exit>

0000000000003e5a <forkforkfork>:
{
    3e5a:	1101                	add	sp,sp,-32
    3e5c:	ec06                	sd	ra,24(sp)
    3e5e:	e822                	sd	s0,16(sp)
    3e60:	e426                	sd	s1,8(sp)
    3e62:	1000                	add	s0,sp,32
    3e64:	84aa                	mv	s1,a0
  unlink("stopforking");
    3e66:	00004517          	auipc	a0,0x4
    3e6a:	b2250513          	add	a0,a0,-1246 # 7988 <malloc+0x1c0a>
    3e6e:	00002097          	auipc	ra,0x2
    3e72:	8a8080e7          	jalr	-1880(ra) # 5716 <unlink>
  int pid = fork();
    3e76:	00002097          	auipc	ra,0x2
    3e7a:	848080e7          	jalr	-1976(ra) # 56be <fork>
  if(pid < 0){
    3e7e:	04054563          	bltz	a0,3ec8 <forkforkfork+0x6e>
  if(pid == 0){
    3e82:	c12d                	beqz	a0,3ee4 <forkforkfork+0x8a>
  sleep(20); // two seconds
    3e84:	4551                	li	a0,20
    3e86:	00002097          	auipc	ra,0x2
    3e8a:	8d0080e7          	jalr	-1840(ra) # 5756 <sleep>
  close(open("stopforking", O_CREATE|O_RDWR));
    3e8e:	20200593          	li	a1,514
    3e92:	00004517          	auipc	a0,0x4
    3e96:	af650513          	add	a0,a0,-1290 # 7988 <malloc+0x1c0a>
    3e9a:	00002097          	auipc	ra,0x2
    3e9e:	86c080e7          	jalr	-1940(ra) # 5706 <open>
    3ea2:	00002097          	auipc	ra,0x2
    3ea6:	84c080e7          	jalr	-1972(ra) # 56ee <close>
  wait(0);
    3eaa:	4501                	li	a0,0
    3eac:	00002097          	auipc	ra,0x2
    3eb0:	822080e7          	jalr	-2014(ra) # 56ce <wait>
  sleep(10); // one second
    3eb4:	4529                	li	a0,10
    3eb6:	00002097          	auipc	ra,0x2
    3eba:	8a0080e7          	jalr	-1888(ra) # 5756 <sleep>
}
    3ebe:	60e2                	ld	ra,24(sp)
    3ec0:	6442                	ld	s0,16(sp)
    3ec2:	64a2                	ld	s1,8(sp)
    3ec4:	6105                	add	sp,sp,32
    3ec6:	8082                	ret
    printf("%s: fork failed", s);
    3ec8:	85a6                	mv	a1,s1
    3eca:	00003517          	auipc	a0,0x3
    3ece:	a1650513          	add	a0,a0,-1514 # 68e0 <malloc+0xb62>
    3ed2:	00002097          	auipc	ra,0x2
    3ed6:	c2c080e7          	jalr	-980(ra) # 5afe <printf>
    exit(1);
    3eda:	4505                	li	a0,1
    3edc:	00001097          	auipc	ra,0x1
    3ee0:	7ea080e7          	jalr	2026(ra) # 56c6 <exit>
      int fd = open("stopforking", 0);
    3ee4:	00004497          	auipc	s1,0x4
    3ee8:	aa448493          	add	s1,s1,-1372 # 7988 <malloc+0x1c0a>
    3eec:	4581                	li	a1,0
    3eee:	8526                	mv	a0,s1
    3ef0:	00002097          	auipc	ra,0x2
    3ef4:	816080e7          	jalr	-2026(ra) # 5706 <open>
      if(fd >= 0){
    3ef8:	02055763          	bgez	a0,3f26 <forkforkfork+0xcc>
      if(fork() < 0){
    3efc:	00001097          	auipc	ra,0x1
    3f00:	7c2080e7          	jalr	1986(ra) # 56be <fork>
    3f04:	fe0554e3          	bgez	a0,3eec <forkforkfork+0x92>
        close(open("stopforking", O_CREATE|O_RDWR));
    3f08:	20200593          	li	a1,514
    3f0c:	00004517          	auipc	a0,0x4
    3f10:	a7c50513          	add	a0,a0,-1412 # 7988 <malloc+0x1c0a>
    3f14:	00001097          	auipc	ra,0x1
    3f18:	7f2080e7          	jalr	2034(ra) # 5706 <open>
    3f1c:	00001097          	auipc	ra,0x1
    3f20:	7d2080e7          	jalr	2002(ra) # 56ee <close>
    3f24:	b7e1                	j	3eec <forkforkfork+0x92>
        exit(0);
    3f26:	4501                	li	a0,0
    3f28:	00001097          	auipc	ra,0x1
    3f2c:	79e080e7          	jalr	1950(ra) # 56c6 <exit>

0000000000003f30 <preempt>:
{
    3f30:	7139                	add	sp,sp,-64
    3f32:	fc06                	sd	ra,56(sp)
    3f34:	f822                	sd	s0,48(sp)
    3f36:	f426                	sd	s1,40(sp)
    3f38:	f04a                	sd	s2,32(sp)
    3f3a:	ec4e                	sd	s3,24(sp)
    3f3c:	e852                	sd	s4,16(sp)
    3f3e:	0080                	add	s0,sp,64
    3f40:	892a                	mv	s2,a0
  pid1 = fork();
    3f42:	00001097          	auipc	ra,0x1
    3f46:	77c080e7          	jalr	1916(ra) # 56be <fork>
  if(pid1 < 0) {
    3f4a:	00054563          	bltz	a0,3f54 <preempt+0x24>
    3f4e:	84aa                	mv	s1,a0
  if(pid1 == 0)
    3f50:	e105                	bnez	a0,3f70 <preempt+0x40>
    for(;;)
    3f52:	a001                	j	3f52 <preempt+0x22>
    printf("%s: fork failed", s);
    3f54:	85ca                	mv	a1,s2
    3f56:	00003517          	auipc	a0,0x3
    3f5a:	98a50513          	add	a0,a0,-1654 # 68e0 <malloc+0xb62>
    3f5e:	00002097          	auipc	ra,0x2
    3f62:	ba0080e7          	jalr	-1120(ra) # 5afe <printf>
    exit(1);
    3f66:	4505                	li	a0,1
    3f68:	00001097          	auipc	ra,0x1
    3f6c:	75e080e7          	jalr	1886(ra) # 56c6 <exit>
  pid2 = fork();
    3f70:	00001097          	auipc	ra,0x1
    3f74:	74e080e7          	jalr	1870(ra) # 56be <fork>
    3f78:	89aa                	mv	s3,a0
  if(pid2 < 0) {
    3f7a:	00054463          	bltz	a0,3f82 <preempt+0x52>
  if(pid2 == 0)
    3f7e:	e105                	bnez	a0,3f9e <preempt+0x6e>
    for(;;)
    3f80:	a001                	j	3f80 <preempt+0x50>
    printf("%s: fork failed\n", s);
    3f82:	85ca                	mv	a1,s2
    3f84:	00002517          	auipc	a0,0x2
    3f88:	79c50513          	add	a0,a0,1948 # 6720 <malloc+0x9a2>
    3f8c:	00002097          	auipc	ra,0x2
    3f90:	b72080e7          	jalr	-1166(ra) # 5afe <printf>
    exit(1);
    3f94:	4505                	li	a0,1
    3f96:	00001097          	auipc	ra,0x1
    3f9a:	730080e7          	jalr	1840(ra) # 56c6 <exit>
  pipe(pfds);
    3f9e:	fc840513          	add	a0,s0,-56
    3fa2:	00001097          	auipc	ra,0x1
    3fa6:	734080e7          	jalr	1844(ra) # 56d6 <pipe>
  pid3 = fork();
    3faa:	00001097          	auipc	ra,0x1
    3fae:	714080e7          	jalr	1812(ra) # 56be <fork>
    3fb2:	8a2a                	mv	s4,a0
  if(pid3 < 0) {
    3fb4:	02054e63          	bltz	a0,3ff0 <preempt+0xc0>
  if(pid3 == 0){
    3fb8:	e525                	bnez	a0,4020 <preempt+0xf0>
    close(pfds[0]);
    3fba:	fc842503          	lw	a0,-56(s0)
    3fbe:	00001097          	auipc	ra,0x1
    3fc2:	730080e7          	jalr	1840(ra) # 56ee <close>
    if(write(pfds[1], "x", 1) != 1)
    3fc6:	4605                	li	a2,1
    3fc8:	00002597          	auipc	a1,0x2
    3fcc:	f6058593          	add	a1,a1,-160 # 5f28 <malloc+0x1aa>
    3fd0:	fcc42503          	lw	a0,-52(s0)
    3fd4:	00001097          	auipc	ra,0x1
    3fd8:	712080e7          	jalr	1810(ra) # 56e6 <write>
    3fdc:	4785                	li	a5,1
    3fde:	02f51763          	bne	a0,a5,400c <preempt+0xdc>
    close(pfds[1]);
    3fe2:	fcc42503          	lw	a0,-52(s0)
    3fe6:	00001097          	auipc	ra,0x1
    3fea:	708080e7          	jalr	1800(ra) # 56ee <close>
    for(;;)
    3fee:	a001                	j	3fee <preempt+0xbe>
     printf("%s: fork failed\n", s);
    3ff0:	85ca                	mv	a1,s2
    3ff2:	00002517          	auipc	a0,0x2
    3ff6:	72e50513          	add	a0,a0,1838 # 6720 <malloc+0x9a2>
    3ffa:	00002097          	auipc	ra,0x2
    3ffe:	b04080e7          	jalr	-1276(ra) # 5afe <printf>
     exit(1);
    4002:	4505                	li	a0,1
    4004:	00001097          	auipc	ra,0x1
    4008:	6c2080e7          	jalr	1730(ra) # 56c6 <exit>
      printf("%s: preempt write error", s);
    400c:	85ca                	mv	a1,s2
    400e:	00004517          	auipc	a0,0x4
    4012:	98a50513          	add	a0,a0,-1654 # 7998 <malloc+0x1c1a>
    4016:	00002097          	auipc	ra,0x2
    401a:	ae8080e7          	jalr	-1304(ra) # 5afe <printf>
    401e:	b7d1                	j	3fe2 <preempt+0xb2>
  close(pfds[1]);
    4020:	fcc42503          	lw	a0,-52(s0)
    4024:	00001097          	auipc	ra,0x1
    4028:	6ca080e7          	jalr	1738(ra) # 56ee <close>
  if(read(pfds[0], buf, sizeof(buf)) != 1){
    402c:	660d                	lui	a2,0x3
    402e:	00008597          	auipc	a1,0x8
    4032:	e2258593          	add	a1,a1,-478 # be50 <buf>
    4036:	fc842503          	lw	a0,-56(s0)
    403a:	00001097          	auipc	ra,0x1
    403e:	6a4080e7          	jalr	1700(ra) # 56de <read>
    4042:	4785                	li	a5,1
    4044:	02f50363          	beq	a0,a5,406a <preempt+0x13a>
    printf("%s: preempt read error", s);
    4048:	85ca                	mv	a1,s2
    404a:	00004517          	auipc	a0,0x4
    404e:	96650513          	add	a0,a0,-1690 # 79b0 <malloc+0x1c32>
    4052:	00002097          	auipc	ra,0x2
    4056:	aac080e7          	jalr	-1364(ra) # 5afe <printf>
}
    405a:	70e2                	ld	ra,56(sp)
    405c:	7442                	ld	s0,48(sp)
    405e:	74a2                	ld	s1,40(sp)
    4060:	7902                	ld	s2,32(sp)
    4062:	69e2                	ld	s3,24(sp)
    4064:	6a42                	ld	s4,16(sp)
    4066:	6121                	add	sp,sp,64
    4068:	8082                	ret
  close(pfds[0]);
    406a:	fc842503          	lw	a0,-56(s0)
    406e:	00001097          	auipc	ra,0x1
    4072:	680080e7          	jalr	1664(ra) # 56ee <close>
  printf("kill... ");
    4076:	00004517          	auipc	a0,0x4
    407a:	95250513          	add	a0,a0,-1710 # 79c8 <malloc+0x1c4a>
    407e:	00002097          	auipc	ra,0x2
    4082:	a80080e7          	jalr	-1408(ra) # 5afe <printf>
  kill(pid1);
    4086:	8526                	mv	a0,s1
    4088:	00001097          	auipc	ra,0x1
    408c:	66e080e7          	jalr	1646(ra) # 56f6 <kill>
  kill(pid2);
    4090:	854e                	mv	a0,s3
    4092:	00001097          	auipc	ra,0x1
    4096:	664080e7          	jalr	1636(ra) # 56f6 <kill>
  kill(pid3);
    409a:	8552                	mv	a0,s4
    409c:	00001097          	auipc	ra,0x1
    40a0:	65a080e7          	jalr	1626(ra) # 56f6 <kill>
  printf("wait... ");
    40a4:	00004517          	auipc	a0,0x4
    40a8:	93450513          	add	a0,a0,-1740 # 79d8 <malloc+0x1c5a>
    40ac:	00002097          	auipc	ra,0x2
    40b0:	a52080e7          	jalr	-1454(ra) # 5afe <printf>
  wait(0);
    40b4:	4501                	li	a0,0
    40b6:	00001097          	auipc	ra,0x1
    40ba:	618080e7          	jalr	1560(ra) # 56ce <wait>
  wait(0);
    40be:	4501                	li	a0,0
    40c0:	00001097          	auipc	ra,0x1
    40c4:	60e080e7          	jalr	1550(ra) # 56ce <wait>
  wait(0);
    40c8:	4501                	li	a0,0
    40ca:	00001097          	auipc	ra,0x1
    40ce:	604080e7          	jalr	1540(ra) # 56ce <wait>
    40d2:	b761                	j	405a <preempt+0x12a>

00000000000040d4 <sbrkfail>:
{
    40d4:	7119                	add	sp,sp,-128
    40d6:	fc86                	sd	ra,120(sp)
    40d8:	f8a2                	sd	s0,112(sp)
    40da:	f4a6                	sd	s1,104(sp)
    40dc:	f0ca                	sd	s2,96(sp)
    40de:	ecce                	sd	s3,88(sp)
    40e0:	e8d2                	sd	s4,80(sp)
    40e2:	e4d6                	sd	s5,72(sp)
    40e4:	0100                	add	s0,sp,128
    40e6:	8aaa                	mv	s5,a0
  if(pipe(fds) != 0){
    40e8:	fb040513          	add	a0,s0,-80
    40ec:	00001097          	auipc	ra,0x1
    40f0:	5ea080e7          	jalr	1514(ra) # 56d6 <pipe>
    40f4:	e901                	bnez	a0,4104 <sbrkfail+0x30>
    40f6:	f8040493          	add	s1,s0,-128
    40fa:	fa840993          	add	s3,s0,-88
    40fe:	8926                	mv	s2,s1
    if(pids[i] != -1)
    4100:	5a7d                	li	s4,-1
    4102:	a085                	j	4162 <sbrkfail+0x8e>
    printf("%s: pipe() failed\n", s);
    4104:	85d6                	mv	a1,s5
    4106:	00002517          	auipc	a0,0x2
    410a:	72250513          	add	a0,a0,1826 # 6828 <malloc+0xaaa>
    410e:	00002097          	auipc	ra,0x2
    4112:	9f0080e7          	jalr	-1552(ra) # 5afe <printf>
    exit(1);
    4116:	4505                	li	a0,1
    4118:	00001097          	auipc	ra,0x1
    411c:	5ae080e7          	jalr	1454(ra) # 56c6 <exit>
      sbrk(BIG - (uint64)sbrk(0));
    4120:	00001097          	auipc	ra,0x1
    4124:	62e080e7          	jalr	1582(ra) # 574e <sbrk>
    4128:	064007b7          	lui	a5,0x6400
    412c:	40a7853b          	subw	a0,a5,a0
    4130:	00001097          	auipc	ra,0x1
    4134:	61e080e7          	jalr	1566(ra) # 574e <sbrk>
      write(fds[1], "x", 1);
    4138:	4605                	li	a2,1
    413a:	00002597          	auipc	a1,0x2
    413e:	dee58593          	add	a1,a1,-530 # 5f28 <malloc+0x1aa>
    4142:	fb442503          	lw	a0,-76(s0)
    4146:	00001097          	auipc	ra,0x1
    414a:	5a0080e7          	jalr	1440(ra) # 56e6 <write>
      for(;;) sleep(1000);
    414e:	3e800513          	li	a0,1000
    4152:	00001097          	auipc	ra,0x1
    4156:	604080e7          	jalr	1540(ra) # 5756 <sleep>
    415a:	bfd5                	j	414e <sbrkfail+0x7a>
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    415c:	0911                	add	s2,s2,4
    415e:	03390563          	beq	s2,s3,4188 <sbrkfail+0xb4>
    if((pids[i] = fork()) == 0){
    4162:	00001097          	auipc	ra,0x1
    4166:	55c080e7          	jalr	1372(ra) # 56be <fork>
    416a:	00a92023          	sw	a0,0(s2)
    416e:	d94d                	beqz	a0,4120 <sbrkfail+0x4c>
    if(pids[i] != -1)
    4170:	ff4506e3          	beq	a0,s4,415c <sbrkfail+0x88>
      read(fds[0], &scratch, 1);
    4174:	4605                	li	a2,1
    4176:	faf40593          	add	a1,s0,-81
    417a:	fb042503          	lw	a0,-80(s0)
    417e:	00001097          	auipc	ra,0x1
    4182:	560080e7          	jalr	1376(ra) # 56de <read>
    4186:	bfd9                	j	415c <sbrkfail+0x88>
  c = sbrk(PGSIZE);
    4188:	6505                	lui	a0,0x1
    418a:	00001097          	auipc	ra,0x1
    418e:	5c4080e7          	jalr	1476(ra) # 574e <sbrk>
    4192:	8a2a                	mv	s4,a0
    if(pids[i] == -1)
    4194:	597d                	li	s2,-1
    4196:	a021                	j	419e <sbrkfail+0xca>
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    4198:	0491                	add	s1,s1,4
    419a:	01348f63          	beq	s1,s3,41b8 <sbrkfail+0xe4>
    if(pids[i] == -1)
    419e:	4088                	lw	a0,0(s1)
    41a0:	ff250ce3          	beq	a0,s2,4198 <sbrkfail+0xc4>
    kill(pids[i]);
    41a4:	00001097          	auipc	ra,0x1
    41a8:	552080e7          	jalr	1362(ra) # 56f6 <kill>
    wait(0);
    41ac:	4501                	li	a0,0
    41ae:	00001097          	auipc	ra,0x1
    41b2:	520080e7          	jalr	1312(ra) # 56ce <wait>
    41b6:	b7cd                	j	4198 <sbrkfail+0xc4>
  if(c == (char*)0xffffffffffffffffL){
    41b8:	57fd                	li	a5,-1
    41ba:	04fa0163          	beq	s4,a5,41fc <sbrkfail+0x128>
  pid = fork();
    41be:	00001097          	auipc	ra,0x1
    41c2:	500080e7          	jalr	1280(ra) # 56be <fork>
    41c6:	84aa                	mv	s1,a0
  if(pid < 0){
    41c8:	04054863          	bltz	a0,4218 <sbrkfail+0x144>
  if(pid == 0){
    41cc:	c525                	beqz	a0,4234 <sbrkfail+0x160>
  wait(&xstatus);
    41ce:	fbc40513          	add	a0,s0,-68
    41d2:	00001097          	auipc	ra,0x1
    41d6:	4fc080e7          	jalr	1276(ra) # 56ce <wait>
  if(xstatus != -1 && xstatus != 2)
    41da:	fbc42783          	lw	a5,-68(s0)
    41de:	577d                	li	a4,-1
    41e0:	00e78563          	beq	a5,a4,41ea <sbrkfail+0x116>
    41e4:	4709                	li	a4,2
    41e6:	08e79d63          	bne	a5,a4,4280 <sbrkfail+0x1ac>
}
    41ea:	70e6                	ld	ra,120(sp)
    41ec:	7446                	ld	s0,112(sp)
    41ee:	74a6                	ld	s1,104(sp)
    41f0:	7906                	ld	s2,96(sp)
    41f2:	69e6                	ld	s3,88(sp)
    41f4:	6a46                	ld	s4,80(sp)
    41f6:	6aa6                	ld	s5,72(sp)
    41f8:	6109                	add	sp,sp,128
    41fa:	8082                	ret
    printf("%s: failed sbrk leaked memory\n", s);
    41fc:	85d6                	mv	a1,s5
    41fe:	00003517          	auipc	a0,0x3
    4202:	7ea50513          	add	a0,a0,2026 # 79e8 <malloc+0x1c6a>
    4206:	00002097          	auipc	ra,0x2
    420a:	8f8080e7          	jalr	-1800(ra) # 5afe <printf>
    exit(1);
    420e:	4505                	li	a0,1
    4210:	00001097          	auipc	ra,0x1
    4214:	4b6080e7          	jalr	1206(ra) # 56c6 <exit>
    printf("%s: fork failed\n", s);
    4218:	85d6                	mv	a1,s5
    421a:	00002517          	auipc	a0,0x2
    421e:	50650513          	add	a0,a0,1286 # 6720 <malloc+0x9a2>
    4222:	00002097          	auipc	ra,0x2
    4226:	8dc080e7          	jalr	-1828(ra) # 5afe <printf>
    exit(1);
    422a:	4505                	li	a0,1
    422c:	00001097          	auipc	ra,0x1
    4230:	49a080e7          	jalr	1178(ra) # 56c6 <exit>
    a = sbrk(0);
    4234:	4501                	li	a0,0
    4236:	00001097          	auipc	ra,0x1
    423a:	518080e7          	jalr	1304(ra) # 574e <sbrk>
    423e:	892a                	mv	s2,a0
    sbrk(10*BIG);
    4240:	3e800537          	lui	a0,0x3e800
    4244:	00001097          	auipc	ra,0x1
    4248:	50a080e7          	jalr	1290(ra) # 574e <sbrk>
    for (i = 0; i < 10*BIG; i += PGSIZE) {
    424c:	87ca                	mv	a5,s2
    424e:	3e800737          	lui	a4,0x3e800
    4252:	993a                	add	s2,s2,a4
    4254:	6705                	lui	a4,0x1
      n += *(a+i);
    4256:	0007c683          	lbu	a3,0(a5) # 6400000 <__BSS_END__+0x63f11a0>
    425a:	9cb5                	addw	s1,s1,a3
    for (i = 0; i < 10*BIG; i += PGSIZE) {
    425c:	97ba                	add	a5,a5,a4
    425e:	fef91ce3          	bne	s2,a5,4256 <sbrkfail+0x182>
    printf("%s: allocate a lot of memory succeeded %d\n", s, n);
    4262:	8626                	mv	a2,s1
    4264:	85d6                	mv	a1,s5
    4266:	00003517          	auipc	a0,0x3
    426a:	7a250513          	add	a0,a0,1954 # 7a08 <malloc+0x1c8a>
    426e:	00002097          	auipc	ra,0x2
    4272:	890080e7          	jalr	-1904(ra) # 5afe <printf>
    exit(1);
    4276:	4505                	li	a0,1
    4278:	00001097          	auipc	ra,0x1
    427c:	44e080e7          	jalr	1102(ra) # 56c6 <exit>
    exit(1);
    4280:	4505                	li	a0,1
    4282:	00001097          	auipc	ra,0x1
    4286:	444080e7          	jalr	1092(ra) # 56c6 <exit>

000000000000428a <reparent>:
{
    428a:	7179                	add	sp,sp,-48
    428c:	f406                	sd	ra,40(sp)
    428e:	f022                	sd	s0,32(sp)
    4290:	ec26                	sd	s1,24(sp)
    4292:	e84a                	sd	s2,16(sp)
    4294:	e44e                	sd	s3,8(sp)
    4296:	e052                	sd	s4,0(sp)
    4298:	1800                	add	s0,sp,48
    429a:	89aa                	mv	s3,a0
  int master_pid = getpid();
    429c:	00001097          	auipc	ra,0x1
    42a0:	4aa080e7          	jalr	1194(ra) # 5746 <getpid>
    42a4:	8a2a                	mv	s4,a0
    42a6:	0c800913          	li	s2,200
    int pid = fork();
    42aa:	00001097          	auipc	ra,0x1
    42ae:	414080e7          	jalr	1044(ra) # 56be <fork>
    42b2:	84aa                	mv	s1,a0
    if(pid < 0){
    42b4:	02054263          	bltz	a0,42d8 <reparent+0x4e>
    if(pid){
    42b8:	cd21                	beqz	a0,4310 <reparent+0x86>
      if(wait(0) != pid){
    42ba:	4501                	li	a0,0
    42bc:	00001097          	auipc	ra,0x1
    42c0:	412080e7          	jalr	1042(ra) # 56ce <wait>
    42c4:	02951863          	bne	a0,s1,42f4 <reparent+0x6a>
  for(int i = 0; i < 200; i++){
    42c8:	397d                	addw	s2,s2,-1
    42ca:	fe0910e3          	bnez	s2,42aa <reparent+0x20>
  exit(0);
    42ce:	4501                	li	a0,0
    42d0:	00001097          	auipc	ra,0x1
    42d4:	3f6080e7          	jalr	1014(ra) # 56c6 <exit>
      printf("%s: fork failed\n", s);
    42d8:	85ce                	mv	a1,s3
    42da:	00002517          	auipc	a0,0x2
    42de:	44650513          	add	a0,a0,1094 # 6720 <malloc+0x9a2>
    42e2:	00002097          	auipc	ra,0x2
    42e6:	81c080e7          	jalr	-2020(ra) # 5afe <printf>
      exit(1);
    42ea:	4505                	li	a0,1
    42ec:	00001097          	auipc	ra,0x1
    42f0:	3da080e7          	jalr	986(ra) # 56c6 <exit>
        printf("%s: wait wrong pid\n", s);
    42f4:	85ce                	mv	a1,s3
    42f6:	00002517          	auipc	a0,0x2
    42fa:	5b250513          	add	a0,a0,1458 # 68a8 <malloc+0xb2a>
    42fe:	00002097          	auipc	ra,0x2
    4302:	800080e7          	jalr	-2048(ra) # 5afe <printf>
        exit(1);
    4306:	4505                	li	a0,1
    4308:	00001097          	auipc	ra,0x1
    430c:	3be080e7          	jalr	958(ra) # 56c6 <exit>
      int pid2 = fork();
    4310:	00001097          	auipc	ra,0x1
    4314:	3ae080e7          	jalr	942(ra) # 56be <fork>
      if(pid2 < 0){
    4318:	00054763          	bltz	a0,4326 <reparent+0x9c>
      exit(0);
    431c:	4501                	li	a0,0
    431e:	00001097          	auipc	ra,0x1
    4322:	3a8080e7          	jalr	936(ra) # 56c6 <exit>
        kill(master_pid);
    4326:	8552                	mv	a0,s4
    4328:	00001097          	auipc	ra,0x1
    432c:	3ce080e7          	jalr	974(ra) # 56f6 <kill>
        exit(1);
    4330:	4505                	li	a0,1
    4332:	00001097          	auipc	ra,0x1
    4336:	394080e7          	jalr	916(ra) # 56c6 <exit>

000000000000433a <mem>:
{
    433a:	7139                	add	sp,sp,-64
    433c:	fc06                	sd	ra,56(sp)
    433e:	f822                	sd	s0,48(sp)
    4340:	f426                	sd	s1,40(sp)
    4342:	f04a                	sd	s2,32(sp)
    4344:	ec4e                	sd	s3,24(sp)
    4346:	0080                	add	s0,sp,64
    4348:	89aa                	mv	s3,a0
  if((pid = fork()) == 0){
    434a:	00001097          	auipc	ra,0x1
    434e:	374080e7          	jalr	884(ra) # 56be <fork>
    m1 = 0;
    4352:	4481                	li	s1,0
    while((m2 = malloc(10001)) != 0){
    4354:	6909                	lui	s2,0x2
    4356:	71190913          	add	s2,s2,1809 # 2711 <sbrkbasic+0x119>
  if((pid = fork()) == 0){
    435a:	c115                	beqz	a0,437e <mem+0x44>
    wait(&xstatus);
    435c:	fcc40513          	add	a0,s0,-52
    4360:	00001097          	auipc	ra,0x1
    4364:	36e080e7          	jalr	878(ra) # 56ce <wait>
    if(xstatus == -1){
    4368:	fcc42503          	lw	a0,-52(s0)
    436c:	57fd                	li	a5,-1
    436e:	06f50363          	beq	a0,a5,43d4 <mem+0x9a>
    exit(xstatus);
    4372:	00001097          	auipc	ra,0x1
    4376:	354080e7          	jalr	852(ra) # 56c6 <exit>
      *(char**)m2 = m1;
    437a:	e104                	sd	s1,0(a0)
      m1 = m2;
    437c:	84aa                	mv	s1,a0
    while((m2 = malloc(10001)) != 0){
    437e:	854a                	mv	a0,s2
    4380:	00002097          	auipc	ra,0x2
    4384:	9fe080e7          	jalr	-1538(ra) # 5d7e <malloc>
    4388:	f96d                	bnez	a0,437a <mem+0x40>
    while(m1){
    438a:	c881                	beqz	s1,439a <mem+0x60>
      m2 = *(char**)m1;
    438c:	8526                	mv	a0,s1
    438e:	6084                	ld	s1,0(s1)
      free(m1);
    4390:	00002097          	auipc	ra,0x2
    4394:	96c080e7          	jalr	-1684(ra) # 5cfc <free>
    while(m1){
    4398:	f8f5                	bnez	s1,438c <mem+0x52>
    m1 = malloc(1024*20);
    439a:	6515                	lui	a0,0x5
    439c:	00002097          	auipc	ra,0x2
    43a0:	9e2080e7          	jalr	-1566(ra) # 5d7e <malloc>
    if(m1 == 0){
    43a4:	c911                	beqz	a0,43b8 <mem+0x7e>
    free(m1);
    43a6:	00002097          	auipc	ra,0x2
    43aa:	956080e7          	jalr	-1706(ra) # 5cfc <free>
    exit(0);
    43ae:	4501                	li	a0,0
    43b0:	00001097          	auipc	ra,0x1
    43b4:	316080e7          	jalr	790(ra) # 56c6 <exit>
      printf("couldn't allocate mem?!!\n", s);
    43b8:	85ce                	mv	a1,s3
    43ba:	00003517          	auipc	a0,0x3
    43be:	67e50513          	add	a0,a0,1662 # 7a38 <malloc+0x1cba>
    43c2:	00001097          	auipc	ra,0x1
    43c6:	73c080e7          	jalr	1852(ra) # 5afe <printf>
      exit(1);
    43ca:	4505                	li	a0,1
    43cc:	00001097          	auipc	ra,0x1
    43d0:	2fa080e7          	jalr	762(ra) # 56c6 <exit>
      exit(0);
    43d4:	4501                	li	a0,0
    43d6:	00001097          	auipc	ra,0x1
    43da:	2f0080e7          	jalr	752(ra) # 56c6 <exit>

00000000000043de <sharedfd>:
{
    43de:	7159                	add	sp,sp,-112
    43e0:	f486                	sd	ra,104(sp)
    43e2:	f0a2                	sd	s0,96(sp)
    43e4:	e0d2                	sd	s4,64(sp)
    43e6:	1880                	add	s0,sp,112
    43e8:	8a2a                	mv	s4,a0
  unlink("sharedfd");
    43ea:	00003517          	auipc	a0,0x3
    43ee:	66e50513          	add	a0,a0,1646 # 7a58 <malloc+0x1cda>
    43f2:	00001097          	auipc	ra,0x1
    43f6:	324080e7          	jalr	804(ra) # 5716 <unlink>
  fd = open("sharedfd", O_CREATE|O_RDWR);
    43fa:	20200593          	li	a1,514
    43fe:	00003517          	auipc	a0,0x3
    4402:	65a50513          	add	a0,a0,1626 # 7a58 <malloc+0x1cda>
    4406:	00001097          	auipc	ra,0x1
    440a:	300080e7          	jalr	768(ra) # 5706 <open>
  if(fd < 0){
    440e:	06054063          	bltz	a0,446e <sharedfd+0x90>
    4412:	eca6                	sd	s1,88(sp)
    4414:	e8ca                	sd	s2,80(sp)
    4416:	e4ce                	sd	s3,72(sp)
    4418:	fc56                	sd	s5,56(sp)
    441a:	f85a                	sd	s6,48(sp)
    441c:	f45e                	sd	s7,40(sp)
    441e:	892a                	mv	s2,a0
  pid = fork();
    4420:	00001097          	auipc	ra,0x1
    4424:	29e080e7          	jalr	670(ra) # 56be <fork>
    4428:	89aa                	mv	s3,a0
  memset(buf, pid==0?'c':'p', sizeof(buf));
    442a:	07000593          	li	a1,112
    442e:	e119                	bnez	a0,4434 <sharedfd+0x56>
    4430:	06300593          	li	a1,99
    4434:	4629                	li	a2,10
    4436:	fa040513          	add	a0,s0,-96
    443a:	00001097          	auipc	ra,0x1
    443e:	092080e7          	jalr	146(ra) # 54cc <memset>
    4442:	3e800493          	li	s1,1000
    if(write(fd, buf, sizeof(buf)) != sizeof(buf)){
    4446:	4629                	li	a2,10
    4448:	fa040593          	add	a1,s0,-96
    444c:	854a                	mv	a0,s2
    444e:	00001097          	auipc	ra,0x1
    4452:	298080e7          	jalr	664(ra) # 56e6 <write>
    4456:	47a9                	li	a5,10
    4458:	02f51f63          	bne	a0,a5,4496 <sharedfd+0xb8>
  for(i = 0; i < N; i++){
    445c:	34fd                	addw	s1,s1,-1
    445e:	f4e5                	bnez	s1,4446 <sharedfd+0x68>
  if(pid == 0) {
    4460:	04099963          	bnez	s3,44b2 <sharedfd+0xd4>
    exit(0);
    4464:	4501                	li	a0,0
    4466:	00001097          	auipc	ra,0x1
    446a:	260080e7          	jalr	608(ra) # 56c6 <exit>
    446e:	eca6                	sd	s1,88(sp)
    4470:	e8ca                	sd	s2,80(sp)
    4472:	e4ce                	sd	s3,72(sp)
    4474:	fc56                	sd	s5,56(sp)
    4476:	f85a                	sd	s6,48(sp)
    4478:	f45e                	sd	s7,40(sp)
    printf("%s: cannot open sharedfd for writing", s);
    447a:	85d2                	mv	a1,s4
    447c:	00003517          	auipc	a0,0x3
    4480:	5ec50513          	add	a0,a0,1516 # 7a68 <malloc+0x1cea>
    4484:	00001097          	auipc	ra,0x1
    4488:	67a080e7          	jalr	1658(ra) # 5afe <printf>
    exit(1);
    448c:	4505                	li	a0,1
    448e:	00001097          	auipc	ra,0x1
    4492:	238080e7          	jalr	568(ra) # 56c6 <exit>
      printf("%s: write sharedfd failed\n", s);
    4496:	85d2                	mv	a1,s4
    4498:	00003517          	auipc	a0,0x3
    449c:	5f850513          	add	a0,a0,1528 # 7a90 <malloc+0x1d12>
    44a0:	00001097          	auipc	ra,0x1
    44a4:	65e080e7          	jalr	1630(ra) # 5afe <printf>
      exit(1);
    44a8:	4505                	li	a0,1
    44aa:	00001097          	auipc	ra,0x1
    44ae:	21c080e7          	jalr	540(ra) # 56c6 <exit>
    wait(&xstatus);
    44b2:	f9c40513          	add	a0,s0,-100
    44b6:	00001097          	auipc	ra,0x1
    44ba:	218080e7          	jalr	536(ra) # 56ce <wait>
    if(xstatus != 0)
    44be:	f9c42983          	lw	s3,-100(s0)
    44c2:	00098763          	beqz	s3,44d0 <sharedfd+0xf2>
      exit(xstatus);
    44c6:	854e                	mv	a0,s3
    44c8:	00001097          	auipc	ra,0x1
    44cc:	1fe080e7          	jalr	510(ra) # 56c6 <exit>
  close(fd);
    44d0:	854a                	mv	a0,s2
    44d2:	00001097          	auipc	ra,0x1
    44d6:	21c080e7          	jalr	540(ra) # 56ee <close>
  fd = open("sharedfd", 0);
    44da:	4581                	li	a1,0
    44dc:	00003517          	auipc	a0,0x3
    44e0:	57c50513          	add	a0,a0,1404 # 7a58 <malloc+0x1cda>
    44e4:	00001097          	auipc	ra,0x1
    44e8:	222080e7          	jalr	546(ra) # 5706 <open>
    44ec:	8baa                	mv	s7,a0
  nc = np = 0;
    44ee:	8ace                	mv	s5,s3
  if(fd < 0){
    44f0:	02054563          	bltz	a0,451a <sharedfd+0x13c>
    44f4:	faa40913          	add	s2,s0,-86
      if(buf[i] == 'c')
    44f8:	06300493          	li	s1,99
      if(buf[i] == 'p')
    44fc:	07000b13          	li	s6,112
  while((n = read(fd, buf, sizeof(buf))) > 0){
    4500:	4629                	li	a2,10
    4502:	fa040593          	add	a1,s0,-96
    4506:	855e                	mv	a0,s7
    4508:	00001097          	auipc	ra,0x1
    450c:	1d6080e7          	jalr	470(ra) # 56de <read>
    4510:	02a05f63          	blez	a0,454e <sharedfd+0x170>
    4514:	fa040793          	add	a5,s0,-96
    4518:	a01d                	j	453e <sharedfd+0x160>
    printf("%s: cannot open sharedfd for reading\n", s);
    451a:	85d2                	mv	a1,s4
    451c:	00003517          	auipc	a0,0x3
    4520:	59450513          	add	a0,a0,1428 # 7ab0 <malloc+0x1d32>
    4524:	00001097          	auipc	ra,0x1
    4528:	5da080e7          	jalr	1498(ra) # 5afe <printf>
    exit(1);
    452c:	4505                	li	a0,1
    452e:	00001097          	auipc	ra,0x1
    4532:	198080e7          	jalr	408(ra) # 56c6 <exit>
        nc++;
    4536:	2985                	addw	s3,s3,1
    for(i = 0; i < sizeof(buf); i++){
    4538:	0785                	add	a5,a5,1
    453a:	fd2783e3          	beq	a5,s2,4500 <sharedfd+0x122>
      if(buf[i] == 'c')
    453e:	0007c703          	lbu	a4,0(a5)
    4542:	fe970ae3          	beq	a4,s1,4536 <sharedfd+0x158>
      if(buf[i] == 'p')
    4546:	ff6719e3          	bne	a4,s6,4538 <sharedfd+0x15a>
        np++;
    454a:	2a85                	addw	s5,s5,1
    454c:	b7f5                	j	4538 <sharedfd+0x15a>
  close(fd);
    454e:	855e                	mv	a0,s7
    4550:	00001097          	auipc	ra,0x1
    4554:	19e080e7          	jalr	414(ra) # 56ee <close>
  unlink("sharedfd");
    4558:	00003517          	auipc	a0,0x3
    455c:	50050513          	add	a0,a0,1280 # 7a58 <malloc+0x1cda>
    4560:	00001097          	auipc	ra,0x1
    4564:	1b6080e7          	jalr	438(ra) # 5716 <unlink>
  if(nc == N*SZ && np == N*SZ){
    4568:	6789                	lui	a5,0x2
    456a:	71078793          	add	a5,a5,1808 # 2710 <sbrkbasic+0x118>
    456e:	00f99763          	bne	s3,a5,457c <sharedfd+0x19e>
    4572:	6789                	lui	a5,0x2
    4574:	71078793          	add	a5,a5,1808 # 2710 <sbrkbasic+0x118>
    4578:	02fa8063          	beq	s5,a5,4598 <sharedfd+0x1ba>
    printf("%s: nc/np test fails\n", s);
    457c:	85d2                	mv	a1,s4
    457e:	00003517          	auipc	a0,0x3
    4582:	55a50513          	add	a0,a0,1370 # 7ad8 <malloc+0x1d5a>
    4586:	00001097          	auipc	ra,0x1
    458a:	578080e7          	jalr	1400(ra) # 5afe <printf>
    exit(1);
    458e:	4505                	li	a0,1
    4590:	00001097          	auipc	ra,0x1
    4594:	136080e7          	jalr	310(ra) # 56c6 <exit>
    exit(0);
    4598:	4501                	li	a0,0
    459a:	00001097          	auipc	ra,0x1
    459e:	12c080e7          	jalr	300(ra) # 56c6 <exit>

00000000000045a2 <fourfiles>:
{
    45a2:	7135                	add	sp,sp,-160
    45a4:	ed06                	sd	ra,152(sp)
    45a6:	e922                	sd	s0,144(sp)
    45a8:	e526                	sd	s1,136(sp)
    45aa:	e14a                	sd	s2,128(sp)
    45ac:	fcce                	sd	s3,120(sp)
    45ae:	f8d2                	sd	s4,112(sp)
    45b0:	f4d6                	sd	s5,104(sp)
    45b2:	f0da                	sd	s6,96(sp)
    45b4:	ecde                	sd	s7,88(sp)
    45b6:	e8e2                	sd	s8,80(sp)
    45b8:	e4e6                	sd	s9,72(sp)
    45ba:	e0ea                	sd	s10,64(sp)
    45bc:	fc6e                	sd	s11,56(sp)
    45be:	1100                	add	s0,sp,160
    45c0:	8caa                	mv	s9,a0
  char *names[] = { "f0", "f1", "f2", "f3" };
    45c2:	00003797          	auipc	a5,0x3
    45c6:	52e78793          	add	a5,a5,1326 # 7af0 <malloc+0x1d72>
    45ca:	f6f43823          	sd	a5,-144(s0)
    45ce:	00003797          	auipc	a5,0x3
    45d2:	52a78793          	add	a5,a5,1322 # 7af8 <malloc+0x1d7a>
    45d6:	f6f43c23          	sd	a5,-136(s0)
    45da:	00003797          	auipc	a5,0x3
    45de:	52678793          	add	a5,a5,1318 # 7b00 <malloc+0x1d82>
    45e2:	f8f43023          	sd	a5,-128(s0)
    45e6:	00003797          	auipc	a5,0x3
    45ea:	52278793          	add	a5,a5,1314 # 7b08 <malloc+0x1d8a>
    45ee:	f8f43423          	sd	a5,-120(s0)
  for(pi = 0; pi < NCHILD; pi++){
    45f2:	f7040b93          	add	s7,s0,-144
  char *names[] = { "f0", "f1", "f2", "f3" };
    45f6:	895e                	mv	s2,s7
  for(pi = 0; pi < NCHILD; pi++){
    45f8:	4481                	li	s1,0
    45fa:	4a11                	li	s4,4
    fname = names[pi];
    45fc:	00093983          	ld	s3,0(s2)
    unlink(fname);
    4600:	854e                	mv	a0,s3
    4602:	00001097          	auipc	ra,0x1
    4606:	114080e7          	jalr	276(ra) # 5716 <unlink>
    pid = fork();
    460a:	00001097          	auipc	ra,0x1
    460e:	0b4080e7          	jalr	180(ra) # 56be <fork>
    if(pid < 0){
    4612:	04054063          	bltz	a0,4652 <fourfiles+0xb0>
    if(pid == 0){
    4616:	cd21                	beqz	a0,466e <fourfiles+0xcc>
  for(pi = 0; pi < NCHILD; pi++){
    4618:	2485                	addw	s1,s1,1
    461a:	0921                	add	s2,s2,8
    461c:	ff4490e3          	bne	s1,s4,45fc <fourfiles+0x5a>
    4620:	4491                	li	s1,4
    wait(&xstatus);
    4622:	f6c40513          	add	a0,s0,-148
    4626:	00001097          	auipc	ra,0x1
    462a:	0a8080e7          	jalr	168(ra) # 56ce <wait>
    if(xstatus != 0)
    462e:	f6c42a83          	lw	s5,-148(s0)
    4632:	0c0a9863          	bnez	s5,4702 <fourfiles+0x160>
  for(pi = 0; pi < NCHILD; pi++){
    4636:	34fd                	addw	s1,s1,-1
    4638:	f4ed                	bnez	s1,4622 <fourfiles+0x80>
    463a:	03000b13          	li	s6,48
    while((n = read(fd, buf, sizeof(buf))) > 0){
    463e:	00008a17          	auipc	s4,0x8
    4642:	812a0a13          	add	s4,s4,-2030 # be50 <buf>
    if(total != N*SZ){
    4646:	6d05                	lui	s10,0x1
    4648:	770d0d13          	add	s10,s10,1904 # 1770 <pipe1+0x18>
  for(i = 0; i < NCHILD; i++){
    464c:	03400d93          	li	s11,52
    4650:	a22d                	j	477a <fourfiles+0x1d8>
      printf("fork failed\n", s);
    4652:	85e6                	mv	a1,s9
    4654:	00002517          	auipc	a0,0x2
    4658:	4d450513          	add	a0,a0,1236 # 6b28 <malloc+0xdaa>
    465c:	00001097          	auipc	ra,0x1
    4660:	4a2080e7          	jalr	1186(ra) # 5afe <printf>
      exit(1);
    4664:	4505                	li	a0,1
    4666:	00001097          	auipc	ra,0x1
    466a:	060080e7          	jalr	96(ra) # 56c6 <exit>
      fd = open(fname, O_CREATE | O_RDWR);
    466e:	20200593          	li	a1,514
    4672:	854e                	mv	a0,s3
    4674:	00001097          	auipc	ra,0x1
    4678:	092080e7          	jalr	146(ra) # 5706 <open>
    467c:	892a                	mv	s2,a0
      if(fd < 0){
    467e:	04054763          	bltz	a0,46cc <fourfiles+0x12a>
      memset(buf, '0'+pi, SZ);
    4682:	1f400613          	li	a2,500
    4686:	0304859b          	addw	a1,s1,48
    468a:	00007517          	auipc	a0,0x7
    468e:	7c650513          	add	a0,a0,1990 # be50 <buf>
    4692:	00001097          	auipc	ra,0x1
    4696:	e3a080e7          	jalr	-454(ra) # 54cc <memset>
    469a:	44b1                	li	s1,12
        if((n = write(fd, buf, SZ)) != SZ){
    469c:	00007997          	auipc	s3,0x7
    46a0:	7b498993          	add	s3,s3,1972 # be50 <buf>
    46a4:	1f400613          	li	a2,500
    46a8:	85ce                	mv	a1,s3
    46aa:	854a                	mv	a0,s2
    46ac:	00001097          	auipc	ra,0x1
    46b0:	03a080e7          	jalr	58(ra) # 56e6 <write>
    46b4:	85aa                	mv	a1,a0
    46b6:	1f400793          	li	a5,500
    46ba:	02f51763          	bne	a0,a5,46e8 <fourfiles+0x146>
      for(i = 0; i < N; i++){
    46be:	34fd                	addw	s1,s1,-1
    46c0:	f0f5                	bnez	s1,46a4 <fourfiles+0x102>
      exit(0);
    46c2:	4501                	li	a0,0
    46c4:	00001097          	auipc	ra,0x1
    46c8:	002080e7          	jalr	2(ra) # 56c6 <exit>
        printf("create failed\n", s);
    46cc:	85e6                	mv	a1,s9
    46ce:	00003517          	auipc	a0,0x3
    46d2:	44250513          	add	a0,a0,1090 # 7b10 <malloc+0x1d92>
    46d6:	00001097          	auipc	ra,0x1
    46da:	428080e7          	jalr	1064(ra) # 5afe <printf>
        exit(1);
    46de:	4505                	li	a0,1
    46e0:	00001097          	auipc	ra,0x1
    46e4:	fe6080e7          	jalr	-26(ra) # 56c6 <exit>
          printf("write failed %d\n", n);
    46e8:	00003517          	auipc	a0,0x3
    46ec:	43850513          	add	a0,a0,1080 # 7b20 <malloc+0x1da2>
    46f0:	00001097          	auipc	ra,0x1
    46f4:	40e080e7          	jalr	1038(ra) # 5afe <printf>
          exit(1);
    46f8:	4505                	li	a0,1
    46fa:	00001097          	auipc	ra,0x1
    46fe:	fcc080e7          	jalr	-52(ra) # 56c6 <exit>
      exit(xstatus);
    4702:	8556                	mv	a0,s5
    4704:	00001097          	auipc	ra,0x1
    4708:	fc2080e7          	jalr	-62(ra) # 56c6 <exit>
          printf("wrong char\n", s);
    470c:	85e6                	mv	a1,s9
    470e:	00003517          	auipc	a0,0x3
    4712:	42a50513          	add	a0,a0,1066 # 7b38 <malloc+0x1dba>
    4716:	00001097          	auipc	ra,0x1
    471a:	3e8080e7          	jalr	1000(ra) # 5afe <printf>
          exit(1);
    471e:	4505                	li	a0,1
    4720:	00001097          	auipc	ra,0x1
    4724:	fa6080e7          	jalr	-90(ra) # 56c6 <exit>
      total += n;
    4728:	00a9093b          	addw	s2,s2,a0
    while((n = read(fd, buf, sizeof(buf))) > 0){
    472c:	660d                	lui	a2,0x3
    472e:	85d2                	mv	a1,s4
    4730:	854e                	mv	a0,s3
    4732:	00001097          	auipc	ra,0x1
    4736:	fac080e7          	jalr	-84(ra) # 56de <read>
    473a:	02a05063          	blez	a0,475a <fourfiles+0x1b8>
    473e:	00007797          	auipc	a5,0x7
    4742:	71278793          	add	a5,a5,1810 # be50 <buf>
    4746:	00f506b3          	add	a3,a0,a5
        if(buf[j] != '0'+i){
    474a:	0007c703          	lbu	a4,0(a5)
    474e:	fa971fe3          	bne	a4,s1,470c <fourfiles+0x16a>
      for(j = 0; j < n; j++){
    4752:	0785                	add	a5,a5,1
    4754:	fed79be3          	bne	a5,a3,474a <fourfiles+0x1a8>
    4758:	bfc1                	j	4728 <fourfiles+0x186>
    close(fd);
    475a:	854e                	mv	a0,s3
    475c:	00001097          	auipc	ra,0x1
    4760:	f92080e7          	jalr	-110(ra) # 56ee <close>
    if(total != N*SZ){
    4764:	03a91863          	bne	s2,s10,4794 <fourfiles+0x1f2>
    unlink(fname);
    4768:	8562                	mv	a0,s8
    476a:	00001097          	auipc	ra,0x1
    476e:	fac080e7          	jalr	-84(ra) # 5716 <unlink>
  for(i = 0; i < NCHILD; i++){
    4772:	0ba1                	add	s7,s7,8
    4774:	2b05                	addw	s6,s6,1
    4776:	03bb0d63          	beq	s6,s11,47b0 <fourfiles+0x20e>
    fname = names[i];
    477a:	000bbc03          	ld	s8,0(s7)
    fd = open(fname, 0);
    477e:	4581                	li	a1,0
    4780:	8562                	mv	a0,s8
    4782:	00001097          	auipc	ra,0x1
    4786:	f84080e7          	jalr	-124(ra) # 5706 <open>
    478a:	89aa                	mv	s3,a0
    total = 0;
    478c:	8956                	mv	s2,s5
        if(buf[j] != '0'+i){
    478e:	000b049b          	sext.w	s1,s6
    while((n = read(fd, buf, sizeof(buf))) > 0){
    4792:	bf69                	j	472c <fourfiles+0x18a>
      printf("wrong length %d\n", total);
    4794:	85ca                	mv	a1,s2
    4796:	00003517          	auipc	a0,0x3
    479a:	3b250513          	add	a0,a0,946 # 7b48 <malloc+0x1dca>
    479e:	00001097          	auipc	ra,0x1
    47a2:	360080e7          	jalr	864(ra) # 5afe <printf>
      exit(1);
    47a6:	4505                	li	a0,1
    47a8:	00001097          	auipc	ra,0x1
    47ac:	f1e080e7          	jalr	-226(ra) # 56c6 <exit>
}
    47b0:	60ea                	ld	ra,152(sp)
    47b2:	644a                	ld	s0,144(sp)
    47b4:	64aa                	ld	s1,136(sp)
    47b6:	690a                	ld	s2,128(sp)
    47b8:	79e6                	ld	s3,120(sp)
    47ba:	7a46                	ld	s4,112(sp)
    47bc:	7aa6                	ld	s5,104(sp)
    47be:	7b06                	ld	s6,96(sp)
    47c0:	6be6                	ld	s7,88(sp)
    47c2:	6c46                	ld	s8,80(sp)
    47c4:	6ca6                	ld	s9,72(sp)
    47c6:	6d06                	ld	s10,64(sp)
    47c8:	7de2                	ld	s11,56(sp)
    47ca:	610d                	add	sp,sp,160
    47cc:	8082                	ret

00000000000047ce <concreate>:
{
    47ce:	7135                	add	sp,sp,-160
    47d0:	ed06                	sd	ra,152(sp)
    47d2:	e922                	sd	s0,144(sp)
    47d4:	e526                	sd	s1,136(sp)
    47d6:	e14a                	sd	s2,128(sp)
    47d8:	fcce                	sd	s3,120(sp)
    47da:	f8d2                	sd	s4,112(sp)
    47dc:	f4d6                	sd	s5,104(sp)
    47de:	f0da                	sd	s6,96(sp)
    47e0:	ecde                	sd	s7,88(sp)
    47e2:	1100                	add	s0,sp,160
    47e4:	89aa                	mv	s3,a0
  file[0] = 'C';
    47e6:	04300793          	li	a5,67
    47ea:	faf40423          	sb	a5,-88(s0)
  file[2] = '\0';
    47ee:	fa040523          	sb	zero,-86(s0)
  for(i = 0; i < N; i++){
    47f2:	4901                	li	s2,0
    if(pid && (i % 3) == 1){
    47f4:	4b0d                	li	s6,3
    47f6:	4a85                	li	s5,1
      link("C0", file);
    47f8:	00003b97          	auipc	s7,0x3
    47fc:	368b8b93          	add	s7,s7,872 # 7b60 <malloc+0x1de2>
  for(i = 0; i < N; i++){
    4800:	02800a13          	li	s4,40
    4804:	acc9                	j	4ad6 <concreate+0x308>
      link("C0", file);
    4806:	fa840593          	add	a1,s0,-88
    480a:	855e                	mv	a0,s7
    480c:	00001097          	auipc	ra,0x1
    4810:	f1a080e7          	jalr	-230(ra) # 5726 <link>
    if(pid == 0) {
    4814:	a465                	j	4abc <concreate+0x2ee>
    } else if(pid == 0 && (i % 5) == 1){
    4816:	4795                	li	a5,5
    4818:	02f9693b          	remw	s2,s2,a5
    481c:	4785                	li	a5,1
    481e:	02f90b63          	beq	s2,a5,4854 <concreate+0x86>
      fd = open(file, O_CREATE | O_RDWR);
    4822:	20200593          	li	a1,514
    4826:	fa840513          	add	a0,s0,-88
    482a:	00001097          	auipc	ra,0x1
    482e:	edc080e7          	jalr	-292(ra) # 5706 <open>
      if(fd < 0){
    4832:	26055c63          	bgez	a0,4aaa <concreate+0x2dc>
        printf("concreate create %s failed\n", file);
    4836:	fa840593          	add	a1,s0,-88
    483a:	00003517          	auipc	a0,0x3
    483e:	32e50513          	add	a0,a0,814 # 7b68 <malloc+0x1dea>
    4842:	00001097          	auipc	ra,0x1
    4846:	2bc080e7          	jalr	700(ra) # 5afe <printf>
        exit(1);
    484a:	4505                	li	a0,1
    484c:	00001097          	auipc	ra,0x1
    4850:	e7a080e7          	jalr	-390(ra) # 56c6 <exit>
      link("C0", file);
    4854:	fa840593          	add	a1,s0,-88
    4858:	00003517          	auipc	a0,0x3
    485c:	30850513          	add	a0,a0,776 # 7b60 <malloc+0x1de2>
    4860:	00001097          	auipc	ra,0x1
    4864:	ec6080e7          	jalr	-314(ra) # 5726 <link>
      exit(0);
    4868:	4501                	li	a0,0
    486a:	00001097          	auipc	ra,0x1
    486e:	e5c080e7          	jalr	-420(ra) # 56c6 <exit>
        exit(1);
    4872:	4505                	li	a0,1
    4874:	00001097          	auipc	ra,0x1
    4878:	e52080e7          	jalr	-430(ra) # 56c6 <exit>
  memset(fa, 0, sizeof(fa));
    487c:	02800613          	li	a2,40
    4880:	4581                	li	a1,0
    4882:	f8040513          	add	a0,s0,-128
    4886:	00001097          	auipc	ra,0x1
    488a:	c46080e7          	jalr	-954(ra) # 54cc <memset>
  fd = open(".", 0);
    488e:	4581                	li	a1,0
    4890:	00002517          	auipc	a0,0x2
    4894:	cf050513          	add	a0,a0,-784 # 6580 <malloc+0x802>
    4898:	00001097          	auipc	ra,0x1
    489c:	e6e080e7          	jalr	-402(ra) # 5706 <open>
    48a0:	892a                	mv	s2,a0
  n = 0;
    48a2:	8aa6                	mv	s5,s1
    if(de.name[0] == 'C' && de.name[2] == '\0'){
    48a4:	04300a13          	li	s4,67
      if(i < 0 || i >= sizeof(fa)){
    48a8:	02700b13          	li	s6,39
      fa[i] = 1;
    48ac:	4b85                	li	s7,1
  while(read(fd, &de, sizeof(de)) > 0){
    48ae:	4641                	li	a2,16
    48b0:	f7040593          	add	a1,s0,-144
    48b4:	854a                	mv	a0,s2
    48b6:	00001097          	auipc	ra,0x1
    48ba:	e28080e7          	jalr	-472(ra) # 56de <read>
    48be:	08a05263          	blez	a0,4942 <concreate+0x174>
    if(de.inum == 0)
    48c2:	f7045783          	lhu	a5,-144(s0)
    48c6:	d7e5                	beqz	a5,48ae <concreate+0xe0>
    if(de.name[0] == 'C' && de.name[2] == '\0'){
    48c8:	f7244783          	lbu	a5,-142(s0)
    48cc:	ff4791e3          	bne	a5,s4,48ae <concreate+0xe0>
    48d0:	f7444783          	lbu	a5,-140(s0)
    48d4:	ffe9                	bnez	a5,48ae <concreate+0xe0>
      i = de.name[1] - '0';
    48d6:	f7344783          	lbu	a5,-141(s0)
    48da:	fd07879b          	addw	a5,a5,-48
    48de:	0007871b          	sext.w	a4,a5
      if(i < 0 || i >= sizeof(fa)){
    48e2:	02eb6063          	bltu	s6,a4,4902 <concreate+0x134>
      if(fa[i]){
    48e6:	fb070793          	add	a5,a4,-80 # fb0 <bigdir+0x50>
    48ea:	97a2                	add	a5,a5,s0
    48ec:	fd07c783          	lbu	a5,-48(a5)
    48f0:	eb8d                	bnez	a5,4922 <concreate+0x154>
      fa[i] = 1;
    48f2:	fb070793          	add	a5,a4,-80
    48f6:	00878733          	add	a4,a5,s0
    48fa:	fd770823          	sb	s7,-48(a4)
      n++;
    48fe:	2a85                	addw	s5,s5,1
    4900:	b77d                	j	48ae <concreate+0xe0>
        printf("%s: concreate weird file %s\n", s, de.name);
    4902:	f7240613          	add	a2,s0,-142
    4906:	85ce                	mv	a1,s3
    4908:	00003517          	auipc	a0,0x3
    490c:	28050513          	add	a0,a0,640 # 7b88 <malloc+0x1e0a>
    4910:	00001097          	auipc	ra,0x1
    4914:	1ee080e7          	jalr	494(ra) # 5afe <printf>
        exit(1);
    4918:	4505                	li	a0,1
    491a:	00001097          	auipc	ra,0x1
    491e:	dac080e7          	jalr	-596(ra) # 56c6 <exit>
        printf("%s: concreate duplicate file %s\n", s, de.name);
    4922:	f7240613          	add	a2,s0,-142
    4926:	85ce                	mv	a1,s3
    4928:	00003517          	auipc	a0,0x3
    492c:	28050513          	add	a0,a0,640 # 7ba8 <malloc+0x1e2a>
    4930:	00001097          	auipc	ra,0x1
    4934:	1ce080e7          	jalr	462(ra) # 5afe <printf>
        exit(1);
    4938:	4505                	li	a0,1
    493a:	00001097          	auipc	ra,0x1
    493e:	d8c080e7          	jalr	-628(ra) # 56c6 <exit>
  close(fd);
    4942:	854a                	mv	a0,s2
    4944:	00001097          	auipc	ra,0x1
    4948:	daa080e7          	jalr	-598(ra) # 56ee <close>
  if(n != N){
    494c:	02800793          	li	a5,40
    4950:	00fa9763          	bne	s5,a5,495e <concreate+0x190>
    if(((i % 3) == 0 && pid == 0) ||
    4954:	4a8d                	li	s5,3
    4956:	4b05                	li	s6,1
  for(i = 0; i < N; i++){
    4958:	02800a13          	li	s4,40
    495c:	a8c9                	j	4a2e <concreate+0x260>
    printf("%s: concreate not enough files in directory listing\n", s);
    495e:	85ce                	mv	a1,s3
    4960:	00003517          	auipc	a0,0x3
    4964:	27050513          	add	a0,a0,624 # 7bd0 <malloc+0x1e52>
    4968:	00001097          	auipc	ra,0x1
    496c:	196080e7          	jalr	406(ra) # 5afe <printf>
    exit(1);
    4970:	4505                	li	a0,1
    4972:	00001097          	auipc	ra,0x1
    4976:	d54080e7          	jalr	-684(ra) # 56c6 <exit>
      printf("%s: fork failed\n", s);
    497a:	85ce                	mv	a1,s3
    497c:	00002517          	auipc	a0,0x2
    4980:	da450513          	add	a0,a0,-604 # 6720 <malloc+0x9a2>
    4984:	00001097          	auipc	ra,0x1
    4988:	17a080e7          	jalr	378(ra) # 5afe <printf>
      exit(1);
    498c:	4505                	li	a0,1
    498e:	00001097          	auipc	ra,0x1
    4992:	d38080e7          	jalr	-712(ra) # 56c6 <exit>
      close(open(file, 0));
    4996:	4581                	li	a1,0
    4998:	fa840513          	add	a0,s0,-88
    499c:	00001097          	auipc	ra,0x1
    49a0:	d6a080e7          	jalr	-662(ra) # 5706 <open>
    49a4:	00001097          	auipc	ra,0x1
    49a8:	d4a080e7          	jalr	-694(ra) # 56ee <close>
      close(open(file, 0));
    49ac:	4581                	li	a1,0
    49ae:	fa840513          	add	a0,s0,-88
    49b2:	00001097          	auipc	ra,0x1
    49b6:	d54080e7          	jalr	-684(ra) # 5706 <open>
    49ba:	00001097          	auipc	ra,0x1
    49be:	d34080e7          	jalr	-716(ra) # 56ee <close>
      close(open(file, 0));
    49c2:	4581                	li	a1,0
    49c4:	fa840513          	add	a0,s0,-88
    49c8:	00001097          	auipc	ra,0x1
    49cc:	d3e080e7          	jalr	-706(ra) # 5706 <open>
    49d0:	00001097          	auipc	ra,0x1
    49d4:	d1e080e7          	jalr	-738(ra) # 56ee <close>
      close(open(file, 0));
    49d8:	4581                	li	a1,0
    49da:	fa840513          	add	a0,s0,-88
    49de:	00001097          	auipc	ra,0x1
    49e2:	d28080e7          	jalr	-728(ra) # 5706 <open>
    49e6:	00001097          	auipc	ra,0x1
    49ea:	d08080e7          	jalr	-760(ra) # 56ee <close>
      close(open(file, 0));
    49ee:	4581                	li	a1,0
    49f0:	fa840513          	add	a0,s0,-88
    49f4:	00001097          	auipc	ra,0x1
    49f8:	d12080e7          	jalr	-750(ra) # 5706 <open>
    49fc:	00001097          	auipc	ra,0x1
    4a00:	cf2080e7          	jalr	-782(ra) # 56ee <close>
      close(open(file, 0));
    4a04:	4581                	li	a1,0
    4a06:	fa840513          	add	a0,s0,-88
    4a0a:	00001097          	auipc	ra,0x1
    4a0e:	cfc080e7          	jalr	-772(ra) # 5706 <open>
    4a12:	00001097          	auipc	ra,0x1
    4a16:	cdc080e7          	jalr	-804(ra) # 56ee <close>
    if(pid == 0)
    4a1a:	08090363          	beqz	s2,4aa0 <concreate+0x2d2>
      wait(0);
    4a1e:	4501                	li	a0,0
    4a20:	00001097          	auipc	ra,0x1
    4a24:	cae080e7          	jalr	-850(ra) # 56ce <wait>
  for(i = 0; i < N; i++){
    4a28:	2485                	addw	s1,s1,1
    4a2a:	0f448563          	beq	s1,s4,4b14 <concreate+0x346>
    file[1] = '0' + i;
    4a2e:	0304879b          	addw	a5,s1,48
    4a32:	faf404a3          	sb	a5,-87(s0)
    pid = fork();
    4a36:	00001097          	auipc	ra,0x1
    4a3a:	c88080e7          	jalr	-888(ra) # 56be <fork>
    4a3e:	892a                	mv	s2,a0
    if(pid < 0){
    4a40:	f2054de3          	bltz	a0,497a <concreate+0x1ac>
    if(((i % 3) == 0 && pid == 0) ||
    4a44:	0354e73b          	remw	a4,s1,s5
    4a48:	00a767b3          	or	a5,a4,a0
    4a4c:	2781                	sext.w	a5,a5
    4a4e:	d7a1                	beqz	a5,4996 <concreate+0x1c8>
    4a50:	01671363          	bne	a4,s6,4a56 <concreate+0x288>
       ((i % 3) == 1 && pid != 0)){
    4a54:	f129                	bnez	a0,4996 <concreate+0x1c8>
      unlink(file);
    4a56:	fa840513          	add	a0,s0,-88
    4a5a:	00001097          	auipc	ra,0x1
    4a5e:	cbc080e7          	jalr	-836(ra) # 5716 <unlink>
      unlink(file);
    4a62:	fa840513          	add	a0,s0,-88
    4a66:	00001097          	auipc	ra,0x1
    4a6a:	cb0080e7          	jalr	-848(ra) # 5716 <unlink>
      unlink(file);
    4a6e:	fa840513          	add	a0,s0,-88
    4a72:	00001097          	auipc	ra,0x1
    4a76:	ca4080e7          	jalr	-860(ra) # 5716 <unlink>
      unlink(file);
    4a7a:	fa840513          	add	a0,s0,-88
    4a7e:	00001097          	auipc	ra,0x1
    4a82:	c98080e7          	jalr	-872(ra) # 5716 <unlink>
      unlink(file);
    4a86:	fa840513          	add	a0,s0,-88
    4a8a:	00001097          	auipc	ra,0x1
    4a8e:	c8c080e7          	jalr	-884(ra) # 5716 <unlink>
      unlink(file);
    4a92:	fa840513          	add	a0,s0,-88
    4a96:	00001097          	auipc	ra,0x1
    4a9a:	c80080e7          	jalr	-896(ra) # 5716 <unlink>
    4a9e:	bfb5                	j	4a1a <concreate+0x24c>
      exit(0);
    4aa0:	4501                	li	a0,0
    4aa2:	00001097          	auipc	ra,0x1
    4aa6:	c24080e7          	jalr	-988(ra) # 56c6 <exit>
      close(fd);
    4aaa:	00001097          	auipc	ra,0x1
    4aae:	c44080e7          	jalr	-956(ra) # 56ee <close>
    if(pid == 0) {
    4ab2:	bb5d                	j	4868 <concreate+0x9a>
      close(fd);
    4ab4:	00001097          	auipc	ra,0x1
    4ab8:	c3a080e7          	jalr	-966(ra) # 56ee <close>
      wait(&xstatus);
    4abc:	f6c40513          	add	a0,s0,-148
    4ac0:	00001097          	auipc	ra,0x1
    4ac4:	c0e080e7          	jalr	-1010(ra) # 56ce <wait>
      if(xstatus != 0)
    4ac8:	f6c42483          	lw	s1,-148(s0)
    4acc:	da0493e3          	bnez	s1,4872 <concreate+0xa4>
  for(i = 0; i < N; i++){
    4ad0:	2905                	addw	s2,s2,1
    4ad2:	db4905e3          	beq	s2,s4,487c <concreate+0xae>
    file[1] = '0' + i;
    4ad6:	0309079b          	addw	a5,s2,48
    4ada:	faf404a3          	sb	a5,-87(s0)
    unlink(file);
    4ade:	fa840513          	add	a0,s0,-88
    4ae2:	00001097          	auipc	ra,0x1
    4ae6:	c34080e7          	jalr	-972(ra) # 5716 <unlink>
    pid = fork();
    4aea:	00001097          	auipc	ra,0x1
    4aee:	bd4080e7          	jalr	-1068(ra) # 56be <fork>
    if(pid && (i % 3) == 1){
    4af2:	d20502e3          	beqz	a0,4816 <concreate+0x48>
    4af6:	036967bb          	remw	a5,s2,s6
    4afa:	d15786e3          	beq	a5,s5,4806 <concreate+0x38>
      fd = open(file, O_CREATE | O_RDWR);
    4afe:	20200593          	li	a1,514
    4b02:	fa840513          	add	a0,s0,-88
    4b06:	00001097          	auipc	ra,0x1
    4b0a:	c00080e7          	jalr	-1024(ra) # 5706 <open>
      if(fd < 0){
    4b0e:	fa0553e3          	bgez	a0,4ab4 <concreate+0x2e6>
    4b12:	b315                	j	4836 <concreate+0x68>
}
    4b14:	60ea                	ld	ra,152(sp)
    4b16:	644a                	ld	s0,144(sp)
    4b18:	64aa                	ld	s1,136(sp)
    4b1a:	690a                	ld	s2,128(sp)
    4b1c:	79e6                	ld	s3,120(sp)
    4b1e:	7a46                	ld	s4,112(sp)
    4b20:	7aa6                	ld	s5,104(sp)
    4b22:	7b06                	ld	s6,96(sp)
    4b24:	6be6                	ld	s7,88(sp)
    4b26:	610d                	add	sp,sp,160
    4b28:	8082                	ret

0000000000004b2a <bigfile>:
{
    4b2a:	7139                	add	sp,sp,-64
    4b2c:	fc06                	sd	ra,56(sp)
    4b2e:	f822                	sd	s0,48(sp)
    4b30:	f426                	sd	s1,40(sp)
    4b32:	f04a                	sd	s2,32(sp)
    4b34:	ec4e                	sd	s3,24(sp)
    4b36:	e852                	sd	s4,16(sp)
    4b38:	e456                	sd	s5,8(sp)
    4b3a:	0080                	add	s0,sp,64
    4b3c:	8aaa                	mv	s5,a0
  unlink("bigfile.dat");
    4b3e:	00003517          	auipc	a0,0x3
    4b42:	0ca50513          	add	a0,a0,202 # 7c08 <malloc+0x1e8a>
    4b46:	00001097          	auipc	ra,0x1
    4b4a:	bd0080e7          	jalr	-1072(ra) # 5716 <unlink>
  fd = open("bigfile.dat", O_CREATE | O_RDWR);
    4b4e:	20200593          	li	a1,514
    4b52:	00003517          	auipc	a0,0x3
    4b56:	0b650513          	add	a0,a0,182 # 7c08 <malloc+0x1e8a>
    4b5a:	00001097          	auipc	ra,0x1
    4b5e:	bac080e7          	jalr	-1108(ra) # 5706 <open>
    4b62:	89aa                	mv	s3,a0
  for(i = 0; i < N; i++){
    4b64:	4481                	li	s1,0
    memset(buf, i, SZ);
    4b66:	00007917          	auipc	s2,0x7
    4b6a:	2ea90913          	add	s2,s2,746 # be50 <buf>
  for(i = 0; i < N; i++){
    4b6e:	4a51                	li	s4,20
  if(fd < 0){
    4b70:	0a054063          	bltz	a0,4c10 <bigfile+0xe6>
    memset(buf, i, SZ);
    4b74:	25800613          	li	a2,600
    4b78:	85a6                	mv	a1,s1
    4b7a:	854a                	mv	a0,s2
    4b7c:	00001097          	auipc	ra,0x1
    4b80:	950080e7          	jalr	-1712(ra) # 54cc <memset>
    if(write(fd, buf, SZ) != SZ){
    4b84:	25800613          	li	a2,600
    4b88:	85ca                	mv	a1,s2
    4b8a:	854e                	mv	a0,s3
    4b8c:	00001097          	auipc	ra,0x1
    4b90:	b5a080e7          	jalr	-1190(ra) # 56e6 <write>
    4b94:	25800793          	li	a5,600
    4b98:	08f51a63          	bne	a0,a5,4c2c <bigfile+0x102>
  for(i = 0; i < N; i++){
    4b9c:	2485                	addw	s1,s1,1
    4b9e:	fd449be3          	bne	s1,s4,4b74 <bigfile+0x4a>
  close(fd);
    4ba2:	854e                	mv	a0,s3
    4ba4:	00001097          	auipc	ra,0x1
    4ba8:	b4a080e7          	jalr	-1206(ra) # 56ee <close>
  fd = open("bigfile.dat", 0);
    4bac:	4581                	li	a1,0
    4bae:	00003517          	auipc	a0,0x3
    4bb2:	05a50513          	add	a0,a0,90 # 7c08 <malloc+0x1e8a>
    4bb6:	00001097          	auipc	ra,0x1
    4bba:	b50080e7          	jalr	-1200(ra) # 5706 <open>
    4bbe:	8a2a                	mv	s4,a0
  total = 0;
    4bc0:	4981                	li	s3,0
  for(i = 0; ; i++){
    4bc2:	4481                	li	s1,0
    cc = read(fd, buf, SZ/2);
    4bc4:	00007917          	auipc	s2,0x7
    4bc8:	28c90913          	add	s2,s2,652 # be50 <buf>
  if(fd < 0){
    4bcc:	06054e63          	bltz	a0,4c48 <bigfile+0x11e>
    cc = read(fd, buf, SZ/2);
    4bd0:	12c00613          	li	a2,300
    4bd4:	85ca                	mv	a1,s2
    4bd6:	8552                	mv	a0,s4
    4bd8:	00001097          	auipc	ra,0x1
    4bdc:	b06080e7          	jalr	-1274(ra) # 56de <read>
    if(cc < 0){
    4be0:	08054263          	bltz	a0,4c64 <bigfile+0x13a>
    if(cc == 0)
    4be4:	c971                	beqz	a0,4cb8 <bigfile+0x18e>
    if(cc != SZ/2){
    4be6:	12c00793          	li	a5,300
    4bea:	08f51b63          	bne	a0,a5,4c80 <bigfile+0x156>
    if(buf[0] != i/2 || buf[SZ/2-1] != i/2){
    4bee:	01f4d79b          	srlw	a5,s1,0x1f
    4bf2:	9fa5                	addw	a5,a5,s1
    4bf4:	4017d79b          	sraw	a5,a5,0x1
    4bf8:	00094703          	lbu	a4,0(s2)
    4bfc:	0af71063          	bne	a4,a5,4c9c <bigfile+0x172>
    4c00:	12b94703          	lbu	a4,299(s2)
    4c04:	08f71c63          	bne	a4,a5,4c9c <bigfile+0x172>
    total += cc;
    4c08:	12c9899b          	addw	s3,s3,300
  for(i = 0; ; i++){
    4c0c:	2485                	addw	s1,s1,1
    cc = read(fd, buf, SZ/2);
    4c0e:	b7c9                	j	4bd0 <bigfile+0xa6>
    printf("%s: cannot create bigfile", s);
    4c10:	85d6                	mv	a1,s5
    4c12:	00003517          	auipc	a0,0x3
    4c16:	00650513          	add	a0,a0,6 # 7c18 <malloc+0x1e9a>
    4c1a:	00001097          	auipc	ra,0x1
    4c1e:	ee4080e7          	jalr	-284(ra) # 5afe <printf>
    exit(1);
    4c22:	4505                	li	a0,1
    4c24:	00001097          	auipc	ra,0x1
    4c28:	aa2080e7          	jalr	-1374(ra) # 56c6 <exit>
      printf("%s: write bigfile failed\n", s);
    4c2c:	85d6                	mv	a1,s5
    4c2e:	00003517          	auipc	a0,0x3
    4c32:	00a50513          	add	a0,a0,10 # 7c38 <malloc+0x1eba>
    4c36:	00001097          	auipc	ra,0x1
    4c3a:	ec8080e7          	jalr	-312(ra) # 5afe <printf>
      exit(1);
    4c3e:	4505                	li	a0,1
    4c40:	00001097          	auipc	ra,0x1
    4c44:	a86080e7          	jalr	-1402(ra) # 56c6 <exit>
    printf("%s: cannot open bigfile\n", s);
    4c48:	85d6                	mv	a1,s5
    4c4a:	00003517          	auipc	a0,0x3
    4c4e:	00e50513          	add	a0,a0,14 # 7c58 <malloc+0x1eda>
    4c52:	00001097          	auipc	ra,0x1
    4c56:	eac080e7          	jalr	-340(ra) # 5afe <printf>
    exit(1);
    4c5a:	4505                	li	a0,1
    4c5c:	00001097          	auipc	ra,0x1
    4c60:	a6a080e7          	jalr	-1430(ra) # 56c6 <exit>
      printf("%s: read bigfile failed\n", s);
    4c64:	85d6                	mv	a1,s5
    4c66:	00003517          	auipc	a0,0x3
    4c6a:	01250513          	add	a0,a0,18 # 7c78 <malloc+0x1efa>
    4c6e:	00001097          	auipc	ra,0x1
    4c72:	e90080e7          	jalr	-368(ra) # 5afe <printf>
      exit(1);
    4c76:	4505                	li	a0,1
    4c78:	00001097          	auipc	ra,0x1
    4c7c:	a4e080e7          	jalr	-1458(ra) # 56c6 <exit>
      printf("%s: short read bigfile\n", s);
    4c80:	85d6                	mv	a1,s5
    4c82:	00003517          	auipc	a0,0x3
    4c86:	01650513          	add	a0,a0,22 # 7c98 <malloc+0x1f1a>
    4c8a:	00001097          	auipc	ra,0x1
    4c8e:	e74080e7          	jalr	-396(ra) # 5afe <printf>
      exit(1);
    4c92:	4505                	li	a0,1
    4c94:	00001097          	auipc	ra,0x1
    4c98:	a32080e7          	jalr	-1486(ra) # 56c6 <exit>
      printf("%s: read bigfile wrong data\n", s);
    4c9c:	85d6                	mv	a1,s5
    4c9e:	00003517          	auipc	a0,0x3
    4ca2:	01250513          	add	a0,a0,18 # 7cb0 <malloc+0x1f32>
    4ca6:	00001097          	auipc	ra,0x1
    4caa:	e58080e7          	jalr	-424(ra) # 5afe <printf>
      exit(1);
    4cae:	4505                	li	a0,1
    4cb0:	00001097          	auipc	ra,0x1
    4cb4:	a16080e7          	jalr	-1514(ra) # 56c6 <exit>
  close(fd);
    4cb8:	8552                	mv	a0,s4
    4cba:	00001097          	auipc	ra,0x1
    4cbe:	a34080e7          	jalr	-1484(ra) # 56ee <close>
  if(total != N*SZ){
    4cc2:	678d                	lui	a5,0x3
    4cc4:	ee078793          	add	a5,a5,-288 # 2ee0 <iputtest+0xc6>
    4cc8:	02f99363          	bne	s3,a5,4cee <bigfile+0x1c4>
  unlink("bigfile.dat");
    4ccc:	00003517          	auipc	a0,0x3
    4cd0:	f3c50513          	add	a0,a0,-196 # 7c08 <malloc+0x1e8a>
    4cd4:	00001097          	auipc	ra,0x1
    4cd8:	a42080e7          	jalr	-1470(ra) # 5716 <unlink>
}
    4cdc:	70e2                	ld	ra,56(sp)
    4cde:	7442                	ld	s0,48(sp)
    4ce0:	74a2                	ld	s1,40(sp)
    4ce2:	7902                	ld	s2,32(sp)
    4ce4:	69e2                	ld	s3,24(sp)
    4ce6:	6a42                	ld	s4,16(sp)
    4ce8:	6aa2                	ld	s5,8(sp)
    4cea:	6121                	add	sp,sp,64
    4cec:	8082                	ret
    printf("%s: read bigfile wrong total\n", s);
    4cee:	85d6                	mv	a1,s5
    4cf0:	00003517          	auipc	a0,0x3
    4cf4:	fe050513          	add	a0,a0,-32 # 7cd0 <malloc+0x1f52>
    4cf8:	00001097          	auipc	ra,0x1
    4cfc:	e06080e7          	jalr	-506(ra) # 5afe <printf>
    exit(1);
    4d00:	4505                	li	a0,1
    4d02:	00001097          	auipc	ra,0x1
    4d06:	9c4080e7          	jalr	-1596(ra) # 56c6 <exit>

0000000000004d0a <fsfull>:
{
    4d0a:	7135                	add	sp,sp,-160
    4d0c:	ed06                	sd	ra,152(sp)
    4d0e:	e922                	sd	s0,144(sp)
    4d10:	e526                	sd	s1,136(sp)
    4d12:	e14a                	sd	s2,128(sp)
    4d14:	fcce                	sd	s3,120(sp)
    4d16:	f8d2                	sd	s4,112(sp)
    4d18:	f4d6                	sd	s5,104(sp)
    4d1a:	f0da                	sd	s6,96(sp)
    4d1c:	ecde                	sd	s7,88(sp)
    4d1e:	e8e2                	sd	s8,80(sp)
    4d20:	e4e6                	sd	s9,72(sp)
    4d22:	e0ea                	sd	s10,64(sp)
    4d24:	1100                	add	s0,sp,160
  printf("fsfull test\n");
    4d26:	00003517          	auipc	a0,0x3
    4d2a:	fca50513          	add	a0,a0,-54 # 7cf0 <malloc+0x1f72>
    4d2e:	00001097          	auipc	ra,0x1
    4d32:	dd0080e7          	jalr	-560(ra) # 5afe <printf>
  for(nfiles = 0; ; nfiles++){
    4d36:	4481                	li	s1,0
    name[0] = 'f';
    4d38:	06600d13          	li	s10,102
    name[1] = '0' + nfiles / 1000;
    4d3c:	3e800c13          	li	s8,1000
    name[2] = '0' + (nfiles % 1000) / 100;
    4d40:	06400b93          	li	s7,100
    name[3] = '0' + (nfiles % 100) / 10;
    4d44:	4b29                	li	s6,10
    printf("writing %s\n", name);
    4d46:	00003c97          	auipc	s9,0x3
    4d4a:	fbac8c93          	add	s9,s9,-70 # 7d00 <malloc+0x1f82>
    name[0] = 'f';
    4d4e:	f7a40023          	sb	s10,-160(s0)
    name[1] = '0' + nfiles / 1000;
    4d52:	0384c7bb          	divw	a5,s1,s8
    4d56:	0307879b          	addw	a5,a5,48
    4d5a:	f6f400a3          	sb	a5,-159(s0)
    name[2] = '0' + (nfiles % 1000) / 100;
    4d5e:	0384e7bb          	remw	a5,s1,s8
    4d62:	0377c7bb          	divw	a5,a5,s7
    4d66:	0307879b          	addw	a5,a5,48
    4d6a:	f6f40123          	sb	a5,-158(s0)
    name[3] = '0' + (nfiles % 100) / 10;
    4d6e:	0374e7bb          	remw	a5,s1,s7
    4d72:	0367c7bb          	divw	a5,a5,s6
    4d76:	0307879b          	addw	a5,a5,48
    4d7a:	f6f401a3          	sb	a5,-157(s0)
    name[4] = '0' + (nfiles % 10);
    4d7e:	0364e7bb          	remw	a5,s1,s6
    4d82:	0307879b          	addw	a5,a5,48
    4d86:	f6f40223          	sb	a5,-156(s0)
    name[5] = '\0';
    4d8a:	f60402a3          	sb	zero,-155(s0)
    printf("writing %s\n", name);
    4d8e:	f6040593          	add	a1,s0,-160
    4d92:	8566                	mv	a0,s9
    4d94:	00001097          	auipc	ra,0x1
    4d98:	d6a080e7          	jalr	-662(ra) # 5afe <printf>
    int fd = open(name, O_CREATE|O_RDWR);
    4d9c:	20200593          	li	a1,514
    4da0:	f6040513          	add	a0,s0,-160
    4da4:	00001097          	auipc	ra,0x1
    4da8:	962080e7          	jalr	-1694(ra) # 5706 <open>
    4dac:	892a                	mv	s2,a0
    if(fd < 0){
    4dae:	0a055563          	bgez	a0,4e58 <fsfull+0x14e>
      printf("open %s failed\n", name);
    4db2:	f6040593          	add	a1,s0,-160
    4db6:	00003517          	auipc	a0,0x3
    4dba:	f5a50513          	add	a0,a0,-166 # 7d10 <malloc+0x1f92>
    4dbe:	00001097          	auipc	ra,0x1
    4dc2:	d40080e7          	jalr	-704(ra) # 5afe <printf>
  while(nfiles >= 0){
    4dc6:	0604c363          	bltz	s1,4e2c <fsfull+0x122>
    name[0] = 'f';
    4dca:	06600b13          	li	s6,102
    name[1] = '0' + nfiles / 1000;
    4dce:	3e800a13          	li	s4,1000
    name[2] = '0' + (nfiles % 1000) / 100;
    4dd2:	06400993          	li	s3,100
    name[3] = '0' + (nfiles % 100) / 10;
    4dd6:	4929                	li	s2,10
  while(nfiles >= 0){
    4dd8:	5afd                	li	s5,-1
    name[0] = 'f';
    4dda:	f7640023          	sb	s6,-160(s0)
    name[1] = '0' + nfiles / 1000;
    4dde:	0344c7bb          	divw	a5,s1,s4
    4de2:	0307879b          	addw	a5,a5,48
    4de6:	f6f400a3          	sb	a5,-159(s0)
    name[2] = '0' + (nfiles % 1000) / 100;
    4dea:	0344e7bb          	remw	a5,s1,s4
    4dee:	0337c7bb          	divw	a5,a5,s3
    4df2:	0307879b          	addw	a5,a5,48
    4df6:	f6f40123          	sb	a5,-158(s0)
    name[3] = '0' + (nfiles % 100) / 10;
    4dfa:	0334e7bb          	remw	a5,s1,s3
    4dfe:	0327c7bb          	divw	a5,a5,s2
    4e02:	0307879b          	addw	a5,a5,48
    4e06:	f6f401a3          	sb	a5,-157(s0)
    name[4] = '0' + (nfiles % 10);
    4e0a:	0324e7bb          	remw	a5,s1,s2
    4e0e:	0307879b          	addw	a5,a5,48
    4e12:	f6f40223          	sb	a5,-156(s0)
    name[5] = '\0';
    4e16:	f60402a3          	sb	zero,-155(s0)
    unlink(name);
    4e1a:	f6040513          	add	a0,s0,-160
    4e1e:	00001097          	auipc	ra,0x1
    4e22:	8f8080e7          	jalr	-1800(ra) # 5716 <unlink>
    nfiles--;
    4e26:	34fd                	addw	s1,s1,-1
  while(nfiles >= 0){
    4e28:	fb5499e3          	bne	s1,s5,4dda <fsfull+0xd0>
  printf("fsfull test finished\n");
    4e2c:	00003517          	auipc	a0,0x3
    4e30:	f0450513          	add	a0,a0,-252 # 7d30 <malloc+0x1fb2>
    4e34:	00001097          	auipc	ra,0x1
    4e38:	cca080e7          	jalr	-822(ra) # 5afe <printf>
}
    4e3c:	60ea                	ld	ra,152(sp)
    4e3e:	644a                	ld	s0,144(sp)
    4e40:	64aa                	ld	s1,136(sp)
    4e42:	690a                	ld	s2,128(sp)
    4e44:	79e6                	ld	s3,120(sp)
    4e46:	7a46                	ld	s4,112(sp)
    4e48:	7aa6                	ld	s5,104(sp)
    4e4a:	7b06                	ld	s6,96(sp)
    4e4c:	6be6                	ld	s7,88(sp)
    4e4e:	6c46                	ld	s8,80(sp)
    4e50:	6ca6                	ld	s9,72(sp)
    4e52:	6d06                	ld	s10,64(sp)
    4e54:	610d                	add	sp,sp,160
    4e56:	8082                	ret
    int total = 0;
    4e58:	4981                	li	s3,0
      int cc = write(fd, buf, BSIZE);
    4e5a:	00007a97          	auipc	s5,0x7
    4e5e:	ff6a8a93          	add	s5,s5,-10 # be50 <buf>
      if(cc < BSIZE)
    4e62:	3ff00a13          	li	s4,1023
      int cc = write(fd, buf, BSIZE);
    4e66:	40000613          	li	a2,1024
    4e6a:	85d6                	mv	a1,s5
    4e6c:	854a                	mv	a0,s2
    4e6e:	00001097          	auipc	ra,0x1
    4e72:	878080e7          	jalr	-1928(ra) # 56e6 <write>
      if(cc < BSIZE)
    4e76:	00aa5563          	bge	s4,a0,4e80 <fsfull+0x176>
      total += cc;
    4e7a:	00a989bb          	addw	s3,s3,a0
    while(1){
    4e7e:	b7e5                	j	4e66 <fsfull+0x15c>
    printf("wrote %d bytes\n", total);
    4e80:	85ce                	mv	a1,s3
    4e82:	00003517          	auipc	a0,0x3
    4e86:	e9e50513          	add	a0,a0,-354 # 7d20 <malloc+0x1fa2>
    4e8a:	00001097          	auipc	ra,0x1
    4e8e:	c74080e7          	jalr	-908(ra) # 5afe <printf>
    close(fd);
    4e92:	854a                	mv	a0,s2
    4e94:	00001097          	auipc	ra,0x1
    4e98:	85a080e7          	jalr	-1958(ra) # 56ee <close>
    if(total == 0)
    4e9c:	f20985e3          	beqz	s3,4dc6 <fsfull+0xbc>
  for(nfiles = 0; ; nfiles++){
    4ea0:	2485                	addw	s1,s1,1
    4ea2:	b575                	j	4d4e <fsfull+0x44>

0000000000004ea4 <rand>:
{
    4ea4:	1141                	add	sp,sp,-16
    4ea6:	e422                	sd	s0,8(sp)
    4ea8:	0800                	add	s0,sp,16
  randstate = randstate * 1664525 + 1013904223;
    4eaa:	00003717          	auipc	a4,0x3
    4eae:	77e70713          	add	a4,a4,1918 # 8628 <randstate>
    4eb2:	6308                	ld	a0,0(a4)
    4eb4:	001967b7          	lui	a5,0x196
    4eb8:	60d78793          	add	a5,a5,1549 # 19660d <__BSS_END__+0x1877ad>
    4ebc:	02f50533          	mul	a0,a0,a5
    4ec0:	3c6ef7b7          	lui	a5,0x3c6ef
    4ec4:	35f78793          	add	a5,a5,863 # 3c6ef35f <__BSS_END__+0x3c6e04ff>
    4ec8:	953e                	add	a0,a0,a5
    4eca:	e308                	sd	a0,0(a4)
}
    4ecc:	2501                	sext.w	a0,a0
    4ece:	6422                	ld	s0,8(sp)
    4ed0:	0141                	add	sp,sp,16
    4ed2:	8082                	ret

0000000000004ed4 <badwrite>:
{
    4ed4:	7179                	add	sp,sp,-48
    4ed6:	f406                	sd	ra,40(sp)
    4ed8:	f022                	sd	s0,32(sp)
    4eda:	ec26                	sd	s1,24(sp)
    4edc:	e84a                	sd	s2,16(sp)
    4ede:	e44e                	sd	s3,8(sp)
    4ee0:	e052                	sd	s4,0(sp)
    4ee2:	1800                	add	s0,sp,48
  unlink("junk");
    4ee4:	00003517          	auipc	a0,0x3
    4ee8:	e6450513          	add	a0,a0,-412 # 7d48 <malloc+0x1fca>
    4eec:	00001097          	auipc	ra,0x1
    4ef0:	82a080e7          	jalr	-2006(ra) # 5716 <unlink>
    4ef4:	25800913          	li	s2,600
    int fd = open("junk", O_CREATE|O_WRONLY);
    4ef8:	00003997          	auipc	s3,0x3
    4efc:	e5098993          	add	s3,s3,-432 # 7d48 <malloc+0x1fca>
    write(fd, (char*)0xffffffffffL, 1);
    4f00:	5a7d                	li	s4,-1
    4f02:	018a5a13          	srl	s4,s4,0x18
    int fd = open("junk", O_CREATE|O_WRONLY);
    4f06:	20100593          	li	a1,513
    4f0a:	854e                	mv	a0,s3
    4f0c:	00000097          	auipc	ra,0x0
    4f10:	7fa080e7          	jalr	2042(ra) # 5706 <open>
    4f14:	84aa                	mv	s1,a0
    if(fd < 0){
    4f16:	06054b63          	bltz	a0,4f8c <badwrite+0xb8>
    write(fd, (char*)0xffffffffffL, 1);
    4f1a:	4605                	li	a2,1
    4f1c:	85d2                	mv	a1,s4
    4f1e:	00000097          	auipc	ra,0x0
    4f22:	7c8080e7          	jalr	1992(ra) # 56e6 <write>
    close(fd);
    4f26:	8526                	mv	a0,s1
    4f28:	00000097          	auipc	ra,0x0
    4f2c:	7c6080e7          	jalr	1990(ra) # 56ee <close>
    unlink("junk");
    4f30:	854e                	mv	a0,s3
    4f32:	00000097          	auipc	ra,0x0
    4f36:	7e4080e7          	jalr	2020(ra) # 5716 <unlink>
  for(int i = 0; i < assumed_free; i++){
    4f3a:	397d                	addw	s2,s2,-1
    4f3c:	fc0915e3          	bnez	s2,4f06 <badwrite+0x32>
  int fd = open("junk", O_CREATE|O_WRONLY);
    4f40:	20100593          	li	a1,513
    4f44:	00003517          	auipc	a0,0x3
    4f48:	e0450513          	add	a0,a0,-508 # 7d48 <malloc+0x1fca>
    4f4c:	00000097          	auipc	ra,0x0
    4f50:	7ba080e7          	jalr	1978(ra) # 5706 <open>
    4f54:	84aa                	mv	s1,a0
  if(fd < 0){
    4f56:	04054863          	bltz	a0,4fa6 <badwrite+0xd2>
  if(write(fd, "x", 1) != 1){
    4f5a:	4605                	li	a2,1
    4f5c:	00001597          	auipc	a1,0x1
    4f60:	fcc58593          	add	a1,a1,-52 # 5f28 <malloc+0x1aa>
    4f64:	00000097          	auipc	ra,0x0
    4f68:	782080e7          	jalr	1922(ra) # 56e6 <write>
    4f6c:	4785                	li	a5,1
    4f6e:	04f50963          	beq	a0,a5,4fc0 <badwrite+0xec>
    printf("write failed\n");
    4f72:	00003517          	auipc	a0,0x3
    4f76:	df650513          	add	a0,a0,-522 # 7d68 <malloc+0x1fea>
    4f7a:	00001097          	auipc	ra,0x1
    4f7e:	b84080e7          	jalr	-1148(ra) # 5afe <printf>
    exit(1);
    4f82:	4505                	li	a0,1
    4f84:	00000097          	auipc	ra,0x0
    4f88:	742080e7          	jalr	1858(ra) # 56c6 <exit>
      printf("open junk failed\n");
    4f8c:	00003517          	auipc	a0,0x3
    4f90:	dc450513          	add	a0,a0,-572 # 7d50 <malloc+0x1fd2>
    4f94:	00001097          	auipc	ra,0x1
    4f98:	b6a080e7          	jalr	-1174(ra) # 5afe <printf>
      exit(1);
    4f9c:	4505                	li	a0,1
    4f9e:	00000097          	auipc	ra,0x0
    4fa2:	728080e7          	jalr	1832(ra) # 56c6 <exit>
    printf("open junk failed\n");
    4fa6:	00003517          	auipc	a0,0x3
    4faa:	daa50513          	add	a0,a0,-598 # 7d50 <malloc+0x1fd2>
    4fae:	00001097          	auipc	ra,0x1
    4fb2:	b50080e7          	jalr	-1200(ra) # 5afe <printf>
    exit(1);
    4fb6:	4505                	li	a0,1
    4fb8:	00000097          	auipc	ra,0x0
    4fbc:	70e080e7          	jalr	1806(ra) # 56c6 <exit>
  close(fd);
    4fc0:	8526                	mv	a0,s1
    4fc2:	00000097          	auipc	ra,0x0
    4fc6:	72c080e7          	jalr	1836(ra) # 56ee <close>
  unlink("junk");
    4fca:	00003517          	auipc	a0,0x3
    4fce:	d7e50513          	add	a0,a0,-642 # 7d48 <malloc+0x1fca>
    4fd2:	00000097          	auipc	ra,0x0
    4fd6:	744080e7          	jalr	1860(ra) # 5716 <unlink>
  exit(0);
    4fda:	4501                	li	a0,0
    4fdc:	00000097          	auipc	ra,0x0
    4fe0:	6ea080e7          	jalr	1770(ra) # 56c6 <exit>

0000000000004fe4 <countfree>:
// because out of memory with lazy allocation results in the process
// taking a fault and being killed, fork and report back.
//
int
countfree()
{
    4fe4:	7139                	add	sp,sp,-64
    4fe6:	fc06                	sd	ra,56(sp)
    4fe8:	f822                	sd	s0,48(sp)
    4fea:	0080                	add	s0,sp,64
  int fds[2];

  if(pipe(fds) < 0){
    4fec:	fc840513          	add	a0,s0,-56
    4ff0:	00000097          	auipc	ra,0x0
    4ff4:	6e6080e7          	jalr	1766(ra) # 56d6 <pipe>
    4ff8:	06054a63          	bltz	a0,506c <countfree+0x88>
    printf("pipe() failed in countfree()\n");
    exit(1);
  }
  
  int pid = fork();
    4ffc:	00000097          	auipc	ra,0x0
    5000:	6c2080e7          	jalr	1730(ra) # 56be <fork>

  if(pid < 0){
    5004:	08054463          	bltz	a0,508c <countfree+0xa8>
    printf("fork failed in countfree()\n");
    exit(1);
  }

  if(pid == 0){
    5008:	e55d                	bnez	a0,50b6 <countfree+0xd2>
    500a:	f426                	sd	s1,40(sp)
    500c:	f04a                	sd	s2,32(sp)
    500e:	ec4e                	sd	s3,24(sp)
    close(fds[0]);
    5010:	fc842503          	lw	a0,-56(s0)
    5014:	00000097          	auipc	ra,0x0
    5018:	6da080e7          	jalr	1754(ra) # 56ee <close>
    
    while(1){
      uint64 a = (uint64) sbrk(4096);
      if(a == 0xffffffffffffffff){
    501c:	597d                	li	s2,-1
        break;
      }

      // modify the memory to make sure it's really allocated.
      *(char *)(a + 4096 - 1) = 1;
    501e:	4485                	li	s1,1

      // report back one more page.
      if(write(fds[1], "x", 1) != 1){
    5020:	00001997          	auipc	s3,0x1
    5024:	f0898993          	add	s3,s3,-248 # 5f28 <malloc+0x1aa>
      uint64 a = (uint64) sbrk(4096);
    5028:	6505                	lui	a0,0x1
    502a:	00000097          	auipc	ra,0x0
    502e:	724080e7          	jalr	1828(ra) # 574e <sbrk>
      if(a == 0xffffffffffffffff){
    5032:	07250d63          	beq	a0,s2,50ac <countfree+0xc8>
      *(char *)(a + 4096 - 1) = 1;
    5036:	6785                	lui	a5,0x1
    5038:	97aa                	add	a5,a5,a0
    503a:	fe978fa3          	sb	s1,-1(a5) # fff <bigdir+0x9f>
      if(write(fds[1], "x", 1) != 1){
    503e:	8626                	mv	a2,s1
    5040:	85ce                	mv	a1,s3
    5042:	fcc42503          	lw	a0,-52(s0)
    5046:	00000097          	auipc	ra,0x0
    504a:	6a0080e7          	jalr	1696(ra) # 56e6 <write>
    504e:	fc950de3          	beq	a0,s1,5028 <countfree+0x44>
        printf("write() failed in countfree()\n");
    5052:	00003517          	auipc	a0,0x3
    5056:	d6650513          	add	a0,a0,-666 # 7db8 <malloc+0x203a>
    505a:	00001097          	auipc	ra,0x1
    505e:	aa4080e7          	jalr	-1372(ra) # 5afe <printf>
        exit(1);
    5062:	4505                	li	a0,1
    5064:	00000097          	auipc	ra,0x0
    5068:	662080e7          	jalr	1634(ra) # 56c6 <exit>
    506c:	f426                	sd	s1,40(sp)
    506e:	f04a                	sd	s2,32(sp)
    5070:	ec4e                	sd	s3,24(sp)
    printf("pipe() failed in countfree()\n");
    5072:	00003517          	auipc	a0,0x3
    5076:	d0650513          	add	a0,a0,-762 # 7d78 <malloc+0x1ffa>
    507a:	00001097          	auipc	ra,0x1
    507e:	a84080e7          	jalr	-1404(ra) # 5afe <printf>
    exit(1);
    5082:	4505                	li	a0,1
    5084:	00000097          	auipc	ra,0x0
    5088:	642080e7          	jalr	1602(ra) # 56c6 <exit>
    508c:	f426                	sd	s1,40(sp)
    508e:	f04a                	sd	s2,32(sp)
    5090:	ec4e                	sd	s3,24(sp)
    printf("fork failed in countfree()\n");
    5092:	00003517          	auipc	a0,0x3
    5096:	d0650513          	add	a0,a0,-762 # 7d98 <malloc+0x201a>
    509a:	00001097          	auipc	ra,0x1
    509e:	a64080e7          	jalr	-1436(ra) # 5afe <printf>
    exit(1);
    50a2:	4505                	li	a0,1
    50a4:	00000097          	auipc	ra,0x0
    50a8:	622080e7          	jalr	1570(ra) # 56c6 <exit>
      }
    }

    exit(0);
    50ac:	4501                	li	a0,0
    50ae:	00000097          	auipc	ra,0x0
    50b2:	618080e7          	jalr	1560(ra) # 56c6 <exit>
    50b6:	f426                	sd	s1,40(sp)
  }

  close(fds[1]);
    50b8:	fcc42503          	lw	a0,-52(s0)
    50bc:	00000097          	auipc	ra,0x0
    50c0:	632080e7          	jalr	1586(ra) # 56ee <close>

  int n = 0;
    50c4:	4481                	li	s1,0
  while(1){
    char c;
    int cc = read(fds[0], &c, 1);
    50c6:	4605                	li	a2,1
    50c8:	fc740593          	add	a1,s0,-57
    50cc:	fc842503          	lw	a0,-56(s0)
    50d0:	00000097          	auipc	ra,0x0
    50d4:	60e080e7          	jalr	1550(ra) # 56de <read>
    if(cc < 0){
    50d8:	00054563          	bltz	a0,50e2 <countfree+0xfe>
      printf("read() failed in countfree()\n");
      exit(1);
    }
    if(cc == 0)
    50dc:	c115                	beqz	a0,5100 <countfree+0x11c>
      break;
    n += 1;
    50de:	2485                	addw	s1,s1,1
  while(1){
    50e0:	b7dd                	j	50c6 <countfree+0xe2>
    50e2:	f04a                	sd	s2,32(sp)
    50e4:	ec4e                	sd	s3,24(sp)
      printf("read() failed in countfree()\n");
    50e6:	00003517          	auipc	a0,0x3
    50ea:	cf250513          	add	a0,a0,-782 # 7dd8 <malloc+0x205a>
    50ee:	00001097          	auipc	ra,0x1
    50f2:	a10080e7          	jalr	-1520(ra) # 5afe <printf>
      exit(1);
    50f6:	4505                	li	a0,1
    50f8:	00000097          	auipc	ra,0x0
    50fc:	5ce080e7          	jalr	1486(ra) # 56c6 <exit>
  }

  close(fds[0]);
    5100:	fc842503          	lw	a0,-56(s0)
    5104:	00000097          	auipc	ra,0x0
    5108:	5ea080e7          	jalr	1514(ra) # 56ee <close>
  wait((int*)0);
    510c:	4501                	li	a0,0
    510e:	00000097          	auipc	ra,0x0
    5112:	5c0080e7          	jalr	1472(ra) # 56ce <wait>
  
  return n;
}
    5116:	8526                	mv	a0,s1
    5118:	74a2                	ld	s1,40(sp)
    511a:	70e2                	ld	ra,56(sp)
    511c:	7442                	ld	s0,48(sp)
    511e:	6121                	add	sp,sp,64
    5120:	8082                	ret

0000000000005122 <run>:

// run each test in its own process. run returns 1 if child's exit()
// indicates success.
int
run(void f(char *), char *s) {
    5122:	7179                	add	sp,sp,-48
    5124:	f406                	sd	ra,40(sp)
    5126:	f022                	sd	s0,32(sp)
    5128:	ec26                	sd	s1,24(sp)
    512a:	e84a                	sd	s2,16(sp)
    512c:	1800                	add	s0,sp,48
    512e:	84aa                	mv	s1,a0
    5130:	892e                	mv	s2,a1
  int pid;
  int xstatus;

  printf("test %s: ", s);
    5132:	00003517          	auipc	a0,0x3
    5136:	cc650513          	add	a0,a0,-826 # 7df8 <malloc+0x207a>
    513a:	00001097          	auipc	ra,0x1
    513e:	9c4080e7          	jalr	-1596(ra) # 5afe <printf>
  if((pid = fork()) < 0) {
    5142:	00000097          	auipc	ra,0x0
    5146:	57c080e7          	jalr	1404(ra) # 56be <fork>
    514a:	02054e63          	bltz	a0,5186 <run+0x64>
    printf("runtest: fork error\n");
    exit(1);
  }
  if(pid == 0) {
    514e:	c929                	beqz	a0,51a0 <run+0x7e>
    f(s);
    exit(0);
  } else {
    wait(&xstatus);
    5150:	fdc40513          	add	a0,s0,-36
    5154:	00000097          	auipc	ra,0x0
    5158:	57a080e7          	jalr	1402(ra) # 56ce <wait>
    if(xstatus != 0) 
    515c:	fdc42783          	lw	a5,-36(s0)
    5160:	c7b9                	beqz	a5,51ae <run+0x8c>
      printf("FAILED\n");
    5162:	00003517          	auipc	a0,0x3
    5166:	cbe50513          	add	a0,a0,-834 # 7e20 <malloc+0x20a2>
    516a:	00001097          	auipc	ra,0x1
    516e:	994080e7          	jalr	-1644(ra) # 5afe <printf>
    else
      printf("OK\n");
    return xstatus == 0;
    5172:	fdc42503          	lw	a0,-36(s0)
  }
}
    5176:	00153513          	seqz	a0,a0
    517a:	70a2                	ld	ra,40(sp)
    517c:	7402                	ld	s0,32(sp)
    517e:	64e2                	ld	s1,24(sp)
    5180:	6942                	ld	s2,16(sp)
    5182:	6145                	add	sp,sp,48
    5184:	8082                	ret
    printf("runtest: fork error\n");
    5186:	00003517          	auipc	a0,0x3
    518a:	c8250513          	add	a0,a0,-894 # 7e08 <malloc+0x208a>
    518e:	00001097          	auipc	ra,0x1
    5192:	970080e7          	jalr	-1680(ra) # 5afe <printf>
    exit(1);
    5196:	4505                	li	a0,1
    5198:	00000097          	auipc	ra,0x0
    519c:	52e080e7          	jalr	1326(ra) # 56c6 <exit>
    f(s);
    51a0:	854a                	mv	a0,s2
    51a2:	9482                	jalr	s1
    exit(0);
    51a4:	4501                	li	a0,0
    51a6:	00000097          	auipc	ra,0x0
    51aa:	520080e7          	jalr	1312(ra) # 56c6 <exit>
      printf("OK\n");
    51ae:	00003517          	auipc	a0,0x3
    51b2:	c7a50513          	add	a0,a0,-902 # 7e28 <malloc+0x20aa>
    51b6:	00001097          	auipc	ra,0x1
    51ba:	948080e7          	jalr	-1720(ra) # 5afe <printf>
    51be:	bf55                	j	5172 <run+0x50>

00000000000051c0 <main>:

int
main(int argc, char *argv[])
{
    51c0:	c1010113          	add	sp,sp,-1008
    51c4:	3e113423          	sd	ra,1000(sp)
    51c8:	3e813023          	sd	s0,992(sp)
    51cc:	3d313423          	sd	s3,968(sp)
    51d0:	1f80                	add	s0,sp,1008
    51d2:	89aa                	mv	s3,a0
  int continuous = 0;
  char *justone = 0;

  if(argc == 2 && strcmp(argv[1], "-c") == 0){
    51d4:	4789                	li	a5,2
    51d6:	0af50663          	beq	a0,a5,5282 <main+0xc2>
    continuous = 1;
  } else if(argc == 2 && strcmp(argv[1], "-C") == 0){
    continuous = 2;
  } else if(argc == 2 && argv[1][0] != '-'){
    justone = argv[1];
  } else if(argc > 1){
    51da:	4785                	li	a5,1
    51dc:	14a7ca63          	blt	a5,a0,5330 <main+0x170>
  char *justone = 0;
    51e0:	4981                	li	s3,0
    51e2:	3c913c23          	sd	s1,984(sp)
    51e6:	3d213823          	sd	s2,976(sp)
    51ea:	3d413023          	sd	s4,960(sp)
    51ee:	3b513c23          	sd	s5,952(sp)
    51f2:	3b613823          	sd	s6,944(sp)
  }
  
  struct test {
    void (*f)(char *);
    char *s;
  } tests[] = {
    51f6:	00003797          	auipc	a5,0x3
    51fa:	01278793          	add	a5,a5,18 # 8208 <malloc+0x248a>
    51fe:	c1040713          	add	a4,s0,-1008
    5202:	00003817          	auipc	a6,0x3
    5206:	3a680813          	add	a6,a6,934 # 85a8 <malloc+0x282a>
    520a:	6388                	ld	a0,0(a5)
    520c:	678c                	ld	a1,8(a5)
    520e:	6b90                	ld	a2,16(a5)
    5210:	6f94                	ld	a3,24(a5)
    5212:	e308                	sd	a0,0(a4)
    5214:	e70c                	sd	a1,8(a4)
    5216:	eb10                	sd	a2,16(a4)
    5218:	ef14                	sd	a3,24(a4)
    521a:	02078793          	add	a5,a5,32
    521e:	02070713          	add	a4,a4,32
    5222:	ff0794e3          	bne	a5,a6,520a <main+0x4a>
    5226:	6394                	ld	a3,0(a5)
    5228:	679c                	ld	a5,8(a5)
    522a:	e314                	sd	a3,0(a4)
    522c:	e71c                	sd	a5,8(a4)
          exit(1);
      }
    }
  }

  printf("usertests starting\n");
    522e:	00003517          	auipc	a0,0x3
    5232:	cba50513          	add	a0,a0,-838 # 7ee8 <malloc+0x216a>
    5236:	00001097          	auipc	ra,0x1
    523a:	8c8080e7          	jalr	-1848(ra) # 5afe <printf>
  int free0 = countfree();
    523e:	00000097          	auipc	ra,0x0
    5242:	da6080e7          	jalr	-602(ra) # 4fe4 <countfree>
    5246:	8aaa                	mv	s5,a0
  int free1 = 0;
  int fail = 0;
  for (struct test *t = tests; t->s != 0; t++) {
    5248:	c1843903          	ld	s2,-1000(s0)
    524c:	c1040493          	add	s1,s0,-1008
  int fail = 0;
    5250:	4a01                	li	s4,0
    if((justone == 0) || strcmp(t->s, justone) == 0) {
      if(!run(t->f, t->s))
        fail = 1;
    5252:	4b05                	li	s6,1
  for (struct test *t = tests; t->s != 0; t++) {
    5254:	12091d63          	bnez	s2,538e <main+0x1ce>
  }

  if(fail){
    printf("SOME TESTS FAILED\n");
    exit(1);
  } else if((free1 = countfree()) < free0){
    5258:	00000097          	auipc	ra,0x0
    525c:	d8c080e7          	jalr	-628(ra) # 4fe4 <countfree>
    5260:	85aa                	mv	a1,a0
    5262:	17555763          	bge	a0,s5,53d0 <main+0x210>
    printf("FAILED -- lost some free pages %d (out of %d)\n", free1, free0);
    5266:	8656                	mv	a2,s5
    5268:	00003517          	auipc	a0,0x3
    526c:	c3850513          	add	a0,a0,-968 # 7ea0 <malloc+0x2122>
    5270:	00001097          	auipc	ra,0x1
    5274:	88e080e7          	jalr	-1906(ra) # 5afe <printf>
    exit(1);
    5278:	4505                	li	a0,1
    527a:	00000097          	auipc	ra,0x0
    527e:	44c080e7          	jalr	1100(ra) # 56c6 <exit>
    5282:	3c913c23          	sd	s1,984(sp)
    5286:	3d213823          	sd	s2,976(sp)
    528a:	3d413023          	sd	s4,960(sp)
    528e:	3b513c23          	sd	s5,952(sp)
    5292:	3b613823          	sd	s6,944(sp)
    5296:	84ae                	mv	s1,a1
  if(argc == 2 && strcmp(argv[1], "-c") == 0){
    5298:	00003597          	auipc	a1,0x3
    529c:	b9858593          	add	a1,a1,-1128 # 7e30 <malloc+0x20b2>
    52a0:	6488                	ld	a0,8(s1)
    52a2:	00000097          	auipc	ra,0x0
    52a6:	1a6080e7          	jalr	422(ra) # 5448 <strcmp>
    52aa:	e125                	bnez	a0,530a <main+0x14a>
    continuous = 1;
    52ac:	4985                	li	s3,1
  } tests[] = {
    52ae:	00003797          	auipc	a5,0x3
    52b2:	f5a78793          	add	a5,a5,-166 # 8208 <malloc+0x248a>
    52b6:	c1040713          	add	a4,s0,-1008
    52ba:	00003817          	auipc	a6,0x3
    52be:	2ee80813          	add	a6,a6,750 # 85a8 <malloc+0x282a>
    52c2:	6388                	ld	a0,0(a5)
    52c4:	678c                	ld	a1,8(a5)
    52c6:	6b90                	ld	a2,16(a5)
    52c8:	6f94                	ld	a3,24(a5)
    52ca:	e308                	sd	a0,0(a4)
    52cc:	e70c                	sd	a1,8(a4)
    52ce:	eb10                	sd	a2,16(a4)
    52d0:	ef14                	sd	a3,24(a4)
    52d2:	02078793          	add	a5,a5,32
    52d6:	02070713          	add	a4,a4,32
    52da:	ff0794e3          	bne	a5,a6,52c2 <main+0x102>
    52de:	6394                	ld	a3,0(a5)
    52e0:	679c                	ld	a5,8(a5)
    52e2:	e314                	sd	a3,0(a4)
    52e4:	e71c                	sd	a5,8(a4)
    printf("continuous usertests starting\n");
    52e6:	00003517          	auipc	a0,0x3
    52ea:	c1a50513          	add	a0,a0,-998 # 7f00 <malloc+0x2182>
    52ee:	00001097          	auipc	ra,0x1
    52f2:	810080e7          	jalr	-2032(ra) # 5afe <printf>
        printf("SOME TESTS FAILED\n");
    52f6:	00003a97          	auipc	s5,0x3
    52fa:	b92a8a93          	add	s5,s5,-1134 # 7e88 <malloc+0x210a>
        if(continuous != 2)
    52fe:	4a09                	li	s4,2
        printf("FAILED -- lost %d free pages\n", free0 - free1);
    5300:	00003b17          	auipc	s6,0x3
    5304:	b68b0b13          	add	s6,s6,-1176 # 7e68 <malloc+0x20ea>
    5308:	a8f5                	j	5404 <main+0x244>
  } else if(argc == 2 && strcmp(argv[1], "-C") == 0){
    530a:	00003597          	auipc	a1,0x3
    530e:	b2e58593          	add	a1,a1,-1234 # 7e38 <malloc+0x20ba>
    5312:	6488                	ld	a0,8(s1)
    5314:	00000097          	auipc	ra,0x0
    5318:	134080e7          	jalr	308(ra) # 5448 <strcmp>
    531c:	d949                	beqz	a0,52ae <main+0xee>
  } else if(argc == 2 && argv[1][0] != '-'){
    531e:	0084b983          	ld	s3,8(s1)
    5322:	0009c703          	lbu	a4,0(s3)
    5326:	02d00793          	li	a5,45
    532a:	ecf716e3          	bne	a4,a5,51f6 <main+0x36>
    532e:	a819                	j	5344 <main+0x184>
    5330:	3c913c23          	sd	s1,984(sp)
    5334:	3d213823          	sd	s2,976(sp)
    5338:	3d413023          	sd	s4,960(sp)
    533c:	3b513c23          	sd	s5,952(sp)
    5340:	3b613823          	sd	s6,944(sp)
    printf("Usage: usertests [-c] [testname]\n");
    5344:	00003517          	auipc	a0,0x3
    5348:	afc50513          	add	a0,a0,-1284 # 7e40 <malloc+0x20c2>
    534c:	00000097          	auipc	ra,0x0
    5350:	7b2080e7          	jalr	1970(ra) # 5afe <printf>
    exit(1);
    5354:	4505                	li	a0,1
    5356:	00000097          	auipc	ra,0x0
    535a:	370080e7          	jalr	880(ra) # 56c6 <exit>
          exit(1);
    535e:	4505                	li	a0,1
    5360:	00000097          	auipc	ra,0x0
    5364:	366080e7          	jalr	870(ra) # 56c6 <exit>
        printf("FAILED -- lost %d free pages\n", free0 - free1);
    5368:	40a905bb          	subw	a1,s2,a0
    536c:	855a                	mv	a0,s6
    536e:	00000097          	auipc	ra,0x0
    5372:	790080e7          	jalr	1936(ra) # 5afe <printf>
        if(continuous != 2)
    5376:	09498763          	beq	s3,s4,5404 <main+0x244>
          exit(1);
    537a:	4505                	li	a0,1
    537c:	00000097          	auipc	ra,0x0
    5380:	34a080e7          	jalr	842(ra) # 56c6 <exit>
  for (struct test *t = tests; t->s != 0; t++) {
    5384:	04c1                	add	s1,s1,16
    5386:	0084b903          	ld	s2,8(s1)
    538a:	02090463          	beqz	s2,53b2 <main+0x1f2>
    if((justone == 0) || strcmp(t->s, justone) == 0) {
    538e:	00098963          	beqz	s3,53a0 <main+0x1e0>
    5392:	85ce                	mv	a1,s3
    5394:	854a                	mv	a0,s2
    5396:	00000097          	auipc	ra,0x0
    539a:	0b2080e7          	jalr	178(ra) # 5448 <strcmp>
    539e:	f17d                	bnez	a0,5384 <main+0x1c4>
      if(!run(t->f, t->s))
    53a0:	85ca                	mv	a1,s2
    53a2:	6088                	ld	a0,0(s1)
    53a4:	00000097          	auipc	ra,0x0
    53a8:	d7e080e7          	jalr	-642(ra) # 5122 <run>
    53ac:	fd61                	bnez	a0,5384 <main+0x1c4>
        fail = 1;
    53ae:	8a5a                	mv	s4,s6
    53b0:	bfd1                	j	5384 <main+0x1c4>
  if(fail){
    53b2:	ea0a03e3          	beqz	s4,5258 <main+0x98>
    printf("SOME TESTS FAILED\n");
    53b6:	00003517          	auipc	a0,0x3
    53ba:	ad250513          	add	a0,a0,-1326 # 7e88 <malloc+0x210a>
    53be:	00000097          	auipc	ra,0x0
    53c2:	740080e7          	jalr	1856(ra) # 5afe <printf>
    exit(1);
    53c6:	4505                	li	a0,1
    53c8:	00000097          	auipc	ra,0x0
    53cc:	2fe080e7          	jalr	766(ra) # 56c6 <exit>
  } else {
    printf("ALL TESTS PASSED\n");
    53d0:	00003517          	auipc	a0,0x3
    53d4:	b0050513          	add	a0,a0,-1280 # 7ed0 <malloc+0x2152>
    53d8:	00000097          	auipc	ra,0x0
    53dc:	726080e7          	jalr	1830(ra) # 5afe <printf>
    exit(0);
    53e0:	4501                	li	a0,0
    53e2:	00000097          	auipc	ra,0x0
    53e6:	2e4080e7          	jalr	740(ra) # 56c6 <exit>
        printf("SOME TESTS FAILED\n");
    53ea:	8556                	mv	a0,s5
    53ec:	00000097          	auipc	ra,0x0
    53f0:	712080e7          	jalr	1810(ra) # 5afe <printf>
        if(continuous != 2)
    53f4:	f74995e3          	bne	s3,s4,535e <main+0x19e>
      int free1 = countfree();
    53f8:	00000097          	auipc	ra,0x0
    53fc:	bec080e7          	jalr	-1044(ra) # 4fe4 <countfree>
      if(free1 < free0){
    5400:	f72544e3          	blt	a0,s2,5368 <main+0x1a8>
      int free0 = countfree();
    5404:	00000097          	auipc	ra,0x0
    5408:	be0080e7          	jalr	-1056(ra) # 4fe4 <countfree>
    540c:	892a                	mv	s2,a0
      for (struct test *t = tests; t->s != 0; t++) {
    540e:	c1843583          	ld	a1,-1000(s0)
    5412:	d1fd                	beqz	a1,53f8 <main+0x238>
    5414:	c1040493          	add	s1,s0,-1008
        if(!run(t->f, t->s)){
    5418:	6088                	ld	a0,0(s1)
    541a:	00000097          	auipc	ra,0x0
    541e:	d08080e7          	jalr	-760(ra) # 5122 <run>
    5422:	d561                	beqz	a0,53ea <main+0x22a>
      for (struct test *t = tests; t->s != 0; t++) {
    5424:	04c1                	add	s1,s1,16
    5426:	648c                	ld	a1,8(s1)
    5428:	f9e5                	bnez	a1,5418 <main+0x258>
    542a:	b7f9                	j	53f8 <main+0x238>

000000000000542c <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
    542c:	1141                	add	sp,sp,-16
    542e:	e422                	sd	s0,8(sp)
    5430:	0800                	add	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    5432:	87aa                	mv	a5,a0
    5434:	0585                	add	a1,a1,1
    5436:	0785                	add	a5,a5,1
    5438:	fff5c703          	lbu	a4,-1(a1)
    543c:	fee78fa3          	sb	a4,-1(a5)
    5440:	fb75                	bnez	a4,5434 <strcpy+0x8>
    ;
  return os;
}
    5442:	6422                	ld	s0,8(sp)
    5444:	0141                	add	sp,sp,16
    5446:	8082                	ret

0000000000005448 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    5448:	1141                	add	sp,sp,-16
    544a:	e422                	sd	s0,8(sp)
    544c:	0800                	add	s0,sp,16
  while(*p && *p == *q)
    544e:	00054783          	lbu	a5,0(a0)
    5452:	cb91                	beqz	a5,5466 <strcmp+0x1e>
    5454:	0005c703          	lbu	a4,0(a1)
    5458:	00f71763          	bne	a4,a5,5466 <strcmp+0x1e>
    p++, q++;
    545c:	0505                	add	a0,a0,1
    545e:	0585                	add	a1,a1,1
  while(*p && *p == *q)
    5460:	00054783          	lbu	a5,0(a0)
    5464:	fbe5                	bnez	a5,5454 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
    5466:	0005c503          	lbu	a0,0(a1)
}
    546a:	40a7853b          	subw	a0,a5,a0
    546e:	6422                	ld	s0,8(sp)
    5470:	0141                	add	sp,sp,16
    5472:	8082                	ret

0000000000005474 <strlen>:

uint
strlen(const char *s)
{
    5474:	1141                	add	sp,sp,-16
    5476:	e422                	sd	s0,8(sp)
    5478:	0800                	add	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
    547a:	00054783          	lbu	a5,0(a0)
    547e:	cf91                	beqz	a5,549a <strlen+0x26>
    5480:	0505                	add	a0,a0,1
    5482:	87aa                	mv	a5,a0
    5484:	86be                	mv	a3,a5
    5486:	0785                	add	a5,a5,1
    5488:	fff7c703          	lbu	a4,-1(a5)
    548c:	ff65                	bnez	a4,5484 <strlen+0x10>
    548e:	40a6853b          	subw	a0,a3,a0
    5492:	2505                	addw	a0,a0,1
    ;
  return n;
}
    5494:	6422                	ld	s0,8(sp)
    5496:	0141                	add	sp,sp,16
    5498:	8082                	ret
  for(n = 0; s[n]; n++)
    549a:	4501                	li	a0,0
    549c:	bfe5                	j	5494 <strlen+0x20>

000000000000549e <strcat>:

char *
strcat(char *dst, char *src)
{
    549e:	1141                	add	sp,sp,-16
    54a0:	e422                	sd	s0,8(sp)
    54a2:	0800                	add	s0,sp,16
  char *s = dst;
  while (*dst)
    54a4:	00054783          	lbu	a5,0(a0)
    54a8:	c385                	beqz	a5,54c8 <strcat+0x2a>
    54aa:	87aa                	mv	a5,a0
    dst++;
    54ac:	0785                	add	a5,a5,1
  while (*dst)
    54ae:	0007c703          	lbu	a4,0(a5)
    54b2:	ff6d                	bnez	a4,54ac <strcat+0xe>
  while ((*dst++ = *src++) != 0);
    54b4:	0585                	add	a1,a1,1
    54b6:	0785                	add	a5,a5,1
    54b8:	fff5c703          	lbu	a4,-1(a1)
    54bc:	fee78fa3          	sb	a4,-1(a5)
    54c0:	fb75                	bnez	a4,54b4 <strcat+0x16>

  return s;
}
    54c2:	6422                	ld	s0,8(sp)
    54c4:	0141                	add	sp,sp,16
    54c6:	8082                	ret
  while (*dst)
    54c8:	87aa                	mv	a5,a0
    54ca:	b7ed                	j	54b4 <strcat+0x16>

00000000000054cc <memset>:

void*
memset(void *dst, int c, uint n)
{
    54cc:	1141                	add	sp,sp,-16
    54ce:	e422                	sd	s0,8(sp)
    54d0:	0800                	add	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
    54d2:	ca19                	beqz	a2,54e8 <memset+0x1c>
    54d4:	87aa                	mv	a5,a0
    54d6:	1602                	sll	a2,a2,0x20
    54d8:	9201                	srl	a2,a2,0x20
    54da:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
    54de:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
    54e2:	0785                	add	a5,a5,1
    54e4:	fee79de3          	bne	a5,a4,54de <memset+0x12>
  }
  return dst;
}
    54e8:	6422                	ld	s0,8(sp)
    54ea:	0141                	add	sp,sp,16
    54ec:	8082                	ret

00000000000054ee <strchr>:

char*
strchr(const char *s, char c)
{
    54ee:	1141                	add	sp,sp,-16
    54f0:	e422                	sd	s0,8(sp)
    54f2:	0800                	add	s0,sp,16
  for(; *s; s++)
    54f4:	00054783          	lbu	a5,0(a0)
    54f8:	cb99                	beqz	a5,550e <strchr+0x20>
    if(*s == c)
    54fa:	00f58763          	beq	a1,a5,5508 <strchr+0x1a>
  for(; *s; s++)
    54fe:	0505                	add	a0,a0,1
    5500:	00054783          	lbu	a5,0(a0)
    5504:	fbfd                	bnez	a5,54fa <strchr+0xc>
      return (char*)s;
  return 0;
    5506:	4501                	li	a0,0
}
    5508:	6422                	ld	s0,8(sp)
    550a:	0141                	add	sp,sp,16
    550c:	8082                	ret
  return 0;
    550e:	4501                	li	a0,0
    5510:	bfe5                	j	5508 <strchr+0x1a>

0000000000005512 <gets>:

char*
gets(char *buf, int max)
{
    5512:	711d                	add	sp,sp,-96
    5514:	ec86                	sd	ra,88(sp)
    5516:	e8a2                	sd	s0,80(sp)
    5518:	e4a6                	sd	s1,72(sp)
    551a:	e0ca                	sd	s2,64(sp)
    551c:	fc4e                	sd	s3,56(sp)
    551e:	f852                	sd	s4,48(sp)
    5520:	f456                	sd	s5,40(sp)
    5522:	f05a                	sd	s6,32(sp)
    5524:	ec5e                	sd	s7,24(sp)
    5526:	1080                	add	s0,sp,96
    5528:	8baa                	mv	s7,a0
    552a:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    552c:	892a                	mv	s2,a0
    552e:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
    5530:	4aa9                	li	s5,10
    5532:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
    5534:	89a6                	mv	s3,s1
    5536:	2485                	addw	s1,s1,1
    5538:	0344d863          	bge	s1,s4,5568 <gets+0x56>
    cc = read(0, &c, 1);
    553c:	4605                	li	a2,1
    553e:	faf40593          	add	a1,s0,-81
    5542:	4501                	li	a0,0
    5544:	00000097          	auipc	ra,0x0
    5548:	19a080e7          	jalr	410(ra) # 56de <read>
    if(cc < 1)
    554c:	00a05e63          	blez	a0,5568 <gets+0x56>
    buf[i++] = c;
    5550:	faf44783          	lbu	a5,-81(s0)
    5554:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
    5558:	01578763          	beq	a5,s5,5566 <gets+0x54>
    555c:	0905                	add	s2,s2,1
    555e:	fd679be3          	bne	a5,s6,5534 <gets+0x22>
    buf[i++] = c;
    5562:	89a6                	mv	s3,s1
    5564:	a011                	j	5568 <gets+0x56>
    5566:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
    5568:	99de                	add	s3,s3,s7
    556a:	00098023          	sb	zero,0(s3)
  return buf;
}
    556e:	855e                	mv	a0,s7
    5570:	60e6                	ld	ra,88(sp)
    5572:	6446                	ld	s0,80(sp)
    5574:	64a6                	ld	s1,72(sp)
    5576:	6906                	ld	s2,64(sp)
    5578:	79e2                	ld	s3,56(sp)
    557a:	7a42                	ld	s4,48(sp)
    557c:	7aa2                	ld	s5,40(sp)
    557e:	7b02                	ld	s6,32(sp)
    5580:	6be2                	ld	s7,24(sp)
    5582:	6125                	add	sp,sp,96
    5584:	8082                	ret

0000000000005586 <stat>:

int
stat(const char *n, struct stat *st)
{
    5586:	1101                	add	sp,sp,-32
    5588:	ec06                	sd	ra,24(sp)
    558a:	e822                	sd	s0,16(sp)
    558c:	e04a                	sd	s2,0(sp)
    558e:	1000                	add	s0,sp,32
    5590:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    5592:	4581                	li	a1,0
    5594:	00000097          	auipc	ra,0x0
    5598:	172080e7          	jalr	370(ra) # 5706 <open>
  if(fd < 0)
    559c:	02054663          	bltz	a0,55c8 <stat+0x42>
    55a0:	e426                	sd	s1,8(sp)
    55a2:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
    55a4:	85ca                	mv	a1,s2
    55a6:	00000097          	auipc	ra,0x0
    55aa:	178080e7          	jalr	376(ra) # 571e <fstat>
    55ae:	892a                	mv	s2,a0
  close(fd);
    55b0:	8526                	mv	a0,s1
    55b2:	00000097          	auipc	ra,0x0
    55b6:	13c080e7          	jalr	316(ra) # 56ee <close>
  return r;
    55ba:	64a2                	ld	s1,8(sp)
}
    55bc:	854a                	mv	a0,s2
    55be:	60e2                	ld	ra,24(sp)
    55c0:	6442                	ld	s0,16(sp)
    55c2:	6902                	ld	s2,0(sp)
    55c4:	6105                	add	sp,sp,32
    55c6:	8082                	ret
    return -1;
    55c8:	597d                	li	s2,-1
    55ca:	bfcd                	j	55bc <stat+0x36>

00000000000055cc <atoi>:

int
atoi(const char *s)
{
    55cc:	1141                	add	sp,sp,-16
    55ce:	e422                	sd	s0,8(sp)
    55d0:	0800                	add	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    55d2:	00054683          	lbu	a3,0(a0)
    55d6:	fd06879b          	addw	a5,a3,-48
    55da:	0ff7f793          	zext.b	a5,a5
    55de:	4625                	li	a2,9
    55e0:	02f66863          	bltu	a2,a5,5610 <atoi+0x44>
    55e4:	872a                	mv	a4,a0
  n = 0;
    55e6:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
    55e8:	0705                	add	a4,a4,1
    55ea:	0025179b          	sllw	a5,a0,0x2
    55ee:	9fa9                	addw	a5,a5,a0
    55f0:	0017979b          	sllw	a5,a5,0x1
    55f4:	9fb5                	addw	a5,a5,a3
    55f6:	fd07851b          	addw	a0,a5,-48
  while('0' <= *s && *s <= '9')
    55fa:	00074683          	lbu	a3,0(a4)
    55fe:	fd06879b          	addw	a5,a3,-48
    5602:	0ff7f793          	zext.b	a5,a5
    5606:	fef671e3          	bgeu	a2,a5,55e8 <atoi+0x1c>
  return n;
}
    560a:	6422                	ld	s0,8(sp)
    560c:	0141                	add	sp,sp,16
    560e:	8082                	ret
  n = 0;
    5610:	4501                	li	a0,0
    5612:	bfe5                	j	560a <atoi+0x3e>

0000000000005614 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    5614:	1141                	add	sp,sp,-16
    5616:	e422                	sd	s0,8(sp)
    5618:	0800                	add	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
    561a:	02b57463          	bgeu	a0,a1,5642 <memmove+0x2e>
    while(n-- > 0)
    561e:	00c05f63          	blez	a2,563c <memmove+0x28>
    5622:	1602                	sll	a2,a2,0x20
    5624:	9201                	srl	a2,a2,0x20
    5626:	00c507b3          	add	a5,a0,a2
  dst = vdst;
    562a:	872a                	mv	a4,a0
      *dst++ = *src++;
    562c:	0585                	add	a1,a1,1
    562e:	0705                	add	a4,a4,1
    5630:	fff5c683          	lbu	a3,-1(a1)
    5634:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
    5638:	fef71ae3          	bne	a4,a5,562c <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
    563c:	6422                	ld	s0,8(sp)
    563e:	0141                	add	sp,sp,16
    5640:	8082                	ret
    dst += n;
    5642:	00c50733          	add	a4,a0,a2
    src += n;
    5646:	95b2                	add	a1,a1,a2
    while(n-- > 0)
    5648:	fec05ae3          	blez	a2,563c <memmove+0x28>
    564c:	fff6079b          	addw	a5,a2,-1 # 2fff <dirtest+0x27>
    5650:	1782                	sll	a5,a5,0x20
    5652:	9381                	srl	a5,a5,0x20
    5654:	fff7c793          	not	a5,a5
    5658:	97ba                	add	a5,a5,a4
      *--dst = *--src;
    565a:	15fd                	add	a1,a1,-1
    565c:	177d                	add	a4,a4,-1
    565e:	0005c683          	lbu	a3,0(a1)
    5662:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
    5666:	fee79ae3          	bne	a5,a4,565a <memmove+0x46>
    566a:	bfc9                	j	563c <memmove+0x28>

000000000000566c <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
    566c:	1141                	add	sp,sp,-16
    566e:	e422                	sd	s0,8(sp)
    5670:	0800                	add	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
    5672:	ca05                	beqz	a2,56a2 <memcmp+0x36>
    5674:	fff6069b          	addw	a3,a2,-1
    5678:	1682                	sll	a3,a3,0x20
    567a:	9281                	srl	a3,a3,0x20
    567c:	0685                	add	a3,a3,1
    567e:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
    5680:	00054783          	lbu	a5,0(a0)
    5684:	0005c703          	lbu	a4,0(a1)
    5688:	00e79863          	bne	a5,a4,5698 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
    568c:	0505                	add	a0,a0,1
    p2++;
    568e:	0585                	add	a1,a1,1
  while (n-- > 0) {
    5690:	fed518e3          	bne	a0,a3,5680 <memcmp+0x14>
  }
  return 0;
    5694:	4501                	li	a0,0
    5696:	a019                	j	569c <memcmp+0x30>
      return *p1 - *p2;
    5698:	40e7853b          	subw	a0,a5,a4
}
    569c:	6422                	ld	s0,8(sp)
    569e:	0141                	add	sp,sp,16
    56a0:	8082                	ret
  return 0;
    56a2:	4501                	li	a0,0
    56a4:	bfe5                	j	569c <memcmp+0x30>

00000000000056a6 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
    56a6:	1141                	add	sp,sp,-16
    56a8:	e406                	sd	ra,8(sp)
    56aa:	e022                	sd	s0,0(sp)
    56ac:	0800                	add	s0,sp,16
  return memmove(dst, src, n);
    56ae:	00000097          	auipc	ra,0x0
    56b2:	f66080e7          	jalr	-154(ra) # 5614 <memmove>
}
    56b6:	60a2                	ld	ra,8(sp)
    56b8:	6402                	ld	s0,0(sp)
    56ba:	0141                	add	sp,sp,16
    56bc:	8082                	ret

00000000000056be <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
    56be:	4885                	li	a7,1
 ecall
    56c0:	00000073          	ecall
 ret
    56c4:	8082                	ret

00000000000056c6 <exit>:
.global exit
exit:
 li a7, SYS_exit
    56c6:	4889                	li	a7,2
 ecall
    56c8:	00000073          	ecall
 ret
    56cc:	8082                	ret

00000000000056ce <wait>:
.global wait
wait:
 li a7, SYS_wait
    56ce:	488d                	li	a7,3
 ecall
    56d0:	00000073          	ecall
 ret
    56d4:	8082                	ret

00000000000056d6 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
    56d6:	4891                	li	a7,4
 ecall
    56d8:	00000073          	ecall
 ret
    56dc:	8082                	ret

00000000000056de <read>:
.global read
read:
 li a7, SYS_read
    56de:	4895                	li	a7,5
 ecall
    56e0:	00000073          	ecall
 ret
    56e4:	8082                	ret

00000000000056e6 <write>:
.global write
write:
 li a7, SYS_write
    56e6:	48c1                	li	a7,16
 ecall
    56e8:	00000073          	ecall
 ret
    56ec:	8082                	ret

00000000000056ee <close>:
.global close
close:
 li a7, SYS_close
    56ee:	48d5                	li	a7,21
 ecall
    56f0:	00000073          	ecall
 ret
    56f4:	8082                	ret

00000000000056f6 <kill>:
.global kill
kill:
 li a7, SYS_kill
    56f6:	4899                	li	a7,6
 ecall
    56f8:	00000073          	ecall
 ret
    56fc:	8082                	ret

00000000000056fe <exec>:
.global exec
exec:
 li a7, SYS_exec
    56fe:	489d                	li	a7,7
 ecall
    5700:	00000073          	ecall
 ret
    5704:	8082                	ret

0000000000005706 <open>:
.global open
open:
 li a7, SYS_open
    5706:	48bd                	li	a7,15
 ecall
    5708:	00000073          	ecall
 ret
    570c:	8082                	ret

000000000000570e <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
    570e:	48c5                	li	a7,17
 ecall
    5710:	00000073          	ecall
 ret
    5714:	8082                	ret

0000000000005716 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
    5716:	48c9                	li	a7,18
 ecall
    5718:	00000073          	ecall
 ret
    571c:	8082                	ret

000000000000571e <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
    571e:	48a1                	li	a7,8
 ecall
    5720:	00000073          	ecall
 ret
    5724:	8082                	ret

0000000000005726 <link>:
.global link
link:
 li a7, SYS_link
    5726:	48cd                	li	a7,19
 ecall
    5728:	00000073          	ecall
 ret
    572c:	8082                	ret

000000000000572e <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
    572e:	48d1                	li	a7,20
 ecall
    5730:	00000073          	ecall
 ret
    5734:	8082                	ret

0000000000005736 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
    5736:	48a5                	li	a7,9
 ecall
    5738:	00000073          	ecall
 ret
    573c:	8082                	ret

000000000000573e <dup>:
.global dup
dup:
 li a7, SYS_dup
    573e:	48a9                	li	a7,10
 ecall
    5740:	00000073          	ecall
 ret
    5744:	8082                	ret

0000000000005746 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
    5746:	48ad                	li	a7,11
 ecall
    5748:	00000073          	ecall
 ret
    574c:	8082                	ret

000000000000574e <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
    574e:	48b1                	li	a7,12
 ecall
    5750:	00000073          	ecall
 ret
    5754:	8082                	ret

0000000000005756 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
    5756:	48b5                	li	a7,13
 ecall
    5758:	00000073          	ecall
 ret
    575c:	8082                	ret

000000000000575e <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
    575e:	48b9                	li	a7,14
 ecall
    5760:	00000073          	ecall
 ret
    5764:	8082                	ret

0000000000005766 <uconnect>:
.global uconnect
uconnect:
 li a7, SYS_uconnect
    5766:	48f5                	li	a7,29
 ecall
    5768:	00000073          	ecall
 ret
    576c:	8082                	ret

000000000000576e <socket>:
.global socket
socket:
 li a7, SYS_socket
    576e:	48f9                	li	a7,30
 ecall
    5770:	00000073          	ecall
 ret
    5774:	8082                	ret

0000000000005776 <bind>:
.global bind
bind:
 li a7, SYS_bind
    5776:	48fd                	li	a7,31
 ecall
    5778:	00000073          	ecall
 ret
    577c:	8082                	ret

000000000000577e <listen>:
.global listen
listen:
 li a7, SYS_listen
    577e:	02000893          	li	a7,32
 ecall
    5782:	00000073          	ecall
 ret
    5786:	8082                	ret

0000000000005788 <accept>:
.global accept
accept:
 li a7, SYS_accept
    5788:	02100893          	li	a7,33
 ecall
    578c:	00000073          	ecall
 ret
    5790:	8082                	ret

0000000000005792 <connect>:
.global connect
connect:
 li a7, SYS_connect
    5792:	02200893          	li	a7,34
 ecall
    5796:	00000073          	ecall
 ret
    579a:	8082                	ret

000000000000579c <sprintint>:
  return 1;
}

static int
sprintint(char *s, int xx, int base, int sign)
{
    579c:	1101                	add	sp,sp,-32
    579e:	ec22                	sd	s0,24(sp)
    57a0:	1000                	add	s0,sp,32
    57a2:	882a                	mv	a6,a0
  char buf[16];
  int i, n;
  uint x;

  if(sign && (sign = xx < 0))
    57a4:	c299                	beqz	a3,57aa <sprintint+0xe>
    57a6:	0805c263          	bltz	a1,582a <sprintint+0x8e>
    x = -xx;
  else
    x = xx;
    57aa:	2581                	sext.w	a1,a1
    57ac:	4301                	li	t1,0

  i = 0;
    57ae:	fe040713          	add	a4,s0,-32
    57b2:	4501                	li	a0,0
  do {
    buf[i++] = digits[x % base];
    57b4:	2601                	sext.w	a2,a2
    57b6:	00003697          	auipc	a3,0x3
    57ba:	e5a68693          	add	a3,a3,-422 # 8610 <digits>
    57be:	88aa                	mv	a7,a0
    57c0:	2505                	addw	a0,a0,1
    57c2:	02c5f7bb          	remuw	a5,a1,a2
    57c6:	1782                	sll	a5,a5,0x20
    57c8:	9381                	srl	a5,a5,0x20
    57ca:	97b6                	add	a5,a5,a3
    57cc:	0007c783          	lbu	a5,0(a5)
    57d0:	00f70023          	sb	a5,0(a4)
  } while((x /= base) != 0);
    57d4:	0005879b          	sext.w	a5,a1
    57d8:	02c5d5bb          	divuw	a1,a1,a2
    57dc:	0705                	add	a4,a4,1
    57de:	fec7f0e3          	bgeu	a5,a2,57be <sprintint+0x22>

  if(sign)
    57e2:	00030b63          	beqz	t1,57f8 <sprintint+0x5c>
    buf[i++] = '-';
    57e6:	ff050793          	add	a5,a0,-16
    57ea:	97a2                	add	a5,a5,s0
    57ec:	02d00713          	li	a4,45
    57f0:	fee78823          	sb	a4,-16(a5)
    57f4:	0028851b          	addw	a0,a7,2

  n = 0;
  while(--i >= 0)
    57f8:	02a05d63          	blez	a0,5832 <sprintint+0x96>
    57fc:	fe040793          	add	a5,s0,-32
    5800:	00a78733          	add	a4,a5,a0
    5804:	87c2                	mv	a5,a6
    5806:	00180613          	add	a2,a6,1
    580a:	fff5069b          	addw	a3,a0,-1
    580e:	1682                	sll	a3,a3,0x20
    5810:	9281                	srl	a3,a3,0x20
    5812:	9636                	add	a2,a2,a3
  *s = c;
    5814:	fff74683          	lbu	a3,-1(a4)
    5818:	00d78023          	sb	a3,0(a5)
  while(--i >= 0)
    581c:	177d                	add	a4,a4,-1
    581e:	0785                	add	a5,a5,1
    5820:	fec79ae3          	bne	a5,a2,5814 <sprintint+0x78>
    n += sputc(s+n, buf[i]);
  return n;
}
    5824:	6462                	ld	s0,24(sp)
    5826:	6105                	add	sp,sp,32
    5828:	8082                	ret
    x = -xx;
    582a:	40b005bb          	negw	a1,a1
  if(sign && (sign = xx < 0))
    582e:	4305                	li	t1,1
    x = -xx;
    5830:	bfbd                	j	57ae <sprintint+0x12>
  while(--i >= 0)
    5832:	4501                	li	a0,0
    5834:	bfc5                	j	5824 <sprintint+0x88>

0000000000005836 <putc>:
{
    5836:	1101                	add	sp,sp,-32
    5838:	ec06                	sd	ra,24(sp)
    583a:	e822                	sd	s0,16(sp)
    583c:	1000                	add	s0,sp,32
    583e:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
    5842:	4605                	li	a2,1
    5844:	fef40593          	add	a1,s0,-17
    5848:	00000097          	auipc	ra,0x0
    584c:	e9e080e7          	jalr	-354(ra) # 56e6 <write>
}
    5850:	60e2                	ld	ra,24(sp)
    5852:	6442                	ld	s0,16(sp)
    5854:	6105                	add	sp,sp,32
    5856:	8082                	ret

0000000000005858 <printint>:
{
    5858:	7139                	add	sp,sp,-64
    585a:	fc06                	sd	ra,56(sp)
    585c:	f822                	sd	s0,48(sp)
    585e:	f426                	sd	s1,40(sp)
    5860:	0080                	add	s0,sp,64
    5862:	84aa                	mv	s1,a0
  if(sgn && xx < 0){
    5864:	c299                	beqz	a3,586a <printint+0x12>
    5866:	0805cb63          	bltz	a1,58fc <printint+0xa4>
    x = xx;
    586a:	2581                	sext.w	a1,a1
  neg = 0;
    586c:	4881                	li	a7,0
    586e:	fc040693          	add	a3,s0,-64
  i = 0;
    5872:	4701                	li	a4,0
    buf[i++] = digits[x % base];
    5874:	2601                	sext.w	a2,a2
    5876:	00003517          	auipc	a0,0x3
    587a:	d9a50513          	add	a0,a0,-614 # 8610 <digits>
    587e:	883a                	mv	a6,a4
    5880:	2705                	addw	a4,a4,1
    5882:	02c5f7bb          	remuw	a5,a1,a2
    5886:	1782                	sll	a5,a5,0x20
    5888:	9381                	srl	a5,a5,0x20
    588a:	97aa                	add	a5,a5,a0
    588c:	0007c783          	lbu	a5,0(a5)
    5890:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
    5894:	0005879b          	sext.w	a5,a1
    5898:	02c5d5bb          	divuw	a1,a1,a2
    589c:	0685                	add	a3,a3,1
    589e:	fec7f0e3          	bgeu	a5,a2,587e <printint+0x26>
  if(neg)
    58a2:	00088c63          	beqz	a7,58ba <printint+0x62>
    buf[i++] = '-';
    58a6:	fd070793          	add	a5,a4,-48
    58aa:	00878733          	add	a4,a5,s0
    58ae:	02d00793          	li	a5,45
    58b2:	fef70823          	sb	a5,-16(a4)
    58b6:	0028071b          	addw	a4,a6,2
  while(--i >= 0)
    58ba:	02e05c63          	blez	a4,58f2 <printint+0x9a>
    58be:	f04a                	sd	s2,32(sp)
    58c0:	ec4e                	sd	s3,24(sp)
    58c2:	fc040793          	add	a5,s0,-64
    58c6:	00e78933          	add	s2,a5,a4
    58ca:	fff78993          	add	s3,a5,-1
    58ce:	99ba                	add	s3,s3,a4
    58d0:	377d                	addw	a4,a4,-1
    58d2:	1702                	sll	a4,a4,0x20
    58d4:	9301                	srl	a4,a4,0x20
    58d6:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
    58da:	fff94583          	lbu	a1,-1(s2)
    58de:	8526                	mv	a0,s1
    58e0:	00000097          	auipc	ra,0x0
    58e4:	f56080e7          	jalr	-170(ra) # 5836 <putc>
  while(--i >= 0)
    58e8:	197d                	add	s2,s2,-1
    58ea:	ff3918e3          	bne	s2,s3,58da <printint+0x82>
    58ee:	7902                	ld	s2,32(sp)
    58f0:	69e2                	ld	s3,24(sp)
}
    58f2:	70e2                	ld	ra,56(sp)
    58f4:	7442                	ld	s0,48(sp)
    58f6:	74a2                	ld	s1,40(sp)
    58f8:	6121                	add	sp,sp,64
    58fa:	8082                	ret
    x = -xx;
    58fc:	40b005bb          	negw	a1,a1
    neg = 1;
    5900:	4885                	li	a7,1
    x = -xx;
    5902:	b7b5                	j	586e <printint+0x16>

0000000000005904 <vprintf>:
{
    5904:	715d                	add	sp,sp,-80
    5906:	e486                	sd	ra,72(sp)
    5908:	e0a2                	sd	s0,64(sp)
    590a:	f84a                	sd	s2,48(sp)
    590c:	0880                	add	s0,sp,80
  for(i = 0; fmt[i]; i++){
    590e:	0005c903          	lbu	s2,0(a1)
    5912:	1a090a63          	beqz	s2,5ac6 <vprintf+0x1c2>
    5916:	fc26                	sd	s1,56(sp)
    5918:	f44e                	sd	s3,40(sp)
    591a:	f052                	sd	s4,32(sp)
    591c:	ec56                	sd	s5,24(sp)
    591e:	e85a                	sd	s6,16(sp)
    5920:	e45e                	sd	s7,8(sp)
    5922:	8aaa                	mv	s5,a0
    5924:	8bb2                	mv	s7,a2
    5926:	00158493          	add	s1,a1,1
  state = 0;
    592a:	4981                	li	s3,0
    } else if(state == '%'){
    592c:	02500a13          	li	s4,37
    5930:	4b55                	li	s6,21
    5932:	a839                	j	5950 <vprintf+0x4c>
        putc(fd, c);
    5934:	85ca                	mv	a1,s2
    5936:	8556                	mv	a0,s5
    5938:	00000097          	auipc	ra,0x0
    593c:	efe080e7          	jalr	-258(ra) # 5836 <putc>
    5940:	a019                	j	5946 <vprintf+0x42>
    } else if(state == '%'){
    5942:	01498d63          	beq	s3,s4,595c <vprintf+0x58>
  for(i = 0; fmt[i]; i++){
    5946:	0485                	add	s1,s1,1
    5948:	fff4c903          	lbu	s2,-1(s1)
    594c:	16090763          	beqz	s2,5aba <vprintf+0x1b6>
    if(state == 0){
    5950:	fe0999e3          	bnez	s3,5942 <vprintf+0x3e>
      if(c == '%'){
    5954:	ff4910e3          	bne	s2,s4,5934 <vprintf+0x30>
        state = '%';
    5958:	89d2                	mv	s3,s4
    595a:	b7f5                	j	5946 <vprintf+0x42>
      if(c == 'd'){
    595c:	13490463          	beq	s2,s4,5a84 <vprintf+0x180>
    5960:	f9d9079b          	addw	a5,s2,-99
    5964:	0ff7f793          	zext.b	a5,a5
    5968:	12fb6763          	bltu	s6,a5,5a96 <vprintf+0x192>
    596c:	f9d9079b          	addw	a5,s2,-99
    5970:	0ff7f713          	zext.b	a4,a5
    5974:	12eb6163          	bltu	s6,a4,5a96 <vprintf+0x192>
    5978:	00271793          	sll	a5,a4,0x2
    597c:	00003717          	auipc	a4,0x3
    5980:	c3c70713          	add	a4,a4,-964 # 85b8 <malloc+0x283a>
    5984:	97ba                	add	a5,a5,a4
    5986:	439c                	lw	a5,0(a5)
    5988:	97ba                	add	a5,a5,a4
    598a:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
    598c:	008b8913          	add	s2,s7,8
    5990:	4685                	li	a3,1
    5992:	4629                	li	a2,10
    5994:	000ba583          	lw	a1,0(s7)
    5998:	8556                	mv	a0,s5
    599a:	00000097          	auipc	ra,0x0
    599e:	ebe080e7          	jalr	-322(ra) # 5858 <printint>
    59a2:	8bca                	mv	s7,s2
      state = 0;
    59a4:	4981                	li	s3,0
    59a6:	b745                	j	5946 <vprintf+0x42>
        printint(fd, va_arg(ap, uint64), 10, 0);
    59a8:	008b8913          	add	s2,s7,8
    59ac:	4681                	li	a3,0
    59ae:	4629                	li	a2,10
    59b0:	000ba583          	lw	a1,0(s7)
    59b4:	8556                	mv	a0,s5
    59b6:	00000097          	auipc	ra,0x0
    59ba:	ea2080e7          	jalr	-350(ra) # 5858 <printint>
    59be:	8bca                	mv	s7,s2
      state = 0;
    59c0:	4981                	li	s3,0
    59c2:	b751                	j	5946 <vprintf+0x42>
        printint(fd, va_arg(ap, int), 16, 0);
    59c4:	008b8913          	add	s2,s7,8
    59c8:	4681                	li	a3,0
    59ca:	4641                	li	a2,16
    59cc:	000ba583          	lw	a1,0(s7)
    59d0:	8556                	mv	a0,s5
    59d2:	00000097          	auipc	ra,0x0
    59d6:	e86080e7          	jalr	-378(ra) # 5858 <printint>
    59da:	8bca                	mv	s7,s2
      state = 0;
    59dc:	4981                	li	s3,0
    59de:	b7a5                	j	5946 <vprintf+0x42>
    59e0:	e062                	sd	s8,0(sp)
        printptr(fd, va_arg(ap, uint64));
    59e2:	008b8c13          	add	s8,s7,8
    59e6:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
    59ea:	03000593          	li	a1,48
    59ee:	8556                	mv	a0,s5
    59f0:	00000097          	auipc	ra,0x0
    59f4:	e46080e7          	jalr	-442(ra) # 5836 <putc>
  putc(fd, 'x');
    59f8:	07800593          	li	a1,120
    59fc:	8556                	mv	a0,s5
    59fe:	00000097          	auipc	ra,0x0
    5a02:	e38080e7          	jalr	-456(ra) # 5836 <putc>
    5a06:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
    5a08:	00003b97          	auipc	s7,0x3
    5a0c:	c08b8b93          	add	s7,s7,-1016 # 8610 <digits>
    5a10:	03c9d793          	srl	a5,s3,0x3c
    5a14:	97de                	add	a5,a5,s7
    5a16:	0007c583          	lbu	a1,0(a5)
    5a1a:	8556                	mv	a0,s5
    5a1c:	00000097          	auipc	ra,0x0
    5a20:	e1a080e7          	jalr	-486(ra) # 5836 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    5a24:	0992                	sll	s3,s3,0x4
    5a26:	397d                	addw	s2,s2,-1
    5a28:	fe0914e3          	bnez	s2,5a10 <vprintf+0x10c>
        printptr(fd, va_arg(ap, uint64));
    5a2c:	8be2                	mv	s7,s8
      state = 0;
    5a2e:	4981                	li	s3,0
    5a30:	6c02                	ld	s8,0(sp)
    5a32:	bf11                	j	5946 <vprintf+0x42>
        s = va_arg(ap, char*);
    5a34:	008b8993          	add	s3,s7,8
    5a38:	000bb903          	ld	s2,0(s7)
        if(s == 0)
    5a3c:	02090163          	beqz	s2,5a5e <vprintf+0x15a>
        while(*s != 0){
    5a40:	00094583          	lbu	a1,0(s2)
    5a44:	c9a5                	beqz	a1,5ab4 <vprintf+0x1b0>
          putc(fd, *s);
    5a46:	8556                	mv	a0,s5
    5a48:	00000097          	auipc	ra,0x0
    5a4c:	dee080e7          	jalr	-530(ra) # 5836 <putc>
          s++;
    5a50:	0905                	add	s2,s2,1
        while(*s != 0){
    5a52:	00094583          	lbu	a1,0(s2)
    5a56:	f9e5                	bnez	a1,5a46 <vprintf+0x142>
        s = va_arg(ap, char*);
    5a58:	8bce                	mv	s7,s3
      state = 0;
    5a5a:	4981                	li	s3,0
    5a5c:	b5ed                	j	5946 <vprintf+0x42>
          s = "(null)";
    5a5e:	00002917          	auipc	s2,0x2
    5a62:	78290913          	add	s2,s2,1922 # 81e0 <malloc+0x2462>
        while(*s != 0){
    5a66:	02800593          	li	a1,40
    5a6a:	bff1                	j	5a46 <vprintf+0x142>
        putc(fd, va_arg(ap, uint));
    5a6c:	008b8913          	add	s2,s7,8
    5a70:	000bc583          	lbu	a1,0(s7)
    5a74:	8556                	mv	a0,s5
    5a76:	00000097          	auipc	ra,0x0
    5a7a:	dc0080e7          	jalr	-576(ra) # 5836 <putc>
    5a7e:	8bca                	mv	s7,s2
      state = 0;
    5a80:	4981                	li	s3,0
    5a82:	b5d1                	j	5946 <vprintf+0x42>
        putc(fd, c);
    5a84:	02500593          	li	a1,37
    5a88:	8556                	mv	a0,s5
    5a8a:	00000097          	auipc	ra,0x0
    5a8e:	dac080e7          	jalr	-596(ra) # 5836 <putc>
      state = 0;
    5a92:	4981                	li	s3,0
    5a94:	bd4d                	j	5946 <vprintf+0x42>
        putc(fd, '%');
    5a96:	02500593          	li	a1,37
    5a9a:	8556                	mv	a0,s5
    5a9c:	00000097          	auipc	ra,0x0
    5aa0:	d9a080e7          	jalr	-614(ra) # 5836 <putc>
        putc(fd, c);
    5aa4:	85ca                	mv	a1,s2
    5aa6:	8556                	mv	a0,s5
    5aa8:	00000097          	auipc	ra,0x0
    5aac:	d8e080e7          	jalr	-626(ra) # 5836 <putc>
      state = 0;
    5ab0:	4981                	li	s3,0
    5ab2:	bd51                	j	5946 <vprintf+0x42>
        s = va_arg(ap, char*);
    5ab4:	8bce                	mv	s7,s3
      state = 0;
    5ab6:	4981                	li	s3,0
    5ab8:	b579                	j	5946 <vprintf+0x42>
    5aba:	74e2                	ld	s1,56(sp)
    5abc:	79a2                	ld	s3,40(sp)
    5abe:	7a02                	ld	s4,32(sp)
    5ac0:	6ae2                	ld	s5,24(sp)
    5ac2:	6b42                	ld	s6,16(sp)
    5ac4:	6ba2                	ld	s7,8(sp)
}
    5ac6:	60a6                	ld	ra,72(sp)
    5ac8:	6406                	ld	s0,64(sp)
    5aca:	7942                	ld	s2,48(sp)
    5acc:	6161                	add	sp,sp,80
    5ace:	8082                	ret

0000000000005ad0 <fprintf>:
{
    5ad0:	715d                	add	sp,sp,-80
    5ad2:	ec06                	sd	ra,24(sp)
    5ad4:	e822                	sd	s0,16(sp)
    5ad6:	1000                	add	s0,sp,32
    5ad8:	e010                	sd	a2,0(s0)
    5ada:	e414                	sd	a3,8(s0)
    5adc:	e818                	sd	a4,16(s0)
    5ade:	ec1c                	sd	a5,24(s0)
    5ae0:	03043023          	sd	a6,32(s0)
    5ae4:	03143423          	sd	a7,40(s0)
  va_start(ap, fmt);
    5ae8:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
    5aec:	8622                	mv	a2,s0
    5aee:	00000097          	auipc	ra,0x0
    5af2:	e16080e7          	jalr	-490(ra) # 5904 <vprintf>
}
    5af6:	60e2                	ld	ra,24(sp)
    5af8:	6442                	ld	s0,16(sp)
    5afa:	6161                	add	sp,sp,80
    5afc:	8082                	ret

0000000000005afe <printf>:
{
    5afe:	711d                	add	sp,sp,-96
    5b00:	ec06                	sd	ra,24(sp)
    5b02:	e822                	sd	s0,16(sp)
    5b04:	1000                	add	s0,sp,32
    5b06:	e40c                	sd	a1,8(s0)
    5b08:	e810                	sd	a2,16(s0)
    5b0a:	ec14                	sd	a3,24(s0)
    5b0c:	f018                	sd	a4,32(s0)
    5b0e:	f41c                	sd	a5,40(s0)
    5b10:	03043823          	sd	a6,48(s0)
    5b14:	03143c23          	sd	a7,56(s0)
  va_start(ap, fmt);
    5b18:	00840613          	add	a2,s0,8
    5b1c:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
    5b20:	85aa                	mv	a1,a0
    5b22:	4505                	li	a0,1
    5b24:	00000097          	auipc	ra,0x0
    5b28:	de0080e7          	jalr	-544(ra) # 5904 <vprintf>
}
    5b2c:	60e2                	ld	ra,24(sp)
    5b2e:	6442                	ld	s0,16(sp)
    5b30:	6125                	add	sp,sp,96
    5b32:	8082                	ret

0000000000005b34 <snprintf>:

int
snprintf(char *buf, int sz, char *fmt, ...)
{
    5b34:	7135                	add	sp,sp,-160
    5b36:	f486                	sd	ra,104(sp)
    5b38:	f0a2                	sd	s0,96(sp)
    5b3a:	eca6                	sd	s1,88(sp)
    5b3c:	1880                	add	s0,sp,112
    5b3e:	e414                	sd	a3,8(s0)
    5b40:	e818                	sd	a4,16(s0)
    5b42:	ec1c                	sd	a5,24(s0)
    5b44:	03043023          	sd	a6,32(s0)
    5b48:	03143423          	sd	a7,40(s0)
  va_list ap;
  int i, c;
  int off = 0;
  char *s;

  if (fmt == 0)
    5b4c:	16060b63          	beqz	a2,5cc2 <snprintf+0x18e>
    5b50:	e8ca                	sd	s2,80(sp)
    5b52:	e4ce                	sd	s3,72(sp)
    5b54:	fc56                	sd	s5,56(sp)
    5b56:	f85a                	sd	s6,48(sp)
    5b58:	8b2a                	mv	s6,a0
    5b5a:	8aae                	mv	s5,a1
    5b5c:	89b2                	mv	s3,a2
    return -1;

  va_start(ap, fmt);
    5b5e:	00840793          	add	a5,s0,8
    5b62:	f8f43c23          	sd	a5,-104(s0)
  int off = 0;
    5b66:	4481                	li	s1,0
  for(i = 0; off < sz && (c = fmt[i] & 0xff) != 0; i++){
    5b68:	4901                	li	s2,0
    5b6a:	00b05f63          	blez	a1,5b88 <snprintf+0x54>
    5b6e:	e0d2                	sd	s4,64(sp)
    5b70:	f45e                	sd	s7,40(sp)
    5b72:	f062                	sd	s8,32(sp)
    5b74:	ec66                	sd	s9,24(sp)
    if(c != '%'){
    5b76:	02500a13          	li	s4,37
      continue;
    }
    c = fmt[++i] & 0xff;
    if(c == 0)
      break;
    switch(c){
    5b7a:	07300b93          	li	s7,115
    5b7e:	07800c93          	li	s9,120
    5b82:	06400c13          	li	s8,100
    5b86:	a839                	j	5ba4 <snprintf+0x70>
      off += sputc(buf+off, '%');
      off += sputc(buf+off, c);
      break;
    }
  }
  return off;
    5b88:	4481                	li	s1,0
    5b8a:	6946                	ld	s2,80(sp)
    5b8c:	69a6                	ld	s3,72(sp)
    5b8e:	7ae2                	ld	s5,56(sp)
    5b90:	7b42                	ld	s6,48(sp)
    5b92:	a0cd                	j	5c74 <snprintf+0x140>
  *s = c;
    5b94:	009b0733          	add	a4,s6,s1
    5b98:	00f70023          	sb	a5,0(a4)
      off += sputc(buf+off, c);
    5b9c:	2485                	addw	s1,s1,1
  for(i = 0; off < sz && (c = fmt[i] & 0xff) != 0; i++){
    5b9e:	2905                	addw	s2,s2,1
    5ba0:	1554d563          	bge	s1,s5,5cea <snprintf+0x1b6>
    5ba4:	012987b3          	add	a5,s3,s2
    5ba8:	0007c783          	lbu	a5,0(a5)
    5bac:	0007871b          	sext.w	a4,a5
    5bb0:	10078063          	beqz	a5,5cb0 <snprintf+0x17c>
    if(c != '%'){
    5bb4:	ff4710e3          	bne	a4,s4,5b94 <snprintf+0x60>
    c = fmt[++i] & 0xff;
    5bb8:	2905                	addw	s2,s2,1
    5bba:	012987b3          	add	a5,s3,s2
    5bbe:	0007c783          	lbu	a5,0(a5)
    if(c == 0)
    5bc2:	10078263          	beqz	a5,5cc6 <snprintf+0x192>
    switch(c){
    5bc6:	05778c63          	beq	a5,s7,5c1e <snprintf+0xea>
    5bca:	02fbe763          	bltu	s7,a5,5bf8 <snprintf+0xc4>
    5bce:	0d478063          	beq	a5,s4,5c8e <snprintf+0x15a>
    5bd2:	0d879463          	bne	a5,s8,5c9a <snprintf+0x166>
      off += sprintint(buf+off, va_arg(ap, int), 10, 1);
    5bd6:	f9843783          	ld	a5,-104(s0)
    5bda:	00878713          	add	a4,a5,8
    5bde:	f8e43c23          	sd	a4,-104(s0)
    5be2:	4685                	li	a3,1
    5be4:	4629                	li	a2,10
    5be6:	438c                	lw	a1,0(a5)
    5be8:	009b0533          	add	a0,s6,s1
    5bec:	00000097          	auipc	ra,0x0
    5bf0:	bb0080e7          	jalr	-1104(ra) # 579c <sprintint>
    5bf4:	9ca9                	addw	s1,s1,a0
      break;
    5bf6:	b765                	j	5b9e <snprintf+0x6a>
    switch(c){
    5bf8:	0b979163          	bne	a5,s9,5c9a <snprintf+0x166>
      off += sprintint(buf+off, va_arg(ap, int), 16, 1);
    5bfc:	f9843783          	ld	a5,-104(s0)
    5c00:	00878713          	add	a4,a5,8
    5c04:	f8e43c23          	sd	a4,-104(s0)
    5c08:	4685                	li	a3,1
    5c0a:	4641                	li	a2,16
    5c0c:	438c                	lw	a1,0(a5)
    5c0e:	009b0533          	add	a0,s6,s1
    5c12:	00000097          	auipc	ra,0x0
    5c16:	b8a080e7          	jalr	-1142(ra) # 579c <sprintint>
    5c1a:	9ca9                	addw	s1,s1,a0
      break;
    5c1c:	b749                	j	5b9e <snprintf+0x6a>
      if((s = va_arg(ap, char*)) == 0)
    5c1e:	f9843783          	ld	a5,-104(s0)
    5c22:	00878713          	add	a4,a5,8
    5c26:	f8e43c23          	sd	a4,-104(s0)
    5c2a:	6388                	ld	a0,0(a5)
    5c2c:	c931                	beqz	a0,5c80 <snprintf+0x14c>
      for(; *s && off < sz; s++)
    5c2e:	00054703          	lbu	a4,0(a0)
    5c32:	d735                	beqz	a4,5b9e <snprintf+0x6a>
    5c34:	0b54d263          	bge	s1,s5,5cd8 <snprintf+0x1a4>
    5c38:	009b06b3          	add	a3,s6,s1
    5c3c:	409a863b          	subw	a2,s5,s1
    5c40:	1602                	sll	a2,a2,0x20
    5c42:	9201                	srl	a2,a2,0x20
    5c44:	962a                	add	a2,a2,a0
    5c46:	87aa                	mv	a5,a0
        off += sputc(buf+off, *s);
    5c48:	0014859b          	addw	a1,s1,1
    5c4c:	9d89                	subw	a1,a1,a0
  *s = c;
    5c4e:	00e68023          	sb	a4,0(a3)
        off += sputc(buf+off, *s);
    5c52:	00f584bb          	addw	s1,a1,a5
      for(; *s && off < sz; s++)
    5c56:	0785                	add	a5,a5,1
    5c58:	0007c703          	lbu	a4,0(a5)
    5c5c:	d329                	beqz	a4,5b9e <snprintf+0x6a>
    5c5e:	0685                	add	a3,a3,1
    5c60:	fec797e3          	bne	a5,a2,5c4e <snprintf+0x11a>
    5c64:	6946                	ld	s2,80(sp)
    5c66:	69a6                	ld	s3,72(sp)
    5c68:	6a06                	ld	s4,64(sp)
    5c6a:	7ae2                	ld	s5,56(sp)
    5c6c:	7b42                	ld	s6,48(sp)
    5c6e:	7ba2                	ld	s7,40(sp)
    5c70:	7c02                	ld	s8,32(sp)
    5c72:	6ce2                	ld	s9,24(sp)
    5c74:	8526                	mv	a0,s1
    5c76:	70a6                	ld	ra,104(sp)
    5c78:	7406                	ld	s0,96(sp)
    5c7a:	64e6                	ld	s1,88(sp)
    5c7c:	610d                	add	sp,sp,160
    5c7e:	8082                	ret
      for(; *s && off < sz; s++)
    5c80:	02800713          	li	a4,40
        s = "(null)";
    5c84:	00002517          	auipc	a0,0x2
    5c88:	55c50513          	add	a0,a0,1372 # 81e0 <malloc+0x2462>
    5c8c:	b765                	j	5c34 <snprintf+0x100>
  *s = c;
    5c8e:	009b07b3          	add	a5,s6,s1
    5c92:	01478023          	sb	s4,0(a5)
      off += sputc(buf+off, '%');
    5c96:	2485                	addw	s1,s1,1
      break;
    5c98:	b719                	j	5b9e <snprintf+0x6a>
  *s = c;
    5c9a:	009b0733          	add	a4,s6,s1
    5c9e:	01470023          	sb	s4,0(a4)
      off += sputc(buf+off, c);
    5ca2:	0014871b          	addw	a4,s1,1
  *s = c;
    5ca6:	975a                	add	a4,a4,s6
    5ca8:	00f70023          	sb	a5,0(a4)
      off += sputc(buf+off, c);
    5cac:	2489                	addw	s1,s1,2
      break;
    5cae:	bdc5                	j	5b9e <snprintf+0x6a>
    5cb0:	6946                	ld	s2,80(sp)
    5cb2:	69a6                	ld	s3,72(sp)
    5cb4:	6a06                	ld	s4,64(sp)
    5cb6:	7ae2                	ld	s5,56(sp)
    5cb8:	7b42                	ld	s6,48(sp)
    5cba:	7ba2                	ld	s7,40(sp)
    5cbc:	7c02                	ld	s8,32(sp)
    5cbe:	6ce2                	ld	s9,24(sp)
    5cc0:	bf55                	j	5c74 <snprintf+0x140>
    return -1;
    5cc2:	54fd                	li	s1,-1
    5cc4:	bf45                	j	5c74 <snprintf+0x140>
    5cc6:	6946                	ld	s2,80(sp)
    5cc8:	69a6                	ld	s3,72(sp)
    5cca:	6a06                	ld	s4,64(sp)
    5ccc:	7ae2                	ld	s5,56(sp)
    5cce:	7b42                	ld	s6,48(sp)
    5cd0:	7ba2                	ld	s7,40(sp)
    5cd2:	7c02                	ld	s8,32(sp)
    5cd4:	6ce2                	ld	s9,24(sp)
    5cd6:	bf79                	j	5c74 <snprintf+0x140>
    5cd8:	6946                	ld	s2,80(sp)
    5cda:	69a6                	ld	s3,72(sp)
    5cdc:	6a06                	ld	s4,64(sp)
    5cde:	7ae2                	ld	s5,56(sp)
    5ce0:	7b42                	ld	s6,48(sp)
    5ce2:	7ba2                	ld	s7,40(sp)
    5ce4:	7c02                	ld	s8,32(sp)
    5ce6:	6ce2                	ld	s9,24(sp)
    5ce8:	b771                	j	5c74 <snprintf+0x140>
    5cea:	6946                	ld	s2,80(sp)
    5cec:	69a6                	ld	s3,72(sp)
    5cee:	6a06                	ld	s4,64(sp)
    5cf0:	7ae2                	ld	s5,56(sp)
    5cf2:	7b42                	ld	s6,48(sp)
    5cf4:	7ba2                	ld	s7,40(sp)
    5cf6:	7c02                	ld	s8,32(sp)
    5cf8:	6ce2                	ld	s9,24(sp)
    5cfa:	bfad                	j	5c74 <snprintf+0x140>

0000000000005cfc <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    5cfc:	1141                	add	sp,sp,-16
    5cfe:	e422                	sd	s0,8(sp)
    5d00:	0800                	add	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
    5d02:	ff050693          	add	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    5d06:	00003797          	auipc	a5,0x3
    5d0a:	92a7b783          	ld	a5,-1750(a5) # 8630 <freep>
    5d0e:	a02d                	j	5d38 <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
    5d10:	4618                	lw	a4,8(a2)
    5d12:	9f2d                	addw	a4,a4,a1
    5d14:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
    5d18:	6398                	ld	a4,0(a5)
    5d1a:	6310                	ld	a2,0(a4)
    5d1c:	a83d                	j	5d5a <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    5d1e:	ff852703          	lw	a4,-8(a0)
    5d22:	9f31                	addw	a4,a4,a2
    5d24:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
    5d26:	ff053683          	ld	a3,-16(a0)
    5d2a:	a091                	j	5d6e <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    5d2c:	6398                	ld	a4,0(a5)
    5d2e:	00e7e463          	bltu	a5,a4,5d36 <free+0x3a>
    5d32:	00e6ea63          	bltu	a3,a4,5d46 <free+0x4a>
{
    5d36:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    5d38:	fed7fae3          	bgeu	a5,a3,5d2c <free+0x30>
    5d3c:	6398                	ld	a4,0(a5)
    5d3e:	00e6e463          	bltu	a3,a4,5d46 <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    5d42:	fee7eae3          	bltu	a5,a4,5d36 <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
    5d46:	ff852583          	lw	a1,-8(a0)
    5d4a:	6390                	ld	a2,0(a5)
    5d4c:	02059813          	sll	a6,a1,0x20
    5d50:	01c85713          	srl	a4,a6,0x1c
    5d54:	9736                	add	a4,a4,a3
    5d56:	fae60de3          	beq	a2,a4,5d10 <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
    5d5a:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
    5d5e:	4790                	lw	a2,8(a5)
    5d60:	02061593          	sll	a1,a2,0x20
    5d64:	01c5d713          	srl	a4,a1,0x1c
    5d68:	973e                	add	a4,a4,a5
    5d6a:	fae68ae3          	beq	a3,a4,5d1e <free+0x22>
    p->s.ptr = bp->s.ptr;
    5d6e:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
    5d70:	00003717          	auipc	a4,0x3
    5d74:	8cf73023          	sd	a5,-1856(a4) # 8630 <freep>
}
    5d78:	6422                	ld	s0,8(sp)
    5d7a:	0141                	add	sp,sp,16
    5d7c:	8082                	ret

0000000000005d7e <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    5d7e:	7139                	add	sp,sp,-64
    5d80:	fc06                	sd	ra,56(sp)
    5d82:	f822                	sd	s0,48(sp)
    5d84:	f426                	sd	s1,40(sp)
    5d86:	ec4e                	sd	s3,24(sp)
    5d88:	0080                	add	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    5d8a:	02051493          	sll	s1,a0,0x20
    5d8e:	9081                	srl	s1,s1,0x20
    5d90:	04bd                	add	s1,s1,15
    5d92:	8091                	srl	s1,s1,0x4
    5d94:	0014899b          	addw	s3,s1,1
    5d98:	0485                	add	s1,s1,1
  if((prevp = freep) == 0){
    5d9a:	00003517          	auipc	a0,0x3
    5d9e:	89653503          	ld	a0,-1898(a0) # 8630 <freep>
    5da2:	c915                	beqz	a0,5dd6 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    5da4:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    5da6:	4798                	lw	a4,8(a5)
    5da8:	08977e63          	bgeu	a4,s1,5e44 <malloc+0xc6>
    5dac:	f04a                	sd	s2,32(sp)
    5dae:	e852                	sd	s4,16(sp)
    5db0:	e456                	sd	s5,8(sp)
    5db2:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
    5db4:	8a4e                	mv	s4,s3
    5db6:	0009871b          	sext.w	a4,s3
    5dba:	6685                	lui	a3,0x1
    5dbc:	00d77363          	bgeu	a4,a3,5dc2 <malloc+0x44>
    5dc0:	6a05                	lui	s4,0x1
    5dc2:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
    5dc6:	004a1a1b          	sllw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    5dca:	00003917          	auipc	s2,0x3
    5dce:	86690913          	add	s2,s2,-1946 # 8630 <freep>
  if(p == (char*)-1)
    5dd2:	5afd                	li	s5,-1
    5dd4:	a091                	j	5e18 <malloc+0x9a>
    5dd6:	f04a                	sd	s2,32(sp)
    5dd8:	e852                	sd	s4,16(sp)
    5dda:	e456                	sd	s5,8(sp)
    5ddc:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
    5dde:	00009797          	auipc	a5,0x9
    5de2:	07278793          	add	a5,a5,114 # ee50 <base>
    5de6:	00003717          	auipc	a4,0x3
    5dea:	84f73523          	sd	a5,-1974(a4) # 8630 <freep>
    5dee:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
    5df0:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
    5df4:	b7c1                	j	5db4 <malloc+0x36>
        prevp->s.ptr = p->s.ptr;
    5df6:	6398                	ld	a4,0(a5)
    5df8:	e118                	sd	a4,0(a0)
    5dfa:	a08d                	j	5e5c <malloc+0xde>
  hp->s.size = nu;
    5dfc:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
    5e00:	0541                	add	a0,a0,16
    5e02:	00000097          	auipc	ra,0x0
    5e06:	efa080e7          	jalr	-262(ra) # 5cfc <free>
  return freep;
    5e0a:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
    5e0e:	c13d                	beqz	a0,5e74 <malloc+0xf6>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    5e10:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    5e12:	4798                	lw	a4,8(a5)
    5e14:	02977463          	bgeu	a4,s1,5e3c <malloc+0xbe>
    if(p == freep)
    5e18:	00093703          	ld	a4,0(s2)
    5e1c:	853e                	mv	a0,a5
    5e1e:	fef719e3          	bne	a4,a5,5e10 <malloc+0x92>
  p = sbrk(nu * sizeof(Header));
    5e22:	8552                	mv	a0,s4
    5e24:	00000097          	auipc	ra,0x0
    5e28:	92a080e7          	jalr	-1750(ra) # 574e <sbrk>
  if(p == (char*)-1)
    5e2c:	fd5518e3          	bne	a0,s5,5dfc <malloc+0x7e>
        return 0;
    5e30:	4501                	li	a0,0
    5e32:	7902                	ld	s2,32(sp)
    5e34:	6a42                	ld	s4,16(sp)
    5e36:	6aa2                	ld	s5,8(sp)
    5e38:	6b02                	ld	s6,0(sp)
    5e3a:	a03d                	j	5e68 <malloc+0xea>
    5e3c:	7902                	ld	s2,32(sp)
    5e3e:	6a42                	ld	s4,16(sp)
    5e40:	6aa2                	ld	s5,8(sp)
    5e42:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
    5e44:	fae489e3          	beq	s1,a4,5df6 <malloc+0x78>
        p->s.size -= nunits;
    5e48:	4137073b          	subw	a4,a4,s3
    5e4c:	c798                	sw	a4,8(a5)
        p += p->s.size;
    5e4e:	02071693          	sll	a3,a4,0x20
    5e52:	01c6d713          	srl	a4,a3,0x1c
    5e56:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
    5e58:	0137a423          	sw	s3,8(a5)
      freep = prevp;
    5e5c:	00002717          	auipc	a4,0x2
    5e60:	7ca73a23          	sd	a0,2004(a4) # 8630 <freep>
      return (void*)(p + 1);
    5e64:	01078513          	add	a0,a5,16
  }
}
    5e68:	70e2                	ld	ra,56(sp)
    5e6a:	7442                	ld	s0,48(sp)
    5e6c:	74a2                	ld	s1,40(sp)
    5e6e:	69e2                	ld	s3,24(sp)
    5e70:	6121                	add	sp,sp,64
    5e72:	8082                	ret
    5e74:	7902                	ld	s2,32(sp)
    5e76:	6a42                	ld	s4,16(sp)
    5e78:	6aa2                	ld	s5,8(sp)
    5e7a:	6b02                	ld	s6,0(sp)
    5e7c:	b7f5                	j	5e68 <malloc+0xea>
