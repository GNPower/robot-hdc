# TOP-LEVEL TEMPLATE - BEGIN

# TODO: Not sure what script or folder this is referencing
set QSYS_SIMDIR "D:/School/Grad/Code/my_hdc/hdl/sim/ipgen"

source $QSYS_SIMDIR/mentor/msim_setup.tcl

dev_com

com

# 
# Add commands to compile all design files and testbench files, including the top level (NOTE: no IP files included)
# 
vlog -sv "D:/School/Grad/Code/my_hdc/hdl/rtl/bundling/element_addition_cut/ElementAdditionCutBipolar_F.sv" "D:/School/Grad/Code/my_hdc/hdl/tb/add_test.sv" "D:/School/Grad/Code/my_hdc/hdl/tb/memoryEmulator.sv"

# 
# Set the top-level simulation or testbench module/entity name, which is used by the elab command to elaborate the top level
# 
set TOP_LEVEL_NAME AddTestSim

# vsim -L altera_ver -L altera_mf_ver -t ns AddTestSim

# 
# Call the command to elaborate your design and testbench
# 
elab_debug

view wave
configure wave -signalnamewidth 1
configure wave -timeline 0
configure wave -timelineunits us


# add signals to waveform

add wave -divider -height 20 {Clock & Reset}
add wave -bin clock
add wave -bin reset_n

add wave -divider -height 20 {Element Add Input}
add wave -bin valid
add wave -uns addr_a
add wave -uns addr_b
add wave -bin done

add wave -divider -height 20 {Memory Control}
add wave -bin write_enable_n
add wave -uns write_address
add wave -uns read_address
add wave -uns data_i
add wave -uns data_o

add wave -divider -height 20 {Element Addition Cut}
add wave -uns UUT/d_one
add wave -uns UUT/d_two
add wave -uns UUT/mac


run -all

# 
# Report success to the shell.
# 
#exit -code 0