module inverse_affine_transform (in,out);
 input [7:0]in;
 output [7:0]out;
 wire q0;
 wire q1;
 wire q2;
 wire q3;
 wire q4;
 wire q5;
 wire q6;
 wire q7;
 wire d0;
 wire d1;
 wire d2;
 wire d3;
 wire d4;
 wire d5;
 wire d6;
 wire d7;

 assign q0=in[0];
 assign q1=in[1];
 assign q2=in[2];
 assign q3=in[3];
 assign q4=in[4];
 assign q5=in[5];
 assign q6=in[6];
 assign q7=in[7];
 
 assign d7=q6^q4^q1;
 assign d6=q5^q3^q0;
 assign d5=q7^q4^q2;
 assign d4=q6^q3^q1;
 assign d3=q5^q2^q0;
 assign d2=q7^q4^q1;
 assign d1=q6^q3^q0;
 assign d0=q7^q5^q2;
 
 assign out7=d7^1'b0;
 assign out6=d6^1'b0;
 assign out5=d5^1'b0;
 assign out4=d4^1'b0;
 assign out3=d3^1'b0;
 assign out2=d2^1'b1;
 assign out1=d1^1'b0;
 assign out0=d0^1'b1;
 
 assign out={out7,out6,out5,out4,out3,out2,out1,out0};
endmodule 
 