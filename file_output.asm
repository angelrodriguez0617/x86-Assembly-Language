; fread.asm
; a program to demonstrate reading from a file

SECTION .data
buffer_size		db			80
NL				db			10
errorMsg		db 			"File Open Error", 10
errorMsg_len	equ			$-errorMsg					; calculate length of error message
openMsg		    db 			"File is opened, contents are: \n", 10
openMsg_len		equ			$-errorMsg					; calculate length of error message
fileName		db 			"exercise10b.dat",0			; null-terminated string
FileDescrip: 	dq 			0
%include "io.h"

SECTION .bss
buffer			resb 		80

SECTION .text
GLOBAL _start
_start:
	mov rdi, fileName			; pointer to filename
   	mov rsi, O_RDONLY			; file access - read only
   	mov rax, SYS_open           ; system call 'open'
   	syscall                     ; perform the system call
	cmp rax, 0					; check for error
	jl error
	mov [FileDescrip], eax		; save file descriptor

again:
	mov rdi, [FileDescrip]		; recover file descriptor
	mov rsi, buffer				; point to buffer
	mov rdx, buffer_size		; buffer size
	mov rax, SYS_read			; read from file
	syscall
	cmp rax, 0					; check for end of file
	jz done
	
	mov rdx, rax				; transfer length of line read
	mov edi, STDOUT				; write to screen
	mov rsi, buffer				; point to string to print
	mov rax, SYS_write			; write to screen
	syscall

	jmp again

done:
	
	mov rdi, [FileDescrip]
	mov rax, SYS_close				; close file
	syscall
	jmp exit

error:
	mov rsi, STDOUT				; screen
	mov rsi, errorMsg
	mov rdx, errorMsg_len
	mov rax, SYS_write
	syscall

exit:
   	mov rdi, 0
   	mov rax, SYS_exit				; exit
   	syscall
