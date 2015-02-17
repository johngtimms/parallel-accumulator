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

reg clk_tb, reset_tb;
localparam CLK_PERIOD = 20;
integer clk_count, results;

initial
begin : CLK_GENERATOR
	clk_tb = 0;
	forever
	begin
		#(CLK_PERIOD/2) clk_tb = ~clk_tb;
	end 
end

initial
begin : RESET_GENERATOR
	reset_tb = 1;
	#(2 * CLK_PERIOD) reset_tb = 0;
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

integer load_count = 0;

accumulator_top UUT (clk_tb, clk_tb, reset_tb, load, result);

////////////////////////////////////////////////////////////////////////////////////////////////
// Run the test
////////////////////////////////////////////////////////////////////////////////////////////////

initial
begin		
	wait (!reset_tb);
	
	while (load_count < 1023) begin
		@(posedge clk_tb)
		load <= {$random} % 65536;
		load_count <= load_count + 1;
	end
	
	@(posedge clk_tb)
	load <= 32'b0;
	
	wait(result !== 'bx);
	
	@(posedge clk_tb)
	$stop;
end

endmodule
