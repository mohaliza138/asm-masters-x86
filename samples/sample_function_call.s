section .bss
	
section .rodata
sfmt:	db	"%d", 0
pfmt:	db	"Received data is: %d", 10, 0

section .data
val:    dd  0


section	.text

; Declarint external symbols 'scanf' & 'printf' 
extern scanf
extern printf

%macro scan_int 1
	lea	rdi, sfmt
	lea	rsi, %1
	xor	eax, eax
	call scanf
%endmacro

global main
main:
	; Creating stack frame.
	push rbp
	mov	rbp, rsp

	scan_int val
	; lea	rdi, sfmt
	; lea	rsi, val
	; xor	eax, eax
	; call scanf

	lea	rdi, pfmt
	mov	esi, [val]
	xor	eax, eax
	call printf


	; Ensure eax is 0 before returning
	xor	eax, eax
	; 'leave' instruction is equivalent to:
	; 	mov	rsp, rbp
	; 	pop	rbp
	leave
	ret
