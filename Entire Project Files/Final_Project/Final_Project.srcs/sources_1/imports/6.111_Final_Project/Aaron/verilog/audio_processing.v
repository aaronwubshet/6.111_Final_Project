`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////

module audio_processing(
    input clock, //100 MHZ clock
    input clk_25mhz,
    input reset,
    input sd_done, // goes high when wings is done using the SD card
    input sd_read_available, //goes high when the SD card has a value present on dout
    input sd_ready, //goes high when SD card is ready for a read or write
    output AUD_PWM,
    output AUD_SD,
    input [1:0] SW,
    output bin_count,
    input audio_data,
    output [59:0] bin_add,
    input julian_done,
    output done,
    output reg sd_read_address,
    output fft_bram_out_write_enablea,
    output fft_bram_out_addra,
    output fft_bram_out_dina 
    );        
    
    
assign bin_count = 4;
assign bin_add = {30'd0, 10'd200, 10'd400, 10'd600}; 
//fsm variables
reg [1:0] state;
reg [1:0] count;
reg [9:0] send_count;
reg first_round;

//generate sample buffer signals
wire sample_write_enable;
reg sample_write_enable_reg;
wire sample_addra;
reg [10:0] sample_addra_read_reg;
reg [10:0] sample_addra_fft_read_reg;
reg [10:0] sample_addra_write_filter_reg;
reg [10:0] sample_addra_write_reg;
wire sample_dina;
reg sample_dina_reg;
wire sample_douta;
reg sample_douta_reg;

//changing assignments 
assign sample_write_enable = sample_write_enable_reg;
assign sample_dina = sample_dina_reg;
assign sample_addra = sample_write_enable ? 
                        (state == 3'b000 || state == 3'b001) ? sample_addra_write_reg: sample_addra_write_filter_reg: 
                       (state == 3'b010 || state == 3'b011) ? sample_addra_read_reg: sample_addra_fft_read_reg;
assign sample_douta = sample_douta_reg;

//8 bits wide and 2048 lines long
filter_input_buffer sample_buffer (
  .clka(clock),    // input wire clka
  .wea(sample_write_enable),      // input wire [0 : 0] wea
  .addra(sample_addra),  // input wire [10 : 0] addra
  .dina(sample_dina),    // input wire [7 : 0] dina
  .douta(sample_douta)  // output wire [7 : 0] douta
);

//general filter signals
wire ready_to_filter;
wire filters_done;
wire filters_ready;
assign ready_to_filter = count == 2 ? 1:0;

//bram to filter interface signals
wire [7:0] bram_to_filter_data;
reg [7:0] bram_to_filter_data_reg;
assign bram_to_filter_data = bram_to_filter_data_reg;

//filter to audio interface
wire [7:0] audio_out;

//filter to FFT interface
wire signed [7:0] filter_to_fft;
wire ir; //internalready for filter output
//filter instantiation
filter_control filter_controller_module(.clock(clock),.reset(reset), .switch(SW[1:0]),.ready(filters_ready),
        .audio_in(bram_to_filter_data),.audio_out(audio_out), .filter_to_fft(filter_to_fft),
        .done(filters_done),.internal_ready(ir));

assign filters_ready = (state == 3'b011) ? 1 : 0;

//audio instantiation
assign AUD_SD = 1;
audio_PWM my_audio(.clk(clock), .reset(reset), .music_data(audio_out), .PWM_out(AUD_PWM));

//general FFT signals
wire fft_input_data;
assign fft_input_data = {8'b0, sample_douta};

wire fft_data_valid; //data is ready for fft
reg fft_data_valid_reg;
assign fft_data_valid = fft_data_valid_reg;

wire last_sample;
assign last_sample = (send_count == 1022) ? 1 :0;

wire [15:0] fft_output_data;
wire fft_out_data_valid;
wire bram_ready_for_fft_out_data;
wire fft_out_data_last; //last sample in frame
wire [9:0] tuser;

fft_mag my_fft(.clk(clock), .event_tlast_missing(tlast_missing),.frame_tdata(fft_input),.frame_tlast(last_sample),
        .frame_tready(fft_ready), .frame_tvalid(fft_data_valid), .magnitude_tdata(fft_output), .magnitude_tlast(fft_out_data_last),
        .magnitude_tuser(tuser), .magnitude_tvalid(fft_out_data_valid));

assign fft_bram_out_write_enablea = (state == 3'b100) && julian_done && fft_out_data_valid;
assign fft_bram_out_dina = fft_output_data;
assign done = (state != 3'b100) ? 1:0;

assign fft_bram_out_addra = tuser;

always @ (posedge clock)
    begin
        if(reset)
        begin
            state <= 3'b000;
            sample_addra_read_reg <= 11'b0;
            sample_addra_write_reg <= 11'b0;
            sample_addra_fft_read_reg <= 11'b0;
            sample_addra_write_filter_reg <= 11'b0;
            sample_dina_reg <= 8'b0;
            //sd_read_address <= 32'd500000;
            sample_write_enable_reg <= 0;
            count <= 0;
            send_count <= 0;
        end
        if (sd_done && julian_done)
        begin
            case(state)
            
                //read from sd card
                3'b000:
                begin
                    fft_data_valid_reg <=0;
                    if(sd_ready)
                        if (sd_read_available)
                        begin
                            sd_read_address <= sd_read_address + 1;
                            sample_dina_reg <= audio_data;
                            state <= 3'b001;
                            sample_write_enable_reg <= 1;
                        end
                end
                //write to bram
                3'b001:
                begin
                    sample_addra_write_reg <= sample_addra_write_reg + 1;
                    sample_write_enable_reg <= 0;
                    state <= 3'b010;
                end
                
                //filter reads from bram
                3'b010:
                begin
                    if(filters_done)
                    begin
                        if (count == 2)
                        begin
                            sample_addra_read_reg <= sample_addra_read_reg + 1;
                            count <= 0;
                            bram_to_filter_data_reg <= sample_douta;
                            state <= 3'b011;
                            sample_write_enable_reg <= 1;
                        end
                        else
                        begin
                            count <= count +1;
                        end
                    end
                end
                
                //filter write to bram
                3'b011:
                begin
                    if (ir)
                    begin
                        sample_addra_write_filter_reg <= sample_addra_write_filter_reg +1;
                        sample_dina_reg <= filter_to_fft;
                        sample_write_enable_reg <= 0;
                        if (sample_addra_write_filter_reg == 1024 || sample_addra_write_filter_reg == 1536)
                        begin
                            first_round <= 1;
                            state <= 3'b100;
                        end
                        else if(first_round && (sample_addra_write_filter_reg == 0 || sample_addra_write_filter_reg == 512))
                        begin
                            state<= 3'b100;
                        end
                        else
                        begin
                            state<= 3'b000;
                        end
                    end
                end
                
                //fft read
                3'b100:
                begin
                    if (julian_done)
                    begin
                        if (fft_ready && send_count <= 1023)
                        begin
                            if (send_count != 1023)
                            begin
                                sample_addra_fft_read_reg <= sample_addra_fft_read_reg +1;
                            end
                            fft_data_valid_reg<=1;
                            send_count <= send_count +1;
                        end
                        if (send_count == 1023)
                        begin
                            sample_addra_fft_read_reg <= sample_addra_fft_read_reg -512;
                            state <= 3'b000;    
                        end
                    end
                end
            endcase
        end
    end

endmodule
