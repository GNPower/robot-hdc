`timescale 1ns/100ps
`default_nettype none

// the top module of the testbench
module BindKernelMapperTB;

	localparam CLOCK_PERIOD_NS = 20;
	localparam TESTBENCH_TIMEOUT_CLKS = 100;
	
	/*******************************
	 * 
	 * SELECT THE TYPE OF BIND KERNEL TO GENERATE
	 *
	 * 1 = ElementMultiplication_F
	 *
	 *******************************/
	localparam KERNEL_TO_GENERATE = 1;
	
	localparam HV_DATA_WIDTH = 32;
	localparam HV_ADDRESS_WIDTH = 5;
	
	localparam MAX_HYPERVECTOR_LENGTH = 4;
	
	localparam NUM_PARALLEL_KERNELS = 4;
	
	localparam MAX_SUM_INPUTS = 31;
	localparam INPUT_VERIFICATION_FILE = "../data/BindKernelMapper.tst";
	
	logic [HV_DATA_WIDTH-1:0] sum_result [MAX_SUM_INPUTS]; // Arbitrarily Large
	int num_inputs;
	logic [HV_DATA_WIDTH-1:0] sum_inputs [MAX_SUM_INPUTS]; // Arbitrarily Large
	
	
	logic clock;
	logic reset_n;
	
	logic valid;														// input
	logic [HV_ADDRESS_WIDTH-1:0] vec_length;							// input
	
	logic [HV_ADDRESS_WIDTH-1:0] hva;									// input
	logic [HV_ADDRESS_WIDTH-1:0] hvb;									// input
	logic [HV_ADDRESS_WIDTH-1:0] hvc;									// input
	
	logic [NUM_PARALLEL_KERNELS-1:0] we_n;								// output
	logic [HV_ADDRESS_WIDTH-1:0] address [NUM_PARALLEL_KERNELS-1:0];	// output
	logic [HV_DATA_WIDTH-1:0] data_wr [NUM_PARALLEL_KERNELS-1:0];		// output
	logic [HV_DATA_WIDTH-1:0] data_rd [NUM_PARALLEL_KERNELS-1:0];		// input
	
	logic done;															// output
	
	
	dpRamEmulatorInfPorts
	#(
		.HV_DATA_WIDTH(HV_DATA_WIDTH),
		.HV_ADDRESS_WIDTH(HV_ADDRESS_WIDTH),
		
		.NUM_PORTS(NUM_PARALLEL_KERNELS)
	)
	DPRam_Inst
	(
		.clk(clock),
		.reset_n(reset_n),
		
		.we_n(we_n),
		.address(address),
		.data_i(data_wr),
		.data_o(data_rd)
	);
	
	
	BindKernelMapper
	#(
		.HV_DATA_WIDTH(HV_DATA_WIDTH),
		.HV_ADDRESS_WIDTH(HV_ADDRESS_WIDTH),
		
		.MAX_HYPERVECTOR_LENGTH(MAX_HYPERVECTOR_LENGTH),
		.NUM_PARALLEL_KERNELS(NUM_PARALLEL_KERNELS),
		
		.KERNEL_TO_GENERATE(KERNEL_TO_GENERATE)
	)
	UUT
	(
		// clock and reset signals
		.clk(clock),
		.reset_n(reset_n),
		
		// address and control signals
		.valid(valid),
		.vec_length(vec_length),
		
		// hypervector address components
		.hva(hva),
		.hvb(hvb),
		.hvc(hvc),
		
		// dpram signals
		.we_n(we_n),
		.address(address),
		.data_wr(data_wr),
		.data_rd(data_rd),
		
		// output control signals
		.done(done)
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
		readVerificationFile(INPUT_VERIFICATION_FILE, vec_length, num_inputs, sum_result, sum_inputs);
		// Initialize all other logic
		valid = 1'b0;
		hva = 0*MAX_HYPERVECTOR_LENGTH;
		hvb = (num_inputs-1)*MAX_HYPERVECTOR_LENGTH; // NOTE: must happen after verification file is read so num_inputs is initialized
		hvc = num_inputs*MAX_HYPERVECTOR_LENGTH;
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
		int res_is_valid;
	
		// Wait since writing happens in idle and has some latency
		@(posedge clock);
		@(posedge clock);
		res_is_valid = 1;
		for (int i = 0; i < MAX_HYPERVECTOR_LENGTH; i++) begin
		
			if(DPRam_Inst.DPRAM_data[(num_inputs * MAX_HYPERVECTOR_LENGTH) + i] == sum_result[i]) begin				
			end else begin
				res_is_valid = 0;
				$error("%t: Mismatch between Hypervector output and expected output!", $realtime);
				$display("%t: Index %d   :   Expected 0b%b   :   Got 0b%b", $realtime, i, sum_result[i], DPRam_Inst.DPRAM_data[(num_inputs * MAX_HYPERVECTOR_LENGTH) + i]);
			end
		
		end
		
		if (res_is_valid) begin
			$display("%t: Hypervector output matches expected output!", $realtime);
		end
	end
	endtask
	
	task initializeMemory;
	begin
		$display("%t: Beginning write to memory...", $realtime);
		wait (reset_n == 1'b1);
		@(posedge clock);		
		for (int i = 0; i < MAX_HYPERVECTOR_LENGTH * num_inputs; i++)
			DPRam_Inst.DPRAM_data[i] = sum_inputs[i];
		@(posedge clock);
		$display("%t: Memory write complete", $realtime);
	end
	endtask
	
	task readVerificationFile;
		input string filename;
		output int hv_length;
		output int num_inputs;
		output logic [HV_DATA_WIDTH-1:0] res [MAX_SUM_INPUTS];
		output logic [HV_DATA_WIDTH-1:0] inputs [MAX_SUM_INPUTS];
	begin
		int max_hv;
		int infile;
		string line;
		int i;

		infile = $fopen(filename, "r");
		if (!infile) begin
			$error("File Not Found! : %0d", infile);
		end

		$fgets(line, infile);
		max_hv = line.atoi();
		
		if (max_hv != MAX_HYPERVECTOR_LENGTH) begin
			$error("%t: Verification file has invalid Max Hypervector Length value!", $realtime);
			$display("%t: Expected %d   :   Got %d", $realtime, MAX_HYPERVECTOR_LENGTH, max_hv);
			$display("%t: Both the value of HV Length (first number) of the verification file and the value of MAX_HYPERVECTOR_LENGTH must match", $realtime);
		end
		
		$fgets(line, infile);
		hv_length = line.atoi();
		
		$fgets(line, infile);
		num_inputs = line.atoi();		
		
		for (i = 0; i < MAX_HYPERVECTOR_LENGTH * num_inputs;  i = i + 1) begin
			$fgets(line, infile);
			inputs[i] = line.atobin();
		end
		
		for (i = 0; i < MAX_HYPERVECTOR_LENGTH; i = i + 1) begin
			$fgets(line, infile);
			res[i] = line.atobin();
		end

		$fclose(infile);
	end
	endtask

endmodule
