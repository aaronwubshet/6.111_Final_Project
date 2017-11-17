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
    input clock, //100 MHZ clock
    input clk_25mhz,
    input ready,
    input reset,
    output AUD_PWM,
    output AUD_SD,
    input [15:0] SW,
    output bin_count,
    input audio_data,
    output [59:0] bin_add,
    output done
    );



//generate sample buffer signals
wire sample_buffer_enable;
wire sample_write_enable_a;
wire sample_addra;
wire sample_dina;
wire sample_douta;
//16 bits wide and 1024 lines long
sample_buffer sd_to_filter (
          .clka(clock),    // input wire clka
          .ena(sample_buffer_enable),      // input wire ena
          .wea(sample_write_enable_a),      // input wire [0 : 0] wea
          .addra(sample_addra),  // input wire [9 : 0] addra
          .dina(sample_dina),    // input wire [15 : 0] dina
          .douta(sample_douta)  // output wire [15 : 0] douta
        );
wire ready_to_filter;
wire filter_to_fft;
wire filter_done;
filter_control filter_controller_module(.clock(clock), .switch(SW[1:0]),
        .audio_in(sd_dout), .ready(ready_to_filter),.audio_out(filter_to_fft), .done(filter_done));

wire [7:0] music_data;
assign AUD_SD = filter_done ? 1: 0;
audio_PWM my_audio(.clk(clock), .reset(reset), .music_data(music_data), .PWM_out(AUD_PWM));

xfft_0 your_instance_name (
          .aclk(aclk),                                                // input wire aclk
          .s_axis_config_tdata(s_axis_config_tdata),                  // input wire [15 : 0] s_axis_config_tdata
          .s_axis_config_tvalid(s_axis_config_tvalid),                // input wire s_axis_config_tvalid
          .s_axis_config_tready(s_axis_config_tready),                // output wire s_axis_config_tready
          .s_axis_data_tdata(s_axis_data_tdata),                      // input wire [31 : 0] s_axis_data_tdata
          .s_axis_data_tvalid(s_axis_data_tvalid),                    // input wire s_axis_data_tvalid
          .s_axis_data_tready(s_axis_data_tready),                    // output wire s_axis_data_tready
          .s_axis_data_tlast(s_axis_data_tlast),                      // input wire s_axis_data_tlast
          .m_axis_data_tdata(m_axis_data_tdata),                      // output wire [31 : 0] m_axis_data_tdata
          .m_axis_data_tvalid(m_axis_data_tvalid),                    // output wire m_axis_data_tvalid
          .m_axis_data_tready(m_axis_data_tready),                    // input wire m_axis_data_tready
          .m_axis_data_tlast(m_axis_data_tlast),                      // output wire m_axis_data_tlast
          .event_frame_started(event_frame_started),                  // output wire event_frame_started
          .event_tlast_unexpected(event_tlast_unexpected),            // output wire event_tlast_unexpected
          .event_tlast_missing(event_tlast_missing),                  // output wire event_tlast_missing
          .event_status_channel_halt(event_status_channel_halt),      // output wire event_status_channel_halt
          .event_data_in_channel_halt(event_data_in_channel_halt),    // output wire event_data_in_channel_halt
          .event_data_out_channel_halt(event_data_out_channel_halt)  // output wire event_data_out_channel_halt
        );

square_root fft_mag_calc (
      .aclk(clock),                                        // input wire aclk
      .s_axis_cartesian_tvalid(s_axis_cartesian_tvalid),  // input wire s_axis_cartesian_tvalid
      .s_axis_cartesian_tlast(s_axis_cartesian_tlast),    // input wire s_axis_cartesian_tlast
      .s_axis_cartesian_tdata(s_axis_cartesian_tdata),    // input wire [15 : 0] s_axis_cartesian_tdata
      .m_axis_dout_tvalid(m_axis_dout_tvalid),            // output wire m_axis_dout_tvalid
      .m_axis_dout_tlast(m_axis_dout_tlast),              // output wire m_axis_dout_tlast
      .m_axis_dout_tdata(m_axis_dout_tdata)              // output wire [15 : 0] m_axis_dout_tdata
        );
wire out_enable_a;
wire out_write_enable_a;
wire out_addra;
wire out_dina;
wire out_douta;
wire out_enable_b;
wire out_write_enable_b;
wire out_addrb;
wire out_dinb;
wire out_doutb;

bram_fft_output_buffer out_buffer (
  .clka(clock),    // input wire clka
  .ena(ena),      // input wire ena
  .wea(wea),      // input wire [0 : 0] wea
  .addra(addra),  // input wire [9 : 0] addra
  .dina(dina),    // input wire [15 : 0] dina
  .douta(douta),  // output wire [15 : 0] douta
  .clkb(clock),    // input wire clkb
  .enb(enb),      // input wire enb
  .web(web),      // input wire [0 : 0] web
  .addrb(addrb),  // input wire [9 : 0] addrb
  .dinb(dinb),    // input wire [15 : 0] dinb
  .doutb(doutb)  // output wire [15 : 0] doutb
);
endmodule
