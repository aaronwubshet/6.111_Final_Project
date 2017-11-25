# 
# Synthesis run script generated by Vivado
# 

set_param xicom.use_bs_reader 1
set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000
create_project -in_memory -part xc7a100tcsg324-3

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_property webtalk.parent_dir C:/Users/Wings/Desktop/WingsFinalProject/WingsFinalProject.cache/wt [current_project]
set_property parent.project_path C:/Users/Wings/Desktop/WingsFinalProject/WingsFinalProject.xpr [current_project]
set_property XPM_LIBRARIES {XPM_CDC XPM_MEMORY} [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
add_files {{c:/Users/Wings/Desktop/6.111/MATLAB files/decahedral.coe}}
add_files -quiet c:/Users/Wings/Desktop/WingsFinalProject/WingsFinalProject.srcs/sources_1/ip/clk_wiz_0/clk_wiz_0.dcp
set_property used_in_implementation false [get_files c:/Users/Wings/Desktop/WingsFinalProject/WingsFinalProject.srcs/sources_1/ip/clk_wiz_0/clk_wiz_0.dcp]
add_files -quiet c:/Users/Wings/Desktop/WingsFinalProject/WingsFinalProject.srcs/sources_1/ip/xy_bin/xy_bin.dcp
set_property used_in_implementation false [get_files c:/Users/Wings/Desktop/WingsFinalProject/WingsFinalProject.srcs/sources_1/ip/xy_bin/xy_bin.dcp]
add_files -quiet c:/Users/Wings/Desktop/WingsFinalProject/WingsFinalProject.srcs/sources_1/ip/div_gen_0/div_gen_0.dcp
set_property used_in_implementation false [get_files c:/Users/Wings/Desktop/WingsFinalProject/WingsFinalProject.srcs/sources_1/ip/div_gen_0/div_gen_0.dcp]
read_verilog -library xil_defaultlib {
  C:/Users/Wings/Desktop/WingsFinalProject/WingsFinalProject.srcs/sources_1/imports/Wings/color_contour.v
  C:/Users/Wings/Desktop/WingsFinalProject/WingsFinalProject.srcs/sources_1/imports/Wings/edge_to_display.v
  C:/Users/Wings/Desktop/WingsFinalProject/WingsFinalProject.srcs/sources_1/imports/Wings/sd_controller.v
  C:/Users/Wings/Desktop/WingsFinalProject/WingsFinalProject.srcs/sources_1/imports/Wings/display_8hex.v
  C:/Users/Wings/Desktop/WingsFinalProject/WingsFinalProject.srcs/sources_1/imports/Wings/debug.v
}
foreach dcp [get_files -quiet -all *.dcp] {
  set_property used_in_implementation false $dcp
}
read_xdc C:/Users/Wings/Desktop/WingsFinalProject/WingsFinalProject.srcs/constrs_1/imports/6.111/Nexys4DDR_Master_lab4.xdc
set_property used_in_implementation false [get_files C:/Users/Wings/Desktop/WingsFinalProject/WingsFinalProject.srcs/constrs_1/imports/6.111/Nexys4DDR_Master_lab4.xdc]


synth_design -top debug -part xc7a100tcsg324-3


write_checkpoint -force -noxdef debug.dcp

catch { report_utilization -file debug_utilization_synth.rpt -pb debug_utilization_synth.pb }
