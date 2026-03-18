	.attribute	4, 16
	.attribute	5, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_zicsr2p0_zifencei2p0_zmmul1p0_zaamo1p0_zalrsc1p0"
	.file	"test_ptr_arith.c"
	.text
	.globl	main                            # -- Begin function main
	.p2align	2
	.type	main,@function
main:                                   # @main
# %bb.0:
	addi	sp, sp, -48
	sd	ra, 40(sp)                      # 8-byte Folded Spill
	sd	s0, 32(sp)                      # 8-byte Folded Spill
	addi	s0, sp, 48
	li	a0, 0
	sw	a0, -20(s0)
	li	a0, 5
	sw	a0, -24(s0)
	li	a0, 1
	slli	a1, a0, 34
	addi	a1, a1, 3
	sd	a1, -32(s0)
	slli	a0, a0, 33
	addi	a0, a0, 1
	sd	a0, -40(s0)
	addi	a0, s0, -40
	sd	a0, -48(s0)
	ld	a0, -48(s0)
	addi	a0, a0, 8
	sd	a0, -48(s0)
	ld	a0, -48(s0)
	lw	a0, 0(a0)
	ld	ra, 40(sp)                      # 8-byte Folded Reload
	ld	s0, 32(sp)                      # 8-byte Folded Reload
	addi	sp, sp, 48
	ret
.Lfunc_end0:
	.size	main, .Lfunc_end0-main
                                        # -- End function
	.type	.L__const.main.arr,@object      # @__const.main.arr
	.section	.rodata,"a",@progbits
	.p2align	2, 0x0
.L__const.main.arr:
	.word	1                               # 0x1
	.word	2                               # 0x2
	.word	3                               # 0x3
	.word	4                               # 0x4
	.word	5                               # 0x5
	.size	.L__const.main.arr, 20

	.ident	"Homebrew clang version 21.1.8"
	.section	".note.GNU-stack","",@progbits
	.addrsig
