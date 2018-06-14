`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/12/2018 04:27:02 PM
// Design Name: 
// Module Name: test_decoder
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
// This is the test bench for decorder
//////////////////////////////////////////////////////////////////////////////////


module test_decoder;
reg [13:0] inp_Addr=0'b01111111111111;
reg HCLK=0;
wire sel_s0;
wire sel_s1;
wire  sel_s2;

Decoder1_3 Dec(
inp_Addr,
sel_s0,
sel_s1,
sel_s2
);
initial begin
	forever HCLK = #10 ~HCLK;
		
	end
	
endmodule
