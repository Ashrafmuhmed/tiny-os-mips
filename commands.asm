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
        li $v0, 4
        la $a0, cmd_ls
        syscall
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

