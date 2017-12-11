`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/27/2017 04:58:20 PM
// Design Name: 
// Module Name: test
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


module audio_processing(
    input clock,
    input clk_25mhz,
    input reset,
    input wings_done,
    input julian_done,
    input [7:0] sd_data,
    input sd_ready,
    input sd_read_available,
    input filter_control,
    output AUD_PWM,
    output reg [31:0] sd_addr,
    output AUD_SD,
    output reg sd_rd,
    output fft_bram_out_write_enablea,
    output reg [9:0] fft_bram_out_addra,
    output [8:0] fft_bram_out_dina,
    output [2:0] bin,
    output [59:0] bin_addr,
    output done,
    output reg [2:0] state,
    output reg filter_flag,
    output filter_done,
    output filter_ready,
    output wire flag,
    output wire last_flag,
    output test
        
    );
    
    //fsm signals
    reg fft_first_round;
    reg [12:0] fft_send_count;
    reg make_fft_valid;
    reg [2:0] state;
    reg first_sample_flag;
    reg filter_flag;
    
    //32khz clk for audio
    reg last_clk_32khz;
    wire clk_32khz; // audio sample rate clock
    clock_divider clk_32khz_module(.clk_in(clock), .clk_out(clk_32khz), .divider(32'd1563), .reset(reset)); // 100_000_000 / (32_000*2) = 1563


    //SD to fifo
    reg [8:0] sd_count;
    reg last_sd_read_available;
    wire overflow;
    reg fwrite;
    reg fread;
    wire [7:0] fifo_to_filter;
    fifo #(.LOGSIZE(9), .WIDTH(8)) myfifo(.clk(clock),.reset(reset),.rd(fread),.wr(fwrite),.din(sd_data), .full(ffull),
            .empty(fempty), .overflow(overflow), .dout(fifo_to_filter));
    
    //fifo to filter
    wire [7:0] audio_out;
    //wire filter_done;
    reg filter_ready;
    wire filt_ready;
    assign filt_ready = filter_ready;
    wire signed [7:0] filter_to_fft;
    filter_control filter_controller(.clock(clock), .reset(reset), .switch(filter_control), .ready(filt_ready), 
        .audio_in(fifo_to_filter), .audio_out(audio_out), .done(filter_done), .flag(flag), .last_flag(last_flag));


    //filter to bram
    wire [10:0] filter_bram_addra;
    reg [10:0] filter_bram_addra_filter_reg;
    reg [10:0] filter_bram_addra_fft_reg;
    wire [7:0] fft_input;
    reg internal_bram_we;
    //assign internal_bram_we = filter_done;
    filter_input_buffer filter_bram (
      .clka(clock),    // input wire clka
      .wea(internal_bram_we),      // input wire [0 : 0] wea
      .addra(filter_bram_addra),  // input wire [10 : 0] addra
      .dina(audio_out),    // input wire [7 : 0] dina
      .douta(fft_input)  // output wire [7 : 0] douta
    );
    
    //filter to audio PWM
    assign AUD_SD = 1;
    audio_PWM audio_at32khz(.clk(clock), .reset(reset),.music_data(audio_out), .PWM_out(AUD_PWM));
    
    
    //internal bram to FFT
    
    //internal bram address multiplexing
    assign filter_bram_addra = (state == 3'b100 ) ? filter_bram_addra_fft_reg : filter_bram_addra_filter_reg;
    
    //FFT signals related to input data
    assign zero_extended_fft_input_data = {8'b0, fft_input};
    wire signed [15:0] fft_input_data = {1'b0, zero_extended_fft_input_data} - (1 << 15);

    wire fft_data_valid; //data is ready for fft
    assign fft_data_valid = (julian_done && fft_send_count <=1023 && fft_ready && make_fft_valid) ? 1 : 0;
    wire last_sample;
    assign last_sample = (fft_send_count == 1024) ? 1 :0;
    
    //FFT signals related to output data
    wire [15:0] fft_output_data;
    wire fft_out_data_valid;
    wire fft_out_data_last; //last sample in frame
    wire [9:0] tuser;
    
    fft_mag my_fft(.clk(clock), .event_tlast_missing(tlast_missing),.frame_tdata(fft_input_data),.frame_tlast(last_sample),
            .frame_tready(fft_ready), .frame_tvalid(fft_data_valid), .magnitude_tdata(fft_output_data), .magnitude_tlast(fft_out_data_last),
            .magnitude_tuser(tuser), .magnitude_tvalid(fft_out_data_valid));

    //FFT to external bram
    assign fft_bram_out_write_enablea = (state == 3'b100) && julian_done && fft_out_data_valid;
    assign fft_bram_out_dina = fft_output_data;
    
    reg done_reg;
    initial done_reg = 0;
    assign done = done_reg; 
    //assign done = (state != 3'b100) ? !julian_done : (!julian_done || fft_out_data_last);
    
    //FFT to Julian
    assign bin = 3'd4;
    //assign bin_addr = {30'd0, 10'd300, 10'd700, 10'd1023};
    assign bin_addr = {20'd0,10'd1023, 10'd691, 10'd541, 10'd521};
    

    reg test;
    always @ (posedge clock)
    begin
        last_clk_32khz <= clk_32khz;
        if(done)
        begin
            test <= 1;
        end
        if (reset)
        begin
            sd_addr <= 32'h0;
            filter_bram_addra_fft_reg <= 11'b0;
            filter_bram_addra_filter_reg <= 11'b0;
            fwrite <= 0;
            fread <= 0;
            sd_rd <= 0;
            state <= 3'b000;
            make_fft_valid <= 0;
            filter_ready <= 0;
            first_sample_flag <= 1;
            filter_flag <= 0;
        end
        else
        begin
            if(wings_done)
            begin
                last_sd_read_available <= sd_read_available;
                case(state)
                    //SD --> FIFO --> Filter --> audioPWM
                    //                  ||
                    //                  --> BRAM1 ---> FFT --> BRAM2
                    3'b000: 
                    begin     
                        //whenever julian is done, i am not done
                        if (julian_done)
                        begin
                            done_reg <=0;
                        end
                        // when filtering is done write it to the bram and read a new value into the filter 
                        // as a 32khz rate to match the audio requirements
                        if (filter_done)
                        begin
                            filter_flag <= 1;
                        end
                        else if (filter_flag && last_clk_32khz == 0 && clk_32khz == 1)
                        begin
                            fread <= 1;
                            filter_ready <= 1;
                            internal_bram_we <= 1;
                            filter_flag <=0;
                            state <= 3'b011;
                        end
                        else
                        begin
                            state <= 3'b001;
                        end
                        //start filling up the fifo if it is empty
                        if (fempty)
                        begin
                            sd_rd <=1;
                        end
                        else
                        begin
                            sd_rd<=0;
                        end
                        // fifo has room and sd card byte is avaliable so write to fifo, increment sd_count(reading)
                        // and change states to see if filter is ready to read from fifo if this is the first value
                        if (last_sd_read_available == 0 && sd_read_available == 1 )
                        begin
                            fwrite <= 1;
                            sd_count <= sd_count + 1; 
                            
                        end
                        // otherwise don't write to fifo
                        else
                        begin
                            fwrite <= 0;
                        end
                        // if 512 bytes have been read from SD card then increment address by 200 hex and reset sd_count since
                        // the fifo will be full
                        if (sd_count >= 511)
                        begin
                            sd_addr <= sd_addr + 32'h200;
                            sd_count <= 0;
                        end

                        
                    end

                    3'b001:
                    begin
                        if (julian_done)
                        begin
                            done_reg <=0;
                        end 
                        
                         // fifo has room and sd card byte is avaliable so write to fifo, increment sd_count(reading)
                       if (last_sd_read_available == 0 && sd_read_available == 1 )
                       begin
                           fwrite <= 1;
                           sd_count <= sd_count + 1; 
                       end
                       // otherwise don't write to fifo
                       else
                       begin
                           fwrite <= 0;
                       end   
                       // if 512 bytes have been read from SD card then increment address by 200 hex and reset sd_count since
                       // the fifo will be full
                       if (sd_count >= 511)
                       begin
                           sd_addr <= sd_addr + 32'h200;
                           sd_count <= 0;
                       end   
                        
                       //only write one value to fifo
                       //if this is the first value being written to fifo from sd card simply shift into filter and  
                       // go into state waiting for filter to finish

                        if(first_sample_flag)
                        begin
                            first_sample_flag <=0;
                            fread <= 1;
                            filter_ready <= 1;
                            state <= 3'b010;
                            fwrite <=0;
                               
                        end
                        else
                        begin
                            // when filtering is done write it to the bram and read a new value into the filter 
                            // as a 32khz rate to match the audio requirements 
                            if (filter_done)
                            begin
                                filter_flag <= 1;
                                fread <= 0;
                            end
                            //otherwise go straight to waiting for the filter to finish processing previous sample
                            else if (filter_flag && last_clk_32khz == 0 && clk_32khz == 1)
                            begin
                                fread <= 1;
                                filter_ready <= 1;
                                internal_bram_we <= 1;
                                filter_flag <=0;
                                state <= 3'b011;
                            end
                            else if(!filter_flag)
                            begin
                                fread <= 0;
                                filter_ready <= 0;
                                state <= 3'b010;
                            end
                            else
                            begin
                                filter_ready <= 0;
                            end
                                                                      
                        end
                    end
                    3'b010:
                    begin
                        // filtering is done so write it to the bram and read a new value into the filter 
                        if (filter_done)
                        begin
                            filter_flag <= 1;
                            fread <= 0;
                        end
                        else if (filter_flag && last_clk_32khz == 0 && clk_32khz == 1)
                        begin
                            fread <= 1;
                            filter_ready <= 1;
                            internal_bram_we <= 1;
                            filter_flag <= 0;
                            state <= 3'b011;
                        end
                        //go back and try to add another value to the fifo  while waiting for the filter
                        else
                        begin
                            //only read out one value from fifo
                            fread <= 0;
                            //filter is not ready for new values
                            filter_ready <= 0;
                        end
                        // fifo has room and sd card byte is avaliable so write to fifo, increment sd_count(reading)
                        if (last_sd_read_available == 0 && sd_read_available == 1 )
                        begin
                            fwrite <= 1;
                            sd_count <= sd_count + 1; 
                        end
                        // otherwise don't write to fifo
                        else
                        begin
                            fwrite <= 0;
                        end
                        // if 512 bytes have been read from SD card then increment address by 200 hex and reset sd_count since
                        // the fifo will be full
                        if (sd_count >= 511)
                        begin
                            sd_addr <= sd_addr + 32'h200;
                            sd_count <= 0;
                        end
                        if (julian_done)
                        begin
                            done_reg <=0;
                        end
                    end
                    3'b011: 
                    begin
                        //if coming from state 1 fread will need to be set to 0 so that multiple values are not read
                        // from the fifo
                        fread <= 0;
                        //if coming from state 0,1, or 2 and a byte was avaliable for mthe sd card then fwrite needs to de
                        // asserted
                        fwrite <= 0;
                        //a value was just written to the bram so increment the address
                        filter_bram_addra_filter_reg <= filter_bram_addra_filter_reg + 1;
                        //if 1024 of 1535 values have been filtered and written to the bram
                        //then send the first fft window over and also set first fft flag
                        // also disable internal bram writing
                        if (filter_bram_addra_filter_reg == 1024  || filter_bram_addra_filter_reg == 1536)
                        begin
                            state <= 3'b100;
                            internal_bram_we <= 0;
                            fft_first_round <= 1;
                        end
                        // 512 and 0 also trigger an fft window after the first window has been sent
                        // also disable internal bram writing
                        else if ((filter_bram_addra_filter_reg == 512 || filter_bram_addra_filter_reg == 0) && fft_first_round == 1)
                        begin   
                            state <= 3'b100;
                            internal_bram_we <= 0;
                        end
                        // go back to state 0 to push more data from the sd card into the pipeline if 
                        // there is not enough data for the fft to run yet
                        else
                        begin
                            state <= 3'b000;
                        end
                        // fifo has room and sd card byte is avaliable so write to fifo, increment sd_count(reading)
                        if (last_sd_read_available == 0 && sd_read_available == 1 )
                        begin
                            fwrite <= 1;
                            sd_count <= sd_count + 1; 
                        end
                        // otherwise don't write to fifo
                        else
                        begin
                            fwrite <= 0;
                        end   
                        // if 512 bytes have been read from SD card then increment address by 200 hex and reset sd_count since
                        // the fifo will be full
                        if (sd_count >= 511)
                        begin
                            sd_addr <= sd_addr + 32'h200;
                            sd_count <= 0;
                        end  
                        if (julian_done)
                        begin
                            done_reg <=0;
                        end
                    end
                    3'b100:
                    begin
                        // once julian is done using external bram check if fft is ready to accept data
                        if(julian_done)
                        begin
                            if (fft_ready && fft_send_count <= 1023)
                            begin
                                //account for one clock cycle bram read delay by reseting the data to invalid after 
                                //each value is output from fft module
                                if (!fft_data_valid)
                                begin
                                    make_fft_valid <= 1;
                                end     
                                //increment fft send count so that only 1024 values are output
                                if (fft_out_data_valid)
                                begin
                                    fft_send_count <= fft_send_count +1;
                                    filter_bram_addra_fft_reg <= filter_bram_addra_fft_reg + 1; 
                                    fft_bram_out_addra <= fft_bram_out_addra +1;
                                    make_fft_valid <= 0;
                                end
                            end
                            //reset the internal bram reading address used by the fft to 512 back so that windows
                            //overlap by half the width
                            if (fft_out_data_last)
                            begin
                                fft_send_count <= 0;
                                filter_bram_addra_fft_reg <= filter_bram_addra_fft_reg - 512;
                                fft_bram_out_addra <= 0;
                                done_reg <= 1;
                                state <= 3'b000;    
                            end
                            else
                            begin
                                done_reg <= 0;
                            end
                        end
                        // fifo has room and sd card byte is avaliable so write to fifo, increment sd_count(reading)
                        if (last_sd_read_available == 0 && sd_read_available == 1 )
                        begin
                            fwrite <= 1;
                            sd_count <= sd_count + 1; 
                        end
                        // otherwise don't write to fifo
                        else
                        begin
                            fwrite <= 0;
                        end
                        // if 512 bytes have been read from SD card then increment address by 200 hex and reset sd_count since
                        // the fifo will be full
                        if (sd_count >= 511)
                        begin
                            sd_addr <= sd_addr + 32'h200;
                            sd_count <= 0;
                        end
                    end
                endcase
            end
        end
    end
endmodule