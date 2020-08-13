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
wire clk_104mhz;
wire clk_25mhz;
clk_wiz_0 clock_gen(.clk_in1(CLK100MHZ),.clk_out1(clk_100mhz), .clk_out2(clk_25mhz), .reset(reeset), .locked(locked));

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
display_8hex display(.clk(clock_25mhz),.data(data), .seg(segments), .strobe(AN));
assign SEG[6:0] = segments;
assign SEG[7] = 1'b1;

// general SD signals
reg sd_rd; // when ready is high, asserting rd will begin a read
wire sd_wr = 0;
wire sd_ready;
wire [4:0] sd_state; // for debug purposes

// set SPI mode
assign SD_DAT[2] = 1;
assign SD_DAT[1] = 1;
assign SD_RESET = 0;

// read SD signals
reg [31:0] sd_adr; // address of read operation
wire [7:0] sd_dout; // data output for read operation
wire sd_byte_available; // signal that a new byte has been presented on dout

// write SD signals
wire [7:0] sd_din = 0;
wire sd_ready_for_next_byte = 0;


sd_controller sd_controller_module(.cs(SD_DAT[3]), .mosi(SD_CMD), .miso(SD_DAT[0]),
      .sclk(SD_SCK), .rd(sd_rd), .wr(sd_wr), .reset(master_reset),
      .din(sd_din), .dout(sd_dout), .byte_available(sd_byte_available),
      .ready(sd_ready), .address(sd_adr), .clk(clk_25mhz),
      .ready_for_next_byte(sd_ready_for_next_byte), .status(sd_state));
//WINGS STUFF GOES HERE







//AARON STUFF GOES HERE
wire [2:0] bin_count;
wire [59:0] bin_addr;
audio_processing filters_and_fft(.clock(clk_100mhz), .clk_25mhz(clk_25mhz), .ready(DONE_SIGNAL_FROM_WINGS),
    .reset(reset), .AUD_PWM(AUD_PWM), .AUD_SD(AUD_SD), .SW(SW[15:0]),.bin_count(bin_count), .audio_data(sd_dout),
    .bin_add(bin_addr), .done(done));





//JULIAN'S STUFF GOES HERE

//image processing stuff
wire [9:0] hcount;
wire [9:0] vcount;
wire hsync, vsync, at_display_area;
vga vga1(.vga_clock(clock_25mhz),.hcount(hcount),.vcount(vcount),
        .hsync(hsync),.vsync(vsync),.at_display_area(at_display_area));
assign VGA_HS = ~hsync;
assign VGA_VS = ~vsync;



endmodule
