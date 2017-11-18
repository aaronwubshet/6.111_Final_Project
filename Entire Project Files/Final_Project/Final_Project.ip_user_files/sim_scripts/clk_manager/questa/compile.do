vlib work
vlib msim

vlib msim/xil_defaultlib
vlib msim/xpm

vmap xil_defaultlib msim/xil_defaultlib
vmap xpm msim/xpm

vlog -work xil_defaultlib -64 -sv "+incdir+../../../ipstatic/clk_wiz_v5_3_1" "+incdir+../../../ipstatic/Aaron Wubshet/Desktop/new_folder/Final_Project/Final_Project.srcs/sources_1/ip/clk_manager/clk_wiz_v5_3_1" "+incdir+../../../ipstatic/clk_wiz_v5_3_1" "+incdir+../../../ipstatic/Aaron Wubshet/Desktop/new_folder/Final_Project/Final_Project.srcs/sources_1/ip/clk_manager/clk_wiz_v5_3_1" \
"C:/Xilinx/Vivado/2016.2/data/ip/xpm/xpm_memory/hdl/xpm_memory_base.sv" \
"C:/Xilinx/Vivado/2016.2/data/ip/xpm/xpm_memory/hdl/xpm_memory_dpdistram.sv" \
"C:/Xilinx/Vivado/2016.2/data/ip/xpm/xpm_memory/hdl/xpm_memory_dprom.sv" \
"C:/Xilinx/Vivado/2016.2/data/ip/xpm/xpm_memory/hdl/xpm_memory_sdpram.sv" \
"C:/Xilinx/Vivado/2016.2/data/ip/xpm/xpm_memory/hdl/xpm_memory_spram.sv" \
"C:/Xilinx/Vivado/2016.2/data/ip/xpm/xpm_memory/hdl/xpm_memory_sprom.sv" \
"C:/Xilinx/Vivado/2016.2/data/ip/xpm/xpm_memory/hdl/xpm_memory_tdpram.sv" \

vcom -work xpm -64 \
"C:/Xilinx/Vivado/2016.2/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work xil_defaultlib -64 "+incdir+../../../ipstatic/clk_wiz_v5_3_1" "+incdir+../../../ipstatic/Aaron Wubshet/Desktop/new_folder/Final_Project/Final_Project.srcs/sources_1/ip/clk_manager/clk_wiz_v5_3_1" "+incdir+../../../ipstatic/clk_wiz_v5_3_1" "+incdir+../../../ipstatic/Aaron Wubshet/Desktop/new_folder/Final_Project/Final_Project.srcs/sources_1/ip/clk_manager/clk_wiz_v5_3_1" \
"../../../../Final_Project.srcs/sources_1/ip/clk_manager/clk_manager_clk_wiz.v" \
"../../../../Final_Project.srcs/sources_1/ip/clk_manager/clk_manager.v" \

vlog -work xil_defaultlib "glbl.v"

