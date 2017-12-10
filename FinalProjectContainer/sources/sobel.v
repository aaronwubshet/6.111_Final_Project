`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/28/2017 04:02:12 PM
// Design Name: 
// Module Name: sobel
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


module sobel(
    input wire clk,
    input wire start,
    output reg done,
    input wire [5:0] SW,  //lower 6 switches

    //from the BRAM of the original picture
    input wire [11:0] pixel_data,
    output reg [18:0] pic_memory_addr,
    
    //writing to the BRAM of the edges
    output reg [2:0] is_edge,
    output reg [18:0] edge_memory_addr
    );
    
    reg [3:0] bw_pixel0, bw_pixel1, bw_pixel2, bw_pixel3, bw_pixel4, bw_pixel5, bw_pixel6, bw_pixel7, bw_pixel8;
    reg [3:0] bw_pixel_load0, bw_pixel_load1, bw_pixel_load2;
    
    parameter STATE_SETUP = 0;
    parameter STATE_THRESHOLD = 2;
    parameter STATE_WAIT = 3;
    parameter STATE_WAIT2 = 4;
    parameter STATE_GET_9 = 5;
    parameter STATE_CALCULATE_G = 6;
    parameter STATE_SQUARE = 7;
    parameter STATE_SHIFTWINDOW = 8;
    parameter STATE_SQUARE2 = 9;
    reg [4:0] state = STATE_SETUP;
    reg [4:0] next_state;
    
    parameter WIDTH = 640;
    parameter HEIGHT = 480;
    
    reg [9:0] x;
    reg [8:0] y;
    reg [9:0] x_buffer = 25;
    reg [8:0] y_buffer = 25;
    
    reg [6:0] GX; 
    reg [6:0] GY; 
    
    reg [11:0] GX2; //11
    reg [11:0] GY2; //11
    reg [11:0] threshold; // = 12'd3000;
   
    
    
    reg [3:0] i = 0;
    reg [5:0] old_SW = 16'hFFFF;   
        
    always @(posedge clk) begin
        if (SW != old_SW) begin
            threshold <= {SW[5], SW[5], SW[4], SW[4], SW[3], SW[3], SW[2], SW[2], SW[1], SW[1], SW[0], SW[0]};
            old_SW <= SW;
            state <= STATE_SETUP;
            done <= 0;
        end
        if (~done) begin
        case (state)
            STATE_SETUP: begin                
                pic_memory_addr <= 0;
                i <= 0;
                x <= 1;
                y <= 1;
                edge_memory_addr <= 641;
                done <= 0;
                
                if (start) begin                
                    state <= STATE_WAIT;
                    next_state <= STATE_GET_9;
                end
            end
            
            STATE_WAIT: state <= STATE_WAIT2;
            
            STATE_WAIT2: state <= next_state;
                    
            STATE_GET_9: begin
                i <= i + 1;
                state <= STATE_WAIT;
                next_state <= STATE_GET_9;
                
                case (i)
                    0: begin
                        bw_pixel0 = (pixel_data[11:8] >> 2) + (pixel_data[7:4] >> 1) + (pixel_data[7:4] >> 3) + (pixel_data[3:0] >> 3);
                        pic_memory_addr <= pic_memory_addr + 1;
                    end
                    1: begin
                        bw_pixel1 = (pixel_data[11:8] >> 2) + (pixel_data[7:4] >> 1) + (pixel_data[7:4] >> 3) + (pixel_data[3:0] >> 3);
                        pic_memory_addr <= pic_memory_addr + 1;
                    end
                    2: begin
                        bw_pixel2 = (pixel_data[11:8] >> 2) + (pixel_data[7:4] >> 1) + (pixel_data[7:4] >> 3) + (pixel_data[3:0] >> 3);
                        pic_memory_addr <= pic_memory_addr + WIDTH - 2;
                    end
                    3: begin
                        bw_pixel3 = (pixel_data[11:8] >> 2) + (pixel_data[7:4] >> 1) + (pixel_data[7:4] >> 3) + (pixel_data[3:0] >> 3);
                        pic_memory_addr <= pic_memory_addr + 1;
                    end
                    4: begin
                        bw_pixel4 = (pixel_data[11:8] >> 2) + (pixel_data[7:4] >> 1) + (pixel_data[7:4] >> 3) + (pixel_data[3:0] >> 3);
                        pic_memory_addr <= pic_memory_addr + 1;
                    end
                    5: begin
                        bw_pixel5 = (pixel_data[11:8] >> 2) + (pixel_data[7:4] >> 1) + (pixel_data[7:4] >> 3) + (pixel_data[3:0] >> 3);
                        pic_memory_addr <= pic_memory_addr + WIDTH - 2;
                    end
                    6: begin
                        bw_pixel6 = (pixel_data[11:8] >> 2) + (pixel_data[7:4] >> 1) + (pixel_data[7:4] >> 3) + (pixel_data[3:0] >> 3);
                        pic_memory_addr <= pic_memory_addr + 1;
                    end
                    7: begin
                        bw_pixel7 = (pixel_data[11:8] >> 2) + (pixel_data[7:4] >> 1) + (pixel_data[7:4] >> 3) + (pixel_data[3:0] >> 3);
                        pic_memory_addr <= pic_memory_addr + 1;
                    end
                    8: begin
                        bw_pixel8 = (pixel_data[11:8] >> 2) + (pixel_data[7:4] >> 1) + (pixel_data[7:4] >> 3) + (pixel_data[3:0] >> 3);
                        pic_memory_addr <= pic_memory_addr - WIDTH - WIDTH + 1;
                        state <= STATE_CALCULATE_G;
                    end                    
                endcase
            end 
                    
            STATE_CALCULATE_G: begin
                GX <= bw_pixel0 - bw_pixel2 + (bw_pixel3 << 1) - (bw_pixel5 << 1) + bw_pixel6 - bw_pixel8;
                GY <= bw_pixel0 + (bw_pixel1 << 1) + bw_pixel2 - bw_pixel6 - (bw_pixel7 << 1) - bw_pixel8;
                state <= STATE_SQUARE;
            end
                    
            STATE_SQUARE: begin
                GX2 <= GX * GX;
                state <= STATE_SQUARE2;
            end
            
            STATE_SQUARE2: begin
                GY2 <= GY * GY;
                
                i <= 0;
                
                state <= STATE_SHIFTWINDOW;
            end
            
            STATE_SHIFTWINDOW: begin
                i <= i + 1;
                state <= STATE_WAIT;
                next_state <= STATE_SHIFTWINDOW;
                case(i)
                    0: begin
                        bw_pixel_load0 = (pixel_data[11:8] >> 2) + (pixel_data[7:4] >> 1) + (pixel_data[7:4] >> 3) + (pixel_data[3:0] >> 3);
                        pic_memory_addr <= pic_memory_addr + WIDTH;
                    end
                    
                    1: begin
                        bw_pixel_load1 = (pixel_data[11:8] >> 2) + (pixel_data[7:4] >> 1) + (pixel_data[7:4] >> 3) + (pixel_data[3:0] >> 3);
                        pic_memory_addr <= pic_memory_addr + WIDTH;
                    end
                    
                    2: begin
                        bw_pixel_load2 = (pixel_data[11:8] >> 2) + (pixel_data[7:4] >> 1) + (pixel_data[7:4] >> 3) + (pixel_data[3:0] >> 3);
                        pic_memory_addr <= pic_memory_addr - WIDTH - WIDTH + 1;
                    end
                    
                    3: begin
                        bw_pixel0 <= bw_pixel1;
                        bw_pixel1 <= bw_pixel2;
                        bw_pixel2 <= bw_pixel_load0;
                        bw_pixel3 <= bw_pixel4;
                        bw_pixel4 <= bw_pixel5;
                        bw_pixel5 <= bw_pixel_load1;
                        bw_pixel6 <= bw_pixel7;
                        bw_pixel7 <= bw_pixel8;
                        bw_pixel8 <= bw_pixel_load2;
                        
                        if (x == WIDTH - 1) begin
                            x <= 0;
                            y <= y + 1;
                        end
                        else begin
                            x <= x + 1;
                        end
                        
                        state <= STATE_THRESHOLD;
                    end
                endcase
            end
            
            STATE_THRESHOLD: begin
                edge_memory_addr <= edge_memory_addr + 1;
                is_edge <= (GX2 + GY2) > threshold ? 3'b001: 3'b000;
                state <= STATE_CALCULATE_G;
                
                i <= 0;
                
                
                if ((x < x_buffer)  || (x > (WIDTH - x_buffer)) || (y < y_buffer) || ( y >( HEIGHT - y_buffer ))) begin
                    state <= STATE_SHIFTWINDOW;
                    is_edge <= 0;
                end
                else begin
                    state <= STATE_CALCULATE_G;
                end
                
                if (( x == WIDTH - 1) && (y == HEIGHT - 2)) begin
                    done <= 1;
                end
            end
        endcase
        end
    end
endmodule
