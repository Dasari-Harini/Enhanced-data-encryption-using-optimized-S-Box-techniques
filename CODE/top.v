`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:57:38 01/07/2022 
// Design Name: 
// Module Name:    top 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module top(clk, rst, enable, keyin, plaintext, FINAL_out);

input		clk, rst;
input		enable;
input	[127:0]	keyin;
input	[127:0]	plaintext;
output [127:0]FINAL_out;

wire	[127:0]	FINAL_ciphertextout;
wire out_valid;

AES_encryption_top e1(clk, rst, enable, keyin, plaintext, FINAL_ciphertextout ,out_valid);
AES_decryption_top d1(clk, rst, out_valid, keyin, FINAL_ciphertextout, FINAL_out );

endmodule
