
user/_nettests:     file format elf64-littleriscv


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

000000000000003e <ping>:
{
      3e:	7171                	add	sp,sp,-176
      40:	f506                	sd	ra,168(sp)
      42:	f122                	sd	s0,160(sp)
      44:	ed26                	sd	s1,152(sp)
      46:	e94a                	sd	s2,144(sp)
      48:	e54e                	sd	s3,136(sp)
      4a:	e152                	sd	s4,128(sp)
      4c:	1900                	add	s0,sp,176
      4e:	8a32                	mv	s4,a2
  if((fd = uconnect(dst, sport, dport)) < 0){
      50:	862e                	mv	a2,a1
      52:	85aa                	mv	a1,a0
      54:	0a000537          	lui	a0,0xa000
      58:	20250513          	add	a0,a0,514 # a000202 <__global_pointer$+0x9ffe599>
      5c:	00001097          	auipc	ra,0x1
      60:	a2a080e7          	jalr	-1494(ra) # a86 <uconnect>
      64:	08054663          	bltz	a0,f0 <ping+0xb2>
      68:	89aa                	mv	s3,a0
  for(int i = 0; i < attempts; i++) {
      6a:	4481                	li	s1,0
    if(write(fd, obuf, strlen(obuf)) < 0){
      6c:	00001917          	auipc	s2,0x1
      70:	15490913          	add	s2,s2,340 # 11c0 <malloc+0x122>
  for(int i = 0; i < attempts; i++) {
      74:	03405463          	blez	s4,9c <ping+0x5e>
    if(write(fd, obuf, strlen(obuf)) < 0){
      78:	854a                	mv	a0,s2
      7a:	00000097          	auipc	ra,0x0
      7e:	71a080e7          	jalr	1818(ra) # 794 <strlen>
      82:	0005061b          	sext.w	a2,a0
      86:	85ca                	mv	a1,s2
      88:	854e                	mv	a0,s3
      8a:	00001097          	auipc	ra,0x1
      8e:	97c080e7          	jalr	-1668(ra) # a06 <write>
      92:	06054d63          	bltz	a0,10c <ping+0xce>
  for(int i = 0; i < attempts; i++) {
      96:	2485                	addw	s1,s1,1
      98:	fe9a10e3          	bne	s4,s1,78 <ping+0x3a>
  int cc = read(fd, ibuf, sizeof(ibuf)-1);
      9c:	07f00613          	li	a2,127
      a0:	f5040593          	add	a1,s0,-176
      a4:	854e                	mv	a0,s3
      a6:	00001097          	auipc	ra,0x1
      aa:	958080e7          	jalr	-1704(ra) # 9fe <read>
      ae:	84aa                	mv	s1,a0
  if(cc < 0){
      b0:	06054c63          	bltz	a0,128 <ping+0xea>
  close(fd);
      b4:	854e                	mv	a0,s3
      b6:	00001097          	auipc	ra,0x1
      ba:	958080e7          	jalr	-1704(ra) # a0e <close>
  ibuf[cc] = '\0';
      be:	fd048793          	add	a5,s1,-48
      c2:	008784b3          	add	s1,a5,s0
      c6:	f8048023          	sb	zero,-128(s1)
  if(strcmp(ibuf, "this is the host!") != 0){
      ca:	00001597          	auipc	a1,0x1
      ce:	13e58593          	add	a1,a1,318 # 1208 <malloc+0x16a>
      d2:	f5040513          	add	a0,s0,-176
      d6:	00000097          	auipc	ra,0x0
      da:	692080e7          	jalr	1682(ra) # 768 <strcmp>
      de:	e13d                	bnez	a0,144 <ping+0x106>
}
      e0:	70aa                	ld	ra,168(sp)
      e2:	740a                	ld	s0,160(sp)
      e4:	64ea                	ld	s1,152(sp)
      e6:	694a                	ld	s2,144(sp)
      e8:	69aa                	ld	s3,136(sp)
      ea:	6a0a                	ld	s4,128(sp)
      ec:	614d                	add	sp,sp,176
      ee:	8082                	ret
    fprintf(2, "ping: uconnect() failed\n");
      f0:	00001597          	auipc	a1,0x1
      f4:	0b058593          	add	a1,a1,176 # 11a0 <malloc+0x102>
      f8:	4509                	li	a0,2
      fa:	00001097          	auipc	ra,0x1
      fe:	cf6080e7          	jalr	-778(ra) # df0 <fprintf>
    exit(1);
     102:	4505                	li	a0,1
     104:	00001097          	auipc	ra,0x1
     108:	8e2080e7          	jalr	-1822(ra) # 9e6 <exit>
      fprintf(2, "ping: send() failed\n");
     10c:	00001597          	auipc	a1,0x1
     110:	0cc58593          	add	a1,a1,204 # 11d8 <malloc+0x13a>
     114:	4509                	li	a0,2
     116:	00001097          	auipc	ra,0x1
     11a:	cda080e7          	jalr	-806(ra) # df0 <fprintf>
      exit(1);
     11e:	4505                	li	a0,1
     120:	00001097          	auipc	ra,0x1
     124:	8c6080e7          	jalr	-1850(ra) # 9e6 <exit>
    fprintf(2, "ping: recv() failed\n");
     128:	00001597          	auipc	a1,0x1
     12c:	0c858593          	add	a1,a1,200 # 11f0 <malloc+0x152>
     130:	4509                	li	a0,2
     132:	00001097          	auipc	ra,0x1
     136:	cbe080e7          	jalr	-834(ra) # df0 <fprintf>
    exit(1);
     13a:	4505                	li	a0,1
     13c:	00001097          	auipc	ra,0x1
     140:	8aa080e7          	jalr	-1878(ra) # 9e6 <exit>
    fprintf(2, "ping didn't receive correct payload\n");
     144:	00001597          	auipc	a1,0x1
     148:	0dc58593          	add	a1,a1,220 # 1220 <malloc+0x182>
     14c:	4509                	li	a0,2
     14e:	00001097          	auipc	ra,0x1
     152:	ca2080e7          	jalr	-862(ra) # df0 <fprintf>
    exit(1);
     156:	4505                	li	a0,1
     158:	00001097          	auipc	ra,0x1
     15c:	88e080e7          	jalr	-1906(ra) # 9e6 <exit>

0000000000000160 <dns>:
  }
}

static void
dns()
{
     160:	7159                	add	sp,sp,-112
     162:	f486                	sd	ra,104(sp)
     164:	f0a2                	sd	s0,96(sp)
     166:	eca6                	sd	s1,88(sp)
     168:	e8ca                	sd	s2,80(sp)
     16a:	e4ce                	sd	s3,72(sp)
     16c:	e0d2                	sd	s4,64(sp)
     16e:	fc56                	sd	s5,56(sp)
     170:	f85a                	sd	s6,48(sp)
     172:	f45e                	sd	s7,40(sp)
     174:	f062                	sd	s8,32(sp)
     176:	ec66                	sd	s9,24(sp)
     178:	e86a                	sd	s10,16(sp)
     17a:	e46e                	sd	s11,8(sp)
     17c:	1880                	add	s0,sp,112
     17e:	81010113          	add	sp,sp,-2032
  uint8 ibuf[N];
  uint32 dst;
  int fd;
  int len;

  memset(obuf, 0, N);
     182:	3e800613          	li	a2,1000
     186:	4581                	li	a1,0
     188:	ba840513          	add	a0,s0,-1112
     18c:	00000097          	auipc	ra,0x0
     190:	660080e7          	jalr	1632(ra) # 7ec <memset>
  memset(ibuf, 0, N);
     194:	3e800613          	li	a2,1000
     198:	4581                	li	a1,0
     19a:	77fd                	lui	a5,0xfffff
     19c:	7c078793          	add	a5,a5,1984 # fffffffffffff7c0 <__global_pointer$+0xffffffffffffdb57>
     1a0:	00f40533          	add	a0,s0,a5
     1a4:	00000097          	auipc	ra,0x0
     1a8:	648080e7          	jalr	1608(ra) # 7ec <memset>
  
  // 8.8.8.8: google's name server
  dst = (8 << 24) | (8 << 16) | (8 << 8) | (8 << 0);

  if((fd = uconnect(dst, 10000, 53)) < 0){
     1ac:	03500613          	li	a2,53
     1b0:	6589                	lui	a1,0x2
     1b2:	71058593          	add	a1,a1,1808 # 2710 <__global_pointer$+0xaa7>
     1b6:	08081537          	lui	a0,0x8081
     1ba:	80850513          	add	a0,a0,-2040 # 8080808 <__global_pointer$+0x807eb9f>
     1be:	00001097          	auipc	ra,0x1
     1c2:	8c8080e7          	jalr	-1848(ra) # a86 <uconnect>
     1c6:	777d                	lui	a4,0xfffff
     1c8:	7b070713          	add	a4,a4,1968 # fffffffffffff7b0 <__global_pointer$+0xffffffffffffdb47>
     1cc:	9722                	add	a4,a4,s0
     1ce:	e308                	sd	a0,0(a4)
     1d0:	02054c63          	bltz	a0,208 <dns+0xa8>
  hdr->id = htons(6828);
     1d4:	77ed                	lui	a5,0xffffb
     1d6:	c1a78793          	add	a5,a5,-998 # ffffffffffffac1a <__global_pointer$+0xffffffffffff8fb1>
     1da:	baf41423          	sh	a5,-1112(s0)
  hdr->rd = 1;
     1de:	baa45783          	lhu	a5,-1110(s0)
     1e2:	0017e793          	or	a5,a5,1
     1e6:	baf41523          	sh	a5,-1110(s0)
  hdr->qdcount = htons(1);
     1ea:	10000793          	li	a5,256
     1ee:	baf41623          	sh	a5,-1108(s0)
  for(char *c = host; c < host+strlen(host)+1; c++) {
     1f2:	00001497          	auipc	s1,0x1
     1f6:	05648493          	add	s1,s1,86 # 1248 <malloc+0x1aa>
  char *l = host; 
     1fa:	8a26                	mv	s4,s1
  for(char *c = host; c < host+strlen(host)+1; c++) {
     1fc:	bb440a93          	add	s5,s0,-1100
     200:	8926                	mv	s2,s1
    if(*c == '.') {
     202:	02e00993          	li	s3,46
  for(char *c = host; c < host+strlen(host)+1; c++) {
     206:	a01d                	j	22c <dns+0xcc>
    fprintf(2, "ping: uconnect() failed\n");
     208:	00001597          	auipc	a1,0x1
     20c:	f9858593          	add	a1,a1,-104 # 11a0 <malloc+0x102>
     210:	4509                	li	a0,2
     212:	00001097          	auipc	ra,0x1
     216:	bde080e7          	jalr	-1058(ra) # df0 <fprintf>
    exit(1);
     21a:	4505                	li	a0,1
     21c:	00000097          	auipc	ra,0x0
     220:	7ca080e7          	jalr	1994(ra) # 9e6 <exit>
      *qn++ = (char) (c-l);
     224:	8ab2                	mv	s5,a2
      l = c+1; // skip .
     226:	00148a13          	add	s4,s1,1
  for(char *c = host; c < host+strlen(host)+1; c++) {
     22a:	0485                	add	s1,s1,1
     22c:	854a                	mv	a0,s2
     22e:	00000097          	auipc	ra,0x0
     232:	566080e7          	jalr	1382(ra) # 794 <strlen>
     236:	02051793          	sll	a5,a0,0x20
     23a:	9381                	srl	a5,a5,0x20
     23c:	0785                	add	a5,a5,1
     23e:	97ca                	add	a5,a5,s2
     240:	02f4fc63          	bgeu	s1,a5,278 <dns+0x118>
    if(*c == '.') {
     244:	0004c783          	lbu	a5,0(s1)
     248:	ff3791e3          	bne	a5,s3,22a <dns+0xca>
      *qn++ = (char) (c-l);
     24c:	001a8613          	add	a2,s5,1
     250:	414487b3          	sub	a5,s1,s4
     254:	00fa8023          	sb	a5,0(s5)
      for(char *d = l; d < c; d++) {
     258:	fc9a76e3          	bgeu	s4,s1,224 <dns+0xc4>
     25c:	87d2                	mv	a5,s4
      *qn++ = (char) (c-l);
     25e:	8732                	mv	a4,a2
        *qn++ = *d;
     260:	0705                	add	a4,a4,1
     262:	0007c683          	lbu	a3,0(a5)
     266:	fed70fa3          	sb	a3,-1(a4)
      for(char *d = l; d < c; d++) {
     26a:	0785                	add	a5,a5,1
     26c:	fef49ae3          	bne	s1,a5,260 <dns+0x100>
     270:	41448ab3          	sub	s5,s1,s4
     274:	9ab2                	add	s5,s5,a2
     276:	bf45                	j	226 <dns+0xc6>
  *qn = '\0';
     278:	000a8023          	sb	zero,0(s5)
  len += strlen(qname) + 1;
     27c:	bb440513          	add	a0,s0,-1100
     280:	00000097          	auipc	ra,0x0
     284:	514080e7          	jalr	1300(ra) # 794 <strlen>
     288:	0005049b          	sext.w	s1,a0
  struct dns_question *h = (struct dns_question *) (qname+strlen(qname)+1);
     28c:	bb440513          	add	a0,s0,-1100
     290:	00000097          	auipc	ra,0x0
     294:	504080e7          	jalr	1284(ra) # 794 <strlen>
     298:	02051793          	sll	a5,a0,0x20
     29c:	9381                	srl	a5,a5,0x20
     29e:	0785                	add	a5,a5,1
     2a0:	bb440713          	add	a4,s0,-1100
     2a4:	97ba                	add	a5,a5,a4
  h->qtype = htons(0x1);
     2a6:	00078023          	sb	zero,0(a5)
     2aa:	4705                	li	a4,1
     2ac:	00e780a3          	sb	a4,1(a5)
  h->qclass = htons(0x1);
     2b0:	00078123          	sb	zero,2(a5)
     2b4:	00e781a3          	sb	a4,3(a5)
  }

  len = dns_req(obuf);
  
  if(write(fd, obuf, len) < 0){
     2b8:	0114861b          	addw	a2,s1,17
     2bc:	ba840593          	add	a1,s0,-1112
     2c0:	77fd                	lui	a5,0xfffff
     2c2:	7b078793          	add	a5,a5,1968 # fffffffffffff7b0 <__global_pointer$+0xffffffffffffdb47>
     2c6:	97a2                	add	a5,a5,s0
     2c8:	6388                	ld	a0,0(a5)
     2ca:	00000097          	auipc	ra,0x0
     2ce:	73c080e7          	jalr	1852(ra) # a06 <write>
     2d2:	10054863          	bltz	a0,3e2 <dns+0x282>
    fprintf(2, "dns: send() failed\n");
    exit(1);
  }
  int cc = read(fd, ibuf, sizeof(ibuf));
     2d6:	3e800613          	li	a2,1000
     2da:	77fd                	lui	a5,0xfffff
     2dc:	7c078793          	add	a5,a5,1984 # fffffffffffff7c0 <__global_pointer$+0xffffffffffffdb57>
     2e0:	00f405b3          	add	a1,s0,a5
     2e4:	74fd                	lui	s1,0xfffff
     2e6:	7b048793          	add	a5,s1,1968 # fffffffffffff7b0 <__global_pointer$+0xffffffffffffdb47>
     2ea:	97a2                	add	a5,a5,s0
     2ec:	6388                	ld	a0,0(a5)
     2ee:	00000097          	auipc	ra,0x0
     2f2:	710080e7          	jalr	1808(ra) # 9fe <read>
     2f6:	7a848713          	add	a4,s1,1960
     2fa:	9722                	add	a4,a4,s0
     2fc:	e308                	sd	a0,0(a4)
  if(cc < 0){
     2fe:	10054063          	bltz	a0,3fe <dns+0x29e>
  if(!hdr->qr) {
     302:	77fd                	lui	a5,0xfffff
     304:	7c278793          	add	a5,a5,1986 # fffffffffffff7c2 <__global_pointer$+0xffffffffffffdb59>
     308:	97a2                	add	a5,a5,s0
     30a:	00078783          	lb	a5,0(a5)
     30e:	1007d663          	bgez	a5,41a <dns+0x2ba>
  if(hdr->id != htons(6828))
     312:	77fd                	lui	a5,0xfffff
     314:	7c078793          	add	a5,a5,1984 # fffffffffffff7c0 <__global_pointer$+0xffffffffffffdb57>
     318:	97a2                	add	a5,a5,s0
     31a:	0007d703          	lhu	a4,0(a5)
     31e:	0007069b          	sext.w	a3,a4
     322:	67ad                	lui	a5,0xb
     324:	c1a78793          	add	a5,a5,-998 # ac1a <__global_pointer$+0x8fb1>
     328:	0ef69e63          	bne	a3,a5,424 <dns+0x2c4>
  if(hdr->rcode != 0) {
     32c:	777d                	lui	a4,0xfffff
     32e:	7c370793          	add	a5,a4,1987 # fffffffffffff7c3 <__global_pointer$+0xffffffffffffdb5a>
     332:	97a2                	add	a5,a5,s0
     334:	0007c783          	lbu	a5,0(a5)
     338:	8bbd                	and	a5,a5,15
     33a:	10079563          	bnez	a5,444 <dns+0x2e4>
  for(int i =0; i < ntohs(hdr->qdcount); i++) {
     33e:	7c470793          	add	a5,a4,1988
     342:	97a2                	add	a5,a5,s0
     344:	0007d783          	lhu	a5,0(a5)
     348:	4981                	li	s3,0
  len = sizeof(struct dns);
     34a:	44b1                	li	s1,12
  char *qname = 0;
     34c:	4901                	li	s2,0
  for(int i =0; i < ntohs(hdr->qdcount); i++) {
     34e:	c3a9                	beqz	a5,390 <dns+0x230>
    char *qn = (char *) (ibuf+len);
     350:	7a7d                	lui	s4,0xfffff
     352:	7c0a0793          	add	a5,s4,1984 # fffffffffffff7c0 <__global_pointer$+0xffffffffffffdb57>
     356:	97a2                	add	a5,a5,s0
     358:	00978933          	add	s2,a5,s1
    decode_qname(qn);
     35c:	854a                	mv	a0,s2
     35e:	00000097          	auipc	ra,0x0
     362:	ca2080e7          	jalr	-862(ra) # 0 <decode_qname>
    len += strlen(qn)+1;
     366:	854a                	mv	a0,s2
     368:	00000097          	auipc	ra,0x0
     36c:	42c080e7          	jalr	1068(ra) # 794 <strlen>
    len += sizeof(struct dns_question);
     370:	2515                	addw	a0,a0,5
     372:	9ca9                	addw	s1,s1,a0
  for(int i =0; i < ntohs(hdr->qdcount); i++) {
     374:	2985                	addw	s3,s3,1
// endianness support
//

static inline uint16 bswaps(uint16 val)
{
  return (((val & 0x00ffU) << 8) |
     376:	7c4a0793          	add	a5,s4,1988
     37a:	97a2                	add	a5,a5,s0
     37c:	0007d783          	lhu	a5,0(a5)
     380:	0087971b          	sllw	a4,a5,0x8
     384:	83a1                	srl	a5,a5,0x8
     386:	8fd9                	or	a5,a5,a4
     388:	17c2                	sll	a5,a5,0x30
     38a:	93c1                	srl	a5,a5,0x30
     38c:	fcf9c2e3          	blt	s3,a5,350 <dns+0x1f0>
  for(int i = 0; i < ntohs(hdr->ancount); i++) {
     390:	77fd                	lui	a5,0xfffff
     392:	7c678793          	add	a5,a5,1990 # fffffffffffff7c6 <__global_pointer$+0xffffffffffffdb5d>
     396:	97a2                	add	a5,a5,s0
     398:	0007d783          	lhu	a5,0(a5)
     39c:	22078863          	beqz	a5,5cc <dns+0x46c>
     3a0:	00001797          	auipc	a5,0x1
     3a4:	f8878793          	add	a5,a5,-120 # 1328 <malloc+0x28a>
     3a8:	00090363          	beqz	s2,3ae <dns+0x24e>
     3ac:	87ca                	mv	a5,s2
     3ae:	777d                	lui	a4,0xfffff
     3b0:	7b870713          	add	a4,a4,1976 # fffffffffffff7b8 <__global_pointer$+0xffffffffffffdb4f>
     3b4:	9722                	add	a4,a4,s0
     3b6:	e31c                	sd	a5,0(a4)
  int record = 0;
     3b8:	4b81                	li	s7,0
  for(int i = 0; i < ntohs(hdr->ancount); i++) {
     3ba:	4901                	li	s2,0
    if((int) qn[0] > 63) {  // compression?
     3bc:	03f00a93          	li	s5,63
    if(ntohs(d->type) == ARECORD && ntohs(d->len) == 4) {
     3c0:	10000a13          	li	s4,256
     3c4:	40000b13          	li	s6,1024
      printf("DNS arecord for %s is ", qname ? qname : "" );
     3c8:	00001d97          	auipc	s11,0x1
     3cc:	ef8d8d93          	add	s11,s11,-264 # 12c0 <malloc+0x222>
      printf("%d.%d.%d.%d\n", ip[0], ip[1], ip[2], ip[3]);
     3d0:	00001c17          	auipc	s8,0x1
     3d4:	f08c0c13          	add	s8,s8,-248 # 12d8 <malloc+0x23a>
      if(ip[0] != 128 || ip[1] != 52 || ip[2] != 129 || ip[3] != 126) {
     3d8:	08000d13          	li	s10,128
     3dc:	03400c93          	li	s9,52
     3e0:	a0e9                	j	4aa <dns+0x34a>
    fprintf(2, "dns: send() failed\n");
     3e2:	00001597          	auipc	a1,0x1
     3e6:	e7e58593          	add	a1,a1,-386 # 1260 <malloc+0x1c2>
     3ea:	4509                	li	a0,2
     3ec:	00001097          	auipc	ra,0x1
     3f0:	a04080e7          	jalr	-1532(ra) # df0 <fprintf>
    exit(1);
     3f4:	4505                	li	a0,1
     3f6:	00000097          	auipc	ra,0x0
     3fa:	5f0080e7          	jalr	1520(ra) # 9e6 <exit>
    fprintf(2, "dns: recv() failed\n");
     3fe:	00001597          	auipc	a1,0x1
     402:	e7a58593          	add	a1,a1,-390 # 1278 <malloc+0x1da>
     406:	4509                	li	a0,2
     408:	00001097          	auipc	ra,0x1
     40c:	9e8080e7          	jalr	-1560(ra) # df0 <fprintf>
    exit(1);
     410:	4505                	li	a0,1
     412:	00000097          	auipc	ra,0x0
     416:	5d4080e7          	jalr	1492(ra) # 9e6 <exit>
    exit(1);
     41a:	4505                	li	a0,1
     41c:	00000097          	auipc	ra,0x0
     420:	5ca080e7          	jalr	1482(ra) # 9e6 <exit>
     424:	0087159b          	sllw	a1,a4,0x8
     428:	0087571b          	srlw	a4,a4,0x8
     42c:	8dd9                	or	a1,a1,a4
    printf("DNS wrong id: %d\n", ntohs(hdr->id));
     42e:	15c2                	sll	a1,a1,0x30
     430:	91c1                	srl	a1,a1,0x30
     432:	00001517          	auipc	a0,0x1
     436:	e5e50513          	add	a0,a0,-418 # 1290 <malloc+0x1f2>
     43a:	00001097          	auipc	ra,0x1
     43e:	9e4080e7          	jalr	-1564(ra) # e1e <printf>
     442:	b5ed                	j	32c <dns+0x1cc>
    printf("DNS rcode error: %x\n", hdr->rcode);
     444:	77fd                	lui	a5,0xfffff
     446:	7c378793          	add	a5,a5,1987 # fffffffffffff7c3 <__global_pointer$+0xffffffffffffdb5a>
     44a:	97a2                	add	a5,a5,s0
     44c:	0007c583          	lbu	a1,0(a5)
     450:	89bd                	and	a1,a1,15
     452:	00001517          	auipc	a0,0x1
     456:	e5650513          	add	a0,a0,-426 # 12a8 <malloc+0x20a>
     45a:	00001097          	auipc	ra,0x1
     45e:	9c4080e7          	jalr	-1596(ra) # e1e <printf>
    exit(1);
     462:	4505                	li	a0,1
     464:	00000097          	auipc	ra,0x0
     468:	582080e7          	jalr	1410(ra) # 9e6 <exit>
      decode_qname(qn);
     46c:	854e                	mv	a0,s3
     46e:	00000097          	auipc	ra,0x0
     472:	b92080e7          	jalr	-1134(ra) # 0 <decode_qname>
      len += strlen(qn)+1;
     476:	854e                	mv	a0,s3
     478:	00000097          	auipc	ra,0x0
     47c:	31c080e7          	jalr	796(ra) # 794 <strlen>
     480:	2485                	addw	s1,s1,1
     482:	9ca9                	addw	s1,s1,a0
     484:	a835                	j	4c0 <dns+0x360>
      len += 4;
     486:	00e9849b          	addw	s1,s3,14
      record = 1;
     48a:	4b85                	li	s7,1
  for(int i = 0; i < ntohs(hdr->ancount); i++) {
     48c:	2905                	addw	s2,s2,1
     48e:	77fd                	lui	a5,0xfffff
     490:	7c678793          	add	a5,a5,1990 # fffffffffffff7c6 <__global_pointer$+0xffffffffffffdb5d>
     494:	97a2                	add	a5,a5,s0
     496:	0007d783          	lhu	a5,0(a5)
     49a:	0087971b          	sllw	a4,a5,0x8
     49e:	83a1                	srl	a5,a5,0x8
     4a0:	8fd9                	or	a5,a5,a4
     4a2:	17c2                	sll	a5,a5,0x30
     4a4:	93c1                	srl	a5,a5,0x30
     4a6:	0cf95363          	bge	s2,a5,56c <dns+0x40c>
    char *qn = (char *) (ibuf+len);
     4aa:	77fd                	lui	a5,0xfffff
     4ac:	7c078793          	add	a5,a5,1984 # fffffffffffff7c0 <__global_pointer$+0xffffffffffffdb57>
     4b0:	97a2                	add	a5,a5,s0
     4b2:	009789b3          	add	s3,a5,s1
    if((int) qn[0] > 63) {  // compression?
     4b6:	0009c783          	lbu	a5,0(s3)
     4ba:	fafaf9e3          	bgeu	s5,a5,46c <dns+0x30c>
      len += 2;
     4be:	2489                	addw	s1,s1,2
    struct dns_data *d = (struct dns_data *) (ibuf+len);
     4c0:	77fd                	lui	a5,0xfffff
     4c2:	7c078793          	add	a5,a5,1984 # fffffffffffff7c0 <__global_pointer$+0xffffffffffffdb57>
     4c6:	97a2                	add	a5,a5,s0
     4c8:	00978733          	add	a4,a5,s1
    len += sizeof(struct dns_data);
     4cc:	0004899b          	sext.w	s3,s1
     4d0:	24a9                	addw	s1,s1,10
    if(ntohs(d->type) == ARECORD && ntohs(d->len) == 4) {
     4d2:	00074683          	lbu	a3,0(a4)
     4d6:	00174783          	lbu	a5,1(a4)
     4da:	07a2                	sll	a5,a5,0x8
     4dc:	8fd5                	or	a5,a5,a3
     4de:	fb4797e3          	bne	a5,s4,48c <dns+0x32c>
     4e2:	00874683          	lbu	a3,8(a4)
     4e6:	00974783          	lbu	a5,9(a4)
     4ea:	07a2                	sll	a5,a5,0x8
     4ec:	8fd5                	or	a5,a5,a3
     4ee:	f9679fe3          	bne	a5,s6,48c <dns+0x32c>
      printf("DNS arecord for %s is ", qname ? qname : "" );
     4f2:	77fd                	lui	a5,0xfffff
     4f4:	7b878793          	add	a5,a5,1976 # fffffffffffff7b8 <__global_pointer$+0xffffffffffffdb4f>
     4f8:	97a2                	add	a5,a5,s0
     4fa:	638c                	ld	a1,0(a5)
     4fc:	856e                	mv	a0,s11
     4fe:	00001097          	auipc	ra,0x1
     502:	920080e7          	jalr	-1760(ra) # e1e <printf>
      uint8 *ip = (ibuf+len);
     506:	77fd                	lui	a5,0xfffff
     508:	7c078793          	add	a5,a5,1984 # fffffffffffff7c0 <__global_pointer$+0xffffffffffffdb57>
     50c:	97a2                	add	a5,a5,s0
     50e:	94be                	add	s1,s1,a5
      printf("%d.%d.%d.%d\n", ip[0], ip[1], ip[2], ip[3]);
     510:	0034c703          	lbu	a4,3(s1)
     514:	0024c683          	lbu	a3,2(s1)
     518:	0014c603          	lbu	a2,1(s1)
     51c:	0004c583          	lbu	a1,0(s1)
     520:	8562                	mv	a0,s8
     522:	00001097          	auipc	ra,0x1
     526:	8fc080e7          	jalr	-1796(ra) # e1e <printf>
      if(ip[0] != 128 || ip[1] != 52 || ip[2] != 129 || ip[3] != 126) {
     52a:	0004c783          	lbu	a5,0(s1)
     52e:	03a79263          	bne	a5,s10,552 <dns+0x3f2>
     532:	0014c783          	lbu	a5,1(s1)
     536:	01979e63          	bne	a5,s9,552 <dns+0x3f2>
     53a:	0024c703          	lbu	a4,2(s1)
     53e:	08100793          	li	a5,129
     542:	00f71863          	bne	a4,a5,552 <dns+0x3f2>
     546:	0034c703          	lbu	a4,3(s1)
     54a:	07e00793          	li	a5,126
     54e:	f2f70ce3          	beq	a4,a5,486 <dns+0x326>
        printf("wrong ip address");
     552:	00001517          	auipc	a0,0x1
     556:	d9650513          	add	a0,a0,-618 # 12e8 <malloc+0x24a>
     55a:	00001097          	auipc	ra,0x1
     55e:	8c4080e7          	jalr	-1852(ra) # e1e <printf>
        exit(1);
     562:	4505                	li	a0,1
     564:	00000097          	auipc	ra,0x0
     568:	482080e7          	jalr	1154(ra) # 9e6 <exit>
  if(len != cc) {
     56c:	77fd                	lui	a5,0xfffff
     56e:	7a878793          	add	a5,a5,1960 # fffffffffffff7a8 <__global_pointer$+0xffffffffffffdb3f>
     572:	97a2                	add	a5,a5,s0
     574:	639c                	ld	a5,0(a5)
     576:	06979263          	bne	a5,s1,5da <dns+0x47a>
  if(!record) {
     57a:	020b8c63          	beqz	s7,5b2 <dns+0x452>
  }
  dns_rep(ibuf, cc);

  close(fd);
     57e:	77fd                	lui	a5,0xfffff
     580:	7b078793          	add	a5,a5,1968 # fffffffffffff7b0 <__global_pointer$+0xffffffffffffdb47>
     584:	97a2                	add	a5,a5,s0
     586:	6388                	ld	a0,0(a5)
     588:	00000097          	auipc	ra,0x0
     58c:	486080e7          	jalr	1158(ra) # a0e <close>
}  
     590:	7f010113          	add	sp,sp,2032
     594:	70a6                	ld	ra,104(sp)
     596:	7406                	ld	s0,96(sp)
     598:	64e6                	ld	s1,88(sp)
     59a:	6946                	ld	s2,80(sp)
     59c:	69a6                	ld	s3,72(sp)
     59e:	6a06                	ld	s4,64(sp)
     5a0:	7ae2                	ld	s5,56(sp)
     5a2:	7b42                	ld	s6,48(sp)
     5a4:	7ba2                	ld	s7,40(sp)
     5a6:	7c02                	ld	s8,32(sp)
     5a8:	6ce2                	ld	s9,24(sp)
     5aa:	6d42                	ld	s10,16(sp)
     5ac:	6da2                	ld	s11,8(sp)
     5ae:	6165                	add	sp,sp,112
     5b0:	8082                	ret
    printf("Didn't receive an arecord\n");
     5b2:	00001517          	auipc	a0,0x1
     5b6:	d7e50513          	add	a0,a0,-642 # 1330 <malloc+0x292>
     5ba:	00001097          	auipc	ra,0x1
     5be:	864080e7          	jalr	-1948(ra) # e1e <printf>
    exit(1);
     5c2:	4505                	li	a0,1
     5c4:	00000097          	auipc	ra,0x0
     5c8:	422080e7          	jalr	1058(ra) # 9e6 <exit>
  if(len != cc) {
     5cc:	77fd                	lui	a5,0xfffff
     5ce:	7a878793          	add	a5,a5,1960 # fffffffffffff7a8 <__global_pointer$+0xffffffffffffdb3f>
     5d2:	97a2                	add	a5,a5,s0
     5d4:	639c                	ld	a5,0(a5)
     5d6:	fc978ee3          	beq	a5,s1,5b2 <dns+0x452>
    printf("Processed %d data bytes but received %d\n", len, cc);
     5da:	77fd                	lui	a5,0xfffff
     5dc:	7a878793          	add	a5,a5,1960 # fffffffffffff7a8 <__global_pointer$+0xffffffffffffdb3f>
     5e0:	97a2                	add	a5,a5,s0
     5e2:	6390                	ld	a2,0(a5)
     5e4:	85a6                	mv	a1,s1
     5e6:	00001517          	auipc	a0,0x1
     5ea:	d1a50513          	add	a0,a0,-742 # 1300 <malloc+0x262>
     5ee:	00001097          	auipc	ra,0x1
     5f2:	830080e7          	jalr	-2000(ra) # e1e <printf>
    exit(1);
     5f6:	4505                	li	a0,1
     5f8:	00000097          	auipc	ra,0x0
     5fc:	3ee080e7          	jalr	1006(ra) # 9e6 <exit>

0000000000000600 <main>:

int
main(int argc, char *argv[])
{
     600:	7179                	add	sp,sp,-48
     602:	f406                	sd	ra,40(sp)
     604:	f022                	sd	s0,32(sp)
     606:	ec26                	sd	s1,24(sp)
     608:	e84a                	sd	s2,16(sp)
     60a:	1800                	add	s0,sp,48
  int i, ret;
  uint16 dport = NET_TESTS_PORT;

  printf("nettests running on port %d\n", dport);
     60c:	6599                	lui	a1,0x6
     60e:	40158593          	add	a1,a1,1025 # 6401 <__global_pointer$+0x4798>
     612:	00001517          	auipc	a0,0x1
     616:	d3e50513          	add	a0,a0,-706 # 1350 <malloc+0x2b2>
     61a:	00001097          	auipc	ra,0x1
     61e:	804080e7          	jalr	-2044(ra) # e1e <printf>

  printf("testing ping: ");
     622:	00001517          	auipc	a0,0x1
     626:	d4e50513          	add	a0,a0,-690 # 1370 <malloc+0x2d2>
     62a:	00000097          	auipc	ra,0x0
     62e:	7f4080e7          	jalr	2036(ra) # e1e <printf>
  ping(2000, dport, 1);
     632:	4605                	li	a2,1
     634:	6599                	lui	a1,0x6
     636:	40158593          	add	a1,a1,1025 # 6401 <__global_pointer$+0x4798>
     63a:	7d000513          	li	a0,2000
     63e:	00000097          	auipc	ra,0x0
     642:	a00080e7          	jalr	-1536(ra) # 3e <ping>
  printf("OK\n");
     646:	00001517          	auipc	a0,0x1
     64a:	d3a50513          	add	a0,a0,-710 # 1380 <malloc+0x2e2>
     64e:	00000097          	auipc	ra,0x0
     652:	7d0080e7          	jalr	2000(ra) # e1e <printf>

  printf("testing single-process pings: ");
     656:	00001517          	auipc	a0,0x1
     65a:	d3250513          	add	a0,a0,-718 # 1388 <malloc+0x2ea>
     65e:	00000097          	auipc	ra,0x0
     662:	7c0080e7          	jalr	1984(ra) # e1e <printf>
     666:	06400493          	li	s1,100
  for (i = 0; i < 100; i++)
    ping(2000, dport, 1);
     66a:	6919                	lui	s2,0x6
     66c:	40190913          	add	s2,s2,1025 # 6401 <__global_pointer$+0x4798>
     670:	4605                	li	a2,1
     672:	85ca                	mv	a1,s2
     674:	7d000513          	li	a0,2000
     678:	00000097          	auipc	ra,0x0
     67c:	9c6080e7          	jalr	-1594(ra) # 3e <ping>
  for (i = 0; i < 100; i++)
     680:	34fd                	addw	s1,s1,-1
     682:	f4fd                	bnez	s1,670 <main+0x70>
  printf("OK\n");
     684:	00001517          	auipc	a0,0x1
     688:	cfc50513          	add	a0,a0,-772 # 1380 <malloc+0x2e2>
     68c:	00000097          	auipc	ra,0x0
     690:	792080e7          	jalr	1938(ra) # e1e <printf>

  printf("testing multi-process pings: ");
     694:	00001517          	auipc	a0,0x1
     698:	d1450513          	add	a0,a0,-748 # 13a8 <malloc+0x30a>
     69c:	00000097          	auipc	ra,0x0
     6a0:	782080e7          	jalr	1922(ra) # e1e <printf>
  for (i = 0; i < 10; i++){
     6a4:	4929                	li	s2,10
    int pid = fork();
     6a6:	00000097          	auipc	ra,0x0
     6aa:	338080e7          	jalr	824(ra) # 9de <fork>
    if (pid == 0){
     6ae:	c92d                	beqz	a0,720 <main+0x120>
  for (i = 0; i < 10; i++){
     6b0:	2485                	addw	s1,s1,1
     6b2:	ff249ae3          	bne	s1,s2,6a6 <main+0xa6>
     6b6:	44a9                	li	s1,10
      ping(2000 + i + 1, dport, 1);
      exit(0);
    }
  }
  for (i = 0; i < 10; i++){
    wait(&ret);
     6b8:	fdc40513          	add	a0,s0,-36
     6bc:	00000097          	auipc	ra,0x0
     6c0:	332080e7          	jalr	818(ra) # 9ee <wait>
    if (ret != 0)
     6c4:	fdc42783          	lw	a5,-36(s0)
     6c8:	efad                	bnez	a5,742 <main+0x142>
  for (i = 0; i < 10; i++){
     6ca:	34fd                	addw	s1,s1,-1
     6cc:	f4f5                	bnez	s1,6b8 <main+0xb8>
      exit(1);
  }
  printf("OK\n");
     6ce:	00001517          	auipc	a0,0x1
     6d2:	cb250513          	add	a0,a0,-846 # 1380 <malloc+0x2e2>
     6d6:	00000097          	auipc	ra,0x0
     6da:	748080e7          	jalr	1864(ra) # e1e <printf>
  
  printf("testing DNS\n");
     6de:	00001517          	auipc	a0,0x1
     6e2:	cea50513          	add	a0,a0,-790 # 13c8 <malloc+0x32a>
     6e6:	00000097          	auipc	ra,0x0
     6ea:	738080e7          	jalr	1848(ra) # e1e <printf>
  dns();
     6ee:	00000097          	auipc	ra,0x0
     6f2:	a72080e7          	jalr	-1422(ra) # 160 <dns>
  printf("DNS OK\n");
     6f6:	00001517          	auipc	a0,0x1
     6fa:	ce250513          	add	a0,a0,-798 # 13d8 <malloc+0x33a>
     6fe:	00000097          	auipc	ra,0x0
     702:	720080e7          	jalr	1824(ra) # e1e <printf>
  
  printf("all tests passed.\n");
     706:	00001517          	auipc	a0,0x1
     70a:	cda50513          	add	a0,a0,-806 # 13e0 <malloc+0x342>
     70e:	00000097          	auipc	ra,0x0
     712:	710080e7          	jalr	1808(ra) # e1e <printf>
  exit(0);
     716:	4501                	li	a0,0
     718:	00000097          	auipc	ra,0x0
     71c:	2ce080e7          	jalr	718(ra) # 9e6 <exit>
      ping(2000 + i + 1, dport, 1);
     720:	7d14851b          	addw	a0,s1,2001
     724:	4605                	li	a2,1
     726:	6599                	lui	a1,0x6
     728:	40158593          	add	a1,a1,1025 # 6401 <__global_pointer$+0x4798>
     72c:	1542                	sll	a0,a0,0x30
     72e:	9141                	srl	a0,a0,0x30
     730:	00000097          	auipc	ra,0x0
     734:	90e080e7          	jalr	-1778(ra) # 3e <ping>
      exit(0);
     738:	4501                	li	a0,0
     73a:	00000097          	auipc	ra,0x0
     73e:	2ac080e7          	jalr	684(ra) # 9e6 <exit>
      exit(1);
     742:	4505                	li	a0,1
     744:	00000097          	auipc	ra,0x0
     748:	2a2080e7          	jalr	674(ra) # 9e6 <exit>

000000000000074c <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
     74c:	1141                	add	sp,sp,-16
     74e:	e422                	sd	s0,8(sp)
     750:	0800                	add	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
     752:	87aa                	mv	a5,a0
     754:	0585                	add	a1,a1,1
     756:	0785                	add	a5,a5,1
     758:	fff5c703          	lbu	a4,-1(a1)
     75c:	fee78fa3          	sb	a4,-1(a5)
     760:	fb75                	bnez	a4,754 <strcpy+0x8>
    ;
  return os;
}
     762:	6422                	ld	s0,8(sp)
     764:	0141                	add	sp,sp,16
     766:	8082                	ret

0000000000000768 <strcmp>:

int
strcmp(const char *p, const char *q)
{
     768:	1141                	add	sp,sp,-16
     76a:	e422                	sd	s0,8(sp)
     76c:	0800                	add	s0,sp,16
  while(*p && *p == *q)
     76e:	00054783          	lbu	a5,0(a0)
     772:	cb91                	beqz	a5,786 <strcmp+0x1e>
     774:	0005c703          	lbu	a4,0(a1)
     778:	00f71763          	bne	a4,a5,786 <strcmp+0x1e>
    p++, q++;
     77c:	0505                	add	a0,a0,1
     77e:	0585                	add	a1,a1,1
  while(*p && *p == *q)
     780:	00054783          	lbu	a5,0(a0)
     784:	fbe5                	bnez	a5,774 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
     786:	0005c503          	lbu	a0,0(a1)
}
     78a:	40a7853b          	subw	a0,a5,a0
     78e:	6422                	ld	s0,8(sp)
     790:	0141                	add	sp,sp,16
     792:	8082                	ret

0000000000000794 <strlen>:

uint
strlen(const char *s)
{
     794:	1141                	add	sp,sp,-16
     796:	e422                	sd	s0,8(sp)
     798:	0800                	add	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
     79a:	00054783          	lbu	a5,0(a0)
     79e:	cf91                	beqz	a5,7ba <strlen+0x26>
     7a0:	0505                	add	a0,a0,1
     7a2:	87aa                	mv	a5,a0
     7a4:	86be                	mv	a3,a5
     7a6:	0785                	add	a5,a5,1
     7a8:	fff7c703          	lbu	a4,-1(a5)
     7ac:	ff65                	bnez	a4,7a4 <strlen+0x10>
     7ae:	40a6853b          	subw	a0,a3,a0
     7b2:	2505                	addw	a0,a0,1
    ;
  return n;
}
     7b4:	6422                	ld	s0,8(sp)
     7b6:	0141                	add	sp,sp,16
     7b8:	8082                	ret
  for(n = 0; s[n]; n++)
     7ba:	4501                	li	a0,0
     7bc:	bfe5                	j	7b4 <strlen+0x20>

00000000000007be <strcat>:

char *
strcat(char *dst, char *src)
{
     7be:	1141                	add	sp,sp,-16
     7c0:	e422                	sd	s0,8(sp)
     7c2:	0800                	add	s0,sp,16
  char *s = dst;
  while (*dst)
     7c4:	00054783          	lbu	a5,0(a0)
     7c8:	c385                	beqz	a5,7e8 <strcat+0x2a>
     7ca:	87aa                	mv	a5,a0
    dst++;
     7cc:	0785                	add	a5,a5,1
  while (*dst)
     7ce:	0007c703          	lbu	a4,0(a5)
     7d2:	ff6d                	bnez	a4,7cc <strcat+0xe>
  while ((*dst++ = *src++) != 0);
     7d4:	0585                	add	a1,a1,1
     7d6:	0785                	add	a5,a5,1
     7d8:	fff5c703          	lbu	a4,-1(a1)
     7dc:	fee78fa3          	sb	a4,-1(a5)
     7e0:	fb75                	bnez	a4,7d4 <strcat+0x16>

  return s;
}
     7e2:	6422                	ld	s0,8(sp)
     7e4:	0141                	add	sp,sp,16
     7e6:	8082                	ret
  while (*dst)
     7e8:	87aa                	mv	a5,a0
     7ea:	b7ed                	j	7d4 <strcat+0x16>

00000000000007ec <memset>:

void*
memset(void *dst, int c, uint n)
{
     7ec:	1141                	add	sp,sp,-16
     7ee:	e422                	sd	s0,8(sp)
     7f0:	0800                	add	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
     7f2:	ca19                	beqz	a2,808 <memset+0x1c>
     7f4:	87aa                	mv	a5,a0
     7f6:	1602                	sll	a2,a2,0x20
     7f8:	9201                	srl	a2,a2,0x20
     7fa:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
     7fe:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
     802:	0785                	add	a5,a5,1
     804:	fee79de3          	bne	a5,a4,7fe <memset+0x12>
  }
  return dst;
}
     808:	6422                	ld	s0,8(sp)
     80a:	0141                	add	sp,sp,16
     80c:	8082                	ret

000000000000080e <strchr>:

char*
strchr(const char *s, char c)
{
     80e:	1141                	add	sp,sp,-16
     810:	e422                	sd	s0,8(sp)
     812:	0800                	add	s0,sp,16
  for(; *s; s++)
     814:	00054783          	lbu	a5,0(a0)
     818:	cb99                	beqz	a5,82e <strchr+0x20>
    if(*s == c)
     81a:	00f58763          	beq	a1,a5,828 <strchr+0x1a>
  for(; *s; s++)
     81e:	0505                	add	a0,a0,1
     820:	00054783          	lbu	a5,0(a0)
     824:	fbfd                	bnez	a5,81a <strchr+0xc>
      return (char*)s;
  return 0;
     826:	4501                	li	a0,0
}
     828:	6422                	ld	s0,8(sp)
     82a:	0141                	add	sp,sp,16
     82c:	8082                	ret
  return 0;
     82e:	4501                	li	a0,0
     830:	bfe5                	j	828 <strchr+0x1a>

0000000000000832 <gets>:

char*
gets(char *buf, int max)
{
     832:	711d                	add	sp,sp,-96
     834:	ec86                	sd	ra,88(sp)
     836:	e8a2                	sd	s0,80(sp)
     838:	e4a6                	sd	s1,72(sp)
     83a:	e0ca                	sd	s2,64(sp)
     83c:	fc4e                	sd	s3,56(sp)
     83e:	f852                	sd	s4,48(sp)
     840:	f456                	sd	s5,40(sp)
     842:	f05a                	sd	s6,32(sp)
     844:	ec5e                	sd	s7,24(sp)
     846:	1080                	add	s0,sp,96
     848:	8baa                	mv	s7,a0
     84a:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     84c:	892a                	mv	s2,a0
     84e:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
     850:	4aa9                	li	s5,10
     852:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
     854:	89a6                	mv	s3,s1
     856:	2485                	addw	s1,s1,1
     858:	0344d863          	bge	s1,s4,888 <gets+0x56>
    cc = read(0, &c, 1);
     85c:	4605                	li	a2,1
     85e:	faf40593          	add	a1,s0,-81
     862:	4501                	li	a0,0
     864:	00000097          	auipc	ra,0x0
     868:	19a080e7          	jalr	410(ra) # 9fe <read>
    if(cc < 1)
     86c:	00a05e63          	blez	a0,888 <gets+0x56>
    buf[i++] = c;
     870:	faf44783          	lbu	a5,-81(s0)
     874:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
     878:	01578763          	beq	a5,s5,886 <gets+0x54>
     87c:	0905                	add	s2,s2,1
     87e:	fd679be3          	bne	a5,s6,854 <gets+0x22>
    buf[i++] = c;
     882:	89a6                	mv	s3,s1
     884:	a011                	j	888 <gets+0x56>
     886:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
     888:	99de                	add	s3,s3,s7
     88a:	00098023          	sb	zero,0(s3)
  return buf;
}
     88e:	855e                	mv	a0,s7
     890:	60e6                	ld	ra,88(sp)
     892:	6446                	ld	s0,80(sp)
     894:	64a6                	ld	s1,72(sp)
     896:	6906                	ld	s2,64(sp)
     898:	79e2                	ld	s3,56(sp)
     89a:	7a42                	ld	s4,48(sp)
     89c:	7aa2                	ld	s5,40(sp)
     89e:	7b02                	ld	s6,32(sp)
     8a0:	6be2                	ld	s7,24(sp)
     8a2:	6125                	add	sp,sp,96
     8a4:	8082                	ret

00000000000008a6 <stat>:

int
stat(const char *n, struct stat *st)
{
     8a6:	1101                	add	sp,sp,-32
     8a8:	ec06                	sd	ra,24(sp)
     8aa:	e822                	sd	s0,16(sp)
     8ac:	e04a                	sd	s2,0(sp)
     8ae:	1000                	add	s0,sp,32
     8b0:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     8b2:	4581                	li	a1,0
     8b4:	00000097          	auipc	ra,0x0
     8b8:	172080e7          	jalr	370(ra) # a26 <open>
  if(fd < 0)
     8bc:	02054663          	bltz	a0,8e8 <stat+0x42>
     8c0:	e426                	sd	s1,8(sp)
     8c2:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
     8c4:	85ca                	mv	a1,s2
     8c6:	00000097          	auipc	ra,0x0
     8ca:	178080e7          	jalr	376(ra) # a3e <fstat>
     8ce:	892a                	mv	s2,a0
  close(fd);
     8d0:	8526                	mv	a0,s1
     8d2:	00000097          	auipc	ra,0x0
     8d6:	13c080e7          	jalr	316(ra) # a0e <close>
  return r;
     8da:	64a2                	ld	s1,8(sp)
}
     8dc:	854a                	mv	a0,s2
     8de:	60e2                	ld	ra,24(sp)
     8e0:	6442                	ld	s0,16(sp)
     8e2:	6902                	ld	s2,0(sp)
     8e4:	6105                	add	sp,sp,32
     8e6:	8082                	ret
    return -1;
     8e8:	597d                	li	s2,-1
     8ea:	bfcd                	j	8dc <stat+0x36>

00000000000008ec <atoi>:

int
atoi(const char *s)
{
     8ec:	1141                	add	sp,sp,-16
     8ee:	e422                	sd	s0,8(sp)
     8f0:	0800                	add	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
     8f2:	00054683          	lbu	a3,0(a0)
     8f6:	fd06879b          	addw	a5,a3,-48
     8fa:	0ff7f793          	zext.b	a5,a5
     8fe:	4625                	li	a2,9
     900:	02f66863          	bltu	a2,a5,930 <atoi+0x44>
     904:	872a                	mv	a4,a0
  n = 0;
     906:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
     908:	0705                	add	a4,a4,1
     90a:	0025179b          	sllw	a5,a0,0x2
     90e:	9fa9                	addw	a5,a5,a0
     910:	0017979b          	sllw	a5,a5,0x1
     914:	9fb5                	addw	a5,a5,a3
     916:	fd07851b          	addw	a0,a5,-48
  while('0' <= *s && *s <= '9')
     91a:	00074683          	lbu	a3,0(a4)
     91e:	fd06879b          	addw	a5,a3,-48
     922:	0ff7f793          	zext.b	a5,a5
     926:	fef671e3          	bgeu	a2,a5,908 <atoi+0x1c>
  return n;
}
     92a:	6422                	ld	s0,8(sp)
     92c:	0141                	add	sp,sp,16
     92e:	8082                	ret
  n = 0;
     930:	4501                	li	a0,0
     932:	bfe5                	j	92a <atoi+0x3e>

0000000000000934 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
     934:	1141                	add	sp,sp,-16
     936:	e422                	sd	s0,8(sp)
     938:	0800                	add	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
     93a:	02b57463          	bgeu	a0,a1,962 <memmove+0x2e>
    while(n-- > 0)
     93e:	00c05f63          	blez	a2,95c <memmove+0x28>
     942:	1602                	sll	a2,a2,0x20
     944:	9201                	srl	a2,a2,0x20
     946:	00c507b3          	add	a5,a0,a2
  dst = vdst;
     94a:	872a                	mv	a4,a0
      *dst++ = *src++;
     94c:	0585                	add	a1,a1,1
     94e:	0705                	add	a4,a4,1
     950:	fff5c683          	lbu	a3,-1(a1)
     954:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
     958:	fef71ae3          	bne	a4,a5,94c <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
     95c:	6422                	ld	s0,8(sp)
     95e:	0141                	add	sp,sp,16
     960:	8082                	ret
    dst += n;
     962:	00c50733          	add	a4,a0,a2
    src += n;
     966:	95b2                	add	a1,a1,a2
    while(n-- > 0)
     968:	fec05ae3          	blez	a2,95c <memmove+0x28>
     96c:	fff6079b          	addw	a5,a2,-1
     970:	1782                	sll	a5,a5,0x20
     972:	9381                	srl	a5,a5,0x20
     974:	fff7c793          	not	a5,a5
     978:	97ba                	add	a5,a5,a4
      *--dst = *--src;
     97a:	15fd                	add	a1,a1,-1
     97c:	177d                	add	a4,a4,-1
     97e:	0005c683          	lbu	a3,0(a1)
     982:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
     986:	fee79ae3          	bne	a5,a4,97a <memmove+0x46>
     98a:	bfc9                	j	95c <memmove+0x28>

000000000000098c <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
     98c:	1141                	add	sp,sp,-16
     98e:	e422                	sd	s0,8(sp)
     990:	0800                	add	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
     992:	ca05                	beqz	a2,9c2 <memcmp+0x36>
     994:	fff6069b          	addw	a3,a2,-1
     998:	1682                	sll	a3,a3,0x20
     99a:	9281                	srl	a3,a3,0x20
     99c:	0685                	add	a3,a3,1
     99e:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
     9a0:	00054783          	lbu	a5,0(a0)
     9a4:	0005c703          	lbu	a4,0(a1)
     9a8:	00e79863          	bne	a5,a4,9b8 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
     9ac:	0505                	add	a0,a0,1
    p2++;
     9ae:	0585                	add	a1,a1,1
  while (n-- > 0) {
     9b0:	fed518e3          	bne	a0,a3,9a0 <memcmp+0x14>
  }
  return 0;
     9b4:	4501                	li	a0,0
     9b6:	a019                	j	9bc <memcmp+0x30>
      return *p1 - *p2;
     9b8:	40e7853b          	subw	a0,a5,a4
}
     9bc:	6422                	ld	s0,8(sp)
     9be:	0141                	add	sp,sp,16
     9c0:	8082                	ret
  return 0;
     9c2:	4501                	li	a0,0
     9c4:	bfe5                	j	9bc <memcmp+0x30>

00000000000009c6 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
     9c6:	1141                	add	sp,sp,-16
     9c8:	e406                	sd	ra,8(sp)
     9ca:	e022                	sd	s0,0(sp)
     9cc:	0800                	add	s0,sp,16
  return memmove(dst, src, n);
     9ce:	00000097          	auipc	ra,0x0
     9d2:	f66080e7          	jalr	-154(ra) # 934 <memmove>
}
     9d6:	60a2                	ld	ra,8(sp)
     9d8:	6402                	ld	s0,0(sp)
     9da:	0141                	add	sp,sp,16
     9dc:	8082                	ret

00000000000009de <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
     9de:	4885                	li	a7,1
 ecall
     9e0:	00000073          	ecall
 ret
     9e4:	8082                	ret

00000000000009e6 <exit>:
.global exit
exit:
 li a7, SYS_exit
     9e6:	4889                	li	a7,2
 ecall
     9e8:	00000073          	ecall
 ret
     9ec:	8082                	ret

00000000000009ee <wait>:
.global wait
wait:
 li a7, SYS_wait
     9ee:	488d                	li	a7,3
 ecall
     9f0:	00000073          	ecall
 ret
     9f4:	8082                	ret

00000000000009f6 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
     9f6:	4891                	li	a7,4
 ecall
     9f8:	00000073          	ecall
 ret
     9fc:	8082                	ret

00000000000009fe <read>:
.global read
read:
 li a7, SYS_read
     9fe:	4895                	li	a7,5
 ecall
     a00:	00000073          	ecall
 ret
     a04:	8082                	ret

0000000000000a06 <write>:
.global write
write:
 li a7, SYS_write
     a06:	48c1                	li	a7,16
 ecall
     a08:	00000073          	ecall
 ret
     a0c:	8082                	ret

0000000000000a0e <close>:
.global close
close:
 li a7, SYS_close
     a0e:	48d5                	li	a7,21
 ecall
     a10:	00000073          	ecall
 ret
     a14:	8082                	ret

0000000000000a16 <kill>:
.global kill
kill:
 li a7, SYS_kill
     a16:	4899                	li	a7,6
 ecall
     a18:	00000073          	ecall
 ret
     a1c:	8082                	ret

0000000000000a1e <exec>:
.global exec
exec:
 li a7, SYS_exec
     a1e:	489d                	li	a7,7
 ecall
     a20:	00000073          	ecall
 ret
     a24:	8082                	ret

0000000000000a26 <open>:
.global open
open:
 li a7, SYS_open
     a26:	48bd                	li	a7,15
 ecall
     a28:	00000073          	ecall
 ret
     a2c:	8082                	ret

0000000000000a2e <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
     a2e:	48c5                	li	a7,17
 ecall
     a30:	00000073          	ecall
 ret
     a34:	8082                	ret

0000000000000a36 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
     a36:	48c9                	li	a7,18
 ecall
     a38:	00000073          	ecall
 ret
     a3c:	8082                	ret

0000000000000a3e <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
     a3e:	48a1                	li	a7,8
 ecall
     a40:	00000073          	ecall
 ret
     a44:	8082                	ret

0000000000000a46 <link>:
.global link
link:
 li a7, SYS_link
     a46:	48cd                	li	a7,19
 ecall
     a48:	00000073          	ecall
 ret
     a4c:	8082                	ret

0000000000000a4e <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
     a4e:	48d1                	li	a7,20
 ecall
     a50:	00000073          	ecall
 ret
     a54:	8082                	ret

0000000000000a56 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
     a56:	48a5                	li	a7,9
 ecall
     a58:	00000073          	ecall
 ret
     a5c:	8082                	ret

0000000000000a5e <dup>:
.global dup
dup:
 li a7, SYS_dup
     a5e:	48a9                	li	a7,10
 ecall
     a60:	00000073          	ecall
 ret
     a64:	8082                	ret

0000000000000a66 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
     a66:	48ad                	li	a7,11
 ecall
     a68:	00000073          	ecall
 ret
     a6c:	8082                	ret

0000000000000a6e <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
     a6e:	48b1                	li	a7,12
 ecall
     a70:	00000073          	ecall
 ret
     a74:	8082                	ret

0000000000000a76 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
     a76:	48b5                	li	a7,13
 ecall
     a78:	00000073          	ecall
 ret
     a7c:	8082                	ret

0000000000000a7e <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
     a7e:	48b9                	li	a7,14
 ecall
     a80:	00000073          	ecall
 ret
     a84:	8082                	ret

0000000000000a86 <uconnect>:
.global uconnect
uconnect:
 li a7, SYS_uconnect
     a86:	48f5                	li	a7,29
 ecall
     a88:	00000073          	ecall
 ret
     a8c:	8082                	ret

0000000000000a8e <socket>:
.global socket
socket:
 li a7, SYS_socket
     a8e:	48f9                	li	a7,30
 ecall
     a90:	00000073          	ecall
 ret
     a94:	8082                	ret

0000000000000a96 <bind>:
.global bind
bind:
 li a7, SYS_bind
     a96:	48fd                	li	a7,31
 ecall
     a98:	00000073          	ecall
 ret
     a9c:	8082                	ret

0000000000000a9e <listen>:
.global listen
listen:
 li a7, SYS_listen
     a9e:	02000893          	li	a7,32
 ecall
     aa2:	00000073          	ecall
 ret
     aa6:	8082                	ret

0000000000000aa8 <accept>:
.global accept
accept:
 li a7, SYS_accept
     aa8:	02100893          	li	a7,33
 ecall
     aac:	00000073          	ecall
 ret
     ab0:	8082                	ret

0000000000000ab2 <connect>:
.global connect
connect:
 li a7, SYS_connect
     ab2:	02200893          	li	a7,34
 ecall
     ab6:	00000073          	ecall
 ret
     aba:	8082                	ret

0000000000000abc <sprintint>:
  return 1;
}

static int
sprintint(char *s, int xx, int base, int sign)
{
     abc:	1101                	add	sp,sp,-32
     abe:	ec22                	sd	s0,24(sp)
     ac0:	1000                	add	s0,sp,32
     ac2:	882a                	mv	a6,a0
  char buf[16];
  int i, n;
  uint x;

  if(sign && (sign = xx < 0))
     ac4:	c299                	beqz	a3,aca <sprintint+0xe>
     ac6:	0805c263          	bltz	a1,b4a <sprintint+0x8e>
    x = -xx;
  else
    x = xx;
     aca:	2581                	sext.w	a1,a1
     acc:	4301                	li	t1,0

  i = 0;
     ace:	fe040713          	add	a4,s0,-32
     ad2:	4501                	li	a0,0
  do {
    buf[i++] = digits[x % base];
     ad4:	2601                	sext.w	a2,a2
     ad6:	00001697          	auipc	a3,0x1
     ada:	98268693          	add	a3,a3,-1662 # 1458 <digits>
     ade:	88aa                	mv	a7,a0
     ae0:	2505                	addw	a0,a0,1
     ae2:	02c5f7bb          	remuw	a5,a1,a2
     ae6:	1782                	sll	a5,a5,0x20
     ae8:	9381                	srl	a5,a5,0x20
     aea:	97b6                	add	a5,a5,a3
     aec:	0007c783          	lbu	a5,0(a5)
     af0:	00f70023          	sb	a5,0(a4)
  } while((x /= base) != 0);
     af4:	0005879b          	sext.w	a5,a1
     af8:	02c5d5bb          	divuw	a1,a1,a2
     afc:	0705                	add	a4,a4,1
     afe:	fec7f0e3          	bgeu	a5,a2,ade <sprintint+0x22>

  if(sign)
     b02:	00030b63          	beqz	t1,b18 <sprintint+0x5c>
    buf[i++] = '-';
     b06:	ff050793          	add	a5,a0,-16
     b0a:	97a2                	add	a5,a5,s0
     b0c:	02d00713          	li	a4,45
     b10:	fee78823          	sb	a4,-16(a5)
     b14:	0028851b          	addw	a0,a7,2

  n = 0;
  while(--i >= 0)
     b18:	02a05d63          	blez	a0,b52 <sprintint+0x96>
     b1c:	fe040793          	add	a5,s0,-32
     b20:	00a78733          	add	a4,a5,a0
     b24:	87c2                	mv	a5,a6
     b26:	00180613          	add	a2,a6,1
     b2a:	fff5069b          	addw	a3,a0,-1
     b2e:	1682                	sll	a3,a3,0x20
     b30:	9281                	srl	a3,a3,0x20
     b32:	9636                	add	a2,a2,a3
  *s = c;
     b34:	fff74683          	lbu	a3,-1(a4)
     b38:	00d78023          	sb	a3,0(a5)
  while(--i >= 0)
     b3c:	177d                	add	a4,a4,-1
     b3e:	0785                	add	a5,a5,1
     b40:	fec79ae3          	bne	a5,a2,b34 <sprintint+0x78>
    n += sputc(s+n, buf[i]);
  return n;
}
     b44:	6462                	ld	s0,24(sp)
     b46:	6105                	add	sp,sp,32
     b48:	8082                	ret
    x = -xx;
     b4a:	40b005bb          	negw	a1,a1
  if(sign && (sign = xx < 0))
     b4e:	4305                	li	t1,1
    x = -xx;
     b50:	bfbd                	j	ace <sprintint+0x12>
  while(--i >= 0)
     b52:	4501                	li	a0,0
     b54:	bfc5                	j	b44 <sprintint+0x88>

0000000000000b56 <putc>:
{
     b56:	1101                	add	sp,sp,-32
     b58:	ec06                	sd	ra,24(sp)
     b5a:	e822                	sd	s0,16(sp)
     b5c:	1000                	add	s0,sp,32
     b5e:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
     b62:	4605                	li	a2,1
     b64:	fef40593          	add	a1,s0,-17
     b68:	00000097          	auipc	ra,0x0
     b6c:	e9e080e7          	jalr	-354(ra) # a06 <write>
}
     b70:	60e2                	ld	ra,24(sp)
     b72:	6442                	ld	s0,16(sp)
     b74:	6105                	add	sp,sp,32
     b76:	8082                	ret

0000000000000b78 <printint>:
{
     b78:	7139                	add	sp,sp,-64
     b7a:	fc06                	sd	ra,56(sp)
     b7c:	f822                	sd	s0,48(sp)
     b7e:	f426                	sd	s1,40(sp)
     b80:	0080                	add	s0,sp,64
     b82:	84aa                	mv	s1,a0
  if(sgn && xx < 0){
     b84:	c299                	beqz	a3,b8a <printint+0x12>
     b86:	0805cb63          	bltz	a1,c1c <printint+0xa4>
    x = xx;
     b8a:	2581                	sext.w	a1,a1
  neg = 0;
     b8c:	4881                	li	a7,0
     b8e:	fc040693          	add	a3,s0,-64
  i = 0;
     b92:	4701                	li	a4,0
    buf[i++] = digits[x % base];
     b94:	2601                	sext.w	a2,a2
     b96:	00001517          	auipc	a0,0x1
     b9a:	8c250513          	add	a0,a0,-1854 # 1458 <digits>
     b9e:	883a                	mv	a6,a4
     ba0:	2705                	addw	a4,a4,1
     ba2:	02c5f7bb          	remuw	a5,a1,a2
     ba6:	1782                	sll	a5,a5,0x20
     ba8:	9381                	srl	a5,a5,0x20
     baa:	97aa                	add	a5,a5,a0
     bac:	0007c783          	lbu	a5,0(a5)
     bb0:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
     bb4:	0005879b          	sext.w	a5,a1
     bb8:	02c5d5bb          	divuw	a1,a1,a2
     bbc:	0685                	add	a3,a3,1
     bbe:	fec7f0e3          	bgeu	a5,a2,b9e <printint+0x26>
  if(neg)
     bc2:	00088c63          	beqz	a7,bda <printint+0x62>
    buf[i++] = '-';
     bc6:	fd070793          	add	a5,a4,-48
     bca:	00878733          	add	a4,a5,s0
     bce:	02d00793          	li	a5,45
     bd2:	fef70823          	sb	a5,-16(a4)
     bd6:	0028071b          	addw	a4,a6,2
  while(--i >= 0)
     bda:	02e05c63          	blez	a4,c12 <printint+0x9a>
     bde:	f04a                	sd	s2,32(sp)
     be0:	ec4e                	sd	s3,24(sp)
     be2:	fc040793          	add	a5,s0,-64
     be6:	00e78933          	add	s2,a5,a4
     bea:	fff78993          	add	s3,a5,-1
     bee:	99ba                	add	s3,s3,a4
     bf0:	377d                	addw	a4,a4,-1
     bf2:	1702                	sll	a4,a4,0x20
     bf4:	9301                	srl	a4,a4,0x20
     bf6:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
     bfa:	fff94583          	lbu	a1,-1(s2)
     bfe:	8526                	mv	a0,s1
     c00:	00000097          	auipc	ra,0x0
     c04:	f56080e7          	jalr	-170(ra) # b56 <putc>
  while(--i >= 0)
     c08:	197d                	add	s2,s2,-1
     c0a:	ff3918e3          	bne	s2,s3,bfa <printint+0x82>
     c0e:	7902                	ld	s2,32(sp)
     c10:	69e2                	ld	s3,24(sp)
}
     c12:	70e2                	ld	ra,56(sp)
     c14:	7442                	ld	s0,48(sp)
     c16:	74a2                	ld	s1,40(sp)
     c18:	6121                	add	sp,sp,64
     c1a:	8082                	ret
    x = -xx;
     c1c:	40b005bb          	negw	a1,a1
    neg = 1;
     c20:	4885                	li	a7,1
    x = -xx;
     c22:	b7b5                	j	b8e <printint+0x16>

0000000000000c24 <vprintf>:
{
     c24:	715d                	add	sp,sp,-80
     c26:	e486                	sd	ra,72(sp)
     c28:	e0a2                	sd	s0,64(sp)
     c2a:	f84a                	sd	s2,48(sp)
     c2c:	0880                	add	s0,sp,80
  for(i = 0; fmt[i]; i++){
     c2e:	0005c903          	lbu	s2,0(a1)
     c32:	1a090a63          	beqz	s2,de6 <vprintf+0x1c2>
     c36:	fc26                	sd	s1,56(sp)
     c38:	f44e                	sd	s3,40(sp)
     c3a:	f052                	sd	s4,32(sp)
     c3c:	ec56                	sd	s5,24(sp)
     c3e:	e85a                	sd	s6,16(sp)
     c40:	e45e                	sd	s7,8(sp)
     c42:	8aaa                	mv	s5,a0
     c44:	8bb2                	mv	s7,a2
     c46:	00158493          	add	s1,a1,1
  state = 0;
     c4a:	4981                	li	s3,0
    } else if(state == '%'){
     c4c:	02500a13          	li	s4,37
     c50:	4b55                	li	s6,21
     c52:	a839                	j	c70 <vprintf+0x4c>
        putc(fd, c);
     c54:	85ca                	mv	a1,s2
     c56:	8556                	mv	a0,s5
     c58:	00000097          	auipc	ra,0x0
     c5c:	efe080e7          	jalr	-258(ra) # b56 <putc>
     c60:	a019                	j	c66 <vprintf+0x42>
    } else if(state == '%'){
     c62:	01498d63          	beq	s3,s4,c7c <vprintf+0x58>
  for(i = 0; fmt[i]; i++){
     c66:	0485                	add	s1,s1,1
     c68:	fff4c903          	lbu	s2,-1(s1)
     c6c:	16090763          	beqz	s2,dda <vprintf+0x1b6>
    if(state == 0){
     c70:	fe0999e3          	bnez	s3,c62 <vprintf+0x3e>
      if(c == '%'){
     c74:	ff4910e3          	bne	s2,s4,c54 <vprintf+0x30>
        state = '%';
     c78:	89d2                	mv	s3,s4
     c7a:	b7f5                	j	c66 <vprintf+0x42>
      if(c == 'd'){
     c7c:	13490463          	beq	s2,s4,da4 <vprintf+0x180>
     c80:	f9d9079b          	addw	a5,s2,-99
     c84:	0ff7f793          	zext.b	a5,a5
     c88:	12fb6763          	bltu	s6,a5,db6 <vprintf+0x192>
     c8c:	f9d9079b          	addw	a5,s2,-99
     c90:	0ff7f713          	zext.b	a4,a5
     c94:	12eb6163          	bltu	s6,a4,db6 <vprintf+0x192>
     c98:	00271793          	sll	a5,a4,0x2
     c9c:	00000717          	auipc	a4,0x0
     ca0:	76470713          	add	a4,a4,1892 # 1400 <malloc+0x362>
     ca4:	97ba                	add	a5,a5,a4
     ca6:	439c                	lw	a5,0(a5)
     ca8:	97ba                	add	a5,a5,a4
     caa:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
     cac:	008b8913          	add	s2,s7,8
     cb0:	4685                	li	a3,1
     cb2:	4629                	li	a2,10
     cb4:	000ba583          	lw	a1,0(s7)
     cb8:	8556                	mv	a0,s5
     cba:	00000097          	auipc	ra,0x0
     cbe:	ebe080e7          	jalr	-322(ra) # b78 <printint>
     cc2:	8bca                	mv	s7,s2
      state = 0;
     cc4:	4981                	li	s3,0
     cc6:	b745                	j	c66 <vprintf+0x42>
        printint(fd, va_arg(ap, uint64), 10, 0);
     cc8:	008b8913          	add	s2,s7,8
     ccc:	4681                	li	a3,0
     cce:	4629                	li	a2,10
     cd0:	000ba583          	lw	a1,0(s7)
     cd4:	8556                	mv	a0,s5
     cd6:	00000097          	auipc	ra,0x0
     cda:	ea2080e7          	jalr	-350(ra) # b78 <printint>
     cde:	8bca                	mv	s7,s2
      state = 0;
     ce0:	4981                	li	s3,0
     ce2:	b751                	j	c66 <vprintf+0x42>
        printint(fd, va_arg(ap, int), 16, 0);
     ce4:	008b8913          	add	s2,s7,8
     ce8:	4681                	li	a3,0
     cea:	4641                	li	a2,16
     cec:	000ba583          	lw	a1,0(s7)
     cf0:	8556                	mv	a0,s5
     cf2:	00000097          	auipc	ra,0x0
     cf6:	e86080e7          	jalr	-378(ra) # b78 <printint>
     cfa:	8bca                	mv	s7,s2
      state = 0;
     cfc:	4981                	li	s3,0
     cfe:	b7a5                	j	c66 <vprintf+0x42>
     d00:	e062                	sd	s8,0(sp)
        printptr(fd, va_arg(ap, uint64));
     d02:	008b8c13          	add	s8,s7,8
     d06:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
     d0a:	03000593          	li	a1,48
     d0e:	8556                	mv	a0,s5
     d10:	00000097          	auipc	ra,0x0
     d14:	e46080e7          	jalr	-442(ra) # b56 <putc>
  putc(fd, 'x');
     d18:	07800593          	li	a1,120
     d1c:	8556                	mv	a0,s5
     d1e:	00000097          	auipc	ra,0x0
     d22:	e38080e7          	jalr	-456(ra) # b56 <putc>
     d26:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
     d28:	00000b97          	auipc	s7,0x0
     d2c:	730b8b93          	add	s7,s7,1840 # 1458 <digits>
     d30:	03c9d793          	srl	a5,s3,0x3c
     d34:	97de                	add	a5,a5,s7
     d36:	0007c583          	lbu	a1,0(a5)
     d3a:	8556                	mv	a0,s5
     d3c:	00000097          	auipc	ra,0x0
     d40:	e1a080e7          	jalr	-486(ra) # b56 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
     d44:	0992                	sll	s3,s3,0x4
     d46:	397d                	addw	s2,s2,-1
     d48:	fe0914e3          	bnez	s2,d30 <vprintf+0x10c>
        printptr(fd, va_arg(ap, uint64));
     d4c:	8be2                	mv	s7,s8
      state = 0;
     d4e:	4981                	li	s3,0
     d50:	6c02                	ld	s8,0(sp)
     d52:	bf11                	j	c66 <vprintf+0x42>
        s = va_arg(ap, char*);
     d54:	008b8993          	add	s3,s7,8
     d58:	000bb903          	ld	s2,0(s7)
        if(s == 0)
     d5c:	02090163          	beqz	s2,d7e <vprintf+0x15a>
        while(*s != 0){
     d60:	00094583          	lbu	a1,0(s2)
     d64:	c9a5                	beqz	a1,dd4 <vprintf+0x1b0>
          putc(fd, *s);
     d66:	8556                	mv	a0,s5
     d68:	00000097          	auipc	ra,0x0
     d6c:	dee080e7          	jalr	-530(ra) # b56 <putc>
          s++;
     d70:	0905                	add	s2,s2,1
        while(*s != 0){
     d72:	00094583          	lbu	a1,0(s2)
     d76:	f9e5                	bnez	a1,d66 <vprintf+0x142>
        s = va_arg(ap, char*);
     d78:	8bce                	mv	s7,s3
      state = 0;
     d7a:	4981                	li	s3,0
     d7c:	b5ed                	j	c66 <vprintf+0x42>
          s = "(null)";
     d7e:	00000917          	auipc	s2,0x0
     d82:	67a90913          	add	s2,s2,1658 # 13f8 <malloc+0x35a>
        while(*s != 0){
     d86:	02800593          	li	a1,40
     d8a:	bff1                	j	d66 <vprintf+0x142>
        putc(fd, va_arg(ap, uint));
     d8c:	008b8913          	add	s2,s7,8
     d90:	000bc583          	lbu	a1,0(s7)
     d94:	8556                	mv	a0,s5
     d96:	00000097          	auipc	ra,0x0
     d9a:	dc0080e7          	jalr	-576(ra) # b56 <putc>
     d9e:	8bca                	mv	s7,s2
      state = 0;
     da0:	4981                	li	s3,0
     da2:	b5d1                	j	c66 <vprintf+0x42>
        putc(fd, c);
     da4:	02500593          	li	a1,37
     da8:	8556                	mv	a0,s5
     daa:	00000097          	auipc	ra,0x0
     dae:	dac080e7          	jalr	-596(ra) # b56 <putc>
      state = 0;
     db2:	4981                	li	s3,0
     db4:	bd4d                	j	c66 <vprintf+0x42>
        putc(fd, '%');
     db6:	02500593          	li	a1,37
     dba:	8556                	mv	a0,s5
     dbc:	00000097          	auipc	ra,0x0
     dc0:	d9a080e7          	jalr	-614(ra) # b56 <putc>
        putc(fd, c);
     dc4:	85ca                	mv	a1,s2
     dc6:	8556                	mv	a0,s5
     dc8:	00000097          	auipc	ra,0x0
     dcc:	d8e080e7          	jalr	-626(ra) # b56 <putc>
      state = 0;
     dd0:	4981                	li	s3,0
     dd2:	bd51                	j	c66 <vprintf+0x42>
        s = va_arg(ap, char*);
     dd4:	8bce                	mv	s7,s3
      state = 0;
     dd6:	4981                	li	s3,0
     dd8:	b579                	j	c66 <vprintf+0x42>
     dda:	74e2                	ld	s1,56(sp)
     ddc:	79a2                	ld	s3,40(sp)
     dde:	7a02                	ld	s4,32(sp)
     de0:	6ae2                	ld	s5,24(sp)
     de2:	6b42                	ld	s6,16(sp)
     de4:	6ba2                	ld	s7,8(sp)
}
     de6:	60a6                	ld	ra,72(sp)
     de8:	6406                	ld	s0,64(sp)
     dea:	7942                	ld	s2,48(sp)
     dec:	6161                	add	sp,sp,80
     dee:	8082                	ret

0000000000000df0 <fprintf>:
{
     df0:	715d                	add	sp,sp,-80
     df2:	ec06                	sd	ra,24(sp)
     df4:	e822                	sd	s0,16(sp)
     df6:	1000                	add	s0,sp,32
     df8:	e010                	sd	a2,0(s0)
     dfa:	e414                	sd	a3,8(s0)
     dfc:	e818                	sd	a4,16(s0)
     dfe:	ec1c                	sd	a5,24(s0)
     e00:	03043023          	sd	a6,32(s0)
     e04:	03143423          	sd	a7,40(s0)
  va_start(ap, fmt);
     e08:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
     e0c:	8622                	mv	a2,s0
     e0e:	00000097          	auipc	ra,0x0
     e12:	e16080e7          	jalr	-490(ra) # c24 <vprintf>
}
     e16:	60e2                	ld	ra,24(sp)
     e18:	6442                	ld	s0,16(sp)
     e1a:	6161                	add	sp,sp,80
     e1c:	8082                	ret

0000000000000e1e <printf>:
{
     e1e:	711d                	add	sp,sp,-96
     e20:	ec06                	sd	ra,24(sp)
     e22:	e822                	sd	s0,16(sp)
     e24:	1000                	add	s0,sp,32
     e26:	e40c                	sd	a1,8(s0)
     e28:	e810                	sd	a2,16(s0)
     e2a:	ec14                	sd	a3,24(s0)
     e2c:	f018                	sd	a4,32(s0)
     e2e:	f41c                	sd	a5,40(s0)
     e30:	03043823          	sd	a6,48(s0)
     e34:	03143c23          	sd	a7,56(s0)
  va_start(ap, fmt);
     e38:	00840613          	add	a2,s0,8
     e3c:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
     e40:	85aa                	mv	a1,a0
     e42:	4505                	li	a0,1
     e44:	00000097          	auipc	ra,0x0
     e48:	de0080e7          	jalr	-544(ra) # c24 <vprintf>
}
     e4c:	60e2                	ld	ra,24(sp)
     e4e:	6442                	ld	s0,16(sp)
     e50:	6125                	add	sp,sp,96
     e52:	8082                	ret

0000000000000e54 <snprintf>:

int
snprintf(char *buf, int sz, char *fmt, ...)
{
     e54:	7135                	add	sp,sp,-160
     e56:	f486                	sd	ra,104(sp)
     e58:	f0a2                	sd	s0,96(sp)
     e5a:	eca6                	sd	s1,88(sp)
     e5c:	1880                	add	s0,sp,112
     e5e:	e414                	sd	a3,8(s0)
     e60:	e818                	sd	a4,16(s0)
     e62:	ec1c                	sd	a5,24(s0)
     e64:	03043023          	sd	a6,32(s0)
     e68:	03143423          	sd	a7,40(s0)
  va_list ap;
  int i, c;
  int off = 0;
  char *s;

  if (fmt == 0)
     e6c:	16060b63          	beqz	a2,fe2 <snprintf+0x18e>
     e70:	e8ca                	sd	s2,80(sp)
     e72:	e4ce                	sd	s3,72(sp)
     e74:	fc56                	sd	s5,56(sp)
     e76:	f85a                	sd	s6,48(sp)
     e78:	8b2a                	mv	s6,a0
     e7a:	8aae                	mv	s5,a1
     e7c:	89b2                	mv	s3,a2
    return -1;

  va_start(ap, fmt);
     e7e:	00840793          	add	a5,s0,8
     e82:	f8f43c23          	sd	a5,-104(s0)
  int off = 0;
     e86:	4481                	li	s1,0
  for(i = 0; off < sz && (c = fmt[i] & 0xff) != 0; i++){
     e88:	4901                	li	s2,0
     e8a:	00b05f63          	blez	a1,ea8 <snprintf+0x54>
     e8e:	e0d2                	sd	s4,64(sp)
     e90:	f45e                	sd	s7,40(sp)
     e92:	f062                	sd	s8,32(sp)
     e94:	ec66                	sd	s9,24(sp)
    if(c != '%'){
     e96:	02500a13          	li	s4,37
      continue;
    }
    c = fmt[++i] & 0xff;
    if(c == 0)
      break;
    switch(c){
     e9a:	07300b93          	li	s7,115
     e9e:	07800c93          	li	s9,120
     ea2:	06400c13          	li	s8,100
     ea6:	a839                	j	ec4 <snprintf+0x70>
      off += sputc(buf+off, '%');
      off += sputc(buf+off, c);
      break;
    }
  }
  return off;
     ea8:	4481                	li	s1,0
     eaa:	6946                	ld	s2,80(sp)
     eac:	69a6                	ld	s3,72(sp)
     eae:	7ae2                	ld	s5,56(sp)
     eb0:	7b42                	ld	s6,48(sp)
     eb2:	a0cd                	j	f94 <snprintf+0x140>
  *s = c;
     eb4:	009b0733          	add	a4,s6,s1
     eb8:	00f70023          	sb	a5,0(a4)
      off += sputc(buf+off, c);
     ebc:	2485                	addw	s1,s1,1
  for(i = 0; off < sz && (c = fmt[i] & 0xff) != 0; i++){
     ebe:	2905                	addw	s2,s2,1
     ec0:	1554d563          	bge	s1,s5,100a <snprintf+0x1b6>
     ec4:	012987b3          	add	a5,s3,s2
     ec8:	0007c783          	lbu	a5,0(a5)
     ecc:	0007871b          	sext.w	a4,a5
     ed0:	10078063          	beqz	a5,fd0 <snprintf+0x17c>
    if(c != '%'){
     ed4:	ff4710e3          	bne	a4,s4,eb4 <snprintf+0x60>
    c = fmt[++i] & 0xff;
     ed8:	2905                	addw	s2,s2,1
     eda:	012987b3          	add	a5,s3,s2
     ede:	0007c783          	lbu	a5,0(a5)
    if(c == 0)
     ee2:	10078263          	beqz	a5,fe6 <snprintf+0x192>
    switch(c){
     ee6:	05778c63          	beq	a5,s7,f3e <snprintf+0xea>
     eea:	02fbe763          	bltu	s7,a5,f18 <snprintf+0xc4>
     eee:	0d478063          	beq	a5,s4,fae <snprintf+0x15a>
     ef2:	0d879463          	bne	a5,s8,fba <snprintf+0x166>
      off += sprintint(buf+off, va_arg(ap, int), 10, 1);
     ef6:	f9843783          	ld	a5,-104(s0)
     efa:	00878713          	add	a4,a5,8
     efe:	f8e43c23          	sd	a4,-104(s0)
     f02:	4685                	li	a3,1
     f04:	4629                	li	a2,10
     f06:	438c                	lw	a1,0(a5)
     f08:	009b0533          	add	a0,s6,s1
     f0c:	00000097          	auipc	ra,0x0
     f10:	bb0080e7          	jalr	-1104(ra) # abc <sprintint>
     f14:	9ca9                	addw	s1,s1,a0
      break;
     f16:	b765                	j	ebe <snprintf+0x6a>
    switch(c){
     f18:	0b979163          	bne	a5,s9,fba <snprintf+0x166>
      off += sprintint(buf+off, va_arg(ap, int), 16, 1);
     f1c:	f9843783          	ld	a5,-104(s0)
     f20:	00878713          	add	a4,a5,8
     f24:	f8e43c23          	sd	a4,-104(s0)
     f28:	4685                	li	a3,1
     f2a:	4641                	li	a2,16
     f2c:	438c                	lw	a1,0(a5)
     f2e:	009b0533          	add	a0,s6,s1
     f32:	00000097          	auipc	ra,0x0
     f36:	b8a080e7          	jalr	-1142(ra) # abc <sprintint>
     f3a:	9ca9                	addw	s1,s1,a0
      break;
     f3c:	b749                	j	ebe <snprintf+0x6a>
      if((s = va_arg(ap, char*)) == 0)
     f3e:	f9843783          	ld	a5,-104(s0)
     f42:	00878713          	add	a4,a5,8
     f46:	f8e43c23          	sd	a4,-104(s0)
     f4a:	6388                	ld	a0,0(a5)
     f4c:	c931                	beqz	a0,fa0 <snprintf+0x14c>
      for(; *s && off < sz; s++)
     f4e:	00054703          	lbu	a4,0(a0)
     f52:	d735                	beqz	a4,ebe <snprintf+0x6a>
     f54:	0b54d263          	bge	s1,s5,ff8 <snprintf+0x1a4>
     f58:	009b06b3          	add	a3,s6,s1
     f5c:	409a863b          	subw	a2,s5,s1
     f60:	1602                	sll	a2,a2,0x20
     f62:	9201                	srl	a2,a2,0x20
     f64:	962a                	add	a2,a2,a0
     f66:	87aa                	mv	a5,a0
        off += sputc(buf+off, *s);
     f68:	0014859b          	addw	a1,s1,1
     f6c:	9d89                	subw	a1,a1,a0
  *s = c;
     f6e:	00e68023          	sb	a4,0(a3)
        off += sputc(buf+off, *s);
     f72:	00f584bb          	addw	s1,a1,a5
      for(; *s && off < sz; s++)
     f76:	0785                	add	a5,a5,1
     f78:	0007c703          	lbu	a4,0(a5)
     f7c:	d329                	beqz	a4,ebe <snprintf+0x6a>
     f7e:	0685                	add	a3,a3,1
     f80:	fec797e3          	bne	a5,a2,f6e <snprintf+0x11a>
     f84:	6946                	ld	s2,80(sp)
     f86:	69a6                	ld	s3,72(sp)
     f88:	6a06                	ld	s4,64(sp)
     f8a:	7ae2                	ld	s5,56(sp)
     f8c:	7b42                	ld	s6,48(sp)
     f8e:	7ba2                	ld	s7,40(sp)
     f90:	7c02                	ld	s8,32(sp)
     f92:	6ce2                	ld	s9,24(sp)
     f94:	8526                	mv	a0,s1
     f96:	70a6                	ld	ra,104(sp)
     f98:	7406                	ld	s0,96(sp)
     f9a:	64e6                	ld	s1,88(sp)
     f9c:	610d                	add	sp,sp,160
     f9e:	8082                	ret
      for(; *s && off < sz; s++)
     fa0:	02800713          	li	a4,40
        s = "(null)";
     fa4:	00000517          	auipc	a0,0x0
     fa8:	45450513          	add	a0,a0,1108 # 13f8 <malloc+0x35a>
     fac:	b765                	j	f54 <snprintf+0x100>
  *s = c;
     fae:	009b07b3          	add	a5,s6,s1
     fb2:	01478023          	sb	s4,0(a5)
      off += sputc(buf+off, '%');
     fb6:	2485                	addw	s1,s1,1
      break;
     fb8:	b719                	j	ebe <snprintf+0x6a>
  *s = c;
     fba:	009b0733          	add	a4,s6,s1
     fbe:	01470023          	sb	s4,0(a4)
      off += sputc(buf+off, c);
     fc2:	0014871b          	addw	a4,s1,1
  *s = c;
     fc6:	975a                	add	a4,a4,s6
     fc8:	00f70023          	sb	a5,0(a4)
      off += sputc(buf+off, c);
     fcc:	2489                	addw	s1,s1,2
      break;
     fce:	bdc5                	j	ebe <snprintf+0x6a>
     fd0:	6946                	ld	s2,80(sp)
     fd2:	69a6                	ld	s3,72(sp)
     fd4:	6a06                	ld	s4,64(sp)
     fd6:	7ae2                	ld	s5,56(sp)
     fd8:	7b42                	ld	s6,48(sp)
     fda:	7ba2                	ld	s7,40(sp)
     fdc:	7c02                	ld	s8,32(sp)
     fde:	6ce2                	ld	s9,24(sp)
     fe0:	bf55                	j	f94 <snprintf+0x140>
    return -1;
     fe2:	54fd                	li	s1,-1
     fe4:	bf45                	j	f94 <snprintf+0x140>
     fe6:	6946                	ld	s2,80(sp)
     fe8:	69a6                	ld	s3,72(sp)
     fea:	6a06                	ld	s4,64(sp)
     fec:	7ae2                	ld	s5,56(sp)
     fee:	7b42                	ld	s6,48(sp)
     ff0:	7ba2                	ld	s7,40(sp)
     ff2:	7c02                	ld	s8,32(sp)
     ff4:	6ce2                	ld	s9,24(sp)
     ff6:	bf79                	j	f94 <snprintf+0x140>
     ff8:	6946                	ld	s2,80(sp)
     ffa:	69a6                	ld	s3,72(sp)
     ffc:	6a06                	ld	s4,64(sp)
     ffe:	7ae2                	ld	s5,56(sp)
    1000:	7b42                	ld	s6,48(sp)
    1002:	7ba2                	ld	s7,40(sp)
    1004:	7c02                	ld	s8,32(sp)
    1006:	6ce2                	ld	s9,24(sp)
    1008:	b771                	j	f94 <snprintf+0x140>
    100a:	6946                	ld	s2,80(sp)
    100c:	69a6                	ld	s3,72(sp)
    100e:	6a06                	ld	s4,64(sp)
    1010:	7ae2                	ld	s5,56(sp)
    1012:	7b42                	ld	s6,48(sp)
    1014:	7ba2                	ld	s7,40(sp)
    1016:	7c02                	ld	s8,32(sp)
    1018:	6ce2                	ld	s9,24(sp)
    101a:	bfad                	j	f94 <snprintf+0x140>

000000000000101c <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    101c:	1141                	add	sp,sp,-16
    101e:	e422                	sd	s0,8(sp)
    1020:	0800                	add	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
    1022:	ff050693          	add	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1026:	00000797          	auipc	a5,0x0
    102a:	44a7b783          	ld	a5,1098(a5) # 1470 <freep>
    102e:	a02d                	j	1058 <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
    1030:	4618                	lw	a4,8(a2)
    1032:	9f2d                	addw	a4,a4,a1
    1034:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
    1038:	6398                	ld	a4,0(a5)
    103a:	6310                	ld	a2,0(a4)
    103c:	a83d                	j	107a <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    103e:	ff852703          	lw	a4,-8(a0)
    1042:	9f31                	addw	a4,a4,a2
    1044:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
    1046:	ff053683          	ld	a3,-16(a0)
    104a:	a091                	j	108e <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    104c:	6398                	ld	a4,0(a5)
    104e:	00e7e463          	bltu	a5,a4,1056 <free+0x3a>
    1052:	00e6ea63          	bltu	a3,a4,1066 <free+0x4a>
{
    1056:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1058:	fed7fae3          	bgeu	a5,a3,104c <free+0x30>
    105c:	6398                	ld	a4,0(a5)
    105e:	00e6e463          	bltu	a3,a4,1066 <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1062:	fee7eae3          	bltu	a5,a4,1056 <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
    1066:	ff852583          	lw	a1,-8(a0)
    106a:	6390                	ld	a2,0(a5)
    106c:	02059813          	sll	a6,a1,0x20
    1070:	01c85713          	srl	a4,a6,0x1c
    1074:	9736                	add	a4,a4,a3
    1076:	fae60de3          	beq	a2,a4,1030 <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
    107a:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
    107e:	4790                	lw	a2,8(a5)
    1080:	02061593          	sll	a1,a2,0x20
    1084:	01c5d713          	srl	a4,a1,0x1c
    1088:	973e                	add	a4,a4,a5
    108a:	fae68ae3          	beq	a3,a4,103e <free+0x22>
    p->s.ptr = bp->s.ptr;
    108e:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
    1090:	00000717          	auipc	a4,0x0
    1094:	3ef73023          	sd	a5,992(a4) # 1470 <freep>
}
    1098:	6422                	ld	s0,8(sp)
    109a:	0141                	add	sp,sp,16
    109c:	8082                	ret

000000000000109e <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    109e:	7139                	add	sp,sp,-64
    10a0:	fc06                	sd	ra,56(sp)
    10a2:	f822                	sd	s0,48(sp)
    10a4:	f426                	sd	s1,40(sp)
    10a6:	ec4e                	sd	s3,24(sp)
    10a8:	0080                	add	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    10aa:	02051493          	sll	s1,a0,0x20
    10ae:	9081                	srl	s1,s1,0x20
    10b0:	04bd                	add	s1,s1,15
    10b2:	8091                	srl	s1,s1,0x4
    10b4:	0014899b          	addw	s3,s1,1
    10b8:	0485                	add	s1,s1,1
  if((prevp = freep) == 0){
    10ba:	00000517          	auipc	a0,0x0
    10be:	3b653503          	ld	a0,950(a0) # 1470 <freep>
    10c2:	c915                	beqz	a0,10f6 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    10c4:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    10c6:	4798                	lw	a4,8(a5)
    10c8:	08977e63          	bgeu	a4,s1,1164 <malloc+0xc6>
    10cc:	f04a                	sd	s2,32(sp)
    10ce:	e852                	sd	s4,16(sp)
    10d0:	e456                	sd	s5,8(sp)
    10d2:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
    10d4:	8a4e                	mv	s4,s3
    10d6:	0009871b          	sext.w	a4,s3
    10da:	6685                	lui	a3,0x1
    10dc:	00d77363          	bgeu	a4,a3,10e2 <malloc+0x44>
    10e0:	6a05                	lui	s4,0x1
    10e2:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
    10e6:	004a1a1b          	sllw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    10ea:	00000917          	auipc	s2,0x0
    10ee:	38690913          	add	s2,s2,902 # 1470 <freep>
  if(p == (char*)-1)
    10f2:	5afd                	li	s5,-1
    10f4:	a091                	j	1138 <malloc+0x9a>
    10f6:	f04a                	sd	s2,32(sp)
    10f8:	e852                	sd	s4,16(sp)
    10fa:	e456                	sd	s5,8(sp)
    10fc:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
    10fe:	00000797          	auipc	a5,0x0
    1102:	37a78793          	add	a5,a5,890 # 1478 <base>
    1106:	00000717          	auipc	a4,0x0
    110a:	36f73523          	sd	a5,874(a4) # 1470 <freep>
    110e:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
    1110:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
    1114:	b7c1                	j	10d4 <malloc+0x36>
        prevp->s.ptr = p->s.ptr;
    1116:	6398                	ld	a4,0(a5)
    1118:	e118                	sd	a4,0(a0)
    111a:	a08d                	j	117c <malloc+0xde>
  hp->s.size = nu;
    111c:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
    1120:	0541                	add	a0,a0,16
    1122:	00000097          	auipc	ra,0x0
    1126:	efa080e7          	jalr	-262(ra) # 101c <free>
  return freep;
    112a:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
    112e:	c13d                	beqz	a0,1194 <malloc+0xf6>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1130:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    1132:	4798                	lw	a4,8(a5)
    1134:	02977463          	bgeu	a4,s1,115c <malloc+0xbe>
    if(p == freep)
    1138:	00093703          	ld	a4,0(s2)
    113c:	853e                	mv	a0,a5
    113e:	fef719e3          	bne	a4,a5,1130 <malloc+0x92>
  p = sbrk(nu * sizeof(Header));
    1142:	8552                	mv	a0,s4
    1144:	00000097          	auipc	ra,0x0
    1148:	92a080e7          	jalr	-1750(ra) # a6e <sbrk>
  if(p == (char*)-1)
    114c:	fd5518e3          	bne	a0,s5,111c <malloc+0x7e>
        return 0;
    1150:	4501                	li	a0,0
    1152:	7902                	ld	s2,32(sp)
    1154:	6a42                	ld	s4,16(sp)
    1156:	6aa2                	ld	s5,8(sp)
    1158:	6b02                	ld	s6,0(sp)
    115a:	a03d                	j	1188 <malloc+0xea>
    115c:	7902                	ld	s2,32(sp)
    115e:	6a42                	ld	s4,16(sp)
    1160:	6aa2                	ld	s5,8(sp)
    1162:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
    1164:	fae489e3          	beq	s1,a4,1116 <malloc+0x78>
        p->s.size -= nunits;
    1168:	4137073b          	subw	a4,a4,s3
    116c:	c798                	sw	a4,8(a5)
        p += p->s.size;
    116e:	02071693          	sll	a3,a4,0x20
    1172:	01c6d713          	srl	a4,a3,0x1c
    1176:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
    1178:	0137a423          	sw	s3,8(a5)
      freep = prevp;
    117c:	00000717          	auipc	a4,0x0
    1180:	2ea73a23          	sd	a0,756(a4) # 1470 <freep>
      return (void*)(p + 1);
    1184:	01078513          	add	a0,a5,16
  }
}
    1188:	70e2                	ld	ra,56(sp)
    118a:	7442                	ld	s0,48(sp)
    118c:	74a2                	ld	s1,40(sp)
    118e:	69e2                	ld	s3,24(sp)
    1190:	6121                	add	sp,sp,64
    1192:	8082                	ret
    1194:	7902                	ld	s2,32(sp)
    1196:	6a42                	ld	s4,16(sp)
    1198:	6aa2                	ld	s5,8(sp)
    119a:	6b02                	ld	s6,0(sp)
    119c:	b7f5                	j	1188 <malloc+0xea>
