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
            input reset,
            input wire [2:0] bin_num,
            input wire [59:0] addresses,
            input wire [15:0] data,
            input wire [3:0] off1,
            input wire [3:0] off2,
            input wire [3:0] off3,
            input wire [3:0] off4,
            input wire [3:0] off5,
            input wire [3:0] off6,
            input wire [3:0] off7,
            input wire adjusting,
            output wire [11:0] acc,
            output reg [9:0] bram_addr,
            output reg done,
            output reg [3:0]  c_map_test,
            output wire [83:0] color,
            output reg [23:0] test_out,     //debugging output 
            output reg test,
            output reg  [9:0] julian_test,
            output reg start
    );
    
reg [59:0] addr_hold;                   //holds
reg [9:0] max_addr;
reg [2:0] bin_count;
reg [2:0] start_count;
reg addr_count;
reg start = 0;
reg [41:0] bin_acc;                 //make sure this can hold our maximum value! - 42 bits

/*individual color registers*/ 
reg [11:0] sev;
reg [11:0] six;
reg [11:0] fiv;
reg [11:0] four;
reg [11:0] three;
reg [11:0] two;
reg [11:0] one; 

/*individual color map wires*/ 
wire [3:0] c_map_1;
wire [3:0] c_map_2;
wire [3:0] c_map_3;
wire [3:0] c_map_4;
wire [3:0] c_map_5;
wire [3:0] c_map_6;
wire [3:0] c_map_7;



reg first_time;

initial first_time = 0;
 //reg julian_test;
 reg done_delay;
 reg [5:0] count;
 initial done_delay = 0;
initial done = 1; //AARON ADDED THIS LINE SO THAT INITIALLY JULIAN OUTPUTS DONE
    always@(posedge clock) begin
        //AARON ADDED A SEPARATE CONDITIONAL THAT TRIGGERS IF AND ONLY IF THERE IS A RESET
        if(reset) begin
            done <= 1;
            
            
            sev = 12'hFFF;
            six = 12'hD2A;
            fiv = 12'h000;
            four = 12'h00F;
            three =12'h6FF;
            two = 12'hF00;
            one = 12'h0F0;
        end
        /*ready from wubs, while I can read*/ 
        //THIS SET UP STUFF CAN'T HAPPEN AT RESET, IT NEEDS TO HAPPEN THE FIRST CLOCK CYCLE IN WHICH READY
        //IS ASSERT FROM AARON
        if (done)
        begin
            done_delay <= 1;
        end
        else
        begin
            done_delay <= 0;
        end
        if((ready && !start && done_delay)) begin
            start <= 1'b1;                      //start in taking data and calculating 
            addr_hold <= addresses;
            bram_addr <= 10'd511;
            max_addr <= addresses[9:0];
            //max_addr <= 10'd1023;
            bin_count <= 0;
            start_count <= 0;
            done <= 1'b0;
            //test_out <= 0;
            bin_acc <= 0;
            
//            sev = 12'hFFF;
//            six = 12'hD2A;
//            fiv = 12'h000;
//            four = 12'h00F;
//            three =12'h6FF;
//            two = 12'hF00;
//            one = 12'h0F0; 
            
        end
        
        if(start) begin 
            
            if(bin_count < bin_num) begin
            /*data available, start calculation */ 
                if(start_count >= 2) begin
                    start_count <= 0;
                     if(bram_addr < max_addr) begin 
                         bin_acc <= data*data + bin_acc;                    //update our bin energy
                         test_out[15:0] <= data;
                         bram_addr <= bram_addr + 1;                        //move on to next bram address
                         //start_count <= 0;
                         //test_out <= 1;
                     end
                     
                     else if (bram_addr >= max_addr) begin
                     /****write code to transfer bin_acc value to color value****/
                        case(bin_count) 
                            3'b000: begin
                                if(adjusting) begin
                                    one <= one;             //load in previous value 
                                end
                                
                                else begin                  //otherwise update 
                                    if(c_map_1 >= 15) begin
                                        one <= 12'h0FF;
                                            
                                    end
                                            
                                    else begin
                                        one <= {4'h0,4'hF - c_map_1, 4'hF};
                                    end
                                
                                end
                            end
                            
                            3'b001: begin
                                c_map_test <=c_map_2;
                                if(adjusting) begin
                                    two <= two; 
                                end
                                
                                else begin
                                    if(c_map_2 > 11)begin
                                        two <= {4'h0,4'h8,4'h0};
                                    end 
                                                                
                                    if(c_map_2 <= 4) begin
                                        two <=  {4'h0, 4'hF, (4'h4 - c_map_2)};
                                    end
                                                                
                                    else if((c_map_2 > 4) && (c_map_2 <= 11)) begin 
                                        two <= {4'h0,4'hF - (c_map_2 - 4'h4),4'h0};
                                    end
                                    
                                end
                               
                            end    
                                       
                            3'b010:begin
                            
                                if(!first_time)begin
                                    julian_test <= max_addr;
                                    first_time <= 1;
                                end
                                if(adjusting) begin
                                    three <= three; 
                                end
                                
                                else begin 
                                    if(c_map_3 >= 12) begin
                                        three <= {4'hB,4'h0, 4'h0};
                                    end
                                                                 
                                    if(c_map_3 < 7) begin 
                                        three <= {4'hF,4'h7-c_map_3,4'h0};
                                    end
                                                           
                                    else if ((c_map_3 >= 7) && (c_map_3 < 12)) begin 
                                        three <= {4'hF - (c_map_3 - 4'h7),4'h0,4'h0};
                                    end 
                                
                                end
                            end
                          
                            3'b011: begin
                                if(adjusting) begin
                                    four <= four;
                                end
                                
                                else begin 
                                    if(c_map_4 >= 12) begin
                                        four <= {4'hF,4'h0,4'h3};
                                    end
                                    
                                    if(c_map_4 < 2)begin
                                        four <= {4'hF,4'h2 - c_map_4,4'hD};
                                    end
                                                            
                                    else if ((c_map_4 >= 2) && (c_map_4 <12)) begin
                                        four <= {4'hF,4'h0,4'hD - (c_map_4 - 4'h2)};
                                    end
                                
                                end
                               
                            
                            
                            end 
                            3'b100:begin 
                                if(adjusting)begin
                                    fiv <= fiv;
                                end
                                
                                else begin 
                                    if(c_map_5 > 10) begin
                                        fiv <= {4'h3,4'h0,4'hF};
                                    end
                                  
                                    else begin 
                                        fiv <= {4'hD - c_map_5, 4'h0,4'hF};
                                    end
                                end
               
                            end
                            
                            
                            3'b101: begin 
                                if(adjusting) begin 
                                    six <= six;
                                end
                                
                                else begin 
                                    if(c_map_6 > 13) begin 
                                        six <= {4'h3,4'h0,4'hF};
                                    end
                                                            
                                    else begin 
                                        six <= {4'hF - c_map_6,4'h0,4'h0};
                                    end
                                
                                end
                            end
                            
                            
                            
                            
                            3'b110:begin 
                                if(adjusting)begin
                                    sev <= sev;
                                end
                                
                                else begin 
                                    if(c_map_7 > 13) begin 
                                        sev <= {4'h3,4'h0,4'h0};
                                    end
                                                                                        
                                    else begin 
                                        sev <={4'h0,4'h0,4'hF - c_map_7 };
                                    end
                                end 
                            end
                            
                            
                            
                            3'b111: begin 
                               
                            end                            
                        
                        
                        endcase 
                        
                        
                        
                        //test_out <= bin_acc;
                        bin_count <= bin_count + 1;
                        bin_acc <= 0;
                        addr_hold <= addr_hold >>10;
                        max_addr <= addr_hold>>10;     //get next max bin address
            //            start_count <= 0;
                     end
                
                end 
                
    
                else begin
                    start_count <= start_count + 1;    
                end
        
            end
            
            else begin
                done <= 1'b1;
                start <= 0;
                count <= count + 1;
                if (count > 10)
                begin
                    count <= 0;
                    //julian_test <= 1;
                end
                //possibly wait a clock cycle 
                //test_out <= 4;
                //bin_acc <= 1;
            end
            
        end
        
//        else if (done) begin
//            start <= 1'b0;
//        end
    end 
 assign acc = bin_acc;
 assign c_map_1 = {bin_acc[off1 + 3],bin_acc[off1 + 2],bin_acc[off1 + 1],bin_acc[off1]} ;          //offset bits of accumulation register 
 assign c_map_2 = {bin_acc[off2 + 3],bin_acc[off2 + 2],bin_acc[off2 + 1],bin_acc[off2]};          //offset bits of accumulation register 
 assign c_map_3 = {bin_acc[off3 + 3],bin_acc[off3 + 2],bin_acc[off3 + 1],bin_acc[off3]} ;          //offset bits of accumulation register 
 assign c_map_4 = {bin_acc[off4 + 3],bin_acc[off4 + 2],bin_acc[off4 + 1],bin_acc[off4]} ;          //offset bits of accumulation register 
 assign c_map_5 = {bin_acc[off5 + 3],bin_acc[off5 + 2],bin_acc[off5 + 1],bin_acc[off5]} ;          //offset bits of accumulation register 
 assign c_map_6 = {bin_acc[off6 + 3],bin_acc[off6 + 2],bin_acc[off6 + 1],bin_acc[off6]} ;          //offset bits of accumulation register 
 assign c_map_7 = {bin_acc[off7 + 3],bin_acc[off7 + 2],bin_acc[off7 + 1],bin_acc[off7]} ;          //offset bits of accumulation register 
 assign color = {sev,six,fiv,four,three,two,one}; 
endmodule
