.ORIG X3000
BR Start
Message		.STRINGZ	"Hello, you gorgeous world! Pick a single digit number to multiply 6 with:\n"
Message2	.STRINGZ	"\nThe product of the inputted number and 6 is "
NEWLINE		.STRINGZ	"\n"

Start
	LEA R0, Message
	PUTS
	TRAP x23 		;the trap instruction which is also known as “IN”
	ADD R2, R0, x0 	;move the user-inputted integer to register 2
	ADD R2, R2, #-16 ; subtract 48 from received int to convert from ASCII
	ADD R2, R2, #-16
	ADD R2, R2, #-16
	LD R1, SIX

MULTIPLY
	ADD R3, R3, R2
	ADD R1, R1, #-1
	BRP MULTIPLY	
	AND R1, R1, #0 ; Reset register 1 to 0


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
	LD R4, ASCII      ; load the ascii offset into R4
	LEA R0, Message2
	PUTS
	ADD R1, R1, R4		; load ACII representation of quotient into R1 to display later
	AND R0, R0, #0		; clear R0
	ADD R0, R1, R0		; load bits from R1 to R0
	OUT					; display R0
	ADD R3, R3, R4		; load ACII representation of remainder into R3 to display later
	AND R0, R0, #0		; clear R0
	ADD R0, R3, R0		; load bits from R1 to R0
	OUT					; display R0
	LEA R0, NEWLINE		; Move to new line
	PUTS
	AND R1, R1, #0		; Reset R1
	AND R2, R2, #0		; Reset R2
	AND R3, R3, #0		; Reset R3
	BR Start 
	HALT

SIX	  .FILL #6
ASCII .fill  x30    ; Our ASCII offset
	  .END	