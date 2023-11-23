`timescale 1ns/100ps
`default_nettype none

// the top module of the testbench
module BindKernelTB;

	localparam CLOCK_PERIOD_NS = 20;
	localparam TESTBENCH_TIMEOUT_CLKS = 100;
	
	localparam HV_DATA_WIDTH = 32;
	
	localparam MAX_SUM_INPUTS = 5000;
	localparam INPUT_VERIFICATION_FILE = "../data/ElementMultiplication_F.tst";
	
	logic [HV_DATA_WIDTH-1:0] prod_result;
	int current_input;
	int num_inputs;
	logic [HV_DATA_WIDTH-1:0] prod_inputs [MAX_SUM_INPUTS]; // Arbitrarily Large
	
	
	logic clock;
	logic reset_n;
	
	logic valid; // input
	logic first; // input
	logic last;  // input
	
	logic [HV_DATA_WIDTH-1:0] data_in;  // input
	logic [HV_DATA_WIDTH-1:0] data_out; // output
	
	logic ready; // output
	logic done;  // output
	
	
	ElementMultiplication_F
	#(
		.HV_DATA_WIDTH(HV_DATA_WIDTH)
	)
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
		.data_out(data_out),
		
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
		readVerificationFile(INPUT_VERIFICATION_FILE, num_inputs, prod_result, prod_inputs);
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
		data_in = prod_inputs[i];
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
		if(data_out === prod_result) begin
			$display("%t: Kernel output matches expected output!", $realtime);
			$display("%t: Final Kernel Output: 0b%b", $realtime, data_out);
		end else begin
			$error("%t: Mismatch between kernel output and expected output!", $realtime);
			$display("%t: Expected 0b%b   :   Got 0b%b", $realtime, prod_result, data_out);
		end
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
