`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Ian Worgan
// 
// Create Date: 01/03/2025 10:52:57 PM
// Design Name: Resizeable Comparator
// Module Name: Comparator_NBit
// Project Name: Traffic Light Controller
// Target Devices: Zybo Z7 10/20
// Description: Checks equality of two vectors of lengths <WIDTH>
// 
// Dependencies: N/A
// 
// Revision: 1.0
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Comparator_NBit #(parameter WIDTH = 4)(
    input wire [WIDTH-1:0] X,
    input wire [WIDTH-1:0] Y,
    output wire Eq
    );
    
    //-----------------------------------------------------------------------------
    // INTERMEDIATE CONNECTIONS
    //-----------------------------------------------------------------------------
    
    // Holds result of bitwise equalty check
    wire [WIDTH-1:0] int_vector;
    
    //-----------------------------------------------------------------------------
    // LOGIC EQUATIONS
    //-----------------------------------------------------------------------------
    
    // Check equality bitwise
    assign int_vector = X~^Y;
    
    // Check all bits are equal bitwise
    assign Eq = &int_vector;
    
endmodule
