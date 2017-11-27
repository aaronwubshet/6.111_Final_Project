`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/16/2017 12:43:14 PM
// Design Name: 
// Module Name: edge_to_display
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


module edge_to_display(
    input wire [2:0] bin_data,
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
//    assign video_out = 12'hF0F; //blank_delay_2 ? 12'b0 : (bin_data != 3'b000) ? 12'hFFF : 12'b0; 
//    assign video_out = at_display_area ? 12'hF0f: 0;
//    assign video_out = at_display_area ? ((bin_data != 3'b000) ? 12'h000 : 12'hFFF): 0;//(12'h0F0) : 0;
    assign video_out = ~at_display_area ? 0: bin_data == 3'b001 ? 12'hF00 : bin_data == 3'b010 ? 12'h0F0 : 
                        bin_data == 3'b011 ? 12'h00F : bin_data == 3'b100 ? 12'hF0F : 12'hFFF; 
    
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
    end
endmodule
