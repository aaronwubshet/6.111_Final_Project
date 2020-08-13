// Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2016.2 (win64) Build 1577090 Thu Jun  2 16:32:40 MDT 2016
// Date        : Thu Dec 07 01:48:57 2017
// Host        : THINKPAD running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub {C:/Users/Aaron
//               Wubshet/Desktop/FinalProjectContainer/sources/ip/fft_mag_xlconcat_0_0/fft_mag_xlconcat_0_0_stub.v}
// Design      : fft_mag_xlconcat_0_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a100tcsg324-3
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* X_CORE_INFO = "xlconcat,Vivado 2016.2" *)
module fft_mag_xlconcat_0_0(In0, In1, In2, dout)
/* synthesis syn_black_box black_box_pad_pin="In0[2:0],In1[11:0],In2[0:0],dout[15:0]" */;
  input [2:0]In0;
  input [11:0]In1;
  input [0:0]In2;
  output [15:0]dout;
endmodule
