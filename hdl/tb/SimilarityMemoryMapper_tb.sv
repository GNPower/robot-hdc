`timescale 1ns/100ps
`default_nettype none

// the top module of the testbench
module SimilarityMemoryMapperTB;

	localparam CLOCK_PERIOD_NS = 20;
	localparam TESTBENCH_TIMEOUT_CLKS = 100;
	
	localparam HV_DATA_WIDTH = 32;
	localparam HV_ADDRESS_WIDTH = 5;
	
	localparam MAX_HYPERVECTOR_LENGTH = 4;
	localparam TEST_MEMORY_OFFSET = 0;
	
	localparam MAX_SUM_INPUTS = 31;
	localparam INPUT_VERIFICATION_FILE = "../data/CosineSimilarity_F.tst";
	
	logic [HV_DATA_WIDTH-1:0] aa_result;
	logic [HV_DATA_WIDTH-1:0] bb_result;
	logic [HV_DATA_WIDTH-1:0] ab_result;
	int current_input;
	int num_inputs;
	logic [HV_DATA_WIDTH-1:0] sim_inputs [MAX_SUM_INPUTS]; // Arbitrarily Large
	
	
	logic clock;
	logic reset_n;
	
	logic k_valid; // input
	logic k_first; // input
	logic k_last;  // input
	
	logic [HV_DATA_WIDTH-1:0] k_data_in;  // input
	logic [HV_DATA_WIDTH-1:0] k_AA_out; // output
	logic [HV_DATA_WIDTH-1:0] k_BB_out; // output
	logic [HV_DATA_WIDTH-1:0] k_AB_out; // output
	
	logic k_ready; // output
	logic k_done;  // output
	
	CosineSimilarity_F
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
		.AA_out(k_AA_out),
		.BB_out(k_BB_out),
		.AB_out(k_AB_out),
		
		// output control signals
		.ready(k_ready),
		.done(k_done)
	);
	

	logic we_n;
	logic [HV_ADDRESS_WIDTH-1:0] address;
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
		.data_i({HV_DATA_WIDTH{1'b0}}),	
		.data_o(data_o)
	);	
	
	
	logic valid;							// input
	logic [HV_ADDRESS_WIDTH-1:0] hva;		// input
	logic [HV_ADDRESS_WIDTH-1:0] hvb;		// input
	logic [HV_ADDRESS_WIDTH-1:0] hv_start;	// input
	logic [HV_ADDRESS_WIDTH-1:0] hv_end;	// input
	logic done;								// output
	logic [HV_DATA_WIDTH-1:0] AA_out;		// output
	logic [HV_DATA_WIDTH-1:0] BB_out;		// output
	logic [HV_DATA_WIDTH-1:0] AB_out;		// output
	
	SimilarityDirectMapper
	#(
		.HV_DATA_WIDTH(HV_DATA_WIDTH),
		.HV_ADDRESS_WIDTH(HV_ADDRESS_WIDTH)
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
		.hv_start(hv_start),
		.hv_end(hv_end),
		
		// dpram signals
		.we_n(we_n),
		.address(address),
		.data_rd(data_o),
		
		// output control signals
		.done(done),
		.AA_out(AA_out),
		.BB_out(BB_out),
		.AB_out(AB_out),
		
		// address control signals
		.k_valid(k_valid),
		.k_first(k_first),
		.k_last(k_last),
		
		// data
		.k_data_in(k_data_in),
		.k_AA_out(k_AA_out),
		.k_BB_out(k_BB_out),
		.k_AB_out(k_AB_out),
		
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
		readVerificationFile(INPUT_VERIFICATION_FILE, num_inputs, aa_result, bb_result, ab_result, sim_inputs);
		// Initialize all other logic
		valid = 1'b0;
		hva = 0;
		hvb = MAX_HYPERVECTOR_LENGTH; // NOTE: must happen after verification file is read so num_inputs is initialized
		hv_start = 0;
		hv_end = (num_inputs / 2) - 1;
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
		if((AA_out === aa_result) & (BB_out === bb_result) & (AB_out === ab_result)) begin
			$display("%t: Kernel output matches expected output!", $realtime);
			$display("%t: Final Kernel Output AA: 0b%b", $realtime, AA_out);
			$display("%t: Final Kernel Output BB: 0b%b", $realtime, BB_out);
			$display("%t: Final Kernel Output AB: 0b%b", $realtime, AB_out);
		end else begin
			if(!(AA_out === aa_result)) begin
				$display("%t: Mismatch between kernel output and expected output for AA!", $realtime);
				$display("%t: Expected AA  0b%b   :   Got AA  0b%b", $realtime, aa_result, AA_out);
			end
			if(!(BB_out === bb_result)) begin
				$display("%t: Mismatch between kernel output and expected output for BB!", $realtime);
				$display("%t: Expected BB  0b%b   :   Got BB  0b%b", $realtime, bb_result, BB_out);
			end
			if(!(AB_out === ab_result)) begin
				$display("%t: Mismatch between kernel output and expected output for AB!", $realtime);
				$display("%t: Expected AB  0b%b   :   Got AB  0b%b", $realtime, ab_result, AB_out);
			end
			$error("%t: Mismatch between kernel output and expected output, see above!", $realtime);
		end
	end
	endtask
	
	task initializeMemory;
	begin
		$display("%t: Beginning write to memory...", $realtime);
		wait (reset_n == 1'b1);
		@(posedge clock);		
		for (int i = 0; i < (num_inputs/2); i++) begin
			DPRam_Inst.DPRAM_data[(i)+TEST_MEMORY_OFFSET] = sim_inputs[(i*2)];
			DPRam_Inst.DPRAM_data[(i+MAX_HYPERVECTOR_LENGTH)+TEST_MEMORY_OFFSET] = sim_inputs[(i*2)+1];
		end
		@(posedge clock);
		$display("%t: Memory write complete", $realtime);
	end
	endtask
	
	task readVerificationFile;
		input string filename;
		output int num_inputs;
		output logic [HV_DATA_WIDTH-1:0] aa_res;
		output logic [HV_DATA_WIDTH-1:0] bb_res;
		output logic [HV_DATA_WIDTH-1:0] ab_res;
		output logic [HV_DATA_WIDTH-1:0] inputs [MAX_SUM_INPUTS];
	begin
		int infile;
		string line;

		infile = $fopen(filename, "r");
		if (!infile) begin
			$error("File Not Found! : %0d", infile);
		end

		$fgets(line, infile);
		aa_res = line.atobin();
		
		$fgets(line, infile);
		bb_res = line.atobin();
		
		$fgets(line, infile);
		ab_res = line.atobin();

		num_inputs = 0;
		while (!$feof(infile)) begin
			$fgets(line, infile);
			inputs[num_inputs] = line.atobin();
			num_inputs = num_inputs + 1;
		end

		$fclose(infile);
	end
	endtask
	
endmodule
