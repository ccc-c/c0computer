	.attribute	4, 16
	.attribute	5, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_zicsr2p0_zifencei2p0_zmmul1p0_zaamo1p0_zalrsc1p0"
	.file	"test_double_arith.c"
	.section	.rodata.cst8,"aM",@progbits,8
	.p2align	3, 0x0                          # -- Begin function main
.LCPI0_0:
	.quad	0x4029cccccccccccd              # double 12.9
.LCPI0_1:
	.quad	0x402a333333333333              # double 13.1
.LCPI0_2:
	.quad	0x401f99999999999a              # double 7.9000000000000004
.LCPI0_3:
	.quad	0x4020333333333333              # double 8.0999999999999996
.LCPI0_4:
	.quad	0x403a333333333333              # double 26.199999999999999
.LCPI0_5:
	.quad	0x403a4ccccccccccd              # double 26.300000000000001
.LCPI0_6:
	.quad	0x4010666666666666              # double 4.0999999999999996
.LCPI0_7:
	.quad	0x4011333333333333              # double 4.2999999999999998
	.text
	.globl	main
	.p2align	2
	.type	main,@function
main:                                   # @main
# %bb.0:
	addi	sp, sp, -80
	sd	ra, 72(sp)                      # 8-byte Folded Spill
	sd	s0, 64(sp)                      # 8-byte Folded Spill
	addi	s0, sp, 80
	li	a0, 0
	sw	a0, -20(s0)
	lui	a1, 16421
	slli	a1, a1, 36
	sd	a1, -32(s0)
	lui	a1, 4097
	slli	a1, a1, 38
	sd	a1, -40(s0)
	fld	fa5, -32(s0)
	fld	fa4, -40(s0)
	fadd.d	fa5, fa5, fa4
	fsd	fa5, -48(s0)
	fld	fa5, -32(s0)
	fld	fa4, -40(s0)
	fsub.d	fa5, fa5, fa4
	fsd	fa5, -56(s0)
	fld	fa5, -32(s0)
	fld	fa4, -40(s0)
	fmul.d	fa5, fa5, fa4
	fsd	fa5, -64(s0)
	fld	fa5, -32(s0)
	fld	fa4, -40(s0)
	fdiv.d	fa5, fa5, fa4
	fsd	fa5, -72(s0)
	sw	a0, -76(s0)
	fld	fa4, -48(s0)
	lui	a0, %hi(.LCPI0_0)
	fld	fa5, %lo(.LCPI0_0)(a0)
	flt.d	a0, fa5, fa4
	beqz	a0, .LBB0_3
	j	.LBB0_1
.LBB0_1:
	fld	fa5, -48(s0)
	lui	a0, %hi(.LCPI0_1)
	fld	fa4, %lo(.LCPI0_1)(a0)
	flt.d	a0, fa5, fa4
	beqz	a0, .LBB0_3
	j	.LBB0_2
.LBB0_2:
	lw	a0, -76(s0)
	addiw	a0, a0, 1
	sw	a0, -76(s0)
	j	.LBB0_3
.LBB0_3:
	fld	fa4, -56(s0)
	lui	a0, %hi(.LCPI0_2)
	fld	fa5, %lo(.LCPI0_2)(a0)
	flt.d	a0, fa5, fa4
	beqz	a0, .LBB0_6
	j	.LBB0_4
.LBB0_4:
	fld	fa5, -56(s0)
	lui	a0, %hi(.LCPI0_3)
	fld	fa4, %lo(.LCPI0_3)(a0)
	flt.d	a0, fa5, fa4
	beqz	a0, .LBB0_6
	j	.LBB0_5
.LBB0_5:
	lw	a0, -76(s0)
	addiw	a0, a0, 1
	sw	a0, -76(s0)
	j	.LBB0_6
.LBB0_6:
	fld	fa4, -64(s0)
	lui	a0, %hi(.LCPI0_4)
	fld	fa5, %lo(.LCPI0_4)(a0)
	flt.d	a0, fa5, fa4
	beqz	a0, .LBB0_9
	j	.LBB0_7
.LBB0_7:
	fld	fa5, -64(s0)
	lui	a0, %hi(.LCPI0_5)
	fld	fa4, %lo(.LCPI0_5)(a0)
	flt.d	a0, fa5, fa4
	beqz	a0, .LBB0_9
	j	.LBB0_8
.LBB0_8:
	lw	a0, -76(s0)
	addiw	a0, a0, 1
	sw	a0, -76(s0)
	j	.LBB0_9
.LBB0_9:
	fld	fa4, -72(s0)
	lui	a0, %hi(.LCPI0_6)
	fld	fa5, %lo(.LCPI0_6)(a0)
	flt.d	a0, fa5, fa4
	beqz	a0, .LBB0_12
	j	.LBB0_10
.LBB0_10:
	fld	fa5, -72(s0)
	lui	a0, %hi(.LCPI0_7)
	fld	fa4, %lo(.LCPI0_7)(a0)
	flt.d	a0, fa5, fa4
	beqz	a0, .LBB0_12
	j	.LBB0_11
.LBB0_11:
	lw	a0, -76(s0)
	addiw	a0, a0, 1
	sw	a0, -76(s0)
	j	.LBB0_12
.LBB0_12:
	lw	a0, -76(s0)
	ld	ra, 72(sp)                      # 8-byte Folded Reload
	ld	s0, 64(sp)                      # 8-byte Folded Reload
	addi	sp, sp, 80
	ret
.Lfunc_end0:
	.size	main, .Lfunc_end0-main
                                        # -- End function
	.ident	"Homebrew clang version 21.1.8"
	.section	".note.GNU-stack","",@progbits
	.addrsig
