//Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2016.2 (lin64) Build 1577090 Thu Jun  2 16:32:35 MDT 2016
//Date        : Wed Dec  6 17:28:24 2017
//Host        : eecs-digital-13 running 64-bit Ubuntu 14.04.5 LTS
//Command     : generate_target fft_mag_wrapper.bd
//Design      : fft_mag_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module fft_mag_wrapper
   (clk,
    event_data_in_channel_halt,
    event_data_out_channel_halt,
    event_frame_started,
    event_status_channel_halt,
    event_tlast_missing,
    event_tlast_unexpected,
    frame_tdata,
    frame_tlast,
    frame_tready,
    frame_tvalid,
    magnitude_tdata,
    magnitude_tlast,
    magnitude_tuser,
    magnitude_tvalid);
  input clk;
  output event_data_in_channel_halt;
  output event_data_out_channel_halt;
  output event_frame_started;
  output event_status_channel_halt;
  output event_tlast_missing;
  output event_tlast_unexpected;
  input [15:0]frame_tdata;
  input frame_tlast;
  output frame_tready;
  input frame_tvalid;
  output [15:0]magnitude_tdata;
  output magnitude_tlast;
  output [9:0]magnitude_tuser;
  output magnitude_tvalid;

  wire clk;
  wire event_data_in_channel_halt;
  wire event_data_out_channel_halt;
  wire event_frame_started;
  wire event_status_channel_halt;
  wire event_tlast_missing;
  wire event_tlast_unexpected;
  wire [15:0]frame_tdata;
  wire frame_tlast;
  wire frame_tready;
  wire frame_tvalid;
  wire [15:0]magnitude_tdata;
  wire magnitude_tlast;
  wire [9:0]magnitude_tuser;
  wire magnitude_tvalid;

  fft_mag fft_mag_i
       (.clk(clk),
        .event_data_in_channel_halt(event_data_in_channel_halt),
        .event_data_out_channel_halt(event_data_out_channel_halt),
        .event_frame_started(event_frame_started),
        .event_status_channel_halt(event_status_channel_halt),
        .event_tlast_missing(event_tlast_missing),
        .event_tlast_unexpected(event_tlast_unexpected),
        .frame_tdata(frame_tdata),
        .frame_tlast(frame_tlast),
        .frame_tready(frame_tready),
        .frame_tvalid(frame_tvalid),
        .magnitude_tdata(magnitude_tdata),
        .magnitude_tlast(magnitude_tlast),
        .magnitude_tuser(magnitude_tuser),
        .magnitude_tvalid(magnitude_tvalid));
endmodule
