if { $1 == 1 } {
	do $waves/BundleKernel.do
} elseif { $1 == 2 } {
	do $waves/BundleMemoryMapper.do
} elseif { $1 == 3 } {
	do $waves/BundleKernelMapper.do
} elseif { $1 == 4 } {
	do $waves/BindKernel.do
} elseif { $1 == 5 } {
	do $waves/BindMemoryMapper.do
} elseif { $1 == 6 } {
	do $waves/BindKernelMapper.do
} elseif { $1 == 7 } {
	do $waves/SimilarityKernel.do
} elseif { $1 == 8 } {
	do $waves/SimilarityMemoryMapper.do
} elseif { $1 == 9 } {
	do $waves/SimilarityKernelMapper.do
}