`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/02/2025 08:19:00 PM
// Design Name: 
// Module Name: MUX_4Input_4Bit
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


module MUX_4Input_4Bit(
    input wire [3:0] Input00,
    input wire [3:0] Input01,
    input wire [3:0] Input10,
    input wire [3:0] Input11,
    input wire [1:0] SEL,
    output wire [3:0] Out_Val
    );
    
    wire [3:0] int_out;
    
    genvar i;
    generate
        for (i = 0; i < 4; i = i+1) begin: bit_mux
            MUX_4Input_1Bit mux_inst (
                    .In00(Input00[i]),
                    .In01(Input01[i]),
                    .In10(Input10[i]),
                    .In11(Input11[i]),
                    .SEL(SEL),
                    .Out_Val(int_out[i])
            );
        end
    endgenerate;
     
    assign Out_Val = int_out;
    
    
endmodule
