; finalProject.asm
; Angel Rodriguez
; multiplies a selected number from the user

%include "system.mac"

SECTION .data
welcome		    db 		"Hello, welcome to Angel's final for CS 2810!",0
welcome_len		equ		$-welcome		; calculate length of welcome
question		db 		"Choose the first single-digit number to multiply or enter 'q' to quit: ",0
question_len	equ		$-question		; calculate length of question
question2		db 		"Choose the second single-digit number to multiply or enter 'q' to quit: ",0
question2_len	equ		$-question2		; calculate length of question
statement  		db 		"6 * ",0
statement_len	equ		$-statement		; calculate length of statement
product		    db 		"product = ",0
product_len		equ		$-product		; calculate length of product statement
quit_msg	    db 		"Exiting the program...",0
quit_len		equ		$-quit_msg		; calculate length of quitting
error_msg	   	db 		"ERROR, inputted value is not a number, try again",0
error_len		equ		$-error_msg		; calculate length of error
bee	   			db 		"Just for fun, the ENTIRE bee movie script is printed above",0
bee_len			equ		$-bee		; calculate length of bee

number_len		dq		0
NL				db 		10
fileName		db 		"final.dat",0		; null-terminated string
FileDescrip		dq 		0
buffer_len		equ 	25

SECTION .bss
number 		resb 	8
buffer 		resb 	buffer_len
SECTION .text

GLOBAL _start				; global label required to make executable


_start:	
	  ; print welcome message
	  write STDOUT, welcome, welcome_len
	  
	  ; output new line
	  write STDOUT, NL, 1

prompt:	  
	  ; ask for number
	  write STDOUT, question, question_len
	  
	  ; save number	
	  save_input number, [number_len]
	  
	  ; get inputted number
  	  mov rbx, 0			; clear rbx
  	  mov rbx, [number]		; store number in rbx
  	  mov rax, 0			; clear rax
  	  
  	  cmp bl, 113			; check for q
  	  je quit				; go to quit if q
  	  cmp bl, 48			; compare to 0 in ASCII
  	  jl error 				; go to error if less than 0
  	  cmp bl, 57			; compare to 9 in ASCII
  	  jg error				; go to error if greater than 9
  	  
  	  sub rbx, 48			; convert from ASCII
  	  mov r12, rbx			; move first number to r11

	  ; ask for second number
	  write STDOUT, question2, question2_len
	  
	  ; save second number	
	  save_input number, [number_len]
	  
	  ; get second inputted number
  	  mov rbx, 0			; clear rbx
  	  mov rbx, [number]		; store number in rbx
  	  mov rax, 0			; clear rax
  	  
  	  cmp bl, 113			; check for q
  	  je quit				; go to quit if q
  	  cmp bl, 48			; compare to 0 in ASCII
  	  jl error 				; go to error if less than 0
  	  cmp bl, 57			; compare to 9 in ASCII
  	  jg error				; go to error if greater than 9
  	  
  	  sub rbx, 48			; convert from ASCII
  	    	  
	  ; display message for product
	  write STDOUT, product, product_len
  	  
  	  mov rax, r12			; move first number to rax
  	  
	  ; multiply inputted numbers
	  mul rbx				; product is in rax
	  
	  mov r8, rax	; product is in r8
	  
	  ; get quotient and remainder of product for dividing by 10
	  divide 10 ; remainder is now in r8 and quotient in r9  
	  
	  add r9, 48	; ACII of first digit
	  add r8, 48	; ASCII of second digit
	  
	  mov [number], r9 		; first digit
	  mov [number+1], r8	; second digit
	  mov r13, 0
	  mov [number+2], r13	; end of number marked with 0
	  
	  write STDOUT, number, number_len  ; display product
	  write STDOUT, NL, 1 				; output new line
	  write STDOUT, NL, 1 					; output new line

	  jmp prompt ; continue program
	
error:
	  write STDOUT, error_msg, error_len	; print quit message
	  write STDOUT, NL, 1 					; output new line
	  write STDOUT, NL, 1 					; output new line

	  jmp prompt 						 	; continue program
	  
quit:	
	  write STDOUT, NL, 1 				; output new line
	  ; read the file
	  read_file fileName, [FileDescrip], buffer, buffer_len
	  write STDOUT, NL, 1 				; output new line
	  
	  write STDOUT, bee, bee_len  ; print quit message
	  write STDOUT, NL, 1 				; output new line
	  write STDOUT, quit_msg, quit_len  ; print quit message
	  write STDOUT, NL, 1 				; output new line
	  exit 0							; code for exit function	
	
