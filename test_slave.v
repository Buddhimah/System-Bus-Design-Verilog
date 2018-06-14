`timescale 1ns / 100ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/10/2018 10:24:01 PM
// Design Name: 
// Module Name: test_slave
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


module test_slave;
reg HWRITE=0;
reg HRESETn=1;
reg HSELx=1;
reg HCLK=0;
reg [1:0] TRANS=0'b00;
reg [13:0] ADDR=0'b00000000000001;
reg [7:0] HWDATA=0'd10;
reg [1:0] HSIZE=0'b00;
reg [2:0] HBURST=0'b000;
reg  HMASTER=0;
reg MASTLOCK=1;
wire HREADY;
wire [1:0] HRESP;
wire [7:0] HRDATA;
wire [1:0] HSPLITx;


AHB_Slave AHB_Slave_0(HREADY,
					HRESP,
					HRDATA,
					HSPLITx,
                             HSELx,
					ADDR,
					HWRITE,
				    TRANS,
					HSIZE,
					HBURST,
					HWDATA,
					HRESETn,
					HCLK,
					HMASTER,
					MASTLOCK);
initial begin
	forever HCLK = #10 ~HCLK;
		
	end
	


endmodule
