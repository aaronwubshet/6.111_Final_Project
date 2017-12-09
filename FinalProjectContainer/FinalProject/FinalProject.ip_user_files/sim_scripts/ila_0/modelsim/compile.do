vlib work
vlib msim

vlib msim/xil_defaultlib
vlib msim/xpm

vmap xil_defaultlib msim/xil_defaultlib
vmap xpm msim/xpm

vlog -work xil_defaultlib -64 -incr -sv "+incdir+../../../../FinalProject.srcs/sources_1/ip/ila_0/ila_v6_1_1/hdl/verilog" "+incdir+../../../../FinalProject.srcs/sources_1/ip/ila_0/ltlib_v1_0_0/hdl/verilog" "+incdir+../../../../FinalProject.srcs/sources_1/ip/ila_0/xsdbm_v1_1_3/hdl/verilog" "+incdir+../../../../FinalProject.srcs/sources_1/ip/ila_0/xsdbs_v1_0_2/hdl/verilog" "+incdir+../../../../FinalProject.srcs/sources_1/ip/ila_0/ila_v6_1_1/hdl/verilog" "+incdir+../../../../FinalProject.srcs/sources_1/ip/ila_0/ltlib_v1_0_0/hdl/verilog" "+incdir+../../../../FinalProject.srcs/sources_1/ip/ila_0/xsdbm_v1_1_3/hdl/verilog" "+incdir+../../../../FinalProject.srcs/sources_1/ip/ila_0/xsdbs_v1_0_2/hdl/verilog" \
"C:/Xilinx/Vivado/2016.2/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
"C:/Xilinx/Vivado/2016.2/data/ip/xpm/xpm_memory/hdl/xpm_memory_base.sv" \
"C:/Xilinx/Vivado/2016.2/data/ip/xpm/xpm_memory/hdl/xpm_memory_dpdistram.sv" \
"C:/Xilinx/Vivado/2016.2/data/ip/xpm/xpm_memory/hdl/xpm_memory_dprom.sv" \
"C:/Xilinx/Vivado/2016.2/data/ip/xpm/xpm_memory/hdl/xpm_memory_sdpram.sv" \
"C:/Xilinx/Vivado/2016.2/data/ip/xpm/xpm_memory/hdl/xpm_memory_spram.sv" \
"C:/Xilinx/Vivado/2016.2/data/ip/xpm/xpm_memory/hdl/xpm_memory_sprom.sv" \
"C:/Xilinx/Vivado/2016.2/data/ip/xpm/xpm_memory/hdl/xpm_memory_tdpram.sv" \

vcom -work xpm -64 -93 \
"C:/Xilinx/Vivado/2016.2/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work xil_defaultlib -64 -incr "+incdir+../../../../FinalProject.srcs/sources_1/ip/ila_0/ila_v6_1_1/hdl/verilog" "+incdir+../../../../FinalProject.srcs/sources_1/ip/ila_0/ltlib_v1_0_0/hdl/verilog" "+incdir+../../../../FinalProject.srcs/sources_1/ip/ila_0/xsdbm_v1_1_3/hdl/verilog" "+incdir+../../../../FinalProject.srcs/sources_1/ip/ila_0/xsdbs_v1_0_2/hdl/verilog" "+incdir+../../../../FinalProject.srcs/sources_1/ip/ila_0/ila_v6_1_1/hdl/verilog" "+incdir+../../../../FinalProject.srcs/sources_1/ip/ila_0/ltlib_v1_0_0/hdl/verilog" "+incdir+../../../../FinalProject.srcs/sources_1/ip/ila_0/xsdbm_v1_1_3/hdl/verilog" "+incdir+../../../../FinalProject.srcs/sources_1/ip/ila_0/xsdbs_v1_0_2/hdl/verilog" \
"../../../../FinalProject.srcs/sources_1/ip/ila_0/sim/ila_0.v" \

vlog -work xil_defaultlib "glbl.v"

