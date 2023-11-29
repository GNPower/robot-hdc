`timescale 1ns/100ps
`default_nettype none

// the top module of the testbench
module BindMemoryMapperTB;

	localparam CLOCK_PERIOD_NS = 20;
	localparam TESTBENCH_TIMEOUT_CLKS = 100;
	
	localparam HV_DATA_WIDTH = 32;
	localparam HV_ADDRESS_WIDTH = 5;
	
	localparam MAX_HYPERVECTOR_LENGTH = 4;
	localparam TEST_MEMORY_OFFSET = 0;
	
	localparam MAX_SUM_INPUTS = 31;
	localparam INPUT_VERIFICATION_FILE = "../data/ElementMultiplication_F.tst";
	
	logic [HV_DATA_WIDTH-1:0] sum_result;
	int current_input;
	int num_inputs;
	logic [HV_DATA_WIDTH-1:0] sum_inputs [MAX_SUM_INPUTS]; // Arbitrarily Large
	
	
	logic clock;
	logic reset_n;
	
	logic k_valid; // input
	logic k_first; // input
	logic k_last;  // input
	
	logic [HV_DATA_WIDTH-1:0] k_data_in;  // input
	logic [HV_DATA_WIDTH-1:0] k_data_out; // output
	
	logic k_ready; // output
	logic k_done;  // output
	
	ElementMultiplication_F
	#(
		.HV_DATA_WIDTH(HV_DATA_WIDTH)
	)
	Kernel_Inst
	(
		// clock and reset signals
		.clk(clock),
		.reset_n(reset_n),
		
		// address control signals
		.valid(k_valid),
		.first(k_first),
		.last(k_last),
		
		// data
		.data_in(k_data_in),
		.data_out(k_data_out),
		
		// output control signals
		.ready(k_ready),
		.done(k_done)
	);
	

	logic we_n;
	logic [HV_ADDRESS_WIDTH-1:0] address;
	logic [HV_DATA_WIDTH-1:0] data_i;
	logic [HV_DATA_WIDTH-1:0] data_o;
	
	dpRamEmulator 
	#(
		.HV_DATA_WIDTH(HV_DATA_WIDTH),
		.HV_ADDRESS_WIDTH(HV_ADDRESS_WIDTH)
	)
	DPRam_Inst
	(
		.clk(clock),
		.reset_n(reset_n),
		.we_n(we_n),
		.address(address),
		.data_i(data_i),	
		.data_o(data_o)
	);	
	
	
	logic valid;							// input
	logic [HV_ADDRESS_WIDTH-1:0] hva;		// input
	logic [HV_ADDRESS_WIDTH-1:0] hvb;		// input
	logic [HV_ADDRESS_WIDTH-1:0] hvc;		// input
	logic [HV_ADDRESS_WIDTH-1:0] hv_offset;	// input
	logic done;								// output
	
	BindDirectMapper
	#(
		.HV_DATA_WIDTH(HV_DATA_WIDTH),
		.HV_ADDRESS_WIDTH(HV_ADDRESS_WIDTH),
		.MAX_HYPERVECTOR_LENGTH(MAX_HYPERVECTOR_LENGTH)
	)
	UUT
	(
		// clock and reset signals
		.clk(clock),
		.reset_n(reset_n),
		
		// address control signals
		.valid(valid),
		
		// hypervector address components
		.hva(hva),
		.hvb(hvb),
		.hvc(hvc),
		.hv_offset(hv_offset),
		
		// dpram signals
		.we_n(we_n),
		.address(address),
		.data_wr(data_i),
		.data_rd(data_o),
		
		// output control signals
		.done(done),
		
		// address control signals
		.k_valid(k_valid),
		.k_first(k_first),
		.k_last(k_last),
		
		// data
		.k_data_in(k_data_in),
		.k_data_out(k_data_out),
		
		// output control signals
		.k_ready(k_ready),
		.k_done(k_done)
	);
	
	
	always begin
		#(CLOCK_PERIOD_NS/2);
		clock = ~clock;
	end
	
	always begin
		#(TESTBENCH_TIMEOUT_CLKS*CLOCK_PERIOD_NS);
		$error("Testbench Timeout! Max Clock Cycles Exceeded : %0d", TESTBENCH_TIMEOUT_CLKS);
		$stop;
	end
	
	initial begin
		// Initialize clock and reset
		$timeformat(-6, 2, "us", 10);
		$display("%t: Begin Simulation...", $realtime);
		clock = 1'b1;
		reset_n = 1'b0;		
		// Read the verification file
		readVerificationFile(INPUT_VERIFICATION_FILE, num_inputs, sum_result, sum_inputs);
		// Initialize all other logic
		valid = 1'b0;
		hva = 0*MAX_HYPERVECTOR_LENGTH;
		hvb = (num_inputs-1)*MAX_HYPERVECTOR_LENGTH; // NOTE: must happen after verification file is read so num_inputs is initialized
		hvc = num_inputs*MAX_HYPERVECTOR_LENGTH;
		hv_offset = TEST_MEMORY_OFFSET;
		// Raise reset_n after 1 clocks		
		@(posedge clock);
		$display("%t: Raising reset_n", $realtime);
		reset_n = 1'b1;
		// Initialize simulated memory		
		initializeMemory(); // NOTE: must be done after reset, since module sets all contents to 0 on reset		
		// Send the test inputs
		$display("%t: Set valid high", $realtime);
		valid = 1'b1;
		// Wait for completion
		waitResult();
		// Verify kernel output
		verifyOutput();
		// Wait an extra couple clock cycles and end simulation
		@(posedge clock);
		@(posedge clock);
		$display("%t: Simulation Completed!", $realtime);
		$stop;
	end
	
	task waitResult;
	begin		
		@(posedge done);
		valid = 1'b0;
	end
	endtask
	
	task verifyOutput;
	begin
		// Wait since writing happens in idle and has some latency
		@(posedge clock);
		@(posedge clock);
		if(DPRam_Inst.DPRAM_data[(num_inputs*MAX_HYPERVECTOR_LENGTH)+TEST_MEMORY_OFFSET] == sum_result) begin
			$display("%t: Kernel output matches expected output!", $realtime);
			$display("%t: Final Kernel Output: 0b%b", $realtime, DPRam_Inst.DPRAM_data[(num_inputs*MAX_HYPERVECTOR_LENGTH)+TEST_MEMORY_OFFSET]);
		end else begin
			$error("%t: Mismatch between kernel output and expected output!", $realtime);
			$display("%t: Expected 0b%b   :   Got 0b%b", $realtime, sum_result, DPRam_Inst.DPRAM_data[(num_inputs*MAX_HYPERVECTOR_LENGTH)+TEST_MEMORY_OFFSET]);
		end
	end
	endtask
	
	task initializeMemory;
	begin
		$display("%t: Beginning write to memory...", $realtime);
		wait (reset_n == 1'b1);
		@(posedge clock);		
		for (int i = 0; i < num_inputs; i++)
			DPRam_Inst.DPRAM_data[(i*MAX_HYPERVECTOR_LENGTH)+TEST_MEMORY_OFFSET] = sum_inputs[i];
		@(posedge clock);
		$display("%t: Memory write complete", $realtime);
	end
	endtask
	
	task readVerificationFile;
		input string filename;
		output int num_inputs;
		output logic [HV_DATA_WIDTH-1:0] res;
		output logic [HV_DATA_WIDTH-1:0] inputs [MAX_SUM_INPUTS];
	begin
		int infile;
		string line;

		infile = $fopen(filename, "r");
		if (!infile) begin
			$error("File Not Found! : %0d", infile);
		end

		//$fscanf(infile, "%b\n", res);
		$fgets(line, infile);
		res = line.atobin();

		num_inputs = 0;
		while (!$feof(infile)) begin
			//$fscanf(infile, "%b\n", inputs[i]);
			$fgets(line, infile);
			inputs[num_inputs] = line.atobin();
			num_inputs = num_inputs + 1;
		end

		$fclose(infile);
	end
	endtask
	
endmodule
