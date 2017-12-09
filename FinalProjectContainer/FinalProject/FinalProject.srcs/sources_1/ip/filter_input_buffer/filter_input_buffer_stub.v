// Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2016.2 (win64) Build 1577090 Thu Jun  2 16:32:40 MDT 2016
// Date        : Fri Dec 08 16:49:35 2017
// Host        : THINKPAD running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub {C:/Users/Aaron
//               Wubshet/Desktop/FinalProjectContainer/FinalProject/FinalProject.srcs/sources_1/ip/filter_input_buffer/filter_input_buffer_stub.v}
// Design      : filter_input_buffer
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a100tcsg324-3
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "blk_mem_gen_v8_3_3,Vivado 2016.2" *)
module filter_input_buffer(clka, wea, addra, dina, douta)
/* synthesis syn_black_box black_box_pad_pin="clka,wea[0:0],addra[10:0],dina[7:0],douta[7:0]" */;
  input clka;
  input [0:0]wea;
  input [10:0]addra;
  input [7:0]dina;
  output [7:0]douta;
endmodule
