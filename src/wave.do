#############################################################################################
#
# Required libraries:
#     unisim
#     unisims_ver
#     unimacro_ver
#     secureip
#
#############################################################################################

wave -named_row "Clocks & Resets"
wave sim:/testbench/ACLK
wave sim:/testbench/ARESETn
wave sim:/testbench/clk_p
wave sim:/testbench/clk_n
wave sim:/testbench/rst
wave -named_row "Memory Controller"
wave sim:/testbench/DUT/TOP_Module_i/AXI_QDR_CONTROLLER_0/*
wave -named_row "QDR Model"
wave sim:/testbench/DUT/TOP_Module_i/QDR_MODEL_0/*
wave -named_row "Other signals"
