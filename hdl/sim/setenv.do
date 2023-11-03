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