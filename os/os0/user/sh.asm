
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
  write(2, "$ ", 2);
      10:	4609                	li	a2,2
      12:	00001597          	auipc	a1,0x1
      16:	37e58593          	add	a1,a1,894 # 1390 <malloc+0x104>
      1a:	4509                	li	a0,2
      1c:	56d000ef          	jal	d88 <write>
  memset(buf, 0, nbuf);
      20:	864a                	mv	a2,s2
      22:	4581                	li	a1,0
      24:	8526                	mv	a0,s1
      26:	291000ef          	jal	ab6 <memset>
  gets(buf, nbuf);
      2a:	85ca                	mv	a1,s2
      2c:	8526                	mv	a0,s1
      2e:	2cf000ef          	jal	afc <gets>
  if(buf[0] == 0) // EOF
      32:	0004c503          	lbu	a0,0(s1)
      36:	00153513          	seqz	a0,a0
    return -1;
  return 0;
}
      3a:	40a00533          	neg	a0,a0
      3e:	60e2                	ld	ra,24(sp)
      40:	6442                	ld	s0,16(sp)
      42:	64a2                	ld	s1,8(sp)
      44:	6902                	ld	s2,0(sp)
      46:	6105                	add	sp,sp,32
      48:	8082                	ret

000000000000004a <panic>:
  exit(0);
}

void
panic(char *s)
{
      4a:	1141                	add	sp,sp,-16
      4c:	e406                	sd	ra,8(sp)
      4e:	e022                	sd	s0,0(sp)
      50:	0800                	add	s0,sp,16
      52:	862a                	mv	a2,a0
  fprintf(2, "%s\n", s);
      54:	00001597          	auipc	a1,0x1
      58:	34c58593          	add	a1,a1,844 # 13a0 <malloc+0x114>
      5c:	4509                	li	a0,2
      5e:	150010ef          	jal	11ae <fprintf>
  exit(1);
      62:	4505                	li	a0,1
      64:	505000ef          	jal	d68 <exit>

0000000000000068 <fork1>:
}

int
fork1(void)
{
      68:	1141                	add	sp,sp,-16
      6a:	e406                	sd	ra,8(sp)
      6c:	e022                	sd	s0,0(sp)
      6e:	0800                	add	s0,sp,16
  int pid;

  pid = fork();
      70:	4f1000ef          	jal	d60 <fork>
  if(pid == -1)
      74:	57fd                	li	a5,-1
      76:	00f50663          	beq	a0,a5,82 <fork1+0x1a>
    panic("fork");
  return pid;
}
      7a:	60a2                	ld	ra,8(sp)
      7c:	6402                	ld	s0,0(sp)
      7e:	0141                	add	sp,sp,16
      80:	8082                	ret
    panic("fork");
      82:	00001517          	auipc	a0,0x1
      86:	32650513          	add	a0,a0,806 # 13a8 <malloc+0x11c>
      8a:	fc1ff0ef          	jal	4a <panic>

000000000000008e <runcmd>:
{
      8e:	7179                	add	sp,sp,-48
      90:	f406                	sd	ra,40(sp)
      92:	f022                	sd	s0,32(sp)
      94:	1800                	add	s0,sp,48
  if(cmd == 0)
      96:	c115                	beqz	a0,ba <runcmd+0x2c>
      98:	ec26                	sd	s1,24(sp)
      9a:	84aa                	mv	s1,a0
  switch(cmd->type){
      9c:	4118                	lw	a4,0(a0)
      9e:	4795                	li	a5,5
      a0:	02e7e163          	bltu	a5,a4,c2 <runcmd+0x34>
      a4:	00056783          	lwu	a5,0(a0)
      a8:	078a                	sll	a5,a5,0x2
      aa:	00001717          	auipc	a4,0x1
      ae:	3fe70713          	add	a4,a4,1022 # 14a8 <malloc+0x21c>
      b2:	97ba                	add	a5,a5,a4
      b4:	439c                	lw	a5,0(a5)
      b6:	97ba                	add	a5,a5,a4
      b8:	8782                	jr	a5
      ba:	ec26                	sd	s1,24(sp)
    exit(1);
      bc:	4505                	li	a0,1
      be:	4ab000ef          	jal	d68 <exit>
    panic("runcmd");
      c2:	00001517          	auipc	a0,0x1
      c6:	2ee50513          	add	a0,a0,750 # 13b0 <malloc+0x124>
      ca:	f81ff0ef          	jal	4a <panic>
    if(ecmd->argv[0] == 0)
      ce:	6508                	ld	a0,8(a0)
      d0:	c105                	beqz	a0,f0 <runcmd+0x62>
    exec(ecmd->argv[0], ecmd->argv);
      d2:	00848593          	add	a1,s1,8
      d6:	4cb000ef          	jal	da0 <exec>
    fprintf(2, "exec %s failed\n", ecmd->argv[0]);
      da:	6490                	ld	a2,8(s1)
      dc:	00001597          	auipc	a1,0x1
      e0:	2dc58593          	add	a1,a1,732 # 13b8 <malloc+0x12c>
      e4:	4509                	li	a0,2
      e6:	0c8010ef          	jal	11ae <fprintf>
  exit(0);
      ea:	4501                	li	a0,0
      ec:	47d000ef          	jal	d68 <exit>
      exit(1);
      f0:	4505                	li	a0,1
      f2:	477000ef          	jal	d68 <exit>
    close(rcmd->fd);
      f6:	5148                	lw	a0,36(a0)
      f8:	499000ef          	jal	d90 <close>
    if(open(rcmd->file, rcmd->mode) < 0){
      fc:	508c                	lw	a1,32(s1)
      fe:	6888                	ld	a0,16(s1)
     100:	4a9000ef          	jal	da8 <open>
     104:	00054563          	bltz	a0,10e <runcmd+0x80>
    runcmd(rcmd->cmd);
     108:	6488                	ld	a0,8(s1)
     10a:	f85ff0ef          	jal	8e <runcmd>
      fprintf(2, "open %s failed\n", rcmd->file);
     10e:	6890                	ld	a2,16(s1)
     110:	00001597          	auipc	a1,0x1
     114:	2b858593          	add	a1,a1,696 # 13c8 <malloc+0x13c>
     118:	4509                	li	a0,2
     11a:	094010ef          	jal	11ae <fprintf>
      exit(1);
     11e:	4505                	li	a0,1
     120:	449000ef          	jal	d68 <exit>
    if(fork1() == 0)
     124:	f45ff0ef          	jal	68 <fork1>
     128:	e501                	bnez	a0,130 <runcmd+0xa2>
      runcmd(lcmd->left);
     12a:	6488                	ld	a0,8(s1)
     12c:	f63ff0ef          	jal	8e <runcmd>
    wait(0);
     130:	4501                	li	a0,0
     132:	43f000ef          	jal	d70 <wait>
    runcmd(lcmd->right);
     136:	6888                	ld	a0,16(s1)
     138:	f57ff0ef          	jal	8e <runcmd>
    if(pipe(p) < 0)
     13c:	fd840513          	add	a0,s0,-40
     140:	439000ef          	jal	d78 <pipe>
     144:	02054763          	bltz	a0,172 <runcmd+0xe4>
    if(fork1() == 0){
     148:	f21ff0ef          	jal	68 <fork1>
     14c:	e90d                	bnez	a0,17e <runcmd+0xf0>
      close(1);
     14e:	4505                	li	a0,1
     150:	441000ef          	jal	d90 <close>
      dup(p[1]);
     154:	fdc42503          	lw	a0,-36(s0)
     158:	489000ef          	jal	de0 <dup>
      close(p[0]);
     15c:	fd842503          	lw	a0,-40(s0)
     160:	431000ef          	jal	d90 <close>
      close(p[1]);
     164:	fdc42503          	lw	a0,-36(s0)
     168:	429000ef          	jal	d90 <close>
      runcmd(pcmd->left);
     16c:	6488                	ld	a0,8(s1)
     16e:	f21ff0ef          	jal	8e <runcmd>
      panic("pipe");
     172:	00001517          	auipc	a0,0x1
     176:	26650513          	add	a0,a0,614 # 13d8 <malloc+0x14c>
     17a:	ed1ff0ef          	jal	4a <panic>
    if(fork1() == 0){
     17e:	eebff0ef          	jal	68 <fork1>
     182:	e115                	bnez	a0,1a6 <runcmd+0x118>
      close(0);
     184:	40d000ef          	jal	d90 <close>
      dup(p[0]);
     188:	fd842503          	lw	a0,-40(s0)
     18c:	455000ef          	jal	de0 <dup>
      close(p[0]);
     190:	fd842503          	lw	a0,-40(s0)
     194:	3fd000ef          	jal	d90 <close>
      close(p[1]);
     198:	fdc42503          	lw	a0,-36(s0)
     19c:	3f5000ef          	jal	d90 <close>
      runcmd(pcmd->right);
     1a0:	6888                	ld	a0,16(s1)
     1a2:	eedff0ef          	jal	8e <runcmd>
    close(p[0]);
     1a6:	fd842503          	lw	a0,-40(s0)
     1aa:	3e7000ef          	jal	d90 <close>
    close(p[1]);
     1ae:	fdc42503          	lw	a0,-36(s0)
     1b2:	3df000ef          	jal	d90 <close>
    wait(0);
     1b6:	4501                	li	a0,0
     1b8:	3b9000ef          	jal	d70 <wait>
    wait(0);
     1bc:	4501                	li	a0,0
     1be:	3b3000ef          	jal	d70 <wait>
    break;
     1c2:	b725                	j	ea <runcmd+0x5c>
    if(fork1() == 0)
     1c4:	ea5ff0ef          	jal	68 <fork1>
     1c8:	f20511e3          	bnez	a0,ea <runcmd+0x5c>
      runcmd(bcmd->cmd);
     1cc:	6488                	ld	a0,8(s1)
     1ce:	ec1ff0ef          	jal	8e <runcmd>

00000000000001d2 <execcmd>:
//PAGEBREAK!
// Constructors

struct cmd*
execcmd(void)
{
     1d2:	1101                	add	sp,sp,-32
     1d4:	ec06                	sd	ra,24(sp)
     1d6:	e822                	sd	s0,16(sp)
     1d8:	e426                	sd	s1,8(sp)
     1da:	1000                	add	s0,sp,32
  struct execcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     1dc:	0a800513          	li	a0,168
     1e0:	0ac010ef          	jal	128c <malloc>
     1e4:	84aa                	mv	s1,a0
  memset(cmd, 0, sizeof(*cmd));
     1e6:	0a800613          	li	a2,168
     1ea:	4581                	li	a1,0
     1ec:	0cb000ef          	jal	ab6 <memset>
  cmd->type = EXEC;
     1f0:	4785                	li	a5,1
     1f2:	c09c                	sw	a5,0(s1)
  return (struct cmd*)cmd;
}
     1f4:	8526                	mv	a0,s1
     1f6:	60e2                	ld	ra,24(sp)
     1f8:	6442                	ld	s0,16(sp)
     1fa:	64a2                	ld	s1,8(sp)
     1fc:	6105                	add	sp,sp,32
     1fe:	8082                	ret

0000000000000200 <redircmd>:

struct cmd*
redircmd(struct cmd *subcmd, char *file, char *efile, int mode, int fd)
{
     200:	7139                	add	sp,sp,-64
     202:	fc06                	sd	ra,56(sp)
     204:	f822                	sd	s0,48(sp)
     206:	f426                	sd	s1,40(sp)
     208:	f04a                	sd	s2,32(sp)
     20a:	ec4e                	sd	s3,24(sp)
     20c:	e852                	sd	s4,16(sp)
     20e:	e456                	sd	s5,8(sp)
     210:	e05a                	sd	s6,0(sp)
     212:	0080                	add	s0,sp,64
     214:	8b2a                	mv	s6,a0
     216:	8aae                	mv	s5,a1
     218:	8a32                	mv	s4,a2
     21a:	89b6                	mv	s3,a3
     21c:	893a                	mv	s2,a4
  struct redircmd *cmd;

  cmd = malloc(sizeof(*cmd));
     21e:	02800513          	li	a0,40
     222:	06a010ef          	jal	128c <malloc>
     226:	84aa                	mv	s1,a0
  memset(cmd, 0, sizeof(*cmd));
     228:	02800613          	li	a2,40
     22c:	4581                	li	a1,0
     22e:	089000ef          	jal	ab6 <memset>
  cmd->type = REDIR;
     232:	4789                	li	a5,2
     234:	c09c                	sw	a5,0(s1)
  cmd->cmd = subcmd;
     236:	0164b423          	sd	s6,8(s1)
  cmd->file = file;
     23a:	0154b823          	sd	s5,16(s1)
  cmd->efile = efile;
     23e:	0144bc23          	sd	s4,24(s1)
  cmd->mode = mode;
     242:	0334a023          	sw	s3,32(s1)
  cmd->fd = fd;
     246:	0324a223          	sw	s2,36(s1)
  return (struct cmd*)cmd;
}
     24a:	8526                	mv	a0,s1
     24c:	70e2                	ld	ra,56(sp)
     24e:	7442                	ld	s0,48(sp)
     250:	74a2                	ld	s1,40(sp)
     252:	7902                	ld	s2,32(sp)
     254:	69e2                	ld	s3,24(sp)
     256:	6a42                	ld	s4,16(sp)
     258:	6aa2                	ld	s5,8(sp)
     25a:	6b02                	ld	s6,0(sp)
     25c:	6121                	add	sp,sp,64
     25e:	8082                	ret

0000000000000260 <pipecmd>:

struct cmd*
pipecmd(struct cmd *left, struct cmd *right)
{
     260:	7179                	add	sp,sp,-48
     262:	f406                	sd	ra,40(sp)
     264:	f022                	sd	s0,32(sp)
     266:	ec26                	sd	s1,24(sp)
     268:	e84a                	sd	s2,16(sp)
     26a:	e44e                	sd	s3,8(sp)
     26c:	1800                	add	s0,sp,48
     26e:	89aa                	mv	s3,a0
     270:	892e                	mv	s2,a1
  struct pipecmd *cmd;

  cmd = malloc(sizeof(*cmd));
     272:	4561                	li	a0,24
     274:	018010ef          	jal	128c <malloc>
     278:	84aa                	mv	s1,a0
  memset(cmd, 0, sizeof(*cmd));
     27a:	4661                	li	a2,24
     27c:	4581                	li	a1,0
     27e:	039000ef          	jal	ab6 <memset>
  cmd->type = PIPE;
     282:	478d                	li	a5,3
     284:	c09c                	sw	a5,0(s1)
  cmd->left = left;
     286:	0134b423          	sd	s3,8(s1)
  cmd->right = right;
     28a:	0124b823          	sd	s2,16(s1)
  return (struct cmd*)cmd;
}
     28e:	8526                	mv	a0,s1
     290:	70a2                	ld	ra,40(sp)
     292:	7402                	ld	s0,32(sp)
     294:	64e2                	ld	s1,24(sp)
     296:	6942                	ld	s2,16(sp)
     298:	69a2                	ld	s3,8(sp)
     29a:	6145                	add	sp,sp,48
     29c:	8082                	ret

000000000000029e <listcmd>:

struct cmd*
listcmd(struct cmd *left, struct cmd *right)
{
     29e:	7179                	add	sp,sp,-48
     2a0:	f406                	sd	ra,40(sp)
     2a2:	f022                	sd	s0,32(sp)
     2a4:	ec26                	sd	s1,24(sp)
     2a6:	e84a                	sd	s2,16(sp)
     2a8:	e44e                	sd	s3,8(sp)
     2aa:	1800                	add	s0,sp,48
     2ac:	89aa                	mv	s3,a0
     2ae:	892e                	mv	s2,a1
  struct listcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     2b0:	4561                	li	a0,24
     2b2:	7db000ef          	jal	128c <malloc>
     2b6:	84aa                	mv	s1,a0
  memset(cmd, 0, sizeof(*cmd));
     2b8:	4661                	li	a2,24
     2ba:	4581                	li	a1,0
     2bc:	7fa000ef          	jal	ab6 <memset>
  cmd->type = LIST;
     2c0:	4791                	li	a5,4
     2c2:	c09c                	sw	a5,0(s1)
  cmd->left = left;
     2c4:	0134b423          	sd	s3,8(s1)
  cmd->right = right;
     2c8:	0124b823          	sd	s2,16(s1)
  return (struct cmd*)cmd;
}
     2cc:	8526                	mv	a0,s1
     2ce:	70a2                	ld	ra,40(sp)
     2d0:	7402                	ld	s0,32(sp)
     2d2:	64e2                	ld	s1,24(sp)
     2d4:	6942                	ld	s2,16(sp)
     2d6:	69a2                	ld	s3,8(sp)
     2d8:	6145                	add	sp,sp,48
     2da:	8082                	ret

00000000000002dc <backcmd>:

struct cmd*
backcmd(struct cmd *subcmd)
{
     2dc:	1101                	add	sp,sp,-32
     2de:	ec06                	sd	ra,24(sp)
     2e0:	e822                	sd	s0,16(sp)
     2e2:	e426                	sd	s1,8(sp)
     2e4:	e04a                	sd	s2,0(sp)
     2e6:	1000                	add	s0,sp,32
     2e8:	892a                	mv	s2,a0
  struct backcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     2ea:	4541                	li	a0,16
     2ec:	7a1000ef          	jal	128c <malloc>
     2f0:	84aa                	mv	s1,a0
  memset(cmd, 0, sizeof(*cmd));
     2f2:	4641                	li	a2,16
     2f4:	4581                	li	a1,0
     2f6:	7c0000ef          	jal	ab6 <memset>
  cmd->type = BACK;
     2fa:	4795                	li	a5,5
     2fc:	c09c                	sw	a5,0(s1)
  cmd->cmd = subcmd;
     2fe:	0124b423          	sd	s2,8(s1)
  return (struct cmd*)cmd;
}
     302:	8526                	mv	a0,s1
     304:	60e2                	ld	ra,24(sp)
     306:	6442                	ld	s0,16(sp)
     308:	64a2                	ld	s1,8(sp)
     30a:	6902                	ld	s2,0(sp)
     30c:	6105                	add	sp,sp,32
     30e:	8082                	ret

0000000000000310 <gettoken>:
char whitespace[] = " \t\r\n\v";
char symbols[] = "<|>&;()";

int
gettoken(char **ps, char *es, char **q, char **eq)
{
     310:	7139                	add	sp,sp,-64
     312:	fc06                	sd	ra,56(sp)
     314:	f822                	sd	s0,48(sp)
     316:	f426                	sd	s1,40(sp)
     318:	f04a                	sd	s2,32(sp)
     31a:	ec4e                	sd	s3,24(sp)
     31c:	e852                	sd	s4,16(sp)
     31e:	e456                	sd	s5,8(sp)
     320:	e05a                	sd	s6,0(sp)
     322:	0080                	add	s0,sp,64
     324:	8a2a                	mv	s4,a0
     326:	892e                	mv	s2,a1
     328:	8ab2                	mv	s5,a2
     32a:	8b36                	mv	s6,a3
  char *s;
  int ret;

  s = *ps;
     32c:	6104                	ld	s1,0(a0)
  while(s < es && strchr(whitespace, *s))
     32e:	00002997          	auipc	s3,0x2
     332:	cda98993          	add	s3,s3,-806 # 2008 <whitespace>
     336:	00b4fc63          	bgeu	s1,a1,34e <gettoken+0x3e>
     33a:	0004c583          	lbu	a1,0(s1)
     33e:	854e                	mv	a0,s3
     340:	798000ef          	jal	ad8 <strchr>
     344:	c509                	beqz	a0,34e <gettoken+0x3e>
    s++;
     346:	0485                	add	s1,s1,1
  while(s < es && strchr(whitespace, *s))
     348:	fe9919e3          	bne	s2,s1,33a <gettoken+0x2a>
     34c:	84ca                	mv	s1,s2
  if(q)
     34e:	000a8463          	beqz	s5,356 <gettoken+0x46>
    *q = s;
     352:	009ab023          	sd	s1,0(s5)
  ret = *s;
     356:	0004c783          	lbu	a5,0(s1)
     35a:	00078a9b          	sext.w	s5,a5
  switch(*s){
     35e:	03c00713          	li	a4,60
     362:	06f76463          	bltu	a4,a5,3ca <gettoken+0xba>
     366:	03a00713          	li	a4,58
     36a:	00f76e63          	bltu	a4,a5,386 <gettoken+0x76>
     36e:	cf89                	beqz	a5,388 <gettoken+0x78>
     370:	02600713          	li	a4,38
     374:	00e78963          	beq	a5,a4,386 <gettoken+0x76>
     378:	fd87879b          	addw	a5,a5,-40
     37c:	0ff7f793          	zext.b	a5,a5
     380:	4705                	li	a4,1
     382:	06f76b63          	bltu	a4,a5,3f8 <gettoken+0xe8>
  case '(':
  case ')':
  case ';':
  case '&':
  case '<':
    s++;
     386:	0485                	add	s1,s1,1
    ret = 'a';
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
      s++;
    break;
  }
  if(eq)
     388:	000b0463          	beqz	s6,390 <gettoken+0x80>
    *eq = s;
     38c:	009b3023          	sd	s1,0(s6)

  while(s < es && strchr(whitespace, *s))
     390:	00002997          	auipc	s3,0x2
     394:	c7898993          	add	s3,s3,-904 # 2008 <whitespace>
     398:	0124fc63          	bgeu	s1,s2,3b0 <gettoken+0xa0>
     39c:	0004c583          	lbu	a1,0(s1)
     3a0:	854e                	mv	a0,s3
     3a2:	736000ef          	jal	ad8 <strchr>
     3a6:	c509                	beqz	a0,3b0 <gettoken+0xa0>
    s++;
     3a8:	0485                	add	s1,s1,1
  while(s < es && strchr(whitespace, *s))
     3aa:	fe9919e3          	bne	s2,s1,39c <gettoken+0x8c>
     3ae:	84ca                	mv	s1,s2
  *ps = s;
     3b0:	009a3023          	sd	s1,0(s4)
  return ret;
}
     3b4:	8556                	mv	a0,s5
     3b6:	70e2                	ld	ra,56(sp)
     3b8:	7442                	ld	s0,48(sp)
     3ba:	74a2                	ld	s1,40(sp)
     3bc:	7902                	ld	s2,32(sp)
     3be:	69e2                	ld	s3,24(sp)
     3c0:	6a42                	ld	s4,16(sp)
     3c2:	6aa2                	ld	s5,8(sp)
     3c4:	6b02                	ld	s6,0(sp)
     3c6:	6121                	add	sp,sp,64
     3c8:	8082                	ret
  switch(*s){
     3ca:	03e00713          	li	a4,62
     3ce:	02e79163          	bne	a5,a4,3f0 <gettoken+0xe0>
    s++;
     3d2:	00148693          	add	a3,s1,1
    if(*s == '>'){
     3d6:	0014c703          	lbu	a4,1(s1)
     3da:	03e00793          	li	a5,62
      s++;
     3de:	0489                	add	s1,s1,2
      ret = '+';
     3e0:	02b00a93          	li	s5,43
    if(*s == '>'){
     3e4:	faf702e3          	beq	a4,a5,388 <gettoken+0x78>
    s++;
     3e8:	84b6                	mv	s1,a3
  ret = *s;
     3ea:	03e00a93          	li	s5,62
     3ee:	bf69                	j	388 <gettoken+0x78>
  switch(*s){
     3f0:	07c00713          	li	a4,124
     3f4:	f8e789e3          	beq	a5,a4,386 <gettoken+0x76>
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     3f8:	00002997          	auipc	s3,0x2
     3fc:	c1098993          	add	s3,s3,-1008 # 2008 <whitespace>
     400:	00002a97          	auipc	s5,0x2
     404:	c00a8a93          	add	s5,s5,-1024 # 2000 <symbols>
     408:	0324fd63          	bgeu	s1,s2,442 <gettoken+0x132>
     40c:	0004c583          	lbu	a1,0(s1)
     410:	854e                	mv	a0,s3
     412:	6c6000ef          	jal	ad8 <strchr>
     416:	e11d                	bnez	a0,43c <gettoken+0x12c>
     418:	0004c583          	lbu	a1,0(s1)
     41c:	8556                	mv	a0,s5
     41e:	6ba000ef          	jal	ad8 <strchr>
     422:	e911                	bnez	a0,436 <gettoken+0x126>
      s++;
     424:	0485                	add	s1,s1,1
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     426:	fe9913e3          	bne	s2,s1,40c <gettoken+0xfc>
  if(eq)
     42a:	84ca                	mv	s1,s2
    ret = 'a';
     42c:	06100a93          	li	s5,97
  if(eq)
     430:	f40b1ee3          	bnez	s6,38c <gettoken+0x7c>
     434:	bfb5                	j	3b0 <gettoken+0xa0>
    ret = 'a';
     436:	06100a93          	li	s5,97
     43a:	b7b9                	j	388 <gettoken+0x78>
     43c:	06100a93          	li	s5,97
     440:	b7a1                	j	388 <gettoken+0x78>
     442:	06100a93          	li	s5,97
  if(eq)
     446:	f40b13e3          	bnez	s6,38c <gettoken+0x7c>
     44a:	b79d                	j	3b0 <gettoken+0xa0>

000000000000044c <peek>:

int
peek(char **ps, char *es, char *toks)
{
     44c:	7139                	add	sp,sp,-64
     44e:	fc06                	sd	ra,56(sp)
     450:	f822                	sd	s0,48(sp)
     452:	f426                	sd	s1,40(sp)
     454:	f04a                	sd	s2,32(sp)
     456:	ec4e                	sd	s3,24(sp)
     458:	e852                	sd	s4,16(sp)
     45a:	e456                	sd	s5,8(sp)
     45c:	0080                	add	s0,sp,64
     45e:	8a2a                	mv	s4,a0
     460:	892e                	mv	s2,a1
     462:	8ab2                	mv	s5,a2
  char *s;

  s = *ps;
     464:	6104                	ld	s1,0(a0)
  while(s < es && strchr(whitespace, *s))
     466:	00002997          	auipc	s3,0x2
     46a:	ba298993          	add	s3,s3,-1118 # 2008 <whitespace>
     46e:	00b4fc63          	bgeu	s1,a1,486 <peek+0x3a>
     472:	0004c583          	lbu	a1,0(s1)
     476:	854e                	mv	a0,s3
     478:	660000ef          	jal	ad8 <strchr>
     47c:	c509                	beqz	a0,486 <peek+0x3a>
    s++;
     47e:	0485                	add	s1,s1,1
  while(s < es && strchr(whitespace, *s))
     480:	fe9919e3          	bne	s2,s1,472 <peek+0x26>
     484:	84ca                	mv	s1,s2
  *ps = s;
     486:	009a3023          	sd	s1,0(s4)
  return *s && strchr(toks, *s);
     48a:	0004c583          	lbu	a1,0(s1)
     48e:	4501                	li	a0,0
     490:	e991                	bnez	a1,4a4 <peek+0x58>
}
     492:	70e2                	ld	ra,56(sp)
     494:	7442                	ld	s0,48(sp)
     496:	74a2                	ld	s1,40(sp)
     498:	7902                	ld	s2,32(sp)
     49a:	69e2                	ld	s3,24(sp)
     49c:	6a42                	ld	s4,16(sp)
     49e:	6aa2                	ld	s5,8(sp)
     4a0:	6121                	add	sp,sp,64
     4a2:	8082                	ret
  return *s && strchr(toks, *s);
     4a4:	8556                	mv	a0,s5
     4a6:	632000ef          	jal	ad8 <strchr>
     4aa:	00a03533          	snez	a0,a0
     4ae:	b7d5                	j	492 <peek+0x46>

00000000000004b0 <parseredirs>:
  return cmd;
}

struct cmd*
parseredirs(struct cmd *cmd, char **ps, char *es)
{
     4b0:	711d                	add	sp,sp,-96
     4b2:	ec86                	sd	ra,88(sp)
     4b4:	e8a2                	sd	s0,80(sp)
     4b6:	e4a6                	sd	s1,72(sp)
     4b8:	e0ca                	sd	s2,64(sp)
     4ba:	fc4e                	sd	s3,56(sp)
     4bc:	f852                	sd	s4,48(sp)
     4be:	f456                	sd	s5,40(sp)
     4c0:	f05a                	sd	s6,32(sp)
     4c2:	ec5e                	sd	s7,24(sp)
     4c4:	1080                	add	s0,sp,96
     4c6:	8a2a                	mv	s4,a0
     4c8:	89ae                	mv	s3,a1
     4ca:	8932                	mv	s2,a2
  int tok;
  char *q, *eq;

  while(peek(ps, es, "<>")){
     4cc:	00001a97          	auipc	s5,0x1
     4d0:	f34a8a93          	add	s5,s5,-204 # 1400 <malloc+0x174>
    tok = gettoken(ps, es, 0, 0);
    if(gettoken(ps, es, &q, &eq) != 'a')
     4d4:	06100b13          	li	s6,97
      panic("missing file for redirection");
    switch(tok){
     4d8:	03c00b93          	li	s7,60
  while(peek(ps, es, "<>")){
     4dc:	a00d                	j	4fe <parseredirs+0x4e>
      panic("missing file for redirection");
     4de:	00001517          	auipc	a0,0x1
     4e2:	f0250513          	add	a0,a0,-254 # 13e0 <malloc+0x154>
     4e6:	b65ff0ef          	jal	4a <panic>
    case '<':
      cmd = redircmd(cmd, q, eq, O_RDONLY, 0);
     4ea:	4701                	li	a4,0
     4ec:	4681                	li	a3,0
     4ee:	fa043603          	ld	a2,-96(s0)
     4f2:	fa843583          	ld	a1,-88(s0)
     4f6:	8552                	mv	a0,s4
     4f8:	d09ff0ef          	jal	200 <redircmd>
     4fc:	8a2a                	mv	s4,a0
  while(peek(ps, es, "<>")){
     4fe:	8656                	mv	a2,s5
     500:	85ca                	mv	a1,s2
     502:	854e                	mv	a0,s3
     504:	f49ff0ef          	jal	44c <peek>
     508:	c525                	beqz	a0,570 <parseredirs+0xc0>
    tok = gettoken(ps, es, 0, 0);
     50a:	4681                	li	a3,0
     50c:	4601                	li	a2,0
     50e:	85ca                	mv	a1,s2
     510:	854e                	mv	a0,s3
     512:	dffff0ef          	jal	310 <gettoken>
     516:	84aa                	mv	s1,a0
    if(gettoken(ps, es, &q, &eq) != 'a')
     518:	fa040693          	add	a3,s0,-96
     51c:	fa840613          	add	a2,s0,-88
     520:	85ca                	mv	a1,s2
     522:	854e                	mv	a0,s3
     524:	dedff0ef          	jal	310 <gettoken>
     528:	fb651be3          	bne	a0,s6,4de <parseredirs+0x2e>
    switch(tok){
     52c:	fb748fe3          	beq	s1,s7,4ea <parseredirs+0x3a>
     530:	03e00793          	li	a5,62
     534:	02f48263          	beq	s1,a5,558 <parseredirs+0xa8>
     538:	02b00793          	li	a5,43
     53c:	fcf491e3          	bne	s1,a5,4fe <parseredirs+0x4e>
      break;
    case '>':
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE|O_TRUNC, 1);
      break;
    case '+':  // >>
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
     540:	4705                	li	a4,1
     542:	20100693          	li	a3,513
     546:	fa043603          	ld	a2,-96(s0)
     54a:	fa843583          	ld	a1,-88(s0)
     54e:	8552                	mv	a0,s4
     550:	cb1ff0ef          	jal	200 <redircmd>
     554:	8a2a                	mv	s4,a0
      break;
     556:	b765                	j	4fe <parseredirs+0x4e>
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE|O_TRUNC, 1);
     558:	4705                	li	a4,1
     55a:	60100693          	li	a3,1537
     55e:	fa043603          	ld	a2,-96(s0)
     562:	fa843583          	ld	a1,-88(s0)
     566:	8552                	mv	a0,s4
     568:	c99ff0ef          	jal	200 <redircmd>
     56c:	8a2a                	mv	s4,a0
      break;
     56e:	bf41                	j	4fe <parseredirs+0x4e>
    }
  }
  return cmd;
}
     570:	8552                	mv	a0,s4
     572:	60e6                	ld	ra,88(sp)
     574:	6446                	ld	s0,80(sp)
     576:	64a6                	ld	s1,72(sp)
     578:	6906                	ld	s2,64(sp)
     57a:	79e2                	ld	s3,56(sp)
     57c:	7a42                	ld	s4,48(sp)
     57e:	7aa2                	ld	s5,40(sp)
     580:	7b02                	ld	s6,32(sp)
     582:	6be2                	ld	s7,24(sp)
     584:	6125                	add	sp,sp,96
     586:	8082                	ret

0000000000000588 <parseexec>:
  return cmd;
}

struct cmd*
parseexec(char **ps, char *es)
{
     588:	7159                	add	sp,sp,-112
     58a:	f486                	sd	ra,104(sp)
     58c:	f0a2                	sd	s0,96(sp)
     58e:	eca6                	sd	s1,88(sp)
     590:	e0d2                	sd	s4,64(sp)
     592:	fc56                	sd	s5,56(sp)
     594:	1880                	add	s0,sp,112
     596:	8a2a                	mv	s4,a0
     598:	8aae                	mv	s5,a1
  char *q, *eq;
  int tok, argc;
  struct execcmd *cmd;
  struct cmd *ret;

  if(peek(ps, es, "("))
     59a:	00001617          	auipc	a2,0x1
     59e:	e6e60613          	add	a2,a2,-402 # 1408 <malloc+0x17c>
     5a2:	eabff0ef          	jal	44c <peek>
     5a6:	e915                	bnez	a0,5da <parseexec+0x52>
     5a8:	e8ca                	sd	s2,80(sp)
     5aa:	e4ce                	sd	s3,72(sp)
     5ac:	f85a                	sd	s6,48(sp)
     5ae:	f45e                	sd	s7,40(sp)
     5b0:	f062                	sd	s8,32(sp)
     5b2:	ec66                	sd	s9,24(sp)
     5b4:	89aa                	mv	s3,a0
    return parseblock(ps, es);

  ret = execcmd();
     5b6:	c1dff0ef          	jal	1d2 <execcmd>
     5ba:	8c2a                	mv	s8,a0
  cmd = (struct execcmd*)ret;

  argc = 0;
  ret = parseredirs(ret, ps, es);
     5bc:	8656                	mv	a2,s5
     5be:	85d2                	mv	a1,s4
     5c0:	ef1ff0ef          	jal	4b0 <parseredirs>
     5c4:	84aa                	mv	s1,a0
  while(!peek(ps, es, "|)&;")){
     5c6:	008c0913          	add	s2,s8,8
     5ca:	00001b17          	auipc	s6,0x1
     5ce:	e5eb0b13          	add	s6,s6,-418 # 1428 <malloc+0x19c>
    if((tok=gettoken(ps, es, &q, &eq)) == 0)
      break;
    if(tok != 'a')
     5d2:	06100c93          	li	s9,97
      panic("syntax");
    cmd->argv[argc] = q;
    cmd->eargv[argc] = eq;
    argc++;
    if(argc >= MAXARGS)
     5d6:	4ba9                	li	s7,10
  while(!peek(ps, es, "|)&;")){
     5d8:	a815                	j	60c <parseexec+0x84>
    return parseblock(ps, es);
     5da:	85d6                	mv	a1,s5
     5dc:	8552                	mv	a0,s4
     5de:	170000ef          	jal	74e <parseblock>
     5e2:	84aa                	mv	s1,a0
    ret = parseredirs(ret, ps, es);
  }
  cmd->argv[argc] = 0;
  cmd->eargv[argc] = 0;
  return ret;
}
     5e4:	8526                	mv	a0,s1
     5e6:	70a6                	ld	ra,104(sp)
     5e8:	7406                	ld	s0,96(sp)
     5ea:	64e6                	ld	s1,88(sp)
     5ec:	6a06                	ld	s4,64(sp)
     5ee:	7ae2                	ld	s5,56(sp)
     5f0:	6165                	add	sp,sp,112
     5f2:	8082                	ret
      panic("syntax");
     5f4:	00001517          	auipc	a0,0x1
     5f8:	e1c50513          	add	a0,a0,-484 # 1410 <malloc+0x184>
     5fc:	a4fff0ef          	jal	4a <panic>
    ret = parseredirs(ret, ps, es);
     600:	8656                	mv	a2,s5
     602:	85d2                	mv	a1,s4
     604:	8526                	mv	a0,s1
     606:	eabff0ef          	jal	4b0 <parseredirs>
     60a:	84aa                	mv	s1,a0
  while(!peek(ps, es, "|)&;")){
     60c:	865a                	mv	a2,s6
     60e:	85d6                	mv	a1,s5
     610:	8552                	mv	a0,s4
     612:	e3bff0ef          	jal	44c <peek>
     616:	ed15                	bnez	a0,652 <parseexec+0xca>
    if((tok=gettoken(ps, es, &q, &eq)) == 0)
     618:	f9040693          	add	a3,s0,-112
     61c:	f9840613          	add	a2,s0,-104
     620:	85d6                	mv	a1,s5
     622:	8552                	mv	a0,s4
     624:	cedff0ef          	jal	310 <gettoken>
     628:	c50d                	beqz	a0,652 <parseexec+0xca>
    if(tok != 'a')
     62a:	fd9515e3          	bne	a0,s9,5f4 <parseexec+0x6c>
    cmd->argv[argc] = q;
     62e:	f9843783          	ld	a5,-104(s0)
     632:	00f93023          	sd	a5,0(s2)
    cmd->eargv[argc] = eq;
     636:	f9043783          	ld	a5,-112(s0)
     63a:	04f93823          	sd	a5,80(s2)
    argc++;
     63e:	2985                	addw	s3,s3,1
    if(argc >= MAXARGS)
     640:	0921                	add	s2,s2,8
     642:	fb799fe3          	bne	s3,s7,600 <parseexec+0x78>
      panic("too many args");
     646:	00001517          	auipc	a0,0x1
     64a:	dd250513          	add	a0,a0,-558 # 1418 <malloc+0x18c>
     64e:	9fdff0ef          	jal	4a <panic>
  cmd->argv[argc] = 0;
     652:	098e                	sll	s3,s3,0x3
     654:	9c4e                	add	s8,s8,s3
     656:	000c3423          	sd	zero,8(s8)
  cmd->eargv[argc] = 0;
     65a:	040c3c23          	sd	zero,88(s8)
     65e:	6946                	ld	s2,80(sp)
     660:	69a6                	ld	s3,72(sp)
     662:	7b42                	ld	s6,48(sp)
     664:	7ba2                	ld	s7,40(sp)
     666:	7c02                	ld	s8,32(sp)
     668:	6ce2                	ld	s9,24(sp)
  return ret;
     66a:	bfad                	j	5e4 <parseexec+0x5c>

000000000000066c <parsepipe>:
{
     66c:	7179                	add	sp,sp,-48
     66e:	f406                	sd	ra,40(sp)
     670:	f022                	sd	s0,32(sp)
     672:	ec26                	sd	s1,24(sp)
     674:	e84a                	sd	s2,16(sp)
     676:	e44e                	sd	s3,8(sp)
     678:	1800                	add	s0,sp,48
     67a:	892a                	mv	s2,a0
     67c:	89ae                	mv	s3,a1
  cmd = parseexec(ps, es);
     67e:	f0bff0ef          	jal	588 <parseexec>
     682:	84aa                	mv	s1,a0
  if(peek(ps, es, "|")){
     684:	00001617          	auipc	a2,0x1
     688:	dac60613          	add	a2,a2,-596 # 1430 <malloc+0x1a4>
     68c:	85ce                	mv	a1,s3
     68e:	854a                	mv	a0,s2
     690:	dbdff0ef          	jal	44c <peek>
     694:	e909                	bnez	a0,6a6 <parsepipe+0x3a>
}
     696:	8526                	mv	a0,s1
     698:	70a2                	ld	ra,40(sp)
     69a:	7402                	ld	s0,32(sp)
     69c:	64e2                	ld	s1,24(sp)
     69e:	6942                	ld	s2,16(sp)
     6a0:	69a2                	ld	s3,8(sp)
     6a2:	6145                	add	sp,sp,48
     6a4:	8082                	ret
    gettoken(ps, es, 0, 0);
     6a6:	4681                	li	a3,0
     6a8:	4601                	li	a2,0
     6aa:	85ce                	mv	a1,s3
     6ac:	854a                	mv	a0,s2
     6ae:	c63ff0ef          	jal	310 <gettoken>
    cmd = pipecmd(cmd, parsepipe(ps, es));
     6b2:	85ce                	mv	a1,s3
     6b4:	854a                	mv	a0,s2
     6b6:	fb7ff0ef          	jal	66c <parsepipe>
     6ba:	85aa                	mv	a1,a0
     6bc:	8526                	mv	a0,s1
     6be:	ba3ff0ef          	jal	260 <pipecmd>
     6c2:	84aa                	mv	s1,a0
  return cmd;
     6c4:	bfc9                	j	696 <parsepipe+0x2a>

00000000000006c6 <parseline>:
{
     6c6:	7179                	add	sp,sp,-48
     6c8:	f406                	sd	ra,40(sp)
     6ca:	f022                	sd	s0,32(sp)
     6cc:	ec26                	sd	s1,24(sp)
     6ce:	e84a                	sd	s2,16(sp)
     6d0:	e44e                	sd	s3,8(sp)
     6d2:	e052                	sd	s4,0(sp)
     6d4:	1800                	add	s0,sp,48
     6d6:	892a                	mv	s2,a0
     6d8:	89ae                	mv	s3,a1
  cmd = parsepipe(ps, es);
     6da:	f93ff0ef          	jal	66c <parsepipe>
     6de:	84aa                	mv	s1,a0
  while(peek(ps, es, "&")){
     6e0:	00001a17          	auipc	s4,0x1
     6e4:	d58a0a13          	add	s4,s4,-680 # 1438 <malloc+0x1ac>
     6e8:	a819                	j	6fe <parseline+0x38>
    gettoken(ps, es, 0, 0);
     6ea:	4681                	li	a3,0
     6ec:	4601                	li	a2,0
     6ee:	85ce                	mv	a1,s3
     6f0:	854a                	mv	a0,s2
     6f2:	c1fff0ef          	jal	310 <gettoken>
    cmd = backcmd(cmd);
     6f6:	8526                	mv	a0,s1
     6f8:	be5ff0ef          	jal	2dc <backcmd>
     6fc:	84aa                	mv	s1,a0
  while(peek(ps, es, "&")){
     6fe:	8652                	mv	a2,s4
     700:	85ce                	mv	a1,s3
     702:	854a                	mv	a0,s2
     704:	d49ff0ef          	jal	44c <peek>
     708:	f16d                	bnez	a0,6ea <parseline+0x24>
  if(peek(ps, es, ";")){
     70a:	00001617          	auipc	a2,0x1
     70e:	d3660613          	add	a2,a2,-714 # 1440 <malloc+0x1b4>
     712:	85ce                	mv	a1,s3
     714:	854a                	mv	a0,s2
     716:	d37ff0ef          	jal	44c <peek>
     71a:	e911                	bnez	a0,72e <parseline+0x68>
}
     71c:	8526                	mv	a0,s1
     71e:	70a2                	ld	ra,40(sp)
     720:	7402                	ld	s0,32(sp)
     722:	64e2                	ld	s1,24(sp)
     724:	6942                	ld	s2,16(sp)
     726:	69a2                	ld	s3,8(sp)
     728:	6a02                	ld	s4,0(sp)
     72a:	6145                	add	sp,sp,48
     72c:	8082                	ret
    gettoken(ps, es, 0, 0);
     72e:	4681                	li	a3,0
     730:	4601                	li	a2,0
     732:	85ce                	mv	a1,s3
     734:	854a                	mv	a0,s2
     736:	bdbff0ef          	jal	310 <gettoken>
    cmd = listcmd(cmd, parseline(ps, es));
     73a:	85ce                	mv	a1,s3
     73c:	854a                	mv	a0,s2
     73e:	f89ff0ef          	jal	6c6 <parseline>
     742:	85aa                	mv	a1,a0
     744:	8526                	mv	a0,s1
     746:	b59ff0ef          	jal	29e <listcmd>
     74a:	84aa                	mv	s1,a0
  return cmd;
     74c:	bfc1                	j	71c <parseline+0x56>

000000000000074e <parseblock>:
{
     74e:	7179                	add	sp,sp,-48
     750:	f406                	sd	ra,40(sp)
     752:	f022                	sd	s0,32(sp)
     754:	ec26                	sd	s1,24(sp)
     756:	e84a                	sd	s2,16(sp)
     758:	e44e                	sd	s3,8(sp)
     75a:	1800                	add	s0,sp,48
     75c:	84aa                	mv	s1,a0
     75e:	892e                	mv	s2,a1
  if(!peek(ps, es, "("))
     760:	00001617          	auipc	a2,0x1
     764:	ca860613          	add	a2,a2,-856 # 1408 <malloc+0x17c>
     768:	ce5ff0ef          	jal	44c <peek>
     76c:	c539                	beqz	a0,7ba <parseblock+0x6c>
  gettoken(ps, es, 0, 0);
     76e:	4681                	li	a3,0
     770:	4601                	li	a2,0
     772:	85ca                	mv	a1,s2
     774:	8526                	mv	a0,s1
     776:	b9bff0ef          	jal	310 <gettoken>
  cmd = parseline(ps, es);
     77a:	85ca                	mv	a1,s2
     77c:	8526                	mv	a0,s1
     77e:	f49ff0ef          	jal	6c6 <parseline>
     782:	89aa                	mv	s3,a0
  if(!peek(ps, es, ")"))
     784:	00001617          	auipc	a2,0x1
     788:	cd460613          	add	a2,a2,-812 # 1458 <malloc+0x1cc>
     78c:	85ca                	mv	a1,s2
     78e:	8526                	mv	a0,s1
     790:	cbdff0ef          	jal	44c <peek>
     794:	c90d                	beqz	a0,7c6 <parseblock+0x78>
  gettoken(ps, es, 0, 0);
     796:	4681                	li	a3,0
     798:	4601                	li	a2,0
     79a:	85ca                	mv	a1,s2
     79c:	8526                	mv	a0,s1
     79e:	b73ff0ef          	jal	310 <gettoken>
  cmd = parseredirs(cmd, ps, es);
     7a2:	864a                	mv	a2,s2
     7a4:	85a6                	mv	a1,s1
     7a6:	854e                	mv	a0,s3
     7a8:	d09ff0ef          	jal	4b0 <parseredirs>
}
     7ac:	70a2                	ld	ra,40(sp)
     7ae:	7402                	ld	s0,32(sp)
     7b0:	64e2                	ld	s1,24(sp)
     7b2:	6942                	ld	s2,16(sp)
     7b4:	69a2                	ld	s3,8(sp)
     7b6:	6145                	add	sp,sp,48
     7b8:	8082                	ret
    panic("parseblock");
     7ba:	00001517          	auipc	a0,0x1
     7be:	c8e50513          	add	a0,a0,-882 # 1448 <malloc+0x1bc>
     7c2:	889ff0ef          	jal	4a <panic>
    panic("syntax - missing )");
     7c6:	00001517          	auipc	a0,0x1
     7ca:	c9a50513          	add	a0,a0,-870 # 1460 <malloc+0x1d4>
     7ce:	87dff0ef          	jal	4a <panic>

00000000000007d2 <nulterminate>:

// NUL-terminate all the counted strings.
struct cmd*
nulterminate(struct cmd *cmd)
{
     7d2:	1101                	add	sp,sp,-32
     7d4:	ec06                	sd	ra,24(sp)
     7d6:	e822                	sd	s0,16(sp)
     7d8:	e426                	sd	s1,8(sp)
     7da:	1000                	add	s0,sp,32
     7dc:	84aa                	mv	s1,a0
  struct execcmd *ecmd;
  struct listcmd *lcmd;
  struct pipecmd *pcmd;
  struct redircmd *rcmd;

  if(cmd == 0)
     7de:	c131                	beqz	a0,822 <nulterminate+0x50>
    return 0;

  switch(cmd->type){
     7e0:	4118                	lw	a4,0(a0)
     7e2:	4795                	li	a5,5
     7e4:	02e7ef63          	bltu	a5,a4,822 <nulterminate+0x50>
     7e8:	00056783          	lwu	a5,0(a0)
     7ec:	078a                	sll	a5,a5,0x2
     7ee:	00001717          	auipc	a4,0x1
     7f2:	cd270713          	add	a4,a4,-814 # 14c0 <malloc+0x234>
     7f6:	97ba                	add	a5,a5,a4
     7f8:	439c                	lw	a5,0(a5)
     7fa:	97ba                	add	a5,a5,a4
     7fc:	8782                	jr	a5
  case EXEC:
    ecmd = (struct execcmd*)cmd;
    for(i=0; ecmd->argv[i]; i++)
     7fe:	651c                	ld	a5,8(a0)
     800:	c38d                	beqz	a5,822 <nulterminate+0x50>
     802:	01050793          	add	a5,a0,16
      *ecmd->eargv[i] = 0;
     806:	67b8                	ld	a4,72(a5)
     808:	00070023          	sb	zero,0(a4)
    for(i=0; ecmd->argv[i]; i++)
     80c:	07a1                	add	a5,a5,8
     80e:	ff87b703          	ld	a4,-8(a5)
     812:	fb75                	bnez	a4,806 <nulterminate+0x34>
     814:	a039                	j	822 <nulterminate+0x50>
    break;

  case REDIR:
    rcmd = (struct redircmd*)cmd;
    nulterminate(rcmd->cmd);
     816:	6508                	ld	a0,8(a0)
     818:	fbbff0ef          	jal	7d2 <nulterminate>
    *rcmd->efile = 0;
     81c:	6c9c                	ld	a5,24(s1)
     81e:	00078023          	sb	zero,0(a5)
    bcmd = (struct backcmd*)cmd;
    nulterminate(bcmd->cmd);
    break;
  }
  return cmd;
}
     822:	8526                	mv	a0,s1
     824:	60e2                	ld	ra,24(sp)
     826:	6442                	ld	s0,16(sp)
     828:	64a2                	ld	s1,8(sp)
     82a:	6105                	add	sp,sp,32
     82c:	8082                	ret
    nulterminate(pcmd->left);
     82e:	6508                	ld	a0,8(a0)
     830:	fa3ff0ef          	jal	7d2 <nulterminate>
    nulterminate(pcmd->right);
     834:	6888                	ld	a0,16(s1)
     836:	f9dff0ef          	jal	7d2 <nulterminate>
    break;
     83a:	b7e5                	j	822 <nulterminate+0x50>
    nulterminate(lcmd->left);
     83c:	6508                	ld	a0,8(a0)
     83e:	f95ff0ef          	jal	7d2 <nulterminate>
    nulterminate(lcmd->right);
     842:	6888                	ld	a0,16(s1)
     844:	f8fff0ef          	jal	7d2 <nulterminate>
    break;
     848:	bfe9                	j	822 <nulterminate+0x50>
    nulterminate(bcmd->cmd);
     84a:	6508                	ld	a0,8(a0)
     84c:	f87ff0ef          	jal	7d2 <nulterminate>
    break;
     850:	bfc9                	j	822 <nulterminate+0x50>

0000000000000852 <parsecmd>:
{
     852:	7179                	add	sp,sp,-48
     854:	f406                	sd	ra,40(sp)
     856:	f022                	sd	s0,32(sp)
     858:	ec26                	sd	s1,24(sp)
     85a:	e84a                	sd	s2,16(sp)
     85c:	1800                	add	s0,sp,48
     85e:	fca43c23          	sd	a0,-40(s0)
  es = s + strlen(s);
     862:	84aa                	mv	s1,a0
     864:	228000ef          	jal	a8c <strlen>
     868:	1502                	sll	a0,a0,0x20
     86a:	9101                	srl	a0,a0,0x20
     86c:	94aa                	add	s1,s1,a0
  cmd = parseline(&s, es);
     86e:	85a6                	mv	a1,s1
     870:	fd840513          	add	a0,s0,-40
     874:	e53ff0ef          	jal	6c6 <parseline>
     878:	892a                	mv	s2,a0
  peek(&s, es, "");
     87a:	00001617          	auipc	a2,0x1
     87e:	b1e60613          	add	a2,a2,-1250 # 1398 <malloc+0x10c>
     882:	85a6                	mv	a1,s1
     884:	fd840513          	add	a0,s0,-40
     888:	bc5ff0ef          	jal	44c <peek>
  if(s != es){
     88c:	fd843603          	ld	a2,-40(s0)
     890:	00961c63          	bne	a2,s1,8a8 <parsecmd+0x56>
  nulterminate(cmd);
     894:	854a                	mv	a0,s2
     896:	f3dff0ef          	jal	7d2 <nulterminate>
}
     89a:	854a                	mv	a0,s2
     89c:	70a2                	ld	ra,40(sp)
     89e:	7402                	ld	s0,32(sp)
     8a0:	64e2                	ld	s1,24(sp)
     8a2:	6942                	ld	s2,16(sp)
     8a4:	6145                	add	sp,sp,48
     8a6:	8082                	ret
    fprintf(2, "leftovers: %s\n", s);
     8a8:	00001597          	auipc	a1,0x1
     8ac:	bd058593          	add	a1,a1,-1072 # 1478 <malloc+0x1ec>
     8b0:	4509                	li	a0,2
     8b2:	0fd000ef          	jal	11ae <fprintf>
    panic("syntax");
     8b6:	00001517          	auipc	a0,0x1
     8ba:	b5a50513          	add	a0,a0,-1190 # 1410 <malloc+0x184>
     8be:	f8cff0ef          	jal	4a <panic>

00000000000008c2 <main>:
{
     8c2:	7139                	add	sp,sp,-64
     8c4:	fc06                	sd	ra,56(sp)
     8c6:	f822                	sd	s0,48(sp)
     8c8:	f426                	sd	s1,40(sp)
     8ca:	f04a                	sd	s2,32(sp)
     8cc:	ec4e                	sd	s3,24(sp)
     8ce:	e852                	sd	s4,16(sp)
     8d0:	e456                	sd	s5,8(sp)
     8d2:	e05a                	sd	s6,0(sp)
     8d4:	0080                	add	s0,sp,64
  while((fd = open("console", O_RDWR)) >= 0){
     8d6:	00001497          	auipc	s1,0x1
     8da:	bb248493          	add	s1,s1,-1102 # 1488 <malloc+0x1fc>
     8de:	4589                	li	a1,2
     8e0:	8526                	mv	a0,s1
     8e2:	4c6000ef          	jal	da8 <open>
     8e6:	00054763          	bltz	a0,8f4 <main+0x32>
    if(fd >= 3){
     8ea:	4789                	li	a5,2
     8ec:	fea7d9e3          	bge	a5,a0,8de <main+0x1c>
      close(fd);
     8f0:	4a0000ef          	jal	d90 <close>
  while(getcmd(buf, sizeof(buf)) >= 0){
     8f4:	00001a17          	auipc	s4,0x1
     8f8:	72ca0a13          	add	s4,s4,1836 # 2020 <buf.0>
    while (*cmd == ' ' || *cmd == '\t')
     8fc:	02000913          	li	s2,32
     900:	49a5                	li	s3,9
    if (*cmd == '\n') // is a blank command
     902:	4aa9                	li	s5,10
    if(cmd[0] == 'c' && cmd[1] == 'd' && cmd[2] == ' '){
     904:	06300b13          	li	s6,99
     908:	a805                	j	938 <main+0x76>
      cmd++;
     90a:	0485                	add	s1,s1,1
    while (*cmd == ' ' || *cmd == '\t')
     90c:	0004c783          	lbu	a5,0(s1)
     910:	ff278de3          	beq	a5,s2,90a <main+0x48>
     914:	ff378be3          	beq	a5,s3,90a <main+0x48>
    if (*cmd == '\n') // is a blank command
     918:	03578063          	beq	a5,s5,938 <main+0x76>
    if(cmd[0] == 'c' && cmd[1] == 'd' && cmd[2] == ' '){
     91c:	01679863          	bne	a5,s6,92c <main+0x6a>
     920:	0014c703          	lbu	a4,1(s1)
     924:	06400793          	li	a5,100
     928:	02f70463          	beq	a4,a5,950 <main+0x8e>
      if(fork1() == 0)
     92c:	f3cff0ef          	jal	68 <fork1>
     930:	cd29                	beqz	a0,98a <main+0xc8>
      wait(0);
     932:	4501                	li	a0,0
     934:	43c000ef          	jal	d70 <wait>
  while(getcmd(buf, sizeof(buf)) >= 0){
     938:	06400593          	li	a1,100
     93c:	8552                	mv	a0,s4
     93e:	ec2ff0ef          	jal	0 <getcmd>
     942:	04054963          	bltz	a0,994 <main+0xd2>
    char *cmd = buf;
     946:	00001497          	auipc	s1,0x1
     94a:	6da48493          	add	s1,s1,1754 # 2020 <buf.0>
     94e:	bf7d                	j	90c <main+0x4a>
    if(cmd[0] == 'c' && cmd[1] == 'd' && cmd[2] == ' '){
     950:	0024c783          	lbu	a5,2(s1)
     954:	fd279ce3          	bne	a5,s2,92c <main+0x6a>
      cmd[strlen(cmd)-1] = 0;  // chop \n
     958:	8526                	mv	a0,s1
     95a:	132000ef          	jal	a8c <strlen>
     95e:	fff5079b          	addw	a5,a0,-1
     962:	1782                	sll	a5,a5,0x20
     964:	9381                	srl	a5,a5,0x20
     966:	97a6                	add	a5,a5,s1
     968:	00078023          	sb	zero,0(a5)
      if(chdir(cmd+3) < 0)
     96c:	048d                	add	s1,s1,3
     96e:	8526                	mv	a0,s1
     970:	468000ef          	jal	dd8 <chdir>
     974:	fc0552e3          	bgez	a0,938 <main+0x76>
        fprintf(2, "cannot cd %s\n", cmd+3);
     978:	8626                	mv	a2,s1
     97a:	00001597          	auipc	a1,0x1
     97e:	b1658593          	add	a1,a1,-1258 # 1490 <malloc+0x204>
     982:	4509                	li	a0,2
     984:	02b000ef          	jal	11ae <fprintf>
     988:	bf45                	j	938 <main+0x76>
        runcmd(parsecmd(cmd));
     98a:	8526                	mv	a0,s1
     98c:	ec7ff0ef          	jal	852 <parsecmd>
     990:	efeff0ef          	jal	8e <runcmd>
  exit(0);
     994:	4501                	li	a0,0
     996:	3d2000ef          	jal	d68 <exit>

000000000000099a <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start(int argc, char **argv)
{
     99a:	1141                	add	sp,sp,-16
     99c:	e406                	sd	ra,8(sp)
     99e:	e022                	sd	s0,0(sp)
     9a0:	0800                	add	s0,sp,16
  int r;
  extern int main(int argc, char **argv);
  r = main(argc, argv);
     9a2:	f21ff0ef          	jal	8c2 <main>
  exit(r);
     9a6:	3c2000ef          	jal	d68 <exit>

00000000000009aa <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
     9aa:	1141                	add	sp,sp,-16
     9ac:	e422                	sd	s0,8(sp)
     9ae:	0800                	add	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
     9b0:	87aa                	mv	a5,a0
     9b2:	0585                	add	a1,a1,1
     9b4:	0785                	add	a5,a5,1
     9b6:	fff5c703          	lbu	a4,-1(a1)
     9ba:	fee78fa3          	sb	a4,-1(a5)
     9be:	fb75                	bnez	a4,9b2 <strcpy+0x8>
    ;
  return os;
}
     9c0:	6422                	ld	s0,8(sp)
     9c2:	0141                	add	sp,sp,16
     9c4:	8082                	ret

00000000000009c6 <strcmp>:

int
strcmp(const char *p, const char *q)
{
     9c6:	1141                	add	sp,sp,-16
     9c8:	e422                	sd	s0,8(sp)
     9ca:	0800                	add	s0,sp,16
  while(*p && *p == *q)
     9cc:	00054783          	lbu	a5,0(a0)
     9d0:	cb91                	beqz	a5,9e4 <strcmp+0x1e>
     9d2:	0005c703          	lbu	a4,0(a1)
     9d6:	00f71763          	bne	a4,a5,9e4 <strcmp+0x1e>
    p++, q++;
     9da:	0505                	add	a0,a0,1
     9dc:	0585                	add	a1,a1,1
  while(*p && *p == *q)
     9de:	00054783          	lbu	a5,0(a0)
     9e2:	fbe5                	bnez	a5,9d2 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
     9e4:	0005c503          	lbu	a0,0(a1)
}
     9e8:	40a7853b          	subw	a0,a5,a0
     9ec:	6422                	ld	s0,8(sp)
     9ee:	0141                	add	sp,sp,16
     9f0:	8082                	ret

00000000000009f2 <strncmp>:

int
strncmp(const char *p, const char *q, uint n)
{
     9f2:	1141                	add	sp,sp,-16
     9f4:	e422                	sd	s0,8(sp)
     9f6:	0800                	add	s0,sp,16
  while(n > 0 && *p && *p == *q) {
     9f8:	ce11                	beqz	a2,a14 <strncmp+0x22>
     9fa:	00054783          	lbu	a5,0(a0)
     9fe:	cf89                	beqz	a5,a18 <strncmp+0x26>
     a00:	0005c703          	lbu	a4,0(a1)
     a04:	00f71a63          	bne	a4,a5,a18 <strncmp+0x26>
    p++, q++, n--;
     a08:	0505                	add	a0,a0,1
     a0a:	0585                	add	a1,a1,1
     a0c:	367d                	addw	a2,a2,-1
  while(n > 0 && *p && *p == *q) {
     a0e:	f675                	bnez	a2,9fa <strncmp+0x8>
  }
  if (n == 0)
    return 0;
     a10:	4501                	li	a0,0
     a12:	a801                	j	a22 <strncmp+0x30>
     a14:	4501                	li	a0,0
     a16:	a031                	j	a22 <strncmp+0x30>
  return (uchar)*p - (uchar)*q;
     a18:	00054503          	lbu	a0,0(a0)
     a1c:	0005c783          	lbu	a5,0(a1)
     a20:	9d1d                	subw	a0,a0,a5
}
     a22:	6422                	ld	s0,8(sp)
     a24:	0141                	add	sp,sp,16
     a26:	8082                	ret

0000000000000a28 <strcat>:

char*
strcat(char *dst, const char *src)
{
     a28:	1141                	add	sp,sp,-16
     a2a:	e422                	sd	s0,8(sp)
     a2c:	0800                	add	s0,sp,16
  char *p = dst;
  while(*p) p++;
     a2e:	00054783          	lbu	a5,0(a0)
     a32:	c385                	beqz	a5,a52 <strcat+0x2a>
  char *p = dst;
     a34:	87aa                	mv	a5,a0
  while(*p) p++;
     a36:	0785                	add	a5,a5,1
     a38:	0007c703          	lbu	a4,0(a5)
     a3c:	ff6d                	bnez	a4,a36 <strcat+0xe>
  while((*p++ = *src++) != 0);
     a3e:	0585                	add	a1,a1,1
     a40:	0785                	add	a5,a5,1
     a42:	fff5c703          	lbu	a4,-1(a1)
     a46:	fee78fa3          	sb	a4,-1(a5)
     a4a:	fb75                	bnez	a4,a3e <strcat+0x16>
  return dst;
}
     a4c:	6422                	ld	s0,8(sp)
     a4e:	0141                	add	sp,sp,16
     a50:	8082                	ret
  char *p = dst;
     a52:	87aa                	mv	a5,a0
     a54:	b7ed                	j	a3e <strcat+0x16>

0000000000000a56 <strncpy>:

char*
strncpy(char *dst, const char *src, int n)
{
     a56:	1141                	add	sp,sp,-16
     a58:	e422                	sd	s0,8(sp)
     a5a:	0800                	add	s0,sp,16
  char *p = dst;
     a5c:	87aa                	mv	a5,a0
  while(n > 0 && *src) {
     a5e:	02c05463          	blez	a2,a86 <strncpy+0x30>
     a62:	0005c703          	lbu	a4,0(a1)
     a66:	cb01                	beqz	a4,a76 <strncpy+0x20>
    *p++ = *src++;
     a68:	0585                	add	a1,a1,1
     a6a:	0785                	add	a5,a5,1
     a6c:	fee78fa3          	sb	a4,-1(a5)
    n--;
     a70:	367d                	addw	a2,a2,-1
  while(n > 0 && *src) {
     a72:	fa65                	bnez	a2,a62 <strncpy+0xc>
     a74:	a809                	j	a86 <strncpy+0x30>
  }
  while(n > 0) {
     a76:	1602                	sll	a2,a2,0x20
     a78:	9201                	srl	a2,a2,0x20
     a7a:	963e                	add	a2,a2,a5
    *p++ = 0;
     a7c:	0785                	add	a5,a5,1
     a7e:	fe078fa3          	sb	zero,-1(a5)
  while(n > 0) {
     a82:	fec79de3          	bne	a5,a2,a7c <strncpy+0x26>
    n--;
  }
  return dst;
}
     a86:	6422                	ld	s0,8(sp)
     a88:	0141                	add	sp,sp,16
     a8a:	8082                	ret

0000000000000a8c <strlen>:

uint
strlen(const char *s)
{
     a8c:	1141                	add	sp,sp,-16
     a8e:	e422                	sd	s0,8(sp)
     a90:	0800                	add	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
     a92:	00054783          	lbu	a5,0(a0)
     a96:	cf91                	beqz	a5,ab2 <strlen+0x26>
     a98:	0505                	add	a0,a0,1
     a9a:	87aa                	mv	a5,a0
     a9c:	86be                	mv	a3,a5
     a9e:	0785                	add	a5,a5,1
     aa0:	fff7c703          	lbu	a4,-1(a5)
     aa4:	ff65                	bnez	a4,a9c <strlen+0x10>
     aa6:	40a6853b          	subw	a0,a3,a0
     aaa:	2505                	addw	a0,a0,1
    ;
  return n;
}
     aac:	6422                	ld	s0,8(sp)
     aae:	0141                	add	sp,sp,16
     ab0:	8082                	ret
  for(n = 0; s[n]; n++)
     ab2:	4501                	li	a0,0
     ab4:	bfe5                	j	aac <strlen+0x20>

0000000000000ab6 <memset>:

void*
memset(void *dst, int c, uint n)
{
     ab6:	1141                	add	sp,sp,-16
     ab8:	e422                	sd	s0,8(sp)
     aba:	0800                	add	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
     abc:	ca19                	beqz	a2,ad2 <memset+0x1c>
     abe:	87aa                	mv	a5,a0
     ac0:	1602                	sll	a2,a2,0x20
     ac2:	9201                	srl	a2,a2,0x20
     ac4:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
     ac8:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
     acc:	0785                	add	a5,a5,1
     ace:	fee79de3          	bne	a5,a4,ac8 <memset+0x12>
  }
  return dst;
}
     ad2:	6422                	ld	s0,8(sp)
     ad4:	0141                	add	sp,sp,16
     ad6:	8082                	ret

0000000000000ad8 <strchr>:

char*
strchr(const char *s, char c)
{
     ad8:	1141                	add	sp,sp,-16
     ada:	e422                	sd	s0,8(sp)
     adc:	0800                	add	s0,sp,16
  for(; *s; s++)
     ade:	00054783          	lbu	a5,0(a0)
     ae2:	cb99                	beqz	a5,af8 <strchr+0x20>
    if(*s == c)
     ae4:	00f58763          	beq	a1,a5,af2 <strchr+0x1a>
  for(; *s; s++)
     ae8:	0505                	add	a0,a0,1
     aea:	00054783          	lbu	a5,0(a0)
     aee:	fbfd                	bnez	a5,ae4 <strchr+0xc>
      return (char*)s;
  return 0;
     af0:	4501                	li	a0,0
}
     af2:	6422                	ld	s0,8(sp)
     af4:	0141                	add	sp,sp,16
     af6:	8082                	ret
  return 0;
     af8:	4501                	li	a0,0
     afa:	bfe5                	j	af2 <strchr+0x1a>

0000000000000afc <gets>:

char*
gets(char *buf, int max)
{
     afc:	711d                	add	sp,sp,-96
     afe:	ec86                	sd	ra,88(sp)
     b00:	e8a2                	sd	s0,80(sp)
     b02:	e4a6                	sd	s1,72(sp)
     b04:	e0ca                	sd	s2,64(sp)
     b06:	fc4e                	sd	s3,56(sp)
     b08:	f852                	sd	s4,48(sp)
     b0a:	f456                	sd	s5,40(sp)
     b0c:	f05a                	sd	s6,32(sp)
     b0e:	ec5e                	sd	s7,24(sp)
     b10:	1080                	add	s0,sp,96
     b12:	8baa                	mv	s7,a0
     b14:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     b16:	892a                	mv	s2,a0
     b18:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
     b1a:	4aa9                	li	s5,10
     b1c:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
     b1e:	89a6                	mv	s3,s1
     b20:	2485                	addw	s1,s1,1
     b22:	0344d663          	bge	s1,s4,b4e <gets+0x52>
    cc = read(0, &c, 1);
     b26:	4605                	li	a2,1
     b28:	faf40593          	add	a1,s0,-81
     b2c:	4501                	li	a0,0
     b2e:	252000ef          	jal	d80 <read>
    if(cc < 1)
     b32:	00a05e63          	blez	a0,b4e <gets+0x52>
    buf[i++] = c;
     b36:	faf44783          	lbu	a5,-81(s0)
     b3a:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
     b3e:	01578763          	beq	a5,s5,b4c <gets+0x50>
     b42:	0905                	add	s2,s2,1
     b44:	fd679de3          	bne	a5,s6,b1e <gets+0x22>
    buf[i++] = c;
     b48:	89a6                	mv	s3,s1
     b4a:	a011                	j	b4e <gets+0x52>
     b4c:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
     b4e:	99de                	add	s3,s3,s7
     b50:	00098023          	sb	zero,0(s3)
  return buf;
}
     b54:	855e                	mv	a0,s7
     b56:	60e6                	ld	ra,88(sp)
     b58:	6446                	ld	s0,80(sp)
     b5a:	64a6                	ld	s1,72(sp)
     b5c:	6906                	ld	s2,64(sp)
     b5e:	79e2                	ld	s3,56(sp)
     b60:	7a42                	ld	s4,48(sp)
     b62:	7aa2                	ld	s5,40(sp)
     b64:	7b02                	ld	s6,32(sp)
     b66:	6be2                	ld	s7,24(sp)
     b68:	6125                	add	sp,sp,96
     b6a:	8082                	ret

0000000000000b6c <stat>:

int
stat(const char *n, struct stat *st)
{
     b6c:	1101                	add	sp,sp,-32
     b6e:	ec06                	sd	ra,24(sp)
     b70:	e822                	sd	s0,16(sp)
     b72:	e04a                	sd	s2,0(sp)
     b74:	1000                	add	s0,sp,32
     b76:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     b78:	4581                	li	a1,0
     b7a:	22e000ef          	jal	da8 <open>
  if(fd < 0)
     b7e:	02054263          	bltz	a0,ba2 <stat+0x36>
     b82:	e426                	sd	s1,8(sp)
     b84:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
     b86:	85ca                	mv	a1,s2
     b88:	238000ef          	jal	dc0 <fstat>
     b8c:	892a                	mv	s2,a0
  close(fd);
     b8e:	8526                	mv	a0,s1
     b90:	200000ef          	jal	d90 <close>
  return r;
     b94:	64a2                	ld	s1,8(sp)
}
     b96:	854a                	mv	a0,s2
     b98:	60e2                	ld	ra,24(sp)
     b9a:	6442                	ld	s0,16(sp)
     b9c:	6902                	ld	s2,0(sp)
     b9e:	6105                	add	sp,sp,32
     ba0:	8082                	ret
    return -1;
     ba2:	597d                	li	s2,-1
     ba4:	bfcd                	j	b96 <stat+0x2a>

0000000000000ba6 <atoi>:

int
atoi(const char *s)
{
     ba6:	1141                	add	sp,sp,-16
     ba8:	e422                	sd	s0,8(sp)
     baa:	0800                	add	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
     bac:	00054683          	lbu	a3,0(a0)
     bb0:	fd06879b          	addw	a5,a3,-48
     bb4:	0ff7f793          	zext.b	a5,a5
     bb8:	4625                	li	a2,9
     bba:	02f66863          	bltu	a2,a5,bea <atoi+0x44>
     bbe:	872a                	mv	a4,a0
  n = 0;
     bc0:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
     bc2:	0705                	add	a4,a4,1
     bc4:	0025179b          	sllw	a5,a0,0x2
     bc8:	9fa9                	addw	a5,a5,a0
     bca:	0017979b          	sllw	a5,a5,0x1
     bce:	9fb5                	addw	a5,a5,a3
     bd0:	fd07851b          	addw	a0,a5,-48
  while('0' <= *s && *s <= '9')
     bd4:	00074683          	lbu	a3,0(a4)
     bd8:	fd06879b          	addw	a5,a3,-48
     bdc:	0ff7f793          	zext.b	a5,a5
     be0:	fef671e3          	bgeu	a2,a5,bc2 <atoi+0x1c>
  return n;
}
     be4:	6422                	ld	s0,8(sp)
     be6:	0141                	add	sp,sp,16
     be8:	8082                	ret
  n = 0;
     bea:	4501                	li	a0,0
     bec:	bfe5                	j	be4 <atoi+0x3e>

0000000000000bee <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
     bee:	1141                	add	sp,sp,-16
     bf0:	e422                	sd	s0,8(sp)
     bf2:	0800                	add	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
     bf4:	02b57463          	bgeu	a0,a1,c1c <memmove+0x2e>
    while(n-- > 0)
     bf8:	00c05f63          	blez	a2,c16 <memmove+0x28>
     bfc:	1602                	sll	a2,a2,0x20
     bfe:	9201                	srl	a2,a2,0x20
     c00:	00c507b3          	add	a5,a0,a2
  dst = vdst;
     c04:	872a                	mv	a4,a0
      *dst++ = *src++;
     c06:	0585                	add	a1,a1,1
     c08:	0705                	add	a4,a4,1
     c0a:	fff5c683          	lbu	a3,-1(a1)
     c0e:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
     c12:	fef71ae3          	bne	a4,a5,c06 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
     c16:	6422                	ld	s0,8(sp)
     c18:	0141                	add	sp,sp,16
     c1a:	8082                	ret
    dst += n;
     c1c:	00c50733          	add	a4,a0,a2
    src += n;
     c20:	95b2                	add	a1,a1,a2
    while(n-- > 0)
     c22:	fec05ae3          	blez	a2,c16 <memmove+0x28>
     c26:	fff6079b          	addw	a5,a2,-1
     c2a:	1782                	sll	a5,a5,0x20
     c2c:	9381                	srl	a5,a5,0x20
     c2e:	fff7c793          	not	a5,a5
     c32:	97ba                	add	a5,a5,a4
      *--dst = *--src;
     c34:	15fd                	add	a1,a1,-1
     c36:	177d                	add	a4,a4,-1
     c38:	0005c683          	lbu	a3,0(a1)
     c3c:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
     c40:	fee79ae3          	bne	a5,a4,c34 <memmove+0x46>
     c44:	bfc9                	j	c16 <memmove+0x28>

0000000000000c46 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
     c46:	1141                	add	sp,sp,-16
     c48:	e422                	sd	s0,8(sp)
     c4a:	0800                	add	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
     c4c:	ca05                	beqz	a2,c7c <memcmp+0x36>
     c4e:	fff6069b          	addw	a3,a2,-1
     c52:	1682                	sll	a3,a3,0x20
     c54:	9281                	srl	a3,a3,0x20
     c56:	0685                	add	a3,a3,1
     c58:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
     c5a:	00054783          	lbu	a5,0(a0)
     c5e:	0005c703          	lbu	a4,0(a1)
     c62:	00e79863          	bne	a5,a4,c72 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
     c66:	0505                	add	a0,a0,1
    p2++;
     c68:	0585                	add	a1,a1,1
  while (n-- > 0) {
     c6a:	fed518e3          	bne	a0,a3,c5a <memcmp+0x14>
  }
  return 0;
     c6e:	4501                	li	a0,0
     c70:	a019                	j	c76 <memcmp+0x30>
      return *p1 - *p2;
     c72:	40e7853b          	subw	a0,a5,a4
}
     c76:	6422                	ld	s0,8(sp)
     c78:	0141                	add	sp,sp,16
     c7a:	8082                	ret
  return 0;
     c7c:	4501                	li	a0,0
     c7e:	bfe5                	j	c76 <memcmp+0x30>

0000000000000c80 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
     c80:	1141                	add	sp,sp,-16
     c82:	e406                	sd	ra,8(sp)
     c84:	e022                	sd	s0,0(sp)
     c86:	0800                	add	s0,sp,16
  return memmove(dst, src, n);
     c88:	f67ff0ef          	jal	bee <memmove>
}
     c8c:	60a2                	ld	ra,8(sp)
     c8e:	6402                	ld	s0,0(sp)
     c90:	0141                	add	sp,sp,16
     c92:	8082                	ret

0000000000000c94 <sbrk>:

char *
sbrk(int n) {
     c94:	1141                	add	sp,sp,-16
     c96:	e406                	sd	ra,8(sp)
     c98:	e022                	sd	s0,0(sp)
     c9a:	0800                	add	s0,sp,16
  return sys_sbrk(n, SBRK_EAGER);
     c9c:	4585                	li	a1,1
     c9e:	152000ef          	jal	df0 <sys_sbrk>
}
     ca2:	60a2                	ld	ra,8(sp)
     ca4:	6402                	ld	s0,0(sp)
     ca6:	0141                	add	sp,sp,16
     ca8:	8082                	ret

0000000000000caa <sbrklazy>:

char *
sbrklazy(int n) {
     caa:	1141                	add	sp,sp,-16
     cac:	e406                	sd	ra,8(sp)
     cae:	e022                	sd	s0,0(sp)
     cb0:	0800                	add	s0,sp,16
  return sys_sbrk(n, SBRK_LAZY);
     cb2:	4589                	li	a1,2
     cb4:	13c000ef          	jal	df0 <sys_sbrk>
}
     cb8:	60a2                	ld	ra,8(sp)
     cba:	6402                	ld	s0,0(sp)
     cbc:	0141                	add	sp,sp,16
     cbe:	8082                	ret

0000000000000cc0 <htons>:

// Byte order conversion functions
unsigned short
htons(unsigned short hostshort)
{
     cc0:	1141                	add	sp,sp,-16
     cc2:	e422                	sd	s0,8(sp)
     cc4:	0800                	add	s0,sp,16
  return ((hostshort >> 8) & 0xff) | ((hostshort & 0xff) << 8);
     cc6:	0085179b          	sllw	a5,a0,0x8
     cca:	0085551b          	srlw	a0,a0,0x8
     cce:	8d5d                	or	a0,a0,a5
}
     cd0:	1542                	sll	a0,a0,0x30
     cd2:	9141                	srl	a0,a0,0x30
     cd4:	6422                	ld	s0,8(sp)
     cd6:	0141                	add	sp,sp,16
     cd8:	8082                	ret

0000000000000cda <ntohs>:

unsigned short
ntohs(unsigned short netshort)
{
     cda:	1141                	add	sp,sp,-16
     cdc:	e422                	sd	s0,8(sp)
     cde:	0800                	add	s0,sp,16
  return ((netshort >> 8) & 0xff) | ((netshort & 0xff) << 8);
     ce0:	0085179b          	sllw	a5,a0,0x8
     ce4:	0085551b          	srlw	a0,a0,0x8
     ce8:	8d5d                	or	a0,a0,a5
}
     cea:	1542                	sll	a0,a0,0x30
     cec:	9141                	srl	a0,a0,0x30
     cee:	6422                	ld	s0,8(sp)
     cf0:	0141                	add	sp,sp,16
     cf2:	8082                	ret

0000000000000cf4 <htonl>:

unsigned long
htonl(unsigned long hostlong)
{
     cf4:	1141                	add	sp,sp,-16
     cf6:	e422                	sd	s0,8(sp)
     cf8:	0800                	add	s0,sp,16
  return ((hostlong >> 24) & 0xff) |
     cfa:	0185579b          	srlw	a5,a0,0x18
         ((hostlong >> 8) & 0xff00) |
     cfe:	00855713          	srl	a4,a0,0x8
     d02:	66c1                	lui	a3,0x10
     d04:	f0068693          	add	a3,a3,-256 # ff00 <base+0xde78>
     d08:	8f75                	and	a4,a4,a3
  return ((hostlong >> 24) & 0xff) |
     d0a:	8fd9                	or	a5,a5,a4
         ((hostlong & 0xff00) << 8) |
     d0c:	00851713          	sll	a4,a0,0x8
     d10:	00ff06b7          	lui	a3,0xff0
     d14:	8f75                	and	a4,a4,a3
         ((hostlong >> 8) & 0xff00) |
     d16:	8fd9                	or	a5,a5,a4
         ((hostlong & 0xff) << 24);
     d18:	0562                	sll	a0,a0,0x18
     d1a:	0ff00713          	li	a4,255
     d1e:	0762                	sll	a4,a4,0x18
     d20:	8d79                	and	a0,a0,a4
}
     d22:	8d5d                	or	a0,a0,a5
     d24:	6422                	ld	s0,8(sp)
     d26:	0141                	add	sp,sp,16
     d28:	8082                	ret

0000000000000d2a <ntohl>:

unsigned long
ntohl(unsigned long netlong)
{
     d2a:	1141                	add	sp,sp,-16
     d2c:	e422                	sd	s0,8(sp)
     d2e:	0800                	add	s0,sp,16
  return ((netlong >> 24) & 0xff) |
     d30:	0185579b          	srlw	a5,a0,0x18
         ((netlong >> 8) & 0xff00) |
     d34:	00855713          	srl	a4,a0,0x8
     d38:	66c1                	lui	a3,0x10
     d3a:	f0068693          	add	a3,a3,-256 # ff00 <base+0xde78>
     d3e:	8f75                	and	a4,a4,a3
  return ((netlong >> 24) & 0xff) |
     d40:	8fd9                	or	a5,a5,a4
         ((netlong & 0xff00) << 8) |
     d42:	00851713          	sll	a4,a0,0x8
     d46:	00ff06b7          	lui	a3,0xff0
     d4a:	8f75                	and	a4,a4,a3
         ((netlong >> 8) & 0xff00) |
     d4c:	8fd9                	or	a5,a5,a4
         ((netlong & 0xff) << 24);
     d4e:	0562                	sll	a0,a0,0x18
     d50:	0ff00713          	li	a4,255
     d54:	0762                	sll	a4,a4,0x18
     d56:	8d79                	and	a0,a0,a4
}
     d58:	8d5d                	or	a0,a0,a5
     d5a:	6422                	ld	s0,8(sp)
     d5c:	0141                	add	sp,sp,16
     d5e:	8082                	ret

0000000000000d60 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
     d60:	4885                	li	a7,1
 ecall
     d62:	00000073          	ecall
 ret
     d66:	8082                	ret

0000000000000d68 <exit>:
.global exit
exit:
 li a7, SYS_exit
     d68:	4889                	li	a7,2
 ecall
     d6a:	00000073          	ecall
 ret
     d6e:	8082                	ret

0000000000000d70 <wait>:
.global wait
wait:
 li a7, SYS_wait
     d70:	488d                	li	a7,3
 ecall
     d72:	00000073          	ecall
 ret
     d76:	8082                	ret

0000000000000d78 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
     d78:	4891                	li	a7,4
 ecall
     d7a:	00000073          	ecall
 ret
     d7e:	8082                	ret

0000000000000d80 <read>:
.global read
read:
 li a7, SYS_read
     d80:	4895                	li	a7,5
 ecall
     d82:	00000073          	ecall
 ret
     d86:	8082                	ret

0000000000000d88 <write>:
.global write
write:
 li a7, SYS_write
     d88:	48c1                	li	a7,16
 ecall
     d8a:	00000073          	ecall
 ret
     d8e:	8082                	ret

0000000000000d90 <close>:
.global close
close:
 li a7, SYS_close
     d90:	48d5                	li	a7,21
 ecall
     d92:	00000073          	ecall
 ret
     d96:	8082                	ret

0000000000000d98 <kill>:
.global kill
kill:
 li a7, SYS_kill
     d98:	4899                	li	a7,6
 ecall
     d9a:	00000073          	ecall
 ret
     d9e:	8082                	ret

0000000000000da0 <exec>:
.global exec
exec:
 li a7, SYS_exec
     da0:	489d                	li	a7,7
 ecall
     da2:	00000073          	ecall
 ret
     da6:	8082                	ret

0000000000000da8 <open>:
.global open
open:
 li a7, SYS_open
     da8:	48bd                	li	a7,15
 ecall
     daa:	00000073          	ecall
 ret
     dae:	8082                	ret

0000000000000db0 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
     db0:	48c5                	li	a7,17
 ecall
     db2:	00000073          	ecall
 ret
     db6:	8082                	ret

0000000000000db8 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
     db8:	48c9                	li	a7,18
 ecall
     dba:	00000073          	ecall
 ret
     dbe:	8082                	ret

0000000000000dc0 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
     dc0:	48a1                	li	a7,8
 ecall
     dc2:	00000073          	ecall
 ret
     dc6:	8082                	ret

0000000000000dc8 <link>:
.global link
link:
 li a7, SYS_link
     dc8:	48cd                	li	a7,19
 ecall
     dca:	00000073          	ecall
 ret
     dce:	8082                	ret

0000000000000dd0 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
     dd0:	48d1                	li	a7,20
 ecall
     dd2:	00000073          	ecall
 ret
     dd6:	8082                	ret

0000000000000dd8 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
     dd8:	48a5                	li	a7,9
 ecall
     dda:	00000073          	ecall
 ret
     dde:	8082                	ret

0000000000000de0 <dup>:
.global dup
dup:
 li a7, SYS_dup
     de0:	48a9                	li	a7,10
 ecall
     de2:	00000073          	ecall
 ret
     de6:	8082                	ret

0000000000000de8 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
     de8:	48ad                	li	a7,11
 ecall
     dea:	00000073          	ecall
 ret
     dee:	8082                	ret

0000000000000df0 <sys_sbrk>:
.global sys_sbrk
sys_sbrk:
 li a7, SYS_sbrk
     df0:	48b1                	li	a7,12
 ecall
     df2:	00000073          	ecall
 ret
     df6:	8082                	ret

0000000000000df8 <pause>:
.global pause
pause:
 li a7, SYS_pause
     df8:	48b5                	li	a7,13
 ecall
     dfa:	00000073          	ecall
 ret
     dfe:	8082                	ret

0000000000000e00 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
     e00:	48b9                	li	a7,14
 ecall
     e02:	00000073          	ecall
 ret
     e06:	8082                	ret

0000000000000e08 <socket>:
.global socket
socket:
 li a7, SYS_socket
     e08:	48d9                	li	a7,22
 ecall
     e0a:	00000073          	ecall
 ret
     e0e:	8082                	ret

0000000000000e10 <bind>:
.global bind
bind:
 li a7, SYS_bind
     e10:	48dd                	li	a7,23
 ecall
     e12:	00000073          	ecall
 ret
     e16:	8082                	ret

0000000000000e18 <listen>:
.global listen
listen:
 li a7, SYS_listen
     e18:	48e1                	li	a7,24
 ecall
     e1a:	00000073          	ecall
 ret
     e1e:	8082                	ret

0000000000000e20 <accept>:
.global accept
accept:
 li a7, SYS_accept
     e20:	48e5                	li	a7,25
 ecall
     e22:	00000073          	ecall
 ret
     e26:	8082                	ret

0000000000000e28 <connect>:
.global connect
connect:
 li a7, SYS_connect
     e28:	48e9                	li	a7,26
 ecall
     e2a:	00000073          	ecall
 ret
     e2e:	8082                	ret

0000000000000e30 <send>:
.global send
send:
 li a7, SYS_send
     e30:	48ed                	li	a7,27
 ecall
     e32:	00000073          	ecall
 ret
     e36:	8082                	ret

0000000000000e38 <recv>:
.global recv
recv:
 li a7, SYS_recv
     e38:	48f1                	li	a7,28
 ecall
     e3a:	00000073          	ecall
 ret
     e3e:	8082                	ret

0000000000000e40 <sendto>:
.global sendto
sendto:
 li a7, SYS_sendto
     e40:	48f5                	li	a7,29
 ecall
     e42:	00000073          	ecall
 ret
     e46:	8082                	ret

0000000000000e48 <recvfrom>:
.global recvfrom
recvfrom:
 li a7, SYS_recvfrom
     e48:	48f9                	li	a7,30
 ecall
     e4a:	00000073          	ecall
 ret
     e4e:	8082                	ret

0000000000000e50 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
     e50:	1101                	add	sp,sp,-32
     e52:	ec06                	sd	ra,24(sp)
     e54:	e822                	sd	s0,16(sp)
     e56:	1000                	add	s0,sp,32
     e58:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
     e5c:	4605                	li	a2,1
     e5e:	fef40593          	add	a1,s0,-17
     e62:	f27ff0ef          	jal	d88 <write>
}
     e66:	60e2                	ld	ra,24(sp)
     e68:	6442                	ld	s0,16(sp)
     e6a:	6105                	add	sp,sp,32
     e6c:	8082                	ret

0000000000000e6e <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
     e6e:	715d                	add	sp,sp,-80
     e70:	e486                	sd	ra,72(sp)
     e72:	e0a2                	sd	s0,64(sp)
     e74:	f84a                	sd	s2,48(sp)
     e76:	0880                	add	s0,sp,80
     e78:	892a                	mv	s2,a0
  char buf[20];
  int i, neg;
  unsigned long long x;

  neg = 0;
  if(sgn && xx < 0){
     e7a:	c299                	beqz	a3,e80 <printint+0x12>
     e7c:	0805c363          	bltz	a1,f02 <printint+0x94>
  neg = 0;
     e80:	4881                	li	a7,0
     e82:	fb840693          	add	a3,s0,-72
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
     e86:	4781                	li	a5,0
  do{
    buf[i++] = digits[x % base];
     e88:	00000517          	auipc	a0,0x0
     e8c:	65050513          	add	a0,a0,1616 # 14d8 <digits>
     e90:	883e                	mv	a6,a5
     e92:	2785                	addw	a5,a5,1
     e94:	02c5f733          	remu	a4,a1,a2
     e98:	972a                	add	a4,a4,a0
     e9a:	00074703          	lbu	a4,0(a4)
     e9e:	00e68023          	sb	a4,0(a3) # ff0000 <base+0xfedf78>
  }while((x /= base) != 0);
     ea2:	872e                	mv	a4,a1
     ea4:	02c5d5b3          	divu	a1,a1,a2
     ea8:	0685                	add	a3,a3,1
     eaa:	fec773e3          	bgeu	a4,a2,e90 <printint+0x22>
  if(neg)
     eae:	00088b63          	beqz	a7,ec4 <printint+0x56>
    buf[i++] = '-';
     eb2:	fd078793          	add	a5,a5,-48
     eb6:	97a2                	add	a5,a5,s0
     eb8:	02d00713          	li	a4,45
     ebc:	fee78423          	sb	a4,-24(a5)
     ec0:	0028079b          	addw	a5,a6,2

  while(--i >= 0)
     ec4:	02f05a63          	blez	a5,ef8 <printint+0x8a>
     ec8:	fc26                	sd	s1,56(sp)
     eca:	f44e                	sd	s3,40(sp)
     ecc:	fb840713          	add	a4,s0,-72
     ed0:	00f704b3          	add	s1,a4,a5
     ed4:	fff70993          	add	s3,a4,-1
     ed8:	99be                	add	s3,s3,a5
     eda:	37fd                	addw	a5,a5,-1
     edc:	1782                	sll	a5,a5,0x20
     ede:	9381                	srl	a5,a5,0x20
     ee0:	40f989b3          	sub	s3,s3,a5
    putc(fd, buf[i]);
     ee4:	fff4c583          	lbu	a1,-1(s1)
     ee8:	854a                	mv	a0,s2
     eea:	f67ff0ef          	jal	e50 <putc>
  while(--i >= 0)
     eee:	14fd                	add	s1,s1,-1
     ef0:	ff349ae3          	bne	s1,s3,ee4 <printint+0x76>
     ef4:	74e2                	ld	s1,56(sp)
     ef6:	79a2                	ld	s3,40(sp)
}
     ef8:	60a6                	ld	ra,72(sp)
     efa:	6406                	ld	s0,64(sp)
     efc:	7942                	ld	s2,48(sp)
     efe:	6161                	add	sp,sp,80
     f00:	8082                	ret
    x = -xx;
     f02:	40b005b3          	neg	a1,a1
    neg = 1;
     f06:	4885                	li	a7,1
    x = -xx;
     f08:	bfad                	j	e82 <printint+0x14>

0000000000000f0a <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %c, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
     f0a:	711d                	add	sp,sp,-96
     f0c:	ec86                	sd	ra,88(sp)
     f0e:	e8a2                	sd	s0,80(sp)
     f10:	e0ca                	sd	s2,64(sp)
     f12:	1080                	add	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
     f14:	0005c903          	lbu	s2,0(a1)
     f18:	28090663          	beqz	s2,11a4 <vprintf+0x29a>
     f1c:	e4a6                	sd	s1,72(sp)
     f1e:	fc4e                	sd	s3,56(sp)
     f20:	f852                	sd	s4,48(sp)
     f22:	f456                	sd	s5,40(sp)
     f24:	f05a                	sd	s6,32(sp)
     f26:	ec5e                	sd	s7,24(sp)
     f28:	e862                	sd	s8,16(sp)
     f2a:	e466                	sd	s9,8(sp)
     f2c:	8b2a                	mv	s6,a0
     f2e:	8a2e                	mv	s4,a1
     f30:	8bb2                	mv	s7,a2
  state = 0;
     f32:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
     f34:	4481                	li	s1,0
     f36:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
     f38:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
     f3c:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
     f40:	06c00c93          	li	s9,108
     f44:	a005                	j	f64 <vprintf+0x5a>
        putc(fd, c0);
     f46:	85ca                	mv	a1,s2
     f48:	855a                	mv	a0,s6
     f4a:	f07ff0ef          	jal	e50 <putc>
     f4e:	a019                	j	f54 <vprintf+0x4a>
    } else if(state == '%'){
     f50:	03598263          	beq	s3,s5,f74 <vprintf+0x6a>
  for(i = 0; fmt[i]; i++){
     f54:	2485                	addw	s1,s1,1
     f56:	8726                	mv	a4,s1
     f58:	009a07b3          	add	a5,s4,s1
     f5c:	0007c903          	lbu	s2,0(a5)
     f60:	22090a63          	beqz	s2,1194 <vprintf+0x28a>
    c0 = fmt[i] & 0xff;
     f64:	0009079b          	sext.w	a5,s2
    if(state == 0){
     f68:	fe0994e3          	bnez	s3,f50 <vprintf+0x46>
      if(c0 == '%'){
     f6c:	fd579de3          	bne	a5,s5,f46 <vprintf+0x3c>
        state = '%';
     f70:	89be                	mv	s3,a5
     f72:	b7cd                	j	f54 <vprintf+0x4a>
      if(c0) c1 = fmt[i+1] & 0xff;
     f74:	00ea06b3          	add	a3,s4,a4
     f78:	0016c683          	lbu	a3,1(a3)
      c1 = c2 = 0;
     f7c:	8636                	mv	a2,a3
      if(c1) c2 = fmt[i+2] & 0xff;
     f7e:	c681                	beqz	a3,f86 <vprintf+0x7c>
     f80:	9752                	add	a4,a4,s4
     f82:	00274603          	lbu	a2,2(a4)
      if(c0 == 'd'){
     f86:	05878363          	beq	a5,s8,fcc <vprintf+0xc2>
      } else if(c0 == 'l' && c1 == 'd'){
     f8a:	05978d63          	beq	a5,s9,fe4 <vprintf+0xda>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
     f8e:	07500713          	li	a4,117
     f92:	0ee78763          	beq	a5,a4,1080 <vprintf+0x176>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
     f96:	07800713          	li	a4,120
     f9a:	12e78963          	beq	a5,a4,10cc <vprintf+0x1c2>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
     f9e:	07000713          	li	a4,112
     fa2:	14e78e63          	beq	a5,a4,10fe <vprintf+0x1f4>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 'c'){
     fa6:	06300713          	li	a4,99
     faa:	18e78e63          	beq	a5,a4,1146 <vprintf+0x23c>
        putc(fd, va_arg(ap, uint32));
      } else if(c0 == 's'){
     fae:	07300713          	li	a4,115
     fb2:	1ae78463          	beq	a5,a4,115a <vprintf+0x250>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
     fb6:	02500713          	li	a4,37
     fba:	04e79563          	bne	a5,a4,1004 <vprintf+0xfa>
        putc(fd, '%');
     fbe:	02500593          	li	a1,37
     fc2:	855a                	mv	a0,s6
     fc4:	e8dff0ef          	jal	e50 <putc>
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c0);
      }

      state = 0;
     fc8:	4981                	li	s3,0
     fca:	b769                	j	f54 <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 1);
     fcc:	008b8913          	add	s2,s7,8
     fd0:	4685                	li	a3,1
     fd2:	4629                	li	a2,10
     fd4:	000ba583          	lw	a1,0(s7)
     fd8:	855a                	mv	a0,s6
     fda:	e95ff0ef          	jal	e6e <printint>
     fde:	8bca                	mv	s7,s2
      state = 0;
     fe0:	4981                	li	s3,0
     fe2:	bf8d                	j	f54 <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'd'){
     fe4:	06400793          	li	a5,100
     fe8:	02f68963          	beq	a3,a5,101a <vprintf+0x110>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
     fec:	06c00793          	li	a5,108
     ff0:	04f68263          	beq	a3,a5,1034 <vprintf+0x12a>
      } else if(c0 == 'l' && c1 == 'u'){
     ff4:	07500793          	li	a5,117
     ff8:	0af68063          	beq	a3,a5,1098 <vprintf+0x18e>
      } else if(c0 == 'l' && c1 == 'x'){
     ffc:	07800793          	li	a5,120
    1000:	0ef68263          	beq	a3,a5,10e4 <vprintf+0x1da>
        putc(fd, '%');
    1004:	02500593          	li	a1,37
    1008:	855a                	mv	a0,s6
    100a:	e47ff0ef          	jal	e50 <putc>
        putc(fd, c0);
    100e:	85ca                	mv	a1,s2
    1010:	855a                	mv	a0,s6
    1012:	e3fff0ef          	jal	e50 <putc>
      state = 0;
    1016:	4981                	li	s3,0
    1018:	bf35                	j	f54 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
    101a:	008b8913          	add	s2,s7,8
    101e:	4685                	li	a3,1
    1020:	4629                	li	a2,10
    1022:	000bb583          	ld	a1,0(s7)
    1026:	855a                	mv	a0,s6
    1028:	e47ff0ef          	jal	e6e <printint>
        i += 1;
    102c:	2485                	addw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 1);
    102e:	8bca                	mv	s7,s2
      state = 0;
    1030:	4981                	li	s3,0
        i += 1;
    1032:	b70d                	j	f54 <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
    1034:	06400793          	li	a5,100
    1038:	02f60763          	beq	a2,a5,1066 <vprintf+0x15c>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
    103c:	07500793          	li	a5,117
    1040:	06f60963          	beq	a2,a5,10b2 <vprintf+0x1a8>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
    1044:	07800793          	li	a5,120
    1048:	faf61ee3          	bne	a2,a5,1004 <vprintf+0xfa>
        printint(fd, va_arg(ap, uint64), 16, 0);
    104c:	008b8913          	add	s2,s7,8
    1050:	4681                	li	a3,0
    1052:	4641                	li	a2,16
    1054:	000bb583          	ld	a1,0(s7)
    1058:	855a                	mv	a0,s6
    105a:	e15ff0ef          	jal	e6e <printint>
        i += 2;
    105e:	2489                	addw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 16, 0);
    1060:	8bca                	mv	s7,s2
      state = 0;
    1062:	4981                	li	s3,0
        i += 2;
    1064:	bdc5                	j	f54 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
    1066:	008b8913          	add	s2,s7,8
    106a:	4685                	li	a3,1
    106c:	4629                	li	a2,10
    106e:	000bb583          	ld	a1,0(s7)
    1072:	855a                	mv	a0,s6
    1074:	dfbff0ef          	jal	e6e <printint>
        i += 2;
    1078:	2489                	addw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 1);
    107a:	8bca                	mv	s7,s2
      state = 0;
    107c:	4981                	li	s3,0
        i += 2;
    107e:	bdd9                	j	f54 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint32), 10, 0);
    1080:	008b8913          	add	s2,s7,8
    1084:	4681                	li	a3,0
    1086:	4629                	li	a2,10
    1088:	000be583          	lwu	a1,0(s7)
    108c:	855a                	mv	a0,s6
    108e:	de1ff0ef          	jal	e6e <printint>
    1092:	8bca                	mv	s7,s2
      state = 0;
    1094:	4981                	li	s3,0
    1096:	bd7d                	j	f54 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
    1098:	008b8913          	add	s2,s7,8
    109c:	4681                	li	a3,0
    109e:	4629                	li	a2,10
    10a0:	000bb583          	ld	a1,0(s7)
    10a4:	855a                	mv	a0,s6
    10a6:	dc9ff0ef          	jal	e6e <printint>
        i += 1;
    10aa:	2485                	addw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 0);
    10ac:	8bca                	mv	s7,s2
      state = 0;
    10ae:	4981                	li	s3,0
        i += 1;
    10b0:	b555                	j	f54 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
    10b2:	008b8913          	add	s2,s7,8
    10b6:	4681                	li	a3,0
    10b8:	4629                	li	a2,10
    10ba:	000bb583          	ld	a1,0(s7)
    10be:	855a                	mv	a0,s6
    10c0:	dafff0ef          	jal	e6e <printint>
        i += 2;
    10c4:	2489                	addw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 0);
    10c6:	8bca                	mv	s7,s2
      state = 0;
    10c8:	4981                	li	s3,0
        i += 2;
    10ca:	b569                	j	f54 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint32), 16, 0);
    10cc:	008b8913          	add	s2,s7,8
    10d0:	4681                	li	a3,0
    10d2:	4641                	li	a2,16
    10d4:	000be583          	lwu	a1,0(s7)
    10d8:	855a                	mv	a0,s6
    10da:	d95ff0ef          	jal	e6e <printint>
    10de:	8bca                	mv	s7,s2
      state = 0;
    10e0:	4981                	li	s3,0
    10e2:	bd8d                	j	f54 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 16, 0);
    10e4:	008b8913          	add	s2,s7,8
    10e8:	4681                	li	a3,0
    10ea:	4641                	li	a2,16
    10ec:	000bb583          	ld	a1,0(s7)
    10f0:	855a                	mv	a0,s6
    10f2:	d7dff0ef          	jal	e6e <printint>
        i += 1;
    10f6:	2485                	addw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 16, 0);
    10f8:	8bca                	mv	s7,s2
      state = 0;
    10fa:	4981                	li	s3,0
        i += 1;
    10fc:	bda1                	j	f54 <vprintf+0x4a>
    10fe:	e06a                	sd	s10,0(sp)
        printptr(fd, va_arg(ap, uint64));
    1100:	008b8d13          	add	s10,s7,8
    1104:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
    1108:	03000593          	li	a1,48
    110c:	855a                	mv	a0,s6
    110e:	d43ff0ef          	jal	e50 <putc>
  putc(fd, 'x');
    1112:	07800593          	li	a1,120
    1116:	855a                	mv	a0,s6
    1118:	d39ff0ef          	jal	e50 <putc>
    111c:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
    111e:	00000b97          	auipc	s7,0x0
    1122:	3bab8b93          	add	s7,s7,954 # 14d8 <digits>
    1126:	03c9d793          	srl	a5,s3,0x3c
    112a:	97de                	add	a5,a5,s7
    112c:	0007c583          	lbu	a1,0(a5)
    1130:	855a                	mv	a0,s6
    1132:	d1fff0ef          	jal	e50 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    1136:	0992                	sll	s3,s3,0x4
    1138:	397d                	addw	s2,s2,-1
    113a:	fe0916e3          	bnez	s2,1126 <vprintf+0x21c>
        printptr(fd, va_arg(ap, uint64));
    113e:	8bea                	mv	s7,s10
      state = 0;
    1140:	4981                	li	s3,0
    1142:	6d02                	ld	s10,0(sp)
    1144:	bd01                	j	f54 <vprintf+0x4a>
        putc(fd, va_arg(ap, uint32));
    1146:	008b8913          	add	s2,s7,8
    114a:	000bc583          	lbu	a1,0(s7)
    114e:	855a                	mv	a0,s6
    1150:	d01ff0ef          	jal	e50 <putc>
    1154:	8bca                	mv	s7,s2
      state = 0;
    1156:	4981                	li	s3,0
    1158:	bbf5                	j	f54 <vprintf+0x4a>
        if((s = va_arg(ap, char*)) == 0)
    115a:	008b8993          	add	s3,s7,8
    115e:	000bb903          	ld	s2,0(s7)
    1162:	00090f63          	beqz	s2,1180 <vprintf+0x276>
        for(; *s; s++)
    1166:	00094583          	lbu	a1,0(s2)
    116a:	c195                	beqz	a1,118e <vprintf+0x284>
          putc(fd, *s);
    116c:	855a                	mv	a0,s6
    116e:	ce3ff0ef          	jal	e50 <putc>
        for(; *s; s++)
    1172:	0905                	add	s2,s2,1
    1174:	00094583          	lbu	a1,0(s2)
    1178:	f9f5                	bnez	a1,116c <vprintf+0x262>
        if((s = va_arg(ap, char*)) == 0)
    117a:	8bce                	mv	s7,s3
      state = 0;
    117c:	4981                	li	s3,0
    117e:	bbd9                	j	f54 <vprintf+0x4a>
          s = "(null)";
    1180:	00000917          	auipc	s2,0x0
    1184:	32090913          	add	s2,s2,800 # 14a0 <malloc+0x214>
        for(; *s; s++)
    1188:	02800593          	li	a1,40
    118c:	b7c5                	j	116c <vprintf+0x262>
        if((s = va_arg(ap, char*)) == 0)
    118e:	8bce                	mv	s7,s3
      state = 0;
    1190:	4981                	li	s3,0
    1192:	b3c9                	j	f54 <vprintf+0x4a>
    1194:	64a6                	ld	s1,72(sp)
    1196:	79e2                	ld	s3,56(sp)
    1198:	7a42                	ld	s4,48(sp)
    119a:	7aa2                	ld	s5,40(sp)
    119c:	7b02                	ld	s6,32(sp)
    119e:	6be2                	ld	s7,24(sp)
    11a0:	6c42                	ld	s8,16(sp)
    11a2:	6ca2                	ld	s9,8(sp)
    }
  }
}
    11a4:	60e6                	ld	ra,88(sp)
    11a6:	6446                	ld	s0,80(sp)
    11a8:	6906                	ld	s2,64(sp)
    11aa:	6125                	add	sp,sp,96
    11ac:	8082                	ret

00000000000011ae <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
    11ae:	715d                	add	sp,sp,-80
    11b0:	ec06                	sd	ra,24(sp)
    11b2:	e822                	sd	s0,16(sp)
    11b4:	1000                	add	s0,sp,32
    11b6:	e010                	sd	a2,0(s0)
    11b8:	e414                	sd	a3,8(s0)
    11ba:	e818                	sd	a4,16(s0)
    11bc:	ec1c                	sd	a5,24(s0)
    11be:	03043023          	sd	a6,32(s0)
    11c2:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
    11c6:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
    11ca:	8622                	mv	a2,s0
    11cc:	d3fff0ef          	jal	f0a <vprintf>
}
    11d0:	60e2                	ld	ra,24(sp)
    11d2:	6442                	ld	s0,16(sp)
    11d4:	6161                	add	sp,sp,80
    11d6:	8082                	ret

00000000000011d8 <printf>:

void
printf(const char *fmt, ...)
{
    11d8:	711d                	add	sp,sp,-96
    11da:	ec06                	sd	ra,24(sp)
    11dc:	e822                	sd	s0,16(sp)
    11de:	1000                	add	s0,sp,32
    11e0:	e40c                	sd	a1,8(s0)
    11e2:	e810                	sd	a2,16(s0)
    11e4:	ec14                	sd	a3,24(s0)
    11e6:	f018                	sd	a4,32(s0)
    11e8:	f41c                	sd	a5,40(s0)
    11ea:	03043823          	sd	a6,48(s0)
    11ee:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
    11f2:	00840613          	add	a2,s0,8
    11f6:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
    11fa:	85aa                	mv	a1,a0
    11fc:	4505                	li	a0,1
    11fe:	d0dff0ef          	jal	f0a <vprintf>
}
    1202:	60e2                	ld	ra,24(sp)
    1204:	6442                	ld	s0,16(sp)
    1206:	6125                	add	sp,sp,96
    1208:	8082                	ret

000000000000120a <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    120a:	1141                	add	sp,sp,-16
    120c:	e422                	sd	s0,8(sp)
    120e:	0800                	add	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
    1210:	ff050693          	add	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1214:	00001797          	auipc	a5,0x1
    1218:	dfc7b783          	ld	a5,-516(a5) # 2010 <freep>
    121c:	a02d                	j	1246 <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
    121e:	4618                	lw	a4,8(a2)
    1220:	9f2d                	addw	a4,a4,a1
    1222:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
    1226:	6398                	ld	a4,0(a5)
    1228:	6310                	ld	a2,0(a4)
    122a:	a83d                	j	1268 <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    122c:	ff852703          	lw	a4,-8(a0)
    1230:	9f31                	addw	a4,a4,a2
    1232:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
    1234:	ff053683          	ld	a3,-16(a0)
    1238:	a091                	j	127c <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    123a:	6398                	ld	a4,0(a5)
    123c:	00e7e463          	bltu	a5,a4,1244 <free+0x3a>
    1240:	00e6ea63          	bltu	a3,a4,1254 <free+0x4a>
{
    1244:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1246:	fed7fae3          	bgeu	a5,a3,123a <free+0x30>
    124a:	6398                	ld	a4,0(a5)
    124c:	00e6e463          	bltu	a3,a4,1254 <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1250:	fee7eae3          	bltu	a5,a4,1244 <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
    1254:	ff852583          	lw	a1,-8(a0)
    1258:	6390                	ld	a2,0(a5)
    125a:	02059813          	sll	a6,a1,0x20
    125e:	01c85713          	srl	a4,a6,0x1c
    1262:	9736                	add	a4,a4,a3
    1264:	fae60de3          	beq	a2,a4,121e <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
    1268:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
    126c:	4790                	lw	a2,8(a5)
    126e:	02061593          	sll	a1,a2,0x20
    1272:	01c5d713          	srl	a4,a1,0x1c
    1276:	973e                	add	a4,a4,a5
    1278:	fae68ae3          	beq	a3,a4,122c <free+0x22>
    p->s.ptr = bp->s.ptr;
    127c:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
    127e:	00001717          	auipc	a4,0x1
    1282:	d8f73923          	sd	a5,-622(a4) # 2010 <freep>
}
    1286:	6422                	ld	s0,8(sp)
    1288:	0141                	add	sp,sp,16
    128a:	8082                	ret

000000000000128c <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    128c:	7139                	add	sp,sp,-64
    128e:	fc06                	sd	ra,56(sp)
    1290:	f822                	sd	s0,48(sp)
    1292:	f426                	sd	s1,40(sp)
    1294:	ec4e                	sd	s3,24(sp)
    1296:	0080                	add	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1298:	02051493          	sll	s1,a0,0x20
    129c:	9081                	srl	s1,s1,0x20
    129e:	04bd                	add	s1,s1,15
    12a0:	8091                	srl	s1,s1,0x4
    12a2:	0014899b          	addw	s3,s1,1
    12a6:	0485                	add	s1,s1,1
  if((prevp = freep) == 0){
    12a8:	00001517          	auipc	a0,0x1
    12ac:	d6853503          	ld	a0,-664(a0) # 2010 <freep>
    12b0:	c915                	beqz	a0,12e4 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    12b2:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    12b4:	4798                	lw	a4,8(a5)
    12b6:	08977a63          	bgeu	a4,s1,134a <malloc+0xbe>
    12ba:	f04a                	sd	s2,32(sp)
    12bc:	e852                	sd	s4,16(sp)
    12be:	e456                	sd	s5,8(sp)
    12c0:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
    12c2:	8a4e                	mv	s4,s3
    12c4:	0009871b          	sext.w	a4,s3
    12c8:	6685                	lui	a3,0x1
    12ca:	00d77363          	bgeu	a4,a3,12d0 <malloc+0x44>
    12ce:	6a05                	lui	s4,0x1
    12d0:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
    12d4:	004a1a1b          	sllw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    12d8:	00001917          	auipc	s2,0x1
    12dc:	d3890913          	add	s2,s2,-712 # 2010 <freep>
  if(p == SBRK_ERROR)
    12e0:	5afd                	li	s5,-1
    12e2:	a081                	j	1322 <malloc+0x96>
    12e4:	f04a                	sd	s2,32(sp)
    12e6:	e852                	sd	s4,16(sp)
    12e8:	e456                	sd	s5,8(sp)
    12ea:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
    12ec:	00001797          	auipc	a5,0x1
    12f0:	d9c78793          	add	a5,a5,-612 # 2088 <base>
    12f4:	00001717          	auipc	a4,0x1
    12f8:	d0f73e23          	sd	a5,-740(a4) # 2010 <freep>
    12fc:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
    12fe:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
    1302:	b7c1                	j	12c2 <malloc+0x36>
        prevp->s.ptr = p->s.ptr;
    1304:	6398                	ld	a4,0(a5)
    1306:	e118                	sd	a4,0(a0)
    1308:	a8a9                	j	1362 <malloc+0xd6>
  hp->s.size = nu;
    130a:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
    130e:	0541                	add	a0,a0,16
    1310:	efbff0ef          	jal	120a <free>
  return freep;
    1314:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
    1318:	c12d                	beqz	a0,137a <malloc+0xee>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    131a:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    131c:	4798                	lw	a4,8(a5)
    131e:	02977263          	bgeu	a4,s1,1342 <malloc+0xb6>
    if(p == freep)
    1322:	00093703          	ld	a4,0(s2)
    1326:	853e                	mv	a0,a5
    1328:	fef719e3          	bne	a4,a5,131a <malloc+0x8e>
  p = sbrk(nu * sizeof(Header));
    132c:	8552                	mv	a0,s4
    132e:	967ff0ef          	jal	c94 <sbrk>
  if(p == SBRK_ERROR)
    1332:	fd551ce3          	bne	a0,s5,130a <malloc+0x7e>
        return 0;
    1336:	4501                	li	a0,0
    1338:	7902                	ld	s2,32(sp)
    133a:	6a42                	ld	s4,16(sp)
    133c:	6aa2                	ld	s5,8(sp)
    133e:	6b02                	ld	s6,0(sp)
    1340:	a03d                	j	136e <malloc+0xe2>
    1342:	7902                	ld	s2,32(sp)
    1344:	6a42                	ld	s4,16(sp)
    1346:	6aa2                	ld	s5,8(sp)
    1348:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
    134a:	fae48de3          	beq	s1,a4,1304 <malloc+0x78>
        p->s.size -= nunits;
    134e:	4137073b          	subw	a4,a4,s3
    1352:	c798                	sw	a4,8(a5)
        p += p->s.size;
    1354:	02071693          	sll	a3,a4,0x20
    1358:	01c6d713          	srl	a4,a3,0x1c
    135c:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
    135e:	0137a423          	sw	s3,8(a5)
      freep = prevp;
    1362:	00001717          	auipc	a4,0x1
    1366:	caa73723          	sd	a0,-850(a4) # 2010 <freep>
      return (void*)(p + 1);
    136a:	01078513          	add	a0,a5,16
  }
}
    136e:	70e2                	ld	ra,56(sp)
    1370:	7442                	ld	s0,48(sp)
    1372:	74a2                	ld	s1,40(sp)
    1374:	69e2                	ld	s3,24(sp)
    1376:	6121                	add	sp,sp,64
    1378:	8082                	ret
    137a:	7902                	ld	s2,32(sp)
    137c:	6a42                	ld	s4,16(sp)
    137e:	6aa2                	ld	s5,8(sp)
    1380:	6b02                	ld	s6,0(sp)
    1382:	b7f5                	j	136e <malloc+0xe2>
