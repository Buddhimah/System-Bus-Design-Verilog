`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/12/2018 11:46:53 PM
// Design Name: 
// Module Name: Bustest
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


module Bustest;

reg  clk;
reg  rst;//reset
reg  sb_lock_m1;//lock request from m1 to arbiter
reg  req1;//request to aquire the bus from Master1
reg  req2;//request to aquire the bus from Master2
reg  sb_lock_m2;//lock request from m2 to arbiter
reg  [1:0] resp;//Responce from mux 
reg  [1:0] resp0;//responce from slave 0
reg  [1:0] resp1;//responce from slave 1
reg  [1:0] resp2;//responce from slave 2
reg  [13:0] HADDR_M1;//Address of Master 1
reg  [13:0] HADDR_M2;//Address of Master 2
reg  [31:0] RDATA_S0;//Read Data from Slave 0
reg  [31:0] RDATA_S1;//Read Data from Slave 1
reg  [31:0] RDATA_S2;//Read data from Slave 2
reg  [31:0] WDATA_M1;//Write data from M1
reg  [31:0] WDATA_M2;//Write data from M2
reg  [1:0] sb_split_ar;//Splitx from slave to arbiter 01-GNT Master 1 // 10-GNT Mater 2

wire gnt1;// Grant for Master 1
wire gnt2;//Grnt for Master 2
 wire [1:0] sb_masters;//00 - No master // 01 - Master 1 // 10 - Master
 wire sb_mastlock;//output from arbiter about master lock 1- lock 0-no lock to all slaves
 wire [31:0] RDATA;//Read data from slave mux
 wire [13:0] HADDR; // Address from Address mux
 wire scl_0;//input to slave 0 about its selection 1 -selected 
 wire scl_1;
 wire scl_2;
 wire [1:0] sel_slave;// to Decoder about the slave selected 
 wire [31:0] WDATA;//Write data from write data mux\
 
always #5 clk=~clk;

initial begin
  clk=0;
 rst=1;//reset
  sb_lock_m1=0;//lock request from m1 to arbiter
  req1=1;//request to aquire the bus from Master1
 req2=0;//request to aquire the bus from Master2
  sb_lock_m2=0;//lock request from m2 to arbiter
 resp=0;//Responce from mux 
 resp0=0;//responce from slave 0
 resp1=0;//responce from slave 1
resp2=0;//responce from slave 2
 HADDR_M1=1;//Address of Master 1
HADDR_M2=2;//Address of Master 2
 RDATA_S0=0;//Read Data from Slave 0
 RDATA_S1=1;//Read Data from Slave 1
 RDATA_S2=2;//Read data from Slave 2
 WDATA_M1=1;//Write data from M1
 WDATA_M2=2;//Write data from M2
 sb_split_ar=0;
 #50

rst=0;//reset
 sb_lock_m1=0;//lock request from m1 to arbiter
 req1=1;//request to aquire the bus from Master1
req2=0;//request to aquire the bus from Master2
 sb_lock_m2=0;//lock request from m2 to arbiter
resp=0;//Responce from mux 
resp0=0;//responce from slave 0
resp1=0;//responce from slave 1
resp2=0;//responce from slave 2
HADDR_M1=1;//Address of Master 1
HADDR_M2=2;//Address of Master 2
RDATA_S0=0;//Read Data from Slave 0
RDATA_S1=1;//Read Data from Slave 1
RDATA_S2=2;//Read data from Slave 2
WDATA_M1=1;//Write data from M1
WDATA_M2=2;//Write data from M2
sb_split_ar=0;
#50
rst=0;//reset
 sb_lock_m1=0;//lock request from m1 to arbiter
 req1=0;//request to aquire the bus from Master1
req2=1;//request to aquire the bus from Master2
 sb_lock_m2=0;//lock request from m2 to arbiter
resp=0;//Responce from mux 
resp0=0;//responce from slave 0
resp1=0;//responce from slave 1
resp2=0;//responce from slave 2
HADDR_M1=1;//Address of Master 1
HADDR_M2=2;//Address of Master 2
RDATA_S0=0;//Read Data from Slave 0
RDATA_S1=1;//Read Data from Slave 1
RDATA_S2=2;//Read data from Slave 2
WDATA_M1=1;//Write data from M1
WDATA_M2=2;//Write data from M2
sb_split_ar=0;
#50
rst=0;//reset
 sb_lock_m1=1;//lock request from m1 to arbiter
 req1=1;//request to aquire the bus from Master1
req2=0;//request to aquire the bus from Master2
 sb_lock_m2=0;//lock request from m2 to arbiter
resp=0;//Responce from mux 
resp0=0;//responce from slave 0
resp1=0;//responce from slave 1
resp2=0;//responce from slave 2
HADDR_M1=1;//Address of Master 1
HADDR_M2=2;//Address of Master 2
RDATA_S0=0;//Read Data from Slave 0
RDATA_S1=1;//Read Data from Slave 1
RDATA_S2=2;//Read data from Slave 2
WDATA_M1=1;//Write data from M1
WDATA_M2=2;//Write data from M2
sb_split_ar=0;
#50
rst=0;//reset
 sb_lock_m1=1;//lock request from m1 to arbiter
 req1=0;//request to aquire the bus from Master1
req2=1;//request to aquire the bus from Master2
 sb_lock_m2=0;//lock request from m2 to arbiter
resp=0;//Responce from mux 
resp0=0;//responce from slave 0
resp1=0;//responce from slave 1
resp2=0;//responce from slave 2
HADDR_M1=1;//Address of Master 1
HADDR_M2=2;//Address of Master 2
RDATA_S0=0;//Read Data from Slave 0
RDATA_S1=1;//Read Data from Slave 1
RDATA_S2=2;//Read data from Slave 2
WDATA_M1=1;//Write data from M1
WDATA_M2=2;//Write data from M2
sb_split_ar=0;
#50
rst=0;//reset
 sb_lock_m1=0;//lock request from m1 to arbiter
 req1=0;//request to aquire the bus from Master1
req2=1;//request to aquire the bus from Master2
 sb_lock_m2=0;//lock request from m2 to arbiter
resp=0;//Responce from mux 
resp0=0;//responce from slave 0
resp1=0;//responce from slave 1
resp2=0;//responce from slave 2
HADDR_M1=1;//Address of Master 1
HADDR_M2=2;//Address of Master 2
RDATA_S0=0;//Read Data from Slave 0
RDATA_S1=1;//Read Data from Slave 1
RDATA_S2=2;//Read data from Slave 2
WDATA_M1=1;//Write data from M1
WDATA_M2=2;//Write data from M2
sb_split_ar=0;
#50
rst=0;//reset
 sb_lock_m1=0;//lock request from m1 to arbiter
 req1=1;//request to aquire the bus from Master1
req2=1;//request to aquire the bus from Master2
 sb_lock_m2=0;//lock request from m2 to arbiter
resp=0;//Responce from mux 
resp0=0;//responce from slave 0
resp1=0;//responce from slave 1
resp2=0;//responce from slave 2
HADDR_M1=1;//Address of Master 1
HADDR_M2=2;//Address of Master 2
RDATA_S0=0;//Read Data from Slave 0
RDATA_S1=1;//Read Data from Slave 1
RDATA_S2=2;//Read data from Slave 2
WDATA_M1=1;//Write data from M1
WDATA_M2=2;//Write data from M2
sb_split_ar=0;
#50
rst=0;//reset
 sb_lock_m1=0;//lock request from m1 to arbiter
 req1=0;//request to aquire the bus from Master1
req2=1;//request to aquire the bus from Master2
 sb_lock_m2=0;//lock request from m2 to arbiter
resp=0;//Responce from mux 
resp0=0;//responce from slave 0
resp1=0;//responce from slave 1
resp2=0;//responce from slave 2
HADDR_M1=1;//Address of Master 1
HADDR_M2=2;//Address of Master 2
RDATA_S0=0;//Read Data from Slave 0
RDATA_S1=1;//Read Data from Slave 1
RDATA_S2=2;//Read data from Slave 2
WDATA_M1=1;//Write data from M1
WDATA_M2=2;//Write data from M2
sb_split_ar=0;
#50
rst=0;//reset
 sb_lock_m1=0;//lock request from m1 to arbiter
 req1=0;//request to aquire the bus from Master1
req2=1;//request to aquire the bus from Master2
 sb_lock_m2=0;//lock request from m2 to arbiter
resp=3;//Responce from mux 
resp0=3;//responce from slave 0
resp1=0;//responce from slave 1
resp2=0;//responce from slave 2
HADDR_M1=1;//Address of Master 1
HADDR_M2=2;//Address of Master 2
RDATA_S0=0;//Read Data from Slave 0
RDATA_S1=1;//Read Data from Slave 1
RDATA_S2=2;//Read data from Slave 2
WDATA_M1=1;//Write data from M1
WDATA_M2=2;//Write data from M2
sb_split_ar=0;
#50
rst=0;//reset
 sb_lock_m1=0;//lock request from m1 to arbiter
 req1=0;//request to aquire the bus from Master1
req2=1;//request to aquire the bus from Master2
 sb_lock_m2=0;//lock request from m2 to arbiter
resp=0;//Responce from mux 
resp0=0;//responce from slave 0
resp1=0;//responce from slave 1
resp2=0;//responce from slave 2
HADDR_M1=1;//Address of Master 1
HADDR_M2=2;//Address of Master 2
RDATA_S0=0;//Read Data from Slave 0
RDATA_S1=1;//Read Data from Slave 1
RDATA_S2=2;//Read data from Slave 2
WDATA_M1=1;//Write data from M1
WDATA_M2=2;//Write data from M2
sb_split_ar=0;
#50
rst=0;//reset
 sb_lock_m1=0;//lock request from m1 to arbiter
 req1=0;//request to aquire the bus from Master1
req2=1;//request to aquire the bus from Master2
 sb_lock_m2=0;//lock request from m2 to arbiter
resp=0;//Responce from mux 
resp0=0;//responce from slave 0
resp1=0;//responce from slave 1
resp2=0;//responce from slave 2
HADDR_M1=1;//Address of Master 1
HADDR_M2=2;//Address of Master 2
RDATA_S0=0;//Read Data from Slave 0
RDATA_S1=1;//Read Data from Slave 1
RDATA_S2=2;//Read data from Slave 2
WDATA_M1=1;//Write data from M1
WDATA_M2=2;//Write data from M2
sb_split_ar=2;
#50
rst=0;//reset
 sb_lock_m1=0;//lock request from m1 to arbiter
 req1=1;//request to aquire the bus from Master1
req2=1;//request to aquire the bus from Master2
 sb_lock_m2=0;//lock request from m2 to arbiter
resp=0;//Responce from mux 
resp0=0;//responce from slave 0
resp1=0;//responce from slave 1
resp2=0;//responce from slave 2
HADDR_M1=1;//Address of Master 1
HADDR_M2=2;//Address of Master 2
RDATA_S0=0;//Read Data from Slave 0
RDATA_S1=1;//Read Data from Slave 1
RDATA_S2=2;//Read data from Slave 2
WDATA_M1=1;//Write data from M1
WDATA_M2=2;//Write data from M2
sb_split_ar=0;
end
Bus bus_instance(clk,rst,sb_lock_m1 ,req1,req2,sb_lock_m2,resp,resp0,resp1,resp2,HADDR_M1,HADDR_M2,RDATA_S0,RDATA_S1,RDATA_S2,WDATA_M1,
WDATA_M2,
sb_split_ar,
gnt1,
gnt2,
sb_masters,
sb_mastlock,
RDATA,
HADDR,
scl_0,
scl_1,
scl_2,
sel_slave,
WDATA

);


endmodule
