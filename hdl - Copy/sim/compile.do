
vlog -v +define+DISABLE_DEFAULT_NET $rtl/floating_point/fp_add_sub.v
vlog -sv -work my_work +define+DISABLE_DEFAULT_NET $rtl/bundling/element_Addition_cut/ElementAdditionCutBipolar_F.sv

vlog -sv -work my_work +define+DISABLE_DEFAULT_NET $tb/memoryEmulator.sv
vlog -sv -work my_work +define+DISABLE_DEFAULT_NET $tb/add_test.sv
