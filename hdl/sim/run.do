# handle command line arguments
if { $argc != 1} {
    puts "The run.do script requires TopLevel testbench as input argument (int)"
    puts "For example:"
	puts "1 - BundleKernelTB (BundleKernel_tb.sv)"
    puts "Please try again."
	error "Missing input arguments"
}

if {$1 > 9 || $1 < 1} {
	puts "TopLevel testbench input ID invalid"
    puts "Valid input IDs are:"
	puts "1 - BundleKernelTB (BundleKernel_tb.sv)"
	puts "2 - BundleMemoryMapperTB (BundleMemoryMapper_tb.sv)"
	puts "3 - BundleKernelMapperTB (BundleKernelMapper_tb.sv)"
	puts "4 - BindKernelTB (BindKernel_tb.sv)"
	puts "5 - BindMemoryMapperTB (BindMemoryMapper_tb.sv)"
	puts "6 - BindKernelMapperTB (BindKernelMapper_tb.sv)"
	puts "7 - SimilarityKernelTB (SimilarityKernel_tb.sv)"
	puts "8 - SimilarityMemoryMapperTB (SimilarityMemoryMapper_tb.sv)"
	puts "9 - SimilarityKernelMapperTB (SimilarityKernelMapper_tb.sv)"
    puts "Please try again."
	error "Invalid input arguments"
}

# set up paths, top-level module, ...
do setenv.do $1

# add 3rd party simulation libraries (this replaces the vsim command)
do ipgen.do

# compile the source files
do compile.do

# Set the top-level testbench name, used by elab to elaborate the top level
set TOP_LEVEL_NAME $top

# Call the command to elaborate your design and testbench
elab_debug

# Clear previous simulation
restart -f

# add signals to waveform
do waves.do $1

# run simulation
run -all

do save.do $1
