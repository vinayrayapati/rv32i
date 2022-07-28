# read design

read_verilog iiitb_rv32i.v

# generic synthesis
synth -top iiitb_rv32i

# mapping to mycells.lib
dfflibmap -liberty /home/vinay.r/Desktop/iiitb_rv32i/lib/sky130_fd_sc_hd__tt_025C_1v80.lib
abc -liberty /home/vinay.r/Desktop/iiitb_rv32i/lib/sky130_fd_sc_hd__tt_025C_1v80.lib
clean
flatten
# write synthesized design
write_verilog -noattr iiitb_rv32i_synth.v
