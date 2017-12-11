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
    input wire sobel_start, 
    input wire edge_start,
    input wire color_start, 
    
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
    output wire [2:0] edge_bram_din,
    
    //display
    output wire [3:0] VGA_R, 
    output wire [3:0] VGA_B, 
    output wire [3:0] VGA_G, 
    output wire VGA_HS, 
    output wire VGA_VS,
    
    //camera
    inout wire [7:0] JA,
    inout wire [7:0] JB,
    input wire BTNC,
    input wire BTNR,
    input wire BTNL
    

);
    //camera signals
wire camera_pwdn;
wire camera_clk_out;
wire [7:0] camera_dout;
wire camera_scl, camera_sda;
wire camera_vsync, camera_hsync;      
wire [15:0] camera_pixel;
wire camera_pixel_valid;
wire camera_reset;
wire camera_frame_done;

assign camera_pwdn = 0;
assign camera_reset = 1; 

//assign camera outputs
assign JA[0] = camera_pwdn;
assign camera_dout[0] = JA[1];
assign camera_dout[2] = JA[2];
assign camera_dout[4] = JA[3];
assign JA[4] = camera_reset;
assign camera_dout[1] = JA[5];
assign camera_dout[3] = JA[6];
assign camera_dout[5] = JA[7];

assign camera_dout[6] = JB[0];
assign JB[1] = clk_25mhz;
assign camera_hsync = JB[2];
//assign JB[3]= camera_sda; 
assign camera_dout[7] = JB[4];
assign camera_clk_out = JB[7];
assign camera_vsync = JB[5];
//assign JB[7] = camera_scl;



//camera configuration module    
camera_configure camera_configure_1 (
    .clk(clk_25mhz),
    .start(BTNC),
    .sioc(JB[6]),
    .siod(JB[3]),
    .done()
    );

//camera interface
camera_read camera_read_1 (
    .p_clock(camera_clk_out), 
    .vsync(camera_vsync), 
    .href(camera_hsync),
    .p_data(camera_dout), 
    .pixel_data(camera_pixel), 
    .pixel_valid(camera_pixel_valid),
    .frame_done(camera_frame_done) 
    );
    
//write camera data to frame buffer     
camera_address_gen camera_address_gen_1 (
    .camera_clk(camera_clk_out),
    .camera_pixel_valid(camera_pixel_valid),
    .camera_frame_done(camera_frame_done),
    .capture_frame(BTNR),
    .camera_pixel(camera_pixel),
    .memory_data(memory_write_data),
    .memory_addr(memory_write_addr_cam),
    .memory_we(memory_write_enable_cam)
    );

wire [18:0] memory_write_addr_cam;
wire memory_write_enable_cam;

assign memory_write_addr = memory_write_addr_cam; //image_start ? 0 : memory_write_addr_cam;    
assign memory_write_enable = memory_write_enable_cam; //image_start ? 0 : memory_write_enable_cam;
   
  
        
    
    wire sobel_done;
    wire [18:0] sobel_edge_bram_addr;
    wire [18:0] sobel_rgb_bram_addr;
    wire [2:0] sobel_edge_bram_din;
    
    //sobel edge detection    
    sobel edge_detection(
        .clk(CLK_100M),
        .start(sobel_start),
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
        .start(edge_start),
        .bram_read(edge_bram_doutb),
        .bram_write(one_edge_bram_din),
        .edge_addr_read(one_edge_addrb),
        .edge_addr_write(one_edge_addr),
        .clear(BTNL)
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
        .start(color_start),
        .bram_read(edge_bram_doutb),
        .bram_write(color_contour_bram_din),
        .edge_addr_read(color_contour_addrb),
        .edge_addr_write(color_contour_addr)
    );
    
//    wire padding_done;
//    wire [18:0] padding_edge_bram_addrb;
//    wire [2:0] padding_edge_bram_din;
//    wire [18:0] padding_edge_bram_addr;
//    padding pad(
//        .clk(clk_25mhz),
//        .start(color_contour_done),
//        .done(padding_done),
        
//        .bram_read(edge_bram_doutb),
//        .bram_write(padding_edge_bram_din),
//        .edge_addr_read(padding_edge_bram_addrb),
//        .edge_addr_write(padding_edge_bram_addr)
        
//    );
    
        
    wire [18:0] vga_bram_addr;
    video_playback video_playback_1 (
        .pixel_data(edge_bram_doutb),
        .rgb_data(memory_read_data),
        .video_clk(clk_25mhz),
        .memory_addr(vga_bram_addr),
        .vsync(VGA_VS),
        .hsync(VGA_HS),
        .video_out({VGA_R, VGA_G, VGA_B}),
        .contour(sobel_start)
        );
        
    wire [18:0] edge_bram_addrb_temp;
    wire [18:0] memory_read_addr_temp;
    assign edge_bram_addr = ~sobel_done ? sobel_edge_bram_addr : ~erosion_done ? erosion_edge_bram_addr : 
                            ~one_edge_done ? one_edge_addr : color_contour_addr;
//                            ~color_contour_done ? color_contour_addr : padding_edge_bram_addr; 
    assign edge_bram_addrb_temp = ~erosion_done ? erosion_edge_bram_addrb : ~one_edge_done ? one_edge_addrb : 
                            color_contour_addrb;
//                            ~color_contour_done ? color_contour_addrb : padding_edge_bram_addrb;                  
    assign memory_read_addr_temp = sobel_rgb_bram_addr; 
    assign edge_bram_din = ~sobel_done ? sobel_edge_bram_din : ~erosion_done ? erosion_edge_bram_din : 
                            ~one_edge_done? one_edge_bram_din : 
                            color_contour_bram_din;
//                            ~color_contour_done ? color_contour_bram_din : padding_edge_bram_din;
                                
    
    assign done = (sobel_start && edge_start && color_start) ? color_contour_done: //padding_done : //color_contour_done :
                    (sobel_start && edge_start) ? one_edge_done :
                    (sobel_start) ? erosion_done : 0;
                   
                    
    assign memory_read_addr = ~sobel_start ? vga_bram_addr : done ? vga_bram_addr : memory_read_addr_temp;
    assign edge_bram_addrb = ~sobel_start ? vga_bram_addr : done? vga_bram_addr : edge_bram_addrb_temp;
    
    
endmodule

