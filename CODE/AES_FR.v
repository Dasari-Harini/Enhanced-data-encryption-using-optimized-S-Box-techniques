module AES_FR(clk, rst, enable, key, plaintext, ciphertextout );
input		clk, rst;
input		enable;
input	[127:0]	key;
input	[127:0]	plaintext;
output	[127:0]	ciphertextout;


//
// Local Wires
//

wire	[31:0]	w0, w1, w2, w3;
reg	[127:0]	plaintext_r;
reg	[127:0]	ciphertextout;
reg	[7:0]	matrix00, matrix01, matrix02, matrix03;
reg	[7:0]	matrix10, matrix11, matrix12, matrix13;
reg	[7:0]	matrix20, matrix21, matrix22, matrix23;
reg	[7:0]	matrix30, matrix31, matrix32, matrix33;
reg	[7:0]	matrix00_next, matrix01_next, matrix02_next, matrix03_next;
reg	[7:0]	matrix10_next, matrix11_next, matrix12_next, matrix13_next;
reg	[7:0]	matrix20_next, matrix21_next, matrix22_next, matrix23_next;
reg	[7:0]	matrix30_next, matrix31_next, matrix32_next, matrix33_next;


wire	[7:0]	matrix00_next1, matrix01_next1, matrix02_next1, matrix03_next1;
wire	[7:0]	matrix10_next1, matrix11_next1, matrix12_next1, matrix13_next1;
wire	[7:0]	matrix20_next1, matrix21_next1, matrix22_next1, matrix23_next1;
wire	[7:0]	matrix30_next1, matrix31_next1, matrix32_next1, matrix33_next1;

wire	[7:0]	matrix00_sub1, matrix01_sub1, matrix02_sub1, matrix03_sub1;
wire	[7:0]	matrix10_sub1, matrix11_sub1, matrix12_sub1, matrix13_sub1;
wire	[7:0]	matrix20_sub1, matrix21_sub1, matrix22_sub1, matrix23_sub1;
wire	[7:0]	matrix30_sub1, matrix31_sub1, matrix32_sub1, matrix33_sub1;


reg	[7:0]	matrix00_sub, matrix01_sub, matrix02_sub, matrix03_sub;
reg	[7:0]	matrix10_sub, matrix11_sub, matrix12_sub, matrix13_sub;
reg	[7:0]	matrix20_sub, matrix21_sub, matrix22_sub, matrix23_sub;
reg	[7:0]	matrix30_sub, matrix31_sub, matrix32_sub, matrix33_sub;

reg	[7:0]	matrix00_sr, matrix01_sr, matrix02_sr, matrix03_sr;
reg	[7:0]	matrix10_sr, matrix11_sr, matrix12_sr, matrix13_sr;
reg	[7:0]	matrix20_sr, matrix21_sr, matrix22_sr, matrix23_sr;
reg	[7:0]	matrix30_sr, matrix31_sr, matrix32_sr, matrix33_sr;
wire	[7:0]	matrix00_mc1, matrix01_mc1, matrix02_mc1, matrix03_mc1;
wire	[7:0]	matrix10_mc1, matrix11_mc1, matrix12_mc1, matrix13_mc1;
wire	[7:0]	matrix20_mc1, matrix21_mc1, matrix22_mc1, matrix23_mc1;
wire	[7:0]	matrix30_mc1, matrix31_mc1, matrix32_mc1, matrix33_mc1;

reg	[7:0]	matrix00_mc, matrix01_mc, matrix02_mc, matrix03_mc;
reg	[7:0]	matrix10_mc, matrix11_mc, matrix12_mc, matrix13_mc;
reg	[7:0]	matrix20_mc, matrix21_mc, matrix22_mc, matrix23_mc;
reg	[7:0]	matrix30_mc, matrix31_mc, matrix32_mc, matrix33_mc;
reg		done, enable_r;






always @(posedge clk) if(enable) plaintext_r <=  plaintext;
always @(posedge clk) enable_r <=  enable;


//
//  AddRoundKey
//
 

always @(posedge clk)	matrix33 <=  enable_r ? plaintext_r[007:000] ^ w3[07:00] : matrix33_next;
always @(posedge clk)	matrix23 <=  enable_r ? plaintext_r[015:008] ^ w3[15:08] : matrix23_next;
always @(posedge clk)	matrix13 <=  enable_r ? plaintext_r[023:016] ^ w3[23:16] : matrix13_next;
always @(posedge clk)	matrix03 <=  enable_r ? plaintext_r[031:024] ^ w3[31:24] : matrix03_next;
always @(posedge clk)	matrix32 <=  enable_r ? plaintext_r[039:032] ^ w2[07:00] : matrix32_next;
always @(posedge clk)	matrix22 <=  enable_r ? plaintext_r[047:040] ^ w2[15:08] : matrix22_next;
always @(posedge clk)	matrix12 <=  enable_r ? plaintext_r[055:048] ^ w2[23:16] : matrix12_next;
always @(posedge clk)	matrix02 <=  enable_r ? plaintext_r[063:056] ^ w2[31:24] : matrix02_next;
always @(posedge clk)	matrix31 <=  enable_r ? plaintext_r[071:064] ^ w1[07:00] : matrix31_next;
always @(posedge clk)	matrix21 <=  enable_r ? plaintext_r[079:072] ^ w1[15:08] : matrix21_next;
always @(posedge clk)	matrix11 <=  enable_r ? plaintext_r[087:080] ^ w1[23:16] : matrix11_next;
always @(posedge clk)	matrix01 <=  enable_r ? plaintext_r[095:088] ^ w1[31:24] : matrix01_next;
always @(posedge clk)	matrix30 <=  enable_r ? plaintext_r[103:096] ^ w0[07:00] : matrix30_next;
always @(posedge clk)	matrix20 <=  enable_r ? plaintext_r[111:104] ^ w0[15:08] : matrix20_next;
always @(posedge clk)	matrix10 <=  enable_r ? plaintext_r[119:112] ^ w0[23:16] : matrix10_next;
always @(posedge clk)	matrix00 <=  enable_r ? plaintext_r[127:120] ^ w0[31:24] : matrix00_next;


///////////////////////////////////////////////
////////////////shift_rows/////////////////////
///////////////////////////////////////////////

always @(posedge clk)
begin
    if (rst)
		 begin    
			 matrix00_sr <= 0;
			 matrix01_sr <= 0;
			 matrix02_sr <= 0;
			 matrix03_sr <= 0;
			 matrix10_sr <= 0;
			 matrix11_sr <= 0;
			 matrix12_sr <= 0;
			 matrix13_sr <= 0;
			 matrix20_sr <= 0;
			 matrix21_sr <= 0;
			 matrix22_sr <= 0;
			 matrix23_sr <= 0;
			 matrix30_sr <= 0;
			 matrix31_sr <= 0;
			 matrix32_sr <= 0;
			 matrix33_sr <= 0;
		end
	else    
		 begin
			 matrix00_sr <= matrix00_sub;
			 matrix01_sr <= matrix01_sub;
			 matrix02_sr <= matrix02_sub;
			 matrix03_sr <= matrix03_sub;
			 matrix10_sr <= matrix11_sub;
			 matrix11_sr <= matrix12_sub;
			 matrix12_sr <= matrix13_sub;
			 matrix13_sr <= matrix10_sub;
			 matrix20_sr <= matrix22_sub;
			 matrix21_sr <= matrix23_sub;
			 matrix22_sr <= matrix20_sub;
			 matrix23_sr <= matrix21_sub;
			 matrix30_sr <= matrix33_sub;
			 matrix31_sr <= matrix30_sub;
			 matrix32_sr <= matrix31_sub;
			 matrix33_sr <= matrix32_sub;
		 end
end

////////////////////Mixcolomns/////////////////////////
always @(posedge clk)
begin
    if (rst)
		 begin    
			 matrix00_mc <= 0;
			 matrix01_mc <= 0;
			 matrix02_mc <= 0;
			 matrix03_mc <= 0;
			 matrix10_mc <= 0;
			 matrix11_mc <= 0;
			 matrix12_mc <= 0;
			 matrix13_mc <= 0;
			 matrix20_mc <= 0;
			 matrix21_mc <= 0;
			 matrix22_mc <= 0;
			 matrix23_mc <= 0;
			 matrix30_mc <= 0;
			 matrix31_mc <= 0;
			 matrix32_mc <= 0;
			 matrix33_mc <= 0;
		 end
 else    
		 begin
			 matrix00_mc <= matrix00_mc1;
			 matrix01_mc <= matrix01_mc1;
			 matrix02_mc <= matrix02_mc1;
			 matrix03_mc <= matrix03_mc1;
			 matrix10_mc <= matrix10_mc1;
			 matrix11_mc <= matrix11_mc1;
			 matrix12_mc <= matrix12_mc1;
			 matrix13_mc <= matrix13_mc1;
			 matrix20_mc <= matrix20_mc1;
			 matrix21_mc <= matrix21_mc1;
			 matrix22_mc <= matrix22_mc1;
			 matrix23_mc <= matrix23_mc1;
			 matrix30_mc <= matrix30_mc1;
			 matrix31_mc <= matrix31_mc1;
			 matrix32_mc <= matrix32_mc1;
			 matrix33_mc <= matrix33_mc1;
		 end
end

assign {matrix00_mc1, matrix10_mc1, matrix20_mc1, matrix30_mc1}  = mix_col(matrix00_sr,matrix10_sr,matrix20_sr,matrix30_sr);
assign {matrix01_mc1, matrix11_mc1, matrix21_mc1, matrix31_mc1}  = mix_col(matrix01_sr,matrix11_sr,matrix21_sr,matrix31_sr);
assign {matrix02_mc1, matrix12_mc1, matrix22_mc1, matrix32_mc1}  = mix_col(matrix02_sr,matrix12_sr,matrix22_sr,matrix32_sr);
assign {matrix03_mc1, matrix13_mc1, matrix23_mc1, matrix33_mc1}  = mix_col(matrix03_sr,matrix13_sr,matrix23_sr,matrix33_sr);

////////////////////Mixcolomns/////////////////////////
always @(posedge clk)
begin
    if (rst)
		 begin    
			 matrix00_next <= 0;
			 matrix01_next <= 0;
			 matrix02_next <= 0;
			 matrix03_next <= 0;
			 matrix10_next <= 0;
			 matrix11_next <= 0;
			 matrix12_next <= 0;
			 matrix13_next <= 0;
			 matrix20_next <= 0;
			 matrix21_next <= 0;
			 matrix22_next <= 0;
			 matrix23_next <= 0;
			 matrix30_next <= 0;
			 matrix31_next <= 0;
			 matrix32_next <= 0;
			 matrix33_next <= 0;
		 end
 else    
		 begin
			 matrix00_next <= matrix00_next1;
			 matrix01_next <= matrix01_next1;
			 matrix02_next <= matrix02_next1;
			 matrix03_next <= matrix03_next1;
			 matrix10_next <= matrix10_next1;
			 matrix11_next <= matrix11_next1;
			 matrix12_next <= matrix12_next1;
			 matrix13_next <= matrix13_next1;
			 matrix20_next <= matrix20_next1;
			 matrix21_next <= matrix21_next1;
			 matrix22_next <= matrix22_next1;
			 matrix23_next <= matrix23_next1;
			 matrix30_next <= matrix30_next1;
			 matrix31_next <= matrix31_next1;
			 matrix32_next <= matrix32_next1;
			 matrix33_next <= matrix33_next1;
		 end
end

assign matrix00_next1 = matrix00_mc ^ w0[31:24];
assign matrix01_next1 = matrix01_mc ^ w1[31:24];
assign matrix02_next1 = matrix02_mc ^ w2[31:24];
assign matrix03_next1 = matrix03_mc ^ w3[31:24];
assign matrix10_next1 = matrix10_mc ^ w0[23:16];
assign matrix11_next1 = matrix11_mc ^ w1[23:16];
assign matrix12_next1 = matrix12_mc ^ w2[23:16];
assign matrix13_next1 = matrix13_mc ^ w3[23:16];
assign matrix20_next1 = matrix20_mc ^ w0[15:08];
assign matrix21_next1 = matrix21_mc ^ w1[15:08];
assign matrix22_next1 = matrix22_mc ^ w2[15:08];
assign matrix23_next1 = matrix23_mc ^ w3[15:08];
assign matrix30_next1 = matrix30_mc ^ w0[07:00];
assign matrix31_next1 = matrix31_mc ^ w1[07:00];
assign matrix32_next1 = matrix32_mc ^ w2[07:00];
assign matrix33_next1 = matrix33_mc ^ w3[07:00];


//
// Final text output
//

always @(posedge clk) ciphertextout[127:120] <=  matrix00_sr ^ w0[31:24];
always @(posedge clk) ciphertextout[095:088] <=  matrix01_sr ^ w1[31:24];
always @(posedge clk) ciphertextout[063:056] <=  matrix02_sr ^ w2[31:24];
always @(posedge clk) ciphertextout[031:024] <=  matrix03_sr ^ w3[31:24];
always @(posedge clk) ciphertextout[119:112] <=  matrix10_sr ^ w0[23:16];
always @(posedge clk) ciphertextout[087:080] <=  matrix11_sr ^ w1[23:16];
always @(posedge clk) ciphertextout[055:048] <=  matrix12_sr ^ w2[23:16];
always @(posedge clk) ciphertextout[023:016] <=  matrix13_sr ^ w3[23:16];
always @(posedge clk) ciphertextout[111:104] <=  matrix20_sr ^ w0[15:08];
always @(posedge clk) ciphertextout[079:072] <=  matrix21_sr ^ w1[15:08];
always @(posedge clk) ciphertextout[047:040] <=  matrix22_sr ^ w2[15:08];
always @(posedge clk) ciphertextout[015:008] <=  matrix23_sr ^ w3[15:08];
always @(posedge clk) ciphertextout[103:096] <=  matrix30_sr ^ w0[07:00];
always @(posedge clk) ciphertextout[071:064] <=  matrix31_sr ^ w1[07:00];
always @(posedge clk) ciphertextout[039:032] <=  matrix32_sr ^ w2[07:00];
always @(posedge clk) ciphertextout[007:000] <=  matrix33_sr ^ w3[07:00];



function [31:0] mix_col;
input	[7:0]	s0,s1,s2,s3;
begin
mix_col[31:24]=xtime(s0)^xtime(s1)^s1^s2^s3;
mix_col[23:16]=s0^xtime(s1)^xtime(s2)^s2^s3;
mix_col[15:08]=s0^s1^xtime(s2)^xtime(s3)^s3;
mix_col[07:00]=xtime(s0)^s0^s1^s2^xtime(s3);
end
endfunction

function [7:0] xtime;
input [7:0] b; xtime={b[6:0],1'b0}^(8'h1b&{8{b[7]}});
endfunction


// Key expansion module


AES_key_expansion u0(
	.clk(		clk	),
	.rst  (rst),
	.kenable(		enable	),
	.key(		key[127:0]	),
	.wo_0(		w0	),
	.wo_1(		w1	),
	.wo_2(		w2	),
	.wo_3(		w3	));
	

always @(posedge clk)
begin
    if (rst)
		 begin    
			 matrix00_sub <= 0;
			 matrix01_sub <= 0;
			 matrix02_sub <= 0;
			 matrix03_sub <= 0;
			 matrix10_sub <= 0;
			 matrix11_sub <= 0;
			 matrix12_sub <= 0;
			 matrix13_sub <= 0;
			 matrix20_sub <= 0;
			 matrix21_sub <= 0;
			 matrix22_sub <= 0;
			 matrix23_sub <= 0;
			 matrix30_sub <= 0;
			 matrix31_sub <= 0;
			 matrix32_sub <= 0;
			 matrix33_sub <= 0;
		 end
	 else    
		 begin
			 matrix00_sub <= matrix00_sub1;
			 matrix01_sub <= matrix01_sub1;
			 matrix02_sub <= matrix02_sub1;
			 matrix03_sub <= matrix03_sub1;
			 matrix10_sub <= matrix10_sub1;
			 matrix11_sub <= matrix11_sub1;
			 matrix12_sub <= matrix12_sub1;
			 matrix13_sub <= matrix13_sub1;
			 matrix20_sub <= matrix20_sub1;
			 matrix21_sub <= matrix21_sub1;
			 matrix22_sub <= matrix22_sub1;
			 matrix23_sub <= matrix23_sub1;
			 matrix30_sub <= matrix30_sub1;
			 matrix31_sub <= matrix31_sub1;
			 matrix32_sub <= matrix32_sub1;
			 matrix33_sub <= matrix33_sub1;
		 end
end

sbox in00(
                        .in(	matrix00	),
								.out(	matrix00_sub1	)
								);
sbox in01(	
                        .in(	matrix01	), 
								.out(	matrix01_sub1	)
								);
sbox in02(	
								.in(	matrix02	), 
								.out(	matrix02_sub1	)
								);
sbox in03(	
								.in(	matrix03	), 
								.out(	matrix03_sub1	)
								);
sbox in10(	
								.in(	matrix10	),
								.out(	matrix10_sub1	)
								);
sbox in11(	
								.in(	matrix11	),
								.out(	matrix11_sub1	)
								);
sbox in12(	
								.in(	matrix12	),
								.out(	matrix12_sub1	)
								);
sbox in13(	
								.in(	matrix13	), 
								.out(	matrix13_sub1	)
								);
sbox in20(	
								.in(	matrix20	), 
								.out(	matrix20_sub1	)
								);
sbox in21(	
							   .in(	matrix21	), 
								.out(	matrix21_sub1	)
								);
sbox in22(
                     	.in(	matrix22	), 
								.out(	matrix22_sub1	)
								);
sbox in23(
								.in(	matrix23	),
								.out(	matrix23_sub1	)
								);
sbox in30(	
								.in(	matrix30	),
								.out(	matrix30_sub1	)
								);
sbox in31(	
								.in(	matrix31	), 
								.out(	matrix31_sub1	)
								);
sbox in32(
								.in(	matrix32	), 
								.out(	matrix32_sub1	)
								);
sbox in33(	
								.in(	matrix33	), 
								.out(	matrix33_sub1	)
								);

endmodule
