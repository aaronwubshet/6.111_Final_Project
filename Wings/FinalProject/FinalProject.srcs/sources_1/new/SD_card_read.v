`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/10/2017 03:35:23 PM
// Design Name: 
// Module Name: SD_card_read
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

//Vivado Constraints
// input SD_CD
// output SD_RESET
// output SD_SCK
// output SD_CMD
// inout SD_DAT[3:0]

module SD_card_read(
    input reset,    //resets controller on assertion
    input clk,      //25Mhz clock
    output reg cs,      //connect to SD_DAT[3]
    output mosi,    //connect to SD_CMD
    input misi,     //connect to SD_DAT[0]   
    output sclk,    //connect to SD_SCK
                    //for SPI mode, SD_DAT[2] and SD_DAT[1] should be held HIGH
                    //SD_RESET should be held LOW
    output ready,   //HIGH if SD card is ready for a read or write operation
    input [31:0] address,   //Memory address for read/write operation
                            //MUST be a multiple of 512 byytes, due to SD sectoring
    input rd,       //read-enable
                    //when [ready] is HIGH, asserting [rd] will begin 512-byte READ operation at [address]
                    //[byte_available] will transition HIGH as a new byte has been read from the SD card
                    //byte is presented on [dout]
    input [7:0] dout,   //data output for READ operation
    output byte_available,  //a new byte has been presented on [dout]
    input wr,       //write-enable
                    //when [ready] is HIGH, asserting [wr] will begin a 512-byte WRITE operation at [address]
                    //[ready_for_next_byte] will transition HIGH to request that the next byte to be written should be presented on [din]
    input [7:0] din,    //data input for WRITE operation
    output ready_for_next_byte  //a new byte should be presented on [din]
    );
endmodule
