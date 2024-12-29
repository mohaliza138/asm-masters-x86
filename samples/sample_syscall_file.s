section .bss
    buffer resb 128          ; Reserve 128 bytes for input

section .rodata
filename db "input.txt", 0

section .text
    global main

main:
	; Creating stack frame.
    push rbp
    mov rbp, rsp

    ; Open the file
    mov rax, 2                   ; Syscall number for open
    lea rdi, filename            ; File name
    mov rsi, 0                   ; Read-only mode
    xor rdx, rdx                 ; No flags
    syscall                      ; Perform syscall
    mov r12, rax                 ; Save file descriptor (FD)

    ; Read from the file
    mov rax, 0                   ; Syscall number for read
    mov rdi, r12                 ; File descriptor
    lea rsi, buffer              ; Address of buffer
    mov rdx, 128                 ; Number of bytes to read
    syscall                      ; Perform syscall

    ; Output the file content
    mov rax, 1                   ; Syscall number for write
    mov rdi, 1                   ; File descriptor (stdout)
    lea rsi, buffer              ; Address of buffer
    mov rdx, 128                 ; Length of buffer
    syscall                      ; Perform syscall

    ; Close the file
    mov rax, 3                   ; Syscall number for close
    mov rdi, r12                 ; File descriptor
    syscall                      ; Perform syscall

    xor eax, eax
    leave
    ret
