.data
      Array: .space 48     #Array Declaration # 12 int numbers each one is 4 byte : 4*12=48
      Msg0: .asciiz "Please Enter The Numbers Of The Array: "
      Msg1: .asciiz "The Array You Have Entered: "
      Msg2: .asciiz "The Cumulative Sum Of All 2 Digit Numbers: "
      Msg3: .asciiz "The Smallest Number , The Largest Number : "
      Msg4: .asciiz "The Array After Sorting In Ascending Order: "
      Msg5: .asciiz "The Prime Numbers In The Array: "
      Msg6: .asciiz "*** Name: Fathi Fathallah Fathi Ali   |    ID Number: 11821218    ***"
      Msg7: .asciiz "*** Mail: s11821218@stu.najah.edu     |    CA 1 - Dr.Luai Malhis  ***"
      nl: .asciiz "\n"
      
.text
	li $v0,4
	la $a0,Msg0
	syscall         #print Msg0
	li $v0,4
	la $a0,nl       #print newLine
	syscall
	
	li $20,0       #counter of numbers stored in Array
	la $s0, Array  #Start Offset of -Array- stored in $s0
	move $t7,$s0
	
	Reading:
	li $v0,5       #read Integer syscall = 5
	syscall 
	move $t1,$v0      #$t0 = number
	blez $t1,Reading  #if the number in ($t0 <= 0) it will branch again to Reading and ignore the value
	j Store           #If the code has reached here then the (number > 0) , so we need to store it
	
	
	
	Store:
	sw $t1,0($t7)              #we will store the number in the array
	addiu $t7,$t7,4            #moving the offset to next number
	addiu $20,$20,1
        beq $20,12,Finish_Storing  #if the counter (equal == 12)then we branch to finish_sorting
	j Reading                 #after storing we get back to read
	
	
	
	Finish_Storing:
	li $v0,4
	la $a0,nl
	syscall
	li $v0,4
	la $a0,Msg1
	syscall         #print Msg1
	Print:
	li $v0,1
	lw $a0,0($s0)
	syscall 
	addi $20,$20,-1
	beqz $20,newline  #if $20 == 0 then all numbers are printed
	addiu $s0,$s0,4
	li $a0, 32  #to print space
	li $v0, 11  # syscall number for printing character
	syscall
	j Print
	newline:
	li $v0,4
	la $a0,nl
	syscall
################################################################### Now we have stored all the 12 integers(integers > 0) into the array	#########################################################

	li $v0,4
	la $a0,Msg2
	syscall        #print MSG2
	
	la $s0, Array  #Start Offset of -Array- stored in $s0
	li $20,12      #loop
	li $22,0       #// the sum of the two digits numbers
	li $21,10
	
	TwoDigits:
	lw $t1,0($s0)  #store the number into $t1
	move $t2,$t1   #store the number into $t2
	divu $t2,$21  #We divide the number by 10 , then if the quotient is one digit , the number is two digits
	mflo $t2
	ble $t2,$zero,NotTwoDigits    #if the number in LO wich is the QUOTIENT <= 0 then it's not two digits number , so we branch again to NotTwoDigits
	bge $t2,$21,NotTwoDigits       #if the number >= 10 then it's not two digits number , so we branch again to NotTwoDigits

	
	addu $22,$22,$t1            #add the number to $20
	addiu $s0,$s0,4
	addi $20,$20,-1            #The counter is decreased by one
	bnez  $20,TwoDigits
	j DoneTwoDigits
	

	
	NotTwoDigits:
	addi $20,$20,-1            #The counter is decreased by one
	addiu $s0,$s0,4
	bnez  $20,TwoDigits
	
	
	
	DoneTwoDigits:
	li $v0,1                    #print the summation
	move $a0,$22
	syscall
	li $v0,4                   #new line
	la $a0,nl
	syscall


	
	
################################################################### Finish the cumulative sum of all 2 digit numbers	########################################################################
	####IMPORTANT :: We Can find the smallest , largest number after sorting the array easily , but we will implement the code for smallest and largest to practice more to mips language
	
	li $v0,4
	la $a0,Msg3
	syscall        #print MSG3
	
	la $s0, Array  #Start Offset of -Array- stored in $s0
	li $20,12      #loop
	lw $21,0($s0)  #the smallest number
	addiu $s0,$s0,4 #to have the next number of the array soon
	
	
	Smallest:
	lw $t1,0($s0)  #the next number now is in $t1
	blt $t1,$21,LessThanSwap
	addi $20,$20,-1
	addiu $s0,$s0,4
	bnez $20,Smallest
	j FinishSmallest
	
	LessThanSwap:
	move $21,$t1
	addi $20,$20,-1
	addiu $s0,$s0,4
	bnez $20,Smallest

	
	FinishSmallest:
	li $v0,1                    #print the smallest and (,)
	move $a0,$21
	syscall
	
	li $a0, 32  #to print space
	li $v0, 11  # syscall number for printing character
	syscall
	
	li $a0, 44  #to print ,
	li $v0, 11  # syscall number for printing character
	syscall
	
	li $a0, 32  #to print ,
	li $v0, 11  # syscall number for printing character
	syscall

	#The smallest is done
	
	la $s0, Array  #Start Offset of -Array- stored in $s0
	li $20,12      #loop
	li $22,1       #the largest number
	
	Largest:
	lw $t1,0($s0)  #the first number now is in $t1
	bgt $t1,$22,LargerSwap
	addi $20,$20,-1
	addiu $s0,$s0,4
	bnez $20,Largest
	j FinishLargest

	
	LargerSwap:
	move $22,$t1
	addi $20,$20,-1
	addiu $s0,$s0,4
	bnez $20,Largest
	
	
	FinishLargest:
	li $v0,1                    #print the largest
	move $a0,$22
	syscall
	
	li $v0,4                  #new line
	la $a0,nl
	syscall

	

################################################################### Finish the largest and the smallest numbers	###############################################################################	
	
	la $s0, Array  #Start Offset of -Array- stored in $s0
	li $20,0      #loop1
	li $21,0      #loop2
	
	
	
	
	Sort:
	lw $t1,0($s0)
	lw $t2,4($s0)
	bgt $t1,$t2,Swap
	addiu $s0,$s0,4
	addiu $20,$20,1
	beq $20,11,Loop2
	j Sort
	
	
	
	Swap:
	move $22,$t1
	move $t1,$t2
	move $t2,$22
	sw $t1,0($s0)
	sw $t2,4($s0)
	addiu $s0,$s0,4
	addiu $20,$20,1
	beq $20,11,Loop2
	j Sort
	
	
	Loop2:
	la $s0, Array
	li $20,0      #loop1
	addiu $21,$21,1 #loop2
	ble $21,11,Sort
	
	
	
	PringSortingArray:
	li $v0,4
	la $a0,Msg4
	syscall        #print MSG4
	
	la $s0, Array  #Start Offset of -Array- stored in $s0
	li $20,12      #loop for printing
	
	PrintSortingLoop:
	li $v0,1
	lw $a0,0($s0)
	syscall 
	addi $20,$20,-1
	beqz $20,donePrintingSort  #if $20 == 0 then all numbers are printed
	addiu $s0,$s0,4
	li $a0, 32  #to print space
	li $v0, 11  # syscall number for printing character
	syscall
	j PrintSortingLoop
	
	donePrintingSort:
	li $v0,4       #new line
	la $a0,nl
	syscall

################################################################### Finish Sorting the array in ascending order #################################################################################	

	li $v0,4
	la $a0,Msg5
	syscall        #print MSG5

	
	la $s0, Array  #Start Offset of -Array- stored in $s0
	li $20,0       #loop

	
	LoopPrime:
	lw $t1,0($s0) #the number is in $t1
	li $21,2
	beq $t1,1,Prime  #if its one , its already prime
	Dividing:
	move $t2,$t1
	divu $t2,$21  #we divide the number by (2 to the number-1)
	mfhi $t2      #now the reminder is in $t2
	beqz  $t2,NotPrime      #if it's 
	addiu $21,$21,1         #increment by 1
	beq $21,$t1,Prime
	j Dividing

	NotPrime:
	addiu $s0,$s0,4
	addiu $20,$20,1
	beq $20,12,FinishPrime
	j LoopPrime
	
	
	Prime:
	li $v0,1          #Print it
	move $a0,$t1
	syscall 
	li $a0, 32  #to print space
	li $v0, 11  # syscall number for printing character
	syscall

	addiu $s0,$s0,4
	addiu $20,$20,1
	beq $20,12,FinishPrime
	j LoopPrime


	FinishPrime:
	
################################################################### Finish Prime Number ######################################################################################################	
	
	#PRINT MY NAME , LAST ORDER
	
	li $v0,4       #new line
	la $a0,nl
	syscall

	li $v0,4
	la $a0,Msg6
	syscall        #print MSG6
	
	li $v0,4       #new line
	la $a0,nl
	syscall
	
	li $v0,4
	la $a0,Msg7
	syscall        #print MSG7
	
	
####################################################################################FINISH PRINTING THE NAME & THE ID #########################################################################
####################################################################################        END OF THE PROGRAM        #########################################################################
