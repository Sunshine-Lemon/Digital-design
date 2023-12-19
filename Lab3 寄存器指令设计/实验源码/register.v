`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/12/03 14:14:21
// Design Name: 
// Module Name: register
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


module register(
    input [4:0]N1,
    input [4:0]N2,
    input [1:0]op,
    input WE,
    input reset,
    input CLK100MHZ,
    output reg DP,
    output reg [7:0] AN,
    output reg [6:0] A2G
    );
    wire [1:0] s;
    reg [7:0] mem [0:31];
    reg [7:0] Q1;
    reg [7:0] Q2;
    reg [7:0] Dl;
    reg clk;
    reg [23:0] count;
    reg [19:0] clkdiv;
    reg [3:0] digit;

    assign s = clkdiv[19:18];
    
    always @(posedge CLK100MHZ)
    begin 
            clkdiv <= clkdiv+1;    
    end 
    
    always@(posedge CLK100MHZ)
    begin
        count = count + 1'b1;
        if (count [23] == 1)
        begin
             clk = ~clk;
             count = 24'b0;
       end
    end

    task initialize_memory;
    integer i;   
    begin  
    for (i = 0; i < 32; i = i + 1) begin
        mem[i] = 8'b1;
    end
    end
    endtask

    initial begin
    initialize_memory;
    end

    always @(posedge clk)
    begin
    Q1 = mem[N1];
    Q2 = mem[N2];
    case(op)
        0:Dl = Q1 + Q2;
        1:Dl = Q1 - Q2;
        2:Dl = ~Q1;
        3:Dl = multi(Q1,Q2);
    endcase
    end
    
    always @(negedge clk)
    begin
    if(WE == 1&&reset == 0) begin
        mem[N1] = Dl;
    end
    if(reset == 1) begin
         initialize_memory;
    end      
    end  
    
    function [7:0]multi;
        input [3:0] A,B;
        reg [7:0] count;
        integer i;
        begin
            count = 0;
            for(i = 0;i < 4;i=i+1)
                begin
                    if(A[i])
                     count = count + (B << i);
                 end
             multi = count;
         end        
    endfunction
     
    always @(*)
    begin
        case(s)
        0,1:begin
                AN = 8'b11111111;
                AN[s] = 0;
                DP = 1;
            end
        2,3:begin
                AN = 8'b11111111;
                AN[s+2] = 0;
                DP = 1;
            end        
        endcase     
    end  
    
    always @(s)
    case(s)
        0:digit = Q1[3:0];
        1:digit = Q1[7:4];
        2:digit = Q2[3:0];
        3:digit = Q2[7:4];
    endcase
    
    always @(*)
    case (digit)
        4'h0:A2G = 7'b1000000;
        4'h1:A2G = 7'b1111001;
        4'h2:A2G = 7'b0100100;
        4'h3:A2G = 7'b0110000;
        4'h4:A2G = 7'b0011001;
        4'h5:A2G = 7'b0010010;
        4'h6:A2G = 7'b0000010;
        4'h7:A2G = 7'b1111000;
        4'h8:A2G = 7'b0000000;
        4'h9:A2G = 7'b0010000;
        4'ha:A2G = 7'b0001000;
        4'hb:A2G = 7'b0000011;
        4'hc:A2G = 7'b1000110;
        4'hd:A2G = 7'b0100001;
        4'he:A2G = 7'b0000110;
        4'hf:A2G = 7'b0001110;
        default:A2G = 7'b1000000;
    endcase  
endmodule
