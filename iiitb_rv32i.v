module iiitb_rv32i(clk,WB_OUT,PC);
input clk;
reg[31:0] IF_ID_IR,IF_ID,IF_ID_NPC;                                //I_FETCH STAGE

reg[31:0] ID_EX_A,ID_EX_B,ID_EX_IMMEDIATE,ID_EX_IR,ID_EX_NPC;      //I_DECODE STAGE

reg[31:0] EX_MEM_COND,EX_MEM_ALUOUT,EX_MEM_B,EX_MEM_IR;            //EXECUTION STAGE

parameter ADD=3'd0,SUB=3'd1,AND=3'd2,OR=3'd3,XOR=3'd4,ADDI=3'd0,LW=3'd0,SW=3'd1,BEQ=3'd0,BNE=3'd1,SLL=3'd0,SRL=3'd1,SLT=3'd5;

parameter RR_TYPE=7'd0,RM_TYPE=7'd1,BR_TYPE=7'd2,SH_TYPE=7'd3,M_TYPE=7'd4;


reg[31:0] MEM_WB_IR,MEM_WB_ALUOUT,MEM_WB_LDM;                      //MEMORY STAGE


output reg [31:0]WB_OUT,PC;

reg [31:0]REG[0:31];                                               //REG FILE

reg [31:0]MEM[0:1023];                                             //1024*32 IMEM

reg [31:0]DM[0:1023];                                              //1024*32 DMEM



//I_FECT STAGE

always@(posedge clk) begin

if(EX_MEM_COND==1 && EX_MEM_IR[6:0]==BR_TYPE) begin
PC=EX_MEM_ALUOUT;
IF_ID=MEM[PC];
end

else begin
PC<=PC+1;
IF_ID<=MEM[PC];
IF_ID_NPC<=PC+1;
end
end


always @(posedge clk) begin

IF_ID_IR <= IF_ID;

end
//FETCH STAGE END

//I_DECODE STAGE 
always @(posedge clk) begin

ID_EX_A <= REG[IF_ID_IR[19:15]];
ID_EX_B <= REG[IF_ID_IR[24:20]];
ID_EX_IR <= IF_ID_IR;
ID_EX_IMMEDIATE <= {{20{IF_ID_IR[31]}},IF_ID_IR[31:20]};
ID_EX_NPC<=IF_ID_NPC;
end
//DECODE STAGE END


//EXECUTION STAGE

always@(posedge clk) begin

EX_MEM_IR <=  ID_EX_IR;

case(ID_EX_IR[6:0])

RR_TYPE:begin
case(ID_EX_IR[14:12])

ADD:EX_MEM_ALUOUT <= ID_EX_A + ID_EX_B;
SUB:EX_MEM_ALUOUT <= ID_EX_A - ID_EX_B;
AND:EX_MEM_ALUOUT <= ID_EX_A & ID_EX_B;
OR :EX_MEM_ALUOUT <= ID_EX_A | ID_EX_B;
XOR:EX_MEM_ALUOUT <= ID_EX_A ^ ID_EX_B;
SLT:EX_MEM_ALUOUT <= (ID_EX_A < ID_EX_B) ? 32'b1 : 32'b0;

endcase
end

RM_TYPE:begin
case(ID_EX_IR[14:12])
ADDI:EX_MEM_ALUOUT <= ID_EX_A + ID_EX_IMMEDIATE;
endcase
end

BR_TYPE:begin
case(ID_EX_IR[14:12])
BEQ:begin 
EX_MEM_ALUOUT <= ID_EX_NPC+ID_EX_IMMEDIATE;
EX_MEM_COND <= (ID_EX_A == ID_EX_IR[11:7])?1:0;
end
BNE:begin 
EX_MEM_ALUOUT <= ID_EX_NPC+ID_EX_IMMEDIATE;
EX_MEM_COND <= (ID_EX_A != ID_EX_IR[11:7])?1:0;
end
endcase
end

SH_TYPE:begin
case(ID_EX_IR[14:12])
SLL:EX_MEM_ALUOUT <= ID_EX_A << ID_EX_B;
SRL:EX_MEM_ALUOUT <= ID_EX_A >> ID_EX_B;
endcase
end

M_TYPE:begin
case(ID_EX_IR[14:12])
LW  :EX_MEM_ALUOUT <= ID_EX_A + ID_EX_IMMEDIATE;
SW  :EX_MEM_ALUOUT <= ID_EX_IR[24:20] +ID_EX_IR[19:15];
endcase
end

endcase
end


//EXECUTION STAGE END
		
//MEMORY STAGE
always@(posedge clk) begin

MEM_WB_IR <= EX_MEM_IR;

case(EX_MEM_IR[6:0])

RR_TYPE:MEM_WB_ALUOUT <=  EX_MEM_ALUOUT;
RM_TYPE:MEM_WB_ALUOUT <=  EX_MEM_ALUOUT;
SH_TYPE:MEM_WB_ALUOUT <=  EX_MEM_ALUOUT;

M_TYPE:begin
case(EX_MEM_IR[14:12])
LW:MEM_WB_LDM = DM[EX_MEM_ALUOUT];
SW:DM[EX_MEM_ALUOUT]<=REG[EX_MEM_IR[11:7]];
endcase
end

endcase
end

// MEMORY STAGE END


//WRITE BACK STAGE
always@(posedge clk) begin

case(MEM_WB_IR[6:0])

RR_TYPE:begin 
WB_OUT=MEM_WB_ALUOUT;
REG[MEM_WB_IR[11:7]]=WB_OUT;
end

RM_TYPE:begin
case(MEM_WB_IR[14:12])
ADDI:begin
WB_OUT=MEM_WB_ALUOUT;
REG[MEM_WB_IR[11:7]]=WB_OUT;
end
endcase
end

SH_TYPE:begin
WB_OUT=MEM_WB_ALUOUT;
REG[MEM_WB_IR[11:7]]=WB_OUT;
end

M_TYPE:begin
case(MEM_WB_IR[14:12])
LW:begin
WB_OUT=MEM_WB_LDM;
REG[MEM_WB_IR[11:7]]=WB_OUT;
end
endcase
end



endcase
end
//WRITE BACK STAGE END

endmodule
