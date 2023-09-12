; getn.asm
; a subroutine to input a decimal number from the keyboard
; Parameters: none
; Return values:
; r0 - binary value
; r1 - error code: 0 for success, -1 for value error, -2 for invalid character
; Error handling:
; has a limit of unsigned values in 16 bits
; will return -1 if value would exceed this limit
; returns -2 if there are invalid characters
; DEPENDENCIES: read, string2num

	.ORIG x4300
	BR getn
SaveR2	.FILL #0
SaveR3  .FILL #0
SaveR4  .fill #0
SaveR7	.FILL #0
Buffer  .blkw #6
Size  .fill #5
read	.fill x4000
string2num .fill x4200

getn
	; save registers
	ST R2, SaveR2
	ST R3, SaveR3
	ST R4, SaveR4
	ST R7, SaveR7

  lea r0, Buffer
	ld r1, Size
	ld r2, read					; read a string
	jsrr r2
	add r1, r0, #0			; copy character count to r1
	lea r0, Buffer
	ld r2, string2num
	jsrr r2							; convert string to number, error codes pass t
	; restore registers
	LD R2, SaveR2
	LD R3, SaveR3
	LD r4, SaveR4
	LD R7, SaveR7
	RET
.end
