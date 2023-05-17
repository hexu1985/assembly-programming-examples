#cpuid2.s View the CPUID Vendor ID string using C library calls

.section .data

output:
    .asciz "The processor Vendor ID is '%s'\n"

.section .bss
    .lcomm buffer, 12

.section .text

.globl main

main:
    mov $0, %rax
    cpuid

    mov $buffer, %rsi
    movl %ebx, (%rsi)
    movl %edx, 4(%rsi)
    movl %ecx, 8(%rsi)

    movq $output, %rdi
    movq $buffer, %rsi
    mov $0, %rax
    callq printf

    addq $8, %rsp
    pushq $0
    call exit
