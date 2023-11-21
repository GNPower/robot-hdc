set rtl ../rtl
set tb ../tb
set sim .
set waves $sim/waves

if { $1 == 1 } {
	set top BundleKernelTB
} elseif { $1 == 2} {
	set top MemoryMapperTB
} elseif { $1 == 3 } {
	set top KernelMapperTB
}


onbreak {resume}

transcript on

if {[file exists my_work]} {
	vdel -lib my_work -all
}

if {[file exists $sim/libraries]} {
	set subdirs [ glob -directory $sim/libraries -type d * ] ;

	foreach x $subdirs {
		if {[file exists $x]} {
			vdel -lib $x -all
		}
	}
}

vlib my_work
vmap work my_work
