; multiply6.asm
; multiply aa number by 6

	 .ORIG x3000
	 LD R1, SIX
	 LD R2, NUMBER
AGAIN 
	 ADD R3, R3, R2
	 ADD R1, R1, #-1
	 BRP AGAIN	
	 HALT 
NUMBER .FILL #9
SIX	.FILL #6
	.END