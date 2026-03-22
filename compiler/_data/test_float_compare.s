	.attribute	4, 16
	.attribute	5, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_zicsr2p0_zifencei2p0_zmmul1p0_zaamo1p0_zalrsc1p0"
	.file	"test_float_compare.c"
	.text
	.globl	main                            # -- Begin function main
	.p2align	2
	.type	main,@function
main:                                   # @main
# %bb.0:
	addi	sp, sp, -32
	sd	ra, 24(sp)                      # 8-byte Folded Spill
	sd	s0, 16(sp)                      # 8-byte Folded Spill
	addi	s0, sp, 32
	li	a0, 0
	sw	a0, -20(s0)
	lui	a1, 264704
	sw	a1, -24(s0)
	lui	a1, 263168
	sw	a1, -28(s0)
	sw	a0, -32(s0)
	flw	fa4, -24(s0)
	flw	fa5, -28(s0)
	flt.s	a0, fa5, fa4
	beqz	a0, .LBB0_2
	j	.LBB0_1
.LBB0_1:
	lw	a0, -32(s0)
	addiw	a0, a0, 1
	sw	a0, -32(s0)
	j	.LBB0_2
.LBB0_2:
	flw	fa4, -24(s0)
	flw	fa5, -28(s0)
	fle.s	a0, fa5, fa4
	beqz	a0, .LBB0_4
	j	.LBB0_3
.LBB0_3:
	lw	a0, -32(s0)
	addiw	a0, a0, 1
	sw	a0, -32(s0)
	j	.LBB0_4
.LBB0_4:
	flw	fa5, -28(s0)
	flw	fa4, -24(s0)
	flt.s	a0, fa5, fa4
	beqz	a0, .LBB0_6
	j	.LBB0_5
.LBB0_5:
	lw	a0, -32(s0)
	addiw	a0, a0, 1
	sw	a0, -32(s0)
	j	.LBB0_6
.LBB0_6:
	flw	fa5, -28(s0)
	flw	fa4, -24(s0)
	fle.s	a0, fa5, fa4
	beqz	a0, .LBB0_8
	j	.LBB0_7
.LBB0_7:
	lw	a0, -32(s0)
	addiw	a0, a0, 1
	sw	a0, -32(s0)
	j	.LBB0_8
.LBB0_8:
	flw	fa5, -24(s0)
	feq.s	a0, fa5, fa5
	beqz	a0, .LBB0_10
	j	.LBB0_9
.LBB0_9:
	lw	a0, -32(s0)
	addiw	a0, a0, 1
	sw	a0, -32(s0)
	j	.LBB0_10
.LBB0_10:
	flw	fa5, -24(s0)
	flw	fa4, -28(s0)
	feq.s	a0, fa5, fa4
	bnez	a0, .LBB0_12
	j	.LBB0_11
.LBB0_11:
	lw	a0, -32(s0)
	addiw	a0, a0, 1
	sw	a0, -32(s0)
	j	.LBB0_12
.LBB0_12:
	lw	a0, -32(s0)
	ld	ra, 24(sp)                      # 8-byte Folded Reload
	ld	s0, 16(sp)                      # 8-byte Folded Reload
	addi	sp, sp, 32
	ret
.Lfunc_end0:
	.size	main, .Lfunc_end0-main
                                        # -- End function
	.ident	"Homebrew clang version 21.1.8"
	.section	".note.GNU-stack","",@progbits
	.addrsig
