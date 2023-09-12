; printn.s
; a subroutine to print a decimal value to the console screen
; PARAMETERS:
; R0 - the decimal value to print
; RETURN VALUES:
; R0 - 0 on success, -1 on failure
; ERROR CHECKING:
; Only works on values on positive numbers
; Returns -1 if decimal value is negative
; DEPENDENCIES:  divide

	.ORIG x5000
	BR printn
Buffer	.BLKW #10
ToAscii	.FILL x30
Divisor	.FILL #10
ErrorCode	.FILL #-1
SaveR1	.FILL #0
SaveR3	.FILL #0
SaveR4	.FILL #0
SaveR7	.FILL #0
divide	.fill X5100

printn
	; save registers and return address
	ST R1, SaveR1
	ST R3, SaveR3
	ST R4, SaveR4
	ST R7, SaveR7

	LEA R1, Buffer			; pointer to buffer

begin
	ADD r4, r1, #9			; point to end of buffer
	AND r3, r3, #0			; null character
	STR R3, R4, #0			; insert null character at end of string
	ADD R0, r0, #0			; check value of r0
	BRZ zero						; if number = 0, insert 0
	BRN error						; if number < 0, error
again
	ADD r4, r4, #-1			; move pointer to previous character
	LD r1, Divisor
	LD r3, divide				; divide by 10
	jsrr r3
	LD R3, ToAscii
	ADD R1, R1, R3			; convert remainder to ascii
	STR r1, R4, #0			; store character
	ADD r0, r0, #0			; check quotient
	BRP again
	BR print
error
	LD R0, ErrorCode		; set error code
	br return

zero
	ADD r4, r4, #-1			; back up one character
  LD R3, ToAscii			; insert '0'
	STR r3, r4, #0			; store in string

print
	ADD R0, R4, #0			; point to beginning of string
	PUTS
	and r0, r0, #0
	add r0, r0, #10			;  newline
	out									; print newline

return
	; recover registers and return address
	LD R1, SaveR1
	LD R3, SaveR3
	LD R4, SaveR4
	LD R7, SaveR7
	RET
	.end
