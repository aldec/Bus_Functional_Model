This example was tested on Ubuntu 22.04.3 LTS and Windows 11 with Xilinx Vivado 2022.1 and Aldec Riviera-PRO 2022.10 but also
works with newer versions of Riviera-Pro simulator.

1. Run Vivado
2. Make sure a proper path to Riviera-Pro simulator is selected in
   Tools > Settings > Tool Settings > 3rd Party Simulators
3. Make sure that Vivado environment is in the same directory as TOP_module.tcl file.
4. Source TOP_Module.tcl using Tools > Run Tcl Script...
5. Wait until the example project generation is complete
6. Run Simulation

Known Problems

If the path to Riviera-PRO is not established. After Run Simulation is selected, the tcl console should print:

ERROR: [USF-Riviera-PRO-35] Failed to locate '../rungui' executable in the shell environment 'PATH' variable. 
Please source the settings script included with the installation and retry this operation again.
ERROR: [Common 17-39] 'send_msg_id' failed due to earlier errors.

If the path to BFM license is incorrect, the Riviera-Pro console should print:

ELAB2: Warning: ELAB2_0113 Task or function "$check_license" not defined in
module "Ax_Axi4MasterBFMcore" from library "xil_defaultlib"

Make sure the correct path is given in -pli switch in asim command located in "simulate.do" file.
Correct the path in project file (visible in Riviera-PRO) or in source file (src/simulate.do).
Actualisation of source file requires vivado project re-generation.

The path should be established as follows:

Windows
-pli <path_to_Riviera-PRO>/bin/libAxiBfmPliRiv

Linux
-pli <path_to_Riviera-PRO>/bin/Linux64/libAxiBfmPliRiv
