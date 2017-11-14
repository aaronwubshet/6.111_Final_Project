`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/12/2017 02:47:40 PM
// Design Name: 
// Module Name: sprite_contours
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


module sprite_contours(
        input clk
    );
    
    //bram setup
    reg [9:0] addr_read = 10'b00_00_00_00_00;    //row
    reg [9:0] read_index = 10'b0_00_00_00_00;     //column
    wire [1023:0] bram_out;
    reg ena;    // 1 = enabled ; 0 = disabled
    
    reg wea;    // 1 = write ; 0 = read
    
    reg[9:0] addr_write = 10'b11_0011_0000;
    
    reg [1023:0] bram_in = 0;
    wire [1203:0] bram_in_wire;
    assign bram_in_wire = bram_in;
    
    wire [1023:0] bram_out_next;
    reg en_next;
    
//    blk_mem_gen_0 get_edge(.addra(addr), .clka(clk), .dina(bram_in_wire), .douta(bram_out), .ena(ena), .wea(wea));
//    blk_mem_gen_0 get_edge_next(.addra(addr), .clka(clk), .dina(bram_in_wire), .douta(bram_out_next), .ena(en_next), .wea(wea));
    
    //states
    parameter [2:0] STATE_GET_FIRST_ROW = 3'b000;
    parameter [2:0] STATE_GET_FIRST_COLUMN = 3'b100;
    parameter [2:0] STATE_GET_SLOPE = 3'b001;
    parameter [2:0] STATE_GET_EDGE = 3'b010;
    parameter [2:0] STATE_DONE = 3'b011;
    parameter [2:0] STATE_GET_FIRST_EDGE = 3'b101;
    parameter [2:0] STATE_GET_EDGE_SETUP = 3'b110;
    parameter [2:0] STATE_GET_XSLOPE = 3'b111;
    
    reg [2:0] state = STATE_GET_FIRST_ROW;
    
    //to remember
    reg [11:0] x_start = 0;
    reg [10:0] y_start = 0;
    
    reg [6:0] x_slope = 0;
    reg [6:0] y_slope = 0;
    reg x_dir = 0;      // 0 = left, 1 = right
    reg y_dir = 0;      // 0 = up, 1 = down
    
    //polygon
    reg [4:0] get_slope_index = 0;
    reg [9:0] edge_length_fixed = 0;
    reg [9:0] edge_length_count = 0;
    
    always @(posedge clk) begin
        case (state)            
            STATE_GET_FIRST_ROW: begin
                ena = 1;
                wea = 0;
                if (bram_out == 0) begin
                    addr_read <= addr_read + 1;
                end
                else begin
                    y_start <= addr;
                    state <= STATE_GET_FIRST_COLUMN;
                end
            end
            
            STATE_GET_FIRST_COLUMN: begin
                ena = 0;
                if (bram_out[read_index] == 1) begin
                    x_start <= read_index;
/*                    state <= STATE_GET_SLOPE;
                    
                    //preliminary slope: all to the right (horizontal)
                    x_slope <= 1;
                    y_slope <= 0;
                    x_dir <= 1;
                    y_dir <= 1;*/
                    
                    state <= STATE_GET_FIRST_EDGE;
                    edge_length_fixed <= 0;
                    
                end
                else begin
                    read_index <= read_index + 1;
                end
            end
            
            STATE_GET_FIRST_EDGE: begin
                if (bram_out[read_index] == 1) begin
                    read_index <= read_index + 1;
                    edge_length_fixed <= edge_length_fixed + 1;
                end
                else begin
                    state <= STATE_GET_EDGE_SETUP;
                end
            end
            
            STATE_GET_DIRECTION: begin
                ena <= 1;
                en_next <= 1;
                wea <= 0;
                
                
            /*                    state <= STATE_GET_SLOPE;
                                
                                //preliminary slope: all to the right (horizontal)
                                x_slope <= 1;
                                y_slope <= 0;
                                x_dir <= 1;
                                y_dir <= 1;*/
                                
                get_slope_index <= get_slope_index + 1;
                
                if (bram_out[read_index + 1] == 1) begin
                    read_index <= read_index + 1;
                    
                    x_slope <= x_slope + 1;
                    x_dir <= 1;
                    
//                    y_slope <= y_slope;
//                    y_dir <= y_dir;
                end
                else if (bram_out[read_index - 1] == 1) begin
                    read_index <= read_index + 1;
                    
                    x_slope <= x_slope + 1;
                    x_dir <= 0;
                    
//                    y_slope <= y_slope;
//                    y_dir <= y_dir;
                    
                    
                end 
                else if (bram_out_next[read_index] == 1) begin
                    read_index <= read_index + 1;
                
//                    x_slope <= x_slope;
//                    x_dir <= x_dir;
                
                    y_slope <= y_slope + 1;
                    y_dir <= 1;
                
                end
                else if (bram_out_next[read_index + 1] == 1) begin
                    read_index <= read_index + 1;
            
                    x_slope <= x_slope + 1;
                    x_dir <= 1;
            
                    y_slope <= y_slope + 1;
                    y_dir <= 1;
                end
                else if (bram_out_next[read_index - 1] == 1) begin
                    read_index <= read_index + 1;
        
                    x_slope <= x_slope + 1;
                    x_dir <= 0;
        
                    y_slope <= y_slope + 1;
                    y_dir <= 1;                
                end
                
                                
            end
            
            STATE_GET_XSLOPE: begin
                if (x_slope == 0) begin
                
                    if (bram_out[read_index + 1] == 1) begin
                        x_dir <= 1;
                    end
                    else if (bram_out[read_index - 1] == 1) begin
                        x_dir <= 0;
                    end
                end
            end
            
            STATE_GET_EDGE_SETUP: begin

            end
            
            STATE_GET_EDGE: begin
            end
            
            STATE_DONE: begin
            end
        endcase
    end
    
endmodule
