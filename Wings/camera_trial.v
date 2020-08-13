
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/07/2017 02:38:36 PM
// Design Name: 
// Module Name: top_camera
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

`timescale 1ns / 1ps
`default_nettype none 

module camera_trial(
    input wire CLK_100M,
	input wire [15:0] SW,
	output wire [15:0] LED,
	output wire RGB1_Blue, RGB1_Green, RGB1_Red,
	output wire RGB2_Blue, RGB2_Green, RGB2_Red,
	output wire [7:0] SSEG_CA, [7:0] SSEG_AN, //7 segment LED display
	input wire CPU_RESETN, BTNC, BTNU, BTNL, BTNR, BTND, //buttons
	inout wire [7:0] JA, JB, JC, JD, //PMOD headers
	//input wire [3:0] XA_N, XA_P, //analog inputs
	output wire [3:0] VGA_R, VGA_G, VGA_B, //VGA outputs
	output wire VGA_HS, VGA_VS
	
    );
    
    wire reset;
    assign reset = 0;
   
    wire clk_25mhz;
    
    //camera signals
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
     
    assign camera_clk_in = video_clk;
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
   
   wire [11:0] memory_read_data;
   wire [11:0] memory_write_data;
   wire [18:0] memory_read_addr;
   wire [18:0] memory_write_addr;
   wire memory_write_enable; 
   
    //clock generation
     video_clk video_clk_1 (
        .clk_in1(CLK_100M), 
        .clk_out1(clk_25mhz)              
        );
        
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
        .memory_addr(memory_write_addr),
        .memory_we(memory_write_enable)
        );
            
    video_playback video_playback_1 (
        .pixel_data(memory_read_data),
        .video_clk(clk 25mhz),
        .memory_addr(memory_read_addr),
        .vsync(VGA_VS),
        .hsync(VGA_HS),
        .video_out({VGA_R, VGA_G, VGA_B})
        );
        
       
       
    //frame buffer memory   
    frame_buffer frame_buffer_1 (
        .clka(camera_clk_out),
        .wea(memory_write_enable),
        .addra(memory_write_addr),
        .dina(memory_write_data),
        .clkb(video_clk),
        .enb(1'b1),
        .addrb(memory_read_addr),
        .doutb(memory_read_data)
        );
    
 
endmodule
