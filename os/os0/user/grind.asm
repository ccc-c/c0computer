
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
      74:	7119                	add	sp,sp,-128
      76:	fc86                	sd	ra,120(sp)
      78:	f8a2                	sd	s0,112(sp)
      7a:	f4a6                	sd	s1,104(sp)
      7c:	f0ca                	sd	s2,96(sp)
      7e:	ecce                	sd	s3,88(sp)
      80:	e8d2                	sd	s4,80(sp)
      82:	e4d6                	sd	s5,72(sp)
      84:	e0da                	sd	s6,64(sp)
      86:	fc5e                	sd	s7,56(sp)
      88:	0100                	add	s0,sp,128
      8a:	84aa                	mv	s1,a0
  int fd = -1;
  static char buf[999];
  char *break0 = sbrk(0);
      8c:	4501                	li	a0,0
      8e:	5b5000ef          	jal	e42 <sbrk>
      92:	8aaa                	mv	s5,a0
  uint64 iters = 0;

  mkdir("grindir");
      94:	00001517          	auipc	a0,0x1
      98:	32c50513          	add	a0,a0,812 # 13c0 <malloc+0xe8>
      9c:	587000ef          	jal	e22 <mkdir>
  if(chdir("grindir") != 0){
      a0:	00001517          	auipc	a0,0x1
      a4:	32050513          	add	a0,a0,800 # 13c0 <malloc+0xe8>
      a8:	583000ef          	jal	e2a <chdir>
      ac:	c911                	beqz	a0,c0 <go+0x4c>
    printf("grind: chdir grindir failed\n");
      ae:	00001517          	auipc	a0,0x1
      b2:	31a50513          	add	a0,a0,794 # 13c8 <malloc+0xf0>
      b6:	16e010ef          	jal	1224 <printf>
    exit(1);
      ba:	4505                	li	a0,1
      bc:	4ff000ef          	jal	dba <exit>
  }
  chdir("/");
      c0:	00001517          	auipc	a0,0x1
      c4:	32850513          	add	a0,a0,808 # 13e8 <malloc+0x110>
      c8:	563000ef          	jal	e2a <chdir>
      cc:	00001997          	auipc	s3,0x1
      d0:	32c98993          	add	s3,s3,812 # 13f8 <malloc+0x120>
      d4:	c489                	beqz	s1,de <go+0x6a>
      d6:	00001997          	auipc	s3,0x1
      da:	31a98993          	add	s3,s3,794 # 13f0 <malloc+0x118>
  uint64 iters = 0;
      de:	4481                	li	s1,0
  int fd = -1;
      e0:	5a7d                	li	s4,-1
      e2:	00001917          	auipc	s2,0x1
      e6:	5c690913          	add	s2,s2,1478 # 16a8 <malloc+0x3d0>
      ea:	a819                	j	100 <go+0x8c>
    iters++;
    if((iters % 500) == 0)
      write(1, which_child?"B":"A", 1);
    int what = rand() % 23;
    if(what == 1){
      close(open("grindir/../a", O_CREATE|O_RDWR));
      ec:	20200593          	li	a1,514
      f0:	00001517          	auipc	a0,0x1
      f4:	31050513          	add	a0,a0,784 # 1400 <malloc+0x128>
      f8:	503000ef          	jal	dfa <open>
      fc:	4e7000ef          	jal	de2 <close>
    iters++;
     100:	0485                	add	s1,s1,1
    if((iters % 500) == 0)
     102:	1f400793          	li	a5,500
     106:	02f4f7b3          	remu	a5,s1,a5
     10a:	e791                	bnez	a5,116 <go+0xa2>
      write(1, which_child?"B":"A", 1);
     10c:	4605                	li	a2,1
     10e:	85ce                	mv	a1,s3
     110:	4505                	li	a0,1
     112:	4c9000ef          	jal	dda <write>
    int what = rand() % 23;
     116:	f43ff0ef          	jal	58 <rand>
     11a:	47dd                	li	a5,23
     11c:	02f5653b          	remw	a0,a0,a5
    if(what == 1){
     120:	4785                	li	a5,1
     122:	fcf505e3          	beq	a0,a5,ec <go+0x78>
    } else if(what == 2){
     126:	47d9                	li	a5,22
     128:	fca7ece3          	bltu	a5,a0,100 <go+0x8c>
     12c:	050a                	sll	a0,a0,0x2
     12e:	954a                	add	a0,a0,s2
     130:	411c                	lw	a5,0(a0)
     132:	97ca                	add	a5,a5,s2
     134:	8782                	jr	a5
      close(open("grindir/../grindir/../b", O_CREATE|O_RDWR));
     136:	20200593          	li	a1,514
     13a:	00001517          	auipc	a0,0x1
     13e:	2d650513          	add	a0,a0,726 # 1410 <malloc+0x138>
     142:	4b9000ef          	jal	dfa <open>
     146:	49d000ef          	jal	de2 <close>
     14a:	bf5d                	j	100 <go+0x8c>
    } else if(what == 3){
      unlink("grindir/../a");
     14c:	00001517          	auipc	a0,0x1
     150:	2b450513          	add	a0,a0,692 # 1400 <malloc+0x128>
     154:	4b7000ef          	jal	e0a <unlink>
     158:	b765                	j	100 <go+0x8c>
    } else if(what == 4){
      if(chdir("grindir") != 0){
     15a:	00001517          	auipc	a0,0x1
     15e:	26650513          	add	a0,a0,614 # 13c0 <malloc+0xe8>
     162:	4c9000ef          	jal	e2a <chdir>
     166:	ed11                	bnez	a0,182 <go+0x10e>
        printf("grind: chdir grindir failed\n");
        exit(1);
      }
      unlink("../b");
     168:	00001517          	auipc	a0,0x1
     16c:	2c050513          	add	a0,a0,704 # 1428 <malloc+0x150>
     170:	49b000ef          	jal	e0a <unlink>
      chdir("/");
     174:	00001517          	auipc	a0,0x1
     178:	27450513          	add	a0,a0,628 # 13e8 <malloc+0x110>
     17c:	4af000ef          	jal	e2a <chdir>
     180:	b741                	j	100 <go+0x8c>
        printf("grind: chdir grindir failed\n");
     182:	00001517          	auipc	a0,0x1
     186:	24650513          	add	a0,a0,582 # 13c8 <malloc+0xf0>
     18a:	09a010ef          	jal	1224 <printf>
        exit(1);
     18e:	4505                	li	a0,1
     190:	42b000ef          	jal	dba <exit>
    } else if(what == 5){
      close(fd);
     194:	8552                	mv	a0,s4
     196:	44d000ef          	jal	de2 <close>
      fd = open("/grindir/../a", O_CREATE|O_RDWR);
     19a:	20200593          	li	a1,514
     19e:	00001517          	auipc	a0,0x1
     1a2:	29250513          	add	a0,a0,658 # 1430 <malloc+0x158>
     1a6:	455000ef          	jal	dfa <open>
     1aa:	8a2a                	mv	s4,a0
     1ac:	bf91                	j	100 <go+0x8c>
    } else if(what == 6){
      close(fd);
     1ae:	8552                	mv	a0,s4
     1b0:	433000ef          	jal	de2 <close>
      fd = open("/./grindir/./../b", O_CREATE|O_RDWR);
     1b4:	20200593          	li	a1,514
     1b8:	00001517          	auipc	a0,0x1
     1bc:	28850513          	add	a0,a0,648 # 1440 <malloc+0x168>
     1c0:	43b000ef          	jal	dfa <open>
     1c4:	8a2a                	mv	s4,a0
     1c6:	bf2d                	j	100 <go+0x8c>
    } else if(what == 7){
      write(fd, buf, sizeof(buf));
     1c8:	3e700613          	li	a2,999
     1cc:	00002597          	auipc	a1,0x2
     1d0:	e5458593          	add	a1,a1,-428 # 2020 <buf.0>
     1d4:	8552                	mv	a0,s4
     1d6:	405000ef          	jal	dda <write>
     1da:	b71d                	j	100 <go+0x8c>
    } else if(what == 8){
      read(fd, buf, sizeof(buf));
     1dc:	3e700613          	li	a2,999
     1e0:	00002597          	auipc	a1,0x2
     1e4:	e4058593          	add	a1,a1,-448 # 2020 <buf.0>
     1e8:	8552                	mv	a0,s4
     1ea:	3e9000ef          	jal	dd2 <read>
     1ee:	bf09                	j	100 <go+0x8c>
    } else if(what == 9){
      mkdir("grindir/../a");
     1f0:	00001517          	auipc	a0,0x1
     1f4:	21050513          	add	a0,a0,528 # 1400 <malloc+0x128>
     1f8:	42b000ef          	jal	e22 <mkdir>
      close(open("a/../a/./a", O_CREATE|O_RDWR));
     1fc:	20200593          	li	a1,514
     200:	00001517          	auipc	a0,0x1
     204:	25850513          	add	a0,a0,600 # 1458 <malloc+0x180>
     208:	3f3000ef          	jal	dfa <open>
     20c:	3d7000ef          	jal	de2 <close>
      unlink("a/a");
     210:	00001517          	auipc	a0,0x1
     214:	25850513          	add	a0,a0,600 # 1468 <malloc+0x190>
     218:	3f3000ef          	jal	e0a <unlink>
     21c:	b5d5                	j	100 <go+0x8c>
    } else if(what == 10){
      mkdir("/../b");
     21e:	00001517          	auipc	a0,0x1
     222:	25250513          	add	a0,a0,594 # 1470 <malloc+0x198>
     226:	3fd000ef          	jal	e22 <mkdir>
      close(open("grindir/../b/b", O_CREATE|O_RDWR));
     22a:	20200593          	li	a1,514
     22e:	00001517          	auipc	a0,0x1
     232:	24a50513          	add	a0,a0,586 # 1478 <malloc+0x1a0>
     236:	3c5000ef          	jal	dfa <open>
     23a:	3a9000ef          	jal	de2 <close>
      unlink("b/b");
     23e:	00001517          	auipc	a0,0x1
     242:	24a50513          	add	a0,a0,586 # 1488 <malloc+0x1b0>
     246:	3c5000ef          	jal	e0a <unlink>
     24a:	bd5d                	j	100 <go+0x8c>
    } else if(what == 11){
      unlink("b");
     24c:	00001517          	auipc	a0,0x1
     250:	20450513          	add	a0,a0,516 # 1450 <malloc+0x178>
     254:	3b7000ef          	jal	e0a <unlink>
      link("../grindir/./../a", "../b");
     258:	00001597          	auipc	a1,0x1
     25c:	1d058593          	add	a1,a1,464 # 1428 <malloc+0x150>
     260:	00001517          	auipc	a0,0x1
     264:	23050513          	add	a0,a0,560 # 1490 <malloc+0x1b8>
     268:	3b3000ef          	jal	e1a <link>
     26c:	bd51                	j	100 <go+0x8c>
    } else if(what == 12){
      unlink("../grindir/../a");
     26e:	00001517          	auipc	a0,0x1
     272:	23a50513          	add	a0,a0,570 # 14a8 <malloc+0x1d0>
     276:	395000ef          	jal	e0a <unlink>
      link(".././b", "/grindir/../a");
     27a:	00001597          	auipc	a1,0x1
     27e:	1b658593          	add	a1,a1,438 # 1430 <malloc+0x158>
     282:	00001517          	auipc	a0,0x1
     286:	23650513          	add	a0,a0,566 # 14b8 <malloc+0x1e0>
     28a:	391000ef          	jal	e1a <link>
     28e:	bd8d                	j	100 <go+0x8c>
    } else if(what == 13){
      int pid = fork();
     290:	323000ef          	jal	db2 <fork>
      if(pid == 0){
     294:	c519                	beqz	a0,2a2 <go+0x22e>
        exit(0);
      } else if(pid < 0){
     296:	00054863          	bltz	a0,2a6 <go+0x232>
        printf("grind: fork failed\n");
        exit(1);
      }
      wait(0);
     29a:	4501                	li	a0,0
     29c:	327000ef          	jal	dc2 <wait>
     2a0:	b585                	j	100 <go+0x8c>
        exit(0);
     2a2:	319000ef          	jal	dba <exit>
        printf("grind: fork failed\n");
     2a6:	00001517          	auipc	a0,0x1
     2aa:	21a50513          	add	a0,a0,538 # 14c0 <malloc+0x1e8>
     2ae:	777000ef          	jal	1224 <printf>
        exit(1);
     2b2:	4505                	li	a0,1
     2b4:	307000ef          	jal	dba <exit>
    } else if(what == 14){
      int pid = fork();
     2b8:	2fb000ef          	jal	db2 <fork>
      if(pid == 0){
     2bc:	c519                	beqz	a0,2ca <go+0x256>
        fork();
        fork();
        exit(0);
      } else if(pid < 0){
     2be:	00054d63          	bltz	a0,2d8 <go+0x264>
        printf("grind: fork failed\n");
        exit(1);
      }
      wait(0);
     2c2:	4501                	li	a0,0
     2c4:	2ff000ef          	jal	dc2 <wait>
     2c8:	bd25                	j	100 <go+0x8c>
        fork();
     2ca:	2e9000ef          	jal	db2 <fork>
        fork();
     2ce:	2e5000ef          	jal	db2 <fork>
        exit(0);
     2d2:	4501                	li	a0,0
     2d4:	2e7000ef          	jal	dba <exit>
        printf("grind: fork failed\n");
     2d8:	00001517          	auipc	a0,0x1
     2dc:	1e850513          	add	a0,a0,488 # 14c0 <malloc+0x1e8>
     2e0:	745000ef          	jal	1224 <printf>
        exit(1);
     2e4:	4505                	li	a0,1
     2e6:	2d5000ef          	jal	dba <exit>
    } else if(what == 15){
      sbrk(6011);
     2ea:	6505                	lui	a0,0x1
     2ec:	77b50513          	add	a0,a0,1915 # 177b <digits+0x6b>
     2f0:	353000ef          	jal	e42 <sbrk>
     2f4:	b531                	j	100 <go+0x8c>
    } else if(what == 16){
      if(sbrk(0) > break0)
     2f6:	4501                	li	a0,0
     2f8:	34b000ef          	jal	e42 <sbrk>
     2fc:	e0aaf2e3          	bgeu	s5,a0,100 <go+0x8c>
        sbrk(-(sbrk(0) - break0));
     300:	4501                	li	a0,0
     302:	341000ef          	jal	e42 <sbrk>
     306:	40aa853b          	subw	a0,s5,a0
     30a:	339000ef          	jal	e42 <sbrk>
     30e:	bbcd                	j	100 <go+0x8c>
    } else if(what == 17){
      int pid = fork();
     310:	2a3000ef          	jal	db2 <fork>
     314:	8b2a                	mv	s6,a0
      if(pid == 0){
     316:	c10d                	beqz	a0,338 <go+0x2c4>
        close(open("a", O_CREATE|O_RDWR));
        exit(0);
      } else if(pid < 0){
     318:	02054d63          	bltz	a0,352 <go+0x2de>
        printf("grind: fork failed\n");
        exit(1);
      }
      if(chdir("../grindir/..") != 0){
     31c:	00001517          	auipc	a0,0x1
     320:	1bc50513          	add	a0,a0,444 # 14d8 <malloc+0x200>
     324:	307000ef          	jal	e2a <chdir>
     328:	ed15                	bnez	a0,364 <go+0x2f0>
        printf("grind: chdir failed\n");
        exit(1);
      }
      kill(pid);
     32a:	855a                	mv	a0,s6
     32c:	2bf000ef          	jal	dea <kill>
      wait(0);
     330:	4501                	li	a0,0
     332:	291000ef          	jal	dc2 <wait>
     336:	b3e9                	j	100 <go+0x8c>
        close(open("a", O_CREATE|O_RDWR));
     338:	20200593          	li	a1,514
     33c:	00001517          	auipc	a0,0x1
     340:	16450513          	add	a0,a0,356 # 14a0 <malloc+0x1c8>
     344:	2b7000ef          	jal	dfa <open>
     348:	29b000ef          	jal	de2 <close>
        exit(0);
     34c:	4501                	li	a0,0
     34e:	26d000ef          	jal	dba <exit>
        printf("grind: fork failed\n");
     352:	00001517          	auipc	a0,0x1
     356:	16e50513          	add	a0,a0,366 # 14c0 <malloc+0x1e8>
     35a:	6cb000ef          	jal	1224 <printf>
        exit(1);
     35e:	4505                	li	a0,1
     360:	25b000ef          	jal	dba <exit>
        printf("grind: chdir failed\n");
     364:	00001517          	auipc	a0,0x1
     368:	18450513          	add	a0,a0,388 # 14e8 <malloc+0x210>
     36c:	6b9000ef          	jal	1224 <printf>
        exit(1);
     370:	4505                	li	a0,1
     372:	249000ef          	jal	dba <exit>
    } else if(what == 18){
      int pid = fork();
     376:	23d000ef          	jal	db2 <fork>
      if(pid == 0){
     37a:	c519                	beqz	a0,388 <go+0x314>
        kill(getpid());
        exit(0);
      } else if(pid < 0){
     37c:	00054d63          	bltz	a0,396 <go+0x322>
        printf("grind: fork failed\n");
        exit(1);
      }
      wait(0);
     380:	4501                	li	a0,0
     382:	241000ef          	jal	dc2 <wait>
     386:	bbad                	j	100 <go+0x8c>
        kill(getpid());
     388:	2b3000ef          	jal	e3a <getpid>
     38c:	25f000ef          	jal	dea <kill>
        exit(0);
     390:	4501                	li	a0,0
     392:	229000ef          	jal	dba <exit>
        printf("grind: fork failed\n");
     396:	00001517          	auipc	a0,0x1
     39a:	12a50513          	add	a0,a0,298 # 14c0 <malloc+0x1e8>
     39e:	687000ef          	jal	1224 <printf>
        exit(1);
     3a2:	4505                	li	a0,1
     3a4:	217000ef          	jal	dba <exit>
    } else if(what == 19){
      int fds[2];
      if(pipe(fds) < 0){
     3a8:	f9840513          	add	a0,s0,-104
     3ac:	21f000ef          	jal	dca <pipe>
     3b0:	02054363          	bltz	a0,3d6 <go+0x362>
        printf("grind: pipe failed\n");
        exit(1);
      }
      int pid = fork();
     3b4:	1ff000ef          	jal	db2 <fork>
      if(pid == 0){
     3b8:	c905                	beqz	a0,3e8 <go+0x374>
          printf("grind: pipe write failed\n");
        char c;
        if(read(fds[0], &c, 1) != 1)
          printf("grind: pipe read failed\n");
        exit(0);
      } else if(pid < 0){
     3ba:	08054263          	bltz	a0,43e <go+0x3ca>
        printf("grind: fork failed\n");
        exit(1);
      }
      close(fds[0]);
     3be:	f9842503          	lw	a0,-104(s0)
     3c2:	221000ef          	jal	de2 <close>
      close(fds[1]);
     3c6:	f9c42503          	lw	a0,-100(s0)
     3ca:	219000ef          	jal	de2 <close>
      wait(0);
     3ce:	4501                	li	a0,0
     3d0:	1f3000ef          	jal	dc2 <wait>
     3d4:	b335                	j	100 <go+0x8c>
        printf("grind: pipe failed\n");
     3d6:	00001517          	auipc	a0,0x1
     3da:	12a50513          	add	a0,a0,298 # 1500 <malloc+0x228>
     3de:	647000ef          	jal	1224 <printf>
        exit(1);
     3e2:	4505                	li	a0,1
     3e4:	1d7000ef          	jal	dba <exit>
        fork();
     3e8:	1cb000ef          	jal	db2 <fork>
        fork();
     3ec:	1c7000ef          	jal	db2 <fork>
        if(write(fds[1], "x", 1) != 1)
     3f0:	4605                	li	a2,1
     3f2:	00001597          	auipc	a1,0x1
     3f6:	12658593          	add	a1,a1,294 # 1518 <malloc+0x240>
     3fa:	f9c42503          	lw	a0,-100(s0)
     3fe:	1dd000ef          	jal	dda <write>
     402:	4785                	li	a5,1
     404:	00f51f63          	bne	a0,a5,422 <go+0x3ae>
        if(read(fds[0], &c, 1) != 1)
     408:	4605                	li	a2,1
     40a:	f9040593          	add	a1,s0,-112
     40e:	f9842503          	lw	a0,-104(s0)
     412:	1c1000ef          	jal	dd2 <read>
     416:	4785                	li	a5,1
     418:	00f51c63          	bne	a0,a5,430 <go+0x3bc>
        exit(0);
     41c:	4501                	li	a0,0
     41e:	19d000ef          	jal	dba <exit>
          printf("grind: pipe write failed\n");
     422:	00001517          	auipc	a0,0x1
     426:	0fe50513          	add	a0,a0,254 # 1520 <malloc+0x248>
     42a:	5fb000ef          	jal	1224 <printf>
     42e:	bfe9                	j	408 <go+0x394>
          printf("grind: pipe read failed\n");
     430:	00001517          	auipc	a0,0x1
     434:	11050513          	add	a0,a0,272 # 1540 <malloc+0x268>
     438:	5ed000ef          	jal	1224 <printf>
     43c:	b7c5                	j	41c <go+0x3a8>
        printf("grind: fork failed\n");
     43e:	00001517          	auipc	a0,0x1
     442:	08250513          	add	a0,a0,130 # 14c0 <malloc+0x1e8>
     446:	5df000ef          	jal	1224 <printf>
        exit(1);
     44a:	4505                	li	a0,1
     44c:	16f000ef          	jal	dba <exit>
    } else if(what == 20){
      int pid = fork();
     450:	163000ef          	jal	db2 <fork>
      if(pid == 0){
     454:	c519                	beqz	a0,462 <go+0x3ee>
        chdir("a");
        unlink("../a");
        fd = open("x", O_CREATE|O_RDWR);
        unlink("x");
        exit(0);
      } else if(pid < 0){
     456:	04054f63          	bltz	a0,4b4 <go+0x440>
        printf("grind: fork failed\n");
        exit(1);
      }
      wait(0);
     45a:	4501                	li	a0,0
     45c:	167000ef          	jal	dc2 <wait>
     460:	b145                	j	100 <go+0x8c>
        unlink("a");
     462:	00001517          	auipc	a0,0x1
     466:	03e50513          	add	a0,a0,62 # 14a0 <malloc+0x1c8>
     46a:	1a1000ef          	jal	e0a <unlink>
        mkdir("a");
     46e:	00001517          	auipc	a0,0x1
     472:	03250513          	add	a0,a0,50 # 14a0 <malloc+0x1c8>
     476:	1ad000ef          	jal	e22 <mkdir>
        chdir("a");
     47a:	00001517          	auipc	a0,0x1
     47e:	02650513          	add	a0,a0,38 # 14a0 <malloc+0x1c8>
     482:	1a9000ef          	jal	e2a <chdir>
        unlink("../a");
     486:	00001517          	auipc	a0,0x1
     48a:	f8250513          	add	a0,a0,-126 # 1408 <malloc+0x130>
     48e:	17d000ef          	jal	e0a <unlink>
        fd = open("x", O_CREATE|O_RDWR);
     492:	20200593          	li	a1,514
     496:	00001517          	auipc	a0,0x1
     49a:	08250513          	add	a0,a0,130 # 1518 <malloc+0x240>
     49e:	15d000ef          	jal	dfa <open>
        unlink("x");
     4a2:	00001517          	auipc	a0,0x1
     4a6:	07650513          	add	a0,a0,118 # 1518 <malloc+0x240>
     4aa:	161000ef          	jal	e0a <unlink>
        exit(0);
     4ae:	4501                	li	a0,0
     4b0:	10b000ef          	jal	dba <exit>
        printf("grind: fork failed\n");
     4b4:	00001517          	auipc	a0,0x1
     4b8:	00c50513          	add	a0,a0,12 # 14c0 <malloc+0x1e8>
     4bc:	569000ef          	jal	1224 <printf>
        exit(1);
     4c0:	4505                	li	a0,1
     4c2:	0f9000ef          	jal	dba <exit>
    } else if(what == 21){
      unlink("c");
     4c6:	00001517          	auipc	a0,0x1
     4ca:	09a50513          	add	a0,a0,154 # 1560 <malloc+0x288>
     4ce:	13d000ef          	jal	e0a <unlink>
      // should always succeed. check that there are free i-nodes,
      // file descriptors, blocks.
      int fd1 = open("c", O_CREATE|O_RDWR);
     4d2:	20200593          	li	a1,514
     4d6:	00001517          	auipc	a0,0x1
     4da:	08a50513          	add	a0,a0,138 # 1560 <malloc+0x288>
     4de:	11d000ef          	jal	dfa <open>
     4e2:	8b2a                	mv	s6,a0
      if(fd1 < 0){
     4e4:	04054763          	bltz	a0,532 <go+0x4be>
        printf("grind: create c failed\n");
        exit(1);
      }
      if(write(fd1, "x", 1) != 1){
     4e8:	4605                	li	a2,1
     4ea:	00001597          	auipc	a1,0x1
     4ee:	02e58593          	add	a1,a1,46 # 1518 <malloc+0x240>
     4f2:	0e9000ef          	jal	dda <write>
     4f6:	4785                	li	a5,1
     4f8:	04f51663          	bne	a0,a5,544 <go+0x4d0>
        printf("grind: write c failed\n");
        exit(1);
      }
      struct stat st;
      if(fstat(fd1, &st) != 0){
     4fc:	f9840593          	add	a1,s0,-104
     500:	855a                	mv	a0,s6
     502:	111000ef          	jal	e12 <fstat>
     506:	e921                	bnez	a0,556 <go+0x4e2>
        printf("grind: fstat failed\n");
        exit(1);
      }
      if(st.size != 1){
     508:	fa843583          	ld	a1,-88(s0)
     50c:	4785                	li	a5,1
     50e:	04f59d63          	bne	a1,a5,568 <go+0x4f4>
        printf("grind: fstat reports wrong size %d\n", (int)st.size);
        exit(1);
      }
      if(st.ino > 200){
     512:	f9c42583          	lw	a1,-100(s0)
     516:	0c800793          	li	a5,200
     51a:	06b7e163          	bltu	a5,a1,57c <go+0x508>
        printf("grind: fstat reports crazy i-number %d\n", st.ino);
        exit(1);
      }
      close(fd1);
     51e:	855a                	mv	a0,s6
     520:	0c3000ef          	jal	de2 <close>
      unlink("c");
     524:	00001517          	auipc	a0,0x1
     528:	03c50513          	add	a0,a0,60 # 1560 <malloc+0x288>
     52c:	0df000ef          	jal	e0a <unlink>
     530:	bec1                	j	100 <go+0x8c>
        printf("grind: create c failed\n");
     532:	00001517          	auipc	a0,0x1
     536:	03650513          	add	a0,a0,54 # 1568 <malloc+0x290>
     53a:	4eb000ef          	jal	1224 <printf>
        exit(1);
     53e:	4505                	li	a0,1
     540:	07b000ef          	jal	dba <exit>
        printf("grind: write c failed\n");
     544:	00001517          	auipc	a0,0x1
     548:	03c50513          	add	a0,a0,60 # 1580 <malloc+0x2a8>
     54c:	4d9000ef          	jal	1224 <printf>
        exit(1);
     550:	4505                	li	a0,1
     552:	069000ef          	jal	dba <exit>
        printf("grind: fstat failed\n");
     556:	00001517          	auipc	a0,0x1
     55a:	04250513          	add	a0,a0,66 # 1598 <malloc+0x2c0>
     55e:	4c7000ef          	jal	1224 <printf>
        exit(1);
     562:	4505                	li	a0,1
     564:	057000ef          	jal	dba <exit>
        printf("grind: fstat reports wrong size %d\n", (int)st.size);
     568:	2581                	sext.w	a1,a1
     56a:	00001517          	auipc	a0,0x1
     56e:	04650513          	add	a0,a0,70 # 15b0 <malloc+0x2d8>
     572:	4b3000ef          	jal	1224 <printf>
        exit(1);
     576:	4505                	li	a0,1
     578:	043000ef          	jal	dba <exit>
        printf("grind: fstat reports crazy i-number %d\n", st.ino);
     57c:	00001517          	auipc	a0,0x1
     580:	05c50513          	add	a0,a0,92 # 15d8 <malloc+0x300>
     584:	4a1000ef          	jal	1224 <printf>
        exit(1);
     588:	4505                	li	a0,1
     58a:	031000ef          	jal	dba <exit>
    } else if(what == 22){
      // echo hi | cat
      int aa[2], bb[2];
      if(pipe(aa) < 0){
     58e:	f8840513          	add	a0,s0,-120
     592:	039000ef          	jal	dca <pipe>
     596:	0a054563          	bltz	a0,640 <go+0x5cc>
        fprintf(2, "grind: pipe failed\n");
        exit(1);
      }
      if(pipe(bb) < 0){
     59a:	f9040513          	add	a0,s0,-112
     59e:	02d000ef          	jal	dca <pipe>
     5a2:	0a054963          	bltz	a0,654 <go+0x5e0>
        fprintf(2, "grind: pipe failed\n");
        exit(1);
      }
      int pid1 = fork();
     5a6:	00d000ef          	jal	db2 <fork>
      if(pid1 == 0){
     5aa:	cd5d                	beqz	a0,668 <go+0x5f4>
        close(aa[1]);
        char *args[3] = { "echo", "hi", 0 };
        exec("grindir/../echo", args);
        fprintf(2, "grind: echo: not found\n");
        exit(2);
      } else if(pid1 < 0){
     5ac:	14054263          	bltz	a0,6f0 <go+0x67c>
        fprintf(2, "grind: fork failed\n");
        exit(3);
      }
      int pid2 = fork();
     5b0:	003000ef          	jal	db2 <fork>
      if(pid2 == 0){
     5b4:	14050863          	beqz	a0,704 <go+0x690>
        close(bb[1]);
        char *args[2] = { "cat", 0 };
        exec("/cat", args);
        fprintf(2, "grind: cat: not found\n");
        exit(6);
      } else if(pid2 < 0){
     5b8:	1e054663          	bltz	a0,7a4 <go+0x730>
        fprintf(2, "grind: fork failed\n");
        exit(7);
      }
      close(aa[0]);
     5bc:	f8842503          	lw	a0,-120(s0)
     5c0:	023000ef          	jal	de2 <close>
      close(aa[1]);
     5c4:	f8c42503          	lw	a0,-116(s0)
     5c8:	01b000ef          	jal	de2 <close>
      close(bb[1]);
     5cc:	f9442503          	lw	a0,-108(s0)
     5d0:	013000ef          	jal	de2 <close>
      char buf[4] = { 0, 0, 0, 0 };
     5d4:	f8042023          	sw	zero,-128(s0)
      read(bb[0], buf+0, 1);
     5d8:	4605                	li	a2,1
     5da:	f8040593          	add	a1,s0,-128
     5de:	f9042503          	lw	a0,-112(s0)
     5e2:	7f0000ef          	jal	dd2 <read>
      read(bb[0], buf+1, 1);
     5e6:	4605                	li	a2,1
     5e8:	f8140593          	add	a1,s0,-127
     5ec:	f9042503          	lw	a0,-112(s0)
     5f0:	7e2000ef          	jal	dd2 <read>
      read(bb[0], buf+2, 1);
     5f4:	4605                	li	a2,1
     5f6:	f8240593          	add	a1,s0,-126
     5fa:	f9042503          	lw	a0,-112(s0)
     5fe:	7d4000ef          	jal	dd2 <read>
      close(bb[0]);
     602:	f9042503          	lw	a0,-112(s0)
     606:	7dc000ef          	jal	de2 <close>
      int st1, st2;
      wait(&st1);
     60a:	f8440513          	add	a0,s0,-124
     60e:	7b4000ef          	jal	dc2 <wait>
      wait(&st2);
     612:	f9840513          	add	a0,s0,-104
     616:	7ac000ef          	jal	dc2 <wait>
      if(st1 != 0 || st2 != 0 || strcmp(buf, "hi\n") != 0){
     61a:	f8442783          	lw	a5,-124(s0)
     61e:	f9842b83          	lw	s7,-104(s0)
     622:	0177eb33          	or	s6,a5,s7
     626:	180b1963          	bnez	s6,7b8 <go+0x744>
     62a:	00001597          	auipc	a1,0x1
     62e:	04e58593          	add	a1,a1,78 # 1678 <malloc+0x3a0>
     632:	f8040513          	add	a0,s0,-128
     636:	2c8000ef          	jal	8fe <strcmp>
     63a:	ac0503e3          	beqz	a0,100 <go+0x8c>
     63e:	aab5                	j	7ba <go+0x746>
        fprintf(2, "grind: pipe failed\n");
     640:	00001597          	auipc	a1,0x1
     644:	ec058593          	add	a1,a1,-320 # 1500 <malloc+0x228>
     648:	4509                	li	a0,2
     64a:	3b1000ef          	jal	11fa <fprintf>
        exit(1);
     64e:	4505                	li	a0,1
     650:	76a000ef          	jal	dba <exit>
        fprintf(2, "grind: pipe failed\n");
     654:	00001597          	auipc	a1,0x1
     658:	eac58593          	add	a1,a1,-340 # 1500 <malloc+0x228>
     65c:	4509                	li	a0,2
     65e:	39d000ef          	jal	11fa <fprintf>
        exit(1);
     662:	4505                	li	a0,1
     664:	756000ef          	jal	dba <exit>
        close(bb[0]);
     668:	f9042503          	lw	a0,-112(s0)
     66c:	776000ef          	jal	de2 <close>
        close(bb[1]);
     670:	f9442503          	lw	a0,-108(s0)
     674:	76e000ef          	jal	de2 <close>
        close(aa[0]);
     678:	f8842503          	lw	a0,-120(s0)
     67c:	766000ef          	jal	de2 <close>
        close(1);
     680:	4505                	li	a0,1
     682:	760000ef          	jal	de2 <close>
        if(dup(aa[1]) != 1){
     686:	f8c42503          	lw	a0,-116(s0)
     68a:	7a8000ef          	jal	e32 <dup>
     68e:	4785                	li	a5,1
     690:	00f50c63          	beq	a0,a5,6a8 <go+0x634>
          fprintf(2, "grind: dup failed\n");
     694:	00001597          	auipc	a1,0x1
     698:	f6c58593          	add	a1,a1,-148 # 1600 <malloc+0x328>
     69c:	4509                	li	a0,2
     69e:	35d000ef          	jal	11fa <fprintf>
          exit(1);
     6a2:	4505                	li	a0,1
     6a4:	716000ef          	jal	dba <exit>
        close(aa[1]);
     6a8:	f8c42503          	lw	a0,-116(s0)
     6ac:	736000ef          	jal	de2 <close>
        char *args[3] = { "echo", "hi", 0 };
     6b0:	00001797          	auipc	a5,0x1
     6b4:	f6878793          	add	a5,a5,-152 # 1618 <malloc+0x340>
     6b8:	f8f43c23          	sd	a5,-104(s0)
     6bc:	00001797          	auipc	a5,0x1
     6c0:	f6478793          	add	a5,a5,-156 # 1620 <malloc+0x348>
     6c4:	faf43023          	sd	a5,-96(s0)
     6c8:	fa043423          	sd	zero,-88(s0)
        exec("grindir/../echo", args);
     6cc:	f9840593          	add	a1,s0,-104
     6d0:	00001517          	auipc	a0,0x1
     6d4:	f5850513          	add	a0,a0,-168 # 1628 <malloc+0x350>
     6d8:	71a000ef          	jal	df2 <exec>
        fprintf(2, "grind: echo: not found\n");
     6dc:	00001597          	auipc	a1,0x1
     6e0:	f5c58593          	add	a1,a1,-164 # 1638 <malloc+0x360>
     6e4:	4509                	li	a0,2
     6e6:	315000ef          	jal	11fa <fprintf>
        exit(2);
     6ea:	4509                	li	a0,2
     6ec:	6ce000ef          	jal	dba <exit>
        fprintf(2, "grind: fork failed\n");
     6f0:	00001597          	auipc	a1,0x1
     6f4:	dd058593          	add	a1,a1,-560 # 14c0 <malloc+0x1e8>
     6f8:	4509                	li	a0,2
     6fa:	301000ef          	jal	11fa <fprintf>
        exit(3);
     6fe:	450d                	li	a0,3
     700:	6ba000ef          	jal	dba <exit>
        close(aa[1]);
     704:	f8c42503          	lw	a0,-116(s0)
     708:	6da000ef          	jal	de2 <close>
        close(bb[0]);
     70c:	f9042503          	lw	a0,-112(s0)
     710:	6d2000ef          	jal	de2 <close>
        close(0);
     714:	4501                	li	a0,0
     716:	6cc000ef          	jal	de2 <close>
        if(dup(aa[0]) != 0){
     71a:	f8842503          	lw	a0,-120(s0)
     71e:	714000ef          	jal	e32 <dup>
     722:	c919                	beqz	a0,738 <go+0x6c4>
          fprintf(2, "grind: dup failed\n");
     724:	00001597          	auipc	a1,0x1
     728:	edc58593          	add	a1,a1,-292 # 1600 <malloc+0x328>
     72c:	4509                	li	a0,2
     72e:	2cd000ef          	jal	11fa <fprintf>
          exit(4);
     732:	4511                	li	a0,4
     734:	686000ef          	jal	dba <exit>
        close(aa[0]);
     738:	f8842503          	lw	a0,-120(s0)
     73c:	6a6000ef          	jal	de2 <close>
        close(1);
     740:	4505                	li	a0,1
     742:	6a0000ef          	jal	de2 <close>
        if(dup(bb[1]) != 1){
     746:	f9442503          	lw	a0,-108(s0)
     74a:	6e8000ef          	jal	e32 <dup>
     74e:	4785                	li	a5,1
     750:	00f50c63          	beq	a0,a5,768 <go+0x6f4>
          fprintf(2, "grind: dup failed\n");
     754:	00001597          	auipc	a1,0x1
     758:	eac58593          	add	a1,a1,-340 # 1600 <malloc+0x328>
     75c:	4509                	li	a0,2
     75e:	29d000ef          	jal	11fa <fprintf>
          exit(5);
     762:	4515                	li	a0,5
     764:	656000ef          	jal	dba <exit>
        close(bb[1]);
     768:	f9442503          	lw	a0,-108(s0)
     76c:	676000ef          	jal	de2 <close>
        char *args[2] = { "cat", 0 };
     770:	00001797          	auipc	a5,0x1
     774:	ee078793          	add	a5,a5,-288 # 1650 <malloc+0x378>
     778:	f8f43c23          	sd	a5,-104(s0)
     77c:	fa043023          	sd	zero,-96(s0)
        exec("/cat", args);
     780:	f9840593          	add	a1,s0,-104
     784:	00001517          	auipc	a0,0x1
     788:	ed450513          	add	a0,a0,-300 # 1658 <malloc+0x380>
     78c:	666000ef          	jal	df2 <exec>
        fprintf(2, "grind: cat: not found\n");
     790:	00001597          	auipc	a1,0x1
     794:	ed058593          	add	a1,a1,-304 # 1660 <malloc+0x388>
     798:	4509                	li	a0,2
     79a:	261000ef          	jal	11fa <fprintf>
        exit(6);
     79e:	4519                	li	a0,6
     7a0:	61a000ef          	jal	dba <exit>
        fprintf(2, "grind: fork failed\n");
     7a4:	00001597          	auipc	a1,0x1
     7a8:	d1c58593          	add	a1,a1,-740 # 14c0 <malloc+0x1e8>
     7ac:	4509                	li	a0,2
     7ae:	24d000ef          	jal	11fa <fprintf>
        exit(7);
     7b2:	451d                	li	a0,7
     7b4:	606000ef          	jal	dba <exit>
      if(st1 != 0 || st2 != 0 || strcmp(buf, "hi\n") != 0){
     7b8:	8b3e                	mv	s6,a5
        printf("grind: exec pipeline failed %d %d \"%s\"\n", st1, st2, buf);
     7ba:	f8040693          	add	a3,s0,-128
     7be:	865e                	mv	a2,s7
     7c0:	85da                	mv	a1,s6
     7c2:	00001517          	auipc	a0,0x1
     7c6:	ebe50513          	add	a0,a0,-322 # 1680 <malloc+0x3a8>
     7ca:	25b000ef          	jal	1224 <printf>
        exit(1);
     7ce:	4505                	li	a0,1
     7d0:	5ea000ef          	jal	dba <exit>

00000000000007d4 <iter>:
  }
}

void
iter()
{
     7d4:	7179                	add	sp,sp,-48
     7d6:	f406                	sd	ra,40(sp)
     7d8:	f022                	sd	s0,32(sp)
     7da:	ec26                	sd	s1,24(sp)
     7dc:	e84a                	sd	s2,16(sp)
     7de:	1800                	add	s0,sp,48
  unlink("a");
     7e0:	00001517          	auipc	a0,0x1
     7e4:	cc050513          	add	a0,a0,-832 # 14a0 <malloc+0x1c8>
     7e8:	622000ef          	jal	e0a <unlink>
  unlink("b");
     7ec:	00001517          	auipc	a0,0x1
     7f0:	c6450513          	add	a0,a0,-924 # 1450 <malloc+0x178>
     7f4:	616000ef          	jal	e0a <unlink>
  
  int pid1 = fork();
     7f8:	5ba000ef          	jal	db2 <fork>
  if(pid1 < 0){
     7fc:	00054f63          	bltz	a0,81a <iter+0x46>
     800:	84aa                	mv	s1,a0
    printf("grind: fork failed\n");
    exit(1);
  }
  if(pid1 == 0){
     802:	e50d                	bnez	a0,82c <iter+0x58>
    rand_next ^= 31;
     804:	00001717          	auipc	a4,0x1
     808:	7fc70713          	add	a4,a4,2044 # 2000 <rand_next>
     80c:	631c                	ld	a5,0(a4)
     80e:	01f7c793          	xor	a5,a5,31
     812:	e31c                	sd	a5,0(a4)
    go(0);
     814:	4501                	li	a0,0
     816:	85fff0ef          	jal	74 <go>
    printf("grind: fork failed\n");
     81a:	00001517          	auipc	a0,0x1
     81e:	ca650513          	add	a0,a0,-858 # 14c0 <malloc+0x1e8>
     822:	203000ef          	jal	1224 <printf>
    exit(1);
     826:	4505                	li	a0,1
     828:	592000ef          	jal	dba <exit>
    exit(0);
  }

  int pid2 = fork();
     82c:	586000ef          	jal	db2 <fork>
     830:	892a                	mv	s2,a0
  if(pid2 < 0){
     832:	02054063          	bltz	a0,852 <iter+0x7e>
    printf("grind: fork failed\n");
    exit(1);
  }
  if(pid2 == 0){
     836:	e51d                	bnez	a0,864 <iter+0x90>
    rand_next ^= 7177;
     838:	00001697          	auipc	a3,0x1
     83c:	7c868693          	add	a3,a3,1992 # 2000 <rand_next>
     840:	629c                	ld	a5,0(a3)
     842:	6709                	lui	a4,0x2
     844:	c0970713          	add	a4,a4,-1015 # 1c09 <digits+0x4f9>
     848:	8fb9                	xor	a5,a5,a4
     84a:	e29c                	sd	a5,0(a3)
    go(1);
     84c:	4505                	li	a0,1
     84e:	827ff0ef          	jal	74 <go>
    printf("grind: fork failed\n");
     852:	00001517          	auipc	a0,0x1
     856:	c6e50513          	add	a0,a0,-914 # 14c0 <malloc+0x1e8>
     85a:	1cb000ef          	jal	1224 <printf>
    exit(1);
     85e:	4505                	li	a0,1
     860:	55a000ef          	jal	dba <exit>
    exit(0);
  }

  int st1 = -1;
     864:	57fd                	li	a5,-1
     866:	fcf42e23          	sw	a5,-36(s0)
  wait(&st1);
     86a:	fdc40513          	add	a0,s0,-36
     86e:	554000ef          	jal	dc2 <wait>
  if(st1 != 0){
     872:	fdc42783          	lw	a5,-36(s0)
     876:	eb99                	bnez	a5,88c <iter+0xb8>
    kill(pid1);
    kill(pid2);
  }
  int st2 = -1;
     878:	57fd                	li	a5,-1
     87a:	fcf42c23          	sw	a5,-40(s0)
  wait(&st2);
     87e:	fd840513          	add	a0,s0,-40
     882:	540000ef          	jal	dc2 <wait>

  exit(0);
     886:	4501                	li	a0,0
     888:	532000ef          	jal	dba <exit>
    kill(pid1);
     88c:	8526                	mv	a0,s1
     88e:	55c000ef          	jal	dea <kill>
    kill(pid2);
     892:	854a                	mv	a0,s2
     894:	556000ef          	jal	dea <kill>
     898:	b7c5                	j	878 <iter+0xa4>

000000000000089a <main>:
}

int
main()
{
     89a:	1101                	add	sp,sp,-32
     89c:	ec06                	sd	ra,24(sp)
     89e:	e822                	sd	s0,16(sp)
     8a0:	e426                	sd	s1,8(sp)
     8a2:	1000                	add	s0,sp,32
    }
    if(pid > 0){
      wait(0);
    }
    sleep(20);
    rand_next += 1;
     8a4:	00001497          	auipc	s1,0x1
     8a8:	75c48493          	add	s1,s1,1884 # 2000 <rand_next>
     8ac:	a809                	j	8be <main+0x24>
      iter();
     8ae:	f27ff0ef          	jal	7d4 <iter>
    sleep(20);
     8b2:	4551                	li	a0,20
     8b4:	596000ef          	jal	e4a <sleep>
    rand_next += 1;
     8b8:	609c                	ld	a5,0(s1)
     8ba:	0785                	add	a5,a5,1
     8bc:	e09c                	sd	a5,0(s1)
    int pid = fork();
     8be:	4f4000ef          	jal	db2 <fork>
    if(pid == 0){
     8c2:	d575                	beqz	a0,8ae <main+0x14>
    if(pid > 0){
     8c4:	fea057e3          	blez	a0,8b2 <main+0x18>
      wait(0);
     8c8:	4501                	li	a0,0
     8ca:	4f8000ef          	jal	dc2 <wait>
     8ce:	b7d5                	j	8b2 <main+0x18>

00000000000008d0 <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start()
{
     8d0:	1141                	add	sp,sp,-16
     8d2:	e406                	sd	ra,8(sp)
     8d4:	e022                	sd	s0,0(sp)
     8d6:	0800                	add	s0,sp,16
  extern int main();
  main();
     8d8:	fc3ff0ef          	jal	89a <main>
  exit(0);
     8dc:	4501                	li	a0,0
     8de:	4dc000ef          	jal	dba <exit>

00000000000008e2 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
     8e2:	1141                	add	sp,sp,-16
     8e4:	e422                	sd	s0,8(sp)
     8e6:	0800                	add	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
     8e8:	87aa                	mv	a5,a0
     8ea:	0585                	add	a1,a1,1
     8ec:	0785                	add	a5,a5,1
     8ee:	fff5c703          	lbu	a4,-1(a1)
     8f2:	fee78fa3          	sb	a4,-1(a5)
     8f6:	fb75                	bnez	a4,8ea <strcpy+0x8>
    ;
  return os;
}
     8f8:	6422                	ld	s0,8(sp)
     8fa:	0141                	add	sp,sp,16
     8fc:	8082                	ret

00000000000008fe <strcmp>:

int
strcmp(const char *p, const char *q)
{
     8fe:	1141                	add	sp,sp,-16
     900:	e422                	sd	s0,8(sp)
     902:	0800                	add	s0,sp,16
  while(*p && *p == *q)
     904:	00054783          	lbu	a5,0(a0)
     908:	cb91                	beqz	a5,91c <strcmp+0x1e>
     90a:	0005c703          	lbu	a4,0(a1)
     90e:	00f71763          	bne	a4,a5,91c <strcmp+0x1e>
    p++, q++;
     912:	0505                	add	a0,a0,1
     914:	0585                	add	a1,a1,1
  while(*p && *p == *q)
     916:	00054783          	lbu	a5,0(a0)
     91a:	fbe5                	bnez	a5,90a <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
     91c:	0005c503          	lbu	a0,0(a1)
}
     920:	40a7853b          	subw	a0,a5,a0
     924:	6422                	ld	s0,8(sp)
     926:	0141                	add	sp,sp,16
     928:	8082                	ret

000000000000092a <strlen>:

uint
strlen(const char *s)
{
     92a:	1141                	add	sp,sp,-16
     92c:	e422                	sd	s0,8(sp)
     92e:	0800                	add	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
     930:	00054783          	lbu	a5,0(a0)
     934:	cf91                	beqz	a5,950 <strlen+0x26>
     936:	0505                	add	a0,a0,1
     938:	87aa                	mv	a5,a0
     93a:	86be                	mv	a3,a5
     93c:	0785                	add	a5,a5,1
     93e:	fff7c703          	lbu	a4,-1(a5)
     942:	ff65                	bnez	a4,93a <strlen+0x10>
     944:	40a6853b          	subw	a0,a3,a0
     948:	2505                	addw	a0,a0,1
    ;
  return n;
}
     94a:	6422                	ld	s0,8(sp)
     94c:	0141                	add	sp,sp,16
     94e:	8082                	ret
  for(n = 0; s[n]; n++)
     950:	4501                	li	a0,0
     952:	bfe5                	j	94a <strlen+0x20>

0000000000000954 <memset>:

void*
memset(void *dst, int c, uint n)
{
     954:	1141                	add	sp,sp,-16
     956:	e422                	sd	s0,8(sp)
     958:	0800                	add	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
     95a:	ca19                	beqz	a2,970 <memset+0x1c>
     95c:	87aa                	mv	a5,a0
     95e:	1602                	sll	a2,a2,0x20
     960:	9201                	srl	a2,a2,0x20
     962:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
     966:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
     96a:	0785                	add	a5,a5,1
     96c:	fee79de3          	bne	a5,a4,966 <memset+0x12>
  }
  return dst;
}
     970:	6422                	ld	s0,8(sp)
     972:	0141                	add	sp,sp,16
     974:	8082                	ret

0000000000000976 <strchr>:

char*
strchr(const char *s, char c)
{
     976:	1141                	add	sp,sp,-16
     978:	e422                	sd	s0,8(sp)
     97a:	0800                	add	s0,sp,16
  for(; *s; s++)
     97c:	00054783          	lbu	a5,0(a0)
     980:	cb99                	beqz	a5,996 <strchr+0x20>
    if(*s == c)
     982:	00f58763          	beq	a1,a5,990 <strchr+0x1a>
  for(; *s; s++)
     986:	0505                	add	a0,a0,1
     988:	00054783          	lbu	a5,0(a0)
     98c:	fbfd                	bnez	a5,982 <strchr+0xc>
      return (char*)s;
  return 0;
     98e:	4501                	li	a0,0
}
     990:	6422                	ld	s0,8(sp)
     992:	0141                	add	sp,sp,16
     994:	8082                	ret
  return 0;
     996:	4501                	li	a0,0
     998:	bfe5                	j	990 <strchr+0x1a>

000000000000099a <gets>:

char*
gets(char *buf, int max)
{
     99a:	711d                	add	sp,sp,-96
     99c:	ec86                	sd	ra,88(sp)
     99e:	e8a2                	sd	s0,80(sp)
     9a0:	e4a6                	sd	s1,72(sp)
     9a2:	e0ca                	sd	s2,64(sp)
     9a4:	fc4e                	sd	s3,56(sp)
     9a6:	f852                	sd	s4,48(sp)
     9a8:	f456                	sd	s5,40(sp)
     9aa:	f05a                	sd	s6,32(sp)
     9ac:	ec5e                	sd	s7,24(sp)
     9ae:	1080                	add	s0,sp,96
     9b0:	8baa                	mv	s7,a0
     9b2:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     9b4:	892a                	mv	s2,a0
     9b6:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
     9b8:	4aa9                	li	s5,10
     9ba:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
     9bc:	89a6                	mv	s3,s1
     9be:	2485                	addw	s1,s1,1
     9c0:	0344d663          	bge	s1,s4,9ec <gets+0x52>
    cc = read(0, &c, 1);
     9c4:	4605                	li	a2,1
     9c6:	faf40593          	add	a1,s0,-81
     9ca:	4501                	li	a0,0
     9cc:	406000ef          	jal	dd2 <read>
    if(cc < 1)
     9d0:	00a05e63          	blez	a0,9ec <gets+0x52>
    buf[i++] = c;
     9d4:	faf44783          	lbu	a5,-81(s0)
     9d8:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
     9dc:	01578763          	beq	a5,s5,9ea <gets+0x50>
     9e0:	0905                	add	s2,s2,1
     9e2:	fd679de3          	bne	a5,s6,9bc <gets+0x22>
  for(i=0; i+1 < max; ){
     9e6:	89a6                	mv	s3,s1
     9e8:	a011                	j	9ec <gets+0x52>
     9ea:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
     9ec:	99de                	add	s3,s3,s7
     9ee:	00098023          	sb	zero,0(s3)
  return buf;
}
     9f2:	855e                	mv	a0,s7
     9f4:	60e6                	ld	ra,88(sp)
     9f6:	6446                	ld	s0,80(sp)
     9f8:	64a6                	ld	s1,72(sp)
     9fa:	6906                	ld	s2,64(sp)
     9fc:	79e2                	ld	s3,56(sp)
     9fe:	7a42                	ld	s4,48(sp)
     a00:	7aa2                	ld	s5,40(sp)
     a02:	7b02                	ld	s6,32(sp)
     a04:	6be2                	ld	s7,24(sp)
     a06:	6125                	add	sp,sp,96
     a08:	8082                	ret

0000000000000a0a <stat>:

int
stat(const char *n, struct stat *st)
{
     a0a:	1101                	add	sp,sp,-32
     a0c:	ec06                	sd	ra,24(sp)
     a0e:	e822                	sd	s0,16(sp)
     a10:	e426                	sd	s1,8(sp)
     a12:	e04a                	sd	s2,0(sp)
     a14:	1000                	add	s0,sp,32
     a16:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     a18:	4581                	li	a1,0
     a1a:	3e0000ef          	jal	dfa <open>
  if(fd < 0)
     a1e:	02054163          	bltz	a0,a40 <stat+0x36>
     a22:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
     a24:	85ca                	mv	a1,s2
     a26:	3ec000ef          	jal	e12 <fstat>
     a2a:	892a                	mv	s2,a0
  close(fd);
     a2c:	8526                	mv	a0,s1
     a2e:	3b4000ef          	jal	de2 <close>
  return r;
}
     a32:	854a                	mv	a0,s2
     a34:	60e2                	ld	ra,24(sp)
     a36:	6442                	ld	s0,16(sp)
     a38:	64a2                	ld	s1,8(sp)
     a3a:	6902                	ld	s2,0(sp)
     a3c:	6105                	add	sp,sp,32
     a3e:	8082                	ret
    return -1;
     a40:	597d                	li	s2,-1
     a42:	bfc5                	j	a32 <stat+0x28>

0000000000000a44 <atoi>:

int
atoi(const char *s)
{
     a44:	1141                	add	sp,sp,-16
     a46:	e422                	sd	s0,8(sp)
     a48:	0800                	add	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
     a4a:	00054683          	lbu	a3,0(a0)
     a4e:	fd06879b          	addw	a5,a3,-48
     a52:	0ff7f793          	zext.b	a5,a5
     a56:	4625                	li	a2,9
     a58:	02f66863          	bltu	a2,a5,a88 <atoi+0x44>
     a5c:	872a                	mv	a4,a0
  n = 0;
     a5e:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
     a60:	0705                	add	a4,a4,1
     a62:	0025179b          	sllw	a5,a0,0x2
     a66:	9fa9                	addw	a5,a5,a0
     a68:	0017979b          	sllw	a5,a5,0x1
     a6c:	9fb5                	addw	a5,a5,a3
     a6e:	fd07851b          	addw	a0,a5,-48
  while('0' <= *s && *s <= '9')
     a72:	00074683          	lbu	a3,0(a4)
     a76:	fd06879b          	addw	a5,a3,-48
     a7a:	0ff7f793          	zext.b	a5,a5
     a7e:	fef671e3          	bgeu	a2,a5,a60 <atoi+0x1c>
  return n;
}
     a82:	6422                	ld	s0,8(sp)
     a84:	0141                	add	sp,sp,16
     a86:	8082                	ret
  n = 0;
     a88:	4501                	li	a0,0
     a8a:	bfe5                	j	a82 <atoi+0x3e>

0000000000000a8c <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
     a8c:	1141                	add	sp,sp,-16
     a8e:	e422                	sd	s0,8(sp)
     a90:	0800                	add	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
     a92:	02b57463          	bgeu	a0,a1,aba <memmove+0x2e>
    while(n-- > 0)
     a96:	00c05f63          	blez	a2,ab4 <memmove+0x28>
     a9a:	1602                	sll	a2,a2,0x20
     a9c:	9201                	srl	a2,a2,0x20
     a9e:	00c507b3          	add	a5,a0,a2
  dst = vdst;
     aa2:	872a                	mv	a4,a0
      *dst++ = *src++;
     aa4:	0585                	add	a1,a1,1
     aa6:	0705                	add	a4,a4,1
     aa8:	fff5c683          	lbu	a3,-1(a1)
     aac:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
     ab0:	fee79ae3          	bne	a5,a4,aa4 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
     ab4:	6422                	ld	s0,8(sp)
     ab6:	0141                	add	sp,sp,16
     ab8:	8082                	ret
    dst += n;
     aba:	00c50733          	add	a4,a0,a2
    src += n;
     abe:	95b2                	add	a1,a1,a2
    while(n-- > 0)
     ac0:	fec05ae3          	blez	a2,ab4 <memmove+0x28>
     ac4:	fff6079b          	addw	a5,a2,-1
     ac8:	1782                	sll	a5,a5,0x20
     aca:	9381                	srl	a5,a5,0x20
     acc:	fff7c793          	not	a5,a5
     ad0:	97ba                	add	a5,a5,a4
      *--dst = *--src;
     ad2:	15fd                	add	a1,a1,-1
     ad4:	177d                	add	a4,a4,-1
     ad6:	0005c683          	lbu	a3,0(a1)
     ada:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
     ade:	fee79ae3          	bne	a5,a4,ad2 <memmove+0x46>
     ae2:	bfc9                	j	ab4 <memmove+0x28>

0000000000000ae4 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
     ae4:	1141                	add	sp,sp,-16
     ae6:	e422                	sd	s0,8(sp)
     ae8:	0800                	add	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
     aea:	ca05                	beqz	a2,b1a <memcmp+0x36>
     aec:	fff6069b          	addw	a3,a2,-1
     af0:	1682                	sll	a3,a3,0x20
     af2:	9281                	srl	a3,a3,0x20
     af4:	0685                	add	a3,a3,1
     af6:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
     af8:	00054783          	lbu	a5,0(a0)
     afc:	0005c703          	lbu	a4,0(a1)
     b00:	00e79863          	bne	a5,a4,b10 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
     b04:	0505                	add	a0,a0,1
    p2++;
     b06:	0585                	add	a1,a1,1
  while (n-- > 0) {
     b08:	fed518e3          	bne	a0,a3,af8 <memcmp+0x14>
  }
  return 0;
     b0c:	4501                	li	a0,0
     b0e:	a019                	j	b14 <memcmp+0x30>
      return *p1 - *p2;
     b10:	40e7853b          	subw	a0,a5,a4
}
     b14:	6422                	ld	s0,8(sp)
     b16:	0141                	add	sp,sp,16
     b18:	8082                	ret
  return 0;
     b1a:	4501                	li	a0,0
     b1c:	bfe5                	j	b14 <memcmp+0x30>

0000000000000b1e <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
     b1e:	1141                	add	sp,sp,-16
     b20:	e406                	sd	ra,8(sp)
     b22:	e022                	sd	s0,0(sp)
     b24:	0800                	add	s0,sp,16
  return memmove(dst, src, n);
     b26:	f67ff0ef          	jal	a8c <memmove>
}
     b2a:	60a2                	ld	ra,8(sp)
     b2c:	6402                	ld	s0,0(sp)
     b2e:	0141                	add	sp,sp,16
     b30:	8082                	ret

0000000000000b32 <htons>:
    return (v & 0x000000ff) << 24 | (v & 0x0000ff00) << 8 | (v & 0x00ff0000) >> 8 | (v & 0xff000000) >> 24;
}

uint16_t
htons(uint16_t h)
{
     b32:	1141                	add	sp,sp,-16
     b34:	e422                	sd	s0,8(sp)
     b36:	0800                	add	s0,sp,16
    if (!endian) {
     b38:	00001797          	auipc	a5,0x1
     b3c:	4d87a783          	lw	a5,1240(a5) # 2010 <endian>
     b40:	e385                	bnez	a5,b60 <htons+0x2e>
        endian = byteorder();
     b42:	4d200793          	li	a5,1234
     b46:	00001717          	auipc	a4,0x1
     b4a:	4cf72523          	sw	a5,1226(a4) # 2010 <endian>
    return (v & 0x00ff) << 8 | (v & 0xff00 ) >> 8;
     b4e:	0085579b          	srlw	a5,a0,0x8
     b52:	0085151b          	sllw	a0,a0,0x8
     b56:	8fc9                	or	a5,a5,a0
     b58:	03079513          	sll	a0,a5,0x30
     b5c:	9141                	srl	a0,a0,0x30
     b5e:	a029                	j	b68 <htons+0x36>
    }
    return endian == __LITTLE_ENDIAN ? byteswap16(h) : h;
     b60:	4d200713          	li	a4,1234
     b64:	fee785e3          	beq	a5,a4,b4e <htons+0x1c>
}
     b68:	6422                	ld	s0,8(sp)
     b6a:	0141                	add	sp,sp,16
     b6c:	8082                	ret

0000000000000b6e <ntohs>:

uint16_t
ntohs(uint16_t n)
{
     b6e:	1141                	add	sp,sp,-16
     b70:	e422                	sd	s0,8(sp)
     b72:	0800                	add	s0,sp,16
    if (!endian) {
     b74:	00001797          	auipc	a5,0x1
     b78:	49c7a783          	lw	a5,1180(a5) # 2010 <endian>
     b7c:	e385                	bnez	a5,b9c <ntohs+0x2e>
        endian = byteorder();
     b7e:	4d200793          	li	a5,1234
     b82:	00001717          	auipc	a4,0x1
     b86:	48f72723          	sw	a5,1166(a4) # 2010 <endian>
    return (v & 0x00ff) << 8 | (v & 0xff00 ) >> 8;
     b8a:	0085579b          	srlw	a5,a0,0x8
     b8e:	0085151b          	sllw	a0,a0,0x8
     b92:	8fc9                	or	a5,a5,a0
     b94:	03079513          	sll	a0,a5,0x30
     b98:	9141                	srl	a0,a0,0x30
     b9a:	a029                	j	ba4 <ntohs+0x36>
    }
    return endian == __LITTLE_ENDIAN ? byteswap16(n) : n;
     b9c:	4d200713          	li	a4,1234
     ba0:	fee785e3          	beq	a5,a4,b8a <ntohs+0x1c>
}
     ba4:	6422                	ld	s0,8(sp)
     ba6:	0141                	add	sp,sp,16
     ba8:	8082                	ret

0000000000000baa <htonl>:

uint32_t
htonl(uint32_t h)
{
     baa:	1141                	add	sp,sp,-16
     bac:	e422                	sd	s0,8(sp)
     bae:	0800                	add	s0,sp,16
    if (!endian) {
     bb0:	00001797          	auipc	a5,0x1
     bb4:	4607a783          	lw	a5,1120(a5) # 2010 <endian>
     bb8:	ef85                	bnez	a5,bf0 <htonl+0x46>
        endian = byteorder();
     bba:	4d200793          	li	a5,1234
     bbe:	00001717          	auipc	a4,0x1
     bc2:	44f72923          	sw	a5,1106(a4) # 2010 <endian>
    return (v & 0x000000ff) << 24 | (v & 0x0000ff00) << 8 | (v & 0x00ff0000) >> 8 | (v & 0xff000000) >> 24;
     bc6:	0185179b          	sllw	a5,a0,0x18
     bca:	0185571b          	srlw	a4,a0,0x18
     bce:	8fd9                	or	a5,a5,a4
     bd0:	0085171b          	sllw	a4,a0,0x8
     bd4:	00ff06b7          	lui	a3,0xff0
     bd8:	8f75                	and	a4,a4,a3
     bda:	8fd9                	or	a5,a5,a4
     bdc:	0085551b          	srlw	a0,a0,0x8
     be0:	6741                	lui	a4,0x10
     be2:	f0070713          	add	a4,a4,-256 # ff00 <base+0xdaf8>
     be6:	8d79                	and	a0,a0,a4
     be8:	8fc9                	or	a5,a5,a0
     bea:	0007851b          	sext.w	a0,a5
     bee:	a029                	j	bf8 <htonl+0x4e>
    }
    return endian == __LITTLE_ENDIAN ? byteswap32(h) : h;
     bf0:	4d200713          	li	a4,1234
     bf4:	fce789e3          	beq	a5,a4,bc6 <htonl+0x1c>
}
     bf8:	6422                	ld	s0,8(sp)
     bfa:	0141                	add	sp,sp,16
     bfc:	8082                	ret

0000000000000bfe <ntohl>:

uint32_t
ntohl(uint32_t n)
{
     bfe:	1141                	add	sp,sp,-16
     c00:	e422                	sd	s0,8(sp)
     c02:	0800                	add	s0,sp,16
    if (!endian) {
     c04:	00001797          	auipc	a5,0x1
     c08:	40c7a783          	lw	a5,1036(a5) # 2010 <endian>
     c0c:	ef85                	bnez	a5,c44 <ntohl+0x46>
        endian = byteorder();
     c0e:	4d200793          	li	a5,1234
     c12:	00001717          	auipc	a4,0x1
     c16:	3ef72f23          	sw	a5,1022(a4) # 2010 <endian>
    return (v & 0x000000ff) << 24 | (v & 0x0000ff00) << 8 | (v & 0x00ff0000) >> 8 | (v & 0xff000000) >> 24;
     c1a:	0185179b          	sllw	a5,a0,0x18
     c1e:	0185571b          	srlw	a4,a0,0x18
     c22:	8fd9                	or	a5,a5,a4
     c24:	0085171b          	sllw	a4,a0,0x8
     c28:	00ff06b7          	lui	a3,0xff0
     c2c:	8f75                	and	a4,a4,a3
     c2e:	8fd9                	or	a5,a5,a4
     c30:	0085551b          	srlw	a0,a0,0x8
     c34:	6741                	lui	a4,0x10
     c36:	f0070713          	add	a4,a4,-256 # ff00 <base+0xdaf8>
     c3a:	8d79                	and	a0,a0,a4
     c3c:	8fc9                	or	a5,a5,a0
     c3e:	0007851b          	sext.w	a0,a5
     c42:	a029                	j	c4c <ntohl+0x4e>
    }
    return endian == __LITTLE_ENDIAN ? byteswap32(n) : n;
     c44:	4d200713          	li	a4,1234
     c48:	fce789e3          	beq	a5,a4,c1a <ntohl+0x1c>
}
     c4c:	6422                	ld	s0,8(sp)
     c4e:	0141                	add	sp,sp,16
     c50:	8082                	ret

0000000000000c52 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
     c52:	1141                	add	sp,sp,-16
     c54:	e422                	sd	s0,8(sp)
     c56:	0800                	add	s0,sp,16
     c58:	872a                	mv	a4,a0
    int neg = 0;
    long val = 0;

    // gobble initial whitespace
    while (*s == ' ' || *s == '\t')
     c5a:	02000693          	li	a3,32
     c5e:	4525                	li	a0,9
     c60:	a011                	j	c64 <strtol+0x12>
        s++;
     c62:	0705                	add	a4,a4,1
    while (*s == ' ' || *s == '\t')
     c64:	00074783          	lbu	a5,0(a4)
     c68:	fed78de3          	beq	a5,a3,c62 <strtol+0x10>
     c6c:	fea78be3          	beq	a5,a0,c62 <strtol+0x10>

    // plus/minus sign
    if (*s == '+')
     c70:	02b00693          	li	a3,43
     c74:	02d78663          	beq	a5,a3,ca0 <strtol+0x4e>
        s++;
    else if (*s == '-')
     c78:	02d00693          	li	a3,45
    int neg = 0;
     c7c:	4301                	li	t1,0
    else if (*s == '-')
     c7e:	02d78463          	beq	a5,a3,ca6 <strtol+0x54>
        s++, neg = 1;

    // hex or octal base prefix
    if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
     c82:	fef67793          	and	a5,a2,-17
     c86:	eb89                	bnez	a5,c98 <strtol+0x46>
     c88:	00074683          	lbu	a3,0(a4)
     c8c:	03000793          	li	a5,48
     c90:	00f68e63          	beq	a3,a5,cac <strtol+0x5a>
        s += 2, base = 16;
    else if (base == 0 && s[0] == '0')
     c94:	e211                	bnez	a2,c98 <strtol+0x46>
        s++, base = 8;
    else if (base == 0)
        base = 10;
     c96:	4629                	li	a2,10
     c98:	4501                	li	a0,0

    // digits
    while (1) {
        int dig;

        if (*s >= '0' && *s <= '9')
     c9a:	4825                	li	a6,9
            dig = *s - '0';
        else if (*s >= 'a' && *s <= 'z')
     c9c:	48e5                	li	a7,25
     c9e:	a825                	j	cd6 <strtol+0x84>
        s++;
     ca0:	0705                	add	a4,a4,1
    int neg = 0;
     ca2:	4301                	li	t1,0
     ca4:	bff9                	j	c82 <strtol+0x30>
        s++, neg = 1;
     ca6:	0705                	add	a4,a4,1
     ca8:	4305                	li	t1,1
     caa:	bfe1                	j	c82 <strtol+0x30>
    if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
     cac:	00174683          	lbu	a3,1(a4)
     cb0:	07800793          	li	a5,120
     cb4:	00f68663          	beq	a3,a5,cc0 <strtol+0x6e>
    else if (base == 0 && s[0] == '0')
     cb8:	f265                	bnez	a2,c98 <strtol+0x46>
        s++, base = 8;
     cba:	0705                	add	a4,a4,1
     cbc:	4621                	li	a2,8
     cbe:	bfe9                	j	c98 <strtol+0x46>
        s += 2, base = 16;
     cc0:	0709                	add	a4,a4,2
     cc2:	4641                	li	a2,16
     cc4:	bfd1                	j	c98 <strtol+0x46>
            dig = *s - '0';
     cc6:	fd07879b          	addw	a5,a5,-48
            dig = *s - 'a' + 10;
        else if (*s >= 'A' && *s <= 'Z')
            dig = *s - 'A' + 10;
        else
            break;
        if (dig >= base)
     cca:	04c7d063          	bge	a5,a2,d0a <strtol+0xb8>
            break;
        s++, val = (val * base) + dig;
     cce:	0705                	add	a4,a4,1
     cd0:	02a60533          	mul	a0,a2,a0
     cd4:	953e                	add	a0,a0,a5
        if (*s >= '0' && *s <= '9')
     cd6:	00074783          	lbu	a5,0(a4)
     cda:	fd07869b          	addw	a3,a5,-48
     cde:	0ff6f693          	zext.b	a3,a3
     ce2:	fed872e3          	bgeu	a6,a3,cc6 <strtol+0x74>
        else if (*s >= 'a' && *s <= 'z')
     ce6:	f9f7869b          	addw	a3,a5,-97
     cea:	0ff6f693          	zext.b	a3,a3
     cee:	00d8e563          	bltu	a7,a3,cf8 <strtol+0xa6>
            dig = *s - 'a' + 10;
     cf2:	fa97879b          	addw	a5,a5,-87
     cf6:	bfd1                	j	cca <strtol+0x78>
        else if (*s >= 'A' && *s <= 'Z')
     cf8:	fbf7869b          	addw	a3,a5,-65
     cfc:	0ff6f693          	zext.b	a3,a3
     d00:	00d8e563          	bltu	a7,a3,d0a <strtol+0xb8>
            dig = *s - 'A' + 10;
     d04:	fc97879b          	addw	a5,a5,-55
     d08:	b7c9                	j	cca <strtol+0x78>
        // we don't properly detect overflow!
    }

    if (endptr)
     d0a:	c191                	beqz	a1,d0e <strtol+0xbc>
        *endptr = (char *) s;
     d0c:	e198                	sd	a4,0(a1)
    return (neg ? -val : val);
     d0e:	00030463          	beqz	t1,d16 <strtol+0xc4>
     d12:	40a00533          	neg	a0,a0
}
     d16:	6422                	ld	s0,8(sp)
     d18:	0141                	add	sp,sp,16
     d1a:	8082                	ret

0000000000000d1c <inet_pton>:
inet_pton (int family, const char *p, void *n) {
    char *sp, *ep;
    int idx;
    long ret;

    if (family != AF_INET) {
     d1c:	4785                	li	a5,1
     d1e:	08f51263          	bne	a0,a5,da2 <inet_pton+0x86>
inet_pton (int family, const char *p, void *n) {
     d22:	715d                	add	sp,sp,-80
     d24:	e486                	sd	ra,72(sp)
     d26:	e0a2                	sd	s0,64(sp)
     d28:	fc26                	sd	s1,56(sp)
     d2a:	f84a                	sd	s2,48(sp)
     d2c:	f44e                	sd	s3,40(sp)
     d2e:	f052                	sd	s4,32(sp)
     d30:	ec56                	sd	s5,24(sp)
     d32:	e85a                	sd	s6,16(sp)
     d34:	0880                	add	s0,sp,80
     d36:	892e                	mv	s2,a1
     d38:	89b2                	mv	s3,a2
     d3a:	4481                	li	s1,0
        return -1;
    }
    sp = (char *)p;
    for (idx = 0; idx < 4; idx++) {
        ret = strtol(sp, &ep, 10);
        if (ret < 0 || ret > 255) {
     d3c:	0ff00a13          	li	s4,255
            return -1;
        }
        if (ep == sp) {
            return -1;
        }
        if ((idx == 3 && *ep != '\0') || (idx != 3 && *ep != '.')) {
     d40:	4a8d                	li	s5,3
     d42:	02e00b13          	li	s6,46
     d46:	a815                	j	d7a <inet_pton+0x5e>
     d48:	0007c783          	lbu	a5,0(a5)
     d4c:	e3ad                	bnez	a5,dae <inet_pton+0x92>
            return -1;
        }
        ((uint8_t *)n)[idx] = ret;
     d4e:	2481                	sext.w	s1,s1
     d50:	99a6                	add	s3,s3,s1
     d52:	00a98023          	sb	a0,0(s3)
        sp = ep + 1;
    }
    return 0;
     d56:	4501                	li	a0,0
}
     d58:	60a6                	ld	ra,72(sp)
     d5a:	6406                	ld	s0,64(sp)
     d5c:	74e2                	ld	s1,56(sp)
     d5e:	7942                	ld	s2,48(sp)
     d60:	79a2                	ld	s3,40(sp)
     d62:	7a02                	ld	s4,32(sp)
     d64:	6ae2                	ld	s5,24(sp)
     d66:	6b42                	ld	s6,16(sp)
     d68:	6161                	add	sp,sp,80
     d6a:	8082                	ret
        ((uint8_t *)n)[idx] = ret;
     d6c:	00998733          	add	a4,s3,s1
     d70:	00a70023          	sb	a0,0(a4)
        sp = ep + 1;
     d74:	00178913          	add	s2,a5,1
    for (idx = 0; idx < 4; idx++) {
     d78:	0485                	add	s1,s1,1
        ret = strtol(sp, &ep, 10);
     d7a:	4629                	li	a2,10
     d7c:	fb840593          	add	a1,s0,-72
     d80:	854a                	mv	a0,s2
     d82:	ed1ff0ef          	jal	c52 <strtol>
        if (ret < 0 || ret > 255) {
     d86:	02aa6063          	bltu	s4,a0,da6 <inet_pton+0x8a>
        if (ep == sp) {
     d8a:	fb843783          	ld	a5,-72(s0)
     d8e:	01278e63          	beq	a5,s2,daa <inet_pton+0x8e>
        if ((idx == 3 && *ep != '\0') || (idx != 3 && *ep != '.')) {
     d92:	fb548be3          	beq	s1,s5,d48 <inet_pton+0x2c>
     d96:	0007c703          	lbu	a4,0(a5)
     d9a:	fd6709e3          	beq	a4,s6,d6c <inet_pton+0x50>
            return -1;
     d9e:	557d                	li	a0,-1
     da0:	bf65                	j	d58 <inet_pton+0x3c>
        return -1;
     da2:	557d                	li	a0,-1
}
     da4:	8082                	ret
            return -1;
     da6:	557d                	li	a0,-1
     da8:	bf45                	j	d58 <inet_pton+0x3c>
            return -1;
     daa:	557d                	li	a0,-1
     dac:	b775                	j	d58 <inet_pton+0x3c>
            return -1;
     dae:	557d                	li	a0,-1
     db0:	b765                	j	d58 <inet_pton+0x3c>

0000000000000db2 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
     db2:	4885                	li	a7,1
 ecall
     db4:	00000073          	ecall
 ret
     db8:	8082                	ret

0000000000000dba <exit>:
.global exit
exit:
 li a7, SYS_exit
     dba:	4889                	li	a7,2
 ecall
     dbc:	00000073          	ecall
 ret
     dc0:	8082                	ret

0000000000000dc2 <wait>:
.global wait
wait:
 li a7, SYS_wait
     dc2:	488d                	li	a7,3
 ecall
     dc4:	00000073          	ecall
 ret
     dc8:	8082                	ret

0000000000000dca <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
     dca:	4891                	li	a7,4
 ecall
     dcc:	00000073          	ecall
 ret
     dd0:	8082                	ret

0000000000000dd2 <read>:
.global read
read:
 li a7, SYS_read
     dd2:	4895                	li	a7,5
 ecall
     dd4:	00000073          	ecall
 ret
     dd8:	8082                	ret

0000000000000dda <write>:
.global write
write:
 li a7, SYS_write
     dda:	48c1                	li	a7,16
 ecall
     ddc:	00000073          	ecall
 ret
     de0:	8082                	ret

0000000000000de2 <close>:
.global close
close:
 li a7, SYS_close
     de2:	48d5                	li	a7,21
 ecall
     de4:	00000073          	ecall
 ret
     de8:	8082                	ret

0000000000000dea <kill>:
.global kill
kill:
 li a7, SYS_kill
     dea:	4899                	li	a7,6
 ecall
     dec:	00000073          	ecall
 ret
     df0:	8082                	ret

0000000000000df2 <exec>:
.global exec
exec:
 li a7, SYS_exec
     df2:	489d                	li	a7,7
 ecall
     df4:	00000073          	ecall
 ret
     df8:	8082                	ret

0000000000000dfa <open>:
.global open
open:
 li a7, SYS_open
     dfa:	48bd                	li	a7,15
 ecall
     dfc:	00000073          	ecall
 ret
     e00:	8082                	ret

0000000000000e02 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
     e02:	48c5                	li	a7,17
 ecall
     e04:	00000073          	ecall
 ret
     e08:	8082                	ret

0000000000000e0a <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
     e0a:	48c9                	li	a7,18
 ecall
     e0c:	00000073          	ecall
 ret
     e10:	8082                	ret

0000000000000e12 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
     e12:	48a1                	li	a7,8
 ecall
     e14:	00000073          	ecall
 ret
     e18:	8082                	ret

0000000000000e1a <link>:
.global link
link:
 li a7, SYS_link
     e1a:	48cd                	li	a7,19
 ecall
     e1c:	00000073          	ecall
 ret
     e20:	8082                	ret

0000000000000e22 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
     e22:	48d1                	li	a7,20
 ecall
     e24:	00000073          	ecall
 ret
     e28:	8082                	ret

0000000000000e2a <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
     e2a:	48a5                	li	a7,9
 ecall
     e2c:	00000073          	ecall
 ret
     e30:	8082                	ret

0000000000000e32 <dup>:
.global dup
dup:
 li a7, SYS_dup
     e32:	48a9                	li	a7,10
 ecall
     e34:	00000073          	ecall
 ret
     e38:	8082                	ret

0000000000000e3a <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
     e3a:	48ad                	li	a7,11
 ecall
     e3c:	00000073          	ecall
 ret
     e40:	8082                	ret

0000000000000e42 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
     e42:	48b1                	li	a7,12
 ecall
     e44:	00000073          	ecall
 ret
     e48:	8082                	ret

0000000000000e4a <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
     e4a:	48b5                	li	a7,13
 ecall
     e4c:	00000073          	ecall
 ret
     e50:	8082                	ret

0000000000000e52 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
     e52:	48b9                	li	a7,14
 ecall
     e54:	00000073          	ecall
 ret
     e58:	8082                	ret

0000000000000e5a <socket>:
.global socket
socket:
 li a7, SYS_socket
     e5a:	48d9                	li	a7,22
 ecall
     e5c:	00000073          	ecall
 ret
     e60:	8082                	ret

0000000000000e62 <bind>:
.global bind
bind:
 li a7, SYS_bind
     e62:	48dd                	li	a7,23
 ecall
     e64:	00000073          	ecall
 ret
     e68:	8082                	ret

0000000000000e6a <recvfrom>:
.global recvfrom
recvfrom:
 li a7, SYS_recvfrom
     e6a:	48e1                	li	a7,24
 ecall
     e6c:	00000073          	ecall
 ret
     e70:	8082                	ret

0000000000000e72 <sendto>:
.global sendto
sendto:
 li a7, SYS_sendto
     e72:	48e5                	li	a7,25
 ecall
     e74:	00000073          	ecall
 ret
     e78:	8082                	ret

0000000000000e7a <connect>:
.global connect
connect:
 li a7, SYS_connect
     e7a:	48e9                	li	a7,26
 ecall
     e7c:	00000073          	ecall
 ret
     e80:	8082                	ret

0000000000000e82 <listen>:
.global listen
listen:
 li a7, SYS_listen
     e82:	48ed                	li	a7,27
 ecall
     e84:	00000073          	ecall
 ret
     e88:	8082                	ret

0000000000000e8a <accept>:
.global accept
accept:
 li a7, SYS_accept
     e8a:	48f1                	li	a7,28
 ecall
     e8c:	00000073          	ecall
 ret
     e90:	8082                	ret

0000000000000e92 <recv>:
.global recv
recv:
 li a7, SYS_recv
     e92:	48f5                	li	a7,29
 ecall
     e94:	00000073          	ecall
 ret
     e98:	8082                	ret

0000000000000e9a <send>:
.global send
send:
 li a7, SYS_send
     e9a:	48f9                	li	a7,30
 ecall
     e9c:	00000073          	ecall
 ret
     ea0:	8082                	ret

0000000000000ea2 <ioctl>:
.global ioctl
ioctl:
 li a7, SYS_ioctl
     ea2:	48fd                	li	a7,31
 ecall
     ea4:	00000073          	ecall
 ret
     ea8:	8082                	ret

0000000000000eaa <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
     eaa:	1101                	add	sp,sp,-32
     eac:	ec06                	sd	ra,24(sp)
     eae:	e822                	sd	s0,16(sp)
     eb0:	1000                	add	s0,sp,32
     eb2:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
     eb6:	4605                	li	a2,1
     eb8:	fef40593          	add	a1,s0,-17
     ebc:	f1fff0ef          	jal	dda <write>
}
     ec0:	60e2                	ld	ra,24(sp)
     ec2:	6442                	ld	s0,16(sp)
     ec4:	6105                	add	sp,sp,32
     ec6:	8082                	ret

0000000000000ec8 <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
     ec8:	715d                	add	sp,sp,-80
     eca:	e486                	sd	ra,72(sp)
     ecc:	e0a2                	sd	s0,64(sp)
     ece:	fc26                	sd	s1,56(sp)
     ed0:	f84a                	sd	s2,48(sp)
     ed2:	f44e                	sd	s3,40(sp)
     ed4:	0880                	add	s0,sp,80
     ed6:	84aa                	mv	s1,a0
  char buf[20];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
     ed8:	c299                	beqz	a3,ede <printint+0x16>
     eda:	0805c763          	bltz	a1,f68 <printint+0xa0>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
     ede:	2581                	sext.w	a1,a1
  neg = 0;
     ee0:	4881                	li	a7,0
     ee2:	fb840693          	add	a3,s0,-72
  }

  i = 0;
     ee6:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
     ee8:	2601                	sext.w	a2,a2
     eea:	00001517          	auipc	a0,0x1
     eee:	82650513          	add	a0,a0,-2010 # 1710 <digits>
     ef2:	883a                	mv	a6,a4
     ef4:	2705                	addw	a4,a4,1
     ef6:	02c5f7bb          	remuw	a5,a1,a2
     efa:	1782                	sll	a5,a5,0x20
     efc:	9381                	srl	a5,a5,0x20
     efe:	97aa                	add	a5,a5,a0
     f00:	0007c783          	lbu	a5,0(a5)
     f04:	00f68023          	sb	a5,0(a3) # ff0000 <base+0xfedbf8>
  }while((x /= base) != 0);
     f08:	0005879b          	sext.w	a5,a1
     f0c:	02c5d5bb          	divuw	a1,a1,a2
     f10:	0685                	add	a3,a3,1
     f12:	fec7f0e3          	bgeu	a5,a2,ef2 <printint+0x2a>
  if(neg)
     f16:	00088c63          	beqz	a7,f2e <printint+0x66>
    buf[i++] = '-';
     f1a:	fd070793          	add	a5,a4,-48
     f1e:	00878733          	add	a4,a5,s0
     f22:	02d00793          	li	a5,45
     f26:	fef70423          	sb	a5,-24(a4)
     f2a:	0028071b          	addw	a4,a6,2

  while(--i >= 0)
     f2e:	02e05663          	blez	a4,f5a <printint+0x92>
     f32:	fb840793          	add	a5,s0,-72
     f36:	00e78933          	add	s2,a5,a4
     f3a:	fff78993          	add	s3,a5,-1
     f3e:	99ba                	add	s3,s3,a4
     f40:	377d                	addw	a4,a4,-1
     f42:	1702                	sll	a4,a4,0x20
     f44:	9301                	srl	a4,a4,0x20
     f46:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
     f4a:	fff94583          	lbu	a1,-1(s2)
     f4e:	8526                	mv	a0,s1
     f50:	f5bff0ef          	jal	eaa <putc>
  while(--i >= 0)
     f54:	197d                	add	s2,s2,-1
     f56:	ff391ae3          	bne	s2,s3,f4a <printint+0x82>
}
     f5a:	60a6                	ld	ra,72(sp)
     f5c:	6406                	ld	s0,64(sp)
     f5e:	74e2                	ld	s1,56(sp)
     f60:	7942                	ld	s2,48(sp)
     f62:	79a2                	ld	s3,40(sp)
     f64:	6161                	add	sp,sp,80
     f66:	8082                	ret
    x = -xx;
     f68:	40b005bb          	negw	a1,a1
    neg = 1;
     f6c:	4885                	li	a7,1
    x = -xx;
     f6e:	bf95                	j	ee2 <printint+0x1a>

0000000000000f70 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
     f70:	711d                	add	sp,sp,-96
     f72:	ec86                	sd	ra,88(sp)
     f74:	e8a2                	sd	s0,80(sp)
     f76:	e4a6                	sd	s1,72(sp)
     f78:	e0ca                	sd	s2,64(sp)
     f7a:	fc4e                	sd	s3,56(sp)
     f7c:	f852                	sd	s4,48(sp)
     f7e:	f456                	sd	s5,40(sp)
     f80:	f05a                	sd	s6,32(sp)
     f82:	ec5e                	sd	s7,24(sp)
     f84:	e862                	sd	s8,16(sp)
     f86:	e466                	sd	s9,8(sp)
     f88:	e06a                	sd	s10,0(sp)
     f8a:	1080                	add	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
     f8c:	0005c903          	lbu	s2,0(a1)
     f90:	24090763          	beqz	s2,11de <vprintf+0x26e>
     f94:	8b2a                	mv	s6,a0
     f96:	8a2e                	mv	s4,a1
     f98:	8bb2                	mv	s7,a2
  state = 0;
     f9a:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
     f9c:	4481                	li	s1,0
     f9e:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
     fa0:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
     fa4:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
     fa8:	06c00c93          	li	s9,108
     fac:	a005                	j	fcc <vprintf+0x5c>
        putc(fd, c0);
     fae:	85ca                	mv	a1,s2
     fb0:	855a                	mv	a0,s6
     fb2:	ef9ff0ef          	jal	eaa <putc>
     fb6:	a019                	j	fbc <vprintf+0x4c>
    } else if(state == '%'){
     fb8:	03598263          	beq	s3,s5,fdc <vprintf+0x6c>
  for(i = 0; fmt[i]; i++){
     fbc:	2485                	addw	s1,s1,1
     fbe:	8726                	mv	a4,s1
     fc0:	009a07b3          	add	a5,s4,s1
     fc4:	0007c903          	lbu	s2,0(a5)
     fc8:	20090b63          	beqz	s2,11de <vprintf+0x26e>
    c0 = fmt[i] & 0xff;
     fcc:	0009079b          	sext.w	a5,s2
    if(state == 0){
     fd0:	fe0994e3          	bnez	s3,fb8 <vprintf+0x48>
      if(c0 == '%'){
     fd4:	fd579de3          	bne	a5,s5,fae <vprintf+0x3e>
        state = '%';
     fd8:	89be                	mv	s3,a5
     fda:	b7cd                	j	fbc <vprintf+0x4c>
      if(c0) c1 = fmt[i+1] & 0xff;
     fdc:	c7c9                	beqz	a5,1066 <vprintf+0xf6>
     fde:	00ea06b3          	add	a3,s4,a4
     fe2:	0016c683          	lbu	a3,1(a3)
      c1 = c2 = 0;
     fe6:	8636                	mv	a2,a3
      if(c1) c2 = fmt[i+2] & 0xff;
     fe8:	c681                	beqz	a3,ff0 <vprintf+0x80>
     fea:	9752                	add	a4,a4,s4
     fec:	00274603          	lbu	a2,2(a4)
      if(c0 == 'd'){
     ff0:	03878f63          	beq	a5,s8,102e <vprintf+0xbe>
      } else if(c0 == 'l' && c1 == 'd'){
     ff4:	05978963          	beq	a5,s9,1046 <vprintf+0xd6>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
     ff8:	07500713          	li	a4,117
     ffc:	0ee78363          	beq	a5,a4,10e2 <vprintf+0x172>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
    1000:	07800713          	li	a4,120
    1004:	12e78563          	beq	a5,a4,112e <vprintf+0x1be>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
    1008:	07000713          	li	a4,112
    100c:	14e78a63          	beq	a5,a4,1160 <vprintf+0x1f0>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 's'){
    1010:	07300713          	li	a4,115
    1014:	18e78863          	beq	a5,a4,11a4 <vprintf+0x234>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
    1018:	02500713          	li	a4,37
    101c:	04e79563          	bne	a5,a4,1066 <vprintf+0xf6>
        putc(fd, '%');
    1020:	02500593          	li	a1,37
    1024:	855a                	mv	a0,s6
    1026:	e85ff0ef          	jal	eaa <putc>
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
#endif
      state = 0;
    102a:	4981                	li	s3,0
    102c:	bf41                	j	fbc <vprintf+0x4c>
        printint(fd, va_arg(ap, int), 10, 1);
    102e:	008b8913          	add	s2,s7,8
    1032:	4685                	li	a3,1
    1034:	4629                	li	a2,10
    1036:	000ba583          	lw	a1,0(s7)
    103a:	855a                	mv	a0,s6
    103c:	e8dff0ef          	jal	ec8 <printint>
    1040:	8bca                	mv	s7,s2
      state = 0;
    1042:	4981                	li	s3,0
    1044:	bfa5                	j	fbc <vprintf+0x4c>
      } else if(c0 == 'l' && c1 == 'd'){
    1046:	06400793          	li	a5,100
    104a:	02f68963          	beq	a3,a5,107c <vprintf+0x10c>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
    104e:	06c00793          	li	a5,108
    1052:	04f68263          	beq	a3,a5,1096 <vprintf+0x126>
      } else if(c0 == 'l' && c1 == 'u'){
    1056:	07500793          	li	a5,117
    105a:	0af68063          	beq	a3,a5,10fa <vprintf+0x18a>
      } else if(c0 == 'l' && c1 == 'x'){
    105e:	07800793          	li	a5,120
    1062:	0ef68263          	beq	a3,a5,1146 <vprintf+0x1d6>
        putc(fd, '%');
    1066:	02500593          	li	a1,37
    106a:	855a                	mv	a0,s6
    106c:	e3fff0ef          	jal	eaa <putc>
        putc(fd, c0);
    1070:	85ca                	mv	a1,s2
    1072:	855a                	mv	a0,s6
    1074:	e37ff0ef          	jal	eaa <putc>
      state = 0;
    1078:	4981                	li	s3,0
    107a:	b789                	j	fbc <vprintf+0x4c>
        printint(fd, va_arg(ap, uint64), 10, 1);
    107c:	008b8913          	add	s2,s7,8
    1080:	4685                	li	a3,1
    1082:	4629                	li	a2,10
    1084:	000bb583          	ld	a1,0(s7)
    1088:	855a                	mv	a0,s6
    108a:	e3fff0ef          	jal	ec8 <printint>
        i += 1;
    108e:	2485                	addw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 1);
    1090:	8bca                	mv	s7,s2
      state = 0;
    1092:	4981                	li	s3,0
        i += 1;
    1094:	b725                	j	fbc <vprintf+0x4c>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
    1096:	06400793          	li	a5,100
    109a:	02f60763          	beq	a2,a5,10c8 <vprintf+0x158>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
    109e:	07500793          	li	a5,117
    10a2:	06f60963          	beq	a2,a5,1114 <vprintf+0x1a4>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
    10a6:	07800793          	li	a5,120
    10aa:	faf61ee3          	bne	a2,a5,1066 <vprintf+0xf6>
        printint(fd, va_arg(ap, uint64), 16, 0);
    10ae:	008b8913          	add	s2,s7,8
    10b2:	4681                	li	a3,0
    10b4:	4641                	li	a2,16
    10b6:	000bb583          	ld	a1,0(s7)
    10ba:	855a                	mv	a0,s6
    10bc:	e0dff0ef          	jal	ec8 <printint>
        i += 2;
    10c0:	2489                	addw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 16, 0);
    10c2:	8bca                	mv	s7,s2
      state = 0;
    10c4:	4981                	li	s3,0
        i += 2;
    10c6:	bddd                	j	fbc <vprintf+0x4c>
        printint(fd, va_arg(ap, uint64), 10, 1);
    10c8:	008b8913          	add	s2,s7,8
    10cc:	4685                	li	a3,1
    10ce:	4629                	li	a2,10
    10d0:	000bb583          	ld	a1,0(s7)
    10d4:	855a                	mv	a0,s6
    10d6:	df3ff0ef          	jal	ec8 <printint>
        i += 2;
    10da:	2489                	addw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 1);
    10dc:	8bca                	mv	s7,s2
      state = 0;
    10de:	4981                	li	s3,0
        i += 2;
    10e0:	bdf1                	j	fbc <vprintf+0x4c>
        printint(fd, va_arg(ap, int), 10, 0);
    10e2:	008b8913          	add	s2,s7,8
    10e6:	4681                	li	a3,0
    10e8:	4629                	li	a2,10
    10ea:	000ba583          	lw	a1,0(s7)
    10ee:	855a                	mv	a0,s6
    10f0:	dd9ff0ef          	jal	ec8 <printint>
    10f4:	8bca                	mv	s7,s2
      state = 0;
    10f6:	4981                	li	s3,0
    10f8:	b5d1                	j	fbc <vprintf+0x4c>
        printint(fd, va_arg(ap, uint64), 10, 0);
    10fa:	008b8913          	add	s2,s7,8
    10fe:	4681                	li	a3,0
    1100:	4629                	li	a2,10
    1102:	000bb583          	ld	a1,0(s7)
    1106:	855a                	mv	a0,s6
    1108:	dc1ff0ef          	jal	ec8 <printint>
        i += 1;
    110c:	2485                	addw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 0);
    110e:	8bca                	mv	s7,s2
      state = 0;
    1110:	4981                	li	s3,0
        i += 1;
    1112:	b56d                	j	fbc <vprintf+0x4c>
        printint(fd, va_arg(ap, uint64), 10, 0);
    1114:	008b8913          	add	s2,s7,8
    1118:	4681                	li	a3,0
    111a:	4629                	li	a2,10
    111c:	000bb583          	ld	a1,0(s7)
    1120:	855a                	mv	a0,s6
    1122:	da7ff0ef          	jal	ec8 <printint>
        i += 2;
    1126:	2489                	addw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 0);
    1128:	8bca                	mv	s7,s2
      state = 0;
    112a:	4981                	li	s3,0
        i += 2;
    112c:	bd41                	j	fbc <vprintf+0x4c>
        printint(fd, va_arg(ap, int), 16, 0);
    112e:	008b8913          	add	s2,s7,8
    1132:	4681                	li	a3,0
    1134:	4641                	li	a2,16
    1136:	000ba583          	lw	a1,0(s7)
    113a:	855a                	mv	a0,s6
    113c:	d8dff0ef          	jal	ec8 <printint>
    1140:	8bca                	mv	s7,s2
      state = 0;
    1142:	4981                	li	s3,0
    1144:	bda5                	j	fbc <vprintf+0x4c>
        printint(fd, va_arg(ap, uint64), 16, 0);
    1146:	008b8913          	add	s2,s7,8
    114a:	4681                	li	a3,0
    114c:	4641                	li	a2,16
    114e:	000bb583          	ld	a1,0(s7)
    1152:	855a                	mv	a0,s6
    1154:	d75ff0ef          	jal	ec8 <printint>
        i += 1;
    1158:	2485                	addw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 16, 0);
    115a:	8bca                	mv	s7,s2
      state = 0;
    115c:	4981                	li	s3,0
        i += 1;
    115e:	bdb9                	j	fbc <vprintf+0x4c>
        printptr(fd, va_arg(ap, uint64));
    1160:	008b8d13          	add	s10,s7,8
    1164:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
    1168:	03000593          	li	a1,48
    116c:	855a                	mv	a0,s6
    116e:	d3dff0ef          	jal	eaa <putc>
  putc(fd, 'x');
    1172:	07800593          	li	a1,120
    1176:	855a                	mv	a0,s6
    1178:	d33ff0ef          	jal	eaa <putc>
    117c:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
    117e:	00000b97          	auipc	s7,0x0
    1182:	592b8b93          	add	s7,s7,1426 # 1710 <digits>
    1186:	03c9d793          	srl	a5,s3,0x3c
    118a:	97de                	add	a5,a5,s7
    118c:	0007c583          	lbu	a1,0(a5)
    1190:	855a                	mv	a0,s6
    1192:	d19ff0ef          	jal	eaa <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    1196:	0992                	sll	s3,s3,0x4
    1198:	397d                	addw	s2,s2,-1
    119a:	fe0916e3          	bnez	s2,1186 <vprintf+0x216>
        printptr(fd, va_arg(ap, uint64));
    119e:	8bea                	mv	s7,s10
      state = 0;
    11a0:	4981                	li	s3,0
    11a2:	bd29                	j	fbc <vprintf+0x4c>
        if((s = va_arg(ap, char*)) == 0)
    11a4:	008b8993          	add	s3,s7,8
    11a8:	000bb903          	ld	s2,0(s7)
    11ac:	00090f63          	beqz	s2,11ca <vprintf+0x25a>
        for(; *s; s++)
    11b0:	00094583          	lbu	a1,0(s2)
    11b4:	c195                	beqz	a1,11d8 <vprintf+0x268>
          putc(fd, *s);
    11b6:	855a                	mv	a0,s6
    11b8:	cf3ff0ef          	jal	eaa <putc>
        for(; *s; s++)
    11bc:	0905                	add	s2,s2,1
    11be:	00094583          	lbu	a1,0(s2)
    11c2:	f9f5                	bnez	a1,11b6 <vprintf+0x246>
        if((s = va_arg(ap, char*)) == 0)
    11c4:	8bce                	mv	s7,s3
      state = 0;
    11c6:	4981                	li	s3,0
    11c8:	bbd5                	j	fbc <vprintf+0x4c>
          s = "(null)";
    11ca:	00000917          	auipc	s2,0x0
    11ce:	53e90913          	add	s2,s2,1342 # 1708 <malloc+0x430>
        for(; *s; s++)
    11d2:	02800593          	li	a1,40
    11d6:	b7c5                	j	11b6 <vprintf+0x246>
        if((s = va_arg(ap, char*)) == 0)
    11d8:	8bce                	mv	s7,s3
      state = 0;
    11da:	4981                	li	s3,0
    11dc:	b3c5                	j	fbc <vprintf+0x4c>
    }
  }
}
    11de:	60e6                	ld	ra,88(sp)
    11e0:	6446                	ld	s0,80(sp)
    11e2:	64a6                	ld	s1,72(sp)
    11e4:	6906                	ld	s2,64(sp)
    11e6:	79e2                	ld	s3,56(sp)
    11e8:	7a42                	ld	s4,48(sp)
    11ea:	7aa2                	ld	s5,40(sp)
    11ec:	7b02                	ld	s6,32(sp)
    11ee:	6be2                	ld	s7,24(sp)
    11f0:	6c42                	ld	s8,16(sp)
    11f2:	6ca2                	ld	s9,8(sp)
    11f4:	6d02                	ld	s10,0(sp)
    11f6:	6125                	add	sp,sp,96
    11f8:	8082                	ret

00000000000011fa <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
    11fa:	715d                	add	sp,sp,-80
    11fc:	ec06                	sd	ra,24(sp)
    11fe:	e822                	sd	s0,16(sp)
    1200:	1000                	add	s0,sp,32
    1202:	e010                	sd	a2,0(s0)
    1204:	e414                	sd	a3,8(s0)
    1206:	e818                	sd	a4,16(s0)
    1208:	ec1c                	sd	a5,24(s0)
    120a:	03043023          	sd	a6,32(s0)
    120e:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
    1212:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
    1216:	8622                	mv	a2,s0
    1218:	d59ff0ef          	jal	f70 <vprintf>
}
    121c:	60e2                	ld	ra,24(sp)
    121e:	6442                	ld	s0,16(sp)
    1220:	6161                	add	sp,sp,80
    1222:	8082                	ret

0000000000001224 <printf>:

void
printf(const char *fmt, ...)
{
    1224:	711d                	add	sp,sp,-96
    1226:	ec06                	sd	ra,24(sp)
    1228:	e822                	sd	s0,16(sp)
    122a:	1000                	add	s0,sp,32
    122c:	e40c                	sd	a1,8(s0)
    122e:	e810                	sd	a2,16(s0)
    1230:	ec14                	sd	a3,24(s0)
    1232:	f018                	sd	a4,32(s0)
    1234:	f41c                	sd	a5,40(s0)
    1236:	03043823          	sd	a6,48(s0)
    123a:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
    123e:	00840613          	add	a2,s0,8
    1242:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
    1246:	85aa                	mv	a1,a0
    1248:	4505                	li	a0,1
    124a:	d27ff0ef          	jal	f70 <vprintf>
}
    124e:	60e2                	ld	ra,24(sp)
    1250:	6442                	ld	s0,16(sp)
    1252:	6125                	add	sp,sp,96
    1254:	8082                	ret

0000000000001256 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    1256:	1141                	add	sp,sp,-16
    1258:	e422                	sd	s0,8(sp)
    125a:	0800                	add	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
    125c:	ff050693          	add	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1260:	00001797          	auipc	a5,0x1
    1264:	db87b783          	ld	a5,-584(a5) # 2018 <freep>
    1268:	a02d                	j	1292 <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
    126a:	4618                	lw	a4,8(a2)
    126c:	9f2d                	addw	a4,a4,a1
    126e:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
    1272:	6398                	ld	a4,0(a5)
    1274:	6310                	ld	a2,0(a4)
    1276:	a83d                	j	12b4 <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    1278:	ff852703          	lw	a4,-8(a0)
    127c:	9f31                	addw	a4,a4,a2
    127e:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
    1280:	ff053683          	ld	a3,-16(a0)
    1284:	a091                	j	12c8 <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1286:	6398                	ld	a4,0(a5)
    1288:	00e7e463          	bltu	a5,a4,1290 <free+0x3a>
    128c:	00e6ea63          	bltu	a3,a4,12a0 <free+0x4a>
{
    1290:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1292:	fed7fae3          	bgeu	a5,a3,1286 <free+0x30>
    1296:	6398                	ld	a4,0(a5)
    1298:	00e6e463          	bltu	a3,a4,12a0 <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    129c:	fee7eae3          	bltu	a5,a4,1290 <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
    12a0:	ff852583          	lw	a1,-8(a0)
    12a4:	6390                	ld	a2,0(a5)
    12a6:	02059813          	sll	a6,a1,0x20
    12aa:	01c85713          	srl	a4,a6,0x1c
    12ae:	9736                	add	a4,a4,a3
    12b0:	fae60de3          	beq	a2,a4,126a <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
    12b4:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
    12b8:	4790                	lw	a2,8(a5)
    12ba:	02061593          	sll	a1,a2,0x20
    12be:	01c5d713          	srl	a4,a1,0x1c
    12c2:	973e                	add	a4,a4,a5
    12c4:	fae68ae3          	beq	a3,a4,1278 <free+0x22>
    p->s.ptr = bp->s.ptr;
    12c8:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
    12ca:	00001717          	auipc	a4,0x1
    12ce:	d4f73723          	sd	a5,-690(a4) # 2018 <freep>
}
    12d2:	6422                	ld	s0,8(sp)
    12d4:	0141                	add	sp,sp,16
    12d6:	8082                	ret

00000000000012d8 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    12d8:	7139                	add	sp,sp,-64
    12da:	fc06                	sd	ra,56(sp)
    12dc:	f822                	sd	s0,48(sp)
    12de:	f426                	sd	s1,40(sp)
    12e0:	f04a                	sd	s2,32(sp)
    12e2:	ec4e                	sd	s3,24(sp)
    12e4:	e852                	sd	s4,16(sp)
    12e6:	e456                	sd	s5,8(sp)
    12e8:	e05a                	sd	s6,0(sp)
    12ea:	0080                	add	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    12ec:	02051493          	sll	s1,a0,0x20
    12f0:	9081                	srl	s1,s1,0x20
    12f2:	04bd                	add	s1,s1,15
    12f4:	8091                	srl	s1,s1,0x4
    12f6:	0014899b          	addw	s3,s1,1
    12fa:	0485                	add	s1,s1,1
  if((prevp = freep) == 0){
    12fc:	00001517          	auipc	a0,0x1
    1300:	d1c53503          	ld	a0,-740(a0) # 2018 <freep>
    1304:	c515                	beqz	a0,1330 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1306:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    1308:	4798                	lw	a4,8(a5)
    130a:	02977f63          	bgeu	a4,s1,1348 <malloc+0x70>
  if(nu < 4096)
    130e:	8a4e                	mv	s4,s3
    1310:	0009871b          	sext.w	a4,s3
    1314:	6685                	lui	a3,0x1
    1316:	00d77363          	bgeu	a4,a3,131c <malloc+0x44>
    131a:	6a05                	lui	s4,0x1
    131c:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
    1320:	004a1a1b          	sllw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    1324:	00001917          	auipc	s2,0x1
    1328:	cf490913          	add	s2,s2,-780 # 2018 <freep>
  if(p == (char*)-1)
    132c:	5afd                	li	s5,-1
    132e:	a885                	j	139e <malloc+0xc6>
    base.s.ptr = freep = prevp = &base;
    1330:	00001797          	auipc	a5,0x1
    1334:	0d878793          	add	a5,a5,216 # 2408 <base>
    1338:	00001717          	auipc	a4,0x1
    133c:	cef73023          	sd	a5,-800(a4) # 2018 <freep>
    1340:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
    1342:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
    1346:	b7e1                	j	130e <malloc+0x36>
      if(p->s.size == nunits)
    1348:	02e48c63          	beq	s1,a4,1380 <malloc+0xa8>
        p->s.size -= nunits;
    134c:	4137073b          	subw	a4,a4,s3
    1350:	c798                	sw	a4,8(a5)
        p += p->s.size;
    1352:	02071693          	sll	a3,a4,0x20
    1356:	01c6d713          	srl	a4,a3,0x1c
    135a:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
    135c:	0137a423          	sw	s3,8(a5)
      freep = prevp;
    1360:	00001717          	auipc	a4,0x1
    1364:	caa73c23          	sd	a0,-840(a4) # 2018 <freep>
      return (void*)(p + 1);
    1368:	01078513          	add	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
    136c:	70e2                	ld	ra,56(sp)
    136e:	7442                	ld	s0,48(sp)
    1370:	74a2                	ld	s1,40(sp)
    1372:	7902                	ld	s2,32(sp)
    1374:	69e2                	ld	s3,24(sp)
    1376:	6a42                	ld	s4,16(sp)
    1378:	6aa2                	ld	s5,8(sp)
    137a:	6b02                	ld	s6,0(sp)
    137c:	6121                	add	sp,sp,64
    137e:	8082                	ret
        prevp->s.ptr = p->s.ptr;
    1380:	6398                	ld	a4,0(a5)
    1382:	e118                	sd	a4,0(a0)
    1384:	bff1                	j	1360 <malloc+0x88>
  hp->s.size = nu;
    1386:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
    138a:	0541                	add	a0,a0,16
    138c:	ecbff0ef          	jal	1256 <free>
  return freep;
    1390:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
    1394:	dd61                	beqz	a0,136c <malloc+0x94>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1396:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    1398:	4798                	lw	a4,8(a5)
    139a:	fa9777e3          	bgeu	a4,s1,1348 <malloc+0x70>
    if(p == freep)
    139e:	00093703          	ld	a4,0(s2)
    13a2:	853e                	mv	a0,a5
    13a4:	fef719e3          	bne	a4,a5,1396 <malloc+0xbe>
  p = sbrk(nu * sizeof(Header));
    13a8:	8552                	mv	a0,s4
    13aa:	a99ff0ef          	jal	e42 <sbrk>
  if(p == (char*)-1)
    13ae:	fd551ce3          	bne	a0,s5,1386 <malloc+0xae>
        return 0;
    13b2:	4501                	li	a0,0
    13b4:	bf65                	j	136c <malloc+0x94>
