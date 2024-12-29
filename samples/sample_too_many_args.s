section .bss
val:    resd 10
	
section .rodata
sfmt:	db	"%d %d %d %d %d %d %d", 0
pfmt:	db	"Received data is: %d %d %d %d %d %d %d", 10, 0

section .data

section	.text

extern scanf
extern printf


global main
main:
	; Create stack frame.
	push	rbp
	mov	rbp, rsp


	lea	rdi, sfmt
	lea	rsi, val
	lea	rdx, val + 4
	lea	rcx, val + 8
	lea	r8, val + 12
	lea	r9, val + 16
	sub	rsp, 32
	lea	rax, val + 20
	mov	[rsp], rax
	lea	rax, val + 24
	mov	[rsp + 8], rax
	xor	eax, eax
	call	scanf
	add	rsp, 32


	lea	rdi, pfmt
	mov	esi, [val]
	mov	edx, [val + 4]
	mov	ecx, [val + 8]
	mov	r8d, [val + 12]
	mov	r9d, [val + 16]
	sub	rsp, 32
	mov	eax, [val + 20]
	mov	[rsp], rax
	mov	eax, [val + 24]
	mov	[rsp + 8], rax
	xor	eax, eax
	call	printf
	add	rsp, 32


	xor	eax, eax
	leave
	ret

section	.note.GNU-stack
