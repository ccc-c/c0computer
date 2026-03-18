
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
      18:	31d68693          	add	a3,a3,797 # 1f31d <__global_pointer$+0x1d164>
      1c:	02d7e733          	rem	a4,a5,a3
    x = 16807 * lo - 2836 * hi;
      20:	6611                	lui	a2,0x4
      22:	1a760613          	add	a2,a2,423 # 41a7 <__global_pointer$+0x1fee>
      26:	02c70733          	mul	a4,a4,a2
    hi = x / 127773;
      2a:	02d7c7b3          	div	a5,a5,a3
    x = 16807 * lo - 2836 * hi;
      2e:	76fd                	lui	a3,0xfffff
      30:	4ec68693          	add	a3,a3,1260 # fffffffffffff4ec <__global_pointer$+0xffffffffffffd333>
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
      64:	96050513          	add	a0,a0,-1696 # 19c0 <rand_next>
      68:	00000097          	auipc	ra,0x0
      6c:	f98080e7          	jalr	-104(ra) # 0 <do_rand>
}
      70:	60a2                	ld	ra,8(sp)
      72:	6402                	ld	s0,0(sp)
      74:	0141                	add	sp,sp,16
      76:	8082                	ret

0000000000000078 <go>:

void
go(int which_child)
{
      78:	7119                	add	sp,sp,-128
      7a:	fc86                	sd	ra,120(sp)
      7c:	f8a2                	sd	s0,112(sp)
      7e:	f4a6                	sd	s1,104(sp)
      80:	e4d6                	sd	s5,72(sp)
      82:	0100                	add	s0,sp,128
      84:	84aa                	mv	s1,a0
  int fd = -1;
  static char buf[999];
  char *break0 = sbrk(0);
      86:	4501                	li	a0,0
      88:	00001097          	auipc	ra,0x1
      8c:	e2a080e7          	jalr	-470(ra) # eb2 <sbrk>
      90:	8aaa                	mv	s5,a0
  uint64 iters = 0;

  mkdir("grindir");
      92:	00001517          	auipc	a0,0x1
      96:	55650513          	add	a0,a0,1366 # 15e8 <malloc+0x106>
      9a:	00001097          	auipc	ra,0x1
      9e:	df8080e7          	jalr	-520(ra) # e92 <mkdir>
  if(chdir("grindir") != 0){
      a2:	00001517          	auipc	a0,0x1
      a6:	54650513          	add	a0,a0,1350 # 15e8 <malloc+0x106>
      aa:	00001097          	auipc	ra,0x1
      ae:	df0080e7          	jalr	-528(ra) # e9a <chdir>
      b2:	c11d                	beqz	a0,d8 <go+0x60>
      b4:	f0ca                	sd	s2,96(sp)
      b6:	ecce                	sd	s3,88(sp)
      b8:	e8d2                	sd	s4,80(sp)
      ba:	e0da                	sd	s6,64(sp)
      bc:	fc5e                	sd	s7,56(sp)
    printf("grind: chdir grindir failed\n");
      be:	00001517          	auipc	a0,0x1
      c2:	53250513          	add	a0,a0,1330 # 15f0 <malloc+0x10e>
      c6:	00001097          	auipc	ra,0x1
      ca:	19c080e7          	jalr	412(ra) # 1262 <printf>
    exit(1);
      ce:	4505                	li	a0,1
      d0:	00001097          	auipc	ra,0x1
      d4:	d5a080e7          	jalr	-678(ra) # e2a <exit>
      d8:	f0ca                	sd	s2,96(sp)
      da:	ecce                	sd	s3,88(sp)
      dc:	e8d2                	sd	s4,80(sp)
      de:	e0da                	sd	s6,64(sp)
      e0:	fc5e                	sd	s7,56(sp)
  }
  chdir("/");
      e2:	00001517          	auipc	a0,0x1
      e6:	53650513          	add	a0,a0,1334 # 1618 <malloc+0x136>
      ea:	00001097          	auipc	ra,0x1
      ee:	db0080e7          	jalr	-592(ra) # e9a <chdir>
      f2:	00001997          	auipc	s3,0x1
      f6:	53698993          	add	s3,s3,1334 # 1628 <malloc+0x146>
      fa:	c489                	beqz	s1,104 <go+0x8c>
      fc:	00001997          	auipc	s3,0x1
     100:	52498993          	add	s3,s3,1316 # 1620 <malloc+0x13e>
  uint64 iters = 0;
     104:	4481                	li	s1,0
  int fd = -1;
     106:	5a7d                	li	s4,-1
     108:	00001917          	auipc	s2,0x1
     10c:	7e890913          	add	s2,s2,2024 # 18f0 <malloc+0x40e>
      close(fd);
      fd = open("/./grindir/./../b", O_CREATE|O_RDWR);
    } else if(what == 7){
      write(fd, buf, sizeof(buf));
    } else if(what == 8){
      read(fd, buf, sizeof(buf));
     110:	00002b17          	auipc	s6,0x2
     114:	8c0b0b13          	add	s6,s6,-1856 # 19d0 <buf.0>
     118:	a839                	j	136 <go+0xbe>
      close(open("grindir/../a", O_CREATE|O_RDWR));
     11a:	20200593          	li	a1,514
     11e:	00001517          	auipc	a0,0x1
     122:	51250513          	add	a0,a0,1298 # 1630 <malloc+0x14e>
     126:	00001097          	auipc	ra,0x1
     12a:	d44080e7          	jalr	-700(ra) # e6a <open>
     12e:	00001097          	auipc	ra,0x1
     132:	d24080e7          	jalr	-732(ra) # e52 <close>
    iters++;
     136:	0485                	add	s1,s1,1
    if((iters % 500) == 0)
     138:	1f400793          	li	a5,500
     13c:	02f4f7b3          	remu	a5,s1,a5
     140:	eb81                	bnez	a5,150 <go+0xd8>
      write(1, which_child?"B":"A", 1);
     142:	4605                	li	a2,1
     144:	85ce                	mv	a1,s3
     146:	4505                	li	a0,1
     148:	00001097          	auipc	ra,0x1
     14c:	d02080e7          	jalr	-766(ra) # e4a <write>
    int what = rand() % 23;
     150:	00000097          	auipc	ra,0x0
     154:	f08080e7          	jalr	-248(ra) # 58 <rand>
     158:	47dd                	li	a5,23
     15a:	02f5653b          	remw	a0,a0,a5
     15e:	0005071b          	sext.w	a4,a0
     162:	47d9                	li	a5,22
     164:	fce7e9e3          	bltu	a5,a4,136 <go+0xbe>
     168:	02051793          	sll	a5,a0,0x20
     16c:	01e7d513          	srl	a0,a5,0x1e
     170:	954a                	add	a0,a0,s2
     172:	411c                	lw	a5,0(a0)
     174:	97ca                	add	a5,a5,s2
     176:	8782                	jr	a5
      close(open("grindir/../grindir/../b", O_CREATE|O_RDWR));
     178:	20200593          	li	a1,514
     17c:	00001517          	auipc	a0,0x1
     180:	4c450513          	add	a0,a0,1220 # 1640 <malloc+0x15e>
     184:	00001097          	auipc	ra,0x1
     188:	ce6080e7          	jalr	-794(ra) # e6a <open>
     18c:	00001097          	auipc	ra,0x1
     190:	cc6080e7          	jalr	-826(ra) # e52 <close>
     194:	b74d                	j	136 <go+0xbe>
      unlink("grindir/../a");
     196:	00001517          	auipc	a0,0x1
     19a:	49a50513          	add	a0,a0,1178 # 1630 <malloc+0x14e>
     19e:	00001097          	auipc	ra,0x1
     1a2:	cdc080e7          	jalr	-804(ra) # e7a <unlink>
     1a6:	bf41                	j	136 <go+0xbe>
      if(chdir("grindir") != 0){
     1a8:	00001517          	auipc	a0,0x1
     1ac:	44050513          	add	a0,a0,1088 # 15e8 <malloc+0x106>
     1b0:	00001097          	auipc	ra,0x1
     1b4:	cea080e7          	jalr	-790(ra) # e9a <chdir>
     1b8:	e115                	bnez	a0,1dc <go+0x164>
      unlink("../b");
     1ba:	00001517          	auipc	a0,0x1
     1be:	49e50513          	add	a0,a0,1182 # 1658 <malloc+0x176>
     1c2:	00001097          	auipc	ra,0x1
     1c6:	cb8080e7          	jalr	-840(ra) # e7a <unlink>
      chdir("/");
     1ca:	00001517          	auipc	a0,0x1
     1ce:	44e50513          	add	a0,a0,1102 # 1618 <malloc+0x136>
     1d2:	00001097          	auipc	ra,0x1
     1d6:	cc8080e7          	jalr	-824(ra) # e9a <chdir>
     1da:	bfb1                	j	136 <go+0xbe>
        printf("grind: chdir grindir failed\n");
     1dc:	00001517          	auipc	a0,0x1
     1e0:	41450513          	add	a0,a0,1044 # 15f0 <malloc+0x10e>
     1e4:	00001097          	auipc	ra,0x1
     1e8:	07e080e7          	jalr	126(ra) # 1262 <printf>
        exit(1);
     1ec:	4505                	li	a0,1
     1ee:	00001097          	auipc	ra,0x1
     1f2:	c3c080e7          	jalr	-964(ra) # e2a <exit>
      close(fd);
     1f6:	8552                	mv	a0,s4
     1f8:	00001097          	auipc	ra,0x1
     1fc:	c5a080e7          	jalr	-934(ra) # e52 <close>
      fd = open("/grindir/../a", O_CREATE|O_RDWR);
     200:	20200593          	li	a1,514
     204:	00001517          	auipc	a0,0x1
     208:	45c50513          	add	a0,a0,1116 # 1660 <malloc+0x17e>
     20c:	00001097          	auipc	ra,0x1
     210:	c5e080e7          	jalr	-930(ra) # e6a <open>
     214:	8a2a                	mv	s4,a0
     216:	b705                	j	136 <go+0xbe>
      close(fd);
     218:	8552                	mv	a0,s4
     21a:	00001097          	auipc	ra,0x1
     21e:	c38080e7          	jalr	-968(ra) # e52 <close>
      fd = open("/./grindir/./../b", O_CREATE|O_RDWR);
     222:	20200593          	li	a1,514
     226:	00001517          	auipc	a0,0x1
     22a:	44a50513          	add	a0,a0,1098 # 1670 <malloc+0x18e>
     22e:	00001097          	auipc	ra,0x1
     232:	c3c080e7          	jalr	-964(ra) # e6a <open>
     236:	8a2a                	mv	s4,a0
     238:	bdfd                	j	136 <go+0xbe>
      write(fd, buf, sizeof(buf));
     23a:	3e700613          	li	a2,999
     23e:	85da                	mv	a1,s6
     240:	8552                	mv	a0,s4
     242:	00001097          	auipc	ra,0x1
     246:	c08080e7          	jalr	-1016(ra) # e4a <write>
     24a:	b5f5                	j	136 <go+0xbe>
      read(fd, buf, sizeof(buf));
     24c:	3e700613          	li	a2,999
     250:	85da                	mv	a1,s6
     252:	8552                	mv	a0,s4
     254:	00001097          	auipc	ra,0x1
     258:	bee080e7          	jalr	-1042(ra) # e42 <read>
     25c:	bde9                	j	136 <go+0xbe>
    } else if(what == 9){
      mkdir("grindir/../a");
     25e:	00001517          	auipc	a0,0x1
     262:	3d250513          	add	a0,a0,978 # 1630 <malloc+0x14e>
     266:	00001097          	auipc	ra,0x1
     26a:	c2c080e7          	jalr	-980(ra) # e92 <mkdir>
      close(open("a/../a/./a", O_CREATE|O_RDWR));
     26e:	20200593          	li	a1,514
     272:	00001517          	auipc	a0,0x1
     276:	41650513          	add	a0,a0,1046 # 1688 <malloc+0x1a6>
     27a:	00001097          	auipc	ra,0x1
     27e:	bf0080e7          	jalr	-1040(ra) # e6a <open>
     282:	00001097          	auipc	ra,0x1
     286:	bd0080e7          	jalr	-1072(ra) # e52 <close>
      unlink("a/a");
     28a:	00001517          	auipc	a0,0x1
     28e:	40e50513          	add	a0,a0,1038 # 1698 <malloc+0x1b6>
     292:	00001097          	auipc	ra,0x1
     296:	be8080e7          	jalr	-1048(ra) # e7a <unlink>
     29a:	bd71                	j	136 <go+0xbe>
    } else if(what == 10){
      mkdir("/../b");
     29c:	00001517          	auipc	a0,0x1
     2a0:	40450513          	add	a0,a0,1028 # 16a0 <malloc+0x1be>
     2a4:	00001097          	auipc	ra,0x1
     2a8:	bee080e7          	jalr	-1042(ra) # e92 <mkdir>
      close(open("grindir/../b/b", O_CREATE|O_RDWR));
     2ac:	20200593          	li	a1,514
     2b0:	00001517          	auipc	a0,0x1
     2b4:	3f850513          	add	a0,a0,1016 # 16a8 <malloc+0x1c6>
     2b8:	00001097          	auipc	ra,0x1
     2bc:	bb2080e7          	jalr	-1102(ra) # e6a <open>
     2c0:	00001097          	auipc	ra,0x1
     2c4:	b92080e7          	jalr	-1134(ra) # e52 <close>
      unlink("b/b");
     2c8:	00001517          	auipc	a0,0x1
     2cc:	3f050513          	add	a0,a0,1008 # 16b8 <malloc+0x1d6>
     2d0:	00001097          	auipc	ra,0x1
     2d4:	baa080e7          	jalr	-1110(ra) # e7a <unlink>
     2d8:	bdb9                	j	136 <go+0xbe>
    } else if(what == 11){
      unlink("b");
     2da:	00001517          	auipc	a0,0x1
     2de:	3e650513          	add	a0,a0,998 # 16c0 <malloc+0x1de>
     2e2:	00001097          	auipc	ra,0x1
     2e6:	b98080e7          	jalr	-1128(ra) # e7a <unlink>
      link("../grindir/./../a", "../b");
     2ea:	00001597          	auipc	a1,0x1
     2ee:	36e58593          	add	a1,a1,878 # 1658 <malloc+0x176>
     2f2:	00001517          	auipc	a0,0x1
     2f6:	3d650513          	add	a0,a0,982 # 16c8 <malloc+0x1e6>
     2fa:	00001097          	auipc	ra,0x1
     2fe:	b90080e7          	jalr	-1136(ra) # e8a <link>
     302:	bd15                	j	136 <go+0xbe>
    } else if(what == 12){
      unlink("../grindir/../a");
     304:	00001517          	auipc	a0,0x1
     308:	3dc50513          	add	a0,a0,988 # 16e0 <malloc+0x1fe>
     30c:	00001097          	auipc	ra,0x1
     310:	b6e080e7          	jalr	-1170(ra) # e7a <unlink>
      link(".././b", "/grindir/../a");
     314:	00001597          	auipc	a1,0x1
     318:	34c58593          	add	a1,a1,844 # 1660 <malloc+0x17e>
     31c:	00001517          	auipc	a0,0x1
     320:	3d450513          	add	a0,a0,980 # 16f0 <malloc+0x20e>
     324:	00001097          	auipc	ra,0x1
     328:	b66080e7          	jalr	-1178(ra) # e8a <link>
     32c:	b529                	j	136 <go+0xbe>
    } else if(what == 13){
      int pid = fork();
     32e:	00001097          	auipc	ra,0x1
     332:	af4080e7          	jalr	-1292(ra) # e22 <fork>
      if(pid == 0){
     336:	c909                	beqz	a0,348 <go+0x2d0>
        exit(0);
      } else if(pid < 0){
     338:	00054c63          	bltz	a0,350 <go+0x2d8>
        printf("grind: fork failed\n");
        exit(1);
      }
      wait(0);
     33c:	4501                	li	a0,0
     33e:	00001097          	auipc	ra,0x1
     342:	af4080e7          	jalr	-1292(ra) # e32 <wait>
     346:	bbc5                	j	136 <go+0xbe>
        exit(0);
     348:	00001097          	auipc	ra,0x1
     34c:	ae2080e7          	jalr	-1310(ra) # e2a <exit>
        printf("grind: fork failed\n");
     350:	00001517          	auipc	a0,0x1
     354:	3a850513          	add	a0,a0,936 # 16f8 <malloc+0x216>
     358:	00001097          	auipc	ra,0x1
     35c:	f0a080e7          	jalr	-246(ra) # 1262 <printf>
        exit(1);
     360:	4505                	li	a0,1
     362:	00001097          	auipc	ra,0x1
     366:	ac8080e7          	jalr	-1336(ra) # e2a <exit>
    } else if(what == 14){
      int pid = fork();
     36a:	00001097          	auipc	ra,0x1
     36e:	ab8080e7          	jalr	-1352(ra) # e22 <fork>
      if(pid == 0){
     372:	c909                	beqz	a0,384 <go+0x30c>
        fork();
        fork();
        exit(0);
      } else if(pid < 0){
     374:	02054563          	bltz	a0,39e <go+0x326>
        printf("grind: fork failed\n");
        exit(1);
      }
      wait(0);
     378:	4501                	li	a0,0
     37a:	00001097          	auipc	ra,0x1
     37e:	ab8080e7          	jalr	-1352(ra) # e32 <wait>
     382:	bb55                	j	136 <go+0xbe>
        fork();
     384:	00001097          	auipc	ra,0x1
     388:	a9e080e7          	jalr	-1378(ra) # e22 <fork>
        fork();
     38c:	00001097          	auipc	ra,0x1
     390:	a96080e7          	jalr	-1386(ra) # e22 <fork>
        exit(0);
     394:	4501                	li	a0,0
     396:	00001097          	auipc	ra,0x1
     39a:	a94080e7          	jalr	-1388(ra) # e2a <exit>
        printf("grind: fork failed\n");
     39e:	00001517          	auipc	a0,0x1
     3a2:	35a50513          	add	a0,a0,858 # 16f8 <malloc+0x216>
     3a6:	00001097          	auipc	ra,0x1
     3aa:	ebc080e7          	jalr	-324(ra) # 1262 <printf>
        exit(1);
     3ae:	4505                	li	a0,1
     3b0:	00001097          	auipc	ra,0x1
     3b4:	a7a080e7          	jalr	-1414(ra) # e2a <exit>
    } else if(what == 15){
      sbrk(6011);
     3b8:	6505                	lui	a0,0x1
     3ba:	77b50513          	add	a0,a0,1915 # 177b <malloc+0x299>
     3be:	00001097          	auipc	ra,0x1
     3c2:	af4080e7          	jalr	-1292(ra) # eb2 <sbrk>
     3c6:	bb85                	j	136 <go+0xbe>
    } else if(what == 16){
      if(sbrk(0) > break0)
     3c8:	4501                	li	a0,0
     3ca:	00001097          	auipc	ra,0x1
     3ce:	ae8080e7          	jalr	-1304(ra) # eb2 <sbrk>
     3d2:	d6aaf2e3          	bgeu	s5,a0,136 <go+0xbe>
        sbrk(-(sbrk(0) - break0));
     3d6:	4501                	li	a0,0
     3d8:	00001097          	auipc	ra,0x1
     3dc:	ada080e7          	jalr	-1318(ra) # eb2 <sbrk>
     3e0:	40aa853b          	subw	a0,s5,a0
     3e4:	00001097          	auipc	ra,0x1
     3e8:	ace080e7          	jalr	-1330(ra) # eb2 <sbrk>
     3ec:	b3a9                	j	136 <go+0xbe>
    } else if(what == 17){
      int pid = fork();
     3ee:	00001097          	auipc	ra,0x1
     3f2:	a34080e7          	jalr	-1484(ra) # e22 <fork>
     3f6:	8baa                	mv	s7,a0
      if(pid == 0){
     3f8:	c51d                	beqz	a0,426 <go+0x3ae>
        close(open("a", O_CREATE|O_RDWR));
        exit(0);
      } else if(pid < 0){
     3fa:	04054963          	bltz	a0,44c <go+0x3d4>
        printf("grind: fork failed\n");
        exit(1);
      }
      if(chdir("../grindir/..") != 0){
     3fe:	00001517          	auipc	a0,0x1
     402:	31a50513          	add	a0,a0,794 # 1718 <malloc+0x236>
     406:	00001097          	auipc	ra,0x1
     40a:	a94080e7          	jalr	-1388(ra) # e9a <chdir>
     40e:	ed21                	bnez	a0,466 <go+0x3ee>
        printf("grind: chdir failed\n");
        exit(1);
      }
      kill(pid);
     410:	855e                	mv	a0,s7
     412:	00001097          	auipc	ra,0x1
     416:	a48080e7          	jalr	-1464(ra) # e5a <kill>
      wait(0);
     41a:	4501                	li	a0,0
     41c:	00001097          	auipc	ra,0x1
     420:	a16080e7          	jalr	-1514(ra) # e32 <wait>
     424:	bb09                	j	136 <go+0xbe>
        close(open("a", O_CREATE|O_RDWR));
     426:	20200593          	li	a1,514
     42a:	00001517          	auipc	a0,0x1
     42e:	2e650513          	add	a0,a0,742 # 1710 <malloc+0x22e>
     432:	00001097          	auipc	ra,0x1
     436:	a38080e7          	jalr	-1480(ra) # e6a <open>
     43a:	00001097          	auipc	ra,0x1
     43e:	a18080e7          	jalr	-1512(ra) # e52 <close>
        exit(0);
     442:	4501                	li	a0,0
     444:	00001097          	auipc	ra,0x1
     448:	9e6080e7          	jalr	-1562(ra) # e2a <exit>
        printf("grind: fork failed\n");
     44c:	00001517          	auipc	a0,0x1
     450:	2ac50513          	add	a0,a0,684 # 16f8 <malloc+0x216>
     454:	00001097          	auipc	ra,0x1
     458:	e0e080e7          	jalr	-498(ra) # 1262 <printf>
        exit(1);
     45c:	4505                	li	a0,1
     45e:	00001097          	auipc	ra,0x1
     462:	9cc080e7          	jalr	-1588(ra) # e2a <exit>
        printf("grind: chdir failed\n");
     466:	00001517          	auipc	a0,0x1
     46a:	2c250513          	add	a0,a0,706 # 1728 <malloc+0x246>
     46e:	00001097          	auipc	ra,0x1
     472:	df4080e7          	jalr	-524(ra) # 1262 <printf>
        exit(1);
     476:	4505                	li	a0,1
     478:	00001097          	auipc	ra,0x1
     47c:	9b2080e7          	jalr	-1614(ra) # e2a <exit>
    } else if(what == 18){
      int pid = fork();
     480:	00001097          	auipc	ra,0x1
     484:	9a2080e7          	jalr	-1630(ra) # e22 <fork>
      if(pid == 0){
     488:	c909                	beqz	a0,49a <go+0x422>
        kill(getpid());
        exit(0);
      } else if(pid < 0){
     48a:	02054563          	bltz	a0,4b4 <go+0x43c>
        printf("grind: fork failed\n");
        exit(1);
      }
      wait(0);
     48e:	4501                	li	a0,0
     490:	00001097          	auipc	ra,0x1
     494:	9a2080e7          	jalr	-1630(ra) # e32 <wait>
     498:	b979                	j	136 <go+0xbe>
        kill(getpid());
     49a:	00001097          	auipc	ra,0x1
     49e:	a10080e7          	jalr	-1520(ra) # eaa <getpid>
     4a2:	00001097          	auipc	ra,0x1
     4a6:	9b8080e7          	jalr	-1608(ra) # e5a <kill>
        exit(0);
     4aa:	4501                	li	a0,0
     4ac:	00001097          	auipc	ra,0x1
     4b0:	97e080e7          	jalr	-1666(ra) # e2a <exit>
        printf("grind: fork failed\n");
     4b4:	00001517          	auipc	a0,0x1
     4b8:	24450513          	add	a0,a0,580 # 16f8 <malloc+0x216>
     4bc:	00001097          	auipc	ra,0x1
     4c0:	da6080e7          	jalr	-602(ra) # 1262 <printf>
        exit(1);
     4c4:	4505                	li	a0,1
     4c6:	00001097          	auipc	ra,0x1
     4ca:	964080e7          	jalr	-1692(ra) # e2a <exit>
    } else if(what == 19){
      int fds[2];
      if(pipe(fds) < 0){
     4ce:	f9840513          	add	a0,s0,-104
     4d2:	00001097          	auipc	ra,0x1
     4d6:	968080e7          	jalr	-1688(ra) # e3a <pipe>
     4da:	02054b63          	bltz	a0,510 <go+0x498>
        printf("grind: pipe failed\n");
        exit(1);
      }
      int pid = fork();
     4de:	00001097          	auipc	ra,0x1
     4e2:	944080e7          	jalr	-1724(ra) # e22 <fork>
      if(pid == 0){
     4e6:	c131                	beqz	a0,52a <go+0x4b2>
          printf("grind: pipe write failed\n");
        char c;
        if(read(fds[0], &c, 1) != 1)
          printf("grind: pipe read failed\n");
        exit(0);
      } else if(pid < 0){
     4e8:	0a054a63          	bltz	a0,59c <go+0x524>
        printf("grind: fork failed\n");
        exit(1);
      }
      close(fds[0]);
     4ec:	f9842503          	lw	a0,-104(s0)
     4f0:	00001097          	auipc	ra,0x1
     4f4:	962080e7          	jalr	-1694(ra) # e52 <close>
      close(fds[1]);
     4f8:	f9c42503          	lw	a0,-100(s0)
     4fc:	00001097          	auipc	ra,0x1
     500:	956080e7          	jalr	-1706(ra) # e52 <close>
      wait(0);
     504:	4501                	li	a0,0
     506:	00001097          	auipc	ra,0x1
     50a:	92c080e7          	jalr	-1748(ra) # e32 <wait>
     50e:	b125                	j	136 <go+0xbe>
        printf("grind: pipe failed\n");
     510:	00001517          	auipc	a0,0x1
     514:	23050513          	add	a0,a0,560 # 1740 <malloc+0x25e>
     518:	00001097          	auipc	ra,0x1
     51c:	d4a080e7          	jalr	-694(ra) # 1262 <printf>
        exit(1);
     520:	4505                	li	a0,1
     522:	00001097          	auipc	ra,0x1
     526:	908080e7          	jalr	-1784(ra) # e2a <exit>
        fork();
     52a:	00001097          	auipc	ra,0x1
     52e:	8f8080e7          	jalr	-1800(ra) # e22 <fork>
        fork();
     532:	00001097          	auipc	ra,0x1
     536:	8f0080e7          	jalr	-1808(ra) # e22 <fork>
        if(write(fds[1], "x", 1) != 1)
     53a:	4605                	li	a2,1
     53c:	00001597          	auipc	a1,0x1
     540:	21c58593          	add	a1,a1,540 # 1758 <malloc+0x276>
     544:	f9c42503          	lw	a0,-100(s0)
     548:	00001097          	auipc	ra,0x1
     54c:	902080e7          	jalr	-1790(ra) # e4a <write>
     550:	4785                	li	a5,1
     552:	02f51363          	bne	a0,a5,578 <go+0x500>
        if(read(fds[0], &c, 1) != 1)
     556:	4605                	li	a2,1
     558:	f9040593          	add	a1,s0,-112
     55c:	f9842503          	lw	a0,-104(s0)
     560:	00001097          	auipc	ra,0x1
     564:	8e2080e7          	jalr	-1822(ra) # e42 <read>
     568:	4785                	li	a5,1
     56a:	02f51063          	bne	a0,a5,58a <go+0x512>
        exit(0);
     56e:	4501                	li	a0,0
     570:	00001097          	auipc	ra,0x1
     574:	8ba080e7          	jalr	-1862(ra) # e2a <exit>
          printf("grind: pipe write failed\n");
     578:	00001517          	auipc	a0,0x1
     57c:	1e850513          	add	a0,a0,488 # 1760 <malloc+0x27e>
     580:	00001097          	auipc	ra,0x1
     584:	ce2080e7          	jalr	-798(ra) # 1262 <printf>
     588:	b7f9                	j	556 <go+0x4de>
          printf("grind: pipe read failed\n");
     58a:	00001517          	auipc	a0,0x1
     58e:	1f650513          	add	a0,a0,502 # 1780 <malloc+0x29e>
     592:	00001097          	auipc	ra,0x1
     596:	cd0080e7          	jalr	-816(ra) # 1262 <printf>
     59a:	bfd1                	j	56e <go+0x4f6>
        printf("grind: fork failed\n");
     59c:	00001517          	auipc	a0,0x1
     5a0:	15c50513          	add	a0,a0,348 # 16f8 <malloc+0x216>
     5a4:	00001097          	auipc	ra,0x1
     5a8:	cbe080e7          	jalr	-834(ra) # 1262 <printf>
        exit(1);
     5ac:	4505                	li	a0,1
     5ae:	00001097          	auipc	ra,0x1
     5b2:	87c080e7          	jalr	-1924(ra) # e2a <exit>
    } else if(what == 20){
      int pid = fork();
     5b6:	00001097          	auipc	ra,0x1
     5ba:	86c080e7          	jalr	-1940(ra) # e22 <fork>
      if(pid == 0){
     5be:	c909                	beqz	a0,5d0 <go+0x558>
        chdir("a");
        unlink("../a");
        fd = open("x", O_CREATE|O_RDWR);
        unlink("x");
        exit(0);
      } else if(pid < 0){
     5c0:	06054f63          	bltz	a0,63e <go+0x5c6>
        printf("grind: fork failed\n");
        exit(1);
      }
      wait(0);
     5c4:	4501                	li	a0,0
     5c6:	00001097          	auipc	ra,0x1
     5ca:	86c080e7          	jalr	-1940(ra) # e32 <wait>
     5ce:	b6a5                	j	136 <go+0xbe>
        unlink("a");
     5d0:	00001517          	auipc	a0,0x1
     5d4:	14050513          	add	a0,a0,320 # 1710 <malloc+0x22e>
     5d8:	00001097          	auipc	ra,0x1
     5dc:	8a2080e7          	jalr	-1886(ra) # e7a <unlink>
        mkdir("a");
     5e0:	00001517          	auipc	a0,0x1
     5e4:	13050513          	add	a0,a0,304 # 1710 <malloc+0x22e>
     5e8:	00001097          	auipc	ra,0x1
     5ec:	8aa080e7          	jalr	-1878(ra) # e92 <mkdir>
        chdir("a");
     5f0:	00001517          	auipc	a0,0x1
     5f4:	12050513          	add	a0,a0,288 # 1710 <malloc+0x22e>
     5f8:	00001097          	auipc	ra,0x1
     5fc:	8a2080e7          	jalr	-1886(ra) # e9a <chdir>
        unlink("../a");
     600:	00001517          	auipc	a0,0x1
     604:	1a050513          	add	a0,a0,416 # 17a0 <malloc+0x2be>
     608:	00001097          	auipc	ra,0x1
     60c:	872080e7          	jalr	-1934(ra) # e7a <unlink>
        fd = open("x", O_CREATE|O_RDWR);
     610:	20200593          	li	a1,514
     614:	00001517          	auipc	a0,0x1
     618:	14450513          	add	a0,a0,324 # 1758 <malloc+0x276>
     61c:	00001097          	auipc	ra,0x1
     620:	84e080e7          	jalr	-1970(ra) # e6a <open>
        unlink("x");
     624:	00001517          	auipc	a0,0x1
     628:	13450513          	add	a0,a0,308 # 1758 <malloc+0x276>
     62c:	00001097          	auipc	ra,0x1
     630:	84e080e7          	jalr	-1970(ra) # e7a <unlink>
        exit(0);
     634:	4501                	li	a0,0
     636:	00000097          	auipc	ra,0x0
     63a:	7f4080e7          	jalr	2036(ra) # e2a <exit>
        printf("grind: fork failed\n");
     63e:	00001517          	auipc	a0,0x1
     642:	0ba50513          	add	a0,a0,186 # 16f8 <malloc+0x216>
     646:	00001097          	auipc	ra,0x1
     64a:	c1c080e7          	jalr	-996(ra) # 1262 <printf>
        exit(1);
     64e:	4505                	li	a0,1
     650:	00000097          	auipc	ra,0x0
     654:	7da080e7          	jalr	2010(ra) # e2a <exit>
    } else if(what == 21){
      unlink("c");
     658:	00001517          	auipc	a0,0x1
     65c:	15050513          	add	a0,a0,336 # 17a8 <malloc+0x2c6>
     660:	00001097          	auipc	ra,0x1
     664:	81a080e7          	jalr	-2022(ra) # e7a <unlink>
      // should always succeed. check that there are free i-nodes,
      // file descriptors, blocks.
      int fd1 = open("c", O_CREATE|O_RDWR);
     668:	20200593          	li	a1,514
     66c:	00001517          	auipc	a0,0x1
     670:	13c50513          	add	a0,a0,316 # 17a8 <malloc+0x2c6>
     674:	00000097          	auipc	ra,0x0
     678:	7f6080e7          	jalr	2038(ra) # e6a <open>
     67c:	8baa                	mv	s7,a0
      if(fd1 < 0){
     67e:	04054f63          	bltz	a0,6dc <go+0x664>
        printf("grind: create c failed\n");
        exit(1);
      }
      if(write(fd1, "x", 1) != 1){
     682:	4605                	li	a2,1
     684:	00001597          	auipc	a1,0x1
     688:	0d458593          	add	a1,a1,212 # 1758 <malloc+0x276>
     68c:	00000097          	auipc	ra,0x0
     690:	7be080e7          	jalr	1982(ra) # e4a <write>
     694:	4785                	li	a5,1
     696:	06f51063          	bne	a0,a5,6f6 <go+0x67e>
        printf("grind: write c failed\n");
        exit(1);
      }
      struct stat st;
      if(fstat(fd1, &st) != 0){
     69a:	f9840593          	add	a1,s0,-104
     69e:	855e                	mv	a0,s7
     6a0:	00000097          	auipc	ra,0x0
     6a4:	7e2080e7          	jalr	2018(ra) # e82 <fstat>
     6a8:	e525                	bnez	a0,710 <go+0x698>
        printf("grind: fstat failed\n");
        exit(1);
      }
      if(st.size != 1){
     6aa:	fa843583          	ld	a1,-88(s0)
     6ae:	4785                	li	a5,1
     6b0:	06f59d63          	bne	a1,a5,72a <go+0x6b2>
        printf("grind: fstat reports wrong size %d\n", (int)st.size);
        exit(1);
      }
      if(st.ino > 200){
     6b4:	f9c42583          	lw	a1,-100(s0)
     6b8:	0c800793          	li	a5,200
     6bc:	08b7e563          	bltu	a5,a1,746 <go+0x6ce>
        printf("grind: fstat reports crazy i-number %d\n", st.ino);
        exit(1);
      }
      close(fd1);
     6c0:	855e                	mv	a0,s7
     6c2:	00000097          	auipc	ra,0x0
     6c6:	790080e7          	jalr	1936(ra) # e52 <close>
      unlink("c");
     6ca:	00001517          	auipc	a0,0x1
     6ce:	0de50513          	add	a0,a0,222 # 17a8 <malloc+0x2c6>
     6d2:	00000097          	auipc	ra,0x0
     6d6:	7a8080e7          	jalr	1960(ra) # e7a <unlink>
     6da:	bcb1                	j	136 <go+0xbe>
        printf("grind: create c failed\n");
     6dc:	00001517          	auipc	a0,0x1
     6e0:	0d450513          	add	a0,a0,212 # 17b0 <malloc+0x2ce>
     6e4:	00001097          	auipc	ra,0x1
     6e8:	b7e080e7          	jalr	-1154(ra) # 1262 <printf>
        exit(1);
     6ec:	4505                	li	a0,1
     6ee:	00000097          	auipc	ra,0x0
     6f2:	73c080e7          	jalr	1852(ra) # e2a <exit>
        printf("grind: write c failed\n");
     6f6:	00001517          	auipc	a0,0x1
     6fa:	0d250513          	add	a0,a0,210 # 17c8 <malloc+0x2e6>
     6fe:	00001097          	auipc	ra,0x1
     702:	b64080e7          	jalr	-1180(ra) # 1262 <printf>
        exit(1);
     706:	4505                	li	a0,1
     708:	00000097          	auipc	ra,0x0
     70c:	722080e7          	jalr	1826(ra) # e2a <exit>
        printf("grind: fstat failed\n");
     710:	00001517          	auipc	a0,0x1
     714:	0d050513          	add	a0,a0,208 # 17e0 <malloc+0x2fe>
     718:	00001097          	auipc	ra,0x1
     71c:	b4a080e7          	jalr	-1206(ra) # 1262 <printf>
        exit(1);
     720:	4505                	li	a0,1
     722:	00000097          	auipc	ra,0x0
     726:	708080e7          	jalr	1800(ra) # e2a <exit>
        printf("grind: fstat reports wrong size %d\n", (int)st.size);
     72a:	2581                	sext.w	a1,a1
     72c:	00001517          	auipc	a0,0x1
     730:	0cc50513          	add	a0,a0,204 # 17f8 <malloc+0x316>
     734:	00001097          	auipc	ra,0x1
     738:	b2e080e7          	jalr	-1234(ra) # 1262 <printf>
        exit(1);
     73c:	4505                	li	a0,1
     73e:	00000097          	auipc	ra,0x0
     742:	6ec080e7          	jalr	1772(ra) # e2a <exit>
        printf("grind: fstat reports crazy i-number %d\n", st.ino);
     746:	00001517          	auipc	a0,0x1
     74a:	0da50513          	add	a0,a0,218 # 1820 <malloc+0x33e>
     74e:	00001097          	auipc	ra,0x1
     752:	b14080e7          	jalr	-1260(ra) # 1262 <printf>
        exit(1);
     756:	4505                	li	a0,1
     758:	00000097          	auipc	ra,0x0
     75c:	6d2080e7          	jalr	1746(ra) # e2a <exit>
    } else if(what == 22){
      // echo hi | cat
      int aa[2], bb[2];
      if(pipe(aa) < 0){
     760:	f8840513          	add	a0,s0,-120
     764:	00000097          	auipc	ra,0x0
     768:	6d6080e7          	jalr	1750(ra) # e3a <pipe>
     76c:	0e054963          	bltz	a0,85e <go+0x7e6>
        fprintf(2, "grind: pipe failed\n");
        exit(1);
      }
      if(pipe(bb) < 0){
     770:	f9040513          	add	a0,s0,-112
     774:	00000097          	auipc	ra,0x0
     778:	6c6080e7          	jalr	1734(ra) # e3a <pipe>
     77c:	0e054f63          	bltz	a0,87a <go+0x802>
        fprintf(2, "grind: pipe failed\n");
        exit(1);
      }
      int pid1 = fork();
     780:	00000097          	auipc	ra,0x0
     784:	6a2080e7          	jalr	1698(ra) # e22 <fork>
      if(pid1 == 0){
     788:	10050763          	beqz	a0,896 <go+0x81e>
        close(aa[1]);
        char *args[3] = { "echo", "hi", 0 };
        exec("grindir/../echo", args);
        fprintf(2, "grind: echo: not found\n");
        exit(2);
      } else if(pid1 < 0){
     78c:	1a054f63          	bltz	a0,94a <go+0x8d2>
        fprintf(2, "grind: fork failed\n");
        exit(3);
      }
      int pid2 = fork();
     790:	00000097          	auipc	ra,0x0
     794:	692080e7          	jalr	1682(ra) # e22 <fork>
      if(pid2 == 0){
     798:	1c050763          	beqz	a0,966 <go+0x8ee>
        close(bb[1]);
        char *args[2] = { "cat", 0 };
        exec("/cat", args);
        fprintf(2, "grind: cat: not found\n");
        exit(6);
      } else if(pid2 < 0){
     79c:	2a054363          	bltz	a0,a42 <go+0x9ca>
        fprintf(2, "grind: fork failed\n");
        exit(7);
      }
      close(aa[0]);
     7a0:	f8842503          	lw	a0,-120(s0)
     7a4:	00000097          	auipc	ra,0x0
     7a8:	6ae080e7          	jalr	1710(ra) # e52 <close>
      close(aa[1]);
     7ac:	f8c42503          	lw	a0,-116(s0)
     7b0:	00000097          	auipc	ra,0x0
     7b4:	6a2080e7          	jalr	1698(ra) # e52 <close>
      close(bb[1]);
     7b8:	f9442503          	lw	a0,-108(s0)
     7bc:	00000097          	auipc	ra,0x0
     7c0:	696080e7          	jalr	1686(ra) # e52 <close>
      char buf[3] = { 0, 0, 0 };
     7c4:	f8041023          	sh	zero,-128(s0)
     7c8:	f8040123          	sb	zero,-126(s0)
      read(bb[0], buf+0, 1);
     7cc:	4605                	li	a2,1
     7ce:	f8040593          	add	a1,s0,-128
     7d2:	f9042503          	lw	a0,-112(s0)
     7d6:	00000097          	auipc	ra,0x0
     7da:	66c080e7          	jalr	1644(ra) # e42 <read>
      read(bb[0], buf+1, 1);
     7de:	4605                	li	a2,1
     7e0:	f8140593          	add	a1,s0,-127
     7e4:	f9042503          	lw	a0,-112(s0)
     7e8:	00000097          	auipc	ra,0x0
     7ec:	65a080e7          	jalr	1626(ra) # e42 <read>
      close(bb[0]);
     7f0:	f9042503          	lw	a0,-112(s0)
     7f4:	00000097          	auipc	ra,0x0
     7f8:	65e080e7          	jalr	1630(ra) # e52 <close>
      int st1, st2;
      wait(&st1);
     7fc:	f8440513          	add	a0,s0,-124
     800:	00000097          	auipc	ra,0x0
     804:	632080e7          	jalr	1586(ra) # e32 <wait>
      wait(&st2);
     808:	f9840513          	add	a0,s0,-104
     80c:	00000097          	auipc	ra,0x0
     810:	626080e7          	jalr	1574(ra) # e32 <wait>
      if(st1 != 0 || st2 != 0 || strcmp(buf, "hi") != 0){
     814:	f8442783          	lw	a5,-124(s0)
     818:	f9842703          	lw	a4,-104(s0)
     81c:	8fd9                	or	a5,a5,a4
     81e:	ef89                	bnez	a5,838 <go+0x7c0>
     820:	00001597          	auipc	a1,0x1
     824:	04858593          	add	a1,a1,72 # 1868 <malloc+0x386>
     828:	f8040513          	add	a0,s0,-128
     82c:	00000097          	auipc	ra,0x0
     830:	380080e7          	jalr	896(ra) # bac <strcmp>
     834:	900501e3          	beqz	a0,136 <go+0xbe>
        printf("grind: exec pipeline failed %d %d \"%s\"\n", st1, st2, buf);
     838:	f8040693          	add	a3,s0,-128
     83c:	f9842603          	lw	a2,-104(s0)
     840:	f8442583          	lw	a1,-124(s0)
     844:	00001517          	auipc	a0,0x1
     848:	07c50513          	add	a0,a0,124 # 18c0 <malloc+0x3de>
     84c:	00001097          	auipc	ra,0x1
     850:	a16080e7          	jalr	-1514(ra) # 1262 <printf>
        exit(1);
     854:	4505                	li	a0,1
     856:	00000097          	auipc	ra,0x0
     85a:	5d4080e7          	jalr	1492(ra) # e2a <exit>
        fprintf(2, "grind: pipe failed\n");
     85e:	00001597          	auipc	a1,0x1
     862:	ee258593          	add	a1,a1,-286 # 1740 <malloc+0x25e>
     866:	4509                	li	a0,2
     868:	00001097          	auipc	ra,0x1
     86c:	9cc080e7          	jalr	-1588(ra) # 1234 <fprintf>
        exit(1);
     870:	4505                	li	a0,1
     872:	00000097          	auipc	ra,0x0
     876:	5b8080e7          	jalr	1464(ra) # e2a <exit>
        fprintf(2, "grind: pipe failed\n");
     87a:	00001597          	auipc	a1,0x1
     87e:	ec658593          	add	a1,a1,-314 # 1740 <malloc+0x25e>
     882:	4509                	li	a0,2
     884:	00001097          	auipc	ra,0x1
     888:	9b0080e7          	jalr	-1616(ra) # 1234 <fprintf>
        exit(1);
     88c:	4505                	li	a0,1
     88e:	00000097          	auipc	ra,0x0
     892:	59c080e7          	jalr	1436(ra) # e2a <exit>
        close(bb[0]);
     896:	f9042503          	lw	a0,-112(s0)
     89a:	00000097          	auipc	ra,0x0
     89e:	5b8080e7          	jalr	1464(ra) # e52 <close>
        close(bb[1]);
     8a2:	f9442503          	lw	a0,-108(s0)
     8a6:	00000097          	auipc	ra,0x0
     8aa:	5ac080e7          	jalr	1452(ra) # e52 <close>
        close(aa[0]);
     8ae:	f8842503          	lw	a0,-120(s0)
     8b2:	00000097          	auipc	ra,0x0
     8b6:	5a0080e7          	jalr	1440(ra) # e52 <close>
        close(1);
     8ba:	4505                	li	a0,1
     8bc:	00000097          	auipc	ra,0x0
     8c0:	596080e7          	jalr	1430(ra) # e52 <close>
        if(dup(aa[1]) != 1){
     8c4:	f8c42503          	lw	a0,-116(s0)
     8c8:	00000097          	auipc	ra,0x0
     8cc:	5da080e7          	jalr	1498(ra) # ea2 <dup>
     8d0:	4785                	li	a5,1
     8d2:	02f50063          	beq	a0,a5,8f2 <go+0x87a>
          fprintf(2, "grind: dup failed\n");
     8d6:	00001597          	auipc	a1,0x1
     8da:	f7258593          	add	a1,a1,-142 # 1848 <malloc+0x366>
     8de:	4509                	li	a0,2
     8e0:	00001097          	auipc	ra,0x1
     8e4:	954080e7          	jalr	-1708(ra) # 1234 <fprintf>
          exit(1);
     8e8:	4505                	li	a0,1
     8ea:	00000097          	auipc	ra,0x0
     8ee:	540080e7          	jalr	1344(ra) # e2a <exit>
        close(aa[1]);
     8f2:	f8c42503          	lw	a0,-116(s0)
     8f6:	00000097          	auipc	ra,0x0
     8fa:	55c080e7          	jalr	1372(ra) # e52 <close>
        char *args[3] = { "echo", "hi", 0 };
     8fe:	00001797          	auipc	a5,0x1
     902:	f6278793          	add	a5,a5,-158 # 1860 <malloc+0x37e>
     906:	f8f43c23          	sd	a5,-104(s0)
     90a:	00001797          	auipc	a5,0x1
     90e:	f5e78793          	add	a5,a5,-162 # 1868 <malloc+0x386>
     912:	faf43023          	sd	a5,-96(s0)
     916:	fa043423          	sd	zero,-88(s0)
        exec("grindir/../echo", args);
     91a:	f9840593          	add	a1,s0,-104
     91e:	00001517          	auipc	a0,0x1
     922:	f5250513          	add	a0,a0,-174 # 1870 <malloc+0x38e>
     926:	00000097          	auipc	ra,0x0
     92a:	53c080e7          	jalr	1340(ra) # e62 <exec>
        fprintf(2, "grind: echo: not found\n");
     92e:	00001597          	auipc	a1,0x1
     932:	f5258593          	add	a1,a1,-174 # 1880 <malloc+0x39e>
     936:	4509                	li	a0,2
     938:	00001097          	auipc	ra,0x1
     93c:	8fc080e7          	jalr	-1796(ra) # 1234 <fprintf>
        exit(2);
     940:	4509                	li	a0,2
     942:	00000097          	auipc	ra,0x0
     946:	4e8080e7          	jalr	1256(ra) # e2a <exit>
        fprintf(2, "grind: fork failed\n");
     94a:	00001597          	auipc	a1,0x1
     94e:	dae58593          	add	a1,a1,-594 # 16f8 <malloc+0x216>
     952:	4509                	li	a0,2
     954:	00001097          	auipc	ra,0x1
     958:	8e0080e7          	jalr	-1824(ra) # 1234 <fprintf>
        exit(3);
     95c:	450d                	li	a0,3
     95e:	00000097          	auipc	ra,0x0
     962:	4cc080e7          	jalr	1228(ra) # e2a <exit>
        close(aa[1]);
     966:	f8c42503          	lw	a0,-116(s0)
     96a:	00000097          	auipc	ra,0x0
     96e:	4e8080e7          	jalr	1256(ra) # e52 <close>
        close(bb[0]);
     972:	f9042503          	lw	a0,-112(s0)
     976:	00000097          	auipc	ra,0x0
     97a:	4dc080e7          	jalr	1244(ra) # e52 <close>
        close(0);
     97e:	4501                	li	a0,0
     980:	00000097          	auipc	ra,0x0
     984:	4d2080e7          	jalr	1234(ra) # e52 <close>
        if(dup(aa[0]) != 0){
     988:	f8842503          	lw	a0,-120(s0)
     98c:	00000097          	auipc	ra,0x0
     990:	516080e7          	jalr	1302(ra) # ea2 <dup>
     994:	cd19                	beqz	a0,9b2 <go+0x93a>
          fprintf(2, "grind: dup failed\n");
     996:	00001597          	auipc	a1,0x1
     99a:	eb258593          	add	a1,a1,-334 # 1848 <malloc+0x366>
     99e:	4509                	li	a0,2
     9a0:	00001097          	auipc	ra,0x1
     9a4:	894080e7          	jalr	-1900(ra) # 1234 <fprintf>
          exit(4);
     9a8:	4511                	li	a0,4
     9aa:	00000097          	auipc	ra,0x0
     9ae:	480080e7          	jalr	1152(ra) # e2a <exit>
        close(aa[0]);
     9b2:	f8842503          	lw	a0,-120(s0)
     9b6:	00000097          	auipc	ra,0x0
     9ba:	49c080e7          	jalr	1180(ra) # e52 <close>
        close(1);
     9be:	4505                	li	a0,1
     9c0:	00000097          	auipc	ra,0x0
     9c4:	492080e7          	jalr	1170(ra) # e52 <close>
        if(dup(bb[1]) != 1){
     9c8:	f9442503          	lw	a0,-108(s0)
     9cc:	00000097          	auipc	ra,0x0
     9d0:	4d6080e7          	jalr	1238(ra) # ea2 <dup>
     9d4:	4785                	li	a5,1
     9d6:	02f50063          	beq	a0,a5,9f6 <go+0x97e>
          fprintf(2, "grind: dup failed\n");
     9da:	00001597          	auipc	a1,0x1
     9de:	e6e58593          	add	a1,a1,-402 # 1848 <malloc+0x366>
     9e2:	4509                	li	a0,2
     9e4:	00001097          	auipc	ra,0x1
     9e8:	850080e7          	jalr	-1968(ra) # 1234 <fprintf>
          exit(5);
     9ec:	4515                	li	a0,5
     9ee:	00000097          	auipc	ra,0x0
     9f2:	43c080e7          	jalr	1084(ra) # e2a <exit>
        close(bb[1]);
     9f6:	f9442503          	lw	a0,-108(s0)
     9fa:	00000097          	auipc	ra,0x0
     9fe:	458080e7          	jalr	1112(ra) # e52 <close>
        char *args[2] = { "cat", 0 };
     a02:	00001797          	auipc	a5,0x1
     a06:	e9678793          	add	a5,a5,-362 # 1898 <malloc+0x3b6>
     a0a:	f8f43c23          	sd	a5,-104(s0)
     a0e:	fa043023          	sd	zero,-96(s0)
        exec("/cat", args);
     a12:	f9840593          	add	a1,s0,-104
     a16:	00001517          	auipc	a0,0x1
     a1a:	e8a50513          	add	a0,a0,-374 # 18a0 <malloc+0x3be>
     a1e:	00000097          	auipc	ra,0x0
     a22:	444080e7          	jalr	1092(ra) # e62 <exec>
        fprintf(2, "grind: cat: not found\n");
     a26:	00001597          	auipc	a1,0x1
     a2a:	e8258593          	add	a1,a1,-382 # 18a8 <malloc+0x3c6>
     a2e:	4509                	li	a0,2
     a30:	00001097          	auipc	ra,0x1
     a34:	804080e7          	jalr	-2044(ra) # 1234 <fprintf>
        exit(6);
     a38:	4519                	li	a0,6
     a3a:	00000097          	auipc	ra,0x0
     a3e:	3f0080e7          	jalr	1008(ra) # e2a <exit>
        fprintf(2, "grind: fork failed\n");
     a42:	00001597          	auipc	a1,0x1
     a46:	cb658593          	add	a1,a1,-842 # 16f8 <malloc+0x216>
     a4a:	4509                	li	a0,2
     a4c:	00000097          	auipc	ra,0x0
     a50:	7e8080e7          	jalr	2024(ra) # 1234 <fprintf>
        exit(7);
     a54:	451d                	li	a0,7
     a56:	00000097          	auipc	ra,0x0
     a5a:	3d4080e7          	jalr	980(ra) # e2a <exit>

0000000000000a5e <iter>:
  }
}

void
iter()
{
     a5e:	7179                	add	sp,sp,-48
     a60:	f406                	sd	ra,40(sp)
     a62:	f022                	sd	s0,32(sp)
     a64:	1800                	add	s0,sp,48
  unlink("a");
     a66:	00001517          	auipc	a0,0x1
     a6a:	caa50513          	add	a0,a0,-854 # 1710 <malloc+0x22e>
     a6e:	00000097          	auipc	ra,0x0
     a72:	40c080e7          	jalr	1036(ra) # e7a <unlink>
  unlink("b");
     a76:	00001517          	auipc	a0,0x1
     a7a:	c4a50513          	add	a0,a0,-950 # 16c0 <malloc+0x1de>
     a7e:	00000097          	auipc	ra,0x0
     a82:	3fc080e7          	jalr	1020(ra) # e7a <unlink>
  
  int pid1 = fork();
     a86:	00000097          	auipc	ra,0x0
     a8a:	39c080e7          	jalr	924(ra) # e22 <fork>
  if(pid1 < 0){
     a8e:	02054063          	bltz	a0,aae <iter+0x50>
     a92:	ec26                	sd	s1,24(sp)
     a94:	84aa                	mv	s1,a0
    printf("grind: fork failed\n");
    exit(1);
  }
  if(pid1 == 0){
     a96:	e91d                	bnez	a0,acc <iter+0x6e>
     a98:	e84a                	sd	s2,16(sp)
    rand_next = 31;
     a9a:	47fd                	li	a5,31
     a9c:	00001717          	auipc	a4,0x1
     aa0:	f2f73223          	sd	a5,-220(a4) # 19c0 <rand_next>
    go(0);
     aa4:	4501                	li	a0,0
     aa6:	fffff097          	auipc	ra,0xfffff
     aaa:	5d2080e7          	jalr	1490(ra) # 78 <go>
     aae:	ec26                	sd	s1,24(sp)
     ab0:	e84a                	sd	s2,16(sp)
    printf("grind: fork failed\n");
     ab2:	00001517          	auipc	a0,0x1
     ab6:	c4650513          	add	a0,a0,-954 # 16f8 <malloc+0x216>
     aba:	00000097          	auipc	ra,0x0
     abe:	7a8080e7          	jalr	1960(ra) # 1262 <printf>
    exit(1);
     ac2:	4505                	li	a0,1
     ac4:	00000097          	auipc	ra,0x0
     ac8:	366080e7          	jalr	870(ra) # e2a <exit>
     acc:	e84a                	sd	s2,16(sp)
    exit(0);
  }

  int pid2 = fork();
     ace:	00000097          	auipc	ra,0x0
     ad2:	354080e7          	jalr	852(ra) # e22 <fork>
     ad6:	892a                	mv	s2,a0
  if(pid2 < 0){
     ad8:	00054f63          	bltz	a0,af6 <iter+0x98>
    printf("grind: fork failed\n");
    exit(1);
  }
  if(pid2 == 0){
     adc:	e915                	bnez	a0,b10 <iter+0xb2>
    rand_next = 7177;
     ade:	6789                	lui	a5,0x2
     ae0:	c0978793          	add	a5,a5,-1015 # 1c09 <buf.0+0x239>
     ae4:	00001717          	auipc	a4,0x1
     ae8:	ecf73e23          	sd	a5,-292(a4) # 19c0 <rand_next>
    go(1);
     aec:	4505                	li	a0,1
     aee:	fffff097          	auipc	ra,0xfffff
     af2:	58a080e7          	jalr	1418(ra) # 78 <go>
    printf("grind: fork failed\n");
     af6:	00001517          	auipc	a0,0x1
     afa:	c0250513          	add	a0,a0,-1022 # 16f8 <malloc+0x216>
     afe:	00000097          	auipc	ra,0x0
     b02:	764080e7          	jalr	1892(ra) # 1262 <printf>
    exit(1);
     b06:	4505                	li	a0,1
     b08:	00000097          	auipc	ra,0x0
     b0c:	322080e7          	jalr	802(ra) # e2a <exit>
    exit(0);
  }

  int st1 = -1;
     b10:	57fd                	li	a5,-1
     b12:	fcf42e23          	sw	a5,-36(s0)
  wait(&st1);
     b16:	fdc40513          	add	a0,s0,-36
     b1a:	00000097          	auipc	ra,0x0
     b1e:	318080e7          	jalr	792(ra) # e32 <wait>
  if(st1 != 0){
     b22:	fdc42783          	lw	a5,-36(s0)
     b26:	ef99                	bnez	a5,b44 <iter+0xe6>
    kill(pid1);
    kill(pid2);
  }
  int st2 = -1;
     b28:	57fd                	li	a5,-1
     b2a:	fcf42c23          	sw	a5,-40(s0)
  wait(&st2);
     b2e:	fd840513          	add	a0,s0,-40
     b32:	00000097          	auipc	ra,0x0
     b36:	300080e7          	jalr	768(ra) # e32 <wait>

  exit(0);
     b3a:	4501                	li	a0,0
     b3c:	00000097          	auipc	ra,0x0
     b40:	2ee080e7          	jalr	750(ra) # e2a <exit>
    kill(pid1);
     b44:	8526                	mv	a0,s1
     b46:	00000097          	auipc	ra,0x0
     b4a:	314080e7          	jalr	788(ra) # e5a <kill>
    kill(pid2);
     b4e:	854a                	mv	a0,s2
     b50:	00000097          	auipc	ra,0x0
     b54:	30a080e7          	jalr	778(ra) # e5a <kill>
     b58:	bfc1                	j	b28 <iter+0xca>

0000000000000b5a <main>:
}

int
main()
{
     b5a:	1141                	add	sp,sp,-16
     b5c:	e406                	sd	ra,8(sp)
     b5e:	e022                	sd	s0,0(sp)
     b60:	0800                	add	s0,sp,16
     b62:	a811                	j	b76 <main+0x1c>
  while(1){
    int pid = fork();
    if(pid == 0){
      iter();
     b64:	00000097          	auipc	ra,0x0
     b68:	efa080e7          	jalr	-262(ra) # a5e <iter>
      exit(0);
    }
    if(pid > 0){
      wait(0);
    }
    sleep(20);
     b6c:	4551                	li	a0,20
     b6e:	00000097          	auipc	ra,0x0
     b72:	34c080e7          	jalr	844(ra) # eba <sleep>
    int pid = fork();
     b76:	00000097          	auipc	ra,0x0
     b7a:	2ac080e7          	jalr	684(ra) # e22 <fork>
    if(pid == 0){
     b7e:	d17d                	beqz	a0,b64 <main+0xa>
    if(pid > 0){
     b80:	fea056e3          	blez	a0,b6c <main+0x12>
      wait(0);
     b84:	4501                	li	a0,0
     b86:	00000097          	auipc	ra,0x0
     b8a:	2ac080e7          	jalr	684(ra) # e32 <wait>
     b8e:	bff9                	j	b6c <main+0x12>

0000000000000b90 <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
     b90:	1141                	add	sp,sp,-16
     b92:	e422                	sd	s0,8(sp)
     b94:	0800                	add	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
     b96:	87aa                	mv	a5,a0
     b98:	0585                	add	a1,a1,1
     b9a:	0785                	add	a5,a5,1
     b9c:	fff5c703          	lbu	a4,-1(a1)
     ba0:	fee78fa3          	sb	a4,-1(a5)
     ba4:	fb75                	bnez	a4,b98 <strcpy+0x8>
    ;
  return os;
}
     ba6:	6422                	ld	s0,8(sp)
     ba8:	0141                	add	sp,sp,16
     baa:	8082                	ret

0000000000000bac <strcmp>:

int
strcmp(const char *p, const char *q)
{
     bac:	1141                	add	sp,sp,-16
     bae:	e422                	sd	s0,8(sp)
     bb0:	0800                	add	s0,sp,16
  while(*p && *p == *q)
     bb2:	00054783          	lbu	a5,0(a0)
     bb6:	cb91                	beqz	a5,bca <strcmp+0x1e>
     bb8:	0005c703          	lbu	a4,0(a1)
     bbc:	00f71763          	bne	a4,a5,bca <strcmp+0x1e>
    p++, q++;
     bc0:	0505                	add	a0,a0,1
     bc2:	0585                	add	a1,a1,1
  while(*p && *p == *q)
     bc4:	00054783          	lbu	a5,0(a0)
     bc8:	fbe5                	bnez	a5,bb8 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
     bca:	0005c503          	lbu	a0,0(a1)
}
     bce:	40a7853b          	subw	a0,a5,a0
     bd2:	6422                	ld	s0,8(sp)
     bd4:	0141                	add	sp,sp,16
     bd6:	8082                	ret

0000000000000bd8 <strlen>:

uint
strlen(const char *s)
{
     bd8:	1141                	add	sp,sp,-16
     bda:	e422                	sd	s0,8(sp)
     bdc:	0800                	add	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
     bde:	00054783          	lbu	a5,0(a0)
     be2:	cf91                	beqz	a5,bfe <strlen+0x26>
     be4:	0505                	add	a0,a0,1
     be6:	87aa                	mv	a5,a0
     be8:	86be                	mv	a3,a5
     bea:	0785                	add	a5,a5,1
     bec:	fff7c703          	lbu	a4,-1(a5)
     bf0:	ff65                	bnez	a4,be8 <strlen+0x10>
     bf2:	40a6853b          	subw	a0,a3,a0
     bf6:	2505                	addw	a0,a0,1
    ;
  return n;
}
     bf8:	6422                	ld	s0,8(sp)
     bfa:	0141                	add	sp,sp,16
     bfc:	8082                	ret
  for(n = 0; s[n]; n++)
     bfe:	4501                	li	a0,0
     c00:	bfe5                	j	bf8 <strlen+0x20>

0000000000000c02 <strcat>:

char *
strcat(char *dst, char *src)
{
     c02:	1141                	add	sp,sp,-16
     c04:	e422                	sd	s0,8(sp)
     c06:	0800                	add	s0,sp,16
  char *s = dst;
  while (*dst)
     c08:	00054783          	lbu	a5,0(a0)
     c0c:	c385                	beqz	a5,c2c <strcat+0x2a>
     c0e:	87aa                	mv	a5,a0
    dst++;
     c10:	0785                	add	a5,a5,1
  while (*dst)
     c12:	0007c703          	lbu	a4,0(a5)
     c16:	ff6d                	bnez	a4,c10 <strcat+0xe>
  while ((*dst++ = *src++) != 0);
     c18:	0585                	add	a1,a1,1
     c1a:	0785                	add	a5,a5,1
     c1c:	fff5c703          	lbu	a4,-1(a1)
     c20:	fee78fa3          	sb	a4,-1(a5)
     c24:	fb75                	bnez	a4,c18 <strcat+0x16>

  return s;
}
     c26:	6422                	ld	s0,8(sp)
     c28:	0141                	add	sp,sp,16
     c2a:	8082                	ret
  while (*dst)
     c2c:	87aa                	mv	a5,a0
     c2e:	b7ed                	j	c18 <strcat+0x16>

0000000000000c30 <memset>:

void*
memset(void *dst, int c, uint n)
{
     c30:	1141                	add	sp,sp,-16
     c32:	e422                	sd	s0,8(sp)
     c34:	0800                	add	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
     c36:	ca19                	beqz	a2,c4c <memset+0x1c>
     c38:	87aa                	mv	a5,a0
     c3a:	1602                	sll	a2,a2,0x20
     c3c:	9201                	srl	a2,a2,0x20
     c3e:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
     c42:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
     c46:	0785                	add	a5,a5,1
     c48:	fee79de3          	bne	a5,a4,c42 <memset+0x12>
  }
  return dst;
}
     c4c:	6422                	ld	s0,8(sp)
     c4e:	0141                	add	sp,sp,16
     c50:	8082                	ret

0000000000000c52 <strchr>:

char*
strchr(const char *s, char c)
{
     c52:	1141                	add	sp,sp,-16
     c54:	e422                	sd	s0,8(sp)
     c56:	0800                	add	s0,sp,16
  for(; *s; s++)
     c58:	00054783          	lbu	a5,0(a0)
     c5c:	cb99                	beqz	a5,c72 <strchr+0x20>
    if(*s == c)
     c5e:	00f58763          	beq	a1,a5,c6c <strchr+0x1a>
  for(; *s; s++)
     c62:	0505                	add	a0,a0,1
     c64:	00054783          	lbu	a5,0(a0)
     c68:	fbfd                	bnez	a5,c5e <strchr+0xc>
      return (char*)s;
  return 0;
     c6a:	4501                	li	a0,0
}
     c6c:	6422                	ld	s0,8(sp)
     c6e:	0141                	add	sp,sp,16
     c70:	8082                	ret
  return 0;
     c72:	4501                	li	a0,0
     c74:	bfe5                	j	c6c <strchr+0x1a>

0000000000000c76 <gets>:

char*
gets(char *buf, int max)
{
     c76:	711d                	add	sp,sp,-96
     c78:	ec86                	sd	ra,88(sp)
     c7a:	e8a2                	sd	s0,80(sp)
     c7c:	e4a6                	sd	s1,72(sp)
     c7e:	e0ca                	sd	s2,64(sp)
     c80:	fc4e                	sd	s3,56(sp)
     c82:	f852                	sd	s4,48(sp)
     c84:	f456                	sd	s5,40(sp)
     c86:	f05a                	sd	s6,32(sp)
     c88:	ec5e                	sd	s7,24(sp)
     c8a:	1080                	add	s0,sp,96
     c8c:	8baa                	mv	s7,a0
     c8e:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     c90:	892a                	mv	s2,a0
     c92:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
     c94:	4aa9                	li	s5,10
     c96:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
     c98:	89a6                	mv	s3,s1
     c9a:	2485                	addw	s1,s1,1
     c9c:	0344d863          	bge	s1,s4,ccc <gets+0x56>
    cc = read(0, &c, 1);
     ca0:	4605                	li	a2,1
     ca2:	faf40593          	add	a1,s0,-81
     ca6:	4501                	li	a0,0
     ca8:	00000097          	auipc	ra,0x0
     cac:	19a080e7          	jalr	410(ra) # e42 <read>
    if(cc < 1)
     cb0:	00a05e63          	blez	a0,ccc <gets+0x56>
    buf[i++] = c;
     cb4:	faf44783          	lbu	a5,-81(s0)
     cb8:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
     cbc:	01578763          	beq	a5,s5,cca <gets+0x54>
     cc0:	0905                	add	s2,s2,1
     cc2:	fd679be3          	bne	a5,s6,c98 <gets+0x22>
    buf[i++] = c;
     cc6:	89a6                	mv	s3,s1
     cc8:	a011                	j	ccc <gets+0x56>
     cca:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
     ccc:	99de                	add	s3,s3,s7
     cce:	00098023          	sb	zero,0(s3)
  return buf;
}
     cd2:	855e                	mv	a0,s7
     cd4:	60e6                	ld	ra,88(sp)
     cd6:	6446                	ld	s0,80(sp)
     cd8:	64a6                	ld	s1,72(sp)
     cda:	6906                	ld	s2,64(sp)
     cdc:	79e2                	ld	s3,56(sp)
     cde:	7a42                	ld	s4,48(sp)
     ce0:	7aa2                	ld	s5,40(sp)
     ce2:	7b02                	ld	s6,32(sp)
     ce4:	6be2                	ld	s7,24(sp)
     ce6:	6125                	add	sp,sp,96
     ce8:	8082                	ret

0000000000000cea <stat>:

int
stat(const char *n, struct stat *st)
{
     cea:	1101                	add	sp,sp,-32
     cec:	ec06                	sd	ra,24(sp)
     cee:	e822                	sd	s0,16(sp)
     cf0:	e04a                	sd	s2,0(sp)
     cf2:	1000                	add	s0,sp,32
     cf4:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     cf6:	4581                	li	a1,0
     cf8:	00000097          	auipc	ra,0x0
     cfc:	172080e7          	jalr	370(ra) # e6a <open>
  if(fd < 0)
     d00:	02054663          	bltz	a0,d2c <stat+0x42>
     d04:	e426                	sd	s1,8(sp)
     d06:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
     d08:	85ca                	mv	a1,s2
     d0a:	00000097          	auipc	ra,0x0
     d0e:	178080e7          	jalr	376(ra) # e82 <fstat>
     d12:	892a                	mv	s2,a0
  close(fd);
     d14:	8526                	mv	a0,s1
     d16:	00000097          	auipc	ra,0x0
     d1a:	13c080e7          	jalr	316(ra) # e52 <close>
  return r;
     d1e:	64a2                	ld	s1,8(sp)
}
     d20:	854a                	mv	a0,s2
     d22:	60e2                	ld	ra,24(sp)
     d24:	6442                	ld	s0,16(sp)
     d26:	6902                	ld	s2,0(sp)
     d28:	6105                	add	sp,sp,32
     d2a:	8082                	ret
    return -1;
     d2c:	597d                	li	s2,-1
     d2e:	bfcd                	j	d20 <stat+0x36>

0000000000000d30 <atoi>:

int
atoi(const char *s)
{
     d30:	1141                	add	sp,sp,-16
     d32:	e422                	sd	s0,8(sp)
     d34:	0800                	add	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
     d36:	00054683          	lbu	a3,0(a0)
     d3a:	fd06879b          	addw	a5,a3,-48
     d3e:	0ff7f793          	zext.b	a5,a5
     d42:	4625                	li	a2,9
     d44:	02f66863          	bltu	a2,a5,d74 <atoi+0x44>
     d48:	872a                	mv	a4,a0
  n = 0;
     d4a:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
     d4c:	0705                	add	a4,a4,1
     d4e:	0025179b          	sllw	a5,a0,0x2
     d52:	9fa9                	addw	a5,a5,a0
     d54:	0017979b          	sllw	a5,a5,0x1
     d58:	9fb5                	addw	a5,a5,a3
     d5a:	fd07851b          	addw	a0,a5,-48
  while('0' <= *s && *s <= '9')
     d5e:	00074683          	lbu	a3,0(a4)
     d62:	fd06879b          	addw	a5,a3,-48
     d66:	0ff7f793          	zext.b	a5,a5
     d6a:	fef671e3          	bgeu	a2,a5,d4c <atoi+0x1c>
  return n;
}
     d6e:	6422                	ld	s0,8(sp)
     d70:	0141                	add	sp,sp,16
     d72:	8082                	ret
  n = 0;
     d74:	4501                	li	a0,0
     d76:	bfe5                	j	d6e <atoi+0x3e>

0000000000000d78 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
     d78:	1141                	add	sp,sp,-16
     d7a:	e422                	sd	s0,8(sp)
     d7c:	0800                	add	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
     d7e:	02b57463          	bgeu	a0,a1,da6 <memmove+0x2e>
    while(n-- > 0)
     d82:	00c05f63          	blez	a2,da0 <memmove+0x28>
     d86:	1602                	sll	a2,a2,0x20
     d88:	9201                	srl	a2,a2,0x20
     d8a:	00c507b3          	add	a5,a0,a2
  dst = vdst;
     d8e:	872a                	mv	a4,a0
      *dst++ = *src++;
     d90:	0585                	add	a1,a1,1
     d92:	0705                	add	a4,a4,1
     d94:	fff5c683          	lbu	a3,-1(a1)
     d98:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
     d9c:	fef71ae3          	bne	a4,a5,d90 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
     da0:	6422                	ld	s0,8(sp)
     da2:	0141                	add	sp,sp,16
     da4:	8082                	ret
    dst += n;
     da6:	00c50733          	add	a4,a0,a2
    src += n;
     daa:	95b2                	add	a1,a1,a2
    while(n-- > 0)
     dac:	fec05ae3          	blez	a2,da0 <memmove+0x28>
     db0:	fff6079b          	addw	a5,a2,-1
     db4:	1782                	sll	a5,a5,0x20
     db6:	9381                	srl	a5,a5,0x20
     db8:	fff7c793          	not	a5,a5
     dbc:	97ba                	add	a5,a5,a4
      *--dst = *--src;
     dbe:	15fd                	add	a1,a1,-1
     dc0:	177d                	add	a4,a4,-1
     dc2:	0005c683          	lbu	a3,0(a1)
     dc6:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
     dca:	fee79ae3          	bne	a5,a4,dbe <memmove+0x46>
     dce:	bfc9                	j	da0 <memmove+0x28>

0000000000000dd0 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
     dd0:	1141                	add	sp,sp,-16
     dd2:	e422                	sd	s0,8(sp)
     dd4:	0800                	add	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
     dd6:	ca05                	beqz	a2,e06 <memcmp+0x36>
     dd8:	fff6069b          	addw	a3,a2,-1
     ddc:	1682                	sll	a3,a3,0x20
     dde:	9281                	srl	a3,a3,0x20
     de0:	0685                	add	a3,a3,1
     de2:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
     de4:	00054783          	lbu	a5,0(a0)
     de8:	0005c703          	lbu	a4,0(a1)
     dec:	00e79863          	bne	a5,a4,dfc <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
     df0:	0505                	add	a0,a0,1
    p2++;
     df2:	0585                	add	a1,a1,1
  while (n-- > 0) {
     df4:	fed518e3          	bne	a0,a3,de4 <memcmp+0x14>
  }
  return 0;
     df8:	4501                	li	a0,0
     dfa:	a019                	j	e00 <memcmp+0x30>
      return *p1 - *p2;
     dfc:	40e7853b          	subw	a0,a5,a4
}
     e00:	6422                	ld	s0,8(sp)
     e02:	0141                	add	sp,sp,16
     e04:	8082                	ret
  return 0;
     e06:	4501                	li	a0,0
     e08:	bfe5                	j	e00 <memcmp+0x30>

0000000000000e0a <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
     e0a:	1141                	add	sp,sp,-16
     e0c:	e406                	sd	ra,8(sp)
     e0e:	e022                	sd	s0,0(sp)
     e10:	0800                	add	s0,sp,16
  return memmove(dst, src, n);
     e12:	00000097          	auipc	ra,0x0
     e16:	f66080e7          	jalr	-154(ra) # d78 <memmove>
}
     e1a:	60a2                	ld	ra,8(sp)
     e1c:	6402                	ld	s0,0(sp)
     e1e:	0141                	add	sp,sp,16
     e20:	8082                	ret

0000000000000e22 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
     e22:	4885                	li	a7,1
 ecall
     e24:	00000073          	ecall
 ret
     e28:	8082                	ret

0000000000000e2a <exit>:
.global exit
exit:
 li a7, SYS_exit
     e2a:	4889                	li	a7,2
 ecall
     e2c:	00000073          	ecall
 ret
     e30:	8082                	ret

0000000000000e32 <wait>:
.global wait
wait:
 li a7, SYS_wait
     e32:	488d                	li	a7,3
 ecall
     e34:	00000073          	ecall
 ret
     e38:	8082                	ret

0000000000000e3a <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
     e3a:	4891                	li	a7,4
 ecall
     e3c:	00000073          	ecall
 ret
     e40:	8082                	ret

0000000000000e42 <read>:
.global read
read:
 li a7, SYS_read
     e42:	4895                	li	a7,5
 ecall
     e44:	00000073          	ecall
 ret
     e48:	8082                	ret

0000000000000e4a <write>:
.global write
write:
 li a7, SYS_write
     e4a:	48c1                	li	a7,16
 ecall
     e4c:	00000073          	ecall
 ret
     e50:	8082                	ret

0000000000000e52 <close>:
.global close
close:
 li a7, SYS_close
     e52:	48d5                	li	a7,21
 ecall
     e54:	00000073          	ecall
 ret
     e58:	8082                	ret

0000000000000e5a <kill>:
.global kill
kill:
 li a7, SYS_kill
     e5a:	4899                	li	a7,6
 ecall
     e5c:	00000073          	ecall
 ret
     e60:	8082                	ret

0000000000000e62 <exec>:
.global exec
exec:
 li a7, SYS_exec
     e62:	489d                	li	a7,7
 ecall
     e64:	00000073          	ecall
 ret
     e68:	8082                	ret

0000000000000e6a <open>:
.global open
open:
 li a7, SYS_open
     e6a:	48bd                	li	a7,15
 ecall
     e6c:	00000073          	ecall
 ret
     e70:	8082                	ret

0000000000000e72 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
     e72:	48c5                	li	a7,17
 ecall
     e74:	00000073          	ecall
 ret
     e78:	8082                	ret

0000000000000e7a <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
     e7a:	48c9                	li	a7,18
 ecall
     e7c:	00000073          	ecall
 ret
     e80:	8082                	ret

0000000000000e82 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
     e82:	48a1                	li	a7,8
 ecall
     e84:	00000073          	ecall
 ret
     e88:	8082                	ret

0000000000000e8a <link>:
.global link
link:
 li a7, SYS_link
     e8a:	48cd                	li	a7,19
 ecall
     e8c:	00000073          	ecall
 ret
     e90:	8082                	ret

0000000000000e92 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
     e92:	48d1                	li	a7,20
 ecall
     e94:	00000073          	ecall
 ret
     e98:	8082                	ret

0000000000000e9a <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
     e9a:	48a5                	li	a7,9
 ecall
     e9c:	00000073          	ecall
 ret
     ea0:	8082                	ret

0000000000000ea2 <dup>:
.global dup
dup:
 li a7, SYS_dup
     ea2:	48a9                	li	a7,10
 ecall
     ea4:	00000073          	ecall
 ret
     ea8:	8082                	ret

0000000000000eaa <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
     eaa:	48ad                	li	a7,11
 ecall
     eac:	00000073          	ecall
 ret
     eb0:	8082                	ret

0000000000000eb2 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
     eb2:	48b1                	li	a7,12
 ecall
     eb4:	00000073          	ecall
 ret
     eb8:	8082                	ret

0000000000000eba <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
     eba:	48b5                	li	a7,13
 ecall
     ebc:	00000073          	ecall
 ret
     ec0:	8082                	ret

0000000000000ec2 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
     ec2:	48b9                	li	a7,14
 ecall
     ec4:	00000073          	ecall
 ret
     ec8:	8082                	ret

0000000000000eca <uconnect>:
.global uconnect
uconnect:
 li a7, SYS_uconnect
     eca:	48f5                	li	a7,29
 ecall
     ecc:	00000073          	ecall
 ret
     ed0:	8082                	ret

0000000000000ed2 <socket>:
.global socket
socket:
 li a7, SYS_socket
     ed2:	48f9                	li	a7,30
 ecall
     ed4:	00000073          	ecall
 ret
     ed8:	8082                	ret

0000000000000eda <bind>:
.global bind
bind:
 li a7, SYS_bind
     eda:	48fd                	li	a7,31
 ecall
     edc:	00000073          	ecall
 ret
     ee0:	8082                	ret

0000000000000ee2 <listen>:
.global listen
listen:
 li a7, SYS_listen
     ee2:	02000893          	li	a7,32
 ecall
     ee6:	00000073          	ecall
 ret
     eea:	8082                	ret

0000000000000eec <accept>:
.global accept
accept:
 li a7, SYS_accept
     eec:	02100893          	li	a7,33
 ecall
     ef0:	00000073          	ecall
 ret
     ef4:	8082                	ret

0000000000000ef6 <connect>:
.global connect
connect:
 li a7, SYS_connect
     ef6:	02200893          	li	a7,34
 ecall
     efa:	00000073          	ecall
 ret
     efe:	8082                	ret

0000000000000f00 <sprintint>:
  return 1;
}

static int
sprintint(char *s, int xx, int base, int sign)
{
     f00:	1101                	add	sp,sp,-32
     f02:	ec22                	sd	s0,24(sp)
     f04:	1000                	add	s0,sp,32
     f06:	882a                	mv	a6,a0
  char buf[16];
  int i, n;
  uint x;

  if(sign && (sign = xx < 0))
     f08:	c299                	beqz	a3,f0e <sprintint+0xe>
     f0a:	0805c263          	bltz	a1,f8e <sprintint+0x8e>
    x = -xx;
  else
    x = xx;
     f0e:	2581                	sext.w	a1,a1
     f10:	4301                	li	t1,0

  i = 0;
     f12:	fe040713          	add	a4,s0,-32
     f16:	4501                	li	a0,0
  do {
    buf[i++] = digits[x % base];
     f18:	2601                	sext.w	a2,a2
     f1a:	00001697          	auipc	a3,0x1
     f1e:	a8e68693          	add	a3,a3,-1394 # 19a8 <digits>
     f22:	88aa                	mv	a7,a0
     f24:	2505                	addw	a0,a0,1
     f26:	02c5f7bb          	remuw	a5,a1,a2
     f2a:	1782                	sll	a5,a5,0x20
     f2c:	9381                	srl	a5,a5,0x20
     f2e:	97b6                	add	a5,a5,a3
     f30:	0007c783          	lbu	a5,0(a5)
     f34:	00f70023          	sb	a5,0(a4)
  } while((x /= base) != 0);
     f38:	0005879b          	sext.w	a5,a1
     f3c:	02c5d5bb          	divuw	a1,a1,a2
     f40:	0705                	add	a4,a4,1
     f42:	fec7f0e3          	bgeu	a5,a2,f22 <sprintint+0x22>

  if(sign)
     f46:	00030b63          	beqz	t1,f5c <sprintint+0x5c>
    buf[i++] = '-';
     f4a:	ff050793          	add	a5,a0,-16
     f4e:	97a2                	add	a5,a5,s0
     f50:	02d00713          	li	a4,45
     f54:	fee78823          	sb	a4,-16(a5)
     f58:	0028851b          	addw	a0,a7,2

  n = 0;
  while(--i >= 0)
     f5c:	02a05d63          	blez	a0,f96 <sprintint+0x96>
     f60:	fe040793          	add	a5,s0,-32
     f64:	00a78733          	add	a4,a5,a0
     f68:	87c2                	mv	a5,a6
     f6a:	00180613          	add	a2,a6,1
     f6e:	fff5069b          	addw	a3,a0,-1
     f72:	1682                	sll	a3,a3,0x20
     f74:	9281                	srl	a3,a3,0x20
     f76:	9636                	add	a2,a2,a3
  *s = c;
     f78:	fff74683          	lbu	a3,-1(a4)
     f7c:	00d78023          	sb	a3,0(a5)
  while(--i >= 0)
     f80:	177d                	add	a4,a4,-1
     f82:	0785                	add	a5,a5,1
     f84:	fec79ae3          	bne	a5,a2,f78 <sprintint+0x78>
    n += sputc(s+n, buf[i]);
  return n;
}
     f88:	6462                	ld	s0,24(sp)
     f8a:	6105                	add	sp,sp,32
     f8c:	8082                	ret
    x = -xx;
     f8e:	40b005bb          	negw	a1,a1
  if(sign && (sign = xx < 0))
     f92:	4305                	li	t1,1
    x = -xx;
     f94:	bfbd                	j	f12 <sprintint+0x12>
  while(--i >= 0)
     f96:	4501                	li	a0,0
     f98:	bfc5                	j	f88 <sprintint+0x88>

0000000000000f9a <putc>:
{
     f9a:	1101                	add	sp,sp,-32
     f9c:	ec06                	sd	ra,24(sp)
     f9e:	e822                	sd	s0,16(sp)
     fa0:	1000                	add	s0,sp,32
     fa2:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
     fa6:	4605                	li	a2,1
     fa8:	fef40593          	add	a1,s0,-17
     fac:	00000097          	auipc	ra,0x0
     fb0:	e9e080e7          	jalr	-354(ra) # e4a <write>
}
     fb4:	60e2                	ld	ra,24(sp)
     fb6:	6442                	ld	s0,16(sp)
     fb8:	6105                	add	sp,sp,32
     fba:	8082                	ret

0000000000000fbc <printint>:
{
     fbc:	7139                	add	sp,sp,-64
     fbe:	fc06                	sd	ra,56(sp)
     fc0:	f822                	sd	s0,48(sp)
     fc2:	f426                	sd	s1,40(sp)
     fc4:	0080                	add	s0,sp,64
     fc6:	84aa                	mv	s1,a0
  if(sgn && xx < 0){
     fc8:	c299                	beqz	a3,fce <printint+0x12>
     fca:	0805cb63          	bltz	a1,1060 <printint+0xa4>
    x = xx;
     fce:	2581                	sext.w	a1,a1
  neg = 0;
     fd0:	4881                	li	a7,0
     fd2:	fc040693          	add	a3,s0,-64
  i = 0;
     fd6:	4701                	li	a4,0
    buf[i++] = digits[x % base];
     fd8:	2601                	sext.w	a2,a2
     fda:	00001517          	auipc	a0,0x1
     fde:	9ce50513          	add	a0,a0,-1586 # 19a8 <digits>
     fe2:	883a                	mv	a6,a4
     fe4:	2705                	addw	a4,a4,1
     fe6:	02c5f7bb          	remuw	a5,a1,a2
     fea:	1782                	sll	a5,a5,0x20
     fec:	9381                	srl	a5,a5,0x20
     fee:	97aa                	add	a5,a5,a0
     ff0:	0007c783          	lbu	a5,0(a5)
     ff4:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
     ff8:	0005879b          	sext.w	a5,a1
     ffc:	02c5d5bb          	divuw	a1,a1,a2
    1000:	0685                	add	a3,a3,1
    1002:	fec7f0e3          	bgeu	a5,a2,fe2 <printint+0x26>
  if(neg)
    1006:	00088c63          	beqz	a7,101e <printint+0x62>
    buf[i++] = '-';
    100a:	fd070793          	add	a5,a4,-48
    100e:	00878733          	add	a4,a5,s0
    1012:	02d00793          	li	a5,45
    1016:	fef70823          	sb	a5,-16(a4)
    101a:	0028071b          	addw	a4,a6,2
  while(--i >= 0)
    101e:	02e05c63          	blez	a4,1056 <printint+0x9a>
    1022:	f04a                	sd	s2,32(sp)
    1024:	ec4e                	sd	s3,24(sp)
    1026:	fc040793          	add	a5,s0,-64
    102a:	00e78933          	add	s2,a5,a4
    102e:	fff78993          	add	s3,a5,-1
    1032:	99ba                	add	s3,s3,a4
    1034:	377d                	addw	a4,a4,-1
    1036:	1702                	sll	a4,a4,0x20
    1038:	9301                	srl	a4,a4,0x20
    103a:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
    103e:	fff94583          	lbu	a1,-1(s2)
    1042:	8526                	mv	a0,s1
    1044:	00000097          	auipc	ra,0x0
    1048:	f56080e7          	jalr	-170(ra) # f9a <putc>
  while(--i >= 0)
    104c:	197d                	add	s2,s2,-1
    104e:	ff3918e3          	bne	s2,s3,103e <printint+0x82>
    1052:	7902                	ld	s2,32(sp)
    1054:	69e2                	ld	s3,24(sp)
}
    1056:	70e2                	ld	ra,56(sp)
    1058:	7442                	ld	s0,48(sp)
    105a:	74a2                	ld	s1,40(sp)
    105c:	6121                	add	sp,sp,64
    105e:	8082                	ret
    x = -xx;
    1060:	40b005bb          	negw	a1,a1
    neg = 1;
    1064:	4885                	li	a7,1
    x = -xx;
    1066:	b7b5                	j	fd2 <printint+0x16>

0000000000001068 <vprintf>:
{
    1068:	715d                	add	sp,sp,-80
    106a:	e486                	sd	ra,72(sp)
    106c:	e0a2                	sd	s0,64(sp)
    106e:	f84a                	sd	s2,48(sp)
    1070:	0880                	add	s0,sp,80
  for(i = 0; fmt[i]; i++){
    1072:	0005c903          	lbu	s2,0(a1)
    1076:	1a090a63          	beqz	s2,122a <vprintf+0x1c2>
    107a:	fc26                	sd	s1,56(sp)
    107c:	f44e                	sd	s3,40(sp)
    107e:	f052                	sd	s4,32(sp)
    1080:	ec56                	sd	s5,24(sp)
    1082:	e85a                	sd	s6,16(sp)
    1084:	e45e                	sd	s7,8(sp)
    1086:	8aaa                	mv	s5,a0
    1088:	8bb2                	mv	s7,a2
    108a:	00158493          	add	s1,a1,1
  state = 0;
    108e:	4981                	li	s3,0
    } else if(state == '%'){
    1090:	02500a13          	li	s4,37
    1094:	4b55                	li	s6,21
    1096:	a839                	j	10b4 <vprintf+0x4c>
        putc(fd, c);
    1098:	85ca                	mv	a1,s2
    109a:	8556                	mv	a0,s5
    109c:	00000097          	auipc	ra,0x0
    10a0:	efe080e7          	jalr	-258(ra) # f9a <putc>
    10a4:	a019                	j	10aa <vprintf+0x42>
    } else if(state == '%'){
    10a6:	01498d63          	beq	s3,s4,10c0 <vprintf+0x58>
  for(i = 0; fmt[i]; i++){
    10aa:	0485                	add	s1,s1,1
    10ac:	fff4c903          	lbu	s2,-1(s1)
    10b0:	16090763          	beqz	s2,121e <vprintf+0x1b6>
    if(state == 0){
    10b4:	fe0999e3          	bnez	s3,10a6 <vprintf+0x3e>
      if(c == '%'){
    10b8:	ff4910e3          	bne	s2,s4,1098 <vprintf+0x30>
        state = '%';
    10bc:	89d2                	mv	s3,s4
    10be:	b7f5                	j	10aa <vprintf+0x42>
      if(c == 'd'){
    10c0:	13490463          	beq	s2,s4,11e8 <vprintf+0x180>
    10c4:	f9d9079b          	addw	a5,s2,-99
    10c8:	0ff7f793          	zext.b	a5,a5
    10cc:	12fb6763          	bltu	s6,a5,11fa <vprintf+0x192>
    10d0:	f9d9079b          	addw	a5,s2,-99
    10d4:	0ff7f713          	zext.b	a4,a5
    10d8:	12eb6163          	bltu	s6,a4,11fa <vprintf+0x192>
    10dc:	00271793          	sll	a5,a4,0x2
    10e0:	00001717          	auipc	a4,0x1
    10e4:	87070713          	add	a4,a4,-1936 # 1950 <malloc+0x46e>
    10e8:	97ba                	add	a5,a5,a4
    10ea:	439c                	lw	a5,0(a5)
    10ec:	97ba                	add	a5,a5,a4
    10ee:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
    10f0:	008b8913          	add	s2,s7,8
    10f4:	4685                	li	a3,1
    10f6:	4629                	li	a2,10
    10f8:	000ba583          	lw	a1,0(s7)
    10fc:	8556                	mv	a0,s5
    10fe:	00000097          	auipc	ra,0x0
    1102:	ebe080e7          	jalr	-322(ra) # fbc <printint>
    1106:	8bca                	mv	s7,s2
      state = 0;
    1108:	4981                	li	s3,0
    110a:	b745                	j	10aa <vprintf+0x42>
        printint(fd, va_arg(ap, uint64), 10, 0);
    110c:	008b8913          	add	s2,s7,8
    1110:	4681                	li	a3,0
    1112:	4629                	li	a2,10
    1114:	000ba583          	lw	a1,0(s7)
    1118:	8556                	mv	a0,s5
    111a:	00000097          	auipc	ra,0x0
    111e:	ea2080e7          	jalr	-350(ra) # fbc <printint>
    1122:	8bca                	mv	s7,s2
      state = 0;
    1124:	4981                	li	s3,0
    1126:	b751                	j	10aa <vprintf+0x42>
        printint(fd, va_arg(ap, int), 16, 0);
    1128:	008b8913          	add	s2,s7,8
    112c:	4681                	li	a3,0
    112e:	4641                	li	a2,16
    1130:	000ba583          	lw	a1,0(s7)
    1134:	8556                	mv	a0,s5
    1136:	00000097          	auipc	ra,0x0
    113a:	e86080e7          	jalr	-378(ra) # fbc <printint>
    113e:	8bca                	mv	s7,s2
      state = 0;
    1140:	4981                	li	s3,0
    1142:	b7a5                	j	10aa <vprintf+0x42>
    1144:	e062                	sd	s8,0(sp)
        printptr(fd, va_arg(ap, uint64));
    1146:	008b8c13          	add	s8,s7,8
    114a:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
    114e:	03000593          	li	a1,48
    1152:	8556                	mv	a0,s5
    1154:	00000097          	auipc	ra,0x0
    1158:	e46080e7          	jalr	-442(ra) # f9a <putc>
  putc(fd, 'x');
    115c:	07800593          	li	a1,120
    1160:	8556                	mv	a0,s5
    1162:	00000097          	auipc	ra,0x0
    1166:	e38080e7          	jalr	-456(ra) # f9a <putc>
    116a:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
    116c:	00001b97          	auipc	s7,0x1
    1170:	83cb8b93          	add	s7,s7,-1988 # 19a8 <digits>
    1174:	03c9d793          	srl	a5,s3,0x3c
    1178:	97de                	add	a5,a5,s7
    117a:	0007c583          	lbu	a1,0(a5)
    117e:	8556                	mv	a0,s5
    1180:	00000097          	auipc	ra,0x0
    1184:	e1a080e7          	jalr	-486(ra) # f9a <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    1188:	0992                	sll	s3,s3,0x4
    118a:	397d                	addw	s2,s2,-1
    118c:	fe0914e3          	bnez	s2,1174 <vprintf+0x10c>
        printptr(fd, va_arg(ap, uint64));
    1190:	8be2                	mv	s7,s8
      state = 0;
    1192:	4981                	li	s3,0
    1194:	6c02                	ld	s8,0(sp)
    1196:	bf11                	j	10aa <vprintf+0x42>
        s = va_arg(ap, char*);
    1198:	008b8993          	add	s3,s7,8
    119c:	000bb903          	ld	s2,0(s7)
        if(s == 0)
    11a0:	02090163          	beqz	s2,11c2 <vprintf+0x15a>
        while(*s != 0){
    11a4:	00094583          	lbu	a1,0(s2)
    11a8:	c9a5                	beqz	a1,1218 <vprintf+0x1b0>
          putc(fd, *s);
    11aa:	8556                	mv	a0,s5
    11ac:	00000097          	auipc	ra,0x0
    11b0:	dee080e7          	jalr	-530(ra) # f9a <putc>
          s++;
    11b4:	0905                	add	s2,s2,1
        while(*s != 0){
    11b6:	00094583          	lbu	a1,0(s2)
    11ba:	f9e5                	bnez	a1,11aa <vprintf+0x142>
        s = va_arg(ap, char*);
    11bc:	8bce                	mv	s7,s3
      state = 0;
    11be:	4981                	li	s3,0
    11c0:	b5ed                	j	10aa <vprintf+0x42>
          s = "(null)";
    11c2:	00000917          	auipc	s2,0x0
    11c6:	72690913          	add	s2,s2,1830 # 18e8 <malloc+0x406>
        while(*s != 0){
    11ca:	02800593          	li	a1,40
    11ce:	bff1                	j	11aa <vprintf+0x142>
        putc(fd, va_arg(ap, uint));
    11d0:	008b8913          	add	s2,s7,8
    11d4:	000bc583          	lbu	a1,0(s7)
    11d8:	8556                	mv	a0,s5
    11da:	00000097          	auipc	ra,0x0
    11de:	dc0080e7          	jalr	-576(ra) # f9a <putc>
    11e2:	8bca                	mv	s7,s2
      state = 0;
    11e4:	4981                	li	s3,0
    11e6:	b5d1                	j	10aa <vprintf+0x42>
        putc(fd, c);
    11e8:	02500593          	li	a1,37
    11ec:	8556                	mv	a0,s5
    11ee:	00000097          	auipc	ra,0x0
    11f2:	dac080e7          	jalr	-596(ra) # f9a <putc>
      state = 0;
    11f6:	4981                	li	s3,0
    11f8:	bd4d                	j	10aa <vprintf+0x42>
        putc(fd, '%');
    11fa:	02500593          	li	a1,37
    11fe:	8556                	mv	a0,s5
    1200:	00000097          	auipc	ra,0x0
    1204:	d9a080e7          	jalr	-614(ra) # f9a <putc>
        putc(fd, c);
    1208:	85ca                	mv	a1,s2
    120a:	8556                	mv	a0,s5
    120c:	00000097          	auipc	ra,0x0
    1210:	d8e080e7          	jalr	-626(ra) # f9a <putc>
      state = 0;
    1214:	4981                	li	s3,0
    1216:	bd51                	j	10aa <vprintf+0x42>
        s = va_arg(ap, char*);
    1218:	8bce                	mv	s7,s3
      state = 0;
    121a:	4981                	li	s3,0
    121c:	b579                	j	10aa <vprintf+0x42>
    121e:	74e2                	ld	s1,56(sp)
    1220:	79a2                	ld	s3,40(sp)
    1222:	7a02                	ld	s4,32(sp)
    1224:	6ae2                	ld	s5,24(sp)
    1226:	6b42                	ld	s6,16(sp)
    1228:	6ba2                	ld	s7,8(sp)
}
    122a:	60a6                	ld	ra,72(sp)
    122c:	6406                	ld	s0,64(sp)
    122e:	7942                	ld	s2,48(sp)
    1230:	6161                	add	sp,sp,80
    1232:	8082                	ret

0000000000001234 <fprintf>:
{
    1234:	715d                	add	sp,sp,-80
    1236:	ec06                	sd	ra,24(sp)
    1238:	e822                	sd	s0,16(sp)
    123a:	1000                	add	s0,sp,32
    123c:	e010                	sd	a2,0(s0)
    123e:	e414                	sd	a3,8(s0)
    1240:	e818                	sd	a4,16(s0)
    1242:	ec1c                	sd	a5,24(s0)
    1244:	03043023          	sd	a6,32(s0)
    1248:	03143423          	sd	a7,40(s0)
  va_start(ap, fmt);
    124c:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
    1250:	8622                	mv	a2,s0
    1252:	00000097          	auipc	ra,0x0
    1256:	e16080e7          	jalr	-490(ra) # 1068 <vprintf>
}
    125a:	60e2                	ld	ra,24(sp)
    125c:	6442                	ld	s0,16(sp)
    125e:	6161                	add	sp,sp,80
    1260:	8082                	ret

0000000000001262 <printf>:
{
    1262:	711d                	add	sp,sp,-96
    1264:	ec06                	sd	ra,24(sp)
    1266:	e822                	sd	s0,16(sp)
    1268:	1000                	add	s0,sp,32
    126a:	e40c                	sd	a1,8(s0)
    126c:	e810                	sd	a2,16(s0)
    126e:	ec14                	sd	a3,24(s0)
    1270:	f018                	sd	a4,32(s0)
    1272:	f41c                	sd	a5,40(s0)
    1274:	03043823          	sd	a6,48(s0)
    1278:	03143c23          	sd	a7,56(s0)
  va_start(ap, fmt);
    127c:	00840613          	add	a2,s0,8
    1280:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
    1284:	85aa                	mv	a1,a0
    1286:	4505                	li	a0,1
    1288:	00000097          	auipc	ra,0x0
    128c:	de0080e7          	jalr	-544(ra) # 1068 <vprintf>
}
    1290:	60e2                	ld	ra,24(sp)
    1292:	6442                	ld	s0,16(sp)
    1294:	6125                	add	sp,sp,96
    1296:	8082                	ret

0000000000001298 <snprintf>:

int
snprintf(char *buf, int sz, char *fmt, ...)
{
    1298:	7135                	add	sp,sp,-160
    129a:	f486                	sd	ra,104(sp)
    129c:	f0a2                	sd	s0,96(sp)
    129e:	eca6                	sd	s1,88(sp)
    12a0:	1880                	add	s0,sp,112
    12a2:	e414                	sd	a3,8(s0)
    12a4:	e818                	sd	a4,16(s0)
    12a6:	ec1c                	sd	a5,24(s0)
    12a8:	03043023          	sd	a6,32(s0)
    12ac:	03143423          	sd	a7,40(s0)
  va_list ap;
  int i, c;
  int off = 0;
  char *s;

  if (fmt == 0)
    12b0:	16060b63          	beqz	a2,1426 <snprintf+0x18e>
    12b4:	e8ca                	sd	s2,80(sp)
    12b6:	e4ce                	sd	s3,72(sp)
    12b8:	fc56                	sd	s5,56(sp)
    12ba:	f85a                	sd	s6,48(sp)
    12bc:	8b2a                	mv	s6,a0
    12be:	8aae                	mv	s5,a1
    12c0:	89b2                	mv	s3,a2
    return -1;

  va_start(ap, fmt);
    12c2:	00840793          	add	a5,s0,8
    12c6:	f8f43c23          	sd	a5,-104(s0)
  int off = 0;
    12ca:	4481                	li	s1,0
  for(i = 0; off < sz && (c = fmt[i] & 0xff) != 0; i++){
    12cc:	4901                	li	s2,0
    12ce:	00b05f63          	blez	a1,12ec <snprintf+0x54>
    12d2:	e0d2                	sd	s4,64(sp)
    12d4:	f45e                	sd	s7,40(sp)
    12d6:	f062                	sd	s8,32(sp)
    12d8:	ec66                	sd	s9,24(sp)
    if(c != '%'){
    12da:	02500a13          	li	s4,37
      continue;
    }
    c = fmt[++i] & 0xff;
    if(c == 0)
      break;
    switch(c){
    12de:	07300b93          	li	s7,115
    12e2:	07800c93          	li	s9,120
    12e6:	06400c13          	li	s8,100
    12ea:	a839                	j	1308 <snprintf+0x70>
      off += sputc(buf+off, '%');
      off += sputc(buf+off, c);
      break;
    }
  }
  return off;
    12ec:	4481                	li	s1,0
    12ee:	6946                	ld	s2,80(sp)
    12f0:	69a6                	ld	s3,72(sp)
    12f2:	7ae2                	ld	s5,56(sp)
    12f4:	7b42                	ld	s6,48(sp)
    12f6:	a0cd                	j	13d8 <snprintf+0x140>
  *s = c;
    12f8:	009b0733          	add	a4,s6,s1
    12fc:	00f70023          	sb	a5,0(a4)
      off += sputc(buf+off, c);
    1300:	2485                	addw	s1,s1,1
  for(i = 0; off < sz && (c = fmt[i] & 0xff) != 0; i++){
    1302:	2905                	addw	s2,s2,1
    1304:	1554d563          	bge	s1,s5,144e <snprintf+0x1b6>
    1308:	012987b3          	add	a5,s3,s2
    130c:	0007c783          	lbu	a5,0(a5)
    1310:	0007871b          	sext.w	a4,a5
    1314:	10078063          	beqz	a5,1414 <snprintf+0x17c>
    if(c != '%'){
    1318:	ff4710e3          	bne	a4,s4,12f8 <snprintf+0x60>
    c = fmt[++i] & 0xff;
    131c:	2905                	addw	s2,s2,1
    131e:	012987b3          	add	a5,s3,s2
    1322:	0007c783          	lbu	a5,0(a5)
    if(c == 0)
    1326:	10078263          	beqz	a5,142a <snprintf+0x192>
    switch(c){
    132a:	05778c63          	beq	a5,s7,1382 <snprintf+0xea>
    132e:	02fbe763          	bltu	s7,a5,135c <snprintf+0xc4>
    1332:	0d478063          	beq	a5,s4,13f2 <snprintf+0x15a>
    1336:	0d879463          	bne	a5,s8,13fe <snprintf+0x166>
      off += sprintint(buf+off, va_arg(ap, int), 10, 1);
    133a:	f9843783          	ld	a5,-104(s0)
    133e:	00878713          	add	a4,a5,8
    1342:	f8e43c23          	sd	a4,-104(s0)
    1346:	4685                	li	a3,1
    1348:	4629                	li	a2,10
    134a:	438c                	lw	a1,0(a5)
    134c:	009b0533          	add	a0,s6,s1
    1350:	00000097          	auipc	ra,0x0
    1354:	bb0080e7          	jalr	-1104(ra) # f00 <sprintint>
    1358:	9ca9                	addw	s1,s1,a0
      break;
    135a:	b765                	j	1302 <snprintf+0x6a>
    switch(c){
    135c:	0b979163          	bne	a5,s9,13fe <snprintf+0x166>
      off += sprintint(buf+off, va_arg(ap, int), 16, 1);
    1360:	f9843783          	ld	a5,-104(s0)
    1364:	00878713          	add	a4,a5,8
    1368:	f8e43c23          	sd	a4,-104(s0)
    136c:	4685                	li	a3,1
    136e:	4641                	li	a2,16
    1370:	438c                	lw	a1,0(a5)
    1372:	009b0533          	add	a0,s6,s1
    1376:	00000097          	auipc	ra,0x0
    137a:	b8a080e7          	jalr	-1142(ra) # f00 <sprintint>
    137e:	9ca9                	addw	s1,s1,a0
      break;
    1380:	b749                	j	1302 <snprintf+0x6a>
      if((s = va_arg(ap, char*)) == 0)
    1382:	f9843783          	ld	a5,-104(s0)
    1386:	00878713          	add	a4,a5,8
    138a:	f8e43c23          	sd	a4,-104(s0)
    138e:	6388                	ld	a0,0(a5)
    1390:	c931                	beqz	a0,13e4 <snprintf+0x14c>
      for(; *s && off < sz; s++)
    1392:	00054703          	lbu	a4,0(a0)
    1396:	d735                	beqz	a4,1302 <snprintf+0x6a>
    1398:	0b54d263          	bge	s1,s5,143c <snprintf+0x1a4>
    139c:	009b06b3          	add	a3,s6,s1
    13a0:	409a863b          	subw	a2,s5,s1
    13a4:	1602                	sll	a2,a2,0x20
    13a6:	9201                	srl	a2,a2,0x20
    13a8:	962a                	add	a2,a2,a0
    13aa:	87aa                	mv	a5,a0
        off += sputc(buf+off, *s);
    13ac:	0014859b          	addw	a1,s1,1
    13b0:	9d89                	subw	a1,a1,a0
  *s = c;
    13b2:	00e68023          	sb	a4,0(a3)
        off += sputc(buf+off, *s);
    13b6:	00f584bb          	addw	s1,a1,a5
      for(; *s && off < sz; s++)
    13ba:	0785                	add	a5,a5,1
    13bc:	0007c703          	lbu	a4,0(a5)
    13c0:	d329                	beqz	a4,1302 <snprintf+0x6a>
    13c2:	0685                	add	a3,a3,1
    13c4:	fec797e3          	bne	a5,a2,13b2 <snprintf+0x11a>
    13c8:	6946                	ld	s2,80(sp)
    13ca:	69a6                	ld	s3,72(sp)
    13cc:	6a06                	ld	s4,64(sp)
    13ce:	7ae2                	ld	s5,56(sp)
    13d0:	7b42                	ld	s6,48(sp)
    13d2:	7ba2                	ld	s7,40(sp)
    13d4:	7c02                	ld	s8,32(sp)
    13d6:	6ce2                	ld	s9,24(sp)
    13d8:	8526                	mv	a0,s1
    13da:	70a6                	ld	ra,104(sp)
    13dc:	7406                	ld	s0,96(sp)
    13de:	64e6                	ld	s1,88(sp)
    13e0:	610d                	add	sp,sp,160
    13e2:	8082                	ret
      for(; *s && off < sz; s++)
    13e4:	02800713          	li	a4,40
        s = "(null)";
    13e8:	00000517          	auipc	a0,0x0
    13ec:	50050513          	add	a0,a0,1280 # 18e8 <malloc+0x406>
    13f0:	b765                	j	1398 <snprintf+0x100>
  *s = c;
    13f2:	009b07b3          	add	a5,s6,s1
    13f6:	01478023          	sb	s4,0(a5)
      off += sputc(buf+off, '%');
    13fa:	2485                	addw	s1,s1,1
      break;
    13fc:	b719                	j	1302 <snprintf+0x6a>
  *s = c;
    13fe:	009b0733          	add	a4,s6,s1
    1402:	01470023          	sb	s4,0(a4)
      off += sputc(buf+off, c);
    1406:	0014871b          	addw	a4,s1,1
  *s = c;
    140a:	975a                	add	a4,a4,s6
    140c:	00f70023          	sb	a5,0(a4)
      off += sputc(buf+off, c);
    1410:	2489                	addw	s1,s1,2
      break;
    1412:	bdc5                	j	1302 <snprintf+0x6a>
    1414:	6946                	ld	s2,80(sp)
    1416:	69a6                	ld	s3,72(sp)
    1418:	6a06                	ld	s4,64(sp)
    141a:	7ae2                	ld	s5,56(sp)
    141c:	7b42                	ld	s6,48(sp)
    141e:	7ba2                	ld	s7,40(sp)
    1420:	7c02                	ld	s8,32(sp)
    1422:	6ce2                	ld	s9,24(sp)
    1424:	bf55                	j	13d8 <snprintf+0x140>
    return -1;
    1426:	54fd                	li	s1,-1
    1428:	bf45                	j	13d8 <snprintf+0x140>
    142a:	6946                	ld	s2,80(sp)
    142c:	69a6                	ld	s3,72(sp)
    142e:	6a06                	ld	s4,64(sp)
    1430:	7ae2                	ld	s5,56(sp)
    1432:	7b42                	ld	s6,48(sp)
    1434:	7ba2                	ld	s7,40(sp)
    1436:	7c02                	ld	s8,32(sp)
    1438:	6ce2                	ld	s9,24(sp)
    143a:	bf79                	j	13d8 <snprintf+0x140>
    143c:	6946                	ld	s2,80(sp)
    143e:	69a6                	ld	s3,72(sp)
    1440:	6a06                	ld	s4,64(sp)
    1442:	7ae2                	ld	s5,56(sp)
    1444:	7b42                	ld	s6,48(sp)
    1446:	7ba2                	ld	s7,40(sp)
    1448:	7c02                	ld	s8,32(sp)
    144a:	6ce2                	ld	s9,24(sp)
    144c:	b771                	j	13d8 <snprintf+0x140>
    144e:	6946                	ld	s2,80(sp)
    1450:	69a6                	ld	s3,72(sp)
    1452:	6a06                	ld	s4,64(sp)
    1454:	7ae2                	ld	s5,56(sp)
    1456:	7b42                	ld	s6,48(sp)
    1458:	7ba2                	ld	s7,40(sp)
    145a:	7c02                	ld	s8,32(sp)
    145c:	6ce2                	ld	s9,24(sp)
    145e:	bfad                	j	13d8 <snprintf+0x140>

0000000000001460 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    1460:	1141                	add	sp,sp,-16
    1462:	e422                	sd	s0,8(sp)
    1464:	0800                	add	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
    1466:	ff050693          	add	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    146a:	00000797          	auipc	a5,0x0
    146e:	55e7b783          	ld	a5,1374(a5) # 19c8 <freep>
    1472:	a02d                	j	149c <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
    1474:	4618                	lw	a4,8(a2)
    1476:	9f2d                	addw	a4,a4,a1
    1478:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
    147c:	6398                	ld	a4,0(a5)
    147e:	6310                	ld	a2,0(a4)
    1480:	a83d                	j	14be <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    1482:	ff852703          	lw	a4,-8(a0)
    1486:	9f31                	addw	a4,a4,a2
    1488:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
    148a:	ff053683          	ld	a3,-16(a0)
    148e:	a091                	j	14d2 <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1490:	6398                	ld	a4,0(a5)
    1492:	00e7e463          	bltu	a5,a4,149a <free+0x3a>
    1496:	00e6ea63          	bltu	a3,a4,14aa <free+0x4a>
{
    149a:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    149c:	fed7fae3          	bgeu	a5,a3,1490 <free+0x30>
    14a0:	6398                	ld	a4,0(a5)
    14a2:	00e6e463          	bltu	a3,a4,14aa <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    14a6:	fee7eae3          	bltu	a5,a4,149a <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
    14aa:	ff852583          	lw	a1,-8(a0)
    14ae:	6390                	ld	a2,0(a5)
    14b0:	02059813          	sll	a6,a1,0x20
    14b4:	01c85713          	srl	a4,a6,0x1c
    14b8:	9736                	add	a4,a4,a3
    14ba:	fae60de3          	beq	a2,a4,1474 <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
    14be:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
    14c2:	4790                	lw	a2,8(a5)
    14c4:	02061593          	sll	a1,a2,0x20
    14c8:	01c5d713          	srl	a4,a1,0x1c
    14cc:	973e                	add	a4,a4,a5
    14ce:	fae68ae3          	beq	a3,a4,1482 <free+0x22>
    p->s.ptr = bp->s.ptr;
    14d2:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
    14d4:	00000717          	auipc	a4,0x0
    14d8:	4ef73a23          	sd	a5,1268(a4) # 19c8 <freep>
}
    14dc:	6422                	ld	s0,8(sp)
    14de:	0141                	add	sp,sp,16
    14e0:	8082                	ret

00000000000014e2 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    14e2:	7139                	add	sp,sp,-64
    14e4:	fc06                	sd	ra,56(sp)
    14e6:	f822                	sd	s0,48(sp)
    14e8:	f426                	sd	s1,40(sp)
    14ea:	ec4e                	sd	s3,24(sp)
    14ec:	0080                	add	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    14ee:	02051493          	sll	s1,a0,0x20
    14f2:	9081                	srl	s1,s1,0x20
    14f4:	04bd                	add	s1,s1,15
    14f6:	8091                	srl	s1,s1,0x4
    14f8:	0014899b          	addw	s3,s1,1
    14fc:	0485                	add	s1,s1,1
  if((prevp = freep) == 0){
    14fe:	00000517          	auipc	a0,0x0
    1502:	4ca53503          	ld	a0,1226(a0) # 19c8 <freep>
    1506:	c915                	beqz	a0,153a <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1508:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    150a:	4798                	lw	a4,8(a5)
    150c:	08977e63          	bgeu	a4,s1,15a8 <malloc+0xc6>
    1510:	f04a                	sd	s2,32(sp)
    1512:	e852                	sd	s4,16(sp)
    1514:	e456                	sd	s5,8(sp)
    1516:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
    1518:	8a4e                	mv	s4,s3
    151a:	0009871b          	sext.w	a4,s3
    151e:	6685                	lui	a3,0x1
    1520:	00d77363          	bgeu	a4,a3,1526 <malloc+0x44>
    1524:	6a05                	lui	s4,0x1
    1526:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
    152a:	004a1a1b          	sllw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    152e:	00000917          	auipc	s2,0x0
    1532:	49a90913          	add	s2,s2,1178 # 19c8 <freep>
  if(p == (char*)-1)
    1536:	5afd                	li	s5,-1
    1538:	a091                	j	157c <malloc+0x9a>
    153a:	f04a                	sd	s2,32(sp)
    153c:	e852                	sd	s4,16(sp)
    153e:	e456                	sd	s5,8(sp)
    1540:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
    1542:	00001797          	auipc	a5,0x1
    1546:	87678793          	add	a5,a5,-1930 # 1db8 <base>
    154a:	00000717          	auipc	a4,0x0
    154e:	46f73f23          	sd	a5,1150(a4) # 19c8 <freep>
    1552:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
    1554:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
    1558:	b7c1                	j	1518 <malloc+0x36>
        prevp->s.ptr = p->s.ptr;
    155a:	6398                	ld	a4,0(a5)
    155c:	e118                	sd	a4,0(a0)
    155e:	a08d                	j	15c0 <malloc+0xde>
  hp->s.size = nu;
    1560:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
    1564:	0541                	add	a0,a0,16
    1566:	00000097          	auipc	ra,0x0
    156a:	efa080e7          	jalr	-262(ra) # 1460 <free>
  return freep;
    156e:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
    1572:	c13d                	beqz	a0,15d8 <malloc+0xf6>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1574:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    1576:	4798                	lw	a4,8(a5)
    1578:	02977463          	bgeu	a4,s1,15a0 <malloc+0xbe>
    if(p == freep)
    157c:	00093703          	ld	a4,0(s2)
    1580:	853e                	mv	a0,a5
    1582:	fef719e3          	bne	a4,a5,1574 <malloc+0x92>
  p = sbrk(nu * sizeof(Header));
    1586:	8552                	mv	a0,s4
    1588:	00000097          	auipc	ra,0x0
    158c:	92a080e7          	jalr	-1750(ra) # eb2 <sbrk>
  if(p == (char*)-1)
    1590:	fd5518e3          	bne	a0,s5,1560 <malloc+0x7e>
        return 0;
    1594:	4501                	li	a0,0
    1596:	7902                	ld	s2,32(sp)
    1598:	6a42                	ld	s4,16(sp)
    159a:	6aa2                	ld	s5,8(sp)
    159c:	6b02                	ld	s6,0(sp)
    159e:	a03d                	j	15cc <malloc+0xea>
    15a0:	7902                	ld	s2,32(sp)
    15a2:	6a42                	ld	s4,16(sp)
    15a4:	6aa2                	ld	s5,8(sp)
    15a6:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
    15a8:	fae489e3          	beq	s1,a4,155a <malloc+0x78>
        p->s.size -= nunits;
    15ac:	4137073b          	subw	a4,a4,s3
    15b0:	c798                	sw	a4,8(a5)
        p += p->s.size;
    15b2:	02071693          	sll	a3,a4,0x20
    15b6:	01c6d713          	srl	a4,a3,0x1c
    15ba:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
    15bc:	0137a423          	sw	s3,8(a5)
      freep = prevp;
    15c0:	00000717          	auipc	a4,0x0
    15c4:	40a73423          	sd	a0,1032(a4) # 19c8 <freep>
      return (void*)(p + 1);
    15c8:	01078513          	add	a0,a5,16
  }
}
    15cc:	70e2                	ld	ra,56(sp)
    15ce:	7442                	ld	s0,48(sp)
    15d0:	74a2                	ld	s1,40(sp)
    15d2:	69e2                	ld	s3,24(sp)
    15d4:	6121                	add	sp,sp,64
    15d6:	8082                	ret
    15d8:	7902                	ld	s2,32(sp)
    15da:	6a42                	ld	s4,16(sp)
    15dc:	6aa2                	ld	s5,8(sp)
    15de:	6b02                	ld	s6,0(sp)
    15e0:	b7f5                	j	15cc <malloc+0xea>
