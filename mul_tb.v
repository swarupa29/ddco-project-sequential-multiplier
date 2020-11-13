  
`timescale 1 ns / 100 ps

module tb;
  reg clk,reset,write;
  reg [7:0] mul1,b1,mul2,b2;
  wire [15:0] prod1,prod2;
  reg test;
  integer i;
  initial begin $dumpfile("test_bench.vcd"); $dumpvars(0,tb); end
  initial begin reset = 1'b1; #10 reset = 1'b0; end
  initial begin write = 1'b1; #20 write = 1'b0; end
  initial clk = 1'b0; always #5 clk =~ clk;
  initial begin
    mul1 = 8;
    b1 = 7;
    mul2=10;
    b2=11;
  end
  seq_mul seq_mul1 (clk, write, reset, mul1, b1, prod1);
  seq_mul seq_mul2 (clk, write, reset, mul2, b2, prod2);
  initial begin
  #95 $finish;
  end
endmodule
 

 // first example is multiplying 8X7
 // second example is multiplying 10X11