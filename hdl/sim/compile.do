# Bundle Kernels & Testbench
vlog -sv +define+DISABLE_DEFAULT_NET $rtl/bundling/element_addition_cut/ElementAdditionCutBipolar_F.sv

vlog -sv +define+DISABLE_DEFAULT_NET $tb/BundleKernel_tb.sv

# Bind Kernels & Testbench
vlog -sv +define+DISABLE_DEFAULT_NET $rtl/binding/element_multiplication/ElementMultiplication_F.sv

vlog -sv +define+DISABLE_DEFAULT_NET $tb/BindKernel_tb.sv

# Memory Emulators
vlog -sv +define+DISABLE_DEFAULT_NET $tb/MemoryEmulator.sv
vlog -sv +define+DISABLE_DEFAULT_NET $tb/MemoryEmulator_InfPort.sv

# Bundle Memory Mappers & Testbench
vlog -sv +define+DISABLE_DEFAULT_NET $rtl/mapping/memory/bundle/BundleLinearMapper.sv

vlog -sv +define+DISABLE_DEFAULT_NET $tb/BundleMemoryMapper_tb.sv

# Kernel Mappers & Testbench
vlog -sv +define+DISABLE_DEFAULT_NET $rtl/mapping/kernel/BundleKernelMapper.sv
vlog -sv +define+DISABLE_DEFAULT_NET $rtl/mapping/kernel/BundleKernelGenerator.sv

vlog -sv +define+DISABLE_DEFAULT_NET $tb/KernelMapper_tb.sv