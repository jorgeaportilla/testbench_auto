timeunit 0.1ns; timeprecision 0.1ns;

/**/module test_task_ALU( );
    parameter             N = 8;  //length vectors
    logic                 [N-1:0]a,b;
    logic                 [3:0]opcode;
    logic                 cin;
    logic                 [N-1:0] y;
    logic                 clk;
    integer               count_pass = 0;
    integer               count_fails = 0;
    
    always #1 clk = ~clk;
    ALU #(.N(N))DUT_ALU (.*);
    
    integer i=0;
    initial begin
        clk=0;
        a =0;
        b = 0;
        cin = 0;
        opcode = 0;
        $display("Begining Test Bench");
      
        repeat (800) begin
            @(negedge clk)
            i+=1;
            a = $urandom_range(0,255);  //(std::randomize (a) with {a>=10; a <=20;});
            b = $urandom_range(0,255); //(std::randomize (b) with {b <=10;});
            cin = $urandom_range(0,1);
            opcode = $urandom_range(0,16);
            @ (negedge clk); check_results;
        end
             if (count_fails > 0)  $display("*********FAIL*********"); else $display("*********PASS*********");
            $display("Failed (%1d) and Passed  (%1d) operations",count_fails,count_pass);
      end
      
      task check_results;
          case (opcode)
              'd0 : if(y ==  ~a) count_pass  += 1; else count_fails  += 1; 
              'd1 : if(y ==  ~b) count_pass  += 1; else count_fails  += 1; 
              'd2  : if(y ==   (a & b))  count_pass  += 1; else count_fails  += 1; 
              'd3  : if(y ==   (a | b))  count_pass  += 1; else count_fails  += 1; 
              'd4  : if(y == ~(a & b)) count_pass  += 1; else count_fails  += 1; 
              'd5  : if(y == ~(a | b)) count_pass  += 1; else count_fails  += 1; 
              'd6  : if(y ==   a ^ b) count_pass  += 1; else count_fails  += 1; 
              'd7  : if(y == ~(a ^ b)) count_pass  += 1; else count_fails  += 1; 
              'd8  : if(y ==  a)     count_pass  += 1; else count_fails  += 1;  
              'd9  : if(y == b)      count_pass  += 1; else count_fails  += 1; 
              'd10 : if(y == a + 1) count_pass  += 1; else count_fails  += 1; 
              'd11 : if(y == b + 1) count_pass  += 1; else count_fails  += 1; 
              'd12 : if(y ==  a - 1) count_pass  += 1; else count_fails  += 1; 
              'd13 : if(y == b - 1) count_pass  += 1; else count_fails  += 1; 
              'd14 : if(y == a + b) count_pass  += 1; else count_fails  += 1; 
              'd15 : if(y == a + b+ cin) count_pass  += 1; else count_fails  += 1;      
              default : y=  a + b + cin;
             endcase
             $write("%d) A: %3d \t B:%3d \t Cin:%1d \t opcode:%b \t rta:%4d \n",i,a,b,cin,opcode,y);
    endtask
endmodule




