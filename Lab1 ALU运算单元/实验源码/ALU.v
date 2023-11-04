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
  reg [7:0] accumulator; // �ۻ���
   reg [4:0] sum; // �м����Ĵ���
  reg [4:0] carry; // ��λ�Ĵ���
  assign clr=0;
  assign s=clkdiv[19:17];
    assign DP=1;
    assign x=F;
  
  //8λ 8ѡһǰ6λ����0
  always @(s)
  case(s)
  0:digit=x[3:0];
  1:digit=x[7:4];
       default: digit=0; 
  endcase
  //ѡ�в�����
  always @(*) begin
  AN='b11111111;
  AN[s]=0;
  end
  //ʱ�ӷ�Ƶ��
  always @(posedge CLK100MHZ or posedge clr)
   begin
   if(clr==1)clkdiv<=0;
 else clkdiv<=clkdiv+1;
  end
  
  
  // �߼��������������
  always @(*) begin
   F = 2'h00;
    case (op)
      2'b00: begin carry=0;sum=0;
       for(i=0;i<4;i=i+1) begin
      {carry[i+1], sum[i]} = A[i] + B[i] + carry[i];
      end      
      sum[i]=sum[i]+carry[i];
      F = sum; // �ӷ�
      end
      2'b01: F = A - B; // ����
      2'b10: F = {1'h0,~A}; // ȡ��
      2'b11: begin accumulator=0;
       for(i=0;i<4;i=i+1) begin 
    if (B[i] == 1) begin 
        // ���B�ĵ�ǰλΪ1����A���� i λ���ӵ��ۻ�����
        accumulator = accumulator + (A << i);
      end
    end
      F = accumulator; // �˷�
      end
      default: F = 2'h00; // Ĭ��ֵ
    endcase
  end
  
always @(*) begin
    case (digit)
        4'b0000: segment = 7'b1000000; // ���� 0
        4'b0001: segment = 7'b1111001; // ���� 1
        4'b0010: segment = 7'b0100100; // ���� 2
        4'b0011: segment = 7'b0110000; // ���� 3
        4'b0100: segment = 7'b0011001; // ���� 4
        4'b0101: segment = 7'b0010010; // ���� 5
        4'b0110: segment = 7'b0000010; // ���� 6
        4'b0111: segment = 7'b1111000; // ���� 7
        4'b1000: segment = 7'b0000000; // ���� 8
        4'b1001: segment = 7'b0010000; // ���� 9
        4'b1010: segment = 7'b0001000; // ���� A
        4'b1011: segment = 7'b0000011; // ���� B
        4'b1100: segment = 7'b1000110; // ���� C
        4'b1101: segment = 7'b0100001; // ���� D
        4'b1110: segment = 7'b0000110; // ���� E
        4'b1111: segment = 7'b0001110; // ���� F
        default: segment = 7'b1000000; // Ĭ��������ر����ж�
    endcase
end

endmodule