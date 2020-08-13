`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/04/2017 11:53:08 AM
// Design Name: 
// Module Name: Color_offst
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


module Color_offst( 
        input clock,
        input wire reset,
        input wire [15:0] SW,
        input wire up,
        input wire down,
        output wire adjusting,
        output reg [3:0] off1,
        output reg [3:0] off2,
        output reg [3:0] off3,
        output reg [3:0] off4,
        output reg [3:0] off5,
        output reg [3:0] off6,
        output reg [3:0] off7

    );
  
    always@(posedge clock)begin
        if(reset)begin
            off1 <= 0;
            off2 <= 0;
            off3 <= 0;
            off4 <= 0;
            off5 <= 0;
            off6 <= 0;
            off7 <= 0;
        end
        
        else if(adjusting) begin
            if (SW[0]) begin 
                if(up)begin
                    if(off1 == 15)begin
                        off1 <= off1;
                    end
                    else begin 
                        off1 <= off1 + 1;
                    end
                    
                end
                
                else if (down)begin
                    if(off1 == 0) begin
                        off1 <= off1;
                    end
                    else begin 
                        off1 <= off1 - 1;
                    end
                end
            end
            
            
            
            
            
            
            
            if (SW[1]) begin 
                if(up)begin
                    if(off2 == 15)begin
                        off2 <= off2;
                    end
                    else begin 
                        off2 <= off2 + 1;
                    end
                    
                end
                
                else if (down)begin
                    if(off2 == 0) begin
                        off2 <= off2;
                    end
                    else begin 
                        off2 <= off2 - 1;
                    end
                end
            end
            
            
            
            
            
            
            if (SW[2]) begin 
                if(up)begin
                    if(off3 == 15)begin
                        off3 <= off3;
                    end
                    else begin 
                        off3 <= off3 + 1;
                    end
                    
                end
                
                else if (down)begin
                    if(off3 == 0) begin
                        off3 <= off3;
                    end
                    else begin 
                        off3 <= off3 - 1;
                    end
                end
            end
            
            
            
            
            if (SW[3]) begin 
                if(up)begin
                    if(off4 == 15)begin
                        off4 <= off4;
                    end
                    else begin 
                        off4 <= off4 + 1;
                    end
                    
                end
                
                else if (down)begin
                    if(off4 == 0) begin
                        off4 <= off4;
                    end
                    else begin 
                        off4 <= off4 - 1;
                    end
                end
            end
      
            
            if (SW[4]) begin 
                if(up)begin
                    if(off5 == 15)begin
                        off5 <= off5;
                    end
                    else begin 
                        off5 <= off5 + 1;
                    end
                    
                end
                
                else if (down)begin
                    if(off5 == 0) begin
                        off5 <= off5;
                    end
                    else begin 
                        off5 <= off5 - 1;
                    end
                end
            end
            
            
            
            if (SW[5]) begin 
                if(up)begin
                    if(off6 == 15)begin
                        off6 <= off6;
                    end
                    else begin 
                        off6 <= off6 + 1;
                    end
                    
                end
                
                else if (down)begin
                    if(off6 == 0) begin
                        off6 <= off6;
                    end
                    else begin 
                        off6 <= off6 - 1;
                    end
                end
            end
            
            
            if (SW[6]) begin 
                if(up)begin
                    if(off7 == 15)begin
                        off7 <= off7;
                    end
                    else begin 
                        off7 <= off7 + 1;
                    end
                    
                end
                
                else if (down)begin
                    if(off7 == 0) begin
                        off7 <= off7;
                    end
                    else begin 
                        off7 <= off7 - 1;
                    end
                end
            end
            
        end
        
    
    
    
    
    
    
    end
assign adjusting = (SW[6:0] == 0) ? 0: 1;
endmodule
