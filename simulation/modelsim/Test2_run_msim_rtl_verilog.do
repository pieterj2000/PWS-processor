transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/altera/13.0/quartus/bin64/projecten/Test2 {C:/altera/13.0/quartus/bin64/projecten/Test2/ramtest.v}
vlog -sv -work work +incdir+C:/altera/13.0/quartus/bin64/projecten/Test2 {C:/altera/13.0/quartus/bin64/projecten/Test2/Test2.sv}

