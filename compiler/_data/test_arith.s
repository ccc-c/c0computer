	.attribute	4, 16
	.attribute	5, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_zicsr2p0_zifencei2p0_zmmul1p0_zaamo1p0_zalrsc1p0"
	.file	"test_arith.c"
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
	li	a0, 10
	sw	a0, -24(s0)
	li	a0, 5
	sw	a0, -28(s0)
	lw	a0, -24(s0)
	lw	a1, -28(s0)
	addw	a0, a0, a1
	sw	a0, -32(s0)
	lw	a0, -32(s0)
	slliw	a0, a0, 1
	sw	a0, -36(s0)
	lw	a0, -36(s0)
	lui	a1, 349525
	addi	a1, a1, 1366
	mul	a0, a0, a1
	srli	a1, a0, 63
	srli	a0, a0, 32
	addw	a0, a0, a1
	sw	a0, -40(s0)
	lw	a0, -40(s0)
	addiw	a0, a0, 20
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
