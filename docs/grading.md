# Grading of Labs

The lab assignments for this course are worth 40% of your overall grade. There will be two main forms of assessment for labs:

## Lab assignments

The lab manuals for some weeks clearly indicate that a lab assignment is included for that week. There are questions embedded in the manuals for those weeks. 

!!! question "Question 1"
	This is how the questions in the manuals are presented. 
	
	Please note that **EVERY QUESTION** in a green box like this one, **MUST** be answered for credit - they are not rhetorical...

Please use your preferred word processor (Word, Google Docs, Pages, Overleaf, LibreOffice Writer etc.) to create a document, and use headings to separate the answers to each question in the manual. The questions may ask you to include code, screenshots, or written answers. 

The first line of your submission must include your name and student number. If there are any questions that require you to use your student number or NUSNET ID (eg. to derive test cases), you MUST include these in your answer.

Export your report to PDF before uploading it to Canvas. There is no naming scheme you must follow. 

The weightage of each assignment, as well as that of each question within the assignment, is clearly specified in each manual. Note that 1 point = 1% of your grade. The graded labs add up to 20 points, or 20% of the grade for the whole course. 

Upload your solutions for each of the assignments to Canvas by the end of the lab session at noon. Late submissions will be accepted for 30 minutes, with a penalty of 10% of your score for every 15 minutes you are late. That is, for submitting between 12:00 and 12:15, you will be penalised 10%; for submitting between 12:15 and 12:30, you will be penalised 20%. 

## Projects

As you may have figured out by now, the project for this course involves building your own CPU :D. In the second half of the course, we will slowly build up to making our own CPU on the FPGA board. The project will be assessed in a demonstration in Week 12, along with a Q&A session with a member of the teaching team to demonstrate your understanding. The project will be worth **20 points** in total, or 20% of your grade.

The grading criteria for the project will be as follows: 

* **Basic Hardware implementation [12 points]**

	For this criterion, the project group will be scored as a group. The implementation of the project, as described in Labs 5-8, will be tested on the FPGA board. For this requirement, the basic demo program provided is sufficient, and no modifications to the final product specified in Lab 5-8 is required. 

	* **12 points**: The CPU functions and is able to run the demo program provided. 
	* **6 points**: The CPU does not function in hardware, but the simulation produces the correct result. 
	* **3 points**: The CPU does not function in hardware, and the simulation produces some correct results (but not all). 

* **Live Q&A [6 points]**

	Each student will be asked 3 questions, worth 2 points each. The scope of these questions is wide: they may be about the RISC-V ISA, the microarchitecture, about SystemVerilog or Vivado, or about the specific implementation presented. These questions must be answered *individually*, so every group member needs to know every part of the finished project to be able to answer these questions. 

* **Enhancements to Hardware [2 points]**

	Up to 2 points will be awarded for any enhancements made beyond the basic requirements for the project. 

	Here are some examples of enhancements which could be implemented:

	1. Support for `lui` and `auipc` instructions. 
	2. A more complex demo program than the one included, e.g. using the push buttons, adding more features, etc. 




