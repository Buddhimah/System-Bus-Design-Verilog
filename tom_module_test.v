`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/12/2018 07:35:29 PM
// Design Name: 
// Module Name: tom_module_test
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


module tom_module_test;
reg HCLK=0;
reg [1:0] resp_0 =0;
reg [1:0] resp_1 =1;
reg [1:0] resp_2 =2;
reg [13:0] HADDR_M1 =1;
reg [13:0] HADDR_M2 = 2;
reg [31:0] RDATA_S0 =0;
reg [31:0] RDATA_S1=1;
reg [1:0] sel=0;
reg [31:0] RDATA_S2=2;
reg [31:0] WDATA_M1=100;
reg [31:0] WDATA_M2=200;


wire [1:0] resp;
wire [31:0] R_DATA;
wire [13:0] HADDR;
wire sel_0;
wire sel_1;
wire sel_2;
wire [31:0] WDATA;

top_module top(resp_0,resp_1,resp_2,HADDR_M1,HADDR_M2,RDATA_S0,RDATA_S1,sel,RDATA_S2,WDATA_M1,WDATA_M2,resp,R_DATA,HADDR);
  


initial begin
	forever HCLK = #10 ~HCLK;
		
	end
	

endmodule
