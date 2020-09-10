# 12Eprog.asm
# ENCM 369 Winter 2020 Lab 12 Exercise E

# BEGINNING of start-up & clean-up code.  Do NOT edit this code.
	.data
exit_msg_1:
	.asciiz	"***About to exit. main returned "
exit_msg_2:
	.asciiz	".***\n"
main_rv:
	.word	0
	
	.text
	# adjust $sp, then call main
	addi	$t0, $zero, -32		# $t0 = 0xffffffe0
	and	$sp, $sp, $t0		# round $sp down to multiple of 32
	jal	main
	nop
	
	# when main is done, print its return value, then halt the program
	sw	$v0, main_rv	
	la	$a0, exit_msg_1
	addi	$v0, $zero, 4
	syscall
	nop
	lw	$a0, main_rv
	addi	$v0, $zero, 1
	syscall
	nop
	la	$a0, exit_msg_2
	addi	$v0, $zero, 4
	syscall
	nop
	addi	$v0, $zero, 10
	syscall
	nop	
# END of start-up & clean-up code.

# int main(void)
#
# variable		allocation
#  int k		  $s0
#  double y[5]		  10 words starting at 0($sp) 
	.text
	.globl	main
main:
	addiu	$sp, $sp, -64
	sw	$ra, 44($sp)
	sw	$s0, 40($sp)

	addiu	$a0, $sp, 0		# $a0 = &y[0]
	addiu	$a1, $zero, 5		# $a1 = 5
	jal	proc1
	addu	$s0, $zero, $zero	# k = 0
L11:
	slti	$t0, $s0, 5		# $t0 = (k < 5)
	beq	$t0, $zero, L12		# if (!$t0) goto L12
	sll	$t1, $s0, 3		# $t1 = 8 * k
	addu	$t2, $sp, $t1		# $t0 = &y[k]
	ldc1	$f12, ($t2)		# $f12 = y[k]
	addiu	$v0, $zero, 3		# 3 means print double
	syscall				# print double in $f12
	addiu	$a0, $zero, 10		# $a0 = '\n'
	addiu	$v0, $zero, 11		# 11 means print char
	syscall				# print char in $a0
	addiu	$s0, $s0, 1		# k++
	j	L11
L12:
	addu	$v0, $zero, $zero	# r.v = 0

	lw	$s0, 40($sp)
	lw	$ra, 44($sp)
	addiu	$sp, $sp, 64
	jr	$ra

# void proc1(double *a, int n)
#
# arg/var			allocation
#  a				  $s0
#  n				  $s1
#  int k			  $s2
#  double pi_over_2		  $f20
#
	.data
const_pi_by_2:
	.double 1.57079632679489661923
	.text
	.globl	proc1
proc1:
	addiu	$sp, $sp, -32
	sw	$ra, 20($sp)
	sw	$s2, 16($sp)
	sw	$s1, 12($sp)
	sw	$s0, 8($sp)
	sdc1	$f20, 0($sp)
	addu	$s0, $a0, $zero
	addu	$s1, $a1, $zero
	
	# Attention: The next line of code is a helpful *pseudoinstruction*.
	# ldc1, the machine instruction, builds an address from a GPR and an
	# offset, just like lw.	 The assembler will expand the
	# pseudoinstruction into lui followed by a real ldc1 instruction.
	ldc1	$f20, const_pi_by_2

	addu	$s2, $zero, $zero	# i = 0
 L21:
	slt	$t0, $s2, $s1		# $t0 = i < n
	beq	$t0, $zero, L22		# if (!$t0) goto L22
	mtc1	$s2, $f2		# copy bits from i t0 $f2
	cvt.d.w $f4, $f2		# $f4 = (double) i
	mul.d	$f12, $f4, $f20		# $f12 = $f4 * pi_over_2
	jal	proc2
	sll	$t1, $s2, 3		# $t1 = 8 * i
	addu	$t2, $s0, $t1		# $t2 = &a[i]
	sdc1	$f0, ($t2)		# a[i] = r.v. from proc2
	addiu	$s2, $s2, 1		# i++
	j	L21
L22:	
	ldc1	$f20, 0($sp)
	lw	$s0, 8($sp)
	lw	$s1, 12($sp)
	lw	$s2, 16($sp)
	lw	$ra, 20($sp)
	addiu	$sp, $sp, 32
	jr	$ra

# double proc2(double x)
#
	.data
const_0pt5:
	.double 0.5
	.text
	.globl	proc2
proc2:
	ldc1	$f2, const_0pt5
	mul.d	$f0, $f2, $f12		# r.v. = $f2 * x
	jr	$ra
