
kernel/kernel:     file format elf64-littleriscv


Disassembly of section .text:

0000000080000000 <_entry>:
    80000000:	0003f117          	auipc	sp,0x3f
    80000004:	4d010113          	add	sp,sp,1232 # 8003f4d0 <stack0>
    80000008:	6505                	lui	a0,0x1
    8000000a:	f14025f3          	csrr	a1,mhartid
    8000000e:	0585                	add	a1,a1,1
    80000010:	02b50533          	mul	a0,a0,a1
    80000014:	912a                	add	sp,sp,a0
    80000016:	603080ef          	jal	80008e18 <start>

000000008000001a <spin>:
    8000001a:	a001                	j	8000001a <spin>

000000008000001c <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(void *pa)
{
    8000001c:	1101                	add	sp,sp,-32
    8000001e:	ec06                	sd	ra,24(sp)
    80000020:	e822                	sd	s0,16(sp)
    80000022:	e426                	sd	s1,8(sp)
    80000024:	e04a                	sd	s2,0(sp)
    80000026:	1000                	add	s0,sp,32
  struct run *r;

  if(((uint64)pa % PGSIZE) != 0 || (char*)pa < end || (uint64)pa >= PHYSTOP)
    80000028:	03451793          	sll	a5,a0,0x34
    8000002c:	ebb9                	bnez	a5,80000082 <kfree+0x66>
    8000002e:	84aa                	mv	s1,a0
    80000030:	00047797          	auipc	a5,0x47
    80000034:	5a078793          	add	a5,a5,1440 # 800475d0 <end>
    80000038:	04f56563          	bltu	a0,a5,80000082 <kfree+0x66>
    8000003c:	47c5                	li	a5,17
    8000003e:	07ee                	sll	a5,a5,0x1b
    80000040:	04f57163          	bgeu	a0,a5,80000082 <kfree+0x66>
    panic("kfree");

  // Fill with junk to catch dangling refs.
  memset(pa, 1, PGSIZE);
    80000044:	6605                	lui	a2,0x1
    80000046:	4585                	li	a1,1
    80000048:	00000097          	auipc	ra,0x0
    8000004c:	132080e7          	jalr	306(ra) # 8000017a <memset>

  r = (struct run*)pa;

  acquire(&kmem.lock);
    80000050:	0000c917          	auipc	s2,0xc
    80000054:	00090913          	mv	s2,s2
    80000058:	854a                	mv	a0,s2
    8000005a:	0000a097          	auipc	ra,0xa
    8000005e:	818080e7          	jalr	-2024(ra) # 80009872 <acquire>
  r->next = kmem.freelist;
    80000062:	01893783          	ld	a5,24(s2) # 8000c068 <kmem+0x18>
    80000066:	e09c                	sd	a5,0(s1)
  kmem.freelist = r;
    80000068:	00993c23          	sd	s1,24(s2)
  release(&kmem.lock);
    8000006c:	854a                	mv	a0,s2
    8000006e:	0000a097          	auipc	ra,0xa
    80000072:	8ca080e7          	jalr	-1846(ra) # 80009938 <release>
}
    80000076:	60e2                	ld	ra,24(sp)
    80000078:	6442                	ld	s0,16(sp)
    8000007a:	64a2                	ld	s1,8(sp)
    8000007c:	6902                	ld	s2,0(sp)
    8000007e:	6105                	add	sp,sp,32
    80000080:	8082                	ret
    panic("kfree");
    80000082:	0000b517          	auipc	a0,0xb
    80000086:	f7e50513          	add	a0,a0,-130 # 8000b000 <etext>
    8000008a:	00009097          	auipc	ra,0x9
    8000008e:	24e080e7          	jalr	590(ra) # 800092d8 <panic>

0000000080000092 <freerange>:
{
    80000092:	7179                	add	sp,sp,-48
    80000094:	f406                	sd	ra,40(sp)
    80000096:	f022                	sd	s0,32(sp)
    80000098:	ec26                	sd	s1,24(sp)
    8000009a:	1800                	add	s0,sp,48
  p = (char*)PGROUNDUP((uint64)pa_start);
    8000009c:	6785                	lui	a5,0x1
    8000009e:	fff78713          	add	a4,a5,-1 # fff <_entry-0x7ffff001>
    800000a2:	00e504b3          	add	s1,a0,a4
    800000a6:	777d                	lui	a4,0xfffff
    800000a8:	8cf9                	and	s1,s1,a4
  for(; p + PGSIZE <= (char*)pa_end; p += PGSIZE)
    800000aa:	94be                	add	s1,s1,a5
    800000ac:	0295e463          	bltu	a1,s1,800000d4 <freerange+0x42>
    800000b0:	e84a                	sd	s2,16(sp)
    800000b2:	e44e                	sd	s3,8(sp)
    800000b4:	e052                	sd	s4,0(sp)
    800000b6:	892e                	mv	s2,a1
    kfree(p);
    800000b8:	7a7d                	lui	s4,0xfffff
  for(; p + PGSIZE <= (char*)pa_end; p += PGSIZE)
    800000ba:	6985                	lui	s3,0x1
    kfree(p);
    800000bc:	01448533          	add	a0,s1,s4
    800000c0:	00000097          	auipc	ra,0x0
    800000c4:	f5c080e7          	jalr	-164(ra) # 8000001c <kfree>
  for(; p + PGSIZE <= (char*)pa_end; p += PGSIZE)
    800000c8:	94ce                	add	s1,s1,s3
    800000ca:	fe9979e3          	bgeu	s2,s1,800000bc <freerange+0x2a>
    800000ce:	6942                	ld	s2,16(sp)
    800000d0:	69a2                	ld	s3,8(sp)
    800000d2:	6a02                	ld	s4,0(sp)
}
    800000d4:	70a2                	ld	ra,40(sp)
    800000d6:	7402                	ld	s0,32(sp)
    800000d8:	64e2                	ld	s1,24(sp)
    800000da:	6145                	add	sp,sp,48
    800000dc:	8082                	ret

00000000800000de <kinit>:
{
    800000de:	1141                	add	sp,sp,-16
    800000e0:	e406                	sd	ra,8(sp)
    800000e2:	e022                	sd	s0,0(sp)
    800000e4:	0800                	add	s0,sp,16
  initlock(&kmem.lock, "kmem");
    800000e6:	0000b597          	auipc	a1,0xb
    800000ea:	f2a58593          	add	a1,a1,-214 # 8000b010 <etext+0x10>
    800000ee:	0000c517          	auipc	a0,0xc
    800000f2:	f6250513          	add	a0,a0,-158 # 8000c050 <kmem>
    800000f6:	00009097          	auipc	ra,0x9
    800000fa:	6ec080e7          	jalr	1772(ra) # 800097e2 <initlock>
  freerange(end, (void*)PHYSTOP);
    800000fe:	45c5                	li	a1,17
    80000100:	05ee                	sll	a1,a1,0x1b
    80000102:	00047517          	auipc	a0,0x47
    80000106:	4ce50513          	add	a0,a0,1230 # 800475d0 <end>
    8000010a:	00000097          	auipc	ra,0x0
    8000010e:	f88080e7          	jalr	-120(ra) # 80000092 <freerange>
}
    80000112:	60a2                	ld	ra,8(sp)
    80000114:	6402                	ld	s0,0(sp)
    80000116:	0141                	add	sp,sp,16
    80000118:	8082                	ret

000000008000011a <kalloc>:
// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
void *
kalloc(void)
{
    8000011a:	1101                	add	sp,sp,-32
    8000011c:	ec06                	sd	ra,24(sp)
    8000011e:	e822                	sd	s0,16(sp)
    80000120:	e426                	sd	s1,8(sp)
    80000122:	1000                	add	s0,sp,32
  struct run *r;

  acquire(&kmem.lock);
    80000124:	0000c497          	auipc	s1,0xc
    80000128:	f2c48493          	add	s1,s1,-212 # 8000c050 <kmem>
    8000012c:	8526                	mv	a0,s1
    8000012e:	00009097          	auipc	ra,0x9
    80000132:	744080e7          	jalr	1860(ra) # 80009872 <acquire>
  r = kmem.freelist;
    80000136:	6c84                	ld	s1,24(s1)
  if(r)
    80000138:	c885                	beqz	s1,80000168 <kalloc+0x4e>
    kmem.freelist = r->next;
    8000013a:	609c                	ld	a5,0(s1)
    8000013c:	0000c517          	auipc	a0,0xc
    80000140:	f1450513          	add	a0,a0,-236 # 8000c050 <kmem>
    80000144:	ed1c                	sd	a5,24(a0)
  release(&kmem.lock);
    80000146:	00009097          	auipc	ra,0x9
    8000014a:	7f2080e7          	jalr	2034(ra) # 80009938 <release>

  if(r)
    memset((char*)r, 5, PGSIZE); // fill with junk
    8000014e:	6605                	lui	a2,0x1
    80000150:	4595                	li	a1,5
    80000152:	8526                	mv	a0,s1
    80000154:	00000097          	auipc	ra,0x0
    80000158:	026080e7          	jalr	38(ra) # 8000017a <memset>
  return (void*)r;
}
    8000015c:	8526                	mv	a0,s1
    8000015e:	60e2                	ld	ra,24(sp)
    80000160:	6442                	ld	s0,16(sp)
    80000162:	64a2                	ld	s1,8(sp)
    80000164:	6105                	add	sp,sp,32
    80000166:	8082                	ret
  release(&kmem.lock);
    80000168:	0000c517          	auipc	a0,0xc
    8000016c:	ee850513          	add	a0,a0,-280 # 8000c050 <kmem>
    80000170:	00009097          	auipc	ra,0x9
    80000174:	7c8080e7          	jalr	1992(ra) # 80009938 <release>
  if(r)
    80000178:	b7d5                	j	8000015c <kalloc+0x42>

000000008000017a <memset>:
#include "types.h"

void*
memset(void *dst, int c, uint n)
{
    8000017a:	1141                	add	sp,sp,-16
    8000017c:	e422                	sd	s0,8(sp)
    8000017e:	0800                	add	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
    80000180:	ca19                	beqz	a2,80000196 <memset+0x1c>
    80000182:	87aa                	mv	a5,a0
    80000184:	1602                	sll	a2,a2,0x20
    80000186:	9201                	srl	a2,a2,0x20
    80000188:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
    8000018c:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
    80000190:	0785                	add	a5,a5,1
    80000192:	fee79de3          	bne	a5,a4,8000018c <memset+0x12>
  }
  return dst;
}
    80000196:	6422                	ld	s0,8(sp)
    80000198:	0141                	add	sp,sp,16
    8000019a:	8082                	ret

000000008000019c <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
    8000019c:	1141                	add	sp,sp,-16
    8000019e:	e422                	sd	s0,8(sp)
    800001a0:	0800                	add	s0,sp,16
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
    800001a2:	ca05                	beqz	a2,800001d2 <memcmp+0x36>
    800001a4:	fff6069b          	addw	a3,a2,-1 # fff <_entry-0x7ffff001>
    800001a8:	1682                	sll	a3,a3,0x20
    800001aa:	9281                	srl	a3,a3,0x20
    800001ac:	0685                	add	a3,a3,1
    800001ae:	96aa                	add	a3,a3,a0
    if(*s1 != *s2)
    800001b0:	00054783          	lbu	a5,0(a0)
    800001b4:	0005c703          	lbu	a4,0(a1)
    800001b8:	00e79863          	bne	a5,a4,800001c8 <memcmp+0x2c>
      return *s1 - *s2;
    s1++, s2++;
    800001bc:	0505                	add	a0,a0,1
    800001be:	0585                	add	a1,a1,1
  while(n-- > 0){
    800001c0:	fed518e3          	bne	a0,a3,800001b0 <memcmp+0x14>
  }

  return 0;
    800001c4:	4501                	li	a0,0
    800001c6:	a019                	j	800001cc <memcmp+0x30>
      return *s1 - *s2;
    800001c8:	40e7853b          	subw	a0,a5,a4
}
    800001cc:	6422                	ld	s0,8(sp)
    800001ce:	0141                	add	sp,sp,16
    800001d0:	8082                	ret
  return 0;
    800001d2:	4501                	li	a0,0
    800001d4:	bfe5                	j	800001cc <memcmp+0x30>

00000000800001d6 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
    800001d6:	1141                	add	sp,sp,-16
    800001d8:	e422                	sd	s0,8(sp)
    800001da:	0800                	add	s0,sp,16
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
    800001dc:	02a5e563          	bltu	a1,a0,80000206 <memmove+0x30>
    s += n;
    d += n;
    while(n-- > 0)
      *--d = *--s;
  } else
    while(n-- > 0)
    800001e0:	fff6069b          	addw	a3,a2,-1
    800001e4:	ce11                	beqz	a2,80000200 <memmove+0x2a>
    800001e6:	1682                	sll	a3,a3,0x20
    800001e8:	9281                	srl	a3,a3,0x20
    800001ea:	0685                	add	a3,a3,1
    800001ec:	96ae                	add	a3,a3,a1
    800001ee:	87aa                	mv	a5,a0
      *d++ = *s++;
    800001f0:	0585                	add	a1,a1,1
    800001f2:	0785                	add	a5,a5,1
    800001f4:	fff5c703          	lbu	a4,-1(a1)
    800001f8:	fee78fa3          	sb	a4,-1(a5)
    while(n-- > 0)
    800001fc:	feb69ae3          	bne	a3,a1,800001f0 <memmove+0x1a>

  return dst;
}
    80000200:	6422                	ld	s0,8(sp)
    80000202:	0141                	add	sp,sp,16
    80000204:	8082                	ret
  if(s < d && s + n > d){
    80000206:	02061713          	sll	a4,a2,0x20
    8000020a:	9301                	srl	a4,a4,0x20
    8000020c:	00e587b3          	add	a5,a1,a4
    80000210:	fcf578e3          	bgeu	a0,a5,800001e0 <memmove+0xa>
    d += n;
    80000214:	972a                	add	a4,a4,a0
    while(n-- > 0)
    80000216:	fff6069b          	addw	a3,a2,-1
    8000021a:	d27d                	beqz	a2,80000200 <memmove+0x2a>
    8000021c:	02069613          	sll	a2,a3,0x20
    80000220:	9201                	srl	a2,a2,0x20
    80000222:	fff64613          	not	a2,a2
    80000226:	963e                	add	a2,a2,a5
      *--d = *--s;
    80000228:	17fd                	add	a5,a5,-1
    8000022a:	177d                	add	a4,a4,-1 # ffffffffffffefff <end+0xffffffff7ffb7a2f>
    8000022c:	0007c683          	lbu	a3,0(a5)
    80000230:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
    80000234:	fec79ae3          	bne	a5,a2,80000228 <memmove+0x52>
    80000238:	b7e1                	j	80000200 <memmove+0x2a>

000000008000023a <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
    8000023a:	1141                	add	sp,sp,-16
    8000023c:	e406                	sd	ra,8(sp)
    8000023e:	e022                	sd	s0,0(sp)
    80000240:	0800                	add	s0,sp,16
  return memmove(dst, src, n);
    80000242:	00000097          	auipc	ra,0x0
    80000246:	f94080e7          	jalr	-108(ra) # 800001d6 <memmove>
}
    8000024a:	60a2                	ld	ra,8(sp)
    8000024c:	6402                	ld	s0,0(sp)
    8000024e:	0141                	add	sp,sp,16
    80000250:	8082                	ret

0000000080000252 <strncmp>:

int
strncmp(const char *p, const char *q, uint n)
{
    80000252:	1141                	add	sp,sp,-16
    80000254:	e422                	sd	s0,8(sp)
    80000256:	0800                	add	s0,sp,16
  while(n > 0 && *p && *p == *q)
    80000258:	ce11                	beqz	a2,80000274 <strncmp+0x22>
    8000025a:	00054783          	lbu	a5,0(a0)
    8000025e:	cf89                	beqz	a5,80000278 <strncmp+0x26>
    80000260:	0005c703          	lbu	a4,0(a1)
    80000264:	00f71a63          	bne	a4,a5,80000278 <strncmp+0x26>
    n--, p++, q++;
    80000268:	367d                	addw	a2,a2,-1
    8000026a:	0505                	add	a0,a0,1
    8000026c:	0585                	add	a1,a1,1
  while(n > 0 && *p && *p == *q)
    8000026e:	f675                	bnez	a2,8000025a <strncmp+0x8>
  if(n == 0)
    return 0;
    80000270:	4501                	li	a0,0
    80000272:	a801                	j	80000282 <strncmp+0x30>
    80000274:	4501                	li	a0,0
    80000276:	a031                	j	80000282 <strncmp+0x30>
  return (uchar)*p - (uchar)*q;
    80000278:	00054503          	lbu	a0,0(a0)
    8000027c:	0005c783          	lbu	a5,0(a1)
    80000280:	9d1d                	subw	a0,a0,a5
}
    80000282:	6422                	ld	s0,8(sp)
    80000284:	0141                	add	sp,sp,16
    80000286:	8082                	ret

0000000080000288 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
    80000288:	1141                	add	sp,sp,-16
    8000028a:	e422                	sd	s0,8(sp)
    8000028c:	0800                	add	s0,sp,16
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
    8000028e:	87aa                	mv	a5,a0
    80000290:	86b2                	mv	a3,a2
    80000292:	367d                	addw	a2,a2,-1
    80000294:	02d05563          	blez	a3,800002be <strncpy+0x36>
    80000298:	0785                	add	a5,a5,1
    8000029a:	0005c703          	lbu	a4,0(a1)
    8000029e:	fee78fa3          	sb	a4,-1(a5)
    800002a2:	0585                	add	a1,a1,1
    800002a4:	f775                	bnez	a4,80000290 <strncpy+0x8>
    ;
  while(n-- > 0)
    800002a6:	873e                	mv	a4,a5
    800002a8:	9fb5                	addw	a5,a5,a3
    800002aa:	37fd                	addw	a5,a5,-1
    800002ac:	00c05963          	blez	a2,800002be <strncpy+0x36>
    *s++ = 0;
    800002b0:	0705                	add	a4,a4,1
    800002b2:	fe070fa3          	sb	zero,-1(a4)
  while(n-- > 0)
    800002b6:	40e786bb          	subw	a3,a5,a4
    800002ba:	fed04be3          	bgtz	a3,800002b0 <strncpy+0x28>
  return os;
}
    800002be:	6422                	ld	s0,8(sp)
    800002c0:	0141                	add	sp,sp,16
    800002c2:	8082                	ret

00000000800002c4 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
    800002c4:	1141                	add	sp,sp,-16
    800002c6:	e422                	sd	s0,8(sp)
    800002c8:	0800                	add	s0,sp,16
  char *os;

  os = s;
  if(n <= 0)
    800002ca:	02c05363          	blez	a2,800002f0 <safestrcpy+0x2c>
    800002ce:	fff6069b          	addw	a3,a2,-1
    800002d2:	1682                	sll	a3,a3,0x20
    800002d4:	9281                	srl	a3,a3,0x20
    800002d6:	96ae                	add	a3,a3,a1
    800002d8:	87aa                	mv	a5,a0
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
    800002da:	00d58963          	beq	a1,a3,800002ec <safestrcpy+0x28>
    800002de:	0585                	add	a1,a1,1
    800002e0:	0785                	add	a5,a5,1
    800002e2:	fff5c703          	lbu	a4,-1(a1)
    800002e6:	fee78fa3          	sb	a4,-1(a5)
    800002ea:	fb65                	bnez	a4,800002da <safestrcpy+0x16>
    ;
  *s = 0;
    800002ec:	00078023          	sb	zero,0(a5)
  return os;
}
    800002f0:	6422                	ld	s0,8(sp)
    800002f2:	0141                	add	sp,sp,16
    800002f4:	8082                	ret

00000000800002f6 <strlen>:

int
strlen(const char *s)
{
    800002f6:	1141                	add	sp,sp,-16
    800002f8:	e422                	sd	s0,8(sp)
    800002fa:	0800                	add	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
    800002fc:	00054783          	lbu	a5,0(a0)
    80000300:	cf91                	beqz	a5,8000031c <strlen+0x26>
    80000302:	0505                	add	a0,a0,1
    80000304:	87aa                	mv	a5,a0
    80000306:	86be                	mv	a3,a5
    80000308:	0785                	add	a5,a5,1
    8000030a:	fff7c703          	lbu	a4,-1(a5)
    8000030e:	ff65                	bnez	a4,80000306 <strlen+0x10>
    80000310:	40a6853b          	subw	a0,a3,a0
    80000314:	2505                	addw	a0,a0,1
    ;
  return n;
}
    80000316:	6422                	ld	s0,8(sp)
    80000318:	0141                	add	sp,sp,16
    8000031a:	8082                	ret
  for(n = 0; s[n]; n++)
    8000031c:	4501                	li	a0,0
    8000031e:	bfe5                	j	80000316 <strlen+0x20>

0000000080000320 <hello>:


int cnt = 0;
void*
hello(void *arg)
{
    80000320:	1141                	add	sp,sp,-16
    80000322:	e406                	sd	ra,8(sp)
    80000324:	e022                	sd	s0,0(sp)
    80000326:	0800                	add	s0,sp,16
  printf("hhhhh hello!!! in timer!!!\n");
    80000328:	0000b517          	auipc	a0,0xb
    8000032c:	cf050513          	add	a0,a0,-784 # 8000b018 <etext+0x18>
    80000330:	00009097          	auipc	ra,0x9
    80000334:	ff2080e7          	jalr	-14(ra) # 80009322 <printf>
  if (++cnt < 5)
    80000338:	0000c717          	auipc	a4,0xc
    8000033c:	cc870713          	add	a4,a4,-824 # 8000c000 <cnt>
    80000340:	431c                	lw	a5,0(a4)
    80000342:	2785                	addw	a5,a5,1
    80000344:	0007869b          	sext.w	a3,a5
    80000348:	c31c                	sw	a5,0(a4)
    8000034a:	4791                	li	a5,4
    8000034c:	00d7d763          	bge	a5,a3,8000035a <hello+0x3a>
    timer_add_in_handler(10, hello, NULL);
  return NULL;
}
    80000350:	4501                	li	a0,0
    80000352:	60a2                	ld	ra,8(sp)
    80000354:	6402                	ld	s0,0(sp)
    80000356:	0141                	add	sp,sp,16
    80000358:	8082                	ret
    timer_add_in_handler(10, hello, NULL);
    8000035a:	4601                	li	a2,0
    8000035c:	00000597          	auipc	a1,0x0
    80000360:	fc458593          	add	a1,a1,-60 # 80000320 <hello>
    80000364:	4529                	li	a0,10
    80000366:	00009097          	auipc	ra,0x9
    8000036a:	8d8080e7          	jalr	-1832(ra) # 80008c3e <timer_add_in_handler>
    8000036e:	b7cd                	j	80000350 <hello+0x30>

0000000080000370 <main>:

// start() jumps here in supervisor mode on all CPUs.
void
main()
{
    80000370:	1101                	add	sp,sp,-32
    80000372:	ec06                	sd	ra,24(sp)
    80000374:	e822                	sd	s0,16(sp)
    80000376:	e426                	sd	s1,8(sp)
    80000378:	1000                	add	s0,sp,32
  if(cpuid() == 0){
    8000037a:	00001097          	auipc	ra,0x1
    8000037e:	ba0080e7          	jalr	-1120(ra) # 80000f1a <cpuid>
    userinit();      // first user process
    // timer_add(10, hello, NULL);
    __sync_synchronize();
    started = 1;
  } else {
    while(lockfree_read4((int *) &started) == 0)
    80000382:	0000c497          	auipc	s1,0xc
    80000386:	c8248493          	add	s1,s1,-894 # 8000c004 <started>
  if(cpuid() == 0){
    8000038a:	c531                	beqz	a0,800003d6 <main+0x66>
    while(lockfree_read4((int *) &started) == 0)
    8000038c:	8526                	mv	a0,s1
    8000038e:	00009097          	auipc	ra,0x9
    80000392:	61a080e7          	jalr	1562(ra) # 800099a8 <lockfree_read4>
    80000396:	d97d                	beqz	a0,8000038c <main+0x1c>
      ;
    __sync_synchronize();
    80000398:	0ff0000f          	fence
    printf("hart %d starting\n", cpuid());
    8000039c:	00001097          	auipc	ra,0x1
    800003a0:	b7e080e7          	jalr	-1154(ra) # 80000f1a <cpuid>
    800003a4:	85aa                	mv	a1,a0
    800003a6:	0000b517          	auipc	a0,0xb
    800003aa:	cb250513          	add	a0,a0,-846 # 8000b058 <etext+0x58>
    800003ae:	00009097          	auipc	ra,0x9
    800003b2:	f74080e7          	jalr	-140(ra) # 80009322 <printf>
    kvminithart();    // turn on paging
    800003b6:	00000097          	auipc	ra,0x0
    800003ba:	0f0080e7          	jalr	240(ra) # 800004a6 <kvminithart>
    trapinithart();   // install kernel trap vector
    800003be:	00001097          	auipc	ra,0x1
    800003c2:	7e8080e7          	jalr	2024(ra) # 80001ba6 <trapinithart>
    plicinithart();   // ask PLIC for device interrupts
    800003c6:	00005097          	auipc	ra,0x5
    800003ca:	372080e7          	jalr	882(ra) # 80005738 <plicinithart>
  }

  scheduler();        
    800003ce:	00001097          	auipc	ra,0x1
    800003d2:	0b2080e7          	jalr	178(ra) # 80001480 <scheduler>
    timer_init();
    800003d6:	00008097          	auipc	ra,0x8
    800003da:	794080e7          	jalr	1940(ra) # 80008b6a <timer_init>
    consoleinit();
    800003de:	00009097          	auipc	ra,0x9
    800003e2:	e0a080e7          	jalr	-502(ra) # 800091e8 <consoleinit>
    printfinit();
    800003e6:	00009097          	auipc	ra,0x9
    800003ea:	164080e7          	jalr	356(ra) # 8000954a <printfinit>
    printf("\n");
    800003ee:	0000b517          	auipc	a0,0xb
    800003f2:	c4a50513          	add	a0,a0,-950 # 8000b038 <etext+0x38>
    800003f6:	00009097          	auipc	ra,0x9
    800003fa:	f2c080e7          	jalr	-212(ra) # 80009322 <printf>
    printf("xv6 kernel is booting\n");
    800003fe:	0000b517          	auipc	a0,0xb
    80000402:	c4250513          	add	a0,a0,-958 # 8000b040 <etext+0x40>
    80000406:	00009097          	auipc	ra,0x9
    8000040a:	f1c080e7          	jalr	-228(ra) # 80009322 <printf>
    printf("\n");
    8000040e:	0000b517          	auipc	a0,0xb
    80000412:	c2a50513          	add	a0,a0,-982 # 8000b038 <etext+0x38>
    80000416:	00009097          	auipc	ra,0x9
    8000041a:	f0c080e7          	jalr	-244(ra) # 80009322 <printf>
    kinit();         // physical page allocator
    8000041e:	00000097          	auipc	ra,0x0
    80000422:	cc0080e7          	jalr	-832(ra) # 800000de <kinit>
    kvminit();       // create kernel page table
    80000426:	00000097          	auipc	ra,0x0
    8000042a:	350080e7          	jalr	848(ra) # 80000776 <kvminit>
    kvminithart();   // turn on paging
    8000042e:	00000097          	auipc	ra,0x0
    80000432:	078080e7          	jalr	120(ra) # 800004a6 <kvminithart>
    procinit();      // process table
    80000436:	00001097          	auipc	ra,0x1
    8000043a:	a44080e7          	jalr	-1468(ra) # 80000e7a <procinit>
    trapinit();      // trap vectors
    8000043e:	00001097          	auipc	ra,0x1
    80000442:	740080e7          	jalr	1856(ra) # 80001b7e <trapinit>
    trapinithart();  // install kernel trap vector
    80000446:	00001097          	auipc	ra,0x1
    8000044a:	760080e7          	jalr	1888(ra) # 80001ba6 <trapinithart>
    plicinit();      // set up interrupt controller
    8000044e:	00005097          	auipc	ra,0x5
    80000452:	2bc080e7          	jalr	700(ra) # 8000570a <plicinit>
    plicinithart();  // ask PLIC for device interrupts
    80000456:	00005097          	auipc	ra,0x5
    8000045a:	2e2080e7          	jalr	738(ra) # 80005738 <plicinithart>
    binit();         // buffer cache
    8000045e:	00002097          	auipc	ra,0x2
    80000462:	ee2080e7          	jalr	-286(ra) # 80002340 <binit>
    iinit();         // inode cache
    80000466:	00002097          	auipc	ra,0x2
    8000046a:	56e080e7          	jalr	1390(ra) # 800029d4 <iinit>
    fileinit();      // file table
    8000046e:	00003097          	auipc	ra,0x3
    80000472:	51a080e7          	jalr	1306(ra) # 80003988 <fileinit>
    virtio_disk_init(); // emulated hard disk
    80000476:	00005097          	auipc	ra,0x5
    8000047a:	3e8080e7          	jalr	1000(ra) # 8000585e <virtio_disk_init>
    pci_init();
    8000047e:	00006097          	auipc	ra,0x6
    80000482:	6e2080e7          	jalr	1762(ra) # 80006b60 <pci_init>
    sockinit();
    80000486:	00006097          	auipc	ra,0x6
    8000048a:	29e080e7          	jalr	670(ra) # 80006724 <sockinit>
    userinit();      // first user process
    8000048e:	00001097          	auipc	ra,0x1
    80000492:	d82080e7          	jalr	-638(ra) # 80001210 <userinit>
    __sync_synchronize();
    80000496:	0ff0000f          	fence
    started = 1;
    8000049a:	4785                	li	a5,1
    8000049c:	0000c717          	auipc	a4,0xc
    800004a0:	b6f72423          	sw	a5,-1176(a4) # 8000c004 <started>
    800004a4:	b72d                	j	800003ce <main+0x5e>

00000000800004a6 <kvminithart>:

// Switch h/w page table register to the kernel's page table,
// and enable paging.
void
kvminithart()
{
    800004a6:	1141                	add	sp,sp,-16
    800004a8:	e422                	sd	s0,8(sp)
    800004aa:	0800                	add	s0,sp,16
  w_satp(MAKE_SATP(kernel_pagetable));
    800004ac:	0000c797          	auipc	a5,0xc
    800004b0:	b5c7b783          	ld	a5,-1188(a5) # 8000c008 <kernel_pagetable>
    800004b4:	83b1                	srl	a5,a5,0xc
    800004b6:	577d                	li	a4,-1
    800004b8:	177e                	sll	a4,a4,0x3f
    800004ba:	8fd9                	or	a5,a5,a4
// supervisor address translation and protection;
// holds the address of the page table.
static inline void 
w_satp(uint64 x)
{
  asm volatile("csrw satp, %0" : : "r" (x));
    800004bc:	18079073          	csrw	satp,a5
// flush the TLB.
static inline void
sfence_vma()
{
  // the zero, zero means flush all TLB entries.
  asm volatile("sfence.vma zero, zero");
    800004c0:	12000073          	sfence.vma
  sfence_vma();
}
    800004c4:	6422                	ld	s0,8(sp)
    800004c6:	0141                	add	sp,sp,16
    800004c8:	8082                	ret

00000000800004ca <walk>:
//   21..29 -- 9 bits of level-1 index.
//   12..20 -- 9 bits of level-0 index.
//    0..11 -- 12 bits of byte offset within the page.
pte_t *
walk(pagetable_t pagetable, uint64 va, int alloc)
{
    800004ca:	7139                	add	sp,sp,-64
    800004cc:	fc06                	sd	ra,56(sp)
    800004ce:	f822                	sd	s0,48(sp)
    800004d0:	f426                	sd	s1,40(sp)
    800004d2:	f04a                	sd	s2,32(sp)
    800004d4:	ec4e                	sd	s3,24(sp)
    800004d6:	e852                	sd	s4,16(sp)
    800004d8:	e456                	sd	s5,8(sp)
    800004da:	e05a                	sd	s6,0(sp)
    800004dc:	0080                	add	s0,sp,64
    800004de:	84aa                	mv	s1,a0
    800004e0:	89ae                	mv	s3,a1
    800004e2:	8ab2                	mv	s5,a2
  if(va >= MAXVA)
    800004e4:	57fd                	li	a5,-1
    800004e6:	83e9                	srl	a5,a5,0x1a
    800004e8:	4a79                	li	s4,30
    panic("walk");

  for(int level = 2; level > 0; level--) {
    800004ea:	4b31                	li	s6,12
  if(va >= MAXVA)
    800004ec:	04b7f263          	bgeu	a5,a1,80000530 <walk+0x66>
    panic("walk");
    800004f0:	0000b517          	auipc	a0,0xb
    800004f4:	b8050513          	add	a0,a0,-1152 # 8000b070 <etext+0x70>
    800004f8:	00009097          	auipc	ra,0x9
    800004fc:	de0080e7          	jalr	-544(ra) # 800092d8 <panic>
    pte_t *pte = &pagetable[PX(level, va)];
    if(*pte & PTE_V) {
      pagetable = (pagetable_t)PTE2PA(*pte);
    } else {
      if(!alloc || (pagetable = (pde_t*)kalloc()) == 0)
    80000500:	060a8663          	beqz	s5,8000056c <walk+0xa2>
    80000504:	00000097          	auipc	ra,0x0
    80000508:	c16080e7          	jalr	-1002(ra) # 8000011a <kalloc>
    8000050c:	84aa                	mv	s1,a0
    8000050e:	c529                	beqz	a0,80000558 <walk+0x8e>
        return 0;
      memset(pagetable, 0, PGSIZE);
    80000510:	6605                	lui	a2,0x1
    80000512:	4581                	li	a1,0
    80000514:	00000097          	auipc	ra,0x0
    80000518:	c66080e7          	jalr	-922(ra) # 8000017a <memset>
      *pte = PA2PTE(pagetable) | PTE_V;
    8000051c:	00c4d793          	srl	a5,s1,0xc
    80000520:	07aa                	sll	a5,a5,0xa
    80000522:	0017e793          	or	a5,a5,1
    80000526:	00f93023          	sd	a5,0(s2)
  for(int level = 2; level > 0; level--) {
    8000052a:	3a5d                	addw	s4,s4,-9 # ffffffffffffeff7 <end+0xffffffff7ffb7a27>
    8000052c:	036a0063          	beq	s4,s6,8000054c <walk+0x82>
    pte_t *pte = &pagetable[PX(level, va)];
    80000530:	0149d933          	srl	s2,s3,s4
    80000534:	1ff97913          	and	s2,s2,511
    80000538:	090e                	sll	s2,s2,0x3
    8000053a:	9926                	add	s2,s2,s1
    if(*pte & PTE_V) {
    8000053c:	00093483          	ld	s1,0(s2)
    80000540:	0014f793          	and	a5,s1,1
    80000544:	dfd5                	beqz	a5,80000500 <walk+0x36>
      pagetable = (pagetable_t)PTE2PA(*pte);
    80000546:	80a9                	srl	s1,s1,0xa
    80000548:	04b2                	sll	s1,s1,0xc
    8000054a:	b7c5                	j	8000052a <walk+0x60>
    }
  }
  return &pagetable[PX(0, va)];
    8000054c:	00c9d513          	srl	a0,s3,0xc
    80000550:	1ff57513          	and	a0,a0,511
    80000554:	050e                	sll	a0,a0,0x3
    80000556:	9526                	add	a0,a0,s1
}
    80000558:	70e2                	ld	ra,56(sp)
    8000055a:	7442                	ld	s0,48(sp)
    8000055c:	74a2                	ld	s1,40(sp)
    8000055e:	7902                	ld	s2,32(sp)
    80000560:	69e2                	ld	s3,24(sp)
    80000562:	6a42                	ld	s4,16(sp)
    80000564:	6aa2                	ld	s5,8(sp)
    80000566:	6b02                	ld	s6,0(sp)
    80000568:	6121                	add	sp,sp,64
    8000056a:	8082                	ret
        return 0;
    8000056c:	4501                	li	a0,0
    8000056e:	b7ed                	j	80000558 <walk+0x8e>

0000000080000570 <walkaddr>:
walkaddr(pagetable_t pagetable, uint64 va)
{
  pte_t *pte;
  uint64 pa;

  if(va >= MAXVA)
    80000570:	57fd                	li	a5,-1
    80000572:	83e9                	srl	a5,a5,0x1a
    80000574:	00b7f463          	bgeu	a5,a1,8000057c <walkaddr+0xc>
    return 0;
    80000578:	4501                	li	a0,0
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
  pa = PTE2PA(*pte);
  return pa;
}
    8000057a:	8082                	ret
{
    8000057c:	1141                	add	sp,sp,-16
    8000057e:	e406                	sd	ra,8(sp)
    80000580:	e022                	sd	s0,0(sp)
    80000582:	0800                	add	s0,sp,16
  pte = walk(pagetable, va, 0);
    80000584:	4601                	li	a2,0
    80000586:	00000097          	auipc	ra,0x0
    8000058a:	f44080e7          	jalr	-188(ra) # 800004ca <walk>
  if(pte == 0)
    8000058e:	c105                	beqz	a0,800005ae <walkaddr+0x3e>
  if((*pte & PTE_V) == 0)
    80000590:	611c                	ld	a5,0(a0)
  if((*pte & PTE_U) == 0)
    80000592:	0117f693          	and	a3,a5,17
    80000596:	4745                	li	a4,17
    return 0;
    80000598:	4501                	li	a0,0
  if((*pte & PTE_U) == 0)
    8000059a:	00e68663          	beq	a3,a4,800005a6 <walkaddr+0x36>
}
    8000059e:	60a2                	ld	ra,8(sp)
    800005a0:	6402                	ld	s0,0(sp)
    800005a2:	0141                	add	sp,sp,16
    800005a4:	8082                	ret
  pa = PTE2PA(*pte);
    800005a6:	83a9                	srl	a5,a5,0xa
    800005a8:	00c79513          	sll	a0,a5,0xc
  return pa;
    800005ac:	bfcd                	j	8000059e <walkaddr+0x2e>
    return 0;
    800005ae:	4501                	li	a0,0
    800005b0:	b7fd                	j	8000059e <walkaddr+0x2e>

00000000800005b2 <mappages>:
// physical addresses starting at pa. va and size might not
// be page-aligned. Returns 0 on success, -1 if walk() couldn't
// allocate a needed page-table page.
int
mappages(pagetable_t pagetable, uint64 va, uint64 size, uint64 pa, int perm)
{
    800005b2:	715d                	add	sp,sp,-80
    800005b4:	e486                	sd	ra,72(sp)
    800005b6:	e0a2                	sd	s0,64(sp)
    800005b8:	fc26                	sd	s1,56(sp)
    800005ba:	f84a                	sd	s2,48(sp)
    800005bc:	f44e                	sd	s3,40(sp)
    800005be:	f052                	sd	s4,32(sp)
    800005c0:	ec56                	sd	s5,24(sp)
    800005c2:	e85a                	sd	s6,16(sp)
    800005c4:	e45e                	sd	s7,8(sp)
    800005c6:	0880                	add	s0,sp,80
    800005c8:	8aaa                	mv	s5,a0
    800005ca:	8b3a                	mv	s6,a4
  uint64 a, last;
  pte_t *pte;

  a = PGROUNDDOWN(va);
    800005cc:	777d                	lui	a4,0xfffff
    800005ce:	00e5f7b3          	and	a5,a1,a4
  last = PGROUNDDOWN(va + size - 1);
    800005d2:	fff60993          	add	s3,a2,-1 # fff <_entry-0x7ffff001>
    800005d6:	99ae                	add	s3,s3,a1
    800005d8:	00e9f9b3          	and	s3,s3,a4
  a = PGROUNDDOWN(va);
    800005dc:	893e                	mv	s2,a5
    800005de:	40f68a33          	sub	s4,a3,a5
    if(*pte & PTE_V)
      panic("remap");
    *pte = PA2PTE(pa) | perm | PTE_V;
    if(a == last)
      break;
    a += PGSIZE;
    800005e2:	6b85                	lui	s7,0x1
    800005e4:	014904b3          	add	s1,s2,s4
    if((pte = walk(pagetable, a, 1)) == 0)
    800005e8:	4605                	li	a2,1
    800005ea:	85ca                	mv	a1,s2
    800005ec:	8556                	mv	a0,s5
    800005ee:	00000097          	auipc	ra,0x0
    800005f2:	edc080e7          	jalr	-292(ra) # 800004ca <walk>
    800005f6:	c51d                	beqz	a0,80000624 <mappages+0x72>
    if(*pte & PTE_V)
    800005f8:	611c                	ld	a5,0(a0)
    800005fa:	8b85                	and	a5,a5,1
    800005fc:	ef81                	bnez	a5,80000614 <mappages+0x62>
    *pte = PA2PTE(pa) | perm | PTE_V;
    800005fe:	80b1                	srl	s1,s1,0xc
    80000600:	04aa                	sll	s1,s1,0xa
    80000602:	0164e4b3          	or	s1,s1,s6
    80000606:	0014e493          	or	s1,s1,1
    8000060a:	e104                	sd	s1,0(a0)
    if(a == last)
    8000060c:	03390863          	beq	s2,s3,8000063c <mappages+0x8a>
    a += PGSIZE;
    80000610:	995e                	add	s2,s2,s7
    if((pte = walk(pagetable, a, 1)) == 0)
    80000612:	bfc9                	j	800005e4 <mappages+0x32>
      panic("remap");
    80000614:	0000b517          	auipc	a0,0xb
    80000618:	a6450513          	add	a0,a0,-1436 # 8000b078 <etext+0x78>
    8000061c:	00009097          	auipc	ra,0x9
    80000620:	cbc080e7          	jalr	-836(ra) # 800092d8 <panic>
      return -1;
    80000624:	557d                	li	a0,-1
    pa += PGSIZE;
  }
  return 0;
}
    80000626:	60a6                	ld	ra,72(sp)
    80000628:	6406                	ld	s0,64(sp)
    8000062a:	74e2                	ld	s1,56(sp)
    8000062c:	7942                	ld	s2,48(sp)
    8000062e:	79a2                	ld	s3,40(sp)
    80000630:	7a02                	ld	s4,32(sp)
    80000632:	6ae2                	ld	s5,24(sp)
    80000634:	6b42                	ld	s6,16(sp)
    80000636:	6ba2                	ld	s7,8(sp)
    80000638:	6161                	add	sp,sp,80
    8000063a:	8082                	ret
  return 0;
    8000063c:	4501                	li	a0,0
    8000063e:	b7e5                	j	80000626 <mappages+0x74>

0000000080000640 <kvmmap>:
{
    80000640:	1141                	add	sp,sp,-16
    80000642:	e406                	sd	ra,8(sp)
    80000644:	e022                	sd	s0,0(sp)
    80000646:	0800                	add	s0,sp,16
    80000648:	87b6                	mv	a5,a3
  if(mappages(kpgtbl, va, sz, pa, perm) != 0)
    8000064a:	86b2                	mv	a3,a2
    8000064c:	863e                	mv	a2,a5
    8000064e:	00000097          	auipc	ra,0x0
    80000652:	f64080e7          	jalr	-156(ra) # 800005b2 <mappages>
    80000656:	e509                	bnez	a0,80000660 <kvmmap+0x20>
}
    80000658:	60a2                	ld	ra,8(sp)
    8000065a:	6402                	ld	s0,0(sp)
    8000065c:	0141                	add	sp,sp,16
    8000065e:	8082                	ret
    panic("kvmmap");
    80000660:	0000b517          	auipc	a0,0xb
    80000664:	a2050513          	add	a0,a0,-1504 # 8000b080 <etext+0x80>
    80000668:	00009097          	auipc	ra,0x9
    8000066c:	c70080e7          	jalr	-912(ra) # 800092d8 <panic>

0000000080000670 <kvmmake>:
{
    80000670:	1101                	add	sp,sp,-32
    80000672:	ec06                	sd	ra,24(sp)
    80000674:	e822                	sd	s0,16(sp)
    80000676:	e426                	sd	s1,8(sp)
    80000678:	e04a                	sd	s2,0(sp)
    8000067a:	1000                	add	s0,sp,32
  kpgtbl = (pagetable_t) kalloc();
    8000067c:	00000097          	auipc	ra,0x0
    80000680:	a9e080e7          	jalr	-1378(ra) # 8000011a <kalloc>
    80000684:	84aa                	mv	s1,a0
  memset(kpgtbl, 0, PGSIZE);
    80000686:	6605                	lui	a2,0x1
    80000688:	4581                	li	a1,0
    8000068a:	00000097          	auipc	ra,0x0
    8000068e:	af0080e7          	jalr	-1296(ra) # 8000017a <memset>
  kvmmap(kpgtbl, UART0, UART0, PGSIZE, PTE_R | PTE_W);
    80000692:	4719                	li	a4,6
    80000694:	6685                	lui	a3,0x1
    80000696:	10000637          	lui	a2,0x10000
    8000069a:	100005b7          	lui	a1,0x10000
    8000069e:	8526                	mv	a0,s1
    800006a0:	00000097          	auipc	ra,0x0
    800006a4:	fa0080e7          	jalr	-96(ra) # 80000640 <kvmmap>
  kvmmap(kpgtbl, VIRTIO0, VIRTIO0, PGSIZE, PTE_R | PTE_W);
    800006a8:	4719                	li	a4,6
    800006aa:	6685                	lui	a3,0x1
    800006ac:	10001637          	lui	a2,0x10001
    800006b0:	100015b7          	lui	a1,0x10001
    800006b4:	8526                	mv	a0,s1
    800006b6:	00000097          	auipc	ra,0x0
    800006ba:	f8a080e7          	jalr	-118(ra) # 80000640 <kvmmap>
  kvmmap(kpgtbl, 0x30000000L, 0x30000000L, 0x10000000, PTE_R | PTE_W);
    800006be:	4719                	li	a4,6
    800006c0:	100006b7          	lui	a3,0x10000
    800006c4:	30000637          	lui	a2,0x30000
    800006c8:	300005b7          	lui	a1,0x30000
    800006cc:	8526                	mv	a0,s1
    800006ce:	00000097          	auipc	ra,0x0
    800006d2:	f72080e7          	jalr	-142(ra) # 80000640 <kvmmap>
  kvmmap(kpgtbl, 0x40000000L, 0x40000000L, 0x20000, PTE_R | PTE_W);
    800006d6:	4719                	li	a4,6
    800006d8:	000206b7          	lui	a3,0x20
    800006dc:	40000637          	lui	a2,0x40000
    800006e0:	400005b7          	lui	a1,0x40000
    800006e4:	8526                	mv	a0,s1
    800006e6:	00000097          	auipc	ra,0x0
    800006ea:	f5a080e7          	jalr	-166(ra) # 80000640 <kvmmap>
  kvmmap(kpgtbl, PLIC, PLIC, 0x400000, PTE_R | PTE_W);
    800006ee:	4719                	li	a4,6
    800006f0:	004006b7          	lui	a3,0x400
    800006f4:	0c000637          	lui	a2,0xc000
    800006f8:	0c0005b7          	lui	a1,0xc000
    800006fc:	8526                	mv	a0,s1
    800006fe:	00000097          	auipc	ra,0x0
    80000702:	f42080e7          	jalr	-190(ra) # 80000640 <kvmmap>
  kvmmap(kpgtbl, KERNBASE, KERNBASE, (uint64)etext-KERNBASE, PTE_R | PTE_X);
    80000706:	0000b917          	auipc	s2,0xb
    8000070a:	8fa90913          	add	s2,s2,-1798 # 8000b000 <etext>
    8000070e:	4729                	li	a4,10
    80000710:	8000b697          	auipc	a3,0x8000b
    80000714:	8f068693          	add	a3,a3,-1808 # b000 <_entry-0x7fff5000>
    80000718:	4605                	li	a2,1
    8000071a:	067e                	sll	a2,a2,0x1f
    8000071c:	85b2                	mv	a1,a2
    8000071e:	8526                	mv	a0,s1
    80000720:	00000097          	auipc	ra,0x0
    80000724:	f20080e7          	jalr	-224(ra) # 80000640 <kvmmap>
  kvmmap(kpgtbl, (uint64)etext, (uint64)etext, PHYSTOP-(uint64)etext, PTE_R | PTE_W);
    80000728:	46c5                	li	a3,17
    8000072a:	06ee                	sll	a3,a3,0x1b
    8000072c:	4719                	li	a4,6
    8000072e:	412686b3          	sub	a3,a3,s2
    80000732:	864a                	mv	a2,s2
    80000734:	85ca                	mv	a1,s2
    80000736:	8526                	mv	a0,s1
    80000738:	00000097          	auipc	ra,0x0
    8000073c:	f08080e7          	jalr	-248(ra) # 80000640 <kvmmap>
  kvmmap(kpgtbl, TRAMPOLINE, (uint64)trampoline, PGSIZE, PTE_R | PTE_X);
    80000740:	4729                	li	a4,10
    80000742:	6685                	lui	a3,0x1
    80000744:	0000a617          	auipc	a2,0xa
    80000748:	8bc60613          	add	a2,a2,-1860 # 8000a000 <_trampoline>
    8000074c:	040005b7          	lui	a1,0x4000
    80000750:	15fd                	add	a1,a1,-1 # 3ffffff <_entry-0x7c000001>
    80000752:	05b2                	sll	a1,a1,0xc
    80000754:	8526                	mv	a0,s1
    80000756:	00000097          	auipc	ra,0x0
    8000075a:	eea080e7          	jalr	-278(ra) # 80000640 <kvmmap>
  proc_mapstacks(kpgtbl);
    8000075e:	8526                	mv	a0,s1
    80000760:	00000097          	auipc	ra,0x0
    80000764:	67c080e7          	jalr	1660(ra) # 80000ddc <proc_mapstacks>
}
    80000768:	8526                	mv	a0,s1
    8000076a:	60e2                	ld	ra,24(sp)
    8000076c:	6442                	ld	s0,16(sp)
    8000076e:	64a2                	ld	s1,8(sp)
    80000770:	6902                	ld	s2,0(sp)
    80000772:	6105                	add	sp,sp,32
    80000774:	8082                	ret

0000000080000776 <kvminit>:
{
    80000776:	1141                	add	sp,sp,-16
    80000778:	e406                	sd	ra,8(sp)
    8000077a:	e022                	sd	s0,0(sp)
    8000077c:	0800                	add	s0,sp,16
  kernel_pagetable = kvmmake();
    8000077e:	00000097          	auipc	ra,0x0
    80000782:	ef2080e7          	jalr	-270(ra) # 80000670 <kvmmake>
    80000786:	0000c797          	auipc	a5,0xc
    8000078a:	88a7b123          	sd	a0,-1918(a5) # 8000c008 <kernel_pagetable>
}
    8000078e:	60a2                	ld	ra,8(sp)
    80000790:	6402                	ld	s0,0(sp)
    80000792:	0141                	add	sp,sp,16
    80000794:	8082                	ret

0000000080000796 <uvmunmap>:
// Remove npages of mappings starting from va. va must be
// page-aligned. The mappings must exist.
// Optionally free the physical memory.
void
uvmunmap(pagetable_t pagetable, uint64 va, uint64 npages, int do_free)
{
    80000796:	715d                	add	sp,sp,-80
    80000798:	e486                	sd	ra,72(sp)
    8000079a:	e0a2                	sd	s0,64(sp)
    8000079c:	0880                	add	s0,sp,80
  uint64 a;
  pte_t *pte;

  if((va % PGSIZE) != 0)
    8000079e:	03459793          	sll	a5,a1,0x34
    800007a2:	e39d                	bnez	a5,800007c8 <uvmunmap+0x32>
    800007a4:	f84a                	sd	s2,48(sp)
    800007a6:	f44e                	sd	s3,40(sp)
    800007a8:	f052                	sd	s4,32(sp)
    800007aa:	ec56                	sd	s5,24(sp)
    800007ac:	e85a                	sd	s6,16(sp)
    800007ae:	e45e                	sd	s7,8(sp)
    800007b0:	8a2a                	mv	s4,a0
    800007b2:	892e                	mv	s2,a1
    800007b4:	8ab6                	mv	s5,a3
    panic("uvmunmap: not aligned");

  for(a = va; a < va + npages*PGSIZE; a += PGSIZE){
    800007b6:	0632                	sll	a2,a2,0xc
    800007b8:	00b609b3          	add	s3,a2,a1
      panic("uvmunmap: walk");
    if((*pte & PTE_V) == 0) {
      printf("va=%p pte=%p\n", a, *pte);
      panic("uvmunmap: not mapped");
    }
    if(PTE_FLAGS(*pte) == PTE_V)
    800007bc:	4b85                	li	s7,1
  for(a = va; a < va + npages*PGSIZE; a += PGSIZE){
    800007be:	6b05                	lui	s6,0x1
    800007c0:	0b35f563          	bgeu	a1,s3,8000086a <uvmunmap+0xd4>
    800007c4:	fc26                	sd	s1,56(sp)
    800007c6:	a0b5                	j	80000832 <uvmunmap+0x9c>
    800007c8:	fc26                	sd	s1,56(sp)
    800007ca:	f84a                	sd	s2,48(sp)
    800007cc:	f44e                	sd	s3,40(sp)
    800007ce:	f052                	sd	s4,32(sp)
    800007d0:	ec56                	sd	s5,24(sp)
    800007d2:	e85a                	sd	s6,16(sp)
    800007d4:	e45e                	sd	s7,8(sp)
    panic("uvmunmap: not aligned");
    800007d6:	0000b517          	auipc	a0,0xb
    800007da:	8b250513          	add	a0,a0,-1870 # 8000b088 <etext+0x88>
    800007de:	00009097          	auipc	ra,0x9
    800007e2:	afa080e7          	jalr	-1286(ra) # 800092d8 <panic>
      panic("uvmunmap: walk");
    800007e6:	0000b517          	auipc	a0,0xb
    800007ea:	8ba50513          	add	a0,a0,-1862 # 8000b0a0 <etext+0xa0>
    800007ee:	00009097          	auipc	ra,0x9
    800007f2:	aea080e7          	jalr	-1302(ra) # 800092d8 <panic>
      printf("va=%p pte=%p\n", a, *pte);
    800007f6:	85ca                	mv	a1,s2
    800007f8:	0000b517          	auipc	a0,0xb
    800007fc:	8b850513          	add	a0,a0,-1864 # 8000b0b0 <etext+0xb0>
    80000800:	00009097          	auipc	ra,0x9
    80000804:	b22080e7          	jalr	-1246(ra) # 80009322 <printf>
      panic("uvmunmap: not mapped");
    80000808:	0000b517          	auipc	a0,0xb
    8000080c:	8b850513          	add	a0,a0,-1864 # 8000b0c0 <etext+0xc0>
    80000810:	00009097          	auipc	ra,0x9
    80000814:	ac8080e7          	jalr	-1336(ra) # 800092d8 <panic>
      panic("uvmunmap: not a leaf");
    80000818:	0000b517          	auipc	a0,0xb
    8000081c:	8c050513          	add	a0,a0,-1856 # 8000b0d8 <etext+0xd8>
    80000820:	00009097          	auipc	ra,0x9
    80000824:	ab8080e7          	jalr	-1352(ra) # 800092d8 <panic>
    if(do_free){
      uint64 pa = PTE2PA(*pte);
      kfree((void*)pa);
    }
    *pte = 0;
    80000828:	0004b023          	sd	zero,0(s1)
  for(a = va; a < va + npages*PGSIZE; a += PGSIZE){
    8000082c:	995a                	add	s2,s2,s6
    8000082e:	03397d63          	bgeu	s2,s3,80000868 <uvmunmap+0xd2>
    if((pte = walk(pagetable, a, 0)) == 0)
    80000832:	4601                	li	a2,0
    80000834:	85ca                	mv	a1,s2
    80000836:	8552                	mv	a0,s4
    80000838:	00000097          	auipc	ra,0x0
    8000083c:	c92080e7          	jalr	-878(ra) # 800004ca <walk>
    80000840:	84aa                	mv	s1,a0
    80000842:	d155                	beqz	a0,800007e6 <uvmunmap+0x50>
    if((*pte & PTE_V) == 0) {
    80000844:	6110                	ld	a2,0(a0)
    80000846:	00167793          	and	a5,a2,1
    8000084a:	d7d5                	beqz	a5,800007f6 <uvmunmap+0x60>
    if(PTE_FLAGS(*pte) == PTE_V)
    8000084c:	3ff67793          	and	a5,a2,1023
    80000850:	fd7784e3          	beq	a5,s7,80000818 <uvmunmap+0x82>
    if(do_free){
    80000854:	fc0a8ae3          	beqz	s5,80000828 <uvmunmap+0x92>
      uint64 pa = PTE2PA(*pte);
    80000858:	8229                	srl	a2,a2,0xa
      kfree((void*)pa);
    8000085a:	00c61513          	sll	a0,a2,0xc
    8000085e:	fffff097          	auipc	ra,0xfffff
    80000862:	7be080e7          	jalr	1982(ra) # 8000001c <kfree>
    80000866:	b7c9                	j	80000828 <uvmunmap+0x92>
    80000868:	74e2                	ld	s1,56(sp)
    8000086a:	7942                	ld	s2,48(sp)
    8000086c:	79a2                	ld	s3,40(sp)
    8000086e:	7a02                	ld	s4,32(sp)
    80000870:	6ae2                	ld	s5,24(sp)
    80000872:	6b42                	ld	s6,16(sp)
    80000874:	6ba2                	ld	s7,8(sp)
  }
}
    80000876:	60a6                	ld	ra,72(sp)
    80000878:	6406                	ld	s0,64(sp)
    8000087a:	6161                	add	sp,sp,80
    8000087c:	8082                	ret

000000008000087e <uvmcreate>:

// create an empty user page table.
// returns 0 if out of memory.
pagetable_t
uvmcreate()
{
    8000087e:	1101                	add	sp,sp,-32
    80000880:	ec06                	sd	ra,24(sp)
    80000882:	e822                	sd	s0,16(sp)
    80000884:	e426                	sd	s1,8(sp)
    80000886:	1000                	add	s0,sp,32
  pagetable_t pagetable;
  pagetable = (pagetable_t) kalloc();
    80000888:	00000097          	auipc	ra,0x0
    8000088c:	892080e7          	jalr	-1902(ra) # 8000011a <kalloc>
    80000890:	84aa                	mv	s1,a0
  if(pagetable == 0)
    80000892:	c519                	beqz	a0,800008a0 <uvmcreate+0x22>
    return 0;
  memset(pagetable, 0, PGSIZE);
    80000894:	6605                	lui	a2,0x1
    80000896:	4581                	li	a1,0
    80000898:	00000097          	auipc	ra,0x0
    8000089c:	8e2080e7          	jalr	-1822(ra) # 8000017a <memset>
  return pagetable;
}
    800008a0:	8526                	mv	a0,s1
    800008a2:	60e2                	ld	ra,24(sp)
    800008a4:	6442                	ld	s0,16(sp)
    800008a6:	64a2                	ld	s1,8(sp)
    800008a8:	6105                	add	sp,sp,32
    800008aa:	8082                	ret

00000000800008ac <uvminit>:
// Load the user initcode into address 0 of pagetable,
// for the very first process.
// sz must be less than a page.
void
uvminit(pagetable_t pagetable, uchar *src, uint sz)
{
    800008ac:	7179                	add	sp,sp,-48
    800008ae:	f406                	sd	ra,40(sp)
    800008b0:	f022                	sd	s0,32(sp)
    800008b2:	ec26                	sd	s1,24(sp)
    800008b4:	e84a                	sd	s2,16(sp)
    800008b6:	e44e                	sd	s3,8(sp)
    800008b8:	e052                	sd	s4,0(sp)
    800008ba:	1800                	add	s0,sp,48
  char *mem;

  if(sz >= PGSIZE)
    800008bc:	6785                	lui	a5,0x1
    800008be:	04f67863          	bgeu	a2,a5,8000090e <uvminit+0x62>
    800008c2:	8a2a                	mv	s4,a0
    800008c4:	89ae                	mv	s3,a1
    800008c6:	84b2                	mv	s1,a2
    panic("inituvm: more than a page");
  mem = kalloc();
    800008c8:	00000097          	auipc	ra,0x0
    800008cc:	852080e7          	jalr	-1966(ra) # 8000011a <kalloc>
    800008d0:	892a                	mv	s2,a0
  memset(mem, 0, PGSIZE);
    800008d2:	6605                	lui	a2,0x1
    800008d4:	4581                	li	a1,0
    800008d6:	00000097          	auipc	ra,0x0
    800008da:	8a4080e7          	jalr	-1884(ra) # 8000017a <memset>
  mappages(pagetable, 0, PGSIZE, (uint64)mem, PTE_W|PTE_R|PTE_X|PTE_U);
    800008de:	4779                	li	a4,30
    800008e0:	86ca                	mv	a3,s2
    800008e2:	6605                	lui	a2,0x1
    800008e4:	4581                	li	a1,0
    800008e6:	8552                	mv	a0,s4
    800008e8:	00000097          	auipc	ra,0x0
    800008ec:	cca080e7          	jalr	-822(ra) # 800005b2 <mappages>
  memmove(mem, src, sz);
    800008f0:	8626                	mv	a2,s1
    800008f2:	85ce                	mv	a1,s3
    800008f4:	854a                	mv	a0,s2
    800008f6:	00000097          	auipc	ra,0x0
    800008fa:	8e0080e7          	jalr	-1824(ra) # 800001d6 <memmove>
}
    800008fe:	70a2                	ld	ra,40(sp)
    80000900:	7402                	ld	s0,32(sp)
    80000902:	64e2                	ld	s1,24(sp)
    80000904:	6942                	ld	s2,16(sp)
    80000906:	69a2                	ld	s3,8(sp)
    80000908:	6a02                	ld	s4,0(sp)
    8000090a:	6145                	add	sp,sp,48
    8000090c:	8082                	ret
    panic("inituvm: more than a page");
    8000090e:	0000a517          	auipc	a0,0xa
    80000912:	7e250513          	add	a0,a0,2018 # 8000b0f0 <etext+0xf0>
    80000916:	00009097          	auipc	ra,0x9
    8000091a:	9c2080e7          	jalr	-1598(ra) # 800092d8 <panic>

000000008000091e <uvmdealloc>:
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
uint64
uvmdealloc(pagetable_t pagetable, uint64 oldsz, uint64 newsz)
{
    8000091e:	1101                	add	sp,sp,-32
    80000920:	ec06                	sd	ra,24(sp)
    80000922:	e822                	sd	s0,16(sp)
    80000924:	e426                	sd	s1,8(sp)
    80000926:	1000                	add	s0,sp,32
  if(newsz >= oldsz)
    return oldsz;
    80000928:	84ae                	mv	s1,a1
  if(newsz >= oldsz)
    8000092a:	00b67d63          	bgeu	a2,a1,80000944 <uvmdealloc+0x26>
    8000092e:	84b2                	mv	s1,a2

  if(PGROUNDUP(newsz) < PGROUNDUP(oldsz)){
    80000930:	6785                	lui	a5,0x1
    80000932:	17fd                	add	a5,a5,-1 # fff <_entry-0x7ffff001>
    80000934:	00f60733          	add	a4,a2,a5
    80000938:	76fd                	lui	a3,0xfffff
    8000093a:	8f75                	and	a4,a4,a3
    8000093c:	97ae                	add	a5,a5,a1
    8000093e:	8ff5                	and	a5,a5,a3
    80000940:	00f76863          	bltu	a4,a5,80000950 <uvmdealloc+0x32>
    int npages = (PGROUNDUP(oldsz) - PGROUNDUP(newsz)) / PGSIZE;
    uvmunmap(pagetable, PGROUNDUP(newsz), npages, 1);
  }

  return newsz;
}
    80000944:	8526                	mv	a0,s1
    80000946:	60e2                	ld	ra,24(sp)
    80000948:	6442                	ld	s0,16(sp)
    8000094a:	64a2                	ld	s1,8(sp)
    8000094c:	6105                	add	sp,sp,32
    8000094e:	8082                	ret
    int npages = (PGROUNDUP(oldsz) - PGROUNDUP(newsz)) / PGSIZE;
    80000950:	8f99                	sub	a5,a5,a4
    80000952:	83b1                	srl	a5,a5,0xc
    uvmunmap(pagetable, PGROUNDUP(newsz), npages, 1);
    80000954:	4685                	li	a3,1
    80000956:	0007861b          	sext.w	a2,a5
    8000095a:	85ba                	mv	a1,a4
    8000095c:	00000097          	auipc	ra,0x0
    80000960:	e3a080e7          	jalr	-454(ra) # 80000796 <uvmunmap>
    80000964:	b7c5                	j	80000944 <uvmdealloc+0x26>

0000000080000966 <uvmalloc>:
  if(newsz < oldsz)
    80000966:	0ab66563          	bltu	a2,a1,80000a10 <uvmalloc+0xaa>
{
    8000096a:	7139                	add	sp,sp,-64
    8000096c:	fc06                	sd	ra,56(sp)
    8000096e:	f822                	sd	s0,48(sp)
    80000970:	ec4e                	sd	s3,24(sp)
    80000972:	e852                	sd	s4,16(sp)
    80000974:	e456                	sd	s5,8(sp)
    80000976:	0080                	add	s0,sp,64
    80000978:	8aaa                	mv	s5,a0
    8000097a:	8a32                	mv	s4,a2
  oldsz = PGROUNDUP(oldsz);
    8000097c:	6785                	lui	a5,0x1
    8000097e:	17fd                	add	a5,a5,-1 # fff <_entry-0x7ffff001>
    80000980:	95be                	add	a1,a1,a5
    80000982:	77fd                	lui	a5,0xfffff
    80000984:	00f5f9b3          	and	s3,a1,a5
  for(a = oldsz; a < newsz; a += PGSIZE){
    80000988:	08c9f663          	bgeu	s3,a2,80000a14 <uvmalloc+0xae>
    8000098c:	f426                	sd	s1,40(sp)
    8000098e:	f04a                	sd	s2,32(sp)
    80000990:	894e                	mv	s2,s3
    mem = kalloc();
    80000992:	fffff097          	auipc	ra,0xfffff
    80000996:	788080e7          	jalr	1928(ra) # 8000011a <kalloc>
    8000099a:	84aa                	mv	s1,a0
    if(mem == 0){
    8000099c:	c90d                	beqz	a0,800009ce <uvmalloc+0x68>
    memset(mem, 0, PGSIZE);
    8000099e:	6605                	lui	a2,0x1
    800009a0:	4581                	li	a1,0
    800009a2:	fffff097          	auipc	ra,0xfffff
    800009a6:	7d8080e7          	jalr	2008(ra) # 8000017a <memset>
    if(mappages(pagetable, a, PGSIZE, (uint64)mem, PTE_W|PTE_X|PTE_R|PTE_U) != 0){
    800009aa:	4779                	li	a4,30
    800009ac:	86a6                	mv	a3,s1
    800009ae:	6605                	lui	a2,0x1
    800009b0:	85ca                	mv	a1,s2
    800009b2:	8556                	mv	a0,s5
    800009b4:	00000097          	auipc	ra,0x0
    800009b8:	bfe080e7          	jalr	-1026(ra) # 800005b2 <mappages>
    800009bc:	e915                	bnez	a0,800009f0 <uvmalloc+0x8a>
  for(a = oldsz; a < newsz; a += PGSIZE){
    800009be:	6785                	lui	a5,0x1
    800009c0:	993e                	add	s2,s2,a5
    800009c2:	fd4968e3          	bltu	s2,s4,80000992 <uvmalloc+0x2c>
  return newsz;
    800009c6:	8552                	mv	a0,s4
    800009c8:	74a2                	ld	s1,40(sp)
    800009ca:	7902                	ld	s2,32(sp)
    800009cc:	a819                	j	800009e2 <uvmalloc+0x7c>
      uvmdealloc(pagetable, a, oldsz);
    800009ce:	864e                	mv	a2,s3
    800009d0:	85ca                	mv	a1,s2
    800009d2:	8556                	mv	a0,s5
    800009d4:	00000097          	auipc	ra,0x0
    800009d8:	f4a080e7          	jalr	-182(ra) # 8000091e <uvmdealloc>
      return 0;
    800009dc:	4501                	li	a0,0
    800009de:	74a2                	ld	s1,40(sp)
    800009e0:	7902                	ld	s2,32(sp)
}
    800009e2:	70e2                	ld	ra,56(sp)
    800009e4:	7442                	ld	s0,48(sp)
    800009e6:	69e2                	ld	s3,24(sp)
    800009e8:	6a42                	ld	s4,16(sp)
    800009ea:	6aa2                	ld	s5,8(sp)
    800009ec:	6121                	add	sp,sp,64
    800009ee:	8082                	ret
      kfree(mem);
    800009f0:	8526                	mv	a0,s1
    800009f2:	fffff097          	auipc	ra,0xfffff
    800009f6:	62a080e7          	jalr	1578(ra) # 8000001c <kfree>
      uvmdealloc(pagetable, a, oldsz);
    800009fa:	864e                	mv	a2,s3
    800009fc:	85ca                	mv	a1,s2
    800009fe:	8556                	mv	a0,s5
    80000a00:	00000097          	auipc	ra,0x0
    80000a04:	f1e080e7          	jalr	-226(ra) # 8000091e <uvmdealloc>
      return 0;
    80000a08:	4501                	li	a0,0
    80000a0a:	74a2                	ld	s1,40(sp)
    80000a0c:	7902                	ld	s2,32(sp)
    80000a0e:	bfd1                	j	800009e2 <uvmalloc+0x7c>
    return oldsz;
    80000a10:	852e                	mv	a0,a1
}
    80000a12:	8082                	ret
  return newsz;
    80000a14:	8532                	mv	a0,a2
    80000a16:	b7f1                	j	800009e2 <uvmalloc+0x7c>

0000000080000a18 <freewalk>:

// Recursively free page-table pages.
// All leaf mappings must already have been removed.
void
freewalk(pagetable_t pagetable)
{
    80000a18:	7179                	add	sp,sp,-48
    80000a1a:	f406                	sd	ra,40(sp)
    80000a1c:	f022                	sd	s0,32(sp)
    80000a1e:	ec26                	sd	s1,24(sp)
    80000a20:	e84a                	sd	s2,16(sp)
    80000a22:	e44e                	sd	s3,8(sp)
    80000a24:	e052                	sd	s4,0(sp)
    80000a26:	1800                	add	s0,sp,48
    80000a28:	8a2a                	mv	s4,a0
  // there are 2^9 = 512 PTEs in a page table.
  for(int i = 0; i < 512; i++){
    80000a2a:	84aa                	mv	s1,a0
    80000a2c:	6905                	lui	s2,0x1
    80000a2e:	992a                	add	s2,s2,a0
    pte_t pte = pagetable[i];
    if((pte & PTE_V) && (pte & (PTE_R|PTE_W|PTE_X)) == 0){
    80000a30:	4985                	li	s3,1
    80000a32:	a829                	j	80000a4c <freewalk+0x34>
      // this PTE points to a lower-level page table.
      uint64 child = PTE2PA(pte);
    80000a34:	83a9                	srl	a5,a5,0xa
      freewalk((pagetable_t)child);
    80000a36:	00c79513          	sll	a0,a5,0xc
    80000a3a:	00000097          	auipc	ra,0x0
    80000a3e:	fde080e7          	jalr	-34(ra) # 80000a18 <freewalk>
      pagetable[i] = 0;
    80000a42:	0004b023          	sd	zero,0(s1)
  for(int i = 0; i < 512; i++){
    80000a46:	04a1                	add	s1,s1,8
    80000a48:	03248163          	beq	s1,s2,80000a6a <freewalk+0x52>
    pte_t pte = pagetable[i];
    80000a4c:	609c                	ld	a5,0(s1)
    if((pte & PTE_V) && (pte & (PTE_R|PTE_W|PTE_X)) == 0){
    80000a4e:	00f7f713          	and	a4,a5,15
    80000a52:	ff3701e3          	beq	a4,s3,80000a34 <freewalk+0x1c>
    } else if(pte & PTE_V){
    80000a56:	8b85                	and	a5,a5,1
    80000a58:	d7fd                	beqz	a5,80000a46 <freewalk+0x2e>
      panic("freewalk: leaf");
    80000a5a:	0000a517          	auipc	a0,0xa
    80000a5e:	6b650513          	add	a0,a0,1718 # 8000b110 <etext+0x110>
    80000a62:	00009097          	auipc	ra,0x9
    80000a66:	876080e7          	jalr	-1930(ra) # 800092d8 <panic>
    }
  }
  kfree((void*)pagetable);
    80000a6a:	8552                	mv	a0,s4
    80000a6c:	fffff097          	auipc	ra,0xfffff
    80000a70:	5b0080e7          	jalr	1456(ra) # 8000001c <kfree>
}
    80000a74:	70a2                	ld	ra,40(sp)
    80000a76:	7402                	ld	s0,32(sp)
    80000a78:	64e2                	ld	s1,24(sp)
    80000a7a:	6942                	ld	s2,16(sp)
    80000a7c:	69a2                	ld	s3,8(sp)
    80000a7e:	6a02                	ld	s4,0(sp)
    80000a80:	6145                	add	sp,sp,48
    80000a82:	8082                	ret

0000000080000a84 <uvmfree>:

// Free user memory pages,
// then free page-table pages.
void
uvmfree(pagetable_t pagetable, uint64 sz)
{
    80000a84:	1101                	add	sp,sp,-32
    80000a86:	ec06                	sd	ra,24(sp)
    80000a88:	e822                	sd	s0,16(sp)
    80000a8a:	e426                	sd	s1,8(sp)
    80000a8c:	1000                	add	s0,sp,32
    80000a8e:	84aa                	mv	s1,a0
  if(sz > 0)
    80000a90:	e999                	bnez	a1,80000aa6 <uvmfree+0x22>
    uvmunmap(pagetable, 0, PGROUNDUP(sz)/PGSIZE, 1);
  freewalk(pagetable);
    80000a92:	8526                	mv	a0,s1
    80000a94:	00000097          	auipc	ra,0x0
    80000a98:	f84080e7          	jalr	-124(ra) # 80000a18 <freewalk>
}
    80000a9c:	60e2                	ld	ra,24(sp)
    80000a9e:	6442                	ld	s0,16(sp)
    80000aa0:	64a2                	ld	s1,8(sp)
    80000aa2:	6105                	add	sp,sp,32
    80000aa4:	8082                	ret
    uvmunmap(pagetable, 0, PGROUNDUP(sz)/PGSIZE, 1);
    80000aa6:	6785                	lui	a5,0x1
    80000aa8:	17fd                	add	a5,a5,-1 # fff <_entry-0x7ffff001>
    80000aaa:	95be                	add	a1,a1,a5
    80000aac:	4685                	li	a3,1
    80000aae:	00c5d613          	srl	a2,a1,0xc
    80000ab2:	4581                	li	a1,0
    80000ab4:	00000097          	auipc	ra,0x0
    80000ab8:	ce2080e7          	jalr	-798(ra) # 80000796 <uvmunmap>
    80000abc:	bfd9                	j	80000a92 <uvmfree+0xe>

0000000080000abe <uvmcopy>:
  pte_t *pte;
  uint64 pa, i;
  uint flags;
  char *mem;

  for(i = 0; i < sz; i += PGSIZE){
    80000abe:	c679                	beqz	a2,80000b8c <uvmcopy+0xce>
{
    80000ac0:	715d                	add	sp,sp,-80
    80000ac2:	e486                	sd	ra,72(sp)
    80000ac4:	e0a2                	sd	s0,64(sp)
    80000ac6:	fc26                	sd	s1,56(sp)
    80000ac8:	f84a                	sd	s2,48(sp)
    80000aca:	f44e                	sd	s3,40(sp)
    80000acc:	f052                	sd	s4,32(sp)
    80000ace:	ec56                	sd	s5,24(sp)
    80000ad0:	e85a                	sd	s6,16(sp)
    80000ad2:	e45e                	sd	s7,8(sp)
    80000ad4:	0880                	add	s0,sp,80
    80000ad6:	8b2a                	mv	s6,a0
    80000ad8:	8aae                	mv	s5,a1
    80000ada:	8a32                	mv	s4,a2
  for(i = 0; i < sz; i += PGSIZE){
    80000adc:	4981                	li	s3,0
    if((pte = walk(old, i, 0)) == 0)
    80000ade:	4601                	li	a2,0
    80000ae0:	85ce                	mv	a1,s3
    80000ae2:	855a                	mv	a0,s6
    80000ae4:	00000097          	auipc	ra,0x0
    80000ae8:	9e6080e7          	jalr	-1562(ra) # 800004ca <walk>
    80000aec:	c531                	beqz	a0,80000b38 <uvmcopy+0x7a>
      panic("uvmcopy: pte should exist");
    if((*pte & PTE_V) == 0)
    80000aee:	6118                	ld	a4,0(a0)
    80000af0:	00177793          	and	a5,a4,1
    80000af4:	cbb1                	beqz	a5,80000b48 <uvmcopy+0x8a>
      panic("uvmcopy: page not present");
    pa = PTE2PA(*pte);
    80000af6:	00a75593          	srl	a1,a4,0xa
    80000afa:	00c59b93          	sll	s7,a1,0xc
    flags = PTE_FLAGS(*pte);
    80000afe:	3ff77493          	and	s1,a4,1023
    if((mem = kalloc()) == 0)
    80000b02:	fffff097          	auipc	ra,0xfffff
    80000b06:	618080e7          	jalr	1560(ra) # 8000011a <kalloc>
    80000b0a:	892a                	mv	s2,a0
    80000b0c:	c939                	beqz	a0,80000b62 <uvmcopy+0xa4>
      goto err;
    memmove(mem, (char*)pa, PGSIZE);
    80000b0e:	6605                	lui	a2,0x1
    80000b10:	85de                	mv	a1,s7
    80000b12:	fffff097          	auipc	ra,0xfffff
    80000b16:	6c4080e7          	jalr	1732(ra) # 800001d6 <memmove>
    if(mappages(new, i, PGSIZE, (uint64)mem, flags) != 0){
    80000b1a:	8726                	mv	a4,s1
    80000b1c:	86ca                	mv	a3,s2
    80000b1e:	6605                	lui	a2,0x1
    80000b20:	85ce                	mv	a1,s3
    80000b22:	8556                	mv	a0,s5
    80000b24:	00000097          	auipc	ra,0x0
    80000b28:	a8e080e7          	jalr	-1394(ra) # 800005b2 <mappages>
    80000b2c:	e515                	bnez	a0,80000b58 <uvmcopy+0x9a>
  for(i = 0; i < sz; i += PGSIZE){
    80000b2e:	6785                	lui	a5,0x1
    80000b30:	99be                	add	s3,s3,a5
    80000b32:	fb49e6e3          	bltu	s3,s4,80000ade <uvmcopy+0x20>
    80000b36:	a081                	j	80000b76 <uvmcopy+0xb8>
      panic("uvmcopy: pte should exist");
    80000b38:	0000a517          	auipc	a0,0xa
    80000b3c:	5e850513          	add	a0,a0,1512 # 8000b120 <etext+0x120>
    80000b40:	00008097          	auipc	ra,0x8
    80000b44:	798080e7          	jalr	1944(ra) # 800092d8 <panic>
      panic("uvmcopy: page not present");
    80000b48:	0000a517          	auipc	a0,0xa
    80000b4c:	5f850513          	add	a0,a0,1528 # 8000b140 <etext+0x140>
    80000b50:	00008097          	auipc	ra,0x8
    80000b54:	788080e7          	jalr	1928(ra) # 800092d8 <panic>
      kfree(mem);
    80000b58:	854a                	mv	a0,s2
    80000b5a:	fffff097          	auipc	ra,0xfffff
    80000b5e:	4c2080e7          	jalr	1218(ra) # 8000001c <kfree>
    }
  }
  return 0;

 err:
  uvmunmap(new, 0, i / PGSIZE, 1);
    80000b62:	4685                	li	a3,1
    80000b64:	00c9d613          	srl	a2,s3,0xc
    80000b68:	4581                	li	a1,0
    80000b6a:	8556                	mv	a0,s5
    80000b6c:	00000097          	auipc	ra,0x0
    80000b70:	c2a080e7          	jalr	-982(ra) # 80000796 <uvmunmap>
  return -1;
    80000b74:	557d                	li	a0,-1
}
    80000b76:	60a6                	ld	ra,72(sp)
    80000b78:	6406                	ld	s0,64(sp)
    80000b7a:	74e2                	ld	s1,56(sp)
    80000b7c:	7942                	ld	s2,48(sp)
    80000b7e:	79a2                	ld	s3,40(sp)
    80000b80:	7a02                	ld	s4,32(sp)
    80000b82:	6ae2                	ld	s5,24(sp)
    80000b84:	6b42                	ld	s6,16(sp)
    80000b86:	6ba2                	ld	s7,8(sp)
    80000b88:	6161                	add	sp,sp,80
    80000b8a:	8082                	ret
  return 0;
    80000b8c:	4501                	li	a0,0
}
    80000b8e:	8082                	ret

0000000080000b90 <uvmclear>:

// mark a PTE invalid for user access.
// used by exec for the user stack guard page.
void
uvmclear(pagetable_t pagetable, uint64 va)
{
    80000b90:	1141                	add	sp,sp,-16
    80000b92:	e406                	sd	ra,8(sp)
    80000b94:	e022                	sd	s0,0(sp)
    80000b96:	0800                	add	s0,sp,16
  pte_t *pte;
  
  pte = walk(pagetable, va, 0);
    80000b98:	4601                	li	a2,0
    80000b9a:	00000097          	auipc	ra,0x0
    80000b9e:	930080e7          	jalr	-1744(ra) # 800004ca <walk>
  if(pte == 0)
    80000ba2:	c901                	beqz	a0,80000bb2 <uvmclear+0x22>
    panic("uvmclear");
  *pte &= ~PTE_U;
    80000ba4:	611c                	ld	a5,0(a0)
    80000ba6:	9bbd                	and	a5,a5,-17
    80000ba8:	e11c                	sd	a5,0(a0)
}
    80000baa:	60a2                	ld	ra,8(sp)
    80000bac:	6402                	ld	s0,0(sp)
    80000bae:	0141                	add	sp,sp,16
    80000bb0:	8082                	ret
    panic("uvmclear");
    80000bb2:	0000a517          	auipc	a0,0xa
    80000bb6:	5ae50513          	add	a0,a0,1454 # 8000b160 <etext+0x160>
    80000bba:	00008097          	auipc	ra,0x8
    80000bbe:	71e080e7          	jalr	1822(ra) # 800092d8 <panic>

0000000080000bc2 <copyout>:
int
copyout(pagetable_t pagetable, uint64 dstva, char *src, uint64 len)
{
  uint64 n, va0, pa0;

  while(len > 0){
    80000bc2:	c6bd                	beqz	a3,80000c30 <copyout+0x6e>
{
    80000bc4:	715d                	add	sp,sp,-80
    80000bc6:	e486                	sd	ra,72(sp)
    80000bc8:	e0a2                	sd	s0,64(sp)
    80000bca:	fc26                	sd	s1,56(sp)
    80000bcc:	f84a                	sd	s2,48(sp)
    80000bce:	f44e                	sd	s3,40(sp)
    80000bd0:	f052                	sd	s4,32(sp)
    80000bd2:	ec56                	sd	s5,24(sp)
    80000bd4:	e85a                	sd	s6,16(sp)
    80000bd6:	e45e                	sd	s7,8(sp)
    80000bd8:	e062                	sd	s8,0(sp)
    80000bda:	0880                	add	s0,sp,80
    80000bdc:	8b2a                	mv	s6,a0
    80000bde:	8c2e                	mv	s8,a1
    80000be0:	8a32                	mv	s4,a2
    80000be2:	89b6                	mv	s3,a3
    va0 = PGROUNDDOWN(dstva);
    80000be4:	7bfd                	lui	s7,0xfffff
    pa0 = walkaddr(pagetable, va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (dstva - va0);
    80000be6:	6a85                	lui	s5,0x1
    80000be8:	a015                	j	80000c0c <copyout+0x4a>
    if(n > len)
      n = len;
    memmove((void *)(pa0 + (dstva - va0)), src, n);
    80000bea:	9562                	add	a0,a0,s8
    80000bec:	0004861b          	sext.w	a2,s1
    80000bf0:	85d2                	mv	a1,s4
    80000bf2:	41250533          	sub	a0,a0,s2
    80000bf6:	fffff097          	auipc	ra,0xfffff
    80000bfa:	5e0080e7          	jalr	1504(ra) # 800001d6 <memmove>

    len -= n;
    80000bfe:	409989b3          	sub	s3,s3,s1
    src += n;
    80000c02:	9a26                	add	s4,s4,s1
    dstva = va0 + PGSIZE;
    80000c04:	01590c33          	add	s8,s2,s5
  while(len > 0){
    80000c08:	02098263          	beqz	s3,80000c2c <copyout+0x6a>
    va0 = PGROUNDDOWN(dstva);
    80000c0c:	017c7933          	and	s2,s8,s7
    pa0 = walkaddr(pagetable, va0);
    80000c10:	85ca                	mv	a1,s2
    80000c12:	855a                	mv	a0,s6
    80000c14:	00000097          	auipc	ra,0x0
    80000c18:	95c080e7          	jalr	-1700(ra) # 80000570 <walkaddr>
    if(pa0 == 0)
    80000c1c:	cd01                	beqz	a0,80000c34 <copyout+0x72>
    n = PGSIZE - (dstva - va0);
    80000c1e:	418904b3          	sub	s1,s2,s8
    80000c22:	94d6                	add	s1,s1,s5
    if(n > len)
    80000c24:	fc99f3e3          	bgeu	s3,s1,80000bea <copyout+0x28>
    80000c28:	84ce                	mv	s1,s3
    80000c2a:	b7c1                	j	80000bea <copyout+0x28>
  }
  return 0;
    80000c2c:	4501                	li	a0,0
    80000c2e:	a021                	j	80000c36 <copyout+0x74>
    80000c30:	4501                	li	a0,0
}
    80000c32:	8082                	ret
      return -1;
    80000c34:	557d                	li	a0,-1
}
    80000c36:	60a6                	ld	ra,72(sp)
    80000c38:	6406                	ld	s0,64(sp)
    80000c3a:	74e2                	ld	s1,56(sp)
    80000c3c:	7942                	ld	s2,48(sp)
    80000c3e:	79a2                	ld	s3,40(sp)
    80000c40:	7a02                	ld	s4,32(sp)
    80000c42:	6ae2                	ld	s5,24(sp)
    80000c44:	6b42                	ld	s6,16(sp)
    80000c46:	6ba2                	ld	s7,8(sp)
    80000c48:	6c02                	ld	s8,0(sp)
    80000c4a:	6161                	add	sp,sp,80
    80000c4c:	8082                	ret

0000000080000c4e <copyin>:
int
copyin(pagetable_t pagetable, char *dst, uint64 srcva, uint64 len)
{
  uint64 n, va0, pa0;
  
  while(len > 0){
    80000c4e:	caa5                	beqz	a3,80000cbe <copyin+0x70>
{
    80000c50:	715d                	add	sp,sp,-80
    80000c52:	e486                	sd	ra,72(sp)
    80000c54:	e0a2                	sd	s0,64(sp)
    80000c56:	fc26                	sd	s1,56(sp)
    80000c58:	f84a                	sd	s2,48(sp)
    80000c5a:	f44e                	sd	s3,40(sp)
    80000c5c:	f052                	sd	s4,32(sp)
    80000c5e:	ec56                	sd	s5,24(sp)
    80000c60:	e85a                	sd	s6,16(sp)
    80000c62:	e45e                	sd	s7,8(sp)
    80000c64:	e062                	sd	s8,0(sp)
    80000c66:	0880                	add	s0,sp,80
    80000c68:	8b2a                	mv	s6,a0
    80000c6a:	8a2e                	mv	s4,a1
    80000c6c:	8c32                	mv	s8,a2
    80000c6e:	89b6                	mv	s3,a3
    va0 = PGROUNDDOWN(srcva);
    80000c70:	7bfd                	lui	s7,0xfffff
    pa0 = walkaddr(pagetable, va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (srcva - va0);
    80000c72:	6a85                	lui	s5,0x1
    80000c74:	a01d                	j	80000c9a <copyin+0x4c>
    if(n > len)
      n = len;
    memmove(dst, (void *)(pa0 + (srcva - va0)), n);
    80000c76:	018505b3          	add	a1,a0,s8
    80000c7a:	0004861b          	sext.w	a2,s1
    80000c7e:	412585b3          	sub	a1,a1,s2
    80000c82:	8552                	mv	a0,s4
    80000c84:	fffff097          	auipc	ra,0xfffff
    80000c88:	552080e7          	jalr	1362(ra) # 800001d6 <memmove>

    len -= n;
    80000c8c:	409989b3          	sub	s3,s3,s1
    dst += n;
    80000c90:	9a26                	add	s4,s4,s1
    srcva = va0 + PGSIZE;
    80000c92:	01590c33          	add	s8,s2,s5
  while(len > 0){
    80000c96:	02098263          	beqz	s3,80000cba <copyin+0x6c>
    va0 = PGROUNDDOWN(srcva);
    80000c9a:	017c7933          	and	s2,s8,s7
    pa0 = walkaddr(pagetable, va0);
    80000c9e:	85ca                	mv	a1,s2
    80000ca0:	855a                	mv	a0,s6
    80000ca2:	00000097          	auipc	ra,0x0
    80000ca6:	8ce080e7          	jalr	-1842(ra) # 80000570 <walkaddr>
    if(pa0 == 0)
    80000caa:	cd01                	beqz	a0,80000cc2 <copyin+0x74>
    n = PGSIZE - (srcva - va0);
    80000cac:	418904b3          	sub	s1,s2,s8
    80000cb0:	94d6                	add	s1,s1,s5
    if(n > len)
    80000cb2:	fc99f2e3          	bgeu	s3,s1,80000c76 <copyin+0x28>
    80000cb6:	84ce                	mv	s1,s3
    80000cb8:	bf7d                	j	80000c76 <copyin+0x28>
  }
  return 0;
    80000cba:	4501                	li	a0,0
    80000cbc:	a021                	j	80000cc4 <copyin+0x76>
    80000cbe:	4501                	li	a0,0
}
    80000cc0:	8082                	ret
      return -1;
    80000cc2:	557d                	li	a0,-1
}
    80000cc4:	60a6                	ld	ra,72(sp)
    80000cc6:	6406                	ld	s0,64(sp)
    80000cc8:	74e2                	ld	s1,56(sp)
    80000cca:	7942                	ld	s2,48(sp)
    80000ccc:	79a2                	ld	s3,40(sp)
    80000cce:	7a02                	ld	s4,32(sp)
    80000cd0:	6ae2                	ld	s5,24(sp)
    80000cd2:	6b42                	ld	s6,16(sp)
    80000cd4:	6ba2                	ld	s7,8(sp)
    80000cd6:	6c02                	ld	s8,0(sp)
    80000cd8:	6161                	add	sp,sp,80
    80000cda:	8082                	ret

0000000080000cdc <copyinstr>:
copyinstr(pagetable_t pagetable, char *dst, uint64 srcva, uint64 max)
{
  uint64 n, va0, pa0;
  int got_null = 0;

  while(got_null == 0 && max > 0){
    80000cdc:	cacd                	beqz	a3,80000d8e <copyinstr+0xb2>
{
    80000cde:	715d                	add	sp,sp,-80
    80000ce0:	e486                	sd	ra,72(sp)
    80000ce2:	e0a2                	sd	s0,64(sp)
    80000ce4:	fc26                	sd	s1,56(sp)
    80000ce6:	f84a                	sd	s2,48(sp)
    80000ce8:	f44e                	sd	s3,40(sp)
    80000cea:	f052                	sd	s4,32(sp)
    80000cec:	ec56                	sd	s5,24(sp)
    80000cee:	e85a                	sd	s6,16(sp)
    80000cf0:	e45e                	sd	s7,8(sp)
    80000cf2:	0880                	add	s0,sp,80
    80000cf4:	8a2a                	mv	s4,a0
    80000cf6:	8b2e                	mv	s6,a1
    80000cf8:	8bb2                	mv	s7,a2
    80000cfa:	8936                	mv	s2,a3
    va0 = PGROUNDDOWN(srcva);
    80000cfc:	7afd                	lui	s5,0xfffff
    pa0 = walkaddr(pagetable, va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (srcva - va0);
    80000cfe:	6985                	lui	s3,0x1
    80000d00:	a825                	j	80000d38 <copyinstr+0x5c>
      n = max;

    char *p = (char *) (pa0 + (srcva - va0));
    while(n > 0){
      if(*p == '\0'){
        *dst = '\0';
    80000d02:	00078023          	sb	zero,0(a5) # 1000 <_entry-0x7ffff000>
    80000d06:	4785                	li	a5,1
      dst++;
    }

    srcva = va0 + PGSIZE;
  }
  if(got_null){
    80000d08:	37fd                	addw	a5,a5,-1
    80000d0a:	0007851b          	sext.w	a0,a5
    return 0;
  } else {
    return -1;
  }
}
    80000d0e:	60a6                	ld	ra,72(sp)
    80000d10:	6406                	ld	s0,64(sp)
    80000d12:	74e2                	ld	s1,56(sp)
    80000d14:	7942                	ld	s2,48(sp)
    80000d16:	79a2                	ld	s3,40(sp)
    80000d18:	7a02                	ld	s4,32(sp)
    80000d1a:	6ae2                	ld	s5,24(sp)
    80000d1c:	6b42                	ld	s6,16(sp)
    80000d1e:	6ba2                	ld	s7,8(sp)
    80000d20:	6161                	add	sp,sp,80
    80000d22:	8082                	ret
    80000d24:	fff90713          	add	a4,s2,-1 # fff <_entry-0x7ffff001>
    80000d28:	9742                	add	a4,a4,a6
      --max;
    80000d2a:	40b70933          	sub	s2,a4,a1
    srcva = va0 + PGSIZE;
    80000d2e:	01348bb3          	add	s7,s1,s3
  while(got_null == 0 && max > 0){
    80000d32:	04e58663          	beq	a1,a4,80000d7e <copyinstr+0xa2>
{
    80000d36:	8b3e                	mv	s6,a5
    va0 = PGROUNDDOWN(srcva);
    80000d38:	015bf4b3          	and	s1,s7,s5
    pa0 = walkaddr(pagetable, va0);
    80000d3c:	85a6                	mv	a1,s1
    80000d3e:	8552                	mv	a0,s4
    80000d40:	00000097          	auipc	ra,0x0
    80000d44:	830080e7          	jalr	-2000(ra) # 80000570 <walkaddr>
    if(pa0 == 0)
    80000d48:	cd0d                	beqz	a0,80000d82 <copyinstr+0xa6>
    n = PGSIZE - (srcva - va0);
    80000d4a:	417486b3          	sub	a3,s1,s7
    80000d4e:	96ce                	add	a3,a3,s3
    if(n > max)
    80000d50:	00d97363          	bgeu	s2,a3,80000d56 <copyinstr+0x7a>
    80000d54:	86ca                	mv	a3,s2
    char *p = (char *) (pa0 + (srcva - va0));
    80000d56:	955e                	add	a0,a0,s7
    80000d58:	8d05                	sub	a0,a0,s1
    while(n > 0){
    80000d5a:	c695                	beqz	a3,80000d86 <copyinstr+0xaa>
    80000d5c:	87da                	mv	a5,s6
    80000d5e:	885a                	mv	a6,s6
      if(*p == '\0'){
    80000d60:	41650633          	sub	a2,a0,s6
    while(n > 0){
    80000d64:	96da                	add	a3,a3,s6
    80000d66:	85be                	mv	a1,a5
      if(*p == '\0'){
    80000d68:	00f60733          	add	a4,a2,a5
    80000d6c:	00074703          	lbu	a4,0(a4) # fffffffffffff000 <end+0xffffffff7ffb7a30>
    80000d70:	db49                	beqz	a4,80000d02 <copyinstr+0x26>
        *dst = *p;
    80000d72:	00e78023          	sb	a4,0(a5)
      dst++;
    80000d76:	0785                	add	a5,a5,1
    while(n > 0){
    80000d78:	fed797e3          	bne	a5,a3,80000d66 <copyinstr+0x8a>
    80000d7c:	b765                	j	80000d24 <copyinstr+0x48>
    80000d7e:	4781                	li	a5,0
    80000d80:	b761                	j	80000d08 <copyinstr+0x2c>
      return -1;
    80000d82:	557d                	li	a0,-1
    80000d84:	b769                	j	80000d0e <copyinstr+0x32>
    srcva = va0 + PGSIZE;
    80000d86:	6b85                	lui	s7,0x1
    80000d88:	9ba6                	add	s7,s7,s1
    80000d8a:	87da                	mv	a5,s6
    80000d8c:	b76d                	j	80000d36 <copyinstr+0x5a>
  int got_null = 0;
    80000d8e:	4781                	li	a5,0
  if(got_null){
    80000d90:	37fd                	addw	a5,a5,-1
    80000d92:	0007851b          	sext.w	a0,a5
}
    80000d96:	8082                	ret

0000000080000d98 <wakeup1>:

// Wake up p if it is sleeping in wait(); used by exit().
// Caller must hold p->lock.
static void
wakeup1(struct proc *p)
{
    80000d98:	1101                	add	sp,sp,-32
    80000d9a:	ec06                	sd	ra,24(sp)
    80000d9c:	e822                	sd	s0,16(sp)
    80000d9e:	e426                	sd	s1,8(sp)
    80000da0:	1000                	add	s0,sp,32
    80000da2:	84aa                	mv	s1,a0
  if(!holding(&p->lock))
    80000da4:	00009097          	auipc	ra,0x9
    80000da8:	a54080e7          	jalr	-1452(ra) # 800097f8 <holding>
    80000dac:	c909                	beqz	a0,80000dbe <wakeup1+0x26>
    panic("wakeup1");
  if(p->chan == p && p->state == SLEEPING) {
    80000dae:	749c                	ld	a5,40(s1)
    80000db0:	00978f63          	beq	a5,s1,80000dce <wakeup1+0x36>
    p->state = RUNNABLE;
  }
}
    80000db4:	60e2                	ld	ra,24(sp)
    80000db6:	6442                	ld	s0,16(sp)
    80000db8:	64a2                	ld	s1,8(sp)
    80000dba:	6105                	add	sp,sp,32
    80000dbc:	8082                	ret
    panic("wakeup1");
    80000dbe:	0000a517          	auipc	a0,0xa
    80000dc2:	3b250513          	add	a0,a0,946 # 8000b170 <etext+0x170>
    80000dc6:	00008097          	auipc	ra,0x8
    80000dca:	512080e7          	jalr	1298(ra) # 800092d8 <panic>
  if(p->chan == p && p->state == SLEEPING) {
    80000dce:	4c98                	lw	a4,24(s1)
    80000dd0:	4785                	li	a5,1
    80000dd2:	fef711e3          	bne	a4,a5,80000db4 <wakeup1+0x1c>
    p->state = RUNNABLE;
    80000dd6:	4789                	li	a5,2
    80000dd8:	cc9c                	sw	a5,24(s1)
}
    80000dda:	bfe9                	j	80000db4 <wakeup1+0x1c>

0000000080000ddc <proc_mapstacks>:
proc_mapstacks(pagetable_t kpgtbl) {
    80000ddc:	7139                	add	sp,sp,-64
    80000dde:	fc06                	sd	ra,56(sp)
    80000de0:	f822                	sd	s0,48(sp)
    80000de2:	f426                	sd	s1,40(sp)
    80000de4:	f04a                	sd	s2,32(sp)
    80000de6:	ec4e                	sd	s3,24(sp)
    80000de8:	e852                	sd	s4,16(sp)
    80000dea:	e456                	sd	s5,8(sp)
    80000dec:	e05a                	sd	s6,0(sp)
    80000dee:	0080                	add	s0,sp,64
    80000df0:	8a2a                	mv	s4,a0
  for(p = proc; p < &proc[NPROC]; p++) {
    80000df2:	0000b497          	auipc	s1,0xb
    80000df6:	69648493          	add	s1,s1,1686 # 8000c488 <proc>
    uint64 va = KSTACK((int) (p - proc));
    80000dfa:	8b26                	mv	s6,s1
    80000dfc:	fa540937          	lui	s2,0xfa540
    80000e00:	a9590913          	add	s2,s2,-1387 # fffffffffa53fa95 <end+0xffffffff7a4f84c5>
    80000e04:	094a                	sll	s2,s2,0x12
    80000e06:	a9590913          	add	s2,s2,-1387
    80000e0a:	094a                	sll	s2,s2,0x12
    80000e0c:	a9590913          	add	s2,s2,-1387
    80000e10:	040009b7          	lui	s3,0x4000
    80000e14:	19fd                	add	s3,s3,-1 # 3ffffff <_entry-0x7c000001>
    80000e16:	09b2                	sll	s3,s3,0xc
  for(p = proc; p < &proc[NPROC]; p++) {
    80000e18:	00023a97          	auipc	s5,0x23
    80000e1c:	070a8a93          	add	s5,s5,112 # 80023e88 <tickslock>
    char *pa = kalloc();
    80000e20:	fffff097          	auipc	ra,0xfffff
    80000e24:	2fa080e7          	jalr	762(ra) # 8000011a <kalloc>
    80000e28:	862a                	mv	a2,a0
    if(pa == 0)
    80000e2a:	c121                	beqz	a0,80000e6a <proc_mapstacks+0x8e>
    uint64 va = KSTACK((int) (p - proc));
    80000e2c:	416485b3          	sub	a1,s1,s6
    80000e30:	858d                	sra	a1,a1,0x3
    80000e32:	032585b3          	mul	a1,a1,s2
    80000e36:	2585                	addw	a1,a1,1
    80000e38:	00d5959b          	sllw	a1,a1,0xd
    kvmmap(kpgtbl, va, (uint64)pa, PGSIZE, PTE_R | PTE_W);
    80000e3c:	4719                	li	a4,6
    80000e3e:	6685                	lui	a3,0x1
    80000e40:	40b985b3          	sub	a1,s3,a1
    80000e44:	8552                	mv	a0,s4
    80000e46:	fffff097          	auipc	ra,0xfffff
    80000e4a:	7fa080e7          	jalr	2042(ra) # 80000640 <kvmmap>
  for(p = proc; p < &proc[NPROC]; p++) {
    80000e4e:	5e848493          	add	s1,s1,1512
    80000e52:	fd5497e3          	bne	s1,s5,80000e20 <proc_mapstacks+0x44>
}
    80000e56:	70e2                	ld	ra,56(sp)
    80000e58:	7442                	ld	s0,48(sp)
    80000e5a:	74a2                	ld	s1,40(sp)
    80000e5c:	7902                	ld	s2,32(sp)
    80000e5e:	69e2                	ld	s3,24(sp)
    80000e60:	6a42                	ld	s4,16(sp)
    80000e62:	6aa2                	ld	s5,8(sp)
    80000e64:	6b02                	ld	s6,0(sp)
    80000e66:	6121                	add	sp,sp,64
    80000e68:	8082                	ret
      panic("kalloc");
    80000e6a:	0000a517          	auipc	a0,0xa
    80000e6e:	30e50513          	add	a0,a0,782 # 8000b178 <etext+0x178>
    80000e72:	00008097          	auipc	ra,0x8
    80000e76:	466080e7          	jalr	1126(ra) # 800092d8 <panic>

0000000080000e7a <procinit>:
{
    80000e7a:	7139                	add	sp,sp,-64
    80000e7c:	fc06                	sd	ra,56(sp)
    80000e7e:	f822                	sd	s0,48(sp)
    80000e80:	f426                	sd	s1,40(sp)
    80000e82:	f04a                	sd	s2,32(sp)
    80000e84:	ec4e                	sd	s3,24(sp)
    80000e86:	e852                	sd	s4,16(sp)
    80000e88:	e456                	sd	s5,8(sp)
    80000e8a:	e05a                	sd	s6,0(sp)
    80000e8c:	0080                	add	s0,sp,64
  initlock(&pid_lock, "nextpid");
    80000e8e:	0000a597          	auipc	a1,0xa
    80000e92:	2f258593          	add	a1,a1,754 # 8000b180 <etext+0x180>
    80000e96:	0000b517          	auipc	a0,0xb
    80000e9a:	1da50513          	add	a0,a0,474 # 8000c070 <pid_lock>
    80000e9e:	00009097          	auipc	ra,0x9
    80000ea2:	944080e7          	jalr	-1724(ra) # 800097e2 <initlock>
  for(p = proc; p < &proc[NPROC]; p++) {
    80000ea6:	0000b497          	auipc	s1,0xb
    80000eaa:	5e248493          	add	s1,s1,1506 # 8000c488 <proc>
      initlock(&p->lock, "proc");
    80000eae:	0000ab17          	auipc	s6,0xa
    80000eb2:	2dab0b13          	add	s6,s6,730 # 8000b188 <etext+0x188>
      p->kstack = KSTACK((int) (p - proc));
    80000eb6:	8aa6                	mv	s5,s1
    80000eb8:	fa540937          	lui	s2,0xfa540
    80000ebc:	a9590913          	add	s2,s2,-1387 # fffffffffa53fa95 <end+0xffffffff7a4f84c5>
    80000ec0:	094a                	sll	s2,s2,0x12
    80000ec2:	a9590913          	add	s2,s2,-1387
    80000ec6:	094a                	sll	s2,s2,0x12
    80000ec8:	a9590913          	add	s2,s2,-1387
    80000ecc:	040009b7          	lui	s3,0x4000
    80000ed0:	19fd                	add	s3,s3,-1 # 3ffffff <_entry-0x7c000001>
    80000ed2:	09b2                	sll	s3,s3,0xc
  for(p = proc; p < &proc[NPROC]; p++) {
    80000ed4:	00023a17          	auipc	s4,0x23
    80000ed8:	fb4a0a13          	add	s4,s4,-76 # 80023e88 <tickslock>
      initlock(&p->lock, "proc");
    80000edc:	85da                	mv	a1,s6
    80000ede:	8526                	mv	a0,s1
    80000ee0:	00009097          	auipc	ra,0x9
    80000ee4:	902080e7          	jalr	-1790(ra) # 800097e2 <initlock>
      p->kstack = KSTACK((int) (p - proc));
    80000ee8:	415487b3          	sub	a5,s1,s5
    80000eec:	878d                	sra	a5,a5,0x3
    80000eee:	032787b3          	mul	a5,a5,s2
    80000ef2:	2785                	addw	a5,a5,1
    80000ef4:	00d7979b          	sllw	a5,a5,0xd
    80000ef8:	40f987b3          	sub	a5,s3,a5
    80000efc:	e0bc                	sd	a5,64(s1)
  for(p = proc; p < &proc[NPROC]; p++) {
    80000efe:	5e848493          	add	s1,s1,1512
    80000f02:	fd449de3          	bne	s1,s4,80000edc <procinit+0x62>
}
    80000f06:	70e2                	ld	ra,56(sp)
    80000f08:	7442                	ld	s0,48(sp)
    80000f0a:	74a2                	ld	s1,40(sp)
    80000f0c:	7902                	ld	s2,32(sp)
    80000f0e:	69e2                	ld	s3,24(sp)
    80000f10:	6a42                	ld	s4,16(sp)
    80000f12:	6aa2                	ld	s5,8(sp)
    80000f14:	6b02                	ld	s6,0(sp)
    80000f16:	6121                	add	sp,sp,64
    80000f18:	8082                	ret

0000000080000f1a <cpuid>:
{
    80000f1a:	1141                	add	sp,sp,-16
    80000f1c:	e422                	sd	s0,8(sp)
    80000f1e:	0800                	add	s0,sp,16
  asm volatile("mv %0, tp" : "=r" (x) );
    80000f20:	8512                	mv	a0,tp
}
    80000f22:	2501                	sext.w	a0,a0
    80000f24:	6422                	ld	s0,8(sp)
    80000f26:	0141                	add	sp,sp,16
    80000f28:	8082                	ret

0000000080000f2a <mycpu>:
mycpu(void) {
    80000f2a:	1141                	add	sp,sp,-16
    80000f2c:	e422                	sd	s0,8(sp)
    80000f2e:	0800                	add	s0,sp,16
    80000f30:	8792                	mv	a5,tp
  struct cpu *c = &cpus[id];
    80000f32:	2781                	sext.w	a5,a5
    80000f34:	079e                	sll	a5,a5,0x7
}
    80000f36:	0000b517          	auipc	a0,0xb
    80000f3a:	15250513          	add	a0,a0,338 # 8000c088 <cpus>
    80000f3e:	953e                	add	a0,a0,a5
    80000f40:	6422                	ld	s0,8(sp)
    80000f42:	0141                	add	sp,sp,16
    80000f44:	8082                	ret

0000000080000f46 <myproc>:
myproc(void) {
    80000f46:	1101                	add	sp,sp,-32
    80000f48:	ec06                	sd	ra,24(sp)
    80000f4a:	e822                	sd	s0,16(sp)
    80000f4c:	e426                	sd	s1,8(sp)
    80000f4e:	1000                	add	s0,sp,32
  push_off();
    80000f50:	00009097          	auipc	ra,0x9
    80000f54:	8d6080e7          	jalr	-1834(ra) # 80009826 <push_off>
    80000f58:	8792                	mv	a5,tp
  struct proc *p = c->proc;
    80000f5a:	2781                	sext.w	a5,a5
    80000f5c:	079e                	sll	a5,a5,0x7
    80000f5e:	0000b717          	auipc	a4,0xb
    80000f62:	11270713          	add	a4,a4,274 # 8000c070 <pid_lock>
    80000f66:	97ba                	add	a5,a5,a4
    80000f68:	6f84                	ld	s1,24(a5)
  pop_off();
    80000f6a:	00009097          	auipc	ra,0x9
    80000f6e:	96e080e7          	jalr	-1682(ra) # 800098d8 <pop_off>
}
    80000f72:	8526                	mv	a0,s1
    80000f74:	60e2                	ld	ra,24(sp)
    80000f76:	6442                	ld	s0,16(sp)
    80000f78:	64a2                	ld	s1,8(sp)
    80000f7a:	6105                	add	sp,sp,32
    80000f7c:	8082                	ret

0000000080000f7e <forkret>:
{
    80000f7e:	1141                	add	sp,sp,-16
    80000f80:	e406                	sd	ra,8(sp)
    80000f82:	e022                	sd	s0,0(sp)
    80000f84:	0800                	add	s0,sp,16
  release(&myproc()->lock);
    80000f86:	00000097          	auipc	ra,0x0
    80000f8a:	fc0080e7          	jalr	-64(ra) # 80000f46 <myproc>
    80000f8e:	00009097          	auipc	ra,0x9
    80000f92:	9aa080e7          	jalr	-1622(ra) # 80009938 <release>
  if (first) {
    80000f96:	0000b797          	auipc	a5,0xb
    80000f9a:	bba7a783          	lw	a5,-1094(a5) # 8000bb50 <first.1>
    80000f9e:	eb89                	bnez	a5,80000fb0 <forkret+0x32>
  usertrapret();
    80000fa0:	00001097          	auipc	ra,0x1
    80000fa4:	c1e080e7          	jalr	-994(ra) # 80001bbe <usertrapret>
}
    80000fa8:	60a2                	ld	ra,8(sp)
    80000faa:	6402                	ld	s0,0(sp)
    80000fac:	0141                	add	sp,sp,16
    80000fae:	8082                	ret
    first = 0;
    80000fb0:	0000b797          	auipc	a5,0xb
    80000fb4:	ba07a023          	sw	zero,-1120(a5) # 8000bb50 <first.1>
    fsinit(ROOTDEV);
    80000fb8:	4505                	li	a0,1
    80000fba:	00002097          	auipc	ra,0x2
    80000fbe:	99a080e7          	jalr	-1638(ra) # 80002954 <fsinit>
    80000fc2:	bff9                	j	80000fa0 <forkret+0x22>

0000000080000fc4 <allocpid>:
allocpid() {
    80000fc4:	1101                	add	sp,sp,-32
    80000fc6:	ec06                	sd	ra,24(sp)
    80000fc8:	e822                	sd	s0,16(sp)
    80000fca:	e426                	sd	s1,8(sp)
    80000fcc:	e04a                	sd	s2,0(sp)
    80000fce:	1000                	add	s0,sp,32
  acquire(&pid_lock);
    80000fd0:	0000b917          	auipc	s2,0xb
    80000fd4:	0a090913          	add	s2,s2,160 # 8000c070 <pid_lock>
    80000fd8:	854a                	mv	a0,s2
    80000fda:	00009097          	auipc	ra,0x9
    80000fde:	898080e7          	jalr	-1896(ra) # 80009872 <acquire>
  pid = nextpid;
    80000fe2:	0000b797          	auipc	a5,0xb
    80000fe6:	b7278793          	add	a5,a5,-1166 # 8000bb54 <nextpid>
    80000fea:	4384                	lw	s1,0(a5)
  nextpid = nextpid + 1;
    80000fec:	0014871b          	addw	a4,s1,1
    80000ff0:	c398                	sw	a4,0(a5)
  release(&pid_lock);
    80000ff2:	854a                	mv	a0,s2
    80000ff4:	00009097          	auipc	ra,0x9
    80000ff8:	944080e7          	jalr	-1724(ra) # 80009938 <release>
}
    80000ffc:	8526                	mv	a0,s1
    80000ffe:	60e2                	ld	ra,24(sp)
    80001000:	6442                	ld	s0,16(sp)
    80001002:	64a2                	ld	s1,8(sp)
    80001004:	6902                	ld	s2,0(sp)
    80001006:	6105                	add	sp,sp,32
    80001008:	8082                	ret

000000008000100a <proc_pagetable>:
{
    8000100a:	1101                	add	sp,sp,-32
    8000100c:	ec06                	sd	ra,24(sp)
    8000100e:	e822                	sd	s0,16(sp)
    80001010:	e426                	sd	s1,8(sp)
    80001012:	e04a                	sd	s2,0(sp)
    80001014:	1000                	add	s0,sp,32
    80001016:	892a                	mv	s2,a0
  pagetable = uvmcreate();
    80001018:	00000097          	auipc	ra,0x0
    8000101c:	866080e7          	jalr	-1946(ra) # 8000087e <uvmcreate>
    80001020:	84aa                	mv	s1,a0
  if(pagetable == 0)
    80001022:	c121                	beqz	a0,80001062 <proc_pagetable+0x58>
  if(mappages(pagetable, TRAMPOLINE, PGSIZE,
    80001024:	4729                	li	a4,10
    80001026:	00009697          	auipc	a3,0x9
    8000102a:	fda68693          	add	a3,a3,-38 # 8000a000 <_trampoline>
    8000102e:	6605                	lui	a2,0x1
    80001030:	040005b7          	lui	a1,0x4000
    80001034:	15fd                	add	a1,a1,-1 # 3ffffff <_entry-0x7c000001>
    80001036:	05b2                	sll	a1,a1,0xc
    80001038:	fffff097          	auipc	ra,0xfffff
    8000103c:	57a080e7          	jalr	1402(ra) # 800005b2 <mappages>
    80001040:	02054863          	bltz	a0,80001070 <proc_pagetable+0x66>
  if(mappages(pagetable, TRAPFRAME, PGSIZE,
    80001044:	4719                	li	a4,6
    80001046:	05893683          	ld	a3,88(s2)
    8000104a:	6605                	lui	a2,0x1
    8000104c:	020005b7          	lui	a1,0x2000
    80001050:	15fd                	add	a1,a1,-1 # 1ffffff <_entry-0x7e000001>
    80001052:	05b6                	sll	a1,a1,0xd
    80001054:	8526                	mv	a0,s1
    80001056:	fffff097          	auipc	ra,0xfffff
    8000105a:	55c080e7          	jalr	1372(ra) # 800005b2 <mappages>
    8000105e:	02054163          	bltz	a0,80001080 <proc_pagetable+0x76>
}
    80001062:	8526                	mv	a0,s1
    80001064:	60e2                	ld	ra,24(sp)
    80001066:	6442                	ld	s0,16(sp)
    80001068:	64a2                	ld	s1,8(sp)
    8000106a:	6902                	ld	s2,0(sp)
    8000106c:	6105                	add	sp,sp,32
    8000106e:	8082                	ret
    uvmfree(pagetable, 0);
    80001070:	4581                	li	a1,0
    80001072:	8526                	mv	a0,s1
    80001074:	00000097          	auipc	ra,0x0
    80001078:	a10080e7          	jalr	-1520(ra) # 80000a84 <uvmfree>
    return 0;
    8000107c:	4481                	li	s1,0
    8000107e:	b7d5                	j	80001062 <proc_pagetable+0x58>
    uvmunmap(pagetable, TRAMPOLINE, 1, 0);
    80001080:	4681                	li	a3,0
    80001082:	4605                	li	a2,1
    80001084:	040005b7          	lui	a1,0x4000
    80001088:	15fd                	add	a1,a1,-1 # 3ffffff <_entry-0x7c000001>
    8000108a:	05b2                	sll	a1,a1,0xc
    8000108c:	8526                	mv	a0,s1
    8000108e:	fffff097          	auipc	ra,0xfffff
    80001092:	708080e7          	jalr	1800(ra) # 80000796 <uvmunmap>
    uvmfree(pagetable, 0);
    80001096:	4581                	li	a1,0
    80001098:	8526                	mv	a0,s1
    8000109a:	00000097          	auipc	ra,0x0
    8000109e:	9ea080e7          	jalr	-1558(ra) # 80000a84 <uvmfree>
    return 0;
    800010a2:	4481                	li	s1,0
    800010a4:	bf7d                	j	80001062 <proc_pagetable+0x58>

00000000800010a6 <proc_freepagetable>:
{
    800010a6:	1101                	add	sp,sp,-32
    800010a8:	ec06                	sd	ra,24(sp)
    800010aa:	e822                	sd	s0,16(sp)
    800010ac:	e426                	sd	s1,8(sp)
    800010ae:	e04a                	sd	s2,0(sp)
    800010b0:	1000                	add	s0,sp,32
    800010b2:	84aa                	mv	s1,a0
    800010b4:	892e                	mv	s2,a1
  uvmunmap(pagetable, TRAMPOLINE, 1, 0);
    800010b6:	4681                	li	a3,0
    800010b8:	4605                	li	a2,1
    800010ba:	040005b7          	lui	a1,0x4000
    800010be:	15fd                	add	a1,a1,-1 # 3ffffff <_entry-0x7c000001>
    800010c0:	05b2                	sll	a1,a1,0xc
    800010c2:	fffff097          	auipc	ra,0xfffff
    800010c6:	6d4080e7          	jalr	1748(ra) # 80000796 <uvmunmap>
  uvmunmap(pagetable, TRAPFRAME, 1, 0);
    800010ca:	4681                	li	a3,0
    800010cc:	4605                	li	a2,1
    800010ce:	020005b7          	lui	a1,0x2000
    800010d2:	15fd                	add	a1,a1,-1 # 1ffffff <_entry-0x7e000001>
    800010d4:	05b6                	sll	a1,a1,0xd
    800010d6:	8526                	mv	a0,s1
    800010d8:	fffff097          	auipc	ra,0xfffff
    800010dc:	6be080e7          	jalr	1726(ra) # 80000796 <uvmunmap>
  uvmfree(pagetable, sz);
    800010e0:	85ca                	mv	a1,s2
    800010e2:	8526                	mv	a0,s1
    800010e4:	00000097          	auipc	ra,0x0
    800010e8:	9a0080e7          	jalr	-1632(ra) # 80000a84 <uvmfree>
}
    800010ec:	60e2                	ld	ra,24(sp)
    800010ee:	6442                	ld	s0,16(sp)
    800010f0:	64a2                	ld	s1,8(sp)
    800010f2:	6902                	ld	s2,0(sp)
    800010f4:	6105                	add	sp,sp,32
    800010f6:	8082                	ret

00000000800010f8 <freeproc>:
{
    800010f8:	1101                	add	sp,sp,-32
    800010fa:	ec06                	sd	ra,24(sp)
    800010fc:	e822                	sd	s0,16(sp)
    800010fe:	e426                	sd	s1,8(sp)
    80001100:	1000                	add	s0,sp,32
    80001102:	84aa                	mv	s1,a0
  if(p->trapframe)
    80001104:	6d28                	ld	a0,88(a0)
    80001106:	c509                	beqz	a0,80001110 <freeproc+0x18>
    kfree((void*)p->trapframe);
    80001108:	fffff097          	auipc	ra,0xfffff
    8000110c:	f14080e7          	jalr	-236(ra) # 8000001c <kfree>
  p->trapframe = 0;
    80001110:	0404bc23          	sd	zero,88(s1)
  if(p->pagetable)
    80001114:	68a8                	ld	a0,80(s1)
    80001116:	c511                	beqz	a0,80001122 <freeproc+0x2a>
    proc_freepagetable(p->pagetable, p->sz);
    80001118:	64ac                	ld	a1,72(s1)
    8000111a:	00000097          	auipc	ra,0x0
    8000111e:	f8c080e7          	jalr	-116(ra) # 800010a6 <proc_freepagetable>
  p->pagetable = 0;
    80001122:	0404b823          	sd	zero,80(s1)
  p->sz = 0;
    80001126:	0404b423          	sd	zero,72(s1)
  p->pid = 0;
    8000112a:	0204ac23          	sw	zero,56(s1)
  p->parent = 0;
    8000112e:	0204b023          	sd	zero,32(s1)
  p->name[0] = 0;
    80001132:	5c048c23          	sb	zero,1496(s1)
  p->chan = 0;
    80001136:	0204b423          	sd	zero,40(s1)
  p->killed = 0;
    8000113a:	0204a823          	sw	zero,48(s1)
  p->xstate = 0;
    8000113e:	0204aa23          	sw	zero,52(s1)
  p->state = UNUSED;
    80001142:	0004ac23          	sw	zero,24(s1)
}
    80001146:	60e2                	ld	ra,24(sp)
    80001148:	6442                	ld	s0,16(sp)
    8000114a:	64a2                	ld	s1,8(sp)
    8000114c:	6105                	add	sp,sp,32
    8000114e:	8082                	ret

0000000080001150 <allocproc>:
{
    80001150:	1101                	add	sp,sp,-32
    80001152:	ec06                	sd	ra,24(sp)
    80001154:	e822                	sd	s0,16(sp)
    80001156:	e426                	sd	s1,8(sp)
    80001158:	e04a                	sd	s2,0(sp)
    8000115a:	1000                	add	s0,sp,32
  for(p = proc; p < &proc[NPROC]; p++) {
    8000115c:	0000b497          	auipc	s1,0xb
    80001160:	32c48493          	add	s1,s1,812 # 8000c488 <proc>
    80001164:	00023917          	auipc	s2,0x23
    80001168:	d2490913          	add	s2,s2,-732 # 80023e88 <tickslock>
    acquire(&p->lock);
    8000116c:	8526                	mv	a0,s1
    8000116e:	00008097          	auipc	ra,0x8
    80001172:	704080e7          	jalr	1796(ra) # 80009872 <acquire>
    if(p->state == UNUSED) {
    80001176:	4c9c                	lw	a5,24(s1)
    80001178:	cf81                	beqz	a5,80001190 <allocproc+0x40>
      release(&p->lock);
    8000117a:	8526                	mv	a0,s1
    8000117c:	00008097          	auipc	ra,0x8
    80001180:	7bc080e7          	jalr	1980(ra) # 80009938 <release>
  for(p = proc; p < &proc[NPROC]; p++) {
    80001184:	5e848493          	add	s1,s1,1512
    80001188:	ff2492e3          	bne	s1,s2,8000116c <allocproc+0x1c>
  return 0;
    8000118c:	4481                	li	s1,0
    8000118e:	a0b9                	j	800011dc <allocproc+0x8c>
  p->pid = allocpid();
    80001190:	00000097          	auipc	ra,0x0
    80001194:	e34080e7          	jalr	-460(ra) # 80000fc4 <allocpid>
    80001198:	dc88                	sw	a0,56(s1)
  if((p->trapframe = (struct trapframe *)kalloc()) == 0){
    8000119a:	fffff097          	auipc	ra,0xfffff
    8000119e:	f80080e7          	jalr	-128(ra) # 8000011a <kalloc>
    800011a2:	892a                	mv	s2,a0
    800011a4:	eca8                	sd	a0,88(s1)
    800011a6:	c131                	beqz	a0,800011ea <allocproc+0x9a>
  p->pagetable = proc_pagetable(p);
    800011a8:	8526                	mv	a0,s1
    800011aa:	00000097          	auipc	ra,0x0
    800011ae:	e60080e7          	jalr	-416(ra) # 8000100a <proc_pagetable>
    800011b2:	892a                	mv	s2,a0
    800011b4:	e8a8                	sd	a0,80(s1)
  if(p->pagetable == 0){
    800011b6:	c129                	beqz	a0,800011f8 <allocproc+0xa8>
  memset(&p->context, 0, sizeof(p->context));
    800011b8:	07000613          	li	a2,112
    800011bc:	4581                	li	a1,0
    800011be:	06048513          	add	a0,s1,96
    800011c2:	fffff097          	auipc	ra,0xfffff
    800011c6:	fb8080e7          	jalr	-72(ra) # 8000017a <memset>
  p->context.ra = (uint64)forkret;
    800011ca:	00000797          	auipc	a5,0x0
    800011ce:	db478793          	add	a5,a5,-588 # 80000f7e <forkret>
    800011d2:	f0bc                	sd	a5,96(s1)
  p->context.sp = p->kstack + PGSIZE;
    800011d4:	60bc                	ld	a5,64(s1)
    800011d6:	6705                	lui	a4,0x1
    800011d8:	97ba                	add	a5,a5,a4
    800011da:	f4bc                	sd	a5,104(s1)
}
    800011dc:	8526                	mv	a0,s1
    800011de:	60e2                	ld	ra,24(sp)
    800011e0:	6442                	ld	s0,16(sp)
    800011e2:	64a2                	ld	s1,8(sp)
    800011e4:	6902                	ld	s2,0(sp)
    800011e6:	6105                	add	sp,sp,32
    800011e8:	8082                	ret
    release(&p->lock);
    800011ea:	8526                	mv	a0,s1
    800011ec:	00008097          	auipc	ra,0x8
    800011f0:	74c080e7          	jalr	1868(ra) # 80009938 <release>
    return 0;
    800011f4:	84ca                	mv	s1,s2
    800011f6:	b7dd                	j	800011dc <allocproc+0x8c>
    freeproc(p);
    800011f8:	8526                	mv	a0,s1
    800011fa:	00000097          	auipc	ra,0x0
    800011fe:	efe080e7          	jalr	-258(ra) # 800010f8 <freeproc>
    release(&p->lock);
    80001202:	8526                	mv	a0,s1
    80001204:	00008097          	auipc	ra,0x8
    80001208:	734080e7          	jalr	1844(ra) # 80009938 <release>
    return 0;
    8000120c:	84ca                	mv	s1,s2
    8000120e:	b7f9                	j	800011dc <allocproc+0x8c>

0000000080001210 <userinit>:
{
    80001210:	1101                	add	sp,sp,-32
    80001212:	ec06                	sd	ra,24(sp)
    80001214:	e822                	sd	s0,16(sp)
    80001216:	e426                	sd	s1,8(sp)
    80001218:	1000                	add	s0,sp,32
  p = allocproc();
    8000121a:	00000097          	auipc	ra,0x0
    8000121e:	f36080e7          	jalr	-202(ra) # 80001150 <allocproc>
    80001222:	84aa                	mv	s1,a0
  initproc = p;
    80001224:	0000b797          	auipc	a5,0xb
    80001228:	dea7b623          	sd	a0,-532(a5) # 8000c010 <initproc>
  uvminit(p->pagetable, initcode, sizeof(initcode));
    8000122c:	03400613          	li	a2,52
    80001230:	0000b597          	auipc	a1,0xb
    80001234:	94058593          	add	a1,a1,-1728 # 8000bb70 <initcode>
    80001238:	6928                	ld	a0,80(a0)
    8000123a:	fffff097          	auipc	ra,0xfffff
    8000123e:	672080e7          	jalr	1650(ra) # 800008ac <uvminit>
  p->sz = PGSIZE;
    80001242:	6785                	lui	a5,0x1
    80001244:	e4bc                	sd	a5,72(s1)
  p->trapframe->epc = 0;      // user program counter
    80001246:	6cb8                	ld	a4,88(s1)
    80001248:	00073c23          	sd	zero,24(a4) # 1018 <_entry-0x7fffefe8>
  p->trapframe->sp = PGSIZE;  // user stack pointer
    8000124c:	6cb8                	ld	a4,88(s1)
    8000124e:	fb1c                	sd	a5,48(a4)
  safestrcpy(p->name, "initcode", sizeof(p->name));
    80001250:	4641                	li	a2,16
    80001252:	0000a597          	auipc	a1,0xa
    80001256:	f3e58593          	add	a1,a1,-194 # 8000b190 <etext+0x190>
    8000125a:	5d848513          	add	a0,s1,1496
    8000125e:	fffff097          	auipc	ra,0xfffff
    80001262:	066080e7          	jalr	102(ra) # 800002c4 <safestrcpy>
  p->cwd = namei("/");
    80001266:	0000a517          	auipc	a0,0xa
    8000126a:	f3a50513          	add	a0,a0,-198 # 8000b1a0 <etext+0x1a0>
    8000126e:	00002097          	auipc	ra,0x2
    80001272:	12c080e7          	jalr	300(ra) # 8000339a <namei>
    80001276:	5ca4b823          	sd	a0,1488(s1)
  p->state = RUNNABLE;
    8000127a:	4789                	li	a5,2
    8000127c:	cc9c                	sw	a5,24(s1)
  release(&p->lock);
    8000127e:	8526                	mv	a0,s1
    80001280:	00008097          	auipc	ra,0x8
    80001284:	6b8080e7          	jalr	1720(ra) # 80009938 <release>
}
    80001288:	60e2                	ld	ra,24(sp)
    8000128a:	6442                	ld	s0,16(sp)
    8000128c:	64a2                	ld	s1,8(sp)
    8000128e:	6105                	add	sp,sp,32
    80001290:	8082                	ret

0000000080001292 <growproc>:
{
    80001292:	1101                	add	sp,sp,-32
    80001294:	ec06                	sd	ra,24(sp)
    80001296:	e822                	sd	s0,16(sp)
    80001298:	e426                	sd	s1,8(sp)
    8000129a:	e04a                	sd	s2,0(sp)
    8000129c:	1000                	add	s0,sp,32
    8000129e:	84aa                	mv	s1,a0
  struct proc *p = myproc();
    800012a0:	00000097          	auipc	ra,0x0
    800012a4:	ca6080e7          	jalr	-858(ra) # 80000f46 <myproc>
    800012a8:	892a                	mv	s2,a0
  sz = p->sz;
    800012aa:	652c                	ld	a1,72(a0)
    800012ac:	0005879b          	sext.w	a5,a1
  if(n > 0){
    800012b0:	00904f63          	bgtz	s1,800012ce <growproc+0x3c>
  } else if(n < 0){
    800012b4:	0204cd63          	bltz	s1,800012ee <growproc+0x5c>
  p->sz = sz;
    800012b8:	1782                	sll	a5,a5,0x20
    800012ba:	9381                	srl	a5,a5,0x20
    800012bc:	04f93423          	sd	a5,72(s2)
  return 0;
    800012c0:	4501                	li	a0,0
}
    800012c2:	60e2                	ld	ra,24(sp)
    800012c4:	6442                	ld	s0,16(sp)
    800012c6:	64a2                	ld	s1,8(sp)
    800012c8:	6902                	ld	s2,0(sp)
    800012ca:	6105                	add	sp,sp,32
    800012cc:	8082                	ret
    if((sz = uvmalloc(p->pagetable, sz, sz + n)) == 0) {
    800012ce:	00f4863b          	addw	a2,s1,a5
    800012d2:	1602                	sll	a2,a2,0x20
    800012d4:	9201                	srl	a2,a2,0x20
    800012d6:	1582                	sll	a1,a1,0x20
    800012d8:	9181                	srl	a1,a1,0x20
    800012da:	6928                	ld	a0,80(a0)
    800012dc:	fffff097          	auipc	ra,0xfffff
    800012e0:	68a080e7          	jalr	1674(ra) # 80000966 <uvmalloc>
    800012e4:	0005079b          	sext.w	a5,a0
    800012e8:	fbe1                	bnez	a5,800012b8 <growproc+0x26>
      return -1;
    800012ea:	557d                	li	a0,-1
    800012ec:	bfd9                	j	800012c2 <growproc+0x30>
    sz = uvmdealloc(p->pagetable, sz, sz + n);
    800012ee:	00f4863b          	addw	a2,s1,a5
    800012f2:	1602                	sll	a2,a2,0x20
    800012f4:	9201                	srl	a2,a2,0x20
    800012f6:	1582                	sll	a1,a1,0x20
    800012f8:	9181                	srl	a1,a1,0x20
    800012fa:	6928                	ld	a0,80(a0)
    800012fc:	fffff097          	auipc	ra,0xfffff
    80001300:	622080e7          	jalr	1570(ra) # 8000091e <uvmdealloc>
    80001304:	0005079b          	sext.w	a5,a0
    80001308:	bf45                	j	800012b8 <growproc+0x26>

000000008000130a <fork>:
{
    8000130a:	7139                	add	sp,sp,-64
    8000130c:	fc06                	sd	ra,56(sp)
    8000130e:	f822                	sd	s0,48(sp)
    80001310:	f426                	sd	s1,40(sp)
    80001312:	e456                	sd	s5,8(sp)
    80001314:	0080                	add	s0,sp,64
  struct proc *p = myproc();
    80001316:	00000097          	auipc	ra,0x0
    8000131a:	c30080e7          	jalr	-976(ra) # 80000f46 <myproc>
    8000131e:	8aaa                	mv	s5,a0
  if((np = allocproc()) == 0){
    80001320:	00000097          	auipc	ra,0x0
    80001324:	e30080e7          	jalr	-464(ra) # 80001150 <allocproc>
    80001328:	c57d                	beqz	a0,80001416 <fork+0x10c>
    8000132a:	e852                	sd	s4,16(sp)
    8000132c:	8a2a                	mv	s4,a0
  if(uvmcopy(p->pagetable, np->pagetable, p->sz) < 0){
    8000132e:	048ab603          	ld	a2,72(s5)
    80001332:	692c                	ld	a1,80(a0)
    80001334:	050ab503          	ld	a0,80(s5)
    80001338:	fffff097          	auipc	ra,0xfffff
    8000133c:	786080e7          	jalr	1926(ra) # 80000abe <uvmcopy>
    80001340:	04054c63          	bltz	a0,80001398 <fork+0x8e>
    80001344:	f04a                	sd	s2,32(sp)
    80001346:	ec4e                	sd	s3,24(sp)
  np->sz = p->sz;
    80001348:	048ab783          	ld	a5,72(s5)
    8000134c:	04fa3423          	sd	a5,72(s4)
  np->parent = p;
    80001350:	035a3023          	sd	s5,32(s4)
  *(np->trapframe) = *(p->trapframe);
    80001354:	058ab683          	ld	a3,88(s5)
    80001358:	87b6                	mv	a5,a3
    8000135a:	058a3703          	ld	a4,88(s4)
    8000135e:	12068693          	add	a3,a3,288
    80001362:	0007b803          	ld	a6,0(a5) # 1000 <_entry-0x7ffff000>
    80001366:	6788                	ld	a0,8(a5)
    80001368:	6b8c                	ld	a1,16(a5)
    8000136a:	6f90                	ld	a2,24(a5)
    8000136c:	01073023          	sd	a6,0(a4)
    80001370:	e708                	sd	a0,8(a4)
    80001372:	eb0c                	sd	a1,16(a4)
    80001374:	ef10                	sd	a2,24(a4)
    80001376:	02078793          	add	a5,a5,32
    8000137a:	02070713          	add	a4,a4,32
    8000137e:	fed792e3          	bne	a5,a3,80001362 <fork+0x58>
  np->trapframe->a0 = 0;
    80001382:	058a3783          	ld	a5,88(s4)
    80001386:	0607b823          	sd	zero,112(a5)
  for(i = 0; i < NOFILE; i++)
    8000138a:	0d0a8493          	add	s1,s5,208
    8000138e:	0d0a0913          	add	s2,s4,208
    80001392:	5d0a8993          	add	s3,s5,1488
    80001396:	a805                	j	800013c6 <fork+0xbc>
    freeproc(np);
    80001398:	8552                	mv	a0,s4
    8000139a:	00000097          	auipc	ra,0x0
    8000139e:	d5e080e7          	jalr	-674(ra) # 800010f8 <freeproc>
    release(&np->lock);
    800013a2:	8552                	mv	a0,s4
    800013a4:	00008097          	auipc	ra,0x8
    800013a8:	594080e7          	jalr	1428(ra) # 80009938 <release>
    return -1;
    800013ac:	54fd                	li	s1,-1
    800013ae:	6a42                	ld	s4,16(sp)
    800013b0:	a8a1                	j	80001408 <fork+0xfe>
      np->ofile[i] = filedup(p->ofile[i]);
    800013b2:	00002097          	auipc	ra,0x2
    800013b6:	668080e7          	jalr	1640(ra) # 80003a1a <filedup>
    800013ba:	00a93023          	sd	a0,0(s2)
  for(i = 0; i < NOFILE; i++)
    800013be:	04a1                	add	s1,s1,8
    800013c0:	0921                	add	s2,s2,8
    800013c2:	01348563          	beq	s1,s3,800013cc <fork+0xc2>
    if(p->ofile[i])
    800013c6:	6088                	ld	a0,0(s1)
    800013c8:	f56d                	bnez	a0,800013b2 <fork+0xa8>
    800013ca:	bfd5                	j	800013be <fork+0xb4>
  np->cwd = idup(p->cwd);
    800013cc:	5d0ab503          	ld	a0,1488(s5)
    800013d0:	00001097          	auipc	ra,0x1
    800013d4:	7ba080e7          	jalr	1978(ra) # 80002b8a <idup>
    800013d8:	5caa3823          	sd	a0,1488(s4)
  safestrcpy(np->name, p->name, sizeof(p->name));
    800013dc:	4641                	li	a2,16
    800013de:	5d8a8593          	add	a1,s5,1496
    800013e2:	5d8a0513          	add	a0,s4,1496
    800013e6:	fffff097          	auipc	ra,0xfffff
    800013ea:	ede080e7          	jalr	-290(ra) # 800002c4 <safestrcpy>
  pid = np->pid;
    800013ee:	038a2483          	lw	s1,56(s4)
  np->state = RUNNABLE;
    800013f2:	4789                	li	a5,2
    800013f4:	00fa2c23          	sw	a5,24(s4)
  release(&np->lock);
    800013f8:	8552                	mv	a0,s4
    800013fa:	00008097          	auipc	ra,0x8
    800013fe:	53e080e7          	jalr	1342(ra) # 80009938 <release>
  return pid;
    80001402:	7902                	ld	s2,32(sp)
    80001404:	69e2                	ld	s3,24(sp)
    80001406:	6a42                	ld	s4,16(sp)
}
    80001408:	8526                	mv	a0,s1
    8000140a:	70e2                	ld	ra,56(sp)
    8000140c:	7442                	ld	s0,48(sp)
    8000140e:	74a2                	ld	s1,40(sp)
    80001410:	6aa2                	ld	s5,8(sp)
    80001412:	6121                	add	sp,sp,64
    80001414:	8082                	ret
    return -1;
    80001416:	54fd                	li	s1,-1
    80001418:	bfc5                	j	80001408 <fork+0xfe>

000000008000141a <reparent>:
{
    8000141a:	7179                	add	sp,sp,-48
    8000141c:	f406                	sd	ra,40(sp)
    8000141e:	f022                	sd	s0,32(sp)
    80001420:	ec26                	sd	s1,24(sp)
    80001422:	e84a                	sd	s2,16(sp)
    80001424:	e44e                	sd	s3,8(sp)
    80001426:	e052                	sd	s4,0(sp)
    80001428:	1800                	add	s0,sp,48
    8000142a:	892a                	mv	s2,a0
  for(pp = proc; pp < &proc[NPROC]; pp++){
    8000142c:	0000b497          	auipc	s1,0xb
    80001430:	05c48493          	add	s1,s1,92 # 8000c488 <proc>
      pp->parent = initproc;
    80001434:	0000ba17          	auipc	s4,0xb
    80001438:	bdca0a13          	add	s4,s4,-1060 # 8000c010 <initproc>
  for(pp = proc; pp < &proc[NPROC]; pp++){
    8000143c:	00023997          	auipc	s3,0x23
    80001440:	a4c98993          	add	s3,s3,-1460 # 80023e88 <tickslock>
    80001444:	a029                	j	8000144e <reparent+0x34>
    80001446:	5e848493          	add	s1,s1,1512
    8000144a:	03348363          	beq	s1,s3,80001470 <reparent+0x56>
    if(pp->parent == p){
    8000144e:	709c                	ld	a5,32(s1)
    80001450:	ff279be3          	bne	a5,s2,80001446 <reparent+0x2c>
      acquire(&pp->lock);
    80001454:	8526                	mv	a0,s1
    80001456:	00008097          	auipc	ra,0x8
    8000145a:	41c080e7          	jalr	1052(ra) # 80009872 <acquire>
      pp->parent = initproc;
    8000145e:	000a3783          	ld	a5,0(s4)
    80001462:	f09c                	sd	a5,32(s1)
      release(&pp->lock);
    80001464:	8526                	mv	a0,s1
    80001466:	00008097          	auipc	ra,0x8
    8000146a:	4d2080e7          	jalr	1234(ra) # 80009938 <release>
    8000146e:	bfe1                	j	80001446 <reparent+0x2c>
}
    80001470:	70a2                	ld	ra,40(sp)
    80001472:	7402                	ld	s0,32(sp)
    80001474:	64e2                	ld	s1,24(sp)
    80001476:	6942                	ld	s2,16(sp)
    80001478:	69a2                	ld	s3,8(sp)
    8000147a:	6a02                	ld	s4,0(sp)
    8000147c:	6145                	add	sp,sp,48
    8000147e:	8082                	ret

0000000080001480 <scheduler>:
{
    80001480:	715d                	add	sp,sp,-80
    80001482:	e486                	sd	ra,72(sp)
    80001484:	e0a2                	sd	s0,64(sp)
    80001486:	fc26                	sd	s1,56(sp)
    80001488:	f84a                	sd	s2,48(sp)
    8000148a:	f44e                	sd	s3,40(sp)
    8000148c:	f052                	sd	s4,32(sp)
    8000148e:	ec56                	sd	s5,24(sp)
    80001490:	e85a                	sd	s6,16(sp)
    80001492:	e45e                	sd	s7,8(sp)
    80001494:	e062                	sd	s8,0(sp)
    80001496:	0880                	add	s0,sp,80
    80001498:	8792                	mv	a5,tp
  int id = r_tp();
    8000149a:	2781                	sext.w	a5,a5
  c->proc = 0;
    8000149c:	00779b93          	sll	s7,a5,0x7
    800014a0:	0000b717          	auipc	a4,0xb
    800014a4:	bd070713          	add	a4,a4,-1072 # 8000c070 <pid_lock>
    800014a8:	975e                	add	a4,a4,s7
    800014aa:	00073c23          	sd	zero,24(a4)
        swtch(&c->context, &p->context);
    800014ae:	0000b717          	auipc	a4,0xb
    800014b2:	be270713          	add	a4,a4,-1054 # 8000c090 <cpus+0x8>
    800014b6:	9bba                	add	s7,s7,a4
    int nproc = 0;
    800014b8:	4c01                	li	s8,0
      if(p->state == RUNNABLE) {
    800014ba:	4a09                	li	s4,2
        c->proc = p;
    800014bc:	079e                	sll	a5,a5,0x7
    800014be:	0000ba97          	auipc	s5,0xb
    800014c2:	bb2a8a93          	add	s5,s5,-1102 # 8000c070 <pid_lock>
    800014c6:	9abe                	add	s5,s5,a5
    for(p = proc; p < &proc[NPROC]; p++) {
    800014c8:	00023997          	auipc	s3,0x23
    800014cc:	9c098993          	add	s3,s3,-1600 # 80023e88 <tickslock>
    800014d0:	a8a1                	j	80001528 <scheduler+0xa8>
      release(&p->lock);
    800014d2:	8526                	mv	a0,s1
    800014d4:	00008097          	auipc	ra,0x8
    800014d8:	464080e7          	jalr	1124(ra) # 80009938 <release>
    for(p = proc; p < &proc[NPROC]; p++) {
    800014dc:	5e848493          	add	s1,s1,1512
    800014e0:	03348a63          	beq	s1,s3,80001514 <scheduler+0x94>
      acquire(&p->lock);
    800014e4:	8526                	mv	a0,s1
    800014e6:	00008097          	auipc	ra,0x8
    800014ea:	38c080e7          	jalr	908(ra) # 80009872 <acquire>
      if(p->state != UNUSED) {
    800014ee:	4c9c                	lw	a5,24(s1)
    800014f0:	d3ed                	beqz	a5,800014d2 <scheduler+0x52>
        nproc++;
    800014f2:	2905                	addw	s2,s2,1
      if(p->state == RUNNABLE) {
    800014f4:	fd479fe3          	bne	a5,s4,800014d2 <scheduler+0x52>
        p->state = RUNNING;
    800014f8:	0164ac23          	sw	s6,24(s1)
        c->proc = p;
    800014fc:	009abc23          	sd	s1,24(s5)
        swtch(&c->context, &p->context);
    80001500:	06048593          	add	a1,s1,96
    80001504:	855e                	mv	a0,s7
    80001506:	00000097          	auipc	ra,0x0
    8000150a:	60e080e7          	jalr	1550(ra) # 80001b14 <swtch>
        c->proc = 0;
    8000150e:	000abc23          	sd	zero,24(s5)
    80001512:	b7c1                	j	800014d2 <scheduler+0x52>
    if(nproc <= 2) {   // only init and sh exist
    80001514:	012a4a63          	blt	s4,s2,80001528 <scheduler+0xa8>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80001518:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() | SSTATUS_SIE);
    8000151c:	0027e793          	or	a5,a5,2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80001520:	10079073          	csrw	sstatus,a5
      asm volatile("wfi");
    80001524:	10500073          	wfi
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80001528:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() | SSTATUS_SIE);
    8000152c:	0027e793          	or	a5,a5,2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80001530:	10079073          	csrw	sstatus,a5
    int nproc = 0;
    80001534:	8962                	mv	s2,s8
    for(p = proc; p < &proc[NPROC]; p++) {
    80001536:	0000b497          	auipc	s1,0xb
    8000153a:	f5248493          	add	s1,s1,-174 # 8000c488 <proc>
        p->state = RUNNING;
    8000153e:	4b0d                	li	s6,3
    80001540:	b755                	j	800014e4 <scheduler+0x64>

0000000080001542 <sched>:
{
    80001542:	7179                	add	sp,sp,-48
    80001544:	f406                	sd	ra,40(sp)
    80001546:	f022                	sd	s0,32(sp)
    80001548:	ec26                	sd	s1,24(sp)
    8000154a:	e84a                	sd	s2,16(sp)
    8000154c:	e44e                	sd	s3,8(sp)
    8000154e:	1800                	add	s0,sp,48
  struct proc *p = myproc();
    80001550:	00000097          	auipc	ra,0x0
    80001554:	9f6080e7          	jalr	-1546(ra) # 80000f46 <myproc>
    80001558:	84aa                	mv	s1,a0
  if(!holding(&p->lock))
    8000155a:	00008097          	auipc	ra,0x8
    8000155e:	29e080e7          	jalr	670(ra) # 800097f8 <holding>
    80001562:	c93d                	beqz	a0,800015d8 <sched+0x96>
  asm volatile("mv %0, tp" : "=r" (x) );
    80001564:	8792                	mv	a5,tp
  if(mycpu()->noff != 1)
    80001566:	2781                	sext.w	a5,a5
    80001568:	079e                	sll	a5,a5,0x7
    8000156a:	0000b717          	auipc	a4,0xb
    8000156e:	b0670713          	add	a4,a4,-1274 # 8000c070 <pid_lock>
    80001572:	97ba                	add	a5,a5,a4
    80001574:	0907a703          	lw	a4,144(a5)
    80001578:	4785                	li	a5,1
    8000157a:	06f71763          	bne	a4,a5,800015e8 <sched+0xa6>
  if(p->state == RUNNING)
    8000157e:	4c98                	lw	a4,24(s1)
    80001580:	478d                	li	a5,3
    80001582:	06f70b63          	beq	a4,a5,800015f8 <sched+0xb6>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80001586:	100027f3          	csrr	a5,sstatus
  return (x & SSTATUS_SIE) != 0;
    8000158a:	8b89                	and	a5,a5,2
  if(intr_get())
    8000158c:	efb5                	bnez	a5,80001608 <sched+0xc6>
  asm volatile("mv %0, tp" : "=r" (x) );
    8000158e:	8792                	mv	a5,tp
  intena = mycpu()->intena;
    80001590:	0000b917          	auipc	s2,0xb
    80001594:	ae090913          	add	s2,s2,-1312 # 8000c070 <pid_lock>
    80001598:	2781                	sext.w	a5,a5
    8000159a:	079e                	sll	a5,a5,0x7
    8000159c:	97ca                	add	a5,a5,s2
    8000159e:	0947a983          	lw	s3,148(a5)
    800015a2:	8792                	mv	a5,tp
  swtch(&p->context, &mycpu()->context);
    800015a4:	2781                	sext.w	a5,a5
    800015a6:	079e                	sll	a5,a5,0x7
    800015a8:	0000b597          	auipc	a1,0xb
    800015ac:	ae858593          	add	a1,a1,-1304 # 8000c090 <cpus+0x8>
    800015b0:	95be                	add	a1,a1,a5
    800015b2:	06048513          	add	a0,s1,96
    800015b6:	00000097          	auipc	ra,0x0
    800015ba:	55e080e7          	jalr	1374(ra) # 80001b14 <swtch>
    800015be:	8792                	mv	a5,tp
  mycpu()->intena = intena;
    800015c0:	2781                	sext.w	a5,a5
    800015c2:	079e                	sll	a5,a5,0x7
    800015c4:	993e                	add	s2,s2,a5
    800015c6:	09392a23          	sw	s3,148(s2)
}
    800015ca:	70a2                	ld	ra,40(sp)
    800015cc:	7402                	ld	s0,32(sp)
    800015ce:	64e2                	ld	s1,24(sp)
    800015d0:	6942                	ld	s2,16(sp)
    800015d2:	69a2                	ld	s3,8(sp)
    800015d4:	6145                	add	sp,sp,48
    800015d6:	8082                	ret
    panic("sched p->lock");
    800015d8:	0000a517          	auipc	a0,0xa
    800015dc:	bd050513          	add	a0,a0,-1072 # 8000b1a8 <etext+0x1a8>
    800015e0:	00008097          	auipc	ra,0x8
    800015e4:	cf8080e7          	jalr	-776(ra) # 800092d8 <panic>
    panic("sched locks");
    800015e8:	0000a517          	auipc	a0,0xa
    800015ec:	bd050513          	add	a0,a0,-1072 # 8000b1b8 <etext+0x1b8>
    800015f0:	00008097          	auipc	ra,0x8
    800015f4:	ce8080e7          	jalr	-792(ra) # 800092d8 <panic>
    panic("sched running");
    800015f8:	0000a517          	auipc	a0,0xa
    800015fc:	bd050513          	add	a0,a0,-1072 # 8000b1c8 <etext+0x1c8>
    80001600:	00008097          	auipc	ra,0x8
    80001604:	cd8080e7          	jalr	-808(ra) # 800092d8 <panic>
    panic("sched interruptible");
    80001608:	0000a517          	auipc	a0,0xa
    8000160c:	bd050513          	add	a0,a0,-1072 # 8000b1d8 <etext+0x1d8>
    80001610:	00008097          	auipc	ra,0x8
    80001614:	cc8080e7          	jalr	-824(ra) # 800092d8 <panic>

0000000080001618 <exit>:
{
    80001618:	7179                	add	sp,sp,-48
    8000161a:	f406                	sd	ra,40(sp)
    8000161c:	f022                	sd	s0,32(sp)
    8000161e:	ec26                	sd	s1,24(sp)
    80001620:	e84a                	sd	s2,16(sp)
    80001622:	e44e                	sd	s3,8(sp)
    80001624:	e052                	sd	s4,0(sp)
    80001626:	1800                	add	s0,sp,48
    80001628:	8a2a                	mv	s4,a0
  struct proc *p = myproc();
    8000162a:	00000097          	auipc	ra,0x0
    8000162e:	91c080e7          	jalr	-1764(ra) # 80000f46 <myproc>
    80001632:	89aa                	mv	s3,a0
  if(p == initproc)
    80001634:	0000b797          	auipc	a5,0xb
    80001638:	9dc7b783          	ld	a5,-1572(a5) # 8000c010 <initproc>
    8000163c:	0d050493          	add	s1,a0,208
    80001640:	5d050913          	add	s2,a0,1488
    80001644:	02a79363          	bne	a5,a0,8000166a <exit+0x52>
    panic("init exiting");
    80001648:	0000a517          	auipc	a0,0xa
    8000164c:	ba850513          	add	a0,a0,-1112 # 8000b1f0 <etext+0x1f0>
    80001650:	00008097          	auipc	ra,0x8
    80001654:	c88080e7          	jalr	-888(ra) # 800092d8 <panic>
      fileclose(f);
    80001658:	00002097          	auipc	ra,0x2
    8000165c:	414080e7          	jalr	1044(ra) # 80003a6c <fileclose>
      p->ofile[fd] = 0;
    80001660:	0004b023          	sd	zero,0(s1)
  for(int fd = 0; fd < NOFILE; fd++){
    80001664:	04a1                	add	s1,s1,8
    80001666:	01248563          	beq	s1,s2,80001670 <exit+0x58>
    if(p->ofile[fd]){
    8000166a:	6088                	ld	a0,0(s1)
    8000166c:	f575                	bnez	a0,80001658 <exit+0x40>
    8000166e:	bfdd                	j	80001664 <exit+0x4c>
  begin_op();
    80001670:	00002097          	auipc	ra,0x2
    80001674:	f2a080e7          	jalr	-214(ra) # 8000359a <begin_op>
  iput(p->cwd);
    80001678:	5d09b503          	ld	a0,1488(s3)
    8000167c:	00001097          	auipc	ra,0x1
    80001680:	70a080e7          	jalr	1802(ra) # 80002d86 <iput>
  end_op();
    80001684:	00002097          	auipc	ra,0x2
    80001688:	f90080e7          	jalr	-112(ra) # 80003614 <end_op>
  p->cwd = 0;
    8000168c:	5c09b823          	sd	zero,1488(s3)
  acquire(&initproc->lock);
    80001690:	0000b497          	auipc	s1,0xb
    80001694:	98048493          	add	s1,s1,-1664 # 8000c010 <initproc>
    80001698:	6088                	ld	a0,0(s1)
    8000169a:	00008097          	auipc	ra,0x8
    8000169e:	1d8080e7          	jalr	472(ra) # 80009872 <acquire>
  wakeup1(initproc);
    800016a2:	6088                	ld	a0,0(s1)
    800016a4:	fffff097          	auipc	ra,0xfffff
    800016a8:	6f4080e7          	jalr	1780(ra) # 80000d98 <wakeup1>
  release(&initproc->lock);
    800016ac:	6088                	ld	a0,0(s1)
    800016ae:	00008097          	auipc	ra,0x8
    800016b2:	28a080e7          	jalr	650(ra) # 80009938 <release>
  acquire(&p->lock);
    800016b6:	854e                	mv	a0,s3
    800016b8:	00008097          	auipc	ra,0x8
    800016bc:	1ba080e7          	jalr	442(ra) # 80009872 <acquire>
  struct proc *original_parent = p->parent;
    800016c0:	0209b483          	ld	s1,32(s3)
  release(&p->lock);
    800016c4:	854e                	mv	a0,s3
    800016c6:	00008097          	auipc	ra,0x8
    800016ca:	272080e7          	jalr	626(ra) # 80009938 <release>
  acquire(&original_parent->lock);
    800016ce:	8526                	mv	a0,s1
    800016d0:	00008097          	auipc	ra,0x8
    800016d4:	1a2080e7          	jalr	418(ra) # 80009872 <acquire>
  acquire(&p->lock);
    800016d8:	854e                	mv	a0,s3
    800016da:	00008097          	auipc	ra,0x8
    800016de:	198080e7          	jalr	408(ra) # 80009872 <acquire>
  reparent(p);
    800016e2:	854e                	mv	a0,s3
    800016e4:	00000097          	auipc	ra,0x0
    800016e8:	d36080e7          	jalr	-714(ra) # 8000141a <reparent>
  wakeup1(original_parent);
    800016ec:	8526                	mv	a0,s1
    800016ee:	fffff097          	auipc	ra,0xfffff
    800016f2:	6aa080e7          	jalr	1706(ra) # 80000d98 <wakeup1>
  p->xstate = status;
    800016f6:	0349aa23          	sw	s4,52(s3)
  p->state = ZOMBIE;
    800016fa:	4791                	li	a5,4
    800016fc:	00f9ac23          	sw	a5,24(s3)
  release(&original_parent->lock);
    80001700:	8526                	mv	a0,s1
    80001702:	00008097          	auipc	ra,0x8
    80001706:	236080e7          	jalr	566(ra) # 80009938 <release>
  sched();
    8000170a:	00000097          	auipc	ra,0x0
    8000170e:	e38080e7          	jalr	-456(ra) # 80001542 <sched>
  panic("zombie exit");
    80001712:	0000a517          	auipc	a0,0xa
    80001716:	aee50513          	add	a0,a0,-1298 # 8000b200 <etext+0x200>
    8000171a:	00008097          	auipc	ra,0x8
    8000171e:	bbe080e7          	jalr	-1090(ra) # 800092d8 <panic>

0000000080001722 <yield>:
{
    80001722:	1101                	add	sp,sp,-32
    80001724:	ec06                	sd	ra,24(sp)
    80001726:	e822                	sd	s0,16(sp)
    80001728:	e426                	sd	s1,8(sp)
    8000172a:	1000                	add	s0,sp,32
  struct proc *p = myproc();
    8000172c:	00000097          	auipc	ra,0x0
    80001730:	81a080e7          	jalr	-2022(ra) # 80000f46 <myproc>
    80001734:	84aa                	mv	s1,a0
  acquire(&p->lock);
    80001736:	00008097          	auipc	ra,0x8
    8000173a:	13c080e7          	jalr	316(ra) # 80009872 <acquire>
  p->state = RUNNABLE;
    8000173e:	4789                	li	a5,2
    80001740:	cc9c                	sw	a5,24(s1)
  sched();
    80001742:	00000097          	auipc	ra,0x0
    80001746:	e00080e7          	jalr	-512(ra) # 80001542 <sched>
  release(&p->lock);
    8000174a:	8526                	mv	a0,s1
    8000174c:	00008097          	auipc	ra,0x8
    80001750:	1ec080e7          	jalr	492(ra) # 80009938 <release>
}
    80001754:	60e2                	ld	ra,24(sp)
    80001756:	6442                	ld	s0,16(sp)
    80001758:	64a2                	ld	s1,8(sp)
    8000175a:	6105                	add	sp,sp,32
    8000175c:	8082                	ret

000000008000175e <sleep>:
{
    8000175e:	7179                	add	sp,sp,-48
    80001760:	f406                	sd	ra,40(sp)
    80001762:	f022                	sd	s0,32(sp)
    80001764:	ec26                	sd	s1,24(sp)
    80001766:	e84a                	sd	s2,16(sp)
    80001768:	e44e                	sd	s3,8(sp)
    8000176a:	1800                	add	s0,sp,48
    8000176c:	89aa                	mv	s3,a0
    8000176e:	892e                	mv	s2,a1
  struct proc *p = myproc();
    80001770:	fffff097          	auipc	ra,0xfffff
    80001774:	7d6080e7          	jalr	2006(ra) # 80000f46 <myproc>
    80001778:	84aa                	mv	s1,a0
  if(lk != &p->lock){  //DOC: sleeplock0
    8000177a:	05250663          	beq	a0,s2,800017c6 <sleep+0x68>
    acquire(&p->lock);  //DOC: sleeplock1
    8000177e:	00008097          	auipc	ra,0x8
    80001782:	0f4080e7          	jalr	244(ra) # 80009872 <acquire>
    release(lk);
    80001786:	854a                	mv	a0,s2
    80001788:	00008097          	auipc	ra,0x8
    8000178c:	1b0080e7          	jalr	432(ra) # 80009938 <release>
  p->chan = chan;
    80001790:	0334b423          	sd	s3,40(s1)
  p->state = SLEEPING;
    80001794:	4785                	li	a5,1
    80001796:	cc9c                	sw	a5,24(s1)
  sched();
    80001798:	00000097          	auipc	ra,0x0
    8000179c:	daa080e7          	jalr	-598(ra) # 80001542 <sched>
  p->chan = 0;
    800017a0:	0204b423          	sd	zero,40(s1)
    release(&p->lock);
    800017a4:	8526                	mv	a0,s1
    800017a6:	00008097          	auipc	ra,0x8
    800017aa:	192080e7          	jalr	402(ra) # 80009938 <release>
    acquire(lk);
    800017ae:	854a                	mv	a0,s2
    800017b0:	00008097          	auipc	ra,0x8
    800017b4:	0c2080e7          	jalr	194(ra) # 80009872 <acquire>
}
    800017b8:	70a2                	ld	ra,40(sp)
    800017ba:	7402                	ld	s0,32(sp)
    800017bc:	64e2                	ld	s1,24(sp)
    800017be:	6942                	ld	s2,16(sp)
    800017c0:	69a2                	ld	s3,8(sp)
    800017c2:	6145                	add	sp,sp,48
    800017c4:	8082                	ret
  p->chan = chan;
    800017c6:	03353423          	sd	s3,40(a0)
  p->state = SLEEPING;
    800017ca:	4785                	li	a5,1
    800017cc:	cd1c                	sw	a5,24(a0)
  sched();
    800017ce:	00000097          	auipc	ra,0x0
    800017d2:	d74080e7          	jalr	-652(ra) # 80001542 <sched>
  p->chan = 0;
    800017d6:	0204b423          	sd	zero,40(s1)
  if(lk != &p->lock){
    800017da:	bff9                	j	800017b8 <sleep+0x5a>

00000000800017dc <wait>:
{
    800017dc:	715d                	add	sp,sp,-80
    800017de:	e486                	sd	ra,72(sp)
    800017e0:	e0a2                	sd	s0,64(sp)
    800017e2:	fc26                	sd	s1,56(sp)
    800017e4:	f84a                	sd	s2,48(sp)
    800017e6:	f44e                	sd	s3,40(sp)
    800017e8:	f052                	sd	s4,32(sp)
    800017ea:	ec56                	sd	s5,24(sp)
    800017ec:	e85a                	sd	s6,16(sp)
    800017ee:	e45e                	sd	s7,8(sp)
    800017f0:	0880                	add	s0,sp,80
    800017f2:	8b2a                	mv	s6,a0
  struct proc *p = myproc();
    800017f4:	fffff097          	auipc	ra,0xfffff
    800017f8:	752080e7          	jalr	1874(ra) # 80000f46 <myproc>
    800017fc:	892a                	mv	s2,a0
  acquire(&p->lock);
    800017fe:	00008097          	auipc	ra,0x8
    80001802:	074080e7          	jalr	116(ra) # 80009872 <acquire>
    havekids = 0;
    80001806:	4b81                	li	s7,0
        if(np->state == ZOMBIE){
    80001808:	4a11                	li	s4,4
        havekids = 1;
    8000180a:	4a85                	li	s5,1
    for(np = proc; np < &proc[NPROC]; np++){
    8000180c:	00022997          	auipc	s3,0x22
    80001810:	67c98993          	add	s3,s3,1660 # 80023e88 <tickslock>
    80001814:	a845                	j	800018c4 <wait+0xe8>
          pid = np->pid;
    80001816:	0384a983          	lw	s3,56(s1)
          if(addr != 0 && copyout(p->pagetable, addr, (char *)&np->xstate,
    8000181a:	000b0e63          	beqz	s6,80001836 <wait+0x5a>
    8000181e:	4691                	li	a3,4
    80001820:	03448613          	add	a2,s1,52
    80001824:	85da                	mv	a1,s6
    80001826:	05093503          	ld	a0,80(s2)
    8000182a:	fffff097          	auipc	ra,0xfffff
    8000182e:	398080e7          	jalr	920(ra) # 80000bc2 <copyout>
    80001832:	02054d63          	bltz	a0,8000186c <wait+0x90>
          freeproc(np);
    80001836:	8526                	mv	a0,s1
    80001838:	00000097          	auipc	ra,0x0
    8000183c:	8c0080e7          	jalr	-1856(ra) # 800010f8 <freeproc>
          release(&np->lock);
    80001840:	8526                	mv	a0,s1
    80001842:	00008097          	auipc	ra,0x8
    80001846:	0f6080e7          	jalr	246(ra) # 80009938 <release>
          release(&p->lock);
    8000184a:	854a                	mv	a0,s2
    8000184c:	00008097          	auipc	ra,0x8
    80001850:	0ec080e7          	jalr	236(ra) # 80009938 <release>
}
    80001854:	854e                	mv	a0,s3
    80001856:	60a6                	ld	ra,72(sp)
    80001858:	6406                	ld	s0,64(sp)
    8000185a:	74e2                	ld	s1,56(sp)
    8000185c:	7942                	ld	s2,48(sp)
    8000185e:	79a2                	ld	s3,40(sp)
    80001860:	7a02                	ld	s4,32(sp)
    80001862:	6ae2                	ld	s5,24(sp)
    80001864:	6b42                	ld	s6,16(sp)
    80001866:	6ba2                	ld	s7,8(sp)
    80001868:	6161                	add	sp,sp,80
    8000186a:	8082                	ret
            release(&np->lock);
    8000186c:	8526                	mv	a0,s1
    8000186e:	00008097          	auipc	ra,0x8
    80001872:	0ca080e7          	jalr	202(ra) # 80009938 <release>
            release(&p->lock);
    80001876:	854a                	mv	a0,s2
    80001878:	00008097          	auipc	ra,0x8
    8000187c:	0c0080e7          	jalr	192(ra) # 80009938 <release>
            return -1;
    80001880:	59fd                	li	s3,-1
    80001882:	bfc9                	j	80001854 <wait+0x78>
    for(np = proc; np < &proc[NPROC]; np++){
    80001884:	5e848493          	add	s1,s1,1512
    80001888:	03348463          	beq	s1,s3,800018b0 <wait+0xd4>
      if(np->parent == p){
    8000188c:	709c                	ld	a5,32(s1)
    8000188e:	ff279be3          	bne	a5,s2,80001884 <wait+0xa8>
        acquire(&np->lock);
    80001892:	8526                	mv	a0,s1
    80001894:	00008097          	auipc	ra,0x8
    80001898:	fde080e7          	jalr	-34(ra) # 80009872 <acquire>
        if(np->state == ZOMBIE){
    8000189c:	4c9c                	lw	a5,24(s1)
    8000189e:	f7478ce3          	beq	a5,s4,80001816 <wait+0x3a>
        release(&np->lock);
    800018a2:	8526                	mv	a0,s1
    800018a4:	00008097          	auipc	ra,0x8
    800018a8:	094080e7          	jalr	148(ra) # 80009938 <release>
        havekids = 1;
    800018ac:	8756                	mv	a4,s5
    800018ae:	bfd9                	j	80001884 <wait+0xa8>
    if(!havekids || p->killed){
    800018b0:	c305                	beqz	a4,800018d0 <wait+0xf4>
    800018b2:	03092783          	lw	a5,48(s2)
    800018b6:	ef89                	bnez	a5,800018d0 <wait+0xf4>
    sleep(p, &p->lock);  //DOC: wait-sleep
    800018b8:	85ca                	mv	a1,s2
    800018ba:	854a                	mv	a0,s2
    800018bc:	00000097          	auipc	ra,0x0
    800018c0:	ea2080e7          	jalr	-350(ra) # 8000175e <sleep>
    havekids = 0;
    800018c4:	875e                	mv	a4,s7
    for(np = proc; np < &proc[NPROC]; np++){
    800018c6:	0000b497          	auipc	s1,0xb
    800018ca:	bc248493          	add	s1,s1,-1086 # 8000c488 <proc>
    800018ce:	bf7d                	j	8000188c <wait+0xb0>
      release(&p->lock);
    800018d0:	854a                	mv	a0,s2
    800018d2:	00008097          	auipc	ra,0x8
    800018d6:	066080e7          	jalr	102(ra) # 80009938 <release>
      return -1;
    800018da:	59fd                	li	s3,-1
    800018dc:	bfa5                	j	80001854 <wait+0x78>

00000000800018de <wakeup>:
{
    800018de:	7139                	add	sp,sp,-64
    800018e0:	fc06                	sd	ra,56(sp)
    800018e2:	f822                	sd	s0,48(sp)
    800018e4:	f426                	sd	s1,40(sp)
    800018e6:	f04a                	sd	s2,32(sp)
    800018e8:	ec4e                	sd	s3,24(sp)
    800018ea:	e852                	sd	s4,16(sp)
    800018ec:	e456                	sd	s5,8(sp)
    800018ee:	0080                	add	s0,sp,64
    800018f0:	8a2a                	mv	s4,a0
  for(p = proc; p < &proc[NPROC]; p++) {
    800018f2:	0000b497          	auipc	s1,0xb
    800018f6:	b9648493          	add	s1,s1,-1130 # 8000c488 <proc>
    if(p->state == SLEEPING && p->chan == chan) {
    800018fa:	4985                	li	s3,1
      p->state = RUNNABLE;
    800018fc:	4a89                	li	s5,2
  for(p = proc; p < &proc[NPROC]; p++) {
    800018fe:	00022917          	auipc	s2,0x22
    80001902:	58a90913          	add	s2,s2,1418 # 80023e88 <tickslock>
    80001906:	a811                	j	8000191a <wakeup+0x3c>
    release(&p->lock);
    80001908:	8526                	mv	a0,s1
    8000190a:	00008097          	auipc	ra,0x8
    8000190e:	02e080e7          	jalr	46(ra) # 80009938 <release>
  for(p = proc; p < &proc[NPROC]; p++) {
    80001912:	5e848493          	add	s1,s1,1512
    80001916:	03248063          	beq	s1,s2,80001936 <wakeup+0x58>
    acquire(&p->lock);
    8000191a:	8526                	mv	a0,s1
    8000191c:	00008097          	auipc	ra,0x8
    80001920:	f56080e7          	jalr	-170(ra) # 80009872 <acquire>
    if(p->state == SLEEPING && p->chan == chan) {
    80001924:	4c9c                	lw	a5,24(s1)
    80001926:	ff3791e3          	bne	a5,s3,80001908 <wakeup+0x2a>
    8000192a:	749c                	ld	a5,40(s1)
    8000192c:	fd479ee3          	bne	a5,s4,80001908 <wakeup+0x2a>
      p->state = RUNNABLE;
    80001930:	0154ac23          	sw	s5,24(s1)
    80001934:	bfd1                	j	80001908 <wakeup+0x2a>
}
    80001936:	70e2                	ld	ra,56(sp)
    80001938:	7442                	ld	s0,48(sp)
    8000193a:	74a2                	ld	s1,40(sp)
    8000193c:	7902                	ld	s2,32(sp)
    8000193e:	69e2                	ld	s3,24(sp)
    80001940:	6a42                	ld	s4,16(sp)
    80001942:	6aa2                	ld	s5,8(sp)
    80001944:	6121                	add	sp,sp,64
    80001946:	8082                	ret

0000000080001948 <kill>:
// Kill the process with the given pid.
// The victim won't exit until it tries to return
// to user space (see usertrap() in trap.c).
int
kill(int pid)
{
    80001948:	7179                	add	sp,sp,-48
    8000194a:	f406                	sd	ra,40(sp)
    8000194c:	f022                	sd	s0,32(sp)
    8000194e:	ec26                	sd	s1,24(sp)
    80001950:	e84a                	sd	s2,16(sp)
    80001952:	e44e                	sd	s3,8(sp)
    80001954:	1800                	add	s0,sp,48
    80001956:	892a                	mv	s2,a0
  struct proc *p;

  for(p = proc; p < &proc[NPROC]; p++){
    80001958:	0000b497          	auipc	s1,0xb
    8000195c:	b3048493          	add	s1,s1,-1232 # 8000c488 <proc>
    80001960:	00022997          	auipc	s3,0x22
    80001964:	52898993          	add	s3,s3,1320 # 80023e88 <tickslock>
    acquire(&p->lock);
    80001968:	8526                	mv	a0,s1
    8000196a:	00008097          	auipc	ra,0x8
    8000196e:	f08080e7          	jalr	-248(ra) # 80009872 <acquire>
    if(p->pid == pid){
    80001972:	5c9c                	lw	a5,56(s1)
    80001974:	01278d63          	beq	a5,s2,8000198e <kill+0x46>
        p->state = RUNNABLE;
      }
      release(&p->lock);
      return 0;
    }
    release(&p->lock);
    80001978:	8526                	mv	a0,s1
    8000197a:	00008097          	auipc	ra,0x8
    8000197e:	fbe080e7          	jalr	-66(ra) # 80009938 <release>
  for(p = proc; p < &proc[NPROC]; p++){
    80001982:	5e848493          	add	s1,s1,1512
    80001986:	ff3491e3          	bne	s1,s3,80001968 <kill+0x20>
  }
  return -1;
    8000198a:	557d                	li	a0,-1
    8000198c:	a821                	j	800019a4 <kill+0x5c>
      p->killed = 1;
    8000198e:	4785                	li	a5,1
    80001990:	d89c                	sw	a5,48(s1)
      if(p->state == SLEEPING){
    80001992:	4c98                	lw	a4,24(s1)
    80001994:	00f70f63          	beq	a4,a5,800019b2 <kill+0x6a>
      release(&p->lock);
    80001998:	8526                	mv	a0,s1
    8000199a:	00008097          	auipc	ra,0x8
    8000199e:	f9e080e7          	jalr	-98(ra) # 80009938 <release>
      return 0;
    800019a2:	4501                	li	a0,0
}
    800019a4:	70a2                	ld	ra,40(sp)
    800019a6:	7402                	ld	s0,32(sp)
    800019a8:	64e2                	ld	s1,24(sp)
    800019aa:	6942                	ld	s2,16(sp)
    800019ac:	69a2                	ld	s3,8(sp)
    800019ae:	6145                	add	sp,sp,48
    800019b0:	8082                	ret
        p->state = RUNNABLE;
    800019b2:	4789                	li	a5,2
    800019b4:	cc9c                	sw	a5,24(s1)
    800019b6:	b7cd                	j	80001998 <kill+0x50>

00000000800019b8 <either_copyout>:
// Copy to either a user address, or kernel address,
// depending on usr_dst.
// Returns 0 on success, -1 on error.
int
either_copyout(int user_dst, uint64 dst, void *src, uint64 len)
{
    800019b8:	7179                	add	sp,sp,-48
    800019ba:	f406                	sd	ra,40(sp)
    800019bc:	f022                	sd	s0,32(sp)
    800019be:	ec26                	sd	s1,24(sp)
    800019c0:	e84a                	sd	s2,16(sp)
    800019c2:	e44e                	sd	s3,8(sp)
    800019c4:	e052                	sd	s4,0(sp)
    800019c6:	1800                	add	s0,sp,48
    800019c8:	84aa                	mv	s1,a0
    800019ca:	892e                	mv	s2,a1
    800019cc:	89b2                	mv	s3,a2
    800019ce:	8a36                	mv	s4,a3
  struct proc *p = myproc();
    800019d0:	fffff097          	auipc	ra,0xfffff
    800019d4:	576080e7          	jalr	1398(ra) # 80000f46 <myproc>
  if(user_dst){
    800019d8:	c08d                	beqz	s1,800019fa <either_copyout+0x42>
    return copyout(p->pagetable, dst, src, len);
    800019da:	86d2                	mv	a3,s4
    800019dc:	864e                	mv	a2,s3
    800019de:	85ca                	mv	a1,s2
    800019e0:	6928                	ld	a0,80(a0)
    800019e2:	fffff097          	auipc	ra,0xfffff
    800019e6:	1e0080e7          	jalr	480(ra) # 80000bc2 <copyout>
  } else {
    memmove((char *)dst, src, len);
    return 0;
  }
}
    800019ea:	70a2                	ld	ra,40(sp)
    800019ec:	7402                	ld	s0,32(sp)
    800019ee:	64e2                	ld	s1,24(sp)
    800019f0:	6942                	ld	s2,16(sp)
    800019f2:	69a2                	ld	s3,8(sp)
    800019f4:	6a02                	ld	s4,0(sp)
    800019f6:	6145                	add	sp,sp,48
    800019f8:	8082                	ret
    memmove((char *)dst, src, len);
    800019fa:	000a061b          	sext.w	a2,s4
    800019fe:	85ce                	mv	a1,s3
    80001a00:	854a                	mv	a0,s2
    80001a02:	ffffe097          	auipc	ra,0xffffe
    80001a06:	7d4080e7          	jalr	2004(ra) # 800001d6 <memmove>
    return 0;
    80001a0a:	8526                	mv	a0,s1
    80001a0c:	bff9                	j	800019ea <either_copyout+0x32>

0000000080001a0e <either_copyin>:
// Copy from either a user address, or kernel address,
// depending on usr_src.
// Returns 0 on success, -1 on error.
int
either_copyin(void *dst, int user_src, uint64 src, uint64 len)
{
    80001a0e:	7179                	add	sp,sp,-48
    80001a10:	f406                	sd	ra,40(sp)
    80001a12:	f022                	sd	s0,32(sp)
    80001a14:	ec26                	sd	s1,24(sp)
    80001a16:	e84a                	sd	s2,16(sp)
    80001a18:	e44e                	sd	s3,8(sp)
    80001a1a:	e052                	sd	s4,0(sp)
    80001a1c:	1800                	add	s0,sp,48
    80001a1e:	892a                	mv	s2,a0
    80001a20:	84ae                	mv	s1,a1
    80001a22:	89b2                	mv	s3,a2
    80001a24:	8a36                	mv	s4,a3
  struct proc *p = myproc();
    80001a26:	fffff097          	auipc	ra,0xfffff
    80001a2a:	520080e7          	jalr	1312(ra) # 80000f46 <myproc>
  if(user_src){
    80001a2e:	c08d                	beqz	s1,80001a50 <either_copyin+0x42>
    return copyin(p->pagetable, dst, src, len);
    80001a30:	86d2                	mv	a3,s4
    80001a32:	864e                	mv	a2,s3
    80001a34:	85ca                	mv	a1,s2
    80001a36:	6928                	ld	a0,80(a0)
    80001a38:	fffff097          	auipc	ra,0xfffff
    80001a3c:	216080e7          	jalr	534(ra) # 80000c4e <copyin>
  } else {
    memmove(dst, (char*)src, len);
    return 0;
  }
}
    80001a40:	70a2                	ld	ra,40(sp)
    80001a42:	7402                	ld	s0,32(sp)
    80001a44:	64e2                	ld	s1,24(sp)
    80001a46:	6942                	ld	s2,16(sp)
    80001a48:	69a2                	ld	s3,8(sp)
    80001a4a:	6a02                	ld	s4,0(sp)
    80001a4c:	6145                	add	sp,sp,48
    80001a4e:	8082                	ret
    memmove(dst, (char*)src, len);
    80001a50:	000a061b          	sext.w	a2,s4
    80001a54:	85ce                	mv	a1,s3
    80001a56:	854a                	mv	a0,s2
    80001a58:	ffffe097          	auipc	ra,0xffffe
    80001a5c:	77e080e7          	jalr	1918(ra) # 800001d6 <memmove>
    return 0;
    80001a60:	8526                	mv	a0,s1
    80001a62:	bff9                	j	80001a40 <either_copyin+0x32>

0000000080001a64 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
    80001a64:	715d                	add	sp,sp,-80
    80001a66:	e486                	sd	ra,72(sp)
    80001a68:	e0a2                	sd	s0,64(sp)
    80001a6a:	fc26                	sd	s1,56(sp)
    80001a6c:	f84a                	sd	s2,48(sp)
    80001a6e:	f44e                	sd	s3,40(sp)
    80001a70:	f052                	sd	s4,32(sp)
    80001a72:	ec56                	sd	s5,24(sp)
    80001a74:	e85a                	sd	s6,16(sp)
    80001a76:	e45e                	sd	s7,8(sp)
    80001a78:	0880                	add	s0,sp,80
  [ZOMBIE]    "zombie"
  };
  struct proc *p;
  char *state;

  printf("\n");
    80001a7a:	00009517          	auipc	a0,0x9
    80001a7e:	5be50513          	add	a0,a0,1470 # 8000b038 <etext+0x38>
    80001a82:	00008097          	auipc	ra,0x8
    80001a86:	8a0080e7          	jalr	-1888(ra) # 80009322 <printf>
  for(p = proc; p < &proc[NPROC]; p++){
    80001a8a:	0000b497          	auipc	s1,0xb
    80001a8e:	fd648493          	add	s1,s1,-42 # 8000ca60 <proc+0x5d8>
    80001a92:	00023917          	auipc	s2,0x23
    80001a96:	9ce90913          	add	s2,s2,-1586 # 80024460 <bcache+0x5c0>
    if(p->state == UNUSED)
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
    80001a9a:	4b11                	li	s6,4
      state = states[p->state];
    else
      state = "???";
    80001a9c:	00009997          	auipc	s3,0x9
    80001aa0:	77498993          	add	s3,s3,1908 # 8000b210 <etext+0x210>
    printf("%d %s %s", p->pid, state, p->name);
    80001aa4:	00009a97          	auipc	s5,0x9
    80001aa8:	774a8a93          	add	s5,s5,1908 # 8000b218 <etext+0x218>
    printf("\n");
    80001aac:	00009a17          	auipc	s4,0x9
    80001ab0:	58ca0a13          	add	s4,s4,1420 # 8000b038 <etext+0x38>
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
    80001ab4:	0000ab97          	auipc	s7,0xa
    80001ab8:	e6cb8b93          	add	s7,s7,-404 # 8000b920 <states.0>
    80001abc:	a00d                	j	80001ade <procdump+0x7a>
    printf("%d %s %s", p->pid, state, p->name);
    80001abe:	a606a583          	lw	a1,-1440(a3)
    80001ac2:	8556                	mv	a0,s5
    80001ac4:	00008097          	auipc	ra,0x8
    80001ac8:	85e080e7          	jalr	-1954(ra) # 80009322 <printf>
    printf("\n");
    80001acc:	8552                	mv	a0,s4
    80001ace:	00008097          	auipc	ra,0x8
    80001ad2:	854080e7          	jalr	-1964(ra) # 80009322 <printf>
  for(p = proc; p < &proc[NPROC]; p++){
    80001ad6:	5e848493          	add	s1,s1,1512
    80001ada:	03248263          	beq	s1,s2,80001afe <procdump+0x9a>
    if(p->state == UNUSED)
    80001ade:	86a6                	mv	a3,s1
    80001ae0:	a404a783          	lw	a5,-1472(s1)
    80001ae4:	dbed                	beqz	a5,80001ad6 <procdump+0x72>
      state = "???";
    80001ae6:	864e                	mv	a2,s3
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
    80001ae8:	fcfb6be3          	bltu	s6,a5,80001abe <procdump+0x5a>
    80001aec:	02079713          	sll	a4,a5,0x20
    80001af0:	01d75793          	srl	a5,a4,0x1d
    80001af4:	97de                	add	a5,a5,s7
    80001af6:	6390                	ld	a2,0(a5)
    80001af8:	f279                	bnez	a2,80001abe <procdump+0x5a>
      state = "???";
    80001afa:	864e                	mv	a2,s3
    80001afc:	b7c9                	j	80001abe <procdump+0x5a>
  }
}
    80001afe:	60a6                	ld	ra,72(sp)
    80001b00:	6406                	ld	s0,64(sp)
    80001b02:	74e2                	ld	s1,56(sp)
    80001b04:	7942                	ld	s2,48(sp)
    80001b06:	79a2                	ld	s3,40(sp)
    80001b08:	7a02                	ld	s4,32(sp)
    80001b0a:	6ae2                	ld	s5,24(sp)
    80001b0c:	6b42                	ld	s6,16(sp)
    80001b0e:	6ba2                	ld	s7,8(sp)
    80001b10:	6161                	add	sp,sp,80
    80001b12:	8082                	ret

0000000080001b14 <swtch>:
    80001b14:	00153023          	sd	ra,0(a0)
    80001b18:	00253423          	sd	sp,8(a0)
    80001b1c:	e900                	sd	s0,16(a0)
    80001b1e:	ed04                	sd	s1,24(a0)
    80001b20:	03253023          	sd	s2,32(a0)
    80001b24:	03353423          	sd	s3,40(a0)
    80001b28:	03453823          	sd	s4,48(a0)
    80001b2c:	03553c23          	sd	s5,56(a0)
    80001b30:	05653023          	sd	s6,64(a0)
    80001b34:	05753423          	sd	s7,72(a0)
    80001b38:	05853823          	sd	s8,80(a0)
    80001b3c:	05953c23          	sd	s9,88(a0)
    80001b40:	07a53023          	sd	s10,96(a0)
    80001b44:	07b53423          	sd	s11,104(a0)
    80001b48:	0005b083          	ld	ra,0(a1)
    80001b4c:	0085b103          	ld	sp,8(a1)
    80001b50:	6980                	ld	s0,16(a1)
    80001b52:	6d84                	ld	s1,24(a1)
    80001b54:	0205b903          	ld	s2,32(a1)
    80001b58:	0285b983          	ld	s3,40(a1)
    80001b5c:	0305ba03          	ld	s4,48(a1)
    80001b60:	0385ba83          	ld	s5,56(a1)
    80001b64:	0405bb03          	ld	s6,64(a1)
    80001b68:	0485bb83          	ld	s7,72(a1)
    80001b6c:	0505bc03          	ld	s8,80(a1)
    80001b70:	0585bc83          	ld	s9,88(a1)
    80001b74:	0605bd03          	ld	s10,96(a1)
    80001b78:	0685bd83          	ld	s11,104(a1)
    80001b7c:	8082                	ret

0000000080001b7e <trapinit>:

extern int devintr();

void
trapinit(void)
{
    80001b7e:	1141                	add	sp,sp,-16
    80001b80:	e406                	sd	ra,8(sp)
    80001b82:	e022                	sd	s0,0(sp)
    80001b84:	0800                	add	s0,sp,16
  initlock(&tickslock, "time");
    80001b86:	00009597          	auipc	a1,0x9
    80001b8a:	6ca58593          	add	a1,a1,1738 # 8000b250 <etext+0x250>
    80001b8e:	00022517          	auipc	a0,0x22
    80001b92:	2fa50513          	add	a0,a0,762 # 80023e88 <tickslock>
    80001b96:	00008097          	auipc	ra,0x8
    80001b9a:	c4c080e7          	jalr	-948(ra) # 800097e2 <initlock>
}
    80001b9e:	60a2                	ld	ra,8(sp)
    80001ba0:	6402                	ld	s0,0(sp)
    80001ba2:	0141                	add	sp,sp,16
    80001ba4:	8082                	ret

0000000080001ba6 <trapinithart>:

// set up to take exceptions and traps while in the kernel.
void
trapinithart(void)
{
    80001ba6:	1141                	add	sp,sp,-16
    80001ba8:	e422                	sd	s0,8(sp)
    80001baa:	0800                	add	s0,sp,16
  asm volatile("csrw stvec, %0" : : "r" (x));
    80001bac:	00004797          	auipc	a5,0x4
    80001bb0:	aa478793          	add	a5,a5,-1372 # 80005650 <kernelvec>
    80001bb4:	10579073          	csrw	stvec,a5
  w_stvec((uint64)kernelvec);
}
    80001bb8:	6422                	ld	s0,8(sp)
    80001bba:	0141                	add	sp,sp,16
    80001bbc:	8082                	ret

0000000080001bbe <usertrapret>:
//
// return to user space
//
void
usertrapret(void)
{
    80001bbe:	1141                	add	sp,sp,-16
    80001bc0:	e406                	sd	ra,8(sp)
    80001bc2:	e022                	sd	s0,0(sp)
    80001bc4:	0800                	add	s0,sp,16
  struct proc *p = myproc();
    80001bc6:	fffff097          	auipc	ra,0xfffff
    80001bca:	380080e7          	jalr	896(ra) # 80000f46 <myproc>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80001bce:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() & ~SSTATUS_SIE);
    80001bd2:	9bf5                	and	a5,a5,-3
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80001bd4:	10079073          	csrw	sstatus,a5
  // kerneltrap() to usertrap(), so turn off interrupts until
  // we're back in user space, where usertrap() is correct.
  intr_off();

  // send syscalls, interrupts, and exceptions to trampoline.S
  w_stvec(TRAMPOLINE + (uservec - trampoline));
    80001bd8:	00008697          	auipc	a3,0x8
    80001bdc:	42868693          	add	a3,a3,1064 # 8000a000 <_trampoline>
    80001be0:	00008717          	auipc	a4,0x8
    80001be4:	42070713          	add	a4,a4,1056 # 8000a000 <_trampoline>
    80001be8:	8f15                	sub	a4,a4,a3
    80001bea:	040007b7          	lui	a5,0x4000
    80001bee:	17fd                	add	a5,a5,-1 # 3ffffff <_entry-0x7c000001>
    80001bf0:	07b2                	sll	a5,a5,0xc
    80001bf2:	973e                	add	a4,a4,a5
  asm volatile("csrw stvec, %0" : : "r" (x));
    80001bf4:	10571073          	csrw	stvec,a4

  // set up trapframe values that uservec will need when
  // the process next re-enters the kernel.
  p->trapframe->kernel_satp = r_satp();         // kernel page table
    80001bf8:	6d38                	ld	a4,88(a0)
  asm volatile("csrr %0, satp" : "=r" (x) );
    80001bfa:	18002673          	csrr	a2,satp
    80001bfe:	e310                	sd	a2,0(a4)
  p->trapframe->kernel_sp = p->kstack + PGSIZE; // process's kernel stack
    80001c00:	6d30                	ld	a2,88(a0)
    80001c02:	6138                	ld	a4,64(a0)
    80001c04:	6585                	lui	a1,0x1
    80001c06:	972e                	add	a4,a4,a1
    80001c08:	e618                	sd	a4,8(a2)
  p->trapframe->kernel_trap = (uint64)usertrap;
    80001c0a:	6d38                	ld	a4,88(a0)
    80001c0c:	00000617          	auipc	a2,0x0
    80001c10:	16860613          	add	a2,a2,360 # 80001d74 <usertrap>
    80001c14:	eb10                	sd	a2,16(a4)
  p->trapframe->kernel_hartid = r_tp();         // hartid for cpuid()
    80001c16:	6d38                	ld	a4,88(a0)
  asm volatile("mv %0, tp" : "=r" (x) );
    80001c18:	8612                	mv	a2,tp
    80001c1a:	f310                	sd	a2,32(a4)
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80001c1c:	10002773          	csrr	a4,sstatus
  // set up the registers that trampoline.S's sret will use
  // to get to user space.
  
  // set S Previous Privilege mode to User.
  unsigned long x = r_sstatus();
  x &= ~SSTATUS_SPP; // clear SPP to 0 for user mode
    80001c20:	eff77713          	and	a4,a4,-257
  x |= SSTATUS_SPIE; // enable interrupts in user mode
    80001c24:	02076713          	or	a4,a4,32
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80001c28:	10071073          	csrw	sstatus,a4
  w_sstatus(x);

  // set S Exception Program Counter to the saved user pc.
  w_sepc(p->trapframe->epc);
    80001c2c:	6d38                	ld	a4,88(a0)
  asm volatile("csrw sepc, %0" : : "r" (x));
    80001c2e:	6f18                	ld	a4,24(a4)
    80001c30:	14171073          	csrw	sepc,a4

  // tell trampoline.S the user page table to switch to.
  uint64 satp = MAKE_SATP(p->pagetable);
    80001c34:	692c                	ld	a1,80(a0)
    80001c36:	81b1                	srl	a1,a1,0xc

  // jump to trampoline.S at the top of memory, which 
  // switches to the user page table, restores user registers,
  // and switches to user mode with sret.
  uint64 fn = TRAMPOLINE + (userret - trampoline);
    80001c38:	00008717          	auipc	a4,0x8
    80001c3c:	45870713          	add	a4,a4,1112 # 8000a090 <userret>
    80001c40:	8f15                	sub	a4,a4,a3
    80001c42:	97ba                	add	a5,a5,a4
  ((void (*)(uint64,uint64))fn)(TRAPFRAME, satp);
    80001c44:	577d                	li	a4,-1
    80001c46:	177e                	sll	a4,a4,0x3f
    80001c48:	8dd9                	or	a1,a1,a4
    80001c4a:	02000537          	lui	a0,0x2000
    80001c4e:	157d                	add	a0,a0,-1 # 1ffffff <_entry-0x7e000001>
    80001c50:	0536                	sll	a0,a0,0xd
    80001c52:	9782                	jalr	a5
}
    80001c54:	60a2                	ld	ra,8(sp)
    80001c56:	6402                	ld	s0,0(sp)
    80001c58:	0141                	add	sp,sp,16
    80001c5a:	8082                	ret

0000000080001c5c <clockintr>:
  w_sstatus(sstatus);
}

void
clockintr()
{
    80001c5c:	1101                	add	sp,sp,-32
    80001c5e:	ec06                	sd	ra,24(sp)
    80001c60:	e822                	sd	s0,16(sp)
    80001c62:	e426                	sd	s1,8(sp)
    80001c64:	1000                	add	s0,sp,32
  acquire(&tickslock);
    80001c66:	00022497          	auipc	s1,0x22
    80001c6a:	22248493          	add	s1,s1,546 # 80023e88 <tickslock>
    80001c6e:	8526                	mv	a0,s1
    80001c70:	00008097          	auipc	ra,0x8
    80001c74:	c02080e7          	jalr	-1022(ra) # 80009872 <acquire>
  ticks++;
    80001c78:	0000a517          	auipc	a0,0xa
    80001c7c:	3a050513          	add	a0,a0,928 # 8000c018 <ticks>
    80001c80:	411c                	lw	a5,0(a0)
    80001c82:	2785                	addw	a5,a5,1
    80001c84:	c11c                	sw	a5,0(a0)
  wakeup(&ticks);
    80001c86:	00000097          	auipc	ra,0x0
    80001c8a:	c58080e7          	jalr	-936(ra) # 800018de <wakeup>
  release(&tickslock);
    80001c8e:	8526                	mv	a0,s1
    80001c90:	00008097          	auipc	ra,0x8
    80001c94:	ca8080e7          	jalr	-856(ra) # 80009938 <release>
}
    80001c98:	60e2                	ld	ra,24(sp)
    80001c9a:	6442                	ld	s0,16(sp)
    80001c9c:	64a2                	ld	s1,8(sp)
    80001c9e:	6105                	add	sp,sp,32
    80001ca0:	8082                	ret

0000000080001ca2 <devintr>:
  asm volatile("csrr %0, scause" : "=r" (x) );
    80001ca2:	142027f3          	csrr	a5,scause
    // the SSIP bit in sip.
    w_sip(r_sip() & ~2);

    return 2;
  } else {
    return 0;
    80001ca6:	4501                	li	a0,0
  if((scause & 0x8000000000000000L) &&
    80001ca8:	0c07d563          	bgez	a5,80001d72 <devintr+0xd0>
{
    80001cac:	1101                	add	sp,sp,-32
    80001cae:	ec06                	sd	ra,24(sp)
    80001cb0:	e822                	sd	s0,16(sp)
    80001cb2:	1000                	add	s0,sp,32
     (scause & 0xff) == 9){
    80001cb4:	0ff7f713          	zext.b	a4,a5
  if((scause & 0x8000000000000000L) &&
    80001cb8:	46a5                	li	a3,9
    80001cba:	00d70c63          	beq	a4,a3,80001cd2 <devintr+0x30>
  } else if(scause == 0x8000000000000001L){
    80001cbe:	577d                	li	a4,-1
    80001cc0:	177e                	sll	a4,a4,0x3f
    80001cc2:	0705                	add	a4,a4,1
    return 0;
    80001cc4:	4501                	li	a0,0
  } else if(scause == 0x8000000000000001L){
    80001cc6:	06e78a63          	beq	a5,a4,80001d3a <devintr+0x98>
  }
}
    80001cca:	60e2                	ld	ra,24(sp)
    80001ccc:	6442                	ld	s0,16(sp)
    80001cce:	6105                	add	sp,sp,32
    80001cd0:	8082                	ret
    80001cd2:	e426                	sd	s1,8(sp)
    int irq = plic_claim();
    80001cd4:	00004097          	auipc	ra,0x4
    80001cd8:	aa2080e7          	jalr	-1374(ra) # 80005776 <plic_claim>
    80001cdc:	84aa                	mv	s1,a0
    if(irq == UART0_IRQ){
    80001cde:	47a9                	li	a5,10
    80001ce0:	00f50d63          	beq	a0,a5,80001cfa <devintr+0x58>
    } else if(irq == VIRTIO0_IRQ){
    80001ce4:	4785                	li	a5,1
    80001ce6:	02f50663          	beq	a0,a5,80001d12 <devintr+0x70>
    else if(irq == E1000_IRQ){
    80001cea:	02100793          	li	a5,33
    80001cee:	02f50763          	beq	a0,a5,80001d1c <devintr+0x7a>
    return 1;
    80001cf2:	4505                	li	a0,1
    else if(irq){
    80001cf4:	e88d                	bnez	s1,80001d26 <devintr+0x84>
    80001cf6:	64a2                	ld	s1,8(sp)
    80001cf8:	bfc9                	j	80001cca <devintr+0x28>
      uartintr();
    80001cfa:	00008097          	auipc	ra,0x8
    80001cfe:	a98080e7          	jalr	-1384(ra) # 80009792 <uartintr>
      plic_complete(irq);
    80001d02:	8526                	mv	a0,s1
    80001d04:	00004097          	auipc	ra,0x4
    80001d08:	a96080e7          	jalr	-1386(ra) # 8000579a <plic_complete>
    return 1;
    80001d0c:	4505                	li	a0,1
    80001d0e:	64a2                	ld	s1,8(sp)
    80001d10:	bf6d                	j	80001cca <devintr+0x28>
      virtio_disk_intr();
    80001d12:	00004097          	auipc	ra,0x4
    80001d16:	f38080e7          	jalr	-200(ra) # 80005c4a <virtio_disk_intr>
    if(irq)
    80001d1a:	b7e5                	j	80001d02 <devintr+0x60>
      e1000_intr();
    80001d1c:	00004097          	auipc	ra,0x4
    80001d20:	2aa080e7          	jalr	682(ra) # 80005fc6 <e1000_intr>
    if(irq)
    80001d24:	bff9                	j	80001d02 <devintr+0x60>
      printf("unexpected interrupt irq=%d\n", irq);
    80001d26:	85a6                	mv	a1,s1
    80001d28:	00009517          	auipc	a0,0x9
    80001d2c:	53050513          	add	a0,a0,1328 # 8000b258 <etext+0x258>
    80001d30:	00007097          	auipc	ra,0x7
    80001d34:	5f2080e7          	jalr	1522(ra) # 80009322 <printf>
    if(irq)
    80001d38:	b7e9                	j	80001d02 <devintr+0x60>
    if(cpuid() == 0){
    80001d3a:	fffff097          	auipc	ra,0xfffff
    80001d3e:	1e0080e7          	jalr	480(ra) # 80000f1a <cpuid>
    80001d42:	ed01                	bnez	a0,80001d5a <devintr+0xb8>
      clockintr();
    80001d44:	00000097          	auipc	ra,0x0
    80001d48:	f18080e7          	jalr	-232(ra) # 80001c5c <clockintr>
  asm volatile("csrr %0, sip" : "=r" (x) );
    80001d4c:	144027f3          	csrr	a5,sip
    w_sip(r_sip() & ~2);
    80001d50:	9bf5                	and	a5,a5,-3
  asm volatile("csrw sip, %0" : : "r" (x));
    80001d52:	14479073          	csrw	sip,a5
    return 2;
    80001d56:	4509                	li	a0,2
    80001d58:	bf8d                	j	80001cca <devintr+0x28>
    }else if(cpuid() == 1) {
    80001d5a:	fffff097          	auipc	ra,0xfffff
    80001d5e:	1c0080e7          	jalr	448(ra) # 80000f1a <cpuid>
    80001d62:	4785                	li	a5,1
    80001d64:	fef514e3          	bne	a0,a5,80001d4c <devintr+0xaa>
      timers_exe_all();
    80001d68:	00007097          	auipc	ra,0x7
    80001d6c:	f5a080e7          	jalr	-166(ra) # 80008cc2 <timers_exe_all>
    80001d70:	bff1                	j	80001d4c <devintr+0xaa>
}
    80001d72:	8082                	ret

0000000080001d74 <usertrap>:
{
    80001d74:	1101                	add	sp,sp,-32
    80001d76:	ec06                	sd	ra,24(sp)
    80001d78:	e822                	sd	s0,16(sp)
    80001d7a:	e426                	sd	s1,8(sp)
    80001d7c:	e04a                	sd	s2,0(sp)
    80001d7e:	1000                	add	s0,sp,32
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80001d80:	100027f3          	csrr	a5,sstatus
  if((r_sstatus() & SSTATUS_SPP) != 0)
    80001d84:	1007f793          	and	a5,a5,256
    80001d88:	e3b9                	bnez	a5,80001dce <usertrap+0x5a>
  asm volatile("csrw stvec, %0" : : "r" (x));
    80001d8a:	00004797          	auipc	a5,0x4
    80001d8e:	8c678793          	add	a5,a5,-1850 # 80005650 <kernelvec>
    80001d92:	10579073          	csrw	stvec,a5
  struct proc *p = myproc();
    80001d96:	fffff097          	auipc	ra,0xfffff
    80001d9a:	1b0080e7          	jalr	432(ra) # 80000f46 <myproc>
    80001d9e:	84aa                	mv	s1,a0
  p->trapframe->epc = r_sepc();
    80001da0:	6d3c                	ld	a5,88(a0)
  asm volatile("csrr %0, sepc" : "=r" (x) );
    80001da2:	14102773          	csrr	a4,sepc
    80001da6:	ef98                	sd	a4,24(a5)
  asm volatile("csrr %0, scause" : "=r" (x) );
    80001da8:	14202773          	csrr	a4,scause
  if(r_scause() == 8){
    80001dac:	47a1                	li	a5,8
    80001dae:	02f70863          	beq	a4,a5,80001dde <usertrap+0x6a>
  } else if((which_dev = devintr()) != 0){
    80001db2:	00000097          	auipc	ra,0x0
    80001db6:	ef0080e7          	jalr	-272(ra) # 80001ca2 <devintr>
    80001dba:	892a                	mv	s2,a0
    80001dbc:	c551                	beqz	a0,80001e48 <usertrap+0xd4>
  if(lockfree_read4(&p->killed))
    80001dbe:	03048513          	add	a0,s1,48
    80001dc2:	00008097          	auipc	ra,0x8
    80001dc6:	be6080e7          	jalr	-1050(ra) # 800099a8 <lockfree_read4>
    80001dca:	cd21                	beqz	a0,80001e22 <usertrap+0xae>
    80001dcc:	a0b1                	j	80001e18 <usertrap+0xa4>
    panic("usertrap: not from user mode");
    80001dce:	00009517          	auipc	a0,0x9
    80001dd2:	4aa50513          	add	a0,a0,1194 # 8000b278 <etext+0x278>
    80001dd6:	00007097          	auipc	ra,0x7
    80001dda:	502080e7          	jalr	1282(ra) # 800092d8 <panic>
    if(lockfree_read4(&p->killed))
    80001dde:	03050513          	add	a0,a0,48
    80001de2:	00008097          	auipc	ra,0x8
    80001de6:	bc6080e7          	jalr	-1082(ra) # 800099a8 <lockfree_read4>
    80001dea:	e929                	bnez	a0,80001e3c <usertrap+0xc8>
    p->trapframe->epc += 4;
    80001dec:	6cb8                	ld	a4,88(s1)
    80001dee:	6f1c                	ld	a5,24(a4)
    80001df0:	0791                	add	a5,a5,4
    80001df2:	ef1c                	sd	a5,24(a4)
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80001df4:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() | SSTATUS_SIE);
    80001df8:	0027e793          	or	a5,a5,2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80001dfc:	10079073          	csrw	sstatus,a5
    syscall();
    80001e00:	00000097          	auipc	ra,0x0
    80001e04:	2c8080e7          	jalr	712(ra) # 800020c8 <syscall>
  if(lockfree_read4(&p->killed))
    80001e08:	03048513          	add	a0,s1,48
    80001e0c:	00008097          	auipc	ra,0x8
    80001e10:	b9c080e7          	jalr	-1124(ra) # 800099a8 <lockfree_read4>
    80001e14:	c911                	beqz	a0,80001e28 <usertrap+0xb4>
    80001e16:	4901                	li	s2,0
    exit(-1);
    80001e18:	557d                	li	a0,-1
    80001e1a:	fffff097          	auipc	ra,0xfffff
    80001e1e:	7fe080e7          	jalr	2046(ra) # 80001618 <exit>
  if(which_dev == 2)
    80001e22:	4789                	li	a5,2
    80001e24:	04f90c63          	beq	s2,a5,80001e7c <usertrap+0x108>
  usertrapret();
    80001e28:	00000097          	auipc	ra,0x0
    80001e2c:	d96080e7          	jalr	-618(ra) # 80001bbe <usertrapret>
}
    80001e30:	60e2                	ld	ra,24(sp)
    80001e32:	6442                	ld	s0,16(sp)
    80001e34:	64a2                	ld	s1,8(sp)
    80001e36:	6902                	ld	s2,0(sp)
    80001e38:	6105                	add	sp,sp,32
    80001e3a:	8082                	ret
      exit(-1);
    80001e3c:	557d                	li	a0,-1
    80001e3e:	fffff097          	auipc	ra,0xfffff
    80001e42:	7da080e7          	jalr	2010(ra) # 80001618 <exit>
    80001e46:	b75d                	j	80001dec <usertrap+0x78>
  asm volatile("csrr %0, scause" : "=r" (x) );
    80001e48:	142025f3          	csrr	a1,scause
    printf("usertrap(): unexpected scause %p pid=%d\n", r_scause(), p->pid);
    80001e4c:	5c90                	lw	a2,56(s1)
    80001e4e:	00009517          	auipc	a0,0x9
    80001e52:	44a50513          	add	a0,a0,1098 # 8000b298 <etext+0x298>
    80001e56:	00007097          	auipc	ra,0x7
    80001e5a:	4cc080e7          	jalr	1228(ra) # 80009322 <printf>
  asm volatile("csrr %0, sepc" : "=r" (x) );
    80001e5e:	141025f3          	csrr	a1,sepc
  asm volatile("csrr %0, stval" : "=r" (x) );
    80001e62:	14302673          	csrr	a2,stval
    printf("            sepc=%p stval=%p\n", r_sepc(), r_stval());
    80001e66:	00009517          	auipc	a0,0x9
    80001e6a:	46250513          	add	a0,a0,1122 # 8000b2c8 <etext+0x2c8>
    80001e6e:	00007097          	auipc	ra,0x7
    80001e72:	4b4080e7          	jalr	1204(ra) # 80009322 <printf>
    p->killed = 1;
    80001e76:	4785                	li	a5,1
    80001e78:	d89c                	sw	a5,48(s1)
    80001e7a:	b779                	j	80001e08 <usertrap+0x94>
    yield();
    80001e7c:	00000097          	auipc	ra,0x0
    80001e80:	8a6080e7          	jalr	-1882(ra) # 80001722 <yield>
    80001e84:	b755                	j	80001e28 <usertrap+0xb4>

0000000080001e86 <kerneltrap>:
{
    80001e86:	7179                	add	sp,sp,-48
    80001e88:	f406                	sd	ra,40(sp)
    80001e8a:	f022                	sd	s0,32(sp)
    80001e8c:	ec26                	sd	s1,24(sp)
    80001e8e:	e84a                	sd	s2,16(sp)
    80001e90:	e44e                	sd	s3,8(sp)
    80001e92:	1800                	add	s0,sp,48
  asm volatile("csrr %0, sepc" : "=r" (x) );
    80001e94:	14102973          	csrr	s2,sepc
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80001e98:	100024f3          	csrr	s1,sstatus
  asm volatile("csrr %0, scause" : "=r" (x) );
    80001e9c:	142029f3          	csrr	s3,scause
  if((sstatus & SSTATUS_SPP) == 0)
    80001ea0:	1004f793          	and	a5,s1,256
    80001ea4:	cb85                	beqz	a5,80001ed4 <kerneltrap+0x4e>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80001ea6:	100027f3          	csrr	a5,sstatus
  return (x & SSTATUS_SIE) != 0;
    80001eaa:	8b89                	and	a5,a5,2
  if(intr_get() != 0)
    80001eac:	ef85                	bnez	a5,80001ee4 <kerneltrap+0x5e>
  if((which_dev = devintr()) == 0){
    80001eae:	00000097          	auipc	ra,0x0
    80001eb2:	df4080e7          	jalr	-524(ra) # 80001ca2 <devintr>
    80001eb6:	cd1d                	beqz	a0,80001ef4 <kerneltrap+0x6e>
  if(which_dev == 2 && myproc() != 0 && myproc()->state == RUNNING)
    80001eb8:	4789                	li	a5,2
    80001eba:	06f50a63          	beq	a0,a5,80001f2e <kerneltrap+0xa8>
  asm volatile("csrw sepc, %0" : : "r" (x));
    80001ebe:	14191073          	csrw	sepc,s2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80001ec2:	10049073          	csrw	sstatus,s1
}
    80001ec6:	70a2                	ld	ra,40(sp)
    80001ec8:	7402                	ld	s0,32(sp)
    80001eca:	64e2                	ld	s1,24(sp)
    80001ecc:	6942                	ld	s2,16(sp)
    80001ece:	69a2                	ld	s3,8(sp)
    80001ed0:	6145                	add	sp,sp,48
    80001ed2:	8082                	ret
    panic("kerneltrap: not from supervisor mode");
    80001ed4:	00009517          	auipc	a0,0x9
    80001ed8:	41450513          	add	a0,a0,1044 # 8000b2e8 <etext+0x2e8>
    80001edc:	00007097          	auipc	ra,0x7
    80001ee0:	3fc080e7          	jalr	1020(ra) # 800092d8 <panic>
    panic("kerneltrap: interrupts enabled");
    80001ee4:	00009517          	auipc	a0,0x9
    80001ee8:	42c50513          	add	a0,a0,1068 # 8000b310 <etext+0x310>
    80001eec:	00007097          	auipc	ra,0x7
    80001ef0:	3ec080e7          	jalr	1004(ra) # 800092d8 <panic>
    printf("scause %p\n", scause);
    80001ef4:	85ce                	mv	a1,s3
    80001ef6:	00009517          	auipc	a0,0x9
    80001efa:	43a50513          	add	a0,a0,1082 # 8000b330 <etext+0x330>
    80001efe:	00007097          	auipc	ra,0x7
    80001f02:	424080e7          	jalr	1060(ra) # 80009322 <printf>
  asm volatile("csrr %0, sepc" : "=r" (x) );
    80001f06:	141025f3          	csrr	a1,sepc
  asm volatile("csrr %0, stval" : "=r" (x) );
    80001f0a:	14302673          	csrr	a2,stval
    printf("sepc=%p stval=%p\n", r_sepc(), r_stval());
    80001f0e:	00009517          	auipc	a0,0x9
    80001f12:	43250513          	add	a0,a0,1074 # 8000b340 <etext+0x340>
    80001f16:	00007097          	auipc	ra,0x7
    80001f1a:	40c080e7          	jalr	1036(ra) # 80009322 <printf>
    panic("kerneltrap");
    80001f1e:	00009517          	auipc	a0,0x9
    80001f22:	43a50513          	add	a0,a0,1082 # 8000b358 <etext+0x358>
    80001f26:	00007097          	auipc	ra,0x7
    80001f2a:	3b2080e7          	jalr	946(ra) # 800092d8 <panic>
  if(which_dev == 2 && myproc() != 0 && myproc()->state == RUNNING)
    80001f2e:	fffff097          	auipc	ra,0xfffff
    80001f32:	018080e7          	jalr	24(ra) # 80000f46 <myproc>
    80001f36:	d541                	beqz	a0,80001ebe <kerneltrap+0x38>
    80001f38:	fffff097          	auipc	ra,0xfffff
    80001f3c:	00e080e7          	jalr	14(ra) # 80000f46 <myproc>
    80001f40:	4d18                	lw	a4,24(a0)
    80001f42:	478d                	li	a5,3
    80001f44:	f6f71de3          	bne	a4,a5,80001ebe <kerneltrap+0x38>
    yield();
    80001f48:	fffff097          	auipc	ra,0xfffff
    80001f4c:	7da080e7          	jalr	2010(ra) # 80001722 <yield>
    80001f50:	b7bd                	j	80001ebe <kerneltrap+0x38>

0000000080001f52 <argraw>:
  return strlen(buf);
}

static uint64
argraw(int n)
{
    80001f52:	1101                	add	sp,sp,-32
    80001f54:	ec06                	sd	ra,24(sp)
    80001f56:	e822                	sd	s0,16(sp)
    80001f58:	e426                	sd	s1,8(sp)
    80001f5a:	1000                	add	s0,sp,32
    80001f5c:	84aa                	mv	s1,a0
  struct proc *p = myproc();
    80001f5e:	fffff097          	auipc	ra,0xfffff
    80001f62:	fe8080e7          	jalr	-24(ra) # 80000f46 <myproc>
  switch (n) {
    80001f66:	4795                	li	a5,5
    80001f68:	0497e163          	bltu	a5,s1,80001faa <argraw+0x58>
    80001f6c:	048a                	sll	s1,s1,0x2
    80001f6e:	0000a717          	auipc	a4,0xa
    80001f72:	9da70713          	add	a4,a4,-1574 # 8000b948 <states.0+0x28>
    80001f76:	94ba                	add	s1,s1,a4
    80001f78:	409c                	lw	a5,0(s1)
    80001f7a:	97ba                	add	a5,a5,a4
    80001f7c:	8782                	jr	a5
  case 0:
    return p->trapframe->a0;
    80001f7e:	6d3c                	ld	a5,88(a0)
    80001f80:	7ba8                	ld	a0,112(a5)
  case 5:
    return p->trapframe->a5;
  }
  panic("argraw");
  return -1;
}
    80001f82:	60e2                	ld	ra,24(sp)
    80001f84:	6442                	ld	s0,16(sp)
    80001f86:	64a2                	ld	s1,8(sp)
    80001f88:	6105                	add	sp,sp,32
    80001f8a:	8082                	ret
    return p->trapframe->a1;
    80001f8c:	6d3c                	ld	a5,88(a0)
    80001f8e:	7fa8                	ld	a0,120(a5)
    80001f90:	bfcd                	j	80001f82 <argraw+0x30>
    return p->trapframe->a2;
    80001f92:	6d3c                	ld	a5,88(a0)
    80001f94:	63c8                	ld	a0,128(a5)
    80001f96:	b7f5                	j	80001f82 <argraw+0x30>
    return p->trapframe->a3;
    80001f98:	6d3c                	ld	a5,88(a0)
    80001f9a:	67c8                	ld	a0,136(a5)
    80001f9c:	b7dd                	j	80001f82 <argraw+0x30>
    return p->trapframe->a4;
    80001f9e:	6d3c                	ld	a5,88(a0)
    80001fa0:	6bc8                	ld	a0,144(a5)
    80001fa2:	b7c5                	j	80001f82 <argraw+0x30>
    return p->trapframe->a5;
    80001fa4:	6d3c                	ld	a5,88(a0)
    80001fa6:	6fc8                	ld	a0,152(a5)
    80001fa8:	bfe9                	j	80001f82 <argraw+0x30>
  panic("argraw");
    80001faa:	00009517          	auipc	a0,0x9
    80001fae:	3be50513          	add	a0,a0,958 # 8000b368 <etext+0x368>
    80001fb2:	00007097          	auipc	ra,0x7
    80001fb6:	326080e7          	jalr	806(ra) # 800092d8 <panic>

0000000080001fba <fetchaddr>:
{
    80001fba:	1101                	add	sp,sp,-32
    80001fbc:	ec06                	sd	ra,24(sp)
    80001fbe:	e822                	sd	s0,16(sp)
    80001fc0:	e426                	sd	s1,8(sp)
    80001fc2:	e04a                	sd	s2,0(sp)
    80001fc4:	1000                	add	s0,sp,32
    80001fc6:	84aa                	mv	s1,a0
    80001fc8:	892e                	mv	s2,a1
  struct proc *p = myproc();
    80001fca:	fffff097          	auipc	ra,0xfffff
    80001fce:	f7c080e7          	jalr	-132(ra) # 80000f46 <myproc>
  if(addr >= p->sz || addr+sizeof(uint64) > p->sz)
    80001fd2:	653c                	ld	a5,72(a0)
    80001fd4:	02f4f863          	bgeu	s1,a5,80002004 <fetchaddr+0x4a>
    80001fd8:	00848713          	add	a4,s1,8
    80001fdc:	02e7e663          	bltu	a5,a4,80002008 <fetchaddr+0x4e>
  if(copyin(p->pagetable, (char *)ip, addr, sizeof(*ip)) != 0)
    80001fe0:	46a1                	li	a3,8
    80001fe2:	8626                	mv	a2,s1
    80001fe4:	85ca                	mv	a1,s2
    80001fe6:	6928                	ld	a0,80(a0)
    80001fe8:	fffff097          	auipc	ra,0xfffff
    80001fec:	c66080e7          	jalr	-922(ra) # 80000c4e <copyin>
    80001ff0:	00a03533          	snez	a0,a0
    80001ff4:	40a00533          	neg	a0,a0
}
    80001ff8:	60e2                	ld	ra,24(sp)
    80001ffa:	6442                	ld	s0,16(sp)
    80001ffc:	64a2                	ld	s1,8(sp)
    80001ffe:	6902                	ld	s2,0(sp)
    80002000:	6105                	add	sp,sp,32
    80002002:	8082                	ret
    return -1;
    80002004:	557d                	li	a0,-1
    80002006:	bfcd                	j	80001ff8 <fetchaddr+0x3e>
    80002008:	557d                	li	a0,-1
    8000200a:	b7fd                	j	80001ff8 <fetchaddr+0x3e>

000000008000200c <fetchstr>:
{
    8000200c:	7179                	add	sp,sp,-48
    8000200e:	f406                	sd	ra,40(sp)
    80002010:	f022                	sd	s0,32(sp)
    80002012:	ec26                	sd	s1,24(sp)
    80002014:	e84a                	sd	s2,16(sp)
    80002016:	e44e                	sd	s3,8(sp)
    80002018:	1800                	add	s0,sp,48
    8000201a:	892a                	mv	s2,a0
    8000201c:	84ae                	mv	s1,a1
    8000201e:	89b2                	mv	s3,a2
  struct proc *p = myproc();
    80002020:	fffff097          	auipc	ra,0xfffff
    80002024:	f26080e7          	jalr	-218(ra) # 80000f46 <myproc>
  int err = copyinstr(p->pagetable, buf, addr, max);
    80002028:	86ce                	mv	a3,s3
    8000202a:	864a                	mv	a2,s2
    8000202c:	85a6                	mv	a1,s1
    8000202e:	6928                	ld	a0,80(a0)
    80002030:	fffff097          	auipc	ra,0xfffff
    80002034:	cac080e7          	jalr	-852(ra) # 80000cdc <copyinstr>
  if(err < 0)
    80002038:	00054763          	bltz	a0,80002046 <fetchstr+0x3a>
  return strlen(buf);
    8000203c:	8526                	mv	a0,s1
    8000203e:	ffffe097          	auipc	ra,0xffffe
    80002042:	2b8080e7          	jalr	696(ra) # 800002f6 <strlen>
}
    80002046:	70a2                	ld	ra,40(sp)
    80002048:	7402                	ld	s0,32(sp)
    8000204a:	64e2                	ld	s1,24(sp)
    8000204c:	6942                	ld	s2,16(sp)
    8000204e:	69a2                	ld	s3,8(sp)
    80002050:	6145                	add	sp,sp,48
    80002052:	8082                	ret

0000000080002054 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
    80002054:	1101                	add	sp,sp,-32
    80002056:	ec06                	sd	ra,24(sp)
    80002058:	e822                	sd	s0,16(sp)
    8000205a:	e426                	sd	s1,8(sp)
    8000205c:	1000                	add	s0,sp,32
    8000205e:	84ae                	mv	s1,a1
  *ip = argraw(n);
    80002060:	00000097          	auipc	ra,0x0
    80002064:	ef2080e7          	jalr	-270(ra) # 80001f52 <argraw>
    80002068:	c088                	sw	a0,0(s1)
  return 0;
}
    8000206a:	4501                	li	a0,0
    8000206c:	60e2                	ld	ra,24(sp)
    8000206e:	6442                	ld	s0,16(sp)
    80002070:	64a2                	ld	s1,8(sp)
    80002072:	6105                	add	sp,sp,32
    80002074:	8082                	ret

0000000080002076 <argaddr>:
// Retrieve an argument as a pointer.
// Doesn't check for legality, since
// copyin/copyout will do that.
int
argaddr(int n, uint64 *ip)
{
    80002076:	1101                	add	sp,sp,-32
    80002078:	ec06                	sd	ra,24(sp)
    8000207a:	e822                	sd	s0,16(sp)
    8000207c:	e426                	sd	s1,8(sp)
    8000207e:	1000                	add	s0,sp,32
    80002080:	84ae                	mv	s1,a1
  *ip = argraw(n);
    80002082:	00000097          	auipc	ra,0x0
    80002086:	ed0080e7          	jalr	-304(ra) # 80001f52 <argraw>
    8000208a:	e088                	sd	a0,0(s1)
  return 0;
}
    8000208c:	4501                	li	a0,0
    8000208e:	60e2                	ld	ra,24(sp)
    80002090:	6442                	ld	s0,16(sp)
    80002092:	64a2                	ld	s1,8(sp)
    80002094:	6105                	add	sp,sp,32
    80002096:	8082                	ret

0000000080002098 <argstr>:
// Fetch the nth word-sized system call argument as a null-terminated string.
// Copies into buf, at most max.
// Returns string length if OK (including nul), -1 if error.
int
argstr(int n, char *buf, int max)
{
    80002098:	1101                	add	sp,sp,-32
    8000209a:	ec06                	sd	ra,24(sp)
    8000209c:	e822                	sd	s0,16(sp)
    8000209e:	e426                	sd	s1,8(sp)
    800020a0:	e04a                	sd	s2,0(sp)
    800020a2:	1000                	add	s0,sp,32
    800020a4:	84ae                	mv	s1,a1
    800020a6:	8932                	mv	s2,a2
  *ip = argraw(n);
    800020a8:	00000097          	auipc	ra,0x0
    800020ac:	eaa080e7          	jalr	-342(ra) # 80001f52 <argraw>
  uint64 addr;
  if(argaddr(n, &addr) < 0)
    return -1;
  return fetchstr(addr, buf, max);
    800020b0:	864a                	mv	a2,s2
    800020b2:	85a6                	mv	a1,s1
    800020b4:	00000097          	auipc	ra,0x0
    800020b8:	f58080e7          	jalr	-168(ra) # 8000200c <fetchstr>
}
    800020bc:	60e2                	ld	ra,24(sp)
    800020be:	6442                	ld	s0,16(sp)
    800020c0:	64a2                	ld	s1,8(sp)
    800020c2:	6902                	ld	s2,0(sp)
    800020c4:	6105                	add	sp,sp,32
    800020c6:	8082                	ret

00000000800020c8 <syscall>:



void
syscall(void)
{
    800020c8:	1101                	add	sp,sp,-32
    800020ca:	ec06                	sd	ra,24(sp)
    800020cc:	e822                	sd	s0,16(sp)
    800020ce:	e426                	sd	s1,8(sp)
    800020d0:	e04a                	sd	s2,0(sp)
    800020d2:	1000                	add	s0,sp,32
  int num;
  struct proc *p = myproc();
    800020d4:	fffff097          	auipc	ra,0xfffff
    800020d8:	e72080e7          	jalr	-398(ra) # 80000f46 <myproc>
    800020dc:	84aa                	mv	s1,a0

  num = p->trapframe->a7;
    800020de:	05853903          	ld	s2,88(a0)
    800020e2:	0a893783          	ld	a5,168(s2)
    800020e6:	0007869b          	sext.w	a3,a5
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
    800020ea:	37fd                	addw	a5,a5,-1
    800020ec:	02100713          	li	a4,33
    800020f0:	00f76f63          	bltu	a4,a5,8000210e <syscall+0x46>
    800020f4:	00369713          	sll	a4,a3,0x3
    800020f8:	0000a797          	auipc	a5,0xa
    800020fc:	86878793          	add	a5,a5,-1944 # 8000b960 <syscalls>
    80002100:	97ba                	add	a5,a5,a4
    80002102:	639c                	ld	a5,0(a5)
    80002104:	c789                	beqz	a5,8000210e <syscall+0x46>
    p->trapframe->a0 = syscalls[num]();
    80002106:	9782                	jalr	a5
    80002108:	06a93823          	sd	a0,112(s2)
    8000210c:	a839                	j	8000212a <syscall+0x62>
  } else {
    printf("%d %s: unknown sys call %d\n",
    8000210e:	5d848613          	add	a2,s1,1496
    80002112:	5c8c                	lw	a1,56(s1)
    80002114:	00009517          	auipc	a0,0x9
    80002118:	25c50513          	add	a0,a0,604 # 8000b370 <etext+0x370>
    8000211c:	00007097          	auipc	ra,0x7
    80002120:	206080e7          	jalr	518(ra) # 80009322 <printf>
            p->pid, p->name, num);
    p->trapframe->a0 = -1;
    80002124:	6cbc                	ld	a5,88(s1)
    80002126:	577d                	li	a4,-1
    80002128:	fbb8                	sd	a4,112(a5)
  }
}
    8000212a:	60e2                	ld	ra,24(sp)
    8000212c:	6442                	ld	s0,16(sp)
    8000212e:	64a2                	ld	s1,8(sp)
    80002130:	6902                	ld	s2,0(sp)
    80002132:	6105                	add	sp,sp,32
    80002134:	8082                	ret

0000000080002136 <sys_exit>:
#include "spinlock.h"
#include "proc.h"

uint64
sys_exit(void)
{
    80002136:	1101                	add	sp,sp,-32
    80002138:	ec06                	sd	ra,24(sp)
    8000213a:	e822                	sd	s0,16(sp)
    8000213c:	1000                	add	s0,sp,32
  int n;
  if(argint(0, &n) < 0)
    8000213e:	fec40593          	add	a1,s0,-20
    80002142:	4501                	li	a0,0
    80002144:	00000097          	auipc	ra,0x0
    80002148:	f10080e7          	jalr	-240(ra) # 80002054 <argint>
    return -1;
    8000214c:	57fd                	li	a5,-1
  if(argint(0, &n) < 0)
    8000214e:	00054963          	bltz	a0,80002160 <sys_exit+0x2a>
  exit(n);
    80002152:	fec42503          	lw	a0,-20(s0)
    80002156:	fffff097          	auipc	ra,0xfffff
    8000215a:	4c2080e7          	jalr	1218(ra) # 80001618 <exit>
  return 0;  // not reached
    8000215e:	4781                	li	a5,0
}
    80002160:	853e                	mv	a0,a5
    80002162:	60e2                	ld	ra,24(sp)
    80002164:	6442                	ld	s0,16(sp)
    80002166:	6105                	add	sp,sp,32
    80002168:	8082                	ret

000000008000216a <sys_getpid>:

uint64
sys_getpid(void)
{
    8000216a:	1141                	add	sp,sp,-16
    8000216c:	e406                	sd	ra,8(sp)
    8000216e:	e022                	sd	s0,0(sp)
    80002170:	0800                	add	s0,sp,16
  return myproc()->pid;
    80002172:	fffff097          	auipc	ra,0xfffff
    80002176:	dd4080e7          	jalr	-556(ra) # 80000f46 <myproc>
}
    8000217a:	5d08                	lw	a0,56(a0)
    8000217c:	60a2                	ld	ra,8(sp)
    8000217e:	6402                	ld	s0,0(sp)
    80002180:	0141                	add	sp,sp,16
    80002182:	8082                	ret

0000000080002184 <sys_fork>:

uint64
sys_fork(void)
{
    80002184:	1141                	add	sp,sp,-16
    80002186:	e406                	sd	ra,8(sp)
    80002188:	e022                	sd	s0,0(sp)
    8000218a:	0800                	add	s0,sp,16
  return fork();
    8000218c:	fffff097          	auipc	ra,0xfffff
    80002190:	17e080e7          	jalr	382(ra) # 8000130a <fork>
}
    80002194:	60a2                	ld	ra,8(sp)
    80002196:	6402                	ld	s0,0(sp)
    80002198:	0141                	add	sp,sp,16
    8000219a:	8082                	ret

000000008000219c <sys_wait>:

uint64
sys_wait(void)
{
    8000219c:	1101                	add	sp,sp,-32
    8000219e:	ec06                	sd	ra,24(sp)
    800021a0:	e822                	sd	s0,16(sp)
    800021a2:	1000                	add	s0,sp,32
  uint64 p;
  if(argaddr(0, &p) < 0)
    800021a4:	fe840593          	add	a1,s0,-24
    800021a8:	4501                	li	a0,0
    800021aa:	00000097          	auipc	ra,0x0
    800021ae:	ecc080e7          	jalr	-308(ra) # 80002076 <argaddr>
    800021b2:	87aa                	mv	a5,a0
    return -1;
    800021b4:	557d                	li	a0,-1
  if(argaddr(0, &p) < 0)
    800021b6:	0007c863          	bltz	a5,800021c6 <sys_wait+0x2a>
  return wait(p);
    800021ba:	fe843503          	ld	a0,-24(s0)
    800021be:	fffff097          	auipc	ra,0xfffff
    800021c2:	61e080e7          	jalr	1566(ra) # 800017dc <wait>
}
    800021c6:	60e2                	ld	ra,24(sp)
    800021c8:	6442                	ld	s0,16(sp)
    800021ca:	6105                	add	sp,sp,32
    800021cc:	8082                	ret

00000000800021ce <sys_sbrk>:

uint64
sys_sbrk(void)
{
    800021ce:	7179                	add	sp,sp,-48
    800021d0:	f406                	sd	ra,40(sp)
    800021d2:	f022                	sd	s0,32(sp)
    800021d4:	1800                	add	s0,sp,48
  int addr;
  int n;

  if(argint(0, &n) < 0)
    800021d6:	fdc40593          	add	a1,s0,-36
    800021da:	4501                	li	a0,0
    800021dc:	00000097          	auipc	ra,0x0
    800021e0:	e78080e7          	jalr	-392(ra) # 80002054 <argint>
    800021e4:	87aa                	mv	a5,a0
    return -1;
    800021e6:	557d                	li	a0,-1
  if(argint(0, &n) < 0)
    800021e8:	0207c263          	bltz	a5,8000220c <sys_sbrk+0x3e>
    800021ec:	ec26                	sd	s1,24(sp)
  addr = myproc()->sz;
    800021ee:	fffff097          	auipc	ra,0xfffff
    800021f2:	d58080e7          	jalr	-680(ra) # 80000f46 <myproc>
    800021f6:	4524                	lw	s1,72(a0)
  if(growproc(n) < 0)
    800021f8:	fdc42503          	lw	a0,-36(s0)
    800021fc:	fffff097          	auipc	ra,0xfffff
    80002200:	096080e7          	jalr	150(ra) # 80001292 <growproc>
    80002204:	00054863          	bltz	a0,80002214 <sys_sbrk+0x46>
    return -1;
  return addr;
    80002208:	8526                	mv	a0,s1
    8000220a:	64e2                	ld	s1,24(sp)
}
    8000220c:	70a2                	ld	ra,40(sp)
    8000220e:	7402                	ld	s0,32(sp)
    80002210:	6145                	add	sp,sp,48
    80002212:	8082                	ret
    return -1;
    80002214:	557d                	li	a0,-1
    80002216:	64e2                	ld	s1,24(sp)
    80002218:	bfd5                	j	8000220c <sys_sbrk+0x3e>

000000008000221a <sys_sleep>:

uint64
sys_sleep(void)
{
    8000221a:	7139                	add	sp,sp,-64
    8000221c:	fc06                	sd	ra,56(sp)
    8000221e:	f822                	sd	s0,48(sp)
    80002220:	0080                	add	s0,sp,64
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
    80002222:	fcc40593          	add	a1,s0,-52
    80002226:	4501                	li	a0,0
    80002228:	00000097          	auipc	ra,0x0
    8000222c:	e2c080e7          	jalr	-468(ra) # 80002054 <argint>
    return -1;
    80002230:	57fd                	li	a5,-1
  if(argint(0, &n) < 0)
    80002232:	06054b63          	bltz	a0,800022a8 <sys_sleep+0x8e>
    80002236:	f04a                	sd	s2,32(sp)
  acquire(&tickslock);
    80002238:	00022517          	auipc	a0,0x22
    8000223c:	c5050513          	add	a0,a0,-944 # 80023e88 <tickslock>
    80002240:	00007097          	auipc	ra,0x7
    80002244:	632080e7          	jalr	1586(ra) # 80009872 <acquire>
  ticks0 = ticks;
    80002248:	0000a917          	auipc	s2,0xa
    8000224c:	dd092903          	lw	s2,-560(s2) # 8000c018 <ticks>
  while(ticks - ticks0 < n){
    80002250:	fcc42783          	lw	a5,-52(s0)
    80002254:	c3a1                	beqz	a5,80002294 <sys_sleep+0x7a>
    80002256:	f426                	sd	s1,40(sp)
    80002258:	ec4e                	sd	s3,24(sp)
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
    8000225a:	00022997          	auipc	s3,0x22
    8000225e:	c2e98993          	add	s3,s3,-978 # 80023e88 <tickslock>
    80002262:	0000a497          	auipc	s1,0xa
    80002266:	db648493          	add	s1,s1,-586 # 8000c018 <ticks>
    if(myproc()->killed){
    8000226a:	fffff097          	auipc	ra,0xfffff
    8000226e:	cdc080e7          	jalr	-804(ra) # 80000f46 <myproc>
    80002272:	591c                	lw	a5,48(a0)
    80002274:	ef9d                	bnez	a5,800022b2 <sys_sleep+0x98>
    sleep(&ticks, &tickslock);
    80002276:	85ce                	mv	a1,s3
    80002278:	8526                	mv	a0,s1
    8000227a:	fffff097          	auipc	ra,0xfffff
    8000227e:	4e4080e7          	jalr	1252(ra) # 8000175e <sleep>
  while(ticks - ticks0 < n){
    80002282:	409c                	lw	a5,0(s1)
    80002284:	412787bb          	subw	a5,a5,s2
    80002288:	fcc42703          	lw	a4,-52(s0)
    8000228c:	fce7efe3          	bltu	a5,a4,8000226a <sys_sleep+0x50>
    80002290:	74a2                	ld	s1,40(sp)
    80002292:	69e2                	ld	s3,24(sp)
  }
  release(&tickslock);
    80002294:	00022517          	auipc	a0,0x22
    80002298:	bf450513          	add	a0,a0,-1036 # 80023e88 <tickslock>
    8000229c:	00007097          	auipc	ra,0x7
    800022a0:	69c080e7          	jalr	1692(ra) # 80009938 <release>
  return 0;
    800022a4:	4781                	li	a5,0
    800022a6:	7902                	ld	s2,32(sp)
}
    800022a8:	853e                	mv	a0,a5
    800022aa:	70e2                	ld	ra,56(sp)
    800022ac:	7442                	ld	s0,48(sp)
    800022ae:	6121                	add	sp,sp,64
    800022b0:	8082                	ret
      release(&tickslock);
    800022b2:	00022517          	auipc	a0,0x22
    800022b6:	bd650513          	add	a0,a0,-1066 # 80023e88 <tickslock>
    800022ba:	00007097          	auipc	ra,0x7
    800022be:	67e080e7          	jalr	1662(ra) # 80009938 <release>
      return -1;
    800022c2:	57fd                	li	a5,-1
    800022c4:	74a2                	ld	s1,40(sp)
    800022c6:	7902                	ld	s2,32(sp)
    800022c8:	69e2                	ld	s3,24(sp)
    800022ca:	bff9                	j	800022a8 <sys_sleep+0x8e>

00000000800022cc <sys_kill>:

uint64
sys_kill(void)
{
    800022cc:	1101                	add	sp,sp,-32
    800022ce:	ec06                	sd	ra,24(sp)
    800022d0:	e822                	sd	s0,16(sp)
    800022d2:	1000                	add	s0,sp,32
  int pid;

  if(argint(0, &pid) < 0)
    800022d4:	fec40593          	add	a1,s0,-20
    800022d8:	4501                	li	a0,0
    800022da:	00000097          	auipc	ra,0x0
    800022de:	d7a080e7          	jalr	-646(ra) # 80002054 <argint>
    800022e2:	87aa                	mv	a5,a0
    return -1;
    800022e4:	557d                	li	a0,-1
  if(argint(0, &pid) < 0)
    800022e6:	0007c863          	bltz	a5,800022f6 <sys_kill+0x2a>
  return kill(pid);
    800022ea:	fec42503          	lw	a0,-20(s0)
    800022ee:	fffff097          	auipc	ra,0xfffff
    800022f2:	65a080e7          	jalr	1626(ra) # 80001948 <kill>
}
    800022f6:	60e2                	ld	ra,24(sp)
    800022f8:	6442                	ld	s0,16(sp)
    800022fa:	6105                	add	sp,sp,32
    800022fc:	8082                	ret

00000000800022fe <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
uint64
sys_uptime(void)
{
    800022fe:	1101                	add	sp,sp,-32
    80002300:	ec06                	sd	ra,24(sp)
    80002302:	e822                	sd	s0,16(sp)
    80002304:	e426                	sd	s1,8(sp)
    80002306:	1000                	add	s0,sp,32
  uint xticks;

  acquire(&tickslock);
    80002308:	00022517          	auipc	a0,0x22
    8000230c:	b8050513          	add	a0,a0,-1152 # 80023e88 <tickslock>
    80002310:	00007097          	auipc	ra,0x7
    80002314:	562080e7          	jalr	1378(ra) # 80009872 <acquire>
  xticks = ticks;
    80002318:	0000a497          	auipc	s1,0xa
    8000231c:	d004a483          	lw	s1,-768(s1) # 8000c018 <ticks>
  release(&tickslock);
    80002320:	00022517          	auipc	a0,0x22
    80002324:	b6850513          	add	a0,a0,-1176 # 80023e88 <tickslock>
    80002328:	00007097          	auipc	ra,0x7
    8000232c:	610080e7          	jalr	1552(ra) # 80009938 <release>
  return xticks;
}
    80002330:	02049513          	sll	a0,s1,0x20
    80002334:	9101                	srl	a0,a0,0x20
    80002336:	60e2                	ld	ra,24(sp)
    80002338:	6442                	ld	s0,16(sp)
    8000233a:	64a2                	ld	s1,8(sp)
    8000233c:	6105                	add	sp,sp,32
    8000233e:	8082                	ret

0000000080002340 <binit>:
  struct buf head;
} bcache;

void
binit(void)
{
    80002340:	7179                	add	sp,sp,-48
    80002342:	f406                	sd	ra,40(sp)
    80002344:	f022                	sd	s0,32(sp)
    80002346:	ec26                	sd	s1,24(sp)
    80002348:	e84a                	sd	s2,16(sp)
    8000234a:	e44e                	sd	s3,8(sp)
    8000234c:	e052                	sd	s4,0(sp)
    8000234e:	1800                	add	s0,sp,48
  struct buf *b;

  initlock(&bcache.lock, "bcache");
    80002350:	00009597          	auipc	a1,0x9
    80002354:	04058593          	add	a1,a1,64 # 8000b390 <etext+0x390>
    80002358:	00022517          	auipc	a0,0x22
    8000235c:	b4850513          	add	a0,a0,-1208 # 80023ea0 <bcache>
    80002360:	00007097          	auipc	ra,0x7
    80002364:	482080e7          	jalr	1154(ra) # 800097e2 <initlock>

  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
    80002368:	0002a797          	auipc	a5,0x2a
    8000236c:	b3878793          	add	a5,a5,-1224 # 8002bea0 <bcache+0x8000>
    80002370:	0002a717          	auipc	a4,0x2a
    80002374:	d9870713          	add	a4,a4,-616 # 8002c108 <bcache+0x8268>
    80002378:	2ae7b823          	sd	a4,688(a5)
  bcache.head.next = &bcache.head;
    8000237c:	2ae7bc23          	sd	a4,696(a5)
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
    80002380:	00022497          	auipc	s1,0x22
    80002384:	b3848493          	add	s1,s1,-1224 # 80023eb8 <bcache+0x18>
    b->next = bcache.head.next;
    80002388:	893e                	mv	s2,a5
    b->prev = &bcache.head;
    8000238a:	89ba                	mv	s3,a4
    initsleeplock(&b->lock, "buffer");
    8000238c:	00009a17          	auipc	s4,0x9
    80002390:	00ca0a13          	add	s4,s4,12 # 8000b398 <etext+0x398>
    b->next = bcache.head.next;
    80002394:	2b893783          	ld	a5,696(s2)
    80002398:	e8bc                	sd	a5,80(s1)
    b->prev = &bcache.head;
    8000239a:	0534b423          	sd	s3,72(s1)
    initsleeplock(&b->lock, "buffer");
    8000239e:	85d2                	mv	a1,s4
    800023a0:	01048513          	add	a0,s1,16
    800023a4:	00001097          	auipc	ra,0x1
    800023a8:	4ba080e7          	jalr	1210(ra) # 8000385e <initsleeplock>
    bcache.head.next->prev = b;
    800023ac:	2b893783          	ld	a5,696(s2)
    800023b0:	e7a4                	sd	s1,72(a5)
    bcache.head.next = b;
    800023b2:	2a993c23          	sd	s1,696(s2)
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
    800023b6:	45848493          	add	s1,s1,1112
    800023ba:	fd349de3          	bne	s1,s3,80002394 <binit+0x54>
  }
}
    800023be:	70a2                	ld	ra,40(sp)
    800023c0:	7402                	ld	s0,32(sp)
    800023c2:	64e2                	ld	s1,24(sp)
    800023c4:	6942                	ld	s2,16(sp)
    800023c6:	69a2                	ld	s3,8(sp)
    800023c8:	6a02                	ld	s4,0(sp)
    800023ca:	6145                	add	sp,sp,48
    800023cc:	8082                	ret

00000000800023ce <bread>:
}

// Return a locked buf with the contents of the indicated block.
struct buf*
bread(uint dev, uint blockno)
{
    800023ce:	7179                	add	sp,sp,-48
    800023d0:	f406                	sd	ra,40(sp)
    800023d2:	f022                	sd	s0,32(sp)
    800023d4:	ec26                	sd	s1,24(sp)
    800023d6:	e84a                	sd	s2,16(sp)
    800023d8:	e44e                	sd	s3,8(sp)
    800023da:	1800                	add	s0,sp,48
    800023dc:	892a                	mv	s2,a0
    800023de:	89ae                	mv	s3,a1
  acquire(&bcache.lock);
    800023e0:	00022517          	auipc	a0,0x22
    800023e4:	ac050513          	add	a0,a0,-1344 # 80023ea0 <bcache>
    800023e8:	00007097          	auipc	ra,0x7
    800023ec:	48a080e7          	jalr	1162(ra) # 80009872 <acquire>
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
    800023f0:	0002a497          	auipc	s1,0x2a
    800023f4:	d684b483          	ld	s1,-664(s1) # 8002c158 <bcache+0x82b8>
    800023f8:	0002a797          	auipc	a5,0x2a
    800023fc:	d1078793          	add	a5,a5,-752 # 8002c108 <bcache+0x8268>
    80002400:	02f48f63          	beq	s1,a5,8000243e <bread+0x70>
    80002404:	873e                	mv	a4,a5
    80002406:	a021                	j	8000240e <bread+0x40>
    80002408:	68a4                	ld	s1,80(s1)
    8000240a:	02e48a63          	beq	s1,a4,8000243e <bread+0x70>
    if(b->dev == dev && b->blockno == blockno){
    8000240e:	449c                	lw	a5,8(s1)
    80002410:	ff279ce3          	bne	a5,s2,80002408 <bread+0x3a>
    80002414:	44dc                	lw	a5,12(s1)
    80002416:	ff3799e3          	bne	a5,s3,80002408 <bread+0x3a>
      b->refcnt++;
    8000241a:	40bc                	lw	a5,64(s1)
    8000241c:	2785                	addw	a5,a5,1
    8000241e:	c0bc                	sw	a5,64(s1)
      release(&bcache.lock);
    80002420:	00022517          	auipc	a0,0x22
    80002424:	a8050513          	add	a0,a0,-1408 # 80023ea0 <bcache>
    80002428:	00007097          	auipc	ra,0x7
    8000242c:	510080e7          	jalr	1296(ra) # 80009938 <release>
      acquiresleep(&b->lock);
    80002430:	01048513          	add	a0,s1,16
    80002434:	00001097          	auipc	ra,0x1
    80002438:	464080e7          	jalr	1124(ra) # 80003898 <acquiresleep>
      return b;
    8000243c:	a8b9                	j	8000249a <bread+0xcc>
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
    8000243e:	0002a497          	auipc	s1,0x2a
    80002442:	d124b483          	ld	s1,-750(s1) # 8002c150 <bcache+0x82b0>
    80002446:	0002a797          	auipc	a5,0x2a
    8000244a:	cc278793          	add	a5,a5,-830 # 8002c108 <bcache+0x8268>
    8000244e:	00f48863          	beq	s1,a5,8000245e <bread+0x90>
    80002452:	873e                	mv	a4,a5
    if(b->refcnt == 0) {
    80002454:	40bc                	lw	a5,64(s1)
    80002456:	cf81                	beqz	a5,8000246e <bread+0xa0>
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
    80002458:	64a4                	ld	s1,72(s1)
    8000245a:	fee49de3          	bne	s1,a4,80002454 <bread+0x86>
  panic("bget: no buffers");
    8000245e:	00009517          	auipc	a0,0x9
    80002462:	f4250513          	add	a0,a0,-190 # 8000b3a0 <etext+0x3a0>
    80002466:	00007097          	auipc	ra,0x7
    8000246a:	e72080e7          	jalr	-398(ra) # 800092d8 <panic>
      b->dev = dev;
    8000246e:	0124a423          	sw	s2,8(s1)
      b->blockno = blockno;
    80002472:	0134a623          	sw	s3,12(s1)
      b->valid = 0;
    80002476:	0004a023          	sw	zero,0(s1)
      b->refcnt = 1;
    8000247a:	4785                	li	a5,1
    8000247c:	c0bc                	sw	a5,64(s1)
      release(&bcache.lock);
    8000247e:	00022517          	auipc	a0,0x22
    80002482:	a2250513          	add	a0,a0,-1502 # 80023ea0 <bcache>
    80002486:	00007097          	auipc	ra,0x7
    8000248a:	4b2080e7          	jalr	1202(ra) # 80009938 <release>
      acquiresleep(&b->lock);
    8000248e:	01048513          	add	a0,s1,16
    80002492:	00001097          	auipc	ra,0x1
    80002496:	406080e7          	jalr	1030(ra) # 80003898 <acquiresleep>
  struct buf *b;

  b = bget(dev, blockno);
  if(!b->valid) {
    8000249a:	409c                	lw	a5,0(s1)
    8000249c:	cb89                	beqz	a5,800024ae <bread+0xe0>
    virtio_disk_rw(b, 0);
    b->valid = 1;
  }
  return b;
}
    8000249e:	8526                	mv	a0,s1
    800024a0:	70a2                	ld	ra,40(sp)
    800024a2:	7402                	ld	s0,32(sp)
    800024a4:	64e2                	ld	s1,24(sp)
    800024a6:	6942                	ld	s2,16(sp)
    800024a8:	69a2                	ld	s3,8(sp)
    800024aa:	6145                	add	sp,sp,48
    800024ac:	8082                	ret
    virtio_disk_rw(b, 0);
    800024ae:	4581                	li	a1,0
    800024b0:	8526                	mv	a0,s1
    800024b2:	00003097          	auipc	ra,0x3
    800024b6:	50a080e7          	jalr	1290(ra) # 800059bc <virtio_disk_rw>
    b->valid = 1;
    800024ba:	4785                	li	a5,1
    800024bc:	c09c                	sw	a5,0(s1)
  return b;
    800024be:	b7c5                	j	8000249e <bread+0xd0>

00000000800024c0 <bwrite>:

// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
    800024c0:	1101                	add	sp,sp,-32
    800024c2:	ec06                	sd	ra,24(sp)
    800024c4:	e822                	sd	s0,16(sp)
    800024c6:	e426                	sd	s1,8(sp)
    800024c8:	1000                	add	s0,sp,32
    800024ca:	84aa                	mv	s1,a0
  if(!holdingsleep(&b->lock))
    800024cc:	0541                	add	a0,a0,16
    800024ce:	00001097          	auipc	ra,0x1
    800024d2:	464080e7          	jalr	1124(ra) # 80003932 <holdingsleep>
    800024d6:	cd01                	beqz	a0,800024ee <bwrite+0x2e>
    panic("bwrite");
  virtio_disk_rw(b, 1);
    800024d8:	4585                	li	a1,1
    800024da:	8526                	mv	a0,s1
    800024dc:	00003097          	auipc	ra,0x3
    800024e0:	4e0080e7          	jalr	1248(ra) # 800059bc <virtio_disk_rw>
}
    800024e4:	60e2                	ld	ra,24(sp)
    800024e6:	6442                	ld	s0,16(sp)
    800024e8:	64a2                	ld	s1,8(sp)
    800024ea:	6105                	add	sp,sp,32
    800024ec:	8082                	ret
    panic("bwrite");
    800024ee:	00009517          	auipc	a0,0x9
    800024f2:	eca50513          	add	a0,a0,-310 # 8000b3b8 <etext+0x3b8>
    800024f6:	00007097          	auipc	ra,0x7
    800024fa:	de2080e7          	jalr	-542(ra) # 800092d8 <panic>

00000000800024fe <brelse>:

// Release a locked buffer.
// Move to the head of the most-recently-used list.
void
brelse(struct buf *b)
{
    800024fe:	1101                	add	sp,sp,-32
    80002500:	ec06                	sd	ra,24(sp)
    80002502:	e822                	sd	s0,16(sp)
    80002504:	e426                	sd	s1,8(sp)
    80002506:	e04a                	sd	s2,0(sp)
    80002508:	1000                	add	s0,sp,32
    8000250a:	84aa                	mv	s1,a0
  if(!holdingsleep(&b->lock))
    8000250c:	01050913          	add	s2,a0,16
    80002510:	854a                	mv	a0,s2
    80002512:	00001097          	auipc	ra,0x1
    80002516:	420080e7          	jalr	1056(ra) # 80003932 <holdingsleep>
    8000251a:	c925                	beqz	a0,8000258a <brelse+0x8c>
    panic("brelse");

  releasesleep(&b->lock);
    8000251c:	854a                	mv	a0,s2
    8000251e:	00001097          	auipc	ra,0x1
    80002522:	3d0080e7          	jalr	976(ra) # 800038ee <releasesleep>

  acquire(&bcache.lock);
    80002526:	00022517          	auipc	a0,0x22
    8000252a:	97a50513          	add	a0,a0,-1670 # 80023ea0 <bcache>
    8000252e:	00007097          	auipc	ra,0x7
    80002532:	344080e7          	jalr	836(ra) # 80009872 <acquire>
  b->refcnt--;
    80002536:	40bc                	lw	a5,64(s1)
    80002538:	37fd                	addw	a5,a5,-1
    8000253a:	0007871b          	sext.w	a4,a5
    8000253e:	c0bc                	sw	a5,64(s1)
  if (b->refcnt == 0) {
    80002540:	e71d                	bnez	a4,8000256e <brelse+0x70>
    // no one is waiting for it.
    b->next->prev = b->prev;
    80002542:	68b8                	ld	a4,80(s1)
    80002544:	64bc                	ld	a5,72(s1)
    80002546:	e73c                	sd	a5,72(a4)
    b->prev->next = b->next;
    80002548:	68b8                	ld	a4,80(s1)
    8000254a:	ebb8                	sd	a4,80(a5)
    b->next = bcache.head.next;
    8000254c:	0002a797          	auipc	a5,0x2a
    80002550:	95478793          	add	a5,a5,-1708 # 8002bea0 <bcache+0x8000>
    80002554:	2b87b703          	ld	a4,696(a5)
    80002558:	e8b8                	sd	a4,80(s1)
    b->prev = &bcache.head;
    8000255a:	0002a717          	auipc	a4,0x2a
    8000255e:	bae70713          	add	a4,a4,-1106 # 8002c108 <bcache+0x8268>
    80002562:	e4b8                	sd	a4,72(s1)
    bcache.head.next->prev = b;
    80002564:	2b87b703          	ld	a4,696(a5)
    80002568:	e724                	sd	s1,72(a4)
    bcache.head.next = b;
    8000256a:	2a97bc23          	sd	s1,696(a5)
  }
  
  release(&bcache.lock);
    8000256e:	00022517          	auipc	a0,0x22
    80002572:	93250513          	add	a0,a0,-1742 # 80023ea0 <bcache>
    80002576:	00007097          	auipc	ra,0x7
    8000257a:	3c2080e7          	jalr	962(ra) # 80009938 <release>
}
    8000257e:	60e2                	ld	ra,24(sp)
    80002580:	6442                	ld	s0,16(sp)
    80002582:	64a2                	ld	s1,8(sp)
    80002584:	6902                	ld	s2,0(sp)
    80002586:	6105                	add	sp,sp,32
    80002588:	8082                	ret
    panic("brelse");
    8000258a:	00009517          	auipc	a0,0x9
    8000258e:	e3650513          	add	a0,a0,-458 # 8000b3c0 <etext+0x3c0>
    80002592:	00007097          	auipc	ra,0x7
    80002596:	d46080e7          	jalr	-698(ra) # 800092d8 <panic>

000000008000259a <bpin>:

void
bpin(struct buf *b) {
    8000259a:	1101                	add	sp,sp,-32
    8000259c:	ec06                	sd	ra,24(sp)
    8000259e:	e822                	sd	s0,16(sp)
    800025a0:	e426                	sd	s1,8(sp)
    800025a2:	1000                	add	s0,sp,32
    800025a4:	84aa                	mv	s1,a0
  acquire(&bcache.lock);
    800025a6:	00022517          	auipc	a0,0x22
    800025aa:	8fa50513          	add	a0,a0,-1798 # 80023ea0 <bcache>
    800025ae:	00007097          	auipc	ra,0x7
    800025b2:	2c4080e7          	jalr	708(ra) # 80009872 <acquire>
  b->refcnt++;
    800025b6:	40bc                	lw	a5,64(s1)
    800025b8:	2785                	addw	a5,a5,1
    800025ba:	c0bc                	sw	a5,64(s1)
  release(&bcache.lock);
    800025bc:	00022517          	auipc	a0,0x22
    800025c0:	8e450513          	add	a0,a0,-1820 # 80023ea0 <bcache>
    800025c4:	00007097          	auipc	ra,0x7
    800025c8:	374080e7          	jalr	884(ra) # 80009938 <release>
}
    800025cc:	60e2                	ld	ra,24(sp)
    800025ce:	6442                	ld	s0,16(sp)
    800025d0:	64a2                	ld	s1,8(sp)
    800025d2:	6105                	add	sp,sp,32
    800025d4:	8082                	ret

00000000800025d6 <bunpin>:

void
bunpin(struct buf *b) {
    800025d6:	1101                	add	sp,sp,-32
    800025d8:	ec06                	sd	ra,24(sp)
    800025da:	e822                	sd	s0,16(sp)
    800025dc:	e426                	sd	s1,8(sp)
    800025de:	1000                	add	s0,sp,32
    800025e0:	84aa                	mv	s1,a0
  acquire(&bcache.lock);
    800025e2:	00022517          	auipc	a0,0x22
    800025e6:	8be50513          	add	a0,a0,-1858 # 80023ea0 <bcache>
    800025ea:	00007097          	auipc	ra,0x7
    800025ee:	288080e7          	jalr	648(ra) # 80009872 <acquire>
  b->refcnt--;
    800025f2:	40bc                	lw	a5,64(s1)
    800025f4:	37fd                	addw	a5,a5,-1
    800025f6:	c0bc                	sw	a5,64(s1)
  release(&bcache.lock);
    800025f8:	00022517          	auipc	a0,0x22
    800025fc:	8a850513          	add	a0,a0,-1880 # 80023ea0 <bcache>
    80002600:	00007097          	auipc	ra,0x7
    80002604:	338080e7          	jalr	824(ra) # 80009938 <release>
}
    80002608:	60e2                	ld	ra,24(sp)
    8000260a:	6442                	ld	s0,16(sp)
    8000260c:	64a2                	ld	s1,8(sp)
    8000260e:	6105                	add	sp,sp,32
    80002610:	8082                	ret

0000000080002612 <bfree>:
}

// Free a disk block.
static void
bfree(int dev, uint b)
{
    80002612:	1101                	add	sp,sp,-32
    80002614:	ec06                	sd	ra,24(sp)
    80002616:	e822                	sd	s0,16(sp)
    80002618:	e426                	sd	s1,8(sp)
    8000261a:	e04a                	sd	s2,0(sp)
    8000261c:	1000                	add	s0,sp,32
    8000261e:	84ae                	mv	s1,a1
  struct buf *bp;
  int bi, m;

  bp = bread(dev, BBLOCK(b, sb));
    80002620:	00d5d59b          	srlw	a1,a1,0xd
    80002624:	0002a797          	auipc	a5,0x2a
    80002628:	f587a783          	lw	a5,-168(a5) # 8002c57c <sb+0x1c>
    8000262c:	9dbd                	addw	a1,a1,a5
    8000262e:	00000097          	auipc	ra,0x0
    80002632:	da0080e7          	jalr	-608(ra) # 800023ce <bread>
  bi = b % BPB;
  m = 1 << (bi % 8);
    80002636:	0074f713          	and	a4,s1,7
    8000263a:	4785                	li	a5,1
    8000263c:	00e797bb          	sllw	a5,a5,a4
  if((bp->data[bi/8] & m) == 0)
    80002640:	14ce                	sll	s1,s1,0x33
    80002642:	90d9                	srl	s1,s1,0x36
    80002644:	00950733          	add	a4,a0,s1
    80002648:	05874703          	lbu	a4,88(a4)
    8000264c:	00e7f6b3          	and	a3,a5,a4
    80002650:	c69d                	beqz	a3,8000267e <bfree+0x6c>
    80002652:	892a                	mv	s2,a0
    panic("freeing free block");
  bp->data[bi/8] &= ~m;
    80002654:	94aa                	add	s1,s1,a0
    80002656:	fff7c793          	not	a5,a5
    8000265a:	8f7d                	and	a4,a4,a5
    8000265c:	04e48c23          	sb	a4,88(s1)
  log_write(bp);
    80002660:	00001097          	auipc	ra,0x1
    80002664:	112080e7          	jalr	274(ra) # 80003772 <log_write>
  brelse(bp);
    80002668:	854a                	mv	a0,s2
    8000266a:	00000097          	auipc	ra,0x0
    8000266e:	e94080e7          	jalr	-364(ra) # 800024fe <brelse>
}
    80002672:	60e2                	ld	ra,24(sp)
    80002674:	6442                	ld	s0,16(sp)
    80002676:	64a2                	ld	s1,8(sp)
    80002678:	6902                	ld	s2,0(sp)
    8000267a:	6105                	add	sp,sp,32
    8000267c:	8082                	ret
    panic("freeing free block");
    8000267e:	00009517          	auipc	a0,0x9
    80002682:	d4a50513          	add	a0,a0,-694 # 8000b3c8 <etext+0x3c8>
    80002686:	00007097          	auipc	ra,0x7
    8000268a:	c52080e7          	jalr	-942(ra) # 800092d8 <panic>

000000008000268e <balloc>:
{
    8000268e:	711d                	add	sp,sp,-96
    80002690:	ec86                	sd	ra,88(sp)
    80002692:	e8a2                	sd	s0,80(sp)
    80002694:	e4a6                	sd	s1,72(sp)
    80002696:	e0ca                	sd	s2,64(sp)
    80002698:	fc4e                	sd	s3,56(sp)
    8000269a:	f852                	sd	s4,48(sp)
    8000269c:	f456                	sd	s5,40(sp)
    8000269e:	f05a                	sd	s6,32(sp)
    800026a0:	ec5e                	sd	s7,24(sp)
    800026a2:	e862                	sd	s8,16(sp)
    800026a4:	e466                	sd	s9,8(sp)
    800026a6:	1080                	add	s0,sp,96
  for(b = 0; b < sb.size; b += BPB){
    800026a8:	0002a797          	auipc	a5,0x2a
    800026ac:	ebc7a783          	lw	a5,-324(a5) # 8002c564 <sb+0x4>
    800026b0:	cbc1                	beqz	a5,80002740 <balloc+0xb2>
    800026b2:	8baa                	mv	s7,a0
    800026b4:	4a81                	li	s5,0
    bp = bread(dev, BBLOCK(b, sb));
    800026b6:	0002ab17          	auipc	s6,0x2a
    800026ba:	eaab0b13          	add	s6,s6,-342 # 8002c560 <sb>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
    800026be:	4c01                	li	s8,0
      m = 1 << (bi % 8);
    800026c0:	4985                	li	s3,1
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
    800026c2:	6a09                	lui	s4,0x2
  for(b = 0; b < sb.size; b += BPB){
    800026c4:	6c89                	lui	s9,0x2
    800026c6:	a831                	j	800026e2 <balloc+0x54>
    brelse(bp);
    800026c8:	854a                	mv	a0,s2
    800026ca:	00000097          	auipc	ra,0x0
    800026ce:	e34080e7          	jalr	-460(ra) # 800024fe <brelse>
  for(b = 0; b < sb.size; b += BPB){
    800026d2:	015c87bb          	addw	a5,s9,s5
    800026d6:	00078a9b          	sext.w	s5,a5
    800026da:	004b2703          	lw	a4,4(s6)
    800026de:	06eaf163          	bgeu	s5,a4,80002740 <balloc+0xb2>
    bp = bread(dev, BBLOCK(b, sb));
    800026e2:	41fad79b          	sraw	a5,s5,0x1f
    800026e6:	0137d79b          	srlw	a5,a5,0x13
    800026ea:	015787bb          	addw	a5,a5,s5
    800026ee:	40d7d79b          	sraw	a5,a5,0xd
    800026f2:	01cb2583          	lw	a1,28(s6)
    800026f6:	9dbd                	addw	a1,a1,a5
    800026f8:	855e                	mv	a0,s7
    800026fa:	00000097          	auipc	ra,0x0
    800026fe:	cd4080e7          	jalr	-812(ra) # 800023ce <bread>
    80002702:	892a                	mv	s2,a0
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
    80002704:	004b2503          	lw	a0,4(s6)
    80002708:	000a849b          	sext.w	s1,s5
    8000270c:	8762                	mv	a4,s8
    8000270e:	faa4fde3          	bgeu	s1,a0,800026c8 <balloc+0x3a>
      m = 1 << (bi % 8);
    80002712:	00777693          	and	a3,a4,7
    80002716:	00d996bb          	sllw	a3,s3,a3
      if((bp->data[bi/8] & m) == 0){  // Is block free?
    8000271a:	41f7579b          	sraw	a5,a4,0x1f
    8000271e:	01d7d79b          	srlw	a5,a5,0x1d
    80002722:	9fb9                	addw	a5,a5,a4
    80002724:	4037d79b          	sraw	a5,a5,0x3
    80002728:	00f90633          	add	a2,s2,a5
    8000272c:	05864603          	lbu	a2,88(a2)
    80002730:	00c6f5b3          	and	a1,a3,a2
    80002734:	cd91                	beqz	a1,80002750 <balloc+0xc2>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
    80002736:	2705                	addw	a4,a4,1
    80002738:	2485                	addw	s1,s1,1
    8000273a:	fd471ae3          	bne	a4,s4,8000270e <balloc+0x80>
    8000273e:	b769                	j	800026c8 <balloc+0x3a>
  panic("balloc: out of blocks");
    80002740:	00009517          	auipc	a0,0x9
    80002744:	ca050513          	add	a0,a0,-864 # 8000b3e0 <etext+0x3e0>
    80002748:	00007097          	auipc	ra,0x7
    8000274c:	b90080e7          	jalr	-1136(ra) # 800092d8 <panic>
        bp->data[bi/8] |= m;  // Mark block in use.
    80002750:	97ca                	add	a5,a5,s2
    80002752:	8e55                	or	a2,a2,a3
    80002754:	04c78c23          	sb	a2,88(a5)
        log_write(bp);
    80002758:	854a                	mv	a0,s2
    8000275a:	00001097          	auipc	ra,0x1
    8000275e:	018080e7          	jalr	24(ra) # 80003772 <log_write>
        brelse(bp);
    80002762:	854a                	mv	a0,s2
    80002764:	00000097          	auipc	ra,0x0
    80002768:	d9a080e7          	jalr	-614(ra) # 800024fe <brelse>
  bp = bread(dev, bno);
    8000276c:	85a6                	mv	a1,s1
    8000276e:	855e                	mv	a0,s7
    80002770:	00000097          	auipc	ra,0x0
    80002774:	c5e080e7          	jalr	-930(ra) # 800023ce <bread>
    80002778:	892a                	mv	s2,a0
  memset(bp->data, 0, BSIZE);
    8000277a:	40000613          	li	a2,1024
    8000277e:	4581                	li	a1,0
    80002780:	05850513          	add	a0,a0,88
    80002784:	ffffe097          	auipc	ra,0xffffe
    80002788:	9f6080e7          	jalr	-1546(ra) # 8000017a <memset>
  log_write(bp);
    8000278c:	854a                	mv	a0,s2
    8000278e:	00001097          	auipc	ra,0x1
    80002792:	fe4080e7          	jalr	-28(ra) # 80003772 <log_write>
  brelse(bp);
    80002796:	854a                	mv	a0,s2
    80002798:	00000097          	auipc	ra,0x0
    8000279c:	d66080e7          	jalr	-666(ra) # 800024fe <brelse>
}
    800027a0:	8526                	mv	a0,s1
    800027a2:	60e6                	ld	ra,88(sp)
    800027a4:	6446                	ld	s0,80(sp)
    800027a6:	64a6                	ld	s1,72(sp)
    800027a8:	6906                	ld	s2,64(sp)
    800027aa:	79e2                	ld	s3,56(sp)
    800027ac:	7a42                	ld	s4,48(sp)
    800027ae:	7aa2                	ld	s5,40(sp)
    800027b0:	7b02                	ld	s6,32(sp)
    800027b2:	6be2                	ld	s7,24(sp)
    800027b4:	6c42                	ld	s8,16(sp)
    800027b6:	6ca2                	ld	s9,8(sp)
    800027b8:	6125                	add	sp,sp,96
    800027ba:	8082                	ret

00000000800027bc <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
    800027bc:	7179                	add	sp,sp,-48
    800027be:	f406                	sd	ra,40(sp)
    800027c0:	f022                	sd	s0,32(sp)
    800027c2:	ec26                	sd	s1,24(sp)
    800027c4:	e84a                	sd	s2,16(sp)
    800027c6:	e44e                	sd	s3,8(sp)
    800027c8:	1800                	add	s0,sp,48
    800027ca:	892a                	mv	s2,a0
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
    800027cc:	47ad                	li	a5,11
    800027ce:	04b7ff63          	bgeu	a5,a1,8000282c <bmap+0x70>
    800027d2:	e052                	sd	s4,0(sp)
    if((addr = ip->addrs[bn]) == 0)
      ip->addrs[bn] = addr = balloc(ip->dev);
    return addr;
  }
  bn -= NDIRECT;
    800027d4:	ff45849b          	addw	s1,a1,-12
    800027d8:	0004871b          	sext.w	a4,s1

  if(bn < NINDIRECT){
    800027dc:	0ff00793          	li	a5,255
    800027e0:	0ae7e463          	bltu	a5,a4,80002888 <bmap+0xcc>
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
    800027e4:	08052583          	lw	a1,128(a0)
    800027e8:	c5b5                	beqz	a1,80002854 <bmap+0x98>
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    bp = bread(ip->dev, addr);
    800027ea:	00092503          	lw	a0,0(s2)
    800027ee:	00000097          	auipc	ra,0x0
    800027f2:	be0080e7          	jalr	-1056(ra) # 800023ce <bread>
    800027f6:	8a2a                	mv	s4,a0
    a = (uint*)bp->data;
    800027f8:	05850793          	add	a5,a0,88
    if((addr = a[bn]) == 0){
    800027fc:	02049713          	sll	a4,s1,0x20
    80002800:	01e75593          	srl	a1,a4,0x1e
    80002804:	00b784b3          	add	s1,a5,a1
    80002808:	0004a983          	lw	s3,0(s1)
    8000280c:	04098e63          	beqz	s3,80002868 <bmap+0xac>
      a[bn] = addr = balloc(ip->dev);
      log_write(bp);
    }
    brelse(bp);
    80002810:	8552                	mv	a0,s4
    80002812:	00000097          	auipc	ra,0x0
    80002816:	cec080e7          	jalr	-788(ra) # 800024fe <brelse>
    return addr;
    8000281a:	6a02                	ld	s4,0(sp)
  }

  panic("bmap: out of range");
}
    8000281c:	854e                	mv	a0,s3
    8000281e:	70a2                	ld	ra,40(sp)
    80002820:	7402                	ld	s0,32(sp)
    80002822:	64e2                	ld	s1,24(sp)
    80002824:	6942                	ld	s2,16(sp)
    80002826:	69a2                	ld	s3,8(sp)
    80002828:	6145                	add	sp,sp,48
    8000282a:	8082                	ret
    if((addr = ip->addrs[bn]) == 0)
    8000282c:	02059793          	sll	a5,a1,0x20
    80002830:	01e7d593          	srl	a1,a5,0x1e
    80002834:	00b504b3          	add	s1,a0,a1
    80002838:	0504a983          	lw	s3,80(s1)
    8000283c:	fe0990e3          	bnez	s3,8000281c <bmap+0x60>
      ip->addrs[bn] = addr = balloc(ip->dev);
    80002840:	4108                	lw	a0,0(a0)
    80002842:	00000097          	auipc	ra,0x0
    80002846:	e4c080e7          	jalr	-436(ra) # 8000268e <balloc>
    8000284a:	0005099b          	sext.w	s3,a0
    8000284e:	0534a823          	sw	s3,80(s1)
    80002852:	b7e9                	j	8000281c <bmap+0x60>
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    80002854:	4108                	lw	a0,0(a0)
    80002856:	00000097          	auipc	ra,0x0
    8000285a:	e38080e7          	jalr	-456(ra) # 8000268e <balloc>
    8000285e:	0005059b          	sext.w	a1,a0
    80002862:	08b92023          	sw	a1,128(s2)
    80002866:	b751                	j	800027ea <bmap+0x2e>
      a[bn] = addr = balloc(ip->dev);
    80002868:	00092503          	lw	a0,0(s2)
    8000286c:	00000097          	auipc	ra,0x0
    80002870:	e22080e7          	jalr	-478(ra) # 8000268e <balloc>
    80002874:	0005099b          	sext.w	s3,a0
    80002878:	0134a023          	sw	s3,0(s1)
      log_write(bp);
    8000287c:	8552                	mv	a0,s4
    8000287e:	00001097          	auipc	ra,0x1
    80002882:	ef4080e7          	jalr	-268(ra) # 80003772 <log_write>
    80002886:	b769                	j	80002810 <bmap+0x54>
  panic("bmap: out of range");
    80002888:	00009517          	auipc	a0,0x9
    8000288c:	b7050513          	add	a0,a0,-1168 # 8000b3f8 <etext+0x3f8>
    80002890:	00007097          	auipc	ra,0x7
    80002894:	a48080e7          	jalr	-1464(ra) # 800092d8 <panic>

0000000080002898 <iget>:
{
    80002898:	7179                	add	sp,sp,-48
    8000289a:	f406                	sd	ra,40(sp)
    8000289c:	f022                	sd	s0,32(sp)
    8000289e:	ec26                	sd	s1,24(sp)
    800028a0:	e84a                	sd	s2,16(sp)
    800028a2:	e44e                	sd	s3,8(sp)
    800028a4:	e052                	sd	s4,0(sp)
    800028a6:	1800                	add	s0,sp,48
    800028a8:	89aa                	mv	s3,a0
    800028aa:	8a2e                	mv	s4,a1
  acquire(&icache.lock);
    800028ac:	0002a517          	auipc	a0,0x2a
    800028b0:	cd450513          	add	a0,a0,-812 # 8002c580 <icache>
    800028b4:	00007097          	auipc	ra,0x7
    800028b8:	fbe080e7          	jalr	-66(ra) # 80009872 <acquire>
  empty = 0;
    800028bc:	4901                	li	s2,0
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
    800028be:	0002a497          	auipc	s1,0x2a
    800028c2:	cda48493          	add	s1,s1,-806 # 8002c598 <icache+0x18>
    800028c6:	0002b697          	auipc	a3,0x2b
    800028ca:	76268693          	add	a3,a3,1890 # 8002e028 <log>
    800028ce:	a039                	j	800028dc <iget+0x44>
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
    800028d0:	02090b63          	beqz	s2,80002906 <iget+0x6e>
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
    800028d4:	08848493          	add	s1,s1,136
    800028d8:	02d48a63          	beq	s1,a3,8000290c <iget+0x74>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
    800028dc:	449c                	lw	a5,8(s1)
    800028de:	fef059e3          	blez	a5,800028d0 <iget+0x38>
    800028e2:	4098                	lw	a4,0(s1)
    800028e4:	ff3716e3          	bne	a4,s3,800028d0 <iget+0x38>
    800028e8:	40d8                	lw	a4,4(s1)
    800028ea:	ff4713e3          	bne	a4,s4,800028d0 <iget+0x38>
      ip->ref++;
    800028ee:	2785                	addw	a5,a5,1
    800028f0:	c49c                	sw	a5,8(s1)
      release(&icache.lock);
    800028f2:	0002a517          	auipc	a0,0x2a
    800028f6:	c8e50513          	add	a0,a0,-882 # 8002c580 <icache>
    800028fa:	00007097          	auipc	ra,0x7
    800028fe:	03e080e7          	jalr	62(ra) # 80009938 <release>
      return ip;
    80002902:	8926                	mv	s2,s1
    80002904:	a03d                	j	80002932 <iget+0x9a>
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
    80002906:	f7f9                	bnez	a5,800028d4 <iget+0x3c>
      empty = ip;
    80002908:	8926                	mv	s2,s1
    8000290a:	b7e9                	j	800028d4 <iget+0x3c>
  if(empty == 0)
    8000290c:	02090c63          	beqz	s2,80002944 <iget+0xac>
  ip->dev = dev;
    80002910:	01392023          	sw	s3,0(s2)
  ip->inum = inum;
    80002914:	01492223          	sw	s4,4(s2)
  ip->ref = 1;
    80002918:	4785                	li	a5,1
    8000291a:	00f92423          	sw	a5,8(s2)
  ip->valid = 0;
    8000291e:	04092023          	sw	zero,64(s2)
  release(&icache.lock);
    80002922:	0002a517          	auipc	a0,0x2a
    80002926:	c5e50513          	add	a0,a0,-930 # 8002c580 <icache>
    8000292a:	00007097          	auipc	ra,0x7
    8000292e:	00e080e7          	jalr	14(ra) # 80009938 <release>
}
    80002932:	854a                	mv	a0,s2
    80002934:	70a2                	ld	ra,40(sp)
    80002936:	7402                	ld	s0,32(sp)
    80002938:	64e2                	ld	s1,24(sp)
    8000293a:	6942                	ld	s2,16(sp)
    8000293c:	69a2                	ld	s3,8(sp)
    8000293e:	6a02                	ld	s4,0(sp)
    80002940:	6145                	add	sp,sp,48
    80002942:	8082                	ret
    panic("iget: no inodes");
    80002944:	00009517          	auipc	a0,0x9
    80002948:	acc50513          	add	a0,a0,-1332 # 8000b410 <etext+0x410>
    8000294c:	00007097          	auipc	ra,0x7
    80002950:	98c080e7          	jalr	-1652(ra) # 800092d8 <panic>

0000000080002954 <fsinit>:
fsinit(int dev) {
    80002954:	7179                	add	sp,sp,-48
    80002956:	f406                	sd	ra,40(sp)
    80002958:	f022                	sd	s0,32(sp)
    8000295a:	ec26                	sd	s1,24(sp)
    8000295c:	e84a                	sd	s2,16(sp)
    8000295e:	e44e                	sd	s3,8(sp)
    80002960:	1800                	add	s0,sp,48
    80002962:	892a                	mv	s2,a0
  bp = bread(dev, 1);
    80002964:	4585                	li	a1,1
    80002966:	00000097          	auipc	ra,0x0
    8000296a:	a68080e7          	jalr	-1432(ra) # 800023ce <bread>
    8000296e:	84aa                	mv	s1,a0
  memmove(sb, bp->data, sizeof(*sb));
    80002970:	0002a997          	auipc	s3,0x2a
    80002974:	bf098993          	add	s3,s3,-1040 # 8002c560 <sb>
    80002978:	02000613          	li	a2,32
    8000297c:	05850593          	add	a1,a0,88
    80002980:	854e                	mv	a0,s3
    80002982:	ffffe097          	auipc	ra,0xffffe
    80002986:	854080e7          	jalr	-1964(ra) # 800001d6 <memmove>
  brelse(bp);
    8000298a:	8526                	mv	a0,s1
    8000298c:	00000097          	auipc	ra,0x0
    80002990:	b72080e7          	jalr	-1166(ra) # 800024fe <brelse>
  if(sb.magic != FSMAGIC)
    80002994:	0009a703          	lw	a4,0(s3)
    80002998:	102037b7          	lui	a5,0x10203
    8000299c:	04078793          	add	a5,a5,64 # 10203040 <_entry-0x6fdfcfc0>
    800029a0:	02f71263          	bne	a4,a5,800029c4 <fsinit+0x70>
  initlog(dev, &sb);
    800029a4:	0002a597          	auipc	a1,0x2a
    800029a8:	bbc58593          	add	a1,a1,-1092 # 8002c560 <sb>
    800029ac:	854a                	mv	a0,s2
    800029ae:	00001097          	auipc	ra,0x1
    800029b2:	b54080e7          	jalr	-1196(ra) # 80003502 <initlog>
}
    800029b6:	70a2                	ld	ra,40(sp)
    800029b8:	7402                	ld	s0,32(sp)
    800029ba:	64e2                	ld	s1,24(sp)
    800029bc:	6942                	ld	s2,16(sp)
    800029be:	69a2                	ld	s3,8(sp)
    800029c0:	6145                	add	sp,sp,48
    800029c2:	8082                	ret
    panic("invalid file system");
    800029c4:	00009517          	auipc	a0,0x9
    800029c8:	a5c50513          	add	a0,a0,-1444 # 8000b420 <etext+0x420>
    800029cc:	00007097          	auipc	ra,0x7
    800029d0:	90c080e7          	jalr	-1780(ra) # 800092d8 <panic>

00000000800029d4 <iinit>:
{
    800029d4:	7179                	add	sp,sp,-48
    800029d6:	f406                	sd	ra,40(sp)
    800029d8:	f022                	sd	s0,32(sp)
    800029da:	ec26                	sd	s1,24(sp)
    800029dc:	e84a                	sd	s2,16(sp)
    800029de:	e44e                	sd	s3,8(sp)
    800029e0:	1800                	add	s0,sp,48
  initlock(&icache.lock, "icache");
    800029e2:	00009597          	auipc	a1,0x9
    800029e6:	a5658593          	add	a1,a1,-1450 # 8000b438 <etext+0x438>
    800029ea:	0002a517          	auipc	a0,0x2a
    800029ee:	b9650513          	add	a0,a0,-1130 # 8002c580 <icache>
    800029f2:	00007097          	auipc	ra,0x7
    800029f6:	df0080e7          	jalr	-528(ra) # 800097e2 <initlock>
  for(i = 0; i < NINODE; i++) {
    800029fa:	0002a497          	auipc	s1,0x2a
    800029fe:	bae48493          	add	s1,s1,-1106 # 8002c5a8 <icache+0x28>
    80002a02:	0002b997          	auipc	s3,0x2b
    80002a06:	63698993          	add	s3,s3,1590 # 8002e038 <log+0x10>
    initsleeplock(&icache.inode[i].lock, "inode");
    80002a0a:	00009917          	auipc	s2,0x9
    80002a0e:	a3690913          	add	s2,s2,-1482 # 8000b440 <etext+0x440>
    80002a12:	85ca                	mv	a1,s2
    80002a14:	8526                	mv	a0,s1
    80002a16:	00001097          	auipc	ra,0x1
    80002a1a:	e48080e7          	jalr	-440(ra) # 8000385e <initsleeplock>
  for(i = 0; i < NINODE; i++) {
    80002a1e:	08848493          	add	s1,s1,136
    80002a22:	ff3498e3          	bne	s1,s3,80002a12 <iinit+0x3e>
}
    80002a26:	70a2                	ld	ra,40(sp)
    80002a28:	7402                	ld	s0,32(sp)
    80002a2a:	64e2                	ld	s1,24(sp)
    80002a2c:	6942                	ld	s2,16(sp)
    80002a2e:	69a2                	ld	s3,8(sp)
    80002a30:	6145                	add	sp,sp,48
    80002a32:	8082                	ret

0000000080002a34 <ialloc>:
{
    80002a34:	7139                	add	sp,sp,-64
    80002a36:	fc06                	sd	ra,56(sp)
    80002a38:	f822                	sd	s0,48(sp)
    80002a3a:	f426                	sd	s1,40(sp)
    80002a3c:	f04a                	sd	s2,32(sp)
    80002a3e:	ec4e                	sd	s3,24(sp)
    80002a40:	e852                	sd	s4,16(sp)
    80002a42:	e456                	sd	s5,8(sp)
    80002a44:	e05a                	sd	s6,0(sp)
    80002a46:	0080                	add	s0,sp,64
  for(inum = 1; inum < sb.ninodes; inum++){
    80002a48:	0002a717          	auipc	a4,0x2a
    80002a4c:	b2472703          	lw	a4,-1244(a4) # 8002c56c <sb+0xc>
    80002a50:	4785                	li	a5,1
    80002a52:	04e7f863          	bgeu	a5,a4,80002aa2 <ialloc+0x6e>
    80002a56:	8aaa                	mv	s5,a0
    80002a58:	8b2e                	mv	s6,a1
    80002a5a:	4905                	li	s2,1
    bp = bread(dev, IBLOCK(inum, sb));
    80002a5c:	0002aa17          	auipc	s4,0x2a
    80002a60:	b04a0a13          	add	s4,s4,-1276 # 8002c560 <sb>
    80002a64:	00495593          	srl	a1,s2,0x4
    80002a68:	018a2783          	lw	a5,24(s4)
    80002a6c:	9dbd                	addw	a1,a1,a5
    80002a6e:	8556                	mv	a0,s5
    80002a70:	00000097          	auipc	ra,0x0
    80002a74:	95e080e7          	jalr	-1698(ra) # 800023ce <bread>
    80002a78:	84aa                	mv	s1,a0
    dip = (struct dinode*)bp->data + inum%IPB;
    80002a7a:	05850993          	add	s3,a0,88
    80002a7e:	00f97793          	and	a5,s2,15
    80002a82:	079a                	sll	a5,a5,0x6
    80002a84:	99be                	add	s3,s3,a5
    if(dip->type == 0){  // a free inode
    80002a86:	00099783          	lh	a5,0(s3)
    80002a8a:	c785                	beqz	a5,80002ab2 <ialloc+0x7e>
    brelse(bp);
    80002a8c:	00000097          	auipc	ra,0x0
    80002a90:	a72080e7          	jalr	-1422(ra) # 800024fe <brelse>
  for(inum = 1; inum < sb.ninodes; inum++){
    80002a94:	0905                	add	s2,s2,1
    80002a96:	00ca2703          	lw	a4,12(s4)
    80002a9a:	0009079b          	sext.w	a5,s2
    80002a9e:	fce7e3e3          	bltu	a5,a4,80002a64 <ialloc+0x30>
  panic("ialloc: no inodes");
    80002aa2:	00009517          	auipc	a0,0x9
    80002aa6:	9a650513          	add	a0,a0,-1626 # 8000b448 <etext+0x448>
    80002aaa:	00007097          	auipc	ra,0x7
    80002aae:	82e080e7          	jalr	-2002(ra) # 800092d8 <panic>
      memset(dip, 0, sizeof(*dip));
    80002ab2:	04000613          	li	a2,64
    80002ab6:	4581                	li	a1,0
    80002ab8:	854e                	mv	a0,s3
    80002aba:	ffffd097          	auipc	ra,0xffffd
    80002abe:	6c0080e7          	jalr	1728(ra) # 8000017a <memset>
      dip->type = type;
    80002ac2:	01699023          	sh	s6,0(s3)
      log_write(bp);   // mark it allocated on the disk
    80002ac6:	8526                	mv	a0,s1
    80002ac8:	00001097          	auipc	ra,0x1
    80002acc:	caa080e7          	jalr	-854(ra) # 80003772 <log_write>
      brelse(bp);
    80002ad0:	8526                	mv	a0,s1
    80002ad2:	00000097          	auipc	ra,0x0
    80002ad6:	a2c080e7          	jalr	-1492(ra) # 800024fe <brelse>
      return iget(dev, inum);
    80002ada:	0009059b          	sext.w	a1,s2
    80002ade:	8556                	mv	a0,s5
    80002ae0:	00000097          	auipc	ra,0x0
    80002ae4:	db8080e7          	jalr	-584(ra) # 80002898 <iget>
}
    80002ae8:	70e2                	ld	ra,56(sp)
    80002aea:	7442                	ld	s0,48(sp)
    80002aec:	74a2                	ld	s1,40(sp)
    80002aee:	7902                	ld	s2,32(sp)
    80002af0:	69e2                	ld	s3,24(sp)
    80002af2:	6a42                	ld	s4,16(sp)
    80002af4:	6aa2                	ld	s5,8(sp)
    80002af6:	6b02                	ld	s6,0(sp)
    80002af8:	6121                	add	sp,sp,64
    80002afa:	8082                	ret

0000000080002afc <iupdate>:
{
    80002afc:	1101                	add	sp,sp,-32
    80002afe:	ec06                	sd	ra,24(sp)
    80002b00:	e822                	sd	s0,16(sp)
    80002b02:	e426                	sd	s1,8(sp)
    80002b04:	e04a                	sd	s2,0(sp)
    80002b06:	1000                	add	s0,sp,32
    80002b08:	84aa                	mv	s1,a0
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
    80002b0a:	415c                	lw	a5,4(a0)
    80002b0c:	0047d79b          	srlw	a5,a5,0x4
    80002b10:	0002a597          	auipc	a1,0x2a
    80002b14:	a685a583          	lw	a1,-1432(a1) # 8002c578 <sb+0x18>
    80002b18:	9dbd                	addw	a1,a1,a5
    80002b1a:	4108                	lw	a0,0(a0)
    80002b1c:	00000097          	auipc	ra,0x0
    80002b20:	8b2080e7          	jalr	-1870(ra) # 800023ce <bread>
    80002b24:	892a                	mv	s2,a0
  dip = (struct dinode*)bp->data + ip->inum%IPB;
    80002b26:	05850793          	add	a5,a0,88
    80002b2a:	40d8                	lw	a4,4(s1)
    80002b2c:	8b3d                	and	a4,a4,15
    80002b2e:	071a                	sll	a4,a4,0x6
    80002b30:	97ba                	add	a5,a5,a4
  dip->type = ip->type;
    80002b32:	04449703          	lh	a4,68(s1)
    80002b36:	00e79023          	sh	a4,0(a5)
  dip->major = ip->major;
    80002b3a:	04649703          	lh	a4,70(s1)
    80002b3e:	00e79123          	sh	a4,2(a5)
  dip->minor = ip->minor;
    80002b42:	04849703          	lh	a4,72(s1)
    80002b46:	00e79223          	sh	a4,4(a5)
  dip->nlink = ip->nlink;
    80002b4a:	04a49703          	lh	a4,74(s1)
    80002b4e:	00e79323          	sh	a4,6(a5)
  dip->size = ip->size;
    80002b52:	44f8                	lw	a4,76(s1)
    80002b54:	c798                	sw	a4,8(a5)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
    80002b56:	03400613          	li	a2,52
    80002b5a:	05048593          	add	a1,s1,80
    80002b5e:	00c78513          	add	a0,a5,12
    80002b62:	ffffd097          	auipc	ra,0xffffd
    80002b66:	674080e7          	jalr	1652(ra) # 800001d6 <memmove>
  log_write(bp);
    80002b6a:	854a                	mv	a0,s2
    80002b6c:	00001097          	auipc	ra,0x1
    80002b70:	c06080e7          	jalr	-1018(ra) # 80003772 <log_write>
  brelse(bp);
    80002b74:	854a                	mv	a0,s2
    80002b76:	00000097          	auipc	ra,0x0
    80002b7a:	988080e7          	jalr	-1656(ra) # 800024fe <brelse>
}
    80002b7e:	60e2                	ld	ra,24(sp)
    80002b80:	6442                	ld	s0,16(sp)
    80002b82:	64a2                	ld	s1,8(sp)
    80002b84:	6902                	ld	s2,0(sp)
    80002b86:	6105                	add	sp,sp,32
    80002b88:	8082                	ret

0000000080002b8a <idup>:
{
    80002b8a:	1101                	add	sp,sp,-32
    80002b8c:	ec06                	sd	ra,24(sp)
    80002b8e:	e822                	sd	s0,16(sp)
    80002b90:	e426                	sd	s1,8(sp)
    80002b92:	1000                	add	s0,sp,32
    80002b94:	84aa                	mv	s1,a0
  acquire(&icache.lock);
    80002b96:	0002a517          	auipc	a0,0x2a
    80002b9a:	9ea50513          	add	a0,a0,-1558 # 8002c580 <icache>
    80002b9e:	00007097          	auipc	ra,0x7
    80002ba2:	cd4080e7          	jalr	-812(ra) # 80009872 <acquire>
  ip->ref++;
    80002ba6:	449c                	lw	a5,8(s1)
    80002ba8:	2785                	addw	a5,a5,1
    80002baa:	c49c                	sw	a5,8(s1)
  release(&icache.lock);
    80002bac:	0002a517          	auipc	a0,0x2a
    80002bb0:	9d450513          	add	a0,a0,-1580 # 8002c580 <icache>
    80002bb4:	00007097          	auipc	ra,0x7
    80002bb8:	d84080e7          	jalr	-636(ra) # 80009938 <release>
}
    80002bbc:	8526                	mv	a0,s1
    80002bbe:	60e2                	ld	ra,24(sp)
    80002bc0:	6442                	ld	s0,16(sp)
    80002bc2:	64a2                	ld	s1,8(sp)
    80002bc4:	6105                	add	sp,sp,32
    80002bc6:	8082                	ret

0000000080002bc8 <ilock>:
{
    80002bc8:	1101                	add	sp,sp,-32
    80002bca:	ec06                	sd	ra,24(sp)
    80002bcc:	e822                	sd	s0,16(sp)
    80002bce:	e426                	sd	s1,8(sp)
    80002bd0:	1000                	add	s0,sp,32
  if(ip == 0 || ip->ref < 1)
    80002bd2:	c10d                	beqz	a0,80002bf4 <ilock+0x2c>
    80002bd4:	84aa                	mv	s1,a0
    80002bd6:	451c                	lw	a5,8(a0)
    80002bd8:	00f05e63          	blez	a5,80002bf4 <ilock+0x2c>
  acquiresleep(&ip->lock);
    80002bdc:	0541                	add	a0,a0,16
    80002bde:	00001097          	auipc	ra,0x1
    80002be2:	cba080e7          	jalr	-838(ra) # 80003898 <acquiresleep>
  if(ip->valid == 0){
    80002be6:	40bc                	lw	a5,64(s1)
    80002be8:	cf99                	beqz	a5,80002c06 <ilock+0x3e>
}
    80002bea:	60e2                	ld	ra,24(sp)
    80002bec:	6442                	ld	s0,16(sp)
    80002bee:	64a2                	ld	s1,8(sp)
    80002bf0:	6105                	add	sp,sp,32
    80002bf2:	8082                	ret
    80002bf4:	e04a                	sd	s2,0(sp)
    panic("ilock");
    80002bf6:	00009517          	auipc	a0,0x9
    80002bfa:	86a50513          	add	a0,a0,-1942 # 8000b460 <etext+0x460>
    80002bfe:	00006097          	auipc	ra,0x6
    80002c02:	6da080e7          	jalr	1754(ra) # 800092d8 <panic>
    80002c06:	e04a                	sd	s2,0(sp)
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
    80002c08:	40dc                	lw	a5,4(s1)
    80002c0a:	0047d79b          	srlw	a5,a5,0x4
    80002c0e:	0002a597          	auipc	a1,0x2a
    80002c12:	96a5a583          	lw	a1,-1686(a1) # 8002c578 <sb+0x18>
    80002c16:	9dbd                	addw	a1,a1,a5
    80002c18:	4088                	lw	a0,0(s1)
    80002c1a:	fffff097          	auipc	ra,0xfffff
    80002c1e:	7b4080e7          	jalr	1972(ra) # 800023ce <bread>
    80002c22:	892a                	mv	s2,a0
    dip = (struct dinode*)bp->data + ip->inum%IPB;
    80002c24:	05850593          	add	a1,a0,88
    80002c28:	40dc                	lw	a5,4(s1)
    80002c2a:	8bbd                	and	a5,a5,15
    80002c2c:	079a                	sll	a5,a5,0x6
    80002c2e:	95be                	add	a1,a1,a5
    ip->type = dip->type;
    80002c30:	00059783          	lh	a5,0(a1)
    80002c34:	04f49223          	sh	a5,68(s1)
    ip->major = dip->major;
    80002c38:	00259783          	lh	a5,2(a1)
    80002c3c:	04f49323          	sh	a5,70(s1)
    ip->minor = dip->minor;
    80002c40:	00459783          	lh	a5,4(a1)
    80002c44:	04f49423          	sh	a5,72(s1)
    ip->nlink = dip->nlink;
    80002c48:	00659783          	lh	a5,6(a1)
    80002c4c:	04f49523          	sh	a5,74(s1)
    ip->size = dip->size;
    80002c50:	459c                	lw	a5,8(a1)
    80002c52:	c4fc                	sw	a5,76(s1)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
    80002c54:	03400613          	li	a2,52
    80002c58:	05b1                	add	a1,a1,12
    80002c5a:	05048513          	add	a0,s1,80
    80002c5e:	ffffd097          	auipc	ra,0xffffd
    80002c62:	578080e7          	jalr	1400(ra) # 800001d6 <memmove>
    brelse(bp);
    80002c66:	854a                	mv	a0,s2
    80002c68:	00000097          	auipc	ra,0x0
    80002c6c:	896080e7          	jalr	-1898(ra) # 800024fe <brelse>
    ip->valid = 1;
    80002c70:	4785                	li	a5,1
    80002c72:	c0bc                	sw	a5,64(s1)
    if(ip->type == 0)
    80002c74:	04449783          	lh	a5,68(s1)
    80002c78:	c399                	beqz	a5,80002c7e <ilock+0xb6>
    80002c7a:	6902                	ld	s2,0(sp)
    80002c7c:	b7bd                	j	80002bea <ilock+0x22>
      panic("ilock: no type");
    80002c7e:	00008517          	auipc	a0,0x8
    80002c82:	7ea50513          	add	a0,a0,2026 # 8000b468 <etext+0x468>
    80002c86:	00006097          	auipc	ra,0x6
    80002c8a:	652080e7          	jalr	1618(ra) # 800092d8 <panic>

0000000080002c8e <iunlock>:
{
    80002c8e:	1101                	add	sp,sp,-32
    80002c90:	ec06                	sd	ra,24(sp)
    80002c92:	e822                	sd	s0,16(sp)
    80002c94:	e426                	sd	s1,8(sp)
    80002c96:	e04a                	sd	s2,0(sp)
    80002c98:	1000                	add	s0,sp,32
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
    80002c9a:	c905                	beqz	a0,80002cca <iunlock+0x3c>
    80002c9c:	84aa                	mv	s1,a0
    80002c9e:	01050913          	add	s2,a0,16
    80002ca2:	854a                	mv	a0,s2
    80002ca4:	00001097          	auipc	ra,0x1
    80002ca8:	c8e080e7          	jalr	-882(ra) # 80003932 <holdingsleep>
    80002cac:	cd19                	beqz	a0,80002cca <iunlock+0x3c>
    80002cae:	449c                	lw	a5,8(s1)
    80002cb0:	00f05d63          	blez	a5,80002cca <iunlock+0x3c>
  releasesleep(&ip->lock);
    80002cb4:	854a                	mv	a0,s2
    80002cb6:	00001097          	auipc	ra,0x1
    80002cba:	c38080e7          	jalr	-968(ra) # 800038ee <releasesleep>
}
    80002cbe:	60e2                	ld	ra,24(sp)
    80002cc0:	6442                	ld	s0,16(sp)
    80002cc2:	64a2                	ld	s1,8(sp)
    80002cc4:	6902                	ld	s2,0(sp)
    80002cc6:	6105                	add	sp,sp,32
    80002cc8:	8082                	ret
    panic("iunlock");
    80002cca:	00008517          	auipc	a0,0x8
    80002cce:	7ae50513          	add	a0,a0,1966 # 8000b478 <etext+0x478>
    80002cd2:	00006097          	auipc	ra,0x6
    80002cd6:	606080e7          	jalr	1542(ra) # 800092d8 <panic>

0000000080002cda <itrunc>:

// Truncate inode (discard contents).
// Caller must hold ip->lock.
void
itrunc(struct inode *ip)
{
    80002cda:	7179                	add	sp,sp,-48
    80002cdc:	f406                	sd	ra,40(sp)
    80002cde:	f022                	sd	s0,32(sp)
    80002ce0:	ec26                	sd	s1,24(sp)
    80002ce2:	e84a                	sd	s2,16(sp)
    80002ce4:	e44e                	sd	s3,8(sp)
    80002ce6:	1800                	add	s0,sp,48
    80002ce8:	89aa                	mv	s3,a0
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
    80002cea:	05050493          	add	s1,a0,80
    80002cee:	08050913          	add	s2,a0,128
    80002cf2:	a021                	j	80002cfa <itrunc+0x20>
    80002cf4:	0491                	add	s1,s1,4
    80002cf6:	01248d63          	beq	s1,s2,80002d10 <itrunc+0x36>
    if(ip->addrs[i]){
    80002cfa:	408c                	lw	a1,0(s1)
    80002cfc:	dde5                	beqz	a1,80002cf4 <itrunc+0x1a>
      bfree(ip->dev, ip->addrs[i]);
    80002cfe:	0009a503          	lw	a0,0(s3)
    80002d02:	00000097          	auipc	ra,0x0
    80002d06:	910080e7          	jalr	-1776(ra) # 80002612 <bfree>
      ip->addrs[i] = 0;
    80002d0a:	0004a023          	sw	zero,0(s1)
    80002d0e:	b7dd                	j	80002cf4 <itrunc+0x1a>
    }
  }

  if(ip->addrs[NDIRECT]){
    80002d10:	0809a583          	lw	a1,128(s3)
    80002d14:	ed99                	bnez	a1,80002d32 <itrunc+0x58>
    brelse(bp);
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
    80002d16:	0409a623          	sw	zero,76(s3)
  iupdate(ip);
    80002d1a:	854e                	mv	a0,s3
    80002d1c:	00000097          	auipc	ra,0x0
    80002d20:	de0080e7          	jalr	-544(ra) # 80002afc <iupdate>
}
    80002d24:	70a2                	ld	ra,40(sp)
    80002d26:	7402                	ld	s0,32(sp)
    80002d28:	64e2                	ld	s1,24(sp)
    80002d2a:	6942                	ld	s2,16(sp)
    80002d2c:	69a2                	ld	s3,8(sp)
    80002d2e:	6145                	add	sp,sp,48
    80002d30:	8082                	ret
    80002d32:	e052                	sd	s4,0(sp)
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
    80002d34:	0009a503          	lw	a0,0(s3)
    80002d38:	fffff097          	auipc	ra,0xfffff
    80002d3c:	696080e7          	jalr	1686(ra) # 800023ce <bread>
    80002d40:	8a2a                	mv	s4,a0
    for(j = 0; j < NINDIRECT; j++){
    80002d42:	05850493          	add	s1,a0,88
    80002d46:	45850913          	add	s2,a0,1112
    80002d4a:	a021                	j	80002d52 <itrunc+0x78>
    80002d4c:	0491                	add	s1,s1,4
    80002d4e:	01248b63          	beq	s1,s2,80002d64 <itrunc+0x8a>
      if(a[j])
    80002d52:	408c                	lw	a1,0(s1)
    80002d54:	dde5                	beqz	a1,80002d4c <itrunc+0x72>
        bfree(ip->dev, a[j]);
    80002d56:	0009a503          	lw	a0,0(s3)
    80002d5a:	00000097          	auipc	ra,0x0
    80002d5e:	8b8080e7          	jalr	-1864(ra) # 80002612 <bfree>
    80002d62:	b7ed                	j	80002d4c <itrunc+0x72>
    brelse(bp);
    80002d64:	8552                	mv	a0,s4
    80002d66:	fffff097          	auipc	ra,0xfffff
    80002d6a:	798080e7          	jalr	1944(ra) # 800024fe <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
    80002d6e:	0809a583          	lw	a1,128(s3)
    80002d72:	0009a503          	lw	a0,0(s3)
    80002d76:	00000097          	auipc	ra,0x0
    80002d7a:	89c080e7          	jalr	-1892(ra) # 80002612 <bfree>
    ip->addrs[NDIRECT] = 0;
    80002d7e:	0809a023          	sw	zero,128(s3)
    80002d82:	6a02                	ld	s4,0(sp)
    80002d84:	bf49                	j	80002d16 <itrunc+0x3c>

0000000080002d86 <iput>:
{
    80002d86:	1101                	add	sp,sp,-32
    80002d88:	ec06                	sd	ra,24(sp)
    80002d8a:	e822                	sd	s0,16(sp)
    80002d8c:	e426                	sd	s1,8(sp)
    80002d8e:	1000                	add	s0,sp,32
    80002d90:	84aa                	mv	s1,a0
  acquire(&icache.lock);
    80002d92:	00029517          	auipc	a0,0x29
    80002d96:	7ee50513          	add	a0,a0,2030 # 8002c580 <icache>
    80002d9a:	00007097          	auipc	ra,0x7
    80002d9e:	ad8080e7          	jalr	-1320(ra) # 80009872 <acquire>
  if(ip->ref == 1 && ip->valid && ip->nlink == 0){
    80002da2:	4498                	lw	a4,8(s1)
    80002da4:	4785                	li	a5,1
    80002da6:	02f70263          	beq	a4,a5,80002dca <iput+0x44>
  ip->ref--;
    80002daa:	449c                	lw	a5,8(s1)
    80002dac:	37fd                	addw	a5,a5,-1
    80002dae:	c49c                	sw	a5,8(s1)
  release(&icache.lock);
    80002db0:	00029517          	auipc	a0,0x29
    80002db4:	7d050513          	add	a0,a0,2000 # 8002c580 <icache>
    80002db8:	00007097          	auipc	ra,0x7
    80002dbc:	b80080e7          	jalr	-1152(ra) # 80009938 <release>
}
    80002dc0:	60e2                	ld	ra,24(sp)
    80002dc2:	6442                	ld	s0,16(sp)
    80002dc4:	64a2                	ld	s1,8(sp)
    80002dc6:	6105                	add	sp,sp,32
    80002dc8:	8082                	ret
  if(ip->ref == 1 && ip->valid && ip->nlink == 0){
    80002dca:	40bc                	lw	a5,64(s1)
    80002dcc:	dff9                	beqz	a5,80002daa <iput+0x24>
    80002dce:	04a49783          	lh	a5,74(s1)
    80002dd2:	ffe1                	bnez	a5,80002daa <iput+0x24>
    80002dd4:	e04a                	sd	s2,0(sp)
    acquiresleep(&ip->lock);
    80002dd6:	01048913          	add	s2,s1,16
    80002dda:	854a                	mv	a0,s2
    80002ddc:	00001097          	auipc	ra,0x1
    80002de0:	abc080e7          	jalr	-1348(ra) # 80003898 <acquiresleep>
    release(&icache.lock);
    80002de4:	00029517          	auipc	a0,0x29
    80002de8:	79c50513          	add	a0,a0,1948 # 8002c580 <icache>
    80002dec:	00007097          	auipc	ra,0x7
    80002df0:	b4c080e7          	jalr	-1204(ra) # 80009938 <release>
    itrunc(ip);
    80002df4:	8526                	mv	a0,s1
    80002df6:	00000097          	auipc	ra,0x0
    80002dfa:	ee4080e7          	jalr	-284(ra) # 80002cda <itrunc>
    ip->type = 0;
    80002dfe:	04049223          	sh	zero,68(s1)
    iupdate(ip);
    80002e02:	8526                	mv	a0,s1
    80002e04:	00000097          	auipc	ra,0x0
    80002e08:	cf8080e7          	jalr	-776(ra) # 80002afc <iupdate>
    ip->valid = 0;
    80002e0c:	0404a023          	sw	zero,64(s1)
    releasesleep(&ip->lock);
    80002e10:	854a                	mv	a0,s2
    80002e12:	00001097          	auipc	ra,0x1
    80002e16:	adc080e7          	jalr	-1316(ra) # 800038ee <releasesleep>
    acquire(&icache.lock);
    80002e1a:	00029517          	auipc	a0,0x29
    80002e1e:	76650513          	add	a0,a0,1894 # 8002c580 <icache>
    80002e22:	00007097          	auipc	ra,0x7
    80002e26:	a50080e7          	jalr	-1456(ra) # 80009872 <acquire>
    80002e2a:	6902                	ld	s2,0(sp)
    80002e2c:	bfbd                	j	80002daa <iput+0x24>

0000000080002e2e <iunlockput>:
{
    80002e2e:	1101                	add	sp,sp,-32
    80002e30:	ec06                	sd	ra,24(sp)
    80002e32:	e822                	sd	s0,16(sp)
    80002e34:	e426                	sd	s1,8(sp)
    80002e36:	1000                	add	s0,sp,32
    80002e38:	84aa                	mv	s1,a0
  iunlock(ip);
    80002e3a:	00000097          	auipc	ra,0x0
    80002e3e:	e54080e7          	jalr	-428(ra) # 80002c8e <iunlock>
  iput(ip);
    80002e42:	8526                	mv	a0,s1
    80002e44:	00000097          	auipc	ra,0x0
    80002e48:	f42080e7          	jalr	-190(ra) # 80002d86 <iput>
}
    80002e4c:	60e2                	ld	ra,24(sp)
    80002e4e:	6442                	ld	s0,16(sp)
    80002e50:	64a2                	ld	s1,8(sp)
    80002e52:	6105                	add	sp,sp,32
    80002e54:	8082                	ret

0000000080002e56 <stati>:

// Copy stat information from inode.
// Caller must hold ip->lock.
void
stati(struct inode *ip, struct stat *st)
{
    80002e56:	1141                	add	sp,sp,-16
    80002e58:	e422                	sd	s0,8(sp)
    80002e5a:	0800                	add	s0,sp,16
  st->dev = ip->dev;
    80002e5c:	411c                	lw	a5,0(a0)
    80002e5e:	c19c                	sw	a5,0(a1)
  st->ino = ip->inum;
    80002e60:	415c                	lw	a5,4(a0)
    80002e62:	c1dc                	sw	a5,4(a1)
  st->type = ip->type;
    80002e64:	04451783          	lh	a5,68(a0)
    80002e68:	00f59423          	sh	a5,8(a1)
  st->nlink = ip->nlink;
    80002e6c:	04a51783          	lh	a5,74(a0)
    80002e70:	00f59523          	sh	a5,10(a1)
  st->size = ip->size;
    80002e74:	04c56783          	lwu	a5,76(a0)
    80002e78:	e99c                	sd	a5,16(a1)
}
    80002e7a:	6422                	ld	s0,8(sp)
    80002e7c:	0141                	add	sp,sp,16
    80002e7e:	8082                	ret

0000000080002e80 <readi>:
readi(struct inode *ip, int user_dst, uint64 dst, uint off, uint n)
{
  uint tot, m;
  struct buf *bp;

  if(off > ip->size || off + n < off)
    80002e80:	457c                	lw	a5,76(a0)
    80002e82:	0ed7ef63          	bltu	a5,a3,80002f80 <readi+0x100>
{
    80002e86:	7159                	add	sp,sp,-112
    80002e88:	f486                	sd	ra,104(sp)
    80002e8a:	f0a2                	sd	s0,96(sp)
    80002e8c:	eca6                	sd	s1,88(sp)
    80002e8e:	fc56                	sd	s5,56(sp)
    80002e90:	f85a                	sd	s6,48(sp)
    80002e92:	f45e                	sd	s7,40(sp)
    80002e94:	f062                	sd	s8,32(sp)
    80002e96:	1880                	add	s0,sp,112
    80002e98:	8baa                	mv	s7,a0
    80002e9a:	8c2e                	mv	s8,a1
    80002e9c:	8ab2                	mv	s5,a2
    80002e9e:	84b6                	mv	s1,a3
    80002ea0:	8b3a                	mv	s6,a4
  if(off > ip->size || off + n < off)
    80002ea2:	9f35                	addw	a4,a4,a3
    return 0;
    80002ea4:	4501                	li	a0,0
  if(off > ip->size || off + n < off)
    80002ea6:	0ad76c63          	bltu	a4,a3,80002f5e <readi+0xde>
    80002eaa:	e4ce                	sd	s3,72(sp)
  if(off + n > ip->size)
    80002eac:	00e7f463          	bgeu	a5,a4,80002eb4 <readi+0x34>
    n = ip->size - off;
    80002eb0:	40d78b3b          	subw	s6,a5,a3

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    80002eb4:	0c0b0463          	beqz	s6,80002f7c <readi+0xfc>
    80002eb8:	e8ca                	sd	s2,80(sp)
    80002eba:	e0d2                	sd	s4,64(sp)
    80002ebc:	ec66                	sd	s9,24(sp)
    80002ebe:	e86a                	sd	s10,16(sp)
    80002ec0:	e46e                	sd	s11,8(sp)
    80002ec2:	4981                	li	s3,0
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
    80002ec4:	40000d13          	li	s10,1024
    if(either_copyout(user_dst, dst, bp->data + (off % BSIZE), m) == -1) {
    80002ec8:	5cfd                	li	s9,-1
    80002eca:	a82d                	j	80002f04 <readi+0x84>
    80002ecc:	020a1d93          	sll	s11,s4,0x20
    80002ed0:	020ddd93          	srl	s11,s11,0x20
    80002ed4:	05890613          	add	a2,s2,88
    80002ed8:	86ee                	mv	a3,s11
    80002eda:	963a                	add	a2,a2,a4
    80002edc:	85d6                	mv	a1,s5
    80002ede:	8562                	mv	a0,s8
    80002ee0:	fffff097          	auipc	ra,0xfffff
    80002ee4:	ad8080e7          	jalr	-1320(ra) # 800019b8 <either_copyout>
    80002ee8:	05950d63          	beq	a0,s9,80002f42 <readi+0xc2>
      brelse(bp);
      tot = -1;
      break;
    }
    brelse(bp);
    80002eec:	854a                	mv	a0,s2
    80002eee:	fffff097          	auipc	ra,0xfffff
    80002ef2:	610080e7          	jalr	1552(ra) # 800024fe <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    80002ef6:	013a09bb          	addw	s3,s4,s3
    80002efa:	009a04bb          	addw	s1,s4,s1
    80002efe:	9aee                	add	s5,s5,s11
    80002f00:	0769f863          	bgeu	s3,s6,80002f70 <readi+0xf0>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    80002f04:	000ba903          	lw	s2,0(s7)
    80002f08:	00a4d59b          	srlw	a1,s1,0xa
    80002f0c:	855e                	mv	a0,s7
    80002f0e:	00000097          	auipc	ra,0x0
    80002f12:	8ae080e7          	jalr	-1874(ra) # 800027bc <bmap>
    80002f16:	0005059b          	sext.w	a1,a0
    80002f1a:	854a                	mv	a0,s2
    80002f1c:	fffff097          	auipc	ra,0xfffff
    80002f20:	4b2080e7          	jalr	1202(ra) # 800023ce <bread>
    80002f24:	892a                	mv	s2,a0
    m = min(n - tot, BSIZE - off%BSIZE);
    80002f26:	3ff4f713          	and	a4,s1,1023
    80002f2a:	40ed07bb          	subw	a5,s10,a4
    80002f2e:	413b06bb          	subw	a3,s6,s3
    80002f32:	8a3e                	mv	s4,a5
    80002f34:	2781                	sext.w	a5,a5
    80002f36:	0006861b          	sext.w	a2,a3
    80002f3a:	f8f679e3          	bgeu	a2,a5,80002ecc <readi+0x4c>
    80002f3e:	8a36                	mv	s4,a3
    80002f40:	b771                	j	80002ecc <readi+0x4c>
      brelse(bp);
    80002f42:	854a                	mv	a0,s2
    80002f44:	fffff097          	auipc	ra,0xfffff
    80002f48:	5ba080e7          	jalr	1466(ra) # 800024fe <brelse>
      tot = -1;
    80002f4c:	59fd                	li	s3,-1
      break;
    80002f4e:	6946                	ld	s2,80(sp)
    80002f50:	6a06                	ld	s4,64(sp)
    80002f52:	6ce2                	ld	s9,24(sp)
    80002f54:	6d42                	ld	s10,16(sp)
    80002f56:	6da2                	ld	s11,8(sp)
  }
  return tot;
    80002f58:	0009851b          	sext.w	a0,s3
    80002f5c:	69a6                	ld	s3,72(sp)
}
    80002f5e:	70a6                	ld	ra,104(sp)
    80002f60:	7406                	ld	s0,96(sp)
    80002f62:	64e6                	ld	s1,88(sp)
    80002f64:	7ae2                	ld	s5,56(sp)
    80002f66:	7b42                	ld	s6,48(sp)
    80002f68:	7ba2                	ld	s7,40(sp)
    80002f6a:	7c02                	ld	s8,32(sp)
    80002f6c:	6165                	add	sp,sp,112
    80002f6e:	8082                	ret
    80002f70:	6946                	ld	s2,80(sp)
    80002f72:	6a06                	ld	s4,64(sp)
    80002f74:	6ce2                	ld	s9,24(sp)
    80002f76:	6d42                	ld	s10,16(sp)
    80002f78:	6da2                	ld	s11,8(sp)
    80002f7a:	bff9                	j	80002f58 <readi+0xd8>
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    80002f7c:	89da                	mv	s3,s6
    80002f7e:	bfe9                	j	80002f58 <readi+0xd8>
    return 0;
    80002f80:	4501                	li	a0,0
}
    80002f82:	8082                	ret

0000000080002f84 <writei>:
writei(struct inode *ip, int user_src, uint64 src, uint off, uint n)
{
  uint tot, m;
  struct buf *bp;

  if(off > ip->size || off + n < off)
    80002f84:	457c                	lw	a5,76(a0)
    80002f86:	10d7ee63          	bltu	a5,a3,800030a2 <writei+0x11e>
{
    80002f8a:	7159                	add	sp,sp,-112
    80002f8c:	f486                	sd	ra,104(sp)
    80002f8e:	f0a2                	sd	s0,96(sp)
    80002f90:	e8ca                	sd	s2,80(sp)
    80002f92:	fc56                	sd	s5,56(sp)
    80002f94:	f85a                	sd	s6,48(sp)
    80002f96:	f45e                	sd	s7,40(sp)
    80002f98:	f062                	sd	s8,32(sp)
    80002f9a:	1880                	add	s0,sp,112
    80002f9c:	8b2a                	mv	s6,a0
    80002f9e:	8c2e                	mv	s8,a1
    80002fa0:	8ab2                	mv	s5,a2
    80002fa2:	8936                	mv	s2,a3
    80002fa4:	8bba                	mv	s7,a4
  if(off > ip->size || off + n < off)
    80002fa6:	00e687bb          	addw	a5,a3,a4
    80002faa:	0ed7ee63          	bltu	a5,a3,800030a6 <writei+0x122>
    return -1;
  if(off + n > MAXFILE*BSIZE)
    80002fae:	00043737          	lui	a4,0x43
    80002fb2:	0ef76c63          	bltu	a4,a5,800030aa <writei+0x126>
    80002fb6:	e0d2                	sd	s4,64(sp)
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    80002fb8:	0c0b8d63          	beqz	s7,80003092 <writei+0x10e>
    80002fbc:	eca6                	sd	s1,88(sp)
    80002fbe:	e4ce                	sd	s3,72(sp)
    80002fc0:	ec66                	sd	s9,24(sp)
    80002fc2:	e86a                	sd	s10,16(sp)
    80002fc4:	e46e                	sd	s11,8(sp)
    80002fc6:	4a01                	li	s4,0
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
    80002fc8:	40000d13          	li	s10,1024
    if(either_copyin(bp->data + (off % BSIZE), user_src, src, m) == -1) {
    80002fcc:	5cfd                	li	s9,-1
    80002fce:	a091                	j	80003012 <writei+0x8e>
    80002fd0:	02099d93          	sll	s11,s3,0x20
    80002fd4:	020ddd93          	srl	s11,s11,0x20
    80002fd8:	05848513          	add	a0,s1,88
    80002fdc:	86ee                	mv	a3,s11
    80002fde:	8656                	mv	a2,s5
    80002fe0:	85e2                	mv	a1,s8
    80002fe2:	953a                	add	a0,a0,a4
    80002fe4:	fffff097          	auipc	ra,0xfffff
    80002fe8:	a2a080e7          	jalr	-1494(ra) # 80001a0e <either_copyin>
    80002fec:	07950263          	beq	a0,s9,80003050 <writei+0xcc>
      brelse(bp);
      break;
    }
    log_write(bp);
    80002ff0:	8526                	mv	a0,s1
    80002ff2:	00000097          	auipc	ra,0x0
    80002ff6:	780080e7          	jalr	1920(ra) # 80003772 <log_write>
    brelse(bp);
    80002ffa:	8526                	mv	a0,s1
    80002ffc:	fffff097          	auipc	ra,0xfffff
    80003000:	502080e7          	jalr	1282(ra) # 800024fe <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    80003004:	01498a3b          	addw	s4,s3,s4
    80003008:	0129893b          	addw	s2,s3,s2
    8000300c:	9aee                	add	s5,s5,s11
    8000300e:	057a7663          	bgeu	s4,s7,8000305a <writei+0xd6>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    80003012:	000b2483          	lw	s1,0(s6)
    80003016:	00a9559b          	srlw	a1,s2,0xa
    8000301a:	855a                	mv	a0,s6
    8000301c:	fffff097          	auipc	ra,0xfffff
    80003020:	7a0080e7          	jalr	1952(ra) # 800027bc <bmap>
    80003024:	0005059b          	sext.w	a1,a0
    80003028:	8526                	mv	a0,s1
    8000302a:	fffff097          	auipc	ra,0xfffff
    8000302e:	3a4080e7          	jalr	932(ra) # 800023ce <bread>
    80003032:	84aa                	mv	s1,a0
    m = min(n - tot, BSIZE - off%BSIZE);
    80003034:	3ff97713          	and	a4,s2,1023
    80003038:	40ed07bb          	subw	a5,s10,a4
    8000303c:	414b86bb          	subw	a3,s7,s4
    80003040:	89be                	mv	s3,a5
    80003042:	2781                	sext.w	a5,a5
    80003044:	0006861b          	sext.w	a2,a3
    80003048:	f8f674e3          	bgeu	a2,a5,80002fd0 <writei+0x4c>
    8000304c:	89b6                	mv	s3,a3
    8000304e:	b749                	j	80002fd0 <writei+0x4c>
      brelse(bp);
    80003050:	8526                	mv	a0,s1
    80003052:	fffff097          	auipc	ra,0xfffff
    80003056:	4ac080e7          	jalr	1196(ra) # 800024fe <brelse>
  }

  if(off > ip->size)
    8000305a:	04cb2783          	lw	a5,76(s6)
    8000305e:	0327fc63          	bgeu	a5,s2,80003096 <writei+0x112>
    ip->size = off;
    80003062:	052b2623          	sw	s2,76(s6)
    80003066:	64e6                	ld	s1,88(sp)
    80003068:	69a6                	ld	s3,72(sp)
    8000306a:	6ce2                	ld	s9,24(sp)
    8000306c:	6d42                	ld	s10,16(sp)
    8000306e:	6da2                	ld	s11,8(sp)

  // write the i-node back to disk even if the size didn't change
  // because the loop above might have called bmap() and added a new
  // block to ip->addrs[].
  iupdate(ip);
    80003070:	855a                	mv	a0,s6
    80003072:	00000097          	auipc	ra,0x0
    80003076:	a8a080e7          	jalr	-1398(ra) # 80002afc <iupdate>

  return tot;
    8000307a:	000a051b          	sext.w	a0,s4
    8000307e:	6a06                	ld	s4,64(sp)
}
    80003080:	70a6                	ld	ra,104(sp)
    80003082:	7406                	ld	s0,96(sp)
    80003084:	6946                	ld	s2,80(sp)
    80003086:	7ae2                	ld	s5,56(sp)
    80003088:	7b42                	ld	s6,48(sp)
    8000308a:	7ba2                	ld	s7,40(sp)
    8000308c:	7c02                	ld	s8,32(sp)
    8000308e:	6165                	add	sp,sp,112
    80003090:	8082                	ret
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    80003092:	8a5e                	mv	s4,s7
    80003094:	bff1                	j	80003070 <writei+0xec>
    80003096:	64e6                	ld	s1,88(sp)
    80003098:	69a6                	ld	s3,72(sp)
    8000309a:	6ce2                	ld	s9,24(sp)
    8000309c:	6d42                	ld	s10,16(sp)
    8000309e:	6da2                	ld	s11,8(sp)
    800030a0:	bfc1                	j	80003070 <writei+0xec>
    return -1;
    800030a2:	557d                	li	a0,-1
}
    800030a4:	8082                	ret
    return -1;
    800030a6:	557d                	li	a0,-1
    800030a8:	bfe1                	j	80003080 <writei+0xfc>
    return -1;
    800030aa:	557d                	li	a0,-1
    800030ac:	bfd1                	j	80003080 <writei+0xfc>

00000000800030ae <namecmp>:

// Directories

int
namecmp(const char *s, const char *t)
{
    800030ae:	1141                	add	sp,sp,-16
    800030b0:	e406                	sd	ra,8(sp)
    800030b2:	e022                	sd	s0,0(sp)
    800030b4:	0800                	add	s0,sp,16
  return strncmp(s, t, DIRSIZ);
    800030b6:	4639                	li	a2,14
    800030b8:	ffffd097          	auipc	ra,0xffffd
    800030bc:	19a080e7          	jalr	410(ra) # 80000252 <strncmp>
}
    800030c0:	60a2                	ld	ra,8(sp)
    800030c2:	6402                	ld	s0,0(sp)
    800030c4:	0141                	add	sp,sp,16
    800030c6:	8082                	ret

00000000800030c8 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
    800030c8:	7139                	add	sp,sp,-64
    800030ca:	fc06                	sd	ra,56(sp)
    800030cc:	f822                	sd	s0,48(sp)
    800030ce:	f426                	sd	s1,40(sp)
    800030d0:	f04a                	sd	s2,32(sp)
    800030d2:	ec4e                	sd	s3,24(sp)
    800030d4:	e852                	sd	s4,16(sp)
    800030d6:	0080                	add	s0,sp,64
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
    800030d8:	04451703          	lh	a4,68(a0)
    800030dc:	4785                	li	a5,1
    800030de:	00f71a63          	bne	a4,a5,800030f2 <dirlookup+0x2a>
    800030e2:	892a                	mv	s2,a0
    800030e4:	89ae                	mv	s3,a1
    800030e6:	8a32                	mv	s4,a2
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
    800030e8:	457c                	lw	a5,76(a0)
    800030ea:	4481                	li	s1,0
      inum = de.inum;
      return iget(dp->dev, inum);
    }
  }

  return 0;
    800030ec:	4501                	li	a0,0
  for(off = 0; off < dp->size; off += sizeof(de)){
    800030ee:	e79d                	bnez	a5,8000311c <dirlookup+0x54>
    800030f0:	a8a5                	j	80003168 <dirlookup+0xa0>
    panic("dirlookup not DIR");
    800030f2:	00008517          	auipc	a0,0x8
    800030f6:	38e50513          	add	a0,a0,910 # 8000b480 <etext+0x480>
    800030fa:	00006097          	auipc	ra,0x6
    800030fe:	1de080e7          	jalr	478(ra) # 800092d8 <panic>
      panic("dirlookup read");
    80003102:	00008517          	auipc	a0,0x8
    80003106:	39650513          	add	a0,a0,918 # 8000b498 <etext+0x498>
    8000310a:	00006097          	auipc	ra,0x6
    8000310e:	1ce080e7          	jalr	462(ra) # 800092d8 <panic>
  for(off = 0; off < dp->size; off += sizeof(de)){
    80003112:	24c1                	addw	s1,s1,16
    80003114:	04c92783          	lw	a5,76(s2)
    80003118:	04f4f763          	bgeu	s1,a5,80003166 <dirlookup+0x9e>
    if(readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    8000311c:	4741                	li	a4,16
    8000311e:	86a6                	mv	a3,s1
    80003120:	fc040613          	add	a2,s0,-64
    80003124:	4581                	li	a1,0
    80003126:	854a                	mv	a0,s2
    80003128:	00000097          	auipc	ra,0x0
    8000312c:	d58080e7          	jalr	-680(ra) # 80002e80 <readi>
    80003130:	47c1                	li	a5,16
    80003132:	fcf518e3          	bne	a0,a5,80003102 <dirlookup+0x3a>
    if(de.inum == 0)
    80003136:	fc045783          	lhu	a5,-64(s0)
    8000313a:	dfe1                	beqz	a5,80003112 <dirlookup+0x4a>
    if(namecmp(name, de.name) == 0){
    8000313c:	fc240593          	add	a1,s0,-62
    80003140:	854e                	mv	a0,s3
    80003142:	00000097          	auipc	ra,0x0
    80003146:	f6c080e7          	jalr	-148(ra) # 800030ae <namecmp>
    8000314a:	f561                	bnez	a0,80003112 <dirlookup+0x4a>
      if(poff)
    8000314c:	000a0463          	beqz	s4,80003154 <dirlookup+0x8c>
        *poff = off;
    80003150:	009a2023          	sw	s1,0(s4)
      return iget(dp->dev, inum);
    80003154:	fc045583          	lhu	a1,-64(s0)
    80003158:	00092503          	lw	a0,0(s2)
    8000315c:	fffff097          	auipc	ra,0xfffff
    80003160:	73c080e7          	jalr	1852(ra) # 80002898 <iget>
    80003164:	a011                	j	80003168 <dirlookup+0xa0>
  return 0;
    80003166:	4501                	li	a0,0
}
    80003168:	70e2                	ld	ra,56(sp)
    8000316a:	7442                	ld	s0,48(sp)
    8000316c:	74a2                	ld	s1,40(sp)
    8000316e:	7902                	ld	s2,32(sp)
    80003170:	69e2                	ld	s3,24(sp)
    80003172:	6a42                	ld	s4,16(sp)
    80003174:	6121                	add	sp,sp,64
    80003176:	8082                	ret

0000000080003178 <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
    80003178:	711d                	add	sp,sp,-96
    8000317a:	ec86                	sd	ra,88(sp)
    8000317c:	e8a2                	sd	s0,80(sp)
    8000317e:	e4a6                	sd	s1,72(sp)
    80003180:	e0ca                	sd	s2,64(sp)
    80003182:	fc4e                	sd	s3,56(sp)
    80003184:	f852                	sd	s4,48(sp)
    80003186:	f456                	sd	s5,40(sp)
    80003188:	f05a                	sd	s6,32(sp)
    8000318a:	ec5e                	sd	s7,24(sp)
    8000318c:	e862                	sd	s8,16(sp)
    8000318e:	e466                	sd	s9,8(sp)
    80003190:	1080                	add	s0,sp,96
    80003192:	84aa                	mv	s1,a0
    80003194:	8b2e                	mv	s6,a1
    80003196:	8ab2                	mv	s5,a2
  struct inode *ip, *next;

  if(*path == '/')
    80003198:	00054703          	lbu	a4,0(a0)
    8000319c:	02f00793          	li	a5,47
    800031a0:	02f70263          	beq	a4,a5,800031c4 <namex+0x4c>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);
    800031a4:	ffffe097          	auipc	ra,0xffffe
    800031a8:	da2080e7          	jalr	-606(ra) # 80000f46 <myproc>
    800031ac:	5d053503          	ld	a0,1488(a0)
    800031b0:	00000097          	auipc	ra,0x0
    800031b4:	9da080e7          	jalr	-1574(ra) # 80002b8a <idup>
    800031b8:	8a2a                	mv	s4,a0
  while(*path == '/')
    800031ba:	02f00913          	li	s2,47
  if(len >= DIRSIZ)
    800031be:	4c35                	li	s8,13

  while((path = skipelem(path, name)) != 0){
    ilock(ip);
    if(ip->type != T_DIR){
    800031c0:	4b85                	li	s7,1
    800031c2:	a875                	j	8000327e <namex+0x106>
    ip = iget(ROOTDEV, ROOTINO);
    800031c4:	4585                	li	a1,1
    800031c6:	4505                	li	a0,1
    800031c8:	fffff097          	auipc	ra,0xfffff
    800031cc:	6d0080e7          	jalr	1744(ra) # 80002898 <iget>
    800031d0:	8a2a                	mv	s4,a0
    800031d2:	b7e5                	j	800031ba <namex+0x42>
      iunlockput(ip);
    800031d4:	8552                	mv	a0,s4
    800031d6:	00000097          	auipc	ra,0x0
    800031da:	c58080e7          	jalr	-936(ra) # 80002e2e <iunlockput>
      return 0;
    800031de:	4a01                	li	s4,0
  if(nameiparent){
    iput(ip);
    return 0;
  }
  return ip;
}
    800031e0:	8552                	mv	a0,s4
    800031e2:	60e6                	ld	ra,88(sp)
    800031e4:	6446                	ld	s0,80(sp)
    800031e6:	64a6                	ld	s1,72(sp)
    800031e8:	6906                	ld	s2,64(sp)
    800031ea:	79e2                	ld	s3,56(sp)
    800031ec:	7a42                	ld	s4,48(sp)
    800031ee:	7aa2                	ld	s5,40(sp)
    800031f0:	7b02                	ld	s6,32(sp)
    800031f2:	6be2                	ld	s7,24(sp)
    800031f4:	6c42                	ld	s8,16(sp)
    800031f6:	6ca2                	ld	s9,8(sp)
    800031f8:	6125                	add	sp,sp,96
    800031fa:	8082                	ret
      iunlock(ip);
    800031fc:	8552                	mv	a0,s4
    800031fe:	00000097          	auipc	ra,0x0
    80003202:	a90080e7          	jalr	-1392(ra) # 80002c8e <iunlock>
      return ip;
    80003206:	bfe9                	j	800031e0 <namex+0x68>
      iunlockput(ip);
    80003208:	8552                	mv	a0,s4
    8000320a:	00000097          	auipc	ra,0x0
    8000320e:	c24080e7          	jalr	-988(ra) # 80002e2e <iunlockput>
      return 0;
    80003212:	8a4e                	mv	s4,s3
    80003214:	b7f1                	j	800031e0 <namex+0x68>
  len = path - s;
    80003216:	40998633          	sub	a2,s3,s1
    8000321a:	00060c9b          	sext.w	s9,a2
  if(len >= DIRSIZ)
    8000321e:	099c5863          	bge	s8,s9,800032ae <namex+0x136>
    memmove(name, s, DIRSIZ);
    80003222:	4639                	li	a2,14
    80003224:	85a6                	mv	a1,s1
    80003226:	8556                	mv	a0,s5
    80003228:	ffffd097          	auipc	ra,0xffffd
    8000322c:	fae080e7          	jalr	-82(ra) # 800001d6 <memmove>
    80003230:	84ce                	mv	s1,s3
  while(*path == '/')
    80003232:	0004c783          	lbu	a5,0(s1)
    80003236:	01279763          	bne	a5,s2,80003244 <namex+0xcc>
    path++;
    8000323a:	0485                	add	s1,s1,1
  while(*path == '/')
    8000323c:	0004c783          	lbu	a5,0(s1)
    80003240:	ff278de3          	beq	a5,s2,8000323a <namex+0xc2>
    ilock(ip);
    80003244:	8552                	mv	a0,s4
    80003246:	00000097          	auipc	ra,0x0
    8000324a:	982080e7          	jalr	-1662(ra) # 80002bc8 <ilock>
    if(ip->type != T_DIR){
    8000324e:	044a1783          	lh	a5,68(s4)
    80003252:	f97791e3          	bne	a5,s7,800031d4 <namex+0x5c>
    if(nameiparent && *path == '\0'){
    80003256:	000b0563          	beqz	s6,80003260 <namex+0xe8>
    8000325a:	0004c783          	lbu	a5,0(s1)
    8000325e:	dfd9                	beqz	a5,800031fc <namex+0x84>
    if((next = dirlookup(ip, name, 0)) == 0){
    80003260:	4601                	li	a2,0
    80003262:	85d6                	mv	a1,s5
    80003264:	8552                	mv	a0,s4
    80003266:	00000097          	auipc	ra,0x0
    8000326a:	e62080e7          	jalr	-414(ra) # 800030c8 <dirlookup>
    8000326e:	89aa                	mv	s3,a0
    80003270:	dd41                	beqz	a0,80003208 <namex+0x90>
    iunlockput(ip);
    80003272:	8552                	mv	a0,s4
    80003274:	00000097          	auipc	ra,0x0
    80003278:	bba080e7          	jalr	-1094(ra) # 80002e2e <iunlockput>
    ip = next;
    8000327c:	8a4e                	mv	s4,s3
  while(*path == '/')
    8000327e:	0004c783          	lbu	a5,0(s1)
    80003282:	01279763          	bne	a5,s2,80003290 <namex+0x118>
    path++;
    80003286:	0485                	add	s1,s1,1
  while(*path == '/')
    80003288:	0004c783          	lbu	a5,0(s1)
    8000328c:	ff278de3          	beq	a5,s2,80003286 <namex+0x10e>
  if(*path == 0)
    80003290:	cb9d                	beqz	a5,800032c6 <namex+0x14e>
  while(*path != '/' && *path != 0)
    80003292:	0004c783          	lbu	a5,0(s1)
    80003296:	89a6                	mv	s3,s1
  len = path - s;
    80003298:	4c81                	li	s9,0
    8000329a:	4601                	li	a2,0
  while(*path != '/' && *path != 0)
    8000329c:	01278963          	beq	a5,s2,800032ae <namex+0x136>
    800032a0:	dbbd                	beqz	a5,80003216 <namex+0x9e>
    path++;
    800032a2:	0985                	add	s3,s3,1
  while(*path != '/' && *path != 0)
    800032a4:	0009c783          	lbu	a5,0(s3)
    800032a8:	ff279ce3          	bne	a5,s2,800032a0 <namex+0x128>
    800032ac:	b7ad                	j	80003216 <namex+0x9e>
    memmove(name, s, len);
    800032ae:	2601                	sext.w	a2,a2
    800032b0:	85a6                	mv	a1,s1
    800032b2:	8556                	mv	a0,s5
    800032b4:	ffffd097          	auipc	ra,0xffffd
    800032b8:	f22080e7          	jalr	-222(ra) # 800001d6 <memmove>
    name[len] = 0;
    800032bc:	9cd6                	add	s9,s9,s5
    800032be:	000c8023          	sb	zero,0(s9) # 2000 <_entry-0x7fffe000>
    800032c2:	84ce                	mv	s1,s3
    800032c4:	b7bd                	j	80003232 <namex+0xba>
  if(nameiparent){
    800032c6:	f00b0de3          	beqz	s6,800031e0 <namex+0x68>
    iput(ip);
    800032ca:	8552                	mv	a0,s4
    800032cc:	00000097          	auipc	ra,0x0
    800032d0:	aba080e7          	jalr	-1350(ra) # 80002d86 <iput>
    return 0;
    800032d4:	4a01                	li	s4,0
    800032d6:	b729                	j	800031e0 <namex+0x68>

00000000800032d8 <dirlink>:
{
    800032d8:	7139                	add	sp,sp,-64
    800032da:	fc06                	sd	ra,56(sp)
    800032dc:	f822                	sd	s0,48(sp)
    800032de:	f04a                	sd	s2,32(sp)
    800032e0:	ec4e                	sd	s3,24(sp)
    800032e2:	e852                	sd	s4,16(sp)
    800032e4:	0080                	add	s0,sp,64
    800032e6:	892a                	mv	s2,a0
    800032e8:	8a2e                	mv	s4,a1
    800032ea:	89b2                	mv	s3,a2
  if((ip = dirlookup(dp, name, 0)) != 0){
    800032ec:	4601                	li	a2,0
    800032ee:	00000097          	auipc	ra,0x0
    800032f2:	dda080e7          	jalr	-550(ra) # 800030c8 <dirlookup>
    800032f6:	ed25                	bnez	a0,8000336e <dirlink+0x96>
    800032f8:	f426                	sd	s1,40(sp)
  for(off = 0; off < dp->size; off += sizeof(de)){
    800032fa:	04c92483          	lw	s1,76(s2)
    800032fe:	c49d                	beqz	s1,8000332c <dirlink+0x54>
    80003300:	4481                	li	s1,0
    if(readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80003302:	4741                	li	a4,16
    80003304:	86a6                	mv	a3,s1
    80003306:	fc040613          	add	a2,s0,-64
    8000330a:	4581                	li	a1,0
    8000330c:	854a                	mv	a0,s2
    8000330e:	00000097          	auipc	ra,0x0
    80003312:	b72080e7          	jalr	-1166(ra) # 80002e80 <readi>
    80003316:	47c1                	li	a5,16
    80003318:	06f51163          	bne	a0,a5,8000337a <dirlink+0xa2>
    if(de.inum == 0)
    8000331c:	fc045783          	lhu	a5,-64(s0)
    80003320:	c791                	beqz	a5,8000332c <dirlink+0x54>
  for(off = 0; off < dp->size; off += sizeof(de)){
    80003322:	24c1                	addw	s1,s1,16
    80003324:	04c92783          	lw	a5,76(s2)
    80003328:	fcf4ede3          	bltu	s1,a5,80003302 <dirlink+0x2a>
  strncpy(de.name, name, DIRSIZ);
    8000332c:	4639                	li	a2,14
    8000332e:	85d2                	mv	a1,s4
    80003330:	fc240513          	add	a0,s0,-62
    80003334:	ffffd097          	auipc	ra,0xffffd
    80003338:	f54080e7          	jalr	-172(ra) # 80000288 <strncpy>
  de.inum = inum;
    8000333c:	fd341023          	sh	s3,-64(s0)
  if(writei(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80003340:	4741                	li	a4,16
    80003342:	86a6                	mv	a3,s1
    80003344:	fc040613          	add	a2,s0,-64
    80003348:	4581                	li	a1,0
    8000334a:	854a                	mv	a0,s2
    8000334c:	00000097          	auipc	ra,0x0
    80003350:	c38080e7          	jalr	-968(ra) # 80002f84 <writei>
    80003354:	872a                	mv	a4,a0
    80003356:	47c1                	li	a5,16
  return 0;
    80003358:	4501                	li	a0,0
  if(writei(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    8000335a:	02f71863          	bne	a4,a5,8000338a <dirlink+0xb2>
    8000335e:	74a2                	ld	s1,40(sp)
}
    80003360:	70e2                	ld	ra,56(sp)
    80003362:	7442                	ld	s0,48(sp)
    80003364:	7902                	ld	s2,32(sp)
    80003366:	69e2                	ld	s3,24(sp)
    80003368:	6a42                	ld	s4,16(sp)
    8000336a:	6121                	add	sp,sp,64
    8000336c:	8082                	ret
    iput(ip);
    8000336e:	00000097          	auipc	ra,0x0
    80003372:	a18080e7          	jalr	-1512(ra) # 80002d86 <iput>
    return -1;
    80003376:	557d                	li	a0,-1
    80003378:	b7e5                	j	80003360 <dirlink+0x88>
      panic("dirlink read");
    8000337a:	00008517          	auipc	a0,0x8
    8000337e:	12e50513          	add	a0,a0,302 # 8000b4a8 <etext+0x4a8>
    80003382:	00006097          	auipc	ra,0x6
    80003386:	f56080e7          	jalr	-170(ra) # 800092d8 <panic>
    panic("dirlink");
    8000338a:	00008517          	auipc	a0,0x8
    8000338e:	22e50513          	add	a0,a0,558 # 8000b5b8 <etext+0x5b8>
    80003392:	00006097          	auipc	ra,0x6
    80003396:	f46080e7          	jalr	-186(ra) # 800092d8 <panic>

000000008000339a <namei>:

struct inode*
namei(char *path)
{
    8000339a:	1101                	add	sp,sp,-32
    8000339c:	ec06                	sd	ra,24(sp)
    8000339e:	e822                	sd	s0,16(sp)
    800033a0:	1000                	add	s0,sp,32
  char name[DIRSIZ];
  return namex(path, 0, name);
    800033a2:	fe040613          	add	a2,s0,-32
    800033a6:	4581                	li	a1,0
    800033a8:	00000097          	auipc	ra,0x0
    800033ac:	dd0080e7          	jalr	-560(ra) # 80003178 <namex>
}
    800033b0:	60e2                	ld	ra,24(sp)
    800033b2:	6442                	ld	s0,16(sp)
    800033b4:	6105                	add	sp,sp,32
    800033b6:	8082                	ret

00000000800033b8 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
    800033b8:	1141                	add	sp,sp,-16
    800033ba:	e406                	sd	ra,8(sp)
    800033bc:	e022                	sd	s0,0(sp)
    800033be:	0800                	add	s0,sp,16
    800033c0:	862e                	mv	a2,a1
  return namex(path, 1, name);
    800033c2:	4585                	li	a1,1
    800033c4:	00000097          	auipc	ra,0x0
    800033c8:	db4080e7          	jalr	-588(ra) # 80003178 <namex>
}
    800033cc:	60a2                	ld	ra,8(sp)
    800033ce:	6402                	ld	s0,0(sp)
    800033d0:	0141                	add	sp,sp,16
    800033d2:	8082                	ret

00000000800033d4 <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
    800033d4:	1101                	add	sp,sp,-32
    800033d6:	ec06                	sd	ra,24(sp)
    800033d8:	e822                	sd	s0,16(sp)
    800033da:	e426                	sd	s1,8(sp)
    800033dc:	e04a                	sd	s2,0(sp)
    800033de:	1000                	add	s0,sp,32
  struct buf *buf = bread(log.dev, log.start);
    800033e0:	0002b917          	auipc	s2,0x2b
    800033e4:	c4890913          	add	s2,s2,-952 # 8002e028 <log>
    800033e8:	01892583          	lw	a1,24(s2)
    800033ec:	02892503          	lw	a0,40(s2)
    800033f0:	fffff097          	auipc	ra,0xfffff
    800033f4:	fde080e7          	jalr	-34(ra) # 800023ce <bread>
    800033f8:	84aa                	mv	s1,a0
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
    800033fa:	02c92603          	lw	a2,44(s2)
    800033fe:	cd30                	sw	a2,88(a0)
  for (i = 0; i < log.lh.n; i++) {
    80003400:	00c05f63          	blez	a2,8000341e <write_head+0x4a>
    80003404:	0002b717          	auipc	a4,0x2b
    80003408:	c5470713          	add	a4,a4,-940 # 8002e058 <log+0x30>
    8000340c:	87aa                	mv	a5,a0
    8000340e:	060a                	sll	a2,a2,0x2
    80003410:	962a                	add	a2,a2,a0
    hb->block[i] = log.lh.block[i];
    80003412:	4314                	lw	a3,0(a4)
    80003414:	cff4                	sw	a3,92(a5)
  for (i = 0; i < log.lh.n; i++) {
    80003416:	0711                	add	a4,a4,4
    80003418:	0791                	add	a5,a5,4
    8000341a:	fec79ce3          	bne	a5,a2,80003412 <write_head+0x3e>
  }
  bwrite(buf);
    8000341e:	8526                	mv	a0,s1
    80003420:	fffff097          	auipc	ra,0xfffff
    80003424:	0a0080e7          	jalr	160(ra) # 800024c0 <bwrite>
  brelse(buf);
    80003428:	8526                	mv	a0,s1
    8000342a:	fffff097          	auipc	ra,0xfffff
    8000342e:	0d4080e7          	jalr	212(ra) # 800024fe <brelse>
}
    80003432:	60e2                	ld	ra,24(sp)
    80003434:	6442                	ld	s0,16(sp)
    80003436:	64a2                	ld	s1,8(sp)
    80003438:	6902                	ld	s2,0(sp)
    8000343a:	6105                	add	sp,sp,32
    8000343c:	8082                	ret

000000008000343e <install_trans>:
  for (tail = 0; tail < log.lh.n; tail++) {
    8000343e:	0002b797          	auipc	a5,0x2b
    80003442:	c167a783          	lw	a5,-1002(a5) # 8002e054 <log+0x2c>
    80003446:	0af05d63          	blez	a5,80003500 <install_trans+0xc2>
{
    8000344a:	7139                	add	sp,sp,-64
    8000344c:	fc06                	sd	ra,56(sp)
    8000344e:	f822                	sd	s0,48(sp)
    80003450:	f426                	sd	s1,40(sp)
    80003452:	f04a                	sd	s2,32(sp)
    80003454:	ec4e                	sd	s3,24(sp)
    80003456:	e852                	sd	s4,16(sp)
    80003458:	e456                	sd	s5,8(sp)
    8000345a:	e05a                	sd	s6,0(sp)
    8000345c:	0080                	add	s0,sp,64
    8000345e:	8b2a                	mv	s6,a0
    80003460:	0002ba97          	auipc	s5,0x2b
    80003464:	bf8a8a93          	add	s5,s5,-1032 # 8002e058 <log+0x30>
  for (tail = 0; tail < log.lh.n; tail++) {
    80003468:	4a01                	li	s4,0
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
    8000346a:	0002b997          	auipc	s3,0x2b
    8000346e:	bbe98993          	add	s3,s3,-1090 # 8002e028 <log>
    80003472:	a00d                	j	80003494 <install_trans+0x56>
    brelse(lbuf);
    80003474:	854a                	mv	a0,s2
    80003476:	fffff097          	auipc	ra,0xfffff
    8000347a:	088080e7          	jalr	136(ra) # 800024fe <brelse>
    brelse(dbuf);
    8000347e:	8526                	mv	a0,s1
    80003480:	fffff097          	auipc	ra,0xfffff
    80003484:	07e080e7          	jalr	126(ra) # 800024fe <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
    80003488:	2a05                	addw	s4,s4,1
    8000348a:	0a91                	add	s5,s5,4
    8000348c:	02c9a783          	lw	a5,44(s3)
    80003490:	04fa5e63          	bge	s4,a5,800034ec <install_trans+0xae>
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
    80003494:	0189a583          	lw	a1,24(s3)
    80003498:	014585bb          	addw	a1,a1,s4
    8000349c:	2585                	addw	a1,a1,1
    8000349e:	0289a503          	lw	a0,40(s3)
    800034a2:	fffff097          	auipc	ra,0xfffff
    800034a6:	f2c080e7          	jalr	-212(ra) # 800023ce <bread>
    800034aa:	892a                	mv	s2,a0
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
    800034ac:	000aa583          	lw	a1,0(s5)
    800034b0:	0289a503          	lw	a0,40(s3)
    800034b4:	fffff097          	auipc	ra,0xfffff
    800034b8:	f1a080e7          	jalr	-230(ra) # 800023ce <bread>
    800034bc:	84aa                	mv	s1,a0
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
    800034be:	40000613          	li	a2,1024
    800034c2:	05890593          	add	a1,s2,88
    800034c6:	05850513          	add	a0,a0,88
    800034ca:	ffffd097          	auipc	ra,0xffffd
    800034ce:	d0c080e7          	jalr	-756(ra) # 800001d6 <memmove>
    bwrite(dbuf);  // write dst to disk
    800034d2:	8526                	mv	a0,s1
    800034d4:	fffff097          	auipc	ra,0xfffff
    800034d8:	fec080e7          	jalr	-20(ra) # 800024c0 <bwrite>
    if(recovering == 0)
    800034dc:	f80b1ce3          	bnez	s6,80003474 <install_trans+0x36>
      bunpin(dbuf);
    800034e0:	8526                	mv	a0,s1
    800034e2:	fffff097          	auipc	ra,0xfffff
    800034e6:	0f4080e7          	jalr	244(ra) # 800025d6 <bunpin>
    800034ea:	b769                	j	80003474 <install_trans+0x36>
}
    800034ec:	70e2                	ld	ra,56(sp)
    800034ee:	7442                	ld	s0,48(sp)
    800034f0:	74a2                	ld	s1,40(sp)
    800034f2:	7902                	ld	s2,32(sp)
    800034f4:	69e2                	ld	s3,24(sp)
    800034f6:	6a42                	ld	s4,16(sp)
    800034f8:	6aa2                	ld	s5,8(sp)
    800034fa:	6b02                	ld	s6,0(sp)
    800034fc:	6121                	add	sp,sp,64
    800034fe:	8082                	ret
    80003500:	8082                	ret

0000000080003502 <initlog>:
{
    80003502:	7179                	add	sp,sp,-48
    80003504:	f406                	sd	ra,40(sp)
    80003506:	f022                	sd	s0,32(sp)
    80003508:	ec26                	sd	s1,24(sp)
    8000350a:	e84a                	sd	s2,16(sp)
    8000350c:	e44e                	sd	s3,8(sp)
    8000350e:	1800                	add	s0,sp,48
    80003510:	892a                	mv	s2,a0
    80003512:	89ae                	mv	s3,a1
  initlock(&log.lock, "log");
    80003514:	0002b497          	auipc	s1,0x2b
    80003518:	b1448493          	add	s1,s1,-1260 # 8002e028 <log>
    8000351c:	00008597          	auipc	a1,0x8
    80003520:	f9c58593          	add	a1,a1,-100 # 8000b4b8 <etext+0x4b8>
    80003524:	8526                	mv	a0,s1
    80003526:	00006097          	auipc	ra,0x6
    8000352a:	2bc080e7          	jalr	700(ra) # 800097e2 <initlock>
  log.start = sb->logstart;
    8000352e:	0149a583          	lw	a1,20(s3)
    80003532:	cc8c                	sw	a1,24(s1)
  log.size = sb->nlog;
    80003534:	0109a783          	lw	a5,16(s3)
    80003538:	ccdc                	sw	a5,28(s1)
  log.dev = dev;
    8000353a:	0324a423          	sw	s2,40(s1)
  struct buf *buf = bread(log.dev, log.start);
    8000353e:	854a                	mv	a0,s2
    80003540:	fffff097          	auipc	ra,0xfffff
    80003544:	e8e080e7          	jalr	-370(ra) # 800023ce <bread>
  log.lh.n = lh->n;
    80003548:	4d30                	lw	a2,88(a0)
    8000354a:	d4d0                	sw	a2,44(s1)
  for (i = 0; i < log.lh.n; i++) {
    8000354c:	00c05f63          	blez	a2,8000356a <initlog+0x68>
    80003550:	87aa                	mv	a5,a0
    80003552:	0002b717          	auipc	a4,0x2b
    80003556:	b0670713          	add	a4,a4,-1274 # 8002e058 <log+0x30>
    8000355a:	060a                	sll	a2,a2,0x2
    8000355c:	962a                	add	a2,a2,a0
    log.lh.block[i] = lh->block[i];
    8000355e:	4ff4                	lw	a3,92(a5)
    80003560:	c314                	sw	a3,0(a4)
  for (i = 0; i < log.lh.n; i++) {
    80003562:	0791                	add	a5,a5,4
    80003564:	0711                	add	a4,a4,4
    80003566:	fec79ce3          	bne	a5,a2,8000355e <initlog+0x5c>
  brelse(buf);
    8000356a:	fffff097          	auipc	ra,0xfffff
    8000356e:	f94080e7          	jalr	-108(ra) # 800024fe <brelse>

static void
recover_from_log(void)
{
  read_head();
  install_trans(1); // if committed, copy from log to disk
    80003572:	4505                	li	a0,1
    80003574:	00000097          	auipc	ra,0x0
    80003578:	eca080e7          	jalr	-310(ra) # 8000343e <install_trans>
  log.lh.n = 0;
    8000357c:	0002b797          	auipc	a5,0x2b
    80003580:	ac07ac23          	sw	zero,-1320(a5) # 8002e054 <log+0x2c>
  write_head(); // clear the log
    80003584:	00000097          	auipc	ra,0x0
    80003588:	e50080e7          	jalr	-432(ra) # 800033d4 <write_head>
}
    8000358c:	70a2                	ld	ra,40(sp)
    8000358e:	7402                	ld	s0,32(sp)
    80003590:	64e2                	ld	s1,24(sp)
    80003592:	6942                	ld	s2,16(sp)
    80003594:	69a2                	ld	s3,8(sp)
    80003596:	6145                	add	sp,sp,48
    80003598:	8082                	ret

000000008000359a <begin_op>:
}

// called at the start of each FS system call.
void
begin_op(void)
{
    8000359a:	1101                	add	sp,sp,-32
    8000359c:	ec06                	sd	ra,24(sp)
    8000359e:	e822                	sd	s0,16(sp)
    800035a0:	e426                	sd	s1,8(sp)
    800035a2:	e04a                	sd	s2,0(sp)
    800035a4:	1000                	add	s0,sp,32
  acquire(&log.lock);
    800035a6:	0002b517          	auipc	a0,0x2b
    800035aa:	a8250513          	add	a0,a0,-1406 # 8002e028 <log>
    800035ae:	00006097          	auipc	ra,0x6
    800035b2:	2c4080e7          	jalr	708(ra) # 80009872 <acquire>
  while(1){
    if(log.committing){
    800035b6:	0002b497          	auipc	s1,0x2b
    800035ba:	a7248493          	add	s1,s1,-1422 # 8002e028 <log>
      sleep(&log, &log.lock);
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
    800035be:	4979                	li	s2,30
    800035c0:	a039                	j	800035ce <begin_op+0x34>
      sleep(&log, &log.lock);
    800035c2:	85a6                	mv	a1,s1
    800035c4:	8526                	mv	a0,s1
    800035c6:	ffffe097          	auipc	ra,0xffffe
    800035ca:	198080e7          	jalr	408(ra) # 8000175e <sleep>
    if(log.committing){
    800035ce:	50dc                	lw	a5,36(s1)
    800035d0:	fbed                	bnez	a5,800035c2 <begin_op+0x28>
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
    800035d2:	5098                	lw	a4,32(s1)
    800035d4:	2705                	addw	a4,a4,1
    800035d6:	0027179b          	sllw	a5,a4,0x2
    800035da:	9fb9                	addw	a5,a5,a4
    800035dc:	0017979b          	sllw	a5,a5,0x1
    800035e0:	54d4                	lw	a3,44(s1)
    800035e2:	9fb5                	addw	a5,a5,a3
    800035e4:	00f95963          	bge	s2,a5,800035f6 <begin_op+0x5c>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    800035e8:	85a6                	mv	a1,s1
    800035ea:	8526                	mv	a0,s1
    800035ec:	ffffe097          	auipc	ra,0xffffe
    800035f0:	172080e7          	jalr	370(ra) # 8000175e <sleep>
    800035f4:	bfe9                	j	800035ce <begin_op+0x34>
    } else {
      log.outstanding += 1;
    800035f6:	0002b517          	auipc	a0,0x2b
    800035fa:	a3250513          	add	a0,a0,-1486 # 8002e028 <log>
    800035fe:	d118                	sw	a4,32(a0)
      release(&log.lock);
    80003600:	00006097          	auipc	ra,0x6
    80003604:	338080e7          	jalr	824(ra) # 80009938 <release>
      break;
    }
  }
}
    80003608:	60e2                	ld	ra,24(sp)
    8000360a:	6442                	ld	s0,16(sp)
    8000360c:	64a2                	ld	s1,8(sp)
    8000360e:	6902                	ld	s2,0(sp)
    80003610:	6105                	add	sp,sp,32
    80003612:	8082                	ret

0000000080003614 <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
    80003614:	7139                	add	sp,sp,-64
    80003616:	fc06                	sd	ra,56(sp)
    80003618:	f822                	sd	s0,48(sp)
    8000361a:	f426                	sd	s1,40(sp)
    8000361c:	f04a                	sd	s2,32(sp)
    8000361e:	0080                	add	s0,sp,64
  int do_commit = 0;

  acquire(&log.lock);
    80003620:	0002b497          	auipc	s1,0x2b
    80003624:	a0848493          	add	s1,s1,-1528 # 8002e028 <log>
    80003628:	8526                	mv	a0,s1
    8000362a:	00006097          	auipc	ra,0x6
    8000362e:	248080e7          	jalr	584(ra) # 80009872 <acquire>
  log.outstanding -= 1;
    80003632:	509c                	lw	a5,32(s1)
    80003634:	37fd                	addw	a5,a5,-1
    80003636:	0007891b          	sext.w	s2,a5
    8000363a:	d09c                	sw	a5,32(s1)
  if(log.committing)
    8000363c:	50dc                	lw	a5,36(s1)
    8000363e:	e7b9                	bnez	a5,8000368c <end_op+0x78>
    panic("log.committing");
  if(log.outstanding == 0){
    80003640:	06091163          	bnez	s2,800036a2 <end_op+0x8e>
    do_commit = 1;
    log.committing = 1;
    80003644:	0002b497          	auipc	s1,0x2b
    80003648:	9e448493          	add	s1,s1,-1564 # 8002e028 <log>
    8000364c:	4785                	li	a5,1
    8000364e:	d0dc                	sw	a5,36(s1)
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
    80003650:	8526                	mv	a0,s1
    80003652:	00006097          	auipc	ra,0x6
    80003656:	2e6080e7          	jalr	742(ra) # 80009938 <release>
}

static void
commit()
{
  if (log.lh.n > 0) {
    8000365a:	54dc                	lw	a5,44(s1)
    8000365c:	06f04763          	bgtz	a5,800036ca <end_op+0xb6>
    acquire(&log.lock);
    80003660:	0002b497          	auipc	s1,0x2b
    80003664:	9c848493          	add	s1,s1,-1592 # 8002e028 <log>
    80003668:	8526                	mv	a0,s1
    8000366a:	00006097          	auipc	ra,0x6
    8000366e:	208080e7          	jalr	520(ra) # 80009872 <acquire>
    log.committing = 0;
    80003672:	0204a223          	sw	zero,36(s1)
    wakeup(&log);
    80003676:	8526                	mv	a0,s1
    80003678:	ffffe097          	auipc	ra,0xffffe
    8000367c:	266080e7          	jalr	614(ra) # 800018de <wakeup>
    release(&log.lock);
    80003680:	8526                	mv	a0,s1
    80003682:	00006097          	auipc	ra,0x6
    80003686:	2b6080e7          	jalr	694(ra) # 80009938 <release>
}
    8000368a:	a815                	j	800036be <end_op+0xaa>
    8000368c:	ec4e                	sd	s3,24(sp)
    8000368e:	e852                	sd	s4,16(sp)
    80003690:	e456                	sd	s5,8(sp)
    panic("log.committing");
    80003692:	00008517          	auipc	a0,0x8
    80003696:	e2e50513          	add	a0,a0,-466 # 8000b4c0 <etext+0x4c0>
    8000369a:	00006097          	auipc	ra,0x6
    8000369e:	c3e080e7          	jalr	-962(ra) # 800092d8 <panic>
    wakeup(&log);
    800036a2:	0002b497          	auipc	s1,0x2b
    800036a6:	98648493          	add	s1,s1,-1658 # 8002e028 <log>
    800036aa:	8526                	mv	a0,s1
    800036ac:	ffffe097          	auipc	ra,0xffffe
    800036b0:	232080e7          	jalr	562(ra) # 800018de <wakeup>
  release(&log.lock);
    800036b4:	8526                	mv	a0,s1
    800036b6:	00006097          	auipc	ra,0x6
    800036ba:	282080e7          	jalr	642(ra) # 80009938 <release>
}
    800036be:	70e2                	ld	ra,56(sp)
    800036c0:	7442                	ld	s0,48(sp)
    800036c2:	74a2                	ld	s1,40(sp)
    800036c4:	7902                	ld	s2,32(sp)
    800036c6:	6121                	add	sp,sp,64
    800036c8:	8082                	ret
    800036ca:	ec4e                	sd	s3,24(sp)
    800036cc:	e852                	sd	s4,16(sp)
    800036ce:	e456                	sd	s5,8(sp)
  for (tail = 0; tail < log.lh.n; tail++) {
    800036d0:	0002ba97          	auipc	s5,0x2b
    800036d4:	988a8a93          	add	s5,s5,-1656 # 8002e058 <log+0x30>
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
    800036d8:	0002ba17          	auipc	s4,0x2b
    800036dc:	950a0a13          	add	s4,s4,-1712 # 8002e028 <log>
    800036e0:	018a2583          	lw	a1,24(s4)
    800036e4:	012585bb          	addw	a1,a1,s2
    800036e8:	2585                	addw	a1,a1,1
    800036ea:	028a2503          	lw	a0,40(s4)
    800036ee:	fffff097          	auipc	ra,0xfffff
    800036f2:	ce0080e7          	jalr	-800(ra) # 800023ce <bread>
    800036f6:	84aa                	mv	s1,a0
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
    800036f8:	000aa583          	lw	a1,0(s5)
    800036fc:	028a2503          	lw	a0,40(s4)
    80003700:	fffff097          	auipc	ra,0xfffff
    80003704:	cce080e7          	jalr	-818(ra) # 800023ce <bread>
    80003708:	89aa                	mv	s3,a0
    memmove(to->data, from->data, BSIZE);
    8000370a:	40000613          	li	a2,1024
    8000370e:	05850593          	add	a1,a0,88
    80003712:	05848513          	add	a0,s1,88
    80003716:	ffffd097          	auipc	ra,0xffffd
    8000371a:	ac0080e7          	jalr	-1344(ra) # 800001d6 <memmove>
    bwrite(to);  // write the log
    8000371e:	8526                	mv	a0,s1
    80003720:	fffff097          	auipc	ra,0xfffff
    80003724:	da0080e7          	jalr	-608(ra) # 800024c0 <bwrite>
    brelse(from);
    80003728:	854e                	mv	a0,s3
    8000372a:	fffff097          	auipc	ra,0xfffff
    8000372e:	dd4080e7          	jalr	-556(ra) # 800024fe <brelse>
    brelse(to);
    80003732:	8526                	mv	a0,s1
    80003734:	fffff097          	auipc	ra,0xfffff
    80003738:	dca080e7          	jalr	-566(ra) # 800024fe <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
    8000373c:	2905                	addw	s2,s2,1
    8000373e:	0a91                	add	s5,s5,4
    80003740:	02ca2783          	lw	a5,44(s4)
    80003744:	f8f94ee3          	blt	s2,a5,800036e0 <end_op+0xcc>
    write_log();     // Write modified blocks from cache to log
    write_head();    // Write header to disk -- the real commit
    80003748:	00000097          	auipc	ra,0x0
    8000374c:	c8c080e7          	jalr	-884(ra) # 800033d4 <write_head>
    install_trans(0); // Now install writes to home locations
    80003750:	4501                	li	a0,0
    80003752:	00000097          	auipc	ra,0x0
    80003756:	cec080e7          	jalr	-788(ra) # 8000343e <install_trans>
    log.lh.n = 0;
    8000375a:	0002b797          	auipc	a5,0x2b
    8000375e:	8e07ad23          	sw	zero,-1798(a5) # 8002e054 <log+0x2c>
    write_head();    // Erase the transaction from the log
    80003762:	00000097          	auipc	ra,0x0
    80003766:	c72080e7          	jalr	-910(ra) # 800033d4 <write_head>
    8000376a:	69e2                	ld	s3,24(sp)
    8000376c:	6a42                	ld	s4,16(sp)
    8000376e:	6aa2                	ld	s5,8(sp)
    80003770:	bdc5                	j	80003660 <end_op+0x4c>

0000000080003772 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
    80003772:	1101                	add	sp,sp,-32
    80003774:	ec06                	sd	ra,24(sp)
    80003776:	e822                	sd	s0,16(sp)
    80003778:	e426                	sd	s1,8(sp)
    8000377a:	e04a                	sd	s2,0(sp)
    8000377c:	1000                	add	s0,sp,32
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
    8000377e:	0002b717          	auipc	a4,0x2b
    80003782:	8d672703          	lw	a4,-1834(a4) # 8002e054 <log+0x2c>
    80003786:	47f5                	li	a5,29
    80003788:	08e7c063          	blt	a5,a4,80003808 <log_write+0x96>
    8000378c:	84aa                	mv	s1,a0
    8000378e:	0002b797          	auipc	a5,0x2b
    80003792:	8b67a783          	lw	a5,-1866(a5) # 8002e044 <log+0x1c>
    80003796:	37fd                	addw	a5,a5,-1
    80003798:	06f75863          	bge	a4,a5,80003808 <log_write+0x96>
    panic("too big a transaction");
  if (log.outstanding < 1)
    8000379c:	0002b797          	auipc	a5,0x2b
    800037a0:	8ac7a783          	lw	a5,-1876(a5) # 8002e048 <log+0x20>
    800037a4:	06f05a63          	blez	a5,80003818 <log_write+0xa6>
    panic("log_write outside of trans");

  acquire(&log.lock);
    800037a8:	0002b917          	auipc	s2,0x2b
    800037ac:	88090913          	add	s2,s2,-1920 # 8002e028 <log>
    800037b0:	854a                	mv	a0,s2
    800037b2:	00006097          	auipc	ra,0x6
    800037b6:	0c0080e7          	jalr	192(ra) # 80009872 <acquire>
  for (i = 0; i < log.lh.n; i++) {
    800037ba:	02c92603          	lw	a2,44(s2)
    800037be:	06c05563          	blez	a2,80003828 <log_write+0xb6>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
    800037c2:	44cc                	lw	a1,12(s1)
    800037c4:	0002b717          	auipc	a4,0x2b
    800037c8:	89470713          	add	a4,a4,-1900 # 8002e058 <log+0x30>
  for (i = 0; i < log.lh.n; i++) {
    800037cc:	4781                	li	a5,0
    if (log.lh.block[i] == b->blockno)   // log absorbtion
    800037ce:	4314                	lw	a3,0(a4)
    800037d0:	04b68d63          	beq	a3,a1,8000382a <log_write+0xb8>
  for (i = 0; i < log.lh.n; i++) {
    800037d4:	2785                	addw	a5,a5,1
    800037d6:	0711                	add	a4,a4,4
    800037d8:	fec79be3          	bne	a5,a2,800037ce <log_write+0x5c>
      break;
  }
  log.lh.block[i] = b->blockno;
    800037dc:	0621                	add	a2,a2,8
    800037de:	060a                	sll	a2,a2,0x2
    800037e0:	0002b797          	auipc	a5,0x2b
    800037e4:	84878793          	add	a5,a5,-1976 # 8002e028 <log>
    800037e8:	97b2                	add	a5,a5,a2
    800037ea:	44d8                	lw	a4,12(s1)
    800037ec:	cb98                	sw	a4,16(a5)
  if (i == log.lh.n) {  // Add new block to log?
    bpin(b);
    800037ee:	8526                	mv	a0,s1
    800037f0:	fffff097          	auipc	ra,0xfffff
    800037f4:	daa080e7          	jalr	-598(ra) # 8000259a <bpin>
    log.lh.n++;
    800037f8:	0002b717          	auipc	a4,0x2b
    800037fc:	83070713          	add	a4,a4,-2000 # 8002e028 <log>
    80003800:	575c                	lw	a5,44(a4)
    80003802:	2785                	addw	a5,a5,1
    80003804:	d75c                	sw	a5,44(a4)
    80003806:	a835                	j	80003842 <log_write+0xd0>
    panic("too big a transaction");
    80003808:	00008517          	auipc	a0,0x8
    8000380c:	cc850513          	add	a0,a0,-824 # 8000b4d0 <etext+0x4d0>
    80003810:	00006097          	auipc	ra,0x6
    80003814:	ac8080e7          	jalr	-1336(ra) # 800092d8 <panic>
    panic("log_write outside of trans");
    80003818:	00008517          	auipc	a0,0x8
    8000381c:	cd050513          	add	a0,a0,-816 # 8000b4e8 <etext+0x4e8>
    80003820:	00006097          	auipc	ra,0x6
    80003824:	ab8080e7          	jalr	-1352(ra) # 800092d8 <panic>
  for (i = 0; i < log.lh.n; i++) {
    80003828:	4781                	li	a5,0
  log.lh.block[i] = b->blockno;
    8000382a:	00878693          	add	a3,a5,8
    8000382e:	068a                	sll	a3,a3,0x2
    80003830:	0002a717          	auipc	a4,0x2a
    80003834:	7f870713          	add	a4,a4,2040 # 8002e028 <log>
    80003838:	9736                	add	a4,a4,a3
    8000383a:	44d4                	lw	a3,12(s1)
    8000383c:	cb14                	sw	a3,16(a4)
  if (i == log.lh.n) {  // Add new block to log?
    8000383e:	faf608e3          	beq	a2,a5,800037ee <log_write+0x7c>
  }
  release(&log.lock);
    80003842:	0002a517          	auipc	a0,0x2a
    80003846:	7e650513          	add	a0,a0,2022 # 8002e028 <log>
    8000384a:	00006097          	auipc	ra,0x6
    8000384e:	0ee080e7          	jalr	238(ra) # 80009938 <release>
}
    80003852:	60e2                	ld	ra,24(sp)
    80003854:	6442                	ld	s0,16(sp)
    80003856:	64a2                	ld	s1,8(sp)
    80003858:	6902                	ld	s2,0(sp)
    8000385a:	6105                	add	sp,sp,32
    8000385c:	8082                	ret

000000008000385e <initsleeplock>:
#include "proc.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
    8000385e:	1101                	add	sp,sp,-32
    80003860:	ec06                	sd	ra,24(sp)
    80003862:	e822                	sd	s0,16(sp)
    80003864:	e426                	sd	s1,8(sp)
    80003866:	e04a                	sd	s2,0(sp)
    80003868:	1000                	add	s0,sp,32
    8000386a:	84aa                	mv	s1,a0
    8000386c:	892e                	mv	s2,a1
  initlock(&lk->lk, "sleep lock");
    8000386e:	00008597          	auipc	a1,0x8
    80003872:	c9a58593          	add	a1,a1,-870 # 8000b508 <etext+0x508>
    80003876:	0521                	add	a0,a0,8
    80003878:	00006097          	auipc	ra,0x6
    8000387c:	f6a080e7          	jalr	-150(ra) # 800097e2 <initlock>
  lk->name = name;
    80003880:	0324b023          	sd	s2,32(s1)
  lk->locked = 0;
    80003884:	0004a023          	sw	zero,0(s1)
  lk->pid = 0;
    80003888:	0204a423          	sw	zero,40(s1)
}
    8000388c:	60e2                	ld	ra,24(sp)
    8000388e:	6442                	ld	s0,16(sp)
    80003890:	64a2                	ld	s1,8(sp)
    80003892:	6902                	ld	s2,0(sp)
    80003894:	6105                	add	sp,sp,32
    80003896:	8082                	ret

0000000080003898 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
    80003898:	1101                	add	sp,sp,-32
    8000389a:	ec06                	sd	ra,24(sp)
    8000389c:	e822                	sd	s0,16(sp)
    8000389e:	e426                	sd	s1,8(sp)
    800038a0:	e04a                	sd	s2,0(sp)
    800038a2:	1000                	add	s0,sp,32
    800038a4:	84aa                	mv	s1,a0
  acquire(&lk->lk);
    800038a6:	00850913          	add	s2,a0,8
    800038aa:	854a                	mv	a0,s2
    800038ac:	00006097          	auipc	ra,0x6
    800038b0:	fc6080e7          	jalr	-58(ra) # 80009872 <acquire>
  while (lk->locked) {
    800038b4:	409c                	lw	a5,0(s1)
    800038b6:	cb89                	beqz	a5,800038c8 <acquiresleep+0x30>
    sleep(lk, &lk->lk);
    800038b8:	85ca                	mv	a1,s2
    800038ba:	8526                	mv	a0,s1
    800038bc:	ffffe097          	auipc	ra,0xffffe
    800038c0:	ea2080e7          	jalr	-350(ra) # 8000175e <sleep>
  while (lk->locked) {
    800038c4:	409c                	lw	a5,0(s1)
    800038c6:	fbed                	bnez	a5,800038b8 <acquiresleep+0x20>
  }
  lk->locked = 1;
    800038c8:	4785                	li	a5,1
    800038ca:	c09c                	sw	a5,0(s1)
  lk->pid = myproc()->pid;
    800038cc:	ffffd097          	auipc	ra,0xffffd
    800038d0:	67a080e7          	jalr	1658(ra) # 80000f46 <myproc>
    800038d4:	5d1c                	lw	a5,56(a0)
    800038d6:	d49c                	sw	a5,40(s1)
  release(&lk->lk);
    800038d8:	854a                	mv	a0,s2
    800038da:	00006097          	auipc	ra,0x6
    800038de:	05e080e7          	jalr	94(ra) # 80009938 <release>
}
    800038e2:	60e2                	ld	ra,24(sp)
    800038e4:	6442                	ld	s0,16(sp)
    800038e6:	64a2                	ld	s1,8(sp)
    800038e8:	6902                	ld	s2,0(sp)
    800038ea:	6105                	add	sp,sp,32
    800038ec:	8082                	ret

00000000800038ee <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
    800038ee:	1101                	add	sp,sp,-32
    800038f0:	ec06                	sd	ra,24(sp)
    800038f2:	e822                	sd	s0,16(sp)
    800038f4:	e426                	sd	s1,8(sp)
    800038f6:	e04a                	sd	s2,0(sp)
    800038f8:	1000                	add	s0,sp,32
    800038fa:	84aa                	mv	s1,a0
  acquire(&lk->lk);
    800038fc:	00850913          	add	s2,a0,8
    80003900:	854a                	mv	a0,s2
    80003902:	00006097          	auipc	ra,0x6
    80003906:	f70080e7          	jalr	-144(ra) # 80009872 <acquire>
  lk->locked = 0;
    8000390a:	0004a023          	sw	zero,0(s1)
  lk->pid = 0;
    8000390e:	0204a423          	sw	zero,40(s1)
  wakeup(lk);
    80003912:	8526                	mv	a0,s1
    80003914:	ffffe097          	auipc	ra,0xffffe
    80003918:	fca080e7          	jalr	-54(ra) # 800018de <wakeup>
  release(&lk->lk);
    8000391c:	854a                	mv	a0,s2
    8000391e:	00006097          	auipc	ra,0x6
    80003922:	01a080e7          	jalr	26(ra) # 80009938 <release>
}
    80003926:	60e2                	ld	ra,24(sp)
    80003928:	6442                	ld	s0,16(sp)
    8000392a:	64a2                	ld	s1,8(sp)
    8000392c:	6902                	ld	s2,0(sp)
    8000392e:	6105                	add	sp,sp,32
    80003930:	8082                	ret

0000000080003932 <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
    80003932:	7179                	add	sp,sp,-48
    80003934:	f406                	sd	ra,40(sp)
    80003936:	f022                	sd	s0,32(sp)
    80003938:	ec26                	sd	s1,24(sp)
    8000393a:	e84a                	sd	s2,16(sp)
    8000393c:	1800                	add	s0,sp,48
    8000393e:	84aa                	mv	s1,a0
  int r;
  
  acquire(&lk->lk);
    80003940:	00850913          	add	s2,a0,8
    80003944:	854a                	mv	a0,s2
    80003946:	00006097          	auipc	ra,0x6
    8000394a:	f2c080e7          	jalr	-212(ra) # 80009872 <acquire>
  r = lk->locked && (lk->pid == myproc()->pid);
    8000394e:	409c                	lw	a5,0(s1)
    80003950:	ef91                	bnez	a5,8000396c <holdingsleep+0x3a>
    80003952:	4481                	li	s1,0
  release(&lk->lk);
    80003954:	854a                	mv	a0,s2
    80003956:	00006097          	auipc	ra,0x6
    8000395a:	fe2080e7          	jalr	-30(ra) # 80009938 <release>
  return r;
}
    8000395e:	8526                	mv	a0,s1
    80003960:	70a2                	ld	ra,40(sp)
    80003962:	7402                	ld	s0,32(sp)
    80003964:	64e2                	ld	s1,24(sp)
    80003966:	6942                	ld	s2,16(sp)
    80003968:	6145                	add	sp,sp,48
    8000396a:	8082                	ret
    8000396c:	e44e                	sd	s3,8(sp)
  r = lk->locked && (lk->pid == myproc()->pid);
    8000396e:	0284a983          	lw	s3,40(s1)
    80003972:	ffffd097          	auipc	ra,0xffffd
    80003976:	5d4080e7          	jalr	1492(ra) # 80000f46 <myproc>
    8000397a:	5d04                	lw	s1,56(a0)
    8000397c:	413484b3          	sub	s1,s1,s3
    80003980:	0014b493          	seqz	s1,s1
    80003984:	69a2                	ld	s3,8(sp)
    80003986:	b7f9                	j	80003954 <holdingsleep+0x22>

0000000080003988 <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
    80003988:	1141                	add	sp,sp,-16
    8000398a:	e406                	sd	ra,8(sp)
    8000398c:	e022                	sd	s0,0(sp)
    8000398e:	0800                	add	s0,sp,16
  initlock(&ftable.lock, "ftable");
    80003990:	00008597          	auipc	a1,0x8
    80003994:	b8858593          	add	a1,a1,-1144 # 8000b518 <etext+0x518>
    80003998:	0002a517          	auipc	a0,0x2a
    8000399c:	7d850513          	add	a0,a0,2008 # 8002e170 <ftable>
    800039a0:	00006097          	auipc	ra,0x6
    800039a4:	e42080e7          	jalr	-446(ra) # 800097e2 <initlock>
}
    800039a8:	60a2                	ld	ra,8(sp)
    800039aa:	6402                	ld	s0,0(sp)
    800039ac:	0141                	add	sp,sp,16
    800039ae:	8082                	ret

00000000800039b0 <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
    800039b0:	1101                	add	sp,sp,-32
    800039b2:	ec06                	sd	ra,24(sp)
    800039b4:	e822                	sd	s0,16(sp)
    800039b6:	e426                	sd	s1,8(sp)
    800039b8:	1000                	add	s0,sp,32
  struct file *f;

  acquire(&ftable.lock);
    800039ba:	0002a517          	auipc	a0,0x2a
    800039be:	7b650513          	add	a0,a0,1974 # 8002e170 <ftable>
    800039c2:	00006097          	auipc	ra,0x6
    800039c6:	eb0080e7          	jalr	-336(ra) # 80009872 <acquire>
  for(f = ftable.file; f < ftable.file + NFILE; f++){
    800039ca:	0002a497          	auipc	s1,0x2a
    800039ce:	7be48493          	add	s1,s1,1982 # 8002e188 <ftable+0x18>
    800039d2:	00038717          	auipc	a4,0x38
    800039d6:	27670713          	add	a4,a4,630 # 8003bc48 <ftable+0xdad8>
    if(f->ref == 0){
    800039da:	40dc                	lw	a5,4(s1)
    800039dc:	cf99                	beqz	a5,800039fa <filealloc+0x4a>
  for(f = ftable.file; f < ftable.file + NFILE; f++){
    800039de:	03848493          	add	s1,s1,56
    800039e2:	fee49ce3          	bne	s1,a4,800039da <filealloc+0x2a>
      f->ref = 1;
      release(&ftable.lock);
      return f;
    }
  }
  release(&ftable.lock);
    800039e6:	0002a517          	auipc	a0,0x2a
    800039ea:	78a50513          	add	a0,a0,1930 # 8002e170 <ftable>
    800039ee:	00006097          	auipc	ra,0x6
    800039f2:	f4a080e7          	jalr	-182(ra) # 80009938 <release>
  return 0;
    800039f6:	4481                	li	s1,0
    800039f8:	a819                	j	80003a0e <filealloc+0x5e>
      f->ref = 1;
    800039fa:	4785                	li	a5,1
    800039fc:	c0dc                	sw	a5,4(s1)
      release(&ftable.lock);
    800039fe:	0002a517          	auipc	a0,0x2a
    80003a02:	77250513          	add	a0,a0,1906 # 8002e170 <ftable>
    80003a06:	00006097          	auipc	ra,0x6
    80003a0a:	f32080e7          	jalr	-206(ra) # 80009938 <release>
}
    80003a0e:	8526                	mv	a0,s1
    80003a10:	60e2                	ld	ra,24(sp)
    80003a12:	6442                	ld	s0,16(sp)
    80003a14:	64a2                	ld	s1,8(sp)
    80003a16:	6105                	add	sp,sp,32
    80003a18:	8082                	ret

0000000080003a1a <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
    80003a1a:	1101                	add	sp,sp,-32
    80003a1c:	ec06                	sd	ra,24(sp)
    80003a1e:	e822                	sd	s0,16(sp)
    80003a20:	e426                	sd	s1,8(sp)
    80003a22:	1000                	add	s0,sp,32
    80003a24:	84aa                	mv	s1,a0
  acquire(&ftable.lock);
    80003a26:	0002a517          	auipc	a0,0x2a
    80003a2a:	74a50513          	add	a0,a0,1866 # 8002e170 <ftable>
    80003a2e:	00006097          	auipc	ra,0x6
    80003a32:	e44080e7          	jalr	-444(ra) # 80009872 <acquire>
  if(f->ref < 1)
    80003a36:	40dc                	lw	a5,4(s1)
    80003a38:	02f05263          	blez	a5,80003a5c <filedup+0x42>
    panic("filedup");
  f->ref++;
    80003a3c:	2785                	addw	a5,a5,1
    80003a3e:	c0dc                	sw	a5,4(s1)
  release(&ftable.lock);
    80003a40:	0002a517          	auipc	a0,0x2a
    80003a44:	73050513          	add	a0,a0,1840 # 8002e170 <ftable>
    80003a48:	00006097          	auipc	ra,0x6
    80003a4c:	ef0080e7          	jalr	-272(ra) # 80009938 <release>
  return f;
}
    80003a50:	8526                	mv	a0,s1
    80003a52:	60e2                	ld	ra,24(sp)
    80003a54:	6442                	ld	s0,16(sp)
    80003a56:	64a2                	ld	s1,8(sp)
    80003a58:	6105                	add	sp,sp,32
    80003a5a:	8082                	ret
    panic("filedup");
    80003a5c:	00008517          	auipc	a0,0x8
    80003a60:	ac450513          	add	a0,a0,-1340 # 8000b520 <etext+0x520>
    80003a64:	00006097          	auipc	ra,0x6
    80003a68:	874080e7          	jalr	-1932(ra) # 800092d8 <panic>

0000000080003a6c <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
    80003a6c:	711d                	add	sp,sp,-96
    80003a6e:	ec86                	sd	ra,88(sp)
    80003a70:	e8a2                	sd	s0,80(sp)
    80003a72:	e4a6                	sd	s1,72(sp)
    80003a74:	1080                	add	s0,sp,96
    80003a76:	84aa                	mv	s1,a0
  struct file ff;

  acquire(&ftable.lock);
    80003a78:	0002a517          	auipc	a0,0x2a
    80003a7c:	6f850513          	add	a0,a0,1784 # 8002e170 <ftable>
    80003a80:	00006097          	auipc	ra,0x6
    80003a84:	df2080e7          	jalr	-526(ra) # 80009872 <acquire>
  if(f->ref < 1)
    80003a88:	40dc                	lw	a5,4(s1)
    80003a8a:	08f05163          	blez	a5,80003b0c <fileclose+0xa0>
    panic("fileclose");
  if(--f->ref > 0){
    80003a8e:	37fd                	addw	a5,a5,-1
    80003a90:	0007871b          	sext.w	a4,a5
    80003a94:	c0dc                	sw	a5,4(s1)
    80003a96:	08e04363          	bgtz	a4,80003b1c <fileclose+0xb0>
    release(&ftable.lock);
    return;
  }
  ff = *f;
    80003a9a:	0004b803          	ld	a6,0(s1)
    80003a9e:	6488                	ld	a0,8(s1)
    80003aa0:	688c                	ld	a1,16(s1)
    80003aa2:	6c90                	ld	a2,24(s1)
    80003aa4:	7094                	ld	a3,32(s1)
    80003aa6:	7498                	ld	a4,40(s1)
    80003aa8:	789c                	ld	a5,48(s1)
    80003aaa:	fb043423          	sd	a6,-88(s0)
    80003aae:	faa43823          	sd	a0,-80(s0)
    80003ab2:	fab43c23          	sd	a1,-72(s0)
    80003ab6:	fcc43023          	sd	a2,-64(s0)
    80003aba:	fcd43423          	sd	a3,-56(s0)
    80003abe:	fce43823          	sd	a4,-48(s0)
    80003ac2:	fcf43c23          	sd	a5,-40(s0)
  f->ref = 0;
    80003ac6:	0004a223          	sw	zero,4(s1)
  f->type = FD_NONE;
    80003aca:	0004a023          	sw	zero,0(s1)
  release(&ftable.lock);
    80003ace:	0002a517          	auipc	a0,0x2a
    80003ad2:	6a250513          	add	a0,a0,1698 # 8002e170 <ftable>
    80003ad6:	00006097          	auipc	ra,0x6
    80003ada:	e62080e7          	jalr	-414(ra) # 80009938 <release>

  if(ff.type == FD_PIPE){
    80003ade:	fa842783          	lw	a5,-88(s0)
    80003ae2:	4705                	li	a4,1
    80003ae4:	04e78963          	beq	a5,a4,80003b36 <fileclose+0xca>
    pipeclose(ff.pipe, ff.writable);
  } else if(ff.type == FD_INODE || ff.type == FD_DEVICE){
    80003ae8:	ffe7871b          	addw	a4,a5,-2
    80003aec:	4685                	li	a3,1
    80003aee:	04e6fd63          	bgeu	a3,a4,80003b48 <fileclose+0xdc>
    begin_op();
    iput(ff.ip);
    end_op();
  } else if(ff.type == FD_SOCK_UDP){
    80003af2:	4711                	li	a4,4
    80003af4:	06e78963          	beq	a5,a4,80003b66 <fileclose+0xfa>
    sockclose(ff.sock);
  } else if (ff.type == FD_SOCK_TCP){
    80003af8:	4715                	li	a4,5
    80003afa:	02e79963          	bne	a5,a4,80003b2c <fileclose+0xc0>
    tcp_close(&ff);
    80003afe:	fa840513          	add	a0,s0,-88
    80003b02:	00005097          	auipc	ra,0x5
    80003b06:	ade080e7          	jalr	-1314(ra) # 800085e0 <tcp_close>
    80003b0a:	a00d                	j	80003b2c <fileclose+0xc0>
    panic("fileclose");
    80003b0c:	00008517          	auipc	a0,0x8
    80003b10:	a1c50513          	add	a0,a0,-1508 # 8000b528 <etext+0x528>
    80003b14:	00005097          	auipc	ra,0x5
    80003b18:	7c4080e7          	jalr	1988(ra) # 800092d8 <panic>
    release(&ftable.lock);
    80003b1c:	0002a517          	auipc	a0,0x2a
    80003b20:	65450513          	add	a0,a0,1620 # 8002e170 <ftable>
    80003b24:	00006097          	auipc	ra,0x6
    80003b28:	e14080e7          	jalr	-492(ra) # 80009938 <release>
  }
}
    80003b2c:	60e6                	ld	ra,88(sp)
    80003b2e:	6446                	ld	s0,80(sp)
    80003b30:	64a6                	ld	s1,72(sp)
    80003b32:	6125                	add	sp,sp,96
    80003b34:	8082                	ret
    pipeclose(ff.pipe, ff.writable);
    80003b36:	fb144583          	lbu	a1,-79(s0)
    80003b3a:	fb843503          	ld	a0,-72(s0)
    80003b3e:	00000097          	auipc	ra,0x0
    80003b42:	3de080e7          	jalr	990(ra) # 80003f1c <pipeclose>
    80003b46:	b7dd                	j	80003b2c <fileclose+0xc0>
    begin_op();
    80003b48:	00000097          	auipc	ra,0x0
    80003b4c:	a52080e7          	jalr	-1454(ra) # 8000359a <begin_op>
    iput(ff.ip);
    80003b50:	fc043503          	ld	a0,-64(s0)
    80003b54:	fffff097          	auipc	ra,0xfffff
    80003b58:	232080e7          	jalr	562(ra) # 80002d86 <iput>
    end_op();
    80003b5c:	00000097          	auipc	ra,0x0
    80003b60:	ab8080e7          	jalr	-1352(ra) # 80003614 <end_op>
    80003b64:	b7e1                	j	80003b2c <fileclose+0xc0>
    sockclose(ff.sock);
    80003b66:	fc843503          	ld	a0,-56(s0)
    80003b6a:	00003097          	auipc	ra,0x3
    80003b6e:	d36080e7          	jalr	-714(ra) # 800068a0 <sockclose>
    80003b72:	bf6d                	j	80003b2c <fileclose+0xc0>

0000000080003b74 <filestat>:

// Get metadata about file f.
// addr is a user virtual address, pointing to a struct stat.
int
filestat(struct file *f, uint64 addr)
{
    80003b74:	715d                	add	sp,sp,-80
    80003b76:	e486                	sd	ra,72(sp)
    80003b78:	e0a2                	sd	s0,64(sp)
    80003b7a:	fc26                	sd	s1,56(sp)
    80003b7c:	f44e                	sd	s3,40(sp)
    80003b7e:	0880                	add	s0,sp,80
    80003b80:	84aa                	mv	s1,a0
    80003b82:	89ae                	mv	s3,a1
  struct proc *p = myproc();
    80003b84:	ffffd097          	auipc	ra,0xffffd
    80003b88:	3c2080e7          	jalr	962(ra) # 80000f46 <myproc>
  struct stat st;
  
  if(f->type == FD_INODE || f->type == FD_DEVICE){
    80003b8c:	409c                	lw	a5,0(s1)
    80003b8e:	37f9                	addw	a5,a5,-2
    80003b90:	4705                	li	a4,1
    80003b92:	04f76863          	bltu	a4,a5,80003be2 <filestat+0x6e>
    80003b96:	f84a                	sd	s2,48(sp)
    80003b98:	892a                	mv	s2,a0
    ilock(f->ip);
    80003b9a:	6c88                	ld	a0,24(s1)
    80003b9c:	fffff097          	auipc	ra,0xfffff
    80003ba0:	02c080e7          	jalr	44(ra) # 80002bc8 <ilock>
    stati(f->ip, &st);
    80003ba4:	fb840593          	add	a1,s0,-72
    80003ba8:	6c88                	ld	a0,24(s1)
    80003baa:	fffff097          	auipc	ra,0xfffff
    80003bae:	2ac080e7          	jalr	684(ra) # 80002e56 <stati>
    iunlock(f->ip);
    80003bb2:	6c88                	ld	a0,24(s1)
    80003bb4:	fffff097          	auipc	ra,0xfffff
    80003bb8:	0da080e7          	jalr	218(ra) # 80002c8e <iunlock>
    if(copyout(p->pagetable, addr, (char *)&st, sizeof(st)) < 0)
    80003bbc:	46e1                	li	a3,24
    80003bbe:	fb840613          	add	a2,s0,-72
    80003bc2:	85ce                	mv	a1,s3
    80003bc4:	05093503          	ld	a0,80(s2)
    80003bc8:	ffffd097          	auipc	ra,0xffffd
    80003bcc:	ffa080e7          	jalr	-6(ra) # 80000bc2 <copyout>
    80003bd0:	41f5551b          	sraw	a0,a0,0x1f
    80003bd4:	7942                	ld	s2,48(sp)
      return -1;
    return 0;
  }
  return -1;
}
    80003bd6:	60a6                	ld	ra,72(sp)
    80003bd8:	6406                	ld	s0,64(sp)
    80003bda:	74e2                	ld	s1,56(sp)
    80003bdc:	79a2                	ld	s3,40(sp)
    80003bde:	6161                	add	sp,sp,80
    80003be0:	8082                	ret
  return -1;
    80003be2:	557d                	li	a0,-1
    80003be4:	bfcd                	j	80003bd6 <filestat+0x62>

0000000080003be6 <fileread>:

// Read from file f.
// addr is a user virtual address.
int
fileread(struct file *f, uint64 addr, int n)
{
    80003be6:	7179                	add	sp,sp,-48
    80003be8:	f406                	sd	ra,40(sp)
    80003bea:	f022                	sd	s0,32(sp)
    80003bec:	e84a                	sd	s2,16(sp)
    80003bee:	1800                	add	s0,sp,48
  int r = 0;

  if(f->readable == 0)
    80003bf0:	00854783          	lbu	a5,8(a0)
    80003bf4:	cff1                	beqz	a5,80003cd0 <fileread+0xea>
    80003bf6:	ec26                	sd	s1,24(sp)
    80003bf8:	e44e                	sd	s3,8(sp)
    80003bfa:	84aa                	mv	s1,a0
    80003bfc:	89ae                	mv	s3,a1
    80003bfe:	8932                	mv	s2,a2
    return -1;

  if(f->type == FD_PIPE){
    80003c00:	4118                	lw	a4,0(a0)
    80003c02:	4795                	li	a5,5
    80003c04:	0ae7ee63          	bltu	a5,a4,80003cc0 <fileread+0xda>
    80003c08:	00056783          	lwu	a5,0(a0)
    80003c0c:	078a                	sll	a5,a5,0x2
    80003c0e:	00008697          	auipc	a3,0x8
    80003c12:	e6a68693          	add	a3,a3,-406 # 8000ba78 <syscalls+0x118>
    80003c16:	97b6                	add	a5,a5,a3
    80003c18:	439c                	lw	a5,0(a5)
    80003c1a:	97b6                	add	a5,a5,a3
    80003c1c:	8782                	jr	a5
    r = piperead(f->pipe, addr, n);
    80003c1e:	6908                	ld	a0,16(a0)
    80003c20:	00000097          	auipc	ra,0x0
    80003c24:	46e080e7          	jalr	1134(ra) # 8000408e <piperead>
    80003c28:	892a                	mv	s2,a0
    80003c2a:	64e2                	ld	s1,24(sp)
    80003c2c:	69a2                	ld	s3,8(sp)
  else {
    panic("fileread");
  }

  return r;
}
    80003c2e:	854a                	mv	a0,s2
    80003c30:	70a2                	ld	ra,40(sp)
    80003c32:	7402                	ld	s0,32(sp)
    80003c34:	6942                	ld	s2,16(sp)
    80003c36:	6145                	add	sp,sp,48
    80003c38:	8082                	ret
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].read)
    80003c3a:	03451783          	lh	a5,52(a0)
    80003c3e:	03079693          	sll	a3,a5,0x30
    80003c42:	92c1                	srl	a3,a3,0x30
    80003c44:	4725                	li	a4,9
    80003c46:	08d76763          	bltu	a4,a3,80003cd4 <fileread+0xee>
    80003c4a:	0792                	sll	a5,a5,0x4
    80003c4c:	0002a717          	auipc	a4,0x2a
    80003c50:	48470713          	add	a4,a4,1156 # 8002e0d0 <devsw>
    80003c54:	97ba                	add	a5,a5,a4
    80003c56:	639c                	ld	a5,0(a5)
    80003c58:	c3d1                	beqz	a5,80003cdc <fileread+0xf6>
    r = devsw[f->major].read(1, addr, n);
    80003c5a:	4505                	li	a0,1
    80003c5c:	9782                	jalr	a5
    80003c5e:	892a                	mv	s2,a0
    80003c60:	64e2                	ld	s1,24(sp)
    80003c62:	69a2                	ld	s3,8(sp)
    80003c64:	b7e9                	j	80003c2e <fileread+0x48>
    ilock(f->ip);
    80003c66:	6d08                	ld	a0,24(a0)
    80003c68:	fffff097          	auipc	ra,0xfffff
    80003c6c:	f60080e7          	jalr	-160(ra) # 80002bc8 <ilock>
    if((r = readi(f->ip, 1, addr, f->off, n)) > 0)
    80003c70:	874a                	mv	a4,s2
    80003c72:	5894                	lw	a3,48(s1)
    80003c74:	864e                	mv	a2,s3
    80003c76:	4585                	li	a1,1
    80003c78:	6c88                	ld	a0,24(s1)
    80003c7a:	fffff097          	auipc	ra,0xfffff
    80003c7e:	206080e7          	jalr	518(ra) # 80002e80 <readi>
    80003c82:	892a                	mv	s2,a0
    80003c84:	00a05563          	blez	a0,80003c8e <fileread+0xa8>
      f->off += r;
    80003c88:	589c                	lw	a5,48(s1)
    80003c8a:	9fa9                	addw	a5,a5,a0
    80003c8c:	d89c                	sw	a5,48(s1)
    iunlock(f->ip);
    80003c8e:	6c88                	ld	a0,24(s1)
    80003c90:	fffff097          	auipc	ra,0xfffff
    80003c94:	ffe080e7          	jalr	-2(ra) # 80002c8e <iunlock>
    80003c98:	64e2                	ld	s1,24(sp)
    80003c9a:	69a2                	ld	s3,8(sp)
    80003c9c:	bf49                	j	80003c2e <fileread+0x48>
    r = sockread(f->sock, addr, n);
    80003c9e:	7108                	ld	a0,32(a0)
    80003ca0:	00003097          	auipc	ra,0x3
    80003ca4:	c90080e7          	jalr	-880(ra) # 80006930 <sockread>
    80003ca8:	892a                	mv	s2,a0
    80003caa:	64e2                	ld	s1,24(sp)
    80003cac:	69a2                	ld	s3,8(sp)
    80003cae:	b741                	j	80003c2e <fileread+0x48>
    r = tcp_read(f, addr, n);
    80003cb0:	00005097          	auipc	ra,0x5
    80003cb4:	83a080e7          	jalr	-1990(ra) # 800084ea <tcp_read>
    80003cb8:	892a                	mv	s2,a0
    80003cba:	64e2                	ld	s1,24(sp)
    80003cbc:	69a2                	ld	s3,8(sp)
    80003cbe:	bf85                	j	80003c2e <fileread+0x48>
    panic("fileread");
    80003cc0:	00008517          	auipc	a0,0x8
    80003cc4:	87850513          	add	a0,a0,-1928 # 8000b538 <etext+0x538>
    80003cc8:	00005097          	auipc	ra,0x5
    80003ccc:	610080e7          	jalr	1552(ra) # 800092d8 <panic>
    return -1;
    80003cd0:	597d                	li	s2,-1
    80003cd2:	bfb1                	j	80003c2e <fileread+0x48>
      return -1;
    80003cd4:	597d                	li	s2,-1
    80003cd6:	64e2                	ld	s1,24(sp)
    80003cd8:	69a2                	ld	s3,8(sp)
    80003cda:	bf91                	j	80003c2e <fileread+0x48>
    80003cdc:	597d                	li	s2,-1
    80003cde:	64e2                	ld	s1,24(sp)
    80003ce0:	69a2                	ld	s3,8(sp)
    80003ce2:	b7b1                	j	80003c2e <fileread+0x48>

0000000080003ce4 <filewrite>:
int
filewrite(struct file *f, uint64 addr, int n)
{
  int r, ret = 0;

  if(f->writable == 0)
    80003ce4:	00954783          	lbu	a5,9(a0)
    80003ce8:	12078f63          	beqz	a5,80003e26 <filewrite+0x142>
{
    80003cec:	715d                	add	sp,sp,-80
    80003cee:	e486                	sd	ra,72(sp)
    80003cf0:	e0a2                	sd	s0,64(sp)
    80003cf2:	fc26                	sd	s1,56(sp)
    80003cf4:	f44e                	sd	s3,40(sp)
    80003cf6:	ec56                	sd	s5,24(sp)
    80003cf8:	0880                	add	s0,sp,80
    80003cfa:	84aa                	mv	s1,a0
    80003cfc:	8aae                	mv	s5,a1
    80003cfe:	89b2                	mv	s3,a2
    return -1;

  if(f->type == FD_PIPE){
    80003d00:	4118                	lw	a4,0(a0)
    80003d02:	4795                	li	a5,5
    80003d04:	10e7e463          	bltu	a5,a4,80003e0c <filewrite+0x128>
    80003d08:	00056783          	lwu	a5,0(a0)
    80003d0c:	078a                	sll	a5,a5,0x2
    80003d0e:	00008717          	auipc	a4,0x8
    80003d12:	d8270713          	add	a4,a4,-638 # 8000ba90 <syscalls+0x130>
    80003d16:	97ba                	add	a5,a5,a4
    80003d18:	439c                	lw	a5,0(a5)
    80003d1a:	97ba                	add	a5,a5,a4
    80003d1c:	8782                	jr	a5
    80003d1e:	f052                	sd	s4,32(sp)
    80003d20:	e45e                	sd	s7,8(sp)
    80003d22:	e062                	sd	s8,0(sp)
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * BSIZE;
    int i = 0;
    while(i < n){
    80003d24:	4a01                	li	s4,0
      int n1 = n - i;
      if(n1 > max)
    80003d26:	6b85                	lui	s7,0x1
    80003d28:	c00b8b93          	add	s7,s7,-1024 # c00 <_entry-0x7ffff400>
    80003d2c:	6c05                	lui	s8,0x1
    80003d2e:	c00c0c1b          	addw	s8,s8,-1024 # c00 <_entry-0x7ffff400>
    while(i < n){
    80003d32:	0ac05b63          	blez	a2,80003de8 <filewrite+0x104>
    80003d36:	f84a                	sd	s2,48(sp)
    80003d38:	e85a                	sd	s6,16(sp)
    80003d3a:	a851                	j	80003dce <filewrite+0xea>
    ret = pipewrite(f->pipe, addr, n);
    80003d3c:	6908                	ld	a0,16(a0)
    80003d3e:	00000097          	auipc	ra,0x0
    80003d42:	24e080e7          	jalr	590(ra) # 80003f8c <pipewrite>
  else {
    panic("filewrite");
  }

  return ret;
}
    80003d46:	60a6                	ld	ra,72(sp)
    80003d48:	6406                	ld	s0,64(sp)
    80003d4a:	74e2                	ld	s1,56(sp)
    80003d4c:	79a2                	ld	s3,40(sp)
    80003d4e:	6ae2                	ld	s5,24(sp)
    80003d50:	6161                	add	sp,sp,80
    80003d52:	8082                	ret
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].write)
    80003d54:	03451783          	lh	a5,52(a0)
    80003d58:	03079693          	sll	a3,a5,0x30
    80003d5c:	92c1                	srl	a3,a3,0x30
    80003d5e:	4725                	li	a4,9
    80003d60:	0cd76563          	bltu	a4,a3,80003e2a <filewrite+0x146>
    80003d64:	0792                	sll	a5,a5,0x4
    80003d66:	0002a717          	auipc	a4,0x2a
    80003d6a:	36a70713          	add	a4,a4,874 # 8002e0d0 <devsw>
    80003d6e:	97ba                	add	a5,a5,a4
    80003d70:	679c                	ld	a5,8(a5)
    80003d72:	cfd5                	beqz	a5,80003e2e <filewrite+0x14a>
    ret = devsw[f->major].write(1, addr, n);
    80003d74:	4505                	li	a0,1
    80003d76:	9782                	jalr	a5
    80003d78:	b7f9                	j	80003d46 <filewrite+0x62>
      if(n1 > max)
    80003d7a:	00090b1b          	sext.w	s6,s2
      begin_op();
    80003d7e:	00000097          	auipc	ra,0x0
    80003d82:	81c080e7          	jalr	-2020(ra) # 8000359a <begin_op>
      ilock(f->ip);
    80003d86:	6c88                	ld	a0,24(s1)
    80003d88:	fffff097          	auipc	ra,0xfffff
    80003d8c:	e40080e7          	jalr	-448(ra) # 80002bc8 <ilock>
      if ((r = writei(f->ip, 1, addr + i, f->off, n1)) > 0)
    80003d90:	875a                	mv	a4,s6
    80003d92:	5894                	lw	a3,48(s1)
    80003d94:	015a0633          	add	a2,s4,s5
    80003d98:	4585                	li	a1,1
    80003d9a:	6c88                	ld	a0,24(s1)
    80003d9c:	fffff097          	auipc	ra,0xfffff
    80003da0:	1e8080e7          	jalr	488(ra) # 80002f84 <writei>
    80003da4:	892a                	mv	s2,a0
    80003da6:	00a05563          	blez	a0,80003db0 <filewrite+0xcc>
        f->off += r;
    80003daa:	589c                	lw	a5,48(s1)
    80003dac:	9fa9                	addw	a5,a5,a0
    80003dae:	d89c                	sw	a5,48(s1)
      iunlock(f->ip);
    80003db0:	6c88                	ld	a0,24(s1)
    80003db2:	fffff097          	auipc	ra,0xfffff
    80003db6:	edc080e7          	jalr	-292(ra) # 80002c8e <iunlock>
      end_op();
    80003dba:	00000097          	auipc	ra,0x0
    80003dbe:	85a080e7          	jalr	-1958(ra) # 80003614 <end_op>
      if(r != n1){
    80003dc2:	032b1163          	bne	s6,s2,80003de4 <filewrite+0x100>
      i += r;
    80003dc6:	01490a3b          	addw	s4,s2,s4
    while(i < n){
    80003dca:	013a5a63          	bge	s4,s3,80003dde <filewrite+0xfa>
      int n1 = n - i;
    80003dce:	4149893b          	subw	s2,s3,s4
      if(n1 > max)
    80003dd2:	0009079b          	sext.w	a5,s2
    80003dd6:	fafbd2e3          	bge	s7,a5,80003d7a <filewrite+0x96>
    80003dda:	8962                	mv	s2,s8
    80003ddc:	bf79                	j	80003d7a <filewrite+0x96>
    80003dde:	7942                	ld	s2,48(sp)
    80003de0:	6b42                	ld	s6,16(sp)
    80003de2:	a019                	j	80003de8 <filewrite+0x104>
    80003de4:	7942                	ld	s2,48(sp)
    80003de6:	6b42                	ld	s6,16(sp)
    ret = (i == n ? n : -1);
    80003de8:	05499563          	bne	s3,s4,80003e32 <filewrite+0x14e>
    80003dec:	854e                	mv	a0,s3
    80003dee:	7a02                	ld	s4,32(sp)
    80003df0:	6ba2                	ld	s7,8(sp)
    80003df2:	6c02                	ld	s8,0(sp)
    80003df4:	bf89                	j	80003d46 <filewrite+0x62>
    ret = sockwrite(f->sock, addr, n);
    80003df6:	7108                	ld	a0,32(a0)
    80003df8:	00003097          	auipc	ra,0x3
    80003dfc:	c0a080e7          	jalr	-1014(ra) # 80006a02 <sockwrite>
    80003e00:	b799                	j	80003d46 <filewrite+0x62>
    ret = tcp_write(f, addr, n);
    80003e02:	00004097          	auipc	ra,0x4
    80003e06:	768080e7          	jalr	1896(ra) # 8000856a <tcp_write>
    80003e0a:	bf35                	j	80003d46 <filewrite+0x62>
    80003e0c:	f84a                	sd	s2,48(sp)
    80003e0e:	f052                	sd	s4,32(sp)
    80003e10:	e85a                	sd	s6,16(sp)
    80003e12:	e45e                	sd	s7,8(sp)
    80003e14:	e062                	sd	s8,0(sp)
    panic("filewrite");
    80003e16:	00007517          	auipc	a0,0x7
    80003e1a:	73250513          	add	a0,a0,1842 # 8000b548 <etext+0x548>
    80003e1e:	00005097          	auipc	ra,0x5
    80003e22:	4ba080e7          	jalr	1210(ra) # 800092d8 <panic>
    return -1;
    80003e26:	557d                	li	a0,-1
}
    80003e28:	8082                	ret
      return -1;
    80003e2a:	557d                	li	a0,-1
    80003e2c:	bf29                	j	80003d46 <filewrite+0x62>
    80003e2e:	557d                	li	a0,-1
    80003e30:	bf19                	j	80003d46 <filewrite+0x62>
    ret = (i == n ? n : -1);
    80003e32:	557d                	li	a0,-1
    80003e34:	7a02                	ld	s4,32(sp)
    80003e36:	6ba2                	ld	s7,8(sp)
    80003e38:	6c02                	ld	s8,0(sp)
    80003e3a:	b731                	j	80003d46 <filewrite+0x62>

0000000080003e3c <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
    80003e3c:	7179                	add	sp,sp,-48
    80003e3e:	f406                	sd	ra,40(sp)
    80003e40:	f022                	sd	s0,32(sp)
    80003e42:	ec26                	sd	s1,24(sp)
    80003e44:	e052                	sd	s4,0(sp)
    80003e46:	1800                	add	s0,sp,48
    80003e48:	84aa                	mv	s1,a0
    80003e4a:	8a2e                	mv	s4,a1
  struct pipe *pi;

  pi = 0;
  *f0 = *f1 = 0;
    80003e4c:	0005b023          	sd	zero,0(a1)
    80003e50:	00053023          	sd	zero,0(a0)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
    80003e54:	00000097          	auipc	ra,0x0
    80003e58:	b5c080e7          	jalr	-1188(ra) # 800039b0 <filealloc>
    80003e5c:	e088                	sd	a0,0(s1)
    80003e5e:	cd49                	beqz	a0,80003ef8 <pipealloc+0xbc>
    80003e60:	00000097          	auipc	ra,0x0
    80003e64:	b50080e7          	jalr	-1200(ra) # 800039b0 <filealloc>
    80003e68:	00aa3023          	sd	a0,0(s4)
    80003e6c:	c141                	beqz	a0,80003eec <pipealloc+0xb0>
    80003e6e:	e84a                	sd	s2,16(sp)
    goto bad;
  if((pi = (struct pipe*)kalloc()) == 0)
    80003e70:	ffffc097          	auipc	ra,0xffffc
    80003e74:	2aa080e7          	jalr	682(ra) # 8000011a <kalloc>
    80003e78:	892a                	mv	s2,a0
    80003e7a:	c13d                	beqz	a0,80003ee0 <pipealloc+0xa4>
    80003e7c:	e44e                	sd	s3,8(sp)
    goto bad;
  pi->readopen = 1;
    80003e7e:	4985                	li	s3,1
    80003e80:	23352023          	sw	s3,544(a0)
  pi->writeopen = 1;
    80003e84:	23352223          	sw	s3,548(a0)
  pi->nwrite = 0;
    80003e88:	20052e23          	sw	zero,540(a0)
  pi->nread = 0;
    80003e8c:	20052c23          	sw	zero,536(a0)
  initlock(&pi->lock, "pipe");
    80003e90:	00007597          	auipc	a1,0x7
    80003e94:	6c858593          	add	a1,a1,1736 # 8000b558 <etext+0x558>
    80003e98:	00006097          	auipc	ra,0x6
    80003e9c:	94a080e7          	jalr	-1718(ra) # 800097e2 <initlock>
  (*f0)->type = FD_PIPE;
    80003ea0:	609c                	ld	a5,0(s1)
    80003ea2:	0137a023          	sw	s3,0(a5)
  (*f0)->readable = 1;
    80003ea6:	609c                	ld	a5,0(s1)
    80003ea8:	01378423          	sb	s3,8(a5)
  (*f0)->writable = 0;
    80003eac:	609c                	ld	a5,0(s1)
    80003eae:	000784a3          	sb	zero,9(a5)
  (*f0)->pipe = pi;
    80003eb2:	609c                	ld	a5,0(s1)
    80003eb4:	0127b823          	sd	s2,16(a5)
  (*f1)->type = FD_PIPE;
    80003eb8:	000a3783          	ld	a5,0(s4)
    80003ebc:	0137a023          	sw	s3,0(a5)
  (*f1)->readable = 0;
    80003ec0:	000a3783          	ld	a5,0(s4)
    80003ec4:	00078423          	sb	zero,8(a5)
  (*f1)->writable = 1;
    80003ec8:	000a3783          	ld	a5,0(s4)
    80003ecc:	013784a3          	sb	s3,9(a5)
  (*f1)->pipe = pi;
    80003ed0:	000a3783          	ld	a5,0(s4)
    80003ed4:	0127b823          	sd	s2,16(a5)
  return 0;
    80003ed8:	4501                	li	a0,0
    80003eda:	6942                	ld	s2,16(sp)
    80003edc:	69a2                	ld	s3,8(sp)
    80003ede:	a03d                	j	80003f0c <pipealloc+0xd0>

 bad:
  if(pi)
    kfree((char*)pi);
  if(*f0)
    80003ee0:	6088                	ld	a0,0(s1)
    80003ee2:	c119                	beqz	a0,80003ee8 <pipealloc+0xac>
    80003ee4:	6942                	ld	s2,16(sp)
    80003ee6:	a029                	j	80003ef0 <pipealloc+0xb4>
    80003ee8:	6942                	ld	s2,16(sp)
    80003eea:	a039                	j	80003ef8 <pipealloc+0xbc>
    80003eec:	6088                	ld	a0,0(s1)
    80003eee:	c50d                	beqz	a0,80003f18 <pipealloc+0xdc>
    fileclose(*f0);
    80003ef0:	00000097          	auipc	ra,0x0
    80003ef4:	b7c080e7          	jalr	-1156(ra) # 80003a6c <fileclose>
  if(*f1)
    80003ef8:	000a3783          	ld	a5,0(s4)
    fileclose(*f1);
  return -1;
    80003efc:	557d                	li	a0,-1
  if(*f1)
    80003efe:	c799                	beqz	a5,80003f0c <pipealloc+0xd0>
    fileclose(*f1);
    80003f00:	853e                	mv	a0,a5
    80003f02:	00000097          	auipc	ra,0x0
    80003f06:	b6a080e7          	jalr	-1174(ra) # 80003a6c <fileclose>
  return -1;
    80003f0a:	557d                	li	a0,-1
}
    80003f0c:	70a2                	ld	ra,40(sp)
    80003f0e:	7402                	ld	s0,32(sp)
    80003f10:	64e2                	ld	s1,24(sp)
    80003f12:	6a02                	ld	s4,0(sp)
    80003f14:	6145                	add	sp,sp,48
    80003f16:	8082                	ret
  return -1;
    80003f18:	557d                	li	a0,-1
    80003f1a:	bfcd                	j	80003f0c <pipealloc+0xd0>

0000000080003f1c <pipeclose>:

void
pipeclose(struct pipe *pi, int writable)
{
    80003f1c:	1101                	add	sp,sp,-32
    80003f1e:	ec06                	sd	ra,24(sp)
    80003f20:	e822                	sd	s0,16(sp)
    80003f22:	e426                	sd	s1,8(sp)
    80003f24:	e04a                	sd	s2,0(sp)
    80003f26:	1000                	add	s0,sp,32
    80003f28:	84aa                	mv	s1,a0
    80003f2a:	892e                	mv	s2,a1
  acquire(&pi->lock);
    80003f2c:	00006097          	auipc	ra,0x6
    80003f30:	946080e7          	jalr	-1722(ra) # 80009872 <acquire>
  if(writable){
    80003f34:	02090d63          	beqz	s2,80003f6e <pipeclose+0x52>
    pi->writeopen = 0;
    80003f38:	2204a223          	sw	zero,548(s1)
    wakeup(&pi->nread);
    80003f3c:	21848513          	add	a0,s1,536
    80003f40:	ffffe097          	auipc	ra,0xffffe
    80003f44:	99e080e7          	jalr	-1634(ra) # 800018de <wakeup>
  } else {
    pi->readopen = 0;
    wakeup(&pi->nwrite);
  }
  if(pi->readopen == 0 && pi->writeopen == 0){
    80003f48:	2204b783          	ld	a5,544(s1)
    80003f4c:	eb95                	bnez	a5,80003f80 <pipeclose+0x64>
    release(&pi->lock);
    80003f4e:	8526                	mv	a0,s1
    80003f50:	00006097          	auipc	ra,0x6
    80003f54:	9e8080e7          	jalr	-1560(ra) # 80009938 <release>
    kfree((char*)pi);
    80003f58:	8526                	mv	a0,s1
    80003f5a:	ffffc097          	auipc	ra,0xffffc
    80003f5e:	0c2080e7          	jalr	194(ra) # 8000001c <kfree>
  } else
    release(&pi->lock);
}
    80003f62:	60e2                	ld	ra,24(sp)
    80003f64:	6442                	ld	s0,16(sp)
    80003f66:	64a2                	ld	s1,8(sp)
    80003f68:	6902                	ld	s2,0(sp)
    80003f6a:	6105                	add	sp,sp,32
    80003f6c:	8082                	ret
    pi->readopen = 0;
    80003f6e:	2204a023          	sw	zero,544(s1)
    wakeup(&pi->nwrite);
    80003f72:	21c48513          	add	a0,s1,540
    80003f76:	ffffe097          	auipc	ra,0xffffe
    80003f7a:	968080e7          	jalr	-1688(ra) # 800018de <wakeup>
    80003f7e:	b7e9                	j	80003f48 <pipeclose+0x2c>
    release(&pi->lock);
    80003f80:	8526                	mv	a0,s1
    80003f82:	00006097          	auipc	ra,0x6
    80003f86:	9b6080e7          	jalr	-1610(ra) # 80009938 <release>
}
    80003f8a:	bfe1                	j	80003f62 <pipeclose+0x46>

0000000080003f8c <pipewrite>:

int
pipewrite(struct pipe *pi, uint64 addr, int n)
{
    80003f8c:	711d                	add	sp,sp,-96
    80003f8e:	ec86                	sd	ra,88(sp)
    80003f90:	e8a2                	sd	s0,80(sp)
    80003f92:	e4a6                	sd	s1,72(sp)
    80003f94:	e0ca                	sd	s2,64(sp)
    80003f96:	fc4e                	sd	s3,56(sp)
    80003f98:	f852                	sd	s4,48(sp)
    80003f9a:	f456                	sd	s5,40(sp)
    80003f9c:	1080                	add	s0,sp,96
    80003f9e:	84aa                	mv	s1,a0
    80003fa0:	8aae                	mv	s5,a1
    80003fa2:	8a32                	mv	s4,a2
  int i = 0;
  struct proc *pr = myproc();
    80003fa4:	ffffd097          	auipc	ra,0xffffd
    80003fa8:	fa2080e7          	jalr	-94(ra) # 80000f46 <myproc>
    80003fac:	89aa                	mv	s3,a0

  acquire(&pi->lock);
    80003fae:	8526                	mv	a0,s1
    80003fb0:	00006097          	auipc	ra,0x6
    80003fb4:	8c2080e7          	jalr	-1854(ra) # 80009872 <acquire>
  while(i < n){
    80003fb8:	0d405563          	blez	s4,80004082 <pipewrite+0xf6>
    80003fbc:	f05a                	sd	s6,32(sp)
    80003fbe:	ec5e                	sd	s7,24(sp)
    80003fc0:	e862                	sd	s8,16(sp)
  int i = 0;
    80003fc2:	4901                	li	s2,0
    if(pi->nwrite == pi->nread + PIPESIZE){ //DOC: pipewrite-full
      wakeup(&pi->nread);
      sleep(&pi->nwrite, &pi->lock);
    } else {
      char ch;
      if(copyin(pr->pagetable, &ch, addr + i, 1) == -1)
    80003fc4:	5b7d                	li	s6,-1
      wakeup(&pi->nread);
    80003fc6:	21848c13          	add	s8,s1,536
      sleep(&pi->nwrite, &pi->lock);
    80003fca:	21c48b93          	add	s7,s1,540
    80003fce:	a089                	j	80004010 <pipewrite+0x84>
      release(&pi->lock);
    80003fd0:	8526                	mv	a0,s1
    80003fd2:	00006097          	auipc	ra,0x6
    80003fd6:	966080e7          	jalr	-1690(ra) # 80009938 <release>
      return -1;
    80003fda:	597d                	li	s2,-1
    80003fdc:	7b02                	ld	s6,32(sp)
    80003fde:	6be2                	ld	s7,24(sp)
    80003fe0:	6c42                	ld	s8,16(sp)
  }
  wakeup(&pi->nread);
  release(&pi->lock);

  return i;
}
    80003fe2:	854a                	mv	a0,s2
    80003fe4:	60e6                	ld	ra,88(sp)
    80003fe6:	6446                	ld	s0,80(sp)
    80003fe8:	64a6                	ld	s1,72(sp)
    80003fea:	6906                	ld	s2,64(sp)
    80003fec:	79e2                	ld	s3,56(sp)
    80003fee:	7a42                	ld	s4,48(sp)
    80003ff0:	7aa2                	ld	s5,40(sp)
    80003ff2:	6125                	add	sp,sp,96
    80003ff4:	8082                	ret
      wakeup(&pi->nread);
    80003ff6:	8562                	mv	a0,s8
    80003ff8:	ffffe097          	auipc	ra,0xffffe
    80003ffc:	8e6080e7          	jalr	-1818(ra) # 800018de <wakeup>
      sleep(&pi->nwrite, &pi->lock);
    80004000:	85a6                	mv	a1,s1
    80004002:	855e                	mv	a0,s7
    80004004:	ffffd097          	auipc	ra,0xffffd
    80004008:	75a080e7          	jalr	1882(ra) # 8000175e <sleep>
  while(i < n){
    8000400c:	05495c63          	bge	s2,s4,80004064 <pipewrite+0xd8>
    if(pi->readopen == 0 || pr->killed){
    80004010:	2204a783          	lw	a5,544(s1)
    80004014:	dfd5                	beqz	a5,80003fd0 <pipewrite+0x44>
    80004016:	0309a783          	lw	a5,48(s3)
    8000401a:	fbdd                	bnez	a5,80003fd0 <pipewrite+0x44>
    if(pi->nwrite == pi->nread + PIPESIZE){ //DOC: pipewrite-full
    8000401c:	2184a783          	lw	a5,536(s1)
    80004020:	21c4a703          	lw	a4,540(s1)
    80004024:	2007879b          	addw	a5,a5,512
    80004028:	fcf707e3          	beq	a4,a5,80003ff6 <pipewrite+0x6a>
      if(copyin(pr->pagetable, &ch, addr + i, 1) == -1)
    8000402c:	4685                	li	a3,1
    8000402e:	01590633          	add	a2,s2,s5
    80004032:	faf40593          	add	a1,s0,-81
    80004036:	0509b503          	ld	a0,80(s3)
    8000403a:	ffffd097          	auipc	ra,0xffffd
    8000403e:	c14080e7          	jalr	-1004(ra) # 80000c4e <copyin>
    80004042:	05650263          	beq	a0,s6,80004086 <pipewrite+0xfa>
      pi->data[pi->nwrite++ % PIPESIZE] = ch;
    80004046:	21c4a783          	lw	a5,540(s1)
    8000404a:	0017871b          	addw	a4,a5,1
    8000404e:	20e4ae23          	sw	a4,540(s1)
    80004052:	1ff7f793          	and	a5,a5,511
    80004056:	97a6                	add	a5,a5,s1
    80004058:	faf44703          	lbu	a4,-81(s0)
    8000405c:	00e78c23          	sb	a4,24(a5)
      i++;
    80004060:	2905                	addw	s2,s2,1
    80004062:	b76d                	j	8000400c <pipewrite+0x80>
    80004064:	7b02                	ld	s6,32(sp)
    80004066:	6be2                	ld	s7,24(sp)
    80004068:	6c42                	ld	s8,16(sp)
  wakeup(&pi->nread);
    8000406a:	21848513          	add	a0,s1,536
    8000406e:	ffffe097          	auipc	ra,0xffffe
    80004072:	870080e7          	jalr	-1936(ra) # 800018de <wakeup>
  release(&pi->lock);
    80004076:	8526                	mv	a0,s1
    80004078:	00006097          	auipc	ra,0x6
    8000407c:	8c0080e7          	jalr	-1856(ra) # 80009938 <release>
  return i;
    80004080:	b78d                	j	80003fe2 <pipewrite+0x56>
  int i = 0;
    80004082:	4901                	li	s2,0
    80004084:	b7dd                	j	8000406a <pipewrite+0xde>
    80004086:	7b02                	ld	s6,32(sp)
    80004088:	6be2                	ld	s7,24(sp)
    8000408a:	6c42                	ld	s8,16(sp)
    8000408c:	bff9                	j	8000406a <pipewrite+0xde>

000000008000408e <piperead>:

int
piperead(struct pipe *pi, uint64 addr, int n)
{
    8000408e:	715d                	add	sp,sp,-80
    80004090:	e486                	sd	ra,72(sp)
    80004092:	e0a2                	sd	s0,64(sp)
    80004094:	fc26                	sd	s1,56(sp)
    80004096:	f84a                	sd	s2,48(sp)
    80004098:	f44e                	sd	s3,40(sp)
    8000409a:	f052                	sd	s4,32(sp)
    8000409c:	ec56                	sd	s5,24(sp)
    8000409e:	0880                	add	s0,sp,80
    800040a0:	84aa                	mv	s1,a0
    800040a2:	892e                	mv	s2,a1
    800040a4:	8ab2                	mv	s5,a2
  int i;
  struct proc *pr = myproc();
    800040a6:	ffffd097          	auipc	ra,0xffffd
    800040aa:	ea0080e7          	jalr	-352(ra) # 80000f46 <myproc>
    800040ae:	8a2a                	mv	s4,a0
  char ch;

  acquire(&pi->lock);
    800040b0:	8526                	mv	a0,s1
    800040b2:	00005097          	auipc	ra,0x5
    800040b6:	7c0080e7          	jalr	1984(ra) # 80009872 <acquire>
  while(pi->nread == pi->nwrite && pi->writeopen){  //DOC: pipe-empty
    800040ba:	2184a703          	lw	a4,536(s1)
    800040be:	21c4a783          	lw	a5,540(s1)
    if(pr->killed){
      release(&pi->lock);
      return -1;
    }
    sleep(&pi->nread, &pi->lock); //DOC: piperead-sleep
    800040c2:	21848993          	add	s3,s1,536
  while(pi->nread == pi->nwrite && pi->writeopen){  //DOC: pipe-empty
    800040c6:	02f71663          	bne	a4,a5,800040f2 <piperead+0x64>
    800040ca:	2244a783          	lw	a5,548(s1)
    800040ce:	cb9d                	beqz	a5,80004104 <piperead+0x76>
    if(pr->killed){
    800040d0:	030a2783          	lw	a5,48(s4)
    800040d4:	e38d                	bnez	a5,800040f6 <piperead+0x68>
    sleep(&pi->nread, &pi->lock); //DOC: piperead-sleep
    800040d6:	85a6                	mv	a1,s1
    800040d8:	854e                	mv	a0,s3
    800040da:	ffffd097          	auipc	ra,0xffffd
    800040de:	684080e7          	jalr	1668(ra) # 8000175e <sleep>
  while(pi->nread == pi->nwrite && pi->writeopen){  //DOC: pipe-empty
    800040e2:	2184a703          	lw	a4,536(s1)
    800040e6:	21c4a783          	lw	a5,540(s1)
    800040ea:	fef700e3          	beq	a4,a5,800040ca <piperead+0x3c>
    800040ee:	e85a                	sd	s6,16(sp)
    800040f0:	a819                	j	80004106 <piperead+0x78>
    800040f2:	e85a                	sd	s6,16(sp)
    800040f4:	a809                	j	80004106 <piperead+0x78>
      release(&pi->lock);
    800040f6:	8526                	mv	a0,s1
    800040f8:	00006097          	auipc	ra,0x6
    800040fc:	840080e7          	jalr	-1984(ra) # 80009938 <release>
      return -1;
    80004100:	59fd                	li	s3,-1
    80004102:	a0a5                	j	8000416a <piperead+0xdc>
    80004104:	e85a                	sd	s6,16(sp)
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
    80004106:	4981                	li	s3,0
    if(pi->nread == pi->nwrite)
      break;
    ch = pi->data[pi->nread++ % PIPESIZE];
    if(copyout(pr->pagetable, addr + i, &ch, 1) == -1)
    80004108:	5b7d                	li	s6,-1
  for(i = 0; i < n; i++){  //DOC: piperead-copy
    8000410a:	05505463          	blez	s5,80004152 <piperead+0xc4>
    if(pi->nread == pi->nwrite)
    8000410e:	2184a783          	lw	a5,536(s1)
    80004112:	21c4a703          	lw	a4,540(s1)
    80004116:	02f70e63          	beq	a4,a5,80004152 <piperead+0xc4>
    ch = pi->data[pi->nread++ % PIPESIZE];
    8000411a:	0017871b          	addw	a4,a5,1
    8000411e:	20e4ac23          	sw	a4,536(s1)
    80004122:	1ff7f793          	and	a5,a5,511
    80004126:	97a6                	add	a5,a5,s1
    80004128:	0187c783          	lbu	a5,24(a5)
    8000412c:	faf40fa3          	sb	a5,-65(s0)
    if(copyout(pr->pagetable, addr + i, &ch, 1) == -1)
    80004130:	4685                	li	a3,1
    80004132:	fbf40613          	add	a2,s0,-65
    80004136:	85ca                	mv	a1,s2
    80004138:	050a3503          	ld	a0,80(s4)
    8000413c:	ffffd097          	auipc	ra,0xffffd
    80004140:	a86080e7          	jalr	-1402(ra) # 80000bc2 <copyout>
    80004144:	01650763          	beq	a0,s6,80004152 <piperead+0xc4>
  for(i = 0; i < n; i++){  //DOC: piperead-copy
    80004148:	2985                	addw	s3,s3,1
    8000414a:	0905                	add	s2,s2,1
    8000414c:	fd3a91e3          	bne	s5,s3,8000410e <piperead+0x80>
    80004150:	89d6                	mv	s3,s5
      break;
  }
  wakeup(&pi->nwrite);  //DOC: piperead-wakeup
    80004152:	21c48513          	add	a0,s1,540
    80004156:	ffffd097          	auipc	ra,0xffffd
    8000415a:	788080e7          	jalr	1928(ra) # 800018de <wakeup>
  release(&pi->lock);
    8000415e:	8526                	mv	a0,s1
    80004160:	00005097          	auipc	ra,0x5
    80004164:	7d8080e7          	jalr	2008(ra) # 80009938 <release>
    80004168:	6b42                	ld	s6,16(sp)
  return i;
}
    8000416a:	854e                	mv	a0,s3
    8000416c:	60a6                	ld	ra,72(sp)
    8000416e:	6406                	ld	s0,64(sp)
    80004170:	74e2                	ld	s1,56(sp)
    80004172:	7942                	ld	s2,48(sp)
    80004174:	79a2                	ld	s3,40(sp)
    80004176:	7a02                	ld	s4,32(sp)
    80004178:	6ae2                	ld	s5,24(sp)
    8000417a:	6161                	add	sp,sp,80
    8000417c:	8082                	ret

000000008000417e <exec>:

static int loadseg(pde_t *pgdir, uint64 addr, struct inode *ip, uint offset, uint sz);

int
exec(char *path, char **argv)
{
    8000417e:	df010113          	add	sp,sp,-528
    80004182:	20113423          	sd	ra,520(sp)
    80004186:	20813023          	sd	s0,512(sp)
    8000418a:	ffa6                	sd	s1,504(sp)
    8000418c:	fbca                	sd	s2,496(sp)
    8000418e:	0c00                	add	s0,sp,528
    80004190:	892a                	mv	s2,a0
    80004192:	dea43c23          	sd	a0,-520(s0)
    80004196:	e0b43023          	sd	a1,-512(s0)
  uint64 argc, sz = 0, sp, ustack[MAXARG+1], stackbase;
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pagetable_t pagetable = 0, oldpagetable;
  struct proc *p = myproc();
    8000419a:	ffffd097          	auipc	ra,0xffffd
    8000419e:	dac080e7          	jalr	-596(ra) # 80000f46 <myproc>
    800041a2:	84aa                	mv	s1,a0

  begin_op();
    800041a4:	fffff097          	auipc	ra,0xfffff
    800041a8:	3f6080e7          	jalr	1014(ra) # 8000359a <begin_op>

  if((ip = namei(path)) == 0){
    800041ac:	854a                	mv	a0,s2
    800041ae:	fffff097          	auipc	ra,0xfffff
    800041b2:	1ec080e7          	jalr	492(ra) # 8000339a <namei>
    800041b6:	c135                	beqz	a0,8000421a <exec+0x9c>
    800041b8:	f3d2                	sd	s4,480(sp)
    800041ba:	8a2a                	mv	s4,a0
    end_op();
    return -1;
  }
  ilock(ip);
    800041bc:	fffff097          	auipc	ra,0xfffff
    800041c0:	a0c080e7          	jalr	-1524(ra) # 80002bc8 <ilock>

  // Check ELF header
  if(readi(ip, 0, (uint64)&elf, 0, sizeof(elf)) != sizeof(elf))
    800041c4:	04000713          	li	a4,64
    800041c8:	4681                	li	a3,0
    800041ca:	e4840613          	add	a2,s0,-440
    800041ce:	4581                	li	a1,0
    800041d0:	8552                	mv	a0,s4
    800041d2:	fffff097          	auipc	ra,0xfffff
    800041d6:	cae080e7          	jalr	-850(ra) # 80002e80 <readi>
    800041da:	04000793          	li	a5,64
    800041de:	00f51a63          	bne	a0,a5,800041f2 <exec+0x74>
    goto bad;
  if(elf.magic != ELF_MAGIC)
    800041e2:	e4842703          	lw	a4,-440(s0)
    800041e6:	464c47b7          	lui	a5,0x464c4
    800041ea:	57f78793          	add	a5,a5,1407 # 464c457f <_entry-0x39b3ba81>
    800041ee:	02f70c63          	beq	a4,a5,80004226 <exec+0xa8>

 bad:
  if(pagetable)
    proc_freepagetable(pagetable, sz);
  if(ip){
    iunlockput(ip);
    800041f2:	8552                	mv	a0,s4
    800041f4:	fffff097          	auipc	ra,0xfffff
    800041f8:	c3a080e7          	jalr	-966(ra) # 80002e2e <iunlockput>
    end_op();
    800041fc:	fffff097          	auipc	ra,0xfffff
    80004200:	418080e7          	jalr	1048(ra) # 80003614 <end_op>
  }
  return -1;
    80004204:	557d                	li	a0,-1
    80004206:	7a1e                	ld	s4,480(sp)
}
    80004208:	20813083          	ld	ra,520(sp)
    8000420c:	20013403          	ld	s0,512(sp)
    80004210:	74fe                	ld	s1,504(sp)
    80004212:	795e                	ld	s2,496(sp)
    80004214:	21010113          	add	sp,sp,528
    80004218:	8082                	ret
    end_op();
    8000421a:	fffff097          	auipc	ra,0xfffff
    8000421e:	3fa080e7          	jalr	1018(ra) # 80003614 <end_op>
    return -1;
    80004222:	557d                	li	a0,-1
    80004224:	b7d5                	j	80004208 <exec+0x8a>
    80004226:	ebda                	sd	s6,464(sp)
  if((pagetable = proc_pagetable(p)) == 0)
    80004228:	8526                	mv	a0,s1
    8000422a:	ffffd097          	auipc	ra,0xffffd
    8000422e:	de0080e7          	jalr	-544(ra) # 8000100a <proc_pagetable>
    80004232:	8b2a                	mv	s6,a0
    80004234:	30050563          	beqz	a0,8000453e <exec+0x3c0>
    80004238:	f7ce                	sd	s3,488(sp)
    8000423a:	efd6                	sd	s5,472(sp)
    8000423c:	e7de                	sd	s7,456(sp)
    8000423e:	e3e2                	sd	s8,448(sp)
    80004240:	ff66                	sd	s9,440(sp)
    80004242:	fb6a                	sd	s10,432(sp)
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
    80004244:	e6842d03          	lw	s10,-408(s0)
    80004248:	e8045783          	lhu	a5,-384(s0)
    8000424c:	14078563          	beqz	a5,80004396 <exec+0x218>
    80004250:	f76e                	sd	s11,424(sp)
  uint64 argc, sz = 0, sp, ustack[MAXARG+1], stackbase;
    80004252:	4481                	li	s1,0
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
    80004254:	4d81                	li	s11,0
    if(ph.vaddr % PGSIZE != 0)
    80004256:	6c85                	lui	s9,0x1
    80004258:	fffc8793          	add	a5,s9,-1 # fff <_entry-0x7ffff001>
    8000425c:	def43823          	sd	a5,-528(s0)

  for(i = 0; i < sz; i += PGSIZE){
    pa = walkaddr(pagetable, va + i);
    if(pa == 0)
      panic("loadseg: address should exist");
    if(sz - i < PGSIZE)
    80004260:	6a85                	lui	s5,0x1
    80004262:	a0b5                	j	800042ce <exec+0x150>
      panic("loadseg: address should exist");
    80004264:	00007517          	auipc	a0,0x7
    80004268:	2fc50513          	add	a0,a0,764 # 8000b560 <etext+0x560>
    8000426c:	00005097          	auipc	ra,0x5
    80004270:	06c080e7          	jalr	108(ra) # 800092d8 <panic>
    if(sz - i < PGSIZE)
    80004274:	2481                	sext.w	s1,s1
      n = sz - i;
    else
      n = PGSIZE;
    if(readi(ip, 0, (uint64)pa, offset+i, n) != n)
    80004276:	8726                	mv	a4,s1
    80004278:	012c06bb          	addw	a3,s8,s2
    8000427c:	4581                	li	a1,0
    8000427e:	8552                	mv	a0,s4
    80004280:	fffff097          	auipc	ra,0xfffff
    80004284:	c00080e7          	jalr	-1024(ra) # 80002e80 <readi>
    80004288:	2501                	sext.w	a0,a0
    8000428a:	26a49e63          	bne	s1,a0,80004506 <exec+0x388>
  for(i = 0; i < sz; i += PGSIZE){
    8000428e:	012a893b          	addw	s2,s5,s2
    80004292:	03397563          	bgeu	s2,s3,800042bc <exec+0x13e>
    pa = walkaddr(pagetable, va + i);
    80004296:	02091593          	sll	a1,s2,0x20
    8000429a:	9181                	srl	a1,a1,0x20
    8000429c:	95de                	add	a1,a1,s7
    8000429e:	855a                	mv	a0,s6
    800042a0:	ffffc097          	auipc	ra,0xffffc
    800042a4:	2d0080e7          	jalr	720(ra) # 80000570 <walkaddr>
    800042a8:	862a                	mv	a2,a0
    if(pa == 0)
    800042aa:	dd4d                	beqz	a0,80004264 <exec+0xe6>
    if(sz - i < PGSIZE)
    800042ac:	412984bb          	subw	s1,s3,s2
    800042b0:	0004879b          	sext.w	a5,s1
    800042b4:	fcfcf0e3          	bgeu	s9,a5,80004274 <exec+0xf6>
    800042b8:	84d6                	mv	s1,s5
    800042ba:	bf6d                	j	80004274 <exec+0xf6>
    sz = sz1;
    800042bc:	e0843483          	ld	s1,-504(s0)
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
    800042c0:	2d85                	addw	s11,s11,1
    800042c2:	038d0d1b          	addw	s10,s10,56
    800042c6:	e8045783          	lhu	a5,-384(s0)
    800042ca:	06fddf63          	bge	s11,a5,80004348 <exec+0x1ca>
    if(readi(ip, 0, (uint64)&ph, off, sizeof(ph)) != sizeof(ph))
    800042ce:	2d01                	sext.w	s10,s10
    800042d0:	03800713          	li	a4,56
    800042d4:	86ea                	mv	a3,s10
    800042d6:	e1040613          	add	a2,s0,-496
    800042da:	4581                	li	a1,0
    800042dc:	8552                	mv	a0,s4
    800042de:	fffff097          	auipc	ra,0xfffff
    800042e2:	ba2080e7          	jalr	-1118(ra) # 80002e80 <readi>
    800042e6:	03800793          	li	a5,56
    800042ea:	1ef51863          	bne	a0,a5,800044da <exec+0x35c>
    if(ph.type != ELF_PROG_LOAD)
    800042ee:	e1042783          	lw	a5,-496(s0)
    800042f2:	4705                	li	a4,1
    800042f4:	fce796e3          	bne	a5,a4,800042c0 <exec+0x142>
    if(ph.memsz < ph.filesz)
    800042f8:	e3843603          	ld	a2,-456(s0)
    800042fc:	e3043783          	ld	a5,-464(s0)
    80004300:	1ef66163          	bltu	a2,a5,800044e2 <exec+0x364>
    if(ph.vaddr + ph.memsz < ph.vaddr)
    80004304:	e2043783          	ld	a5,-480(s0)
    80004308:	963e                	add	a2,a2,a5
    8000430a:	1ef66063          	bltu	a2,a5,800044ea <exec+0x36c>
    if((sz1 = uvmalloc(pagetable, sz, ph.vaddr + ph.memsz)) == 0)
    8000430e:	85a6                	mv	a1,s1
    80004310:	855a                	mv	a0,s6
    80004312:	ffffc097          	auipc	ra,0xffffc
    80004316:	654080e7          	jalr	1620(ra) # 80000966 <uvmalloc>
    8000431a:	e0a43423          	sd	a0,-504(s0)
    8000431e:	1c050a63          	beqz	a0,800044f2 <exec+0x374>
    if(ph.vaddr % PGSIZE != 0)
    80004322:	e2043b83          	ld	s7,-480(s0)
    80004326:	df043783          	ld	a5,-528(s0)
    8000432a:	00fbf7b3          	and	a5,s7,a5
    8000432e:	1c079a63          	bnez	a5,80004502 <exec+0x384>
    if(loadseg(pagetable, ph.vaddr, ip, ph.off, ph.filesz) < 0)
    80004332:	e1842c03          	lw	s8,-488(s0)
    80004336:	e3042983          	lw	s3,-464(s0)
  for(i = 0; i < sz; i += PGSIZE){
    8000433a:	00098463          	beqz	s3,80004342 <exec+0x1c4>
    8000433e:	4901                	li	s2,0
    80004340:	bf99                	j	80004296 <exec+0x118>
    sz = sz1;
    80004342:	e0843483          	ld	s1,-504(s0)
    80004346:	bfad                	j	800042c0 <exec+0x142>
    80004348:	7dba                	ld	s11,424(sp)
  iunlockput(ip);
    8000434a:	8552                	mv	a0,s4
    8000434c:	fffff097          	auipc	ra,0xfffff
    80004350:	ae2080e7          	jalr	-1310(ra) # 80002e2e <iunlockput>
  end_op();
    80004354:	fffff097          	auipc	ra,0xfffff
    80004358:	2c0080e7          	jalr	704(ra) # 80003614 <end_op>
  p = myproc();
    8000435c:	ffffd097          	auipc	ra,0xffffd
    80004360:	bea080e7          	jalr	-1046(ra) # 80000f46 <myproc>
    80004364:	8aaa                	mv	s5,a0
  uint64 oldsz = p->sz;
    80004366:	04853c83          	ld	s9,72(a0)
  sz = PGROUNDUP(sz);
    8000436a:	6985                	lui	s3,0x1
    8000436c:	19fd                	add	s3,s3,-1 # fff <_entry-0x7ffff001>
    8000436e:	99a6                	add	s3,s3,s1
    80004370:	77fd                	lui	a5,0xfffff
    80004372:	00f9f9b3          	and	s3,s3,a5
  if((sz1 = uvmalloc(pagetable, sz, sz + 2*PGSIZE)) == 0)
    80004376:	6609                	lui	a2,0x2
    80004378:	964e                	add	a2,a2,s3
    8000437a:	85ce                	mv	a1,s3
    8000437c:	855a                	mv	a0,s6
    8000437e:	ffffc097          	auipc	ra,0xffffc
    80004382:	5e8080e7          	jalr	1512(ra) # 80000966 <uvmalloc>
    80004386:	892a                	mv	s2,a0
    80004388:	e0a43423          	sd	a0,-504(s0)
    8000438c:	e519                	bnez	a0,8000439a <exec+0x21c>
  if(pagetable)
    8000438e:	e1343423          	sd	s3,-504(s0)
    80004392:	4a01                	li	s4,0
    80004394:	aa95                	j	80004508 <exec+0x38a>
  uint64 argc, sz = 0, sp, ustack[MAXARG+1], stackbase;
    80004396:	4481                	li	s1,0
    80004398:	bf4d                	j	8000434a <exec+0x1cc>
  uvmclear(pagetable, sz-2*PGSIZE);
    8000439a:	75f9                	lui	a1,0xffffe
    8000439c:	95aa                	add	a1,a1,a0
    8000439e:	855a                	mv	a0,s6
    800043a0:	ffffc097          	auipc	ra,0xffffc
    800043a4:	7f0080e7          	jalr	2032(ra) # 80000b90 <uvmclear>
  stackbase = sp - PGSIZE;
    800043a8:	7bfd                	lui	s7,0xfffff
    800043aa:	9bca                	add	s7,s7,s2
  for(argc = 0; argv[argc]; argc++) {
    800043ac:	e0043783          	ld	a5,-512(s0)
    800043b0:	6388                	ld	a0,0(a5)
    800043b2:	c52d                	beqz	a0,8000441c <exec+0x29e>
    800043b4:	e8840993          	add	s3,s0,-376
    800043b8:	f8840c13          	add	s8,s0,-120
    800043bc:	4481                	li	s1,0
    sp -= strlen(argv[argc]) + 1;
    800043be:	ffffc097          	auipc	ra,0xffffc
    800043c2:	f38080e7          	jalr	-200(ra) # 800002f6 <strlen>
    800043c6:	0015079b          	addw	a5,a0,1
    800043ca:	40f907b3          	sub	a5,s2,a5
    sp -= sp % 16; // riscv sp must be 16-byte aligned
    800043ce:	ff07f913          	and	s2,a5,-16
    if(sp < stackbase)
    800043d2:	13796463          	bltu	s2,s7,800044fa <exec+0x37c>
    if(copyout(pagetable, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
    800043d6:	e0043d03          	ld	s10,-512(s0)
    800043da:	000d3a03          	ld	s4,0(s10)
    800043de:	8552                	mv	a0,s4
    800043e0:	ffffc097          	auipc	ra,0xffffc
    800043e4:	f16080e7          	jalr	-234(ra) # 800002f6 <strlen>
    800043e8:	0015069b          	addw	a3,a0,1
    800043ec:	8652                	mv	a2,s4
    800043ee:	85ca                	mv	a1,s2
    800043f0:	855a                	mv	a0,s6
    800043f2:	ffffc097          	auipc	ra,0xffffc
    800043f6:	7d0080e7          	jalr	2000(ra) # 80000bc2 <copyout>
    800043fa:	10054263          	bltz	a0,800044fe <exec+0x380>
    ustack[argc] = sp;
    800043fe:	0129b023          	sd	s2,0(s3)
  for(argc = 0; argv[argc]; argc++) {
    80004402:	0485                	add	s1,s1,1
    80004404:	008d0793          	add	a5,s10,8
    80004408:	e0f43023          	sd	a5,-512(s0)
    8000440c:	008d3503          	ld	a0,8(s10)
    80004410:	c909                	beqz	a0,80004422 <exec+0x2a4>
    if(argc >= MAXARG)
    80004412:	09a1                	add	s3,s3,8
    80004414:	fb8995e3          	bne	s3,s8,800043be <exec+0x240>
  ip = 0;
    80004418:	4a01                	li	s4,0
    8000441a:	a0fd                	j	80004508 <exec+0x38a>
  sp = sz;
    8000441c:	e0843903          	ld	s2,-504(s0)
  for(argc = 0; argv[argc]; argc++) {
    80004420:	4481                	li	s1,0
  ustack[argc] = 0;
    80004422:	00349793          	sll	a5,s1,0x3
    80004426:	f9078793          	add	a5,a5,-112 # ffffffffffffef90 <end+0xffffffff7ffb79c0>
    8000442a:	97a2                	add	a5,a5,s0
    8000442c:	ee07bc23          	sd	zero,-264(a5)
  sp -= (argc+1) * sizeof(uint64);
    80004430:	00148693          	add	a3,s1,1
    80004434:	068e                	sll	a3,a3,0x3
    80004436:	40d90933          	sub	s2,s2,a3
  sp -= sp % 16;
    8000443a:	ff097913          	and	s2,s2,-16
  sz = sz1;
    8000443e:	e0843983          	ld	s3,-504(s0)
  if(sp < stackbase)
    80004442:	f57966e3          	bltu	s2,s7,8000438e <exec+0x210>
  if(copyout(pagetable, sp, (char *)ustack, (argc+1)*sizeof(uint64)) < 0)
    80004446:	e8840613          	add	a2,s0,-376
    8000444a:	85ca                	mv	a1,s2
    8000444c:	855a                	mv	a0,s6
    8000444e:	ffffc097          	auipc	ra,0xffffc
    80004452:	774080e7          	jalr	1908(ra) # 80000bc2 <copyout>
    80004456:	0e054663          	bltz	a0,80004542 <exec+0x3c4>
  p->trapframe->a1 = sp;
    8000445a:	058ab783          	ld	a5,88(s5) # 1058 <_entry-0x7fffefa8>
    8000445e:	0727bc23          	sd	s2,120(a5)
  for(last=s=path; *s; s++)
    80004462:	df843783          	ld	a5,-520(s0)
    80004466:	0007c703          	lbu	a4,0(a5)
    8000446a:	cf11                	beqz	a4,80004486 <exec+0x308>
    8000446c:	0785                	add	a5,a5,1
    if(*s == '/')
    8000446e:	02f00693          	li	a3,47
    80004472:	a039                	j	80004480 <exec+0x302>
      last = s+1;
    80004474:	def43c23          	sd	a5,-520(s0)
  for(last=s=path; *s; s++)
    80004478:	0785                	add	a5,a5,1
    8000447a:	fff7c703          	lbu	a4,-1(a5)
    8000447e:	c701                	beqz	a4,80004486 <exec+0x308>
    if(*s == '/')
    80004480:	fed71ce3          	bne	a4,a3,80004478 <exec+0x2fa>
    80004484:	bfc5                	j	80004474 <exec+0x2f6>
  safestrcpy(p->name, last, sizeof(p->name));
    80004486:	4641                	li	a2,16
    80004488:	df843583          	ld	a1,-520(s0)
    8000448c:	5d8a8513          	add	a0,s5,1496
    80004490:	ffffc097          	auipc	ra,0xffffc
    80004494:	e34080e7          	jalr	-460(ra) # 800002c4 <safestrcpy>
  oldpagetable = p->pagetable;
    80004498:	050ab503          	ld	a0,80(s5)
  p->pagetable = pagetable;
    8000449c:	056ab823          	sd	s6,80(s5)
  p->sz = sz;
    800044a0:	e0843783          	ld	a5,-504(s0)
    800044a4:	04fab423          	sd	a5,72(s5)
  p->trapframe->epc = elf.entry;  // initial program counter = main
    800044a8:	058ab783          	ld	a5,88(s5)
    800044ac:	e6043703          	ld	a4,-416(s0)
    800044b0:	ef98                	sd	a4,24(a5)
  p->trapframe->sp = sp; // initial stack pointer
    800044b2:	058ab783          	ld	a5,88(s5)
    800044b6:	0327b823          	sd	s2,48(a5)
  proc_freepagetable(oldpagetable, oldsz);
    800044ba:	85e6                	mv	a1,s9
    800044bc:	ffffd097          	auipc	ra,0xffffd
    800044c0:	bea080e7          	jalr	-1046(ra) # 800010a6 <proc_freepagetable>
  return argc; // this ends up in a0, the first argument to main(argc, argv)
    800044c4:	0004851b          	sext.w	a0,s1
    800044c8:	79be                	ld	s3,488(sp)
    800044ca:	7a1e                	ld	s4,480(sp)
    800044cc:	6afe                	ld	s5,472(sp)
    800044ce:	6b5e                	ld	s6,464(sp)
    800044d0:	6bbe                	ld	s7,456(sp)
    800044d2:	6c1e                	ld	s8,448(sp)
    800044d4:	7cfa                	ld	s9,440(sp)
    800044d6:	7d5a                	ld	s10,432(sp)
    800044d8:	bb05                	j	80004208 <exec+0x8a>
    800044da:	e0943423          	sd	s1,-504(s0)
    800044de:	7dba                	ld	s11,424(sp)
    800044e0:	a025                	j	80004508 <exec+0x38a>
    800044e2:	e0943423          	sd	s1,-504(s0)
    800044e6:	7dba                	ld	s11,424(sp)
    800044e8:	a005                	j	80004508 <exec+0x38a>
    800044ea:	e0943423          	sd	s1,-504(s0)
    800044ee:	7dba                	ld	s11,424(sp)
    800044f0:	a821                	j	80004508 <exec+0x38a>
    800044f2:	e0943423          	sd	s1,-504(s0)
    800044f6:	7dba                	ld	s11,424(sp)
    800044f8:	a801                	j	80004508 <exec+0x38a>
  ip = 0;
    800044fa:	4a01                	li	s4,0
    800044fc:	a031                	j	80004508 <exec+0x38a>
    800044fe:	4a01                	li	s4,0
  if(pagetable)
    80004500:	a021                	j	80004508 <exec+0x38a>
    80004502:	7dba                	ld	s11,424(sp)
    80004504:	a011                	j	80004508 <exec+0x38a>
    80004506:	7dba                	ld	s11,424(sp)
    proc_freepagetable(pagetable, sz);
    80004508:	e0843583          	ld	a1,-504(s0)
    8000450c:	855a                	mv	a0,s6
    8000450e:	ffffd097          	auipc	ra,0xffffd
    80004512:	b98080e7          	jalr	-1128(ra) # 800010a6 <proc_freepagetable>
  return -1;
    80004516:	557d                	li	a0,-1
  if(ip){
    80004518:	000a1b63          	bnez	s4,8000452e <exec+0x3b0>
    8000451c:	79be                	ld	s3,488(sp)
    8000451e:	7a1e                	ld	s4,480(sp)
    80004520:	6afe                	ld	s5,472(sp)
    80004522:	6b5e                	ld	s6,464(sp)
    80004524:	6bbe                	ld	s7,456(sp)
    80004526:	6c1e                	ld	s8,448(sp)
    80004528:	7cfa                	ld	s9,440(sp)
    8000452a:	7d5a                	ld	s10,432(sp)
    8000452c:	b9f1                	j	80004208 <exec+0x8a>
    8000452e:	79be                	ld	s3,488(sp)
    80004530:	6afe                	ld	s5,472(sp)
    80004532:	6b5e                	ld	s6,464(sp)
    80004534:	6bbe                	ld	s7,456(sp)
    80004536:	6c1e                	ld	s8,448(sp)
    80004538:	7cfa                	ld	s9,440(sp)
    8000453a:	7d5a                	ld	s10,432(sp)
    8000453c:	b95d                	j	800041f2 <exec+0x74>
    8000453e:	6b5e                	ld	s6,464(sp)
    80004540:	b94d                	j	800041f2 <exec+0x74>
  sz = sz1;
    80004542:	e0843983          	ld	s3,-504(s0)
    80004546:	b5a1                	j	8000438e <exec+0x210>

0000000080004548 <argfd>:

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
{
    80004548:	7179                	add	sp,sp,-48
    8000454a:	f406                	sd	ra,40(sp)
    8000454c:	f022                	sd	s0,32(sp)
    8000454e:	ec26                	sd	s1,24(sp)
    80004550:	e84a                	sd	s2,16(sp)
    80004552:	1800                	add	s0,sp,48
    80004554:	892e                	mv	s2,a1
    80004556:	84b2                	mv	s1,a2
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
    80004558:	fdc40593          	add	a1,s0,-36
    8000455c:	ffffe097          	auipc	ra,0xffffe
    80004560:	af8080e7          	jalr	-1288(ra) # 80002054 <argint>
    80004564:	04054163          	bltz	a0,800045a6 <argfd+0x5e>
    return -1;
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
    80004568:	fdc42703          	lw	a4,-36(s0)
    8000456c:	09f00793          	li	a5,159
    80004570:	02e7ed63          	bltu	a5,a4,800045aa <argfd+0x62>
    80004574:	ffffd097          	auipc	ra,0xffffd
    80004578:	9d2080e7          	jalr	-1582(ra) # 80000f46 <myproc>
    8000457c:	fdc42703          	lw	a4,-36(s0)
    80004580:	01a70793          	add	a5,a4,26
    80004584:	078e                	sll	a5,a5,0x3
    80004586:	953e                	add	a0,a0,a5
    80004588:	611c                	ld	a5,0(a0)
    8000458a:	c395                	beqz	a5,800045ae <argfd+0x66>
    return -1;
  if(pfd)
    8000458c:	00090463          	beqz	s2,80004594 <argfd+0x4c>
    *pfd = fd;
    80004590:	00e92023          	sw	a4,0(s2)
  if(pf)
    *pf = f;
  return 0;
    80004594:	4501                	li	a0,0
  if(pf)
    80004596:	c091                	beqz	s1,8000459a <argfd+0x52>
    *pf = f;
    80004598:	e09c                	sd	a5,0(s1)
}
    8000459a:	70a2                	ld	ra,40(sp)
    8000459c:	7402                	ld	s0,32(sp)
    8000459e:	64e2                	ld	s1,24(sp)
    800045a0:	6942                	ld	s2,16(sp)
    800045a2:	6145                	add	sp,sp,48
    800045a4:	8082                	ret
    return -1;
    800045a6:	557d                	li	a0,-1
    800045a8:	bfcd                	j	8000459a <argfd+0x52>
    return -1;
    800045aa:	557d                	li	a0,-1
    800045ac:	b7fd                	j	8000459a <argfd+0x52>
    800045ae:	557d                	li	a0,-1
    800045b0:	b7ed                	j	8000459a <argfd+0x52>

00000000800045b2 <fdalloc>:

// Allocate a file descriptor for the given file.
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
    800045b2:	1101                	add	sp,sp,-32
    800045b4:	ec06                	sd	ra,24(sp)
    800045b6:	e822                	sd	s0,16(sp)
    800045b8:	e426                	sd	s1,8(sp)
    800045ba:	1000                	add	s0,sp,32
    800045bc:	84aa                	mv	s1,a0
  int fd;
  struct proc *p = myproc();
    800045be:	ffffd097          	auipc	ra,0xffffd
    800045c2:	988080e7          	jalr	-1656(ra) # 80000f46 <myproc>
    800045c6:	862a                	mv	a2,a0

  for(fd = 0; fd < NOFILE; fd++){
    800045c8:	0d050793          	add	a5,a0,208
    800045cc:	4501                	li	a0,0
    800045ce:	0a000693          	li	a3,160
    if(p->ofile[fd] == 0){
    800045d2:	6398                	ld	a4,0(a5)
    800045d4:	c719                	beqz	a4,800045e2 <fdalloc+0x30>
  for(fd = 0; fd < NOFILE; fd++){
    800045d6:	2505                	addw	a0,a0,1
    800045d8:	07a1                	add	a5,a5,8
    800045da:	fed51ce3          	bne	a0,a3,800045d2 <fdalloc+0x20>
      p->ofile[fd] = f;
      return fd;
    }
  }
  return -1;
    800045de:	557d                	li	a0,-1
    800045e0:	a031                	j	800045ec <fdalloc+0x3a>
      p->ofile[fd] = f;
    800045e2:	01a50793          	add	a5,a0,26
    800045e6:	078e                	sll	a5,a5,0x3
    800045e8:	963e                	add	a2,a2,a5
    800045ea:	e204                	sd	s1,0(a2)
}
    800045ec:	60e2                	ld	ra,24(sp)
    800045ee:	6442                	ld	s0,16(sp)
    800045f0:	64a2                	ld	s1,8(sp)
    800045f2:	6105                	add	sp,sp,32
    800045f4:	8082                	ret

00000000800045f6 <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
    800045f6:	715d                	add	sp,sp,-80
    800045f8:	e486                	sd	ra,72(sp)
    800045fa:	e0a2                	sd	s0,64(sp)
    800045fc:	fc26                	sd	s1,56(sp)
    800045fe:	f84a                	sd	s2,48(sp)
    80004600:	f44e                	sd	s3,40(sp)
    80004602:	f052                	sd	s4,32(sp)
    80004604:	ec56                	sd	s5,24(sp)
    80004606:	0880                	add	s0,sp,80
    80004608:	8aae                	mv	s5,a1
    8000460a:	8a32                	mv	s4,a2
    8000460c:	89b6                	mv	s3,a3
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
    8000460e:	fb040593          	add	a1,s0,-80
    80004612:	fffff097          	auipc	ra,0xfffff
    80004616:	da6080e7          	jalr	-602(ra) # 800033b8 <nameiparent>
    8000461a:	892a                	mv	s2,a0
    8000461c:	12050c63          	beqz	a0,80004754 <create+0x15e>
    return 0;

  ilock(dp);
    80004620:	ffffe097          	auipc	ra,0xffffe
    80004624:	5a8080e7          	jalr	1448(ra) # 80002bc8 <ilock>

  if((ip = dirlookup(dp, name, 0)) != 0){
    80004628:	4601                	li	a2,0
    8000462a:	fb040593          	add	a1,s0,-80
    8000462e:	854a                	mv	a0,s2
    80004630:	fffff097          	auipc	ra,0xfffff
    80004634:	a98080e7          	jalr	-1384(ra) # 800030c8 <dirlookup>
    80004638:	84aa                	mv	s1,a0
    8000463a:	c539                	beqz	a0,80004688 <create+0x92>
    iunlockput(dp);
    8000463c:	854a                	mv	a0,s2
    8000463e:	ffffe097          	auipc	ra,0xffffe
    80004642:	7f0080e7          	jalr	2032(ra) # 80002e2e <iunlockput>
    ilock(ip);
    80004646:	8526                	mv	a0,s1
    80004648:	ffffe097          	auipc	ra,0xffffe
    8000464c:	580080e7          	jalr	1408(ra) # 80002bc8 <ilock>
    if(type == T_FILE && (ip->type == T_FILE || ip->type == T_DEVICE))
    80004650:	4789                	li	a5,2
    80004652:	02fa9463          	bne	s5,a5,8000467a <create+0x84>
    80004656:	0444d783          	lhu	a5,68(s1)
    8000465a:	37f9                	addw	a5,a5,-2
    8000465c:	17c2                	sll	a5,a5,0x30
    8000465e:	93c1                	srl	a5,a5,0x30
    80004660:	4705                	li	a4,1
    80004662:	00f76c63          	bltu	a4,a5,8000467a <create+0x84>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
    80004666:	8526                	mv	a0,s1
    80004668:	60a6                	ld	ra,72(sp)
    8000466a:	6406                	ld	s0,64(sp)
    8000466c:	74e2                	ld	s1,56(sp)
    8000466e:	7942                	ld	s2,48(sp)
    80004670:	79a2                	ld	s3,40(sp)
    80004672:	7a02                	ld	s4,32(sp)
    80004674:	6ae2                	ld	s5,24(sp)
    80004676:	6161                	add	sp,sp,80
    80004678:	8082                	ret
    iunlockput(ip);
    8000467a:	8526                	mv	a0,s1
    8000467c:	ffffe097          	auipc	ra,0xffffe
    80004680:	7b2080e7          	jalr	1970(ra) # 80002e2e <iunlockput>
    return 0;
    80004684:	4481                	li	s1,0
    80004686:	b7c5                	j	80004666 <create+0x70>
  if((ip = ialloc(dp->dev, type)) == 0)
    80004688:	85d6                	mv	a1,s5
    8000468a:	00092503          	lw	a0,0(s2)
    8000468e:	ffffe097          	auipc	ra,0xffffe
    80004692:	3a6080e7          	jalr	934(ra) # 80002a34 <ialloc>
    80004696:	84aa                	mv	s1,a0
    80004698:	c139                	beqz	a0,800046de <create+0xe8>
  ilock(ip);
    8000469a:	ffffe097          	auipc	ra,0xffffe
    8000469e:	52e080e7          	jalr	1326(ra) # 80002bc8 <ilock>
  ip->major = major;
    800046a2:	05449323          	sh	s4,70(s1)
  ip->minor = minor;
    800046a6:	05349423          	sh	s3,72(s1)
  ip->nlink = 1;
    800046aa:	4985                	li	s3,1
    800046ac:	05349523          	sh	s3,74(s1)
  iupdate(ip);
    800046b0:	8526                	mv	a0,s1
    800046b2:	ffffe097          	auipc	ra,0xffffe
    800046b6:	44a080e7          	jalr	1098(ra) # 80002afc <iupdate>
  if(type == T_DIR){  // Create . and .. entries.
    800046ba:	033a8a63          	beq	s5,s3,800046ee <create+0xf8>
  if(dirlink(dp, name, ip->inum) < 0)
    800046be:	40d0                	lw	a2,4(s1)
    800046c0:	fb040593          	add	a1,s0,-80
    800046c4:	854a                	mv	a0,s2
    800046c6:	fffff097          	auipc	ra,0xfffff
    800046ca:	c12080e7          	jalr	-1006(ra) # 800032d8 <dirlink>
    800046ce:	06054b63          	bltz	a0,80004744 <create+0x14e>
  iunlockput(dp);
    800046d2:	854a                	mv	a0,s2
    800046d4:	ffffe097          	auipc	ra,0xffffe
    800046d8:	75a080e7          	jalr	1882(ra) # 80002e2e <iunlockput>
  return ip;
    800046dc:	b769                	j	80004666 <create+0x70>
    panic("create: ialloc");
    800046de:	00007517          	auipc	a0,0x7
    800046e2:	ea250513          	add	a0,a0,-350 # 8000b580 <etext+0x580>
    800046e6:	00005097          	auipc	ra,0x5
    800046ea:	bf2080e7          	jalr	-1038(ra) # 800092d8 <panic>
    dp->nlink++;  // for ".."
    800046ee:	04a95783          	lhu	a5,74(s2)
    800046f2:	2785                	addw	a5,a5,1
    800046f4:	04f91523          	sh	a5,74(s2)
    iupdate(dp);
    800046f8:	854a                	mv	a0,s2
    800046fa:	ffffe097          	auipc	ra,0xffffe
    800046fe:	402080e7          	jalr	1026(ra) # 80002afc <iupdate>
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
    80004702:	40d0                	lw	a2,4(s1)
    80004704:	00007597          	auipc	a1,0x7
    80004708:	e8c58593          	add	a1,a1,-372 # 8000b590 <etext+0x590>
    8000470c:	8526                	mv	a0,s1
    8000470e:	fffff097          	auipc	ra,0xfffff
    80004712:	bca080e7          	jalr	-1078(ra) # 800032d8 <dirlink>
    80004716:	00054f63          	bltz	a0,80004734 <create+0x13e>
    8000471a:	00492603          	lw	a2,4(s2)
    8000471e:	00007597          	auipc	a1,0x7
    80004722:	e7a58593          	add	a1,a1,-390 # 8000b598 <etext+0x598>
    80004726:	8526                	mv	a0,s1
    80004728:	fffff097          	auipc	ra,0xfffff
    8000472c:	bb0080e7          	jalr	-1104(ra) # 800032d8 <dirlink>
    80004730:	f80557e3          	bgez	a0,800046be <create+0xc8>
      panic("create dots");
    80004734:	00007517          	auipc	a0,0x7
    80004738:	e6c50513          	add	a0,a0,-404 # 8000b5a0 <etext+0x5a0>
    8000473c:	00005097          	auipc	ra,0x5
    80004740:	b9c080e7          	jalr	-1124(ra) # 800092d8 <panic>
    panic("create: dirlink");
    80004744:	00007517          	auipc	a0,0x7
    80004748:	e6c50513          	add	a0,a0,-404 # 8000b5b0 <etext+0x5b0>
    8000474c:	00005097          	auipc	ra,0x5
    80004750:	b8c080e7          	jalr	-1140(ra) # 800092d8 <panic>
    return 0;
    80004754:	84aa                	mv	s1,a0
    80004756:	bf01                	j	80004666 <create+0x70>

0000000080004758 <sys_dup>:
{
    80004758:	7179                	add	sp,sp,-48
    8000475a:	f406                	sd	ra,40(sp)
    8000475c:	f022                	sd	s0,32(sp)
    8000475e:	1800                	add	s0,sp,48
  if(argfd(0, 0, &f) < 0)
    80004760:	fd840613          	add	a2,s0,-40
    80004764:	4581                	li	a1,0
    80004766:	4501                	li	a0,0
    80004768:	00000097          	auipc	ra,0x0
    8000476c:	de0080e7          	jalr	-544(ra) # 80004548 <argfd>
    return -1;
    80004770:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0)
    80004772:	02054763          	bltz	a0,800047a0 <sys_dup+0x48>
    80004776:	ec26                	sd	s1,24(sp)
    80004778:	e84a                	sd	s2,16(sp)
  if((fd=fdalloc(f)) < 0)
    8000477a:	fd843903          	ld	s2,-40(s0)
    8000477e:	854a                	mv	a0,s2
    80004780:	00000097          	auipc	ra,0x0
    80004784:	e32080e7          	jalr	-462(ra) # 800045b2 <fdalloc>
    80004788:	84aa                	mv	s1,a0
    return -1;
    8000478a:	57fd                	li	a5,-1
  if((fd=fdalloc(f)) < 0)
    8000478c:	00054f63          	bltz	a0,800047aa <sys_dup+0x52>
  filedup(f);
    80004790:	854a                	mv	a0,s2
    80004792:	fffff097          	auipc	ra,0xfffff
    80004796:	288080e7          	jalr	648(ra) # 80003a1a <filedup>
  return fd;
    8000479a:	87a6                	mv	a5,s1
    8000479c:	64e2                	ld	s1,24(sp)
    8000479e:	6942                	ld	s2,16(sp)
}
    800047a0:	853e                	mv	a0,a5
    800047a2:	70a2                	ld	ra,40(sp)
    800047a4:	7402                	ld	s0,32(sp)
    800047a6:	6145                	add	sp,sp,48
    800047a8:	8082                	ret
    800047aa:	64e2                	ld	s1,24(sp)
    800047ac:	6942                	ld	s2,16(sp)
    800047ae:	bfcd                	j	800047a0 <sys_dup+0x48>

00000000800047b0 <sys_read>:
{
    800047b0:	7179                	add	sp,sp,-48
    800047b2:	f406                	sd	ra,40(sp)
    800047b4:	f022                	sd	s0,32(sp)
    800047b6:	1800                	add	s0,sp,48
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    800047b8:	fe840613          	add	a2,s0,-24
    800047bc:	4581                	li	a1,0
    800047be:	4501                	li	a0,0
    800047c0:	00000097          	auipc	ra,0x0
    800047c4:	d88080e7          	jalr	-632(ra) # 80004548 <argfd>
    return -1;
    800047c8:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    800047ca:	04054163          	bltz	a0,8000480c <sys_read+0x5c>
    800047ce:	fe440593          	add	a1,s0,-28
    800047d2:	4509                	li	a0,2
    800047d4:	ffffe097          	auipc	ra,0xffffe
    800047d8:	880080e7          	jalr	-1920(ra) # 80002054 <argint>
    return -1;
    800047dc:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    800047de:	02054763          	bltz	a0,8000480c <sys_read+0x5c>
    800047e2:	fd840593          	add	a1,s0,-40
    800047e6:	4505                	li	a0,1
    800047e8:	ffffe097          	auipc	ra,0xffffe
    800047ec:	88e080e7          	jalr	-1906(ra) # 80002076 <argaddr>
    return -1;
    800047f0:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    800047f2:	00054d63          	bltz	a0,8000480c <sys_read+0x5c>
  return fileread(f, p, n);
    800047f6:	fe442603          	lw	a2,-28(s0)
    800047fa:	fd843583          	ld	a1,-40(s0)
    800047fe:	fe843503          	ld	a0,-24(s0)
    80004802:	fffff097          	auipc	ra,0xfffff
    80004806:	3e4080e7          	jalr	996(ra) # 80003be6 <fileread>
    8000480a:	87aa                	mv	a5,a0
}
    8000480c:	853e                	mv	a0,a5
    8000480e:	70a2                	ld	ra,40(sp)
    80004810:	7402                	ld	s0,32(sp)
    80004812:	6145                	add	sp,sp,48
    80004814:	8082                	ret

0000000080004816 <sys_write>:
{
    80004816:	7179                	add	sp,sp,-48
    80004818:	f406                	sd	ra,40(sp)
    8000481a:	f022                	sd	s0,32(sp)
    8000481c:	1800                	add	s0,sp,48
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    8000481e:	fe840613          	add	a2,s0,-24
    80004822:	4581                	li	a1,0
    80004824:	4501                	li	a0,0
    80004826:	00000097          	auipc	ra,0x0
    8000482a:	d22080e7          	jalr	-734(ra) # 80004548 <argfd>
    return -1;
    8000482e:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    80004830:	04054163          	bltz	a0,80004872 <sys_write+0x5c>
    80004834:	fe440593          	add	a1,s0,-28
    80004838:	4509                	li	a0,2
    8000483a:	ffffe097          	auipc	ra,0xffffe
    8000483e:	81a080e7          	jalr	-2022(ra) # 80002054 <argint>
    return -1;
    80004842:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    80004844:	02054763          	bltz	a0,80004872 <sys_write+0x5c>
    80004848:	fd840593          	add	a1,s0,-40
    8000484c:	4505                	li	a0,1
    8000484e:	ffffe097          	auipc	ra,0xffffe
    80004852:	828080e7          	jalr	-2008(ra) # 80002076 <argaddr>
    return -1;
    80004856:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    80004858:	00054d63          	bltz	a0,80004872 <sys_write+0x5c>
  return filewrite(f, p, n);
    8000485c:	fe442603          	lw	a2,-28(s0)
    80004860:	fd843583          	ld	a1,-40(s0)
    80004864:	fe843503          	ld	a0,-24(s0)
    80004868:	fffff097          	auipc	ra,0xfffff
    8000486c:	47c080e7          	jalr	1148(ra) # 80003ce4 <filewrite>
    80004870:	87aa                	mv	a5,a0
}
    80004872:	853e                	mv	a0,a5
    80004874:	70a2                	ld	ra,40(sp)
    80004876:	7402                	ld	s0,32(sp)
    80004878:	6145                	add	sp,sp,48
    8000487a:	8082                	ret

000000008000487c <sys_close>:
{
    8000487c:	1101                	add	sp,sp,-32
    8000487e:	ec06                	sd	ra,24(sp)
    80004880:	e822                	sd	s0,16(sp)
    80004882:	1000                	add	s0,sp,32
  if(argfd(0, &fd, &f) < 0)
    80004884:	fe040613          	add	a2,s0,-32
    80004888:	fec40593          	add	a1,s0,-20
    8000488c:	4501                	li	a0,0
    8000488e:	00000097          	auipc	ra,0x0
    80004892:	cba080e7          	jalr	-838(ra) # 80004548 <argfd>
    return -1;
    80004896:	57fd                	li	a5,-1
  if(argfd(0, &fd, &f) < 0)
    80004898:	02054463          	bltz	a0,800048c0 <sys_close+0x44>
  myproc()->ofile[fd] = 0;
    8000489c:	ffffc097          	auipc	ra,0xffffc
    800048a0:	6aa080e7          	jalr	1706(ra) # 80000f46 <myproc>
    800048a4:	fec42783          	lw	a5,-20(s0)
    800048a8:	07e9                	add	a5,a5,26
    800048aa:	078e                	sll	a5,a5,0x3
    800048ac:	953e                	add	a0,a0,a5
    800048ae:	00053023          	sd	zero,0(a0)
  fileclose(f);
    800048b2:	fe043503          	ld	a0,-32(s0)
    800048b6:	fffff097          	auipc	ra,0xfffff
    800048ba:	1b6080e7          	jalr	438(ra) # 80003a6c <fileclose>
  return 0;
    800048be:	4781                	li	a5,0
}
    800048c0:	853e                	mv	a0,a5
    800048c2:	60e2                	ld	ra,24(sp)
    800048c4:	6442                	ld	s0,16(sp)
    800048c6:	6105                	add	sp,sp,32
    800048c8:	8082                	ret

00000000800048ca <sys_fstat>:
{
    800048ca:	1101                	add	sp,sp,-32
    800048cc:	ec06                	sd	ra,24(sp)
    800048ce:	e822                	sd	s0,16(sp)
    800048d0:	1000                	add	s0,sp,32
  if(argfd(0, 0, &f) < 0 || argaddr(1, &st) < 0)
    800048d2:	fe840613          	add	a2,s0,-24
    800048d6:	4581                	li	a1,0
    800048d8:	4501                	li	a0,0
    800048da:	00000097          	auipc	ra,0x0
    800048de:	c6e080e7          	jalr	-914(ra) # 80004548 <argfd>
    return -1;
    800048e2:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0 || argaddr(1, &st) < 0)
    800048e4:	02054563          	bltz	a0,8000490e <sys_fstat+0x44>
    800048e8:	fe040593          	add	a1,s0,-32
    800048ec:	4505                	li	a0,1
    800048ee:	ffffd097          	auipc	ra,0xffffd
    800048f2:	788080e7          	jalr	1928(ra) # 80002076 <argaddr>
    return -1;
    800048f6:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0 || argaddr(1, &st) < 0)
    800048f8:	00054b63          	bltz	a0,8000490e <sys_fstat+0x44>
  return filestat(f, st);
    800048fc:	fe043583          	ld	a1,-32(s0)
    80004900:	fe843503          	ld	a0,-24(s0)
    80004904:	fffff097          	auipc	ra,0xfffff
    80004908:	270080e7          	jalr	624(ra) # 80003b74 <filestat>
    8000490c:	87aa                	mv	a5,a0
}
    8000490e:	853e                	mv	a0,a5
    80004910:	60e2                	ld	ra,24(sp)
    80004912:	6442                	ld	s0,16(sp)
    80004914:	6105                	add	sp,sp,32
    80004916:	8082                	ret

0000000080004918 <sys_link>:
{
    80004918:	7169                	add	sp,sp,-304
    8000491a:	f606                	sd	ra,296(sp)
    8000491c:	f222                	sd	s0,288(sp)
    8000491e:	1a00                	add	s0,sp,304
  if(argstr(0, old, MAXPATH) < 0 || argstr(1, new, MAXPATH) < 0)
    80004920:	08000613          	li	a2,128
    80004924:	ed040593          	add	a1,s0,-304
    80004928:	4501                	li	a0,0
    8000492a:	ffffd097          	auipc	ra,0xffffd
    8000492e:	76e080e7          	jalr	1902(ra) # 80002098 <argstr>
    return -1;
    80004932:	57fd                	li	a5,-1
  if(argstr(0, old, MAXPATH) < 0 || argstr(1, new, MAXPATH) < 0)
    80004934:	12054663          	bltz	a0,80004a60 <sys_link+0x148>
    80004938:	08000613          	li	a2,128
    8000493c:	f5040593          	add	a1,s0,-176
    80004940:	4505                	li	a0,1
    80004942:	ffffd097          	auipc	ra,0xffffd
    80004946:	756080e7          	jalr	1878(ra) # 80002098 <argstr>
    return -1;
    8000494a:	57fd                	li	a5,-1
  if(argstr(0, old, MAXPATH) < 0 || argstr(1, new, MAXPATH) < 0)
    8000494c:	10054a63          	bltz	a0,80004a60 <sys_link+0x148>
    80004950:	ee26                	sd	s1,280(sp)
  begin_op();
    80004952:	fffff097          	auipc	ra,0xfffff
    80004956:	c48080e7          	jalr	-952(ra) # 8000359a <begin_op>
  if((ip = namei(old)) == 0){
    8000495a:	ed040513          	add	a0,s0,-304
    8000495e:	fffff097          	auipc	ra,0xfffff
    80004962:	a3c080e7          	jalr	-1476(ra) # 8000339a <namei>
    80004966:	84aa                	mv	s1,a0
    80004968:	c949                	beqz	a0,800049fa <sys_link+0xe2>
  ilock(ip);
    8000496a:	ffffe097          	auipc	ra,0xffffe
    8000496e:	25e080e7          	jalr	606(ra) # 80002bc8 <ilock>
  if(ip->type == T_DIR){
    80004972:	04449703          	lh	a4,68(s1)
    80004976:	4785                	li	a5,1
    80004978:	08f70863          	beq	a4,a5,80004a08 <sys_link+0xf0>
    8000497c:	ea4a                	sd	s2,272(sp)
  ip->nlink++;
    8000497e:	04a4d783          	lhu	a5,74(s1)
    80004982:	2785                	addw	a5,a5,1
    80004984:	04f49523          	sh	a5,74(s1)
  iupdate(ip);
    80004988:	8526                	mv	a0,s1
    8000498a:	ffffe097          	auipc	ra,0xffffe
    8000498e:	172080e7          	jalr	370(ra) # 80002afc <iupdate>
  iunlock(ip);
    80004992:	8526                	mv	a0,s1
    80004994:	ffffe097          	auipc	ra,0xffffe
    80004998:	2fa080e7          	jalr	762(ra) # 80002c8e <iunlock>
  if((dp = nameiparent(new, name)) == 0)
    8000499c:	fd040593          	add	a1,s0,-48
    800049a0:	f5040513          	add	a0,s0,-176
    800049a4:	fffff097          	auipc	ra,0xfffff
    800049a8:	a14080e7          	jalr	-1516(ra) # 800033b8 <nameiparent>
    800049ac:	892a                	mv	s2,a0
    800049ae:	cd35                	beqz	a0,80004a2a <sys_link+0x112>
  ilock(dp);
    800049b0:	ffffe097          	auipc	ra,0xffffe
    800049b4:	218080e7          	jalr	536(ra) # 80002bc8 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
    800049b8:	00092703          	lw	a4,0(s2)
    800049bc:	409c                	lw	a5,0(s1)
    800049be:	06f71163          	bne	a4,a5,80004a20 <sys_link+0x108>
    800049c2:	40d0                	lw	a2,4(s1)
    800049c4:	fd040593          	add	a1,s0,-48
    800049c8:	854a                	mv	a0,s2
    800049ca:	fffff097          	auipc	ra,0xfffff
    800049ce:	90e080e7          	jalr	-1778(ra) # 800032d8 <dirlink>
    800049d2:	04054763          	bltz	a0,80004a20 <sys_link+0x108>
  iunlockput(dp);
    800049d6:	854a                	mv	a0,s2
    800049d8:	ffffe097          	auipc	ra,0xffffe
    800049dc:	456080e7          	jalr	1110(ra) # 80002e2e <iunlockput>
  iput(ip);
    800049e0:	8526                	mv	a0,s1
    800049e2:	ffffe097          	auipc	ra,0xffffe
    800049e6:	3a4080e7          	jalr	932(ra) # 80002d86 <iput>
  end_op();
    800049ea:	fffff097          	auipc	ra,0xfffff
    800049ee:	c2a080e7          	jalr	-982(ra) # 80003614 <end_op>
  return 0;
    800049f2:	4781                	li	a5,0
    800049f4:	64f2                	ld	s1,280(sp)
    800049f6:	6952                	ld	s2,272(sp)
    800049f8:	a0a5                	j	80004a60 <sys_link+0x148>
    end_op();
    800049fa:	fffff097          	auipc	ra,0xfffff
    800049fe:	c1a080e7          	jalr	-998(ra) # 80003614 <end_op>
    return -1;
    80004a02:	57fd                	li	a5,-1
    80004a04:	64f2                	ld	s1,280(sp)
    80004a06:	a8a9                	j	80004a60 <sys_link+0x148>
    iunlockput(ip);
    80004a08:	8526                	mv	a0,s1
    80004a0a:	ffffe097          	auipc	ra,0xffffe
    80004a0e:	424080e7          	jalr	1060(ra) # 80002e2e <iunlockput>
    end_op();
    80004a12:	fffff097          	auipc	ra,0xfffff
    80004a16:	c02080e7          	jalr	-1022(ra) # 80003614 <end_op>
    return -1;
    80004a1a:	57fd                	li	a5,-1
    80004a1c:	64f2                	ld	s1,280(sp)
    80004a1e:	a089                	j	80004a60 <sys_link+0x148>
    iunlockput(dp);
    80004a20:	854a                	mv	a0,s2
    80004a22:	ffffe097          	auipc	ra,0xffffe
    80004a26:	40c080e7          	jalr	1036(ra) # 80002e2e <iunlockput>
  ilock(ip);
    80004a2a:	8526                	mv	a0,s1
    80004a2c:	ffffe097          	auipc	ra,0xffffe
    80004a30:	19c080e7          	jalr	412(ra) # 80002bc8 <ilock>
  ip->nlink--;
    80004a34:	04a4d783          	lhu	a5,74(s1)
    80004a38:	37fd                	addw	a5,a5,-1
    80004a3a:	04f49523          	sh	a5,74(s1)
  iupdate(ip);
    80004a3e:	8526                	mv	a0,s1
    80004a40:	ffffe097          	auipc	ra,0xffffe
    80004a44:	0bc080e7          	jalr	188(ra) # 80002afc <iupdate>
  iunlockput(ip);
    80004a48:	8526                	mv	a0,s1
    80004a4a:	ffffe097          	auipc	ra,0xffffe
    80004a4e:	3e4080e7          	jalr	996(ra) # 80002e2e <iunlockput>
  end_op();
    80004a52:	fffff097          	auipc	ra,0xfffff
    80004a56:	bc2080e7          	jalr	-1086(ra) # 80003614 <end_op>
  return -1;
    80004a5a:	57fd                	li	a5,-1
    80004a5c:	64f2                	ld	s1,280(sp)
    80004a5e:	6952                	ld	s2,272(sp)
}
    80004a60:	853e                	mv	a0,a5
    80004a62:	70b2                	ld	ra,296(sp)
    80004a64:	7412                	ld	s0,288(sp)
    80004a66:	6155                	add	sp,sp,304
    80004a68:	8082                	ret

0000000080004a6a <sys_unlink>:
{
    80004a6a:	7151                	add	sp,sp,-240
    80004a6c:	f586                	sd	ra,232(sp)
    80004a6e:	f1a2                	sd	s0,224(sp)
    80004a70:	1980                	add	s0,sp,240
  if(argstr(0, path, MAXPATH) < 0)
    80004a72:	08000613          	li	a2,128
    80004a76:	f3040593          	add	a1,s0,-208
    80004a7a:	4501                	li	a0,0
    80004a7c:	ffffd097          	auipc	ra,0xffffd
    80004a80:	61c080e7          	jalr	1564(ra) # 80002098 <argstr>
    80004a84:	1a054a63          	bltz	a0,80004c38 <sys_unlink+0x1ce>
    80004a88:	eda6                	sd	s1,216(sp)
  begin_op();
    80004a8a:	fffff097          	auipc	ra,0xfffff
    80004a8e:	b10080e7          	jalr	-1264(ra) # 8000359a <begin_op>
  if((dp = nameiparent(path, name)) == 0){
    80004a92:	fb040593          	add	a1,s0,-80
    80004a96:	f3040513          	add	a0,s0,-208
    80004a9a:	fffff097          	auipc	ra,0xfffff
    80004a9e:	91e080e7          	jalr	-1762(ra) # 800033b8 <nameiparent>
    80004aa2:	84aa                	mv	s1,a0
    80004aa4:	cd71                	beqz	a0,80004b80 <sys_unlink+0x116>
  ilock(dp);
    80004aa6:	ffffe097          	auipc	ra,0xffffe
    80004aaa:	122080e7          	jalr	290(ra) # 80002bc8 <ilock>
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
    80004aae:	00007597          	auipc	a1,0x7
    80004ab2:	ae258593          	add	a1,a1,-1310 # 8000b590 <etext+0x590>
    80004ab6:	fb040513          	add	a0,s0,-80
    80004aba:	ffffe097          	auipc	ra,0xffffe
    80004abe:	5f4080e7          	jalr	1524(ra) # 800030ae <namecmp>
    80004ac2:	14050c63          	beqz	a0,80004c1a <sys_unlink+0x1b0>
    80004ac6:	00007597          	auipc	a1,0x7
    80004aca:	ad258593          	add	a1,a1,-1326 # 8000b598 <etext+0x598>
    80004ace:	fb040513          	add	a0,s0,-80
    80004ad2:	ffffe097          	auipc	ra,0xffffe
    80004ad6:	5dc080e7          	jalr	1500(ra) # 800030ae <namecmp>
    80004ada:	14050063          	beqz	a0,80004c1a <sys_unlink+0x1b0>
    80004ade:	e9ca                	sd	s2,208(sp)
  if((ip = dirlookup(dp, name, &off)) == 0)
    80004ae0:	f2c40613          	add	a2,s0,-212
    80004ae4:	fb040593          	add	a1,s0,-80
    80004ae8:	8526                	mv	a0,s1
    80004aea:	ffffe097          	auipc	ra,0xffffe
    80004aee:	5de080e7          	jalr	1502(ra) # 800030c8 <dirlookup>
    80004af2:	892a                	mv	s2,a0
    80004af4:	12050263          	beqz	a0,80004c18 <sys_unlink+0x1ae>
  ilock(ip);
    80004af8:	ffffe097          	auipc	ra,0xffffe
    80004afc:	0d0080e7          	jalr	208(ra) # 80002bc8 <ilock>
  if(ip->nlink < 1)
    80004b00:	04a91783          	lh	a5,74(s2)
    80004b04:	08f05563          	blez	a5,80004b8e <sys_unlink+0x124>
  if(ip->type == T_DIR && !isdirempty(ip)){
    80004b08:	04491703          	lh	a4,68(s2)
    80004b0c:	4785                	li	a5,1
    80004b0e:	08f70963          	beq	a4,a5,80004ba0 <sys_unlink+0x136>
  memset(&de, 0, sizeof(de));
    80004b12:	4641                	li	a2,16
    80004b14:	4581                	li	a1,0
    80004b16:	fc040513          	add	a0,s0,-64
    80004b1a:	ffffb097          	auipc	ra,0xffffb
    80004b1e:	660080e7          	jalr	1632(ra) # 8000017a <memset>
  if(writei(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80004b22:	4741                	li	a4,16
    80004b24:	f2c42683          	lw	a3,-212(s0)
    80004b28:	fc040613          	add	a2,s0,-64
    80004b2c:	4581                	li	a1,0
    80004b2e:	8526                	mv	a0,s1
    80004b30:	ffffe097          	auipc	ra,0xffffe
    80004b34:	454080e7          	jalr	1108(ra) # 80002f84 <writei>
    80004b38:	47c1                	li	a5,16
    80004b3a:	0af51b63          	bne	a0,a5,80004bf0 <sys_unlink+0x186>
  if(ip->type == T_DIR){
    80004b3e:	04491703          	lh	a4,68(s2)
    80004b42:	4785                	li	a5,1
    80004b44:	0af70f63          	beq	a4,a5,80004c02 <sys_unlink+0x198>
  iunlockput(dp);
    80004b48:	8526                	mv	a0,s1
    80004b4a:	ffffe097          	auipc	ra,0xffffe
    80004b4e:	2e4080e7          	jalr	740(ra) # 80002e2e <iunlockput>
  ip->nlink--;
    80004b52:	04a95783          	lhu	a5,74(s2)
    80004b56:	37fd                	addw	a5,a5,-1
    80004b58:	04f91523          	sh	a5,74(s2)
  iupdate(ip);
    80004b5c:	854a                	mv	a0,s2
    80004b5e:	ffffe097          	auipc	ra,0xffffe
    80004b62:	f9e080e7          	jalr	-98(ra) # 80002afc <iupdate>
  iunlockput(ip);
    80004b66:	854a                	mv	a0,s2
    80004b68:	ffffe097          	auipc	ra,0xffffe
    80004b6c:	2c6080e7          	jalr	710(ra) # 80002e2e <iunlockput>
  end_op();
    80004b70:	fffff097          	auipc	ra,0xfffff
    80004b74:	aa4080e7          	jalr	-1372(ra) # 80003614 <end_op>
  return 0;
    80004b78:	4501                	li	a0,0
    80004b7a:	64ee                	ld	s1,216(sp)
    80004b7c:	694e                	ld	s2,208(sp)
    80004b7e:	a84d                	j	80004c30 <sys_unlink+0x1c6>
    end_op();
    80004b80:	fffff097          	auipc	ra,0xfffff
    80004b84:	a94080e7          	jalr	-1388(ra) # 80003614 <end_op>
    return -1;
    80004b88:	557d                	li	a0,-1
    80004b8a:	64ee                	ld	s1,216(sp)
    80004b8c:	a055                	j	80004c30 <sys_unlink+0x1c6>
    80004b8e:	e5ce                	sd	s3,200(sp)
    panic("unlink: nlink < 1");
    80004b90:	00007517          	auipc	a0,0x7
    80004b94:	a3050513          	add	a0,a0,-1488 # 8000b5c0 <etext+0x5c0>
    80004b98:	00004097          	auipc	ra,0x4
    80004b9c:	740080e7          	jalr	1856(ra) # 800092d8 <panic>
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
    80004ba0:	04c92703          	lw	a4,76(s2)
    80004ba4:	02000793          	li	a5,32
    80004ba8:	f6e7f5e3          	bgeu	a5,a4,80004b12 <sys_unlink+0xa8>
    80004bac:	e5ce                	sd	s3,200(sp)
    80004bae:	02000993          	li	s3,32
    if(readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80004bb2:	4741                	li	a4,16
    80004bb4:	86ce                	mv	a3,s3
    80004bb6:	f1840613          	add	a2,s0,-232
    80004bba:	4581                	li	a1,0
    80004bbc:	854a                	mv	a0,s2
    80004bbe:	ffffe097          	auipc	ra,0xffffe
    80004bc2:	2c2080e7          	jalr	706(ra) # 80002e80 <readi>
    80004bc6:	47c1                	li	a5,16
    80004bc8:	00f51c63          	bne	a0,a5,80004be0 <sys_unlink+0x176>
    if(de.inum != 0)
    80004bcc:	f1845783          	lhu	a5,-232(s0)
    80004bd0:	e7b5                	bnez	a5,80004c3c <sys_unlink+0x1d2>
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
    80004bd2:	29c1                	addw	s3,s3,16
    80004bd4:	04c92783          	lw	a5,76(s2)
    80004bd8:	fcf9ede3          	bltu	s3,a5,80004bb2 <sys_unlink+0x148>
    80004bdc:	69ae                	ld	s3,200(sp)
    80004bde:	bf15                	j	80004b12 <sys_unlink+0xa8>
      panic("isdirempty: readi");
    80004be0:	00007517          	auipc	a0,0x7
    80004be4:	9f850513          	add	a0,a0,-1544 # 8000b5d8 <etext+0x5d8>
    80004be8:	00004097          	auipc	ra,0x4
    80004bec:	6f0080e7          	jalr	1776(ra) # 800092d8 <panic>
    80004bf0:	e5ce                	sd	s3,200(sp)
    panic("unlink: writei");
    80004bf2:	00007517          	auipc	a0,0x7
    80004bf6:	9fe50513          	add	a0,a0,-1538 # 8000b5f0 <etext+0x5f0>
    80004bfa:	00004097          	auipc	ra,0x4
    80004bfe:	6de080e7          	jalr	1758(ra) # 800092d8 <panic>
    dp->nlink--;
    80004c02:	04a4d783          	lhu	a5,74(s1)
    80004c06:	37fd                	addw	a5,a5,-1
    80004c08:	04f49523          	sh	a5,74(s1)
    iupdate(dp);
    80004c0c:	8526                	mv	a0,s1
    80004c0e:	ffffe097          	auipc	ra,0xffffe
    80004c12:	eee080e7          	jalr	-274(ra) # 80002afc <iupdate>
    80004c16:	bf0d                	j	80004b48 <sys_unlink+0xde>
    80004c18:	694e                	ld	s2,208(sp)
  iunlockput(dp);
    80004c1a:	8526                	mv	a0,s1
    80004c1c:	ffffe097          	auipc	ra,0xffffe
    80004c20:	212080e7          	jalr	530(ra) # 80002e2e <iunlockput>
  end_op();
    80004c24:	fffff097          	auipc	ra,0xfffff
    80004c28:	9f0080e7          	jalr	-1552(ra) # 80003614 <end_op>
  return -1;
    80004c2c:	557d                	li	a0,-1
    80004c2e:	64ee                	ld	s1,216(sp)
}
    80004c30:	70ae                	ld	ra,232(sp)
    80004c32:	740e                	ld	s0,224(sp)
    80004c34:	616d                	add	sp,sp,240
    80004c36:	8082                	ret
    return -1;
    80004c38:	557d                	li	a0,-1
    80004c3a:	bfdd                	j	80004c30 <sys_unlink+0x1c6>
    iunlockput(ip);
    80004c3c:	854a                	mv	a0,s2
    80004c3e:	ffffe097          	auipc	ra,0xffffe
    80004c42:	1f0080e7          	jalr	496(ra) # 80002e2e <iunlockput>
    goto bad;
    80004c46:	694e                	ld	s2,208(sp)
    80004c48:	69ae                	ld	s3,200(sp)
    80004c4a:	bfc1                	j	80004c1a <sys_unlink+0x1b0>

0000000080004c4c <sys_open>:

uint64
sys_open(void)
{
    80004c4c:	7131                	add	sp,sp,-192
    80004c4e:	fd06                	sd	ra,184(sp)
    80004c50:	f922                	sd	s0,176(sp)
    80004c52:	f526                	sd	s1,168(sp)
    80004c54:	0180                	add	s0,sp,192
  int fd, omode;
  struct file *f;
  struct inode *ip;
  int n;

  if((n = argstr(0, path, MAXPATH)) < 0 || argint(1, &omode) < 0)
    80004c56:	08000613          	li	a2,128
    80004c5a:	f5040593          	add	a1,s0,-176
    80004c5e:	4501                	li	a0,0
    80004c60:	ffffd097          	auipc	ra,0xffffd
    80004c64:	438080e7          	jalr	1080(ra) # 80002098 <argstr>
    return -1;
    80004c68:	54fd                	li	s1,-1
  if((n = argstr(0, path, MAXPATH)) < 0 || argint(1, &omode) < 0)
    80004c6a:	0c054463          	bltz	a0,80004d32 <sys_open+0xe6>
    80004c6e:	f4c40593          	add	a1,s0,-180
    80004c72:	4505                	li	a0,1
    80004c74:	ffffd097          	auipc	ra,0xffffd
    80004c78:	3e0080e7          	jalr	992(ra) # 80002054 <argint>
    80004c7c:	0a054b63          	bltz	a0,80004d32 <sys_open+0xe6>
    80004c80:	f14a                	sd	s2,160(sp)

  begin_op();
    80004c82:	fffff097          	auipc	ra,0xfffff
    80004c86:	918080e7          	jalr	-1768(ra) # 8000359a <begin_op>

  if(omode & O_CREATE){
    80004c8a:	f4c42783          	lw	a5,-180(s0)
    80004c8e:	2007f793          	and	a5,a5,512
    80004c92:	cfc5                	beqz	a5,80004d4a <sys_open+0xfe>
    ip = create(path, T_FILE, 0, 0);
    80004c94:	4681                	li	a3,0
    80004c96:	4601                	li	a2,0
    80004c98:	4589                	li	a1,2
    80004c9a:	f5040513          	add	a0,s0,-176
    80004c9e:	00000097          	auipc	ra,0x0
    80004ca2:	958080e7          	jalr	-1704(ra) # 800045f6 <create>
    80004ca6:	892a                	mv	s2,a0
    if(ip == 0){
    80004ca8:	c959                	beqz	a0,80004d3e <sys_open+0xf2>
      end_op();
      return -1;
    }
  }

  if(ip->type == T_DEVICE && (ip->major < 0 || ip->major >= NDEV)){
    80004caa:	04491703          	lh	a4,68(s2)
    80004cae:	478d                	li	a5,3
    80004cb0:	00f71763          	bne	a4,a5,80004cbe <sys_open+0x72>
    80004cb4:	04695703          	lhu	a4,70(s2)
    80004cb8:	47a5                	li	a5,9
    80004cba:	0ce7ef63          	bltu	a5,a4,80004d98 <sys_open+0x14c>
    80004cbe:	ed4e                	sd	s3,152(sp)
    iunlockput(ip);
    end_op();
    return -1;
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
    80004cc0:	fffff097          	auipc	ra,0xfffff
    80004cc4:	cf0080e7          	jalr	-784(ra) # 800039b0 <filealloc>
    80004cc8:	89aa                	mv	s3,a0
    80004cca:	c965                	beqz	a0,80004dba <sys_open+0x16e>
    80004ccc:	00000097          	auipc	ra,0x0
    80004cd0:	8e6080e7          	jalr	-1818(ra) # 800045b2 <fdalloc>
    80004cd4:	84aa                	mv	s1,a0
    80004cd6:	0c054d63          	bltz	a0,80004db0 <sys_open+0x164>
    iunlockput(ip);
    end_op();
    return -1;
  }

  if(ip->type == T_DEVICE){
    80004cda:	04491703          	lh	a4,68(s2)
    80004cde:	478d                	li	a5,3
    80004ce0:	0ef70a63          	beq	a4,a5,80004dd4 <sys_open+0x188>
    f->type = FD_DEVICE;
    f->major = ip->major;
  } else {
    f->type = FD_INODE;
    80004ce4:	4789                	li	a5,2
    80004ce6:	00f9a023          	sw	a5,0(s3)
    f->off = 0;
    80004cea:	0209a823          	sw	zero,48(s3)
  }
  f->ip = ip;
    80004cee:	0129bc23          	sd	s2,24(s3)
  f->readable = !(omode & O_WRONLY);
    80004cf2:	f4c42783          	lw	a5,-180(s0)
    80004cf6:	0017c713          	xor	a4,a5,1
    80004cfa:	8b05                	and	a4,a4,1
    80004cfc:	00e98423          	sb	a4,8(s3)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
    80004d00:	0037f713          	and	a4,a5,3
    80004d04:	00e03733          	snez	a4,a4
    80004d08:	00e984a3          	sb	a4,9(s3)

  if((omode & O_TRUNC) && ip->type == T_FILE){
    80004d0c:	4007f793          	and	a5,a5,1024
    80004d10:	c791                	beqz	a5,80004d1c <sys_open+0xd0>
    80004d12:	04491703          	lh	a4,68(s2)
    80004d16:	4789                	li	a5,2
    80004d18:	0cf70563          	beq	a4,a5,80004de2 <sys_open+0x196>
    itrunc(ip);
  }

  iunlock(ip);
    80004d1c:	854a                	mv	a0,s2
    80004d1e:	ffffe097          	auipc	ra,0xffffe
    80004d22:	f70080e7          	jalr	-144(ra) # 80002c8e <iunlock>
  end_op();
    80004d26:	fffff097          	auipc	ra,0xfffff
    80004d2a:	8ee080e7          	jalr	-1810(ra) # 80003614 <end_op>
    80004d2e:	790a                	ld	s2,160(sp)
    80004d30:	69ea                	ld	s3,152(sp)

  return fd;
}
    80004d32:	8526                	mv	a0,s1
    80004d34:	70ea                	ld	ra,184(sp)
    80004d36:	744a                	ld	s0,176(sp)
    80004d38:	74aa                	ld	s1,168(sp)
    80004d3a:	6129                	add	sp,sp,192
    80004d3c:	8082                	ret
      end_op();
    80004d3e:	fffff097          	auipc	ra,0xfffff
    80004d42:	8d6080e7          	jalr	-1834(ra) # 80003614 <end_op>
      return -1;
    80004d46:	790a                	ld	s2,160(sp)
    80004d48:	b7ed                	j	80004d32 <sys_open+0xe6>
    if((ip = namei(path)) == 0){
    80004d4a:	f5040513          	add	a0,s0,-176
    80004d4e:	ffffe097          	auipc	ra,0xffffe
    80004d52:	64c080e7          	jalr	1612(ra) # 8000339a <namei>
    80004d56:	892a                	mv	s2,a0
    80004d58:	c90d                	beqz	a0,80004d8a <sys_open+0x13e>
    ilock(ip);
    80004d5a:	ffffe097          	auipc	ra,0xffffe
    80004d5e:	e6e080e7          	jalr	-402(ra) # 80002bc8 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
    80004d62:	04491703          	lh	a4,68(s2)
    80004d66:	4785                	li	a5,1
    80004d68:	f4f711e3          	bne	a4,a5,80004caa <sys_open+0x5e>
    80004d6c:	f4c42783          	lw	a5,-180(s0)
    80004d70:	d7b9                	beqz	a5,80004cbe <sys_open+0x72>
      iunlockput(ip);
    80004d72:	854a                	mv	a0,s2
    80004d74:	ffffe097          	auipc	ra,0xffffe
    80004d78:	0ba080e7          	jalr	186(ra) # 80002e2e <iunlockput>
      end_op();
    80004d7c:	fffff097          	auipc	ra,0xfffff
    80004d80:	898080e7          	jalr	-1896(ra) # 80003614 <end_op>
      return -1;
    80004d84:	54fd                	li	s1,-1
    80004d86:	790a                	ld	s2,160(sp)
    80004d88:	b76d                	j	80004d32 <sys_open+0xe6>
      end_op();
    80004d8a:	fffff097          	auipc	ra,0xfffff
    80004d8e:	88a080e7          	jalr	-1910(ra) # 80003614 <end_op>
      return -1;
    80004d92:	54fd                	li	s1,-1
    80004d94:	790a                	ld	s2,160(sp)
    80004d96:	bf71                	j	80004d32 <sys_open+0xe6>
    iunlockput(ip);
    80004d98:	854a                	mv	a0,s2
    80004d9a:	ffffe097          	auipc	ra,0xffffe
    80004d9e:	094080e7          	jalr	148(ra) # 80002e2e <iunlockput>
    end_op();
    80004da2:	fffff097          	auipc	ra,0xfffff
    80004da6:	872080e7          	jalr	-1934(ra) # 80003614 <end_op>
    return -1;
    80004daa:	54fd                	li	s1,-1
    80004dac:	790a                	ld	s2,160(sp)
    80004dae:	b751                	j	80004d32 <sys_open+0xe6>
      fileclose(f);
    80004db0:	854e                	mv	a0,s3
    80004db2:	fffff097          	auipc	ra,0xfffff
    80004db6:	cba080e7          	jalr	-838(ra) # 80003a6c <fileclose>
    iunlockput(ip);
    80004dba:	854a                	mv	a0,s2
    80004dbc:	ffffe097          	auipc	ra,0xffffe
    80004dc0:	072080e7          	jalr	114(ra) # 80002e2e <iunlockput>
    end_op();
    80004dc4:	fffff097          	auipc	ra,0xfffff
    80004dc8:	850080e7          	jalr	-1968(ra) # 80003614 <end_op>
    return -1;
    80004dcc:	54fd                	li	s1,-1
    80004dce:	790a                	ld	s2,160(sp)
    80004dd0:	69ea                	ld	s3,152(sp)
    80004dd2:	b785                	j	80004d32 <sys_open+0xe6>
    f->type = FD_DEVICE;
    80004dd4:	00f9a023          	sw	a5,0(s3)
    f->major = ip->major;
    80004dd8:	04691783          	lh	a5,70(s2)
    80004ddc:	02f99a23          	sh	a5,52(s3)
    80004de0:	b739                	j	80004cee <sys_open+0xa2>
    itrunc(ip);
    80004de2:	854a                	mv	a0,s2
    80004de4:	ffffe097          	auipc	ra,0xffffe
    80004de8:	ef6080e7          	jalr	-266(ra) # 80002cda <itrunc>
    80004dec:	bf05                	j	80004d1c <sys_open+0xd0>

0000000080004dee <sys_mkdir>:

uint64
sys_mkdir(void)
{
    80004dee:	7175                	add	sp,sp,-144
    80004df0:	e506                	sd	ra,136(sp)
    80004df2:	e122                	sd	s0,128(sp)
    80004df4:	0900                	add	s0,sp,144
  char path[MAXPATH];
  struct inode *ip;

  begin_op();
    80004df6:	ffffe097          	auipc	ra,0xffffe
    80004dfa:	7a4080e7          	jalr	1956(ra) # 8000359a <begin_op>
  if(argstr(0, path, MAXPATH) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
    80004dfe:	08000613          	li	a2,128
    80004e02:	f7040593          	add	a1,s0,-144
    80004e06:	4501                	li	a0,0
    80004e08:	ffffd097          	auipc	ra,0xffffd
    80004e0c:	290080e7          	jalr	656(ra) # 80002098 <argstr>
    80004e10:	02054963          	bltz	a0,80004e42 <sys_mkdir+0x54>
    80004e14:	4681                	li	a3,0
    80004e16:	4601                	li	a2,0
    80004e18:	4585                	li	a1,1
    80004e1a:	f7040513          	add	a0,s0,-144
    80004e1e:	fffff097          	auipc	ra,0xfffff
    80004e22:	7d8080e7          	jalr	2008(ra) # 800045f6 <create>
    80004e26:	cd11                	beqz	a0,80004e42 <sys_mkdir+0x54>
    end_op();
    return -1;
  }
  iunlockput(ip);
    80004e28:	ffffe097          	auipc	ra,0xffffe
    80004e2c:	006080e7          	jalr	6(ra) # 80002e2e <iunlockput>
  end_op();
    80004e30:	ffffe097          	auipc	ra,0xffffe
    80004e34:	7e4080e7          	jalr	2020(ra) # 80003614 <end_op>
  return 0;
    80004e38:	4501                	li	a0,0
}
    80004e3a:	60aa                	ld	ra,136(sp)
    80004e3c:	640a                	ld	s0,128(sp)
    80004e3e:	6149                	add	sp,sp,144
    80004e40:	8082                	ret
    end_op();
    80004e42:	ffffe097          	auipc	ra,0xffffe
    80004e46:	7d2080e7          	jalr	2002(ra) # 80003614 <end_op>
    return -1;
    80004e4a:	557d                	li	a0,-1
    80004e4c:	b7fd                	j	80004e3a <sys_mkdir+0x4c>

0000000080004e4e <sys_mknod>:

uint64
sys_mknod(void)
{
    80004e4e:	7135                	add	sp,sp,-160
    80004e50:	ed06                	sd	ra,152(sp)
    80004e52:	e922                	sd	s0,144(sp)
    80004e54:	1100                	add	s0,sp,160
  struct inode *ip;
  char path[MAXPATH];
  int major, minor;

  begin_op();
    80004e56:	ffffe097          	auipc	ra,0xffffe
    80004e5a:	744080e7          	jalr	1860(ra) # 8000359a <begin_op>
  if((argstr(0, path, MAXPATH)) < 0 ||
    80004e5e:	08000613          	li	a2,128
    80004e62:	f7040593          	add	a1,s0,-144
    80004e66:	4501                	li	a0,0
    80004e68:	ffffd097          	auipc	ra,0xffffd
    80004e6c:	230080e7          	jalr	560(ra) # 80002098 <argstr>
    80004e70:	04054a63          	bltz	a0,80004ec4 <sys_mknod+0x76>
     argint(1, &major) < 0 ||
    80004e74:	f6c40593          	add	a1,s0,-148
    80004e78:	4505                	li	a0,1
    80004e7a:	ffffd097          	auipc	ra,0xffffd
    80004e7e:	1da080e7          	jalr	474(ra) # 80002054 <argint>
  if((argstr(0, path, MAXPATH)) < 0 ||
    80004e82:	04054163          	bltz	a0,80004ec4 <sys_mknod+0x76>
     argint(2, &minor) < 0 ||
    80004e86:	f6840593          	add	a1,s0,-152
    80004e8a:	4509                	li	a0,2
    80004e8c:	ffffd097          	auipc	ra,0xffffd
    80004e90:	1c8080e7          	jalr	456(ra) # 80002054 <argint>
     argint(1, &major) < 0 ||
    80004e94:	02054863          	bltz	a0,80004ec4 <sys_mknod+0x76>
     (ip = create(path, T_DEVICE, major, minor)) == 0){
    80004e98:	f6841683          	lh	a3,-152(s0)
    80004e9c:	f6c41603          	lh	a2,-148(s0)
    80004ea0:	458d                	li	a1,3
    80004ea2:	f7040513          	add	a0,s0,-144
    80004ea6:	fffff097          	auipc	ra,0xfffff
    80004eaa:	750080e7          	jalr	1872(ra) # 800045f6 <create>
     argint(2, &minor) < 0 ||
    80004eae:	c919                	beqz	a0,80004ec4 <sys_mknod+0x76>
    end_op();
    return -1;
  }
  iunlockput(ip);
    80004eb0:	ffffe097          	auipc	ra,0xffffe
    80004eb4:	f7e080e7          	jalr	-130(ra) # 80002e2e <iunlockput>
  end_op();
    80004eb8:	ffffe097          	auipc	ra,0xffffe
    80004ebc:	75c080e7          	jalr	1884(ra) # 80003614 <end_op>
  return 0;
    80004ec0:	4501                	li	a0,0
    80004ec2:	a031                	j	80004ece <sys_mknod+0x80>
    end_op();
    80004ec4:	ffffe097          	auipc	ra,0xffffe
    80004ec8:	750080e7          	jalr	1872(ra) # 80003614 <end_op>
    return -1;
    80004ecc:	557d                	li	a0,-1
}
    80004ece:	60ea                	ld	ra,152(sp)
    80004ed0:	644a                	ld	s0,144(sp)
    80004ed2:	610d                	add	sp,sp,160
    80004ed4:	8082                	ret

0000000080004ed6 <sys_chdir>:

uint64
sys_chdir(void)
{
    80004ed6:	7135                	add	sp,sp,-160
    80004ed8:	ed06                	sd	ra,152(sp)
    80004eda:	e922                	sd	s0,144(sp)
    80004edc:	e14a                	sd	s2,128(sp)
    80004ede:	1100                	add	s0,sp,160
  char path[MAXPATH];
  struct inode *ip;
  struct proc *p = myproc();
    80004ee0:	ffffc097          	auipc	ra,0xffffc
    80004ee4:	066080e7          	jalr	102(ra) # 80000f46 <myproc>
    80004ee8:	892a                	mv	s2,a0
  
  begin_op();
    80004eea:	ffffe097          	auipc	ra,0xffffe
    80004eee:	6b0080e7          	jalr	1712(ra) # 8000359a <begin_op>
  if(argstr(0, path, MAXPATH) < 0 || (ip = namei(path)) == 0){
    80004ef2:	08000613          	li	a2,128
    80004ef6:	f6040593          	add	a1,s0,-160
    80004efa:	4501                	li	a0,0
    80004efc:	ffffd097          	auipc	ra,0xffffd
    80004f00:	19c080e7          	jalr	412(ra) # 80002098 <argstr>
    80004f04:	04054d63          	bltz	a0,80004f5e <sys_chdir+0x88>
    80004f08:	e526                	sd	s1,136(sp)
    80004f0a:	f6040513          	add	a0,s0,-160
    80004f0e:	ffffe097          	auipc	ra,0xffffe
    80004f12:	48c080e7          	jalr	1164(ra) # 8000339a <namei>
    80004f16:	84aa                	mv	s1,a0
    80004f18:	c131                	beqz	a0,80004f5c <sys_chdir+0x86>
    end_op();
    return -1;
  }
  ilock(ip);
    80004f1a:	ffffe097          	auipc	ra,0xffffe
    80004f1e:	cae080e7          	jalr	-850(ra) # 80002bc8 <ilock>
  if(ip->type != T_DIR){
    80004f22:	04449703          	lh	a4,68(s1)
    80004f26:	4785                	li	a5,1
    80004f28:	04f71163          	bne	a4,a5,80004f6a <sys_chdir+0x94>
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
    80004f2c:	8526                	mv	a0,s1
    80004f2e:	ffffe097          	auipc	ra,0xffffe
    80004f32:	d60080e7          	jalr	-672(ra) # 80002c8e <iunlock>
  iput(p->cwd);
    80004f36:	5d093503          	ld	a0,1488(s2)
    80004f3a:	ffffe097          	auipc	ra,0xffffe
    80004f3e:	e4c080e7          	jalr	-436(ra) # 80002d86 <iput>
  end_op();
    80004f42:	ffffe097          	auipc	ra,0xffffe
    80004f46:	6d2080e7          	jalr	1746(ra) # 80003614 <end_op>
  p->cwd = ip;
    80004f4a:	5c993823          	sd	s1,1488(s2)
  return 0;
    80004f4e:	4501                	li	a0,0
    80004f50:	64aa                	ld	s1,136(sp)
}
    80004f52:	60ea                	ld	ra,152(sp)
    80004f54:	644a                	ld	s0,144(sp)
    80004f56:	690a                	ld	s2,128(sp)
    80004f58:	610d                	add	sp,sp,160
    80004f5a:	8082                	ret
    80004f5c:	64aa                	ld	s1,136(sp)
    end_op();
    80004f5e:	ffffe097          	auipc	ra,0xffffe
    80004f62:	6b6080e7          	jalr	1718(ra) # 80003614 <end_op>
    return -1;
    80004f66:	557d                	li	a0,-1
    80004f68:	b7ed                	j	80004f52 <sys_chdir+0x7c>
    iunlockput(ip);
    80004f6a:	8526                	mv	a0,s1
    80004f6c:	ffffe097          	auipc	ra,0xffffe
    80004f70:	ec2080e7          	jalr	-318(ra) # 80002e2e <iunlockput>
    end_op();
    80004f74:	ffffe097          	auipc	ra,0xffffe
    80004f78:	6a0080e7          	jalr	1696(ra) # 80003614 <end_op>
    return -1;
    80004f7c:	557d                	li	a0,-1
    80004f7e:	64aa                	ld	s1,136(sp)
    80004f80:	bfc9                	j	80004f52 <sys_chdir+0x7c>

0000000080004f82 <sys_exec>:

uint64
sys_exec(void)
{
    80004f82:	7121                	add	sp,sp,-448
    80004f84:	ff06                	sd	ra,440(sp)
    80004f86:	fb22                	sd	s0,432(sp)
    80004f88:	f34a                	sd	s2,416(sp)
    80004f8a:	0380                	add	s0,sp,448
  char path[MAXPATH], *argv[MAXARG];
  int i;
  uint64 uargv, uarg;

  if(argstr(0, path, MAXPATH) < 0 || argaddr(1, &uargv) < 0){
    80004f8c:	08000613          	li	a2,128
    80004f90:	f5040593          	add	a1,s0,-176
    80004f94:	4501                	li	a0,0
    80004f96:	ffffd097          	auipc	ra,0xffffd
    80004f9a:	102080e7          	jalr	258(ra) # 80002098 <argstr>
    return -1;
    80004f9e:	597d                	li	s2,-1
  if(argstr(0, path, MAXPATH) < 0 || argaddr(1, &uargv) < 0){
    80004fa0:	0e054a63          	bltz	a0,80005094 <sys_exec+0x112>
    80004fa4:	e4840593          	add	a1,s0,-440
    80004fa8:	4505                	li	a0,1
    80004faa:	ffffd097          	auipc	ra,0xffffd
    80004fae:	0cc080e7          	jalr	204(ra) # 80002076 <argaddr>
    80004fb2:	0e054163          	bltz	a0,80005094 <sys_exec+0x112>
    80004fb6:	f726                	sd	s1,424(sp)
    80004fb8:	ef4e                	sd	s3,408(sp)
    80004fba:	eb52                	sd	s4,400(sp)
  }
  memset(argv, 0, sizeof(argv));
    80004fbc:	10000613          	li	a2,256
    80004fc0:	4581                	li	a1,0
    80004fc2:	e5040513          	add	a0,s0,-432
    80004fc6:	ffffb097          	auipc	ra,0xffffb
    80004fca:	1b4080e7          	jalr	436(ra) # 8000017a <memset>
  for(i=0;; i++){
    if(i >= NELEM(argv)){
    80004fce:	e5040493          	add	s1,s0,-432
  memset(argv, 0, sizeof(argv));
    80004fd2:	89a6                	mv	s3,s1
    80004fd4:	4901                	li	s2,0
    if(i >= NELEM(argv)){
    80004fd6:	02000a13          	li	s4,32
      goto bad;
    }
    if(fetchaddr(uargv+sizeof(uint64)*i, (uint64*)&uarg) < 0){
    80004fda:	00391513          	sll	a0,s2,0x3
    80004fde:	e4040593          	add	a1,s0,-448
    80004fe2:	e4843783          	ld	a5,-440(s0)
    80004fe6:	953e                	add	a0,a0,a5
    80004fe8:	ffffd097          	auipc	ra,0xffffd
    80004fec:	fd2080e7          	jalr	-46(ra) # 80001fba <fetchaddr>
    80004ff0:	02054a63          	bltz	a0,80005024 <sys_exec+0xa2>
      goto bad;
    }
    if(uarg == 0){
    80004ff4:	e4043783          	ld	a5,-448(s0)
    80004ff8:	c7b1                	beqz	a5,80005044 <sys_exec+0xc2>
      argv[i] = 0;
      break;
    }
    argv[i] = kalloc();
    80004ffa:	ffffb097          	auipc	ra,0xffffb
    80004ffe:	120080e7          	jalr	288(ra) # 8000011a <kalloc>
    80005002:	85aa                	mv	a1,a0
    80005004:	00a9b023          	sd	a0,0(s3)
    if(argv[i] == 0)
    80005008:	cd11                	beqz	a0,80005024 <sys_exec+0xa2>
      goto bad;
    if(fetchstr(uarg, argv[i], PGSIZE) < 0)
    8000500a:	6605                	lui	a2,0x1
    8000500c:	e4043503          	ld	a0,-448(s0)
    80005010:	ffffd097          	auipc	ra,0xffffd
    80005014:	ffc080e7          	jalr	-4(ra) # 8000200c <fetchstr>
    80005018:	00054663          	bltz	a0,80005024 <sys_exec+0xa2>
    if(i >= NELEM(argv)){
    8000501c:	0905                	add	s2,s2,1
    8000501e:	09a1                	add	s3,s3,8
    80005020:	fb491de3          	bne	s2,s4,80004fda <sys_exec+0x58>
    kfree(argv[i]);

  return ret;

 bad:
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    80005024:	f5040913          	add	s2,s0,-176
    80005028:	6088                	ld	a0,0(s1)
    8000502a:	c12d                	beqz	a0,8000508c <sys_exec+0x10a>
    kfree(argv[i]);
    8000502c:	ffffb097          	auipc	ra,0xffffb
    80005030:	ff0080e7          	jalr	-16(ra) # 8000001c <kfree>
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    80005034:	04a1                	add	s1,s1,8
    80005036:	ff2499e3          	bne	s1,s2,80005028 <sys_exec+0xa6>
  return -1;
    8000503a:	597d                	li	s2,-1
    8000503c:	74ba                	ld	s1,424(sp)
    8000503e:	69fa                	ld	s3,408(sp)
    80005040:	6a5a                	ld	s4,400(sp)
    80005042:	a889                	j	80005094 <sys_exec+0x112>
      argv[i] = 0;
    80005044:	0009079b          	sext.w	a5,s2
    80005048:	078e                	sll	a5,a5,0x3
    8000504a:	fd078793          	add	a5,a5,-48
    8000504e:	97a2                	add	a5,a5,s0
    80005050:	e807b023          	sd	zero,-384(a5)
  int ret = exec(path, argv);
    80005054:	e5040593          	add	a1,s0,-432
    80005058:	f5040513          	add	a0,s0,-176
    8000505c:	fffff097          	auipc	ra,0xfffff
    80005060:	122080e7          	jalr	290(ra) # 8000417e <exec>
    80005064:	892a                	mv	s2,a0
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    80005066:	f5040993          	add	s3,s0,-176
    8000506a:	6088                	ld	a0,0(s1)
    8000506c:	cd01                	beqz	a0,80005084 <sys_exec+0x102>
    kfree(argv[i]);
    8000506e:	ffffb097          	auipc	ra,0xffffb
    80005072:	fae080e7          	jalr	-82(ra) # 8000001c <kfree>
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    80005076:	04a1                	add	s1,s1,8
    80005078:	ff3499e3          	bne	s1,s3,8000506a <sys_exec+0xe8>
    8000507c:	74ba                	ld	s1,424(sp)
    8000507e:	69fa                	ld	s3,408(sp)
    80005080:	6a5a                	ld	s4,400(sp)
    80005082:	a809                	j	80005094 <sys_exec+0x112>
  return ret;
    80005084:	74ba                	ld	s1,424(sp)
    80005086:	69fa                	ld	s3,408(sp)
    80005088:	6a5a                	ld	s4,400(sp)
    8000508a:	a029                	j	80005094 <sys_exec+0x112>
  return -1;
    8000508c:	597d                	li	s2,-1
    8000508e:	74ba                	ld	s1,424(sp)
    80005090:	69fa                	ld	s3,408(sp)
    80005092:	6a5a                	ld	s4,400(sp)
}
    80005094:	854a                	mv	a0,s2
    80005096:	70fa                	ld	ra,440(sp)
    80005098:	745a                	ld	s0,432(sp)
    8000509a:	791a                	ld	s2,416(sp)
    8000509c:	6139                	add	sp,sp,448
    8000509e:	8082                	ret

00000000800050a0 <sys_pipe>:

uint64
sys_pipe(void)
{
    800050a0:	7139                	add	sp,sp,-64
    800050a2:	fc06                	sd	ra,56(sp)
    800050a4:	f822                	sd	s0,48(sp)
    800050a6:	f426                	sd	s1,40(sp)
    800050a8:	0080                	add	s0,sp,64
  uint64 fdarray; // user pointer to array of two integers
  struct file *rf, *wf;
  int fd0, fd1;
  struct proc *p = myproc();
    800050aa:	ffffc097          	auipc	ra,0xffffc
    800050ae:	e9c080e7          	jalr	-356(ra) # 80000f46 <myproc>
    800050b2:	84aa                	mv	s1,a0

  if(argaddr(0, &fdarray) < 0)
    800050b4:	fd840593          	add	a1,s0,-40
    800050b8:	4501                	li	a0,0
    800050ba:	ffffd097          	auipc	ra,0xffffd
    800050be:	fbc080e7          	jalr	-68(ra) # 80002076 <argaddr>
    return -1;
    800050c2:	57fd                	li	a5,-1
  if(argaddr(0, &fdarray) < 0)
    800050c4:	0e054063          	bltz	a0,800051a4 <sys_pipe+0x104>
  if(pipealloc(&rf, &wf) < 0)
    800050c8:	fc840593          	add	a1,s0,-56
    800050cc:	fd040513          	add	a0,s0,-48
    800050d0:	fffff097          	auipc	ra,0xfffff
    800050d4:	d6c080e7          	jalr	-660(ra) # 80003e3c <pipealloc>
    return -1;
    800050d8:	57fd                	li	a5,-1
  if(pipealloc(&rf, &wf) < 0)
    800050da:	0c054563          	bltz	a0,800051a4 <sys_pipe+0x104>
  fd0 = -1;
    800050de:	fcf42223          	sw	a5,-60(s0)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
    800050e2:	fd043503          	ld	a0,-48(s0)
    800050e6:	fffff097          	auipc	ra,0xfffff
    800050ea:	4cc080e7          	jalr	1228(ra) # 800045b2 <fdalloc>
    800050ee:	fca42223          	sw	a0,-60(s0)
    800050f2:	08054c63          	bltz	a0,8000518a <sys_pipe+0xea>
    800050f6:	fc843503          	ld	a0,-56(s0)
    800050fa:	fffff097          	auipc	ra,0xfffff
    800050fe:	4b8080e7          	jalr	1208(ra) # 800045b2 <fdalloc>
    80005102:	fca42023          	sw	a0,-64(s0)
    80005106:	06054963          	bltz	a0,80005178 <sys_pipe+0xd8>
      p->ofile[fd0] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  if(copyout(p->pagetable, fdarray, (char*)&fd0, sizeof(fd0)) < 0 ||
    8000510a:	4691                	li	a3,4
    8000510c:	fc440613          	add	a2,s0,-60
    80005110:	fd843583          	ld	a1,-40(s0)
    80005114:	68a8                	ld	a0,80(s1)
    80005116:	ffffc097          	auipc	ra,0xffffc
    8000511a:	aac080e7          	jalr	-1364(ra) # 80000bc2 <copyout>
    8000511e:	02054063          	bltz	a0,8000513e <sys_pipe+0x9e>
     copyout(p->pagetable, fdarray+sizeof(fd0), (char *)&fd1, sizeof(fd1)) < 0){
    80005122:	4691                	li	a3,4
    80005124:	fc040613          	add	a2,s0,-64
    80005128:	fd843583          	ld	a1,-40(s0)
    8000512c:	0591                	add	a1,a1,4
    8000512e:	68a8                	ld	a0,80(s1)
    80005130:	ffffc097          	auipc	ra,0xffffc
    80005134:	a92080e7          	jalr	-1390(ra) # 80000bc2 <copyout>
    p->ofile[fd1] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  return 0;
    80005138:	4781                	li	a5,0
  if(copyout(p->pagetable, fdarray, (char*)&fd0, sizeof(fd0)) < 0 ||
    8000513a:	06055563          	bgez	a0,800051a4 <sys_pipe+0x104>
    p->ofile[fd0] = 0;
    8000513e:	fc442783          	lw	a5,-60(s0)
    80005142:	07e9                	add	a5,a5,26
    80005144:	078e                	sll	a5,a5,0x3
    80005146:	97a6                	add	a5,a5,s1
    80005148:	0007b023          	sd	zero,0(a5)
    p->ofile[fd1] = 0;
    8000514c:	fc042783          	lw	a5,-64(s0)
    80005150:	07e9                	add	a5,a5,26
    80005152:	078e                	sll	a5,a5,0x3
    80005154:	00f48533          	add	a0,s1,a5
    80005158:	00053023          	sd	zero,0(a0)
    fileclose(rf);
    8000515c:	fd043503          	ld	a0,-48(s0)
    80005160:	fffff097          	auipc	ra,0xfffff
    80005164:	90c080e7          	jalr	-1780(ra) # 80003a6c <fileclose>
    fileclose(wf);
    80005168:	fc843503          	ld	a0,-56(s0)
    8000516c:	fffff097          	auipc	ra,0xfffff
    80005170:	900080e7          	jalr	-1792(ra) # 80003a6c <fileclose>
    return -1;
    80005174:	57fd                	li	a5,-1
    80005176:	a03d                	j	800051a4 <sys_pipe+0x104>
    if(fd0 >= 0)
    80005178:	fc442783          	lw	a5,-60(s0)
    8000517c:	0007c763          	bltz	a5,8000518a <sys_pipe+0xea>
      p->ofile[fd0] = 0;
    80005180:	07e9                	add	a5,a5,26
    80005182:	078e                	sll	a5,a5,0x3
    80005184:	97a6                	add	a5,a5,s1
    80005186:	0007b023          	sd	zero,0(a5)
    fileclose(rf);
    8000518a:	fd043503          	ld	a0,-48(s0)
    8000518e:	fffff097          	auipc	ra,0xfffff
    80005192:	8de080e7          	jalr	-1826(ra) # 80003a6c <fileclose>
    fileclose(wf);
    80005196:	fc843503          	ld	a0,-56(s0)
    8000519a:	fffff097          	auipc	ra,0xfffff
    8000519e:	8d2080e7          	jalr	-1838(ra) # 80003a6c <fileclose>
    return -1;
    800051a2:	57fd                	li	a5,-1
}
    800051a4:	853e                	mv	a0,a5
    800051a6:	70e2                	ld	ra,56(sp)
    800051a8:	7442                	ld	s0,48(sp)
    800051aa:	74a2                	ld	s1,40(sp)
    800051ac:	6121                	add	sp,sp,64
    800051ae:	8082                	ret

00000000800051b0 <sys_uconnect>:


// udp connect
int
sys_uconnect(void)
{
    800051b0:	7179                	add	sp,sp,-48
    800051b2:	f406                	sd	ra,40(sp)
    800051b4:	f022                	sd	s0,32(sp)
    800051b6:	1800                	add	s0,sp,48
  int fd;
  uint32 raddr;
  uint32 rport;
  uint32 lport;

  if (argint(0, (int*)&raddr) < 0 ||
    800051b8:	fe440593          	add	a1,s0,-28
    800051bc:	4501                	li	a0,0
    800051be:	ffffd097          	auipc	ra,0xffffd
    800051c2:	e96080e7          	jalr	-362(ra) # 80002054 <argint>
    800051c6:	06054663          	bltz	a0,80005232 <sys_uconnect+0x82>
      argint(1, (int*)&lport) < 0 ||
    800051ca:	fdc40593          	add	a1,s0,-36
    800051ce:	4505                	li	a0,1
    800051d0:	ffffd097          	auipc	ra,0xffffd
    800051d4:	e84080e7          	jalr	-380(ra) # 80002054 <argint>
  if (argint(0, (int*)&raddr) < 0 ||
    800051d8:	04054f63          	bltz	a0,80005236 <sys_uconnect+0x86>
      argint(2, (int*)&rport) < 0) {
    800051dc:	fe040593          	add	a1,s0,-32
    800051e0:	4509                	li	a0,2
    800051e2:	ffffd097          	auipc	ra,0xffffd
    800051e6:	e72080e7          	jalr	-398(ra) # 80002054 <argint>
      argint(1, (int*)&lport) < 0 ||
    800051ea:	04054863          	bltz	a0,8000523a <sys_uconnect+0x8a>
    return -1;
  }

  if(sockalloc(&f, raddr, lport, rport) < 0)
    800051ee:	fe045683          	lhu	a3,-32(s0)
    800051f2:	fdc45603          	lhu	a2,-36(s0)
    800051f6:	fe442583          	lw	a1,-28(s0)
    800051fa:	fe840513          	add	a0,s0,-24
    800051fe:	00001097          	auipc	ra,0x1
    80005202:	578080e7          	jalr	1400(ra) # 80006776 <sockalloc>
    80005206:	02054c63          	bltz	a0,8000523e <sys_uconnect+0x8e>
    return -1;
  if((fd=fdalloc(f)) < 0){
    8000520a:	fe843503          	ld	a0,-24(s0)
    8000520e:	fffff097          	auipc	ra,0xfffff
    80005212:	3a4080e7          	jalr	932(ra) # 800045b2 <fdalloc>
    80005216:	00054663          	bltz	a0,80005222 <sys_uconnect+0x72>
    fileclose(f);
    return -1;
  }

  return fd;
}
    8000521a:	70a2                	ld	ra,40(sp)
    8000521c:	7402                	ld	s0,32(sp)
    8000521e:	6145                	add	sp,sp,48
    80005220:	8082                	ret
    fileclose(f);
    80005222:	fe843503          	ld	a0,-24(s0)
    80005226:	fffff097          	auipc	ra,0xfffff
    8000522a:	846080e7          	jalr	-1978(ra) # 80003a6c <fileclose>
    return -1;
    8000522e:	557d                	li	a0,-1
    80005230:	b7ed                	j	8000521a <sys_uconnect+0x6a>
    return -1;
    80005232:	557d                	li	a0,-1
    80005234:	b7dd                	j	8000521a <sys_uconnect+0x6a>
    80005236:	557d                	li	a0,-1
    80005238:	b7cd                	j	8000521a <sys_uconnect+0x6a>
    8000523a:	557d                	li	a0,-1
    8000523c:	bff9                	j	8000521a <sys_uconnect+0x6a>
    return -1;
    8000523e:	557d                	li	a0,-1
    80005240:	bfe9                	j	8000521a <sys_uconnect+0x6a>

0000000080005242 <sys_socket>:

int
sys_socket(void)
{
    80005242:	7179                	add	sp,sp,-48
    80005244:	f406                	sd	ra,40(sp)
    80005246:	f022                	sd	s0,32(sp)
    80005248:	1800                	add	s0,sp,48
  int fd;
  int domain;
  int type;
  int protocol;

  if (argint(0, &domain) < 0 ||
    8000524a:	fe440593          	add	a1,s0,-28
    8000524e:	4501                	li	a0,0
    80005250:	ffffd097          	auipc	ra,0xffffd
    80005254:	e04080e7          	jalr	-508(ra) # 80002054 <argint>
    80005258:	08054363          	bltz	a0,800052de <sys_socket+0x9c>
      argint(1, &type) < 0 ||
    8000525c:	fe040593          	add	a1,s0,-32
    80005260:	4505                	li	a0,1
    80005262:	ffffd097          	auipc	ra,0xffffd
    80005266:	df2080e7          	jalr	-526(ra) # 80002054 <argint>
  if (argint(0, &domain) < 0 ||
    8000526a:	06054c63          	bltz	a0,800052e2 <sys_socket+0xa0>
      argint(2, &protocol) < 0) {
    8000526e:	fdc40593          	add	a1,s0,-36
    80005272:	4509                	li	a0,2
    80005274:	ffffd097          	auipc	ra,0xffffd
    80005278:	de0080e7          	jalr	-544(ra) # 80002054 <argint>
      argint(1, &type) < 0 ||
    8000527c:	06054563          	bltz	a0,800052e6 <sys_socket+0xa4>
        return -1;
  }

  if ((f = filealloc()) == 0) {
    80005280:	ffffe097          	auipc	ra,0xffffe
    80005284:	730080e7          	jalr	1840(ra) # 800039b0 <filealloc>
    80005288:	fea43423          	sd	a0,-24(s0)
    8000528c:	c91d                	beqz	a0,800052c2 <sys_socket+0x80>
    fileclose(f);
    return -1;
  }
  
  if(socket(&f, domain, type, protocol) < 0 || (fd=fdalloc(f)) < 0){
    8000528e:	fdc42683          	lw	a3,-36(s0)
    80005292:	fe042603          	lw	a2,-32(s0)
    80005296:	fe442583          	lw	a1,-28(s0)
    8000529a:	fe840513          	add	a0,s0,-24
    8000529e:	00004097          	auipc	ra,0x4
    800052a2:	848080e7          	jalr	-1976(ra) # 80008ae6 <socket>
    800052a6:	02054463          	bltz	a0,800052ce <sys_socket+0x8c>
    800052aa:	fe843503          	ld	a0,-24(s0)
    800052ae:	fffff097          	auipc	ra,0xfffff
    800052b2:	304080e7          	jalr	772(ra) # 800045b2 <fdalloc>
    800052b6:	00054c63          	bltz	a0,800052ce <sys_socket+0x8c>
    fileclose(f);
    return -1;
  }

  return fd;
}
    800052ba:	70a2                	ld	ra,40(sp)
    800052bc:	7402                	ld	s0,32(sp)
    800052be:	6145                	add	sp,sp,48
    800052c0:	8082                	ret
    fileclose(f);
    800052c2:	ffffe097          	auipc	ra,0xffffe
    800052c6:	7aa080e7          	jalr	1962(ra) # 80003a6c <fileclose>
    return -1;
    800052ca:	557d                	li	a0,-1
    800052cc:	b7fd                	j	800052ba <sys_socket+0x78>
    fileclose(f);
    800052ce:	fe843503          	ld	a0,-24(s0)
    800052d2:	ffffe097          	auipc	ra,0xffffe
    800052d6:	79a080e7          	jalr	1946(ra) # 80003a6c <fileclose>
    return -1;
    800052da:	557d                	li	a0,-1
    800052dc:	bff9                	j	800052ba <sys_socket+0x78>
        return -1;
    800052de:	557d                	li	a0,-1
    800052e0:	bfe9                	j	800052ba <sys_socket+0x78>
    800052e2:	557d                	li	a0,-1
    800052e4:	bfd9                	j	800052ba <sys_socket+0x78>
    800052e6:	557d                	li	a0,-1
    800052e8:	bfc9                	j	800052ba <sys_socket+0x78>

00000000800052ea <sys_bind>:

int
sys_bind(void)
{
    800052ea:	7139                	add	sp,sp,-64
    800052ec:	fc06                	sd	ra,56(sp)
    800052ee:	f822                	sd	s0,48(sp)
    800052f0:	0080                	add	s0,sp,64
  struct file *f;
  uint64 uaddr;
  int addrlen;

  if (argfd(0, 0, &f) < 0 || argaddr(1, &uaddr) < 0 || argint(2, &addrlen) < 0)
    800052f2:	fe840613          	add	a2,s0,-24
    800052f6:	4581                	li	a1,0
    800052f8:	4501                	li	a0,0
    800052fa:	fffff097          	auipc	ra,0xfffff
    800052fe:	24e080e7          	jalr	590(ra) # 80004548 <argfd>
    80005302:	08054f63          	bltz	a0,800053a0 <sys_bind+0xb6>
    80005306:	fe040593          	add	a1,s0,-32
    8000530a:	4505                	li	a0,1
    8000530c:	ffffd097          	auipc	ra,0xffffd
    80005310:	d6a080e7          	jalr	-662(ra) # 80002076 <argaddr>
    80005314:	08054863          	bltz	a0,800053a4 <sys_bind+0xba>
    80005318:	fdc40593          	add	a1,s0,-36
    8000531c:	4509                	li	a0,2
    8000531e:	ffffd097          	auipc	ra,0xffffd
    80005322:	d36080e7          	jalr	-714(ra) # 80002054 <argint>
    80005326:	08054163          	bltz	a0,800053a8 <sys_bind+0xbe>
    return -1;

  struct sockaddr ksa;
  copyin(myproc()->pagetable, (char *)&ksa, uaddr, addrlen);
    8000532a:	ffffc097          	auipc	ra,0xffffc
    8000532e:	c1c080e7          	jalr	-996(ra) # 80000f46 <myproc>
    80005332:	fdc42683          	lw	a3,-36(s0)
    80005336:	fe043603          	ld	a2,-32(s0)
    8000533a:	fc840593          	add	a1,s0,-56
    8000533e:	6928                	ld	a0,80(a0)
    80005340:	ffffc097          	auipc	ra,0xffffc
    80005344:	90e080e7          	jalr	-1778(ra) # 80000c4e <copyin>
  struct sockaddr_in *sin = (struct sockaddr_in *)&ksa;
  sin->sin_addr = ntohl(sin->sin_addr);
    80005348:	fcc42783          	lw	a5,-52(s0)
          ((val & 0xff00U) >> 8));
}

static inline uint32 bswapl(uint32 val)
{
  return (((val & 0x000000ffUL) << 24) |
    8000534c:	0187971b          	sllw	a4,a5,0x18
          ((val & 0x0000ff00UL) << 8) |
          ((val & 0x00ff0000UL) >> 8) |
          ((val & 0xff000000UL) >> 24));
    80005350:	0187d69b          	srlw	a3,a5,0x18
          ((val & 0x00ff0000UL) >> 8) |
    80005354:	8f55                	or	a4,a4,a3
          ((val & 0x0000ff00UL) << 8) |
    80005356:	0087969b          	sllw	a3,a5,0x8
    8000535a:	00ff0637          	lui	a2,0xff0
    8000535e:	8ef1                	and	a3,a3,a2
          ((val & 0x00ff0000UL) >> 8) |
    80005360:	8f55                	or	a4,a4,a3
    80005362:	0087d79b          	srlw	a5,a5,0x8
    80005366:	66c1                	lui	a3,0x10
    80005368:	f0068693          	add	a3,a3,-256 # ff00 <_entry-0x7fff0100>
    8000536c:	8ff5                	and	a5,a5,a3
    8000536e:	8fd9                	or	a5,a5,a4
    80005370:	fcf42623          	sw	a5,-52(s0)
  return (((val & 0x00ffU) << 8) |
    80005374:	fca45783          	lhu	a5,-54(s0)
    80005378:	0087971b          	sllw	a4,a5,0x8
    8000537c:	83a1                	srl	a5,a5,0x8
    8000537e:	8fd9                	or	a5,a5,a4
  sin->sin_port = ntohs(sin->sin_port);
    80005380:	fcf41523          	sh	a5,-54(s0)

  return tcp_bind(f, &ksa, addrlen);
    80005384:	fdc42603          	lw	a2,-36(s0)
    80005388:	fc840593          	add	a1,s0,-56
    8000538c:	fe843503          	ld	a0,-24(s0)
    80005390:	00003097          	auipc	ra,0x3
    80005394:	f62080e7          	jalr	-158(ra) # 800082f2 <tcp_bind>
}
    80005398:	70e2                	ld	ra,56(sp)
    8000539a:	7442                	ld	s0,48(sp)
    8000539c:	6121                	add	sp,sp,64
    8000539e:	8082                	ret
    return -1;
    800053a0:	557d                	li	a0,-1
    800053a2:	bfdd                	j	80005398 <sys_bind+0xae>
    800053a4:	557d                	li	a0,-1
    800053a6:	bfcd                	j	80005398 <sys_bind+0xae>
    800053a8:	557d                	li	a0,-1
    800053aa:	b7fd                	j	80005398 <sys_bind+0xae>

00000000800053ac <sys_connect>:

int
sys_connect()
{
    800053ac:	7139                	add	sp,sp,-64
    800053ae:	fc06                	sd	ra,56(sp)
    800053b0:	f822                	sd	s0,48(sp)
    800053b2:	0080                	add	s0,sp,64
  struct file *f;
  uint64 uaddr;
  int addrlen;

  if (argfd(0, 0, &f) < 0 || argaddr(1, &uaddr) < 0 || argint(2, &addrlen) < 0)
    800053b4:	fe840613          	add	a2,s0,-24
    800053b8:	4581                	li	a1,0
    800053ba:	4501                	li	a0,0
    800053bc:	fffff097          	auipc	ra,0xfffff
    800053c0:	18c080e7          	jalr	396(ra) # 80004548 <argfd>
    800053c4:	0e054363          	bltz	a0,800054aa <sys_connect+0xfe>
    800053c8:	fe040593          	add	a1,s0,-32
    800053cc:	4505                	li	a0,1
    800053ce:	ffffd097          	auipc	ra,0xffffd
    800053d2:	ca8080e7          	jalr	-856(ra) # 80002076 <argaddr>
    800053d6:	0c054c63          	bltz	a0,800054ae <sys_connect+0x102>
    800053da:	fdc40593          	add	a1,s0,-36
    800053de:	4509                	li	a0,2
    800053e0:	ffffd097          	auipc	ra,0xffffd
    800053e4:	c74080e7          	jalr	-908(ra) # 80002054 <argint>
    800053e8:	0c054563          	bltz	a0,800054b2 <sys_connect+0x106>
    return -1;

  struct sockaddr ksa;
  copyin(myproc()->pagetable, (char *)&ksa, uaddr, addrlen);
    800053ec:	ffffc097          	auipc	ra,0xffffc
    800053f0:	b5a080e7          	jalr	-1190(ra) # 80000f46 <myproc>
    800053f4:	fdc42683          	lw	a3,-36(s0)
    800053f8:	fe043603          	ld	a2,-32(s0)
    800053fc:	fc840593          	add	a1,s0,-56
    80005400:	6928                	ld	a0,80(a0)
    80005402:	ffffc097          	auipc	ra,0xffffc
    80005406:	84c080e7          	jalr	-1972(ra) # 80000c4e <copyin>
  struct sockaddr_in *sin = (struct sockaddr_in *)&ksa;
  sin->sin_addr = ntohl(sin->sin_addr);
    8000540a:	fcc42783          	lw	a5,-52(s0)
  return (((val & 0x000000ffUL) << 24) |
    8000540e:	0187971b          	sllw	a4,a5,0x18
          ((val & 0xff000000UL) >> 24));
    80005412:	0187d69b          	srlw	a3,a5,0x18
          ((val & 0x00ff0000UL) >> 8) |
    80005416:	8f55                	or	a4,a4,a3
          ((val & 0x0000ff00UL) << 8) |
    80005418:	0087969b          	sllw	a3,a5,0x8
    8000541c:	00ff0637          	lui	a2,0xff0
    80005420:	8ef1                	and	a3,a3,a2
          ((val & 0x00ff0000UL) >> 8) |
    80005422:	8f55                	or	a4,a4,a3
    80005424:	0087d79b          	srlw	a5,a5,0x8
    80005428:	66c1                	lui	a3,0x10
    8000542a:	f0068693          	add	a3,a3,-256 # ff00 <_entry-0x7fff0100>
    8000542e:	8ff5                	and	a5,a5,a3
    80005430:	8fd9                	or	a5,a5,a4
    80005432:	fcf42623          	sw	a5,-52(s0)
  return (((val & 0x00ffU) << 8) |
    80005436:	fca45783          	lhu	a5,-54(s0)
    8000543a:	0087971b          	sllw	a4,a5,0x8
    8000543e:	83a1                	srl	a5,a5,0x8
    80005440:	8fd9                	or	a5,a5,a4
  sin->sin_port = ntohs(sin->sin_port);
    80005442:	fcf41523          	sh	a5,-54(s0)

  uint16 port = auto_alloc_port(f);
    80005446:	fe843503          	ld	a0,-24(s0)
    8000544a:	00003097          	auipc	ra,0x3
    8000544e:	606080e7          	jalr	1542(ra) # 80008a50 <auto_alloc_port>
    80005452:	862a                	mv	a2,a0
  
  if (f->type == FD_SOCK_UDP) {
    80005454:	fe843703          	ld	a4,-24(s0)
    80005458:	431c                	lw	a5,0(a4)
    8000545a:	4691                	li	a3,4
    8000545c:	00d78a63          	beq	a5,a3,80005470 <sys_connect+0xc4>
    if(sockalloc(&f, sin->sin_addr, port, sin->sin_port) < 0)
      return -1;
  } else if (f->type == FD_SOCK_TCP) {
    80005460:	4695                	li	a3,5
    return tcp_connect(f, &ksa, addrlen, port);
  }

  return 0;
    80005462:	4501                	li	a0,0
  } else if (f->type == FD_SOCK_TCP) {
    80005464:	02d78663          	beq	a5,a3,80005490 <sys_connect+0xe4>
}
    80005468:	70e2                	ld	ra,56(sp)
    8000546a:	7442                	ld	s0,48(sp)
    8000546c:	6121                	add	sp,sp,64
    8000546e:	8082                	ret
    if(sockalloc(&f, sin->sin_addr, port, sin->sin_port) < 0)
    80005470:	fca45683          	lhu	a3,-54(s0)
    80005474:	03051613          	sll	a2,a0,0x30
    80005478:	9241                	srl	a2,a2,0x30
    8000547a:	fcc42583          	lw	a1,-52(s0)
    8000547e:	fe840513          	add	a0,s0,-24
    80005482:	00001097          	auipc	ra,0x1
    80005486:	2f4080e7          	jalr	756(ra) # 80006776 <sockalloc>
    8000548a:	41f5551b          	sraw	a0,a0,0x1f
    8000548e:	bfe9                	j	80005468 <sys_connect+0xbc>
    return tcp_connect(f, &ksa, addrlen, port);
    80005490:	03061693          	sll	a3,a2,0x30
    80005494:	92c1                	srl	a3,a3,0x30
    80005496:	fdc42603          	lw	a2,-36(s0)
    8000549a:	fc840593          	add	a1,s0,-56
    8000549e:	853a                	mv	a0,a4
    800054a0:	00003097          	auipc	ra,0x3
    800054a4:	e92080e7          	jalr	-366(ra) # 80008332 <tcp_connect>
    800054a8:	b7c1                	j	80005468 <sys_connect+0xbc>
    return -1;
    800054aa:	557d                	li	a0,-1
    800054ac:	bf75                	j	80005468 <sys_connect+0xbc>
    800054ae:	557d                	li	a0,-1
    800054b0:	bf65                	j	80005468 <sys_connect+0xbc>
    800054b2:	557d                	li	a0,-1
    800054b4:	bf55                	j	80005468 <sys_connect+0xbc>

00000000800054b6 <sys_listen>:

int
sys_listen(void)
{
    800054b6:	1101                	add	sp,sp,-32
    800054b8:	ec06                	sd	ra,24(sp)
    800054ba:	e822                	sd	s0,16(sp)
    800054bc:	1000                	add	s0,sp,32
  struct file *f;
  int backlog;

  if (argfd(0, 0, &f) < 0 || argint(1, &backlog) < 0)
    800054be:	fe840613          	add	a2,s0,-24
    800054c2:	4581                	li	a1,0
    800054c4:	4501                	li	a0,0
    800054c6:	fffff097          	auipc	ra,0xfffff
    800054ca:	082080e7          	jalr	130(ra) # 80004548 <argfd>
    800054ce:	02054763          	bltz	a0,800054fc <sys_listen+0x46>
    800054d2:	fe440593          	add	a1,s0,-28
    800054d6:	4505                	li	a0,1
    800054d8:	ffffd097          	auipc	ra,0xffffd
    800054dc:	b7c080e7          	jalr	-1156(ra) # 80002054 <argint>
    800054e0:	02054063          	bltz	a0,80005500 <sys_listen+0x4a>
    return -1;

  return tcp_listen(f, backlog);
    800054e4:	fe442583          	lw	a1,-28(s0)
    800054e8:	fe843503          	ld	a0,-24(s0)
    800054ec:	00003097          	auipc	ra,0x3
    800054f0:	f10080e7          	jalr	-240(ra) # 800083fc <tcp_listen>
}
    800054f4:	60e2                	ld	ra,24(sp)
    800054f6:	6442                	ld	s0,16(sp)
    800054f8:	6105                	add	sp,sp,32
    800054fa:	8082                	ret
    return -1;
    800054fc:	557d                	li	a0,-1
    800054fe:	bfdd                	j	800054f4 <sys_listen+0x3e>
    80005500:	557d                	li	a0,-1
    80005502:	bfcd                	j	800054f4 <sys_listen+0x3e>

0000000080005504 <sys_accept>:

int
sys_accept(void)
{
    80005504:	715d                	add	sp,sp,-80
    80005506:	e486                	sd	ra,72(sp)
    80005508:	e0a2                	sd	s0,64(sp)
    8000550a:	0880                	add	s0,sp,80
  struct file *f;
  int fd;
  uint64 uaddr;
  uint64 addrlen;

  if (argfd(0, 0, &f) < 0 || argaddr(1, &uaddr) < 0 || argaddr(2, &addrlen) < 0)
    8000550c:	fd840613          	add	a2,s0,-40
    80005510:	4581                	li	a1,0
    80005512:	4501                	li	a0,0
    80005514:	fffff097          	auipc	ra,0xfffff
    80005518:	034080e7          	jalr	52(ra) # 80004548 <argfd>
    8000551c:	10054d63          	bltz	a0,80005636 <sys_accept+0x132>
    80005520:	fd040593          	add	a1,s0,-48
    80005524:	4505                	li	a0,1
    80005526:	ffffd097          	auipc	ra,0xffffd
    8000552a:	b50080e7          	jalr	-1200(ra) # 80002076 <argaddr>
    8000552e:	10054663          	bltz	a0,8000563a <sys_accept+0x136>
    80005532:	fc840593          	add	a1,s0,-56
    80005536:	4509                	li	a0,2
    80005538:	ffffd097          	auipc	ra,0xffffd
    8000553c:	b3e080e7          	jalr	-1218(ra) # 80002076 <argaddr>
    80005540:	0e054f63          	bltz	a0,8000563e <sys_accept+0x13a>
    80005544:	fc26                	sd	s1,56(sp)
    80005546:	f84a                	sd	s2,48(sp)
    return -1;

  struct tcp_sock *newts = tcp_accept(f);
    80005548:	fd843503          	ld	a0,-40(s0)
    8000554c:	00003097          	auipc	ra,0x3
    80005550:	f26080e7          	jalr	-218(ra) # 80008472 <tcp_accept>
    80005554:	892a                	mv	s2,a0

  if (uaddr && addrlen > 0) {
    80005556:	fd043783          	ld	a5,-48(s0)
    8000555a:	c781                	beqz	a5,80005562 <sys_accept+0x5e>
    8000555c:	fc843783          	ld	a5,-56(s0)
    80005560:	ef95                	bnez	a5,8000559c <sys_accept+0x98>
    copyout(myproc()->pagetable, uaddr, (char *)&ksa, sizeof(struct sockaddr));
    uint64 pa = walkaddr(myproc()->pagetable, addrlen);
    *(uint64 *)pa = sizeof(struct sockaddr);
  }

  if ((f = filealloc()) == 0) {
    80005562:	ffffe097          	auipc	ra,0xffffe
    80005566:	44e080e7          	jalr	1102(ra) # 800039b0 <filealloc>
    8000556a:	84aa                	mv	s1,a0
    8000556c:	fca43c23          	sd	a0,-40(s0)
    80005570:	c14d                	beqz	a0,80005612 <sys_accept+0x10e>
    fileclose(f);
    return -1;
  }

  f->type = FD_SOCK_TCP;
    80005572:	4795                	li	a5,5
    80005574:	c11c                	sw	a5,0(a0)
  f->readable = 1;
    80005576:	4785                	li	a5,1
    80005578:	00f50423          	sb	a5,8(a0)
  f->writable = 1;
    8000557c:	00f504a3          	sb	a5,9(a0)
  f->tcpsock = newts;
    80005580:	03253423          	sd	s2,40(a0)

  if((fd=fdalloc(f)) < 0){
    80005584:	fffff097          	auipc	ra,0xfffff
    80005588:	02e080e7          	jalr	46(ra) # 800045b2 <fdalloc>
    8000558c:	08054c63          	bltz	a0,80005624 <sys_accept+0x120>
    80005590:	74e2                	ld	s1,56(sp)
    80005592:	7942                	ld	s2,48(sp)
    fileclose(f);
    return -1;
  }

  return fd;
}
    80005594:	60a6                	ld	ra,72(sp)
    80005596:	6406                	ld	s0,64(sp)
    80005598:	6161                	add	sp,sp,80
    8000559a:	8082                	ret
    sin->sin_addr = htonl(newts->daddr);
    8000559c:	495c                	lw	a5,20(a0)
  return (((val & 0x000000ffUL) << 24) |
    8000559e:	0187971b          	sllw	a4,a5,0x18
          ((val & 0xff000000UL) >> 24));
    800055a2:	0187d69b          	srlw	a3,a5,0x18
          ((val & 0x00ff0000UL) >> 8) |
    800055a6:	8f55                	or	a4,a4,a3
          ((val & 0x0000ff00UL) << 8) |
    800055a8:	0087969b          	sllw	a3,a5,0x8
    800055ac:	00ff0637          	lui	a2,0xff0
    800055b0:	8ef1                	and	a3,a3,a2
          ((val & 0x00ff0000UL) >> 8) |
    800055b2:	8f55                	or	a4,a4,a3
    800055b4:	0087d79b          	srlw	a5,a5,0x8
    800055b8:	66c1                	lui	a3,0x10
    800055ba:	f0068693          	add	a3,a3,-256 # ff00 <_entry-0x7fff0100>
    800055be:	8ff5                	and	a5,a5,a3
    800055c0:	8fd9                	or	a5,a5,a4
    800055c2:	faf42e23          	sw	a5,-68(s0)
  return (((val & 0x00ffU) << 8) |
    800055c6:	01a55783          	lhu	a5,26(a0)
    800055ca:	0087971b          	sllw	a4,a5,0x8
    800055ce:	83a1                	srl	a5,a5,0x8
    800055d0:	8fd9                	or	a5,a5,a4
    sin->sin_port = htons(newts->dport);
    800055d2:	faf41d23          	sh	a5,-70(s0)
    sin->sin_family = AF_INET;
    800055d6:	fa041c23          	sh	zero,-72(s0)
    copyout(myproc()->pagetable, uaddr, (char *)&ksa, sizeof(struct sockaddr));
    800055da:	ffffc097          	auipc	ra,0xffffc
    800055de:	96c080e7          	jalr	-1684(ra) # 80000f46 <myproc>
    800055e2:	46c1                	li	a3,16
    800055e4:	fb840613          	add	a2,s0,-72
    800055e8:	fd043583          	ld	a1,-48(s0)
    800055ec:	6928                	ld	a0,80(a0)
    800055ee:	ffffb097          	auipc	ra,0xffffb
    800055f2:	5d4080e7          	jalr	1492(ra) # 80000bc2 <copyout>
    uint64 pa = walkaddr(myproc()->pagetable, addrlen);
    800055f6:	ffffc097          	auipc	ra,0xffffc
    800055fa:	950080e7          	jalr	-1712(ra) # 80000f46 <myproc>
    800055fe:	fc843583          	ld	a1,-56(s0)
    80005602:	6928                	ld	a0,80(a0)
    80005604:	ffffb097          	auipc	ra,0xffffb
    80005608:	f6c080e7          	jalr	-148(ra) # 80000570 <walkaddr>
    *(uint64 *)pa = sizeof(struct sockaddr);
    8000560c:	47c1                	li	a5,16
    8000560e:	e11c                	sd	a5,0(a0)
    80005610:	bf89                	j	80005562 <sys_accept+0x5e>
    fileclose(f);
    80005612:	4501                	li	a0,0
    80005614:	ffffe097          	auipc	ra,0xffffe
    80005618:	458080e7          	jalr	1112(ra) # 80003a6c <fileclose>
    return -1;
    8000561c:	557d                	li	a0,-1
    8000561e:	74e2                	ld	s1,56(sp)
    80005620:	7942                	ld	s2,48(sp)
    80005622:	bf8d                	j	80005594 <sys_accept+0x90>
    fileclose(f);
    80005624:	8526                	mv	a0,s1
    80005626:	ffffe097          	auipc	ra,0xffffe
    8000562a:	446080e7          	jalr	1094(ra) # 80003a6c <fileclose>
    return -1;
    8000562e:	557d                	li	a0,-1
    80005630:	74e2                	ld	s1,56(sp)
    80005632:	7942                	ld	s2,48(sp)
    80005634:	b785                	j	80005594 <sys_accept+0x90>
    return -1;
    80005636:	557d                	li	a0,-1
    80005638:	bfb1                	j	80005594 <sys_accept+0x90>
    8000563a:	557d                	li	a0,-1
    8000563c:	bfa1                	j	80005594 <sys_accept+0x90>
    8000563e:	557d                	li	a0,-1
    80005640:	bf91                	j	80005594 <sys_accept+0x90>
	...

0000000080005650 <kernelvec>:
    80005650:	7111                	add	sp,sp,-256
    80005652:	e006                	sd	ra,0(sp)
    80005654:	e40a                	sd	sp,8(sp)
    80005656:	e80e                	sd	gp,16(sp)
    80005658:	ec12                	sd	tp,24(sp)
    8000565a:	f016                	sd	t0,32(sp)
    8000565c:	f41a                	sd	t1,40(sp)
    8000565e:	f81e                	sd	t2,48(sp)
    80005660:	fc22                	sd	s0,56(sp)
    80005662:	e0a6                	sd	s1,64(sp)
    80005664:	e4aa                	sd	a0,72(sp)
    80005666:	e8ae                	sd	a1,80(sp)
    80005668:	ecb2                	sd	a2,88(sp)
    8000566a:	f0b6                	sd	a3,96(sp)
    8000566c:	f4ba                	sd	a4,104(sp)
    8000566e:	f8be                	sd	a5,112(sp)
    80005670:	fcc2                	sd	a6,120(sp)
    80005672:	e146                	sd	a7,128(sp)
    80005674:	e54a                	sd	s2,136(sp)
    80005676:	e94e                	sd	s3,144(sp)
    80005678:	ed52                	sd	s4,152(sp)
    8000567a:	f156                	sd	s5,160(sp)
    8000567c:	f55a                	sd	s6,168(sp)
    8000567e:	f95e                	sd	s7,176(sp)
    80005680:	fd62                	sd	s8,184(sp)
    80005682:	e1e6                	sd	s9,192(sp)
    80005684:	e5ea                	sd	s10,200(sp)
    80005686:	e9ee                	sd	s11,208(sp)
    80005688:	edf2                	sd	t3,216(sp)
    8000568a:	f1f6                	sd	t4,224(sp)
    8000568c:	f5fa                	sd	t5,232(sp)
    8000568e:	f9fe                	sd	t6,240(sp)
    80005690:	ff6fc0ef          	jal	80001e86 <kerneltrap>
    80005694:	6082                	ld	ra,0(sp)
    80005696:	6122                	ld	sp,8(sp)
    80005698:	61c2                	ld	gp,16(sp)
    8000569a:	7282                	ld	t0,32(sp)
    8000569c:	7322                	ld	t1,40(sp)
    8000569e:	73c2                	ld	t2,48(sp)
    800056a0:	7462                	ld	s0,56(sp)
    800056a2:	6486                	ld	s1,64(sp)
    800056a4:	6526                	ld	a0,72(sp)
    800056a6:	65c6                	ld	a1,80(sp)
    800056a8:	6666                	ld	a2,88(sp)
    800056aa:	7686                	ld	a3,96(sp)
    800056ac:	7726                	ld	a4,104(sp)
    800056ae:	77c6                	ld	a5,112(sp)
    800056b0:	7866                	ld	a6,120(sp)
    800056b2:	688a                	ld	a7,128(sp)
    800056b4:	692a                	ld	s2,136(sp)
    800056b6:	69ca                	ld	s3,144(sp)
    800056b8:	6a6a                	ld	s4,152(sp)
    800056ba:	7a8a                	ld	s5,160(sp)
    800056bc:	7b2a                	ld	s6,168(sp)
    800056be:	7bca                	ld	s7,176(sp)
    800056c0:	7c6a                	ld	s8,184(sp)
    800056c2:	6c8e                	ld	s9,192(sp)
    800056c4:	6d2e                	ld	s10,200(sp)
    800056c6:	6dce                	ld	s11,208(sp)
    800056c8:	6e6e                	ld	t3,216(sp)
    800056ca:	7e8e                	ld	t4,224(sp)
    800056cc:	7f2e                	ld	t5,232(sp)
    800056ce:	7fce                	ld	t6,240(sp)
    800056d0:	6111                	add	sp,sp,256
    800056d2:	10200073          	sret
    800056d6:	00000013          	nop
    800056da:	00000013          	nop
    800056de:	0001                	nop

00000000800056e0 <timervec>:
    800056e0:	34051573          	csrrw	a0,mscratch,a0
    800056e4:	e10c                	sd	a1,0(a0)
    800056e6:	e510                	sd	a2,8(a0)
    800056e8:	e914                	sd	a3,16(a0)
    800056ea:	6d0c                	ld	a1,24(a0)
    800056ec:	7110                	ld	a2,32(a0)
    800056ee:	6194                	ld	a3,0(a1)
    800056f0:	96b2                	add	a3,a3,a2
    800056f2:	e194                	sd	a3,0(a1)
    800056f4:	4589                	li	a1,2
    800056f6:	14459073          	csrw	sip,a1
    800056fa:	6914                	ld	a3,16(a0)
    800056fc:	6510                	ld	a2,8(a0)
    800056fe:	610c                	ld	a1,0(a0)
    80005700:	34051573          	csrrw	a0,mscratch,a0
    80005704:	30200073          	mret
	...

000000008000570a <plicinit>:
// the riscv Platform Level Interrupt Controller (PLIC).
//

void
plicinit(void)
{
    8000570a:	1141                	add	sp,sp,-16
    8000570c:	e422                	sd	s0,8(sp)
    8000570e:	0800                	add	s0,sp,16
  // set desired IRQ priorities non-zero (otherwise disabled).
  *(uint32*)(PLIC + UART0_IRQ*4) = 1;
    80005710:	0c0007b7          	lui	a5,0xc000
    80005714:	4705                	li	a4,1
    80005716:	d798                	sw	a4,40(a5)
  *(uint32*)(PLIC + VIRTIO0_IRQ*4) = 1;
    80005718:	0c0007b7          	lui	a5,0xc000
    8000571c:	c3d8                	sw	a4,4(a5)
    8000571e:	0791                	add	a5,a5,4 # c000004 <_entry-0x73fffffc>
  
  // PCIE IRQs are 32 to 35
  for(int irq = 1; irq < 0x35; irq++){
    *(uint32*)(PLIC + irq*4) = 1;
    80005720:	4685                	li	a3,1
  for(int irq = 1; irq < 0x35; irq++){
    80005722:	0c000737          	lui	a4,0xc000
    80005726:	0d470713          	add	a4,a4,212 # c0000d4 <_entry-0x73ffff2c>
    *(uint32*)(PLIC + irq*4) = 1;
    8000572a:	c394                	sw	a3,0(a5)
  for(int irq = 1; irq < 0x35; irq++){
    8000572c:	0791                	add	a5,a5,4
    8000572e:	fee79ee3          	bne	a5,a4,8000572a <plicinit+0x20>
  }
}
    80005732:	6422                	ld	s0,8(sp)
    80005734:	0141                	add	sp,sp,16
    80005736:	8082                	ret

0000000080005738 <plicinithart>:

void
plicinithart(void)
{
    80005738:	1141                	add	sp,sp,-16
    8000573a:	e406                	sd	ra,8(sp)
    8000573c:	e022                	sd	s0,0(sp)
    8000573e:	0800                	add	s0,sp,16
  int hart = cpuid();
    80005740:	ffffb097          	auipc	ra,0xffffb
    80005744:	7da080e7          	jalr	2010(ra) # 80000f1a <cpuid>
  
  // set uart's enable bit for this hart's S-mode. 
  *(uint32*)PLIC_SENABLE(hart)= (1 << UART0_IRQ) | (1 << VIRTIO0_IRQ);
    80005748:	0085171b          	sllw	a4,a0,0x8
    8000574c:	0c0027b7          	lui	a5,0xc002
    80005750:	97ba                	add	a5,a5,a4
    80005752:	40200713          	li	a4,1026
    80005756:	08e7a023          	sw	a4,128(a5) # c002080 <_entry-0x73ffdf80>

  // hack to get at next 32 IRQs for e1000
  *(uint32*)(PLIC_SENABLE(hart)+4) = 0xffffffff;
    8000575a:	577d                	li	a4,-1
    8000575c:	08e7a223          	sw	a4,132(a5)
  
  // set this hart's S-mode priority threshold to 0.
  *(uint32*)PLIC_SPRIORITY(hart) = 0;
    80005760:	00d5151b          	sllw	a0,a0,0xd
    80005764:	0c2017b7          	lui	a5,0xc201
    80005768:	97aa                	add	a5,a5,a0
    8000576a:	0007a023          	sw	zero,0(a5) # c201000 <_entry-0x73dff000>
}
    8000576e:	60a2                	ld	ra,8(sp)
    80005770:	6402                	ld	s0,0(sp)
    80005772:	0141                	add	sp,sp,16
    80005774:	8082                	ret

0000000080005776 <plic_claim>:

// ask the PLIC what interrupt we should serve.
int
plic_claim(void)
{
    80005776:	1141                	add	sp,sp,-16
    80005778:	e406                	sd	ra,8(sp)
    8000577a:	e022                	sd	s0,0(sp)
    8000577c:	0800                	add	s0,sp,16
  int hart = cpuid();
    8000577e:	ffffb097          	auipc	ra,0xffffb
    80005782:	79c080e7          	jalr	1948(ra) # 80000f1a <cpuid>
  int irq = *(uint32*)PLIC_SCLAIM(hart);
    80005786:	00d5151b          	sllw	a0,a0,0xd
    8000578a:	0c2017b7          	lui	a5,0xc201
    8000578e:	97aa                	add	a5,a5,a0
  return irq;
}
    80005790:	43c8                	lw	a0,4(a5)
    80005792:	60a2                	ld	ra,8(sp)
    80005794:	6402                	ld	s0,0(sp)
    80005796:	0141                	add	sp,sp,16
    80005798:	8082                	ret

000000008000579a <plic_complete>:

// tell the PLIC we've served this IRQ.
void
plic_complete(int irq)
{
    8000579a:	1101                	add	sp,sp,-32
    8000579c:	ec06                	sd	ra,24(sp)
    8000579e:	e822                	sd	s0,16(sp)
    800057a0:	e426                	sd	s1,8(sp)
    800057a2:	1000                	add	s0,sp,32
    800057a4:	84aa                	mv	s1,a0
  int hart = cpuid();
    800057a6:	ffffb097          	auipc	ra,0xffffb
    800057aa:	774080e7          	jalr	1908(ra) # 80000f1a <cpuid>
  *(uint32*)PLIC_SCLAIM(hart) = irq;
    800057ae:	00d5151b          	sllw	a0,a0,0xd
    800057b2:	0c2017b7          	lui	a5,0xc201
    800057b6:	97aa                	add	a5,a5,a0
    800057b8:	c3c4                	sw	s1,4(a5)
}
    800057ba:	60e2                	ld	ra,24(sp)
    800057bc:	6442                	ld	s0,16(sp)
    800057be:	64a2                	ld	s1,8(sp)
    800057c0:	6105                	add	sp,sp,32
    800057c2:	8082                	ret

00000000800057c4 <free_desc>:
}

// mark a descriptor as free.
static void
free_desc(int i)
{
    800057c4:	1141                	add	sp,sp,-16
    800057c6:	e406                	sd	ra,8(sp)
    800057c8:	e022                	sd	s0,0(sp)
    800057ca:	0800                	add	s0,sp,16
  if(i >= NUM)
    800057cc:	479d                	li	a5,7
    800057ce:	06a7c863          	blt	a5,a0,8000583e <free_desc+0x7a>
    panic("free_desc 1");
  if(disk.free[i])
    800057d2:	00037717          	auipc	a4,0x37
    800057d6:	82e70713          	add	a4,a4,-2002 # 8003c000 <disk>
    800057da:	972a                	add	a4,a4,a0
    800057dc:	6789                	lui	a5,0x2
    800057de:	97ba                	add	a5,a5,a4
    800057e0:	0187c783          	lbu	a5,24(a5) # 2018 <_entry-0x7fffdfe8>
    800057e4:	e7ad                	bnez	a5,8000584e <free_desc+0x8a>
    panic("free_desc 2");
  disk.desc[i].addr = 0;
    800057e6:	00451793          	sll	a5,a0,0x4
    800057ea:	00039717          	auipc	a4,0x39
    800057ee:	81670713          	add	a4,a4,-2026 # 8003e000 <disk+0x2000>
    800057f2:	6314                	ld	a3,0(a4)
    800057f4:	96be                	add	a3,a3,a5
    800057f6:	0006b023          	sd	zero,0(a3)
  disk.desc[i].len = 0;
    800057fa:	6314                	ld	a3,0(a4)
    800057fc:	96be                	add	a3,a3,a5
    800057fe:	0006a423          	sw	zero,8(a3)
  disk.desc[i].flags = 0;
    80005802:	6314                	ld	a3,0(a4)
    80005804:	96be                	add	a3,a3,a5
    80005806:	00069623          	sh	zero,12(a3)
  disk.desc[i].next = 0;
    8000580a:	6318                	ld	a4,0(a4)
    8000580c:	97ba                	add	a5,a5,a4
    8000580e:	00079723          	sh	zero,14(a5)
  disk.free[i] = 1;
    80005812:	00036717          	auipc	a4,0x36
    80005816:	7ee70713          	add	a4,a4,2030 # 8003c000 <disk>
    8000581a:	972a                	add	a4,a4,a0
    8000581c:	6789                	lui	a5,0x2
    8000581e:	97ba                	add	a5,a5,a4
    80005820:	4705                	li	a4,1
    80005822:	00e78c23          	sb	a4,24(a5) # 2018 <_entry-0x7fffdfe8>
  wakeup(&disk.free[0]);
    80005826:	00038517          	auipc	a0,0x38
    8000582a:	7f250513          	add	a0,a0,2034 # 8003e018 <disk+0x2018>
    8000582e:	ffffc097          	auipc	ra,0xffffc
    80005832:	0b0080e7          	jalr	176(ra) # 800018de <wakeup>
}
    80005836:	60a2                	ld	ra,8(sp)
    80005838:	6402                	ld	s0,0(sp)
    8000583a:	0141                	add	sp,sp,16
    8000583c:	8082                	ret
    panic("free_desc 1");
    8000583e:	00006517          	auipc	a0,0x6
    80005842:	dc250513          	add	a0,a0,-574 # 8000b600 <etext+0x600>
    80005846:	00004097          	auipc	ra,0x4
    8000584a:	a92080e7          	jalr	-1390(ra) # 800092d8 <panic>
    panic("free_desc 2");
    8000584e:	00006517          	auipc	a0,0x6
    80005852:	dc250513          	add	a0,a0,-574 # 8000b610 <etext+0x610>
    80005856:	00004097          	auipc	ra,0x4
    8000585a:	a82080e7          	jalr	-1406(ra) # 800092d8 <panic>

000000008000585e <virtio_disk_init>:
{
    8000585e:	1141                	add	sp,sp,-16
    80005860:	e406                	sd	ra,8(sp)
    80005862:	e022                	sd	s0,0(sp)
    80005864:	0800                	add	s0,sp,16
  initlock(&disk.vdisk_lock, "virtio_disk");
    80005866:	00006597          	auipc	a1,0x6
    8000586a:	dba58593          	add	a1,a1,-582 # 8000b620 <etext+0x620>
    8000586e:	00039517          	auipc	a0,0x39
    80005872:	8ba50513          	add	a0,a0,-1862 # 8003e128 <disk+0x2128>
    80005876:	00004097          	auipc	ra,0x4
    8000587a:	f6c080e7          	jalr	-148(ra) # 800097e2 <initlock>
  if(*R(VIRTIO_MMIO_MAGIC_VALUE) != 0x74726976 ||
    8000587e:	100017b7          	lui	a5,0x10001
    80005882:	4398                	lw	a4,0(a5)
    80005884:	2701                	sext.w	a4,a4
    80005886:	747277b7          	lui	a5,0x74727
    8000588a:	97678793          	add	a5,a5,-1674 # 74726976 <_entry-0xb8d968a>
    8000588e:	0ef71f63          	bne	a4,a5,8000598c <virtio_disk_init+0x12e>
     *R(VIRTIO_MMIO_VERSION) != 1 ||
    80005892:	100017b7          	lui	a5,0x10001
    80005896:	0791                	add	a5,a5,4 # 10001004 <_entry-0x6fffeffc>
    80005898:	439c                	lw	a5,0(a5)
    8000589a:	2781                	sext.w	a5,a5
  if(*R(VIRTIO_MMIO_MAGIC_VALUE) != 0x74726976 ||
    8000589c:	4705                	li	a4,1
    8000589e:	0ee79763          	bne	a5,a4,8000598c <virtio_disk_init+0x12e>
     *R(VIRTIO_MMIO_DEVICE_ID) != 2 ||
    800058a2:	100017b7          	lui	a5,0x10001
    800058a6:	07a1                	add	a5,a5,8 # 10001008 <_entry-0x6fffeff8>
    800058a8:	439c                	lw	a5,0(a5)
    800058aa:	2781                	sext.w	a5,a5
     *R(VIRTIO_MMIO_VERSION) != 1 ||
    800058ac:	4709                	li	a4,2
    800058ae:	0ce79f63          	bne	a5,a4,8000598c <virtio_disk_init+0x12e>
     *R(VIRTIO_MMIO_VENDOR_ID) != 0x554d4551){
    800058b2:	100017b7          	lui	a5,0x10001
    800058b6:	47d8                	lw	a4,12(a5)
    800058b8:	2701                	sext.w	a4,a4
     *R(VIRTIO_MMIO_DEVICE_ID) != 2 ||
    800058ba:	554d47b7          	lui	a5,0x554d4
    800058be:	55178793          	add	a5,a5,1361 # 554d4551 <_entry-0x2ab2baaf>
    800058c2:	0cf71563          	bne	a4,a5,8000598c <virtio_disk_init+0x12e>
  *R(VIRTIO_MMIO_STATUS) = status;
    800058c6:	100017b7          	lui	a5,0x10001
    800058ca:	4705                	li	a4,1
    800058cc:	dbb8                	sw	a4,112(a5)
  *R(VIRTIO_MMIO_STATUS) = status;
    800058ce:	470d                	li	a4,3
    800058d0:	dbb8                	sw	a4,112(a5)
  uint64 features = *R(VIRTIO_MMIO_DEVICE_FEATURES);
    800058d2:	10001737          	lui	a4,0x10001
    800058d6:	4b14                	lw	a3,16(a4)
  features &= ~(1 << VIRTIO_RING_F_INDIRECT_DESC);
    800058d8:	c7ffe737          	lui	a4,0xc7ffe
    800058dc:	75f70713          	add	a4,a4,1887 # ffffffffc7ffe75f <end+0xffffffff47fb718f>
  *R(VIRTIO_MMIO_DRIVER_FEATURES) = features;
    800058e0:	8ef9                	and	a3,a3,a4
    800058e2:	10001737          	lui	a4,0x10001
    800058e6:	d314                	sw	a3,32(a4)
  *R(VIRTIO_MMIO_STATUS) = status;
    800058e8:	472d                	li	a4,11
    800058ea:	dbb8                	sw	a4,112(a5)
  *R(VIRTIO_MMIO_STATUS) = status;
    800058ec:	473d                	li	a4,15
    800058ee:	dbb8                	sw	a4,112(a5)
  *R(VIRTIO_MMIO_GUEST_PAGE_SIZE) = PGSIZE;
    800058f0:	100017b7          	lui	a5,0x10001
    800058f4:	6705                	lui	a4,0x1
    800058f6:	d798                	sw	a4,40(a5)
  *R(VIRTIO_MMIO_QUEUE_SEL) = 0;
    800058f8:	100017b7          	lui	a5,0x10001
    800058fc:	0207a823          	sw	zero,48(a5) # 10001030 <_entry-0x6fffefd0>
  uint32 max = *R(VIRTIO_MMIO_QUEUE_NUM_MAX);
    80005900:	100017b7          	lui	a5,0x10001
    80005904:	03478793          	add	a5,a5,52 # 10001034 <_entry-0x6fffefcc>
    80005908:	439c                	lw	a5,0(a5)
    8000590a:	2781                	sext.w	a5,a5
  if(max == 0)
    8000590c:	cbc1                	beqz	a5,8000599c <virtio_disk_init+0x13e>
  if(max < NUM)
    8000590e:	471d                	li	a4,7
    80005910:	08f77e63          	bgeu	a4,a5,800059ac <virtio_disk_init+0x14e>
  *R(VIRTIO_MMIO_QUEUE_NUM) = NUM;
    80005914:	100017b7          	lui	a5,0x10001
    80005918:	4721                	li	a4,8
    8000591a:	df98                	sw	a4,56(a5)
  memset(disk.pages, 0, sizeof(disk.pages));
    8000591c:	6609                	lui	a2,0x2
    8000591e:	4581                	li	a1,0
    80005920:	00036517          	auipc	a0,0x36
    80005924:	6e050513          	add	a0,a0,1760 # 8003c000 <disk>
    80005928:	ffffb097          	auipc	ra,0xffffb
    8000592c:	852080e7          	jalr	-1966(ra) # 8000017a <memset>
  *R(VIRTIO_MMIO_QUEUE_PFN) = ((uint64)disk.pages) >> PGSHIFT;
    80005930:	00036697          	auipc	a3,0x36
    80005934:	6d068693          	add	a3,a3,1744 # 8003c000 <disk>
    80005938:	00c6d713          	srl	a4,a3,0xc
    8000593c:	2701                	sext.w	a4,a4
    8000593e:	100017b7          	lui	a5,0x10001
    80005942:	c3b8                	sw	a4,64(a5)
  disk.desc = (struct virtq_desc *) disk.pages;
    80005944:	00038797          	auipc	a5,0x38
    80005948:	6bc78793          	add	a5,a5,1724 # 8003e000 <disk+0x2000>
    8000594c:	e394                	sd	a3,0(a5)
  disk.avail = (struct virtq_avail *)(disk.pages + NUM*sizeof(struct virtq_desc));
    8000594e:	00036717          	auipc	a4,0x36
    80005952:	73270713          	add	a4,a4,1842 # 8003c080 <disk+0x80>
    80005956:	e798                	sd	a4,8(a5)
  disk.used = (struct virtq_used *) (disk.pages + PGSIZE);
    80005958:	00037717          	auipc	a4,0x37
    8000595c:	6a870713          	add	a4,a4,1704 # 8003d000 <disk+0x1000>
    80005960:	eb98                	sd	a4,16(a5)
    disk.free[i] = 1;
    80005962:	4705                	li	a4,1
    80005964:	00e78c23          	sb	a4,24(a5)
    80005968:	00e78ca3          	sb	a4,25(a5)
    8000596c:	00e78d23          	sb	a4,26(a5)
    80005970:	00e78da3          	sb	a4,27(a5)
    80005974:	00e78e23          	sb	a4,28(a5)
    80005978:	00e78ea3          	sb	a4,29(a5)
    8000597c:	00e78f23          	sb	a4,30(a5)
    80005980:	00e78fa3          	sb	a4,31(a5)
}
    80005984:	60a2                	ld	ra,8(sp)
    80005986:	6402                	ld	s0,0(sp)
    80005988:	0141                	add	sp,sp,16
    8000598a:	8082                	ret
    panic("could not find virtio disk");
    8000598c:	00006517          	auipc	a0,0x6
    80005990:	ca450513          	add	a0,a0,-860 # 8000b630 <etext+0x630>
    80005994:	00004097          	auipc	ra,0x4
    80005998:	944080e7          	jalr	-1724(ra) # 800092d8 <panic>
    panic("virtio disk has no queue 0");
    8000599c:	00006517          	auipc	a0,0x6
    800059a0:	cb450513          	add	a0,a0,-844 # 8000b650 <etext+0x650>
    800059a4:	00004097          	auipc	ra,0x4
    800059a8:	934080e7          	jalr	-1740(ra) # 800092d8 <panic>
    panic("virtio disk max queue too short");
    800059ac:	00006517          	auipc	a0,0x6
    800059b0:	cc450513          	add	a0,a0,-828 # 8000b670 <etext+0x670>
    800059b4:	00004097          	auipc	ra,0x4
    800059b8:	924080e7          	jalr	-1756(ra) # 800092d8 <panic>

00000000800059bc <virtio_disk_rw>:
  return 0;
}

void
virtio_disk_rw(struct buf *b, int write)
{
    800059bc:	7159                	add	sp,sp,-112
    800059be:	f486                	sd	ra,104(sp)
    800059c0:	f0a2                	sd	s0,96(sp)
    800059c2:	eca6                	sd	s1,88(sp)
    800059c4:	e8ca                	sd	s2,80(sp)
    800059c6:	e4ce                	sd	s3,72(sp)
    800059c8:	e0d2                	sd	s4,64(sp)
    800059ca:	fc56                	sd	s5,56(sp)
    800059cc:	f85a                	sd	s6,48(sp)
    800059ce:	f45e                	sd	s7,40(sp)
    800059d0:	f062                	sd	s8,32(sp)
    800059d2:	ec66                	sd	s9,24(sp)
    800059d4:	1880                	add	s0,sp,112
    800059d6:	8a2a                	mv	s4,a0
    800059d8:	8cae                	mv	s9,a1
  uint64 sector = b->blockno * (BSIZE / 512);
    800059da:	00c52c03          	lw	s8,12(a0)
    800059de:	001c1c1b          	sllw	s8,s8,0x1
    800059e2:	1c02                	sll	s8,s8,0x20
    800059e4:	020c5c13          	srl	s8,s8,0x20

  acquire(&disk.vdisk_lock);
    800059e8:	00038517          	auipc	a0,0x38
    800059ec:	74050513          	add	a0,a0,1856 # 8003e128 <disk+0x2128>
    800059f0:	00004097          	auipc	ra,0x4
    800059f4:	e82080e7          	jalr	-382(ra) # 80009872 <acquire>
  for(int i = 0; i < 3; i++){
    800059f8:	4981                	li	s3,0
  for(int i = 0; i < NUM; i++){
    800059fa:	44a1                	li	s1,8
      disk.free[i] = 0;
    800059fc:	00036b97          	auipc	s7,0x36
    80005a00:	604b8b93          	add	s7,s7,1540 # 8003c000 <disk>
    80005a04:	6b09                	lui	s6,0x2
  for(int i = 0; i < 3; i++){
    80005a06:	4a8d                	li	s5,3
    80005a08:	a88d                	j	80005a7a <virtio_disk_rw+0xbe>
      disk.free[i] = 0;
    80005a0a:	00fb8733          	add	a4,s7,a5
    80005a0e:	975a                	add	a4,a4,s6
    80005a10:	00070c23          	sb	zero,24(a4)
    idx[i] = alloc_desc();
    80005a14:	c19c                	sw	a5,0(a1)
    if(idx[i] < 0){
    80005a16:	0207c563          	bltz	a5,80005a40 <virtio_disk_rw+0x84>
  for(int i = 0; i < 3; i++){
    80005a1a:	2905                	addw	s2,s2,1
    80005a1c:	0611                	add	a2,a2,4 # 2004 <_entry-0x7fffdffc>
    80005a1e:	1b590163          	beq	s2,s5,80005bc0 <virtio_disk_rw+0x204>
    idx[i] = alloc_desc();
    80005a22:	85b2                	mv	a1,a2
  for(int i = 0; i < NUM; i++){
    80005a24:	00038717          	auipc	a4,0x38
    80005a28:	5f470713          	add	a4,a4,1524 # 8003e018 <disk+0x2018>
    80005a2c:	87ce                	mv	a5,s3
    if(disk.free[i]){
    80005a2e:	00074683          	lbu	a3,0(a4)
    80005a32:	fee1                	bnez	a3,80005a0a <virtio_disk_rw+0x4e>
  for(int i = 0; i < NUM; i++){
    80005a34:	2785                	addw	a5,a5,1
    80005a36:	0705                	add	a4,a4,1
    80005a38:	fe979be3          	bne	a5,s1,80005a2e <virtio_disk_rw+0x72>
    idx[i] = alloc_desc();
    80005a3c:	57fd                	li	a5,-1
    80005a3e:	c19c                	sw	a5,0(a1)
      for(int j = 0; j < i; j++)
    80005a40:	03205163          	blez	s2,80005a62 <virtio_disk_rw+0xa6>
        free_desc(idx[j]);
    80005a44:	f9042503          	lw	a0,-112(s0)
    80005a48:	00000097          	auipc	ra,0x0
    80005a4c:	d7c080e7          	jalr	-644(ra) # 800057c4 <free_desc>
      for(int j = 0; j < i; j++)
    80005a50:	4785                	li	a5,1
    80005a52:	0127d863          	bge	a5,s2,80005a62 <virtio_disk_rw+0xa6>
        free_desc(idx[j]);
    80005a56:	f9442503          	lw	a0,-108(s0)
    80005a5a:	00000097          	auipc	ra,0x0
    80005a5e:	d6a080e7          	jalr	-662(ra) # 800057c4 <free_desc>
  int idx[3];
  while(1){
    if(alloc3_desc(idx) == 0) {
      break;
    }
    sleep(&disk.free[0], &disk.vdisk_lock);
    80005a62:	00038597          	auipc	a1,0x38
    80005a66:	6c658593          	add	a1,a1,1734 # 8003e128 <disk+0x2128>
    80005a6a:	00038517          	auipc	a0,0x38
    80005a6e:	5ae50513          	add	a0,a0,1454 # 8003e018 <disk+0x2018>
    80005a72:	ffffc097          	auipc	ra,0xffffc
    80005a76:	cec080e7          	jalr	-788(ra) # 8000175e <sleep>
  for(int i = 0; i < 3; i++){
    80005a7a:	f9040613          	add	a2,s0,-112
    80005a7e:	894e                	mv	s2,s3
    80005a80:	b74d                	j	80005a22 <virtio_disk_rw+0x66>
  disk.desc[idx[0]].next = idx[1];

  disk.desc[idx[1]].addr = (uint64) b->data;
  disk.desc[idx[1]].len = BSIZE;
  if(write)
    disk.desc[idx[1]].flags = 0; // device reads b->data
    80005a82:	00038717          	auipc	a4,0x38
    80005a86:	57e73703          	ld	a4,1406(a4) # 8003e000 <disk+0x2000>
    80005a8a:	973e                	add	a4,a4,a5
    80005a8c:	00071623          	sh	zero,12(a4)
  else
    disk.desc[idx[1]].flags = VRING_DESC_F_WRITE; // device writes b->data
  disk.desc[idx[1]].flags |= VRING_DESC_F_NEXT;
    80005a90:	00036897          	auipc	a7,0x36
    80005a94:	57088893          	add	a7,a7,1392 # 8003c000 <disk>
    80005a98:	00038717          	auipc	a4,0x38
    80005a9c:	56870713          	add	a4,a4,1384 # 8003e000 <disk+0x2000>
    80005aa0:	6314                	ld	a3,0(a4)
    80005aa2:	96be                	add	a3,a3,a5
    80005aa4:	00c6d583          	lhu	a1,12(a3)
    80005aa8:	0015e593          	or	a1,a1,1
    80005aac:	00b69623          	sh	a1,12(a3)
  disk.desc[idx[1]].next = idx[2];
    80005ab0:	f9842683          	lw	a3,-104(s0)
    80005ab4:	630c                	ld	a1,0(a4)
    80005ab6:	97ae                	add	a5,a5,a1
    80005ab8:	00d79723          	sh	a3,14(a5)

  disk.info[idx[0]].status = 0xff; // device writes 0 on success
    80005abc:	20050593          	add	a1,a0,512
    80005ac0:	0592                	sll	a1,a1,0x4
    80005ac2:	95c6                	add	a1,a1,a7
    80005ac4:	57fd                	li	a5,-1
    80005ac6:	02f58823          	sb	a5,48(a1)
  disk.desc[idx[2]].addr = (uint64) &disk.info[idx[0]].status;
    80005aca:	00469793          	sll	a5,a3,0x4
    80005ace:	00073803          	ld	a6,0(a4)
    80005ad2:	983e                	add	a6,a6,a5
    80005ad4:	6689                	lui	a3,0x2
    80005ad6:	03068693          	add	a3,a3,48 # 2030 <_entry-0x7fffdfd0>
    80005ada:	96b2                	add	a3,a3,a2
    80005adc:	96c6                	add	a3,a3,a7
    80005ade:	00d83023          	sd	a3,0(a6)
  disk.desc[idx[2]].len = 1;
    80005ae2:	6314                	ld	a3,0(a4)
    80005ae4:	96be                	add	a3,a3,a5
    80005ae6:	4605                	li	a2,1
    80005ae8:	c690                	sw	a2,8(a3)
  disk.desc[idx[2]].flags = VRING_DESC_F_WRITE; // device writes the status
    80005aea:	6314                	ld	a3,0(a4)
    80005aec:	96be                	add	a3,a3,a5
    80005aee:	4809                	li	a6,2
    80005af0:	01069623          	sh	a6,12(a3)
  disk.desc[idx[2]].next = 0;
    80005af4:	6314                	ld	a3,0(a4)
    80005af6:	97b6                	add	a5,a5,a3
    80005af8:	00079723          	sh	zero,14(a5)

  // record struct buf for virtio_disk_intr().
  b->disk = 1;
    80005afc:	00ca2223          	sw	a2,4(s4)
  disk.info[idx[0]].b = b;
    80005b00:	0345b423          	sd	s4,40(a1)

  // tell the device the first index in our chain of descriptors.
  disk.avail->ring[disk.avail->idx % NUM] = idx[0];
    80005b04:	6714                	ld	a3,8(a4)
    80005b06:	0026d783          	lhu	a5,2(a3)
    80005b0a:	8b9d                	and	a5,a5,7
    80005b0c:	0786                	sll	a5,a5,0x1
    80005b0e:	96be                	add	a3,a3,a5
    80005b10:	00a69223          	sh	a0,4(a3)

  __sync_synchronize();
    80005b14:	0ff0000f          	fence

  // tell the device another avail ring entry is available.
  disk.avail->idx += 1; // not % NUM ...
    80005b18:	6718                	ld	a4,8(a4)
    80005b1a:	00275783          	lhu	a5,2(a4)
    80005b1e:	2785                	addw	a5,a5,1
    80005b20:	00f71123          	sh	a5,2(a4)

  __sync_synchronize();
    80005b24:	0ff0000f          	fence

  *R(VIRTIO_MMIO_QUEUE_NOTIFY) = 0; // value is queue number
    80005b28:	100017b7          	lui	a5,0x10001
    80005b2c:	0407a823          	sw	zero,80(a5) # 10001050 <_entry-0x6fffefb0>

  // Wait for virtio_disk_intr() to say request has finished.
  while(b->disk == 1) {
    80005b30:	004a2783          	lw	a5,4(s4)
    80005b34:	02c79163          	bne	a5,a2,80005b56 <virtio_disk_rw+0x19a>
    sleep(b, &disk.vdisk_lock);
    80005b38:	00038917          	auipc	s2,0x38
    80005b3c:	5f090913          	add	s2,s2,1520 # 8003e128 <disk+0x2128>
  while(b->disk == 1) {
    80005b40:	4485                	li	s1,1
    sleep(b, &disk.vdisk_lock);
    80005b42:	85ca                	mv	a1,s2
    80005b44:	8552                	mv	a0,s4
    80005b46:	ffffc097          	auipc	ra,0xffffc
    80005b4a:	c18080e7          	jalr	-1000(ra) # 8000175e <sleep>
  while(b->disk == 1) {
    80005b4e:	004a2783          	lw	a5,4(s4)
    80005b52:	fe9788e3          	beq	a5,s1,80005b42 <virtio_disk_rw+0x186>
  }

  disk.info[idx[0]].b = 0;
    80005b56:	f9042903          	lw	s2,-112(s0)
    80005b5a:	20090713          	add	a4,s2,512
    80005b5e:	0712                	sll	a4,a4,0x4
    80005b60:	00036797          	auipc	a5,0x36
    80005b64:	4a078793          	add	a5,a5,1184 # 8003c000 <disk>
    80005b68:	97ba                	add	a5,a5,a4
    80005b6a:	0207b423          	sd	zero,40(a5)
    int flag = disk.desc[i].flags;
    80005b6e:	00038997          	auipc	s3,0x38
    80005b72:	49298993          	add	s3,s3,1170 # 8003e000 <disk+0x2000>
    80005b76:	00491713          	sll	a4,s2,0x4
    80005b7a:	0009b783          	ld	a5,0(s3)
    80005b7e:	97ba                	add	a5,a5,a4
    80005b80:	00c7d483          	lhu	s1,12(a5)
    int nxt = disk.desc[i].next;
    80005b84:	854a                	mv	a0,s2
    80005b86:	00e7d903          	lhu	s2,14(a5)
    free_desc(i);
    80005b8a:	00000097          	auipc	ra,0x0
    80005b8e:	c3a080e7          	jalr	-966(ra) # 800057c4 <free_desc>
    if(flag & VRING_DESC_F_NEXT)
    80005b92:	8885                	and	s1,s1,1
    80005b94:	f0ed                	bnez	s1,80005b76 <virtio_disk_rw+0x1ba>
  free_chain(idx[0]);

  release(&disk.vdisk_lock);
    80005b96:	00038517          	auipc	a0,0x38
    80005b9a:	59250513          	add	a0,a0,1426 # 8003e128 <disk+0x2128>
    80005b9e:	00004097          	auipc	ra,0x4
    80005ba2:	d9a080e7          	jalr	-614(ra) # 80009938 <release>
}
    80005ba6:	70a6                	ld	ra,104(sp)
    80005ba8:	7406                	ld	s0,96(sp)
    80005baa:	64e6                	ld	s1,88(sp)
    80005bac:	6946                	ld	s2,80(sp)
    80005bae:	69a6                	ld	s3,72(sp)
    80005bb0:	6a06                	ld	s4,64(sp)
    80005bb2:	7ae2                	ld	s5,56(sp)
    80005bb4:	7b42                	ld	s6,48(sp)
    80005bb6:	7ba2                	ld	s7,40(sp)
    80005bb8:	7c02                	ld	s8,32(sp)
    80005bba:	6ce2                	ld	s9,24(sp)
    80005bbc:	6165                	add	sp,sp,112
    80005bbe:	8082                	ret
  struct virtio_blk_req *buf0 = &disk.ops[idx[0]];
    80005bc0:	f9042503          	lw	a0,-112(s0)
    80005bc4:	00451613          	sll	a2,a0,0x4
  if(write)
    80005bc8:	00036597          	auipc	a1,0x36
    80005bcc:	43858593          	add	a1,a1,1080 # 8003c000 <disk>
    80005bd0:	20050793          	add	a5,a0,512
    80005bd4:	0792                	sll	a5,a5,0x4
    80005bd6:	97ae                	add	a5,a5,a1
    80005bd8:	01903733          	snez	a4,s9
    80005bdc:	0ae7a423          	sw	a4,168(a5)
  buf0->reserved = 0;
    80005be0:	0a07a623          	sw	zero,172(a5)
  buf0->sector = sector;
    80005be4:	0b87b823          	sd	s8,176(a5)
  disk.desc[idx[0]].addr = (uint64) buf0;
    80005be8:	00038717          	auipc	a4,0x38
    80005bec:	41870713          	add	a4,a4,1048 # 8003e000 <disk+0x2000>
    80005bf0:	6314                	ld	a3,0(a4)
    80005bf2:	96b2                	add	a3,a3,a2
  struct virtio_blk_req *buf0 = &disk.ops[idx[0]];
    80005bf4:	6789                	lui	a5,0x2
    80005bf6:	0a878793          	add	a5,a5,168 # 20a8 <_entry-0x7fffdf58>
    80005bfa:	97b2                	add	a5,a5,a2
    80005bfc:	97ae                	add	a5,a5,a1
  disk.desc[idx[0]].addr = (uint64) buf0;
    80005bfe:	e29c                	sd	a5,0(a3)
  disk.desc[idx[0]].len = sizeof(struct virtio_blk_req);
    80005c00:	631c                	ld	a5,0(a4)
    80005c02:	97b2                	add	a5,a5,a2
    80005c04:	46c1                	li	a3,16
    80005c06:	c794                	sw	a3,8(a5)
  disk.desc[idx[0]].flags = VRING_DESC_F_NEXT;
    80005c08:	631c                	ld	a5,0(a4)
    80005c0a:	97b2                	add	a5,a5,a2
    80005c0c:	4685                	li	a3,1
    80005c0e:	00d79623          	sh	a3,12(a5)
  disk.desc[idx[0]].next = idx[1];
    80005c12:	f9442783          	lw	a5,-108(s0)
    80005c16:	6314                	ld	a3,0(a4)
    80005c18:	96b2                	add	a3,a3,a2
    80005c1a:	00f69723          	sh	a5,14(a3)
  disk.desc[idx[1]].addr = (uint64) b->data;
    80005c1e:	0792                	sll	a5,a5,0x4
    80005c20:	6314                	ld	a3,0(a4)
    80005c22:	96be                	add	a3,a3,a5
    80005c24:	058a0593          	add	a1,s4,88
    80005c28:	e28c                	sd	a1,0(a3)
  disk.desc[idx[1]].len = BSIZE;
    80005c2a:	6318                	ld	a4,0(a4)
    80005c2c:	973e                	add	a4,a4,a5
    80005c2e:	40000693          	li	a3,1024
    80005c32:	c714                	sw	a3,8(a4)
  if(write)
    80005c34:	e40c97e3          	bnez	s9,80005a82 <virtio_disk_rw+0xc6>
    disk.desc[idx[1]].flags = VRING_DESC_F_WRITE; // device writes b->data
    80005c38:	00038717          	auipc	a4,0x38
    80005c3c:	3c873703          	ld	a4,968(a4) # 8003e000 <disk+0x2000>
    80005c40:	973e                	add	a4,a4,a5
    80005c42:	4689                	li	a3,2
    80005c44:	00d71623          	sh	a3,12(a4)
    80005c48:	b5a1                	j	80005a90 <virtio_disk_rw+0xd4>

0000000080005c4a <virtio_disk_intr>:

void
virtio_disk_intr()
{
    80005c4a:	1101                	add	sp,sp,-32
    80005c4c:	ec06                	sd	ra,24(sp)
    80005c4e:	e822                	sd	s0,16(sp)
    80005c50:	1000                	add	s0,sp,32
  acquire(&disk.vdisk_lock);
    80005c52:	00038517          	auipc	a0,0x38
    80005c56:	4d650513          	add	a0,a0,1238 # 8003e128 <disk+0x2128>
    80005c5a:	00004097          	auipc	ra,0x4
    80005c5e:	c18080e7          	jalr	-1000(ra) # 80009872 <acquire>
  // we've seen this interrupt, which the following line does.
  // this may race with the device writing new entries to
  // the "used" ring, in which case we may process the new
  // completion entries in this interrupt, and have nothing to do
  // in the next interrupt, which is harmless.
  *R(VIRTIO_MMIO_INTERRUPT_ACK) = *R(VIRTIO_MMIO_INTERRUPT_STATUS) & 0x3;
    80005c62:	100017b7          	lui	a5,0x10001
    80005c66:	53b8                	lw	a4,96(a5)
    80005c68:	8b0d                	and	a4,a4,3
    80005c6a:	100017b7          	lui	a5,0x10001
    80005c6e:	d3f8                	sw	a4,100(a5)

  __sync_synchronize();
    80005c70:	0ff0000f          	fence

  // the device increments disk.used->idx when it
  // adds an entry to the used ring.

  while(disk.used_idx != disk.used->idx){
    80005c74:	00038797          	auipc	a5,0x38
    80005c78:	38c78793          	add	a5,a5,908 # 8003e000 <disk+0x2000>
    80005c7c:	6b94                	ld	a3,16(a5)
    80005c7e:	0207d703          	lhu	a4,32(a5)
    80005c82:	0026d783          	lhu	a5,2(a3)
    80005c86:	06f70563          	beq	a4,a5,80005cf0 <virtio_disk_intr+0xa6>
    80005c8a:	e426                	sd	s1,8(sp)
    80005c8c:	e04a                	sd	s2,0(sp)
    __sync_synchronize();
    int id = disk.used->ring[disk.used_idx % NUM].id;
    80005c8e:	00036917          	auipc	s2,0x36
    80005c92:	37290913          	add	s2,s2,882 # 8003c000 <disk>
    80005c96:	00038497          	auipc	s1,0x38
    80005c9a:	36a48493          	add	s1,s1,874 # 8003e000 <disk+0x2000>
    __sync_synchronize();
    80005c9e:	0ff0000f          	fence
    int id = disk.used->ring[disk.used_idx % NUM].id;
    80005ca2:	6898                	ld	a4,16(s1)
    80005ca4:	0204d783          	lhu	a5,32(s1)
    80005ca8:	8b9d                	and	a5,a5,7
    80005caa:	078e                	sll	a5,a5,0x3
    80005cac:	97ba                	add	a5,a5,a4
    80005cae:	43dc                	lw	a5,4(a5)

    if(disk.info[id].status != 0)
    80005cb0:	20078713          	add	a4,a5,512
    80005cb4:	0712                	sll	a4,a4,0x4
    80005cb6:	974a                	add	a4,a4,s2
    80005cb8:	03074703          	lbu	a4,48(a4)
    80005cbc:	e731                	bnez	a4,80005d08 <virtio_disk_intr+0xbe>
      panic("virtio_disk_intr status");

    struct buf *b = disk.info[id].b;
    80005cbe:	20078793          	add	a5,a5,512
    80005cc2:	0792                	sll	a5,a5,0x4
    80005cc4:	97ca                	add	a5,a5,s2
    80005cc6:	7788                	ld	a0,40(a5)
    b->disk = 0;   // disk is done with buf
    80005cc8:	00052223          	sw	zero,4(a0)
    wakeup(b);
    80005ccc:	ffffc097          	auipc	ra,0xffffc
    80005cd0:	c12080e7          	jalr	-1006(ra) # 800018de <wakeup>

    disk.used_idx += 1;
    80005cd4:	0204d783          	lhu	a5,32(s1)
    80005cd8:	2785                	addw	a5,a5,1
    80005cda:	17c2                	sll	a5,a5,0x30
    80005cdc:	93c1                	srl	a5,a5,0x30
    80005cde:	02f49023          	sh	a5,32(s1)
  while(disk.used_idx != disk.used->idx){
    80005ce2:	6898                	ld	a4,16(s1)
    80005ce4:	00275703          	lhu	a4,2(a4)
    80005ce8:	faf71be3          	bne	a4,a5,80005c9e <virtio_disk_intr+0x54>
    80005cec:	64a2                	ld	s1,8(sp)
    80005cee:	6902                	ld	s2,0(sp)
  }

  release(&disk.vdisk_lock);
    80005cf0:	00038517          	auipc	a0,0x38
    80005cf4:	43850513          	add	a0,a0,1080 # 8003e128 <disk+0x2128>
    80005cf8:	00004097          	auipc	ra,0x4
    80005cfc:	c40080e7          	jalr	-960(ra) # 80009938 <release>
}
    80005d00:	60e2                	ld	ra,24(sp)
    80005d02:	6442                	ld	s0,16(sp)
    80005d04:	6105                	add	sp,sp,32
    80005d06:	8082                	ret
      panic("virtio_disk_intr status");
    80005d08:	00006517          	auipc	a0,0x6
    80005d0c:	98850513          	add	a0,a0,-1656 # 8000b690 <etext+0x690>
    80005d10:	00003097          	auipc	ra,0x3
    80005d14:	5c8080e7          	jalr	1480(ra) # 800092d8 <panic>

0000000080005d18 <e1000_init>:
// called by pci_init().
// xregs is the memory address at which the
// e1000's registers are mapped.
void
e1000_init(uint32 *xregs)
{
    80005d18:	7179                	add	sp,sp,-48
    80005d1a:	f406                	sd	ra,40(sp)
    80005d1c:	f022                	sd	s0,32(sp)
    80005d1e:	ec26                	sd	s1,24(sp)
    80005d20:	e84a                	sd	s2,16(sp)
    80005d22:	e44e                	sd	s3,8(sp)
    80005d24:	1800                	add	s0,sp,48
    80005d26:	84aa                	mv	s1,a0
  int i;

  initlock(&e1000_lock, "e1000");
    80005d28:	00006597          	auipc	a1,0x6
    80005d2c:	98058593          	add	a1,a1,-1664 # 8000b6a8 <etext+0x6a8>
    80005d30:	00039517          	auipc	a0,0x39
    80005d34:	2d050513          	add	a0,a0,720 # 8003f000 <e1000_lock>
    80005d38:	00004097          	auipc	ra,0x4
    80005d3c:	aaa080e7          	jalr	-1366(ra) # 800097e2 <initlock>
  initlock(&e1000_lockrx, "e1000_rx");
    80005d40:	00006597          	auipc	a1,0x6
    80005d44:	97058593          	add	a1,a1,-1680 # 8000b6b0 <etext+0x6b0>
    80005d48:	00039517          	auipc	a0,0x39
    80005d4c:	2d050513          	add	a0,a0,720 # 8003f018 <e1000_lockrx>
    80005d50:	00004097          	auipc	ra,0x4
    80005d54:	a92080e7          	jalr	-1390(ra) # 800097e2 <initlock>

  regs = xregs;
    80005d58:	00006797          	auipc	a5,0x6
    80005d5c:	2c97b423          	sd	s1,712(a5) # 8000c020 <regs>

  // Reset the device
  regs[E1000_IMS] = 0; // disable interrupts
    80005d60:	0c04a823          	sw	zero,208(s1)
  regs[E1000_CTL] |= E1000_CTL_RST;
    80005d64:	409c                	lw	a5,0(s1)
    80005d66:	00400737          	lui	a4,0x400
    80005d6a:	8fd9                	or	a5,a5,a4
    80005d6c:	c09c                	sw	a5,0(s1)
  regs[E1000_IMS] = 0; // redisable interrupts
    80005d6e:	0c04a823          	sw	zero,208(s1)
  __sync_synchronize();
    80005d72:	0ff0000f          	fence

  // [E1000 14.5] Transmit initialization
  memset(tx_ring, 0, sizeof(tx_ring));
    80005d76:	10000613          	li	a2,256
    80005d7a:	4581                	li	a1,0
    80005d7c:	00039517          	auipc	a0,0x39
    80005d80:	2b450513          	add	a0,a0,692 # 8003f030 <tx_ring>
    80005d84:	ffffa097          	auipc	ra,0xffffa
    80005d88:	3f6080e7          	jalr	1014(ra) # 8000017a <memset>
  for (i = 0; i < TX_RING_SIZE; i++) {
    80005d8c:	00039717          	auipc	a4,0x39
    80005d90:	2b070713          	add	a4,a4,688 # 8003f03c <tx_ring+0xc>
    80005d94:	00039797          	auipc	a5,0x39
    80005d98:	39c78793          	add	a5,a5,924 # 8003f130 <tx_mbufs>
    80005d9c:	00039617          	auipc	a2,0x39
    80005da0:	41460613          	add	a2,a2,1044 # 8003f1b0 <rx_ring>
    tx_ring[i].status = E1000_TXD_STAT_DD;
    80005da4:	4685                	li	a3,1
    80005da6:	00d70023          	sb	a3,0(a4)
    tx_mbufs[i] = 0;
    80005daa:	0007b023          	sd	zero,0(a5)
  for (i = 0; i < TX_RING_SIZE; i++) {
    80005dae:	0741                	add	a4,a4,16
    80005db0:	07a1                	add	a5,a5,8
    80005db2:	fec79ae3          	bne	a5,a2,80005da6 <e1000_init+0x8e>
  }
  regs[E1000_TDBAL] = (uint64) tx_ring;
    80005db6:	00039717          	auipc	a4,0x39
    80005dba:	27a70713          	add	a4,a4,634 # 8003f030 <tx_ring>
    80005dbe:	00006797          	auipc	a5,0x6
    80005dc2:	2627b783          	ld	a5,610(a5) # 8000c020 <regs>
    80005dc6:	6691                	lui	a3,0x4
    80005dc8:	97b6                	add	a5,a5,a3
    80005dca:	80e7a023          	sw	a4,-2048(a5)
  if(sizeof(tx_ring) % 128 != 0)
    panic("e1000");
  regs[E1000_TDLEN] = sizeof(tx_ring);
    80005dce:	10000713          	li	a4,256
    80005dd2:	80e7a423          	sw	a4,-2040(a5)
  regs[E1000_TDH] = regs[E1000_TDT] = 0;
    80005dd6:	8007ac23          	sw	zero,-2024(a5)
    80005dda:	8007a823          	sw	zero,-2032(a5)
  
  // [E1000 14.4] Receive initialization
  memset(rx_ring, 0, sizeof(rx_ring));
    80005dde:	00039917          	auipc	s2,0x39
    80005de2:	3d290913          	add	s2,s2,978 # 8003f1b0 <rx_ring>
    80005de6:	10000613          	li	a2,256
    80005dea:	4581                	li	a1,0
    80005dec:	854a                	mv	a0,s2
    80005dee:	ffffa097          	auipc	ra,0xffffa
    80005df2:	38c080e7          	jalr	908(ra) # 8000017a <memset>
  for (i = 0; i < RX_RING_SIZE; i++) {
    80005df6:	00039497          	auipc	s1,0x39
    80005dfa:	4ba48493          	add	s1,s1,1210 # 8003f2b0 <rx_mbufs>
    80005dfe:	00039997          	auipc	s3,0x39
    80005e02:	53298993          	add	s3,s3,1330 # 8003f330 <udp_lock>
    rx_mbufs[i] = mbufalloc(0);
    80005e06:	4501                	li	a0,0
    80005e08:	00001097          	auipc	ra,0x1
    80005e0c:	2be080e7          	jalr	702(ra) # 800070c6 <mbufalloc>
    80005e10:	e088                	sd	a0,0(s1)
    if (!rx_mbufs[i])
    80005e12:	c94d                	beqz	a0,80005ec4 <e1000_init+0x1ac>
      panic("e1000");
    rx_ring[i].addr = (uint64) rx_mbufs[i]->head;
    80005e14:	651c                	ld	a5,8(a0)
    80005e16:	00f93023          	sd	a5,0(s2)
  for (i = 0; i < RX_RING_SIZE; i++) {
    80005e1a:	04a1                	add	s1,s1,8
    80005e1c:	0941                	add	s2,s2,16
    80005e1e:	ff3494e3          	bne	s1,s3,80005e06 <e1000_init+0xee>
  }
  regs[E1000_RDBAL] = (uint64) rx_ring;
    80005e22:	00006697          	auipc	a3,0x6
    80005e26:	1fe6b683          	ld	a3,510(a3) # 8000c020 <regs>
    80005e2a:	00039717          	auipc	a4,0x39
    80005e2e:	38670713          	add	a4,a4,902 # 8003f1b0 <rx_ring>
    80005e32:	678d                	lui	a5,0x3
    80005e34:	97b6                	add	a5,a5,a3
    80005e36:	80e7a023          	sw	a4,-2048(a5) # 2800 <_entry-0x7fffd800>
  if(sizeof(rx_ring) % 128 != 0)
    panic("e1000");
  regs[E1000_RDH] = 0;
    80005e3a:	8007a823          	sw	zero,-2032(a5)
  regs[E1000_RDT] = RX_RING_SIZE - 1;
    80005e3e:	473d                	li	a4,15
    80005e40:	80e7ac23          	sw	a4,-2024(a5)
  regs[E1000_RDLEN] = sizeof(rx_ring);
    80005e44:	10000713          	li	a4,256
    80005e48:	80e7a423          	sw	a4,-2040(a5)

  // filter by qemu's MAC address, 52:54:00:12:34:56
  regs[E1000_RA] = 0x12005452;
    80005e4c:	6795                	lui	a5,0x5
    80005e4e:	97b6                	add	a5,a5,a3
    80005e50:	12005737          	lui	a4,0x12005
    80005e54:	45270713          	add	a4,a4,1106 # 12005452 <_entry-0x6dffabae>
    80005e58:	40e7a023          	sw	a4,1024(a5) # 5400 <_entry-0x7fffac00>
  regs[E1000_RA+1] = 0x5634 | (1<<31);
    80005e5c:	80005737          	lui	a4,0x80005
    80005e60:	63470713          	add	a4,a4,1588 # ffffffff80005634 <end+0xfffffffefffbe064>
    80005e64:	40e7a223          	sw	a4,1028(a5)
  // multicast table
  for (int i = 0; i < 4096/32; i++)
    80005e68:	6795                	lui	a5,0x5
    80005e6a:	20078793          	add	a5,a5,512 # 5200 <_entry-0x7fffae00>
    80005e6e:	97b6                	add	a5,a5,a3
    80005e70:	6715                	lui	a4,0x5
    80005e72:	40070713          	add	a4,a4,1024 # 5400 <_entry-0x7fffac00>
    80005e76:	9736                	add	a4,a4,a3
    regs[E1000_MTA + i] = 0;
    80005e78:	0007a023          	sw	zero,0(a5)
  for (int i = 0; i < 4096/32; i++)
    80005e7c:	0791                	add	a5,a5,4
    80005e7e:	fee79de3          	bne	a5,a4,80005e78 <e1000_init+0x160>

  // transmitter control bits.
  regs[E1000_TCTL] = E1000_TCTL_EN |  // enable
    80005e82:	000407b7          	lui	a5,0x40
    80005e86:	10a78793          	add	a5,a5,266 # 4010a <_entry-0x7ffbfef6>
    80005e8a:	40f6a023          	sw	a5,1024(a3)
    E1000_TCTL_PSP |                  // pad short packets
    (0x10 << E1000_TCTL_CT_SHIFT) |   // collision stuff
    (0x40 << E1000_TCTL_COLD_SHIFT);
  regs[E1000_TIPG] = 10 | (8<<10) | (6<<20); // inter-pkt gap
    80005e8e:	006027b7          	lui	a5,0x602
    80005e92:	07a9                	add	a5,a5,10 # 60200a <_entry-0x7f9fdff6>
    80005e94:	40f6a823          	sw	a5,1040(a3)

  // receiver control bits.
  regs[E1000_RCTL] = E1000_RCTL_EN | // enable receiver
    80005e98:	040087b7          	lui	a5,0x4008
    80005e9c:	0789                	add	a5,a5,2 # 4008002 <_entry-0x7bff7ffe>
    80005e9e:	10f6a023          	sw	a5,256(a3)
    E1000_RCTL_BAM |                 // enable broadcast
    E1000_RCTL_SZ_2048 |             // 2048-byte rx buffers
    E1000_RCTL_SECRC;                // strip CRC
  
  // ask e1000 for receive interrupts.
  regs[E1000_RDTR] = 0; // interrupt after every received packet (no timer)
    80005ea2:	678d                	lui	a5,0x3
    80005ea4:	97b6                	add	a5,a5,a3
    80005ea6:	8207a023          	sw	zero,-2016(a5) # 2820 <_entry-0x7fffd7e0>
  regs[E1000_RADV] = 0; // interrupt after every packet (no timer)
    80005eaa:	8207a623          	sw	zero,-2004(a5)
  regs[E1000_IMS] = (1 << 7); // RXDW -- Receiver Descriptor Write Back
    80005eae:	08000793          	li	a5,128
    80005eb2:	0cf6a823          	sw	a5,208(a3)
}
    80005eb6:	70a2                	ld	ra,40(sp)
    80005eb8:	7402                	ld	s0,32(sp)
    80005eba:	64e2                	ld	s1,24(sp)
    80005ebc:	6942                	ld	s2,16(sp)
    80005ebe:	69a2                	ld	s3,8(sp)
    80005ec0:	6145                	add	sp,sp,48
    80005ec2:	8082                	ret
      panic("e1000");
    80005ec4:	00005517          	auipc	a0,0x5
    80005ec8:	7e450513          	add	a0,a0,2020 # 8000b6a8 <etext+0x6a8>
    80005ecc:	00003097          	auipc	ra,0x3
    80005ed0:	40c080e7          	jalr	1036(ra) # 800092d8 <panic>

0000000080005ed4 <e1000_transmit>:

int
e1000_transmit(struct mbuf *m)
{
    80005ed4:	7179                	add	sp,sp,-48
    80005ed6:	f406                	sd	ra,40(sp)
    80005ed8:	f022                	sd	s0,32(sp)
    80005eda:	ec26                	sd	s1,24(sp)
    80005edc:	e84a                	sd	s2,16(sp)
    80005ede:	e44e                	sd	s3,8(sp)
    80005ee0:	1800                	add	s0,sp,48
    80005ee2:	89aa                	mv	s3,a0
  // the TX descriptor ring so that the e1000 sends it. Stash
  // a pointer so that it can be freed after sending.
  //
  e1000dbg("[e1000] %d len data transmit\n", m->len);

  acquire(&e1000_lock);
    80005ee4:	00039917          	auipc	s2,0x39
    80005ee8:	11c90913          	add	s2,s2,284 # 8003f000 <e1000_lock>
    80005eec:	854a                	mv	a0,s2
    80005eee:	00004097          	auipc	ra,0x4
    80005ef2:	984080e7          	jalr	-1660(ra) # 80009872 <acquire>

  int tail = regs[E1000_TDT];
    80005ef6:	00006797          	auipc	a5,0x6
    80005efa:	12a7b783          	ld	a5,298(a5) # 8000c020 <regs>
    80005efe:	6711                	lui	a4,0x4
    80005f00:	97ba                	add	a5,a5,a4
    80005f02:	8187a483          	lw	s1,-2024(a5)
  if(!(tx_ring[tail].status & E1000_TXD_STAT_DD)){
    80005f06:	00449793          	sll	a5,s1,0x4
    80005f0a:	993e                	add	s2,s2,a5
    80005f0c:	03c94783          	lbu	a5,60(s2)
    80005f10:	8b85                	and	a5,a5,1
    80005f12:	c3c5                	beqz	a5,80005fb2 <e1000_transmit+0xde>
    80005f14:	e052                	sd	s4,0(sp)
    release(&e1000_lock);
    return -1;
  }
  
  if(tx_mbufs[tail])
    80005f16:	00349713          	sll	a4,s1,0x3
    80005f1a:	00039797          	auipc	a5,0x39
    80005f1e:	0e678793          	add	a5,a5,230 # 8003f000 <e1000_lock>
    80005f22:	97ba                	add	a5,a5,a4
    80005f24:	1307b503          	ld	a0,304(a5)
    80005f28:	c509                	beqz	a0,80005f32 <e1000_transmit+0x5e>
    mbuffree(tx_mbufs[tail]);
    80005f2a:	00001097          	auipc	ra,0x1
    80005f2e:	202080e7          	jalr	514(ra) # 8000712c <mbuffree>
  
  memset(&tx_ring[tail], 0, sizeof(struct tx_desc));
    80005f32:	00039a17          	auipc	s4,0x39
    80005f36:	0cea0a13          	add	s4,s4,206 # 8003f000 <e1000_lock>
    80005f3a:	00449913          	sll	s2,s1,0x4
    80005f3e:	4641                	li	a2,16
    80005f40:	4581                	li	a1,0
    80005f42:	00039517          	auipc	a0,0x39
    80005f46:	0ee50513          	add	a0,a0,238 # 8003f030 <tx_ring>
    80005f4a:	954a                	add	a0,a0,s2
    80005f4c:	ffffa097          	auipc	ra,0xffffa
    80005f50:	22e080e7          	jalr	558(ra) # 8000017a <memset>
  tx_ring[tail].cmd = (E1000_TXD_CMD_EOP | E1000_TXD_CMD_RS);
    80005f54:	012a07b3          	add	a5,s4,s2
    80005f58:	4725                	li	a4,9
    80005f5a:	02e78da3          	sb	a4,59(a5)
  tx_ring[tail].addr = (uint64)m->head;
    80005f5e:	0089b703          	ld	a4,8(s3)
    80005f62:	fb98                	sd	a4,48(a5)
  tx_ring[tail].length = m->len;
    80005f64:	0109a703          	lw	a4,16(s3)
    80005f68:	02e79c23          	sh	a4,56(a5)
  tx_mbufs[tail] = m;
    80005f6c:	00349793          	sll	a5,s1,0x3
    80005f70:	97d2                	add	a5,a5,s4
    80005f72:	1337b823          	sd	s3,304(a5)

  regs[E1000_TDT] = (tail + 1) % TX_RING_SIZE;
    80005f76:	2485                	addw	s1,s1,1
    80005f78:	41f4d79b          	sraw	a5,s1,0x1f
    80005f7c:	01c7d79b          	srlw	a5,a5,0x1c
    80005f80:	9cbd                	addw	s1,s1,a5
    80005f82:	88bd                	and	s1,s1,15
    80005f84:	9c9d                	subw	s1,s1,a5
    80005f86:	00006797          	auipc	a5,0x6
    80005f8a:	09a7b783          	ld	a5,154(a5) # 8000c020 <regs>
    80005f8e:	6711                	lui	a4,0x4
    80005f90:	97ba                	add	a5,a5,a4
    80005f92:	8097ac23          	sw	s1,-2024(a5)
  
  release(&e1000_lock);
    80005f96:	8552                	mv	a0,s4
    80005f98:	00004097          	auipc	ra,0x4
    80005f9c:	9a0080e7          	jalr	-1632(ra) # 80009938 <release>
 
  return 0;
    80005fa0:	4501                	li	a0,0
    80005fa2:	6a02                	ld	s4,0(sp)
}
    80005fa4:	70a2                	ld	ra,40(sp)
    80005fa6:	7402                	ld	s0,32(sp)
    80005fa8:	64e2                	ld	s1,24(sp)
    80005faa:	6942                	ld	s2,16(sp)
    80005fac:	69a2                	ld	s3,8(sp)
    80005fae:	6145                	add	sp,sp,48
    80005fb0:	8082                	ret
    release(&e1000_lock);
    80005fb2:	00039517          	auipc	a0,0x39
    80005fb6:	04e50513          	add	a0,a0,78 # 8003f000 <e1000_lock>
    80005fba:	00004097          	auipc	ra,0x4
    80005fbe:	97e080e7          	jalr	-1666(ra) # 80009938 <release>
    return -1;
    80005fc2:	557d                	li	a0,-1
    80005fc4:	b7c5                	j	80005fa4 <e1000_transmit+0xd0>

0000000080005fc6 <e1000_intr>:
  release(&e1000_lockrx);
}

void
e1000_intr(void)
{
    80005fc6:	7139                	add	sp,sp,-64
    80005fc8:	fc06                	sd	ra,56(sp)
    80005fca:	f822                	sd	s0,48(sp)
    80005fcc:	f426                	sd	s1,40(sp)
    80005fce:	0080                	add	s0,sp,64
  // tell the e1000 we've seen this interrupt;
  // without this the e1000 won't raise any
  // further interrupts.
  regs[E1000_ICR] = 0xffffffff;
    80005fd0:	00006497          	auipc	s1,0x6
    80005fd4:	05048493          	add	s1,s1,80 # 8000c020 <regs>
    80005fd8:	609c                	ld	a5,0(s1)
    80005fda:	577d                	li	a4,-1
    80005fdc:	0ce7a023          	sw	a4,192(a5)
  acquire(&e1000_lockrx);
    80005fe0:	00039517          	auipc	a0,0x39
    80005fe4:	03850513          	add	a0,a0,56 # 8003f018 <e1000_lockrx>
    80005fe8:	00004097          	auipc	ra,0x4
    80005fec:	88a080e7          	jalr	-1910(ra) # 80009872 <acquire>
  int i = (regs[E1000_RDT] + 1) % RX_RING_SIZE;
    80005ff0:	609c                	ld	a5,0(s1)
    80005ff2:	670d                	lui	a4,0x3
    80005ff4:	97ba                	add	a5,a5,a4
    80005ff6:	8187a483          	lw	s1,-2024(a5)
    80005ffa:	2485                	addw	s1,s1,1
    80005ffc:	88bd                	and	s1,s1,15
  while(rx_ring[i].status & E1000_RXD_STAT_DD){
    80005ffe:	00449713          	sll	a4,s1,0x4
    80006002:	00039797          	auipc	a5,0x39
    80006006:	ffe78793          	add	a5,a5,-2 # 8003f000 <e1000_lock>
    8000600a:	97ba                	add	a5,a5,a4
    8000600c:	1bc7c783          	lbu	a5,444(a5)
    80006010:	8b85                	and	a5,a5,1
    80006012:	cbd1                	beqz	a5,800060a6 <e1000_intr+0xe0>
    80006014:	f04a                	sd	s2,32(sp)
    80006016:	ec4e                	sd	s3,24(sp)
    80006018:	e852                	sd	s4,16(sp)
    8000601a:	e456                	sd	s5,8(sp)
    8000601c:	e05a                	sd	s6,0(sp)
    rx_mbufs[i]->len = rx_ring[i].length;
    8000601e:	00039997          	auipc	s3,0x39
    80006022:	fe298993          	add	s3,s3,-30 # 8003f000 <e1000_lock>
    regs[E1000_RDT] = i;
    80006026:	00006a97          	auipc	s5,0x6
    8000602a:	ffaa8a93          	add	s5,s5,-6 # 8000c020 <regs>
    8000602e:	6a0d                	lui	s4,0x3
    rx_mbufs[i]->len = rx_ring[i].length;
    80006030:	00349913          	sll	s2,s1,0x3
    80006034:	994e                	add	s2,s2,s3
    80006036:	2b093703          	ld	a4,688(s2)
    8000603a:	00449793          	sll	a5,s1,0x4
    8000603e:	97ce                	add	a5,a5,s3
    80006040:	1b87d783          	lhu	a5,440(a5)
    80006044:	cb1c                	sw	a5,16(a4)
    struct mbuf *rb = rx_mbufs[i];
    80006046:	2b093b03          	ld	s6,688(s2)
    rx_mbufs[i] = mbufalloc(0);
    8000604a:	4501                	li	a0,0
    8000604c:	00001097          	auipc	ra,0x1
    80006050:	07a080e7          	jalr	122(ra) # 800070c6 <mbufalloc>
    80006054:	2aa93823          	sd	a0,688(s2)
    if (!rx_mbufs[i])
    80006058:	c525                	beqz	a0,800060c0 <e1000_intr+0xfa>
    rx_ring[i].addr = (uint64) rx_mbufs[i]->head;
    8000605a:	00449793          	sll	a5,s1,0x4
    8000605e:	97ce                	add	a5,a5,s3
    80006060:	6518                	ld	a4,8(a0)
    80006062:	1ae7b823          	sd	a4,432(a5)
    rx_ring[i].status = 0;
    80006066:	1a078e23          	sb	zero,444(a5)
    regs[E1000_RDT] = i;
    8000606a:	000ab783          	ld	a5,0(s5)
    8000606e:	2481                	sext.w	s1,s1
    80006070:	97d2                	add	a5,a5,s4
    80006072:	8097ac23          	sw	s1,-2024(a5)
    net_rx(rb);
    80006076:	855a                	mv	a0,s6
    80006078:	00000097          	auipc	ra,0x0
    8000607c:	292080e7          	jalr	658(ra) # 8000630a <net_rx>
    i = (regs[E1000_RDT] + 1) % RX_RING_SIZE;
    80006080:	000ab783          	ld	a5,0(s5)
    80006084:	97d2                	add	a5,a5,s4
    80006086:	8187a483          	lw	s1,-2024(a5)
    8000608a:	2485                	addw	s1,s1,1
    8000608c:	88bd                	and	s1,s1,15
  while(rx_ring[i].status & E1000_RXD_STAT_DD){
    8000608e:	00449793          	sll	a5,s1,0x4
    80006092:	97ce                	add	a5,a5,s3
    80006094:	1bc7c783          	lbu	a5,444(a5)
    80006098:	8b85                	and	a5,a5,1
    8000609a:	fbd9                	bnez	a5,80006030 <e1000_intr+0x6a>
    8000609c:	7902                	ld	s2,32(sp)
    8000609e:	69e2                	ld	s3,24(sp)
    800060a0:	6a42                	ld	s4,16(sp)
    800060a2:	6aa2                	ld	s5,8(sp)
    800060a4:	6b02                	ld	s6,0(sp)
  release(&e1000_lockrx);
    800060a6:	00039517          	auipc	a0,0x39
    800060aa:	f7250513          	add	a0,a0,-142 # 8003f018 <e1000_lockrx>
    800060ae:	00004097          	auipc	ra,0x4
    800060b2:	88a080e7          	jalr	-1910(ra) # 80009938 <release>

  e1000_recv();
}
    800060b6:	70e2                	ld	ra,56(sp)
    800060b8:	7442                	ld	s0,48(sp)
    800060ba:	74a2                	ld	s1,40(sp)
    800060bc:	6121                	add	sp,sp,64
    800060be:	8082                	ret
      panic("e1000");
    800060c0:	00005517          	auipc	a0,0x5
    800060c4:	5e850513          	add	a0,a0,1512 # 8000b6a8 <etext+0x6a8>
    800060c8:	00003097          	auipc	ra,0x3
    800060cc:	210080e7          	jalr	528(ra) # 800092d8 <panic>

00000000800060d0 <in_cksum>:

// This code is lifted from FreeBSD's ping.c, and is copyright by the Regents
// of the University of California.
static unsigned short
in_cksum(const unsigned char *addr, int len)
{
    800060d0:	1141                	add	sp,sp,-16
    800060d2:	e422                	sd	s0,8(sp)
    800060d4:	0800                	add	s0,sp,16
  /*
   * Our algorithm is simple, using a 32 bit accumulator (sum), we add
   * sequential 16 bit words to it, and at the end, fold back all the
   * carry bits from the top 16 bits into the lower 16 bits.
   */
  while (nleft > 1)  {
    800060d6:	4785                	li	a5,1
    800060d8:	04b7db63          	bge	a5,a1,8000612e <in_cksum+0x5e>
    800060dc:	ffe5861b          	addw	a2,a1,-2
    800060e0:	0016561b          	srlw	a2,a2,0x1
    800060e4:	0016069b          	addw	a3,a2,1
    800060e8:	02069793          	sll	a5,a3,0x20
    800060ec:	01f7d693          	srl	a3,a5,0x1f
    800060f0:	96aa                	add	a3,a3,a0
  unsigned int sum = 0;
    800060f2:	4781                	li	a5,0
    sum += *w++;
    800060f4:	0509                	add	a0,a0,2
    800060f6:	ffe55703          	lhu	a4,-2(a0)
    800060fa:	9fb9                	addw	a5,a5,a4
  while (nleft > 1)  {
    800060fc:	fed51ce3          	bne	a0,a3,800060f4 <in_cksum+0x24>
    80006100:	35f9                	addw	a1,a1,-2
    80006102:	0016161b          	sllw	a2,a2,0x1
    80006106:	9d91                	subw	a1,a1,a2
    nleft -= 2;
  }

  /* mop up an odd byte, if necessary */
  if (nleft == 1) {
    80006108:	4705                	li	a4,1
    8000610a:	02e58563          	beq	a1,a4,80006134 <in_cksum+0x64>
    *(unsigned char *)(&answer) = *(const unsigned char *)w;
    sum += answer;
  }

  /* add back carry outs from top 16 bits to low 16 bits */
  sum = (sum & 0xffff) + (sum >> 16);
    8000610e:	03079713          	sll	a4,a5,0x30
    80006112:	9341                	srl	a4,a4,0x30
    80006114:	0107d79b          	srlw	a5,a5,0x10
    80006118:	9fb9                	addw	a5,a5,a4
  sum += (sum >> 16);
    8000611a:	0107d51b          	srlw	a0,a5,0x10
    8000611e:	9d3d                	addw	a0,a0,a5
  /* guaranteed now that the lower 16 bits of sum are correct */

  answer = ~sum; /* truncate to 16 bits */
    80006120:	fff54513          	not	a0,a0
  return answer;
}
    80006124:	1542                	sll	a0,a0,0x30
    80006126:	9141                	srl	a0,a0,0x30
    80006128:	6422                	ld	s0,8(sp)
    8000612a:	0141                	add	sp,sp,16
    8000612c:	8082                	ret
  const unsigned short *w = (const unsigned short *)addr;
    8000612e:	86aa                	mv	a3,a0
  unsigned int sum = 0;
    80006130:	4781                	li	a5,0
    80006132:	bfd9                	j	80006108 <in_cksum+0x38>
    *(unsigned char *)(&answer) = *(const unsigned char *)w;
    80006134:	0006c703          	lbu	a4,0(a3)
    sum += answer;
    80006138:	9fb9                	addw	a5,a5,a4
    8000613a:	bfd1                	j	8000610e <in_cksum+0x3e>

000000008000613c <net_tx_eth>:

// sends an ethernet packet
static void
net_tx_eth(struct mbuf *m, uint16 ethtype)
{
    8000613c:	7179                	add	sp,sp,-48
    8000613e:	f406                	sd	ra,40(sp)
    80006140:	f022                	sd	s0,32(sp)
    80006142:	ec26                	sd	s1,24(sp)
    80006144:	e84a                	sd	s2,16(sp)
    80006146:	e44e                	sd	s3,8(sp)
    80006148:	1800                	add	s0,sp,48
    8000614a:	89aa                	mv	s3,a0
    8000614c:	892e                	mv	s2,a1
  struct eth *ethhdr;

  ethhdr = mbufpushhdr(m, *ethhdr);
    8000614e:	45b9                	li	a1,14
    80006150:	00001097          	auipc	ra,0x1
    80006154:	ee4080e7          	jalr	-284(ra) # 80007034 <mbufpush>
    80006158:	84aa                	mv	s1,a0
  memmove(ethhdr->shost, local_mac, ETHADDR_LEN);
    8000615a:	4619                	li	a2,6
    8000615c:	00006597          	auipc	a1,0x6
    80006160:	a0458593          	add	a1,a1,-1532 # 8000bb60 <local_mac>
    80006164:	0519                	add	a0,a0,6
    80006166:	ffffa097          	auipc	ra,0xffffa
    8000616a:	070080e7          	jalr	112(ra) # 800001d6 <memmove>
  // In a real networking stack, dhost would be set to the address discovered
  // through ARP. Because we don't support enough of the ARP protocol, set it
  // to broadcast instead.
  memmove(ethhdr->dhost, broadcast_mac, ETHADDR_LEN);
    8000616e:	4619                	li	a2,6
    80006170:	00006597          	auipc	a1,0x6
    80006174:	9e858593          	add	a1,a1,-1560 # 8000bb58 <broadcast_mac>
    80006178:	8526                	mv	a0,s1
    8000617a:	ffffa097          	auipc	ra,0xffffa
    8000617e:	05c080e7          	jalr	92(ra) # 800001d6 <memmove>
    80006182:	0089579b          	srlw	a5,s2,0x8
  ethhdr->type = htons(ethtype);
    80006186:	00f48623          	sb	a5,12(s1)
    8000618a:	012486a3          	sb	s2,13(s1)
  if (e1000_transmit(m)) {
    8000618e:	854e                	mv	a0,s3
    80006190:	00000097          	auipc	ra,0x0
    80006194:	d44080e7          	jalr	-700(ra) # 80005ed4 <e1000_transmit>
    80006198:	e901                	bnez	a0,800061a8 <net_tx_eth+0x6c>
    mbuffree(m);
  }
}
    8000619a:	70a2                	ld	ra,40(sp)
    8000619c:	7402                	ld	s0,32(sp)
    8000619e:	64e2                	ld	s1,24(sp)
    800061a0:	6942                	ld	s2,16(sp)
    800061a2:	69a2                	ld	s3,8(sp)
    800061a4:	6145                	add	sp,sp,48
    800061a6:	8082                	ret
    mbuffree(m);
    800061a8:	854e                	mv	a0,s3
    800061aa:	00001097          	auipc	ra,0x1
    800061ae:	f82080e7          	jalr	-126(ra) # 8000712c <mbuffree>
}
    800061b2:	b7e5                	j	8000619a <net_tx_eth+0x5e>

00000000800061b4 <net_tx_ip>:

// sends an IP packet
void
net_tx_ip(struct mbuf *m, uint8 proto, uint32 dip)
{
    800061b4:	7179                	add	sp,sp,-48
    800061b6:	f406                	sd	ra,40(sp)
    800061b8:	f022                	sd	s0,32(sp)
    800061ba:	ec26                	sd	s1,24(sp)
    800061bc:	e84a                	sd	s2,16(sp)
    800061be:	e44e                	sd	s3,8(sp)
    800061c0:	e052                	sd	s4,0(sp)
    800061c2:	1800                	add	s0,sp,48
    800061c4:	89aa                	mv	s3,a0
    800061c6:	8a2e                	mv	s4,a1
    800061c8:	8932                	mv	s2,a2
  struct ip *iphdr;

  // push the IP header
  iphdr = mbufpushhdr(m, *iphdr);
    800061ca:	45d1                	li	a1,20
    800061cc:	00001097          	auipc	ra,0x1
    800061d0:	e68080e7          	jalr	-408(ra) # 80007034 <mbufpush>
    800061d4:	84aa                	mv	s1,a0
  memset(iphdr, 0, sizeof(*iphdr));
    800061d6:	4651                	li	a2,20
    800061d8:	4581                	li	a1,0
    800061da:	ffffa097          	auipc	ra,0xffffa
    800061de:	fa0080e7          	jalr	-96(ra) # 8000017a <memset>
  iphdr->ip_vhl = (4 << 4) | (20 >> 2);
    800061e2:	04500793          	li	a5,69
    800061e6:	00f48023          	sb	a5,0(s1)
  iphdr->ip_p = proto;
    800061ea:	014484a3          	sb	s4,9(s1)
  iphdr->ip_src = htonl(local_ip);
    800061ee:	00006797          	auipc	a5,0x6
    800061f2:	97a7a783          	lw	a5,-1670(a5) # 8000bb68 <local_ip>
  return (((val & 0x000000ffUL) << 24) |
    800061f6:	0187971b          	sllw	a4,a5,0x18
          ((val & 0xff000000UL) >> 24));
    800061fa:	0187d69b          	srlw	a3,a5,0x18
          ((val & 0x00ff0000UL) >> 8) |
    800061fe:	8f55                	or	a4,a4,a3
          ((val & 0x0000ff00UL) << 8) |
    80006200:	0087969b          	sllw	a3,a5,0x8
    80006204:	00ff0637          	lui	a2,0xff0
    80006208:	8ef1                	and	a3,a3,a2
          ((val & 0x00ff0000UL) >> 8) |
    8000620a:	8f55                	or	a4,a4,a3
    8000620c:	0087d79b          	srlw	a5,a5,0x8
    80006210:	66c1                	lui	a3,0x10
    80006212:	f0068693          	add	a3,a3,-256 # ff00 <_entry-0x7fff0100>
    80006216:	8ff5                	and	a5,a5,a3
    80006218:	8fd9                	or	a5,a5,a4
    8000621a:	c4dc                	sw	a5,12(s1)
  return (((val & 0x000000ffUL) << 24) |
    8000621c:	0189179b          	sllw	a5,s2,0x18
          ((val & 0xff000000UL) >> 24));
    80006220:	0189571b          	srlw	a4,s2,0x18
          ((val & 0x00ff0000UL) >> 8) |
    80006224:	8fd9                	or	a5,a5,a4
          ((val & 0x0000ff00UL) << 8) |
    80006226:	0089171b          	sllw	a4,s2,0x8
    8000622a:	8f71                	and	a4,a4,a2
          ((val & 0x00ff0000UL) >> 8) |
    8000622c:	8fd9                	or	a5,a5,a4
    8000622e:	0089591b          	srlw	s2,s2,0x8
    80006232:	00d97933          	and	s2,s2,a3
    80006236:	0127e7b3          	or	a5,a5,s2
  iphdr->ip_dst = htonl(dip);
    8000623a:	c89c                	sw	a5,16(s1)
  iphdr->ip_len = htons(m->len);
    8000623c:	0109a783          	lw	a5,16(s3)
  return (((val & 0x00ffU) << 8) |
    80006240:	0087971b          	sllw	a4,a5,0x8
    80006244:	0107979b          	sllw	a5,a5,0x10
    80006248:	0107d79b          	srlw	a5,a5,0x10
    8000624c:	0087d79b          	srlw	a5,a5,0x8
    80006250:	8fd9                	or	a5,a5,a4
    80006252:	00f49123          	sh	a5,2(s1)
  iphdr->ip_ttl = 100;
    80006256:	06400793          	li	a5,100
    8000625a:	00f48423          	sb	a5,8(s1)
  iphdr->ip_sum = in_cksum((unsigned char *)iphdr, sizeof(*iphdr));
    8000625e:	45d1                	li	a1,20
    80006260:	8526                	mv	a0,s1
    80006262:	00000097          	auipc	ra,0x0
    80006266:	e6e080e7          	jalr	-402(ra) # 800060d0 <in_cksum>
    8000626a:	00a49523          	sh	a0,10(s1)

  // now on to the ethernet layer
  net_tx_eth(m, ETHTYPE_IP);
    8000626e:	6585                	lui	a1,0x1
    80006270:	80058593          	add	a1,a1,-2048 # 800 <_entry-0x7ffff800>
    80006274:	854e                	mv	a0,s3
    80006276:	00000097          	auipc	ra,0x0
    8000627a:	ec6080e7          	jalr	-314(ra) # 8000613c <net_tx_eth>
}
    8000627e:	70a2                	ld	ra,40(sp)
    80006280:	7402                	ld	s0,32(sp)
    80006282:	64e2                	ld	s1,24(sp)
    80006284:	6942                	ld	s2,16(sp)
    80006286:	69a2                	ld	s3,8(sp)
    80006288:	6a02                	ld	s4,0(sp)
    8000628a:	6145                	add	sp,sp,48
    8000628c:	8082                	ret

000000008000628e <net_tx_udp>:

// sends a UDP packet
void
net_tx_udp(struct mbuf *m, uint32 dip,
           uint16 sport, uint16 dport)
{
    8000628e:	7179                	add	sp,sp,-48
    80006290:	f406                	sd	ra,40(sp)
    80006292:	f022                	sd	s0,32(sp)
    80006294:	ec26                	sd	s1,24(sp)
    80006296:	e84a                	sd	s2,16(sp)
    80006298:	e44e                	sd	s3,8(sp)
    8000629a:	e052                	sd	s4,0(sp)
    8000629c:	1800                	add	s0,sp,48
    8000629e:	89aa                	mv	s3,a0
    800062a0:	8a2e                	mv	s4,a1
    800062a2:	8932                	mv	s2,a2
    800062a4:	84b6                	mv	s1,a3
  struct udp *udphdr;

  // put the UDP header
  udphdr = mbufpushhdr(m, *udphdr);
    800062a6:	45a1                	li	a1,8
    800062a8:	00001097          	auipc	ra,0x1
    800062ac:	d8c080e7          	jalr	-628(ra) # 80007034 <mbufpush>
    800062b0:	0089179b          	sllw	a5,s2,0x8
    800062b4:	0089591b          	srlw	s2,s2,0x8
    800062b8:	0127e7b3          	or	a5,a5,s2
  udphdr->sport = htons(sport);
    800062bc:	00f51023          	sh	a5,0(a0)
    800062c0:	0084979b          	sllw	a5,s1,0x8
    800062c4:	0084d49b          	srlw	s1,s1,0x8
    800062c8:	8fc5                	or	a5,a5,s1
  udphdr->dport = htons(dport);
    800062ca:	00f51123          	sh	a5,2(a0)
  udphdr->ulen = htons(m->len);
    800062ce:	0109a783          	lw	a5,16(s3)
    800062d2:	0087971b          	sllw	a4,a5,0x8
    800062d6:	0107979b          	sllw	a5,a5,0x10
    800062da:	0107d79b          	srlw	a5,a5,0x10
    800062de:	0087d79b          	srlw	a5,a5,0x8
    800062e2:	8fd9                	or	a5,a5,a4
    800062e4:	00f51223          	sh	a5,4(a0)
  udphdr->sum = 0; // zero means no checksum is provided
    800062e8:	00051323          	sh	zero,6(a0)

  // now on to the IP layer
  net_tx_ip(m, IPPROTO_UDP, dip);
    800062ec:	8652                	mv	a2,s4
    800062ee:	45c5                	li	a1,17
    800062f0:	854e                	mv	a0,s3
    800062f2:	00000097          	auipc	ra,0x0
    800062f6:	ec2080e7          	jalr	-318(ra) # 800061b4 <net_tx_ip>
}
    800062fa:	70a2                	ld	ra,40(sp)
    800062fc:	7402                	ld	s0,32(sp)
    800062fe:	64e2                	ld	s1,24(sp)
    80006300:	6942                	ld	s2,16(sp)
    80006302:	69a2                	ld	s3,8(sp)
    80006304:	6a02                	ld	s4,0(sp)
    80006306:	6145                	add	sp,sp,48
    80006308:	8082                	ret

000000008000630a <net_rx>:
}

// called by e1000 driver's interrupt handler to deliver a packet to the
// networking stack
void net_rx(struct mbuf *m)
{
    8000630a:	715d                	add	sp,sp,-80
    8000630c:	e486                	sd	ra,72(sp)
    8000630e:	e0a2                	sd	s0,64(sp)
    80006310:	fc26                	sd	s1,56(sp)
    80006312:	0880                	add	s0,sp,80
    80006314:	84aa                	mv	s1,a0
  struct eth *ethhdr;
  uint16 type;

  m->refcnt++;
    80006316:	6785                	lui	a5,0x1
    80006318:	97aa                	add	a5,a5,a0
    8000631a:	8147a703          	lw	a4,-2028(a5) # 814 <_entry-0x7ffff7ec>
    8000631e:	2705                	addw	a4,a4,1 # 3001 <_entry-0x7fffcfff>
    80006320:	80e7aa23          	sw	a4,-2028(a5)

  ethhdr = mbufpullhdr(m, *ethhdr);
    80006324:	45b9                	li	a1,14
    80006326:	00001097          	auipc	ra,0x1
    8000632a:	ce8080e7          	jalr	-792(ra) # 8000700e <mbufpull>
  if (!ethhdr) {
    8000632e:	c915                	beqz	a0,80006362 <net_rx+0x58>
    mbuffree(m);
    return;
  }

  type = ntohs(ethhdr->type);
    80006330:	00c54683          	lbu	a3,12(a0)
    80006334:	00d54783          	lbu	a5,13(a0)
    80006338:	07a2                	sll	a5,a5,0x8
    8000633a:	00d7e733          	or	a4,a5,a3
  if (type == ETHTYPE_IP)
    8000633e:	46a1                	li	a3,8
    80006340:	02d70763          	beq	a4,a3,8000636e <net_rx+0x64>
    net_rx_ip(m);
  else if (type == ETHTYPE_ARP)
    80006344:	2701                	sext.w	a4,a4
    80006346:	60800793          	li	a5,1544
    8000634a:	1af70863          	beq	a4,a5,800064fa <net_rx+0x1f0>
    net_rx_arp(m);
  else
    mbuffree(m);
    8000634e:	8526                	mv	a0,s1
    80006350:	00001097          	auipc	ra,0x1
    80006354:	ddc080e7          	jalr	-548(ra) # 8000712c <mbuffree>
}
    80006358:	60a6                	ld	ra,72(sp)
    8000635a:	6406                	ld	s0,64(sp)
    8000635c:	74e2                	ld	s1,56(sp)
    8000635e:	6161                	add	sp,sp,80
    80006360:	8082                	ret
    mbuffree(m);
    80006362:	8526                	mv	a0,s1
    80006364:	00001097          	auipc	ra,0x1
    80006368:	dc8080e7          	jalr	-568(ra) # 8000712c <mbuffree>
    return;
    8000636c:	b7f5                	j	80006358 <net_rx+0x4e>
    8000636e:	f84a                	sd	s2,48(sp)
  iphdr = mbufpullhdr(m, *iphdr);
    80006370:	45d1                	li	a1,20
    80006372:	8526                	mv	a0,s1
    80006374:	00001097          	auipc	ra,0x1
    80006378:	c9a080e7          	jalr	-870(ra) # 8000700e <mbufpull>
    8000637c:	892a                	mv	s2,a0
  if (!iphdr)
    8000637e:	16050763          	beqz	a0,800064ec <net_rx+0x1e2>
  if (iphdr->ip_vhl != ((4 << 4) | (20 >> 2)))
    80006382:	00054703          	lbu	a4,0(a0)
    80006386:	04500793          	li	a5,69
    8000638a:	16f71163          	bne	a4,a5,800064ec <net_rx+0x1e2>
  if (in_cksum((unsigned char *)iphdr, sizeof(*iphdr)))
    8000638e:	45d1                	li	a1,20
    80006390:	00000097          	auipc	ra,0x0
    80006394:	d40080e7          	jalr	-704(ra) # 800060d0 <in_cksum>
    80006398:	14051a63          	bnez	a0,800064ec <net_rx+0x1e2>
  if (htons(iphdr->ip_off) != 0)
    8000639c:	00695783          	lhu	a5,6(s2)
    800063a0:	14079663          	bnez	a5,800064ec <net_rx+0x1e2>
  if (htonl(iphdr->ip_dst) != local_ip)
    800063a4:	01092703          	lw	a4,16(s2)
  return (((val & 0x000000ffUL) << 24) |
    800063a8:	0187179b          	sllw	a5,a4,0x18
          ((val & 0xff000000UL) >> 24));
    800063ac:	0187569b          	srlw	a3,a4,0x18
          ((val & 0x00ff0000UL) >> 8) |
    800063b0:	8fd5                	or	a5,a5,a3
          ((val & 0x0000ff00UL) << 8) |
    800063b2:	0087169b          	sllw	a3,a4,0x8
    800063b6:	00ff0637          	lui	a2,0xff0
    800063ba:	8ef1                	and	a3,a3,a2
          ((val & 0x00ff0000UL) >> 8) |
    800063bc:	8fd5                	or	a5,a5,a3
    800063be:	0087571b          	srlw	a4,a4,0x8
    800063c2:	66c1                	lui	a3,0x10
    800063c4:	f0068693          	add	a3,a3,-256 # ff00 <_entry-0x7fff0100>
    800063c8:	8f75                	and	a4,a4,a3
    800063ca:	8fd9                	or	a5,a5,a4
    800063cc:	00005717          	auipc	a4,0x5
    800063d0:	79c72703          	lw	a4,1948(a4) # 8000bb68 <local_ip>
    800063d4:	2781                	sext.w	a5,a5
    800063d6:	10f71b63          	bne	a4,a5,800064ec <net_rx+0x1e2>
  if (iphdr->ip_p != IPPROTO_UDP && iphdr->ip_p != IPPROTO_TCP)
    800063da:	00994783          	lbu	a5,9(s2)
    800063de:	4745                	li	a4,17
    800063e0:	00e78563          	beq	a5,a4,800063ea <net_rx+0xe0>
    800063e4:	4719                	li	a4,6
    800063e6:	10e79363          	bne	a5,a4,800064ec <net_rx+0x1e2>
    800063ea:	f44e                	sd	s3,40(sp)
    800063ec:	f052                	sd	s4,32(sp)
  return (((val & 0x00ffU) << 8) |
    800063ee:	00295783          	lhu	a5,2(s2)
    800063f2:	0087971b          	sllw	a4,a5,0x8
    800063f6:	0087d993          	srl	s3,a5,0x8
    800063fa:	00e9e9b3          	or	s3,s3,a4
    800063fe:	19c2                	sll	s3,s3,0x30
    80006400:	0309d993          	srl	s3,s3,0x30
  len = ntohs(iphdr->ip_len) - sizeof(*iphdr);
    80006404:	fec98a1b          	addw	s4,s3,-20
    80006408:	1a42                	sll	s4,s4,0x30
    8000640a:	030a5a13          	srl	s4,s4,0x30
  mbuftrim(m, m->len - len);
    8000640e:	488c                	lw	a1,16(s1)
    80006410:	414585bb          	subw	a1,a1,s4
    80006414:	8526                	mv	a0,s1
    80006416:	00001097          	auipc	ra,0x1
    8000641a:	c8e080e7          	jalr	-882(ra) # 800070a4 <mbuftrim>
  if (iphdr->ip_p == IPPROTO_UDP) {
    8000641e:	00994783          	lbu	a5,9(s2)
    80006422:	4745                	li	a4,17
    80006424:	00e78963          	beq	a5,a4,80006436 <net_rx+0x12c>
  } else if (iphdr->ip_p == IPPROTO_TCP) {
    80006428:	4719                	li	a4,6
    8000642a:	0ae78663          	beq	a5,a4,800064d6 <net_rx+0x1cc>
    8000642e:	7942                	ld	s2,48(sp)
    80006430:	79a2                	ld	s3,40(sp)
    80006432:	7a02                	ld	s4,32(sp)
    80006434:	b715                	j	80006358 <net_rx+0x4e>
  udphdr = mbufpullhdr(m, *udphdr);
    80006436:	45a1                	li	a1,8
    80006438:	8526                	mv	a0,s1
    8000643a:	00001097          	auipc	ra,0x1
    8000643e:	bd4080e7          	jalr	-1068(ra) # 8000700e <mbufpull>
  if (!udphdr)
    80006442:	c11d                	beqz	a0,80006468 <net_rx+0x15e>
    80006444:	00455783          	lhu	a5,4(a0)
    80006448:	0087971b          	sllw	a4,a5,0x8
    8000644c:	83a1                	srl	a5,a5,0x8
    8000644e:	8fd9                	or	a5,a5,a4
  if (ntohs(udphdr->ulen) != len)
    80006450:	2a01                	sext.w	s4,s4
    80006452:	17c2                	sll	a5,a5,0x30
    80006454:	93c1                	srl	a5,a5,0x30
    80006456:	00fa1963          	bne	s4,a5,80006468 <net_rx+0x15e>
  len -= sizeof(*udphdr);
    8000645a:	fe49879b          	addw	a5,s3,-28
  if (len > m->len)
    8000645e:	17c2                	sll	a5,a5,0x30
    80006460:	93c1                	srl	a5,a5,0x30
    80006462:	4898                	lw	a4,16(s1)
    80006464:	00f77b63          	bgeu	a4,a5,8000647a <net_rx+0x170>
  mbuffree(m);
    80006468:	8526                	mv	a0,s1
    8000646a:	00001097          	auipc	ra,0x1
    8000646e:	cc2080e7          	jalr	-830(ra) # 8000712c <mbuffree>
    80006472:	7942                	ld	s2,48(sp)
    80006474:	79a2                	ld	s3,40(sp)
    80006476:	7a02                	ld	s4,32(sp)
    80006478:	b5c5                	j	80006358 <net_rx+0x4e>
  sip = ntohl(iphdr->ip_src);
    8000647a:	00c92783          	lw	a5,12(s2)
    8000647e:	00055703          	lhu	a4,0(a0)
    80006482:	0087169b          	sllw	a3,a4,0x8
    80006486:	8321                	srl	a4,a4,0x8
    80006488:	8ed9                	or	a3,a3,a4
    8000648a:	00255703          	lhu	a4,2(a0)
    8000648e:	0087161b          	sllw	a2,a4,0x8
    80006492:	8321                	srl	a4,a4,0x8
    80006494:	8e59                	or	a2,a2,a4
  return (((val & 0x000000ffUL) << 24) |
    80006496:	0187959b          	sllw	a1,a5,0x18
          ((val & 0xff000000UL) >> 24));
    8000649a:	0187d71b          	srlw	a4,a5,0x18
          ((val & 0x00ff0000UL) >> 8) |
    8000649e:	8dd9                	or	a1,a1,a4
          ((val & 0x0000ff00UL) << 8) |
    800064a0:	0087971b          	sllw	a4,a5,0x8
    800064a4:	00ff0537          	lui	a0,0xff0
    800064a8:	8f69                	and	a4,a4,a0
          ((val & 0x00ff0000UL) >> 8) |
    800064aa:	8dd9                	or	a1,a1,a4
    800064ac:	0087d79b          	srlw	a5,a5,0x8
    800064b0:	6741                	lui	a4,0x10
    800064b2:	f0070713          	add	a4,a4,-256 # ff00 <_entry-0x7fff0100>
    800064b6:	8ff9                	and	a5,a5,a4
    800064b8:	8ddd                	or	a1,a1,a5
  sockrecvudp(m, sip, dport, sport);
    800064ba:	16c2                	sll	a3,a3,0x30
    800064bc:	92c1                	srl	a3,a3,0x30
    800064be:	1642                	sll	a2,a2,0x30
    800064c0:	9241                	srl	a2,a2,0x30
    800064c2:	2581                	sext.w	a1,a1
    800064c4:	8526                	mv	a0,s1
    800064c6:	00000097          	auipc	ra,0x0
    800064ca:	5d2080e7          	jalr	1490(ra) # 80006a98 <sockrecvudp>
  return;
    800064ce:	7942                	ld	s2,48(sp)
    800064d0:	79a2                	ld	s3,40(sp)
    800064d2:	7a02                	ld	s4,32(sp)
    800064d4:	b551                	j	80006358 <net_rx+0x4e>
    net_rx_tcp(m, len, iphdr);
    800064d6:	864a                	mv	a2,s2
    800064d8:	85d2                	mv	a1,s4
    800064da:	8526                	mv	a0,s1
    800064dc:	00001097          	auipc	ra,0x1
    800064e0:	078080e7          	jalr	120(ra) # 80007554 <net_rx_tcp>
    800064e4:	7942                	ld	s2,48(sp)
    800064e6:	79a2                	ld	s3,40(sp)
    800064e8:	7a02                	ld	s4,32(sp)
    800064ea:	b5bd                	j	80006358 <net_rx+0x4e>
  mbuffree(m);
    800064ec:	8526                	mv	a0,s1
    800064ee:	00001097          	auipc	ra,0x1
    800064f2:	c3e080e7          	jalr	-962(ra) # 8000712c <mbuffree>
    800064f6:	7942                	ld	s2,48(sp)
    800064f8:	b585                	j	80006358 <net_rx+0x4e>
    800064fa:	f84a                	sd	s2,48(sp)
  arphdr = mbufpullhdr(m, *arphdr);
    800064fc:	45f1                	li	a1,28
    800064fe:	8526                	mv	a0,s1
    80006500:	00001097          	auipc	ra,0x1
    80006504:	b0e080e7          	jalr	-1266(ra) # 8000700e <mbufpull>
    80006508:	892a                	mv	s2,a0
  if (!arphdr)
    8000650a:	c14d                	beqz	a0,800065ac <net_rx+0x2a2>
  if (ntohs(arphdr->hrd) != ARP_HRD_ETHER ||
    8000650c:	00054703          	lbu	a4,0(a0) # ff0000 <_entry-0x7f010000>
    80006510:	00154783          	lbu	a5,1(a0)
    80006514:	07a2                	sll	a5,a5,0x8
    80006516:	8fd9                	or	a5,a5,a4
    80006518:	10000713          	li	a4,256
    8000651c:	08e79863          	bne	a5,a4,800065ac <net_rx+0x2a2>
      ntohs(arphdr->pro) != ETHTYPE_IP ||
    80006520:	00254703          	lbu	a4,2(a0)
    80006524:	00354783          	lbu	a5,3(a0)
    80006528:	07a2                	sll	a5,a5,0x8
  if (ntohs(arphdr->hrd) != ARP_HRD_ETHER ||
    8000652a:	8fd9                	or	a5,a5,a4
    8000652c:	4721                	li	a4,8
    8000652e:	06e79f63          	bne	a5,a4,800065ac <net_rx+0x2a2>
      ntohs(arphdr->pro) != ETHTYPE_IP ||
    80006532:	00454703          	lbu	a4,4(a0)
    80006536:	4799                	li	a5,6
    80006538:	06f71a63          	bne	a4,a5,800065ac <net_rx+0x2a2>
      arphdr->hln != ETHADDR_LEN ||
    8000653c:	00554703          	lbu	a4,5(a0)
    80006540:	4791                	li	a5,4
    80006542:	06f71563          	bne	a4,a5,800065ac <net_rx+0x2a2>
  if (ntohs(arphdr->op) != ARP_OP_REQUEST || tip != local_ip)
    80006546:	00654703          	lbu	a4,6(a0)
    8000654a:	00754783          	lbu	a5,7(a0)
    8000654e:	07a2                	sll	a5,a5,0x8
    80006550:	8fd9                	or	a5,a5,a4
    80006552:	10000713          	li	a4,256
    80006556:	04e79b63          	bne	a5,a4,800065ac <net_rx+0x2a2>
  tip = ntohl(arphdr->tip); // target IP address
    8000655a:	01854703          	lbu	a4,24(a0)
    8000655e:	01954783          	lbu	a5,25(a0)
    80006562:	07a2                	sll	a5,a5,0x8
    80006564:	8fd9                	or	a5,a5,a4
    80006566:	01a54703          	lbu	a4,26(a0)
    8000656a:	0742                	sll	a4,a4,0x10
    8000656c:	8f5d                	or	a4,a4,a5
    8000656e:	01b54783          	lbu	a5,27(a0)
    80006572:	07e2                	sll	a5,a5,0x18
    80006574:	8fd9                	or	a5,a5,a4
    80006576:	0007871b          	sext.w	a4,a5
  return (((val & 0x000000ffUL) << 24) |
    8000657a:	0187979b          	sllw	a5,a5,0x18
          ((val & 0xff000000UL) >> 24));
    8000657e:	0187569b          	srlw	a3,a4,0x18
          ((val & 0x00ff0000UL) >> 8) |
    80006582:	8fd5                	or	a5,a5,a3
          ((val & 0x0000ff00UL) << 8) |
    80006584:	0087169b          	sllw	a3,a4,0x8
    80006588:	00ff0637          	lui	a2,0xff0
    8000658c:	8ef1                	and	a3,a3,a2
          ((val & 0x00ff0000UL) >> 8) |
    8000658e:	8fd5                	or	a5,a5,a3
    80006590:	0087571b          	srlw	a4,a4,0x8
    80006594:	66c1                	lui	a3,0x10
    80006596:	f0068693          	add	a3,a3,-256 # ff00 <_entry-0x7fff0100>
    8000659a:	8f75                	and	a4,a4,a3
    8000659c:	8fd9                	or	a5,a5,a4
  if (ntohs(arphdr->op) != ARP_OP_REQUEST || tip != local_ip)
    8000659e:	00005717          	auipc	a4,0x5
    800065a2:	5ca72703          	lw	a4,1482(a4) # 8000bb68 <local_ip>
    800065a6:	2781                	sext.w	a5,a5
    800065a8:	00f70963          	beq	a4,a5,800065ba <net_rx+0x2b0>
  mbuffree(m);
    800065ac:	8526                	mv	a0,s1
    800065ae:	00001097          	auipc	ra,0x1
    800065b2:	b7e080e7          	jalr	-1154(ra) # 8000712c <mbuffree>
}
    800065b6:	7942                	ld	s2,48(sp)
    800065b8:	b345                	j	80006358 <net_rx+0x4e>
    800065ba:	f052                	sd	s4,32(sp)
  memmove(smac, arphdr->sha, ETHADDR_LEN); // sender's ethernet address
    800065bc:	4619                	li	a2,6
    800065be:	00850593          	add	a1,a0,8
    800065c2:	fb840513          	add	a0,s0,-72
    800065c6:	ffffa097          	auipc	ra,0xffffa
    800065ca:	c10080e7          	jalr	-1008(ra) # 800001d6 <memmove>
  sip = ntohl(arphdr->sip); // sender's IP address (qemu's slirp)
    800065ce:	00e94703          	lbu	a4,14(s2)
    800065d2:	00f94783          	lbu	a5,15(s2)
    800065d6:	07a2                	sll	a5,a5,0x8
    800065d8:	8fd9                	or	a5,a5,a4
    800065da:	01094703          	lbu	a4,16(s2)
    800065de:	0742                	sll	a4,a4,0x10
    800065e0:	8f5d                	or	a4,a4,a5
    800065e2:	01194783          	lbu	a5,17(s2)
    800065e6:	07e2                	sll	a5,a5,0x18
    800065e8:	8fd9                	or	a5,a5,a4
    800065ea:	0007871b          	sext.w	a4,a5
  return (((val & 0x000000ffUL) << 24) |
    800065ee:	0187979b          	sllw	a5,a5,0x18
          ((val & 0xff000000UL) >> 24));
    800065f2:	0187569b          	srlw	a3,a4,0x18
          ((val & 0x00ff0000UL) >> 8) |
    800065f6:	8fd5                	or	a5,a5,a3
          ((val & 0x0000ff00UL) << 8) |
    800065f8:	0087169b          	sllw	a3,a4,0x8
    800065fc:	00ff0637          	lui	a2,0xff0
    80006600:	8ef1                	and	a3,a3,a2
          ((val & 0x00ff0000UL) >> 8) |
    80006602:	8fd5                	or	a5,a5,a3
    80006604:	0087571b          	srlw	a4,a4,0x8
    80006608:	66c1                	lui	a3,0x10
    8000660a:	f0068693          	add	a3,a3,-256 # ff00 <_entry-0x7fff0100>
    8000660e:	8f75                	and	a4,a4,a3
    80006610:	8fd9                	or	a5,a5,a4
    80006612:	0007891b          	sext.w	s2,a5
  m = mbufalloc(MBUF_DEFAULT_HEADROOM);
    80006616:	08000513          	li	a0,128
    8000661a:	00001097          	auipc	ra,0x1
    8000661e:	aac080e7          	jalr	-1364(ra) # 800070c6 <mbufalloc>
    80006622:	8a2a                	mv	s4,a0
  if (!m)
    80006624:	cd75                	beqz	a0,80006720 <net_rx+0x416>
    80006626:	f44e                	sd	s3,40(sp)
    80006628:	ec56                	sd	s5,24(sp)
    8000662a:	e85a                	sd	s6,16(sp)
  arphdr = mbufputhdr(m, *arphdr);
    8000662c:	45f1                	li	a1,28
    8000662e:	00001097          	auipc	ra,0x1
    80006632:	a3c080e7          	jalr	-1476(ra) # 8000706a <mbufput>
    80006636:	89aa                	mv	s3,a0
  arphdr->hrd = htons(ARP_HRD_ETHER);
    80006638:	00050023          	sb	zero,0(a0)
    8000663c:	4785                	li	a5,1
    8000663e:	00f500a3          	sb	a5,1(a0)
  arphdr->pro = htons(ETHTYPE_IP);
    80006642:	47a1                	li	a5,8
    80006644:	00f50123          	sb	a5,2(a0)
    80006648:	000501a3          	sb	zero,3(a0)
  arphdr->hln = ETHADDR_LEN;
    8000664c:	4799                	li	a5,6
    8000664e:	00f50223          	sb	a5,4(a0)
  arphdr->pln = sizeof(uint32);
    80006652:	4791                	li	a5,4
    80006654:	00f502a3          	sb	a5,5(a0)
  arphdr->op = htons(op);
    80006658:	00050323          	sb	zero,6(a0)
    8000665c:	4789                	li	a5,2
    8000665e:	00f503a3          	sb	a5,7(a0)
  memmove(arphdr->sha, local_mac, ETHADDR_LEN);
    80006662:	4619                	li	a2,6
    80006664:	00005597          	auipc	a1,0x5
    80006668:	4fc58593          	add	a1,a1,1276 # 8000bb60 <local_mac>
    8000666c:	0521                	add	a0,a0,8
    8000666e:	ffffa097          	auipc	ra,0xffffa
    80006672:	b68080e7          	jalr	-1176(ra) # 800001d6 <memmove>
  arphdr->sip = htonl(local_ip);
    80006676:	00005797          	auipc	a5,0x5
    8000667a:	4f27a783          	lw	a5,1266(a5) # 8000bb68 <local_ip>
  return (((val & 0x000000ffUL) << 24) |
    8000667e:	0187971b          	sllw	a4,a5,0x18
          ((val & 0xff000000UL) >> 24));
    80006682:	0187d69b          	srlw	a3,a5,0x18
          ((val & 0x00ff0000UL) >> 8) |
    80006686:	8f55                	or	a4,a4,a3
          ((val & 0x0000ff00UL) << 8) |
    80006688:	0087969b          	sllw	a3,a5,0x8
    8000668c:	00ff0b37          	lui	s6,0xff0
    80006690:	0166f6b3          	and	a3,a3,s6
          ((val & 0x00ff0000UL) >> 8) |
    80006694:	8f55                	or	a4,a4,a3
    80006696:	0087d79b          	srlw	a5,a5,0x8
    8000669a:	6ac1                	lui	s5,0x10
    8000669c:	f00a8a93          	add	s5,s5,-256 # ff00 <_entry-0x7fff0100>
    800066a0:	0157f7b3          	and	a5,a5,s5
    800066a4:	00e98723          	sb	a4,14(s3)
    800066a8:	83a1                	srl	a5,a5,0x8
    800066aa:	00f987a3          	sb	a5,15(s3)
    800066ae:	0107579b          	srlw	a5,a4,0x10
    800066b2:	00f98823          	sb	a5,16(s3)
    800066b6:	0187571b          	srlw	a4,a4,0x18
    800066ba:	00e988a3          	sb	a4,17(s3)
  memmove(arphdr->tha, dmac, ETHADDR_LEN);
    800066be:	4619                	li	a2,6
    800066c0:	fb840593          	add	a1,s0,-72
    800066c4:	01298513          	add	a0,s3,18
    800066c8:	ffffa097          	auipc	ra,0xffffa
    800066cc:	b0e080e7          	jalr	-1266(ra) # 800001d6 <memmove>
  return (((val & 0x000000ffUL) << 24) |
    800066d0:	0189171b          	sllw	a4,s2,0x18
          ((val & 0xff000000UL) >> 24));
    800066d4:	0189579b          	srlw	a5,s2,0x18
          ((val & 0x00ff0000UL) >> 8) |
    800066d8:	8f5d                	or	a4,a4,a5
          ((val & 0x0000ff00UL) << 8) |
    800066da:	0089179b          	sllw	a5,s2,0x8
    800066de:	0167f7b3          	and	a5,a5,s6
          ((val & 0x00ff0000UL) >> 8) |
    800066e2:	8f5d                	or	a4,a4,a5
    800066e4:	0089579b          	srlw	a5,s2,0x8
    800066e8:	0157f7b3          	and	a5,a5,s5
  arphdr->tip = htonl(dip);
    800066ec:	00e98c23          	sb	a4,24(s3)
    800066f0:	83a1                	srl	a5,a5,0x8
    800066f2:	00f98ca3          	sb	a5,25(s3)
    800066f6:	0107579b          	srlw	a5,a4,0x10
    800066fa:	00f98d23          	sb	a5,26(s3)
    800066fe:	0187571b          	srlw	a4,a4,0x18
    80006702:	00e98da3          	sb	a4,27(s3)
  net_tx_eth(m, ETHTYPE_ARP);
    80006706:	6585                	lui	a1,0x1
    80006708:	80658593          	add	a1,a1,-2042 # 806 <_entry-0x7ffff7fa>
    8000670c:	8552                	mv	a0,s4
    8000670e:	00000097          	auipc	ra,0x0
    80006712:	a2e080e7          	jalr	-1490(ra) # 8000613c <net_tx_eth>
    80006716:	79a2                	ld	s3,40(sp)
    80006718:	7a02                	ld	s4,32(sp)
    8000671a:	6ae2                	ld	s5,24(sp)
    8000671c:	6b42                	ld	s6,16(sp)
  return 0;
    8000671e:	b579                	j	800065ac <net_rx+0x2a2>
    80006720:	7a02                	ld	s4,32(sp)
    80006722:	b569                	j	800065ac <net_rx+0x2a2>

0000000080006724 <sockinit>:
struct spinlock tcpsocks_list_lk;
struct list_head tcpsocks_list_head;

void
sockinit(void)
{
    80006724:	1101                	add	sp,sp,-32
    80006726:	ec06                	sd	ra,24(sp)
    80006728:	e822                	sd	s0,16(sp)
    8000672a:	e426                	sd	s1,8(sp)
    8000672c:	1000                	add	s0,sp,32
  initlock(&udp_lock, "socktbl");
    8000672e:	00039497          	auipc	s1,0x39
    80006732:	c0248493          	add	s1,s1,-1022 # 8003f330 <udp_lock>
    80006736:	00005597          	auipc	a1,0x5
    8000673a:	f8a58593          	add	a1,a1,-118 # 8000b6c0 <etext+0x6c0>
    8000673e:	8526                	mv	a0,s1
    80006740:	00003097          	auipc	ra,0x3
    80006744:	0a2080e7          	jalr	162(ra) # 800097e2 <initlock>

  initlock(&tcpsocks_list_lk, "tcpsocks_list_lk");
    80006748:	00005597          	auipc	a1,0x5
    8000674c:	f8058593          	add	a1,a1,-128 # 8000b6c8 <etext+0x6c8>
    80006750:	00039517          	auipc	a0,0x39
    80006754:	bf850513          	add	a0,a0,-1032 # 8003f348 <tcpsocks_list_lk>
    80006758:	00003097          	auipc	ra,0x3
    8000675c:	08a080e7          	jalr	138(ra) # 800097e2 <initlock>
	struct list_head *prev, *next;
};

static _inline void list_init(struct list_head *head)
{
	head->prev = head->next = head;
    80006760:	00039797          	auipc	a5,0x39
    80006764:	c0078793          	add	a5,a5,-1024 # 8003f360 <tcpsocks_list_head>
    80006768:	fc9c                	sd	a5,56(s1)
    8000676a:	f89c                	sd	a5,48(s1)
  list_init(&tcpsocks_list_head);
  
}
    8000676c:	60e2                	ld	ra,24(sp)
    8000676e:	6442                	ld	s0,16(sp)
    80006770:	64a2                	ld	s1,8(sp)
    80006772:	6105                	add	sp,sp,32
    80006774:	8082                	ret

0000000080006776 <sockalloc>:

int
sockalloc(struct file **f, uint32 raddr, uint16 lport, uint16 rport)
{
    80006776:	7139                	add	sp,sp,-64
    80006778:	fc06                	sd	ra,56(sp)
    8000677a:	f822                	sd	s0,48(sp)
    8000677c:	f426                	sd	s1,40(sp)
    8000677e:	f04a                	sd	s2,32(sp)
    80006780:	ec4e                	sd	s3,24(sp)
    80006782:	e852                	sd	s4,16(sp)
    80006784:	0080                	add	s0,sp,64
    80006786:	892a                	mv	s2,a0
    80006788:	84ae                	mv	s1,a1
    8000678a:	8a32                	mv	s4,a2
    8000678c:	89b6                	mv	s3,a3
  struct sock *si, *pos;

  si = 0;
  *f = 0;
    8000678e:	00053023          	sd	zero,0(a0)
  if ((*f = filealloc()) == 0)
    80006792:	ffffd097          	auipc	ra,0xffffd
    80006796:	21e080e7          	jalr	542(ra) # 800039b0 <filealloc>
    8000679a:	00a93023          	sd	a0,0(s2)
    8000679e:	cd65                	beqz	a0,80006896 <sockalloc+0x120>
    800067a0:	e456                	sd	s5,8(sp)
    goto bad;
  if ((si = (struct sock*)kalloc()) == 0)
    800067a2:	ffffa097          	auipc	ra,0xffffa
    800067a6:	978080e7          	jalr	-1672(ra) # 8000011a <kalloc>
    800067aa:	8aaa                	mv	s5,a0
    800067ac:	c15d                	beqz	a0,80006852 <sockalloc+0xdc>
    goto bad;

  // initialize objects
  si->raddr = raddr;
    800067ae:	c504                	sw	s1,8(a0)
  si->lport = lport;
    800067b0:	01451623          	sh	s4,12(a0)
  si->rport = rport;
    800067b4:	01351723          	sh	s3,14(a0)
  initlock(&si->lock, "sock");
    800067b8:	00005597          	auipc	a1,0x5
    800067bc:	f2858593          	add	a1,a1,-216 # 8000b6e0 <etext+0x6e0>
    800067c0:	0541                	add	a0,a0,16
    800067c2:	00003097          	auipc	ra,0x3
    800067c6:	020080e7          	jalr	32(ra) # 800097e2 <initlock>
  mbufq_init(&si->rxq);
    800067ca:	028a8513          	add	a0,s5,40
    800067ce:	00001097          	auipc	ra,0x1
    800067d2:	9d6080e7          	jalr	-1578(ra) # 800071a4 <mbufq_init>
  (*f)->type = FD_SOCK_UDP;
    800067d6:	00093783          	ld	a5,0(s2)
    800067da:	4711                	li	a4,4
    800067dc:	c398                	sw	a4,0(a5)
  (*f)->readable = 1;
    800067de:	00093703          	ld	a4,0(s2)
    800067e2:	4785                	li	a5,1
    800067e4:	00f70423          	sb	a5,8(a4)
  (*f)->writable = 1;
    800067e8:	00093703          	ld	a4,0(s2)
    800067ec:	00f704a3          	sb	a5,9(a4)
  (*f)->sock = si;
    800067f0:	00093783          	ld	a5,0(s2)
    800067f4:	0357b023          	sd	s5,32(a5)

  // add to list of sockets
  acquire(&udp_lock);
    800067f8:	00039517          	auipc	a0,0x39
    800067fc:	b3850513          	add	a0,a0,-1224 # 8003f330 <udp_lock>
    80006800:	00003097          	auipc	ra,0x3
    80006804:	072080e7          	jalr	114(ra) # 80009872 <acquire>
  pos = udp_sockets;
    80006808:	00006597          	auipc	a1,0x6
    8000680c:	8205b583          	ld	a1,-2016(a1) # 8000c028 <udp_sockets>
  while (pos) {
    80006810:	c9b9                	beqz	a1,80006866 <sockalloc+0xf0>
  pos = udp_sockets;
    80006812:	87ae                	mv	a5,a1
    if (pos->raddr == raddr &&
    80006814:	000a061b          	sext.w	a2,s4
        pos->lport == lport &&
    80006818:	0009869b          	sext.w	a3,s3
    8000681c:	a019                	j	80006822 <sockalloc+0xac>
	pos->rport == rport) {
      release(&udp_lock);
      goto bad;
    }
    pos = pos->next;
    8000681e:	639c                	ld	a5,0(a5)
  while (pos) {
    80006820:	c3b9                	beqz	a5,80006866 <sockalloc+0xf0>
    if (pos->raddr == raddr &&
    80006822:	4798                	lw	a4,8(a5)
    80006824:	fe971de3          	bne	a4,s1,8000681e <sockalloc+0xa8>
    80006828:	00c7d703          	lhu	a4,12(a5)
    8000682c:	fec719e3          	bne	a4,a2,8000681e <sockalloc+0xa8>
        pos->lport == lport &&
    80006830:	00e7d703          	lhu	a4,14(a5)
    80006834:	fed715e3          	bne	a4,a3,8000681e <sockalloc+0xa8>
      release(&udp_lock);
    80006838:	00039517          	auipc	a0,0x39
    8000683c:	af850513          	add	a0,a0,-1288 # 8003f330 <udp_lock>
    80006840:	00003097          	auipc	ra,0x3
    80006844:	0f8080e7          	jalr	248(ra) # 80009938 <release>
  release(&udp_lock);
  return 0;

bad:
  if (si)
    kfree((char*)si);
    80006848:	8556                	mv	a0,s5
    8000684a:	ffff9097          	auipc	ra,0xffff9
    8000684e:	7d2080e7          	jalr	2002(ra) # 8000001c <kfree>
  if (*f)
    80006852:	00093503          	ld	a0,0(s2)
    80006856:	c131                	beqz	a0,8000689a <sockalloc+0x124>
    fileclose(*f);
    80006858:	ffffd097          	auipc	ra,0xffffd
    8000685c:	214080e7          	jalr	532(ra) # 80003a6c <fileclose>
  return -1;
    80006860:	557d                	li	a0,-1
    80006862:	6aa2                	ld	s5,8(sp)
    80006864:	a00d                	j	80006886 <sockalloc+0x110>
  si->next = udp_sockets;
    80006866:	00bab023          	sd	a1,0(s5)
  udp_sockets = si;
    8000686a:	00005797          	auipc	a5,0x5
    8000686e:	7b57bf23          	sd	s5,1982(a5) # 8000c028 <udp_sockets>
  release(&udp_lock);
    80006872:	00039517          	auipc	a0,0x39
    80006876:	abe50513          	add	a0,a0,-1346 # 8003f330 <udp_lock>
    8000687a:	00003097          	auipc	ra,0x3
    8000687e:	0be080e7          	jalr	190(ra) # 80009938 <release>
  return 0;
    80006882:	4501                	li	a0,0
    80006884:	6aa2                	ld	s5,8(sp)
}
    80006886:	70e2                	ld	ra,56(sp)
    80006888:	7442                	ld	s0,48(sp)
    8000688a:	74a2                	ld	s1,40(sp)
    8000688c:	7902                	ld	s2,32(sp)
    8000688e:	69e2                	ld	s3,24(sp)
    80006890:	6a42                	ld	s4,16(sp)
    80006892:	6121                	add	sp,sp,64
    80006894:	8082                	ret
  return -1;
    80006896:	557d                	li	a0,-1
    80006898:	b7fd                	j	80006886 <sockalloc+0x110>
    8000689a:	557d                	li	a0,-1
    8000689c:	6aa2                	ld	s5,8(sp)
    8000689e:	b7e5                	j	80006886 <sockalloc+0x110>

00000000800068a0 <sockclose>:

void
sockclose(struct sock *si)
{
    800068a0:	1101                	add	sp,sp,-32
    800068a2:	ec06                	sd	ra,24(sp)
    800068a4:	e822                	sd	s0,16(sp)
    800068a6:	e426                	sd	s1,8(sp)
    800068a8:	e04a                	sd	s2,0(sp)
    800068aa:	1000                	add	s0,sp,32
    800068ac:	892a                	mv	s2,a0
  struct sock **pos;
  struct mbuf *m;

  // remove from list of sockets
  acquire(&udp_lock);
    800068ae:	00039517          	auipc	a0,0x39
    800068b2:	a8250513          	add	a0,a0,-1406 # 8003f330 <udp_lock>
    800068b6:	00003097          	auipc	ra,0x3
    800068ba:	fbc080e7          	jalr	-68(ra) # 80009872 <acquire>
  pos = &udp_sockets;
    800068be:	00005797          	auipc	a5,0x5
    800068c2:	76a7b783          	ld	a5,1898(a5) # 8000c028 <udp_sockets>
  while (*pos) {
    800068c6:	cb99                	beqz	a5,800068dc <sockclose+0x3c>
    if (*pos == si){
    800068c8:	04f90463          	beq	s2,a5,80006910 <sockclose+0x70>
      *pos = si->next;
      break;
    }
    pos = &(*pos)->next;
    800068cc:	873e                	mv	a4,a5
    800068ce:	639c                	ld	a5,0(a5)
  while (*pos) {
    800068d0:	c791                	beqz	a5,800068dc <sockclose+0x3c>
    if (*pos == si){
    800068d2:	fef91de3          	bne	s2,a5,800068cc <sockclose+0x2c>
      *pos = si->next;
    800068d6:	00093783          	ld	a5,0(s2)
    800068da:	e31c                	sd	a5,0(a4)
  }
  release(&udp_lock);
    800068dc:	00039517          	auipc	a0,0x39
    800068e0:	a5450513          	add	a0,a0,-1452 # 8003f330 <udp_lock>
    800068e4:	00003097          	auipc	ra,0x3
    800068e8:	054080e7          	jalr	84(ra) # 80009938 <release>

  // free any pending mbufs
  while (!mbufq_empty(&si->rxq)) {
    800068ec:	02890493          	add	s1,s2,40
    800068f0:	8526                	mv	a0,s1
    800068f2:	00001097          	auipc	ra,0x1
    800068f6:	8a0080e7          	jalr	-1888(ra) # 80007192 <mbufq_empty>
    800068fa:	e105                	bnez	a0,8000691a <sockclose+0x7a>
    m = mbufq_pophead(&si->rxq);
    800068fc:	8526                	mv	a0,s1
    800068fe:	00001097          	auipc	ra,0x1
    80006902:	87e080e7          	jalr	-1922(ra) # 8000717c <mbufq_pophead>
    mbuffree(m);
    80006906:	00001097          	auipc	ra,0x1
    8000690a:	826080e7          	jalr	-2010(ra) # 8000712c <mbuffree>
    8000690e:	b7cd                	j	800068f0 <sockclose+0x50>
  pos = &udp_sockets;
    80006910:	00005717          	auipc	a4,0x5
    80006914:	71870713          	add	a4,a4,1816 # 8000c028 <udp_sockets>
    80006918:	bf7d                	j	800068d6 <sockclose+0x36>
  }

  kfree((char*)si);
    8000691a:	854a                	mv	a0,s2
    8000691c:	ffff9097          	auipc	ra,0xffff9
    80006920:	700080e7          	jalr	1792(ra) # 8000001c <kfree>
}
    80006924:	60e2                	ld	ra,24(sp)
    80006926:	6442                	ld	s0,16(sp)
    80006928:	64a2                	ld	s1,8(sp)
    8000692a:	6902                	ld	s2,0(sp)
    8000692c:	6105                	add	sp,sp,32
    8000692e:	8082                	ret

0000000080006930 <sockread>:

int
sockread(struct sock *si, uint64 addr, int n)
{
    80006930:	7139                	add	sp,sp,-64
    80006932:	fc06                	sd	ra,56(sp)
    80006934:	f822                	sd	s0,48(sp)
    80006936:	f426                	sd	s1,40(sp)
    80006938:	f04a                	sd	s2,32(sp)
    8000693a:	ec4e                	sd	s3,24(sp)
    8000693c:	e852                	sd	s4,16(sp)
    8000693e:	e456                	sd	s5,8(sp)
    80006940:	0080                	add	s0,sp,64
    80006942:	84aa                	mv	s1,a0
    80006944:	8a2e                	mv	s4,a1
    80006946:	8ab2                	mv	s5,a2
  struct proc *pr = myproc();
    80006948:	ffffa097          	auipc	ra,0xffffa
    8000694c:	5fe080e7          	jalr	1534(ra) # 80000f46 <myproc>
    80006950:	892a                	mv	s2,a0
  struct mbuf *m;
  int len;

  acquire(&si->lock);
    80006952:	01048993          	add	s3,s1,16
    80006956:	854e                	mv	a0,s3
    80006958:	00003097          	auipc	ra,0x3
    8000695c:	f1a080e7          	jalr	-230(ra) # 80009872 <acquire>
  while (mbufq_empty(&si->rxq) && !pr->killed) {
    80006960:	02848493          	add	s1,s1,40
    80006964:	a039                	j	80006972 <sockread+0x42>
    sleep(&si->rxq, &si->lock);
    80006966:	85ce                	mv	a1,s3
    80006968:	8526                	mv	a0,s1
    8000696a:	ffffb097          	auipc	ra,0xffffb
    8000696e:	df4080e7          	jalr	-524(ra) # 8000175e <sleep>
  while (mbufq_empty(&si->rxq) && !pr->killed) {
    80006972:	8526                	mv	a0,s1
    80006974:	00001097          	auipc	ra,0x1
    80006978:	81e080e7          	jalr	-2018(ra) # 80007192 <mbufq_empty>
    8000697c:	c919                	beqz	a0,80006992 <sockread+0x62>
    8000697e:	03092783          	lw	a5,48(s2)
    80006982:	d3f5                	beqz	a5,80006966 <sockread+0x36>
  }
  if (pr->killed) {
    release(&si->lock);
    80006984:	854e                	mv	a0,s3
    80006986:	00003097          	auipc	ra,0x3
    8000698a:	fb2080e7          	jalr	-78(ra) # 80009938 <release>
    return -1;
    8000698e:	59fd                	li	s3,-1
    80006990:	a881                	j	800069e0 <sockread+0xb0>
  if (pr->killed) {
    80006992:	03092783          	lw	a5,48(s2)
    80006996:	f7fd                	bnez	a5,80006984 <sockread+0x54>
  }
  m = mbufq_pophead(&si->rxq);
    80006998:	8526                	mv	a0,s1
    8000699a:	00000097          	auipc	ra,0x0
    8000699e:	7e2080e7          	jalr	2018(ra) # 8000717c <mbufq_pophead>
    800069a2:	84aa                	mv	s1,a0
  release(&si->lock);
    800069a4:	854e                	mv	a0,s3
    800069a6:	00003097          	auipc	ra,0x3
    800069aa:	f92080e7          	jalr	-110(ra) # 80009938 <release>

  len = m->len;
  if (len > n)
    800069ae:	489c                	lw	a5,16(s1)
    800069b0:	89be                	mv	s3,a5
    800069b2:	2781                	sext.w	a5,a5
    800069b4:	00fad363          	bge	s5,a5,800069ba <sockread+0x8a>
    800069b8:	89d6                	mv	s3,s5
    800069ba:	2981                	sext.w	s3,s3
    len = n;
  if (copyout(pr->pagetable, addr, m->head, len) == -1) {
    800069bc:	86ce                	mv	a3,s3
    800069be:	6490                	ld	a2,8(s1)
    800069c0:	85d2                	mv	a1,s4
    800069c2:	05093503          	ld	a0,80(s2)
    800069c6:	ffffa097          	auipc	ra,0xffffa
    800069ca:	1fc080e7          	jalr	508(ra) # 80000bc2 <copyout>
    800069ce:	892a                	mv	s2,a0
    800069d0:	57fd                	li	a5,-1
    800069d2:	02f50163          	beq	a0,a5,800069f4 <sockread+0xc4>
    mbuffree(m);
    return -1;
  }
  mbuffree(m);
    800069d6:	8526                	mv	a0,s1
    800069d8:	00000097          	auipc	ra,0x0
    800069dc:	754080e7          	jalr	1876(ra) # 8000712c <mbuffree>
  return len;
}
    800069e0:	854e                	mv	a0,s3
    800069e2:	70e2                	ld	ra,56(sp)
    800069e4:	7442                	ld	s0,48(sp)
    800069e6:	74a2                	ld	s1,40(sp)
    800069e8:	7902                	ld	s2,32(sp)
    800069ea:	69e2                	ld	s3,24(sp)
    800069ec:	6a42                	ld	s4,16(sp)
    800069ee:	6aa2                	ld	s5,8(sp)
    800069f0:	6121                	add	sp,sp,64
    800069f2:	8082                	ret
    mbuffree(m);
    800069f4:	8526                	mv	a0,s1
    800069f6:	00000097          	auipc	ra,0x0
    800069fa:	736080e7          	jalr	1846(ra) # 8000712c <mbuffree>
    return -1;
    800069fe:	89ca                	mv	s3,s2
    80006a00:	b7c5                	j	800069e0 <sockread+0xb0>

0000000080006a02 <sockwrite>:

int
sockwrite(struct sock *si, uint64 addr, int n)
{
    80006a02:	7139                	add	sp,sp,-64
    80006a04:	fc06                	sd	ra,56(sp)
    80006a06:	f822                	sd	s0,48(sp)
    80006a08:	f04a                	sd	s2,32(sp)
    80006a0a:	ec4e                	sd	s3,24(sp)
    80006a0c:	e852                	sd	s4,16(sp)
    80006a0e:	e456                	sd	s5,8(sp)
    80006a10:	0080                	add	s0,sp,64
    80006a12:	8aaa                	mv	s5,a0
    80006a14:	89ae                	mv	s3,a1
    80006a16:	8932                	mv	s2,a2
  struct proc *pr = myproc();
    80006a18:	ffffa097          	auipc	ra,0xffffa
    80006a1c:	52e080e7          	jalr	1326(ra) # 80000f46 <myproc>
    80006a20:	8a2a                	mv	s4,a0
  struct mbuf *m;

  m = mbufalloc(MBUF_DEFAULT_HEADROOM);
    80006a22:	08000513          	li	a0,128
    80006a26:	00000097          	auipc	ra,0x0
    80006a2a:	6a0080e7          	jalr	1696(ra) # 800070c6 <mbufalloc>
  if (!m)
    80006a2e:	c13d                	beqz	a0,80006a94 <sockwrite+0x92>
    80006a30:	f426                	sd	s1,40(sp)
    80006a32:	84aa                	mv	s1,a0
    return -1;

  if (copyin(pr->pagetable, mbufput(m, n), addr, n) == -1) {
    80006a34:	050a3a03          	ld	s4,80(s4) # 3050 <_entry-0x7fffcfb0>
    80006a38:	85ca                	mv	a1,s2
    80006a3a:	00000097          	auipc	ra,0x0
    80006a3e:	630080e7          	jalr	1584(ra) # 8000706a <mbufput>
    80006a42:	85aa                	mv	a1,a0
    80006a44:	86ca                	mv	a3,s2
    80006a46:	864e                	mv	a2,s3
    80006a48:	8552                	mv	a0,s4
    80006a4a:	ffffa097          	auipc	ra,0xffffa
    80006a4e:	204080e7          	jalr	516(ra) # 80000c4e <copyin>
    80006a52:	89aa                	mv	s3,a0
    80006a54:	57fd                	li	a5,-1
    80006a56:	02f50863          	beq	a0,a5,80006a86 <sockwrite+0x84>
    mbuffree(m);
    return -1;
  }
  net_tx_udp(m, si->raddr, si->lport, si->rport);
    80006a5a:	00ead683          	lhu	a3,14(s5)
    80006a5e:	00cad603          	lhu	a2,12(s5)
    80006a62:	008aa583          	lw	a1,8(s5)
    80006a66:	8526                	mv	a0,s1
    80006a68:	00000097          	auipc	ra,0x0
    80006a6c:	826080e7          	jalr	-2010(ra) # 8000628e <net_tx_udp>
  return n;
    80006a70:	89ca                	mv	s3,s2
    80006a72:	74a2                	ld	s1,40(sp)
}
    80006a74:	854e                	mv	a0,s3
    80006a76:	70e2                	ld	ra,56(sp)
    80006a78:	7442                	ld	s0,48(sp)
    80006a7a:	7902                	ld	s2,32(sp)
    80006a7c:	69e2                	ld	s3,24(sp)
    80006a7e:	6a42                	ld	s4,16(sp)
    80006a80:	6aa2                	ld	s5,8(sp)
    80006a82:	6121                	add	sp,sp,64
    80006a84:	8082                	ret
    mbuffree(m);
    80006a86:	8526                	mv	a0,s1
    80006a88:	00000097          	auipc	ra,0x0
    80006a8c:	6a4080e7          	jalr	1700(ra) # 8000712c <mbuffree>
    return -1;
    80006a90:	74a2                	ld	s1,40(sp)
    80006a92:	b7cd                	j	80006a74 <sockwrite+0x72>
    return -1;
    80006a94:	59fd                	li	s3,-1
    80006a96:	bff9                	j	80006a74 <sockwrite+0x72>

0000000080006a98 <sockrecvudp>:

// called by protocol handler layer to deliver UDP packets
void
sockrecvudp(struct mbuf *m, uint32 raddr, uint16 lport, uint16 rport)
{
    80006a98:	7139                	add	sp,sp,-64
    80006a9a:	fc06                	sd	ra,56(sp)
    80006a9c:	f822                	sd	s0,48(sp)
    80006a9e:	f426                	sd	s1,40(sp)
    80006aa0:	f04a                	sd	s2,32(sp)
    80006aa2:	ec4e                	sd	s3,24(sp)
    80006aa4:	e852                	sd	s4,16(sp)
    80006aa6:	e456                	sd	s5,8(sp)
    80006aa8:	0080                	add	s0,sp,64
    80006aaa:	8a2a                	mv	s4,a0
    80006aac:	892e                	mv	s2,a1
    80006aae:	89b2                	mv	s3,a2
    80006ab0:	8ab6                	mv	s5,a3
  // any sleeping reader. Free the mbuf if there are no sockets
  // registered to handle it.
  //
  struct sock *si;

  acquire(&udp_lock);
    80006ab2:	00039517          	auipc	a0,0x39
    80006ab6:	87e50513          	add	a0,a0,-1922 # 8003f330 <udp_lock>
    80006aba:	00003097          	auipc	ra,0x3
    80006abe:	db8080e7          	jalr	-584(ra) # 80009872 <acquire>
  si = udp_sockets;
    80006ac2:	00005497          	auipc	s1,0x5
    80006ac6:	5664b483          	ld	s1,1382(s1) # 8000c028 <udp_sockets>
  while (si) {
    80006aca:	c4ad                	beqz	s1,80006b34 <sockrecvudp+0x9c>
    if (si->raddr == raddr && si->lport == lport && si->rport == rport)
    80006acc:	0009871b          	sext.w	a4,s3
    80006ad0:	000a869b          	sext.w	a3,s5
    80006ad4:	a019                	j	80006ada <sockrecvudp+0x42>
      goto found;
    si = si->next;
    80006ad6:	6084                	ld	s1,0(s1)
  while (si) {
    80006ad8:	ccb1                	beqz	s1,80006b34 <sockrecvudp+0x9c>
    if (si->raddr == raddr && si->lport == lport && si->rport == rport)
    80006ada:	449c                	lw	a5,8(s1)
    80006adc:	ff279de3          	bne	a5,s2,80006ad6 <sockrecvudp+0x3e>
    80006ae0:	00c4d783          	lhu	a5,12(s1)
    80006ae4:	fee799e3          	bne	a5,a4,80006ad6 <sockrecvudp+0x3e>
    80006ae8:	00e4d783          	lhu	a5,14(s1)
    80006aec:	fed795e3          	bne	a5,a3,80006ad6 <sockrecvudp+0x3e>
  release(&udp_lock);
  mbuffree(m);
  return;

found:
  acquire(&si->lock);
    80006af0:	01048913          	add	s2,s1,16
    80006af4:	854a                	mv	a0,s2
    80006af6:	00003097          	auipc	ra,0x3
    80006afa:	d7c080e7          	jalr	-644(ra) # 80009872 <acquire>
  mbufq_pushtail(&si->rxq, m);
    80006afe:	02848493          	add	s1,s1,40
    80006b02:	85d2                	mv	a1,s4
    80006b04:	8526                	mv	a0,s1
    80006b06:	00000097          	auipc	ra,0x0
    80006b0a:	656080e7          	jalr	1622(ra) # 8000715c <mbufq_pushtail>
  wakeup(&si->rxq);
    80006b0e:	8526                	mv	a0,s1
    80006b10:	ffffb097          	auipc	ra,0xffffb
    80006b14:	dce080e7          	jalr	-562(ra) # 800018de <wakeup>
  release(&si->lock);
    80006b18:	854a                	mv	a0,s2
    80006b1a:	00003097          	auipc	ra,0x3
    80006b1e:	e1e080e7          	jalr	-482(ra) # 80009938 <release>
  release(&udp_lock);
    80006b22:	00039517          	auipc	a0,0x39
    80006b26:	80e50513          	add	a0,a0,-2034 # 8003f330 <udp_lock>
    80006b2a:	00003097          	auipc	ra,0x3
    80006b2e:	e0e080e7          	jalr	-498(ra) # 80009938 <release>
    80006b32:	a831                	j	80006b4e <sockrecvudp+0xb6>
  release(&udp_lock);
    80006b34:	00038517          	auipc	a0,0x38
    80006b38:	7fc50513          	add	a0,a0,2044 # 8003f330 <udp_lock>
    80006b3c:	00003097          	auipc	ra,0x3
    80006b40:	dfc080e7          	jalr	-516(ra) # 80009938 <release>
  mbuffree(m);
    80006b44:	8552                	mv	a0,s4
    80006b46:	00000097          	auipc	ra,0x0
    80006b4a:	5e6080e7          	jalr	1510(ra) # 8000712c <mbuffree>
}
    80006b4e:	70e2                	ld	ra,56(sp)
    80006b50:	7442                	ld	s0,48(sp)
    80006b52:	74a2                	ld	s1,40(sp)
    80006b54:	7902                	ld	s2,32(sp)
    80006b56:	69e2                	ld	s3,24(sp)
    80006b58:	6a42                	ld	s4,16(sp)
    80006b5a:	6aa2                	ld	s5,8(sp)
    80006b5c:	6121                	add	sp,sp,64
    80006b5e:	8082                	ret

0000000080006b60 <pci_init>:
#include "proc.h"
#include "defs.h"

void
pci_init()
{
    80006b60:	715d                	add	sp,sp,-80
    80006b62:	e486                	sd	ra,72(sp)
    80006b64:	e0a2                	sd	s0,64(sp)
    80006b66:	fc26                	sd	s1,56(sp)
    80006b68:	f84a                	sd	s2,48(sp)
    80006b6a:	f44e                	sd	s3,40(sp)
    80006b6c:	f052                	sd	s4,32(sp)
    80006b6e:	ec56                	sd	s5,24(sp)
    80006b70:	e85a                	sd	s6,16(sp)
    80006b72:	e45e                	sd	s7,8(sp)
    80006b74:	0880                	add	s0,sp,80
    80006b76:	300004b7          	lui	s1,0x30000
    uint32 off = (bus << 16) | (dev << 11) | (func << 8) | (offset);
    volatile uint32 *base = ecam + off;
    uint32 id = base[0];
    
    // 100e:8086 is an e1000
    if(id == 0x100e8086){
    80006b7a:	100e8937          	lui	s2,0x100e8
    80006b7e:	08690913          	add	s2,s2,134 # 100e8086 <_entry-0x6ff17f7a>
      // command and status register.
      // bit 0 : I/O access enable
      // bit 1 : memory access enable
      // bit 2 : enable mastering
      base[1] = 7;
    80006b82:	4b9d                	li	s7,7
      for(int i = 0; i < 6; i++){
        uint32 old = base[4+i];

        // writing all 1's to the BAR causes it to be
        // replaced with its size.
        base[4+i] = 0xffffffff;
    80006b84:	5afd                	li	s5,-1
        base[4+i] = old;
      }

      // tell the e1000 to reveal its registers at
      // physical address 0x40000000.
      base[4+0] = e1000_regs;
    80006b86:	40000b37          	lui	s6,0x40000
  for(int dev = 0; dev < 32; dev++){
    80006b8a:	6a09                	lui	s4,0x2
    80006b8c:	300409b7          	lui	s3,0x30040
    80006b90:	a819                	j	80006ba6 <pci_init+0x46>
      base[4+0] = e1000_regs;
    80006b92:	0166a823          	sw	s6,16(a3)

      e1000_init((uint32*)e1000_regs);
    80006b96:	855a                	mv	a0,s6
    80006b98:	fffff097          	auipc	ra,0xfffff
    80006b9c:	180080e7          	jalr	384(ra) # 80005d18 <e1000_init>
  for(int dev = 0; dev < 32; dev++){
    80006ba0:	94d2                	add	s1,s1,s4
    80006ba2:	03348a63          	beq	s1,s3,80006bd6 <pci_init+0x76>
    volatile uint32 *base = ecam + off;
    80006ba6:	86a6                	mv	a3,s1
    uint32 id = base[0];
    80006ba8:	409c                	lw	a5,0(s1)
    80006baa:	2781                	sext.w	a5,a5
    if(id == 0x100e8086){
    80006bac:	ff279ae3          	bne	a5,s2,80006ba0 <pci_init+0x40>
      base[1] = 7;
    80006bb0:	0174a223          	sw	s7,4(s1) # 30000004 <_entry-0x4ffffffc>
      __sync_synchronize();
    80006bb4:	0ff0000f          	fence
      for(int i = 0; i < 6; i++){
    80006bb8:	01048793          	add	a5,s1,16
    80006bbc:	02848613          	add	a2,s1,40
        uint32 old = base[4+i];
    80006bc0:	4398                	lw	a4,0(a5)
    80006bc2:	2701                	sext.w	a4,a4
        base[4+i] = 0xffffffff;
    80006bc4:	0157a023          	sw	s5,0(a5)
        __sync_synchronize();
    80006bc8:	0ff0000f          	fence
        base[4+i] = old;
    80006bcc:	c398                	sw	a4,0(a5)
      for(int i = 0; i < 6; i++){
    80006bce:	0791                	add	a5,a5,4
    80006bd0:	fec798e3          	bne	a5,a2,80006bc0 <pci_init+0x60>
    80006bd4:	bf7d                	j	80006b92 <pci_init+0x32>
    }
  }
}
    80006bd6:	60a6                	ld	ra,72(sp)
    80006bd8:	6406                	ld	s0,64(sp)
    80006bda:	74e2                	ld	s1,56(sp)
    80006bdc:	7942                	ld	s2,48(sp)
    80006bde:	79a2                	ld	s3,40(sp)
    80006be0:	7a02                	ld	s4,32(sp)
    80006be2:	6ae2                	ld	s5,24(sp)
    80006be4:	6b42                	ld	s6,16(sp)
    80006be6:	6ba2                	ld	s7,8(sp)
    80006be8:	6161                	add	sp,sp,80
    80006bea:	8082                	ret

0000000080006bec <hexdump>:

#define isascii(x) ((x >= 0x00) && (x <= 0x7f))
#define isprint(x) ((x >= 0x20) && (x <= 0x7e))

void
hexdump (void *data, uint size) {
    80006bec:	7119                	add	sp,sp,-128
    80006bee:	fc86                	sd	ra,120(sp)
    80006bf0:	f8a2                	sd	s0,112(sp)
    80006bf2:	f0ca                	sd	s2,96(sp)
    80006bf4:	ecce                	sd	s3,88(sp)
    80006bf6:	0100                	add	s0,sp,128
    80006bf8:	892a                	mv	s2,a0
    80006bfa:	89ae                	mv	s3,a1
  int offset, index;
  unsigned char *src;

  src = (unsigned char *)data;
  printf("+------+-------------------------------------------------+------------------+\n");
    80006bfc:	00005517          	auipc	a0,0x5
    80006c00:	aec50513          	add	a0,a0,-1300 # 8000b6e8 <etext+0x6e8>
    80006c04:	00002097          	auipc	ra,0x2
    80006c08:	71e080e7          	jalr	1822(ra) # 80009322 <printf>
  for (offset = 0; offset < size; offset += 16) {
    80006c0c:	18098a63          	beqz	s3,80006da0 <hexdump+0x1b4>
    80006c10:	f4a6                	sd	s1,104(sp)
    80006c12:	e8d2                	sd	s4,80(sp)
    80006c14:	e4d6                	sd	s5,72(sp)
    80006c16:	e0da                	sd	s6,64(sp)
    80006c18:	fc5e                	sd	s7,56(sp)
    80006c1a:	f862                	sd	s8,48(sp)
    80006c1c:	f466                	sd	s9,40(sp)
    80006c1e:	f06a                	sd	s10,32(sp)
    80006c20:	ec6e                	sd	s11,24(sp)
    80006c22:	8d4a                	mv	s10,s2
    80006c24:	0941                	add	s2,s2,16
    80006c26:	fff9879b          	addw	a5,s3,-1 # 3003ffff <_entry-0x4ffc0001>
    80006c2a:	0047d79b          	srlw	a5,a5,0x4
    80006c2e:	0792                	sll	a5,a5,0x4
    80006c30:	97ca                	add	a5,a5,s2
    80006c32:	f8f43423          	sd	a5,-120(s0)
    80006c36:	4d81                	li	s11,0
    printf("| ");
    if (offset <= 0x0fff) printf("0");
    if (offset <= 0x00ff) printf("0");
    if (offset <= 0x000f) printf("0");
    80006c38:	4b3d                	li	s6,15
    printf("%x | ", offset);
    for (index = 0; index < 16; index++) {
      if(offset + index < (int)size) {
    80006c3a:	2981                	sext.w	s3,s3
        if (src[offset + index] <= 0x0f) printf("0");
        printf("%x ", 0xff & src[offset + index]);
    80006c3c:	00005b97          	auipc	s7,0x5
    80006c40:	b14b8b93          	add	s7,s7,-1260 # 8000b750 <etext+0x750>
    80006c44:	aa19                	j	80006d5a <hexdump+0x16e>
    if (offset <= 0x0fff) printf("0");
    80006c46:	00005517          	auipc	a0,0x5
    80006c4a:	afa50513          	add	a0,a0,-1286 # 8000b740 <etext+0x740>
    80006c4e:	00002097          	auipc	ra,0x2
    80006c52:	6d4080e7          	jalr	1748(ra) # 80009322 <printf>
    if (offset <= 0x00ff) printf("0");
    80006c56:	0ff00793          	li	a5,255
    80006c5a:	11b7cb63          	blt	a5,s11,80006d70 <hexdump+0x184>
    80006c5e:	00005517          	auipc	a0,0x5
    80006c62:	ae250513          	add	a0,a0,-1310 # 8000b740 <etext+0x740>
    80006c66:	00002097          	auipc	ra,0x2
    80006c6a:	6bc080e7          	jalr	1724(ra) # 80009322 <printf>
    if (offset <= 0x000f) printf("0");
    80006c6e:	11bb4163          	blt	s6,s11,80006d70 <hexdump+0x184>
    80006c72:	00005517          	auipc	a0,0x5
    80006c76:	ace50513          	add	a0,a0,-1330 # 8000b740 <etext+0x740>
    80006c7a:	00002097          	auipc	ra,0x2
    80006c7e:	6a8080e7          	jalr	1704(ra) # 80009322 <printf>
    80006c82:	a0fd                	j	80006d70 <hexdump+0x184>
        printf("%x ", 0xff & src[offset + index]);
    80006c84:	000ac583          	lbu	a1,0(s5)
    80006c88:	855e                	mv	a0,s7
    80006c8a:	00002097          	auipc	ra,0x2
    80006c8e:	698080e7          	jalr	1688(ra) # 80009322 <printf>
    for (index = 0; index < 16; index++) {
    80006c92:	0485                	add	s1,s1,1
    80006c94:	03248d63          	beq	s1,s2,80006cce <hexdump+0xe2>
      if(offset + index < (int)size) {
    80006c98:	009c07bb          	addw	a5,s8,s1
    80006c9c:	0337d063          	bge	a5,s3,80006cbc <hexdump+0xd0>
        if (src[offset + index] <= 0x0f) printf("0");
    80006ca0:	8aa6                	mv	s5,s1
    80006ca2:	0004c783          	lbu	a5,0(s1)
    80006ca6:	fcfb6fe3          	bltu	s6,a5,80006c84 <hexdump+0x98>
    80006caa:	00005517          	auipc	a0,0x5
    80006cae:	a9650513          	add	a0,a0,-1386 # 8000b740 <etext+0x740>
    80006cb2:	00002097          	auipc	ra,0x2
    80006cb6:	670080e7          	jalr	1648(ra) # 80009322 <printf>
    80006cba:	b7e9                	j	80006c84 <hexdump+0x98>
      } else {
        printf("   ");
    80006cbc:	00005517          	auipc	a0,0x5
    80006cc0:	a9c50513          	add	a0,a0,-1380 # 8000b758 <etext+0x758>
    80006cc4:	00002097          	auipc	ra,0x2
    80006cc8:	65e080e7          	jalr	1630(ra) # 80009322 <printf>
    80006ccc:	b7d9                	j	80006c92 <hexdump+0xa6>
      }
    }
    printf("| ");
    80006cce:	00005517          	auipc	a0,0x5
    80006cd2:	a6a50513          	add	a0,a0,-1430 # 8000b738 <etext+0x738>
    80006cd6:	00002097          	auipc	ra,0x2
    80006cda:	64c080e7          	jalr	1612(ra) # 80009322 <printf>
    80006cde:	84ea                	mv	s1,s10
    for(index = 0; index < 16; index++) {
      if(offset + index < (int)size) {
        if(isascii(src[offset + index]) && isprint(src[offset + index])) {
    80006ce0:	05e00a93          	li	s5,94
          printf("%c", src[offset + index]);
        } else {
          printf(".");
    80006ce4:	00005c97          	auipc	s9,0x5
    80006ce8:	8acc8c93          	add	s9,s9,-1876 # 8000b590 <etext+0x590>
          printf("%c", src[offset + index]);
    80006cec:	00005c17          	auipc	s8,0x5
    80006cf0:	a74c0c13          	add	s8,s8,-1420 # 8000b760 <etext+0x760>
    80006cf4:	a809                	j	80006d06 <hexdump+0x11a>
          printf(".");
    80006cf6:	8566                	mv	a0,s9
    80006cf8:	00002097          	auipc	ra,0x2
    80006cfc:	62a080e7          	jalr	1578(ra) # 80009322 <printf>
    for(index = 0; index < 16; index++) {
    80006d00:	0485                	add	s1,s1,1
    80006d02:	03248d63          	beq	s1,s2,80006d3c <hexdump+0x150>
      if(offset + index < (int)size) {
    80006d06:	014487bb          	addw	a5,s1,s4
    80006d0a:	0337d063          	bge	a5,s3,80006d2a <hexdump+0x13e>
        if(isascii(src[offset + index]) && isprint(src[offset + index])) {
    80006d0e:	0004c583          	lbu	a1,0(s1)
    80006d12:	fe05879b          	addw	a5,a1,-32
    80006d16:	0ff7f793          	zext.b	a5,a5
    80006d1a:	fcfaeee3          	bltu	s5,a5,80006cf6 <hexdump+0x10a>
          printf("%c", src[offset + index]);
    80006d1e:	8562                	mv	a0,s8
    80006d20:	00002097          	auipc	ra,0x2
    80006d24:	602080e7          	jalr	1538(ra) # 80009322 <printf>
    80006d28:	bfe1                	j	80006d00 <hexdump+0x114>
        }
      } else {
        printf(" ");
    80006d2a:	00005517          	auipc	a0,0x5
    80006d2e:	a3e50513          	add	a0,a0,-1474 # 8000b768 <etext+0x768>
    80006d32:	00002097          	auipc	ra,0x2
    80006d36:	5f0080e7          	jalr	1520(ra) # 80009322 <printf>
    80006d3a:	b7d9                	j	80006d00 <hexdump+0x114>
      }
    }
    printf(" |\n");
    80006d3c:	00005517          	auipc	a0,0x5
    80006d40:	a3450513          	add	a0,a0,-1484 # 8000b770 <etext+0x770>
    80006d44:	00002097          	auipc	ra,0x2
    80006d48:	5de080e7          	jalr	1502(ra) # 80009322 <printf>
  for (offset = 0; offset < size; offset += 16) {
    80006d4c:	2dc1                	addw	s11,s11,16
    80006d4e:	0941                	add	s2,s2,16
    80006d50:	0d41                	add	s10,s10,16
    80006d52:	f8843783          	ld	a5,-120(s0)
    80006d56:	02fd0c63          	beq	s10,a5,80006d8e <hexdump+0x1a2>
    printf("| ");
    80006d5a:	00005517          	auipc	a0,0x5
    80006d5e:	9de50513          	add	a0,a0,-1570 # 8000b738 <etext+0x738>
    80006d62:	00002097          	auipc	ra,0x2
    80006d66:	5c0080e7          	jalr	1472(ra) # 80009322 <printf>
    if (offset <= 0x0fff) printf("0");
    80006d6a:	6785                	lui	a5,0x1
    80006d6c:	ecfdcde3          	blt	s11,a5,80006c46 <hexdump+0x5a>
    printf("%x | ", offset);
    80006d70:	85ee                	mv	a1,s11
    80006d72:	00005517          	auipc	a0,0x5
    80006d76:	9d650513          	add	a0,a0,-1578 # 8000b748 <etext+0x748>
    80006d7a:	00002097          	auipc	ra,0x2
    80006d7e:	5a8080e7          	jalr	1448(ra) # 80009322 <printf>
    80006d82:	84ea                	mv	s1,s10
    80006d84:	41ad8c3b          	subw	s8,s11,s10
    80006d88:	000c0a1b          	sext.w	s4,s8
    80006d8c:	b731                	j	80006c98 <hexdump+0xac>
    80006d8e:	74a6                	ld	s1,104(sp)
    80006d90:	6a46                	ld	s4,80(sp)
    80006d92:	6aa6                	ld	s5,72(sp)
    80006d94:	6b06                	ld	s6,64(sp)
    80006d96:	7be2                	ld	s7,56(sp)
    80006d98:	7c42                	ld	s8,48(sp)
    80006d9a:	7ca2                	ld	s9,40(sp)
    80006d9c:	7d02                	ld	s10,32(sp)
    80006d9e:	6de2                	ld	s11,24(sp)
  }
  printf("+------+-------------------------------------------------+------------------+\n");
    80006da0:	00005517          	auipc	a0,0x5
    80006da4:	94850513          	add	a0,a0,-1720 # 8000b6e8 <etext+0x6e8>
    80006da8:	00002097          	auipc	ra,0x2
    80006dac:	57a080e7          	jalr	1402(ra) # 80009322 <printf>
    80006db0:	70e6                	ld	ra,120(sp)
    80006db2:	7446                	ld	s0,112(sp)
    80006db4:	7906                	ld	s2,96(sp)
    80006db6:	69e6                	ld	s3,88(sp)
    80006db8:	6109                	add	sp,sp,128
    80006dba:	8082                	ret

0000000080006dbc <sprintint>:
  return 1;
}

static int
sprintint(char *s, int xx, int base, int sign)
{
    80006dbc:	1101                	add	sp,sp,-32
    80006dbe:	ec22                	sd	s0,24(sp)
    80006dc0:	1000                	add	s0,sp,32
    80006dc2:	882a                	mv	a6,a0
  char buf[16];
  int i, n;
  uint x;

  if(sign && (sign = xx < 0))
    80006dc4:	c299                	beqz	a3,80006dca <sprintint+0xe>
    80006dc6:	0805c263          	bltz	a1,80006e4a <sprintint+0x8e>
    x = -xx;
  else
    x = xx;
    80006dca:	2581                	sext.w	a1,a1
    80006dcc:	4301                	li	t1,0

  i = 0;
    80006dce:	fe040713          	add	a4,s0,-32
    80006dd2:	4501                	li	a0,0
  do {
    buf[i++] = digits[x % base];
    80006dd4:	2601                	sext.w	a2,a2
    80006dd6:	00005697          	auipc	a3,0x5
    80006dda:	cd268693          	add	a3,a3,-814 # 8000baa8 <digits>
    80006dde:	88aa                	mv	a7,a0
    80006de0:	2505                	addw	a0,a0,1
    80006de2:	02c5f7bb          	remuw	a5,a1,a2
    80006de6:	1782                	sll	a5,a5,0x20
    80006de8:	9381                	srl	a5,a5,0x20
    80006dea:	97b6                	add	a5,a5,a3
    80006dec:	0007c783          	lbu	a5,0(a5) # 1000 <_entry-0x7ffff000>
    80006df0:	00f70023          	sb	a5,0(a4)
  } while((x /= base) != 0);
    80006df4:	0005879b          	sext.w	a5,a1
    80006df8:	02c5d5bb          	divuw	a1,a1,a2
    80006dfc:	0705                	add	a4,a4,1
    80006dfe:	fec7f0e3          	bgeu	a5,a2,80006dde <sprintint+0x22>

  if(sign)
    80006e02:	00030b63          	beqz	t1,80006e18 <sprintint+0x5c>
    buf[i++] = '-';
    80006e06:	ff050793          	add	a5,a0,-16
    80006e0a:	97a2                	add	a5,a5,s0
    80006e0c:	02d00713          	li	a4,45
    80006e10:	fee78823          	sb	a4,-16(a5)
    80006e14:	0028851b          	addw	a0,a7,2

  n = 0;
  while(--i >= 0)
    80006e18:	02a05d63          	blez	a0,80006e52 <sprintint+0x96>
    80006e1c:	fe040793          	add	a5,s0,-32
    80006e20:	00a78733          	add	a4,a5,a0
    80006e24:	87c2                	mv	a5,a6
    80006e26:	00180613          	add	a2,a6,1
    80006e2a:	fff5069b          	addw	a3,a0,-1
    80006e2e:	1682                	sll	a3,a3,0x20
    80006e30:	9281                	srl	a3,a3,0x20
    80006e32:	9636                	add	a2,a2,a3
  *s = c;
    80006e34:	fff74683          	lbu	a3,-1(a4)
    80006e38:	00d78023          	sb	a3,0(a5)
  while(--i >= 0)
    80006e3c:	177d                	add	a4,a4,-1
    80006e3e:	0785                	add	a5,a5,1
    80006e40:	fec79ae3          	bne	a5,a2,80006e34 <sprintint+0x78>
    n += sputc(s+n, buf[i]);
  return n;
}
    80006e44:	6462                	ld	s0,24(sp)
    80006e46:	6105                	add	sp,sp,32
    80006e48:	8082                	ret
    x = -xx;
    80006e4a:	40b005bb          	negw	a1,a1
  if(sign && (sign = xx < 0))
    80006e4e:	4305                	li	t1,1
    x = -xx;
    80006e50:	bfbd                	j	80006dce <sprintint+0x12>
  while(--i >= 0)
    80006e52:	4501                	li	a0,0
    80006e54:	bfc5                	j	80006e44 <sprintint+0x88>

0000000080006e56 <snprintf>:

int
snprintf(char *buf, int sz, char *fmt, ...)
{
    80006e56:	7135                	add	sp,sp,-160
    80006e58:	f486                	sd	ra,104(sp)
    80006e5a:	f0a2                	sd	s0,96(sp)
    80006e5c:	1880                	add	s0,sp,112
    80006e5e:	e414                	sd	a3,8(s0)
    80006e60:	e818                	sd	a4,16(s0)
    80006e62:	ec1c                	sd	a5,24(s0)
    80006e64:	03043023          	sd	a6,32(s0)
    80006e68:	03143423          	sd	a7,40(s0)
  va_list ap;
  int i, c;
  int off = 0;
  char *s;

  if (fmt == 0)
    80006e6c:	ce15                	beqz	a2,80006ea8 <snprintf+0x52>
    80006e6e:	eca6                	sd	s1,88(sp)
    80006e70:	e8ca                	sd	s2,80(sp)
    80006e72:	e4ce                	sd	s3,72(sp)
    80006e74:	fc56                	sd	s5,56(sp)
    80006e76:	f85a                	sd	s6,48(sp)
    80006e78:	8b2a                	mv	s6,a0
    80006e7a:	8aae                	mv	s5,a1
    80006e7c:	89b2                	mv	s3,a2
    panic("null fmt");

  va_start(ap, fmt);
    80006e7e:	00840793          	add	a5,s0,8
    80006e82:	f8f43c23          	sd	a5,-104(s0)
  int off = 0;
    80006e86:	4481                	li	s1,0
  for(i = 0; off < sz && (c = fmt[i] & 0xff) != 0; i++){
    80006e88:	4901                	li	s2,0
    80006e8a:	04b05063          	blez	a1,80006eca <snprintf+0x74>
    80006e8e:	e0d2                	sd	s4,64(sp)
    80006e90:	f45e                	sd	s7,40(sp)
    80006e92:	f062                	sd	s8,32(sp)
    80006e94:	ec66                	sd	s9,24(sp)
    if(c != '%'){
    80006e96:	02500a13          	li	s4,37
      continue;
    }
    c = fmt[++i] & 0xff;
    if(c == 0)
      break;
    switch(c){
    80006e9a:	07300b93          	li	s7,115
    80006e9e:	07800c93          	li	s9,120
    80006ea2:	06400c13          	li	s8,100
    80006ea6:	a825                	j	80006ede <snprintf+0x88>
    80006ea8:	eca6                	sd	s1,88(sp)
    80006eaa:	e8ca                	sd	s2,80(sp)
    80006eac:	e4ce                	sd	s3,72(sp)
    80006eae:	e0d2                	sd	s4,64(sp)
    80006eb0:	fc56                	sd	s5,56(sp)
    80006eb2:	f85a                	sd	s6,48(sp)
    80006eb4:	f45e                	sd	s7,40(sp)
    80006eb6:	f062                	sd	s8,32(sp)
    80006eb8:	ec66                	sd	s9,24(sp)
    panic("null fmt");
    80006eba:	00005517          	auipc	a0,0x5
    80006ebe:	8c650513          	add	a0,a0,-1850 # 8000b780 <etext+0x780>
    80006ec2:	00002097          	auipc	ra,0x2
    80006ec6:	416080e7          	jalr	1046(ra) # 800092d8 <panic>
  int off = 0;
    80006eca:	4481                	li	s1,0
    80006ecc:	a8d9                	j	80006fa2 <snprintf+0x14c>
  *s = c;
    80006ece:	009b0733          	add	a4,s6,s1
    80006ed2:	00f70023          	sb	a5,0(a4)
      off += sputc(buf+off, c);
    80006ed6:	2485                	addw	s1,s1,1
  for(i = 0; off < sz && (c = fmt[i] & 0xff) != 0; i++){
    80006ed8:	2905                	addw	s2,s2,1
    80006eda:	1354d563          	bge	s1,s5,80007004 <snprintf+0x1ae>
    80006ede:	012987b3          	add	a5,s3,s2
    80006ee2:	0007c783          	lbu	a5,0(a5)
    80006ee6:	0007871b          	sext.w	a4,a5
    80006eea:	cff5                	beqz	a5,80006fe6 <snprintf+0x190>
    if(c != '%'){
    80006eec:	ff4711e3          	bne	a4,s4,80006ece <snprintf+0x78>
    c = fmt[++i] & 0xff;
    80006ef0:	2905                	addw	s2,s2,1
    80006ef2:	012987b3          	add	a5,s3,s2
    80006ef6:	0007c783          	lbu	a5,0(a5)
    if(c == 0)
    80006efa:	cbfd                	beqz	a5,80006ff0 <snprintf+0x19a>
    switch(c){
    80006efc:	05778c63          	beq	a5,s7,80006f54 <snprintf+0xfe>
    80006f00:	02fbe763          	bltu	s7,a5,80006f2e <snprintf+0xd8>
    80006f04:	0d478063          	beq	a5,s4,80006fc4 <snprintf+0x16e>
    80006f08:	0d879463          	bne	a5,s8,80006fd0 <snprintf+0x17a>
    case 'd':
      off += sprintint(buf+off, va_arg(ap, int), 10, 1);
    80006f0c:	f9843783          	ld	a5,-104(s0)
    80006f10:	00878713          	add	a4,a5,8
    80006f14:	f8e43c23          	sd	a4,-104(s0)
    80006f18:	4685                	li	a3,1
    80006f1a:	4629                	li	a2,10
    80006f1c:	438c                	lw	a1,0(a5)
    80006f1e:	009b0533          	add	a0,s6,s1
    80006f22:	00000097          	auipc	ra,0x0
    80006f26:	e9a080e7          	jalr	-358(ra) # 80006dbc <sprintint>
    80006f2a:	9ca9                	addw	s1,s1,a0
      break;
    80006f2c:	b775                	j	80006ed8 <snprintf+0x82>
    switch(c){
    80006f2e:	0b979163          	bne	a5,s9,80006fd0 <snprintf+0x17a>
    case 'x':
      off += sprintint(buf+off, va_arg(ap, int), 16, 1);
    80006f32:	f9843783          	ld	a5,-104(s0)
    80006f36:	00878713          	add	a4,a5,8
    80006f3a:	f8e43c23          	sd	a4,-104(s0)
    80006f3e:	4685                	li	a3,1
    80006f40:	4641                	li	a2,16
    80006f42:	438c                	lw	a1,0(a5)
    80006f44:	009b0533          	add	a0,s6,s1
    80006f48:	00000097          	auipc	ra,0x0
    80006f4c:	e74080e7          	jalr	-396(ra) # 80006dbc <sprintint>
    80006f50:	9ca9                	addw	s1,s1,a0
      break;
    80006f52:	b759                	j	80006ed8 <snprintf+0x82>
    case 's':
      if((s = va_arg(ap, char*)) == 0)
    80006f54:	f9843783          	ld	a5,-104(s0)
    80006f58:	00878713          	add	a4,a5,8
    80006f5c:	f8e43c23          	sd	a4,-104(s0)
    80006f60:	6388                	ld	a0,0(a5)
    80006f62:	c931                	beqz	a0,80006fb6 <snprintf+0x160>
        s = "(null)";
      for(; *s && off < sz; s++)
    80006f64:	00054703          	lbu	a4,0(a0)
    80006f68:	db25                	beqz	a4,80006ed8 <snprintf+0x82>
    80006f6a:	0954d863          	bge	s1,s5,80006ffa <snprintf+0x1a4>
    80006f6e:	009b06b3          	add	a3,s6,s1
    80006f72:	409a863b          	subw	a2,s5,s1
    80006f76:	1602                	sll	a2,a2,0x20
    80006f78:	9201                	srl	a2,a2,0x20
    80006f7a:	962a                	add	a2,a2,a0
    80006f7c:	87aa                	mv	a5,a0
        off += sputc(buf+off, *s);
    80006f7e:	0014859b          	addw	a1,s1,1
    80006f82:	9d89                	subw	a1,a1,a0
  *s = c;
    80006f84:	00e68023          	sb	a4,0(a3)
        off += sputc(buf+off, *s);
    80006f88:	00f584bb          	addw	s1,a1,a5
      for(; *s && off < sz; s++)
    80006f8c:	0785                	add	a5,a5,1
    80006f8e:	0007c703          	lbu	a4,0(a5)
    80006f92:	d339                	beqz	a4,80006ed8 <snprintf+0x82>
    80006f94:	0685                	add	a3,a3,1
    80006f96:	fec797e3          	bne	a5,a2,80006f84 <snprintf+0x12e>
    80006f9a:	6a06                	ld	s4,64(sp)
    80006f9c:	7ba2                	ld	s7,40(sp)
    80006f9e:	7c02                	ld	s8,32(sp)
    80006fa0:	6ce2                	ld	s9,24(sp)
      off += sputc(buf+off, c);
      break;
    }
  }
  return off;
}
    80006fa2:	8526                	mv	a0,s1
    80006fa4:	64e6                	ld	s1,88(sp)
    80006fa6:	6946                	ld	s2,80(sp)
    80006fa8:	69a6                	ld	s3,72(sp)
    80006faa:	7ae2                	ld	s5,56(sp)
    80006fac:	7b42                	ld	s6,48(sp)
    80006fae:	70a6                	ld	ra,104(sp)
    80006fb0:	7406                	ld	s0,96(sp)
    80006fb2:	610d                	add	sp,sp,160
    80006fb4:	8082                	ret
      for(; *s && off < sz; s++)
    80006fb6:	02800713          	li	a4,40
        s = "(null)";
    80006fba:	00004517          	auipc	a0,0x4
    80006fbe:	7be50513          	add	a0,a0,1982 # 8000b778 <etext+0x778>
    80006fc2:	b765                	j	80006f6a <snprintf+0x114>
  *s = c;
    80006fc4:	009b07b3          	add	a5,s6,s1
    80006fc8:	01478023          	sb	s4,0(a5)
      off += sputc(buf+off, '%');
    80006fcc:	2485                	addw	s1,s1,1
      break;
    80006fce:	b729                	j	80006ed8 <snprintf+0x82>
  *s = c;
    80006fd0:	009b0733          	add	a4,s6,s1
    80006fd4:	01470023          	sb	s4,0(a4)
      off += sputc(buf+off, c);
    80006fd8:	0014871b          	addw	a4,s1,1
  *s = c;
    80006fdc:	975a                	add	a4,a4,s6
    80006fde:	00f70023          	sb	a5,0(a4)
      off += sputc(buf+off, c);
    80006fe2:	2489                	addw	s1,s1,2
      break;
    80006fe4:	bdd5                	j	80006ed8 <snprintf+0x82>
    80006fe6:	6a06                	ld	s4,64(sp)
    80006fe8:	7ba2                	ld	s7,40(sp)
    80006fea:	7c02                	ld	s8,32(sp)
    80006fec:	6ce2                	ld	s9,24(sp)
    80006fee:	bf55                	j	80006fa2 <snprintf+0x14c>
    80006ff0:	6a06                	ld	s4,64(sp)
    80006ff2:	7ba2                	ld	s7,40(sp)
    80006ff4:	7c02                	ld	s8,32(sp)
    80006ff6:	6ce2                	ld	s9,24(sp)
    80006ff8:	b76d                	j	80006fa2 <snprintf+0x14c>
    80006ffa:	6a06                	ld	s4,64(sp)
    80006ffc:	7ba2                	ld	s7,40(sp)
    80006ffe:	7c02                	ld	s8,32(sp)
    80007000:	6ce2                	ld	s9,24(sp)
    80007002:	b745                	j	80006fa2 <snprintf+0x14c>
    80007004:	6a06                	ld	s4,64(sp)
    80007006:	7ba2                	ld	s7,40(sp)
    80007008:	7c02                	ld	s8,32(sp)
    8000700a:	6ce2                	ld	s9,24(sp)
    8000700c:	bf59                	j	80006fa2 <snprintf+0x14c>

000000008000700e <mbufpull>:

// Strips data from the start of the buffer and returns a pointer to it.
// Returns 0 if less than the full requested length is available.
char *
mbufpull(struct mbuf *m, unsigned int len)
{
    8000700e:	1141                	add	sp,sp,-16
    80007010:	e422                	sd	s0,8(sp)
    80007012:	0800                	add	s0,sp,16
    80007014:	87aa                	mv	a5,a0
  char *tmp = m->head;
    80007016:	6508                	ld	a0,8(a0)
  if (m->len < len)
    80007018:	4b98                	lw	a4,16(a5)
    8000701a:	00b76b63          	bltu	a4,a1,80007030 <mbufpull+0x22>
    return 0;
  m->len -= len;
    8000701e:	9f0d                	subw	a4,a4,a1
    80007020:	cb98                	sw	a4,16(a5)
  m->head += len;
    80007022:	1582                	sll	a1,a1,0x20
    80007024:	9181                	srl	a1,a1,0x20
    80007026:	95aa                	add	a1,a1,a0
    80007028:	e78c                	sd	a1,8(a5)
  return tmp;
}
    8000702a:	6422                	ld	s0,8(sp)
    8000702c:	0141                	add	sp,sp,16
    8000702e:	8082                	ret
    return 0;
    80007030:	4501                	li	a0,0
    80007032:	bfe5                	j	8000702a <mbufpull+0x1c>

0000000080007034 <mbufpush>:

// Prepends data to the beginning of the buffer and returns a pointer to it.
char *
mbufpush(struct mbuf *m, unsigned int len)
{
    80007034:	87aa                	mv	a5,a0
  m->head -= len;
    80007036:	02059713          	sll	a4,a1,0x20
    8000703a:	9301                	srl	a4,a4,0x20
    8000703c:	6508                	ld	a0,8(a0)
    8000703e:	8d19                	sub	a0,a0,a4
    80007040:	e788                	sd	a0,8(a5)
  if (m->head < m->buf)
    80007042:	01478713          	add	a4,a5,20
    80007046:	00e56663          	bltu	a0,a4,80007052 <mbufpush+0x1e>
    panic("mbufpush");
  m->len += len;
    8000704a:	4b98                	lw	a4,16(a5)
    8000704c:	9f2d                	addw	a4,a4,a1
    8000704e:	cb98                	sw	a4,16(a5)
  return m->head;
}
    80007050:	8082                	ret
{
    80007052:	1141                	add	sp,sp,-16
    80007054:	e406                	sd	ra,8(sp)
    80007056:	e022                	sd	s0,0(sp)
    80007058:	0800                	add	s0,sp,16
    panic("mbufpush");
    8000705a:	00004517          	auipc	a0,0x4
    8000705e:	73650513          	add	a0,a0,1846 # 8000b790 <etext+0x790>
    80007062:	00002097          	auipc	ra,0x2
    80007066:	276080e7          	jalr	630(ra) # 800092d8 <panic>

000000008000706a <mbufput>:

// Appends data to the end of the buffer and returns a pointer to it.
char *
mbufput(struct mbuf *m, unsigned int len)
{
    8000706a:	87aa                	mv	a5,a0
  char *tmp = m->head + m->len;
    8000706c:	4918                	lw	a4,16(a0)
    8000706e:	02071693          	sll	a3,a4,0x20
    80007072:	9281                	srl	a3,a3,0x20
    80007074:	6508                	ld	a0,8(a0)
    80007076:	9536                	add	a0,a0,a3
  m->len += len;
    80007078:	9f2d                	addw	a4,a4,a1
    8000707a:	0007069b          	sext.w	a3,a4
    8000707e:	cb98                	sw	a4,16(a5)
  if (m->len > MBUF_SIZE)
    80007080:	6785                	lui	a5,0x1
    80007082:	80078793          	add	a5,a5,-2048 # 800 <_entry-0x7ffff800>
    80007086:	00d7e363          	bltu	a5,a3,8000708c <mbufput+0x22>
    panic("mbufput");
  return tmp;
}
    8000708a:	8082                	ret
{
    8000708c:	1141                	add	sp,sp,-16
    8000708e:	e406                	sd	ra,8(sp)
    80007090:	e022                	sd	s0,0(sp)
    80007092:	0800                	add	s0,sp,16
    panic("mbufput");
    80007094:	00004517          	auipc	a0,0x4
    80007098:	70c50513          	add	a0,a0,1804 # 8000b7a0 <etext+0x7a0>
    8000709c:	00002097          	auipc	ra,0x2
    800070a0:	23c080e7          	jalr	572(ra) # 800092d8 <panic>

00000000800070a4 <mbuftrim>:

// Strips data from the end of the buffer and returns a pointer to it.
// Returns 0 if less than the full requested length is available.
char *
mbuftrim(struct mbuf *m, unsigned int len)
{
    800070a4:	1141                	add	sp,sp,-16
    800070a6:	e422                	sd	s0,8(sp)
    800070a8:	0800                	add	s0,sp,16
  if (len > m->len)
    800070aa:	491c                	lw	a5,16(a0)
    800070ac:	00b7eb63          	bltu	a5,a1,800070c2 <mbuftrim+0x1e>
    return 0;
  m->len -= len;
    800070b0:	9f8d                	subw	a5,a5,a1
    800070b2:	c91c                	sw	a5,16(a0)
  return m->head + m->len;
    800070b4:	1782                	sll	a5,a5,0x20
    800070b6:	9381                	srl	a5,a5,0x20
    800070b8:	6508                	ld	a0,8(a0)
    800070ba:	953e                	add	a0,a0,a5
}
    800070bc:	6422                	ld	s0,8(sp)
    800070be:	0141                	add	sp,sp,16
    800070c0:	8082                	ret
    return 0;
    800070c2:	4501                	li	a0,0
    800070c4:	bfe5                	j	800070bc <mbuftrim+0x18>

00000000800070c6 <mbufalloc>:

// Allocates a packet buffer.
struct mbuf *
mbufalloc(unsigned int headroom)
{
    800070c6:	1101                	add	sp,sp,-32
    800070c8:	ec06                	sd	ra,24(sp)
    800070ca:	e822                	sd	s0,16(sp)
    800070cc:	e426                	sd	s1,8(sp)
    800070ce:	1000                	add	s0,sp,32
  struct mbuf *m;
 
  if (headroom > MBUF_SIZE)
    800070d0:	6785                	lui	a5,0x1
    800070d2:	80078793          	add	a5,a5,-2048 # 800 <_entry-0x7ffff800>
    return 0;
    800070d6:	4481                	li	s1,0
  if (headroom > MBUF_SIZE)
    800070d8:	04a7e263          	bltu	a5,a0,8000711c <mbufalloc+0x56>
    800070dc:	e04a                	sd	s2,0(sp)
    800070de:	892a                	mv	s2,a0
  m = kalloc();
    800070e0:	ffff9097          	auipc	ra,0xffff9
    800070e4:	03a080e7          	jalr	58(ra) # 8000011a <kalloc>
    800070e8:	84aa                	mv	s1,a0
  if (m == 0)
    800070ea:	cd1d                	beqz	a0,80007128 <mbufalloc+0x62>
    return 0;
  m->next = 0;
    800070ec:	00053023          	sd	zero,0(a0)
  m->head = (char *)m->buf + headroom;
    800070f0:	0551                	add	a0,a0,20
    800070f2:	1902                	sll	s2,s2,0x20
    800070f4:	02095913          	srl	s2,s2,0x20
    800070f8:	992a                	add	s2,s2,a0
    800070fa:	0124b423          	sd	s2,8(s1)
  m->len = 0;
    800070fe:	0004a823          	sw	zero,16(s1)
  m->refcnt = 0;
    80007102:	6785                	lui	a5,0x1
    80007104:	97a6                	add	a5,a5,s1
    80007106:	8007aa23          	sw	zero,-2028(a5) # 814 <_entry-0x7ffff7ec>
  memset(m->buf, 0, sizeof(m->buf));
    8000710a:	6605                	lui	a2,0x1
    8000710c:	80060613          	add	a2,a2,-2048 # 800 <_entry-0x7ffff800>
    80007110:	4581                	li	a1,0
    80007112:	ffff9097          	auipc	ra,0xffff9
    80007116:	068080e7          	jalr	104(ra) # 8000017a <memset>
  return m;
    8000711a:	6902                	ld	s2,0(sp)
}
    8000711c:	8526                	mv	a0,s1
    8000711e:	60e2                	ld	ra,24(sp)
    80007120:	6442                	ld	s0,16(sp)
    80007122:	64a2                	ld	s1,8(sp)
    80007124:	6105                	add	sp,sp,32
    80007126:	8082                	ret
    80007128:	6902                	ld	s2,0(sp)
    8000712a:	bfcd                	j	8000711c <mbufalloc+0x56>

000000008000712c <mbuffree>:

// Frees a packet buffer.
void
mbuffree(struct mbuf *m)
{
  if (--m->refcnt <= 0)
    8000712c:	6785                	lui	a5,0x1
    8000712e:	97aa                	add	a5,a5,a0
    80007130:	8147a703          	lw	a4,-2028(a5) # 814 <_entry-0x7ffff7ec>
    80007134:	377d                	addw	a4,a4,-1
    80007136:	0007069b          	sext.w	a3,a4
    8000713a:	80e7aa23          	sw	a4,-2028(a5)
    8000713e:	00d05363          	blez	a3,80007144 <mbuffree+0x18>
    80007142:	8082                	ret
{
    80007144:	1141                	add	sp,sp,-16
    80007146:	e406                	sd	ra,8(sp)
    80007148:	e022                	sd	s0,0(sp)
    8000714a:	0800                	add	s0,sp,16
    kfree(m);
    8000714c:	ffff9097          	auipc	ra,0xffff9
    80007150:	ed0080e7          	jalr	-304(ra) # 8000001c <kfree>
}
    80007154:	60a2                	ld	ra,8(sp)
    80007156:	6402                	ld	s0,0(sp)
    80007158:	0141                	add	sp,sp,16
    8000715a:	8082                	ret

000000008000715c <mbufq_pushtail>:

// Pushes an mbuf to the end of the queue.
void
mbufq_pushtail(struct mbufq *q, struct mbuf *m)
{
    8000715c:	1141                	add	sp,sp,-16
    8000715e:	e422                	sd	s0,8(sp)
    80007160:	0800                	add	s0,sp,16
  m->next = 0;
    80007162:	0005b023          	sd	zero,0(a1)
  if (!q->head){
    80007166:	611c                	ld	a5,0(a0)
    80007168:	c799                	beqz	a5,80007176 <mbufq_pushtail+0x1a>
    q->head = q->tail = m;
    return;
  }
  q->tail->next = m;
    8000716a:	651c                	ld	a5,8(a0)
    8000716c:	e38c                	sd	a1,0(a5)
  q->tail = m;
    8000716e:	e50c                	sd	a1,8(a0)
}
    80007170:	6422                	ld	s0,8(sp)
    80007172:	0141                	add	sp,sp,16
    80007174:	8082                	ret
    q->head = q->tail = m;
    80007176:	e50c                	sd	a1,8(a0)
    80007178:	e10c                	sd	a1,0(a0)
    return;
    8000717a:	bfdd                	j	80007170 <mbufq_pushtail+0x14>

000000008000717c <mbufq_pophead>:

// Pops an mbuf from the start of the queue.
struct mbuf *
mbufq_pophead(struct mbufq *q)
{
    8000717c:	1141                	add	sp,sp,-16
    8000717e:	e422                	sd	s0,8(sp)
    80007180:	0800                	add	s0,sp,16
    80007182:	87aa                	mv	a5,a0
  struct mbuf *head = q->head;
    80007184:	6108                	ld	a0,0(a0)
  if (!head)
    80007186:	c119                	beqz	a0,8000718c <mbufq_pophead+0x10>
    return 0;
  q->head = head->next;
    80007188:	6118                	ld	a4,0(a0)
    8000718a:	e398                	sd	a4,0(a5)
  return head;
}
    8000718c:	6422                	ld	s0,8(sp)
    8000718e:	0141                	add	sp,sp,16
    80007190:	8082                	ret

0000000080007192 <mbufq_empty>:

// Returns one (nonzero) if the queue is empty.
int
mbufq_empty(struct mbufq *q)
{
    80007192:	1141                	add	sp,sp,-16
    80007194:	e422                	sd	s0,8(sp)
    80007196:	0800                	add	s0,sp,16
  return q->head == 0;
    80007198:	6108                	ld	a0,0(a0)
}
    8000719a:	00153513          	seqz	a0,a0
    8000719e:	6422                	ld	s0,8(sp)
    800071a0:	0141                	add	sp,sp,16
    800071a2:	8082                	ret

00000000800071a4 <mbufq_init>:

// Intializes a queue of mbufs.
void
mbufq_init(struct mbufq *q)
{
    800071a4:	1141                	add	sp,sp,-16
    800071a6:	e422                	sd	s0,8(sp)
    800071a8:	0800                	add	s0,sp,16
  q->head = 0;
    800071aa:	00053023          	sd	zero,0(a0)
    800071ae:	6422                	ld	s0,8(sp)
    800071b0:	0141                	add	sp,sp,16
    800071b2:	8082                	ret

00000000800071b4 <tcp_dump>:
#include "defs.h"
#include "debug.h"
#include "tcp.h"

void tcp_dump(struct tcp_hdr *tcphdr, struct mbuf *m)
{
    800071b4:	1141                	add	sp,sp,-16
    800071b6:	e422                	sd	s0,8(sp)
    800071b8:	0800                	add	s0,sp,16
  tcpdbg("checksum: 0x%x\n", (tcphdr->checksum));
  tcpdbg("urgptr: 0x%x\n", (tcphdr->urgptr));

  tcpdbg("data len: %d\n", m->len);
  // hexdump(m->head, m->len);
}
    800071ba:	6422                	ld	s0,8(sp)
    800071bc:	0141                	add	sp,sp,16
    800071be:	8082                	ret

00000000800071c0 <tcpsock_dbg>:
    "TCP_LAST_ACK",
    "TCP_TIME_WAIT",
};

void tcpsock_dbg(char *msg, struct tcp_sock *ts)
{
    800071c0:	1141                	add	sp,sp,-16
    800071c2:	e422                	sd	s0,8(sp)
    800071c4:	0800                	add	s0,sp,16
         (ts)->tcb.snd_nxt - (ts)->tcb.iss, (ts)->tcb.snd_wnd,
         (ts)->tcb.snd_wl1, (ts)->tcb.snd_wl2,
         (ts)->tcb.rcv_nxt - (ts)->tcb.irs, (ts)->tcb.rcv_wnd,
         ts->rcv_queue.len, ts->write_queue.len, (ts)->backlog,
         tcp_dbg_states[ts->state]);
}
    800071c6:	6422                	ld	s0,8(sp)
    800071c8:	0141                	add	sp,sp,16
    800071ca:	8082                	ret

00000000800071cc <tcp_set_state>:

void
tcp_set_state(struct tcp_sock *ts, enum tcp_states state)
{
    800071cc:	1141                	add	sp,sp,-16
    800071ce:	e422                	sd	s0,8(sp)
    800071d0:	0800                	add	s0,sp,16
  tcpdbg("state change: %s -> %s\n", tcp_dbg_states[ts->state], tcp_dbg_states[state]);
  ts->state = state;
    800071d2:	08b52e23          	sw	a1,156(a0)
}
    800071d6:	6422                	ld	s0,8(sp)
    800071d8:	0141                	add	sp,sp,16
    800071da:	8082                	ret

00000000800071dc <tcp_hdr_n2h>:

void tcp_hdr_n2h(struct tcp_hdr *tcphdr)
{
    800071dc:	1141                	add	sp,sp,-16
    800071de:	e422                	sd	s0,8(sp)
    800071e0:	0800                	add	s0,sp,16
  return (((val & 0x00ffU) << 8) |
    800071e2:	00055783          	lhu	a5,0(a0)
    800071e6:	0087971b          	sllw	a4,a5,0x8
    800071ea:	83a1                	srl	a5,a5,0x8
    800071ec:	8fd9                	or	a5,a5,a4
  tcphdr->sport = ntohs(tcphdr->sport);
    800071ee:	00f51023          	sh	a5,0(a0)
    800071f2:	00255783          	lhu	a5,2(a0)
    800071f6:	0087971b          	sllw	a4,a5,0x8
    800071fa:	83a1                	srl	a5,a5,0x8
    800071fc:	8fd9                	or	a5,a5,a4
  tcphdr->dport = ntohs(tcphdr->dport);
    800071fe:	00f51123          	sh	a5,2(a0)
  tcphdr->seq = ntohl(tcphdr->seq);
    80007202:	415c                	lw	a5,4(a0)
  return (((val & 0x000000ffUL) << 24) |
    80007204:	0187971b          	sllw	a4,a5,0x18
          ((val & 0xff000000UL) >> 24));
    80007208:	0187d69b          	srlw	a3,a5,0x18
          ((val & 0x00ff0000UL) >> 8) |
    8000720c:	8f55                	or	a4,a4,a3
          ((val & 0x0000ff00UL) << 8) |
    8000720e:	0087969b          	sllw	a3,a5,0x8
    80007212:	00ff05b7          	lui	a1,0xff0
    80007216:	8eed                	and	a3,a3,a1
          ((val & 0x00ff0000UL) >> 8) |
    80007218:	8f55                	or	a4,a4,a3
    8000721a:	0087d79b          	srlw	a5,a5,0x8
    8000721e:	66c1                	lui	a3,0x10
    80007220:	f0068693          	add	a3,a3,-256 # ff00 <_entry-0x7fff0100>
    80007224:	8ff5                	and	a5,a5,a3
    80007226:	8fd9                	or	a5,a5,a4
    80007228:	c15c                	sw	a5,4(a0)
  tcphdr->ack_seq = ntohl(tcphdr->ack_seq);
    8000722a:	451c                	lw	a5,8(a0)
  return (((val & 0x000000ffUL) << 24) |
    8000722c:	0187971b          	sllw	a4,a5,0x18
          ((val & 0xff000000UL) >> 24));
    80007230:	0187d61b          	srlw	a2,a5,0x18
          ((val & 0x00ff0000UL) >> 8) |
    80007234:	8f51                	or	a4,a4,a2
          ((val & 0x0000ff00UL) << 8) |
    80007236:	0087961b          	sllw	a2,a5,0x8
    8000723a:	8e6d                	and	a2,a2,a1
          ((val & 0x00ff0000UL) >> 8) |
    8000723c:	8f51                	or	a4,a4,a2
    8000723e:	0087d79b          	srlw	a5,a5,0x8
    80007242:	8ff5                	and	a5,a5,a3
    80007244:	8fd9                	or	a5,a5,a4
    80007246:	c51c                	sw	a5,8(a0)
  return (((val & 0x00ffU) << 8) |
    80007248:	00e55783          	lhu	a5,14(a0)
    8000724c:	0087971b          	sllw	a4,a5,0x8
    80007250:	83a1                	srl	a5,a5,0x8
    80007252:	8fd9                	or	a5,a5,a4
  tcphdr->window = ntohs(tcphdr->window);
    80007254:	00f51723          	sh	a5,14(a0)
    80007258:	01055783          	lhu	a5,16(a0)
    8000725c:	0087971b          	sllw	a4,a5,0x8
    80007260:	83a1                	srl	a5,a5,0x8
    80007262:	8fd9                	or	a5,a5,a4
  tcphdr->checksum = ntohs(tcphdr->checksum);
    80007264:	00f51823          	sh	a5,16(a0)
  tcphdr->urg = ntohs(tcphdr->urg);
    80007268:	00c55783          	lhu	a5,12(a0)
    8000726c:	7779                	lui	a4,0xffffe
    8000726e:	177d                	add	a4,a4,-1 # ffffffffffffdfff <end+0xffffffff7ffb6a2f>
    80007270:	8ff9                	and	a5,a5,a4
    80007272:	00f51623          	sh	a5,12(a0)
}
    80007276:	6422                	ld	s0,8(sp)
    80007278:	0141                	add	sp,sp,16
    8000727a:	8082                	ret

000000008000727c <tcp_init_segment>:

void tcp_init_segment(struct tcp_hdr *tcphdr, struct mbuf *m)
{
    8000727c:	1101                	add	sp,sp,-32
    8000727e:	ec06                	sd	ra,24(sp)
    80007280:	e822                	sd	s0,16(sp)
    80007282:	e426                	sd	s1,8(sp)
    80007284:	e04a                	sd	s2,0(sp)
    80007286:	1000                	add	s0,sp,32
    80007288:	892a                	mv	s2,a0
    8000728a:	84ae                	mv	s1,a1
  tcp_hdr_n2h(tcphdr);
    8000728c:	00000097          	auipc	ra,0x0
    80007290:	f50080e7          	jalr	-176(ra) # 800071dc <tcp_hdr_n2h>

  //m->len = m->len + tcphdr->syn + tcphdr->fin; // ?
  m->seq = tcphdr->seq;
    80007294:	00492683          	lw	a3,4(s2)
    80007298:	6785                	lui	a5,0x1
    8000729a:	97a6                	add	a5,a5,s1
    8000729c:	80d7ac23          	sw	a3,-2024(a5) # 818 <_entry-0x7ffff7e8>
  m->end_seq = m->seq + m->len;
    800072a0:	4898                	lw	a4,16(s1)
    800072a2:	9f35                	addw	a4,a4,a3
    800072a4:	80e7ae23          	sw	a4,-2020(a5)
}
    800072a8:	60e2                	ld	ra,24(sp)
    800072aa:	6442                	ld	s0,16(sp)
    800072ac:	64a2                	ld	s1,8(sp)
    800072ae:	6902                	ld	s2,0(sp)
    800072b0:	6105                	add	sp,sp,32
    800072b2:	8082                	ret

00000000800072b4 <tcp_sock_lookup_establish>:


struct tcp_sock *
tcp_sock_lookup_establish(uint src, uint dst, uint16 sport, uint16 dport)
{
    800072b4:	7179                	add	sp,sp,-48
    800072b6:	f406                	sd	ra,40(sp)
    800072b8:	f022                	sd	s0,32(sp)
    800072ba:	ec26                	sd	s1,24(sp)
    800072bc:	e84a                	sd	s2,16(sp)
    800072be:	e44e                	sd	s3,8(sp)
    800072c0:	e052                	sd	s4,0(sp)
    800072c2:	1800                	add	s0,sp,48
    800072c4:	892a                	mv	s2,a0
    800072c6:	89b2                	mv	s3,a2
    800072c8:	8a36                	mv	s4,a3
  struct tcp_sock *tcpsock = NULL, *s;
  acquire(&tcpsocks_list_lk);
    800072ca:	00038517          	auipc	a0,0x38
    800072ce:	07e50513          	add	a0,a0,126 # 8003f348 <tcpsocks_list_lk>
    800072d2:	00002097          	auipc	ra,0x2
    800072d6:	5a0080e7          	jalr	1440(ra) # 80009872 <acquire>
  
  list_for_each_entry(s, &tcpsocks_list_head, tcpsock_list) {
    800072da:	00038797          	auipc	a5,0x38
    800072de:	08678793          	add	a5,a5,134 # 8003f360 <tcpsocks_list_head>
    800072e2:	6784                	ld	s1,8(a5)
    800072e4:	04f48963          	beq	s1,a5,80007336 <tcp_sock_lookup_establish+0x82>
    // tcpdbg("s->sport: %d   s->dport: %d\n", s->sport, s->dport);
    if (src == s->daddr && sport == s->dport && dport == s->sport) {
    800072e8:	0009861b          	sext.w	a2,s3
    800072ec:	000a069b          	sext.w	a3,s4
  list_for_each_entry(s, &tcpsocks_list_head, tcpsock_list) {
    800072f0:	873e                	mv	a4,a5
    800072f2:	a021                	j	800072fa <tcp_sock_lookup_establish+0x46>
    800072f4:	6484                	ld	s1,8(s1)
    800072f6:	00e48e63          	beq	s1,a4,80007312 <tcp_sock_lookup_establish+0x5e>
    if (src == s->daddr && sport == s->dport && dport == s->sport) {
    800072fa:	48dc                	lw	a5,20(s1)
    800072fc:	ff279ce3          	bne	a5,s2,800072f4 <tcp_sock_lookup_establish+0x40>
    80007300:	01a4d783          	lhu	a5,26(s1)
    80007304:	fec798e3          	bne	a5,a2,800072f4 <tcp_sock_lookup_establish+0x40>
    80007308:	0184d783          	lhu	a5,24(s1)
    8000730c:	fed794e3          	bne	a5,a3,800072f4 <tcp_sock_lookup_establish+0x40>
    80007310:	a011                	j	80007314 <tcp_sock_lookup_establish+0x60>
  struct tcp_sock *tcpsock = NULL, *s;
    80007312:	4481                	li	s1,0
      // tcpdbg("find establish\n");
      break;
    }
  }

  release(&tcpsocks_list_lk);
    80007314:	00038517          	auipc	a0,0x38
    80007318:	03450513          	add	a0,a0,52 # 8003f348 <tcpsocks_list_lk>
    8000731c:	00002097          	auipc	ra,0x2
    80007320:	61c080e7          	jalr	1564(ra) # 80009938 <release>

  return tcpsock;
}
    80007324:	8526                	mv	a0,s1
    80007326:	70a2                	ld	ra,40(sp)
    80007328:	7402                	ld	s0,32(sp)
    8000732a:	64e2                	ld	s1,24(sp)
    8000732c:	6942                	ld	s2,16(sp)
    8000732e:	69a2                	ld	s3,8(sp)
    80007330:	6a02                	ld	s4,0(sp)
    80007332:	6145                	add	sp,sp,48
    80007334:	8082                	ret
  struct tcp_sock *tcpsock = NULL, *s;
    80007336:	4481                	li	s1,0
    80007338:	bff1                	j	80007314 <tcp_sock_lookup_establish+0x60>

000000008000733a <tcp_sock_lookup_listen>:


struct tcp_sock *
tcp_sock_lookup_listen(uint dst, uint16 dport)
{
    8000733a:	1101                	add	sp,sp,-32
    8000733c:	ec06                	sd	ra,24(sp)
    8000733e:	e822                	sd	s0,16(sp)
    80007340:	e426                	sd	s1,8(sp)
    80007342:	e04a                	sd	s2,0(sp)
    80007344:	1000                	add	s0,sp,32
    80007346:	892e                	mv	s2,a1
  struct tcp_sock *tcpsock = NULL, *s;
  acquire(&tcpsocks_list_lk);
    80007348:	00038517          	auipc	a0,0x38
    8000734c:	00050513          	mv	a0,a0
    80007350:	00002097          	auipc	ra,0x2
    80007354:	522080e7          	jalr	1314(ra) # 80009872 <acquire>
  
  list_for_each_entry(s, &tcpsocks_list_head, tcpsock_list) {
    80007358:	00038797          	auipc	a5,0x38
    8000735c:	00878793          	add	a5,a5,8 # 8003f360 <tcpsocks_list_head>
    80007360:	6784                	ld	s1,8(a5)
    80007362:	04f48163          	beq	s1,a5,800073a4 <tcp_sock_lookup_listen+0x6a>
    if (dport == s->sport && s->state == TCP_LISTEN) {
    80007366:	0009059b          	sext.w	a1,s2
  list_for_each_entry(s, &tcpsocks_list_head, tcpsock_list) {
    8000736a:	873e                	mv	a4,a5
    8000736c:	a021                	j	80007374 <tcp_sock_lookup_listen+0x3a>
    8000736e:	6484                	ld	s1,8(s1)
    80007370:	00e48a63          	beq	s1,a4,80007384 <tcp_sock_lookup_listen+0x4a>
    if (dport == s->sport && s->state == TCP_LISTEN) {
    80007374:	0184d783          	lhu	a5,24(s1)
    80007378:	feb79be3          	bne	a5,a1,8000736e <tcp_sock_lookup_listen+0x34>
    8000737c:	09c4a783          	lw	a5,156(s1)
    80007380:	f7fd                	bnez	a5,8000736e <tcp_sock_lookup_listen+0x34>
    80007382:	a011                	j	80007386 <tcp_sock_lookup_listen+0x4c>
  struct tcp_sock *tcpsock = NULL, *s;
    80007384:	4481                	li	s1,0
      tcpsock = s;
      break;
    }
  }

  release(&tcpsocks_list_lk);
    80007386:	00038517          	auipc	a0,0x38
    8000738a:	fc250513          	add	a0,a0,-62 # 8003f348 <tcpsocks_list_lk>
    8000738e:	00002097          	auipc	ra,0x2
    80007392:	5aa080e7          	jalr	1450(ra) # 80009938 <release>

  return tcpsock;
}
    80007396:	8526                	mv	a0,s1
    80007398:	60e2                	ld	ra,24(sp)
    8000739a:	6442                	ld	s0,16(sp)
    8000739c:	64a2                	ld	s1,8(sp)
    8000739e:	6902                	ld	s2,0(sp)
    800073a0:	6105                	add	sp,sp,32
    800073a2:	8082                	ret
  struct tcp_sock *tcpsock = NULL, *s;
    800073a4:	4481                	li	s1,0
    800073a6:	b7c5                	j	80007386 <tcp_sock_lookup_listen+0x4c>

00000000800073a8 <tcp_sock_lookup>:

struct tcp_sock *
tcp_sock_lookup(uint src, uint dst, uint16 sport, uint16 dport)
{
    800073a8:	1101                	add	sp,sp,-32
    800073aa:	ec06                	sd	ra,24(sp)
    800073ac:	e822                	sd	s0,16(sp)
    800073ae:	e426                	sd	s1,8(sp)
    800073b0:	e04a                	sd	s2,0(sp)
    800073b2:	1000                	add	s0,sp,32
    800073b4:	84ae                	mv	s1,a1
    800073b6:	8936                	mv	s2,a3
  struct tcp_sock *tcpsock = NULL;
  tcpdbg("look: sport: %d, dport: %d\n", sport, dport);
  tcpsock = tcp_sock_lookup_establish(src, dst, sport, dport);
    800073b8:	00000097          	auipc	ra,0x0
    800073bc:	efc080e7          	jalr	-260(ra) # 800072b4 <tcp_sock_lookup_establish>
  if (!tcpsock)
    800073c0:	c519                	beqz	a0,800073ce <tcp_sock_lookup+0x26>
    tcpsock = tcp_sock_lookup_listen(dst, dport);

  return tcpsock;
}
    800073c2:	60e2                	ld	ra,24(sp)
    800073c4:	6442                	ld	s0,16(sp)
    800073c6:	64a2                	ld	s1,8(sp)
    800073c8:	6902                	ld	s2,0(sp)
    800073ca:	6105                	add	sp,sp,32
    800073cc:	8082                	ret
    tcpsock = tcp_sock_lookup_listen(dst, dport);
    800073ce:	85ca                	mv	a1,s2
    800073d0:	8526                	mv	a0,s1
    800073d2:	00000097          	auipc	ra,0x0
    800073d6:	f68080e7          	jalr	-152(ra) # 8000733a <tcp_sock_lookup_listen>
  return tcpsock;
    800073da:	b7e5                	j	800073c2 <tcp_sock_lookup+0x1a>

00000000800073dc <tcp_free>:

void
tcp_free(struct tcp_sock *ts)
{
    800073dc:	1101                	add	sp,sp,-32
    800073de:	ec06                	sd	ra,24(sp)
    800073e0:	e822                	sd	s0,16(sp)
    800073e2:	e426                	sd	s1,8(sp)
    800073e4:	e04a                	sd	s2,0(sp)
    800073e6:	1000                	add	s0,sp,32
    800073e8:	84aa                	mv	s1,a0
  acquire(&tcpsocks_list_lk);
    800073ea:	00038517          	auipc	a0,0x38
    800073ee:	f5e50513          	add	a0,a0,-162 # 8003f348 <tcpsocks_list_lk>
    800073f2:	00002097          	auipc	ra,0x2
    800073f6:	480080e7          	jalr	1152(ra) # 80009872 <acquire>
	next->prev = prev;
}

static _inline void list_del(struct list_head *list)
{
	__list_del(list->prev, list->next);
    800073fa:	6098                	ld	a4,0(s1)
    800073fc:	649c                	ld	a5,8(s1)
	prev->next = next;
    800073fe:	e71c                	sd	a5,8(a4)
	next->prev = prev;
    80007400:	e398                	sd	a4,0(a5)
	list->prev = NULL;
    80007402:	0004b023          	sd	zero,0(s1)
	list->next = NULL;
    80007406:	0004b423          	sd	zero,8(s1)
  list_del(&ts->tcpsock_list);
  release(&tcpsocks_list_lk);
    8000740a:	00038517          	auipc	a0,0x38
    8000740e:	f3e50513          	add	a0,a0,-194 # 8003f348 <tcpsocks_list_lk>
    80007412:	00002097          	auipc	ra,0x2
    80007416:	526080e7          	jalr	1318(ra) # 80009938 <release>
}

static _inline struct mbuf *
mbuf_queue_peek(struct mbuf_queue *q)
{
  if (mbuf_queue_empty(q))
    8000741a:	0b84a783          	lw	a5,184(s1)
    8000741e:	cb95                	beqz	a5,80007452 <tcp_free+0x76>
    return NULL;
  return list_first_entry(&q->head, struct mbuf, list);
    80007420:	797d                	lui	s2,0xfffff
    80007422:	7e090913          	add	s2,s2,2016 # fffffffffffff7e0 <end+0xffffffff7ffb8210>
    80007426:	78c8                	ld	a0,176(s1)
	__list_del(list->prev, list->next);
    80007428:	6118                	ld	a4,0(a0)
    8000742a:	651c                	ld	a5,8(a0)
	prev->next = next;
    8000742c:	e71c                	sd	a5,8(a4)
	next->prev = prev;
    8000742e:	e398                	sd	a4,0(a5)
	list->prev = NULL;
    80007430:	00053023          	sd	zero,0(a0)
	list->next = NULL;
    80007434:	00053423          	sd	zero,8(a0)
  q->len--;
    80007438:	0b84a783          	lw	a5,184(s1)
    8000743c:	37fd                	addw	a5,a5,-1
    8000743e:	0af4ac23          	sw	a5,184(s1)
{
  struct mbuf *m = NULL;
  
  while ((m = mbuf_queue_peek(q)) != NULL) {
    mbuf_dequeue(q);
    mbuffree(m);
    80007442:	954a                	add	a0,a0,s2
    80007444:	00000097          	auipc	ra,0x0
    80007448:	ce8080e7          	jalr	-792(ra) # 8000712c <mbuffree>
  if (mbuf_queue_empty(q))
    8000744c:	0b84a783          	lw	a5,184(s1)
    80007450:	fbf9                	bnez	a5,80007426 <tcp_free+0x4a>
    80007452:	0d04a783          	lw	a5,208(s1)
    80007456:	cb95                	beqz	a5,8000748a <tcp_free+0xae>
  return list_first_entry(&q->head, struct mbuf, list);
    80007458:	797d                	lui	s2,0xfffff
    8000745a:	7e090913          	add	s2,s2,2016 # fffffffffffff7e0 <end+0xffffffff7ffb8210>
    8000745e:	64e8                	ld	a0,200(s1)
	__list_del(list->prev, list->next);
    80007460:	6118                	ld	a4,0(a0)
    80007462:	651c                	ld	a5,8(a0)
	prev->next = next;
    80007464:	e71c                	sd	a5,8(a4)
	next->prev = prev;
    80007466:	e398                	sd	a4,0(a5)
	list->prev = NULL;
    80007468:	00053023          	sd	zero,0(a0)
	list->next = NULL;
    8000746c:	00053423          	sd	zero,8(a0)
  q->len--;
    80007470:	0d04a783          	lw	a5,208(s1)
    80007474:	37fd                	addw	a5,a5,-1
    80007476:	0cf4a823          	sw	a5,208(s1)
    mbuffree(m);
    8000747a:	954a                	add	a0,a0,s2
    8000747c:	00000097          	auipc	ra,0x0
    80007480:	cb0080e7          	jalr	-848(ra) # 8000712c <mbuffree>
  if (mbuf_queue_empty(q))
    80007484:	0d04a783          	lw	a5,208(s1)
    80007488:	fbf9                	bnez	a5,8000745e <tcp_free+0x82>
    8000748a:	0e84a783          	lw	a5,232(s1)
    8000748e:	cb95                	beqz	a5,800074c2 <tcp_free+0xe6>
  return list_first_entry(&q->head, struct mbuf, list);
    80007490:	797d                	lui	s2,0xfffff
    80007492:	7e090913          	add	s2,s2,2016 # fffffffffffff7e0 <end+0xffffffff7ffb8210>
    80007496:	70e8                	ld	a0,224(s1)
	__list_del(list->prev, list->next);
    80007498:	6118                	ld	a4,0(a0)
    8000749a:	651c                	ld	a5,8(a0)
	prev->next = next;
    8000749c:	e71c                	sd	a5,8(a4)
	next->prev = prev;
    8000749e:	e398                	sd	a4,0(a5)
	list->prev = NULL;
    800074a0:	00053023          	sd	zero,0(a0)
	list->next = NULL;
    800074a4:	00053423          	sd	zero,8(a0)
  q->len--;
    800074a8:	0e84a783          	lw	a5,232(s1)
    800074ac:	37fd                	addw	a5,a5,-1
    800074ae:	0ef4a423          	sw	a5,232(s1)
    mbuffree(m);
    800074b2:	954a                	add	a0,a0,s2
    800074b4:	00000097          	auipc	ra,0x0
    800074b8:	c78080e7          	jalr	-904(ra) # 8000712c <mbuffree>
  if (mbuf_queue_empty(q))
    800074bc:	0e84a783          	lw	a5,232(s1)
    800074c0:	fbf9                	bnez	a5,80007496 <tcp_free+0xba>
  // clear timer
  // clear queue
  mbuf_queue_free(&ts->ofo_queue);
  mbuf_queue_free(&ts->rcv_queue);
  mbuf_queue_free(&ts->write_queue);
}
    800074c2:	60e2                	ld	ra,24(sp)
    800074c4:	6442                	ld	s0,16(sp)
    800074c6:	64a2                	ld	s1,8(sp)
    800074c8:	6902                	ld	s2,0(sp)
    800074ca:	6105                	add	sp,sp,32
    800074cc:	8082                	ret

00000000800074ce <tcp_sock_free>:

void 
tcp_sock_free(struct tcp_sock *ts)
{
    800074ce:	1141                	add	sp,sp,-16
    800074d0:	e406                	sd	ra,8(sp)
    800074d2:	e022                	sd	s0,0(sp)
    800074d4:	0800                	add	s0,sp,16
  kfree(ts);
    800074d6:	ffff9097          	auipc	ra,0xffff9
    800074da:	b46080e7          	jalr	-1210(ra) # 8000001c <kfree>
}
    800074de:	60a2                	ld	ra,8(sp)
    800074e0:	6402                	ld	s0,0(sp)
    800074e2:	0141                	add	sp,sp,16
    800074e4:	8082                	ret

00000000800074e6 <tcp_done>:

void 
tcp_done(struct tcp_sock *ts)
{
    800074e6:	1101                	add	sp,sp,-32
    800074e8:	ec06                	sd	ra,24(sp)
    800074ea:	e822                	sd	s0,16(sp)
    800074ec:	e426                	sd	s1,8(sp)
    800074ee:	1000                	add	s0,sp,32
    800074f0:	84aa                	mv	s1,a0
  ts->state = state;
    800074f2:	4799                	li	a5,6
    800074f4:	08f52e23          	sw	a5,156(a0)
  tcp_set_state(ts, TCP_CLOSE);
  tcp_free(ts);
    800074f8:	00000097          	auipc	ra,0x0
    800074fc:	ee4080e7          	jalr	-284(ra) # 800073dc <tcp_free>
  kfree(ts);
    80007500:	8526                	mv	a0,s1
    80007502:	ffff9097          	auipc	ra,0xffff9
    80007506:	b1a080e7          	jalr	-1254(ra) # 8000001c <kfree>
  tcp_sock_free(ts);
  tcpdbg("tcp done !!!\n");
}
    8000750a:	60e2                	ld	ra,24(sp)
    8000750c:	6442                	ld	s0,16(sp)
    8000750e:	64a2                	ld	s1,8(sp)
    80007510:	6105                	add	sp,sp,32
    80007512:	8082                	ret

0000000080007514 <get_test_tcpsock>:

struct tcp_sock *
get_test_tcpsock(uint16 sport, uint16 dport)
{
    80007514:	1101                	add	sp,sp,-32
    80007516:	ec06                	sd	ra,24(sp)
    80007518:	e822                	sd	s0,16(sp)
    8000751a:	e426                	sd	s1,8(sp)
    8000751c:	e04a                	sd	s2,0(sp)
    8000751e:	1000                	add	s0,sp,32
    80007520:	892a                	mv	s2,a0
    80007522:	84ae                	mv	s1,a1
  struct tcp_sock *tcpsock = (struct tcp_sock *)kalloc();
    80007524:	ffff9097          	auipc	ra,0xffff9
    80007528:	bf6080e7          	jalr	-1034(ra) # 8000011a <kalloc>
  list_init(&q->head);
    8000752c:	0c050713          	add	a4,a0,192
	head->prev = head->next = head;
    80007530:	e578                	sd	a4,200(a0)
    80007532:	e178                	sd	a4,192(a0)
    80007534:	0d850713          	add	a4,a0,216
    80007538:	f178                	sd	a4,224(a0)
    8000753a:	ed78                	sd	a4,216(a0)
  mbuf_queue_init(&tcpsock->rcv_queue);
  mbuf_queue_init(&tcpsock->write_queue);
  tcpsock->state = TCP_LISTEN;
    8000753c:	08052e23          	sw	zero,156(a0)
  tcpsock->sport = sport;
    80007540:	01251c23          	sh	s2,24(a0)
  tcpsock->dport = dport;
    80007544:	00951d23          	sh	s1,26(a0)

  return tcpsock;
}
    80007548:	60e2                	ld	ra,24(sp)
    8000754a:	6442                	ld	s0,16(sp)
    8000754c:	64a2                	ld	s1,8(sp)
    8000754e:	6902                	ld	s2,0(sp)
    80007550:	6105                	add	sp,sp,32
    80007552:	8082                	ret

0000000080007554 <net_rx_tcp>:

// iphdr is network bytes order
void net_rx_tcp(struct mbuf *m, uint16 len, struct ip *iphdr)
{
    80007554:	7139                	add	sp,sp,-64
    80007556:	fc06                	sd	ra,56(sp)
    80007558:	f822                	sd	s0,48(sp)
    8000755a:	f426                	sd	s1,40(sp)
    8000755c:	f04a                	sd	s2,32(sp)
    8000755e:	ec4e                	sd	s3,24(sp)
    80007560:	e852                	sd	s4,16(sp)
    80007562:	0080                	add	s0,sp,64
    80007564:	892a                	mv	s2,a0
    80007566:	89b2                	mv	s3,a2
  struct tcp_hdr *tcphdr;

  tcphdr = mbufpullhdr(m, *tcphdr);
    80007568:	45d1                	li	a1,20
    8000756a:	00000097          	auipc	ra,0x0
    8000756e:	aa4080e7          	jalr	-1372(ra) # 8000700e <mbufpull>
    80007572:	84aa                	mv	s1,a0
  // ignore tcp options
  if (tcphdr->doff > TCP_MIN_DATA_OFF)
    80007574:	455c                	lw	a5,12(a0)
    80007576:	0047d79b          	srlw	a5,a5,0x4
    8000757a:	8bbd                	and	a5,a5,15
    8000757c:	4715                	li	a4,5
    8000757e:	02f77763          	bgeu	a4,a5,800075ac <net_rx_tcp+0x58>
  {
    m->head += (tcphdr->doff - TCP_MIN_DATA_OFF) * 4;
    80007582:	37ed                	addw	a5,a5,-5
    80007584:	0027979b          	sllw	a5,a5,0x2
    80007588:	00893703          	ld	a4,8(s2)
    8000758c:	97ba                	add	a5,a5,a4
    8000758e:	00f93423          	sd	a5,8(s2)
    m->len -= (tcphdr->doff - TCP_MIN_DATA_OFF) * 4;
    80007592:	455c                	lw	a5,12(a0)
    80007594:	0047d79b          	srlw	a5,a5,0x4
    80007598:	8bbd                	and	a5,a5,15
    8000759a:	37ed                	addw	a5,a5,-5
    8000759c:	0027979b          	sllw	a5,a5,0x2
    800075a0:	01092703          	lw	a4,16(s2)
    800075a4:	40f707bb          	subw	a5,a4,a5
    800075a8:	00f92823          	sw	a5,16(s2)
  }

  tcp_init_segment(tcphdr, m);
    800075ac:	85ca                	mv	a1,s2
    800075ae:	8526                	mv	a0,s1
    800075b0:	00000097          	auipc	ra,0x0
    800075b4:	ccc080e7          	jalr	-820(ra) # 8000727c <tcp_init_segment>

#ifdef TCP_DEBUG
  // tcp_dump(tcphdr, m);
#endif

  uint src = ntohl(iphdr->ip_src);
    800075b8:	00c9a783          	lw	a5,12(s3)
  uint dst = ntohl(iphdr->ip_dst);
    800075bc:	0109a703          	lw	a4,16(s3)
  return (((val & 0x000000ffUL) << 24) |
    800075c0:	0187159b          	sllw	a1,a4,0x18
          ((val & 0xff000000UL) >> 24));
    800075c4:	0187569b          	srlw	a3,a4,0x18
          ((val & 0x00ff0000UL) >> 8) |
    800075c8:	8dd5                	or	a1,a1,a3
          ((val & 0x0000ff00UL) << 8) |
    800075ca:	0087169b          	sllw	a3,a4,0x8
    800075ce:	00ff0637          	lui	a2,0xff0
    800075d2:	8ef1                	and	a3,a3,a2
          ((val & 0x00ff0000UL) >> 8) |
    800075d4:	8dd5                	or	a1,a1,a3
    800075d6:	0087571b          	srlw	a4,a4,0x8
    800075da:	66c1                	lui	a3,0x10
    800075dc:	f0068693          	add	a3,a3,-256 # ff00 <_entry-0x7fff0100>
    800075e0:	8f75                	and	a4,a4,a3
    800075e2:	8dd9                	or	a1,a1,a4
  return (((val & 0x000000ffUL) << 24) |
    800075e4:	0187951b          	sllw	a0,a5,0x18
          ((val & 0xff000000UL) >> 24));
    800075e8:	0187d71b          	srlw	a4,a5,0x18
          ((val & 0x00ff0000UL) >> 8) |
    800075ec:	8d59                	or	a0,a0,a4
          ((val & 0x0000ff00UL) << 8) |
    800075ee:	0087971b          	sllw	a4,a5,0x8
    800075f2:	8f71                	and	a4,a4,a2
          ((val & 0x00ff0000UL) >> 8) |
    800075f4:	8d59                	or	a0,a0,a4
    800075f6:	0087d79b          	srlw	a5,a5,0x8
    800075fa:	8ff5                	and	a5,a5,a3
    800075fc:	8d5d                	or	a0,a0,a5

  struct tcp_sock *tcpsock = tcp_sock_lookup(src, dst, tcphdr->sport, tcphdr->dport);
    800075fe:	0024d683          	lhu	a3,2(s1)
    80007602:	0004d603          	lhu	a2,0(s1)
    80007606:	2581                	sext.w	a1,a1
    80007608:	2501                	sext.w	a0,a0
    8000760a:	00000097          	auipc	ra,0x0
    8000760e:	d9e080e7          	jalr	-610(ra) # 800073a8 <tcp_sock_lookup>
    80007612:	8a2a                	mv	s4,a0

  if (tcpsock == NULL) {
    80007614:	c91d                	beqz	a0,8000764a <net_rx_tcp+0xf6>
    80007616:	e456                	sd	s5,8(sp)
  //     tcpdbg("not found socket ! sport: %d, dport: %d\n", tcphdr->sport, tcphdr->dport);
  //     mbuffree(m);
  //     return;
  // }

  acquire(&tcpsock->spinlk);
    80007618:	0f050a93          	add	s5,a0,240
    8000761c:	8556                	mv	a0,s5
    8000761e:	00002097          	auipc	ra,0x2
    80007622:	254080e7          	jalr	596(ra) # 80009872 <acquire>
  tcpdbg("***************************\n");
  int r = tcp_input_state(tcpsock, tcphdr, iphdr, m);
    80007626:	86ca                	mv	a3,s2
    80007628:	864e                	mv	a2,s3
    8000762a:	85a6                	mv	a1,s1
    8000762c:	8552                	mv	a0,s4
    8000762e:	00000097          	auipc	ra,0x0
    80007632:	5b8080e7          	jalr	1464(ra) # 80007be6 <tcp_input_state>
  tcpdbg("***************************\n");
  if (!r) release(&tcpsock->spinlk);
    80007636:	c105                	beqz	a0,80007656 <net_rx_tcp+0x102>
    80007638:	6aa2                	ld	s5,8(sp)

}
    8000763a:	70e2                	ld	ra,56(sp)
    8000763c:	7442                	ld	s0,48(sp)
    8000763e:	74a2                	ld	s1,40(sp)
    80007640:	7902                	ld	s2,32(sp)
    80007642:	69e2                	ld	s3,24(sp)
    80007644:	6a42                	ld	s4,16(sp)
    80007646:	6121                	add	sp,sp,64
    80007648:	8082                	ret
    mbuffree(m);
    8000764a:	854a                	mv	a0,s2
    8000764c:	00000097          	auipc	ra,0x0
    80007650:	ae0080e7          	jalr	-1312(ra) # 8000712c <mbuffree>
    return;
    80007654:	b7dd                	j	8000763a <net_rx_tcp+0xe6>
  if (!r) release(&tcpsock->spinlk);
    80007656:	8556                	mv	a0,s5
    80007658:	00002097          	auipc	ra,0x2
    8000765c:	2e0080e7          	jalr	736(ra) # 80009938 <release>
    80007660:	6aa2                	ld	s5,8(sp)
    80007662:	bfe1                	j	8000763a <net_rx_tcp+0xe6>

0000000080007664 <sum_every_16bits>:
#include "debug.h"
#include "tcp.h"

uint32 
sum_every_16bits(void *addr, int count)
{
    80007664:	1141                	add	sp,sp,-16
    80007666:	e422                	sd	s0,8(sp)
    80007668:	0800                	add	s0,sp,16
    8000766a:	87aa                	mv	a5,a0
    register uint32 sum = 0;
    uint16 * ptr = addr;
    
    while( count > 1 )  {
    8000766c:	4705                	li	a4,1
    8000766e:	04b75063          	bge	a4,a1,800076ae <sum_every_16bits+0x4a>
    80007672:	ffe5861b          	addw	a2,a1,-2 # fefffe <_entry-0x7f010002>
    80007676:	0016561b          	srlw	a2,a2,0x1
    8000767a:	0016069b          	addw	a3,a2,1 # ff0001 <_entry-0x7f00ffff>
    8000767e:	02069713          	sll	a4,a3,0x20
    80007682:	01f75693          	srl	a3,a4,0x1f
    80007686:	96aa                	add	a3,a3,a0
    register uint32 sum = 0;
    80007688:	4501                	li	a0,0
        /*  This is the inner loop */
        sum += * ptr++;
    8000768a:	0789                	add	a5,a5,2
    8000768c:	ffe7d703          	lhu	a4,-2(a5)
    80007690:	9d39                	addw	a0,a0,a4
    while( count > 1 )  {
    80007692:	fed79ce3          	bne	a5,a3,8000768a <sum_every_16bits+0x26>
    80007696:	35f9                	addw	a1,a1,-2
    80007698:	0016161b          	sllw	a2,a2,0x1
    8000769c:	9d91                	subw	a1,a1,a2
        count -= 2;
    }

    /*  Add left-over byte, if any */
    if( count > 0 )
    8000769e:	00b05563          	blez	a1,800076a8 <sum_every_16bits+0x44>
        sum += * (uint8 *) ptr;
    800076a2:	0006c783          	lbu	a5,0(a3)
    800076a6:	9d3d                	addw	a0,a0,a5

    return sum;
}
    800076a8:	6422                	ld	s0,8(sp)
    800076aa:	0141                	add	sp,sp,16
    800076ac:	8082                	ret
    uint16 * ptr = addr;
    800076ae:	86aa                	mv	a3,a0
    register uint32 sum = 0;
    800076b0:	4501                	li	a0,0
    800076b2:	b7f5                	j	8000769e <sum_every_16bits+0x3a>

00000000800076b4 <checksum>:

uint16 
checksum(void *addr, int count, int start_sum)
{
    800076b4:	1101                	add	sp,sp,-32
    800076b6:	ec06                	sd	ra,24(sp)
    800076b8:	e822                	sd	s0,16(sp)
    800076ba:	e426                	sd	s1,8(sp)
    800076bc:	1000                	add	s0,sp,32
    /* Compute Internet Checksum for "count" bytes
     *         beginning at location "addr".
     * Taken from https://tools.ietf.org/html/rfc1071
     */
    uint32 sum = start_sum;
    800076be:	84b2                	mv	s1,a2

    sum += sum_every_16bits(addr, count);
    800076c0:	00000097          	auipc	ra,0x0
    800076c4:	fa4080e7          	jalr	-92(ra) # 80007664 <sum_every_16bits>
    800076c8:	00a487bb          	addw	a5,s1,a0
    800076cc:	0007851b          	sext.w	a0,a5
    
    /*  Fold 32-bit sum to 16 bits */
    while (sum>>16)
    800076d0:	0107d79b          	srlw	a5,a5,0x10
    800076d4:	cb91                	beqz	a5,800076e8 <checksum+0x34>
        sum = (sum & 0xffff) + (sum >> 16);
    800076d6:	6741                	lui	a4,0x10
    800076d8:	177d                	add	a4,a4,-1 # ffff <_entry-0x7fff0001>
    800076da:	8d79                	and	a0,a0,a4
    800076dc:	9fa9                	addw	a5,a5,a0
    800076de:	0007851b          	sext.w	a0,a5
    while (sum>>16)
    800076e2:	0107d79b          	srlw	a5,a5,0x10
    800076e6:	fbf5                	bnez	a5,800076da <checksum+0x26>

    return ~sum;
    800076e8:	fff54513          	not	a0,a0
}
    800076ec:	1542                	sll	a0,a0,0x30
    800076ee:	9141                	srl	a0,a0,0x30
    800076f0:	60e2                	ld	ra,24(sp)
    800076f2:	6442                	ld	s0,16(sp)
    800076f4:	64a2                	ld	s1,8(sp)
    800076f6:	6105                	add	sp,sp,32
    800076f8:	8082                	ret

00000000800076fa <tcp_v4_checksum>:

int
tcp_v4_checksum(struct mbuf *m, uint32 saddr, uint32 daddr)
{
    800076fa:	1141                	add	sp,sp,-16
    800076fc:	e406                	sd	ra,8(sp)
    800076fe:	e022                	sd	s0,0(sp)
    80007700:	0800                	add	s0,sp,16
  uint32 sum = 0;
  
  sum += saddr;
  sum += daddr;
  sum += htons(IPPROTO_TCP);
    80007702:	6006079b          	addw	a5,a2,1536
    80007706:	9fad                	addw	a5,a5,a1
  sum += htons(m->len);
    80007708:	490c                	lw	a1,16(a0)
  return (((val & 0x00ffU) << 8) |
    8000770a:	0085961b          	sllw	a2,a1,0x8
    8000770e:	0105971b          	sllw	a4,a1,0x10
    80007712:	0107571b          	srlw	a4,a4,0x10
    80007716:	0087571b          	srlw	a4,a4,0x8
    8000771a:	8e59                	or	a2,a2,a4
    8000771c:	0106161b          	sllw	a2,a2,0x10
    80007720:	0106561b          	srlw	a2,a2,0x10

  return checksum(m->head, m->len, sum);
    80007724:	9e3d                	addw	a2,a2,a5
    80007726:	6508                	ld	a0,8(a0)
    80007728:	00000097          	auipc	ra,0x0
    8000772c:	f8c080e7          	jalr	-116(ra) # 800076b4 <checksum>
}
    80007730:	2501                	sext.w	a0,a0
    80007732:	60a2                	ld	ra,8(sp)
    80007734:	6402                	ld	s0,0(sp)
    80007736:	0141                	add	sp,sp,16
    80007738:	8082                	ret

000000008000773a <tcp_transmit_mbuf>:

// th is the pointer of tcp_hdr in mbuf.
void 
tcp_transmit_mbuf(struct tcp_sock *ts, struct tcp_hdr *th, struct mbuf *m, uint32 seq)
{
    8000773a:	7179                	add	sp,sp,-48
    8000773c:	f406                	sd	ra,40(sp)
    8000773e:	f022                	sd	s0,32(sp)
    80007740:	ec26                	sd	s1,24(sp)
    80007742:	e84a                	sd	s2,16(sp)
    80007744:	e44e                	sd	s3,8(sp)
    80007746:	1800                	add	s0,sp,48
    80007748:	892a                	mv	s2,a0
    8000774a:	84ae                	mv	s1,a1
    8000774c:	89b2                	mv	s3,a2
  th->doff = TCP_DOFFSET;
    8000774e:	00c5d783          	lhu	a5,12(a1)
    80007752:	f0f7f793          	and	a5,a5,-241
    80007756:	0507e793          	or	a5,a5,80
    8000775a:	00f59623          	sh	a5,12(a1)
  th->sport = ts->sport;
    8000775e:	01855603          	lhu	a2,24(a0)
    80007762:	00c59023          	sh	a2,0(a1)
  th->dport = ts->dport;
    80007766:	01a55703          	lhu	a4,26(a0)
    8000776a:	00e59123          	sh	a4,2(a1)
  th->seq = seq;
    8000776e:	c1d4                	sw	a3,4(a1)
  th->ack_seq = ts->tcb.rcv_nxt;
    80007770:	08c52783          	lw	a5,140(a0)
    80007774:	c59c                	sw	a5,8(a1)
  th->reserved = 0;
    80007776:	00c5d583          	lhu	a1,12(a1)
    8000777a:	99c1                	and	a1,a1,-16
    8000777c:	00b49623          	sh	a1,12(s1)
  th->window = ts->tcb.rcv_wnd;
    80007780:	09055583          	lhu	a1,144(a0)
  th->checksum = 0;
    80007784:	00049823          	sh	zero,16(s1)
  th->urg = 0;
    80007788:	00c4d503          	lhu	a0,12(s1)
    8000778c:	7879                	lui	a6,0xffffe
    8000778e:	187d                	add	a6,a6,-1 # ffffffffffffdfff <end+0xffffffff7ffb6a2f>
    80007790:	01057533          	and	a0,a0,a6
    80007794:	00a49623          	sh	a0,12(s1)
    80007798:	0086151b          	sllw	a0,a2,0x8
    8000779c:	0086561b          	srlw	a2,a2,0x8
    800077a0:	8e49                	or	a2,a2,a0

  // tcpdbg("tcp_transmit...\n");
  // tcp_dump(th, m);

  th->sport = htons(th->sport);
    800077a2:	00c49023          	sh	a2,0(s1)
    800077a6:	0087161b          	sllw	a2,a4,0x8
    800077aa:	0087571b          	srlw	a4,a4,0x8
    800077ae:	8f51                	or	a4,a4,a2
  th->dport = htons(th->dport);
    800077b0:	00e49123          	sh	a4,2(s1)
  return (((val & 0x000000ffUL) << 24) |
    800077b4:	0186971b          	sllw	a4,a3,0x18
          ((val & 0xff000000UL) >> 24));
    800077b8:	0186d61b          	srlw	a2,a3,0x18
          ((val & 0x00ff0000UL) >> 8) |
    800077bc:	8f51                	or	a4,a4,a2
          ((val & 0x0000ff00UL) << 8) |
    800077be:	0086961b          	sllw	a2,a3,0x8
    800077c2:	00ff0837          	lui	a6,0xff0
    800077c6:	01067633          	and	a2,a2,a6
          ((val & 0x00ff0000UL) >> 8) |
    800077ca:	8f51                	or	a4,a4,a2
    800077cc:	0086d69b          	srlw	a3,a3,0x8
    800077d0:	6541                	lui	a0,0x10
    800077d2:	f0050513          	add	a0,a0,-256 # ff00 <_entry-0x7fff0100>
    800077d6:	8ee9                	and	a3,a3,a0
    800077d8:	8f55                	or	a4,a4,a3
  th->seq = htonl(th->seq);
    800077da:	c0d8                	sw	a4,4(s1)
  return (((val & 0x000000ffUL) << 24) |
    800077dc:	0187971b          	sllw	a4,a5,0x18
          ((val & 0xff000000UL) >> 24));
    800077e0:	0187d69b          	srlw	a3,a5,0x18
          ((val & 0x00ff0000UL) >> 8) |
    800077e4:	8f55                	or	a4,a4,a3
          ((val & 0x0000ff00UL) << 8) |
    800077e6:	0087969b          	sllw	a3,a5,0x8
    800077ea:	0106f6b3          	and	a3,a3,a6
          ((val & 0x00ff0000UL) >> 8) |
    800077ee:	8f55                	or	a4,a4,a3
    800077f0:	0087d79b          	srlw	a5,a5,0x8
    800077f4:	8fe9                	and	a5,a5,a0
    800077f6:	8fd9                	or	a5,a5,a4
  th->ack_seq = htonl(th->ack_seq);
    800077f8:	c49c                	sw	a5,8(s1)
  return (((val & 0x00ffU) << 8) |
    800077fa:	0085979b          	sllw	a5,a1,0x8
    800077fe:	0085d59b          	srlw	a1,a1,0x8
    80007802:	8fcd                	or	a5,a5,a1
  th->window = htons(th->window);
    80007804:	00f49723          	sh	a5,14(s1)
  th->checksum = htons(th->checksum);
  th->urg = htons(th->urg);
  th->checksum = tcp_v4_checksum(m, htonl(ts->saddr), htonl(ts->daddr));
    80007808:	01092783          	lw	a5,16(s2)
    8000780c:	01492703          	lw	a4,20(s2)
          ((val & 0xff000000UL) >> 24));
    80007810:	0187561b          	srlw	a2,a4,0x18
  return (((val & 0x000000ffUL) << 24) |
    80007814:	0187169b          	sllw	a3,a4,0x18
          ((val & 0x00ff0000UL) >> 8) |
    80007818:	8e55                	or	a2,a2,a3
          ((val & 0x0000ff00UL) << 8) |
    8000781a:	0087169b          	sllw	a3,a4,0x8
    8000781e:	0106f6b3          	and	a3,a3,a6
          ((val & 0x00ff0000UL) >> 8) |
    80007822:	8e55                	or	a2,a2,a3
    80007824:	0087571b          	srlw	a4,a4,0x8
    80007828:	8f69                	and	a4,a4,a0
    8000782a:	8e59                	or	a2,a2,a4
  return (((val & 0x000000ffUL) << 24) |
    8000782c:	0187959b          	sllw	a1,a5,0x18
          ((val & 0xff000000UL) >> 24));
    80007830:	0187d71b          	srlw	a4,a5,0x18
          ((val & 0x00ff0000UL) >> 8) |
    80007834:	8dd9                	or	a1,a1,a4
          ((val & 0x0000ff00UL) << 8) |
    80007836:	0087971b          	sllw	a4,a5,0x8
    8000783a:	01077733          	and	a4,a4,a6
          ((val & 0x00ff0000UL) >> 8) |
    8000783e:	8dd9                	or	a1,a1,a4
    80007840:	0087d79b          	srlw	a5,a5,0x8
    80007844:	8fe9                	and	a5,a5,a0
    80007846:	8ddd                	or	a1,a1,a5
    80007848:	2601                	sext.w	a2,a2
    8000784a:	2581                	sext.w	a1,a1
    8000784c:	854e                	mv	a0,s3
    8000784e:	00000097          	auipc	ra,0x0
    80007852:	eac080e7          	jalr	-340(ra) # 800076fa <tcp_v4_checksum>
    80007856:	00a49823          	sh	a0,16(s1)

  net_tx_ip(m, IPPROTO_TCP, ts->daddr);
    8000785a:	01492603          	lw	a2,20(s2)
    8000785e:	4599                	li	a1,6
    80007860:	854e                	mv	a0,s3
    80007862:	fffff097          	auipc	ra,0xfffff
    80007866:	952080e7          	jalr	-1710(ra) # 800061b4 <net_tx_ip>
}
    8000786a:	70a2                	ld	ra,40(sp)
    8000786c:	7402                	ld	s0,32(sp)
    8000786e:	64e2                	ld	s1,24(sp)
    80007870:	6942                	ld	s2,16(sp)
    80007872:	69a2                	ld	s3,8(sp)
    80007874:	6145                	add	sp,sp,48
    80007876:	8082                	ret

0000000080007878 <tcp_send_reset>:


int
tcp_send_reset(struct tcp_sock *ts)
{
    80007878:	1101                	add	sp,sp,-32
    8000787a:	ec06                	sd	ra,24(sp)
    8000787c:	e822                	sd	s0,16(sp)
    8000787e:	e04a                	sd	s2,0(sp)
    80007880:	1000                	add	s0,sp,32
    80007882:	892a                	mv	s2,a0
  struct mbuf *m = mbufalloc(MBUF_DEFAULT_HEADROOM);
    80007884:	08000513          	li	a0,128
    80007888:	00000097          	auipc	ra,0x0
    8000788c:	83e080e7          	jalr	-1986(ra) # 800070c6 <mbufalloc>
  if (!m)
    80007890:	c121                	beqz	a0,800078d0 <tcp_send_reset+0x58>
    80007892:	e426                	sd	s1,8(sp)
    80007894:	84aa                	mv	s1,a0
    return -1;

  struct tcp_hdr *th = mbufpushhdr(m, *th);
    80007896:	45d1                	li	a1,20
    80007898:	fffff097          	auipc	ra,0xfffff
    8000789c:	79c080e7          	jalr	1948(ra) # 80007034 <mbufpush>
    800078a0:	85aa                	mv	a1,a0

  th->rst = 1;
    800078a2:	00c55783          	lhu	a5,12(a0)
    800078a6:	4007e793          	or	a5,a5,1024
    800078aa:	00f51623          	sh	a5,12(a0)
  ts->tcb.snd_una = ts->tcb.snd_nxt; // ?
    800078ae:	07492683          	lw	a3,116(s2)
    800078b2:	06d92823          	sw	a3,112(s2)

  tcp_transmit_mbuf(ts, th, m, ts->tcb.snd_nxt);
    800078b6:	8626                	mv	a2,s1
    800078b8:	854a                	mv	a0,s2
    800078ba:	00000097          	auipc	ra,0x0
    800078be:	e80080e7          	jalr	-384(ra) # 8000773a <tcp_transmit_mbuf>

  return 0;
    800078c2:	4501                	li	a0,0
    800078c4:	64a2                	ld	s1,8(sp)
}
    800078c6:	60e2                	ld	ra,24(sp)
    800078c8:	6442                	ld	s0,16(sp)
    800078ca:	6902                	ld	s2,0(sp)
    800078cc:	6105                	add	sp,sp,32
    800078ce:	8082                	ret
    return -1;
    800078d0:	557d                	li	a0,-1
    800078d2:	bfd5                	j	800078c6 <tcp_send_reset+0x4e>

00000000800078d4 <tcp_send_synack>:
	 * SYN-SENT:
	 *         SEG: SYN, no ACK, no RST
	 *         <SEQ=ISS><ACK=RCV.NXT><CTL=SYN,ACK>
	 *         (ISS == SND.NXT)
	 */
  if (rth->rst)
    800078d4:	00c5d783          	lhu	a5,12(a1)
    800078d8:	4007f793          	and	a5,a5,1024
    800078dc:	c391                	beqz	a5,800078e0 <tcp_send_synack+0xc>
    800078de:	8082                	ret
{
    800078e0:	7179                	add	sp,sp,-48
    800078e2:	f406                	sd	ra,40(sp)
    800078e4:	f022                	sd	s0,32(sp)
    800078e6:	ec26                	sd	s1,24(sp)
    800078e8:	e84a                	sd	s2,16(sp)
    800078ea:	1800                	add	s0,sp,48
    800078ec:	84aa                	mv	s1,a0
    return;

  struct mbuf *m = mbufalloc(MBUF_DEFAULT_HEADROOM);
    800078ee:	08000513          	li	a0,128
    800078f2:	fffff097          	auipc	ra,0xfffff
    800078f6:	7d4080e7          	jalr	2004(ra) # 800070c6 <mbufalloc>
    800078fa:	892a                	mv	s2,a0
  if (!m)
    800078fc:	c139                	beqz	a0,80007942 <tcp_send_synack+0x6e>
    800078fe:	e44e                	sd	s3,8(sp)
    return;

  struct tcp_hdr *th = mbufpushhdr(m, *th);
    80007900:	45d1                	li	a1,20
    80007902:	fffff097          	auipc	ra,0xfffff
    80007906:	732080e7          	jalr	1842(ra) # 80007034 <mbufpush>
    8000790a:	89aa                	mv	s3,a0

  th->syn = 1;
    8000790c:	00c55783          	lhu	a5,12(a0)
  th->ack = 1;
    80007910:	2007e793          	or	a5,a5,512
    80007914:	6705                	lui	a4,0x1
    80007916:	8fd9                	or	a5,a5,a4
    80007918:	00f51623          	sh	a5,12(a0)
  
  tcpsock_dbg("send synack", ts);
    8000791c:	85a6                	mv	a1,s1
    8000791e:	00004517          	auipc	a0,0x4
    80007922:	f4250513          	add	a0,a0,-190 # 8000b860 <etext+0x860>
    80007926:	00000097          	auipc	ra,0x0
    8000792a:	89a080e7          	jalr	-1894(ra) # 800071c0 <tcpsock_dbg>

  tcp_transmit_mbuf(ts, th, m, ts->tcb.iss);
    8000792e:	0884a683          	lw	a3,136(s1)
    80007932:	864a                	mv	a2,s2
    80007934:	85ce                	mv	a1,s3
    80007936:	8526                	mv	a0,s1
    80007938:	00000097          	auipc	ra,0x0
    8000793c:	e02080e7          	jalr	-510(ra) # 8000773a <tcp_transmit_mbuf>
    80007940:	69a2                	ld	s3,8(sp)
}
    80007942:	70a2                	ld	ra,40(sp)
    80007944:	7402                	ld	s0,32(sp)
    80007946:	64e2                	ld	s1,24(sp)
    80007948:	6942                	ld	s2,16(sp)
    8000794a:	6145                	add	sp,sp,48
    8000794c:	8082                	ret

000000008000794e <tcp_send_syn>:

void
tcp_send_syn(struct tcp_sock *ts)
{
  if (ts->state == TCP_CLOSE) return;
    8000794e:	09c52703          	lw	a4,156(a0)
    80007952:	4799                	li	a5,6
    80007954:	04f70b63          	beq	a4,a5,800079aa <tcp_send_syn+0x5c>
{
    80007958:	1101                	add	sp,sp,-32
    8000795a:	ec06                	sd	ra,24(sp)
    8000795c:	e822                	sd	s0,16(sp)
    8000795e:	e426                	sd	s1,8(sp)
    80007960:	e04a                	sd	s2,0(sp)
    80007962:	1000                	add	s0,sp,32
    80007964:	84aa                	mv	s1,a0

  struct mbuf *m = mbufalloc(MBUF_DEFAULT_HEADROOM);
    80007966:	08000513          	li	a0,128
    8000796a:	fffff097          	auipc	ra,0xfffff
    8000796e:	75c080e7          	jalr	1884(ra) # 800070c6 <mbufalloc>
    80007972:	892a                	mv	s2,a0
  if (!m)
    80007974:	c50d                	beqz	a0,8000799e <tcp_send_syn+0x50>
    return;

  struct tcp_hdr *th = mbufpushhdr(m, *th);
    80007976:	45d1                	li	a1,20
    80007978:	fffff097          	auipc	ra,0xfffff
    8000797c:	6bc080e7          	jalr	1724(ra) # 80007034 <mbufpush>
    80007980:	85aa                	mv	a1,a0
  th->syn = 1;
    80007982:	00c55783          	lhu	a5,12(a0)
    80007986:	2007e793          	or	a5,a5,512
    8000798a:	00f51623          	sh	a5,12(a0)

  tcp_transmit_mbuf(ts, th, m, ts->tcb.iss);
    8000798e:	0884a683          	lw	a3,136(s1)
    80007992:	864a                	mv	a2,s2
    80007994:	8526                	mv	a0,s1
    80007996:	00000097          	auipc	ra,0x0
    8000799a:	da4080e7          	jalr	-604(ra) # 8000773a <tcp_transmit_mbuf>
}
    8000799e:	60e2                	ld	ra,24(sp)
    800079a0:	6442                	ld	s0,16(sp)
    800079a2:	64a2                	ld	s1,8(sp)
    800079a4:	6902                	ld	s2,0(sp)
    800079a6:	6105                	add	sp,sp,32
    800079a8:	8082                	ret
    800079aa:	8082                	ret

00000000800079ac <tcp_send_ack>:

void
tcp_send_ack(struct tcp_sock *ts)
{
  if (ts->state == TCP_CLOSE) return;
    800079ac:	09c52703          	lw	a4,156(a0)
    800079b0:	4799                	li	a5,6
    800079b2:	04f70a63          	beq	a4,a5,80007a06 <tcp_send_ack+0x5a>
{
    800079b6:	1101                	add	sp,sp,-32
    800079b8:	ec06                	sd	ra,24(sp)
    800079ba:	e822                	sd	s0,16(sp)
    800079bc:	e426                	sd	s1,8(sp)
    800079be:	e04a                	sd	s2,0(sp)
    800079c0:	1000                	add	s0,sp,32
    800079c2:	84aa                	mv	s1,a0

  struct mbuf *m = mbufalloc(MBUF_DEFAULT_HEADROOM);
    800079c4:	08000513          	li	a0,128
    800079c8:	fffff097          	auipc	ra,0xfffff
    800079cc:	6fe080e7          	jalr	1790(ra) # 800070c6 <mbufalloc>
    800079d0:	892a                	mv	s2,a0
  if (!m)
    800079d2:	c505                	beqz	a0,800079fa <tcp_send_ack+0x4e>
    return;

  struct tcp_hdr *th = mbufpushhdr(m, *th);
    800079d4:	45d1                	li	a1,20
    800079d6:	fffff097          	auipc	ra,0xfffff
    800079da:	65e080e7          	jalr	1630(ra) # 80007034 <mbufpush>
    800079de:	85aa                	mv	a1,a0

  th->ack = 1;
    800079e0:	00c55783          	lhu	a5,12(a0)
    800079e4:	6705                	lui	a4,0x1
    800079e6:	8fd9                	or	a5,a5,a4
    800079e8:	00f51623          	sh	a5,12(a0)

  tcp_transmit_mbuf(ts, th, m, ts->tcb.snd_nxt);
    800079ec:	58f4                	lw	a3,116(s1)
    800079ee:	864a                	mv	a2,s2
    800079f0:	8526                	mv	a0,s1
    800079f2:	00000097          	auipc	ra,0x0
    800079f6:	d48080e7          	jalr	-696(ra) # 8000773a <tcp_transmit_mbuf>
}
    800079fa:	60e2                	ld	ra,24(sp)
    800079fc:	6442                	ld	s0,16(sp)
    800079fe:	64a2                	ld	s1,8(sp)
    80007a00:	6902                	ld	s2,0(sp)
    80007a02:	6105                	add	sp,sp,32
    80007a04:	8082                	ret
    80007a06:	8082                	ret

0000000080007a08 <tcp_send_fin>:

void
tcp_send_fin(struct tcp_sock *ts)
{
  if (ts->state == TCP_CLOSE) return;
    80007a08:	09c52703          	lw	a4,156(a0)
    80007a0c:	4799                	li	a5,6
    80007a0e:	04f70c63          	beq	a4,a5,80007a66 <tcp_send_fin+0x5e>
{
    80007a12:	1101                	add	sp,sp,-32
    80007a14:	ec06                	sd	ra,24(sp)
    80007a16:	e822                	sd	s0,16(sp)
    80007a18:	e426                	sd	s1,8(sp)
    80007a1a:	e04a                	sd	s2,0(sp)
    80007a1c:	1000                	add	s0,sp,32
    80007a1e:	84aa                	mv	s1,a0

  struct mbuf *m = mbufalloc(MBUF_DEFAULT_HEADROOM);
    80007a20:	08000513          	li	a0,128
    80007a24:	fffff097          	auipc	ra,0xfffff
    80007a28:	6a2080e7          	jalr	1698(ra) # 800070c6 <mbufalloc>
    80007a2c:	892a                	mv	s2,a0
  if (!m)
    80007a2e:	c515                	beqz	a0,80007a5a <tcp_send_fin+0x52>
    return;

  struct tcp_hdr *th = mbufpushhdr(m, *th);
    80007a30:	45d1                	li	a1,20
    80007a32:	fffff097          	auipc	ra,0xfffff
    80007a36:	602080e7          	jalr	1538(ra) # 80007034 <mbufpush>
    80007a3a:	85aa                	mv	a1,a0

  th->ack = 1;
    80007a3c:	00c55783          	lhu	a5,12(a0)
    80007a40:	6705                	lui	a4,0x1
    80007a42:	8fd9                	or	a5,a5,a4
  th->fin = 1;
    80007a44:	1007e793          	or	a5,a5,256
    80007a48:	00f51623          	sh	a5,12(a0)

  // ToDo: Add write queue
  tcp_transmit_mbuf(ts, th, m, ts->tcb.snd_nxt);
    80007a4c:	58f4                	lw	a3,116(s1)
    80007a4e:	864a                	mv	a2,s2
    80007a50:	8526                	mv	a0,s1
    80007a52:	00000097          	auipc	ra,0x0
    80007a56:	ce8080e7          	jalr	-792(ra) # 8000773a <tcp_transmit_mbuf>
}
    80007a5a:	60e2                	ld	ra,24(sp)
    80007a5c:	6442                	ld	s0,16(sp)
    80007a5e:	64a2                	ld	s1,8(sp)
    80007a60:	6902                	ld	s2,0(sp)
    80007a62:	6105                	add	sp,sp,32
    80007a64:	8082                	ret
    80007a66:	8082                	ret

0000000080007a68 <tcp_send>:



int
tcp_send(struct tcp_sock *ts, uint64 ubuf, int len)
{
    80007a68:	7159                	add	sp,sp,-112
    80007a6a:	f486                	sd	ra,104(sp)
    80007a6c:	f0a2                	sd	s0,96(sp)
    80007a6e:	f062                	sd	s8,32(sp)
    80007a70:	1880                	add	s0,sp,112
    80007a72:	8c32                	mv	s8,a2
  int slen = len;
  int dlen = 0;


  while (slen > 0) {
    80007a74:	10c05463          	blez	a2,80007b7c <tcp_send+0x114>
    80007a78:	eca6                	sd	s1,88(sp)
    80007a7a:	e8ca                	sd	s2,80(sp)
    80007a7c:	e4ce                	sd	s3,72(sp)
    80007a7e:	e0d2                	sd	s4,64(sp)
    80007a80:	fc56                	sd	s5,56(sp)
    80007a82:	f85a                	sd	s6,48(sp)
    80007a84:	f45e                	sd	s7,40(sp)
    80007a86:	ec66                	sd	s9,24(sp)
    80007a88:	e86a                	sd	s10,16(sp)
    80007a8a:	e46e                	sd	s11,8(sp)
    80007a8c:	8a2a                	mv	s4,a0
    80007a8e:	8aae                	mv	s5,a1
  int slen = len;
    80007a90:	89b2                	mv	s3,a2
    dlen = slen > TCP_DEFALUT_MSS ? TCP_DEFALUT_MSS : slen;
    80007a92:	21800b13          	li	s6,536
    80007a96:	21800c93          	li	s9,536
    m->len += dlen;
    ubuf += dlen;
    
    struct tcp_hdr *th = mbufpushhdr(m, *th);

    th->ack = 1;
    80007a9a:	6b85                	lui	s7,0x1
    80007a9c:	a835                	j	80007ad8 <tcp_send+0x70>
    if (!m) return len - slen;
    80007a9e:	41bc0c3b          	subw	s8,s8,s11
    80007aa2:	64e6                	ld	s1,88(sp)
    80007aa4:	6946                	ld	s2,80(sp)
    80007aa6:	69a6                	ld	s3,72(sp)
    80007aa8:	6a06                	ld	s4,64(sp)
    80007aaa:	7ae2                	ld	s5,56(sp)
    80007aac:	7b42                	ld	s6,48(sp)
    80007aae:	7ba2                	ld	s7,40(sp)
    80007ab0:	6ce2                	ld	s9,24(sp)
    80007ab2:	6d42                	ld	s10,16(sp)
    80007ab4:	6da2                	ld	s11,8(sp)
    80007ab6:	a0d9                	j	80007b7c <tcp_send+0x114>
    if (slen == 0) {
      th->psh = 1;
    }

    // ToDo: Add write queue
    tcp_transmit_mbuf(ts, th, m, ts->tcb.snd_nxt);
    80007ab8:	074a2683          	lw	a3,116(s4) # 2074 <_entry-0x7fffdf8c>
    80007abc:	8626                	mv	a2,s1
    80007abe:	8552                	mv	a0,s4
    80007ac0:	00000097          	auipc	ra,0x0
    80007ac4:	c7a080e7          	jalr	-902(ra) # 8000773a <tcp_transmit_mbuf>
    ts->tcb.snd_nxt += dlen;
    80007ac8:	074a2783          	lw	a5,116(s4)
    80007acc:	00f907bb          	addw	a5,s2,a5
    80007ad0:	06fa2a23          	sw	a5,116(s4)
  while (slen > 0) {
    80007ad4:	0b305a63          	blez	s3,80007b88 <tcp_send+0x120>
    dlen = slen > TCP_DEFALUT_MSS ? TCP_DEFALUT_MSS : slen;
    80007ad8:	894e                	mv	s2,s3
    80007ada:	013b5363          	bge	s6,s3,80007ae0 <tcp_send+0x78>
    80007ade:	8966                	mv	s2,s9
    80007ae0:	00090d1b          	sext.w	s10,s2
    slen -= dlen;
    80007ae4:	41298dbb          	subw	s11,s3,s2
    80007ae8:	000d899b          	sext.w	s3,s11
    struct mbuf *m = mbufalloc(MBUF_DEFAULT_HEADROOM);
    80007aec:	08000513          	li	a0,128
    80007af0:	fffff097          	auipc	ra,0xfffff
    80007af4:	5d6080e7          	jalr	1494(ra) # 800070c6 <mbufalloc>
    80007af8:	84aa                	mv	s1,a0
    if (!m) return len - slen;
    80007afa:	d155                	beqz	a0,80007a9e <tcp_send+0x36>
    copyin(myproc()->pagetable, m->head, ubuf, dlen);
    80007afc:	ffff9097          	auipc	ra,0xffff9
    80007b00:	44a080e7          	jalr	1098(ra) # 80000f46 <myproc>
    80007b04:	86ea                	mv	a3,s10
    80007b06:	8656                	mv	a2,s5
    80007b08:	648c                	ld	a1,8(s1)
    80007b0a:	6928                	ld	a0,80(a0)
    80007b0c:	ffff9097          	auipc	ra,0xffff9
    80007b10:	142080e7          	jalr	322(ra) # 80000c4e <copyin>
    m->len += dlen;
    80007b14:	489c                	lw	a5,16(s1)
    80007b16:	00f907bb          	addw	a5,s2,a5
    80007b1a:	c89c                	sw	a5,16(s1)
    ubuf += dlen;
    80007b1c:	9aea                	add	s5,s5,s10
    struct tcp_hdr *th = mbufpushhdr(m, *th);
    80007b1e:	45d1                	li	a1,20
    80007b20:	8526                	mv	a0,s1
    80007b22:	fffff097          	auipc	ra,0xfffff
    80007b26:	512080e7          	jalr	1298(ra) # 80007034 <mbufpush>
    80007b2a:	85aa                	mv	a1,a0
    th->ack = 1;
    80007b2c:	00c55783          	lhu	a5,12(a0)
    80007b30:	0177e7b3          	or	a5,a5,s7
    80007b34:	00f51623          	sh	a5,12(a0)
    if (slen == 0) {
    80007b38:	f80990e3          	bnez	s3,80007ab8 <tcp_send+0x50>
      th->psh = 1;
    80007b3c:	17c2                	sll	a5,a5,0x30
    80007b3e:	93c1                	srl	a5,a5,0x30
    80007b40:	6705                	lui	a4,0x1
    80007b42:	80070713          	add	a4,a4,-2048 # 800 <_entry-0x7ffff800>
    80007b46:	8fd9                	or	a5,a5,a4
    80007b48:	00f51623          	sh	a5,12(a0)
    tcp_transmit_mbuf(ts, th, m, ts->tcb.snd_nxt);
    80007b4c:	074a2683          	lw	a3,116(s4)
    80007b50:	8626                	mv	a2,s1
    80007b52:	8552                	mv	a0,s4
    80007b54:	00000097          	auipc	ra,0x0
    80007b58:	be6080e7          	jalr	-1050(ra) # 8000773a <tcp_transmit_mbuf>
    ts->tcb.snd_nxt += dlen;
    80007b5c:	074a2783          	lw	a5,116(s4)
    80007b60:	00f9093b          	addw	s2,s2,a5
    80007b64:	072a2a23          	sw	s2,116(s4)
  while (slen > 0) {
    80007b68:	64e6                	ld	s1,88(sp)
    80007b6a:	6946                	ld	s2,80(sp)
    80007b6c:	69a6                	ld	s3,72(sp)
    80007b6e:	6a06                	ld	s4,64(sp)
    80007b70:	7ae2                	ld	s5,56(sp)
    80007b72:	7b42                	ld	s6,48(sp)
    80007b74:	7ba2                	ld	s7,40(sp)
    80007b76:	6ce2                	ld	s9,24(sp)
    80007b78:	6d42                	ld	s10,16(sp)
    80007b7a:	6da2                	ld	s11,8(sp)
    //tcpdbg("after send data, snd_nxt: %d\n", ts->tcb.snd_nxt);
  }

  return len;
}
    80007b7c:	8562                	mv	a0,s8
    80007b7e:	70a6                	ld	ra,104(sp)
    80007b80:	7406                	ld	s0,96(sp)
    80007b82:	7c02                	ld	s8,32(sp)
    80007b84:	6165                	add	sp,sp,112
    80007b86:	8082                	ret
    80007b88:	64e6                	ld	s1,88(sp)
    80007b8a:	6946                	ld	s2,80(sp)
    80007b8c:	69a6                	ld	s3,72(sp)
    80007b8e:	6a06                	ld	s4,64(sp)
    80007b90:	7ae2                	ld	s5,56(sp)
    80007b92:	7b42                	ld	s6,48(sp)
    80007b94:	7ba2                	ld	s7,40(sp)
    80007b96:	6ce2                	ld	s9,24(sp)
    80007b98:	6d42                	ld	s10,16(sp)
    80007b9a:	6da2                	ld	s11,8(sp)
    80007b9c:	b7c5                	j	80007b7c <tcp_send+0x114>

0000000080007b9e <tcp_timewait_timer>:
  tcp_done(ts);
}

void *
tcp_timewait_timer(void *arg)
{
    80007b9e:	1141                	add	sp,sp,-16
    80007ba0:	e406                	sd	ra,8(sp)
    80007ba2:	e022                	sd	s0,0(sp)
    80007ba4:	0800                	add	s0,sp,16
  struct tcp_sock *ts = (struct tcp_sock *)arg;
  tcp_done(ts);
    80007ba6:	00000097          	auipc	ra,0x0
    80007baa:	940080e7          	jalr	-1728(ra) # 800074e6 <tcp_done>
  return NULL;
}
    80007bae:	4501                	li	a0,0
    80007bb0:	60a2                	ld	ra,8(sp)
    80007bb2:	6402                	ld	s0,0(sp)
    80007bb4:	0141                	add	sp,sp,16
    80007bb6:	8082                	ret

0000000080007bb8 <alloc_new_iss>:
{
    80007bb8:	1141                	add	sp,sp,-16
    80007bba:	e422                	sd	s0,8(sp)
    80007bbc:	0800                	add	s0,sp,16
	if (++iss >= 0xffffffff)
    80007bbe:	00004517          	auipc	a0,0x4
    80007bc2:	fae52503          	lw	a0,-82(a0) # 8000bb6c <iss.0>
    80007bc6:	2505                	addw	a0,a0,1
    80007bc8:	57fd                	li	a5,-1
    80007bca:	00f50963          	beq	a0,a5,80007bdc <alloc_new_iss+0x24>
    80007bce:	00004797          	auipc	a5,0x4
    80007bd2:	f8a7af23          	sw	a0,-98(a5) # 8000bb6c <iss.0>
}
    80007bd6:	6422                	ld	s0,8(sp)
    80007bd8:	0141                	add	sp,sp,16
    80007bda:	8082                	ret
    80007bdc:	00bc6537          	lui	a0,0xbc6
    80007be0:	14e50513          	add	a0,a0,334 # bc614e <_entry-0x7f439eb2>
    80007be4:	b7ed                	j	80007bce <alloc_new_iss+0x16>

0000000080007be6 <tcp_input_state>:
 * Follows RFC793 "Segment Arrives" section closely
 */ 
// return 1: tcp done
int
tcp_input_state(struct tcp_sock *ts, struct tcp_hdr *th, struct ip *iphdr, struct mbuf *m)
{
    80007be6:	7139                	add	sp,sp,-64
    80007be8:	fc06                	sd	ra,56(sp)
    80007bea:	f822                	sd	s0,48(sp)
    80007bec:	f426                	sd	s1,40(sp)
    80007bee:	f04a                	sd	s2,32(sp)
    80007bf0:	ec4e                	sd	s3,24(sp)
    80007bf2:	e852                	sd	s4,16(sp)
    80007bf4:	0080                	add	s0,sp,64
    80007bf6:	84aa                	mv	s1,a0
    80007bf8:	892e                	mv	s2,a1
    80007bfa:	8a32                	mv	s4,a2
    80007bfc:	89b6                	mv	s3,a3
  // struct tcb *tcb = &sk->tcb;

  tcpsock_dbg("input state", ts);
    80007bfe:	85aa                	mv	a1,a0
    80007c00:	00004517          	auipc	a0,0x4
    80007c04:	c7050513          	add	a0,a0,-912 # 8000b870 <etext+0x870>
    80007c08:	fffff097          	auipc	ra,0xfffff
    80007c0c:	5b8080e7          	jalr	1464(ra) # 800071c0 <tcpsock_dbg>

  switch (ts->state)
    80007c10:	09c4a783          	lw	a5,156(s1)
    80007c14:	4705                	li	a4,1
    80007c16:	18e78a63          	beq	a5,a4,80007daa <tcp_input_state+0x1c4>
    80007c1a:	4719                	li	a4,6
    80007c1c:	06e78d63          	beq	a5,a4,80007c96 <tcp_input_state+0xb0>
    80007c20:	c3d1                	beqz	a5,80007ca4 <tcp_input_state+0xbe>
  if (m->len > 0 && ts->tcb.rcv_wnd == 0) return 0;
    80007c22:	0109a703          	lw	a4,16(s3)
    80007c26:	c709                	beqz	a4,80007c30 <tcp_input_state+0x4a>
    80007c28:	0904a703          	lw	a4,144(s1)
    80007c2c:	26070a63          	beqz	a4,80007ea0 <tcp_input_state+0x2ba>
  if (th->seq < ts->tcb.rcv_nxt ||
    80007c30:	00492703          	lw	a4,4(s2)
    80007c34:	08c4a683          	lw	a3,140(s1)
    80007c38:	26d76463          	bltu	a4,a3,80007ea0 <tcp_input_state+0x2ba>
    th->seq > (ts->tcb.rcv_nxt + ts->tcb.rcv_wnd)) {
    80007c3c:	0904a603          	lw	a2,144(s1)
    return tcp_synsent(ts, th, m);
  }

  /* first check sequence number */
  tcpdbg("1. check seq\n");
  if (!tcp_verify_segment(ts, th, m)) {
    80007c40:	9eb1                	addw	a3,a3,a2
    80007c42:	24e6ef63          	bltu	a3,a4,80007ea0 <tcp_input_state+0x2ba>
    }
  }

  /* second check the RST bit */
  tcpdbg("2. check rst\n");
  if (th->rst) {
    80007c46:	00c95703          	lhu	a4,12(s2)
    80007c4a:	40077693          	and	a3,a4,1024
    80007c4e:	24069e63          	bnez	a3,80007eaa <tcp_input_state+0x2c4>
  /* third check security and precedence (ignored) */
	tcpdbg("3. NO check security and precedence\n");

  /* fourth check the SYN bit */
	tcpdbg("4. check syn\n");
  if (th->syn) {
    80007c52:	20077713          	and	a4,a4,512
    80007c56:	2a071c63          	bnez	a4,80007f0e <tcp_input_state+0x328>
    }
  }

  /* fifth check the ACK field */
	tcpdbg("5. check ack\n");
  if (!th->ack)
    80007c5a:	00c95783          	lhu	a5,12(s2)
    80007c5e:	03379713          	sll	a4,a5,0x33
    80007c62:	28075f63          	bgez	a4,80007f00 <tcp_input_state+0x31a>
    goto drop;
  switch (ts->state) {
    80007c66:	09c4a783          	lw	a5,156(s1)
    80007c6a:	4711                	li	a4,4
    80007c6c:	2ef76263          	bltu	a4,a5,80007f50 <tcp_input_state+0x36a>
    80007c70:	4709                	li	a4,2
    80007c72:	2ef76463          	bltu	a4,a5,80007f5a <tcp_input_state+0x374>
    80007c76:	38e79763          	bne	a5,a4,80008004 <tcp_input_state+0x41e>
    case TCP_SYN_RECEIVED:
      if (ts->tcb.snd_una <= th->ack_seq && th->ack_seq <= ts->tcb.snd_nxt) {
    80007c7a:	00892783          	lw	a5,8(s2)
    80007c7e:	58b8                	lw	a4,112(s1)
    80007c80:	00e7e563          	bltu	a5,a4,80007c8a <tcp_input_state+0xa4>
    80007c84:	58f8                	lw	a4,116(s1)
    80007c86:	30f77563          	bgeu	a4,a5,80007f90 <tcp_input_state+0x3aa>
        ts->tcb.snd_una = th->ack_seq;
        /* RFC 1122: error corrections of RFC 793(SND.W**) */
        __tcp_update_window(ts, th);
        tcp_set_state(ts, TCP_ESTABLISHED);
      } else {
        tcp_send_reset(ts);
    80007c8a:	8526                	mv	a0,s1
    80007c8c:	00000097          	auipc	ra,0x0
    80007c90:	bec080e7          	jalr	-1044(ra) # 80007878 <tcp_send_reset>
        goto drop;
    80007c94:	a4b5                	j	80007f00 <tcp_input_state+0x31a>
  mbuffree(m);
    80007c96:	854e                	mv	a0,s3
    80007c98:	fffff097          	auipc	ra,0xfffff
    80007c9c:	494080e7          	jalr	1172(ra) # 8000712c <mbuffree>
    return tcp_closed(ts, th, m);
    80007ca0:	4501                	li	a0,0
    80007ca2:	aa55                	j	80007e56 <tcp_input_state+0x270>
  if (th->rst)
    80007ca4:	00c95783          	lhu	a5,12(s2)
    80007ca8:	4007f713          	and	a4,a5,1024
    80007cac:	eb01                	bnez	a4,80007cbc <tcp_input_state+0xd6>
  if (th->ack) {
    80007cae:	03379713          	sll	a4,a5,0x33
    80007cb2:	00074c63          	bltz	a4,80007cca <tcp_input_state+0xe4>
  if (!th->syn)
    80007cb6:	2007f793          	and	a5,a5,512
    80007cba:	ef91                	bnez	a5,80007cd6 <tcp_input_state+0xf0>
  mbuffree(m);
    80007cbc:	854e                	mv	a0,s3
    80007cbe:	fffff097          	auipc	ra,0xfffff
    80007cc2:	46e080e7          	jalr	1134(ra) # 8000712c <mbuffree>
    return tcp_in_listen(ts, th, iphdr, m);
    80007cc6:	4501                	li	a0,0
    80007cc8:	a279                	j	80007e56 <tcp_input_state+0x270>
    tcp_send_reset(ts);
    80007cca:	8526                	mv	a0,s1
    80007ccc:	00000097          	auipc	ra,0x0
    80007cd0:	bac080e7          	jalr	-1108(ra) # 80007878 <tcp_send_reset>
    goto discard;
    80007cd4:	b7e5                	j	80007cbc <tcp_input_state+0xd6>
    80007cd6:	e456                	sd	s5,8(sp)
  struct tcp_sock *newts = tcp_sock_alloc();
    80007cd8:	00000097          	auipc	ra,0x0
    80007cdc:	566080e7          	jalr	1382(ra) # 8000823e <tcp_sock_alloc>
    80007ce0:	8aaa                	mv	s5,a0
  tcp_set_state(newts, TCP_SYN_RECEIVED);
    80007ce2:	4589                	li	a1,2
    80007ce4:	fffff097          	auipc	ra,0xfffff
    80007ce8:	4e8080e7          	jalr	1256(ra) # 800071cc <tcp_set_state>
  newts->saddr = ntohl(iphdr->ip_dst);
    80007cec:	010a2783          	lw	a5,16(s4)
  return (((val & 0x000000ffUL) << 24) |
    80007cf0:	0187971b          	sllw	a4,a5,0x18
          ((val & 0xff000000UL) >> 24));
    80007cf4:	0187d69b          	srlw	a3,a5,0x18
          ((val & 0x00ff0000UL) >> 8) |
    80007cf8:	8f55                	or	a4,a4,a3
          ((val & 0x0000ff00UL) << 8) |
    80007cfa:	0087969b          	sllw	a3,a5,0x8
    80007cfe:	00ff05b7          	lui	a1,0xff0
    80007d02:	8eed                	and	a3,a3,a1
          ((val & 0x00ff0000UL) >> 8) |
    80007d04:	8f55                	or	a4,a4,a3
    80007d06:	0087d79b          	srlw	a5,a5,0x8
    80007d0a:	66c1                	lui	a3,0x10
    80007d0c:	f0068693          	add	a3,a3,-256 # ff00 <_entry-0x7fff0100>
    80007d10:	8ff5                	and	a5,a5,a3
    80007d12:	8fd9                	or	a5,a5,a4
    80007d14:	00faa823          	sw	a5,16(s5)
  newts->daddr = ntohl(iphdr->ip_src);
    80007d18:	00ca2783          	lw	a5,12(s4)
  return (((val & 0x000000ffUL) << 24) |
    80007d1c:	0187971b          	sllw	a4,a5,0x18
          ((val & 0xff000000UL) >> 24));
    80007d20:	0187d61b          	srlw	a2,a5,0x18
          ((val & 0x00ff0000UL) >> 8) |
    80007d24:	8f51                	or	a4,a4,a2
          ((val & 0x0000ff00UL) << 8) |
    80007d26:	0087961b          	sllw	a2,a5,0x8
    80007d2a:	8e6d                	and	a2,a2,a1
          ((val & 0x00ff0000UL) >> 8) |
    80007d2c:	8f51                	or	a4,a4,a2
    80007d2e:	0087d79b          	srlw	a5,a5,0x8
    80007d32:	8ff5                	and	a5,a5,a3
    80007d34:	8fd9                	or	a5,a5,a4
    80007d36:	00faaa23          	sw	a5,20(s5)
  newts->sport = th->dport;
    80007d3a:	00295783          	lhu	a5,2(s2)
    80007d3e:	00fa9c23          	sh	a5,24(s5)
  newts->dport = th->sport;
    80007d42:	00095783          	lhu	a5,0(s2)
    80007d46:	00fa9d23          	sh	a5,26(s5)
  newts->parent = ts;
    80007d4a:	069ab423          	sd	s1,104(s5)
  list_add(&newts->list, &ts->listen_queue);
    80007d4e:	048a8793          	add	a5,s5,72
	__list_add(list, head, head->next);
    80007d52:	7898                	ld	a4,48(s1)
    80007d54:	02848693          	add	a3,s1,40
	list->prev = prev;
    80007d58:	04dab423          	sd	a3,72(s5)
	list->next = next;
    80007d5c:	04eab823          	sd	a4,80(s5)
	next->prev = list;
    80007d60:	e31c                	sd	a5,0(a4)
	prev->next = list;
    80007d62:	f89c                	sd	a5,48(s1)
  if (!newts) {
    80007d64:	040a8163          	beqz	s5,80007da6 <tcp_input_state+0x1c0>
  newts->tcb.irs = th->seq;
    80007d68:	00492783          	lw	a5,4(s2)
    80007d6c:	08faac23          	sw	a5,152(s5)
  newts->tcb.iss = alloc_new_iss();
    80007d70:	00000097          	auipc	ra,0x0
    80007d74:	e48080e7          	jalr	-440(ra) # 80007bb8 <alloc_new_iss>
    80007d78:	08aaa423          	sw	a0,136(s5)
  newts->tcb.rcv_nxt = th->seq + 1;
    80007d7c:	00492783          	lw	a5,4(s2)
    80007d80:	2785                	addw	a5,a5,1
    80007d82:	08faa623          	sw	a5,140(s5)
  tcp_send_synack(newts, th);
    80007d86:	85ca                	mv	a1,s2
    80007d88:	8556                	mv	a0,s5
    80007d8a:	00000097          	auipc	ra,0x0
    80007d8e:	b4a080e7          	jalr	-1206(ra) # 800078d4 <tcp_send_synack>
  newts->tcb.snd_nxt = newts->tcb.iss + 1;
    80007d92:	088aa783          	lw	a5,136(s5)
    80007d96:	0017871b          	addw	a4,a5,1
    80007d9a:	06eaaa23          	sw	a4,116(s5)
  newts->tcb.snd_una = newts->tcb.iss;
    80007d9e:	06faa823          	sw	a5,112(s5)
    80007da2:	6aa2                	ld	s5,8(sp)
    80007da4:	bf21                	j	80007cbc <tcp_input_state+0xd6>
    80007da6:	6aa2                	ld	s5,8(sp)
    80007da8:	bf11                	j	80007cbc <tcp_input_state+0xd6>
  if (th->ack) {
    80007daa:	00c95783          	lhu	a5,12(s2)
    80007dae:	03379713          	sll	a4,a5,0x33
    80007db2:	02075263          	bgez	a4,80007dd6 <tcp_input_state+0x1f0>
    if (th->ack_seq <= ts->tcb.iss || th->ack_seq > ts->tcb.snd_nxt) {
    80007db6:	00892703          	lw	a4,8(s2)
    80007dba:	0884a683          	lw	a3,136(s1)
    80007dbe:	08e6f163          	bgeu	a3,a4,80007e40 <tcp_input_state+0x25a>
    80007dc2:	58f4                	lw	a3,116(s1)
    80007dc4:	06e6ee63          	bltu	a3,a4,80007e40 <tcp_input_state+0x25a>
    if (th->ack) {
    80007dc8:	6705                	lui	a4,0x1
    80007dca:	40070713          	add	a4,a4,1024 # 1400 <_entry-0x7fffec00>
    80007dce:	00e7f6b3          	and	a3,a5,a4
    80007dd2:	08e68a63          	beq	a3,a4,80007e66 <tcp_input_state+0x280>
  if (th->syn) {
    80007dd6:	2007f793          	and	a5,a5,512
    80007dda:	cba5                	beqz	a5,80007e4a <tcp_input_state+0x264>
    ts->tcb.irs = th->seq;
    80007ddc:	00492783          	lw	a5,4(s2)
    80007de0:	08f4ac23          	sw	a5,152(s1)
    ts->tcb.rcv_nxt = th->seq + 1;
    80007de4:	2785                	addw	a5,a5,1
    80007de6:	08f4a623          	sw	a5,140(s1)
    if (th->ack)                      /* No ack for simultaneous open */
    80007dea:	00c95783          	lhu	a5,12(s2)
    80007dee:	03379713          	sll	a4,a5,0x33
    80007df2:	00075563          	bgez	a4,80007dfc <tcp_input_state+0x216>
      ts->tcb.snd_una = th->ack_seq;  /* snd_una: iss -> iss+1 */
    80007df6:	00892783          	lw	a5,8(s2)
    80007dfa:	d8bc                	sw	a5,112(s1)
    if (ts->tcb.snd_una > ts->tcb.iss) { /* rcv.ack = snd.syn.seq+1 */
    80007dfc:	58b8                	lw	a4,112(s1)
    80007dfe:	0884a783          	lw	a5,136(s1)
    80007e02:	06e7ff63          	bgeu	a5,a4,80007e80 <tcp_input_state+0x29a>
      tcp_set_state(ts, TCP_ESTABLISHED);
    80007e06:	458d                	li	a1,3
    80007e08:	8526                	mv	a0,s1
    80007e0a:	fffff097          	auipc	ra,0xfffff
    80007e0e:	3c2080e7          	jalr	962(ra) # 800071cc <tcp_set_state>
      ts->tcb.snd_wnd = th->window;
    80007e12:	00e95783          	lhu	a5,14(s2)
    80007e16:	dcbc                	sw	a5,120(s1)
      ts->tcb.snd_wl1 = th->seq;
    80007e18:	00492783          	lw	a5,4(s2)
    80007e1c:	08f4a023          	sw	a5,128(s1)
      ts->tcb.snd_wl2 = th->ack_seq;
    80007e20:	00892783          	lw	a5,8(s2)
    80007e24:	08f4a223          	sw	a5,132(s1)
      tcp_send_ack(ts);
    80007e28:	8526                	mv	a0,s1
    80007e2a:	00000097          	auipc	ra,0x0
    80007e2e:	b82080e7          	jalr	-1150(ra) # 800079ac <tcp_send_ack>
      wakeup(&ts->wait_connect);
    80007e32:	05848513          	add	a0,s1,88
    80007e36:	ffffa097          	auipc	ra,0xffffa
    80007e3a:	aa8080e7          	jalr	-1368(ra) # 800018de <wakeup>
    80007e3e:	a031                	j	80007e4a <tcp_input_state+0x264>
      tcp_send_reset(ts);
    80007e40:	8526                	mv	a0,s1
    80007e42:	00000097          	auipc	ra,0x0
    80007e46:	a36080e7          	jalr	-1482(ra) # 80007878 <tcp_send_reset>
  mbuffree(m);
    80007e4a:	854e                	mv	a0,s3
    80007e4c:	fffff097          	auipc	ra,0xfffff
    80007e50:	2e0080e7          	jalr	736(ra) # 8000712c <mbuffree>
    return tcp_synsent(ts, th, m);
    80007e54:	4501                	li	a0,0
  
drop:
  mbuffree(m);

  return 0;
}
    80007e56:	70e2                	ld	ra,56(sp)
    80007e58:	7442                	ld	s0,48(sp)
    80007e5a:	74a2                	ld	s1,40(sp)
    80007e5c:	7902                	ld	s2,32(sp)
    80007e5e:	69e2                	ld	s3,24(sp)
    80007e60:	6a42                	ld	s4,16(sp)
    80007e62:	6121                	add	sp,sp,64
    80007e64:	8082                	ret
      tcp_set_state(ts, TCP_CLOSE);
    80007e66:	4599                	li	a1,6
    80007e68:	8526                	mv	a0,s1
    80007e6a:	fffff097          	auipc	ra,0xfffff
    80007e6e:	362080e7          	jalr	866(ra) # 800071cc <tcp_set_state>
      wakeup(&ts->wait_connect); 
    80007e72:	05848513          	add	a0,s1,88
    80007e76:	ffffa097          	auipc	ra,0xffffa
    80007e7a:	a68080e7          	jalr	-1432(ra) # 800018de <wakeup>
      goto discard;
    80007e7e:	b7f1                	j	80007e4a <tcp_input_state+0x264>
      tcp_set_state(ts, TCP_SYN_RECEIVED);
    80007e80:	4589                	li	a1,2
    80007e82:	8526                	mv	a0,s1
    80007e84:	fffff097          	auipc	ra,0xfffff
    80007e88:	348080e7          	jalr	840(ra) # 800071cc <tcp_set_state>
      ts->tcb.snd_una = ts->tcb.iss;
    80007e8c:	0884a783          	lw	a5,136(s1)
    80007e90:	d8bc                	sw	a5,112(s1)
      tcp_send_synack(ts, th);
    80007e92:	85ca                	mv	a1,s2
    80007e94:	8526                	mv	a0,s1
    80007e96:	00000097          	auipc	ra,0x0
    80007e9a:	a3e080e7          	jalr	-1474(ra) # 800078d4 <tcp_send_synack>
    80007e9e:	b775                	j	80007e4a <tcp_input_state+0x264>
    if (!th->rst) {
    80007ea0:	00c95703          	lhu	a4,12(s2)
    80007ea4:	40077713          	and	a4,a4,1024
    80007ea8:	c705                	beqz	a4,80007ed0 <tcp_input_state+0x2ea>
    switch (ts->state) {
    80007eaa:	4709                	li	a4,2
    80007eac:	04e79463          	bne	a5,a4,80007ef4 <tcp_input_state+0x30e>
        if (ts->parent) {  /* passive open */
    80007eb0:	74bc                	ld	a5,104(s1)
    80007eb2:	c78d                	beqz	a5,80007edc <tcp_input_state+0x2f6>
	__list_del(list->prev, list->next);
    80007eb4:	64b8                	ld	a4,72(s1)
    80007eb6:	68bc                	ld	a5,80(s1)
	prev->next = next;
    80007eb8:	e71c                	sd	a5,8(a4)
	next->prev = prev;
    80007eba:	e398                	sd	a4,0(a5)
	list->prev = NULL;
    80007ebc:	0404b423          	sd	zero,72(s1)
	list->next = NULL;
    80007ec0:	0404b823          	sd	zero,80(s1)
  tcp_done(ts);
    80007ec4:	8526                	mv	a0,s1
    80007ec6:	fffff097          	auipc	ra,0xfffff
    80007eca:	620080e7          	jalr	1568(ra) # 800074e6 <tcp_done>
          goto drop;
    80007ece:	a80d                	j	80007f00 <tcp_input_state+0x31a>
      tcp_send_ack(ts);
    80007ed0:	8526                	mv	a0,s1
    80007ed2:	00000097          	auipc	ra,0x0
    80007ed6:	ada080e7          	jalr	-1318(ra) # 800079ac <tcp_send_ack>
      goto drop;
    80007eda:	a01d                	j	80007f00 <tcp_input_state+0x31a>
          tcp_set_state(ts, TCP_CLOSE);
    80007edc:	4599                	li	a1,6
    80007ede:	8526                	mv	a0,s1
    80007ee0:	fffff097          	auipc	ra,0xfffff
    80007ee4:	2ec080e7          	jalr	748(ra) # 800071cc <tcp_set_state>
          wakeup(&ts->wait_connect);
    80007ee8:	05848513          	add	a0,s1,88
    80007eec:	ffffa097          	auipc	ra,0xffffa
    80007ef0:	9f2080e7          	jalr	-1550(ra) # 800018de <wakeup>
    tcp_set_state(ts, TCP_CLOSE);
    80007ef4:	4599                	li	a1,6
    80007ef6:	8526                	mv	a0,s1
    80007ef8:	fffff097          	auipc	ra,0xfffff
    80007efc:	2d4080e7          	jalr	724(ra) # 800071cc <tcp_set_state>
  mbuffree(m);
    80007f00:	854e                	mv	a0,s3
    80007f02:	fffff097          	auipc	ra,0xfffff
    80007f06:	22a080e7          	jalr	554(ra) # 8000712c <mbuffree>
  return 0;
    80007f0a:	4501                	li	a0,0
    80007f0c:	b7a9                	j	80007e56 <tcp_input_state+0x270>
    tcp_send_reset(ts);
    80007f0e:	8526                	mv	a0,s1
    80007f10:	00000097          	auipc	ra,0x0
    80007f14:	968080e7          	jalr	-1688(ra) # 80007878 <tcp_send_reset>
    if (ts->state == TCP_SYN_RECEIVED && ts->parent) {
    80007f18:	09c4a703          	lw	a4,156(s1)
    80007f1c:	4789                	li	a5,2
    80007f1e:	d2f71ee3          	bne	a4,a5,80007c5a <tcp_input_state+0x74>
    80007f22:	74bc                	ld	a5,104(s1)
    80007f24:	eb81                	bnez	a5,80007f34 <tcp_input_state+0x34e>
  if (!th->ack)
    80007f26:	00c95783          	lhu	a5,12(s2)
    80007f2a:	03379713          	sll	a4,a5,0x33
    80007f2e:	d40746e3          	bltz	a4,80007c7a <tcp_input_state+0x94>
    80007f32:	b7f9                	j	80007f00 <tcp_input_state+0x31a>
	__list_del(list->prev, list->next);
    80007f34:	64b8                	ld	a4,72(s1)
    80007f36:	68bc                	ld	a5,80(s1)
	prev->next = next;
    80007f38:	e71c                	sd	a5,8(a4)
	next->prev = prev;
    80007f3a:	e398                	sd	a4,0(a5)
	list->prev = NULL;
    80007f3c:	0404b423          	sd	zero,72(s1)
	list->next = NULL;
    80007f40:	0404b823          	sd	zero,80(s1)
  tcp_done(ts);
    80007f44:	8526                	mv	a0,s1
    80007f46:	fffff097          	auipc	ra,0xfffff
    80007f4a:	5a0080e7          	jalr	1440(ra) # 800074e6 <tcp_done>
      goto drop;
    80007f4e:	bf4d                	j	80007f00 <tcp_input_state+0x31a>
  switch (ts->state) {
    80007f50:	ff97871b          	addw	a4,a5,-7
    80007f54:	4689                	li	a3,2
    80007f56:	0ae6e763          	bltu	a3,a4,80008004 <tcp_input_state+0x41e>
      if (ts->tcb.snd_una < th->ack_seq && th->ack_seq <= ts->tcb.snd_nxt) {
    80007f5a:	58b4                	lw	a3,112(s1)
    80007f5c:	00892703          	lw	a4,8(s2)
    80007f60:	18e6ff63          	bgeu	a3,a4,800080fe <tcp_input_state+0x518>
    80007f64:	58f4                	lw	a3,116(s1)
    80007f66:	f8e6ede3          	bltu	a3,a4,80007f00 <tcp_input_state+0x31a>
        ts->tcb.snd_una = th->ack_seq;
    80007f6a:	d8b8                	sw	a4,112(s1)
        if (ts->state == TCP_FIN_WAIT_1) {
    80007f6c:	4711                	li	a4,4
    80007f6e:	12e78d63          	beq	a5,a4,800080a8 <tcp_input_state+0x4c2>
        } else if (ts->state == TCP_CLOSING) {
    80007f72:	4721                	li	a4,8
    80007f74:	14e78163          	beq	a5,a4,800080b6 <tcp_input_state+0x4d0>
        } else if (ts->state == TCP_LAST_ACK) {
    80007f78:	4725                	li	a4,9
    80007f7a:	16e78063          	beq	a5,a4,800080da <tcp_input_state+0x4f4>
  if ((ts->tcb.snd_una <= th->ack_seq && th->ack_seq <= ts->tcb.snd_nxt) && 
    80007f7e:	00892703          	lw	a4,8(s2)
    80007f82:	58bc                	lw	a5,112(s1)
    80007f84:	08f76063          	bltu	a4,a5,80008004 <tcp_input_state+0x41e>
    80007f88:	58fc                	lw	a5,116(s1)
    80007f8a:	06e7ed63          	bltu	a5,a4,80008004 <tcp_input_state+0x41e>
    80007f8e:	aaad                	j	80008108 <tcp_input_state+0x522>
  if (!ts->parent || ts->parent->state != TCP_LISTEN)
    80007f90:	74bc                	ld	a5,104(s1)
    80007f92:	d7bd                	beqz	a5,80007f00 <tcp_input_state+0x31a>
    80007f94:	09c7a703          	lw	a4,156(a5)
    80007f98:	f725                	bnez	a4,80007f00 <tcp_input_state+0x31a>
  if (ts->parent->accept_backlog >= ts->parent->backlog)
    80007f9a:	5398                	lw	a4,32(a5)
    80007f9c:	4fdc                	lw	a5,28(a5)
    80007f9e:	f6f751e3          	bge	a4,a5,80007f00 <tcp_input_state+0x31a>
	__list_del(list->prev, list->next);
    80007fa2:	64b8                	ld	a4,72(s1)
    80007fa4:	68bc                	ld	a5,80(s1)
	prev->next = next;
    80007fa6:	e71c                	sd	a5,8(a4)
	next->prev = prev;
    80007fa8:	e398                	sd	a4,0(a5)
	list->prev = NULL;
    80007faa:	0404b423          	sd	zero,72(s1)
	list->next = NULL;
    80007fae:	0404b823          	sd	zero,80(s1)
  list_add(&ts->list, &ts->parent->accept_queue);
    80007fb2:	04848793          	add	a5,s1,72
    80007fb6:	74b8                	ld	a4,104(s1)
	__list_add(list, head, head->next);
    80007fb8:	6334                	ld	a3,64(a4)
    80007fba:	03870613          	add	a2,a4,56
	list->prev = prev;
    80007fbe:	e4b0                	sd	a2,72(s1)
	list->next = next;
    80007fc0:	e8b4                	sd	a3,80(s1)
	next->prev = list;
    80007fc2:	e29c                	sd	a5,0(a3)
	prev->next = list;
    80007fc4:	e33c                	sd	a5,64(a4)
  ts->parent->accept_backlog++;
    80007fc6:	74b8                	ld	a4,104(s1)
    80007fc8:	531c                	lw	a5,32(a4)
    80007fca:	2785                	addw	a5,a5,1
    80007fcc:	d31c                	sw	a5,32(a4)
  wakeup(&ts->parent->wait_accept);
    80007fce:	74a8                	ld	a0,104(s1)
    80007fd0:	05c50513          	add	a0,a0,92
    80007fd4:	ffffa097          	auipc	ra,0xffffa
    80007fd8:	90a080e7          	jalr	-1782(ra) # 800018de <wakeup>
        ts->tcb.snd_una = th->ack_seq;
    80007fdc:	00892783          	lw	a5,8(s2)
    80007fe0:	d8bc                	sw	a5,112(s1)
  ts->tcb.snd_wnd = th->window;
    80007fe2:	00e95783          	lhu	a5,14(s2)
    80007fe6:	dcbc                	sw	a5,120(s1)
  ts->tcb.snd_wl1 = th->seq;
    80007fe8:	00492783          	lw	a5,4(s2)
    80007fec:	08f4a023          	sw	a5,128(s1)
  ts->tcb.snd_wl2 = th->ack_seq;
    80007ff0:	00892783          	lw	a5,8(s2)
    80007ff4:	08f4a223          	sw	a5,132(s1)
        tcp_set_state(ts, TCP_ESTABLISHED);
    80007ff8:	458d                	li	a1,3
    80007ffa:	8526                	mv	a0,s1
    80007ffc:	fffff097          	auipc	ra,0xfffff
    80008000:	1d0080e7          	jalr	464(ra) # 800071cc <tcp_set_state>
  switch (ts->state) {
    80008004:	09c4a783          	lw	a5,156(s1)
    80008008:	37f5                	addw	a5,a5,-3
    8000800a:	4709                	li	a4,2
    8000800c:	02f76263          	bltu	a4,a5,80008030 <tcp_input_state+0x44a>
      if (th->psh || m->len > 0)
    80008010:	00c95783          	lhu	a5,12(s2)
    80008014:	03479713          	sll	a4,a5,0x34
    80008018:	00074563          	bltz	a4,80008022 <tcp_input_state+0x43c>
    8000801c:	0109a783          	lw	a5,16(s3)
    80008020:	cb81                	beqz	a5,80008030 <tcp_input_state+0x44a>
        tcp_data_queue(ts, th, m);
    80008022:	864e                	mv	a2,s3
    80008024:	85ca                	mv	a1,s2
    80008026:	8526                	mv	a0,s1
    80008028:	00000097          	auipc	ra,0x0
    8000802c:	69e080e7          	jalr	1694(ra) # 800086c6 <tcp_data_queue>
  if (th->fin && m->seq == ts->tcb.rcv_nxt) {
    80008030:	00c95783          	lhu	a5,12(s2)
    80008034:	1007f793          	and	a5,a5,256
    80008038:	ec0784e3          	beqz	a5,80007f00 <tcp_input_state+0x31a>
    8000803c:	08c4a703          	lw	a4,140(s1)
    80008040:	6785                	lui	a5,0x1
    80008042:	97ce                	add	a5,a5,s3
    80008044:	8187a783          	lw	a5,-2024(a5) # 818 <_entry-0x7ffff7e8>
    80008048:	eae79ce3          	bne	a5,a4,80007f00 <tcp_input_state+0x31a>
    switch (ts->state) {
    8000804c:	09c4a783          	lw	a5,156(s1)
    80008050:	4685                	li	a3,1
    80008052:	eaf6f7e3          	bgeu	a3,a5,80007f00 <tcp_input_state+0x31a>
    80008056:	4699                	li	a3,6
    80008058:	ead784e3          	beq	a5,a3,80007f00 <tcp_input_state+0x31a>
    ts->tcb.rcv_nxt += 1;
    8000805c:	2705                	addw	a4,a4,1
    8000805e:	08e4a623          	sw	a4,140(s1)
    ts->flags |= TCP_FIN;
    80008062:	0a04a783          	lw	a5,160(s1)
    80008066:	0017e793          	or	a5,a5,1
    8000806a:	0af4a023          	sw	a5,160(s1)
    tcp_send_ack(ts);
    8000806e:	8526                	mv	a0,s1
    80008070:	00000097          	auipc	ra,0x0
    80008074:	93c080e7          	jalr	-1732(ra) # 800079ac <tcp_send_ack>
    wakeup(&ts->wait_rcv);
    80008078:	06048513          	add	a0,s1,96
    8000807c:	ffffa097          	auipc	ra,0xffffa
    80008080:	862080e7          	jalr	-1950(ra) # 800018de <wakeup>
    switch (ts->state) {
    80008084:	09c4a783          	lw	a5,156(s1)
    80008088:	4711                	li	a4,4
    8000808a:	0ce78c63          	beq	a5,a4,80008162 <tcp_input_state+0x57c>
    8000808e:	0af76563          	bltu	a4,a5,80008138 <tcp_input_state+0x552>
    80008092:	37f9                	addw	a5,a5,-2
    80008094:	4705                	li	a4,1
    80008096:	e6f765e3          	bltu	a4,a5,80007f00 <tcp_input_state+0x31a>
        tcp_set_state(ts, TCP_CLOSE_WAIT);
    8000809a:	459d                	li	a1,7
    8000809c:	8526                	mv	a0,s1
    8000809e:	fffff097          	auipc	ra,0xfffff
    800080a2:	12e080e7          	jalr	302(ra) # 800071cc <tcp_set_state>
        break;
    800080a6:	bda9                	j	80007f00 <tcp_input_state+0x31a>
          tcp_set_state(ts, TCP_FIN_WAIT_2);
    800080a8:	4595                	li	a1,5
    800080aa:	8526                	mv	a0,s1
    800080ac:	fffff097          	auipc	ra,0xfffff
    800080b0:	120080e7          	jalr	288(ra) # 800071cc <tcp_set_state>
    800080b4:	b5e9                	j	80007f7e <tcp_input_state+0x398>
          tcp_set_state(ts, TCP_TIME_WAIT);
    800080b6:	45a9                	li	a1,10
    800080b8:	8526                	mv	a0,s1
    800080ba:	fffff097          	auipc	ra,0xfffff
    800080be:	112080e7          	jalr	274(ra) # 800071cc <tcp_set_state>
          timer_add(TCP_TIMEWAIT_TIMEOUT, tcp_timewait_timer, ts);
    800080c2:	8626                	mv	a2,s1
    800080c4:	00000597          	auipc	a1,0x0
    800080c8:	ada58593          	add	a1,a1,-1318 # 80007b9e <tcp_timewait_timer>
    800080cc:	0c800513          	li	a0,200
    800080d0:	00001097          	auipc	ra,0x1
    800080d4:	ade080e7          	jalr	-1314(ra) # 80008bae <timer_add>
          goto drop;
    800080d8:	b525                	j	80007f00 <tcp_input_state+0x31a>
            release(&ts->spinlk);
    800080da:	0f048513          	add	a0,s1,240
    800080de:	00002097          	auipc	ra,0x2
    800080e2:	85a080e7          	jalr	-1958(ra) # 80009938 <release>
            tcp_done(ts);
    800080e6:	8526                	mv	a0,s1
    800080e8:	fffff097          	auipc	ra,0xfffff
    800080ec:	3fe080e7          	jalr	1022(ra) # 800074e6 <tcp_done>
            mbuffree(m);
    800080f0:	854e                	mv	a0,s3
    800080f2:	fffff097          	auipc	ra,0xfffff
    800080f6:	03a080e7          	jalr	58(ra) # 8000712c <mbuffree>
            return 1;
    800080fa:	4505                	li	a0,1
    800080fc:	bba9                	j	80007e56 <tcp_input_state+0x270>
      } else if (th->ack_seq > ts->tcb.snd_nxt) { /* something not yet sent */
    800080fe:	58fc                	lw	a5,116(s1)
    80008100:	e0e7e0e3          	bltu	a5,a4,80007f00 <tcp_input_state+0x31a>
  if ((ts->tcb.snd_una <= th->ack_seq && th->ack_seq <= ts->tcb.snd_nxt) && 
    80008104:	f0e690e3          	bne	a3,a4,80008004 <tcp_input_state+0x41e>
      (ts->tcb.snd_wl1 < th->seq || 
    80008108:	0804a683          	lw	a3,128(s1)
    8000810c:	00492783          	lw	a5,4(s2)
  if ((ts->tcb.snd_una <= th->ack_seq && th->ack_seq <= ts->tcb.snd_nxt) && 
    80008110:	00f6e863          	bltu	a3,a5,80008120 <tcp_input_state+0x53a>
      (ts->tcb.snd_wl1 < th->seq || 
    80008114:	eef698e3          	bne	a3,a5,80008004 <tcp_input_state+0x41e>
        (ts->tcb.snd_wl1 == th->seq && ts->tcb.snd_wl2 <= th->ack_seq)))
    80008118:	0844a783          	lw	a5,132(s1)
    8000811c:	eef764e3          	bltu	a4,a5,80008004 <tcp_input_state+0x41e>
  ts->tcb.snd_wnd = th->window;
    80008120:	00e95783          	lhu	a5,14(s2)
    80008124:	dcbc                	sw	a5,120(s1)
  ts->tcb.snd_wl1 = th->seq;
    80008126:	00492783          	lw	a5,4(s2)
    8000812a:	08f4a023          	sw	a5,128(s1)
  ts->tcb.snd_wl2 = th->ack_seq;
    8000812e:	00892783          	lw	a5,8(s2)
    80008132:	08f4a223          	sw	a5,132(s1)
}
    80008136:	b5f9                	j	80008004 <tcp_input_state+0x41e>
    switch (ts->state) {
    80008138:	4715                	li	a4,5
    8000813a:	dce793e3          	bne	a5,a4,80007f00 <tcp_input_state+0x31a>
        tcp_set_state(ts, TCP_TIME_WAIT);
    8000813e:	45a9                	li	a1,10
    80008140:	8526                	mv	a0,s1
    80008142:	fffff097          	auipc	ra,0xfffff
    80008146:	08a080e7          	jalr	138(ra) # 800071cc <tcp_set_state>
        timer_add(TCP_TIMEWAIT_TIMEOUT, tcp_timewait_timer, ts);
    8000814a:	8626                	mv	a2,s1
    8000814c:	00000597          	auipc	a1,0x0
    80008150:	a5258593          	add	a1,a1,-1454 # 80007b9e <tcp_timewait_timer>
    80008154:	0c800513          	li	a0,200
    80008158:	00001097          	auipc	ra,0x1
    8000815c:	a56080e7          	jalr	-1450(ra) # 80008bae <timer_add>
        break;
    80008160:	b345                	j	80007f00 <tcp_input_state+0x31a>
        if (mbuf_queue_empty(&ts->write_queue)) {
    80008162:	0e84a783          	lw	a5,232(s1)
    80008166:	e39d                	bnez	a5,8000818c <tcp_input_state+0x5a6>
          tcp_set_state(ts, TCP_TIME_WAIT);
    80008168:	45a9                	li	a1,10
    8000816a:	8526                	mv	a0,s1
    8000816c:	fffff097          	auipc	ra,0xfffff
    80008170:	060080e7          	jalr	96(ra) # 800071cc <tcp_set_state>
          timer_add(TCP_TIMEWAIT_TIMEOUT, tcp_timewait_timer, ts);
    80008174:	8626                	mv	a2,s1
    80008176:	00000597          	auipc	a1,0x0
    8000817a:	a2858593          	add	a1,a1,-1496 # 80007b9e <tcp_timewait_timer>
    8000817e:	0c800513          	li	a0,200
    80008182:	00001097          	auipc	ra,0x1
    80008186:	a2c080e7          	jalr	-1492(ra) # 80008bae <timer_add>
    8000818a:	bb9d                	j	80007f00 <tcp_input_state+0x31a>
          tcp_set_state(ts, TCP_CLOSING);
    8000818c:	45a1                	li	a1,8
    8000818e:	8526                	mv	a0,s1
    80008190:	fffff097          	auipc	ra,0xfffff
    80008194:	03c080e7          	jalr	60(ra) # 800071cc <tcp_set_state>
    80008198:	b3a5                	j	80007f00 <tcp_input_state+0x31a>

000000008000819a <tcp_receive>:

int
tcp_receive(struct tcp_sock *ts, uint64 ubuf, int len)
{
    8000819a:	7139                	add	sp,sp,-64
    8000819c:	fc06                	sd	ra,56(sp)
    8000819e:	f822                	sd	s0,48(sp)
    800081a0:	f426                	sd	s1,40(sp)
    800081a2:	0080                	add	s0,sp,64
  int rlen = 0;
  int curlen = 0;
  
  while (rlen < len) {
    800081a4:	06c05f63          	blez	a2,80008222 <tcp_receive+0x88>
    800081a8:	f04a                	sd	s2,32(sp)
    800081aa:	ec4e                	sd	s3,24(sp)
    800081ac:	e852                	sd	s4,16(sp)
    800081ae:	e456                	sd	s5,8(sp)
    800081b0:	e05a                	sd	s6,0(sp)
    800081b2:	89aa                	mv	s3,a0
    800081b4:	8a2e                	mv	s4,a1
    800081b6:	8932                	mv	s2,a2
  int rlen = 0;
    800081b8:	4481                	li	s1,0

    if (ts->flags & TCP_FIN || rlen == len)
      break;

    if (rlen < len) {
      sleep(&ts->wait_rcv, &ts->spinlk);
    800081ba:	0f050b13          	add	s6,a0,240
    800081be:	06050a93          	add	s5,a0,96
    800081c2:	a005                	j	800081e2 <tcp_receive+0x48>
      ts->flags &= ~TCP_PSH;
    800081c4:	9bdd                	and	a5,a5,-9
    800081c6:	0af9a023          	sw	a5,160(s3)
      break;
    800081ca:	7902                	ld	s2,32(sp)
    800081cc:	69e2                	ld	s3,24(sp)
    800081ce:	6a42                	ld	s4,16(sp)
    800081d0:	6aa2                	ld	s5,8(sp)
    800081d2:	6b02                	ld	s6,0(sp)
    800081d4:	a089                	j	80008216 <tcp_receive+0x7c>
      sleep(&ts->wait_rcv, &ts->spinlk);
    800081d6:	85da                	mv	a1,s6
    800081d8:	8556                	mv	a0,s5
    800081da:	ffff9097          	auipc	ra,0xffff9
    800081de:	584080e7          	jalr	1412(ra) # 8000175e <sleep>
    curlen = tcp_data_dequeue(ts, ubuf + rlen, len - rlen);
    800081e2:	4099063b          	subw	a2,s2,s1
    800081e6:	014485b3          	add	a1,s1,s4
    800081ea:	854e                	mv	a0,s3
    800081ec:	00000097          	auipc	ra,0x0
    800081f0:	63c080e7          	jalr	1596(ra) # 80008828 <tcp_data_dequeue>
    rlen += curlen;
    800081f4:	9ca9                	addw	s1,s1,a0
    if (ts->flags & TCP_PSH) {
    800081f6:	0a09a783          	lw	a5,160(s3)
    800081fa:	0087f713          	and	a4,a5,8
    800081fe:	f379                	bnez	a4,800081c4 <tcp_receive+0x2a>
    if (ts->flags & TCP_FIN || rlen == len)
    80008200:	8b85                	and	a5,a5,1
    80008202:	e395                	bnez	a5,80008226 <tcp_receive+0x8c>
    80008204:	02990763          	beq	s2,s1,80008232 <tcp_receive+0x98>
    if (rlen < len) {
    80008208:	fd24c7e3          	blt	s1,s2,800081d6 <tcp_receive+0x3c>
    8000820c:	7902                	ld	s2,32(sp)
    8000820e:	69e2                	ld	s3,24(sp)
    80008210:	6a42                	ld	s4,16(sp)
    80008212:	6aa2                	ld	s5,8(sp)
    80008214:	6b02                	ld	s6,0(sp)
    }
    
  }

  return rlen;
}
    80008216:	8526                	mv	a0,s1
    80008218:	70e2                	ld	ra,56(sp)
    8000821a:	7442                	ld	s0,48(sp)
    8000821c:	74a2                	ld	s1,40(sp)
    8000821e:	6121                	add	sp,sp,64
    80008220:	8082                	ret
  int rlen = 0;
    80008222:	4481                	li	s1,0
    80008224:	bfcd                	j	80008216 <tcp_receive+0x7c>
    80008226:	7902                	ld	s2,32(sp)
    80008228:	69e2                	ld	s3,24(sp)
    8000822a:	6a42                	ld	s4,16(sp)
    8000822c:	6aa2                	ld	s5,8(sp)
    8000822e:	6b02                	ld	s6,0(sp)
    80008230:	b7dd                	j	80008216 <tcp_receive+0x7c>
    80008232:	7902                	ld	s2,32(sp)
    80008234:	69e2                	ld	s3,24(sp)
    80008236:	6a42                	ld	s4,16(sp)
    80008238:	6aa2                	ld	s5,8(sp)
    8000823a:	6b02                	ld	s6,0(sp)
    8000823c:	bfe9                	j	80008216 <tcp_receive+0x7c>

000000008000823e <tcp_sock_alloc>:

extern uint32 local_ip;

struct tcp_sock *
tcp_sock_alloc()
{
    8000823e:	1101                	add	sp,sp,-32
    80008240:	ec06                	sd	ra,24(sp)
    80008242:	e822                	sd	s0,16(sp)
    80008244:	e426                	sd	s1,8(sp)
    80008246:	1000                	add	s0,sp,32
  struct tcp_sock *ts = (struct tcp_sock *)kalloc();
    80008248:	ffff8097          	auipc	ra,0xffff8
    8000824c:	ed2080e7          	jalr	-302(ra) # 8000011a <kalloc>
    80008250:	84aa                	mv	s1,a0
  if (!ts) return NULL;
    80008252:	c951                	beqz	a0,800082e6 <tcp_sock_alloc+0xa8>
  memset(ts, 0, sizeof(*ts));
    80008254:	10800613          	li	a2,264
    80008258:	4581                	li	a1,0
    8000825a:	ffff8097          	auipc	ra,0xffff8
    8000825e:	f20080e7          	jalr	-224(ra) # 8000017a <memset>

  ts->saddr = local_ip;
    80008262:	00004797          	auipc	a5,0x4
    80008266:	9067a783          	lw	a5,-1786(a5) # 8000bb68 <local_ip>
    8000826a:	c89c                	sw	a5,16(s1)
  ts->state = TCP_CLOSE;
    8000826c:	4799                	li	a5,6
    8000826e:	08f4ae23          	sw	a5,156(s1)
  ts->tcb.rcv_wnd = TCP_DEFAULT_WINDOW;
    80008272:	67a9                	lui	a5,0xa
    80008274:	08f4a823          	sw	a5,144(s1)

  list_init(&ts->listen_queue);
    80008278:	02848793          	add	a5,s1,40
	head->prev = head->next = head;
    8000827c:	f89c                	sd	a5,48(s1)
    8000827e:	f49c                	sd	a5,40(s1)
  list_init(&ts->accept_queue);
    80008280:	03848793          	add	a5,s1,56
    80008284:	e0bc                	sd	a5,64(s1)
    80008286:	fc9c                	sd	a5,56(s1)
    80008288:	0a848793          	add	a5,s1,168
    8000828c:	f8dc                	sd	a5,176(s1)
    8000828e:	f4dc                	sd	a5,168(s1)
    80008290:	0c048793          	add	a5,s1,192
    80008294:	e4fc                	sd	a5,200(s1)
    80008296:	e0fc                	sd	a5,192(s1)
    80008298:	0d848793          	add	a5,s1,216
    8000829c:	f0fc                	sd	a5,224(s1)
    8000829e:	ecfc                	sd	a5,216(s1)
  
  mbuf_queue_init(&ts->ofo_queue);
  mbuf_queue_init(&ts->rcv_queue);
  mbuf_queue_init(&ts->write_queue);

  initlock(&ts->spinlk, "tcp sock lock");
    800082a0:	00003597          	auipc	a1,0x3
    800082a4:	5e058593          	add	a1,a1,1504 # 8000b880 <etext+0x880>
    800082a8:	0f048513          	add	a0,s1,240
    800082ac:	00001097          	auipc	ra,0x1
    800082b0:	536080e7          	jalr	1334(ra) # 800097e2 <initlock>

  acquire(&tcpsocks_list_lk);
    800082b4:	00037517          	auipc	a0,0x37
    800082b8:	09450513          	add	a0,a0,148 # 8003f348 <tcpsocks_list_lk>
    800082bc:	00001097          	auipc	ra,0x1
    800082c0:	5b6080e7          	jalr	1462(ra) # 80009872 <acquire>
	__list_add(list, head, head->next);
    800082c4:	00037797          	auipc	a5,0x37
    800082c8:	09c78793          	add	a5,a5,156 # 8003f360 <tcpsocks_list_head>
    800082cc:	6798                	ld	a4,8(a5)
	list->prev = prev;
    800082ce:	e09c                	sd	a5,0(s1)
	list->next = next;
    800082d0:	e498                	sd	a4,8(s1)
	next->prev = list;
    800082d2:	e304                	sd	s1,0(a4)
	prev->next = list;
    800082d4:	e784                	sd	s1,8(a5)
  list_add(&ts->tcpsock_list, &tcpsocks_list_head);
  release(&tcpsocks_list_lk);
    800082d6:	00037517          	auipc	a0,0x37
    800082da:	07250513          	add	a0,a0,114 # 8003f348 <tcpsocks_list_lk>
    800082de:	00001097          	auipc	ra,0x1
    800082e2:	65a080e7          	jalr	1626(ra) # 80009938 <release>
  
  return ts;
}
    800082e6:	8526                	mv	a0,s1
    800082e8:	60e2                	ld	ra,24(sp)
    800082ea:	6442                	ld	s0,16(sp)
    800082ec:	64a2                	ld	s1,8(sp)
    800082ee:	6105                	add	sp,sp,32
    800082f0:	8082                	ret

00000000800082f2 <tcp_bind>:

int
tcp_bind(struct file *f, struct sockaddr *addr, int addrlen)
{
  if (addr->sa_family != AF_INET) {
    800082f2:	0005d783          	lhu	a5,0(a1)
    800082f6:	eb9d                	bnez	a5,8000832c <tcp_bind+0x3a>
    return -1;
  }

  struct sockaddr_in *sin = (struct sockaddr_in *)addr;
  
  if (sin->sin_port >= MAX_PORT_N)
    800082f8:	0025d583          	lhu	a1,2(a1)
    800082fc:	0005869b          	sext.w	a3,a1
    80008300:	6785                	lui	a5,0x1
    80008302:	38778793          	add	a5,a5,903 # 1387 <_entry-0x7fffec79>
    return -1;
    80008306:	577d                	li	a4,-1
  if (sin->sin_port >= MAX_PORT_N)
    80008308:	02d7e363          	bltu	a5,a3,8000832e <tcp_bind+0x3c>
{
    8000830c:	1141                	add	sp,sp,-16
    8000830e:	e406                	sd	ra,8(sp)
    80008310:	e022                	sd	s0,0(sp)
    80008312:	0800                	add	s0,sp,16
  
  int r = alloc_port(f, sin->sin_port);
    80008314:	00000097          	auipc	ra,0x0
    80008318:	64c080e7          	jalr	1612(ra) # 80008960 <alloc_port>
  if (r) return 1;
  else return -1;
    8000831c:	577d                	li	a4,-1
  if (r) return 1;
    8000831e:	c111                	beqz	a0,80008322 <tcp_bind+0x30>
    80008320:	4705                	li	a4,1
}
    80008322:	853a                	mv	a0,a4
    80008324:	60a2                	ld	ra,8(sp)
    80008326:	6402                	ld	s0,0(sp)
    80008328:	0141                	add	sp,sp,16
    8000832a:	8082                	ret
    return -1;
    8000832c:	577d                	li	a4,-1
}
    8000832e:	853a                	mv	a0,a4
    80008330:	8082                	ret

0000000080008332 <tcp_connect>:

int
tcp_connect(struct file *f, struct sockaddr *addr, int addrlen, int port)
{
    80008332:	7179                	add	sp,sp,-48
    80008334:	f406                	sd	ra,40(sp)
    80008336:	f022                	sd	s0,32(sp)
    80008338:	ec26                	sd	s1,24(sp)
    8000833a:	e84a                	sd	s2,16(sp)
    8000833c:	e44e                	sd	s3,8(sp)
    8000833e:	e052                	sd	s4,0(sp)
    80008340:	1800                	add	s0,sp,48
    80008342:	892e                	mv	s2,a1
    80008344:	89b6                	mv	s3,a3
  struct tcp_sock *ts = f->tcpsock;
    80008346:	7504                	ld	s1,40(a0)
  acquire(&ts->spinlk);
    80008348:	0f048a13          	add	s4,s1,240
    8000834c:	8552                	mv	a0,s4
    8000834e:	00001097          	auipc	ra,0x1
    80008352:	524080e7          	jalr	1316(ra) # 80009872 <acquire>
  if (ts->state != TCP_CLOSE) {
    80008356:	09c4a703          	lw	a4,156(s1)
    8000835a:	4799                	li	a5,6
    8000835c:	06f71c63          	bne	a4,a5,800083d4 <tcp_connect+0xa2>
    release(&ts->spinlk);
    return -1;
  }

  struct sockaddr_in *sin = (struct sockaddr_in *)addr;
  ts->sport = port;
    80008360:	01349c23          	sh	s3,24(s1)
  ts->daddr = sin->sin_addr;
    80008364:	00492783          	lw	a5,4(s2)
    80008368:	c8dc                	sw	a5,20(s1)
  ts->dport = sin->sin_port;
    8000836a:	00295783          	lhu	a5,2(s2)
    8000836e:	00f49d23          	sh	a5,26(s1)
  ts->saddr = local_ip;
    80008372:	00003797          	auipc	a5,0x3
    80008376:	7f67a783          	lw	a5,2038(a5) # 8000bb68 <local_ip>
    8000837a:	c89c                	sw	a5,16(s1)
  /* three-way handshake starts, send first SYN */
  ts->state = TCP_SYN_SENT;
    8000837c:	4785                	li	a5,1
    8000837e:	08f4ae23          	sw	a5,156(s1)
  ts->tcb.iss = alloc_new_iss();
    80008382:	00000097          	auipc	ra,0x0
    80008386:	836080e7          	jalr	-1994(ra) # 80007bb8 <alloc_new_iss>
    8000838a:	2501                	sext.w	a0,a0
    8000838c:	08a4a423          	sw	a0,136(s1)
  ts->tcb.snd_una = ts->tcb.iss;
    80008390:	d8a8                	sw	a0,112(s1)
  ts->tcb.snd_nxt = ts->tcb.iss + 1;
    80008392:	2505                	addw	a0,a0,1
    80008394:	d8e8                	sw	a0,116(s1)

  tcp_send_syn(ts);
    80008396:	8526                	mv	a0,s1
    80008398:	fffff097          	auipc	ra,0xfffff
    8000839c:	5b6080e7          	jalr	1462(ra) # 8000794e <tcp_send_syn>

  sleep(&ts->wait_connect, &ts->spinlk);
    800083a0:	85d2                	mv	a1,s4
    800083a2:	05848513          	add	a0,s1,88
    800083a6:	ffff9097          	auipc	ra,0xffff9
    800083aa:	3b8080e7          	jalr	952(ra) # 8000175e <sleep>
  if (ts->state != TCP_ESTABLISHED) {
    800083ae:	09c4a703          	lw	a4,156(s1)
    800083b2:	478d                	li	a5,3
    800083b4:	02f71763          	bne	a4,a5,800083e2 <tcp_connect+0xb0>
    tcp_set_state(ts, TCP_CLOSE);
    return -1;
  }
  tcpdbg("TCP CLIENT ESTABLISHED SUCCESS, sport: %d\n", port);

  release(&ts->spinlk);
    800083b8:	8552                	mv	a0,s4
    800083ba:	00001097          	auipc	ra,0x1
    800083be:	57e080e7          	jalr	1406(ra) # 80009938 <release>

  return 0; 
    800083c2:	4501                	li	a0,0
}
    800083c4:	70a2                	ld	ra,40(sp)
    800083c6:	7402                	ld	s0,32(sp)
    800083c8:	64e2                	ld	s1,24(sp)
    800083ca:	6942                	ld	s2,16(sp)
    800083cc:	69a2                	ld	s3,8(sp)
    800083ce:	6a02                	ld	s4,0(sp)
    800083d0:	6145                	add	sp,sp,48
    800083d2:	8082                	ret
    release(&ts->spinlk);
    800083d4:	8552                	mv	a0,s4
    800083d6:	00001097          	auipc	ra,0x1
    800083da:	562080e7          	jalr	1378(ra) # 80009938 <release>
    return -1;
    800083de:	557d                	li	a0,-1
    800083e0:	b7d5                	j	800083c4 <tcp_connect+0x92>
    release(&ts->spinlk);
    800083e2:	8552                	mv	a0,s4
    800083e4:	00001097          	auipc	ra,0x1
    800083e8:	554080e7          	jalr	1364(ra) # 80009938 <release>
    tcp_set_state(ts, TCP_CLOSE);
    800083ec:	4599                	li	a1,6
    800083ee:	8526                	mv	a0,s1
    800083f0:	fffff097          	auipc	ra,0xfffff
    800083f4:	ddc080e7          	jalr	-548(ra) # 800071cc <tcp_set_state>
    return -1;
    800083f8:	557d                	li	a0,-1
    800083fa:	b7e9                	j	800083c4 <tcp_connect+0x92>

00000000800083fc <tcp_listen>:

int
tcp_listen(struct file *f, int backlog)
{
    800083fc:	7179                	add	sp,sp,-48
    800083fe:	f406                	sd	ra,40(sp)
    80008400:	f022                	sd	s0,32(sp)
    80008402:	ec26                	sd	s1,24(sp)
    80008404:	e84a                	sd	s2,16(sp)
    80008406:	e44e                	sd	s3,8(sp)
    80008408:	1800                	add	s0,sp,48
    8000840a:	892e                	mv	s2,a1
  struct tcp_sock *ts = f->tcpsock;
    8000840c:	7504                	ld	s1,40(a0)
  acquire(&ts->spinlk);
    8000840e:	0f048993          	add	s3,s1,240
    80008412:	854e                	mv	a0,s3
    80008414:	00001097          	auipc	ra,0x1
    80008418:	45e080e7          	jalr	1118(ra) # 80009872 <acquire>
  if (backlog > TCP_MAX_BACKLOG) {
    8000841c:	08000793          	li	a5,128
    80008420:	0327cb63          	blt	a5,s2,80008456 <tcp_listen+0x5a>
    release(&ts->spinlk);
    return -1;
  }
    
  if (ts->state != TCP_CLOSE || !ts->sport) {
    80008424:	09c4a703          	lw	a4,156(s1)
    80008428:	4799                	li	a5,6
    8000842a:	02f71d63          	bne	a4,a5,80008464 <tcp_listen+0x68>
    8000842e:	0184d783          	lhu	a5,24(s1)
    80008432:	cb8d                	beqz	a5,80008464 <tcp_listen+0x68>
    release(&ts->spinlk);
    return -1;
  }
    
  ts->state = TCP_LISTEN;
    80008434:	0804ae23          	sw	zero,156(s1)
  ts->backlog = backlog;
    80008438:	0124ae23          	sw	s2,28(s1)

  release(&ts->spinlk);
    8000843c:	854e                	mv	a0,s3
    8000843e:	00001097          	auipc	ra,0x1
    80008442:	4fa080e7          	jalr	1274(ra) # 80009938 <release>

  return 0;
    80008446:	4501                	li	a0,0
}
    80008448:	70a2                	ld	ra,40(sp)
    8000844a:	7402                	ld	s0,32(sp)
    8000844c:	64e2                	ld	s1,24(sp)
    8000844e:	6942                	ld	s2,16(sp)
    80008450:	69a2                	ld	s3,8(sp)
    80008452:	6145                	add	sp,sp,48
    80008454:	8082                	ret
    release(&ts->spinlk);
    80008456:	854e                	mv	a0,s3
    80008458:	00001097          	auipc	ra,0x1
    8000845c:	4e0080e7          	jalr	1248(ra) # 80009938 <release>
    return -1;
    80008460:	557d                	li	a0,-1
    80008462:	b7dd                	j	80008448 <tcp_listen+0x4c>
    release(&ts->spinlk);
    80008464:	854e                	mv	a0,s3
    80008466:	00001097          	auipc	ra,0x1
    8000846a:	4d2080e7          	jalr	1234(ra) # 80009938 <release>
    return -1;
    8000846e:	557d                	li	a0,-1
    80008470:	bfe1                	j	80008448 <tcp_listen+0x4c>

0000000080008472 <tcp_accept>:
}


struct tcp_sock *
tcp_accept(struct file *f)
{
    80008472:	7179                	add	sp,sp,-48
    80008474:	f406                	sd	ra,40(sp)
    80008476:	f022                	sd	s0,32(sp)
    80008478:	ec26                	sd	s1,24(sp)
    8000847a:	e84a                	sd	s2,16(sp)
    8000847c:	e44e                	sd	s3,8(sp)
    8000847e:	1800                	add	s0,sp,48
  struct tcp_sock *ts = f->tcpsock;
    80008480:	7504                	ld	s1,40(a0)
  acquire(&ts->spinlk);
    80008482:	0f048913          	add	s2,s1,240
    80008486:	854a                	mv	a0,s2
    80008488:	00001097          	auipc	ra,0x1
    8000848c:	3ea080e7          	jalr	1002(ra) # 80009872 <acquire>

  while (list_empty(&ts->accept_queue)) {
    80008490:	0404b983          	ld	s3,64(s1)
    80008494:	03848793          	add	a5,s1,56
    80008498:	04f99763          	bne	s3,a5,800084e6 <tcp_accept+0x74>
    8000849c:	e052                	sd	s4,0(sp)
    sleep(&ts->wait_accept, &ts->spinlk);
    8000849e:	05c48a13          	add	s4,s1,92
    800084a2:	85ca                	mv	a1,s2
    800084a4:	8552                	mv	a0,s4
    800084a6:	ffff9097          	auipc	ra,0xffff9
    800084aa:	2b8080e7          	jalr	696(ra) # 8000175e <sleep>
  while (list_empty(&ts->accept_queue)) {
    800084ae:	60bc                	ld	a5,64(s1)
    800084b0:	ff3789e3          	beq	a5,s3,800084a2 <tcp_accept+0x30>
    800084b4:	6a02                	ld	s4,0(sp)
  list_del_init(&newts->list);
    800084b6:	fb878993          	add	s3,a5,-72
}

static _inline void list_del_init(struct list_head *list)
{
	__list_del(list->prev, list->next);
    800084ba:	6394                	ld	a3,0(a5)
    800084bc:	6798                	ld	a4,8(a5)
	prev->next = next;
    800084be:	e698                	sd	a4,8(a3)
	next->prev = prev;
    800084c0:	e314                	sd	a3,0(a4)
	list->prev = list;
    800084c2:	e39c                	sd	a5,0(a5)
	list->next = list;
    800084c4:	e79c                	sd	a5,8(a5)
  ts->accept_backlog--;
    800084c6:	509c                	lw	a5,32(s1)
    800084c8:	37fd                	addw	a5,a5,-1
    800084ca:	d09c                	sw	a5,32(s1)
  }

  struct tcp_sock *newts = tcp_accept_dequeue(ts);

  release(&ts->spinlk);
    800084cc:	854a                	mv	a0,s2
    800084ce:	00001097          	auipc	ra,0x1
    800084d2:	46a080e7          	jalr	1130(ra) # 80009938 <release>

  return newts;
}
    800084d6:	854e                	mv	a0,s3
    800084d8:	70a2                	ld	ra,40(sp)
    800084da:	7402                	ld	s0,32(sp)
    800084dc:	64e2                	ld	s1,24(sp)
    800084de:	6942                	ld	s2,16(sp)
    800084e0:	69a2                	ld	s3,8(sp)
    800084e2:	6145                	add	sp,sp,48
    800084e4:	8082                	ret
  while (list_empty(&ts->accept_queue)) {
    800084e6:	87ce                	mv	a5,s3
    800084e8:	b7f9                	j	800084b6 <tcp_accept+0x44>

00000000800084ea <tcp_read>:

int
tcp_read(struct file *f, uint64 addr, int n)
{
    800084ea:	7179                	add	sp,sp,-48
    800084ec:	f406                	sd	ra,40(sp)
    800084ee:	f022                	sd	s0,32(sp)
    800084f0:	ec26                	sd	s1,24(sp)
    800084f2:	1800                	add	s0,sp,48
  int rlen = 0;
  struct tcp_sock *ts = f->tcpsock;
    800084f4:	7504                	ld	s1,40(a0)
  if (!ts) return -1;
    800084f6:	c8a5                	beqz	s1,80008566 <tcp_read+0x7c>
    800084f8:	e84a                	sd	s2,16(sp)
    800084fa:	e44e                	sd	s3,8(sp)
    800084fc:	e052                	sd	s4,0(sp)
    800084fe:	892e                	mv	s2,a1
    80008500:	89b2                	mv	s3,a2
  
  acquire(&ts->spinlk);
    80008502:	0f048a13          	add	s4,s1,240
    80008506:	8552                	mv	a0,s4
    80008508:	00001097          	auipc	ra,0x1
    8000850c:	36a080e7          	jalr	874(ra) # 80009872 <acquire>
  switch (ts->state) {
    80008510:	09c4a703          	lw	a4,156(s1)
    80008514:	47a9                	li	a5,10
    80008516:	00e7e863          	bltu	a5,a4,80008526 <tcp_read+0x3c>
    8000851a:	74700793          	li	a5,1863
    8000851e:	00e7d7b3          	srl	a5,a5,a4
    80008522:	8b85                	and	a5,a5,1
    80008524:	e79d                	bnez	a5,80008552 <tcp_read+0x68>
  case TCP_FIN_WAIT_1:
  case TCP_FIN_WAIT_2:
    break;
  }

  rlen = tcp_receive(ts, addr, n);
    80008526:	864e                	mv	a2,s3
    80008528:	85ca                	mv	a1,s2
    8000852a:	8526                	mv	a0,s1
    8000852c:	00000097          	auipc	ra,0x0
    80008530:	c6e080e7          	jalr	-914(ra) # 8000819a <tcp_receive>
    80008534:	84aa                	mv	s1,a0
  release(&ts->spinlk);
    80008536:	8552                	mv	a0,s4
    80008538:	00001097          	auipc	ra,0x1
    8000853c:	400080e7          	jalr	1024(ra) # 80009938 <release>

  return rlen;
    80008540:	6942                	ld	s2,16(sp)
    80008542:	69a2                	ld	s3,8(sp)
    80008544:	6a02                	ld	s4,0(sp)
}
    80008546:	8526                	mv	a0,s1
    80008548:	70a2                	ld	ra,40(sp)
    8000854a:	7402                	ld	s0,32(sp)
    8000854c:	64e2                	ld	s1,24(sp)
    8000854e:	6145                	add	sp,sp,48
    80008550:	8082                	ret
    release(&ts->spinlk);
    80008552:	8552                	mv	a0,s4
    80008554:	00001097          	auipc	ra,0x1
    80008558:	3e4080e7          	jalr	996(ra) # 80009938 <release>
    return -1;
    8000855c:	54fd                	li	s1,-1
    8000855e:	6942                	ld	s2,16(sp)
    80008560:	69a2                	ld	s3,8(sp)
    80008562:	6a02                	ld	s4,0(sp)
    80008564:	b7cd                	j	80008546 <tcp_read+0x5c>
  if (!ts) return -1;
    80008566:	54fd                	li	s1,-1
    80008568:	bff9                	j	80008546 <tcp_read+0x5c>

000000008000856a <tcp_write>:

int
tcp_write(struct file *f, uint64 ubuf, int len)
{
    8000856a:	7179                	add	sp,sp,-48
    8000856c:	f406                	sd	ra,40(sp)
    8000856e:	f022                	sd	s0,32(sp)
    80008570:	ec26                	sd	s1,24(sp)
    80008572:	1800                	add	s0,sp,48
  struct tcp_sock *ts = f->tcpsock;
    80008574:	7504                	ld	s1,40(a0)
  if (!ts) return -1;
    80008576:	c0bd                	beqz	s1,800085dc <tcp_write+0x72>
    80008578:	e84a                	sd	s2,16(sp)
    8000857a:	e44e                	sd	s3,8(sp)
    8000857c:	e052                	sd	s4,0(sp)
    8000857e:	892e                	mv	s2,a1
    80008580:	89b2                	mv	s3,a2

  acquire(&ts->spinlk);
    80008582:	0f048a13          	add	s4,s1,240
    80008586:	8552                	mv	a0,s4
    80008588:	00001097          	auipc	ra,0x1
    8000858c:	2ea080e7          	jalr	746(ra) # 80009872 <acquire>
  switch (ts->state) {
    80008590:	09c4a783          	lw	a5,156(s1)
    80008594:	9bed                	and	a5,a5,-5
    80008596:	470d                	li	a4,3
    80008598:	00e78c63          	beq	a5,a4,800085b0 <tcp_write+0x46>
    case TCP_ESTABLISHED:
    case TCP_CLOSE_WAIT:
      break;
    default:
      release(&ts->spinlk);
    8000859c:	8552                	mv	a0,s4
    8000859e:	00001097          	auipc	ra,0x1
    800085a2:	39a080e7          	jalr	922(ra) # 80009938 <release>
      return -1;
    800085a6:	54fd                	li	s1,-1
    800085a8:	6942                	ld	s2,16(sp)
    800085aa:	69a2                	ld	s3,8(sp)
    800085ac:	6a02                	ld	s4,0(sp)
    800085ae:	a00d                	j	800085d0 <tcp_write+0x66>
  }

  int rc = tcp_send(ts, ubuf, len);
    800085b0:	864e                	mv	a2,s3
    800085b2:	85ca                	mv	a1,s2
    800085b4:	8526                	mv	a0,s1
    800085b6:	fffff097          	auipc	ra,0xfffff
    800085ba:	4b2080e7          	jalr	1202(ra) # 80007a68 <tcp_send>
    800085be:	84aa                	mv	s1,a0
  release(&ts->spinlk);
    800085c0:	8552                	mv	a0,s4
    800085c2:	00001097          	auipc	ra,0x1
    800085c6:	376080e7          	jalr	886(ra) # 80009938 <release>

  return rc;
    800085ca:	6942                	ld	s2,16(sp)
    800085cc:	69a2                	ld	s3,8(sp)
    800085ce:	6a02                	ld	s4,0(sp)
}
    800085d0:	8526                	mv	a0,s1
    800085d2:	70a2                	ld	ra,40(sp)
    800085d4:	7402                	ld	s0,32(sp)
    800085d6:	64e2                	ld	s1,24(sp)
    800085d8:	6145                	add	sp,sp,48
    800085da:	8082                	ret
  if (!ts) return -1;
    800085dc:	54fd                	li	s1,-1
    800085de:	bfcd                	j	800085d0 <tcp_write+0x66>

00000000800085e0 <tcp_close>:
  }
}

int
tcp_close(struct file *f)
{
    800085e0:	7179                	add	sp,sp,-48
    800085e2:	f406                	sd	ra,40(sp)
    800085e4:	f022                	sd	s0,32(sp)
    800085e6:	ec26                	sd	s1,24(sp)
    800085e8:	e84a                	sd	s2,16(sp)
    800085ea:	1800                	add	s0,sp,48
  struct tcp_sock *ts = f->tcpsock;
    800085ec:	7504                	ld	s1,40(a0)
  acquire(&ts->spinlk);
    800085ee:	0f048913          	add	s2,s1,240
    800085f2:	854a                	mv	a0,s2
    800085f4:	00001097          	auipc	ra,0x1
    800085f8:	27e080e7          	jalr	638(ra) # 80009872 <acquire>
  /* RFC 793 Page 37 */
  switch (ts->state) {
    800085fc:	09c4a703          	lw	a4,156(s1)
    80008600:	479d                	li	a5,7
    80008602:	06e7ee63          	bltu	a5,a4,8000867e <tcp_close+0x9e>
    80008606:	09c4e783          	lwu	a5,156(s1)
    8000860a:	078a                	sll	a5,a5,0x2
    8000860c:	00003717          	auipc	a4,0x3
    80008610:	4b070713          	add	a4,a4,1200 # 8000babc <digits+0x14>
    80008614:	97ba                	add	a5,a5,a4
    80008616:	439c                	lw	a5,0(a5)
    80008618:	97ba                	add	a5,a5,a4
    8000861a:	8782                	jr	a5
    8000861c:	e44e                	sd	s3,8(sp)
  while (!list_empty(&ts->listen_queue)) {
    8000861e:	02848993          	add	s3,s1,40
    80008622:	7888                	ld	a0,48(s1)
    80008624:	02a98163          	beq	s3,a0,80008646 <tcp_close+0x66>
	__list_del(list->prev, list->next);
    80008628:	6118                	ld	a4,0(a0)
    8000862a:	651c                	ld	a5,8(a0)
	prev->next = next;
    8000862c:	e71c                	sd	a5,8(a4)
	next->prev = prev;
    8000862e:	e398                	sd	a4,0(a5)
	list->prev = list;
    80008630:	e108                	sd	a0,0(a0)
	list->next = list;
    80008632:	e508                	sd	a0,8(a0)
    tcp_done(lts);
    80008634:	fb850513          	add	a0,a0,-72
    80008638:	fffff097          	auipc	ra,0xfffff
    8000863c:	eae080e7          	jalr	-338(ra) # 800074e6 <tcp_done>
  while (!list_empty(&ts->listen_queue)) {
    80008640:	7888                	ld	a0,48(s1)
    80008642:	ff3513e3          	bne	a0,s3,80008628 <tcp_close+0x48>
      return 0;
      break;
    case TCP_LISTEN:
      tcp_clear_listen_queue(ts);
      // clear 
      release(&ts->spinlk);
    80008646:	854a                	mv	a0,s2
    80008648:	00001097          	auipc	ra,0x1
    8000864c:	2f0080e7          	jalr	752(ra) # 80009938 <release>
      tcp_done(ts);
    80008650:	8526                	mv	a0,s1
    80008652:	fffff097          	auipc	ra,0xfffff
    80008656:	e94080e7          	jalr	-364(ra) # 800074e6 <tcp_done>
      return 0;
    8000865a:	69a2                	ld	s3,8(sp)
    8000865c:	a035                	j	80008688 <tcp_close+0xa8>
      release(&ts->spinlk);
    8000865e:	854a                	mv	a0,s2
    80008660:	00001097          	auipc	ra,0x1
    80008664:	2d8080e7          	jalr	728(ra) # 80009938 <release>
      tcp_done(ts);
    80008668:	8526                	mv	a0,s1
    8000866a:	fffff097          	auipc	ra,0xfffff
    8000866e:	e7c080e7          	jalr	-388(ra) # 800074e6 <tcp_done>
      return 0;
    80008672:	a819                	j	80008688 <tcp_close+0xa8>
    case TCP_SYN_RECEIVED:
    case TCP_SYN_SENT:
      tcp_done(ts);
    80008674:	8526                	mv	a0,s1
    80008676:	fffff097          	auipc	ra,0xfffff
    8000867a:	e70080e7          	jalr	-400(ra) # 800074e6 <tcp_done>
      ts->tcb.snd_nxt++;
      // tcpdbg("after send FIN, snd_nxt: %d\n", ts->tcb.snd_nxt);
      break;
  }

  release(&ts->spinlk);
    8000867e:	854a                	mv	a0,s2
    80008680:	00001097          	auipc	ra,0x1
    80008684:	2b8080e7          	jalr	696(ra) # 80009938 <release>

  return 0;
}
    80008688:	4501                	li	a0,0
    8000868a:	70a2                	ld	ra,40(sp)
    8000868c:	7402                	ld	s0,32(sp)
    8000868e:	64e2                	ld	s1,24(sp)
    80008690:	6942                	ld	s2,16(sp)
    80008692:	6145                	add	sp,sp,48
    80008694:	8082                	ret
      ts->state = TCP_FIN_WAIT_1;
    80008696:	4791                	li	a5,4
    80008698:	08f4ae23          	sw	a5,156(s1)
      tcp_send_fin(ts);
    8000869c:	8526                	mv	a0,s1
    8000869e:	fffff097          	auipc	ra,0xfffff
    800086a2:	36a080e7          	jalr	874(ra) # 80007a08 <tcp_send_fin>
      ts->tcb.snd_nxt++;
    800086a6:	58fc                	lw	a5,116(s1)
    800086a8:	2785                	addw	a5,a5,1
    800086aa:	d8fc                	sw	a5,116(s1)
      break;
    800086ac:	bfc9                	j	8000867e <tcp_close+0x9e>
      ts->state = TCP_LAST_ACK;
    800086ae:	47a5                	li	a5,9
    800086b0:	08f4ae23          	sw	a5,156(s1)
      tcp_send_fin(ts);
    800086b4:	8526                	mv	a0,s1
    800086b6:	fffff097          	auipc	ra,0xfffff
    800086ba:	352080e7          	jalr	850(ra) # 80007a08 <tcp_send_fin>
      ts->tcb.snd_nxt++;
    800086be:	58fc                	lw	a5,116(s1)
    800086c0:	2785                	addw	a5,a5,1
    800086c2:	d8fc                	sw	a5,116(s1)
      break;
    800086c4:	bf6d                	j	8000867e <tcp_close+0x9e>

00000000800086c6 <tcp_data_queue>:
tcp_data_queue(struct tcp_sock *ts, struct tcp_hdr *th, struct mbuf *m)
{
  tcpdbg("receive data: \n");
  // hexdump(m->head, m->len);

  if (!ts->tcb.rcv_wnd) {
    800086c6:	09052783          	lw	a5,144(a0)
    800086ca:	14078d63          	beqz	a5,80008824 <tcp_data_queue+0x15e>
{
    800086ce:	1101                	add	sp,sp,-32
    800086d0:	ec06                	sd	ra,24(sp)
    800086d2:	e822                	sd	s0,16(sp)
    800086d4:	e426                	sd	s1,8(sp)
    800086d6:	1000                	add	s0,sp,32
    800086d8:	84aa                	mv	s1,a0
    return -1;
  }

  if (m->seq == ts->tcb.rcv_nxt) {
    800086da:	6785                	lui	a5,0x1
    800086dc:	97b2                	add	a5,a5,a2
    800086de:	8187a783          	lw	a5,-2024(a5) # 818 <_entry-0x7ffff7e8>
    800086e2:	08c52703          	lw	a4,140(a0)
    800086e6:	04e78d63          	beq	a5,a4,80008740 <tcp_data_queue+0x7a>
  list_for_each_entry_safe(n, nn, &ts->ofo_queue.head, list) {
    800086ea:	7958                	ld	a4,176(a0)
    800086ec:	0a850693          	add	a3,a0,168
    800086f0:	10e68263          	beq	a3,a4,800087f4 <tcp_data_queue+0x12e>
    if (m->seq < n->seq) {
    800086f4:	ff872703          	lw	a4,-8(a4)
    800086f8:	0ee7f363          	bgeu	a5,a4,800087de <tcp_data_queue+0x118>
      if (m->end_seq > n->seq) {
    800086fc:	6785                	lui	a5,0x1
    800086fe:	97b2                	add	a5,a5,a2
    80008700:	81c7a583          	lw	a1,-2020(a5) # 81c <_entry-0x7ffff7e4>
    80008704:	00b77663          	bgeu	a4,a1,80008710 <tcp_data_queue+0x4a>
        m->len = m->len - (m->end_seq - n->seq);
    80008708:	4a1c                	lw	a5,16(a2)
    8000870a:	9f8d                	subw	a5,a5,a1
    8000870c:	9fb9                	addw	a5,a5,a4
    8000870e:	ca1c                	sw	a5,16(a2)
      m->refcnt++;
    80008710:	6705                	lui	a4,0x1
    80008712:	9732                	add	a4,a4,a2
    80008714:	81472783          	lw	a5,-2028(a4) # 814 <_entry-0x7ffff7ec>
    80008718:	2785                	addw	a5,a5,1
    8000871a:	80f72a23          	sw	a5,-2028(a4)
  list_add_tail(&new->list, &q->head);
    8000871e:	6785                	lui	a5,0x1
    80008720:	82078793          	add	a5,a5,-2016 # 820 <_entry-0x7ffff7e0>
    80008724:	97b2                	add	a5,a5,a2
	__list_add(list, head->prev, head);
    80008726:	74d0                	ld	a2,168(s1)
	list->prev = prev;
    80008728:	82c73023          	sd	a2,-2016(a4)
	list->next = next;
    8000872c:	82d73423          	sd	a3,-2008(a4)
	next->prev = list;
    80008730:	f4dc                	sd	a5,168(s1)
	prev->next = list;
    80008732:	e61c                	sd	a5,8(a2)
  q->len++;
    80008734:	0b84a783          	lw	a5,184(s1)
    80008738:	2785                	addw	a5,a5,1
    8000873a:	0af4ac23          	sw	a5,184(s1)
      return;
    8000873e:	a045                	j	800087de <tcp_data_queue+0x118>
    ts->tcb.rcv_nxt += m->len;
    80008740:	4a1c                	lw	a5,16(a2)
    80008742:	9fb9                	addw	a5,a5,a4
    80008744:	08f52623          	sw	a5,140(a0)
    m->refcnt++;
    80008748:	6705                	lui	a4,0x1
    8000874a:	9732                	add	a4,a4,a2
    8000874c:	81472783          	lw	a5,-2028(a4) # 814 <_entry-0x7ffff7ec>
    80008750:	2785                	addw	a5,a5,1
    80008752:	80f72a23          	sw	a5,-2028(a4)
  list_add_tail(&new->list, &q->head);
    80008756:	6785                	lui	a5,0x1
    80008758:	82078793          	add	a5,a5,-2016 # 820 <_entry-0x7ffff7e0>
    8000875c:	97b2                	add	a5,a5,a2
    8000875e:	0c050613          	add	a2,a0,192
	__list_add(list, head->prev, head);
    80008762:	6174                	ld	a3,192(a0)
	list->prev = prev;
    80008764:	82d73023          	sd	a3,-2016(a4)
	list->next = next;
    80008768:	82c73423          	sd	a2,-2008(a4)
	next->prev = list;
    8000876c:	e17c                	sd	a5,192(a0)
	prev->next = list;
    8000876e:	e69c                	sd	a5,8(a3)
  q->len++;
    80008770:	0d052783          	lw	a5,208(a0)
    80008774:	2785                	addw	a5,a5,1
    80008776:	0cf52823          	sw	a5,208(a0)
  if (mbuf_queue_empty(q))
    8000877a:	0b852783          	lw	a5,184(a0)
    8000877e:	cbb1                	beqz	a5,800087d2 <tcp_data_queue+0x10c>
      ts->tcb.rcv_nxt += m->len;
    80008780:	75fd                	lui	a1,0xfffff
  return list_first_entry(&q->head, struct mbuf, list);
    80008782:	78dc                	ld	a5,176(s1)
    && ts->tcb.rcv_nxt == m->seq) {
    80008784:	08c4a683          	lw	a3,140(s1)
    80008788:	ff87a703          	lw	a4,-8(a5)
    8000878c:	04d71363          	bne	a4,a3,800087d2 <tcp_data_queue+0x10c>
      ts->tcb.rcv_nxt += m->len;
    80008790:	00b78733          	add	a4,a5,a1
    80008794:	7f072703          	lw	a4,2032(a4)
    80008798:	9f35                	addw	a4,a4,a3
    8000879a:	08e4a623          	sw	a4,140(s1)
	__list_del(list->prev, list->next);
    8000879e:	6394                	ld	a3,0(a5)
    800087a0:	6798                	ld	a4,8(a5)
	prev->next = next;
    800087a2:	e698                	sd	a4,8(a3)
	next->prev = prev;
    800087a4:	e314                	sd	a3,0(a4)
	list->prev = NULL;
    800087a6:	0007b023          	sd	zero,0(a5)
	list->next = NULL;
    800087aa:	0007b423          	sd	zero,8(a5)
  q->len--;
    800087ae:	0b84a703          	lw	a4,184(s1)
    800087b2:	377d                	addw	a4,a4,-1
    800087b4:	0ae4ac23          	sw	a4,184(s1)
	__list_add(list, head->prev, head);
    800087b8:	60f8                	ld	a4,192(s1)
	list->prev = prev;
    800087ba:	e398                	sd	a4,0(a5)
	list->next = next;
    800087bc:	e790                	sd	a2,8(a5)
	next->prev = list;
    800087be:	e0fc                	sd	a5,192(s1)
	prev->next = list;
    800087c0:	e71c                	sd	a5,8(a4)
  q->len++;
    800087c2:	0d04a783          	lw	a5,208(s1)
    800087c6:	2785                	addw	a5,a5,1
    800087c8:	0cf4a823          	sw	a5,208(s1)
  if (mbuf_queue_empty(q))
    800087cc:	0b84a783          	lw	a5,184(s1)
    800087d0:	fbcd                	bnez	a5,80008782 <tcp_data_queue+0xbc>
    mbuf_enqueue(&ts->rcv_queue, m);

    tcp_consume_ofo_queue(ts);

    // wakeup  wait for recv
    wakeup(&ts->wait_rcv);
    800087d2:	06048513          	add	a0,s1,96
    800087d6:	ffff9097          	auipc	ra,0xffff9
    800087da:	108080e7          	jalr	264(ra) # 800018de <wakeup>
    /* RFC5581: A TCP receiver SHOULD send an immediate duplicate ACK when an out-
         * of-order segment arrives.  The purpose of this ACK is to inform the
         * sender that a segment was received out-of-order and which sequence
         * number is expected. */
  }
  tcp_send_ack(ts);
    800087de:	8526                	mv	a0,s1
    800087e0:	fffff097          	auipc	ra,0xfffff
    800087e4:	1cc080e7          	jalr	460(ra) # 800079ac <tcp_send_ack>

  return 0;
    800087e8:	4501                	li	a0,0
}
    800087ea:	60e2                	ld	ra,24(sp)
    800087ec:	6442                	ld	s0,16(sp)
    800087ee:	64a2                	ld	s1,8(sp)
    800087f0:	6105                	add	sp,sp,32
    800087f2:	8082                	ret
  m->refcnt++;
    800087f4:	6785                	lui	a5,0x1
    800087f6:	97b2                	add	a5,a5,a2
    800087f8:	8147a703          	lw	a4,-2028(a5) # 814 <_entry-0x7ffff7ec>
    800087fc:	2705                	addw	a4,a4,1
    800087fe:	80e7aa23          	sw	a4,-2028(a5)
  list_add_tail(&new->list, &q->head);
    80008802:	6705                	lui	a4,0x1
    80008804:	82070713          	add	a4,a4,-2016 # 820 <_entry-0x7ffff7e0>
    80008808:	963a                	add	a2,a2,a4
	__list_add(list, head->prev, head);
    8000880a:	7558                	ld	a4,168(a0)
	list->prev = prev;
    8000880c:	82e7b023          	sd	a4,-2016(a5)
	list->next = next;
    80008810:	82d7b423          	sd	a3,-2008(a5)
	next->prev = list;
    80008814:	f550                	sd	a2,168(a0)
	prev->next = list;
    80008816:	e710                	sd	a2,8(a4)
  q->len++;
    80008818:	0b852783          	lw	a5,184(a0)
    8000881c:	2785                	addw	a5,a5,1
    8000881e:	0af52c23          	sw	a5,184(a0)
}
    80008822:	bf75                	j	800087de <tcp_data_queue+0x118>
    return -1;
    80008824:	557d                	li	a0,-1
}
    80008826:	8082                	ret

0000000080008828 <tcp_data_dequeue>:

int
tcp_data_dequeue(struct tcp_sock *ts, uint64 ubuf, int len)
{
    80008828:	7119                	add	sp,sp,-128
    8000882a:	fc86                	sd	ra,120(sp)
    8000882c:	f8a2                	sd	s0,112(sp)
    8000882e:	e8d2                	sd	s4,80(sp)
    80008830:	0100                	add	s0,sp,128
  struct tcp_hdr *th;
  int rlen = 0;

  while (!mbuf_queue_empty(&ts->rcv_queue) && rlen < len) {
    80008832:	0d052783          	lw	a5,208(a0)
    80008836:	cff5                	beqz	a5,80008932 <tcp_data_dequeue+0x10a>
    80008838:	ecce                	sd	s3,88(sp)
    8000883a:	e4d6                	sd	s5,72(sp)
    8000883c:	fc5e                	sd	s7,56(sp)
    8000883e:	89aa                	mv	s3,a0
    80008840:	8aae                	mv	s5,a1
    80008842:	8bb2                	mv	s7,a2
    80008844:	0ec05963          	blez	a2,80008936 <tcp_data_dequeue+0x10e>
    80008848:	f4a6                	sd	s1,104(sp)
    8000884a:	f0ca                	sd	s2,96(sp)
    8000884c:	e0da                	sd	s6,64(sp)
    8000884e:	f862                	sd	s8,48(sp)
    80008850:	f466                	sd	s9,40(sp)
    80008852:	f06a                	sd	s10,32(sp)
    80008854:	ec6e                	sd	s11,24(sp)
  int rlen = 0;
    80008856:	4a01                	li	s4,0
    struct mbuf *m = mbuf_queue_peek(&ts->rcv_queue);
    if (m == NULL) break;
    
    th = (struct tcp_hdr *)(m->head - sizeof(*th));
    80008858:	7c7d                	lui	s8,0xfffff

    /* Guard datalen to not overflow userbuf */
    int dlen = (rlen + m->len) > len ? (len - rlen) : m->len;
    8000885a:	0006079b          	sext.w	a5,a2
    8000885e:	f8f43423          	sd	a5,-120(s0)
    rlen += dlen;
    ubuf += dlen;

    /* mbuf is fully eaten, process flags and drop it */
    if (m->len == 0) {
      if (th->psh) ts->flags |= TCP_PSH;
    80008862:	6d85                	lui	s11,0x1
    80008864:	800d8d93          	add	s11,s11,-2048 # 800 <_entry-0x7ffff800>
  return list_first_entry(&q->head, struct mbuf, list);
    80008868:	7d7d                	lui	s10,0xfffff
    8000886a:	7e0d0d13          	add	s10,s10,2016 # fffffffffffff7e0 <end+0xffffffff7ffb8210>
    8000886e:	a81d                	j	800088a4 <tcp_data_dequeue+0x7c>
  struct mbuf *m = list_first_entry(&q->head, struct mbuf, list);
    80008870:	0c89b783          	ld	a5,200(s3)
	__list_del(list->prev, list->next);
    80008874:	6394                	ld	a3,0(a5)
    80008876:	6798                	ld	a4,8(a5)
	prev->next = next;
    80008878:	e698                	sd	a4,8(a3)
	next->prev = prev;
    8000887a:	e314                	sd	a3,0(a4)
	list->prev = NULL;
    8000887c:	0007b023          	sd	zero,0(a5)
	list->next = NULL;
    80008880:	0007b423          	sd	zero,8(a5)
  q->len--;
    80008884:	0d09a783          	lw	a5,208(s3)
    80008888:	37fd                	addw	a5,a5,-1
    8000888a:	0cf9a823          	sw	a5,208(s3)
      mbuf_dequeue(&ts->rcv_queue);
      mbuffree(m);
    8000888e:	01ab0533          	add	a0,s6,s10
    80008892:	fffff097          	auipc	ra,0xfffff
    80008896:	89a080e7          	jalr	-1894(ra) # 8000712c <mbuffree>
  while (!mbuf_queue_empty(&ts->rcv_queue) && rlen < len) {
    8000889a:	0d09a783          	lw	a5,208(s3)
    8000889e:	c3cd                	beqz	a5,80008940 <tcp_data_dequeue+0x118>
    800088a0:	077a5e63          	bge	s4,s7,8000891c <tcp_data_dequeue+0xf4>
  return list_first_entry(&q->head, struct mbuf, list);
    800088a4:	0c89bb03          	ld	s6,200(s3)
    th = (struct tcp_hdr *)(m->head - sizeof(*th));
    800088a8:	018b07b3          	add	a5,s6,s8
    800088ac:	7e87bc83          	ld	s9,2024(a5)
    int dlen = (rlen + m->len) > len ? (len - rlen) : m->len;
    800088b0:	7f07a483          	lw	s1,2032(a5)
    800088b4:	009a07bb          	addw	a5,s4,s1
    800088b8:	2481                	sext.w	s1,s1
    800088ba:	f8843703          	ld	a4,-120(s0)
    800088be:	00f77463          	bgeu	a4,a5,800088c6 <tcp_data_dequeue+0x9e>
    800088c2:	414b84bb          	subw	s1,s7,s4
    copyout(myproc()->pagetable, ubuf, m->head, dlen);
    800088c6:	ffff8097          	auipc	ra,0xffff8
    800088ca:	680080e7          	jalr	1664(ra) # 80000f46 <myproc>
    800088ce:	018b0933          	add	s2,s6,s8
    800088d2:	86a6                	mv	a3,s1
    800088d4:	7e893603          	ld	a2,2024(s2)
    800088d8:	85d6                	mv	a1,s5
    800088da:	6928                	ld	a0,80(a0)
    800088dc:	ffff8097          	auipc	ra,0xffff8
    800088e0:	2e6080e7          	jalr	742(ra) # 80000bc2 <copyout>
    m->len -= dlen;
    800088e4:	7f092783          	lw	a5,2032(s2)
    800088e8:	9f85                	subw	a5,a5,s1
    800088ea:	0007871b          	sext.w	a4,a5
    800088ee:	7ef92823          	sw	a5,2032(s2)
    m->head += dlen;
    800088f2:	7e893783          	ld	a5,2024(s2)
    800088f6:	97a6                	add	a5,a5,s1
    800088f8:	7ef93423          	sd	a5,2024(s2)
    rlen += dlen;
    800088fc:	01448a3b          	addw	s4,s1,s4
    ubuf += dlen;
    80008900:	9aa6                	add	s5,s5,s1
    if (m->len == 0) {
    80008902:	ff41                	bnez	a4,8000889a <tcp_data_dequeue+0x72>
      if (th->psh) ts->flags |= TCP_PSH;
    80008904:	ff8cd783          	lhu	a5,-8(s9)
    80008908:	01b7f7b3          	and	a5,a5,s11
    8000890c:	d3b5                	beqz	a5,80008870 <tcp_data_dequeue+0x48>
    8000890e:	0a09a783          	lw	a5,160(s3)
    80008912:	0087e793          	or	a5,a5,8
    80008916:	0af9a023          	sw	a5,160(s3)
    8000891a:	bf99                	j	80008870 <tcp_data_dequeue+0x48>
    8000891c:	74a6                	ld	s1,104(sp)
    8000891e:	7906                	ld	s2,96(sp)
    80008920:	69e6                	ld	s3,88(sp)
    80008922:	6aa6                	ld	s5,72(sp)
    80008924:	6b06                	ld	s6,64(sp)
    80008926:	7be2                	ld	s7,56(sp)
    80008928:	7c42                	ld	s8,48(sp)
    8000892a:	7ca2                	ld	s9,40(sp)
    8000892c:	7d02                	ld	s10,32(sp)
    8000892e:	6de2                	ld	s11,24(sp)
    80008930:	a015                	j	80008954 <tcp_data_dequeue+0x12c>
  int rlen = 0;
    80008932:	4a01                	li	s4,0
    80008934:	a005                	j	80008954 <tcp_data_dequeue+0x12c>
    80008936:	4a01                	li	s4,0
    80008938:	69e6                	ld	s3,88(sp)
    8000893a:	6aa6                	ld	s5,72(sp)
    8000893c:	7be2                	ld	s7,56(sp)
    8000893e:	a819                	j	80008954 <tcp_data_dequeue+0x12c>
    80008940:	74a6                	ld	s1,104(sp)
    80008942:	7906                	ld	s2,96(sp)
    80008944:	69e6                	ld	s3,88(sp)
    80008946:	6aa6                	ld	s5,72(sp)
    80008948:	6b06                	ld	s6,64(sp)
    8000894a:	7be2                	ld	s7,56(sp)
    8000894c:	7c42                	ld	s8,48(sp)
    8000894e:	7ca2                	ld	s9,40(sp)
    80008950:	7d02                	ld	s10,32(sp)
    80008952:	6de2                	ld	s11,24(sp)
    }
  }

  return rlen;
    80008954:	8552                	mv	a0,s4
    80008956:	70e6                	ld	ra,120(sp)
    80008958:	7446                	ld	s0,112(sp)
    8000895a:	6a46                	ld	s4,80(sp)
    8000895c:	6109                	add	sp,sp,128
    8000895e:	8082                	ret

0000000080008960 <alloc_port>:


int
alloc_port(struct file *f, uint16 p)
{
  if (p < MIN_PORT || p >= MAX_PORT_N)
    80008960:	ff65871b          	addw	a4,a1,-10 # ffffffffffffeff6 <end+0xffffffff7ffb7a26>
    80008964:	1742                	sll	a4,a4,0x30
    80008966:	9341                	srl	a4,a4,0x30
    80008968:	6785                	lui	a5,0x1
    8000896a:	37d78793          	add	a5,a5,893 # 137d <_entry-0x7fffec83>
    8000896e:	00e7f463          	bgeu	a5,a4,80008976 <alloc_port+0x16>
    return 0;
    80008972:	4501                	li	a0,0
  }
  release(&udp_lock);
  release(&tcpsocks_list_lk);

  return !dup;
}
    80008974:	8082                	ret
{
    80008976:	7179                	add	sp,sp,-48
    80008978:	f406                	sd	ra,40(sp)
    8000897a:	f022                	sd	s0,32(sp)
    8000897c:	ec26                	sd	s1,24(sp)
    8000897e:	e84a                	sd	s2,16(sp)
    80008980:	e44e                	sd	s3,8(sp)
    80008982:	1800                	add	s0,sp,48
    80008984:	892a                	mv	s2,a0
    80008986:	84ae                	mv	s1,a1
  acquire(&tcpsocks_list_lk);
    80008988:	00037517          	auipc	a0,0x37
    8000898c:	9c050513          	add	a0,a0,-1600 # 8003f348 <tcpsocks_list_lk>
    80008990:	00001097          	auipc	ra,0x1
    80008994:	ee2080e7          	jalr	-286(ra) # 80009872 <acquire>
  acquire(&udp_lock);
    80008998:	00037517          	auipc	a0,0x37
    8000899c:	99850513          	add	a0,a0,-1640 # 8003f330 <udp_lock>
    800089a0:	00001097          	auipc	ra,0x1
    800089a4:	ed2080e7          	jalr	-302(ra) # 80009872 <acquire>
  list_for_each_entry(ts, &tcpsocks_list_head, tcpsock_list) {
    800089a8:	00037717          	auipc	a4,0x37
    800089ac:	9b870713          	add	a4,a4,-1608 # 8003f360 <tcpsocks_list_head>
    800089b0:	671c                	ld	a5,8(a4)
    800089b2:	04e78d63          	beq	a5,a4,80008a0c <alloc_port+0xac>
    if (ts->sport == p) {
    800089b6:	0004869b          	sext.w	a3,s1
  list_for_each_entry(ts, &tcpsocks_list_head, tcpsock_list) {
    800089ba:	863a                	mv	a2,a4
    if (ts->sport == p) {
    800089bc:	0187d703          	lhu	a4,24(a5)
    800089c0:	04d70d63          	beq	a4,a3,80008a1a <alloc_port+0xba>
  list_for_each_entry(ts, &tcpsocks_list_head, tcpsock_list) {
    800089c4:	679c                	ld	a5,8(a5)
    800089c6:	fec79be3          	bne	a5,a2,800089bc <alloc_port+0x5c>
  struct sock *pos = udp_sockets;
    800089ca:	00003797          	auipc	a5,0x3
    800089ce:	65e7b783          	ld	a5,1630(a5) # 8000c028 <udp_sockets>
  int dup = 0;
    800089d2:	4981                	li	s3,0
  while (pos) {
    800089d4:	eba9                	bnez	a5,80008a26 <alloc_port+0xc6>
    800089d6:	a095                	j	80008a3a <alloc_port+0xda>
    800089d8:	4985                	li	s3,1
  release(&udp_lock);
    800089da:	00037517          	auipc	a0,0x37
    800089de:	95650513          	add	a0,a0,-1706 # 8003f330 <udp_lock>
    800089e2:	00001097          	auipc	ra,0x1
    800089e6:	f56080e7          	jalr	-170(ra) # 80009938 <release>
  release(&tcpsocks_list_lk);
    800089ea:	00037517          	auipc	a0,0x37
    800089ee:	95e50513          	add	a0,a0,-1698 # 8003f348 <tcpsocks_list_lk>
    800089f2:	00001097          	auipc	ra,0x1
    800089f6:	f46080e7          	jalr	-186(ra) # 80009938 <release>
  return !dup;
    800089fa:	0019c513          	xor	a0,s3,1
}
    800089fe:	70a2                	ld	ra,40(sp)
    80008a00:	7402                	ld	s0,32(sp)
    80008a02:	64e2                	ld	s1,24(sp)
    80008a04:	6942                	ld	s2,16(sp)
    80008a06:	69a2                	ld	s3,8(sp)
    80008a08:	6145                	add	sp,sp,48
    80008a0a:	8082                	ret
  struct sock *pos = udp_sockets;
    80008a0c:	00003797          	auipc	a5,0x3
    80008a10:	61c7b783          	ld	a5,1564(a5) # 8000c028 <udp_sockets>
  int dup = 0;
    80008a14:	4981                	li	s3,0
  while (pos) {
    80008a16:	eb81                	bnez	a5,80008a26 <alloc_port+0xc6>
    80008a18:	a00d                	j	80008a3a <alloc_port+0xda>
  struct sock *pos = udp_sockets;
    80008a1a:	00003797          	auipc	a5,0x3
    80008a1e:	60e7b783          	ld	a5,1550(a5) # 8000c028 <udp_sockets>
      dup = 1;
    80008a22:	4985                	li	s3,1
  while (pos) {
    80008a24:	dbdd                	beqz	a5,800089da <alloc_port+0x7a>
    if (pos->lport == p) {
    80008a26:	0004869b          	sext.w	a3,s1
    80008a2a:	00c7d703          	lhu	a4,12(a5)
    80008a2e:	fad705e3          	beq	a4,a3,800089d8 <alloc_port+0x78>
    pos = pos->next;
    80008a32:	639c                	ld	a5,0(a5)
  while (pos) {
    80008a34:	fbfd                	bnez	a5,80008a2a <alloc_port+0xca>
  if (!dup) {
    80008a36:	fa0992e3          	bnez	s3,800089da <alloc_port+0x7a>
    if (f->type == FD_SOCK_TCP) {
    80008a3a:	00092703          	lw	a4,0(s2)
    80008a3e:	4795                	li	a5,5
    80008a40:	4981                	li	s3,0
    80008a42:	f8f71ce3          	bne	a4,a5,800089da <alloc_port+0x7a>
      f->tcpsock->sport = p;
    80008a46:	02893783          	ld	a5,40(s2)
    80008a4a:	00979c23          	sh	s1,24(a5)
    80008a4e:	b771                	j	800089da <alloc_port+0x7a>

0000000080008a50 <auto_alloc_port>:

int
auto_alloc_port(struct file *f)
{
    80008a50:	7139                	add	sp,sp,-64
    80008a52:	fc06                	sd	ra,56(sp)
    80008a54:	f822                	sd	s0,48(sp)
    80008a56:	f426                	sd	s1,40(sp)
    80008a58:	f04a                	sd	s2,32(sp)
    80008a5a:	ec4e                	sd	s3,24(sp)
    80008a5c:	e852                	sd	s4,16(sp)
    80008a5e:	e456                	sd	s5,8(sp)
    80008a60:	e05a                	sd	s6,0(sp)
    80008a62:	0080                	add	s0,sp,64
    80008a64:	89aa                	mv	s3,a0

  uint p = ticks % MAX_PORT_N;
    80008a66:	00003797          	auipc	a5,0x3
    80008a6a:	5b27a783          	lw	a5,1458(a5) # 8000c018 <ticks>
    80008a6e:	6705                	lui	a4,0x1
    80008a70:	3887071b          	addw	a4,a4,904 # 1388 <_entry-0x7fffec78>
    80008a74:	02e7f7bb          	remuw	a5,a5,a4
  if (p < MIN_PORT) p = MIN_PORT;
    80008a78:	0007869b          	sext.w	a3,a5
    80008a7c:	4729                	li	a4,10
    80008a7e:	00e6f363          	bgeu	a3,a4,80008a84 <auto_alloc_port+0x34>
    80008a82:	47a9                	li	a5,10
    80008a84:	0007849b          	sext.w	s1,a5
    80008a88:	6905                	lui	s2,0x1
    80008a8a:	38890913          	add	s2,s2,904 # 1388 <_entry-0x7fffec78>
  int cnt = 1;
  while (!alloc_port(f, p)) {
    p = (p + 1) % MAX_PORT_N;
    80008a8e:	6a05                	lui	s4,0x1
    80008a90:	388a0a1b          	addw	s4,s4,904 # 1388 <_entry-0x7fffec78>
    if (p < MIN_PORT)
    80008a94:	4aa9                	li	s5,10
    80008a96:	4b29                	li	s6,10
    80008a98:	a031                	j	80008aa4 <auto_alloc_port+0x54>
    80008a9a:	0007849b          	sext.w	s1,a5
      p = MIN_PORT;
    cnt++;
    if (cnt > MAX_PORT_N) {
    80008a9e:	397d                	addw	s2,s2,-1
    80008aa0:	04090163          	beqz	s2,80008ae2 <auto_alloc_port+0x92>
  while (!alloc_port(f, p)) {
    80008aa4:	03049593          	sll	a1,s1,0x30
    80008aa8:	91c1                	srl	a1,a1,0x30
    80008aaa:	854e                	mv	a0,s3
    80008aac:	00000097          	auipc	ra,0x0
    80008ab0:	eb4080e7          	jalr	-332(ra) # 80008960 <alloc_port>
    80008ab4:	e919                	bnez	a0,80008aca <auto_alloc_port+0x7a>
    p = (p + 1) % MAX_PORT_N;
    80008ab6:	0014879b          	addw	a5,s1,1
    80008aba:	0347f7bb          	remuw	a5,a5,s4
    if (p < MIN_PORT)
    80008abe:	0007871b          	sext.w	a4,a5
    80008ac2:	fd577ce3          	bgeu	a4,s5,80008a9a <auto_alloc_port+0x4a>
    80008ac6:	87da                	mv	a5,s6
    80008ac8:	bfc9                	j	80008a9a <auto_alloc_port+0x4a>
      return -1;
    }
  }

  return p;
    80008aca:	0004851b          	sext.w	a0,s1
}
    80008ace:	70e2                	ld	ra,56(sp)
    80008ad0:	7442                	ld	s0,48(sp)
    80008ad2:	74a2                	ld	s1,40(sp)
    80008ad4:	7902                	ld	s2,32(sp)
    80008ad6:	69e2                	ld	s3,24(sp)
    80008ad8:	6a42                	ld	s4,16(sp)
    80008ada:	6aa2                	ld	s5,8(sp)
    80008adc:	6b02                	ld	s6,0(sp)
    80008ade:	6121                	add	sp,sp,64
    80008ae0:	8082                	ret
      return -1;
    80008ae2:	557d                	li	a0,-1
    80008ae4:	b7ed                	j	80008ace <auto_alloc_port+0x7e>

0000000080008ae6 <socket>:

int 
socket(struct file **f, int domain, int type, int protocol)
{

  if (domain != AF_INET || (type != SOCK_STREAM && type != SOCK_DGRAM))
    80008ae6:	eda5                	bnez	a1,80008b5e <socket+0x78>
{
    80008ae8:	1101                	add	sp,sp,-32
    80008aea:	ec06                	sd	ra,24(sp)
    80008aec:	e822                	sd	s0,16(sp)
    80008aee:	e426                	sd	s1,8(sp)
    80008af0:	e04a                	sd	s2,0(sp)
    80008af2:	1000                	add	s0,sp,32
    80008af4:	892a                	mv	s2,a0
    80008af6:	84ae                	mv	s1,a1
  if (domain != AF_INET || (type != SOCK_STREAM && type != SOCK_DGRAM))
    80008af8:	fff6079b          	addw	a5,a2,-1
    80008afc:	4705                	li	a4,1
    80008afe:	06f76263          	bltu	a4,a5,80008b62 <socket+0x7c>
    return -1;
  
  if (type == SOCK_DGRAM) {
    80008b02:	4789                	li	a5,2
    80008b04:	02f60963          	beq	a2,a5,80008b36 <socket+0x50>
    (*f)->type = FD_SOCK_UDP;
    (*f)->readable = 1;
    (*f)->writable = 1;
    (*f)->sock = 0;
  } else if (type == SOCK_STREAM) {
    struct tcp_sock *ts = tcp_sock_alloc();
    80008b08:	fffff097          	auipc	ra,0xfffff
    80008b0c:	736080e7          	jalr	1846(ra) # 8000823e <tcp_sock_alloc>
    if (!ts) return -1;
    80008b10:	c939                	beqz	a0,80008b66 <socket+0x80>
    (*f)->type = FD_SOCK_TCP;
    80008b12:	00093783          	ld	a5,0(s2)
    80008b16:	4715                	li	a4,5
    80008b18:	c398                	sw	a4,0(a5)
    (*f)->readable = 1;
    80008b1a:	00093703          	ld	a4,0(s2)
    80008b1e:	4785                	li	a5,1
    80008b20:	00f70423          	sb	a5,8(a4)
    (*f)->writable = 1;
    80008b24:	00093703          	ld	a4,0(s2)
    80008b28:	00f704a3          	sb	a5,9(a4)
    (*f)->tcpsock = ts;
    80008b2c:	00093783          	ld	a5,0(s2)
    80008b30:	f788                	sd	a0,40(a5)

  }

  return 0;
    80008b32:	8526                	mv	a0,s1
    80008b34:	a839                	j	80008b52 <socket+0x6c>
    (*f)->type = FD_SOCK_UDP;
    80008b36:	611c                	ld	a5,0(a0)
    80008b38:	4711                	li	a4,4
    80008b3a:	c398                	sw	a4,0(a5)
    (*f)->readable = 1;
    80008b3c:	6118                	ld	a4,0(a0)
    80008b3e:	4785                	li	a5,1
    80008b40:	00f70423          	sb	a5,8(a4)
    (*f)->writable = 1;
    80008b44:	6118                	ld	a4,0(a0)
    80008b46:	00f704a3          	sb	a5,9(a4)
    (*f)->sock = 0;
    80008b4a:	611c                	ld	a5,0(a0)
    80008b4c:	0207b023          	sd	zero,32(a5)
  return 0;
    80008b50:	852e                	mv	a0,a1
}
    80008b52:	60e2                	ld	ra,24(sp)
    80008b54:	6442                	ld	s0,16(sp)
    80008b56:	64a2                	ld	s1,8(sp)
    80008b58:	6902                	ld	s2,0(sp)
    80008b5a:	6105                	add	sp,sp,32
    80008b5c:	8082                	ret
    return -1;
    80008b5e:	557d                	li	a0,-1
}
    80008b60:	8082                	ret
    return -1;
    80008b62:	557d                	li	a0,-1
    80008b64:	b7fd                	j	80008b52 <socket+0x6c>
    if (!ts) return -1;
    80008b66:	557d                	li	a0,-1
    80008b68:	b7ed                	j	80008b52 <socket+0x6c>

0000000080008b6a <timer_init>:
LIST_HEAD(timers);
LIST_HEAD(waitadds);
struct spinlock timerslk;

void timer_init()
{
    80008b6a:	1101                	add	sp,sp,-32
    80008b6c:	ec06                	sd	ra,24(sp)
    80008b6e:	e822                	sd	s0,16(sp)
    80008b70:	e426                	sd	s1,8(sp)
    80008b72:	1000                	add	s0,sp,32
	head->prev = head->next = head;
    80008b74:	00003497          	auipc	s1,0x3
    80008b78:	08c48493          	add	s1,s1,140 # 8000bc00 <timers>
    80008b7c:	e484                	sd	s1,8(s1)
    80008b7e:	e084                	sd	s1,0(s1)
  list_init(&timers);
  initlock(&timerslk, "timerslk");
    80008b80:	00003597          	auipc	a1,0x3
    80008b84:	d1058593          	add	a1,a1,-752 # 8000b890 <etext+0x890>
    80008b88:	00036517          	auipc	a0,0x36
    80008b8c:	7e850513          	add	a0,a0,2024 # 8003f370 <timerslk>
    80008b90:	00001097          	auipc	ra,0x1
    80008b94:	c52080e7          	jalr	-942(ra) # 800097e2 <initlock>
    80008b98:	00003797          	auipc	a5,0x3
    80008b9c:	07878793          	add	a5,a5,120 # 8000bc10 <waitadds>
    80008ba0:	ec9c                	sd	a5,24(s1)
    80008ba2:	e89c                	sd	a5,16(s1)

  list_init(&waitadds);
}
    80008ba4:	60e2                	ld	ra,24(sp)
    80008ba6:	6442                	ld	s0,16(sp)
    80008ba8:	64a2                	ld	s1,8(sp)
    80008baa:	6105                	add	sp,sp,32
    80008bac:	8082                	ret

0000000080008bae <timer_add>:

struct timer *
timer_add(uint32 expire, void *(*handler)(void *), void *arg)
{
    80008bae:	7179                	add	sp,sp,-48
    80008bb0:	f406                	sd	ra,40(sp)
    80008bb2:	f022                	sd	s0,32(sp)
    80008bb4:	ec26                	sd	s1,24(sp)
    80008bb6:	e84a                	sd	s2,16(sp)
    80008bb8:	e44e                	sd	s3,8(sp)
    80008bba:	e052                	sd	s4,0(sp)
    80008bbc:	1800                	add	s0,sp,48
    80008bbe:	892a                	mv	s2,a0
    80008bc0:	8a2e                	mv	s4,a1
    80008bc2:	89b2                	mv	s3,a2
#ifdef TIMER_DEBUG
  printf("timer add...\n");
#endif
  struct timer *t = (struct timer *)kalloc();
    80008bc4:	ffff7097          	auipc	ra,0xffff7
    80008bc8:	556080e7          	jalr	1366(ra) # 8000011a <kalloc>
    80008bcc:	84aa                	mv	s1,a0
  t->expires = ticks + expire;
    80008bce:	00003797          	auipc	a5,0x3
    80008bd2:	44a7a783          	lw	a5,1098(a5) # 8000c018 <ticks>
    80008bd6:	0127853b          	addw	a0,a5,s2
    80008bda:	0005071b          	sext.w	a4,a0
    80008bde:	d088                	sw	a0,32(s1)

  if (t->expires < ticks)
    80008be0:	04f76863          	bltu	a4,a5,80008c30 <timer_add+0x82>
  {
    kfree(t);
    return NULL;
  }

  t->handler = handler;
    80008be4:	0344b423          	sd	s4,40(s1)
  t->arg = arg;
    80008be8:	0334b823          	sd	s3,48(s1)
  t->cancelled = 0;
    80008bec:	0204a223          	sw	zero,36(s1)

  acquire(&timerslk);
    80008bf0:	00036917          	auipc	s2,0x36
    80008bf4:	78090913          	add	s2,s2,1920 # 8003f370 <timerslk>
    80008bf8:	854a                	mv	a0,s2
    80008bfa:	00001097          	auipc	ra,0x1
    80008bfe:	c78080e7          	jalr	-904(ra) # 80009872 <acquire>
	__list_add(list, head->prev, head);
    80008c02:	00003797          	auipc	a5,0x3
    80008c06:	ffe78793          	add	a5,a5,-2 # 8000bc00 <timers>
    80008c0a:	6398                	ld	a4,0(a5)
	list->prev = prev;
    80008c0c:	e098                	sd	a4,0(s1)
	list->next = next;
    80008c0e:	e49c                	sd	a5,8(s1)
	next->prev = list;
    80008c10:	e384                	sd	s1,0(a5)
	prev->next = list;
    80008c12:	e704                	sd	s1,8(a4)
  list_add_tail(&t->list, &timers);
  release(&timerslk);
    80008c14:	854a                	mv	a0,s2
    80008c16:	00001097          	auipc	ra,0x1
    80008c1a:	d22080e7          	jalr	-734(ra) # 80009938 <release>

  return t;
}
    80008c1e:	8526                	mv	a0,s1
    80008c20:	70a2                	ld	ra,40(sp)
    80008c22:	7402                	ld	s0,32(sp)
    80008c24:	64e2                	ld	s1,24(sp)
    80008c26:	6942                	ld	s2,16(sp)
    80008c28:	69a2                	ld	s3,8(sp)
    80008c2a:	6a02                	ld	s4,0(sp)
    80008c2c:	6145                	add	sp,sp,48
    80008c2e:	8082                	ret
    kfree(t);
    80008c30:	8526                	mv	a0,s1
    80008c32:	ffff7097          	auipc	ra,0xffff7
    80008c36:	3ea080e7          	jalr	1002(ra) # 8000001c <kfree>
    return NULL;
    80008c3a:	4481                	li	s1,0
    80008c3c:	b7cd                	j	80008c1e <timer_add+0x70>

0000000080008c3e <timer_add_in_handler>:

void
timer_add_in_handler(uint32 expire, void *(*handler)(void *), void *arg)
{
    80008c3e:	7179                	add	sp,sp,-48
    80008c40:	f406                	sd	ra,40(sp)
    80008c42:	f022                	sd	s0,32(sp)
    80008c44:	ec26                	sd	s1,24(sp)
    80008c46:	e84a                	sd	s2,16(sp)
    80008c48:	e44e                	sd	s3,8(sp)
    80008c4a:	1800                	add	s0,sp,48
    80008c4c:	84aa                	mv	s1,a0
    80008c4e:	89ae                	mv	s3,a1
    80008c50:	8932                	mv	s2,a2
  struct timer *t = (struct timer *)kalloc();
    80008c52:	ffff7097          	auipc	ra,0xffff7
    80008c56:	4c8080e7          	jalr	1224(ra) # 8000011a <kalloc>
  t->expires = ticks + expire;
    80008c5a:	00003717          	auipc	a4,0x3
    80008c5e:	3be72703          	lw	a4,958(a4) # 8000c018 <ticks>
    80008c62:	009707bb          	addw	a5,a4,s1
    80008c66:	0007869b          	sext.w	a3,a5
    80008c6a:	d11c                	sw	a5,32(a0)

  if (t->expires < ticks)
    80008c6c:	02e6ee63          	bltu	a3,a4,80008ca8 <timer_add_in_handler+0x6a>
  {
    kfree(t);
    return;
  }

  t->handler = handler;
    80008c70:	03353423          	sd	s3,40(a0)
  t->arg = arg;
    80008c74:	03253823          	sd	s2,48(a0)
  t->cancelled = 0;
    80008c78:	02052223          	sw	zero,36(a0)

  list_add_tail(&t->waitadd, &waitadds);
    80008c7c:	01050713          	add	a4,a0,16
	__list_add(list, head->prev, head);
    80008c80:	00003697          	auipc	a3,0x3
    80008c84:	f8068693          	add	a3,a3,-128 # 8000bc00 <timers>
    80008c88:	6a9c                	ld	a5,16(a3)
	list->prev = prev;
    80008c8a:	e91c                	sd	a5,16(a0)
	list->next = next;
    80008c8c:	00003617          	auipc	a2,0x3
    80008c90:	f8460613          	add	a2,a2,-124 # 8000bc10 <waitadds>
    80008c94:	ed10                	sd	a2,24(a0)
	next->prev = list;
    80008c96:	ea98                	sd	a4,16(a3)
	prev->next = list;
    80008c98:	e798                	sd	a4,8(a5)
}
    80008c9a:	70a2                	ld	ra,40(sp)
    80008c9c:	7402                	ld	s0,32(sp)
    80008c9e:	64e2                	ld	s1,24(sp)
    80008ca0:	6942                	ld	s2,16(sp)
    80008ca2:	69a2                	ld	s3,8(sp)
    80008ca4:	6145                	add	sp,sp,48
    80008ca6:	8082                	ret
    kfree(t);
    80008ca8:	ffff7097          	auipc	ra,0xffff7
    80008cac:	374080e7          	jalr	884(ra) # 8000001c <kfree>
    return;
    80008cb0:	b7ed                	j	80008c9a <timer_add_in_handler+0x5c>

0000000080008cb2 <timer_cancel>:

void timer_cancel(struct timer *t)
{
    80008cb2:	1141                	add	sp,sp,-16
    80008cb4:	e422                	sd	s0,8(sp)
    80008cb6:	0800                	add	s0,sp,16
  t->cancelled = 1;
    80008cb8:	4785                	li	a5,1
    80008cba:	d15c                	sw	a5,36(a0)
}
    80008cbc:	6422                	ld	s0,8(sp)
    80008cbe:	0141                	add	sp,sp,16
    80008cc0:	8082                	ret

0000000080008cc2 <timers_exe_all>:

void timers_exe_all()
{
    80008cc2:	7179                	add	sp,sp,-48
    80008cc4:	f406                	sd	ra,40(sp)
    80008cc6:	f022                	sd	s0,32(sp)
    80008cc8:	ec26                	sd	s1,24(sp)
    80008cca:	e84a                	sd	s2,16(sp)
    80008ccc:	1800                	add	s0,sp,48
  acquire(&timerslk);
    80008cce:	00036517          	auipc	a0,0x36
    80008cd2:	6a250513          	add	a0,a0,1698 # 8003f370 <timerslk>
    80008cd6:	00001097          	auipc	ra,0x1
    80008cda:	b9c080e7          	jalr	-1124(ra) # 80009872 <acquire>
  struct timer *t, *nt;
  list_for_each_entry_safe(t, nt, &timers, list)
    80008cde:	00003797          	auipc	a5,0x3
    80008ce2:	f2278793          	add	a5,a5,-222 # 8000bc00 <timers>
    80008ce6:	6784                	ld	s1,8(a5)
    80008ce8:	0084b903          	ld	s2,8(s1)
    80008cec:	04f48a63          	beq	s1,a5,80008d40 <timers_exe_all+0x7e>
    80008cf0:	e44e                	sd	s3,8(sp)
    80008cf2:	e052                	sd	s4,0(sp)
  {
    if (t->expires <= ticks) {
    80008cf4:	00003a17          	auipc	s4,0x3
    80008cf8:	324a0a13          	add	s4,s4,804 # 8000c018 <ticks>
  list_for_each_entry_safe(t, nt, &timers, list)
    80008cfc:	89be                	mv	s3,a5
    80008cfe:	a025                	j	80008d26 <timers_exe_all+0x64>
	__list_del(list->prev, list->next);
    80008d00:	6098                	ld	a4,0(s1)
    80008d02:	649c                	ld	a5,8(s1)
	prev->next = next;
    80008d04:	e71c                	sd	a5,8(a4)
	next->prev = prev;
    80008d06:	e398                	sd	a4,0(a5)
	list->prev = NULL;
    80008d08:	0004b023          	sd	zero,0(s1)
	list->next = NULL;
    80008d0c:	0004b423          	sd	zero,8(s1)
      if (!t->cancelled)
        t->handler(t->arg);
      list_del(&t->list);
      kfree(t);
    80008d10:	8526                	mv	a0,s1
    80008d12:	ffff7097          	auipc	ra,0xffff7
    80008d16:	30a080e7          	jalr	778(ra) # 8000001c <kfree>
  list_for_each_entry_safe(t, nt, &timers, list)
    80008d1a:	00893783          	ld	a5,8(s2)
    80008d1e:	84ca                	mv	s1,s2
    80008d20:	01390e63          	beq	s2,s3,80008d3c <timers_exe_all+0x7a>
    80008d24:	893e                	mv	s2,a5
    if (t->expires <= ticks) {
    80008d26:	5098                	lw	a4,32(s1)
    80008d28:	000a2783          	lw	a5,0(s4)
    80008d2c:	fee7e7e3          	bltu	a5,a4,80008d1a <timers_exe_all+0x58>
      if (!t->cancelled)
    80008d30:	50dc                	lw	a5,36(s1)
    80008d32:	f7f9                	bnez	a5,80008d00 <timers_exe_all+0x3e>
        t->handler(t->arg);
    80008d34:	749c                	ld	a5,40(s1)
    80008d36:	7888                	ld	a0,48(s1)
    80008d38:	9782                	jalr	a5
    80008d3a:	b7d9                	j	80008d00 <timers_exe_all+0x3e>
    80008d3c:	69a2                	ld	s3,8(sp)
    80008d3e:	6a02                	ld	s4,0(sp)
    }
  }

  while (!list_empty(&waitadds)) {
    80008d40:	00003797          	auipc	a5,0x3
    80008d44:	ed87b783          	ld	a5,-296(a5) # 8000bc18 <waitadds+0x8>
    80008d48:	00003717          	auipc	a4,0x3
    80008d4c:	ec870713          	add	a4,a4,-312 # 8000bc10 <waitadds>
    80008d50:	02e78e63          	beq	a5,a4,80008d8c <timers_exe_all+0xca>
	__list_add(list, head->prev, head);
    80008d54:	00003717          	auipc	a4,0x3
    80008d58:	eac70713          	add	a4,a4,-340 # 8000bc00 <timers>
    80008d5c:	00003597          	auipc	a1,0x3
    80008d60:	eb458593          	add	a1,a1,-332 # 8000bc10 <waitadds>
	__list_del(list->prev, list->next);
    80008d64:	6390                	ld	a2,0(a5)
    80008d66:	6794                	ld	a3,8(a5)
	prev->next = next;
    80008d68:	e614                	sd	a3,8(a2)
	next->prev = prev;
    80008d6a:	e290                	sd	a2,0(a3)
	list->prev = NULL;
    80008d6c:	0007b023          	sd	zero,0(a5)
	list->next = NULL;
    80008d70:	0007b423          	sd	zero,8(a5)
    struct timer *t = list_first_entry(&waitadds, struct timer, waitadd);
    list_del(&t->waitadd);
    list_add_tail(&t->list, &timers);
    80008d74:	ff078613          	add	a2,a5,-16
	__list_add(list, head->prev, head);
    80008d78:	6314                	ld	a3,0(a4)
	list->prev = prev;
    80008d7a:	fed7b823          	sd	a3,-16(a5)
	list->next = next;
    80008d7e:	fee7bc23          	sd	a4,-8(a5)
	next->prev = list;
    80008d82:	e310                	sd	a2,0(a4)
	prev->next = list;
    80008d84:	e690                	sd	a2,8(a3)
  while (!list_empty(&waitadds)) {
    80008d86:	6f1c                	ld	a5,24(a4)
    80008d88:	fcb79ee3          	bne	a5,a1,80008d64 <timers_exe_all+0xa2>
  }

  release(&timerslk);
    80008d8c:	00036517          	auipc	a0,0x36
    80008d90:	5e450513          	add	a0,a0,1508 # 8003f370 <timerslk>
    80008d94:	00001097          	auipc	ra,0x1
    80008d98:	ba4080e7          	jalr	-1116(ra) # 80009938 <release>
}
    80008d9c:	70a2                	ld	ra,40(sp)
    80008d9e:	7402                	ld	s0,32(sp)
    80008da0:	64e2                	ld	s1,24(sp)
    80008da2:	6942                	ld	s2,16(sp)
    80008da4:	6145                	add	sp,sp,48
    80008da6:	8082                	ret

0000000080008da8 <timerinit>:
// which arrive at timervec in kernelvec.S,
// which turns them into software interrupts for
// devintr() in trap.c.
void
timerinit()
{
    80008da8:	1141                	add	sp,sp,-16
    80008daa:	e422                	sd	s0,8(sp)
    80008dac:	0800                	add	s0,sp,16
  asm volatile("csrr %0, mhartid" : "=r" (x) );
    80008dae:	f14027f3          	csrr	a5,mhartid
  // each CPU has a separate source of timer interrupts.
  int id = r_mhartid();
    80008db2:	0007859b          	sext.w	a1,a5

  // ask the CLINT for a timer interrupt.
  int interval = 1000000; // cycles; about 1/10th second in qemu.
  *(uint64*)CLINT_MTIMECMP(id) = *(uint64*)CLINT_MTIME + interval;
    80008db6:	0037979b          	sllw	a5,a5,0x3
    80008dba:	02004737          	lui	a4,0x2004
    80008dbe:	97ba                	add	a5,a5,a4
    80008dc0:	0200c737          	lui	a4,0x200c
    80008dc4:	1761                	add	a4,a4,-8 # 200bff8 <_entry-0x7dff4008>
    80008dc6:	6318                	ld	a4,0(a4)
    80008dc8:	000f4637          	lui	a2,0xf4
    80008dcc:	24060613          	add	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    80008dd0:	9732                	add	a4,a4,a2
    80008dd2:	e398                	sd	a4,0(a5)

  // prepare information in scratch[] for timervec.
  // scratch[0..2] : space for timervec to save registers.
  // scratch[3] : address of CLINT MTIMECMP register.
  // scratch[4] : desired interval (in cycles) between timer interrupts.
  uint64 *scratch = &timer_scratch[id][0];
    80008dd4:	00259693          	sll	a3,a1,0x2
    80008dd8:	96ae                	add	a3,a3,a1
    80008dda:	068e                	sll	a3,a3,0x3
    80008ddc:	00036717          	auipc	a4,0x36
    80008de0:	5b470713          	add	a4,a4,1460 # 8003f390 <timer_scratch>
    80008de4:	9736                	add	a4,a4,a3
  scratch[3] = CLINT_MTIMECMP(id);
    80008de6:	ef1c                	sd	a5,24(a4)
  scratch[4] = interval;
    80008de8:	f310                	sd	a2,32(a4)
  asm volatile("csrw mscratch, %0" : : "r" (x));
    80008dea:	34071073          	csrw	mscratch,a4
  asm volatile("csrw mtvec, %0" : : "r" (x));
    80008dee:	ffffd797          	auipc	a5,0xffffd
    80008df2:	8f278793          	add	a5,a5,-1806 # 800056e0 <timervec>
    80008df6:	30579073          	csrw	mtvec,a5
  asm volatile("csrr %0, mstatus" : "=r" (x) );
    80008dfa:	300027f3          	csrr	a5,mstatus

  // set the machine-mode trap handler.
  w_mtvec((uint64)timervec);

  // enable machine-mode interrupts.
  w_mstatus(r_mstatus() | MSTATUS_MIE);
    80008dfe:	0087e793          	or	a5,a5,8
  asm volatile("csrw mstatus, %0" : : "r" (x));
    80008e02:	30079073          	csrw	mstatus,a5
  asm volatile("csrr %0, mie" : "=r" (x) );
    80008e06:	304027f3          	csrr	a5,mie

  // enable machine-mode timer interrupts.
  w_mie(r_mie() | MIE_MTIE);
    80008e0a:	0807e793          	or	a5,a5,128
  asm volatile("csrw mie, %0" : : "r" (x));
    80008e0e:	30479073          	csrw	mie,a5
}
    80008e12:	6422                	ld	s0,8(sp)
    80008e14:	0141                	add	sp,sp,16
    80008e16:	8082                	ret

0000000080008e18 <start>:
{
    80008e18:	1141                	add	sp,sp,-16
    80008e1a:	e406                	sd	ra,8(sp)
    80008e1c:	e022                	sd	s0,0(sp)
    80008e1e:	0800                	add	s0,sp,16
  asm volatile("csrr %0, mstatus" : "=r" (x) );
    80008e20:	300027f3          	csrr	a5,mstatus
  x &= ~MSTATUS_MPP_MASK;
    80008e24:	7779                	lui	a4,0xffffe
    80008e26:	7ff70713          	add	a4,a4,2047 # ffffffffffffe7ff <end+0xffffffff7ffb722f>
    80008e2a:	8ff9                	and	a5,a5,a4
  x |= MSTATUS_MPP_S;
    80008e2c:	6705                	lui	a4,0x1
    80008e2e:	80070713          	add	a4,a4,-2048 # 800 <_entry-0x7ffff800>
    80008e32:	8fd9                	or	a5,a5,a4
  asm volatile("csrw mstatus, %0" : : "r" (x));
    80008e34:	30079073          	csrw	mstatus,a5
  asm volatile("csrw mepc, %0" : : "r" (x));
    80008e38:	ffff7797          	auipc	a5,0xffff7
    80008e3c:	53878793          	add	a5,a5,1336 # 80000370 <main>
    80008e40:	34179073          	csrw	mepc,a5
  asm volatile("csrw satp, %0" : : "r" (x));
    80008e44:	4781                	li	a5,0
    80008e46:	18079073          	csrw	satp,a5
  asm volatile("csrw medeleg, %0" : : "r" (x));
    80008e4a:	67c1                	lui	a5,0x10
    80008e4c:	17fd                	add	a5,a5,-1 # ffff <_entry-0x7fff0001>
    80008e4e:	30279073          	csrw	medeleg,a5
  asm volatile("csrw mideleg, %0" : : "r" (x));
    80008e52:	30379073          	csrw	mideleg,a5
  asm volatile("csrr %0, sie" : "=r" (x) );
    80008e56:	104027f3          	csrr	a5,sie
  w_sie(r_sie() | SIE_SEIE | SIE_STIE | SIE_SSIE);
    80008e5a:	2227e793          	or	a5,a5,546
  asm volatile("csrw sie, %0" : : "r" (x));
    80008e5e:	10479073          	csrw	sie,a5
  timerinit();
    80008e62:	00000097          	auipc	ra,0x0
    80008e66:	f46080e7          	jalr	-186(ra) # 80008da8 <timerinit>
  asm volatile("csrr %0, mhartid" : "=r" (x) );
    80008e6a:	f14027f3          	csrr	a5,mhartid
  w_tp(id);
    80008e6e:	2781                	sext.w	a5,a5
  asm volatile("mv tp, %0" : : "r" (x));
    80008e70:	823e                	mv	tp,a5
  asm volatile("mret");
    80008e72:	30200073          	mret
}
    80008e76:	60a2                	ld	ra,8(sp)
    80008e78:	6402                	ld	s0,0(sp)
    80008e7a:	0141                	add	sp,sp,16
    80008e7c:	8082                	ret

0000000080008e7e <consolewrite>:
//
// user write()s to the console go here.
//
int
consolewrite(int user_src, uint64 src, int n)
{
    80008e7e:	715d                	add	sp,sp,-80
    80008e80:	e486                	sd	ra,72(sp)
    80008e82:	e0a2                	sd	s0,64(sp)
    80008e84:	f84a                	sd	s2,48(sp)
    80008e86:	0880                	add	s0,sp,80
  int i;

  for(i = 0; i < n; i++){
    80008e88:	04c05663          	blez	a2,80008ed4 <consolewrite+0x56>
    80008e8c:	fc26                	sd	s1,56(sp)
    80008e8e:	f44e                	sd	s3,40(sp)
    80008e90:	f052                	sd	s4,32(sp)
    80008e92:	ec56                	sd	s5,24(sp)
    80008e94:	8a2a                	mv	s4,a0
    80008e96:	84ae                	mv	s1,a1
    80008e98:	89b2                	mv	s3,a2
    80008e9a:	4901                	li	s2,0
    char c;
    if(either_copyin(&c, user_src, src+i, 1) == -1)
    80008e9c:	5afd                	li	s5,-1
    80008e9e:	4685                	li	a3,1
    80008ea0:	8626                	mv	a2,s1
    80008ea2:	85d2                	mv	a1,s4
    80008ea4:	fbf40513          	add	a0,s0,-65
    80008ea8:	ffff9097          	auipc	ra,0xffff9
    80008eac:	b66080e7          	jalr	-1178(ra) # 80001a0e <either_copyin>
    80008eb0:	03550463          	beq	a0,s5,80008ed8 <consolewrite+0x5a>
      break;
    uartputc(c);
    80008eb4:	fbf44503          	lbu	a0,-65(s0)
    80008eb8:	00000097          	auipc	ra,0x0
    80008ebc:	7fe080e7          	jalr	2046(ra) # 800096b6 <uartputc>
  for(i = 0; i < n; i++){
    80008ec0:	2905                	addw	s2,s2,1
    80008ec2:	0485                	add	s1,s1,1
    80008ec4:	fd299de3          	bne	s3,s2,80008e9e <consolewrite+0x20>
    80008ec8:	894e                	mv	s2,s3
    80008eca:	74e2                	ld	s1,56(sp)
    80008ecc:	79a2                	ld	s3,40(sp)
    80008ece:	7a02                	ld	s4,32(sp)
    80008ed0:	6ae2                	ld	s5,24(sp)
    80008ed2:	a039                	j	80008ee0 <consolewrite+0x62>
    80008ed4:	4901                	li	s2,0
    80008ed6:	a029                	j	80008ee0 <consolewrite+0x62>
    80008ed8:	74e2                	ld	s1,56(sp)
    80008eda:	79a2                	ld	s3,40(sp)
    80008edc:	7a02                	ld	s4,32(sp)
    80008ede:	6ae2                	ld	s5,24(sp)
  }

  return i;
}
    80008ee0:	854a                	mv	a0,s2
    80008ee2:	60a6                	ld	ra,72(sp)
    80008ee4:	6406                	ld	s0,64(sp)
    80008ee6:	7942                	ld	s2,48(sp)
    80008ee8:	6161                	add	sp,sp,80
    80008eea:	8082                	ret

0000000080008eec <consoleread>:
// user_dist indicates whether dst is a user
// or kernel address.
//
int
consoleread(int user_dst, uint64 dst, int n)
{
    80008eec:	711d                	add	sp,sp,-96
    80008eee:	ec86                	sd	ra,88(sp)
    80008ef0:	e8a2                	sd	s0,80(sp)
    80008ef2:	e4a6                	sd	s1,72(sp)
    80008ef4:	e0ca                	sd	s2,64(sp)
    80008ef6:	fc4e                	sd	s3,56(sp)
    80008ef8:	f852                	sd	s4,48(sp)
    80008efa:	f456                	sd	s5,40(sp)
    80008efc:	f05a                	sd	s6,32(sp)
    80008efe:	1080                	add	s0,sp,96
    80008f00:	8aaa                	mv	s5,a0
    80008f02:	8a2e                	mv	s4,a1
    80008f04:	89b2                	mv	s3,a2
  uint target;
  int c;
  char cbuf;

  target = n;
    80008f06:	00060b1b          	sext.w	s6,a2
  acquire(&cons.lock);
    80008f0a:	0003e517          	auipc	a0,0x3e
    80008f0e:	5c650513          	add	a0,a0,1478 # 800474d0 <cons>
    80008f12:	00001097          	auipc	ra,0x1
    80008f16:	960080e7          	jalr	-1696(ra) # 80009872 <acquire>
  while(n > 0){
    // wait until interrupt handler has put some
    // input into cons.buffer.
    while(cons.r == cons.w){
    80008f1a:	0003e497          	auipc	s1,0x3e
    80008f1e:	5b648493          	add	s1,s1,1462 # 800474d0 <cons>
      if(myproc()->killed){
        release(&cons.lock);
        return -1;
      }
      sleep(&cons.r, &cons.lock);
    80008f22:	0003e917          	auipc	s2,0x3e
    80008f26:	64690913          	add	s2,s2,1606 # 80047568 <cons+0x98>
  while(n > 0){
    80008f2a:	0d305463          	blez	s3,80008ff2 <consoleread+0x106>
    while(cons.r == cons.w){
    80008f2e:	0984a783          	lw	a5,152(s1)
    80008f32:	09c4a703          	lw	a4,156(s1)
    80008f36:	0af71963          	bne	a4,a5,80008fe8 <consoleread+0xfc>
      if(myproc()->killed){
    80008f3a:	ffff8097          	auipc	ra,0xffff8
    80008f3e:	00c080e7          	jalr	12(ra) # 80000f46 <myproc>
    80008f42:	591c                	lw	a5,48(a0)
    80008f44:	e7ad                	bnez	a5,80008fae <consoleread+0xc2>
      sleep(&cons.r, &cons.lock);
    80008f46:	85a6                	mv	a1,s1
    80008f48:	854a                	mv	a0,s2
    80008f4a:	ffff9097          	auipc	ra,0xffff9
    80008f4e:	814080e7          	jalr	-2028(ra) # 8000175e <sleep>
    while(cons.r == cons.w){
    80008f52:	0984a783          	lw	a5,152(s1)
    80008f56:	09c4a703          	lw	a4,156(s1)
    80008f5a:	fef700e3          	beq	a4,a5,80008f3a <consoleread+0x4e>
    80008f5e:	ec5e                	sd	s7,24(sp)
    }

    c = cons.buf[cons.r++ % INPUT_BUF];
    80008f60:	0003e717          	auipc	a4,0x3e
    80008f64:	57070713          	add	a4,a4,1392 # 800474d0 <cons>
    80008f68:	0017869b          	addw	a3,a5,1
    80008f6c:	08d72c23          	sw	a3,152(a4)
    80008f70:	07f7f693          	and	a3,a5,127
    80008f74:	9736                	add	a4,a4,a3
    80008f76:	01874703          	lbu	a4,24(a4)
    80008f7a:	00070b9b          	sext.w	s7,a4

    if(c == C('D')){  // end-of-file
    80008f7e:	4691                	li	a3,4
    80008f80:	04db8a63          	beq	s7,a3,80008fd4 <consoleread+0xe8>
      }
      break;
    }

    // copy the input byte to the user-space buffer.
    cbuf = c;
    80008f84:	fae407a3          	sb	a4,-81(s0)
    if(either_copyout(user_dst, dst, &cbuf, 1) == -1)
    80008f88:	4685                	li	a3,1
    80008f8a:	faf40613          	add	a2,s0,-81
    80008f8e:	85d2                	mv	a1,s4
    80008f90:	8556                	mv	a0,s5
    80008f92:	ffff9097          	auipc	ra,0xffff9
    80008f96:	a26080e7          	jalr	-1498(ra) # 800019b8 <either_copyout>
    80008f9a:	57fd                	li	a5,-1
    80008f9c:	04f50a63          	beq	a0,a5,80008ff0 <consoleread+0x104>
      break;

    dst++;
    80008fa0:	0a05                	add	s4,s4,1
    --n;
    80008fa2:	39fd                	addw	s3,s3,-1

    if(c == '\n'){
    80008fa4:	47a9                	li	a5,10
    80008fa6:	06fb8163          	beq	s7,a5,80009008 <consoleread+0x11c>
    80008faa:	6be2                	ld	s7,24(sp)
    80008fac:	bfbd                	j	80008f2a <consoleread+0x3e>
        release(&cons.lock);
    80008fae:	0003e517          	auipc	a0,0x3e
    80008fb2:	52250513          	add	a0,a0,1314 # 800474d0 <cons>
    80008fb6:	00001097          	auipc	ra,0x1
    80008fba:	982080e7          	jalr	-1662(ra) # 80009938 <release>
        return -1;
    80008fbe:	557d                	li	a0,-1
    }
  }
  release(&cons.lock);

  return target - n;
}
    80008fc0:	60e6                	ld	ra,88(sp)
    80008fc2:	6446                	ld	s0,80(sp)
    80008fc4:	64a6                	ld	s1,72(sp)
    80008fc6:	6906                	ld	s2,64(sp)
    80008fc8:	79e2                	ld	s3,56(sp)
    80008fca:	7a42                	ld	s4,48(sp)
    80008fcc:	7aa2                	ld	s5,40(sp)
    80008fce:	7b02                	ld	s6,32(sp)
    80008fd0:	6125                	add	sp,sp,96
    80008fd2:	8082                	ret
      if(n < target){
    80008fd4:	0009871b          	sext.w	a4,s3
    80008fd8:	01677a63          	bgeu	a4,s6,80008fec <consoleread+0x100>
        cons.r--;
    80008fdc:	0003e717          	auipc	a4,0x3e
    80008fe0:	58f72623          	sw	a5,1420(a4) # 80047568 <cons+0x98>
    80008fe4:	6be2                	ld	s7,24(sp)
    80008fe6:	a031                	j	80008ff2 <consoleread+0x106>
    80008fe8:	ec5e                	sd	s7,24(sp)
    80008fea:	bf9d                	j	80008f60 <consoleread+0x74>
    80008fec:	6be2                	ld	s7,24(sp)
    80008fee:	a011                	j	80008ff2 <consoleread+0x106>
    80008ff0:	6be2                	ld	s7,24(sp)
  release(&cons.lock);
    80008ff2:	0003e517          	auipc	a0,0x3e
    80008ff6:	4de50513          	add	a0,a0,1246 # 800474d0 <cons>
    80008ffa:	00001097          	auipc	ra,0x1
    80008ffe:	93e080e7          	jalr	-1730(ra) # 80009938 <release>
  return target - n;
    80009002:	413b053b          	subw	a0,s6,s3
    80009006:	bf6d                	j	80008fc0 <consoleread+0xd4>
    80009008:	6be2                	ld	s7,24(sp)
    8000900a:	b7e5                	j	80008ff2 <consoleread+0x106>

000000008000900c <consputc>:
{
    8000900c:	1141                	add	sp,sp,-16
    8000900e:	e406                	sd	ra,8(sp)
    80009010:	e022                	sd	s0,0(sp)
    80009012:	0800                	add	s0,sp,16
  if(c == BACKSPACE){
    80009014:	10000793          	li	a5,256
    80009018:	00f50a63          	beq	a0,a5,8000902c <consputc+0x20>
    uartputc_sync(c);
    8000901c:	00000097          	auipc	ra,0x0
    80009020:	5bc080e7          	jalr	1468(ra) # 800095d8 <uartputc_sync>
}
    80009024:	60a2                	ld	ra,8(sp)
    80009026:	6402                	ld	s0,0(sp)
    80009028:	0141                	add	sp,sp,16
    8000902a:	8082                	ret
    uartputc_sync('\b'); uartputc_sync(' '); uartputc_sync('\b');
    8000902c:	4521                	li	a0,8
    8000902e:	00000097          	auipc	ra,0x0
    80009032:	5aa080e7          	jalr	1450(ra) # 800095d8 <uartputc_sync>
    80009036:	02000513          	li	a0,32
    8000903a:	00000097          	auipc	ra,0x0
    8000903e:	59e080e7          	jalr	1438(ra) # 800095d8 <uartputc_sync>
    80009042:	4521                	li	a0,8
    80009044:	00000097          	auipc	ra,0x0
    80009048:	594080e7          	jalr	1428(ra) # 800095d8 <uartputc_sync>
    8000904c:	bfe1                	j	80009024 <consputc+0x18>

000000008000904e <consoleintr>:
// do erase/kill processing, append to cons.buf,
// wake up consoleread() if a whole line has arrived.
//
void
consoleintr(int c)
{
    8000904e:	1101                	add	sp,sp,-32
    80009050:	ec06                	sd	ra,24(sp)
    80009052:	e822                	sd	s0,16(sp)
    80009054:	e426                	sd	s1,8(sp)
    80009056:	1000                	add	s0,sp,32
    80009058:	84aa                	mv	s1,a0
  acquire(&cons.lock);
    8000905a:	0003e517          	auipc	a0,0x3e
    8000905e:	47650513          	add	a0,a0,1142 # 800474d0 <cons>
    80009062:	00001097          	auipc	ra,0x1
    80009066:	810080e7          	jalr	-2032(ra) # 80009872 <acquire>

  switch(c){
    8000906a:	47d5                	li	a5,21
    8000906c:	0af48563          	beq	s1,a5,80009116 <consoleintr+0xc8>
    80009070:	0297c963          	blt	a5,s1,800090a2 <consoleintr+0x54>
    80009074:	47a1                	li	a5,8
    80009076:	0ef48c63          	beq	s1,a5,8000916e <consoleintr+0x120>
    8000907a:	47c1                	li	a5,16
    8000907c:	10f49f63          	bne	s1,a5,8000919a <consoleintr+0x14c>
  case C('P'):  // Print process list.
    procdump();
    80009080:	ffff9097          	auipc	ra,0xffff9
    80009084:	9e4080e7          	jalr	-1564(ra) # 80001a64 <procdump>
      }
    }
    break;
  }
  
  release(&cons.lock);
    80009088:	0003e517          	auipc	a0,0x3e
    8000908c:	44850513          	add	a0,a0,1096 # 800474d0 <cons>
    80009090:	00001097          	auipc	ra,0x1
    80009094:	8a8080e7          	jalr	-1880(ra) # 80009938 <release>
}
    80009098:	60e2                	ld	ra,24(sp)
    8000909a:	6442                	ld	s0,16(sp)
    8000909c:	64a2                	ld	s1,8(sp)
    8000909e:	6105                	add	sp,sp,32
    800090a0:	8082                	ret
  switch(c){
    800090a2:	07f00793          	li	a5,127
    800090a6:	0cf48463          	beq	s1,a5,8000916e <consoleintr+0x120>
    if(c != 0 && cons.e-cons.r < INPUT_BUF){
    800090aa:	0003e717          	auipc	a4,0x3e
    800090ae:	42670713          	add	a4,a4,1062 # 800474d0 <cons>
    800090b2:	0a072783          	lw	a5,160(a4)
    800090b6:	09872703          	lw	a4,152(a4)
    800090ba:	9f99                	subw	a5,a5,a4
    800090bc:	07f00713          	li	a4,127
    800090c0:	fcf764e3          	bltu	a4,a5,80009088 <consoleintr+0x3a>
      c = (c == '\r') ? '\n' : c;
    800090c4:	47b5                	li	a5,13
    800090c6:	0cf48d63          	beq	s1,a5,800091a0 <consoleintr+0x152>
      consputc(c);
    800090ca:	8526                	mv	a0,s1
    800090cc:	00000097          	auipc	ra,0x0
    800090d0:	f40080e7          	jalr	-192(ra) # 8000900c <consputc>
      cons.buf[cons.e++ % INPUT_BUF] = c;
    800090d4:	0003e797          	auipc	a5,0x3e
    800090d8:	3fc78793          	add	a5,a5,1020 # 800474d0 <cons>
    800090dc:	0a07a703          	lw	a4,160(a5)
    800090e0:	0017069b          	addw	a3,a4,1
    800090e4:	0006861b          	sext.w	a2,a3
    800090e8:	0ad7a023          	sw	a3,160(a5)
    800090ec:	07f77713          	and	a4,a4,127
    800090f0:	97ba                	add	a5,a5,a4
    800090f2:	00978c23          	sb	s1,24(a5)
      if(c == '\n' || c == C('D') || cons.e == cons.r+INPUT_BUF){
    800090f6:	47a9                	li	a5,10
    800090f8:	0cf48b63          	beq	s1,a5,800091ce <consoleintr+0x180>
    800090fc:	4791                	li	a5,4
    800090fe:	0cf48863          	beq	s1,a5,800091ce <consoleintr+0x180>
    80009102:	0003e797          	auipc	a5,0x3e
    80009106:	4667a783          	lw	a5,1126(a5) # 80047568 <cons+0x98>
    8000910a:	0807879b          	addw	a5,a5,128
    8000910e:	f6f61de3          	bne	a2,a5,80009088 <consoleintr+0x3a>
    80009112:	863e                	mv	a2,a5
    80009114:	a86d                	j	800091ce <consoleintr+0x180>
    80009116:	e04a                	sd	s2,0(sp)
    while(cons.e != cons.w &&
    80009118:	0003e717          	auipc	a4,0x3e
    8000911c:	3b870713          	add	a4,a4,952 # 800474d0 <cons>
    80009120:	0a072783          	lw	a5,160(a4)
    80009124:	09c72703          	lw	a4,156(a4)
          cons.buf[(cons.e-1) % INPUT_BUF] != '\n'){
    80009128:	0003e497          	auipc	s1,0x3e
    8000912c:	3a848493          	add	s1,s1,936 # 800474d0 <cons>
    while(cons.e != cons.w &&
    80009130:	4929                	li	s2,10
    80009132:	02f70a63          	beq	a4,a5,80009166 <consoleintr+0x118>
          cons.buf[(cons.e-1) % INPUT_BUF] != '\n'){
    80009136:	37fd                	addw	a5,a5,-1
    80009138:	07f7f713          	and	a4,a5,127
    8000913c:	9726                	add	a4,a4,s1
    while(cons.e != cons.w &&
    8000913e:	01874703          	lbu	a4,24(a4)
    80009142:	03270463          	beq	a4,s2,8000916a <consoleintr+0x11c>
      cons.e--;
    80009146:	0af4a023          	sw	a5,160(s1)
      consputc(BACKSPACE);
    8000914a:	10000513          	li	a0,256
    8000914e:	00000097          	auipc	ra,0x0
    80009152:	ebe080e7          	jalr	-322(ra) # 8000900c <consputc>
    while(cons.e != cons.w &&
    80009156:	0a04a783          	lw	a5,160(s1)
    8000915a:	09c4a703          	lw	a4,156(s1)
    8000915e:	fcf71ce3          	bne	a4,a5,80009136 <consoleintr+0xe8>
    80009162:	6902                	ld	s2,0(sp)
    80009164:	b715                	j	80009088 <consoleintr+0x3a>
    80009166:	6902                	ld	s2,0(sp)
    80009168:	b705                	j	80009088 <consoleintr+0x3a>
    8000916a:	6902                	ld	s2,0(sp)
    8000916c:	bf31                	j	80009088 <consoleintr+0x3a>
    if(cons.e != cons.w){
    8000916e:	0003e717          	auipc	a4,0x3e
    80009172:	36270713          	add	a4,a4,866 # 800474d0 <cons>
    80009176:	0a072783          	lw	a5,160(a4)
    8000917a:	09c72703          	lw	a4,156(a4)
    8000917e:	f0f705e3          	beq	a4,a5,80009088 <consoleintr+0x3a>
      cons.e--;
    80009182:	37fd                	addw	a5,a5,-1
    80009184:	0003e717          	auipc	a4,0x3e
    80009188:	3ef72623          	sw	a5,1004(a4) # 80047570 <cons+0xa0>
      consputc(BACKSPACE);
    8000918c:	10000513          	li	a0,256
    80009190:	00000097          	auipc	ra,0x0
    80009194:	e7c080e7          	jalr	-388(ra) # 8000900c <consputc>
    80009198:	bdc5                	j	80009088 <consoleintr+0x3a>
    if(c != 0 && cons.e-cons.r < INPUT_BUF){
    8000919a:	ee0487e3          	beqz	s1,80009088 <consoleintr+0x3a>
    8000919e:	b731                	j	800090aa <consoleintr+0x5c>
      consputc(c);
    800091a0:	4529                	li	a0,10
    800091a2:	00000097          	auipc	ra,0x0
    800091a6:	e6a080e7          	jalr	-406(ra) # 8000900c <consputc>
      cons.buf[cons.e++ % INPUT_BUF] = c;
    800091aa:	0003e797          	auipc	a5,0x3e
    800091ae:	32678793          	add	a5,a5,806 # 800474d0 <cons>
    800091b2:	0a07a703          	lw	a4,160(a5)
    800091b6:	0017069b          	addw	a3,a4,1
    800091ba:	0006861b          	sext.w	a2,a3
    800091be:	0ad7a023          	sw	a3,160(a5)
    800091c2:	07f77713          	and	a4,a4,127
    800091c6:	97ba                	add	a5,a5,a4
    800091c8:	4729                	li	a4,10
    800091ca:	00e78c23          	sb	a4,24(a5)
        cons.w = cons.e;
    800091ce:	0003e797          	auipc	a5,0x3e
    800091d2:	38c7af23          	sw	a2,926(a5) # 8004756c <cons+0x9c>
        wakeup(&cons.r);
    800091d6:	0003e517          	auipc	a0,0x3e
    800091da:	39250513          	add	a0,a0,914 # 80047568 <cons+0x98>
    800091de:	ffff8097          	auipc	ra,0xffff8
    800091e2:	700080e7          	jalr	1792(ra) # 800018de <wakeup>
    800091e6:	b54d                	j	80009088 <consoleintr+0x3a>

00000000800091e8 <consoleinit>:

void
consoleinit(void)
{
    800091e8:	1141                	add	sp,sp,-16
    800091ea:	e406                	sd	ra,8(sp)
    800091ec:	e022                	sd	s0,0(sp)
    800091ee:	0800                	add	s0,sp,16
  initlock(&cons.lock, "cons");
    800091f0:	00002597          	auipc	a1,0x2
    800091f4:	6b058593          	add	a1,a1,1712 # 8000b8a0 <etext+0x8a0>
    800091f8:	0003e517          	auipc	a0,0x3e
    800091fc:	2d850513          	add	a0,a0,728 # 800474d0 <cons>
    80009200:	00000097          	auipc	ra,0x0
    80009204:	5e2080e7          	jalr	1506(ra) # 800097e2 <initlock>

  uartinit();
    80009208:	00000097          	auipc	ra,0x0
    8000920c:	374080e7          	jalr	884(ra) # 8000957c <uartinit>

  // connect read and write system calls
  // to consoleread and consolewrite.
  devsw[CONSOLE].read = consoleread;
    80009210:	00025797          	auipc	a5,0x25
    80009214:	ec078793          	add	a5,a5,-320 # 8002e0d0 <devsw>
    80009218:	00000717          	auipc	a4,0x0
    8000921c:	cd470713          	add	a4,a4,-812 # 80008eec <consoleread>
    80009220:	eb98                	sd	a4,16(a5)
  devsw[CONSOLE].write = consolewrite;
    80009222:	00000717          	auipc	a4,0x0
    80009226:	c5c70713          	add	a4,a4,-932 # 80008e7e <consolewrite>
    8000922a:	ef98                	sd	a4,24(a5)
}
    8000922c:	60a2                	ld	ra,8(sp)
    8000922e:	6402                	ld	s0,0(sp)
    80009230:	0141                	add	sp,sp,16
    80009232:	8082                	ret

0000000080009234 <printint>:

static char digits[] = "0123456789abcdef";

static void
printint(int xx, int base, int sign)
{
    80009234:	7179                	add	sp,sp,-48
    80009236:	f406                	sd	ra,40(sp)
    80009238:	f022                	sd	s0,32(sp)
    8000923a:	1800                	add	s0,sp,48
  char buf[16];
  int i;
  uint x;

  if(sign && (sign = xx < 0))
    8000923c:	c219                	beqz	a2,80009242 <printint+0xe>
    8000923e:	08054963          	bltz	a0,800092d0 <printint+0x9c>
    x = -xx;
  else
    x = xx;
    80009242:	2501                	sext.w	a0,a0
    80009244:	4881                	li	a7,0
    80009246:	fd040693          	add	a3,s0,-48

  i = 0;
    8000924a:	4701                	li	a4,0
  do {
    buf[i++] = digits[x % base];
    8000924c:	2581                	sext.w	a1,a1
    8000924e:	00003617          	auipc	a2,0x3
    80009252:	8ea60613          	add	a2,a2,-1814 # 8000bb38 <digits>
    80009256:	883a                	mv	a6,a4
    80009258:	2705                	addw	a4,a4,1
    8000925a:	02b577bb          	remuw	a5,a0,a1
    8000925e:	1782                	sll	a5,a5,0x20
    80009260:	9381                	srl	a5,a5,0x20
    80009262:	97b2                	add	a5,a5,a2
    80009264:	0007c783          	lbu	a5,0(a5)
    80009268:	00f68023          	sb	a5,0(a3)
  } while((x /= base) != 0);
    8000926c:	0005079b          	sext.w	a5,a0
    80009270:	02b5553b          	divuw	a0,a0,a1
    80009274:	0685                	add	a3,a3,1
    80009276:	feb7f0e3          	bgeu	a5,a1,80009256 <printint+0x22>

  if(sign)
    8000927a:	00088c63          	beqz	a7,80009292 <printint+0x5e>
    buf[i++] = '-';
    8000927e:	fe070793          	add	a5,a4,-32
    80009282:	00878733          	add	a4,a5,s0
    80009286:	02d00793          	li	a5,45
    8000928a:	fef70823          	sb	a5,-16(a4)
    8000928e:	0028071b          	addw	a4,a6,2 # ff0002 <_entry-0x7f00fffe>

  while(--i >= 0)
    80009292:	02e05b63          	blez	a4,800092c8 <printint+0x94>
    80009296:	ec26                	sd	s1,24(sp)
    80009298:	e84a                	sd	s2,16(sp)
    8000929a:	fd040793          	add	a5,s0,-48
    8000929e:	00e784b3          	add	s1,a5,a4
    800092a2:	fff78913          	add	s2,a5,-1
    800092a6:	993a                	add	s2,s2,a4
    800092a8:	377d                	addw	a4,a4,-1
    800092aa:	1702                	sll	a4,a4,0x20
    800092ac:	9301                	srl	a4,a4,0x20
    800092ae:	40e90933          	sub	s2,s2,a4
    consputc(buf[i]);
    800092b2:	fff4c503          	lbu	a0,-1(s1)
    800092b6:	00000097          	auipc	ra,0x0
    800092ba:	d56080e7          	jalr	-682(ra) # 8000900c <consputc>
  while(--i >= 0)
    800092be:	14fd                	add	s1,s1,-1
    800092c0:	ff2499e3          	bne	s1,s2,800092b2 <printint+0x7e>
    800092c4:	64e2                	ld	s1,24(sp)
    800092c6:	6942                	ld	s2,16(sp)
}
    800092c8:	70a2                	ld	ra,40(sp)
    800092ca:	7402                	ld	s0,32(sp)
    800092cc:	6145                	add	sp,sp,48
    800092ce:	8082                	ret
    x = -xx;
    800092d0:	40a0053b          	negw	a0,a0
  if(sign && (sign = xx < 0))
    800092d4:	4885                	li	a7,1
    x = -xx;
    800092d6:	bf85                	j	80009246 <printint+0x12>

00000000800092d8 <panic>:
    release(&pr.lock);
}

void
panic(char *s)
{
    800092d8:	1101                	add	sp,sp,-32
    800092da:	ec06                	sd	ra,24(sp)
    800092dc:	e822                	sd	s0,16(sp)
    800092de:	e426                	sd	s1,8(sp)
    800092e0:	1000                	add	s0,sp,32
    800092e2:	84aa                	mv	s1,a0
  pr.locking = 0;
    800092e4:	0003e797          	auipc	a5,0x3e
    800092e8:	2a07a623          	sw	zero,684(a5) # 80047590 <pr+0x18>
  printf("panic: ");
    800092ec:	00002517          	auipc	a0,0x2
    800092f0:	5bc50513          	add	a0,a0,1468 # 8000b8a8 <etext+0x8a8>
    800092f4:	00000097          	auipc	ra,0x0
    800092f8:	02e080e7          	jalr	46(ra) # 80009322 <printf>
  printf(s);
    800092fc:	8526                	mv	a0,s1
    800092fe:	00000097          	auipc	ra,0x0
    80009302:	024080e7          	jalr	36(ra) # 80009322 <printf>
  printf("\n");
    80009306:	00002517          	auipc	a0,0x2
    8000930a:	d3250513          	add	a0,a0,-718 # 8000b038 <etext+0x38>
    8000930e:	00000097          	auipc	ra,0x0
    80009312:	014080e7          	jalr	20(ra) # 80009322 <printf>
  panicked = 1; // freeze uart output from other CPUs
    80009316:	4785                	li	a5,1
    80009318:	00003717          	auipc	a4,0x3
    8000931c:	d0f72c23          	sw	a5,-744(a4) # 8000c030 <panicked>
  for(;;)
    80009320:	a001                	j	80009320 <panic+0x48>

0000000080009322 <printf>:
{
    80009322:	7171                	add	sp,sp,-176
    80009324:	f486                	sd	ra,104(sp)
    80009326:	f0a2                	sd	s0,96(sp)
    80009328:	e8ca                	sd	s2,80(sp)
    8000932a:	f062                	sd	s8,32(sp)
    8000932c:	1880                	add	s0,sp,112
    8000932e:	892a                	mv	s2,a0
    80009330:	e40c                	sd	a1,8(s0)
    80009332:	e810                	sd	a2,16(s0)
    80009334:	ec14                	sd	a3,24(s0)
    80009336:	f018                	sd	a4,32(s0)
    80009338:	f41c                	sd	a5,40(s0)
    8000933a:	03043823          	sd	a6,48(s0)
    8000933e:	03143c23          	sd	a7,56(s0)
  locking = pr.locking;
    80009342:	0003ec17          	auipc	s8,0x3e
    80009346:	24ec2c03          	lw	s8,590(s8) # 80047590 <pr+0x18>
  if(locking)
    8000934a:	040c1263          	bnez	s8,8000938e <printf+0x6c>
  if (fmt == 0)
    8000934e:	04090963          	beqz	s2,800093a0 <printf+0x7e>
  va_start(ap, fmt);
    80009352:	00840793          	add	a5,s0,8
    80009356:	f8f43c23          	sd	a5,-104(s0)
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
    8000935a:	00094503          	lbu	a0,0(s2)
    8000935e:	1a050c63          	beqz	a0,80009516 <printf+0x1f4>
    80009362:	eca6                	sd	s1,88(sp)
    80009364:	e4ce                	sd	s3,72(sp)
    80009366:	e0d2                	sd	s4,64(sp)
    80009368:	fc56                	sd	s5,56(sp)
    8000936a:	f85a                	sd	s6,48(sp)
    8000936c:	f45e                	sd	s7,40(sp)
    8000936e:	ec66                	sd	s9,24(sp)
    80009370:	e86a                	sd	s10,16(sp)
    80009372:	4481                	li	s1,0
    if(c != '%'){
    80009374:	02500993          	li	s3,37
    switch(c){
    80009378:	4ad5                	li	s5,21
    8000937a:	00002b97          	auipc	s7,0x2
    8000937e:	766b8b93          	add	s7,s7,1894 # 8000bae0 <digits+0x38>
  consputc('x');
    80009382:	4cc1                	li	s9,16
    consputc(digits[x >> (sizeof(uint64) * 8 - 4)]);
    80009384:	00002a17          	auipc	s4,0x2
    80009388:	7b4a0a13          	add	s4,s4,1972 # 8000bb38 <digits>
    8000938c:	a0a9                	j	800093d6 <printf+0xb4>
    acquire(&pr.lock);
    8000938e:	0003e517          	auipc	a0,0x3e
    80009392:	1ea50513          	add	a0,a0,490 # 80047578 <pr>
    80009396:	00000097          	auipc	ra,0x0
    8000939a:	4dc080e7          	jalr	1244(ra) # 80009872 <acquire>
    8000939e:	bf45                	j	8000934e <printf+0x2c>
    800093a0:	eca6                	sd	s1,88(sp)
    800093a2:	e4ce                	sd	s3,72(sp)
    800093a4:	e0d2                	sd	s4,64(sp)
    800093a6:	fc56                	sd	s5,56(sp)
    800093a8:	f85a                	sd	s6,48(sp)
    800093aa:	f45e                	sd	s7,40(sp)
    800093ac:	ec66                	sd	s9,24(sp)
    800093ae:	e86a                	sd	s10,16(sp)
    panic("null fmt");
    800093b0:	00002517          	auipc	a0,0x2
    800093b4:	3d050513          	add	a0,a0,976 # 8000b780 <etext+0x780>
    800093b8:	00000097          	auipc	ra,0x0
    800093bc:	f20080e7          	jalr	-224(ra) # 800092d8 <panic>
      consputc(c);
    800093c0:	00000097          	auipc	ra,0x0
    800093c4:	c4c080e7          	jalr	-948(ra) # 8000900c <consputc>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
    800093c8:	2485                	addw	s1,s1,1
    800093ca:	009907b3          	add	a5,s2,s1
    800093ce:	0007c503          	lbu	a0,0(a5)
    800093d2:	12050a63          	beqz	a0,80009506 <printf+0x1e4>
    if(c != '%'){
    800093d6:	ff3515e3          	bne	a0,s3,800093c0 <printf+0x9e>
    c = fmt[++i] & 0xff;
    800093da:	2485                	addw	s1,s1,1
    800093dc:	009907b3          	add	a5,s2,s1
    800093e0:	0007c783          	lbu	a5,0(a5)
    800093e4:	00078b1b          	sext.w	s6,a5
    if(c == 0)
    800093e8:	12078f63          	beqz	a5,80009526 <printf+0x204>
    switch(c){
    800093ec:	0f378c63          	beq	a5,s3,800094e4 <printf+0x1c2>
    800093f0:	f9d7871b          	addw	a4,a5,-99
    800093f4:	0ff77713          	zext.b	a4,a4
    800093f8:	0eeaec63          	bltu	s5,a4,800094f0 <printf+0x1ce>
    800093fc:	f9d7879b          	addw	a5,a5,-99
    80009400:	0ff7f713          	zext.b	a4,a5
    80009404:	0eeae663          	bltu	s5,a4,800094f0 <printf+0x1ce>
    80009408:	00271793          	sll	a5,a4,0x2
    8000940c:	97de                	add	a5,a5,s7
    8000940e:	439c                	lw	a5,0(a5)
    80009410:	97de                	add	a5,a5,s7
    80009412:	8782                	jr	a5
      printint(va_arg(ap, int), 10, 1);
    80009414:	f9843783          	ld	a5,-104(s0)
    80009418:	00878713          	add	a4,a5,8
    8000941c:	f8e43c23          	sd	a4,-104(s0)
    80009420:	4605                	li	a2,1
    80009422:	45a9                	li	a1,10
    80009424:	4388                	lw	a0,0(a5)
    80009426:	00000097          	auipc	ra,0x0
    8000942a:	e0e080e7          	jalr	-498(ra) # 80009234 <printint>
      break;
    8000942e:	bf69                	j	800093c8 <printf+0xa6>
      printint(va_arg(ap, int), 16, 1);
    80009430:	f9843783          	ld	a5,-104(s0)
    80009434:	00878713          	add	a4,a5,8
    80009438:	f8e43c23          	sd	a4,-104(s0)
    8000943c:	4605                	li	a2,1
    8000943e:	85e6                	mv	a1,s9
    80009440:	4388                	lw	a0,0(a5)
    80009442:	00000097          	auipc	ra,0x0
    80009446:	df2080e7          	jalr	-526(ra) # 80009234 <printint>
      break;
    8000944a:	bfbd                	j	800093c8 <printf+0xa6>
      printptr(va_arg(ap, uint64));
    8000944c:	f9843783          	ld	a5,-104(s0)
    80009450:	00878713          	add	a4,a5,8
    80009454:	f8e43c23          	sd	a4,-104(s0)
    80009458:	0007bd03          	ld	s10,0(a5)
  consputc('0');
    8000945c:	03000513          	li	a0,48
    80009460:	00000097          	auipc	ra,0x0
    80009464:	bac080e7          	jalr	-1108(ra) # 8000900c <consputc>
  consputc('x');
    80009468:	07800513          	li	a0,120
    8000946c:	00000097          	auipc	ra,0x0
    80009470:	ba0080e7          	jalr	-1120(ra) # 8000900c <consputc>
    80009474:	8b66                	mv	s6,s9
    consputc(digits[x >> (sizeof(uint64) * 8 - 4)]);
    80009476:	03cd5793          	srl	a5,s10,0x3c
    8000947a:	97d2                	add	a5,a5,s4
    8000947c:	0007c503          	lbu	a0,0(a5)
    80009480:	00000097          	auipc	ra,0x0
    80009484:	b8c080e7          	jalr	-1140(ra) # 8000900c <consputc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    80009488:	0d12                	sll	s10,s10,0x4
    8000948a:	3b7d                	addw	s6,s6,-1 # 3fffffff <_entry-0x40000001>
    8000948c:	fe0b15e3          	bnez	s6,80009476 <printf+0x154>
    80009490:	bf25                	j	800093c8 <printf+0xa6>
      consputc(va_arg(ap, int));
    80009492:	f9843783          	ld	a5,-104(s0)
    80009496:	00878713          	add	a4,a5,8
    8000949a:	f8e43c23          	sd	a4,-104(s0)
    8000949e:	4388                	lw	a0,0(a5)
    800094a0:	00000097          	auipc	ra,0x0
    800094a4:	b6c080e7          	jalr	-1172(ra) # 8000900c <consputc>
      break;
    800094a8:	b705                	j	800093c8 <printf+0xa6>
      if((s = va_arg(ap, char*)) == 0)
    800094aa:	f9843783          	ld	a5,-104(s0)
    800094ae:	00878713          	add	a4,a5,8
    800094b2:	f8e43c23          	sd	a4,-104(s0)
    800094b6:	0007bb03          	ld	s6,0(a5)
    800094ba:	000b0e63          	beqz	s6,800094d6 <printf+0x1b4>
      for(; *s; s++)
    800094be:	000b4503          	lbu	a0,0(s6)
    800094c2:	d119                	beqz	a0,800093c8 <printf+0xa6>
        consputc(*s);
    800094c4:	00000097          	auipc	ra,0x0
    800094c8:	b48080e7          	jalr	-1208(ra) # 8000900c <consputc>
      for(; *s; s++)
    800094cc:	0b05                	add	s6,s6,1
    800094ce:	000b4503          	lbu	a0,0(s6)
    800094d2:	f96d                	bnez	a0,800094c4 <printf+0x1a2>
    800094d4:	bdd5                	j	800093c8 <printf+0xa6>
        s = "(null)";
    800094d6:	00002b17          	auipc	s6,0x2
    800094da:	2a2b0b13          	add	s6,s6,674 # 8000b778 <etext+0x778>
      for(; *s; s++)
    800094de:	02800513          	li	a0,40
    800094e2:	b7cd                	j	800094c4 <printf+0x1a2>
      consputc('%');
    800094e4:	854e                	mv	a0,s3
    800094e6:	00000097          	auipc	ra,0x0
    800094ea:	b26080e7          	jalr	-1242(ra) # 8000900c <consputc>
      break;
    800094ee:	bde9                	j	800093c8 <printf+0xa6>
      consputc('%');
    800094f0:	854e                	mv	a0,s3
    800094f2:	00000097          	auipc	ra,0x0
    800094f6:	b1a080e7          	jalr	-1254(ra) # 8000900c <consputc>
      consputc(c);
    800094fa:	855a                	mv	a0,s6
    800094fc:	00000097          	auipc	ra,0x0
    80009500:	b10080e7          	jalr	-1264(ra) # 8000900c <consputc>
      break;
    80009504:	b5d1                	j	800093c8 <printf+0xa6>
    80009506:	64e6                	ld	s1,88(sp)
    80009508:	69a6                	ld	s3,72(sp)
    8000950a:	6a06                	ld	s4,64(sp)
    8000950c:	7ae2                	ld	s5,56(sp)
    8000950e:	7b42                	ld	s6,48(sp)
    80009510:	7ba2                	ld	s7,40(sp)
    80009512:	6ce2                	ld	s9,24(sp)
    80009514:	6d42                	ld	s10,16(sp)
  if(locking)
    80009516:	020c1163          	bnez	s8,80009538 <printf+0x216>
}
    8000951a:	70a6                	ld	ra,104(sp)
    8000951c:	7406                	ld	s0,96(sp)
    8000951e:	6946                	ld	s2,80(sp)
    80009520:	7c02                	ld	s8,32(sp)
    80009522:	614d                	add	sp,sp,176
    80009524:	8082                	ret
    80009526:	64e6                	ld	s1,88(sp)
    80009528:	69a6                	ld	s3,72(sp)
    8000952a:	6a06                	ld	s4,64(sp)
    8000952c:	7ae2                	ld	s5,56(sp)
    8000952e:	7b42                	ld	s6,48(sp)
    80009530:	7ba2                	ld	s7,40(sp)
    80009532:	6ce2                	ld	s9,24(sp)
    80009534:	6d42                	ld	s10,16(sp)
    80009536:	b7c5                	j	80009516 <printf+0x1f4>
    release(&pr.lock);
    80009538:	0003e517          	auipc	a0,0x3e
    8000953c:	04050513          	add	a0,a0,64 # 80047578 <pr>
    80009540:	00000097          	auipc	ra,0x0
    80009544:	3f8080e7          	jalr	1016(ra) # 80009938 <release>
}
    80009548:	bfc9                	j	8000951a <printf+0x1f8>

000000008000954a <printfinit>:
    ;
}

void
printfinit(void)
{
    8000954a:	1101                	add	sp,sp,-32
    8000954c:	ec06                	sd	ra,24(sp)
    8000954e:	e822                	sd	s0,16(sp)
    80009550:	e426                	sd	s1,8(sp)
    80009552:	1000                	add	s0,sp,32
  initlock(&pr.lock, "pr");
    80009554:	0003e497          	auipc	s1,0x3e
    80009558:	02448493          	add	s1,s1,36 # 80047578 <pr>
    8000955c:	00002597          	auipc	a1,0x2
    80009560:	35458593          	add	a1,a1,852 # 8000b8b0 <etext+0x8b0>
    80009564:	8526                	mv	a0,s1
    80009566:	00000097          	auipc	ra,0x0
    8000956a:	27c080e7          	jalr	636(ra) # 800097e2 <initlock>
  pr.locking = 1;
    8000956e:	4785                	li	a5,1
    80009570:	cc9c                	sw	a5,24(s1)
}
    80009572:	60e2                	ld	ra,24(sp)
    80009574:	6442                	ld	s0,16(sp)
    80009576:	64a2                	ld	s1,8(sp)
    80009578:	6105                	add	sp,sp,32
    8000957a:	8082                	ret

000000008000957c <uartinit>:

void uartstart();

void
uartinit(void)
{
    8000957c:	1141                	add	sp,sp,-16
    8000957e:	e406                	sd	ra,8(sp)
    80009580:	e022                	sd	s0,0(sp)
    80009582:	0800                	add	s0,sp,16
  // disable interrupts.
  WriteReg(IER, 0x00);
    80009584:	100007b7          	lui	a5,0x10000
    80009588:	000780a3          	sb	zero,1(a5) # 10000001 <_entry-0x6fffffff>

  // special mode to set baud rate.
  WriteReg(LCR, LCR_BAUD_LATCH);
    8000958c:	10000737          	lui	a4,0x10000
    80009590:	f8000693          	li	a3,-128
    80009594:	00d701a3          	sb	a3,3(a4) # 10000003 <_entry-0x6ffffffd>

  // LSB for baud rate of 38.4K.
  WriteReg(0, 0x03);
    80009598:	468d                	li	a3,3
    8000959a:	10000637          	lui	a2,0x10000
    8000959e:	00d60023          	sb	a3,0(a2) # 10000000 <_entry-0x70000000>

  // MSB for baud rate of 38.4K.
  WriteReg(1, 0x00);
    800095a2:	000780a3          	sb	zero,1(a5)

  // leave set-baud mode,
  // and set word length to 8 bits, no parity.
  WriteReg(LCR, LCR_EIGHT_BITS);
    800095a6:	00d701a3          	sb	a3,3(a4)

  // reset and enable FIFOs.
  WriteReg(FCR, FCR_FIFO_ENABLE | FCR_FIFO_CLEAR);
    800095aa:	10000737          	lui	a4,0x10000
    800095ae:	461d                	li	a2,7
    800095b0:	00c70123          	sb	a2,2(a4) # 10000002 <_entry-0x6ffffffe>

  // enable transmit and receive interrupts.
  WriteReg(IER, IER_TX_ENABLE | IER_RX_ENABLE);
    800095b4:	00d780a3          	sb	a3,1(a5)

  initlock(&uart_tx_lock, "uart");
    800095b8:	00002597          	auipc	a1,0x2
    800095bc:	30058593          	add	a1,a1,768 # 8000b8b8 <etext+0x8b8>
    800095c0:	0003e517          	auipc	a0,0x3e
    800095c4:	fd850513          	add	a0,a0,-40 # 80047598 <uart_tx_lock>
    800095c8:	00000097          	auipc	ra,0x0
    800095cc:	21a080e7          	jalr	538(ra) # 800097e2 <initlock>
}
    800095d0:	60a2                	ld	ra,8(sp)
    800095d2:	6402                	ld	s0,0(sp)
    800095d4:	0141                	add	sp,sp,16
    800095d6:	8082                	ret

00000000800095d8 <uartputc_sync>:
// use interrupts, for use by kernel printf() and
// to echo characters. it spins waiting for the uart's
// output register to be empty.
void
uartputc_sync(int c)
{
    800095d8:	1101                	add	sp,sp,-32
    800095da:	ec06                	sd	ra,24(sp)
    800095dc:	e822                	sd	s0,16(sp)
    800095de:	e426                	sd	s1,8(sp)
    800095e0:	1000                	add	s0,sp,32
    800095e2:	84aa                	mv	s1,a0
  push_off();
    800095e4:	00000097          	auipc	ra,0x0
    800095e8:	242080e7          	jalr	578(ra) # 80009826 <push_off>

  if(panicked){
    800095ec:	00003797          	auipc	a5,0x3
    800095f0:	a447a783          	lw	a5,-1468(a5) # 8000c030 <panicked>
    800095f4:	eb85                	bnez	a5,80009624 <uartputc_sync+0x4c>
    for(;;)
      ;
  }

  // wait for Transmit Holding Empty to be set in LSR.
  while((ReadReg(LSR) & LSR_TX_IDLE) == 0)
    800095f6:	10000737          	lui	a4,0x10000
    800095fa:	0715                	add	a4,a4,5 # 10000005 <_entry-0x6ffffffb>
    800095fc:	00074783          	lbu	a5,0(a4)
    80009600:	0207f793          	and	a5,a5,32
    80009604:	dfe5                	beqz	a5,800095fc <uartputc_sync+0x24>
    ;
  WriteReg(THR, c);
    80009606:	0ff4f513          	zext.b	a0,s1
    8000960a:	100007b7          	lui	a5,0x10000
    8000960e:	00a78023          	sb	a0,0(a5) # 10000000 <_entry-0x70000000>

  pop_off();
    80009612:	00000097          	auipc	ra,0x0
    80009616:	2c6080e7          	jalr	710(ra) # 800098d8 <pop_off>
}
    8000961a:	60e2                	ld	ra,24(sp)
    8000961c:	6442                	ld	s0,16(sp)
    8000961e:	64a2                	ld	s1,8(sp)
    80009620:	6105                	add	sp,sp,32
    80009622:	8082                	ret
    for(;;)
    80009624:	a001                	j	80009624 <uartputc_sync+0x4c>

0000000080009626 <uartstart>:
// called from both the top- and bottom-half.
void
uartstart()
{
  while(1){
    if(uart_tx_w == uart_tx_r){
    80009626:	00003797          	auipc	a5,0x3
    8000962a:	a127b783          	ld	a5,-1518(a5) # 8000c038 <uart_tx_r>
    8000962e:	00003717          	auipc	a4,0x3
    80009632:	a1273703          	ld	a4,-1518(a4) # 8000c040 <uart_tx_w>
    80009636:	06f70f63          	beq	a4,a5,800096b4 <uartstart+0x8e>
{
    8000963a:	7139                	add	sp,sp,-64
    8000963c:	fc06                	sd	ra,56(sp)
    8000963e:	f822                	sd	s0,48(sp)
    80009640:	f426                	sd	s1,40(sp)
    80009642:	f04a                	sd	s2,32(sp)
    80009644:	ec4e                	sd	s3,24(sp)
    80009646:	e852                	sd	s4,16(sp)
    80009648:	e456                	sd	s5,8(sp)
    8000964a:	e05a                	sd	s6,0(sp)
    8000964c:	0080                	add	s0,sp,64
      // transmit buffer is empty.
      return;
    }
    
    if((ReadReg(LSR) & LSR_TX_IDLE) == 0){
    8000964e:	10000937          	lui	s2,0x10000
    80009652:	0915                	add	s2,s2,5 # 10000005 <_entry-0x6ffffffb>
      // so we cannot give it another byte.
      // it will interrupt when it's ready for a new byte.
      return;
    }
    
    int c = uart_tx_buf[uart_tx_r % UART_TX_BUF_SIZE];
    80009654:	0003ea97          	auipc	s5,0x3e
    80009658:	f44a8a93          	add	s5,s5,-188 # 80047598 <uart_tx_lock>
    uart_tx_r += 1;
    8000965c:	00003497          	auipc	s1,0x3
    80009660:	9dc48493          	add	s1,s1,-1572 # 8000c038 <uart_tx_r>
    
    // maybe uartputc() is waiting for space in the buffer.
    wakeup(&uart_tx_r);
    
    WriteReg(THR, c);
    80009664:	10000a37          	lui	s4,0x10000
    if(uart_tx_w == uart_tx_r){
    80009668:	00003997          	auipc	s3,0x3
    8000966c:	9d898993          	add	s3,s3,-1576 # 8000c040 <uart_tx_w>
    if((ReadReg(LSR) & LSR_TX_IDLE) == 0){
    80009670:	00094703          	lbu	a4,0(s2)
    80009674:	02077713          	and	a4,a4,32
    80009678:	c705                	beqz	a4,800096a0 <uartstart+0x7a>
    int c = uart_tx_buf[uart_tx_r % UART_TX_BUF_SIZE];
    8000967a:	01f7f713          	and	a4,a5,31
    8000967e:	9756                	add	a4,a4,s5
    80009680:	01874b03          	lbu	s6,24(a4)
    uart_tx_r += 1;
    80009684:	0785                	add	a5,a5,1
    80009686:	e09c                	sd	a5,0(s1)
    wakeup(&uart_tx_r);
    80009688:	8526                	mv	a0,s1
    8000968a:	ffff8097          	auipc	ra,0xffff8
    8000968e:	254080e7          	jalr	596(ra) # 800018de <wakeup>
    WriteReg(THR, c);
    80009692:	016a0023          	sb	s6,0(s4) # 10000000 <_entry-0x70000000>
    if(uart_tx_w == uart_tx_r){
    80009696:	609c                	ld	a5,0(s1)
    80009698:	0009b703          	ld	a4,0(s3)
    8000969c:	fcf71ae3          	bne	a4,a5,80009670 <uartstart+0x4a>
  }
}
    800096a0:	70e2                	ld	ra,56(sp)
    800096a2:	7442                	ld	s0,48(sp)
    800096a4:	74a2                	ld	s1,40(sp)
    800096a6:	7902                	ld	s2,32(sp)
    800096a8:	69e2                	ld	s3,24(sp)
    800096aa:	6a42                	ld	s4,16(sp)
    800096ac:	6aa2                	ld	s5,8(sp)
    800096ae:	6b02                	ld	s6,0(sp)
    800096b0:	6121                	add	sp,sp,64
    800096b2:	8082                	ret
    800096b4:	8082                	ret

00000000800096b6 <uartputc>:
{
    800096b6:	7179                	add	sp,sp,-48
    800096b8:	f406                	sd	ra,40(sp)
    800096ba:	f022                	sd	s0,32(sp)
    800096bc:	e052                	sd	s4,0(sp)
    800096be:	1800                	add	s0,sp,48
    800096c0:	8a2a                	mv	s4,a0
  acquire(&uart_tx_lock);
    800096c2:	0003e517          	auipc	a0,0x3e
    800096c6:	ed650513          	add	a0,a0,-298 # 80047598 <uart_tx_lock>
    800096ca:	00000097          	auipc	ra,0x0
    800096ce:	1a8080e7          	jalr	424(ra) # 80009872 <acquire>
  if(panicked){
    800096d2:	00003797          	auipc	a5,0x3
    800096d6:	95e7a783          	lw	a5,-1698(a5) # 8000c030 <panicked>
    800096da:	c391                	beqz	a5,800096de <uartputc+0x28>
    for(;;)
    800096dc:	a001                	j	800096dc <uartputc+0x26>
    800096de:	ec26                	sd	s1,24(sp)
    if(uart_tx_w == uart_tx_r + UART_TX_BUF_SIZE){
    800096e0:	00003717          	auipc	a4,0x3
    800096e4:	96073703          	ld	a4,-1696(a4) # 8000c040 <uart_tx_w>
    800096e8:	00003797          	auipc	a5,0x3
    800096ec:	9507b783          	ld	a5,-1712(a5) # 8000c038 <uart_tx_r>
    800096f0:	02078793          	add	a5,a5,32
    800096f4:	02e79f63          	bne	a5,a4,80009732 <uartputc+0x7c>
    800096f8:	e84a                	sd	s2,16(sp)
    800096fa:	e44e                	sd	s3,8(sp)
      sleep(&uart_tx_r, &uart_tx_lock);
    800096fc:	0003e997          	auipc	s3,0x3e
    80009700:	e9c98993          	add	s3,s3,-356 # 80047598 <uart_tx_lock>
    80009704:	00003497          	auipc	s1,0x3
    80009708:	93448493          	add	s1,s1,-1740 # 8000c038 <uart_tx_r>
    if(uart_tx_w == uart_tx_r + UART_TX_BUF_SIZE){
    8000970c:	00003917          	auipc	s2,0x3
    80009710:	93490913          	add	s2,s2,-1740 # 8000c040 <uart_tx_w>
      sleep(&uart_tx_r, &uart_tx_lock);
    80009714:	85ce                	mv	a1,s3
    80009716:	8526                	mv	a0,s1
    80009718:	ffff8097          	auipc	ra,0xffff8
    8000971c:	046080e7          	jalr	70(ra) # 8000175e <sleep>
    if(uart_tx_w == uart_tx_r + UART_TX_BUF_SIZE){
    80009720:	00093703          	ld	a4,0(s2)
    80009724:	609c                	ld	a5,0(s1)
    80009726:	02078793          	add	a5,a5,32
    8000972a:	fee785e3          	beq	a5,a4,80009714 <uartputc+0x5e>
    8000972e:	6942                	ld	s2,16(sp)
    80009730:	69a2                	ld	s3,8(sp)
      uart_tx_buf[uart_tx_w % UART_TX_BUF_SIZE] = c;
    80009732:	0003e497          	auipc	s1,0x3e
    80009736:	e6648493          	add	s1,s1,-410 # 80047598 <uart_tx_lock>
    8000973a:	01f77793          	and	a5,a4,31
    8000973e:	97a6                	add	a5,a5,s1
    80009740:	01478c23          	sb	s4,24(a5)
      uart_tx_w += 1;
    80009744:	0705                	add	a4,a4,1
    80009746:	00003797          	auipc	a5,0x3
    8000974a:	8ee7bd23          	sd	a4,-1798(a5) # 8000c040 <uart_tx_w>
      uartstart();
    8000974e:	00000097          	auipc	ra,0x0
    80009752:	ed8080e7          	jalr	-296(ra) # 80009626 <uartstart>
      release(&uart_tx_lock);
    80009756:	8526                	mv	a0,s1
    80009758:	00000097          	auipc	ra,0x0
    8000975c:	1e0080e7          	jalr	480(ra) # 80009938 <release>
    80009760:	64e2                	ld	s1,24(sp)
}
    80009762:	70a2                	ld	ra,40(sp)
    80009764:	7402                	ld	s0,32(sp)
    80009766:	6a02                	ld	s4,0(sp)
    80009768:	6145                	add	sp,sp,48
    8000976a:	8082                	ret

000000008000976c <uartgetc>:

// read one input character from the UART.
// return -1 if none is waiting.
int
uartgetc(void)
{
    8000976c:	1141                	add	sp,sp,-16
    8000976e:	e422                	sd	s0,8(sp)
    80009770:	0800                	add	s0,sp,16
  if(ReadReg(LSR) & 0x01){
    80009772:	100007b7          	lui	a5,0x10000
    80009776:	0795                	add	a5,a5,5 # 10000005 <_entry-0x6ffffffb>
    80009778:	0007c783          	lbu	a5,0(a5)
    8000977c:	8b85                	and	a5,a5,1
    8000977e:	cb81                	beqz	a5,8000978e <uartgetc+0x22>
    // input data is ready.
    return ReadReg(RHR);
    80009780:	100007b7          	lui	a5,0x10000
    80009784:	0007c503          	lbu	a0,0(a5) # 10000000 <_entry-0x70000000>
  } else {
    return -1;
  }
}
    80009788:	6422                	ld	s0,8(sp)
    8000978a:	0141                	add	sp,sp,16
    8000978c:	8082                	ret
    return -1;
    8000978e:	557d                	li	a0,-1
    80009790:	bfe5                	j	80009788 <uartgetc+0x1c>

0000000080009792 <uartintr>:
// handle a uart interrupt, raised because input has
// arrived, or the uart is ready for more output, or
// both. called from trap.c.
void
uartintr(void)
{
    80009792:	1101                	add	sp,sp,-32
    80009794:	ec06                	sd	ra,24(sp)
    80009796:	e822                	sd	s0,16(sp)
    80009798:	e426                	sd	s1,8(sp)
    8000979a:	1000                	add	s0,sp,32
  // read and process incoming characters.
  while(1){
    int c = uartgetc();
    if(c == -1)
    8000979c:	54fd                	li	s1,-1
    8000979e:	a029                	j	800097a8 <uartintr+0x16>
      break;
    consoleintr(c);
    800097a0:	00000097          	auipc	ra,0x0
    800097a4:	8ae080e7          	jalr	-1874(ra) # 8000904e <consoleintr>
    int c = uartgetc();
    800097a8:	00000097          	auipc	ra,0x0
    800097ac:	fc4080e7          	jalr	-60(ra) # 8000976c <uartgetc>
    if(c == -1)
    800097b0:	fe9518e3          	bne	a0,s1,800097a0 <uartintr+0xe>
  }

  // send buffered characters.
  acquire(&uart_tx_lock);
    800097b4:	0003e497          	auipc	s1,0x3e
    800097b8:	de448493          	add	s1,s1,-540 # 80047598 <uart_tx_lock>
    800097bc:	8526                	mv	a0,s1
    800097be:	00000097          	auipc	ra,0x0
    800097c2:	0b4080e7          	jalr	180(ra) # 80009872 <acquire>
  uartstart();
    800097c6:	00000097          	auipc	ra,0x0
    800097ca:	e60080e7          	jalr	-416(ra) # 80009626 <uartstart>
  release(&uart_tx_lock);
    800097ce:	8526                	mv	a0,s1
    800097d0:	00000097          	auipc	ra,0x0
    800097d4:	168080e7          	jalr	360(ra) # 80009938 <release>
}
    800097d8:	60e2                	ld	ra,24(sp)
    800097da:	6442                	ld	s0,16(sp)
    800097dc:	64a2                	ld	s1,8(sp)
    800097de:	6105                	add	sp,sp,32
    800097e0:	8082                	ret

00000000800097e2 <initlock>:
}
#endif

void
initlock(struct spinlock *lk, char *name)
{
    800097e2:	1141                	add	sp,sp,-16
    800097e4:	e422                	sd	s0,8(sp)
    800097e6:	0800                	add	s0,sp,16
  lk->name = name;
    800097e8:	e50c                	sd	a1,8(a0)
  lk->locked = 0;
    800097ea:	00052023          	sw	zero,0(a0)
  lk->cpu = 0;
    800097ee:	00053823          	sd	zero,16(a0)
#ifdef LAB_LOCK
  lk->nts = 0;
  lk->n = 0;
  findslot(lk);
#endif  
}
    800097f2:	6422                	ld	s0,8(sp)
    800097f4:	0141                	add	sp,sp,16
    800097f6:	8082                	ret

00000000800097f8 <holding>:
// Interrupts must be off.
int
holding(struct spinlock *lk)
{
  int r;
  r = (lk->locked && lk->cpu == mycpu());
    800097f8:	411c                	lw	a5,0(a0)
    800097fa:	e399                	bnez	a5,80009800 <holding+0x8>
    800097fc:	4501                	li	a0,0
  return r;
}
    800097fe:	8082                	ret
{
    80009800:	1101                	add	sp,sp,-32
    80009802:	ec06                	sd	ra,24(sp)
    80009804:	e822                	sd	s0,16(sp)
    80009806:	e426                	sd	s1,8(sp)
    80009808:	1000                	add	s0,sp,32
  r = (lk->locked && lk->cpu == mycpu());
    8000980a:	6904                	ld	s1,16(a0)
    8000980c:	ffff7097          	auipc	ra,0xffff7
    80009810:	71e080e7          	jalr	1822(ra) # 80000f2a <mycpu>
    80009814:	40a48533          	sub	a0,s1,a0
    80009818:	00153513          	seqz	a0,a0
}
    8000981c:	60e2                	ld	ra,24(sp)
    8000981e:	6442                	ld	s0,16(sp)
    80009820:	64a2                	ld	s1,8(sp)
    80009822:	6105                	add	sp,sp,32
    80009824:	8082                	ret

0000000080009826 <push_off>:
// it takes two pop_off()s to undo two push_off()s.  Also, if interrupts
// are initially off, then push_off, pop_off leaves them off.

void
push_off(void)
{
    80009826:	1101                	add	sp,sp,-32
    80009828:	ec06                	sd	ra,24(sp)
    8000982a:	e822                	sd	s0,16(sp)
    8000982c:	e426                	sd	s1,8(sp)
    8000982e:	1000                	add	s0,sp,32
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80009830:	100024f3          	csrr	s1,sstatus
    80009834:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() & ~SSTATUS_SIE);
    80009838:	9bf5                	and	a5,a5,-3
  asm volatile("csrw sstatus, %0" : : "r" (x));
    8000983a:	10079073          	csrw	sstatus,a5
  int old = intr_get();

  intr_off();
  if(mycpu()->noff == 0)
    8000983e:	ffff7097          	auipc	ra,0xffff7
    80009842:	6ec080e7          	jalr	1772(ra) # 80000f2a <mycpu>
    80009846:	5d3c                	lw	a5,120(a0)
    80009848:	cf89                	beqz	a5,80009862 <push_off+0x3c>
    mycpu()->intena = old;
  mycpu()->noff += 1;
    8000984a:	ffff7097          	auipc	ra,0xffff7
    8000984e:	6e0080e7          	jalr	1760(ra) # 80000f2a <mycpu>
    80009852:	5d3c                	lw	a5,120(a0)
    80009854:	2785                	addw	a5,a5,1
    80009856:	dd3c                	sw	a5,120(a0)
}
    80009858:	60e2                	ld	ra,24(sp)
    8000985a:	6442                	ld	s0,16(sp)
    8000985c:	64a2                	ld	s1,8(sp)
    8000985e:	6105                	add	sp,sp,32
    80009860:	8082                	ret
    mycpu()->intena = old;
    80009862:	ffff7097          	auipc	ra,0xffff7
    80009866:	6c8080e7          	jalr	1736(ra) # 80000f2a <mycpu>
  return (x & SSTATUS_SIE) != 0;
    8000986a:	8085                	srl	s1,s1,0x1
    8000986c:	8885                	and	s1,s1,1
    8000986e:	dd64                	sw	s1,124(a0)
    80009870:	bfe9                	j	8000984a <push_off+0x24>

0000000080009872 <acquire>:
{
    80009872:	1101                	add	sp,sp,-32
    80009874:	ec06                	sd	ra,24(sp)
    80009876:	e822                	sd	s0,16(sp)
    80009878:	e426                	sd	s1,8(sp)
    8000987a:	1000                	add	s0,sp,32
    8000987c:	84aa                	mv	s1,a0
  push_off(); // disable interrupts to avoid deadlock.
    8000987e:	00000097          	auipc	ra,0x0
    80009882:	fa8080e7          	jalr	-88(ra) # 80009826 <push_off>
  if(holding(lk)) {
    80009886:	8526                	mv	a0,s1
    80009888:	00000097          	auipc	ra,0x0
    8000988c:	f70080e7          	jalr	-144(ra) # 800097f8 <holding>
  while(__sync_lock_test_and_set(&lk->locked, 1) != 0) {
    80009890:	4705                	li	a4,1
  if(holding(lk)) {
    80009892:	e115                	bnez	a0,800098b6 <acquire+0x44>
  while(__sync_lock_test_and_set(&lk->locked, 1) != 0) {
    80009894:	87ba                	mv	a5,a4
    80009896:	0cf4a7af          	amoswap.w.aq	a5,a5,(s1)
    8000989a:	2781                	sext.w	a5,a5
    8000989c:	ffe5                	bnez	a5,80009894 <acquire+0x22>
  __sync_synchronize();
    8000989e:	0ff0000f          	fence
  lk->cpu = mycpu();
    800098a2:	ffff7097          	auipc	ra,0xffff7
    800098a6:	688080e7          	jalr	1672(ra) # 80000f2a <mycpu>
    800098aa:	e888                	sd	a0,16(s1)
}
    800098ac:	60e2                	ld	ra,24(sp)
    800098ae:	6442                	ld	s0,16(sp)
    800098b0:	64a2                	ld	s1,8(sp)
    800098b2:	6105                	add	sp,sp,32
    800098b4:	8082                	ret
    printf("acquire_lock: %s\n", lk->name);
    800098b6:	648c                	ld	a1,8(s1)
    800098b8:	00002517          	auipc	a0,0x2
    800098bc:	00850513          	add	a0,a0,8 # 8000b8c0 <etext+0x8c0>
    800098c0:	00000097          	auipc	ra,0x0
    800098c4:	a62080e7          	jalr	-1438(ra) # 80009322 <printf>
    panic("acquire");
    800098c8:	00002517          	auipc	a0,0x2
    800098cc:	01050513          	add	a0,a0,16 # 8000b8d8 <etext+0x8d8>
    800098d0:	00000097          	auipc	ra,0x0
    800098d4:	a08080e7          	jalr	-1528(ra) # 800092d8 <panic>

00000000800098d8 <pop_off>:

void
pop_off(void)
{
    800098d8:	1141                	add	sp,sp,-16
    800098da:	e406                	sd	ra,8(sp)
    800098dc:	e022                	sd	s0,0(sp)
    800098de:	0800                	add	s0,sp,16
  struct cpu *c = mycpu();
    800098e0:	ffff7097          	auipc	ra,0xffff7
    800098e4:	64a080e7          	jalr	1610(ra) # 80000f2a <mycpu>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    800098e8:	100027f3          	csrr	a5,sstatus
  return (x & SSTATUS_SIE) != 0;
    800098ec:	8b89                	and	a5,a5,2
  if(intr_get())
    800098ee:	e78d                	bnez	a5,80009918 <pop_off+0x40>
    panic("pop_off - interruptible");
  if(c->noff < 1)
    800098f0:	5d3c                	lw	a5,120(a0)
    800098f2:	02f05b63          	blez	a5,80009928 <pop_off+0x50>
    panic("pop_off");
  c->noff -= 1;
    800098f6:	37fd                	addw	a5,a5,-1
    800098f8:	0007871b          	sext.w	a4,a5
    800098fc:	dd3c                	sw	a5,120(a0)
  if(c->noff == 0 && c->intena)
    800098fe:	eb09                	bnez	a4,80009910 <pop_off+0x38>
    80009900:	5d7c                	lw	a5,124(a0)
    80009902:	c799                	beqz	a5,80009910 <pop_off+0x38>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80009904:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() | SSTATUS_SIE);
    80009908:	0027e793          	or	a5,a5,2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    8000990c:	10079073          	csrw	sstatus,a5
    intr_on();
}
    80009910:	60a2                	ld	ra,8(sp)
    80009912:	6402                	ld	s0,0(sp)
    80009914:	0141                	add	sp,sp,16
    80009916:	8082                	ret
    panic("pop_off - interruptible");
    80009918:	00002517          	auipc	a0,0x2
    8000991c:	fc850513          	add	a0,a0,-56 # 8000b8e0 <etext+0x8e0>
    80009920:	00000097          	auipc	ra,0x0
    80009924:	9b8080e7          	jalr	-1608(ra) # 800092d8 <panic>
    panic("pop_off");
    80009928:	00002517          	auipc	a0,0x2
    8000992c:	fd050513          	add	a0,a0,-48 # 8000b8f8 <etext+0x8f8>
    80009930:	00000097          	auipc	ra,0x0
    80009934:	9a8080e7          	jalr	-1624(ra) # 800092d8 <panic>

0000000080009938 <release>:
{
    80009938:	1101                	add	sp,sp,-32
    8000993a:	ec06                	sd	ra,24(sp)
    8000993c:	e822                	sd	s0,16(sp)
    8000993e:	e426                	sd	s1,8(sp)
    80009940:	1000                	add	s0,sp,32
    80009942:	84aa                	mv	s1,a0
  if(!holding(lk)) {
    80009944:	00000097          	auipc	ra,0x0
    80009948:	eb4080e7          	jalr	-332(ra) # 800097f8 <holding>
    8000994c:	c115                	beqz	a0,80009970 <release+0x38>
  lk->cpu = 0;
    8000994e:	0004b823          	sd	zero,16(s1)
  __sync_synchronize();
    80009952:	0ff0000f          	fence
  __sync_lock_release(&lk->locked);
    80009956:	0f50000f          	fence	iorw,ow
    8000995a:	0804a02f          	amoswap.w	zero,zero,(s1)
  pop_off();
    8000995e:	00000097          	auipc	ra,0x0
    80009962:	f7a080e7          	jalr	-134(ra) # 800098d8 <pop_off>
}
    80009966:	60e2                	ld	ra,24(sp)
    80009968:	6442                	ld	s0,16(sp)
    8000996a:	64a2                	ld	s1,8(sp)
    8000996c:	6105                	add	sp,sp,32
    8000996e:	8082                	ret
    printf("release_lock: %s\n", lk->name);
    80009970:	648c                	ld	a1,8(s1)
    80009972:	00002517          	auipc	a0,0x2
    80009976:	f8e50513          	add	a0,a0,-114 # 8000b900 <etext+0x900>
    8000997a:	00000097          	auipc	ra,0x0
    8000997e:	9a8080e7          	jalr	-1624(ra) # 80009322 <printf>
    panic("release");
    80009982:	00002517          	auipc	a0,0x2
    80009986:	f9650513          	add	a0,a0,-106 # 8000b918 <etext+0x918>
    8000998a:	00000097          	auipc	ra,0x0
    8000998e:	94e080e7          	jalr	-1714(ra) # 800092d8 <panic>

0000000080009992 <lockfree_read8>:

// Read a shared 64-bit value without holding a lock
uint64
lockfree_read8(uint64 *addr) {
    80009992:	1141                	add	sp,sp,-16
    80009994:	e422                	sd	s0,8(sp)
    80009996:	0800                	add	s0,sp,16
  uint64 val;
  __atomic_load(addr, &val, __ATOMIC_SEQ_CST);
    80009998:	0ff0000f          	fence
    8000999c:	6108                	ld	a0,0(a0)
    8000999e:	0ff0000f          	fence
  return val;
}
    800099a2:	6422                	ld	s0,8(sp)
    800099a4:	0141                	add	sp,sp,16
    800099a6:	8082                	ret

00000000800099a8 <lockfree_read4>:

// Read a shared 32-bit value without holding a lock
int
lockfree_read4(int *addr) {
    800099a8:	1141                	add	sp,sp,-16
    800099aa:	e422                	sd	s0,8(sp)
    800099ac:	0800                	add	s0,sp,16
  uint32 val;
  __atomic_load(addr, &val, __ATOMIC_SEQ_CST);
    800099ae:	0ff0000f          	fence
    800099b2:	4108                	lw	a0,0(a0)
    800099b4:	0ff0000f          	fence
  return val;
}
    800099b8:	6422                	ld	s0,8(sp)
    800099ba:	0141                	add	sp,sp,16
    800099bc:	8082                	ret
	...

000000008000a000 <_trampoline>:
    8000a000:	14051573          	csrrw	a0,sscratch,a0
    8000a004:	02153423          	sd	ra,40(a0)
    8000a008:	02253823          	sd	sp,48(a0)
    8000a00c:	02353c23          	sd	gp,56(a0)
    8000a010:	04453023          	sd	tp,64(a0)
    8000a014:	04553423          	sd	t0,72(a0)
    8000a018:	04653823          	sd	t1,80(a0)
    8000a01c:	04753c23          	sd	t2,88(a0)
    8000a020:	f120                	sd	s0,96(a0)
    8000a022:	f524                	sd	s1,104(a0)
    8000a024:	fd2c                	sd	a1,120(a0)
    8000a026:	e150                	sd	a2,128(a0)
    8000a028:	e554                	sd	a3,136(a0)
    8000a02a:	e958                	sd	a4,144(a0)
    8000a02c:	ed5c                	sd	a5,152(a0)
    8000a02e:	0b053023          	sd	a6,160(a0)
    8000a032:	0b153423          	sd	a7,168(a0)
    8000a036:	0b253823          	sd	s2,176(a0)
    8000a03a:	0b353c23          	sd	s3,184(a0)
    8000a03e:	0d453023          	sd	s4,192(a0)
    8000a042:	0d553423          	sd	s5,200(a0)
    8000a046:	0d653823          	sd	s6,208(a0)
    8000a04a:	0d753c23          	sd	s7,216(a0)
    8000a04e:	0f853023          	sd	s8,224(a0)
    8000a052:	0f953423          	sd	s9,232(a0)
    8000a056:	0fa53823          	sd	s10,240(a0)
    8000a05a:	0fb53c23          	sd	s11,248(a0)
    8000a05e:	11c53023          	sd	t3,256(a0)
    8000a062:	11d53423          	sd	t4,264(a0)
    8000a066:	11e53823          	sd	t5,272(a0)
    8000a06a:	11f53c23          	sd	t6,280(a0)
    8000a06e:	140022f3          	csrr	t0,sscratch
    8000a072:	06553823          	sd	t0,112(a0)
    8000a076:	00853103          	ld	sp,8(a0)
    8000a07a:	02053203          	ld	tp,32(a0)
    8000a07e:	01053283          	ld	t0,16(a0)
    8000a082:	00053303          	ld	t1,0(a0)
    8000a086:	18031073          	csrw	satp,t1
    8000a08a:	12000073          	sfence.vma
    8000a08e:	8282                	jr	t0

000000008000a090 <userret>:
    8000a090:	18059073          	csrw	satp,a1
    8000a094:	12000073          	sfence.vma
    8000a098:	07053283          	ld	t0,112(a0)
    8000a09c:	14029073          	csrw	sscratch,t0
    8000a0a0:	02853083          	ld	ra,40(a0)
    8000a0a4:	03053103          	ld	sp,48(a0)
    8000a0a8:	03853183          	ld	gp,56(a0)
    8000a0ac:	04053203          	ld	tp,64(a0)
    8000a0b0:	04853283          	ld	t0,72(a0)
    8000a0b4:	05053303          	ld	t1,80(a0)
    8000a0b8:	05853383          	ld	t2,88(a0)
    8000a0bc:	7120                	ld	s0,96(a0)
    8000a0be:	7524                	ld	s1,104(a0)
    8000a0c0:	7d2c                	ld	a1,120(a0)
    8000a0c2:	6150                	ld	a2,128(a0)
    8000a0c4:	6554                	ld	a3,136(a0)
    8000a0c6:	6958                	ld	a4,144(a0)
    8000a0c8:	6d5c                	ld	a5,152(a0)
    8000a0ca:	0a053803          	ld	a6,160(a0)
    8000a0ce:	0a853883          	ld	a7,168(a0)
    8000a0d2:	0b053903          	ld	s2,176(a0)
    8000a0d6:	0b853983          	ld	s3,184(a0)
    8000a0da:	0c053a03          	ld	s4,192(a0)
    8000a0de:	0c853a83          	ld	s5,200(a0)
    8000a0e2:	0d053b03          	ld	s6,208(a0)
    8000a0e6:	0d853b83          	ld	s7,216(a0)
    8000a0ea:	0e053c03          	ld	s8,224(a0)
    8000a0ee:	0e853c83          	ld	s9,232(a0)
    8000a0f2:	0f053d03          	ld	s10,240(a0)
    8000a0f6:	0f853d83          	ld	s11,248(a0)
    8000a0fa:	10053e03          	ld	t3,256(a0)
    8000a0fe:	10853e83          	ld	t4,264(a0)
    8000a102:	11053f03          	ld	t5,272(a0)
    8000a106:	11853f83          	ld	t6,280(a0)
    8000a10a:	14051573          	csrrw	a0,sscratch,a0
    8000a10e:	10200073          	sret
	...
