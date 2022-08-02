
# iiitb_rv32i-risc-v rv32i


## RISC-V RV32I

This project provides an insight into the working of a few important instructions of the instruction set of a Single cycle Reduced Instruction Set Computer - Five(RISC-V) Instruction Set Architecture suitable for use across wide-spectrum of Applications from low power embedded devices to high performance Cloud based Server processors. The base RISC-V is a 32-bit processor with 31 general-purpose registers, so all the instructions are 32-bit long. Some Applications where the RISC-V processors have begun to make some significant threads are in Artificial intelligence and machine learning, Embedded systems, Ultra Low power processing systems etc.

### BLOCK DIAGRAM OF RISC-V RV32I
![image](https://user-images.githubusercontent.com/110079631/181293948-beb8622c-7696-4b06-b6c9-eeab9b8ab9d3.png)

### INSTRUCTION SET OF RISC-V RV32I
![image](https://user-images.githubusercontent.com/110079631/181298133-60269bc2-01da-4b5c-8b42-69057b8dc15c.png)

### FUNCTIONAL SIMULATION:

**ABOUT VERILOG**
Icarus Verilog is an implementation of the Verilog hardware description language.

**ABOUT GTKWAVE**
GTKWave is a fully featured GTK+ v1. 2 based wave viewer for Unix and Win32 which reads Ver Structural Verilog Compiler generated AET files as well as standard Verilog VCD/EVCD files and allows their viewing.

### Installing iverilog and gtkwave
**For Ubuntu**
Open your terminal and type the following to install iverilog and GTKWave
```
$   sudo apt get update
$   sudo apt get install iverilog gtkwave
```

**To clone the repository and download the netlist files for simulation , enter the following commands in your terminal.**

```
$ git clone https://github.com/vinayrayapati/iiitb_rv32i
$ cd iiitb_rv32i
```
**To simulate and run the verilog code , enter the following commands in your terminal.**
```
$ iverilog -o iiitb_rv32i iiitb_rv32i.v iiitb_rv32i_tb.v
$ ./iiitb_rv32i
```
**To see the output waveform in gtkwave, enter the following commands in your terminal.**

`$ gtkwave iiitb_rv32i.vcd`

### The output waveform in the gtkwave

 The output waveform showing the instructions performed in a 5-stage pipelined architecture.
 Instruction 1:add r4,r2,r1
![image](https://user-images.githubusercontent.com/110079631/182328768-d66c30a9-2d49-46f7-b444-9fd37817726c.png)
 Instruction 2:SUB R5,R2,R3
![image](https://user-images.githubusercontent.com/110079631/182328910-c039d30d-0b9b-4522-9a09-48ae66fd6896.png)
 Instruction 3:ADI R6,R7,IMM
![image](https://user-images.githubusercontent.com/110079631/182329021-81f00357-732b-4d26-ad25-22cca210b9ec.png)
 Instruction 4:st r8 r9 imm=1
![image](https://user-images.githubusercontent.com/110079631/182329120-349b1692-f90d-4f71-bf57-2cfe190d5c2e.png)
 Instruction 5:lt r10 r8 imm=1
![image](https://user-images.githubusercontent.com/110079631/182329228-a525ad59-2711-4f0e-aaa9-f8e23cf3f5da.png)
 Instruction 6:branch(i6)
 After branching performing
 INstruction 7:add r12 r13,r14
![RISC-V waveform](https://user-images.githubusercontent.com/110079631/181292645-93965b12-4b8a-4d89-8af9-6ea72132c498.jpg)

### Author
 - **Vinay Rayapati**

### Contributors
 - Vinay Rayapati
 - Kunal Ghosh

### Acknowledgments
 - Kunal Ghosh, Director, VSD Corp. Pvt. Ltd.
 - Dr.Murali, Co-ordinator(M.Tech), IIIT Bangalore.

### Contact Information
 - Vinay Rayapati,Post-Graduate student,International Institute of Information Technology Bangalore,vinayrayapati@outlook.com
 - Kunal Ghosh, Director, VSD Corp. Pvt. Ltd. kunalghosh@gmail.com
 - Dr.Murali, Co-ordinator(M.Tech), IIIT Bangalore,coordinator-mtech@iiitb.ac.in

