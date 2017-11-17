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
    input [1:0] switch,
    input ready,
    input audio_in,
    output audio_out,
    output done,
    output all_filters_ready
    );
    //filter is ready to accept data
    wire hpf_ready;
    wire lpf_ready;
    wire bpf_ready;
    assign all_filters_ready = hpf_ready && lpf_ready && bpf_ready;

    //filter selection via switch
    wire [3:0] data_in_valid;
    assign data_in_valid = switch[0] ? (switch[1] ? 4'b1000: 4'b1000) : (switch[1] ? 4'b0010: 4'b0001);

    //user is ready to input data     input to filter
    wire input_data;
    assign input_data = all_filters_ready ? audio_in: 0;

    fir_compiler_high_pass hpf (
      .aclk(clock),                              // input wire aclk
      .s_axis_data_tvalid(data_in_valid[0]),  // input wire s_axis_data_tvalid
      .s_axis_data_tready(hpf_ready),           // output wire s_axis_data_tready
      .s_axis_data_tdata(input_data),    // input wire [15 : 0] s_axis_data_tdata
      .m_axis_data_tvalid(m_axis_data_tvalid),  // output wire m_axis_data_tvalid
      .m_axis_data_tready(m_axis_data_tready),  // input wire m_axis_data_tready
      .m_axis_data_tdata(m_axis_data_tdata)    // output wire [31 : 0] m_axis_data_tdata
    );
    fir_compiler_bandpass bpf (
      .aclk(clock),                              // input wire aclk
      .s_axis_data_tvalid(data_in_valid[1]),  // input wire s_axis_data_tvalid
      .s_axis_data_tready(bpf_ready),  // output wire s_axis_data_tready
      .s_axis_data_tdata(input_data),    // input wire [15 : 0] s_axis_data_tdata
      .m_axis_data_tvalid(m_axis_data_tvalid),  // output wire m_axis_data_tvalid
      .m_axis_data_tready(m_axis_data_tready),  // input wire m_axis_data_tready
      .m_axis_data_tdata(m_axis_data_tdata)    // output wire [31 : 0] m_axis_data_tdata
    );
    fir_compiler_low_pass lpf (
      .aclk(clock),                              // input wire aclk
      .s_axis_data_tvalid(data_in_valid[2]),  // input wire s_axis_data_tvalid
      .s_axis_data_tready(lpf_ready),  // output wire s_axis_data_tready
      .s_axis_data_tdata(input_data),    // input wire [15 : 0] s_axis_data_tdata
      .m_axis_data_tvalid(m_axis_data_tvalid),  // output wire m_axis_data_tvalid
      .m_axis_data_tready(m_axis_data_tready),  // input wire m_axis_data_tready
      .m_axis_data_tdata(m_axis_data_tdata)    // output wire [31 : 0] m_axis_data_tdata
    );




endmodule
