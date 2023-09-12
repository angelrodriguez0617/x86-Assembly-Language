; Program to multiply a number by the constant 6

SECTION .data
question		db 		"Choose a single-digit number to multiply by 6: ",0
question_len	equ		$-question					; calculate length of question
statement  		db 		"6 * ",0
statement_len	equ		$-statement				; calculate length of statement
product		    db 		"= ",0
product_len		equ		$-product			; calculate length of product statement
number_len	dq		0
NL				db 		10

SECTION .bss
number 		resb 	8

SECTION .text

GLOBAL _start				; global label required to make executable
_start:	

	  ; ask for number
	  mov rdi, 1            	; standard output
	  mov rsi, question			; address of prompt
	  mov rdx, question_len	
	  mov rax, 1				; write system call
	  syscall
	  
	  ; save number	
	  mov rdi, 0				; standard input
	  mov rsi, number		; point to buffer
	  mov rdx, 25				; length of buffer
	  mov rax, 0				; read system call
	  syscall
	  mov [number_len], rax	; save length of name
	  
	  ; display statement
	  mov rdi, 1				; standard output
	  mov rsi, statement   		; address of greeting
	  mov rdx, statement_len
	  mov rax, 1                ; select system call 'write’
	  syscall                   ; perform the system call
	  
	  ; display chosen number
	  mov rdi, 1			; standard output
	  mov rsi, number   	; address of name
	  mov rdx, number
	  mov rax, 1            ; select system call 'write’
	  syscall               ; perform the system call
	  
	  ; display message for product
	  mov rdi, 1				; standard output
	  mov rsi, product  		; address of greeting
	  mov rdx, product_len
	  mov rax, 1                ; select system call 'write’
	  syscall                   ; perform the system call
  		
  	  ; get inputted number and multiply with 6
  	  mov rbx, 0			; clear rbx
  	  mov rbx, [number]		; store number in first 8 bits of rbx
  	  sub rbx, 48			; convert from ASCII
  	  mov rax, 0			; Clear product
	  mov rax, [six]		; copy from memory to rax register
	  mul rbx				; product is in rax
	  
	  ; get quotient and remainder of product for dividing by 10
	  mov r8, rax	; product is in r8
	  mov r10, 10	; we will use the 10 to divide accumulator
	  div r10		; quotient of product/10 is in rax
	  mov r9, rax	; quotient is in r9
	  mov rax, 10	; we will be multiplying by 10
	  mul r9		; product of quotient and 10 is in rax
	  sub r8, rax   ; remainder is now in r8 and quotient in r9 
	  
	  add r9, 48	; ACII of first digit
	  add r8, 48	; ASCII of second digit
	  
	  mov r13, 0
	  mov [number], r9
	  mov [number+1], r8
	  mov [number+2], r13
	  
	  ; display product
	  mov rdi, 1			; standard output
	  mov rsi, number   	; address of name
	  mov rdx, number
	  mov rax, 1            ; select system call 'write’
	  syscall               ; perform the system call
	  
	  ; output new line
	  mov rdi, 1				; standard output
	  mov rsi, NL    			; address of newline
      mov rdx, 1
      mov rax, 1                ; select system call 'write’
      syscall                   ; perform the system call
	  
	  mov rax, 60			; code for exit function
	  syscall				; system call
		
;number:
;		dq 9				; 64-but "quadword"
six: 
		dq 6				; 64-but "quadword"
	
