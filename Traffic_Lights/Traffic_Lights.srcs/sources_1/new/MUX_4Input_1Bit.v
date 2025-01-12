`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/29/2024 09:35:49 PM
// Design Name: 
// Module Name: MUX_4Input_1Bit
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


module MUX_4Input_1Bit(
    input wire In00,
    input wire In01,
    input wire In10,
    input wire In11,
    input wire [1:0] SEL,
    input wire Out_Val
    );
    
    wire int_val00;
    wire int_val01;
    wire int_vall0;
    wire int_vall1;
    
    assign int_val00 = (~SEL[1]) & (~SEL[0]) & In00;
    assign int_val01 = (~SEL[1]) & SEL[0] & In01;
    assign int_vall0 = SEL[1] & (~SEL[0]) & In10;
    assign int_vall1 = SEL[1] & SEL[0] & In11;
    
    assign Out_Val = int_val00 | int_val01 | int_vall0 | int_vall1;
    
endmodule
