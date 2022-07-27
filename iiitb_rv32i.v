module mips32(clk,WB_OUT,PC);
input clk;
reg[31:0] IF_ID_IR,IF_ID,IF_ID_NPC;//instruction fetch stage

reg[31:0] ID_EX_A,ID_EX_B,ID_EX_IMMEDIATE,ID_EX_IR,ID_EX_NPC;//instruction decode

reg[2:0] ID_EX_TYPE,EX_MEM_TYPE,MEM_WB_TYPE;//TYPES 

reg[31:0] EX_MEM_COND,EX_MEM_ALUOUT,EX_MEM_B,EX_MEM_IR;//EXECUTION stage 

parameter ADD=6'd0,SUB=6'd1,MUL=6'd2,DIV=6'd3,ADDI=6'd4,SUBI=6'd5,LOAD=6'd6,STORE=6'd7,BRANCH=6'd8;

parameter RR_ALU=3'd0,RM_ALU=3'd1,L_ALU=3'd2,ST_ALU=3'd3,BR_ALU=3'd4;


reg[31:0] MEM_WB_IR,MEM_WB_ALUOUT,MEM_WB_LDM,MEM_WB_SDM;//MEMORY  stage


output reg [31:0]WB_OUT,PC;

reg [31:0]REG[0:31];//register bank

reg [31:0]MEM[0:1023];//1024*32  instruction memory

reg [31:0]DM[0:1023];//1024*32 DATA MEMORY



//instruction fetch stage
always@(posedge clk) begin

if(EX_MEM_COND && EX_MEM_IR[31:26]==BRANCH) begin
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
//fetch end

//instruction decode stage
always @(posedge clk) begin

ID_EX_A <= REG[IF_ID_IR[25:21]];
ID_EX_B <= REG[IF_ID_IR[20:16]];
ID_EX_IR <= IF_ID_IR;
ID_EX_IMMEDIATE <= {{16{IF_ID_IR[15]}},IF_ID_IR[15:0]};
ID_EX_NPC<=IF_ID_NPC;

case(IF_ID_IR[31:26])

ADD,SUB,MUL,DIV: ID_EX_TYPE <=  RR_ALU;
ADDI,SUBI:ID_EX_TYPE <= RM_ALU;
LOAD:ID_EX_TYPE <= L_ALU;
STORE:ID_EX_TYPE <= ST_ALU;
BRANCH:ID_EX_TYPE <= BR_ALU;

endcase

end
//decode stage completion


//execution stage

always@(posedge clk) begin

EX_MEM_TYPE <= ID_EX_TYPE;
EX_MEM_IR <=  ID_EX_IR;
EX_MEM_B <= ID_EX_B;

case(ID_EX_TYPE)

RR_ALU:begin
case(ID_EX_IR[31:26])

ADD:EX_MEM_ALUOUT <= ID_EX_A + ID_EX_B;
SUB:EX_MEM_ALUOUT <= ID_EX_A - ID_EX_B;
MUL:EX_MEM_ALUOUT <= ID_EX_A * ID_EX_B;
DIV:EX_MEM_ALUOUT <= ID_EX_A / ID_EX_B;

endcase
end

RM_ALU:begin
case(ID_EX_IR[31:26])
ADDI:EX_MEM_ALUOUT <= ID_EX_A + ID_EX_IMMEDIATE;
SUBI:EX_MEM_ALUOUT <= ID_EX_A - ID_EX_IMMEDIATE;
endcase
end

L_ALU:begin
case(ID_EX_IR[31:26])
LOAD:EX_MEM_ALUOUT <= ID_EX_A + ID_EX_IMMEDIATE;
endcase
end

ST_ALU:begin
case(ID_EX_IR[31:26])
STORE:EX_MEM_ALUOUT <= ID_EX_A + ID_EX_IMMEDIATE;
endcase
end

BR_ALU:begin
case(ID_EX_IR[31:26])
BRANCH:begin 
EX_MEM_ALUOUT <= ID_EX_NPC+ID_EX_IMMEDIATE;
EX_MEM_COND <= (ID_EX_A == ID_EX_B)?1:0;
end
endcase
end

endcase
end


//execution stage ending
		
//memory stage
always@(posedge clk) begin

MEM_WB_TYPE <= EX_MEM_TYPE;
MEM_WB_IR <= EX_MEM_IR;

case(EX_MEM_TYPE)

RR_ALU,RM_ALU:MEM_WB_ALUOUT <=  EX_MEM_ALUOUT;

L_ALU:MEM_WB_LDM <= DM[EX_MEM_ALUOUT];

ST_ALU:begin
DM[EX_MEM_ALUOUT]<=REG[EX_MEM_IR[20:16]];
end

endcase
end



//write back stage
always@(posedge clk) begin

case(MEM_WB_TYPE)

RR_ALU:begin 
WB_OUT<=MEM_WB_ALUOUT;
REG[MEM_WB_IR[15:11]]<=WB_OUT;
end


RM_ALU:begin
WB_OUT<=MEM_WB_ALUOUT;
REG[MEM_WB_IR[20:16]]<=WB_OUT;
end


L_ALU:begin
WB_OUT<=MEM_WB_LDM;
REG[MEM_WB_IR[20:16]]<=WB_OUT;
end


endcase
end

endmodule
