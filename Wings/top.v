`timescale 1ns / 1ps
`default_nettype none 

module top(
    input wire CLK_100M,
	input wire [15:0] SW,
	output wire [15:0] LED,
	output wire RGB1_Blue, RGB1_Green, RGB1_Red,
	output wire RGB2_Blue, RGB2_Green, RGB2_Red,
//	output wire [7:0] SSEG_CA, [7:0] SSEG_AN, //7 segment LED display
	input wire CPU_RESETN, BTNC, BTNU, BTNL, BTNR, BTND, //buttons
	inout wire [7:0] JA, JB, JC, JD, //PMOD headers
	//input wire [3:0] XA_N, XA_P, //analog inputs
	output wire [3:0] VGA_R, VGA_G, VGA_B, //VGA outputs
	output wire VGA_HS, VGA_VS,
	
	inout wire [1:0] SD_DAT,
	input wire SD_CMD, SD_SCK, SD_CD, SD_RESET
	
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

            
    wire [3:0] green;
    wire [3:0] blue;
    wire [3:0] red;
/*    
    video_playback video_playback_1 (
        .pixel_data(memory_read_data),
        .video_clk(clk_25mhz),
        .memory_addr(memory_read_addr),
        .vsync(VGA_VS),
        .hsync(VGA_HS),
//        .video_out({VGA_R, VGA_G, VGA_B})
        .video_out({red, green, blue})   
        );*/
            
    wire [18:0] vga_bram_addr;
    video_playback video_playback_1 (
        .pixel_data(edge_bram_dout),
        .rgb_data(memory_read_data),
        .video_clk(clk_25mhz),
        .memory_addr(vga_bram_addr),
        .vsync(VGA_VS),
        .hsync(VGA_HS),
        .video_out({VGA_R, VGA_G, VGA_B})
//        .video_out({red, green, blue})   
        );
                
                
     
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
    
    wire sobel_done;
    wire [18:0] sobel_edge_bram_addr;
    wire [18:0] sobel_rgb_bram_addr;
    //sobel edge detection    
    sobel edge_detection(
        .clk(CLK_100M),
        .start(1),
        .done(sobel_done),
        
        .pixel_data(memory_read_data),
        .pic_memory_addr(sobel_rgb_bram_addr),
        
        .is_edge(edge_bram_din),
        .edge_memory_addr(sobel_edge_bram_addr)
    );
    
    
        
    wire [2:0] edge_bram_din;
    wire [2:0] edge_bram_dout;
    wire [18:0] edge_bram_addr;
    wire edge_bram_we;
    
    assign edge_bram_we = ~sobel_done ? 1: 0;
    assign edge_bram_addr = ~sobel_done ? sobel_edge_bram_addr : vga_bram_addr;
    assign memory_read_addr = ~sobel_done ?  sobel_rgb_bram_addr : vga_bram_addr;
    
        
    edge_bram your_instance_name (
        .clka(clk_25mhz),    // input wire clka
        .ena(1),      // input wire ena
        .wea(edge_bram_we),      // input wire [0 : 0] wea
        .addra(edge_bram_addr),  // input wire [18 : 0] addra
        .dina(edge_bram_din),    // input wire [2 : 0] dina
        .douta(edge_bram_dout)  // output wire [2 : 0] douta
    );


        
endmodule

module video_playback(
//    input wire [11:0] pixel_data,
    input wire [2:0] pixel_data,
    input wire [12:0] rgb_data,
    input wire video_clk,
    output wire [18:0] memory_addr,
    output reg vsync,
    output reg hsync,
    output wire [11:0] video_out
    );
    
    
    // horizontal: 800 pixels total
    // display 640 pixels per line
    reg hblank,vblank;
    wire hsyncon,hsyncoff,hreset,hblankon;
    reg [11:0] hcount = 0;
    reg [11:0] vcount = 0;
    reg blank; 
    //kludges to fix frame alignment due to memory access time
    reg blank_delay;
    reg blank_delay_2;
    reg hsync_pre_delay;
    reg hsync_pre_delay_2;
    reg vsync_pre_delay;
    reg vsync_pre_delay_2;

    reg at_display_area;
    reg [3:0] bw_value;
    reg [11:0] bw_total;
    
//    assign video_out = blank_delay_2 ? 12'b0 : pixel_data; 
    assign video_out = at_display_area ? ((pixel_data != 3'bF00) ? 12'h000 : bw_total): 0;//(12'h0F0) : 0; 
    
    assign hblankon = (hcount == 639);   //blank after display width   
    assign hsyncon = (hcount == 655);  // active video + front porch
    assign hsyncoff = (hcount == 751); //active video + front portch + sync
    assign hreset = (hcount == 799); //plus back porch
    
    // vertical:  525 lines total
    // display 480 lines
    wire vsyncon,vsyncoff,vreset,vblankon;
    assign vblankon = hreset & (vcount == 479);    
    assign vsyncon = hreset & (vcount == 489);
    assign vsyncoff = hreset & (vcount == 491);
    assign vreset = (hreset & (vcount == 524));
    
    // sync and blanking
    wire next_hblank,next_vblank;
    assign next_hblank = hreset ? 0 : hblankon ? 1 : hblank;
    assign next_vblank = vreset ? 0 : vblankon ? 1 : vblank;

    assign memory_addr = hcount+vcount*640;
      
    always @(posedge video_clk) begin
    
           
        blank_delay <= blank;
        blank_delay_2 <= blank_delay;
        hsync_pre_delay_2 <= hsync_pre_delay;
        vsync_pre_delay_2 <= vsync_pre_delay;
        vsync <= vsync_pre_delay_2;
        hsync <= hsync_pre_delay_2;
         //hcount 
         hcount <= hreset ? 0 : hcount + 1;
         hblank <= next_hblank;
         hsync_pre_delay <= hsyncon ? 0 : hsyncoff ? 1 : hsync_pre_delay;  // active low
        
         vcount <= hreset ? (vreset ? 0 : vcount + 1) : vcount;
         vblank <= next_vblank;
         vsync_pre_delay <= vsyncon ? 0 : vsyncoff ? 1 : vsync_pre_delay;  // active low
        
         blank <= next_vblank | (next_hblank & ~hreset);
         
        at_display_area <= ((hcount >= 0) && (hcount < 640) && (vcount >= 0) && (vcount < 480));
        
        bw_value <= (rgb_data[11:8] >> 2) + (rgb_data[7:4] >> 1) + (rgb_data[7:4] >> 3) + (rgb_data[3:0] >> 3);
        bw_total <= {bw_value, bw_value, bw_value};
        

    end
endmodule