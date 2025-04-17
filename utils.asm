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
    
    SPLIT_INPUT:
            move $v0 , $a0 
            move $t0 , $a0
            
            split_loop:
                lb $t1 , ($t0)
                beq $t1 , 0 , no_args
                beq $t1 , 32 , found_space
                addi $t0 , $t0 , 1
                j split_loop
            
            found_space:
                sb $zero , ($t0)
                addi $t0 , $t0 , 1
            
            skip_space:
                lb $t1 , ($t0)
                bne $t1 , 32 , done_skipping
                addi $t0 , $t0 , 1
                j skip_space
            
            done_skipping:
                move $v1 , $t0  
                beq $t1 , 0 , no_args
                jr $ra
            
            no_args:
                li $v1 , 0
                jr $ra

    EXIT:
    	li $v0, 10
		syscall
