`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/14/2017 08:34:55 PM
// Design Name: 
// Module Name: color_contour
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


module color_contour(
    input clk,
    input [9:0] x_start,
    input [8:0] y_start,
    input [18:0] addr_start,
    input [11:0] num_pixels,
    input [2:0] num_bins,
    input reset,
    output reg done = 0,
    
    output reg [18:0] addr,
    output reg [2:0] edge_out,
    output reg [2:0] bin_in,
    output reg we,
    
    output reg [1:0] state_out,
    input start,
    output reg [11:0] pixel_count,
    output reg [2:0] set_bin_out
    );
    
    wire [23:0] div_out;
    reg [11:0] pixel_per_bin;
    wire div_ready;
//    div_gen_0 pixel_per(.s_axis_divisor_tdata(num_pixels), .s_axis_divisor_tvalid(1), .s_axis_dividend_tdata(num_bins), 
 //   .s_axis_dividend_tvalid(1), .aclk (clk), .m_axis_dout_tdata(div_out), .m_axis_dout_tvalid(div_ready));
    
    
//    reg [11:0] pixel_count;
    reg [2:0] bin = 1;
    
//    //reading bram
//    reg [18:0]addr = 0;
//    reg [2:0] edge_out;
//    reg [2:0] bin_in;
//    reg en = 0;
//    reg we = 0;    //0 for read, 1 for write
              
//    xy_bin get_if_edge(.addra(addr), .clka(clk), .dina(bin_in), .douta(edge_out), .ena(en), .wea(we));
    
    parameter STATE_SETUP = 0;
    parameter STATE_WAIT = 1;
    parameter STATE_EXPLORE = 2;
    parameter STATE_IS_IT_EDGE = 3;
    
    reg [2:0] explore_dir = 0;
    reg [2:0] max_explore_dir = 3'b111;
    parameter DIR_GET_RIGHT = 0;
    parameter DIR_GET_DOWNRIGHT = 1;
    parameter DIR_GET_DOWN = 2;
    parameter DIR_GET_DOWNLEFT = 3;
    parameter DIR_GET_LEFT = 4;
    parameter DIR_GET_UPLEFT = 5;
    parameter DIR_GET_UP = 6;
    parameter DIR_GET_UPRIGHT = 7;
    
    reg [1:0] state = STATE_SETUP;
    reg [1:0] next_state;
    
    reg [9:0] x_prev = 0;
    reg [8:0] y_prev = 0;
    reg [18:0] addr_prev = 0;
    reg [9:0] x_curr;
    reg [8:0] y_curr;
    reg [18:0] addr_curr = 0;
    
    reg [2:0] set_bin;
    
    reg [9:0] x_explore;
    reg [8:0] y_explore;
    reg [18:0] addr_explore = 0;
    
    always @(posedge clk) begin
//        if (reset) begin
//            done <= 0;
//            state <= STATE_SETUP;
//        end
        
//        else begin
            state_out <= state;
            if (start && ~done) begin
//            pixel_per_bin[11:0] <= div_out[19:8];
            
            pixel_per_bin <= 9'b101011100;
            set_bin_out <= set_bin;
                        
            case (state)
                STATE_SETUP: begin
                    set_bin <= 2;
                    done <= 0;
                    addr <= addr_start;
                    x_curr <= x_start;
                    y_curr <= y_start;
                    addr_curr <= addr_start; 
                    
                    pixel_count <= 0;
                    
                    next_state <= STATE_EXPLORE;
                    state <= STATE_WAIT;
                end
                
                STATE_WAIT: begin
                    //waste 1 clock cycle
                    state <= next_state;
                end
                
                STATE_EXPLORE: begin
                    next_state <= STATE_IS_IT_EDGE;
                    state <= STATE_WAIT;
                    
                    we <= 0;
                    
                    case (explore_dir)
                        DIR_GET_RIGHT: begin                        
                            if (addr + 1 == addr_prev) begin
                                state <= STATE_EXPLORE;
                            end else begin
                                x_explore <= x_curr + 1;
                                y_explore <= y_curr;
                                addr_explore <= addr + 1;

                            end
                            
                            explore_dir <= DIR_GET_DOWNRIGHT;
                            
    
                        end
                        
                        DIR_GET_DOWNRIGHT: begin
                            if (addr + 640 + 1 == addr_prev) begin
                                state <= STATE_EXPLORE;
                            end else begin                                                        
                                x_explore <= x_curr + 1;
                                y_explore <= y_curr + 1;
                                addr_explore <= addr + 640 + 1;
                            end
                            
                            explore_dir <= DIR_GET_DOWN;
                        end
                        
                        DIR_GET_DOWN: begin
                            if (addr + 640 == addr_prev) begin
                                state <= STATE_EXPLORE;
                            end else begin
                                x_explore <= x_curr;
                                y_explore <= y_curr + 1;
                                addr_explore <= addr + 640;
                            end
                            
                            explore_dir <= DIR_GET_DOWNLEFT;                        
                        end
                        
                        DIR_GET_DOWNLEFT: begin
                            if (addr + 640 - 1 == addr_prev) begin
                                state <= STATE_EXPLORE;
                            end else begin
                                x_explore <= x_curr - 1;
                                y_explore <= y_curr + 1;
                                addr_explore <= addr + 640 - 1;
                            end
                            
                            explore_dir <= DIR_GET_LEFT;
                        end
                        
                        DIR_GET_LEFT: begin
                            if (addr - 1 == addr_prev) begin
                                state <= STATE_EXPLORE;
                            end else begin
                                x_explore <= x_curr - 1;
                                y_explore <= y_curr;
                                addr_explore <= addr - 1;
                            end
                            
                            explore_dir <= DIR_GET_UPLEFT;
                        end
                        
                        DIR_GET_UPLEFT: begin
                            if (addr - 640 - 1 == addr_prev) begin
                                state <= STATE_EXPLORE;
                            end else begin
                                x_explore <= x_curr - 1;
                                y_explore <= y_curr - 1;
                                addr_explore <= addr - 640 - 1;
                            end
                            
                            explore_dir <= DIR_GET_UP;
                        end
                        
                        DIR_GET_UP: begin
                            if (addr - 640 == addr_prev) begin
                                state <= STATE_EXPLORE;
                            end else begin
                                x_explore <= x_curr;
                                y_explore <= y_curr - 1;
                                addr_explore <= addr - 640;
                            end
                            
                            explore_dir <= DIR_GET_UPRIGHT;
                        end
                        
                        DIR_GET_UPRIGHT: begin
                            if (addr - 640 + 1 == addr_prev) begin
                                state <= STATE_EXPLORE;
                            end else begin
                                x_explore <= x_curr + 1;
                                y_explore <= y_curr - 1;
                                addr_explore <= addr - 640 + 1;
                            end
                            
                            explore_dir <= DIR_GET_RIGHT;
                        end
                    endcase                
                end
                
                STATE_IS_IT_EDGE: begin
//                    if (addr_explore == addr_start) begin
//                        done <= 1;
                    if (set_bin == 3) begin
                        done <= 1;
                    end
                    else begin
                        if (edge_out != 3'b000) begin
                            //update our memory of current and past pixels
                            x_prev <= x_curr;
                            y_prev <= y_curr;
                            addr_prev <= addr_curr;
                            
                            x_curr <= x_explore;
                            y_curr <= y_explore;
                            addr_curr <= addr_explore;
                            
                            explore_dir <= 0;
                            pixel_count <= pixel_count + 1;
                            
                            //write that bin into the bram location. check to see if we have all pixels in that bin
                            addr <= addr_explore;
                            we <= 1;
                            bin_in <= set_bin;
                            if (pixel_count == pixel_per_bin) begin
                                pixel_count <= 0;
                                set_bin <= set_bin + 1;
                            end                                   
                        end
                        else begin
                            state <= STATE_EXPLORE;
                            explore_dir <= explore_dir + 1;
                            if (explore_dir == max_explore_dir) begin
                                done <= 1;
                            end
                        end
                    end
                end
            
            
            endcase
        end
    end
    
endmodule
