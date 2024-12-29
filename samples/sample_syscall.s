section .bss
    buffer resb 128          ; Reserve 128 bytes for input

section .text
    global main

main:
	; Creating stack frame.
    push rbp
    mov rbp, rsp

    ; Read syscall
    mov rax, 0         ; Syscall number for read
    mov rdi, 0         ; File descriptor: STDIN
    lea rsi, buffer    ; Address of buffer
    mov rdx, 128       ; Max bytes to read
    syscall            ; Invoke the system call

    ; Write back the input
    mov rax, 1         ; Syscall number for write
    mov rdi, 1         ; File descriptor: STDOUT
    lea rsi, buffer    ; Address of buffer
    ; When the input is less than 128 bytes, several zero bytes are written to stdout.
    ; These zeros aren't visible in the terminal but can be seen using tools like hexdump or xxd.
    mov rdx, 128       ; Length of the buffer
    syscall            ; Invoke the system call

    xor eax, eax
    leave
    ret
