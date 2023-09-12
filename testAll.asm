; 	testAll.asm
;	PURPOSE:  reading a decimal number from the keyboard, doubling it and printing it to console screen
;	DEPENDENCIES:  getn, printn

.ORIG X3000
br Start
getn
	.fill x4100
printn
	.fill x4200
Prompt
	.stringz "Enter a number> "
Buffer
	.blkw #25
ValueError
	.stringz "\nValue too large\n"
CharacterError
  .stringz "\nIllegal character\n"

Start
	lea r0, Prompt
  PUTS
 	ld r1, getn
	jsrr r1
	add r2, r1, #2
	brn valueError
  brz characterError
	add r0, r0, r0
	ld r1, printn
	jsrr r1
  halt
valueError
  lea r0, ValueError
	puts
	halt
characterError
  lea r0, CharacterError
	puts
	halt
.end
