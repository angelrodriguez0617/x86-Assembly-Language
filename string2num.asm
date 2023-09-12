; string2num.asm
; a subroutine to convert a string of decimal digits to a binary number
; Parameters: rdi-pointer to string, rsi-length of string
; Return values: rax - binary value
; Error handling
; has a limit of unsigned 64-bit values
; does not handle negative numbers
; will return -1 if value would exceed 64 bits
; returns -2 if there are invalid characters
; DEPENDENCIES: none

GLOBAL string2num

SECTION .data
Multiplier			dq 		10
ValueErrorCode		equ		-1
CharacterErrorCode 	equ 	-2
MaxCharacters		equ		100

SECTION .text
string2num:
	mov rcx, rsi			; copy to counter register
	mov rax, 0				; clear final sum
	cmp rcx, MaxCharacters
	jae ValueError			; too many characters
	cmp rcx, 0
	jbe ValueError			; too few characters 
getChar:
	movzx rbx, byte [rdi]	; get character into 64-bit register
	inc rdi					; increment pointer
	sub rbx, 30h			; convert to value
	cmp rbx, 0		
	jl CharacterError		; character less than '0'
	cmp rbx, -9
	ja CharacterError		; character greater than '9'
	mul qword [Multiplier]	; multiply by 10
	add rax, rbx			; add value of digit
	loop getChar			; get another character
	ret
ValueError:
	mov rax, ValueErrorCode
	ret
CharacterError:
	mov rax, CharacterErrorCode
	ret
