main:
        LDI   R1,5
        PUSH  R1
        CALL  factorial
        POP   R2
        JMP   exit

factorial:
        PUSH  R14
        POP   R1
        PUSH  R1

        CMP   R1,R0
        JNE   recurse

        LDI   R1,1
        PUSH  R1
        POP   R14
        RET

recurse:
        ADDI  R2,R1,-1
        PUSH  R2
        CALL  factorial
        POP   R3

        MUL   R4,R1,R3
        PUSH  R4

        POP   R14
        RET

exit: