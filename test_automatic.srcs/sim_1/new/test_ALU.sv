`timescale 1ns / 1ps

/**/module test_ALU( );
    parameter             N = 8;  //length vectors
    parameter             number_lines = 17;
    logic                 [N-1:0]a,b;
    logic                 [3:0]opcode;
    logic                 cin;
    logic                 [N-1:0] y;
    
    reg                   [7:0] test_vectors [number_lines:0][0:4];
    string                PATH_FILE = "/home/jorge/Downloads/data_test.txt";
    integer               count_pass = 0;
    integer               count_fails = 0;
    integer               i = 0;
    
    integer               file_inputs     ; // var to see if file exists
    integer               scan_inputs     ; // captured text handler
    integer               count=0;
    reg try;
    
    
    //****count lines in the textfile***
    initial begin    
      file_inputs = $fopen(PATH_FILE, "r");
    end
          
    always @(* )
      begin
       while (!$feof(file_inputs)) 
       begin    
           scan_inputs = $fscanf(file_inputs, "%h\n", try); 
           count +=1;
       end
       $display("Lines in the text file: ", count/5);
    end
    

    ALU #(.N(N))DUT_ALU (.*);
    initial begin
        
        $display("Begining Test Bench");       
        $readmemb(PATH_FILE, test_vectors);   //in the txt |  a     |    b   |cin| ope|    y    |
        //$display(test_vectors_input);
        
        for (i = 0; i < number_lines; i++) begin //error when number_lines is variable
          #10 a = test_vectors[i][0];  b = test_vectors[i][1]; cin = test_vectors[i][2][0:0]; opcode= test_vectors[i][3][3:0]; 
          #1 $write("%2d | %2d | %2d | %b | %3d \n", test_vectors[i][0],test_vectors[i][1],test_vectors[i][2][0:0],test_vectors[i][3][3:0], test_vectors[i][4]);
          if(y == test_vectors[i][4]) count_pass  += 1; else count_fails  += 1; 
        end  
        #1
        if (count_fails > 0)  $display("*********FAIL*********"); else $display("*********PASS*********");
        $display("Failed (%1d) and Passed  (%1d) operations",count_fails,count_pass);

    end
    
endmodule

