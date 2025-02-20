.text
	# Write your code here

	# DO NOT MODIFY THE CODE BEYOND THIS POINT:
	halt:
		jal halt
.data
	# The following are two example test cases you can use to test your program.
	# Try changing the values to try different test cases. 
	N: .word 7					# N < 100
	ARRAY: .word 326 3878 148 16 1820 750 655
	# Expected outcome of this test case: 16 148 326 655 750 1820 3878
	
	# .word N 25
	# .word ARRAY 1234 -567 8901 -2345 6789 -9012 3456 -7890 1357 -2468 9123 -4567 8246 -1357 5791 -8642 2468 -9753 6185 -3217 7531 -4862 1975 -6398 8024