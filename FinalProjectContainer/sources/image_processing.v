`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/05/2017 12:51:49 PM
// Design Name: 
// Module Name: image_processing
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


module image_processing(
    input wire clk_25mhz,
    input wire CLK_100M,    
    input wire [5:0] SW,
    input wire [2:0] num_bins,
    output wire done,
    
    //frame buffer
    input wire [11:0] memory_read_data,
    output wire [11:0] memory_write_data,
    output wire [18:0] memory_read_addr,
    output wire [18:0] memory_write_addr,
    output wire memory_write_enable,
    
    //xy bram
    input wire [2:0] edge_bram_doutb,
    output wire [18:0] edge_bram_addr,
    output wire [18:0] edge_bram_addrb,
    output wire [2:0] edge_bram_din
    

);
   
  
        
    
    wire sobel_done;
    wire [18:0] sobel_edge_bram_addr;
    wire [18:0] sobel_rgb_bram_addr;
    wire [2:0] sobel_edge_bram_din;
    
    //sobel edge detection    
    sobel edge_detection(
        .clk(CLK_100M),
        .start(1),
        .done(sobel_done),
        .SW(SW),
        
        .pixel_data(memory_read_data),
        .pic_memory_addr(sobel_rgb_bram_addr),
        
        .is_edge(sobel_edge_bram_din),
        .edge_memory_addr(sobel_edge_bram_addr)
    );
   
   
        
    
    wire erosion_done;
    wire [18:0] erosion_edge_bram_addrb;
    wire [2:0] erosion_edge_bram_din;
    wire [18:0] erosion_edge_bram_addr;
    wire [2:0] erosion_edge_bram_doutb;
    
    edge_pixel_width skinny_edge(
        .clk(clk_25mhz),
        .start(sobel_done),
        .done(erosion_done),
        
        .bram_read(edge_bram_doutb),
        .bram_write(erosion_edge_bram_din),
        .edge_addr_read(erosion_edge_bram_addrb),
        .edge_addr_write(erosion_edge_bram_addr)
        
    );
    
    wire [9:0] x_start;
    wire [8:0] y_start;
    wire [18:0] addr_start;
    wire [11:0] num_edge_pixels;
    wire one_edge_done;
    wire [2:0] one_edge_bram_din;
    wire [18:0] one_edge_addrb;
    wire [18:0] one_edge_addr;
    
    one_edge isolate(
        .clk(clk_25mhz),
        .num_pixels(num_edge_pixels),
        .done(one_edge_done),
        .start(erosion_done),
        .bram_read(edge_bram_doutb),
        .bram_write(one_edge_bram_din),
        .edge_addr_read(one_edge_addrb),
        .edge_addr_write(one_edge_addr)
    );
    
    wire color_contour_done;
    wire [18:0] color_contour_addr;
    wire [18:0] color_contour_addrb;
    wire [2:0] color_contour_bram_din;
    wire color_contour_we;
    
    
    color_contour separate(
        .clk(clk_25mhz),
        .num_pixels(num_edge_pixels),
        .num_bins(num_bins),
        .done(color_contour_done),
        .start(one_edge_done),
        .bram_read(edge_bram_doutb),
        .bram_write(color_contour_bram_din),
        .edge_addr_read(color_contour_addrb),
        .edge_addr_write(color_contour_addr)
    );
    
    assign edge_bram_addr = ~sobel_done ? sobel_edge_bram_addr : ~erosion_done ? erosion_edge_bram_addr : 
                            ~one_edge_done ? one_edge_addr : color_contour_addr; 
    assign edge_bram_addrb = ~erosion_done ? erosion_edge_bram_addrb : ~one_edge_done ? one_edge_addrb : 
                            color_contour_addrb;
    assign memory_read_addr = sobel_rgb_bram_addr; //~sobel_done ?  sobel_rgb_bram_addr : vga_bram_addr; 
    assign edge_bram_din = ~sobel_done ? sobel_edge_bram_din : ~erosion_done ? erosion_edge_bram_din : 
                            ~one_edge_done? one_edge_bram_din : color_contour_bram_din;
                            
    assign done = color_contour_done;
    
    
endmodule

