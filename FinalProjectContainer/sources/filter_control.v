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
    input [7:0] audio_in,
    output [7:0] audio_out,
    output done
    );
    

    //low pass filter signals and instantiations
    wire signed [9:0] lpf_coeff;
    wire [4:0] lpf_idx;
    wire lpf_done;
    wire lpf_ready;
    assign lpf_ready = (switch == 2'b00) ? ready : 0;
    wire signed [17:0] lpf_filter_out;
    
    lpf_coeffs low_pass_coeffs(.index(lpf_idx), .coeff(lpf_coeff));
    
    fir31 lpf(.clock(clock),.reset(reset),.ready(lpf_ready), .x(audio_in), .coeff(lpf_coeff), .idx(lpf_idx),
        .y(lpf_filter_out), .done(lpf_done));      
    
    //high pass filter signals and instantiations
    wire signed [9:0] hpf_coeff;
    wire [4:0] hpf_idx;
    wire hpf_done;
    wire hpf_ready;
    assign hpf_ready = (switch == 2'b01) ? ready: 0;
    wire signed [17:0] hpf_filter_out;
    
    hpf_coeffs high_pass_coeffs(.index(hpf_idx), .coeff(hpf_coeff));
    
    fir31 hpf(.clock(clock),.reset(reset),.ready(hpf_ready), .x(audio_in), .coeff(hpf_coeff), .idx(hpf_idx),
        .y(hpf_filter_out), .done(hpf_done)); 
       
    //band pass 1 filter signals and instations
    wire signed [9:0] bpf1_coeff;
    wire [4:0] bpf1_idx;
    wire bpf1_done;
    wire bpf1_ready;
    assign bpf1_ready = (switch == 2'b10) ? ready: 0;
    wire signed [17:0] bpf1_filter_out;
    
    bpf1_coeffs band_pass_1_coeffs(.index(bpf1_idx), .coeff(bpf1_coeff));
    
    fir31 bpf1(.clock(clock),.reset(reset),.ready(bpf1_ready), .x(audio_in), .coeff(bpf1_coeff), .idx(bpf1_idx),
        .y(bpf1_filter_out), .done(bpf1_done)); 
          
    //band pass 2 filter signals and instations
    wire signed [9:0] bpf2_coeff;
    wire [4:0] bpf2_idx;
    wire bpf2_done;
    wire bpf2_ready;
    assign bpf2_ready = (switch == 2'b11) ? ready: 0;
    wire signed [17:0] bpf2_filter_out;
    
    bpf2_coeffs band_pass_2_coeffs(.index(bpf2_idx), .coeff(bpf2_coeff));
    
    fir31 bpf2(.clock(clock),.reset(reset),.ready(bpf2_ready), .x(audio_in), .coeff(bpf2_coeff), .idx(bpf2_idx),
        .y(bpf2_filter_out), .done(bpf2_done)); 

    //output multiplexing
    assign done = (switch == 2'b00) ? 
        lpf_done: (switch==2'b01) ? 
        hpf_done : (switch== 2'b10) ? 
        bpf1_done : (switch == 2'b11) ? 
        bpf2_done : 0;
    assign audio_out = (switch == 2'b00) ?
        lpf_filter_out[14:7]: (switch==2'b01) ? 
        hpf_filter_out[14:7]: (switch== 2'b10) ? 
        bpf1_filter_out[14:7] : (switch == 2'b11) ? 
        bpf2_filter_out[14:7] : 0;
endmodule
