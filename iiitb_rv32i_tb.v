module verilog1;

reg clk;
integer k;

wire [31:0]WB_OUT,PC;

mips32 mips(clk,WB_OUT,PC);

initial clk=1'b1;

always #10 clk=!clk;

initial begin 

$dumpfile ("riscv_out.vcd"); //by default vcd
$dumpvars (0, verilog1);

for(k=0;k<32;k=k+1) 
mips.REG[k] <=k;

//mips.Reg[0] =0;
//mips.Reg[1] =1;
//mips.Reg[2] =2;
//mips.Reg[3] =3;
//mips.reg[4]=4;

mips.PC = 0;


mips.MEM[0] = 32'h00222000;        // add r4,r0,r1.(i1)
mips.MEM[1] = 32'h04432800;         //SUB R5,R2,R3.(i2)
mips.MEM[2] = 32'h10E60001;         //ADI R6,R7,IMM.(i3)


mips.MEM[3] = 32'h1D090001;  //st r8 r9 imm=1.(i4)

mips.MEM[4]=32'h190A0001; //lt r10 r8 imm=1.(i5)

mips.MEM[5]=32'h20000028;//(i6)


mips.MEM[47]=32'h01AE6000;//(i7)//add r12 r13,r14

#500 $finish;


end
endmodule
