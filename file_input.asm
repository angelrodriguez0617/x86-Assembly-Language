; fwrite.asm
; a program to demonstrate writing to a file

SECTION .data
FileDescrip		dq 		0
greeting		db		"Hello, Angel.", 10
greeting_len	equ		$-greeting							; calculate length of greeting
greeting2		db 		"You are 24 years old.", 10
greeting2_len	equ		$-greeting2							; calculate length of greeting2
greeting3		db 		"You live in Millcreek.", 10
greeting3_len	equ		$-greeting3							; calculate length of greeting3
fileName		db 		"exercise10b.dat",0					; null-terminated string
errorMsg		db 		"File Create error", 10
errorMsg_len	equ		$-errorMsg							; calculate length of error message
writeError		db 		"File Write error", 10
writeError_len	equ		$-writeError						; calculate length of write error message

%include "io.h"

SECTION .text
GLOBAL _start
_start:
		mov rdi, fileName				; address of filename
		mov rsi, O_WRONLY|666q			; write only, permissions
		mov rax, SYS_creat              ; select system call 'creat'
		syscall
		cmp rax, 0						; check for error
		jl errorOpen
		mov [FileDescrip], rax			; save file descriptor

		mov rdi, [FileDescrip]			; recover file descriptor
		mov rsi, greeting				; point to greeting
		mov rdx, greeting_len			
		mov rax, SYS_write 				; write to file
		syscall
		cmp rax, 0						; check for error
		jl errorWrite

		mov rdi, [FileDescrip]			; recover file descriptor
		mov rsi, greeting2				; point to greeting2
		mov rdx, greeting2_len
		mov rax, SYS_write 				; write to file
		syscall
		cmp rax, 0						; check for error
		jl errorWrite
		
		mov rdi, [FileDescrip]			; recover file descriptor
		mov rsi, greeting3				; point to greeting3
		mov rdx, greeting3_len
		mov rax, SYS_write 				; write to file
		syscall

		mov rdi, [FileDescrip]			; recover file descriptor
		mov rax, SYS_close				; close file
		syscall
		jmp exit

errorOpen:
		mov rdi, STDOUT					; write to screen
		mov rsi, errorMsg				; pointer to error message
		mov rdx, errorMsg_len	
		mov rax, SYS_write
		syscall
		jmp exit
		
errorWrite:
		mov rdi, STDOUT					; write to screen
		mov rsi, writeError				; pointer to error message
		mov rdx, writeError_len
		mov rax, SYS_write
		syscall
		
exit:	mov rdi, 0						; status code
		mov rax, SYS_exit
		syscall
