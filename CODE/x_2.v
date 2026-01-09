module x_2(in,out);
 input [3:0]in;
 output [3:0]out;
 
 wire q0;
 wire q1;
 wire q2;
 wire q3;
 
assign out={q3,q2,q1,q0};
assign q3=in[3];
assign q2=in[3]^in[2];
assign q1=in[2]^in[1];
assign q0=in[3]^in[1]^in[0];
endmodule
