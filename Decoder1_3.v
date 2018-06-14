`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/12/2018 03:47:34 PM
// Design Name: 
// Module Name: Decoder1_3
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


module Decoder1_3(
inp_Addr,// This is the input address from the Address mux
sel_s0,// Select pin that goes to slave0 this goes high when slave 0 selected 
sel_s1,//Select pin that goes to slave1 this goes high when slave 1 selected 
sel_s2,//Select pin that goes to slave2 this goes high when slave 2 selected 
sel_slave//This is a indication to ReadMux and RespMux about the slave selected 00-Slave 0    01-Slave 1    10 -Slave 2
    );
    
 input [13:0] inp_Addr;
 output sel_s0;
 output sel_s1;
 output sel_s2;
 output [1:0] sel_slave;
 
 reg sel_s0;
 reg sel_s1;
 reg sel_s2;
 reg [1:0] sel_slave;
 
 always @ (inp_Addr)
 begin : MUX
   if (inp_Addr[13:12] == 2'b00) begin
       sel_s0=1;
       sel_s1=0;
       sel_s2=0;
       sel_slave=0;
   end else if(inp_Addr[13:12] == 2'b01) begin
       sel_s0=0;
          sel_s1=1;
          sel_s2=0;
       sel_slave=1;
   end else if(inp_Addr [13:12]== 2'b10)
        begin
        sel_s0=0;
                  sel_s1=0;
                  sel_s2=1;
        sel_slave=2;
        end
        else
        begin
        sel_s0=1;
        sel_slave=0;
        end
        
        
 end
endmodule
