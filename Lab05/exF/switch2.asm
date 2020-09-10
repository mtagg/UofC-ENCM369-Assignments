# switch2.asm
# ENCM 369 Winter 2020 Lab 5 Exercise F

# BEGINNING of start-up & clean-up code.
	.data
exit_msg_1:
	.asciiz "***About to exit. main returned "
exit_msg_2:
	.asciiz ".***\n"
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
	
jump_table:

	.word default
	.word default
	.word case1_6_10
	.word case2
	.word case3
	.word default
	.word case5_7_11_13
	.word case1_6_10
	.word case5_7_11_13
	.word default
	.word default
	.word case1_6_10
	.word case5_7_11_13
	.word default
	.word case5_7_11_13
	.word default

tri:		.asciiz " is triangular.\n"
two:		.asciiz " is the only even prime number.\n"
tre:		.asciiz " is both prime and triangular.\n"
oddp:		.asciiz " is odd and prime.\n"
def:		.asciiz " is not special, according to this program.\n"	
	
	.text
	.globl main
main:
	addi	$sp, $sp, -32
	sw 	$s0, 0($sp)
	sw	$s1, 4($sp)
	sw	$s2, 8($sp)
	sw	$ra, 12($sp)
	
	addi 	$s0, $0, 15
	addi 	$s1, $0, -1
L1: 	
	beq	$s0, $s1, end
	add 	$a0, $s1, $zero
	addi 	$v0, $zero, 1
	syscall
	jal	comment_on
	add	$a0, $v0, $zero
	addi	$v0, $zero, 4
	syscall
	addi 	$s1, $s1, 1
	j L1
end:	
	lw	$s0, 0($sp)
	lw	$s1, 4($sp)
	lw	$s2, 8($sp)
	lw	$ra, 12($sp)
	addi	$sp, $sp, 32
	add	$v0, $zero, $zero
	jr 	$ra
	
	
	
	.globl comment_on
comment_on:
	addi 	$t0, $a0, 1
	sll	$t0, $t0, 2
	la	$t1, jump_table
	add	$t2, $t1, $t0		# $t2 = &jumptable[index]
	lw	$t3, ($t2)		# $t3 = jumptable[index]
	jr	$t3			# jump to jumptable[index]
	
end_comment:
	jr $ra
	
	
case1_6_10:	
	la 	$v0 tri 		
	j 	end_comment
case2:		
	la 	$v0 two 	
	j 	end_comment
case3:		
	la 	$v0 tre 	
	j 	end_comment
case5_7_11_13:	
	la 	$v0 oddp 	
	j 	end_comment
default:	
	la 	$v0 def 	
	j 	end_comment	
	
	

	
	


