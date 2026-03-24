# Test atomic swap operation
# Expected: a0 = 10 (old value), memory = 20 (new value)
.text
.globl main
main:
    # Initialize memory at address 0x100 with value 10
    addi t0, zero, 10
    sd t0, 0x100(zero)
    
    # Atomic swap: exchange t1 (20) with memory at address in t2
    # Returns old value (10) in t3
    addi t1, zero, 20
    addi t2, zero, 0x100
    amoswap.d t3, t1, (t2)
    
    # Load the new value from memory
    ld t4, 0(t2)
    
    # Return old value in a0
    mv a0, t3
    
    # Return
    ret
