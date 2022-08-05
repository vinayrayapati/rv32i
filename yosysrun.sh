# read design

read_verilog iiitb_rv32i.v

# generic synthesis
synth -top iiitb_rv32i

# mapping to mycells.lib
dfflibmap -liberty /Users/vinayrayapati/Desktop/Vinay/RISC-V/iiitb_rv32i-main/lib/sky130_fd_sc_hd__tt_025C_1v80.lib
proc; opt
abc -liberty /Users/vinayrayapati/Desktop/Vinay/RISC-V/iiitb_rv32i-main/lib/sky130_fd_sc_hd__tt_025C_1v80.lib -script +strash;scorr;ifraig;retime,{D};strash;dch,-f;map,-M,1,{D}
clean
flatten
# write synthesized design
write_verilog -noattr iiitb_rv32i_synth.v
