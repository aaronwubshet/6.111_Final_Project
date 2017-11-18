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


module image_processing(
    
    inout [3:0] SD_DAT,
    output SD_CMD, SD_SCK,
    output SD_RESET, SD_CD,
    
    input clk_100mhz,
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
    output[7:0] AN,    // Display 0-7
    
    output SD_DONE,
    output BRAM_DONE,
    
    input clk_25mhz,
    
    output [18:0] bram_addr,
    input [2:0] xy_edge_out,
    output [2:0] xy_bin_in,
    output xy_bin_we,
    input sd_read_available,
    output sd_addr

    );
      
    
    
    
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
    
    wire state;
    wire [18:0] total_pixel_count;

    sd_color_bram to_xy_bram(
        .clk(clk_100mhz),
        .sd_read(sd_read),
        .sd_read_available(sd_read_available),
        .reset(reset_sd_color_bram),
        
        .sd_addr(sd_addr),
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
        .num_pixels(num_edge_pixels)     ,
        
        .total_pixel_count(total_pixel_count),
        
        .state(state)           
    );

    
    //MODULE FOR ETRACTING EDGE CONTOURS FROM THE EDGE
    wire [18:0] color_contour_bram_addr;
    wire [2:0] color_contour_xy_edge_out;
    wire [2:0] color_contour_xy_bin_in;
    wire color_contour_xy_bin_en;
    wire color_contour_xy_bin_we;    //0 for read, 1 for write
    
    wire [1:0] color_contour_state;
    
    wire [11:0] pixel_per_bin;   //15c
    wire [2:0] set_bin_out;
    
    parameter [2:0] num_bins = 4;
    wire color_contour_reset;
    wire color_contour_done;
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
        .edge_out(color_contour_xy_edge_out),
        .bin_in(color_contour_xy_bin_in),
        .we(color_contour_xy_bin_we),
        .start(done_sd_color_bram)        ,
        .state_out(color_contour_state),
        .pixel_count(pixel_per_bin),
        .set_bin_out(set_bin_out)
    );
           
    //LOGIC FOR BRAM INPUTS
    //first reset (one clock_cycle, with push?) --> sd_color_bram --> done signal --> color_contour --> done signal --> image

    assign bram_addr = ~done_sd_color_bram ? sd_color_bram_addr: color_contour_bram_addr ;
    assign xy_bin_in = ~done_sd_color_bram ? sd_color_xy_bin_in: color_contour_xy_bin_in;
    assign xy_bin_we = ~done_sd_color_bram ? sd_color_xy_bin_we: color_contour_xy_bin_we;
    
    assign SD_DONE = done_sd_color_bram;
    assign BRAM_DONE = color_contour_done;       
       
endmodule