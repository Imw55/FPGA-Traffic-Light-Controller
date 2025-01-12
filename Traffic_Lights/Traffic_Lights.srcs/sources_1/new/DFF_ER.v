`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Ian Worgan
// 
// Create Date: 12/29/2024 06:14:58 PM
// Design Name: Synchronous Enable Asyncronous Reset D Flip Flop 
// Module Name: DFF_ER
// Project Name: Traffic Light Controller
// Target Devices: Zybo Z7 10/20
// Description: D
// 
// Dependencies: D Flip Flop with synchronous enable and asynchronous reset functionality
// 
// Revision: 1.0
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module DFF_ER(
    input wire D,
    input wire CLK,
    input wire EN,
    input wire RE,
    output reg Q,
    output wire Q_Prime
    );
    
    //-----------------------------------------------------------------------------
    // Transition Logic
    //-----------------------------------------------------------------------------
    
    // Initialize out value to 0
    initial begin
        Q = 1'b0;
    end
    
    // Continuously assign ~Q to the complement of Q
    assign Q_Prime = ~Q;
    
    always @ (posedge CLK or posedge RE) begin
        // If reset detected, set output to 0
        if (RE) begin
            Q <= 0;
        end
        // If no reset and flip flop is enabled, pass D to output
        else if (EN) begin
            Q <= D;
        end
    end
endmodule
