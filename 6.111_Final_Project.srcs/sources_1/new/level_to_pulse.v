`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/06/2017 01:50:46 PM
// Design Name: 
// Module Name: level_to_pulse
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


module level_to_pulse(
    input clock,
    input level,
    output pulse
    );
    reg last_level;
    
    always @(posedge clock) 
    begin
        last_level <= level;
    end
    assign pulse = level & ~last_level;
endmodule
