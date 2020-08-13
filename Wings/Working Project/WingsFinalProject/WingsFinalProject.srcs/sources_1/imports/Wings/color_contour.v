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
    
    //things for the bram
    output reg [18:0] addr,
    input [2:0] edge_out,
    output reg [2:0] bin_in,
    output reg we,
    
    //this can be commented out
    output reg [2:0] state_out,
    input start,
    output reg [11:0] pixel_count,
    output reg [2:0] set_bin_out
    
    );
        
    parameter STATE_SETUP = 0;
    parameter STATE_WAIT = 1;
    parameter STATE_EXPLORE = 2;
    parameter STATE_IS_IT_EDGE = 3;
    parameter STATE_WAIT_TWO = 4;
    parameter STATE_DONE = 5;
    parameter STATE_DONE_PREMATURE = 6;
    
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
    
    reg [2:0] state = STATE_SETUP;
    reg [2:0] next_state;
    
    
    reg [9:0] x_prev = 0;
    reg [8:0] y_prev = 0;
    reg [18:0] addr_prev = 0;
    reg [9:0] x_curr;
    reg [8:0] y_curr;
    reg [18:0] addr_curr = 0;
        
    reg [9:0] x_explore;
    reg [8:0] y_explore;
    reg [18:0] addr_explore = 0;
    
    reg [11:0] pixel_per_bin; 
    wire [23:0] divide_out;
    wire divide_valid;
    reg divisor_ready;
    reg dividend_ready;
    reg [7:0] divisor_in;
    reg [15:0] dividend_in;
    
    div_gen_0 getting_pixels_per_bin (
        .aclk(clk),                                      // input wire aclk
        .s_axis_divisor_tvalid(divisor_ready),    // input wire s_axis_divisor_tvalid
        .s_axis_divisor_tdata(divisor_in),      // input wire [7 : 0] s_axis_divisor_tdata
        .s_axis_dividend_tvalid(dividend_ready),  // input wire s_axis_dividend_tvalid
        .s_axis_dividend_tdata(dividend_in),    // input wire [15 : 0] s_axis_dividend_tdata
        .m_axis_dout_tvalid(divide_valid),          // output wire m_axis_dout_tvalid
        .m_axis_dout_tdata(divide_out)            // output wire [23 : 0] m_axis_dout_tdata
    );
    
    
    always @(posedge clk) begin
        state_out <= state;
        set_bin_out <= bin_in;
        if (reset) begin
            state <= STATE_SETUP;
        end                       
    
        if (start) begin        
                        
            case (state)
                STATE_SETUP: begin
                    bin_in <= 1;
                    done <= 0;
                    addr <= addr_start;
                    addr_curr <= addr_start; 
                    we <= 1;
                    
                    divisor_ready <= 1;
                    dividend_ready <= 1;
                    divisor_in <= {5'h00, num_bins};
                    dividend_in <= {4'h0, num_pixels};
                    
                    pixel_count <= 0;
                    
                    if (divide_valid) begin                   
                        pixel_per_bin <= divide_out[19:8] + 1;
                                                
                        next_state <= STATE_EXPLORE;
                        state <= STATE_WAIT;
                    end                
                    
                end
                
                STATE_WAIT: begin
                    state <= STATE_WAIT_TWO;
                end
                
                STATE_WAIT_TWO: begin
                    state <= next_state;
                end
                
                STATE_EXPLORE: begin
                    next_state <= STATE_IS_IT_EDGE;
                    state <= STATE_WAIT;
                    
                    we <= 0;
                    
                    case (explore_dir)
                        DIR_GET_RIGHT: begin                        
                            if (addr_curr + 1 == addr_prev) begin
                                state <= STATE_EXPLORE;
                                explore_dir <= explore_dir + 1;
                            end else begin
                                addr <= addr_curr + 1;
                            end
                        end
                        
                        DIR_GET_DOWNRIGHT: begin
                            if (addr_curr + 640 + 1 == addr_prev) begin
                                state <= STATE_EXPLORE;
                                explore_dir <= explore_dir + 1;
                            end else begin                                                        
                                addr <= addr_curr + 640 + 1;
                            end
                        end
                        
                        DIR_GET_DOWN: begin
                            if (addr_curr + 640 == addr_prev) begin
                                state <= STATE_EXPLORE;
                                explore_dir <= explore_dir + 1;
                            end else begin
                                addr <= addr_curr + 640;
                            end
                        end
                        
                        DIR_GET_DOWNLEFT: begin
                            if (addr_curr + 640 - 1 == addr_prev) begin
                                state <= STATE_EXPLORE;
                                explore_dir <= explore_dir + 1;
                            end else begin
                                addr <= addr_curr + 640 - 1;
                            end
                        end
                        
                        DIR_GET_LEFT: begin
                            if (addr_curr - 1 == addr_prev) begin
                                state <= STATE_EXPLORE;
                                explore_dir <= explore_dir + 1;
                            end else begin
                                addr <= addr_curr - 1;
                            end
                        end
                        
                        DIR_GET_UPLEFT: begin
                            if (addr_curr - 640 - 1 == addr_prev) begin
                                state <= STATE_EXPLORE;
                                explore_dir <= explore_dir + 1;
                            end else begin
                                addr <= addr_curr - 640 - 1;
                            end
                        end
                        
                        DIR_GET_UP: begin
                            if (addr_curr - 640 == addr_prev) begin
                                state <= STATE_EXPLORE;
                                explore_dir <= explore_dir + 1;
                            end else begin
                                addr <= addr_curr - 640;
                            end
                        end
                        
                        DIR_GET_UPRIGHT: begin
                            if (addr_curr - 640 + 1 == addr_prev) begin
                                state <= STATE_EXPLORE;
                                explore_dir <= explore_dir + 1;
                            end else begin
                                addr <= addr_curr - 640 + 1;
                            end
                        end
                    endcase                
                end
                
                STATE_IS_IT_EDGE: begin
                    state <= STATE_EXPLORE;

                    if (addr == addr_start) begin
                        state <= STATE_DONE;
                    end
                    else begin
                        if (edge_out != 3'b000) begin
                            //update our memory of current and past pixels
                            addr_prev <= addr_curr;                            
                            addr_curr <= addr;
                            
                            explore_dir <= 0;
                            pixel_count <= pixel_count + 1;
                            
                            //write that bin into the bram location. check to see if we have all pixels in that bin
                            we <= 1;
                            if (pixel_count == pixel_per_bin) begin
                                pixel_count <= 0;
                                bin_in <= bin_in + 1;
                            end
                        end
                        else begin
                            explore_dir <= explore_dir + 1;
                            if (explore_dir == max_explore_dir) begin
                                state <= STATE_DONE_PREMATURE;
                            end
                        end
                    end
                end
                
                STATE_DONE: begin
                //edge is finished
                    done <= 1;
                    we <= 0;
                end
                
                STATE_DONE_PREMATURE: begin
                //following the edge is finished prematurely. edge is not a closed contour
                    done <= 1;
                    we <= 0;
                end             
            
            endcase
        end
    end    
endmodule