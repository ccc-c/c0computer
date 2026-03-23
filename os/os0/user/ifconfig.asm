
user/_ifconfig:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <display>:
#include "kernel/net/socket.h"
#include "kernel/net/if.h"

static void
display(const char *name)
{
       0:	7111                	add	sp,sp,-256
       2:	fd86                	sd	ra,248(sp)
       4:	f9a2                	sd	s0,240(sp)
       6:	f5a6                	sd	s1,232(sp)
       8:	f1ca                	sd	s2,224(sp)
       a:	edce                	sd	s3,216(sp)
       c:	e9d2                	sd	s4,208(sp)
       e:	e5d6                	sd	s5,200(sp)
      10:	e1da                	sd	s6,192(sp)
      12:	fd5e                	sd	s7,184(sp)
      14:	0200                	add	s0,sp,256
      16:	84aa                	mv	s1,a0
    struct ifreq ifr;
    int fd;
    const char **s, *str[] = {
      18:	00001797          	auipc	a5,0x1
      1c:	3e878793          	add	a5,a5,1000 # 1400 <malloc+0x3de>
      20:	f0840713          	add	a4,s0,-248
      24:	00001317          	auipc	t1,0x1
      28:	45c30313          	add	t1,t1,1116 # 1480 <malloc+0x45e>
      2c:	0007b883          	ld	a7,0(a5)
      30:	0087b803          	ld	a6,8(a5)
      34:	6b90                	ld	a2,16(a5)
      36:	6f94                	ld	a3,24(a5)
      38:	01173023          	sd	a7,0(a4)
      3c:	01073423          	sd	a6,8(a4)
      40:	eb10                	sd	a2,16(a4)
      42:	ef14                	sd	a3,24(a4)
      44:	02078793          	add	a5,a5,32
      48:	02070713          	add	a4,a4,32
      4c:	fe6790e3          	bne	a5,t1,2c <display+0x2c>
      50:	639c                	ld	a5,0(a5)
      52:	e31c                	sd	a5,0(a4)
        NULL
    };
    unsigned short mask = 1;
    int any = 0;
    uint8_t *p; 
    fd = socket(AF_INET, SOCK_DGRAM, 0);
      54:	4601                	li	a2,0
      56:	4585                	li	a1,1
      58:	4505                	li	a0,1
      5a:	34b000ef          	jal	ba4 <socket>
      5e:	8a2a                	mv	s4,a0
    if (fd == -1)
      60:	57fd                	li	a5,-1
      62:	10f50c63          	beq	a0,a5,17a <display+0x17a>
        return;
    // name
    strcpy(ifr.ifr_name, name);
      66:	85a6                	mv	a1,s1
      68:	f9040513          	add	a0,s0,-112
      6c:	5c0000ef          	jal	62c <strcpy>
    if (ioctl(fd, SIOCGIFFLAGS, &ifr) == -1) {
      70:	f9040613          	add	a2,s0,-112
      74:	c02075b7          	lui	a1,0xc0207
      78:	90558593          	add	a1,a1,-1787 # ffffffffc0206905 <base+0xffffffffc02048f5>
      7c:	8552                	mv	a0,s4
      7e:	36f000ef          	jal	bec <ioctl>
      82:	57fd                	li	a5,-1
      84:	04f50463          	beq	a0,a5,cc <display+0xcc>
        close(fd);
        printf("ifconfig: interface %s does not exist\n", name);
        return;
    }
    printf("%s: ", ifr.ifr_name);
      88:	f9040593          	add	a1,s0,-112
      8c:	00001517          	auipc	a0,0x1
      90:	09c50513          	add	a0,a0,156 # 1128 <malloc+0x106>
      94:	6db000ef          	jal	f6e <printf>
    // flags
    printf("flags=%x<", ifr.ifr_flags);
      98:	fa041583          	lh	a1,-96(s0)
      9c:	00001517          	auipc	a0,0x1
      a0:	09450513          	add	a0,a0,148 # 1130 <malloc+0x10e>
      a4:	6cb000ef          	jal	f6e <printf>
    for (s = str; *s; s++) {
      a8:	f0843983          	ld	s3,-248(s0)
      ac:	06098263          	beqz	s3,110 <display+0x110>
    int any = 0;
      b0:	4701                	li	a4,0
    unsigned short mask = 1;
      b2:	4485                	li	s1,1
    for (s = str; *s; s++) {
      b4:	f0840913          	add	s2,s0,-248
        if (ifr.ifr_flags & mask) {
            if (any)
                printf("|");
            any = 1;
            printf("%s", *s);
      b8:	00001b17          	auipc	s6,0x1
      bc:	090b0b13          	add	s6,s6,144 # 1148 <malloc+0x126>
            any = 1;
      c0:	4a85                	li	s5,1
                printf("|");
      c2:	00001b97          	auipc	s7,0x1
      c6:	07eb8b93          	add	s7,s7,126 # 1140 <malloc+0x11e>
      ca:	a815                	j	fe <display+0xfe>
        close(fd);
      cc:	8552                	mv	a0,s4
      ce:	25f000ef          	jal	b2c <close>
        printf("ifconfig: interface %s does not exist\n", name);
      d2:	85a6                	mv	a1,s1
      d4:	00001517          	auipc	a0,0x1
      d8:	02c50513          	add	a0,a0,44 # 1100 <malloc+0xde>
      dc:	693000ef          	jal	f6e <printf>
        return;
      e0:	a869                	j	17a <display+0x17a>
            printf("%s", *s);
      e2:	85ce                	mv	a1,s3
      e4:	855a                	mv	a0,s6
      e6:	689000ef          	jal	f6e <printf>
            any = 1;
      ea:	8756                	mv	a4,s5
        }
        mask <<= 1;
      ec:	0014949b          	sllw	s1,s1,0x1
      f0:	14c2                	sll	s1,s1,0x30
      f2:	90c1                	srl	s1,s1,0x30
    for (s = str; *s; s++) {
      f4:	0921                	add	s2,s2,8
      f6:	00093983          	ld	s3,0(s2)
      fa:	00098b63          	beqz	s3,110 <display+0x110>
        if (ifr.ifr_flags & mask) {
      fe:	fa041783          	lh	a5,-96(s0)
     102:	8fe5                	and	a5,a5,s1
     104:	d7e5                	beqz	a5,ec <display+0xec>
            if (any)
     106:	df71                	beqz	a4,e2 <display+0xe2>
                printf("|");
     108:	855e                	mv	a0,s7
     10a:	665000ef          	jal	f6e <printf>
     10e:	bfd1                	j	e2 <display+0xe2>
    }
    printf(">");
     110:	00001517          	auipc	a0,0x1
     114:	04050513          	add	a0,a0,64 # 1150 <malloc+0x12e>
     118:	657000ef          	jal	f6e <printf>
    // mtu
    ifr.ifr_mtu = 1500;
     11c:	5dc00793          	li	a5,1500
     120:	faf42023          	sw	a5,-96(s0)
    if (ioctl(fd, SIOCGIFMTU, &ifr) == -1)
     124:	f9040613          	add	a2,s0,-112
     128:	c02074b7          	lui	s1,0xc0207
     12c:	90d48593          	add	a1,s1,-1779 # ffffffffc020690d <base+0xffffffffc02048fd>
     130:	8552                	mv	a0,s4
     132:	2bb000ef          	jal	bec <ioctl>
        ;//ifr.ifr_mtu = 0;
    printf(" mtu %d\n", ifr.ifr_mtu);
     136:	fa042583          	lw	a1,-96(s0)
     13a:	00001517          	auipc	a0,0x1
     13e:	01e50513          	add	a0,a0,30 # 1158 <malloc+0x136>
     142:	62d000ef          	jal	f6e <printf>
    // hwaddr
    if (ioctl(fd, SIOCGIFHWADDR, &ifr) == 0) {
     146:	f9040613          	add	a2,s0,-112
     14a:	90348593          	add	a1,s1,-1789
     14e:	8552                	mv	a0,s4
     150:	29d000ef          	jal	bec <ioctl>
     154:	cd15                	beqz	a0,190 <display+0x190>
        p = (uint8_t *)ifr.ifr_hwaddr.sa_data;
        printf("  ether %x:%x:%x:%x:%x:%x\n", p[0], p[1], p[2], p[3], p[4], p[5]);
    }
    do {
        // addr
        ifr.ifr_addr.sa_family = AF_INET;
     156:	4785                	li	a5,1
     158:	faf41023          	sh	a5,-96(s0)
        if (ioctl(fd, SIOCGIFADDR, &ifr) == -1)
     15c:	f9040613          	add	a2,s0,-112
     160:	c02075b7          	lui	a1,0xc0207
     164:	90758593          	add	a1,a1,-1785 # ffffffffc0206907 <base+0xffffffffc02048f7>
     168:	8552                	mv	a0,s4
     16a:	283000ef          	jal	bec <ioctl>
     16e:	57fd                	li	a5,-1
     170:	04f51363          	bne	a0,a5,1b6 <display+0x1b6>
        if (ioctl(fd, SIOCGIFBRDADDR, &ifr) == -1)
            break;
        p = (uint8_t *)&((struct sockaddr_in *)&ifr.ifr_broadaddr)->sin_addr;
        printf(" broadcast %d.%d.%d.%d\n", p[0], p[1], p[2], p[3]);
    } while(0);
    close(fd);
     174:	8552                	mv	a0,s4
     176:	1b7000ef          	jal	b2c <close>
}
     17a:	70ee                	ld	ra,248(sp)
     17c:	744e                	ld	s0,240(sp)
     17e:	74ae                	ld	s1,232(sp)
     180:	790e                	ld	s2,224(sp)
     182:	69ee                	ld	s3,216(sp)
     184:	6a4e                	ld	s4,208(sp)
     186:	6aae                	ld	s5,200(sp)
     188:	6b0e                	ld	s6,192(sp)
     18a:	7bea                	ld	s7,184(sp)
     18c:	6111                	add	sp,sp,256
     18e:	8082                	ret
        printf("  ether %x:%x:%x:%x:%x:%x\n", p[0], p[1], p[2], p[3], p[4], p[5]);
     190:	fa744803          	lbu	a6,-89(s0)
     194:	fa644783          	lbu	a5,-90(s0)
     198:	fa544703          	lbu	a4,-91(s0)
     19c:	fa444683          	lbu	a3,-92(s0)
     1a0:	fa344603          	lbu	a2,-93(s0)
     1a4:	fa244583          	lbu	a1,-94(s0)
     1a8:	00001517          	auipc	a0,0x1
     1ac:	fc050513          	add	a0,a0,-64 # 1168 <malloc+0x146>
     1b0:	5bf000ef          	jal	f6e <printf>
     1b4:	b74d                	j	156 <display+0x156>
        printf("  inet %d.%d.%d.%d", p[0], p[1], p[2], p[3]);
     1b6:	fa744703          	lbu	a4,-89(s0)
     1ba:	fa644683          	lbu	a3,-90(s0)
     1be:	fa544603          	lbu	a2,-91(s0)
     1c2:	fa444583          	lbu	a1,-92(s0)
     1c6:	00001517          	auipc	a0,0x1
     1ca:	fc250513          	add	a0,a0,-62 # 1188 <malloc+0x166>
     1ce:	5a1000ef          	jal	f6e <printf>
        ifr.ifr_netmask.sa_family = AF_INET;
     1d2:	4785                	li	a5,1
     1d4:	faf41023          	sh	a5,-96(s0)
        if (ioctl(fd, SIOCGIFNETMASK, &ifr) == -1)
     1d8:	f9040613          	add	a2,s0,-112
     1dc:	c02075b7          	lui	a1,0xc0207
     1e0:	90958593          	add	a1,a1,-1783 # ffffffffc0206909 <base+0xffffffffc02048f9>
     1e4:	8552                	mv	a0,s4
     1e6:	207000ef          	jal	bec <ioctl>
     1ea:	57fd                	li	a5,-1
     1ec:	f8f504e3          	beq	a0,a5,174 <display+0x174>
        printf(" netmask %d.%d.%d.%d", p[0], p[1], p[2], p[3]);
     1f0:	fa744703          	lbu	a4,-89(s0)
     1f4:	fa644683          	lbu	a3,-90(s0)
     1f8:	fa544603          	lbu	a2,-91(s0)
     1fc:	fa444583          	lbu	a1,-92(s0)
     200:	00001517          	auipc	a0,0x1
     204:	fa050513          	add	a0,a0,-96 # 11a0 <malloc+0x17e>
     208:	567000ef          	jal	f6e <printf>
        ifr.ifr_broadaddr.sa_family = AF_INET;
     20c:	4785                	li	a5,1
     20e:	faf41023          	sh	a5,-96(s0)
        if (ioctl(fd, SIOCGIFBRDADDR, &ifr) == -1)
     212:	f9040613          	add	a2,s0,-112
     216:	c02075b7          	lui	a1,0xc0207
     21a:	90b58593          	add	a1,a1,-1781 # ffffffffc020690b <base+0xffffffffc02048fb>
     21e:	8552                	mv	a0,s4
     220:	1cd000ef          	jal	bec <ioctl>
     224:	57fd                	li	a5,-1
     226:	f4f507e3          	beq	a0,a5,174 <display+0x174>
        printf(" broadcast %d.%d.%d.%d\n", p[0], p[1], p[2], p[3]);
     22a:	fa744703          	lbu	a4,-89(s0)
     22e:	fa644683          	lbu	a3,-90(s0)
     232:	fa544603          	lbu	a2,-91(s0)
     236:	fa444583          	lbu	a1,-92(s0)
     23a:	00001517          	auipc	a0,0x1
     23e:	f7e50513          	add	a0,a0,-130 # 11b8 <malloc+0x196>
     242:	52d000ef          	jal	f6e <printf>
     246:	b73d                	j	174 <display+0x174>

0000000000000248 <display_all>:

static void
display_all(void)
{
     248:	715d                	add	sp,sp,-80
     24a:	e486                	sd	ra,72(sp)
     24c:	e0a2                	sd	s0,64(sp)
     24e:	fc26                	sd	s1,56(sp)
     250:	f84a                	sd	s2,48(sp)
     252:	f44e                	sd	s3,40(sp)
     254:	0880                	add	s0,sp,80
    int fd;
    struct ifreq ifr = {.ifr_ifindex = 0};
     256:	fa043823          	sd	zero,-80(s0)
     25a:	fa043c23          	sd	zero,-72(s0)
     25e:	fc043023          	sd	zero,-64(s0)
     262:	fc043423          	sd	zero,-56(s0)

    fd = socket(AF_INET, SOCK_DGRAM, 0);
     266:	4601                	li	a2,0
     268:	4585                	li	a1,1
     26a:	4505                	li	a0,1
     26c:	139000ef          	jal	ba4 <socket>
    if (fd == -1) {
     270:	57fd                	li	a5,-1
     272:	00f50963          	beq	a0,a5,284 <display_all+0x3c>
     276:	84aa                	mv	s1,a0
        exit(-1);
    }
    while (1) {
        if (ioctl(fd, SIOCGIFNAME, &ifr) == -1)
     278:	c0207937          	lui	s2,0xc0207
     27c:	90190913          	add	s2,s2,-1791 # ffffffffc0206901 <base+0xffffffffc02048f1>
     280:	59fd                	li	s3,-1
     282:	a829                	j	29c <display_all+0x54>
        exit(-1);
     284:	557d                	li	a0,-1
     286:	07f000ef          	jal	b04 <exit>
            break;
        display(ifr.ifr_name);
     28a:	fb040513          	add	a0,s0,-80
     28e:	d73ff0ef          	jal	0 <display>
        ifr.ifr_ifindex++;
     292:	fc042783          	lw	a5,-64(s0)
     296:	2785                	addw	a5,a5,1
     298:	fcf42023          	sw	a5,-64(s0)
        if (ioctl(fd, SIOCGIFNAME, &ifr) == -1)
     29c:	fb040613          	add	a2,s0,-80
     2a0:	85ca                	mv	a1,s2
     2a2:	8526                	mv	a0,s1
     2a4:	149000ef          	jal	bec <ioctl>
     2a8:	ff3511e3          	bne	a0,s3,28a <display_all+0x42>
    }
    close(fd);
     2ac:	8526                	mv	a0,s1
     2ae:	07f000ef          	jal	b2c <close>
}
     2b2:	60a6                	ld	ra,72(sp)
     2b4:	6406                	ld	s0,64(sp)
     2b6:	74e2                	ld	s1,56(sp)
     2b8:	7942                	ld	s2,48(sp)
     2ba:	79a2                	ld	s3,40(sp)
     2bc:	6161                	add	sp,sp,80
     2be:	8082                	ret

00000000000002c0 <ifset>:
    close(fd);
}

static void
ifset(const char *name, uint32_t addr, uint32_t netmask)
{
     2c0:	715d                	add	sp,sp,-80
     2c2:	e486                	sd	ra,72(sp)
     2c4:	e0a2                	sd	s0,64(sp)
     2c6:	fc26                	sd	s1,56(sp)
     2c8:	f84a                	sd	s2,48(sp)
     2ca:	f44e                	sd	s3,40(sp)
     2cc:	f052                	sd	s4,32(sp)
     2ce:	0880                	add	s0,sp,80
     2d0:	8a2a                	mv	s4,a0
     2d2:	892e                	mv	s2,a1
     2d4:	89b2                	mv	s3,a2
    int fd;
    struct ifreq ifr;

    fd = socket(AF_INET, SOCK_DGRAM, 0);
     2d6:	4601                	li	a2,0
     2d8:	4585                	li	a1,1
     2da:	4505                	li	a0,1
     2dc:	0c9000ef          	jal	ba4 <socket>
    if (fd == -1)
     2e0:	57fd                	li	a5,-1
     2e2:	04f50d63          	beq	a0,a5,33c <ifset+0x7c>
     2e6:	84aa                	mv	s1,a0
        return;
    strcpy(ifr.ifr_name, name); 
     2e8:	85d2                	mv	a1,s4
     2ea:	fb040513          	add	a0,s0,-80
     2ee:	33e000ef          	jal	62c <strcpy>
    ifr.ifr_addr.sa_family = AF_INET;
     2f2:	4785                	li	a5,1
     2f4:	fcf41023          	sh	a5,-64(s0)
    ((struct sockaddr_in *)&ifr.ifr_addr)->sin_addr.s_addr = addr;
     2f8:	fd242223          	sw	s2,-60(s0)
    if (ioctl(fd, SIOCSIFADDR, &ifr) == -1) {
     2fc:	fb040613          	add	a2,s0,-80
     300:	802075b7          	lui	a1,0x80207
     304:	90858593          	add	a1,a1,-1784 # ffffffff80206908 <base+0xffffffff802048f8>
     308:	8526                	mv	a0,s1
     30a:	0e3000ef          	jal	bec <ioctl>
     30e:	57fd                	li	a5,-1
     310:	02f50e63          	beq	a0,a5,34c <ifset+0x8c>
        close(fd);
        printf("ifconfig: ioctl(SIOCSIFADDR) failure, interface=%s\n", name);
        return;
    }
    ifr.ifr_netmask.sa_family = AF_INET;
     314:	4785                	li	a5,1
     316:	fcf41023          	sh	a5,-64(s0)
    ((struct sockaddr_in *)&ifr.ifr_netmask)->sin_addr.s_addr = netmask;
     31a:	fd342223          	sw	s3,-60(s0)
    if (ioctl(fd, SIOCSIFNETMASK, &ifr) == -1) {
     31e:	fb040613          	add	a2,s0,-80
     322:	802075b7          	lui	a1,0x80207
     326:	90a58593          	add	a1,a1,-1782 # ffffffff8020690a <base+0xffffffff802048fa>
     32a:	8526                	mv	a0,s1
     32c:	0c1000ef          	jal	bec <ioctl>
     330:	57fd                	li	a5,-1
     332:	02f50863          	beq	a0,a5,362 <ifset+0xa2>
        close(fd);
        printf("ifconfig: ioctl(SIOCSIFNETMASK) failure, interface=%s\n", name);
        return;
    }
    close(fd);
     336:	8526                	mv	a0,s1
     338:	7f4000ef          	jal	b2c <close>
}
     33c:	60a6                	ld	ra,72(sp)
     33e:	6406                	ld	s0,64(sp)
     340:	74e2                	ld	s1,56(sp)
     342:	7942                	ld	s2,48(sp)
     344:	79a2                	ld	s3,40(sp)
     346:	7a02                	ld	s4,32(sp)
     348:	6161                	add	sp,sp,80
     34a:	8082                	ret
        close(fd);
     34c:	8526                	mv	a0,s1
     34e:	7de000ef          	jal	b2c <close>
        printf("ifconfig: ioctl(SIOCSIFADDR) failure, interface=%s\n", name);
     352:	85d2                	mv	a1,s4
     354:	00001517          	auipc	a0,0x1
     358:	e7c50513          	add	a0,a0,-388 # 11d0 <malloc+0x1ae>
     35c:	413000ef          	jal	f6e <printf>
        return;
     360:	bff1                	j	33c <ifset+0x7c>
        close(fd);
     362:	8526                	mv	a0,s1
     364:	7c8000ef          	jal	b2c <close>
        printf("ifconfig: ioctl(SIOCSIFNETMASK) failure, interface=%s\n", name);
     368:	85d2                	mv	a1,s4
     36a:	00001517          	auipc	a0,0x1
     36e:	e9e50513          	add	a0,a0,-354 # 1208 <malloc+0x1e6>
     372:	3fd000ef          	jal	f6e <printf>
        return;
     376:	b7d9                	j	33c <ifset+0x7c>

0000000000000378 <usage>:

static void
usage(void)
{
     378:	1141                	add	sp,sp,-16
     37a:	e406                	sd	ra,8(sp)
     37c:	e022                	sd	s0,0(sp)
     37e:	0800                	add	s0,sp,16
    printf("usage: ifconfig interface [command|address]\n");
     380:	00001517          	auipc	a0,0x1
     384:	ec050513          	add	a0,a0,-320 # 1240 <malloc+0x21e>
     388:	3e7000ef          	jal	f6e <printf>
    printf("           - command: up | down\n");
     38c:	00001517          	auipc	a0,0x1
     390:	ee450513          	add	a0,a0,-284 # 1270 <malloc+0x24e>
     394:	3db000ef          	jal	f6e <printf>
    printf("           - address: ADDRESS/PREFIX | ADDRESS netmask NETMASK\n");
     398:	00001517          	auipc	a0,0x1
     39c:	f0050513          	add	a0,a0,-256 # 1298 <malloc+0x276>
     3a0:	3cf000ef          	jal	f6e <printf>
    printf("       ifconfig [-a]\n");
     3a4:	00001517          	auipc	a0,0x1
     3a8:	f3450513          	add	a0,a0,-204 # 12d8 <malloc+0x2b6>
     3ac:	3c3000ef          	jal	f6e <printf>
    exit(-1);
     3b0:	557d                	li	a0,-1
     3b2:	752000ef          	jal	b04 <exit>

00000000000003b6 <main>:
}

int
main(int argc, char *argv[])
{
     3b6:	715d                	add	sp,sp,-80
     3b8:	e486                	sd	ra,72(sp)
     3ba:	e0a2                	sd	s0,64(sp)
     3bc:	fc26                	sd	s1,56(sp)
     3be:	f84a                	sd	s2,48(sp)
     3c0:	0880                	add	s0,sp,80
    char *s;
    uint32_t addr, netmask;
    int prefix = 0;

    if (argc == 1) {
     3c2:	4785                	li	a5,1
     3c4:	00f50e63          	beq	a0,a5,3e0 <main+0x2a>
     3c8:	84ae                	mv	s1,a1
        display_all();
        exit(0);
    }
    if (argc == 2) {
     3ca:	4789                	li	a5,2
     3cc:	00f50f63          	beq	a0,a5,3ea <main+0x34>
            display_all();
        else
            display(argv[1]);
        exit(0);
    }
    if (argc == 3) {
     3d0:	478d                	li	a5,3
     3d2:	02f50e63          	beq	a0,a5,40e <main+0x58>
            usage();
        netmask = htonl(0xffffffff << (32 - prefix));
        ifset(argv[1], addr, netmask);
        exit(0);
    }
    if (argc == 5) {
     3d6:	4795                	li	a5,5
     3d8:	1ef50763          	beq	a0,a5,5c6 <main+0x210>
        if (inet_pton(AF_INET, argv[4], (struct in_addr *)&netmask) == -1)
            usage();
        ifset(argv[1], addr, netmask);
        exit(0);
    }
    usage();
     3dc:	f9dff0ef          	jal	378 <usage>
        display_all();
     3e0:	e69ff0ef          	jal	248 <display_all>
        exit(0);
     3e4:	4501                	li	a0,0
     3e6:	71e000ef          	jal	b04 <exit>
        if (strcmp(argv[1], "-a") == 0)
     3ea:	6584                	ld	s1,8(a1)
     3ec:	00001597          	auipc	a1,0x1
     3f0:	f0458593          	add	a1,a1,-252 # 12f0 <malloc+0x2ce>
     3f4:	8526                	mv	a0,s1
     3f6:	252000ef          	jal	648 <strcmp>
     3fa:	e511                	bnez	a0,406 <main+0x50>
            display_all();
     3fc:	e4dff0ef          	jal	248 <display_all>
        exit(0);
     400:	4501                	li	a0,0
     402:	702000ef          	jal	b04 <exit>
            display(argv[1]);
     406:	8526                	mv	a0,s1
     408:	bf9ff0ef          	jal	0 <display>
     40c:	bfd5                	j	400 <main+0x4a>
        if (strcmp(argv[2], "up") == 0) {
     40e:	0105b903          	ld	s2,16(a1)
     412:	00001597          	auipc	a1,0x1
     416:	ee658593          	add	a1,a1,-282 # 12f8 <malloc+0x2d6>
     41a:	854a                	mv	a0,s2
     41c:	22c000ef          	jal	648 <strcmp>
     420:	cd2d                	beqz	a0,49a <main+0xe4>
        if (strcmp(argv[2], "down") == 0) {
     422:	00001597          	auipc	a1,0x1
     426:	f1658593          	add	a1,a1,-234 # 1338 <malloc+0x316>
     42a:	854a                	mv	a0,s2
     42c:	21c000ef          	jal	648 <strcmp>
     430:	12051563          	bnez	a0,55a <main+0x1a4>
            ifdown(argv[1]);
     434:	0084b903          	ld	s2,8(s1)
    fd = socket(AF_INET, SOCK_DGRAM, 0);
     438:	4601                	li	a2,0
     43a:	4585                	li	a1,1
     43c:	4505                	li	a0,1
     43e:	766000ef          	jal	ba4 <socket>
     442:	84aa                	mv	s1,a0
    if (fd == -1)
     444:	57fd                	li	a5,-1
     446:	04f50763          	beq	a0,a5,494 <main+0xde>
    strcpy(ifr.ifr_name, name);
     44a:	85ca                	mv	a1,s2
     44c:	fb840513          	add	a0,s0,-72
     450:	1dc000ef          	jal	62c <strcpy>
    if (ioctl(fd, SIOCGIFFLAGS, &ifr) == -1) {
     454:	fb840613          	add	a2,s0,-72
     458:	c02075b7          	lui	a1,0xc0207
     45c:	90558593          	add	a1,a1,-1787 # ffffffffc0206905 <base+0xffffffffc02048f5>
     460:	8526                	mv	a0,s1
     462:	78a000ef          	jal	bec <ioctl>
     466:	57fd                	li	a5,-1
     468:	0cf50363          	beq	a0,a5,52e <main+0x178>
    ifr.ifr_flags &= ~IFF_UP;
     46c:	fc845783          	lhu	a5,-56(s0)
     470:	9bf9                	and	a5,a5,-2
     472:	fcf41423          	sh	a5,-56(s0)
    if (ioctl(fd, SIOCSIFFLAGS, &ifr) == -1) {
     476:	fb840613          	add	a2,s0,-72
     47a:	802075b7          	lui	a1,0x80207
     47e:	90658593          	add	a1,a1,-1786 # ffffffff80206906 <base+0xffffffff802048f6>
     482:	8526                	mv	a0,s1
     484:	768000ef          	jal	bec <ioctl>
     488:	57fd                	li	a5,-1
     48a:	0af50d63          	beq	a0,a5,544 <main+0x18e>
    close(fd);
     48e:	8526                	mv	a0,s1
     490:	69c000ef          	jal	b2c <close>
            exit(0);
     494:	4501                	li	a0,0
     496:	66e000ef          	jal	b04 <exit>
            ifup(argv[1]);
     49a:	0084b903          	ld	s2,8(s1)
    fd = socket(AF_INET, SOCK_DGRAM, 0);
     49e:	4601                	li	a2,0
     4a0:	4585                	li	a1,1
     4a2:	4505                	li	a0,1
     4a4:	700000ef          	jal	ba4 <socket>
     4a8:	84aa                	mv	s1,a0
    if (fd == -1)
     4aa:	57fd                	li	a5,-1
     4ac:	04f50863          	beq	a0,a5,4fc <main+0x146>
    strcpy(ifr.ifr_name, name);
     4b0:	85ca                	mv	a1,s2
     4b2:	fb840513          	add	a0,s0,-72
     4b6:	176000ef          	jal	62c <strcpy>
    if (ioctl(fd, SIOCGIFFLAGS, &ifr) == -1) {
     4ba:	fb840613          	add	a2,s0,-72
     4be:	c02075b7          	lui	a1,0xc0207
     4c2:	90558593          	add	a1,a1,-1787 # ffffffffc0206905 <base+0xffffffffc02048f5>
     4c6:	8526                	mv	a0,s1
     4c8:	724000ef          	jal	bec <ioctl>
     4cc:	57fd                	li	a5,-1
     4ce:	02f50a63          	beq	a0,a5,502 <main+0x14c>
    ifr.ifr_flags |= IFF_UP;
     4d2:	fc845783          	lhu	a5,-56(s0)
     4d6:	0017e793          	or	a5,a5,1
     4da:	fcf41423          	sh	a5,-56(s0)
    if (ioctl(fd, SIOCSIFFLAGS, &ifr) == -1) {
     4de:	fb840613          	add	a2,s0,-72
     4e2:	802075b7          	lui	a1,0x80207
     4e6:	90658593          	add	a1,a1,-1786 # ffffffff80206906 <base+0xffffffff802048f6>
     4ea:	8526                	mv	a0,s1
     4ec:	700000ef          	jal	bec <ioctl>
     4f0:	57fd                	li	a5,-1
     4f2:	02f50363          	beq	a0,a5,518 <main+0x162>
    close(fd);
     4f6:	8526                	mv	a0,s1
     4f8:	634000ef          	jal	b2c <close>
            exit(0);
     4fc:	4501                	li	a0,0
     4fe:	606000ef          	jal	b04 <exit>
        close(fd);
     502:	8526                	mv	a0,s1
     504:	628000ef          	jal	b2c <close>
        printf("ifconfig: interface %s does not exist\n", name);
     508:	85ca                	mv	a1,s2
     50a:	00001517          	auipc	a0,0x1
     50e:	bf650513          	add	a0,a0,-1034 # 1100 <malloc+0xde>
     512:	25d000ef          	jal	f6e <printf>
        return;
     516:	b7dd                	j	4fc <main+0x146>
        close(fd);
     518:	8526                	mv	a0,s1
     51a:	612000ef          	jal	b2c <close>
        printf("ifconfig: ioctl(SIOCSIFFLAGS) failure, interface=%s\n", name);
     51e:	85ca                	mv	a1,s2
     520:	00001517          	auipc	a0,0x1
     524:	de050513          	add	a0,a0,-544 # 1300 <malloc+0x2de>
     528:	247000ef          	jal	f6e <printf>
        return;
     52c:	bfc1                	j	4fc <main+0x146>
        close(fd);
     52e:	8526                	mv	a0,s1
     530:	5fc000ef          	jal	b2c <close>
        printf("ifconfig: interface %s does not exist\n", name);
     534:	85ca                	mv	a1,s2
     536:	00001517          	auipc	a0,0x1
     53a:	bca50513          	add	a0,a0,-1078 # 1100 <malloc+0xde>
     53e:	231000ef          	jal	f6e <printf>
        return;
     542:	bf89                	j	494 <main+0xde>
        close(fd);
     544:	8526                	mv	a0,s1
     546:	5e6000ef          	jal	b2c <close>
        printf("ifconfig: ioctl(SIOCSIFFLAGS) failure, interface=%s\n", name);
     54a:	85ca                	mv	a1,s2
     54c:	00001517          	auipc	a0,0x1
     550:	db450513          	add	a0,a0,-588 # 1300 <malloc+0x2de>
     554:	21b000ef          	jal	f6e <printf>
        return;
     558:	bf35                	j	494 <main+0xde>
        s = strchr(argv[2], '/');
     55a:	02f00593          	li	a1,47
     55e:	854a                	mv	a0,s2
     560:	160000ef          	jal	6c0 <strchr>
     564:	892a                	mv	s2,a0
        if (!s)
     566:	c905                	beqz	a0,596 <main+0x1e0>
        *s++ = 0;
     568:	00050023          	sb	zero,0(a0)
        if (inet_pton(AF_INET, argv[2], (struct in_addr *)&addr) == -1)
     56c:	fdc40613          	add	a2,s0,-36
     570:	688c                	ld	a1,16(s1)
     572:	4505                	li	a0,1
     574:	4f2000ef          	jal	a66 <inet_pton>
     578:	57fd                	li	a5,-1
     57a:	02f50063          	beq	a0,a5,59a <main+0x1e4>
        prefix = atoi(s);
     57e:	00190513          	add	a0,s2,1
     582:	20c000ef          	jal	78e <atoi>
        if (prefix < 0 || prefix > 32)
     586:	0005071b          	sext.w	a4,a0
     58a:	02000793          	li	a5,32
     58e:	00e7f863          	bgeu	a5,a4,59e <main+0x1e8>
            usage();
     592:	de7ff0ef          	jal	378 <usage>
            usage();
     596:	de3ff0ef          	jal	378 <usage>
            usage();
     59a:	ddfff0ef          	jal	378 <usage>
        netmask = htonl(0xffffffff << (32 - prefix));
     59e:	02000793          	li	a5,32
     5a2:	9f89                	subw	a5,a5,a0
     5a4:	557d                	li	a0,-1
     5a6:	00f5153b          	sllw	a0,a0,a5
     5aa:	34a000ef          	jal	8f4 <htonl>
     5ae:	0005061b          	sext.w	a2,a0
     5b2:	fcc42c23          	sw	a2,-40(s0)
        ifset(argv[1], addr, netmask);
     5b6:	fdc42583          	lw	a1,-36(s0)
     5ba:	6488                	ld	a0,8(s1)
     5bc:	d05ff0ef          	jal	2c0 <ifset>
        exit(0);
     5c0:	4501                	li	a0,0
     5c2:	542000ef          	jal	b04 <exit>
        if (inet_pton(AF_INET, argv[2], (struct in_addr *)&addr) == -1)
     5c6:	fdc40613          	add	a2,s0,-36
     5ca:	698c                	ld	a1,16(a1)
     5cc:	4505                	li	a0,1
     5ce:	498000ef          	jal	a66 <inet_pton>
     5d2:	57fd                	li	a5,-1
     5d4:	00f50c63          	beq	a0,a5,5ec <main+0x236>
        if (strcmp(argv[3], "netmask") != 0)
     5d8:	00001597          	auipc	a1,0x1
     5dc:	d6858593          	add	a1,a1,-664 # 1340 <malloc+0x31e>
     5e0:	6c88                	ld	a0,24(s1)
     5e2:	066000ef          	jal	648 <strcmp>
     5e6:	c509                	beqz	a0,5f0 <main+0x23a>
            usage();
     5e8:	d91ff0ef          	jal	378 <usage>
            usage();
     5ec:	d8dff0ef          	jal	378 <usage>
        if (inet_pton(AF_INET, argv[4], (struct in_addr *)&netmask) == -1)
     5f0:	fd840613          	add	a2,s0,-40
     5f4:	708c                	ld	a1,32(s1)
     5f6:	4505                	li	a0,1
     5f8:	46e000ef          	jal	a66 <inet_pton>
     5fc:	57fd                	li	a5,-1
     5fe:	00f50c63          	beq	a0,a5,616 <main+0x260>
        ifset(argv[1], addr, netmask);
     602:	fd842603          	lw	a2,-40(s0)
     606:	fdc42583          	lw	a1,-36(s0)
     60a:	6488                	ld	a0,8(s1)
     60c:	cb5ff0ef          	jal	2c0 <ifset>
        exit(0);
     610:	4501                	li	a0,0
     612:	4f2000ef          	jal	b04 <exit>
            usage();
     616:	d63ff0ef          	jal	378 <usage>

000000000000061a <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start()
{
     61a:	1141                	add	sp,sp,-16
     61c:	e406                	sd	ra,8(sp)
     61e:	e022                	sd	s0,0(sp)
     620:	0800                	add	s0,sp,16
  extern int main();
  main();
     622:	d95ff0ef          	jal	3b6 <main>
  exit(0);
     626:	4501                	li	a0,0
     628:	4dc000ef          	jal	b04 <exit>

000000000000062c <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
     62c:	1141                	add	sp,sp,-16
     62e:	e422                	sd	s0,8(sp)
     630:	0800                	add	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
     632:	87aa                	mv	a5,a0
     634:	0585                	add	a1,a1,1
     636:	0785                	add	a5,a5,1
     638:	fff5c703          	lbu	a4,-1(a1)
     63c:	fee78fa3          	sb	a4,-1(a5)
     640:	fb75                	bnez	a4,634 <strcpy+0x8>
    ;
  return os;
}
     642:	6422                	ld	s0,8(sp)
     644:	0141                	add	sp,sp,16
     646:	8082                	ret

0000000000000648 <strcmp>:

int
strcmp(const char *p, const char *q)
{
     648:	1141                	add	sp,sp,-16
     64a:	e422                	sd	s0,8(sp)
     64c:	0800                	add	s0,sp,16
  while(*p && *p == *q)
     64e:	00054783          	lbu	a5,0(a0)
     652:	cb91                	beqz	a5,666 <strcmp+0x1e>
     654:	0005c703          	lbu	a4,0(a1)
     658:	00f71763          	bne	a4,a5,666 <strcmp+0x1e>
    p++, q++;
     65c:	0505                	add	a0,a0,1
     65e:	0585                	add	a1,a1,1
  while(*p && *p == *q)
     660:	00054783          	lbu	a5,0(a0)
     664:	fbe5                	bnez	a5,654 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
     666:	0005c503          	lbu	a0,0(a1)
}
     66a:	40a7853b          	subw	a0,a5,a0
     66e:	6422                	ld	s0,8(sp)
     670:	0141                	add	sp,sp,16
     672:	8082                	ret

0000000000000674 <strlen>:

uint
strlen(const char *s)
{
     674:	1141                	add	sp,sp,-16
     676:	e422                	sd	s0,8(sp)
     678:	0800                	add	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
     67a:	00054783          	lbu	a5,0(a0)
     67e:	cf91                	beqz	a5,69a <strlen+0x26>
     680:	0505                	add	a0,a0,1
     682:	87aa                	mv	a5,a0
     684:	86be                	mv	a3,a5
     686:	0785                	add	a5,a5,1
     688:	fff7c703          	lbu	a4,-1(a5)
     68c:	ff65                	bnez	a4,684 <strlen+0x10>
     68e:	40a6853b          	subw	a0,a3,a0
     692:	2505                	addw	a0,a0,1
    ;
  return n;
}
     694:	6422                	ld	s0,8(sp)
     696:	0141                	add	sp,sp,16
     698:	8082                	ret
  for(n = 0; s[n]; n++)
     69a:	4501                	li	a0,0
     69c:	bfe5                	j	694 <strlen+0x20>

000000000000069e <memset>:

void*
memset(void *dst, int c, uint n)
{
     69e:	1141                	add	sp,sp,-16
     6a0:	e422                	sd	s0,8(sp)
     6a2:	0800                	add	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
     6a4:	ca19                	beqz	a2,6ba <memset+0x1c>
     6a6:	87aa                	mv	a5,a0
     6a8:	1602                	sll	a2,a2,0x20
     6aa:	9201                	srl	a2,a2,0x20
     6ac:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
     6b0:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
     6b4:	0785                	add	a5,a5,1
     6b6:	fee79de3          	bne	a5,a4,6b0 <memset+0x12>
  }
  return dst;
}
     6ba:	6422                	ld	s0,8(sp)
     6bc:	0141                	add	sp,sp,16
     6be:	8082                	ret

00000000000006c0 <strchr>:

char*
strchr(const char *s, char c)
{
     6c0:	1141                	add	sp,sp,-16
     6c2:	e422                	sd	s0,8(sp)
     6c4:	0800                	add	s0,sp,16
  for(; *s; s++)
     6c6:	00054783          	lbu	a5,0(a0)
     6ca:	cb99                	beqz	a5,6e0 <strchr+0x20>
    if(*s == c)
     6cc:	00f58763          	beq	a1,a5,6da <strchr+0x1a>
  for(; *s; s++)
     6d0:	0505                	add	a0,a0,1
     6d2:	00054783          	lbu	a5,0(a0)
     6d6:	fbfd                	bnez	a5,6cc <strchr+0xc>
      return (char*)s;
  return 0;
     6d8:	4501                	li	a0,0
}
     6da:	6422                	ld	s0,8(sp)
     6dc:	0141                	add	sp,sp,16
     6de:	8082                	ret
  return 0;
     6e0:	4501                	li	a0,0
     6e2:	bfe5                	j	6da <strchr+0x1a>

00000000000006e4 <gets>:

char*
gets(char *buf, int max)
{
     6e4:	711d                	add	sp,sp,-96
     6e6:	ec86                	sd	ra,88(sp)
     6e8:	e8a2                	sd	s0,80(sp)
     6ea:	e4a6                	sd	s1,72(sp)
     6ec:	e0ca                	sd	s2,64(sp)
     6ee:	fc4e                	sd	s3,56(sp)
     6f0:	f852                	sd	s4,48(sp)
     6f2:	f456                	sd	s5,40(sp)
     6f4:	f05a                	sd	s6,32(sp)
     6f6:	ec5e                	sd	s7,24(sp)
     6f8:	1080                	add	s0,sp,96
     6fa:	8baa                	mv	s7,a0
     6fc:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     6fe:	892a                	mv	s2,a0
     700:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
     702:	4aa9                	li	s5,10
     704:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
     706:	89a6                	mv	s3,s1
     708:	2485                	addw	s1,s1,1
     70a:	0344d663          	bge	s1,s4,736 <gets+0x52>
    cc = read(0, &c, 1);
     70e:	4605                	li	a2,1
     710:	faf40593          	add	a1,s0,-81
     714:	4501                	li	a0,0
     716:	406000ef          	jal	b1c <read>
    if(cc < 1)
     71a:	00a05e63          	blez	a0,736 <gets+0x52>
    buf[i++] = c;
     71e:	faf44783          	lbu	a5,-81(s0)
     722:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
     726:	01578763          	beq	a5,s5,734 <gets+0x50>
     72a:	0905                	add	s2,s2,1
     72c:	fd679de3          	bne	a5,s6,706 <gets+0x22>
  for(i=0; i+1 < max; ){
     730:	89a6                	mv	s3,s1
     732:	a011                	j	736 <gets+0x52>
     734:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
     736:	99de                	add	s3,s3,s7
     738:	00098023          	sb	zero,0(s3)
  return buf;
}
     73c:	855e                	mv	a0,s7
     73e:	60e6                	ld	ra,88(sp)
     740:	6446                	ld	s0,80(sp)
     742:	64a6                	ld	s1,72(sp)
     744:	6906                	ld	s2,64(sp)
     746:	79e2                	ld	s3,56(sp)
     748:	7a42                	ld	s4,48(sp)
     74a:	7aa2                	ld	s5,40(sp)
     74c:	7b02                	ld	s6,32(sp)
     74e:	6be2                	ld	s7,24(sp)
     750:	6125                	add	sp,sp,96
     752:	8082                	ret

0000000000000754 <stat>:

int
stat(const char *n, struct stat *st)
{
     754:	1101                	add	sp,sp,-32
     756:	ec06                	sd	ra,24(sp)
     758:	e822                	sd	s0,16(sp)
     75a:	e426                	sd	s1,8(sp)
     75c:	e04a                	sd	s2,0(sp)
     75e:	1000                	add	s0,sp,32
     760:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     762:	4581                	li	a1,0
     764:	3e0000ef          	jal	b44 <open>
  if(fd < 0)
     768:	02054163          	bltz	a0,78a <stat+0x36>
     76c:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
     76e:	85ca                	mv	a1,s2
     770:	3ec000ef          	jal	b5c <fstat>
     774:	892a                	mv	s2,a0
  close(fd);
     776:	8526                	mv	a0,s1
     778:	3b4000ef          	jal	b2c <close>
  return r;
}
     77c:	854a                	mv	a0,s2
     77e:	60e2                	ld	ra,24(sp)
     780:	6442                	ld	s0,16(sp)
     782:	64a2                	ld	s1,8(sp)
     784:	6902                	ld	s2,0(sp)
     786:	6105                	add	sp,sp,32
     788:	8082                	ret
    return -1;
     78a:	597d                	li	s2,-1
     78c:	bfc5                	j	77c <stat+0x28>

000000000000078e <atoi>:

int
atoi(const char *s)
{
     78e:	1141                	add	sp,sp,-16
     790:	e422                	sd	s0,8(sp)
     792:	0800                	add	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
     794:	00054683          	lbu	a3,0(a0)
     798:	fd06879b          	addw	a5,a3,-48
     79c:	0ff7f793          	zext.b	a5,a5
     7a0:	4625                	li	a2,9
     7a2:	02f66863          	bltu	a2,a5,7d2 <atoi+0x44>
     7a6:	872a                	mv	a4,a0
  n = 0;
     7a8:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
     7aa:	0705                	add	a4,a4,1
     7ac:	0025179b          	sllw	a5,a0,0x2
     7b0:	9fa9                	addw	a5,a5,a0
     7b2:	0017979b          	sllw	a5,a5,0x1
     7b6:	9fb5                	addw	a5,a5,a3
     7b8:	fd07851b          	addw	a0,a5,-48
  while('0' <= *s && *s <= '9')
     7bc:	00074683          	lbu	a3,0(a4)
     7c0:	fd06879b          	addw	a5,a3,-48
     7c4:	0ff7f793          	zext.b	a5,a5
     7c8:	fef671e3          	bgeu	a2,a5,7aa <atoi+0x1c>
  return n;
}
     7cc:	6422                	ld	s0,8(sp)
     7ce:	0141                	add	sp,sp,16
     7d0:	8082                	ret
  n = 0;
     7d2:	4501                	li	a0,0
     7d4:	bfe5                	j	7cc <atoi+0x3e>

00000000000007d6 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
     7d6:	1141                	add	sp,sp,-16
     7d8:	e422                	sd	s0,8(sp)
     7da:	0800                	add	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
     7dc:	02b57463          	bgeu	a0,a1,804 <memmove+0x2e>
    while(n-- > 0)
     7e0:	00c05f63          	blez	a2,7fe <memmove+0x28>
     7e4:	1602                	sll	a2,a2,0x20
     7e6:	9201                	srl	a2,a2,0x20
     7e8:	00c507b3          	add	a5,a0,a2
  dst = vdst;
     7ec:	872a                	mv	a4,a0
      *dst++ = *src++;
     7ee:	0585                	add	a1,a1,1
     7f0:	0705                	add	a4,a4,1
     7f2:	fff5c683          	lbu	a3,-1(a1)
     7f6:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
     7fa:	fee79ae3          	bne	a5,a4,7ee <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
     7fe:	6422                	ld	s0,8(sp)
     800:	0141                	add	sp,sp,16
     802:	8082                	ret
    dst += n;
     804:	00c50733          	add	a4,a0,a2
    src += n;
     808:	95b2                	add	a1,a1,a2
    while(n-- > 0)
     80a:	fec05ae3          	blez	a2,7fe <memmove+0x28>
     80e:	fff6079b          	addw	a5,a2,-1
     812:	1782                	sll	a5,a5,0x20
     814:	9381                	srl	a5,a5,0x20
     816:	fff7c793          	not	a5,a5
     81a:	97ba                	add	a5,a5,a4
      *--dst = *--src;
     81c:	15fd                	add	a1,a1,-1
     81e:	177d                	add	a4,a4,-1
     820:	0005c683          	lbu	a3,0(a1)
     824:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
     828:	fee79ae3          	bne	a5,a4,81c <memmove+0x46>
     82c:	bfc9                	j	7fe <memmove+0x28>

000000000000082e <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
     82e:	1141                	add	sp,sp,-16
     830:	e422                	sd	s0,8(sp)
     832:	0800                	add	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
     834:	ca05                	beqz	a2,864 <memcmp+0x36>
     836:	fff6069b          	addw	a3,a2,-1
     83a:	1682                	sll	a3,a3,0x20
     83c:	9281                	srl	a3,a3,0x20
     83e:	0685                	add	a3,a3,1
     840:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
     842:	00054783          	lbu	a5,0(a0)
     846:	0005c703          	lbu	a4,0(a1)
     84a:	00e79863          	bne	a5,a4,85a <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
     84e:	0505                	add	a0,a0,1
    p2++;
     850:	0585                	add	a1,a1,1
  while (n-- > 0) {
     852:	fed518e3          	bne	a0,a3,842 <memcmp+0x14>
  }
  return 0;
     856:	4501                	li	a0,0
     858:	a019                	j	85e <memcmp+0x30>
      return *p1 - *p2;
     85a:	40e7853b          	subw	a0,a5,a4
}
     85e:	6422                	ld	s0,8(sp)
     860:	0141                	add	sp,sp,16
     862:	8082                	ret
  return 0;
     864:	4501                	li	a0,0
     866:	bfe5                	j	85e <memcmp+0x30>

0000000000000868 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
     868:	1141                	add	sp,sp,-16
     86a:	e406                	sd	ra,8(sp)
     86c:	e022                	sd	s0,0(sp)
     86e:	0800                	add	s0,sp,16
  return memmove(dst, src, n);
     870:	f67ff0ef          	jal	7d6 <memmove>
}
     874:	60a2                	ld	ra,8(sp)
     876:	6402                	ld	s0,0(sp)
     878:	0141                	add	sp,sp,16
     87a:	8082                	ret

000000000000087c <htons>:
    return (v & 0x000000ff) << 24 | (v & 0x0000ff00) << 8 | (v & 0x00ff0000) >> 8 | (v & 0xff000000) >> 24;
}

uint16_t
htons(uint16_t h)
{
     87c:	1141                	add	sp,sp,-16
     87e:	e422                	sd	s0,8(sp)
     880:	0800                	add	s0,sp,16
    if (!endian) {
     882:	00001797          	auipc	a5,0x1
     886:	77e7a783          	lw	a5,1918(a5) # 2000 <endian>
     88a:	e385                	bnez	a5,8aa <htons+0x2e>
        endian = byteorder();
     88c:	4d200793          	li	a5,1234
     890:	00001717          	auipc	a4,0x1
     894:	76f72823          	sw	a5,1904(a4) # 2000 <endian>
    return (v & 0x00ff) << 8 | (v & 0xff00 ) >> 8;
     898:	0085579b          	srlw	a5,a0,0x8
     89c:	0085151b          	sllw	a0,a0,0x8
     8a0:	8fc9                	or	a5,a5,a0
     8a2:	03079513          	sll	a0,a5,0x30
     8a6:	9141                	srl	a0,a0,0x30
     8a8:	a029                	j	8b2 <htons+0x36>
    }
    return endian == __LITTLE_ENDIAN ? byteswap16(h) : h;
     8aa:	4d200713          	li	a4,1234
     8ae:	fee785e3          	beq	a5,a4,898 <htons+0x1c>
}
     8b2:	6422                	ld	s0,8(sp)
     8b4:	0141                	add	sp,sp,16
     8b6:	8082                	ret

00000000000008b8 <ntohs>:

uint16_t
ntohs(uint16_t n)
{
     8b8:	1141                	add	sp,sp,-16
     8ba:	e422                	sd	s0,8(sp)
     8bc:	0800                	add	s0,sp,16
    if (!endian) {
     8be:	00001797          	auipc	a5,0x1
     8c2:	7427a783          	lw	a5,1858(a5) # 2000 <endian>
     8c6:	e385                	bnez	a5,8e6 <ntohs+0x2e>
        endian = byteorder();
     8c8:	4d200793          	li	a5,1234
     8cc:	00001717          	auipc	a4,0x1
     8d0:	72f72a23          	sw	a5,1844(a4) # 2000 <endian>
    return (v & 0x00ff) << 8 | (v & 0xff00 ) >> 8;
     8d4:	0085579b          	srlw	a5,a0,0x8
     8d8:	0085151b          	sllw	a0,a0,0x8
     8dc:	8fc9                	or	a5,a5,a0
     8de:	03079513          	sll	a0,a5,0x30
     8e2:	9141                	srl	a0,a0,0x30
     8e4:	a029                	j	8ee <ntohs+0x36>
    }
    return endian == __LITTLE_ENDIAN ? byteswap16(n) : n;
     8e6:	4d200713          	li	a4,1234
     8ea:	fee785e3          	beq	a5,a4,8d4 <ntohs+0x1c>
}
     8ee:	6422                	ld	s0,8(sp)
     8f0:	0141                	add	sp,sp,16
     8f2:	8082                	ret

00000000000008f4 <htonl>:

uint32_t
htonl(uint32_t h)
{
     8f4:	1141                	add	sp,sp,-16
     8f6:	e422                	sd	s0,8(sp)
     8f8:	0800                	add	s0,sp,16
    if (!endian) {
     8fa:	00001797          	auipc	a5,0x1
     8fe:	7067a783          	lw	a5,1798(a5) # 2000 <endian>
     902:	ef85                	bnez	a5,93a <htonl+0x46>
        endian = byteorder();
     904:	4d200793          	li	a5,1234
     908:	00001717          	auipc	a4,0x1
     90c:	6ef72c23          	sw	a5,1784(a4) # 2000 <endian>
    return (v & 0x000000ff) << 24 | (v & 0x0000ff00) << 8 | (v & 0x00ff0000) >> 8 | (v & 0xff000000) >> 24;
     910:	0185179b          	sllw	a5,a0,0x18
     914:	0185571b          	srlw	a4,a0,0x18
     918:	8fd9                	or	a5,a5,a4
     91a:	0085171b          	sllw	a4,a0,0x8
     91e:	00ff06b7          	lui	a3,0xff0
     922:	8f75                	and	a4,a4,a3
     924:	8fd9                	or	a5,a5,a4
     926:	0085551b          	srlw	a0,a0,0x8
     92a:	6741                	lui	a4,0x10
     92c:	f0070713          	add	a4,a4,-256 # ff00 <base+0xdef0>
     930:	8d79                	and	a0,a0,a4
     932:	8fc9                	or	a5,a5,a0
     934:	0007851b          	sext.w	a0,a5
     938:	a029                	j	942 <htonl+0x4e>
    }
    return endian == __LITTLE_ENDIAN ? byteswap32(h) : h;
     93a:	4d200713          	li	a4,1234
     93e:	fce789e3          	beq	a5,a4,910 <htonl+0x1c>
}
     942:	6422                	ld	s0,8(sp)
     944:	0141                	add	sp,sp,16
     946:	8082                	ret

0000000000000948 <ntohl>:

uint32_t
ntohl(uint32_t n)
{
     948:	1141                	add	sp,sp,-16
     94a:	e422                	sd	s0,8(sp)
     94c:	0800                	add	s0,sp,16
    if (!endian) {
     94e:	00001797          	auipc	a5,0x1
     952:	6b27a783          	lw	a5,1714(a5) # 2000 <endian>
     956:	ef85                	bnez	a5,98e <ntohl+0x46>
        endian = byteorder();
     958:	4d200793          	li	a5,1234
     95c:	00001717          	auipc	a4,0x1
     960:	6af72223          	sw	a5,1700(a4) # 2000 <endian>
    return (v & 0x000000ff) << 24 | (v & 0x0000ff00) << 8 | (v & 0x00ff0000) >> 8 | (v & 0xff000000) >> 24;
     964:	0185179b          	sllw	a5,a0,0x18
     968:	0185571b          	srlw	a4,a0,0x18
     96c:	8fd9                	or	a5,a5,a4
     96e:	0085171b          	sllw	a4,a0,0x8
     972:	00ff06b7          	lui	a3,0xff0
     976:	8f75                	and	a4,a4,a3
     978:	8fd9                	or	a5,a5,a4
     97a:	0085551b          	srlw	a0,a0,0x8
     97e:	6741                	lui	a4,0x10
     980:	f0070713          	add	a4,a4,-256 # ff00 <base+0xdef0>
     984:	8d79                	and	a0,a0,a4
     986:	8fc9                	or	a5,a5,a0
     988:	0007851b          	sext.w	a0,a5
     98c:	a029                	j	996 <ntohl+0x4e>
    }
    return endian == __LITTLE_ENDIAN ? byteswap32(n) : n;
     98e:	4d200713          	li	a4,1234
     992:	fce789e3          	beq	a5,a4,964 <ntohl+0x1c>
}
     996:	6422                	ld	s0,8(sp)
     998:	0141                	add	sp,sp,16
     99a:	8082                	ret

000000000000099c <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
     99c:	1141                	add	sp,sp,-16
     99e:	e422                	sd	s0,8(sp)
     9a0:	0800                	add	s0,sp,16
     9a2:	872a                	mv	a4,a0
    int neg = 0;
    long val = 0;

    // gobble initial whitespace
    while (*s == ' ' || *s == '\t')
     9a4:	02000693          	li	a3,32
     9a8:	4525                	li	a0,9
     9aa:	a011                	j	9ae <strtol+0x12>
        s++;
     9ac:	0705                	add	a4,a4,1
    while (*s == ' ' || *s == '\t')
     9ae:	00074783          	lbu	a5,0(a4)
     9b2:	fed78de3          	beq	a5,a3,9ac <strtol+0x10>
     9b6:	fea78be3          	beq	a5,a0,9ac <strtol+0x10>

    // plus/minus sign
    if (*s == '+')
     9ba:	02b00693          	li	a3,43
     9be:	02d78663          	beq	a5,a3,9ea <strtol+0x4e>
        s++;
    else if (*s == '-')
     9c2:	02d00693          	li	a3,45
    int neg = 0;
     9c6:	4301                	li	t1,0
    else if (*s == '-')
     9c8:	02d78463          	beq	a5,a3,9f0 <strtol+0x54>
        s++, neg = 1;

    // hex or octal base prefix
    if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
     9cc:	fef67793          	and	a5,a2,-17
     9d0:	eb89                	bnez	a5,9e2 <strtol+0x46>
     9d2:	00074683          	lbu	a3,0(a4)
     9d6:	03000793          	li	a5,48
     9da:	00f68e63          	beq	a3,a5,9f6 <strtol+0x5a>
        s += 2, base = 16;
    else if (base == 0 && s[0] == '0')
     9de:	e211                	bnez	a2,9e2 <strtol+0x46>
        s++, base = 8;
    else if (base == 0)
        base = 10;
     9e0:	4629                	li	a2,10
     9e2:	4501                	li	a0,0

    // digits
    while (1) {
        int dig;

        if (*s >= '0' && *s <= '9')
     9e4:	4825                	li	a6,9
            dig = *s - '0';
        else if (*s >= 'a' && *s <= 'z')
     9e6:	48e5                	li	a7,25
     9e8:	a825                	j	a20 <strtol+0x84>
        s++;
     9ea:	0705                	add	a4,a4,1
    int neg = 0;
     9ec:	4301                	li	t1,0
     9ee:	bff9                	j	9cc <strtol+0x30>
        s++, neg = 1;
     9f0:	0705                	add	a4,a4,1
     9f2:	4305                	li	t1,1
     9f4:	bfe1                	j	9cc <strtol+0x30>
    if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
     9f6:	00174683          	lbu	a3,1(a4)
     9fa:	07800793          	li	a5,120
     9fe:	00f68663          	beq	a3,a5,a0a <strtol+0x6e>
    else if (base == 0 && s[0] == '0')
     a02:	f265                	bnez	a2,9e2 <strtol+0x46>
        s++, base = 8;
     a04:	0705                	add	a4,a4,1
     a06:	4621                	li	a2,8
     a08:	bfe9                	j	9e2 <strtol+0x46>
        s += 2, base = 16;
     a0a:	0709                	add	a4,a4,2
     a0c:	4641                	li	a2,16
     a0e:	bfd1                	j	9e2 <strtol+0x46>
            dig = *s - '0';
     a10:	fd07879b          	addw	a5,a5,-48
            dig = *s - 'a' + 10;
        else if (*s >= 'A' && *s <= 'Z')
            dig = *s - 'A' + 10;
        else
            break;
        if (dig >= base)
     a14:	04c7d063          	bge	a5,a2,a54 <strtol+0xb8>
            break;
        s++, val = (val * base) + dig;
     a18:	0705                	add	a4,a4,1
     a1a:	02a60533          	mul	a0,a2,a0
     a1e:	953e                	add	a0,a0,a5
        if (*s >= '0' && *s <= '9')
     a20:	00074783          	lbu	a5,0(a4)
     a24:	fd07869b          	addw	a3,a5,-48
     a28:	0ff6f693          	zext.b	a3,a3
     a2c:	fed872e3          	bgeu	a6,a3,a10 <strtol+0x74>
        else if (*s >= 'a' && *s <= 'z')
     a30:	f9f7869b          	addw	a3,a5,-97
     a34:	0ff6f693          	zext.b	a3,a3
     a38:	00d8e563          	bltu	a7,a3,a42 <strtol+0xa6>
            dig = *s - 'a' + 10;
     a3c:	fa97879b          	addw	a5,a5,-87
     a40:	bfd1                	j	a14 <strtol+0x78>
        else if (*s >= 'A' && *s <= 'Z')
     a42:	fbf7869b          	addw	a3,a5,-65
     a46:	0ff6f693          	zext.b	a3,a3
     a4a:	00d8e563          	bltu	a7,a3,a54 <strtol+0xb8>
            dig = *s - 'A' + 10;
     a4e:	fc97879b          	addw	a5,a5,-55
     a52:	b7c9                	j	a14 <strtol+0x78>
        // we don't properly detect overflow!
    }

    if (endptr)
     a54:	c191                	beqz	a1,a58 <strtol+0xbc>
        *endptr = (char *) s;
     a56:	e198                	sd	a4,0(a1)
    return (neg ? -val : val);
     a58:	00030463          	beqz	t1,a60 <strtol+0xc4>
     a5c:	40a00533          	neg	a0,a0
}
     a60:	6422                	ld	s0,8(sp)
     a62:	0141                	add	sp,sp,16
     a64:	8082                	ret

0000000000000a66 <inet_pton>:
inet_pton (int family, const char *p, void *n) {
    char *sp, *ep;
    int idx;
    long ret;

    if (family != AF_INET) {
     a66:	4785                	li	a5,1
     a68:	08f51263          	bne	a0,a5,aec <inet_pton+0x86>
inet_pton (int family, const char *p, void *n) {
     a6c:	715d                	add	sp,sp,-80
     a6e:	e486                	sd	ra,72(sp)
     a70:	e0a2                	sd	s0,64(sp)
     a72:	fc26                	sd	s1,56(sp)
     a74:	f84a                	sd	s2,48(sp)
     a76:	f44e                	sd	s3,40(sp)
     a78:	f052                	sd	s4,32(sp)
     a7a:	ec56                	sd	s5,24(sp)
     a7c:	e85a                	sd	s6,16(sp)
     a7e:	0880                	add	s0,sp,80
     a80:	892e                	mv	s2,a1
     a82:	89b2                	mv	s3,a2
     a84:	4481                	li	s1,0
        return -1;
    }
    sp = (char *)p;
    for (idx = 0; idx < 4; idx++) {
        ret = strtol(sp, &ep, 10);
        if (ret < 0 || ret > 255) {
     a86:	0ff00a13          	li	s4,255
            return -1;
        }
        if (ep == sp) {
            return -1;
        }
        if ((idx == 3 && *ep != '\0') || (idx != 3 && *ep != '.')) {
     a8a:	4a8d                	li	s5,3
     a8c:	02e00b13          	li	s6,46
     a90:	a815                	j	ac4 <inet_pton+0x5e>
     a92:	0007c783          	lbu	a5,0(a5)
     a96:	e3ad                	bnez	a5,af8 <inet_pton+0x92>
            return -1;
        }
        ((uint8_t *)n)[idx] = ret;
     a98:	2481                	sext.w	s1,s1
     a9a:	99a6                	add	s3,s3,s1
     a9c:	00a98023          	sb	a0,0(s3)
        sp = ep + 1;
    }
    return 0;
     aa0:	4501                	li	a0,0
}
     aa2:	60a6                	ld	ra,72(sp)
     aa4:	6406                	ld	s0,64(sp)
     aa6:	74e2                	ld	s1,56(sp)
     aa8:	7942                	ld	s2,48(sp)
     aaa:	79a2                	ld	s3,40(sp)
     aac:	7a02                	ld	s4,32(sp)
     aae:	6ae2                	ld	s5,24(sp)
     ab0:	6b42                	ld	s6,16(sp)
     ab2:	6161                	add	sp,sp,80
     ab4:	8082                	ret
        ((uint8_t *)n)[idx] = ret;
     ab6:	00998733          	add	a4,s3,s1
     aba:	00a70023          	sb	a0,0(a4)
        sp = ep + 1;
     abe:	00178913          	add	s2,a5,1
    for (idx = 0; idx < 4; idx++) {
     ac2:	0485                	add	s1,s1,1
        ret = strtol(sp, &ep, 10);
     ac4:	4629                	li	a2,10
     ac6:	fb840593          	add	a1,s0,-72
     aca:	854a                	mv	a0,s2
     acc:	ed1ff0ef          	jal	99c <strtol>
        if (ret < 0 || ret > 255) {
     ad0:	02aa6063          	bltu	s4,a0,af0 <inet_pton+0x8a>
        if (ep == sp) {
     ad4:	fb843783          	ld	a5,-72(s0)
     ad8:	01278e63          	beq	a5,s2,af4 <inet_pton+0x8e>
        if ((idx == 3 && *ep != '\0') || (idx != 3 && *ep != '.')) {
     adc:	fb548be3          	beq	s1,s5,a92 <inet_pton+0x2c>
     ae0:	0007c703          	lbu	a4,0(a5)
     ae4:	fd6709e3          	beq	a4,s6,ab6 <inet_pton+0x50>
            return -1;
     ae8:	557d                	li	a0,-1
     aea:	bf65                	j	aa2 <inet_pton+0x3c>
        return -1;
     aec:	557d                	li	a0,-1
}
     aee:	8082                	ret
            return -1;
     af0:	557d                	li	a0,-1
     af2:	bf45                	j	aa2 <inet_pton+0x3c>
            return -1;
     af4:	557d                	li	a0,-1
     af6:	b775                	j	aa2 <inet_pton+0x3c>
            return -1;
     af8:	557d                	li	a0,-1
     afa:	b765                	j	aa2 <inet_pton+0x3c>

0000000000000afc <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
     afc:	4885                	li	a7,1
 ecall
     afe:	00000073          	ecall
 ret
     b02:	8082                	ret

0000000000000b04 <exit>:
.global exit
exit:
 li a7, SYS_exit
     b04:	4889                	li	a7,2
 ecall
     b06:	00000073          	ecall
 ret
     b0a:	8082                	ret

0000000000000b0c <wait>:
.global wait
wait:
 li a7, SYS_wait
     b0c:	488d                	li	a7,3
 ecall
     b0e:	00000073          	ecall
 ret
     b12:	8082                	ret

0000000000000b14 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
     b14:	4891                	li	a7,4
 ecall
     b16:	00000073          	ecall
 ret
     b1a:	8082                	ret

0000000000000b1c <read>:
.global read
read:
 li a7, SYS_read
     b1c:	4895                	li	a7,5
 ecall
     b1e:	00000073          	ecall
 ret
     b22:	8082                	ret

0000000000000b24 <write>:
.global write
write:
 li a7, SYS_write
     b24:	48c1                	li	a7,16
 ecall
     b26:	00000073          	ecall
 ret
     b2a:	8082                	ret

0000000000000b2c <close>:
.global close
close:
 li a7, SYS_close
     b2c:	48d5                	li	a7,21
 ecall
     b2e:	00000073          	ecall
 ret
     b32:	8082                	ret

0000000000000b34 <kill>:
.global kill
kill:
 li a7, SYS_kill
     b34:	4899                	li	a7,6
 ecall
     b36:	00000073          	ecall
 ret
     b3a:	8082                	ret

0000000000000b3c <exec>:
.global exec
exec:
 li a7, SYS_exec
     b3c:	489d                	li	a7,7
 ecall
     b3e:	00000073          	ecall
 ret
     b42:	8082                	ret

0000000000000b44 <open>:
.global open
open:
 li a7, SYS_open
     b44:	48bd                	li	a7,15
 ecall
     b46:	00000073          	ecall
 ret
     b4a:	8082                	ret

0000000000000b4c <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
     b4c:	48c5                	li	a7,17
 ecall
     b4e:	00000073          	ecall
 ret
     b52:	8082                	ret

0000000000000b54 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
     b54:	48c9                	li	a7,18
 ecall
     b56:	00000073          	ecall
 ret
     b5a:	8082                	ret

0000000000000b5c <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
     b5c:	48a1                	li	a7,8
 ecall
     b5e:	00000073          	ecall
 ret
     b62:	8082                	ret

0000000000000b64 <link>:
.global link
link:
 li a7, SYS_link
     b64:	48cd                	li	a7,19
 ecall
     b66:	00000073          	ecall
 ret
     b6a:	8082                	ret

0000000000000b6c <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
     b6c:	48d1                	li	a7,20
 ecall
     b6e:	00000073          	ecall
 ret
     b72:	8082                	ret

0000000000000b74 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
     b74:	48a5                	li	a7,9
 ecall
     b76:	00000073          	ecall
 ret
     b7a:	8082                	ret

0000000000000b7c <dup>:
.global dup
dup:
 li a7, SYS_dup
     b7c:	48a9                	li	a7,10
 ecall
     b7e:	00000073          	ecall
 ret
     b82:	8082                	ret

0000000000000b84 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
     b84:	48ad                	li	a7,11
 ecall
     b86:	00000073          	ecall
 ret
     b8a:	8082                	ret

0000000000000b8c <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
     b8c:	48b1                	li	a7,12
 ecall
     b8e:	00000073          	ecall
 ret
     b92:	8082                	ret

0000000000000b94 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
     b94:	48b5                	li	a7,13
 ecall
     b96:	00000073          	ecall
 ret
     b9a:	8082                	ret

0000000000000b9c <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
     b9c:	48b9                	li	a7,14
 ecall
     b9e:	00000073          	ecall
 ret
     ba2:	8082                	ret

0000000000000ba4 <socket>:
.global socket
socket:
 li a7, SYS_socket
     ba4:	48d9                	li	a7,22
 ecall
     ba6:	00000073          	ecall
 ret
     baa:	8082                	ret

0000000000000bac <bind>:
.global bind
bind:
 li a7, SYS_bind
     bac:	48dd                	li	a7,23
 ecall
     bae:	00000073          	ecall
 ret
     bb2:	8082                	ret

0000000000000bb4 <recvfrom>:
.global recvfrom
recvfrom:
 li a7, SYS_recvfrom
     bb4:	48e1                	li	a7,24
 ecall
     bb6:	00000073          	ecall
 ret
     bba:	8082                	ret

0000000000000bbc <sendto>:
.global sendto
sendto:
 li a7, SYS_sendto
     bbc:	48e5                	li	a7,25
 ecall
     bbe:	00000073          	ecall
 ret
     bc2:	8082                	ret

0000000000000bc4 <connect>:
.global connect
connect:
 li a7, SYS_connect
     bc4:	48e9                	li	a7,26
 ecall
     bc6:	00000073          	ecall
 ret
     bca:	8082                	ret

0000000000000bcc <listen>:
.global listen
listen:
 li a7, SYS_listen
     bcc:	48ed                	li	a7,27
 ecall
     bce:	00000073          	ecall
 ret
     bd2:	8082                	ret

0000000000000bd4 <accept>:
.global accept
accept:
 li a7, SYS_accept
     bd4:	48f1                	li	a7,28
 ecall
     bd6:	00000073          	ecall
 ret
     bda:	8082                	ret

0000000000000bdc <recv>:
.global recv
recv:
 li a7, SYS_recv
     bdc:	48f5                	li	a7,29
 ecall
     bde:	00000073          	ecall
 ret
     be2:	8082                	ret

0000000000000be4 <send>:
.global send
send:
 li a7, SYS_send
     be4:	48f9                	li	a7,30
 ecall
     be6:	00000073          	ecall
 ret
     bea:	8082                	ret

0000000000000bec <ioctl>:
.global ioctl
ioctl:
 li a7, SYS_ioctl
     bec:	48fd                	li	a7,31
 ecall
     bee:	00000073          	ecall
 ret
     bf2:	8082                	ret

0000000000000bf4 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
     bf4:	1101                	add	sp,sp,-32
     bf6:	ec06                	sd	ra,24(sp)
     bf8:	e822                	sd	s0,16(sp)
     bfa:	1000                	add	s0,sp,32
     bfc:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
     c00:	4605                	li	a2,1
     c02:	fef40593          	add	a1,s0,-17
     c06:	f1fff0ef          	jal	b24 <write>
}
     c0a:	60e2                	ld	ra,24(sp)
     c0c:	6442                	ld	s0,16(sp)
     c0e:	6105                	add	sp,sp,32
     c10:	8082                	ret

0000000000000c12 <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
     c12:	715d                	add	sp,sp,-80
     c14:	e486                	sd	ra,72(sp)
     c16:	e0a2                	sd	s0,64(sp)
     c18:	fc26                	sd	s1,56(sp)
     c1a:	f84a                	sd	s2,48(sp)
     c1c:	f44e                	sd	s3,40(sp)
     c1e:	0880                	add	s0,sp,80
     c20:	84aa                	mv	s1,a0
  char buf[20];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
     c22:	c299                	beqz	a3,c28 <printint+0x16>
     c24:	0805c763          	bltz	a1,cb2 <printint+0xa0>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
     c28:	2581                	sext.w	a1,a1
  neg = 0;
     c2a:	4881                	li	a7,0
     c2c:	fb840693          	add	a3,s0,-72
  }

  i = 0;
     c30:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
     c32:	2601                	sext.w	a2,a2
     c34:	00001517          	auipc	a0,0x1
     c38:	85c50513          	add	a0,a0,-1956 # 1490 <digits>
     c3c:	883a                	mv	a6,a4
     c3e:	2705                	addw	a4,a4,1
     c40:	02c5f7bb          	remuw	a5,a1,a2
     c44:	1782                	sll	a5,a5,0x20
     c46:	9381                	srl	a5,a5,0x20
     c48:	97aa                	add	a5,a5,a0
     c4a:	0007c783          	lbu	a5,0(a5)
     c4e:	00f68023          	sb	a5,0(a3) # ff0000 <base+0xfedff0>
  }while((x /= base) != 0);
     c52:	0005879b          	sext.w	a5,a1
     c56:	02c5d5bb          	divuw	a1,a1,a2
     c5a:	0685                	add	a3,a3,1
     c5c:	fec7f0e3          	bgeu	a5,a2,c3c <printint+0x2a>
  if(neg)
     c60:	00088c63          	beqz	a7,c78 <printint+0x66>
    buf[i++] = '-';
     c64:	fd070793          	add	a5,a4,-48
     c68:	00878733          	add	a4,a5,s0
     c6c:	02d00793          	li	a5,45
     c70:	fef70423          	sb	a5,-24(a4)
     c74:	0028071b          	addw	a4,a6,2

  while(--i >= 0)
     c78:	02e05663          	blez	a4,ca4 <printint+0x92>
     c7c:	fb840793          	add	a5,s0,-72
     c80:	00e78933          	add	s2,a5,a4
     c84:	fff78993          	add	s3,a5,-1
     c88:	99ba                	add	s3,s3,a4
     c8a:	377d                	addw	a4,a4,-1
     c8c:	1702                	sll	a4,a4,0x20
     c8e:	9301                	srl	a4,a4,0x20
     c90:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
     c94:	fff94583          	lbu	a1,-1(s2)
     c98:	8526                	mv	a0,s1
     c9a:	f5bff0ef          	jal	bf4 <putc>
  while(--i >= 0)
     c9e:	197d                	add	s2,s2,-1
     ca0:	ff391ae3          	bne	s2,s3,c94 <printint+0x82>
}
     ca4:	60a6                	ld	ra,72(sp)
     ca6:	6406                	ld	s0,64(sp)
     ca8:	74e2                	ld	s1,56(sp)
     caa:	7942                	ld	s2,48(sp)
     cac:	79a2                	ld	s3,40(sp)
     cae:	6161                	add	sp,sp,80
     cb0:	8082                	ret
    x = -xx;
     cb2:	40b005bb          	negw	a1,a1
    neg = 1;
     cb6:	4885                	li	a7,1
    x = -xx;
     cb8:	bf95                	j	c2c <printint+0x1a>

0000000000000cba <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
     cba:	711d                	add	sp,sp,-96
     cbc:	ec86                	sd	ra,88(sp)
     cbe:	e8a2                	sd	s0,80(sp)
     cc0:	e4a6                	sd	s1,72(sp)
     cc2:	e0ca                	sd	s2,64(sp)
     cc4:	fc4e                	sd	s3,56(sp)
     cc6:	f852                	sd	s4,48(sp)
     cc8:	f456                	sd	s5,40(sp)
     cca:	f05a                	sd	s6,32(sp)
     ccc:	ec5e                	sd	s7,24(sp)
     cce:	e862                	sd	s8,16(sp)
     cd0:	e466                	sd	s9,8(sp)
     cd2:	e06a                	sd	s10,0(sp)
     cd4:	1080                	add	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
     cd6:	0005c903          	lbu	s2,0(a1)
     cda:	24090763          	beqz	s2,f28 <vprintf+0x26e>
     cde:	8b2a                	mv	s6,a0
     ce0:	8a2e                	mv	s4,a1
     ce2:	8bb2                	mv	s7,a2
  state = 0;
     ce4:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
     ce6:	4481                	li	s1,0
     ce8:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
     cea:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
     cee:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
     cf2:	06c00c93          	li	s9,108
     cf6:	a005                	j	d16 <vprintf+0x5c>
        putc(fd, c0);
     cf8:	85ca                	mv	a1,s2
     cfa:	855a                	mv	a0,s6
     cfc:	ef9ff0ef          	jal	bf4 <putc>
     d00:	a019                	j	d06 <vprintf+0x4c>
    } else if(state == '%'){
     d02:	03598263          	beq	s3,s5,d26 <vprintf+0x6c>
  for(i = 0; fmt[i]; i++){
     d06:	2485                	addw	s1,s1,1
     d08:	8726                	mv	a4,s1
     d0a:	009a07b3          	add	a5,s4,s1
     d0e:	0007c903          	lbu	s2,0(a5)
     d12:	20090b63          	beqz	s2,f28 <vprintf+0x26e>
    c0 = fmt[i] & 0xff;
     d16:	0009079b          	sext.w	a5,s2
    if(state == 0){
     d1a:	fe0994e3          	bnez	s3,d02 <vprintf+0x48>
      if(c0 == '%'){
     d1e:	fd579de3          	bne	a5,s5,cf8 <vprintf+0x3e>
        state = '%';
     d22:	89be                	mv	s3,a5
     d24:	b7cd                	j	d06 <vprintf+0x4c>
      if(c0) c1 = fmt[i+1] & 0xff;
     d26:	c7c9                	beqz	a5,db0 <vprintf+0xf6>
     d28:	00ea06b3          	add	a3,s4,a4
     d2c:	0016c683          	lbu	a3,1(a3)
      c1 = c2 = 0;
     d30:	8636                	mv	a2,a3
      if(c1) c2 = fmt[i+2] & 0xff;
     d32:	c681                	beqz	a3,d3a <vprintf+0x80>
     d34:	9752                	add	a4,a4,s4
     d36:	00274603          	lbu	a2,2(a4)
      if(c0 == 'd'){
     d3a:	03878f63          	beq	a5,s8,d78 <vprintf+0xbe>
      } else if(c0 == 'l' && c1 == 'd'){
     d3e:	05978963          	beq	a5,s9,d90 <vprintf+0xd6>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
     d42:	07500713          	li	a4,117
     d46:	0ee78363          	beq	a5,a4,e2c <vprintf+0x172>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
     d4a:	07800713          	li	a4,120
     d4e:	12e78563          	beq	a5,a4,e78 <vprintf+0x1be>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
     d52:	07000713          	li	a4,112
     d56:	14e78a63          	beq	a5,a4,eaa <vprintf+0x1f0>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 's'){
     d5a:	07300713          	li	a4,115
     d5e:	18e78863          	beq	a5,a4,eee <vprintf+0x234>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
     d62:	02500713          	li	a4,37
     d66:	04e79563          	bne	a5,a4,db0 <vprintf+0xf6>
        putc(fd, '%');
     d6a:	02500593          	li	a1,37
     d6e:	855a                	mv	a0,s6
     d70:	e85ff0ef          	jal	bf4 <putc>
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
#endif
      state = 0;
     d74:	4981                	li	s3,0
     d76:	bf41                	j	d06 <vprintf+0x4c>
        printint(fd, va_arg(ap, int), 10, 1);
     d78:	008b8913          	add	s2,s7,8
     d7c:	4685                	li	a3,1
     d7e:	4629                	li	a2,10
     d80:	000ba583          	lw	a1,0(s7)
     d84:	855a                	mv	a0,s6
     d86:	e8dff0ef          	jal	c12 <printint>
     d8a:	8bca                	mv	s7,s2
      state = 0;
     d8c:	4981                	li	s3,0
     d8e:	bfa5                	j	d06 <vprintf+0x4c>
      } else if(c0 == 'l' && c1 == 'd'){
     d90:	06400793          	li	a5,100
     d94:	02f68963          	beq	a3,a5,dc6 <vprintf+0x10c>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
     d98:	06c00793          	li	a5,108
     d9c:	04f68263          	beq	a3,a5,de0 <vprintf+0x126>
      } else if(c0 == 'l' && c1 == 'u'){
     da0:	07500793          	li	a5,117
     da4:	0af68063          	beq	a3,a5,e44 <vprintf+0x18a>
      } else if(c0 == 'l' && c1 == 'x'){
     da8:	07800793          	li	a5,120
     dac:	0ef68263          	beq	a3,a5,e90 <vprintf+0x1d6>
        putc(fd, '%');
     db0:	02500593          	li	a1,37
     db4:	855a                	mv	a0,s6
     db6:	e3fff0ef          	jal	bf4 <putc>
        putc(fd, c0);
     dba:	85ca                	mv	a1,s2
     dbc:	855a                	mv	a0,s6
     dbe:	e37ff0ef          	jal	bf4 <putc>
      state = 0;
     dc2:	4981                	li	s3,0
     dc4:	b789                	j	d06 <vprintf+0x4c>
        printint(fd, va_arg(ap, uint64), 10, 1);
     dc6:	008b8913          	add	s2,s7,8
     dca:	4685                	li	a3,1
     dcc:	4629                	li	a2,10
     dce:	000bb583          	ld	a1,0(s7)
     dd2:	855a                	mv	a0,s6
     dd4:	e3fff0ef          	jal	c12 <printint>
        i += 1;
     dd8:	2485                	addw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 1);
     dda:	8bca                	mv	s7,s2
      state = 0;
     ddc:	4981                	li	s3,0
        i += 1;
     dde:	b725                	j	d06 <vprintf+0x4c>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
     de0:	06400793          	li	a5,100
     de4:	02f60763          	beq	a2,a5,e12 <vprintf+0x158>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
     de8:	07500793          	li	a5,117
     dec:	06f60963          	beq	a2,a5,e5e <vprintf+0x1a4>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
     df0:	07800793          	li	a5,120
     df4:	faf61ee3          	bne	a2,a5,db0 <vprintf+0xf6>
        printint(fd, va_arg(ap, uint64), 16, 0);
     df8:	008b8913          	add	s2,s7,8
     dfc:	4681                	li	a3,0
     dfe:	4641                	li	a2,16
     e00:	000bb583          	ld	a1,0(s7)
     e04:	855a                	mv	a0,s6
     e06:	e0dff0ef          	jal	c12 <printint>
        i += 2;
     e0a:	2489                	addw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 16, 0);
     e0c:	8bca                	mv	s7,s2
      state = 0;
     e0e:	4981                	li	s3,0
        i += 2;
     e10:	bddd                	j	d06 <vprintf+0x4c>
        printint(fd, va_arg(ap, uint64), 10, 1);
     e12:	008b8913          	add	s2,s7,8
     e16:	4685                	li	a3,1
     e18:	4629                	li	a2,10
     e1a:	000bb583          	ld	a1,0(s7)
     e1e:	855a                	mv	a0,s6
     e20:	df3ff0ef          	jal	c12 <printint>
        i += 2;
     e24:	2489                	addw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 1);
     e26:	8bca                	mv	s7,s2
      state = 0;
     e28:	4981                	li	s3,0
        i += 2;
     e2a:	bdf1                	j	d06 <vprintf+0x4c>
        printint(fd, va_arg(ap, int), 10, 0);
     e2c:	008b8913          	add	s2,s7,8
     e30:	4681                	li	a3,0
     e32:	4629                	li	a2,10
     e34:	000ba583          	lw	a1,0(s7)
     e38:	855a                	mv	a0,s6
     e3a:	dd9ff0ef          	jal	c12 <printint>
     e3e:	8bca                	mv	s7,s2
      state = 0;
     e40:	4981                	li	s3,0
     e42:	b5d1                	j	d06 <vprintf+0x4c>
        printint(fd, va_arg(ap, uint64), 10, 0);
     e44:	008b8913          	add	s2,s7,8
     e48:	4681                	li	a3,0
     e4a:	4629                	li	a2,10
     e4c:	000bb583          	ld	a1,0(s7)
     e50:	855a                	mv	a0,s6
     e52:	dc1ff0ef          	jal	c12 <printint>
        i += 1;
     e56:	2485                	addw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 0);
     e58:	8bca                	mv	s7,s2
      state = 0;
     e5a:	4981                	li	s3,0
        i += 1;
     e5c:	b56d                	j	d06 <vprintf+0x4c>
        printint(fd, va_arg(ap, uint64), 10, 0);
     e5e:	008b8913          	add	s2,s7,8
     e62:	4681                	li	a3,0
     e64:	4629                	li	a2,10
     e66:	000bb583          	ld	a1,0(s7)
     e6a:	855a                	mv	a0,s6
     e6c:	da7ff0ef          	jal	c12 <printint>
        i += 2;
     e70:	2489                	addw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 0);
     e72:	8bca                	mv	s7,s2
      state = 0;
     e74:	4981                	li	s3,0
        i += 2;
     e76:	bd41                	j	d06 <vprintf+0x4c>
        printint(fd, va_arg(ap, int), 16, 0);
     e78:	008b8913          	add	s2,s7,8
     e7c:	4681                	li	a3,0
     e7e:	4641                	li	a2,16
     e80:	000ba583          	lw	a1,0(s7)
     e84:	855a                	mv	a0,s6
     e86:	d8dff0ef          	jal	c12 <printint>
     e8a:	8bca                	mv	s7,s2
      state = 0;
     e8c:	4981                	li	s3,0
     e8e:	bda5                	j	d06 <vprintf+0x4c>
        printint(fd, va_arg(ap, uint64), 16, 0);
     e90:	008b8913          	add	s2,s7,8
     e94:	4681                	li	a3,0
     e96:	4641                	li	a2,16
     e98:	000bb583          	ld	a1,0(s7)
     e9c:	855a                	mv	a0,s6
     e9e:	d75ff0ef          	jal	c12 <printint>
        i += 1;
     ea2:	2485                	addw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 16, 0);
     ea4:	8bca                	mv	s7,s2
      state = 0;
     ea6:	4981                	li	s3,0
        i += 1;
     ea8:	bdb9                	j	d06 <vprintf+0x4c>
        printptr(fd, va_arg(ap, uint64));
     eaa:	008b8d13          	add	s10,s7,8
     eae:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
     eb2:	03000593          	li	a1,48
     eb6:	855a                	mv	a0,s6
     eb8:	d3dff0ef          	jal	bf4 <putc>
  putc(fd, 'x');
     ebc:	07800593          	li	a1,120
     ec0:	855a                	mv	a0,s6
     ec2:	d33ff0ef          	jal	bf4 <putc>
     ec6:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
     ec8:	00000b97          	auipc	s7,0x0
     ecc:	5c8b8b93          	add	s7,s7,1480 # 1490 <digits>
     ed0:	03c9d793          	srl	a5,s3,0x3c
     ed4:	97de                	add	a5,a5,s7
     ed6:	0007c583          	lbu	a1,0(a5)
     eda:	855a                	mv	a0,s6
     edc:	d19ff0ef          	jal	bf4 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
     ee0:	0992                	sll	s3,s3,0x4
     ee2:	397d                	addw	s2,s2,-1
     ee4:	fe0916e3          	bnez	s2,ed0 <vprintf+0x216>
        printptr(fd, va_arg(ap, uint64));
     ee8:	8bea                	mv	s7,s10
      state = 0;
     eea:	4981                	li	s3,0
     eec:	bd29                	j	d06 <vprintf+0x4c>
        if((s = va_arg(ap, char*)) == 0)
     eee:	008b8993          	add	s3,s7,8
     ef2:	000bb903          	ld	s2,0(s7)
     ef6:	00090f63          	beqz	s2,f14 <vprintf+0x25a>
        for(; *s; s++)
     efa:	00094583          	lbu	a1,0(s2)
     efe:	c195                	beqz	a1,f22 <vprintf+0x268>
          putc(fd, *s);
     f00:	855a                	mv	a0,s6
     f02:	cf3ff0ef          	jal	bf4 <putc>
        for(; *s; s++)
     f06:	0905                	add	s2,s2,1
     f08:	00094583          	lbu	a1,0(s2)
     f0c:	f9f5                	bnez	a1,f00 <vprintf+0x246>
        if((s = va_arg(ap, char*)) == 0)
     f0e:	8bce                	mv	s7,s3
      state = 0;
     f10:	4981                	li	s3,0
     f12:	bbd5                	j	d06 <vprintf+0x4c>
          s = "(null)";
     f14:	00000917          	auipc	s2,0x0
     f18:	57490913          	add	s2,s2,1396 # 1488 <malloc+0x466>
        for(; *s; s++)
     f1c:	02800593          	li	a1,40
     f20:	b7c5                	j	f00 <vprintf+0x246>
        if((s = va_arg(ap, char*)) == 0)
     f22:	8bce                	mv	s7,s3
      state = 0;
     f24:	4981                	li	s3,0
     f26:	b3c5                	j	d06 <vprintf+0x4c>
    }
  }
}
     f28:	60e6                	ld	ra,88(sp)
     f2a:	6446                	ld	s0,80(sp)
     f2c:	64a6                	ld	s1,72(sp)
     f2e:	6906                	ld	s2,64(sp)
     f30:	79e2                	ld	s3,56(sp)
     f32:	7a42                	ld	s4,48(sp)
     f34:	7aa2                	ld	s5,40(sp)
     f36:	7b02                	ld	s6,32(sp)
     f38:	6be2                	ld	s7,24(sp)
     f3a:	6c42                	ld	s8,16(sp)
     f3c:	6ca2                	ld	s9,8(sp)
     f3e:	6d02                	ld	s10,0(sp)
     f40:	6125                	add	sp,sp,96
     f42:	8082                	ret

0000000000000f44 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
     f44:	715d                	add	sp,sp,-80
     f46:	ec06                	sd	ra,24(sp)
     f48:	e822                	sd	s0,16(sp)
     f4a:	1000                	add	s0,sp,32
     f4c:	e010                	sd	a2,0(s0)
     f4e:	e414                	sd	a3,8(s0)
     f50:	e818                	sd	a4,16(s0)
     f52:	ec1c                	sd	a5,24(s0)
     f54:	03043023          	sd	a6,32(s0)
     f58:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
     f5c:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
     f60:	8622                	mv	a2,s0
     f62:	d59ff0ef          	jal	cba <vprintf>
}
     f66:	60e2                	ld	ra,24(sp)
     f68:	6442                	ld	s0,16(sp)
     f6a:	6161                	add	sp,sp,80
     f6c:	8082                	ret

0000000000000f6e <printf>:

void
printf(const char *fmt, ...)
{
     f6e:	711d                	add	sp,sp,-96
     f70:	ec06                	sd	ra,24(sp)
     f72:	e822                	sd	s0,16(sp)
     f74:	1000                	add	s0,sp,32
     f76:	e40c                	sd	a1,8(s0)
     f78:	e810                	sd	a2,16(s0)
     f7a:	ec14                	sd	a3,24(s0)
     f7c:	f018                	sd	a4,32(s0)
     f7e:	f41c                	sd	a5,40(s0)
     f80:	03043823          	sd	a6,48(s0)
     f84:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
     f88:	00840613          	add	a2,s0,8
     f8c:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
     f90:	85aa                	mv	a1,a0
     f92:	4505                	li	a0,1
     f94:	d27ff0ef          	jal	cba <vprintf>
}
     f98:	60e2                	ld	ra,24(sp)
     f9a:	6442                	ld	s0,16(sp)
     f9c:	6125                	add	sp,sp,96
     f9e:	8082                	ret

0000000000000fa0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     fa0:	1141                	add	sp,sp,-16
     fa2:	e422                	sd	s0,8(sp)
     fa4:	0800                	add	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
     fa6:	ff050693          	add	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     faa:	00001797          	auipc	a5,0x1
     fae:	05e7b783          	ld	a5,94(a5) # 2008 <freep>
     fb2:	a02d                	j	fdc <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
     fb4:	4618                	lw	a4,8(a2)
     fb6:	9f2d                	addw	a4,a4,a1
     fb8:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
     fbc:	6398                	ld	a4,0(a5)
     fbe:	6310                	ld	a2,0(a4)
     fc0:	a83d                	j	ffe <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
     fc2:	ff852703          	lw	a4,-8(a0)
     fc6:	9f31                	addw	a4,a4,a2
     fc8:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
     fca:	ff053683          	ld	a3,-16(a0)
     fce:	a091                	j	1012 <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     fd0:	6398                	ld	a4,0(a5)
     fd2:	00e7e463          	bltu	a5,a4,fda <free+0x3a>
     fd6:	00e6ea63          	bltu	a3,a4,fea <free+0x4a>
{
     fda:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     fdc:	fed7fae3          	bgeu	a5,a3,fd0 <free+0x30>
     fe0:	6398                	ld	a4,0(a5)
     fe2:	00e6e463          	bltu	a3,a4,fea <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     fe6:	fee7eae3          	bltu	a5,a4,fda <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
     fea:	ff852583          	lw	a1,-8(a0)
     fee:	6390                	ld	a2,0(a5)
     ff0:	02059813          	sll	a6,a1,0x20
     ff4:	01c85713          	srl	a4,a6,0x1c
     ff8:	9736                	add	a4,a4,a3
     ffa:	fae60de3          	beq	a2,a4,fb4 <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
     ffe:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
    1002:	4790                	lw	a2,8(a5)
    1004:	02061593          	sll	a1,a2,0x20
    1008:	01c5d713          	srl	a4,a1,0x1c
    100c:	973e                	add	a4,a4,a5
    100e:	fae68ae3          	beq	a3,a4,fc2 <free+0x22>
    p->s.ptr = bp->s.ptr;
    1012:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
    1014:	00001717          	auipc	a4,0x1
    1018:	fef73a23          	sd	a5,-12(a4) # 2008 <freep>
}
    101c:	6422                	ld	s0,8(sp)
    101e:	0141                	add	sp,sp,16
    1020:	8082                	ret

0000000000001022 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    1022:	7139                	add	sp,sp,-64
    1024:	fc06                	sd	ra,56(sp)
    1026:	f822                	sd	s0,48(sp)
    1028:	f426                	sd	s1,40(sp)
    102a:	f04a                	sd	s2,32(sp)
    102c:	ec4e                	sd	s3,24(sp)
    102e:	e852                	sd	s4,16(sp)
    1030:	e456                	sd	s5,8(sp)
    1032:	e05a                	sd	s6,0(sp)
    1034:	0080                	add	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1036:	02051493          	sll	s1,a0,0x20
    103a:	9081                	srl	s1,s1,0x20
    103c:	04bd                	add	s1,s1,15
    103e:	8091                	srl	s1,s1,0x4
    1040:	0014899b          	addw	s3,s1,1
    1044:	0485                	add	s1,s1,1
  if((prevp = freep) == 0){
    1046:	00001517          	auipc	a0,0x1
    104a:	fc253503          	ld	a0,-62(a0) # 2008 <freep>
    104e:	c515                	beqz	a0,107a <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1050:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    1052:	4798                	lw	a4,8(a5)
    1054:	02977f63          	bgeu	a4,s1,1092 <malloc+0x70>
  if(nu < 4096)
    1058:	8a4e                	mv	s4,s3
    105a:	0009871b          	sext.w	a4,s3
    105e:	6685                	lui	a3,0x1
    1060:	00d77363          	bgeu	a4,a3,1066 <malloc+0x44>
    1064:	6a05                	lui	s4,0x1
    1066:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
    106a:	004a1a1b          	sllw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    106e:	00001917          	auipc	s2,0x1
    1072:	f9a90913          	add	s2,s2,-102 # 2008 <freep>
  if(p == (char*)-1)
    1076:	5afd                	li	s5,-1
    1078:	a885                	j	10e8 <malloc+0xc6>
    base.s.ptr = freep = prevp = &base;
    107a:	00001797          	auipc	a5,0x1
    107e:	f9678793          	add	a5,a5,-106 # 2010 <base>
    1082:	00001717          	auipc	a4,0x1
    1086:	f8f73323          	sd	a5,-122(a4) # 2008 <freep>
    108a:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
    108c:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
    1090:	b7e1                	j	1058 <malloc+0x36>
      if(p->s.size == nunits)
    1092:	02e48c63          	beq	s1,a4,10ca <malloc+0xa8>
        p->s.size -= nunits;
    1096:	4137073b          	subw	a4,a4,s3
    109a:	c798                	sw	a4,8(a5)
        p += p->s.size;
    109c:	02071693          	sll	a3,a4,0x20
    10a0:	01c6d713          	srl	a4,a3,0x1c
    10a4:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
    10a6:	0137a423          	sw	s3,8(a5)
      freep = prevp;
    10aa:	00001717          	auipc	a4,0x1
    10ae:	f4a73f23          	sd	a0,-162(a4) # 2008 <freep>
      return (void*)(p + 1);
    10b2:	01078513          	add	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
    10b6:	70e2                	ld	ra,56(sp)
    10b8:	7442                	ld	s0,48(sp)
    10ba:	74a2                	ld	s1,40(sp)
    10bc:	7902                	ld	s2,32(sp)
    10be:	69e2                	ld	s3,24(sp)
    10c0:	6a42                	ld	s4,16(sp)
    10c2:	6aa2                	ld	s5,8(sp)
    10c4:	6b02                	ld	s6,0(sp)
    10c6:	6121                	add	sp,sp,64
    10c8:	8082                	ret
        prevp->s.ptr = p->s.ptr;
    10ca:	6398                	ld	a4,0(a5)
    10cc:	e118                	sd	a4,0(a0)
    10ce:	bff1                	j	10aa <malloc+0x88>
  hp->s.size = nu;
    10d0:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
    10d4:	0541                	add	a0,a0,16
    10d6:	ecbff0ef          	jal	fa0 <free>
  return freep;
    10da:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
    10de:	dd61                	beqz	a0,10b6 <malloc+0x94>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    10e0:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    10e2:	4798                	lw	a4,8(a5)
    10e4:	fa9777e3          	bgeu	a4,s1,1092 <malloc+0x70>
    if(p == freep)
    10e8:	00093703          	ld	a4,0(s2)
    10ec:	853e                	mv	a0,a5
    10ee:	fef719e3          	bne	a4,a5,10e0 <malloc+0xbe>
  p = sbrk(nu * sizeof(Header));
    10f2:	8552                	mv	a0,s4
    10f4:	a99ff0ef          	jal	b8c <sbrk>
  if(p == (char*)-1)
    10f8:	fd551ce3          	bne	a0,s5,10d0 <malloc+0xae>
        return 0;
    10fc:	4501                	li	a0,0
    10fe:	bf65                	j	10b6 <malloc+0x94>
