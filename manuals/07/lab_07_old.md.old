# Lab 7: The data path - putting everything together

Welcome back to CS2100DE! We're nearing the final destination. We've built the critical components of our CPU, namely the instruction decoder, immediate extension unit, and the ALU. Now, it's time to wire everything up and get ready to see it working. By the end of this lab, we should be able to assemble all the components of our CPU together, and get it ready for the final task next week, when we will see the CPU run real programs. 

!!! info "Project Work"
	This manual is part of the final project. You do not need to write a report for this. You should work in your project groups. 

## Introduction

### The datapath for our RISC-V CPU

Over the past few weeks, we've built three of the main components of our CPU. Let's explore the functions that these components perform inside our CPU in a bit more detail:

1. The `Decoder` module takes the instruction itself as an input, and it produces a number of control signals as outputs. These are:
	1. `PCS` goes to the PC Logic block. It determines what the PC should add to the current PC value: either the constant 4 or an offset (for branching). 
	2. `mem_to_reg` controls a multiplexer to select whether the ALU result or the data read from memory should be stored in a register.
	3. `mem_write` controls the write enable for the data memory. We do not always want to write to memory, only on store instructions. 
	4. `alu_control` chooses the operation the ALU should perform.
	5. `alu_src_b` controls a multiplexer that chooses whether the second operand of the ALU should be an immediate or a register value.
	6. `imm_src` tells the Extender module the immediate encoding format to expect.
	7. `reg_write` controls the write enable for the register file. We do not always want to write to the register file, for example for branch or store instructions. 

2. The `Extend` module takes the `imm_src` input from the `Decoder` and part of the `instr` input to the CPU. The output goes into the first of the two multiplexers we have (the one controlled by `alu_src_b`). It may be used as an input to the ALU, if the instruction is not an R-type. 

3. The `ALU` module takes two inputs:
	1. `alu_source_a` always comes from the register file.
	2. `alu_source_b` may come from the register file (R-type) or the immediate extender (all other types). 
   	
	It also has two outputs:
	1. `alu_flags` should go into the PC logic module. These help us determine whether or not a branch in our code should be taken. 
	2. `alu_result` should be used to address our data memory. It should also be connected to the second multiplexer, controlled by `mem_to_reg`, which determines whether the data to be written to the register file comes directly from the ALU, or from the data read from the data memory (`mem_read_data`).  

There are some other components of the CPU, namely the register file, the PC logic, and the PC itself. We can consider these black boxes, and do not need to understand the details of how they work. However, the code is, of course, available to peruse. For the purposes of this course, it will suffice to just understand each input and output to these modules, and to  connect the outputs from each module correctly following the microarchitecture diagram. 

Here is a very brief description of what each of the provided modules does:

1. `RegFile` is the register file for our CPU. It takes in two source numbers, and returns the value stored in the register indexed by those source numbers. For example, if `rs1` is `00011`, `RD1` will contain the value stored in register `x3`. It also takes in `rd` and `WD`, which choose the index of the register to be written to, and the data to be written to that register, respectively. `WE` is used as a write enable, to control whether register `rd` is written to. 

2. `PC_Logic` takes in the `PCS` from the instruction decoder and the `alu_flags`. It uses this information to determine whether branches should be taken or not, and controls whether the PC should be incremented by 4 (branch not taken) or by some other value determined by the encoded immediate (branch taken). 

3. `ProgramCounter` takes in the clock `clk` (to count up on positive edges), the reset signal `rst` (to reset to 0 when the CPU_RESET button is pressed), and the new value that PC should take `pc_in`. This can either be the current PC value plus 4, or the current PC value plus the immediate offset. Of course, the output `pc` determines the current value of the program counter.

We can assume that the "Instr Memory" and "Data Memory" are outside the CPU itself, and these will be provided later. Indeed, in a regular Von Neumann architecture, the memory lives outside the CPU, so this is somewhat accurate. Notice that the input to the Instruction Memory (`PC`) is an output of the CPU, while the ouput of the Instruction Memory (`Instr`) is an input to the CPU. The same is true for Data Memory; outputs of the CPU are inputs to the memory and vice versa. 

## Wiring everything up

Today, we will be filling out the `RISCV_MMC.sv` file. (2100, our course code, is MMC in Roman numerals.) This is our actual CPU. For today, we can just focus on connecting everything here. Next time, we will have the rest of the scaffolding needed to make the CPU tick, and we will be able to write and run our own programs on it. 

Today's task is reasonably simple. We can follow the microarchitecture diagram from Lecture 7, Slide 20. Here are the steps we need to follow to do this:

1. Create the wires/logic elements that we need to connect all the components together. Following the microarchitecture diagram should give us all the necessary ones. If we miss any, it should become quite obvious when we try to start connecting things together, so it's not really a big deal. 

2. Instantiate the modules we worked on in the previous two weeks, namely the instruction decoder `Decoder`, the immediate extension unit `Extend`, and the ALU `ALU`. 

3. Download and instantiate the modules provided for this week, namely the Register File [`RegFile`](https://github.com/NUS-CS2100DE/labs/blob/main/lab_templates/week09/RegFile.sv), the PC Logic [`PC_Logic`](https://github.com/NUS-CS2100DE/labs/blob/main/lab_templates/week09/PC_Logic.sv), and the Program Counter [`ProgramCounter`](https://github.com/NUS-CS2100DE/labs/blob/main/lab_templates/week09/ProgramCounter.sv) itself.

4. There are some discrepancies with the schematic from the schematic in the slides, namely:
	1. The `rst` input to the CPU should be connected to the `RESET` signal of the program counter. 
	2. Our instruction decoder takes the full 32 bit instruction, instead of having `funct3`, `opcode` and `funct7` as explicit inputs. 

This week, we will not be simulating the code. Next week, we will have a fairly complex framework to run programs and extensively debug our design. 

As usual, here is an unordered collection of tips for writing the code:

* Use a consistent naming scheme where possible. Neil personally prefers to use `PascalCase` for module names, and `snake_case` for inputs, outputs, module instances, and logic elements. This is the convention used in most of the source files. 

* Remember to use the correct bit width for each wire. This is a common issue, and it causes us many headaches that are completely avoidable. 

* Ensure that all the inputs and outputs of each module are connected, and accounted for. Use the RTL Schematic to verify this. In particular, verify that `alu_result`, which is used by two components, is correctly connected.

* Remember, multiplexers can easily be instantiated in your CPU itself using the ternary operator `assign some_wire = (condition) ? value_if_true : value_if_false;`

## Concluding Remarks

Nice work! We've built our CPU, and we're ready to see it in action next week. 

!!! success "What we should know"
	* How the datapath of our RISC-V CPU looks like. 
	* How to go from a schematic to implementation in SystemVerilog.
	* What all the components and signals inside our CPU do, and why they exist. 
