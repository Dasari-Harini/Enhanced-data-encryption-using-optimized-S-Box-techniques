module inverse (in,out);
input [3:0]in; 
 output [3:0]out;
 wire q0;
 wire q1;
 wire q2;
 wire q3;
  assign q0=in[0];
  assign q1=in[1];
  assign q2=in[2];
  assign q3=in[3];
  
  assign out[3]=q3 ^ (q3 && q2 && q1) ^ (q3 && q0)^q2;
  assign out[2]=(q3 && q2 && q1) ^ (q3 && q2 && q0) ^ (q3 && q0)^q2 ^(q2 && q1);
  assign out[1]=q3 ^(q3 && q2 && q1) ^ (q3 && q1 && q0) ^ (q2 && q0)^q2 ^ q1;
  assign out[0]=(q3 && q2 && q1) ^ (q3 && q1)^(q3 && q2 && q0) ^ (q3 && q1 && q0) ^ (q3 && q0)^q2 ^(q2 && q1)^ (q2 && q1 && q0)^q1 ^ q0;
  endmodule