module iiitb_rv32i_tb;

reg clk;
integer k;

wire [31:0]WB_OUT,PC;

iiitb_rv32i rv32(clk,WB_OUT,PC);

initial clk=1'b1;

always #10 clk=!clk;

initial begin 

  $dumpfile ("iiitb_rv32i.vcd"); //by default vcd
  $dumpvars (0, iiitb_rv32i_tb);

for(k=0;k<32;k=k+1) 
rv32.REG[k] <=k;

//rv32.Reg[0] =0;
//rv32.Reg[1] =1;
//rv32.Reg[2] =2;
//rv32.Reg[3] =3;
//rv32.reg[4]=4;

rv32.PC = 0;


rv32.MEM[0] = 32'h00222000;        // add r4,r0,r1.(i1)
rv32.MEM[1] = 32'h04432800;         //SUB R5,R2,R3.(i2)
rv32.MEM[2] = 32'h10E60001;         //ADI R6,R7,IMM.(i3)


rv32.MEM[3] = 32'h1D090001;  //st r8 r9 imm=1.(i4)

rv32.MEM[4]=32'h190A0001; //lt r10 r8 imm=1.(i5)

rv32.MEM[5]=32'h20000028;//(i6)


rv32.MEM[47]=32'h01AE6000;//(i7)//add r12 r13,r14

#500 $finish;


end
endmodule
