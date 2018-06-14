`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/12/2018 03:17:16 PM
// Design Name: 
// Module Name: Mux2_1_Write
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
// This is created to connect Master and Slave with WDATA with 32 bit bus
//
//////////////////////////////////////////////////////////////////////////////////


module  mux2_1_Write(
in_0      , // Mux first input
in_1      , // Mux Second input
sel        , // Select input
mux_out      // Mux output
);
//-----------Input Ports---------------
input  sel ;
input [31:0] in_0;
input [31:0] in_1;
//-----------Output Ports---------------
output [31:0] mux_out;
//------------Internal Variables--------
reg [31:0]   mux_out;
//-------------Code Starts Here---------
always @ (sel or in_0 or in_1)
begin : MUX
  if (sel == 0) begin
      mux_out = in_0;
  end else begin
      mux_out = in_1 ;
  end
end

endmodule 