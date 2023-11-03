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
