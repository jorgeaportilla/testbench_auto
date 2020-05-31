`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/22/2020 07:02:01 PM
// Design Name: 
// Module Name: ALU
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

module ALU #(parameter N = 8)
    (
    input logic [N-1:0]a,b,
    input logic [3:0]opcode,
    input logic cin,
    output logic [N-1:0] y);
    
    logic [N-1:0] y_logic, y_arith;
    
    always_comb begin
        case (opcode[2:0])
            'b000 :  y_logic =  ~a;      //NOT A
            'b001 :  y_logic =  ~b;      //NOT B
            'b010 :  y_logic =   a & b;  //A AND B
            'b011 :  y_logic =   a | b;  //A OR B
            'b100 :  y_logic =  ~(a & b);  //A NAND B
            'b101 :  y_logic = ~(a | b); //A NOR B
            'b110 :  y_logic =   a ^ b;  //A XOR B
            default : y_logic =  ~(a ^ b); //A XNOR B
         endcase
         
         case (opcode[2:0])
            'b000 :  y_arith = a;
            'b001 :  y_arith = b;
            'b010 :  y_arith = a + 1;
            'b011 :  y_arith = b + 1;
            'b100 :  y_arith = a - 1;
            'b101 :  y_arith = b - 1;
            'b110 :  y_arith = a + b;
            default : y_arith = a + b + cin;
         endcase
         
         case (opcode[3])
            'b0 :  y = y_logic;
            default:  y = y_arith;
         endcase
    end
    
        
endmodule
