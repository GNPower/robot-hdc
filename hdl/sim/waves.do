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

add wave -divider -height 20 {Element Add Input}
add wave -bin valid
add wave -uns addr_a
add wave -uns addr_b
add wave -uns addr_c
add wave -bin done

add wave -divider -height 20 {Memory Control}
add wave -bin write_enable_n
add wave -uns write_address
add wave -uns read_address
add wave -uns data_i
add wave -uns data_o

add wave -divider -height 20 {Element Addition Cut}
add wave -uns UUT/addr_a
add wave -uns UUT/addr_b
add wave -uns UUT/addr_c
add wave -bin UUT/valid
add wave -bin UUT/done
add wave -uns UUT/state

add wave -divider -height 10
add wave -uns UUT/data_a_latch
add wave -uns UUT/addr_b_latch
add wave -uns UUT/addr_c_latch

add wave -divider -height 10
add wave -uns UUT/raddress
add wave -uns UUT/data_rd

add wave -divider -height 10
add wave -uns UUT/we_n
add wave -uns UUT/waddress
add wave -uns UUT/data_wr

add wave -divider -height 10
add wave -bin UUT/add_en
add wave -bin UUT/comp_en
add wave -bin UUT/c_leq_max
add wave -bin UUT/c_leq_min

add wave -divider -height 10
add wave -uns UUT/adder_out




