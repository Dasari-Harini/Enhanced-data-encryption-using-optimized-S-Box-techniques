module mul_in(in1,in2,out);
 input [3:0]in1;
 input [3:0]in2;
 output [3:0]out;
 
 wire q0;
 wire q1;
 wire q2;
 wire q3;
 wire out0;
 wire out1;
 wire out2;
 wire out3;
 wire opa0;
 wire opa1;
 wire opb0;
 wire opb1;
 wire [1:0]opa;
 wire [1:0]opb;
 wire [1:0]m_1out;
 wire [1:0]m_2out;
 wire [1:0]m_3out;
 wire [1:0]gam_out;
 assign opa={opa1,opa0};
 assign opb={opb1,opb0};
//assign out={q3,q2,q1,q0};
assign opa0=in1[0]^in1[2];
assign opa1=in1[1]^in1[3];
assign opb0=in2[0]^in2[2];
assign opb1=in2[1]^in2[3];


   mul_2in ins1(
            .in1(in1[3:2]),
            .in2(in2[3:2]),
            .out(m_1out)
         );
   mul_2in ins2(
            .in1(opa),
            .in2(opb),
            .out(m_2out)
         );
   mul_2in ins3(
            .in1(in1[1:0]),
            .in2(in2[1:0]),
            .out(m_3out)
         );
   gamma in (
            .in(m_1out),
            .out(gam_out)
         );
   assign out2=m_2out[0]^m_3out[0];
   assign out3=m_2out[1]^m_3out[1];      
   assign out0=gam_out[0]^m_3out[0];
   assign out1=gam_out[1]^m_3out[1];  
   assign out={out3,out2,out1,out0};     
	
endmodule
