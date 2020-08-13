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
        .BTNL(BTNL),
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



