`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/16/2017 12:32:36 PM
// Design Name: 
// Module Name: high_fsm
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


module high_fsm(
    input clk,

    input BTNR,
    output reg reset_sd_color_bram,
    input done_sd_color_bram,
    
    output reg color_contour_reset,
    input color_contour_done,
    
    output reg vga_start = 0,
    
    output reg [18:0] bram_addr,
    output reg [2:0] xy_bin_in,
    output reg xy_bin_en,
    output reg xy_bin_we,    //0 for read, 1 for write
    
    input [18:0] sd_color_bram_addr,
    input [2:0] sd_color_xy_bin_in,
    input sd_color_xy_bin_en,
    input sd_color_xy_bin_we,    //0 for read, 1 for write
    
    input [18:0] color_contour_bram_addr,
    input [2:0] color_contour_xy_bin_in,
    input color_contour_xy_bin_en,
    input color_contour_xy_bin_we,    //0 for read, 1 for write
    
    input [18:0] vga_bram_addr,
    
    output reg [2:0] state_out
    );
    
    parameter [2:0] WAIT_BEGINNING = 0;
    parameter [2:0] SD_COLOR_BRAM = 1;
    parameter [2:0] COLOR_CONTOUR = 2;
    
    reg [2:0] state = WAIT_BEGINNING;
    
    
    always @(posedge clk) begin
        state_out <= state;    
    
        if (BTNR) begin
            reset_sd_color_bram <= 1;
            state <= SD_COLOR_BRAM;
            color_contour_reset <= 0;
            vga_start <= 0;
        end
        
        else begin
            bram_addr <= sd_color_bram_addr;
            xy_bin_in <= sd_color_xy_bin_in;
            xy_bin_en <= sd_color_xy_bin_en;
            xy_bin_we <= sd_color_xy_bin_we;
        end
        
        /*case (state)
        
            WAIT_BEGINNING: begin
                reset_sd_color_bram <= 0;
                color_contour_reset <= 0;
                vga_start <= 0;
            
            
                if (BTNR) begin
                    reset_sd_color_bram <= 1;
                    state <= SD_COLOR_BRAM;

                    bram_addr <= sd_color_bram_addr;
                    xy_bin_in <= sd_color_xy_bin_in;
                    xy_bin_en <= sd_color_xy_bin_en;
                    xy_bin_we <= sd_color_xy_bin_we;
                end
            end 
            
            SD_COLOR_BRAM: begin
                reset_sd_color_bram <= 0;
                if (done_sd_color_bram) begin
//                    color_contour_reset <= 1;
                    state <= COLOR_CONTOUR;

                    
                    bram_addr <= color_contour_bram_addr;
                    xy_bin_in <= color_contour_xy_bin_in;
                    xy_bin_en <= color_contour_xy_bin_en;
                    xy_bin_we <= color_contour_xy_bin_we;
                end
                
                bram_addr <= sd_color_bram_addr;
                xy_bin_in <= sd_color_xy_bin_in;
                xy_bin_en <= sd_color_xy_bin_en;
                xy_bin_we <= sd_color_xy_bin_we;
            end
            
            COLOR_CONTOUR: begin
//                color_contour_reset <= 0;
//                bram_addr <= color_contour_bram_addr;
//                xy_bin_in <= color_contour_xy_bin_in;
//                xy_bin_en <= color_contour_xy_bin_en;
//                xy_bin_we <= color_contour_xy_bin_we;
                
//                if (color_contour_done) begin
                    vga_start <= 1;
                    
                    bram_addr <= vga_bram_addr;
                    xy_bin_en <= 1;
                    xy_bin_we <= 0;
                    
//                end
            end
        
        endcase*/
    end
endmodule
