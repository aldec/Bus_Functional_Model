# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_param $IPINST -name "ADDRESS_WIDTH" -parent ${Page_0}
  ipgui::add_param $IPINST -name "ARUSER_BUS_WIDTH" -parent ${Page_0}
  ipgui::add_param $IPINST -name "AWUSER_BUS_WIDTH" -parent ${Page_0}
  ipgui::add_param $IPINST -name "BUSER_BUS_WIDTH" -parent ${Page_0}
  ipgui::add_param $IPINST -name "DATA_BUS_WIDTH" -parent ${Page_0}
  ipgui::add_param $IPINST -name "ID_WIDTH" -parent ${Page_0}
  ipgui::add_param $IPINST -name "RUSER_BUS_WIDTH" -parent ${Page_0}
  ipgui::add_param $IPINST -name "WUSER_BUS_WIDTH" -parent ${Page_0}


}

proc update_PARAM_VALUE.ADDRESS_WIDTH { PARAM_VALUE.ADDRESS_WIDTH } {
	# Procedure called to update ADDRESS_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.ADDRESS_WIDTH { PARAM_VALUE.ADDRESS_WIDTH } {
	# Procedure called to validate ADDRESS_WIDTH
	return true
}

proc update_PARAM_VALUE.ARUSER_BUS_WIDTH { PARAM_VALUE.ARUSER_BUS_WIDTH } {
	# Procedure called to update ARUSER_BUS_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.ARUSER_BUS_WIDTH { PARAM_VALUE.ARUSER_BUS_WIDTH } {
	# Procedure called to validate ARUSER_BUS_WIDTH
	return true
}

proc update_PARAM_VALUE.AWUSER_BUS_WIDTH { PARAM_VALUE.AWUSER_BUS_WIDTH } {
	# Procedure called to update AWUSER_BUS_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.AWUSER_BUS_WIDTH { PARAM_VALUE.AWUSER_BUS_WIDTH } {
	# Procedure called to validate AWUSER_BUS_WIDTH
	return true
}

proc update_PARAM_VALUE.BUSER_BUS_WIDTH { PARAM_VALUE.BUSER_BUS_WIDTH } {
	# Procedure called to update BUSER_BUS_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.BUSER_BUS_WIDTH { PARAM_VALUE.BUSER_BUS_WIDTH } {
	# Procedure called to validate BUSER_BUS_WIDTH
	return true
}

proc update_PARAM_VALUE.DATA_BUS_WIDTH { PARAM_VALUE.DATA_BUS_WIDTH } {
	# Procedure called to update DATA_BUS_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.DATA_BUS_WIDTH { PARAM_VALUE.DATA_BUS_WIDTH } {
	# Procedure called to validate DATA_BUS_WIDTH
	return true
}

proc update_PARAM_VALUE.ID_WIDTH { PARAM_VALUE.ID_WIDTH } {
	# Procedure called to update ID_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.ID_WIDTH { PARAM_VALUE.ID_WIDTH } {
	# Procedure called to validate ID_WIDTH
	return true
}

proc update_PARAM_VALUE.RUSER_BUS_WIDTH { PARAM_VALUE.RUSER_BUS_WIDTH } {
	# Procedure called to update RUSER_BUS_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.RUSER_BUS_WIDTH { PARAM_VALUE.RUSER_BUS_WIDTH } {
	# Procedure called to validate RUSER_BUS_WIDTH
	return true
}

proc update_PARAM_VALUE.WUSER_BUS_WIDTH { PARAM_VALUE.WUSER_BUS_WIDTH } {
	# Procedure called to update WUSER_BUS_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.WUSER_BUS_WIDTH { PARAM_VALUE.WUSER_BUS_WIDTH } {
	# Procedure called to validate WUSER_BUS_WIDTH
	return true
}


proc update_MODELPARAM_VALUE.DATA_BUS_WIDTH { MODELPARAM_VALUE.DATA_BUS_WIDTH PARAM_VALUE.DATA_BUS_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.DATA_BUS_WIDTH}] ${MODELPARAM_VALUE.DATA_BUS_WIDTH}
}

proc update_MODELPARAM_VALUE.ADDRESS_WIDTH { MODELPARAM_VALUE.ADDRESS_WIDTH PARAM_VALUE.ADDRESS_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.ADDRESS_WIDTH}] ${MODELPARAM_VALUE.ADDRESS_WIDTH}
}

proc update_MODELPARAM_VALUE.ID_WIDTH { MODELPARAM_VALUE.ID_WIDTH PARAM_VALUE.ID_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.ID_WIDTH}] ${MODELPARAM_VALUE.ID_WIDTH}
}

proc update_MODELPARAM_VALUE.AWUSER_BUS_WIDTH { MODELPARAM_VALUE.AWUSER_BUS_WIDTH PARAM_VALUE.AWUSER_BUS_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.AWUSER_BUS_WIDTH}] ${MODELPARAM_VALUE.AWUSER_BUS_WIDTH}
}

proc update_MODELPARAM_VALUE.ARUSER_BUS_WIDTH { MODELPARAM_VALUE.ARUSER_BUS_WIDTH PARAM_VALUE.ARUSER_BUS_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.ARUSER_BUS_WIDTH}] ${MODELPARAM_VALUE.ARUSER_BUS_WIDTH}
}

proc update_MODELPARAM_VALUE.RUSER_BUS_WIDTH { MODELPARAM_VALUE.RUSER_BUS_WIDTH PARAM_VALUE.RUSER_BUS_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.RUSER_BUS_WIDTH}] ${MODELPARAM_VALUE.RUSER_BUS_WIDTH}
}

proc update_MODELPARAM_VALUE.WUSER_BUS_WIDTH { MODELPARAM_VALUE.WUSER_BUS_WIDTH PARAM_VALUE.WUSER_BUS_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.WUSER_BUS_WIDTH}] ${MODELPARAM_VALUE.WUSER_BUS_WIDTH}
}

proc update_MODELPARAM_VALUE.BUSER_BUS_WIDTH { MODELPARAM_VALUE.BUSER_BUS_WIDTH PARAM_VALUE.BUSER_BUS_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.BUSER_BUS_WIDTH}] ${MODELPARAM_VALUE.BUSER_BUS_WIDTH}
}

