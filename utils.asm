.text 
    STRCMP:
        strcmp_loop:
            lb $t0 , ($a0)
            lb $t1 , ($a1)
            bne $t0 , $t1 , strcmp_diff
            beq $t0 , $zero , strcmp_end
            addi $a0 , $a0 , 1
            addi $a1 , $a1 , 1
            j strcmp_loop
        strcmp_diff:
            sub $v0 , $t0 , $t1
            jr $ra
        strcmp_end:
            bne $t1 , $zero , strcmp_diff
            li $v0 , 0 
            jr $ra

    EXIT:
    	li $v0, 10
		syscall
