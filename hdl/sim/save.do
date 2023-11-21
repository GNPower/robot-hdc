# MemoryMapperTB
if { $1 == 2 || $1 == 3 } {
	mem save -o DPRAM.mem -f mti -data hex -addr hex -startaddress 0 -endaddress 31 -wordsperline 8 /$top/DPRam_Inst/DPRAM_data
}