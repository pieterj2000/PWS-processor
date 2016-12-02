set_global_assignment -entity "Test2" -library "lib_Test2" -name IP_TOOL_NAME "Qsys"
set_global_assignment -entity "Test2" -library "lib_Test2" -name IP_TOOL_VERSION "13.0"
set_global_assignment -entity "Test2" -library "lib_Test2" -name IP_TOOL_ENV "Qsys"
set_global_assignment -library "lib_Test2" -name SPD_FILE [file join $::quartus(quartus_rootpath) "bin64/projecten/Test2/Test2.spd"]
set_global_assignment -library "lib_Test2" -name MISC_FILE [file join $::quartus(quartus_rootpath) "bin64/projecten/Test2/Test2.qsys"]

set_global_assignment -library "lib_Test2" -name MISC_FILE [file join $::quartus(sip_path) "Test2.v"]
set_global_assignment -library "lib_Test2" -name MISC_FILE [file join $::quartus(sip_path) "submodules/altera_reset_controller.v"]
set_global_assignment -library "lib_Test2" -name MISC_FILE [file join $::quartus(sip_path) "submodules/altera_reset_synchronizer.v"]
set_global_assignment -library "lib_Test2" -name MISC_FILE [file join $::quartus(sip_path) "submodules/altera_reset_controller.sdc"]
set_global_assignment -library "lib_Test2" -name MISC_FILE [file join $::quartus(sip_path) "submodules/Test2_onchip_memory2_0.hex"]
set_global_assignment -library "lib_Test2" -name MISC_FILE [file join $::quartus(sip_path) "submodules/Test2_onchip_memory2_0.v"]
