# Lab 6: Designing our ALU

Welcome back to CS2100DE! Last week, we made a small step to start creating our own CPU, by decoding instructions and figuring out what each should do. Today, we will work on the ALU - another crucial component of the CPU. Once we have these two components completed, we will have all the most important bits of our CPU ready to go. Then, it's just a matter of connecting everything together correctly, and letting it rip :D 

!!! info "Project Work"
	This manual is part of the final project. You do not need to write a report for this. You should work in your project groups. 

Note: Today's lab, unlike all those before, does not closely match the lecture content. However, Lecture 7's content, plus this manual, should suffice to be able to complete this lab.

## Introduction

### What is an ALU, and what does it do?

The ALU, or Arithmetic and Logic Unit, lives at the heart of our CPU. As the name implies, it is in charge of performing all the arithmetic and logic operations for our CPU - which, if you think about it, is almost all of them :D 

The ALU is a relatively simple block: in our case, it is a block of combinational logic that produces a result, and some flags, based on the inputs provided. Let's break it down into two parts.

The result output of the ALU should be the result of performing some arithmetic or logic (figures!) operation on the two inputs. What this operation is, depends on the control signal we provide to the ALU. 

Remember that our decoder module has an output `alu_control` that changes depending on the type of instruction. This is the signal we use to determine what operation the ALU should perform: addition, subtraction, logical shift, etc. 

??? note "Where are multiplication and division?"
	Multiplication and division are not part of the base RV32I instruction set. They are instead part of the M extension for multiplication and division operations. The reason for this is that not all systems need hardware multiplication capability, and are better served by having less hardware on board. For example, the Arduino Uno does not feature a multiplication unit, and multiplications are performed in software. 

	However, even if we were to implement multiplication and division, we would not implement them in an ALU. Multiplication and division are actually very computationally complex operations compared to, for example, simple addition. So, we would implement these in a separate module, and this module would take many clock cycles to finish computing the result. Due to the complexity of this hardware, it has been left out of CS2100DE. However, [CG3207 does implement a multiplier](https://nus-cg3207.github.io/labs/Lab_3/lab3/), so do take this course if you are interested. 

The ALU outputs three flags, based on three conditions: equality, less than, and less than unsigned. These flags are useful for performing branch operations. 

Recall that there are six different branch instructions in the RISC-V ISA: `beq`, `bne`, `blt`, `bge`, `bltu` and `bgeu`. If we look at them closely, we see that `beq` and `bne` are inverses of each other: that is to say, the condition `eq` (equal) is the logical negative of `ne` (not equal). The same applies for `lt` (less than) and `ge` (greater than or equal) and their unsigned counterparts. So, we can get away with just three flags to check these three conditions: `eq`, `lt` and `ge`. 

These flags will eventually go to the Conditional Unit, which will then determine whether or not a branch should be taken. We will figure this part out later. 

## Building our ALU

Download [`ALU.sv`](https://github.com/NUS-CS2100DE/labs/blob/main/lab_templates/week08/ALU.sv) from the GitHub repository. Add it to the Vivado project we created last week. 

The inputs and outputs for the ALU are defined as follows: 

```SystemVerilog linenums="23"
module ALU(
    input src_a,
    input src_b,
    input control,
    output result, 
    output flags
    );
```

### Activity 1: Quick Maths

For the first activity, we need to define each of the ALU operations. Referring to the RISC-V Reference and the `Decoder` that we coded last week, we need to produce the correct `result` output based on the value of `control`. 

Now that we've sorted one of the outputs, we need to sort out the other one: the ALU flags. 

We need to write logic to set the `flags` according to the result of our ALU operation. As a reminder, the three flags should correspond to the three conditions (equal, less than, less than unsigned). 

In no particular order, here are some hints for solving this problem:

1. Use a case statement on the `control` input for the `result` output. Make sure all cases are covered, use a `default` case if necessary. 

2. There exists a synthesizable function `$signed()` in (System)Verilog. Feel free to research this to make signed operations easier. 

3. Be careful: logical and arithmetic shifts are not the same thing :)

4. Feel free to use all the Verilog operators (`+`, `-`, `&`, `|`, etc. etc. ). 

!!! note "Making the ALU more efficient"
	Our approach to designing the ALU is quite inefficient. It is possible to make the ALU higher performance, and use much less hardware. For the sake of simplicity for this course, we have simplified the code for the ALU. CG3207 will go into much more depth and create a much more efficient CPU. Once again, we cannot recommend taking that course enough, if you are interested in this field. 

### Activity 2: Sim City

Of course, we need to simulate to make sure our result is correct. However, there's a twist: for this week, the training wheels are off completely - there are no templates for simulation. However, we can always refer back to previous simulation sources to figure out how to simulate the module. Here are some hints that you might want to use:

1. We can choose to create a new simulation file, or simply extend the source file created last week, or even both. It might be useful to test that the decoder and the ALU can work together. 

2. Since we haven't implemented our register file (or other potential ALU sources) yet, we will need to specify the ALU sources manually. However, when testing instructions with immediate sources, we can still test our extender to make sure the results are correct. 

3. Instantiate the ALU module inside the simulation testbench, and create the connections as necessary. If we are testing all the modules together, we need to make the connections between them correctly. We may need to add more wires; remember you can use the `logic` keyword in SystemVerilog. 

## Concluding Remarks

Congratulations on finishing this week's lab! Believe it or not, we have done the lion's share of designing our CPU. The next steps are simply wiring everything up correctly, and testing it rigourously to make sure everything works as expected. 

!!! success "What we should know"
	* All the different operations the ALU can compute.
	* The purpose of the flags that the ALU outputs.
	* How to design a simple ALU that can perform all the operations needed for a basic CPU.
	* How to write our own simulation testbenches, with little to no guidance. 