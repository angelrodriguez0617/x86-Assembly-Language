; helloNameAddress.asm
; LC-3 program to demonstrate i/o
.ORIG X3000
BR Start
question   	    .stringz "What is your name? "
question2		.stringz "Where do you live? "
greeting		.stringz "Hello, "
location		.stringz "You live at "

firstName 		.blkw #25
address		    .blkw #50

saveR7           .fill #0
Start
 
	lea r0, question			; r0 - prompt
	puts
	lea r1, firstName
    jsr getChar 

	lea r0, question2
	PUTS
	lea r1, address
    jsr getChar
    
	LEA r0, greeting    		; print greeting
	PUTS
	LEA r0, firstName 			; print firstName
	PUTS						
    lea r0, location			; print location message
	PUTS
	lea r0, address 			; print address
    PUTS
	HALT

getChar st r7, saveR7	
Loop	getc						; get a character
	out							; output character
	str r0, r1, #0				; store character in buffer
	add r1, r1, #1				; increment pointer
	add r2, r0, #-10			; check for newline
	brnp Loop				    ; get next character
	and r0, r0, #0
	str r0, r1, #0				; store zero word
        ld r7, saveR7
    RET

	.end
