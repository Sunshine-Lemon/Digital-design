`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/11/07 09:31:27
// Design Name: 
// Module Name: AutoSeller
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


module AutoSeller(
    input [2:0] goods,
    input [4:0] money,//money[0]��ʾ��Ŀǰ��֧���۸����㣬���¿�ʼ��money[1-4]��ʾ�۸�ť
    input CLK100MHZ,
    output reg DP,
    output reg [7:0] AN,//������һ���������ʾ
    output reg [6:0] A2G,
    output reg [0:0] success_buy
    );
    
    integer total_money;
    wire [1:0] s; //��������ĳ�������
    reg clk;
    reg [23:0] count;
    reg [3:0] digit;//�����Ҫ��ʾ�����֣�ֻ��Ҫ����λ��ʾ0-15
    reg [19:0] clkdiv;
    
    assign s = clkdiv[19:18];
    
    //�������Ĵ���
    always@(posedge CLK100MHZ)
    begin
        count = count + 1'b1;
        if (count [23] == 1)
        begin
             clk = ~clk;
             count = 24'b0;
       end
    end
    
    //��digit���и�ֵ�����������չʾ����Ҫչʾ��ż���Ǯ��
    always @(s)
    case(s)
        //��ʾ��Ʒ���
        0:begin
            case(goods)
                0,7:digit = 0; //���0,7Ĭ����ʾΪ0
                default:digit = goods[2:0]; //������������ʾ
            endcase
          end 
        //��ʾ��֧���ļ۸� 
        1:digit = total_money%10;
        2:digit = (total_money%100 - total_money%10)/10;
        3:digit = (total_money%1000 - total_money%100)/100;
    endcase
    
    //Ĭ������£�8�������ȫ��Ϩ�𣬸���s��ֵ��ѡ���ĸ����������
    always @(*)
    begin
        case(s)
        0:begin
                AN = 8'b11111111;
                AN[s] = 0;
                DP = 1;
            end
        2:begin
                AN = 8'b11111111;
                AN[s+3] = 0;
                DP = 0;
            end      
        1,3:begin
                AN = 8'b11111111;
                AN[s+3] = 0;
                DP = 1;
            end     
        endcase     
    end  
    
    //ʱ�ӷ�Ƶ��
    always @(posedge CLK100MHZ)
    begin 
            clkdiv <= clkdiv+1;    
    end  
    
    //���㵱ǰ��֧���ļ۸�
    always @(posedge clk) begin
        total_money = total_money + 5 * money[1] + 10 * money[2] + 20 * money[3] + 50 * money[4];
        if(money[0]) begin
            total_money = 0;//���밴ť��ʾ��գ�����֧��
        end
    end
    
          
    always @(*)
    case (digit)
        //�������ʾ��������
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
    
    //�ж��Ƿ�ɹ�֧��
    always @(total_money or goods)
    case(goods)
        1:begin
            if(total_money == 5) success_buy = 1;
            else success_buy = 0;
          end 
        2:begin
            if(total_money == 10) success_buy = 1;
            else success_buy = 0;
          end  
        3:begin
            if(total_money == 15) success_buy = 1;
            else success_buy = 0;
          end 
        4:begin
            if(total_money == 20) success_buy = 1;
            else success_buy = 0;
          end
        5:begin
            if(total_money == 65) success_buy = 1;
            else success_buy = 0;
          end  
        6:begin
            if(total_money == 130) success_buy = 1;
            else success_buy = 0;
          end  
        default:success_buy = 0;               
    endcase
endmodule
