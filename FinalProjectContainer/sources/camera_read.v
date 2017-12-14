`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:12:24 12/03/2014 
// Design Name: 
// Module Name:    camera_read 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module camera_read(
	input wire p_clock,
	input wire vsync,
	input wire href,
	input wire [7:0] p_data,
	output reg [15:0] pixel_data =0,
	output reg pixel_valid = 0,
	output reg frame_done = 0

//	inout wire [1:0] SD_DAT,
//	output wire SD_CMD, SD_SCK
    );
    
    
//        //SD card memory
//        SD_card_mem SD_card_mem_2 (
//            .cs(SD_DAT[3]),// Connect to SD_DAT[3].
//            .mosi(SD_CMD), // Connect to SD_CMD.
//            .miso(SD_DAT[0]),// Connect to SD_DAT[0].
//            .sclk(SD_SCK), // Connect to SD_SCK.
////                                     For SPI mode, SD_DAT[2] and SD_DAT[1] should be held HIGH. 
////                                     SD_RESET should be held LOW.
//            .rd(), // Read-enable. When [ready] is HIGH, asseting [rd] will 
//                                    // begin a 512-byte READ operation at [address]. 
//                                    // [byte_available] will transition HIGH as a new byte has been
//                                    // read from the SD card. The byte is presented on [dout].
//            .dout(), // Data output for READ operation.
//            .byte_available(), // A new byte has been presented on [dout].
//            .wr(1'b1), // Write-enable. When [ready] is HIGH, asserting [wr] will
//                                    // begin a 512-byte WRITE operation at [address].
//                                    // [ready_for_next_byte] will transition HIGH to request that
//                                    // the next byte to be written should be presentaed on [din].
//            .din(p_data), // Data input for WRITE operation.
//            .ready_for_next_byte(), // A new byte should be presented on [din].
//            .reset(1'b0),// Resets controller on assertion.
//            .ready(), // HIGH if the SD card is ready for a read or write operation.
//            .address(addr), // Memory address for read/write operation. This MUST 
//                                                // be a multiple of 512 bytes, due to SD sectoring.
//            .clk(p_clock), // 25 MHz clock.
//            .status() // For debug purposes: Current state of controller.
            
//        );
	reg [31:0] addr = 0;   //
	
	
	
	reg [1:0] FSM_state = 0;
    reg pixel_half = 0;
	
	localparam WAIT_FRAME_START = 0;
	localparam ROW_CAPTURE = 1;
	
	
	
	always@(posedge p_clock) begin 
	
        case(FSM_state)
        
            WAIT_FRAME_START: begin //wait for VSYNC
               FSM_state <= (!vsync) ? ROW_CAPTURE : WAIT_FRAME_START;
               frame_done <= 0;
               pixel_half <= 0;
               
               addr <= 0; //
            end
            
            ROW_CAPTURE: begin 
               FSM_state <= vsync ? WAIT_FRAME_START : ROW_CAPTURE;
               frame_done <= vsync ? 1 : 0;
               pixel_valid <= (href && pixel_half) ? 1 : 0; 
               if (href) begin
                   pixel_half <= ~ pixel_half;
                   if (pixel_half) pixel_data[7:0] <= p_data;
                   else pixel_data[15:8] <= p_data;
               end
               
               addr <= addr + 1; //
            end
        
        
        endcase
	end
	
endmodule