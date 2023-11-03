# do setenv.do
set rtl ../rtl
set tb ../tb
set sim .
set top AddTestSim

onbreak {resume}

transcript on

if {[file exists my_work]} {
	vdel -lib my_work -all
}

vlib my_work
vmap work my_work

# do ipgen.do
#set QSYS_SIMDIR "D:/School/Grad/Code/my_hdc/hdl/sim/ipgen"
#set QSYS_SIMDIR $sim/ipgen"

#source $QSYS_SIMDIR/mentor/msim_setup.tcl
source $sim/ipgen/mentor/msim_setup.tcl

dev_com

com

# do compile.do
#vlog -sv "D:/School/Grad/Code/my_hdc/hdl/rtl/bundling/element_addition_cut/ElementAdditionCutBipolar_F.sv" "D:/School/Grad/Code/my_hdc/hdl/tb/add_test.sv" "D:/School/Grad/Code/my_hdc/hdl/tb/memoryEmulator.sv"

vlog -sv -work my_work +define+DISABLE_DEFAULT_NET $rtl/bundling/element_addition_cut/ElementAdditionCutBipolar_F.sv

vlog -sv -work my_work +define+DISABLE_DEFAULT_NET $tb/memoryEmulator.sv
vlog -sv -work my_work +define+DISABLE_DEFAULT_NET $tb/add_test.sv

# Call the command to elaborate your design and testbench
set TOP_LEVEL_NAME $top
elab_debug

# Clear previous simulation
restart -f

# do waves.do
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

# run simulation
run -all

# do save.do
mem save -o DPRAM.mem -f mti -data hex -addr hex -startaddress 0 -endaddress 2097151 -wordsperline 8 /AddTestSim/emulated_DPRAM/DPRAM_data
