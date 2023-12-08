onerror {resume}
quietly virtual function -install /SimilarityKernelTB/UUT -env /SimilarityKernelTB/#INITIAL#78 { &{/SimilarityKernelTB/UUT/AA_mul_pipe_i, /SimilarityKernelTB/UUT/AA_mul_pipe }} AA_mul_pipe_v
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider -height 20 {Clock & Reset}
add wave -noupdate -radix binary /SimilarityKernelTB/clock
add wave -noupdate -radix binary /SimilarityKernelTB/reset_n
add wave -noupdate -divider -height 20 {Test Data}
add wave -noupdate -radix binary /SimilarityKernelTB/aa_result
add wave -noupdate -radix binary /SimilarityKernelTB/bb_result
add wave -noupdate -radix binary /SimilarityKernelTB/ab_result
add wave -noupdate -radix unsigned /SimilarityKernelTB/current_input
add wave -noupdate -radix unsigned /SimilarityKernelTB/num_inputs
add wave -noupdate -radix binary /SimilarityKernelTB/sim_inputs
add wave -noupdate -divider -height 20 {Cosine Sim Input}
add wave -noupdate -radix binary /SimilarityKernelTB/valid
add wave -noupdate -radix binary /SimilarityKernelTB/first
add wave -noupdate -radix binary /SimilarityKernelTB/last
add wave -noupdate -radix binary /SimilarityKernelTB/data_in
add wave -noupdate -radix binary /SimilarityKernelTB/AA_out
add wave -noupdate -radix binary /SimilarityKernelTB/BB_out
add wave -noupdate -radix binary /SimilarityKernelTB/AB_out
add wave -noupdate -radix binary /SimilarityKernelTB/ready
add wave -noupdate -radix binary /SimilarityKernelTB/done
add wave -noupdate -divider -height 20 {Cosine Sim Parameters}
add wave -noupdate -radix unsigned /SimilarityKernelTB/UUT/HV_DATA_WIDTH
add wave -noupdate -divider -height 20 {Cosine Similarity}
add wave -noupdate -radix unsigned /SimilarityKernelTB/UUT/state
add wave -noupdate -radix binary /SimilarityKernelTB/UUT/a_latch
add wave -noupdate -radix binary /SimilarityKernelTB/UUT/b_latch
add wave -noupdate -radix binary /SimilarityKernelTB/UUT/last_latch
add wave -noupdate -radix binary /SimilarityKernelTB/UUT/AA_accumulate
add wave -noupdate -radix binary /SimilarityKernelTB/UUT/BB_accumulate
add wave -noupdate -radix binary /SimilarityKernelTB/UUT/AB_accumulate
add wave -noupdate -divider -height 20 {Cosine Sim FP Wires}
add wave -noupdate -radix binary /SimilarityKernelTB/UUT/mult_a
add wave -noupdate -radix binary /SimilarityKernelTB/UUT/mult_b
add wave -noupdate -radix binary /SimilarityKernelTB/UUT/mult_out
add wave -noupdate -radix binary /SimilarityKernelTB/UUT/add_a
add wave -noupdate -radix binary /SimilarityKernelTB/UUT/add_out
add wave -noupdate -divider -height 20 {Cosine Sim Counter Pipes}
add wave -noupdate /SimilarityKernelTB/UUT/AA_mul_pipe_v
add wave -noupdate -radix binary /SimilarityKernelTB/UUT/AA_mul_pipe_i
add wave -noupdate -radix binary /SimilarityKernelTB/UUT/AA_mul_pipe
add wave -noupdate -radix binary /SimilarityKernelTB/UUT/BB_mul_pipe_i
add wave -noupdate -radix binary /SimilarityKernelTB/UUT/BB_mul_pipe
add wave -noupdate -radix binary /SimilarityKernelTB/UUT/AB_mul_pipe_i
add wave -noupdate -radix binary /SimilarityKernelTB/UUT/AB_mul_pipe
add wave -noupdate -radix binary /SimilarityKernelTB/UUT/AA_add_pipe_i
add wave -noupdate -radix binary /SimilarityKernelTB/UUT/AA_add_pipe
add wave -noupdate -radix binary /SimilarityKernelTB/UUT/BB_add_pipe_i
add wave -noupdate -radix binary /SimilarityKernelTB/UUT/BB_add_pipe
add wave -noupdate -radix binary /SimilarityKernelTB/UUT/AB_add_pipe_i
add wave -noupdate -radix binary /SimilarityKernelTB/UUT/AB_add_pipe
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {248757201 fs} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits us
update
WaveRestoreZoom {0 fs} {338493440 fs}
