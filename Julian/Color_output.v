`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 11/14/2017 04:06:15 PM
// Design Name:
// Module Name: Color_output
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


module Color_output(
    input wire [2:0] bin_data,
    input wire ready,
    input wire [83:0] FFT_COLOR,
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

    /*assign pixel out value based on BRAM data*/

    assign video_out = ~at_display_area ? 0:
			bin_data == 3'b001 ? FFT_COLOR[11:0] :
			bin_data == 3'b010 ? FFT_COLOR[23:12] :
            bin_data == 3'b011 ? FFT_COLOR[35:24] :
			bin_data == 3'b100 ? FFT_COLOR[47:36]:
			bin_data == 3'b101 ? FFT_COLOR[59:48]:
			bin_data == 3'b110 ? FFT_COLOR[71:60]:
			bin_data == 3'b111 ? FFT_COLOR[83:72]: 0;

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

    assign memory_addr = ready ? hcount+vcount*640 : 0;			//don’t output address until can start reading from BRAM

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