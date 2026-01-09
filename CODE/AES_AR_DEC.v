module AES_FR_DEC(clk, rst, enable, key, text_in, text_out );
input		clk, rst;
input	 enable;

input	[127:0]	key;
input	[127:0]	text_in;
output	[127:0]	text_out;


//
// Local Wires
//

wire	[31:0]	wk0, wk1, wk2, wk3;
reg	[31:0]	w0, w1, w2, w3;
reg	[127:0]	text_in_r;
reg	[127:0]	text_out;
reg	[7:0]	matrix00, matrix01, matrix02, matrix03;
reg	[7:0]	matrix10, matrix11, matrix12, matrix13;
reg	[7:0]	matrix20, matrix21, matrix22, matrix23;
reg	[7:0]	matrix30, matrix31, matrix32, matrix33;
wire	[7:0]	matrix00_next1, matrix01_next1, matrix02_next1, matrix03_next1;
wire	[7:0]	matrix10_next1, matrix11_next1, matrix12_next1, matrix13_next1;
wire	[7:0]	matrix20_next1, matrix21_next1, matrix22_next1, matrix23_next1;
wire	[7:0]	matrix30_next1, matrix31_next1, matrix32_next1, matrix33_next1;

reg	[7:0]	matrix00_next, matrix01_next, matrix02_next, matrix03_next;
reg	[7:0]	matrix10_next, matrix11_next, matrix12_next, matrix13_next;
reg	[7:0]	matrix20_next, matrix21_next, matrix22_next, matrix23_next;
reg	[7:0]	matrix30_next, matrix31_next, matrix32_next, matrix33_next;

wire	[7:0]	matrix00_sub1, matrix01_sub1, matrix02_sub1, matrix03_sub1;
wire	[7:0]	matrix10_sub1, matrix11_sub1, matrix12_sub1, matrix13_sub1;
wire	[7:0]	matrix20_sub1, matrix21_sub1, matrix22_sub1, matrix23_sub1;
wire	[7:0]	matrix30_sub1, matrix31_sub1, matrix32_sub1, matrix33_sub1;


reg	[7:0]	matrix00_sub, matrix01_sub, matrix02_sub, matrix03_sub;
reg	[7:0]	matrix10_sub, matrix11_sub, matrix12_sub, matrix13_sub;
reg	[7:0]	matrix20_sub, matrix21_sub, matrix22_sub, matrix23_sub;
reg	[7:0]	matrix30_sub, matrix31_sub, matrix32_sub, matrix33_sub;



wire	[7:0]	matrix00_sr1, matrix01_sr1, matrix02_sr1, matrix03_sr1;
wire	[7:0]	matrix10_sr1, matrix11_sr1, matrix12_sr1, matrix13_sr1;
wire	[7:0]	matrix20_sr1, matrix21_sr1, matrix22_sr1, matrix23_sr1;
wire	[7:0]	matrix30_sr1, matrix31_sr1, matrix32_sr1, matrix33_sr1;


reg	[7:0]	matrix00_sr, matrix01_sr, matrix02_sr, matrix03_sr;
reg	[7:0]	matrix10_sr, matrix11_sr, matrix12_sr, matrix13_sr;
reg	[7:0]	matrix20_sr, matrix21_sr, matrix22_sr, matrix23_sr;
reg	[7:0]	matrix30_sr, matrix31_sr, matrix32_sr, matrix33_sr;


reg	[7:0]	matrix00_ark, matrix01_ark, matrix02_ark, matrix03_ark;
reg	[7:0]	matrix10_ark, matrix11_ark, matrix12_ark, matrix13_ark;
reg	[7:0]	matrix20_ark, matrix21_ark, matrix22_ark, matrix23_ark;
reg	[7:0]	matrix30_ark, matrix31_ark, matrix32_ark, matrix33_ark;

wire	[7:0]	matrix00_ark1, matrix01_ark1, matrix02_ark1, matrix03_ark1;
wire	[7:0]	matrix10_ark1, matrix11_ark1, matrix12_ark1, matrix13_ark1;
wire	[7:0]	matrix20_ark1, matrix21_ark1, matrix22_ark1, matrix23_ark1;
wire	[7:0]	matrix30_ark1, matrix31_ark1, matrix32_ark1, matrix33_ark1;
reg enable_r;

always @(posedge clk)	if(enable)	text_in_r <=  text_in;

always @(posedge clk)	enable_r <=  enable;


//
// Initial Permutation
//

always @(posedge clk)	matrix33 <=  enable_r ? text_in_r[007:000] ^ w3[07:00] : matrix33_next;
always @(posedge clk)	matrix23 <=  enable_r ? text_in_r[015:008] ^ w3[15:08] : matrix23_next;
always @(posedge clk)	matrix13 <=  enable_r ? text_in_r[023:016] ^ w3[23:16] : matrix13_next;
always @(posedge clk)	matrix03 <=  enable_r ? text_in_r[031:024] ^ w3[31:24] : matrix03_next;
always @(posedge clk)	matrix32 <=  enable_r ? text_in_r[039:032] ^ w2[07:00] : matrix32_next;
always @(posedge clk)	matrix22 <=  enable_r ? text_in_r[047:040] ^ w2[15:08] : matrix22_next;
always @(posedge clk)	matrix12 <=  enable_r ? text_in_r[055:048] ^ w2[23:16] : matrix12_next;
always @(posedge clk)	matrix02 <=  enable_r ? text_in_r[063:056] ^ w2[31:24] : matrix02_next;
always @(posedge clk)	matrix31 <=  enable_r ? text_in_r[071:064] ^ w1[07:00] : matrix31_next;
always @(posedge clk)	matrix21 <=  enable_r ? text_in_r[079:072] ^ w1[15:08] : matrix21_next;
always @(posedge clk)	matrix11 <=  enable_r ? text_in_r[087:080] ^ w1[23:16] : matrix11_next;
always @(posedge clk)	matrix01 <=  enable_r ? text_in_r[095:088] ^ w1[31:24] : matrix01_next;
always @(posedge clk)	matrix30 <=  enable_r ? text_in_r[103:096] ^ w0[07:00] : matrix30_next;
always @(posedge clk)	matrix20 <=  enable_r ? text_in_r[111:104] ^ w0[15:08] : matrix20_next;
always @(posedge clk)	matrix10 <=  enable_r ? text_in_r[119:112] ^ w0[23:16] : matrix10_next;
always @(posedge clk)	matrix00 <=  enable_r ? text_in_r[127:120] ^ w0[31:24] : matrix00_next;


//
// Round 
//


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
 matrix00_sr <= matrix00_sr1;
 matrix01_sr <= matrix01_sr1;
 matrix02_sr <= matrix02_sr1;
 matrix03_sr <= matrix03_sr1;
 matrix10_sr <= matrix10_sr1;
 matrix11_sr <= matrix11_sr1;
 matrix12_sr <= matrix12_sr1;
 matrix13_sr <= matrix13_sr1;
 matrix20_sr <= matrix20_sr1;
 matrix21_sr <= matrix21_sr1;
 matrix22_sr <= matrix22_sr1;
 matrix23_sr <= matrix23_sr1;
 matrix30_sr <= matrix30_sr1;
 matrix31_sr <= matrix31_sr1;
 matrix32_sr <= matrix32_sr1;
 matrix33_sr <= matrix33_sr1;
 end
end



assign matrix00_sr1 = matrix00;
assign matrix01_sr1 = matrix01;
assign matrix02_sr1 = matrix02;
assign matrix03_sr1 = matrix03;
assign matrix10_sr1 = matrix13;
assign matrix11_sr1 = matrix10;
assign matrix12_sr1 = matrix11;
assign matrix13_sr1 = matrix12;
assign matrix20_sr1 = matrix22;
assign matrix21_sr1 = matrix23;
assign matrix22_sr1 = matrix20;
assign matrix23_sr1 = matrix21;
assign matrix30_sr1 = matrix31;
assign matrix31_sr1 = matrix32;
assign matrix32_sr1 = matrix33;
assign matrix33_sr1 = matrix30;




always @(posedge clk)
begin
    if (rst)
    begin    
    matrix00_ark <= 0;
 matrix01_ark <= 0;
 matrix02_ark <= 0;
 matrix03_ark <= 0;
 matrix10_ark <= 0;
 matrix11_ark <= 0;
 matrix12_ark <= 0;
 matrix13_ark <= 0;
 matrix20_ark <= 0;
 matrix21_ark <= 0;
 matrix22_ark <= 0;
 matrix23_ark <= 0;
 matrix30_ark <= 0;
 matrix31_ark <= 0;
 matrix32_ark <= 0;
 matrix33_ark <= 0;
 end
 else    
 begin
 matrix00_ark <= matrix00_ark1;
 matrix01_ark <= matrix01_ark1;
 matrix02_ark <= matrix02_ark1;
 matrix03_ark <= matrix03_ark1;
 matrix10_ark <= matrix10_ark1;
 matrix11_ark <= matrix11_ark1;
 matrix12_ark <= matrix12_ark1;
 matrix13_ark <= matrix13_ark1;
 matrix20_ark <= matrix20_ark1;
 matrix21_ark <= matrix21_ark1;
 matrix22_ark <= matrix22_ark1;
 matrix23_ark <= matrix23_ark1;
 matrix30_ark <= matrix30_ark1;
 matrix31_ark <= matrix31_ark1;
 matrix32_ark <= matrix32_ark1;
 matrix33_ark <= matrix33_ark1;
 end
end



assign matrix00_ark1 = matrix00_sub ^ w0[31:24];
assign matrix01_ark1 = matrix01_sub ^ w1[31:24];
assign matrix02_ark1 = matrix02_sub ^ w2[31:24];
assign matrix03_ark1 = matrix03_sub ^ w3[31:24];
assign matrix10_ark1 = matrix10_sub ^ w0[23:16];
assign matrix11_ark1 = matrix11_sub ^ w1[23:16];
assign matrix12_ark1 = matrix12_sub ^ w2[23:16];
assign matrix13_ark1 = matrix13_sub ^ w3[23:16];
assign matrix20_ark1 = matrix20_sub ^ w0[15:08];
assign matrix21_ark1 = matrix21_sub ^ w1[15:08];
assign matrix22_ark1 = matrix22_sub ^ w2[15:08];
assign matrix23_ark1 = matrix23_sub ^ w3[15:08];
assign matrix30_ark1 = matrix30_sub ^ w0[07:00];
assign matrix31_ark1 = matrix31_sub ^ w1[07:00];
assign matrix32_ark1 = matrix32_sub ^ w2[07:00];
assign matrix33_ark1 = matrix33_sub ^ w3[07:00];



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

assign {matrix00_next1, matrix10_next1, matrix20_next1, matrix30_next1} = inv_mix_col(matrix00_ark,matrix10_ark,matrix20_ark,matrix30_ark);
assign {matrix01_next1, matrix11_next1, matrix21_next1, matrix31_next1} = inv_mix_col(matrix01_ark,matrix11_ark,matrix21_ark,matrix31_ark);
assign {matrix02_next1, matrix12_next1, matrix22_next1, matrix32_next1} = inv_mix_col(matrix02_ark,matrix12_ark,matrix22_ark,matrix32_ark);
assign {matrix03_next1, matrix13_next1, matrix23_next1, matrix33_next1} = inv_mix_col(matrix03_ark,matrix13_ark,matrix23_ark,matrix33_ark);


//
// Final Text Output
//

always @(posedge clk) text_out[127:120] <=  matrix00_ark;
always @(posedge clk) text_out[095:088] <=  matrix01_ark;
always @(posedge clk) text_out[063:056] <=  matrix02_ark;
always @(posedge clk) text_out[031:024] <=  matrix03_ark;
always @(posedge clk) text_out[119:112] <=  matrix10_ark;
always @(posedge clk) text_out[087:080] <=  matrix11_ark;
always @(posedge clk) text_out[055:048] <=  matrix12_ark;
always @(posedge clk) text_out[023:016] <=  matrix13_ark;
always @(posedge clk) text_out[111:104] <=  matrix20_ark;
always @(posedge clk) text_out[079:072] <=  matrix21_ark;
always @(posedge clk) text_out[047:040] <=  matrix22_ark;
always @(posedge clk) text_out[015:008] <=  matrix23_ark;
always @(posedge clk) text_out[103:096] <=  matrix30_ark;
always @(posedge clk) text_out[071:064] <=  matrix31_ark;
always @(posedge clk) text_out[039:032] <=  matrix32_ark;
always @(posedge clk) text_out[007:000] <=  matrix33_ark;


//
//Inverse mix colomn Functions
//

function [31:0] inv_mix_col;
input	[7:0]	s0,s1,s2,s3;
begin
inv_mix_col[31:24]=pmul_e(s0)^pmul_b(s1)^pmul_d(s2)^pmul_9(s3);
inv_mix_col[23:16]=pmul_9(s0)^pmul_e(s1)^pmul_b(s2)^pmul_d(s3);
inv_mix_col[15:08]=pmul_d(s0)^pmul_9(s1)^pmul_e(s2)^pmul_b(s3);
inv_mix_col[07:00]=pmul_b(s0)^pmul_d(s1)^pmul_9(s2)^pmul_e(s3);
end
endfunction


function [7:0] pmul_e;
input [7:0] b;
reg [7:0] two,four,eight;
begin
two=xtime(b);four=xtime(two);eight=xtime(four);pmul_e=eight^four^two;
end
endfunction

function [7:0] pmul_9;
input [7:0] b;
reg [7:0] two,four,eight;
begin
two=xtime(b);four=xtime(two);eight=xtime(four);pmul_9=eight^b;
end
endfunction

function [7:0] pmul_d;
input [7:0] b;
reg [7:0] two,four,eight;
begin
two=xtime(b);four=xtime(two);eight=xtime(four);pmul_d=eight^four^b;
end
endfunction

function [7:0] pmul_b;
input [7:0] b;
reg [7:0] two,four,eight;
begin
two=xtime(b);four=xtime(two);eight=xtime(four);pmul_b=eight^two^b;
end
endfunction

function [7:0] xtime;
input [7:0] b;xtime={b[6:0],1'b0}^(8'h1b&{8{b[7]}});
endfunction


//
// Key Buffer
//



always @(posedge clk)	{w3, w2, w1, w0} <=   {wk3, wk2, wk1, wk0};


//
// Modules
//

AES_key_expansion u0(
	.clk(		clk	),
	.rst  (rst),
	.kenable(		enable	),
	.key(		key[127:0]	),
	.wo_0(		wk0	),
	.wo_1(		wk1	),
	.wo_2(		wk2	),
	.wo_3(		wk3	));

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


inv_sbox us00(	 .in(	matrix00_sr	),	.out(	matrix00_sub1	));
inv_sbox us01(		.in(	matrix01_sr	),	.out(	matrix01_sub1	));
inv_sbox us02(		.in(	matrix02_sr	),	.out(	matrix02_sub1	));
inv_sbox us03(		.in(	matrix03_sr	),	.out(	matrix03_sub1	));
inv_sbox us10(		.in(	matrix10_sr	),	.out(	matrix10_sub1	));
inv_sbox us11(		.in(	matrix11_sr	),	.out(	matrix11_sub1	));
inv_sbox us12(		.in(	matrix12_sr	),	.out(	matrix12_sub1	));
inv_sbox us13(		.in(	matrix13_sr	),	.out(	matrix13_sub1	));
inv_sbox us20(		.in(	matrix20_sr	),	.out(	matrix20_sub1	));
inv_sbox us21(		.in(	matrix21_sr	),	.out(	matrix21_sub1	));
inv_sbox us22(		.in(	matrix22_sr	),	.out(	matrix22_sub1	));
inv_sbox us23(		.in(	matrix23_sr	),	.out(	matrix23_sub1	));
inv_sbox us30(		.in(	matrix30_sr	),	.out(	matrix30_sub1	));
inv_sbox us31(		.in(	matrix31_sr	),	.out(	matrix31_sub1	));
inv_sbox us32(		.in(	matrix32_sr	),	.out(	matrix32_sub1	));
inv_sbox us33(		.in(	matrix33_sr	),	.out(	matrix33_sub1	));

endmodule
