	.file	"main.c"
	.text
	.comm	x, 60000000, 5
	.def	__main;	.scl	2;	.type	32;	.endef
	.section .rdata,"dr"
	.align 8
.LC1:
	.ascii "microseconds spent in index_version: %.2f\12\0"
	.align 8
.LC2:
	.ascii "The sum from index_version was %lld.\12\0"
	.align 8
.LC3:
	.ascii "microseconds spent in pointer_version: %.2f\12\0"
	.align 8
.LC4:
	.ascii "The sum from pointer_version was %lld.\12\0"
	.text
	.globl	main
	.def	main;	.scl	2;	.type	32;	.endef
	.seh_proc	main
main:
	pushq	%rbp
	.seh_pushreg	%rbp
	movq	%rsp, %rbp
	.seh_setframe	%rbp, 0
	subq	$96, %rsp
	.seh_stackalloc	96
	.seh_endprologue
	call	__main
	movl	$0, -4(%rbp)
	jmp	.L2
.L3:
	movl	-4(%rbp), %eax
	leal	1(%rax), %edx
	movl	%edx, %eax
	sall	$2, %eax
	addl	%edx, %eax
	addl	%eax, %eax
	movl	%eax, %ecx
	leaq	x(%rip), %rax
	movl	-4(%rbp), %edx
	movslq	%edx, %rdx
	movl	%ecx, (%rax,%rdx,4)
	addl	$1, -4(%rbp)
.L2:
	cmpl	$14999999, -4(%rbp)
	jle	.L3
	leaq	-48(%rbp), %rax
	movq	%rax, %rcx
	movq	__imp_QueryPerformanceCounter(%rip), %rax
	call	*%rax
	movq	-48(%rbp), %rax
	cvtsi2sdq	%rax, %xmm0
	movsd	%xmm0, -16(%rbp)
	movl	$15000000, %edx
	leaq	x(%rip), %rax
	movq	%rax, %rcx
	call	index_version
	movq	%rax, -24(%rbp)
	leaq	-48(%rbp), %rax
	movq	%rax, %rcx
	movq	__imp_QueryPerformanceCounter(%rip), %rax
	call	*%rax
	movq	-48(%rbp), %rax
	cvtsi2sdq	%rax, %xmm0
	movsd	%xmm0, -32(%rbp)
	leaq	-48(%rbp), %rax
	movq	%rax, %rcx
	movq	__imp_QueryPerformanceFrequency(%rip), %rax
	call	*%rax
	movq	-48(%rbp), %rax
	cvtsi2sdq	%rax, %xmm0
	movsd	%xmm0, -40(%rbp)
	movsd	-32(%rbp), %xmm0
	subsd	-16(%rbp), %xmm0
	movsd	.LC0(%rip), %xmm1
	mulsd	%xmm1, %xmm0
	divsd	-40(%rbp), %xmm0
	movq	%xmm0, %rax
	movq	%rax, %rdx
	movq	%rdx, -56(%rbp)
	movsd	-56(%rbp), %xmm0
	movapd	%xmm0, %xmm1
	movq	%rax, %rdx
	leaq	.LC1(%rip), %rcx
	call	printf
	movq	-24(%rbp), %rax
	movq	%rax, %rdx
	leaq	.LC2(%rip), %rcx
	call	printf
	leaq	-48(%rbp), %rax
	movq	%rax, %rcx
	movq	__imp_QueryPerformanceCounter(%rip), %rax
	call	*%rax
	movq	-48(%rbp), %rax
	cvtsi2sdq	%rax, %xmm0
	movsd	%xmm0, -16(%rbp)
	movl	$15000000, %edx
	leaq	x(%rip), %rax
	movq	%rax, %rcx
	call	pointer_version
	movq	%rax, -24(%rbp)
	leaq	-48(%rbp), %rax
	movq	%rax, %rcx
	movq	__imp_QueryPerformanceCounter(%rip), %rax
	call	*%rax
	movq	-48(%rbp), %rax
	cvtsi2sdq	%rax, %xmm0
	movsd	%xmm0, -32(%rbp)
	leaq	-48(%rbp), %rax
	movq	%rax, %rcx
	movq	__imp_QueryPerformanceFrequency(%rip), %rax
	call	*%rax
	movq	-48(%rbp), %rax
	cvtsi2sdq	%rax, %xmm0
	movsd	%xmm0, -40(%rbp)
	movsd	-32(%rbp), %xmm0
	subsd	-16(%rbp), %xmm0
	movsd	.LC0(%rip), %xmm1
	mulsd	%xmm1, %xmm0
	divsd	-40(%rbp), %xmm0
	movq	%xmm0, %rax
	movq	%rax, %rdx
	movq	%rdx, -56(%rbp)
	movsd	-56(%rbp), %xmm0
	movapd	%xmm0, %xmm1
	movq	%rax, %rdx
	leaq	.LC3(%rip), %rcx
	call	printf
	movq	-24(%rbp), %rax
	movq	%rax, %rdx
	leaq	.LC4(%rip), %rcx
	call	printf
	movl	$0, %eax
	addq	$96, %rsp
	popq	%rbp
	ret
	.seh_endproc
	.section .rdata,"dr"
	.align 8
.LC0:
	.long	0
	.long	1093567616
	.ident	"GCC: (GNU) 7.4.0"
	.def	index_version;	.scl	2;	.type	32;	.endef
	.def	printf;	.scl	2;	.type	32;	.endef
	.def	pointer_version;	.scl	2;	.type	32;	.endef
