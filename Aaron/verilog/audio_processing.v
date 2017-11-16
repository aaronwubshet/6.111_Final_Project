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
    input clk_25mhz,
    input ready,
    input reset,
    output AUD_PWM,
    output AUD_SD,     
    input [15:0] SW,
    output bin_count,
    input SD_CD,
    output SD_RESET,
    output SD_SCK,
    output SD_CMD, 
    inout [3:0] SD_DAT
    );


  // general SD signals 
reg sd_rd; // when ready is high, asserting rd will begin a read
wire sd_wr = 0;
wire sd_ready;
wire [4:0] sd_state; // for debug purposes

// set SPI mode
assign SD_DAT[2] = 1;
assign SD_DAT[1] = 1;
assign SD_RESET = 0;
  
// read SD signals
reg [31:0] sd_adr; // address of read operation
wire [7:0] sd_dout; // data output for read operation
wire sd_byte_available; // signal that a new byte has been presented on dout

// write SD signals
wire [7:0] sd_din = 0;
wire sd_ready_for_next_byte = 0;


sd_controller sd_controller_module(.cs(SD_DAT[3]), .mosi(SD_CMD), .miso(SD_DAT[0]),
        .sclk(SD_SCK), .rd(sd_rd), .wr(sd_wr), .reset(master_reset),
        .din(sd_din), .dout(sd_dout), .byte_available(sd_byte_available),
        .ready(sd_ready), .address(sd_adr), .clk(clk_25mhz), 
        .ready_for_next_byte(sd_ready_for_next_byte), .status(sd_state));
//generate sample buffer signals
wire sample_buffer_enable;
wire sample_write_enable_a;
wire sample_addra;
wire sample_dina;
wire sample_douta;

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
wire out_enable_a;
wire out_write_enable_a;
wire out_addra;
wire out_dina;
wire out_douta;
wire out_enable_b;
wire

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