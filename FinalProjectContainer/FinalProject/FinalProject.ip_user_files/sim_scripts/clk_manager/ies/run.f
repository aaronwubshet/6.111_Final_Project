-makelib ies/xil_defaultlib -sv \
  "/var/local/xilinx-local/Vivado/2016.2/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
-endlib
-makelib ies/xpm \
  "/var/local/xilinx-local/Vivado/2016.2/data/ip/xpm/xpm_VCOMP.vhd" \
-endlib
-makelib ies/xil_defaultlib \
  "../../../../FinalProject.srcs/sources_1/ip/clk_manager/clk_manager_clk_wiz.v" \
  "../../../../FinalProject.srcs/sources_1/ip/clk_manager/clk_manager.v" \
-endlib
-makelib ies/xil_defaultlib \
  glbl.v
-endlib

