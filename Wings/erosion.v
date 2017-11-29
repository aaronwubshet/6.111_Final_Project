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


module erosion(
input wire clk,
    input wire start,
    output reg done,
    
    //writing to the BRAM of the edges
    input wire [3:0] bram_read,
    output reg [3:0] bram_write,
    output reg [18:0] edge_memory_addr,
    output reg bram_we
    );
    
    reg [3:0] pixel0, pixel1, pixel2, pixel3, pixel4, pixel5, pixel6, pixel7, pixel8;
    reg [3:0] pixel_load0, pixel_load1, pixel_load2;
    
    parameter STATE_SETUP = 0;
    parameter STATE_WAIT = 3;
    parameter STATE_WAIT2 = 4;
    parameter STATE_GET_9 = 5;
    parameter STATE_ERODE = 6;
    parameter STATE_SHIFTWINDOW = 8;
    reg [4:0] state = STATE_SETUP;
    reg [4:0] next_state;
    
    parameter WIDTH = 640;
    parameter HEIGHT = 480;
    
    reg [9:0] x;
    reg [8:0] y;
    
    reg [6:0] GX; //6
    reg [6:0] GY; //6
    
    reg [11:0] GX2; //11
    reg [11:0] GY2; //11
    reg [11:0] threshold = 12'd3000;
    
    reg [18:0] write_xy_addr;
    reg [18:0] read_xy_addr;
   
    
    
    reg [3:0] i = 0;
    reg [5:0] old_SW = 16'hFFFF;
    
        
    always @(posedge clk) begin
        if (~done) begin
        case (state)
            STATE_SETUP: begin                
                i <= 0;
                x <= 1;
                y <= 1;
                edge_memory_addr <= 0;
                write_xy_addr <= 640 + 1;
                read_xy_addr <= 0;
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
                        edge_memory_addr <= edge_memory_addr + 1;
                    end
                    1: begin
                        pixel1 = bram_read;
                        edge_memory_addr <= edge_memory_addr + 1;
                    end
                    2: begin
                        pixel2 = bram_read;
                        edge_memory_addr <= edge_memory_addr + WIDTH - 2;
                    end
                    3: begin
                        pixel3 = bram_read;
                        edge_memory_addr <= edge_memory_addr + 1;
                    end
                    4: begin
                        pixel4 = bram_read;
                        edge_memory_addr <= edge_memory_addr + 1;
                    end
                    5: begin
                        pixel5 = bram_read;
                        edge_memory_addr <= edge_memory_addr + WIDTH - 2;
                    end
                    6: begin
                        pixel6 = bram_read;
                        edge_memory_addr <= edge_memory_addr + 1;
                    end
                    7: begin
                        pixel7 = bram_read;
                        edge_memory_addr <= edge_memory_addr + 1;
                    end
                    8: begin
                        pixel8 = bram_read;
                        edge_memory_addr <= edge_memory_addr - WIDTH - WIDTH + 1;
                        next_state <= STATE_ERODE;
                    end                    
                endcase
            end 
            
            
            
            STATE_SHIFTWINDOW: begin
                i <= i + 1;
                state <= STATE_WAIT;
                next_state <= STATE_SHIFTWINDOW;
                
                read_xy_addr <= edge_memory_addr;
                bram_write <= write_xy_addr;
                
                case(i)
                    0: begin
                        pixel_load0 = bram_read;
                        edge_memory_addr <= edge_memory_addr + WIDTH;
                    end
                    
                    1: begin
                        pixel_load1 = bram_read;
                        edge_memory_addr <= edge_memory_addr + WIDTH;
                    end
                    
                    2: begin
                        pixel_load2 = bram_read;
                        edge_memory_addr <= edge_memory_addr - WIDTH - WIDTH + 1;
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
                        
                        state <= STATE_ERODE;
                    end
                endcase
            end
            
            STATE_ERODE: begin
                if (pixel0 != 0 && pixel1 != 0 && pixel2 != 0 && pixel3 != 0 && pixel4 != 0 &&
                    pixel5 != 0 && pixel6 != 0 && pixel7 != 0 && pixel8 != 0) begin
                    bram_write <= 3'b010;
                    bram_we <= 1;
                    read_xy_addr <= edge_memory_addr;
                    edge_memory_addr <= write_xy_addr;
                    
                end
                write_xy_addr <= write_xy_addr;
                state <= STATE_SHIFTWINDOW;               
                i <= 0;
                if (( x == WIDTH - 1) && (y == HEIGHT - 2)) begin
                    done <= 1;
                end
            end
            
        endcase
        end
    end
endmodule