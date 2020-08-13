`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/15/2017 10:32:46 PM
// Design Name: 
// Module Name: sd_color_bram
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


module sd_color_bram(
    input clk,
    input [7:0] sd_read,
    input sd_read_available,
    input reset,
        
    output reg [31:0] sd_addr,
//    output reg sd_we,
    output reg done,
    
    output reg [18:0] bram_addr,
    output reg [2:0] edge_out,
    output reg [2:0] bin_in,
    output reg en, we,
    
    output reg [9:0] x_start,
    output reg [8:0] y_start,
    output reg [18:0] addr_start,
    output reg [11:0] num_pixels,
    
    output reg [18:0] total_pixel_count,
    
    output reg state
    
    );
    
    parameter width = 10'd640;
    parameter height = 9'd480;
    parameter total_pixels = 20'd307200;
     
    //    reg state;
    parameter STATE_GET_SD = 0;
    parameter STATE_SD_BRAM = 1;
    
    reg [7:0] sd_info_for_bram;
    reg [2:0] index = 0;
    

    reg first_edge = 0;
    reg[9:0] x_curr;
    reg [8:0] y_curr;
    
    reg [18:0] pixel_count = 0;
   

    
    always @(posedge clk) begin
        en <= 1;
        we <= 1;

        if (reset) begin
            done <= 0;
            sd_addr <= 0;
            bram_addr <= 0;
//            sd_we <= 1;
            first_edge <= 0;
            num_pixels <= 0;
            pixel_count <= 0;
            
            x_curr <= 0;
            y_curr <= 0;
            
            addr_start <= 0;
            x_start <= 0;
            y_start <= 0;

            state <= STATE_GET_SD;
        end
        else begin //if (~done) begin
            total_pixel_count <= bram_addr;
        
            case (state)
                STATE_GET_SD: begin
                    if (sd_read_available) begin
                        sd_info_for_bram <= sd_read;
                        sd_addr <= sd_addr + 1;
                        index <= 3'b111;
                        
                        state <= STATE_SD_BRAM;
                    end
                end
                
                STATE_SD_BRAM: begin
                    if (~done) begin
                        bin_in <= {2'b0, sd_info_for_bram[index]};
                        index <= index - 1;
                        bram_addr <= bram_addr + 1;
                        x_curr <= x_curr + 1;
                        
                        pixel_count <= pixel_count + 1;
                        
                        if (x_curr == width - 1) begin
                            x_curr <= 0;
                            y_curr <= y_curr + 1;
                        end
                        
                        if (sd_info_for_bram[index] == 1) begin
                            num_pixels <= num_pixels + 1;
                            if (~first_edge) begin
                                first_edge <= 1;
                                addr_start <= bram_addr+1;
                                x_start <= x_curr+1;
                                y_start <= y_curr;
                                bin_in <= 3'b011;
//                                total_pixel_count <= bram_addr;
                                
                            end
                        end
                        
                        if (index == 0) begin
                            state <= STATE_GET_SD;
                        end
                        
                        if (bram_addr == total_pixels - 1) begin
//                            total_pixel_count <= bram_addr;
                            done <= 1;
                        end
                    end
                    
                end
                
                default: state <= STATE_GET_SD;
            endcase
        end
        
    end
    
endmodule
