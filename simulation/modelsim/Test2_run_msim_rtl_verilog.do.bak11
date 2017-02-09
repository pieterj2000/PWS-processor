transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+D:/Onderneming/16-bits\ processor/PWS-processor {D:/Onderneming/16-bits processor/PWS-processor/ramtest.v}
vlog -sv -work work +incdir+D:/Onderneming/16-bits\ processor/PWS-processor {D:/Onderneming/16-bits processor/PWS-processor/Test2.sv}

