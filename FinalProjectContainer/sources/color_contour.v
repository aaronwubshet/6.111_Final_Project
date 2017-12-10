`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/30/2017 05:24:25 PM
// Design Name: 
// Module Name: one_edge
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
    input wire clk,
    input wire [11:0] num_pixels,
    input wire [2:0] num_bins,
    output reg done, //AARON CHANGED THIS TO NOT HAVE THE EQUAL SIGN
    input wire start,
    
    //writing to the BRAM of the edges
    input wire [2:0] bram_read,
    output reg [2:0] bram_write,
    output reg [18:0] edge_addr_read,
    output reg [18:0] edge_addr_write
    );
    
    initial done = 0; //AARON ADDED THIS LINE SO THAT DONE IS ONLY INITLALY 0 BUT EVENTUALLY COULD GO UP TO 1
    parameter WIDTH = 640;
    parameter HEIGHT = 480;


    parameter STATE_SETUP = 0;
    parameter STATE_WAIT = 1;
    parameter STATE_EXPLORE = 2;
    parameter STATE_IS_IT_EDGE = 3;
    parameter STATE_WAIT_TWO = 4;
    parameter STATE_GET_FIRST = 6;
    
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
    
    reg [18:0] addr_start;
    reg [11:0] pixel_count;
    reg [2:0] bin_in;
    
    
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
    
    
    
    div_gen_0 your_instance_name (
      .aclk(clk),                                      // input wire aclk
      .s_axis_divisor_tvalid(divisor_ready),    // input wire s_axis_divisor_tvalid
      .s_axis_divisor_tdata(divisor_in),      // input wire [7 : 0] s_axis_divisor_tdata
      .s_axis_dividend_tvalid(dividend_ready),  // input wire s_axis_dividend_tvalid
      .s_axis_dividend_tdata(dividend_in),    // input wire [15 : 0] s_axis_dividend_tdata
      .m_axis_dout_tvalid(divide_valid),          // output wire m_axis_dout_tvalid
      .m_axis_dout_tdata(divide_out)            // output wire [23 : 0] m_axis_dout_tdata
    );
    
 
    reg [11:0] manual_pixel_bin = 12'h162;
    reg first = 1;
    
    always @(posedge clk) begin
        if (~start) begin
            state <= STATE_SETUP;
            done <= 0;
            bin_in <= 3'b001;
            pixel_count <= 0;
            divisor_ready <= 0;
            dividend_ready <= 0;
        end
        else if (~done) begin
                               
                            
        case (state)
            STATE_SETUP: begin
                bram_write <= 3'b000;
                edge_addr_read <= 0;
                edge_addr_write <= 0;
                x_curr <= 0;
                y_curr <= 0;
                
                addr_prev <= 0;
                
                divisor_ready <= 1;
                dividend_ready <= 1;
                divisor_in <= {5'h00, num_bins};
                dividend_in <= {4'h0, num_pixels};
        
                pixel_count <= 0;
        
                if (divide_valid) begin                   
                    pixel_per_bin <= divide_out[19:8] + 1;
                                    
                    next_state <= STATE_GET_FIRST;
                    state <= STATE_WAIT;
                end
                
                                                            
//                next_state <= STATE_GET_FIRST;
//                state <= STATE_WAIT;
            end
            
            STATE_GET_FIRST: begin
                if (bram_read != 0) begin                
//                    x_start <= x_curr;
//                    y_start <= y_curr;
                    addr_start <= edge_addr_read;
                    
                    bram_write <= bin_in;
                    edge_addr_write <= edge_addr_read;
                    
                    addr_curr <= edge_addr_read;
                    
                    state <= STATE_EXPLORE;                    
                end
                else begin
                    edge_addr_read <= edge_addr_read + 1;
                    if (x_curr == WIDTH - 1) begin
                        x_curr <= 0;
                        y_curr <= y_curr + 1;
                    end else begin
                        x_curr <= x_curr + 1;
                    end
                    
                    state <= STATE_WAIT;
                    next_state <= STATE_GET_FIRST;
                    
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
                                
                case (explore_dir)
                    DIR_GET_RIGHT: begin                        
                        if (addr_curr + 1 == addr_prev) begin
                            state <= STATE_EXPLORE;
                            explore_dir <= explore_dir + 1;
                        end else begin
                            edge_addr_read <= addr_curr + 1;
                        end
                    end
                    
                    DIR_GET_DOWNRIGHT: begin
                        if (addr_curr + 640 + 1 == addr_prev) begin
                            state <= STATE_EXPLORE;
                            explore_dir <= explore_dir + 1;
                        end else begin                                                        
                            edge_addr_read <= addr_curr + 640 + 1;
                        end
                    end
                    
                    DIR_GET_DOWN: begin
                        if (addr_curr + 640 == addr_prev) begin
                            state <= STATE_EXPLORE;
                            explore_dir <= explore_dir + 1;
                        end else begin
                            edge_addr_read <= addr_curr + 640;
                        end
                    end
                    
                    DIR_GET_DOWNLEFT: begin
                        if (addr_curr + 640 - 1 == addr_prev) begin
                            state <= STATE_EXPLORE;
                            explore_dir <= explore_dir + 1;
                        end else begin
                            edge_addr_read <= addr_curr + 640 - 1;
                        end
                    end
                    
                    DIR_GET_LEFT: begin
                        if (addr_curr - 1 == addr_prev) begin
                            state <= STATE_EXPLORE;
                            explore_dir <= explore_dir + 1;
                        end else begin
                            edge_addr_read <= addr_curr - 1;
                        end
                    end
                    
                    DIR_GET_UPLEFT: begin
                        if (addr_curr - 640 - 1 == addr_prev) begin
                            state <= STATE_EXPLORE;
                            explore_dir <= explore_dir + 1;
                        end else begin
                            edge_addr_read <= addr_curr - 640 - 1;
                        end
                    end
                    
                    DIR_GET_UP: begin
                        if (addr_curr - 640 == addr_prev) begin
                            state <= STATE_EXPLORE;
                            explore_dir <= explore_dir + 1;
                        end else begin
                            edge_addr_read <= addr_curr - 640;
                        end
                    end
                    
                    DIR_GET_UPRIGHT: begin
                        if (addr_curr - 640 + 1 == addr_prev) begin
                            state <= STATE_EXPLORE;
                            explore_dir <= explore_dir + 1;
                        end else begin
                            edge_addr_read <= addr_curr - 640 + 1;
                        end
                    end
                endcase                
            end
                
            STATE_IS_IT_EDGE: begin
                state <= STATE_EXPLORE;

                if (edge_addr_read == addr_start) begin
                    done <= 1;
                    state <= STATE_WAIT;
                end
                else begin
                    if (bram_read != 0) begin //3'b001) begin
                    
                        //update our memory of current and past pixels
                        addr_prev <= addr_curr;                            
                        addr_curr <= edge_addr_read;
                        
                        explore_dir <= 0;
//                        num_pixels <= num_pixels + 1;
                        
                        //write that bin into the bram location
                        edge_addr_write <= edge_addr_read;
                        
                        bram_write <= bin_in;
                        
                        pixel_count <= pixel_count + 1;
//                        if (pixel_count == pixel_per_bin) begin 
                        if (pixel_count ==  manual_pixel_bin) begin
                            bin_in <= bin_in + 1;
                            pixel_count <= 0;
                        end
                    end
                    else begin
                        explore_dir <= explore_dir + 1;                            
                    end
                end
            end
            
                        
            
        endcase
        end
    end    
endmodule

