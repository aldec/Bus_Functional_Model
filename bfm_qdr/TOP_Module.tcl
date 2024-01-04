
################################################################
# This is a generated script based on design: TOP_Module
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
set scripts_vivado_version 2022.1
set current_vivado_version [version -short]

if { [string first $scripts_vivado_version $current_vivado_version] == -1 } {
   puts ""
   catch {common::send_gid_msg -ssname BD::TCL -id 2041 -severity "ERROR" "This script was generated using Vivado <$scripts_vivado_version> and is being run in <$current_vivado_version> of Vivado. Please run the script in Vivado <$scripts_vivado_version> then open the design in Vivado <$current_vivado_version>. Upgrade the design by running \"Tools => Report => Report IP Status...\", then run write_bd_tcl to create an updated script."}

   return 1
}

################################################################
# START
################################################################

# To test this script, run the following commands from Vivado Tcl console:
# source TOP_Module_script.tcl

# If there is no project opened, this script will create a
# project, but make sure you do not have an existing project
# <./myproj/project_1.xpr> in the current working folder.
set_param board.repoPaths src/board

set list_projs [get_projects -quiet]
if { $list_projs eq "" } {
   create_project project_1 myproj -part xcvu9p-flgb2104-2-e
   set_property BOARD_PART aldec.com:hes-xcvu9p-qdr:part0:1.5-2-E [current_project]
}


# CHANGE DESIGN NAME HERE
variable design_name
set design_name TOP_Module

# If you do not already have an existing IP Integrator design open,
# you can create a design using the following command:
#    create_bd_design $design_name

# Creating design if needed
set errMsg ""
set nRet 0

set cur_design [current_bd_design -quiet]
set list_cells [get_bd_cells -quiet]

if { ${design_name} eq "" } {
   # USE CASES:
   #    1) Design_name not set

   set errMsg "Please set the variable <design_name> to a non-empty value."
   set nRet 1

} elseif { ${cur_design} ne "" && ${list_cells} eq "" } {
   # USE CASES:
   #    2): Current design opened AND is empty AND names same.
   #    3): Current design opened AND is empty AND names diff; design_name NOT in project.
   #    4): Current design opened AND is empty AND names diff; design_name exists in project.

   if { $cur_design ne $design_name } {
      common::send_gid_msg -ssname BD::TCL -id 2001 -severity "INFO" "Changing value of <design_name> from <$design_name> to <$cur_design> since current design is empty."
      set design_name [get_property NAME $cur_design]
   }
   common::send_gid_msg -ssname BD::TCL -id 2002 -severity "INFO" "Constructing design in IPI design <$cur_design>..."

} elseif { ${cur_design} ne "" && $list_cells ne "" && $cur_design eq $design_name } {
   # USE CASES:
   #    5) Current design opened AND has components AND same names.

   set errMsg "Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 1
} elseif { [get_files -quiet ${design_name}.bd] ne "" } {
   # USE CASES: 
   #    6) Current opened design, has components, but diff names, design_name exists in project.
   #    7) No opened design, design_name exists in project.

   set errMsg "Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 2

} else {
   # USE CASES:
   #    8) No opened design, design_name not in project.
   #    9) Current opened design, has components, but diff names, design_name not in project.

   common::send_gid_msg -ssname BD::TCL -id 2003 -severity "INFO" "Currently there is no design <$design_name> in project, so creating one..."

   create_bd_design $design_name

   common::send_gid_msg -ssname BD::TCL -id 2004 -severity "INFO" "Making design <$design_name> as current_bd_design."
   current_bd_design $design_name

}

common::send_gid_msg -ssname BD::TCL -id 2005 -severity "INFO" "Currently the variable <design_name> is equal to \"$design_name\"."

if { $nRet != 0 } {
   catch {common::send_gid_msg -ssname BD::TCL -id 2006 -severity "ERROR" $errMsg}
   return $nRet
}

set_property IP_REPO_PATHS {src/ip_repo} [current_fileset]
update_ip_catalog -rebuild

set bCheckIPsPassed 1
##################################################################
# CHECK IPs
##################################################################
set bCheckIPs 1
if { $bCheckIPs == 1 } {
   set list_check_ips "\ 
com.pl:user:AXI_QDR_CONTROLLER:1.0\
com.pl:user:Ax_Axi4MasterBFM:1.0\
com.pl:user:QDR_MODEL:1.0\
"

   set list_ips_missing ""
   common::send_gid_msg -ssname BD::TCL -id 2011 -severity "INFO" "Checking if the following IPs exist in the project's IP catalog: $list_check_ips ."

   foreach ip_vlnv $list_check_ips {
      set ip_obj [get_ipdefs -all $ip_vlnv]
      if { $ip_obj eq "" } {
         lappend list_ips_missing $ip_vlnv
      }
   }

   if { $list_ips_missing ne "" } {
      catch {common::send_gid_msg -ssname BD::TCL -id 2012 -severity "ERROR" "The following IPs are not found in the IP Catalog:\n  $list_ips_missing\n\nResolution: Please add the repository containing the IP(s) to the project." }
      set bCheckIPsPassed 0
   }

}

if { $bCheckIPsPassed != 1 } {
  common::send_gid_msg -ssname BD::TCL -id 2023 -severity "WARNING" "Will not continue with creation of design due to the error(s) above."
  return 3
}

##################################################################
# DESIGN PROCs
##################################################################



# Procedure to create entire design; Provide argument to make
# procedure reusable. If parentCell is "", will use root.
proc create_root_design { parentCell } {

  variable script_folder
  variable design_name

  if { $parentCell eq "" } {
     set parentCell [get_bd_cells /]
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj


  # Create interface ports
  set JTAG_0 [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:jtag_rtl:2.0 JTAG_0 ]


  # Create ports
  set ACLK_0 [ create_bd_port -dir I -type clk -freq_hz 100000000 ACLK_0 ]
  set ARESETn_0 [ create_bd_port -dir I -type rst ARESETn_0 ]
  set ODT_0 [ create_bd_port -dir I ODT_0 ]
  set QVLD_0 [ create_bd_port -dir O QVLD_0 ]
  set ZQ_0 [ create_bd_port -dir I ZQ_0 ]
  set clk_n_0 [ create_bd_port -dir I -type clk -freq_hz 200000000 clk_n_0 ]
  set clk_p_0 [ create_bd_port -dir I -type clk -freq_hz 200000000 clk_p_0 ]
  set init_calib_complete_0 [ create_bd_port -dir O init_calib_complete_0 ]
  set reset_0 [ create_bd_port -dir I -type rst reset_0 ]

  # Create instance: AXI_QDR_CONTROLLER_0, and set properties
  set AXI_QDR_CONTROLLER_0 [ create_bd_cell -type ip -vlnv com.pl:user:AXI_QDR_CONTROLLER:1.0 AXI_QDR_CONTROLLER_0 ]

  # Create instance: Ax_Axi4MasterBFM_0, and set properties
  set Ax_Axi4MasterBFM_0 [ create_bd_cell -type ip -vlnv com.pl:user:Ax_Axi4MasterBFM:1.0 Ax_Axi4MasterBFM_0 ]
  set_property -dict [ list \
   CONFIG.ADDRESS_WIDTH {48} \
   CONFIG.DATA_BUS_WIDTH {64} \
   CONFIG.ID_WIDTH {8} \
 ] $Ax_Axi4MasterBFM_0

  # Create instance: QDR_MODEL_0, and set properties
  set QDR_MODEL_0 [ create_bd_cell -type ip -vlnv com.pl:user:QDR_MODEL:1.0 QDR_MODEL_0 ]

  # Create interface connections
  connect_bd_intf_net -intf_net Ax_Axi4MasterBFM_0_interface_aximm [get_bd_intf_pins AXI_QDR_CONTROLLER_0/interface_aximm] [get_bd_intf_pins Ax_Axi4MasterBFM_0/interface_aximm]
  connect_bd_intf_net -intf_net JTAG_0_1 [get_bd_intf_ports JTAG_0] [get_bd_intf_pins QDR_MODEL_0/JTAG]

  # Create port connections
  connect_bd_net -net ACLK_0_1 [get_bd_ports ACLK_0] [get_bd_pins AXI_QDR_CONTROLLER_0/ACLK] [get_bd_pins Ax_Axi4MasterBFM_0/ACLK]
  connect_bd_net -net ARESETn_0_1 [get_bd_ports ARESETn_0] [get_bd_pins AXI_QDR_CONTROLLER_0/ARESETn] [get_bd_pins Ax_Axi4MasterBFM_0/ARESETn]
  connect_bd_net -net AXI_QDR_CONTROLLER_0_init_calib_complete [get_bd_ports init_calib_complete_0] [get_bd_pins AXI_QDR_CONTROLLER_0/init_calib_complete]
  connect_bd_net -net AXI_QDR_CONTROLLER_0_qdriip_bw0_n [get_bd_pins AXI_QDR_CONTROLLER_0/qdriip_bw0_n] [get_bd_pins QDR_MODEL_0/BWS0b]
  connect_bd_net -net AXI_QDR_CONTROLLER_0_qdriip_bw1_n [get_bd_pins AXI_QDR_CONTROLLER_0/qdriip_bw1_n] [get_bd_pins QDR_MODEL_0/BWS1b]
  connect_bd_net -net AXI_QDR_CONTROLLER_0_qdriip_d [get_bd_pins AXI_QDR_CONTROLLER_0/qdriip_d] [get_bd_pins QDR_MODEL_0/D]
  connect_bd_net -net AXI_QDR_CONTROLLER_0_qdriip_doff_n [get_bd_pins AXI_QDR_CONTROLLER_0/qdriip_doff_n] [get_bd_pins QDR_MODEL_0/DOFF]
  connect_bd_net -net AXI_QDR_CONTROLLER_0_qdriip_k_n [get_bd_pins AXI_QDR_CONTROLLER_0/qdriip_k_n] [get_bd_pins QDR_MODEL_0/Kb]
  connect_bd_net -net AXI_QDR_CONTROLLER_0_qdriip_k_p [get_bd_pins AXI_QDR_CONTROLLER_0/qdriip_k_p] [get_bd_pins QDR_MODEL_0/K]
  connect_bd_net -net AXI_QDR_CONTROLLER_0_qdriip_r_n [get_bd_pins AXI_QDR_CONTROLLER_0/qdriip_r_n] [get_bd_pins QDR_MODEL_0/RPSb]
  connect_bd_net -net AXI_QDR_CONTROLLER_0_qdriip_sa [get_bd_pins AXI_QDR_CONTROLLER_0/qdriip_sa] [get_bd_pins QDR_MODEL_0/A]
  connect_bd_net -net AXI_QDR_CONTROLLER_0_qdriip_w_n [get_bd_pins AXI_QDR_CONTROLLER_0/qdriip_w_n] [get_bd_pins QDR_MODEL_0/WPSb]
  connect_bd_net -net ODT_0_1 [get_bd_ports ODT_0] [get_bd_pins QDR_MODEL_0/ODT]
  connect_bd_net -net QDR_MODEL_0_CQ [get_bd_pins AXI_QDR_CONTROLLER_0/qdriip_cq_p] [get_bd_pins QDR_MODEL_0/CQ]
  connect_bd_net -net QDR_MODEL_0_CQb [get_bd_pins AXI_QDR_CONTROLLER_0/qdriip_cq_n] [get_bd_pins QDR_MODEL_0/CQb]
  connect_bd_net -net QDR_MODEL_0_Q [get_bd_pins AXI_QDR_CONTROLLER_0/qdriip_q] [get_bd_pins QDR_MODEL_0/Q]
  connect_bd_net -net QDR_MODEL_0_QVLD [get_bd_ports QVLD_0] [get_bd_pins QDR_MODEL_0/QVLD]
  connect_bd_net -net ZQ_0_1 [get_bd_ports ZQ_0] [get_bd_pins QDR_MODEL_0/ZQ]
  connect_bd_net -net clk_n_0_1 [get_bd_ports clk_n_0] [get_bd_pins AXI_QDR_CONTROLLER_0/clk_n]
  connect_bd_net -net clk_p_0_1 [get_bd_ports clk_p_0] [get_bd_pins AXI_QDR_CONTROLLER_0/clk_p]
  connect_bd_net -net reset_0_1 [get_bd_ports reset_0] [get_bd_pins AXI_QDR_CONTROLLER_0/reset]

  # Create address segments
  assign_bd_address -offset 0x00000000 -range 0x01000000 -target_address_space [get_bd_addr_spaces Ax_Axi4MasterBFM_0/interface_aximm] [get_bd_addr_segs AXI_QDR_CONTROLLER_0/interface_aximm/reg0] -force


  # Restore current instance
  current_bd_instance $oldCurInst

  validate_bd_design
  save_bd_design
}
# End of create_root_design()


##################################################################
# MAIN FLOW
##################################################################

create_root_design ""

make_wrapper -files [get_files myproj/project_1.srcs/sources_1/bd/TOP_Module/TOP_Module.bd] -top
add_files -norecurse myproj/project_1.gen/sources_1/bd/TOP_Module/hdl/TOP_Module_wrapper.v

import_files -fileset sim_1 src/testbench.v
import_files -fileset sim_1 src/simulate.do

update_compile_order -fileset sources_1
set_property target_simulator Riviera [current_project]
set_property compxlib.riviera_compiled_library_dir src/lib [current_project]
set_property -name {riviera.simulate.custom_do} -value {simulate.do} -objects [get_filesets sim_1]