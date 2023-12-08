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

add wave -divider -height 20 {Cosine Sim Input}
add wave -bin valid
add wave -bin first
add wave -bin last
add wave -bin data_in
add wave -bin AA_out
add wave -bin BB_out
add wave -bin AB_out
add wave -bin ready
add wave -bin done

add wave -divider -height 20 {Cosine Sim Parameters}
add wave -uns UUT/HV_DATA_WIDTH

add wave -divider -height 20 {Cosine Similarity}
add wave -uns UUT/state
add wave -bin UUT/a_latch
add wave -bin UUT/b_latch
add wave -bin UUT/last_latch
add wave -bin UUT/AA_accumulate
add wave -bin UUT/BB_accumulate
add wave -bin UUT/AB_accumulate

add wave -divider -height 20 {Cosine Sim FP Wires}
add wave -bin UUT/mult_a
add wave -bin UUT/mult_b
add wave -bin UUT/mult_out
add wave -bin UUT/add_a
add wave -bin UUT/add_out

add wave -divider -height 20 {Cosine Sim Counter Pipes}
add wave -bin UUT/load_AA_mul_pipe
add wave -bin UUT/load_BB_mul_pipe
add wave -bin UUT/load_AB_mul_pipe
add wave -bin UUT/load_AA_add_pipe
add wave -bin UUT/load_BB_add_pipe
add wave -bin UUT/load_AB_add_pipe

quietly virtual function -install /SimilarityKernelTB/UUT { &{/SimilarityKernelTB/UUT/AA_mul_pipe_i, /SimilarityKernelTB/UUT/AA_mul_pipe }} AA_mul_pipe_v
add wave -bin /SimilarityKernelTB/UUT/AA_mul_pipe_v
quietly virtual function -install /SimilarityKernelTB/UUT { &{/SimilarityKernelTB/UUT/BB_mul_pipe_i, /SimilarityKernelTB/UUT/BB_mul_pipe }} BB_mul_pipe_v
add wave -bin /SimilarityKernelTB/UUT/BB_mul_pipe_v
quietly virtual function -install /SimilarityKernelTB/UUT { &{/SimilarityKernelTB/UUT/AB_mul_pipe_i, /SimilarityKernelTB/UUT/AB_mul_pipe }} AB_mul_pipe_v
add wave -bin /SimilarityKernelTB/UUT/AB_mul_pipe_v

quietly virtual function -install /SimilarityKernelTB/UUT { &{/SimilarityKernelTB/UUT/AA_add_pipe_i, /SimilarityKernelTB/UUT/AA_add_pipe }} AA_add_pipe_v
add wave -bin /SimilarityKernelTB/UUT/AA_add_pipe_v
quietly virtual function -install /SimilarityKernelTB/UUT { &{/SimilarityKernelTB/UUT/BB_add_pipe_i, /SimilarityKernelTB/UUT/BB_add_pipe }} BB_add_pipe_v
add wave -bin /SimilarityKernelTB/UUT/BB_add_pipe_v
quietly virtual function -install /SimilarityKernelTB/UUT { &{/SimilarityKernelTB/UUT/AB_add_pipe_i, /SimilarityKernelTB/UUT/AB_add_pipe }} AB_add_pipe_v
add wave -bin /SimilarityKernelTB/UUT/AB_add_pipe_v
