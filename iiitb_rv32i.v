module iiitb_rv32i(clk,RN,NPC,WB_OUT);
input clk;
input RN;
//input EN;
integer k;
reg  EX_MEM_COND ;

reg 
BR_EN;

//I_FETCH STAGE
reg[31:0] 
IF_ID_IR,
IF_ID,IF_ID_NPC;                                

//I_DECODE STAGE
reg[31:0] 
ID_EX_A,
ID_EX_B,
ID_EX_RD,
ID_EX_IMMEDIATE,
ID_EX_IR,ID_EX_NPC;      

//EXECUTION STAGE
reg[31:0] 
EX_MEM_ALUOUT,
EX_MEM_B,EX_MEM_IR;                        

parameter 
ADD=3'd0,
SUB=3'd1,
AND=3'd2,
OR=3'd3,
XOR=3'd4,
ADDI=3'd0,
LW=3'd0,
SW=3'd1,
BEQ=3'd0,
BNE=3'd1,
SLL=3'd0,
SRL=3'd1,
SLT=3'd5;

parameter 
RR_TYPE=7'd0,
RM_TYPE=7'd1,
BR_TYPE=7'd2,
SH_TYPE=7'd3,
M_TYPE=7'd4;

//MEMORY STAGE
reg[31:0] 
MEM_WB_IR,
MEM_WB_ALUOUT,
MEM_WB_LDM;                      


output reg [31:0]WB_OUT,NPC;

//REG FILE
reg [31:0]REG[0:31];                                               
//64*32 IMEM
reg [31:0]MEM[0:31];                                             
//64*32 DMEM
reg [31:0]DM[0:31];   


//assign EX_MEM_COND = (ID_EX_IR[6:0]==BR_TYPE) ? 1'b1 : 1'b0;
                     //1'b1 ? (ID_EX_A!=ID_EX_RD) : 1'b0;

always @(posedge clk or posedge RN) begin
    if(RN) begin
    NPC<= 32'd0;
    //EX_MEM_COND <=1'd0;
    BR_EN<= 1'd0; 
    REG[0] <= 32'h00000000;
    REG[1] <= 32'd1;
    REG[2] <= 32'd2;
    REG[3] <= 32'd3;
    REG[4] <= 32'd4;
    REG[5] <= 32'd5;
    REG[6] <= 32'd6;
    end
    //else if(EX_MEM_COND)
    //NPC <= EX_MEM_ALUOUT;

    else if (BR_EN)begin
    NPC = EX_MEM_COND ? EX_MEM_ALUOUT : NPC +32'd1;
    //EX_MEM_COND = BR_EN;
    //NPC = BR_EN ? EX_MEM_ALUOUT : NPC +32'd1;
    BR_EN = 1'd0;
    //EX_MEM_COND <= 1'd0;
    end
    else begin
        NPC <= NPC +32'd1;
    //EX_MEM_COND <=1'd0;
    IF_ID <=MEM[NPC];
    IF_ID_NPC <=NPC+32'd1;
    end
end

always @(posedge RN) begin

MEM[0] <= 32'h00208300;         // add r6,r1,r2.(i1)
MEM[1] <= 32'h00209380;         //sub r7,r1,r2.(i2)
MEM[2] <= 32'h0030a400;         //and r8,r1,r3.(i3)
MEM[3] <= 32'h00513480;         //or r9,r2,r5.(i4)
MEM[4] <= 32'h0040c500;         //xor r10,r1,r4.(i5)
MEM[5] <= 32'h00415580;         //slt r11,r2,r4.(i6)
MEM[6] <= 32'h00520601;         //addi r12,r4,5.(i7)
MEM[7] <= 32'h00209184;         //sw r3,r1,2.(i8)
MEM[8] <= 32'h00208684;         //lw r13,r1,2.(i9)
MEM[9] <= 32'h00f00002;         //beq r0,r0,15.(i10)
MEM[26] <= 32'h00210700;         //add r14,r2,r2.
MEM[27] <= 32'h00208783;         //sll r15,r1,r2(2).(i14)
MEM[28] <= 32'h00271803;         //srl r16,r14,r2(2).(i15) 

end
//I_FECT STAGE


always @(posedge clk) begin

IF_ID_IR <= IF_ID;

end
//FETCH STAGE END

//I_DECODE STAGE 
always @(posedge clk) begin

ID_EX_A <= REG[IF_ID_IR[19:15]];
ID_EX_B <= REG[IF_ID_IR[24:20]];
ID_EX_RD <= REG[IF_ID_IR[11:7]];
ID_EX_IR <= IF_ID_IR;
ID_EX_IMMEDIATE <= {{20{IF_ID_IR[31]}},IF_ID_IR[31:20]};
ID_EX_NPC<=IF_ID_NPC;
end
//DECODE STAGE END



//EXECUTION STAGE

always@(posedge clk) begin

EX_MEM_IR <=  ID_EX_IR;
EX_MEM_COND <= (ID_EX_IR[6:0] == BR_TYPE) ? 1'd1 :1'd0;


case(ID_EX_IR[6:0])

RR_TYPE:begin
case(ID_EX_IR[14:12])

ADD:EX_MEM_ALUOUT <= ID_EX_A + ID_EX_B;
SUB:EX_MEM_ALUOUT <= ID_EX_A - ID_EX_B;
AND:EX_MEM_ALUOUT <= ID_EX_A & ID_EX_B;
OR :EX_MEM_ALUOUT <= ID_EX_A | ID_EX_B;
XOR:EX_MEM_ALUOUT <= ID_EX_A ^ ID_EX_B;
SLT:EX_MEM_ALUOUT <= (ID_EX_A < ID_EX_B) ? 32'd1 : 32'd0;

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
BR_EN <= 1'd1 ? (ID_EX_IR[19:15] == ID_EX_IR[11:7]) : 1'd0;
//BR_PC = EX_MEM_COND ? EX_MEM_ALUOUT : 1'd0; 
end
BNE:begin 
EX_MEM_ALUOUT <= ID_EX_NPC+ID_EX_IMMEDIATE;
BR_EN <= (ID_EX_IR[19:15] != ID_EX_IR[11:7]) ? 1'd1 : 1'd0;
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
