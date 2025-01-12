`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Ian Worgan
// 
// Create Date: 01/03/2025 11:38:37 PM
// Design Name: Traffic Light FSM
// Module Name: FSM_Kernel
// Project Name: Traffic Light Controller
// Target Devices: Zybo Z7 10/20
// Description: FSM to control state transition opperations of the traffic light
// controller.
// State 0 --CNT0+Sensor--> State 1 --CNT0--> State 2 --CNT0--> State 3 --CNT0--> State 0 
// Dependencies: N/A
// 
// Revision: 1.0
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module FSM_Kernel(
        input wire CLK,
        input wire Sensor,
        input wire CNT0,
        input wire Reset,
        output reg [2:0] MSTL,
        output reg [2:0] SSTL,
        output reg [1:0] SEL,
        output reg [1:0] SET
    );
    
    //-----------------------------------------------------------------------------
    // INTERMEDIATE CONNECTIONS
    //-----------------------------------------------------------------------------
    
    // System state
    reg [1:0] state;
    
    //-----------------------------------------------------------------------------
    // TRANSITION LOGIC
    //-----------------------------------------------------------------------------
    
    // Initialize state to Main Street Green (State 0)
    initial begin
        state = 2'b00;
        MSTL = 3'b001;
        SSTL = 3'b100;
        SEL = 2'b00;
        SET = 2'b01;
    end
    
     // State 0 --CNT0+Sensor--> State 1 --CNT0--> State 2 --CNT0--> State 3 --CNT0--> State 0 
     always @ (posedge CLK) begin
        
        // Main Street green (State 0)
        if (state == 2'b00 || Reset) begin
            // If counter expired and sensor on, transition to State 1
            if (CNT0 && Sensor) begin
                state = 2'b01;
                MSTL = 3'b010;
                SSTL = 3'b100;
                SEL = 2'b01;
                SET = 2'b10;
            end
        end
        
        // Main Street yellow (State 1)
        else if (state == 2'b01) begin
            // If counter expired, transition to State 2
            if (CNT0) begin
                state = 2'b11;
                MSTL = 3'b100;
                SSTL = 3'b001;
                SEL = 2'b10;
                SET = 2'b11;
            end
        end
        
        // Side Street green (State 2)
        else if (state == 2'b11) begin
            // If counter expired, transition to State 3
            if (CNT0) begin
                state = 2'b10;
                MSTL = 3'b100;
                SSTL = 3'b010;
                SEL = 2'b11;
                SET = 2'b00;
            end
        end
        
        // Side Street Yellow (State 3)
        else if (state == 2'b10) begin
            // If counter expired, transition to State 0
            if (CNT0) begin
                state = 2'b00;
                MSTL = 3'b001;
                SSTL = 3'b100;
                SEL = 2'b00;
                SET = 2'b01;
            end
        end       
     end
endmodule
