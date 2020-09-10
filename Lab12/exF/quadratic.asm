# quadratic.asm
# ENCM 369 Winter 2020 Lab 12 Exercise F

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
	.data
c1pt0:	.double 1.0
c1pt5:	.double 1.5
c2pt0:	.double 2.0
c1pt1:	.double 1.1
cm3pt5:	.double -3.5

	.text
	.globl	main
main:
	addiu	$sp, $sp, -32
	sw	$ra, 0($sp)

	ldc1	$f12, c1pt0
	ldc1	$f14 c1pt5
	ldc1	$f16, c2pt0
	jal	test_q	      
	ldc1	$f12, c1pt1
	ldc1	$f14 cm3pt5
	ldc1	$f16, c2pt0
	jal	test_q	      

	lw	$ra, 0($sp)
	addiu	$sp, $sp, 4
	jr	$ra


# double result[4] = {0.0, 0.0, 0.0, 0.0};
	.data
	.globl result
result: .double 0.0, 0.0, 0.0, 0.0

# void test_q(double a, double b, double c)
	.data
str01:	.asciiz "\ncoefficient a = "
str02:	.asciiz "\ncoefficient b = "
str03:	.asciiz "\ncoefficient c = "
str04:	.asciiz "\nroot: "
str05:	.asciiz " + i * ("
str06:	.asciiz ")\nroot: "
str07:	.asciiz ")\n"

	.text
	.globl	test_q
test_q:
	addiu	$sp, $sp, -32
	sw	$ra, 24($sp)
	sdc1	$f16, 16($sp)		# copy c to stack
	sdc1	$f14,  8($sp)		# copy b to stack
	sdc1	$f12,  0($sp)		# copy a to stack
	
	# Note: At this point a, b, and c are still in the appropriate
	# FPRs, so there is no need to recover them from the stack before
	# making the call to quadratic
	la	$a0, result		# 4th arg = &result[0]
	jal	quadratic
	
	la	$a0, str01
	li	$v0, 4			# syscall to print string
	syscall
	ldc1	$f12, 0($sp)		# $f12 = a
	li	$v0, 3			# syscall to print double
	syscall

	la	$a0, str02
	li	$v0, 4			# syscall to print string
	syscall
	ldc1	$f12, 8($sp)		# $f12 = b
	li	$v0, 3			# syscall to print double
	syscall

	la	$a0, str03
	li	$v0, 4			# syscall to print string
	syscall
	ldc1	$f12, 16($sp)		# $f12 = c
	li	$v0, 3			# syscall to print double
	syscall

	la	$a0, str04
	li	$v0, 4			# syscall to print string
	syscall
	ldc1	$f12,result		# $f12 = result[0]
	li	$v0, 3			# syscall to print double
	syscall

	la	$a0, str05
	li	$v0, 4			# syscall to print string
	syscall
	la	$t0, result		# $t0 = &result[0]
	ldc1	$f12, 8($t0)		# $f12 = result[1]
	li	$v0, 3			# syscall to print double
	syscall

	la	$a0, str06
	li	$v0, 4			# syscall to print string
	syscall
	la	$t0, result		# $t0 = &result[0]
	ldc1	$f12, 16($t0)		# $f12 = result[2]
	li	$v0, 3			# syscall to print double
	syscall

	la	$a0, str05
	li	$v0, 4			# syscall to print string
	syscall
	la	$t0, result		# $t0 = &result[0]
	ldc1	$f12, 24($t0)		# $f12 = result[3]
	li	$v0, 3			# syscall to print double
	syscall

	la	$a0, str07
	li	$v0, 4			# syscall to print string
	syscall

	lw	$ra, 24($sp)
	addiu	$sp, $sp, 32
	jr	$ra

#  void quadratic(double a, double b, double c, double *roots)
	.text
	.globl	quadratic
quadratic:
	
	# Replace these comments with code that translates the C
	# code.

	# ATTENTION: The C version of quadratic is nonleaf, but you
	# can code the AL version as LEAF by using the MIPS sqrt.d
	# instruction instead of making a call to a sqrt procedure.

	jr	$ra
