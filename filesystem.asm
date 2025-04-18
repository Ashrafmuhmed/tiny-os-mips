.data 
	file1_name: .asciiz "file1.txt"
	file1_size: .word 1024
	file1_date: .asciiz "2025-04-17"
	file1_perm: .word 0644  # rw-r--r--
	file1_type: .byte 0     # 0 = file
	file1: .word file1_name, file1_size, file1_date, file1_perm, file1_type

	file2_name: .asciiz "file2.txt"
	file2_size: .word 512
	file2_date: .asciiz "2025-04-17"
	file2_perm: .word 0644
	file2_type: .byte 0
	file2: .word file2_name, file2_size, file2_date, file2_perm, file2_type

	root_entries: .word file1, file2, 0  
	
	dir1_name: .asciiz "dir1"
	dir1_size: .word 0
	dir1_date: .asciiz "2025-04-17"
	dir1_perm: .word 0755  # rwxr-xr-x
	dir1_type: .byte 1     # 1 = directory
	dir1: .word dir1_name, dir1_size, dir1_date, dir1_perm, dir1_type