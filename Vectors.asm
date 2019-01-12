## Chandler Barlow
## L20441500

la $s0, vectorA
la $s1, vectorB

li $v0, 4 
la $a0, prompt1
syscall

li $v0, 5 ## get number of elements
syscall
sw $v0, length ## saving length to t0
lw $t1, length

li $v0, 4
la $a0, prompt2
syscall

or $t2,$0, $t1

vectorLOOPA:
beqz $t2,loop1end
li $v0, 5
syscall
sw $v0, ($s0)
addi $s0,$s0,4
subi $t2, $t2, 1
j vectorLOOPA
loop1end:

li $v0, 4
la $a0, prompt3
syscall
or $t2,$0, $t1

vectorLOOPB:
beqz $t2,loop2end
li $v0, 5
syscall
sw $v0, ($s1)
addi $s1,$s1,4
subi $t2, $t2, 1
j vectorLOOPB
loop2end:


la $s0, vectorA
la $s1, vectorB

or $t2,$0, $t1
ori $t3, $0, 0
ori $t4, $0, 0
ori $t5, $0, 0

dotProduct:
beqz $t2, final
lw $t6, ($s0)
lw $t7, ($s1)
mult $t6, $t7
mflo $t4
mfhi $t5
add $t3, $t3, $t4
add $t3, $t3, $t5
addi $s0, $s0, 4
addi $s1, $s1, 4
subi $t2, $t2, 1
j dotProduct

final:
li $v0, 4
la $a0, prompt4
syscall



sw $t3, dot
or $a0, $0, $t3
li $v0, 1
syscall


.data
prompt1: .asciiz "Enter the number of elements in the Vectors\n"
prompt2: .asciiz "Enter the values for Vector A\n"
prompt3: .asciiz "Enter the values for Vector B\n"
prompt4: .asciiz "The dot product is "

dot: .word 0
length: .word 0
vectorA: .space 40
vectorB: .space 40
