`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/12/2017 05:41:55 PM
// Design Name: 
// Module Name: sprite_contour_separation
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

//test after sprite_contours

module sprite_contour_separation(
        input clk
    );
    
    //bram setup
    //vga_display
    reg [8:0] vga_addr_read = 9'b0_00_00_00_00;    //row
    reg [10:0] read_index = 11'b0_00_00_00_00_00;     //column
    
    reg vga_en_down = 1;    // 1 = enabled ; 0 = disabled
    reg vga_en_up = 0;
    reg vga_we = 0;    // 1 = write ; 0 = read
    reg [1919:0] vga_bram_in = 0;
    wire [1919:0] vga_bram_in_wire;
    assign vga_bram_in_wire = vga_bram_in;
    
    //look ahead or behind in the rows
    reg [1919:0] vga_bram_out;
    reg [1919:0] vga_bram_out_up;
    reg [1919:0] vga_bram_out_down;
        
        
    //edge_positions
    reg [13:0] edge_addr_write = 0;
    reg [8:0] y_edge = 0;
    reg [9:0] x_edge = 0;
    wire [18:0] x_y_edge_wire;
    assign x_y_edge_wire = {x_edge, y_edge}; //x_y_edge;
    reg edge_en = 0;
    reg edge_we = 0;
    
    //setup bram
    vga_display get_disp_down(.addra(vga_addr_read), .clka(clk), .dina(vga_bram_in_wire), .douta(vga_bram_out_dpwm), .ena(vga_en_down), .wea(vga_we));
    vga_display get_disp_up(.addra(vga_addr_read), .clka(clk), .dina(vga_bram_in_wire), .douta(vga_bram_out_up), .ena(vga_en_up), .wea(vga_we));
    edge_positions insert_pos(.addra(edge_addr_write), .clka(clk), .dina(x_y_edge_wire), .ena(edge_en), .wea(edge_we)); // don't have anything for .douta
    
    //states
    parameter [3:0] STATE_GET_FIRST_ROW = 3'b000;
    parameter [3:0] STATE_GET_FIRST_COLUMN = 3'b100;
    parameter [3:0] STATE_GET_SLOPE = 3'b001;
    parameter [3:0] STATE_GET_EDGE = 3'b010;
    parameter [3:0] STATE_FOLLOW_EDGE = 3'b011;
    parameter [3:0] STATE_GET_NEXT_ROW_DOWN = 3'b101;
    parameter [3:0] STATE_GET_EDGE_DIR = 3'b110;
    parameter [3:0] STATE_GET_NEXT_ROW_UP = 3'b111;
    
    parameter [3:0] STATE_UP = 4'b1000;
    parameter [3:0] STATE_UP_RIGHT = 4'b1001;
    parameter [3:0] STATE_RIGHT = 4'b1010;
    parameter [3:0] STATE_DOWN_RIGHT = 4'b1011;
    parameter [3:0] STATE_DOWN = 4'b100;
    parameter [3:0] STATE_DOWN_LEFT = 4'b101;
    parameter [3:0] STATE_LEFT = 4'b110;
    parameter [3:0] STATE_UP_LEFT = 4'b111;
    
    reg [2:0] state = STATE_GET_FIRST_ROW;
    reg [2:0] prev_state = STATE_GET_FIRST_ROW;
    
    //to remember
    reg [11:0] x_start = 0;
    reg [10:0] y_start = 0;
    
    reg [8:0] x_pos = 0;    // read = y_pos * 3
    reg [9:0] y_pos = 0;
    
    reg [6:0] x_slope = 0;
    reg [6:0] y_slope = 0;
    reg [1:0] x_dir = 0;      // 0 = none, 1 = left, 2 = right
    reg [1:0] y_dir = 0;      // 0 = none, 1 = up, 2 = down
    
    //polygon
    reg [2:0] get_dir_index = 0;
    reg [9:0] edge_length_fixed = 0;
    reg [9:0] edge_length_count = 0;
    
    reg [11:0] x_prev = 0;
    reg [10:0] y_prev = 0;
    
    always @(posedge clk) begin
        case(state)
            STATE_GET_FIRST_ROW: begin
                vga_en_down <= 1;
                vga_we <= 0;
                if (vga_bram_out == 0) begin
                    prev_state <= STATE_GET_FIRST_ROW;
                    state <= STATE_GET_NEXT_ROW_DOWN;
                end
                else begin
                    y_start <= vga_addr_read - 1;
                    y_pos <= vga_addr_read - 1;
                    state <= STATE_GET_FIRST_COLUMN;
                end
            end
            
            STATE_GET_NEXT_ROW_DOWN: begin
                vga_en_down <= 1;
                vga_we <= 0;
                
                vga_addr_read <= vga_addr_read + 1;
                y_pos <= y_pos + 1;
                
                vga_bram_out_up <= vga_bram_out;
                vga_bram_out <= vga_bram_out_down;
                
                state <= prev_state;
                
            end
            
            STATE_GET_NEXT_ROW_UP: begin
                vga_en_up <= 1;
                vga_we <= 0;
                
                vga_addr_read <= vga_addr_read - 1;
                y_pos <= y_pos - 1;
                
                vga_bram_out_down <= vga_bram_out;
                vga_bram_out <= vga_bram_out_up;
                
                state <= prev_state;
                
            end
            
            STATE_GET_FIRST_COLUMN: begin
                vga_en_down = 0;
                if ((vga_bram_out[read_index] == 0) && (vga_bram_out[read_index+1] == 0) && (vga_bram_out[read_index+2] == 0)) begin
                    read_index <= read_index + 3;
                    x_pos <= x_pos + 1;
                end
                else begin
                    x_start <= x_pos;
                    state <= STATE_GET_EDGE_DIR;
                    get_dir_index <= 0;
                    x_dir <= 0;
                    y_dir <= 0;
                end
            end
            
            STATE_GET_EDGE_DIR: begin
                //current state: is at read_index, vga_addr_read - 1
                
                if (get_dir_index == 3'b111) begin
                    state <= STATE_FOLLOW_EDGE;
                end
                
                else begin
                    get_dir_index <= get_dir_index + 1;
                    x_prev <= x_pos;
                    y_prev <= y_pos;
                    prev_state <= STATE_GET_EDGE_DIR;
                    
                    //up
                    if (((vga_bram_out_up[read_index] != 0) || (vga_bram_out_up[read_index + 1] != 0) || (vga_bram_out_up[read_index + 2] != 0)) && 
                        ((y_pos - 1 != y_prev))) begin                        
                        state <= STATE_UP;
                    end                    
                    //up-right
                    else if (((vga_bram_out_up[read_index + 3] != 0) || (vga_bram_out_up[read_index + 4] != 0) || (vga_bram_out_up[read_index + 5] != 0) ) && 
                        ((y_pos - 1 != y_prev) || (x_pos + 1 != x_prev)))begin
                        state <= STATE_UP_RIGHT;
                    end                    
                    //right
                    else if (((vga_bram_out[read_index + 3] != 0) || (vga_bram_out[read_index + 4] != 0) || (vga_bram_out[read_index + 5] != 0) ) && 
                        ((x_pos + 1 != x_prev)))begin
                        state <= STATE_RIGHT;
                    end                    
                    //down-right
                    else if (((vga_bram_out_down[read_index + 3] != 0) || (vga_bram_out_down[read_index + 4] != 0) || (vga_bram_out_down[read_index + 5] != 0) ) &&
                        ((y_pos + 1 != y_prev) || (x_pos + 1 != x_prev)))begin
                        state <= STATE_DOWN_RIGHT;
                    end                    
                    //down
                    else if (((vga_bram_out_down[read_index] != 0) || (vga_bram_out_down[read_index + 1] != 0) || (vga_bram_out_down[read_index + 2] != 0)) && 
                        ((y_pos + 1 != y_prev))) begin
                        state <= STATE_DOWN;
                    end                                      
                    //down_left
                    else if (((vga_bram_out_down[read_index - 1] != 0) || (vga_bram_out_down[read_index - 2] != 0) || (vga_bram_out_down[read_index - 3] != 0) ) &&
                        ((y_pos + 1 != y_prev) || (x_pos - 1 != x_prev)))begin
                        state <= STATE_DOWN_LEFT;
                    end                    
                    //left
                    else if (((vga_bram_out[read_index - 1] != 0) || (vga_bram_out[read_index - 2] != 0) || (vga_bram_out[read_index -3] != 0) ) && 
                       ((x_pos - 1 != x_prev)))begin
                        state <= STATE_LEFT;
                   end                    
                    //up-left
                    else if (((vga_bram_out_up[read_index - 1] != 0) || (vga_bram_out_up[read_index - 2] != 0) || (vga_bram_out_up[read_index - 3] != 0) ) &&
                        ((y_pos - 1 != y_prev) || (x_pos - 1 != x_prev)))begin
                        state <= STATE_UP_LEFT;
                    end                                        
                end
            end
            
            STATE_UP: begin            
                y_dir <= 1; //up                                  
                state <= STATE_GET_NEXT_ROW_UP;                
                y_pos <= y_pos - 1;
            end
            
            STATE_UP_RIGHT: begin           
                read_index <= read_index + 3;                
                x_dir <= 2; //right
                y_dir <= 1; //up                
                state <= STATE_GET_NEXT_ROW_UP;                
                x_pos <= x_pos + 1;
                y_pos <= y_pos - 1;
            end
            
            STATE_RIGHT: begin                        
                read_index <= read_index + 3;                
                x_dir <= 2; //right                
                x_pos <= x_pos + 1;                 
                state <= STATE_GET_EDGE_DIR;           
            end
            
            STATE_DOWN_RIGHT: begin                                    
                read_index <= read_index + 3;                
                x_dir <= 2; //right
                y_dir <= 2; //down                
                state <= STATE_GET_NEXT_ROW_DOWN;               
                x_pos <= x_pos + 1;
                y_pos <= y_pos + 1;
            end
            
            STATE_DOWN: begin                                   
                y_dir <= 2; //down                
                state <= STATE_GET_NEXT_ROW_DOWN;                
                y_pos <= y_pos + 1;
            end
            
            STATE_DOWN_LEFT: begin                                    
                read_index <= read_index - 3;                
                x_dir <= 1; //left
                y_dir <= 2; //down                
                state <= STATE_GET_NEXT_ROW_DOWN;                
                x_pos <= x_pos -1;
                y_pos <= y_pos + 1;
            end
            
            STATE_LEFT: begin                                       
                read_index <= read_index - 3;                
                x_dir <= 1; //left                
                x_pos <= x_pos - 1;                
                state <= STATE_GET_EDGE_DIR;
            end
            
            STATE_UP_LEFT: begin                                    
                read_index <= read_index - 3;                
                x_dir <= 1; //left
                y_dir <= 1; //up                
                state <= STATE_GET_NEXT_ROW_UP;                
                x_pos <= x_pos - 1;
                y_pos <= y_pos - 1;
            end
            
            STATE_FOLLOW_EDGE: begin
                if (x_pos == 0 || y_pos == 0) begin
                    prev_state <= STATE_FOLLOW_EDGE;
                    x_prev <= x_pos;
                    y_prev <= y_pos;
                    
                    //left
                    if (x_pos == 1) begin
                        if (((vga_bram_out[read_index - 1] != 0) || (vga_bram_out[read_index - 2] != 0) || (vga_bram_out[read_index -3] != 0) ) && 
                            ((x_pos - 1 != x_prev)))begin
                                state <= STATE_LEFT;
                        end
                        else state <= STATE_GET_EDGE_DIR;
                    end
                    
                    //right
                    else if (x_pos == 2) begin
                        if (((vga_bram_out[read_index + 3] != 0) || (vga_bram_out[read_index + 4] != 0) || (vga_bram_out[read_index + 5] != 0) ) && 
                            ((x_pos + 1 != x_prev)))begin
                            state <= STATE_RIGHT;
                        end
                        else state <= STATE_GET_EDGE_DIR;                         
                    end
                    
                    //up
                    else if(y_pos == 1) begin
                        if (((vga_bram_out_up[read_index] != 0) || (vga_bram_out_up[read_index + 1] != 0) || (vga_bram_out_up[read_index + 2] != 0)) && 
                            ((y_pos - 1 != y_prev))) begin                        
                            state <= STATE_UP;
                        end
                        else state <= STATE_GET_EDGE_DIR;                        
                    end
                    
                    //down
                    else if (y_pos == 2) begin
                        if (((vga_bram_out_down[read_index] != 0) || (vga_bram_out_down[read_index + 1] != 0) || (vga_bram_out_down[read_index + 2] != 0)) && 
                            ((y_pos + 1 != y_prev))) begin
                            state <= STATE_DOWN;
                        end
                        else state <= STATE_GET_EDGE_DIR;
                    end
                end
            end          
        endcase
    end 
endmodule