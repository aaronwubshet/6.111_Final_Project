`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/16/2017 07:45:46 PM
// Design Name: 
// Module Name: debug
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


module debug(
    
    inout [3:0] SD_DAT,
    output SD_CMD, SD_SCK,
    output SD_RESET, SD_CD,
    
    input CLK100MHZ,
    input[15:0] SW, 
    input BTNC, BTNU, BTNL, BTNR, BTND,
    output[3:0] VGA_R, 
    output[3:0] VGA_B, 
    output[3:0] VGA_G,
    //    output[7:0] JA, 
    output VGA_HS, 
    output VGA_VS, 
    output LED16_B, LED16_G, LED16_R,
    output LED17_B, LED17_G, LED17_R,
    output[15:0] LED,
    output[7:0] SEG,  // segments A-G (0-6), DP (7)
    output[7:0] AN    // Display 0-7

    );
    
        wire clk_100mhz;
       wire clk_25mhz;
       wire clk_65mhz;
       
       wire reset = 0;
       wire locked = 1;
       
       clk_wiz_0 clocks (
           // Clock in ports
           .clk_in1(CLK100MHZ),    // input clk_in1
           // Clock out ports
           .clk_out1(clk_100mhz),  // 100mhz for everything
           .clk_out2(clk_25mhz),   // 25mhz for SD card
           .clk_out3(clk_65mhz),   // 65 mhz for VGA???
           // Status and control signals
           .reset(reset), // input reset
           .locked(locked) // output locked
       );
       
                   
       wire [31:0] data;
       wire [6:0] segments;
       display_8hex display(.clk(clk_25mhz),.data(data), .seg(segments), .strobe(AN));    
       assign SEG[6:0] = segments;
       assign SEG[7] = 1'b1;
       
       wire state;
       assign data = {20'h0, num_edge_pixels};//, 8'b0, state};
//assign data = {13'h000, total_pixel_count};
       assign LED[1] = done_sd_color_bram;
       assign LED[0] = reset_sd_color_bram;
       
       wire [18:0] total_pixel_count;
     
       
       wire [7:0] sd_read;
       wire [7:0] sd_write;
//       wire sd_we;  //0 = read, 1 = write
       wire sd_read_available;
       wire sd_write_available;
       wire sd_write_ready = 0;
       wire sd_reset = 0;
       wire sd_ready;
       wire [31:0] sd_addr;
       wire [4:0] sd_status;
       
       // set SPI mode
       assign SD_DAT[2] = 1;
       assign SD_DAT[1] = 1;
       assign SD_RESET = 0;
       
       
       sd_controller sd_read_write (
           .cs (SD_DAT[3]), // output: Connect to SD_DAT[3].
           .mosi (SD_CMD), //output mosi, // output: Connect to SD_CMD.
           .miso (SD_DAT[0]), //input miso, // Connect to SD_DAT[0].
           .sclk (SD_SCK), //output sclk, // Connect to SD_SCK.
                       // For SPI mode, SD_DAT[2] and SD_DAT[1] should be held HIGH. 
                       // SD_RESET should be held LOW.
       
           .rd (1), //input rd,   // Read-enable. When [ready] is HIGH, asseting [rd] will 
                       // begin a 512-byte READ operation at [address]. 
                       // [byte_available] will transition HIGH as a new byte has been
                       // read from the SD card. The byte is presented on [dout].
           .dout (sd_read), // output reg [7:0] dout, // Data output for READ operation.
           .byte_available (sd_read_available), //output reg byte_available, // A new byte has been presented on [dout].
       
           .wr(0), //input wr,   // Write-enable. When [ready] is HIGH, asserting [wr] will
                       // begin a 512-byte WRITE operation at [address].
                       // [ready_for_next_byte] will transition HIGH to request that
                       // the next byte to be written should be presentaed on [din].
           .din(sd_write), //input [7:0] din, // Data input for WRITE operation.
           .ready_for_next_byte (sd_write_available), //output reg ready_for_next_byte, // A new byte should be presented on [din].
       
           .reset(sd_reset), //input reset, // Resets controller on assertion.
           .ready (sd_ready), //output ready, // HIGH if the SD card is ready for a read or write operation.
           .address(sd_addr), //input [31:0] address,   // Memory address for read/write operation. This MUST 
                                   // be a multiple of 512 bytes, due to SD sectoring.
           .clk(clk_25mhz), //input clk,  // 25 MHz clock.
           .status(sd_status) //output [4:0] status // For debug purposes: Current state of controller.
       );
       
       wire [18:0] bram_addr;
       wire [2:0] xy_edge_out;
       wire [2:0] xy_bin_in;
       wire xy_bin_en;
       wire xy_bin_we;    //0 for read, 1 for write
       
       xy_bin get_if_edge(.addra(bram_addr), .clka(clk_100mhz), .dina(xy_bin_in), .douta(xy_edge_out), .ena(1), .wea(xy_bin_we));
       
       wire [9:0] x_first_edge;
           wire [8:0] y_first_edge;
           wire [18:0] addr_first_edge;
           wire [11:0] num_edge_pixels;
       
      assign reset_sd_color_bram = BTNR;
       sd_color_bram to_xy_bram(
           .clk(clk_100mhz),
           .sd_read(sd_read),
           .sd_read_available(sd_read_available),
           .reset(reset_sd_color_bram),
               
           .sd_addr(sd_addr),
//           .sd_we(sd_we),
           .done(done_sd_color_bram),
           
           .bram_addr(bram_addr),
           .edge_out(xy_edge_out),
           .bin_in(xy_bin_in),
           .en(xy_bin_en),
           .we(xy_bin_we),
           
           .x_start(x_first_edge),
           .y_start(y_first_edge),
           .addr_start(addr_first_edge),
           .num_pixels(num_edge_pixels)     ,
           
           .total_pixel_count(total_pixel_count),
           
           .state(state)           
           );
       
       //first reset (one clock_cycle, with push?) --> sd_color_bram --> done signal --> color_contour --> done signal --> image
       
       edge_to_display video_playback_1 (
               .bin_data(xy_edge_out),
               .video_clk(clk_25mhz),
               .memory_addr(vga_bram_addr),
               .vsync(VGA_VS),
               .hsync(VGA_HS),
               .video_out(junk),
               .start(vga_start)
               );
           assign {VGA_R, VGA_G, VGA_B} = junk; //12'b000011110000;
           
           wire [18:0] color_contour_bram_addr;
           wire [2:0] color_contour_xy_edge_out;
           wire [2:0] color_contour_xy_bin_in;
           wire color_contour_xy_bin_en;
           wire color_contour_xy_bin_we;    //0 for read, 1 for write
           
               
           wire [2:0] state;
           high_fsm fsm(
               .clk (clk_100mhz),
           
               .BTNR(BTNR),
               .reset_sd_color_bram(reset_sd_color_bram),
               .done_sd_color_bram(done_sd_color_bram),
               
               .color_contour_reset(color_contour_reset),
               .color_contour_done(color_contour_done),
               
               .vga_start(vga_start),
               
               .bram_addr(bram_addr),
               .xy_bin_in(xy_bin_in),
               .xy_bin_en(xy_bin_en),
               .xy_bin_we(xy_bin_we),
               
               
               .sd_color_bram_addr(sd_color_bram_addr),
               .sd_color_xy_bin_in(sd_color_xy_bin_in),
               .sd_color_xy_bin_en(sd_color_xy_bin_en),
               .sd_color_xy_bin_we(sd_color_xy_bin_we),
               
               .color_contour_bram_addr(color_contour_bram_addr),
               .color_contour_xy_bin_in(color_contour_xy_bin_in),
               .color_contour_xy_bin_en(color_contour_xy_bin_en),
               .color_contour_xy_bin_we(color_contour_xy_bin_we)   ,
               
               .vga_bram_addr(vga_bram_addr),
               .state_out(state)
               
               );
       


     
       
   endmodule
