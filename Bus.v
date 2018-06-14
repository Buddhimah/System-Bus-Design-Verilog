`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/12/2018 09:42:28 PM
// Design Name: 
// Module Name: Bus
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


module Bus(

input wire clk,
input wire rst,//reset
input wire sb_lock_m1,//lock request from m1 to arbiter
input wire req1,//request to aquire the bus from Master1
input wire req2,//request to aquire the bus from Master2
input wire sb_lock_m2,//lock request from m2 to arbiter
input wire [1:0] resp,//Responce from mux 
input wire [1:0] resp0,//responce from slave 0
input wire [1:0] resp1,//responce from slave 1
input wire [1:0] resp2,//responce from slave 2
input wire [13:0] HADDR_M1,//Address of Master 1
input wire [13:0] HADDR_M2,//Address of Master 2
input wire [31:0] RDATA_S0,//Read Data from Slave 0
input wire [31:0] RDATA_S1,//Read Data from Slave 1
input wire [31:0] RDATA_S2,//Read data from Slave 2
input wire [31:0] WDATA_M1,//Write data from M1
input wire [31:0] WDATA_M2,//Write data from M2
input wire [1:0] sb_split_ar,//Splitx from slave to arbiter 01-GNT Master 1 // 10-GNT Mater 2

output wire gnt1,// Grant for Master 1
output wire gnt2,//Grnt for Master 2
output wire [1:0] sb_masters,//00 - No master // 01 - Master 1 // 10 - Master 2
output wire sb_mastlock,//output from arbiter about master lock 1- lock 0-no lock to all slaves
output wire [31:0] RDATA,//Read data from slave mux
output wire [13:0] HADDR, // Address from Address mux
output wire sel_0,//input to slave 0 about its selection 1 -selected 
output wire sel_1,
output wire sel_2,
output wire [1:0] sel_slave,// from Decoder about the slave selected 
output wire [31:0] WDATA//Write data from write data mux

);


    Arbiter Arbiter_Instance(clk, 
     rst, 
     req1, 
     sb_lock_m1, 
     req2, 
     sb_lock_m2, 
     sb_split_ar,
     resp,
     gnt1,
     gnt2,
     sb_masters,
     sb_mastlock
     );
     
    top_module top_module_instance(
         resp0,
         resp1,
         resp2,
         HADDR_M1,
         HADDR_M2,
         RDATA_S0,
         RDATA_S1,
         sb_masters,
         RDATA_S2,
         WDATA_M1,
         WDATA_M2,
         resp,
         RDATA,
         HADDR,
         sel_0,
         sel_1,
         sel_slave,
         sel_2,
         WDATA
         );
         
endmodule
