`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/09/2018 09:00:05 PM
// Design Name: 
// Module Name: myArbiter
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


module Arbiter(

 clk,
 rst,

 req1,
 sb_lock_m1,
 
 req2,
 sb_lock_m2,


 sb_split_ar,

 sb_resp_ar,

 
 gnt1,
 gnt2,
 
 sb_masters,
 sb_mastlock
    );
//--------------------------------------------------------------------------------------------------------------------- 
// parameter definitionsendmodule
//---------------------------------------------------------------------------------------------------------------------

//---------------------------------------------------------------------------------------------------------------------
// localparam definitions
//---------------------------------------------------------------------------------------------------------------------

    localparam                          SB_ADDR_WIDTH         = 32;
    localparam                          SB_TRAS_TYPE          = 2;
    localparam                          SB_BURST_NUM          = 3;
    localparam                          SB_RESP_TYPE          = 2;
    localparam                          SB_NUM_MASTER         = 2;
    localparam                          SB_SPLIT_NUM_MSTR     = 2;
  


//---------------------------------------------------------------------------------------------------------------------
// I/O signals
//---------------------------------------------------------------------------------------------------------------------
    input                                   clk;
    input                                   rst;
    
    input                                   req1;
    input                                   sb_lock_m1;
    
    input                                   req2;
    input                                   sb_lock_m2;

   
    input       [SB_SPLIT_NUM_MSTR-1:0]     sb_split_ar;

    input       [SB_RESP_TYPE-1:0]          sb_resp_ar;


    output reg                              gnt1;
    output reg                              gnt2;
    
    output reg  [SB_NUM_MASTER-1:0]         sb_masters;
    output reg                              sb_mastlock;


//----------------------------

  
   parameter SPLIT=2'b11;
   
   parameter idle=2'b00;
   parameter GNT1=2'b01;
   parameter GNT2=2'b10;

   reg [1:0]  state,next_state;

   always @ (posedge clk or posedge rst )
     begin
    if(rst)
      state=idle;
    else
      state=next_state;
     end
//-----------------------
always @ (sb_split_ar)// 10- gnt2 =1 01 gnt1=1
begin
  case (state)
idle:begin
{gnt2 ,gnt1}=sb_split_ar;
sb_masters=sb_split_ar; //no master select
sb_mastlock=(sb_lock_m1 | sb_lock_m2);
end

GNT1:begin
{gnt2 ,gnt1}=sb_split_ar;
sb_masters=sb_split_ar; //no master select
sb_mastlock=(sb_lock_m1 | sb_lock_m2);
  end
  
  GNT2:begin
{gnt2 ,gnt1}=sb_split_ar;
  sb_masters=sb_split_ar; //no master select
  sb_mastlock=(sb_lock_m1 | sb_lock_m2);
    end

endcase
end




always @ (sb_resp_ar)
begin
  case (state)
idle:begin
gnt2=0;
gnt1=0;
sb_masters=2'b00; //no master select
sb_mastlock=0;
end

GNT1:begin
  gnt2=1;
  gnt1=0;
  sb_masters=2'b10;//master 2
   sb_mastlock=sb_lock_m2;
  end
  
  GNT2:begin
    gnt2=0;
    gnt1=1;
    sb_masters=2'b01;//master 1
    sb_mastlock=sb_lock_m1;
    end

endcase
end


always @ (state)
  begin
  
  case (state)
  idle:begin
  gnt2=0;
  gnt1=0;
  sb_masters=2'b00; //no master select
  sb_mastlock=0;
 end
  
  GNT1:begin
    gnt2=0;
    gnt1=1;
    sb_masters=2'b01;//master 1
     sb_mastlock=sb_lock_m1;
    end
    
    GNT2:begin
      gnt2=1;
      gnt1=0;
      sb_masters=2'b10;//master 2
      sb_mastlock=sb_lock_m2;
      end
  
  endcase
     
  end // always @ (state)

//-----------------------
   always @ (state,req2,req1,sb_lock_m1,sb_lock_m2)
     begin
   // next_state=0;

    case (state)

      idle:begin

         if(req1)
           next_state=GNT1;
         else if(req2)
           next_state=GNT2;
         else
           next_state=idle;
      end // case: idle

     

      GNT1:begin
         if(sb_resp_ar==SPLIT)
           next_state=GNT2;
         else if(sb_lock_m1)
              next_state=GNT1;
              else if(sb_split_ar==2'b10)
                    next_state=GNT2;
                    else if( req1)
                         next_state=GNT1;
                         else
                            next_state=GNT2;//default master
      end

      GNT2:begin
         if(sb_resp_ar==SPLIT)
                 next_state=GNT1;
               else if(sb_lock_m2)
                    next_state=GNT2;
                    else if(sb_split_ar==2'b01)
                          next_state=GNT1;
                          else if( req1)
                               next_state=GNT1;
                               else
                                  next_state=GNT2;//default master
      end
     
     
    endcase // case (state)
     end // always @ (state,req2,req1)


endmodule // arbiter
