	.attribute	4, 16
	.attribute	5, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_zicsr2p0_zifencei2p0_zmmul1p0_zaamo1p0_zalrsc1p0"
	.file	"test_union.c"
	.text
	.globl	test_union_basic                # -- Begin function test_union_basic
	.p2align	2
	.type	test_union_basic,@function
test_union_basic:                       # @test_union_basic
# %bb.0:
	addi	sp, sp, -32
	sd	ra, 24(sp)                      # 8-byte Folded Spill
	sd	s0, 16(sp)                      # 8-byte Folded Spill
	addi	s0, sp, 32
	lui	a0, 267300
	addi	a0, a0, 836
	sw	a0, -20(s0)
	lbu	a0, -20(s0)
	ld	ra, 24(sp)                      # 8-byte Folded Reload
	ld	s0, 16(sp)                      # 8-byte Folded Reload
	addi	sp, sp, 32
	ret
.Lfunc_end0:
	.size	test_union_basic, .Lfunc_end0-test_union_basic
                                        # -- End function
	.globl	test_union_cast                 # -- Begin function test_union_cast
	.p2align	2
	.type	test_union_cast,@function
test_union_cast:                        # @test_union_cast
# %bb.0:
	addi	sp, sp, -32
	sd	ra, 24(sp)                      # 8-byte Folded Spill
	sd	s0, 16(sp)                      # 8-byte Folded Spill
	addi	s0, sp, 32
	li	a0, 65
	sw	a0, -20(s0)
	lw	a0, -20(s0)
	ld	ra, 24(sp)                      # 8-byte Folded Reload
	ld	s0, 16(sp)                      # 8-byte Folded Reload
	addi	sp, sp, 32
	ret
.Lfunc_end1:
	.size	test_union_cast, .Lfunc_end1-test_union_cast
                                        # -- End function
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
	call	test_union_basic
	sd	a0, -32(s0)                     # 8-byte Folded Spill
	call	test_union_cast
	mv	a1, a0
	ld	a0, -32(s0)                     # 8-byte Folded Reload
	addw	a0, a0, a1
	ld	ra, 24(sp)                      # 8-byte Folded Reload
	ld	s0, 16(sp)                      # 8-byte Folded Reload
	addi	sp, sp, 32
	ret
.Lfunc_end2:
	.size	main, .Lfunc_end2-main
                                        # -- End function
	.ident	"Homebrew clang version 21.1.8"
	.section	".note.GNU-stack","",@progbits
	.addrsig
	.addrsig_sym test_union_basic
	.addrsig_sym test_union_cast
