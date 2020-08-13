`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/29/2017 03:50:14 PM
// Design Name: 
// Module Name: erosion
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


module edge_pixel_width(
    input wire clk,
    input wire start,
    output reg done,
    
    //writing to the BRAM of the edges
    input wire [2:0] bram_read,
    output reg [2:0] bram_write,
    output reg [18:0] edge_addr_read,
    output reg [18:0] edge_addr_write
    );
    
    reg [2:0] n = 1;
    
    reg [3:0] pixel0, pixel1, pixel2, pixel3, pixel4, pixel5, pixel6, pixel7, pixel8;
    reg [3:0] pixel_load0, pixel_load1, pixel_load2;
    
    parameter STATE_SETUP = 0;
    parameter STATE_WAIT = 1;
    parameter STATE_WAIT2 = 2;
    parameter STATE_GET_9 = 3;
    
    parameter STATE_SHIFTWINDOW = 4;
    parameter STATE_MIDDLE_EDGE = 5;
    parameter STATE_UP = 6;
    parameter STATE_DOWN = 7;
    parameter STATE_RIGHT = 8;
    parameter STATE_LEFT = 9;
    
    
    reg [4:0] state = STATE_SETUP;
    reg [4:0] next_state;
    
    parameter WIDTH = 640;
    parameter HEIGHT = 480;
    
    reg [9:0] x;
    reg [8:0] y;
    
    reg [18:0] middle_addr;   
    
    
    reg [3:0] i = 0;
    reg [5:0] old_SW = 16'hFFFF;
    
        
    always @(posedge clk) begin
        if (~start) begin
            state <= STATE_SETUP;
            n <= 1;
            done <= 0;
        end
        else if (~done) begin
        case (state)
            STATE_SETUP: begin
                i <= 0;
                x <= 1;
                y <= 1;
                edge_addr_read <= 0;
                middle_addr <= 640 + 1;
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
                        pixel0 = bram_read;
                        edge_addr_read <= edge_addr_read + 1;
                    end
                    1: begin
                        pixel1 = bram_read;
                        edge_addr_read <= edge_addr_read + 1;
                    end
                    2: begin
                        pixel2 = bram_read;
                        edge_addr_read <= edge_addr_read + WIDTH - 2;
                    end
                    3: begin
                        pixel3 = bram_read;
                        edge_addr_read <= edge_addr_read + 1;
                    end
                    4: begin
                        pixel4 = bram_read;
                        edge_addr_read <= edge_addr_read + 1;
                    end
                    5: begin
                        pixel5 = bram_read;
                        edge_addr_read <= edge_addr_read + WIDTH - 2;
                    end
                    6: begin
                        pixel6 = bram_read;
                        edge_addr_read <= edge_addr_read + 1;
                    end
                    7: begin
                        pixel7 = bram_read;
                        edge_addr_read <= edge_addr_read + 1;
                    end
                    8: begin
                        pixel8 = bram_read;
                        edge_addr_read <= edge_addr_read - WIDTH - WIDTH + 1;
                        next_state <= STATE_MIDDLE_EDGE;
                    end                    
                endcase
            end 
            
            STATE_MIDDLE_EDGE: begin    //decides whether or not middle pixel is an edge
                if (pixel4 == n) begin //1) begin
                    state <= STATE_UP;
                end else begin
                    middle_addr <= middle_addr + 1;
                    state <= STATE_SHIFTWINDOW;
                    i <= 0;
                    
                end
            end
            
            STATE_UP: begin
                if (pixel1 == 0) begin
                    bram_write <= n + 1; //3'b010;
                    edge_addr_write <= middle_addr - 640;
                end
                state <= STATE_RIGHT;
            end
            
            STATE_RIGHT: begin
                if (pixel5 == 0) begin
                    bram_write <= n + 1; //3'b010;
                    edge_addr_write <= middle_addr + 1;
                end
                state <= STATE_DOWN;
            end
            
            STATE_DOWN: begin
                if (pixel7 == 0) begin
                    bram_write <= n + 1; //3'b010;
                    edge_addr_write <= middle_addr + 640;
                end
                state <= STATE_LEFT;
            end
            
            STATE_LEFT: begin
                if (pixel3 == 0) begin
                    bram_write <= n + 1; //3'b010;
                    edge_addr_write <= middle_addr - 1;
                end
                middle_addr <= middle_addr + 1;
                state <= STATE_SHIFTWINDOW;
                i <= 0;
            end
                
            
            
            STATE_SHIFTWINDOW: begin
                i <= i + 1;
                state <= STATE_WAIT;
                next_state <= STATE_SHIFTWINDOW;
                
                case(i)
                    0: begin
                        pixel_load0 = bram_read;
                        edge_addr_read <= edge_addr_read + WIDTH;
                    end
                    
                    1: begin
                        pixel_load1 = bram_read;
                        edge_addr_read <= edge_addr_read + WIDTH;
                    end
                    
                    2: begin
                        pixel_load2 = bram_read;
                        edge_addr_read <= edge_addr_read - WIDTH - WIDTH + 1;
                    end
                    
                    3: begin
                        pixel0 <= pixel1;
                        pixel1 <= pixel2;
                        pixel2 <= pixel_load0;
                        pixel3 <= pixel4;
                        pixel4 <= pixel5;
                        pixel5 <= pixel_load1;
                        pixel6 <= pixel7;
                        pixel7 <= pixel8;
                        pixel8 <= pixel_load2;
                        
                        if (x == WIDTH - 1) begin
                            x <= 0;
                            y <= y + 1;
                        end
                        else begin
                            x <= x + 1;
                        end
                        
                        if (middle_addr >= 307200 - 640 - 640) begin// ( x == WIDTH - 1) && (y == HEIGHT - 2)) begin
                            if (n == 2) begin
                                done <= 1;                                
                            end else begin
                                state <= STATE_SETUP;
                                n <= n + 1;
                            end
                        end else begin                        
                            state <= STATE_MIDDLE_EDGE;
                        end
                    end
                endcase
            end
            
        endcase
        end
    end
endmodule