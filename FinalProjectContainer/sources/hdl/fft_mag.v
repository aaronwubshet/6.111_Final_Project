//Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2016.2 (lin64) Build 1577090 Thu Jun  2 16:32:35 MDT 2016
//Date        : Wed Dec  6 17:28:24 2017
//Host        : eecs-digital-13 running 64-bit Ubuntu 14.04.5 LTS
//Command     : generate_target fft_mag.bd
//Design      : fft_mag
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CORE_GENERATION_INFO = "fft_mag,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=fft_mag,x_ipVersion=1.00.a,x_ipLanguage=VERILOG,numBlks=13,numReposBlks=13,numNonXlnxBlks=0,numHierBlks=0,maxHierDepth=0,numSysgenBlks=0,numHlsBlks=0,numHdlrefBlks=0,numPkgbdBlks=0,bdsource=USER,synth_mode=OOC_per_IP}" *) (* HW_HANDOFF = "fft_mag.hwdef" *) 
module fft_mag
   (clk,
    event_data_in_channel_halt,
    event_data_out_channel_halt,
    event_frame_started,
    event_status_channel_halt,
    event_tlast_missing,
    event_tlast_unexpected,
    frame_tdata,
    frame_tlast,
    frame_tready,
    frame_tvalid,
    magnitude_tdata,
    magnitude_tlast,
    magnitude_tuser,
    magnitude_tvalid);
  input clk;
  output event_data_in_channel_halt;
  output event_data_out_channel_halt;
  output event_frame_started;
  output event_status_channel_halt;
  output event_tlast_missing;
  output event_tlast_unexpected;
  input [15:0]frame_tdata;
  input frame_tlast;
  output frame_tready;
  input frame_tvalid;
  output [15:0]magnitude_tdata;
  output magnitude_tlast;
  output [9:0]magnitude_tuser;
  output magnitude_tvalid;

  wire axis_register_slice_2_m_axis_tlast;
  wire [9:0]axis_register_slice_2_m_axis_tuser;
  wire axis_register_slice_2_m_axis_tvalid;
  wire [15:0]c_addsub_0_S;
  wire clk_1;
  wire [15:0]cordic_0_M_AXIS_DOUT_TDATA;
  wire cordic_0_M_AXIS_DOUT_TLAST;
  wire [9:0]cordic_0_M_AXIS_DOUT_TUSER;
  wire cordic_0_M_AXIS_DOUT_TVALID;
  wire [15:0]frame_1_TDATA;
  wire frame_1_TLAST;
  wire frame_1_TREADY;
  wire frame_1_TVALID;
  wire [15:0]mult_gen_0_P;
  wire [15:0]mult_gen_1_P;
  wire xfft_0_M_AXIS_DATA_TLAST;
  wire xfft_0_M_AXIS_DATA_TVALID;
  wire xfft_0_event_data_in_channel_halt;
  wire xfft_0_event_data_out_channel_halt;
  wire xfft_0_event_frame_started;
  wire xfft_0_event_status_channel_halt;
  wire xfft_0_event_tlast_missing;
  wire xfft_0_event_tlast_unexpected;
  wire [15:0]xfft_0_m_axis_data_tdata;
  wire [15:0]xlconcat_0_dout;
  wire [0:0]xlconstant_0_dout;
  wire [0:0]xlconstant_1_dout;
  wire [2:0]xlconstant_2_dout;
  wire [11:0]xlconstant_3_dout;
  wire [7:0]xlslice_0_Dout;
  wire [7:0]xlslice_1_Dout;

  assign clk_1 = clk;
  assign event_data_in_channel_halt = xfft_0_event_data_in_channel_halt;
  assign event_data_out_channel_halt = xfft_0_event_data_out_channel_halt;
  assign event_frame_started = xfft_0_event_frame_started;
  assign event_status_channel_halt = xfft_0_event_status_channel_halt;
  assign event_tlast_missing = xfft_0_event_tlast_missing;
  assign event_tlast_unexpected = xfft_0_event_tlast_unexpected;
  assign frame_1_TDATA = frame_tdata[15:0];
  assign frame_1_TLAST = frame_tlast;
  assign frame_1_TVALID = frame_tvalid;
  assign frame_tready = frame_1_TREADY;
  assign magnitude_tdata[15:0] = cordic_0_M_AXIS_DOUT_TDATA;
  assign magnitude_tlast = cordic_0_M_AXIS_DOUT_TLAST;
  assign magnitude_tuser[9:0] = cordic_0_M_AXIS_DOUT_TUSER;
  assign magnitude_tvalid = cordic_0_M_AXIS_DOUT_TVALID;
  fft_mag_axis_register_slice_2_0 axis_register_slice_2
       (.aclk(clk_1),
        .aresetn(xlconstant_0_dout),
        .m_axis_tlast(axis_register_slice_2_m_axis_tlast),
        .m_axis_tuser(axis_register_slice_2_m_axis_tuser),
        .m_axis_tvalid(axis_register_slice_2_m_axis_tvalid),
        .s_axis_tdata({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axis_tlast(xfft_0_M_AXIS_DATA_TLAST),
        .s_axis_tuser({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axis_tvalid(xfft_0_M_AXIS_DATA_TVALID));
  fft_mag_c_addsub_0_0 c_addsub_0
       (.A(mult_gen_0_P),
        .B(mult_gen_1_P),
        .CE(1'b1),
        .S(c_addsub_0_S));
  fft_mag_cordic_0_0 cordic_0
       (.aclk(clk_1),
        .m_axis_dout_tdata(cordic_0_M_AXIS_DOUT_TDATA),
        .m_axis_dout_tlast(cordic_0_M_AXIS_DOUT_TLAST),
        .m_axis_dout_tuser(cordic_0_M_AXIS_DOUT_TUSER),
        .m_axis_dout_tvalid(cordic_0_M_AXIS_DOUT_TVALID),
        .s_axis_cartesian_tdata(c_addsub_0_S),
        .s_axis_cartesian_tlast(axis_register_slice_2_m_axis_tlast),
        .s_axis_cartesian_tuser(axis_register_slice_2_m_axis_tuser),
        .s_axis_cartesian_tvalid(axis_register_slice_2_m_axis_tvalid));
  fft_mag_mult_gen_0_0 mult_gen_0
       (.A(xlslice_0_Dout),
        .B(xlslice_0_Dout),
        .CLK(clk_1),
        .P(mult_gen_0_P));
  fft_mag_mult_gen_1_0 mult_gen_1
       (.A(xlslice_1_Dout),
        .B(xlslice_1_Dout),
        .CLK(clk_1),
        .P(mult_gen_1_P));
  fft_mag_xfft_0_0 xfft_0
       (.aclk(clk_1),
        .event_data_in_channel_halt(xfft_0_event_data_in_channel_halt),
        .event_data_out_channel_halt(xfft_0_event_data_out_channel_halt),
        .event_frame_started(xfft_0_event_frame_started),
        .event_status_channel_halt(xfft_0_event_status_channel_halt),
        .event_tlast_missing(xfft_0_event_tlast_missing),
        .event_tlast_unexpected(xfft_0_event_tlast_unexpected),
        .m_axis_data_tdata(xfft_0_m_axis_data_tdata),
        .m_axis_data_tlast(xfft_0_M_AXIS_DATA_TLAST),
        .m_axis_data_tready(xlconstant_1_dout),
        .m_axis_data_tvalid(xfft_0_M_AXIS_DATA_TVALID),
        .s_axis_config_tdata(xlconcat_0_dout),
        .s_axis_config_tvalid(xlconstant_1_dout),
        .s_axis_data_tdata(frame_1_TDATA),
        .s_axis_data_tlast(frame_1_TLAST),
        .s_axis_data_tready(frame_1_TREADY),
        .s_axis_data_tvalid(frame_1_TVALID));
  fft_mag_xlconcat_0_0 xlconcat_0
       (.In0(xlconstant_2_dout),
        .In1(xlconstant_3_dout),
        .In2(xlconstant_1_dout),
        .dout(xlconcat_0_dout));
  fft_mag_xlconstant_0_0 xlconstant_0
       (.dout(xlconstant_0_dout));
  fft_mag_xlconstant_1_0 xlconstant_1
       (.dout(xlconstant_1_dout));
  fft_mag_xlconstant_2_0 xlconstant_2
       (.dout(xlconstant_2_dout));
  fft_mag_xlconstant_3_0 xlconstant_3
       (.dout(xlconstant_3_dout));
  fft_mag_xlslice_0_0 xlslice_0
       (.Din(xfft_0_m_axis_data_tdata),
        .Dout(xlslice_0_Dout));
  fft_mag_xlslice_1_0 xlslice_1
       (.Din(xfft_0_m_axis_data_tdata),
        .Dout(xlslice_1_Dout));
endmodule
