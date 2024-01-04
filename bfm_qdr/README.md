This example was tested on Ubuntu with Xilinx Vivado 2022.1 and Aldec Riviera-PRO 2022.10 but also
works with newer versions of Riviera-Pro simulator.

1. Run Vivado
2. Make sure a proper path to Riviera-Pro simulator is selected in
   Tools > Settings > Tool Settings > 3rd Party Simulators
3. Source TOP_Module.tcl using Tools > Run Tcl Script...
4. Wait until the example project generation is complete
5. Run Simulation

Known Problems

If the path to Riviera-Pro is not established. After Run Simulation is selected, the tcl console should print:

ERROR: [USF-Riviera-PRO-35] Failed to locate '../rungui' executable in the shell environment 'PATH' variable. 
Please source the settings script included with the installation and retry this operation again.
ERROR: [Common 17-39] 'send_msg_id' failed due to earlier errors.