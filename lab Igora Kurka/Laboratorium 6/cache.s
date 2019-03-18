.data

.bss

.text
    .global my_rtdsc
    .type my_rtdsc, @function

my_rtdsc:
    # Save stack, so it doesn't go missing
    push %rbp
    # Save stack pointer to defferent register
    mov %rsp, %rbp
    # Clear %eax, required by cpuid
    xor %eax, %eax
    # Get processor info
    cpuid
    # Read number of processor ticks
    # Output is stored in %edx and %eax
    rdtsc
    # Move 32 bytes from %edx
    # To beggining of %rdx
    shl $32, %rdx
    # Move content of %rdx to %rax
    or %rdx, %rax
    # Restore stack pointer
    mov %rbp, %rsp
    # Restore stack
    pop %rbp
ret
