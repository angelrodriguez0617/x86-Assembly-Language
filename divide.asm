.ORIG X5000
DIVIDE  ; Divide R3 by 10, and store the remainder in R1 and the quotient in R3
	ADD R1, R1, #1
	ADD R3, R3, #-10
	BRZ	ZERO			  ; Should reach here when quotient is zero
	BRN LESS_THAN_ZERO ; Should reach here where quotient is negative
	BR DIVIDE			  ; should reach here when number is not zero nor negative

LESS_THAN_ZERO
	ADD R1, R1, #-1 ; R1 should be the quotient 
	ADD R3, R3, #10	; R3 should be the remainder

ZERO
	RET
    .END