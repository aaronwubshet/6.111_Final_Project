
################################################################
# This is a generated script based on design: fft_mag
#
# Though there are limitations about the generated script,
# the main purpose of this utility is to make learning
# IP Integrator Tcl commands easier.
################################################################

namespace eval _tcl {
proc get_script_folder {} {
   set script_path [file normalize [info script]]
   set script_folder [file dirname $script_path]
   return $script_folder
}
}
variable script_folder
set script_folder [_tcl::get_script_folder]

################################################################
# Check if script is running in correct Vivado version.
################################################################
set scripts_vivado_version 2016.2
set current_vivado_version [version -short]

if { [string first $scripts_vivado_version $current_vivado_version] == -1 } {
   puts ""
   catch {common::send_msg_id "BD_TCL-109" "ERROR" "This script was generated using Vivado <$scripts_vivado_version> and is being run in <$current_vivado_version> of Vivado. Please run the script in Vivado <$scripts_vivado_version> then open the design in Vivado <$current_vivado_version>. Upgrade the design by running \"Tools => Report => Report IP Status...\", then run write_bd_tcl to create an updated script."}

   return 1
}

################################################################
# START
################################################################

# To test this script, run the following commands from Vivado Tcl console:
# source fft_mag_script.tcl

# If there is no project opened, this script will create a
# project, but make sure you do not have an existing project
# <./myproj/project_1.xpr> in the current working folder.

set list_projs [get_projects -quiet]
if { $list_projs eq "" } {
   create_project project_1 myproj -part xc7a100tcsg324-3
}


# CHANGE DESIGN NAME HERE
set design_name fft_mag

# This script was generated for a remote BD. To create a non-remote design,
# change the variable <run_remote_bd_flow> to <0>.

set run_remote_bd_flow 1
if { $run_remote_bd_flow == 1 } {
  set str_bd_folder C:/Users/Aaron Wubshet/Desktop/FinalProjectContainer/sources
  set str_bd_filepath ${str_bd_folder}/${design_name}.bd

  # Check if remote design exists on disk
  if { [file exists $str_bd_filepath ] == 1 } {
     catch {common::send_msg_id "BD_TCL-110" "ERROR" "The remote BD file path <$str_bd_filepath> already exists!"}
     common::send_msg_id "BD_TCL-008" "INFO" "To create a non-remote BD, change the variable <run_remote_bd_flow> to <0>."
     common::send_msg_id "BD_TCL-009" "INFO" "Also make sure there is no design <$design_name> existing in your current project."

     return 1
  }

  # Check if design exists in memory
  set list_existing_designs [get_bd_designs -quiet $design_name]
  if { $list_existing_designs ne "" } {
     catch {common::send_msg_id "BD_TCL-111" "ERROR" "The design <$design_name> already exists in this project! Will not create the remote BD <$design_name> at the folder <$str_bd_folder>."}

     common::send_msg_id "BD_TCL-010" "INFO" "To create a non-remote BD, change the variable <run_remote_bd_flow> to <0> or please set a different value to variable <design_name>."

     return 1
  }

  # Check if design exists on disk within project
  set list_existing_designs [get_files */${design_name}.bd]
  if { $list_existing_designs ne "" } {
     catch {common::send_msg_id "BD_TCL-112" "ERROR" "The design <$design_name> already exists in this project at location:
    $list_existing_designs"}
     catch {common::send_msg_id "BD_TCL-113" "ERROR" "Will not create the remote BD <$design_name> at the folder <$str_bd_folder>."}

     common::send_msg_id "BD_TCL-011" "INFO" "To create a non-remote BD, change the variable <run_remote_bd_flow> to <0> or please set a different value to variable <design_name>."

     return 1
  }

  # Now can create the remote BD
  create_bd_design -dir $str_bd_folder $design_name
} else {

  # Create regular design
  if { [catch {create_bd_design $design_name} errmsg] } {
     common::send_msg_id "BD_TCL-012" "INFO" "Please set a different value to variable <design_name>."

     return 1
  }
}

current_bd_design $design_name

##################################################################
# DESIGN PROCs
##################################################################



# Procedure to create entire design; Provide argument to make
# procedure reusable. If parentCell is "", will use root.
proc create_root_design { parentCell } {

  variable script_folder

  if { $parentCell eq "" } {
     set parentCell [get_bd_cells /]
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_msg_id "BD_TCL-100" "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_msg_id "BD_TCL-101" "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj


  # Create interface ports
  set frame [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 frame ]
  set_property -dict [ list \
CONFIG.HAS_TKEEP {0} \
CONFIG.HAS_TLAST {1} \
CONFIG.HAS_TREADY {1} \
CONFIG.HAS_TSTRB {0} \
CONFIG.LAYERED_METADATA {undef} \
CONFIG.TDATA_NUM_BYTES {2} \
CONFIG.TDEST_WIDTH {0} \
CONFIG.TID_WIDTH {0} \
CONFIG.TUSER_WIDTH {0} \
 ] $frame
  set magnitude [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 magnitude ]
  set_property -dict [ list \
CONFIG.FREQ_HZ {100000000} \
 ] $magnitude

  # Create ports
  set clk [ create_bd_port -dir I -type clk clk ]
  set_property -dict [ list \
CONFIG.ASSOCIATED_BUSIF {frame:magnitude} \
CONFIG.FREQ_HZ {100000000} \
 ] $clk
  set event_data_in_channel_halt [ create_bd_port -dir O -type intr event_data_in_channel_halt ]
  set event_data_out_channel_halt [ create_bd_port -dir O -type intr event_data_out_channel_halt ]
  set event_frame_started [ create_bd_port -dir O -type intr event_frame_started ]
  set event_status_channel_halt [ create_bd_port -dir O -type intr event_status_channel_halt ]
  set event_tlast_missing [ create_bd_port -dir O -type intr event_tlast_missing ]
  set event_tlast_unexpected [ create_bd_port -dir O -type intr event_tlast_unexpected ]

  # Create instance: axis_register_slice_2, and set properties
  set axis_register_slice_2 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_register_slice:1.1 axis_register_slice_2 ]
  set_property -dict [ list \
CONFIG.HAS_TLAST {1} \
CONFIG.HAS_TREADY {0} \
CONFIG.TDATA_NUM_BYTES {2} \
CONFIG.TUSER_WIDTH {10} \
 ] $axis_register_slice_2

  # Create instance: c_addsub_0, and set properties
  set c_addsub_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:c_addsub:12.0 c_addsub_0 ]
  set_property -dict [ list \
CONFIG.A_Width {16} \
CONFIG.B_Value {0000000000000000} \
CONFIG.B_Width {16} \
CONFIG.Latency {0} \
CONFIG.Out_Width {16} \
 ] $c_addsub_0

  # Create instance: cordic_0, and set properties
  set cordic_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:cordic:6.0 cordic_0 ]
  set_property -dict [ list \
CONFIG.Coarse_Rotation {false} \
CONFIG.Data_Format {UnsignedInteger} \
CONFIG.Functional_Selection {Square_Root} \
CONFIG.Input_Width {16} \
CONFIG.Output_Width {9} \
CONFIG.Round_Mode {Nearest_Even} \
CONFIG.cartesian_has_tlast {true} \
CONFIG.cartesian_has_tuser {true} \
CONFIG.cartesian_tuser_width {10} \
CONFIG.optimize_goal {Performance} \
CONFIG.out_tlast_behv {Pass_Cartesian_TLAST} \
 ] $cordic_0

  # Need to retain value_src of defaults
  set_property -dict [ list \
CONFIG.optimize_goal.VALUE_SRC {DEFAULT} \
 ] $cordic_0

  # Create instance: mult_gen_0, and set properties
  set mult_gen_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:mult_gen:12.0 mult_gen_0 ]
  set_property -dict [ list \
CONFIG.Multiplier_Construction {Use_Mults} \
CONFIG.OptGoal {Speed} \
CONFIG.PortAWidth {8} \
CONFIG.PortBWidth {8} \
 ] $mult_gen_0

  # Create instance: mult_gen_1, and set properties
  set mult_gen_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:mult_gen:12.0 mult_gen_1 ]
  set_property -dict [ list \
CONFIG.Multiplier_Construction {Use_Mults} \
CONFIG.PortAWidth {8} \
CONFIG.PortBWidth {8} \
CONFIG.Use_Custom_Output_Width {false} \
 ] $mult_gen_1

  # Create instance: xfft_0, and set properties
  set xfft_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xfft:9.0 xfft_0 ]
  set_property -dict [ list \
CONFIG.butterfly_type {use_luts} \
CONFIG.complex_mult_type {use_mults_resources} \
CONFIG.implementation_options {pipelined_streaming_io} \
CONFIG.input_width {8} \
CONFIG.memory_options_hybrid {false} \
CONFIG.number_of_stages_using_block_ram_for_data_and_phase_factors {1} \
CONFIG.phase_factor_width {8} \
CONFIG.rounding_modes {convergent_rounding} \
CONFIG.scaling_options {scaled} \
CONFIG.target_clock_frequency {100} \
CONFIG.transform_length {1024} \
CONFIG.xk_index {false} \
 ] $xfft_0

  # Create instance: xlconcat_0, and set properties
  set xlconcat_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 xlconcat_0 ]
  set_property -dict [ list \
CONFIG.NUM_PORTS {3} \
 ] $xlconcat_0

  # Create instance: xlconstant_0, and set properties
  set xlconstant_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 xlconstant_0 ]
  set_property -dict [ list \
CONFIG.CONST_VAL {0} \
 ] $xlconstant_0

  # Create instance: xlconstant_1, and set properties
  set xlconstant_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 xlconstant_1 ]
  set_property -dict [ list \
CONFIG.CONST_VAL {1} \
 ] $xlconstant_1

  # Create instance: xlconstant_2, and set properties
  set xlconstant_2 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 xlconstant_2 ]
  set_property -dict [ list \
CONFIG.CONST_VAL {0} \
CONFIG.CONST_WIDTH {3} \
 ] $xlconstant_2

  # Create instance: xlconstant_3, and set properties
  set xlconstant_3 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 xlconstant_3 ]
  set_property -dict [ list \
CONFIG.CONST_VAL {0} \
CONFIG.CONST_WIDTH {12} \
 ] $xlconstant_3

  # Create instance: xlslice_0, and set properties
  set xlslice_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 xlslice_0 ]
  set_property -dict [ list \
CONFIG.DIN_FROM {7} \
CONFIG.DIN_TO {0} \
CONFIG.DIN_WIDTH {16} \
CONFIG.DOUT_WIDTH {8} \
 ] $xlslice_0

  # Create instance: xlslice_1, and set properties
  set xlslice_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 xlslice_1 ]
  set_property -dict [ list \
CONFIG.DIN_FROM {15} \
CONFIG.DIN_TO {8} \
CONFIG.DIN_WIDTH {16} \
CONFIG.DOUT_WIDTH {8} \
 ] $xlslice_1

  # Create interface connections
  connect_bd_intf_net -intf_net cordic_0_M_AXIS_DOUT [get_bd_intf_ports magnitude] [get_bd_intf_pins cordic_0/M_AXIS_DOUT]
  connect_bd_intf_net -intf_net frame_1 [get_bd_intf_ports frame] [get_bd_intf_pins xfft_0/S_AXIS_DATA]
  connect_bd_intf_net -intf_net xfft_0_M_AXIS_DATA [get_bd_intf_pins axis_register_slice_2/S_AXIS] [get_bd_intf_pins xfft_0/M_AXIS_DATA]

  # Create port connections
  connect_bd_net -net axis_register_slice_2_m_axis_tlast [get_bd_pins axis_register_slice_2/m_axis_tlast] [get_bd_pins cordic_0/s_axis_cartesian_tlast]
  connect_bd_net -net axis_register_slice_2_m_axis_tuser [get_bd_pins axis_register_slice_2/m_axis_tuser] [get_bd_pins cordic_0/s_axis_cartesian_tuser]
  connect_bd_net -net axis_register_slice_2_m_axis_tvalid [get_bd_pins axis_register_slice_2/m_axis_tvalid] [get_bd_pins cordic_0/s_axis_cartesian_tvalid]
  connect_bd_net -net c_addsub_0_S [get_bd_pins c_addsub_0/S] [get_bd_pins cordic_0/s_axis_cartesian_tdata]
  connect_bd_net -net clk_1 [get_bd_ports clk] [get_bd_pins axis_register_slice_2/aclk] [get_bd_pins cordic_0/aclk] [get_bd_pins mult_gen_0/CLK] [get_bd_pins mult_gen_1/CLK] [get_bd_pins xfft_0/aclk]
  connect_bd_net -net mult_gen_0_P [get_bd_pins c_addsub_0/A] [get_bd_pins mult_gen_0/P]
  connect_bd_net -net mult_gen_1_P [get_bd_pins c_addsub_0/B] [get_bd_pins mult_gen_1/P]
  connect_bd_net -net xfft_0_event_data_in_channel_halt [get_bd_ports event_data_in_channel_halt] [get_bd_pins xfft_0/event_data_in_channel_halt]
  connect_bd_net -net xfft_0_event_data_out_channel_halt [get_bd_ports event_data_out_channel_halt] [get_bd_pins xfft_0/event_data_out_channel_halt]
  connect_bd_net -net xfft_0_event_frame_started [get_bd_ports event_frame_started] [get_bd_pins xfft_0/event_frame_started]
  connect_bd_net -net xfft_0_event_status_channel_halt [get_bd_ports event_status_channel_halt] [get_bd_pins xfft_0/event_status_channel_halt]
  connect_bd_net -net xfft_0_event_tlast_missing [get_bd_ports event_tlast_missing] [get_bd_pins xfft_0/event_tlast_missing]
  connect_bd_net -net xfft_0_event_tlast_unexpected [get_bd_ports event_tlast_unexpected] [get_bd_pins xfft_0/event_tlast_unexpected]
  connect_bd_net -net xfft_0_m_axis_data_tdata [get_bd_pins xfft_0/m_axis_data_tdata] [get_bd_pins xlslice_0/Din] [get_bd_pins xlslice_1/Din]
  connect_bd_net -net xlconcat_0_dout [get_bd_pins xfft_0/s_axis_config_tdata] [get_bd_pins xlconcat_0/dout]
  connect_bd_net -net xlconstant_0_dout [get_bd_pins axis_register_slice_2/aresetn] [get_bd_pins xlconstant_0/dout]
  connect_bd_net -net xlconstant_1_dout [get_bd_pins xfft_0/m_axis_data_tready] [get_bd_pins xfft_0/s_axis_config_tvalid] [get_bd_pins xlconcat_0/In2] [get_bd_pins xlconstant_1/dout]
  connect_bd_net -net xlconstant_2_dout [get_bd_pins xlconcat_0/In0] [get_bd_pins xlconstant_2/dout]
  connect_bd_net -net xlconstant_3_dout [get_bd_pins xlconcat_0/In1] [get_bd_pins xlconstant_3/dout]
  connect_bd_net -net xlslice_0_Dout [get_bd_pins mult_gen_0/A] [get_bd_pins mult_gen_0/B] [get_bd_pins xlslice_0/Dout]
  connect_bd_net -net xlslice_1_Dout [get_bd_pins mult_gen_1/A] [get_bd_pins mult_gen_1/B] [get_bd_pins xlslice_1/Dout]

  # Create address segments

  # Perform GUI Layout
  regenerate_bd_layout -layout_string {
   guistr: "# # String gsaved with Nlview 6.5.12  2016-01-29 bk=1.3547 VDI=39 GEI=35 GUI=JA:1.6
#  -string -flagsOSRD
preplace port event_status_channel_halt -pg 1 -y 460 -defaultsOSRD
preplace port event_data_in_channel_halt -pg 1 -y 420 -defaultsOSRD
preplace port event_tlast_unexpected -pg 1 -y 500 -defaultsOSRD
preplace port event_frame_started -pg 1 -y 240 -defaultsOSRD
preplace port frame -pg 1 -y 310 -defaultsOSRD
preplace port event_data_out_channel_halt -pg 1 -y 440 -defaultsOSRD
preplace port event_tlast_missing -pg 1 -y 480 -defaultsOSRD
preplace port clk -pg 1 -y 350 -defaultsOSRD
preplace port magnitude -pg 1 -y 340 -defaultsOSRD
preplace inst xlslice_0 -pg 1 -lvl 2 -y 80 -defaultsOSRD
preplace inst xlslice_1 -pg 1 -lvl 2 -y 200 -defaultsOSRD
preplace inst xlconstant_0 -pg 1 -lvl 3 -y 560 -defaultsOSRD
preplace inst xlconstant_1 -pg 1 -lvl 1 -y 660 -defaultsOSRD
preplace inst xlconstant_2 -pg 1 -lvl 1 -y 480 -defaultsOSRD
preplace inst xlconstant_3 -pg 1 -lvl 1 -y 570 -defaultsOSRD
preplace inst xlconcat_0 -pg 1 -lvl 2 -y 580 -defaultsOSRD
preplace inst mult_gen_0 -pg 1 -lvl 3 -y 50 -defaultsOSRD
preplace inst c_addsub_0 -pg 1 -lvl 4 -y 180 -defaultsOSRD
preplace inst xfft_0 -pg 1 -lvl 3 -y 380 -defaultsOSRD
preplace inst mult_gen_1 -pg 1 -lvl 3 -y 180 -defaultsOSRD
preplace inst cordic_0 -pg 1 -lvl 5 -y 340 -defaultsOSRD
preplace inst axis_register_slice_2 -pg 1 -lvl 4 -y 320 -defaultsOSRD
preplace netloc xlconstant_1_dout 1 1 3 160 650 460 610 920
preplace netloc mult_gen_1_P 1 3 1 N
preplace netloc xfft_0_event_tlast_unexpected 1 3 3 NJ 420 NJ 500 NJ
preplace netloc xfft_0_event_frame_started 1 3 3 NJ 110 NJ 110 NJ
preplace netloc xlconstant_2_dout 1 1 1 NJ
preplace netloc xlslice_1_Dout 1 2 1 460
preplace netloc xfft_0_event_data_out_channel_halt 1 3 3 NJ 450 NJ 450 NJ
preplace netloc xfft_0_event_data_in_channel_halt 1 3 3 NJ 440 NJ 440 NJ
preplace netloc xfft_0_M_AXIS_DATA 1 3 1 N
preplace netloc frame_1 1 0 3 NJ 310 NJ 310 430
preplace netloc xlconcat_0_dout 1 2 1 450
preplace netloc xlconstant_0_dout 1 3 1 NJ
preplace netloc clk_1 1 0 5 NJ 350 N 350 440 510 960 400 NJ
preplace netloc xfft_0_m_axis_data_tdata 1 1 3 160 250 NJ 250 920
preplace netloc xfft_0_event_status_channel_halt 1 3 3 NJ 460 NJ 460 NJ
preplace netloc xfft_0_event_tlast_missing 1 3 3 NJ 410 NJ 480 NJ
preplace netloc mult_gen_0_P 1 3 1 960
preplace netloc axis_register_slice_2_m_axis_tlast 1 4 1 N
preplace netloc axis_register_slice_2_m_axis_tvalid 1 4 1 1260
preplace netloc cordic_0_M_AXIS_DOUT 1 5 1 NJ
preplace netloc xlconstant_3_dout 1 1 1 NJ
preplace netloc axis_register_slice_2_m_axis_tuser 1 4 1 N
preplace netloc c_addsub_0_S 1 4 1 1270
preplace netloc xlslice_0_Dout 1 2 1 430
levelinfo -pg 1 0 90 330 710 1130 1470 1690 -top -20 -bot 710
",
}

  # Restore current instance
  current_bd_instance $oldCurInst

  save_bd_design
}
# End of create_root_design()


##################################################################
# MAIN FLOW
##################################################################

create_root_design ""


