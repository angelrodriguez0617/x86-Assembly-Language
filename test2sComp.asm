; test 2sComp subroutine
.ORIG X3000
BR Start
2sComp  .fill x4000
number1 .fill #12
number2 .fill #10

Start 
    LD R1, number1
    LD R0, number2
    LD R2, 2sComp 
    JSRR R2
    ADD R3, R1, R0
    HALT
    .END