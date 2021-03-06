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
    output SD_SCK,
    output SD_CMD,
    inout [3:0] SD_DAT,
    output SD_RESET,
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
    output [7:0] SEG,  // segments A-G (0-6), DP (7)
    output [7:0] AN,  // Display 0-7

    // audio
    output AUD_PWM,
    output AUD_SD // PWM audio enable
    );

    //master reset
    wire master_reset = SW[15];
    
   //CLOCK SETUP
    wire clk_100mhz;
    wire clk_25mhz;
    wire locked = 1;
    clk_manager clocker (
       .clk_in1(CLK100MHZ),    // input clk_in1
       .clk_out1(clk_25mhz),  
       .clk_out2(clk_100mhz), 
       .reset(SW[15]), // input reset
       .locked(locked) // output locked
    );
               
    // debounce buttons
    wire btn_up, btn_down, btn_center, btn_left, btn_right;
    debounce up(.reset(master_reset), .clock(clk_25mhz), .noisy(BTNU), .clean(btn_up));
    debounce down(.reset(master_reset), .clock(clk_25mhz), .noisy(BTND), .clean(btn_down));
    debounce center(.reset(master_reset), .clock(clk_25mhz), .noisy(BTNC), .clean(btn_center));
    debounce left(.reset(master_reset), .clock(clk_25mhz), .noisy(BTNL), .clean(btn_left));
    debounce right(.reset(master_reset), .clock(clk_25mhz), .noisy(BTNR), .clean(btn_right));
    assign LED[13] = btn_center;
       
        
    //8-HEX SETUP FOR TESTING               
    wire [31:0] data;
    wire [6:0] segments;
    display_8hex display(.clk(clk_25mhz),.data(data), .seg(segments), .strobe(AN));    
    assign SEG[6:0] = segments;
    assign SEG[7] = 1'b1;
        
        
        
    //SETTING UP THE SD CARD    
    wire [7:0] sd_read;
    wire [7:0] sd_write;
    //wire sd_we;  //0 = read, 1 = write
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
    wire sd_rd;
    sd_controller sd_read_write (
        .cs (SD_DAT[3]), 
        .mosi (SD_CMD), 
        .miso (SD_DAT[0]), 
        .sclk (SD_SCK),        
        .rd (sd_rd), //input rd. The byte is presented on [dout].
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
          
          
    wire [11:0] memory_read_data;
    wire [11:0] memory_write_data;
    wire [18:0] memory_read_addr;
    wire [18:0] memory_write_addr;
    wire memory_write_enable; 
        
    //frame buffer memory   
    frame_buffer frame_buffer_1 (
        .clka(clk_25mhz),
        .wea(memory_write_enable),
//        .wea(0),
        .addra(memory_write_addr),
        .dina(memory_write_data),
        .clkb(clk_25mhz),
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
    
    wire [18:0] image_edge_bram_addr;
    wire [18:0] image_edge_bram_addrb;
    wire [2:0] image_edge_bram_din;
    wire image_done;
    
    wire [18:0] image_memory_read_addr;
    wire [18:0] vga_bram_addr;

    
    assign edge_bram_addr = image_edge_bram_addr;
    assign edge_bram_din = image_edge_bram_din;
    assign memory_read_addr = ~image_done ? image_memory_read_addr : vga_bram_addr;
    assign edge_bram_addrb = ~image_done ? image_edge_bram_addrb : vga_bram_addr;
        
    //a = write, b = read
    xy_bin xy_edge (
        .clka(clk_25mhz),    // input wire clka
        .wea(1),      // input wire [0 : 0] wea
        .addra(edge_bram_addr),  // input wire [18 : 0] addra
        .dina(edge_bram_din),    // input wire [2 : 0] dina
        .douta(edge_bram_dout),  // output wire [2 : 0] douta
        .clkb(clk_25mhz),
        .web(0),
        .addrb(edge_bram_addrb),
        .dinb(edge_bram_dinb),
        .doutb(edge_bram_doutb)
    );
    
    
    
    wire [3:0] VGA_R_w;
    wire [3:0] VGA_B_w;
    wire [3:0] VGA_G_w;
    wire VGA_VS_w;
    wire VGA_HS_w;
    
    image_processing box(
        .clk_25mhz(clk_25mhz),
        .CLK_100M(clk_100mhz),    
        .SW(6'b0),
        .num_bins(3'b110),
        .done(LED[15]),
        .sobel_start(SW[9]),
        .edge_start(SW[10]),
        .color_start(SW[11]),
        
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
        
        .VGA_R(VGA_R_w), .VGA_B(VGA_B_w), .VGA_G(VGA_G_w), .VGA_HS(VGA_HS_w), .VGA_VS(VGA_VS_w),
        
        .JA(JA), .JB(JB), .BTNC(btn_center), .BTNR(btn_right), .BTNL(btn_left)
    );
   
    wire [31:0] julian_debug;
    wire adjusting;
    wire [3:0] VGA_R_j;
    wire [3:0] VGA_B_j;
    wire [3:0] VGA_G_j;
    wire VGA_VS_j;
    wire VGA_HS_j;
    assign VGA_R = SW[12] ? VGA_R_j : VGA_R_w;
    assign VGA_G = SW[12] ? VGA_G_j : VGA_G_w;
    assign VGA_B = SW[12] ? VGA_B_j : VGA_B_w;
    assign VGA_VS = SW[12] ? VGA_VS_j : VGA_VS_w;
    assign VGA_HS = SW[12] ? VGA_HS_j : VGA_HS_w;
    assign image_done = SW[12];
    
    Color_transform julian_color(.CLK100MHZ(clk_100mhz), .reset(master_reset), .clock_25mhz(clk_25mhz), .SW(SW[15:0]), 
        .BTNC(btn_center), .BTNU(btn_up), .BTNL(btn_left), .BTNR(btn_right), .BTND(btn_down),
        .VGA_R(VGA_R_j), .VGA_B(VGA_B_j), .VGA_G(VGA_G_j), .VGA_HS(VGA_HS_j), .VGA_VS(VGA_VS_j), .addr2_b(addrb),
        .dout2_b(doutb), .addr_b(vga_bram_addr), .dout_b(edge_bram_doutb), .wings_done(image_done),
        .wubs_done(aaron_done), .addresses(bin_addr), .bin_num(bin), .FFT_done(julian_done), 
        .data_disp(julian_debug), .adjusting(adjusting));
           
    //FFT amplitude output buffer read and write signals
    wire fft_bram_out_write_enablea;
    wire [9:0] fft_bram_out_addra;
    wire [15:0] fft_bram_out_dina;
    wire [15:0] fft_bram_out_douta;
    
    wire [9:0] fft_bram_out_addrb;
    wire [15:0] fft_bram_out_dinb;
    wire [15:0] fft_bram_out_doutb;
    
    bram_fft_output_buffer fft_amplitude_buffer (
        .clka(clk_100mhz),    // input wire clka
        .wea(fft_bram_out_write_enablea),      // input wire [0 : 0] wea
        .addra(fft_bram_out_addra),  // input wire [9 : 0] addra
        .dina(fft_bram_out_dina),    // input wire [15 : 0] dina
        .douta(fft_bram_out_douta),  // output wire [15 : 0] douta
        .clkb(clk_100mhz),    // input wire clkb
        .web(0),      // input wire [0 : 0] web
        .addrb(addrb),  // input wire [9 : 0] addrb
        .dinb(dinb),    // input wire [15 : 0] dinb
        .doutb(doutb)  // output wire [15 : 0] doutb
    );
        
    
    
    audio_processing audio_stuff(.clock(clk_100mhz), .clk_25mhz(clk_25mhz), .reset(master_reset), .wings_done(image_done), 
        .julian_done(julian_done), .sd_data(sd_read),.sd_ready(sd_ready), .sd_read_available(sd_read_available), 
        .AUD_PWM(AUD_PWM),.sd_addr(sd_addr), .AUD_SD(AUD_SD), .sd_rd(sd_rd), .filter_control(SW[8:7]), 
        .fft_bram_out_write_enablea(fft_bram_out_write_enablea), .fft_bram_out_addra(fft_bram_out_addra),
        .fft_bram_out_dina(fft_bram_out_dina), .done(aaron_done),.bin(bin),.bin_addr(bin_addr));
    assign LED[0] = image_done;
    assign LED[1] = julian_done;
    assign LED[2] = aaron_done;
    
    /*
    
    ila_0 testing (
        .clk(clk_25mhz), // input wire clk
    
    
        .probe0(image_edge_bram_addrb), // input wire [18:0]  probe0  
        .probe1(vga_bram_addr), // input wire [18:0]  probe1 
        .probe2(edge_bram_dout), // input wire [2:0]  probe2 
        .probe3(edge_bram_din), // input wire [2:0]  probe3 
        .probe4(hcount), // input wire [11:0]  probe4 
        .probe5(vcount), // input wire [11:0]  probe5 
        .probe6({aaron_done, julian_done, image_done}), // input wire [2:0]  probe6 
        .probe7(image_done) // input wire [0:0]  probe7
    );
*/
endmodule
