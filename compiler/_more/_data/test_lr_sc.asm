# Test LR.W and SC.W (load reserved / store conditional)
# This tests a simple compare-and-swap operation
# Expected: a0 = 0 (success), memory = 20
.text
.globl main
main:
    # Initialize memory at address 0x100 with value 10
    addi t0, zero, 10
    sw t0, 0x100(zero)
    
    # Load reserved from address 0x100
    addi t1, zero, 0x100
    lr.w t2, (t1)
    
    # Try to store conditional with new value 20
    # This should succeed (since no other CPU modified the memory)
    addi t3, zero, 20
    sc.w t4, t3, (t1)
    
    # Load the value from memory
    lw t5, 0x100(zero)
    
    # Return sc result (0 = success)
    mv a0, t4
    
    # Return
    ret
