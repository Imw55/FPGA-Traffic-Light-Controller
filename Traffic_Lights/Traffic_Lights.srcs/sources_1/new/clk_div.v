`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Ian Worgan
// 
// Create Date: 01/03/2025 10:39:48 PM
// Design Name: Resizeable Clock Divider
// Module Name: clk_div
// Project Name: Traffic Light Controller
// Target Devices: Zybo Z7 10/20
// Description: Takes an input clock and slows it by a factor of <DIVISOR>
// 
// Dependencies: N/A
// 
// Revision: 1.0
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module clk_div #(parameter DIVISOR = 10)(
    input wire CLK,
    output reg div_CLK
    );
    
    //-----------------------------------------------------------------------------
    // INTERMEDIATE Variables
    //-----------------------------------------------------------------------------
    
    // Holds the current count value
    integer count;
    
    //-----------------------------------------------------------------------------
    // Transition Logic
    //-----------------------------------------------------------------------------
    
    // Initialize the count to input parameter, and initialize output to low
    initial begin
        count = DIVISOR;
        div_CLK = 0;
    end
    
    always @ (posedge CLK) begin
        // If counter expired, toggle output clock
        if (count == 0) begin
            count = DIVISOR;
            div_CLK = ~div_CLK;
        end
        
        // Else decrement count
        else begin
            count = count - 1;
        end
    end
endmodule
