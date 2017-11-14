`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/14/2017 04:28:22 PM
// Design Name: 
// Module Name: VGA_array_expansion
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

//This file expands the original VGA display which has 0 or 1 in place of edges.
//Expands each pixel into 3 (so that they can later be assigned bins) for color implementation

module VGA_array_expansion(
    input clock,
    input enable,
    input reset,
    output done
    );
    
    //array to expand. read only
    reg [8:0] array_addr = 0;
    reg [639:0] array_out;
    reg array_en;
    vga_display get_array(.addra(array_addr), .clka(clk), .douta(array_out), .ena(array_en), .wea(0));  //always reading
   
    //array that is expanded. write only
    reg [8:0] expand_addr = 0;
    reg [1919:0] expand_in;
    reg expand_en;
    vga_display write_expand_array(.addra(expand_addr), .clka(clk), .dina(expand_in), .ena(expand_en), .wea(1)); //always writing
  
    reg [9:0] index = 0;
    reg [9:0] max_index = 639; //640 indexed at 0    
    reg [8:0] max_addr = 479; // 480 indexed at
     
    parameter [1:0] STATE_EXPANDING = 0'b00;
    parameter [1:0] STATE_WRITE = 0'b01;
    parameter [1:0] STATE_SETUP_EXPANSION = 0'b10;
    
    reg [3:0] state = STATE_EXPANDING;
    reg done = 0;
    
    always @(posedge clk) begin
        if (reset) begin
            array_addr <= 0;
            array_en <= 1;
            
            expand_addr <= 0;
            expand_en <= 0;
            
            index <= 0;
            done <= 0;
        end
        else if (done != 1) begin
            case (state) 
                STATE_EXPANDING: begin
                    expand_in <= {expand_in << 3, 2'b00, array_out[index]};
                    index <= index + 1;
                    
                    if (index == max_index) begin
                        state <= STATE_WRITE;
                        if (array_addr == max_addr) begin
                            done <= 1;
                        end
                        else begin
                            array_addr <= array_addr + 1;
                            array_en <= 1;
                        end
                        
                    end 
                end
                
                STATE_WRITE: begin
                    expand_en <= 1;
                    state <= STATE_SETUP_EXPANSION; 
                end
                
                STATE_SETUP_EXPANSION: begin
                    expand_en <= 0;
                    array_en <= 0;
                    expand_addr <= expand_addr + 1;
                    
                    expand_in <= 0;
                end
          
            endcase
        end
    end
    
endmodule
