	.attribute	4, 16
	.attribute	5, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_zicsr2p0_zifencei2p0_zmmul1p0_zaamo1p0_zalrsc1p0"
	.file	"test_struct.c"
	.text
	.globl	test_struct_basic               # -- Begin function test_struct_basic
	.p2align	2
	.type	test_struct_basic,@function
test_struct_basic:                      # @test_struct_basic
# %bb.0:
	addi	sp, sp, -32
	sd	ra, 24(sp)                      # 8-byte Folded Spill
	sd	s0, 16(sp)                      # 8-byte Folded Spill
	addi	s0, sp, 32
	li	a0, 10
	sw	a0, -24(s0)
	li	a0, 20
	sw	a0, -20(s0)
	lw	a0, -24(s0)
	lw	a1, -20(s0)
	addw	a0, a0, a1
	ld	ra, 24(sp)                      # 8-byte Folded Reload
	ld	s0, 16(sp)                      # 8-byte Folded Reload
	addi	sp, sp, 32
	ret
.Lfunc_end0:
	.size	test_struct_basic, .Lfunc_end0-test_struct_basic
                                        # -- End function
	.globl	test_struct_nested              # -- Begin function test_struct_nested
	.p2align	2
	.type	test_struct_nested,@function
test_struct_nested:                     # @test_struct_nested
# %bb.0:
	addi	sp, sp, -32
	sd	ra, 24(sp)                      # 8-byte Folded Spill
	sd	s0, 16(sp)                      # 8-byte Folded Spill
	addi	s0, sp, 32
	li	a0, 1
	sw	a0, -32(s0)
	li	a0, 2
	sw	a0, -28(s0)
	li	a0, 100
	sw	a0, -24(s0)
	li	a0, 200
	sw	a0, -20(s0)
	lw	a0, -32(s0)
	lw	a1, -20(s0)
	addw	a0, a0, a1
	ld	ra, 24(sp)                      # 8-byte Folded Reload
	ld	s0, 16(sp)                      # 8-byte Folded Reload
	addi	sp, sp, 32
	ret
.Lfunc_end1:
	.size	test_struct_nested, .Lfunc_end1-test_struct_nested
                                        # -- End function
	.globl	test_struct_array               # -- Begin function test_struct_array
	.p2align	2
	.type	test_struct_array,@function
test_struct_array:                      # @test_struct_array
# %bb.0:
	addi	sp, sp, -48
	sd	ra, 40(sp)                      # 8-byte Folded Spill
	sd	s0, 32(sp)                      # 8-byte Folded Spill
	addi	s0, sp, 48
	li	a0, 1
	sw	a0, -40(s0)
	li	a0, 2
	sw	a0, -28(s0)
	li	a0, 3
	sw	a0, -24(s0)
	lw	a0, -40(s0)
	lw	a1, -28(s0)
	addw	a0, a0, a1
	lw	a1, -24(s0)
	addw	a0, a0, a1
	ld	ra, 40(sp)                      # 8-byte Folded Reload
	ld	s0, 32(sp)                      # 8-byte Folded Reload
	addi	sp, sp, 48
	ret
.Lfunc_end2:
	.size	test_struct_array, .Lfunc_end2-test_struct_array
                                        # -- End function
	.globl	test_ptr_to_struct              # -- Begin function test_ptr_to_struct
	.p2align	2
	.type	test_ptr_to_struct,@function
test_ptr_to_struct:                     # @test_ptr_to_struct
# %bb.0:
	addi	sp, sp, -32
	sd	ra, 24(sp)                      # 8-byte Folded Spill
	sd	s0, 16(sp)                      # 8-byte Folded Spill
	addi	s0, sp, 32
	addi	a0, s0, -24
	sd	a0, -32(s0)
	ld	a1, -32(s0)
	li	a0, 50
	sw	a0, 0(a1)
	ld	a1, -32(s0)
	li	a0, 60
	sw	a0, 4(a1)
	ld	a1, -32(s0)
	lw	a0, 0(a1)
	lw	a1, 4(a1)
	addw	a0, a0, a1
	ld	ra, 24(sp)                      # 8-byte Folded Reload
	ld	s0, 16(sp)                      # 8-byte Folded Reload
	addi	sp, sp, 32
	ret
.Lfunc_end3:
	.size	test_ptr_to_struct, .Lfunc_end3-test_ptr_to_struct
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
	sw	a0, -24(s0)
	call	test_struct_basic
	mv	a1, a0
	lw	a0, -24(s0)
	addw	a0, a0, a1
	sw	a0, -24(s0)
	call	test_struct_nested
	mv	a1, a0
	lw	a0, -24(s0)
	addw	a0, a0, a1
	sw	a0, -24(s0)
	call	test_struct_array
	mv	a1, a0
	lw	a0, -24(s0)
	addw	a0, a0, a1
	sw	a0, -24(s0)
	call	test_ptr_to_struct
	mv	a1, a0
	lw	a0, -24(s0)
	addw	a0, a0, a1
	sw	a0, -24(s0)
	lw	a0, -24(s0)
	ld	ra, 24(sp)                      # 8-byte Folded Reload
	ld	s0, 16(sp)                      # 8-byte Folded Reload
	addi	sp, sp, 32
	ret
.Lfunc_end4:
	.size	main, .Lfunc_end4-main
                                        # -- End function
	.ident	"Homebrew clang version 21.1.8"
	.section	".note.GNU-stack","",@progbits
	.addrsig
	.addrsig_sym test_struct_basic
	.addrsig_sym test_struct_nested
	.addrsig_sym test_struct_array
	.addrsig_sym test_ptr_to_struct
