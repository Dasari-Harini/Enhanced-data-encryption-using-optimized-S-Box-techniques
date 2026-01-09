module mulinverse(in,dout);

 input [7:0]in;
 output [7:0]dout;
 
 
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
 wire [7:0]d;
 wire [3:0]mulin;
 wire mulin0;
 wire mulin1;
 wire mulin2;
 wire mulin3;
 wire [3:0]out;
 wire [3:0]lam_out;
 wire [3:0]m_out;
 wire [3:0]inv_out;
 wire [3:0]m1_out;
 wire [3:0]m2_out;
 wire [7:0]del_in;
 wire [3:0]inv_in;
 wire inv_in0;
 wire inv_in1;
 wire inv_in2;
 wire inv_in3;
 
 //isomorphic morphing
 assign q0=in[0];
 assign q1=in[1];
 assign q2=in[2];
 assign q3=in[3];
 assign q4=in[4];
 assign q5=in[5];
 assign q6=in[6];
 assign q7=in[7];
 
 assign d7=q7^q5;
 assign d6=q7^q6^q4^q3^q2^q1;
 assign d5=q7^q5^q3^q2;
 assign d4=q7^q5^q3^q2^q1;
 assign d3=q7^q6^q2^q1;
 assign d2=q7^q4^q3^q2^q1;
 assign d1=q6^q4^q1;
 assign d0=q6^q1^q0;
 
 assign d={d7,d6,d5,d4,d3,d2,d1,d0};
 
 assign mulin0=d[0]^d[4];
 assign mulin1=d[1]^d[5];
 assign mulin2=d[2]^d[6];
 assign mulin3=d[3]^d[7];
 
 assign mulin={mulin3,mulin2,mulin1,mulin0};
 
 x_2 in1s(
         .in(d[7:4]),
         .out(out)
         );
         
  lamda in1s1(
            .in(out),
            .out(lam_out)
         );
         
  mul_in i1ns2(
            .in1(mulin[3:0]),
            .in2(d[3:0]),
            .out(m_out)
         );
         
   assign inv_in0=lam_out[0]^m_out[0];
   assign inv_in1=lam_out[1]^m_out[1];
   assign inv_in2=lam_out[2]^m_out[2];
   assign inv_in3=lam_out[3]^m_out[3];
   assign inv_in={inv_in3,inv_in2,inv_in1,inv_in0};
   
   assign del_in={m1_out,m2_out};
   inverse  ins(
            .in(inv_in),
            .out(inv_out)
            );
            
   mul_in ins1(
            .in1(d[7:4]),
            .in2(inv_out),
            .out(m1_out)
         );
   mul_in ins2(
            .in1(mulin[3:0]),
            .in2(inv_out),
            .out(m2_out)
         );
 assign dout[7]=del_in[7]^del_in[6]^del_in[5]^del_in[1];
 assign dout[6]=del_in[6]^del_in[2];
 assign dout[5]=del_in[6]^del_in[5]^del_in[1];
 assign dout[4]=del_in[6]^del_in[5]^del_in[4]^del_in[2]^del_in[1];
 assign dout[3]=del_in[5]^del_in[4]^del_in[3]^del_in[2]^del_in[1];
 assign dout[2]=del_in[7]^del_in[4]^del_in[3]^del_in[2]^del_in[1];
 assign dout[1]=del_in[5]^del_in[4];
 assign dout[0]=del_in[6]^del_in[5]^del_in[4]^del_in[2]^del_in[0];
 //assign dout[7]=del_in[7]^del_in[6]^del_in[5]^del_in[1];
 endmodule
 