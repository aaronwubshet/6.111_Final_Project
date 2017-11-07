`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/06/2017 02:07:21 PM
// Design Name: 
// Module Name: audio_processing
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


module audio_processing(
    input clock,
    input ready,
    input reset,
    input switches,
    output bin_count,
    input SD_CD,
    output SD_RESET,
    output SD_SCK,
    inout SD_DAT,
    output SD_CMD
    );
endmodule
