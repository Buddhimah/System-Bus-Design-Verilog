`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/12/2018 07:49:38 PM
// Design Name: 
// Module Name: Mux_3_1_Resp
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


module Mux_3_1_Resp( in_0  , // Mux first input
in_1      , // Mux Second input
in_2     ,// Mux Third Input
sel        , // Select input
mux_out      // Mux output
);
//-----------Input Ports---------------
input [1:0] sel ;
input [1:0] in_0;
input [1:0] in_1;
input [1:0] in_2;
//-----------Output Ports---------------
output [1:0] mux_out;
//------------Internal Variables--------
reg [1:0]   mux_out;
//-------------Code Starts Here---------
always @ (sel or in_0 or in_1 or in_2)
begin : MUX
  if (sel == 2'b00) begin
      mux_out = in_0;
  end else if(sel == 2'b01)begin
      mux_out = in_1 ;
      end
      else if(sel == 2'b10)begin
            mux_out = in_2 ;
            end
            else
            mux_out=in_0;//Default when no input given output is slave 0
            
  end
endmodule
