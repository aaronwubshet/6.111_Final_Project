`timescale 1ns / 1ps
`default_nettype none 

module top(
    input wire CLK_100M,
	input wire [15:0] SW,
	output wire [15:0] LED,
	output wire RGB1_Blue, RGB1_Green, RGB1_Red,
	output wire RGB2_Blue, RGB2_Green, RGB2_Red,
	output wire [7:0] SSEG_CA, output wire [7:0] SSEG_AN, //7 segment LED display
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
    
/*    //camera signals
    wire camera_pwdn;
    wire camera_clk_in;
    wire camera_clk_out;
    wire [7:0] camera_dout;
    wire camera_scl, camera_sda;
    wire camera_vsync, camera_hsync;      
    wire [15:0] camera_pixel;
    wire camera_pixel_valid;
    wire camera_reset;
    wire camera_frame_done;
    
    assign camera_clk_in = clk_25mhz;
    assign camera_pwdn = 0;
    assign camera_reset = ~reset; 
    
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
    assign JB[1] = camera_clk_in;
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
    
    assign memory_write_addr = SW[6] ? 0 : memory_write_addr_cam;    
    assign memory_write_enable = SW[6] ? 0 : memory_write_enable_cam;*/
    
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
//    assign memory_write_enable = 0;
        
    //frame buffer memory   
    frame_buffer frame_buffer_1 (
        .clka(clk_25mhz),
        .wea(memory_write_enable),
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
    
//    wire [2:0] edge_bram_dinb;
    wire [2:0] edge_bram_doutb;
    wire [18:0] edge_bram_addrb;
    
    assign edge_bram_addr = image_edge_bram_addr;
    assign edge_bram_din = image_edge_bram_din;
    assign memory_read_addr = ~SW[6]? vga_bram_addr : ~image_done ? image_memory_read_addr : vga_bram_addr;
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
        .dinb(),//edge_bram_dinb),
        .doutb(edge_bram_doutb)
    );
    
    
    wire [18:0] image_edge_bram_addr;
    wire [18:0] image_edge_bram_addrb;
    wire [2:0] image_edge_bram_din;
    wire image_done;
    
    wire [18:0] image_memory_read_addr;
//    wire [18:0] memory_write_addr_process;
    wire memory_write_enable_process;
    
    image_processing box(
        .clk_25mhz(clk_25mhz),
        .CLK_100M(CLK_100M),    
        .SW(SW[5:0]),
        .num_bins(3'b100),
//        .start(SW[6]),
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
        .edge_bram_din(image_edge_bram_din),
        
        //camera
        .JA(JA),
        .JB(JB),
        .BTNC(BTNC),
        .BTNU(BTNU),
        .image_start(SW[6])
    );
    
    assign LED[0] = image_done;
    
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
       
   
   
//   wire [11:0] memory_read_data;
//   wire [11:0] memory_write_data;
//   wire [18:0] memory_read_addr;
//   wire [18:0] memory_write_addr;
//   wire memory_write_enable; 

            
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
        
  
//        //8-HEX SETUP FOR TESTING               
//    wire [31:0] data;
//    wire [6:0] segments;
//    display_8hex display(.clk(clk_25mhz),.data(data), .seg(segments), .strobe(SSEG_AN));    
//    assign SSEG_CA[6:0] = segments;
//    assign SSEG_CA[7] = 1'b1;
    
//    assign data = {29'h0, check_state};//, 8'b0, state};



