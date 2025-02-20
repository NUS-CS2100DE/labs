.text
	lui s0, 2				# Sets s0 to 2 << 12, or 0x2000
	lw s1, 0(s0)			# Loads the content at the address stored in s0, into s1
	lw s2, B				# We can use a label to load the value stored at the address where the label B is applied
	lw s3, 8(s0)			# We can use an offset (e.g. 8) to load the value stored at the address stored in s0, plus an offset of 8 (i.e. 0x2408) 
	la s4, ARRAY			# We can use the pseudoinstruction la to load the address of the data with label ARRAY. 
	
	start:
	add s5, s1, s2			# Take the value in s1 and s2, add them up, store result in s5
	sw s5, 0(s0)			# Take the value of s5, store at the address specified in s0
	
	loop:
	addi s5, s5, -100		# Add -100 to (or subtract 100 from) s5 and store back in s5 
	sw s5, 0(s0)			# Store the value in s5 at the address stored in s0
	bge s5, zero, loop		# If s5 >= 0, branch to the label loop (line 12)
	bltz s5, start 			# If s5 < 0, branch to the label start (line 8). Pseudoinstruction for blt s5, zero, start
	
# We changed the settings to set the data segment to start from 0x2000
.data
	A: .word 406 					# Address: 0x2000
	B: .word 775					# Address: 0x2004
	N: .word 4						# Address: 0x2008
	ARRAY: .word 320 753 680 400	# Address: 0x200C