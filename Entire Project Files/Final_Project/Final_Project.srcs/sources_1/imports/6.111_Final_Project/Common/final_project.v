`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 11/06/2017 08:23:41 PM
// Design Name:
// Module Name: final_project
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


module final_project(
    //MASTER CLOCK
    input CLK100MHZ,

    //switches
    input [15:0] SW,

    //buttons
    input BTNC, BTNU, BTNL, BTNR, BTND,

    //SD card stuff
    output SD_CD,
    output SD_SCK,
    output SD_CMD,
    inout [3:0] SD_DAT,
    output SD_RESET,
    //JA and JB PMOD Headers for Camera input
    //inout [7:0] JA,
    //inout [7:0] JB,

    // video
    output [3:0] VGA_R,
    output [3:0] VGA_G,
    output [3:0] VGA_B,
    output VGA_HS,
    output VGA_VS,

    //LEDs
    output LED16_B, LED16_G, LED16_R,
    output LED17_B, LED17_G, LED17_R,


    output[15:0] LED,
    output [7:0] SEG,  // segments A-G (0-6), DP (7)
    output [7:0] AN,  // Display 0-7

    // audio
    output AUD_PWM,
    output AUD_SD // PWM audio enable
    );

    //master reset
    wire master_reset = SW[15];
   //CLOCK SETUP
    wire clk_100mhz;
    wire clk_25mhz;
    
    wire locked = 1;
    
    clk_manager clocker (
       .clk_in1(CLK100MHZ),    // input clk_in1
       .clk_out1(clk_25mhz),  
       .clk_out2(clk_100mhz), 
       .reset(0), // input reset
       .locked(locked) // output locked
    );
               
    // debounce buttons
    wire btn_up, btn_down, btn_center, btn_left, btn_right;
    debounce up(.reset(master_reset), .clock(clk_25mhz), .noisy(BTNU), .clean(btn_up));
    debounce down(.reset(master_reset), .clock(clk_25mhz), .noisy(BTND), .clean(btn_down));
    debounce center(.reset(master_reset), .clock(clk_25mhz), .noisy(BTNC), .clean(btn_center));
    debounce left(.reset(master_reset), .clock(clk_25mhz), .noisy(BTNL), .clean(btn_left));
    debounce right(.reset(master_reset), .clock(clk_25mhz), .noisy(BTNR), .clean(btn_right));
    
       
        
        //8-HEX SETUP FOR TESTING               
        wire [31:0] data;
        wire [6:0] segments;
        display_8hex display(.clk(clk_25mhz),.data(data), .seg(segments), .strobe(AN));    
        assign SEG[6:0] = segments;
        assign SEG[7] = 1'b1;
        
        assign data = {1'h0, color_contour_xy_bin_in, 1'h0, color_contour_state, 12'h0, 23'h0};//, 8'b0, state};
        assign LED[0] = done_sd_color_bram;
        assign LED[1] = color_contour_done;
    
        
        //SETTING UP THE SD CARD    
        wire [7:0] sd_read;
        wire [7:0] sd_write;
        //wire sd_we;  //0 = read, 1 = write
        wire sd_read_available;
        wire sd_write_available;
        wire sd_write_ready = 0;
        wire sd_reset = 0;
        wire sd_ready;
        wire [31:0] sd_addr1;
        wire [4:0] sd_status;
        wire [31:0] sd_addr;
        
        // set SPI mode
        assign SD_DAT[2] = 1;
        assign SD_DAT[1] = 1;
        assign SD_RESET = 0;     
           
        sd_controller sd_read_write (
            .cs (SD_DAT[3]), 
            .mosi (SD_CMD), 
            .miso (SD_DAT[0]), 
            .sclk (SD_SCK),        
            .rd (1), //input rd. The byte is presented on [dout].
            .dout (sd_read), // output reg [7:0] dout for READ operation.
            .byte_available (sd_read_available), // A new byte has been presented on [dout].
            .wr(0), //input wr. The next byte to be written should be presentaed on [din].
            .din(sd_write), // Data input for WRITE operation.
            .ready_for_next_byte (sd_write_available), // A new byte should be presented on [din].       
            .reset(sd_reset), // input Resets controller on assertion.
            .ready (sd_ready), //output HIGH if the SD card is ready for a read or write operation.
            .address(sd_addr), //input [31:0] addres
            .clk(clk_25mhz), // 25 MHz clock.
            .status(sd_status) //output [4:0] status: Current state of controller.
        );
          
          
        //SETTING UP THE BRAM WITH THE BINS OF EACH XY POSITION 
        wire [18:0] bram_addr;
        wire [2:0] xy_edge_out;
        wire [2:0] xy_bin_in;
        wire xy_bin_we;    //0 for read, 1 for write
        
        wire [18:0] bram_addr_b;
        wire [2:0] xy_edge_out_b;
        wire [2:0] xy_bin_in_b;
        wire xy_bin_we_b = 0;    //0 for read, 1 for write
    
        xy_bin xy_bram (
          .clka(clk_100mhz),    // input wire clka
          .wea(xy_bin_we),      // input wire [0 : 0] wea
          .addra(bram_addr),  // input wire [18 : 0] addra
          .dina(xy_bin_in),    // input wire [2 : 0] dina
          .douta(xy_edge_out),  // output wire [2 : 0] douta
          .clkb(clk_100mhz),    // input wire clkb
          .web(xy_bin_we_b),      // input wire [0 : 0] web
          .addrb(bram_addr_b),  // input wire [18 : 0] addrb
          .dinb(xy_bin_in_b),    // input wire [2 : 0] dinb
          .doutb(xy_edge_out_b)  // output wire [2 : 0] doutb
        );
        
    
        //LOGIC FOR BRAM INPUTS    
        assign bram_addr = ~done_sd_color_bram ? sd_color_bram_addr: color_contour_bram_addr;
        assign xy_bin_in = ~done_sd_color_bram ? sd_color_xy_bin_in: color_contour_xy_bin_in;
        assign xy_bin_we = ~done_sd_color_bram ? sd_color_xy_bin_we: ~color_contour_done ? color_contour_xy_bin_we : 0;
        
        wire SD_DONE;
        wire BRAM_DONE;
        
        assign SD_DONE = done_sd_color_bram;        
        assign BRAM_DONE = color_contour_done;
        assign sd_addr = SD_DONE ? sd_addr1: sd_addr1;
        
        //MODULE TO GET EDGE FROM SD CARD TO BRAM
        wire [9:0] x_first_edge;
        wire [8:0] y_first_edge;
        wire [18:0] addr_first_edge;
        wire [11:0] num_edge_pixels;
        
        //assign reset_sd_color_bram = BTNR;
        wire [18:0] sd_color_bram_addr;
        wire [2:0] sd_color_xy_bin_in;
        
        wire sd_color_xy_bin_en; //not necessary
        wire sd_color_xy_bin_we;    //not necessary       
        
        
        assign reset_sd_color_bram = BTNR;
        
        wire [18:0] total_pixel_count;
        wire done_sd_color_bram;         
    
        sd_color_bram to_xy_bram(
            .clk(clk_100mhz),
            .sd_read(sd_read),
            .sd_read_available(sd_read_available),
            .reset(reset_sd_color_bram),
            .sd_addr(sd_addr1),
            //           .sd_we(sd_we),
            .done(done_sd_color_bram),
            .bram_addr(sd_color_bram_addr),
            .edge_out(xy_edge_out),
            .bin_in(sd_color_xy_bin_in),
            .en(sd_color_xy_bin_en),
            .we(sd_color_xy_bin_we),
            .x_start(x_first_edge),
            .y_start(y_first_edge),
            .addr_start(addr_first_edge),
            .num_pixels(num_edge_pixels),
            .total_pixel_count(total_pixel_count)
        );
    
        wire [83:0] FFT_COLOR;
        assign FFT_COLOR = 84'h0F0_FF0_FFF_F0F;
        //MODULE FOR VGA OUTPUT        
    
        edge_to_display video_playback_1 (
            .bin_data(xy_edge_out_b),
            .ready(color_contour_done),
            .FFT_COLOR(FFT_COLOR),
            .video_clk(clk_25mhz),
            .memory_addr(bram_addr_b),
            .vsync(VGA_VS),
            .hsync(VGA_HS),
            .video_out({VGA_R, VGA_G, VGA_B})
            );
        
        
        //MODULE FOR ETRACTING EDGE CONTOURS FROM THE EDGE
        wire [18:0] color_contour_bram_addr;
        wire [2:0] color_contour_xy_bin_in;
        wire color_contour_xy_bin_en;
        wire color_contour_xy_bin_we;    //0 for read, 1 for write
        
        wire [2:0] color_contour_state;
        
        wire [11:0] pixel_per_bin;   //15c
        wire [2:0] set_bin_out;
                
        parameter [2:0] num_bins = 3;
        wire color_contour_reset;
        wire color_contour_done;
        
        wire [2:0] junk;
            
        color_contour get_contour(
            .clk(clk_100mhz),
            .x_start(x_first_edge),
            .y_start(y_first_edge),
            .addr_start(addr_first_edge),
            .num_pixels(num_edge_pixels),
            .num_bins(num_bins),
            .reset(color_contour_reset),
            .done(color_contour_done),
            
            .addr(color_contour_bram_addr),
            .edge_out(xy_edge_out),
            .bin_in(color_contour_xy_bin_in),
            .we(color_contour_xy_bin_we),
            .start(done_sd_color_bram)        ,
            .state_out(color_contour_state),
            .pixel_count(pixel_per_bin),
            .set_bin_out(junk)
        );
              
           
    
    //FFT amplitude output buffer read and write signals
    wire fft_bram_out_write_enablea;
    wire fft_bram_out_addra;
    wire fft_bram_out_dina;
    wire fft_bram_out_douta;
    
    wire fft_bram_out_addrb;
    wire fft_bram_out_dinb;
    wire fft_bram_out_doutb;
    
    bram_fft_output_buffer fft_amplitude_buffer (
      .clka(clk_100mhz),    // input wire clka
      .wea(fft_bram_out_write_enablea),      // input wire [0 : 0] wea
      .addra(fft_bram_out_addra),  // input wire [9 : 0] addra
      .dina(fft_bram_out_dina),    // input wire [7 : 0] dina
      .douta(fft_bram_out_douta),  // output wire [7 : 0] douta
      .clkb(clk_100mhz),    // input wire clkb
      .web(0),      // input wire [0 : 0] web
      .addrb(fft_bram_out_addrb),  // input wire [9 : 0] addrb
      .dinb(fft_bram_out_dinb),    // input wire [7 : 0] dinb
      .doutb(fft_bram_out_doutb)  // output wire [7 : 0] doutb
    );

  
    //AARON STUFF GOES HERE
    wire [2:0] bin_count;
    wire [59:0] bin_addr;
    wire [31:0] sd_addr2;
    audio_processing filters_and_fft(.clock(clk_100mhz), .clk_25mhz(clk_25mhz), .reset(master_reset),
        .sd_done(SD_DONE),.sd_read_available(sd_read_available), .sd_ready(sd_ready),.AUD_PWM(AUD_PWM), .AUD_SD(AUD_SD), 
        .SW(SW[1:0]),.bin_count(bin_count), .audio_data(sd_read),.bin_add(bin_addr), .done(done),.julian_done(julian_done),
        .sd_read_address(sd_addr2), .fft_bram_out_write_enablea(fft_bram_out_write_enablea), 
        .fft_bram_out_addra(fft_bram_out_addra), .fft_bram_out_dina(fft_bram_out_dina));
    
endmodule
