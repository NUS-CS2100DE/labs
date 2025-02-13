# Prerequisites for lab work

## Knowledge and skills expected

This course is designed for students with all sorts of background, and we do not expect almost any prior knowledge. The same holds true for the labs. 

We expect you to have completed CS1010 or one of its variants like CS1010E; this should not be an issue as CS1010* is a listed prerequisite for this course. We recommend refreshing your memory on Python and/or C programming as the skills and thinking style will be needed for the labs.

Most importantly, we expect you to have attended, paid attention to, and understood (at least most of) every lecture before the lab. The labs will take the knowledge you gain from the lectures, and help you put it into practice and build something cool. If you are unclear with any concepts taught in lecture, please ask for help from the teaching team. The labs will not be particularly valuable in a vacuum, and having a solid understanding of lecture concepts is necessary to get the most out of the labs. 

## Hardware required

For this course, you will need an FPGA development board. We will provide you a [Nexys 4 board](guides/nexys4.md), and our materials will expect you to use this specific board. You will also need a Windows or Linux (preferred) computer to run the software to program this FPGA. The PCs in the lab will have the software required for this course installed for you, and you may use these as well. 

!!! note

	If you are not an official student of this course, and do not have access to a Nexys 4 board to follow along, you can use any other Xilinx/AMD FPGA development board, like the Basys 3 or Arty A7. You may need to make some changes to your code and project files to account for the different FPGA and different available peripherals. You may also be able to use a completely different brand of FPGA, like an Intel or Sipeed board. However, you will not be able to use Vivado, nor our template files. 

The FPGA board comes with a USB type A to USB micro-B cable. You will need a USB type A port on your laptop, and if you do not have one, you must use an adapter. Remember to bring one to class. 

## Software required

The software you will use to program your FPGA board is [Vivado](https://www.amd.com/en/products/software/adaptive-socs-and-fpgas/vivado.html). Installation instructions can be found [on the CG3207 website](https://nus-cg3207.github.io/labs/Vivado_Installation_and_Getting_Started/vivado_install_guide/). Please install Vivado before coming for your first lab in Week 3. 

To explore RISC-V assembly, we will use the [RARS architecture simulator](https://github.com/TheThirdOne/rars). This runs on Windows, macOS and Linux, and does not require any installation and can be run by double clicking the downloaded jar file or by running `java -jar filename.jar` where `filename` is the name of the jar file you downloaded. 