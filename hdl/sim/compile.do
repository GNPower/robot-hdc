
vlog -sv -work my_work +define+DISABLE_DEFAULT_NET $rtl/bundling/element_addition_cut/ElementAdditionCutBipolar_F.sv

vlog -sv -work my_work +define+DISABLE_DEFAULT_NET $tb/memoryEmulator.sv
vlog -sv -work my_work +define+DISABLE_DEFAULT_NET $tb/add_test.sv
