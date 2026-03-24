	.attribute	4, 16
	.attribute	5, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_zicsr2p0_zifencei2p0_zmmul1p0_zaamo1p0_zalrsc1p0"
	.file	"test_compare.c"
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
	li	a1, 10
	sw	a1, -24(s0)
	li	a2, 5
	sw	a2, -28(s0)
	sw	a1, -32(s0)
	sw	a0, -36(s0)
	lw	a1, -24(s0)
	lw	a0, -28(s0)
	bge	a0, a1, .LBB0_2
	j	.LBB0_1
.LBB0_1:
	lw	a0, -36(s0)
	addiw	a0, a0, 1
	sw	a0, -36(s0)
	j	.LBB0_2
.LBB0_2:
	lw	a0, -24(s0)
	lw	a1, -32(s0)
	blt	a0, a1, .LBB0_4
	j	.LBB0_3
.LBB0_3:
	lw	a0, -36(s0)
	addiw	a0, a0, 1
	sw	a0, -36(s0)
	j	.LBB0_4
.LBB0_4:
	lw	a0, -24(s0)
	lw	a1, -32(s0)
	bne	a0, a1, .LBB0_6
	j	.LBB0_5
.LBB0_5:
	lw	a0, -36(s0)
	addiw	a0, a0, 1
	sw	a0, -36(s0)
	j	.LBB0_6
.LBB0_6:
	lw	a0, -24(s0)
	lw	a1, -28(s0)
	beq	a0, a1, .LBB0_8
	j	.LBB0_7
.LBB0_7:
	lw	a0, -36(s0)
	addiw	a0, a0, 1
	sw	a0, -36(s0)
	j	.LBB0_8
.LBB0_8:
	lw	a0, -28(s0)
	lw	a1, -24(s0)
	bge	a0, a1, .LBB0_10
	j	.LBB0_9
.LBB0_9:
	lw	a0, -36(s0)
	addiw	a0, a0, 1
	sw	a0, -36(s0)
	j	.LBB0_10
.LBB0_10:
	lw	a1, -32(s0)
	lw	a0, -24(s0)
	blt	a0, a1, .LBB0_12
	j	.LBB0_11
.LBB0_11:
	lw	a0, -36(s0)
	addiw	a0, a0, 1
	sw	a0, -36(s0)
	j	.LBB0_12
.LBB0_12:
	lw	a0, -36(s0)
	ld	ra, 40(sp)                      # 8-byte Folded Reload
	ld	s0, 32(sp)                      # 8-byte Folded Reload
	addi	sp, sp, 48
	ret
.Lfunc_end0:
	.size	main, .Lfunc_end0-main
                                        # -- End function
	.ident	"Homebrew clang version 21.1.8"
	.section	".note.GNU-stack","",@progbits
	.addrsig
