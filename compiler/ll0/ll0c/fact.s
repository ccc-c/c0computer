	.attribute	4, 16
	.attribute	5, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_zicsr2p0_zifencei2p0_zmmul1p0_zaamo1p0_zalrsc1p0"
	.file	"fact.c"
	.text
	.globl	factorial                       # -- Begin function factorial
	.p2align	2
	.type	factorial,@function
factorial:                              # @factorial
.Lfunc_begin0:
	.file	0 "/Users/Shared/ccc/c0computer/compiler/ll0/ll0c" "fact.c" md5 0xd4da699c43546eed15c07109094650e0
	.loc	0 1 0                           # fact.c:1:0
	.cfi_sections .debug_frame
	.cfi_startproc
# %bb.0:
	addi	sp, sp, -32
	.cfi_def_cfa_offset 32
	sd	ra, 24(sp)                      # 8-byte Folded Spill
	sd	s0, 16(sp)                      # 8-byte Folded Spill
	.cfi_offset ra, -8
	.cfi_offset s0, -16
	addi	s0, sp, 32
	.cfi_def_cfa s0, 0
                                        # kill: def $x11 killed $x10
	sw	a0, -24(s0)
.Ltmp0:
	.loc	0 2 9 prologue_end              # fact.c:2:9
	lw	a0, -24(s0)
	.loc	0 2 10 is_stmt 0                # fact.c:2:10
	bnez	a0, .LBB0_2
	j	.LBB0_1
.LBB0_1:
	.loc	0 0 10                          # fact.c:0:10
	li	a0, 1
	.loc	0 2 15                          # fact.c:2:15
	sw	a0, -20(s0)
	j	.LBB0_3
.Ltmp1:
.LBB0_2:
	.loc	0 3 12 is_stmt 1                # fact.c:3:12
	lw	a0, -24(s0)
	sd	a0, -32(s0)                     # 8-byte Folded Spill
	.loc	0 3 25 is_stmt 0                # fact.c:3:25
	addiw	a0, a0, -1
	.loc	0 3 14                          # fact.c:3:14
	call	factorial
	mv	a1, a0
	ld	a0, -32(s0)                     # 8-byte Folded Reload
	.loc	0 3 13                          # fact.c:3:13
	mulw	a0, a0, a1
	.loc	0 3 5                           # fact.c:3:5
	sw	a0, -20(s0)
	j	.LBB0_3
.LBB0_3:
	.loc	0 4 1 is_stmt 1                 # fact.c:4:1
	lw	a0, -20(s0)
	.cfi_def_cfa sp, 32
	.loc	0 4 1 epilogue_begin is_stmt 0  # fact.c:4:1
	ld	ra, 24(sp)                      # 8-byte Folded Reload
	ld	s0, 16(sp)                      # 8-byte Folded Reload
	.cfi_restore ra
	.cfi_restore s0
	addi	sp, sp, 32
	.cfi_def_cfa_offset 0
	ret
.Ltmp2:
.Lfunc_end0:
	.size	factorial, .Lfunc_end0-factorial
	.cfi_endproc
                                        # -- End function
	.globl	main                            # -- Begin function main
	.p2align	2
	.type	main,@function
main:                                   # @main
.Lfunc_begin1:
	.loc	0 6 0 is_stmt 1                 # fact.c:6:0
	.cfi_startproc
# %bb.0:
	addi	sp, sp, -32
	.cfi_def_cfa_offset 32
	sd	ra, 24(sp)                      # 8-byte Folded Spill
	sd	s0, 16(sp)                      # 8-byte Folded Spill
	.cfi_offset ra, -8
	.cfi_offset s0, -16
	addi	s0, sp, 32
	.cfi_def_cfa s0, 0
	li	a0, 0
	sw	a0, -20(s0)
	li	a0, 5
.Ltmp3:
	.loc	0 7 12 prologue_end             # fact.c:7:12
	call	factorial
	.cfi_def_cfa sp, 32
	.loc	0 7 5 epilogue_begin is_stmt 0  # fact.c:7:5
	ld	ra, 24(sp)                      # 8-byte Folded Reload
	ld	s0, 16(sp)                      # 8-byte Folded Reload
	.cfi_restore ra
	.cfi_restore s0
	addi	sp, sp, 32
	.cfi_def_cfa_offset 0
	ret
.Ltmp4:
.Lfunc_end1:
	.size	main, .Lfunc_end1-main
	.cfi_endproc
                                        # -- End function
	.section	.debug_abbrev,"",@progbits
	.byte	1                               # Abbreviation Code
	.byte	17                              # DW_TAG_compile_unit
	.byte	1                               # DW_CHILDREN_yes
	.byte	37                              # DW_AT_producer
	.byte	37                              # DW_FORM_strx1
	.byte	19                              # DW_AT_language
	.byte	5                               # DW_FORM_data2
	.byte	3                               # DW_AT_name
	.byte	37                              # DW_FORM_strx1
	.byte	114                             # DW_AT_str_offsets_base
	.byte	23                              # DW_FORM_sec_offset
	.byte	16                              # DW_AT_stmt_list
	.byte	23                              # DW_FORM_sec_offset
	.byte	27                              # DW_AT_comp_dir
	.byte	37                              # DW_FORM_strx1
	.byte	17                              # DW_AT_low_pc
	.byte	27                              # DW_FORM_addrx
	.byte	18                              # DW_AT_high_pc
	.byte	6                               # DW_FORM_data4
	.byte	115                             # DW_AT_addr_base
	.byte	23                              # DW_FORM_sec_offset
	.byte	0                               # EOM(1)
	.byte	0                               # EOM(2)
	.byte	2                               # Abbreviation Code
	.byte	46                              # DW_TAG_subprogram
	.byte	1                               # DW_CHILDREN_yes
	.byte	17                              # DW_AT_low_pc
	.byte	27                              # DW_FORM_addrx
	.byte	18                              # DW_AT_high_pc
	.byte	6                               # DW_FORM_data4
	.byte	64                              # DW_AT_frame_base
	.byte	24                              # DW_FORM_exprloc
	.byte	3                               # DW_AT_name
	.byte	37                              # DW_FORM_strx1
	.byte	58                              # DW_AT_decl_file
	.byte	11                              # DW_FORM_data1
	.byte	59                              # DW_AT_decl_line
	.byte	11                              # DW_FORM_data1
	.byte	39                              # DW_AT_prototyped
	.byte	25                              # DW_FORM_flag_present
	.byte	73                              # DW_AT_type
	.byte	19                              # DW_FORM_ref4
	.byte	63                              # DW_AT_external
	.byte	25                              # DW_FORM_flag_present
	.byte	0                               # EOM(1)
	.byte	0                               # EOM(2)
	.byte	3                               # Abbreviation Code
	.byte	5                               # DW_TAG_formal_parameter
	.byte	0                               # DW_CHILDREN_no
	.byte	2                               # DW_AT_location
	.byte	24                              # DW_FORM_exprloc
	.byte	3                               # DW_AT_name
	.byte	37                              # DW_FORM_strx1
	.byte	58                              # DW_AT_decl_file
	.byte	11                              # DW_FORM_data1
	.byte	59                              # DW_AT_decl_line
	.byte	11                              # DW_FORM_data1
	.byte	73                              # DW_AT_type
	.byte	19                              # DW_FORM_ref4
	.byte	0                               # EOM(1)
	.byte	0                               # EOM(2)
	.byte	4                               # Abbreviation Code
	.byte	46                              # DW_TAG_subprogram
	.byte	0                               # DW_CHILDREN_no
	.byte	17                              # DW_AT_low_pc
	.byte	27                              # DW_FORM_addrx
	.byte	18                              # DW_AT_high_pc
	.byte	6                               # DW_FORM_data4
	.byte	64                              # DW_AT_frame_base
	.byte	24                              # DW_FORM_exprloc
	.byte	3                               # DW_AT_name
	.byte	37                              # DW_FORM_strx1
	.byte	58                              # DW_AT_decl_file
	.byte	11                              # DW_FORM_data1
	.byte	59                              # DW_AT_decl_line
	.byte	11                              # DW_FORM_data1
	.byte	73                              # DW_AT_type
	.byte	19                              # DW_FORM_ref4
	.byte	63                              # DW_AT_external
	.byte	25                              # DW_FORM_flag_present
	.byte	0                               # EOM(1)
	.byte	0                               # EOM(2)
	.byte	5                               # Abbreviation Code
	.byte	36                              # DW_TAG_base_type
	.byte	0                               # DW_CHILDREN_no
	.byte	3                               # DW_AT_name
	.byte	37                              # DW_FORM_strx1
	.byte	62                              # DW_AT_encoding
	.byte	11                              # DW_FORM_data1
	.byte	11                              # DW_AT_byte_size
	.byte	11                              # DW_FORM_data1
	.byte	0                               # EOM(1)
	.byte	0                               # EOM(2)
	.byte	0                               # EOM(3)
	.section	.debug_info,"",@progbits
.Lcu_begin0:
	.word	.Ldebug_info_end0-.Ldebug_info_start0 # Length of Unit
.Ldebug_info_start0:
	.half	5                               # DWARF version number
	.byte	1                               # DWARF Unit Type
	.byte	8                               # Address Size (in bytes)
	.word	.debug_abbrev                   # Offset Into Abbrev. Section
	.byte	1                               # Abbrev [1] 0xc:0x46 DW_TAG_compile_unit
	.byte	0                               # DW_AT_producer
	.half	29                              # DW_AT_language
	.byte	1                               # DW_AT_name
	.word	.Lstr_offsets_base0             # DW_AT_str_offsets_base
	.word	.Lline_table_start0             # DW_AT_stmt_list
	.byte	2                               # DW_AT_comp_dir
	.byte	0                               # DW_AT_low_pc
	.word	.Lfunc_end1-.Lfunc_begin0       # DW_AT_high_pc
	.word	.Laddr_table_base0              # DW_AT_addr_base
	.byte	2                               # Abbrev [2] 0x23:0x1b DW_TAG_subprogram
	.byte	0                               # DW_AT_low_pc
	.word	.Lfunc_end0-.Lfunc_begin0       # DW_AT_high_pc
	.byte	1                               # DW_AT_frame_base
	.byte	88
	.byte	3                               # DW_AT_name
	.byte	0                               # DW_AT_decl_file
	.byte	1                               # DW_AT_decl_line
                                        # DW_AT_prototyped
	.word	77                              # DW_AT_type
                                        # DW_AT_external
	.byte	3                               # Abbrev [3] 0x32:0xb DW_TAG_formal_parameter
	.byte	2                               # DW_AT_location
	.byte	145
	.byte	104
	.byte	6                               # DW_AT_name
	.byte	0                               # DW_AT_decl_file
	.byte	1                               # DW_AT_decl_line
	.word	77                              # DW_AT_type
	.byte	0                               # End Of Children Mark
	.byte	4                               # Abbrev [4] 0x3e:0xf DW_TAG_subprogram
	.byte	1                               # DW_AT_low_pc
	.word	.Lfunc_end1-.Lfunc_begin1       # DW_AT_high_pc
	.byte	1                               # DW_AT_frame_base
	.byte	88
	.byte	5                               # DW_AT_name
	.byte	0                               # DW_AT_decl_file
	.byte	6                               # DW_AT_decl_line
	.word	77                              # DW_AT_type
                                        # DW_AT_external
	.byte	5                               # Abbrev [5] 0x4d:0x4 DW_TAG_base_type
	.byte	4                               # DW_AT_name
	.byte	5                               # DW_AT_encoding
	.byte	4                               # DW_AT_byte_size
	.byte	0                               # End Of Children Mark
.Ldebug_info_end0:
	.section	.debug_str_offsets,"",@progbits
	.word	32                              # Length of String Offsets Set
	.half	5
	.half	0
.Lstr_offsets_base0:
	.section	.debug_str,"MS",@progbits,1
.Linfo_string0:
	.asciz	"Homebrew clang version 21.1.8" # string offset=0
.Linfo_string1:
	.asciz	"fact.c"                        # string offset=30
.Linfo_string2:
	.asciz	"/Users/Shared/ccc/c0computer/compiler/ll0/ll0c" # string offset=37
.Linfo_string3:
	.asciz	"factorial"                     # string offset=84
.Linfo_string4:
	.asciz	"int"                           # string offset=94
.Linfo_string5:
	.asciz	"main"                          # string offset=98
.Linfo_string6:
	.asciz	"n"                             # string offset=103
	.section	.debug_str_offsets,"",@progbits
	.word	.Linfo_string0
	.word	.Linfo_string1
	.word	.Linfo_string2
	.word	.Linfo_string3
	.word	.Linfo_string4
	.word	.Linfo_string5
	.word	.Linfo_string6
	.section	.debug_addr,"",@progbits
	.word	.Ldebug_addr_end0-.Ldebug_addr_start0 # Length of contribution
.Ldebug_addr_start0:
	.half	5                               # DWARF version number
	.byte	8                               # Address size
	.byte	0                               # Segment selector size
.Laddr_table_base0:
	.quad	.Lfunc_begin0
	.quad	.Lfunc_begin1
.Ldebug_addr_end0:
	.ident	"Homebrew clang version 21.1.8"
	.section	".note.GNU-stack","",@progbits
	.addrsig
	.addrsig_sym factorial
	.section	.debug_line,"",@progbits
.Lline_table_start0:
