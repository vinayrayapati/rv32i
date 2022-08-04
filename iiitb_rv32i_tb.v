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

rv32.PC = 0;


rv32.MEM[0] = 32'h00208300;         // add r6,r1,r2.(i1)
rv32.MEM[1] = 32'h00209380;         //sub r7,r1,r2.(i2)
rv32.MEM[2] = 32'h0030a400;         //and r8,r1,r3.(i3)
rv32.MEM[3] = 32'h00513480;         //or r9,r2,r5.(i4)
rv32.MEM[4] = 32'h0040c500;         //xor r10,r1,r4.(i5)
rv32.MEM[5] = 32'h00415580;         //slt r11,r2,r4.(i6)
rv32.MEM[6] = 32'h00520601;         //addi r12,r4,5.(i7)
rv32.MEM[7] = 32'h00209184;         //sw r3,r1,2.(i8)
rv32.MEM[8] = 32'h00208684;         //lw r13,r1,2.(i9)
rv32.MEM[9] = 32'h00f00002;         //beq r0,r0,15.(i10)
rv32.MEM[26] = 32'h00210700;         //add r14,r2,r2.(i11)
rv32.MEM[27] = 32'h01409002;         //bne r0,r1,20.(i12)
rv32.MEM[49] = 32'h00520601;         //addi r12,r4,5.(i13)
rv32.MEM[50] = 32'h00208783;         //sll r15,r1,r2(2).(i14)
rv32.MEM[51] = 32'h00271803;         //srl r16,r14,r2(2).(i15)



#2000 $finish;


end
endmodule
