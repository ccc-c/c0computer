
user/_sh:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <getcmd>:
  exit(0);
}

int
getcmd(char *buf, int nbuf)
{
       0:	1101                	add	sp,sp,-32
       2:	ec06                	sd	ra,24(sp)
       4:	e822                	sd	s0,16(sp)
       6:	e426                	sd	s1,8(sp)
       8:	e04a                	sd	s2,0(sp)
       a:	1000                	add	s0,sp,32
       c:	84aa                	mv	s1,a0
       e:	892e                	mv	s2,a1
  fprintf(2, "$ ");
      10:	00001597          	auipc	a1,0x1
      14:	5b058593          	add	a1,a1,1456 # 15c0 <malloc+0x106>
      18:	4509                	li	a0,2
      1a:	00001097          	auipc	ra,0x1
      1e:	1f2080e7          	jalr	498(ra) # 120c <fprintf>
  memset(buf, 0, nbuf);
      22:	864a                	mv	a2,s2
      24:	4581                	li	a1,0
      26:	8526                	mv	a0,s1
      28:	00001097          	auipc	ra,0x1
      2c:	be0080e7          	jalr	-1056(ra) # c08 <memset>
  gets(buf, nbuf);
      30:	85ca                	mv	a1,s2
      32:	8526                	mv	a0,s1
      34:	00001097          	auipc	ra,0x1
      38:	c1a080e7          	jalr	-998(ra) # c4e <gets>
  if(buf[0] == 0) // EOF
      3c:	0004c503          	lbu	a0,0(s1)
      40:	00153513          	seqz	a0,a0
    return -1;
  return 0;
}
      44:	40a00533          	neg	a0,a0
      48:	60e2                	ld	ra,24(sp)
      4a:	6442                	ld	s0,16(sp)
      4c:	64a2                	ld	s1,8(sp)
      4e:	6902                	ld	s2,0(sp)
      50:	6105                	add	sp,sp,32
      52:	8082                	ret

0000000000000054 <panic>:
  exit(0);
}

void
panic(char *s)
{
      54:	1141                	add	sp,sp,-16
      56:	e406                	sd	ra,8(sp)
      58:	e022                	sd	s0,0(sp)
      5a:	0800                	add	s0,sp,16
      5c:	862a                	mv	a2,a0
  fprintf(2, "%s\n", s);
      5e:	00001597          	auipc	a1,0x1
      62:	57258593          	add	a1,a1,1394 # 15d0 <malloc+0x116>
      66:	4509                	li	a0,2
      68:	00001097          	auipc	ra,0x1
      6c:	1a4080e7          	jalr	420(ra) # 120c <fprintf>
  exit(1);
      70:	4505                	li	a0,1
      72:	00001097          	auipc	ra,0x1
      76:	d90080e7          	jalr	-624(ra) # e02 <exit>

000000000000007a <fork1>:
}

int
fork1(void)
{
      7a:	1141                	add	sp,sp,-16
      7c:	e406                	sd	ra,8(sp)
      7e:	e022                	sd	s0,0(sp)
      80:	0800                	add	s0,sp,16
  int pid;

  pid = fork();
      82:	00001097          	auipc	ra,0x1
      86:	d78080e7          	jalr	-648(ra) # dfa <fork>
  if(pid == -1)
      8a:	57fd                	li	a5,-1
      8c:	00f50663          	beq	a0,a5,98 <fork1+0x1e>
    panic("fork");
  return pid;
}
      90:	60a2                	ld	ra,8(sp)
      92:	6402                	ld	s0,0(sp)
      94:	0141                	add	sp,sp,16
      96:	8082                	ret
    panic("fork");
      98:	00001517          	auipc	a0,0x1
      9c:	54050513          	add	a0,a0,1344 # 15d8 <malloc+0x11e>
      a0:	00000097          	auipc	ra,0x0
      a4:	fb4080e7          	jalr	-76(ra) # 54 <panic>

00000000000000a8 <runcmd>:
{
      a8:	7179                	add	sp,sp,-48
      aa:	f406                	sd	ra,40(sp)
      ac:	f022                	sd	s0,32(sp)
      ae:	1800                	add	s0,sp,48
  if(cmd == 0)
      b0:	c115                	beqz	a0,d4 <runcmd+0x2c>
      b2:	ec26                	sd	s1,24(sp)
      b4:	84aa                	mv	s1,a0
  switch(cmd->type){
      b6:	4118                	lw	a4,0(a0)
      b8:	4795                	li	a5,5
      ba:	02e7e363          	bltu	a5,a4,e0 <runcmd+0x38>
      be:	00056783          	lwu	a5,0(a0)
      c2:	078a                	sll	a5,a5,0x2
      c4:	00001717          	auipc	a4,0x1
      c8:	61470713          	add	a4,a4,1556 # 16d8 <malloc+0x21e>
      cc:	97ba                	add	a5,a5,a4
      ce:	439c                	lw	a5,0(a5)
      d0:	97ba                	add	a5,a5,a4
      d2:	8782                	jr	a5
      d4:	ec26                	sd	s1,24(sp)
    exit(1);
      d6:	4505                	li	a0,1
      d8:	00001097          	auipc	ra,0x1
      dc:	d2a080e7          	jalr	-726(ra) # e02 <exit>
    panic("runcmd");
      e0:	00001517          	auipc	a0,0x1
      e4:	50050513          	add	a0,a0,1280 # 15e0 <malloc+0x126>
      e8:	00000097          	auipc	ra,0x0
      ec:	f6c080e7          	jalr	-148(ra) # 54 <panic>
    if(ecmd->argv[0] == 0)
      f0:	6508                	ld	a0,8(a0)
      f2:	c515                	beqz	a0,11e <runcmd+0x76>
    exec(ecmd->argv[0], ecmd->argv);
      f4:	00848593          	add	a1,s1,8
      f8:	00001097          	auipc	ra,0x1
      fc:	d42080e7          	jalr	-702(ra) # e3a <exec>
    fprintf(2, "exec %s failed\n", ecmd->argv[0]);
     100:	6490                	ld	a2,8(s1)
     102:	00001597          	auipc	a1,0x1
     106:	4e658593          	add	a1,a1,1254 # 15e8 <malloc+0x12e>
     10a:	4509                	li	a0,2
     10c:	00001097          	auipc	ra,0x1
     110:	100080e7          	jalr	256(ra) # 120c <fprintf>
  exit(0);
     114:	4501                	li	a0,0
     116:	00001097          	auipc	ra,0x1
     11a:	cec080e7          	jalr	-788(ra) # e02 <exit>
      exit(1);
     11e:	4505                	li	a0,1
     120:	00001097          	auipc	ra,0x1
     124:	ce2080e7          	jalr	-798(ra) # e02 <exit>
    close(rcmd->fd);
     128:	5148                	lw	a0,36(a0)
     12a:	00001097          	auipc	ra,0x1
     12e:	d00080e7          	jalr	-768(ra) # e2a <close>
    if(open(rcmd->file, rcmd->mode) < 0){
     132:	508c                	lw	a1,32(s1)
     134:	6888                	ld	a0,16(s1)
     136:	00001097          	auipc	ra,0x1
     13a:	d0c080e7          	jalr	-756(ra) # e42 <open>
     13e:	00054763          	bltz	a0,14c <runcmd+0xa4>
    runcmd(rcmd->cmd);
     142:	6488                	ld	a0,8(s1)
     144:	00000097          	auipc	ra,0x0
     148:	f64080e7          	jalr	-156(ra) # a8 <runcmd>
      fprintf(2, "open %s failed\n", rcmd->file);
     14c:	6890                	ld	a2,16(s1)
     14e:	00001597          	auipc	a1,0x1
     152:	4aa58593          	add	a1,a1,1194 # 15f8 <malloc+0x13e>
     156:	4509                	li	a0,2
     158:	00001097          	auipc	ra,0x1
     15c:	0b4080e7          	jalr	180(ra) # 120c <fprintf>
      exit(1);
     160:	4505                	li	a0,1
     162:	00001097          	auipc	ra,0x1
     166:	ca0080e7          	jalr	-864(ra) # e02 <exit>
    if(fork1() == 0)
     16a:	00000097          	auipc	ra,0x0
     16e:	f10080e7          	jalr	-240(ra) # 7a <fork1>
     172:	c919                	beqz	a0,188 <runcmd+0xe0>
    wait(0);
     174:	4501                	li	a0,0
     176:	00001097          	auipc	ra,0x1
     17a:	c94080e7          	jalr	-876(ra) # e0a <wait>
    runcmd(lcmd->right);
     17e:	6888                	ld	a0,16(s1)
     180:	00000097          	auipc	ra,0x0
     184:	f28080e7          	jalr	-216(ra) # a8 <runcmd>
      runcmd(lcmd->left);
     188:	6488                	ld	a0,8(s1)
     18a:	00000097          	auipc	ra,0x0
     18e:	f1e080e7          	jalr	-226(ra) # a8 <runcmd>
    if(pipe(p) < 0)
     192:	fd840513          	add	a0,s0,-40
     196:	00001097          	auipc	ra,0x1
     19a:	c7c080e7          	jalr	-900(ra) # e12 <pipe>
     19e:	04054363          	bltz	a0,1e4 <runcmd+0x13c>
    if(fork1() == 0){
     1a2:	00000097          	auipc	ra,0x0
     1a6:	ed8080e7          	jalr	-296(ra) # 7a <fork1>
     1aa:	c529                	beqz	a0,1f4 <runcmd+0x14c>
    if(fork1() == 0){
     1ac:	00000097          	auipc	ra,0x0
     1b0:	ece080e7          	jalr	-306(ra) # 7a <fork1>
     1b4:	cd25                	beqz	a0,22c <runcmd+0x184>
    close(p[0]);
     1b6:	fd842503          	lw	a0,-40(s0)
     1ba:	00001097          	auipc	ra,0x1
     1be:	c70080e7          	jalr	-912(ra) # e2a <close>
    close(p[1]);
     1c2:	fdc42503          	lw	a0,-36(s0)
     1c6:	00001097          	auipc	ra,0x1
     1ca:	c64080e7          	jalr	-924(ra) # e2a <close>
    wait(0);
     1ce:	4501                	li	a0,0
     1d0:	00001097          	auipc	ra,0x1
     1d4:	c3a080e7          	jalr	-966(ra) # e0a <wait>
    wait(0);
     1d8:	4501                	li	a0,0
     1da:	00001097          	auipc	ra,0x1
     1de:	c30080e7          	jalr	-976(ra) # e0a <wait>
    break;
     1e2:	bf0d                	j	114 <runcmd+0x6c>
      panic("pipe");
     1e4:	00001517          	auipc	a0,0x1
     1e8:	42450513          	add	a0,a0,1060 # 1608 <malloc+0x14e>
     1ec:	00000097          	auipc	ra,0x0
     1f0:	e68080e7          	jalr	-408(ra) # 54 <panic>
      close(1);
     1f4:	4505                	li	a0,1
     1f6:	00001097          	auipc	ra,0x1
     1fa:	c34080e7          	jalr	-972(ra) # e2a <close>
      dup(p[1]);
     1fe:	fdc42503          	lw	a0,-36(s0)
     202:	00001097          	auipc	ra,0x1
     206:	c78080e7          	jalr	-904(ra) # e7a <dup>
      close(p[0]);
     20a:	fd842503          	lw	a0,-40(s0)
     20e:	00001097          	auipc	ra,0x1
     212:	c1c080e7          	jalr	-996(ra) # e2a <close>
      close(p[1]);
     216:	fdc42503          	lw	a0,-36(s0)
     21a:	00001097          	auipc	ra,0x1
     21e:	c10080e7          	jalr	-1008(ra) # e2a <close>
      runcmd(pcmd->left);
     222:	6488                	ld	a0,8(s1)
     224:	00000097          	auipc	ra,0x0
     228:	e84080e7          	jalr	-380(ra) # a8 <runcmd>
      close(0);
     22c:	00001097          	auipc	ra,0x1
     230:	bfe080e7          	jalr	-1026(ra) # e2a <close>
      dup(p[0]);
     234:	fd842503          	lw	a0,-40(s0)
     238:	00001097          	auipc	ra,0x1
     23c:	c42080e7          	jalr	-958(ra) # e7a <dup>
      close(p[0]);
     240:	fd842503          	lw	a0,-40(s0)
     244:	00001097          	auipc	ra,0x1
     248:	be6080e7          	jalr	-1050(ra) # e2a <close>
      close(p[1]);
     24c:	fdc42503          	lw	a0,-36(s0)
     250:	00001097          	auipc	ra,0x1
     254:	bda080e7          	jalr	-1062(ra) # e2a <close>
      runcmd(pcmd->right);
     258:	6888                	ld	a0,16(s1)
     25a:	00000097          	auipc	ra,0x0
     25e:	e4e080e7          	jalr	-434(ra) # a8 <runcmd>
    if(fork1() == 0)
     262:	00000097          	auipc	ra,0x0
     266:	e18080e7          	jalr	-488(ra) # 7a <fork1>
     26a:	ea0515e3          	bnez	a0,114 <runcmd+0x6c>
      runcmd(bcmd->cmd);
     26e:	6488                	ld	a0,8(s1)
     270:	00000097          	auipc	ra,0x0
     274:	e38080e7          	jalr	-456(ra) # a8 <runcmd>

0000000000000278 <execcmd>:
//PAGEBREAK!
// Constructors

struct cmd*
execcmd(void)
{
     278:	1101                	add	sp,sp,-32
     27a:	ec06                	sd	ra,24(sp)
     27c:	e822                	sd	s0,16(sp)
     27e:	e426                	sd	s1,8(sp)
     280:	1000                	add	s0,sp,32
  struct execcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     282:	0a800513          	li	a0,168
     286:	00001097          	auipc	ra,0x1
     28a:	234080e7          	jalr	564(ra) # 14ba <malloc>
     28e:	84aa                	mv	s1,a0
  memset(cmd, 0, sizeof(*cmd));
     290:	0a800613          	li	a2,168
     294:	4581                	li	a1,0
     296:	00001097          	auipc	ra,0x1
     29a:	972080e7          	jalr	-1678(ra) # c08 <memset>
  cmd->type = EXEC;
     29e:	4785                	li	a5,1
     2a0:	c09c                	sw	a5,0(s1)
  return (struct cmd*)cmd;
}
     2a2:	8526                	mv	a0,s1
     2a4:	60e2                	ld	ra,24(sp)
     2a6:	6442                	ld	s0,16(sp)
     2a8:	64a2                	ld	s1,8(sp)
     2aa:	6105                	add	sp,sp,32
     2ac:	8082                	ret

00000000000002ae <redircmd>:

struct cmd*
redircmd(struct cmd *subcmd, char *file, char *efile, int mode, int fd)
{
     2ae:	7139                	add	sp,sp,-64
     2b0:	fc06                	sd	ra,56(sp)
     2b2:	f822                	sd	s0,48(sp)
     2b4:	f426                	sd	s1,40(sp)
     2b6:	f04a                	sd	s2,32(sp)
     2b8:	ec4e                	sd	s3,24(sp)
     2ba:	e852                	sd	s4,16(sp)
     2bc:	e456                	sd	s5,8(sp)
     2be:	e05a                	sd	s6,0(sp)
     2c0:	0080                	add	s0,sp,64
     2c2:	8b2a                	mv	s6,a0
     2c4:	8aae                	mv	s5,a1
     2c6:	8a32                	mv	s4,a2
     2c8:	89b6                	mv	s3,a3
     2ca:	893a                	mv	s2,a4
  struct redircmd *cmd;

  cmd = malloc(sizeof(*cmd));
     2cc:	02800513          	li	a0,40
     2d0:	00001097          	auipc	ra,0x1
     2d4:	1ea080e7          	jalr	490(ra) # 14ba <malloc>
     2d8:	84aa                	mv	s1,a0
  memset(cmd, 0, sizeof(*cmd));
     2da:	02800613          	li	a2,40
     2de:	4581                	li	a1,0
     2e0:	00001097          	auipc	ra,0x1
     2e4:	928080e7          	jalr	-1752(ra) # c08 <memset>
  cmd->type = REDIR;
     2e8:	4789                	li	a5,2
     2ea:	c09c                	sw	a5,0(s1)
  cmd->cmd = subcmd;
     2ec:	0164b423          	sd	s6,8(s1)
  cmd->file = file;
     2f0:	0154b823          	sd	s5,16(s1)
  cmd->efile = efile;
     2f4:	0144bc23          	sd	s4,24(s1)
  cmd->mode = mode;
     2f8:	0334a023          	sw	s3,32(s1)
  cmd->fd = fd;
     2fc:	0324a223          	sw	s2,36(s1)
  return (struct cmd*)cmd;
}
     300:	8526                	mv	a0,s1
     302:	70e2                	ld	ra,56(sp)
     304:	7442                	ld	s0,48(sp)
     306:	74a2                	ld	s1,40(sp)
     308:	7902                	ld	s2,32(sp)
     30a:	69e2                	ld	s3,24(sp)
     30c:	6a42                	ld	s4,16(sp)
     30e:	6aa2                	ld	s5,8(sp)
     310:	6b02                	ld	s6,0(sp)
     312:	6121                	add	sp,sp,64
     314:	8082                	ret

0000000000000316 <pipecmd>:

struct cmd*
pipecmd(struct cmd *left, struct cmd *right)
{
     316:	7179                	add	sp,sp,-48
     318:	f406                	sd	ra,40(sp)
     31a:	f022                	sd	s0,32(sp)
     31c:	ec26                	sd	s1,24(sp)
     31e:	e84a                	sd	s2,16(sp)
     320:	e44e                	sd	s3,8(sp)
     322:	1800                	add	s0,sp,48
     324:	89aa                	mv	s3,a0
     326:	892e                	mv	s2,a1
  struct pipecmd *cmd;

  cmd = malloc(sizeof(*cmd));
     328:	4561                	li	a0,24
     32a:	00001097          	auipc	ra,0x1
     32e:	190080e7          	jalr	400(ra) # 14ba <malloc>
     332:	84aa                	mv	s1,a0
  memset(cmd, 0, sizeof(*cmd));
     334:	4661                	li	a2,24
     336:	4581                	li	a1,0
     338:	00001097          	auipc	ra,0x1
     33c:	8d0080e7          	jalr	-1840(ra) # c08 <memset>
  cmd->type = PIPE;
     340:	478d                	li	a5,3
     342:	c09c                	sw	a5,0(s1)
  cmd->left = left;
     344:	0134b423          	sd	s3,8(s1)
  cmd->right = right;
     348:	0124b823          	sd	s2,16(s1)
  return (struct cmd*)cmd;
}
     34c:	8526                	mv	a0,s1
     34e:	70a2                	ld	ra,40(sp)
     350:	7402                	ld	s0,32(sp)
     352:	64e2                	ld	s1,24(sp)
     354:	6942                	ld	s2,16(sp)
     356:	69a2                	ld	s3,8(sp)
     358:	6145                	add	sp,sp,48
     35a:	8082                	ret

000000000000035c <listcmd>:

struct cmd*
listcmd(struct cmd *left, struct cmd *right)
{
     35c:	7179                	add	sp,sp,-48
     35e:	f406                	sd	ra,40(sp)
     360:	f022                	sd	s0,32(sp)
     362:	ec26                	sd	s1,24(sp)
     364:	e84a                	sd	s2,16(sp)
     366:	e44e                	sd	s3,8(sp)
     368:	1800                	add	s0,sp,48
     36a:	89aa                	mv	s3,a0
     36c:	892e                	mv	s2,a1
  struct listcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     36e:	4561                	li	a0,24
     370:	00001097          	auipc	ra,0x1
     374:	14a080e7          	jalr	330(ra) # 14ba <malloc>
     378:	84aa                	mv	s1,a0
  memset(cmd, 0, sizeof(*cmd));
     37a:	4661                	li	a2,24
     37c:	4581                	li	a1,0
     37e:	00001097          	auipc	ra,0x1
     382:	88a080e7          	jalr	-1910(ra) # c08 <memset>
  cmd->type = LIST;
     386:	4791                	li	a5,4
     388:	c09c                	sw	a5,0(s1)
  cmd->left = left;
     38a:	0134b423          	sd	s3,8(s1)
  cmd->right = right;
     38e:	0124b823          	sd	s2,16(s1)
  return (struct cmd*)cmd;
}
     392:	8526                	mv	a0,s1
     394:	70a2                	ld	ra,40(sp)
     396:	7402                	ld	s0,32(sp)
     398:	64e2                	ld	s1,24(sp)
     39a:	6942                	ld	s2,16(sp)
     39c:	69a2                	ld	s3,8(sp)
     39e:	6145                	add	sp,sp,48
     3a0:	8082                	ret

00000000000003a2 <backcmd>:

struct cmd*
backcmd(struct cmd *subcmd)
{
     3a2:	1101                	add	sp,sp,-32
     3a4:	ec06                	sd	ra,24(sp)
     3a6:	e822                	sd	s0,16(sp)
     3a8:	e426                	sd	s1,8(sp)
     3aa:	e04a                	sd	s2,0(sp)
     3ac:	1000                	add	s0,sp,32
     3ae:	892a                	mv	s2,a0
  struct backcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     3b0:	4541                	li	a0,16
     3b2:	00001097          	auipc	ra,0x1
     3b6:	108080e7          	jalr	264(ra) # 14ba <malloc>
     3ba:	84aa                	mv	s1,a0
  memset(cmd, 0, sizeof(*cmd));
     3bc:	4641                	li	a2,16
     3be:	4581                	li	a1,0
     3c0:	00001097          	auipc	ra,0x1
     3c4:	848080e7          	jalr	-1976(ra) # c08 <memset>
  cmd->type = BACK;
     3c8:	4795                	li	a5,5
     3ca:	c09c                	sw	a5,0(s1)
  cmd->cmd = subcmd;
     3cc:	0124b423          	sd	s2,8(s1)
  return (struct cmd*)cmd;
}
     3d0:	8526                	mv	a0,s1
     3d2:	60e2                	ld	ra,24(sp)
     3d4:	6442                	ld	s0,16(sp)
     3d6:	64a2                	ld	s1,8(sp)
     3d8:	6902                	ld	s2,0(sp)
     3da:	6105                	add	sp,sp,32
     3dc:	8082                	ret

00000000000003de <gettoken>:
char whitespace[] = " \t\r\n\v";
char symbols[] = "<|>&;()";

int
gettoken(char **ps, char *es, char **q, char **eq)
{
     3de:	7139                	add	sp,sp,-64
     3e0:	fc06                	sd	ra,56(sp)
     3e2:	f822                	sd	s0,48(sp)
     3e4:	f426                	sd	s1,40(sp)
     3e6:	f04a                	sd	s2,32(sp)
     3e8:	ec4e                	sd	s3,24(sp)
     3ea:	e852                	sd	s4,16(sp)
     3ec:	e456                	sd	s5,8(sp)
     3ee:	e05a                	sd	s6,0(sp)
     3f0:	0080                	add	s0,sp,64
     3f2:	8a2a                	mv	s4,a0
     3f4:	892e                	mv	s2,a1
     3f6:	8ab2                	mv	s5,a2
     3f8:	8b36                	mv	s6,a3
  char *s;
  int ret;

  s = *ps;
     3fa:	6104                	ld	s1,0(a0)
  while(s < es && strchr(whitespace, *s))
     3fc:	00001997          	auipc	s3,0x1
     400:	38498993          	add	s3,s3,900 # 1780 <whitespace>
     404:	00b4fe63          	bgeu	s1,a1,420 <gettoken+0x42>
     408:	0004c583          	lbu	a1,0(s1)
     40c:	854e                	mv	a0,s3
     40e:	00001097          	auipc	ra,0x1
     412:	81c080e7          	jalr	-2020(ra) # c2a <strchr>
     416:	c509                	beqz	a0,420 <gettoken+0x42>
    s++;
     418:	0485                	add	s1,s1,1
  while(s < es && strchr(whitespace, *s))
     41a:	fe9917e3          	bne	s2,s1,408 <gettoken+0x2a>
     41e:	84ca                	mv	s1,s2
  if(q)
     420:	000a8463          	beqz	s5,428 <gettoken+0x4a>
    *q = s;
     424:	009ab023          	sd	s1,0(s5)
  ret = *s;
     428:	0004c783          	lbu	a5,0(s1)
     42c:	00078a9b          	sext.w	s5,a5
  switch(*s){
     430:	03c00713          	li	a4,60
     434:	06f76663          	bltu	a4,a5,4a0 <gettoken+0xc2>
     438:	03a00713          	li	a4,58
     43c:	00f76e63          	bltu	a4,a5,458 <gettoken+0x7a>
     440:	cf89                	beqz	a5,45a <gettoken+0x7c>
     442:	02600713          	li	a4,38
     446:	00e78963          	beq	a5,a4,458 <gettoken+0x7a>
     44a:	fd87879b          	addw	a5,a5,-40
     44e:	0ff7f793          	zext.b	a5,a5
     452:	4705                	li	a4,1
     454:	06f76d63          	bltu	a4,a5,4ce <gettoken+0xf0>
  case '(':
  case ')':
  case ';':
  case '&':
  case '<':
    s++;
     458:	0485                	add	s1,s1,1
    ret = 'a';
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
      s++;
    break;
  }
  if(eq)
     45a:	000b0463          	beqz	s6,462 <gettoken+0x84>
    *eq = s;
     45e:	009b3023          	sd	s1,0(s6)

  while(s < es && strchr(whitespace, *s))
     462:	00001997          	auipc	s3,0x1
     466:	31e98993          	add	s3,s3,798 # 1780 <whitespace>
     46a:	0124fe63          	bgeu	s1,s2,486 <gettoken+0xa8>
     46e:	0004c583          	lbu	a1,0(s1)
     472:	854e                	mv	a0,s3
     474:	00000097          	auipc	ra,0x0
     478:	7b6080e7          	jalr	1974(ra) # c2a <strchr>
     47c:	c509                	beqz	a0,486 <gettoken+0xa8>
    s++;
     47e:	0485                	add	s1,s1,1
  while(s < es && strchr(whitespace, *s))
     480:	fe9917e3          	bne	s2,s1,46e <gettoken+0x90>
     484:	84ca                	mv	s1,s2
  *ps = s;
     486:	009a3023          	sd	s1,0(s4)
  return ret;
}
     48a:	8556                	mv	a0,s5
     48c:	70e2                	ld	ra,56(sp)
     48e:	7442                	ld	s0,48(sp)
     490:	74a2                	ld	s1,40(sp)
     492:	7902                	ld	s2,32(sp)
     494:	69e2                	ld	s3,24(sp)
     496:	6a42                	ld	s4,16(sp)
     498:	6aa2                	ld	s5,8(sp)
     49a:	6b02                	ld	s6,0(sp)
     49c:	6121                	add	sp,sp,64
     49e:	8082                	ret
  switch(*s){
     4a0:	03e00713          	li	a4,62
     4a4:	02e79163          	bne	a5,a4,4c6 <gettoken+0xe8>
    s++;
     4a8:	00148693          	add	a3,s1,1
    if(*s == '>'){
     4ac:	0014c703          	lbu	a4,1(s1)
     4b0:	03e00793          	li	a5,62
      s++;
     4b4:	0489                	add	s1,s1,2
      ret = '+';
     4b6:	02b00a93          	li	s5,43
    if(*s == '>'){
     4ba:	faf700e3          	beq	a4,a5,45a <gettoken+0x7c>
    s++;
     4be:	84b6                	mv	s1,a3
  ret = *s;
     4c0:	03e00a93          	li	s5,62
     4c4:	bf59                	j	45a <gettoken+0x7c>
  switch(*s){
     4c6:	07c00713          	li	a4,124
     4ca:	f8e787e3          	beq	a5,a4,458 <gettoken+0x7a>
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     4ce:	00001997          	auipc	s3,0x1
     4d2:	2b298993          	add	s3,s3,690 # 1780 <whitespace>
     4d6:	00001a97          	auipc	s5,0x1
     4da:	2a2a8a93          	add	s5,s5,674 # 1778 <symbols>
     4de:	0524f163          	bgeu	s1,s2,520 <gettoken+0x142>
     4e2:	0004c583          	lbu	a1,0(s1)
     4e6:	854e                	mv	a0,s3
     4e8:	00000097          	auipc	ra,0x0
     4ec:	742080e7          	jalr	1858(ra) # c2a <strchr>
     4f0:	e50d                	bnez	a0,51a <gettoken+0x13c>
     4f2:	0004c583          	lbu	a1,0(s1)
     4f6:	8556                	mv	a0,s5
     4f8:	00000097          	auipc	ra,0x0
     4fc:	732080e7          	jalr	1842(ra) # c2a <strchr>
     500:	e911                	bnez	a0,514 <gettoken+0x136>
      s++;
     502:	0485                	add	s1,s1,1
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     504:	fc991fe3          	bne	s2,s1,4e2 <gettoken+0x104>
  if(eq)
     508:	84ca                	mv	s1,s2
    ret = 'a';
     50a:	06100a93          	li	s5,97
  if(eq)
     50e:	f40b18e3          	bnez	s6,45e <gettoken+0x80>
     512:	bf95                	j	486 <gettoken+0xa8>
    ret = 'a';
     514:	06100a93          	li	s5,97
     518:	b789                	j	45a <gettoken+0x7c>
     51a:	06100a93          	li	s5,97
     51e:	bf35                	j	45a <gettoken+0x7c>
     520:	06100a93          	li	s5,97
  if(eq)
     524:	f20b1de3          	bnez	s6,45e <gettoken+0x80>
     528:	bfb9                	j	486 <gettoken+0xa8>

000000000000052a <peek>:

int
peek(char **ps, char *es, char *toks)
{
     52a:	7139                	add	sp,sp,-64
     52c:	fc06                	sd	ra,56(sp)
     52e:	f822                	sd	s0,48(sp)
     530:	f426                	sd	s1,40(sp)
     532:	f04a                	sd	s2,32(sp)
     534:	ec4e                	sd	s3,24(sp)
     536:	e852                	sd	s4,16(sp)
     538:	e456                	sd	s5,8(sp)
     53a:	0080                	add	s0,sp,64
     53c:	8a2a                	mv	s4,a0
     53e:	892e                	mv	s2,a1
     540:	8ab2                	mv	s5,a2
  char *s;

  s = *ps;
     542:	6104                	ld	s1,0(a0)
  while(s < es && strchr(whitespace, *s))
     544:	00001997          	auipc	s3,0x1
     548:	23c98993          	add	s3,s3,572 # 1780 <whitespace>
     54c:	00b4fe63          	bgeu	s1,a1,568 <peek+0x3e>
     550:	0004c583          	lbu	a1,0(s1)
     554:	854e                	mv	a0,s3
     556:	00000097          	auipc	ra,0x0
     55a:	6d4080e7          	jalr	1748(ra) # c2a <strchr>
     55e:	c509                	beqz	a0,568 <peek+0x3e>
    s++;
     560:	0485                	add	s1,s1,1
  while(s < es && strchr(whitespace, *s))
     562:	fe9917e3          	bne	s2,s1,550 <peek+0x26>
     566:	84ca                	mv	s1,s2
  *ps = s;
     568:	009a3023          	sd	s1,0(s4)
  return *s && strchr(toks, *s);
     56c:	0004c583          	lbu	a1,0(s1)
     570:	4501                	li	a0,0
     572:	e991                	bnez	a1,586 <peek+0x5c>
}
     574:	70e2                	ld	ra,56(sp)
     576:	7442                	ld	s0,48(sp)
     578:	74a2                	ld	s1,40(sp)
     57a:	7902                	ld	s2,32(sp)
     57c:	69e2                	ld	s3,24(sp)
     57e:	6a42                	ld	s4,16(sp)
     580:	6aa2                	ld	s5,8(sp)
     582:	6121                	add	sp,sp,64
     584:	8082                	ret
  return *s && strchr(toks, *s);
     586:	8556                	mv	a0,s5
     588:	00000097          	auipc	ra,0x0
     58c:	6a2080e7          	jalr	1698(ra) # c2a <strchr>
     590:	00a03533          	snez	a0,a0
     594:	b7c5                	j	574 <peek+0x4a>

0000000000000596 <parseredirs>:
  return cmd;
}

struct cmd*
parseredirs(struct cmd *cmd, char **ps, char *es)
{
     596:	711d                	add	sp,sp,-96
     598:	ec86                	sd	ra,88(sp)
     59a:	e8a2                	sd	s0,80(sp)
     59c:	e4a6                	sd	s1,72(sp)
     59e:	e0ca                	sd	s2,64(sp)
     5a0:	fc4e                	sd	s3,56(sp)
     5a2:	f852                	sd	s4,48(sp)
     5a4:	f456                	sd	s5,40(sp)
     5a6:	f05a                	sd	s6,32(sp)
     5a8:	ec5e                	sd	s7,24(sp)
     5aa:	1080                	add	s0,sp,96
     5ac:	8a2a                	mv	s4,a0
     5ae:	89ae                	mv	s3,a1
     5b0:	8932                	mv	s2,a2
  int tok;
  char *q, *eq;

  while(peek(ps, es, "<>")){
     5b2:	00001a97          	auipc	s5,0x1
     5b6:	07ea8a93          	add	s5,s5,126 # 1630 <malloc+0x176>
    tok = gettoken(ps, es, 0, 0);
    if(gettoken(ps, es, &q, &eq) != 'a')
     5ba:	06100b13          	li	s6,97
      panic("missing file for redirection");
    switch(tok){
     5be:	03c00b93          	li	s7,60
  while(peek(ps, es, "<>")){
     5c2:	a02d                	j	5ec <parseredirs+0x56>
      panic("missing file for redirection");
     5c4:	00001517          	auipc	a0,0x1
     5c8:	04c50513          	add	a0,a0,76 # 1610 <malloc+0x156>
     5cc:	00000097          	auipc	ra,0x0
     5d0:	a88080e7          	jalr	-1400(ra) # 54 <panic>
    case '<':
      cmd = redircmd(cmd, q, eq, O_RDONLY, 0);
     5d4:	4701                	li	a4,0
     5d6:	4681                	li	a3,0
     5d8:	fa043603          	ld	a2,-96(s0)
     5dc:	fa843583          	ld	a1,-88(s0)
     5e0:	8552                	mv	a0,s4
     5e2:	00000097          	auipc	ra,0x0
     5e6:	ccc080e7          	jalr	-820(ra) # 2ae <redircmd>
     5ea:	8a2a                	mv	s4,a0
  while(peek(ps, es, "<>")){
     5ec:	8656                	mv	a2,s5
     5ee:	85ca                	mv	a1,s2
     5f0:	854e                	mv	a0,s3
     5f2:	00000097          	auipc	ra,0x0
     5f6:	f38080e7          	jalr	-200(ra) # 52a <peek>
     5fa:	cd25                	beqz	a0,672 <parseredirs+0xdc>
    tok = gettoken(ps, es, 0, 0);
     5fc:	4681                	li	a3,0
     5fe:	4601                	li	a2,0
     600:	85ca                	mv	a1,s2
     602:	854e                	mv	a0,s3
     604:	00000097          	auipc	ra,0x0
     608:	dda080e7          	jalr	-550(ra) # 3de <gettoken>
     60c:	84aa                	mv	s1,a0
    if(gettoken(ps, es, &q, &eq) != 'a')
     60e:	fa040693          	add	a3,s0,-96
     612:	fa840613          	add	a2,s0,-88
     616:	85ca                	mv	a1,s2
     618:	854e                	mv	a0,s3
     61a:	00000097          	auipc	ra,0x0
     61e:	dc4080e7          	jalr	-572(ra) # 3de <gettoken>
     622:	fb6511e3          	bne	a0,s6,5c4 <parseredirs+0x2e>
    switch(tok){
     626:	fb7487e3          	beq	s1,s7,5d4 <parseredirs+0x3e>
     62a:	03e00793          	li	a5,62
     62e:	02f48463          	beq	s1,a5,656 <parseredirs+0xc0>
     632:	02b00793          	li	a5,43
     636:	faf49be3          	bne	s1,a5,5ec <parseredirs+0x56>
      break;
    case '>':
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE|O_TRUNC, 1);
      break;
    case '+':  // >>
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
     63a:	4705                	li	a4,1
     63c:	20100693          	li	a3,513
     640:	fa043603          	ld	a2,-96(s0)
     644:	fa843583          	ld	a1,-88(s0)
     648:	8552                	mv	a0,s4
     64a:	00000097          	auipc	ra,0x0
     64e:	c64080e7          	jalr	-924(ra) # 2ae <redircmd>
     652:	8a2a                	mv	s4,a0
      break;
     654:	bf61                	j	5ec <parseredirs+0x56>
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE|O_TRUNC, 1);
     656:	4705                	li	a4,1
     658:	60100693          	li	a3,1537
     65c:	fa043603          	ld	a2,-96(s0)
     660:	fa843583          	ld	a1,-88(s0)
     664:	8552                	mv	a0,s4
     666:	00000097          	auipc	ra,0x0
     66a:	c48080e7          	jalr	-952(ra) # 2ae <redircmd>
     66e:	8a2a                	mv	s4,a0
      break;
     670:	bfb5                	j	5ec <parseredirs+0x56>
    }
  }
  return cmd;
}
     672:	8552                	mv	a0,s4
     674:	60e6                	ld	ra,88(sp)
     676:	6446                	ld	s0,80(sp)
     678:	64a6                	ld	s1,72(sp)
     67a:	6906                	ld	s2,64(sp)
     67c:	79e2                	ld	s3,56(sp)
     67e:	7a42                	ld	s4,48(sp)
     680:	7aa2                	ld	s5,40(sp)
     682:	7b02                	ld	s6,32(sp)
     684:	6be2                	ld	s7,24(sp)
     686:	6125                	add	sp,sp,96
     688:	8082                	ret

000000000000068a <parseexec>:
  return cmd;
}

struct cmd*
parseexec(char **ps, char *es)
{
     68a:	7159                	add	sp,sp,-112
     68c:	f486                	sd	ra,104(sp)
     68e:	f0a2                	sd	s0,96(sp)
     690:	eca6                	sd	s1,88(sp)
     692:	e0d2                	sd	s4,64(sp)
     694:	fc56                	sd	s5,56(sp)
     696:	1880                	add	s0,sp,112
     698:	8a2a                	mv	s4,a0
     69a:	8aae                	mv	s5,a1
  char *q, *eq;
  int tok, argc;
  struct execcmd *cmd;
  struct cmd *ret;

  if(peek(ps, es, "("))
     69c:	00001617          	auipc	a2,0x1
     6a0:	f9c60613          	add	a2,a2,-100 # 1638 <malloc+0x17e>
     6a4:	00000097          	auipc	ra,0x0
     6a8:	e86080e7          	jalr	-378(ra) # 52a <peek>
     6ac:	ed15                	bnez	a0,6e8 <parseexec+0x5e>
     6ae:	e8ca                	sd	s2,80(sp)
     6b0:	e4ce                	sd	s3,72(sp)
     6b2:	f85a                	sd	s6,48(sp)
     6b4:	f45e                	sd	s7,40(sp)
     6b6:	f062                	sd	s8,32(sp)
     6b8:	ec66                	sd	s9,24(sp)
     6ba:	89aa                	mv	s3,a0
    return parseblock(ps, es);

  ret = execcmd();
     6bc:	00000097          	auipc	ra,0x0
     6c0:	bbc080e7          	jalr	-1092(ra) # 278 <execcmd>
     6c4:	8c2a                	mv	s8,a0
  cmd = (struct execcmd*)ret;

  argc = 0;
  ret = parseredirs(ret, ps, es);
     6c6:	8656                	mv	a2,s5
     6c8:	85d2                	mv	a1,s4
     6ca:	00000097          	auipc	ra,0x0
     6ce:	ecc080e7          	jalr	-308(ra) # 596 <parseredirs>
     6d2:	84aa                	mv	s1,a0
  while(!peek(ps, es, "|)&;")){
     6d4:	008c0913          	add	s2,s8,8
     6d8:	00001b17          	auipc	s6,0x1
     6dc:	f80b0b13          	add	s6,s6,-128 # 1658 <malloc+0x19e>
    if((tok=gettoken(ps, es, &q, &eq)) == 0)
      break;
    if(tok != 'a')
     6e0:	06100c93          	li	s9,97
      panic("syntax");
    cmd->argv[argc] = q;
    cmd->eargv[argc] = eq;
    argc++;
    if(argc >= MAXARGS)
     6e4:	4ba9                	li	s7,10
  while(!peek(ps, es, "|)&;")){
     6e6:	a081                	j	726 <parseexec+0x9c>
    return parseblock(ps, es);
     6e8:	85d6                	mv	a1,s5
     6ea:	8552                	mv	a0,s4
     6ec:	00000097          	auipc	ra,0x0
     6f0:	1bc080e7          	jalr	444(ra) # 8a8 <parseblock>
     6f4:	84aa                	mv	s1,a0
    ret = parseredirs(ret, ps, es);
  }
  cmd->argv[argc] = 0;
  cmd->eargv[argc] = 0;
  return ret;
}
     6f6:	8526                	mv	a0,s1
     6f8:	70a6                	ld	ra,104(sp)
     6fa:	7406                	ld	s0,96(sp)
     6fc:	64e6                	ld	s1,88(sp)
     6fe:	6a06                	ld	s4,64(sp)
     700:	7ae2                	ld	s5,56(sp)
     702:	6165                	add	sp,sp,112
     704:	8082                	ret
      panic("syntax");
     706:	00001517          	auipc	a0,0x1
     70a:	f3a50513          	add	a0,a0,-198 # 1640 <malloc+0x186>
     70e:	00000097          	auipc	ra,0x0
     712:	946080e7          	jalr	-1722(ra) # 54 <panic>
    ret = parseredirs(ret, ps, es);
     716:	8656                	mv	a2,s5
     718:	85d2                	mv	a1,s4
     71a:	8526                	mv	a0,s1
     71c:	00000097          	auipc	ra,0x0
     720:	e7a080e7          	jalr	-390(ra) # 596 <parseredirs>
     724:	84aa                	mv	s1,a0
  while(!peek(ps, es, "|)&;")){
     726:	865a                	mv	a2,s6
     728:	85d6                	mv	a1,s5
     72a:	8552                	mv	a0,s4
     72c:	00000097          	auipc	ra,0x0
     730:	dfe080e7          	jalr	-514(ra) # 52a <peek>
     734:	e131                	bnez	a0,778 <parseexec+0xee>
    if((tok=gettoken(ps, es, &q, &eq)) == 0)
     736:	f9040693          	add	a3,s0,-112
     73a:	f9840613          	add	a2,s0,-104
     73e:	85d6                	mv	a1,s5
     740:	8552                	mv	a0,s4
     742:	00000097          	auipc	ra,0x0
     746:	c9c080e7          	jalr	-868(ra) # 3de <gettoken>
     74a:	c51d                	beqz	a0,778 <parseexec+0xee>
    if(tok != 'a')
     74c:	fb951de3          	bne	a0,s9,706 <parseexec+0x7c>
    cmd->argv[argc] = q;
     750:	f9843783          	ld	a5,-104(s0)
     754:	00f93023          	sd	a5,0(s2)
    cmd->eargv[argc] = eq;
     758:	f9043783          	ld	a5,-112(s0)
     75c:	04f93823          	sd	a5,80(s2)
    argc++;
     760:	2985                	addw	s3,s3,1
    if(argc >= MAXARGS)
     762:	0921                	add	s2,s2,8
     764:	fb7999e3          	bne	s3,s7,716 <parseexec+0x8c>
      panic("too many args");
     768:	00001517          	auipc	a0,0x1
     76c:	ee050513          	add	a0,a0,-288 # 1648 <malloc+0x18e>
     770:	00000097          	auipc	ra,0x0
     774:	8e4080e7          	jalr	-1820(ra) # 54 <panic>
  cmd->argv[argc] = 0;
     778:	098e                	sll	s3,s3,0x3
     77a:	9c4e                	add	s8,s8,s3
     77c:	000c3423          	sd	zero,8(s8)
  cmd->eargv[argc] = 0;
     780:	040c3c23          	sd	zero,88(s8)
     784:	6946                	ld	s2,80(sp)
     786:	69a6                	ld	s3,72(sp)
     788:	7b42                	ld	s6,48(sp)
     78a:	7ba2                	ld	s7,40(sp)
     78c:	7c02                	ld	s8,32(sp)
     78e:	6ce2                	ld	s9,24(sp)
  return ret;
     790:	b79d                	j	6f6 <parseexec+0x6c>

0000000000000792 <parsepipe>:
{
     792:	7179                	add	sp,sp,-48
     794:	f406                	sd	ra,40(sp)
     796:	f022                	sd	s0,32(sp)
     798:	ec26                	sd	s1,24(sp)
     79a:	e84a                	sd	s2,16(sp)
     79c:	e44e                	sd	s3,8(sp)
     79e:	1800                	add	s0,sp,48
     7a0:	892a                	mv	s2,a0
     7a2:	89ae                	mv	s3,a1
  cmd = parseexec(ps, es);
     7a4:	00000097          	auipc	ra,0x0
     7a8:	ee6080e7          	jalr	-282(ra) # 68a <parseexec>
     7ac:	84aa                	mv	s1,a0
  if(peek(ps, es, "|")){
     7ae:	00001617          	auipc	a2,0x1
     7b2:	eb260613          	add	a2,a2,-334 # 1660 <malloc+0x1a6>
     7b6:	85ce                	mv	a1,s3
     7b8:	854a                	mv	a0,s2
     7ba:	00000097          	auipc	ra,0x0
     7be:	d70080e7          	jalr	-656(ra) # 52a <peek>
     7c2:	e909                	bnez	a0,7d4 <parsepipe+0x42>
}
     7c4:	8526                	mv	a0,s1
     7c6:	70a2                	ld	ra,40(sp)
     7c8:	7402                	ld	s0,32(sp)
     7ca:	64e2                	ld	s1,24(sp)
     7cc:	6942                	ld	s2,16(sp)
     7ce:	69a2                	ld	s3,8(sp)
     7d0:	6145                	add	sp,sp,48
     7d2:	8082                	ret
    gettoken(ps, es, 0, 0);
     7d4:	4681                	li	a3,0
     7d6:	4601                	li	a2,0
     7d8:	85ce                	mv	a1,s3
     7da:	854a                	mv	a0,s2
     7dc:	00000097          	auipc	ra,0x0
     7e0:	c02080e7          	jalr	-1022(ra) # 3de <gettoken>
    cmd = pipecmd(cmd, parsepipe(ps, es));
     7e4:	85ce                	mv	a1,s3
     7e6:	854a                	mv	a0,s2
     7e8:	00000097          	auipc	ra,0x0
     7ec:	faa080e7          	jalr	-86(ra) # 792 <parsepipe>
     7f0:	85aa                	mv	a1,a0
     7f2:	8526                	mv	a0,s1
     7f4:	00000097          	auipc	ra,0x0
     7f8:	b22080e7          	jalr	-1246(ra) # 316 <pipecmd>
     7fc:	84aa                	mv	s1,a0
  return cmd;
     7fe:	b7d9                	j	7c4 <parsepipe+0x32>

0000000000000800 <parseline>:
{
     800:	7179                	add	sp,sp,-48
     802:	f406                	sd	ra,40(sp)
     804:	f022                	sd	s0,32(sp)
     806:	ec26                	sd	s1,24(sp)
     808:	e84a                	sd	s2,16(sp)
     80a:	e44e                	sd	s3,8(sp)
     80c:	e052                	sd	s4,0(sp)
     80e:	1800                	add	s0,sp,48
     810:	892a                	mv	s2,a0
     812:	89ae                	mv	s3,a1
  cmd = parsepipe(ps, es);
     814:	00000097          	auipc	ra,0x0
     818:	f7e080e7          	jalr	-130(ra) # 792 <parsepipe>
     81c:	84aa                	mv	s1,a0
  while(peek(ps, es, "&")){
     81e:	00001a17          	auipc	s4,0x1
     822:	e4aa0a13          	add	s4,s4,-438 # 1668 <malloc+0x1ae>
     826:	a839                	j	844 <parseline+0x44>
    gettoken(ps, es, 0, 0);
     828:	4681                	li	a3,0
     82a:	4601                	li	a2,0
     82c:	85ce                	mv	a1,s3
     82e:	854a                	mv	a0,s2
     830:	00000097          	auipc	ra,0x0
     834:	bae080e7          	jalr	-1106(ra) # 3de <gettoken>
    cmd = backcmd(cmd);
     838:	8526                	mv	a0,s1
     83a:	00000097          	auipc	ra,0x0
     83e:	b68080e7          	jalr	-1176(ra) # 3a2 <backcmd>
     842:	84aa                	mv	s1,a0
  while(peek(ps, es, "&")){
     844:	8652                	mv	a2,s4
     846:	85ce                	mv	a1,s3
     848:	854a                	mv	a0,s2
     84a:	00000097          	auipc	ra,0x0
     84e:	ce0080e7          	jalr	-800(ra) # 52a <peek>
     852:	f979                	bnez	a0,828 <parseline+0x28>
  if(peek(ps, es, ";")){
     854:	00001617          	auipc	a2,0x1
     858:	e1c60613          	add	a2,a2,-484 # 1670 <malloc+0x1b6>
     85c:	85ce                	mv	a1,s3
     85e:	854a                	mv	a0,s2
     860:	00000097          	auipc	ra,0x0
     864:	cca080e7          	jalr	-822(ra) # 52a <peek>
     868:	e911                	bnez	a0,87c <parseline+0x7c>
}
     86a:	8526                	mv	a0,s1
     86c:	70a2                	ld	ra,40(sp)
     86e:	7402                	ld	s0,32(sp)
     870:	64e2                	ld	s1,24(sp)
     872:	6942                	ld	s2,16(sp)
     874:	69a2                	ld	s3,8(sp)
     876:	6a02                	ld	s4,0(sp)
     878:	6145                	add	sp,sp,48
     87a:	8082                	ret
    gettoken(ps, es, 0, 0);
     87c:	4681                	li	a3,0
     87e:	4601                	li	a2,0
     880:	85ce                	mv	a1,s3
     882:	854a                	mv	a0,s2
     884:	00000097          	auipc	ra,0x0
     888:	b5a080e7          	jalr	-1190(ra) # 3de <gettoken>
    cmd = listcmd(cmd, parseline(ps, es));
     88c:	85ce                	mv	a1,s3
     88e:	854a                	mv	a0,s2
     890:	00000097          	auipc	ra,0x0
     894:	f70080e7          	jalr	-144(ra) # 800 <parseline>
     898:	85aa                	mv	a1,a0
     89a:	8526                	mv	a0,s1
     89c:	00000097          	auipc	ra,0x0
     8a0:	ac0080e7          	jalr	-1344(ra) # 35c <listcmd>
     8a4:	84aa                	mv	s1,a0
  return cmd;
     8a6:	b7d1                	j	86a <parseline+0x6a>

00000000000008a8 <parseblock>:
{
     8a8:	7179                	add	sp,sp,-48
     8aa:	f406                	sd	ra,40(sp)
     8ac:	f022                	sd	s0,32(sp)
     8ae:	ec26                	sd	s1,24(sp)
     8b0:	e84a                	sd	s2,16(sp)
     8b2:	e44e                	sd	s3,8(sp)
     8b4:	1800                	add	s0,sp,48
     8b6:	84aa                	mv	s1,a0
     8b8:	892e                	mv	s2,a1
  if(!peek(ps, es, "("))
     8ba:	00001617          	auipc	a2,0x1
     8be:	d7e60613          	add	a2,a2,-642 # 1638 <malloc+0x17e>
     8c2:	00000097          	auipc	ra,0x0
     8c6:	c68080e7          	jalr	-920(ra) # 52a <peek>
     8ca:	c12d                	beqz	a0,92c <parseblock+0x84>
  gettoken(ps, es, 0, 0);
     8cc:	4681                	li	a3,0
     8ce:	4601                	li	a2,0
     8d0:	85ca                	mv	a1,s2
     8d2:	8526                	mv	a0,s1
     8d4:	00000097          	auipc	ra,0x0
     8d8:	b0a080e7          	jalr	-1270(ra) # 3de <gettoken>
  cmd = parseline(ps, es);
     8dc:	85ca                	mv	a1,s2
     8de:	8526                	mv	a0,s1
     8e0:	00000097          	auipc	ra,0x0
     8e4:	f20080e7          	jalr	-224(ra) # 800 <parseline>
     8e8:	89aa                	mv	s3,a0
  if(!peek(ps, es, ")"))
     8ea:	00001617          	auipc	a2,0x1
     8ee:	d9e60613          	add	a2,a2,-610 # 1688 <malloc+0x1ce>
     8f2:	85ca                	mv	a1,s2
     8f4:	8526                	mv	a0,s1
     8f6:	00000097          	auipc	ra,0x0
     8fa:	c34080e7          	jalr	-972(ra) # 52a <peek>
     8fe:	cd1d                	beqz	a0,93c <parseblock+0x94>
  gettoken(ps, es, 0, 0);
     900:	4681                	li	a3,0
     902:	4601                	li	a2,0
     904:	85ca                	mv	a1,s2
     906:	8526                	mv	a0,s1
     908:	00000097          	auipc	ra,0x0
     90c:	ad6080e7          	jalr	-1322(ra) # 3de <gettoken>
  cmd = parseredirs(cmd, ps, es);
     910:	864a                	mv	a2,s2
     912:	85a6                	mv	a1,s1
     914:	854e                	mv	a0,s3
     916:	00000097          	auipc	ra,0x0
     91a:	c80080e7          	jalr	-896(ra) # 596 <parseredirs>
}
     91e:	70a2                	ld	ra,40(sp)
     920:	7402                	ld	s0,32(sp)
     922:	64e2                	ld	s1,24(sp)
     924:	6942                	ld	s2,16(sp)
     926:	69a2                	ld	s3,8(sp)
     928:	6145                	add	sp,sp,48
     92a:	8082                	ret
    panic("parseblock");
     92c:	00001517          	auipc	a0,0x1
     930:	d4c50513          	add	a0,a0,-692 # 1678 <malloc+0x1be>
     934:	fffff097          	auipc	ra,0xfffff
     938:	720080e7          	jalr	1824(ra) # 54 <panic>
    panic("syntax - missing )");
     93c:	00001517          	auipc	a0,0x1
     940:	d5450513          	add	a0,a0,-684 # 1690 <malloc+0x1d6>
     944:	fffff097          	auipc	ra,0xfffff
     948:	710080e7          	jalr	1808(ra) # 54 <panic>

000000000000094c <nulterminate>:

// NUL-terminate all the counted strings.
struct cmd*
nulterminate(struct cmd *cmd)
{
     94c:	1101                	add	sp,sp,-32
     94e:	ec06                	sd	ra,24(sp)
     950:	e822                	sd	s0,16(sp)
     952:	e426                	sd	s1,8(sp)
     954:	1000                	add	s0,sp,32
     956:	84aa                	mv	s1,a0
  struct execcmd *ecmd;
  struct listcmd *lcmd;
  struct pipecmd *pcmd;
  struct redircmd *rcmd;

  if(cmd == 0)
     958:	c521                	beqz	a0,9a0 <nulterminate+0x54>
    return 0;

  switch(cmd->type){
     95a:	4118                	lw	a4,0(a0)
     95c:	4795                	li	a5,5
     95e:	04e7e163          	bltu	a5,a4,9a0 <nulterminate+0x54>
     962:	00056783          	lwu	a5,0(a0)
     966:	078a                	sll	a5,a5,0x2
     968:	00001717          	auipc	a4,0x1
     96c:	d8870713          	add	a4,a4,-632 # 16f0 <malloc+0x236>
     970:	97ba                	add	a5,a5,a4
     972:	439c                	lw	a5,0(a5)
     974:	97ba                	add	a5,a5,a4
     976:	8782                	jr	a5
  case EXEC:
    ecmd = (struct execcmd*)cmd;
    for(i=0; ecmd->argv[i]; i++)
     978:	651c                	ld	a5,8(a0)
     97a:	c39d                	beqz	a5,9a0 <nulterminate+0x54>
     97c:	01050793          	add	a5,a0,16
      *ecmd->eargv[i] = 0;
     980:	67b8                	ld	a4,72(a5)
     982:	00070023          	sb	zero,0(a4)
    for(i=0; ecmd->argv[i]; i++)
     986:	07a1                	add	a5,a5,8
     988:	ff87b703          	ld	a4,-8(a5)
     98c:	fb75                	bnez	a4,980 <nulterminate+0x34>
     98e:	a809                	j	9a0 <nulterminate+0x54>
    break;

  case REDIR:
    rcmd = (struct redircmd*)cmd;
    nulterminate(rcmd->cmd);
     990:	6508                	ld	a0,8(a0)
     992:	00000097          	auipc	ra,0x0
     996:	fba080e7          	jalr	-70(ra) # 94c <nulterminate>
    *rcmd->efile = 0;
     99a:	6c9c                	ld	a5,24(s1)
     99c:	00078023          	sb	zero,0(a5)
    bcmd = (struct backcmd*)cmd;
    nulterminate(bcmd->cmd);
    break;
  }
  return cmd;
}
     9a0:	8526                	mv	a0,s1
     9a2:	60e2                	ld	ra,24(sp)
     9a4:	6442                	ld	s0,16(sp)
     9a6:	64a2                	ld	s1,8(sp)
     9a8:	6105                	add	sp,sp,32
     9aa:	8082                	ret
    nulterminate(pcmd->left);
     9ac:	6508                	ld	a0,8(a0)
     9ae:	00000097          	auipc	ra,0x0
     9b2:	f9e080e7          	jalr	-98(ra) # 94c <nulterminate>
    nulterminate(pcmd->right);
     9b6:	6888                	ld	a0,16(s1)
     9b8:	00000097          	auipc	ra,0x0
     9bc:	f94080e7          	jalr	-108(ra) # 94c <nulterminate>
    break;
     9c0:	b7c5                	j	9a0 <nulterminate+0x54>
    nulterminate(lcmd->left);
     9c2:	6508                	ld	a0,8(a0)
     9c4:	00000097          	auipc	ra,0x0
     9c8:	f88080e7          	jalr	-120(ra) # 94c <nulterminate>
    nulterminate(lcmd->right);
     9cc:	6888                	ld	a0,16(s1)
     9ce:	00000097          	auipc	ra,0x0
     9d2:	f7e080e7          	jalr	-130(ra) # 94c <nulterminate>
    break;
     9d6:	b7e9                	j	9a0 <nulterminate+0x54>
    nulterminate(bcmd->cmd);
     9d8:	6508                	ld	a0,8(a0)
     9da:	00000097          	auipc	ra,0x0
     9de:	f72080e7          	jalr	-142(ra) # 94c <nulterminate>
    break;
     9e2:	bf7d                	j	9a0 <nulterminate+0x54>

00000000000009e4 <parsecmd>:
{
     9e4:	7179                	add	sp,sp,-48
     9e6:	f406                	sd	ra,40(sp)
     9e8:	f022                	sd	s0,32(sp)
     9ea:	ec26                	sd	s1,24(sp)
     9ec:	e84a                	sd	s2,16(sp)
     9ee:	1800                	add	s0,sp,48
     9f0:	fca43c23          	sd	a0,-40(s0)
  es = s + strlen(s);
     9f4:	84aa                	mv	s1,a0
     9f6:	00000097          	auipc	ra,0x0
     9fa:	1ba080e7          	jalr	442(ra) # bb0 <strlen>
     9fe:	1502                	sll	a0,a0,0x20
     a00:	9101                	srl	a0,a0,0x20
     a02:	94aa                	add	s1,s1,a0
  cmd = parseline(&s, es);
     a04:	85a6                	mv	a1,s1
     a06:	fd840513          	add	a0,s0,-40
     a0a:	00000097          	auipc	ra,0x0
     a0e:	df6080e7          	jalr	-522(ra) # 800 <parseline>
     a12:	892a                	mv	s2,a0
  peek(&s, es, "");
     a14:	00001617          	auipc	a2,0x1
     a18:	bb460613          	add	a2,a2,-1100 # 15c8 <malloc+0x10e>
     a1c:	85a6                	mv	a1,s1
     a1e:	fd840513          	add	a0,s0,-40
     a22:	00000097          	auipc	ra,0x0
     a26:	b08080e7          	jalr	-1272(ra) # 52a <peek>
  if(s != es){
     a2a:	fd843603          	ld	a2,-40(s0)
     a2e:	00961e63          	bne	a2,s1,a4a <parsecmd+0x66>
  nulterminate(cmd);
     a32:	854a                	mv	a0,s2
     a34:	00000097          	auipc	ra,0x0
     a38:	f18080e7          	jalr	-232(ra) # 94c <nulterminate>
}
     a3c:	854a                	mv	a0,s2
     a3e:	70a2                	ld	ra,40(sp)
     a40:	7402                	ld	s0,32(sp)
     a42:	64e2                	ld	s1,24(sp)
     a44:	6942                	ld	s2,16(sp)
     a46:	6145                	add	sp,sp,48
     a48:	8082                	ret
    fprintf(2, "leftovers: %s\n", s);
     a4a:	00001597          	auipc	a1,0x1
     a4e:	c5e58593          	add	a1,a1,-930 # 16a8 <malloc+0x1ee>
     a52:	4509                	li	a0,2
     a54:	00000097          	auipc	ra,0x0
     a58:	7b8080e7          	jalr	1976(ra) # 120c <fprintf>
    panic("syntax");
     a5c:	00001517          	auipc	a0,0x1
     a60:	be450513          	add	a0,a0,-1052 # 1640 <malloc+0x186>
     a64:	fffff097          	auipc	ra,0xfffff
     a68:	5f0080e7          	jalr	1520(ra) # 54 <panic>

0000000000000a6c <main>:
{
     a6c:	7179                	add	sp,sp,-48
     a6e:	f406                	sd	ra,40(sp)
     a70:	f022                	sd	s0,32(sp)
     a72:	ec26                	sd	s1,24(sp)
     a74:	e84a                	sd	s2,16(sp)
     a76:	e44e                	sd	s3,8(sp)
     a78:	e052                	sd	s4,0(sp)
     a7a:	1800                	add	s0,sp,48
  while((fd = open("console", O_RDWR)) >= 0){
     a7c:	00001497          	auipc	s1,0x1
     a80:	c3c48493          	add	s1,s1,-964 # 16b8 <malloc+0x1fe>
     a84:	4589                	li	a1,2
     a86:	8526                	mv	a0,s1
     a88:	00000097          	auipc	ra,0x0
     a8c:	3ba080e7          	jalr	954(ra) # e42 <open>
     a90:	00054963          	bltz	a0,aa2 <main+0x36>
    if(fd >= 3){
     a94:	4789                	li	a5,2
     a96:	fea7d7e3          	bge	a5,a0,a84 <main+0x18>
      close(fd);
     a9a:	00000097          	auipc	ra,0x0
     a9e:	390080e7          	jalr	912(ra) # e2a <close>
  while(getcmd(buf, sizeof(buf)) >= 0){
     aa2:	00001497          	auipc	s1,0x1
     aa6:	cee48493          	add	s1,s1,-786 # 1790 <buf.0>
    if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
     aaa:	06300913          	li	s2,99
     aae:	02000993          	li	s3,32
     ab2:	a819                	j	ac8 <main+0x5c>
    if(fork1() == 0)
     ab4:	fffff097          	auipc	ra,0xfffff
     ab8:	5c6080e7          	jalr	1478(ra) # 7a <fork1>
     abc:	c549                	beqz	a0,b46 <main+0xda>
    wait(0);
     abe:	4501                	li	a0,0
     ac0:	00000097          	auipc	ra,0x0
     ac4:	34a080e7          	jalr	842(ra) # e0a <wait>
  while(getcmd(buf, sizeof(buf)) >= 0){
     ac8:	06400593          	li	a1,100
     acc:	8526                	mv	a0,s1
     ace:	fffff097          	auipc	ra,0xfffff
     ad2:	532080e7          	jalr	1330(ra) # 0 <getcmd>
     ad6:	08054463          	bltz	a0,b5e <main+0xf2>
    if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
     ada:	0004c783          	lbu	a5,0(s1)
     ade:	fd279be3          	bne	a5,s2,ab4 <main+0x48>
     ae2:	0014c703          	lbu	a4,1(s1)
     ae6:	06400793          	li	a5,100
     aea:	fcf715e3          	bne	a4,a5,ab4 <main+0x48>
     aee:	0024c783          	lbu	a5,2(s1)
     af2:	fd3791e3          	bne	a5,s3,ab4 <main+0x48>
      buf[strlen(buf)-1] = 0;  // chop \n
     af6:	00001a17          	auipc	s4,0x1
     afa:	c9aa0a13          	add	s4,s4,-870 # 1790 <buf.0>
     afe:	8552                	mv	a0,s4
     b00:	00000097          	auipc	ra,0x0
     b04:	0b0080e7          	jalr	176(ra) # bb0 <strlen>
     b08:	fff5079b          	addw	a5,a0,-1
     b0c:	1782                	sll	a5,a5,0x20
     b0e:	9381                	srl	a5,a5,0x20
     b10:	9a3e                	add	s4,s4,a5
     b12:	000a0023          	sb	zero,0(s4)
      if(chdir(buf+3) < 0)
     b16:	00001517          	auipc	a0,0x1
     b1a:	c7d50513          	add	a0,a0,-899 # 1793 <buf.0+0x3>
     b1e:	00000097          	auipc	ra,0x0
     b22:	354080e7          	jalr	852(ra) # e72 <chdir>
     b26:	fa0551e3          	bgez	a0,ac8 <main+0x5c>
        fprintf(2, "cannot cd %s\n", buf+3);
     b2a:	00001617          	auipc	a2,0x1
     b2e:	c6960613          	add	a2,a2,-919 # 1793 <buf.0+0x3>
     b32:	00001597          	auipc	a1,0x1
     b36:	b8e58593          	add	a1,a1,-1138 # 16c0 <malloc+0x206>
     b3a:	4509                	li	a0,2
     b3c:	00000097          	auipc	ra,0x0
     b40:	6d0080e7          	jalr	1744(ra) # 120c <fprintf>
     b44:	b751                	j	ac8 <main+0x5c>
      runcmd(parsecmd(buf));
     b46:	00001517          	auipc	a0,0x1
     b4a:	c4a50513          	add	a0,a0,-950 # 1790 <buf.0>
     b4e:	00000097          	auipc	ra,0x0
     b52:	e96080e7          	jalr	-362(ra) # 9e4 <parsecmd>
     b56:	fffff097          	auipc	ra,0xfffff
     b5a:	552080e7          	jalr	1362(ra) # a8 <runcmd>
  exit(0);
     b5e:	4501                	li	a0,0
     b60:	00000097          	auipc	ra,0x0
     b64:	2a2080e7          	jalr	674(ra) # e02 <exit>

0000000000000b68 <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
     b68:	1141                	add	sp,sp,-16
     b6a:	e422                	sd	s0,8(sp)
     b6c:	0800                	add	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
     b6e:	87aa                	mv	a5,a0
     b70:	0585                	add	a1,a1,1
     b72:	0785                	add	a5,a5,1
     b74:	fff5c703          	lbu	a4,-1(a1)
     b78:	fee78fa3          	sb	a4,-1(a5)
     b7c:	fb75                	bnez	a4,b70 <strcpy+0x8>
    ;
  return os;
}
     b7e:	6422                	ld	s0,8(sp)
     b80:	0141                	add	sp,sp,16
     b82:	8082                	ret

0000000000000b84 <strcmp>:

int
strcmp(const char *p, const char *q)
{
     b84:	1141                	add	sp,sp,-16
     b86:	e422                	sd	s0,8(sp)
     b88:	0800                	add	s0,sp,16
  while(*p && *p == *q)
     b8a:	00054783          	lbu	a5,0(a0)
     b8e:	cb91                	beqz	a5,ba2 <strcmp+0x1e>
     b90:	0005c703          	lbu	a4,0(a1)
     b94:	00f71763          	bne	a4,a5,ba2 <strcmp+0x1e>
    p++, q++;
     b98:	0505                	add	a0,a0,1
     b9a:	0585                	add	a1,a1,1
  while(*p && *p == *q)
     b9c:	00054783          	lbu	a5,0(a0)
     ba0:	fbe5                	bnez	a5,b90 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
     ba2:	0005c503          	lbu	a0,0(a1)
}
     ba6:	40a7853b          	subw	a0,a5,a0
     baa:	6422                	ld	s0,8(sp)
     bac:	0141                	add	sp,sp,16
     bae:	8082                	ret

0000000000000bb0 <strlen>:

uint
strlen(const char *s)
{
     bb0:	1141                	add	sp,sp,-16
     bb2:	e422                	sd	s0,8(sp)
     bb4:	0800                	add	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
     bb6:	00054783          	lbu	a5,0(a0)
     bba:	cf91                	beqz	a5,bd6 <strlen+0x26>
     bbc:	0505                	add	a0,a0,1
     bbe:	87aa                	mv	a5,a0
     bc0:	86be                	mv	a3,a5
     bc2:	0785                	add	a5,a5,1
     bc4:	fff7c703          	lbu	a4,-1(a5)
     bc8:	ff65                	bnez	a4,bc0 <strlen+0x10>
     bca:	40a6853b          	subw	a0,a3,a0
     bce:	2505                	addw	a0,a0,1
    ;
  return n;
}
     bd0:	6422                	ld	s0,8(sp)
     bd2:	0141                	add	sp,sp,16
     bd4:	8082                	ret
  for(n = 0; s[n]; n++)
     bd6:	4501                	li	a0,0
     bd8:	bfe5                	j	bd0 <strlen+0x20>

0000000000000bda <strcat>:

char *
strcat(char *dst, char *src)
{
     bda:	1141                	add	sp,sp,-16
     bdc:	e422                	sd	s0,8(sp)
     bde:	0800                	add	s0,sp,16
  char *s = dst;
  while (*dst)
     be0:	00054783          	lbu	a5,0(a0)
     be4:	c385                	beqz	a5,c04 <strcat+0x2a>
     be6:	87aa                	mv	a5,a0
    dst++;
     be8:	0785                	add	a5,a5,1
  while (*dst)
     bea:	0007c703          	lbu	a4,0(a5)
     bee:	ff6d                	bnez	a4,be8 <strcat+0xe>
  while ((*dst++ = *src++) != 0);
     bf0:	0585                	add	a1,a1,1
     bf2:	0785                	add	a5,a5,1
     bf4:	fff5c703          	lbu	a4,-1(a1)
     bf8:	fee78fa3          	sb	a4,-1(a5)
     bfc:	fb75                	bnez	a4,bf0 <strcat+0x16>

  return s;
}
     bfe:	6422                	ld	s0,8(sp)
     c00:	0141                	add	sp,sp,16
     c02:	8082                	ret
  while (*dst)
     c04:	87aa                	mv	a5,a0
     c06:	b7ed                	j	bf0 <strcat+0x16>

0000000000000c08 <memset>:

void*
memset(void *dst, int c, uint n)
{
     c08:	1141                	add	sp,sp,-16
     c0a:	e422                	sd	s0,8(sp)
     c0c:	0800                	add	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
     c0e:	ca19                	beqz	a2,c24 <memset+0x1c>
     c10:	87aa                	mv	a5,a0
     c12:	1602                	sll	a2,a2,0x20
     c14:	9201                	srl	a2,a2,0x20
     c16:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
     c1a:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
     c1e:	0785                	add	a5,a5,1
     c20:	fee79de3          	bne	a5,a4,c1a <memset+0x12>
  }
  return dst;
}
     c24:	6422                	ld	s0,8(sp)
     c26:	0141                	add	sp,sp,16
     c28:	8082                	ret

0000000000000c2a <strchr>:

char*
strchr(const char *s, char c)
{
     c2a:	1141                	add	sp,sp,-16
     c2c:	e422                	sd	s0,8(sp)
     c2e:	0800                	add	s0,sp,16
  for(; *s; s++)
     c30:	00054783          	lbu	a5,0(a0)
     c34:	cb99                	beqz	a5,c4a <strchr+0x20>
    if(*s == c)
     c36:	00f58763          	beq	a1,a5,c44 <strchr+0x1a>
  for(; *s; s++)
     c3a:	0505                	add	a0,a0,1
     c3c:	00054783          	lbu	a5,0(a0)
     c40:	fbfd                	bnez	a5,c36 <strchr+0xc>
      return (char*)s;
  return 0;
     c42:	4501                	li	a0,0
}
     c44:	6422                	ld	s0,8(sp)
     c46:	0141                	add	sp,sp,16
     c48:	8082                	ret
  return 0;
     c4a:	4501                	li	a0,0
     c4c:	bfe5                	j	c44 <strchr+0x1a>

0000000000000c4e <gets>:

char*
gets(char *buf, int max)
{
     c4e:	711d                	add	sp,sp,-96
     c50:	ec86                	sd	ra,88(sp)
     c52:	e8a2                	sd	s0,80(sp)
     c54:	e4a6                	sd	s1,72(sp)
     c56:	e0ca                	sd	s2,64(sp)
     c58:	fc4e                	sd	s3,56(sp)
     c5a:	f852                	sd	s4,48(sp)
     c5c:	f456                	sd	s5,40(sp)
     c5e:	f05a                	sd	s6,32(sp)
     c60:	ec5e                	sd	s7,24(sp)
     c62:	1080                	add	s0,sp,96
     c64:	8baa                	mv	s7,a0
     c66:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     c68:	892a                	mv	s2,a0
     c6a:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
     c6c:	4aa9                	li	s5,10
     c6e:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
     c70:	89a6                	mv	s3,s1
     c72:	2485                	addw	s1,s1,1
     c74:	0344d863          	bge	s1,s4,ca4 <gets+0x56>
    cc = read(0, &c, 1);
     c78:	4605                	li	a2,1
     c7a:	faf40593          	add	a1,s0,-81
     c7e:	4501                	li	a0,0
     c80:	00000097          	auipc	ra,0x0
     c84:	19a080e7          	jalr	410(ra) # e1a <read>
    if(cc < 1)
     c88:	00a05e63          	blez	a0,ca4 <gets+0x56>
    buf[i++] = c;
     c8c:	faf44783          	lbu	a5,-81(s0)
     c90:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
     c94:	01578763          	beq	a5,s5,ca2 <gets+0x54>
     c98:	0905                	add	s2,s2,1
     c9a:	fd679be3          	bne	a5,s6,c70 <gets+0x22>
    buf[i++] = c;
     c9e:	89a6                	mv	s3,s1
     ca0:	a011                	j	ca4 <gets+0x56>
     ca2:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
     ca4:	99de                	add	s3,s3,s7
     ca6:	00098023          	sb	zero,0(s3)
  return buf;
}
     caa:	855e                	mv	a0,s7
     cac:	60e6                	ld	ra,88(sp)
     cae:	6446                	ld	s0,80(sp)
     cb0:	64a6                	ld	s1,72(sp)
     cb2:	6906                	ld	s2,64(sp)
     cb4:	79e2                	ld	s3,56(sp)
     cb6:	7a42                	ld	s4,48(sp)
     cb8:	7aa2                	ld	s5,40(sp)
     cba:	7b02                	ld	s6,32(sp)
     cbc:	6be2                	ld	s7,24(sp)
     cbe:	6125                	add	sp,sp,96
     cc0:	8082                	ret

0000000000000cc2 <stat>:

int
stat(const char *n, struct stat *st)
{
     cc2:	1101                	add	sp,sp,-32
     cc4:	ec06                	sd	ra,24(sp)
     cc6:	e822                	sd	s0,16(sp)
     cc8:	e04a                	sd	s2,0(sp)
     cca:	1000                	add	s0,sp,32
     ccc:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     cce:	4581                	li	a1,0
     cd0:	00000097          	auipc	ra,0x0
     cd4:	172080e7          	jalr	370(ra) # e42 <open>
  if(fd < 0)
     cd8:	02054663          	bltz	a0,d04 <stat+0x42>
     cdc:	e426                	sd	s1,8(sp)
     cde:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
     ce0:	85ca                	mv	a1,s2
     ce2:	00000097          	auipc	ra,0x0
     ce6:	178080e7          	jalr	376(ra) # e5a <fstat>
     cea:	892a                	mv	s2,a0
  close(fd);
     cec:	8526                	mv	a0,s1
     cee:	00000097          	auipc	ra,0x0
     cf2:	13c080e7          	jalr	316(ra) # e2a <close>
  return r;
     cf6:	64a2                	ld	s1,8(sp)
}
     cf8:	854a                	mv	a0,s2
     cfa:	60e2                	ld	ra,24(sp)
     cfc:	6442                	ld	s0,16(sp)
     cfe:	6902                	ld	s2,0(sp)
     d00:	6105                	add	sp,sp,32
     d02:	8082                	ret
    return -1;
     d04:	597d                	li	s2,-1
     d06:	bfcd                	j	cf8 <stat+0x36>

0000000000000d08 <atoi>:

int
atoi(const char *s)
{
     d08:	1141                	add	sp,sp,-16
     d0a:	e422                	sd	s0,8(sp)
     d0c:	0800                	add	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
     d0e:	00054683          	lbu	a3,0(a0)
     d12:	fd06879b          	addw	a5,a3,-48
     d16:	0ff7f793          	zext.b	a5,a5
     d1a:	4625                	li	a2,9
     d1c:	02f66863          	bltu	a2,a5,d4c <atoi+0x44>
     d20:	872a                	mv	a4,a0
  n = 0;
     d22:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
     d24:	0705                	add	a4,a4,1
     d26:	0025179b          	sllw	a5,a0,0x2
     d2a:	9fa9                	addw	a5,a5,a0
     d2c:	0017979b          	sllw	a5,a5,0x1
     d30:	9fb5                	addw	a5,a5,a3
     d32:	fd07851b          	addw	a0,a5,-48
  while('0' <= *s && *s <= '9')
     d36:	00074683          	lbu	a3,0(a4)
     d3a:	fd06879b          	addw	a5,a3,-48
     d3e:	0ff7f793          	zext.b	a5,a5
     d42:	fef671e3          	bgeu	a2,a5,d24 <atoi+0x1c>
  return n;
}
     d46:	6422                	ld	s0,8(sp)
     d48:	0141                	add	sp,sp,16
     d4a:	8082                	ret
  n = 0;
     d4c:	4501                	li	a0,0
     d4e:	bfe5                	j	d46 <atoi+0x3e>

0000000000000d50 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
     d50:	1141                	add	sp,sp,-16
     d52:	e422                	sd	s0,8(sp)
     d54:	0800                	add	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
     d56:	02b57463          	bgeu	a0,a1,d7e <memmove+0x2e>
    while(n-- > 0)
     d5a:	00c05f63          	blez	a2,d78 <memmove+0x28>
     d5e:	1602                	sll	a2,a2,0x20
     d60:	9201                	srl	a2,a2,0x20
     d62:	00c507b3          	add	a5,a0,a2
  dst = vdst;
     d66:	872a                	mv	a4,a0
      *dst++ = *src++;
     d68:	0585                	add	a1,a1,1
     d6a:	0705                	add	a4,a4,1
     d6c:	fff5c683          	lbu	a3,-1(a1)
     d70:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
     d74:	fef71ae3          	bne	a4,a5,d68 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
     d78:	6422                	ld	s0,8(sp)
     d7a:	0141                	add	sp,sp,16
     d7c:	8082                	ret
    dst += n;
     d7e:	00c50733          	add	a4,a0,a2
    src += n;
     d82:	95b2                	add	a1,a1,a2
    while(n-- > 0)
     d84:	fec05ae3          	blez	a2,d78 <memmove+0x28>
     d88:	fff6079b          	addw	a5,a2,-1
     d8c:	1782                	sll	a5,a5,0x20
     d8e:	9381                	srl	a5,a5,0x20
     d90:	fff7c793          	not	a5,a5
     d94:	97ba                	add	a5,a5,a4
      *--dst = *--src;
     d96:	15fd                	add	a1,a1,-1
     d98:	177d                	add	a4,a4,-1
     d9a:	0005c683          	lbu	a3,0(a1)
     d9e:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
     da2:	fee79ae3          	bne	a5,a4,d96 <memmove+0x46>
     da6:	bfc9                	j	d78 <memmove+0x28>

0000000000000da8 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
     da8:	1141                	add	sp,sp,-16
     daa:	e422                	sd	s0,8(sp)
     dac:	0800                	add	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
     dae:	ca05                	beqz	a2,dde <memcmp+0x36>
     db0:	fff6069b          	addw	a3,a2,-1
     db4:	1682                	sll	a3,a3,0x20
     db6:	9281                	srl	a3,a3,0x20
     db8:	0685                	add	a3,a3,1
     dba:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
     dbc:	00054783          	lbu	a5,0(a0)
     dc0:	0005c703          	lbu	a4,0(a1)
     dc4:	00e79863          	bne	a5,a4,dd4 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
     dc8:	0505                	add	a0,a0,1
    p2++;
     dca:	0585                	add	a1,a1,1
  while (n-- > 0) {
     dcc:	fed518e3          	bne	a0,a3,dbc <memcmp+0x14>
  }
  return 0;
     dd0:	4501                	li	a0,0
     dd2:	a019                	j	dd8 <memcmp+0x30>
      return *p1 - *p2;
     dd4:	40e7853b          	subw	a0,a5,a4
}
     dd8:	6422                	ld	s0,8(sp)
     dda:	0141                	add	sp,sp,16
     ddc:	8082                	ret
  return 0;
     dde:	4501                	li	a0,0
     de0:	bfe5                	j	dd8 <memcmp+0x30>

0000000000000de2 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
     de2:	1141                	add	sp,sp,-16
     de4:	e406                	sd	ra,8(sp)
     de6:	e022                	sd	s0,0(sp)
     de8:	0800                	add	s0,sp,16
  return memmove(dst, src, n);
     dea:	00000097          	auipc	ra,0x0
     dee:	f66080e7          	jalr	-154(ra) # d50 <memmove>
}
     df2:	60a2                	ld	ra,8(sp)
     df4:	6402                	ld	s0,0(sp)
     df6:	0141                	add	sp,sp,16
     df8:	8082                	ret

0000000000000dfa <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
     dfa:	4885                	li	a7,1
 ecall
     dfc:	00000073          	ecall
 ret
     e00:	8082                	ret

0000000000000e02 <exit>:
.global exit
exit:
 li a7, SYS_exit
     e02:	4889                	li	a7,2
 ecall
     e04:	00000073          	ecall
 ret
     e08:	8082                	ret

0000000000000e0a <wait>:
.global wait
wait:
 li a7, SYS_wait
     e0a:	488d                	li	a7,3
 ecall
     e0c:	00000073          	ecall
 ret
     e10:	8082                	ret

0000000000000e12 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
     e12:	4891                	li	a7,4
 ecall
     e14:	00000073          	ecall
 ret
     e18:	8082                	ret

0000000000000e1a <read>:
.global read
read:
 li a7, SYS_read
     e1a:	4895                	li	a7,5
 ecall
     e1c:	00000073          	ecall
 ret
     e20:	8082                	ret

0000000000000e22 <write>:
.global write
write:
 li a7, SYS_write
     e22:	48c1                	li	a7,16
 ecall
     e24:	00000073          	ecall
 ret
     e28:	8082                	ret

0000000000000e2a <close>:
.global close
close:
 li a7, SYS_close
     e2a:	48d5                	li	a7,21
 ecall
     e2c:	00000073          	ecall
 ret
     e30:	8082                	ret

0000000000000e32 <kill>:
.global kill
kill:
 li a7, SYS_kill
     e32:	4899                	li	a7,6
 ecall
     e34:	00000073          	ecall
 ret
     e38:	8082                	ret

0000000000000e3a <exec>:
.global exec
exec:
 li a7, SYS_exec
     e3a:	489d                	li	a7,7
 ecall
     e3c:	00000073          	ecall
 ret
     e40:	8082                	ret

0000000000000e42 <open>:
.global open
open:
 li a7, SYS_open
     e42:	48bd                	li	a7,15
 ecall
     e44:	00000073          	ecall
 ret
     e48:	8082                	ret

0000000000000e4a <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
     e4a:	48c5                	li	a7,17
 ecall
     e4c:	00000073          	ecall
 ret
     e50:	8082                	ret

0000000000000e52 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
     e52:	48c9                	li	a7,18
 ecall
     e54:	00000073          	ecall
 ret
     e58:	8082                	ret

0000000000000e5a <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
     e5a:	48a1                	li	a7,8
 ecall
     e5c:	00000073          	ecall
 ret
     e60:	8082                	ret

0000000000000e62 <link>:
.global link
link:
 li a7, SYS_link
     e62:	48cd                	li	a7,19
 ecall
     e64:	00000073          	ecall
 ret
     e68:	8082                	ret

0000000000000e6a <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
     e6a:	48d1                	li	a7,20
 ecall
     e6c:	00000073          	ecall
 ret
     e70:	8082                	ret

0000000000000e72 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
     e72:	48a5                	li	a7,9
 ecall
     e74:	00000073          	ecall
 ret
     e78:	8082                	ret

0000000000000e7a <dup>:
.global dup
dup:
 li a7, SYS_dup
     e7a:	48a9                	li	a7,10
 ecall
     e7c:	00000073          	ecall
 ret
     e80:	8082                	ret

0000000000000e82 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
     e82:	48ad                	li	a7,11
 ecall
     e84:	00000073          	ecall
 ret
     e88:	8082                	ret

0000000000000e8a <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
     e8a:	48b1                	li	a7,12
 ecall
     e8c:	00000073          	ecall
 ret
     e90:	8082                	ret

0000000000000e92 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
     e92:	48b5                	li	a7,13
 ecall
     e94:	00000073          	ecall
 ret
     e98:	8082                	ret

0000000000000e9a <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
     e9a:	48b9                	li	a7,14
 ecall
     e9c:	00000073          	ecall
 ret
     ea0:	8082                	ret

0000000000000ea2 <uconnect>:
.global uconnect
uconnect:
 li a7, SYS_uconnect
     ea2:	48f5                	li	a7,29
 ecall
     ea4:	00000073          	ecall
 ret
     ea8:	8082                	ret

0000000000000eaa <socket>:
.global socket
socket:
 li a7, SYS_socket
     eaa:	48f9                	li	a7,30
 ecall
     eac:	00000073          	ecall
 ret
     eb0:	8082                	ret

0000000000000eb2 <bind>:
.global bind
bind:
 li a7, SYS_bind
     eb2:	48fd                	li	a7,31
 ecall
     eb4:	00000073          	ecall
 ret
     eb8:	8082                	ret

0000000000000eba <listen>:
.global listen
listen:
 li a7, SYS_listen
     eba:	02000893          	li	a7,32
 ecall
     ebe:	00000073          	ecall
 ret
     ec2:	8082                	ret

0000000000000ec4 <accept>:
.global accept
accept:
 li a7, SYS_accept
     ec4:	02100893          	li	a7,33
 ecall
     ec8:	00000073          	ecall
 ret
     ecc:	8082                	ret

0000000000000ece <connect>:
.global connect
connect:
 li a7, SYS_connect
     ece:	02200893          	li	a7,34
 ecall
     ed2:	00000073          	ecall
 ret
     ed6:	8082                	ret

0000000000000ed8 <sprintint>:
  return 1;
}

static int
sprintint(char *s, int xx, int base, int sign)
{
     ed8:	1101                	add	sp,sp,-32
     eda:	ec22                	sd	s0,24(sp)
     edc:	1000                	add	s0,sp,32
     ede:	882a                	mv	a6,a0
  char buf[16];
  int i, n;
  uint x;

  if(sign && (sign = xx < 0))
     ee0:	c299                	beqz	a3,ee6 <sprintint+0xe>
     ee2:	0805c263          	bltz	a1,f66 <sprintint+0x8e>
    x = -xx;
  else
    x = xx;
     ee6:	2581                	sext.w	a1,a1
     ee8:	4301                	li	t1,0

  i = 0;
     eea:	fe040713          	add	a4,s0,-32
     eee:	4501                	li	a0,0
  do {
    buf[i++] = digits[x % base];
     ef0:	2601                	sext.w	a2,a2
     ef2:	00001697          	auipc	a3,0x1
     ef6:	86e68693          	add	a3,a3,-1938 # 1760 <digits>
     efa:	88aa                	mv	a7,a0
     efc:	2505                	addw	a0,a0,1
     efe:	02c5f7bb          	remuw	a5,a1,a2
     f02:	1782                	sll	a5,a5,0x20
     f04:	9381                	srl	a5,a5,0x20
     f06:	97b6                	add	a5,a5,a3
     f08:	0007c783          	lbu	a5,0(a5)
     f0c:	00f70023          	sb	a5,0(a4)
  } while((x /= base) != 0);
     f10:	0005879b          	sext.w	a5,a1
     f14:	02c5d5bb          	divuw	a1,a1,a2
     f18:	0705                	add	a4,a4,1
     f1a:	fec7f0e3          	bgeu	a5,a2,efa <sprintint+0x22>

  if(sign)
     f1e:	00030b63          	beqz	t1,f34 <sprintint+0x5c>
    buf[i++] = '-';
     f22:	ff050793          	add	a5,a0,-16
     f26:	97a2                	add	a5,a5,s0
     f28:	02d00713          	li	a4,45
     f2c:	fee78823          	sb	a4,-16(a5)
     f30:	0028851b          	addw	a0,a7,2

  n = 0;
  while(--i >= 0)
     f34:	02a05d63          	blez	a0,f6e <sprintint+0x96>
     f38:	fe040793          	add	a5,s0,-32
     f3c:	00a78733          	add	a4,a5,a0
     f40:	87c2                	mv	a5,a6
     f42:	00180613          	add	a2,a6,1
     f46:	fff5069b          	addw	a3,a0,-1
     f4a:	1682                	sll	a3,a3,0x20
     f4c:	9281                	srl	a3,a3,0x20
     f4e:	9636                	add	a2,a2,a3
  *s = c;
     f50:	fff74683          	lbu	a3,-1(a4)
     f54:	00d78023          	sb	a3,0(a5)
  while(--i >= 0)
     f58:	177d                	add	a4,a4,-1
     f5a:	0785                	add	a5,a5,1
     f5c:	fec79ae3          	bne	a5,a2,f50 <sprintint+0x78>
    n += sputc(s+n, buf[i]);
  return n;
}
     f60:	6462                	ld	s0,24(sp)
     f62:	6105                	add	sp,sp,32
     f64:	8082                	ret
    x = -xx;
     f66:	40b005bb          	negw	a1,a1
  if(sign && (sign = xx < 0))
     f6a:	4305                	li	t1,1
    x = -xx;
     f6c:	bfbd                	j	eea <sprintint+0x12>
  while(--i >= 0)
     f6e:	4501                	li	a0,0
     f70:	bfc5                	j	f60 <sprintint+0x88>

0000000000000f72 <putc>:
{
     f72:	1101                	add	sp,sp,-32
     f74:	ec06                	sd	ra,24(sp)
     f76:	e822                	sd	s0,16(sp)
     f78:	1000                	add	s0,sp,32
     f7a:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
     f7e:	4605                	li	a2,1
     f80:	fef40593          	add	a1,s0,-17
     f84:	00000097          	auipc	ra,0x0
     f88:	e9e080e7          	jalr	-354(ra) # e22 <write>
}
     f8c:	60e2                	ld	ra,24(sp)
     f8e:	6442                	ld	s0,16(sp)
     f90:	6105                	add	sp,sp,32
     f92:	8082                	ret

0000000000000f94 <printint>:
{
     f94:	7139                	add	sp,sp,-64
     f96:	fc06                	sd	ra,56(sp)
     f98:	f822                	sd	s0,48(sp)
     f9a:	f426                	sd	s1,40(sp)
     f9c:	0080                	add	s0,sp,64
     f9e:	84aa                	mv	s1,a0
  if(sgn && xx < 0){
     fa0:	c299                	beqz	a3,fa6 <printint+0x12>
     fa2:	0805cb63          	bltz	a1,1038 <printint+0xa4>
    x = xx;
     fa6:	2581                	sext.w	a1,a1
  neg = 0;
     fa8:	4881                	li	a7,0
     faa:	fc040693          	add	a3,s0,-64
  i = 0;
     fae:	4701                	li	a4,0
    buf[i++] = digits[x % base];
     fb0:	2601                	sext.w	a2,a2
     fb2:	00000517          	auipc	a0,0x0
     fb6:	7ae50513          	add	a0,a0,1966 # 1760 <digits>
     fba:	883a                	mv	a6,a4
     fbc:	2705                	addw	a4,a4,1
     fbe:	02c5f7bb          	remuw	a5,a1,a2
     fc2:	1782                	sll	a5,a5,0x20
     fc4:	9381                	srl	a5,a5,0x20
     fc6:	97aa                	add	a5,a5,a0
     fc8:	0007c783          	lbu	a5,0(a5)
     fcc:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
     fd0:	0005879b          	sext.w	a5,a1
     fd4:	02c5d5bb          	divuw	a1,a1,a2
     fd8:	0685                	add	a3,a3,1
     fda:	fec7f0e3          	bgeu	a5,a2,fba <printint+0x26>
  if(neg)
     fde:	00088c63          	beqz	a7,ff6 <printint+0x62>
    buf[i++] = '-';
     fe2:	fd070793          	add	a5,a4,-48
     fe6:	00878733          	add	a4,a5,s0
     fea:	02d00793          	li	a5,45
     fee:	fef70823          	sb	a5,-16(a4)
     ff2:	0028071b          	addw	a4,a6,2
  while(--i >= 0)
     ff6:	02e05c63          	blez	a4,102e <printint+0x9a>
     ffa:	f04a                	sd	s2,32(sp)
     ffc:	ec4e                	sd	s3,24(sp)
     ffe:	fc040793          	add	a5,s0,-64
    1002:	00e78933          	add	s2,a5,a4
    1006:	fff78993          	add	s3,a5,-1
    100a:	99ba                	add	s3,s3,a4
    100c:	377d                	addw	a4,a4,-1
    100e:	1702                	sll	a4,a4,0x20
    1010:	9301                	srl	a4,a4,0x20
    1012:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
    1016:	fff94583          	lbu	a1,-1(s2)
    101a:	8526                	mv	a0,s1
    101c:	00000097          	auipc	ra,0x0
    1020:	f56080e7          	jalr	-170(ra) # f72 <putc>
  while(--i >= 0)
    1024:	197d                	add	s2,s2,-1
    1026:	ff3918e3          	bne	s2,s3,1016 <printint+0x82>
    102a:	7902                	ld	s2,32(sp)
    102c:	69e2                	ld	s3,24(sp)
}
    102e:	70e2                	ld	ra,56(sp)
    1030:	7442                	ld	s0,48(sp)
    1032:	74a2                	ld	s1,40(sp)
    1034:	6121                	add	sp,sp,64
    1036:	8082                	ret
    x = -xx;
    1038:	40b005bb          	negw	a1,a1
    neg = 1;
    103c:	4885                	li	a7,1
    x = -xx;
    103e:	b7b5                	j	faa <printint+0x16>

0000000000001040 <vprintf>:
{
    1040:	715d                	add	sp,sp,-80
    1042:	e486                	sd	ra,72(sp)
    1044:	e0a2                	sd	s0,64(sp)
    1046:	f84a                	sd	s2,48(sp)
    1048:	0880                	add	s0,sp,80
  for(i = 0; fmt[i]; i++){
    104a:	0005c903          	lbu	s2,0(a1)
    104e:	1a090a63          	beqz	s2,1202 <vprintf+0x1c2>
    1052:	fc26                	sd	s1,56(sp)
    1054:	f44e                	sd	s3,40(sp)
    1056:	f052                	sd	s4,32(sp)
    1058:	ec56                	sd	s5,24(sp)
    105a:	e85a                	sd	s6,16(sp)
    105c:	e45e                	sd	s7,8(sp)
    105e:	8aaa                	mv	s5,a0
    1060:	8bb2                	mv	s7,a2
    1062:	00158493          	add	s1,a1,1
  state = 0;
    1066:	4981                	li	s3,0
    } else if(state == '%'){
    1068:	02500a13          	li	s4,37
    106c:	4b55                	li	s6,21
    106e:	a839                	j	108c <vprintf+0x4c>
        putc(fd, c);
    1070:	85ca                	mv	a1,s2
    1072:	8556                	mv	a0,s5
    1074:	00000097          	auipc	ra,0x0
    1078:	efe080e7          	jalr	-258(ra) # f72 <putc>
    107c:	a019                	j	1082 <vprintf+0x42>
    } else if(state == '%'){
    107e:	01498d63          	beq	s3,s4,1098 <vprintf+0x58>
  for(i = 0; fmt[i]; i++){
    1082:	0485                	add	s1,s1,1
    1084:	fff4c903          	lbu	s2,-1(s1)
    1088:	16090763          	beqz	s2,11f6 <vprintf+0x1b6>
    if(state == 0){
    108c:	fe0999e3          	bnez	s3,107e <vprintf+0x3e>
      if(c == '%'){
    1090:	ff4910e3          	bne	s2,s4,1070 <vprintf+0x30>
        state = '%';
    1094:	89d2                	mv	s3,s4
    1096:	b7f5                	j	1082 <vprintf+0x42>
      if(c == 'd'){
    1098:	13490463          	beq	s2,s4,11c0 <vprintf+0x180>
    109c:	f9d9079b          	addw	a5,s2,-99
    10a0:	0ff7f793          	zext.b	a5,a5
    10a4:	12fb6763          	bltu	s6,a5,11d2 <vprintf+0x192>
    10a8:	f9d9079b          	addw	a5,s2,-99
    10ac:	0ff7f713          	zext.b	a4,a5
    10b0:	12eb6163          	bltu	s6,a4,11d2 <vprintf+0x192>
    10b4:	00271793          	sll	a5,a4,0x2
    10b8:	00000717          	auipc	a4,0x0
    10bc:	65070713          	add	a4,a4,1616 # 1708 <malloc+0x24e>
    10c0:	97ba                	add	a5,a5,a4
    10c2:	439c                	lw	a5,0(a5)
    10c4:	97ba                	add	a5,a5,a4
    10c6:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
    10c8:	008b8913          	add	s2,s7,8
    10cc:	4685                	li	a3,1
    10ce:	4629                	li	a2,10
    10d0:	000ba583          	lw	a1,0(s7)
    10d4:	8556                	mv	a0,s5
    10d6:	00000097          	auipc	ra,0x0
    10da:	ebe080e7          	jalr	-322(ra) # f94 <printint>
    10de:	8bca                	mv	s7,s2
      state = 0;
    10e0:	4981                	li	s3,0
    10e2:	b745                	j	1082 <vprintf+0x42>
        printint(fd, va_arg(ap, uint64), 10, 0);
    10e4:	008b8913          	add	s2,s7,8
    10e8:	4681                	li	a3,0
    10ea:	4629                	li	a2,10
    10ec:	000ba583          	lw	a1,0(s7)
    10f0:	8556                	mv	a0,s5
    10f2:	00000097          	auipc	ra,0x0
    10f6:	ea2080e7          	jalr	-350(ra) # f94 <printint>
    10fa:	8bca                	mv	s7,s2
      state = 0;
    10fc:	4981                	li	s3,0
    10fe:	b751                	j	1082 <vprintf+0x42>
        printint(fd, va_arg(ap, int), 16, 0);
    1100:	008b8913          	add	s2,s7,8
    1104:	4681                	li	a3,0
    1106:	4641                	li	a2,16
    1108:	000ba583          	lw	a1,0(s7)
    110c:	8556                	mv	a0,s5
    110e:	00000097          	auipc	ra,0x0
    1112:	e86080e7          	jalr	-378(ra) # f94 <printint>
    1116:	8bca                	mv	s7,s2
      state = 0;
    1118:	4981                	li	s3,0
    111a:	b7a5                	j	1082 <vprintf+0x42>
    111c:	e062                	sd	s8,0(sp)
        printptr(fd, va_arg(ap, uint64));
    111e:	008b8c13          	add	s8,s7,8
    1122:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
    1126:	03000593          	li	a1,48
    112a:	8556                	mv	a0,s5
    112c:	00000097          	auipc	ra,0x0
    1130:	e46080e7          	jalr	-442(ra) # f72 <putc>
  putc(fd, 'x');
    1134:	07800593          	li	a1,120
    1138:	8556                	mv	a0,s5
    113a:	00000097          	auipc	ra,0x0
    113e:	e38080e7          	jalr	-456(ra) # f72 <putc>
    1142:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
    1144:	00000b97          	auipc	s7,0x0
    1148:	61cb8b93          	add	s7,s7,1564 # 1760 <digits>
    114c:	03c9d793          	srl	a5,s3,0x3c
    1150:	97de                	add	a5,a5,s7
    1152:	0007c583          	lbu	a1,0(a5)
    1156:	8556                	mv	a0,s5
    1158:	00000097          	auipc	ra,0x0
    115c:	e1a080e7          	jalr	-486(ra) # f72 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    1160:	0992                	sll	s3,s3,0x4
    1162:	397d                	addw	s2,s2,-1
    1164:	fe0914e3          	bnez	s2,114c <vprintf+0x10c>
        printptr(fd, va_arg(ap, uint64));
    1168:	8be2                	mv	s7,s8
      state = 0;
    116a:	4981                	li	s3,0
    116c:	6c02                	ld	s8,0(sp)
    116e:	bf11                	j	1082 <vprintf+0x42>
        s = va_arg(ap, char*);
    1170:	008b8993          	add	s3,s7,8
    1174:	000bb903          	ld	s2,0(s7)
        if(s == 0)
    1178:	02090163          	beqz	s2,119a <vprintf+0x15a>
        while(*s != 0){
    117c:	00094583          	lbu	a1,0(s2)
    1180:	c9a5                	beqz	a1,11f0 <vprintf+0x1b0>
          putc(fd, *s);
    1182:	8556                	mv	a0,s5
    1184:	00000097          	auipc	ra,0x0
    1188:	dee080e7          	jalr	-530(ra) # f72 <putc>
          s++;
    118c:	0905                	add	s2,s2,1
        while(*s != 0){
    118e:	00094583          	lbu	a1,0(s2)
    1192:	f9e5                	bnez	a1,1182 <vprintf+0x142>
        s = va_arg(ap, char*);
    1194:	8bce                	mv	s7,s3
      state = 0;
    1196:	4981                	li	s3,0
    1198:	b5ed                	j	1082 <vprintf+0x42>
          s = "(null)";
    119a:	00000917          	auipc	s2,0x0
    119e:	53690913          	add	s2,s2,1334 # 16d0 <malloc+0x216>
        while(*s != 0){
    11a2:	02800593          	li	a1,40
    11a6:	bff1                	j	1182 <vprintf+0x142>
        putc(fd, va_arg(ap, uint));
    11a8:	008b8913          	add	s2,s7,8
    11ac:	000bc583          	lbu	a1,0(s7)
    11b0:	8556                	mv	a0,s5
    11b2:	00000097          	auipc	ra,0x0
    11b6:	dc0080e7          	jalr	-576(ra) # f72 <putc>
    11ba:	8bca                	mv	s7,s2
      state = 0;
    11bc:	4981                	li	s3,0
    11be:	b5d1                	j	1082 <vprintf+0x42>
        putc(fd, c);
    11c0:	02500593          	li	a1,37
    11c4:	8556                	mv	a0,s5
    11c6:	00000097          	auipc	ra,0x0
    11ca:	dac080e7          	jalr	-596(ra) # f72 <putc>
      state = 0;
    11ce:	4981                	li	s3,0
    11d0:	bd4d                	j	1082 <vprintf+0x42>
        putc(fd, '%');
    11d2:	02500593          	li	a1,37
    11d6:	8556                	mv	a0,s5
    11d8:	00000097          	auipc	ra,0x0
    11dc:	d9a080e7          	jalr	-614(ra) # f72 <putc>
        putc(fd, c);
    11e0:	85ca                	mv	a1,s2
    11e2:	8556                	mv	a0,s5
    11e4:	00000097          	auipc	ra,0x0
    11e8:	d8e080e7          	jalr	-626(ra) # f72 <putc>
      state = 0;
    11ec:	4981                	li	s3,0
    11ee:	bd51                	j	1082 <vprintf+0x42>
        s = va_arg(ap, char*);
    11f0:	8bce                	mv	s7,s3
      state = 0;
    11f2:	4981                	li	s3,0
    11f4:	b579                	j	1082 <vprintf+0x42>
    11f6:	74e2                	ld	s1,56(sp)
    11f8:	79a2                	ld	s3,40(sp)
    11fa:	7a02                	ld	s4,32(sp)
    11fc:	6ae2                	ld	s5,24(sp)
    11fe:	6b42                	ld	s6,16(sp)
    1200:	6ba2                	ld	s7,8(sp)
}
    1202:	60a6                	ld	ra,72(sp)
    1204:	6406                	ld	s0,64(sp)
    1206:	7942                	ld	s2,48(sp)
    1208:	6161                	add	sp,sp,80
    120a:	8082                	ret

000000000000120c <fprintf>:
{
    120c:	715d                	add	sp,sp,-80
    120e:	ec06                	sd	ra,24(sp)
    1210:	e822                	sd	s0,16(sp)
    1212:	1000                	add	s0,sp,32
    1214:	e010                	sd	a2,0(s0)
    1216:	e414                	sd	a3,8(s0)
    1218:	e818                	sd	a4,16(s0)
    121a:	ec1c                	sd	a5,24(s0)
    121c:	03043023          	sd	a6,32(s0)
    1220:	03143423          	sd	a7,40(s0)
  va_start(ap, fmt);
    1224:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
    1228:	8622                	mv	a2,s0
    122a:	00000097          	auipc	ra,0x0
    122e:	e16080e7          	jalr	-490(ra) # 1040 <vprintf>
}
    1232:	60e2                	ld	ra,24(sp)
    1234:	6442                	ld	s0,16(sp)
    1236:	6161                	add	sp,sp,80
    1238:	8082                	ret

000000000000123a <printf>:
{
    123a:	711d                	add	sp,sp,-96
    123c:	ec06                	sd	ra,24(sp)
    123e:	e822                	sd	s0,16(sp)
    1240:	1000                	add	s0,sp,32
    1242:	e40c                	sd	a1,8(s0)
    1244:	e810                	sd	a2,16(s0)
    1246:	ec14                	sd	a3,24(s0)
    1248:	f018                	sd	a4,32(s0)
    124a:	f41c                	sd	a5,40(s0)
    124c:	03043823          	sd	a6,48(s0)
    1250:	03143c23          	sd	a7,56(s0)
  va_start(ap, fmt);
    1254:	00840613          	add	a2,s0,8
    1258:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
    125c:	85aa                	mv	a1,a0
    125e:	4505                	li	a0,1
    1260:	00000097          	auipc	ra,0x0
    1264:	de0080e7          	jalr	-544(ra) # 1040 <vprintf>
}
    1268:	60e2                	ld	ra,24(sp)
    126a:	6442                	ld	s0,16(sp)
    126c:	6125                	add	sp,sp,96
    126e:	8082                	ret

0000000000001270 <snprintf>:

int
snprintf(char *buf, int sz, char *fmt, ...)
{
    1270:	7135                	add	sp,sp,-160
    1272:	f486                	sd	ra,104(sp)
    1274:	f0a2                	sd	s0,96(sp)
    1276:	eca6                	sd	s1,88(sp)
    1278:	1880                	add	s0,sp,112
    127a:	e414                	sd	a3,8(s0)
    127c:	e818                	sd	a4,16(s0)
    127e:	ec1c                	sd	a5,24(s0)
    1280:	03043023          	sd	a6,32(s0)
    1284:	03143423          	sd	a7,40(s0)
  va_list ap;
  int i, c;
  int off = 0;
  char *s;

  if (fmt == 0)
    1288:	16060b63          	beqz	a2,13fe <snprintf+0x18e>
    128c:	e8ca                	sd	s2,80(sp)
    128e:	e4ce                	sd	s3,72(sp)
    1290:	fc56                	sd	s5,56(sp)
    1292:	f85a                	sd	s6,48(sp)
    1294:	8b2a                	mv	s6,a0
    1296:	8aae                	mv	s5,a1
    1298:	89b2                	mv	s3,a2
    return -1;

  va_start(ap, fmt);
    129a:	00840793          	add	a5,s0,8
    129e:	f8f43c23          	sd	a5,-104(s0)
  int off = 0;
    12a2:	4481                	li	s1,0
  for(i = 0; off < sz && (c = fmt[i] & 0xff) != 0; i++){
    12a4:	4901                	li	s2,0
    12a6:	00b05f63          	blez	a1,12c4 <snprintf+0x54>
    12aa:	e0d2                	sd	s4,64(sp)
    12ac:	f45e                	sd	s7,40(sp)
    12ae:	f062                	sd	s8,32(sp)
    12b0:	ec66                	sd	s9,24(sp)
    if(c != '%'){
    12b2:	02500a13          	li	s4,37
      continue;
    }
    c = fmt[++i] & 0xff;
    if(c == 0)
      break;
    switch(c){
    12b6:	07300b93          	li	s7,115
    12ba:	07800c93          	li	s9,120
    12be:	06400c13          	li	s8,100
    12c2:	a839                	j	12e0 <snprintf+0x70>
      off += sputc(buf+off, '%');
      off += sputc(buf+off, c);
      break;
    }
  }
  return off;
    12c4:	4481                	li	s1,0
    12c6:	6946                	ld	s2,80(sp)
    12c8:	69a6                	ld	s3,72(sp)
    12ca:	7ae2                	ld	s5,56(sp)
    12cc:	7b42                	ld	s6,48(sp)
    12ce:	a0cd                	j	13b0 <snprintf+0x140>
  *s = c;
    12d0:	009b0733          	add	a4,s6,s1
    12d4:	00f70023          	sb	a5,0(a4)
      off += sputc(buf+off, c);
    12d8:	2485                	addw	s1,s1,1
  for(i = 0; off < sz && (c = fmt[i] & 0xff) != 0; i++){
    12da:	2905                	addw	s2,s2,1
    12dc:	1554d563          	bge	s1,s5,1426 <snprintf+0x1b6>
    12e0:	012987b3          	add	a5,s3,s2
    12e4:	0007c783          	lbu	a5,0(a5)
    12e8:	0007871b          	sext.w	a4,a5
    12ec:	10078063          	beqz	a5,13ec <snprintf+0x17c>
    if(c != '%'){
    12f0:	ff4710e3          	bne	a4,s4,12d0 <snprintf+0x60>
    c = fmt[++i] & 0xff;
    12f4:	2905                	addw	s2,s2,1
    12f6:	012987b3          	add	a5,s3,s2
    12fa:	0007c783          	lbu	a5,0(a5)
    if(c == 0)
    12fe:	10078263          	beqz	a5,1402 <snprintf+0x192>
    switch(c){
    1302:	05778c63          	beq	a5,s7,135a <snprintf+0xea>
    1306:	02fbe763          	bltu	s7,a5,1334 <snprintf+0xc4>
    130a:	0d478063          	beq	a5,s4,13ca <snprintf+0x15a>
    130e:	0d879463          	bne	a5,s8,13d6 <snprintf+0x166>
      off += sprintint(buf+off, va_arg(ap, int), 10, 1);
    1312:	f9843783          	ld	a5,-104(s0)
    1316:	00878713          	add	a4,a5,8
    131a:	f8e43c23          	sd	a4,-104(s0)
    131e:	4685                	li	a3,1
    1320:	4629                	li	a2,10
    1322:	438c                	lw	a1,0(a5)
    1324:	009b0533          	add	a0,s6,s1
    1328:	00000097          	auipc	ra,0x0
    132c:	bb0080e7          	jalr	-1104(ra) # ed8 <sprintint>
    1330:	9ca9                	addw	s1,s1,a0
      break;
    1332:	b765                	j	12da <snprintf+0x6a>
    switch(c){
    1334:	0b979163          	bne	a5,s9,13d6 <snprintf+0x166>
      off += sprintint(buf+off, va_arg(ap, int), 16, 1);
    1338:	f9843783          	ld	a5,-104(s0)
    133c:	00878713          	add	a4,a5,8
    1340:	f8e43c23          	sd	a4,-104(s0)
    1344:	4685                	li	a3,1
    1346:	4641                	li	a2,16
    1348:	438c                	lw	a1,0(a5)
    134a:	009b0533          	add	a0,s6,s1
    134e:	00000097          	auipc	ra,0x0
    1352:	b8a080e7          	jalr	-1142(ra) # ed8 <sprintint>
    1356:	9ca9                	addw	s1,s1,a0
      break;
    1358:	b749                	j	12da <snprintf+0x6a>
      if((s = va_arg(ap, char*)) == 0)
    135a:	f9843783          	ld	a5,-104(s0)
    135e:	00878713          	add	a4,a5,8
    1362:	f8e43c23          	sd	a4,-104(s0)
    1366:	6388                	ld	a0,0(a5)
    1368:	c931                	beqz	a0,13bc <snprintf+0x14c>
      for(; *s && off < sz; s++)
    136a:	00054703          	lbu	a4,0(a0)
    136e:	d735                	beqz	a4,12da <snprintf+0x6a>
    1370:	0b54d263          	bge	s1,s5,1414 <snprintf+0x1a4>
    1374:	009b06b3          	add	a3,s6,s1
    1378:	409a863b          	subw	a2,s5,s1
    137c:	1602                	sll	a2,a2,0x20
    137e:	9201                	srl	a2,a2,0x20
    1380:	962a                	add	a2,a2,a0
    1382:	87aa                	mv	a5,a0
        off += sputc(buf+off, *s);
    1384:	0014859b          	addw	a1,s1,1
    1388:	9d89                	subw	a1,a1,a0
  *s = c;
    138a:	00e68023          	sb	a4,0(a3)
        off += sputc(buf+off, *s);
    138e:	00f584bb          	addw	s1,a1,a5
      for(; *s && off < sz; s++)
    1392:	0785                	add	a5,a5,1
    1394:	0007c703          	lbu	a4,0(a5)
    1398:	d329                	beqz	a4,12da <snprintf+0x6a>
    139a:	0685                	add	a3,a3,1
    139c:	fec797e3          	bne	a5,a2,138a <snprintf+0x11a>
    13a0:	6946                	ld	s2,80(sp)
    13a2:	69a6                	ld	s3,72(sp)
    13a4:	6a06                	ld	s4,64(sp)
    13a6:	7ae2                	ld	s5,56(sp)
    13a8:	7b42                	ld	s6,48(sp)
    13aa:	7ba2                	ld	s7,40(sp)
    13ac:	7c02                	ld	s8,32(sp)
    13ae:	6ce2                	ld	s9,24(sp)
    13b0:	8526                	mv	a0,s1
    13b2:	70a6                	ld	ra,104(sp)
    13b4:	7406                	ld	s0,96(sp)
    13b6:	64e6                	ld	s1,88(sp)
    13b8:	610d                	add	sp,sp,160
    13ba:	8082                	ret
      for(; *s && off < sz; s++)
    13bc:	02800713          	li	a4,40
        s = "(null)";
    13c0:	00000517          	auipc	a0,0x0
    13c4:	31050513          	add	a0,a0,784 # 16d0 <malloc+0x216>
    13c8:	b765                	j	1370 <snprintf+0x100>
  *s = c;
    13ca:	009b07b3          	add	a5,s6,s1
    13ce:	01478023          	sb	s4,0(a5)
      off += sputc(buf+off, '%');
    13d2:	2485                	addw	s1,s1,1
      break;
    13d4:	b719                	j	12da <snprintf+0x6a>
  *s = c;
    13d6:	009b0733          	add	a4,s6,s1
    13da:	01470023          	sb	s4,0(a4)
      off += sputc(buf+off, c);
    13de:	0014871b          	addw	a4,s1,1
  *s = c;
    13e2:	975a                	add	a4,a4,s6
    13e4:	00f70023          	sb	a5,0(a4)
      off += sputc(buf+off, c);
    13e8:	2489                	addw	s1,s1,2
      break;
    13ea:	bdc5                	j	12da <snprintf+0x6a>
    13ec:	6946                	ld	s2,80(sp)
    13ee:	69a6                	ld	s3,72(sp)
    13f0:	6a06                	ld	s4,64(sp)
    13f2:	7ae2                	ld	s5,56(sp)
    13f4:	7b42                	ld	s6,48(sp)
    13f6:	7ba2                	ld	s7,40(sp)
    13f8:	7c02                	ld	s8,32(sp)
    13fa:	6ce2                	ld	s9,24(sp)
    13fc:	bf55                	j	13b0 <snprintf+0x140>
    return -1;
    13fe:	54fd                	li	s1,-1
    1400:	bf45                	j	13b0 <snprintf+0x140>
    1402:	6946                	ld	s2,80(sp)
    1404:	69a6                	ld	s3,72(sp)
    1406:	6a06                	ld	s4,64(sp)
    1408:	7ae2                	ld	s5,56(sp)
    140a:	7b42                	ld	s6,48(sp)
    140c:	7ba2                	ld	s7,40(sp)
    140e:	7c02                	ld	s8,32(sp)
    1410:	6ce2                	ld	s9,24(sp)
    1412:	bf79                	j	13b0 <snprintf+0x140>
    1414:	6946                	ld	s2,80(sp)
    1416:	69a6                	ld	s3,72(sp)
    1418:	6a06                	ld	s4,64(sp)
    141a:	7ae2                	ld	s5,56(sp)
    141c:	7b42                	ld	s6,48(sp)
    141e:	7ba2                	ld	s7,40(sp)
    1420:	7c02                	ld	s8,32(sp)
    1422:	6ce2                	ld	s9,24(sp)
    1424:	b771                	j	13b0 <snprintf+0x140>
    1426:	6946                	ld	s2,80(sp)
    1428:	69a6                	ld	s3,72(sp)
    142a:	6a06                	ld	s4,64(sp)
    142c:	7ae2                	ld	s5,56(sp)
    142e:	7b42                	ld	s6,48(sp)
    1430:	7ba2                	ld	s7,40(sp)
    1432:	7c02                	ld	s8,32(sp)
    1434:	6ce2                	ld	s9,24(sp)
    1436:	bfad                	j	13b0 <snprintf+0x140>

0000000000001438 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    1438:	1141                	add	sp,sp,-16
    143a:	e422                	sd	s0,8(sp)
    143c:	0800                	add	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
    143e:	ff050693          	add	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1442:	00000797          	auipc	a5,0x0
    1446:	3467b783          	ld	a5,838(a5) # 1788 <freep>
    144a:	a02d                	j	1474 <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
    144c:	4618                	lw	a4,8(a2)
    144e:	9f2d                	addw	a4,a4,a1
    1450:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
    1454:	6398                	ld	a4,0(a5)
    1456:	6310                	ld	a2,0(a4)
    1458:	a83d                	j	1496 <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    145a:	ff852703          	lw	a4,-8(a0)
    145e:	9f31                	addw	a4,a4,a2
    1460:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
    1462:	ff053683          	ld	a3,-16(a0)
    1466:	a091                	j	14aa <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1468:	6398                	ld	a4,0(a5)
    146a:	00e7e463          	bltu	a5,a4,1472 <free+0x3a>
    146e:	00e6ea63          	bltu	a3,a4,1482 <free+0x4a>
{
    1472:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1474:	fed7fae3          	bgeu	a5,a3,1468 <free+0x30>
    1478:	6398                	ld	a4,0(a5)
    147a:	00e6e463          	bltu	a3,a4,1482 <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    147e:	fee7eae3          	bltu	a5,a4,1472 <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
    1482:	ff852583          	lw	a1,-8(a0)
    1486:	6390                	ld	a2,0(a5)
    1488:	02059813          	sll	a6,a1,0x20
    148c:	01c85713          	srl	a4,a6,0x1c
    1490:	9736                	add	a4,a4,a3
    1492:	fae60de3          	beq	a2,a4,144c <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
    1496:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
    149a:	4790                	lw	a2,8(a5)
    149c:	02061593          	sll	a1,a2,0x20
    14a0:	01c5d713          	srl	a4,a1,0x1c
    14a4:	973e                	add	a4,a4,a5
    14a6:	fae68ae3          	beq	a3,a4,145a <free+0x22>
    p->s.ptr = bp->s.ptr;
    14aa:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
    14ac:	00000717          	auipc	a4,0x0
    14b0:	2cf73e23          	sd	a5,732(a4) # 1788 <freep>
}
    14b4:	6422                	ld	s0,8(sp)
    14b6:	0141                	add	sp,sp,16
    14b8:	8082                	ret

00000000000014ba <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    14ba:	7139                	add	sp,sp,-64
    14bc:	fc06                	sd	ra,56(sp)
    14be:	f822                	sd	s0,48(sp)
    14c0:	f426                	sd	s1,40(sp)
    14c2:	ec4e                	sd	s3,24(sp)
    14c4:	0080                	add	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    14c6:	02051493          	sll	s1,a0,0x20
    14ca:	9081                	srl	s1,s1,0x20
    14cc:	04bd                	add	s1,s1,15
    14ce:	8091                	srl	s1,s1,0x4
    14d0:	0014899b          	addw	s3,s1,1
    14d4:	0485                	add	s1,s1,1
  if((prevp = freep) == 0){
    14d6:	00000517          	auipc	a0,0x0
    14da:	2b253503          	ld	a0,690(a0) # 1788 <freep>
    14de:	c915                	beqz	a0,1512 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    14e0:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    14e2:	4798                	lw	a4,8(a5)
    14e4:	08977e63          	bgeu	a4,s1,1580 <malloc+0xc6>
    14e8:	f04a                	sd	s2,32(sp)
    14ea:	e852                	sd	s4,16(sp)
    14ec:	e456                	sd	s5,8(sp)
    14ee:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
    14f0:	8a4e                	mv	s4,s3
    14f2:	0009871b          	sext.w	a4,s3
    14f6:	6685                	lui	a3,0x1
    14f8:	00d77363          	bgeu	a4,a3,14fe <malloc+0x44>
    14fc:	6a05                	lui	s4,0x1
    14fe:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
    1502:	004a1a1b          	sllw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    1506:	00000917          	auipc	s2,0x0
    150a:	28290913          	add	s2,s2,642 # 1788 <freep>
  if(p == (char*)-1)
    150e:	5afd                	li	s5,-1
    1510:	a091                	j	1554 <malloc+0x9a>
    1512:	f04a                	sd	s2,32(sp)
    1514:	e852                	sd	s4,16(sp)
    1516:	e456                	sd	s5,8(sp)
    1518:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
    151a:	00000797          	auipc	a5,0x0
    151e:	2de78793          	add	a5,a5,734 # 17f8 <base>
    1522:	00000717          	auipc	a4,0x0
    1526:	26f73323          	sd	a5,614(a4) # 1788 <freep>
    152a:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
    152c:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
    1530:	b7c1                	j	14f0 <malloc+0x36>
        prevp->s.ptr = p->s.ptr;
    1532:	6398                	ld	a4,0(a5)
    1534:	e118                	sd	a4,0(a0)
    1536:	a08d                	j	1598 <malloc+0xde>
  hp->s.size = nu;
    1538:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
    153c:	0541                	add	a0,a0,16
    153e:	00000097          	auipc	ra,0x0
    1542:	efa080e7          	jalr	-262(ra) # 1438 <free>
  return freep;
    1546:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
    154a:	c13d                	beqz	a0,15b0 <malloc+0xf6>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    154c:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    154e:	4798                	lw	a4,8(a5)
    1550:	02977463          	bgeu	a4,s1,1578 <malloc+0xbe>
    if(p == freep)
    1554:	00093703          	ld	a4,0(s2)
    1558:	853e                	mv	a0,a5
    155a:	fef719e3          	bne	a4,a5,154c <malloc+0x92>
  p = sbrk(nu * sizeof(Header));
    155e:	8552                	mv	a0,s4
    1560:	00000097          	auipc	ra,0x0
    1564:	92a080e7          	jalr	-1750(ra) # e8a <sbrk>
  if(p == (char*)-1)
    1568:	fd5518e3          	bne	a0,s5,1538 <malloc+0x7e>
        return 0;
    156c:	4501                	li	a0,0
    156e:	7902                	ld	s2,32(sp)
    1570:	6a42                	ld	s4,16(sp)
    1572:	6aa2                	ld	s5,8(sp)
    1574:	6b02                	ld	s6,0(sp)
    1576:	a03d                	j	15a4 <malloc+0xea>
    1578:	7902                	ld	s2,32(sp)
    157a:	6a42                	ld	s4,16(sp)
    157c:	6aa2                	ld	s5,8(sp)
    157e:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
    1580:	fae489e3          	beq	s1,a4,1532 <malloc+0x78>
        p->s.size -= nunits;
    1584:	4137073b          	subw	a4,a4,s3
    1588:	c798                	sw	a4,8(a5)
        p += p->s.size;
    158a:	02071693          	sll	a3,a4,0x20
    158e:	01c6d713          	srl	a4,a3,0x1c
    1592:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
    1594:	0137a423          	sw	s3,8(a5)
      freep = prevp;
    1598:	00000717          	auipc	a4,0x0
    159c:	1ea73823          	sd	a0,496(a4) # 1788 <freep>
      return (void*)(p + 1);
    15a0:	01078513          	add	a0,a5,16
  }
}
    15a4:	70e2                	ld	ra,56(sp)
    15a6:	7442                	ld	s0,48(sp)
    15a8:	74a2                	ld	s1,40(sp)
    15aa:	69e2                	ld	s3,24(sp)
    15ac:	6121                	add	sp,sp,64
    15ae:	8082                	ret
    15b0:	7902                	ld	s2,32(sp)
    15b2:	6a42                	ld	s4,16(sp)
    15b4:	6aa2                	ld	s5,8(sp)
    15b6:	6b02                	ld	s6,0(sp)
    15b8:	b7f5                	j	15a4 <malloc+0xea>
