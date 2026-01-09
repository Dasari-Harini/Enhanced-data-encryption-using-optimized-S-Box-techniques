module inv_sbox (in,out);
 input [7:0]in;
 output [7:0]out;
 
 wire [7:0]ind_out;
 
 inverse_affine_transform  ains(
            .in(in),
            .out (ind_out)
            );
 mulinverse mins(
            .in(ind_out),
            .dout(out)
            );
 endmodule
 