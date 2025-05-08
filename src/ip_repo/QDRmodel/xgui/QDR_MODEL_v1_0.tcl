# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_param $IPINST -name "DLL_SwitchingCycles" -parent ${Page_0}
  ipgui::add_param $IPINST -name "Sampling_Time" -parent ${Page_0}
  ipgui::add_param $IPINST -name "Wait_Cycles" -parent ${Page_0}


}

proc update_PARAM_VALUE.DLL_SwitchingCycles { PARAM_VALUE.DLL_SwitchingCycles } {
	# Procedure called to update DLL_SwitchingCycles when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.DLL_SwitchingCycles { PARAM_VALUE.DLL_SwitchingCycles } {
	# Procedure called to validate DLL_SwitchingCycles
	return true
}

proc update_PARAM_VALUE.Sampling_Time { PARAM_VALUE.Sampling_Time } {
	# Procedure called to update Sampling_Time when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.Sampling_Time { PARAM_VALUE.Sampling_Time } {
	# Procedure called to validate Sampling_Time
	return true
}

proc update_PARAM_VALUE.Wait_Cycles { PARAM_VALUE.Wait_Cycles } {
	# Procedure called to update Wait_Cycles when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.Wait_Cycles { PARAM_VALUE.Wait_Cycles } {
	# Procedure called to validate Wait_Cycles
	return true
}


proc update_MODELPARAM_VALUE.DLL_SwitchingCycles { MODELPARAM_VALUE.DLL_SwitchingCycles PARAM_VALUE.DLL_SwitchingCycles } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.DLL_SwitchingCycles}] ${MODELPARAM_VALUE.DLL_SwitchingCycles}
}

proc update_MODELPARAM_VALUE.Wait_Cycles { MODELPARAM_VALUE.Wait_Cycles PARAM_VALUE.Wait_Cycles } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.Wait_Cycles}] ${MODELPARAM_VALUE.Wait_Cycles}
}

proc update_MODELPARAM_VALUE.Sampling_Time { MODELPARAM_VALUE.Sampling_Time PARAM_VALUE.Sampling_Time } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.Sampling_Time}] ${MODELPARAM_VALUE.Sampling_Time}
}

