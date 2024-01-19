eval asim +access +r \
-L unisims_ver \
-L unimacro_ver \
-L secureip \
-L xpm \
-L fifo_generator_v13_2_7 \
-L xil_defaultlib \
-L microblaze_v11_0_9 \
-L lib_cdc_v1_0_2 \
-L proc_sys_reset_v5_0_13 \
-L lmb_v10_v3_0_12 \
-L lmb_bram_if_cntlr_v4_0_21 \
-L blk_mem_gen_v8_4_5 \
-L iomodule_v3_1_8 \
-O5 \
-pli ${aldec}/bin/libAxiBfmPliRiv \
xil_defaultlib.testbench \
xil_defaultlib.glbl

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

run -all