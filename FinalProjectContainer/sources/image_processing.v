`timescale 1ns / 1ps


module image_processing(
    input wire clk_25mhz,
    input wire CLK_100M,    
    input wire [5:0] SW,
    input wire [2:0] num_bins,
//    input wire start,
    output wire done,
    
    //frame buffer
    input wire [11:0] memory_read_data,
    output wire [11:0] memory_write_data,
    output wire [18:0] memory_read_addr,
    output wire [18:0] memory_write_addr,
    output wire memory_write_enable ,
    
    //xy bram
    input wire [2:0] edge_bram_doutb,
    output wire [18:0] edge_bram_addr,
    output wire [18:0] edge_bram_addrb,
    output wire [2:0] edge_bram_din,
    
    //camera
    inout wire [7:0] JA,
    inout wire [7:0] JB,
    input wire BTNC,
    input wire BTNU,
    input wire BTNL,
    input wire image_start
    

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
        .capture_frame(BTNU),
        .camera_pixel(camera_pixel),
        .memory_data(memory_write_data),
        .memory_addr(memory_write_addr_cam),
        .memory_we(memory_write_enable_cam)
        );
    
    wire [18:0] memory_write_addr_cam;
    wire memory_write_enable_cam;
    
    assign memory_write_addr = image_start ? 0 : memory_write_addr_cam;    
    assign memory_write_enable = image_start ? 0 : memory_write_enable_cam;
       
    
    wire sobel_done;
    wire [18:0] sobel_edge_bram_addr;
    wire [18:0] sobel_rgb_bram_addr;
    wire [2:0] sobel_edge_bram_din;
        
    
    //sobel edge detection    
    sobel edge_detection(
        .clk(clk_25mhz),
        .start(image_start),
        .done(sobel_done),
//        .SW(SW),
        
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
    
    wire [11:0] num_edge_pixels;
    wire one_edge_done;
    wire [2:0] one_edge_bram_din;
    wire [18:0] one_edge_addrb;
    wire [18:0] one_edge_addr;
    
    one_edge isolate(
        .clk(clk_25mhz),
        .num_pixels(num_edge_pixels),
        .done(one_edge_done),
        .start(SW[5]), //erosion_done),
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
    wire junk;
    
    
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
    assign memory_read_addr = sobel_rgb_bram_addr;
    assign edge_bram_din = ~sobel_done ? sobel_edge_bram_din : ~erosion_done ? erosion_edge_bram_din : 
                            ~one_edge_done? one_edge_bram_din : color_contour_bram_din;
                            
//    assign done = color_contour_done;
   assign done = (SW[5] && image_start) ? color_contour_done: (image_start) ? erosion_done : 0;
//      assign done = (SW[5] && image_start &&SW[4]) ? color_contour_done: (SW[5] && image_start) ? one_edge_done : (image_start) ? erosion_done : 0;

   //~SW[5] ? erosion_done : color_contour_done;

    
    
endmodule



//`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////////
//// Company: 
//// Engineer: 
//// 
//// Create Date: 12/05/2017 12:51:49 PM
//// Design Name: 
//// Module Name: image_processing
//// Project Name: 
//// Target Devices: 
//// Tool Versions: 
//// Description: 
//// 
//// Dependencies: 
//// 
//// Revision:
//// Revision 0.01 - File Created
//// Additional Comments:
//// 
////////////////////////////////////////////////////////////////////////////////////


//module image_processing(
//    input wire clk_25mhz,
//    input wire CLK_100M,    
//    input wire [5:0] SW,
//    input wire [2:0] num_bins,
//    input wire start,
//    output wire done,
    
//    //frame buffer
//    input wire [11:0] memory_read_data,
////    output wire [11:0] memory_write_data,
//    output wire [18:0] memory_read_addr,
////    output wire [18:0] memory_write_addr,
//    output wire memory_write_enable ,
    
//    //xy bram
//    input wire [2:0] edge_bram_doutb,
//    output wire [18:0] edge_bram_addr,
//    output wire [18:0] edge_bram_addrb,
//    output wire [2:0] edge_bram_din
    

//);
        
    
//    wire sobel_done;
//    wire [18:0] sobel_edge_bram_addr;
//    wire [18:0] sobel_rgb_bram_addr;
//    wire [2:0] sobel_edge_bram_din;
    
//    assign memory_write_enable = 0;
    
    
//    //sobel edge detection    
//    sobel edge_detection(
//        .clk(CLK_100M),
//        .start(start),
////        .done(color_contour_done),
//        .done(sobel_done),
//        .SW(SW),
        
//        .pixel_data(memory_read_data),
//        .pic_memory_addr(sobel_rgb_bram_addr),
        
//        .is_edge(sobel_edge_bram_din),
//        .edge_memory_addr(sobel_edge_bram_addr)
//    );
   
//   assign color_contour_done = sobel_done;
////   assign erosion_done = sobel_done;
////   assign one_edge_done = sobel_done;
        
    
//    wire erosion_done;
//    wire [18:0] erosion_edge_bram_addrb;
//    wire [2:0] erosion_edge_bram_din;
//    wire [18:0] erosion_edge_bram_addr;
//    wire [2:0] erosion_edge_bram_doutb;
    
//    edge_pixel_width skinny_edge(
//        .clk(clk_25mhz),
//        .start(0), //sobel_done),
//        .done(erosion_done),
        
//        .bram_read(edge_bram_doutb),
//        .bram_write(erosion_edge_bram_din),
//        .edge_addr_read(erosion_edge_bram_addrb),
//        .edge_addr_write(erosion_edge_bram_addr)
        
//    );
    
//    wire [11:0] num_edge_pixels;
//    wire one_edge_done;
//    wire [2:0] one_edge_bram_din;
//    wire [18:0] one_edge_addrb;
//    wire [18:0] one_edge_addr;
    
//    one_edge isolate(
//        .clk(clk_25mhz),
//        .num_pixels(num_edge_pixels),
//        .done(one_edge_done),
//        .start(erosion_done),
//        .bram_read(edge_bram_doutb),
//        .bram_write(one_edge_bram_din),
//        .edge_addr_read(one_edge_addrb),
//        .edge_addr_write(one_edge_addr)
//    );
    
//    wire color_contour_done;
//    wire [18:0] color_contour_addr;
//    wire [18:0] color_contour_addrb;
//    wire [2:0] color_contour_bram_din;
//    wire color_contour_we;
//    wire junk;
    
    
//    color_contour separate(
//        .clk(clk_25mhz),
//        .num_pixels(num_edge_pixels),
//        .num_bins(num_bins),
//        .done(junk),
//        .start(one_edge_done),
//        .bram_read(edge_bram_doutb),
//        .bram_write(color_contour_bram_din),
//        .edge_addr_read(color_contour_addrb),
//        .edge_addr_write(color_contour_addr)
//    );
    
//    assign edge_bram_addr = ~sobel_done ? sobel_edge_bram_addr : ~erosion_done ? erosion_edge_bram_addr : 
//                            ~one_edge_done ? one_edge_addr : color_contour_addr; 
//    assign edge_bram_addrb = ~erosion_done ? erosion_edge_bram_addrb : ~one_edge_done ? one_edge_addrb : 
//                            color_contour_addrb;
//    assign memory_read_addr = sobel_rgb_bram_addr;
//    assign edge_bram_din = ~sobel_done ? sobel_edge_bram_din : ~erosion_done ? erosion_edge_bram_din : 
//                            ~one_edge_done? one_edge_bram_din : color_contour_bram_din;
                            
//    assign done = color_contour_done;
    
    
//endmodule

