`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Ian Worgan
// 
// Create Date: 01/02/2025 08:24:49 PM
// Design Name: 15 down to 0 Counter
// Module Name: Counter_15to0
// Project Name: Traffic Light Controller
// Target Devices: Zybo Z7 10/20
// Description: Binary counter which counts down from 15 to 0, halting at zero.
// Synchronous parallel load to set counter to desired start value.
// 15 --> 14 --> 13 --> ... --> 2 --> 1 --> 0 
// 
// Dependencies: DFF_ER.v
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Counter_15to0(
    input wire [3:0] Par_In,
    input wire CNT,
    input wire LD,
    input wire RE,
    input wire CLK,
    output wire [3:0] Par_Out
    );
    
    //-----------------------------------------------------------------------------
    // INTERMEDIATE CONNECTIONS
    //-----------------------------------------------------------------------------
      
    // Vector holding next value of flip flops
    wire int_D[3:0];
    
    //-----------------------------------------------------------------------------
    // LOGIC EQUATIONS
    //-----------------------------------------------------------------------------
    
    // Equations to determine next value for each flip flop
    assign int_D[0] = (((Par_Out[1] & ~Par_Out[0]) | (Par_Out[2] & ~Par_Out[0]) | (Par_Out[3] & ~Par_Out[0])) & CNT) | (Par_In[0] & LD);
    assign int_D[1] = (((Par_Out[1] & Par_Out[0]) | (Par_Out[2] & ~Par_Out[1] & ~Par_Out[0]) | (Par_Out[3] & ~Par_Out[1] & ~Par_Out[0])) & CNT) | (Par_In[1] & LD);
    assign int_D[2] = (((Par_Out[2] & Par_Out[0]) | (Par_Out[2] & Par_Out[1]) | (Par_Out[3] & ~Par_Out[2] & ~Par_Out[1] & ~Par_Out[0])) & CNT) | (Par_In[2] & LD);
    assign int_D[3] = (((Par_Out[3] & Par_Out[0]) | (Par_Out[3] & Par_Out[1]) | (Par_Out[3] & Par_Out[2])) & CNT)| (Par_In[3] & LD);
    
    // Flip flop enable equation
    wire FF_EN = CNT | LD;   
    
    //-----------------------------------------------------------------------------
    // MODULE MAPS
    //-----------------------------------------------------------------------------
    
    // Generates 4 flip flops, passing the proper transition equation to each through D
    genvar i;
    generate
        for(i=0 ; i<4 ; i = i+1) begin : FF_Gen
            DFF_ER FF_Inst (
                .D(int_D[i]),
                .CLK(CLK),
                .EN(FF_EN),
                .RE(RE),
                .Q(Par_Out[i])
            );
        end
    endgenerate
    
endmodule
