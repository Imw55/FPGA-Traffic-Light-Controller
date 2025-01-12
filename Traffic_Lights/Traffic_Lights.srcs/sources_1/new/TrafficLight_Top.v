`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Ian Worgan
// 
// Create Date: 01/08/2025 07:32:51 PM
// Design Name: Traffic Light Controller Top Level
// Module Name: TrafficLight_Top
// Project Name: Traffic Light Controller
// Target Devices: Digilent Zybo Z7 10/20
// Description: Controlls traffic lights for two streets based on a sensor input
// the secondary street, and fixed timings for light transitions.
// 
// Dependencies: FSM_Kernel.v, MUX_4Input_4Bit.v, Comparator.v, Counter_15to0.v
// clk_divider.v 
// 
// Revision: 1.0
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module TrafficLight_Top(
    input wire CLK,
    input wire Sensor,
    input wire Reset,
    output wire [2:0] SSTL,
    output wire [2:0] MSTL
    );
    
    //-----------------------------------------------------------------------------
    // INTERMEDIATE CONNECTIONS
    //-----------------------------------------------------------------------------

    // Divided clock
    wire div_CLK;
    
    // Output from comparator, 1 when selected counter expired
    wire int_CNT0;
    
    // Controlls for counter, SET to engage parallel load, SEL to run counter and
    // select on MUX
    wire [1:0] int_SEL;
    wire [1:0] int_SET;
    
    // Connections to multiplexer inputs
    wire [3:0] int_Mux00;
    wire [3:0] int_Mux01;
    wire [3:0] int_Mux10;
    wire [3:0] int_Mux11;
    wire [3:0] int_MuxOut;
    
    //-----------------------------------------------------------------------------
    // MODULE MAPS
    //-----------------------------------------------------------------------------
    
    // FSM for transition logic
    FSM_Kernel FSM (
        .CLK(div_CLK),
        .Sensor(Sensor),
        .CNT0(int_CNT0),
        .Reset(Reset),
        .MSTL(MSTL),
        .SSTL(SSTL),
        .SEL(int_SEL),
        .SET(int_SET)    
    );
    
    // Timer MUX
    MUX_4Input_4Bit MUX (
        .Input00(int_Mux00),
        .Input01(int_Mux01),
        .Input10(int_Mux10),
        .Input11(int_Mux11),
        .SEL(int_SEL),
        .Out_Val(int_MuxOut)
    );
    
    // Timer expired comparator
    Comparator_NBit #(4) Comparator (
        .X(int_MuxOut),
        .Y(4'b0000),
        .Eq(int_CNT0)
    );
    
    // Main Street green timer
    Counter_15to0 MSG_Counter (
            .Par_In(4'b1111),
            .CNT( ~int_SEL[1] & ~int_SEL[0] ),
            .LD( ~int_SET[1] & ~int_SET[0] ),
            .RE(Reset),
            .CLK(div_CLK),
            .Par_Out(int_Mux00)
    );
    
    // Main Street yellow timer
    Counter_15to0 MSY_Counter (
            .Par_In(4'b0100),
            .CNT( ~int_SEL[1] & int_SEL[0] ),
            .LD( ~int_SET[1] & int_SET[0] ),
            .RE(Reset),
            .CLK(div_CLK),
            .Par_Out(int_Mux01)
    );
    
    // Side Street green timer
    Counter_15to0 SSG_Counter (
            .Par_In(4'b1100),
            .CNT( int_SEL[1] & ~int_SEL[0] ),
            .LD( int_SET[1] & ~int_SET[0] ),
            .RE(Reset),
            .CLK(div_CLK),
            .Par_Out(int_Mux10)
    );
    
    // Side Street yellow counter
    Counter_15to0 SSY_Counter (
            .Par_In(4'b0100),
            .CNT( int_SEL[1] & int_SEL[0] ),
            .LD( int_SET[1] & int_SET[0] ),
            .RE(Reset),
            .CLK(div_CLK),
            .Par_Out(int_Mux11)
    );
    
    // Clock divider
    // Assumes clock of 125Mhz
    clk_div #(62500000) clk_divider (
        .CLK(CLK),
        .div_CLK(div_CLK)
    );
    
endmodule
