# exD.asm
# ENCM 369 Winter 2020 Lab 2
# This program has complete start-up and clean-up code and
# exD main function.

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

# Below is the stub for main. Edit it to give main the desired behaviour.

	.data
	.globl alpha
alpha: 	.word 0xb1, 0xe1, 0x91, 0xc1, 0x81, 0xa1, 0xf1, 0xd1
	.globl beta
beta: 	.word 0x0, 0x10, 0x20, 0x30, 0x40, 0x50, 0x60, 0x70
	.text
	.globl	main
	
	
# Variables	Register

# int *p	$s0
# int *gaurd	$s1
# int min	$s2
# int j		$s3
# int k		$s4
main:
	## setup of variables
	la   $s0, alpha		# set $s0 to address of alpha[0]
	addi $s1, $s0, 32	# set $s1 to address of alpha[0] + 8
	lw   $t9, ($s0)		# load value at *p into $t9
	add  $s2, $t9, 	 $zero	# set $s2 to value of alpha[0]
L1:		
	## loop through alpha to find min
	addi $s0, $s0,   4	# p++
	beq  $s0, $s1,   L3	# pc = ($s0 == $s1) ? L3 : pc
	lw   $t8, ($s0)		# load value at *p into $t8
	slt  $t1, $t8,   $s2	# $t1 = ($t8 < $s2) ? 1 : 0
	bne  $t1, $zero, L2	# pc = ($t1 != 0) ? L2 : pc
	j    L1			# re-loop
L2:	
	## update value of min if neccessary
	add  $s2, $t8,   $zero	# min = *p
	j    L1		# return to L1
L3: 	
	## set variables: j, k; for new loop
	la   $s0, alpha		# set $s0 to address of alpha[0]
	la   $s5, beta		# set $s5 to address of beta[0]
	add  $s3, $zero, $zero  # j = 0
	addi $s4, $zero, 7	# k = 7	
L4:  
	## loop to replace values in alpha with beta in reverse order
	## te following is why pointers are so much better eh??
	sll  $t2, $s3, 2 	# $t2 = j * 4
	sll  $t3, $s4, 2	# $t3 = k * 4		
	add  $t7, $s0, $t2	# $t7 = alpha + $t2
	add  $t6, $s5,  $t3	# $t6 = beta  + $t3
	beq  $t7, $s1, L5       # pc = ($t7 == gaurd) ? L5 : pc
	lw   $t5, ($t6)		# load value from ($t6) to $t5
	sw   $t5, ($t7)		# store $t5 into ($t7)
	addi $s3, $s3, 1	# j++
	subi $s4, $s4, 1	# k--
	j    L4			# re-loop
L5:
	##code end main
	add	$v0, $zero, $zero	# return value from main = 0
	jr	$ra
