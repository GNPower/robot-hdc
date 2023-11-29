set rtl ../rtl
set tb ../tb
set sim .
set waves $sim/waves

if { $1 == 1 } {
	set top BundleKernelTB
} elseif { $1 == 2} {
	set top BundleMemoryMapperTB
} elseif { $1 == 3 } {
	set top BundleKernelMapperTB
} elseif { $1 == 4} {
	set top BindKernelTB
} elseif { $1 == 5} {
	set top BindMemoryMapperTB
} elseif { $1 == 6} {
	set top BindKernelMapperTB
} elseif { $1 == 7} {
	set top SimilarityKernelTB
} elseif { $1 == 8} {
	set top SimilarityMemoryMapperTB
} elseif { $1 == 9} {
	set top SimilarityKernelMapperTB
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
