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
    input switch,
    input ready, 
    input audio_in,
    output audio_out,
    output done
    );
    fir_compiler_high_pass hpf (
      .aclk(clock),                              // input wire aclk
      .s_axis_data_tvalid(s_axis_data_tvalid),  // input wire s_axis_data_tvalid
      .s_axis_data_tready(s_axis_data_tready),  // output wire s_axis_data_tready
      .s_axis_data_tdata(s_axis_data_tdata),    // input wire [15 : 0] s_axis_data_tdata
      .m_axis_data_tvalid(m_axis_data_tvalid),  // output wire m_axis_data_tvalid
      .m_axis_data_tready(m_axis_data_tready),  // input wire m_axis_data_tready
      .m_axis_data_tdata(m_axis_data_tdata)    // output wire [31 : 0] m_axis_data_tdata
    );
    fir_compiler_bandpass bpf (
      .aclk(clock),                              // input wire aclk
      .s_axis_data_tvalid(s_axis_data_tvalid),  // input wire s_axis_data_tvalid
      .s_axis_data_tready(s_axis_data_tready),  // output wire s_axis_data_tready
      .s_axis_data_tdata(s_axis_data_tdata),    // input wire [15 : 0] s_axis_data_tdata
      .m_axis_data_tvalid(m_axis_data_tvalid),  // output wire m_axis_data_tvalid
      .m_axis_data_tready(m_axis_data_tready),  // input wire m_axis_data_tready
      .m_axis_data_tdata(m_axis_data_tdata)    // output wire [31 : 0] m_axis_data_tdata
    );
    fir_compiler_low_pass lpf (
      .aclk(clock),                              // input wire aclk
      .s_axis_data_tvalid(s_axis_data_tvalid),  // input wire s_axis_data_tvalid
      .s_axis_data_tready(s_axis_data_tready),  // output wire s_axis_data_tready
      .s_axis_data_tdata(s_axis_data_tdata),    // input wire [15 : 0] s_axis_data_tdata
      .m_axis_data_tvalid(m_axis_data_tvalid),  // output wire m_axis_data_tvalid
      .m_axis_data_tready(m_axis_data_tready),  // input wire m_axis_data_tready
      .m_axis_data_tdata(m_axis_data_tdata)    // output wire [31 : 0] m_axis_data_tdata
    );
    always @(posedge clock)
    begin
        case(switch)
        
        2'b00: 
    
    
    
endmodule
