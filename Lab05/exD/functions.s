	.file	"functions.c"
	.text
	.globl	pointer_version
	.def	pointer_version;	.scl	2;	.type	32;	.endef
	.seh_proc	pointer_version
pointer_version:
	pushq	%rbp
	.seh_pushreg	%rbp
	movq	%rsp, %rbp
	.seh_setframe	%rbp, 0
	subq	$32, %rsp
	.seh_stackalloc	32
	.seh_endprologue
	movq	%rcx, 16(%rbp)
	movl	%edx, 24(%rbp)
	movq	$0, -8(%rbp)
	movq	16(%rbp), %rax
	movq	%rax, -16(%rbp)
	movl	24(%rbp), %eax
	cltq
	leaq	0(,%rax,4), %rdx
	movq	16(%rbp), %rax
	addq	%rdx, %rax
	movq	%rax, -24(%rbp)
	jmp	.L2
.L3:
	movq	-16(%rbp), %rax
	movl	(%rax), %eax
	cltq
	addq	%rax, -8(%rbp)
	addq	$4, -16(%rbp)
.L2:
	movq	-16(%rbp), %rax
	cmpq	-24(%rbp), %rax
	jne	.L3
	movq	-8(%rbp), %rax
	addq	$32, %rsp
	popq	%rbp
	ret
	.seh_endproc
	.globl	index_version
	.def	index_version;	.scl	2;	.type	32;	.endef
	.seh_proc	index_version
index_version:
	pushq	%rbp
	.seh_pushreg	%rbp
	movq	%rsp, %rbp
	.seh_setframe	%rbp, 0
	subq	$16, %rsp
	.seh_stackalloc	16
	.seh_endprologue
	movq	%rcx, 16(%rbp)
	movl	%edx, 24(%rbp)
	movq	$0, -8(%rbp)
	movl	$0, -12(%rbp)
	jmp	.L6
.L7:
	movl	-12(%rbp), %eax
	cltq
	leaq	0(,%rax,4), %rdx
	movq	16(%rbp), %rax
	addq	%rdx, %rax
	movl	(%rax), %eax
	cltq
	addq	%rax, -8(%rbp)
	addl	$1, -12(%rbp)
.L6:
	movl	-12(%rbp), %eax
	cmpl	24(%rbp), %eax
	jl	.L7
	movq	-8(%rbp), %rax
	addq	$16, %rsp
	popq	%rbp
	ret
	.seh_endproc
	.ident	"GCC: (GNU) 7.4.0"
