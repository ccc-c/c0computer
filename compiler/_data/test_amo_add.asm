# Test atomic add operation
# Expected: a0 = 15 (initial 10 + 5)
.text
.globl main
main:
    # Initialize memory at address 0x100 with value 10
    addi t0, zero, 10
    sd t0, 0x100(zero)
    
    # Load value from memory using amoadd.d
    # This atomically adds t1 (5) to the value at address in t2 (0x100)
    # and returns the old value (10) in t3
    addi t1, zero, 5
    addi t2, zero, 0x100
    amoadd.d t3, t1, (t2)
    
    # Load the new value from the same address
    ld t4, 0(t2)
    
    # Move result to a0 (should be 15)
    mv a0, t4
    
    # Return
    ret
