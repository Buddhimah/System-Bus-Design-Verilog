`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/12/2018 05:17:28 PM
// Design Name: 
// Module Name: top_module
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


module top_module(
    input wire [1:0] resp0,
    input wire [1:0] resp1,
    input wire [1:0] resp2,
    input wire [13:0] HADDR_M1,
    input wire [13:0] HADDR_M2,
	input wire [31:0] RDATA_S0,
	input wire [31:0] RDATA_S1,
	input wire [1:0] sel,
	input wire [31:0] RDATA_S2,
	input wire [31:0] WDATA_M1,
	input wire [31:0] WDATA_M2,
	output wire [1:0] resp,
	output wire [31:0] RDATA,
	output wire [13:0] HADDR,
    output wire sel_0,
    output wire sel_1,
    output wire [1:0] sel_slave,
    output wire sel_2,
    output wire [31:0] WDATA

    );
    mux2_1 ADD_MUX(HADDR_M1,HADDR_M2,sel,HADDR);
    Decoder1_3 Dec(HADDR,sel_0,sel_1,sel_2,sel_slave);
    Mux_3_1 ReadMux(RDATA_S0,RDATA_S1,RDATA_S2,sel_slave,RDATA);
    Mux_3_1_Resp RespMux(resp0,resp1,resp2,sel_slave,resp);
    Mux_2_1_Write_Data WriteDataMux(WDATA_M1,WDATA_M2,sel,WDATA);
endmodule
