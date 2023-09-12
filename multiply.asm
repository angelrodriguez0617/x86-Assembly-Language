.ORIG X4000
MULTIPLY    ; Multiply R2 by R1 and the result will be in R3
    ADD R3, R3, R2
	ADD R1, R1, #-1
	BRP MULTIPLY	
	AND R1, R1, #0 ; Reset register 1 to 0
    RET
    .END