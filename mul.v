
module read_reg (input wire clk,wrt, input wire [15:0] x,input wire [7:0] b, output wire [15:0] y);

    mux2 m1(x[0],b[0],wrt,y[0]);
    mux2 m2(x[1],b[1],wrt,y[1]);
    mux2 m3(x[2],b[2],wrt,y[2]);
    mux2 m4(x[3],b[3],wrt,y[3]);
    mux2 m5(x[4],b[4],wrt,y[4]);
    mux2 m6(x[5],b[5],wrt,y[5]);
    mux2 m7(x[6],b[6],wrt,y[6]);
    mux2 m8(x[7],b[7],wrt,y[7]);
    mux2 m9(x[8],1'b0,wrt,y[8]);
    mux2 m10(x[9],1'b0,wrt,y[9]);
    mux2 m11(x[10],1'b0,wrt,y[10]);
    mux2 m12(x[11],1'b0,wrt,y[11]);
    mux2 m13(x[12],1'b0,wrt,y[12]);
    mux2 m14(x[13],1'b0,wrt,y[13]);
    mux2 m15(x[14],1'b0,wrt,y[14]);
    mux2 m16(x[15],1'b0,wrt,y[15]);
endmodule

module write_reg(input wire clk,reset,cout, input wire [15:0] sum,output [15:0] out);

    dfrl d0(clk,reset,1'b1,sum[1],out[0]);
    dfrl d1(clk,reset,1'b1,sum[2],out[1]);
    dfrl d2(clk,reset,1'b1,sum[3],out[2]);
    dfrl d3(clk,reset,1'b1,sum[4],out[3]);
    dfrl d4(clk,reset,1'b1,sum[5],out[4]);
    dfrl d5(clk,reset,1'b1,sum[6],out[5]);
    dfrl d6(clk,reset,1'b1,sum[7],out[6]);
    dfrl d7(clk,reset,1'b1,sum[8],out[7]);
    dfrl d8(clk,reset,1'b1,sum[9],out[8]);
    dfrl d9(clk,reset,1'b1,sum[10],out[9]);
    dfrl d10(clk,reset,1'b1,sum[11],out[10]);
    dfrl d11(clk,reset,1'b1,sum[12],out[11]);
    dfrl d12(clk,reset,1'b1,sum[13],out[12]);
    dfrl d13(clk,reset,1'b1,sum[14],out[13]);
    dfrl d14(clk,reset,1'b1,sum[15],out[14]);
    dfrl d15(clk,reset,1'b1,cout,out[15]);
endmodule

module alu_slice(input wire[15:0] a,input wire[7:0] b1,output wire [15:0] out,output wire carry);

    assign out[0] = a[0];
    assign out[1] = a[1];
    assign out[2] = a[2];
    assign out[3] = a[3];
    assign out[4] = a[4];
    assign out[5] = a[5];
    assign out[6] = a[6];
    assign out[7] = a[7];

    wire [7:0]b;
    and2 a0(a[0],b1[0],b[0]);
    and2 a1(a[0],b1[1],b[1]);
    and2 a2(a[0],b1[2],b[2]);
    and2 a3(a[0],b1[3],b[3]);
    and2 a4(a[0],b1[4],b[4]);
    and2 a5(a[0],b1[5],b[5]);
    and2 a6(a[0],b1[6],b[6]);
    and2 a7(a[0],b1[7],b[7]);

    wire [6:0] c; 
    fa fa0(a[8],b[0],1'b0,out[8],c[0]);
    fa fa1(a[9],b[1],c[0],out[9],c[1]);
    fa fa2(a[10],b[2],c[1],out[10],c[2]);
    fa fa3(a[11],b[3],c[2],out[11],c[3]);
    fa fa4(a[12],b[4],c[3],out[12],c[4]);
    fa fa5(a[13],b[5],c[4],out[13],c[5]);
    fa fa6(a[14],b[6],c[5],out[14],c[6]);
    fa fa7(a[15],b[7],c[6],out[15],carry);
endmodule


module fa (input wire i0, i1, cin, output wire sum, cout);
   wire t0, t1, t2;
   xor3 _x0 (i0, i1, cin, sum);
   and2 _a0 (i0, i1, t0);
   and2 _a1 (i1, cin, t1);
   and2 _a2 (cin, i0, t2);
   or3 _o0 (t0, t1, t2, cout);
endmodule

module reg_file(input wire clk,reset,wrt,cout,input wire [7:0]b,input wire[15:0] sum,output wire [15:0] prod);
    wire [15:0] r0;
    read_reg re1(clk,wrt,r0,b,prod);
    write_reg w1(clk,reset,cout,sum,r0);
endmodule

module seq_mul (input wire clk,wrt,reset, input wire [7:0] mul,b,output wire [15:0] prod);
    wire [15:0]sum;
    wire carry;
    alu_slice a1(prod,mul,sum,carry);
    reg_file rf1(clk,reset,wrt,carry,b,sum,prod);
endmodule