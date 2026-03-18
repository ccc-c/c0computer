
user/_mywget:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <decode_qname>:
}

// Decode a DNS name
static void
decode_qname(char *qn)
{
       0:	1141                	add	sp,sp,-16
       2:	e422                	sd	s0,8(sp)
       4:	0800                	add	s0,sp,16
  while(*qn != '\0') {
       6:	00054683          	lbu	a3,0(a0)
       a:	c69d                	beqz	a3,38 <decode_qname+0x38>
      break;
    for(int i = 0; i < l; i++) {
      *qn = *(qn+1);
      qn++;
    }
    *qn++ = '.';
       c:	02e00593          	li	a1,46
      10:	a801                	j	20 <decode_qname+0x20>
      12:	0605                	add	a2,a2,1
      14:	9532                	add	a0,a0,a2
      16:	00b68023          	sb	a1,0(a3)
  while(*qn != '\0') {
      1a:	0016c683          	lbu	a3,1(a3)
      1e:	ce89                	beqz	a3,38 <decode_qname+0x38>
    for(int i = 0; i < l; i++) {
      20:	0006861b          	sext.w	a2,a3
      24:	96aa                	add	a3,a3,a0
{
      26:	87aa                	mv	a5,a0
      *qn = *(qn+1);
      28:	0017c703          	lbu	a4,1(a5)
      2c:	00e78023          	sb	a4,0(a5)
      qn++;
      30:	0785                	add	a5,a5,1
    for(int i = 0; i < l; i++) {
      32:	fed79be3          	bne	a5,a3,28 <decode_qname+0x28>
      36:	bff1                	j	12 <decode_qname+0x12>
  }
}
      38:	6422                	ld	s0,8(sp)
      3a:	0141                	add	sp,sp,16
      3c:	8082                	ret

000000000000003e <hexdump>:
hexdump (void *data, uint size) {
      3e:	7119                	add	sp,sp,-128
      40:	fc86                	sd	ra,120(sp)
      42:	f8a2                	sd	s0,112(sp)
      44:	f0ca                	sd	s2,96(sp)
      46:	ecce                	sd	s3,88(sp)
      48:	0100                	add	s0,sp,128
      4a:	892a                	mv	s2,a0
      4c:	89ae                	mv	s3,a1
  printf("+------+-------------------------------------------------+------------------+\n");
      4e:	00001517          	auipc	a0,0x1
      52:	7ea50513          	add	a0,a0,2026 # 1838 <malloc+0x106>
      56:	00001097          	auipc	ra,0x1
      5a:	45c080e7          	jalr	1116(ra) # 14b2 <printf>
  for (offset = 0; offset < size; offset += 16) {
      5e:	18098a63          	beqz	s3,1f2 <hexdump+0x1b4>
      62:	f4a6                	sd	s1,104(sp)
      64:	e8d2                	sd	s4,80(sp)
      66:	e4d6                	sd	s5,72(sp)
      68:	e0da                	sd	s6,64(sp)
      6a:	fc5e                	sd	s7,56(sp)
      6c:	f862                	sd	s8,48(sp)
      6e:	f466                	sd	s9,40(sp)
      70:	f06a                	sd	s10,32(sp)
      72:	ec6e                	sd	s11,24(sp)
      74:	8d4a                	mv	s10,s2
      76:	0941                	add	s2,s2,16
      78:	fff9879b          	addw	a5,s3,-1
      7c:	0047d79b          	srlw	a5,a5,0x4
      80:	0792                	sll	a5,a5,0x4
      82:	97ca                	add	a5,a5,s2
      84:	f8f43423          	sd	a5,-120(s0)
      88:	4d81                	li	s11,0
    if (offset <= 0x000f) printf("0");
      8a:	4b3d                	li	s6,15
      if(offset + index < (int)size) {
      8c:	2981                	sext.w	s3,s3
        printf("%x ", 0xff & src[offset + index]);
      8e:	00002b97          	auipc	s7,0x2
      92:	81ab8b93          	add	s7,s7,-2022 # 18a8 <malloc+0x176>
      96:	aa19                	j	1ac <hexdump+0x16e>
    if (offset <= 0x0fff) printf("0");
      98:	00002517          	auipc	a0,0x2
      9c:	80050513          	add	a0,a0,-2048 # 1898 <malloc+0x166>
      a0:	00001097          	auipc	ra,0x1
      a4:	412080e7          	jalr	1042(ra) # 14b2 <printf>
    if (offset <= 0x00ff) printf("0");
      a8:	0ff00793          	li	a5,255
      ac:	11b7cb63          	blt	a5,s11,1c2 <hexdump+0x184>
      b0:	00001517          	auipc	a0,0x1
      b4:	7e850513          	add	a0,a0,2024 # 1898 <malloc+0x166>
      b8:	00001097          	auipc	ra,0x1
      bc:	3fa080e7          	jalr	1018(ra) # 14b2 <printf>
    if (offset <= 0x000f) printf("0");
      c0:	11bb4163          	blt	s6,s11,1c2 <hexdump+0x184>
      c4:	00001517          	auipc	a0,0x1
      c8:	7d450513          	add	a0,a0,2004 # 1898 <malloc+0x166>
      cc:	00001097          	auipc	ra,0x1
      d0:	3e6080e7          	jalr	998(ra) # 14b2 <printf>
      d4:	a0fd                	j	1c2 <hexdump+0x184>
        printf("%x ", 0xff & src[offset + index]);
      d6:	000ac583          	lbu	a1,0(s5)
      da:	855e                	mv	a0,s7
      dc:	00001097          	auipc	ra,0x1
      e0:	3d6080e7          	jalr	982(ra) # 14b2 <printf>
    for (index = 0; index < 16; index++) {
      e4:	0485                	add	s1,s1,1
      e6:	03248d63          	beq	s1,s2,120 <hexdump+0xe2>
      if(offset + index < (int)size) {
      ea:	009c07bb          	addw	a5,s8,s1
      ee:	0337d063          	bge	a5,s3,10e <hexdump+0xd0>
        if (src[offset + index] <= 0x0f) printf("0");
      f2:	8aa6                	mv	s5,s1
      f4:	0004c783          	lbu	a5,0(s1)
      f8:	fcfb6fe3          	bltu	s6,a5,d6 <hexdump+0x98>
      fc:	00001517          	auipc	a0,0x1
     100:	79c50513          	add	a0,a0,1948 # 1898 <malloc+0x166>
     104:	00001097          	auipc	ra,0x1
     108:	3ae080e7          	jalr	942(ra) # 14b2 <printf>
     10c:	b7e9                	j	d6 <hexdump+0x98>
        printf("   ");
     10e:	00001517          	auipc	a0,0x1
     112:	7a250513          	add	a0,a0,1954 # 18b0 <malloc+0x17e>
     116:	00001097          	auipc	ra,0x1
     11a:	39c080e7          	jalr	924(ra) # 14b2 <printf>
     11e:	b7d9                	j	e4 <hexdump+0xa6>
    printf("| ");
     120:	00001517          	auipc	a0,0x1
     124:	77050513          	add	a0,a0,1904 # 1890 <malloc+0x15e>
     128:	00001097          	auipc	ra,0x1
     12c:	38a080e7          	jalr	906(ra) # 14b2 <printf>
     130:	84ea                	mv	s1,s10
        if(isascii(src[offset + index]) && isprint(src[offset + index])) {
     132:	05e00a93          	li	s5,94
          printf(".");
     136:	00001c97          	auipc	s9,0x1
     13a:	78ac8c93          	add	s9,s9,1930 # 18c0 <malloc+0x18e>
          printf("%c", src[offset + index]);
     13e:	00001c17          	auipc	s8,0x1
     142:	77ac0c13          	add	s8,s8,1914 # 18b8 <malloc+0x186>
     146:	a809                	j	158 <hexdump+0x11a>
          printf(".");
     148:	8566                	mv	a0,s9
     14a:	00001097          	auipc	ra,0x1
     14e:	368080e7          	jalr	872(ra) # 14b2 <printf>
    for(index = 0; index < 16; index++) {
     152:	0485                	add	s1,s1,1
     154:	03248d63          	beq	s1,s2,18e <hexdump+0x150>
      if(offset + index < (int)size) {
     158:	014487bb          	addw	a5,s1,s4
     15c:	0337d063          	bge	a5,s3,17c <hexdump+0x13e>
        if(isascii(src[offset + index]) && isprint(src[offset + index])) {
     160:	0004c583          	lbu	a1,0(s1)
     164:	fe05879b          	addw	a5,a1,-32
     168:	0ff7f793          	zext.b	a5,a5
     16c:	fcfaeee3          	bltu	s5,a5,148 <hexdump+0x10a>
          printf("%c", src[offset + index]);
     170:	8562                	mv	a0,s8
     172:	00001097          	auipc	ra,0x1
     176:	340080e7          	jalr	832(ra) # 14b2 <printf>
     17a:	bfe1                	j	152 <hexdump+0x114>
        printf(" ");
     17c:	00001517          	auipc	a0,0x1
     180:	74c50513          	add	a0,a0,1868 # 18c8 <malloc+0x196>
     184:	00001097          	auipc	ra,0x1
     188:	32e080e7          	jalr	814(ra) # 14b2 <printf>
     18c:	b7d9                	j	152 <hexdump+0x114>
    printf(" |\n");
     18e:	00001517          	auipc	a0,0x1
     192:	74250513          	add	a0,a0,1858 # 18d0 <malloc+0x19e>
     196:	00001097          	auipc	ra,0x1
     19a:	31c080e7          	jalr	796(ra) # 14b2 <printf>
  for (offset = 0; offset < size; offset += 16) {
     19e:	2dc1                	addw	s11,s11,16
     1a0:	0941                	add	s2,s2,16
     1a2:	0d41                	add	s10,s10,16
     1a4:	f8843783          	ld	a5,-120(s0)
     1a8:	02fd0c63          	beq	s10,a5,1e0 <hexdump+0x1a2>
    printf("| ");
     1ac:	00001517          	auipc	a0,0x1
     1b0:	6e450513          	add	a0,a0,1764 # 1890 <malloc+0x15e>
     1b4:	00001097          	auipc	ra,0x1
     1b8:	2fe080e7          	jalr	766(ra) # 14b2 <printf>
    if (offset <= 0x0fff) printf("0");
     1bc:	6785                	lui	a5,0x1
     1be:	ecfdcde3          	blt	s11,a5,98 <hexdump+0x5a>
    printf("%x | ", offset);
     1c2:	85ee                	mv	a1,s11
     1c4:	00001517          	auipc	a0,0x1
     1c8:	6dc50513          	add	a0,a0,1756 # 18a0 <malloc+0x16e>
     1cc:	00001097          	auipc	ra,0x1
     1d0:	2e6080e7          	jalr	742(ra) # 14b2 <printf>
     1d4:	84ea                	mv	s1,s10
     1d6:	41ad8c3b          	subw	s8,s11,s10
     1da:	000c0a1b          	sext.w	s4,s8
     1de:	b731                	j	ea <hexdump+0xac>
     1e0:	74a6                	ld	s1,104(sp)
     1e2:	6a46                	ld	s4,80(sp)
     1e4:	6aa6                	ld	s5,72(sp)
     1e6:	6b06                	ld	s6,64(sp)
     1e8:	7be2                	ld	s7,56(sp)
     1ea:	7c42                	ld	s8,48(sp)
     1ec:	7ca2                	ld	s9,40(sp)
     1ee:	7d02                	ld	s10,32(sp)
     1f0:	6de2                	ld	s11,24(sp)
  printf("+------+-------------------------------------------------+------------------+\n");
     1f2:	00001517          	auipc	a0,0x1
     1f6:	64650513          	add	a0,a0,1606 # 1838 <malloc+0x106>
     1fa:	00001097          	auipc	ra,0x1
     1fe:	2b8080e7          	jalr	696(ra) # 14b2 <printf>
}
     202:	70e6                	ld	ra,120(sp)
     204:	7446                	ld	s0,112(sp)
     206:	7906                	ld	s2,96(sp)
     208:	69e6                	ld	s3,88(sp)
     20a:	6109                	add	sp,sp,128
     20c:	8082                	ret

000000000000020e <connect_server>:
  return ip;
} 

int
connect_server(uint64 ip, uint16 port)
{
     20e:	7139                	add	sp,sp,-64
     210:	fc06                	sd	ra,56(sp)
     212:	f822                	sd	s0,48(sp)
     214:	f426                	sd	s1,40(sp)
     216:	f04a                	sd	s2,32(sp)
     218:	ec4e                	sd	s3,24(sp)
     21a:	0080                	add	s0,sp,64
     21c:	84aa                	mv	s1,a0
     21e:	892e                	mv	s2,a1
  int fd;
  if ((fd = socket(AF_INET, SOCK_STREAM, 0)) < 0) {
     220:	4601                	li	a2,0
     222:	4585                	li	a1,1
     224:	4501                	li	a0,0
     226:	00001097          	auipc	ra,0x1
     22a:	efc080e7          	jalr	-260(ra) # 1122 <socket>
     22e:	06054263          	bltz	a0,292 <connect_server+0x84>
     232:	89aa                	mv	s3,a0
    exit(0);
  }
  // printf("socket create success\n");

  struct sockaddr_in addr;
  addr.sin_family = AF_INET;
     234:	fc041423          	sh	zero,-56(s0)
          ((val & 0xff00U) >> 8));
}

static inline uint32 bswapl(uint32 val)
{
  return (((val & 0x000000ffUL) << 24) |
     238:	0184979b          	sllw	a5,s1,0x18
          ((val & 0x0000ff00UL) << 8) |
          ((val & 0x00ff0000UL) >> 8) |
          ((val & 0xff000000UL) >> 24));
     23c:	0184d71b          	srlw	a4,s1,0x18
          ((val & 0x00ff0000UL) >> 8) |
     240:	8fd9                	or	a5,a5,a4
          ((val & 0x0000ff00UL) << 8) |
     242:	0084971b          	sllw	a4,s1,0x8
     246:	00ff06b7          	lui	a3,0xff0
     24a:	8f75                	and	a4,a4,a3
          ((val & 0x00ff0000UL) >> 8) |
     24c:	8fd9                	or	a5,a5,a4
     24e:	0084d49b          	srlw	s1,s1,0x8
     252:	6741                	lui	a4,0x10
     254:	f0070713          	add	a4,a4,-256 # ff00 <__BSS_END__+0xbb78>
     258:	8cf9                	and	s1,s1,a4
     25a:	8fc5                	or	a5,a5,s1
  addr.sin_addr = htonl(ip);
     25c:	fcf42623          	sw	a5,-52(s0)
  return (((val & 0x00ffU) << 8) |
     260:	0089179b          	sllw	a5,s2,0x8
     264:	0089591b          	srlw	s2,s2,0x8
     268:	0127e7b3          	or	a5,a5,s2
  addr.sin_port = htons(port);
     26c:	fcf41523          	sh	a5,-54(s0)
  if (connect(fd, (struct sockaddr *)&addr, sizeof(addr)) < 0) {
     270:	4621                	li	a2,8
     272:	fc840593          	add	a1,s0,-56
     276:	00001097          	auipc	ra,0x1
     27a:	ed0080e7          	jalr	-304(ra) # 1146 <connect>
     27e:	02054763          	bltz	a0,2ac <connect_server+0x9e>
  }

  // printf("connect success\n");

  return fd;
}
     282:	854e                	mv	a0,s3
     284:	70e2                	ld	ra,56(sp)
     286:	7442                	ld	s0,48(sp)
     288:	74a2                	ld	s1,40(sp)
     28a:	7902                	ld	s2,32(sp)
     28c:	69e2                	ld	s3,24(sp)
     28e:	6121                	add	sp,sp,64
     290:	8082                	ret
    printf("Error: socket error !!!\n");
     292:	00001517          	auipc	a0,0x1
     296:	64650513          	add	a0,a0,1606 # 18d8 <malloc+0x1a6>
     29a:	00001097          	auipc	ra,0x1
     29e:	218080e7          	jalr	536(ra) # 14b2 <printf>
    exit(0);
     2a2:	4501                	li	a0,0
     2a4:	00001097          	auipc	ra,0x1
     2a8:	dd6080e7          	jalr	-554(ra) # 107a <exit>
    printf("Error: connect error!!!\n");
     2ac:	00001517          	auipc	a0,0x1
     2b0:	64c50513          	add	a0,a0,1612 # 18f8 <malloc+0x1c6>
     2b4:	00001097          	auipc	ra,0x1
     2b8:	1fe080e7          	jalr	510(ra) # 14b2 <printf>
    exit(0);
     2bc:	4501                	li	a0,0
     2be:	00001097          	auipc	ra,0x1
     2c2:	dbc080e7          	jalr	-580(ra) # 107a <exit>

00000000000002c6 <read_if_content_len>:
  return buf + lb;
}

void
read_if_content_len(int fd, char *s, int rn)
{
     2c6:	7139                	add	sp,sp,-64
     2c8:	fc06                	sd	ra,56(sp)
     2ca:	f822                	sd	s0,48(sp)
     2cc:	f426                	sd	s1,40(sp)
     2ce:	f04a                	sd	s2,32(sp)
     2d0:	e852                	sd	s4,16(sp)
     2d2:	0080                	add	s0,sp,64
     2d4:	8a2a                	mv	s4,a0
     2d6:	84b2                	mv	s1,a2
  int n;
  int total = content_len;
     2d8:	00002917          	auipc	s2,0x2
     2dc:	88c92903          	lw	s2,-1908(s2) # 1b64 <content_len>
  write(1, s, total < rn ? total : rn);
     2e0:	864a                	mv	a2,s2
     2e2:	0124d363          	bge	s1,s2,2e8 <read_if_content_len+0x22>
     2e6:	8626                	mv	a2,s1
     2e8:	2601                	sext.w	a2,a2
     2ea:	4505                	li	a0,1
     2ec:	00001097          	auipc	ra,0x1
     2f0:	dae080e7          	jalr	-594(ra) # 109a <write>
  total -= rn;
     2f4:	4099093b          	subw	s2,s2,s1
  if (total == 0)
     2f8:	04090863          	beqz	s2,348 <read_if_content_len+0x82>
     2fc:	ec4e                	sd	s3,24(sp)
     2fe:	e456                	sd	s5,8(sp)
    return;

  while ((n = read(fd, buf, BUFSZ)) > 0) {
     300:	6a8d                	lui	s5,0x3
     302:	800a8a93          	add	s5,s5,-2048 # 2800 <__global_pointer$+0x49c>
     306:	00002997          	auipc	s3,0x2
     30a:	87298993          	add	s3,s3,-1934 # 1b78 <buf>
     30e:	a821                	j	326 <read_if_content_len+0x60>
    write(1, buf, total < n ? total : n);
     310:	2601                	sext.w	a2,a2
     312:	85ce                	mv	a1,s3
     314:	4505                	li	a0,1
     316:	00001097          	auipc	ra,0x1
     31a:	d84080e7          	jalr	-636(ra) # 109a <write>
    total -= n;
     31e:	4099093b          	subw	s2,s2,s1
    if (total == 0)
     322:	02090a63          	beqz	s2,356 <read_if_content_len+0x90>
  while ((n = read(fd, buf, BUFSZ)) > 0) {
     326:	8656                	mv	a2,s5
     328:	85ce                	mv	a1,s3
     32a:	8552                	mv	a0,s4
     32c:	00001097          	auipc	ra,0x1
     330:	d66080e7          	jalr	-666(ra) # 1092 <read>
     334:	84aa                	mv	s1,a0
     336:	00a05763          	blez	a0,344 <read_if_content_len+0x7e>
    write(1, buf, total < n ? total : n);
     33a:	864a                	mv	a2,s2
     33c:	fd24dae3          	bge	s1,s2,310 <read_if_content_len+0x4a>
     340:	8626                	mv	a2,s1
     342:	b7f9                	j	310 <read_if_content_len+0x4a>
     344:	69e2                	ld	s3,24(sp)
     346:	6aa2                	ld	s5,8(sp)
      break;
  }
}
     348:	70e2                	ld	ra,56(sp)
     34a:	7442                	ld	s0,48(sp)
     34c:	74a2                	ld	s1,40(sp)
     34e:	7902                	ld	s2,32(sp)
     350:	6a42                	ld	s4,16(sp)
     352:	6121                	add	sp,sp,64
     354:	8082                	ret
     356:	69e2                	ld	s3,24(sp)
     358:	6aa2                	ld	s5,8(sp)
     35a:	b7fd                	j	348 <read_if_content_len+0x82>

000000000000035c <hex2int>:

int
hex2int(char ch)
{
     35c:	1141                	add	sp,sp,-16
     35e:	e422                	sd	s0,8(sp)
     360:	0800                	add	s0,sp,16
  if (ch >= '0' && ch <= '9')
     362:	fd05079b          	addw	a5,a0,-48
     366:	0ff7f793          	zext.b	a5,a5
     36a:	4725                	li	a4,9
     36c:	00f76763          	bltu	a4,a5,37a <hex2int+0x1e>
    return ch - '0';
     370:	fd05051b          	addw	a0,a0,-48
  else
    return (ch - 'a') + 10;
}
     374:	6422                	ld	s0,8(sp)
     376:	0141                	add	sp,sp,16
     378:	8082                	ret
    return (ch - 'a') + 10;
     37a:	fa95051b          	addw	a0,a0,-87
     37e:	bfdd                	j	374 <hex2int+0x18>

0000000000000380 <read_if_chunked>:

void
read_if_chunked(int fd, char *s, int rn)
{
  if (rn == 0) return;
     380:	10060363          	beqz	a2,486 <read_if_chunked+0x106>
{
     384:	711d                	add	sp,sp,-96
     386:	ec86                	sd	ra,88(sp)
     388:	e8a2                	sd	s0,80(sp)
     38a:	e4a6                	sd	s1,72(sp)
     38c:	e0ca                	sd	s2,64(sp)
     38e:	fc4e                	sd	s3,56(sp)
     390:	f852                	sd	s4,48(sp)
     392:	f456                	sd	s5,40(sp)
     394:	f05a                	sd	s6,32(sp)
     396:	ec5e                	sd	s7,24(sp)
     398:	e862                	sd	s8,16(sp)
     39a:	e466                	sd	s9,8(sp)
     39c:	e06a                	sd	s10,0(sp)
     39e:	1080                	add	s0,sp,96
     3a0:	8b2a                	mv	s6,a0
     3a2:	8cae                	mv	s9,a1
     3a4:	8d32                	mv	s10,a2
    // printf("dn: %d\n", dn);
    // printf("rn: %d\n", rn);
    if (rn <= dn - 2) {
      write(1, s, rn);
      dn -= rn;
      rn = read(fd, buf, BUFSZ);
     3a6:	6b8d                	lui	s7,0x3
     3a8:	800b8b93          	add	s7,s7,-2048 # 2800 <__global_pointer$+0x49c>
     3ac:	00001a97          	auipc	s5,0x1
     3b0:	7cca8a93          	add	s5,s5,1996 # 1b78 <buf>
    int i = 0;
     3b4:	4a01                	li	s4,0
      if (s[i] == '\r')
     3b6:	49b5                	li	s3,13
     3b8:	a835                	j	3f4 <read_if_chunked+0x74>
    i += 2;
     3ba:	2909                	addw	s2,s2,2
     3bc:	00090c1b          	sext.w	s8,s2
    s += i;
     3c0:	9c66                	add	s8,s8,s9
    rn -= i;
     3c2:	412d093b          	subw	s2,s10,s2
    if (rn <= dn - 2) {
     3c6:	fff4879b          	addw	a5,s1,-1
     3ca:	06f94d63          	blt	s2,a5,444 <read_if_chunked+0xc4>
      s = buf;
    } 
    // printf("dn: %d\n", dn);
    // printf("rn: %d\n", rn);

    write(1, s, dn);
     3ce:	8626                	mv	a2,s1
     3d0:	85e2                	mv	a1,s8
     3d2:	4505                	li	a0,1
     3d4:	00001097          	auipc	ra,0x1
     3d8:	cc6080e7          	jalr	-826(ra) # 109a <write>
    s += dn;
     3dc:	9c26                	add	s8,s8,s1
    rn -= dn;
     3de:	4099093b          	subw	s2,s2,s1

    // hexdump(s, 10);
    if (s[0] != '\r') {
     3e2:	000c4783          	lbu	a5,0(s8)
     3e6:	03379d63          	bne	a5,s3,420 <read_if_chunked+0xa0>
      printf("\nchunked error!!!\n");
      exit(0);
    }

    s += 2;
     3ea:	002c0c93          	add	s9,s8,2
    rn -= 2;
     3ee:	ffe90d1b          	addw	s10,s2,-2

    if (dn == 0)
     3f2:	cca5                	beqz	s1,46a <read_if_chunked+0xea>
    while (i < rn) {
     3f4:	05a05363          	blez	s10,43a <read_if_chunked+0xba>
     3f8:	8c66                	mv	s8,s9
    int i = 0;
     3fa:	8952                	mv	s2,s4
    int dn = 0;
     3fc:	84d2                	mv	s1,s4
      if (s[i] == '\r')
     3fe:	000c4503          	lbu	a0,0(s8)
     402:	fb350ce3          	beq	a0,s3,3ba <read_if_chunked+0x3a>
      dn = dn * 16 + hex2int(s[i]);
     406:	0044949b          	sllw	s1,s1,0x4
     40a:	00000097          	auipc	ra,0x0
     40e:	f52080e7          	jalr	-174(ra) # 35c <hex2int>
     412:	9ca9                	addw	s1,s1,a0
      i++;
     414:	2905                	addw	s2,s2,1
    while (i < rn) {
     416:	0c05                	add	s8,s8,1
     418:	ff2d13e3          	bne	s10,s2,3fe <read_if_chunked+0x7e>
     41c:	896a                	mv	s2,s10
     41e:	bf71                	j	3ba <read_if_chunked+0x3a>
      printf("\nchunked error!!!\n");
     420:	00001517          	auipc	a0,0x1
     424:	4f850513          	add	a0,a0,1272 # 1918 <malloc+0x1e6>
     428:	00001097          	auipc	ra,0x1
     42c:	08a080e7          	jalr	138(ra) # 14b2 <printf>
      exit(0);
     430:	4501                	li	a0,0
     432:	00001097          	auipc	ra,0x1
     436:	c48080e7          	jalr	-952(ra) # 107a <exit>
    s += i;
     43a:	002c8c13          	add	s8,s9,2
    rn -= i;
     43e:	ffed091b          	addw	s2,s10,-2
    int dn = 0;
     442:	4481                	li	s1,0
      write(1, s, rn);
     444:	864a                	mv	a2,s2
     446:	85e2                	mv	a1,s8
     448:	4505                	li	a0,1
     44a:	00001097          	auipc	ra,0x1
     44e:	c50080e7          	jalr	-944(ra) # 109a <write>
      dn -= rn;
     452:	412484bb          	subw	s1,s1,s2
      rn = read(fd, buf, BUFSZ);
     456:	865e                	mv	a2,s7
     458:	85d6                	mv	a1,s5
     45a:	855a                	mv	a0,s6
     45c:	00001097          	auipc	ra,0x1
     460:	c36080e7          	jalr	-970(ra) # 1092 <read>
     464:	892a                	mv	s2,a0
      s = buf;
     466:	8c56                	mv	s8,s5
     468:	b79d                	j	3ce <read_if_chunked+0x4e>
      break;
  }
}
     46a:	60e6                	ld	ra,88(sp)
     46c:	6446                	ld	s0,80(sp)
     46e:	64a6                	ld	s1,72(sp)
     470:	6906                	ld	s2,64(sp)
     472:	79e2                	ld	s3,56(sp)
     474:	7a42                	ld	s4,48(sp)
     476:	7aa2                	ld	s5,40(sp)
     478:	7b02                	ld	s6,32(sp)
     47a:	6be2                	ld	s7,24(sp)
     47c:	6c42                	ld	s8,16(sp)
     47e:	6ca2                	ld	s9,8(sp)
     480:	6d02                	ld	s10,0(sp)
     482:	6125                	add	sp,sp,96
     484:	8082                	ret
     486:	8082                	ret

0000000000000488 <read_util_fin>:

void
read_util_fin(int fd, char *s, int rn)
{
     488:	7179                	add	sp,sp,-48
     48a:	f406                	sd	ra,40(sp)
     48c:	f022                	sd	s0,32(sp)
     48e:	ec26                	sd	s1,24(sp)
     490:	e84a                	sd	s2,16(sp)
     492:	e44e                	sd	s3,8(sp)
     494:	1800                	add	s0,sp,48
     496:	89aa                	mv	s3,a0
  write(1, s, rn);
     498:	4505                	li	a0,1
     49a:	00001097          	auipc	ra,0x1
     49e:	c00080e7          	jalr	-1024(ra) # 109a <write>
  int n;
  while ((n = read(fd, buf, BUFSZ)) > 0) {
     4a2:	690d                	lui	s2,0x3
     4a4:	80090913          	add	s2,s2,-2048 # 2800 <__global_pointer$+0x49c>
     4a8:	00001497          	auipc	s1,0x1
     4ac:	6d048493          	add	s1,s1,1744 # 1b78 <buf>
     4b0:	a039                	j	4be <read_util_fin+0x36>
    write(1, buf, n);
     4b2:	85a6                	mv	a1,s1
     4b4:	4505                	li	a0,1
     4b6:	00001097          	auipc	ra,0x1
     4ba:	be4080e7          	jalr	-1052(ra) # 109a <write>
  while ((n = read(fd, buf, BUFSZ)) > 0) {
     4be:	864a                	mv	a2,s2
     4c0:	85a6                	mv	a1,s1
     4c2:	854e                	mv	a0,s3
     4c4:	00001097          	auipc	ra,0x1
     4c8:	bce080e7          	jalr	-1074(ra) # 1092 <read>
     4cc:	862a                	mv	a2,a0
     4ce:	fea042e3          	bgtz	a0,4b2 <read_util_fin+0x2a>
  }
}
     4d2:	70a2                	ld	ra,40(sp)
     4d4:	7402                	ld	s0,32(sp)
     4d6:	64e2                	ld	s1,24(sp)
     4d8:	6942                	ld	s2,16(sp)
     4da:	69a2                	ld	s3,8(sp)
     4dc:	6145                	add	sp,sp,48
     4de:	8082                	ret

00000000000004e0 <main>:


int main(int argc, char *argv[])
{
     4e0:	81010113          	add	sp,sp,-2032
     4e4:	7e113423          	sd	ra,2024(sp)
     4e8:	7e813023          	sd	s0,2016(sp)
     4ec:	7c913c23          	sd	s1,2008(sp)
     4f0:	7d213823          	sd	s2,2000(sp)
     4f4:	7d313423          	sd	s3,1992(sp)
     4f8:	7d413023          	sd	s4,1984(sp)
     4fc:	7b513c23          	sd	s5,1976(sp)
     500:	7b613823          	sd	s6,1968(sp)
     504:	7b713423          	sd	s7,1960(sp)
     508:	7b813023          	sd	s8,1952(sp)
     50c:	79913c23          	sd	s9,1944(sp)
     510:	79a13823          	sd	s10,1936(sp)
     514:	79b13423          	sd	s11,1928(sp)
     518:	7f010413          	add	s0,sp,2032
     51c:	da010113          	add	sp,sp,-608
  if (argc < 2) {
     520:	4785                	li	a5,1
     522:	02a7d963          	bge	a5,a0,554 <main+0x74>
     526:	892e                	mv	s2,a1
    exit(0);
  }
  
  uint32 ip = 0;
  uint16 port = 80;
  if (strlen(argv[1]) < 5) {
     528:	6588                	ld	a0,8(a1)
     52a:	00001097          	auipc	ra,0x1
     52e:	8fe080e7          	jalr	-1794(ra) # e28 <strlen>
     532:	2501                	sext.w	a0,a0
     534:	4791                	li	a5,4
     536:	02a7ec63          	bltu	a5,a0,56e <main+0x8e>
    printf("Error: the url is too short\n");
     53a:	00001517          	auipc	a0,0x1
     53e:	41650513          	add	a0,a0,1046 # 1950 <malloc+0x21e>
     542:	00001097          	auipc	ra,0x1
     546:	f70080e7          	jalr	-144(ra) # 14b2 <printf>
    exit(0);
     54a:	4501                	li	a0,0
     54c:	00001097          	auipc	ra,0x1
     550:	b2e080e7          	jalr	-1234(ra) # 107a <exit>
    printf("usge: mywget url\n");
     554:	00001517          	auipc	a0,0x1
     558:	3e450513          	add	a0,a0,996 # 1938 <malloc+0x206>
     55c:	00001097          	auipc	ra,0x1
     560:	f56080e7          	jalr	-170(ra) # 14b2 <printf>
    exit(0);
     564:	4501                	li	a0,0
     566:	00001097          	auipc	ra,0x1
     56a:	b14080e7          	jalr	-1260(ra) # 107a <exit>
  }

  char oargv[100] = {0};
     56e:	06400613          	li	a2,100
     572:	4581                	li	a1,0
     574:	f2840513          	add	a0,s0,-216
     578:	00001097          	auipc	ra,0x1
     57c:	908080e7          	jalr	-1784(ra) # e80 <memset>
  memmove(oargv, argv[1], strlen(argv[1]));
     580:	00893483          	ld	s1,8(s2)
     584:	8526                	mv	a0,s1
     586:	00001097          	auipc	ra,0x1
     58a:	8a2080e7          	jalr	-1886(ra) # e28 <strlen>
     58e:	0005061b          	sext.w	a2,a0
     592:	85a6                	mv	a1,s1
     594:	f2840513          	add	a0,s0,-216
     598:	00001097          	auipc	ra,0x1
     59c:	a30080e7          	jalr	-1488(ra) # fc8 <memmove>

  char *path = "/";
  char host[100] = {0};
     5a0:	06400613          	li	a2,100
     5a4:	4581                	li	a1,0
     5a6:	ec040513          	add	a0,s0,-320
     5aa:	00001097          	auipc	ra,0x1
     5ae:	8d6080e7          	jalr	-1834(ra) # e80 <memset>
  int i = 0;
  while (oargv[i] && oargv[i] != '/') i++;
     5b2:	f2844783          	lbu	a5,-216(s0)
     5b6:	c395                	beqz	a5,5da <main+0xfa>
     5b8:	f2940713          	add	a4,s0,-215
  int i = 0;
     5bc:	4601                	li	a2,0
  while (oargv[i] && oargv[i] != '/') i++;
     5be:	02f00693          	li	a3,47
     5c2:	6ad78a63          	beq	a5,a3,c76 <main+0x796>
     5c6:	2605                	addw	a2,a2,1
     5c8:	0705                	add	a4,a4,1
     5ca:	fff74783          	lbu	a5,-1(a4)
     5ce:	fbf5                	bnez	a5,5c2 <main+0xe2>
  char *path = "/";
     5d0:	00001497          	auipc	s1,0x1
     5d4:	36048493          	add	s1,s1,864 # 1930 <malloc+0x1fe>
     5d8:	a55d                	j	c7e <main+0x79e>
  int i = 0;
     5da:	4601                	li	a2,0
  char *path = "/";
     5dc:	00001497          	auipc	s1,0x1
     5e0:	35448493          	add	s1,s1,852 # 1930 <malloc+0x1fe>
     5e4:	ad69                	j	c7e <main+0x79e>
  // printf("host: %s\n", host);
  // printf("argv[1]: %s\n", argv[1]);

  if (argv[1][0] >= '0' && argv[1][0] <= '9') {
    // ip:port
    int p[5] = {0};
     5e6:	a0043823          	sd	zero,-1520(s0)
     5ea:	a0043c23          	sd	zero,-1512(s0)
     5ee:	a2042023          	sw	zero,-1504(s0)
    int index = 0;
    int i = 0;
    int n = 0;
    while (argv[1][i]) {
     5f2:	ec140693          	add	a3,s0,-319
    int n = 0;
     5f6:	4601                	li	a2,0
    int index = 0;
     5f8:	4581                	li	a1,0
      if (is_digit(argv[1][i])) {
     5fa:	4525                	li	a0,9
        n = n * 10 + (argv[1][i] - '0');
      } else if (argv[1][i] == '.') {
     5fc:	02e00813          	li	a6,46
        p[index++] = n;
        n = 0;
      } else if (argv[1][i] == ':') {
     600:	03a00893          	li	a7,58
        if (index < 3) {
     604:	4e09                	li	t3,2
          printf("Error: IP:PORT format is wrong\n");
          exit(0);
        } else {
          p[index++] = n;
          n = 0;
     606:	4301                	li	t1,0
     608:	a809                	j	61a <main+0x13a>
      } else if (argv[1][i] == '.') {
     60a:	03078863          	beq	a5,a6,63a <main+0x15a>
      } else if (argv[1][i] == ':') {
     60e:	05178063          	beq	a5,a7,64e <main+0x16e>
    while (argv[1][i]) {
     612:	0685                	add	a3,a3,1 # ff0001 <__BSS_END__+0xfebc79>
     614:	fff6c783          	lbu	a5,-1(a3)
     618:	c7a5                	beqz	a5,680 <main+0x1a0>
  return ch >= '0' && ch <= '9';
     61a:	fd07871b          	addw	a4,a5,-48 # fd0 <memmove+0x8>
      if (is_digit(argv[1][i])) {
     61e:	0ff77713          	zext.b	a4,a4
     622:	fee564e3          	bltu	a0,a4,60a <main+0x12a>
        n = n * 10 + (argv[1][i] - '0');
     626:	0026171b          	sllw	a4,a2,0x2
     62a:	9f31                	addw	a4,a4,a2
     62c:	0017171b          	sllw	a4,a4,0x1
     630:	fd07879b          	addw	a5,a5,-48
     634:	00e7863b          	addw	a2,a5,a4
     638:	bfe9                	j	612 <main+0x132>
        p[index++] = n;
     63a:	00259793          	sll	a5,a1,0x2
     63e:	f9078793          	add	a5,a5,-112
     642:	97a2                	add	a5,a5,s0
     644:	a8c7a023          	sw	a2,-1408(a5)
     648:	2585                	addw	a1,a1,1
        n = 0;
     64a:	861a                	mv	a2,t1
     64c:	b7d9                	j	612 <main+0x132>
        if (index < 3) {
     64e:	00be5c63          	bge	t3,a1,666 <main+0x186>
          p[index++] = n;
     652:	00259793          	sll	a5,a1,0x2
     656:	f9078793          	add	a5,a5,-112
     65a:	97a2                	add	a5,a5,s0
     65c:	a8c7a023          	sw	a2,-1408(a5)
     660:	2585                	addw	a1,a1,1
          n = 0;
     662:	861a                	mv	a2,t1
     664:	b77d                	j	612 <main+0x132>
          printf("Error: IP:PORT format is wrong\n");
     666:	00001517          	auipc	a0,0x1
     66a:	30a50513          	add	a0,a0,778 # 1970 <malloc+0x23e>
     66e:	00001097          	auipc	ra,0x1
     672:	e44080e7          	jalr	-444(ra) # 14b2 <printf>
          exit(0);
     676:	4501                	li	a0,0
     678:	00001097          	auipc	ra,0x1
     67c:	a02080e7          	jalr	-1534(ra) # 107a <exit>
        }
      }
      i++;
    }

    p[index++] = n;
     680:	0015879b          	addw	a5,a1,1
     684:	058a                	sll	a1,a1,0x2
     686:	f9058713          	add	a4,a1,-112
     68a:	008705b3          	add	a1,a4,s0
     68e:	a8c5a023          	sw	a2,-1408(a1)
    if (index < 4) {
     692:	470d                	li	a4,3
     694:	04f75063          	bge	a4,a5,6d4 <main+0x1f4>
      printf("Error: IP:PORT format is wrong\n");
      exit(0);
    } else if (index == 4) {
     698:	4711                	li	a4,4
     69a:	04e78a63          	beq	a5,a4,6ee <main+0x20e>
      ip = MAKE_IP_ADDR(p[0], p[1], p[2], p[3]);
    } else if (index == 5) {
     69e:	4715                	li	a4,5
     6a0:	06e79f63          	bne	a5,a4,71e <main+0x23e>
      ip = MAKE_IP_ADDR(p[0], p[1], p[2], p[3]);
     6a4:	a1042983          	lw	s3,-1520(s0)
     6a8:	0189999b          	sllw	s3,s3,0x18
     6ac:	a1442783          	lw	a5,-1516(s0)
     6b0:	0107979b          	sllw	a5,a5,0x10
     6b4:	00f9e9b3          	or	s3,s3,a5
     6b8:	a1c42783          	lw	a5,-1508(s0)
     6bc:	00f9e9b3          	or	s3,s3,a5
     6c0:	a1842783          	lw	a5,-1512(s0)
     6c4:	0087979b          	sllw	a5,a5,0x8
     6c8:	00f9e9b3          	or	s3,s3,a5
     6cc:	2981                	sext.w	s3,s3
      port = p[4];
     6ce:	a2045583          	lhu	a1,-1504(s0)
     6d2:	a69d                	j	a38 <main+0x558>
      printf("Error: IP:PORT format is wrong\n");
     6d4:	00001517          	auipc	a0,0x1
     6d8:	29c50513          	add	a0,a0,668 # 1970 <malloc+0x23e>
     6dc:	00001097          	auipc	ra,0x1
     6e0:	dd6080e7          	jalr	-554(ra) # 14b2 <printf>
      exit(0);
     6e4:	4501                	li	a0,0
     6e6:	00001097          	auipc	ra,0x1
     6ea:	994080e7          	jalr	-1644(ra) # 107a <exit>
      ip = MAKE_IP_ADDR(p[0], p[1], p[2], p[3]);
     6ee:	a1042983          	lw	s3,-1520(s0)
     6f2:	0189999b          	sllw	s3,s3,0x18
     6f6:	a1442783          	lw	a5,-1516(s0)
     6fa:	0107979b          	sllw	a5,a5,0x10
     6fe:	00f9e9b3          	or	s3,s3,a5
     702:	a1c42783          	lw	a5,-1508(s0)
     706:	00f9e9b3          	or	s3,s3,a5
     70a:	a1842783          	lw	a5,-1512(s0)
     70e:	0087979b          	sllw	a5,a5,0x8
     712:	00f9e9b3          	or	s3,s3,a5
     716:	2981                	sext.w	s3,s3
  uint16 port = 80;
     718:	05000593          	li	a1,80
     71c:	ae31                	j	a38 <main+0x558>
    } else {
      printf("Error: IP:PORT format is wrong\n");
     71e:	00001517          	auipc	a0,0x1
     722:	25250513          	add	a0,a0,594 # 1970 <malloc+0x23e>
     726:	00001097          	auipc	ra,0x1
     72a:	d8c080e7          	jalr	-628(ra) # 14b2 <printf>
      exit(0);
     72e:	4501                	li	a0,0
     730:	00001097          	auipc	ra,0x1
     734:	94a080e7          	jalr	-1718(ra) # 107a <exit>
    argv[1][i] = 0;
    i++;
    int n = 0;
    while (argv[1][i]) {
      if (!is_digit(argv[1][i])) {
        printf("Error: IP:PORT format is wrong\n");
     738:	00001517          	auipc	a0,0x1
     73c:	23850513          	add	a0,a0,568 # 1970 <malloc+0x23e>
     740:	00001097          	auipc	ra,0x1
     744:	d72080e7          	jalr	-654(ra) # 14b2 <printf>
        exit(0);
     748:	4501                	li	a0,0
     74a:	00001097          	auipc	ra,0x1
     74e:	930080e7          	jalr	-1744(ra) # 107a <exit>
      }
      n = n * 10 + (argv[1][i] - '0');
      i++;
    }

    port = n == 0 ? 80 : n;
     752:	05000913          	li	s2,80
     756:	ab5d                	j	d0c <main+0x82c>
    while (argv[1][i]) {
     758:	05000913          	li	s2,80
     75c:	ab45                	j	d0c <main+0x82c>
    fprintf(2, "ping: uconnect() failed\n");
     75e:	00001597          	auipc	a1,0x1
     762:	23a58593          	add	a1,a1,570 # 1998 <malloc+0x266>
     766:	4509                	li	a0,2
     768:	00001097          	auipc	ra,0x1
     76c:	d1c080e7          	jalr	-740(ra) # 1484 <fprintf>
    // printf("name: %s\n", argv[1]);
    ip = dns2ip(argv[1]);
    if (ip == 0) {
      printf("Error: The domain name resolution error\n");
     770:	00001517          	auipc	a0,0x1
     774:	2c850513          	add	a0,a0,712 # 1a38 <malloc+0x306>
     778:	00001097          	auipc	ra,0x1
     77c:	d3a080e7          	jalr	-710(ra) # 14b2 <printf>
      exit(0);
     780:	4501                	li	a0,0
     782:	00001097          	auipc	ra,0x1
     786:	8f8080e7          	jalr	-1800(ra) # 107a <exit>
        *qn++ = *d;
     78a:	0705                	add	a4,a4,1
     78c:	0007c683          	lbu	a3,0(a5)
     790:	fed70fa3          	sb	a3,-1(a4)
      for(char *d = l; d < c; d++) {
     794:	0785                	add	a5,a5,1
     796:	ff37eae3          	bltu	a5,s3,78a <main+0x2aa>
     79a:	87ce                	mv	a5,s3
     79c:	8a62                	mv	s4,s8
     79e:	0179e463          	bltu	s3,s7,7a6 <main+0x2c6>
     7a2:	41798a33          	sub	s4,s3,s7
     7a6:	9a32                	add	s4,s4,a2
      l = c+1; // skip .
     7a8:	00178b93          	add	s7,a5,1
  for(char *c = host; c < host+strlen(host)+1; c++) {
     7ac:	0985                	add	s3,s3,1
     7ae:	7cfd                	lui	s9,0xfffff
     7b0:	5b8c8793          	add	a5,s9,1464 # fffffffffffff5b8 <__BSS_END__+0xffffffffffffb230>
     7b4:	97a2                	add	a5,a5,s0
     7b6:	6388                	ld	a0,0(a5)
     7b8:	00000097          	auipc	ra,0x0
     7bc:	670080e7          	jalr	1648(ra) # e28 <strlen>
     7c0:	02051793          	sll	a5,a0,0x20
     7c4:	9381                	srl	a5,a5,0x20
     7c6:	0785                	add	a5,a5,1
     7c8:	5b8c8713          	add	a4,s9,1464
     7cc:	9722                	add	a4,a4,s0
     7ce:	6318                	ld	a4,0(a4)
     7d0:	97ba                	add	a5,a5,a4
     7d2:	00f9ff63          	bgeu	s3,a5,7f0 <main+0x310>
    if(*c == '.') {
     7d6:	0009c783          	lbu	a5,0(s3)
     7da:	fd5799e3          	bne	a5,s5,7ac <main+0x2cc>
      *qn++ = (char) (c-l);
     7de:	001a0613          	add	a2,s4,1
     7e2:	417987b3          	sub	a5,s3,s7
     7e6:	00fa0023          	sb	a5,0(s4)
      for(char *d = l; d < c; d++) {
     7ea:	87de                	mv	a5,s7
      *qn++ = (char) (c-l);
     7ec:	8732                	mv	a4,a2
      for(char *d = l; d < c; d++) {
     7ee:	b765                	j	796 <main+0x2b6>
  *qn = '\0';
     7f0:	000a0023          	sb	zero,0(s4)
  len += strlen(qname) + 1;
     7f4:	77fd                	lui	a5,0xfffff
     7f6:	62878793          	add	a5,a5,1576 # fffffffffffff628 <__BSS_END__+0xffffffffffffb2a0>
     7fa:	97a2                	add	a5,a5,s0
     7fc:	7afd                	lui	s5,0xfffff
     7fe:	5b8a8713          	add	a4,s5,1464 # fffffffffffff5b8 <__BSS_END__+0xffffffffffffb230>
     802:	9722                	add	a4,a4,s0
     804:	e31c                	sd	a5,0(a4)
     806:	631c                	ld	a5,0(a4)
     808:	00c78993          	add	s3,a5,12
     80c:	854e                	mv	a0,s3
     80e:	00000097          	auipc	ra,0x0
     812:	61a080e7          	jalr	1562(ra) # e28 <strlen>
     816:	00050a1b          	sext.w	s4,a0
  struct dns_question *h = (struct dns_question *) (qname+strlen(qname)+1);
     81a:	854e                	mv	a0,s3
     81c:	00000097          	auipc	ra,0x0
     820:	60c080e7          	jalr	1548(ra) # e28 <strlen>
     824:	02051793          	sll	a5,a0,0x20
     828:	9381                	srl	a5,a5,0x20
     82a:	0785                	add	a5,a5,1
     82c:	97ce                	add	a5,a5,s3
  h->qtype = htons(0x1);
     82e:	00078023          	sb	zero,0(a5)
     832:	4705                	li	a4,1
     834:	00e780a3          	sb	a4,1(a5)
  h->qclass = htons(0x1);
     838:	00078123          	sb	zero,2(a5)
     83c:	00e781a3          	sb	a4,3(a5)
  if(write(fd, obuf, len) < 0){
     840:	011a061b          	addw	a2,s4,17
     844:	5b8a8793          	add	a5,s5,1464
     848:	97a2                	add	a5,a5,s0
     84a:	638c                	ld	a1,0(a5)
     84c:	855a                	mv	a0,s6
     84e:	00001097          	auipc	ra,0x1
     852:	84c080e7          	jalr	-1972(ra) # 109a <write>
     856:	04054163          	bltz	a0,898 <main+0x3b8>
  int cc = read(fd, ibuf, sizeof(ibuf));
     85a:	3e800613          	li	a2,1000
     85e:	a1040593          	add	a1,s0,-1520
     862:	855a                	mv	a0,s6
     864:	00001097          	auipc	ra,0x1
     868:	82e080e7          	jalr	-2002(ra) # 1092 <read>
  if(cc < 0){
     86c:	04054063          	bltz	a0,8ac <main+0x3cc>
  if(!hdr->qr) {
     870:	a1240783          	lb	a5,-1518(s0)
     874:	0407d663          	bgez	a5,8c0 <main+0x3e0>
  if(hdr->id != htons(6828)) {
     878:	a1045703          	lhu	a4,-1520(s0)
     87c:	0007069b          	sext.w	a3,a4
     880:	67ad                	lui	a5,0xb
     882:	c1a78793          	add	a5,a5,-998 # ac1a <__BSS_END__+0x6892>
     886:	06f69463          	bne	a3,a5,8ee <main+0x40e>
  if(hdr->rcode != 0) {
     88a:	a1344783          	lbu	a5,-1517(s0)
     88e:	8bbd                	and	a5,a5,15
     890:	efbd                	bnez	a5,90e <main+0x42e>
  for(int i =0; i < ntohs(hdr->qdcount); i++) {
     892:	4a01                	li	s4,0
  len = sizeof(struct dns);
     894:	49b1                	li	s3,12
     896:	a855                	j	94a <main+0x46a>
    fprintf(2, "dns: send() failed\n");
     898:	00001597          	auipc	a1,0x1
     89c:	12058593          	add	a1,a1,288 # 19b8 <malloc+0x286>
     8a0:	4509                	li	a0,2
     8a2:	00001097          	auipc	ra,0x1
     8a6:	be2080e7          	jalr	-1054(ra) # 1484 <fprintf>
    return 0;
     8aa:	b5d9                	j	770 <main+0x290>
    fprintf(2, "dns: recv() failed\n");
     8ac:	00001597          	auipc	a1,0x1
     8b0:	12458593          	add	a1,a1,292 # 19d0 <malloc+0x29e>
     8b4:	4509                	li	a0,2
     8b6:	00001097          	auipc	ra,0x1
     8ba:	bce080e7          	jalr	-1074(ra) # 1484 <fprintf>
    return 0;
     8be:	bd4d                	j	770 <main+0x290>
     8c0:	a1045783          	lhu	a5,-1520(s0)
     8c4:	0087971b          	sllw	a4,a5,0x8
     8c8:	83a1                	srl	a5,a5,0x8
     8ca:	00e7e5b3          	or	a1,a5,a4
    printf("Not a DNS response for %d\n", ntohs(hdr->id));
     8ce:	15c2                	sll	a1,a1,0x30
     8d0:	91c1                	srl	a1,a1,0x30
     8d2:	00001517          	auipc	a0,0x1
     8d6:	11650513          	add	a0,a0,278 # 19e8 <malloc+0x2b6>
     8da:	00001097          	auipc	ra,0x1
     8de:	bd8080e7          	jalr	-1064(ra) # 14b2 <printf>
  close(fd);
     8e2:	855a                	mv	a0,s6
     8e4:	00000097          	auipc	ra,0x0
     8e8:	7be080e7          	jalr	1982(ra) # 10a2 <close>
    if (ip == 0) {
     8ec:	b551                	j	770 <main+0x290>
     8ee:	0087159b          	sllw	a1,a4,0x8
     8f2:	0087571b          	srlw	a4,a4,0x8
     8f6:	8dd9                	or	a1,a1,a4
    printf("DNS wrong id: %d\n", ntohs(hdr->id));
     8f8:	15c2                	sll	a1,a1,0x30
     8fa:	91c1                	srl	a1,a1,0x30
     8fc:	00001517          	auipc	a0,0x1
     900:	10c50513          	add	a0,a0,268 # 1a08 <malloc+0x2d6>
     904:	00001097          	auipc	ra,0x1
     908:	bae080e7          	jalr	-1106(ra) # 14b2 <printf>
    return 0;
     90c:	bfd9                	j	8e2 <main+0x402>
    printf("DNS rcode error: %x\n", hdr->rcode);
     90e:	a1344583          	lbu	a1,-1517(s0)
     912:	89bd                	and	a1,a1,15
     914:	00001517          	auipc	a0,0x1
     918:	10c50513          	add	a0,a0,268 # 1a20 <malloc+0x2ee>
     91c:	00001097          	auipc	ra,0x1
     920:	b96080e7          	jalr	-1130(ra) # 14b2 <printf>
    return 0;
     924:	bf7d                	j	8e2 <main+0x402>
    char *qn = (char *) (ibuf+len);
     926:	a1040793          	add	a5,s0,-1520
     92a:	01378ab3          	add	s5,a5,s3
    decode_qname(qn);
     92e:	8556                	mv	a0,s5
     930:	fffff097          	auipc	ra,0xfffff
     934:	6d0080e7          	jalr	1744(ra) # 0 <decode_qname>
    len += strlen(qn)+1;
     938:	8556                	mv	a0,s5
     93a:	00000097          	auipc	ra,0x0
     93e:	4ee080e7          	jalr	1262(ra) # e28 <strlen>
    len += sizeof(struct dns_question);
     942:	2995                	addw	s3,s3,5
     944:	00a989bb          	addw	s3,s3,a0
  for(int i =0; i < ntohs(hdr->qdcount); i++) {
     948:	2a05                	addw	s4,s4,1
     94a:	a1445783          	lhu	a5,-1516(s0)
     94e:	0087971b          	sllw	a4,a5,0x8
     952:	83a1                	srl	a5,a5,0x8
     954:	8fd9                	or	a5,a5,a4
     956:	17c2                	sll	a5,a5,0x30
     958:	93c1                	srl	a5,a5,0x30
     95a:	fcfa46e3          	blt	s4,a5,926 <main+0x446>
  for (int i = 0; i < ntohs(hdr->ancount); i++) {
     95e:	4a01                	li	s4,0
    if((int) qn[0] > 63) {  // compression?
     960:	03f00b93          	li	s7,63
    if (ntohs(d->type) == ARECORD) {
     964:	10000a93          	li	s5,256
     968:	a08d                	j	9ca <main+0x4ea>
      decode_qname(qn);
     96a:	8562                	mv	a0,s8
     96c:	fffff097          	auipc	ra,0xfffff
     970:	694080e7          	jalr	1684(ra) # 0 <decode_qname>
      len += strlen(qn)+1;
     974:	8562                	mv	a0,s8
     976:	00000097          	auipc	ra,0x0
     97a:	4b2080e7          	jalr	1202(ra) # e28 <strlen>
     97e:	0019879b          	addw	a5,s3,1
     982:	9fa9                	addw	a5,a5,a0
    struct dns_data *d = (struct dns_data *)(ibuf + len);
     984:	a1040713          	add	a4,s0,-1520
     988:	00f706b3          	add	a3,a4,a5
    len += sizeof(struct dns_data);
     98c:	00a7871b          	addw	a4,a5,10
     990:	0007059b          	sext.w	a1,a4
    if (ntohs(d->type) == ARECORD) {
     994:	0006c603          	lbu	a2,0(a3)
     998:	0016c783          	lbu	a5,1(a3)
     99c:	07a2                	sll	a5,a5,0x8
     99e:	8fd1                	or	a5,a5,a2
     9a0:	05578a63          	beq	a5,s5,9f4 <main+0x514>
      len += ntohs(d->len);
     9a4:	0086c603          	lbu	a2,8(a3)
     9a8:	0096c783          	lbu	a5,9(a3)
     9ac:	07a2                	sll	a5,a5,0x8
     9ae:	8fd1                	or	a5,a5,a2
     9b0:	0087969b          	sllw	a3,a5,0x8
     9b4:	0087d993          	srl	s3,a5,0x8
     9b8:	00d9e9b3          	or	s3,s3,a3
     9bc:	0109999b          	sllw	s3,s3,0x10
     9c0:	0109d99b          	srlw	s3,s3,0x10
     9c4:	00e989bb          	addw	s3,s3,a4
  for (int i = 0; i < ntohs(hdr->ancount); i++) {
     9c8:	2a05                	addw	s4,s4,1
     9ca:	a1645783          	lhu	a5,-1514(s0)
     9ce:	0087971b          	sllw	a4,a5,0x8
     9d2:	83a1                	srl	a5,a5,0x8
     9d4:	8fd9                	or	a5,a5,a4
     9d6:	17c2                	sll	a5,a5,0x30
     9d8:	93c1                	srl	a5,a5,0x30
     9da:	f0fa54e3          	bge	s4,a5,8e2 <main+0x402>
    char *qn = (char *) (ibuf + len);
     9de:	a1040793          	add	a5,s0,-1520
     9e2:	01378c33          	add	s8,a5,s3
    if((int) qn[0] > 63) {  // compression?
     9e6:	000c4783          	lbu	a5,0(s8)
     9ea:	f8fbf0e3          	bgeu	s7,a5,96a <main+0x48a>
      len += 2;
     9ee:	0029879b          	addw	a5,s3,2
     9f2:	bf49                	j	984 <main+0x4a4>
      uint8 *ip = (ibuf+len);
     9f4:	a1040793          	add	a5,s0,-1520
     9f8:	97ae                	add	a5,a5,a1
      return MAKE_IP_ADDR(ip[0], ip[1], ip[2], ip[3]);
     9fa:	0007c983          	lbu	s3,0(a5)
     9fe:	0189999b          	sllw	s3,s3,0x18
     a02:	0017c703          	lbu	a4,1(a5)
     a06:	0107171b          	sllw	a4,a4,0x10
     a0a:	00e9e9b3          	or	s3,s3,a4
     a0e:	0037c703          	lbu	a4,3(a5)
     a12:	00e9e9b3          	or	s3,s3,a4
     a16:	0027c783          	lbu	a5,2(a5)
     a1a:	0087979b          	sllw	a5,a5,0x8
     a1e:	00f9e9b3          	or	s3,s3,a5
     a22:	2981                	sext.w	s3,s3
  close(fd);
     a24:	855a                	mv	a0,s6
     a26:	00000097          	auipc	ra,0x0
     a2a:	67c080e7          	jalr	1660(ra) # 10a2 <close>
    if (ip == 0) {
     a2e:	03091593          	sll	a1,s2,0x30
     a32:	91c1                	srl	a1,a1,0x30
     a34:	d2098ee3          	beqz	s3,770 <main+0x290>
    }
  }
  
  int fd = connect_server(ip, port);
     a38:	02099513          	sll	a0,s3,0x20
     a3c:	9101                	srl	a0,a0,0x20
     a3e:	fffff097          	auipc	ra,0xfffff
     a42:	7d0080e7          	jalr	2000(ra) # 20e <connect_server>
     a46:	8baa                	mv	s7,a0

  char msg[200] = {0};
     a48:	0c800613          	li	a2,200
     a4c:	4581                	li	a1,0
     a4e:	df840513          	add	a0,s0,-520
     a52:	00000097          	auipc	ra,0x0
     a56:	42e080e7          	jalr	1070(ra) # e80 <memset>
  snprintf(msg, 200, "GET %s HTTP/1.1\r\nHost: %s\r\n\r\n", path, host);
     a5a:	ec040713          	add	a4,s0,-320
     a5e:	86a6                	mv	a3,s1
     a60:	00001617          	auipc	a2,0x1
     a64:	00860613          	add	a2,a2,8 # 1a68 <malloc+0x336>
     a68:	0c800593          	li	a1,200
     a6c:	df840513          	add	a0,s0,-520
     a70:	00001097          	auipc	ra,0x1
     a74:	a78080e7          	jalr	-1416(ra) # 14e8 <snprintf>

  if (write(fd, msg, strlen(msg)) < 0) {
     a78:	df840513          	add	a0,s0,-520
     a7c:	00000097          	auipc	ra,0x0
     a80:	3ac080e7          	jalr	940(ra) # e28 <strlen>
     a84:	0005061b          	sext.w	a2,a0
     a88:	df840593          	add	a1,s0,-520
     a8c:	855e                	mv	a0,s7
     a8e:	00000097          	auipc	ra,0x0
     a92:	60c080e7          	jalr	1548(ra) # 109a <write>
     a96:	04054563          	bltz	a0,ae0 <main+0x600>
  int n = read(fd, buf, BUFSZ);
     a9a:	660d                	lui	a2,0x3
     a9c:	80060613          	add	a2,a2,-2048 # 2800 <__global_pointer$+0x49c>
     aa0:	00001597          	auipc	a1,0x1
     aa4:	0d858593          	add	a1,a1,216 # 1b78 <buf>
     aa8:	855e                	mv	a0,s7
     aaa:	00000097          	auipc	ra,0x0
     aae:	5e8080e7          	jalr	1512(ra) # 1092 <read>
     ab2:	89aa                	mv	s3,a0
  if (n < 0) return 0;
     ab4:	06054e63          	bltz	a0,b30 <main+0x650>
  for (;i < n; i++) {
     ab8:	04a05163          	blez	a0,afa <main+0x61a>
  int i = 0, lb = 0;
     abc:	4481                	li	s1,0
     abe:	4901                	li	s2,0
    if (buf[i] == '\r') {
     ac0:	00001a97          	auipc	s5,0x1
     ac4:	0b8a8a93          	add	s5,s5,184 # 1b78 <buf>
     ac8:	4b35                	li	s6,13
      memset(line, 0, 300);
     aca:	a1040a13          	add	s4,s0,-1520
  if (strlen(line) < 17)
     ace:	4d41                	li	s10,16
        content_len = cl;
     ad0:	00001d97          	auipc	s11,0x1
     ad4:	094d8d93          	add	s11,s11,148 # 1b64 <content_len>
  while (line[i] == cstr[i]) i++;
     ad8:	4c85                	li	s9,1
     ada:	414c8cbb          	subw	s9,s9,s4
     ade:	a8c9                	j	bb0 <main+0x6d0>
    printf("Error: send HTTP GET");
     ae0:	00001517          	auipc	a0,0x1
     ae4:	fa850513          	add	a0,a0,-88 # 1a88 <malloc+0x356>
     ae8:	00001097          	auipc	ra,0x1
     aec:	9ca080e7          	jalr	-1590(ra) # 14b2 <printf>
    exit(0);
     af0:	4501                	li	a0,0
     af2:	00000097          	auipc	ra,0x0
     af6:	588080e7          	jalr	1416(ra) # 107a <exit>
  int i = 0, lb = 0;
     afa:	4481                	li	s1,0
  *rn = n - lb;
     afc:	4099863b          	subw	a2,s3,s1
  return buf + lb;
     b00:	00001797          	auipc	a5,0x1
     b04:	07878793          	add	a5,a5,120 # 1b78 <buf>
     b08:	00f485b3          	add	a1,s1,a5
  }
  
  int rn = 0;
  char *d = parse_http_header(fd, &rn);
  
  if (content_len == 0) {
     b0c:	00001797          	auipc	a5,0x1
     b10:	0587a783          	lw	a5,88(a5) # 1b64 <content_len>
     b14:	c38d                	beqz	a5,b36 <main+0x656>
    printf("Content-Length is zero\n");
    exit(0);
  }
  if (content_len > 0) {
     b16:	02f04d63          	bgtz	a5,b50 <main+0x670>
    read_if_content_len(fd, d, rn);
  } else if (chunked) {
     b1a:	00001797          	auipc	a5,0x1
     b1e:	04e7a783          	lw	a5,78(a5) # 1b68 <chunked>
     b22:	c3a9                	beqz	a5,b64 <main+0x684>
    read_if_chunked(fd, d, rn);
     b24:	855e                	mv	a0,s7
     b26:	00000097          	auipc	ra,0x0
     b2a:	85a080e7          	jalr	-1958(ra) # 380 <read_if_chunked>
     b2e:	a035                	j	b5a <main+0x67a>
  int rn = 0;
     b30:	4601                	li	a2,0
  if (n < 0) return 0;
     b32:	4581                	li	a1,0
     b34:	bfe1                	j	b0c <main+0x62c>
    printf("Content-Length is zero\n");
     b36:	00001517          	auipc	a0,0x1
     b3a:	fa250513          	add	a0,a0,-94 # 1ad8 <malloc+0x3a6>
     b3e:	00001097          	auipc	ra,0x1
     b42:	974080e7          	jalr	-1676(ra) # 14b2 <printf>
    exit(0);
     b46:	4501                	li	a0,0
     b48:	00000097          	auipc	ra,0x0
     b4c:	532080e7          	jalr	1330(ra) # 107a <exit>
    read_if_content_len(fd, d, rn);
     b50:	855e                	mv	a0,s7
     b52:	fffff097          	auipc	ra,0xfffff
     b56:	774080e7          	jalr	1908(ra) # 2c6 <read_if_content_len>
  } else {
    read_util_fin(fd, d, rn);
  }

  exit(0);
     b5a:	4501                	li	a0,0
     b5c:	00000097          	auipc	ra,0x0
     b60:	51e080e7          	jalr	1310(ra) # 107a <exit>
    read_util_fin(fd, d, rn);
     b64:	855e                	mv	a0,s7
     b66:	00000097          	auipc	ra,0x0
     b6a:	922080e7          	jalr	-1758(ra) # 488 <read_util_fin>
     b6e:	b7f5                	j	b5a <main+0x67a>
  return !strcmp(line, "Transfer-Encoding: chunked");
     b70:	00001597          	auipc	a1,0x1
     b74:	f4858593          	add	a1,a1,-184 # 1ab8 <malloc+0x386>
     b78:	a1040513          	add	a0,s0,-1520
     b7c:	00000097          	auipc	ra,0x0
     b80:	280080e7          	jalr	640(ra) # dfc <strcmp>
     b84:	84aa                	mv	s1,a0
      if (is_chunked(line))
     b86:	e969                	bnez	a0,c58 <main+0x778>
        chunked = 1;
     b88:	4785                	li	a5,1
     b8a:	00001717          	auipc	a4,0x1
     b8e:	fde70713          	add	a4,a4,-34 # 1b68 <chunked>
     b92:	c31c                	sw	a5,0(a4)
      if (cl >= 0)
     b94:	0004c463          	bltz	s1,b9c <main+0x6bc>
        content_len = cl;
     b98:	009da023          	sw	s1,0(s11)
      i++; // \n
     b9c:	0019079b          	addw	a5,s2,1
      lb = i + 1; // \r\n
     ba0:	0029049b          	addw	s1,s2,2
      if (line_n == 0) {
     ba4:	f40c0ce3          	beqz	s8,afc <main+0x61c>
      i++; // \n
     ba8:	893e                	mv	s2,a5
  for (;i < n; i++) {
     baa:	2905                	addw	s2,s2,1
     bac:	f53958e3          	bge	s2,s3,afc <main+0x61c>
    if (buf[i] == '\r') {
     bb0:	012a87b3          	add	a5,s5,s2
     bb4:	0007c783          	lbu	a5,0(a5)
     bb8:	ff6799e3          	bne	a5,s6,baa <main+0x6ca>
      memset(line, 0, 300);
     bbc:	12c00613          	li	a2,300
     bc0:	4581                	li	a1,0
     bc2:	8552                	mv	a0,s4
     bc4:	00000097          	auipc	ra,0x0
     bc8:	2bc080e7          	jalr	700(ra) # e80 <memset>
      int line_n = i - lb;
     bcc:	40990c3b          	subw	s8,s2,s1
      memmove(line, buf + lb, line_n);
     bd0:	8662                	mv	a2,s8
     bd2:	009a85b3          	add	a1,s5,s1
     bd6:	8552                	mv	a0,s4
     bd8:	00000097          	auipc	ra,0x0
     bdc:	3f0080e7          	jalr	1008(ra) # fc8 <memmove>
  if (strlen(line) < 17)
     be0:	8552                	mv	a0,s4
     be2:	00000097          	auipc	ra,0x0
     be6:	246080e7          	jalr	582(ra) # e28 <strlen>
     bea:	2501                	sext.w	a0,a0
     bec:	06ad7863          	bgeu	s10,a0,c5c <main+0x77c>
  while (line[i] == cstr[i]) i++;
     bf0:	a1044703          	lbu	a4,-1520(s0)
     bf4:	04300793          	li	a5,67
     bf8:	06f71263          	bne	a4,a5,c5c <main+0x77c>
     bfc:	00001697          	auipc	a3,0x1
     c00:	ea568693          	add	a3,a3,-347 # 1aa1 <malloc+0x36f>
     c04:	8752                	mv	a4,s4
     c06:	00174583          	lbu	a1,1(a4)
     c0a:	0006c603          	lbu	a2,0(a3)
     c0e:	87ba                	mv	a5,a4
     c10:	0705                	add	a4,a4,1
     c12:	0685                	add	a3,a3,1
     c14:	fec589e3          	beq	a1,a2,c06 <main+0x726>
  if (!cstr[i]) {
     c18:	e231                	bnez	a2,c5c <main+0x77c>
    while (line[i]) {
     c1a:	00fc86bb          	addw	a3,s9,a5
     c1e:	96d2                	add	a3,a3,s4
     c20:	0006c703          	lbu	a4,0(a3)
     c24:	d731                	beqz	a4,b70 <main+0x690>
    int len = 0;
     c26:	4481                	li	s1,0
      len = len * 10 + (line[i++] - '0');
     c28:	0024979b          	sllw	a5,s1,0x2
     c2c:	9fa5                	addw	a5,a5,s1
     c2e:	0017979b          	sllw	a5,a5,0x1
     c32:	fd07071b          	addw	a4,a4,-48
     c36:	00f704bb          	addw	s1,a4,a5
    while (line[i]) {
     c3a:	0685                	add	a3,a3,1
     c3c:	0006c703          	lbu	a4,0(a3)
     c40:	f765                	bnez	a4,c28 <main+0x748>
  return !strcmp(line, "Transfer-Encoding: chunked");
     c42:	00001597          	auipc	a1,0x1
     c46:	e7658593          	add	a1,a1,-394 # 1ab8 <malloc+0x386>
     c4a:	8552                	mv	a0,s4
     c4c:	00000097          	auipc	ra,0x0
     c50:	1b0080e7          	jalr	432(ra) # dfc <strcmp>
      if (is_chunked(line))
     c54:	f121                	bnez	a0,b94 <main+0x6b4>
     c56:	bf0d                	j	b88 <main+0x6a8>
    return len;
     c58:	4481                	li	s1,0
     c5a:	bf3d                	j	b98 <main+0x6b8>
  return !strcmp(line, "Transfer-Encoding: chunked");
     c5c:	00001597          	auipc	a1,0x1
     c60:	e5c58593          	add	a1,a1,-420 # 1ab8 <malloc+0x386>
     c64:	a1040513          	add	a0,s0,-1520
     c68:	00000097          	auipc	ra,0x0
     c6c:	194080e7          	jalr	404(ra) # dfc <strcmp>
      if (is_chunked(line))
     c70:	f515                	bnez	a0,b9c <main+0x6bc>
     c72:	54fd                	li	s1,-1
     c74:	bf11                	j	b88 <main+0x6a8>
    path = oargv + i;
     c76:	f2840793          	add	a5,s0,-216
     c7a:	00c784b3          	add	s1,a5,a2
  memmove(host, oargv, i);
     c7e:	ec040993          	add	s3,s0,-320
     c82:	f2840593          	add	a1,s0,-216
     c86:	854e                	mv	a0,s3
     c88:	00000097          	auipc	ra,0x0
     c8c:	340080e7          	jalr	832(ra) # fc8 <memmove>
  argv[1] = host;
     c90:	01393423          	sd	s3,8(s2)
  if (argv[1][0] >= '0' && argv[1][0] <= '9') {
     c94:	ec044783          	lbu	a5,-320(s0)
     c98:	fd07871b          	addw	a4,a5,-48
     c9c:	0ff77713          	zext.b	a4,a4
     ca0:	46a5                	li	a3,9
     ca2:	94e6f2e3          	bgeu	a3,a4,5e6 <main+0x106>
    int i = 0;
     ca6:	4701                	li	a4,0
    while (argv[1][i] && argv[1][i] != ':') i++;
     ca8:	86ce                	mv	a3,s3
     caa:	03a00613          	li	a2,58
     cae:	cb81                	beqz	a5,cbe <main+0x7de>
     cb0:	00c78763          	beq	a5,a2,cbe <main+0x7de>
     cb4:	2705                	addw	a4,a4,1
     cb6:	0685                	add	a3,a3,1
     cb8:	0006c783          	lbu	a5,0(a3)
     cbc:	fbf5                	bnez	a5,cb0 <main+0x7d0>
    argv[1][i] = 0;
     cbe:	00068023          	sb	zero,0(a3)
    while (argv[1][i]) {
     cc2:	2705                	addw	a4,a4,1
     cc4:	f9070793          	add	a5,a4,-112
     cc8:	97a2                	add	a5,a5,s0
     cca:	f307c783          	lbu	a5,-208(a5)
     cce:	a80785e3          	beqz	a5,758 <main+0x278>
     cd2:	f9070713          	add	a4,a4,-112
     cd6:	9722                	add	a4,a4,s0
     cd8:	f3170693          	add	a3,a4,-207
    int n = 0;
     cdc:	4901                	li	s2,0
      if (!is_digit(argv[1][i])) {
     cde:	4625                	li	a2,9
  return ch >= '0' && ch <= '9';
     ce0:	fd07871b          	addw	a4,a5,-48
      if (!is_digit(argv[1][i])) {
     ce4:	0ff77713          	zext.b	a4,a4
     ce8:	a4e668e3          	bltu	a2,a4,738 <main+0x258>
      n = n * 10 + (argv[1][i] - '0');
     cec:	0029171b          	sllw	a4,s2,0x2
     cf0:	0127073b          	addw	a4,a4,s2
     cf4:	0017171b          	sllw	a4,a4,0x1
     cf8:	fd07879b          	addw	a5,a5,-48
     cfc:	00e7893b          	addw	s2,a5,a4
    while (argv[1][i]) {
     d00:	0685                	add	a3,a3,1
     d02:	fff6c783          	lbu	a5,-1(a3)
     d06:	ffe9                	bnez	a5,ce0 <main+0x800>
    port = n == 0 ? 80 : n;
     d08:	a40905e3          	beqz	s2,752 <main+0x272>
  char qs[100] = {0};
     d0c:	757d                	lui	a0,0xfffff
     d0e:	06400613          	li	a2,100
     d12:	4581                	li	a1,0
     d14:	5c050793          	add	a5,a0,1472 # fffffffffffff5c0 <__BSS_END__+0xffffffffffffb238>
     d18:	00878533          	add	a0,a5,s0
     d1c:	00000097          	auipc	ra,0x0
     d20:	164080e7          	jalr	356(ra) # e80 <memset>
  snprintf(qs, 100, "%s.", s);
     d24:	757d                	lui	a0,0xfffff
     d26:	ec040693          	add	a3,s0,-320
     d2a:	00001617          	auipc	a2,0x1
     d2e:	c6660613          	add	a2,a2,-922 # 1990 <malloc+0x25e>
     d32:	06400593          	li	a1,100
     d36:	5c050793          	add	a5,a0,1472 # fffffffffffff5c0 <__BSS_END__+0xffffffffffffb238>
     d3a:	00878533          	add	a0,a5,s0
     d3e:	00000097          	auipc	ra,0x0
     d42:	7aa080e7          	jalr	1962(ra) # 14e8 <snprintf>
  memset(obuf, 0, N);
     d46:	757d                	lui	a0,0xfffff
     d48:	3e800613          	li	a2,1000
     d4c:	4581                	li	a1,0
     d4e:	62850793          	add	a5,a0,1576 # fffffffffffff628 <__BSS_END__+0xffffffffffffb2a0>
     d52:	00878533          	add	a0,a5,s0
     d56:	00000097          	auipc	ra,0x0
     d5a:	12a080e7          	jalr	298(ra) # e80 <memset>
  memset(ibuf, 0, N);
     d5e:	3e800613          	li	a2,1000
     d62:	4581                	li	a1,0
     d64:	a1040513          	add	a0,s0,-1520
     d68:	00000097          	auipc	ra,0x0
     d6c:	118080e7          	jalr	280(ra) # e80 <memset>
  if((fd = uconnect(dst, 10000, 53)) < 0){
     d70:	03500613          	li	a2,53
     d74:	6589                	lui	a1,0x2
     d76:	71058593          	add	a1,a1,1808 # 2710 <__global_pointer$+0x3ac>
     d7a:	df050537          	lui	a0,0xdf050
     d7e:	50550513          	add	a0,a0,1285 # ffffffffdf050505 <__BSS_END__+0xffffffffdf04c17d>
     d82:	00000097          	auipc	ra,0x0
     d86:	398080e7          	jalr	920(ra) # 111a <uconnect>
     d8a:	8b2a                	mv	s6,a0
     d8c:	9c0549e3          	bltz	a0,75e <main+0x27e>
  hdr->id = htons(6828);
     d90:	77fd                	lui	a5,0xfffff
     d92:	f9078793          	add	a5,a5,-112 # ffffffffffffef90 <__BSS_END__+0xffffffffffffac08>
     d96:	97a2                	add	a5,a5,s0
     d98:	776d                	lui	a4,0xffffb
     d9a:	c1a70713          	add	a4,a4,-998 # ffffffffffffac1a <__BSS_END__+0xffffffffffff6892>
     d9e:	68e79c23          	sh	a4,1688(a5)
  hdr->rd = 1;
     da2:	69a7d703          	lhu	a4,1690(a5)
     da6:	00176713          	or	a4,a4,1
     daa:	68e79d23          	sh	a4,1690(a5)
  hdr->qdcount = htons(1);
     dae:	10000713          	li	a4,256
     db2:	68e79e23          	sh	a4,1692(a5)
  for(char *c = host; c < host+strlen(host)+1; c++) {
     db6:	79fd                	lui	s3,0xfffff
     db8:	5c098793          	add	a5,s3,1472 # fffffffffffff5c0 <__BSS_END__+0xffffffffffffb238>
     dbc:	008789b3          	add	s3,a5,s0
  char *l = host; 
     dc0:	8bce                	mv	s7,s3
  for(char *c = host; c < host+strlen(host)+1; c++) {
     dc2:	7a7d                	lui	s4,0xfffff
     dc4:	634a0793          	add	a5,s4,1588 # fffffffffffff634 <__BSS_END__+0xffffffffffffb2ac>
     dc8:	00878a33          	add	s4,a5,s0
     dcc:	777d                	lui	a4,0xfffff
     dce:	5b870713          	add	a4,a4,1464 # fffffffffffff5b8 <__BSS_END__+0xffffffffffffb230>
     dd2:	9722                	add	a4,a4,s0
     dd4:	01373023          	sd	s3,0(a4)
    if(*c == '.') {
     dd8:	02e00a93          	li	s5,46
     ddc:	4c01                	li	s8,0
  for(char *c = host; c < host+strlen(host)+1; c++) {
     dde:	bac1                	j	7ae <main+0x2ce>

0000000000000de0 <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
     de0:	1141                	add	sp,sp,-16
     de2:	e422                	sd	s0,8(sp)
     de4:	0800                	add	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
     de6:	87aa                	mv	a5,a0
     de8:	0585                	add	a1,a1,1
     dea:	0785                	add	a5,a5,1
     dec:	fff5c703          	lbu	a4,-1(a1)
     df0:	fee78fa3          	sb	a4,-1(a5)
     df4:	fb75                	bnez	a4,de8 <strcpy+0x8>
    ;
  return os;
}
     df6:	6422                	ld	s0,8(sp)
     df8:	0141                	add	sp,sp,16
     dfa:	8082                	ret

0000000000000dfc <strcmp>:

int
strcmp(const char *p, const char *q)
{
     dfc:	1141                	add	sp,sp,-16
     dfe:	e422                	sd	s0,8(sp)
     e00:	0800                	add	s0,sp,16
  while(*p && *p == *q)
     e02:	00054783          	lbu	a5,0(a0)
     e06:	cb91                	beqz	a5,e1a <strcmp+0x1e>
     e08:	0005c703          	lbu	a4,0(a1)
     e0c:	00f71763          	bne	a4,a5,e1a <strcmp+0x1e>
    p++, q++;
     e10:	0505                	add	a0,a0,1
     e12:	0585                	add	a1,a1,1
  while(*p && *p == *q)
     e14:	00054783          	lbu	a5,0(a0)
     e18:	fbe5                	bnez	a5,e08 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
     e1a:	0005c503          	lbu	a0,0(a1)
}
     e1e:	40a7853b          	subw	a0,a5,a0
     e22:	6422                	ld	s0,8(sp)
     e24:	0141                	add	sp,sp,16
     e26:	8082                	ret

0000000000000e28 <strlen>:

uint
strlen(const char *s)
{
     e28:	1141                	add	sp,sp,-16
     e2a:	e422                	sd	s0,8(sp)
     e2c:	0800                	add	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
     e2e:	00054783          	lbu	a5,0(a0)
     e32:	cf91                	beqz	a5,e4e <strlen+0x26>
     e34:	0505                	add	a0,a0,1
     e36:	87aa                	mv	a5,a0
     e38:	86be                	mv	a3,a5
     e3a:	0785                	add	a5,a5,1
     e3c:	fff7c703          	lbu	a4,-1(a5)
     e40:	ff65                	bnez	a4,e38 <strlen+0x10>
     e42:	40a6853b          	subw	a0,a3,a0
     e46:	2505                	addw	a0,a0,1
    ;
  return n;
}
     e48:	6422                	ld	s0,8(sp)
     e4a:	0141                	add	sp,sp,16
     e4c:	8082                	ret
  for(n = 0; s[n]; n++)
     e4e:	4501                	li	a0,0
     e50:	bfe5                	j	e48 <strlen+0x20>

0000000000000e52 <strcat>:

char *
strcat(char *dst, char *src)
{
     e52:	1141                	add	sp,sp,-16
     e54:	e422                	sd	s0,8(sp)
     e56:	0800                	add	s0,sp,16
  char *s = dst;
  while (*dst)
     e58:	00054783          	lbu	a5,0(a0)
     e5c:	c385                	beqz	a5,e7c <strcat+0x2a>
     e5e:	87aa                	mv	a5,a0
    dst++;
     e60:	0785                	add	a5,a5,1
  while (*dst)
     e62:	0007c703          	lbu	a4,0(a5)
     e66:	ff6d                	bnez	a4,e60 <strcat+0xe>
  while ((*dst++ = *src++) != 0);
     e68:	0585                	add	a1,a1,1
     e6a:	0785                	add	a5,a5,1
     e6c:	fff5c703          	lbu	a4,-1(a1)
     e70:	fee78fa3          	sb	a4,-1(a5)
     e74:	fb75                	bnez	a4,e68 <strcat+0x16>

  return s;
}
     e76:	6422                	ld	s0,8(sp)
     e78:	0141                	add	sp,sp,16
     e7a:	8082                	ret
  while (*dst)
     e7c:	87aa                	mv	a5,a0
     e7e:	b7ed                	j	e68 <strcat+0x16>

0000000000000e80 <memset>:

void*
memset(void *dst, int c, uint n)
{
     e80:	1141                	add	sp,sp,-16
     e82:	e422                	sd	s0,8(sp)
     e84:	0800                	add	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
     e86:	ca19                	beqz	a2,e9c <memset+0x1c>
     e88:	87aa                	mv	a5,a0
     e8a:	1602                	sll	a2,a2,0x20
     e8c:	9201                	srl	a2,a2,0x20
     e8e:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
     e92:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
     e96:	0785                	add	a5,a5,1
     e98:	fee79de3          	bne	a5,a4,e92 <memset+0x12>
  }
  return dst;
}
     e9c:	6422                	ld	s0,8(sp)
     e9e:	0141                	add	sp,sp,16
     ea0:	8082                	ret

0000000000000ea2 <strchr>:

char*
strchr(const char *s, char c)
{
     ea2:	1141                	add	sp,sp,-16
     ea4:	e422                	sd	s0,8(sp)
     ea6:	0800                	add	s0,sp,16
  for(; *s; s++)
     ea8:	00054783          	lbu	a5,0(a0)
     eac:	cb99                	beqz	a5,ec2 <strchr+0x20>
    if(*s == c)
     eae:	00f58763          	beq	a1,a5,ebc <strchr+0x1a>
  for(; *s; s++)
     eb2:	0505                	add	a0,a0,1
     eb4:	00054783          	lbu	a5,0(a0)
     eb8:	fbfd                	bnez	a5,eae <strchr+0xc>
      return (char*)s;
  return 0;
     eba:	4501                	li	a0,0
}
     ebc:	6422                	ld	s0,8(sp)
     ebe:	0141                	add	sp,sp,16
     ec0:	8082                	ret
  return 0;
     ec2:	4501                	li	a0,0
     ec4:	bfe5                	j	ebc <strchr+0x1a>

0000000000000ec6 <gets>:

char*
gets(char *buf, int max)
{
     ec6:	711d                	add	sp,sp,-96
     ec8:	ec86                	sd	ra,88(sp)
     eca:	e8a2                	sd	s0,80(sp)
     ecc:	e4a6                	sd	s1,72(sp)
     ece:	e0ca                	sd	s2,64(sp)
     ed0:	fc4e                	sd	s3,56(sp)
     ed2:	f852                	sd	s4,48(sp)
     ed4:	f456                	sd	s5,40(sp)
     ed6:	f05a                	sd	s6,32(sp)
     ed8:	ec5e                	sd	s7,24(sp)
     eda:	1080                	add	s0,sp,96
     edc:	8baa                	mv	s7,a0
     ede:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     ee0:	892a                	mv	s2,a0
     ee2:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
     ee4:	4aa9                	li	s5,10
     ee6:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
     ee8:	89a6                	mv	s3,s1
     eea:	2485                	addw	s1,s1,1
     eec:	0344d863          	bge	s1,s4,f1c <gets+0x56>
    cc = read(0, &c, 1);
     ef0:	4605                	li	a2,1
     ef2:	faf40593          	add	a1,s0,-81
     ef6:	4501                	li	a0,0
     ef8:	00000097          	auipc	ra,0x0
     efc:	19a080e7          	jalr	410(ra) # 1092 <read>
    if(cc < 1)
     f00:	00a05e63          	blez	a0,f1c <gets+0x56>
    buf[i++] = c;
     f04:	faf44783          	lbu	a5,-81(s0)
     f08:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
     f0c:	01578763          	beq	a5,s5,f1a <gets+0x54>
     f10:	0905                	add	s2,s2,1
     f12:	fd679be3          	bne	a5,s6,ee8 <gets+0x22>
    buf[i++] = c;
     f16:	89a6                	mv	s3,s1
     f18:	a011                	j	f1c <gets+0x56>
     f1a:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
     f1c:	99de                	add	s3,s3,s7
     f1e:	00098023          	sb	zero,0(s3)
  return buf;
}
     f22:	855e                	mv	a0,s7
     f24:	60e6                	ld	ra,88(sp)
     f26:	6446                	ld	s0,80(sp)
     f28:	64a6                	ld	s1,72(sp)
     f2a:	6906                	ld	s2,64(sp)
     f2c:	79e2                	ld	s3,56(sp)
     f2e:	7a42                	ld	s4,48(sp)
     f30:	7aa2                	ld	s5,40(sp)
     f32:	7b02                	ld	s6,32(sp)
     f34:	6be2                	ld	s7,24(sp)
     f36:	6125                	add	sp,sp,96
     f38:	8082                	ret

0000000000000f3a <stat>:

int
stat(const char *n, struct stat *st)
{
     f3a:	1101                	add	sp,sp,-32
     f3c:	ec06                	sd	ra,24(sp)
     f3e:	e822                	sd	s0,16(sp)
     f40:	e04a                	sd	s2,0(sp)
     f42:	1000                	add	s0,sp,32
     f44:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     f46:	4581                	li	a1,0
     f48:	00000097          	auipc	ra,0x0
     f4c:	172080e7          	jalr	370(ra) # 10ba <open>
  if(fd < 0)
     f50:	02054663          	bltz	a0,f7c <stat+0x42>
     f54:	e426                	sd	s1,8(sp)
     f56:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
     f58:	85ca                	mv	a1,s2
     f5a:	00000097          	auipc	ra,0x0
     f5e:	178080e7          	jalr	376(ra) # 10d2 <fstat>
     f62:	892a                	mv	s2,a0
  close(fd);
     f64:	8526                	mv	a0,s1
     f66:	00000097          	auipc	ra,0x0
     f6a:	13c080e7          	jalr	316(ra) # 10a2 <close>
  return r;
     f6e:	64a2                	ld	s1,8(sp)
}
     f70:	854a                	mv	a0,s2
     f72:	60e2                	ld	ra,24(sp)
     f74:	6442                	ld	s0,16(sp)
     f76:	6902                	ld	s2,0(sp)
     f78:	6105                	add	sp,sp,32
     f7a:	8082                	ret
    return -1;
     f7c:	597d                	li	s2,-1
     f7e:	bfcd                	j	f70 <stat+0x36>

0000000000000f80 <atoi>:

int
atoi(const char *s)
{
     f80:	1141                	add	sp,sp,-16
     f82:	e422                	sd	s0,8(sp)
     f84:	0800                	add	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
     f86:	00054683          	lbu	a3,0(a0)
     f8a:	fd06879b          	addw	a5,a3,-48
     f8e:	0ff7f793          	zext.b	a5,a5
     f92:	4625                	li	a2,9
     f94:	02f66863          	bltu	a2,a5,fc4 <atoi+0x44>
     f98:	872a                	mv	a4,a0
  n = 0;
     f9a:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
     f9c:	0705                	add	a4,a4,1
     f9e:	0025179b          	sllw	a5,a0,0x2
     fa2:	9fa9                	addw	a5,a5,a0
     fa4:	0017979b          	sllw	a5,a5,0x1
     fa8:	9fb5                	addw	a5,a5,a3
     faa:	fd07851b          	addw	a0,a5,-48
  while('0' <= *s && *s <= '9')
     fae:	00074683          	lbu	a3,0(a4)
     fb2:	fd06879b          	addw	a5,a3,-48
     fb6:	0ff7f793          	zext.b	a5,a5
     fba:	fef671e3          	bgeu	a2,a5,f9c <atoi+0x1c>
  return n;
}
     fbe:	6422                	ld	s0,8(sp)
     fc0:	0141                	add	sp,sp,16
     fc2:	8082                	ret
  n = 0;
     fc4:	4501                	li	a0,0
     fc6:	bfe5                	j	fbe <atoi+0x3e>

0000000000000fc8 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
     fc8:	1141                	add	sp,sp,-16
     fca:	e422                	sd	s0,8(sp)
     fcc:	0800                	add	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
     fce:	02b57463          	bgeu	a0,a1,ff6 <memmove+0x2e>
    while(n-- > 0)
     fd2:	00c05f63          	blez	a2,ff0 <memmove+0x28>
     fd6:	1602                	sll	a2,a2,0x20
     fd8:	9201                	srl	a2,a2,0x20
     fda:	00c507b3          	add	a5,a0,a2
  dst = vdst;
     fde:	872a                	mv	a4,a0
      *dst++ = *src++;
     fe0:	0585                	add	a1,a1,1
     fe2:	0705                	add	a4,a4,1
     fe4:	fff5c683          	lbu	a3,-1(a1)
     fe8:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
     fec:	fef71ae3          	bne	a4,a5,fe0 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
     ff0:	6422                	ld	s0,8(sp)
     ff2:	0141                	add	sp,sp,16
     ff4:	8082                	ret
    dst += n;
     ff6:	00c50733          	add	a4,a0,a2
    src += n;
     ffa:	95b2                	add	a1,a1,a2
    while(n-- > 0)
     ffc:	fec05ae3          	blez	a2,ff0 <memmove+0x28>
    1000:	fff6079b          	addw	a5,a2,-1
    1004:	1782                	sll	a5,a5,0x20
    1006:	9381                	srl	a5,a5,0x20
    1008:	fff7c793          	not	a5,a5
    100c:	97ba                	add	a5,a5,a4
      *--dst = *--src;
    100e:	15fd                	add	a1,a1,-1
    1010:	177d                	add	a4,a4,-1
    1012:	0005c683          	lbu	a3,0(a1)
    1016:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
    101a:	fee79ae3          	bne	a5,a4,100e <memmove+0x46>
    101e:	bfc9                	j	ff0 <memmove+0x28>

0000000000001020 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
    1020:	1141                	add	sp,sp,-16
    1022:	e422                	sd	s0,8(sp)
    1024:	0800                	add	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
    1026:	ca05                	beqz	a2,1056 <memcmp+0x36>
    1028:	fff6069b          	addw	a3,a2,-1
    102c:	1682                	sll	a3,a3,0x20
    102e:	9281                	srl	a3,a3,0x20
    1030:	0685                	add	a3,a3,1
    1032:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
    1034:	00054783          	lbu	a5,0(a0)
    1038:	0005c703          	lbu	a4,0(a1)
    103c:	00e79863          	bne	a5,a4,104c <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
    1040:	0505                	add	a0,a0,1
    p2++;
    1042:	0585                	add	a1,a1,1
  while (n-- > 0) {
    1044:	fed518e3          	bne	a0,a3,1034 <memcmp+0x14>
  }
  return 0;
    1048:	4501                	li	a0,0
    104a:	a019                	j	1050 <memcmp+0x30>
      return *p1 - *p2;
    104c:	40e7853b          	subw	a0,a5,a4
}
    1050:	6422                	ld	s0,8(sp)
    1052:	0141                	add	sp,sp,16
    1054:	8082                	ret
  return 0;
    1056:	4501                	li	a0,0
    1058:	bfe5                	j	1050 <memcmp+0x30>

000000000000105a <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
    105a:	1141                	add	sp,sp,-16
    105c:	e406                	sd	ra,8(sp)
    105e:	e022                	sd	s0,0(sp)
    1060:	0800                	add	s0,sp,16
  return memmove(dst, src, n);
    1062:	00000097          	auipc	ra,0x0
    1066:	f66080e7          	jalr	-154(ra) # fc8 <memmove>
}
    106a:	60a2                	ld	ra,8(sp)
    106c:	6402                	ld	s0,0(sp)
    106e:	0141                	add	sp,sp,16
    1070:	8082                	ret

0000000000001072 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
    1072:	4885                	li	a7,1
 ecall
    1074:	00000073          	ecall
 ret
    1078:	8082                	ret

000000000000107a <exit>:
.global exit
exit:
 li a7, SYS_exit
    107a:	4889                	li	a7,2
 ecall
    107c:	00000073          	ecall
 ret
    1080:	8082                	ret

0000000000001082 <wait>:
.global wait
wait:
 li a7, SYS_wait
    1082:	488d                	li	a7,3
 ecall
    1084:	00000073          	ecall
 ret
    1088:	8082                	ret

000000000000108a <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
    108a:	4891                	li	a7,4
 ecall
    108c:	00000073          	ecall
 ret
    1090:	8082                	ret

0000000000001092 <read>:
.global read
read:
 li a7, SYS_read
    1092:	4895                	li	a7,5
 ecall
    1094:	00000073          	ecall
 ret
    1098:	8082                	ret

000000000000109a <write>:
.global write
write:
 li a7, SYS_write
    109a:	48c1                	li	a7,16
 ecall
    109c:	00000073          	ecall
 ret
    10a0:	8082                	ret

00000000000010a2 <close>:
.global close
close:
 li a7, SYS_close
    10a2:	48d5                	li	a7,21
 ecall
    10a4:	00000073          	ecall
 ret
    10a8:	8082                	ret

00000000000010aa <kill>:
.global kill
kill:
 li a7, SYS_kill
    10aa:	4899                	li	a7,6
 ecall
    10ac:	00000073          	ecall
 ret
    10b0:	8082                	ret

00000000000010b2 <exec>:
.global exec
exec:
 li a7, SYS_exec
    10b2:	489d                	li	a7,7
 ecall
    10b4:	00000073          	ecall
 ret
    10b8:	8082                	ret

00000000000010ba <open>:
.global open
open:
 li a7, SYS_open
    10ba:	48bd                	li	a7,15
 ecall
    10bc:	00000073          	ecall
 ret
    10c0:	8082                	ret

00000000000010c2 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
    10c2:	48c5                	li	a7,17
 ecall
    10c4:	00000073          	ecall
 ret
    10c8:	8082                	ret

00000000000010ca <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
    10ca:	48c9                	li	a7,18
 ecall
    10cc:	00000073          	ecall
 ret
    10d0:	8082                	ret

00000000000010d2 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
    10d2:	48a1                	li	a7,8
 ecall
    10d4:	00000073          	ecall
 ret
    10d8:	8082                	ret

00000000000010da <link>:
.global link
link:
 li a7, SYS_link
    10da:	48cd                	li	a7,19
 ecall
    10dc:	00000073          	ecall
 ret
    10e0:	8082                	ret

00000000000010e2 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
    10e2:	48d1                	li	a7,20
 ecall
    10e4:	00000073          	ecall
 ret
    10e8:	8082                	ret

00000000000010ea <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
    10ea:	48a5                	li	a7,9
 ecall
    10ec:	00000073          	ecall
 ret
    10f0:	8082                	ret

00000000000010f2 <dup>:
.global dup
dup:
 li a7, SYS_dup
    10f2:	48a9                	li	a7,10
 ecall
    10f4:	00000073          	ecall
 ret
    10f8:	8082                	ret

00000000000010fa <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
    10fa:	48ad                	li	a7,11
 ecall
    10fc:	00000073          	ecall
 ret
    1100:	8082                	ret

0000000000001102 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
    1102:	48b1                	li	a7,12
 ecall
    1104:	00000073          	ecall
 ret
    1108:	8082                	ret

000000000000110a <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
    110a:	48b5                	li	a7,13
 ecall
    110c:	00000073          	ecall
 ret
    1110:	8082                	ret

0000000000001112 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
    1112:	48b9                	li	a7,14
 ecall
    1114:	00000073          	ecall
 ret
    1118:	8082                	ret

000000000000111a <uconnect>:
.global uconnect
uconnect:
 li a7, SYS_uconnect
    111a:	48f5                	li	a7,29
 ecall
    111c:	00000073          	ecall
 ret
    1120:	8082                	ret

0000000000001122 <socket>:
.global socket
socket:
 li a7, SYS_socket
    1122:	48f9                	li	a7,30
 ecall
    1124:	00000073          	ecall
 ret
    1128:	8082                	ret

000000000000112a <bind>:
.global bind
bind:
 li a7, SYS_bind
    112a:	48fd                	li	a7,31
 ecall
    112c:	00000073          	ecall
 ret
    1130:	8082                	ret

0000000000001132 <listen>:
.global listen
listen:
 li a7, SYS_listen
    1132:	02000893          	li	a7,32
 ecall
    1136:	00000073          	ecall
 ret
    113a:	8082                	ret

000000000000113c <accept>:
.global accept
accept:
 li a7, SYS_accept
    113c:	02100893          	li	a7,33
 ecall
    1140:	00000073          	ecall
 ret
    1144:	8082                	ret

0000000000001146 <connect>:
.global connect
connect:
 li a7, SYS_connect
    1146:	02200893          	li	a7,34
 ecall
    114a:	00000073          	ecall
 ret
    114e:	8082                	ret

0000000000001150 <sprintint>:
  return 1;
}

static int
sprintint(char *s, int xx, int base, int sign)
{
    1150:	1101                	add	sp,sp,-32
    1152:	ec22                	sd	s0,24(sp)
    1154:	1000                	add	s0,sp,32
    1156:	882a                	mv	a6,a0
  char buf[16];
  int i, n;
  uint x;

  if(sign && (sign = xx < 0))
    1158:	c299                	beqz	a3,115e <sprintint+0xe>
    115a:	0805c263          	bltz	a1,11de <sprintint+0x8e>
    x = -xx;
  else
    x = xx;
    115e:	2581                	sext.w	a1,a1
    1160:	4301                	li	t1,0

  i = 0;
    1162:	fe040713          	add	a4,s0,-32
    1166:	4501                	li	a0,0
  do {
    buf[i++] = digits[x % base];
    1168:	2601                	sext.w	a2,a2
    116a:	00001697          	auipc	a3,0x1
    116e:	9e668693          	add	a3,a3,-1562 # 1b50 <digits>
    1172:	88aa                	mv	a7,a0
    1174:	2505                	addw	a0,a0,1
    1176:	02c5f7bb          	remuw	a5,a1,a2
    117a:	1782                	sll	a5,a5,0x20
    117c:	9381                	srl	a5,a5,0x20
    117e:	97b6                	add	a5,a5,a3
    1180:	0007c783          	lbu	a5,0(a5)
    1184:	00f70023          	sb	a5,0(a4)
  } while((x /= base) != 0);
    1188:	0005879b          	sext.w	a5,a1
    118c:	02c5d5bb          	divuw	a1,a1,a2
    1190:	0705                	add	a4,a4,1
    1192:	fec7f0e3          	bgeu	a5,a2,1172 <sprintint+0x22>

  if(sign)
    1196:	00030b63          	beqz	t1,11ac <sprintint+0x5c>
    buf[i++] = '-';
    119a:	ff050793          	add	a5,a0,-16
    119e:	97a2                	add	a5,a5,s0
    11a0:	02d00713          	li	a4,45
    11a4:	fee78823          	sb	a4,-16(a5)
    11a8:	0028851b          	addw	a0,a7,2

  n = 0;
  while(--i >= 0)
    11ac:	02a05d63          	blez	a0,11e6 <sprintint+0x96>
    11b0:	fe040793          	add	a5,s0,-32
    11b4:	00a78733          	add	a4,a5,a0
    11b8:	87c2                	mv	a5,a6
    11ba:	00180613          	add	a2,a6,1
    11be:	fff5069b          	addw	a3,a0,-1
    11c2:	1682                	sll	a3,a3,0x20
    11c4:	9281                	srl	a3,a3,0x20
    11c6:	9636                	add	a2,a2,a3
  *s = c;
    11c8:	fff74683          	lbu	a3,-1(a4)
    11cc:	00d78023          	sb	a3,0(a5)
  while(--i >= 0)
    11d0:	177d                	add	a4,a4,-1
    11d2:	0785                	add	a5,a5,1
    11d4:	fec79ae3          	bne	a5,a2,11c8 <sprintint+0x78>
    n += sputc(s+n, buf[i]);
  return n;
}
    11d8:	6462                	ld	s0,24(sp)
    11da:	6105                	add	sp,sp,32
    11dc:	8082                	ret
    x = -xx;
    11de:	40b005bb          	negw	a1,a1
  if(sign && (sign = xx < 0))
    11e2:	4305                	li	t1,1
    x = -xx;
    11e4:	bfbd                	j	1162 <sprintint+0x12>
  while(--i >= 0)
    11e6:	4501                	li	a0,0
    11e8:	bfc5                	j	11d8 <sprintint+0x88>

00000000000011ea <putc>:
{
    11ea:	1101                	add	sp,sp,-32
    11ec:	ec06                	sd	ra,24(sp)
    11ee:	e822                	sd	s0,16(sp)
    11f0:	1000                	add	s0,sp,32
    11f2:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
    11f6:	4605                	li	a2,1
    11f8:	fef40593          	add	a1,s0,-17
    11fc:	00000097          	auipc	ra,0x0
    1200:	e9e080e7          	jalr	-354(ra) # 109a <write>
}
    1204:	60e2                	ld	ra,24(sp)
    1206:	6442                	ld	s0,16(sp)
    1208:	6105                	add	sp,sp,32
    120a:	8082                	ret

000000000000120c <printint>:
{
    120c:	7139                	add	sp,sp,-64
    120e:	fc06                	sd	ra,56(sp)
    1210:	f822                	sd	s0,48(sp)
    1212:	f426                	sd	s1,40(sp)
    1214:	0080                	add	s0,sp,64
    1216:	84aa                	mv	s1,a0
  if(sgn && xx < 0){
    1218:	c299                	beqz	a3,121e <printint+0x12>
    121a:	0805cb63          	bltz	a1,12b0 <printint+0xa4>
    x = xx;
    121e:	2581                	sext.w	a1,a1
  neg = 0;
    1220:	4881                	li	a7,0
    1222:	fc040693          	add	a3,s0,-64
  i = 0;
    1226:	4701                	li	a4,0
    buf[i++] = digits[x % base];
    1228:	2601                	sext.w	a2,a2
    122a:	00001517          	auipc	a0,0x1
    122e:	92650513          	add	a0,a0,-1754 # 1b50 <digits>
    1232:	883a                	mv	a6,a4
    1234:	2705                	addw	a4,a4,1
    1236:	02c5f7bb          	remuw	a5,a1,a2
    123a:	1782                	sll	a5,a5,0x20
    123c:	9381                	srl	a5,a5,0x20
    123e:	97aa                	add	a5,a5,a0
    1240:	0007c783          	lbu	a5,0(a5)
    1244:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
    1248:	0005879b          	sext.w	a5,a1
    124c:	02c5d5bb          	divuw	a1,a1,a2
    1250:	0685                	add	a3,a3,1
    1252:	fec7f0e3          	bgeu	a5,a2,1232 <printint+0x26>
  if(neg)
    1256:	00088c63          	beqz	a7,126e <printint+0x62>
    buf[i++] = '-';
    125a:	fd070793          	add	a5,a4,-48
    125e:	00878733          	add	a4,a5,s0
    1262:	02d00793          	li	a5,45
    1266:	fef70823          	sb	a5,-16(a4)
    126a:	0028071b          	addw	a4,a6,2
  while(--i >= 0)
    126e:	02e05c63          	blez	a4,12a6 <printint+0x9a>
    1272:	f04a                	sd	s2,32(sp)
    1274:	ec4e                	sd	s3,24(sp)
    1276:	fc040793          	add	a5,s0,-64
    127a:	00e78933          	add	s2,a5,a4
    127e:	fff78993          	add	s3,a5,-1
    1282:	99ba                	add	s3,s3,a4
    1284:	377d                	addw	a4,a4,-1
    1286:	1702                	sll	a4,a4,0x20
    1288:	9301                	srl	a4,a4,0x20
    128a:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
    128e:	fff94583          	lbu	a1,-1(s2)
    1292:	8526                	mv	a0,s1
    1294:	00000097          	auipc	ra,0x0
    1298:	f56080e7          	jalr	-170(ra) # 11ea <putc>
  while(--i >= 0)
    129c:	197d                	add	s2,s2,-1
    129e:	ff3918e3          	bne	s2,s3,128e <printint+0x82>
    12a2:	7902                	ld	s2,32(sp)
    12a4:	69e2                	ld	s3,24(sp)
}
    12a6:	70e2                	ld	ra,56(sp)
    12a8:	7442                	ld	s0,48(sp)
    12aa:	74a2                	ld	s1,40(sp)
    12ac:	6121                	add	sp,sp,64
    12ae:	8082                	ret
    x = -xx;
    12b0:	40b005bb          	negw	a1,a1
    neg = 1;
    12b4:	4885                	li	a7,1
    x = -xx;
    12b6:	b7b5                	j	1222 <printint+0x16>

00000000000012b8 <vprintf>:
{
    12b8:	715d                	add	sp,sp,-80
    12ba:	e486                	sd	ra,72(sp)
    12bc:	e0a2                	sd	s0,64(sp)
    12be:	f84a                	sd	s2,48(sp)
    12c0:	0880                	add	s0,sp,80
  for(i = 0; fmt[i]; i++){
    12c2:	0005c903          	lbu	s2,0(a1)
    12c6:	1a090a63          	beqz	s2,147a <vprintf+0x1c2>
    12ca:	fc26                	sd	s1,56(sp)
    12cc:	f44e                	sd	s3,40(sp)
    12ce:	f052                	sd	s4,32(sp)
    12d0:	ec56                	sd	s5,24(sp)
    12d2:	e85a                	sd	s6,16(sp)
    12d4:	e45e                	sd	s7,8(sp)
    12d6:	8aaa                	mv	s5,a0
    12d8:	8bb2                	mv	s7,a2
    12da:	00158493          	add	s1,a1,1
  state = 0;
    12de:	4981                	li	s3,0
    } else if(state == '%'){
    12e0:	02500a13          	li	s4,37
    12e4:	4b55                	li	s6,21
    12e6:	a839                	j	1304 <vprintf+0x4c>
        putc(fd, c);
    12e8:	85ca                	mv	a1,s2
    12ea:	8556                	mv	a0,s5
    12ec:	00000097          	auipc	ra,0x0
    12f0:	efe080e7          	jalr	-258(ra) # 11ea <putc>
    12f4:	a019                	j	12fa <vprintf+0x42>
    } else if(state == '%'){
    12f6:	01498d63          	beq	s3,s4,1310 <vprintf+0x58>
  for(i = 0; fmt[i]; i++){
    12fa:	0485                	add	s1,s1,1
    12fc:	fff4c903          	lbu	s2,-1(s1)
    1300:	16090763          	beqz	s2,146e <vprintf+0x1b6>
    if(state == 0){
    1304:	fe0999e3          	bnez	s3,12f6 <vprintf+0x3e>
      if(c == '%'){
    1308:	ff4910e3          	bne	s2,s4,12e8 <vprintf+0x30>
        state = '%';
    130c:	89d2                	mv	s3,s4
    130e:	b7f5                	j	12fa <vprintf+0x42>
      if(c == 'd'){
    1310:	13490463          	beq	s2,s4,1438 <vprintf+0x180>
    1314:	f9d9079b          	addw	a5,s2,-99
    1318:	0ff7f793          	zext.b	a5,a5
    131c:	12fb6763          	bltu	s6,a5,144a <vprintf+0x192>
    1320:	f9d9079b          	addw	a5,s2,-99
    1324:	0ff7f713          	zext.b	a4,a5
    1328:	12eb6163          	bltu	s6,a4,144a <vprintf+0x192>
    132c:	00271793          	sll	a5,a4,0x2
    1330:	00000717          	auipc	a4,0x0
    1334:	7c870713          	add	a4,a4,1992 # 1af8 <malloc+0x3c6>
    1338:	97ba                	add	a5,a5,a4
    133a:	439c                	lw	a5,0(a5)
    133c:	97ba                	add	a5,a5,a4
    133e:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
    1340:	008b8913          	add	s2,s7,8
    1344:	4685                	li	a3,1
    1346:	4629                	li	a2,10
    1348:	000ba583          	lw	a1,0(s7)
    134c:	8556                	mv	a0,s5
    134e:	00000097          	auipc	ra,0x0
    1352:	ebe080e7          	jalr	-322(ra) # 120c <printint>
    1356:	8bca                	mv	s7,s2
      state = 0;
    1358:	4981                	li	s3,0
    135a:	b745                	j	12fa <vprintf+0x42>
        printint(fd, va_arg(ap, uint64), 10, 0);
    135c:	008b8913          	add	s2,s7,8
    1360:	4681                	li	a3,0
    1362:	4629                	li	a2,10
    1364:	000ba583          	lw	a1,0(s7)
    1368:	8556                	mv	a0,s5
    136a:	00000097          	auipc	ra,0x0
    136e:	ea2080e7          	jalr	-350(ra) # 120c <printint>
    1372:	8bca                	mv	s7,s2
      state = 0;
    1374:	4981                	li	s3,0
    1376:	b751                	j	12fa <vprintf+0x42>
        printint(fd, va_arg(ap, int), 16, 0);
    1378:	008b8913          	add	s2,s7,8
    137c:	4681                	li	a3,0
    137e:	4641                	li	a2,16
    1380:	000ba583          	lw	a1,0(s7)
    1384:	8556                	mv	a0,s5
    1386:	00000097          	auipc	ra,0x0
    138a:	e86080e7          	jalr	-378(ra) # 120c <printint>
    138e:	8bca                	mv	s7,s2
      state = 0;
    1390:	4981                	li	s3,0
    1392:	b7a5                	j	12fa <vprintf+0x42>
    1394:	e062                	sd	s8,0(sp)
        printptr(fd, va_arg(ap, uint64));
    1396:	008b8c13          	add	s8,s7,8
    139a:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
    139e:	03000593          	li	a1,48
    13a2:	8556                	mv	a0,s5
    13a4:	00000097          	auipc	ra,0x0
    13a8:	e46080e7          	jalr	-442(ra) # 11ea <putc>
  putc(fd, 'x');
    13ac:	07800593          	li	a1,120
    13b0:	8556                	mv	a0,s5
    13b2:	00000097          	auipc	ra,0x0
    13b6:	e38080e7          	jalr	-456(ra) # 11ea <putc>
    13ba:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
    13bc:	00000b97          	auipc	s7,0x0
    13c0:	794b8b93          	add	s7,s7,1940 # 1b50 <digits>
    13c4:	03c9d793          	srl	a5,s3,0x3c
    13c8:	97de                	add	a5,a5,s7
    13ca:	0007c583          	lbu	a1,0(a5)
    13ce:	8556                	mv	a0,s5
    13d0:	00000097          	auipc	ra,0x0
    13d4:	e1a080e7          	jalr	-486(ra) # 11ea <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    13d8:	0992                	sll	s3,s3,0x4
    13da:	397d                	addw	s2,s2,-1
    13dc:	fe0914e3          	bnez	s2,13c4 <vprintf+0x10c>
        printptr(fd, va_arg(ap, uint64));
    13e0:	8be2                	mv	s7,s8
      state = 0;
    13e2:	4981                	li	s3,0
    13e4:	6c02                	ld	s8,0(sp)
    13e6:	bf11                	j	12fa <vprintf+0x42>
        s = va_arg(ap, char*);
    13e8:	008b8993          	add	s3,s7,8
    13ec:	000bb903          	ld	s2,0(s7)
        if(s == 0)
    13f0:	02090163          	beqz	s2,1412 <vprintf+0x15a>
        while(*s != 0){
    13f4:	00094583          	lbu	a1,0(s2)
    13f8:	c9a5                	beqz	a1,1468 <vprintf+0x1b0>
          putc(fd, *s);
    13fa:	8556                	mv	a0,s5
    13fc:	00000097          	auipc	ra,0x0
    1400:	dee080e7          	jalr	-530(ra) # 11ea <putc>
          s++;
    1404:	0905                	add	s2,s2,1
        while(*s != 0){
    1406:	00094583          	lbu	a1,0(s2)
    140a:	f9e5                	bnez	a1,13fa <vprintf+0x142>
        s = va_arg(ap, char*);
    140c:	8bce                	mv	s7,s3
      state = 0;
    140e:	4981                	li	s3,0
    1410:	b5ed                	j	12fa <vprintf+0x42>
          s = "(null)";
    1412:	00000917          	auipc	s2,0x0
    1416:	6de90913          	add	s2,s2,1758 # 1af0 <malloc+0x3be>
        while(*s != 0){
    141a:	02800593          	li	a1,40
    141e:	bff1                	j	13fa <vprintf+0x142>
        putc(fd, va_arg(ap, uint));
    1420:	008b8913          	add	s2,s7,8
    1424:	000bc583          	lbu	a1,0(s7)
    1428:	8556                	mv	a0,s5
    142a:	00000097          	auipc	ra,0x0
    142e:	dc0080e7          	jalr	-576(ra) # 11ea <putc>
    1432:	8bca                	mv	s7,s2
      state = 0;
    1434:	4981                	li	s3,0
    1436:	b5d1                	j	12fa <vprintf+0x42>
        putc(fd, c);
    1438:	02500593          	li	a1,37
    143c:	8556                	mv	a0,s5
    143e:	00000097          	auipc	ra,0x0
    1442:	dac080e7          	jalr	-596(ra) # 11ea <putc>
      state = 0;
    1446:	4981                	li	s3,0
    1448:	bd4d                	j	12fa <vprintf+0x42>
        putc(fd, '%');
    144a:	02500593          	li	a1,37
    144e:	8556                	mv	a0,s5
    1450:	00000097          	auipc	ra,0x0
    1454:	d9a080e7          	jalr	-614(ra) # 11ea <putc>
        putc(fd, c);
    1458:	85ca                	mv	a1,s2
    145a:	8556                	mv	a0,s5
    145c:	00000097          	auipc	ra,0x0
    1460:	d8e080e7          	jalr	-626(ra) # 11ea <putc>
      state = 0;
    1464:	4981                	li	s3,0
    1466:	bd51                	j	12fa <vprintf+0x42>
        s = va_arg(ap, char*);
    1468:	8bce                	mv	s7,s3
      state = 0;
    146a:	4981                	li	s3,0
    146c:	b579                	j	12fa <vprintf+0x42>
    146e:	74e2                	ld	s1,56(sp)
    1470:	79a2                	ld	s3,40(sp)
    1472:	7a02                	ld	s4,32(sp)
    1474:	6ae2                	ld	s5,24(sp)
    1476:	6b42                	ld	s6,16(sp)
    1478:	6ba2                	ld	s7,8(sp)
}
    147a:	60a6                	ld	ra,72(sp)
    147c:	6406                	ld	s0,64(sp)
    147e:	7942                	ld	s2,48(sp)
    1480:	6161                	add	sp,sp,80
    1482:	8082                	ret

0000000000001484 <fprintf>:
{
    1484:	715d                	add	sp,sp,-80
    1486:	ec06                	sd	ra,24(sp)
    1488:	e822                	sd	s0,16(sp)
    148a:	1000                	add	s0,sp,32
    148c:	e010                	sd	a2,0(s0)
    148e:	e414                	sd	a3,8(s0)
    1490:	e818                	sd	a4,16(s0)
    1492:	ec1c                	sd	a5,24(s0)
    1494:	03043023          	sd	a6,32(s0)
    1498:	03143423          	sd	a7,40(s0)
  va_start(ap, fmt);
    149c:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
    14a0:	8622                	mv	a2,s0
    14a2:	00000097          	auipc	ra,0x0
    14a6:	e16080e7          	jalr	-490(ra) # 12b8 <vprintf>
}
    14aa:	60e2                	ld	ra,24(sp)
    14ac:	6442                	ld	s0,16(sp)
    14ae:	6161                	add	sp,sp,80
    14b0:	8082                	ret

00000000000014b2 <printf>:
{
    14b2:	711d                	add	sp,sp,-96
    14b4:	ec06                	sd	ra,24(sp)
    14b6:	e822                	sd	s0,16(sp)
    14b8:	1000                	add	s0,sp,32
    14ba:	e40c                	sd	a1,8(s0)
    14bc:	e810                	sd	a2,16(s0)
    14be:	ec14                	sd	a3,24(s0)
    14c0:	f018                	sd	a4,32(s0)
    14c2:	f41c                	sd	a5,40(s0)
    14c4:	03043823          	sd	a6,48(s0)
    14c8:	03143c23          	sd	a7,56(s0)
  va_start(ap, fmt);
    14cc:	00840613          	add	a2,s0,8
    14d0:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
    14d4:	85aa                	mv	a1,a0
    14d6:	4505                	li	a0,1
    14d8:	00000097          	auipc	ra,0x0
    14dc:	de0080e7          	jalr	-544(ra) # 12b8 <vprintf>
}
    14e0:	60e2                	ld	ra,24(sp)
    14e2:	6442                	ld	s0,16(sp)
    14e4:	6125                	add	sp,sp,96
    14e6:	8082                	ret

00000000000014e8 <snprintf>:

int
snprintf(char *buf, int sz, char *fmt, ...)
{
    14e8:	7135                	add	sp,sp,-160
    14ea:	f486                	sd	ra,104(sp)
    14ec:	f0a2                	sd	s0,96(sp)
    14ee:	eca6                	sd	s1,88(sp)
    14f0:	1880                	add	s0,sp,112
    14f2:	e414                	sd	a3,8(s0)
    14f4:	e818                	sd	a4,16(s0)
    14f6:	ec1c                	sd	a5,24(s0)
    14f8:	03043023          	sd	a6,32(s0)
    14fc:	03143423          	sd	a7,40(s0)
  va_list ap;
  int i, c;
  int off = 0;
  char *s;

  if (fmt == 0)
    1500:	16060b63          	beqz	a2,1676 <snprintf+0x18e>
    1504:	e8ca                	sd	s2,80(sp)
    1506:	e4ce                	sd	s3,72(sp)
    1508:	fc56                	sd	s5,56(sp)
    150a:	f85a                	sd	s6,48(sp)
    150c:	8b2a                	mv	s6,a0
    150e:	8aae                	mv	s5,a1
    1510:	89b2                	mv	s3,a2
    return -1;

  va_start(ap, fmt);
    1512:	00840793          	add	a5,s0,8
    1516:	f8f43c23          	sd	a5,-104(s0)
  int off = 0;
    151a:	4481                	li	s1,0
  for(i = 0; off < sz && (c = fmt[i] & 0xff) != 0; i++){
    151c:	4901                	li	s2,0
    151e:	00b05f63          	blez	a1,153c <snprintf+0x54>
    1522:	e0d2                	sd	s4,64(sp)
    1524:	f45e                	sd	s7,40(sp)
    1526:	f062                	sd	s8,32(sp)
    1528:	ec66                	sd	s9,24(sp)
    if(c != '%'){
    152a:	02500a13          	li	s4,37
      continue;
    }
    c = fmt[++i] & 0xff;
    if(c == 0)
      break;
    switch(c){
    152e:	07300b93          	li	s7,115
    1532:	07800c93          	li	s9,120
    1536:	06400c13          	li	s8,100
    153a:	a839                	j	1558 <snprintf+0x70>
      off += sputc(buf+off, '%');
      off += sputc(buf+off, c);
      break;
    }
  }
  return off;
    153c:	4481                	li	s1,0
    153e:	6946                	ld	s2,80(sp)
    1540:	69a6                	ld	s3,72(sp)
    1542:	7ae2                	ld	s5,56(sp)
    1544:	7b42                	ld	s6,48(sp)
    1546:	a0cd                	j	1628 <snprintf+0x140>
  *s = c;
    1548:	009b0733          	add	a4,s6,s1
    154c:	00f70023          	sb	a5,0(a4)
      off += sputc(buf+off, c);
    1550:	2485                	addw	s1,s1,1
  for(i = 0; off < sz && (c = fmt[i] & 0xff) != 0; i++){
    1552:	2905                	addw	s2,s2,1
    1554:	1554d563          	bge	s1,s5,169e <snprintf+0x1b6>
    1558:	012987b3          	add	a5,s3,s2
    155c:	0007c783          	lbu	a5,0(a5)
    1560:	0007871b          	sext.w	a4,a5
    1564:	10078063          	beqz	a5,1664 <snprintf+0x17c>
    if(c != '%'){
    1568:	ff4710e3          	bne	a4,s4,1548 <snprintf+0x60>
    c = fmt[++i] & 0xff;
    156c:	2905                	addw	s2,s2,1
    156e:	012987b3          	add	a5,s3,s2
    1572:	0007c783          	lbu	a5,0(a5)
    if(c == 0)
    1576:	10078263          	beqz	a5,167a <snprintf+0x192>
    switch(c){
    157a:	05778c63          	beq	a5,s7,15d2 <snprintf+0xea>
    157e:	02fbe763          	bltu	s7,a5,15ac <snprintf+0xc4>
    1582:	0d478063          	beq	a5,s4,1642 <snprintf+0x15a>
    1586:	0d879463          	bne	a5,s8,164e <snprintf+0x166>
      off += sprintint(buf+off, va_arg(ap, int), 10, 1);
    158a:	f9843783          	ld	a5,-104(s0)
    158e:	00878713          	add	a4,a5,8
    1592:	f8e43c23          	sd	a4,-104(s0)
    1596:	4685                	li	a3,1
    1598:	4629                	li	a2,10
    159a:	438c                	lw	a1,0(a5)
    159c:	009b0533          	add	a0,s6,s1
    15a0:	00000097          	auipc	ra,0x0
    15a4:	bb0080e7          	jalr	-1104(ra) # 1150 <sprintint>
    15a8:	9ca9                	addw	s1,s1,a0
      break;
    15aa:	b765                	j	1552 <snprintf+0x6a>
    switch(c){
    15ac:	0b979163          	bne	a5,s9,164e <snprintf+0x166>
      off += sprintint(buf+off, va_arg(ap, int), 16, 1);
    15b0:	f9843783          	ld	a5,-104(s0)
    15b4:	00878713          	add	a4,a5,8
    15b8:	f8e43c23          	sd	a4,-104(s0)
    15bc:	4685                	li	a3,1
    15be:	4641                	li	a2,16
    15c0:	438c                	lw	a1,0(a5)
    15c2:	009b0533          	add	a0,s6,s1
    15c6:	00000097          	auipc	ra,0x0
    15ca:	b8a080e7          	jalr	-1142(ra) # 1150 <sprintint>
    15ce:	9ca9                	addw	s1,s1,a0
      break;
    15d0:	b749                	j	1552 <snprintf+0x6a>
      if((s = va_arg(ap, char*)) == 0)
    15d2:	f9843783          	ld	a5,-104(s0)
    15d6:	00878713          	add	a4,a5,8
    15da:	f8e43c23          	sd	a4,-104(s0)
    15de:	6388                	ld	a0,0(a5)
    15e0:	c931                	beqz	a0,1634 <snprintf+0x14c>
      for(; *s && off < sz; s++)
    15e2:	00054703          	lbu	a4,0(a0)
    15e6:	d735                	beqz	a4,1552 <snprintf+0x6a>
    15e8:	0b54d263          	bge	s1,s5,168c <snprintf+0x1a4>
    15ec:	009b06b3          	add	a3,s6,s1
    15f0:	409a863b          	subw	a2,s5,s1
    15f4:	1602                	sll	a2,a2,0x20
    15f6:	9201                	srl	a2,a2,0x20
    15f8:	962a                	add	a2,a2,a0
    15fa:	87aa                	mv	a5,a0
        off += sputc(buf+off, *s);
    15fc:	0014859b          	addw	a1,s1,1
    1600:	9d89                	subw	a1,a1,a0
  *s = c;
    1602:	00e68023          	sb	a4,0(a3)
        off += sputc(buf+off, *s);
    1606:	00f584bb          	addw	s1,a1,a5
      for(; *s && off < sz; s++)
    160a:	0785                	add	a5,a5,1
    160c:	0007c703          	lbu	a4,0(a5)
    1610:	d329                	beqz	a4,1552 <snprintf+0x6a>
    1612:	0685                	add	a3,a3,1
    1614:	fec797e3          	bne	a5,a2,1602 <snprintf+0x11a>
    1618:	6946                	ld	s2,80(sp)
    161a:	69a6                	ld	s3,72(sp)
    161c:	6a06                	ld	s4,64(sp)
    161e:	7ae2                	ld	s5,56(sp)
    1620:	7b42                	ld	s6,48(sp)
    1622:	7ba2                	ld	s7,40(sp)
    1624:	7c02                	ld	s8,32(sp)
    1626:	6ce2                	ld	s9,24(sp)
    1628:	8526                	mv	a0,s1
    162a:	70a6                	ld	ra,104(sp)
    162c:	7406                	ld	s0,96(sp)
    162e:	64e6                	ld	s1,88(sp)
    1630:	610d                	add	sp,sp,160
    1632:	8082                	ret
      for(; *s && off < sz; s++)
    1634:	02800713          	li	a4,40
        s = "(null)";
    1638:	00000517          	auipc	a0,0x0
    163c:	4b850513          	add	a0,a0,1208 # 1af0 <malloc+0x3be>
    1640:	b765                	j	15e8 <snprintf+0x100>
  *s = c;
    1642:	009b07b3          	add	a5,s6,s1
    1646:	01478023          	sb	s4,0(a5)
      off += sputc(buf+off, '%');
    164a:	2485                	addw	s1,s1,1
      break;
    164c:	b719                	j	1552 <snprintf+0x6a>
  *s = c;
    164e:	009b0733          	add	a4,s6,s1
    1652:	01470023          	sb	s4,0(a4)
      off += sputc(buf+off, c);
    1656:	0014871b          	addw	a4,s1,1
  *s = c;
    165a:	975a                	add	a4,a4,s6
    165c:	00f70023          	sb	a5,0(a4)
      off += sputc(buf+off, c);
    1660:	2489                	addw	s1,s1,2
      break;
    1662:	bdc5                	j	1552 <snprintf+0x6a>
    1664:	6946                	ld	s2,80(sp)
    1666:	69a6                	ld	s3,72(sp)
    1668:	6a06                	ld	s4,64(sp)
    166a:	7ae2                	ld	s5,56(sp)
    166c:	7b42                	ld	s6,48(sp)
    166e:	7ba2                	ld	s7,40(sp)
    1670:	7c02                	ld	s8,32(sp)
    1672:	6ce2                	ld	s9,24(sp)
    1674:	bf55                	j	1628 <snprintf+0x140>
    return -1;
    1676:	54fd                	li	s1,-1
    1678:	bf45                	j	1628 <snprintf+0x140>
    167a:	6946                	ld	s2,80(sp)
    167c:	69a6                	ld	s3,72(sp)
    167e:	6a06                	ld	s4,64(sp)
    1680:	7ae2                	ld	s5,56(sp)
    1682:	7b42                	ld	s6,48(sp)
    1684:	7ba2                	ld	s7,40(sp)
    1686:	7c02                	ld	s8,32(sp)
    1688:	6ce2                	ld	s9,24(sp)
    168a:	bf79                	j	1628 <snprintf+0x140>
    168c:	6946                	ld	s2,80(sp)
    168e:	69a6                	ld	s3,72(sp)
    1690:	6a06                	ld	s4,64(sp)
    1692:	7ae2                	ld	s5,56(sp)
    1694:	7b42                	ld	s6,48(sp)
    1696:	7ba2                	ld	s7,40(sp)
    1698:	7c02                	ld	s8,32(sp)
    169a:	6ce2                	ld	s9,24(sp)
    169c:	b771                	j	1628 <snprintf+0x140>
    169e:	6946                	ld	s2,80(sp)
    16a0:	69a6                	ld	s3,72(sp)
    16a2:	6a06                	ld	s4,64(sp)
    16a4:	7ae2                	ld	s5,56(sp)
    16a6:	7b42                	ld	s6,48(sp)
    16a8:	7ba2                	ld	s7,40(sp)
    16aa:	7c02                	ld	s8,32(sp)
    16ac:	6ce2                	ld	s9,24(sp)
    16ae:	bfad                	j	1628 <snprintf+0x140>

00000000000016b0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    16b0:	1141                	add	sp,sp,-16
    16b2:	e422                	sd	s0,8(sp)
    16b4:	0800                	add	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
    16b6:	ff050693          	add	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    16ba:	00000797          	auipc	a5,0x0
    16be:	4b67b783          	ld	a5,1206(a5) # 1b70 <freep>
    16c2:	a02d                	j	16ec <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
    16c4:	4618                	lw	a4,8(a2)
    16c6:	9f2d                	addw	a4,a4,a1
    16c8:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
    16cc:	6398                	ld	a4,0(a5)
    16ce:	6310                	ld	a2,0(a4)
    16d0:	a83d                	j	170e <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    16d2:	ff852703          	lw	a4,-8(a0)
    16d6:	9f31                	addw	a4,a4,a2
    16d8:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
    16da:	ff053683          	ld	a3,-16(a0)
    16de:	a091                	j	1722 <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    16e0:	6398                	ld	a4,0(a5)
    16e2:	00e7e463          	bltu	a5,a4,16ea <free+0x3a>
    16e6:	00e6ea63          	bltu	a3,a4,16fa <free+0x4a>
{
    16ea:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    16ec:	fed7fae3          	bgeu	a5,a3,16e0 <free+0x30>
    16f0:	6398                	ld	a4,0(a5)
    16f2:	00e6e463          	bltu	a3,a4,16fa <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    16f6:	fee7eae3          	bltu	a5,a4,16ea <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
    16fa:	ff852583          	lw	a1,-8(a0)
    16fe:	6390                	ld	a2,0(a5)
    1700:	02059813          	sll	a6,a1,0x20
    1704:	01c85713          	srl	a4,a6,0x1c
    1708:	9736                	add	a4,a4,a3
    170a:	fae60de3          	beq	a2,a4,16c4 <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
    170e:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
    1712:	4790                	lw	a2,8(a5)
    1714:	02061593          	sll	a1,a2,0x20
    1718:	01c5d713          	srl	a4,a1,0x1c
    171c:	973e                	add	a4,a4,a5
    171e:	fae68ae3          	beq	a3,a4,16d2 <free+0x22>
    p->s.ptr = bp->s.ptr;
    1722:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
    1724:	00000717          	auipc	a4,0x0
    1728:	44f73623          	sd	a5,1100(a4) # 1b70 <freep>
}
    172c:	6422                	ld	s0,8(sp)
    172e:	0141                	add	sp,sp,16
    1730:	8082                	ret

0000000000001732 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    1732:	7139                	add	sp,sp,-64
    1734:	fc06                	sd	ra,56(sp)
    1736:	f822                	sd	s0,48(sp)
    1738:	f426                	sd	s1,40(sp)
    173a:	ec4e                	sd	s3,24(sp)
    173c:	0080                	add	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    173e:	02051493          	sll	s1,a0,0x20
    1742:	9081                	srl	s1,s1,0x20
    1744:	04bd                	add	s1,s1,15
    1746:	8091                	srl	s1,s1,0x4
    1748:	0014899b          	addw	s3,s1,1
    174c:	0485                	add	s1,s1,1
  if((prevp = freep) == 0){
    174e:	00000517          	auipc	a0,0x0
    1752:	42253503          	ld	a0,1058(a0) # 1b70 <freep>
    1756:	c915                	beqz	a0,178a <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1758:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    175a:	4798                	lw	a4,8(a5)
    175c:	08977e63          	bgeu	a4,s1,17f8 <malloc+0xc6>
    1760:	f04a                	sd	s2,32(sp)
    1762:	e852                	sd	s4,16(sp)
    1764:	e456                	sd	s5,8(sp)
    1766:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
    1768:	8a4e                	mv	s4,s3
    176a:	0009871b          	sext.w	a4,s3
    176e:	6685                	lui	a3,0x1
    1770:	00d77363          	bgeu	a4,a3,1776 <malloc+0x44>
    1774:	6a05                	lui	s4,0x1
    1776:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
    177a:	004a1a1b          	sllw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    177e:	00000917          	auipc	s2,0x0
    1782:	3f290913          	add	s2,s2,1010 # 1b70 <freep>
  if(p == (char*)-1)
    1786:	5afd                	li	s5,-1
    1788:	a091                	j	17cc <malloc+0x9a>
    178a:	f04a                	sd	s2,32(sp)
    178c:	e852                	sd	s4,16(sp)
    178e:	e456                	sd	s5,8(sp)
    1790:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
    1792:	00003797          	auipc	a5,0x3
    1796:	be678793          	add	a5,a5,-1050 # 4378 <base>
    179a:	00000717          	auipc	a4,0x0
    179e:	3cf73b23          	sd	a5,982(a4) # 1b70 <freep>
    17a2:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
    17a4:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
    17a8:	b7c1                	j	1768 <malloc+0x36>
        prevp->s.ptr = p->s.ptr;
    17aa:	6398                	ld	a4,0(a5)
    17ac:	e118                	sd	a4,0(a0)
    17ae:	a08d                	j	1810 <malloc+0xde>
  hp->s.size = nu;
    17b0:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
    17b4:	0541                	add	a0,a0,16
    17b6:	00000097          	auipc	ra,0x0
    17ba:	efa080e7          	jalr	-262(ra) # 16b0 <free>
  return freep;
    17be:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
    17c2:	c13d                	beqz	a0,1828 <malloc+0xf6>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    17c4:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    17c6:	4798                	lw	a4,8(a5)
    17c8:	02977463          	bgeu	a4,s1,17f0 <malloc+0xbe>
    if(p == freep)
    17cc:	00093703          	ld	a4,0(s2)
    17d0:	853e                	mv	a0,a5
    17d2:	fef719e3          	bne	a4,a5,17c4 <malloc+0x92>
  p = sbrk(nu * sizeof(Header));
    17d6:	8552                	mv	a0,s4
    17d8:	00000097          	auipc	ra,0x0
    17dc:	92a080e7          	jalr	-1750(ra) # 1102 <sbrk>
  if(p == (char*)-1)
    17e0:	fd5518e3          	bne	a0,s5,17b0 <malloc+0x7e>
        return 0;
    17e4:	4501                	li	a0,0
    17e6:	7902                	ld	s2,32(sp)
    17e8:	6a42                	ld	s4,16(sp)
    17ea:	6aa2                	ld	s5,8(sp)
    17ec:	6b02                	ld	s6,0(sp)
    17ee:	a03d                	j	181c <malloc+0xea>
    17f0:	7902                	ld	s2,32(sp)
    17f2:	6a42                	ld	s4,16(sp)
    17f4:	6aa2                	ld	s5,8(sp)
    17f6:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
    17f8:	fae489e3          	beq	s1,a4,17aa <malloc+0x78>
        p->s.size -= nunits;
    17fc:	4137073b          	subw	a4,a4,s3
    1800:	c798                	sw	a4,8(a5)
        p += p->s.size;
    1802:	02071693          	sll	a3,a4,0x20
    1806:	01c6d713          	srl	a4,a3,0x1c
    180a:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
    180c:	0137a423          	sw	s3,8(a5)
      freep = prevp;
    1810:	00000717          	auipc	a4,0x0
    1814:	36a73023          	sd	a0,864(a4) # 1b70 <freep>
      return (void*)(p + 1);
    1818:	01078513          	add	a0,a5,16
  }
}
    181c:	70e2                	ld	ra,56(sp)
    181e:	7442                	ld	s0,48(sp)
    1820:	74a2                	ld	s1,40(sp)
    1822:	69e2                	ld	s3,24(sp)
    1824:	6121                	add	sp,sp,64
    1826:	8082                	ret
    1828:	7902                	ld	s2,32(sp)
    182a:	6a42                	ld	s4,16(sp)
    182c:	6aa2                	ld	s5,8(sp)
    182e:	6b02                	ld	s6,0(sp)
    1830:	b7f5                	j	181c <malloc+0xea>
