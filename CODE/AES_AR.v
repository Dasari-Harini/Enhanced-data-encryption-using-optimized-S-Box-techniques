module AES_AR(clk, rst, enable, key, plaintext, ciphertextout );
input		clk, rst;
input		enable;
input	[127:0]	key;
input	[127:0]	plaintext;
output	[127:0]	ciphertextout;


//
// Local Wires
//

wire	[31:0]	w0, w1, w2, w3; 
wire	[127:0]	ciphertextout;
reg	[7:0]	matrix00, matrix01, matrix02, matrix03;
reg	[7:0]	matrix10, matrix11, matrix12, matrix13;
reg	[7:0]	matrix20, matrix21, matrix22, matrix23;
reg	[7:0]	matrix30, matrix31, matrix32, matrix33;

//
//  AddRoundKey
//

assign w0=key[031:000];
assign w1=key[063:032];
assign w2=key[095:064];
assign w3=key[127:096];

assign ciphertextout = {matrix00,matrix10,matrix20,matrix30,matrix01,matrix11,matrix21,matrix31,matrix02,matrix12,matrix22,matrix32,matrix03,matrix13,matrix23,matrix33};

always @(posedge clk)	matrix33 <=  enable ? plaintext[007:000] ^ w3[07:00] : plaintext[007:000];
always @(posedge clk)	matrix23 <=  enable ? plaintext[015:008] ^ w3[15:08] : plaintext[015:008];
always @(posedge clk)	matrix13 <=  enable ? plaintext[023:016] ^ w3[23:16] : plaintext[023:016];
always @(posedge clk)	matrix03 <=  enable ? plaintext[031:024] ^ w3[31:24] : plaintext[031:024];
always @(posedge clk)	matrix32 <=  enable ? plaintext[039:032] ^ w2[07:00] : plaintext[039:032];
always @(posedge clk)	matrix22 <=  enable ? plaintext[047:040] ^ w2[15:08] : plaintext[047:040];
always @(posedge clk)	matrix12 <=  enable ? plaintext[055:048] ^ w2[23:16] : plaintext[055:048];
always @(posedge clk)	matrix02 <=  enable ? plaintext[063:056] ^ w2[31:24] : plaintext[063:056];
always @(posedge clk)	matrix31 <=  enable ? plaintext[071:064] ^ w1[07:00] : plaintext[071:064];
always @(posedge clk)	matrix21 <=  enable ? plaintext[079:072] ^ w1[15:08] : plaintext[079:072];
always @(posedge clk)	matrix11 <=  enable ? plaintext[087:080] ^ w1[23:16] : plaintext[087:080];
always @(posedge clk)	matrix01 <=  enable ? plaintext[095:088] ^ w1[31:24] : plaintext[095:088];
always @(posedge clk)	matrix30 <=  enable ? plaintext[103:096] ^ w0[07:00] : plaintext[103:096];
always @(posedge clk)	matrix20 <=  enable ? plaintext[111:104] ^ w0[15:08] : plaintext[111:104];
always @(posedge clk)	matrix10 <=  enable ? plaintext[119:112] ^ w0[23:16] : plaintext[119:112];
always @(posedge clk)	matrix00 <=  enable ? plaintext[127:120] ^ w0[31:24] : plaintext[127:120];



endmodule
