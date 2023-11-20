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
add wave -bin sum_result
add wave -uns current_input
add wave -uns num_inputs
add wave -bin sum_inputs

add wave -divider -height 20 {Element Add Input}
add wave -bin valid
add wave -bin first
add wave -bin last
add wave -bin data_in
add wave -bin data_out
add wave -bin ready
add wave -bin done

add wave -divider -height 20 {Element Add Parameters}
add wave -uns UUT/HV_DATA_WIDTH
add wave -bin UUT/CUT_POS
add wave -bin UUT/CUT_NEG

add wave -divider -height 20 {Element Addition Cut}
add wave -uns UUT/state
add wave -bin UUT/accumulate
add wave -bin UUT/last_latch
#add wave -bin UUT/add_en
#add wave -bin UUT/comp_en
add wave -bin UUT/c_leq_max
add wave -bin UUT/c_leq_min
add wave -bin UUT/adder_out
