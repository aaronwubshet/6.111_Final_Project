`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/05/2017 01:41:12 PM
// Design Name: 
// Module Name: Color_transform
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


module Color_transform(
       input CLK100MHZ,
	input clock_25mhz,
       input[15:0] SW, 
       input BTNC, BTNU, BTNL, BTNR, BTND,
       output[3:0] VGA_R, 
       output[3:0] VGA_B, 
       output[3:0] VGA_G, 
       output VGA_HS, 
       output VGA_VS, 
       output [9:0] addr2_b,
       input [15:0] dout2_b,
       
       output [18:0] addr_b,
       input [2:0] dout_b,
       
       input wings_done,
       input wubs_done,
       
       input [50:0] addresses,
       input [2:0] bin_num,
       
       output FFT_done,
       output [31:0] data_disp,
       output adjusting
       );
       
    
    
    wire up_puls;   
    lev_to_pulse pulse_up(.clock(CLK100MHZ),.reset(SW[15]),.lev(up),.pulse(up_puls));
    
    wire down_puls;
    lev_to_pulse pulse_down(.clock(CLK100MHZ),.reset(SW[15]),.lev(down),.pulse(down_puls));
   

    wire [83:0] color_test;  
    
    wire [3:0] off1;
    wire [3:0] off2;
    wire [3:0] off3;
    wire [3:0] off4;
    wire [3:0] off5; 
    wire [3:0] off6;
    wire [3:0] off7;
    wire [3:0] off8;
    
    wire [3:0] c_map_test;
    
    
    Color_offst test_off(.clock(CLK100MHZ),.reset(SW[14]),.SW(SW),.up(up_puls),.down(down_puls),.adjusting(adjusting), .off1(off1), .off2(off2), 
                         .off3(off3), .off4(off4), .off5(off5), .off6(off6), .off7(off7));
    
    //add a pause signal somewhere to change the offset??? 
    FFT_energy test_FFT(.clock(CLK100MHZ),.ready(wubs_done),.bin_num(bin_num),.addresses(addresses),.data(dout2_b),.bram_addr(addr2_b),
                         .off1(off1), .off2(off2), .off3(off3), .off4(off4), .off5(off5), .off6(off6), .off7(off7),
                         .color(color_test),.test_out(data_disp[31:8]),.done(FFT_done),.adjusting(adjusting),.reset(SW[15]),.c_map_test(c_map_test));
    
    
    //wire [83:0] color = 84'h00F_00C_00A_008_006_004_003;
    wire [11:0] rgb;
    wire hsync, vsync;
    
    Color_output test_color(.bin_data(dout_b),.ready(wings_done),.FFT_COLOR(color_test),.video_clk(clock_25mhz),.memory_addr(addr_b),.vsync(vsync), .hsync(hsync),
                            .video_out(rgb));
                            
                         
   assign data_disp[7:0] = {c_map_test, 3'b000,adjusting};   // display 0123456 + SW                      
   
                            
    //////////////////////////////////////////////////////////////////////////////////
    // sample Verilog to generate color bars
    //    vga vga1(.vga_clock(clock_25mhz),.hcount(hcount),.vcount(vcount),
    //          .hsync(hsync),.vsync(vsync),.at_display_area(at_display_area));
            
        assign VGA_R = rgb[11:8];
        assign VGA_G = rgb[7:4];
        assign VGA_B = rgb[3:0];
        
    //    assign VGA_R =  10;
    //    assign VGA_G =  8;
    //    assign VGA_B =  1;
        assign VGA_HS = hsync;
        assign VGA_VS = vsync;


endmodule
