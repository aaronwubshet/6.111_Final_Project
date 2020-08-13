// Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2016.2 (win64) Build 1577090 Thu Jun  2 16:32:40 MDT 2016
// Date        : Thu Dec 07 01:43:54 2017
// Host        : THINKPAD running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub {C:/Users/Aaron
//               Wubshet/Desktop/FinalProjectContainer/sources/ip/fft_mag_axis_register_slice_2_0/fft_mag_axis_register_slice_2_0_stub.v}
// Design      : fft_mag_axis_register_slice_2_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a100tcsg324-3
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* X_CORE_INFO = "axis_register_slice_v1_1_9_axis_register_slice,Vivado 2016.2" *)
module fft_mag_axis_register_slice_2_0(aclk, aresetn, s_axis_tvalid, s_axis_tdata, s_axis_tlast, s_axis_tuser, m_axis_tvalid, m_axis_tdata, m_axis_tlast, m_axis_tuser)
/* synthesis syn_black_box black_box_pad_pin="aclk,aresetn,s_axis_tvalid,s_axis_tdata[15:0],s_axis_tlast,s_axis_tuser[9:0],m_axis_tvalid,m_axis_tdata[15:0],m_axis_tlast,m_axis_tuser[9:0]" */;
  input aclk;
  input aresetn;
  input s_axis_tvalid;
  input [15:0]s_axis_tdata;
  input s_axis_tlast;
  input [9:0]s_axis_tuser;
  output m_axis_tvalid;
  output [15:0]m_axis_tdata;
  output m_axis_tlast;
  output [9:0]m_axis_tuser;
endmodule
