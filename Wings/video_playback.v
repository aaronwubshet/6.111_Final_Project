`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/05/2017 03:36:00 PM
// Design Name: 
// Module Name: video_playback
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
    
    assign video_out = ~at_display_area ? 0: 
                        pixel_data == 3'b001 ? 12'hF00 : 
                        pixel_data == 3'b010 ? 12'h0F0 : 
                        pixel_data == 3'b011 ? 12'h00F : 
                        pixel_data == 3'b100 ? 12'hF0F : 
                        pixel_data == 3'b101 ? 12'h0FF :
                        pixel_data == 3'b110 ? 12'h4F4 :
                        pixel_data == 3'b111 ? 12'hFF0 : rgb_data; 
    
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
