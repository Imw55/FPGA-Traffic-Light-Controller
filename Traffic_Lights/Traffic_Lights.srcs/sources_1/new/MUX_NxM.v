`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/29/2024 06:39:39 PM
// Design Name: 
// Module Name: MUX_NxM
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


module MUX_NxM #(parameter WIDTH = 4, parameter NUM = 4)(
    input wire [WIDTH-1:0] In [NUM-1:0],
    input wire [$clog2(NUM)-1:0] Selects, 
    output reg [WIDTH-1:0] Out
);

    always @(*) begin
        Out = In[Selects];
    end

endmodule
