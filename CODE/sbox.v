module sbox (in,out);
 input [7:0]in;
 output [7:0]out;
 
 wire [7:0]ind_out;
 mulinverse mins(
            .in(in),
            .dout(ind_out)
            );
 affine  ains(
            .in(ind_out),
            .out (out)
            );
 endmodule
 