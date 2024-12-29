section .bss
	
section .rodata
sfmt:	db	"%f %f %f %f", 0
pfmt:	db	"%f %f %f %f", 10, 0

section .data
array: dd 0.0, 0.0, 0.0, 0.0

section	.text

extern scanf
extern printf

global main
main:
	; Create stack frame.
	push	rbp
	mov	rbp, rsp

	lea	rdi, sfmt
	lea	rsi, array
	lea	rdx, array + 4
	lea	rcx, array + 8
	lea	r8, array + 12
	xor eax, eax			; Total number of xmme registers being used in this call is 0. It's not wrong to use 4 as an upperbound but it's better to use 0 instead.
	call	scanf

	lea	rdi, pfmt
	movss	xmm0, [array]
	cvtss2sd xmm0, xmm0
	movss	xmm1, [array + 4]
	cvtss2sd xmm1, xmm1
	movss	xmm2, [array + 8]
	cvtss2sd xmm2, xmm2
	movss	xmm3, [array + 12]
	cvtss2sd xmm3, xmm3
	mov eax, 4
	call	printf

	xor	eax, eax
	leave
	ret

section	.note.GNU-stack
