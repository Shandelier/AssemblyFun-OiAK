.section .data

s0 : .asciz "Procesor: %.48s\n"
err : .asciz "Nie mozna rozpoznac procesora.\n"

.section .text

.global asm_cpuid
.type asm_cpuid, @function
.align 32
asm_cpuid:
	pushq	%rbp
	movq	%rsp,	%rbp
	subq	$48,	%rsp
	pushq	%rbx

	movl	$0x80000000,	%eax
	cpuid

	cmpl	$0x80000004,	%eax
	jl	error

	movl	$0x80000002,	%esi
	movq	%rsp,	%rdi

.align 16
get_brand:
	movl	%esi,	%eax
	cpuid

	movl	%eax,	(%rdi)
	movl	%ebx,	4(%rdi)
	movl	%ecx,	8(%rdi)
	movl	%edx,	12(%rdi)

	addl	$1,	%esi
	addq	$16,	%rdi
	cmpl	$0x80000004,	%esi
	jle	get_brand

print_brand:
	movq	$s0,	%rdi
	movq	%rsp,	%rsi
	xorb	%al,	%al
	call	printf

	jmp	end

.align 16
error:
	movq	$err,	%rdi
	xorb	%al,	%al
	call	printf

.align 16
end:
	popq	%rbx
	movq	%rbp,	%rsp
	popq	%rbp
	xorl	%eax,	%eax
	ret
