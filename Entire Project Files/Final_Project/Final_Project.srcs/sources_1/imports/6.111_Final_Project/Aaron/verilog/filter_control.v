`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 11/06/2017 02:50:18 PM
// Design Name:
// Module Name: filter_control
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


module filter_control(
    input clock,
    input reset,
    input [1:0] switch,
    input ready,
    input state,
    input [7:0] audio_in,
    output [7:0] audio_out,
    output signed [7:0] filter_to_fft,
    output done,
    output internal_ready
    );
    
    reg [4:0] count;
    wire filter_ready;
    assign internal_ready = (count == 0) ? 1 : 0;
    assign filter_ready = internal_ready && ready;
    
    wire signed [9:0] coeff;
    wire [4:0] idx;
    wire signed [17:0] filter_out;
    wire [4:0] offset;
    wire lpf_done;
    
    fir31 lpf(.clock(clock),.reset(reset),.ready(filter_ready), .x(audio_in), .coeff(coeff), .idx(idx),
        .y(filter_out), .offset(offset), .done(lpf_done));      
    
    lpf_coeffs low_pass_coeffs(.index(idx), .coeff(coeff));   
 
    assign filter_to_fft = filter_out[17:10];
    assign audio_out = filter_out[14:7];
    
    
    always @ (posedge clock)
    begin
        if(reset)
        begin
            count <= 1;
        end
        if (state == 2'b11)
        begin
            count <= count + 1;
        end
    end


endmodule
