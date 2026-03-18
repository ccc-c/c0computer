
user/_usertests:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <copyinstr1>:
}

// what if you pass ridiculous string pointers to system calls?
void
copyinstr1(char *s)
{
       0:	711d                	add	sp,sp,-96
       2:	ec86                	sd	ra,88(sp)
       4:	e8a2                	sd	s0,80(sp)
       6:	e4a6                	sd	s1,72(sp)
       8:	e0ca                	sd	s2,64(sp)
       a:	fc4e                	sd	s3,56(sp)
       c:	1080                	add	s0,sp,96
  uint64 addrs[] = { 0x80000000LL, 0x3fffffe000, 0x3ffffff000, 0x4000000000,
       e:	00008797          	auipc	a5,0x8
      12:	a4278793          	add	a5,a5,-1470 # 7a50 <malloc+0x267e>
      16:	638c                	ld	a1,0(a5)
      18:	6790                	ld	a2,8(a5)
      1a:	6b94                	ld	a3,16(a5)
      1c:	6f98                	ld	a4,24(a5)
      1e:	739c                	ld	a5,32(a5)
      20:	fab43423          	sd	a1,-88(s0)
      24:	fac43823          	sd	a2,-80(s0)
      28:	fad43c23          	sd	a3,-72(s0)
      2c:	fce43023          	sd	a4,-64(s0)
      30:	fcf43423          	sd	a5,-56(s0)
                     0xffffffffffffffff };

  for(int ai = 0; ai < sizeof(addrs)/sizeof(addrs[0]); ai++){
      34:	fa840493          	add	s1,s0,-88
      38:	fd040993          	add	s3,s0,-48
    uint64 addr = addrs[ai];

    int fd = open((char *)addr, O_CREATE|O_WRONLY);
      3c:	0004b903          	ld	s2,0(s1)
      40:	20100593          	li	a1,513
      44:	854a                	mv	a0,s2
      46:	6a9040ef          	jal	4eee <open>
    if(fd >= 0){
      4a:	00055c63          	bgez	a0,62 <copyinstr1+0x62>
  for(int ai = 0; ai < sizeof(addrs)/sizeof(addrs[0]); ai++){
      4e:	04a1                	add	s1,s1,8
      50:	ff3496e3          	bne	s1,s3,3c <copyinstr1+0x3c>
      printf("open(%p) returned %d, not -1\n", (void*)addr, fd);
      exit(1);
    }
  }
}
      54:	60e6                	ld	ra,88(sp)
      56:	6446                	ld	s0,80(sp)
      58:	64a6                	ld	s1,72(sp)
      5a:	6906                	ld	s2,64(sp)
      5c:	79e2                	ld	s3,56(sp)
      5e:	6125                	add	sp,sp,96
      60:	8082                	ret
      printf("open(%p) returned %d, not -1\n", (void*)addr, fd);
      62:	862a                	mv	a2,a0
      64:	85ca                	mv	a1,s2
      66:	00005517          	auipc	a0,0x5
      6a:	46a50513          	add	a0,a0,1130 # 54d0 <malloc+0xfe>
      6e:	2b0050ef          	jal	531e <printf>
      exit(1);
      72:	4505                	li	a0,1
      74:	63b040ef          	jal	4eae <exit>

0000000000000078 <bsstest>:
void
bsstest(char *s)
{
  int i;

  for(i = 0; i < sizeof(uninit); i++){
      78:	00009797          	auipc	a5,0x9
      7c:	53078793          	add	a5,a5,1328 # 95a8 <uninit>
      80:	0000c697          	auipc	a3,0xc
      84:	c3868693          	add	a3,a3,-968 # bcb8 <buf>
    if(uninit[i] != '\0'){
      88:	0007c703          	lbu	a4,0(a5)
      8c:	e709                	bnez	a4,96 <bsstest+0x1e>
  for(i = 0; i < sizeof(uninit); i++){
      8e:	0785                	add	a5,a5,1
      90:	fed79ce3          	bne	a5,a3,88 <bsstest+0x10>
      94:	8082                	ret
{
      96:	1141                	add	sp,sp,-16
      98:	e406                	sd	ra,8(sp)
      9a:	e022                	sd	s0,0(sp)
      9c:	0800                	add	s0,sp,16
      printf("%s: bss test failed\n", s);
      9e:	85aa                	mv	a1,a0
      a0:	00005517          	auipc	a0,0x5
      a4:	45050513          	add	a0,a0,1104 # 54f0 <malloc+0x11e>
      a8:	276050ef          	jal	531e <printf>
      exit(1);
      ac:	4505                	li	a0,1
      ae:	601040ef          	jal	4eae <exit>

00000000000000b2 <opentest>:
{
      b2:	1101                	add	sp,sp,-32
      b4:	ec06                	sd	ra,24(sp)
      b6:	e822                	sd	s0,16(sp)
      b8:	e426                	sd	s1,8(sp)
      ba:	1000                	add	s0,sp,32
      bc:	84aa                	mv	s1,a0
  fd = open("echo", 0);
      be:	4581                	li	a1,0
      c0:	00005517          	auipc	a0,0x5
      c4:	44850513          	add	a0,a0,1096 # 5508 <malloc+0x136>
      c8:	627040ef          	jal	4eee <open>
  if(fd < 0){
      cc:	02054263          	bltz	a0,f0 <opentest+0x3e>
  close(fd);
      d0:	607040ef          	jal	4ed6 <close>
  fd = open("doesnotexist", 0);
      d4:	4581                	li	a1,0
      d6:	00005517          	auipc	a0,0x5
      da:	45250513          	add	a0,a0,1106 # 5528 <malloc+0x156>
      de:	611040ef          	jal	4eee <open>
  if(fd >= 0){
      e2:	02055163          	bgez	a0,104 <opentest+0x52>
}
      e6:	60e2                	ld	ra,24(sp)
      e8:	6442                	ld	s0,16(sp)
      ea:	64a2                	ld	s1,8(sp)
      ec:	6105                	add	sp,sp,32
      ee:	8082                	ret
    printf("%s: open echo failed!\n", s);
      f0:	85a6                	mv	a1,s1
      f2:	00005517          	auipc	a0,0x5
      f6:	41e50513          	add	a0,a0,1054 # 5510 <malloc+0x13e>
      fa:	224050ef          	jal	531e <printf>
    exit(1);
      fe:	4505                	li	a0,1
     100:	5af040ef          	jal	4eae <exit>
    printf("%s: open doesnotexist succeeded!\n", s);
     104:	85a6                	mv	a1,s1
     106:	00005517          	auipc	a0,0x5
     10a:	43250513          	add	a0,a0,1074 # 5538 <malloc+0x166>
     10e:	210050ef          	jal	531e <printf>
    exit(1);
     112:	4505                	li	a0,1
     114:	59b040ef          	jal	4eae <exit>

0000000000000118 <truncate2>:
{
     118:	7179                	add	sp,sp,-48
     11a:	f406                	sd	ra,40(sp)
     11c:	f022                	sd	s0,32(sp)
     11e:	ec26                	sd	s1,24(sp)
     120:	e84a                	sd	s2,16(sp)
     122:	e44e                	sd	s3,8(sp)
     124:	1800                	add	s0,sp,48
     126:	89aa                	mv	s3,a0
  unlink("truncfile");
     128:	00005517          	auipc	a0,0x5
     12c:	43850513          	add	a0,a0,1080 # 5560 <malloc+0x18e>
     130:	5cf040ef          	jal	4efe <unlink>
  int fd1 = open("truncfile", O_CREATE|O_TRUNC|O_WRONLY);
     134:	60100593          	li	a1,1537
     138:	00005517          	auipc	a0,0x5
     13c:	42850513          	add	a0,a0,1064 # 5560 <malloc+0x18e>
     140:	5af040ef          	jal	4eee <open>
     144:	84aa                	mv	s1,a0
  write(fd1, "abcd", 4);
     146:	4611                	li	a2,4
     148:	00005597          	auipc	a1,0x5
     14c:	42858593          	add	a1,a1,1064 # 5570 <malloc+0x19e>
     150:	57f040ef          	jal	4ece <write>
  int fd2 = open("truncfile", O_TRUNC|O_WRONLY);
     154:	40100593          	li	a1,1025
     158:	00005517          	auipc	a0,0x5
     15c:	40850513          	add	a0,a0,1032 # 5560 <malloc+0x18e>
     160:	58f040ef          	jal	4eee <open>
     164:	892a                	mv	s2,a0
  int n = write(fd1, "x", 1);
     166:	4605                	li	a2,1
     168:	00005597          	auipc	a1,0x5
     16c:	41058593          	add	a1,a1,1040 # 5578 <malloc+0x1a6>
     170:	8526                	mv	a0,s1
     172:	55d040ef          	jal	4ece <write>
  if(n != -1){
     176:	57fd                	li	a5,-1
     178:	02f51563          	bne	a0,a5,1a2 <truncate2+0x8a>
  unlink("truncfile");
     17c:	00005517          	auipc	a0,0x5
     180:	3e450513          	add	a0,a0,996 # 5560 <malloc+0x18e>
     184:	57b040ef          	jal	4efe <unlink>
  close(fd1);
     188:	8526                	mv	a0,s1
     18a:	54d040ef          	jal	4ed6 <close>
  close(fd2);
     18e:	854a                	mv	a0,s2
     190:	547040ef          	jal	4ed6 <close>
}
     194:	70a2                	ld	ra,40(sp)
     196:	7402                	ld	s0,32(sp)
     198:	64e2                	ld	s1,24(sp)
     19a:	6942                	ld	s2,16(sp)
     19c:	69a2                	ld	s3,8(sp)
     19e:	6145                	add	sp,sp,48
     1a0:	8082                	ret
    printf("%s: write returned %d, expected -1\n", s, n);
     1a2:	862a                	mv	a2,a0
     1a4:	85ce                	mv	a1,s3
     1a6:	00005517          	auipc	a0,0x5
     1aa:	3da50513          	add	a0,a0,986 # 5580 <malloc+0x1ae>
     1ae:	170050ef          	jal	531e <printf>
    exit(1);
     1b2:	4505                	li	a0,1
     1b4:	4fb040ef          	jal	4eae <exit>

00000000000001b8 <createtest>:
{
     1b8:	7179                	add	sp,sp,-48
     1ba:	f406                	sd	ra,40(sp)
     1bc:	f022                	sd	s0,32(sp)
     1be:	ec26                	sd	s1,24(sp)
     1c0:	e84a                	sd	s2,16(sp)
     1c2:	1800                	add	s0,sp,48
  name[0] = 'a';
     1c4:	06100793          	li	a5,97
     1c8:	fcf40c23          	sb	a5,-40(s0)
  name[2] = '\0';
     1cc:	fc040d23          	sb	zero,-38(s0)
     1d0:	03000493          	li	s1,48
  for(i = 0; i < N; i++){
     1d4:	06400913          	li	s2,100
    name[1] = '0' + i;
     1d8:	fc940ca3          	sb	s1,-39(s0)
    fd = open(name, O_CREATE|O_RDWR);
     1dc:	20200593          	li	a1,514
     1e0:	fd840513          	add	a0,s0,-40
     1e4:	50b040ef          	jal	4eee <open>
    close(fd);
     1e8:	4ef040ef          	jal	4ed6 <close>
  for(i = 0; i < N; i++){
     1ec:	2485                	addw	s1,s1,1
     1ee:	0ff4f493          	zext.b	s1,s1
     1f2:	ff2493e3          	bne	s1,s2,1d8 <createtest+0x20>
  name[0] = 'a';
     1f6:	06100793          	li	a5,97
     1fa:	fcf40c23          	sb	a5,-40(s0)
  name[2] = '\0';
     1fe:	fc040d23          	sb	zero,-38(s0)
     202:	03000493          	li	s1,48
  for(i = 0; i < N; i++){
     206:	06400913          	li	s2,100
    name[1] = '0' + i;
     20a:	fc940ca3          	sb	s1,-39(s0)
    unlink(name);
     20e:	fd840513          	add	a0,s0,-40
     212:	4ed040ef          	jal	4efe <unlink>
  for(i = 0; i < N; i++){
     216:	2485                	addw	s1,s1,1
     218:	0ff4f493          	zext.b	s1,s1
     21c:	ff2497e3          	bne	s1,s2,20a <createtest+0x52>
}
     220:	70a2                	ld	ra,40(sp)
     222:	7402                	ld	s0,32(sp)
     224:	64e2                	ld	s1,24(sp)
     226:	6942                	ld	s2,16(sp)
     228:	6145                	add	sp,sp,48
     22a:	8082                	ret

000000000000022c <bigwrite>:
{
     22c:	715d                	add	sp,sp,-80
     22e:	e486                	sd	ra,72(sp)
     230:	e0a2                	sd	s0,64(sp)
     232:	fc26                	sd	s1,56(sp)
     234:	f84a                	sd	s2,48(sp)
     236:	f44e                	sd	s3,40(sp)
     238:	f052                	sd	s4,32(sp)
     23a:	ec56                	sd	s5,24(sp)
     23c:	e85a                	sd	s6,16(sp)
     23e:	e45e                	sd	s7,8(sp)
     240:	0880                	add	s0,sp,80
     242:	8baa                	mv	s7,a0
  unlink("bigwrite");
     244:	00005517          	auipc	a0,0x5
     248:	36450513          	add	a0,a0,868 # 55a8 <malloc+0x1d6>
     24c:	4b3040ef          	jal	4efe <unlink>
  for(sz = 499; sz < (MAXOPBLOCKS+2)*BSIZE; sz += 471){
     250:	1f300493          	li	s1,499
    fd = open("bigwrite", O_CREATE | O_RDWR);
     254:	00005a97          	auipc	s5,0x5
     258:	354a8a93          	add	s5,s5,852 # 55a8 <malloc+0x1d6>
      int cc = write(fd, buf, sz);
     25c:	0000ca17          	auipc	s4,0xc
     260:	a5ca0a13          	add	s4,s4,-1444 # bcb8 <buf>
  for(sz = 499; sz < (MAXOPBLOCKS+2)*BSIZE; sz += 471){
     264:	6b0d                	lui	s6,0x3
     266:	1c9b0b13          	add	s6,s6,457 # 31c9 <rmdot+0x19>
    fd = open("bigwrite", O_CREATE | O_RDWR);
     26a:	20200593          	li	a1,514
     26e:	8556                	mv	a0,s5
     270:	47f040ef          	jal	4eee <open>
     274:	892a                	mv	s2,a0
    if(fd < 0){
     276:	04054563          	bltz	a0,2c0 <bigwrite+0x94>
      int cc = write(fd, buf, sz);
     27a:	8626                	mv	a2,s1
     27c:	85d2                	mv	a1,s4
     27e:	451040ef          	jal	4ece <write>
     282:	89aa                	mv	s3,a0
      if(cc != sz){
     284:	04a49863          	bne	s1,a0,2d4 <bigwrite+0xa8>
      int cc = write(fd, buf, sz);
     288:	8626                	mv	a2,s1
     28a:	85d2                	mv	a1,s4
     28c:	854a                	mv	a0,s2
     28e:	441040ef          	jal	4ece <write>
      if(cc != sz){
     292:	04951263          	bne	a0,s1,2d6 <bigwrite+0xaa>
    close(fd);
     296:	854a                	mv	a0,s2
     298:	43f040ef          	jal	4ed6 <close>
    unlink("bigwrite");
     29c:	8556                	mv	a0,s5
     29e:	461040ef          	jal	4efe <unlink>
  for(sz = 499; sz < (MAXOPBLOCKS+2)*BSIZE; sz += 471){
     2a2:	1d74849b          	addw	s1,s1,471
     2a6:	fd6492e3          	bne	s1,s6,26a <bigwrite+0x3e>
}
     2aa:	60a6                	ld	ra,72(sp)
     2ac:	6406                	ld	s0,64(sp)
     2ae:	74e2                	ld	s1,56(sp)
     2b0:	7942                	ld	s2,48(sp)
     2b2:	79a2                	ld	s3,40(sp)
     2b4:	7a02                	ld	s4,32(sp)
     2b6:	6ae2                	ld	s5,24(sp)
     2b8:	6b42                	ld	s6,16(sp)
     2ba:	6ba2                	ld	s7,8(sp)
     2bc:	6161                	add	sp,sp,80
     2be:	8082                	ret
      printf("%s: cannot create bigwrite\n", s);
     2c0:	85de                	mv	a1,s7
     2c2:	00005517          	auipc	a0,0x5
     2c6:	2f650513          	add	a0,a0,758 # 55b8 <malloc+0x1e6>
     2ca:	054050ef          	jal	531e <printf>
      exit(1);
     2ce:	4505                	li	a0,1
     2d0:	3df040ef          	jal	4eae <exit>
      if(cc != sz){
     2d4:	89a6                	mv	s3,s1
        printf("%s: write(%d) ret %d\n", s, sz, cc);
     2d6:	86aa                	mv	a3,a0
     2d8:	864e                	mv	a2,s3
     2da:	85de                	mv	a1,s7
     2dc:	00005517          	auipc	a0,0x5
     2e0:	2fc50513          	add	a0,a0,764 # 55d8 <malloc+0x206>
     2e4:	03a050ef          	jal	531e <printf>
        exit(1);
     2e8:	4505                	li	a0,1
     2ea:	3c5040ef          	jal	4eae <exit>

00000000000002ee <badwrite>:
// file is deleted? if the kernel has this bug, it will panic: balloc:
// out of blocks. assumed_free may need to be raised to be more than
// the number of free blocks. this test takes a long time.
void
badwrite(char *s)
{
     2ee:	7179                	add	sp,sp,-48
     2f0:	f406                	sd	ra,40(sp)
     2f2:	f022                	sd	s0,32(sp)
     2f4:	ec26                	sd	s1,24(sp)
     2f6:	e84a                	sd	s2,16(sp)
     2f8:	e44e                	sd	s3,8(sp)
     2fa:	e052                	sd	s4,0(sp)
     2fc:	1800                	add	s0,sp,48
  int assumed_free = 600;
  
  unlink("junk");
     2fe:	00005517          	auipc	a0,0x5
     302:	2f250513          	add	a0,a0,754 # 55f0 <malloc+0x21e>
     306:	3f9040ef          	jal	4efe <unlink>
     30a:	25800913          	li	s2,600
  for(int i = 0; i < assumed_free; i++){
    int fd = open("junk", O_CREATE|O_WRONLY);
     30e:	00005997          	auipc	s3,0x5
     312:	2e298993          	add	s3,s3,738 # 55f0 <malloc+0x21e>
    if(fd < 0){
      printf("open junk failed\n");
      exit(1);
    }
    write(fd, (char*)0xffffffffffL, 1);
     316:	5a7d                	li	s4,-1
     318:	018a5a13          	srl	s4,s4,0x18
    int fd = open("junk", O_CREATE|O_WRONLY);
     31c:	20100593          	li	a1,513
     320:	854e                	mv	a0,s3
     322:	3cd040ef          	jal	4eee <open>
     326:	84aa                	mv	s1,a0
    if(fd < 0){
     328:	04054d63          	bltz	a0,382 <badwrite+0x94>
    write(fd, (char*)0xffffffffffL, 1);
     32c:	4605                	li	a2,1
     32e:	85d2                	mv	a1,s4
     330:	39f040ef          	jal	4ece <write>
    close(fd);
     334:	8526                	mv	a0,s1
     336:	3a1040ef          	jal	4ed6 <close>
    unlink("junk");
     33a:	854e                	mv	a0,s3
     33c:	3c3040ef          	jal	4efe <unlink>
  for(int i = 0; i < assumed_free; i++){
     340:	397d                	addw	s2,s2,-1
     342:	fc091de3          	bnez	s2,31c <badwrite+0x2e>
  }

  int fd = open("junk", O_CREATE|O_WRONLY);
     346:	20100593          	li	a1,513
     34a:	00005517          	auipc	a0,0x5
     34e:	2a650513          	add	a0,a0,678 # 55f0 <malloc+0x21e>
     352:	39d040ef          	jal	4eee <open>
     356:	84aa                	mv	s1,a0
  if(fd < 0){
     358:	02054e63          	bltz	a0,394 <badwrite+0xa6>
    printf("open junk failed\n");
    exit(1);
  }
  if(write(fd, "x", 1) != 1){
     35c:	4605                	li	a2,1
     35e:	00005597          	auipc	a1,0x5
     362:	21a58593          	add	a1,a1,538 # 5578 <malloc+0x1a6>
     366:	369040ef          	jal	4ece <write>
     36a:	4785                	li	a5,1
     36c:	02f50d63          	beq	a0,a5,3a6 <badwrite+0xb8>
    printf("write failed\n");
     370:	00005517          	auipc	a0,0x5
     374:	2a050513          	add	a0,a0,672 # 5610 <malloc+0x23e>
     378:	7a7040ef          	jal	531e <printf>
    exit(1);
     37c:	4505                	li	a0,1
     37e:	331040ef          	jal	4eae <exit>
      printf("open junk failed\n");
     382:	00005517          	auipc	a0,0x5
     386:	27650513          	add	a0,a0,630 # 55f8 <malloc+0x226>
     38a:	795040ef          	jal	531e <printf>
      exit(1);
     38e:	4505                	li	a0,1
     390:	31f040ef          	jal	4eae <exit>
    printf("open junk failed\n");
     394:	00005517          	auipc	a0,0x5
     398:	26450513          	add	a0,a0,612 # 55f8 <malloc+0x226>
     39c:	783040ef          	jal	531e <printf>
    exit(1);
     3a0:	4505                	li	a0,1
     3a2:	30d040ef          	jal	4eae <exit>
  }
  close(fd);
     3a6:	8526                	mv	a0,s1
     3a8:	32f040ef          	jal	4ed6 <close>
  unlink("junk");
     3ac:	00005517          	auipc	a0,0x5
     3b0:	24450513          	add	a0,a0,580 # 55f0 <malloc+0x21e>
     3b4:	34b040ef          	jal	4efe <unlink>

  exit(0);
     3b8:	4501                	li	a0,0
     3ba:	2f5040ef          	jal	4eae <exit>

00000000000003be <outofinodes>:
  }
}

void
outofinodes(char *s)
{
     3be:	715d                	add	sp,sp,-80
     3c0:	e486                	sd	ra,72(sp)
     3c2:	e0a2                	sd	s0,64(sp)
     3c4:	fc26                	sd	s1,56(sp)
     3c6:	f84a                	sd	s2,48(sp)
     3c8:	f44e                	sd	s3,40(sp)
     3ca:	0880                	add	s0,sp,80
  int nzz = 32*32;
  for(int i = 0; i < nzz; i++){
     3cc:	4481                	li	s1,0
    char name[32];
    name[0] = 'z';
     3ce:	07a00913          	li	s2,122
  for(int i = 0; i < nzz; i++){
     3d2:	40000993          	li	s3,1024
    name[0] = 'z';
     3d6:	fb240823          	sb	s2,-80(s0)
    name[1] = 'z';
     3da:	fb2408a3          	sb	s2,-79(s0)
    name[2] = '0' + (i / 32);
     3de:	41f4d71b          	sraw	a4,s1,0x1f
     3e2:	01b7571b          	srlw	a4,a4,0x1b
     3e6:	009707bb          	addw	a5,a4,s1
     3ea:	4057d69b          	sraw	a3,a5,0x5
     3ee:	0306869b          	addw	a3,a3,48
     3f2:	fad40923          	sb	a3,-78(s0)
    name[3] = '0' + (i % 32);
     3f6:	8bfd                	and	a5,a5,31
     3f8:	9f99                	subw	a5,a5,a4
     3fa:	0307879b          	addw	a5,a5,48
     3fe:	faf409a3          	sb	a5,-77(s0)
    name[4] = '\0';
     402:	fa040a23          	sb	zero,-76(s0)
    unlink(name);
     406:	fb040513          	add	a0,s0,-80
     40a:	2f5040ef          	jal	4efe <unlink>
    int fd = open(name, O_CREATE|O_RDWR|O_TRUNC);
     40e:	60200593          	li	a1,1538
     412:	fb040513          	add	a0,s0,-80
     416:	2d9040ef          	jal	4eee <open>
    if(fd < 0){
     41a:	00054763          	bltz	a0,428 <outofinodes+0x6a>
      // failure is eventually expected.
      break;
    }
    close(fd);
     41e:	2b9040ef          	jal	4ed6 <close>
  for(int i = 0; i < nzz; i++){
     422:	2485                	addw	s1,s1,1
     424:	fb3499e3          	bne	s1,s3,3d6 <outofinodes+0x18>
     428:	4481                	li	s1,0
  }

  for(int i = 0; i < nzz; i++){
    char name[32];
    name[0] = 'z';
     42a:	07a00913          	li	s2,122
  for(int i = 0; i < nzz; i++){
     42e:	40000993          	li	s3,1024
    name[0] = 'z';
     432:	fb240823          	sb	s2,-80(s0)
    name[1] = 'z';
     436:	fb2408a3          	sb	s2,-79(s0)
    name[2] = '0' + (i / 32);
     43a:	41f4d71b          	sraw	a4,s1,0x1f
     43e:	01b7571b          	srlw	a4,a4,0x1b
     442:	009707bb          	addw	a5,a4,s1
     446:	4057d69b          	sraw	a3,a5,0x5
     44a:	0306869b          	addw	a3,a3,48
     44e:	fad40923          	sb	a3,-78(s0)
    name[3] = '0' + (i % 32);
     452:	8bfd                	and	a5,a5,31
     454:	9f99                	subw	a5,a5,a4
     456:	0307879b          	addw	a5,a5,48
     45a:	faf409a3          	sb	a5,-77(s0)
    name[4] = '\0';
     45e:	fa040a23          	sb	zero,-76(s0)
    unlink(name);
     462:	fb040513          	add	a0,s0,-80
     466:	299040ef          	jal	4efe <unlink>
  for(int i = 0; i < nzz; i++){
     46a:	2485                	addw	s1,s1,1
     46c:	fd3493e3          	bne	s1,s3,432 <outofinodes+0x74>
  }
}
     470:	60a6                	ld	ra,72(sp)
     472:	6406                	ld	s0,64(sp)
     474:	74e2                	ld	s1,56(sp)
     476:	7942                	ld	s2,48(sp)
     478:	79a2                	ld	s3,40(sp)
     47a:	6161                	add	sp,sp,80
     47c:	8082                	ret

000000000000047e <copyin>:
{
     47e:	7159                	add	sp,sp,-112
     480:	f486                	sd	ra,104(sp)
     482:	f0a2                	sd	s0,96(sp)
     484:	eca6                	sd	s1,88(sp)
     486:	e8ca                	sd	s2,80(sp)
     488:	e4ce                	sd	s3,72(sp)
     48a:	e0d2                	sd	s4,64(sp)
     48c:	fc56                	sd	s5,56(sp)
     48e:	1880                	add	s0,sp,112
  uint64 addrs[] = { 0x80000000LL, 0x3fffffe000, 0x3ffffff000, 0x4000000000,
     490:	00007797          	auipc	a5,0x7
     494:	5c078793          	add	a5,a5,1472 # 7a50 <malloc+0x267e>
     498:	638c                	ld	a1,0(a5)
     49a:	6790                	ld	a2,8(a5)
     49c:	6b94                	ld	a3,16(a5)
     49e:	6f98                	ld	a4,24(a5)
     4a0:	739c                	ld	a5,32(a5)
     4a2:	f8b43c23          	sd	a1,-104(s0)
     4a6:	fac43023          	sd	a2,-96(s0)
     4aa:	fad43423          	sd	a3,-88(s0)
     4ae:	fae43823          	sd	a4,-80(s0)
     4b2:	faf43c23          	sd	a5,-72(s0)
  for(int ai = 0; ai < sizeof(addrs)/sizeof(addrs[0]); ai++){
     4b6:	f9840913          	add	s2,s0,-104
     4ba:	fc040a93          	add	s5,s0,-64
    int fd = open("copyin1", O_CREATE|O_WRONLY);
     4be:	00005a17          	auipc	s4,0x5
     4c2:	162a0a13          	add	s4,s4,354 # 5620 <malloc+0x24e>
    uint64 addr = addrs[ai];
     4c6:	00093983          	ld	s3,0(s2)
    int fd = open("copyin1", O_CREATE|O_WRONLY);
     4ca:	20100593          	li	a1,513
     4ce:	8552                	mv	a0,s4
     4d0:	21f040ef          	jal	4eee <open>
     4d4:	84aa                	mv	s1,a0
    if(fd < 0){
     4d6:	06054763          	bltz	a0,544 <copyin+0xc6>
    int n = write(fd, (void*)addr, 8192);
     4da:	6609                	lui	a2,0x2
     4dc:	85ce                	mv	a1,s3
     4de:	1f1040ef          	jal	4ece <write>
    if(n >= 0){
     4e2:	06055a63          	bgez	a0,556 <copyin+0xd8>
    close(fd);
     4e6:	8526                	mv	a0,s1
     4e8:	1ef040ef          	jal	4ed6 <close>
    unlink("copyin1");
     4ec:	8552                	mv	a0,s4
     4ee:	211040ef          	jal	4efe <unlink>
    n = write(1, (char*)addr, 8192);
     4f2:	6609                	lui	a2,0x2
     4f4:	85ce                	mv	a1,s3
     4f6:	4505                	li	a0,1
     4f8:	1d7040ef          	jal	4ece <write>
    if(n > 0){
     4fc:	06a04863          	bgtz	a0,56c <copyin+0xee>
    if(pipe(fds) < 0){
     500:	f9040513          	add	a0,s0,-112
     504:	1bb040ef          	jal	4ebe <pipe>
     508:	06054d63          	bltz	a0,582 <copyin+0x104>
    n = write(fds[1], (char*)addr, 8192);
     50c:	6609                	lui	a2,0x2
     50e:	85ce                	mv	a1,s3
     510:	f9442503          	lw	a0,-108(s0)
     514:	1bb040ef          	jal	4ece <write>
    if(n > 0){
     518:	06a04e63          	bgtz	a0,594 <copyin+0x116>
    close(fds[0]);
     51c:	f9042503          	lw	a0,-112(s0)
     520:	1b7040ef          	jal	4ed6 <close>
    close(fds[1]);
     524:	f9442503          	lw	a0,-108(s0)
     528:	1af040ef          	jal	4ed6 <close>
  for(int ai = 0; ai < sizeof(addrs)/sizeof(addrs[0]); ai++){
     52c:	0921                	add	s2,s2,8
     52e:	f9591ce3          	bne	s2,s5,4c6 <copyin+0x48>
}
     532:	70a6                	ld	ra,104(sp)
     534:	7406                	ld	s0,96(sp)
     536:	64e6                	ld	s1,88(sp)
     538:	6946                	ld	s2,80(sp)
     53a:	69a6                	ld	s3,72(sp)
     53c:	6a06                	ld	s4,64(sp)
     53e:	7ae2                	ld	s5,56(sp)
     540:	6165                	add	sp,sp,112
     542:	8082                	ret
      printf("open(copyin1) failed\n");
     544:	00005517          	auipc	a0,0x5
     548:	0e450513          	add	a0,a0,228 # 5628 <malloc+0x256>
     54c:	5d3040ef          	jal	531e <printf>
      exit(1);
     550:	4505                	li	a0,1
     552:	15d040ef          	jal	4eae <exit>
      printf("write(fd, %p, 8192) returned %d, not -1\n", (void*)addr, n);
     556:	862a                	mv	a2,a0
     558:	85ce                	mv	a1,s3
     55a:	00005517          	auipc	a0,0x5
     55e:	0e650513          	add	a0,a0,230 # 5640 <malloc+0x26e>
     562:	5bd040ef          	jal	531e <printf>
      exit(1);
     566:	4505                	li	a0,1
     568:	147040ef          	jal	4eae <exit>
      printf("write(1, %p, 8192) returned %d, not -1 or 0\n", (void*)addr, n);
     56c:	862a                	mv	a2,a0
     56e:	85ce                	mv	a1,s3
     570:	00005517          	auipc	a0,0x5
     574:	10050513          	add	a0,a0,256 # 5670 <malloc+0x29e>
     578:	5a7040ef          	jal	531e <printf>
      exit(1);
     57c:	4505                	li	a0,1
     57e:	131040ef          	jal	4eae <exit>
      printf("pipe() failed\n");
     582:	00005517          	auipc	a0,0x5
     586:	11e50513          	add	a0,a0,286 # 56a0 <malloc+0x2ce>
     58a:	595040ef          	jal	531e <printf>
      exit(1);
     58e:	4505                	li	a0,1
     590:	11f040ef          	jal	4eae <exit>
      printf("write(pipe, %p, 8192) returned %d, not -1 or 0\n", (void*)addr, n);
     594:	862a                	mv	a2,a0
     596:	85ce                	mv	a1,s3
     598:	00005517          	auipc	a0,0x5
     59c:	11850513          	add	a0,a0,280 # 56b0 <malloc+0x2de>
     5a0:	57f040ef          	jal	531e <printf>
      exit(1);
     5a4:	4505                	li	a0,1
     5a6:	109040ef          	jal	4eae <exit>

00000000000005aa <copyout>:
{
     5aa:	7119                	add	sp,sp,-128
     5ac:	fc86                	sd	ra,120(sp)
     5ae:	f8a2                	sd	s0,112(sp)
     5b0:	f4a6                	sd	s1,104(sp)
     5b2:	f0ca                	sd	s2,96(sp)
     5b4:	ecce                	sd	s3,88(sp)
     5b6:	e8d2                	sd	s4,80(sp)
     5b8:	e4d6                	sd	s5,72(sp)
     5ba:	e0da                	sd	s6,64(sp)
     5bc:	0100                	add	s0,sp,128
  uint64 addrs[] = { 0LL, 0x80000000LL, 0x3fffffe000, 0x3ffffff000, 0x4000000000,
     5be:	00007797          	auipc	a5,0x7
     5c2:	49278793          	add	a5,a5,1170 # 7a50 <malloc+0x267e>
     5c6:	7788                	ld	a0,40(a5)
     5c8:	7b8c                	ld	a1,48(a5)
     5ca:	7f90                	ld	a2,56(a5)
     5cc:	63b4                	ld	a3,64(a5)
     5ce:	67b8                	ld	a4,72(a5)
     5d0:	6bbc                	ld	a5,80(a5)
     5d2:	f8a43823          	sd	a0,-112(s0)
     5d6:	f8b43c23          	sd	a1,-104(s0)
     5da:	fac43023          	sd	a2,-96(s0)
     5de:	fad43423          	sd	a3,-88(s0)
     5e2:	fae43823          	sd	a4,-80(s0)
     5e6:	faf43c23          	sd	a5,-72(s0)
  for(int ai = 0; ai < sizeof(addrs)/sizeof(addrs[0]); ai++){
     5ea:	f9040913          	add	s2,s0,-112
     5ee:	fc040b13          	add	s6,s0,-64
    int fd = open("README", 0);
     5f2:	00005a17          	auipc	s4,0x5
     5f6:	0eea0a13          	add	s4,s4,238 # 56e0 <malloc+0x30e>
    n = write(fds[1], "x", 1);
     5fa:	00005a97          	auipc	s5,0x5
     5fe:	f7ea8a93          	add	s5,s5,-130 # 5578 <malloc+0x1a6>
    uint64 addr = addrs[ai];
     602:	00093983          	ld	s3,0(s2)
    int fd = open("README", 0);
     606:	4581                	li	a1,0
     608:	8552                	mv	a0,s4
     60a:	0e5040ef          	jal	4eee <open>
     60e:	84aa                	mv	s1,a0
    if(fd < 0){
     610:	06054763          	bltz	a0,67e <copyout+0xd4>
    int n = read(fd, (void*)addr, 8192);
     614:	6609                	lui	a2,0x2
     616:	85ce                	mv	a1,s3
     618:	0af040ef          	jal	4ec6 <read>
    if(n > 0){
     61c:	06a04a63          	bgtz	a0,690 <copyout+0xe6>
    close(fd);
     620:	8526                	mv	a0,s1
     622:	0b5040ef          	jal	4ed6 <close>
    if(pipe(fds) < 0){
     626:	f8840513          	add	a0,s0,-120
     62a:	095040ef          	jal	4ebe <pipe>
     62e:	06054c63          	bltz	a0,6a6 <copyout+0xfc>
    n = write(fds[1], "x", 1);
     632:	4605                	li	a2,1
     634:	85d6                	mv	a1,s5
     636:	f8c42503          	lw	a0,-116(s0)
     63a:	095040ef          	jal	4ece <write>
    if(n != 1){
     63e:	4785                	li	a5,1
     640:	06f51c63          	bne	a0,a5,6b8 <copyout+0x10e>
    n = read(fds[0], (void*)addr, 8192);
     644:	6609                	lui	a2,0x2
     646:	85ce                	mv	a1,s3
     648:	f8842503          	lw	a0,-120(s0)
     64c:	07b040ef          	jal	4ec6 <read>
    if(n > 0){
     650:	06a04d63          	bgtz	a0,6ca <copyout+0x120>
    close(fds[0]);
     654:	f8842503          	lw	a0,-120(s0)
     658:	07f040ef          	jal	4ed6 <close>
    close(fds[1]);
     65c:	f8c42503          	lw	a0,-116(s0)
     660:	077040ef          	jal	4ed6 <close>
  for(int ai = 0; ai < sizeof(addrs)/sizeof(addrs[0]); ai++){
     664:	0921                	add	s2,s2,8
     666:	f9691ee3          	bne	s2,s6,602 <copyout+0x58>
}
     66a:	70e6                	ld	ra,120(sp)
     66c:	7446                	ld	s0,112(sp)
     66e:	74a6                	ld	s1,104(sp)
     670:	7906                	ld	s2,96(sp)
     672:	69e6                	ld	s3,88(sp)
     674:	6a46                	ld	s4,80(sp)
     676:	6aa6                	ld	s5,72(sp)
     678:	6b06                	ld	s6,64(sp)
     67a:	6109                	add	sp,sp,128
     67c:	8082                	ret
      printf("open(README) failed\n");
     67e:	00005517          	auipc	a0,0x5
     682:	06a50513          	add	a0,a0,106 # 56e8 <malloc+0x316>
     686:	499040ef          	jal	531e <printf>
      exit(1);
     68a:	4505                	li	a0,1
     68c:	023040ef          	jal	4eae <exit>
      printf("read(fd, %p, 8192) returned %d, not -1 or 0\n", (void*)addr, n);
     690:	862a                	mv	a2,a0
     692:	85ce                	mv	a1,s3
     694:	00005517          	auipc	a0,0x5
     698:	06c50513          	add	a0,a0,108 # 5700 <malloc+0x32e>
     69c:	483040ef          	jal	531e <printf>
      exit(1);
     6a0:	4505                	li	a0,1
     6a2:	00d040ef          	jal	4eae <exit>
      printf("pipe() failed\n");
     6a6:	00005517          	auipc	a0,0x5
     6aa:	ffa50513          	add	a0,a0,-6 # 56a0 <malloc+0x2ce>
     6ae:	471040ef          	jal	531e <printf>
      exit(1);
     6b2:	4505                	li	a0,1
     6b4:	7fa040ef          	jal	4eae <exit>
      printf("pipe write failed\n");
     6b8:	00005517          	auipc	a0,0x5
     6bc:	07850513          	add	a0,a0,120 # 5730 <malloc+0x35e>
     6c0:	45f040ef          	jal	531e <printf>
      exit(1);
     6c4:	4505                	li	a0,1
     6c6:	7e8040ef          	jal	4eae <exit>
      printf("read(pipe, %p, 8192) returned %d, not -1 or 0\n", (void*)addr, n);
     6ca:	862a                	mv	a2,a0
     6cc:	85ce                	mv	a1,s3
     6ce:	00005517          	auipc	a0,0x5
     6d2:	07a50513          	add	a0,a0,122 # 5748 <malloc+0x376>
     6d6:	449040ef          	jal	531e <printf>
      exit(1);
     6da:	4505                	li	a0,1
     6dc:	7d2040ef          	jal	4eae <exit>

00000000000006e0 <truncate1>:
{
     6e0:	711d                	add	sp,sp,-96
     6e2:	ec86                	sd	ra,88(sp)
     6e4:	e8a2                	sd	s0,80(sp)
     6e6:	e4a6                	sd	s1,72(sp)
     6e8:	e0ca                	sd	s2,64(sp)
     6ea:	fc4e                	sd	s3,56(sp)
     6ec:	f852                	sd	s4,48(sp)
     6ee:	f456                	sd	s5,40(sp)
     6f0:	1080                	add	s0,sp,96
     6f2:	8aaa                	mv	s5,a0
  unlink("truncfile");
     6f4:	00005517          	auipc	a0,0x5
     6f8:	e6c50513          	add	a0,a0,-404 # 5560 <malloc+0x18e>
     6fc:	003040ef          	jal	4efe <unlink>
  int fd1 = open("truncfile", O_CREATE|O_WRONLY|O_TRUNC);
     700:	60100593          	li	a1,1537
     704:	00005517          	auipc	a0,0x5
     708:	e5c50513          	add	a0,a0,-420 # 5560 <malloc+0x18e>
     70c:	7e2040ef          	jal	4eee <open>
     710:	84aa                	mv	s1,a0
  write(fd1, "abcd", 4);
     712:	4611                	li	a2,4
     714:	00005597          	auipc	a1,0x5
     718:	e5c58593          	add	a1,a1,-420 # 5570 <malloc+0x19e>
     71c:	7b2040ef          	jal	4ece <write>
  close(fd1);
     720:	8526                	mv	a0,s1
     722:	7b4040ef          	jal	4ed6 <close>
  int fd2 = open("truncfile", O_RDONLY);
     726:	4581                	li	a1,0
     728:	00005517          	auipc	a0,0x5
     72c:	e3850513          	add	a0,a0,-456 # 5560 <malloc+0x18e>
     730:	7be040ef          	jal	4eee <open>
     734:	84aa                	mv	s1,a0
  int n = read(fd2, buf, sizeof(buf));
     736:	02000613          	li	a2,32
     73a:	fa040593          	add	a1,s0,-96
     73e:	788040ef          	jal	4ec6 <read>
  if(n != 4){
     742:	4791                	li	a5,4
     744:	0af51863          	bne	a0,a5,7f4 <truncate1+0x114>
  fd1 = open("truncfile", O_WRONLY|O_TRUNC);
     748:	40100593          	li	a1,1025
     74c:	00005517          	auipc	a0,0x5
     750:	e1450513          	add	a0,a0,-492 # 5560 <malloc+0x18e>
     754:	79a040ef          	jal	4eee <open>
     758:	89aa                	mv	s3,a0
  int fd3 = open("truncfile", O_RDONLY);
     75a:	4581                	li	a1,0
     75c:	00005517          	auipc	a0,0x5
     760:	e0450513          	add	a0,a0,-508 # 5560 <malloc+0x18e>
     764:	78a040ef          	jal	4eee <open>
     768:	892a                	mv	s2,a0
  n = read(fd3, buf, sizeof(buf));
     76a:	02000613          	li	a2,32
     76e:	fa040593          	add	a1,s0,-96
     772:	754040ef          	jal	4ec6 <read>
     776:	8a2a                	mv	s4,a0
  if(n != 0){
     778:	e949                	bnez	a0,80a <truncate1+0x12a>
  n = read(fd2, buf, sizeof(buf));
     77a:	02000613          	li	a2,32
     77e:	fa040593          	add	a1,s0,-96
     782:	8526                	mv	a0,s1
     784:	742040ef          	jal	4ec6 <read>
     788:	8a2a                	mv	s4,a0
  if(n != 0){
     78a:	e155                	bnez	a0,82e <truncate1+0x14e>
  write(fd1, "abcdef", 6);
     78c:	4619                	li	a2,6
     78e:	00005597          	auipc	a1,0x5
     792:	04a58593          	add	a1,a1,74 # 57d8 <malloc+0x406>
     796:	854e                	mv	a0,s3
     798:	736040ef          	jal	4ece <write>
  n = read(fd3, buf, sizeof(buf));
     79c:	02000613          	li	a2,32
     7a0:	fa040593          	add	a1,s0,-96
     7a4:	854a                	mv	a0,s2
     7a6:	720040ef          	jal	4ec6 <read>
  if(n != 6){
     7aa:	4799                	li	a5,6
     7ac:	0af51363          	bne	a0,a5,852 <truncate1+0x172>
  n = read(fd2, buf, sizeof(buf));
     7b0:	02000613          	li	a2,32
     7b4:	fa040593          	add	a1,s0,-96
     7b8:	8526                	mv	a0,s1
     7ba:	70c040ef          	jal	4ec6 <read>
  if(n != 2){
     7be:	4789                	li	a5,2
     7c0:	0af51463          	bne	a0,a5,868 <truncate1+0x188>
  unlink("truncfile");
     7c4:	00005517          	auipc	a0,0x5
     7c8:	d9c50513          	add	a0,a0,-612 # 5560 <malloc+0x18e>
     7cc:	732040ef          	jal	4efe <unlink>
  close(fd1);
     7d0:	854e                	mv	a0,s3
     7d2:	704040ef          	jal	4ed6 <close>
  close(fd2);
     7d6:	8526                	mv	a0,s1
     7d8:	6fe040ef          	jal	4ed6 <close>
  close(fd3);
     7dc:	854a                	mv	a0,s2
     7de:	6f8040ef          	jal	4ed6 <close>
}
     7e2:	60e6                	ld	ra,88(sp)
     7e4:	6446                	ld	s0,80(sp)
     7e6:	64a6                	ld	s1,72(sp)
     7e8:	6906                	ld	s2,64(sp)
     7ea:	79e2                	ld	s3,56(sp)
     7ec:	7a42                	ld	s4,48(sp)
     7ee:	7aa2                	ld	s5,40(sp)
     7f0:	6125                	add	sp,sp,96
     7f2:	8082                	ret
    printf("%s: read %d bytes, wanted 4\n", s, n);
     7f4:	862a                	mv	a2,a0
     7f6:	85d6                	mv	a1,s5
     7f8:	00005517          	auipc	a0,0x5
     7fc:	f8050513          	add	a0,a0,-128 # 5778 <malloc+0x3a6>
     800:	31f040ef          	jal	531e <printf>
    exit(1);
     804:	4505                	li	a0,1
     806:	6a8040ef          	jal	4eae <exit>
    printf("aaa fd3=%d\n", fd3);
     80a:	85ca                	mv	a1,s2
     80c:	00005517          	auipc	a0,0x5
     810:	f8c50513          	add	a0,a0,-116 # 5798 <malloc+0x3c6>
     814:	30b040ef          	jal	531e <printf>
    printf("%s: read %d bytes, wanted 0\n", s, n);
     818:	8652                	mv	a2,s4
     81a:	85d6                	mv	a1,s5
     81c:	00005517          	auipc	a0,0x5
     820:	f8c50513          	add	a0,a0,-116 # 57a8 <malloc+0x3d6>
     824:	2fb040ef          	jal	531e <printf>
    exit(1);
     828:	4505                	li	a0,1
     82a:	684040ef          	jal	4eae <exit>
    printf("bbb fd2=%d\n", fd2);
     82e:	85a6                	mv	a1,s1
     830:	00005517          	auipc	a0,0x5
     834:	f9850513          	add	a0,a0,-104 # 57c8 <malloc+0x3f6>
     838:	2e7040ef          	jal	531e <printf>
    printf("%s: read %d bytes, wanted 0\n", s, n);
     83c:	8652                	mv	a2,s4
     83e:	85d6                	mv	a1,s5
     840:	00005517          	auipc	a0,0x5
     844:	f6850513          	add	a0,a0,-152 # 57a8 <malloc+0x3d6>
     848:	2d7040ef          	jal	531e <printf>
    exit(1);
     84c:	4505                	li	a0,1
     84e:	660040ef          	jal	4eae <exit>
    printf("%s: read %d bytes, wanted 6\n", s, n);
     852:	862a                	mv	a2,a0
     854:	85d6                	mv	a1,s5
     856:	00005517          	auipc	a0,0x5
     85a:	f8a50513          	add	a0,a0,-118 # 57e0 <malloc+0x40e>
     85e:	2c1040ef          	jal	531e <printf>
    exit(1);
     862:	4505                	li	a0,1
     864:	64a040ef          	jal	4eae <exit>
    printf("%s: read %d bytes, wanted 2\n", s, n);
     868:	862a                	mv	a2,a0
     86a:	85d6                	mv	a1,s5
     86c:	00005517          	auipc	a0,0x5
     870:	f9450513          	add	a0,a0,-108 # 5800 <malloc+0x42e>
     874:	2ab040ef          	jal	531e <printf>
    exit(1);
     878:	4505                	li	a0,1
     87a:	634040ef          	jal	4eae <exit>

000000000000087e <writetest>:
{
     87e:	7139                	add	sp,sp,-64
     880:	fc06                	sd	ra,56(sp)
     882:	f822                	sd	s0,48(sp)
     884:	f426                	sd	s1,40(sp)
     886:	f04a                	sd	s2,32(sp)
     888:	ec4e                	sd	s3,24(sp)
     88a:	e852                	sd	s4,16(sp)
     88c:	e456                	sd	s5,8(sp)
     88e:	e05a                	sd	s6,0(sp)
     890:	0080                	add	s0,sp,64
     892:	8b2a                	mv	s6,a0
  fd = open("small", O_CREATE|O_RDWR);
     894:	20200593          	li	a1,514
     898:	00005517          	auipc	a0,0x5
     89c:	f8850513          	add	a0,a0,-120 # 5820 <malloc+0x44e>
     8a0:	64e040ef          	jal	4eee <open>
  if(fd < 0){
     8a4:	08054f63          	bltz	a0,942 <writetest+0xc4>
     8a8:	892a                	mv	s2,a0
     8aa:	4481                	li	s1,0
    if(write(fd, "aaaaaaaaaa", SZ) != SZ){
     8ac:	00005997          	auipc	s3,0x5
     8b0:	f9c98993          	add	s3,s3,-100 # 5848 <malloc+0x476>
    if(write(fd, "bbbbbbbbbb", SZ) != SZ){
     8b4:	00005a97          	auipc	s5,0x5
     8b8:	fcca8a93          	add	s5,s5,-52 # 5880 <malloc+0x4ae>
  for(i = 0; i < N; i++){
     8bc:	06400a13          	li	s4,100
    if(write(fd, "aaaaaaaaaa", SZ) != SZ){
     8c0:	4629                	li	a2,10
     8c2:	85ce                	mv	a1,s3
     8c4:	854a                	mv	a0,s2
     8c6:	608040ef          	jal	4ece <write>
     8ca:	47a9                	li	a5,10
     8cc:	08f51563          	bne	a0,a5,956 <writetest+0xd8>
    if(write(fd, "bbbbbbbbbb", SZ) != SZ){
     8d0:	4629                	li	a2,10
     8d2:	85d6                	mv	a1,s5
     8d4:	854a                	mv	a0,s2
     8d6:	5f8040ef          	jal	4ece <write>
     8da:	47a9                	li	a5,10
     8dc:	08f51863          	bne	a0,a5,96c <writetest+0xee>
  for(i = 0; i < N; i++){
     8e0:	2485                	addw	s1,s1,1
     8e2:	fd449fe3          	bne	s1,s4,8c0 <writetest+0x42>
  close(fd);
     8e6:	854a                	mv	a0,s2
     8e8:	5ee040ef          	jal	4ed6 <close>
  fd = open("small", O_RDONLY);
     8ec:	4581                	li	a1,0
     8ee:	00005517          	auipc	a0,0x5
     8f2:	f3250513          	add	a0,a0,-206 # 5820 <malloc+0x44e>
     8f6:	5f8040ef          	jal	4eee <open>
     8fa:	84aa                	mv	s1,a0
  if(fd < 0){
     8fc:	08054363          	bltz	a0,982 <writetest+0x104>
  i = read(fd, buf, N*SZ*2);
     900:	7d000613          	li	a2,2000
     904:	0000b597          	auipc	a1,0xb
     908:	3b458593          	add	a1,a1,948 # bcb8 <buf>
     90c:	5ba040ef          	jal	4ec6 <read>
  if(i != N*SZ*2){
     910:	7d000793          	li	a5,2000
     914:	08f51163          	bne	a0,a5,996 <writetest+0x118>
  close(fd);
     918:	8526                	mv	a0,s1
     91a:	5bc040ef          	jal	4ed6 <close>
  if(unlink("small") < 0){
     91e:	00005517          	auipc	a0,0x5
     922:	f0250513          	add	a0,a0,-254 # 5820 <malloc+0x44e>
     926:	5d8040ef          	jal	4efe <unlink>
     92a:	08054063          	bltz	a0,9aa <writetest+0x12c>
}
     92e:	70e2                	ld	ra,56(sp)
     930:	7442                	ld	s0,48(sp)
     932:	74a2                	ld	s1,40(sp)
     934:	7902                	ld	s2,32(sp)
     936:	69e2                	ld	s3,24(sp)
     938:	6a42                	ld	s4,16(sp)
     93a:	6aa2                	ld	s5,8(sp)
     93c:	6b02                	ld	s6,0(sp)
     93e:	6121                	add	sp,sp,64
     940:	8082                	ret
    printf("%s: error: creat small failed!\n", s);
     942:	85da                	mv	a1,s6
     944:	00005517          	auipc	a0,0x5
     948:	ee450513          	add	a0,a0,-284 # 5828 <malloc+0x456>
     94c:	1d3040ef          	jal	531e <printf>
    exit(1);
     950:	4505                	li	a0,1
     952:	55c040ef          	jal	4eae <exit>
      printf("%s: error: write aa %d new file failed\n", s, i);
     956:	8626                	mv	a2,s1
     958:	85da                	mv	a1,s6
     95a:	00005517          	auipc	a0,0x5
     95e:	efe50513          	add	a0,a0,-258 # 5858 <malloc+0x486>
     962:	1bd040ef          	jal	531e <printf>
      exit(1);
     966:	4505                	li	a0,1
     968:	546040ef          	jal	4eae <exit>
      printf("%s: error: write bb %d new file failed\n", s, i);
     96c:	8626                	mv	a2,s1
     96e:	85da                	mv	a1,s6
     970:	00005517          	auipc	a0,0x5
     974:	f2050513          	add	a0,a0,-224 # 5890 <malloc+0x4be>
     978:	1a7040ef          	jal	531e <printf>
      exit(1);
     97c:	4505                	li	a0,1
     97e:	530040ef          	jal	4eae <exit>
    printf("%s: error: open small failed!\n", s);
     982:	85da                	mv	a1,s6
     984:	00005517          	auipc	a0,0x5
     988:	f3450513          	add	a0,a0,-204 # 58b8 <malloc+0x4e6>
     98c:	193040ef          	jal	531e <printf>
    exit(1);
     990:	4505                	li	a0,1
     992:	51c040ef          	jal	4eae <exit>
    printf("%s: read failed\n", s);
     996:	85da                	mv	a1,s6
     998:	00005517          	auipc	a0,0x5
     99c:	f4050513          	add	a0,a0,-192 # 58d8 <malloc+0x506>
     9a0:	17f040ef          	jal	531e <printf>
    exit(1);
     9a4:	4505                	li	a0,1
     9a6:	508040ef          	jal	4eae <exit>
    printf("%s: unlink small failed\n", s);
     9aa:	85da                	mv	a1,s6
     9ac:	00005517          	auipc	a0,0x5
     9b0:	f4450513          	add	a0,a0,-188 # 58f0 <malloc+0x51e>
     9b4:	16b040ef          	jal	531e <printf>
    exit(1);
     9b8:	4505                	li	a0,1
     9ba:	4f4040ef          	jal	4eae <exit>

00000000000009be <writebig>:
{
     9be:	7139                	add	sp,sp,-64
     9c0:	fc06                	sd	ra,56(sp)
     9c2:	f822                	sd	s0,48(sp)
     9c4:	f426                	sd	s1,40(sp)
     9c6:	f04a                	sd	s2,32(sp)
     9c8:	ec4e                	sd	s3,24(sp)
     9ca:	e852                	sd	s4,16(sp)
     9cc:	e456                	sd	s5,8(sp)
     9ce:	0080                	add	s0,sp,64
     9d0:	8aaa                	mv	s5,a0
  fd = open("big", O_CREATE|O_RDWR);
     9d2:	20200593          	li	a1,514
     9d6:	00005517          	auipc	a0,0x5
     9da:	f3a50513          	add	a0,a0,-198 # 5910 <malloc+0x53e>
     9de:	510040ef          	jal	4eee <open>
     9e2:	89aa                	mv	s3,a0
  for(i = 0; i < MAXFILE; i++){
     9e4:	4481                	li	s1,0
    ((int*)buf)[0] = i;
     9e6:	0000b917          	auipc	s2,0xb
     9ea:	2d290913          	add	s2,s2,722 # bcb8 <buf>
  for(i = 0; i < MAXFILE; i++){
     9ee:	10c00a13          	li	s4,268
  if(fd < 0){
     9f2:	06054463          	bltz	a0,a5a <writebig+0x9c>
    ((int*)buf)[0] = i;
     9f6:	00992023          	sw	s1,0(s2)
    if(write(fd, buf, BSIZE) != BSIZE){
     9fa:	40000613          	li	a2,1024
     9fe:	85ca                	mv	a1,s2
     a00:	854e                	mv	a0,s3
     a02:	4cc040ef          	jal	4ece <write>
     a06:	40000793          	li	a5,1024
     a0a:	06f51263          	bne	a0,a5,a6e <writebig+0xb0>
  for(i = 0; i < MAXFILE; i++){
     a0e:	2485                	addw	s1,s1,1
     a10:	ff4493e3          	bne	s1,s4,9f6 <writebig+0x38>
  close(fd);
     a14:	854e                	mv	a0,s3
     a16:	4c0040ef          	jal	4ed6 <close>
  fd = open("big", O_RDONLY);
     a1a:	4581                	li	a1,0
     a1c:	00005517          	auipc	a0,0x5
     a20:	ef450513          	add	a0,a0,-268 # 5910 <malloc+0x53e>
     a24:	4ca040ef          	jal	4eee <open>
     a28:	89aa                	mv	s3,a0
  n = 0;
     a2a:	4481                	li	s1,0
    i = read(fd, buf, BSIZE);
     a2c:	0000b917          	auipc	s2,0xb
     a30:	28c90913          	add	s2,s2,652 # bcb8 <buf>
  if(fd < 0){
     a34:	04054863          	bltz	a0,a84 <writebig+0xc6>
    i = read(fd, buf, BSIZE);
     a38:	40000613          	li	a2,1024
     a3c:	85ca                	mv	a1,s2
     a3e:	854e                	mv	a0,s3
     a40:	486040ef          	jal	4ec6 <read>
    if(i == 0){
     a44:	c931                	beqz	a0,a98 <writebig+0xda>
    } else if(i != BSIZE){
     a46:	40000793          	li	a5,1024
     a4a:	08f51a63          	bne	a0,a5,ade <writebig+0x120>
    if(((int*)buf)[0] != n){
     a4e:	00092683          	lw	a3,0(s2)
     a52:	0a969163          	bne	a3,s1,af4 <writebig+0x136>
    n++;
     a56:	2485                	addw	s1,s1,1
    i = read(fd, buf, BSIZE);
     a58:	b7c5                	j	a38 <writebig+0x7a>
    printf("%s: error: creat big failed!\n", s);
     a5a:	85d6                	mv	a1,s5
     a5c:	00005517          	auipc	a0,0x5
     a60:	ebc50513          	add	a0,a0,-324 # 5918 <malloc+0x546>
     a64:	0bb040ef          	jal	531e <printf>
    exit(1);
     a68:	4505                	li	a0,1
     a6a:	444040ef          	jal	4eae <exit>
      printf("%s: error: write big file failed i=%d\n", s, i);
     a6e:	8626                	mv	a2,s1
     a70:	85d6                	mv	a1,s5
     a72:	00005517          	auipc	a0,0x5
     a76:	ec650513          	add	a0,a0,-314 # 5938 <malloc+0x566>
     a7a:	0a5040ef          	jal	531e <printf>
      exit(1);
     a7e:	4505                	li	a0,1
     a80:	42e040ef          	jal	4eae <exit>
    printf("%s: error: open big failed!\n", s);
     a84:	85d6                	mv	a1,s5
     a86:	00005517          	auipc	a0,0x5
     a8a:	eda50513          	add	a0,a0,-294 # 5960 <malloc+0x58e>
     a8e:	091040ef          	jal	531e <printf>
    exit(1);
     a92:	4505                	li	a0,1
     a94:	41a040ef          	jal	4eae <exit>
      if(n != MAXFILE){
     a98:	10c00793          	li	a5,268
     a9c:	02f49663          	bne	s1,a5,ac8 <writebig+0x10a>
  close(fd);
     aa0:	854e                	mv	a0,s3
     aa2:	434040ef          	jal	4ed6 <close>
  if(unlink("big") < 0){
     aa6:	00005517          	auipc	a0,0x5
     aaa:	e6a50513          	add	a0,a0,-406 # 5910 <malloc+0x53e>
     aae:	450040ef          	jal	4efe <unlink>
     ab2:	04054c63          	bltz	a0,b0a <writebig+0x14c>
}
     ab6:	70e2                	ld	ra,56(sp)
     ab8:	7442                	ld	s0,48(sp)
     aba:	74a2                	ld	s1,40(sp)
     abc:	7902                	ld	s2,32(sp)
     abe:	69e2                	ld	s3,24(sp)
     ac0:	6a42                	ld	s4,16(sp)
     ac2:	6aa2                	ld	s5,8(sp)
     ac4:	6121                	add	sp,sp,64
     ac6:	8082                	ret
        printf("%s: read only %d blocks from big", s, n);
     ac8:	8626                	mv	a2,s1
     aca:	85d6                	mv	a1,s5
     acc:	00005517          	auipc	a0,0x5
     ad0:	eb450513          	add	a0,a0,-332 # 5980 <malloc+0x5ae>
     ad4:	04b040ef          	jal	531e <printf>
        exit(1);
     ad8:	4505                	li	a0,1
     ada:	3d4040ef          	jal	4eae <exit>
      printf("%s: read failed %d\n", s, i);
     ade:	862a                	mv	a2,a0
     ae0:	85d6                	mv	a1,s5
     ae2:	00005517          	auipc	a0,0x5
     ae6:	ec650513          	add	a0,a0,-314 # 59a8 <malloc+0x5d6>
     aea:	035040ef          	jal	531e <printf>
      exit(1);
     aee:	4505                	li	a0,1
     af0:	3be040ef          	jal	4eae <exit>
      printf("%s: read content of block %d is %d\n", s,
     af4:	8626                	mv	a2,s1
     af6:	85d6                	mv	a1,s5
     af8:	00005517          	auipc	a0,0x5
     afc:	ec850513          	add	a0,a0,-312 # 59c0 <malloc+0x5ee>
     b00:	01f040ef          	jal	531e <printf>
      exit(1);
     b04:	4505                	li	a0,1
     b06:	3a8040ef          	jal	4eae <exit>
    printf("%s: unlink big failed\n", s);
     b0a:	85d6                	mv	a1,s5
     b0c:	00005517          	auipc	a0,0x5
     b10:	edc50513          	add	a0,a0,-292 # 59e8 <malloc+0x616>
     b14:	00b040ef          	jal	531e <printf>
    exit(1);
     b18:	4505                	li	a0,1
     b1a:	394040ef          	jal	4eae <exit>

0000000000000b1e <unlinkread>:
{
     b1e:	7179                	add	sp,sp,-48
     b20:	f406                	sd	ra,40(sp)
     b22:	f022                	sd	s0,32(sp)
     b24:	ec26                	sd	s1,24(sp)
     b26:	e84a                	sd	s2,16(sp)
     b28:	e44e                	sd	s3,8(sp)
     b2a:	1800                	add	s0,sp,48
     b2c:	89aa                	mv	s3,a0
  fd = open("unlinkread", O_CREATE | O_RDWR);
     b2e:	20200593          	li	a1,514
     b32:	00005517          	auipc	a0,0x5
     b36:	ece50513          	add	a0,a0,-306 # 5a00 <malloc+0x62e>
     b3a:	3b4040ef          	jal	4eee <open>
  if(fd < 0){
     b3e:	0a054f63          	bltz	a0,bfc <unlinkread+0xde>
     b42:	84aa                	mv	s1,a0
  write(fd, "hello", SZ);
     b44:	4615                	li	a2,5
     b46:	00005597          	auipc	a1,0x5
     b4a:	eea58593          	add	a1,a1,-278 # 5a30 <malloc+0x65e>
     b4e:	380040ef          	jal	4ece <write>
  close(fd);
     b52:	8526                	mv	a0,s1
     b54:	382040ef          	jal	4ed6 <close>
  fd = open("unlinkread", O_RDWR);
     b58:	4589                	li	a1,2
     b5a:	00005517          	auipc	a0,0x5
     b5e:	ea650513          	add	a0,a0,-346 # 5a00 <malloc+0x62e>
     b62:	38c040ef          	jal	4eee <open>
     b66:	84aa                	mv	s1,a0
  if(fd < 0){
     b68:	0a054463          	bltz	a0,c10 <unlinkread+0xf2>
  if(unlink("unlinkread") != 0){
     b6c:	00005517          	auipc	a0,0x5
     b70:	e9450513          	add	a0,a0,-364 # 5a00 <malloc+0x62e>
     b74:	38a040ef          	jal	4efe <unlink>
     b78:	e555                	bnez	a0,c24 <unlinkread+0x106>
  fd1 = open("unlinkread", O_CREATE | O_RDWR);
     b7a:	20200593          	li	a1,514
     b7e:	00005517          	auipc	a0,0x5
     b82:	e8250513          	add	a0,a0,-382 # 5a00 <malloc+0x62e>
     b86:	368040ef          	jal	4eee <open>
     b8a:	892a                	mv	s2,a0
  write(fd1, "yyy", 3);
     b8c:	460d                	li	a2,3
     b8e:	00005597          	auipc	a1,0x5
     b92:	eea58593          	add	a1,a1,-278 # 5a78 <malloc+0x6a6>
     b96:	338040ef          	jal	4ece <write>
  close(fd1);
     b9a:	854a                	mv	a0,s2
     b9c:	33a040ef          	jal	4ed6 <close>
  if(read(fd, buf, sizeof(buf)) != SZ){
     ba0:	660d                	lui	a2,0x3
     ba2:	0000b597          	auipc	a1,0xb
     ba6:	11658593          	add	a1,a1,278 # bcb8 <buf>
     baa:	8526                	mv	a0,s1
     bac:	31a040ef          	jal	4ec6 <read>
     bb0:	4795                	li	a5,5
     bb2:	08f51363          	bne	a0,a5,c38 <unlinkread+0x11a>
  if(buf[0] != 'h'){
     bb6:	0000b717          	auipc	a4,0xb
     bba:	10274703          	lbu	a4,258(a4) # bcb8 <buf>
     bbe:	06800793          	li	a5,104
     bc2:	08f71563          	bne	a4,a5,c4c <unlinkread+0x12e>
  if(write(fd, buf, 10) != 10){
     bc6:	4629                	li	a2,10
     bc8:	0000b597          	auipc	a1,0xb
     bcc:	0f058593          	add	a1,a1,240 # bcb8 <buf>
     bd0:	8526                	mv	a0,s1
     bd2:	2fc040ef          	jal	4ece <write>
     bd6:	47a9                	li	a5,10
     bd8:	08f51463          	bne	a0,a5,c60 <unlinkread+0x142>
  close(fd);
     bdc:	8526                	mv	a0,s1
     bde:	2f8040ef          	jal	4ed6 <close>
  unlink("unlinkread");
     be2:	00005517          	auipc	a0,0x5
     be6:	e1e50513          	add	a0,a0,-482 # 5a00 <malloc+0x62e>
     bea:	314040ef          	jal	4efe <unlink>
}
     bee:	70a2                	ld	ra,40(sp)
     bf0:	7402                	ld	s0,32(sp)
     bf2:	64e2                	ld	s1,24(sp)
     bf4:	6942                	ld	s2,16(sp)
     bf6:	69a2                	ld	s3,8(sp)
     bf8:	6145                	add	sp,sp,48
     bfa:	8082                	ret
    printf("%s: create unlinkread failed\n", s);
     bfc:	85ce                	mv	a1,s3
     bfe:	00005517          	auipc	a0,0x5
     c02:	e1250513          	add	a0,a0,-494 # 5a10 <malloc+0x63e>
     c06:	718040ef          	jal	531e <printf>
    exit(1);
     c0a:	4505                	li	a0,1
     c0c:	2a2040ef          	jal	4eae <exit>
    printf("%s: open unlinkread failed\n", s);
     c10:	85ce                	mv	a1,s3
     c12:	00005517          	auipc	a0,0x5
     c16:	e2650513          	add	a0,a0,-474 # 5a38 <malloc+0x666>
     c1a:	704040ef          	jal	531e <printf>
    exit(1);
     c1e:	4505                	li	a0,1
     c20:	28e040ef          	jal	4eae <exit>
    printf("%s: unlink unlinkread failed\n", s);
     c24:	85ce                	mv	a1,s3
     c26:	00005517          	auipc	a0,0x5
     c2a:	e3250513          	add	a0,a0,-462 # 5a58 <malloc+0x686>
     c2e:	6f0040ef          	jal	531e <printf>
    exit(1);
     c32:	4505                	li	a0,1
     c34:	27a040ef          	jal	4eae <exit>
    printf("%s: unlinkread read failed", s);
     c38:	85ce                	mv	a1,s3
     c3a:	00005517          	auipc	a0,0x5
     c3e:	e4650513          	add	a0,a0,-442 # 5a80 <malloc+0x6ae>
     c42:	6dc040ef          	jal	531e <printf>
    exit(1);
     c46:	4505                	li	a0,1
     c48:	266040ef          	jal	4eae <exit>
    printf("%s: unlinkread wrong data\n", s);
     c4c:	85ce                	mv	a1,s3
     c4e:	00005517          	auipc	a0,0x5
     c52:	e5250513          	add	a0,a0,-430 # 5aa0 <malloc+0x6ce>
     c56:	6c8040ef          	jal	531e <printf>
    exit(1);
     c5a:	4505                	li	a0,1
     c5c:	252040ef          	jal	4eae <exit>
    printf("%s: unlinkread write failed\n", s);
     c60:	85ce                	mv	a1,s3
     c62:	00005517          	auipc	a0,0x5
     c66:	e5e50513          	add	a0,a0,-418 # 5ac0 <malloc+0x6ee>
     c6a:	6b4040ef          	jal	531e <printf>
    exit(1);
     c6e:	4505                	li	a0,1
     c70:	23e040ef          	jal	4eae <exit>

0000000000000c74 <linktest>:
{
     c74:	1101                	add	sp,sp,-32
     c76:	ec06                	sd	ra,24(sp)
     c78:	e822                	sd	s0,16(sp)
     c7a:	e426                	sd	s1,8(sp)
     c7c:	e04a                	sd	s2,0(sp)
     c7e:	1000                	add	s0,sp,32
     c80:	892a                	mv	s2,a0
  unlink("lf1");
     c82:	00005517          	auipc	a0,0x5
     c86:	e5e50513          	add	a0,a0,-418 # 5ae0 <malloc+0x70e>
     c8a:	274040ef          	jal	4efe <unlink>
  unlink("lf2");
     c8e:	00005517          	auipc	a0,0x5
     c92:	e5a50513          	add	a0,a0,-422 # 5ae8 <malloc+0x716>
     c96:	268040ef          	jal	4efe <unlink>
  fd = open("lf1", O_CREATE|O_RDWR);
     c9a:	20200593          	li	a1,514
     c9e:	00005517          	auipc	a0,0x5
     ca2:	e4250513          	add	a0,a0,-446 # 5ae0 <malloc+0x70e>
     ca6:	248040ef          	jal	4eee <open>
  if(fd < 0){
     caa:	0c054f63          	bltz	a0,d88 <linktest+0x114>
     cae:	84aa                	mv	s1,a0
  if(write(fd, "hello", SZ) != SZ){
     cb0:	4615                	li	a2,5
     cb2:	00005597          	auipc	a1,0x5
     cb6:	d7e58593          	add	a1,a1,-642 # 5a30 <malloc+0x65e>
     cba:	214040ef          	jal	4ece <write>
     cbe:	4795                	li	a5,5
     cc0:	0cf51e63          	bne	a0,a5,d9c <linktest+0x128>
  close(fd);
     cc4:	8526                	mv	a0,s1
     cc6:	210040ef          	jal	4ed6 <close>
  if(link("lf1", "lf2") < 0){
     cca:	00005597          	auipc	a1,0x5
     cce:	e1e58593          	add	a1,a1,-482 # 5ae8 <malloc+0x716>
     cd2:	00005517          	auipc	a0,0x5
     cd6:	e0e50513          	add	a0,a0,-498 # 5ae0 <malloc+0x70e>
     cda:	234040ef          	jal	4f0e <link>
     cde:	0c054963          	bltz	a0,db0 <linktest+0x13c>
  unlink("lf1");
     ce2:	00005517          	auipc	a0,0x5
     ce6:	dfe50513          	add	a0,a0,-514 # 5ae0 <malloc+0x70e>
     cea:	214040ef          	jal	4efe <unlink>
  if(open("lf1", 0) >= 0){
     cee:	4581                	li	a1,0
     cf0:	00005517          	auipc	a0,0x5
     cf4:	df050513          	add	a0,a0,-528 # 5ae0 <malloc+0x70e>
     cf8:	1f6040ef          	jal	4eee <open>
     cfc:	0c055463          	bgez	a0,dc4 <linktest+0x150>
  fd = open("lf2", 0);
     d00:	4581                	li	a1,0
     d02:	00005517          	auipc	a0,0x5
     d06:	de650513          	add	a0,a0,-538 # 5ae8 <malloc+0x716>
     d0a:	1e4040ef          	jal	4eee <open>
     d0e:	84aa                	mv	s1,a0
  if(fd < 0){
     d10:	0c054463          	bltz	a0,dd8 <linktest+0x164>
  if(read(fd, buf, sizeof(buf)) != SZ){
     d14:	660d                	lui	a2,0x3
     d16:	0000b597          	auipc	a1,0xb
     d1a:	fa258593          	add	a1,a1,-94 # bcb8 <buf>
     d1e:	1a8040ef          	jal	4ec6 <read>
     d22:	4795                	li	a5,5
     d24:	0cf51463          	bne	a0,a5,dec <linktest+0x178>
  close(fd);
     d28:	8526                	mv	a0,s1
     d2a:	1ac040ef          	jal	4ed6 <close>
  if(link("lf2", "lf2") >= 0){
     d2e:	00005597          	auipc	a1,0x5
     d32:	dba58593          	add	a1,a1,-582 # 5ae8 <malloc+0x716>
     d36:	852e                	mv	a0,a1
     d38:	1d6040ef          	jal	4f0e <link>
     d3c:	0c055263          	bgez	a0,e00 <linktest+0x18c>
  unlink("lf2");
     d40:	00005517          	auipc	a0,0x5
     d44:	da850513          	add	a0,a0,-600 # 5ae8 <malloc+0x716>
     d48:	1b6040ef          	jal	4efe <unlink>
  if(link("lf2", "lf1") >= 0){
     d4c:	00005597          	auipc	a1,0x5
     d50:	d9458593          	add	a1,a1,-620 # 5ae0 <malloc+0x70e>
     d54:	00005517          	auipc	a0,0x5
     d58:	d9450513          	add	a0,a0,-620 # 5ae8 <malloc+0x716>
     d5c:	1b2040ef          	jal	4f0e <link>
     d60:	0a055a63          	bgez	a0,e14 <linktest+0x1a0>
  if(link(".", "lf1") >= 0){
     d64:	00005597          	auipc	a1,0x5
     d68:	d7c58593          	add	a1,a1,-644 # 5ae0 <malloc+0x70e>
     d6c:	00005517          	auipc	a0,0x5
     d70:	e8450513          	add	a0,a0,-380 # 5bf0 <malloc+0x81e>
     d74:	19a040ef          	jal	4f0e <link>
     d78:	0a055863          	bgez	a0,e28 <linktest+0x1b4>
}
     d7c:	60e2                	ld	ra,24(sp)
     d7e:	6442                	ld	s0,16(sp)
     d80:	64a2                	ld	s1,8(sp)
     d82:	6902                	ld	s2,0(sp)
     d84:	6105                	add	sp,sp,32
     d86:	8082                	ret
    printf("%s: create lf1 failed\n", s);
     d88:	85ca                	mv	a1,s2
     d8a:	00005517          	auipc	a0,0x5
     d8e:	d6650513          	add	a0,a0,-666 # 5af0 <malloc+0x71e>
     d92:	58c040ef          	jal	531e <printf>
    exit(1);
     d96:	4505                	li	a0,1
     d98:	116040ef          	jal	4eae <exit>
    printf("%s: write lf1 failed\n", s);
     d9c:	85ca                	mv	a1,s2
     d9e:	00005517          	auipc	a0,0x5
     da2:	d6a50513          	add	a0,a0,-662 # 5b08 <malloc+0x736>
     da6:	578040ef          	jal	531e <printf>
    exit(1);
     daa:	4505                	li	a0,1
     dac:	102040ef          	jal	4eae <exit>
    printf("%s: link lf1 lf2 failed\n", s);
     db0:	85ca                	mv	a1,s2
     db2:	00005517          	auipc	a0,0x5
     db6:	d6e50513          	add	a0,a0,-658 # 5b20 <malloc+0x74e>
     dba:	564040ef          	jal	531e <printf>
    exit(1);
     dbe:	4505                	li	a0,1
     dc0:	0ee040ef          	jal	4eae <exit>
    printf("%s: unlinked lf1 but it is still there!\n", s);
     dc4:	85ca                	mv	a1,s2
     dc6:	00005517          	auipc	a0,0x5
     dca:	d7a50513          	add	a0,a0,-646 # 5b40 <malloc+0x76e>
     dce:	550040ef          	jal	531e <printf>
    exit(1);
     dd2:	4505                	li	a0,1
     dd4:	0da040ef          	jal	4eae <exit>
    printf("%s: open lf2 failed\n", s);
     dd8:	85ca                	mv	a1,s2
     dda:	00005517          	auipc	a0,0x5
     dde:	d9650513          	add	a0,a0,-618 # 5b70 <malloc+0x79e>
     de2:	53c040ef          	jal	531e <printf>
    exit(1);
     de6:	4505                	li	a0,1
     de8:	0c6040ef          	jal	4eae <exit>
    printf("%s: read lf2 failed\n", s);
     dec:	85ca                	mv	a1,s2
     dee:	00005517          	auipc	a0,0x5
     df2:	d9a50513          	add	a0,a0,-614 # 5b88 <malloc+0x7b6>
     df6:	528040ef          	jal	531e <printf>
    exit(1);
     dfa:	4505                	li	a0,1
     dfc:	0b2040ef          	jal	4eae <exit>
    printf("%s: link lf2 lf2 succeeded! oops\n", s);
     e00:	85ca                	mv	a1,s2
     e02:	00005517          	auipc	a0,0x5
     e06:	d9e50513          	add	a0,a0,-610 # 5ba0 <malloc+0x7ce>
     e0a:	514040ef          	jal	531e <printf>
    exit(1);
     e0e:	4505                	li	a0,1
     e10:	09e040ef          	jal	4eae <exit>
    printf("%s: link non-existent succeeded! oops\n", s);
     e14:	85ca                	mv	a1,s2
     e16:	00005517          	auipc	a0,0x5
     e1a:	db250513          	add	a0,a0,-590 # 5bc8 <malloc+0x7f6>
     e1e:	500040ef          	jal	531e <printf>
    exit(1);
     e22:	4505                	li	a0,1
     e24:	08a040ef          	jal	4eae <exit>
    printf("%s: link . lf1 succeeded! oops\n", s);
     e28:	85ca                	mv	a1,s2
     e2a:	00005517          	auipc	a0,0x5
     e2e:	dce50513          	add	a0,a0,-562 # 5bf8 <malloc+0x826>
     e32:	4ec040ef          	jal	531e <printf>
    exit(1);
     e36:	4505                	li	a0,1
     e38:	076040ef          	jal	4eae <exit>

0000000000000e3c <validatetest>:
{
     e3c:	7139                	add	sp,sp,-64
     e3e:	fc06                	sd	ra,56(sp)
     e40:	f822                	sd	s0,48(sp)
     e42:	f426                	sd	s1,40(sp)
     e44:	f04a                	sd	s2,32(sp)
     e46:	ec4e                	sd	s3,24(sp)
     e48:	e852                	sd	s4,16(sp)
     e4a:	e456                	sd	s5,8(sp)
     e4c:	e05a                	sd	s6,0(sp)
     e4e:	0080                	add	s0,sp,64
     e50:	8b2a                	mv	s6,a0
  for(p = 0; p <= (uint)hi; p += PGSIZE){
     e52:	4481                	li	s1,0
    if(link("nosuchfile", (char*)p) != -1){
     e54:	00005997          	auipc	s3,0x5
     e58:	dc498993          	add	s3,s3,-572 # 5c18 <malloc+0x846>
     e5c:	597d                	li	s2,-1
  for(p = 0; p <= (uint)hi; p += PGSIZE){
     e5e:	6a85                	lui	s5,0x1
     e60:	00114a37          	lui	s4,0x114
    if(link("nosuchfile", (char*)p) != -1){
     e64:	85a6                	mv	a1,s1
     e66:	854e                	mv	a0,s3
     e68:	0a6040ef          	jal	4f0e <link>
     e6c:	01251f63          	bne	a0,s2,e8a <validatetest+0x4e>
  for(p = 0; p <= (uint)hi; p += PGSIZE){
     e70:	94d6                	add	s1,s1,s5
     e72:	ff4499e3          	bne	s1,s4,e64 <validatetest+0x28>
}
     e76:	70e2                	ld	ra,56(sp)
     e78:	7442                	ld	s0,48(sp)
     e7a:	74a2                	ld	s1,40(sp)
     e7c:	7902                	ld	s2,32(sp)
     e7e:	69e2                	ld	s3,24(sp)
     e80:	6a42                	ld	s4,16(sp)
     e82:	6aa2                	ld	s5,8(sp)
     e84:	6b02                	ld	s6,0(sp)
     e86:	6121                	add	sp,sp,64
     e88:	8082                	ret
      printf("%s: link should not succeed\n", s);
     e8a:	85da                	mv	a1,s6
     e8c:	00005517          	auipc	a0,0x5
     e90:	d9c50513          	add	a0,a0,-612 # 5c28 <malloc+0x856>
     e94:	48a040ef          	jal	531e <printf>
      exit(1);
     e98:	4505                	li	a0,1
     e9a:	014040ef          	jal	4eae <exit>

0000000000000e9e <bigdir>:
{
     e9e:	715d                	add	sp,sp,-80
     ea0:	e486                	sd	ra,72(sp)
     ea2:	e0a2                	sd	s0,64(sp)
     ea4:	fc26                	sd	s1,56(sp)
     ea6:	f84a                	sd	s2,48(sp)
     ea8:	f44e                	sd	s3,40(sp)
     eaa:	f052                	sd	s4,32(sp)
     eac:	ec56                	sd	s5,24(sp)
     eae:	e85a                	sd	s6,16(sp)
     eb0:	0880                	add	s0,sp,80
     eb2:	89aa                	mv	s3,a0
  unlink("bd");
     eb4:	00005517          	auipc	a0,0x5
     eb8:	d9450513          	add	a0,a0,-620 # 5c48 <malloc+0x876>
     ebc:	042040ef          	jal	4efe <unlink>
  fd = open("bd", O_CREATE);
     ec0:	20000593          	li	a1,512
     ec4:	00005517          	auipc	a0,0x5
     ec8:	d8450513          	add	a0,a0,-636 # 5c48 <malloc+0x876>
     ecc:	022040ef          	jal	4eee <open>
  if(fd < 0){
     ed0:	0c054163          	bltz	a0,f92 <bigdir+0xf4>
  close(fd);
     ed4:	002040ef          	jal	4ed6 <close>
  for(i = 0; i < N; i++){
     ed8:	4901                	li	s2,0
    name[0] = 'x';
     eda:	07800a93          	li	s5,120
    if(link("bd", name) != 0){
     ede:	00005a17          	auipc	s4,0x5
     ee2:	d6aa0a13          	add	s4,s4,-662 # 5c48 <malloc+0x876>
  for(i = 0; i < N; i++){
     ee6:	1f400b13          	li	s6,500
    name[0] = 'x';
     eea:	fb540823          	sb	s5,-80(s0)
    name[1] = '0' + (i / 64);
     eee:	41f9571b          	sraw	a4,s2,0x1f
     ef2:	01a7571b          	srlw	a4,a4,0x1a
     ef6:	012707bb          	addw	a5,a4,s2
     efa:	4067d69b          	sraw	a3,a5,0x6
     efe:	0306869b          	addw	a3,a3,48
     f02:	fad408a3          	sb	a3,-79(s0)
    name[2] = '0' + (i % 64);
     f06:	03f7f793          	and	a5,a5,63
     f0a:	9f99                	subw	a5,a5,a4
     f0c:	0307879b          	addw	a5,a5,48
     f10:	faf40923          	sb	a5,-78(s0)
    name[3] = '\0';
     f14:	fa0409a3          	sb	zero,-77(s0)
    if(link("bd", name) != 0){
     f18:	fb040593          	add	a1,s0,-80
     f1c:	8552                	mv	a0,s4
     f1e:	7f1030ef          	jal	4f0e <link>
     f22:	84aa                	mv	s1,a0
     f24:	e149                	bnez	a0,fa6 <bigdir+0x108>
  for(i = 0; i < N; i++){
     f26:	2905                	addw	s2,s2,1
     f28:	fd6911e3          	bne	s2,s6,eea <bigdir+0x4c>
  unlink("bd");
     f2c:	00005517          	auipc	a0,0x5
     f30:	d1c50513          	add	a0,a0,-740 # 5c48 <malloc+0x876>
     f34:	7cb030ef          	jal	4efe <unlink>
    name[0] = 'x';
     f38:	07800913          	li	s2,120
  for(i = 0; i < N; i++){
     f3c:	1f400a13          	li	s4,500
    name[0] = 'x';
     f40:	fb240823          	sb	s2,-80(s0)
    name[1] = '0' + (i / 64);
     f44:	41f4d71b          	sraw	a4,s1,0x1f
     f48:	01a7571b          	srlw	a4,a4,0x1a
     f4c:	009707bb          	addw	a5,a4,s1
     f50:	4067d69b          	sraw	a3,a5,0x6
     f54:	0306869b          	addw	a3,a3,48
     f58:	fad408a3          	sb	a3,-79(s0)
    name[2] = '0' + (i % 64);
     f5c:	03f7f793          	and	a5,a5,63
     f60:	9f99                	subw	a5,a5,a4
     f62:	0307879b          	addw	a5,a5,48
     f66:	faf40923          	sb	a5,-78(s0)
    name[3] = '\0';
     f6a:	fa0409a3          	sb	zero,-77(s0)
    if(unlink(name) != 0){
     f6e:	fb040513          	add	a0,s0,-80
     f72:	78d030ef          	jal	4efe <unlink>
     f76:	e529                	bnez	a0,fc0 <bigdir+0x122>
  for(i = 0; i < N; i++){
     f78:	2485                	addw	s1,s1,1
     f7a:	fd4493e3          	bne	s1,s4,f40 <bigdir+0xa2>
}
     f7e:	60a6                	ld	ra,72(sp)
     f80:	6406                	ld	s0,64(sp)
     f82:	74e2                	ld	s1,56(sp)
     f84:	7942                	ld	s2,48(sp)
     f86:	79a2                	ld	s3,40(sp)
     f88:	7a02                	ld	s4,32(sp)
     f8a:	6ae2                	ld	s5,24(sp)
     f8c:	6b42                	ld	s6,16(sp)
     f8e:	6161                	add	sp,sp,80
     f90:	8082                	ret
    printf("%s: bigdir create failed\n", s);
     f92:	85ce                	mv	a1,s3
     f94:	00005517          	auipc	a0,0x5
     f98:	cbc50513          	add	a0,a0,-836 # 5c50 <malloc+0x87e>
     f9c:	382040ef          	jal	531e <printf>
    exit(1);
     fa0:	4505                	li	a0,1
     fa2:	70d030ef          	jal	4eae <exit>
      printf("%s: bigdir i=%d link(bd, %s) failed\n", s, i, name);
     fa6:	fb040693          	add	a3,s0,-80
     faa:	864a                	mv	a2,s2
     fac:	85ce                	mv	a1,s3
     fae:	00005517          	auipc	a0,0x5
     fb2:	cc250513          	add	a0,a0,-830 # 5c70 <malloc+0x89e>
     fb6:	368040ef          	jal	531e <printf>
      exit(1);
     fba:	4505                	li	a0,1
     fbc:	6f3030ef          	jal	4eae <exit>
      printf("%s: bigdir unlink failed", s);
     fc0:	85ce                	mv	a1,s3
     fc2:	00005517          	auipc	a0,0x5
     fc6:	cd650513          	add	a0,a0,-810 # 5c98 <malloc+0x8c6>
     fca:	354040ef          	jal	531e <printf>
      exit(1);
     fce:	4505                	li	a0,1
     fd0:	6df030ef          	jal	4eae <exit>

0000000000000fd4 <pgbug>:
{
     fd4:	7179                	add	sp,sp,-48
     fd6:	f406                	sd	ra,40(sp)
     fd8:	f022                	sd	s0,32(sp)
     fda:	ec26                	sd	s1,24(sp)
     fdc:	1800                	add	s0,sp,48
  argv[0] = 0;
     fde:	fc043c23          	sd	zero,-40(s0)
  exec(big, argv);
     fe2:	00007497          	auipc	s1,0x7
     fe6:	01e48493          	add	s1,s1,30 # 8000 <big>
     fea:	fd840593          	add	a1,s0,-40
     fee:	6088                	ld	a0,0(s1)
     ff0:	6f7030ef          	jal	4ee6 <exec>
  pipe(big);
     ff4:	6088                	ld	a0,0(s1)
     ff6:	6c9030ef          	jal	4ebe <pipe>
  exit(0);
     ffa:	4501                	li	a0,0
     ffc:	6b3030ef          	jal	4eae <exit>

0000000000001000 <badarg>:
{
    1000:	7139                	add	sp,sp,-64
    1002:	fc06                	sd	ra,56(sp)
    1004:	f822                	sd	s0,48(sp)
    1006:	f426                	sd	s1,40(sp)
    1008:	f04a                	sd	s2,32(sp)
    100a:	ec4e                	sd	s3,24(sp)
    100c:	0080                	add	s0,sp,64
    100e:	64b1                	lui	s1,0xc
    1010:	35048493          	add	s1,s1,848 # c350 <buf+0x698>
    argv[0] = (char*)0xffffffff;
    1014:	597d                	li	s2,-1
    1016:	02095913          	srl	s2,s2,0x20
    exec("echo", argv);
    101a:	00004997          	auipc	s3,0x4
    101e:	4ee98993          	add	s3,s3,1262 # 5508 <malloc+0x136>
    argv[0] = (char*)0xffffffff;
    1022:	fd243023          	sd	s2,-64(s0)
    argv[1] = 0;
    1026:	fc043423          	sd	zero,-56(s0)
    exec("echo", argv);
    102a:	fc040593          	add	a1,s0,-64
    102e:	854e                	mv	a0,s3
    1030:	6b7030ef          	jal	4ee6 <exec>
  for(int i = 0; i < 50000; i++){
    1034:	34fd                	addw	s1,s1,-1
    1036:	f4f5                	bnez	s1,1022 <badarg+0x22>
  exit(0);
    1038:	4501                	li	a0,0
    103a:	675030ef          	jal	4eae <exit>

000000000000103e <copyinstr2>:
{
    103e:	7155                	add	sp,sp,-208
    1040:	e586                	sd	ra,200(sp)
    1042:	e1a2                	sd	s0,192(sp)
    1044:	0980                	add	s0,sp,208
  for(int i = 0; i < MAXPATH; i++)
    1046:	f6840793          	add	a5,s0,-152
    104a:	fe840693          	add	a3,s0,-24
    b[i] = 'x';
    104e:	07800713          	li	a4,120
    1052:	00e78023          	sb	a4,0(a5)
  for(int i = 0; i < MAXPATH; i++)
    1056:	0785                	add	a5,a5,1
    1058:	fed79de3          	bne	a5,a3,1052 <copyinstr2+0x14>
  b[MAXPATH] = '\0';
    105c:	fe040423          	sb	zero,-24(s0)
  int ret = unlink(b);
    1060:	f6840513          	add	a0,s0,-152
    1064:	69b030ef          	jal	4efe <unlink>
  if(ret != -1){
    1068:	57fd                	li	a5,-1
    106a:	0cf51263          	bne	a0,a5,112e <copyinstr2+0xf0>
  int fd = open(b, O_CREATE | O_WRONLY);
    106e:	20100593          	li	a1,513
    1072:	f6840513          	add	a0,s0,-152
    1076:	679030ef          	jal	4eee <open>
  if(fd != -1){
    107a:	57fd                	li	a5,-1
    107c:	0cf51563          	bne	a0,a5,1146 <copyinstr2+0x108>
  ret = link(b, b);
    1080:	f6840593          	add	a1,s0,-152
    1084:	852e                	mv	a0,a1
    1086:	689030ef          	jal	4f0e <link>
  if(ret != -1){
    108a:	57fd                	li	a5,-1
    108c:	0cf51963          	bne	a0,a5,115e <copyinstr2+0x120>
  char *args[] = { "xx", 0 };
    1090:	00006797          	auipc	a5,0x6
    1094:	d5878793          	add	a5,a5,-680 # 6de8 <malloc+0x1a16>
    1098:	f4f43c23          	sd	a5,-168(s0)
    109c:	f6043023          	sd	zero,-160(s0)
  ret = exec(b, args);
    10a0:	f5840593          	add	a1,s0,-168
    10a4:	f6840513          	add	a0,s0,-152
    10a8:	63f030ef          	jal	4ee6 <exec>
  if(ret != -1){
    10ac:	57fd                	li	a5,-1
    10ae:	0cf51563          	bne	a0,a5,1178 <copyinstr2+0x13a>
  int pid = fork();
    10b2:	5f5030ef          	jal	4ea6 <fork>
  if(pid < 0){
    10b6:	0c054d63          	bltz	a0,1190 <copyinstr2+0x152>
  if(pid == 0){
    10ba:	0e051863          	bnez	a0,11aa <copyinstr2+0x16c>
    10be:	00007797          	auipc	a5,0x7
    10c2:	4e278793          	add	a5,a5,1250 # 85a0 <big.0>
    10c6:	00008697          	auipc	a3,0x8
    10ca:	4da68693          	add	a3,a3,1242 # 95a0 <big.0+0x1000>
      big[i] = 'x';
    10ce:	07800713          	li	a4,120
    10d2:	00e78023          	sb	a4,0(a5)
    for(int i = 0; i < PGSIZE; i++)
    10d6:	0785                	add	a5,a5,1
    10d8:	fed79de3          	bne	a5,a3,10d2 <copyinstr2+0x94>
    big[PGSIZE] = '\0';
    10dc:	00008797          	auipc	a5,0x8
    10e0:	4c078223          	sb	zero,1220(a5) # 95a0 <big.0+0x1000>
    char *args2[] = { big, big, big, 0 };
    10e4:	00007797          	auipc	a5,0x7
    10e8:	96c78793          	add	a5,a5,-1684 # 7a50 <malloc+0x267e>
    10ec:	6fb0                	ld	a2,88(a5)
    10ee:	73b4                	ld	a3,96(a5)
    10f0:	77b8                	ld	a4,104(a5)
    10f2:	7bbc                	ld	a5,112(a5)
    10f4:	f2c43823          	sd	a2,-208(s0)
    10f8:	f2d43c23          	sd	a3,-200(s0)
    10fc:	f4e43023          	sd	a4,-192(s0)
    1100:	f4f43423          	sd	a5,-184(s0)
    ret = exec("echo", args2);
    1104:	f3040593          	add	a1,s0,-208
    1108:	00004517          	auipc	a0,0x4
    110c:	40050513          	add	a0,a0,1024 # 5508 <malloc+0x136>
    1110:	5d7030ef          	jal	4ee6 <exec>
    if(ret != -1){
    1114:	57fd                	li	a5,-1
    1116:	08f50663          	beq	a0,a5,11a2 <copyinstr2+0x164>
      printf("exec(echo, BIG) returned %d, not -1\n", fd);
    111a:	55fd                	li	a1,-1
    111c:	00005517          	auipc	a0,0x5
    1120:	c2450513          	add	a0,a0,-988 # 5d40 <malloc+0x96e>
    1124:	1fa040ef          	jal	531e <printf>
      exit(1);
    1128:	4505                	li	a0,1
    112a:	585030ef          	jal	4eae <exit>
    printf("unlink(%s) returned %d, not -1\n", b, ret);
    112e:	862a                	mv	a2,a0
    1130:	f6840593          	add	a1,s0,-152
    1134:	00005517          	auipc	a0,0x5
    1138:	b8450513          	add	a0,a0,-1148 # 5cb8 <malloc+0x8e6>
    113c:	1e2040ef          	jal	531e <printf>
    exit(1);
    1140:	4505                	li	a0,1
    1142:	56d030ef          	jal	4eae <exit>
    printf("open(%s) returned %d, not -1\n", b, fd);
    1146:	862a                	mv	a2,a0
    1148:	f6840593          	add	a1,s0,-152
    114c:	00005517          	auipc	a0,0x5
    1150:	b8c50513          	add	a0,a0,-1140 # 5cd8 <malloc+0x906>
    1154:	1ca040ef          	jal	531e <printf>
    exit(1);
    1158:	4505                	li	a0,1
    115a:	555030ef          	jal	4eae <exit>
    printf("link(%s, %s) returned %d, not -1\n", b, b, ret);
    115e:	86aa                	mv	a3,a0
    1160:	f6840613          	add	a2,s0,-152
    1164:	85b2                	mv	a1,a2
    1166:	00005517          	auipc	a0,0x5
    116a:	b9250513          	add	a0,a0,-1134 # 5cf8 <malloc+0x926>
    116e:	1b0040ef          	jal	531e <printf>
    exit(1);
    1172:	4505                	li	a0,1
    1174:	53b030ef          	jal	4eae <exit>
    printf("exec(%s) returned %d, not -1\n", b, fd);
    1178:	567d                	li	a2,-1
    117a:	f6840593          	add	a1,s0,-152
    117e:	00005517          	auipc	a0,0x5
    1182:	ba250513          	add	a0,a0,-1118 # 5d20 <malloc+0x94e>
    1186:	198040ef          	jal	531e <printf>
    exit(1);
    118a:	4505                	li	a0,1
    118c:	523030ef          	jal	4eae <exit>
    printf("fork failed\n");
    1190:	00006517          	auipc	a0,0x6
    1194:	1b050513          	add	a0,a0,432 # 7340 <malloc+0x1f6e>
    1198:	186040ef          	jal	531e <printf>
    exit(1);
    119c:	4505                	li	a0,1
    119e:	511030ef          	jal	4eae <exit>
    exit(747); // OK
    11a2:	2eb00513          	li	a0,747
    11a6:	509030ef          	jal	4eae <exit>
  int st = 0;
    11aa:	f4042a23          	sw	zero,-172(s0)
  wait(&st);
    11ae:	f5440513          	add	a0,s0,-172
    11b2:	505030ef          	jal	4eb6 <wait>
  if(st != 747){
    11b6:	f5442703          	lw	a4,-172(s0)
    11ba:	2eb00793          	li	a5,747
    11be:	00f71663          	bne	a4,a5,11ca <copyinstr2+0x18c>
}
    11c2:	60ae                	ld	ra,200(sp)
    11c4:	640e                	ld	s0,192(sp)
    11c6:	6169                	add	sp,sp,208
    11c8:	8082                	ret
    printf("exec(echo, BIG) succeeded, should have failed\n");
    11ca:	00005517          	auipc	a0,0x5
    11ce:	b9e50513          	add	a0,a0,-1122 # 5d68 <malloc+0x996>
    11d2:	14c040ef          	jal	531e <printf>
    exit(1);
    11d6:	4505                	li	a0,1
    11d8:	4d7030ef          	jal	4eae <exit>

00000000000011dc <truncate3>:
{
    11dc:	7159                	add	sp,sp,-112
    11de:	f486                	sd	ra,104(sp)
    11e0:	f0a2                	sd	s0,96(sp)
    11e2:	e8ca                	sd	s2,80(sp)
    11e4:	1880                	add	s0,sp,112
    11e6:	892a                	mv	s2,a0
  close(open("truncfile", O_CREATE|O_TRUNC|O_WRONLY));
    11e8:	60100593          	li	a1,1537
    11ec:	00004517          	auipc	a0,0x4
    11f0:	37450513          	add	a0,a0,884 # 5560 <malloc+0x18e>
    11f4:	4fb030ef          	jal	4eee <open>
    11f8:	4df030ef          	jal	4ed6 <close>
  pid = fork();
    11fc:	4ab030ef          	jal	4ea6 <fork>
  if(pid < 0){
    1200:	06054663          	bltz	a0,126c <truncate3+0x90>
  if(pid == 0){
    1204:	e55d                	bnez	a0,12b2 <truncate3+0xd6>
    1206:	eca6                	sd	s1,88(sp)
    1208:	e4ce                	sd	s3,72(sp)
    120a:	e0d2                	sd	s4,64(sp)
    120c:	fc56                	sd	s5,56(sp)
    120e:	06400993          	li	s3,100
      int fd = open("truncfile", O_WRONLY);
    1212:	00004a17          	auipc	s4,0x4
    1216:	34ea0a13          	add	s4,s4,846 # 5560 <malloc+0x18e>
      int n = write(fd, "1234567890", 10);
    121a:	00005a97          	auipc	s5,0x5
    121e:	baea8a93          	add	s5,s5,-1106 # 5dc8 <malloc+0x9f6>
      int fd = open("truncfile", O_WRONLY);
    1222:	4585                	li	a1,1
    1224:	8552                	mv	a0,s4
    1226:	4c9030ef          	jal	4eee <open>
    122a:	84aa                	mv	s1,a0
      if(fd < 0){
    122c:	04054e63          	bltz	a0,1288 <truncate3+0xac>
      int n = write(fd, "1234567890", 10);
    1230:	4629                	li	a2,10
    1232:	85d6                	mv	a1,s5
    1234:	49b030ef          	jal	4ece <write>
      if(n != 10){
    1238:	47a9                	li	a5,10
    123a:	06f51163          	bne	a0,a5,129c <truncate3+0xc0>
      close(fd);
    123e:	8526                	mv	a0,s1
    1240:	497030ef          	jal	4ed6 <close>
      fd = open("truncfile", O_RDONLY);
    1244:	4581                	li	a1,0
    1246:	8552                	mv	a0,s4
    1248:	4a7030ef          	jal	4eee <open>
    124c:	84aa                	mv	s1,a0
      read(fd, buf, sizeof(buf));
    124e:	02000613          	li	a2,32
    1252:	f9840593          	add	a1,s0,-104
    1256:	471030ef          	jal	4ec6 <read>
      close(fd);
    125a:	8526                	mv	a0,s1
    125c:	47b030ef          	jal	4ed6 <close>
    for(int i = 0; i < 100; i++){
    1260:	39fd                	addw	s3,s3,-1
    1262:	fc0990e3          	bnez	s3,1222 <truncate3+0x46>
    exit(0);
    1266:	4501                	li	a0,0
    1268:	447030ef          	jal	4eae <exit>
    126c:	eca6                	sd	s1,88(sp)
    126e:	e4ce                	sd	s3,72(sp)
    1270:	e0d2                	sd	s4,64(sp)
    1272:	fc56                	sd	s5,56(sp)
    printf("%s: fork failed\n", s);
    1274:	85ca                	mv	a1,s2
    1276:	00005517          	auipc	a0,0x5
    127a:	b2250513          	add	a0,a0,-1246 # 5d98 <malloc+0x9c6>
    127e:	0a0040ef          	jal	531e <printf>
    exit(1);
    1282:	4505                	li	a0,1
    1284:	42b030ef          	jal	4eae <exit>
        printf("%s: open failed\n", s);
    1288:	85ca                	mv	a1,s2
    128a:	00005517          	auipc	a0,0x5
    128e:	b2650513          	add	a0,a0,-1242 # 5db0 <malloc+0x9de>
    1292:	08c040ef          	jal	531e <printf>
        exit(1);
    1296:	4505                	li	a0,1
    1298:	417030ef          	jal	4eae <exit>
        printf("%s: write got %d, expected 10\n", s, n);
    129c:	862a                	mv	a2,a0
    129e:	85ca                	mv	a1,s2
    12a0:	00005517          	auipc	a0,0x5
    12a4:	b3850513          	add	a0,a0,-1224 # 5dd8 <malloc+0xa06>
    12a8:	076040ef          	jal	531e <printf>
        exit(1);
    12ac:	4505                	li	a0,1
    12ae:	401030ef          	jal	4eae <exit>
    12b2:	eca6                	sd	s1,88(sp)
    12b4:	e4ce                	sd	s3,72(sp)
    12b6:	e0d2                	sd	s4,64(sp)
    12b8:	fc56                	sd	s5,56(sp)
    12ba:	09600993          	li	s3,150
    int fd = open("truncfile", O_CREATE|O_WRONLY|O_TRUNC);
    12be:	00004a17          	auipc	s4,0x4
    12c2:	2a2a0a13          	add	s4,s4,674 # 5560 <malloc+0x18e>
    int n = write(fd, "xxx", 3);
    12c6:	00005a97          	auipc	s5,0x5
    12ca:	b32a8a93          	add	s5,s5,-1230 # 5df8 <malloc+0xa26>
    int fd = open("truncfile", O_CREATE|O_WRONLY|O_TRUNC);
    12ce:	60100593          	li	a1,1537
    12d2:	8552                	mv	a0,s4
    12d4:	41b030ef          	jal	4eee <open>
    12d8:	84aa                	mv	s1,a0
    if(fd < 0){
    12da:	02054d63          	bltz	a0,1314 <truncate3+0x138>
    int n = write(fd, "xxx", 3);
    12de:	460d                	li	a2,3
    12e0:	85d6                	mv	a1,s5
    12e2:	3ed030ef          	jal	4ece <write>
    if(n != 3){
    12e6:	478d                	li	a5,3
    12e8:	04f51063          	bne	a0,a5,1328 <truncate3+0x14c>
    close(fd);
    12ec:	8526                	mv	a0,s1
    12ee:	3e9030ef          	jal	4ed6 <close>
  for(int i = 0; i < 150; i++){
    12f2:	39fd                	addw	s3,s3,-1
    12f4:	fc099de3          	bnez	s3,12ce <truncate3+0xf2>
  wait(&xstatus);
    12f8:	fbc40513          	add	a0,s0,-68
    12fc:	3bb030ef          	jal	4eb6 <wait>
  unlink("truncfile");
    1300:	00004517          	auipc	a0,0x4
    1304:	26050513          	add	a0,a0,608 # 5560 <malloc+0x18e>
    1308:	3f7030ef          	jal	4efe <unlink>
  exit(xstatus);
    130c:	fbc42503          	lw	a0,-68(s0)
    1310:	39f030ef          	jal	4eae <exit>
      printf("%s: open failed\n", s);
    1314:	85ca                	mv	a1,s2
    1316:	00005517          	auipc	a0,0x5
    131a:	a9a50513          	add	a0,a0,-1382 # 5db0 <malloc+0x9de>
    131e:	000040ef          	jal	531e <printf>
      exit(1);
    1322:	4505                	li	a0,1
    1324:	38b030ef          	jal	4eae <exit>
      printf("%s: write got %d, expected 3\n", s, n);
    1328:	862a                	mv	a2,a0
    132a:	85ca                	mv	a1,s2
    132c:	00005517          	auipc	a0,0x5
    1330:	ad450513          	add	a0,a0,-1324 # 5e00 <malloc+0xa2e>
    1334:	7eb030ef          	jal	531e <printf>
      exit(1);
    1338:	4505                	li	a0,1
    133a:	375030ef          	jal	4eae <exit>

000000000000133e <exectest>:
{
    133e:	715d                	add	sp,sp,-80
    1340:	e486                	sd	ra,72(sp)
    1342:	e0a2                	sd	s0,64(sp)
    1344:	f84a                	sd	s2,48(sp)
    1346:	0880                	add	s0,sp,80
    1348:	892a                	mv	s2,a0
  char *echoargv[] = { "echo", "OK", 0 };
    134a:	00004797          	auipc	a5,0x4
    134e:	1be78793          	add	a5,a5,446 # 5508 <malloc+0x136>
    1352:	fcf43023          	sd	a5,-64(s0)
    1356:	00005797          	auipc	a5,0x5
    135a:	aca78793          	add	a5,a5,-1334 # 5e20 <malloc+0xa4e>
    135e:	fcf43423          	sd	a5,-56(s0)
    1362:	fc043823          	sd	zero,-48(s0)
  unlink("echo-ok");
    1366:	00005517          	auipc	a0,0x5
    136a:	ac250513          	add	a0,a0,-1342 # 5e28 <malloc+0xa56>
    136e:	391030ef          	jal	4efe <unlink>
  pid = fork();
    1372:	335030ef          	jal	4ea6 <fork>
  if(pid < 0) {
    1376:	02054f63          	bltz	a0,13b4 <exectest+0x76>
    137a:	fc26                	sd	s1,56(sp)
    137c:	84aa                	mv	s1,a0
  if(pid == 0) {
    137e:	e935                	bnez	a0,13f2 <exectest+0xb4>
    close(1);
    1380:	4505                	li	a0,1
    1382:	355030ef          	jal	4ed6 <close>
    fd = open("echo-ok", O_CREATE|O_WRONLY);
    1386:	20100593          	li	a1,513
    138a:	00005517          	auipc	a0,0x5
    138e:	a9e50513          	add	a0,a0,-1378 # 5e28 <malloc+0xa56>
    1392:	35d030ef          	jal	4eee <open>
    if(fd < 0) {
    1396:	02054a63          	bltz	a0,13ca <exectest+0x8c>
    if(fd != 1) {
    139a:	4785                	li	a5,1
    139c:	04f50163          	beq	a0,a5,13de <exectest+0xa0>
      printf("%s: wrong fd\n", s);
    13a0:	85ca                	mv	a1,s2
    13a2:	00005517          	auipc	a0,0x5
    13a6:	aa650513          	add	a0,a0,-1370 # 5e48 <malloc+0xa76>
    13aa:	775030ef          	jal	531e <printf>
      exit(1);
    13ae:	4505                	li	a0,1
    13b0:	2ff030ef          	jal	4eae <exit>
    13b4:	fc26                	sd	s1,56(sp)
     printf("%s: fork failed\n", s);
    13b6:	85ca                	mv	a1,s2
    13b8:	00005517          	auipc	a0,0x5
    13bc:	9e050513          	add	a0,a0,-1568 # 5d98 <malloc+0x9c6>
    13c0:	75f030ef          	jal	531e <printf>
     exit(1);
    13c4:	4505                	li	a0,1
    13c6:	2e9030ef          	jal	4eae <exit>
      printf("%s: create failed\n", s);
    13ca:	85ca                	mv	a1,s2
    13cc:	00005517          	auipc	a0,0x5
    13d0:	a6450513          	add	a0,a0,-1436 # 5e30 <malloc+0xa5e>
    13d4:	74b030ef          	jal	531e <printf>
      exit(1);
    13d8:	4505                	li	a0,1
    13da:	2d5030ef          	jal	4eae <exit>
    if(exec("echo", echoargv) < 0){
    13de:	fc040593          	add	a1,s0,-64
    13e2:	00004517          	auipc	a0,0x4
    13e6:	12650513          	add	a0,a0,294 # 5508 <malloc+0x136>
    13ea:	2fd030ef          	jal	4ee6 <exec>
    13ee:	00054d63          	bltz	a0,1408 <exectest+0xca>
  if (wait(&xstatus) != pid) {
    13f2:	fdc40513          	add	a0,s0,-36
    13f6:	2c1030ef          	jal	4eb6 <wait>
    13fa:	02951163          	bne	a0,s1,141c <exectest+0xde>
  if(xstatus != 0)
    13fe:	fdc42503          	lw	a0,-36(s0)
    1402:	c50d                	beqz	a0,142c <exectest+0xee>
    exit(xstatus);
    1404:	2ab030ef          	jal	4eae <exit>
      printf("%s: exec echo failed\n", s);
    1408:	85ca                	mv	a1,s2
    140a:	00005517          	auipc	a0,0x5
    140e:	a4e50513          	add	a0,a0,-1458 # 5e58 <malloc+0xa86>
    1412:	70d030ef          	jal	531e <printf>
      exit(1);
    1416:	4505                	li	a0,1
    1418:	297030ef          	jal	4eae <exit>
    printf("%s: wait failed!\n", s);
    141c:	85ca                	mv	a1,s2
    141e:	00005517          	auipc	a0,0x5
    1422:	a5250513          	add	a0,a0,-1454 # 5e70 <malloc+0xa9e>
    1426:	6f9030ef          	jal	531e <printf>
    142a:	bfd1                	j	13fe <exectest+0xc0>
  fd = open("echo-ok", O_RDONLY);
    142c:	4581                	li	a1,0
    142e:	00005517          	auipc	a0,0x5
    1432:	9fa50513          	add	a0,a0,-1542 # 5e28 <malloc+0xa56>
    1436:	2b9030ef          	jal	4eee <open>
  if(fd < 0) {
    143a:	02054463          	bltz	a0,1462 <exectest+0x124>
  if (read(fd, buf, 2) != 2) {
    143e:	4609                	li	a2,2
    1440:	fb840593          	add	a1,s0,-72
    1444:	283030ef          	jal	4ec6 <read>
    1448:	4789                	li	a5,2
    144a:	02f50663          	beq	a0,a5,1476 <exectest+0x138>
    printf("%s: read failed\n", s);
    144e:	85ca                	mv	a1,s2
    1450:	00004517          	auipc	a0,0x4
    1454:	48850513          	add	a0,a0,1160 # 58d8 <malloc+0x506>
    1458:	6c7030ef          	jal	531e <printf>
    exit(1);
    145c:	4505                	li	a0,1
    145e:	251030ef          	jal	4eae <exit>
    printf("%s: open failed\n", s);
    1462:	85ca                	mv	a1,s2
    1464:	00005517          	auipc	a0,0x5
    1468:	94c50513          	add	a0,a0,-1716 # 5db0 <malloc+0x9de>
    146c:	6b3030ef          	jal	531e <printf>
    exit(1);
    1470:	4505                	li	a0,1
    1472:	23d030ef          	jal	4eae <exit>
  unlink("echo-ok");
    1476:	00005517          	auipc	a0,0x5
    147a:	9b250513          	add	a0,a0,-1614 # 5e28 <malloc+0xa56>
    147e:	281030ef          	jal	4efe <unlink>
  if(buf[0] == 'O' && buf[1] == 'K')
    1482:	fb844703          	lbu	a4,-72(s0)
    1486:	04f00793          	li	a5,79
    148a:	00f71863          	bne	a4,a5,149a <exectest+0x15c>
    148e:	fb944703          	lbu	a4,-71(s0)
    1492:	04b00793          	li	a5,75
    1496:	00f70c63          	beq	a4,a5,14ae <exectest+0x170>
    printf("%s: wrong output\n", s);
    149a:	85ca                	mv	a1,s2
    149c:	00005517          	auipc	a0,0x5
    14a0:	9ec50513          	add	a0,a0,-1556 # 5e88 <malloc+0xab6>
    14a4:	67b030ef          	jal	531e <printf>
    exit(1);
    14a8:	4505                	li	a0,1
    14aa:	205030ef          	jal	4eae <exit>
    exit(0);
    14ae:	4501                	li	a0,0
    14b0:	1ff030ef          	jal	4eae <exit>

00000000000014b4 <pipe1>:
{
    14b4:	711d                	add	sp,sp,-96
    14b6:	ec86                	sd	ra,88(sp)
    14b8:	e8a2                	sd	s0,80(sp)
    14ba:	fc4e                	sd	s3,56(sp)
    14bc:	1080                	add	s0,sp,96
    14be:	89aa                	mv	s3,a0
  if(pipe(fds) != 0){
    14c0:	fa840513          	add	a0,s0,-88
    14c4:	1fb030ef          	jal	4ebe <pipe>
    14c8:	e92d                	bnez	a0,153a <pipe1+0x86>
    14ca:	e4a6                	sd	s1,72(sp)
    14cc:	f852                	sd	s4,48(sp)
    14ce:	84aa                	mv	s1,a0
  pid = fork();
    14d0:	1d7030ef          	jal	4ea6 <fork>
    14d4:	8a2a                	mv	s4,a0
  if(pid == 0){
    14d6:	c151                	beqz	a0,155a <pipe1+0xa6>
  } else if(pid > 0){
    14d8:	14a05e63          	blez	a0,1634 <pipe1+0x180>
    14dc:	e0ca                	sd	s2,64(sp)
    14de:	f456                	sd	s5,40(sp)
    close(fds[1]);
    14e0:	fac42503          	lw	a0,-84(s0)
    14e4:	1f3030ef          	jal	4ed6 <close>
    total = 0;
    14e8:	8a26                	mv	s4,s1
    cc = 1;
    14ea:	4905                	li	s2,1
    while((n = read(fds[0], buf, cc)) > 0){
    14ec:	0000aa97          	auipc	s5,0xa
    14f0:	7cca8a93          	add	s5,s5,1996 # bcb8 <buf>
    14f4:	864a                	mv	a2,s2
    14f6:	85d6                	mv	a1,s5
    14f8:	fa842503          	lw	a0,-88(s0)
    14fc:	1cb030ef          	jal	4ec6 <read>
    1500:	0ea05a63          	blez	a0,15f4 <pipe1+0x140>
      for(i = 0; i < n; i++){
    1504:	0000a717          	auipc	a4,0xa
    1508:	7b470713          	add	a4,a4,1972 # bcb8 <buf>
    150c:	00a4863b          	addw	a2,s1,a0
        if((buf[i] & 0xff) != (seq++ & 0xff)){
    1510:	00074683          	lbu	a3,0(a4)
    1514:	0ff4f793          	zext.b	a5,s1
    1518:	2485                	addw	s1,s1,1
    151a:	0af69d63          	bne	a3,a5,15d4 <pipe1+0x120>
      for(i = 0; i < n; i++){
    151e:	0705                	add	a4,a4,1
    1520:	fec498e3          	bne	s1,a2,1510 <pipe1+0x5c>
      total += n;
    1524:	00aa0a3b          	addw	s4,s4,a0
      cc = cc * 2;
    1528:	0019179b          	sllw	a5,s2,0x1
    152c:	0007891b          	sext.w	s2,a5
      if(cc > sizeof(buf))
    1530:	670d                	lui	a4,0x3
    1532:	fd2771e3          	bgeu	a4,s2,14f4 <pipe1+0x40>
        cc = sizeof(buf);
    1536:	690d                	lui	s2,0x3
    1538:	bf75                	j	14f4 <pipe1+0x40>
    153a:	e4a6                	sd	s1,72(sp)
    153c:	e0ca                	sd	s2,64(sp)
    153e:	f852                	sd	s4,48(sp)
    1540:	f456                	sd	s5,40(sp)
    1542:	f05a                	sd	s6,32(sp)
    1544:	ec5e                	sd	s7,24(sp)
    printf("%s: pipe() failed\n", s);
    1546:	85ce                	mv	a1,s3
    1548:	00005517          	auipc	a0,0x5
    154c:	95850513          	add	a0,a0,-1704 # 5ea0 <malloc+0xace>
    1550:	5cf030ef          	jal	531e <printf>
    exit(1);
    1554:	4505                	li	a0,1
    1556:	159030ef          	jal	4eae <exit>
    155a:	e0ca                	sd	s2,64(sp)
    155c:	f456                	sd	s5,40(sp)
    155e:	f05a                	sd	s6,32(sp)
    1560:	ec5e                	sd	s7,24(sp)
    close(fds[0]);
    1562:	fa842503          	lw	a0,-88(s0)
    1566:	171030ef          	jal	4ed6 <close>
    for(n = 0; n < N; n++){
    156a:	0000ab17          	auipc	s6,0xa
    156e:	74eb0b13          	add	s6,s6,1870 # bcb8 <buf>
    1572:	416004bb          	negw	s1,s6
    1576:	0ff4f493          	zext.b	s1,s1
    157a:	409b0913          	add	s2,s6,1033
      if(write(fds[1], buf, SZ) != SZ){
    157e:	8bda                	mv	s7,s6
    for(n = 0; n < N; n++){
    1580:	6a85                	lui	s5,0x1
    1582:	42da8a93          	add	s5,s5,1069 # 142d <exectest+0xef>
{
    1586:	87da                	mv	a5,s6
        buf[i] = seq++;
    1588:	0097873b          	addw	a4,a5,s1
    158c:	00e78023          	sb	a4,0(a5)
      for(i = 0; i < SZ; i++)
    1590:	0785                	add	a5,a5,1
    1592:	ff279be3          	bne	a5,s2,1588 <pipe1+0xd4>
    1596:	409a0a1b          	addw	s4,s4,1033
      if(write(fds[1], buf, SZ) != SZ){
    159a:	40900613          	li	a2,1033
    159e:	85de                	mv	a1,s7
    15a0:	fac42503          	lw	a0,-84(s0)
    15a4:	12b030ef          	jal	4ece <write>
    15a8:	40900793          	li	a5,1033
    15ac:	00f51a63          	bne	a0,a5,15c0 <pipe1+0x10c>
    for(n = 0; n < N; n++){
    15b0:	24a5                	addw	s1,s1,9
    15b2:	0ff4f493          	zext.b	s1,s1
    15b6:	fd5a18e3          	bne	s4,s5,1586 <pipe1+0xd2>
    exit(0);
    15ba:	4501                	li	a0,0
    15bc:	0f3030ef          	jal	4eae <exit>
        printf("%s: pipe1 oops 1\n", s);
    15c0:	85ce                	mv	a1,s3
    15c2:	00005517          	auipc	a0,0x5
    15c6:	8f650513          	add	a0,a0,-1802 # 5eb8 <malloc+0xae6>
    15ca:	555030ef          	jal	531e <printf>
        exit(1);
    15ce:	4505                	li	a0,1
    15d0:	0df030ef          	jal	4eae <exit>
          printf("%s: pipe1 oops 2\n", s);
    15d4:	85ce                	mv	a1,s3
    15d6:	00005517          	auipc	a0,0x5
    15da:	8fa50513          	add	a0,a0,-1798 # 5ed0 <malloc+0xafe>
    15de:	541030ef          	jal	531e <printf>
          return;
    15e2:	64a6                	ld	s1,72(sp)
    15e4:	6906                	ld	s2,64(sp)
    15e6:	7a42                	ld	s4,48(sp)
    15e8:	7aa2                	ld	s5,40(sp)
}
    15ea:	60e6                	ld	ra,88(sp)
    15ec:	6446                	ld	s0,80(sp)
    15ee:	79e2                	ld	s3,56(sp)
    15f0:	6125                	add	sp,sp,96
    15f2:	8082                	ret
    if(total != N * SZ){
    15f4:	6785                	lui	a5,0x1
    15f6:	42d78793          	add	a5,a5,1069 # 142d <exectest+0xef>
    15fa:	00fa0f63          	beq	s4,a5,1618 <pipe1+0x164>
    15fe:	f05a                	sd	s6,32(sp)
    1600:	ec5e                	sd	s7,24(sp)
      printf("%s: pipe1 oops 3 total %d\n", s, total);
    1602:	8652                	mv	a2,s4
    1604:	85ce                	mv	a1,s3
    1606:	00005517          	auipc	a0,0x5
    160a:	8e250513          	add	a0,a0,-1822 # 5ee8 <malloc+0xb16>
    160e:	511030ef          	jal	531e <printf>
      exit(1);
    1612:	4505                	li	a0,1
    1614:	09b030ef          	jal	4eae <exit>
    1618:	f05a                	sd	s6,32(sp)
    161a:	ec5e                	sd	s7,24(sp)
    close(fds[0]);
    161c:	fa842503          	lw	a0,-88(s0)
    1620:	0b7030ef          	jal	4ed6 <close>
    wait(&xstatus);
    1624:	fa440513          	add	a0,s0,-92
    1628:	08f030ef          	jal	4eb6 <wait>
    exit(xstatus);
    162c:	fa442503          	lw	a0,-92(s0)
    1630:	07f030ef          	jal	4eae <exit>
    1634:	e0ca                	sd	s2,64(sp)
    1636:	f456                	sd	s5,40(sp)
    1638:	f05a                	sd	s6,32(sp)
    163a:	ec5e                	sd	s7,24(sp)
    printf("%s: fork() failed\n", s);
    163c:	85ce                	mv	a1,s3
    163e:	00005517          	auipc	a0,0x5
    1642:	8ca50513          	add	a0,a0,-1846 # 5f08 <malloc+0xb36>
    1646:	4d9030ef          	jal	531e <printf>
    exit(1);
    164a:	4505                	li	a0,1
    164c:	063030ef          	jal	4eae <exit>

0000000000001650 <exitwait>:
{
    1650:	7139                	add	sp,sp,-64
    1652:	fc06                	sd	ra,56(sp)
    1654:	f822                	sd	s0,48(sp)
    1656:	f426                	sd	s1,40(sp)
    1658:	f04a                	sd	s2,32(sp)
    165a:	ec4e                	sd	s3,24(sp)
    165c:	e852                	sd	s4,16(sp)
    165e:	0080                	add	s0,sp,64
    1660:	8a2a                	mv	s4,a0
  for(i = 0; i < 100; i++){
    1662:	4901                	li	s2,0
    1664:	06400993          	li	s3,100
    pid = fork();
    1668:	03f030ef          	jal	4ea6 <fork>
    166c:	84aa                	mv	s1,a0
    if(pid < 0){
    166e:	02054863          	bltz	a0,169e <exitwait+0x4e>
    if(pid){
    1672:	c525                	beqz	a0,16da <exitwait+0x8a>
      if(wait(&xstate) != pid){
    1674:	fcc40513          	add	a0,s0,-52
    1678:	03f030ef          	jal	4eb6 <wait>
    167c:	02951b63          	bne	a0,s1,16b2 <exitwait+0x62>
      if(i != xstate) {
    1680:	fcc42783          	lw	a5,-52(s0)
    1684:	05279163          	bne	a5,s2,16c6 <exitwait+0x76>
  for(i = 0; i < 100; i++){
    1688:	2905                	addw	s2,s2,1 # 3001 <subdir+0x43f>
    168a:	fd391fe3          	bne	s2,s3,1668 <exitwait+0x18>
}
    168e:	70e2                	ld	ra,56(sp)
    1690:	7442                	ld	s0,48(sp)
    1692:	74a2                	ld	s1,40(sp)
    1694:	7902                	ld	s2,32(sp)
    1696:	69e2                	ld	s3,24(sp)
    1698:	6a42                	ld	s4,16(sp)
    169a:	6121                	add	sp,sp,64
    169c:	8082                	ret
      printf("%s: fork failed\n", s);
    169e:	85d2                	mv	a1,s4
    16a0:	00004517          	auipc	a0,0x4
    16a4:	6f850513          	add	a0,a0,1784 # 5d98 <malloc+0x9c6>
    16a8:	477030ef          	jal	531e <printf>
      exit(1);
    16ac:	4505                	li	a0,1
    16ae:	001030ef          	jal	4eae <exit>
        printf("%s: wait wrong pid\n", s);
    16b2:	85d2                	mv	a1,s4
    16b4:	00005517          	auipc	a0,0x5
    16b8:	86c50513          	add	a0,a0,-1940 # 5f20 <malloc+0xb4e>
    16bc:	463030ef          	jal	531e <printf>
        exit(1);
    16c0:	4505                	li	a0,1
    16c2:	7ec030ef          	jal	4eae <exit>
        printf("%s: wait wrong exit status\n", s);
    16c6:	85d2                	mv	a1,s4
    16c8:	00005517          	auipc	a0,0x5
    16cc:	87050513          	add	a0,a0,-1936 # 5f38 <malloc+0xb66>
    16d0:	44f030ef          	jal	531e <printf>
        exit(1);
    16d4:	4505                	li	a0,1
    16d6:	7d8030ef          	jal	4eae <exit>
      exit(i);
    16da:	854a                	mv	a0,s2
    16dc:	7d2030ef          	jal	4eae <exit>

00000000000016e0 <twochildren>:
{
    16e0:	1101                	add	sp,sp,-32
    16e2:	ec06                	sd	ra,24(sp)
    16e4:	e822                	sd	s0,16(sp)
    16e6:	e426                	sd	s1,8(sp)
    16e8:	e04a                	sd	s2,0(sp)
    16ea:	1000                	add	s0,sp,32
    16ec:	892a                	mv	s2,a0
    16ee:	3e800493          	li	s1,1000
    int pid1 = fork();
    16f2:	7b4030ef          	jal	4ea6 <fork>
    if(pid1 < 0){
    16f6:	02054663          	bltz	a0,1722 <twochildren+0x42>
    if(pid1 == 0){
    16fa:	cd15                	beqz	a0,1736 <twochildren+0x56>
      int pid2 = fork();
    16fc:	7aa030ef          	jal	4ea6 <fork>
      if(pid2 < 0){
    1700:	02054d63          	bltz	a0,173a <twochildren+0x5a>
      if(pid2 == 0){
    1704:	c529                	beqz	a0,174e <twochildren+0x6e>
        wait(0);
    1706:	4501                	li	a0,0
    1708:	7ae030ef          	jal	4eb6 <wait>
        wait(0);
    170c:	4501                	li	a0,0
    170e:	7a8030ef          	jal	4eb6 <wait>
  for(int i = 0; i < 1000; i++){
    1712:	34fd                	addw	s1,s1,-1
    1714:	fcf9                	bnez	s1,16f2 <twochildren+0x12>
}
    1716:	60e2                	ld	ra,24(sp)
    1718:	6442                	ld	s0,16(sp)
    171a:	64a2                	ld	s1,8(sp)
    171c:	6902                	ld	s2,0(sp)
    171e:	6105                	add	sp,sp,32
    1720:	8082                	ret
      printf("%s: fork failed\n", s);
    1722:	85ca                	mv	a1,s2
    1724:	00004517          	auipc	a0,0x4
    1728:	67450513          	add	a0,a0,1652 # 5d98 <malloc+0x9c6>
    172c:	3f3030ef          	jal	531e <printf>
      exit(1);
    1730:	4505                	li	a0,1
    1732:	77c030ef          	jal	4eae <exit>
      exit(0);
    1736:	778030ef          	jal	4eae <exit>
        printf("%s: fork failed\n", s);
    173a:	85ca                	mv	a1,s2
    173c:	00004517          	auipc	a0,0x4
    1740:	65c50513          	add	a0,a0,1628 # 5d98 <malloc+0x9c6>
    1744:	3db030ef          	jal	531e <printf>
        exit(1);
    1748:	4505                	li	a0,1
    174a:	764030ef          	jal	4eae <exit>
        exit(0);
    174e:	760030ef          	jal	4eae <exit>

0000000000001752 <forkfork>:
{
    1752:	7179                	add	sp,sp,-48
    1754:	f406                	sd	ra,40(sp)
    1756:	f022                	sd	s0,32(sp)
    1758:	ec26                	sd	s1,24(sp)
    175a:	1800                	add	s0,sp,48
    175c:	84aa                	mv	s1,a0
    int pid = fork();
    175e:	748030ef          	jal	4ea6 <fork>
    if(pid < 0){
    1762:	02054b63          	bltz	a0,1798 <forkfork+0x46>
    if(pid == 0){
    1766:	c139                	beqz	a0,17ac <forkfork+0x5a>
    int pid = fork();
    1768:	73e030ef          	jal	4ea6 <fork>
    if(pid < 0){
    176c:	02054663          	bltz	a0,1798 <forkfork+0x46>
    if(pid == 0){
    1770:	cd15                	beqz	a0,17ac <forkfork+0x5a>
    wait(&xstatus);
    1772:	fdc40513          	add	a0,s0,-36
    1776:	740030ef          	jal	4eb6 <wait>
    if(xstatus != 0) {
    177a:	fdc42783          	lw	a5,-36(s0)
    177e:	ebb9                	bnez	a5,17d4 <forkfork+0x82>
    wait(&xstatus);
    1780:	fdc40513          	add	a0,s0,-36
    1784:	732030ef          	jal	4eb6 <wait>
    if(xstatus != 0) {
    1788:	fdc42783          	lw	a5,-36(s0)
    178c:	e7a1                	bnez	a5,17d4 <forkfork+0x82>
}
    178e:	70a2                	ld	ra,40(sp)
    1790:	7402                	ld	s0,32(sp)
    1792:	64e2                	ld	s1,24(sp)
    1794:	6145                	add	sp,sp,48
    1796:	8082                	ret
      printf("%s: fork failed", s);
    1798:	85a6                	mv	a1,s1
    179a:	00004517          	auipc	a0,0x4
    179e:	7be50513          	add	a0,a0,1982 # 5f58 <malloc+0xb86>
    17a2:	37d030ef          	jal	531e <printf>
      exit(1);
    17a6:	4505                	li	a0,1
    17a8:	706030ef          	jal	4eae <exit>
{
    17ac:	0c800493          	li	s1,200
        int pid1 = fork();
    17b0:	6f6030ef          	jal	4ea6 <fork>
        if(pid1 < 0){
    17b4:	00054b63          	bltz	a0,17ca <forkfork+0x78>
        if(pid1 == 0){
    17b8:	cd01                	beqz	a0,17d0 <forkfork+0x7e>
        wait(0);
    17ba:	4501                	li	a0,0
    17bc:	6fa030ef          	jal	4eb6 <wait>
      for(int j = 0; j < 200; j++){
    17c0:	34fd                	addw	s1,s1,-1
    17c2:	f4fd                	bnez	s1,17b0 <forkfork+0x5e>
      exit(0);
    17c4:	4501                	li	a0,0
    17c6:	6e8030ef          	jal	4eae <exit>
          exit(1);
    17ca:	4505                	li	a0,1
    17cc:	6e2030ef          	jal	4eae <exit>
          exit(0);
    17d0:	6de030ef          	jal	4eae <exit>
      printf("%s: fork in child failed", s);
    17d4:	85a6                	mv	a1,s1
    17d6:	00004517          	auipc	a0,0x4
    17da:	79250513          	add	a0,a0,1938 # 5f68 <malloc+0xb96>
    17de:	341030ef          	jal	531e <printf>
      exit(1);
    17e2:	4505                	li	a0,1
    17e4:	6ca030ef          	jal	4eae <exit>

00000000000017e8 <reparent2>:
{
    17e8:	1101                	add	sp,sp,-32
    17ea:	ec06                	sd	ra,24(sp)
    17ec:	e822                	sd	s0,16(sp)
    17ee:	e426                	sd	s1,8(sp)
    17f0:	1000                	add	s0,sp,32
    17f2:	32000493          	li	s1,800
    int pid1 = fork();
    17f6:	6b0030ef          	jal	4ea6 <fork>
    if(pid1 < 0){
    17fa:	00054b63          	bltz	a0,1810 <reparent2+0x28>
    if(pid1 == 0){
    17fe:	c115                	beqz	a0,1822 <reparent2+0x3a>
    wait(0);
    1800:	4501                	li	a0,0
    1802:	6b4030ef          	jal	4eb6 <wait>
  for(int i = 0; i < 800; i++){
    1806:	34fd                	addw	s1,s1,-1
    1808:	f4fd                	bnez	s1,17f6 <reparent2+0xe>
  exit(0);
    180a:	4501                	li	a0,0
    180c:	6a2030ef          	jal	4eae <exit>
      printf("fork failed\n");
    1810:	00006517          	auipc	a0,0x6
    1814:	b3050513          	add	a0,a0,-1232 # 7340 <malloc+0x1f6e>
    1818:	307030ef          	jal	531e <printf>
      exit(1);
    181c:	4505                	li	a0,1
    181e:	690030ef          	jal	4eae <exit>
      fork();
    1822:	684030ef          	jal	4ea6 <fork>
      fork();
    1826:	680030ef          	jal	4ea6 <fork>
      exit(0);
    182a:	4501                	li	a0,0
    182c:	682030ef          	jal	4eae <exit>

0000000000001830 <createdelete>:
{
    1830:	7175                	add	sp,sp,-144
    1832:	e506                	sd	ra,136(sp)
    1834:	e122                	sd	s0,128(sp)
    1836:	fca6                	sd	s1,120(sp)
    1838:	f8ca                	sd	s2,112(sp)
    183a:	f4ce                	sd	s3,104(sp)
    183c:	f0d2                	sd	s4,96(sp)
    183e:	ecd6                	sd	s5,88(sp)
    1840:	e8da                	sd	s6,80(sp)
    1842:	e4de                	sd	s7,72(sp)
    1844:	e0e2                	sd	s8,64(sp)
    1846:	fc66                	sd	s9,56(sp)
    1848:	0900                	add	s0,sp,144
    184a:	8caa                	mv	s9,a0
  for(pi = 0; pi < NCHILD; pi++){
    184c:	4901                	li	s2,0
    184e:	4991                	li	s3,4
    pid = fork();
    1850:	656030ef          	jal	4ea6 <fork>
    1854:	84aa                	mv	s1,a0
    if(pid < 0){
    1856:	02054d63          	bltz	a0,1890 <createdelete+0x60>
    if(pid == 0){
    185a:	c529                	beqz	a0,18a4 <createdelete+0x74>
  for(pi = 0; pi < NCHILD; pi++){
    185c:	2905                	addw	s2,s2,1
    185e:	ff3919e3          	bne	s2,s3,1850 <createdelete+0x20>
    1862:	4491                	li	s1,4
    wait(&xstatus);
    1864:	f7c40513          	add	a0,s0,-132
    1868:	64e030ef          	jal	4eb6 <wait>
    if(xstatus != 0)
    186c:	f7c42903          	lw	s2,-132(s0)
    1870:	0a091e63          	bnez	s2,192c <createdelete+0xfc>
  for(pi = 0; pi < NCHILD; pi++){
    1874:	34fd                	addw	s1,s1,-1
    1876:	f4fd                	bnez	s1,1864 <createdelete+0x34>
  name[0] = name[1] = name[2] = 0;
    1878:	f8040123          	sb	zero,-126(s0)
    187c:	03000993          	li	s3,48
    1880:	5a7d                	li	s4,-1
    1882:	07000c13          	li	s8,112
      if((i == 0 || i >= N/2) && fd < 0){
    1886:	4b25                	li	s6,9
      } else if((i >= 1 && i < N/2) && fd >= 0){
    1888:	4ba1                	li	s7,8
    for(pi = 0; pi < NCHILD; pi++){
    188a:	07400a93          	li	s5,116
    188e:	aa39                	j	19ac <createdelete+0x17c>
      printf("%s: fork failed\n", s);
    1890:	85e6                	mv	a1,s9
    1892:	00004517          	auipc	a0,0x4
    1896:	50650513          	add	a0,a0,1286 # 5d98 <malloc+0x9c6>
    189a:	285030ef          	jal	531e <printf>
      exit(1);
    189e:	4505                	li	a0,1
    18a0:	60e030ef          	jal	4eae <exit>
      name[0] = 'p' + pi;
    18a4:	0709091b          	addw	s2,s2,112
    18a8:	f9240023          	sb	s2,-128(s0)
      name[2] = '\0';
    18ac:	f8040123          	sb	zero,-126(s0)
      for(i = 0; i < N; i++){
    18b0:	4951                	li	s2,20
    18b2:	a831                	j	18ce <createdelete+0x9e>
          printf("%s: create failed\n", s);
    18b4:	85e6                	mv	a1,s9
    18b6:	00004517          	auipc	a0,0x4
    18ba:	57a50513          	add	a0,a0,1402 # 5e30 <malloc+0xa5e>
    18be:	261030ef          	jal	531e <printf>
          exit(1);
    18c2:	4505                	li	a0,1
    18c4:	5ea030ef          	jal	4eae <exit>
      for(i = 0; i < N; i++){
    18c8:	2485                	addw	s1,s1,1
    18ca:	05248e63          	beq	s1,s2,1926 <createdelete+0xf6>
        name[1] = '0' + i;
    18ce:	0304879b          	addw	a5,s1,48
    18d2:	f8f400a3          	sb	a5,-127(s0)
        fd = open(name, O_CREATE | O_RDWR);
    18d6:	20200593          	li	a1,514
    18da:	f8040513          	add	a0,s0,-128
    18de:	610030ef          	jal	4eee <open>
        if(fd < 0){
    18e2:	fc0549e3          	bltz	a0,18b4 <createdelete+0x84>
        close(fd);
    18e6:	5f0030ef          	jal	4ed6 <close>
        if(i > 0 && (i % 2 ) == 0){
    18ea:	10905063          	blez	s1,19ea <createdelete+0x1ba>
    18ee:	0014f793          	and	a5,s1,1
    18f2:	fbf9                	bnez	a5,18c8 <createdelete+0x98>
          name[1] = '0' + (i / 2);
    18f4:	01f4d79b          	srlw	a5,s1,0x1f
    18f8:	9fa5                	addw	a5,a5,s1
    18fa:	4017d79b          	sraw	a5,a5,0x1
    18fe:	0307879b          	addw	a5,a5,48
    1902:	f8f400a3          	sb	a5,-127(s0)
          if(unlink(name) < 0){
    1906:	f8040513          	add	a0,s0,-128
    190a:	5f4030ef          	jal	4efe <unlink>
    190e:	fa055de3          	bgez	a0,18c8 <createdelete+0x98>
            printf("%s: unlink failed\n", s);
    1912:	85e6                	mv	a1,s9
    1914:	00004517          	auipc	a0,0x4
    1918:	67450513          	add	a0,a0,1652 # 5f88 <malloc+0xbb6>
    191c:	203030ef          	jal	531e <printf>
            exit(1);
    1920:	4505                	li	a0,1
    1922:	58c030ef          	jal	4eae <exit>
      exit(0);
    1926:	4501                	li	a0,0
    1928:	586030ef          	jal	4eae <exit>
      exit(1);
    192c:	4505                	li	a0,1
    192e:	580030ef          	jal	4eae <exit>
        printf("%s: oops createdelete %s didn't exist\n", s, name);
    1932:	f8040613          	add	a2,s0,-128
    1936:	85e6                	mv	a1,s9
    1938:	00004517          	auipc	a0,0x4
    193c:	66850513          	add	a0,a0,1640 # 5fa0 <malloc+0xbce>
    1940:	1df030ef          	jal	531e <printf>
        exit(1);
    1944:	4505                	li	a0,1
    1946:	568030ef          	jal	4eae <exit>
      } else if((i >= 1 && i < N/2) && fd >= 0){
    194a:	034bfb63          	bgeu	s7,s4,1980 <createdelete+0x150>
      if(fd >= 0)
    194e:	02055663          	bgez	a0,197a <createdelete+0x14a>
    for(pi = 0; pi < NCHILD; pi++){
    1952:	2485                	addw	s1,s1,1
    1954:	0ff4f493          	zext.b	s1,s1
    1958:	05548263          	beq	s1,s5,199c <createdelete+0x16c>
      name[0] = 'p' + pi;
    195c:	f8940023          	sb	s1,-128(s0)
      name[1] = '0' + i;
    1960:	f93400a3          	sb	s3,-127(s0)
      fd = open(name, 0);
    1964:	4581                	li	a1,0
    1966:	f8040513          	add	a0,s0,-128
    196a:	584030ef          	jal	4eee <open>
      if((i == 0 || i >= N/2) && fd < 0){
    196e:	00090463          	beqz	s2,1976 <createdelete+0x146>
    1972:	fd2b5ce3          	bge	s6,s2,194a <createdelete+0x11a>
    1976:	fa054ee3          	bltz	a0,1932 <createdelete+0x102>
        close(fd);
    197a:	55c030ef          	jal	4ed6 <close>
    197e:	bfd1                	j	1952 <createdelete+0x122>
      } else if((i >= 1 && i < N/2) && fd >= 0){
    1980:	fc0549e3          	bltz	a0,1952 <createdelete+0x122>
        printf("%s: oops createdelete %s did exist\n", s, name);
    1984:	f8040613          	add	a2,s0,-128
    1988:	85e6                	mv	a1,s9
    198a:	00004517          	auipc	a0,0x4
    198e:	63e50513          	add	a0,a0,1598 # 5fc8 <malloc+0xbf6>
    1992:	18d030ef          	jal	531e <printf>
        exit(1);
    1996:	4505                	li	a0,1
    1998:	516030ef          	jal	4eae <exit>
  for(i = 0; i < N; i++){
    199c:	2905                	addw	s2,s2,1
    199e:	2a05                	addw	s4,s4,1
    19a0:	2985                	addw	s3,s3,1
    19a2:	0ff9f993          	zext.b	s3,s3
    19a6:	47d1                	li	a5,20
    19a8:	02f90863          	beq	s2,a5,19d8 <createdelete+0x1a8>
    for(pi = 0; pi < NCHILD; pi++){
    19ac:	84e2                	mv	s1,s8
    19ae:	b77d                	j	195c <createdelete+0x12c>
  for(i = 0; i < N; i++){
    19b0:	2905                	addw	s2,s2,1
    19b2:	0ff97913          	zext.b	s2,s2
    19b6:	03490c63          	beq	s2,s4,19ee <createdelete+0x1be>
  name[0] = name[1] = name[2] = 0;
    19ba:	84d6                	mv	s1,s5
      name[0] = 'p' + pi;
    19bc:	f8940023          	sb	s1,-128(s0)
      name[1] = '0' + i;
    19c0:	f92400a3          	sb	s2,-127(s0)
      unlink(name);
    19c4:	f8040513          	add	a0,s0,-128
    19c8:	536030ef          	jal	4efe <unlink>
    for(pi = 0; pi < NCHILD; pi++){
    19cc:	2485                	addw	s1,s1,1
    19ce:	0ff4f493          	zext.b	s1,s1
    19d2:	ff3495e3          	bne	s1,s3,19bc <createdelete+0x18c>
    19d6:	bfe9                	j	19b0 <createdelete+0x180>
    19d8:	03000913          	li	s2,48
  name[0] = name[1] = name[2] = 0;
    19dc:	07000a93          	li	s5,112
    for(pi = 0; pi < NCHILD; pi++){
    19e0:	07400993          	li	s3,116
  for(i = 0; i < N; i++){
    19e4:	04400a13          	li	s4,68
    19e8:	bfc9                	j	19ba <createdelete+0x18a>
      for(i = 0; i < N; i++){
    19ea:	2485                	addw	s1,s1,1
    19ec:	b5cd                	j	18ce <createdelete+0x9e>
}
    19ee:	60aa                	ld	ra,136(sp)
    19f0:	640a                	ld	s0,128(sp)
    19f2:	74e6                	ld	s1,120(sp)
    19f4:	7946                	ld	s2,112(sp)
    19f6:	79a6                	ld	s3,104(sp)
    19f8:	7a06                	ld	s4,96(sp)
    19fa:	6ae6                	ld	s5,88(sp)
    19fc:	6b46                	ld	s6,80(sp)
    19fe:	6ba6                	ld	s7,72(sp)
    1a00:	6c06                	ld	s8,64(sp)
    1a02:	7ce2                	ld	s9,56(sp)
    1a04:	6149                	add	sp,sp,144
    1a06:	8082                	ret

0000000000001a08 <linkunlink>:
{
    1a08:	711d                	add	sp,sp,-96
    1a0a:	ec86                	sd	ra,88(sp)
    1a0c:	e8a2                	sd	s0,80(sp)
    1a0e:	e4a6                	sd	s1,72(sp)
    1a10:	e0ca                	sd	s2,64(sp)
    1a12:	fc4e                	sd	s3,56(sp)
    1a14:	f852                	sd	s4,48(sp)
    1a16:	f456                	sd	s5,40(sp)
    1a18:	f05a                	sd	s6,32(sp)
    1a1a:	ec5e                	sd	s7,24(sp)
    1a1c:	e862                	sd	s8,16(sp)
    1a1e:	e466                	sd	s9,8(sp)
    1a20:	1080                	add	s0,sp,96
    1a22:	84aa                	mv	s1,a0
  unlink("x");
    1a24:	00004517          	auipc	a0,0x4
    1a28:	b5450513          	add	a0,a0,-1196 # 5578 <malloc+0x1a6>
    1a2c:	4d2030ef          	jal	4efe <unlink>
  pid = fork();
    1a30:	476030ef          	jal	4ea6 <fork>
  if(pid < 0){
    1a34:	02054b63          	bltz	a0,1a6a <linkunlink+0x62>
    1a38:	8caa                	mv	s9,a0
  unsigned int x = (pid ? 1 : 97);
    1a3a:	06100913          	li	s2,97
    1a3e:	c111                	beqz	a0,1a42 <linkunlink+0x3a>
    1a40:	4905                	li	s2,1
    1a42:	06400493          	li	s1,100
    x = x * 1103515245 + 12345;
    1a46:	41c65a37          	lui	s4,0x41c65
    1a4a:	e6da0a1b          	addw	s4,s4,-403 # 41c64e6d <base+0x41c561b5>
    1a4e:	698d                	lui	s3,0x3
    1a50:	0399899b          	addw	s3,s3,57 # 3039 <subdir+0x477>
    if((x % 3) == 0){
    1a54:	4a8d                	li	s5,3
    } else if((x % 3) == 1){
    1a56:	4b85                	li	s7,1
      unlink("x");
    1a58:	00004b17          	auipc	s6,0x4
    1a5c:	b20b0b13          	add	s6,s6,-1248 # 5578 <malloc+0x1a6>
      link("cat", "x");
    1a60:	00004c17          	auipc	s8,0x4
    1a64:	590c0c13          	add	s8,s8,1424 # 5ff0 <malloc+0xc1e>
    1a68:	a025                	j	1a90 <linkunlink+0x88>
    printf("%s: fork failed\n", s);
    1a6a:	85a6                	mv	a1,s1
    1a6c:	00004517          	auipc	a0,0x4
    1a70:	32c50513          	add	a0,a0,812 # 5d98 <malloc+0x9c6>
    1a74:	0ab030ef          	jal	531e <printf>
    exit(1);
    1a78:	4505                	li	a0,1
    1a7a:	434030ef          	jal	4eae <exit>
      close(open("x", O_RDWR | O_CREATE));
    1a7e:	20200593          	li	a1,514
    1a82:	855a                	mv	a0,s6
    1a84:	46a030ef          	jal	4eee <open>
    1a88:	44e030ef          	jal	4ed6 <close>
  for(i = 0; i < 100; i++){
    1a8c:	34fd                	addw	s1,s1,-1
    1a8e:	c495                	beqz	s1,1aba <linkunlink+0xb2>
    x = x * 1103515245 + 12345;
    1a90:	034907bb          	mulw	a5,s2,s4
    1a94:	013787bb          	addw	a5,a5,s3
    1a98:	0007891b          	sext.w	s2,a5
    if((x % 3) == 0){
    1a9c:	0357f7bb          	remuw	a5,a5,s5
    1aa0:	2781                	sext.w	a5,a5
    1aa2:	dff1                	beqz	a5,1a7e <linkunlink+0x76>
    } else if((x % 3) == 1){
    1aa4:	01778663          	beq	a5,s7,1ab0 <linkunlink+0xa8>
      unlink("x");
    1aa8:	855a                	mv	a0,s6
    1aaa:	454030ef          	jal	4efe <unlink>
    1aae:	bff9                	j	1a8c <linkunlink+0x84>
      link("cat", "x");
    1ab0:	85da                	mv	a1,s6
    1ab2:	8562                	mv	a0,s8
    1ab4:	45a030ef          	jal	4f0e <link>
    1ab8:	bfd1                	j	1a8c <linkunlink+0x84>
  if(pid)
    1aba:	020c8263          	beqz	s9,1ade <linkunlink+0xd6>
    wait(0);
    1abe:	4501                	li	a0,0
    1ac0:	3f6030ef          	jal	4eb6 <wait>
}
    1ac4:	60e6                	ld	ra,88(sp)
    1ac6:	6446                	ld	s0,80(sp)
    1ac8:	64a6                	ld	s1,72(sp)
    1aca:	6906                	ld	s2,64(sp)
    1acc:	79e2                	ld	s3,56(sp)
    1ace:	7a42                	ld	s4,48(sp)
    1ad0:	7aa2                	ld	s5,40(sp)
    1ad2:	7b02                	ld	s6,32(sp)
    1ad4:	6be2                	ld	s7,24(sp)
    1ad6:	6c42                	ld	s8,16(sp)
    1ad8:	6ca2                	ld	s9,8(sp)
    1ada:	6125                	add	sp,sp,96
    1adc:	8082                	ret
    exit(0);
    1ade:	4501                	li	a0,0
    1ae0:	3ce030ef          	jal	4eae <exit>

0000000000001ae4 <forktest>:
{
    1ae4:	7179                	add	sp,sp,-48
    1ae6:	f406                	sd	ra,40(sp)
    1ae8:	f022                	sd	s0,32(sp)
    1aea:	ec26                	sd	s1,24(sp)
    1aec:	e84a                	sd	s2,16(sp)
    1aee:	e44e                	sd	s3,8(sp)
    1af0:	1800                	add	s0,sp,48
    1af2:	89aa                	mv	s3,a0
  for(n=0; n<N; n++){
    1af4:	4481                	li	s1,0
    1af6:	3e800913          	li	s2,1000
    pid = fork();
    1afa:	3ac030ef          	jal	4ea6 <fork>
    if(pid < 0)
    1afe:	06054063          	bltz	a0,1b5e <forktest+0x7a>
    if(pid == 0)
    1b02:	cd11                	beqz	a0,1b1e <forktest+0x3a>
  for(n=0; n<N; n++){
    1b04:	2485                	addw	s1,s1,1
    1b06:	ff249ae3          	bne	s1,s2,1afa <forktest+0x16>
    printf("%s: fork claimed to work 1000 times!\n", s);
    1b0a:	85ce                	mv	a1,s3
    1b0c:	00004517          	auipc	a0,0x4
    1b10:	53450513          	add	a0,a0,1332 # 6040 <malloc+0xc6e>
    1b14:	00b030ef          	jal	531e <printf>
    exit(1);
    1b18:	4505                	li	a0,1
    1b1a:	394030ef          	jal	4eae <exit>
      exit(0);
    1b1e:	390030ef          	jal	4eae <exit>
    printf("%s: no fork at all!\n", s);
    1b22:	85ce                	mv	a1,s3
    1b24:	00004517          	auipc	a0,0x4
    1b28:	4d450513          	add	a0,a0,1236 # 5ff8 <malloc+0xc26>
    1b2c:	7f2030ef          	jal	531e <printf>
    exit(1);
    1b30:	4505                	li	a0,1
    1b32:	37c030ef          	jal	4eae <exit>
      printf("%s: wait stopped early\n", s);
    1b36:	85ce                	mv	a1,s3
    1b38:	00004517          	auipc	a0,0x4
    1b3c:	4d850513          	add	a0,a0,1240 # 6010 <malloc+0xc3e>
    1b40:	7de030ef          	jal	531e <printf>
      exit(1);
    1b44:	4505                	li	a0,1
    1b46:	368030ef          	jal	4eae <exit>
    printf("%s: wait got too many\n", s);
    1b4a:	85ce                	mv	a1,s3
    1b4c:	00004517          	auipc	a0,0x4
    1b50:	4dc50513          	add	a0,a0,1244 # 6028 <malloc+0xc56>
    1b54:	7ca030ef          	jal	531e <printf>
    exit(1);
    1b58:	4505                	li	a0,1
    1b5a:	354030ef          	jal	4eae <exit>
  if (n == 0) {
    1b5e:	d0f1                	beqz	s1,1b22 <forktest+0x3e>
  for(; n > 0; n--){
    1b60:	00905963          	blez	s1,1b72 <forktest+0x8e>
    if(wait(0) < 0){
    1b64:	4501                	li	a0,0
    1b66:	350030ef          	jal	4eb6 <wait>
    1b6a:	fc0546e3          	bltz	a0,1b36 <forktest+0x52>
  for(; n > 0; n--){
    1b6e:	34fd                	addw	s1,s1,-1
    1b70:	f8f5                	bnez	s1,1b64 <forktest+0x80>
  if(wait(0) != -1){
    1b72:	4501                	li	a0,0
    1b74:	342030ef          	jal	4eb6 <wait>
    1b78:	57fd                	li	a5,-1
    1b7a:	fcf518e3          	bne	a0,a5,1b4a <forktest+0x66>
}
    1b7e:	70a2                	ld	ra,40(sp)
    1b80:	7402                	ld	s0,32(sp)
    1b82:	64e2                	ld	s1,24(sp)
    1b84:	6942                	ld	s2,16(sp)
    1b86:	69a2                	ld	s3,8(sp)
    1b88:	6145                	add	sp,sp,48
    1b8a:	8082                	ret

0000000000001b8c <kernmem>:
{
    1b8c:	715d                	add	sp,sp,-80
    1b8e:	e486                	sd	ra,72(sp)
    1b90:	e0a2                	sd	s0,64(sp)
    1b92:	fc26                	sd	s1,56(sp)
    1b94:	f84a                	sd	s2,48(sp)
    1b96:	f44e                	sd	s3,40(sp)
    1b98:	f052                	sd	s4,32(sp)
    1b9a:	ec56                	sd	s5,24(sp)
    1b9c:	0880                	add	s0,sp,80
    1b9e:	8aaa                	mv	s5,a0
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    1ba0:	4485                	li	s1,1
    1ba2:	04fe                	sll	s1,s1,0x1f
    if(xstatus != -1)  // did kernel kill child?
    1ba4:	5a7d                	li	s4,-1
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    1ba6:	69b1                	lui	s3,0xc
    1ba8:	35098993          	add	s3,s3,848 # c350 <buf+0x698>
    1bac:	1003d937          	lui	s2,0x1003d
    1bb0:	090e                	sll	s2,s2,0x3
    1bb2:	48090913          	add	s2,s2,1152 # 1003d480 <base+0x1002e7c8>
    pid = fork();
    1bb6:	2f0030ef          	jal	4ea6 <fork>
    if(pid < 0){
    1bba:	02054763          	bltz	a0,1be8 <kernmem+0x5c>
    if(pid == 0){
    1bbe:	cd1d                	beqz	a0,1bfc <kernmem+0x70>
    wait(&xstatus);
    1bc0:	fbc40513          	add	a0,s0,-68
    1bc4:	2f2030ef          	jal	4eb6 <wait>
    if(xstatus != -1)  // did kernel kill child?
    1bc8:	fbc42783          	lw	a5,-68(s0)
    1bcc:	05479563          	bne	a5,s4,1c16 <kernmem+0x8a>
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    1bd0:	94ce                	add	s1,s1,s3
    1bd2:	ff2492e3          	bne	s1,s2,1bb6 <kernmem+0x2a>
}
    1bd6:	60a6                	ld	ra,72(sp)
    1bd8:	6406                	ld	s0,64(sp)
    1bda:	74e2                	ld	s1,56(sp)
    1bdc:	7942                	ld	s2,48(sp)
    1bde:	79a2                	ld	s3,40(sp)
    1be0:	7a02                	ld	s4,32(sp)
    1be2:	6ae2                	ld	s5,24(sp)
    1be4:	6161                	add	sp,sp,80
    1be6:	8082                	ret
      printf("%s: fork failed\n", s);
    1be8:	85d6                	mv	a1,s5
    1bea:	00004517          	auipc	a0,0x4
    1bee:	1ae50513          	add	a0,a0,430 # 5d98 <malloc+0x9c6>
    1bf2:	72c030ef          	jal	531e <printf>
      exit(1);
    1bf6:	4505                	li	a0,1
    1bf8:	2b6030ef          	jal	4eae <exit>
      printf("%s: oops could read %p = %x\n", s, a, *a);
    1bfc:	0004c683          	lbu	a3,0(s1)
    1c00:	8626                	mv	a2,s1
    1c02:	85d6                	mv	a1,s5
    1c04:	00004517          	auipc	a0,0x4
    1c08:	46450513          	add	a0,a0,1124 # 6068 <malloc+0xc96>
    1c0c:	712030ef          	jal	531e <printf>
      exit(1);
    1c10:	4505                	li	a0,1
    1c12:	29c030ef          	jal	4eae <exit>
      exit(1);
    1c16:	4505                	li	a0,1
    1c18:	296030ef          	jal	4eae <exit>

0000000000001c1c <MAXVAplus>:
{
    1c1c:	7179                	add	sp,sp,-48
    1c1e:	f406                	sd	ra,40(sp)
    1c20:	f022                	sd	s0,32(sp)
    1c22:	1800                	add	s0,sp,48
  volatile uint64 a = MAXVA;
    1c24:	4785                	li	a5,1
    1c26:	179a                	sll	a5,a5,0x26
    1c28:	fcf43c23          	sd	a5,-40(s0)
  for( ; a != 0; a <<= 1){
    1c2c:	fd843783          	ld	a5,-40(s0)
    1c30:	cf85                	beqz	a5,1c68 <MAXVAplus+0x4c>
    1c32:	ec26                	sd	s1,24(sp)
    1c34:	e84a                	sd	s2,16(sp)
    1c36:	892a                	mv	s2,a0
    if(xstatus != -1)  // did kernel kill child?
    1c38:	54fd                	li	s1,-1
    pid = fork();
    1c3a:	26c030ef          	jal	4ea6 <fork>
    if(pid < 0){
    1c3e:	02054963          	bltz	a0,1c70 <MAXVAplus+0x54>
    if(pid == 0){
    1c42:	c129                	beqz	a0,1c84 <MAXVAplus+0x68>
    wait(&xstatus);
    1c44:	fd440513          	add	a0,s0,-44
    1c48:	26e030ef          	jal	4eb6 <wait>
    if(xstatus != -1)  // did kernel kill child?
    1c4c:	fd442783          	lw	a5,-44(s0)
    1c50:	04979c63          	bne	a5,s1,1ca8 <MAXVAplus+0x8c>
  for( ; a != 0; a <<= 1){
    1c54:	fd843783          	ld	a5,-40(s0)
    1c58:	0786                	sll	a5,a5,0x1
    1c5a:	fcf43c23          	sd	a5,-40(s0)
    1c5e:	fd843783          	ld	a5,-40(s0)
    1c62:	ffe1                	bnez	a5,1c3a <MAXVAplus+0x1e>
    1c64:	64e2                	ld	s1,24(sp)
    1c66:	6942                	ld	s2,16(sp)
}
    1c68:	70a2                	ld	ra,40(sp)
    1c6a:	7402                	ld	s0,32(sp)
    1c6c:	6145                	add	sp,sp,48
    1c6e:	8082                	ret
      printf("%s: fork failed\n", s);
    1c70:	85ca                	mv	a1,s2
    1c72:	00004517          	auipc	a0,0x4
    1c76:	12650513          	add	a0,a0,294 # 5d98 <malloc+0x9c6>
    1c7a:	6a4030ef          	jal	531e <printf>
      exit(1);
    1c7e:	4505                	li	a0,1
    1c80:	22e030ef          	jal	4eae <exit>
      *(char*)a = 99;
    1c84:	fd843783          	ld	a5,-40(s0)
    1c88:	06300713          	li	a4,99
    1c8c:	00e78023          	sb	a4,0(a5)
      printf("%s: oops wrote %p\n", s, (void*)a);
    1c90:	fd843603          	ld	a2,-40(s0)
    1c94:	85ca                	mv	a1,s2
    1c96:	00004517          	auipc	a0,0x4
    1c9a:	3f250513          	add	a0,a0,1010 # 6088 <malloc+0xcb6>
    1c9e:	680030ef          	jal	531e <printf>
      exit(1);
    1ca2:	4505                	li	a0,1
    1ca4:	20a030ef          	jal	4eae <exit>
      exit(1);
    1ca8:	4505                	li	a0,1
    1caa:	204030ef          	jal	4eae <exit>

0000000000001cae <stacktest>:
{
    1cae:	7179                	add	sp,sp,-48
    1cb0:	f406                	sd	ra,40(sp)
    1cb2:	f022                	sd	s0,32(sp)
    1cb4:	ec26                	sd	s1,24(sp)
    1cb6:	1800                	add	s0,sp,48
    1cb8:	84aa                	mv	s1,a0
  pid = fork();
    1cba:	1ec030ef          	jal	4ea6 <fork>
  if(pid == 0) {
    1cbe:	cd11                	beqz	a0,1cda <stacktest+0x2c>
  } else if(pid < 0){
    1cc0:	02054c63          	bltz	a0,1cf8 <stacktest+0x4a>
  wait(&xstatus);
    1cc4:	fdc40513          	add	a0,s0,-36
    1cc8:	1ee030ef          	jal	4eb6 <wait>
  if(xstatus == -1)  // kernel killed child?
    1ccc:	fdc42503          	lw	a0,-36(s0)
    1cd0:	57fd                	li	a5,-1
    1cd2:	02f50d63          	beq	a0,a5,1d0c <stacktest+0x5e>
    exit(xstatus);
    1cd6:	1d8030ef          	jal	4eae <exit>

static inline uint64
r_sp()
{
  uint64 x;
  asm volatile("mv %0, sp" : "=r" (x) );
    1cda:	870a                	mv	a4,sp
    printf("%s: stacktest: read below stack %d\n", s, *sp);
    1cdc:	77fd                	lui	a5,0xfffff
    1cde:	97ba                	add	a5,a5,a4
    1ce0:	0007c603          	lbu	a2,0(a5) # fffffffffffff000 <base+0xffffffffffff0348>
    1ce4:	85a6                	mv	a1,s1
    1ce6:	00004517          	auipc	a0,0x4
    1cea:	3ba50513          	add	a0,a0,954 # 60a0 <malloc+0xcce>
    1cee:	630030ef          	jal	531e <printf>
    exit(1);
    1cf2:	4505                	li	a0,1
    1cf4:	1ba030ef          	jal	4eae <exit>
    printf("%s: fork failed\n", s);
    1cf8:	85a6                	mv	a1,s1
    1cfa:	00004517          	auipc	a0,0x4
    1cfe:	09e50513          	add	a0,a0,158 # 5d98 <malloc+0x9c6>
    1d02:	61c030ef          	jal	531e <printf>
    exit(1);
    1d06:	4505                	li	a0,1
    1d08:	1a6030ef          	jal	4eae <exit>
    exit(0);
    1d0c:	4501                	li	a0,0
    1d0e:	1a0030ef          	jal	4eae <exit>

0000000000001d12 <nowrite>:
{
    1d12:	7159                	add	sp,sp,-112
    1d14:	f486                	sd	ra,104(sp)
    1d16:	f0a2                	sd	s0,96(sp)
    1d18:	eca6                	sd	s1,88(sp)
    1d1a:	e8ca                	sd	s2,80(sp)
    1d1c:	e4ce                	sd	s3,72(sp)
    1d1e:	1880                	add	s0,sp,112
    1d20:	89aa                	mv	s3,a0
  uint64 addrs[] = { 0, 0x80000000LL, 0x3fffffe000, 0x3ffffff000, 0x4000000000,
    1d22:	00006797          	auipc	a5,0x6
    1d26:	d2e78793          	add	a5,a5,-722 # 7a50 <malloc+0x267e>
    1d2a:	7788                	ld	a0,40(a5)
    1d2c:	7b8c                	ld	a1,48(a5)
    1d2e:	7f90                	ld	a2,56(a5)
    1d30:	63b4                	ld	a3,64(a5)
    1d32:	67b8                	ld	a4,72(a5)
    1d34:	6bbc                	ld	a5,80(a5)
    1d36:	f8a43c23          	sd	a0,-104(s0)
    1d3a:	fab43023          	sd	a1,-96(s0)
    1d3e:	fac43423          	sd	a2,-88(s0)
    1d42:	fad43823          	sd	a3,-80(s0)
    1d46:	fae43c23          	sd	a4,-72(s0)
    1d4a:	fcf43023          	sd	a5,-64(s0)
  for(int ai = 0; ai < sizeof(addrs)/sizeof(addrs[0]); ai++){
    1d4e:	4481                	li	s1,0
    1d50:	4919                	li	s2,6
    pid = fork();
    1d52:	154030ef          	jal	4ea6 <fork>
    if(pid == 0) {
    1d56:	c105                	beqz	a0,1d76 <nowrite+0x64>
    } else if(pid < 0){
    1d58:	04054263          	bltz	a0,1d9c <nowrite+0x8a>
    wait(&xstatus);
    1d5c:	fcc40513          	add	a0,s0,-52
    1d60:	156030ef          	jal	4eb6 <wait>
    if(xstatus == 0){
    1d64:	fcc42783          	lw	a5,-52(s0)
    1d68:	c7a1                	beqz	a5,1db0 <nowrite+0x9e>
  for(int ai = 0; ai < sizeof(addrs)/sizeof(addrs[0]); ai++){
    1d6a:	2485                	addw	s1,s1,1
    1d6c:	ff2493e3          	bne	s1,s2,1d52 <nowrite+0x40>
  exit(0);
    1d70:	4501                	li	a0,0
    1d72:	13c030ef          	jal	4eae <exit>
      volatile int *addr = (int *) addrs[ai];
    1d76:	048e                	sll	s1,s1,0x3
    1d78:	fd048793          	add	a5,s1,-48
    1d7c:	008784b3          	add	s1,a5,s0
    1d80:	fc84b603          	ld	a2,-56(s1)
      *addr = 10;
    1d84:	47a9                	li	a5,10
    1d86:	c21c                	sw	a5,0(a2)
      printf("%s: write to %p did not fail!\n", s, addr);
    1d88:	85ce                	mv	a1,s3
    1d8a:	00004517          	auipc	a0,0x4
    1d8e:	33e50513          	add	a0,a0,830 # 60c8 <malloc+0xcf6>
    1d92:	58c030ef          	jal	531e <printf>
      exit(0);
    1d96:	4501                	li	a0,0
    1d98:	116030ef          	jal	4eae <exit>
      printf("%s: fork failed\n", s);
    1d9c:	85ce                	mv	a1,s3
    1d9e:	00004517          	auipc	a0,0x4
    1da2:	ffa50513          	add	a0,a0,-6 # 5d98 <malloc+0x9c6>
    1da6:	578030ef          	jal	531e <printf>
      exit(1);
    1daa:	4505                	li	a0,1
    1dac:	102030ef          	jal	4eae <exit>
      exit(1);
    1db0:	4505                	li	a0,1
    1db2:	0fc030ef          	jal	4eae <exit>

0000000000001db6 <manywrites>:
{
    1db6:	711d                	add	sp,sp,-96
    1db8:	ec86                	sd	ra,88(sp)
    1dba:	e8a2                	sd	s0,80(sp)
    1dbc:	e4a6                	sd	s1,72(sp)
    1dbe:	e0ca                	sd	s2,64(sp)
    1dc0:	fc4e                	sd	s3,56(sp)
    1dc2:	f456                	sd	s5,40(sp)
    1dc4:	1080                	add	s0,sp,96
    1dc6:	8aaa                	mv	s5,a0
  for(int ci = 0; ci < nchildren; ci++){
    1dc8:	4981                	li	s3,0
    1dca:	4911                	li	s2,4
    int pid = fork();
    1dcc:	0da030ef          	jal	4ea6 <fork>
    1dd0:	84aa                	mv	s1,a0
    if(pid < 0){
    1dd2:	02054963          	bltz	a0,1e04 <manywrites+0x4e>
    if(pid == 0){
    1dd6:	c139                	beqz	a0,1e1c <manywrites+0x66>
  for(int ci = 0; ci < nchildren; ci++){
    1dd8:	2985                	addw	s3,s3,1
    1dda:	ff2999e3          	bne	s3,s2,1dcc <manywrites+0x16>
    1dde:	f852                	sd	s4,48(sp)
    1de0:	f05a                	sd	s6,32(sp)
    1de2:	ec5e                	sd	s7,24(sp)
    1de4:	4491                	li	s1,4
    int st = 0;
    1de6:	fa042423          	sw	zero,-88(s0)
    wait(&st);
    1dea:	fa840513          	add	a0,s0,-88
    1dee:	0c8030ef          	jal	4eb6 <wait>
    if(st != 0)
    1df2:	fa842503          	lw	a0,-88(s0)
    1df6:	0c051863          	bnez	a0,1ec6 <manywrites+0x110>
  for(int ci = 0; ci < nchildren; ci++){
    1dfa:	34fd                	addw	s1,s1,-1
    1dfc:	f4ed                	bnez	s1,1de6 <manywrites+0x30>
  exit(0);
    1dfe:	4501                	li	a0,0
    1e00:	0ae030ef          	jal	4eae <exit>
    1e04:	f852                	sd	s4,48(sp)
    1e06:	f05a                	sd	s6,32(sp)
    1e08:	ec5e                	sd	s7,24(sp)
      printf("fork failed\n");
    1e0a:	00005517          	auipc	a0,0x5
    1e0e:	53650513          	add	a0,a0,1334 # 7340 <malloc+0x1f6e>
    1e12:	50c030ef          	jal	531e <printf>
      exit(1);
    1e16:	4505                	li	a0,1
    1e18:	096030ef          	jal	4eae <exit>
    1e1c:	f852                	sd	s4,48(sp)
    1e1e:	f05a                	sd	s6,32(sp)
    1e20:	ec5e                	sd	s7,24(sp)
      name[0] = 'b';
    1e22:	06200793          	li	a5,98
    1e26:	faf40423          	sb	a5,-88(s0)
      name[1] = 'a' + ci;
    1e2a:	0619879b          	addw	a5,s3,97
    1e2e:	faf404a3          	sb	a5,-87(s0)
      name[2] = '\0';
    1e32:	fa040523          	sb	zero,-86(s0)
      unlink(name);
    1e36:	fa840513          	add	a0,s0,-88
    1e3a:	0c4030ef          	jal	4efe <unlink>
    1e3e:	4bf9                	li	s7,30
          int cc = write(fd, buf, sz);
    1e40:	0000ab17          	auipc	s6,0xa
    1e44:	e78b0b13          	add	s6,s6,-392 # bcb8 <buf>
        for(int i = 0; i < ci+1; i++){
    1e48:	8a26                	mv	s4,s1
    1e4a:	0209c863          	bltz	s3,1e7a <manywrites+0xc4>
          int fd = open(name, O_CREATE | O_RDWR);
    1e4e:	20200593          	li	a1,514
    1e52:	fa840513          	add	a0,s0,-88
    1e56:	098030ef          	jal	4eee <open>
    1e5a:	892a                	mv	s2,a0
          if(fd < 0){
    1e5c:	02054d63          	bltz	a0,1e96 <manywrites+0xe0>
          int cc = write(fd, buf, sz);
    1e60:	660d                	lui	a2,0x3
    1e62:	85da                	mv	a1,s6
    1e64:	06a030ef          	jal	4ece <write>
          if(cc != sz){
    1e68:	678d                	lui	a5,0x3
    1e6a:	04f51263          	bne	a0,a5,1eae <manywrites+0xf8>
          close(fd);
    1e6e:	854a                	mv	a0,s2
    1e70:	066030ef          	jal	4ed6 <close>
        for(int i = 0; i < ci+1; i++){
    1e74:	2a05                	addw	s4,s4,1
    1e76:	fd49dce3          	bge	s3,s4,1e4e <manywrites+0x98>
        unlink(name);
    1e7a:	fa840513          	add	a0,s0,-88
    1e7e:	080030ef          	jal	4efe <unlink>
      for(int iters = 0; iters < howmany; iters++){
    1e82:	3bfd                	addw	s7,s7,-1
    1e84:	fc0b92e3          	bnez	s7,1e48 <manywrites+0x92>
      unlink(name);
    1e88:	fa840513          	add	a0,s0,-88
    1e8c:	072030ef          	jal	4efe <unlink>
      exit(0);
    1e90:	4501                	li	a0,0
    1e92:	01c030ef          	jal	4eae <exit>
            printf("%s: cannot create %s\n", s, name);
    1e96:	fa840613          	add	a2,s0,-88
    1e9a:	85d6                	mv	a1,s5
    1e9c:	00004517          	auipc	a0,0x4
    1ea0:	24c50513          	add	a0,a0,588 # 60e8 <malloc+0xd16>
    1ea4:	47a030ef          	jal	531e <printf>
            exit(1);
    1ea8:	4505                	li	a0,1
    1eaa:	004030ef          	jal	4eae <exit>
            printf("%s: write(%d) ret %d\n", s, sz, cc);
    1eae:	86aa                	mv	a3,a0
    1eb0:	660d                	lui	a2,0x3
    1eb2:	85d6                	mv	a1,s5
    1eb4:	00003517          	auipc	a0,0x3
    1eb8:	72450513          	add	a0,a0,1828 # 55d8 <malloc+0x206>
    1ebc:	462030ef          	jal	531e <printf>
            exit(1);
    1ec0:	4505                	li	a0,1
    1ec2:	7ed020ef          	jal	4eae <exit>
      exit(st);
    1ec6:	7e9020ef          	jal	4eae <exit>

0000000000001eca <copyinstr3>:
{
    1eca:	7179                	add	sp,sp,-48
    1ecc:	f406                	sd	ra,40(sp)
    1ece:	f022                	sd	s0,32(sp)
    1ed0:	ec26                	sd	s1,24(sp)
    1ed2:	1800                	add	s0,sp,48
  sbrk(8192);
    1ed4:	6509                	lui	a0,0x2
    1ed6:	705020ef          	jal	4dda <sbrk>
  uint64 top = (uint64) sbrk(0);
    1eda:	4501                	li	a0,0
    1edc:	6ff020ef          	jal	4dda <sbrk>
  if((top % PGSIZE) != 0){
    1ee0:	03451793          	sll	a5,a0,0x34
    1ee4:	e7bd                	bnez	a5,1f52 <copyinstr3+0x88>
  top = (uint64) sbrk(0);
    1ee6:	4501                	li	a0,0
    1ee8:	6f3020ef          	jal	4dda <sbrk>
  if(top % PGSIZE){
    1eec:	03451793          	sll	a5,a0,0x34
    1ef0:	ebad                	bnez	a5,1f62 <copyinstr3+0x98>
  char *b = (char *) (top - 1);
    1ef2:	fff50493          	add	s1,a0,-1 # 1fff <rwsbrk+0x31>
  *b = 'x';
    1ef6:	07800793          	li	a5,120
    1efa:	fef50fa3          	sb	a5,-1(a0)
  int ret = unlink(b);
    1efe:	8526                	mv	a0,s1
    1f00:	7ff020ef          	jal	4efe <unlink>
  if(ret != -1){
    1f04:	57fd                	li	a5,-1
    1f06:	06f51763          	bne	a0,a5,1f74 <copyinstr3+0xaa>
  int fd = open(b, O_CREATE | O_WRONLY);
    1f0a:	20100593          	li	a1,513
    1f0e:	8526                	mv	a0,s1
    1f10:	7df020ef          	jal	4eee <open>
  if(fd != -1){
    1f14:	57fd                	li	a5,-1
    1f16:	06f51a63          	bne	a0,a5,1f8a <copyinstr3+0xc0>
  ret = link(b, b);
    1f1a:	85a6                	mv	a1,s1
    1f1c:	8526                	mv	a0,s1
    1f1e:	7f1020ef          	jal	4f0e <link>
  if(ret != -1){
    1f22:	57fd                	li	a5,-1
    1f24:	06f51e63          	bne	a0,a5,1fa0 <copyinstr3+0xd6>
  char *args[] = { "xx", 0 };
    1f28:	00005797          	auipc	a5,0x5
    1f2c:	ec078793          	add	a5,a5,-320 # 6de8 <malloc+0x1a16>
    1f30:	fcf43823          	sd	a5,-48(s0)
    1f34:	fc043c23          	sd	zero,-40(s0)
  ret = exec(b, args);
    1f38:	fd040593          	add	a1,s0,-48
    1f3c:	8526                	mv	a0,s1
    1f3e:	7a9020ef          	jal	4ee6 <exec>
  if(ret != -1){
    1f42:	57fd                	li	a5,-1
    1f44:	06f51a63          	bne	a0,a5,1fb8 <copyinstr3+0xee>
}
    1f48:	70a2                	ld	ra,40(sp)
    1f4a:	7402                	ld	s0,32(sp)
    1f4c:	64e2                	ld	s1,24(sp)
    1f4e:	6145                	add	sp,sp,48
    1f50:	8082                	ret
    sbrk(PGSIZE - (top % PGSIZE));
    1f52:	0347d513          	srl	a0,a5,0x34
    1f56:	6785                	lui	a5,0x1
    1f58:	40a7853b          	subw	a0,a5,a0
    1f5c:	67f020ef          	jal	4dda <sbrk>
    1f60:	b759                	j	1ee6 <copyinstr3+0x1c>
    printf("oops\n");
    1f62:	00004517          	auipc	a0,0x4
    1f66:	19e50513          	add	a0,a0,414 # 6100 <malloc+0xd2e>
    1f6a:	3b4030ef          	jal	531e <printf>
    exit(1);
    1f6e:	4505                	li	a0,1
    1f70:	73f020ef          	jal	4eae <exit>
    printf("unlink(%s) returned %d, not -1\n", b, ret);
    1f74:	862a                	mv	a2,a0
    1f76:	85a6                	mv	a1,s1
    1f78:	00004517          	auipc	a0,0x4
    1f7c:	d4050513          	add	a0,a0,-704 # 5cb8 <malloc+0x8e6>
    1f80:	39e030ef          	jal	531e <printf>
    exit(1);
    1f84:	4505                	li	a0,1
    1f86:	729020ef          	jal	4eae <exit>
    printf("open(%s) returned %d, not -1\n", b, fd);
    1f8a:	862a                	mv	a2,a0
    1f8c:	85a6                	mv	a1,s1
    1f8e:	00004517          	auipc	a0,0x4
    1f92:	d4a50513          	add	a0,a0,-694 # 5cd8 <malloc+0x906>
    1f96:	388030ef          	jal	531e <printf>
    exit(1);
    1f9a:	4505                	li	a0,1
    1f9c:	713020ef          	jal	4eae <exit>
    printf("link(%s, %s) returned %d, not -1\n", b, b, ret);
    1fa0:	86aa                	mv	a3,a0
    1fa2:	8626                	mv	a2,s1
    1fa4:	85a6                	mv	a1,s1
    1fa6:	00004517          	auipc	a0,0x4
    1faa:	d5250513          	add	a0,a0,-686 # 5cf8 <malloc+0x926>
    1fae:	370030ef          	jal	531e <printf>
    exit(1);
    1fb2:	4505                	li	a0,1
    1fb4:	6fb020ef          	jal	4eae <exit>
    printf("exec(%s) returned %d, not -1\n", b, fd);
    1fb8:	567d                	li	a2,-1
    1fba:	85a6                	mv	a1,s1
    1fbc:	00004517          	auipc	a0,0x4
    1fc0:	d6450513          	add	a0,a0,-668 # 5d20 <malloc+0x94e>
    1fc4:	35a030ef          	jal	531e <printf>
    exit(1);
    1fc8:	4505                	li	a0,1
    1fca:	6e5020ef          	jal	4eae <exit>

0000000000001fce <rwsbrk>:
{
    1fce:	1101                	add	sp,sp,-32
    1fd0:	ec06                	sd	ra,24(sp)
    1fd2:	e822                	sd	s0,16(sp)
    1fd4:	1000                	add	s0,sp,32
  uint64 a = (uint64) sbrk(8192);
    1fd6:	6509                	lui	a0,0x2
    1fd8:	603020ef          	jal	4dda <sbrk>
  if(a == (uint64) SBRK_ERROR) {
    1fdc:	57fd                	li	a5,-1
    1fde:	04f50a63          	beq	a0,a5,2032 <rwsbrk+0x64>
    1fe2:	e426                	sd	s1,8(sp)
    1fe4:	84aa                	mv	s1,a0
  if (sbrk(-8192) == SBRK_ERROR) {
    1fe6:	7579                	lui	a0,0xffffe
    1fe8:	5f3020ef          	jal	4dda <sbrk>
    1fec:	57fd                	li	a5,-1
    1fee:	04f50d63          	beq	a0,a5,2048 <rwsbrk+0x7a>
    1ff2:	e04a                	sd	s2,0(sp)
  fd = open("rwsbrk", O_CREATE|O_WRONLY);
    1ff4:	20100593          	li	a1,513
    1ff8:	00004517          	auipc	a0,0x4
    1ffc:	14850513          	add	a0,a0,328 # 6140 <malloc+0xd6e>
    2000:	6ef020ef          	jal	4eee <open>
    2004:	892a                	mv	s2,a0
  if(fd < 0){
    2006:	04054b63          	bltz	a0,205c <rwsbrk+0x8e>
  n = write(fd, (void*)(a+PGSIZE), 1024);
    200a:	6785                	lui	a5,0x1
    200c:	94be                	add	s1,s1,a5
    200e:	40000613          	li	a2,1024
    2012:	85a6                	mv	a1,s1
    2014:	6bb020ef          	jal	4ece <write>
    2018:	862a                	mv	a2,a0
  if(n >= 0){
    201a:	04054a63          	bltz	a0,206e <rwsbrk+0xa0>
    printf("write(fd, %p, 1024) returned %d, not -1\n", (void*)a+PGSIZE, n);
    201e:	85a6                	mv	a1,s1
    2020:	00004517          	auipc	a0,0x4
    2024:	14050513          	add	a0,a0,320 # 6160 <malloc+0xd8e>
    2028:	2f6030ef          	jal	531e <printf>
    exit(1);
    202c:	4505                	li	a0,1
    202e:	681020ef          	jal	4eae <exit>
    2032:	e426                	sd	s1,8(sp)
    2034:	e04a                	sd	s2,0(sp)
    printf("sbrk(rwsbrk) failed\n");
    2036:	00004517          	auipc	a0,0x4
    203a:	0d250513          	add	a0,a0,210 # 6108 <malloc+0xd36>
    203e:	2e0030ef          	jal	531e <printf>
    exit(1);
    2042:	4505                	li	a0,1
    2044:	66b020ef          	jal	4eae <exit>
    2048:	e04a                	sd	s2,0(sp)
    printf("sbrk(rwsbrk) shrink failed\n");
    204a:	00004517          	auipc	a0,0x4
    204e:	0d650513          	add	a0,a0,214 # 6120 <malloc+0xd4e>
    2052:	2cc030ef          	jal	531e <printf>
    exit(1);
    2056:	4505                	li	a0,1
    2058:	657020ef          	jal	4eae <exit>
    printf("open(rwsbrk) failed\n");
    205c:	00004517          	auipc	a0,0x4
    2060:	0ec50513          	add	a0,a0,236 # 6148 <malloc+0xd76>
    2064:	2ba030ef          	jal	531e <printf>
    exit(1);
    2068:	4505                	li	a0,1
    206a:	645020ef          	jal	4eae <exit>
  close(fd);
    206e:	854a                	mv	a0,s2
    2070:	667020ef          	jal	4ed6 <close>
  unlink("rwsbrk");
    2074:	00004517          	auipc	a0,0x4
    2078:	0cc50513          	add	a0,a0,204 # 6140 <malloc+0xd6e>
    207c:	683020ef          	jal	4efe <unlink>
  fd = open("README", O_RDONLY);
    2080:	4581                	li	a1,0
    2082:	00003517          	auipc	a0,0x3
    2086:	65e50513          	add	a0,a0,1630 # 56e0 <malloc+0x30e>
    208a:	665020ef          	jal	4eee <open>
    208e:	892a                	mv	s2,a0
  if(fd < 0){
    2090:	02054363          	bltz	a0,20b6 <rwsbrk+0xe8>
  n = read(fd, (void*)(a+PGSIZE), 10);
    2094:	4629                	li	a2,10
    2096:	85a6                	mv	a1,s1
    2098:	62f020ef          	jal	4ec6 <read>
    209c:	862a                	mv	a2,a0
  if(n >= 0){
    209e:	02054563          	bltz	a0,20c8 <rwsbrk+0xfa>
    printf("read(fd, %p, 10) returned %d, not -1\n", (void*)a+PGSIZE, n);
    20a2:	85a6                	mv	a1,s1
    20a4:	00004517          	auipc	a0,0x4
    20a8:	0ec50513          	add	a0,a0,236 # 6190 <malloc+0xdbe>
    20ac:	272030ef          	jal	531e <printf>
    exit(1);
    20b0:	4505                	li	a0,1
    20b2:	5fd020ef          	jal	4eae <exit>
    printf("open(README) failed\n");
    20b6:	00003517          	auipc	a0,0x3
    20ba:	63250513          	add	a0,a0,1586 # 56e8 <malloc+0x316>
    20be:	260030ef          	jal	531e <printf>
    exit(1);
    20c2:	4505                	li	a0,1
    20c4:	5eb020ef          	jal	4eae <exit>
  close(fd);
    20c8:	854a                	mv	a0,s2
    20ca:	60d020ef          	jal	4ed6 <close>
  exit(0);
    20ce:	4501                	li	a0,0
    20d0:	5df020ef          	jal	4eae <exit>

00000000000020d4 <sbrkbasic>:
{
    20d4:	7139                	add	sp,sp,-64
    20d6:	fc06                	sd	ra,56(sp)
    20d8:	f822                	sd	s0,48(sp)
    20da:	ec4e                	sd	s3,24(sp)
    20dc:	0080                	add	s0,sp,64
    20de:	89aa                	mv	s3,a0
  pid = fork();
    20e0:	5c7020ef          	jal	4ea6 <fork>
  if(pid < 0){
    20e4:	02054b63          	bltz	a0,211a <sbrkbasic+0x46>
  if(pid == 0){
    20e8:	e939                	bnez	a0,213e <sbrkbasic+0x6a>
    a = sbrk(TOOMUCH);
    20ea:	40000537          	lui	a0,0x40000
    20ee:	4ed020ef          	jal	4dda <sbrk>
    if(a == (char*)SBRK_ERROR){
    20f2:	57fd                	li	a5,-1
    20f4:	02f50f63          	beq	a0,a5,2132 <sbrkbasic+0x5e>
    20f8:	f426                	sd	s1,40(sp)
    20fa:	f04a                	sd	s2,32(sp)
    20fc:	e852                	sd	s4,16(sp)
    for(b = a; b < a+TOOMUCH; b += PGSIZE){
    20fe:	400007b7          	lui	a5,0x40000
    2102:	97aa                	add	a5,a5,a0
      *b = 99;
    2104:	06300693          	li	a3,99
    for(b = a; b < a+TOOMUCH; b += PGSIZE){
    2108:	6705                	lui	a4,0x1
      *b = 99;
    210a:	00d50023          	sb	a3,0(a0) # 40000000 <base+0x3fff1348>
    for(b = a; b < a+TOOMUCH; b += PGSIZE){
    210e:	953a                	add	a0,a0,a4
    2110:	fef51de3          	bne	a0,a5,210a <sbrkbasic+0x36>
    exit(1);
    2114:	4505                	li	a0,1
    2116:	599020ef          	jal	4eae <exit>
    211a:	f426                	sd	s1,40(sp)
    211c:	f04a                	sd	s2,32(sp)
    211e:	e852                	sd	s4,16(sp)
    printf("fork failed in sbrkbasic\n");
    2120:	00004517          	auipc	a0,0x4
    2124:	09850513          	add	a0,a0,152 # 61b8 <malloc+0xde6>
    2128:	1f6030ef          	jal	531e <printf>
    exit(1);
    212c:	4505                	li	a0,1
    212e:	581020ef          	jal	4eae <exit>
    2132:	f426                	sd	s1,40(sp)
    2134:	f04a                	sd	s2,32(sp)
    2136:	e852                	sd	s4,16(sp)
      exit(0);
    2138:	4501                	li	a0,0
    213a:	575020ef          	jal	4eae <exit>
  wait(&xstatus);
    213e:	fcc40513          	add	a0,s0,-52
    2142:	575020ef          	jal	4eb6 <wait>
  if(xstatus == 1){
    2146:	fcc42703          	lw	a4,-52(s0)
    214a:	4785                	li	a5,1
    214c:	00f70e63          	beq	a4,a5,2168 <sbrkbasic+0x94>
    2150:	f426                	sd	s1,40(sp)
    2152:	f04a                	sd	s2,32(sp)
    2154:	e852                	sd	s4,16(sp)
  a = sbrk(0);
    2156:	4501                	li	a0,0
    2158:	483020ef          	jal	4dda <sbrk>
    215c:	84aa                	mv	s1,a0
  for(i = 0; i < 5000; i++){
    215e:	4901                	li	s2,0
    2160:	6a05                	lui	s4,0x1
    2162:	388a0a13          	add	s4,s4,904 # 1388 <exectest+0x4a>
    2166:	a839                	j	2184 <sbrkbasic+0xb0>
    2168:	f426                	sd	s1,40(sp)
    216a:	f04a                	sd	s2,32(sp)
    216c:	e852                	sd	s4,16(sp)
    printf("%s: too much memory allocated!\n", s);
    216e:	85ce                	mv	a1,s3
    2170:	00004517          	auipc	a0,0x4
    2174:	06850513          	add	a0,a0,104 # 61d8 <malloc+0xe06>
    2178:	1a6030ef          	jal	531e <printf>
    exit(1);
    217c:	4505                	li	a0,1
    217e:	531020ef          	jal	4eae <exit>
    2182:	84be                	mv	s1,a5
    b = sbrk(1);
    2184:	4505                	li	a0,1
    2186:	455020ef          	jal	4dda <sbrk>
    if(b != a){
    218a:	04951263          	bne	a0,s1,21ce <sbrkbasic+0xfa>
    *b = 1;
    218e:	4785                	li	a5,1
    2190:	00f48023          	sb	a5,0(s1)
    a = b + 1;
    2194:	00148793          	add	a5,s1,1
  for(i = 0; i < 5000; i++){
    2198:	2905                	addw	s2,s2,1
    219a:	ff4914e3          	bne	s2,s4,2182 <sbrkbasic+0xae>
  pid = fork();
    219e:	509020ef          	jal	4ea6 <fork>
    21a2:	892a                	mv	s2,a0
  if(pid < 0){
    21a4:	04054263          	bltz	a0,21e8 <sbrkbasic+0x114>
  c = sbrk(1);
    21a8:	4505                	li	a0,1
    21aa:	431020ef          	jal	4dda <sbrk>
  c = sbrk(1);
    21ae:	4505                	li	a0,1
    21b0:	42b020ef          	jal	4dda <sbrk>
  if(c != a + 1){
    21b4:	0489                	add	s1,s1,2
    21b6:	04a48363          	beq	s1,a0,21fc <sbrkbasic+0x128>
    printf("%s: sbrk test failed post-fork\n", s);
    21ba:	85ce                	mv	a1,s3
    21bc:	00004517          	auipc	a0,0x4
    21c0:	07c50513          	add	a0,a0,124 # 6238 <malloc+0xe66>
    21c4:	15a030ef          	jal	531e <printf>
    exit(1);
    21c8:	4505                	li	a0,1
    21ca:	4e5020ef          	jal	4eae <exit>
      printf("%s: sbrk test failed %d %p %p\n", s, i, a, b);
    21ce:	872a                	mv	a4,a0
    21d0:	86a6                	mv	a3,s1
    21d2:	864a                	mv	a2,s2
    21d4:	85ce                	mv	a1,s3
    21d6:	00004517          	auipc	a0,0x4
    21da:	02250513          	add	a0,a0,34 # 61f8 <malloc+0xe26>
    21de:	140030ef          	jal	531e <printf>
      exit(1);
    21e2:	4505                	li	a0,1
    21e4:	4cb020ef          	jal	4eae <exit>
    printf("%s: sbrk test fork failed\n", s);
    21e8:	85ce                	mv	a1,s3
    21ea:	00004517          	auipc	a0,0x4
    21ee:	02e50513          	add	a0,a0,46 # 6218 <malloc+0xe46>
    21f2:	12c030ef          	jal	531e <printf>
    exit(1);
    21f6:	4505                	li	a0,1
    21f8:	4b7020ef          	jal	4eae <exit>
  if(pid == 0)
    21fc:	00091563          	bnez	s2,2206 <sbrkbasic+0x132>
    exit(0);
    2200:	4501                	li	a0,0
    2202:	4ad020ef          	jal	4eae <exit>
  wait(&xstatus);
    2206:	fcc40513          	add	a0,s0,-52
    220a:	4ad020ef          	jal	4eb6 <wait>
  exit(xstatus);
    220e:	fcc42503          	lw	a0,-52(s0)
    2212:	49d020ef          	jal	4eae <exit>

0000000000002216 <sbrkmuch>:
{
    2216:	7179                	add	sp,sp,-48
    2218:	f406                	sd	ra,40(sp)
    221a:	f022                	sd	s0,32(sp)
    221c:	ec26                	sd	s1,24(sp)
    221e:	e84a                	sd	s2,16(sp)
    2220:	e44e                	sd	s3,8(sp)
    2222:	e052                	sd	s4,0(sp)
    2224:	1800                	add	s0,sp,48
    2226:	89aa                	mv	s3,a0
  oldbrk = sbrk(0);
    2228:	4501                	li	a0,0
    222a:	3b1020ef          	jal	4dda <sbrk>
    222e:	892a                	mv	s2,a0
  a = sbrk(0);
    2230:	4501                	li	a0,0
    2232:	3a9020ef          	jal	4dda <sbrk>
    2236:	84aa                	mv	s1,a0
  p = sbrk(amt);
    2238:	06400537          	lui	a0,0x6400
    223c:	9d05                	subw	a0,a0,s1
    223e:	39d020ef          	jal	4dda <sbrk>
  if (p != a) {
    2242:	08a49763          	bne	s1,a0,22d0 <sbrkmuch+0xba>
  *lastaddr = 99;
    2246:	064007b7          	lui	a5,0x6400
    224a:	06300713          	li	a4,99
    224e:	fee78fa3          	sb	a4,-1(a5) # 63fffff <base+0x63f1347>
  a = sbrk(0);
    2252:	4501                	li	a0,0
    2254:	387020ef          	jal	4dda <sbrk>
    2258:	84aa                	mv	s1,a0
  c = sbrk(-PGSIZE);
    225a:	757d                	lui	a0,0xfffff
    225c:	37f020ef          	jal	4dda <sbrk>
  if(c == (char*)SBRK_ERROR){
    2260:	57fd                	li	a5,-1
    2262:	08f50163          	beq	a0,a5,22e4 <sbrkmuch+0xce>
  c = sbrk(0);
    2266:	4501                	li	a0,0
    2268:	373020ef          	jal	4dda <sbrk>
  if(c != a - PGSIZE){
    226c:	77fd                	lui	a5,0xfffff
    226e:	97a6                	add	a5,a5,s1
    2270:	08f51463          	bne	a0,a5,22f8 <sbrkmuch+0xe2>
  a = sbrk(0);
    2274:	4501                	li	a0,0
    2276:	365020ef          	jal	4dda <sbrk>
    227a:	84aa                	mv	s1,a0
  c = sbrk(PGSIZE);
    227c:	6505                	lui	a0,0x1
    227e:	35d020ef          	jal	4dda <sbrk>
    2282:	8a2a                	mv	s4,a0
  if(c != a || sbrk(0) != a + PGSIZE){
    2284:	08a49663          	bne	s1,a0,2310 <sbrkmuch+0xfa>
    2288:	4501                	li	a0,0
    228a:	351020ef          	jal	4dda <sbrk>
    228e:	6785                	lui	a5,0x1
    2290:	97a6                	add	a5,a5,s1
    2292:	06f51f63          	bne	a0,a5,2310 <sbrkmuch+0xfa>
  if(*lastaddr == 99){
    2296:	064007b7          	lui	a5,0x6400
    229a:	fff7c703          	lbu	a4,-1(a5) # 63fffff <base+0x63f1347>
    229e:	06300793          	li	a5,99
    22a2:	08f70363          	beq	a4,a5,2328 <sbrkmuch+0x112>
  a = sbrk(0);
    22a6:	4501                	li	a0,0
    22a8:	333020ef          	jal	4dda <sbrk>
    22ac:	84aa                	mv	s1,a0
  c = sbrk(-(sbrk(0) - oldbrk));
    22ae:	4501                	li	a0,0
    22b0:	32b020ef          	jal	4dda <sbrk>
    22b4:	40a9053b          	subw	a0,s2,a0
    22b8:	323020ef          	jal	4dda <sbrk>
  if(c != a){
    22bc:	08a49063          	bne	s1,a0,233c <sbrkmuch+0x126>
}
    22c0:	70a2                	ld	ra,40(sp)
    22c2:	7402                	ld	s0,32(sp)
    22c4:	64e2                	ld	s1,24(sp)
    22c6:	6942                	ld	s2,16(sp)
    22c8:	69a2                	ld	s3,8(sp)
    22ca:	6a02                	ld	s4,0(sp)
    22cc:	6145                	add	sp,sp,48
    22ce:	8082                	ret
    printf("%s: sbrk test failed to grow big address space; enough phys mem?\n", s);
    22d0:	85ce                	mv	a1,s3
    22d2:	00004517          	auipc	a0,0x4
    22d6:	f8650513          	add	a0,a0,-122 # 6258 <malloc+0xe86>
    22da:	044030ef          	jal	531e <printf>
    exit(1);
    22de:	4505                	li	a0,1
    22e0:	3cf020ef          	jal	4eae <exit>
    printf("%s: sbrk could not deallocate\n", s);
    22e4:	85ce                	mv	a1,s3
    22e6:	00004517          	auipc	a0,0x4
    22ea:	fba50513          	add	a0,a0,-70 # 62a0 <malloc+0xece>
    22ee:	030030ef          	jal	531e <printf>
    exit(1);
    22f2:	4505                	li	a0,1
    22f4:	3bb020ef          	jal	4eae <exit>
    printf("%s: sbrk deallocation produced wrong address, a %p c %p\n", s, a, c);
    22f8:	86aa                	mv	a3,a0
    22fa:	8626                	mv	a2,s1
    22fc:	85ce                	mv	a1,s3
    22fe:	00004517          	auipc	a0,0x4
    2302:	fc250513          	add	a0,a0,-62 # 62c0 <malloc+0xeee>
    2306:	018030ef          	jal	531e <printf>
    exit(1);
    230a:	4505                	li	a0,1
    230c:	3a3020ef          	jal	4eae <exit>
    printf("%s: sbrk re-allocation failed, a %p c %p\n", s, a, c);
    2310:	86d2                	mv	a3,s4
    2312:	8626                	mv	a2,s1
    2314:	85ce                	mv	a1,s3
    2316:	00004517          	auipc	a0,0x4
    231a:	fea50513          	add	a0,a0,-22 # 6300 <malloc+0xf2e>
    231e:	000030ef          	jal	531e <printf>
    exit(1);
    2322:	4505                	li	a0,1
    2324:	38b020ef          	jal	4eae <exit>
    printf("%s: sbrk de-allocation didn't really deallocate\n", s);
    2328:	85ce                	mv	a1,s3
    232a:	00004517          	auipc	a0,0x4
    232e:	00650513          	add	a0,a0,6 # 6330 <malloc+0xf5e>
    2332:	7ed020ef          	jal	531e <printf>
    exit(1);
    2336:	4505                	li	a0,1
    2338:	377020ef          	jal	4eae <exit>
    printf("%s: sbrk downsize failed, a %p c %p\n", s, a, c);
    233c:	86aa                	mv	a3,a0
    233e:	8626                	mv	a2,s1
    2340:	85ce                	mv	a1,s3
    2342:	00004517          	auipc	a0,0x4
    2346:	02650513          	add	a0,a0,38 # 6368 <malloc+0xf96>
    234a:	7d5020ef          	jal	531e <printf>
    exit(1);
    234e:	4505                	li	a0,1
    2350:	35f020ef          	jal	4eae <exit>

0000000000002354 <sbrkarg>:
{
    2354:	7179                	add	sp,sp,-48
    2356:	f406                	sd	ra,40(sp)
    2358:	f022                	sd	s0,32(sp)
    235a:	ec26                	sd	s1,24(sp)
    235c:	e84a                	sd	s2,16(sp)
    235e:	e44e                	sd	s3,8(sp)
    2360:	1800                	add	s0,sp,48
    2362:	89aa                	mv	s3,a0
  a = sbrk(PGSIZE);
    2364:	6505                	lui	a0,0x1
    2366:	275020ef          	jal	4dda <sbrk>
    236a:	892a                	mv	s2,a0
  fd = open("sbrk", O_CREATE|O_WRONLY);
    236c:	20100593          	li	a1,513
    2370:	00004517          	auipc	a0,0x4
    2374:	02050513          	add	a0,a0,32 # 6390 <malloc+0xfbe>
    2378:	377020ef          	jal	4eee <open>
    237c:	84aa                	mv	s1,a0
  unlink("sbrk");
    237e:	00004517          	auipc	a0,0x4
    2382:	01250513          	add	a0,a0,18 # 6390 <malloc+0xfbe>
    2386:	379020ef          	jal	4efe <unlink>
  if(fd < 0)  {
    238a:	0204c963          	bltz	s1,23bc <sbrkarg+0x68>
  if ((n = write(fd, a, PGSIZE)) < 0) {
    238e:	6605                	lui	a2,0x1
    2390:	85ca                	mv	a1,s2
    2392:	8526                	mv	a0,s1
    2394:	33b020ef          	jal	4ece <write>
    2398:	02054c63          	bltz	a0,23d0 <sbrkarg+0x7c>
  close(fd);
    239c:	8526                	mv	a0,s1
    239e:	339020ef          	jal	4ed6 <close>
  a = sbrk(PGSIZE);
    23a2:	6505                	lui	a0,0x1
    23a4:	237020ef          	jal	4dda <sbrk>
  if(pipe((int *) a) != 0){
    23a8:	317020ef          	jal	4ebe <pipe>
    23ac:	ed05                	bnez	a0,23e4 <sbrkarg+0x90>
}
    23ae:	70a2                	ld	ra,40(sp)
    23b0:	7402                	ld	s0,32(sp)
    23b2:	64e2                	ld	s1,24(sp)
    23b4:	6942                	ld	s2,16(sp)
    23b6:	69a2                	ld	s3,8(sp)
    23b8:	6145                	add	sp,sp,48
    23ba:	8082                	ret
    printf("%s: open sbrk failed\n", s);
    23bc:	85ce                	mv	a1,s3
    23be:	00004517          	auipc	a0,0x4
    23c2:	fda50513          	add	a0,a0,-38 # 6398 <malloc+0xfc6>
    23c6:	759020ef          	jal	531e <printf>
    exit(1);
    23ca:	4505                	li	a0,1
    23cc:	2e3020ef          	jal	4eae <exit>
    printf("%s: write sbrk failed\n", s);
    23d0:	85ce                	mv	a1,s3
    23d2:	00004517          	auipc	a0,0x4
    23d6:	fde50513          	add	a0,a0,-34 # 63b0 <malloc+0xfde>
    23da:	745020ef          	jal	531e <printf>
    exit(1);
    23de:	4505                	li	a0,1
    23e0:	2cf020ef          	jal	4eae <exit>
    printf("%s: pipe() failed\n", s);
    23e4:	85ce                	mv	a1,s3
    23e6:	00004517          	auipc	a0,0x4
    23ea:	aba50513          	add	a0,a0,-1350 # 5ea0 <malloc+0xace>
    23ee:	731020ef          	jal	531e <printf>
    exit(1);
    23f2:	4505                	li	a0,1
    23f4:	2bb020ef          	jal	4eae <exit>

00000000000023f8 <argptest>:
{
    23f8:	1101                	add	sp,sp,-32
    23fa:	ec06                	sd	ra,24(sp)
    23fc:	e822                	sd	s0,16(sp)
    23fe:	e426                	sd	s1,8(sp)
    2400:	e04a                	sd	s2,0(sp)
    2402:	1000                	add	s0,sp,32
    2404:	892a                	mv	s2,a0
  fd = open("init", O_RDONLY);
    2406:	4581                	li	a1,0
    2408:	00004517          	auipc	a0,0x4
    240c:	fc050513          	add	a0,a0,-64 # 63c8 <malloc+0xff6>
    2410:	2df020ef          	jal	4eee <open>
  if (fd < 0) {
    2414:	02054563          	bltz	a0,243e <argptest+0x46>
    2418:	84aa                	mv	s1,a0
  read(fd, sbrk(0) - 1, -1);
    241a:	4501                	li	a0,0
    241c:	1bf020ef          	jal	4dda <sbrk>
    2420:	567d                	li	a2,-1
    2422:	fff50593          	add	a1,a0,-1
    2426:	8526                	mv	a0,s1
    2428:	29f020ef          	jal	4ec6 <read>
  close(fd);
    242c:	8526                	mv	a0,s1
    242e:	2a9020ef          	jal	4ed6 <close>
}
    2432:	60e2                	ld	ra,24(sp)
    2434:	6442                	ld	s0,16(sp)
    2436:	64a2                	ld	s1,8(sp)
    2438:	6902                	ld	s2,0(sp)
    243a:	6105                	add	sp,sp,32
    243c:	8082                	ret
    printf("%s: open failed\n", s);
    243e:	85ca                	mv	a1,s2
    2440:	00004517          	auipc	a0,0x4
    2444:	97050513          	add	a0,a0,-1680 # 5db0 <malloc+0x9de>
    2448:	6d7020ef          	jal	531e <printf>
    exit(1);
    244c:	4505                	li	a0,1
    244e:	261020ef          	jal	4eae <exit>

0000000000002452 <sbrkbugs>:
{
    2452:	1141                	add	sp,sp,-16
    2454:	e406                	sd	ra,8(sp)
    2456:	e022                	sd	s0,0(sp)
    2458:	0800                	add	s0,sp,16
  int pid = fork();
    245a:	24d020ef          	jal	4ea6 <fork>
  if(pid < 0){
    245e:	00054c63          	bltz	a0,2476 <sbrkbugs+0x24>
  if(pid == 0){
    2462:	e11d                	bnez	a0,2488 <sbrkbugs+0x36>
    int sz = (uint64) sbrk(0);
    2464:	177020ef          	jal	4dda <sbrk>
    sbrk(-sz);
    2468:	40a0053b          	negw	a0,a0
    246c:	16f020ef          	jal	4dda <sbrk>
    exit(0);
    2470:	4501                	li	a0,0
    2472:	23d020ef          	jal	4eae <exit>
    printf("fork failed\n");
    2476:	00005517          	auipc	a0,0x5
    247a:	eca50513          	add	a0,a0,-310 # 7340 <malloc+0x1f6e>
    247e:	6a1020ef          	jal	531e <printf>
    exit(1);
    2482:	4505                	li	a0,1
    2484:	22b020ef          	jal	4eae <exit>
  wait(0);
    2488:	4501                	li	a0,0
    248a:	22d020ef          	jal	4eb6 <wait>
  pid = fork();
    248e:	219020ef          	jal	4ea6 <fork>
  if(pid < 0){
    2492:	00054f63          	bltz	a0,24b0 <sbrkbugs+0x5e>
  if(pid == 0){
    2496:	e515                	bnez	a0,24c2 <sbrkbugs+0x70>
    int sz = (uint64) sbrk(0);
    2498:	143020ef          	jal	4dda <sbrk>
    sbrk(-(sz - 3500));
    249c:	6785                	lui	a5,0x1
    249e:	dac7879b          	addw	a5,a5,-596 # dac <linktest+0x138>
    24a2:	40a7853b          	subw	a0,a5,a0
    24a6:	135020ef          	jal	4dda <sbrk>
    exit(0);
    24aa:	4501                	li	a0,0
    24ac:	203020ef          	jal	4eae <exit>
    printf("fork failed\n");
    24b0:	00005517          	auipc	a0,0x5
    24b4:	e9050513          	add	a0,a0,-368 # 7340 <malloc+0x1f6e>
    24b8:	667020ef          	jal	531e <printf>
    exit(1);
    24bc:	4505                	li	a0,1
    24be:	1f1020ef          	jal	4eae <exit>
  wait(0);
    24c2:	4501                	li	a0,0
    24c4:	1f3020ef          	jal	4eb6 <wait>
  pid = fork();
    24c8:	1df020ef          	jal	4ea6 <fork>
  if(pid < 0){
    24cc:	02054263          	bltz	a0,24f0 <sbrkbugs+0x9e>
  if(pid == 0){
    24d0:	e90d                	bnez	a0,2502 <sbrkbugs+0xb0>
    sbrk((10*PGSIZE + 2048) - (uint64)sbrk(0));
    24d2:	109020ef          	jal	4dda <sbrk>
    24d6:	67ad                	lui	a5,0xb
    24d8:	8007879b          	addw	a5,a5,-2048 # a800 <uninit+0x1258>
    24dc:	40a7853b          	subw	a0,a5,a0
    24e0:	0fb020ef          	jal	4dda <sbrk>
    sbrk(-10);
    24e4:	5559                	li	a0,-10
    24e6:	0f5020ef          	jal	4dda <sbrk>
    exit(0);
    24ea:	4501                	li	a0,0
    24ec:	1c3020ef          	jal	4eae <exit>
    printf("fork failed\n");
    24f0:	00005517          	auipc	a0,0x5
    24f4:	e5050513          	add	a0,a0,-432 # 7340 <malloc+0x1f6e>
    24f8:	627020ef          	jal	531e <printf>
    exit(1);
    24fc:	4505                	li	a0,1
    24fe:	1b1020ef          	jal	4eae <exit>
  wait(0);
    2502:	4501                	li	a0,0
    2504:	1b3020ef          	jal	4eb6 <wait>
  exit(0);
    2508:	4501                	li	a0,0
    250a:	1a5020ef          	jal	4eae <exit>

000000000000250e <sbrklast>:
{
    250e:	7179                	add	sp,sp,-48
    2510:	f406                	sd	ra,40(sp)
    2512:	f022                	sd	s0,32(sp)
    2514:	ec26                	sd	s1,24(sp)
    2516:	e84a                	sd	s2,16(sp)
    2518:	e44e                	sd	s3,8(sp)
    251a:	e052                	sd	s4,0(sp)
    251c:	1800                	add	s0,sp,48
  uint64 top = (uint64) sbrk(0);
    251e:	4501                	li	a0,0
    2520:	0bb020ef          	jal	4dda <sbrk>
  if((top % PGSIZE) != 0)
    2524:	03451793          	sll	a5,a0,0x34
    2528:	ebad                	bnez	a5,259a <sbrklast+0x8c>
  sbrk(PGSIZE);
    252a:	6505                	lui	a0,0x1
    252c:	0af020ef          	jal	4dda <sbrk>
  sbrk(10);
    2530:	4529                	li	a0,10
    2532:	0a9020ef          	jal	4dda <sbrk>
  sbrk(-20);
    2536:	5531                	li	a0,-20
    2538:	0a3020ef          	jal	4dda <sbrk>
  top = (uint64) sbrk(0);
    253c:	4501                	li	a0,0
    253e:	09d020ef          	jal	4dda <sbrk>
    2542:	84aa                	mv	s1,a0
  char *p = (char *) (top - 64);
    2544:	fc050913          	add	s2,a0,-64 # fc0 <bigdir+0x122>
  p[0] = 'x';
    2548:	07800a13          	li	s4,120
    254c:	fd450023          	sb	s4,-64(a0)
  p[1] = '\0';
    2550:	fc0500a3          	sb	zero,-63(a0)
  int fd = open(p, O_RDWR|O_CREATE);
    2554:	20200593          	li	a1,514
    2558:	854a                	mv	a0,s2
    255a:	195020ef          	jal	4eee <open>
    255e:	89aa                	mv	s3,a0
  write(fd, p, 1);
    2560:	4605                	li	a2,1
    2562:	85ca                	mv	a1,s2
    2564:	16b020ef          	jal	4ece <write>
  close(fd);
    2568:	854e                	mv	a0,s3
    256a:	16d020ef          	jal	4ed6 <close>
  fd = open(p, O_RDWR);
    256e:	4589                	li	a1,2
    2570:	854a                	mv	a0,s2
    2572:	17d020ef          	jal	4eee <open>
  p[0] = '\0';
    2576:	fc048023          	sb	zero,-64(s1)
  read(fd, p, 1);
    257a:	4605                	li	a2,1
    257c:	85ca                	mv	a1,s2
    257e:	149020ef          	jal	4ec6 <read>
  if(p[0] != 'x')
    2582:	fc04c783          	lbu	a5,-64(s1)
    2586:	03479263          	bne	a5,s4,25aa <sbrklast+0x9c>
}
    258a:	70a2                	ld	ra,40(sp)
    258c:	7402                	ld	s0,32(sp)
    258e:	64e2                	ld	s1,24(sp)
    2590:	6942                	ld	s2,16(sp)
    2592:	69a2                	ld	s3,8(sp)
    2594:	6a02                	ld	s4,0(sp)
    2596:	6145                	add	sp,sp,48
    2598:	8082                	ret
    sbrk(PGSIZE - (top % PGSIZE));
    259a:	0347d513          	srl	a0,a5,0x34
    259e:	6785                	lui	a5,0x1
    25a0:	40a7853b          	subw	a0,a5,a0
    25a4:	037020ef          	jal	4dda <sbrk>
    25a8:	b749                	j	252a <sbrklast+0x1c>
    exit(1);
    25aa:	4505                	li	a0,1
    25ac:	103020ef          	jal	4eae <exit>

00000000000025b0 <sbrk8000>:
{
    25b0:	1141                	add	sp,sp,-16
    25b2:	e406                	sd	ra,8(sp)
    25b4:	e022                	sd	s0,0(sp)
    25b6:	0800                	add	s0,sp,16
  sbrk(0x80000004);
    25b8:	80000537          	lui	a0,0x80000
    25bc:	0511                	add	a0,a0,4 # ffffffff80000004 <base+0xffffffff7fff134c>
    25be:	01d020ef          	jal	4dda <sbrk>
  volatile char *top = sbrk(0);
    25c2:	4501                	li	a0,0
    25c4:	017020ef          	jal	4dda <sbrk>
  *(top-1) = *(top-1) + 1;
    25c8:	fff54783          	lbu	a5,-1(a0)
    25cc:	2785                	addw	a5,a5,1 # 1001 <badarg+0x1>
    25ce:	0ff7f793          	zext.b	a5,a5
    25d2:	fef50fa3          	sb	a5,-1(a0)
}
    25d6:	60a2                	ld	ra,8(sp)
    25d8:	6402                	ld	s0,0(sp)
    25da:	0141                	add	sp,sp,16
    25dc:	8082                	ret

00000000000025de <execout>:
{
    25de:	715d                	add	sp,sp,-80
    25e0:	e486                	sd	ra,72(sp)
    25e2:	e0a2                	sd	s0,64(sp)
    25e4:	fc26                	sd	s1,56(sp)
    25e6:	f84a                	sd	s2,48(sp)
    25e8:	f44e                	sd	s3,40(sp)
    25ea:	f052                	sd	s4,32(sp)
    25ec:	0880                	add	s0,sp,80
  for(int avail = 0; avail < 15; avail++){
    25ee:	4901                	li	s2,0
    25f0:	49bd                	li	s3,15
    int pid = fork();
    25f2:	0b5020ef          	jal	4ea6 <fork>
    25f6:	84aa                	mv	s1,a0
    if(pid < 0){
    25f8:	00054c63          	bltz	a0,2610 <execout+0x32>
    } else if(pid == 0){
    25fc:	c11d                	beqz	a0,2622 <execout+0x44>
      wait((int*)0);
    25fe:	4501                	li	a0,0
    2600:	0b7020ef          	jal	4eb6 <wait>
  for(int avail = 0; avail < 15; avail++){
    2604:	2905                	addw	s2,s2,1
    2606:	ff3916e3          	bne	s2,s3,25f2 <execout+0x14>
  exit(0);
    260a:	4501                	li	a0,0
    260c:	0a3020ef          	jal	4eae <exit>
      printf("fork failed\n");
    2610:	00005517          	auipc	a0,0x5
    2614:	d3050513          	add	a0,a0,-720 # 7340 <malloc+0x1f6e>
    2618:	507020ef          	jal	531e <printf>
      exit(1);
    261c:	4505                	li	a0,1
    261e:	091020ef          	jal	4eae <exit>
        if(a == SBRK_ERROR)
    2622:	59fd                	li	s3,-1
        *(a + PGSIZE - 1) = 1;
    2624:	4a05                	li	s4,1
        char *a = sbrk(PGSIZE);
    2626:	6505                	lui	a0,0x1
    2628:	7b2020ef          	jal	4dda <sbrk>
        if(a == SBRK_ERROR)
    262c:	01350763          	beq	a0,s3,263a <execout+0x5c>
        *(a + PGSIZE - 1) = 1;
    2630:	6785                	lui	a5,0x1
    2632:	953e                	add	a0,a0,a5
    2634:	ff450fa3          	sb	s4,-1(a0) # fff <pgbug+0x2b>
      while(1){
    2638:	b7fd                	j	2626 <execout+0x48>
      for(int i = 0; i < avail; i++)
    263a:	01205863          	blez	s2,264a <execout+0x6c>
        sbrk(-PGSIZE);
    263e:	757d                	lui	a0,0xfffff
    2640:	79a020ef          	jal	4dda <sbrk>
      for(int i = 0; i < avail; i++)
    2644:	2485                	addw	s1,s1,1
    2646:	ff249ce3          	bne	s1,s2,263e <execout+0x60>
      close(1);
    264a:	4505                	li	a0,1
    264c:	08b020ef          	jal	4ed6 <close>
      char *args[] = { "echo", "x", 0 };
    2650:	00003517          	auipc	a0,0x3
    2654:	eb850513          	add	a0,a0,-328 # 5508 <malloc+0x136>
    2658:	faa43c23          	sd	a0,-72(s0)
    265c:	00003797          	auipc	a5,0x3
    2660:	f1c78793          	add	a5,a5,-228 # 5578 <malloc+0x1a6>
    2664:	fcf43023          	sd	a5,-64(s0)
    2668:	fc043423          	sd	zero,-56(s0)
      exec("echo", args);
    266c:	fb840593          	add	a1,s0,-72
    2670:	077020ef          	jal	4ee6 <exec>
      exit(0);
    2674:	4501                	li	a0,0
    2676:	039020ef          	jal	4eae <exit>

000000000000267a <fourteen>:
{
    267a:	1101                	add	sp,sp,-32
    267c:	ec06                	sd	ra,24(sp)
    267e:	e822                	sd	s0,16(sp)
    2680:	e426                	sd	s1,8(sp)
    2682:	1000                	add	s0,sp,32
    2684:	84aa                	mv	s1,a0
  if(mkdir("12345678901234") != 0){
    2686:	00004517          	auipc	a0,0x4
    268a:	f1a50513          	add	a0,a0,-230 # 65a0 <malloc+0x11ce>
    268e:	089020ef          	jal	4f16 <mkdir>
    2692:	e555                	bnez	a0,273e <fourteen+0xc4>
  if(mkdir("12345678901234/123456789012345") != 0){
    2694:	00004517          	auipc	a0,0x4
    2698:	d6450513          	add	a0,a0,-668 # 63f8 <malloc+0x1026>
    269c:	07b020ef          	jal	4f16 <mkdir>
    26a0:	e94d                	bnez	a0,2752 <fourteen+0xd8>
  fd = open("123456789012345/123456789012345/123456789012345", O_CREATE);
    26a2:	20000593          	li	a1,512
    26a6:	00004517          	auipc	a0,0x4
    26aa:	daa50513          	add	a0,a0,-598 # 6450 <malloc+0x107e>
    26ae:	041020ef          	jal	4eee <open>
  if(fd < 0){
    26b2:	0a054a63          	bltz	a0,2766 <fourteen+0xec>
  close(fd);
    26b6:	021020ef          	jal	4ed6 <close>
  fd = open("12345678901234/12345678901234/12345678901234", 0);
    26ba:	4581                	li	a1,0
    26bc:	00004517          	auipc	a0,0x4
    26c0:	e0c50513          	add	a0,a0,-500 # 64c8 <malloc+0x10f6>
    26c4:	02b020ef          	jal	4eee <open>
  if(fd < 0){
    26c8:	0a054963          	bltz	a0,277a <fourteen+0x100>
  close(fd);
    26cc:	00b020ef          	jal	4ed6 <close>
  if(mkdir("12345678901234/12345678901234") == 0){
    26d0:	00004517          	auipc	a0,0x4
    26d4:	e6850513          	add	a0,a0,-408 # 6538 <malloc+0x1166>
    26d8:	03f020ef          	jal	4f16 <mkdir>
    26dc:	c94d                	beqz	a0,278e <fourteen+0x114>
  if(mkdir("123456789012345/12345678901234") == 0){
    26de:	00004517          	auipc	a0,0x4
    26e2:	eb250513          	add	a0,a0,-334 # 6590 <malloc+0x11be>
    26e6:	031020ef          	jal	4f16 <mkdir>
    26ea:	cd45                	beqz	a0,27a2 <fourteen+0x128>
  unlink("123456789012345/12345678901234");
    26ec:	00004517          	auipc	a0,0x4
    26f0:	ea450513          	add	a0,a0,-348 # 6590 <malloc+0x11be>
    26f4:	00b020ef          	jal	4efe <unlink>
  unlink("12345678901234/12345678901234");
    26f8:	00004517          	auipc	a0,0x4
    26fc:	e4050513          	add	a0,a0,-448 # 6538 <malloc+0x1166>
    2700:	7fe020ef          	jal	4efe <unlink>
  unlink("12345678901234/12345678901234/12345678901234");
    2704:	00004517          	auipc	a0,0x4
    2708:	dc450513          	add	a0,a0,-572 # 64c8 <malloc+0x10f6>
    270c:	7f2020ef          	jal	4efe <unlink>
  unlink("123456789012345/123456789012345/123456789012345");
    2710:	00004517          	auipc	a0,0x4
    2714:	d4050513          	add	a0,a0,-704 # 6450 <malloc+0x107e>
    2718:	7e6020ef          	jal	4efe <unlink>
  unlink("12345678901234/123456789012345");
    271c:	00004517          	auipc	a0,0x4
    2720:	cdc50513          	add	a0,a0,-804 # 63f8 <malloc+0x1026>
    2724:	7da020ef          	jal	4efe <unlink>
  unlink("12345678901234");
    2728:	00004517          	auipc	a0,0x4
    272c:	e7850513          	add	a0,a0,-392 # 65a0 <malloc+0x11ce>
    2730:	7ce020ef          	jal	4efe <unlink>
}
    2734:	60e2                	ld	ra,24(sp)
    2736:	6442                	ld	s0,16(sp)
    2738:	64a2                	ld	s1,8(sp)
    273a:	6105                	add	sp,sp,32
    273c:	8082                	ret
    printf("%s: mkdir 12345678901234 failed\n", s);
    273e:	85a6                	mv	a1,s1
    2740:	00004517          	auipc	a0,0x4
    2744:	c9050513          	add	a0,a0,-880 # 63d0 <malloc+0xffe>
    2748:	3d7020ef          	jal	531e <printf>
    exit(1);
    274c:	4505                	li	a0,1
    274e:	760020ef          	jal	4eae <exit>
    printf("%s: mkdir 12345678901234/123456789012345 failed\n", s);
    2752:	85a6                	mv	a1,s1
    2754:	00004517          	auipc	a0,0x4
    2758:	cc450513          	add	a0,a0,-828 # 6418 <malloc+0x1046>
    275c:	3c3020ef          	jal	531e <printf>
    exit(1);
    2760:	4505                	li	a0,1
    2762:	74c020ef          	jal	4eae <exit>
    printf("%s: create 123456789012345/123456789012345/123456789012345 failed\n", s);
    2766:	85a6                	mv	a1,s1
    2768:	00004517          	auipc	a0,0x4
    276c:	d1850513          	add	a0,a0,-744 # 6480 <malloc+0x10ae>
    2770:	3af020ef          	jal	531e <printf>
    exit(1);
    2774:	4505                	li	a0,1
    2776:	738020ef          	jal	4eae <exit>
    printf("%s: open 12345678901234/12345678901234/12345678901234 failed\n", s);
    277a:	85a6                	mv	a1,s1
    277c:	00004517          	auipc	a0,0x4
    2780:	d7c50513          	add	a0,a0,-644 # 64f8 <malloc+0x1126>
    2784:	39b020ef          	jal	531e <printf>
    exit(1);
    2788:	4505                	li	a0,1
    278a:	724020ef          	jal	4eae <exit>
    printf("%s: mkdir 12345678901234/12345678901234 succeeded!\n", s);
    278e:	85a6                	mv	a1,s1
    2790:	00004517          	auipc	a0,0x4
    2794:	dc850513          	add	a0,a0,-568 # 6558 <malloc+0x1186>
    2798:	387020ef          	jal	531e <printf>
    exit(1);
    279c:	4505                	li	a0,1
    279e:	710020ef          	jal	4eae <exit>
    printf("%s: mkdir 12345678901234/123456789012345 succeeded!\n", s);
    27a2:	85a6                	mv	a1,s1
    27a4:	00004517          	auipc	a0,0x4
    27a8:	e0c50513          	add	a0,a0,-500 # 65b0 <malloc+0x11de>
    27ac:	373020ef          	jal	531e <printf>
    exit(1);
    27b0:	4505                	li	a0,1
    27b2:	6fc020ef          	jal	4eae <exit>

00000000000027b6 <diskfull>:
{
    27b6:	b8010113          	add	sp,sp,-1152
    27ba:	46113c23          	sd	ra,1144(sp)
    27be:	46813823          	sd	s0,1136(sp)
    27c2:	46913423          	sd	s1,1128(sp)
    27c6:	47213023          	sd	s2,1120(sp)
    27ca:	45313c23          	sd	s3,1112(sp)
    27ce:	45413823          	sd	s4,1104(sp)
    27d2:	45513423          	sd	s5,1096(sp)
    27d6:	45613023          	sd	s6,1088(sp)
    27da:	43713c23          	sd	s7,1080(sp)
    27de:	43813823          	sd	s8,1072(sp)
    27e2:	43913423          	sd	s9,1064(sp)
    27e6:	48010413          	add	s0,sp,1152
    27ea:	8caa                	mv	s9,a0
  unlink("diskfulldir");
    27ec:	00004517          	auipc	a0,0x4
    27f0:	dfc50513          	add	a0,a0,-516 # 65e8 <malloc+0x1216>
    27f4:	70a020ef          	jal	4efe <unlink>
    27f8:	03000993          	li	s3,48
    name[0] = 'b';
    27fc:	06200b13          	li	s6,98
    name[1] = 'i';
    2800:	06900a93          	li	s5,105
    name[2] = 'g';
    2804:	06700a13          	li	s4,103
    2808:	10c00b93          	li	s7,268
  for(fi = 0; done == 0 && '0' + fi < 0177; fi++){
    280c:	07f00c13          	li	s8,127
    2810:	aab9                	j	296e <diskfull+0x1b8>
      printf("%s: could not create file %s\n", s, name);
    2812:	b8040613          	add	a2,s0,-1152
    2816:	85e6                	mv	a1,s9
    2818:	00004517          	auipc	a0,0x4
    281c:	de050513          	add	a0,a0,-544 # 65f8 <malloc+0x1226>
    2820:	2ff020ef          	jal	531e <printf>
      break;
    2824:	a039                	j	2832 <diskfull+0x7c>
        close(fd);
    2826:	854a                	mv	a0,s2
    2828:	6ae020ef          	jal	4ed6 <close>
    close(fd);
    282c:	854a                	mv	a0,s2
    282e:	6a8020ef          	jal	4ed6 <close>
  for(int i = 0; i < nzz; i++){
    2832:	4481                	li	s1,0
    name[0] = 'z';
    2834:	07a00913          	li	s2,122
  for(int i = 0; i < nzz; i++){
    2838:	08000993          	li	s3,128
    name[0] = 'z';
    283c:	bb240023          	sb	s2,-1120(s0)
    name[1] = 'z';
    2840:	bb2400a3          	sb	s2,-1119(s0)
    name[2] = '0' + (i / 32);
    2844:	41f4d71b          	sraw	a4,s1,0x1f
    2848:	01b7571b          	srlw	a4,a4,0x1b
    284c:	009707bb          	addw	a5,a4,s1
    2850:	4057d69b          	sraw	a3,a5,0x5
    2854:	0306869b          	addw	a3,a3,48
    2858:	bad40123          	sb	a3,-1118(s0)
    name[3] = '0' + (i % 32);
    285c:	8bfd                	and	a5,a5,31
    285e:	9f99                	subw	a5,a5,a4
    2860:	0307879b          	addw	a5,a5,48
    2864:	baf401a3          	sb	a5,-1117(s0)
    name[4] = '\0';
    2868:	ba040223          	sb	zero,-1116(s0)
    unlink(name);
    286c:	ba040513          	add	a0,s0,-1120
    2870:	68e020ef          	jal	4efe <unlink>
    int fd = open(name, O_CREATE|O_RDWR|O_TRUNC);
    2874:	60200593          	li	a1,1538
    2878:	ba040513          	add	a0,s0,-1120
    287c:	672020ef          	jal	4eee <open>
    if(fd < 0)
    2880:	00054763          	bltz	a0,288e <diskfull+0xd8>
    close(fd);
    2884:	652020ef          	jal	4ed6 <close>
  for(int i = 0; i < nzz; i++){
    2888:	2485                	addw	s1,s1,1
    288a:	fb3499e3          	bne	s1,s3,283c <diskfull+0x86>
  if(mkdir("diskfulldir") == 0)
    288e:	00004517          	auipc	a0,0x4
    2892:	d5a50513          	add	a0,a0,-678 # 65e8 <malloc+0x1216>
    2896:	680020ef          	jal	4f16 <mkdir>
    289a:	12050063          	beqz	a0,29ba <diskfull+0x204>
  unlink("diskfulldir");
    289e:	00004517          	auipc	a0,0x4
    28a2:	d4a50513          	add	a0,a0,-694 # 65e8 <malloc+0x1216>
    28a6:	658020ef          	jal	4efe <unlink>
  for(int i = 0; i < nzz; i++){
    28aa:	4481                	li	s1,0
    name[0] = 'z';
    28ac:	07a00913          	li	s2,122
  for(int i = 0; i < nzz; i++){
    28b0:	08000993          	li	s3,128
    name[0] = 'z';
    28b4:	bb240023          	sb	s2,-1120(s0)
    name[1] = 'z';
    28b8:	bb2400a3          	sb	s2,-1119(s0)
    name[2] = '0' + (i / 32);
    28bc:	41f4d71b          	sraw	a4,s1,0x1f
    28c0:	01b7571b          	srlw	a4,a4,0x1b
    28c4:	009707bb          	addw	a5,a4,s1
    28c8:	4057d69b          	sraw	a3,a5,0x5
    28cc:	0306869b          	addw	a3,a3,48
    28d0:	bad40123          	sb	a3,-1118(s0)
    name[3] = '0' + (i % 32);
    28d4:	8bfd                	and	a5,a5,31
    28d6:	9f99                	subw	a5,a5,a4
    28d8:	0307879b          	addw	a5,a5,48
    28dc:	baf401a3          	sb	a5,-1117(s0)
    name[4] = '\0';
    28e0:	ba040223          	sb	zero,-1116(s0)
    unlink(name);
    28e4:	ba040513          	add	a0,s0,-1120
    28e8:	616020ef          	jal	4efe <unlink>
  for(int i = 0; i < nzz; i++){
    28ec:	2485                	addw	s1,s1,1
    28ee:	fd3493e3          	bne	s1,s3,28b4 <diskfull+0xfe>
    28f2:	03000493          	li	s1,48
    name[0] = 'b';
    28f6:	06200a93          	li	s5,98
    name[1] = 'i';
    28fa:	06900a13          	li	s4,105
    name[2] = 'g';
    28fe:	06700993          	li	s3,103
  for(int i = 0; '0' + i < 0177; i++){
    2902:	07f00913          	li	s2,127
    name[0] = 'b';
    2906:	bb540023          	sb	s5,-1120(s0)
    name[1] = 'i';
    290a:	bb4400a3          	sb	s4,-1119(s0)
    name[2] = 'g';
    290e:	bb340123          	sb	s3,-1118(s0)
    name[3] = '0' + i;
    2912:	ba9401a3          	sb	s1,-1117(s0)
    name[4] = '\0';
    2916:	ba040223          	sb	zero,-1116(s0)
    unlink(name);
    291a:	ba040513          	add	a0,s0,-1120
    291e:	5e0020ef          	jal	4efe <unlink>
  for(int i = 0; '0' + i < 0177; i++){
    2922:	2485                	addw	s1,s1,1
    2924:	0ff4f493          	zext.b	s1,s1
    2928:	fd249fe3          	bne	s1,s2,2906 <diskfull+0x150>
}
    292c:	47813083          	ld	ra,1144(sp)
    2930:	47013403          	ld	s0,1136(sp)
    2934:	46813483          	ld	s1,1128(sp)
    2938:	46013903          	ld	s2,1120(sp)
    293c:	45813983          	ld	s3,1112(sp)
    2940:	45013a03          	ld	s4,1104(sp)
    2944:	44813a83          	ld	s5,1096(sp)
    2948:	44013b03          	ld	s6,1088(sp)
    294c:	43813b83          	ld	s7,1080(sp)
    2950:	43013c03          	ld	s8,1072(sp)
    2954:	42813c83          	ld	s9,1064(sp)
    2958:	48010113          	add	sp,sp,1152
    295c:	8082                	ret
    close(fd);
    295e:	854a                	mv	a0,s2
    2960:	576020ef          	jal	4ed6 <close>
  for(fi = 0; done == 0 && '0' + fi < 0177; fi++){
    2964:	2985                	addw	s3,s3,1
    2966:	0ff9f993          	zext.b	s3,s3
    296a:	ed8984e3          	beq	s3,s8,2832 <diskfull+0x7c>
    name[0] = 'b';
    296e:	b9640023          	sb	s6,-1152(s0)
    name[1] = 'i';
    2972:	b95400a3          	sb	s5,-1151(s0)
    name[2] = 'g';
    2976:	b9440123          	sb	s4,-1150(s0)
    name[3] = '0' + fi;
    297a:	b93401a3          	sb	s3,-1149(s0)
    name[4] = '\0';
    297e:	b8040223          	sb	zero,-1148(s0)
    unlink(name);
    2982:	b8040513          	add	a0,s0,-1152
    2986:	578020ef          	jal	4efe <unlink>
    int fd = open(name, O_CREATE|O_RDWR|O_TRUNC);
    298a:	60200593          	li	a1,1538
    298e:	b8040513          	add	a0,s0,-1152
    2992:	55c020ef          	jal	4eee <open>
    2996:	892a                	mv	s2,a0
    if(fd < 0){
    2998:	e6054de3          	bltz	a0,2812 <diskfull+0x5c>
    299c:	84de                	mv	s1,s7
      if(write(fd, buf, BSIZE) != BSIZE){
    299e:	40000613          	li	a2,1024
    29a2:	ba040593          	add	a1,s0,-1120
    29a6:	854a                	mv	a0,s2
    29a8:	526020ef          	jal	4ece <write>
    29ac:	40000793          	li	a5,1024
    29b0:	e6f51be3          	bne	a0,a5,2826 <diskfull+0x70>
    for(int i = 0; i < MAXFILE; i++){
    29b4:	34fd                	addw	s1,s1,-1
    29b6:	f4e5                	bnez	s1,299e <diskfull+0x1e8>
    29b8:	b75d                	j	295e <diskfull+0x1a8>
    printf("%s: mkdir(diskfulldir) unexpectedly succeeded!\n", s);
    29ba:	85e6                	mv	a1,s9
    29bc:	00004517          	auipc	a0,0x4
    29c0:	c5c50513          	add	a0,a0,-932 # 6618 <malloc+0x1246>
    29c4:	15b020ef          	jal	531e <printf>
    29c8:	bdd9                	j	289e <diskfull+0xe8>

00000000000029ca <iputtest>:
{
    29ca:	1101                	add	sp,sp,-32
    29cc:	ec06                	sd	ra,24(sp)
    29ce:	e822                	sd	s0,16(sp)
    29d0:	e426                	sd	s1,8(sp)
    29d2:	1000                	add	s0,sp,32
    29d4:	84aa                	mv	s1,a0
  if(mkdir("iputdir") < 0){
    29d6:	00004517          	auipc	a0,0x4
    29da:	c7250513          	add	a0,a0,-910 # 6648 <malloc+0x1276>
    29de:	538020ef          	jal	4f16 <mkdir>
    29e2:	02054f63          	bltz	a0,2a20 <iputtest+0x56>
  if(chdir("iputdir") < 0){
    29e6:	00004517          	auipc	a0,0x4
    29ea:	c6250513          	add	a0,a0,-926 # 6648 <malloc+0x1276>
    29ee:	530020ef          	jal	4f1e <chdir>
    29f2:	04054163          	bltz	a0,2a34 <iputtest+0x6a>
  if(unlink("../iputdir") < 0){
    29f6:	00004517          	auipc	a0,0x4
    29fa:	c9250513          	add	a0,a0,-878 # 6688 <malloc+0x12b6>
    29fe:	500020ef          	jal	4efe <unlink>
    2a02:	04054363          	bltz	a0,2a48 <iputtest+0x7e>
  if(chdir("/") < 0){
    2a06:	00004517          	auipc	a0,0x4
    2a0a:	cb250513          	add	a0,a0,-846 # 66b8 <malloc+0x12e6>
    2a0e:	510020ef          	jal	4f1e <chdir>
    2a12:	04054563          	bltz	a0,2a5c <iputtest+0x92>
}
    2a16:	60e2                	ld	ra,24(sp)
    2a18:	6442                	ld	s0,16(sp)
    2a1a:	64a2                	ld	s1,8(sp)
    2a1c:	6105                	add	sp,sp,32
    2a1e:	8082                	ret
    printf("%s: mkdir failed\n", s);
    2a20:	85a6                	mv	a1,s1
    2a22:	00004517          	auipc	a0,0x4
    2a26:	c2e50513          	add	a0,a0,-978 # 6650 <malloc+0x127e>
    2a2a:	0f5020ef          	jal	531e <printf>
    exit(1);
    2a2e:	4505                	li	a0,1
    2a30:	47e020ef          	jal	4eae <exit>
    printf("%s: chdir iputdir failed\n", s);
    2a34:	85a6                	mv	a1,s1
    2a36:	00004517          	auipc	a0,0x4
    2a3a:	c3250513          	add	a0,a0,-974 # 6668 <malloc+0x1296>
    2a3e:	0e1020ef          	jal	531e <printf>
    exit(1);
    2a42:	4505                	li	a0,1
    2a44:	46a020ef          	jal	4eae <exit>
    printf("%s: unlink ../iputdir failed\n", s);
    2a48:	85a6                	mv	a1,s1
    2a4a:	00004517          	auipc	a0,0x4
    2a4e:	c4e50513          	add	a0,a0,-946 # 6698 <malloc+0x12c6>
    2a52:	0cd020ef          	jal	531e <printf>
    exit(1);
    2a56:	4505                	li	a0,1
    2a58:	456020ef          	jal	4eae <exit>
    printf("%s: chdir / failed\n", s);
    2a5c:	85a6                	mv	a1,s1
    2a5e:	00004517          	auipc	a0,0x4
    2a62:	c6250513          	add	a0,a0,-926 # 66c0 <malloc+0x12ee>
    2a66:	0b9020ef          	jal	531e <printf>
    exit(1);
    2a6a:	4505                	li	a0,1
    2a6c:	442020ef          	jal	4eae <exit>

0000000000002a70 <exitiputtest>:
{
    2a70:	7179                	add	sp,sp,-48
    2a72:	f406                	sd	ra,40(sp)
    2a74:	f022                	sd	s0,32(sp)
    2a76:	ec26                	sd	s1,24(sp)
    2a78:	1800                	add	s0,sp,48
    2a7a:	84aa                	mv	s1,a0
  pid = fork();
    2a7c:	42a020ef          	jal	4ea6 <fork>
  if(pid < 0){
    2a80:	02054e63          	bltz	a0,2abc <exitiputtest+0x4c>
  if(pid == 0){
    2a84:	e541                	bnez	a0,2b0c <exitiputtest+0x9c>
    if(mkdir("iputdir") < 0){
    2a86:	00004517          	auipc	a0,0x4
    2a8a:	bc250513          	add	a0,a0,-1086 # 6648 <malloc+0x1276>
    2a8e:	488020ef          	jal	4f16 <mkdir>
    2a92:	02054f63          	bltz	a0,2ad0 <exitiputtest+0x60>
    if(chdir("iputdir") < 0){
    2a96:	00004517          	auipc	a0,0x4
    2a9a:	bb250513          	add	a0,a0,-1102 # 6648 <malloc+0x1276>
    2a9e:	480020ef          	jal	4f1e <chdir>
    2aa2:	04054163          	bltz	a0,2ae4 <exitiputtest+0x74>
    if(unlink("../iputdir") < 0){
    2aa6:	00004517          	auipc	a0,0x4
    2aaa:	be250513          	add	a0,a0,-1054 # 6688 <malloc+0x12b6>
    2aae:	450020ef          	jal	4efe <unlink>
    2ab2:	04054363          	bltz	a0,2af8 <exitiputtest+0x88>
    exit(0);
    2ab6:	4501                	li	a0,0
    2ab8:	3f6020ef          	jal	4eae <exit>
    printf("%s: fork failed\n", s);
    2abc:	85a6                	mv	a1,s1
    2abe:	00003517          	auipc	a0,0x3
    2ac2:	2da50513          	add	a0,a0,730 # 5d98 <malloc+0x9c6>
    2ac6:	059020ef          	jal	531e <printf>
    exit(1);
    2aca:	4505                	li	a0,1
    2acc:	3e2020ef          	jal	4eae <exit>
      printf("%s: mkdir failed\n", s);
    2ad0:	85a6                	mv	a1,s1
    2ad2:	00004517          	auipc	a0,0x4
    2ad6:	b7e50513          	add	a0,a0,-1154 # 6650 <malloc+0x127e>
    2ada:	045020ef          	jal	531e <printf>
      exit(1);
    2ade:	4505                	li	a0,1
    2ae0:	3ce020ef          	jal	4eae <exit>
      printf("%s: child chdir failed\n", s);
    2ae4:	85a6                	mv	a1,s1
    2ae6:	00004517          	auipc	a0,0x4
    2aea:	bf250513          	add	a0,a0,-1038 # 66d8 <malloc+0x1306>
    2aee:	031020ef          	jal	531e <printf>
      exit(1);
    2af2:	4505                	li	a0,1
    2af4:	3ba020ef          	jal	4eae <exit>
      printf("%s: unlink ../iputdir failed\n", s);
    2af8:	85a6                	mv	a1,s1
    2afa:	00004517          	auipc	a0,0x4
    2afe:	b9e50513          	add	a0,a0,-1122 # 6698 <malloc+0x12c6>
    2b02:	01d020ef          	jal	531e <printf>
      exit(1);
    2b06:	4505                	li	a0,1
    2b08:	3a6020ef          	jal	4eae <exit>
  wait(&xstatus);
    2b0c:	fdc40513          	add	a0,s0,-36
    2b10:	3a6020ef          	jal	4eb6 <wait>
  exit(xstatus);
    2b14:	fdc42503          	lw	a0,-36(s0)
    2b18:	396020ef          	jal	4eae <exit>

0000000000002b1c <dirtest>:
{
    2b1c:	1101                	add	sp,sp,-32
    2b1e:	ec06                	sd	ra,24(sp)
    2b20:	e822                	sd	s0,16(sp)
    2b22:	e426                	sd	s1,8(sp)
    2b24:	1000                	add	s0,sp,32
    2b26:	84aa                	mv	s1,a0
  if(mkdir("dir0") < 0){
    2b28:	00004517          	auipc	a0,0x4
    2b2c:	bc850513          	add	a0,a0,-1080 # 66f0 <malloc+0x131e>
    2b30:	3e6020ef          	jal	4f16 <mkdir>
    2b34:	02054f63          	bltz	a0,2b72 <dirtest+0x56>
  if(chdir("dir0") < 0){
    2b38:	00004517          	auipc	a0,0x4
    2b3c:	bb850513          	add	a0,a0,-1096 # 66f0 <malloc+0x131e>
    2b40:	3de020ef          	jal	4f1e <chdir>
    2b44:	04054163          	bltz	a0,2b86 <dirtest+0x6a>
  if(chdir("..") < 0){
    2b48:	00004517          	auipc	a0,0x4
    2b4c:	bc850513          	add	a0,a0,-1080 # 6710 <malloc+0x133e>
    2b50:	3ce020ef          	jal	4f1e <chdir>
    2b54:	04054363          	bltz	a0,2b9a <dirtest+0x7e>
  if(unlink("dir0") < 0){
    2b58:	00004517          	auipc	a0,0x4
    2b5c:	b9850513          	add	a0,a0,-1128 # 66f0 <malloc+0x131e>
    2b60:	39e020ef          	jal	4efe <unlink>
    2b64:	04054563          	bltz	a0,2bae <dirtest+0x92>
}
    2b68:	60e2                	ld	ra,24(sp)
    2b6a:	6442                	ld	s0,16(sp)
    2b6c:	64a2                	ld	s1,8(sp)
    2b6e:	6105                	add	sp,sp,32
    2b70:	8082                	ret
    printf("%s: mkdir failed\n", s);
    2b72:	85a6                	mv	a1,s1
    2b74:	00004517          	auipc	a0,0x4
    2b78:	adc50513          	add	a0,a0,-1316 # 6650 <malloc+0x127e>
    2b7c:	7a2020ef          	jal	531e <printf>
    exit(1);
    2b80:	4505                	li	a0,1
    2b82:	32c020ef          	jal	4eae <exit>
    printf("%s: chdir dir0 failed\n", s);
    2b86:	85a6                	mv	a1,s1
    2b88:	00004517          	auipc	a0,0x4
    2b8c:	b7050513          	add	a0,a0,-1168 # 66f8 <malloc+0x1326>
    2b90:	78e020ef          	jal	531e <printf>
    exit(1);
    2b94:	4505                	li	a0,1
    2b96:	318020ef          	jal	4eae <exit>
    printf("%s: chdir .. failed\n", s);
    2b9a:	85a6                	mv	a1,s1
    2b9c:	00004517          	auipc	a0,0x4
    2ba0:	b7c50513          	add	a0,a0,-1156 # 6718 <malloc+0x1346>
    2ba4:	77a020ef          	jal	531e <printf>
    exit(1);
    2ba8:	4505                	li	a0,1
    2baa:	304020ef          	jal	4eae <exit>
    printf("%s: unlink dir0 failed\n", s);
    2bae:	85a6                	mv	a1,s1
    2bb0:	00004517          	auipc	a0,0x4
    2bb4:	b8050513          	add	a0,a0,-1152 # 6730 <malloc+0x135e>
    2bb8:	766020ef          	jal	531e <printf>
    exit(1);
    2bbc:	4505                	li	a0,1
    2bbe:	2f0020ef          	jal	4eae <exit>

0000000000002bc2 <subdir>:
{
    2bc2:	1101                	add	sp,sp,-32
    2bc4:	ec06                	sd	ra,24(sp)
    2bc6:	e822                	sd	s0,16(sp)
    2bc8:	e426                	sd	s1,8(sp)
    2bca:	e04a                	sd	s2,0(sp)
    2bcc:	1000                	add	s0,sp,32
    2bce:	892a                	mv	s2,a0
  unlink("ff");
    2bd0:	00004517          	auipc	a0,0x4
    2bd4:	ca850513          	add	a0,a0,-856 # 6878 <malloc+0x14a6>
    2bd8:	326020ef          	jal	4efe <unlink>
  if(mkdir("dd") != 0){
    2bdc:	00004517          	auipc	a0,0x4
    2be0:	b6c50513          	add	a0,a0,-1172 # 6748 <malloc+0x1376>
    2be4:	332020ef          	jal	4f16 <mkdir>
    2be8:	2e051263          	bnez	a0,2ecc <subdir+0x30a>
  fd = open("dd/ff", O_CREATE | O_RDWR);
    2bec:	20200593          	li	a1,514
    2bf0:	00004517          	auipc	a0,0x4
    2bf4:	b7850513          	add	a0,a0,-1160 # 6768 <malloc+0x1396>
    2bf8:	2f6020ef          	jal	4eee <open>
    2bfc:	84aa                	mv	s1,a0
  if(fd < 0){
    2bfe:	2e054163          	bltz	a0,2ee0 <subdir+0x31e>
  write(fd, "ff", 2);
    2c02:	4609                	li	a2,2
    2c04:	00004597          	auipc	a1,0x4
    2c08:	c7458593          	add	a1,a1,-908 # 6878 <malloc+0x14a6>
    2c0c:	2c2020ef          	jal	4ece <write>
  close(fd);
    2c10:	8526                	mv	a0,s1
    2c12:	2c4020ef          	jal	4ed6 <close>
  if(unlink("dd") >= 0){
    2c16:	00004517          	auipc	a0,0x4
    2c1a:	b3250513          	add	a0,a0,-1230 # 6748 <malloc+0x1376>
    2c1e:	2e0020ef          	jal	4efe <unlink>
    2c22:	2c055963          	bgez	a0,2ef4 <subdir+0x332>
  if(mkdir("/dd/dd") != 0){
    2c26:	00004517          	auipc	a0,0x4
    2c2a:	b9a50513          	add	a0,a0,-1126 # 67c0 <malloc+0x13ee>
    2c2e:	2e8020ef          	jal	4f16 <mkdir>
    2c32:	2c051b63          	bnez	a0,2f08 <subdir+0x346>
  fd = open("dd/dd/ff", O_CREATE | O_RDWR);
    2c36:	20200593          	li	a1,514
    2c3a:	00004517          	auipc	a0,0x4
    2c3e:	bae50513          	add	a0,a0,-1106 # 67e8 <malloc+0x1416>
    2c42:	2ac020ef          	jal	4eee <open>
    2c46:	84aa                	mv	s1,a0
  if(fd < 0){
    2c48:	2c054a63          	bltz	a0,2f1c <subdir+0x35a>
  write(fd, "FF", 2);
    2c4c:	4609                	li	a2,2
    2c4e:	00004597          	auipc	a1,0x4
    2c52:	bca58593          	add	a1,a1,-1078 # 6818 <malloc+0x1446>
    2c56:	278020ef          	jal	4ece <write>
  close(fd);
    2c5a:	8526                	mv	a0,s1
    2c5c:	27a020ef          	jal	4ed6 <close>
  fd = open("dd/dd/../ff", 0);
    2c60:	4581                	li	a1,0
    2c62:	00004517          	auipc	a0,0x4
    2c66:	bbe50513          	add	a0,a0,-1090 # 6820 <malloc+0x144e>
    2c6a:	284020ef          	jal	4eee <open>
    2c6e:	84aa                	mv	s1,a0
  if(fd < 0){
    2c70:	2c054063          	bltz	a0,2f30 <subdir+0x36e>
  cc = read(fd, buf, sizeof(buf));
    2c74:	660d                	lui	a2,0x3
    2c76:	00009597          	auipc	a1,0x9
    2c7a:	04258593          	add	a1,a1,66 # bcb8 <buf>
    2c7e:	248020ef          	jal	4ec6 <read>
  if(cc != 2 || buf[0] != 'f'){
    2c82:	4789                	li	a5,2
    2c84:	2cf51063          	bne	a0,a5,2f44 <subdir+0x382>
    2c88:	00009717          	auipc	a4,0x9
    2c8c:	03074703          	lbu	a4,48(a4) # bcb8 <buf>
    2c90:	06600793          	li	a5,102
    2c94:	2af71863          	bne	a4,a5,2f44 <subdir+0x382>
  close(fd);
    2c98:	8526                	mv	a0,s1
    2c9a:	23c020ef          	jal	4ed6 <close>
  if(link("dd/dd/ff", "dd/dd/ffff") != 0){
    2c9e:	00004597          	auipc	a1,0x4
    2ca2:	bd258593          	add	a1,a1,-1070 # 6870 <malloc+0x149e>
    2ca6:	00004517          	auipc	a0,0x4
    2caa:	b4250513          	add	a0,a0,-1214 # 67e8 <malloc+0x1416>
    2cae:	260020ef          	jal	4f0e <link>
    2cb2:	2a051363          	bnez	a0,2f58 <subdir+0x396>
  if(unlink("dd/dd/ff") != 0){
    2cb6:	00004517          	auipc	a0,0x4
    2cba:	b3250513          	add	a0,a0,-1230 # 67e8 <malloc+0x1416>
    2cbe:	240020ef          	jal	4efe <unlink>
    2cc2:	2a051563          	bnez	a0,2f6c <subdir+0x3aa>
  if(open("dd/dd/ff", O_RDONLY) >= 0){
    2cc6:	4581                	li	a1,0
    2cc8:	00004517          	auipc	a0,0x4
    2ccc:	b2050513          	add	a0,a0,-1248 # 67e8 <malloc+0x1416>
    2cd0:	21e020ef          	jal	4eee <open>
    2cd4:	2a055663          	bgez	a0,2f80 <subdir+0x3be>
  if(chdir("dd") != 0){
    2cd8:	00004517          	auipc	a0,0x4
    2cdc:	a7050513          	add	a0,a0,-1424 # 6748 <malloc+0x1376>
    2ce0:	23e020ef          	jal	4f1e <chdir>
    2ce4:	2a051863          	bnez	a0,2f94 <subdir+0x3d2>
  if(chdir("dd/../../dd") != 0){
    2ce8:	00004517          	auipc	a0,0x4
    2cec:	c2050513          	add	a0,a0,-992 # 6908 <malloc+0x1536>
    2cf0:	22e020ef          	jal	4f1e <chdir>
    2cf4:	2a051a63          	bnez	a0,2fa8 <subdir+0x3e6>
  if(chdir("dd/../../../dd") != 0){
    2cf8:	00004517          	auipc	a0,0x4
    2cfc:	c4050513          	add	a0,a0,-960 # 6938 <malloc+0x1566>
    2d00:	21e020ef          	jal	4f1e <chdir>
    2d04:	2a051c63          	bnez	a0,2fbc <subdir+0x3fa>
  if(chdir("./..") != 0){
    2d08:	00004517          	auipc	a0,0x4
    2d0c:	c6850513          	add	a0,a0,-920 # 6970 <malloc+0x159e>
    2d10:	20e020ef          	jal	4f1e <chdir>
    2d14:	2a051e63          	bnez	a0,2fd0 <subdir+0x40e>
  fd = open("dd/dd/ffff", 0);
    2d18:	4581                	li	a1,0
    2d1a:	00004517          	auipc	a0,0x4
    2d1e:	b5650513          	add	a0,a0,-1194 # 6870 <malloc+0x149e>
    2d22:	1cc020ef          	jal	4eee <open>
    2d26:	84aa                	mv	s1,a0
  if(fd < 0){
    2d28:	2a054e63          	bltz	a0,2fe4 <subdir+0x422>
  if(read(fd, buf, sizeof(buf)) != 2){
    2d2c:	660d                	lui	a2,0x3
    2d2e:	00009597          	auipc	a1,0x9
    2d32:	f8a58593          	add	a1,a1,-118 # bcb8 <buf>
    2d36:	190020ef          	jal	4ec6 <read>
    2d3a:	4789                	li	a5,2
    2d3c:	2af51e63          	bne	a0,a5,2ff8 <subdir+0x436>
  close(fd);
    2d40:	8526                	mv	a0,s1
    2d42:	194020ef          	jal	4ed6 <close>
  if(open("dd/dd/ff", O_RDONLY) >= 0){
    2d46:	4581                	li	a1,0
    2d48:	00004517          	auipc	a0,0x4
    2d4c:	aa050513          	add	a0,a0,-1376 # 67e8 <malloc+0x1416>
    2d50:	19e020ef          	jal	4eee <open>
    2d54:	2a055c63          	bgez	a0,300c <subdir+0x44a>
  if(open("dd/ff/ff", O_CREATE|O_RDWR) >= 0){
    2d58:	20200593          	li	a1,514
    2d5c:	00004517          	auipc	a0,0x4
    2d60:	ca450513          	add	a0,a0,-860 # 6a00 <malloc+0x162e>
    2d64:	18a020ef          	jal	4eee <open>
    2d68:	2a055c63          	bgez	a0,3020 <subdir+0x45e>
  if(open("dd/xx/ff", O_CREATE|O_RDWR) >= 0){
    2d6c:	20200593          	li	a1,514
    2d70:	00004517          	auipc	a0,0x4
    2d74:	cc050513          	add	a0,a0,-832 # 6a30 <malloc+0x165e>
    2d78:	176020ef          	jal	4eee <open>
    2d7c:	2a055c63          	bgez	a0,3034 <subdir+0x472>
  if(open("dd", O_CREATE) >= 0){
    2d80:	20000593          	li	a1,512
    2d84:	00004517          	auipc	a0,0x4
    2d88:	9c450513          	add	a0,a0,-1596 # 6748 <malloc+0x1376>
    2d8c:	162020ef          	jal	4eee <open>
    2d90:	2a055c63          	bgez	a0,3048 <subdir+0x486>
  if(open("dd", O_RDWR) >= 0){
    2d94:	4589                	li	a1,2
    2d96:	00004517          	auipc	a0,0x4
    2d9a:	9b250513          	add	a0,a0,-1614 # 6748 <malloc+0x1376>
    2d9e:	150020ef          	jal	4eee <open>
    2da2:	2a055d63          	bgez	a0,305c <subdir+0x49a>
  if(open("dd", O_WRONLY) >= 0){
    2da6:	4585                	li	a1,1
    2da8:	00004517          	auipc	a0,0x4
    2dac:	9a050513          	add	a0,a0,-1632 # 6748 <malloc+0x1376>
    2db0:	13e020ef          	jal	4eee <open>
    2db4:	2a055e63          	bgez	a0,3070 <subdir+0x4ae>
  if(link("dd/ff/ff", "dd/dd/xx") == 0){
    2db8:	00004597          	auipc	a1,0x4
    2dbc:	d0858593          	add	a1,a1,-760 # 6ac0 <malloc+0x16ee>
    2dc0:	00004517          	auipc	a0,0x4
    2dc4:	c4050513          	add	a0,a0,-960 # 6a00 <malloc+0x162e>
    2dc8:	146020ef          	jal	4f0e <link>
    2dcc:	2a050c63          	beqz	a0,3084 <subdir+0x4c2>
  if(link("dd/xx/ff", "dd/dd/xx") == 0){
    2dd0:	00004597          	auipc	a1,0x4
    2dd4:	cf058593          	add	a1,a1,-784 # 6ac0 <malloc+0x16ee>
    2dd8:	00004517          	auipc	a0,0x4
    2ddc:	c5850513          	add	a0,a0,-936 # 6a30 <malloc+0x165e>
    2de0:	12e020ef          	jal	4f0e <link>
    2de4:	2a050a63          	beqz	a0,3098 <subdir+0x4d6>
  if(link("dd/ff", "dd/dd/ffff") == 0){
    2de8:	00004597          	auipc	a1,0x4
    2dec:	a8858593          	add	a1,a1,-1400 # 6870 <malloc+0x149e>
    2df0:	00004517          	auipc	a0,0x4
    2df4:	97850513          	add	a0,a0,-1672 # 6768 <malloc+0x1396>
    2df8:	116020ef          	jal	4f0e <link>
    2dfc:	2a050863          	beqz	a0,30ac <subdir+0x4ea>
  if(mkdir("dd/ff/ff") == 0){
    2e00:	00004517          	auipc	a0,0x4
    2e04:	c0050513          	add	a0,a0,-1024 # 6a00 <malloc+0x162e>
    2e08:	10e020ef          	jal	4f16 <mkdir>
    2e0c:	2a050a63          	beqz	a0,30c0 <subdir+0x4fe>
  if(mkdir("dd/xx/ff") == 0){
    2e10:	00004517          	auipc	a0,0x4
    2e14:	c2050513          	add	a0,a0,-992 # 6a30 <malloc+0x165e>
    2e18:	0fe020ef          	jal	4f16 <mkdir>
    2e1c:	2a050c63          	beqz	a0,30d4 <subdir+0x512>
  if(mkdir("dd/dd/ffff") == 0){
    2e20:	00004517          	auipc	a0,0x4
    2e24:	a5050513          	add	a0,a0,-1456 # 6870 <malloc+0x149e>
    2e28:	0ee020ef          	jal	4f16 <mkdir>
    2e2c:	2a050e63          	beqz	a0,30e8 <subdir+0x526>
  if(unlink("dd/xx/ff") == 0){
    2e30:	00004517          	auipc	a0,0x4
    2e34:	c0050513          	add	a0,a0,-1024 # 6a30 <malloc+0x165e>
    2e38:	0c6020ef          	jal	4efe <unlink>
    2e3c:	2c050063          	beqz	a0,30fc <subdir+0x53a>
  if(unlink("dd/ff/ff") == 0){
    2e40:	00004517          	auipc	a0,0x4
    2e44:	bc050513          	add	a0,a0,-1088 # 6a00 <malloc+0x162e>
    2e48:	0b6020ef          	jal	4efe <unlink>
    2e4c:	2c050263          	beqz	a0,3110 <subdir+0x54e>
  if(chdir("dd/ff") == 0){
    2e50:	00004517          	auipc	a0,0x4
    2e54:	91850513          	add	a0,a0,-1768 # 6768 <malloc+0x1396>
    2e58:	0c6020ef          	jal	4f1e <chdir>
    2e5c:	2c050463          	beqz	a0,3124 <subdir+0x562>
  if(chdir("dd/xx") == 0){
    2e60:	00004517          	auipc	a0,0x4
    2e64:	db050513          	add	a0,a0,-592 # 6c10 <malloc+0x183e>
    2e68:	0b6020ef          	jal	4f1e <chdir>
    2e6c:	2c050663          	beqz	a0,3138 <subdir+0x576>
  if(unlink("dd/dd/ffff") != 0){
    2e70:	00004517          	auipc	a0,0x4
    2e74:	a0050513          	add	a0,a0,-1536 # 6870 <malloc+0x149e>
    2e78:	086020ef          	jal	4efe <unlink>
    2e7c:	2c051863          	bnez	a0,314c <subdir+0x58a>
  if(unlink("dd/ff") != 0){
    2e80:	00004517          	auipc	a0,0x4
    2e84:	8e850513          	add	a0,a0,-1816 # 6768 <malloc+0x1396>
    2e88:	076020ef          	jal	4efe <unlink>
    2e8c:	2c051a63          	bnez	a0,3160 <subdir+0x59e>
  if(unlink("dd") == 0){
    2e90:	00004517          	auipc	a0,0x4
    2e94:	8b850513          	add	a0,a0,-1864 # 6748 <malloc+0x1376>
    2e98:	066020ef          	jal	4efe <unlink>
    2e9c:	2c050c63          	beqz	a0,3174 <subdir+0x5b2>
  if(unlink("dd/dd") < 0){
    2ea0:	00004517          	auipc	a0,0x4
    2ea4:	de050513          	add	a0,a0,-544 # 6c80 <malloc+0x18ae>
    2ea8:	056020ef          	jal	4efe <unlink>
    2eac:	2c054e63          	bltz	a0,3188 <subdir+0x5c6>
  if(unlink("dd") < 0){
    2eb0:	00004517          	auipc	a0,0x4
    2eb4:	89850513          	add	a0,a0,-1896 # 6748 <malloc+0x1376>
    2eb8:	046020ef          	jal	4efe <unlink>
    2ebc:	2e054063          	bltz	a0,319c <subdir+0x5da>
}
    2ec0:	60e2                	ld	ra,24(sp)
    2ec2:	6442                	ld	s0,16(sp)
    2ec4:	64a2                	ld	s1,8(sp)
    2ec6:	6902                	ld	s2,0(sp)
    2ec8:	6105                	add	sp,sp,32
    2eca:	8082                	ret
    printf("%s: mkdir dd failed\n", s);
    2ecc:	85ca                	mv	a1,s2
    2ece:	00004517          	auipc	a0,0x4
    2ed2:	88250513          	add	a0,a0,-1918 # 6750 <malloc+0x137e>
    2ed6:	448020ef          	jal	531e <printf>
    exit(1);
    2eda:	4505                	li	a0,1
    2edc:	7d3010ef          	jal	4eae <exit>
    printf("%s: create dd/ff failed\n", s);
    2ee0:	85ca                	mv	a1,s2
    2ee2:	00004517          	auipc	a0,0x4
    2ee6:	88e50513          	add	a0,a0,-1906 # 6770 <malloc+0x139e>
    2eea:	434020ef          	jal	531e <printf>
    exit(1);
    2eee:	4505                	li	a0,1
    2ef0:	7bf010ef          	jal	4eae <exit>
    printf("%s: unlink dd (non-empty dir) succeeded!\n", s);
    2ef4:	85ca                	mv	a1,s2
    2ef6:	00004517          	auipc	a0,0x4
    2efa:	89a50513          	add	a0,a0,-1894 # 6790 <malloc+0x13be>
    2efe:	420020ef          	jal	531e <printf>
    exit(1);
    2f02:	4505                	li	a0,1
    2f04:	7ab010ef          	jal	4eae <exit>
    printf("%s: subdir mkdir dd/dd failed\n", s);
    2f08:	85ca                	mv	a1,s2
    2f0a:	00004517          	auipc	a0,0x4
    2f0e:	8be50513          	add	a0,a0,-1858 # 67c8 <malloc+0x13f6>
    2f12:	40c020ef          	jal	531e <printf>
    exit(1);
    2f16:	4505                	li	a0,1
    2f18:	797010ef          	jal	4eae <exit>
    printf("%s: create dd/dd/ff failed\n", s);
    2f1c:	85ca                	mv	a1,s2
    2f1e:	00004517          	auipc	a0,0x4
    2f22:	8da50513          	add	a0,a0,-1830 # 67f8 <malloc+0x1426>
    2f26:	3f8020ef          	jal	531e <printf>
    exit(1);
    2f2a:	4505                	li	a0,1
    2f2c:	783010ef          	jal	4eae <exit>
    printf("%s: open dd/dd/../ff failed\n", s);
    2f30:	85ca                	mv	a1,s2
    2f32:	00004517          	auipc	a0,0x4
    2f36:	8fe50513          	add	a0,a0,-1794 # 6830 <malloc+0x145e>
    2f3a:	3e4020ef          	jal	531e <printf>
    exit(1);
    2f3e:	4505                	li	a0,1
    2f40:	76f010ef          	jal	4eae <exit>
    printf("%s: dd/dd/../ff wrong content\n", s);
    2f44:	85ca                	mv	a1,s2
    2f46:	00004517          	auipc	a0,0x4
    2f4a:	90a50513          	add	a0,a0,-1782 # 6850 <malloc+0x147e>
    2f4e:	3d0020ef          	jal	531e <printf>
    exit(1);
    2f52:	4505                	li	a0,1
    2f54:	75b010ef          	jal	4eae <exit>
    printf("%s: link dd/dd/ff dd/dd/ffff failed\n", s);
    2f58:	85ca                	mv	a1,s2
    2f5a:	00004517          	auipc	a0,0x4
    2f5e:	92650513          	add	a0,a0,-1754 # 6880 <malloc+0x14ae>
    2f62:	3bc020ef          	jal	531e <printf>
    exit(1);
    2f66:	4505                	li	a0,1
    2f68:	747010ef          	jal	4eae <exit>
    printf("%s: unlink dd/dd/ff failed\n", s);
    2f6c:	85ca                	mv	a1,s2
    2f6e:	00004517          	auipc	a0,0x4
    2f72:	93a50513          	add	a0,a0,-1734 # 68a8 <malloc+0x14d6>
    2f76:	3a8020ef          	jal	531e <printf>
    exit(1);
    2f7a:	4505                	li	a0,1
    2f7c:	733010ef          	jal	4eae <exit>
    printf("%s: open (unlinked) dd/dd/ff succeeded\n", s);
    2f80:	85ca                	mv	a1,s2
    2f82:	00004517          	auipc	a0,0x4
    2f86:	94650513          	add	a0,a0,-1722 # 68c8 <malloc+0x14f6>
    2f8a:	394020ef          	jal	531e <printf>
    exit(1);
    2f8e:	4505                	li	a0,1
    2f90:	71f010ef          	jal	4eae <exit>
    printf("%s: chdir dd failed\n", s);
    2f94:	85ca                	mv	a1,s2
    2f96:	00004517          	auipc	a0,0x4
    2f9a:	95a50513          	add	a0,a0,-1702 # 68f0 <malloc+0x151e>
    2f9e:	380020ef          	jal	531e <printf>
    exit(1);
    2fa2:	4505                	li	a0,1
    2fa4:	70b010ef          	jal	4eae <exit>
    printf("%s: chdir dd/../../dd failed\n", s);
    2fa8:	85ca                	mv	a1,s2
    2faa:	00004517          	auipc	a0,0x4
    2fae:	96e50513          	add	a0,a0,-1682 # 6918 <malloc+0x1546>
    2fb2:	36c020ef          	jal	531e <printf>
    exit(1);
    2fb6:	4505                	li	a0,1
    2fb8:	6f7010ef          	jal	4eae <exit>
    printf("%s: chdir dd/../../../dd failed\n", s);
    2fbc:	85ca                	mv	a1,s2
    2fbe:	00004517          	auipc	a0,0x4
    2fc2:	98a50513          	add	a0,a0,-1654 # 6948 <malloc+0x1576>
    2fc6:	358020ef          	jal	531e <printf>
    exit(1);
    2fca:	4505                	li	a0,1
    2fcc:	6e3010ef          	jal	4eae <exit>
    printf("%s: chdir ./.. failed\n", s);
    2fd0:	85ca                	mv	a1,s2
    2fd2:	00004517          	auipc	a0,0x4
    2fd6:	9a650513          	add	a0,a0,-1626 # 6978 <malloc+0x15a6>
    2fda:	344020ef          	jal	531e <printf>
    exit(1);
    2fde:	4505                	li	a0,1
    2fe0:	6cf010ef          	jal	4eae <exit>
    printf("%s: open dd/dd/ffff failed\n", s);
    2fe4:	85ca                	mv	a1,s2
    2fe6:	00004517          	auipc	a0,0x4
    2fea:	9aa50513          	add	a0,a0,-1622 # 6990 <malloc+0x15be>
    2fee:	330020ef          	jal	531e <printf>
    exit(1);
    2ff2:	4505                	li	a0,1
    2ff4:	6bb010ef          	jal	4eae <exit>
    printf("%s: read dd/dd/ffff wrong len\n", s);
    2ff8:	85ca                	mv	a1,s2
    2ffa:	00004517          	auipc	a0,0x4
    2ffe:	9b650513          	add	a0,a0,-1610 # 69b0 <malloc+0x15de>
    3002:	31c020ef          	jal	531e <printf>
    exit(1);
    3006:	4505                	li	a0,1
    3008:	6a7010ef          	jal	4eae <exit>
    printf("%s: open (unlinked) dd/dd/ff succeeded!\n", s);
    300c:	85ca                	mv	a1,s2
    300e:	00004517          	auipc	a0,0x4
    3012:	9c250513          	add	a0,a0,-1598 # 69d0 <malloc+0x15fe>
    3016:	308020ef          	jal	531e <printf>
    exit(1);
    301a:	4505                	li	a0,1
    301c:	693010ef          	jal	4eae <exit>
    printf("%s: create dd/ff/ff succeeded!\n", s);
    3020:	85ca                	mv	a1,s2
    3022:	00004517          	auipc	a0,0x4
    3026:	9ee50513          	add	a0,a0,-1554 # 6a10 <malloc+0x163e>
    302a:	2f4020ef          	jal	531e <printf>
    exit(1);
    302e:	4505                	li	a0,1
    3030:	67f010ef          	jal	4eae <exit>
    printf("%s: create dd/xx/ff succeeded!\n", s);
    3034:	85ca                	mv	a1,s2
    3036:	00004517          	auipc	a0,0x4
    303a:	a0a50513          	add	a0,a0,-1526 # 6a40 <malloc+0x166e>
    303e:	2e0020ef          	jal	531e <printf>
    exit(1);
    3042:	4505                	li	a0,1
    3044:	66b010ef          	jal	4eae <exit>
    printf("%s: create dd succeeded!\n", s);
    3048:	85ca                	mv	a1,s2
    304a:	00004517          	auipc	a0,0x4
    304e:	a1650513          	add	a0,a0,-1514 # 6a60 <malloc+0x168e>
    3052:	2cc020ef          	jal	531e <printf>
    exit(1);
    3056:	4505                	li	a0,1
    3058:	657010ef          	jal	4eae <exit>
    printf("%s: open dd rdwr succeeded!\n", s);
    305c:	85ca                	mv	a1,s2
    305e:	00004517          	auipc	a0,0x4
    3062:	a2250513          	add	a0,a0,-1502 # 6a80 <malloc+0x16ae>
    3066:	2b8020ef          	jal	531e <printf>
    exit(1);
    306a:	4505                	li	a0,1
    306c:	643010ef          	jal	4eae <exit>
    printf("%s: open dd wronly succeeded!\n", s);
    3070:	85ca                	mv	a1,s2
    3072:	00004517          	auipc	a0,0x4
    3076:	a2e50513          	add	a0,a0,-1490 # 6aa0 <malloc+0x16ce>
    307a:	2a4020ef          	jal	531e <printf>
    exit(1);
    307e:	4505                	li	a0,1
    3080:	62f010ef          	jal	4eae <exit>
    printf("%s: link dd/ff/ff dd/dd/xx succeeded!\n", s);
    3084:	85ca                	mv	a1,s2
    3086:	00004517          	auipc	a0,0x4
    308a:	a4a50513          	add	a0,a0,-1462 # 6ad0 <malloc+0x16fe>
    308e:	290020ef          	jal	531e <printf>
    exit(1);
    3092:	4505                	li	a0,1
    3094:	61b010ef          	jal	4eae <exit>
    printf("%s: link dd/xx/ff dd/dd/xx succeeded!\n", s);
    3098:	85ca                	mv	a1,s2
    309a:	00004517          	auipc	a0,0x4
    309e:	a5e50513          	add	a0,a0,-1442 # 6af8 <malloc+0x1726>
    30a2:	27c020ef          	jal	531e <printf>
    exit(1);
    30a6:	4505                	li	a0,1
    30a8:	607010ef          	jal	4eae <exit>
    printf("%s: link dd/ff dd/dd/ffff succeeded!\n", s);
    30ac:	85ca                	mv	a1,s2
    30ae:	00004517          	auipc	a0,0x4
    30b2:	a7250513          	add	a0,a0,-1422 # 6b20 <malloc+0x174e>
    30b6:	268020ef          	jal	531e <printf>
    exit(1);
    30ba:	4505                	li	a0,1
    30bc:	5f3010ef          	jal	4eae <exit>
    printf("%s: mkdir dd/ff/ff succeeded!\n", s);
    30c0:	85ca                	mv	a1,s2
    30c2:	00004517          	auipc	a0,0x4
    30c6:	a8650513          	add	a0,a0,-1402 # 6b48 <malloc+0x1776>
    30ca:	254020ef          	jal	531e <printf>
    exit(1);
    30ce:	4505                	li	a0,1
    30d0:	5df010ef          	jal	4eae <exit>
    printf("%s: mkdir dd/xx/ff succeeded!\n", s);
    30d4:	85ca                	mv	a1,s2
    30d6:	00004517          	auipc	a0,0x4
    30da:	a9250513          	add	a0,a0,-1390 # 6b68 <malloc+0x1796>
    30de:	240020ef          	jal	531e <printf>
    exit(1);
    30e2:	4505                	li	a0,1
    30e4:	5cb010ef          	jal	4eae <exit>
    printf("%s: mkdir dd/dd/ffff succeeded!\n", s);
    30e8:	85ca                	mv	a1,s2
    30ea:	00004517          	auipc	a0,0x4
    30ee:	a9e50513          	add	a0,a0,-1378 # 6b88 <malloc+0x17b6>
    30f2:	22c020ef          	jal	531e <printf>
    exit(1);
    30f6:	4505                	li	a0,1
    30f8:	5b7010ef          	jal	4eae <exit>
    printf("%s: unlink dd/xx/ff succeeded!\n", s);
    30fc:	85ca                	mv	a1,s2
    30fe:	00004517          	auipc	a0,0x4
    3102:	ab250513          	add	a0,a0,-1358 # 6bb0 <malloc+0x17de>
    3106:	218020ef          	jal	531e <printf>
    exit(1);
    310a:	4505                	li	a0,1
    310c:	5a3010ef          	jal	4eae <exit>
    printf("%s: unlink dd/ff/ff succeeded!\n", s);
    3110:	85ca                	mv	a1,s2
    3112:	00004517          	auipc	a0,0x4
    3116:	abe50513          	add	a0,a0,-1346 # 6bd0 <malloc+0x17fe>
    311a:	204020ef          	jal	531e <printf>
    exit(1);
    311e:	4505                	li	a0,1
    3120:	58f010ef          	jal	4eae <exit>
    printf("%s: chdir dd/ff succeeded!\n", s);
    3124:	85ca                	mv	a1,s2
    3126:	00004517          	auipc	a0,0x4
    312a:	aca50513          	add	a0,a0,-1334 # 6bf0 <malloc+0x181e>
    312e:	1f0020ef          	jal	531e <printf>
    exit(1);
    3132:	4505                	li	a0,1
    3134:	57b010ef          	jal	4eae <exit>
    printf("%s: chdir dd/xx succeeded!\n", s);
    3138:	85ca                	mv	a1,s2
    313a:	00004517          	auipc	a0,0x4
    313e:	ade50513          	add	a0,a0,-1314 # 6c18 <malloc+0x1846>
    3142:	1dc020ef          	jal	531e <printf>
    exit(1);
    3146:	4505                	li	a0,1
    3148:	567010ef          	jal	4eae <exit>
    printf("%s: unlink dd/dd/ff failed\n", s);
    314c:	85ca                	mv	a1,s2
    314e:	00003517          	auipc	a0,0x3
    3152:	75a50513          	add	a0,a0,1882 # 68a8 <malloc+0x14d6>
    3156:	1c8020ef          	jal	531e <printf>
    exit(1);
    315a:	4505                	li	a0,1
    315c:	553010ef          	jal	4eae <exit>
    printf("%s: unlink dd/ff failed\n", s);
    3160:	85ca                	mv	a1,s2
    3162:	00004517          	auipc	a0,0x4
    3166:	ad650513          	add	a0,a0,-1322 # 6c38 <malloc+0x1866>
    316a:	1b4020ef          	jal	531e <printf>
    exit(1);
    316e:	4505                	li	a0,1
    3170:	53f010ef          	jal	4eae <exit>
    printf("%s: unlink non-empty dd succeeded!\n", s);
    3174:	85ca                	mv	a1,s2
    3176:	00004517          	auipc	a0,0x4
    317a:	ae250513          	add	a0,a0,-1310 # 6c58 <malloc+0x1886>
    317e:	1a0020ef          	jal	531e <printf>
    exit(1);
    3182:	4505                	li	a0,1
    3184:	52b010ef          	jal	4eae <exit>
    printf("%s: unlink dd/dd failed\n", s);
    3188:	85ca                	mv	a1,s2
    318a:	00004517          	auipc	a0,0x4
    318e:	afe50513          	add	a0,a0,-1282 # 6c88 <malloc+0x18b6>
    3192:	18c020ef          	jal	531e <printf>
    exit(1);
    3196:	4505                	li	a0,1
    3198:	517010ef          	jal	4eae <exit>
    printf("%s: unlink dd failed\n", s);
    319c:	85ca                	mv	a1,s2
    319e:	00004517          	auipc	a0,0x4
    31a2:	b0a50513          	add	a0,a0,-1270 # 6ca8 <malloc+0x18d6>
    31a6:	178020ef          	jal	531e <printf>
    exit(1);
    31aa:	4505                	li	a0,1
    31ac:	503010ef          	jal	4eae <exit>

00000000000031b0 <rmdot>:
{
    31b0:	1101                	add	sp,sp,-32
    31b2:	ec06                	sd	ra,24(sp)
    31b4:	e822                	sd	s0,16(sp)
    31b6:	e426                	sd	s1,8(sp)
    31b8:	1000                	add	s0,sp,32
    31ba:	84aa                	mv	s1,a0
  if(mkdir("dots") != 0){
    31bc:	00004517          	auipc	a0,0x4
    31c0:	b0450513          	add	a0,a0,-1276 # 6cc0 <malloc+0x18ee>
    31c4:	553010ef          	jal	4f16 <mkdir>
    31c8:	e53d                	bnez	a0,3236 <rmdot+0x86>
  if(chdir("dots") != 0){
    31ca:	00004517          	auipc	a0,0x4
    31ce:	af650513          	add	a0,a0,-1290 # 6cc0 <malloc+0x18ee>
    31d2:	54d010ef          	jal	4f1e <chdir>
    31d6:	e935                	bnez	a0,324a <rmdot+0x9a>
  if(unlink(".") == 0){
    31d8:	00003517          	auipc	a0,0x3
    31dc:	a1850513          	add	a0,a0,-1512 # 5bf0 <malloc+0x81e>
    31e0:	51f010ef          	jal	4efe <unlink>
    31e4:	cd2d                	beqz	a0,325e <rmdot+0xae>
  if(unlink("..") == 0){
    31e6:	00003517          	auipc	a0,0x3
    31ea:	52a50513          	add	a0,a0,1322 # 6710 <malloc+0x133e>
    31ee:	511010ef          	jal	4efe <unlink>
    31f2:	c141                	beqz	a0,3272 <rmdot+0xc2>
  if(chdir("/") != 0){
    31f4:	00003517          	auipc	a0,0x3
    31f8:	4c450513          	add	a0,a0,1220 # 66b8 <malloc+0x12e6>
    31fc:	523010ef          	jal	4f1e <chdir>
    3200:	e159                	bnez	a0,3286 <rmdot+0xd6>
  if(unlink("dots/.") == 0){
    3202:	00004517          	auipc	a0,0x4
    3206:	b2650513          	add	a0,a0,-1242 # 6d28 <malloc+0x1956>
    320a:	4f5010ef          	jal	4efe <unlink>
    320e:	c551                	beqz	a0,329a <rmdot+0xea>
  if(unlink("dots/..") == 0){
    3210:	00004517          	auipc	a0,0x4
    3214:	b4050513          	add	a0,a0,-1216 # 6d50 <malloc+0x197e>
    3218:	4e7010ef          	jal	4efe <unlink>
    321c:	c949                	beqz	a0,32ae <rmdot+0xfe>
  if(unlink("dots") != 0){
    321e:	00004517          	auipc	a0,0x4
    3222:	aa250513          	add	a0,a0,-1374 # 6cc0 <malloc+0x18ee>
    3226:	4d9010ef          	jal	4efe <unlink>
    322a:	ed41                	bnez	a0,32c2 <rmdot+0x112>
}
    322c:	60e2                	ld	ra,24(sp)
    322e:	6442                	ld	s0,16(sp)
    3230:	64a2                	ld	s1,8(sp)
    3232:	6105                	add	sp,sp,32
    3234:	8082                	ret
    printf("%s: mkdir dots failed\n", s);
    3236:	85a6                	mv	a1,s1
    3238:	00004517          	auipc	a0,0x4
    323c:	a9050513          	add	a0,a0,-1392 # 6cc8 <malloc+0x18f6>
    3240:	0de020ef          	jal	531e <printf>
    exit(1);
    3244:	4505                	li	a0,1
    3246:	469010ef          	jal	4eae <exit>
    printf("%s: chdir dots failed\n", s);
    324a:	85a6                	mv	a1,s1
    324c:	00004517          	auipc	a0,0x4
    3250:	a9450513          	add	a0,a0,-1388 # 6ce0 <malloc+0x190e>
    3254:	0ca020ef          	jal	531e <printf>
    exit(1);
    3258:	4505                	li	a0,1
    325a:	455010ef          	jal	4eae <exit>
    printf("%s: rm . worked!\n", s);
    325e:	85a6                	mv	a1,s1
    3260:	00004517          	auipc	a0,0x4
    3264:	a9850513          	add	a0,a0,-1384 # 6cf8 <malloc+0x1926>
    3268:	0b6020ef          	jal	531e <printf>
    exit(1);
    326c:	4505                	li	a0,1
    326e:	441010ef          	jal	4eae <exit>
    printf("%s: rm .. worked!\n", s);
    3272:	85a6                	mv	a1,s1
    3274:	00004517          	auipc	a0,0x4
    3278:	a9c50513          	add	a0,a0,-1380 # 6d10 <malloc+0x193e>
    327c:	0a2020ef          	jal	531e <printf>
    exit(1);
    3280:	4505                	li	a0,1
    3282:	42d010ef          	jal	4eae <exit>
    printf("%s: chdir / failed\n", s);
    3286:	85a6                	mv	a1,s1
    3288:	00003517          	auipc	a0,0x3
    328c:	43850513          	add	a0,a0,1080 # 66c0 <malloc+0x12ee>
    3290:	08e020ef          	jal	531e <printf>
    exit(1);
    3294:	4505                	li	a0,1
    3296:	419010ef          	jal	4eae <exit>
    printf("%s: unlink dots/. worked!\n", s);
    329a:	85a6                	mv	a1,s1
    329c:	00004517          	auipc	a0,0x4
    32a0:	a9450513          	add	a0,a0,-1388 # 6d30 <malloc+0x195e>
    32a4:	07a020ef          	jal	531e <printf>
    exit(1);
    32a8:	4505                	li	a0,1
    32aa:	405010ef          	jal	4eae <exit>
    printf("%s: unlink dots/.. worked!\n", s);
    32ae:	85a6                	mv	a1,s1
    32b0:	00004517          	auipc	a0,0x4
    32b4:	aa850513          	add	a0,a0,-1368 # 6d58 <malloc+0x1986>
    32b8:	066020ef          	jal	531e <printf>
    exit(1);
    32bc:	4505                	li	a0,1
    32be:	3f1010ef          	jal	4eae <exit>
    printf("%s: unlink dots failed!\n", s);
    32c2:	85a6                	mv	a1,s1
    32c4:	00004517          	auipc	a0,0x4
    32c8:	ab450513          	add	a0,a0,-1356 # 6d78 <malloc+0x19a6>
    32cc:	052020ef          	jal	531e <printf>
    exit(1);
    32d0:	4505                	li	a0,1
    32d2:	3dd010ef          	jal	4eae <exit>

00000000000032d6 <dirfile>:
{
    32d6:	1101                	add	sp,sp,-32
    32d8:	ec06                	sd	ra,24(sp)
    32da:	e822                	sd	s0,16(sp)
    32dc:	e426                	sd	s1,8(sp)
    32de:	e04a                	sd	s2,0(sp)
    32e0:	1000                	add	s0,sp,32
    32e2:	892a                	mv	s2,a0
  fd = open("dirfile", O_CREATE);
    32e4:	20000593          	li	a1,512
    32e8:	00004517          	auipc	a0,0x4
    32ec:	ab050513          	add	a0,a0,-1360 # 6d98 <malloc+0x19c6>
    32f0:	3ff010ef          	jal	4eee <open>
  if(fd < 0){
    32f4:	0c054563          	bltz	a0,33be <dirfile+0xe8>
  close(fd);
    32f8:	3df010ef          	jal	4ed6 <close>
  if(chdir("dirfile") == 0){
    32fc:	00004517          	auipc	a0,0x4
    3300:	a9c50513          	add	a0,a0,-1380 # 6d98 <malloc+0x19c6>
    3304:	41b010ef          	jal	4f1e <chdir>
    3308:	c569                	beqz	a0,33d2 <dirfile+0xfc>
  fd = open("dirfile/xx", 0);
    330a:	4581                	li	a1,0
    330c:	00004517          	auipc	a0,0x4
    3310:	ad450513          	add	a0,a0,-1324 # 6de0 <malloc+0x1a0e>
    3314:	3db010ef          	jal	4eee <open>
  if(fd >= 0){
    3318:	0c055763          	bgez	a0,33e6 <dirfile+0x110>
  fd = open("dirfile/xx", O_CREATE);
    331c:	20000593          	li	a1,512
    3320:	00004517          	auipc	a0,0x4
    3324:	ac050513          	add	a0,a0,-1344 # 6de0 <malloc+0x1a0e>
    3328:	3c7010ef          	jal	4eee <open>
  if(fd >= 0){
    332c:	0c055763          	bgez	a0,33fa <dirfile+0x124>
  if(mkdir("dirfile/xx") == 0){
    3330:	00004517          	auipc	a0,0x4
    3334:	ab050513          	add	a0,a0,-1360 # 6de0 <malloc+0x1a0e>
    3338:	3df010ef          	jal	4f16 <mkdir>
    333c:	0c050963          	beqz	a0,340e <dirfile+0x138>
  if(unlink("dirfile/xx") == 0){
    3340:	00004517          	auipc	a0,0x4
    3344:	aa050513          	add	a0,a0,-1376 # 6de0 <malloc+0x1a0e>
    3348:	3b7010ef          	jal	4efe <unlink>
    334c:	0c050b63          	beqz	a0,3422 <dirfile+0x14c>
  if(link("README", "dirfile/xx") == 0){
    3350:	00004597          	auipc	a1,0x4
    3354:	a9058593          	add	a1,a1,-1392 # 6de0 <malloc+0x1a0e>
    3358:	00002517          	auipc	a0,0x2
    335c:	38850513          	add	a0,a0,904 # 56e0 <malloc+0x30e>
    3360:	3af010ef          	jal	4f0e <link>
    3364:	0c050963          	beqz	a0,3436 <dirfile+0x160>
  if(unlink("dirfile") != 0){
    3368:	00004517          	auipc	a0,0x4
    336c:	a3050513          	add	a0,a0,-1488 # 6d98 <malloc+0x19c6>
    3370:	38f010ef          	jal	4efe <unlink>
    3374:	0c051b63          	bnez	a0,344a <dirfile+0x174>
  fd = open(".", O_RDWR);
    3378:	4589                	li	a1,2
    337a:	00003517          	auipc	a0,0x3
    337e:	87650513          	add	a0,a0,-1930 # 5bf0 <malloc+0x81e>
    3382:	36d010ef          	jal	4eee <open>
  if(fd >= 0){
    3386:	0c055c63          	bgez	a0,345e <dirfile+0x188>
  fd = open(".", 0);
    338a:	4581                	li	a1,0
    338c:	00003517          	auipc	a0,0x3
    3390:	86450513          	add	a0,a0,-1948 # 5bf0 <malloc+0x81e>
    3394:	35b010ef          	jal	4eee <open>
    3398:	84aa                	mv	s1,a0
  if(write(fd, "x", 1) > 0){
    339a:	4605                	li	a2,1
    339c:	00002597          	auipc	a1,0x2
    33a0:	1dc58593          	add	a1,a1,476 # 5578 <malloc+0x1a6>
    33a4:	32b010ef          	jal	4ece <write>
    33a8:	0ca04563          	bgtz	a0,3472 <dirfile+0x19c>
  close(fd);
    33ac:	8526                	mv	a0,s1
    33ae:	329010ef          	jal	4ed6 <close>
}
    33b2:	60e2                	ld	ra,24(sp)
    33b4:	6442                	ld	s0,16(sp)
    33b6:	64a2                	ld	s1,8(sp)
    33b8:	6902                	ld	s2,0(sp)
    33ba:	6105                	add	sp,sp,32
    33bc:	8082                	ret
    printf("%s: create dirfile failed\n", s);
    33be:	85ca                	mv	a1,s2
    33c0:	00004517          	auipc	a0,0x4
    33c4:	9e050513          	add	a0,a0,-1568 # 6da0 <malloc+0x19ce>
    33c8:	757010ef          	jal	531e <printf>
    exit(1);
    33cc:	4505                	li	a0,1
    33ce:	2e1010ef          	jal	4eae <exit>
    printf("%s: chdir dirfile succeeded!\n", s);
    33d2:	85ca                	mv	a1,s2
    33d4:	00004517          	auipc	a0,0x4
    33d8:	9ec50513          	add	a0,a0,-1556 # 6dc0 <malloc+0x19ee>
    33dc:	743010ef          	jal	531e <printf>
    exit(1);
    33e0:	4505                	li	a0,1
    33e2:	2cd010ef          	jal	4eae <exit>
    printf("%s: create dirfile/xx succeeded!\n", s);
    33e6:	85ca                	mv	a1,s2
    33e8:	00004517          	auipc	a0,0x4
    33ec:	a0850513          	add	a0,a0,-1528 # 6df0 <malloc+0x1a1e>
    33f0:	72f010ef          	jal	531e <printf>
    exit(1);
    33f4:	4505                	li	a0,1
    33f6:	2b9010ef          	jal	4eae <exit>
    printf("%s: create dirfile/xx succeeded!\n", s);
    33fa:	85ca                	mv	a1,s2
    33fc:	00004517          	auipc	a0,0x4
    3400:	9f450513          	add	a0,a0,-1548 # 6df0 <malloc+0x1a1e>
    3404:	71b010ef          	jal	531e <printf>
    exit(1);
    3408:	4505                	li	a0,1
    340a:	2a5010ef          	jal	4eae <exit>
    printf("%s: mkdir dirfile/xx succeeded!\n", s);
    340e:	85ca                	mv	a1,s2
    3410:	00004517          	auipc	a0,0x4
    3414:	a0850513          	add	a0,a0,-1528 # 6e18 <malloc+0x1a46>
    3418:	707010ef          	jal	531e <printf>
    exit(1);
    341c:	4505                	li	a0,1
    341e:	291010ef          	jal	4eae <exit>
    printf("%s: unlink dirfile/xx succeeded!\n", s);
    3422:	85ca                	mv	a1,s2
    3424:	00004517          	auipc	a0,0x4
    3428:	a1c50513          	add	a0,a0,-1508 # 6e40 <malloc+0x1a6e>
    342c:	6f3010ef          	jal	531e <printf>
    exit(1);
    3430:	4505                	li	a0,1
    3432:	27d010ef          	jal	4eae <exit>
    printf("%s: link to dirfile/xx succeeded!\n", s);
    3436:	85ca                	mv	a1,s2
    3438:	00004517          	auipc	a0,0x4
    343c:	a3050513          	add	a0,a0,-1488 # 6e68 <malloc+0x1a96>
    3440:	6df010ef          	jal	531e <printf>
    exit(1);
    3444:	4505                	li	a0,1
    3446:	269010ef          	jal	4eae <exit>
    printf("%s: unlink dirfile failed!\n", s);
    344a:	85ca                	mv	a1,s2
    344c:	00004517          	auipc	a0,0x4
    3450:	a4450513          	add	a0,a0,-1468 # 6e90 <malloc+0x1abe>
    3454:	6cb010ef          	jal	531e <printf>
    exit(1);
    3458:	4505                	li	a0,1
    345a:	255010ef          	jal	4eae <exit>
    printf("%s: open . for writing succeeded!\n", s);
    345e:	85ca                	mv	a1,s2
    3460:	00004517          	auipc	a0,0x4
    3464:	a5050513          	add	a0,a0,-1456 # 6eb0 <malloc+0x1ade>
    3468:	6b7010ef          	jal	531e <printf>
    exit(1);
    346c:	4505                	li	a0,1
    346e:	241010ef          	jal	4eae <exit>
    printf("%s: write . succeeded!\n", s);
    3472:	85ca                	mv	a1,s2
    3474:	00004517          	auipc	a0,0x4
    3478:	a6450513          	add	a0,a0,-1436 # 6ed8 <malloc+0x1b06>
    347c:	6a3010ef          	jal	531e <printf>
    exit(1);
    3480:	4505                	li	a0,1
    3482:	22d010ef          	jal	4eae <exit>

0000000000003486 <iref>:
{
    3486:	7139                	add	sp,sp,-64
    3488:	fc06                	sd	ra,56(sp)
    348a:	f822                	sd	s0,48(sp)
    348c:	f426                	sd	s1,40(sp)
    348e:	f04a                	sd	s2,32(sp)
    3490:	ec4e                	sd	s3,24(sp)
    3492:	e852                	sd	s4,16(sp)
    3494:	e456                	sd	s5,8(sp)
    3496:	e05a                	sd	s6,0(sp)
    3498:	0080                	add	s0,sp,64
    349a:	8b2a                	mv	s6,a0
    349c:	03300913          	li	s2,51
    if(mkdir("irefd") != 0){
    34a0:	00004a17          	auipc	s4,0x4
    34a4:	a50a0a13          	add	s4,s4,-1456 # 6ef0 <malloc+0x1b1e>
    mkdir("");
    34a8:	00003497          	auipc	s1,0x3
    34ac:	55048493          	add	s1,s1,1360 # 69f8 <malloc+0x1626>
    link("README", "");
    34b0:	00002a97          	auipc	s5,0x2
    34b4:	230a8a93          	add	s5,s5,560 # 56e0 <malloc+0x30e>
    fd = open("xx", O_CREATE);
    34b8:	00004997          	auipc	s3,0x4
    34bc:	93098993          	add	s3,s3,-1744 # 6de8 <malloc+0x1a16>
    34c0:	a835                	j	34fc <iref+0x76>
      printf("%s: mkdir irefd failed\n", s);
    34c2:	85da                	mv	a1,s6
    34c4:	00004517          	auipc	a0,0x4
    34c8:	a3450513          	add	a0,a0,-1484 # 6ef8 <malloc+0x1b26>
    34cc:	653010ef          	jal	531e <printf>
      exit(1);
    34d0:	4505                	li	a0,1
    34d2:	1dd010ef          	jal	4eae <exit>
      printf("%s: chdir irefd failed\n", s);
    34d6:	85da                	mv	a1,s6
    34d8:	00004517          	auipc	a0,0x4
    34dc:	a3850513          	add	a0,a0,-1480 # 6f10 <malloc+0x1b3e>
    34e0:	63f010ef          	jal	531e <printf>
      exit(1);
    34e4:	4505                	li	a0,1
    34e6:	1c9010ef          	jal	4eae <exit>
      close(fd);
    34ea:	1ed010ef          	jal	4ed6 <close>
    34ee:	a82d                	j	3528 <iref+0xa2>
    unlink("xx");
    34f0:	854e                	mv	a0,s3
    34f2:	20d010ef          	jal	4efe <unlink>
  for(i = 0; i < NINODE + 1; i++){
    34f6:	397d                	addw	s2,s2,-1
    34f8:	04090263          	beqz	s2,353c <iref+0xb6>
    if(mkdir("irefd") != 0){
    34fc:	8552                	mv	a0,s4
    34fe:	219010ef          	jal	4f16 <mkdir>
    3502:	f161                	bnez	a0,34c2 <iref+0x3c>
    if(chdir("irefd") != 0){
    3504:	8552                	mv	a0,s4
    3506:	219010ef          	jal	4f1e <chdir>
    350a:	f571                	bnez	a0,34d6 <iref+0x50>
    mkdir("");
    350c:	8526                	mv	a0,s1
    350e:	209010ef          	jal	4f16 <mkdir>
    link("README", "");
    3512:	85a6                	mv	a1,s1
    3514:	8556                	mv	a0,s5
    3516:	1f9010ef          	jal	4f0e <link>
    fd = open("", O_CREATE);
    351a:	20000593          	li	a1,512
    351e:	8526                	mv	a0,s1
    3520:	1cf010ef          	jal	4eee <open>
    if(fd >= 0)
    3524:	fc0553e3          	bgez	a0,34ea <iref+0x64>
    fd = open("xx", O_CREATE);
    3528:	20000593          	li	a1,512
    352c:	854e                	mv	a0,s3
    352e:	1c1010ef          	jal	4eee <open>
    if(fd >= 0)
    3532:	fa054fe3          	bltz	a0,34f0 <iref+0x6a>
      close(fd);
    3536:	1a1010ef          	jal	4ed6 <close>
    353a:	bf5d                	j	34f0 <iref+0x6a>
    353c:	03300493          	li	s1,51
    chdir("..");
    3540:	00003997          	auipc	s3,0x3
    3544:	1d098993          	add	s3,s3,464 # 6710 <malloc+0x133e>
    unlink("irefd");
    3548:	00004917          	auipc	s2,0x4
    354c:	9a890913          	add	s2,s2,-1624 # 6ef0 <malloc+0x1b1e>
    chdir("..");
    3550:	854e                	mv	a0,s3
    3552:	1cd010ef          	jal	4f1e <chdir>
    unlink("irefd");
    3556:	854a                	mv	a0,s2
    3558:	1a7010ef          	jal	4efe <unlink>
  for(i = 0; i < NINODE + 1; i++){
    355c:	34fd                	addw	s1,s1,-1
    355e:	f8ed                	bnez	s1,3550 <iref+0xca>
  chdir("/");
    3560:	00003517          	auipc	a0,0x3
    3564:	15850513          	add	a0,a0,344 # 66b8 <malloc+0x12e6>
    3568:	1b7010ef          	jal	4f1e <chdir>
}
    356c:	70e2                	ld	ra,56(sp)
    356e:	7442                	ld	s0,48(sp)
    3570:	74a2                	ld	s1,40(sp)
    3572:	7902                	ld	s2,32(sp)
    3574:	69e2                	ld	s3,24(sp)
    3576:	6a42                	ld	s4,16(sp)
    3578:	6aa2                	ld	s5,8(sp)
    357a:	6b02                	ld	s6,0(sp)
    357c:	6121                	add	sp,sp,64
    357e:	8082                	ret

0000000000003580 <openiputtest>:
{
    3580:	7179                	add	sp,sp,-48
    3582:	f406                	sd	ra,40(sp)
    3584:	f022                	sd	s0,32(sp)
    3586:	ec26                	sd	s1,24(sp)
    3588:	1800                	add	s0,sp,48
    358a:	84aa                	mv	s1,a0
  if(mkdir("oidir") < 0){
    358c:	00004517          	auipc	a0,0x4
    3590:	99c50513          	add	a0,a0,-1636 # 6f28 <malloc+0x1b56>
    3594:	183010ef          	jal	4f16 <mkdir>
    3598:	02054a63          	bltz	a0,35cc <openiputtest+0x4c>
  pid = fork();
    359c:	10b010ef          	jal	4ea6 <fork>
  if(pid < 0){
    35a0:	04054063          	bltz	a0,35e0 <openiputtest+0x60>
  if(pid == 0){
    35a4:	e939                	bnez	a0,35fa <openiputtest+0x7a>
    int fd = open("oidir", O_RDWR);
    35a6:	4589                	li	a1,2
    35a8:	00004517          	auipc	a0,0x4
    35ac:	98050513          	add	a0,a0,-1664 # 6f28 <malloc+0x1b56>
    35b0:	13f010ef          	jal	4eee <open>
    if(fd >= 0){
    35b4:	04054063          	bltz	a0,35f4 <openiputtest+0x74>
      printf("%s: open directory for write succeeded\n", s);
    35b8:	85a6                	mv	a1,s1
    35ba:	00004517          	auipc	a0,0x4
    35be:	98e50513          	add	a0,a0,-1650 # 6f48 <malloc+0x1b76>
    35c2:	55d010ef          	jal	531e <printf>
      exit(1);
    35c6:	4505                	li	a0,1
    35c8:	0e7010ef          	jal	4eae <exit>
    printf("%s: mkdir oidir failed\n", s);
    35cc:	85a6                	mv	a1,s1
    35ce:	00004517          	auipc	a0,0x4
    35d2:	96250513          	add	a0,a0,-1694 # 6f30 <malloc+0x1b5e>
    35d6:	549010ef          	jal	531e <printf>
    exit(1);
    35da:	4505                	li	a0,1
    35dc:	0d3010ef          	jal	4eae <exit>
    printf("%s: fork failed\n", s);
    35e0:	85a6                	mv	a1,s1
    35e2:	00002517          	auipc	a0,0x2
    35e6:	7b650513          	add	a0,a0,1974 # 5d98 <malloc+0x9c6>
    35ea:	535010ef          	jal	531e <printf>
    exit(1);
    35ee:	4505                	li	a0,1
    35f0:	0bf010ef          	jal	4eae <exit>
    exit(0);
    35f4:	4501                	li	a0,0
    35f6:	0b9010ef          	jal	4eae <exit>
  pause(1);
    35fa:	4505                	li	a0,1
    35fc:	143010ef          	jal	4f3e <pause>
  if(unlink("oidir") != 0){
    3600:	00004517          	auipc	a0,0x4
    3604:	92850513          	add	a0,a0,-1752 # 6f28 <malloc+0x1b56>
    3608:	0f7010ef          	jal	4efe <unlink>
    360c:	c919                	beqz	a0,3622 <openiputtest+0xa2>
    printf("%s: unlink failed\n", s);
    360e:	85a6                	mv	a1,s1
    3610:	00003517          	auipc	a0,0x3
    3614:	97850513          	add	a0,a0,-1672 # 5f88 <malloc+0xbb6>
    3618:	507010ef          	jal	531e <printf>
    exit(1);
    361c:	4505                	li	a0,1
    361e:	091010ef          	jal	4eae <exit>
  wait(&xstatus);
    3622:	fdc40513          	add	a0,s0,-36
    3626:	091010ef          	jal	4eb6 <wait>
  exit(xstatus);
    362a:	fdc42503          	lw	a0,-36(s0)
    362e:	081010ef          	jal	4eae <exit>

0000000000003632 <forkforkfork>:
{
    3632:	1101                	add	sp,sp,-32
    3634:	ec06                	sd	ra,24(sp)
    3636:	e822                	sd	s0,16(sp)
    3638:	e426                	sd	s1,8(sp)
    363a:	1000                	add	s0,sp,32
    363c:	84aa                	mv	s1,a0
  unlink("stopforking");
    363e:	00004517          	auipc	a0,0x4
    3642:	93250513          	add	a0,a0,-1742 # 6f70 <malloc+0x1b9e>
    3646:	0b9010ef          	jal	4efe <unlink>
  int pid = fork();
    364a:	05d010ef          	jal	4ea6 <fork>
  if(pid < 0){
    364e:	02054b63          	bltz	a0,3684 <forkforkfork+0x52>
  if(pid == 0){
    3652:	c139                	beqz	a0,3698 <forkforkfork+0x66>
  pause(20); // two seconds
    3654:	4551                	li	a0,20
    3656:	0e9010ef          	jal	4f3e <pause>
  close(open("stopforking", O_CREATE|O_RDWR));
    365a:	20200593          	li	a1,514
    365e:	00004517          	auipc	a0,0x4
    3662:	91250513          	add	a0,a0,-1774 # 6f70 <malloc+0x1b9e>
    3666:	089010ef          	jal	4eee <open>
    366a:	06d010ef          	jal	4ed6 <close>
  wait(0);
    366e:	4501                	li	a0,0
    3670:	047010ef          	jal	4eb6 <wait>
  pause(10); // one second
    3674:	4529                	li	a0,10
    3676:	0c9010ef          	jal	4f3e <pause>
}
    367a:	60e2                	ld	ra,24(sp)
    367c:	6442                	ld	s0,16(sp)
    367e:	64a2                	ld	s1,8(sp)
    3680:	6105                	add	sp,sp,32
    3682:	8082                	ret
    printf("%s: fork failed", s);
    3684:	85a6                	mv	a1,s1
    3686:	00003517          	auipc	a0,0x3
    368a:	8d250513          	add	a0,a0,-1838 # 5f58 <malloc+0xb86>
    368e:	491010ef          	jal	531e <printf>
    exit(1);
    3692:	4505                	li	a0,1
    3694:	01b010ef          	jal	4eae <exit>
      int fd = open("stopforking", 0);
    3698:	00004497          	auipc	s1,0x4
    369c:	8d848493          	add	s1,s1,-1832 # 6f70 <malloc+0x1b9e>
    36a0:	4581                	li	a1,0
    36a2:	8526                	mv	a0,s1
    36a4:	04b010ef          	jal	4eee <open>
      if(fd >= 0){
    36a8:	02055163          	bgez	a0,36ca <forkforkfork+0x98>
      if(fork() < 0){
    36ac:	7fa010ef          	jal	4ea6 <fork>
    36b0:	fe0558e3          	bgez	a0,36a0 <forkforkfork+0x6e>
        close(open("stopforking", O_CREATE|O_RDWR));
    36b4:	20200593          	li	a1,514
    36b8:	00004517          	auipc	a0,0x4
    36bc:	8b850513          	add	a0,a0,-1864 # 6f70 <malloc+0x1b9e>
    36c0:	02f010ef          	jal	4eee <open>
    36c4:	013010ef          	jal	4ed6 <close>
    36c8:	bfe1                	j	36a0 <forkforkfork+0x6e>
        exit(0);
    36ca:	4501                	li	a0,0
    36cc:	7e2010ef          	jal	4eae <exit>

00000000000036d0 <killstatus>:
{
    36d0:	7139                	add	sp,sp,-64
    36d2:	fc06                	sd	ra,56(sp)
    36d4:	f822                	sd	s0,48(sp)
    36d6:	f426                	sd	s1,40(sp)
    36d8:	f04a                	sd	s2,32(sp)
    36da:	ec4e                	sd	s3,24(sp)
    36dc:	e852                	sd	s4,16(sp)
    36de:	0080                	add	s0,sp,64
    36e0:	8a2a                	mv	s4,a0
    36e2:	06400913          	li	s2,100
    if(xst != -1) {
    36e6:	59fd                	li	s3,-1
    int pid1 = fork();
    36e8:	7be010ef          	jal	4ea6 <fork>
    36ec:	84aa                	mv	s1,a0
    if(pid1 < 0){
    36ee:	02054763          	bltz	a0,371c <killstatus+0x4c>
    if(pid1 == 0){
    36f2:	cd1d                	beqz	a0,3730 <killstatus+0x60>
    pause(1);
    36f4:	4505                	li	a0,1
    36f6:	049010ef          	jal	4f3e <pause>
    kill(pid1);
    36fa:	8526                	mv	a0,s1
    36fc:	7e2010ef          	jal	4ede <kill>
    wait(&xst);
    3700:	fcc40513          	add	a0,s0,-52
    3704:	7b2010ef          	jal	4eb6 <wait>
    if(xst != -1) {
    3708:	fcc42783          	lw	a5,-52(s0)
    370c:	03379563          	bne	a5,s3,3736 <killstatus+0x66>
  for(int i = 0; i < 100; i++){
    3710:	397d                	addw	s2,s2,-1
    3712:	fc091be3          	bnez	s2,36e8 <killstatus+0x18>
  exit(0);
    3716:	4501                	li	a0,0
    3718:	796010ef          	jal	4eae <exit>
      printf("%s: fork failed\n", s);
    371c:	85d2                	mv	a1,s4
    371e:	00002517          	auipc	a0,0x2
    3722:	67a50513          	add	a0,a0,1658 # 5d98 <malloc+0x9c6>
    3726:	3f9010ef          	jal	531e <printf>
      exit(1);
    372a:	4505                	li	a0,1
    372c:	782010ef          	jal	4eae <exit>
        getpid();
    3730:	7fe010ef          	jal	4f2e <getpid>
      while(1) {
    3734:	bff5                	j	3730 <killstatus+0x60>
       printf("%s: status should be -1\n", s);
    3736:	85d2                	mv	a1,s4
    3738:	00004517          	auipc	a0,0x4
    373c:	84850513          	add	a0,a0,-1976 # 6f80 <malloc+0x1bae>
    3740:	3df010ef          	jal	531e <printf>
       exit(1);
    3744:	4505                	li	a0,1
    3746:	768010ef          	jal	4eae <exit>

000000000000374a <preempt>:
{
    374a:	7139                	add	sp,sp,-64
    374c:	fc06                	sd	ra,56(sp)
    374e:	f822                	sd	s0,48(sp)
    3750:	f426                	sd	s1,40(sp)
    3752:	f04a                	sd	s2,32(sp)
    3754:	ec4e                	sd	s3,24(sp)
    3756:	e852                	sd	s4,16(sp)
    3758:	0080                	add	s0,sp,64
    375a:	892a                	mv	s2,a0
  pid1 = fork();
    375c:	74a010ef          	jal	4ea6 <fork>
  if(pid1 < 0) {
    3760:	00054563          	bltz	a0,376a <preempt+0x20>
    3764:	84aa                	mv	s1,a0
  if(pid1 == 0)
    3766:	ed01                	bnez	a0,377e <preempt+0x34>
    for(;;)
    3768:	a001                	j	3768 <preempt+0x1e>
    printf("%s: fork failed", s);
    376a:	85ca                	mv	a1,s2
    376c:	00002517          	auipc	a0,0x2
    3770:	7ec50513          	add	a0,a0,2028 # 5f58 <malloc+0xb86>
    3774:	3ab010ef          	jal	531e <printf>
    exit(1);
    3778:	4505                	li	a0,1
    377a:	734010ef          	jal	4eae <exit>
  pid2 = fork();
    377e:	728010ef          	jal	4ea6 <fork>
    3782:	89aa                	mv	s3,a0
  if(pid2 < 0) {
    3784:	00054463          	bltz	a0,378c <preempt+0x42>
  if(pid2 == 0)
    3788:	ed01                	bnez	a0,37a0 <preempt+0x56>
    for(;;)
    378a:	a001                	j	378a <preempt+0x40>
    printf("%s: fork failed\n", s);
    378c:	85ca                	mv	a1,s2
    378e:	00002517          	auipc	a0,0x2
    3792:	60a50513          	add	a0,a0,1546 # 5d98 <malloc+0x9c6>
    3796:	389010ef          	jal	531e <printf>
    exit(1);
    379a:	4505                	li	a0,1
    379c:	712010ef          	jal	4eae <exit>
  pipe(pfds);
    37a0:	fc840513          	add	a0,s0,-56
    37a4:	71a010ef          	jal	4ebe <pipe>
  pid3 = fork();
    37a8:	6fe010ef          	jal	4ea6 <fork>
    37ac:	8a2a                	mv	s4,a0
  if(pid3 < 0) {
    37ae:	02054863          	bltz	a0,37de <preempt+0x94>
  if(pid3 == 0){
    37b2:	e921                	bnez	a0,3802 <preempt+0xb8>
    close(pfds[0]);
    37b4:	fc842503          	lw	a0,-56(s0)
    37b8:	71e010ef          	jal	4ed6 <close>
    if(write(pfds[1], "x", 1) != 1)
    37bc:	4605                	li	a2,1
    37be:	00002597          	auipc	a1,0x2
    37c2:	dba58593          	add	a1,a1,-582 # 5578 <malloc+0x1a6>
    37c6:	fcc42503          	lw	a0,-52(s0)
    37ca:	704010ef          	jal	4ece <write>
    37ce:	4785                	li	a5,1
    37d0:	02f51163          	bne	a0,a5,37f2 <preempt+0xa8>
    close(pfds[1]);
    37d4:	fcc42503          	lw	a0,-52(s0)
    37d8:	6fe010ef          	jal	4ed6 <close>
    for(;;)
    37dc:	a001                	j	37dc <preempt+0x92>
     printf("%s: fork failed\n", s);
    37de:	85ca                	mv	a1,s2
    37e0:	00002517          	auipc	a0,0x2
    37e4:	5b850513          	add	a0,a0,1464 # 5d98 <malloc+0x9c6>
    37e8:	337010ef          	jal	531e <printf>
     exit(1);
    37ec:	4505                	li	a0,1
    37ee:	6c0010ef          	jal	4eae <exit>
      printf("%s: preempt write error", s);
    37f2:	85ca                	mv	a1,s2
    37f4:	00003517          	auipc	a0,0x3
    37f8:	7ac50513          	add	a0,a0,1964 # 6fa0 <malloc+0x1bce>
    37fc:	323010ef          	jal	531e <printf>
    3800:	bfd1                	j	37d4 <preempt+0x8a>
  close(pfds[1]);
    3802:	fcc42503          	lw	a0,-52(s0)
    3806:	6d0010ef          	jal	4ed6 <close>
  if(read(pfds[0], buf, sizeof(buf)) != 1){
    380a:	660d                	lui	a2,0x3
    380c:	00008597          	auipc	a1,0x8
    3810:	4ac58593          	add	a1,a1,1196 # bcb8 <buf>
    3814:	fc842503          	lw	a0,-56(s0)
    3818:	6ae010ef          	jal	4ec6 <read>
    381c:	4785                	li	a5,1
    381e:	02f50163          	beq	a0,a5,3840 <preempt+0xf6>
    printf("%s: preempt read error", s);
    3822:	85ca                	mv	a1,s2
    3824:	00003517          	auipc	a0,0x3
    3828:	79450513          	add	a0,a0,1940 # 6fb8 <malloc+0x1be6>
    382c:	2f3010ef          	jal	531e <printf>
}
    3830:	70e2                	ld	ra,56(sp)
    3832:	7442                	ld	s0,48(sp)
    3834:	74a2                	ld	s1,40(sp)
    3836:	7902                	ld	s2,32(sp)
    3838:	69e2                	ld	s3,24(sp)
    383a:	6a42                	ld	s4,16(sp)
    383c:	6121                	add	sp,sp,64
    383e:	8082                	ret
  close(pfds[0]);
    3840:	fc842503          	lw	a0,-56(s0)
    3844:	692010ef          	jal	4ed6 <close>
  printf("kill... ");
    3848:	00003517          	auipc	a0,0x3
    384c:	78850513          	add	a0,a0,1928 # 6fd0 <malloc+0x1bfe>
    3850:	2cf010ef          	jal	531e <printf>
  kill(pid1);
    3854:	8526                	mv	a0,s1
    3856:	688010ef          	jal	4ede <kill>
  kill(pid2);
    385a:	854e                	mv	a0,s3
    385c:	682010ef          	jal	4ede <kill>
  kill(pid3);
    3860:	8552                	mv	a0,s4
    3862:	67c010ef          	jal	4ede <kill>
  printf("wait... ");
    3866:	00003517          	auipc	a0,0x3
    386a:	77a50513          	add	a0,a0,1914 # 6fe0 <malloc+0x1c0e>
    386e:	2b1010ef          	jal	531e <printf>
  wait(0);
    3872:	4501                	li	a0,0
    3874:	642010ef          	jal	4eb6 <wait>
  wait(0);
    3878:	4501                	li	a0,0
    387a:	63c010ef          	jal	4eb6 <wait>
  wait(0);
    387e:	4501                	li	a0,0
    3880:	636010ef          	jal	4eb6 <wait>
    3884:	b775                	j	3830 <preempt+0xe6>

0000000000003886 <reparent>:
{
    3886:	7179                	add	sp,sp,-48
    3888:	f406                	sd	ra,40(sp)
    388a:	f022                	sd	s0,32(sp)
    388c:	ec26                	sd	s1,24(sp)
    388e:	e84a                	sd	s2,16(sp)
    3890:	e44e                	sd	s3,8(sp)
    3892:	e052                	sd	s4,0(sp)
    3894:	1800                	add	s0,sp,48
    3896:	89aa                	mv	s3,a0
  int master_pid = getpid();
    3898:	696010ef          	jal	4f2e <getpid>
    389c:	8a2a                	mv	s4,a0
    389e:	0c800913          	li	s2,200
    int pid = fork();
    38a2:	604010ef          	jal	4ea6 <fork>
    38a6:	84aa                	mv	s1,a0
    if(pid < 0){
    38a8:	00054e63          	bltz	a0,38c4 <reparent+0x3e>
    if(pid){
    38ac:	c121                	beqz	a0,38ec <reparent+0x66>
      if(wait(0) != pid){
    38ae:	4501                	li	a0,0
    38b0:	606010ef          	jal	4eb6 <wait>
    38b4:	02951263          	bne	a0,s1,38d8 <reparent+0x52>
  for(int i = 0; i < 200; i++){
    38b8:	397d                	addw	s2,s2,-1
    38ba:	fe0914e3          	bnez	s2,38a2 <reparent+0x1c>
  exit(0);
    38be:	4501                	li	a0,0
    38c0:	5ee010ef          	jal	4eae <exit>
      printf("%s: fork failed\n", s);
    38c4:	85ce                	mv	a1,s3
    38c6:	00002517          	auipc	a0,0x2
    38ca:	4d250513          	add	a0,a0,1234 # 5d98 <malloc+0x9c6>
    38ce:	251010ef          	jal	531e <printf>
      exit(1);
    38d2:	4505                	li	a0,1
    38d4:	5da010ef          	jal	4eae <exit>
        printf("%s: wait wrong pid\n", s);
    38d8:	85ce                	mv	a1,s3
    38da:	00002517          	auipc	a0,0x2
    38de:	64650513          	add	a0,a0,1606 # 5f20 <malloc+0xb4e>
    38e2:	23d010ef          	jal	531e <printf>
        exit(1);
    38e6:	4505                	li	a0,1
    38e8:	5c6010ef          	jal	4eae <exit>
      int pid2 = fork();
    38ec:	5ba010ef          	jal	4ea6 <fork>
      if(pid2 < 0){
    38f0:	00054563          	bltz	a0,38fa <reparent+0x74>
      exit(0);
    38f4:	4501                	li	a0,0
    38f6:	5b8010ef          	jal	4eae <exit>
        kill(master_pid);
    38fa:	8552                	mv	a0,s4
    38fc:	5e2010ef          	jal	4ede <kill>
        exit(1);
    3900:	4505                	li	a0,1
    3902:	5ac010ef          	jal	4eae <exit>

0000000000003906 <sbrkfail>:
{
    3906:	7175                	add	sp,sp,-144
    3908:	e506                	sd	ra,136(sp)
    390a:	e122                	sd	s0,128(sp)
    390c:	fca6                	sd	s1,120(sp)
    390e:	f8ca                	sd	s2,112(sp)
    3910:	f4ce                	sd	s3,104(sp)
    3912:	f0d2                	sd	s4,96(sp)
    3914:	ecd6                	sd	s5,88(sp)
    3916:	e8da                	sd	s6,80(sp)
    3918:	e4de                	sd	s7,72(sp)
    391a:	0900                	add	s0,sp,144
    391c:	8b2a                	mv	s6,a0
  if(pipe(fds) != 0){
    391e:	fa040513          	add	a0,s0,-96
    3922:	59c010ef          	jal	4ebe <pipe>
    3926:	e919                	bnez	a0,393c <sbrkfail+0x36>
    3928:	8aaa                	mv	s5,a0
    392a:	f7040493          	add	s1,s0,-144
    392e:	f9840993          	add	s3,s0,-104
    3932:	8926                	mv	s2,s1
    if(pids[i] != -1) {
    3934:	5a7d                	li	s4,-1
      if(scratch == '0')
    3936:	03000b93          	li	s7,48
    393a:	a08d                	j	399c <sbrkfail+0x96>
    printf("%s: pipe() failed\n", s);
    393c:	85da                	mv	a1,s6
    393e:	00002517          	auipc	a0,0x2
    3942:	56250513          	add	a0,a0,1378 # 5ea0 <malloc+0xace>
    3946:	1d9010ef          	jal	531e <printf>
    exit(1);
    394a:	4505                	li	a0,1
    394c:	562010ef          	jal	4eae <exit>
      if (sbrk(BIG - (uint64)sbrk(0)) ==  (char*)SBRK_ERROR)
    3950:	48a010ef          	jal	4dda <sbrk>
    3954:	064007b7          	lui	a5,0x6400
    3958:	40a7853b          	subw	a0,a5,a0
    395c:	47e010ef          	jal	4dda <sbrk>
    3960:	57fd                	li	a5,-1
    3962:	02f50063          	beq	a0,a5,3982 <sbrkfail+0x7c>
        write(fds[1], "1", 1);
    3966:	4605                	li	a2,1
    3968:	00004597          	auipc	a1,0x4
    396c:	e0058593          	add	a1,a1,-512 # 7768 <malloc+0x2396>
    3970:	fa442503          	lw	a0,-92(s0)
    3974:	55a010ef          	jal	4ece <write>
      for(;;) pause(1000);
    3978:	3e800513          	li	a0,1000
    397c:	5c2010ef          	jal	4f3e <pause>
    3980:	bfe5                	j	3978 <sbrkfail+0x72>
        write(fds[1], "0", 1);
    3982:	4605                	li	a2,1
    3984:	00003597          	auipc	a1,0x3
    3988:	66c58593          	add	a1,a1,1644 # 6ff0 <malloc+0x1c1e>
    398c:	fa442503          	lw	a0,-92(s0)
    3990:	53e010ef          	jal	4ece <write>
    3994:	b7d5                	j	3978 <sbrkfail+0x72>
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    3996:	0911                	add	s2,s2,4
    3998:	03390663          	beq	s2,s3,39c4 <sbrkfail+0xbe>
    if((pids[i] = fork()) == 0){
    399c:	50a010ef          	jal	4ea6 <fork>
    39a0:	00a92023          	sw	a0,0(s2)
    39a4:	d555                	beqz	a0,3950 <sbrkfail+0x4a>
    if(pids[i] != -1) {
    39a6:	ff4508e3          	beq	a0,s4,3996 <sbrkfail+0x90>
      read(fds[0], &scratch, 1);
    39aa:	4605                	li	a2,1
    39ac:	f9f40593          	add	a1,s0,-97
    39b0:	fa042503          	lw	a0,-96(s0)
    39b4:	512010ef          	jal	4ec6 <read>
      if(scratch == '0')
    39b8:	f9f44783          	lbu	a5,-97(s0)
    39bc:	fd779de3          	bne	a5,s7,3996 <sbrkfail+0x90>
        failed = 1;
    39c0:	4a85                	li	s5,1
    39c2:	bfd1                	j	3996 <sbrkfail+0x90>
  if(!failed) {
    39c4:	000a8863          	beqz	s5,39d4 <sbrkfail+0xce>
  c = sbrk(PGSIZE);
    39c8:	6505                	lui	a0,0x1
    39ca:	410010ef          	jal	4dda <sbrk>
    39ce:	8a2a                	mv	s4,a0
    if(pids[i] == -1)
    39d0:	597d                	li	s2,-1
    39d2:	a821                	j	39ea <sbrkfail+0xe4>
    printf("%s: no allocation failed; allocate more?\n", s);
    39d4:	85da                	mv	a1,s6
    39d6:	00003517          	auipc	a0,0x3
    39da:	62250513          	add	a0,a0,1570 # 6ff8 <malloc+0x1c26>
    39de:	141010ef          	jal	531e <printf>
    39e2:	b7dd                	j	39c8 <sbrkfail+0xc2>
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    39e4:	0491                	add	s1,s1,4
    39e6:	01348b63          	beq	s1,s3,39fc <sbrkfail+0xf6>
    if(pids[i] == -1)
    39ea:	4088                	lw	a0,0(s1)
    39ec:	ff250ce3          	beq	a0,s2,39e4 <sbrkfail+0xde>
    kill(pids[i]);
    39f0:	4ee010ef          	jal	4ede <kill>
    wait(0);
    39f4:	4501                	li	a0,0
    39f6:	4c0010ef          	jal	4eb6 <wait>
    39fa:	b7ed                	j	39e4 <sbrkfail+0xde>
  if(c == (char*)SBRK_ERROR){
    39fc:	57fd                	li	a5,-1
    39fe:	02fa0a63          	beq	s4,a5,3a32 <sbrkfail+0x12c>
  pid = fork();
    3a02:	4a4010ef          	jal	4ea6 <fork>
  if(pid < 0){
    3a06:	04054063          	bltz	a0,3a46 <sbrkfail+0x140>
  if(pid == 0){
    3a0a:	e939                	bnez	a0,3a60 <sbrkfail+0x15a>
    a = sbrk(10*BIG);
    3a0c:	3e800537          	lui	a0,0x3e800
    3a10:	3ca010ef          	jal	4dda <sbrk>
    if(a == (char*)SBRK_ERROR){
    3a14:	57fd                	li	a5,-1
    3a16:	04f50263          	beq	a0,a5,3a5a <sbrkfail+0x154>
    printf("%s: allocate a lot of memory succeeded %d\n", s, 10*BIG);
    3a1a:	3e800637          	lui	a2,0x3e800
    3a1e:	85da                	mv	a1,s6
    3a20:	00003517          	auipc	a0,0x3
    3a24:	62850513          	add	a0,a0,1576 # 7048 <malloc+0x1c76>
    3a28:	0f7010ef          	jal	531e <printf>
    exit(1);
    3a2c:	4505                	li	a0,1
    3a2e:	480010ef          	jal	4eae <exit>
    printf("%s: failed sbrk leaked memory\n", s);
    3a32:	85da                	mv	a1,s6
    3a34:	00003517          	auipc	a0,0x3
    3a38:	5f450513          	add	a0,a0,1524 # 7028 <malloc+0x1c56>
    3a3c:	0e3010ef          	jal	531e <printf>
    exit(1);
    3a40:	4505                	li	a0,1
    3a42:	46c010ef          	jal	4eae <exit>
    printf("%s: fork failed\n", s);
    3a46:	85da                	mv	a1,s6
    3a48:	00002517          	auipc	a0,0x2
    3a4c:	35050513          	add	a0,a0,848 # 5d98 <malloc+0x9c6>
    3a50:	0cf010ef          	jal	531e <printf>
    exit(1);
    3a54:	4505                	li	a0,1
    3a56:	458010ef          	jal	4eae <exit>
      exit(0);
    3a5a:	4501                	li	a0,0
    3a5c:	452010ef          	jal	4eae <exit>
  wait(&xstatus);
    3a60:	fac40513          	add	a0,s0,-84
    3a64:	452010ef          	jal	4eb6 <wait>
  if(xstatus != 0)
    3a68:	fac42783          	lw	a5,-84(s0)
    3a6c:	ef81                	bnez	a5,3a84 <sbrkfail+0x17e>
}
    3a6e:	60aa                	ld	ra,136(sp)
    3a70:	640a                	ld	s0,128(sp)
    3a72:	74e6                	ld	s1,120(sp)
    3a74:	7946                	ld	s2,112(sp)
    3a76:	79a6                	ld	s3,104(sp)
    3a78:	7a06                	ld	s4,96(sp)
    3a7a:	6ae6                	ld	s5,88(sp)
    3a7c:	6b46                	ld	s6,80(sp)
    3a7e:	6ba6                	ld	s7,72(sp)
    3a80:	6149                	add	sp,sp,144
    3a82:	8082                	ret
    exit(1);
    3a84:	4505                	li	a0,1
    3a86:	428010ef          	jal	4eae <exit>

0000000000003a8a <mem>:
{
    3a8a:	7139                	add	sp,sp,-64
    3a8c:	fc06                	sd	ra,56(sp)
    3a8e:	f822                	sd	s0,48(sp)
    3a90:	f426                	sd	s1,40(sp)
    3a92:	f04a                	sd	s2,32(sp)
    3a94:	ec4e                	sd	s3,24(sp)
    3a96:	0080                	add	s0,sp,64
    3a98:	89aa                	mv	s3,a0
  if((pid = fork()) == 0){
    3a9a:	40c010ef          	jal	4ea6 <fork>
    m1 = 0;
    3a9e:	4481                	li	s1,0
    while((m2 = malloc(10001)) != 0){
    3aa0:	6909                	lui	s2,0x2
    3aa2:	71190913          	add	s2,s2,1809 # 2711 <fourteen+0x97>
  if((pid = fork()) == 0){
    3aa6:	cd11                	beqz	a0,3ac2 <mem+0x38>
    wait(&xstatus);
    3aa8:	fcc40513          	add	a0,s0,-52
    3aac:	40a010ef          	jal	4eb6 <wait>
    if(xstatus == -1){
    3ab0:	fcc42503          	lw	a0,-52(s0)
    3ab4:	57fd                	li	a5,-1
    3ab6:	04f50363          	beq	a0,a5,3afc <mem+0x72>
    exit(xstatus);
    3aba:	3f4010ef          	jal	4eae <exit>
      *(char**)m2 = m1;
    3abe:	e104                	sd	s1,0(a0)
      m1 = m2;
    3ac0:	84aa                	mv	s1,a0
    while((m2 = malloc(10001)) != 0){
    3ac2:	854a                	mv	a0,s2
    3ac4:	10f010ef          	jal	53d2 <malloc>
    3ac8:	f97d                	bnez	a0,3abe <mem+0x34>
    while(m1){
    3aca:	c491                	beqz	s1,3ad6 <mem+0x4c>
      m2 = *(char**)m1;
    3acc:	8526                	mv	a0,s1
    3ace:	6084                	ld	s1,0(s1)
      free(m1);
    3ad0:	081010ef          	jal	5350 <free>
    while(m1){
    3ad4:	fce5                	bnez	s1,3acc <mem+0x42>
    m1 = malloc(1024*20);
    3ad6:	6515                	lui	a0,0x5
    3ad8:	0fb010ef          	jal	53d2 <malloc>
    if(m1 == 0){
    3adc:	c511                	beqz	a0,3ae8 <mem+0x5e>
    free(m1);
    3ade:	073010ef          	jal	5350 <free>
    exit(0);
    3ae2:	4501                	li	a0,0
    3ae4:	3ca010ef          	jal	4eae <exit>
      printf("%s: couldn't allocate mem?!!\n", s);
    3ae8:	85ce                	mv	a1,s3
    3aea:	00003517          	auipc	a0,0x3
    3aee:	58e50513          	add	a0,a0,1422 # 7078 <malloc+0x1ca6>
    3af2:	02d010ef          	jal	531e <printf>
      exit(1);
    3af6:	4505                	li	a0,1
    3af8:	3b6010ef          	jal	4eae <exit>
      exit(0);
    3afc:	4501                	li	a0,0
    3afe:	3b0010ef          	jal	4eae <exit>

0000000000003b02 <sharedfd>:
{
    3b02:	7159                	add	sp,sp,-112
    3b04:	f486                	sd	ra,104(sp)
    3b06:	f0a2                	sd	s0,96(sp)
    3b08:	e0d2                	sd	s4,64(sp)
    3b0a:	1880                	add	s0,sp,112
    3b0c:	8a2a                	mv	s4,a0
  unlink("sharedfd");
    3b0e:	00003517          	auipc	a0,0x3
    3b12:	58a50513          	add	a0,a0,1418 # 7098 <malloc+0x1cc6>
    3b16:	3e8010ef          	jal	4efe <unlink>
  fd = open("sharedfd", O_CREATE|O_RDWR);
    3b1a:	20200593          	li	a1,514
    3b1e:	00003517          	auipc	a0,0x3
    3b22:	57a50513          	add	a0,a0,1402 # 7098 <malloc+0x1cc6>
    3b26:	3c8010ef          	jal	4eee <open>
  if(fd < 0){
    3b2a:	04054863          	bltz	a0,3b7a <sharedfd+0x78>
    3b2e:	eca6                	sd	s1,88(sp)
    3b30:	e8ca                	sd	s2,80(sp)
    3b32:	e4ce                	sd	s3,72(sp)
    3b34:	fc56                	sd	s5,56(sp)
    3b36:	f85a                	sd	s6,48(sp)
    3b38:	f45e                	sd	s7,40(sp)
    3b3a:	892a                	mv	s2,a0
  pid = fork();
    3b3c:	36a010ef          	jal	4ea6 <fork>
    3b40:	89aa                	mv	s3,a0
  memset(buf, pid==0?'c':'p', sizeof(buf));
    3b42:	07000593          	li	a1,112
    3b46:	e119                	bnez	a0,3b4c <sharedfd+0x4a>
    3b48:	06300593          	li	a1,99
    3b4c:	4629                	li	a2,10
    3b4e:	fa040513          	add	a0,s0,-96
    3b52:	0aa010ef          	jal	4bfc <memset>
    3b56:	3e800493          	li	s1,1000
    if(write(fd, buf, sizeof(buf)) != sizeof(buf)){
    3b5a:	4629                	li	a2,10
    3b5c:	fa040593          	add	a1,s0,-96
    3b60:	854a                	mv	a0,s2
    3b62:	36c010ef          	jal	4ece <write>
    3b66:	47a9                	li	a5,10
    3b68:	02f51963          	bne	a0,a5,3b9a <sharedfd+0x98>
  for(i = 0; i < N; i++){
    3b6c:	34fd                	addw	s1,s1,-1
    3b6e:	f4f5                	bnez	s1,3b5a <sharedfd+0x58>
  if(pid == 0) {
    3b70:	02099f63          	bnez	s3,3bae <sharedfd+0xac>
    exit(0);
    3b74:	4501                	li	a0,0
    3b76:	338010ef          	jal	4eae <exit>
    3b7a:	eca6                	sd	s1,88(sp)
    3b7c:	e8ca                	sd	s2,80(sp)
    3b7e:	e4ce                	sd	s3,72(sp)
    3b80:	fc56                	sd	s5,56(sp)
    3b82:	f85a                	sd	s6,48(sp)
    3b84:	f45e                	sd	s7,40(sp)
    printf("%s: cannot open sharedfd for writing", s);
    3b86:	85d2                	mv	a1,s4
    3b88:	00003517          	auipc	a0,0x3
    3b8c:	52050513          	add	a0,a0,1312 # 70a8 <malloc+0x1cd6>
    3b90:	78e010ef          	jal	531e <printf>
    exit(1);
    3b94:	4505                	li	a0,1
    3b96:	318010ef          	jal	4eae <exit>
      printf("%s: write sharedfd failed\n", s);
    3b9a:	85d2                	mv	a1,s4
    3b9c:	00003517          	auipc	a0,0x3
    3ba0:	53450513          	add	a0,a0,1332 # 70d0 <malloc+0x1cfe>
    3ba4:	77a010ef          	jal	531e <printf>
      exit(1);
    3ba8:	4505                	li	a0,1
    3baa:	304010ef          	jal	4eae <exit>
    wait(&xstatus);
    3bae:	f9c40513          	add	a0,s0,-100
    3bb2:	304010ef          	jal	4eb6 <wait>
    if(xstatus != 0)
    3bb6:	f9c42983          	lw	s3,-100(s0)
    3bba:	00098563          	beqz	s3,3bc4 <sharedfd+0xc2>
      exit(xstatus);
    3bbe:	854e                	mv	a0,s3
    3bc0:	2ee010ef          	jal	4eae <exit>
  close(fd);
    3bc4:	854a                	mv	a0,s2
    3bc6:	310010ef          	jal	4ed6 <close>
  fd = open("sharedfd", 0);
    3bca:	4581                	li	a1,0
    3bcc:	00003517          	auipc	a0,0x3
    3bd0:	4cc50513          	add	a0,a0,1228 # 7098 <malloc+0x1cc6>
    3bd4:	31a010ef          	jal	4eee <open>
    3bd8:	8baa                	mv	s7,a0
  nc = np = 0;
    3bda:	8ace                	mv	s5,s3
  if(fd < 0){
    3bdc:	02054363          	bltz	a0,3c02 <sharedfd+0x100>
    3be0:	faa40913          	add	s2,s0,-86
      if(buf[i] == 'c')
    3be4:	06300493          	li	s1,99
      if(buf[i] == 'p')
    3be8:	07000b13          	li	s6,112
  while((n = read(fd, buf, sizeof(buf))) > 0){
    3bec:	4629                	li	a2,10
    3bee:	fa040593          	add	a1,s0,-96
    3bf2:	855e                	mv	a0,s7
    3bf4:	2d2010ef          	jal	4ec6 <read>
    3bf8:	02a05b63          	blez	a0,3c2e <sharedfd+0x12c>
    3bfc:	fa040793          	add	a5,s0,-96
    3c00:	a839                	j	3c1e <sharedfd+0x11c>
    printf("%s: cannot open sharedfd for reading\n", s);
    3c02:	85d2                	mv	a1,s4
    3c04:	00003517          	auipc	a0,0x3
    3c08:	4ec50513          	add	a0,a0,1260 # 70f0 <malloc+0x1d1e>
    3c0c:	712010ef          	jal	531e <printf>
    exit(1);
    3c10:	4505                	li	a0,1
    3c12:	29c010ef          	jal	4eae <exit>
        nc++;
    3c16:	2985                	addw	s3,s3,1
    for(i = 0; i < sizeof(buf); i++){
    3c18:	0785                	add	a5,a5,1 # 6400001 <base+0x63f1349>
    3c1a:	fd2789e3          	beq	a5,s2,3bec <sharedfd+0xea>
      if(buf[i] == 'c')
    3c1e:	0007c703          	lbu	a4,0(a5)
    3c22:	fe970ae3          	beq	a4,s1,3c16 <sharedfd+0x114>
      if(buf[i] == 'p')
    3c26:	ff6719e3          	bne	a4,s6,3c18 <sharedfd+0x116>
        np++;
    3c2a:	2a85                	addw	s5,s5,1
    3c2c:	b7f5                	j	3c18 <sharedfd+0x116>
  close(fd);
    3c2e:	855e                	mv	a0,s7
    3c30:	2a6010ef          	jal	4ed6 <close>
  unlink("sharedfd");
    3c34:	00003517          	auipc	a0,0x3
    3c38:	46450513          	add	a0,a0,1124 # 7098 <malloc+0x1cc6>
    3c3c:	2c2010ef          	jal	4efe <unlink>
  if(nc == N*SZ && np == N*SZ){
    3c40:	6789                	lui	a5,0x2
    3c42:	71078793          	add	a5,a5,1808 # 2710 <fourteen+0x96>
    3c46:	00f99763          	bne	s3,a5,3c54 <sharedfd+0x152>
    3c4a:	6789                	lui	a5,0x2
    3c4c:	71078793          	add	a5,a5,1808 # 2710 <fourteen+0x96>
    3c50:	00fa8c63          	beq	s5,a5,3c68 <sharedfd+0x166>
    printf("%s: nc/np test fails\n", s);
    3c54:	85d2                	mv	a1,s4
    3c56:	00003517          	auipc	a0,0x3
    3c5a:	4c250513          	add	a0,a0,1218 # 7118 <malloc+0x1d46>
    3c5e:	6c0010ef          	jal	531e <printf>
    exit(1);
    3c62:	4505                	li	a0,1
    3c64:	24a010ef          	jal	4eae <exit>
    exit(0);
    3c68:	4501                	li	a0,0
    3c6a:	244010ef          	jal	4eae <exit>

0000000000003c6e <fourfiles>:
{
    3c6e:	7135                	add	sp,sp,-160
    3c70:	ed06                	sd	ra,152(sp)
    3c72:	e922                	sd	s0,144(sp)
    3c74:	e526                	sd	s1,136(sp)
    3c76:	e14a                	sd	s2,128(sp)
    3c78:	fcce                	sd	s3,120(sp)
    3c7a:	f8d2                	sd	s4,112(sp)
    3c7c:	f4d6                	sd	s5,104(sp)
    3c7e:	f0da                	sd	s6,96(sp)
    3c80:	ecde                	sd	s7,88(sp)
    3c82:	e8e2                	sd	s8,80(sp)
    3c84:	e4e6                	sd	s9,72(sp)
    3c86:	e0ea                	sd	s10,64(sp)
    3c88:	fc6e                	sd	s11,56(sp)
    3c8a:	1100                	add	s0,sp,160
    3c8c:	8caa                	mv	s9,a0
  char *names[] = { "f0", "f1", "f2", "f3" };
    3c8e:	00003797          	auipc	a5,0x3
    3c92:	4a278793          	add	a5,a5,1186 # 7130 <malloc+0x1d5e>
    3c96:	f6f43823          	sd	a5,-144(s0)
    3c9a:	00003797          	auipc	a5,0x3
    3c9e:	49e78793          	add	a5,a5,1182 # 7138 <malloc+0x1d66>
    3ca2:	f6f43c23          	sd	a5,-136(s0)
    3ca6:	00003797          	auipc	a5,0x3
    3caa:	49a78793          	add	a5,a5,1178 # 7140 <malloc+0x1d6e>
    3cae:	f8f43023          	sd	a5,-128(s0)
    3cb2:	00003797          	auipc	a5,0x3
    3cb6:	49678793          	add	a5,a5,1174 # 7148 <malloc+0x1d76>
    3cba:	f8f43423          	sd	a5,-120(s0)
  for(pi = 0; pi < NCHILD; pi++){
    3cbe:	f7040b93          	add	s7,s0,-144
  char *names[] = { "f0", "f1", "f2", "f3" };
    3cc2:	895e                	mv	s2,s7
  for(pi = 0; pi < NCHILD; pi++){
    3cc4:	4481                	li	s1,0
    3cc6:	4a11                	li	s4,4
    fname = names[pi];
    3cc8:	00093983          	ld	s3,0(s2)
    unlink(fname);
    3ccc:	854e                	mv	a0,s3
    3cce:	230010ef          	jal	4efe <unlink>
    pid = fork();
    3cd2:	1d4010ef          	jal	4ea6 <fork>
    if(pid < 0){
    3cd6:	02054e63          	bltz	a0,3d12 <fourfiles+0xa4>
    if(pid == 0){
    3cda:	c531                	beqz	a0,3d26 <fourfiles+0xb8>
  for(pi = 0; pi < NCHILD; pi++){
    3cdc:	2485                	addw	s1,s1,1
    3cde:	0921                	add	s2,s2,8
    3ce0:	ff4494e3          	bne	s1,s4,3cc8 <fourfiles+0x5a>
    3ce4:	4491                	li	s1,4
    wait(&xstatus);
    3ce6:	f6c40513          	add	a0,s0,-148
    3cea:	1cc010ef          	jal	4eb6 <wait>
    if(xstatus != 0)
    3cee:	f6c42a83          	lw	s5,-148(s0)
    3cf2:	0a0a9463          	bnez	s5,3d9a <fourfiles+0x12c>
  for(pi = 0; pi < NCHILD; pi++){
    3cf6:	34fd                	addw	s1,s1,-1
    3cf8:	f4fd                	bnez	s1,3ce6 <fourfiles+0x78>
    3cfa:	03000b13          	li	s6,48
    while((n = read(fd, buf, sizeof(buf))) > 0){
    3cfe:	00008a17          	auipc	s4,0x8
    3d02:	fbaa0a13          	add	s4,s4,-70 # bcb8 <buf>
    if(total != N*SZ){
    3d06:	6d05                	lui	s10,0x1
    3d08:	770d0d13          	add	s10,s10,1904 # 1770 <forkfork+0x1e>
  for(i = 0; i < NCHILD; i++){
    3d0c:	03400d93          	li	s11,52
    3d10:	a0ed                	j	3dfa <fourfiles+0x18c>
      printf("%s: fork failed\n", s);
    3d12:	85e6                	mv	a1,s9
    3d14:	00002517          	auipc	a0,0x2
    3d18:	08450513          	add	a0,a0,132 # 5d98 <malloc+0x9c6>
    3d1c:	602010ef          	jal	531e <printf>
      exit(1);
    3d20:	4505                	li	a0,1
    3d22:	18c010ef          	jal	4eae <exit>
      fd = open(fname, O_CREATE | O_RDWR);
    3d26:	20200593          	li	a1,514
    3d2a:	854e                	mv	a0,s3
    3d2c:	1c2010ef          	jal	4eee <open>
    3d30:	892a                	mv	s2,a0
      if(fd < 0){
    3d32:	04054163          	bltz	a0,3d74 <fourfiles+0x106>
      memset(buf, '0'+pi, SZ);
    3d36:	1f400613          	li	a2,500
    3d3a:	0304859b          	addw	a1,s1,48
    3d3e:	00008517          	auipc	a0,0x8
    3d42:	f7a50513          	add	a0,a0,-134 # bcb8 <buf>
    3d46:	6b7000ef          	jal	4bfc <memset>
    3d4a:	44b1                	li	s1,12
        if((n = write(fd, buf, SZ)) != SZ){
    3d4c:	00008997          	auipc	s3,0x8
    3d50:	f6c98993          	add	s3,s3,-148 # bcb8 <buf>
    3d54:	1f400613          	li	a2,500
    3d58:	85ce                	mv	a1,s3
    3d5a:	854a                	mv	a0,s2
    3d5c:	172010ef          	jal	4ece <write>
    3d60:	85aa                	mv	a1,a0
    3d62:	1f400793          	li	a5,500
    3d66:	02f51163          	bne	a0,a5,3d88 <fourfiles+0x11a>
      for(i = 0; i < N; i++){
    3d6a:	34fd                	addw	s1,s1,-1
    3d6c:	f4e5                	bnez	s1,3d54 <fourfiles+0xe6>
      exit(0);
    3d6e:	4501                	li	a0,0
    3d70:	13e010ef          	jal	4eae <exit>
        printf("%s: create failed\n", s);
    3d74:	85e6                	mv	a1,s9
    3d76:	00002517          	auipc	a0,0x2
    3d7a:	0ba50513          	add	a0,a0,186 # 5e30 <malloc+0xa5e>
    3d7e:	5a0010ef          	jal	531e <printf>
        exit(1);
    3d82:	4505                	li	a0,1
    3d84:	12a010ef          	jal	4eae <exit>
          printf("write failed %d\n", n);
    3d88:	00003517          	auipc	a0,0x3
    3d8c:	3c850513          	add	a0,a0,968 # 7150 <malloc+0x1d7e>
    3d90:	58e010ef          	jal	531e <printf>
          exit(1);
    3d94:	4505                	li	a0,1
    3d96:	118010ef          	jal	4eae <exit>
      exit(xstatus);
    3d9a:	8556                	mv	a0,s5
    3d9c:	112010ef          	jal	4eae <exit>
          printf("%s: wrong char\n", s);
    3da0:	85e6                	mv	a1,s9
    3da2:	00003517          	auipc	a0,0x3
    3da6:	3c650513          	add	a0,a0,966 # 7168 <malloc+0x1d96>
    3daa:	574010ef          	jal	531e <printf>
          exit(1);
    3dae:	4505                	li	a0,1
    3db0:	0fe010ef          	jal	4eae <exit>
      total += n;
    3db4:	00a9093b          	addw	s2,s2,a0
    while((n = read(fd, buf, sizeof(buf))) > 0){
    3db8:	660d                	lui	a2,0x3
    3dba:	85d2                	mv	a1,s4
    3dbc:	854e                	mv	a0,s3
    3dbe:	108010ef          	jal	4ec6 <read>
    3dc2:	02a05063          	blez	a0,3de2 <fourfiles+0x174>
    3dc6:	00008797          	auipc	a5,0x8
    3dca:	ef278793          	add	a5,a5,-270 # bcb8 <buf>
    3dce:	00f506b3          	add	a3,a0,a5
        if(buf[j] != '0'+i){
    3dd2:	0007c703          	lbu	a4,0(a5)
    3dd6:	fc9715e3          	bne	a4,s1,3da0 <fourfiles+0x132>
      for(j = 0; j < n; j++){
    3dda:	0785                	add	a5,a5,1
    3ddc:	fed79be3          	bne	a5,a3,3dd2 <fourfiles+0x164>
    3de0:	bfd1                	j	3db4 <fourfiles+0x146>
    close(fd);
    3de2:	854e                	mv	a0,s3
    3de4:	0f2010ef          	jal	4ed6 <close>
    if(total != N*SZ){
    3de8:	03a91463          	bne	s2,s10,3e10 <fourfiles+0x1a2>
    unlink(fname);
    3dec:	8562                	mv	a0,s8
    3dee:	110010ef          	jal	4efe <unlink>
  for(i = 0; i < NCHILD; i++){
    3df2:	0ba1                	add	s7,s7,8
    3df4:	2b05                	addw	s6,s6,1
    3df6:	03bb0763          	beq	s6,s11,3e24 <fourfiles+0x1b6>
    fname = names[i];
    3dfa:	000bbc03          	ld	s8,0(s7)
    fd = open(fname, 0);
    3dfe:	4581                	li	a1,0
    3e00:	8562                	mv	a0,s8
    3e02:	0ec010ef          	jal	4eee <open>
    3e06:	89aa                	mv	s3,a0
    total = 0;
    3e08:	8956                	mv	s2,s5
        if(buf[j] != '0'+i){
    3e0a:	000b049b          	sext.w	s1,s6
    while((n = read(fd, buf, sizeof(buf))) > 0){
    3e0e:	b76d                	j	3db8 <fourfiles+0x14a>
      printf("wrong length %d\n", total);
    3e10:	85ca                	mv	a1,s2
    3e12:	00003517          	auipc	a0,0x3
    3e16:	36650513          	add	a0,a0,870 # 7178 <malloc+0x1da6>
    3e1a:	504010ef          	jal	531e <printf>
      exit(1);
    3e1e:	4505                	li	a0,1
    3e20:	08e010ef          	jal	4eae <exit>
}
    3e24:	60ea                	ld	ra,152(sp)
    3e26:	644a                	ld	s0,144(sp)
    3e28:	64aa                	ld	s1,136(sp)
    3e2a:	690a                	ld	s2,128(sp)
    3e2c:	79e6                	ld	s3,120(sp)
    3e2e:	7a46                	ld	s4,112(sp)
    3e30:	7aa6                	ld	s5,104(sp)
    3e32:	7b06                	ld	s6,96(sp)
    3e34:	6be6                	ld	s7,88(sp)
    3e36:	6c46                	ld	s8,80(sp)
    3e38:	6ca6                	ld	s9,72(sp)
    3e3a:	6d06                	ld	s10,64(sp)
    3e3c:	7de2                	ld	s11,56(sp)
    3e3e:	610d                	add	sp,sp,160
    3e40:	8082                	ret

0000000000003e42 <concreate>:
{
    3e42:	7135                	add	sp,sp,-160
    3e44:	ed06                	sd	ra,152(sp)
    3e46:	e922                	sd	s0,144(sp)
    3e48:	e526                	sd	s1,136(sp)
    3e4a:	e14a                	sd	s2,128(sp)
    3e4c:	fcce                	sd	s3,120(sp)
    3e4e:	f8d2                	sd	s4,112(sp)
    3e50:	f4d6                	sd	s5,104(sp)
    3e52:	f0da                	sd	s6,96(sp)
    3e54:	ecde                	sd	s7,88(sp)
    3e56:	1100                	add	s0,sp,160
    3e58:	89aa                	mv	s3,a0
  file[0] = 'C';
    3e5a:	04300793          	li	a5,67
    3e5e:	faf40423          	sb	a5,-88(s0)
  file[2] = '\0';
    3e62:	fa040523          	sb	zero,-86(s0)
  for(i = 0; i < N; i++){
    3e66:	4901                	li	s2,0
    if(pid && (i % 3) == 1){
    3e68:	4b0d                	li	s6,3
    3e6a:	4a85                	li	s5,1
      link("C0", file);
    3e6c:	00003b97          	auipc	s7,0x3
    3e70:	324b8b93          	add	s7,s7,804 # 7190 <malloc+0x1dbe>
  for(i = 0; i < N; i++){
    3e74:	02800a13          	li	s4,40
    3e78:	a41d                	j	409e <concreate+0x25c>
      link("C0", file);
    3e7a:	fa840593          	add	a1,s0,-88
    3e7e:	855e                	mv	a0,s7
    3e80:	08e010ef          	jal	4f0e <link>
    if(pid == 0) {
    3e84:	a411                	j	4088 <concreate+0x246>
    } else if(pid == 0 && (i % 5) == 1){
    3e86:	4795                	li	a5,5
    3e88:	02f9693b          	remw	s2,s2,a5
    3e8c:	4785                	li	a5,1
    3e8e:	02f90563          	beq	s2,a5,3eb8 <concreate+0x76>
      fd = open(file, O_CREATE | O_RDWR);
    3e92:	20200593          	li	a1,514
    3e96:	fa840513          	add	a0,s0,-88
    3e9a:	054010ef          	jal	4eee <open>
      if(fd < 0){
    3e9e:	1e055063          	bgez	a0,407e <concreate+0x23c>
        printf("concreate create %s failed\n", file);
    3ea2:	fa840593          	add	a1,s0,-88
    3ea6:	00003517          	auipc	a0,0x3
    3eaa:	2f250513          	add	a0,a0,754 # 7198 <malloc+0x1dc6>
    3eae:	470010ef          	jal	531e <printf>
        exit(1);
    3eb2:	4505                	li	a0,1
    3eb4:	7fb000ef          	jal	4eae <exit>
      link("C0", file);
    3eb8:	fa840593          	add	a1,s0,-88
    3ebc:	00003517          	auipc	a0,0x3
    3ec0:	2d450513          	add	a0,a0,724 # 7190 <malloc+0x1dbe>
    3ec4:	04a010ef          	jal	4f0e <link>
      exit(0);
    3ec8:	4501                	li	a0,0
    3eca:	7e5000ef          	jal	4eae <exit>
        exit(1);
    3ece:	4505                	li	a0,1
    3ed0:	7df000ef          	jal	4eae <exit>
  memset(fa, 0, sizeof(fa));
    3ed4:	02800613          	li	a2,40
    3ed8:	4581                	li	a1,0
    3eda:	f8040513          	add	a0,s0,-128
    3ede:	51f000ef          	jal	4bfc <memset>
  fd = open(".", 0);
    3ee2:	4581                	li	a1,0
    3ee4:	00002517          	auipc	a0,0x2
    3ee8:	d0c50513          	add	a0,a0,-756 # 5bf0 <malloc+0x81e>
    3eec:	002010ef          	jal	4eee <open>
    3ef0:	892a                	mv	s2,a0
  n = 0;
    3ef2:	8aa6                	mv	s5,s1
    if(de.name[0] == 'C' && de.name[2] == '\0'){
    3ef4:	04300a13          	li	s4,67
      if(i < 0 || i >= sizeof(fa)){
    3ef8:	02700b13          	li	s6,39
      fa[i] = 1;
    3efc:	4b85                	li	s7,1
  while(read(fd, &de, sizeof(de)) > 0){
    3efe:	4641                	li	a2,16
    3f00:	f7040593          	add	a1,s0,-144
    3f04:	854a                	mv	a0,s2
    3f06:	7c1000ef          	jal	4ec6 <read>
    3f0a:	06a05a63          	blez	a0,3f7e <concreate+0x13c>
    if(de.inum == 0)
    3f0e:	f7045783          	lhu	a5,-144(s0)
    3f12:	d7f5                	beqz	a5,3efe <concreate+0xbc>
    if(de.name[0] == 'C' && de.name[2] == '\0'){
    3f14:	f7244783          	lbu	a5,-142(s0)
    3f18:	ff4793e3          	bne	a5,s4,3efe <concreate+0xbc>
    3f1c:	f7444783          	lbu	a5,-140(s0)
    3f20:	fff9                	bnez	a5,3efe <concreate+0xbc>
      i = de.name[1] - '0';
    3f22:	f7344783          	lbu	a5,-141(s0)
    3f26:	fd07879b          	addw	a5,a5,-48
    3f2a:	0007871b          	sext.w	a4,a5
      if(i < 0 || i >= sizeof(fa)){
    3f2e:	02eb6063          	bltu	s6,a4,3f4e <concreate+0x10c>
      if(fa[i]){
    3f32:	fb070793          	add	a5,a4,-80
    3f36:	97a2                	add	a5,a5,s0
    3f38:	fd07c783          	lbu	a5,-48(a5)
    3f3c:	e78d                	bnez	a5,3f66 <concreate+0x124>
      fa[i] = 1;
    3f3e:	fb070793          	add	a5,a4,-80
    3f42:	00878733          	add	a4,a5,s0
    3f46:	fd770823          	sb	s7,-48(a4)
      n++;
    3f4a:	2a85                	addw	s5,s5,1
    3f4c:	bf4d                	j	3efe <concreate+0xbc>
        printf("%s: concreate weird file %s\n", s, de.name);
    3f4e:	f7240613          	add	a2,s0,-142
    3f52:	85ce                	mv	a1,s3
    3f54:	00003517          	auipc	a0,0x3
    3f58:	26450513          	add	a0,a0,612 # 71b8 <malloc+0x1de6>
    3f5c:	3c2010ef          	jal	531e <printf>
        exit(1);
    3f60:	4505                	li	a0,1
    3f62:	74d000ef          	jal	4eae <exit>
        printf("%s: concreate duplicate file %s\n", s, de.name);
    3f66:	f7240613          	add	a2,s0,-142
    3f6a:	85ce                	mv	a1,s3
    3f6c:	00003517          	auipc	a0,0x3
    3f70:	26c50513          	add	a0,a0,620 # 71d8 <malloc+0x1e06>
    3f74:	3aa010ef          	jal	531e <printf>
        exit(1);
    3f78:	4505                	li	a0,1
    3f7a:	735000ef          	jal	4eae <exit>
  close(fd);
    3f7e:	854a                	mv	a0,s2
    3f80:	757000ef          	jal	4ed6 <close>
  if(n != N){
    3f84:	02800793          	li	a5,40
    3f88:	00fa9763          	bne	s5,a5,3f96 <concreate+0x154>
    if(((i % 3) == 0 && pid == 0) ||
    3f8c:	4a8d                	li	s5,3
    3f8e:	4b05                	li	s6,1
  for(i = 0; i < N; i++){
    3f90:	02800a13          	li	s4,40
    3f94:	a079                	j	4022 <concreate+0x1e0>
    printf("%s: concreate not enough files in directory listing\n", s);
    3f96:	85ce                	mv	a1,s3
    3f98:	00003517          	auipc	a0,0x3
    3f9c:	26850513          	add	a0,a0,616 # 7200 <malloc+0x1e2e>
    3fa0:	37e010ef          	jal	531e <printf>
    exit(1);
    3fa4:	4505                	li	a0,1
    3fa6:	709000ef          	jal	4eae <exit>
      printf("%s: fork failed\n", s);
    3faa:	85ce                	mv	a1,s3
    3fac:	00002517          	auipc	a0,0x2
    3fb0:	dec50513          	add	a0,a0,-532 # 5d98 <malloc+0x9c6>
    3fb4:	36a010ef          	jal	531e <printf>
      exit(1);
    3fb8:	4505                	li	a0,1
    3fba:	6f5000ef          	jal	4eae <exit>
      close(open(file, 0));
    3fbe:	4581                	li	a1,0
    3fc0:	fa840513          	add	a0,s0,-88
    3fc4:	72b000ef          	jal	4eee <open>
    3fc8:	70f000ef          	jal	4ed6 <close>
      close(open(file, 0));
    3fcc:	4581                	li	a1,0
    3fce:	fa840513          	add	a0,s0,-88
    3fd2:	71d000ef          	jal	4eee <open>
    3fd6:	701000ef          	jal	4ed6 <close>
      close(open(file, 0));
    3fda:	4581                	li	a1,0
    3fdc:	fa840513          	add	a0,s0,-88
    3fe0:	70f000ef          	jal	4eee <open>
    3fe4:	6f3000ef          	jal	4ed6 <close>
      close(open(file, 0));
    3fe8:	4581                	li	a1,0
    3fea:	fa840513          	add	a0,s0,-88
    3fee:	701000ef          	jal	4eee <open>
    3ff2:	6e5000ef          	jal	4ed6 <close>
      close(open(file, 0));
    3ff6:	4581                	li	a1,0
    3ff8:	fa840513          	add	a0,s0,-88
    3ffc:	6f3000ef          	jal	4eee <open>
    4000:	6d7000ef          	jal	4ed6 <close>
      close(open(file, 0));
    4004:	4581                	li	a1,0
    4006:	fa840513          	add	a0,s0,-88
    400a:	6e5000ef          	jal	4eee <open>
    400e:	6c9000ef          	jal	4ed6 <close>
    if(pid == 0)
    4012:	06090363          	beqz	s2,4078 <concreate+0x236>
      wait(0);
    4016:	4501                	li	a0,0
    4018:	69f000ef          	jal	4eb6 <wait>
  for(i = 0; i < N; i++){
    401c:	2485                	addw	s1,s1,1
    401e:	0b448963          	beq	s1,s4,40d0 <concreate+0x28e>
    file[1] = '0' + i;
    4022:	0304879b          	addw	a5,s1,48
    4026:	faf404a3          	sb	a5,-87(s0)
    pid = fork();
    402a:	67d000ef          	jal	4ea6 <fork>
    402e:	892a                	mv	s2,a0
    if(pid < 0){
    4030:	f6054de3          	bltz	a0,3faa <concreate+0x168>
    if(((i % 3) == 0 && pid == 0) ||
    4034:	0354e73b          	remw	a4,s1,s5
    4038:	00a767b3          	or	a5,a4,a0
    403c:	2781                	sext.w	a5,a5
    403e:	d3c1                	beqz	a5,3fbe <concreate+0x17c>
    4040:	01671363          	bne	a4,s6,4046 <concreate+0x204>
       ((i % 3) == 1 && pid != 0)){
    4044:	fd2d                	bnez	a0,3fbe <concreate+0x17c>
      unlink(file);
    4046:	fa840513          	add	a0,s0,-88
    404a:	6b5000ef          	jal	4efe <unlink>
      unlink(file);
    404e:	fa840513          	add	a0,s0,-88
    4052:	6ad000ef          	jal	4efe <unlink>
      unlink(file);
    4056:	fa840513          	add	a0,s0,-88
    405a:	6a5000ef          	jal	4efe <unlink>
      unlink(file);
    405e:	fa840513          	add	a0,s0,-88
    4062:	69d000ef          	jal	4efe <unlink>
      unlink(file);
    4066:	fa840513          	add	a0,s0,-88
    406a:	695000ef          	jal	4efe <unlink>
      unlink(file);
    406e:	fa840513          	add	a0,s0,-88
    4072:	68d000ef          	jal	4efe <unlink>
    4076:	bf71                	j	4012 <concreate+0x1d0>
      exit(0);
    4078:	4501                	li	a0,0
    407a:	635000ef          	jal	4eae <exit>
      close(fd);
    407e:	659000ef          	jal	4ed6 <close>
    if(pid == 0) {
    4082:	b599                	j	3ec8 <concreate+0x86>
      close(fd);
    4084:	653000ef          	jal	4ed6 <close>
      wait(&xstatus);
    4088:	f6c40513          	add	a0,s0,-148
    408c:	62b000ef          	jal	4eb6 <wait>
      if(xstatus != 0)
    4090:	f6c42483          	lw	s1,-148(s0)
    4094:	e2049de3          	bnez	s1,3ece <concreate+0x8c>
  for(i = 0; i < N; i++){
    4098:	2905                	addw	s2,s2,1
    409a:	e3490de3          	beq	s2,s4,3ed4 <concreate+0x92>
    file[1] = '0' + i;
    409e:	0309079b          	addw	a5,s2,48
    40a2:	faf404a3          	sb	a5,-87(s0)
    unlink(file);
    40a6:	fa840513          	add	a0,s0,-88
    40aa:	655000ef          	jal	4efe <unlink>
    pid = fork();
    40ae:	5f9000ef          	jal	4ea6 <fork>
    if(pid && (i % 3) == 1){
    40b2:	dc050ae3          	beqz	a0,3e86 <concreate+0x44>
    40b6:	036967bb          	remw	a5,s2,s6
    40ba:	dd5780e3          	beq	a5,s5,3e7a <concreate+0x38>
      fd = open(file, O_CREATE | O_RDWR);
    40be:	20200593          	li	a1,514
    40c2:	fa840513          	add	a0,s0,-88
    40c6:	629000ef          	jal	4eee <open>
      if(fd < 0){
    40ca:	fa055de3          	bgez	a0,4084 <concreate+0x242>
    40ce:	bbd1                	j	3ea2 <concreate+0x60>
}
    40d0:	60ea                	ld	ra,152(sp)
    40d2:	644a                	ld	s0,144(sp)
    40d4:	64aa                	ld	s1,136(sp)
    40d6:	690a                	ld	s2,128(sp)
    40d8:	79e6                	ld	s3,120(sp)
    40da:	7a46                	ld	s4,112(sp)
    40dc:	7aa6                	ld	s5,104(sp)
    40de:	7b06                	ld	s6,96(sp)
    40e0:	6be6                	ld	s7,88(sp)
    40e2:	610d                	add	sp,sp,160
    40e4:	8082                	ret

00000000000040e6 <bigfile>:
{
    40e6:	7139                	add	sp,sp,-64
    40e8:	fc06                	sd	ra,56(sp)
    40ea:	f822                	sd	s0,48(sp)
    40ec:	f426                	sd	s1,40(sp)
    40ee:	f04a                	sd	s2,32(sp)
    40f0:	ec4e                	sd	s3,24(sp)
    40f2:	e852                	sd	s4,16(sp)
    40f4:	e456                	sd	s5,8(sp)
    40f6:	0080                	add	s0,sp,64
    40f8:	8aaa                	mv	s5,a0
  unlink("bigfile.dat");
    40fa:	00003517          	auipc	a0,0x3
    40fe:	13e50513          	add	a0,a0,318 # 7238 <malloc+0x1e66>
    4102:	5fd000ef          	jal	4efe <unlink>
  fd = open("bigfile.dat", O_CREATE | O_RDWR);
    4106:	20200593          	li	a1,514
    410a:	00003517          	auipc	a0,0x3
    410e:	12e50513          	add	a0,a0,302 # 7238 <malloc+0x1e66>
    4112:	5dd000ef          	jal	4eee <open>
    4116:	89aa                	mv	s3,a0
  for(i = 0; i < N; i++){
    4118:	4481                	li	s1,0
    memset(buf, i, SZ);
    411a:	00008917          	auipc	s2,0x8
    411e:	b9e90913          	add	s2,s2,-1122 # bcb8 <buf>
  for(i = 0; i < N; i++){
    4122:	4a51                	li	s4,20
  if(fd < 0){
    4124:	08054663          	bltz	a0,41b0 <bigfile+0xca>
    memset(buf, i, SZ);
    4128:	25800613          	li	a2,600
    412c:	85a6                	mv	a1,s1
    412e:	854a                	mv	a0,s2
    4130:	2cd000ef          	jal	4bfc <memset>
    if(write(fd, buf, SZ) != SZ){
    4134:	25800613          	li	a2,600
    4138:	85ca                	mv	a1,s2
    413a:	854e                	mv	a0,s3
    413c:	593000ef          	jal	4ece <write>
    4140:	25800793          	li	a5,600
    4144:	08f51063          	bne	a0,a5,41c4 <bigfile+0xde>
  for(i = 0; i < N; i++){
    4148:	2485                	addw	s1,s1,1
    414a:	fd449fe3          	bne	s1,s4,4128 <bigfile+0x42>
  close(fd);
    414e:	854e                	mv	a0,s3
    4150:	587000ef          	jal	4ed6 <close>
  fd = open("bigfile.dat", 0);
    4154:	4581                	li	a1,0
    4156:	00003517          	auipc	a0,0x3
    415a:	0e250513          	add	a0,a0,226 # 7238 <malloc+0x1e66>
    415e:	591000ef          	jal	4eee <open>
    4162:	8a2a                	mv	s4,a0
  total = 0;
    4164:	4981                	li	s3,0
  for(i = 0; ; i++){
    4166:	4481                	li	s1,0
    cc = read(fd, buf, SZ/2);
    4168:	00008917          	auipc	s2,0x8
    416c:	b5090913          	add	s2,s2,-1200 # bcb8 <buf>
  if(fd < 0){
    4170:	06054463          	bltz	a0,41d8 <bigfile+0xf2>
    cc = read(fd, buf, SZ/2);
    4174:	12c00613          	li	a2,300
    4178:	85ca                	mv	a1,s2
    417a:	8552                	mv	a0,s4
    417c:	54b000ef          	jal	4ec6 <read>
    if(cc < 0){
    4180:	06054663          	bltz	a0,41ec <bigfile+0x106>
    if(cc == 0)
    4184:	c155                	beqz	a0,4228 <bigfile+0x142>
    if(cc != SZ/2){
    4186:	12c00793          	li	a5,300
    418a:	06f51b63          	bne	a0,a5,4200 <bigfile+0x11a>
    if(buf[0] != i/2 || buf[SZ/2-1] != i/2){
    418e:	01f4d79b          	srlw	a5,s1,0x1f
    4192:	9fa5                	addw	a5,a5,s1
    4194:	4017d79b          	sraw	a5,a5,0x1
    4198:	00094703          	lbu	a4,0(s2)
    419c:	06f71c63          	bne	a4,a5,4214 <bigfile+0x12e>
    41a0:	12b94703          	lbu	a4,299(s2)
    41a4:	06f71863          	bne	a4,a5,4214 <bigfile+0x12e>
    total += cc;
    41a8:	12c9899b          	addw	s3,s3,300
  for(i = 0; ; i++){
    41ac:	2485                	addw	s1,s1,1
    cc = read(fd, buf, SZ/2);
    41ae:	b7d9                	j	4174 <bigfile+0x8e>
    printf("%s: cannot create bigfile", s);
    41b0:	85d6                	mv	a1,s5
    41b2:	00003517          	auipc	a0,0x3
    41b6:	09650513          	add	a0,a0,150 # 7248 <malloc+0x1e76>
    41ba:	164010ef          	jal	531e <printf>
    exit(1);
    41be:	4505                	li	a0,1
    41c0:	4ef000ef          	jal	4eae <exit>
      printf("%s: write bigfile failed\n", s);
    41c4:	85d6                	mv	a1,s5
    41c6:	00003517          	auipc	a0,0x3
    41ca:	0a250513          	add	a0,a0,162 # 7268 <malloc+0x1e96>
    41ce:	150010ef          	jal	531e <printf>
      exit(1);
    41d2:	4505                	li	a0,1
    41d4:	4db000ef          	jal	4eae <exit>
    printf("%s: cannot open bigfile\n", s);
    41d8:	85d6                	mv	a1,s5
    41da:	00003517          	auipc	a0,0x3
    41de:	0ae50513          	add	a0,a0,174 # 7288 <malloc+0x1eb6>
    41e2:	13c010ef          	jal	531e <printf>
    exit(1);
    41e6:	4505                	li	a0,1
    41e8:	4c7000ef          	jal	4eae <exit>
      printf("%s: read bigfile failed\n", s);
    41ec:	85d6                	mv	a1,s5
    41ee:	00003517          	auipc	a0,0x3
    41f2:	0ba50513          	add	a0,a0,186 # 72a8 <malloc+0x1ed6>
    41f6:	128010ef          	jal	531e <printf>
      exit(1);
    41fa:	4505                	li	a0,1
    41fc:	4b3000ef          	jal	4eae <exit>
      printf("%s: short read bigfile\n", s);
    4200:	85d6                	mv	a1,s5
    4202:	00003517          	auipc	a0,0x3
    4206:	0c650513          	add	a0,a0,198 # 72c8 <malloc+0x1ef6>
    420a:	114010ef          	jal	531e <printf>
      exit(1);
    420e:	4505                	li	a0,1
    4210:	49f000ef          	jal	4eae <exit>
      printf("%s: read bigfile wrong data\n", s);
    4214:	85d6                	mv	a1,s5
    4216:	00003517          	auipc	a0,0x3
    421a:	0ca50513          	add	a0,a0,202 # 72e0 <malloc+0x1f0e>
    421e:	100010ef          	jal	531e <printf>
      exit(1);
    4222:	4505                	li	a0,1
    4224:	48b000ef          	jal	4eae <exit>
  close(fd);
    4228:	8552                	mv	a0,s4
    422a:	4ad000ef          	jal	4ed6 <close>
  if(total != N*SZ){
    422e:	678d                	lui	a5,0x3
    4230:	ee078793          	add	a5,a5,-288 # 2ee0 <subdir+0x31e>
    4234:	02f99163          	bne	s3,a5,4256 <bigfile+0x170>
  unlink("bigfile.dat");
    4238:	00003517          	auipc	a0,0x3
    423c:	00050513          	mv	a0,a0
    4240:	4bf000ef          	jal	4efe <unlink>
}
    4244:	70e2                	ld	ra,56(sp)
    4246:	7442                	ld	s0,48(sp)
    4248:	74a2                	ld	s1,40(sp)
    424a:	7902                	ld	s2,32(sp)
    424c:	69e2                	ld	s3,24(sp)
    424e:	6a42                	ld	s4,16(sp)
    4250:	6aa2                	ld	s5,8(sp)
    4252:	6121                	add	sp,sp,64
    4254:	8082                	ret
    printf("%s: read bigfile wrong total\n", s);
    4256:	85d6                	mv	a1,s5
    4258:	00003517          	auipc	a0,0x3
    425c:	0a850513          	add	a0,a0,168 # 7300 <malloc+0x1f2e>
    4260:	0be010ef          	jal	531e <printf>
    exit(1);
    4264:	4505                	li	a0,1
    4266:	449000ef          	jal	4eae <exit>

000000000000426a <bigargtest>:
{
    426a:	7121                	add	sp,sp,-448
    426c:	ff06                	sd	ra,440(sp)
    426e:	fb22                	sd	s0,432(sp)
    4270:	f726                	sd	s1,424(sp)
    4272:	0380                	add	s0,sp,448
    4274:	84aa                	mv	s1,a0
  unlink("bigarg-ok");
    4276:	00003517          	auipc	a0,0x3
    427a:	0aa50513          	add	a0,a0,170 # 7320 <malloc+0x1f4e>
    427e:	481000ef          	jal	4efe <unlink>
  pid = fork();
    4282:	425000ef          	jal	4ea6 <fork>
  if(pid == 0){
    4286:	c915                	beqz	a0,42ba <bigargtest+0x50>
  } else if(pid < 0){
    4288:	08054a63          	bltz	a0,431c <bigargtest+0xb2>
  wait(&xstatus);
    428c:	fdc40513          	add	a0,s0,-36
    4290:	427000ef          	jal	4eb6 <wait>
  if(xstatus != 0)
    4294:	fdc42503          	lw	a0,-36(s0)
    4298:	ed41                	bnez	a0,4330 <bigargtest+0xc6>
  fd = open("bigarg-ok", 0);
    429a:	4581                	li	a1,0
    429c:	00003517          	auipc	a0,0x3
    42a0:	08450513          	add	a0,a0,132 # 7320 <malloc+0x1f4e>
    42a4:	44b000ef          	jal	4eee <open>
  if(fd < 0){
    42a8:	08054663          	bltz	a0,4334 <bigargtest+0xca>
  close(fd);
    42ac:	42b000ef          	jal	4ed6 <close>
}
    42b0:	70fa                	ld	ra,440(sp)
    42b2:	745a                	ld	s0,432(sp)
    42b4:	74ba                	ld	s1,424(sp)
    42b6:	6139                	add	sp,sp,448
    42b8:	8082                	ret
    memset(big, ' ', sizeof(big));
    42ba:	19000613          	li	a2,400
    42be:	02000593          	li	a1,32
    42c2:	e4840513          	add	a0,s0,-440
    42c6:	137000ef          	jal	4bfc <memset>
    big[sizeof(big)-1] = '\0';
    42ca:	fc040ba3          	sb	zero,-41(s0)
    for(i = 0; i < MAXARG-1; i++)
    42ce:	00004797          	auipc	a5,0x4
    42d2:	1d278793          	add	a5,a5,466 # 84a0 <args.1>
    42d6:	00004697          	auipc	a3,0x4
    42da:	2c268693          	add	a3,a3,706 # 8598 <args.1+0xf8>
      args[i] = big;
    42de:	e4840713          	add	a4,s0,-440
    42e2:	e398                	sd	a4,0(a5)
    for(i = 0; i < MAXARG-1; i++)
    42e4:	07a1                	add	a5,a5,8
    42e6:	fed79ee3          	bne	a5,a3,42e2 <bigargtest+0x78>
    args[MAXARG-1] = 0;
    42ea:	00004597          	auipc	a1,0x4
    42ee:	1b658593          	add	a1,a1,438 # 84a0 <args.1>
    42f2:	0e05bc23          	sd	zero,248(a1)
    exec("echo", args);
    42f6:	00001517          	auipc	a0,0x1
    42fa:	21250513          	add	a0,a0,530 # 5508 <malloc+0x136>
    42fe:	3e9000ef          	jal	4ee6 <exec>
    fd = open("bigarg-ok", O_CREATE);
    4302:	20000593          	li	a1,512
    4306:	00003517          	auipc	a0,0x3
    430a:	01a50513          	add	a0,a0,26 # 7320 <malloc+0x1f4e>
    430e:	3e1000ef          	jal	4eee <open>
    close(fd);
    4312:	3c5000ef          	jal	4ed6 <close>
    exit(0);
    4316:	4501                	li	a0,0
    4318:	397000ef          	jal	4eae <exit>
    printf("%s: bigargtest: fork failed\n", s);
    431c:	85a6                	mv	a1,s1
    431e:	00003517          	auipc	a0,0x3
    4322:	01250513          	add	a0,a0,18 # 7330 <malloc+0x1f5e>
    4326:	7f9000ef          	jal	531e <printf>
    exit(1);
    432a:	4505                	li	a0,1
    432c:	383000ef          	jal	4eae <exit>
    exit(xstatus);
    4330:	37f000ef          	jal	4eae <exit>
    printf("%s: bigarg test failed!\n", s);
    4334:	85a6                	mv	a1,s1
    4336:	00003517          	auipc	a0,0x3
    433a:	01a50513          	add	a0,a0,26 # 7350 <malloc+0x1f7e>
    433e:	7e1000ef          	jal	531e <printf>
    exit(1);
    4342:	4505                	li	a0,1
    4344:	36b000ef          	jal	4eae <exit>

0000000000004348 <lazy_alloc>:
{
    4348:	1141                	add	sp,sp,-16
    434a:	e406                	sd	ra,8(sp)
    434c:	e022                	sd	s0,0(sp)
    434e:	0800                	add	s0,sp,16
  prev_end = sbrklazy(REGION_SZ);
    4350:	40000537          	lui	a0,0x40000
    4354:	29d000ef          	jal	4df0 <sbrklazy>
  if (prev_end == (char *) SBRK_ERROR) {
    4358:	57fd                	li	a5,-1
    435a:	02f50a63          	beq	a0,a5,438e <lazy_alloc+0x46>
  for (i = prev_end + PGSIZE; i < new_end; i += 64 * PGSIZE)
    435e:	6605                	lui	a2,0x1
    4360:	962a                	add	a2,a2,a0
    4362:	400017b7          	lui	a5,0x40001
    4366:	00f50733          	add	a4,a0,a5
    436a:	87b2                	mv	a5,a2
    436c:	000406b7          	lui	a3,0x40
    *(char **)i = i;
    4370:	e39c                	sd	a5,0(a5)
  for (i = prev_end + PGSIZE; i < new_end; i += 64 * PGSIZE)
    4372:	97b6                	add	a5,a5,a3
    4374:	fee79ee3          	bne	a5,a4,4370 <lazy_alloc+0x28>
  for (i = prev_end + PGSIZE; i < new_end; i += 64 * PGSIZE) {
    4378:	000406b7          	lui	a3,0x40
    if (*(char **)i != i) {
    437c:	621c                	ld	a5,0(a2)
    437e:	02c79163          	bne	a5,a2,43a0 <lazy_alloc+0x58>
  for (i = prev_end + PGSIZE; i < new_end; i += 64 * PGSIZE) {
    4382:	9636                	add	a2,a2,a3
    4384:	fee61ce3          	bne	a2,a4,437c <lazy_alloc+0x34>
  exit(0);
    4388:	4501                	li	a0,0
    438a:	325000ef          	jal	4eae <exit>
    printf("sbrklazy() failed\n");
    438e:	00003517          	auipc	a0,0x3
    4392:	fe250513          	add	a0,a0,-30 # 7370 <malloc+0x1f9e>
    4396:	789000ef          	jal	531e <printf>
    exit(1);
    439a:	4505                	li	a0,1
    439c:	313000ef          	jal	4eae <exit>
      printf("failed to read value from memory\n");
    43a0:	00003517          	auipc	a0,0x3
    43a4:	fe850513          	add	a0,a0,-24 # 7388 <malloc+0x1fb6>
    43a8:	777000ef          	jal	531e <printf>
      exit(1);
    43ac:	4505                	li	a0,1
    43ae:	301000ef          	jal	4eae <exit>

00000000000043b2 <lazy_unmap>:
{
    43b2:	7139                	add	sp,sp,-64
    43b4:	fc06                	sd	ra,56(sp)
    43b6:	f822                	sd	s0,48(sp)
    43b8:	0080                	add	s0,sp,64
  prev_end = sbrklazy(REGION_SZ);
    43ba:	40000537          	lui	a0,0x40000
    43be:	233000ef          	jal	4df0 <sbrklazy>
  if (prev_end == (char*)SBRK_ERROR) {
    43c2:	57fd                	li	a5,-1
    43c4:	04f50663          	beq	a0,a5,4410 <lazy_unmap+0x5e>
    43c8:	f426                	sd	s1,40(sp)
    43ca:	f04a                	sd	s2,32(sp)
    43cc:	ec4e                	sd	s3,24(sp)
  for (i = prev_end + PGSIZE; i < new_end; i += PGSIZE * PGSIZE)
    43ce:	6905                	lui	s2,0x1
    43d0:	992a                	add	s2,s2,a0
    43d2:	400017b7          	lui	a5,0x40001
    43d6:	00f504b3          	add	s1,a0,a5
    43da:	87ca                	mv	a5,s2
    43dc:	01000737          	lui	a4,0x1000
    *(char **)i = i;
    43e0:	e39c                	sd	a5,0(a5)
  for (i = prev_end + PGSIZE; i < new_end; i += PGSIZE * PGSIZE)
    43e2:	97ba                	add	a5,a5,a4
    43e4:	fe979ee3          	bne	a5,s1,43e0 <lazy_unmap+0x2e>
  for (i = prev_end + PGSIZE; i < new_end; i += PGSIZE * PGSIZE) {
    43e8:	010009b7          	lui	s3,0x1000
    pid = fork();
    43ec:	2bb000ef          	jal	4ea6 <fork>
    if (pid < 0) {
    43f0:	02054c63          	bltz	a0,4428 <lazy_unmap+0x76>
    } else if (pid == 0) {
    43f4:	c139                	beqz	a0,443a <lazy_unmap+0x88>
      wait(&status);
    43f6:	fcc40513          	add	a0,s0,-52
    43fa:	2bd000ef          	jal	4eb6 <wait>
      if (status == 0) {
    43fe:	fcc42783          	lw	a5,-52(s0)
    4402:	c7a9                	beqz	a5,444c <lazy_unmap+0x9a>
  for (i = prev_end + PGSIZE; i < new_end; i += PGSIZE * PGSIZE) {
    4404:	994e                	add	s2,s2,s3
    4406:	fe9913e3          	bne	s2,s1,43ec <lazy_unmap+0x3a>
  exit(0);
    440a:	4501                	li	a0,0
    440c:	2a3000ef          	jal	4eae <exit>
    4410:	f426                	sd	s1,40(sp)
    4412:	f04a                	sd	s2,32(sp)
    4414:	ec4e                	sd	s3,24(sp)
    printf("sbrklazy() failed\n");
    4416:	00003517          	auipc	a0,0x3
    441a:	f5a50513          	add	a0,a0,-166 # 7370 <malloc+0x1f9e>
    441e:	701000ef          	jal	531e <printf>
    exit(1);
    4422:	4505                	li	a0,1
    4424:	28b000ef          	jal	4eae <exit>
      printf("error forking\n");
    4428:	00003517          	auipc	a0,0x3
    442c:	f8850513          	add	a0,a0,-120 # 73b0 <malloc+0x1fde>
    4430:	6ef000ef          	jal	531e <printf>
      exit(1);
    4434:	4505                	li	a0,1
    4436:	279000ef          	jal	4eae <exit>
      sbrklazy(-1L * REGION_SZ);
    443a:	c0000537          	lui	a0,0xc0000
    443e:	1b3000ef          	jal	4df0 <sbrklazy>
      *(char **)i = i;
    4442:	01293023          	sd	s2,0(s2) # 1000 <badarg>
      exit(0);
    4446:	4501                	li	a0,0
    4448:	267000ef          	jal	4eae <exit>
        printf("memory not unmapped\n");
    444c:	00003517          	auipc	a0,0x3
    4450:	f7450513          	add	a0,a0,-140 # 73c0 <malloc+0x1fee>
    4454:	6cb000ef          	jal	531e <printf>
        exit(1);
    4458:	4505                	li	a0,1
    445a:	255000ef          	jal	4eae <exit>

000000000000445e <lazy_copy>:
{
    445e:	7159                	add	sp,sp,-112
    4460:	f486                	sd	ra,104(sp)
    4462:	f0a2                	sd	s0,96(sp)
    4464:	eca6                	sd	s1,88(sp)
    4466:	e8ca                	sd	s2,80(sp)
    4468:	e4ce                	sd	s3,72(sp)
    446a:	e0d2                	sd	s4,64(sp)
    446c:	fc56                	sd	s5,56(sp)
    446e:	f85a                	sd	s6,48(sp)
    4470:	1880                	add	s0,sp,112
    char *p = sbrk(0);
    4472:	4501                	li	a0,0
    4474:	167000ef          	jal	4dda <sbrk>
    4478:	84aa                	mv	s1,a0
    sbrklazy(4*PGSIZE);
    447a:	6511                	lui	a0,0x4
    447c:	175000ef          	jal	4df0 <sbrklazy>
    open(p + 8192, 0);
    4480:	4581                	li	a1,0
    4482:	6509                	lui	a0,0x2
    4484:	9526                	add	a0,a0,s1
    4486:	269000ef          	jal	4eee <open>
    void *xx = sbrk(0);
    448a:	4501                	li	a0,0
    448c:	14f000ef          	jal	4dda <sbrk>
    4490:	84aa                	mv	s1,a0
    void *ret = sbrk(-(((uint64) xx)+1));
    4492:	fff54513          	not	a0,a0
    4496:	2501                	sext.w	a0,a0
    4498:	143000ef          	jal	4dda <sbrk>
    if(ret != xx){
    449c:	00a48c63          	beq	s1,a0,44b4 <lazy_copy+0x56>
    44a0:	85aa                	mv	a1,a0
      printf("sbrk(sbrk(0)+1) returned %p, not old sz\n", ret);
    44a2:	00003517          	auipc	a0,0x3
    44a6:	f3650513          	add	a0,a0,-202 # 73d8 <malloc+0x2006>
    44aa:	675000ef          	jal	531e <printf>
      exit(1);
    44ae:	4505                	li	a0,1
    44b0:	1ff000ef          	jal	4eae <exit>
  unsigned long bad[] = {
    44b4:	00003797          	auipc	a5,0x3
    44b8:	59c78793          	add	a5,a5,1436 # 7a50 <malloc+0x267e>
    44bc:	7fa8                	ld	a0,120(a5)
    44be:	63cc                	ld	a1,128(a5)
    44c0:	67d0                	ld	a2,136(a5)
    44c2:	6bd4                	ld	a3,144(a5)
    44c4:	6fd8                	ld	a4,152(a5)
    44c6:	73dc                	ld	a5,160(a5)
    44c8:	f8a43823          	sd	a0,-112(s0)
    44cc:	f8b43c23          	sd	a1,-104(s0)
    44d0:	fac43023          	sd	a2,-96(s0)
    44d4:	fad43423          	sd	a3,-88(s0)
    44d8:	fae43823          	sd	a4,-80(s0)
    44dc:	faf43c23          	sd	a5,-72(s0)
  for(int i = 0; i < sizeof(bad)/sizeof(bad[0]); i++){
    44e0:	f9040913          	add	s2,s0,-112
    44e4:	fc040b13          	add	s6,s0,-64
    int fd = open("README", 0);
    44e8:	00001a17          	auipc	s4,0x1
    44ec:	1f8a0a13          	add	s4,s4,504 # 56e0 <malloc+0x30e>
    fd = open("junk", O_CREATE|O_RDWR|O_TRUNC);
    44f0:	00001a97          	auipc	s5,0x1
    44f4:	100a8a93          	add	s5,s5,256 # 55f0 <malloc+0x21e>
    int fd = open("README", 0);
    44f8:	4581                	li	a1,0
    44fa:	8552                	mv	a0,s4
    44fc:	1f3000ef          	jal	4eee <open>
    4500:	84aa                	mv	s1,a0
    if(fd < 0) { printf("cannot open README\n"); exit(1); }
    4502:	04054663          	bltz	a0,454e <lazy_copy+0xf0>
    if(read(fd, (char*)bad[i], 512) >= 0) { printf("read succeeded\n");  exit(1); }
    4506:	00093983          	ld	s3,0(s2)
    450a:	20000613          	li	a2,512
    450e:	85ce                	mv	a1,s3
    4510:	1b7000ef          	jal	4ec6 <read>
    4514:	04055663          	bgez	a0,4560 <lazy_copy+0x102>
    close(fd);
    4518:	8526                	mv	a0,s1
    451a:	1bd000ef          	jal	4ed6 <close>
    fd = open("junk", O_CREATE|O_RDWR|O_TRUNC);
    451e:	60200593          	li	a1,1538
    4522:	8556                	mv	a0,s5
    4524:	1cb000ef          	jal	4eee <open>
    4528:	84aa                	mv	s1,a0
    if(fd < 0) { printf("cannot open junk\n"); exit(1); }
    452a:	04054463          	bltz	a0,4572 <lazy_copy+0x114>
    if(write(fd, (char*)bad[i], 512) >= 0) { printf("write succeeded\n"); exit(1); }
    452e:	20000613          	li	a2,512
    4532:	85ce                	mv	a1,s3
    4534:	19b000ef          	jal	4ece <write>
    4538:	04055663          	bgez	a0,4584 <lazy_copy+0x126>
    close(fd);
    453c:	8526                	mv	a0,s1
    453e:	199000ef          	jal	4ed6 <close>
  for(int i = 0; i < sizeof(bad)/sizeof(bad[0]); i++){
    4542:	0921                	add	s2,s2,8
    4544:	fb691ae3          	bne	s2,s6,44f8 <lazy_copy+0x9a>
  exit(0);
    4548:	4501                	li	a0,0
    454a:	165000ef          	jal	4eae <exit>
    if(fd < 0) { printf("cannot open README\n"); exit(1); }
    454e:	00003517          	auipc	a0,0x3
    4552:	eba50513          	add	a0,a0,-326 # 7408 <malloc+0x2036>
    4556:	5c9000ef          	jal	531e <printf>
    455a:	4505                	li	a0,1
    455c:	153000ef          	jal	4eae <exit>
    if(read(fd, (char*)bad[i], 512) >= 0) { printf("read succeeded\n");  exit(1); }
    4560:	00003517          	auipc	a0,0x3
    4564:	ec050513          	add	a0,a0,-320 # 7420 <malloc+0x204e>
    4568:	5b7000ef          	jal	531e <printf>
    456c:	4505                	li	a0,1
    456e:	141000ef          	jal	4eae <exit>
    if(fd < 0) { printf("cannot open junk\n"); exit(1); }
    4572:	00003517          	auipc	a0,0x3
    4576:	ebe50513          	add	a0,a0,-322 # 7430 <malloc+0x205e>
    457a:	5a5000ef          	jal	531e <printf>
    457e:	4505                	li	a0,1
    4580:	12f000ef          	jal	4eae <exit>
    if(write(fd, (char*)bad[i], 512) >= 0) { printf("write succeeded\n"); exit(1); }
    4584:	00003517          	auipc	a0,0x3
    4588:	ec450513          	add	a0,a0,-316 # 7448 <malloc+0x2076>
    458c:	593000ef          	jal	531e <printf>
    4590:	4505                	li	a0,1
    4592:	11d000ef          	jal	4eae <exit>

0000000000004596 <lazy_sbrk>:
{
    4596:	1101                	add	sp,sp,-32
    4598:	ec06                	sd	ra,24(sp)
    459a:	e822                	sd	s0,16(sp)
    459c:	e426                	sd	s1,8(sp)
    459e:	e04a                	sd	s2,0(sp)
    45a0:	1000                	add	s0,sp,32
  char *p = sbrk(0);
    45a2:	4501                	li	a0,0
    45a4:	037000ef          	jal	4dda <sbrk>
    45a8:	84aa                	mv	s1,a0
  while ((uint64)p < MAXVA-(1<<30)) {
    45aa:	0ff00793          	li	a5,255
    45ae:	07fa                	sll	a5,a5,0x1e
    45b0:	00f57d63          	bgeu	a0,a5,45ca <lazy_sbrk+0x34>
    45b4:	893e                	mv	s2,a5
    p = sbrklazy(1<<30);
    45b6:	40000537          	lui	a0,0x40000
    45ba:	037000ef          	jal	4df0 <sbrklazy>
    p = sbrklazy(0);
    45be:	4501                	li	a0,0
    45c0:	031000ef          	jal	4df0 <sbrklazy>
    45c4:	84aa                	mv	s1,a0
  while ((uint64)p < MAXVA-(1<<30)) {
    45c6:	ff2568e3          	bltu	a0,s2,45b6 <lazy_sbrk+0x20>
  int n = TRAPFRAME-PGSIZE-(uint64)p;
    45ca:	7975                	lui	s2,0xffffd
    45cc:	4099093b          	subw	s2,s2,s1
  char *p1 = sbrklazy(n);
    45d0:	854a                	mv	a0,s2
    45d2:	01f000ef          	jal	4df0 <sbrklazy>
    45d6:	862a                	mv	a2,a0
  if (p1 < 0 || p1 != p) {
    45d8:	00950d63          	beq	a0,s1,45f2 <lazy_sbrk+0x5c>
    printf("sbrklazy(%d) returned %p, not expected %p\n", n, p1, p);
    45dc:	86a6                	mv	a3,s1
    45de:	85ca                	mv	a1,s2
    45e0:	00003517          	auipc	a0,0x3
    45e4:	e8050513          	add	a0,a0,-384 # 7460 <malloc+0x208e>
    45e8:	537000ef          	jal	531e <printf>
    exit(1);
    45ec:	4505                	li	a0,1
    45ee:	0c1000ef          	jal	4eae <exit>
  p = sbrk(PGSIZE);
    45f2:	6505                	lui	a0,0x1
    45f4:	7e6000ef          	jal	4dda <sbrk>
    45f8:	862a                	mv	a2,a0
  if (p < 0 || (uint64)p != TRAPFRAME-PGSIZE) {
    45fa:	040007b7          	lui	a5,0x4000
    45fe:	17f5                	add	a5,a5,-3 # 3fffffd <base+0x3ff1345>
    4600:	07b2                	sll	a5,a5,0xc
    4602:	00f50c63          	beq	a0,a5,461a <lazy_sbrk+0x84>
    printf("sbrk(%d) returned %p, not expected TRAPFRAME-PGSIZE\n", PGSIZE, p);
    4606:	6585                	lui	a1,0x1
    4608:	00003517          	auipc	a0,0x3
    460c:	e8850513          	add	a0,a0,-376 # 7490 <malloc+0x20be>
    4610:	50f000ef          	jal	531e <printf>
    exit(1);
    4614:	4505                	li	a0,1
    4616:	099000ef          	jal	4eae <exit>
  p[0] = 1;
    461a:	040007b7          	lui	a5,0x4000
    461e:	17f5                	add	a5,a5,-3 # 3fffffd <base+0x3ff1345>
    4620:	07b2                	sll	a5,a5,0xc
    4622:	4705                	li	a4,1
    4624:	00e78023          	sb	a4,0(a5)
  if (p[1] != 0) {
    4628:	0017c783          	lbu	a5,1(a5)
    462c:	cb91                	beqz	a5,4640 <lazy_sbrk+0xaa>
    printf("sbrk() returned non-zero-filled memory\n");
    462e:	00003517          	auipc	a0,0x3
    4632:	e9a50513          	add	a0,a0,-358 # 74c8 <malloc+0x20f6>
    4636:	4e9000ef          	jal	531e <printf>
    exit(1);
    463a:	4505                	li	a0,1
    463c:	073000ef          	jal	4eae <exit>
  p = sbrk(1);
    4640:	4505                	li	a0,1
    4642:	798000ef          	jal	4dda <sbrk>
    4646:	85aa                	mv	a1,a0
  if ((uint64)p != -1) {
    4648:	57fd                	li	a5,-1
    464a:	00f50b63          	beq	a0,a5,4660 <lazy_sbrk+0xca>
    printf("sbrk(1) returned %p, expected error\n", p);
    464e:	00003517          	auipc	a0,0x3
    4652:	ea250513          	add	a0,a0,-350 # 74f0 <malloc+0x211e>
    4656:	4c9000ef          	jal	531e <printf>
    exit(1);
    465a:	4505                	li	a0,1
    465c:	053000ef          	jal	4eae <exit>
  p = sbrklazy(1);
    4660:	4505                	li	a0,1
    4662:	78e000ef          	jal	4df0 <sbrklazy>
    4666:	85aa                	mv	a1,a0
  if ((uint64)p != -1) {
    4668:	57fd                	li	a5,-1
    466a:	00f50b63          	beq	a0,a5,4680 <lazy_sbrk+0xea>
    printf("sbrklazy(1) returned %p, expected error\n", p);
    466e:	00003517          	auipc	a0,0x3
    4672:	eaa50513          	add	a0,a0,-342 # 7518 <malloc+0x2146>
    4676:	4a9000ef          	jal	531e <printf>
    exit(1);
    467a:	4505                	li	a0,1
    467c:	033000ef          	jal	4eae <exit>
  exit(0);
    4680:	4501                	li	a0,0
    4682:	02d000ef          	jal	4eae <exit>

0000000000004686 <fsfull>:
{
    4686:	7135                	add	sp,sp,-160
    4688:	ed06                	sd	ra,152(sp)
    468a:	e922                	sd	s0,144(sp)
    468c:	e526                	sd	s1,136(sp)
    468e:	e14a                	sd	s2,128(sp)
    4690:	fcce                	sd	s3,120(sp)
    4692:	f8d2                	sd	s4,112(sp)
    4694:	f4d6                	sd	s5,104(sp)
    4696:	f0da                	sd	s6,96(sp)
    4698:	ecde                	sd	s7,88(sp)
    469a:	e8e2                	sd	s8,80(sp)
    469c:	e4e6                	sd	s9,72(sp)
    469e:	e0ea                	sd	s10,64(sp)
    46a0:	1100                	add	s0,sp,160
  printf("fsfull test\n");
    46a2:	00003517          	auipc	a0,0x3
    46a6:	ea650513          	add	a0,a0,-346 # 7548 <malloc+0x2176>
    46aa:	475000ef          	jal	531e <printf>
  for(nfiles = 0; ; nfiles++){
    46ae:	4481                	li	s1,0
    name[0] = 'f';
    46b0:	06600d13          	li	s10,102
    name[1] = '0' + nfiles / 1000;
    46b4:	3e800c13          	li	s8,1000
    name[2] = '0' + (nfiles % 1000) / 100;
    46b8:	06400b93          	li	s7,100
    name[3] = '0' + (nfiles % 100) / 10;
    46bc:	4b29                	li	s6,10
    printf("writing %s\n", name);
    46be:	00003c97          	auipc	s9,0x3
    46c2:	e9ac8c93          	add	s9,s9,-358 # 7558 <malloc+0x2186>
    name[0] = 'f';
    46c6:	f7a40023          	sb	s10,-160(s0)
    name[1] = '0' + nfiles / 1000;
    46ca:	0384c7bb          	divw	a5,s1,s8
    46ce:	0307879b          	addw	a5,a5,48
    46d2:	f6f400a3          	sb	a5,-159(s0)
    name[2] = '0' + (nfiles % 1000) / 100;
    46d6:	0384e7bb          	remw	a5,s1,s8
    46da:	0377c7bb          	divw	a5,a5,s7
    46de:	0307879b          	addw	a5,a5,48
    46e2:	f6f40123          	sb	a5,-158(s0)
    name[3] = '0' + (nfiles % 100) / 10;
    46e6:	0374e7bb          	remw	a5,s1,s7
    46ea:	0367c7bb          	divw	a5,a5,s6
    46ee:	0307879b          	addw	a5,a5,48
    46f2:	f6f401a3          	sb	a5,-157(s0)
    name[4] = '0' + (nfiles % 10);
    46f6:	0364e7bb          	remw	a5,s1,s6
    46fa:	0307879b          	addw	a5,a5,48
    46fe:	f6f40223          	sb	a5,-156(s0)
    name[5] = '\0';
    4702:	f60402a3          	sb	zero,-155(s0)
    printf("writing %s\n", name);
    4706:	f6040593          	add	a1,s0,-160
    470a:	8566                	mv	a0,s9
    470c:	413000ef          	jal	531e <printf>
    int fd = open(name, O_CREATE|O_RDWR);
    4710:	20200593          	li	a1,514
    4714:	f6040513          	add	a0,s0,-160
    4718:	7d6000ef          	jal	4eee <open>
    471c:	892a                	mv	s2,a0
    if(fd < 0){
    471e:	08055f63          	bgez	a0,47bc <fsfull+0x136>
      printf("open %s failed\n", name);
    4722:	f6040593          	add	a1,s0,-160
    4726:	00003517          	auipc	a0,0x3
    472a:	e4250513          	add	a0,a0,-446 # 7568 <malloc+0x2196>
    472e:	3f1000ef          	jal	531e <printf>
  while(nfiles >= 0){
    4732:	0604c163          	bltz	s1,4794 <fsfull+0x10e>
    name[0] = 'f';
    4736:	06600b13          	li	s6,102
    name[1] = '0' + nfiles / 1000;
    473a:	3e800a13          	li	s4,1000
    name[2] = '0' + (nfiles % 1000) / 100;
    473e:	06400993          	li	s3,100
    name[3] = '0' + (nfiles % 100) / 10;
    4742:	4929                	li	s2,10
  while(nfiles >= 0){
    4744:	5afd                	li	s5,-1
    name[0] = 'f';
    4746:	f7640023          	sb	s6,-160(s0)
    name[1] = '0' + nfiles / 1000;
    474a:	0344c7bb          	divw	a5,s1,s4
    474e:	0307879b          	addw	a5,a5,48
    4752:	f6f400a3          	sb	a5,-159(s0)
    name[2] = '0' + (nfiles % 1000) / 100;
    4756:	0344e7bb          	remw	a5,s1,s4
    475a:	0337c7bb          	divw	a5,a5,s3
    475e:	0307879b          	addw	a5,a5,48
    4762:	f6f40123          	sb	a5,-158(s0)
    name[3] = '0' + (nfiles % 100) / 10;
    4766:	0334e7bb          	remw	a5,s1,s3
    476a:	0327c7bb          	divw	a5,a5,s2
    476e:	0307879b          	addw	a5,a5,48
    4772:	f6f401a3          	sb	a5,-157(s0)
    name[4] = '0' + (nfiles % 10);
    4776:	0324e7bb          	remw	a5,s1,s2
    477a:	0307879b          	addw	a5,a5,48
    477e:	f6f40223          	sb	a5,-156(s0)
    name[5] = '\0';
    4782:	f60402a3          	sb	zero,-155(s0)
    unlink(name);
    4786:	f6040513          	add	a0,s0,-160
    478a:	774000ef          	jal	4efe <unlink>
    nfiles--;
    478e:	34fd                	addw	s1,s1,-1
  while(nfiles >= 0){
    4790:	fb549be3          	bne	s1,s5,4746 <fsfull+0xc0>
  printf("fsfull test finished\n");
    4794:	00003517          	auipc	a0,0x3
    4798:	df450513          	add	a0,a0,-524 # 7588 <malloc+0x21b6>
    479c:	383000ef          	jal	531e <printf>
}
    47a0:	60ea                	ld	ra,152(sp)
    47a2:	644a                	ld	s0,144(sp)
    47a4:	64aa                	ld	s1,136(sp)
    47a6:	690a                	ld	s2,128(sp)
    47a8:	79e6                	ld	s3,120(sp)
    47aa:	7a46                	ld	s4,112(sp)
    47ac:	7aa6                	ld	s5,104(sp)
    47ae:	7b06                	ld	s6,96(sp)
    47b0:	6be6                	ld	s7,88(sp)
    47b2:	6c46                	ld	s8,80(sp)
    47b4:	6ca6                	ld	s9,72(sp)
    47b6:	6d06                	ld	s10,64(sp)
    47b8:	610d                	add	sp,sp,160
    47ba:	8082                	ret
    int total = 0;
    47bc:	4981                	li	s3,0
      int cc = write(fd, buf, BSIZE);
    47be:	00007a97          	auipc	s5,0x7
    47c2:	4faa8a93          	add	s5,s5,1274 # bcb8 <buf>
      if(cc < BSIZE)
    47c6:	3ff00a13          	li	s4,1023
      int cc = write(fd, buf, BSIZE);
    47ca:	40000613          	li	a2,1024
    47ce:	85d6                	mv	a1,s5
    47d0:	854a                	mv	a0,s2
    47d2:	6fc000ef          	jal	4ece <write>
      if(cc < BSIZE)
    47d6:	00aa5563          	bge	s4,a0,47e0 <fsfull+0x15a>
      total += cc;
    47da:	00a989bb          	addw	s3,s3,a0
    while(1){
    47de:	b7f5                	j	47ca <fsfull+0x144>
    printf("wrote %d bytes\n", total);
    47e0:	85ce                	mv	a1,s3
    47e2:	00003517          	auipc	a0,0x3
    47e6:	d9650513          	add	a0,a0,-618 # 7578 <malloc+0x21a6>
    47ea:	335000ef          	jal	531e <printf>
    close(fd);
    47ee:	854a                	mv	a0,s2
    47f0:	6e6000ef          	jal	4ed6 <close>
    if(total == 0)
    47f4:	f2098fe3          	beqz	s3,4732 <fsfull+0xac>
  for(nfiles = 0; ; nfiles++){
    47f8:	2485                	addw	s1,s1,1
    47fa:	b5f1                	j	46c6 <fsfull+0x40>

00000000000047fc <run>:
//

// run each test in its own process. run returns 1 if child's exit()
// indicates success.
int
run(void f(char *), char *s) {
    47fc:	7179                	add	sp,sp,-48
    47fe:	f406                	sd	ra,40(sp)
    4800:	f022                	sd	s0,32(sp)
    4802:	ec26                	sd	s1,24(sp)
    4804:	e84a                	sd	s2,16(sp)
    4806:	1800                	add	s0,sp,48
    4808:	84aa                	mv	s1,a0
    480a:	892e                	mv	s2,a1
  int pid;
  int xstatus;

  printf("test %s: ", s);
    480c:	00003517          	auipc	a0,0x3
    4810:	d9450513          	add	a0,a0,-620 # 75a0 <malloc+0x21ce>
    4814:	30b000ef          	jal	531e <printf>
  if((pid = fork()) < 0) {
    4818:	68e000ef          	jal	4ea6 <fork>
    481c:	02054a63          	bltz	a0,4850 <run+0x54>
    printf("runtest: fork error\n");
    exit(1);
  }
  if(pid == 0) {
    4820:	c129                	beqz	a0,4862 <run+0x66>
    f(s);
    exit(0);
  } else {
    wait(&xstatus);
    4822:	fdc40513          	add	a0,s0,-36
    4826:	690000ef          	jal	4eb6 <wait>
    if(xstatus != 0) 
    482a:	fdc42783          	lw	a5,-36(s0)
    482e:	cf9d                	beqz	a5,486c <run+0x70>
      printf("FAILED\n");
    4830:	00003517          	auipc	a0,0x3
    4834:	d9850513          	add	a0,a0,-616 # 75c8 <malloc+0x21f6>
    4838:	2e7000ef          	jal	531e <printf>
    else
      printf("OK\n");
    return xstatus == 0;
    483c:	fdc42503          	lw	a0,-36(s0)
  }
}
    4840:	00153513          	seqz	a0,a0
    4844:	70a2                	ld	ra,40(sp)
    4846:	7402                	ld	s0,32(sp)
    4848:	64e2                	ld	s1,24(sp)
    484a:	6942                	ld	s2,16(sp)
    484c:	6145                	add	sp,sp,48
    484e:	8082                	ret
    printf("runtest: fork error\n");
    4850:	00003517          	auipc	a0,0x3
    4854:	d6050513          	add	a0,a0,-672 # 75b0 <malloc+0x21de>
    4858:	2c7000ef          	jal	531e <printf>
    exit(1);
    485c:	4505                	li	a0,1
    485e:	650000ef          	jal	4eae <exit>
    f(s);
    4862:	854a                	mv	a0,s2
    4864:	9482                	jalr	s1
    exit(0);
    4866:	4501                	li	a0,0
    4868:	646000ef          	jal	4eae <exit>
      printf("OK\n");
    486c:	00003517          	auipc	a0,0x3
    4870:	d6450513          	add	a0,a0,-668 # 75d0 <malloc+0x21fe>
    4874:	2ab000ef          	jal	531e <printf>
    4878:	b7d1                	j	483c <run+0x40>

000000000000487a <runtests>:

int
runtests(struct test *tests, char *justone, int continuous) {
    487a:	7139                	add	sp,sp,-64
    487c:	fc06                	sd	ra,56(sp)
    487e:	f822                	sd	s0,48(sp)
    4880:	f426                	sd	s1,40(sp)
    4882:	ec4e                	sd	s3,24(sp)
    4884:	0080                	add	s0,sp,64
    4886:	84aa                	mv	s1,a0
  int ntests = 0;
  for (struct test *t = tests; t->s != 0; t++) {
    4888:	6508                	ld	a0,8(a0)
    488a:	cd39                	beqz	a0,48e8 <runtests+0x6e>
    488c:	f04a                	sd	s2,32(sp)
    488e:	e852                	sd	s4,16(sp)
    4890:	e456                	sd	s5,8(sp)
    4892:	892e                	mv	s2,a1
    4894:	8a32                	mv	s4,a2
  int ntests = 0;
    4896:	4981                	li	s3,0
    if((justone == 0) || strcmp(t->s, justone) == 0) {
      ntests++;
      if(!run(t->f, t->s)){
        if(continuous != 2){
    4898:	4a89                	li	s5,2
    489a:	a021                	j	48a2 <runtests+0x28>
  for (struct test *t = tests; t->s != 0; t++) {
    489c:	04c1                	add	s1,s1,16
    489e:	6488                	ld	a0,8(s1)
    48a0:	c915                	beqz	a0,48d4 <runtests+0x5a>
    if((justone == 0) || strcmp(t->s, justone) == 0) {
    48a2:	00090663          	beqz	s2,48ae <runtests+0x34>
    48a6:	85ca                	mv	a1,s2
    48a8:	264000ef          	jal	4b0c <strcmp>
    48ac:	f965                	bnez	a0,489c <runtests+0x22>
      ntests++;
    48ae:	2985                	addw	s3,s3,1 # 1000001 <base+0xff1349>
      if(!run(t->f, t->s)){
    48b0:	648c                	ld	a1,8(s1)
    48b2:	6088                	ld	a0,0(s1)
    48b4:	f49ff0ef          	jal	47fc <run>
    48b8:	f175                	bnez	a0,489c <runtests+0x22>
        if(continuous != 2){
    48ba:	ff5a01e3          	beq	s4,s5,489c <runtests+0x22>
          printf("SOME TESTS FAILED\n");
    48be:	00003517          	auipc	a0,0x3
    48c2:	d1a50513          	add	a0,a0,-742 # 75d8 <malloc+0x2206>
    48c6:	259000ef          	jal	531e <printf>
          return -1;
    48ca:	59fd                	li	s3,-1
    48cc:	7902                	ld	s2,32(sp)
    48ce:	6a42                	ld	s4,16(sp)
    48d0:	6aa2                	ld	s5,8(sp)
    48d2:	a021                	j	48da <runtests+0x60>
    48d4:	7902                	ld	s2,32(sp)
    48d6:	6a42                	ld	s4,16(sp)
    48d8:	6aa2                	ld	s5,8(sp)
        }
      }
    }
  }
  return ntests;
}
    48da:	854e                	mv	a0,s3
    48dc:	70e2                	ld	ra,56(sp)
    48de:	7442                	ld	s0,48(sp)
    48e0:	74a2                	ld	s1,40(sp)
    48e2:	69e2                	ld	s3,24(sp)
    48e4:	6121                	add	sp,sp,64
    48e6:	8082                	ret
  return ntests;
    48e8:	4981                	li	s3,0
    48ea:	bfc5                	j	48da <runtests+0x60>

00000000000048ec <countfree>:


// use sbrk() to count how many free physical memory pages there are.
int
countfree()
{
    48ec:	7179                	add	sp,sp,-48
    48ee:	f406                	sd	ra,40(sp)
    48f0:	f022                	sd	s0,32(sp)
    48f2:	ec26                	sd	s1,24(sp)
    48f4:	e84a                	sd	s2,16(sp)
    48f6:	e44e                	sd	s3,8(sp)
    48f8:	1800                	add	s0,sp,48
  int n = 0;
  uint64 sz0 = (uint64)sbrk(0);
    48fa:	4501                	li	a0,0
    48fc:	4de000ef          	jal	4dda <sbrk>
    4900:	89aa                	mv	s3,a0
  int n = 0;
    4902:	4481                	li	s1,0
  while(1){
    char *a = sbrk(PGSIZE);
    if(a == SBRK_ERROR){
    4904:	597d                	li	s2,-1
    4906:	a011                	j	490a <countfree+0x1e>
      break;
    }
    n += 1;
    4908:	2485                	addw	s1,s1,1
    char *a = sbrk(PGSIZE);
    490a:	6505                	lui	a0,0x1
    490c:	4ce000ef          	jal	4dda <sbrk>
    if(a == SBRK_ERROR){
    4910:	ff251ce3          	bne	a0,s2,4908 <countfree+0x1c>
  }
  sbrk(-((uint64)sbrk(0) - sz0));  
    4914:	4501                	li	a0,0
    4916:	4c4000ef          	jal	4dda <sbrk>
    491a:	40a9853b          	subw	a0,s3,a0
    491e:	4bc000ef          	jal	4dda <sbrk>
  return n;
}
    4922:	8526                	mv	a0,s1
    4924:	70a2                	ld	ra,40(sp)
    4926:	7402                	ld	s0,32(sp)
    4928:	64e2                	ld	s1,24(sp)
    492a:	6942                	ld	s2,16(sp)
    492c:	69a2                	ld	s3,8(sp)
    492e:	6145                	add	sp,sp,48
    4930:	8082                	ret

0000000000004932 <drivetests>:

int
drivetests(int quick, int continuous, char *justone) {
    4932:	7159                	add	sp,sp,-112
    4934:	f486                	sd	ra,104(sp)
    4936:	f0a2                	sd	s0,96(sp)
    4938:	eca6                	sd	s1,88(sp)
    493a:	e8ca                	sd	s2,80(sp)
    493c:	e4ce                	sd	s3,72(sp)
    493e:	e0d2                	sd	s4,64(sp)
    4940:	fc56                	sd	s5,56(sp)
    4942:	f85a                	sd	s6,48(sp)
    4944:	f45e                	sd	s7,40(sp)
    4946:	f062                	sd	s8,32(sp)
    4948:	ec66                	sd	s9,24(sp)
    494a:	e86a                	sd	s10,16(sp)
    494c:	e46e                	sd	s11,8(sp)
    494e:	1880                	add	s0,sp,112
    4950:	8aaa                	mv	s5,a0
    4952:	89ae                	mv	s3,a1
    4954:	8a32                	mv	s4,a2
  do {
    printf("usertests starting\n");
    4956:	00003c17          	auipc	s8,0x3
    495a:	c9ac0c13          	add	s8,s8,-870 # 75f0 <malloc+0x221e>
    int free0 = countfree();
    int free1 = 0;
    int ntests = 0;
    int n;
    n = runtests(quicktests, justone, continuous);
    495e:	00003b97          	auipc	s7,0x3
    4962:	6b2b8b93          	add	s7,s7,1714 # 8010 <quicktests>
    if (n < 0) {
      if(continuous != 2) {
    4966:	4b09                	li	s6,2
      ntests += n;
    }
    if(!quick) {
      if (justone == 0)
        printf("usertests slow tests starting\n");
      n = runtests(slowtests, justone, continuous);
    4968:	00004c97          	auipc	s9,0x4
    496c:	ab8c8c93          	add	s9,s9,-1352 # 8420 <slowtests>
        printf("usertests slow tests starting\n");
    4970:	00003d97          	auipc	s11,0x3
    4974:	c98d8d93          	add	s11,s11,-872 # 7608 <malloc+0x2236>
      } else {
        ntests += n;
      }
    }
    if((free1 = countfree()) < free0) {
      printf("FAILED -- lost some free pages %d (out of %d)\n", free1, free0);
    4978:	00003d17          	auipc	s10,0x3
    497c:	cb0d0d13          	add	s10,s10,-848 # 7628 <malloc+0x2256>
    4980:	a025                	j	49a8 <drivetests+0x76>
      if(continuous != 2) {
    4982:	09699063          	bne	s3,s6,4a02 <drivetests+0xd0>
    int ntests = 0;
    4986:	4481                	li	s1,0
    4988:	a835                	j	49c4 <drivetests+0x92>
        printf("usertests slow tests starting\n");
    498a:	856e                	mv	a0,s11
    498c:	193000ef          	jal	531e <printf>
    4990:	a835                	j	49cc <drivetests+0x9a>
        if(continuous != 2) {
    4992:	07699a63          	bne	s3,s6,4a06 <drivetests+0xd4>
    if((free1 = countfree()) < free0) {
    4996:	f57ff0ef          	jal	48ec <countfree>
    499a:	05254263          	blt	a0,s2,49de <drivetests+0xac>
      if(continuous != 2) {
        return 1;
      }
    }
    if (justone != 0 && ntests == 0) {
    499e:	000a0363          	beqz	s4,49a4 <drivetests+0x72>
    49a2:	c8a1                	beqz	s1,49f2 <drivetests+0xc0>
      printf("NO TESTS EXECUTED\n");
      return 1;
    }
  } while(continuous);
    49a4:	06098563          	beqz	s3,4a0e <drivetests+0xdc>
    printf("usertests starting\n");
    49a8:	8562                	mv	a0,s8
    49aa:	175000ef          	jal	531e <printf>
    int free0 = countfree();
    49ae:	f3fff0ef          	jal	48ec <countfree>
    49b2:	892a                	mv	s2,a0
    n = runtests(quicktests, justone, continuous);
    49b4:	864e                	mv	a2,s3
    49b6:	85d2                	mv	a1,s4
    49b8:	855e                	mv	a0,s7
    49ba:	ec1ff0ef          	jal	487a <runtests>
    49be:	84aa                	mv	s1,a0
    if (n < 0) {
    49c0:	fc0541e3          	bltz	a0,4982 <drivetests+0x50>
    if(!quick) {
    49c4:	fc0a99e3          	bnez	s5,4996 <drivetests+0x64>
      if (justone == 0)
    49c8:	fc0a01e3          	beqz	s4,498a <drivetests+0x58>
      n = runtests(slowtests, justone, continuous);
    49cc:	864e                	mv	a2,s3
    49ce:	85d2                	mv	a1,s4
    49d0:	8566                	mv	a0,s9
    49d2:	ea9ff0ef          	jal	487a <runtests>
      if (n < 0) {
    49d6:	fa054ee3          	bltz	a0,4992 <drivetests+0x60>
        ntests += n;
    49da:	9ca9                	addw	s1,s1,a0
    49dc:	bf6d                	j	4996 <drivetests+0x64>
      printf("FAILED -- lost some free pages %d (out of %d)\n", free1, free0);
    49de:	864a                	mv	a2,s2
    49e0:	85aa                	mv	a1,a0
    49e2:	856a                	mv	a0,s10
    49e4:	13b000ef          	jal	531e <printf>
      if(continuous != 2) {
    49e8:	03699163          	bne	s3,s6,4a0a <drivetests+0xd8>
    if (justone != 0 && ntests == 0) {
    49ec:	fa0a1be3          	bnez	s4,49a2 <drivetests+0x70>
    49f0:	bf65                	j	49a8 <drivetests+0x76>
      printf("NO TESTS EXECUTED\n");
    49f2:	00003517          	auipc	a0,0x3
    49f6:	c6650513          	add	a0,a0,-922 # 7658 <malloc+0x2286>
    49fa:	125000ef          	jal	531e <printf>
      return 1;
    49fe:	4505                	li	a0,1
    4a00:	a801                	j	4a10 <drivetests+0xde>
        return 1;
    4a02:	4505                	li	a0,1
    4a04:	a031                	j	4a10 <drivetests+0xde>
          return 1;
    4a06:	4505                	li	a0,1
    4a08:	a021                	j	4a10 <drivetests+0xde>
        return 1;
    4a0a:	4505                	li	a0,1
    4a0c:	a011                	j	4a10 <drivetests+0xde>
  return 0;
    4a0e:	854e                	mv	a0,s3
}
    4a10:	70a6                	ld	ra,104(sp)
    4a12:	7406                	ld	s0,96(sp)
    4a14:	64e6                	ld	s1,88(sp)
    4a16:	6946                	ld	s2,80(sp)
    4a18:	69a6                	ld	s3,72(sp)
    4a1a:	6a06                	ld	s4,64(sp)
    4a1c:	7ae2                	ld	s5,56(sp)
    4a1e:	7b42                	ld	s6,48(sp)
    4a20:	7ba2                	ld	s7,40(sp)
    4a22:	7c02                	ld	s8,32(sp)
    4a24:	6ce2                	ld	s9,24(sp)
    4a26:	6d42                	ld	s10,16(sp)
    4a28:	6da2                	ld	s11,8(sp)
    4a2a:	6165                	add	sp,sp,112
    4a2c:	8082                	ret

0000000000004a2e <main>:

int
main(int argc, char *argv[])
{
    4a2e:	1101                	add	sp,sp,-32
    4a30:	ec06                	sd	ra,24(sp)
    4a32:	e822                	sd	s0,16(sp)
    4a34:	e426                	sd	s1,8(sp)
    4a36:	e04a                	sd	s2,0(sp)
    4a38:	1000                	add	s0,sp,32
    4a3a:	84aa                	mv	s1,a0
  int continuous = 0;
  int quick = 0;
  char *justone = 0;

  if(argc == 2 && strcmp(argv[1], "-q") == 0){
    4a3c:	4789                	li	a5,2
    4a3e:	00f50e63          	beq	a0,a5,4a5a <main+0x2c>
    continuous = 1;
  } else if(argc == 2 && strcmp(argv[1], "-C") == 0){
    continuous = 2;
  } else if(argc == 2 && argv[1][0] != '-'){
    justone = argv[1];
  } else if(argc > 1){
    4a42:	4785                	li	a5,1
    4a44:	06a7c663          	blt	a5,a0,4ab0 <main+0x82>
  char *justone = 0;
    4a48:	4601                	li	a2,0
  int quick = 0;
    4a4a:	4501                	li	a0,0
  int continuous = 0;
    4a4c:	4581                	li	a1,0
    printf("Usage: usertests [-c] [-C] [-q] [testname]\n");
    exit(1);
  }
  if (drivetests(quick, continuous, justone)) {
    4a4e:	ee5ff0ef          	jal	4932 <drivetests>
    4a52:	cd35                	beqz	a0,4ace <main+0xa0>
    exit(1);
    4a54:	4505                	li	a0,1
    4a56:	458000ef          	jal	4eae <exit>
    4a5a:	892e                	mv	s2,a1
  if(argc == 2 && strcmp(argv[1], "-q") == 0){
    4a5c:	00003597          	auipc	a1,0x3
    4a60:	c1458593          	add	a1,a1,-1004 # 7670 <malloc+0x229e>
    4a64:	00893503          	ld	a0,8(s2) # ffffffffffffd008 <base+0xfffffffffffee350>
    4a68:	0a4000ef          	jal	4b0c <strcmp>
    4a6c:	85aa                	mv	a1,a0
    4a6e:	e501                	bnez	a0,4a76 <main+0x48>
  char *justone = 0;
    4a70:	4601                	li	a2,0
    quick = 1;
    4a72:	4505                	li	a0,1
    4a74:	bfe9                	j	4a4e <main+0x20>
  } else if(argc == 2 && strcmp(argv[1], "-c") == 0){
    4a76:	00003597          	auipc	a1,0x3
    4a7a:	c0258593          	add	a1,a1,-1022 # 7678 <malloc+0x22a6>
    4a7e:	00893503          	ld	a0,8(s2)
    4a82:	08a000ef          	jal	4b0c <strcmp>
    4a86:	cd15                	beqz	a0,4ac2 <main+0x94>
  } else if(argc == 2 && strcmp(argv[1], "-C") == 0){
    4a88:	00003597          	auipc	a1,0x3
    4a8c:	c4058593          	add	a1,a1,-960 # 76c8 <malloc+0x22f6>
    4a90:	00893503          	ld	a0,8(s2)
    4a94:	078000ef          	jal	4b0c <strcmp>
    4a98:	c905                	beqz	a0,4ac8 <main+0x9a>
  } else if(argc == 2 && argv[1][0] != '-'){
    4a9a:	00893603          	ld	a2,8(s2)
    4a9e:	00064703          	lbu	a4,0(a2) # 1000 <badarg>
    4aa2:	02d00793          	li	a5,45
    4aa6:	00f70563          	beq	a4,a5,4ab0 <main+0x82>
  int quick = 0;
    4aaa:	4501                	li	a0,0
  int continuous = 0;
    4aac:	4581                	li	a1,0
    4aae:	b745                	j	4a4e <main+0x20>
    printf("Usage: usertests [-c] [-C] [-q] [testname]\n");
    4ab0:	00003517          	auipc	a0,0x3
    4ab4:	bd050513          	add	a0,a0,-1072 # 7680 <malloc+0x22ae>
    4ab8:	067000ef          	jal	531e <printf>
    exit(1);
    4abc:	4505                	li	a0,1
    4abe:	3f0000ef          	jal	4eae <exit>
  char *justone = 0;
    4ac2:	4601                	li	a2,0
    continuous = 1;
    4ac4:	4585                	li	a1,1
    4ac6:	b761                	j	4a4e <main+0x20>
    continuous = 2;
    4ac8:	85a6                	mv	a1,s1
  char *justone = 0;
    4aca:	4601                	li	a2,0
    4acc:	b749                	j	4a4e <main+0x20>
  }
  printf("ALL TESTS PASSED\n");
    4ace:	00003517          	auipc	a0,0x3
    4ad2:	be250513          	add	a0,a0,-1054 # 76b0 <malloc+0x22de>
    4ad6:	049000ef          	jal	531e <printf>
  exit(0);
    4ada:	4501                	li	a0,0
    4adc:	3d2000ef          	jal	4eae <exit>

0000000000004ae0 <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start(int argc, char **argv)
{
    4ae0:	1141                	add	sp,sp,-16
    4ae2:	e406                	sd	ra,8(sp)
    4ae4:	e022                	sd	s0,0(sp)
    4ae6:	0800                	add	s0,sp,16
  int r;
  extern int main(int argc, char **argv);
  r = main(argc, argv);
    4ae8:	f47ff0ef          	jal	4a2e <main>
  exit(r);
    4aec:	3c2000ef          	jal	4eae <exit>

0000000000004af0 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
    4af0:	1141                	add	sp,sp,-16
    4af2:	e422                	sd	s0,8(sp)
    4af4:	0800                	add	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    4af6:	87aa                	mv	a5,a0
    4af8:	0585                	add	a1,a1,1
    4afa:	0785                	add	a5,a5,1
    4afc:	fff5c703          	lbu	a4,-1(a1)
    4b00:	fee78fa3          	sb	a4,-1(a5)
    4b04:	fb75                	bnez	a4,4af8 <strcpy+0x8>
    ;
  return os;
}
    4b06:	6422                	ld	s0,8(sp)
    4b08:	0141                	add	sp,sp,16
    4b0a:	8082                	ret

0000000000004b0c <strcmp>:

int
strcmp(const char *p, const char *q)
{
    4b0c:	1141                	add	sp,sp,-16
    4b0e:	e422                	sd	s0,8(sp)
    4b10:	0800                	add	s0,sp,16
  while(*p && *p == *q)
    4b12:	00054783          	lbu	a5,0(a0)
    4b16:	cb91                	beqz	a5,4b2a <strcmp+0x1e>
    4b18:	0005c703          	lbu	a4,0(a1)
    4b1c:	00f71763          	bne	a4,a5,4b2a <strcmp+0x1e>
    p++, q++;
    4b20:	0505                	add	a0,a0,1
    4b22:	0585                	add	a1,a1,1
  while(*p && *p == *q)
    4b24:	00054783          	lbu	a5,0(a0)
    4b28:	fbe5                	bnez	a5,4b18 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
    4b2a:	0005c503          	lbu	a0,0(a1)
}
    4b2e:	40a7853b          	subw	a0,a5,a0
    4b32:	6422                	ld	s0,8(sp)
    4b34:	0141                	add	sp,sp,16
    4b36:	8082                	ret

0000000000004b38 <strncmp>:

int
strncmp(const char *p, const char *q, uint n)
{
    4b38:	1141                	add	sp,sp,-16
    4b3a:	e422                	sd	s0,8(sp)
    4b3c:	0800                	add	s0,sp,16
  while(n > 0 && *p && *p == *q) {
    4b3e:	ce11                	beqz	a2,4b5a <strncmp+0x22>
    4b40:	00054783          	lbu	a5,0(a0)
    4b44:	cf89                	beqz	a5,4b5e <strncmp+0x26>
    4b46:	0005c703          	lbu	a4,0(a1)
    4b4a:	00f71a63          	bne	a4,a5,4b5e <strncmp+0x26>
    p++, q++, n--;
    4b4e:	0505                	add	a0,a0,1
    4b50:	0585                	add	a1,a1,1
    4b52:	367d                	addw	a2,a2,-1
  while(n > 0 && *p && *p == *q) {
    4b54:	f675                	bnez	a2,4b40 <strncmp+0x8>
  }
  if (n == 0)
    return 0;
    4b56:	4501                	li	a0,0
    4b58:	a801                	j	4b68 <strncmp+0x30>
    4b5a:	4501                	li	a0,0
    4b5c:	a031                	j	4b68 <strncmp+0x30>
  return (uchar)*p - (uchar)*q;
    4b5e:	00054503          	lbu	a0,0(a0)
    4b62:	0005c783          	lbu	a5,0(a1)
    4b66:	9d1d                	subw	a0,a0,a5
}
    4b68:	6422                	ld	s0,8(sp)
    4b6a:	0141                	add	sp,sp,16
    4b6c:	8082                	ret

0000000000004b6e <strcat>:

char*
strcat(char *dst, const char *src)
{
    4b6e:	1141                	add	sp,sp,-16
    4b70:	e422                	sd	s0,8(sp)
    4b72:	0800                	add	s0,sp,16
  char *p = dst;
  while(*p) p++;
    4b74:	00054783          	lbu	a5,0(a0)
    4b78:	c385                	beqz	a5,4b98 <strcat+0x2a>
  char *p = dst;
    4b7a:	87aa                	mv	a5,a0
  while(*p) p++;
    4b7c:	0785                	add	a5,a5,1
    4b7e:	0007c703          	lbu	a4,0(a5)
    4b82:	ff6d                	bnez	a4,4b7c <strcat+0xe>
  while((*p++ = *src++) != 0);
    4b84:	0585                	add	a1,a1,1
    4b86:	0785                	add	a5,a5,1
    4b88:	fff5c703          	lbu	a4,-1(a1)
    4b8c:	fee78fa3          	sb	a4,-1(a5)
    4b90:	fb75                	bnez	a4,4b84 <strcat+0x16>
  return dst;
}
    4b92:	6422                	ld	s0,8(sp)
    4b94:	0141                	add	sp,sp,16
    4b96:	8082                	ret
  char *p = dst;
    4b98:	87aa                	mv	a5,a0
    4b9a:	b7ed                	j	4b84 <strcat+0x16>

0000000000004b9c <strncpy>:

char*
strncpy(char *dst, const char *src, int n)
{
    4b9c:	1141                	add	sp,sp,-16
    4b9e:	e422                	sd	s0,8(sp)
    4ba0:	0800                	add	s0,sp,16
  char *p = dst;
    4ba2:	87aa                	mv	a5,a0
  while(n > 0 && *src) {
    4ba4:	02c05463          	blez	a2,4bcc <strncpy+0x30>
    4ba8:	0005c703          	lbu	a4,0(a1)
    4bac:	cb01                	beqz	a4,4bbc <strncpy+0x20>
    *p++ = *src++;
    4bae:	0585                	add	a1,a1,1
    4bb0:	0785                	add	a5,a5,1
    4bb2:	fee78fa3          	sb	a4,-1(a5)
    n--;
    4bb6:	367d                	addw	a2,a2,-1
  while(n > 0 && *src) {
    4bb8:	fa65                	bnez	a2,4ba8 <strncpy+0xc>
    4bba:	a809                	j	4bcc <strncpy+0x30>
  }
  while(n > 0) {
    4bbc:	1602                	sll	a2,a2,0x20
    4bbe:	9201                	srl	a2,a2,0x20
    4bc0:	963e                	add	a2,a2,a5
    *p++ = 0;
    4bc2:	0785                	add	a5,a5,1
    4bc4:	fe078fa3          	sb	zero,-1(a5)
  while(n > 0) {
    4bc8:	fec79de3          	bne	a5,a2,4bc2 <strncpy+0x26>
    n--;
  }
  return dst;
}
    4bcc:	6422                	ld	s0,8(sp)
    4bce:	0141                	add	sp,sp,16
    4bd0:	8082                	ret

0000000000004bd2 <strlen>:

uint
strlen(const char *s)
{
    4bd2:	1141                	add	sp,sp,-16
    4bd4:	e422                	sd	s0,8(sp)
    4bd6:	0800                	add	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
    4bd8:	00054783          	lbu	a5,0(a0)
    4bdc:	cf91                	beqz	a5,4bf8 <strlen+0x26>
    4bde:	0505                	add	a0,a0,1
    4be0:	87aa                	mv	a5,a0
    4be2:	86be                	mv	a3,a5
    4be4:	0785                	add	a5,a5,1
    4be6:	fff7c703          	lbu	a4,-1(a5)
    4bea:	ff65                	bnez	a4,4be2 <strlen+0x10>
    4bec:	40a6853b          	subw	a0,a3,a0
    4bf0:	2505                	addw	a0,a0,1
    ;
  return n;
}
    4bf2:	6422                	ld	s0,8(sp)
    4bf4:	0141                	add	sp,sp,16
    4bf6:	8082                	ret
  for(n = 0; s[n]; n++)
    4bf8:	4501                	li	a0,0
    4bfa:	bfe5                	j	4bf2 <strlen+0x20>

0000000000004bfc <memset>:

void*
memset(void *dst, int c, uint n)
{
    4bfc:	1141                	add	sp,sp,-16
    4bfe:	e422                	sd	s0,8(sp)
    4c00:	0800                	add	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
    4c02:	ca19                	beqz	a2,4c18 <memset+0x1c>
    4c04:	87aa                	mv	a5,a0
    4c06:	1602                	sll	a2,a2,0x20
    4c08:	9201                	srl	a2,a2,0x20
    4c0a:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
    4c0e:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
    4c12:	0785                	add	a5,a5,1
    4c14:	fee79de3          	bne	a5,a4,4c0e <memset+0x12>
  }
  return dst;
}
    4c18:	6422                	ld	s0,8(sp)
    4c1a:	0141                	add	sp,sp,16
    4c1c:	8082                	ret

0000000000004c1e <strchr>:

char*
strchr(const char *s, char c)
{
    4c1e:	1141                	add	sp,sp,-16
    4c20:	e422                	sd	s0,8(sp)
    4c22:	0800                	add	s0,sp,16
  for(; *s; s++)
    4c24:	00054783          	lbu	a5,0(a0)
    4c28:	cb99                	beqz	a5,4c3e <strchr+0x20>
    if(*s == c)
    4c2a:	00f58763          	beq	a1,a5,4c38 <strchr+0x1a>
  for(; *s; s++)
    4c2e:	0505                	add	a0,a0,1
    4c30:	00054783          	lbu	a5,0(a0)
    4c34:	fbfd                	bnez	a5,4c2a <strchr+0xc>
      return (char*)s;
  return 0;
    4c36:	4501                	li	a0,0
}
    4c38:	6422                	ld	s0,8(sp)
    4c3a:	0141                	add	sp,sp,16
    4c3c:	8082                	ret
  return 0;
    4c3e:	4501                	li	a0,0
    4c40:	bfe5                	j	4c38 <strchr+0x1a>

0000000000004c42 <gets>:

char*
gets(char *buf, int max)
{
    4c42:	711d                	add	sp,sp,-96
    4c44:	ec86                	sd	ra,88(sp)
    4c46:	e8a2                	sd	s0,80(sp)
    4c48:	e4a6                	sd	s1,72(sp)
    4c4a:	e0ca                	sd	s2,64(sp)
    4c4c:	fc4e                	sd	s3,56(sp)
    4c4e:	f852                	sd	s4,48(sp)
    4c50:	f456                	sd	s5,40(sp)
    4c52:	f05a                	sd	s6,32(sp)
    4c54:	ec5e                	sd	s7,24(sp)
    4c56:	1080                	add	s0,sp,96
    4c58:	8baa                	mv	s7,a0
    4c5a:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    4c5c:	892a                	mv	s2,a0
    4c5e:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
    4c60:	4aa9                	li	s5,10
    4c62:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
    4c64:	89a6                	mv	s3,s1
    4c66:	2485                	addw	s1,s1,1
    4c68:	0344d663          	bge	s1,s4,4c94 <gets+0x52>
    cc = read(0, &c, 1);
    4c6c:	4605                	li	a2,1
    4c6e:	faf40593          	add	a1,s0,-81
    4c72:	4501                	li	a0,0
    4c74:	252000ef          	jal	4ec6 <read>
    if(cc < 1)
    4c78:	00a05e63          	blez	a0,4c94 <gets+0x52>
    buf[i++] = c;
    4c7c:	faf44783          	lbu	a5,-81(s0)
    4c80:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
    4c84:	01578763          	beq	a5,s5,4c92 <gets+0x50>
    4c88:	0905                	add	s2,s2,1
    4c8a:	fd679de3          	bne	a5,s6,4c64 <gets+0x22>
    buf[i++] = c;
    4c8e:	89a6                	mv	s3,s1
    4c90:	a011                	j	4c94 <gets+0x52>
    4c92:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
    4c94:	99de                	add	s3,s3,s7
    4c96:	00098023          	sb	zero,0(s3)
  return buf;
}
    4c9a:	855e                	mv	a0,s7
    4c9c:	60e6                	ld	ra,88(sp)
    4c9e:	6446                	ld	s0,80(sp)
    4ca0:	64a6                	ld	s1,72(sp)
    4ca2:	6906                	ld	s2,64(sp)
    4ca4:	79e2                	ld	s3,56(sp)
    4ca6:	7a42                	ld	s4,48(sp)
    4ca8:	7aa2                	ld	s5,40(sp)
    4caa:	7b02                	ld	s6,32(sp)
    4cac:	6be2                	ld	s7,24(sp)
    4cae:	6125                	add	sp,sp,96
    4cb0:	8082                	ret

0000000000004cb2 <stat>:

int
stat(const char *n, struct stat *st)
{
    4cb2:	1101                	add	sp,sp,-32
    4cb4:	ec06                	sd	ra,24(sp)
    4cb6:	e822                	sd	s0,16(sp)
    4cb8:	e04a                	sd	s2,0(sp)
    4cba:	1000                	add	s0,sp,32
    4cbc:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    4cbe:	4581                	li	a1,0
    4cc0:	22e000ef          	jal	4eee <open>
  if(fd < 0)
    4cc4:	02054263          	bltz	a0,4ce8 <stat+0x36>
    4cc8:	e426                	sd	s1,8(sp)
    4cca:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
    4ccc:	85ca                	mv	a1,s2
    4cce:	238000ef          	jal	4f06 <fstat>
    4cd2:	892a                	mv	s2,a0
  close(fd);
    4cd4:	8526                	mv	a0,s1
    4cd6:	200000ef          	jal	4ed6 <close>
  return r;
    4cda:	64a2                	ld	s1,8(sp)
}
    4cdc:	854a                	mv	a0,s2
    4cde:	60e2                	ld	ra,24(sp)
    4ce0:	6442                	ld	s0,16(sp)
    4ce2:	6902                	ld	s2,0(sp)
    4ce4:	6105                	add	sp,sp,32
    4ce6:	8082                	ret
    return -1;
    4ce8:	597d                	li	s2,-1
    4cea:	bfcd                	j	4cdc <stat+0x2a>

0000000000004cec <atoi>:

int
atoi(const char *s)
{
    4cec:	1141                	add	sp,sp,-16
    4cee:	e422                	sd	s0,8(sp)
    4cf0:	0800                	add	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    4cf2:	00054683          	lbu	a3,0(a0)
    4cf6:	fd06879b          	addw	a5,a3,-48 # 3ffd0 <base+0x31318>
    4cfa:	0ff7f793          	zext.b	a5,a5
    4cfe:	4625                	li	a2,9
    4d00:	02f66863          	bltu	a2,a5,4d30 <atoi+0x44>
    4d04:	872a                	mv	a4,a0
  n = 0;
    4d06:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
    4d08:	0705                	add	a4,a4,1 # 1000001 <base+0xff1349>
    4d0a:	0025179b          	sllw	a5,a0,0x2
    4d0e:	9fa9                	addw	a5,a5,a0
    4d10:	0017979b          	sllw	a5,a5,0x1
    4d14:	9fb5                	addw	a5,a5,a3
    4d16:	fd07851b          	addw	a0,a5,-48
  while('0' <= *s && *s <= '9')
    4d1a:	00074683          	lbu	a3,0(a4)
    4d1e:	fd06879b          	addw	a5,a3,-48
    4d22:	0ff7f793          	zext.b	a5,a5
    4d26:	fef671e3          	bgeu	a2,a5,4d08 <atoi+0x1c>
  return n;
}
    4d2a:	6422                	ld	s0,8(sp)
    4d2c:	0141                	add	sp,sp,16
    4d2e:	8082                	ret
  n = 0;
    4d30:	4501                	li	a0,0
    4d32:	bfe5                	j	4d2a <atoi+0x3e>

0000000000004d34 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    4d34:	1141                	add	sp,sp,-16
    4d36:	e422                	sd	s0,8(sp)
    4d38:	0800                	add	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
    4d3a:	02b57463          	bgeu	a0,a1,4d62 <memmove+0x2e>
    while(n-- > 0)
    4d3e:	00c05f63          	blez	a2,4d5c <memmove+0x28>
    4d42:	1602                	sll	a2,a2,0x20
    4d44:	9201                	srl	a2,a2,0x20
    4d46:	00c507b3          	add	a5,a0,a2
  dst = vdst;
    4d4a:	872a                	mv	a4,a0
      *dst++ = *src++;
    4d4c:	0585                	add	a1,a1,1
    4d4e:	0705                	add	a4,a4,1
    4d50:	fff5c683          	lbu	a3,-1(a1)
    4d54:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
    4d58:	fef71ae3          	bne	a4,a5,4d4c <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
    4d5c:	6422                	ld	s0,8(sp)
    4d5e:	0141                	add	sp,sp,16
    4d60:	8082                	ret
    dst += n;
    4d62:	00c50733          	add	a4,a0,a2
    src += n;
    4d66:	95b2                	add	a1,a1,a2
    while(n-- > 0)
    4d68:	fec05ae3          	blez	a2,4d5c <memmove+0x28>
    4d6c:	fff6079b          	addw	a5,a2,-1
    4d70:	1782                	sll	a5,a5,0x20
    4d72:	9381                	srl	a5,a5,0x20
    4d74:	fff7c793          	not	a5,a5
    4d78:	97ba                	add	a5,a5,a4
      *--dst = *--src;
    4d7a:	15fd                	add	a1,a1,-1
    4d7c:	177d                	add	a4,a4,-1
    4d7e:	0005c683          	lbu	a3,0(a1)
    4d82:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
    4d86:	fee79ae3          	bne	a5,a4,4d7a <memmove+0x46>
    4d8a:	bfc9                	j	4d5c <memmove+0x28>

0000000000004d8c <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
    4d8c:	1141                	add	sp,sp,-16
    4d8e:	e422                	sd	s0,8(sp)
    4d90:	0800                	add	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
    4d92:	ca05                	beqz	a2,4dc2 <memcmp+0x36>
    4d94:	fff6069b          	addw	a3,a2,-1
    4d98:	1682                	sll	a3,a3,0x20
    4d9a:	9281                	srl	a3,a3,0x20
    4d9c:	0685                	add	a3,a3,1
    4d9e:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
    4da0:	00054783          	lbu	a5,0(a0)
    4da4:	0005c703          	lbu	a4,0(a1)
    4da8:	00e79863          	bne	a5,a4,4db8 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
    4dac:	0505                	add	a0,a0,1
    p2++;
    4dae:	0585                	add	a1,a1,1
  while (n-- > 0) {
    4db0:	fed518e3          	bne	a0,a3,4da0 <memcmp+0x14>
  }
  return 0;
    4db4:	4501                	li	a0,0
    4db6:	a019                	j	4dbc <memcmp+0x30>
      return *p1 - *p2;
    4db8:	40e7853b          	subw	a0,a5,a4
}
    4dbc:	6422                	ld	s0,8(sp)
    4dbe:	0141                	add	sp,sp,16
    4dc0:	8082                	ret
  return 0;
    4dc2:	4501                	li	a0,0
    4dc4:	bfe5                	j	4dbc <memcmp+0x30>

0000000000004dc6 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
    4dc6:	1141                	add	sp,sp,-16
    4dc8:	e406                	sd	ra,8(sp)
    4dca:	e022                	sd	s0,0(sp)
    4dcc:	0800                	add	s0,sp,16
  return memmove(dst, src, n);
    4dce:	f67ff0ef          	jal	4d34 <memmove>
}
    4dd2:	60a2                	ld	ra,8(sp)
    4dd4:	6402                	ld	s0,0(sp)
    4dd6:	0141                	add	sp,sp,16
    4dd8:	8082                	ret

0000000000004dda <sbrk>:

char *
sbrk(int n) {
    4dda:	1141                	add	sp,sp,-16
    4ddc:	e406                	sd	ra,8(sp)
    4dde:	e022                	sd	s0,0(sp)
    4de0:	0800                	add	s0,sp,16
  return sys_sbrk(n, SBRK_EAGER);
    4de2:	4585                	li	a1,1
    4de4:	152000ef          	jal	4f36 <sys_sbrk>
}
    4de8:	60a2                	ld	ra,8(sp)
    4dea:	6402                	ld	s0,0(sp)
    4dec:	0141                	add	sp,sp,16
    4dee:	8082                	ret

0000000000004df0 <sbrklazy>:

char *
sbrklazy(int n) {
    4df0:	1141                	add	sp,sp,-16
    4df2:	e406                	sd	ra,8(sp)
    4df4:	e022                	sd	s0,0(sp)
    4df6:	0800                	add	s0,sp,16
  return sys_sbrk(n, SBRK_LAZY);
    4df8:	4589                	li	a1,2
    4dfa:	13c000ef          	jal	4f36 <sys_sbrk>
}
    4dfe:	60a2                	ld	ra,8(sp)
    4e00:	6402                	ld	s0,0(sp)
    4e02:	0141                	add	sp,sp,16
    4e04:	8082                	ret

0000000000004e06 <htons>:

// Byte order conversion functions
unsigned short
htons(unsigned short hostshort)
{
    4e06:	1141                	add	sp,sp,-16
    4e08:	e422                	sd	s0,8(sp)
    4e0a:	0800                	add	s0,sp,16
  return ((hostshort >> 8) & 0xff) | ((hostshort & 0xff) << 8);
    4e0c:	0085179b          	sllw	a5,a0,0x8
    4e10:	0085551b          	srlw	a0,a0,0x8
    4e14:	8d5d                	or	a0,a0,a5
}
    4e16:	1542                	sll	a0,a0,0x30
    4e18:	9141                	srl	a0,a0,0x30
    4e1a:	6422                	ld	s0,8(sp)
    4e1c:	0141                	add	sp,sp,16
    4e1e:	8082                	ret

0000000000004e20 <ntohs>:

unsigned short
ntohs(unsigned short netshort)
{
    4e20:	1141                	add	sp,sp,-16
    4e22:	e422                	sd	s0,8(sp)
    4e24:	0800                	add	s0,sp,16
  return ((netshort >> 8) & 0xff) | ((netshort & 0xff) << 8);
    4e26:	0085179b          	sllw	a5,a0,0x8
    4e2a:	0085551b          	srlw	a0,a0,0x8
    4e2e:	8d5d                	or	a0,a0,a5
}
    4e30:	1542                	sll	a0,a0,0x30
    4e32:	9141                	srl	a0,a0,0x30
    4e34:	6422                	ld	s0,8(sp)
    4e36:	0141                	add	sp,sp,16
    4e38:	8082                	ret

0000000000004e3a <htonl>:

unsigned long
htonl(unsigned long hostlong)
{
    4e3a:	1141                	add	sp,sp,-16
    4e3c:	e422                	sd	s0,8(sp)
    4e3e:	0800                	add	s0,sp,16
  return ((hostlong >> 24) & 0xff) |
    4e40:	0185579b          	srlw	a5,a0,0x18
         ((hostlong >> 8) & 0xff00) |
    4e44:	00855713          	srl	a4,a0,0x8
    4e48:	66c1                	lui	a3,0x10
    4e4a:	f0068693          	add	a3,a3,-256 # ff00 <base+0x1248>
    4e4e:	8f75                	and	a4,a4,a3
  return ((hostlong >> 24) & 0xff) |
    4e50:	8fd9                	or	a5,a5,a4
         ((hostlong & 0xff00) << 8) |
    4e52:	00851713          	sll	a4,a0,0x8
    4e56:	00ff06b7          	lui	a3,0xff0
    4e5a:	8f75                	and	a4,a4,a3
         ((hostlong >> 8) & 0xff00) |
    4e5c:	8fd9                	or	a5,a5,a4
         ((hostlong & 0xff) << 24);
    4e5e:	0562                	sll	a0,a0,0x18
    4e60:	0ff00713          	li	a4,255
    4e64:	0762                	sll	a4,a4,0x18
    4e66:	8d79                	and	a0,a0,a4
}
    4e68:	8d5d                	or	a0,a0,a5
    4e6a:	6422                	ld	s0,8(sp)
    4e6c:	0141                	add	sp,sp,16
    4e6e:	8082                	ret

0000000000004e70 <ntohl>:

unsigned long
ntohl(unsigned long netlong)
{
    4e70:	1141                	add	sp,sp,-16
    4e72:	e422                	sd	s0,8(sp)
    4e74:	0800                	add	s0,sp,16
  return ((netlong >> 24) & 0xff) |
    4e76:	0185579b          	srlw	a5,a0,0x18
         ((netlong >> 8) & 0xff00) |
    4e7a:	00855713          	srl	a4,a0,0x8
    4e7e:	66c1                	lui	a3,0x10
    4e80:	f0068693          	add	a3,a3,-256 # ff00 <base+0x1248>
    4e84:	8f75                	and	a4,a4,a3
  return ((netlong >> 24) & 0xff) |
    4e86:	8fd9                	or	a5,a5,a4
         ((netlong & 0xff00) << 8) |
    4e88:	00851713          	sll	a4,a0,0x8
    4e8c:	00ff06b7          	lui	a3,0xff0
    4e90:	8f75                	and	a4,a4,a3
         ((netlong >> 8) & 0xff00) |
    4e92:	8fd9                	or	a5,a5,a4
         ((netlong & 0xff) << 24);
    4e94:	0562                	sll	a0,a0,0x18
    4e96:	0ff00713          	li	a4,255
    4e9a:	0762                	sll	a4,a4,0x18
    4e9c:	8d79                	and	a0,a0,a4
}
    4e9e:	8d5d                	or	a0,a0,a5
    4ea0:	6422                	ld	s0,8(sp)
    4ea2:	0141                	add	sp,sp,16
    4ea4:	8082                	ret

0000000000004ea6 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
    4ea6:	4885                	li	a7,1
 ecall
    4ea8:	00000073          	ecall
 ret
    4eac:	8082                	ret

0000000000004eae <exit>:
.global exit
exit:
 li a7, SYS_exit
    4eae:	4889                	li	a7,2
 ecall
    4eb0:	00000073          	ecall
 ret
    4eb4:	8082                	ret

0000000000004eb6 <wait>:
.global wait
wait:
 li a7, SYS_wait
    4eb6:	488d                	li	a7,3
 ecall
    4eb8:	00000073          	ecall
 ret
    4ebc:	8082                	ret

0000000000004ebe <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
    4ebe:	4891                	li	a7,4
 ecall
    4ec0:	00000073          	ecall
 ret
    4ec4:	8082                	ret

0000000000004ec6 <read>:
.global read
read:
 li a7, SYS_read
    4ec6:	4895                	li	a7,5
 ecall
    4ec8:	00000073          	ecall
 ret
    4ecc:	8082                	ret

0000000000004ece <write>:
.global write
write:
 li a7, SYS_write
    4ece:	48c1                	li	a7,16
 ecall
    4ed0:	00000073          	ecall
 ret
    4ed4:	8082                	ret

0000000000004ed6 <close>:
.global close
close:
 li a7, SYS_close
    4ed6:	48d5                	li	a7,21
 ecall
    4ed8:	00000073          	ecall
 ret
    4edc:	8082                	ret

0000000000004ede <kill>:
.global kill
kill:
 li a7, SYS_kill
    4ede:	4899                	li	a7,6
 ecall
    4ee0:	00000073          	ecall
 ret
    4ee4:	8082                	ret

0000000000004ee6 <exec>:
.global exec
exec:
 li a7, SYS_exec
    4ee6:	489d                	li	a7,7
 ecall
    4ee8:	00000073          	ecall
 ret
    4eec:	8082                	ret

0000000000004eee <open>:
.global open
open:
 li a7, SYS_open
    4eee:	48bd                	li	a7,15
 ecall
    4ef0:	00000073          	ecall
 ret
    4ef4:	8082                	ret

0000000000004ef6 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
    4ef6:	48c5                	li	a7,17
 ecall
    4ef8:	00000073          	ecall
 ret
    4efc:	8082                	ret

0000000000004efe <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
    4efe:	48c9                	li	a7,18
 ecall
    4f00:	00000073          	ecall
 ret
    4f04:	8082                	ret

0000000000004f06 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
    4f06:	48a1                	li	a7,8
 ecall
    4f08:	00000073          	ecall
 ret
    4f0c:	8082                	ret

0000000000004f0e <link>:
.global link
link:
 li a7, SYS_link
    4f0e:	48cd                	li	a7,19
 ecall
    4f10:	00000073          	ecall
 ret
    4f14:	8082                	ret

0000000000004f16 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
    4f16:	48d1                	li	a7,20
 ecall
    4f18:	00000073          	ecall
 ret
    4f1c:	8082                	ret

0000000000004f1e <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
    4f1e:	48a5                	li	a7,9
 ecall
    4f20:	00000073          	ecall
 ret
    4f24:	8082                	ret

0000000000004f26 <dup>:
.global dup
dup:
 li a7, SYS_dup
    4f26:	48a9                	li	a7,10
 ecall
    4f28:	00000073          	ecall
 ret
    4f2c:	8082                	ret

0000000000004f2e <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
    4f2e:	48ad                	li	a7,11
 ecall
    4f30:	00000073          	ecall
 ret
    4f34:	8082                	ret

0000000000004f36 <sys_sbrk>:
.global sys_sbrk
sys_sbrk:
 li a7, SYS_sbrk
    4f36:	48b1                	li	a7,12
 ecall
    4f38:	00000073          	ecall
 ret
    4f3c:	8082                	ret

0000000000004f3e <pause>:
.global pause
pause:
 li a7, SYS_pause
    4f3e:	48b5                	li	a7,13
 ecall
    4f40:	00000073          	ecall
 ret
    4f44:	8082                	ret

0000000000004f46 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
    4f46:	48b9                	li	a7,14
 ecall
    4f48:	00000073          	ecall
 ret
    4f4c:	8082                	ret

0000000000004f4e <socket>:
.global socket
socket:
 li a7, SYS_socket
    4f4e:	48d9                	li	a7,22
 ecall
    4f50:	00000073          	ecall
 ret
    4f54:	8082                	ret

0000000000004f56 <bind>:
.global bind
bind:
 li a7, SYS_bind
    4f56:	48dd                	li	a7,23
 ecall
    4f58:	00000073          	ecall
 ret
    4f5c:	8082                	ret

0000000000004f5e <listen>:
.global listen
listen:
 li a7, SYS_listen
    4f5e:	48e1                	li	a7,24
 ecall
    4f60:	00000073          	ecall
 ret
    4f64:	8082                	ret

0000000000004f66 <accept>:
.global accept
accept:
 li a7, SYS_accept
    4f66:	48e5                	li	a7,25
 ecall
    4f68:	00000073          	ecall
 ret
    4f6c:	8082                	ret

0000000000004f6e <connect>:
.global connect
connect:
 li a7, SYS_connect
    4f6e:	48e9                	li	a7,26
 ecall
    4f70:	00000073          	ecall
 ret
    4f74:	8082                	ret

0000000000004f76 <send>:
.global send
send:
 li a7, SYS_send
    4f76:	48ed                	li	a7,27
 ecall
    4f78:	00000073          	ecall
 ret
    4f7c:	8082                	ret

0000000000004f7e <recv>:
.global recv
recv:
 li a7, SYS_recv
    4f7e:	48f1                	li	a7,28
 ecall
    4f80:	00000073          	ecall
 ret
    4f84:	8082                	ret

0000000000004f86 <sendto>:
.global sendto
sendto:
 li a7, SYS_sendto
    4f86:	48f5                	li	a7,29
 ecall
    4f88:	00000073          	ecall
 ret
    4f8c:	8082                	ret

0000000000004f8e <recvfrom>:
.global recvfrom
recvfrom:
 li a7, SYS_recvfrom
    4f8e:	48f9                	li	a7,30
 ecall
    4f90:	00000073          	ecall
 ret
    4f94:	8082                	ret

0000000000004f96 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
    4f96:	1101                	add	sp,sp,-32
    4f98:	ec06                	sd	ra,24(sp)
    4f9a:	e822                	sd	s0,16(sp)
    4f9c:	1000                	add	s0,sp,32
    4f9e:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
    4fa2:	4605                	li	a2,1
    4fa4:	fef40593          	add	a1,s0,-17
    4fa8:	f27ff0ef          	jal	4ece <write>
}
    4fac:	60e2                	ld	ra,24(sp)
    4fae:	6442                	ld	s0,16(sp)
    4fb0:	6105                	add	sp,sp,32
    4fb2:	8082                	ret

0000000000004fb4 <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
    4fb4:	715d                	add	sp,sp,-80
    4fb6:	e486                	sd	ra,72(sp)
    4fb8:	e0a2                	sd	s0,64(sp)
    4fba:	f84a                	sd	s2,48(sp)
    4fbc:	0880                	add	s0,sp,80
    4fbe:	892a                	mv	s2,a0
  char buf[20];
  int i, neg;
  unsigned long long x;

  neg = 0;
  if(sgn && xx < 0){
    4fc0:	c299                	beqz	a3,4fc6 <printint+0x12>
    4fc2:	0805c363          	bltz	a1,5048 <printint+0x94>
  neg = 0;
    4fc6:	4881                	li	a7,0
    4fc8:	fb840693          	add	a3,s0,-72
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
    4fcc:	4781                	li	a5,0
  do{
    buf[i++] = digits[x % base];
    4fce:	00003517          	auipc	a0,0x3
    4fd2:	b2a50513          	add	a0,a0,-1238 # 7af8 <digits>
    4fd6:	883e                	mv	a6,a5
    4fd8:	2785                	addw	a5,a5,1
    4fda:	02c5f733          	remu	a4,a1,a2
    4fde:	972a                	add	a4,a4,a0
    4fe0:	00074703          	lbu	a4,0(a4)
    4fe4:	00e68023          	sb	a4,0(a3) # ff0000 <base+0xfe1348>
  }while((x /= base) != 0);
    4fe8:	872e                	mv	a4,a1
    4fea:	02c5d5b3          	divu	a1,a1,a2
    4fee:	0685                	add	a3,a3,1
    4ff0:	fec773e3          	bgeu	a4,a2,4fd6 <printint+0x22>
  if(neg)
    4ff4:	00088b63          	beqz	a7,500a <printint+0x56>
    buf[i++] = '-';
    4ff8:	fd078793          	add	a5,a5,-48
    4ffc:	97a2                	add	a5,a5,s0
    4ffe:	02d00713          	li	a4,45
    5002:	fee78423          	sb	a4,-24(a5)
    5006:	0028079b          	addw	a5,a6,2

  while(--i >= 0)
    500a:	02f05a63          	blez	a5,503e <printint+0x8a>
    500e:	fc26                	sd	s1,56(sp)
    5010:	f44e                	sd	s3,40(sp)
    5012:	fb840713          	add	a4,s0,-72
    5016:	00f704b3          	add	s1,a4,a5
    501a:	fff70993          	add	s3,a4,-1
    501e:	99be                	add	s3,s3,a5
    5020:	37fd                	addw	a5,a5,-1
    5022:	1782                	sll	a5,a5,0x20
    5024:	9381                	srl	a5,a5,0x20
    5026:	40f989b3          	sub	s3,s3,a5
    putc(fd, buf[i]);
    502a:	fff4c583          	lbu	a1,-1(s1)
    502e:	854a                	mv	a0,s2
    5030:	f67ff0ef          	jal	4f96 <putc>
  while(--i >= 0)
    5034:	14fd                	add	s1,s1,-1
    5036:	ff349ae3          	bne	s1,s3,502a <printint+0x76>
    503a:	74e2                	ld	s1,56(sp)
    503c:	79a2                	ld	s3,40(sp)
}
    503e:	60a6                	ld	ra,72(sp)
    5040:	6406                	ld	s0,64(sp)
    5042:	7942                	ld	s2,48(sp)
    5044:	6161                	add	sp,sp,80
    5046:	8082                	ret
    x = -xx;
    5048:	40b005b3          	neg	a1,a1
    neg = 1;
    504c:	4885                	li	a7,1
    x = -xx;
    504e:	bfad                	j	4fc8 <printint+0x14>

0000000000005050 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %c, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
    5050:	711d                	add	sp,sp,-96
    5052:	ec86                	sd	ra,88(sp)
    5054:	e8a2                	sd	s0,80(sp)
    5056:	e0ca                	sd	s2,64(sp)
    5058:	1080                	add	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
    505a:	0005c903          	lbu	s2,0(a1)
    505e:	28090663          	beqz	s2,52ea <vprintf+0x29a>
    5062:	e4a6                	sd	s1,72(sp)
    5064:	fc4e                	sd	s3,56(sp)
    5066:	f852                	sd	s4,48(sp)
    5068:	f456                	sd	s5,40(sp)
    506a:	f05a                	sd	s6,32(sp)
    506c:	ec5e                	sd	s7,24(sp)
    506e:	e862                	sd	s8,16(sp)
    5070:	e466                	sd	s9,8(sp)
    5072:	8b2a                	mv	s6,a0
    5074:	8a2e                	mv	s4,a1
    5076:	8bb2                	mv	s7,a2
  state = 0;
    5078:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
    507a:	4481                	li	s1,0
    507c:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
    507e:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
    5082:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
    5086:	06c00c93          	li	s9,108
    508a:	a005                	j	50aa <vprintf+0x5a>
        putc(fd, c0);
    508c:	85ca                	mv	a1,s2
    508e:	855a                	mv	a0,s6
    5090:	f07ff0ef          	jal	4f96 <putc>
    5094:	a019                	j	509a <vprintf+0x4a>
    } else if(state == '%'){
    5096:	03598263          	beq	s3,s5,50ba <vprintf+0x6a>
  for(i = 0; fmt[i]; i++){
    509a:	2485                	addw	s1,s1,1
    509c:	8726                	mv	a4,s1
    509e:	009a07b3          	add	a5,s4,s1
    50a2:	0007c903          	lbu	s2,0(a5)
    50a6:	22090a63          	beqz	s2,52da <vprintf+0x28a>
    c0 = fmt[i] & 0xff;
    50aa:	0009079b          	sext.w	a5,s2
    if(state == 0){
    50ae:	fe0994e3          	bnez	s3,5096 <vprintf+0x46>
      if(c0 == '%'){
    50b2:	fd579de3          	bne	a5,s5,508c <vprintf+0x3c>
        state = '%';
    50b6:	89be                	mv	s3,a5
    50b8:	b7cd                	j	509a <vprintf+0x4a>
      if(c0) c1 = fmt[i+1] & 0xff;
    50ba:	00ea06b3          	add	a3,s4,a4
    50be:	0016c683          	lbu	a3,1(a3)
      c1 = c2 = 0;
    50c2:	8636                	mv	a2,a3
      if(c1) c2 = fmt[i+2] & 0xff;
    50c4:	c681                	beqz	a3,50cc <vprintf+0x7c>
    50c6:	9752                	add	a4,a4,s4
    50c8:	00274603          	lbu	a2,2(a4)
      if(c0 == 'd'){
    50cc:	05878363          	beq	a5,s8,5112 <vprintf+0xc2>
      } else if(c0 == 'l' && c1 == 'd'){
    50d0:	05978d63          	beq	a5,s9,512a <vprintf+0xda>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
    50d4:	07500713          	li	a4,117
    50d8:	0ee78763          	beq	a5,a4,51c6 <vprintf+0x176>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
    50dc:	07800713          	li	a4,120
    50e0:	12e78963          	beq	a5,a4,5212 <vprintf+0x1c2>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
    50e4:	07000713          	li	a4,112
    50e8:	14e78e63          	beq	a5,a4,5244 <vprintf+0x1f4>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 'c'){
    50ec:	06300713          	li	a4,99
    50f0:	18e78e63          	beq	a5,a4,528c <vprintf+0x23c>
        putc(fd, va_arg(ap, uint32));
      } else if(c0 == 's'){
    50f4:	07300713          	li	a4,115
    50f8:	1ae78463          	beq	a5,a4,52a0 <vprintf+0x250>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
    50fc:	02500713          	li	a4,37
    5100:	04e79563          	bne	a5,a4,514a <vprintf+0xfa>
        putc(fd, '%');
    5104:	02500593          	li	a1,37
    5108:	855a                	mv	a0,s6
    510a:	e8dff0ef          	jal	4f96 <putc>
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c0);
      }

      state = 0;
    510e:	4981                	li	s3,0
    5110:	b769                	j	509a <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 1);
    5112:	008b8913          	add	s2,s7,8
    5116:	4685                	li	a3,1
    5118:	4629                	li	a2,10
    511a:	000ba583          	lw	a1,0(s7)
    511e:	855a                	mv	a0,s6
    5120:	e95ff0ef          	jal	4fb4 <printint>
    5124:	8bca                	mv	s7,s2
      state = 0;
    5126:	4981                	li	s3,0
    5128:	bf8d                	j	509a <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'd'){
    512a:	06400793          	li	a5,100
    512e:	02f68963          	beq	a3,a5,5160 <vprintf+0x110>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
    5132:	06c00793          	li	a5,108
    5136:	04f68263          	beq	a3,a5,517a <vprintf+0x12a>
      } else if(c0 == 'l' && c1 == 'u'){
    513a:	07500793          	li	a5,117
    513e:	0af68063          	beq	a3,a5,51de <vprintf+0x18e>
      } else if(c0 == 'l' && c1 == 'x'){
    5142:	07800793          	li	a5,120
    5146:	0ef68263          	beq	a3,a5,522a <vprintf+0x1da>
        putc(fd, '%');
    514a:	02500593          	li	a1,37
    514e:	855a                	mv	a0,s6
    5150:	e47ff0ef          	jal	4f96 <putc>
        putc(fd, c0);
    5154:	85ca                	mv	a1,s2
    5156:	855a                	mv	a0,s6
    5158:	e3fff0ef          	jal	4f96 <putc>
      state = 0;
    515c:	4981                	li	s3,0
    515e:	bf35                	j	509a <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
    5160:	008b8913          	add	s2,s7,8
    5164:	4685                	li	a3,1
    5166:	4629                	li	a2,10
    5168:	000bb583          	ld	a1,0(s7)
    516c:	855a                	mv	a0,s6
    516e:	e47ff0ef          	jal	4fb4 <printint>
        i += 1;
    5172:	2485                	addw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 1);
    5174:	8bca                	mv	s7,s2
      state = 0;
    5176:	4981                	li	s3,0
        i += 1;
    5178:	b70d                	j	509a <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
    517a:	06400793          	li	a5,100
    517e:	02f60763          	beq	a2,a5,51ac <vprintf+0x15c>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
    5182:	07500793          	li	a5,117
    5186:	06f60963          	beq	a2,a5,51f8 <vprintf+0x1a8>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
    518a:	07800793          	li	a5,120
    518e:	faf61ee3          	bne	a2,a5,514a <vprintf+0xfa>
        printint(fd, va_arg(ap, uint64), 16, 0);
    5192:	008b8913          	add	s2,s7,8
    5196:	4681                	li	a3,0
    5198:	4641                	li	a2,16
    519a:	000bb583          	ld	a1,0(s7)
    519e:	855a                	mv	a0,s6
    51a0:	e15ff0ef          	jal	4fb4 <printint>
        i += 2;
    51a4:	2489                	addw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 16, 0);
    51a6:	8bca                	mv	s7,s2
      state = 0;
    51a8:	4981                	li	s3,0
        i += 2;
    51aa:	bdc5                	j	509a <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
    51ac:	008b8913          	add	s2,s7,8
    51b0:	4685                	li	a3,1
    51b2:	4629                	li	a2,10
    51b4:	000bb583          	ld	a1,0(s7)
    51b8:	855a                	mv	a0,s6
    51ba:	dfbff0ef          	jal	4fb4 <printint>
        i += 2;
    51be:	2489                	addw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 1);
    51c0:	8bca                	mv	s7,s2
      state = 0;
    51c2:	4981                	li	s3,0
        i += 2;
    51c4:	bdd9                	j	509a <vprintf+0x4a>
        printint(fd, va_arg(ap, uint32), 10, 0);
    51c6:	008b8913          	add	s2,s7,8
    51ca:	4681                	li	a3,0
    51cc:	4629                	li	a2,10
    51ce:	000be583          	lwu	a1,0(s7)
    51d2:	855a                	mv	a0,s6
    51d4:	de1ff0ef          	jal	4fb4 <printint>
    51d8:	8bca                	mv	s7,s2
      state = 0;
    51da:	4981                	li	s3,0
    51dc:	bd7d                	j	509a <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
    51de:	008b8913          	add	s2,s7,8
    51e2:	4681                	li	a3,0
    51e4:	4629                	li	a2,10
    51e6:	000bb583          	ld	a1,0(s7)
    51ea:	855a                	mv	a0,s6
    51ec:	dc9ff0ef          	jal	4fb4 <printint>
        i += 1;
    51f0:	2485                	addw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 0);
    51f2:	8bca                	mv	s7,s2
      state = 0;
    51f4:	4981                	li	s3,0
        i += 1;
    51f6:	b555                	j	509a <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
    51f8:	008b8913          	add	s2,s7,8
    51fc:	4681                	li	a3,0
    51fe:	4629                	li	a2,10
    5200:	000bb583          	ld	a1,0(s7)
    5204:	855a                	mv	a0,s6
    5206:	dafff0ef          	jal	4fb4 <printint>
        i += 2;
    520a:	2489                	addw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 0);
    520c:	8bca                	mv	s7,s2
      state = 0;
    520e:	4981                	li	s3,0
        i += 2;
    5210:	b569                	j	509a <vprintf+0x4a>
        printint(fd, va_arg(ap, uint32), 16, 0);
    5212:	008b8913          	add	s2,s7,8
    5216:	4681                	li	a3,0
    5218:	4641                	li	a2,16
    521a:	000be583          	lwu	a1,0(s7)
    521e:	855a                	mv	a0,s6
    5220:	d95ff0ef          	jal	4fb4 <printint>
    5224:	8bca                	mv	s7,s2
      state = 0;
    5226:	4981                	li	s3,0
    5228:	bd8d                	j	509a <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 16, 0);
    522a:	008b8913          	add	s2,s7,8
    522e:	4681                	li	a3,0
    5230:	4641                	li	a2,16
    5232:	000bb583          	ld	a1,0(s7)
    5236:	855a                	mv	a0,s6
    5238:	d7dff0ef          	jal	4fb4 <printint>
        i += 1;
    523c:	2485                	addw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 16, 0);
    523e:	8bca                	mv	s7,s2
      state = 0;
    5240:	4981                	li	s3,0
        i += 1;
    5242:	bda1                	j	509a <vprintf+0x4a>
    5244:	e06a                	sd	s10,0(sp)
        printptr(fd, va_arg(ap, uint64));
    5246:	008b8d13          	add	s10,s7,8
    524a:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
    524e:	03000593          	li	a1,48
    5252:	855a                	mv	a0,s6
    5254:	d43ff0ef          	jal	4f96 <putc>
  putc(fd, 'x');
    5258:	07800593          	li	a1,120
    525c:	855a                	mv	a0,s6
    525e:	d39ff0ef          	jal	4f96 <putc>
    5262:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
    5264:	00003b97          	auipc	s7,0x3
    5268:	894b8b93          	add	s7,s7,-1900 # 7af8 <digits>
    526c:	03c9d793          	srl	a5,s3,0x3c
    5270:	97de                	add	a5,a5,s7
    5272:	0007c583          	lbu	a1,0(a5)
    5276:	855a                	mv	a0,s6
    5278:	d1fff0ef          	jal	4f96 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    527c:	0992                	sll	s3,s3,0x4
    527e:	397d                	addw	s2,s2,-1
    5280:	fe0916e3          	bnez	s2,526c <vprintf+0x21c>
        printptr(fd, va_arg(ap, uint64));
    5284:	8bea                	mv	s7,s10
      state = 0;
    5286:	4981                	li	s3,0
    5288:	6d02                	ld	s10,0(sp)
    528a:	bd01                	j	509a <vprintf+0x4a>
        putc(fd, va_arg(ap, uint32));
    528c:	008b8913          	add	s2,s7,8
    5290:	000bc583          	lbu	a1,0(s7)
    5294:	855a                	mv	a0,s6
    5296:	d01ff0ef          	jal	4f96 <putc>
    529a:	8bca                	mv	s7,s2
      state = 0;
    529c:	4981                	li	s3,0
    529e:	bbf5                	j	509a <vprintf+0x4a>
        if((s = va_arg(ap, char*)) == 0)
    52a0:	008b8993          	add	s3,s7,8
    52a4:	000bb903          	ld	s2,0(s7)
    52a8:	00090f63          	beqz	s2,52c6 <vprintf+0x276>
        for(; *s; s++)
    52ac:	00094583          	lbu	a1,0(s2)
    52b0:	c195                	beqz	a1,52d4 <vprintf+0x284>
          putc(fd, *s);
    52b2:	855a                	mv	a0,s6
    52b4:	ce3ff0ef          	jal	4f96 <putc>
        for(; *s; s++)
    52b8:	0905                	add	s2,s2,1
    52ba:	00094583          	lbu	a1,0(s2)
    52be:	f9f5                	bnez	a1,52b2 <vprintf+0x262>
        if((s = va_arg(ap, char*)) == 0)
    52c0:	8bce                	mv	s7,s3
      state = 0;
    52c2:	4981                	li	s3,0
    52c4:	bbd9                	j	509a <vprintf+0x4a>
          s = "(null)";
    52c6:	00002917          	auipc	s2,0x2
    52ca:	78290913          	add	s2,s2,1922 # 7a48 <malloc+0x2676>
        for(; *s; s++)
    52ce:	02800593          	li	a1,40
    52d2:	b7c5                	j	52b2 <vprintf+0x262>
        if((s = va_arg(ap, char*)) == 0)
    52d4:	8bce                	mv	s7,s3
      state = 0;
    52d6:	4981                	li	s3,0
    52d8:	b3c9                	j	509a <vprintf+0x4a>
    52da:	64a6                	ld	s1,72(sp)
    52dc:	79e2                	ld	s3,56(sp)
    52de:	7a42                	ld	s4,48(sp)
    52e0:	7aa2                	ld	s5,40(sp)
    52e2:	7b02                	ld	s6,32(sp)
    52e4:	6be2                	ld	s7,24(sp)
    52e6:	6c42                	ld	s8,16(sp)
    52e8:	6ca2                	ld	s9,8(sp)
    }
  }
}
    52ea:	60e6                	ld	ra,88(sp)
    52ec:	6446                	ld	s0,80(sp)
    52ee:	6906                	ld	s2,64(sp)
    52f0:	6125                	add	sp,sp,96
    52f2:	8082                	ret

00000000000052f4 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
    52f4:	715d                	add	sp,sp,-80
    52f6:	ec06                	sd	ra,24(sp)
    52f8:	e822                	sd	s0,16(sp)
    52fa:	1000                	add	s0,sp,32
    52fc:	e010                	sd	a2,0(s0)
    52fe:	e414                	sd	a3,8(s0)
    5300:	e818                	sd	a4,16(s0)
    5302:	ec1c                	sd	a5,24(s0)
    5304:	03043023          	sd	a6,32(s0)
    5308:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
    530c:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
    5310:	8622                	mv	a2,s0
    5312:	d3fff0ef          	jal	5050 <vprintf>
}
    5316:	60e2                	ld	ra,24(sp)
    5318:	6442                	ld	s0,16(sp)
    531a:	6161                	add	sp,sp,80
    531c:	8082                	ret

000000000000531e <printf>:

void
printf(const char *fmt, ...)
{
    531e:	711d                	add	sp,sp,-96
    5320:	ec06                	sd	ra,24(sp)
    5322:	e822                	sd	s0,16(sp)
    5324:	1000                	add	s0,sp,32
    5326:	e40c                	sd	a1,8(s0)
    5328:	e810                	sd	a2,16(s0)
    532a:	ec14                	sd	a3,24(s0)
    532c:	f018                	sd	a4,32(s0)
    532e:	f41c                	sd	a5,40(s0)
    5330:	03043823          	sd	a6,48(s0)
    5334:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
    5338:	00840613          	add	a2,s0,8
    533c:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
    5340:	85aa                	mv	a1,a0
    5342:	4505                	li	a0,1
    5344:	d0dff0ef          	jal	5050 <vprintf>
}
    5348:	60e2                	ld	ra,24(sp)
    534a:	6442                	ld	s0,16(sp)
    534c:	6125                	add	sp,sp,96
    534e:	8082                	ret

0000000000005350 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    5350:	1141                	add	sp,sp,-16
    5352:	e422                	sd	s0,8(sp)
    5354:	0800                	add	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
    5356:	ff050693          	add	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    535a:	00003797          	auipc	a5,0x3
    535e:	1367b783          	ld	a5,310(a5) # 8490 <freep>
    5362:	a02d                	j	538c <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
    5364:	4618                	lw	a4,8(a2)
    5366:	9f2d                	addw	a4,a4,a1
    5368:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
    536c:	6398                	ld	a4,0(a5)
    536e:	6310                	ld	a2,0(a4)
    5370:	a83d                	j	53ae <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    5372:	ff852703          	lw	a4,-8(a0)
    5376:	9f31                	addw	a4,a4,a2
    5378:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
    537a:	ff053683          	ld	a3,-16(a0)
    537e:	a091                	j	53c2 <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    5380:	6398                	ld	a4,0(a5)
    5382:	00e7e463          	bltu	a5,a4,538a <free+0x3a>
    5386:	00e6ea63          	bltu	a3,a4,539a <free+0x4a>
{
    538a:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    538c:	fed7fae3          	bgeu	a5,a3,5380 <free+0x30>
    5390:	6398                	ld	a4,0(a5)
    5392:	00e6e463          	bltu	a3,a4,539a <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    5396:	fee7eae3          	bltu	a5,a4,538a <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
    539a:	ff852583          	lw	a1,-8(a0)
    539e:	6390                	ld	a2,0(a5)
    53a0:	02059813          	sll	a6,a1,0x20
    53a4:	01c85713          	srl	a4,a6,0x1c
    53a8:	9736                	add	a4,a4,a3
    53aa:	fae60de3          	beq	a2,a4,5364 <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
    53ae:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
    53b2:	4790                	lw	a2,8(a5)
    53b4:	02061593          	sll	a1,a2,0x20
    53b8:	01c5d713          	srl	a4,a1,0x1c
    53bc:	973e                	add	a4,a4,a5
    53be:	fae68ae3          	beq	a3,a4,5372 <free+0x22>
    p->s.ptr = bp->s.ptr;
    53c2:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
    53c4:	00003717          	auipc	a4,0x3
    53c8:	0cf73623          	sd	a5,204(a4) # 8490 <freep>
}
    53cc:	6422                	ld	s0,8(sp)
    53ce:	0141                	add	sp,sp,16
    53d0:	8082                	ret

00000000000053d2 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    53d2:	7139                	add	sp,sp,-64
    53d4:	fc06                	sd	ra,56(sp)
    53d6:	f822                	sd	s0,48(sp)
    53d8:	f426                	sd	s1,40(sp)
    53da:	ec4e                	sd	s3,24(sp)
    53dc:	0080                	add	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    53de:	02051493          	sll	s1,a0,0x20
    53e2:	9081                	srl	s1,s1,0x20
    53e4:	04bd                	add	s1,s1,15
    53e6:	8091                	srl	s1,s1,0x4
    53e8:	0014899b          	addw	s3,s1,1
    53ec:	0485                	add	s1,s1,1
  if((prevp = freep) == 0){
    53ee:	00003517          	auipc	a0,0x3
    53f2:	0a253503          	ld	a0,162(a0) # 8490 <freep>
    53f6:	c915                	beqz	a0,542a <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    53f8:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    53fa:	4798                	lw	a4,8(a5)
    53fc:	08977a63          	bgeu	a4,s1,5490 <malloc+0xbe>
    5400:	f04a                	sd	s2,32(sp)
    5402:	e852                	sd	s4,16(sp)
    5404:	e456                	sd	s5,8(sp)
    5406:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
    5408:	8a4e                	mv	s4,s3
    540a:	0009871b          	sext.w	a4,s3
    540e:	6685                	lui	a3,0x1
    5410:	00d77363          	bgeu	a4,a3,5416 <malloc+0x44>
    5414:	6a05                	lui	s4,0x1
    5416:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
    541a:	004a1a1b          	sllw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    541e:	00003917          	auipc	s2,0x3
    5422:	07290913          	add	s2,s2,114 # 8490 <freep>
  if(p == SBRK_ERROR)
    5426:	5afd                	li	s5,-1
    5428:	a081                	j	5468 <malloc+0x96>
    542a:	f04a                	sd	s2,32(sp)
    542c:	e852                	sd	s4,16(sp)
    542e:	e456                	sd	s5,8(sp)
    5430:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
    5432:	0000a797          	auipc	a5,0xa
    5436:	88678793          	add	a5,a5,-1914 # ecb8 <base>
    543a:	00003717          	auipc	a4,0x3
    543e:	04f73b23          	sd	a5,86(a4) # 8490 <freep>
    5442:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
    5444:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
    5448:	b7c1                	j	5408 <malloc+0x36>
        prevp->s.ptr = p->s.ptr;
    544a:	6398                	ld	a4,0(a5)
    544c:	e118                	sd	a4,0(a0)
    544e:	a8a9                	j	54a8 <malloc+0xd6>
  hp->s.size = nu;
    5450:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
    5454:	0541                	add	a0,a0,16
    5456:	efbff0ef          	jal	5350 <free>
  return freep;
    545a:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
    545e:	c12d                	beqz	a0,54c0 <malloc+0xee>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    5460:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    5462:	4798                	lw	a4,8(a5)
    5464:	02977263          	bgeu	a4,s1,5488 <malloc+0xb6>
    if(p == freep)
    5468:	00093703          	ld	a4,0(s2)
    546c:	853e                	mv	a0,a5
    546e:	fef719e3          	bne	a4,a5,5460 <malloc+0x8e>
  p = sbrk(nu * sizeof(Header));
    5472:	8552                	mv	a0,s4
    5474:	967ff0ef          	jal	4dda <sbrk>
  if(p == SBRK_ERROR)
    5478:	fd551ce3          	bne	a0,s5,5450 <malloc+0x7e>
        return 0;
    547c:	4501                	li	a0,0
    547e:	7902                	ld	s2,32(sp)
    5480:	6a42                	ld	s4,16(sp)
    5482:	6aa2                	ld	s5,8(sp)
    5484:	6b02                	ld	s6,0(sp)
    5486:	a03d                	j	54b4 <malloc+0xe2>
    5488:	7902                	ld	s2,32(sp)
    548a:	6a42                	ld	s4,16(sp)
    548c:	6aa2                	ld	s5,8(sp)
    548e:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
    5490:	fae48de3          	beq	s1,a4,544a <malloc+0x78>
        p->s.size -= nunits;
    5494:	4137073b          	subw	a4,a4,s3
    5498:	c798                	sw	a4,8(a5)
        p += p->s.size;
    549a:	02071693          	sll	a3,a4,0x20
    549e:	01c6d713          	srl	a4,a3,0x1c
    54a2:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
    54a4:	0137a423          	sw	s3,8(a5)
      freep = prevp;
    54a8:	00003717          	auipc	a4,0x3
    54ac:	fea73423          	sd	a0,-24(a4) # 8490 <freep>
      return (void*)(p + 1);
    54b0:	01078513          	add	a0,a5,16
  }
}
    54b4:	70e2                	ld	ra,56(sp)
    54b6:	7442                	ld	s0,48(sp)
    54b8:	74a2                	ld	s1,40(sp)
    54ba:	69e2                	ld	s3,24(sp)
    54bc:	6121                	add	sp,sp,64
    54be:	8082                	ret
    54c0:	7902                	ld	s2,32(sp)
    54c2:	6a42                	ld	s4,16(sp)
    54c4:	6aa2                	ld	s5,8(sp)
    54c6:	6b02                	ld	s6,0(sp)
    54c8:	b7f5                	j	54b4 <malloc+0xe2>
