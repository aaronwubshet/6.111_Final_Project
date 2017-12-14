# 
# Synthesis run script generated by Vivado
# 

set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000
create_project -in_memory -part xc7a100tcsg324-3

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_msg_config -source 4 -id {IP_Flow 19-2162} -severity warning -new_severity info
set_property webtalk.parent_dir {C:/Users/Aaron Wubshet/Desktop/6.111_Final_Project/FinalProjectContainer/FinalProject/FinalProject.cache/wt} [current_project]
set_property parent.project_path {C:/Users/Aaron Wubshet/Desktop/6.111_Final_Project/FinalProjectContainer/FinalProject/FinalProject.xpr} [current_project]
set_property XPM_LIBRARIES {XPM_CDC XPM_MEMORY} [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
read_ip -quiet {{C:/Users/Aaron Wubshet/Desktop/6.111_Final_Project/FinalProjectContainer/FinalProject/FinalProject.srcs/sources_1/ip/frame_buffer/frame_buffer.xci}}
set_property is_locked true [get_files {{C:/Users/Aaron Wubshet/Desktop/6.111_Final_Project/FinalProjectContainer/FinalProject/FinalProject.srcs/sources_1/ip/frame_buffer/frame_buffer.xci}}]

foreach dcp [get_files -quiet -all *.dcp] {
  set_property used_in_implementation false $dcp
}
read_xdc dont_touch.xdc
set_property used_in_implementation false [get_files dont_touch.xdc]

synth_design -top frame_buffer -part xc7a100tcsg324-3 -mode out_of_context

rename_ref -prefix_all frame_buffer_

write_checkpoint -force -noxdef frame_buffer.dcp

catch { report_utilization -file frame_buffer_utilization_synth.rpt -pb frame_buffer_utilization_synth.pb }

if { [catch {
  file copy -force {C:/Users/Aaron Wubshet/Desktop/6.111_Final_Project/FinalProjectContainer/FinalProject/FinalProject.runs/frame_buffer_synth_1/frame_buffer.dcp} {C:/Users/Aaron Wubshet/Desktop/6.111_Final_Project/FinalProjectContainer/FinalProject/FinalProject.srcs/sources_1/ip/frame_buffer/frame_buffer.dcp}
} _RESULT ] } { 
  send_msg_id runtcl-3 error "ERROR: Unable to successfully create or copy the sub-design checkpoint file."
  error "ERROR: Unable to successfully create or copy the sub-design checkpoint file."
}

if { [catch {
  write_verilog -force -mode synth_stub {C:/Users/Aaron Wubshet/Desktop/6.111_Final_Project/FinalProjectContainer/FinalProject/FinalProject.srcs/sources_1/ip/frame_buffer/frame_buffer_stub.v}
} _RESULT ] } { 
  puts "CRITICAL WARNING: Unable to successfully create a Verilog synthesis stub for the sub-design. This may lead to errors in top level synthesis of the design. Error reported: $_RESULT"
}

if { [catch {
  write_vhdl -force -mode synth_stub {C:/Users/Aaron Wubshet/Desktop/6.111_Final_Project/FinalProjectContainer/FinalProject/FinalProject.srcs/sources_1/ip/frame_buffer/frame_buffer_stub.vhdl}
} _RESULT ] } { 
  puts "CRITICAL WARNING: Unable to successfully create a VHDL synthesis stub for the sub-design. This may lead to errors in top level synthesis of the design. Error reported: $_RESULT"
}

if { [catch {
  write_verilog -force -mode funcsim {C:/Users/Aaron Wubshet/Desktop/6.111_Final_Project/FinalProjectContainer/FinalProject/FinalProject.srcs/sources_1/ip/frame_buffer/frame_buffer_sim_netlist.v}
} _RESULT ] } { 
  puts "CRITICAL WARNING: Unable to successfully create the Verilog functional simulation sub-design file. Post-Synthesis Functional Simulation with this file may not be possible or may give incorrect results. Error reported: $_RESULT"
}

if { [catch {
  write_vhdl -force -mode funcsim {C:/Users/Aaron Wubshet/Desktop/6.111_Final_Project/FinalProjectContainer/FinalProject/FinalProject.srcs/sources_1/ip/frame_buffer/frame_buffer_sim_netlist.vhdl}
} _RESULT ] } { 
  puts "CRITICAL WARNING: Unable to successfully create the VHDL functional simulation sub-design file. Post-Synthesis Functional Simulation with this file may not be possible or may give incorrect results. Error reported: $_RESULT"
}

if {[file isdir {C:/Users/Aaron Wubshet/Desktop/6.111_Final_Project/FinalProjectContainer/FinalProject/FinalProject.ip_user_files/ip/frame_buffer}]} {
  catch { 
    file copy -force {{C:/Users/Aaron Wubshet/Desktop/6.111_Final_Project/FinalProjectContainer/FinalProject/FinalProject.srcs/sources_1/ip/frame_buffer/frame_buffer_stub.v}} {C:/Users/Aaron Wubshet/Desktop/6.111_Final_Project/FinalProjectContainer/FinalProject/FinalProject.ip_user_files/ip/frame_buffer}
  }
}

if {[file isdir {C:/Users/Aaron Wubshet/Desktop/6.111_Final_Project/FinalProjectContainer/FinalProject/FinalProject.ip_user_files/ip/frame_buffer}]} {
  catch { 
    file copy -force {{C:/Users/Aaron Wubshet/Desktop/6.111_Final_Project/FinalProjectContainer/FinalProject/FinalProject.srcs/sources_1/ip/frame_buffer/frame_buffer_stub.vhdl}} {C:/Users/Aaron Wubshet/Desktop/6.111_Final_Project/FinalProjectContainer/FinalProject/FinalProject.ip_user_files/ip/frame_buffer}
  }
}
