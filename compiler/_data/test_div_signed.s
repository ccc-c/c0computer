	.attribute	4, 16
	.attribute	5, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_zicsr2p0_zifencei2p0_zmmul1p0_zaamo1p0_zalrsc1p0"
	.file	"test_div_signed.c"
	.text
	.globl	main                            # -- Begin function main
	.p2align	2
	.type	main,@function
main:                                   # @main
# %bb.0:
	addi	sp, sp, -64
	sd	ra, 56(sp)                      # 8-byte Folded Spill
	sd	s0, 48(sp)                      # 8-byte Folded Spill
	addi	s0, sp, 64
	li	a0, 0
	sw	a0, -20(s0)
	li	a0, 10
	sw	a0, -24(s0)
	li	a1, -3
	sw	a1, -28(s0)
	li	a0, 3
	sw	a0, -32(s0)
	sw	a1, -36(s0)
	sw	a1, -40(s0)
	sw	a0, -44(s0)
	li	a1, 1
	sw	a1, -48(s0)
	li	a0, -1
	sw	a0, -52(s0)
	sw	a1, -56(s0)
	sw	a0, -60(s0)
	lw	a0, -32(s0)
	lw	a1, -36(s0)
	addw	a0, a0, a1
	lw	a1, -40(s0)
	addw	a0, a0, a1
	lw	a1, -44(s0)
	addw	a0, a0, a1
	lw	a1, -48(s0)
	addw	a0, a0, a1
	lw	a1, -52(s0)
	addw	a0, a0, a1
	lw	a1, -56(s0)
	addw	a0, a0, a1
	lw	a1, -60(s0)
	addw	a0, a0, a1
	ld	ra, 56(sp)                      # 8-byte Folded Reload
	ld	s0, 48(sp)                      # 8-byte Folded Reload
	addi	sp, sp, 64
	ret
.Lfunc_end0:
	.size	main, .Lfunc_end0-main
                                        # -- End function
	.ident	"Homebrew clang version 21.1.8"
	.section	".note.GNU-stack","",@progbits
	.addrsig
