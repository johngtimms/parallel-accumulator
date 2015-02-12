// EE 454
// Spring 2015
// Lab 2 Part 2
// John Timms
// accumulator_memory_tb.v

`timescale 1 ns / 100 ps

module accumulator_memory_tb;

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
// Set up the memory module for testing
////////////////////////////////////////////////////////////////////////////////////////////////

localparam
	NOP	  = 2'b00, // No operation
	FETCH = 2'b01, // Fetch an operand from the memory
	SEND  = 2'b10, // Send a result to the memory
	END	  = 2'b11; // Memory has finished fetch/send

wire [1:0] op_tb;
wire [31:0] data_tb;
reg load_tb;
wire full_tb;
wire [9:0] index_tb;
wire [4:0] state_tb;
reg [5*8:1] state_string;

reg [1:0] op_internal = NOP;
reg [31:0] data_internal;

integer results;
integer load_count = 0;
integer read_count = 0;

assign op_tb = (op_internal == NOP) ? 2'bz : op_internal;
assign data_tb = (load_count <= 1024) ? data_internal : 32'bz;

always @(*)
begin
	case (state_tb)
		5'b00001: state_string = "INI  ";
		5'b00010: state_string = "READ ";
		5'b00100: state_string = "WRITE";
		5'b01000: state_string = "READY";
		5'b10000: state_string = "DONE ";
		default: state_string = "UNKN ";
	endcase
end

accumulator_memory UUT (clk_tb, reset_tb, op_tb, data_tb, load_tb, full_tb, index_tb, state_tb);

////////////////////////////////////////////////////////////////////////////////////////////////
// Run the test
////////////////////////////////////////////////////////////////////////////////////////////////

initial
begin
	results = $fopen("memory.txt", "w");
	
	while (load_count < 1023) begin
		@(posedge clk_tb)
		load_tb <= 1'b1;
		data_internal <= {$random} % 65536;
		$fdisplay (results, "Load %h, %d", data_internal, load_count);
		load_count <= load_count + 1;
	end
	
	@(posedge clk_tb)
	load_tb <= 1'b0;
	op_internal <= FETCH;
	
	while (read_count < 1023) begin
		@(posedge clk_tb)
		op_internal <= NOP;
	end
	
	$fclose (results);
	
	$stop;
end

endmodule
