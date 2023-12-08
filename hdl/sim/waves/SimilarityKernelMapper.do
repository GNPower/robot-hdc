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
add wave -uns NUM_PARALLEL_KERNELS
add wave -uns MAX_HYPERVECTOR_LENGTH
add wave -uns num_inputs
add wave -bin sum_result
add wave -bin sum_inputs

add wave -divider -height 20 {Kernel Mapp Input}
add wave -bin valid
add wave -uns vec_length
add wave -uns hva
add wave -uns hvb
add wave -uns hvc
add wave -bin done

add wave -divider -height 20 {Kernel Mapper}
add wave -uns UUT/state
add wave -uns UUT/group_offset
add wave -uns UUT/hva_latch
add wave -uns UUT/hvb_latch
add wave -uns UUT/hvc_latch
add wave -bin UUT/k_valid
add wave -bin UUT/k_done
add wave -uns UUT/k_offset
add wave -bin UUT/all_kernels_complete

add wave -divider -height 20 {Memory Mapper Inst 0}
add wave -uns UUT/KernelNum[0]/KernelGen_Inst/MemMap/MemoryMapper_Inst/state
add wave -bin UUT/KernelNum[0]/KernelGen_Inst/MemMap/MemoryMapper_Inst/valid
add wave -uns UUT/KernelNum[0]/KernelGen_Inst/MemMap/MemoryMapper_Inst/hva
add wave -uns UUT/KernelNum[0]/KernelGen_Inst/MemMap/MemoryMapper_Inst/hvb
add wave -uns UUT/KernelNum[0]/KernelGen_Inst/MemMap/MemoryMapper_Inst/hvc
add wave -uns UUT/KernelNum[0]/KernelGen_Inst/MemMap/MemoryMapper_Inst/hv_offset
add wave -bin UUT/KernelNum[0]/KernelGen_Inst/MemMap/MemoryMapper_Inst/done
add wave -bin UUT/KernelNum[0]/KernelGen_Inst/MemMap/MemoryMapper_Inst/buff
add wave -bin UUT/KernelNum[0]/KernelGen_Inst/MemMap/MemoryMapper_Inst/we_n
add wave -uns UUT/KernelNum[0]/KernelGen_Inst/MemMap/MemoryMapper_Inst/address
add wave -hex UUT/KernelNum[0]/KernelGen_Inst/MemMap/MemoryMapper_Inst/data_wr
add wave -hex UUT/KernelNum[0]/KernelGen_Inst/MemMap/MemoryMapper_Inst/data_rd

add wave -divider -height 20 {Bundle Kernel Inst 0}
add wave -uns UUT/KernelNum[0]/KernelGen_Inst/Kernel/Kernel_Inst/state
add wave -bin UUT/KernelNum[0]/KernelGen_Inst/Kernel/Kernel_Inst/valid
add wave -bin UUT/KernelNum[0]/KernelGen_Inst/Kernel/Kernel_Inst/first
add wave -bin UUT/KernelNum[0]/KernelGen_Inst/Kernel/Kernel_Inst/last
add wave -hex UUT/KernelNum[0]/KernelGen_Inst/Kernel/Kernel_Inst/data_in
add wave -hex UUT/KernelNum[0]/KernelGen_Inst/Kernel/Kernel_Inst/data_out
add wave -bin UUT/KernelNum[0]/KernelGen_Inst/Kernel/Kernel_Inst/ready
add wave -bin UUT/KernelNum[0]/KernelGen_Inst/Kernel/Kernel_Inst/done
add wave -hex UUT/KernelNum[0]/KernelGen_Inst/Kernel/Kernel_Inst/partial_result

#add wave -divider -height 20 {Memory Mapper Inst 1}
#add wave -uns UUT/KernelNum[1]/KernelGen_Inst/MemMap/MemoryMapper_Inst/state
#add wave -bin UUT/KernelNum[1]/KernelGen_Inst/MemMap/MemoryMapper_Inst/valid
#add wave -uns UUT/KernelNum[1]/KernelGen_Inst/MemMap/MemoryMapper_Inst/hva
#add wave -uns UUT/KernelNum[1]/KernelGen_Inst/MemMap/MemoryMapper_Inst/hvb
#add wave -uns UUT/KernelNum[1]/KernelGen_Inst/MemMap/MemoryMapper_Inst/hvc
#add wave -uns UUT/KernelNum[1]/KernelGen_Inst/MemMap/MemoryMapper_Inst/hv_offset
#add wave -bin UUT/KernelNum[1]/KernelGen_Inst/MemMap/MemoryMapper_Inst/mode
#add wave -bin UUT/KernelNum[1]/KernelGen_Inst/MemMap/MemoryMapper_Inst/done
#add wave -bin UUT/KernelNum[1]/KernelGen_Inst/MemMap/MemoryMapper_Inst/buff

#add wave -divider -height 20 {Memory Mapper Inst 2}
#add wave -uns UUT/KernelNum[2]/KernelGen_Inst/MemMap/MemoryMapper_Inst/state
#add wave -bin UUT/KernelNum[2]/KernelGen_Inst/MemMap/MemoryMapper_Inst/valid
#add wave -uns UUT/KernelNum[2]/KernelGen_Inst/MemMap/MemoryMapper_Inst/hva
#add wave -uns UUT/KernelNum[2]/KernelGen_Inst/MemMap/MemoryMapper_Inst/hvb
#add wave -uns UUT/KernelNum[2]/KernelGen_Inst/MemMap/MemoryMapper_Inst/hvc
#add wave -uns UUT/KernelNum[2]/KernelGen_Inst/MemMap/MemoryMapper_Inst/hv_offset
#add wave -bin UUT/KernelNum[2]/KernelGen_Inst/MemMap/MemoryMapper_Inst/mode
#add wave -bin UUT/KernelNum[2]/KernelGen_Inst/MemMap/MemoryMapper_Inst/done
#add wave -bin UUT/KernelNum[2]/KernelGen_Inst/MemMap/MemoryMapper_Inst/buff

#add wave -divider -height 20 {Memory Mapper Inst 3}
#add wave -uns UUT/KernelNum[3]/KernelGen_Inst/MemMap/MemoryMapper_Inst/state
#add wave -bin UUT/KernelNum[3]/KernelGen_Inst/MemMap/MemoryMapper_Inst/valid
#add wave -uns UUT/KernelNum[3]/KernelGen_Inst/MemMap/MemoryMapper_Inst/hva
#add wave -uns UUT/KernelNum[3]/KernelGen_Inst/MemMap/MemoryMapper_Inst/hvb
#add wave -uns UUT/KernelNum[3]/KernelGen_Inst/MemMap/MemoryMapper_Inst/hvc
#add wave -uns UUT/KernelNum[3]/KernelGen_Inst/MemMap/MemoryMapper_Inst/hv_offset
#add wave -bin UUT/KernelNum[3]/KernelGen_Inst/MemMap/MemoryMapper_Inst/mode
#add wave -bin UUT/KernelNum[3]/KernelGen_Inst/MemMap/MemoryMapper_Inst/done
#add wave -bin UUT/KernelNum[3]/KernelGen_Inst/MemMap/MemoryMapper_Inst/buff

#add wave -divider -height 20 {Memory Mapper Inst 4}
#add wave -uns UUT/KernelNum[4]/KernelGen_Inst/MemMap/MemoryMapper_Inst/state
#add wave -bin UUT/KernelNum[4]/KernelGen_Inst/MemMap/MemoryMapper_Inst/valid
#add wave -uns UUT/KernelNum[4]/KernelGen_Inst/MemMap/MemoryMapper_Inst/hva
#add wave -uns UUT/KernelNum[4]/KernelGen_Inst/MemMap/MemoryMapper_Inst/hvb
#add wave -uns UUT/KernelNum[4]/KernelGen_Inst/MemMap/MemoryMapper_Inst/hvc
#add wave -uns UUT/KernelNum[4]/KernelGen_Inst/MemMap/MemoryMapper_Inst/hv_offset
#add wave -bin UUT/KernelNum[4]/KernelGen_Inst/MemMap/MemoryMapper_Inst/mode
#add wave -bin UUT/KernelNum[4]/KernelGen_Inst/MemMap/MemoryMapper_Inst/done
#add wave -bin UUT/KernelNum[4]/KernelGen_Inst/MemMap/MemoryMapper_Inst/buff