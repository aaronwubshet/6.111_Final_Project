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
set_msg_config -source 4 -id {IP_Flow 19-2162} -severity warning -new_severity info
set_property webtalk.parent_dir {C:/Users/Aaron Wubshet/Desktop/FinalProjectContainer/FinalProject/FinalProject.cache/wt} [current_project]
set_property parent.project_path {C:/Users/Aaron Wubshet/Desktop/FinalProjectContainer/FinalProject/FinalProject.xpr} [current_project]
set_property XPM_LIBRARIES {XPM_CDC XPM_MEMORY} [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
add_files {{C:/Users/Aaron Wubshet/Desktop/FinalProjectContainer/sources/image_rgb.coe}}
add_files -quiet {{c:/Users/Aaron Wubshet/Desktop/FinalProjectContainer/FinalProject/FinalProject.srcs/sources_1/ip/clk_manager/clk_manager.dcp}}
set_property used_in_implementation false [get_files {{c:/Users/Aaron Wubshet/Desktop/FinalProjectContainer/FinalProject/FinalProject.srcs/sources_1/ip/clk_manager/clk_manager.dcp}}]
add_files -quiet {{c:/Users/Aaron Wubshet/Desktop/FinalProjectContainer/FinalProject/FinalProject.srcs/sources_1/ip/frame_buffer/frame_buffer.dcp}}
set_property used_in_implementation false [get_files {{c:/Users/Aaron Wubshet/Desktop/FinalProjectContainer/FinalProject/FinalProject.srcs/sources_1/ip/frame_buffer/frame_buffer.dcp}}]
add_files -quiet {{c:/Users/Aaron Wubshet/Desktop/FinalProjectContainer/FinalProject/FinalProject.srcs/sources_1/ip/xy_bin/xy_bin.dcp}}
set_property used_in_implementation false [get_files {{c:/Users/Aaron Wubshet/Desktop/FinalProjectContainer/FinalProject/FinalProject.srcs/sources_1/ip/xy_bin/xy_bin.dcp}}]
add_files -quiet {{c:/Users/Aaron Wubshet/Desktop/FinalProjectContainer/FinalProject/FinalProject.srcs/sources_1/ip/bram_fft_output_buffer/bram_fft_output_buffer.dcp}}
set_property used_in_implementation false [get_files {{c:/Users/Aaron Wubshet/Desktop/FinalProjectContainer/FinalProject/FinalProject.srcs/sources_1/ip/bram_fft_output_buffer/bram_fft_output_buffer.dcp}}]
add_files -quiet {{c:/Users/Aaron Wubshet/Desktop/FinalProjectContainer/FinalProject/FinalProject.srcs/sources_1/ip/div_gen_0/div_gen_0.dcp}}
set_property used_in_implementation false [get_files {{c:/Users/Aaron Wubshet/Desktop/FinalProjectContainer/FinalProject/FinalProject.srcs/sources_1/ip/div_gen_0/div_gen_0.dcp}}]
add_files -quiet {{c:/Users/Aaron Wubshet/Desktop/FinalProjectContainer/FinalProject/FinalProject.srcs/sources_1/ip/filter_input_buffer/filter_input_buffer.dcp}}
set_property used_in_implementation false [get_files {{c:/Users/Aaron Wubshet/Desktop/FinalProjectContainer/FinalProject/FinalProject.srcs/sources_1/ip/filter_input_buffer/filter_input_buffer.dcp}}]
add_files {{C:/Users/Aaron Wubshet/Desktop/FinalProjectContainer/sources/fft_mag.bd}}
set_property used_in_implementation false [get_files -all {{c:/Users/Aaron Wubshet/Desktop/FinalProjectContainer/sources/ip/fft_mag_axis_register_slice_2_0/fft_mag_axis_register_slice_2_0_ooc.xdc}}]
set_property used_in_implementation false [get_files -all {{c:/Users/Aaron Wubshet/Desktop/FinalProjectContainer/sources/ip/fft_mag_cordic_0_0/fft_mag_cordic_0_0_ooc.xdc}}]
set_property used_in_implementation false [get_files -all {{c:/Users/Aaron Wubshet/Desktop/FinalProjectContainer/sources/ip/fft_mag_mult_gen_0_0/fft_mag_mult_gen_0_0_ooc.xdc}}]
set_property used_in_implementation false [get_files -all {{c:/Users/Aaron Wubshet/Desktop/FinalProjectContainer/sources/ip/fft_mag_mult_gen_1_0/fft_mag_mult_gen_1_0_ooc.xdc}}]
set_property used_in_implementation false [get_files -all {{c:/Users/Aaron Wubshet/Desktop/FinalProjectContainer/sources/ip/fft_mag_xfft_0_0/fft_mag_xfft_0_0_ooc.xdc}}]
set_property used_in_implementation false [get_files -all {{C:/Users/Aaron Wubshet/Desktop/FinalProjectContainer/sources/fft_mag_ooc.xdc}}]
set_property is_locked true [get_files {{C:/Users/Aaron Wubshet/Desktop/FinalProjectContainer/sources/fft_mag.bd}}]

read_verilog -library xil_defaultlib {
  {C:/Users/Aaron Wubshet/Desktop/FinalProjectContainer/sources/lpf_coeffs.v}
  {C:/Users/Aaron Wubshet/Desktop/FinalProjectContainer/sources/hpf_coeffs.v}
  {C:/Users/Aaron Wubshet/Desktop/FinalProjectContainer/sources/fir31.v}
  {C:/Users/Aaron Wubshet/Desktop/FinalProjectContainer/sources/bpf2_coeffs.v}
  {C:/Users/Aaron Wubshet/Desktop/FinalProjectContainer/sources/bpf1_coeffs.v}
  {C:/Users/Aaron Wubshet/Desktop/FinalProjectContainer/FinalProject/FinalProject.srcs/sources_1/imports/sources/OV7670_config.v}
  {C:/Users/Aaron Wubshet/Desktop/FinalProjectContainer/FinalProject/FinalProject.srcs/sources_1/imports/sources/OV7670_config_rom.v}
  {C:/Users/Aaron Wubshet/Desktop/FinalProjectContainer/FinalProject/FinalProject.srcs/sources_1/imports/sources/SCCB_interface.v}
  {C:/Users/Aaron Wubshet/Desktop/FinalProjectContainer/sources/filter_control.v}
  {C:/Users/Aaron Wubshet/Desktop/FinalProjectContainer/sources/fifo.v}
  {C:/Users/Aaron Wubshet/Desktop/FinalProjectContainer/sources/clock_divider.v}
  {C:/Users/Aaron Wubshet/Desktop/FinalProjectContainer/sources/audio_PWM.v}
  {C:/Users/Aaron Wubshet/Desktop/FinalProjectContainer/sources/FFT_energy.v}
  {C:/Users/Aaron Wubshet/Desktop/FinalProjectContainer/sources/sobel.v}
  {C:/Users/Aaron Wubshet/Desktop/FinalProjectContainer/sources/one_edge.v}
  {C:/Users/Aaron Wubshet/Desktop/FinalProjectContainer/sources/lev_puls.v}
  {C:/Users/Aaron Wubshet/Desktop/FinalProjectContainer/sources/erosion.v}
  {C:/Users/Aaron Wubshet/Desktop/FinalProjectContainer/sources/Color_output.v}
  {C:/Users/Aaron Wubshet/Desktop/FinalProjectContainer/sources/Color_offst.v}
  {C:/Users/Aaron Wubshet/Desktop/FinalProjectContainer/sources/color_contour.v}
  {C:/Users/Aaron Wubshet/Desktop/FinalProjectContainer/FinalProject/FinalProject.srcs/sources_1/imports/sources/camera_address_gen.v}
  {C:/Users/Aaron Wubshet/Desktop/FinalProjectContainer/FinalProject/FinalProject.srcs/sources_1/imports/sources/camera_configure.v}
  {C:/Users/Aaron Wubshet/Desktop/FinalProjectContainer/FinalProject/FinalProject.srcs/sources_1/imports/sources/camera_read.v}
  {C:/Users/Aaron Wubshet/Desktop/FinalProjectContainer/FinalProject/FinalProject.srcs/sources_1/imports/sources/video_playback.v}
  {C:/Users/Aaron Wubshet/Desktop/FinalProjectContainer/sources/test.v}
  {C:/Users/Aaron Wubshet/Desktop/FinalProjectContainer/sources/sd_controller.v}
  {C:/Users/Aaron Wubshet/Desktop/FinalProjectContainer/sources/image_processing.v}
  {C:/Users/Aaron Wubshet/Desktop/FinalProjectContainer/sources/display_8hex.v}
  {C:/Users/Aaron Wubshet/Desktop/FinalProjectContainer/sources/debounce.v}
  {C:/Users/Aaron Wubshet/Desktop/FinalProjectContainer/sources/Color_transform.v}
  {C:/Users/Aaron Wubshet/Desktop/FinalProjectContainer/sources/final_project.v}
}
foreach dcp [get_files -quiet -all *.dcp] {
  set_property used_in_implementation false $dcp
}
read_xdc {{C:/Users/Aaron Wubshet/Desktop/FinalProjectContainer/sources/Constraints_Master.xdc}}
set_property used_in_implementation false [get_files {{C:/Users/Aaron Wubshet/Desktop/FinalProjectContainer/sources/Constraints_Master.xdc}}]

read_xdc dont_touch.xdc
set_property used_in_implementation false [get_files dont_touch.xdc]

synth_design -top final_project -part xc7a100tcsg324-3


write_checkpoint -force -noxdef final_project.dcp

catch { report_utilization -file final_project_utilization_synth.rpt -pb final_project_utilization_synth.pb }
