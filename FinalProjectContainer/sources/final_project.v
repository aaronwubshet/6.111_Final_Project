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
    output [7:0] JA,
    output [7:0] JB,

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
        //.wea(memory_write_enable),
        .wea(0),
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
    
    
    
    
    image_processing box(
        .clk_25mhz(clk_25mhz),
        .CLK_100M(clk_100mhz),    
        .SW(6'b0),
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
   
    wire [31:0] julian_debug;
    wire [9:0] julian_test;
    //wire adjusting;
    
    
    /*julian debug statement*/
    wire [9:0] addrb;
    wire [15:0] doutb;
    wire [59:0] bin_addr;
    wire [2:0] bin;
    Color_transform julian_color(.CLK100MHZ(clk_100mhz), .reset(master_reset), .clock_25mhz(clk_25mhz), .SW(SW[15:0]), 
        .BTNC(btn_center), .BTNU(btn_up), .BTNL(btn_left), .BTNR(btn_right), .BTND(btn_down),
        .VGA_R(VGA_R), .VGA_B(VGA_B), .VGA_G(VGA_G), .VGA_HS(VGA_HS), .VGA_VS(VGA_VS), .addr2_b(addrb),
        .dout2_b(doutb), .addr_b(vga_bram_addr), .dout_b(edge_bram_doutb), .wings_done(image_done),
        .wubs_done(aaron_done), .addresses(bin_addr), .bin_num(bin), .FFT_done(julian_done), 
        .data_disp(julian_debug), .julian_test(julian_test), .start(start));
           
    //FFT amplitude output buffer read and write signals
    wire fft_bram_out_write_enablea;
    wire [9:0] fft_bram_out_addra;
    wire [15:0] fft_bram_out_dina;
    wire [15:0] fft_bram_out_douta;
    
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
        
    
    wire [2:0] state;
    wire filter_flag;
    wire filter_done;
    wire flag;
    wire last_flag;
    wire filter_ready;     
    wire test;
    audio_processing audio_stuff(.clock(clk_100mhz), .clk_25mhz(clk_25mhz), .reset(master_reset), .wings_done(image_done), 
        .julian_done(julian_done), .sd_data(sd_read),.sd_ready(sd_ready), .sd_read_available(sd_read_available), 
        .AUD_PWM(AUD_PWM),.sd_addr(sd_addr), .AUD_SD(AUD_SD), .sd_rd(sd_rd), .filter_control(SW[8:7]), 
        .fft_bram_out_write_enablea(fft_bram_out_write_enablea), .fft_bram_out_addra(fft_bram_out_addra),
        .fft_bram_out_dina(fft_bram_out_dina), .done(aaron_done),.bin(bin),.bin_addr(bin_addr),
        .state(state), .filter_flag(filter_flag), .filter_done(filter_done), .flag(flag), .last_flag(last_flag), .filter_ready(filter_ready), .test(test));
    assign LED[0]= image_done;
    assign LED[1] = julian_done;
    assign LED[2] = test;
    //assign LED[3] = julian_test;
    //assign data = {16'b0, fft_bram_out_dina};
    
    assign data[15:0] = julian_debug[15:0];
    assign data[31:16] = {6'b0, julian_test };
    //assign data = {julian_debug[0],3'b0, 2'b0, addrb, doutb};
 

endmodule
