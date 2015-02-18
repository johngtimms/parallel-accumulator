// EE 454
// Spring 2015
// Lab 2 Part 2
// John Timms
// accumulator_top_tb.v

`timescale 1 ns / 100 ps

module accumulator_top_tb;

////////////////////////////////////////////////////////////////////////////////////////////////
// Set up the testbench components (filesystem, clock, etc.)
////////////////////////////////////////////////////////////////////////////////////////////////

reg bus_clk, proc_clk, reset_tb;
localparam CLK_PERIOD = 5000;
localparam PROC_CLK_PERIOD = 20;
integer clk_count, results;

// Bus clock (slower)
// Timescale is 1ns, CLK_PERIOD is 5000. A period of 5000ns gives a 200 KHz signal.
initial
begin : CLK_GENERATOR
	bus_clk = 0;
	forever
	begin
		#(CLK_PERIOD/2) bus_clk = ~bus_clk;
	end 
end

// Processor clock (faster)
// Timescale is 1ns, PROC_CLK_PERIOD is 20. A period of 20ns gives a 50 MHz signal.
initial 
begin : PROC_CLK_GENERATOR
	proc_clk = 0;
	forever
	begin
		#(PROC_CLK_PERIOD/2) proc_clk = ~proc_clk;
	end
end

// Reset generator
// Reset is run in terms of the slower clock. The slower clock is used for the memory, the
// faster clock is used for the arbiter and processors.
initial
begin : RESET_GENERATOR
	reset_tb = 1;
	#(0.6 * CLK_PERIOD) reset_tb = 0;
end

initial
begin : CLK_COUNTER
	clk_count = 0;
	# (0.6 * CLK_PERIOD);
	forever
	begin
		#(CLK_PERIOD) clk_count <= clk_count + 1;
	end 
end

////////////////////////////////////////////////////////////////////////////////////////////////
// 
////////////////////////////////////////////////////////////////////////////////////////////////

reg [31:0] load = 32'b0;
wire [31:0] result;
reg [31:0] debug = 32'b0;

integer load_count = 0;
integer seed = 8882371;

// accumulator_top (bus_clk, proc_clk, reset, load, result)
accumulator_top UUT (bus_clk, proc_clk, reset_tb, load, result);

////////////////////////////////////////////////////////////////////////////////////////////////
// Run the test
////////////////////////////////////////////////////////////////////////////////////////////////

initial
begin
	while (load_count < 1023) begin
		@(posedge bus_clk)
		load <= {$random(seed)} % 65536;
		debug <= debug + load;
		load_count <= load_count + 1;
	end
	
	@(posedge bus_clk)
	debug <= debug + load;
	load <= 32'b0;
	
	wait(result !== 'bx);
	
	@(posedge bus_clk)
	$stop;
end

endmodule
