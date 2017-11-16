`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/06/2017 08:23:41 PM
// Design Name: 
// Module Name: final_project
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


module final_project(
    //MASTER CLOCK
    input CLK100MHZ,
    
    //switches
    input [15:0] SW,
    
    //SD card stuff
    input SD_CD,
    output SD_RESET,
    output SD_SCK,
    output SD_CMD, 
    inout [3:0] SD_DAT,
    
    //JA and JB PMOD Headers for Camera input
    input [7:0] JA,
    input [7:0] JB,
    
    // video
    output [3:0] VGA_R,
    output [3:0] VGA_G,
    output [3:0] VGA_B,
    output VGA_HS,
    output VGA_VS,
  
    // audio
    output AUD_PWM,
    output AUD_SD, // PWM audio enable
    
    output wire [7:0] SEG,  // segments A-G (0-6), DP (7)
    output wire [7:0] AN    // Display 0-7
    );
//instantiate clock signals
wire clk_104mhz;
wire clk_65mhz;
wire clk_25mhz;
clk_wiz_0 clockgen(.clk_in1(CLK100MHZ), .clk_out1(clk_100mhz),.clk_out2(clk_65mhz),.clk_out3(clk_25mhz));

// INSTANTIATE XVGA SIGNALS (1024x768)
wire [10:0] hcount;
wire [9:0] vcount;
wire hsync, vsync, blank;
xvga xvga1(.vclock(clk_65mhz),.hcount(hcount),.vcount(vcount),.vsync(vsync),.hsync(hsync), .blank(blank));
        
// hex display
display_8hex display(.clk(clk_65mhz),.data(32'hDEAD_BEEF),.seg(SEG[6:0]),.strobe(AN));
        
        
        
        
        
        
        
        
endmodule
