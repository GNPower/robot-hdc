if { $1 == 1 } {
	do $waves/BundleKernel.do
} elseif { $1 == 2 } {
	do $waves/BundleMemoryMapper.do
} elseif { $1 == 3 } {
	do $waves/KernelMapper.do
}