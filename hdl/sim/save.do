# BundleMemoryMapperTB
if { $1 == 2 || $1 == 3 || $1 == 5 || $1 == 6 || $1 == 8 || $1 == 9} {
	mem save -o DPRAM.mem -f mti -data hex -addr hex -startaddress 0 -endaddress 31 -wordsperline 8 /$top/DPRam_Inst/DPRAM_data
}