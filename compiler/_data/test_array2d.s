	.attribute	4, 16
	.attribute	5, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_zicsr2p0_zifencei2p0_zmmul1p0_zaamo1p0_zalrsc1p0"
	.file	"test_array2d.c"
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
	li	a0, 1
	sw	a0, -56(s0)
	li	a0, 2
	sw	a0, -52(s0)
	li	a0, 3
	sw	a0, -48(s0)
	li	a0, 4
	sw	a0, -44(s0)
	li	a0, 5
	sw	a0, -40(s0)
	li	a0, 6
	sw	a0, -36(s0)
	li	a0, 7
	sw	a0, -32(s0)
	li	a0, 8
	sw	a0, -28(s0)
	li	a0, 9
	sw	a0, -24(s0)
	lw	a0, -32(s0)
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
