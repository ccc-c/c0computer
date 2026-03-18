	.attribute	4, 16
	.attribute	5, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_zicsr2p0_zifencei2p0_zmmul1p0_zaamo1p0_zalrsc1p0"
	.file	"test_bitwise.c"
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
	li	a1, 10
	sw	a1, -24(s0)
	li	a1, 5
	sw	a1, -28(s0)
	sw	a0, -32(s0)
	lw	a0, -32(s0)
	lw	a1, -24(s0)
	lw	a2, -28(s0)
	and	a1, a1, a2
	addw	a0, a0, a1
	sw	a0, -32(s0)
	lw	a0, -32(s0)
	lw	a1, -24(s0)
	lw	a2, -28(s0)
	or	a1, a1, a2
	addw	a0, a0, a1
	sw	a0, -32(s0)
	lw	a0, -32(s0)
	lw	a1, -24(s0)
	lw	a2, -28(s0)
	xor	a1, a1, a2
	addw	a0, a0, a1
	sw	a0, -32(s0)
	lw	a0, -32(s0)
	lw	a1, -24(s0)
	slliw	a1, a1, 1
	addw	a0, a0, a1
	sw	a0, -32(s0)
	lw	a0, -32(s0)
	lw	a1, -24(s0)
	srli	a1, a1, 1
	addw	a0, a0, a1
	sw	a0, -32(s0)
	lbu	a0, -32(s0)
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
