.data 
    cmd_ls: .asciiz "ls"
    cmd_ps: .asciiz "ps"
    cmd_mkdir: .asciiz "mkdir"
    cmd_exit: .asciiz "exit"
    error_cmd: .asciiz "Error: Unknown command\n"
    created_msg: .asciiz "created : "

.text
    DO_LS:
        jal CMD_LS
        j PARSE_DONE
    DO_PS:
        jal CMD_PS
        j PARSE_DONE
    DO_MKDIR:
        lw $a1 , 4($sp)
        JAL CMD_MKDIR
        j PARSE_DONE
    DO_EXIT:
        j EXIT

    CMD_LS:
        la $t0 , root_entries
        lw $t1 , ($t0)
        beq $t1 , 0 , ls_done
   	
   	ls_loop:
   		lw $a0 , ($t1) 
   		li $v0 , 4
   		syscall
   		
   		addi $t0 , $t0 , 4
   		lw $t2 , ($t0)
   		beq $t2 , 0 , ls_no_space
   		li $v0 , 11
   		li $a0 , 32
   		syscall
   	ls_no_space:
   		move $t1 , $t2
   		bne $t1 , 0 , ls_loop
   	ls_done:
    		li $v0, 11
    		li $a0, '\n'
    		syscall
    		jr $ra
   		 
      
       
    CMD_PS:
        li $v0, 4
        la $a0, cmd_ps
        syscall
        li $v0, 11
        li $a0, '\n'
        syscall
        jr $ra

    CMD_MKDIR:
        li $v0, 4
        la $a0, created_msg
        syscall
        beq $a1, $zero, CMD_MKDIR_DONE
        move $a0, $a1
        syscall
        
        li $v0, 11
        li $a0, '\n'
        syscall
    
    CMD_MKDIR_DONE:
        jr $ra
     
        
    PARSE_DONE:
        lw $ra, 0($sp)
        addi $sp, $sp, 8
        jr $ra
        
.include "utils.asm"
.include "filesystem.asm"

