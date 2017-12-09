// Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2016.2 (win64) Build 1577090 Thu Jun  2 16:32:40 MDT 2016
// Date        : Sat Dec 09 02:56:30 2017
// Host        : THINKPAD running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub {c:/Users/Aaron
//               Wubshet/Desktop/FinalProjectContainer/FinalProject/FinalProject.srcs/sources_1/ip/ila_0/ila_0_stub.v}
// Design      : ila_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a100tcsg324-3
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* X_CORE_INFO = "ila,Vivado 2016.2" *)
module ila_0(clk, probe0, probe1, probe2, probe3, probe4, probe5, probe6, probe7)
/* synthesis syn_black_box black_box_pad_pin="clk,probe0[18:0],probe1[18:0],probe2[2:0],probe3[2:0],probe4[11:0],probe5[11:0],probe6[2:0],probe7[0:0]" */;
  input clk;
  input [18:0]probe0;
  input [18:0]probe1;
  input [2:0]probe2;
  input [2:0]probe3;
  input [11:0]probe4;
  input [11:0]probe5;
  input [2:0]probe6;
  input [0:0]probe7;
endmodule
