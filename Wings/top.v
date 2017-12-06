`timescale 1ns / 1ps
`default_nettype none 

module top(
    input wire CLK_100M,
	input wire [15:0] SW,
	output wire [15:0] LED,
	output wire RGB1_Blue, RGB1_Green, RGB1_Red,
	output wire RGB2_Blue, RGB2_Green, RGB2_Red,
//	output wire [7:0] SSEG_CA, output wire [7:0] SSEG_AN, //7 segment LED display
	input wire CPU_RESETN, BTNC, BTNU, BTNL, BTNR, BTND, //buttons
	inout wire [7:0] JA, JB, JC, JD, //PMOD headers
	//input wire [3:0] XA_N, XA_P, //analog inputs
	output wire [3:0] VGA_R, VGA_G, VGA_B, //VGA outputs
	output wire VGA_HS, VGA_VS,
	
	//inout wire [1:0] SD_DAT,
	inout wire [3:0] SD_DAT,
	input wire SD_CMD, SD_SCK, SD_CD, SD_RESET
	
    );
    
    wire reset;
    assign reset = 0;
    
    wire clk_25mhz;
    
    //clock generation
    video_clk video_clk_1 (
        .clk_in1(CLK_100M), 
        .clk_out1(clk_25mhz)              
    );
    
    wire [11:0] memory_read_data;
    wire [11:0] memory_write_data;
    wire [18:0] memory_read_addr;
    wire [18:0] memory_write_addr;
    wire memory_write_enable; 
        
    //frame buffer memory   
    frame_buffer frame_buffer_1 (
        .clka(clk_25mhz),
        //.wea(memory_write_enable),
        .wea(0),
        .addra(memory_write_addr),
        .dina(memory_write_data),
        .clkb(clk_25mhz),
        .enb(1'b1),
        .addrb(memory_read_addr),
        .doutb(memory_read_data)
    );
    
    wire [2:0] edge_bram_din;
    wire [2:0] edge_bram_dout;
    wire [18:0] edge_bram_addr;
    wire edge_bram_we;
    
    wire [2:0] edge_bram_dinb;
    wire [2:0] edge_bram_doutb;
    wire [18:0] edge_bram_addrb;
    
    assign edge_bram_addr = image_edge_bram_addr;
//    assign edge_bram_addrb = image_edge_bram_addrb;
    assign edge_bram_din = image_edge_bram_din;
    assign memory_read_addr = ~image_done ? image_memory_read_addr : vga_bram_addr;
    assign edge_bram_addrb = ~image_done ? image_edge_bram_addrb : vga_bram_addr;
        
        //a = write, b = read
    edge_bram xy_edge (
        .clka(clk_25mhz),    // input wire clka
        .ena(1),      // input wire ena
        .wea(1),      // input wire [0 : 0] wea
        .addra(edge_bram_addr),  // input wire [18 : 0] addra
        .dina(edge_bram_din),    // input wire [2 : 0] dina
        .douta(edge_bram_dout),  // output wire [2 : 0] douta
        //
        .clkb(clk_25mhz),
        .enb(1),
        .web(0),
        .addrb(edge_bram_addrb),
        .dinb(edge_bram_dinb),
        .doutb(edge_bram_doutb)
    );
    
    
    wire [18:0] image_edge_bram_addr;
    wire [18:0] image_edge_bram_addrb;
    wire [2:0] image_edge_bram_din;
    wire image_done;
    
    wire [18:0] image_memory_read_addr;
    
    image_processing box(
        .clk_25mhz(clk_25mhz),
        .CLK_100M(CLK_100M),    
        .SW(SW[5:0]),
        .num_bins(3'b100),
        .done(image_done),
        
        //frame buffer
        .memory_read_data(memory_read_data),
        .memory_write_data(memory_write_data),
        .memory_read_addr(image_memory_read_addr),
        .memory_write_addr(memory_write_addr),
        .memory_write_enable(memory_write_enable),
        
        //xy bram
        .edge_bram_doutb(edge_bram_doutb),
        .edge_bram_addr(image_edge_bram_addr),
        .edge_bram_addrb(image_edge_bram_addrb),
        .edge_bram_din(image_edge_bram_din)
    );
    
    wire [18:0] vga_bram_addr;
    video_playback video_playback_1 (
        .pixel_data(edge_bram_doutb),
        .rgb_data(memory_read_data),
        .video_clk(clk_25mhz),
        .memory_addr(vga_bram_addr),
        .vsync(VGA_VS),
        .hsync(VGA_HS),
        .video_out({VGA_R, VGA_G, VGA_B})
        );


endmodule
       
    
//    wire reset;
//    assign reset = 0;
   
//    wire clk_25mhz;
    
//    //camera signals
//    wire camera_pwdn;
//    wire camera_clk_in;
//    wire camera_clk_out;
//    wire [7:0] camera_dout;
//    wire camera_scl, camera_sda;
//    wire camera_vsync, camera_hsync;      
//    wire [15:0] camera_pixel;
//    wire camera_pixel_valid;
//    wire camera_reset;
//    wire camera_frame_done;
     
//    assign camera_clk_in = clk_25mhz;
//    assign camera_pwdn = 0;
//    assign camera_reset = ~reset; 
    
////assign camera outputs
//   assign JA[0] = camera_pwdn;
//   assign camera_dout[0] = JA[1];
//   assign camera_dout[2] = JA[2];
//   assign camera_dout[4] = JA[3];
//   assign JA[4] = camera_reset;
//   assign camera_dout[1] = JA[5];
//   assign camera_dout[3] = JA[6];
//   assign camera_dout[5] = JA[7];
   
//   assign camera_dout[6] = JB[0];
//   assign JB[1] = camera_clk_in;
//   assign camera_hsync = JB[2];
//   //assign JB[3]= camera_sda; 
//   assign camera_dout[7] = JB[4];
//   assign camera_clk_out = JB[7];
//   assign camera_vsync = JB[5];
//   //assign JB[7] = camera_scl;
   
//   wire [11:0] memory_read_data;
//   wire [11:0] memory_write_data;
//   wire [18:0] memory_read_addr;
//   wire [18:0] memory_write_addr;
//   wire memory_write_enable; 
   
//    //clock generation
//     video_clk video_clk_1 (
//        .clk_in1(CLK_100M), 
//        .clk_out1(clk_25mhz)              
//        );

            
///*    
//    video_playback video_playback_1 (
//        .pixel_data(memory_read_data),
//        .video_clk(clk_25mhz),
//        .memory_addr(memory_read_addr),
//        .vsync(VGA_VS),
//        .hsync(VGA_HS),
////        .video_out({VGA_R, VGA_G, VGA_B})
//        .video_out({red, green, blue})   
//        );*/
            
//    wire [18:0] vga_bram_addr;
//    video_playback video_playback_1 (
//        .pixel_data(edge_bram_doutb),
//        .rgb_data(memory_read_data),
//        .video_clk(clk_25mhz),
//        .memory_addr(vga_bram_addr),
////        .vsync(VGA_VS),
////        .hsync(VGA_HS),
//        .vsync(vsync),
//        .hsync(hsync),
//        .video_out({VGA_R, VGA_G, VGA_B})
//        );
//    wire vsync, hsync;
//    assign VGA_VS = vsync;
//    assign VGA_HS = hsync;         
                
     
//    //frame buffer memory   
//    frame_buffer frame_buffer_1 (
//        .clka(clk_25mhz),
//        //.wea(memory_write_enable),
//        .wea(0),
//        .addra(memory_write_addr),
//        .dina(memory_write_data),
//        .clkb(clk_25mhz),
//        .enb(1'b1),
//        .addrb(memory_read_addr),
//        .doutb(memory_read_data)
//        );
        
        
        
    
//    wire sobel_done;
//    wire [18:0] sobel_edge_bram_addr;
//    wire [18:0] sobel_rgb_bram_addr;
//    wire [2:0] sobel_edge_bram_din;
//    //sobel edge detection    
//    sobel edge_detection(
//        .clk(CLK_100M),
//        .start(1),
//        .done(sobel_done),
//        .SW(SW[5:0]),
        
//        .pixel_data(memory_read_data),
//        .pic_memory_addr(sobel_rgb_bram_addr),
        
//        .is_edge(sobel_edge_bram_din),
//        .edge_memory_addr(sobel_edge_bram_addr)
//    );
    
    
        
//    wire [2:0] edge_bram_din;
//    wire [2:0] edge_bram_dout;
//    wire [18:0] edge_bram_addr;
//    wire edge_bram_we;
    
//    wire [2:0] edge_bram_dinb;
//    wire [2:0] edge_bram_doutb;
//    wire [18:0] edge_bram_addrb;
    
    
    
////    assign edge_bram_we = ~one_edge_done ? 1: ~color_contour_done ? color_contour_we : 0;
////    assign edge_bram_addr = ~sobel_done ? sobel_edge_bram_addr : ~erosion_done ? erosion_edge_bram_addr : 
////                            ~one_edge_done ? one_edge_addr : color_contour_addr; 
////    assign edge_bram_addrb = ~erosion_done ? erosion_edge_bram_addrb : ~one_edge_done ? one_edge_addrb : vga_bram_addr;
////    assign memory_read_addr = ~sobel_done ?  sobel_rgb_bram_addr : vga_bram_addr; 
////    assign edge_bram_din = ~sobel_done ? sobel_edge_bram_din : ~erosion_done ? erosion_edge_bram_din : 
////                            ~one_edge_done? one_edge_bram_din : color_contour_din;
                            
////    assign edge_bram_we = ~sobel_done ? 1: 0;
////    assign edge_bram_addr = ~sobel_done ? sobel_edge_bram_addr : ~erosion_done ? erosion_edge_bram_addr : 
////                            ~one_edge_done ? one_edge_addr : 0; 
////    assign edge_bram_addrb = ~erosion_done ? erosion_edge_bram_addrb : ~one_edge_done ? one_edge_addrb : vga_bram_addr;
////    assign memory_read_addr = ~sobel_done ?  sobel_rgb_bram_addr : vga_bram_addr; 
////    assign edge_bram_din = ~sobel_done ? sobel_edge_bram_din : ~erosion_done ? erosion_edge_bram_din : one_edge_bram_din;
//////                            ~one_edge_done? one_edge_bram_din : color_contour_din;

////    assign edge_bram_we = ~one_edge_done ? 1: ~color_contour_done ? color_contour_we : 0;
//    assign edge_bram_addr = ~sobel_done ? sobel_edge_bram_addr : ~erosion_done ? erosion_edge_bram_addr : 
//                            ~one_edge_done ? one_edge_addr : color_contour_addr; 
//    assign edge_bram_addrb = ~erosion_done ? erosion_edge_bram_addrb : ~one_edge_done ? one_edge_addrb : 
//                            ~color_contour_done ? color_contour_addrb : vga_bram_addr;
//    assign memory_read_addr = ~sobel_done ?  sobel_rgb_bram_addr : vga_bram_addr; 
//    assign edge_bram_din = ~sobel_done ? sobel_edge_bram_din : ~erosion_done ? erosion_edge_bram_din : 
//                            ~one_edge_done? one_edge_bram_din : color_contour_bram_din;
        

//    //a = write, b = read
//    edge_bram your_instance_name (
//        .clka(clk_25mhz),    // input wire clka
//        .ena(1),      // input wire ena
//        .wea(1),      // input wire [0 : 0] wea
//        .addra(edge_bram_addr),  // input wire [18 : 0] addra
//        .dina(edge_bram_din),    // input wire [2 : 0] dina
//        .douta(edge_bram_dout),  // output wire [2 : 0] douta
//        //
//        .clkb(clk_25mhz),
//        .enb(1),
//        .web(0),
//        .addrb(edge_bram_addrb),
//        .dinb(edge_bram_dinb),
//        .doutb(edge_bram_doutb)
//    );
    
//    wire erosion_done;
//    wire [18:0] erosion_edge_bram_addrb;
//    wire [2:0] erosion_edge_bram_din;
//    wire [18:0] erosion_edge_bram_addr;
//    wire [2:0] erosion_edge_bram_doutb;
    
//    edge_pixel_width skinny_edge(
//        .clk(clk_25mhz),
//        .start(sobel_done),
//        .done(erosion_done),
        
//        .bram_read(edge_bram_doutb),
//        .bram_write(erosion_edge_bram_din),
//        .edge_addr_read(erosion_edge_bram_addrb),
//        .edge_addr_write(erosion_edge_bram_addr)
        
//    );
    
//    wire [9:0] x_start;
//    wire [8:0] y_start;
//    wire [18:0] addr_start;
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
    
//    wire [11:0] check;
//    wire [2:0] num_bins;
//    assign num_bins = 3'b100;
    
//    wire [2:0] check_state;
//    color_contour separate(
//        .clk(clk_25mhz),
//        .num_pixels(num_edge_pixels),
//        .num_bins(num_bins),
//        .done(color_contour_done),
//        .start(one_edge_done),
//        .bram_read(edge_bram_doutb),
//        .bram_write(color_contour_bram_din),
//        .edge_addr_read(color_contour_addrb),
//        .edge_addr_write(color_contour_addr)
//    );
    
    
//        //8-HEX SETUP FOR TESTING               
//    wire [31:0] data;
//    wire [6:0] segments;
//    display_8hex display(.clk(clk_25mhz),.data(data), .seg(segments), .strobe(SSEG_AN));    
//    assign SSEG_CA[6:0] = segments;
//    assign SSEG_CA[7] = 1'b1;
    
//    assign data = {29'h0, check_state};//, 8'b0, state};

        
//endmodule

