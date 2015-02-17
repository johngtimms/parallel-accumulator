// EE 454
// Spring 2015
// Lab 2 Part 2
// John Timms
// accumulator_processor_tb.v

`timescale 1 ns / 100 ps

module accumulator_processor_tb;

////////////////////////////////////////////////////////////////////////////////////////////////
// Set up the clock and reset
////////////////////////////////////////////////////////////////////////////////////////////////

reg clk_tb, reset_tb;
localparam CLK_PERIOD = 20;
integer clk_count;

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
// Set up the processor module for testing
////////////////////////////////////////////////////////////////////////////////////////////////

localparam
	NOP	  = 2'b00, // No operation
	FETCH = 2'b01, // Fetch an operand from the memory
	SEND  = 2'b10, // Send a result to the memory

wire [1:0] op_tb;
wire signal_tb;
reg [31:0] read_tb;
wire [31:0] write_tb;
wire req_tb;
reg grant_tb;
wire [6:0] state_tb;
reg [4*8:1] state_string;

always @(*)
begin
	case (state_tb)
		7'b0000001: state_string = "REQ1";
		7'b0000010: state_string = "RECA";
		7'b0000100: state_string = "REQ2";
		7'b0001000: state_string = "RECB";
		7'b0010000: state_string = "ADD ";
		7'b0100000: state_string = "REQ3";
		7'b1000000: state_string = "RSLT";
		default: state_string = "UNKN";
	endcase
end

// accumulator_processor (clk, reset, op, signal, read, write, req, grant)
accumulator_processor UUT (clk_tb, reset_tb, op_tb, signal_tb, read_tb, write_tb, req_tb, grant_tb, state_tb)

////////////////////////////////////////////////////////////////////////////////////////////////
// Run the test
////////////////////////////////////////////////////////////////////////////////////////////////

initial
begin
	results = $fopen("processor.txt", "w");
	
	wait (!reset_tb);
	
	while (clk_count < 100) begin
		@(posedge clk_tb)
		$fdisplay (results, "Clock");
	end
	
	$fclose (results);
	
	$stop;
end

endmodule
