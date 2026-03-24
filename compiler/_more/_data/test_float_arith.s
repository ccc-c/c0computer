	.attribute	4, 16
	.attribute	5, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_zicsr2p0_zifencei2p0_zmmul1p0_zaamo1p0_zalrsc1p0"
	.file	"test_float_arith.c"
	.section	.rodata.cst4,"aM",@progbits,4
	.p2align	2, 0x0                          # -- Begin function main
.LCPI0_0:
	.word	0x409ccccd                      # float 4.9000001
.LCPI0_1:
	.word	0x40a33333                      # float 5.0999999
.LCPI0_2:
	.word	0x3ff33333                      # float 1.89999998
.LCPI0_3:
	.word	0x40066666                      # float 2.0999999
.LCPI0_4:
	.word	0x40a66666                      # float 5.19999981
.LCPI0_5:
	.word	0x40a9999a                      # float 5.30000019
.LCPI0_6:
	.word	0x40133333                      # float 2.29999995
.LCPI0_7:
	.word	0x4019999a                      # float 2.4000001
	.text
	.globl	main
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
	lui	a1, 263680
	sw	a1, -24(s0)
	lui	a1, 261120
	sw	a1, -28(s0)
	flw	fa5, -24(s0)
	flw	fa4, -28(s0)
	fadd.s	fa5, fa5, fa4
	fsw	fa5, -32(s0)
	flw	fa5, -24(s0)
	flw	fa4, -28(s0)
	fsub.s	fa5, fa5, fa4
	fsw	fa5, -36(s0)
	flw	fa5, -24(s0)
	flw	fa4, -28(s0)
	fmul.s	fa5, fa5, fa4
	fsw	fa5, -40(s0)
	flw	fa5, -24(s0)
	flw	fa4, -28(s0)
	fdiv.s	fa5, fa5, fa4
	fsw	fa5, -44(s0)
	sw	a0, -48(s0)
	flw	fa4, -32(s0)
	lui	a0, %hi(.LCPI0_0)
	flw	fa5, %lo(.LCPI0_0)(a0)
	flt.s	a0, fa5, fa4
	beqz	a0, .LBB0_3
	j	.LBB0_1
.LBB0_1:
	flw	fa5, -32(s0)
	lui	a0, %hi(.LCPI0_1)
	flw	fa4, %lo(.LCPI0_1)(a0)
	flt.s	a0, fa5, fa4
	beqz	a0, .LBB0_3
	j	.LBB0_2
.LBB0_2:
	lw	a0, -48(s0)
	addiw	a0, a0, 1
	sw	a0, -48(s0)
	j	.LBB0_3
.LBB0_3:
	flw	fa4, -36(s0)
	lui	a0, %hi(.LCPI0_2)
	flw	fa5, %lo(.LCPI0_2)(a0)
	flt.s	a0, fa5, fa4
	beqz	a0, .LBB0_6
	j	.LBB0_4
.LBB0_4:
	flw	fa5, -36(s0)
	lui	a0, %hi(.LCPI0_3)
	flw	fa4, %lo(.LCPI0_3)(a0)
	flt.s	a0, fa5, fa4
	beqz	a0, .LBB0_6
	j	.LBB0_5
.LBB0_5:
	lw	a0, -48(s0)
	addiw	a0, a0, 1
	sw	a0, -48(s0)
	j	.LBB0_6
.LBB0_6:
	flw	fa4, -40(s0)
	lui	a0, %hi(.LCPI0_4)
	flw	fa5, %lo(.LCPI0_4)(a0)
	flt.s	a0, fa5, fa4
	beqz	a0, .LBB0_9
	j	.LBB0_7
.LBB0_7:
	flw	fa5, -40(s0)
	lui	a0, %hi(.LCPI0_5)
	flw	fa4, %lo(.LCPI0_5)(a0)
	flt.s	a0, fa5, fa4
	beqz	a0, .LBB0_9
	j	.LBB0_8
.LBB0_8:
	lw	a0, -48(s0)
	addiw	a0, a0, 1
	sw	a0, -48(s0)
	j	.LBB0_9
.LBB0_9:
	flw	fa4, -44(s0)
	lui	a0, %hi(.LCPI0_6)
	flw	fa5, %lo(.LCPI0_6)(a0)
	flt.s	a0, fa5, fa4
	beqz	a0, .LBB0_12
	j	.LBB0_10
.LBB0_10:
	flw	fa5, -44(s0)
	lui	a0, %hi(.LCPI0_7)
	flw	fa4, %lo(.LCPI0_7)(a0)
	flt.s	a0, fa5, fa4
	beqz	a0, .LBB0_12
	j	.LBB0_11
.LBB0_11:
	lw	a0, -48(s0)
	addiw	a0, a0, 1
	sw	a0, -48(s0)
	j	.LBB0_12
.LBB0_12:
	lw	a0, -48(s0)
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
