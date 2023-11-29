
proc get_design_libraries {} {
  set libraries [dict create]
  dict set libraries altera_fp_functions_1917 1
  dict set libraries fp_add                   1
  dict set libraries fp_compare               1
  dict set libraries fp_mult                  1
  dict set libraries fp_div                   1
  dict set libraries fp_sqrt                  1
  return $libraries
}

proc get_memory_files {QSYS_SIMDIR} {
  set memory_files [list]
  lappend memory_files "[normalize_path "$QSYS_SIMDIR/../../rtl/floating_point/fp_div/altera_fp_functions_1917/sim/fp_div_altera_fp_functions_1917_ugoptdy_memoryC0_uid146_invTables_lutmem.hex"]"
  lappend memory_files "[normalize_path "$QSYS_SIMDIR/../../rtl/floating_point/fp_div/altera_fp_functions_1917/sim/fp_div_altera_fp_functions_1917_ugoptdy_memoryC1_uid149_invTables_lutmem.hex"]"
  lappend memory_files "[normalize_path "$QSYS_SIMDIR/../../rtl/floating_point/fp_div/altera_fp_functions_1917/sim/fp_div_altera_fp_functions_1917_ugoptdy_memoryC2_uid152_invTables_lutmem.hex"]"
  lappend memory_files "[normalize_path "$QSYS_SIMDIR/../../rtl/floating_point/fp_sqrt/altera_fp_functions_1917/sim/fp_sqrt_altera_fp_functions_1917_hchdkjq_memoryC0_uid62_sqrtTables_lutmem.hex"]"
  lappend memory_files "[normalize_path "$QSYS_SIMDIR/../../rtl/floating_point/fp_sqrt/altera_fp_functions_1917/sim/fp_sqrt_altera_fp_functions_1917_hchdkjq_memoryC1_uid65_sqrtTables_lutmem.hex"]"
  lappend memory_files "[normalize_path "$QSYS_SIMDIR/../../rtl/floating_point/fp_sqrt/altera_fp_functions_1917/sim/fp_sqrt_altera_fp_functions_1917_hchdkjq_memoryC2_uid68_sqrtTables_lutmem.hex"]"
  return $memory_files
}

proc get_common_design_files {USER_DEFINED_COMPILE_OPTIONS USER_DEFINED_VERILOG_COMPILE_OPTIONS USER_DEFINED_VHDL_COMPILE_OPTIONS QSYS_SIMDIR} {
  set design_files [dict create]
  return $design_files
}

proc get_design_files {USER_DEFINED_COMPILE_OPTIONS USER_DEFINED_VERILOG_COMPILE_OPTIONS USER_DEFINED_VHDL_COMPILE_OPTIONS QSYS_SIMDIR} {
  set design_files [list]
  lappend design_files "vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../../rtl/floating_point/fp_add/altera_fp_functions_1917/sim/dspba_library_package.vhd"]\"  -work altera_fp_functions_1917"                          
  lappend design_files "vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../../rtl/floating_point/fp_add/altera_fp_functions_1917/sim/dspba_library.vhd"]\"  -work altera_fp_functions_1917"                                  
  lappend design_files "vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../../rtl/floating_point/fp_add/altera_fp_functions_1917/sim/fp_add_altera_fp_functions_1917_vbqzuli.vhd"]\"  -work altera_fp_functions_1917"        
  lappend design_files "vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../../rtl/floating_point/fp_add/sim/fp_add.v"]\"  -work fp_add"                                                                             
  lappend design_files "vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../../rtl/floating_point/fp_compare/altera_fp_functions_1917/sim/dspba_library_package.vhd"]\"  -work altera_fp_functions_1917"                      
  lappend design_files "vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../../rtl/floating_point/fp_compare/altera_fp_functions_1917/sim/dspba_library.vhd"]\"  -work altera_fp_functions_1917"                              
  lappend design_files "vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../../rtl/floating_point/fp_compare/altera_fp_functions_1917/sim/fp_compare_altera_fp_functions_1917_bazjwmi.vhd"]\"  -work altera_fp_functions_1917"
  lappend design_files "vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../../rtl/floating_point/fp_compare/sim/fp_compare.v"]\"  -work fp_compare"                                                                 
  lappend design_files "vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../../rtl/floating_point/fp_mult/altera_fp_functions_1917/sim/dspba_library_package.vhd"]\"  -work altera_fp_functions_1917"                         
  lappend design_files "vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../../rtl/floating_point/fp_mult/altera_fp_functions_1917/sim/dspba_library.vhd"]\"  -work altera_fp_functions_1917"                                 
  lappend design_files "vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../../rtl/floating_point/fp_mult/altera_fp_functions_1917/sim/fp_mult_altera_fp_functions_1917_ebne4uy.vhd"]\"  -work altera_fp_functions_1917"      
  lappend design_files "vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../../rtl/floating_point/fp_mult/sim/fp_mult.v"]\"  -work fp_mult"                                                                          
  lappend design_files "vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../../rtl/floating_point/fp_div/altera_fp_functions_1917/sim/dspba_library_package.vhd"]\"  -work altera_fp_functions_1917"                          
  lappend design_files "vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../../rtl/floating_point/fp_div/altera_fp_functions_1917/sim/dspba_library.vhd"]\"  -work altera_fp_functions_1917"                                  
  lappend design_files "vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../../rtl/floating_point/fp_div/altera_fp_functions_1917/sim/fp_div_altera_fp_functions_1917_ugoptdy.vhd"]\"  -work altera_fp_functions_1917"        
  lappend design_files "vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../../rtl/floating_point/fp_div/sim/fp_div.v"]\"  -work fp_div"                                                                             
  lappend design_files "vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../../rtl/floating_point/fp_sqrt/altera_fp_functions_1917/sim/dspba_library_package.vhd"]\"  -work altera_fp_functions_1917"                         
  lappend design_files "vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../../rtl/floating_point/fp_sqrt/altera_fp_functions_1917/sim/dspba_library.vhd"]\"  -work altera_fp_functions_1917"                                 
  lappend design_files "vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../../rtl/floating_point/fp_sqrt/altera_fp_functions_1917/sim/fp_sqrt_altera_fp_functions_1917_hchdkjq.vhd"]\"  -work altera_fp_functions_1917"      
  lappend design_files "vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../../rtl/floating_point/fp_sqrt/sim/fp_sqrt.v"]\"  -work fp_sqrt"                                                                          
  return $design_files
}

proc get_elab_options {SIMULATOR_TOOL_BITNESS} {
  set ELAB_OPTIONS ""
  if ![ string match "bit_64" $SIMULATOR_TOOL_BITNESS ] {
  } else {
  }
  return $ELAB_OPTIONS
}


proc get_sim_options {SIMULATOR_TOOL_BITNESS} {
  set SIM_OPTIONS ""
  if ![ string match "bit_64" $SIMULATOR_TOOL_BITNESS ] {
  } else {
  }
  return $SIM_OPTIONS
}


proc get_env_variables {SIMULATOR_TOOL_BITNESS} {
  set ENV_VARIABLES [dict create]
  set LD_LIBRARY_PATH [dict create]
  dict set ENV_VARIABLES "LD_LIBRARY_PATH" $LD_LIBRARY_PATH
  if ![ string match "bit_64" $SIMULATOR_TOOL_BITNESS ] {
  } else {
  }
  return $ENV_VARIABLES
}


proc normalize_path {FILEPATH} {
    if {[catch { package require fileutil } err]} { 
        return $FILEPATH 
    } 
    set path [fileutil::lexnormalize [file join [pwd] $FILEPATH]]  
    if {[file pathtype $FILEPATH] eq "relative"} { 
        set path [fileutil::relative [pwd] $path] 
    } 
    return $path 
} 
proc get_dpi_libraries {QSYS_SIMDIR} {
  set libraries [dict create]
  
  return $libraries
}

