# ex12A.asm
# ENCM 369 Winter 2020 Lab 12 Exercise A

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
# variable	location
#  int rs	  $s0
#  unsigned int	  $s1
#
	.data
SC1:	.asciiz "\nfirst result: "
SC2:	.asciiz "\nsecond result: "
SC3:	.asciiz "\nthird result: "
SC4:	.asciiz "\nfourth result: "
SC5:	.asciiz "\nfifth result: "
SC6:	.asciiz "\nsixth result: "
SC7:	.asciiz "\nseventh result: "
SC8:	.asciiz "\neighth result: "
SC9:	.asciiz "\n"
	.text
	.globl	main
main:
	addiu	$sp, $sp, -32
	sw	$ra, 8($sp)
	sw	$s1, 4($sp)
	sw	$s0, 0($sp)

	li	$a0, 3
	li	$a1, 15002
	li	$a2, 10
	li	$a3, 311
	jal	func1
	addu	$s0, $v0, $zero		# rs = r.v. from func1
	la	$a0, SC1		# syscall arg = SC1
	ori	$v0, $zero, 4		# syscall type = print string
	syscall
	addu	$a0, $s0, $zero		# syscall arg = rs
	ori	$v0, $zero, 1		# syscall type = print int
	syscall
	
	li	$a0, 31111
	li	$a1, 31333
	li	$a2, -12
	li	$a3, 1000000000
	jal	func1
	addu	$s0, $v0, $zero		# rs = r.v. from func1
	la	$a0, SC2		# syscall arg = SC2
	ori	$v0, $zero, 4		# syscall type = print string
	syscall
	addu	$a0, $s0, $zero		# syscall arg = rs
	ori	$v0, $zero, 1		# syscall type = print int
	syscall
	
	li	$a0, -6
	li	$a1, 4
	li	$a2, 2
	li	$a3, 5

	jal	func1
	addu	$s0, $v0, $zero		# rs = r.v. from func1
	la	$a0, SC3		# syscall arg = SC3
	ori	$v0, $zero, 4		# syscall type = print string
	syscall
	addu	$a0, $s0, $zero		# syscall arg = rs
	ori	$v0, $zero, 1		# syscall type = print int
	syscall
	
	li	$a0, -47653
	li	$a1, -48767
	li	$a2, -11
	li	$a3, 100000
	jal	func1
	addu	$s0, $v0, $zero		# rs = r.v. from func1
	la	$a0, SC4		# syscall arg = SC4
	ori	$v0, $zero, 4		# syscall type = print string
	syscall
	addu	$a0, $s0, $zero		# syscall arg = rs
	ori	$v0, $zero, 1		# syscall type = print int
	syscall
 
	li	$a0, 10
	li	$a1, 1001
	li	$a2, 301
	li	$a3, 123456789
	jal	func2
	addu	$s1, $v0, $zero		# ru = r.v. from func1
	la	$a0, SC5		# syscall arg = SC5
	ori	$v0, $zero, 4		# syscall type = print string
	syscall
	addu	$a0, $s1, $zero		# syscall arg = ru
	ori	$v0, $zero, 36		# syscall type = print unsigned int
	syscall

	li	$a0, 0xf0000000
	li	$a1, 10000
	li	$a2, 460
	li	$a3, 0xffffffff
	jal	func2
	addu	$s1, $v0, $zero		# ru = r.v. from func1
	la	$a0, SC6		# syscall arg = SC6
	ori	$v0, $zero, 4		# syscall type = print string
	syscall
	addu	$a0, $s1, $zero		# syscall arg = ru
	ori	$v0, $zero, 36		# syscall type = print unsigned int
	syscall

	li	$a0, 11
	li	$a1, 10000
	li	$a2, 460
	li	$a3, 0xffffffff
	jal	func2
	addu	$s1, $v0, $zero		# ru = r.v. from func1
	la	$a0, SC7		# syscall arg = SC7
	ori	$v0, $zero, 4		# syscall type = print string
	syscall
	addu	$a0, $s1, $zero		# syscall arg = ru
	ori	$v0, $zero, 36		# syscall type = print unsigned int
	syscall

	li	$a0, 1000000000
	li	$a1, 10
	li	$a2, 1820000
	li	$a3, 12345
	jal	func2
	addu	$s1, $v0, $zero		# ru = r.v. from func1
	la	$a0, SC8		# syscall arg = SC8
	ori	$v0, $zero, 4		# syscall type = print string
	syscall
	addu	$a0, $s1, $zero		# syscall arg = ru
	ori	$v0, $zero, 36		# syscall type = print unsigned int
	syscall

	la	$a0, SC9		# syscall arg = SC9
	ori	$v0, $zero, 4		# syscall type = print string
	syscall

	addu	$v0, $zero, $zero	# rv from main = 0

	lw	$s0, 0($sp)
	lw	$s1, 4($sp)
	lw	$ra, 8($sp)
	addiu	$sp, $sp, 32
	jr	$ra


# int func1(int a, int b, int c, int d)
#
	.text
	.globl	func1
func1:
	# Students: Replace this comment with a translation of
	# the C version of func2.
	jr	$ra

# unsigned int func2(unsigned int a, unsigned int b, 
#		     unsigned int c, unsigned int d)
#
	.text
	.globl	func2
func2:
	# Students: Replace this comment with a translation of
	# the C version of func2.
	jr	$ra
