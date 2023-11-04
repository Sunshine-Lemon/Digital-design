`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/10/07 21:38:45
// Design Name: 
// Module Name: AIU
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module ALU(
    input [3:0] A,
    input [3:0] B,
    input [1:0] op,
    input CLK100MHZ,
    
    output DP,
    output reg [7:0]AN,
    output reg [6:0] segment
    );
     reg [7:0]  F;
    wire[7:0] x;
    wire clr;
    wire [2:0] s;
    reg[3:0]digit;
    reg[19:0] clkdiv;
  reg [2:0]i;
  reg [7:0] accumulator; // 累积器
   reg [4:0] sum; // 中间结果寄存器
  reg [4:0] carry; // 进位寄存器
  assign clr=0;
  assign s=clkdiv[19:17];
    assign DP=1;
    assign x=F;
  
  //8位 8选一前6位都是0
  always @(s)
  case(s)
  0:digit=x[3:0];
  1:digit=x[7:4];
       default: digit=0; 
  endcase
  //选中并点亮
  always @(*) begin
  AN='b11111111;
  AN[s]=0;
  end
  //时钟分频器
  always @(posedge CLK100MHZ or posedge clr)
   begin
   if(clr==1)clkdiv<=0;
 else clkdiv<=clkdiv+1;
  end
  
  
  // 逻辑运算和算术运算
  always @(*) begin
   F = 2'h00;
    case (op)
      2'b00: begin carry=0;sum=0;
       for(i=0;i<4;i=i+1) begin
      {carry[i+1], sum[i]} = A[i] + B[i] + carry[i];
      end      
      sum[i]=sum[i]+carry[i];
      F = sum; // 加法
      end
      2'b01: F = A - B; // 减法
      2'b10: F = {1'h0,~A}; // 取反
      2'b11: begin accumulator=0;
       for(i=0;i<4;i=i+1) begin 
    if (B[i] == 1) begin 
        // 如果B的当前位为1，将A左移 i 位并加到累积器中
        accumulator = accumulator + (A << i);
      end
    end
      F = accumulator; // 乘法
      end
      default: F = 2'h00; // 默认值
    endcase
  end
  
always @(*) begin
    case (digit)
        4'b0000: segment = 7'b1000000; // 数字 0
        4'b0001: segment = 7'b1111001; // 数字 1
        4'b0010: segment = 7'b0100100; // 数字 2
        4'b0011: segment = 7'b0110000; // 数字 3
        4'b0100: segment = 7'b0011001; // 数字 4
        4'b0101: segment = 7'b0010010; // 数字 5
        4'b0110: segment = 7'b0000010; // 数字 6
        4'b0111: segment = 7'b1111000; // 数字 7
        4'b1000: segment = 7'b0000000; // 数字 8
        4'b1001: segment = 7'b0010000; // 数字 9
        4'b1010: segment = 7'b0001000; // 数字 A
        4'b1011: segment = 7'b0000011; // 数字 B
        4'b1100: segment = 7'b1000110; // 数字 C
        4'b1101: segment = 7'b0100001; // 数字 D
        4'b1110: segment = 7'b0000110; // 数字 E
        4'b1111: segment = 7'b0001110; // 数字 F
        default: segment = 7'b1000000; // 默认情况，关闭所有段
    endcase
end

endmodule