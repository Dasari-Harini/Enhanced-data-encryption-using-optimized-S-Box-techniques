 

module AES_testbench();
  parameter n = 128;
  reg clk; 
  reg rst;
  reg enb;
  reg [n-1:0] plaintext; 
  reg [n-1:0] key; 
   
// parameter declatarion


// input parameters



// output parameters

wire  [n-1:0] FINAL_out; 
wire  [n-1:0] p;
// net signals
 

assign p="2345678jkfowowkj";
 

// module instantiation 
 
top AINS(clk, rst, enb, key, plaintext, FINAL_out);

 always #5 clk=~clk;

initial
begin
   clk=0;
   enb=0;
   key=0;
   rst=1;
   plaintext='b0;
#10rst=0;
   enb=1;
   plaintext=p;
   key=128'd80985098094558981234567890;
end




endmodule 



