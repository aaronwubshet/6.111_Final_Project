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

    //buttons
    input BTNC, BTNU, BTNL, BTNR, BTND,

    //SD card stuff
    input SD_CD,
    output SD_RESET,
    output SD_SCK,
    output SD_CMD,
    inout [3:0] SD_DAT,

    //JA and JB PMOD Headers for Camera input
    inout [7:0] JA,
    inout [7:0] JB,

    // video
    output [3:0] VGA_R,
    output [3:0] VGA_G,
    output [3:0] VGA_B,
    output VGA_HS,
    output VGA_VS,

    //LEDs
    output LED16_B, LED16_G, LED16_R,
    output LED17_B, LED17_G, LED17_R,


    output[15:0] LED,
    output wire [7:0] SEG,  // segments A-G (0-6), DP (7)
    output wire [7:0] AN,  // Display 0-7

    // audio
    output AUD_PWM,
    output AUD_SD // PWM audio enable
    );

    //instantiate clock signals
   
    wire reset = 0;
    wire locked = 1;
    clk_manager clocker(.clk_in1(CLK100MHZ),      // input clk_in1
        .clk_out1(clk_100mhz),     // output clk_out1
        .clk_out2(clk_25mhz),     // output clk_out2
        .reset(reset), // input reset
        .locked(locked));      // output locked
    
    // debounce buttons
    wire btn_up, btn_down, btn_center, btn_left, btn_right;
    debounce up(.reset(master_reset), .clock(clk_25mhz), .noisy(BTNU), .clean(btn_up));
    debounce down(.reset(master_reset), .clock(clk_25mhz), .noisy(BTND), .clean(btn_down));
    debounce center(.reset(master_reset), .clock(clk_25mhz), .noisy(BTNC), .clean(btn_center));
    debounce left(.reset(master_reset), .clock(clk_25mhz), .noisy(BTNL), .clean(btn_left));
    debounce right(.reset(master_reset), .clock(clk_25mhz), .noisy(BTNR), .clean(btn_right));
    
    //  instantiate 7-segment display;
    wire [31:0] data;
    wire [6:0] segments;
    display_8hex display(.clk(clk_25mhz),.data(data), .seg(segments), .strobe(AN));
    assign SEG[6:0] = segments;
    assign SEG[7] = 1'b1;
    
    //set up monitor
    wire [9:0] hcount;
    wire [9:0] vcount;
    wire hsync, vsync, at_display_area;
    vga vga1(.vga_clock(clk_25mhz),.hcount(hcount),.vcount(vcount),
            .hsync(hsync),.vsync(vsync),.at_display_area(at_display_area));
    assign VGA_HS = ~hsync;
    assign VGA_VS = ~vsync;
    
    //SETTING UP THE SD CARD    
    wire [7:0] sd_read;
    wire [7:0] sd_write;
    wire sd_read_available;
    wire sd_write_available;
    wire sd_write_ready = 0;
    wire sd_reset = 0;
    wire sd_ready;
    wire [31:0] sd_addr;
    wire [4:0] sd_status;
    
    // set SPI mode
    assign SD_DAT[2] = 1;
    assign SD_DAT[1] = 1;
    assign SD_RESET = 0;     
       
    sd_controller sd_read_write (
        .cs (SD_DAT[3]), 
        .mosi (SD_CMD), 
        .miso (SD_DAT[0]), 
        .sclk (SD_SCK),        
        .rd (1), //input rd. The byte is presented on [dout].
        .dout (sd_read), // output reg [7:0] dout for READ operation.
        .byte_available (sd_read_available), // A new byte has been presented on [dout].
        .wr(0), //input wr. The next byte to be written should be presentaed on [din].
        .din(sd_write), // Data input for WRITE operation.
        .ready_for_next_byte (sd_write_available), // A new byte should be presented on [din].       
        .reset(sd_reset), // input Resets controller on assertion.
        .ready (sd_ready), //output HIGH if the SD card is ready for a read or write operation.
        .address(sd_addr), //input [31:0] addres
        .clk(clk_25mhz), // 25 MHz clock.
        .status(sd_status) //output [4:0] status: Current state of controller.
    );
      
          
          
    //JW Color Stuff
    wire write_a;
    wire write_b;
    wire addr_a;
    wire addr_b;
    wire din_a;
    wire dout_a;
    wire din_b;
    wire dout_b;
    JW_BRAM_COLOR color_BRAM (
      .clka(clk_25mhz),    // input wire clka
      .wea(write_a),      // input wire [0 : 0] wea
      .addra(addr_a),  // input wire [18 : 0] addra
      .dina(din_a),    // input wire [2 : 0] dina
      .douta(dout_a),  // output wire [2 : 0] douta
      .clkb(clk_25mhz),    // input wire clkb
      .web(write_b),      // input wire [0 : 0] web
      .addrb(addr_b),  // input wire [18 : 0] addrb
      .dinb(din_b),    // input wire [2 : 0] dinb
      .doutb(dout_b)  // output wire [2 : 0] doutb
    );

    //WINGS STUFF GOES HERE
    wire sd_done;
    wire bram_done;
    image_processing image_setup(.SD_DAT(SD_DAT), .SD_CMD(SD_CMD), .SD_SCK(SD_SCK), .SD_RESET(SD_RESET),
        .SD_CD(SD_CD), .clk_100mhz(CLK100MHZ), .SW(SW), .BTNC(btn_center), .BTNU(btn_up), .BTNL(btn_left),
        .BTNR(btn_right), .BTND(btn_down), .VGA_R(VGA_R), .VGA_B(VGA_B), .VGA_G(VGA_G), .VGA_HS(VGA_HS),
        .VGA_VS(VGA_VS), .LED16_B(LED16_B), .LED16_G(LED16_G), .LED16_R(LED16_R), .LED17_B(LED17_B), 
        .LED17_G(LED17_G), .LED17_R(LED17_R),.LED(LED), .SEG(SEG), .AN(AN), .SD_DONE(sd_done), .BRAM_DONE(bram_done),
        .clk_25mhz(clk_25mhz), .bram_addr(addr_a), .xy_edge_out(dout_a), .xy_bin_in(din_a), .xy_bin_we(write_a), 
        .sd_read_available(sd_read_available), .sd_addr(sd_addr));
    
  /*  
    //AARON STUFF GOES HERE
    wire [2:0] bin_count;
    wire [59:0] bin_addr;
    audio_processing filters_and_fft(.clock(clk_100mhz), .clk_25mhz(clk_25mhz), .ready(DONE_SIGNAL_FROM_WINGS),
        .reset(reset), .AUD_PWM(AUD_PWM), .AUD_SD(AUD_SD), .SW(SW[15:0]),.bin_count(bin_count), .audio_data(sd_dout),
        .bin_add(bin_addr), .done(done));
    
    wire out_write_enable_a;
    wire out_addra;
    wire out_dina;
    wire out_douta;
    wire out_enable_b;
    wire out_write_enable_b;
    wire out_addrb;
    wire out_dinb;
    wire out_doutb;
    bram_fft_output_buffer fft_output_bram (
      .clka(clock_100mhz),    // input wire clka
      .wea(out_write_enable_a),      // input wire [0 : 0] wea
      .addra(out_addra),  // input wire [9 : 0] addra
      .dina(out_dina),    // input wire [7 : 0] dina
      .douta(out_douta),  // output wire [7 : 0] douta
      .clkb(clock_100mhz),    // input wire clkb
      .web(out_write_enable_b),      // input wire [0 : 0] web
      .addrb(out_addrb),  // input wire [9 : 0] addrb
      .dinb(out_dinb),    // input wire [7 : 0] dinb
      .doutb(out_doutb)  // output wire [7 : 0] doutb
    );
    

    */
    //JULIAN'S STUFF GOES HERE
    
    
    wire FFT_color = 84'd0;
    wire no_color = 1'b1;
    wire [11:0] rgb;
    Color_output test_JW(.clock(clk_25mhz),.no_color(no_color),.hcount(hcount),.vcount(vcount),
                          .data(din_b),.FFT_color(FFT_color), .address(addr_b),.rgb(rgb));
                         
    assign VGA_R = at_display_area ? rgb[11:8]: 0;
    assign VGA_G = at_display_area ? rgb[7:4]: 0;
    assign VGA_B = at_display_area ? rgb[3:0]: 0;



endmodule
