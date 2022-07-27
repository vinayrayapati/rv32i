
### iiitb_rv32i-risc-v rv32i


## RISC-V RV32I

# To clone the repository and download the netlist files for simulation , enter the following commands in your terminal.

> $ git clone https://github.com/vinayrayapati/iiitb_rv32i
> $ cd iiitb_rv32i

# To simulate and run the verilog code , enter the following commands in your terminal.

> $ iverilog -o iiitb_rv32i iiitb_rv32i.v iiitb_rv32i_tb.v
> $ ./iiitb_rv32i

# To see the output waveform in gtkwave, enter the following commands in your terminal.

> $ gtkwave iiitb_rv32i.vcd
