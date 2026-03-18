
user/_grind:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <do_rand>:
#include "kernel/riscv.h"

// from FreeBSD.
int
do_rand(unsigned long *ctx)
{
       0:	1141                	add	sp,sp,-16
       2:	e422                	sd	s0,8(sp)
       4:	0800                	add	s0,sp,16
 * October 1988, p. 1195.
 */
    long hi, lo, x;

    /* Transform to [1, 0x7ffffffe] range. */
    x = (*ctx % 0x7ffffffe) + 1;
       6:	611c                	ld	a5,0(a0)
       8:	80000737          	lui	a4,0x80000
       c:	ffe74713          	xor	a4,a4,-2
      10:	02e7f7b3          	remu	a5,a5,a4
      14:	0785                	add	a5,a5,1
    hi = x / 127773;
    lo = x % 127773;
      16:	66fd                	lui	a3,0x1f
      18:	31d68693          	add	a3,a3,797 # 1f31d <base+0x1cf15>
      1c:	02d7e733          	rem	a4,a5,a3
    x = 16807 * lo - 2836 * hi;
      20:	6611                	lui	a2,0x4
      22:	1a760613          	add	a2,a2,423 # 41a7 <base+0x1d9f>
      26:	02c70733          	mul	a4,a4,a2
    hi = x / 127773;
      2a:	02d7c7b3          	div	a5,a5,a3
    x = 16807 * lo - 2836 * hi;
      2e:	76fd                	lui	a3,0xfffff
      30:	4ec68693          	add	a3,a3,1260 # fffffffffffff4ec <base+0xffffffffffffd0e4>
      34:	02d787b3          	mul	a5,a5,a3
      38:	97ba                	add	a5,a5,a4
    if (x < 0)
      3a:	0007c963          	bltz	a5,4c <do_rand+0x4c>
        x += 0x7fffffff;
    /* Transform to [0, 0x7ffffffd] range. */
    x--;
      3e:	17fd                	add	a5,a5,-1
    *ctx = x;
      40:	e11c                	sd	a5,0(a0)
    return (x);
}
      42:	0007851b          	sext.w	a0,a5
      46:	6422                	ld	s0,8(sp)
      48:	0141                	add	sp,sp,16
      4a:	8082                	ret
        x += 0x7fffffff;
      4c:	80000737          	lui	a4,0x80000
      50:	fff74713          	not	a4,a4
      54:	97ba                	add	a5,a5,a4
      56:	b7e5                	j	3e <do_rand+0x3e>

0000000000000058 <rand>:

unsigned long rand_next = 1;

int
rand(void)
{
      58:	1141                	add	sp,sp,-16
      5a:	e406                	sd	ra,8(sp)
      5c:	e022                	sd	s0,0(sp)
      5e:	0800                	add	s0,sp,16
    return (do_rand(&rand_next));
      60:	00002517          	auipc	a0,0x2
      64:	fa050513          	add	a0,a0,-96 # 2000 <rand_next>
      68:	f99ff0ef          	jal	0 <do_rand>
}
      6c:	60a2                	ld	ra,8(sp)
      6e:	6402                	ld	s0,0(sp)
      70:	0141                	add	sp,sp,16
      72:	8082                	ret

0000000000000074 <go>:

void
go(int which_child)
{
      74:	7159                	add	sp,sp,-112
      76:	f486                	sd	ra,104(sp)
      78:	f0a2                	sd	s0,96(sp)
      7a:	eca6                	sd	s1,88(sp)
      7c:	fc56                	sd	s5,56(sp)
      7e:	1880                	add	s0,sp,112
      80:	84aa                	mv	s1,a0
  int fd = -1;
  static char buf[999];
  char *break0 = sbrk(0);
      82:	4501                	li	a0,0
      84:	355000ef          	jal	bd8 <sbrk>
      88:	8aaa                	mv	s5,a0
  uint64 iters = 0;

  mkdir("grindir");
      8a:	00001517          	auipc	a0,0x1
      8e:	24650513          	add	a0,a0,582 # 12d0 <malloc+0x100>
      92:	483000ef          	jal	d14 <mkdir>
  if(chdir("grindir") != 0){
      96:	00001517          	auipc	a0,0x1
      9a:	23a50513          	add	a0,a0,570 # 12d0 <malloc+0x100>
      9e:	47f000ef          	jal	d1c <chdir>
      a2:	cd11                	beqz	a0,be <go+0x4a>
      a4:	e8ca                	sd	s2,80(sp)
      a6:	e4ce                	sd	s3,72(sp)
      a8:	e0d2                	sd	s4,64(sp)
      aa:	f85a                	sd	s6,48(sp)
    printf("grind: chdir grindir failed\n");
      ac:	00001517          	auipc	a0,0x1
      b0:	22c50513          	add	a0,a0,556 # 12d8 <malloc+0x108>
      b4:	068010ef          	jal	111c <printf>
    exit(1);
      b8:	4505                	li	a0,1
      ba:	3f3000ef          	jal	cac <exit>
      be:	e8ca                	sd	s2,80(sp)
      c0:	e4ce                	sd	s3,72(sp)
      c2:	e0d2                	sd	s4,64(sp)
      c4:	f85a                	sd	s6,48(sp)
  }
  chdir("/");
      c6:	00001517          	auipc	a0,0x1
      ca:	23a50513          	add	a0,a0,570 # 1300 <malloc+0x130>
      ce:	44f000ef          	jal	d1c <chdir>
      d2:	00001997          	auipc	s3,0x1
      d6:	23e98993          	add	s3,s3,574 # 1310 <malloc+0x140>
      da:	c489                	beqz	s1,e4 <go+0x70>
      dc:	00001997          	auipc	s3,0x1
      e0:	22c98993          	add	s3,s3,556 # 1308 <malloc+0x138>
  uint64 iters = 0;
      e4:	4481                	li	s1,0
  int fd = -1;
      e6:	5a7d                	li	s4,-1
      e8:	00001917          	auipc	s2,0x1
      ec:	4f890913          	add	s2,s2,1272 # 15e0 <malloc+0x410>
      f0:	a819                	j	106 <go+0x92>
    iters++;
    if((iters % 500) == 0)
      write(1, which_child?"B":"A", 1);
    int what = rand() % 23;
    if(what == 1){
      close(open("grindir/../a", O_CREATE|O_RDWR));
      f2:	20200593          	li	a1,514
      f6:	00001517          	auipc	a0,0x1
      fa:	22250513          	add	a0,a0,546 # 1318 <malloc+0x148>
      fe:	3ef000ef          	jal	cec <open>
     102:	3d3000ef          	jal	cd4 <close>
    iters++;
     106:	0485                	add	s1,s1,1
    if((iters % 500) == 0)
     108:	1f400793          	li	a5,500
     10c:	02f4f7b3          	remu	a5,s1,a5
     110:	e791                	bnez	a5,11c <go+0xa8>
      write(1, which_child?"B":"A", 1);
     112:	4605                	li	a2,1
     114:	85ce                	mv	a1,s3
     116:	4505                	li	a0,1
     118:	3b5000ef          	jal	ccc <write>
    int what = rand() % 23;
     11c:	f3dff0ef          	jal	58 <rand>
     120:	47dd                	li	a5,23
     122:	02f5653b          	remw	a0,a0,a5
     126:	0005071b          	sext.w	a4,a0
     12a:	47d9                	li	a5,22
     12c:	fce7ede3          	bltu	a5,a4,106 <go+0x92>
     130:	02051793          	sll	a5,a0,0x20
     134:	01e7d513          	srl	a0,a5,0x1e
     138:	954a                	add	a0,a0,s2
     13a:	411c                	lw	a5,0(a0)
     13c:	97ca                	add	a5,a5,s2
     13e:	8782                	jr	a5
    } else if(what == 2){
      close(open("grindir/../grindir/../b", O_CREATE|O_RDWR));
     140:	20200593          	li	a1,514
     144:	00001517          	auipc	a0,0x1
     148:	1e450513          	add	a0,a0,484 # 1328 <malloc+0x158>
     14c:	3a1000ef          	jal	cec <open>
     150:	385000ef          	jal	cd4 <close>
     154:	bf4d                	j	106 <go+0x92>
    } else if(what == 3){
      unlink("grindir/../a");
     156:	00001517          	auipc	a0,0x1
     15a:	1c250513          	add	a0,a0,450 # 1318 <malloc+0x148>
     15e:	39f000ef          	jal	cfc <unlink>
     162:	b755                	j	106 <go+0x92>
    } else if(what == 4){
      if(chdir("grindir") != 0){
     164:	00001517          	auipc	a0,0x1
     168:	16c50513          	add	a0,a0,364 # 12d0 <malloc+0x100>
     16c:	3b1000ef          	jal	d1c <chdir>
     170:	ed11                	bnez	a0,18c <go+0x118>
        printf("grind: chdir grindir failed\n");
        exit(1);
      }
      unlink("../b");
     172:	00001517          	auipc	a0,0x1
     176:	1ce50513          	add	a0,a0,462 # 1340 <malloc+0x170>
     17a:	383000ef          	jal	cfc <unlink>
      chdir("/");
     17e:	00001517          	auipc	a0,0x1
     182:	18250513          	add	a0,a0,386 # 1300 <malloc+0x130>
     186:	397000ef          	jal	d1c <chdir>
     18a:	bfb5                	j	106 <go+0x92>
        printf("grind: chdir grindir failed\n");
     18c:	00001517          	auipc	a0,0x1
     190:	14c50513          	add	a0,a0,332 # 12d8 <malloc+0x108>
     194:	789000ef          	jal	111c <printf>
        exit(1);
     198:	4505                	li	a0,1
     19a:	313000ef          	jal	cac <exit>
    } else if(what == 5){
      close(fd);
     19e:	8552                	mv	a0,s4
     1a0:	335000ef          	jal	cd4 <close>
      fd = open("/grindir/../a", O_CREATE|O_RDWR);
     1a4:	20200593          	li	a1,514
     1a8:	00001517          	auipc	a0,0x1
     1ac:	1a050513          	add	a0,a0,416 # 1348 <malloc+0x178>
     1b0:	33d000ef          	jal	cec <open>
     1b4:	8a2a                	mv	s4,a0
     1b6:	bf81                	j	106 <go+0x92>
    } else if(what == 6){
      close(fd);
     1b8:	8552                	mv	a0,s4
     1ba:	31b000ef          	jal	cd4 <close>
      fd = open("/./grindir/./../b", O_CREATE|O_RDWR);
     1be:	20200593          	li	a1,514
     1c2:	00001517          	auipc	a0,0x1
     1c6:	19650513          	add	a0,a0,406 # 1358 <malloc+0x188>
     1ca:	323000ef          	jal	cec <open>
     1ce:	8a2a                	mv	s4,a0
     1d0:	bf1d                	j	106 <go+0x92>
    } else if(what == 7){
      write(fd, buf, sizeof(buf));
     1d2:	3e700613          	li	a2,999
     1d6:	00002597          	auipc	a1,0x2
     1da:	e4a58593          	add	a1,a1,-438 # 2020 <buf.0>
     1de:	8552                	mv	a0,s4
     1e0:	2ed000ef          	jal	ccc <write>
     1e4:	b70d                	j	106 <go+0x92>
    } else if(what == 8){
      read(fd, buf, sizeof(buf));
     1e6:	3e700613          	li	a2,999
     1ea:	00002597          	auipc	a1,0x2
     1ee:	e3658593          	add	a1,a1,-458 # 2020 <buf.0>
     1f2:	8552                	mv	a0,s4
     1f4:	2d1000ef          	jal	cc4 <read>
     1f8:	b739                	j	106 <go+0x92>
    } else if(what == 9){
      mkdir("grindir/../a");
     1fa:	00001517          	auipc	a0,0x1
     1fe:	11e50513          	add	a0,a0,286 # 1318 <malloc+0x148>
     202:	313000ef          	jal	d14 <mkdir>
      close(open("a/../a/./a", O_CREATE|O_RDWR));
     206:	20200593          	li	a1,514
     20a:	00001517          	auipc	a0,0x1
     20e:	16650513          	add	a0,a0,358 # 1370 <malloc+0x1a0>
     212:	2db000ef          	jal	cec <open>
     216:	2bf000ef          	jal	cd4 <close>
      unlink("a/a");
     21a:	00001517          	auipc	a0,0x1
     21e:	16650513          	add	a0,a0,358 # 1380 <malloc+0x1b0>
     222:	2db000ef          	jal	cfc <unlink>
     226:	b5c5                	j	106 <go+0x92>
    } else if(what == 10){
      mkdir("/../b");
     228:	00001517          	auipc	a0,0x1
     22c:	16050513          	add	a0,a0,352 # 1388 <malloc+0x1b8>
     230:	2e5000ef          	jal	d14 <mkdir>
      close(open("grindir/../b/b", O_CREATE|O_RDWR));
     234:	20200593          	li	a1,514
     238:	00001517          	auipc	a0,0x1
     23c:	15850513          	add	a0,a0,344 # 1390 <malloc+0x1c0>
     240:	2ad000ef          	jal	cec <open>
     244:	291000ef          	jal	cd4 <close>
      unlink("b/b");
     248:	00001517          	auipc	a0,0x1
     24c:	15850513          	add	a0,a0,344 # 13a0 <malloc+0x1d0>
     250:	2ad000ef          	jal	cfc <unlink>
     254:	bd4d                	j	106 <go+0x92>
    } else if(what == 11){
      unlink("b");
     256:	00001517          	auipc	a0,0x1
     25a:	15250513          	add	a0,a0,338 # 13a8 <malloc+0x1d8>
     25e:	29f000ef          	jal	cfc <unlink>
      link("../grindir/./../a", "../b");
     262:	00001597          	auipc	a1,0x1
     266:	0de58593          	add	a1,a1,222 # 1340 <malloc+0x170>
     26a:	00001517          	auipc	a0,0x1
     26e:	14650513          	add	a0,a0,326 # 13b0 <malloc+0x1e0>
     272:	29b000ef          	jal	d0c <link>
     276:	bd41                	j	106 <go+0x92>
    } else if(what == 12){
      unlink("../grindir/../a");
     278:	00001517          	auipc	a0,0x1
     27c:	15050513          	add	a0,a0,336 # 13c8 <malloc+0x1f8>
     280:	27d000ef          	jal	cfc <unlink>
      link(".././b", "/grindir/../a");
     284:	00001597          	auipc	a1,0x1
     288:	0c458593          	add	a1,a1,196 # 1348 <malloc+0x178>
     28c:	00001517          	auipc	a0,0x1
     290:	14c50513          	add	a0,a0,332 # 13d8 <malloc+0x208>
     294:	279000ef          	jal	d0c <link>
     298:	b5bd                	j	106 <go+0x92>
    } else if(what == 13){
      int pid = fork();
     29a:	20b000ef          	jal	ca4 <fork>
      if(pid == 0){
     29e:	c519                	beqz	a0,2ac <go+0x238>
        exit(0);
      } else if(pid < 0){
     2a0:	00054863          	bltz	a0,2b0 <go+0x23c>
        printf("grind: fork failed\n");
        exit(1);
      }
      wait(0);
     2a4:	4501                	li	a0,0
     2a6:	20f000ef          	jal	cb4 <wait>
     2aa:	bdb1                	j	106 <go+0x92>
        exit(0);
     2ac:	201000ef          	jal	cac <exit>
        printf("grind: fork failed\n");
     2b0:	00001517          	auipc	a0,0x1
     2b4:	13050513          	add	a0,a0,304 # 13e0 <malloc+0x210>
     2b8:	665000ef          	jal	111c <printf>
        exit(1);
     2bc:	4505                	li	a0,1
     2be:	1ef000ef          	jal	cac <exit>
    } else if(what == 14){
      int pid = fork();
     2c2:	1e3000ef          	jal	ca4 <fork>
      if(pid == 0){
     2c6:	c519                	beqz	a0,2d4 <go+0x260>
        fork();
        fork();
        exit(0);
      } else if(pid < 0){
     2c8:	00054d63          	bltz	a0,2e2 <go+0x26e>
        printf("grind: fork failed\n");
        exit(1);
      }
      wait(0);
     2cc:	4501                	li	a0,0
     2ce:	1e7000ef          	jal	cb4 <wait>
     2d2:	bd15                	j	106 <go+0x92>
        fork();
     2d4:	1d1000ef          	jal	ca4 <fork>
        fork();
     2d8:	1cd000ef          	jal	ca4 <fork>
        exit(0);
     2dc:	4501                	li	a0,0
     2de:	1cf000ef          	jal	cac <exit>
        printf("grind: fork failed\n");
     2e2:	00001517          	auipc	a0,0x1
     2e6:	0fe50513          	add	a0,a0,254 # 13e0 <malloc+0x210>
     2ea:	633000ef          	jal	111c <printf>
        exit(1);
     2ee:	4505                	li	a0,1
     2f0:	1bd000ef          	jal	cac <exit>
    } else if(what == 15){
      sbrk(6011);
     2f4:	6505                	lui	a0,0x1
     2f6:	77b50513          	add	a0,a0,1915 # 177b <digits+0x13b>
     2fa:	0df000ef          	jal	bd8 <sbrk>
     2fe:	b521                	j	106 <go+0x92>
    } else if(what == 16){
      if(sbrk(0) > break0)
     300:	4501                	li	a0,0
     302:	0d7000ef          	jal	bd8 <sbrk>
     306:	e0aaf0e3          	bgeu	s5,a0,106 <go+0x92>
        sbrk(-(sbrk(0) - break0));
     30a:	4501                	li	a0,0
     30c:	0cd000ef          	jal	bd8 <sbrk>
     310:	40aa853b          	subw	a0,s5,a0
     314:	0c5000ef          	jal	bd8 <sbrk>
     318:	b3fd                	j	106 <go+0x92>
    } else if(what == 17){
      int pid = fork();
     31a:	18b000ef          	jal	ca4 <fork>
     31e:	8b2a                	mv	s6,a0
      if(pid == 0){
     320:	c10d                	beqz	a0,342 <go+0x2ce>
        close(open("a", O_CREATE|O_RDWR));
        exit(0);
      } else if(pid < 0){
     322:	02054d63          	bltz	a0,35c <go+0x2e8>
        printf("grind: fork failed\n");
        exit(1);
      }
      if(chdir("../grindir/..") != 0){
     326:	00001517          	auipc	a0,0x1
     32a:	0da50513          	add	a0,a0,218 # 1400 <malloc+0x230>
     32e:	1ef000ef          	jal	d1c <chdir>
     332:	ed15                	bnez	a0,36e <go+0x2fa>
        printf("grind: chdir failed\n");
        exit(1);
      }
      kill(pid);
     334:	855a                	mv	a0,s6
     336:	1a7000ef          	jal	cdc <kill>
      wait(0);
     33a:	4501                	li	a0,0
     33c:	179000ef          	jal	cb4 <wait>
     340:	b3d9                	j	106 <go+0x92>
        close(open("a", O_CREATE|O_RDWR));
     342:	20200593          	li	a1,514
     346:	00001517          	auipc	a0,0x1
     34a:	0b250513          	add	a0,a0,178 # 13f8 <malloc+0x228>
     34e:	19f000ef          	jal	cec <open>
     352:	183000ef          	jal	cd4 <close>
        exit(0);
     356:	4501                	li	a0,0
     358:	155000ef          	jal	cac <exit>
        printf("grind: fork failed\n");
     35c:	00001517          	auipc	a0,0x1
     360:	08450513          	add	a0,a0,132 # 13e0 <malloc+0x210>
     364:	5b9000ef          	jal	111c <printf>
        exit(1);
     368:	4505                	li	a0,1
     36a:	143000ef          	jal	cac <exit>
        printf("grind: chdir failed\n");
     36e:	00001517          	auipc	a0,0x1
     372:	0a250513          	add	a0,a0,162 # 1410 <malloc+0x240>
     376:	5a7000ef          	jal	111c <printf>
        exit(1);
     37a:	4505                	li	a0,1
     37c:	131000ef          	jal	cac <exit>
    } else if(what == 18){
      int pid = fork();
     380:	125000ef          	jal	ca4 <fork>
      if(pid == 0){
     384:	c519                	beqz	a0,392 <go+0x31e>
        kill(getpid());
        exit(0);
      } else if(pid < 0){
     386:	00054d63          	bltz	a0,3a0 <go+0x32c>
        printf("grind: fork failed\n");
        exit(1);
      }
      wait(0);
     38a:	4501                	li	a0,0
     38c:	129000ef          	jal	cb4 <wait>
     390:	bb9d                	j	106 <go+0x92>
        kill(getpid());
     392:	19b000ef          	jal	d2c <getpid>
     396:	147000ef          	jal	cdc <kill>
        exit(0);
     39a:	4501                	li	a0,0
     39c:	111000ef          	jal	cac <exit>
        printf("grind: fork failed\n");
     3a0:	00001517          	auipc	a0,0x1
     3a4:	04050513          	add	a0,a0,64 # 13e0 <malloc+0x210>
     3a8:	575000ef          	jal	111c <printf>
        exit(1);
     3ac:	4505                	li	a0,1
     3ae:	0ff000ef          	jal	cac <exit>
    } else if(what == 19){
      int fds[2];
      if(pipe(fds) < 0){
     3b2:	fa840513          	add	a0,s0,-88
     3b6:	107000ef          	jal	cbc <pipe>
     3ba:	02054363          	bltz	a0,3e0 <go+0x36c>
        printf("grind: pipe failed\n");
        exit(1);
      }
      int pid = fork();
     3be:	0e7000ef          	jal	ca4 <fork>
      if(pid == 0){
     3c2:	c905                	beqz	a0,3f2 <go+0x37e>
          printf("grind: pipe write failed\n");
        char c;
        if(read(fds[0], &c, 1) != 1)
          printf("grind: pipe read failed\n");
        exit(0);
      } else if(pid < 0){
     3c4:	08054263          	bltz	a0,448 <go+0x3d4>
        printf("grind: fork failed\n");
        exit(1);
      }
      close(fds[0]);
     3c8:	fa842503          	lw	a0,-88(s0)
     3cc:	109000ef          	jal	cd4 <close>
      close(fds[1]);
     3d0:	fac42503          	lw	a0,-84(s0)
     3d4:	101000ef          	jal	cd4 <close>
      wait(0);
     3d8:	4501                	li	a0,0
     3da:	0db000ef          	jal	cb4 <wait>
     3de:	b325                	j	106 <go+0x92>
        printf("grind: pipe failed\n");
     3e0:	00001517          	auipc	a0,0x1
     3e4:	04850513          	add	a0,a0,72 # 1428 <malloc+0x258>
     3e8:	535000ef          	jal	111c <printf>
        exit(1);
     3ec:	4505                	li	a0,1
     3ee:	0bf000ef          	jal	cac <exit>
        fork();
     3f2:	0b3000ef          	jal	ca4 <fork>
        fork();
     3f6:	0af000ef          	jal	ca4 <fork>
        if(write(fds[1], "x", 1) != 1)
     3fa:	4605                	li	a2,1
     3fc:	00001597          	auipc	a1,0x1
     400:	04458593          	add	a1,a1,68 # 1440 <malloc+0x270>
     404:	fac42503          	lw	a0,-84(s0)
     408:	0c5000ef          	jal	ccc <write>
     40c:	4785                	li	a5,1
     40e:	00f51f63          	bne	a0,a5,42c <go+0x3b8>
        if(read(fds[0], &c, 1) != 1)
     412:	4605                	li	a2,1
     414:	fa040593          	add	a1,s0,-96
     418:	fa842503          	lw	a0,-88(s0)
     41c:	0a9000ef          	jal	cc4 <read>
     420:	4785                	li	a5,1
     422:	00f51c63          	bne	a0,a5,43a <go+0x3c6>
        exit(0);
     426:	4501                	li	a0,0
     428:	085000ef          	jal	cac <exit>
          printf("grind: pipe write failed\n");
     42c:	00001517          	auipc	a0,0x1
     430:	01c50513          	add	a0,a0,28 # 1448 <malloc+0x278>
     434:	4e9000ef          	jal	111c <printf>
     438:	bfe9                	j	412 <go+0x39e>
          printf("grind: pipe read failed\n");
     43a:	00001517          	auipc	a0,0x1
     43e:	02e50513          	add	a0,a0,46 # 1468 <malloc+0x298>
     442:	4db000ef          	jal	111c <printf>
     446:	b7c5                	j	426 <go+0x3b2>
        printf("grind: fork failed\n");
     448:	00001517          	auipc	a0,0x1
     44c:	f9850513          	add	a0,a0,-104 # 13e0 <malloc+0x210>
     450:	4cd000ef          	jal	111c <printf>
        exit(1);
     454:	4505                	li	a0,1
     456:	057000ef          	jal	cac <exit>
    } else if(what == 20){
      int pid = fork();
     45a:	04b000ef          	jal	ca4 <fork>
      if(pid == 0){
     45e:	c519                	beqz	a0,46c <go+0x3f8>
        chdir("a");
        unlink("../a");
        fd = open("x", O_CREATE|O_RDWR);
        unlink("x");
        exit(0);
      } else if(pid < 0){
     460:	04054f63          	bltz	a0,4be <go+0x44a>
        printf("grind: fork failed\n");
        exit(1);
      }
      wait(0);
     464:	4501                	li	a0,0
     466:	04f000ef          	jal	cb4 <wait>
     46a:	b971                	j	106 <go+0x92>
        unlink("a");
     46c:	00001517          	auipc	a0,0x1
     470:	f8c50513          	add	a0,a0,-116 # 13f8 <malloc+0x228>
     474:	089000ef          	jal	cfc <unlink>
        mkdir("a");
     478:	00001517          	auipc	a0,0x1
     47c:	f8050513          	add	a0,a0,-128 # 13f8 <malloc+0x228>
     480:	095000ef          	jal	d14 <mkdir>
        chdir("a");
     484:	00001517          	auipc	a0,0x1
     488:	f7450513          	add	a0,a0,-140 # 13f8 <malloc+0x228>
     48c:	091000ef          	jal	d1c <chdir>
        unlink("../a");
     490:	00001517          	auipc	a0,0x1
     494:	ff850513          	add	a0,a0,-8 # 1488 <malloc+0x2b8>
     498:	065000ef          	jal	cfc <unlink>
        fd = open("x", O_CREATE|O_RDWR);
     49c:	20200593          	li	a1,514
     4a0:	00001517          	auipc	a0,0x1
     4a4:	fa050513          	add	a0,a0,-96 # 1440 <malloc+0x270>
     4a8:	045000ef          	jal	cec <open>
        unlink("x");
     4ac:	00001517          	auipc	a0,0x1
     4b0:	f9450513          	add	a0,a0,-108 # 1440 <malloc+0x270>
     4b4:	049000ef          	jal	cfc <unlink>
        exit(0);
     4b8:	4501                	li	a0,0
     4ba:	7f2000ef          	jal	cac <exit>
        printf("grind: fork failed\n");
     4be:	00001517          	auipc	a0,0x1
     4c2:	f2250513          	add	a0,a0,-222 # 13e0 <malloc+0x210>
     4c6:	457000ef          	jal	111c <printf>
        exit(1);
     4ca:	4505                	li	a0,1
     4cc:	7e0000ef          	jal	cac <exit>
    } else if(what == 21){
      unlink("c");
     4d0:	00001517          	auipc	a0,0x1
     4d4:	fc050513          	add	a0,a0,-64 # 1490 <malloc+0x2c0>
     4d8:	025000ef          	jal	cfc <unlink>
      // should always succeed. check that there are free i-nodes,
      // file descriptors, blocks.
      int fd1 = open("c", O_CREATE|O_RDWR);
     4dc:	20200593          	li	a1,514
     4e0:	00001517          	auipc	a0,0x1
     4e4:	fb050513          	add	a0,a0,-80 # 1490 <malloc+0x2c0>
     4e8:	005000ef          	jal	cec <open>
     4ec:	8b2a                	mv	s6,a0
      if(fd1 < 0){
     4ee:	04054763          	bltz	a0,53c <go+0x4c8>
        printf("grind: create c failed\n");
        exit(1);
      }
      if(write(fd1, "x", 1) != 1){
     4f2:	4605                	li	a2,1
     4f4:	00001597          	auipc	a1,0x1
     4f8:	f4c58593          	add	a1,a1,-180 # 1440 <malloc+0x270>
     4fc:	7d0000ef          	jal	ccc <write>
     500:	4785                	li	a5,1
     502:	04f51663          	bne	a0,a5,54e <go+0x4da>
        printf("grind: write c failed\n");
        exit(1);
      }
      struct stat st;
      if(fstat(fd1, &st) != 0){
     506:	fa840593          	add	a1,s0,-88
     50a:	855a                	mv	a0,s6
     50c:	7f8000ef          	jal	d04 <fstat>
     510:	e921                	bnez	a0,560 <go+0x4ec>
        printf("grind: fstat failed\n");
        exit(1);
      }
      if(st.size != 1){
     512:	fb843583          	ld	a1,-72(s0)
     516:	4785                	li	a5,1
     518:	04f59d63          	bne	a1,a5,572 <go+0x4fe>
        printf("grind: fstat reports wrong size %d\n", (int)st.size);
        exit(1);
      }
      if(st.ino > 200){
     51c:	fac42583          	lw	a1,-84(s0)
     520:	0c800793          	li	a5,200
     524:	06b7e163          	bltu	a5,a1,586 <go+0x512>
        printf("grind: fstat reports crazy i-number %d\n", st.ino);
        exit(1);
      }
      close(fd1);
     528:	855a                	mv	a0,s6
     52a:	7aa000ef          	jal	cd4 <close>
      unlink("c");
     52e:	00001517          	auipc	a0,0x1
     532:	f6250513          	add	a0,a0,-158 # 1490 <malloc+0x2c0>
     536:	7c6000ef          	jal	cfc <unlink>
     53a:	b6f1                	j	106 <go+0x92>
        printf("grind: create c failed\n");
     53c:	00001517          	auipc	a0,0x1
     540:	f5c50513          	add	a0,a0,-164 # 1498 <malloc+0x2c8>
     544:	3d9000ef          	jal	111c <printf>
        exit(1);
     548:	4505                	li	a0,1
     54a:	762000ef          	jal	cac <exit>
        printf("grind: write c failed\n");
     54e:	00001517          	auipc	a0,0x1
     552:	f6250513          	add	a0,a0,-158 # 14b0 <malloc+0x2e0>
     556:	3c7000ef          	jal	111c <printf>
        exit(1);
     55a:	4505                	li	a0,1
     55c:	750000ef          	jal	cac <exit>
        printf("grind: fstat failed\n");
     560:	00001517          	auipc	a0,0x1
     564:	f6850513          	add	a0,a0,-152 # 14c8 <malloc+0x2f8>
     568:	3b5000ef          	jal	111c <printf>
        exit(1);
     56c:	4505                	li	a0,1
     56e:	73e000ef          	jal	cac <exit>
        printf("grind: fstat reports wrong size %d\n", (int)st.size);
     572:	2581                	sext.w	a1,a1
     574:	00001517          	auipc	a0,0x1
     578:	f6c50513          	add	a0,a0,-148 # 14e0 <malloc+0x310>
     57c:	3a1000ef          	jal	111c <printf>
        exit(1);
     580:	4505                	li	a0,1
     582:	72a000ef          	jal	cac <exit>
        printf("grind: fstat reports crazy i-number %d\n", st.ino);
     586:	00001517          	auipc	a0,0x1
     58a:	f8250513          	add	a0,a0,-126 # 1508 <malloc+0x338>
     58e:	38f000ef          	jal	111c <printf>
        exit(1);
     592:	4505                	li	a0,1
     594:	718000ef          	jal	cac <exit>
    } else if(what == 22){
      // echo hi | cat
      int aa[2], bb[2];
      if(pipe(aa) < 0){
     598:	f9840513          	add	a0,s0,-104
     59c:	720000ef          	jal	cbc <pipe>
     5a0:	0c054263          	bltz	a0,664 <go+0x5f0>
        fprintf(2, "grind: pipe failed\n");
        exit(1);
      }
      if(pipe(bb) < 0){
     5a4:	fa040513          	add	a0,s0,-96
     5a8:	714000ef          	jal	cbc <pipe>
     5ac:	0c054663          	bltz	a0,678 <go+0x604>
        fprintf(2, "grind: pipe failed\n");
        exit(1);
      }
      int pid1 = fork();
     5b0:	6f4000ef          	jal	ca4 <fork>
      if(pid1 == 0){
     5b4:	0c050c63          	beqz	a0,68c <go+0x618>
        close(aa[1]);
        char *args[3] = { "echo", "hi", 0 };
        exec("grindir/../echo", args);
        fprintf(2, "grind: echo: not found\n");
        exit(2);
      } else if(pid1 < 0){
     5b8:	14054e63          	bltz	a0,714 <go+0x6a0>
        fprintf(2, "grind: fork failed\n");
        exit(3);
      }
      int pid2 = fork();
     5bc:	6e8000ef          	jal	ca4 <fork>
      if(pid2 == 0){
     5c0:	16050463          	beqz	a0,728 <go+0x6b4>
        close(bb[1]);
        char *args[2] = { "cat", 0 };
        exec("/cat", args);
        fprintf(2, "grind: cat: not found\n");
        exit(6);
      } else if(pid2 < 0){
     5c4:	20054263          	bltz	a0,7c8 <go+0x754>
        fprintf(2, "grind: fork failed\n");
        exit(7);
      }
      close(aa[0]);
     5c8:	f9842503          	lw	a0,-104(s0)
     5cc:	708000ef          	jal	cd4 <close>
      close(aa[1]);
     5d0:	f9c42503          	lw	a0,-100(s0)
     5d4:	700000ef          	jal	cd4 <close>
      close(bb[1]);
     5d8:	fa442503          	lw	a0,-92(s0)
     5dc:	6f8000ef          	jal	cd4 <close>
      char buf[4] = { 0, 0, 0, 0 };
     5e0:	f8042823          	sw	zero,-112(s0)
      read(bb[0], buf+0, 1);
     5e4:	4605                	li	a2,1
     5e6:	f9040593          	add	a1,s0,-112
     5ea:	fa042503          	lw	a0,-96(s0)
     5ee:	6d6000ef          	jal	cc4 <read>
      read(bb[0], buf+1, 1);
     5f2:	4605                	li	a2,1
     5f4:	f9140593          	add	a1,s0,-111
     5f8:	fa042503          	lw	a0,-96(s0)
     5fc:	6c8000ef          	jal	cc4 <read>
      read(bb[0], buf+2, 1);
     600:	4605                	li	a2,1
     602:	f9240593          	add	a1,s0,-110
     606:	fa042503          	lw	a0,-96(s0)
     60a:	6ba000ef          	jal	cc4 <read>
      close(bb[0]);
     60e:	fa042503          	lw	a0,-96(s0)
     612:	6c2000ef          	jal	cd4 <close>
      int st1, st2;
      wait(&st1);
     616:	f9440513          	add	a0,s0,-108
     61a:	69a000ef          	jal	cb4 <wait>
      wait(&st2);
     61e:	fa840513          	add	a0,s0,-88
     622:	692000ef          	jal	cb4 <wait>
      if(st1 != 0 || st2 != 0 || strcmp(buf, "hi\n") != 0){
     626:	f9442783          	lw	a5,-108(s0)
     62a:	fa842703          	lw	a4,-88(s0)
     62e:	8fd9                	or	a5,a5,a4
     630:	eb99                	bnez	a5,646 <go+0x5d2>
     632:	00001597          	auipc	a1,0x1
     636:	f7658593          	add	a1,a1,-138 # 15a8 <malloc+0x3d8>
     63a:	f9040513          	add	a0,s0,-112
     63e:	2cc000ef          	jal	90a <strcmp>
     642:	ac0502e3          	beqz	a0,106 <go+0x92>
        printf("grind: exec pipeline failed %d %d \"%s\"\n", st1, st2, buf);
     646:	f9040693          	add	a3,s0,-112
     64a:	fa842603          	lw	a2,-88(s0)
     64e:	f9442583          	lw	a1,-108(s0)
     652:	00001517          	auipc	a0,0x1
     656:	f5e50513          	add	a0,a0,-162 # 15b0 <malloc+0x3e0>
     65a:	2c3000ef          	jal	111c <printf>
        exit(1);
     65e:	4505                	li	a0,1
     660:	64c000ef          	jal	cac <exit>
        fprintf(2, "grind: pipe failed\n");
     664:	00001597          	auipc	a1,0x1
     668:	dc458593          	add	a1,a1,-572 # 1428 <malloc+0x258>
     66c:	4509                	li	a0,2
     66e:	285000ef          	jal	10f2 <fprintf>
        exit(1);
     672:	4505                	li	a0,1
     674:	638000ef          	jal	cac <exit>
        fprintf(2, "grind: pipe failed\n");
     678:	00001597          	auipc	a1,0x1
     67c:	db058593          	add	a1,a1,-592 # 1428 <malloc+0x258>
     680:	4509                	li	a0,2
     682:	271000ef          	jal	10f2 <fprintf>
        exit(1);
     686:	4505                	li	a0,1
     688:	624000ef          	jal	cac <exit>
        close(bb[0]);
     68c:	fa042503          	lw	a0,-96(s0)
     690:	644000ef          	jal	cd4 <close>
        close(bb[1]);
     694:	fa442503          	lw	a0,-92(s0)
     698:	63c000ef          	jal	cd4 <close>
        close(aa[0]);
     69c:	f9842503          	lw	a0,-104(s0)
     6a0:	634000ef          	jal	cd4 <close>
        close(1);
     6a4:	4505                	li	a0,1
     6a6:	62e000ef          	jal	cd4 <close>
        if(dup(aa[1]) != 1){
     6aa:	f9c42503          	lw	a0,-100(s0)
     6ae:	676000ef          	jal	d24 <dup>
     6b2:	4785                	li	a5,1
     6b4:	00f50c63          	beq	a0,a5,6cc <go+0x658>
          fprintf(2, "grind: dup failed\n");
     6b8:	00001597          	auipc	a1,0x1
     6bc:	e7858593          	add	a1,a1,-392 # 1530 <malloc+0x360>
     6c0:	4509                	li	a0,2
     6c2:	231000ef          	jal	10f2 <fprintf>
          exit(1);
     6c6:	4505                	li	a0,1
     6c8:	5e4000ef          	jal	cac <exit>
        close(aa[1]);
     6cc:	f9c42503          	lw	a0,-100(s0)
     6d0:	604000ef          	jal	cd4 <close>
        char *args[3] = { "echo", "hi", 0 };
     6d4:	00001797          	auipc	a5,0x1
     6d8:	e7478793          	add	a5,a5,-396 # 1548 <malloc+0x378>
     6dc:	faf43423          	sd	a5,-88(s0)
     6e0:	00001797          	auipc	a5,0x1
     6e4:	e7078793          	add	a5,a5,-400 # 1550 <malloc+0x380>
     6e8:	faf43823          	sd	a5,-80(s0)
     6ec:	fa043c23          	sd	zero,-72(s0)
        exec("grindir/../echo", args);
     6f0:	fa840593          	add	a1,s0,-88
     6f4:	00001517          	auipc	a0,0x1
     6f8:	e6450513          	add	a0,a0,-412 # 1558 <malloc+0x388>
     6fc:	5e8000ef          	jal	ce4 <exec>
        fprintf(2, "grind: echo: not found\n");
     700:	00001597          	auipc	a1,0x1
     704:	e6858593          	add	a1,a1,-408 # 1568 <malloc+0x398>
     708:	4509                	li	a0,2
     70a:	1e9000ef          	jal	10f2 <fprintf>
        exit(2);
     70e:	4509                	li	a0,2
     710:	59c000ef          	jal	cac <exit>
        fprintf(2, "grind: fork failed\n");
     714:	00001597          	auipc	a1,0x1
     718:	ccc58593          	add	a1,a1,-820 # 13e0 <malloc+0x210>
     71c:	4509                	li	a0,2
     71e:	1d5000ef          	jal	10f2 <fprintf>
        exit(3);
     722:	450d                	li	a0,3
     724:	588000ef          	jal	cac <exit>
        close(aa[1]);
     728:	f9c42503          	lw	a0,-100(s0)
     72c:	5a8000ef          	jal	cd4 <close>
        close(bb[0]);
     730:	fa042503          	lw	a0,-96(s0)
     734:	5a0000ef          	jal	cd4 <close>
        close(0);
     738:	4501                	li	a0,0
     73a:	59a000ef          	jal	cd4 <close>
        if(dup(aa[0]) != 0){
     73e:	f9842503          	lw	a0,-104(s0)
     742:	5e2000ef          	jal	d24 <dup>
     746:	c919                	beqz	a0,75c <go+0x6e8>
          fprintf(2, "grind: dup failed\n");
     748:	00001597          	auipc	a1,0x1
     74c:	de858593          	add	a1,a1,-536 # 1530 <malloc+0x360>
     750:	4509                	li	a0,2
     752:	1a1000ef          	jal	10f2 <fprintf>
          exit(4);
     756:	4511                	li	a0,4
     758:	554000ef          	jal	cac <exit>
        close(aa[0]);
     75c:	f9842503          	lw	a0,-104(s0)
     760:	574000ef          	jal	cd4 <close>
        close(1);
     764:	4505                	li	a0,1
     766:	56e000ef          	jal	cd4 <close>
        if(dup(bb[1]) != 1){
     76a:	fa442503          	lw	a0,-92(s0)
     76e:	5b6000ef          	jal	d24 <dup>
     772:	4785                	li	a5,1
     774:	00f50c63          	beq	a0,a5,78c <go+0x718>
          fprintf(2, "grind: dup failed\n");
     778:	00001597          	auipc	a1,0x1
     77c:	db858593          	add	a1,a1,-584 # 1530 <malloc+0x360>
     780:	4509                	li	a0,2
     782:	171000ef          	jal	10f2 <fprintf>
          exit(5);
     786:	4515                	li	a0,5
     788:	524000ef          	jal	cac <exit>
        close(bb[1]);
     78c:	fa442503          	lw	a0,-92(s0)
     790:	544000ef          	jal	cd4 <close>
        char *args[2] = { "cat", 0 };
     794:	00001797          	auipc	a5,0x1
     798:	dec78793          	add	a5,a5,-532 # 1580 <malloc+0x3b0>
     79c:	faf43423          	sd	a5,-88(s0)
     7a0:	fa043823          	sd	zero,-80(s0)
        exec("/cat", args);
     7a4:	fa840593          	add	a1,s0,-88
     7a8:	00001517          	auipc	a0,0x1
     7ac:	de050513          	add	a0,a0,-544 # 1588 <malloc+0x3b8>
     7b0:	534000ef          	jal	ce4 <exec>
        fprintf(2, "grind: cat: not found\n");
     7b4:	00001597          	auipc	a1,0x1
     7b8:	ddc58593          	add	a1,a1,-548 # 1590 <malloc+0x3c0>
     7bc:	4509                	li	a0,2
     7be:	135000ef          	jal	10f2 <fprintf>
        exit(6);
     7c2:	4519                	li	a0,6
     7c4:	4e8000ef          	jal	cac <exit>
        fprintf(2, "grind: fork failed\n");
     7c8:	00001597          	auipc	a1,0x1
     7cc:	c1858593          	add	a1,a1,-1000 # 13e0 <malloc+0x210>
     7d0:	4509                	li	a0,2
     7d2:	121000ef          	jal	10f2 <fprintf>
        exit(7);
     7d6:	451d                	li	a0,7
     7d8:	4d4000ef          	jal	cac <exit>

00000000000007dc <iter>:
  }
}

void
iter()
{
     7dc:	7179                	add	sp,sp,-48
     7de:	f406                	sd	ra,40(sp)
     7e0:	f022                	sd	s0,32(sp)
     7e2:	1800                	add	s0,sp,48
  unlink("a");
     7e4:	00001517          	auipc	a0,0x1
     7e8:	c1450513          	add	a0,a0,-1004 # 13f8 <malloc+0x228>
     7ec:	510000ef          	jal	cfc <unlink>
  unlink("b");
     7f0:	00001517          	auipc	a0,0x1
     7f4:	bb850513          	add	a0,a0,-1096 # 13a8 <malloc+0x1d8>
     7f8:	504000ef          	jal	cfc <unlink>
  
  int pid1 = fork();
     7fc:	4a8000ef          	jal	ca4 <fork>
  if(pid1 < 0){
     800:	02054163          	bltz	a0,822 <iter+0x46>
     804:	ec26                	sd	s1,24(sp)
     806:	84aa                	mv	s1,a0
    printf("grind: fork failed\n");
    exit(1);
  }
  if(pid1 == 0){
     808:	e905                	bnez	a0,838 <iter+0x5c>
     80a:	e84a                	sd	s2,16(sp)
    rand_next ^= 31;
     80c:	00001717          	auipc	a4,0x1
     810:	7f470713          	add	a4,a4,2036 # 2000 <rand_next>
     814:	631c                	ld	a5,0(a4)
     816:	01f7c793          	xor	a5,a5,31
     81a:	e31c                	sd	a5,0(a4)
    go(0);
     81c:	4501                	li	a0,0
     81e:	857ff0ef          	jal	74 <go>
     822:	ec26                	sd	s1,24(sp)
     824:	e84a                	sd	s2,16(sp)
    printf("grind: fork failed\n");
     826:	00001517          	auipc	a0,0x1
     82a:	bba50513          	add	a0,a0,-1094 # 13e0 <malloc+0x210>
     82e:	0ef000ef          	jal	111c <printf>
    exit(1);
     832:	4505                	li	a0,1
     834:	478000ef          	jal	cac <exit>
     838:	e84a                	sd	s2,16(sp)
    exit(0);
  }

  int pid2 = fork();
     83a:	46a000ef          	jal	ca4 <fork>
     83e:	892a                	mv	s2,a0
  if(pid2 < 0){
     840:	02054063          	bltz	a0,860 <iter+0x84>
    printf("grind: fork failed\n");
    exit(1);
  }
  if(pid2 == 0){
     844:	e51d                	bnez	a0,872 <iter+0x96>
    rand_next ^= 7177;
     846:	00001697          	auipc	a3,0x1
     84a:	7ba68693          	add	a3,a3,1978 # 2000 <rand_next>
     84e:	629c                	ld	a5,0(a3)
     850:	6709                	lui	a4,0x2
     852:	c0970713          	add	a4,a4,-1015 # 1c09 <digits+0x5c9>
     856:	8fb9                	xor	a5,a5,a4
     858:	e29c                	sd	a5,0(a3)
    go(1);
     85a:	4505                	li	a0,1
     85c:	819ff0ef          	jal	74 <go>
    printf("grind: fork failed\n");
     860:	00001517          	auipc	a0,0x1
     864:	b8050513          	add	a0,a0,-1152 # 13e0 <malloc+0x210>
     868:	0b5000ef          	jal	111c <printf>
    exit(1);
     86c:	4505                	li	a0,1
     86e:	43e000ef          	jal	cac <exit>
    exit(0);
  }

  int st1 = -1;
     872:	57fd                	li	a5,-1
     874:	fcf42e23          	sw	a5,-36(s0)
  wait(&st1);
     878:	fdc40513          	add	a0,s0,-36
     87c:	438000ef          	jal	cb4 <wait>
  if(st1 != 0){
     880:	fdc42783          	lw	a5,-36(s0)
     884:	eb99                	bnez	a5,89a <iter+0xbe>
    kill(pid1);
    kill(pid2);
  }
  int st2 = -1;
     886:	57fd                	li	a5,-1
     888:	fcf42c23          	sw	a5,-40(s0)
  wait(&st2);
     88c:	fd840513          	add	a0,s0,-40
     890:	424000ef          	jal	cb4 <wait>

  exit(0);
     894:	4501                	li	a0,0
     896:	416000ef          	jal	cac <exit>
    kill(pid1);
     89a:	8526                	mv	a0,s1
     89c:	440000ef          	jal	cdc <kill>
    kill(pid2);
     8a0:	854a                	mv	a0,s2
     8a2:	43a000ef          	jal	cdc <kill>
     8a6:	b7c5                	j	886 <iter+0xaa>

00000000000008a8 <main>:
}

int
main()
{
     8a8:	1101                	add	sp,sp,-32
     8aa:	ec06                	sd	ra,24(sp)
     8ac:	e822                	sd	s0,16(sp)
     8ae:	e426                	sd	s1,8(sp)
     8b0:	1000                	add	s0,sp,32
    }
    if(pid > 0){
      wait(0);
    }
    pause(20);
    rand_next += 1;
     8b2:	00001497          	auipc	s1,0x1
     8b6:	74e48493          	add	s1,s1,1870 # 2000 <rand_next>
     8ba:	a809                	j	8cc <main+0x24>
      iter();
     8bc:	f21ff0ef          	jal	7dc <iter>
    pause(20);
     8c0:	4551                	li	a0,20
     8c2:	47a000ef          	jal	d3c <pause>
    rand_next += 1;
     8c6:	609c                	ld	a5,0(s1)
     8c8:	0785                	add	a5,a5,1
     8ca:	e09c                	sd	a5,0(s1)
    int pid = fork();
     8cc:	3d8000ef          	jal	ca4 <fork>
    if(pid == 0){
     8d0:	d575                	beqz	a0,8bc <main+0x14>
    if(pid > 0){
     8d2:	fea057e3          	blez	a0,8c0 <main+0x18>
      wait(0);
     8d6:	4501                	li	a0,0
     8d8:	3dc000ef          	jal	cb4 <wait>
     8dc:	b7d5                	j	8c0 <main+0x18>

00000000000008de <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start(int argc, char **argv)
{
     8de:	1141                	add	sp,sp,-16
     8e0:	e406                	sd	ra,8(sp)
     8e2:	e022                	sd	s0,0(sp)
     8e4:	0800                	add	s0,sp,16
  int r;
  extern int main(int argc, char **argv);
  r = main(argc, argv);
     8e6:	fc3ff0ef          	jal	8a8 <main>
  exit(r);
     8ea:	3c2000ef          	jal	cac <exit>

00000000000008ee <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
     8ee:	1141                	add	sp,sp,-16
     8f0:	e422                	sd	s0,8(sp)
     8f2:	0800                	add	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
     8f4:	87aa                	mv	a5,a0
     8f6:	0585                	add	a1,a1,1
     8f8:	0785                	add	a5,a5,1
     8fa:	fff5c703          	lbu	a4,-1(a1)
     8fe:	fee78fa3          	sb	a4,-1(a5)
     902:	fb75                	bnez	a4,8f6 <strcpy+0x8>
    ;
  return os;
}
     904:	6422                	ld	s0,8(sp)
     906:	0141                	add	sp,sp,16
     908:	8082                	ret

000000000000090a <strcmp>:

int
strcmp(const char *p, const char *q)
{
     90a:	1141                	add	sp,sp,-16
     90c:	e422                	sd	s0,8(sp)
     90e:	0800                	add	s0,sp,16
  while(*p && *p == *q)
     910:	00054783          	lbu	a5,0(a0)
     914:	cb91                	beqz	a5,928 <strcmp+0x1e>
     916:	0005c703          	lbu	a4,0(a1)
     91a:	00f71763          	bne	a4,a5,928 <strcmp+0x1e>
    p++, q++;
     91e:	0505                	add	a0,a0,1
     920:	0585                	add	a1,a1,1
  while(*p && *p == *q)
     922:	00054783          	lbu	a5,0(a0)
     926:	fbe5                	bnez	a5,916 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
     928:	0005c503          	lbu	a0,0(a1)
}
     92c:	40a7853b          	subw	a0,a5,a0
     930:	6422                	ld	s0,8(sp)
     932:	0141                	add	sp,sp,16
     934:	8082                	ret

0000000000000936 <strncmp>:

int
strncmp(const char *p, const char *q, uint n)
{
     936:	1141                	add	sp,sp,-16
     938:	e422                	sd	s0,8(sp)
     93a:	0800                	add	s0,sp,16
  while(n > 0 && *p && *p == *q) {
     93c:	ce11                	beqz	a2,958 <strncmp+0x22>
     93e:	00054783          	lbu	a5,0(a0)
     942:	cf89                	beqz	a5,95c <strncmp+0x26>
     944:	0005c703          	lbu	a4,0(a1)
     948:	00f71a63          	bne	a4,a5,95c <strncmp+0x26>
    p++, q++, n--;
     94c:	0505                	add	a0,a0,1
     94e:	0585                	add	a1,a1,1
     950:	367d                	addw	a2,a2,-1
  while(n > 0 && *p && *p == *q) {
     952:	f675                	bnez	a2,93e <strncmp+0x8>
  }
  if (n == 0)
    return 0;
     954:	4501                	li	a0,0
     956:	a801                	j	966 <strncmp+0x30>
     958:	4501                	li	a0,0
     95a:	a031                	j	966 <strncmp+0x30>
  return (uchar)*p - (uchar)*q;
     95c:	00054503          	lbu	a0,0(a0)
     960:	0005c783          	lbu	a5,0(a1)
     964:	9d1d                	subw	a0,a0,a5
}
     966:	6422                	ld	s0,8(sp)
     968:	0141                	add	sp,sp,16
     96a:	8082                	ret

000000000000096c <strcat>:

char*
strcat(char *dst, const char *src)
{
     96c:	1141                	add	sp,sp,-16
     96e:	e422                	sd	s0,8(sp)
     970:	0800                	add	s0,sp,16
  char *p = dst;
  while(*p) p++;
     972:	00054783          	lbu	a5,0(a0)
     976:	c385                	beqz	a5,996 <strcat+0x2a>
  char *p = dst;
     978:	87aa                	mv	a5,a0
  while(*p) p++;
     97a:	0785                	add	a5,a5,1
     97c:	0007c703          	lbu	a4,0(a5)
     980:	ff6d                	bnez	a4,97a <strcat+0xe>
  while((*p++ = *src++) != 0);
     982:	0585                	add	a1,a1,1
     984:	0785                	add	a5,a5,1
     986:	fff5c703          	lbu	a4,-1(a1)
     98a:	fee78fa3          	sb	a4,-1(a5)
     98e:	fb75                	bnez	a4,982 <strcat+0x16>
  return dst;
}
     990:	6422                	ld	s0,8(sp)
     992:	0141                	add	sp,sp,16
     994:	8082                	ret
  char *p = dst;
     996:	87aa                	mv	a5,a0
     998:	b7ed                	j	982 <strcat+0x16>

000000000000099a <strncpy>:

char*
strncpy(char *dst, const char *src, int n)
{
     99a:	1141                	add	sp,sp,-16
     99c:	e422                	sd	s0,8(sp)
     99e:	0800                	add	s0,sp,16
  char *p = dst;
     9a0:	87aa                	mv	a5,a0
  while(n > 0 && *src) {
     9a2:	02c05463          	blez	a2,9ca <strncpy+0x30>
     9a6:	0005c703          	lbu	a4,0(a1)
     9aa:	cb01                	beqz	a4,9ba <strncpy+0x20>
    *p++ = *src++;
     9ac:	0585                	add	a1,a1,1
     9ae:	0785                	add	a5,a5,1
     9b0:	fee78fa3          	sb	a4,-1(a5)
    n--;
     9b4:	367d                	addw	a2,a2,-1
  while(n > 0 && *src) {
     9b6:	fa65                	bnez	a2,9a6 <strncpy+0xc>
     9b8:	a809                	j	9ca <strncpy+0x30>
  }
  while(n > 0) {
     9ba:	1602                	sll	a2,a2,0x20
     9bc:	9201                	srl	a2,a2,0x20
     9be:	963e                	add	a2,a2,a5
    *p++ = 0;
     9c0:	0785                	add	a5,a5,1
     9c2:	fe078fa3          	sb	zero,-1(a5)
  while(n > 0) {
     9c6:	fec79de3          	bne	a5,a2,9c0 <strncpy+0x26>
    n--;
  }
  return dst;
}
     9ca:	6422                	ld	s0,8(sp)
     9cc:	0141                	add	sp,sp,16
     9ce:	8082                	ret

00000000000009d0 <strlen>:

uint
strlen(const char *s)
{
     9d0:	1141                	add	sp,sp,-16
     9d2:	e422                	sd	s0,8(sp)
     9d4:	0800                	add	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
     9d6:	00054783          	lbu	a5,0(a0)
     9da:	cf91                	beqz	a5,9f6 <strlen+0x26>
     9dc:	0505                	add	a0,a0,1
     9de:	87aa                	mv	a5,a0
     9e0:	86be                	mv	a3,a5
     9e2:	0785                	add	a5,a5,1
     9e4:	fff7c703          	lbu	a4,-1(a5)
     9e8:	ff65                	bnez	a4,9e0 <strlen+0x10>
     9ea:	40a6853b          	subw	a0,a3,a0
     9ee:	2505                	addw	a0,a0,1
    ;
  return n;
}
     9f0:	6422                	ld	s0,8(sp)
     9f2:	0141                	add	sp,sp,16
     9f4:	8082                	ret
  for(n = 0; s[n]; n++)
     9f6:	4501                	li	a0,0
     9f8:	bfe5                	j	9f0 <strlen+0x20>

00000000000009fa <memset>:

void*
memset(void *dst, int c, uint n)
{
     9fa:	1141                	add	sp,sp,-16
     9fc:	e422                	sd	s0,8(sp)
     9fe:	0800                	add	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
     a00:	ca19                	beqz	a2,a16 <memset+0x1c>
     a02:	87aa                	mv	a5,a0
     a04:	1602                	sll	a2,a2,0x20
     a06:	9201                	srl	a2,a2,0x20
     a08:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
     a0c:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
     a10:	0785                	add	a5,a5,1
     a12:	fee79de3          	bne	a5,a4,a0c <memset+0x12>
  }
  return dst;
}
     a16:	6422                	ld	s0,8(sp)
     a18:	0141                	add	sp,sp,16
     a1a:	8082                	ret

0000000000000a1c <strchr>:

char*
strchr(const char *s, char c)
{
     a1c:	1141                	add	sp,sp,-16
     a1e:	e422                	sd	s0,8(sp)
     a20:	0800                	add	s0,sp,16
  for(; *s; s++)
     a22:	00054783          	lbu	a5,0(a0)
     a26:	cb99                	beqz	a5,a3c <strchr+0x20>
    if(*s == c)
     a28:	00f58763          	beq	a1,a5,a36 <strchr+0x1a>
  for(; *s; s++)
     a2c:	0505                	add	a0,a0,1
     a2e:	00054783          	lbu	a5,0(a0)
     a32:	fbfd                	bnez	a5,a28 <strchr+0xc>
      return (char*)s;
  return 0;
     a34:	4501                	li	a0,0
}
     a36:	6422                	ld	s0,8(sp)
     a38:	0141                	add	sp,sp,16
     a3a:	8082                	ret
  return 0;
     a3c:	4501                	li	a0,0
     a3e:	bfe5                	j	a36 <strchr+0x1a>

0000000000000a40 <gets>:

char*
gets(char *buf, int max)
{
     a40:	711d                	add	sp,sp,-96
     a42:	ec86                	sd	ra,88(sp)
     a44:	e8a2                	sd	s0,80(sp)
     a46:	e4a6                	sd	s1,72(sp)
     a48:	e0ca                	sd	s2,64(sp)
     a4a:	fc4e                	sd	s3,56(sp)
     a4c:	f852                	sd	s4,48(sp)
     a4e:	f456                	sd	s5,40(sp)
     a50:	f05a                	sd	s6,32(sp)
     a52:	ec5e                	sd	s7,24(sp)
     a54:	1080                	add	s0,sp,96
     a56:	8baa                	mv	s7,a0
     a58:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     a5a:	892a                	mv	s2,a0
     a5c:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
     a5e:	4aa9                	li	s5,10
     a60:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
     a62:	89a6                	mv	s3,s1
     a64:	2485                	addw	s1,s1,1
     a66:	0344d663          	bge	s1,s4,a92 <gets+0x52>
    cc = read(0, &c, 1);
     a6a:	4605                	li	a2,1
     a6c:	faf40593          	add	a1,s0,-81
     a70:	4501                	li	a0,0
     a72:	252000ef          	jal	cc4 <read>
    if(cc < 1)
     a76:	00a05e63          	blez	a0,a92 <gets+0x52>
    buf[i++] = c;
     a7a:	faf44783          	lbu	a5,-81(s0)
     a7e:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
     a82:	01578763          	beq	a5,s5,a90 <gets+0x50>
     a86:	0905                	add	s2,s2,1
     a88:	fd679de3          	bne	a5,s6,a62 <gets+0x22>
    buf[i++] = c;
     a8c:	89a6                	mv	s3,s1
     a8e:	a011                	j	a92 <gets+0x52>
     a90:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
     a92:	99de                	add	s3,s3,s7
     a94:	00098023          	sb	zero,0(s3)
  return buf;
}
     a98:	855e                	mv	a0,s7
     a9a:	60e6                	ld	ra,88(sp)
     a9c:	6446                	ld	s0,80(sp)
     a9e:	64a6                	ld	s1,72(sp)
     aa0:	6906                	ld	s2,64(sp)
     aa2:	79e2                	ld	s3,56(sp)
     aa4:	7a42                	ld	s4,48(sp)
     aa6:	7aa2                	ld	s5,40(sp)
     aa8:	7b02                	ld	s6,32(sp)
     aaa:	6be2                	ld	s7,24(sp)
     aac:	6125                	add	sp,sp,96
     aae:	8082                	ret

0000000000000ab0 <stat>:

int
stat(const char *n, struct stat *st)
{
     ab0:	1101                	add	sp,sp,-32
     ab2:	ec06                	sd	ra,24(sp)
     ab4:	e822                	sd	s0,16(sp)
     ab6:	e04a                	sd	s2,0(sp)
     ab8:	1000                	add	s0,sp,32
     aba:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     abc:	4581                	li	a1,0
     abe:	22e000ef          	jal	cec <open>
  if(fd < 0)
     ac2:	02054263          	bltz	a0,ae6 <stat+0x36>
     ac6:	e426                	sd	s1,8(sp)
     ac8:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
     aca:	85ca                	mv	a1,s2
     acc:	238000ef          	jal	d04 <fstat>
     ad0:	892a                	mv	s2,a0
  close(fd);
     ad2:	8526                	mv	a0,s1
     ad4:	200000ef          	jal	cd4 <close>
  return r;
     ad8:	64a2                	ld	s1,8(sp)
}
     ada:	854a                	mv	a0,s2
     adc:	60e2                	ld	ra,24(sp)
     ade:	6442                	ld	s0,16(sp)
     ae0:	6902                	ld	s2,0(sp)
     ae2:	6105                	add	sp,sp,32
     ae4:	8082                	ret
    return -1;
     ae6:	597d                	li	s2,-1
     ae8:	bfcd                	j	ada <stat+0x2a>

0000000000000aea <atoi>:

int
atoi(const char *s)
{
     aea:	1141                	add	sp,sp,-16
     aec:	e422                	sd	s0,8(sp)
     aee:	0800                	add	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
     af0:	00054683          	lbu	a3,0(a0)
     af4:	fd06879b          	addw	a5,a3,-48
     af8:	0ff7f793          	zext.b	a5,a5
     afc:	4625                	li	a2,9
     afe:	02f66863          	bltu	a2,a5,b2e <atoi+0x44>
     b02:	872a                	mv	a4,a0
  n = 0;
     b04:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
     b06:	0705                	add	a4,a4,1
     b08:	0025179b          	sllw	a5,a0,0x2
     b0c:	9fa9                	addw	a5,a5,a0
     b0e:	0017979b          	sllw	a5,a5,0x1
     b12:	9fb5                	addw	a5,a5,a3
     b14:	fd07851b          	addw	a0,a5,-48
  while('0' <= *s && *s <= '9')
     b18:	00074683          	lbu	a3,0(a4)
     b1c:	fd06879b          	addw	a5,a3,-48
     b20:	0ff7f793          	zext.b	a5,a5
     b24:	fef671e3          	bgeu	a2,a5,b06 <atoi+0x1c>
  return n;
}
     b28:	6422                	ld	s0,8(sp)
     b2a:	0141                	add	sp,sp,16
     b2c:	8082                	ret
  n = 0;
     b2e:	4501                	li	a0,0
     b30:	bfe5                	j	b28 <atoi+0x3e>

0000000000000b32 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
     b32:	1141                	add	sp,sp,-16
     b34:	e422                	sd	s0,8(sp)
     b36:	0800                	add	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
     b38:	02b57463          	bgeu	a0,a1,b60 <memmove+0x2e>
    while(n-- > 0)
     b3c:	00c05f63          	blez	a2,b5a <memmove+0x28>
     b40:	1602                	sll	a2,a2,0x20
     b42:	9201                	srl	a2,a2,0x20
     b44:	00c507b3          	add	a5,a0,a2
  dst = vdst;
     b48:	872a                	mv	a4,a0
      *dst++ = *src++;
     b4a:	0585                	add	a1,a1,1
     b4c:	0705                	add	a4,a4,1
     b4e:	fff5c683          	lbu	a3,-1(a1)
     b52:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
     b56:	fef71ae3          	bne	a4,a5,b4a <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
     b5a:	6422                	ld	s0,8(sp)
     b5c:	0141                	add	sp,sp,16
     b5e:	8082                	ret
    dst += n;
     b60:	00c50733          	add	a4,a0,a2
    src += n;
     b64:	95b2                	add	a1,a1,a2
    while(n-- > 0)
     b66:	fec05ae3          	blez	a2,b5a <memmove+0x28>
     b6a:	fff6079b          	addw	a5,a2,-1
     b6e:	1782                	sll	a5,a5,0x20
     b70:	9381                	srl	a5,a5,0x20
     b72:	fff7c793          	not	a5,a5
     b76:	97ba                	add	a5,a5,a4
      *--dst = *--src;
     b78:	15fd                	add	a1,a1,-1
     b7a:	177d                	add	a4,a4,-1
     b7c:	0005c683          	lbu	a3,0(a1)
     b80:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
     b84:	fee79ae3          	bne	a5,a4,b78 <memmove+0x46>
     b88:	bfc9                	j	b5a <memmove+0x28>

0000000000000b8a <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
     b8a:	1141                	add	sp,sp,-16
     b8c:	e422                	sd	s0,8(sp)
     b8e:	0800                	add	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
     b90:	ca05                	beqz	a2,bc0 <memcmp+0x36>
     b92:	fff6069b          	addw	a3,a2,-1
     b96:	1682                	sll	a3,a3,0x20
     b98:	9281                	srl	a3,a3,0x20
     b9a:	0685                	add	a3,a3,1
     b9c:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
     b9e:	00054783          	lbu	a5,0(a0)
     ba2:	0005c703          	lbu	a4,0(a1)
     ba6:	00e79863          	bne	a5,a4,bb6 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
     baa:	0505                	add	a0,a0,1
    p2++;
     bac:	0585                	add	a1,a1,1
  while (n-- > 0) {
     bae:	fed518e3          	bne	a0,a3,b9e <memcmp+0x14>
  }
  return 0;
     bb2:	4501                	li	a0,0
     bb4:	a019                	j	bba <memcmp+0x30>
      return *p1 - *p2;
     bb6:	40e7853b          	subw	a0,a5,a4
}
     bba:	6422                	ld	s0,8(sp)
     bbc:	0141                	add	sp,sp,16
     bbe:	8082                	ret
  return 0;
     bc0:	4501                	li	a0,0
     bc2:	bfe5                	j	bba <memcmp+0x30>

0000000000000bc4 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
     bc4:	1141                	add	sp,sp,-16
     bc6:	e406                	sd	ra,8(sp)
     bc8:	e022                	sd	s0,0(sp)
     bca:	0800                	add	s0,sp,16
  return memmove(dst, src, n);
     bcc:	f67ff0ef          	jal	b32 <memmove>
}
     bd0:	60a2                	ld	ra,8(sp)
     bd2:	6402                	ld	s0,0(sp)
     bd4:	0141                	add	sp,sp,16
     bd6:	8082                	ret

0000000000000bd8 <sbrk>:

char *
sbrk(int n) {
     bd8:	1141                	add	sp,sp,-16
     bda:	e406                	sd	ra,8(sp)
     bdc:	e022                	sd	s0,0(sp)
     bde:	0800                	add	s0,sp,16
  return sys_sbrk(n, SBRK_EAGER);
     be0:	4585                	li	a1,1
     be2:	152000ef          	jal	d34 <sys_sbrk>
}
     be6:	60a2                	ld	ra,8(sp)
     be8:	6402                	ld	s0,0(sp)
     bea:	0141                	add	sp,sp,16
     bec:	8082                	ret

0000000000000bee <sbrklazy>:

char *
sbrklazy(int n) {
     bee:	1141                	add	sp,sp,-16
     bf0:	e406                	sd	ra,8(sp)
     bf2:	e022                	sd	s0,0(sp)
     bf4:	0800                	add	s0,sp,16
  return sys_sbrk(n, SBRK_LAZY);
     bf6:	4589                	li	a1,2
     bf8:	13c000ef          	jal	d34 <sys_sbrk>
}
     bfc:	60a2                	ld	ra,8(sp)
     bfe:	6402                	ld	s0,0(sp)
     c00:	0141                	add	sp,sp,16
     c02:	8082                	ret

0000000000000c04 <htons>:

// Byte order conversion functions
unsigned short
htons(unsigned short hostshort)
{
     c04:	1141                	add	sp,sp,-16
     c06:	e422                	sd	s0,8(sp)
     c08:	0800                	add	s0,sp,16
  return ((hostshort >> 8) & 0xff) | ((hostshort & 0xff) << 8);
     c0a:	0085179b          	sllw	a5,a0,0x8
     c0e:	0085551b          	srlw	a0,a0,0x8
     c12:	8d5d                	or	a0,a0,a5
}
     c14:	1542                	sll	a0,a0,0x30
     c16:	9141                	srl	a0,a0,0x30
     c18:	6422                	ld	s0,8(sp)
     c1a:	0141                	add	sp,sp,16
     c1c:	8082                	ret

0000000000000c1e <ntohs>:

unsigned short
ntohs(unsigned short netshort)
{
     c1e:	1141                	add	sp,sp,-16
     c20:	e422                	sd	s0,8(sp)
     c22:	0800                	add	s0,sp,16
  return ((netshort >> 8) & 0xff) | ((netshort & 0xff) << 8);
     c24:	0085179b          	sllw	a5,a0,0x8
     c28:	0085551b          	srlw	a0,a0,0x8
     c2c:	8d5d                	or	a0,a0,a5
}
     c2e:	1542                	sll	a0,a0,0x30
     c30:	9141                	srl	a0,a0,0x30
     c32:	6422                	ld	s0,8(sp)
     c34:	0141                	add	sp,sp,16
     c36:	8082                	ret

0000000000000c38 <htonl>:

unsigned long
htonl(unsigned long hostlong)
{
     c38:	1141                	add	sp,sp,-16
     c3a:	e422                	sd	s0,8(sp)
     c3c:	0800                	add	s0,sp,16
  return ((hostlong >> 24) & 0xff) |
     c3e:	0185579b          	srlw	a5,a0,0x18
         ((hostlong >> 8) & 0xff00) |
     c42:	00855713          	srl	a4,a0,0x8
     c46:	66c1                	lui	a3,0x10
     c48:	f0068693          	add	a3,a3,-256 # ff00 <base+0xdaf8>
     c4c:	8f75                	and	a4,a4,a3
  return ((hostlong >> 24) & 0xff) |
     c4e:	8fd9                	or	a5,a5,a4
         ((hostlong & 0xff00) << 8) |
     c50:	00851713          	sll	a4,a0,0x8
     c54:	00ff06b7          	lui	a3,0xff0
     c58:	8f75                	and	a4,a4,a3
         ((hostlong >> 8) & 0xff00) |
     c5a:	8fd9                	or	a5,a5,a4
         ((hostlong & 0xff) << 24);
     c5c:	0562                	sll	a0,a0,0x18
     c5e:	0ff00713          	li	a4,255
     c62:	0762                	sll	a4,a4,0x18
     c64:	8d79                	and	a0,a0,a4
}
     c66:	8d5d                	or	a0,a0,a5
     c68:	6422                	ld	s0,8(sp)
     c6a:	0141                	add	sp,sp,16
     c6c:	8082                	ret

0000000000000c6e <ntohl>:

unsigned long
ntohl(unsigned long netlong)
{
     c6e:	1141                	add	sp,sp,-16
     c70:	e422                	sd	s0,8(sp)
     c72:	0800                	add	s0,sp,16
  return ((netlong >> 24) & 0xff) |
     c74:	0185579b          	srlw	a5,a0,0x18
         ((netlong >> 8) & 0xff00) |
     c78:	00855713          	srl	a4,a0,0x8
     c7c:	66c1                	lui	a3,0x10
     c7e:	f0068693          	add	a3,a3,-256 # ff00 <base+0xdaf8>
     c82:	8f75                	and	a4,a4,a3
  return ((netlong >> 24) & 0xff) |
     c84:	8fd9                	or	a5,a5,a4
         ((netlong & 0xff00) << 8) |
     c86:	00851713          	sll	a4,a0,0x8
     c8a:	00ff06b7          	lui	a3,0xff0
     c8e:	8f75                	and	a4,a4,a3
         ((netlong >> 8) & 0xff00) |
     c90:	8fd9                	or	a5,a5,a4
         ((netlong & 0xff) << 24);
     c92:	0562                	sll	a0,a0,0x18
     c94:	0ff00713          	li	a4,255
     c98:	0762                	sll	a4,a4,0x18
     c9a:	8d79                	and	a0,a0,a4
}
     c9c:	8d5d                	or	a0,a0,a5
     c9e:	6422                	ld	s0,8(sp)
     ca0:	0141                	add	sp,sp,16
     ca2:	8082                	ret

0000000000000ca4 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
     ca4:	4885                	li	a7,1
 ecall
     ca6:	00000073          	ecall
 ret
     caa:	8082                	ret

0000000000000cac <exit>:
.global exit
exit:
 li a7, SYS_exit
     cac:	4889                	li	a7,2
 ecall
     cae:	00000073          	ecall
 ret
     cb2:	8082                	ret

0000000000000cb4 <wait>:
.global wait
wait:
 li a7, SYS_wait
     cb4:	488d                	li	a7,3
 ecall
     cb6:	00000073          	ecall
 ret
     cba:	8082                	ret

0000000000000cbc <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
     cbc:	4891                	li	a7,4
 ecall
     cbe:	00000073          	ecall
 ret
     cc2:	8082                	ret

0000000000000cc4 <read>:
.global read
read:
 li a7, SYS_read
     cc4:	4895                	li	a7,5
 ecall
     cc6:	00000073          	ecall
 ret
     cca:	8082                	ret

0000000000000ccc <write>:
.global write
write:
 li a7, SYS_write
     ccc:	48c1                	li	a7,16
 ecall
     cce:	00000073          	ecall
 ret
     cd2:	8082                	ret

0000000000000cd4 <close>:
.global close
close:
 li a7, SYS_close
     cd4:	48d5                	li	a7,21
 ecall
     cd6:	00000073          	ecall
 ret
     cda:	8082                	ret

0000000000000cdc <kill>:
.global kill
kill:
 li a7, SYS_kill
     cdc:	4899                	li	a7,6
 ecall
     cde:	00000073          	ecall
 ret
     ce2:	8082                	ret

0000000000000ce4 <exec>:
.global exec
exec:
 li a7, SYS_exec
     ce4:	489d                	li	a7,7
 ecall
     ce6:	00000073          	ecall
 ret
     cea:	8082                	ret

0000000000000cec <open>:
.global open
open:
 li a7, SYS_open
     cec:	48bd                	li	a7,15
 ecall
     cee:	00000073          	ecall
 ret
     cf2:	8082                	ret

0000000000000cf4 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
     cf4:	48c5                	li	a7,17
 ecall
     cf6:	00000073          	ecall
 ret
     cfa:	8082                	ret

0000000000000cfc <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
     cfc:	48c9                	li	a7,18
 ecall
     cfe:	00000073          	ecall
 ret
     d02:	8082                	ret

0000000000000d04 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
     d04:	48a1                	li	a7,8
 ecall
     d06:	00000073          	ecall
 ret
     d0a:	8082                	ret

0000000000000d0c <link>:
.global link
link:
 li a7, SYS_link
     d0c:	48cd                	li	a7,19
 ecall
     d0e:	00000073          	ecall
 ret
     d12:	8082                	ret

0000000000000d14 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
     d14:	48d1                	li	a7,20
 ecall
     d16:	00000073          	ecall
 ret
     d1a:	8082                	ret

0000000000000d1c <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
     d1c:	48a5                	li	a7,9
 ecall
     d1e:	00000073          	ecall
 ret
     d22:	8082                	ret

0000000000000d24 <dup>:
.global dup
dup:
 li a7, SYS_dup
     d24:	48a9                	li	a7,10
 ecall
     d26:	00000073          	ecall
 ret
     d2a:	8082                	ret

0000000000000d2c <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
     d2c:	48ad                	li	a7,11
 ecall
     d2e:	00000073          	ecall
 ret
     d32:	8082                	ret

0000000000000d34 <sys_sbrk>:
.global sys_sbrk
sys_sbrk:
 li a7, SYS_sbrk
     d34:	48b1                	li	a7,12
 ecall
     d36:	00000073          	ecall
 ret
     d3a:	8082                	ret

0000000000000d3c <pause>:
.global pause
pause:
 li a7, SYS_pause
     d3c:	48b5                	li	a7,13
 ecall
     d3e:	00000073          	ecall
 ret
     d42:	8082                	ret

0000000000000d44 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
     d44:	48b9                	li	a7,14
 ecall
     d46:	00000073          	ecall
 ret
     d4a:	8082                	ret

0000000000000d4c <socket>:
.global socket
socket:
 li a7, SYS_socket
     d4c:	48d9                	li	a7,22
 ecall
     d4e:	00000073          	ecall
 ret
     d52:	8082                	ret

0000000000000d54 <bind>:
.global bind
bind:
 li a7, SYS_bind
     d54:	48dd                	li	a7,23
 ecall
     d56:	00000073          	ecall
 ret
     d5a:	8082                	ret

0000000000000d5c <listen>:
.global listen
listen:
 li a7, SYS_listen
     d5c:	48e1                	li	a7,24
 ecall
     d5e:	00000073          	ecall
 ret
     d62:	8082                	ret

0000000000000d64 <accept>:
.global accept
accept:
 li a7, SYS_accept
     d64:	48e5                	li	a7,25
 ecall
     d66:	00000073          	ecall
 ret
     d6a:	8082                	ret

0000000000000d6c <connect>:
.global connect
connect:
 li a7, SYS_connect
     d6c:	48e9                	li	a7,26
 ecall
     d6e:	00000073          	ecall
 ret
     d72:	8082                	ret

0000000000000d74 <send>:
.global send
send:
 li a7, SYS_send
     d74:	48ed                	li	a7,27
 ecall
     d76:	00000073          	ecall
 ret
     d7a:	8082                	ret

0000000000000d7c <recv>:
.global recv
recv:
 li a7, SYS_recv
     d7c:	48f1                	li	a7,28
 ecall
     d7e:	00000073          	ecall
 ret
     d82:	8082                	ret

0000000000000d84 <sendto>:
.global sendto
sendto:
 li a7, SYS_sendto
     d84:	48f5                	li	a7,29
 ecall
     d86:	00000073          	ecall
 ret
     d8a:	8082                	ret

0000000000000d8c <recvfrom>:
.global recvfrom
recvfrom:
 li a7, SYS_recvfrom
     d8c:	48f9                	li	a7,30
 ecall
     d8e:	00000073          	ecall
 ret
     d92:	8082                	ret

0000000000000d94 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
     d94:	1101                	add	sp,sp,-32
     d96:	ec06                	sd	ra,24(sp)
     d98:	e822                	sd	s0,16(sp)
     d9a:	1000                	add	s0,sp,32
     d9c:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
     da0:	4605                	li	a2,1
     da2:	fef40593          	add	a1,s0,-17
     da6:	f27ff0ef          	jal	ccc <write>
}
     daa:	60e2                	ld	ra,24(sp)
     dac:	6442                	ld	s0,16(sp)
     dae:	6105                	add	sp,sp,32
     db0:	8082                	ret

0000000000000db2 <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
     db2:	715d                	add	sp,sp,-80
     db4:	e486                	sd	ra,72(sp)
     db6:	e0a2                	sd	s0,64(sp)
     db8:	f84a                	sd	s2,48(sp)
     dba:	0880                	add	s0,sp,80
     dbc:	892a                	mv	s2,a0
  char buf[20];
  int i, neg;
  unsigned long long x;

  neg = 0;
  if(sgn && xx < 0){
     dbe:	c299                	beqz	a3,dc4 <printint+0x12>
     dc0:	0805c363          	bltz	a1,e46 <printint+0x94>
  neg = 0;
     dc4:	4881                	li	a7,0
     dc6:	fb840693          	add	a3,s0,-72
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
     dca:	4781                	li	a5,0
  do{
    buf[i++] = digits[x % base];
     dcc:	00001517          	auipc	a0,0x1
     dd0:	87450513          	add	a0,a0,-1932 # 1640 <digits>
     dd4:	883e                	mv	a6,a5
     dd6:	2785                	addw	a5,a5,1
     dd8:	02c5f733          	remu	a4,a1,a2
     ddc:	972a                	add	a4,a4,a0
     dde:	00074703          	lbu	a4,0(a4)
     de2:	00e68023          	sb	a4,0(a3) # ff0000 <base+0xfedbf8>
  }while((x /= base) != 0);
     de6:	872e                	mv	a4,a1
     de8:	02c5d5b3          	divu	a1,a1,a2
     dec:	0685                	add	a3,a3,1
     dee:	fec773e3          	bgeu	a4,a2,dd4 <printint+0x22>
  if(neg)
     df2:	00088b63          	beqz	a7,e08 <printint+0x56>
    buf[i++] = '-';
     df6:	fd078793          	add	a5,a5,-48
     dfa:	97a2                	add	a5,a5,s0
     dfc:	02d00713          	li	a4,45
     e00:	fee78423          	sb	a4,-24(a5)
     e04:	0028079b          	addw	a5,a6,2

  while(--i >= 0)
     e08:	02f05a63          	blez	a5,e3c <printint+0x8a>
     e0c:	fc26                	sd	s1,56(sp)
     e0e:	f44e                	sd	s3,40(sp)
     e10:	fb840713          	add	a4,s0,-72
     e14:	00f704b3          	add	s1,a4,a5
     e18:	fff70993          	add	s3,a4,-1
     e1c:	99be                	add	s3,s3,a5
     e1e:	37fd                	addw	a5,a5,-1
     e20:	1782                	sll	a5,a5,0x20
     e22:	9381                	srl	a5,a5,0x20
     e24:	40f989b3          	sub	s3,s3,a5
    putc(fd, buf[i]);
     e28:	fff4c583          	lbu	a1,-1(s1)
     e2c:	854a                	mv	a0,s2
     e2e:	f67ff0ef          	jal	d94 <putc>
  while(--i >= 0)
     e32:	14fd                	add	s1,s1,-1
     e34:	ff349ae3          	bne	s1,s3,e28 <printint+0x76>
     e38:	74e2                	ld	s1,56(sp)
     e3a:	79a2                	ld	s3,40(sp)
}
     e3c:	60a6                	ld	ra,72(sp)
     e3e:	6406                	ld	s0,64(sp)
     e40:	7942                	ld	s2,48(sp)
     e42:	6161                	add	sp,sp,80
     e44:	8082                	ret
    x = -xx;
     e46:	40b005b3          	neg	a1,a1
    neg = 1;
     e4a:	4885                	li	a7,1
    x = -xx;
     e4c:	bfad                	j	dc6 <printint+0x14>

0000000000000e4e <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %c, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
     e4e:	711d                	add	sp,sp,-96
     e50:	ec86                	sd	ra,88(sp)
     e52:	e8a2                	sd	s0,80(sp)
     e54:	e0ca                	sd	s2,64(sp)
     e56:	1080                	add	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
     e58:	0005c903          	lbu	s2,0(a1)
     e5c:	28090663          	beqz	s2,10e8 <vprintf+0x29a>
     e60:	e4a6                	sd	s1,72(sp)
     e62:	fc4e                	sd	s3,56(sp)
     e64:	f852                	sd	s4,48(sp)
     e66:	f456                	sd	s5,40(sp)
     e68:	f05a                	sd	s6,32(sp)
     e6a:	ec5e                	sd	s7,24(sp)
     e6c:	e862                	sd	s8,16(sp)
     e6e:	e466                	sd	s9,8(sp)
     e70:	8b2a                	mv	s6,a0
     e72:	8a2e                	mv	s4,a1
     e74:	8bb2                	mv	s7,a2
  state = 0;
     e76:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
     e78:	4481                	li	s1,0
     e7a:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
     e7c:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
     e80:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
     e84:	06c00c93          	li	s9,108
     e88:	a005                	j	ea8 <vprintf+0x5a>
        putc(fd, c0);
     e8a:	85ca                	mv	a1,s2
     e8c:	855a                	mv	a0,s6
     e8e:	f07ff0ef          	jal	d94 <putc>
     e92:	a019                	j	e98 <vprintf+0x4a>
    } else if(state == '%'){
     e94:	03598263          	beq	s3,s5,eb8 <vprintf+0x6a>
  for(i = 0; fmt[i]; i++){
     e98:	2485                	addw	s1,s1,1
     e9a:	8726                	mv	a4,s1
     e9c:	009a07b3          	add	a5,s4,s1
     ea0:	0007c903          	lbu	s2,0(a5)
     ea4:	22090a63          	beqz	s2,10d8 <vprintf+0x28a>
    c0 = fmt[i] & 0xff;
     ea8:	0009079b          	sext.w	a5,s2
    if(state == 0){
     eac:	fe0994e3          	bnez	s3,e94 <vprintf+0x46>
      if(c0 == '%'){
     eb0:	fd579de3          	bne	a5,s5,e8a <vprintf+0x3c>
        state = '%';
     eb4:	89be                	mv	s3,a5
     eb6:	b7cd                	j	e98 <vprintf+0x4a>
      if(c0) c1 = fmt[i+1] & 0xff;
     eb8:	00ea06b3          	add	a3,s4,a4
     ebc:	0016c683          	lbu	a3,1(a3)
      c1 = c2 = 0;
     ec0:	8636                	mv	a2,a3
      if(c1) c2 = fmt[i+2] & 0xff;
     ec2:	c681                	beqz	a3,eca <vprintf+0x7c>
     ec4:	9752                	add	a4,a4,s4
     ec6:	00274603          	lbu	a2,2(a4)
      if(c0 == 'd'){
     eca:	05878363          	beq	a5,s8,f10 <vprintf+0xc2>
      } else if(c0 == 'l' && c1 == 'd'){
     ece:	05978d63          	beq	a5,s9,f28 <vprintf+0xda>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
     ed2:	07500713          	li	a4,117
     ed6:	0ee78763          	beq	a5,a4,fc4 <vprintf+0x176>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
     eda:	07800713          	li	a4,120
     ede:	12e78963          	beq	a5,a4,1010 <vprintf+0x1c2>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
     ee2:	07000713          	li	a4,112
     ee6:	14e78e63          	beq	a5,a4,1042 <vprintf+0x1f4>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 'c'){
     eea:	06300713          	li	a4,99
     eee:	18e78e63          	beq	a5,a4,108a <vprintf+0x23c>
        putc(fd, va_arg(ap, uint32));
      } else if(c0 == 's'){
     ef2:	07300713          	li	a4,115
     ef6:	1ae78463          	beq	a5,a4,109e <vprintf+0x250>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
     efa:	02500713          	li	a4,37
     efe:	04e79563          	bne	a5,a4,f48 <vprintf+0xfa>
        putc(fd, '%');
     f02:	02500593          	li	a1,37
     f06:	855a                	mv	a0,s6
     f08:	e8dff0ef          	jal	d94 <putc>
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c0);
      }

      state = 0;
     f0c:	4981                	li	s3,0
     f0e:	b769                	j	e98 <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 1);
     f10:	008b8913          	add	s2,s7,8
     f14:	4685                	li	a3,1
     f16:	4629                	li	a2,10
     f18:	000ba583          	lw	a1,0(s7)
     f1c:	855a                	mv	a0,s6
     f1e:	e95ff0ef          	jal	db2 <printint>
     f22:	8bca                	mv	s7,s2
      state = 0;
     f24:	4981                	li	s3,0
     f26:	bf8d                	j	e98 <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'd'){
     f28:	06400793          	li	a5,100
     f2c:	02f68963          	beq	a3,a5,f5e <vprintf+0x110>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
     f30:	06c00793          	li	a5,108
     f34:	04f68263          	beq	a3,a5,f78 <vprintf+0x12a>
      } else if(c0 == 'l' && c1 == 'u'){
     f38:	07500793          	li	a5,117
     f3c:	0af68063          	beq	a3,a5,fdc <vprintf+0x18e>
      } else if(c0 == 'l' && c1 == 'x'){
     f40:	07800793          	li	a5,120
     f44:	0ef68263          	beq	a3,a5,1028 <vprintf+0x1da>
        putc(fd, '%');
     f48:	02500593          	li	a1,37
     f4c:	855a                	mv	a0,s6
     f4e:	e47ff0ef          	jal	d94 <putc>
        putc(fd, c0);
     f52:	85ca                	mv	a1,s2
     f54:	855a                	mv	a0,s6
     f56:	e3fff0ef          	jal	d94 <putc>
      state = 0;
     f5a:	4981                	li	s3,0
     f5c:	bf35                	j	e98 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
     f5e:	008b8913          	add	s2,s7,8
     f62:	4685                	li	a3,1
     f64:	4629                	li	a2,10
     f66:	000bb583          	ld	a1,0(s7)
     f6a:	855a                	mv	a0,s6
     f6c:	e47ff0ef          	jal	db2 <printint>
        i += 1;
     f70:	2485                	addw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 1);
     f72:	8bca                	mv	s7,s2
      state = 0;
     f74:	4981                	li	s3,0
        i += 1;
     f76:	b70d                	j	e98 <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
     f78:	06400793          	li	a5,100
     f7c:	02f60763          	beq	a2,a5,faa <vprintf+0x15c>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
     f80:	07500793          	li	a5,117
     f84:	06f60963          	beq	a2,a5,ff6 <vprintf+0x1a8>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
     f88:	07800793          	li	a5,120
     f8c:	faf61ee3          	bne	a2,a5,f48 <vprintf+0xfa>
        printint(fd, va_arg(ap, uint64), 16, 0);
     f90:	008b8913          	add	s2,s7,8
     f94:	4681                	li	a3,0
     f96:	4641                	li	a2,16
     f98:	000bb583          	ld	a1,0(s7)
     f9c:	855a                	mv	a0,s6
     f9e:	e15ff0ef          	jal	db2 <printint>
        i += 2;
     fa2:	2489                	addw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 16, 0);
     fa4:	8bca                	mv	s7,s2
      state = 0;
     fa6:	4981                	li	s3,0
        i += 2;
     fa8:	bdc5                	j	e98 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
     faa:	008b8913          	add	s2,s7,8
     fae:	4685                	li	a3,1
     fb0:	4629                	li	a2,10
     fb2:	000bb583          	ld	a1,0(s7)
     fb6:	855a                	mv	a0,s6
     fb8:	dfbff0ef          	jal	db2 <printint>
        i += 2;
     fbc:	2489                	addw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 1);
     fbe:	8bca                	mv	s7,s2
      state = 0;
     fc0:	4981                	li	s3,0
        i += 2;
     fc2:	bdd9                	j	e98 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint32), 10, 0);
     fc4:	008b8913          	add	s2,s7,8
     fc8:	4681                	li	a3,0
     fca:	4629                	li	a2,10
     fcc:	000be583          	lwu	a1,0(s7)
     fd0:	855a                	mv	a0,s6
     fd2:	de1ff0ef          	jal	db2 <printint>
     fd6:	8bca                	mv	s7,s2
      state = 0;
     fd8:	4981                	li	s3,0
     fda:	bd7d                	j	e98 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
     fdc:	008b8913          	add	s2,s7,8
     fe0:	4681                	li	a3,0
     fe2:	4629                	li	a2,10
     fe4:	000bb583          	ld	a1,0(s7)
     fe8:	855a                	mv	a0,s6
     fea:	dc9ff0ef          	jal	db2 <printint>
        i += 1;
     fee:	2485                	addw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 0);
     ff0:	8bca                	mv	s7,s2
      state = 0;
     ff2:	4981                	li	s3,0
        i += 1;
     ff4:	b555                	j	e98 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
     ff6:	008b8913          	add	s2,s7,8
     ffa:	4681                	li	a3,0
     ffc:	4629                	li	a2,10
     ffe:	000bb583          	ld	a1,0(s7)
    1002:	855a                	mv	a0,s6
    1004:	dafff0ef          	jal	db2 <printint>
        i += 2;
    1008:	2489                	addw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 0);
    100a:	8bca                	mv	s7,s2
      state = 0;
    100c:	4981                	li	s3,0
        i += 2;
    100e:	b569                	j	e98 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint32), 16, 0);
    1010:	008b8913          	add	s2,s7,8
    1014:	4681                	li	a3,0
    1016:	4641                	li	a2,16
    1018:	000be583          	lwu	a1,0(s7)
    101c:	855a                	mv	a0,s6
    101e:	d95ff0ef          	jal	db2 <printint>
    1022:	8bca                	mv	s7,s2
      state = 0;
    1024:	4981                	li	s3,0
    1026:	bd8d                	j	e98 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 16, 0);
    1028:	008b8913          	add	s2,s7,8
    102c:	4681                	li	a3,0
    102e:	4641                	li	a2,16
    1030:	000bb583          	ld	a1,0(s7)
    1034:	855a                	mv	a0,s6
    1036:	d7dff0ef          	jal	db2 <printint>
        i += 1;
    103a:	2485                	addw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 16, 0);
    103c:	8bca                	mv	s7,s2
      state = 0;
    103e:	4981                	li	s3,0
        i += 1;
    1040:	bda1                	j	e98 <vprintf+0x4a>
    1042:	e06a                	sd	s10,0(sp)
        printptr(fd, va_arg(ap, uint64));
    1044:	008b8d13          	add	s10,s7,8
    1048:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
    104c:	03000593          	li	a1,48
    1050:	855a                	mv	a0,s6
    1052:	d43ff0ef          	jal	d94 <putc>
  putc(fd, 'x');
    1056:	07800593          	li	a1,120
    105a:	855a                	mv	a0,s6
    105c:	d39ff0ef          	jal	d94 <putc>
    1060:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
    1062:	00000b97          	auipc	s7,0x0
    1066:	5deb8b93          	add	s7,s7,1502 # 1640 <digits>
    106a:	03c9d793          	srl	a5,s3,0x3c
    106e:	97de                	add	a5,a5,s7
    1070:	0007c583          	lbu	a1,0(a5)
    1074:	855a                	mv	a0,s6
    1076:	d1fff0ef          	jal	d94 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    107a:	0992                	sll	s3,s3,0x4
    107c:	397d                	addw	s2,s2,-1
    107e:	fe0916e3          	bnez	s2,106a <vprintf+0x21c>
        printptr(fd, va_arg(ap, uint64));
    1082:	8bea                	mv	s7,s10
      state = 0;
    1084:	4981                	li	s3,0
    1086:	6d02                	ld	s10,0(sp)
    1088:	bd01                	j	e98 <vprintf+0x4a>
        putc(fd, va_arg(ap, uint32));
    108a:	008b8913          	add	s2,s7,8
    108e:	000bc583          	lbu	a1,0(s7)
    1092:	855a                	mv	a0,s6
    1094:	d01ff0ef          	jal	d94 <putc>
    1098:	8bca                	mv	s7,s2
      state = 0;
    109a:	4981                	li	s3,0
    109c:	bbf5                	j	e98 <vprintf+0x4a>
        if((s = va_arg(ap, char*)) == 0)
    109e:	008b8993          	add	s3,s7,8
    10a2:	000bb903          	ld	s2,0(s7)
    10a6:	00090f63          	beqz	s2,10c4 <vprintf+0x276>
        for(; *s; s++)
    10aa:	00094583          	lbu	a1,0(s2)
    10ae:	c195                	beqz	a1,10d2 <vprintf+0x284>
          putc(fd, *s);
    10b0:	855a                	mv	a0,s6
    10b2:	ce3ff0ef          	jal	d94 <putc>
        for(; *s; s++)
    10b6:	0905                	add	s2,s2,1
    10b8:	00094583          	lbu	a1,0(s2)
    10bc:	f9f5                	bnez	a1,10b0 <vprintf+0x262>
        if((s = va_arg(ap, char*)) == 0)
    10be:	8bce                	mv	s7,s3
      state = 0;
    10c0:	4981                	li	s3,0
    10c2:	bbd9                	j	e98 <vprintf+0x4a>
          s = "(null)";
    10c4:	00000917          	auipc	s2,0x0
    10c8:	51490913          	add	s2,s2,1300 # 15d8 <malloc+0x408>
        for(; *s; s++)
    10cc:	02800593          	li	a1,40
    10d0:	b7c5                	j	10b0 <vprintf+0x262>
        if((s = va_arg(ap, char*)) == 0)
    10d2:	8bce                	mv	s7,s3
      state = 0;
    10d4:	4981                	li	s3,0
    10d6:	b3c9                	j	e98 <vprintf+0x4a>
    10d8:	64a6                	ld	s1,72(sp)
    10da:	79e2                	ld	s3,56(sp)
    10dc:	7a42                	ld	s4,48(sp)
    10de:	7aa2                	ld	s5,40(sp)
    10e0:	7b02                	ld	s6,32(sp)
    10e2:	6be2                	ld	s7,24(sp)
    10e4:	6c42                	ld	s8,16(sp)
    10e6:	6ca2                	ld	s9,8(sp)
    }
  }
}
    10e8:	60e6                	ld	ra,88(sp)
    10ea:	6446                	ld	s0,80(sp)
    10ec:	6906                	ld	s2,64(sp)
    10ee:	6125                	add	sp,sp,96
    10f0:	8082                	ret

00000000000010f2 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
    10f2:	715d                	add	sp,sp,-80
    10f4:	ec06                	sd	ra,24(sp)
    10f6:	e822                	sd	s0,16(sp)
    10f8:	1000                	add	s0,sp,32
    10fa:	e010                	sd	a2,0(s0)
    10fc:	e414                	sd	a3,8(s0)
    10fe:	e818                	sd	a4,16(s0)
    1100:	ec1c                	sd	a5,24(s0)
    1102:	03043023          	sd	a6,32(s0)
    1106:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
    110a:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
    110e:	8622                	mv	a2,s0
    1110:	d3fff0ef          	jal	e4e <vprintf>
}
    1114:	60e2                	ld	ra,24(sp)
    1116:	6442                	ld	s0,16(sp)
    1118:	6161                	add	sp,sp,80
    111a:	8082                	ret

000000000000111c <printf>:

void
printf(const char *fmt, ...)
{
    111c:	711d                	add	sp,sp,-96
    111e:	ec06                	sd	ra,24(sp)
    1120:	e822                	sd	s0,16(sp)
    1122:	1000                	add	s0,sp,32
    1124:	e40c                	sd	a1,8(s0)
    1126:	e810                	sd	a2,16(s0)
    1128:	ec14                	sd	a3,24(s0)
    112a:	f018                	sd	a4,32(s0)
    112c:	f41c                	sd	a5,40(s0)
    112e:	03043823          	sd	a6,48(s0)
    1132:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
    1136:	00840613          	add	a2,s0,8
    113a:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
    113e:	85aa                	mv	a1,a0
    1140:	4505                	li	a0,1
    1142:	d0dff0ef          	jal	e4e <vprintf>
}
    1146:	60e2                	ld	ra,24(sp)
    1148:	6442                	ld	s0,16(sp)
    114a:	6125                	add	sp,sp,96
    114c:	8082                	ret

000000000000114e <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    114e:	1141                	add	sp,sp,-16
    1150:	e422                	sd	s0,8(sp)
    1152:	0800                	add	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
    1154:	ff050693          	add	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1158:	00001797          	auipc	a5,0x1
    115c:	eb87b783          	ld	a5,-328(a5) # 2010 <freep>
    1160:	a02d                	j	118a <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
    1162:	4618                	lw	a4,8(a2)
    1164:	9f2d                	addw	a4,a4,a1
    1166:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
    116a:	6398                	ld	a4,0(a5)
    116c:	6310                	ld	a2,0(a4)
    116e:	a83d                	j	11ac <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    1170:	ff852703          	lw	a4,-8(a0)
    1174:	9f31                	addw	a4,a4,a2
    1176:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
    1178:	ff053683          	ld	a3,-16(a0)
    117c:	a091                	j	11c0 <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    117e:	6398                	ld	a4,0(a5)
    1180:	00e7e463          	bltu	a5,a4,1188 <free+0x3a>
    1184:	00e6ea63          	bltu	a3,a4,1198 <free+0x4a>
{
    1188:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    118a:	fed7fae3          	bgeu	a5,a3,117e <free+0x30>
    118e:	6398                	ld	a4,0(a5)
    1190:	00e6e463          	bltu	a3,a4,1198 <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1194:	fee7eae3          	bltu	a5,a4,1188 <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
    1198:	ff852583          	lw	a1,-8(a0)
    119c:	6390                	ld	a2,0(a5)
    119e:	02059813          	sll	a6,a1,0x20
    11a2:	01c85713          	srl	a4,a6,0x1c
    11a6:	9736                	add	a4,a4,a3
    11a8:	fae60de3          	beq	a2,a4,1162 <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
    11ac:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
    11b0:	4790                	lw	a2,8(a5)
    11b2:	02061593          	sll	a1,a2,0x20
    11b6:	01c5d713          	srl	a4,a1,0x1c
    11ba:	973e                	add	a4,a4,a5
    11bc:	fae68ae3          	beq	a3,a4,1170 <free+0x22>
    p->s.ptr = bp->s.ptr;
    11c0:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
    11c2:	00001717          	auipc	a4,0x1
    11c6:	e4f73723          	sd	a5,-434(a4) # 2010 <freep>
}
    11ca:	6422                	ld	s0,8(sp)
    11cc:	0141                	add	sp,sp,16
    11ce:	8082                	ret

00000000000011d0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    11d0:	7139                	add	sp,sp,-64
    11d2:	fc06                	sd	ra,56(sp)
    11d4:	f822                	sd	s0,48(sp)
    11d6:	f426                	sd	s1,40(sp)
    11d8:	ec4e                	sd	s3,24(sp)
    11da:	0080                	add	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    11dc:	02051493          	sll	s1,a0,0x20
    11e0:	9081                	srl	s1,s1,0x20
    11e2:	04bd                	add	s1,s1,15
    11e4:	8091                	srl	s1,s1,0x4
    11e6:	0014899b          	addw	s3,s1,1
    11ea:	0485                	add	s1,s1,1
  if((prevp = freep) == 0){
    11ec:	00001517          	auipc	a0,0x1
    11f0:	e2453503          	ld	a0,-476(a0) # 2010 <freep>
    11f4:	c915                	beqz	a0,1228 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    11f6:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    11f8:	4798                	lw	a4,8(a5)
    11fa:	08977a63          	bgeu	a4,s1,128e <malloc+0xbe>
    11fe:	f04a                	sd	s2,32(sp)
    1200:	e852                	sd	s4,16(sp)
    1202:	e456                	sd	s5,8(sp)
    1204:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
    1206:	8a4e                	mv	s4,s3
    1208:	0009871b          	sext.w	a4,s3
    120c:	6685                	lui	a3,0x1
    120e:	00d77363          	bgeu	a4,a3,1214 <malloc+0x44>
    1212:	6a05                	lui	s4,0x1
    1214:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
    1218:	004a1a1b          	sllw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    121c:	00001917          	auipc	s2,0x1
    1220:	df490913          	add	s2,s2,-524 # 2010 <freep>
  if(p == SBRK_ERROR)
    1224:	5afd                	li	s5,-1
    1226:	a081                	j	1266 <malloc+0x96>
    1228:	f04a                	sd	s2,32(sp)
    122a:	e852                	sd	s4,16(sp)
    122c:	e456                	sd	s5,8(sp)
    122e:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
    1230:	00001797          	auipc	a5,0x1
    1234:	1d878793          	add	a5,a5,472 # 2408 <base>
    1238:	00001717          	auipc	a4,0x1
    123c:	dcf73c23          	sd	a5,-552(a4) # 2010 <freep>
    1240:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
    1242:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
    1246:	b7c1                	j	1206 <malloc+0x36>
        prevp->s.ptr = p->s.ptr;
    1248:	6398                	ld	a4,0(a5)
    124a:	e118                	sd	a4,0(a0)
    124c:	a8a9                	j	12a6 <malloc+0xd6>
  hp->s.size = nu;
    124e:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
    1252:	0541                	add	a0,a0,16
    1254:	efbff0ef          	jal	114e <free>
  return freep;
    1258:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
    125c:	c12d                	beqz	a0,12be <malloc+0xee>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    125e:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    1260:	4798                	lw	a4,8(a5)
    1262:	02977263          	bgeu	a4,s1,1286 <malloc+0xb6>
    if(p == freep)
    1266:	00093703          	ld	a4,0(s2)
    126a:	853e                	mv	a0,a5
    126c:	fef719e3          	bne	a4,a5,125e <malloc+0x8e>
  p = sbrk(nu * sizeof(Header));
    1270:	8552                	mv	a0,s4
    1272:	967ff0ef          	jal	bd8 <sbrk>
  if(p == SBRK_ERROR)
    1276:	fd551ce3          	bne	a0,s5,124e <malloc+0x7e>
        return 0;
    127a:	4501                	li	a0,0
    127c:	7902                	ld	s2,32(sp)
    127e:	6a42                	ld	s4,16(sp)
    1280:	6aa2                	ld	s5,8(sp)
    1282:	6b02                	ld	s6,0(sp)
    1284:	a03d                	j	12b2 <malloc+0xe2>
    1286:	7902                	ld	s2,32(sp)
    1288:	6a42                	ld	s4,16(sp)
    128a:	6aa2                	ld	s5,8(sp)
    128c:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
    128e:	fae48de3          	beq	s1,a4,1248 <malloc+0x78>
        p->s.size -= nunits;
    1292:	4137073b          	subw	a4,a4,s3
    1296:	c798                	sw	a4,8(a5)
        p += p->s.size;
    1298:	02071693          	sll	a3,a4,0x20
    129c:	01c6d713          	srl	a4,a3,0x1c
    12a0:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
    12a2:	0137a423          	sw	s3,8(a5)
      freep = prevp;
    12a6:	00001717          	auipc	a4,0x1
    12aa:	d6a73523          	sd	a0,-662(a4) # 2010 <freep>
      return (void*)(p + 1);
    12ae:	01078513          	add	a0,a5,16
  }
}
    12b2:	70e2                	ld	ra,56(sp)
    12b4:	7442                	ld	s0,48(sp)
    12b6:	74a2                	ld	s1,40(sp)
    12b8:	69e2                	ld	s3,24(sp)
    12ba:	6121                	add	sp,sp,64
    12bc:	8082                	ret
    12be:	7902                	ld	s2,32(sp)
    12c0:	6a42                	ld	s4,16(sp)
    12c2:	6aa2                	ld	s5,8(sp)
    12c4:	6b02                	ld	s6,0(sp)
    12c6:	b7f5                	j	12b2 <malloc+0xe2>
