; testSystem.asm
; program to test system.mac by 
; opening, writing, closing, and then reading from a file

%include "system.mac"

SECTION .data

question  		db "Hello, Angel."
question_len	equ $-question
greeting  		db "You live in Millcreek."
greeting_len	equ $-greeting
contents 		db "Below are the contents of the file named: "
contents_len	equ $-greeting
fileName		db 	"nameAddress.dat",0	; null-terminated string
FileDescrip		dq 		0
newline   		db 10
buffer_len		equ 25
name_len		dq 0

SECTION .bss
buffer 		resb buffer_len


SECTION .text
GLOBAL _start

_start:

  ; open file
  open fileName, [FileDescrip]
  
  ; write into the file
  write [FileDescrip], question, question_len
  write [FileDescrip], newline, 1
  write [FileDescrip], greeting, greeting_len
  write [FileDescrip], newline, 1
  
  ; close file
  close [FileDescrip]
  
  ; introduce the contents of the file
  write STDOUT, contents, contents_len
  write STDOUT, newline, 1
  
  ; read the file
  read_file fileName, [FileDescrip], buffer, buffer_len
  
  exit 0
