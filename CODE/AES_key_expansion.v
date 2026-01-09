module AES_key_expansion(clk, rst, kenable, key, wo_0, wo_1, wo_2, wo_3);
input		clk;
input    rst;
input		kenable;
input	[127:0]	key;
output	[31:0]	wo_0, wo_1, wo_2, wo_3;
reg	[31:0]	w[3:0];
wire	[31:0]	tmp_w;
wire	[31:0]	subword;
wire	[31:0]	rcon;
wire  [127:0]  cipher_key;
wire  [31:0]   c_part1;
wire  [31:0]   c_part2;
wire  [31:0]   c_part3;
wire  [31:0]   c_part4;

assign cipher_key={c_part4,c_part3,c_part2,c_part1};
assign c_part1=w[0]^subword^rcon;
assign c_part2=w[0]^w[1]^subword^rcon;
assign c_part3=w[0]^w[2]^w[1]^subword^rcon;
assign c_part4=w[0]^w[3]^w[2]^w[1]^subword^rcon;

assign wo_0 = w[0];
assign wo_1 = w[1];
assign wo_2 = w[2];
assign wo_3 = w[3];
always @(posedge clk)	w[0] <=  kenable ? key[127:096] : c_part1;
always @(posedge clk)	w[1] <=  kenable ? key[095:064] : c_part2;
always @(posedge clk)	w[2] <=  kenable ? key[063:032] : c_part3;
always @(posedge clk)	w[3] <=  kenable ? key[031:000] : c_part4;
assign tmp_w = w[3];
sbox u0(	.in(tmp_w[23:16]), .out(subword[31:24]));
sbox u1(	.in(tmp_w[15:08]), .out(subword[23:16]));
sbox u2(	.in(tmp_w[07:00]), .out(subword[15:08]));
sbox u3(	.in(tmp_w[31:24]), .out(subword[07:00]));
aes_rcon r0(	.clk(clk), .kld(kenable), .out(rcon));
endmodule

