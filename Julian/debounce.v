`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/04/2017 06:31:48 PM
// Design Name: 
// Module Name: debounce
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


module debounce (input reset, clock, noisy,
                 output reg clean);

   reg [19:0] count;
   reg new_1;

   always @(posedge clock)
     if (reset) begin new_1 <= noisy; clean <= noisy; count <= 0; end
     else if (noisy != new_1) begin new_1 <= noisy; count <= 0; end
     else if (count == 250000) clean <= new_1;
     else count <= count+1;

endmodule