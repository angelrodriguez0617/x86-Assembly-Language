; testString2Num.asm
; program to test string2num subroutine
GLOBAL _start
EXTERN string2num
SECTION .data
string 		db "123"
string_len equ $-string
SECTION .text
_start:
  mov rdi, string
  mov rsi, string_len
  call string2num
last:
  mov rdi, rax
  mov rax, 60
  syscall
