 

module AES_decryption_top(clk, rst, enable, key, plaintext, FINAL_ciphertextout );
input		clk, rst;
input		enable;
input	[127:0]	key;
input	[127:0]	plaintext;
output	[127:0]	FINAL_ciphertextout;

wire ROUND_VALID;
reg POST_ROUND;
reg	[127:0]	TEXT_IN;
reg [3:0]ITERATION;
reg POST_VALID; 
wire	[127:0]	ciphertextout1;
wire	[127:0]	TEXT_OUT;

wire[127:0]	FINAL_ciphertextout;

reg [4:0]c;

reg [127:0]TEXT_OUT_FINAL_IN;
always @(posedge clk)
begin
if (rst)
begin
    c<=0;
end
else if (enable)
begin
    c<=c+1;
end
end


initial
begin
  
TEXT_IN <=0;
POST_VALID <=1'b1;
ITERATION <=0;
end

always @(posedge c[4])
begin
    if (ROUND_VALID && POST_VALID && (ITERATION< 4'd9))
      begin
         TEXT_IN <= ciphertextout1;
         POST_VALID <=1'b0;
         POST_ROUND <=1'b0;
         ITERATION <= ITERATION+1;
         TEXT_OUT_FINAL_IN<='b0;
      end
     else if (ITERATION< 4'd9)
      begin
         TEXT_IN <= TEXT_OUT;
         POST_VALID <=1'b0;
         POST_ROUND <=1'b0;
         ITERATION <= ITERATION+1;
         TEXT_OUT_FINAL_IN<='b0;
      end
      else
      begin
         TEXT_IN <= TEXT_IN;
         POST_VALID <=1'b0;
         POST_ROUND <=1'b1;
         ITERATION <= ITERATION;
         TEXT_OUT_FINAL_IN<=TEXT_OUT;
      end
   end  

assign ROUND_VALID=(|ciphertextout1 !=0)?1'b1:1'b0;
 
AES_AR ins1(
       clk,
       rst,
       enable,
       key,
       plaintext,
       ciphertextout1
       );
       
AES_FR_DEC ins2(
       .clk(clk),
       .rst(rst),
       .enable(enable),
       .key(key),
       .text_in(TEXT_IN),
       .text_out(TEXT_OUT)
       );      
       
 AES_AR ins14(
       clk,
       rst,
       POST_ROUND,
       key,
       TEXT_OUT_FINAL_IN,
       FINAL_ciphertextout
       );
                   
endmodule
