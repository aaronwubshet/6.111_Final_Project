`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/15/2017 07:57:39 PM
// Design Name: 
// Module Name: FFT_energy
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


module FFT_energy(
            input clock,
            input ready,
            input [2:0] bin_num,
            input [59:0] addresses,
            input [15:0] data,
            output reg [9:0] bram_addr,
            output done,
            output reg [83:0] color
    );
    
reg [59:0] addr_hold;                   //holds
reg [9:0] max_addr;
reg [59:0] shifted;
reg [2:0] bin_count;
reg [1:0] start_count;
reg addr_count;
reg start;
reg [9:0] current_addr;
reg [41:0] bin_acc;                 //make sure this can hold our maximum value! 

    always@(posedge clock) begin
        /*ready from wubs, for one clock cycle*/ 
        if(ready) begin
            start <= 1'b1;                      //start in taking data and calculating 
            addr_hold <= addresses;
            bram_addr <= 10'd0;
            max_addr <= addresses[9:0];
            
        end
        
        else if(start) begin
            
        /*data available, start calculation */ 
            if(start_count >= 2) begin
                 if(bram_addr < max_addr && bin_count < bin_num) begin 
                     bin_acc <= data*data + bin_acc;                    //update our bin energy 
                     bram_addr <= bram_addr + 1;                        //move on to next bram address
                     start_count <= 0;
                 end
                 
                 else if (bram_addr >= max_addr) begin
                 /****write code to transfer bin_acc value to color value****/
                 
                 
                    bin_count <= bin_count + 1;
                    bin_acc <= 0;
                    /*maybe check if were indexing too far?*/
                    //addr_hold <= addr_hold>>10;
                    max_addr <= addr_hold>>10;     //get next max bin address
                 end
            
            end 
            

            else begin
                start_count <= start_count + 1;    
            end
        
        
        end    
        
    end 
endmodule
