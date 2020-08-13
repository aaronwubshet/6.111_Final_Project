// Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2016.2 (lin64) Build 1577090 Thu Jun  2 16:32:35 MDT 2016
// Date        : Sun Dec 10 11:32:32 2017
// Host        : eecs-digital-13 running 64-bit Ubuntu 14.04.5 LTS
// Command     : write_verilog -force -mode synth_stub
//               /afs/athena.mit.edu/user/a/w/awubshet/Desktop/FinalProjectContainer/FinalProject/FinalProject.srcs/sources_1/ip/bram_fft_output_buffer/bram_fft_output_buffer_stub.v
// Design      : bram_fft_output_buffer
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a100tcsg324-3
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "blk_mem_gen_v8_3_3,Vivado 2016.2" *)
module bram_fft_output_buffer(clka, wea, addra, dina, douta, clkb, web, addrb, dinb, doutb)
/* synthesis syn_black_box black_box_pad_pin="clka,wea[0:0],addra[9:0],dina[15:0],douta[15:0],clkb,web[0:0],addrb[9:0],dinb[15:0],doutb[15:0]" */;
  input clka;
  input [0:0]wea;
  input [9:0]addra;
  input [15:0]dina;
  output [15:0]douta;
  input clkb;
  input [0:0]web;
  input [9:0]addrb;
  input [15:0]dinb;
  output [15:0]doutb;
endmodule
