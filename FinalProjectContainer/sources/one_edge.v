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


module one_edge(
    input wire clk,
    output reg [11:0] num_pixels,
    output reg done = 0,
    input wire start,
    
    //writing to the BRAM of the edges
    input wire [2:0] bram_read,
    output reg [2:0] bram_write,
    output reg [18:0] edge_addr_read,
    output reg [18:0] edge_addr_write

    );
        
    parameter WIDTH = 640;
    parameter HEIGHT = 480;


    parameter STATE_SETUP = 0;
    parameter STATE_WAIT = 1;
    parameter STATE_EXPLORE = 2;
    parameter STATE_IS_IT_EDGE = 3;
    parameter STATE_WAIT_TWO = 4;
    parameter STATE_CLEAR_REST = 5;
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
    
    
    reg [9:0] x_prev = 0;
    reg [8:0] y_prev = 0;
    reg [18:0] addr_prev = 0;
    reg [9:0] x_curr;
    reg [8:0] y_curr;
    reg [18:0] addr_curr = 0;
        
    reg [9:0] x_explore;
    reg [8:0] y_explore;
    reg [18:0] addr_explore = 0;
    
    reg [18:0] addr_start;
    
    
 
    
    always @(posedge clk) begin
        if (start == 0) begin
            state <= STATE_SETUP;
            done <= 0;
        end
        else if (~done) begin
                               
                            
        case (state)
            STATE_SETUP: begin
                bram_write <= 3'b000;
                edge_addr_read <= 0;
                edge_addr_write <= 0;
                x_curr <= 0;
                y_curr <= 0;
                num_pixels <= 0;
                                                            
                next_state <= STATE_GET_FIRST;
                state <= STATE_WAIT;
            end
            
            STATE_GET_FIRST: begin
                if ((x_curr > 35) && (y_curr > 35) && (bram_read == 3'b011)) begin
                    addr_start <= edge_addr_read;
                    
                    bram_write <= 3'b111;
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
                    
                    edge_addr_read <= 0; //addr_start;
                    state <= STATE_WAIT;
                    next_state <= STATE_CLEAR_REST;
                end
                else begin
                    if (bram_read == 3'b011) begin
                        //update our memory of current and past pixels
                        addr_prev <= addr_curr;                            
                        addr_curr <= edge_addr_read;
                        
                        explore_dir <= 0;
                        num_pixels <= num_pixels + 1;
                        
                        //write that bin into the bram location
                        edge_addr_write <= edge_addr_read;
                        bram_write <= 3'b111;
                    end
                    else begin
                        explore_dir <= explore_dir + 1;                            
                    end
                end
            end
            
            STATE_CLEAR_REST: begin
                edge_addr_read <= edge_addr_read + 1;
                if (bram_read == 3'b111) begin
                    bram_write <= 3'b001;
                    edge_addr_write <= edge_addr_read;
//                    num_pixels <= num_pixels + 1;
                end
                else begin
                    bram_write <= 3'b000;
                    edge_addr_write <= edge_addr_read;
                end
                
                if (edge_addr_read > 307000) begin //200) begin
                    done <= 1;
                end
                
                state <= STATE_WAIT;
                next_state <= STATE_CLEAR_REST;
                
            end
                        
            
        endcase
        end
    end    
endmodule

