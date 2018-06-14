`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/10/2018 10:10:10 PM
// Design Name: 
// Module Name: AHB_Slave
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

`define IDLE        3'b000
`define ACTIVE      3'b001
`define AGAIN       3'b010
`define LITTLE      3'b011 
`define TIME_PASS   3'b111
`define WRITE_BURST 3'b100
`define READ_BURST  3'b101


`define NON_SEQ     2'd0
`define SEQ 	   2'd1
`define BUSY 	   2'd2
`define IDLE_TRANS  2'd3

`define OKAY  2'b00
`define ERROR 2'b01
`define RETRY 2'b10
`define SPLIT 2'b11
 



module AHB_Slave( HREADY,//output signal to the arbiter 
					HRESP,//responce of the Slave to the arbiter 11-Split
					HRDATA,//Read data from slave to Read Data Mux
					HSPLITx,//Splitx signal that request the master to arbiter
                             HSELx,//Selection input that is given by decoder to the Slave
					ADDR,//Address 
					HWRITE,//Write signal if this is zero that means its read operation
				    TRANS,//This is not used in our simulation 
					HSIZE,//This is not used in our simulation 
					HBURST,//This is not used in our simulation 
					HWDATA,//Write data from write data mux
					HRESETn,//Reset signal
					HCLK,//Clock
					HMASTER,//Master if 0- Master1 else master2 
					MASTLOCK//Indication whether their is a lock in current transaction
);

output  HREADY;
output [1:0] HRESP;
output [7:0] HRDATA;
output [1:0] HSPLITx;
input MASTLOCK;//Master lock 0-Master has no Lock 1- Master Has lock
input [1:0] TRANS;//Input value of Trans 00-Non Seq 01-Seq 11-Idle 10-Busy
input HSELx,HWRITE,HRESETn,HCLK;
input [13:0] ADDR;//14 Bit address First two bits to identify slave next 12 bits for addr in 11 bit addr slave first of 12 bit becomes zero
reg HMASTLOCK;
reg [11:0] HADDR;
input [7:0] HWDATA;
input  [1:0] HSIZE;//00- 8 bit 01- 16 bit 10 - 32 bit
input [2:0] HBURST; 
input  HMASTER;//master 1 -      master 2 -1
reg [1:0] HTRANS;
reg [7:0] HRDATA;

reg  HREADY;
reg  [1:0] HRESP;
reg  [1:0] HSPLITx;
reg  [4:0] local_addr;
reg  [3:0]SPLIT_RESP;
reg [7:0] memory_slave [2047:0]; //This is a 2K memory slave 
reg[2:0] ps_slave1,ns_slave1;
initial 
begin
ns_slave1=`IDLE;
memory_slave[8'b00000000]=8'd10;//Hardcoed Memory Values
memory_slave[8'b00000001]=8'd20;
memory_slave[8'b00000010]=8'd30;
HMASTLOCK=MASTLOCK;
end
integer count;


always @ (ADDR or MASTLOCK or ps_slave1 or ns_slave1 or HRESETn or 
           HSELx or HWDATA or HWRITE )

begin
HADDR=ADDR[10:0];

case (ps_slave1)

`IDLE  :begin
         
         if(!HRESETn && HSELx==0)
         ns_slave1=`IDLE;
         else
         begin 
        // HSELx=1'd1;
	    HREADY=1'b1;
	//HMASTLOCK=1'b0;
       //  HWRITE=1'b1;
         //HBURST=3'b001;
        // HADDR=$random %32;
         local_addr=5'b0;
         ns_slave1=`ACTIVE;
end
         end 

`ACTIVE : begin
         if(HRESETn && HSELx && HWRITE && HREADY)
begin
         HREADY=1'b0;
         ns_slave1=`WRITE_BURST;
end
         else if(HRESETn && HSELx && !HWRITE && HREADY)
begin
         HREADY= 1'b0;
         ns_slave1=`READ_BURST;
end
         else if(!HREADY) 
begin
         ns_slave1=`AGAIN;
	   HRESP= `RETRY;
end
         else
         ns_slave1=`IDLE;
 end 

`AGAIN :  begin
         if(HREADY)
         ns_slave1=`ACTIVE;
         else
         ns_slave1=`LITTLE; 
         end
         
`WRITE_BURST  : begin
         if (HRESETn && HSELx && HWRITE )
    
         case(HBURST)//Single Transfer is only used 
         3'b000 : begin
										memory_slave[HADDR]= HWDATA;
										HREADY=1'b1; HRESP= `OKAY;
										HTRANS=`NON_SEQ;
										ns_slave1=`IDLE;
									 end	//000--Single transfer

						3'b001 : begin  // incrememting Burst unspecified Length
										 memory_slave[HADDR]=HWDATA;
										 
										 HADDR=HADDR+1;	
										 count=count+1;
										 	if(count<32)
												ns_slave1=`WRITE_BURST;
										 	else
												HREADY=1'b1;	HRESP= `OKAY;
                            ns_slave1=`IDLE;

 									 end//001

						3'b010 : begin   // 4BEAT WRAPPING burst
												 memory_slave[HADDR]=HWDATA;												 
												HADDR=HADDR+4;
											   count=count+1;
												if(count==4) 
												begin
                              HREADY=1'b1; HRESP= `OKAY;
												 HADDR=local_addr;
													count=0;
												 ns_slave1=`IDLE;
												end//count<4
											else
                             ns_slave1=`WRITE_BURST;
								 end//010

							3'b011 : begin	///4 beat Incrementing Burst
											memory_slave[HADDR]=HWDATA;
											HADDR=HADDR+4;
										 	count=count+1;
											if(count<4)
												ns_slave1=`WRITE_BURST;
											else
                            HREADY=1'b1;
											  HRESP= `OKAY;
												ns_slave1=`IDLE;
             								 end//011

							3'b100 : begin			// 8 Beat Wrapping Burst
												memory_slave[HADDR]=HWDATA;
												HADDR=HADDR+4;
											   count=count+1;
												if(count==8) 
												begin
                             HREADY=1'b1; HRESP= `OKAY;
												 HADDR=local_addr;
													count=0;
												 ns_slave1=`IDLE;
												end//count<4
											else
                             ns_slave1=`WRITE_BURST;
								 end//100
						      				

							3'b101 : begin  ///8 beat Incrementing Burst
											memory_slave[HADDR]=HWDATA;
											HADDR=HADDR+4;
										 	count=count+1;
											if(count<8)
												ns_slave1=`WRITE_BURST;
											else
												HREADY=1'b1;HRESP= `OKAY;
												ns_slave1=`IDLE;

										 end//101

							3'b110 : begin // 16 beat wrapping Burst
												memory_slave[HADDR]=HWDATA;
												HADDR=HADDR+4;
											   count=count+1;
												if(count==16) 
												begin
                              HREADY=1'b1;HRESP= `OKAY;
												 HADDR=local_addr;count=0;
												 ns_slave1=`IDLE;
												end//count<4
											else
                             ns_slave1=`WRITE_BURST;

										 end//110

							3'b111 : begin
											memory_slave[HADDR]=HWDATA;
											HADDR=HADDR+4;
										 	count=count+1;
											if(count<16)
												ns_slave1=`WRITE_BURST;
											else
												HREADY=1'b1;HRESP= `OKAY;
												ns_slave1=`IDLE;
									 end//111
							
							default : begin
                           HREADY=1'b1;HRESP= `OKAY;
                           ns_slave1=`IDLE;
                          end
						 endcase//for WRITE operation
          else
           HRESP= `ERROR;
				end//if(WRIte operation)

`READ_BURST : 	
						//READ Operation Starts Here
						begin
              if(HRESETn && HSELx && !HWRITE)
						 case(HBURST)

   					  3'b000 : begin//This is the only used burst operation
   					                    if(HADDR!=0)//This is made to demontrate the split operation is the data in 0 th address is asked then as the response slave gives a Split responce
   					                    begin
										HRDATA=memory_slave[HADDR];
										HREADY=1'b1;  
                                         ns_slave1=`IDLE;HRESP= `OKAY;
										end
										else
										begin
										HREADY=1'b0;  
                                         ns_slave1=`LITTLE;HRESP= `SPLIT;
										end
                        
									 end	//000--Single transfer

						3'b001 : begin  // incrememting Burst unspecified Length
										 HRDATA=memory_slave[HADDR];
										 HADDR=HADDR+1;	
										 count=count+1;
										 	if(count<32)
												ns_slave1=`READ_BURST;
										 	else
												 HREADY=1'b1;HRESP= `OKAY;
												 ns_slave1=`IDLE;

 									 end//001

							3'b010 : begin   // 4BEAT WRAPPING burst
												 HRDATA=memory_slave[HADDR];
												 HADDR=HADDR+4;
											   count=count+1;
												if(count==4) 
												begin
												  HREADY=1'b1;
                              HADDR=local_addr;count=0;
												 ns_slave1=`IDLE;
												end//count<4
											else
                             ns_slave1=`READ_BURST;
								 end//010

							3'b011 : begin	///4 beat Incrementing Burst
											HRDATA=memory_slave[HADDR];
											HADDR=HADDR+4;
										 	count=count+1;
											if(count<4)
												ns_slave1=`READ_BURST;
											else
												 HREADY=1'b1;HRESP= `OKAY;
                             ns_slave1=`IDLE;
             								 end//011

							3'b100 : begin			// 8 Beat Wrapping Burst
												HRDATA=memory_slave[HADDR];
												HADDR=HADDR+4;
											   count=count+1;
												if(count==8) 
												begin
												  HREADY=1'b1;HRESP= `OKAY;
                               HADDR=local_addr;
														count=0;
												 ns_slave1=`IDLE;
												end//count<4
											else
                             ns_slave1=`READ_BURST;
								 end//100
						      				

							3'b101 : begin  ///8 beat Incrementing Burst
											HRDATA=memory_slave[HADDR];
											HADDR=HADDR+4;
										 	count=count+1;
											if(count<8)
												ns_slave1=`READ_BURST;
											else
												 HREADY=1'b1;HRESP= `OKAY;
                              ns_slave1=`IDLE;

										 end//101

							3'b110 : begin // 16 beat wrapping Burst
												HRDATA=memory_slave[HADDR];
												HADDR=HADDR+4;
											   count=count+1;
												if(count==16) 
												begin
												  HREADY=1'b1;HRESP= `OKAY;
                              HADDR=local_addr;
														count=0;
												 ns_slave1=`IDLE;
												end//count<4
											else
                             ns_slave1=`READ_BURST;

										 end//110

							3'b111 : begin
											HRDATA=memory_slave[HADDR];
											HADDR=HADDR+4;
										 	count=count+1;
											if(count<16)
												ns_slave1=`READ_BURST;
											else
												 HREADY=1'b1;
                             ns_slave1=`IDLE;
									 end//111
							
							default :  begin
                            HREADY=1'b1;HRESP= `OKAY;
                            ns_slave1=`IDLE;
                            end

						endcase //for Read Operation    
         else
           HRESP= `ERROR;
         end
`LITTLE : begin
         SPLIT_RESP=HMASTER;
         if(HMASTLOCK)
         ns_slave1=`TIME_PASS;
         else
         begin
         HSPLITx=SPLIT_RESP;
         ns_slave1=`IDLE;
         end
         end
`TIME_PASS :begin//To cover additional clock cycle before splitx
        ns_slave1=`LITTLE;
        HMASTLOCK=0;

end

endcase

end

always@(posedge HCLK)
begin
ps_slave1=ns_slave1;
end          
endmodule

