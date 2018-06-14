`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/12/2018 02:44:07 PM
// Design Name: 
// Module Name: mux2_1
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
// This mux is designed for Address and Control Signals  [13:0] ADDR
//////////////////////////////////////////////////////////////////////////////////
module  mux2_1(
in_0      , // Mux first input
in_1      , // Mux Second input
sel        , // Select input
mux_out      // Mux output
);
//-----------Input Ports---------------
input  [1:0] sel ;
input [13:0] in_0;
input [13:0] in_1;
//-----------Output Ports---------------
output [13:0] mux_out;
//------------Internal Variables--------
reg [13:0]   mux_out;
//-------------Code Starts Here---------
always @ (sel or in_0 or in_1)
begin : MUX
  if (sel == 1) begin
      mux_out = in_0;
  end else begin
      mux_out = in_1 ;
  end
end

endmodule 
