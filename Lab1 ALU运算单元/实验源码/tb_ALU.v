`timescale 1ns / 1ps

module tb_ALU();

  // 信号声明
  reg [3:0] A;
  reg [3:0] B;
  reg [1:0] option;
  reg CLK100MHZ;
  
  wire DP;
  wire [6:0] segment;
  wire [7:0] light;

  // 模块实例化
  ALU uut (
    .A(A),
    .B(B),
    .option(option),
    .CLK100MHZ(CLK100MHZ),
    .DP(DP),
    .segment(segment),
    .light(light)
  );

  // 时钟源
  always begin
    #5 CLK100MHZ = ~CLK100MHZ;
  end

  // 信号初始化
  initial begin
    A = 4'b0010;  // 设置输入 A 为 0010
    B = 4'b1100;  // 设置输入 B
    option = 2'b00;    // 设置操作为加法
    CLK100MHZ = 0; // 初始化时钟信号

  end

  // 添加仿真结束条件
  initial begin
    #100; // 模拟运行一段时间后结束仿真
    $finish;
  end

endmodule
