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
    input sd_data,
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
    output [3:0] bin,
    output [59:0] bin_addr,
    output done
    );

    //fsm signals
    reg fft_first_round;
    reg [11:0] fft_send_count;
    reg make_fft_valid;
    reg [2:0] state;

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
    fifo #(.LOGSIZE(14), .WIDTH(11)) myfifo(.clk(clock),.reset(reset),.rd(fread),.wr(fwrite),.din(sd_data), .full(ffull),
            .empty(fempty), .overflow(overflow), .dout(fifo_to_filter));

    //fifo stuff
    wire [7:0] audio_out;
    wire filter_done;
    wire signed [7:0] filter_to_fft;
    filter_control filter_controller(.clock(clock), .reset(reset), .switch(filter_control), .ready(!fempty),
        .state(state), .audio_in(fifo_to_filter), .audio_out(audio_out), .filter_to_fft(filter_to_fft),
        .done(filter_done));

    //fifo to bram
    wire [10:0] filter_bram_addra;
    reg [10:0] filter_bram_addra_filter_reg;
    reg [10:0] filter_bram_addra_fft_reg;
    wire [7:0] fft_input;
    wire internal_bram_we;
    assign internal_bram_we = (state == 3'b000) ? filter_done: 0;
    filter_input_buffer filter_bram (
      .clka(clock),    // input wire clka
      .wea(internal_bram_we),      // input wire [0 : 0] wea
      .addra(filter_bram_addra),  // input wire [10 : 0] addra
      .dina(filter_to_fft),    // input wire [7 : 0] dina
      .douta(fft_input)  // output wire [7 : 0] douta
    );

    //filter to audio PWM
    assign AUD_SD = 1;
    audio_PWM my_audio(.clk(clock), .reset(reset), .music_data(audio_out), .PWM_out(AUD_PWM));


    //internal bram to FFT

    //internal bram address multiplexing
    assign fft_bram_addra = (state == 3'b010 ) ? filter_bram_addra_fft_reg : filter_bram_addra_filter_reg;

    //FFT signals related to input data
    wire fft_input_data;
    assign fft_input_data = {8'b0, fft_input};
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
    assign fft_bram_out_write_enablea = (state == 3'b010) && julian_done && fft_out_data_valid;
    assign fft_bram_out_dina = fft_output_data;
    assign done = fft_bram_out_write_enablea;

    //FFT to Julian
    assign bin = 4'd4;
    assign bin_addr = {30'd0, 10'd100, 10'd500, 10'd850};


    always @ (posedge clock)
    begin
        if (reset)
        begin
            sd_addr <= 0;
            filter_bram_addra_fft_reg <= 11'b0;
            filter_bram_addra_filter_reg <= 11'b0;
            fwrite <= 0;
            fread <= 0;
            sd_rd <= 0;
            state <= 3'b000;
            make_fft_valid <= 0;
        end
        else
        begin
            case(state)

                3'b000: //sd --> fifo --> filter --> audioPWM
                begin
                    if (wings_done)
                    begin
                        last_sd_read_available <= sd_read_available;
                        last_clk_32khz <= clk_32khz;
                        if (last_sd_read_available == 0 && sd_read_available == 1)
                        begin
                            fwrite <= 1;
                        end
                        else
                        begin
                            fwrite <= 0;
                        end
                        if(!ffull)
                        begin
                            sd_rd <= 1;
                        end
                        else
                        begin
                            sd_rd <= 0;
                        end
                        if (sd_count >= 511)
                        begin
                            sd_addr <= sd_addr + 32'h200;
                            sd_count <= 0;
                        end
                        if (clk_32khz == 1 && last_clk_32khz == 0 && !fempty)
                        begin
                            fread <= 1;
                            sd_count <= sd_count + 1;
                        end
                        else
                        begin
                            fread <= 0;
                        end
                        if (filter_done)
                        begin
                            filter_bram_addra_filter_reg <= filter_bram_addra_filter_reg + 1;
                            state <= 3'b001;
                        end
                    end
                end
                3'b001: //
                begin
                    if (filter_bram_addra_filter_reg == 1024  || filter_bram_addra_filter_reg == 1536)
                    begin
                        state <= 3'b010;
                        fft_first_round <= 1;
                    end
                    else if ((filter_bram_addra_filter_reg == 512 || filter_bram_addra_filter_reg == 0) && fft_first_round == 1)
                    begin
                        state <= 3'b010;
                    end
                    else
                    begin
                        state <= 3'b000;
                    end
                end
                3'b010: //compute fft and write out bram
                begin
                    if(julian_done)
                    begin
                        if (fft_ready && fft_send_count <= 1023)
                        begin
                            if (!fft_data_valid)
                            begin
                                make_fft_valid <= 1;
                            end
                            if (fft_out_data_valid)
                            begin
                                fft_send_count <= fft_send_count +1;
                                filter_bram_addra_fft_reg <= filter_bram_addra_fft_reg + 1;
                                fft_bram_out_addra <= fft_bram_out_addra +1;
                                make_fft_valid <= 0;
                            end
                        end
                        if (fft_out_data_last)
                        begin
                            fft_send_count <= 0;
                            filter_bram_addra_fft_reg <= filter_bram_addra_fft_reg - 512;
                            state <= 3'b000;
                        end
                    end
                end
            endcase
        end
    end
endmodule
