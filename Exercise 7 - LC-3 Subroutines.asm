.ORIG X3000
BR Start
Message		.STRINGZ	"Hello, you gorgeous world! Pick a single digit number to multiply 6 with:\n"
Message2	.STRINGZ	"\nThe product of the inputted number and 6 is "
NEWLINE		.STRINGZ	"\n"
MULTIPLY 	.FILL x4000
DIVIDE 		.FILL x5000
Start
	LEA R0, Message
	PUTS
	TRAP x23 		;the trap instruction which is also known as “IN”
	ADD R2, R0, x0 	;move the user-inputted integer to register 2
	ADD R2, R2, #-16 ; subtract 48 from received int to convert from ASCII
	ADD R2, R2, #-16
	ADD R2, R2, #-16
	LD R1, SIX
	
	LD R5, MULTIPLY
	JSRR, R5

	LD R5, DIVIDE
	JSRR, R5

CONVERT_TO_ASCII
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