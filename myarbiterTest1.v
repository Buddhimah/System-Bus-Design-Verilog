`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/10/2018 06:52:22 PM
// Design Name: 
// Module Name: myarbiterTest1
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

//`include "myArbiter.v"
module myarbiterTes();

reg clk;
reg rst;

reg req1;
reg lockm1;

reg req2;
reg lockm2;

reg [31:0] sb_addr_ar;
reg  [1:0] sb_split_ar;
 reg [1:0] sb_trans_ar;
reg [2:0] sb_burst_ar;
reg [1:0] sb_resp_ar;
reg sb_ready_ar;

wire gnt1;
wire gnt2;
wire [1:0] hmasters;
wire hmasterLock;


always #1 clk=~clk;

initial begin
clk=0;
rst=1;
#5 rst=0;

//--------------------------------------

req1=1;  //master1 reqest
lockm1=0;

req2=0;
lockm2=0;

//sb_addr_ar=32'b4;
sb_addr_ar=3;
sb_split_ar=2'b01;
sb_trans_ar=2'b00;
sb_burst_ar=3'b000;
 sb_resp_ar=2'b00;
sb_ready_ar=1'b1;
#5 
//------------------------------------
req1=0;
lockm1=0;

req2=1;   // master 2 reqest
lockm2=0;

//sb_addr_ar=32'b4;
sb_addr_ar=4;
sb_split_ar=2'b01;
sb_trans_ar=2'b00;
sb_burst_ar=3'b000;
 sb_resp_ar=2'b00;
sb_ready_ar=1'b1;
#5
//---------------------------------

req1=1;     // master 1 and master 2 request
lockm1=0;

req2=1;
lockm2=0;

//sb_addr_ar=32'b4;
sb_addr_ar=7;
sb_split_ar=1'b0;
sb_trans_ar=2'b00;
sb_burst_ar=3'b000;
 sb_resp_ar=2'b00;
sb_ready_ar=1'b1;
#5

//-------------------------------------

req1=1;     // master 1 and master 2 request
lockm1=0;

req2=1;
lockm2=0;

//sb_addr_ar=32'b4;
sb_addr_ar=7;
sb_split_ar=1'b0;
sb_trans_ar=2'b00;
sb_burst_ar=3'b000;
 sb_resp_ar=2'b11;
sb_ready_ar=1'b1;
//#5
//$finish
end
//$finish
//-----------------------------------------------------
Arbiter A(
clk,
 rst,

 req1,
lockm1,
 
 req2,
 lockm1,

 sb_addr_ar,
 sb_split_ar,
 sb_trans_ar,
 sb_burst_ar,
 sb_resp_ar,
 sb_ready_ar,
 
 gnt1,
 gnt2,
 hmasters,
 hmasterLock
 );
 endmodule
