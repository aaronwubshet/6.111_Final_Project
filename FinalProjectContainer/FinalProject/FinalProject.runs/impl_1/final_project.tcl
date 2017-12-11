proc start_step { step } {
  set stopFile ".stop.rst"
  if {[file isfile .stop.rst]} {
    puts ""
    puts "*** Halting run - EA reset detected ***"
    puts ""
    puts ""
    return -code error
  }
  set beginFile ".$step.begin.rst"
  set platform "$::tcl_platform(platform)"
  set user "$::tcl_platform(user)"
  set pid [pid]
  set host ""
  if { [string equal $platform unix] } {
    if { [info exist ::env(HOSTNAME)] } {
      set host $::env(HOSTNAME)
    }
  } else {
    if { [info exist ::env(COMPUTERNAME)] } {
      set host $::env(COMPUTERNAME)
    }
  }
  set ch [open $beginFile w]
  puts $ch "<?xml version=\"1.0\"?>"
  puts $ch "<ProcessHandle Version=\"1\" Minor=\"0\">"
  puts $ch "    <Process Command=\".planAhead.\" Owner=\"$user\" Host=\"$host\" Pid=\"$pid\">"
  puts $ch "    </Process>"
  puts $ch "</ProcessHandle>"
  close $ch
}

proc end_step { step } {
  set endFile ".$step.end.rst"
  set ch [open $endFile w]
  close $ch
}

proc step_failed { step } {
  set endFile ".$step.error.rst"
  set ch [open $endFile w]
  close $ch
}

set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000

start_step init_design
set rc [catch {
  create_msg_db init_design.pb
  set_param xicom.use_bs_reader 1
  set_property design_mode GateLvl [current_fileset]
  set_param project.singleFileAddWarning.threshold 0
  set_property webtalk.parent_dir /afs/athena.mit.edu/user/j/u/julianch/final_project_debug/FinalProject/FinalProject.cache/wt [current_project]
  set_property parent.project_path /afs/athena.mit.edu/user/j/u/julianch/final_project_debug/FinalProject/FinalProject.xpr [current_project]
  set_property ip_repo_paths /afs/athena.mit.edu/user/j/u/julianch/final_project_debug/FinalProject/FinalProject.cache/ip [current_project]
  set_property ip_output_repo /afs/athena.mit.edu/user/j/u/julianch/final_project_debug/FinalProject/FinalProject.cache/ip [current_project]
  set_property XPM_LIBRARIES {XPM_CDC XPM_MEMORY} [current_project]
  add_files -quiet /afs/athena.mit.edu/user/j/u/julianch/final_project_debug/FinalProject/FinalProject.runs/synth_1/final_project.dcp
  add_files -quiet /afs/athena.mit.edu/user/j/u/julianch/final_project_debug/sources/ip/fft_mag_axis_register_slice_2_0/fft_mag_axis_register_slice_2_0.dcp
  set_property netlist_only true [get_files /afs/athena.mit.edu/user/j/u/julianch/final_project_debug/sources/ip/fft_mag_axis_register_slice_2_0/fft_mag_axis_register_slice_2_0.dcp]
  add_files -quiet /afs/athena.mit.edu/user/j/u/julianch/final_project_debug/sources/ip/fft_mag_c_addsub_0_0/fft_mag_c_addsub_0_0.dcp
  set_property netlist_only true [get_files /afs/athena.mit.edu/user/j/u/julianch/final_project_debug/sources/ip/fft_mag_c_addsub_0_0/fft_mag_c_addsub_0_0.dcp]
  add_files -quiet /afs/athena.mit.edu/user/j/u/julianch/final_project_debug/sources/ip/fft_mag_cordic_0_0/fft_mag_cordic_0_0.dcp
  set_property netlist_only true [get_files /afs/athena.mit.edu/user/j/u/julianch/final_project_debug/sources/ip/fft_mag_cordic_0_0/fft_mag_cordic_0_0.dcp]
  add_files -quiet /afs/athena.mit.edu/user/j/u/julianch/final_project_debug/sources/ip/fft_mag_mult_gen_0_0/fft_mag_mult_gen_0_0.dcp
  set_property netlist_only true [get_files /afs/athena.mit.edu/user/j/u/julianch/final_project_debug/sources/ip/fft_mag_mult_gen_0_0/fft_mag_mult_gen_0_0.dcp]
  add_files -quiet /afs/athena.mit.edu/user/j/u/julianch/final_project_debug/sources/ip/fft_mag_mult_gen_1_0/fft_mag_mult_gen_1_0.dcp
  set_property netlist_only true [get_files /afs/athena.mit.edu/user/j/u/julianch/final_project_debug/sources/ip/fft_mag_mult_gen_1_0/fft_mag_mult_gen_1_0.dcp]
  add_files -quiet /afs/athena.mit.edu/user/j/u/julianch/final_project_debug/sources/ip/fft_mag_xfft_0_0/fft_mag_xfft_0_0.dcp
  set_property netlist_only true [get_files /afs/athena.mit.edu/user/j/u/julianch/final_project_debug/sources/ip/fft_mag_xfft_0_0/fft_mag_xfft_0_0.dcp]
  add_files -quiet /afs/athena.mit.edu/user/j/u/julianch/final_project_debug/sources/ip/fft_mag_xlconstant_0_0/fft_mag_xlconstant_0_0.dcp
  set_property netlist_only true [get_files /afs/athena.mit.edu/user/j/u/julianch/final_project_debug/sources/ip/fft_mag_xlconstant_0_0/fft_mag_xlconstant_0_0.dcp]
  add_files -quiet /afs/athena.mit.edu/user/j/u/julianch/final_project_debug/sources/ip/fft_mag_xlconstant_1_0/fft_mag_xlconstant_1_0.dcp
  set_property netlist_only true [get_files /afs/athena.mit.edu/user/j/u/julianch/final_project_debug/sources/ip/fft_mag_xlconstant_1_0/fft_mag_xlconstant_1_0.dcp]
  add_files -quiet /afs/athena.mit.edu/user/j/u/julianch/final_project_debug/sources/ip/fft_mag_xlconstant_2_0/fft_mag_xlconstant_2_0.dcp
  set_property netlist_only true [get_files /afs/athena.mit.edu/user/j/u/julianch/final_project_debug/sources/ip/fft_mag_xlconstant_2_0/fft_mag_xlconstant_2_0.dcp]
  add_files -quiet /afs/athena.mit.edu/user/j/u/julianch/final_project_debug/sources/ip/fft_mag_xlslice_0_0/fft_mag_xlslice_0_0.dcp
  set_property netlist_only true [get_files /afs/athena.mit.edu/user/j/u/julianch/final_project_debug/sources/ip/fft_mag_xlslice_0_0/fft_mag_xlslice_0_0.dcp]
  add_files -quiet /afs/athena.mit.edu/user/j/u/julianch/final_project_debug/sources/ip/fft_mag_xlslice_1_0/fft_mag_xlslice_1_0.dcp
  set_property netlist_only true [get_files /afs/athena.mit.edu/user/j/u/julianch/final_project_debug/sources/ip/fft_mag_xlslice_1_0/fft_mag_xlslice_1_0.dcp]
  add_files -quiet /afs/athena.mit.edu/user/j/u/julianch/final_project_debug/sources/ip/fft_mag_xlconcat_0_0/fft_mag_xlconcat_0_0.dcp
  set_property netlist_only true [get_files /afs/athena.mit.edu/user/j/u/julianch/final_project_debug/sources/ip/fft_mag_xlconcat_0_0/fft_mag_xlconcat_0_0.dcp]
  add_files -quiet /afs/athena.mit.edu/user/j/u/julianch/final_project_debug/sources/ip/fft_mag_xlconstant_3_0/fft_mag_xlconstant_3_0.dcp
  set_property netlist_only true [get_files /afs/athena.mit.edu/user/j/u/julianch/final_project_debug/sources/ip/fft_mag_xlconstant_3_0/fft_mag_xlconstant_3_0.dcp]
  add_files -quiet /afs/athena.mit.edu/user/j/u/julianch/final_project_debug/FinalProject/FinalProject.srcs/sources_1/ip/clk_manager/clk_manager.dcp
  set_property netlist_only true [get_files /afs/athena.mit.edu/user/j/u/julianch/final_project_debug/FinalProject/FinalProject.srcs/sources_1/ip/clk_manager/clk_manager.dcp]
  add_files -quiet /afs/athena.mit.edu/user/j/u/julianch/final_project_debug/FinalProject/FinalProject.srcs/sources_1/ip/frame_buffer/frame_buffer.dcp
  set_property netlist_only true [get_files /afs/athena.mit.edu/user/j/u/julianch/final_project_debug/FinalProject/FinalProject.srcs/sources_1/ip/frame_buffer/frame_buffer.dcp]
  add_files -quiet /afs/athena.mit.edu/user/j/u/julianch/final_project_debug/FinalProject/FinalProject.srcs/sources_1/ip/xy_bin/xy_bin.dcp
  set_property netlist_only true [get_files /afs/athena.mit.edu/user/j/u/julianch/final_project_debug/FinalProject/FinalProject.srcs/sources_1/ip/xy_bin/xy_bin.dcp]
  add_files -quiet /afs/athena.mit.edu/user/j/u/julianch/final_project_debug/FinalProject/FinalProject.srcs/sources_1/ip/bram_fft_output_buffer/bram_fft_output_buffer.dcp
  set_property netlist_only true [get_files /afs/athena.mit.edu/user/j/u/julianch/final_project_debug/FinalProject/FinalProject.srcs/sources_1/ip/bram_fft_output_buffer/bram_fft_output_buffer.dcp]
  add_files -quiet /afs/athena.mit.edu/user/j/u/julianch/final_project_debug/FinalProject/FinalProject.srcs/sources_1/ip/div_gen_0/div_gen_0.dcp
  set_property netlist_only true [get_files /afs/athena.mit.edu/user/j/u/julianch/final_project_debug/FinalProject/FinalProject.srcs/sources_1/ip/div_gen_0/div_gen_0.dcp]
  add_files -quiet /afs/athena.mit.edu/user/j/u/julianch/final_project_debug/FinalProject/FinalProject.srcs/sources_1/ip/filter_input_buffer/filter_input_buffer.dcp
  set_property netlist_only true [get_files /afs/athena.mit.edu/user/j/u/julianch/final_project_debug/FinalProject/FinalProject.srcs/sources_1/ip/filter_input_buffer/filter_input_buffer.dcp]
  add_files -quiet /afs/athena.mit.edu/user/j/u/julianch/final_project_debug/FinalProject/FinalProject.srcs/sources_1/ip/ila_0/ila_0.dcp
  set_property netlist_only true [get_files /afs/athena.mit.edu/user/j/u/julianch/final_project_debug/FinalProject/FinalProject.srcs/sources_1/ip/ila_0/ila_0.dcp]
  read_xdc -mode out_of_context -ref clk_manager -cells inst /afs/athena.mit.edu/user/j/u/julianch/final_project_debug/FinalProject/FinalProject.srcs/sources_1/ip/clk_manager/clk_manager_ooc.xdc
  set_property processing_order EARLY [get_files /afs/athena.mit.edu/user/j/u/julianch/final_project_debug/FinalProject/FinalProject.srcs/sources_1/ip/clk_manager/clk_manager_ooc.xdc]
  read_xdc -prop_thru_buffers -ref clk_manager -cells inst /afs/athena.mit.edu/user/j/u/julianch/final_project_debug/FinalProject/FinalProject.srcs/sources_1/ip/clk_manager/clk_manager_board.xdc
  set_property processing_order EARLY [get_files /afs/athena.mit.edu/user/j/u/julianch/final_project_debug/FinalProject/FinalProject.srcs/sources_1/ip/clk_manager/clk_manager_board.xdc]
  read_xdc -ref clk_manager -cells inst /afs/athena.mit.edu/user/j/u/julianch/final_project_debug/FinalProject/FinalProject.srcs/sources_1/ip/clk_manager/clk_manager.xdc
  set_property processing_order EARLY [get_files /afs/athena.mit.edu/user/j/u/julianch/final_project_debug/FinalProject/FinalProject.srcs/sources_1/ip/clk_manager/clk_manager.xdc]
  read_xdc -mode out_of_context -ref frame_buffer -cells U0 /afs/athena.mit.edu/user/j/u/julianch/final_project_debug/FinalProject/FinalProject.srcs/sources_1/ip/frame_buffer/frame_buffer_ooc.xdc
  set_property processing_order EARLY [get_files /afs/athena.mit.edu/user/j/u/julianch/final_project_debug/FinalProject/FinalProject.srcs/sources_1/ip/frame_buffer/frame_buffer_ooc.xdc]
  read_xdc -mode out_of_context -ref xy_bin -cells U0 /afs/athena.mit.edu/user/j/u/julianch/final_project_debug/FinalProject/FinalProject.srcs/sources_1/ip/xy_bin/xy_bin_ooc.xdc
  set_property processing_order EARLY [get_files /afs/athena.mit.edu/user/j/u/julianch/final_project_debug/FinalProject/FinalProject.srcs/sources_1/ip/xy_bin/xy_bin_ooc.xdc]
  read_xdc -mode out_of_context -ref bram_fft_output_buffer -cells U0 /afs/athena.mit.edu/user/j/u/julianch/final_project_debug/FinalProject/FinalProject.srcs/sources_1/ip/bram_fft_output_buffer/bram_fft_output_buffer_ooc.xdc
  set_property processing_order EARLY [get_files /afs/athena.mit.edu/user/j/u/julianch/final_project_debug/FinalProject/FinalProject.srcs/sources_1/ip/bram_fft_output_buffer/bram_fft_output_buffer_ooc.xdc]
  read_xdc -mode out_of_context -ref div_gen_0 -cells U0 /afs/athena.mit.edu/user/j/u/julianch/final_project_debug/FinalProject/FinalProject.srcs/sources_1/ip/div_gen_0/div_gen_0_ooc.xdc
  set_property processing_order EARLY [get_files /afs/athena.mit.edu/user/j/u/julianch/final_project_debug/FinalProject/FinalProject.srcs/sources_1/ip/div_gen_0/div_gen_0_ooc.xdc]
  read_xdc -mode out_of_context -ref filter_input_buffer -cells U0 /afs/athena.mit.edu/user/j/u/julianch/final_project_debug/FinalProject/FinalProject.srcs/sources_1/ip/filter_input_buffer/filter_input_buffer_ooc.xdc
  set_property processing_order EARLY [get_files /afs/athena.mit.edu/user/j/u/julianch/final_project_debug/FinalProject/FinalProject.srcs/sources_1/ip/filter_input_buffer/filter_input_buffer_ooc.xdc]
  read_xdc -mode out_of_context -ref ila_0 -cells inst /afs/athena.mit.edu/user/j/u/julianch/final_project_debug/FinalProject/FinalProject.srcs/sources_1/ip/ila_0/ila_0_ooc.xdc
  set_property processing_order EARLY [get_files /afs/athena.mit.edu/user/j/u/julianch/final_project_debug/FinalProject/FinalProject.srcs/sources_1/ip/ila_0/ila_0_ooc.xdc]
  read_xdc -ref ila_0 -cells inst /afs/athena.mit.edu/user/j/u/julianch/final_project_debug/FinalProject/FinalProject.srcs/sources_1/ip/ila_0/ila_v6_1/constraints/ila.xdc
  set_property processing_order EARLY [get_files /afs/athena.mit.edu/user/j/u/julianch/final_project_debug/FinalProject/FinalProject.srcs/sources_1/ip/ila_0/ila_v6_1/constraints/ila.xdc]
  read_xdc /afs/athena.mit.edu/user/j/u/julianch/final_project_debug/sources/Constraints_Master.xdc
  link_design -top final_project -part xc7a100tcsg324-3
  write_hwdef -file final_project.hwdef
  close_msg_db -file init_design.pb
} RESULT]
if {$rc} {
  step_failed init_design
  return -code error $RESULT
} else {
  end_step init_design
}

start_step opt_design
set rc [catch {
  create_msg_db opt_design.pb
  opt_design 
  write_checkpoint -force final_project_opt.dcp
  report_drc -file final_project_drc_opted.rpt
  close_msg_db -file opt_design.pb
} RESULT]
if {$rc} {
  step_failed opt_design
  return -code error $RESULT
} else {
  end_step opt_design
}

start_step place_design
set rc [catch {
  create_msg_db place_design.pb
  implement_debug_core 
  place_design 
  write_checkpoint -force final_project_placed.dcp
  report_io -file final_project_io_placed.rpt
  report_utilization -file final_project_utilization_placed.rpt -pb final_project_utilization_placed.pb
  report_control_sets -verbose -file final_project_control_sets_placed.rpt
  close_msg_db -file place_design.pb
} RESULT]
if {$rc} {
  step_failed place_design
  return -code error $RESULT
} else {
  end_step place_design
}

start_step route_design
set rc [catch {
  create_msg_db route_design.pb
  route_design 
  write_checkpoint -force final_project_routed.dcp
  report_drc -file final_project_drc_routed.rpt -pb final_project_drc_routed.pb
  report_timing_summary -warn_on_violation -max_paths 10 -file final_project_timing_summary_routed.rpt -rpx final_project_timing_summary_routed.rpx
  report_power -file final_project_power_routed.rpt -pb final_project_power_summary_routed.pb -rpx final_project_power_routed.rpx
  report_route_status -file final_project_route_status.rpt -pb final_project_route_status.pb
  report_clock_utilization -file final_project_clock_utilization_routed.rpt
  close_msg_db -file route_design.pb
} RESULT]
if {$rc} {
  step_failed route_design
  return -code error $RESULT
} else {
  end_step route_design
}

start_step write_bitstream
set rc [catch {
  create_msg_db write_bitstream.pb
  catch { write_mem_info -force final_project.mmi }
  write_bitstream -force final_project.bit 
  catch { write_sysdef -hwdef final_project.hwdef -bitfile final_project.bit -meminfo final_project.mmi -file final_project.sysdef }
  catch {write_debug_probes -quiet -force debug_nets}
  close_msg_db -file write_bitstream.pb
} RESULT]
if {$rc} {
  step_failed write_bitstream
  return -code error $RESULT
} else {
  end_step write_bitstream
}

