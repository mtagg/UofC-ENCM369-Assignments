# sort.asm
# ENCM 369  Winter 2020 Lab 12 Exercise G

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

	.data
x:	.double	-6.015625, -2.25, -3.125, -5.03125, 
	.double	-8.00390625, -4.0625, -1.5, -7.0078125

# int main(void)
# Register allocation
# Variable   Register
#  i	       $s0

	.data
str1:	.asciiz	"before sorting ...\n"
str2:	.asciiz	"after sorting ...\n"
str3:	.asciiz	"    "
str4:	.asciiz	"\n"

	.text
	.globl	main
main:
	# Prologue.
	addiu	$sp, $sp, -32
	sw	$ra, 4($sp)
	sw	$s0, ($sp)

	# Body.
	la	$a0, str1		# "before sorting ..."
	addi	$v0, $zero, 4		# code for string
	syscall

	add	$s0, $zero, $zero	# i = 0
L1:
	slti	$t0, $s0, 8		# $t0 = (i < 8)
	beq	$t0, $zero, L2		# if ($t0 == false) goto L2
	la	$a0, str3		# "    " (spaces)
	addi	$v0, $zero, 4		# code for string
	syscall
	la	$t0, x
	sll	$t1, $s0, 3		# $t1 = i * 8
	addu	$t1, $t0, $t1		# $t1 = &x[i]
	ldc1	$f12, ($t1)		# $f12 = x[i]
	addiu	$v0, $zero, 3		# code to print a double
	syscall
	la	$a0, str4		# newline
	addiu	$v0, $zero, 4		# code for string
	syscall
	addiu	$s0, $s0, 1		# i++
	j	L1
	
L2:
	la	$a0, x			# arguments for sort
	addiu	$a1, $zero, 8
	jal	sort
	la	$a0, str2		# "after sorting ..."
	addiu	$v0, $zero, 4		# code for string
	syscall

	add	$s0, $zero, $zero	# i = 0
L3:
	slti	$t0, $s0, 8		# $t0 = (i < 8)
	beq	$t0, $zero, L4		# if ($t0 == false) goto L2
	la	$a0, str3		# "    " (spaces)
	addi	$v0, $zero, 4		# code for string
	syscall
	la	$t0, x
	sll	$t1, $s0, 3		# $t1 = i * 8
	addu	$t1, $t0, $t1		# $t1 = &x[i]
	ldc1	$f12, ($t1)		# $f12 = x[i]
	addiu	$v0, $zero, 3		# code to print a double
	syscall
	la	$a0, str4		# newline
	addiu	$v0, $zero, 4		# code for string
	syscall
	addiu	$s0, $s0, 1		# i++
	j	L3

L4:
	addu	$v0, $zero, $zero	# return 0

	# Epilogue.
	lw	$ra, 4($sp)
	lw	$s0, ($sp)
	addiu	$sp, $sp, 32
	jr	$ra




# void sort(double *a, int n)
# Sort array elements a[0], ... a[n - 1] in increasing order.
#
	.text
	.globl	sort
sort:
	# Replace this comment with appropriate code.

	jr	$ra
