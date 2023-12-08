`timescale 1ns/100ps
`default_nettype none

// the top module of the testbench
module SimilarityKernelTB;

	localparam CLOCK_PERIOD_NS = 20;
	localparam TESTBENCH_TIMEOUT_CLKS = 100;
	
	localparam HV_DATA_WIDTH = 32;
	
	localparam MAX_SUM_INPUTS = 5000;
	localparam INPUT_VERIFICATION_FILE = "../data/CosineSimilarity_F.tst";
	
	logic [HV_DATA_WIDTH-1:0] aa_result;
	logic [HV_DATA_WIDTH-1:0] bb_result;
	logic [HV_DATA_WIDTH-1:0] ab_result;
	int current_input;
	int num_inputs;
	logic [HV_DATA_WIDTH-1:0] sim_inputs [MAX_SUM_INPUTS]; // Arbitrarily Large
	
	
	logic clock;
	logic reset_n;
	
	logic valid; // input
	logic first; // input
	logic last;  // input
	
	logic [HV_DATA_WIDTH-1:0] data_in;  // input
	logic [HV_DATA_WIDTH-1:0] AA_out; // output
	logic [HV_DATA_WIDTH-1:0] BB_out; // output
	logic [HV_DATA_WIDTH-1:0] AB_out; // output
	
	logic ready; // output
	logic done;  // output
	
	
	CosineSimilarity_F
	#(
		.HV_DATA_WIDTH(HV_DATA_WIDTH)
	)
	UUT
	(
		// clock and reset signals
		.clk(clock),
		.reset_n(reset_n),
		
		// address control signals
		.valid(valid),
		.first(first),
		.last(last),
		
		// data
		.data_in(data_in),
		.AA_out(AA_out),
		.BB_out(BB_out),
		.AB_out(AB_out),
		
		// output control signals
		.ready(ready),
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
		// Initialize all other logic
		valid = 1'b0;
		first = 1'b0;
		last = 1'b0;		
		data_in = {HV_DATA_WIDTH{1'b0}};
		current_input = 0;
		// Read the verification file
		readVerificationFile(INPUT_VERIFICATION_FILE, num_inputs, aa_result, bb_result, ab_result, sim_inputs);
		// Raise reset_n after 1 clocks
		@(posedge clock);
		reset_n <= 1'b1;
		// Send the test inputs
		for(current_input = 0; current_input < num_inputs; current_input++) begin
			sendInput(current_input);
		end
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
	
	task sendInput;
		input int i;
	begin		
		#1;
		wait (ready == 1'b1);
		
		valid = 1'b1;
		data_in = sim_inputs[i];
		if (i == 0) begin
			first = 1'b1;
		end
		if (i >= num_inputs - 1) begin
			last = 1'b1;
		end
				
		@(posedge clock);
		valid = 1'b0;
		first = 1'b0;
		last = 1'b0;				
	end
	endtask
	
	
	task waitResult;
	begin		
		@(posedge done);
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
