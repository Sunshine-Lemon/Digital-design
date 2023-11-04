`timescale 1ns / 1ps

module tb_ALU();

  // �ź�����
  reg [3:0] A;
  reg [3:0] B;
  reg [1:0] option;
  reg CLK100MHZ;
  
  wire DP;
  wire [6:0] segment;
  wire [7:0] light;

  // ģ��ʵ����
  ALU uut (
    .A(A),
    .B(B),
    .option(option),
    .CLK100MHZ(CLK100MHZ),
    .DP(DP),
    .segment(segment),
    .light(light)
  );

  // ʱ��Դ
  always begin
    #5 CLK100MHZ = ~CLK100MHZ;
  end

  // �źų�ʼ��
  initial begin
    A = 4'b0010;  // �������� A Ϊ 0010
    B = 4'b1100;  // �������� B
    option = 2'b00;    // ���ò���Ϊ�ӷ�
    CLK100MHZ = 0; // ��ʼ��ʱ���ź�

  end

  // ��ӷ����������
  initial begin
    #100; // ģ������һ��ʱ����������
    $finish;
  end

endmodule
