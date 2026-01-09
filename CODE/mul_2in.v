module mul_2in(in1,in2,out);
 input [1:0]in1;
 input [1:0]in2;
 output [1:0]out;
 
 wire in_1;
 wire in_2;
 wire out0;
 wire out1;
 
 assign in_1=in1[0]^in1[1];
 assign in_2=in2[0]^in2[1];
 assign out1=(in1[0] && in2[0])^(in_1 && in_2);
 assign out0=(in1[1] && in2[1])^(in1[0] && in2[0]);
 
 assign out={out1,out0};
 
 endmodule
 