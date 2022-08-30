
# iiitb_rv32i-risc-v rv32i

# Table of contents
 - [1.RISC-V RV32I](#1-RISC-V-RV32I)
 - [2.BLOCK DIAGRAM OF RISC-V RV32I](#2-BLOCK-DIAGRAM-OF-RISC-V-RV32I)
 - [3.INSTRUCTION SET OF RISC-V RV32I](#3-INSTRUCTION-SET-OF-RISC-V-RV32I)
 - [4.FUNCTIONAL SIMULATION](#4-FUNCTIONAL-SIMULATION)
    - [4.1 About iverilog and gtkwave](#41-About-iverilog-and-gtkwave)
    - [4.2 Installing iverilog and gtkwave](#42-Installing-iverilog-and-gtkwave)
    - [4.3 The output waveform](#43-The-output-waveform)
 - [5.SYNTHESIS](#5-SYNTHESIS)
    - [5.1 Synthesis](#51-Synthesis)
    - [5.2 Synthesizer](#52-Synthesizer)
 - [6.GATE LEVEL SIMULATION](#6-GATE-LEVEL-SIMULATION-(GLS))
 - [7.PHYSICAL DESIGN](#7-PHYSICAL-DESIGN)
    - [7.1 Openlane](#71-Openlane)
    - [7.2 Installation Instructions](#72-Installation-Instructions)
    - [7.3 Magic](#73-Magic)
    - [7.4 Generating Layout](#74-Generating-Layout)

## 1. RISC-V RV32I

This project provides an insight into the working of a few important instructions of the instruction set of a Single cycle Reduced Instruction Set Computer - Five(RISC-V) Instruction Set Architecture suitable for use across wide-spectrum of Applications from low power embedded devices to high performance Cloud based Server processors. The base RISC-V is a 32-bit processor with 31 general-purpose registers, so all the instructions are 32-bit long. Some Applications where the RISC-V processors have begun to make some significant threads are in Artificial intelligence and machine learning, Embedded systems, Ultra Low power processing systems etc.

## 2. BLOCK DIAGRAM OF RISC-V RV32I
![image](https://user-images.githubusercontent.com/110079631/181293948-beb8622c-7696-4b06-b6c9-eeab9b8ab9d3.png)

## 3. INSTRUCTION SET OF RISC-V RV32I
![image](https://user-images.githubusercontent.com/110079631/181298133-60269bc2-01da-4b5c-8b42-69057b8dc15c.png)

## 4. FUNCTIONAL SIMULATION

### 4.1 About iverilog and gtkwave
- Icarus Verilog is an implementation of the Verilog hardware description language.
- GTKWave is a fully featured GTK+ v1. 2 based wave viewer for Unix and Win32 which reads Ver Structural Verilog Compiler generated AET files as well as standard Verilog VCD/EVCD files and allows their viewing.

### 4.2 Installing iverilog and gtkwave

- **For Ubuntu**

 Open your terminal and type the following to install iverilog and GTKWave
 ```
 $   sudo apt get update
 $   sudo apt get install iverilog gtkwave
 ```

- **To clone the repository and download the netlist files for simulation , enter the following commands in your terminal.**

 ```
 $ git clone https://github.com/vinayrayapati/iiitb_rv32i
 $ cd iiitb_rv32i
 ```
- **To simulate and run the verilog code , enter the following commands in your terminal.**

```
$ iverilog -o iiitb_rv32i iiitb_rv32i.v iiitb_rv32i_tb.v
$ ./iiitb_rv32i
```
- **To see the output waveform in gtkwave, enter the following commands in your terminal.**

`$ gtkwave iiitb_rv32i.vcd`

### 4.3 The output waveform

 The output waveform showing the instructions performed in a 5-stage pipelined architecture.
 
 Instruction 1:add r6,r2,r1
 
 <img width="1282" alt="add r6 r1 r1" src="https://user-images.githubusercontent.com/110079631/183015273-602663b9-2160-4fae-8abb-9830bae4d313.png">

 Instruction 2:sub r7,r1,r2
 
<img width="1280" alt="sub r7 r1 r2" src="https://user-images.githubusercontent.com/110079631/183015332-c78f4f90-5809-46e4-b16e-2e57f1c99843.png">

 Instruction 3:and r8,r1,r3
 
<img width="1282" alt="and r8 r1 r3" src="https://user-images.githubusercontent.com/110079631/183015364-3276b933-ae6c-4732-80a6-7df250793fc5.png">

 Instruction 4:or r9,r2,r5
 
<img width="1294" alt="or r9 r2 r5" src="https://user-images.githubusercontent.com/110079631/183015379-fb008837-dc05-408f-830c-bb7a4b9f4161.png">

 Instruction 5:xor r10,r1,r4
 
 <img width="1293" alt="xor r10 r1 r4" src="https://user-images.githubusercontent.com/110079631/183015406-e0827f05-9f44-4145-873f-c0d033c79821.png">

 Instruction 6:slt r11,r2,r4
 
 <img width="1290" alt="slt r11 r2 r4" src="https://user-images.githubusercontent.com/110079631/183015434-d57f71e8-e785-4fac-9989-a45f49a2a23e.png">

 Instruction 7:addi r12,r4,5
 
 <img width="1285" alt="addi r12 r4 5" src="https://user-images.githubusercontent.com/110079631/183015460-f481f20e-16e3-42f6-8c79-1e3ed4227dd2.png">

 Instruction 8:sw r3,r1,2
 
 <img width="1280" alt="sw r3 r1 2" src="https://user-images.githubusercontent.com/110079631/183015497-a6878767-c8be-4a91-a3cb-b63aecc28346.png">

 Instruction 9:lw r13,r1,2
 
 <img width="1295" alt="lw r13 r1 2" src="https://user-images.githubusercontent.com/110079631/183015564-e0624f70-4007-49e0-a484-bfaf40b472b0.png">

 Instruction 10:beq r0,r0,15
 
 After branching, performing
 Instruction 11:add r14,r2,r2
 
 <img width="1287" alt="beq r0 r0 15 add r14 r2 r2" src="https://user-images.githubusercontent.com/110079631/183015593-549d8ce8-bf33-46de-aec0-d5cd825697d6.png">

 Instruction 12:bne r0,r1,20
 
 After branching, performing
 Instruction 13:addi r12,r4,5
 
 <img width="1287" alt="bne r0 r1 20 addi r12 r4 5" src="https://user-images.githubusercontent.com/110079631/183015635-313bc6b2-c3b7-4408-8816-029add92103f.png">

 Instruction 14:sll r15,r1,r2(2)
 
 <img width="1322" alt="sll r15 r1 r2(2)" src="https://user-images.githubusercontent.com/110079631/183015681-d14dd5b6-f7aa-4d36-ada8-a34a24eef091.png">

 Instruction 15:srl r16,r14,r2(2)
 
 <img width="1291" alt="srl r16 r14 r2(2)" src="https://user-images.githubusercontent.com/110079631/183015708-1a8708a7-3dc8-43fc-91c8-8ed09ff31a2a.png">

 Full 5-stage instruction pipeline and pc-increment description Waveform
 
 <img width="1325" alt="full-pipeline-description" src="https://user-images.githubusercontent.com/110079631/183015739-3666a275-557b-43a4-b024-542e0aeb7975.png">

## 5. SYNTHESIS

### 5.1 Synthesis: 
 Synthesis transforms the simple RTL design into a gate-level netlist with all the constraints as specified by the designer. In simple language, Synthesis is a process that converts the abstract form of design to a properly implemented chip in terms of logic gates.

Synthesis takes place in multiple steps:
- Converting RTL into simple logic gates.
- Mapping those gates to actual technology-dependent logic gates available in the technology libraries.
- Optimizing the mapped netlist keeping the constraints set by the designer intact.

### 5.2 Synthesizer: 
 It is a tool we use to convert out RTL design code to netlist. Yosys is the tool I've used in this project.

The commands to get the yosys is given belw:

```
git clone https://github.com/YosysHQ/yosys.git
make
sudo make install make test
```
Now you need to create a yosys_run.sh file , which is the yosys script file used to run the synthesis.
The contents of the yosys_run file are given below:

```
read_liberty -lib lib/sky130_fd_sc_hd__tt_025C_1v80.lib
read_verilog iiitb_rv32i.v
synth -top iiitb_rv32i	
dfflibmap -liberty lib/sky130_fd_sc_hd__tt_025C_1v80.lib
proc ; opt
abc -liberty lib/sky130_fd_sc_hd__tt_025C_1v80.lib
clean
flatten
write_verilog -noattr iiitb_rv32i_synth.v
```
Now, in the terminal of your verilog files folder, run the following commands:

```
yosys
script yosys_run.sh
```
Now the synthesized netlist is written in "iiitb_rv32i_synth.v" file.
## 6. GATE LEVEL SIMULATION(GLS)
GLS is generating the simulation output by running test bench with netlist file generated from synthesis as design under test. Netlist is logically same as RTL code, therefore, same test bench can be used for it.We perform this to verify logical correctness of the design after synthesizing it. Also ensuring the timing of the design is met.
Folllowing are the commands to run the GLS simulation:
```
iverilog -DFUNCTIONAL -DUNIT_DELAY=#1 ../verilog_model/primitives.v ../verilog_model/sky130_fd_sc_hd.v iiitb_rv32i_synth.v iiitb_rv32i_tb.v
./a.out
gtkwave iiitb_rv32i.vcd
```
The gtkwave output for the netlist should match the output waveform for the RTL design file. As netlist and design code have same set of inputs and outputs, we can use the same testbench and compare the waveforms.

The output waveform of the synthesized netlist given below:
<img width="1130" alt="Screenshot 2022-08-16 at 8 44 34 AM" src="https://user-images.githubusercontent.com/110079631/184832803-7b35ffc3-8dcd-4aa4-a214-bd360100f7e8.png">

## 7. PHYSICAL DESIGN 

### 7 . 1 Overview of Physical Design flow
Place and Route (PnR) is the core of any ASIC implementation and Openlane flow integrates into it several key open source tools which perform each of the respective stages of PnR.
Below are the stages and the respective tools (in ( )) that are called by openlane for the functionalities as described:
- Synthesis
  - Generating gate-level netlist ([yosys](https://github.com/YosysHQ/yosys)).
  - Performing cell mapping ([abc](https://github.com/YosysHQ/yosys)).
  - Performing pre-layout STA ([OpenSTA](https://github.com/The-OpenROAD-Project/OpenSTA)).
- Floorplanning
  - Defining the core area for the macro as well as the cell sites and the tracks ([init_fp](https://github.com/The-OpenROAD-Project/OpenROAD/tree/master/src/init_fp)).
  - Placing the macro input and output ports ([ioplacer](https://github.com/The-OpenROAD-Project/ioPlacer/)).
  - Generating the power distribution network ([pdn](https://github.com/The-OpenROAD-Project/pdn/)).
- Placement
  - Performing global placement ([RePLace](https://github.com/The-OpenROAD-Project/RePlAce)).
  - Perfroming detailed placement to legalize the globally placed components ([OpenDP](https://github.com/The-OpenROAD-Project/OpenDP)).
- Clock Tree Synthesis (CTS)
  - Synthesizing the clock tree ([TritonCTS](https://github.com/The-OpenROAD-Project/OpenROAD/tree/master/src/TritonCTS)).
- Routing
  - Performing global routing to generate a guide file for the detailed router ([FastRoute](https://github.com/The-OpenROAD-Project/FastRoute/tree/openroad)).
  - Performing detailed routing ([TritonRoute](https://github.com/The-OpenROAD-Project/TritonRoute))
- GDSII Generation
  - Streaming out the final GDSII layout file from the routed def ([Magic](https://github.com/RTimothyEdwards/magic)).

### 7 . 2 Openlane
OpenLane is an automated RTL to GDSII flow based on several components including OpenROAD, Yosys, Magic, Netgen, CVC, SPEF-Extractor, CU-GR, Klayout and a number of custom scripts for design exploration and optimization. The flow performs full ASIC implementation steps from RTL all the way down to GDSII.

more at https://github.com/The-OpenROAD-Project/OpenLane
### 7 . 3 Installation instructions 
```
$   apt install -y build-essential python3 python3-venv python3-pip
```
Docker installation process: https://docs.docker.com/engine/install/ubuntu/

goto home directory->
```
$   git clone https://github.com/The-OpenROAD-Project/OpenLane.git
$   cd OpenLane/
$   sudo make
```
To test the open lane
```
$ sudo make test
```
It takes approximate time of 5min to complete. After 43 steps, if it ended with saying **Basic test passed** then open lane installed succesfully.

### 7 . 4 Magic
Magic is a venerable VLSI layout tool, written in the 1980's at Berkeley by John Ousterhout, now famous primarily for writing the scripting interpreter language Tcl. Due largely in part to its liberal Berkeley open-source license, magic has remained popular with universities and small companies. The open-source license has allowed VLSI engineers with a bent toward programming to implement clever ideas and help magic stay abreast of fabrication technology. However, it is the well thought-out core algorithms which lend to magic the greatest part of its popularity. Magic is widely cited as being the easiest tool to use for circuit layout, even for people who ultimately rely on commercial tools for their product design flow.

More about magic at http://opencircuitdesign.com/magic/index.html

Run following commands one by one to fulfill the system requirement.

```
$   sudo apt-get install m4
$   sudo apt-get install tcsh
$   sudo apt-get install csh
$   sudo apt-get install libx11-dev
$   sudo apt-get install tcl-dev tk-dev
$   sudo apt-get install libcairo2-dev
$   sudo apt-get install mesa-common-dev libglu1-mesa-dev
$   sudo apt-get install libncurses-dev
```
**To install magic**
goto home directory

```
$   git clone https://github.com/RTimothyEdwards/magic
$   cd magic/
$   ./configure
$   sudo make
$   sudo make install
```
type **magic** terminal to check whether it installed succesfully or not. type **exit** to exit magic.

### 7 . 5 Generating Layout

**NON-INTERACTIVE MODE**

Open terminal in home directory
```
$   cd OpenLane/
$   cd designs/
$   mkdir iiitb_iiitb_rv32i
$   cd iiitb_iiitb_rv32i/
$   wget https://raw.githubusercontent.com/vinayrayapati/iiitb_rv32i/main/config.json
$   mkdir src
$   cd src/
$   wget https://raw.githubusercontent.com/vinayrayapati/iiitb_rv32i/main/iiitb_rv32i.v
$   cd ../../../
$   sudo make mount
$   ./flow.tcl -design iiitb_rv32i
```
To see the layout we use a tool called magic which we installed earlier.Type the following command in the terminal opened in the path to your design/runs/latest run folder/final/def/
 
```
$   magic -T /home/parallels/Desktop/OpenLane/pdks/sky130A/libs.tech/magic/sky130A.tech lef read ../../../tmp/merged.max.lef def read iiitb_rv32i.def &
```

The final layout:

<img width="622" alt="Screenshot 2022-08-25 at 8 36 51 AM" src="https://user-images.githubusercontent.com/110079631/186565327-8da1d083-e54e-4a39-ad09-21ea755d8f3b.png">

### 7 . 6 Customizing the layout

Here we are going to customise our layout by including our custom made **sky130_vsdinv cell** into our layout.

- ***CREATING THE SKY130_VSDINV CELL LEF FILE***
   - You need to first get the git repository of the **vsdstdccelldesign**.To get the repository type the following command:

     ``` git clone https://github.com/nickson-jose/vsdstdcelldesign.git ```
   - Now you need to copy your tech file **sky130A.tech** to this folder.
   - Next run the magic command to open the **sky130_vsdinv.mag** file.Use the following command:
     
     ``` magic -T sky130A.tech sky130_vsdinv.mag& ```
     
     * One can zoom into Magic layout by selecting an area with left and right mouse click followed by pressing "z" key. 
     * Various components can be identified by using the ```what``` command in tkcon window after making a selection on the component.
     
     The image showing the invoked magic tool using the above command:
     
     ![Screenshot from 2022-08-30 18-04-31](https://user-images.githubusercontent.com/110079631/187439712-1d3dcbbd-8b00-4eae-a78e-4f19694d4234.png)

   - The next step is setting port class and port use attributes. The "class" and "use" properties of the port have no internal meaning to magic but are used by the LEF and DEF format read and write routines, and match the LEF/DEF CLASS and USE properties for macro cell pins. Valid classes are: default, input, output, tristate, bidirectional, inout, feedthrough, and feedthru. Valid uses are: default, analog, signal, digital, power, ground, and clock. These attributes are set in tkcon window (after selecting each port on layout window. A keyboard shortcut would be repeatedly pressing **s** till that port gets highlighed).
     The tkcon command window of the port classification is shown in the image below:
          
     ![port_define](https://user-images.githubusercontent.com/110079631/187438423-d08803fb-2375-495b-9de7-c46a2aadda00.JPG)
    
   - In the next step, use `lef write` command to write the LEF file with the same nomenclature as that of the layout (.mag) file.This will create a **sky130_vsdinv.lef** file in the same folder.
   
      ![lef_write](https://user-images.githubusercontent.com/110079631/187439794-340e3c4d-65fc-48ad-8c2b-12ee5054e69f.PNG)
               
- ***INCLUDING THE SKY130_VSDINV CELL***

   - You need to copy the **lib** files and the created **sky130_vsinv.lef** file to your design src directory.The src directory image with its contents is shown below:
     
     ![Screenshot from 2022-08-30 18-07-41](https://user-images.githubusercontent.com/110079631/187441835-503799ab-801f-4d41-b943-45b3202a7beb.png)

   - Next,Modify the json file by including the following lines:

     ```
     "PL_RANDOM_GLB_PLACEMENT": 1,
     "PL_TARGET_DENSITY": 0.5,
     "FP_SIZING": "relative",
     "LIB_SYNTH":"dir::src/sky130_fd_sc_hd__typical.lib",
     "LIB_FASTEST":"dir::src/sky130_fd_sc_hd__fast.lib",
     "LIB_SLOWEST":"dir::src/sky130_fd_sc_hd__slow.lib",
     "LIB_TYPICAL":"dir::src/sky130_fd_sc_hd__typical.lib",
     "TEST_EXTERNAL_GLOB":"dir::../iiitb_rv32i/src/*",
     "SYNTH_DRIVING_CELL":"sky130_vsdinv"
     ```
 - ***INTERACTIVE MODE***
 We need to run the openlane now in the interactive mode to include our custom made lef file before synthesis.Such that the openlane recognises our lef files during the flow for mapping.
      - **1. Running openlane in interactive mode**
      
        The commands to the run the flow in interactive mode is given below:
        ```
        cd OpenLane
        sudo make mount
        ./flow.tcl -interactive
        ```
      - **2. Preparing the design and including the lef files**
        The commands to prepare the design and overwite in a existing run folder the reports and results along with the command to include the lef files is given below:
        ```
        prep -design iiitb_rv32i -tag run -overwrite
        set lefs [glob $::env(DESIGN_DIR)/src/*.lef]
        add_lefs -src $lefs
        ```
      - **3. SYNTHESIS**
        
         * The command to run the synthesis is ```run_synthesis```.This runs the synthesis where yosys translates RTL into circuit using generic components and abc maps the circuit to Standard Cells.
      
         * The synthesized netlist is present in the results folder and the stats are present in the reports folder as shown below:
        
           ![stat_syn](https://user-images.githubusercontent.com/110079631/187448071-82e73b3c-2e9e-4f10-b636-a13bdb566986.png)

         * Calcuation of Flop Ratio:
  
           ```
  
           Flop ratio = Number of D Flip flops 
                        ______________________
                        Total Number of cells
  
           ```
        
         * The slack report including the **sky130_vsdinv** cell is shown below:
        
           ![slack_vsd_syn](https://user-images.githubusercontent.com/110079631/187448346-260fb8ff-eef9-47b4-9096-facc01f395e3.png)
        
      - **4. FLOORPLAN**
      
         * Importance of files in increasing priority order:

           1. ```floorplan.tcl``` - System default envrionment variables
           2. ```conifg.tcl```
           3. ```sky130A_sky130_fd_sc_hd_config.tcl```
        
         * Floorplan envrionment variables or switches:

           1. ```FP_CORE_UTIL``` - floorplan core utilisation
           2. ```FP_ASPECT_RATIO``` - floorplan aspect ratio
           3. ```FP_CORE_MARGIN``` - Core to die margin area
           4. ```FP_IO_MODE``` - defines pin configurations (1 = equidistant/0 = not equidistant)
           5. ```FP_CORE_VMETAL``` - vertical metal layer
           6. ```FP_CORE_HMETAL``` - horizontal metal layer
           
           ```Note: Usually, vertical metal layer and horizontal metal layer values will be 1 more than that specified in the file```
        
         * To run the Floorplan use the command `run_floorplan`.
        
         * Post the floorplan run, a `.def` file will have been created within the `results/floorplan` directory. 
           We may review floorplan files by checking the `floorplan.tcl`. 
           The system defaults will have been overriden by switches set in `conifg.tcl` and further overriden by switches set in `sky130A_sky130_fd_sc_hd_config.tcl`.
        
         * To view the floorplan, Magic is invoked after moving to the ```results/floorplan``` directory,then use the floowing command:
           ```
           magic -T /home/vinay/OpenLane/pdks/sky130A/libs.tech/magic/sky130A.tech lef read ../../tmp/merged.nom.lef def read iiitb_rv32i.def &
           ```
         * 
      - **5. PLACEMENT**
         
         * The next step in the OpenLANE ASIC flow is placement. The synthesized netlist is to be placed on the floorplan. Placement is perfomed in 2 stages:
           1. Global Placement: It finds optimal position for all cells which may not be legal and cells may overlap. Optimization is done through reduction of half parameter wire length.
           2. Detailed Placement: It alters the position of cells post global placement so as to legalise them.
         
         * To run the Placement use the command `run_Placement`.
         
         * Post placement, the design can be viewed on magic within ```results/placement``` directory.
           Run the follwing command in that directory:
           ```
           magic -T /home/vinay/OpenLane/pdks/sky130A/libs.tech/magic/sky130A.tech lef read ../../tmp/merged.nom.lef def read iiitb_rv32i.def &
           ```
         
  
The included vsdinv cell in the layout is :
![image](https://user-images.githubusercontent.com/110079631/187410184-f18d0cbd-0b8c-434b-8267-c12dccce1d41.png)

               

### Author
 - **Vinay Rayapati**

### Contributors
 - Vinay Rayapati
 - Kunal Ghosh

### Acknowledgments
 - Kunal Ghosh, Director, VSD Corp. Pvt. Ltd.
 - Dr.Murali, Co-ordinator(M.Tech), IIIT Bangalore.
 - Dr.Madhav Rao, ECE Department, IIIT Bangalore.

### References
 - Jim Ledin “Modern Computer Architecture and Organisation" (2022)

### Contact Information
 - Vinay Rayapati,Post-Graduate student,International Institute of Information Technology Bangalore,vinayrayapati@outlook.com
 - Kunal Ghosh, Director, VSD Corp. Pvt. Ltd.,kunalghosh@gmail.com
 - Dr.Murali, Co-ordinator(M.Tech), IIIT Bangalore,coordinator-mtech@iiitb.ac.in
 - Dr.Madhav Rao, ECE Department, IIIT Bangalore,mr@iiitb.ac.in

