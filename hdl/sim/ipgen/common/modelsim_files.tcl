
proc get_design_libraries {} {
  set libraries [dict create]
  dict set libraries altera_fp_functions_1917 1
  dict set libraries fp_add                   1
  dict set libraries fp_compare               1
  return $libraries
}

proc get_memory_files {QSYS_SIMDIR} {
  set memory_files [list]
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
  lappend design_files "vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../../rtl/floating_point/fp_add/altera_fp_functions_1917/sim/fp_add_altera_fp_functions_1917_3lb67iq.vhd"]\"  -work altera_fp_functions_1917"        
  lappend design_files "vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../../rtl/floating_point/fp_add/sim/fp_add.v"]\"  -work fp_add"                                                                                   
  lappend design_files "vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../../rtl/floating_point/fp_compare/altera_fp_functions_1917/sim/dspba_library_package.vhd"]\"  -work altera_fp_functions_1917"                      
  lappend design_files "vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../../rtl/floating_point/fp_compare/altera_fp_functions_1917/sim/dspba_library.vhd"]\"  -work altera_fp_functions_1917"                              
  lappend design_files "vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../../rtl/floating_point/fp_compare/altera_fp_functions_1917/sim/fp_compare_altera_fp_functions_1917_q54p7sy.vhd"]\"  -work altera_fp_functions_1917"
  lappend design_files "vlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS  \"[normalize_path "$QSYS_SIMDIR/../../rtl/floating_point/fp_compare/sim/fp_compare.v"]\"  -work fp_compare"                                                                       
  return $design_files
}

proc get_elab_options {SIMULATOR_TOOL_BITNESS} {
  set ELAB_OPTIONS ""
  if ![ string match "bit_64" $SIMULATOR_TOOL_BITNESS ] {
  } else {
  }
  append ELAB_OPTIONS { -t fs}
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
