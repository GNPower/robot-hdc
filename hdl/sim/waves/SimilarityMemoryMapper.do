# activate waveform simulation

view wave

# format signal names in waveform

configure wave -signalnamewidth 1
configure wave -timeline 0
configure wave -timelineunits us

# add signals to waveform

add wave -divider -height 20 {Clock & Reset}
add wave -bin clock
add wave -bin reset_n

add wave -divider -height 20 {Test Data}
add wave -bin aa_result
add wave -bin bb_result
add wave -bin ab_result
add wave -uns current_input
add wave -uns num_inputs
add wave -bin sim_inputs

add wave -divider -height 20 {Element Mult Input}
add wave -uns Kernel_Inst/state
add wave -bin k_valid
add wave -bin k_first
add wave -bin k_last
add wave -bin k_data_in
add wave -bin k_AA_out
add wave -bin k_BB_out
add wave -bin k_AB_out
add wave -bin k_ready
add wave -bin k_done

add wave -divider -height 20 {Memory Emulator}
add wave -bin we_n
add wave -uns address
add wave -bin data_o
add wave -bin DPRam_Inst/DPRAM_data

add wave -divider -height 20 {Memory Mapp Input}
add wave -bin valid
add wave -uns hva
add wave -uns hvb
add wave -uns hv_start
add wave -uns hv_end
add wave -bin done

add wave -divider -height 20 {Direct Memory Mapper}
add wave -uns UUT/state
add wave -bin UUT/buff_loaded
add wave -bin UUT/buff
add wave -uns UUT/addr_counter
add wave -uns UUT/hva_addr
add wave -uns UUT/hvb_addr
add wave -uns UUT/hvb_last
