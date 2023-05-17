.section .data
output:
   .asciz "The area is: %f\n"

.section .bss
   .lcomm result, 4

.section .text
.globl _start
_start:
   nop

    finit

    mov 16(%rsp), %rdi
    call atoi

    mov %rax, result

    fldpi
    filds result
    fmul %st(0), %st(0)
    fmul %st(1), %st(0)
    fstps (%rsp)

    cvtss2sd (%rsp), %xmm0
    mov     $output, %rdi
    mov     $1, %rax
    call    printf

    add     $8, %rsp  # due fstps, align stack back

    mov $0, %rdi
    mov	$0, %rax
    call exit

