vlib work
vlib activehdl

vlib activehdl/xil_defaultlib
vlib activehdl/xpm

vmap xil_defaultlib activehdl/xil_defaultlib
vmap xpm activehdl/xpm

vlog -work xil_defaultlib -v2k5 -sv "+incdir+../../../ipstatic/clk_wiz_v5_3_1" "+incdir+../../../ipstatic/Aaron Wubshet/Desktop/FinalProjectContainer/FinalProject/FinalProject.srcs/sources_1/ip/clk_manager/clk_wiz_v5_3_1" "+incdir+../../../ipstatic/clk_wiz_v5_3_1" "+incdir+../../../ipstatic/Aaron Wubshet/Desktop/FinalProjectContainer/FinalProject/FinalProject.srcs/sources_1/ip/clk_manager/clk_wiz_v5_3_1" \
"C:/Xilinx/Vivado/2016.2/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
"C:/Xilinx/Vivado/2016.2/data/ip/xpm/xpm_memory/hdl/xpm_memory_base.sv" \
"C:/Xilinx/Vivado/2016.2/data/ip/xpm/xpm_memory/hdl/xpm_memory_dpdistram.sv" \
"C:/Xilinx/Vivado/2016.2/data/ip/xpm/xpm_memory/hdl/xpm_memory_dprom.sv" \
"C:/Xilinx/Vivado/2016.2/data/ip/xpm/xpm_memory/hdl/xpm_memory_sdpram.sv" \
"C:/Xilinx/Vivado/2016.2/data/ip/xpm/xpm_memory/hdl/xpm_memory_spram.sv" \
"C:/Xilinx/Vivado/2016.2/data/ip/xpm/xpm_memory/hdl/xpm_memory_sprom.sv" \
"C:/Xilinx/Vivado/2016.2/data/ip/xpm/xpm_memory/hdl/xpm_memory_tdpram.sv" \

vcom -work xpm -93 \
"C:/Xilinx/Vivado/2016.2/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work xil_defaultlib -v2k5 "+incdir+../../../ipstatic/clk_wiz_v5_3_1" "+incdir+../../../ipstatic/Aaron Wubshet/Desktop/FinalProjectContainer/FinalProject/FinalProject.srcs/sources_1/ip/clk_manager/clk_wiz_v5_3_1" "+incdir+../../../ipstatic/clk_wiz_v5_3_1" "+incdir+../../../ipstatic/Aaron Wubshet/Desktop/FinalProjectContainer/FinalProject/FinalProject.srcs/sources_1/ip/clk_manager/clk_wiz_v5_3_1" \
"../../../../FinalProject.srcs/sources_1/ip/clk_manager/clk_manager_clk_wiz.v" \
"../../../../FinalProject.srcs/sources_1/ip/clk_manager/clk_manager.v" \

vlog -work xil_defaultlib "glbl.v"

