`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/23/2020 12:32:23 PM
// Design Name: 
// Module Name: test_ALU_automatic
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//////////////////////////////////////////////////////////////////////////////////


module test_ALU_automatic(

    );
     parameter N = 8;
    logic clk;
    logic [N-1:0]a,b;
    logic [3:0]opcode;
    logic cin;
    logic [N-1:0] y;
    integer count_pass = 0;
    integer count_fails = 0;
    
    ALU #(.N(N))DUT_ALU (.*);
   
    initial begin
 
                                                                        $display("  a  |   b  | cin | operation |  y  | \n");
            a = 'b00000001;  b = 'b00000010; cin =  1'b1; opcode= 4'd1; #1 $write("%2d | %2d | %2d | %b | %3d \n" , a,b,cin,opcode,y);
            if(y == 'b11111101) count_pass  += 1; else count_fails  += 1; 
        #10 a = 'b00001011;  b = 'b00000011; cin =  1'b1; opcode= 4'd0; #1 $write("%2d | %2d | %2d | %b | %3d \n", a,b,cin,opcode,y);
            if(y == 8'b11110100) count_pass  += 1; else count_fails  += 1; 
        #10 a = 'b00001000;  b = 'b00000010; cin =  1'b1; opcode= 4'b1110; #1 $write("%2d | %2d | %2d | %b | %3d \n", a,b,cin,opcode,y);
            if(y == 8'd10) count_pass  += 1; else count_fails  += 1; 
        #10 a = 'b00001000;  b = 'b00000010; cin =  1'b1; opcode= 4'b1111; #1 $write("%2d | %2d | %2d | %b | %3d \n", a,b,cin,opcode,y);
            if(y == 8'd11) count_pass  += 1; else count_fails  += 1; 
        
        #10 a = 'b00001001;  b = 'b00000011; cin =  1'b1; opcode= 4'b0110; #1 $write("%2d | %2d | %2d | %b | %3d \n", a,b,cin,opcode,y);
            if(y == 8'b00001010) count_pass  += 1; else count_fails  += 1; 
        #10 a = 'b00001000;  b = 'b00000010; cin =  1'b1; opcode= 4'b0111; #1 $write("%2d | %2d | %2d | %b | %3d \n", a,b,cin,opcode,y);
            if(y == 8'b11110101) count_pass  += 1; else count_fails  += 1; 
        #1
    if (count_fails > 0)  $display("FAIL"); else $display("PASS");
    $display("Failed (%1d) and passed  (%1d) operations",count_fails,count_pass);
       
    
    end
    
endmodule




