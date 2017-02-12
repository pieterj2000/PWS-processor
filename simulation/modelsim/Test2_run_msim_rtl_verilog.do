transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+D:/Onderneming/16-bits\ processor/PWS-processor {D:/Onderneming/16-bits processor/PWS-processor/ALU.v}
vlog -vlog01compat -work work +incdir+D:/Onderneming/16-bits\ processor/PWS-processor {D:/Onderneming/16-bits processor/PWS-processor/ALUcontroller.v}
vlog -vlog01compat -work work +incdir+D:/Onderneming/16-bits\ processor/PWS-processor {D:/Onderneming/16-bits processor/PWS-processor/FDE_processor.v}
vlog -vlog01compat -work work +incdir+D:/Onderneming/16-bits\ processor/PWS-processor {D:/Onderneming/16-bits processor/PWS-processor/program_rom.v}
vlog -vlog01compat -work work +incdir+D:/Onderneming/16-bits\ processor/PWS-processor {D:/Onderneming/16-bits processor/PWS-processor/Instructie_decoder.v}
vlog -vlog01compat -work work +incdir+D:/Onderneming/16-bits\ processor/PWS-processor {D:/Onderneming/16-bits processor/PWS-processor/Register_controller.v}
vlog -vlog01compat -work work +incdir+D:/Onderneming/16-bits\ processor/PWS-processor {D:/Onderneming/16-bits processor/PWS-processor/program_ram.v}

