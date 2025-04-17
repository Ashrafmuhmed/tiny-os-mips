.data
	welcome: .asciiz "Welcome to ASHRAF'S TOSM V1.0.\n"
	prompt_nl: .asciiz "> "
	input: .space 32
	
	
.text
	MAIN:
		li $v0 , 4
		la $a0 , welcome
		syscall
		j MAIN_LOOP
	
	MAIN_LOOP:
		li $v0 , 4
		la $a0 , prompt_nl
		syscall
		
		li $v0 , 8
		la $a0 , input
		li $a1 , 32
		syscall
		jal STRIP_NEWLINE
		la $t0, input
        	lb $t1, ($t0)
        	beq $t1, 0, MAIN_LOOP
		jal PARSE_COMMAND
		j MAIN_LOOP
	
	STRIP_NEWLINE:
		la $t0 , input
		strip_loop:
			lb $t1 ,($t0)
			beq $t1 , 0 , done
			beq $t1, 10, found_newline
			addi $t0 , $t0 , 1
			j strip_loop
		found_newline:
			sb $zero, ($t0)
			jr $ra
		done:
			jr $ra
	
	PARSE_COMMAND:
        addi $sp, $sp, -8
        sw $ra, 0($sp)

        la $a0, input
		jal SPLIT_INPUT

		sw $v1 , 4($sp)
		
		move $a0, $v0
        la $a1, cmd_ls
        jal STRCMP
        beq $v0, 0, DO_LS

		move $a0, $v0
        la $a0, input
        la $a1, cmd_ps
        jal STRCMP
        beq $v0, 0, DO_PS

		move $a0, $v0
        la $a0, input
        la $a1, cmd_mkdir
        jal STRCMP
        beq $v0, 0, DO_MKDIR

		move $a0, $v0
        la $a0, input
        la $a1, cmd_exit
        jal STRCMP
        beq $v0, 0, DO_EXIT

        li $v0, 4
        la $a0, error_cmd
        syscall
        j PARSE_DONE

	

		

		
		
.include "commands.asm"

