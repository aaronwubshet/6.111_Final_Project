// Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2016.2 (win64) Build 1577090 Thu Jun  2 16:32:40 MDT 2016
// Date        : Sun Dec 10 20:23:38 2017
// Host        : THINKPAD running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub {C:/Users/Aaron
//               Wubshet/Desktop/6.111_Final_Project/FinalProjectContainer/FinalProject/FinalProject.srcs/sources_1/ip/xy_bin/xy_bin_stub.v}
// Design      : xy_bin
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a100tcsg324-3
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "blk_mem_gen_v8_3_3,Vivado 2016.2" *)
module xy_bin(clka, wea, addra, dina, douta, clkb, web, addrb, dinb, doutb)
/* synthesis syn_black_box black_box_pad_pin="clka,wea[0:0],addra[18:0],dina[2:0],douta[2:0],clkb,web[0:0],addrb[18:0],dinb[2:0],doutb[2:0]" */;
  input clka;
  input [0:0]wea;
  input [18:0]addra;
  input [2:0]dina;
  output [2:0]douta;
  input clkb;
  input [0:0]web;
  input [18:0]addrb;
  input [2:0]dinb;
  output [2:0]doutb;
endmodule
