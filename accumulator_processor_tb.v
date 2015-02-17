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
	SEND  = 2'b10; // Send a result to the memory
	
localparam 
	REQ1 = 7'b0000001, // Request 1 state - requests the bus to receive A
	RECA = 7'b0000010, // Receive A state - receives A from the bus
	REQ2 = 7'b0000100, // Request 2 state - requests the bus to receive B
	RECB = 7'b0001000, // Receive B state - receives B from the bus
	ADD  = 7'b0010000, // Add state       - adds A and B
	REQ3 = 7'b0100000, // Request 3 state - requests the bus to send the result
	RSLT = 7'b1000000; // Result state    - sends the result over the bus

wire [1:0] op_tb;
reg signal_tb = 0;
reg [31:0] read_tb;
wire [31:0] write_tb;
wire req_tb;
reg grant_tb = 0;
wire [6:0] state_tb;
reg [4*8:1] state_string;

integer A;
integer B;
reg [6:0] state_internal = REQ1;

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
accumulator_processor UUT (clk_tb, reset_tb, op_tb, signal_tb, read_tb, write_tb, req_tb, grant_tb, state_tb);

////////////////////////////////////////////////////////////////////////////////////////////////
// Run the test
////////////////////////////////////////////////////////////////////////////////////////////////

initial
begin
	A = {$random} % 65536;
	B = {$random} % 65536;
end

always @(posedge clk_tb)
begin
	case (state_internal)
	
		REQ1:
		begin
			if (req_tb) begin
				grant_tb <= 1;
				state_internal <= RECA;
			end
		end
		
		RECA:
		begin
			if (op_tb == FETCH) begin
				read_tb <= A;
				signal_tb <= 1;
				state_internal <= REQ2;
			end
		end
		
		REQ2:
		begin
			grant_tb <= 0;
			signal_tb <= 0;
			if (req_tb) begin
				grant_tb <= 1;
				state_internal <= RECB;
			end
		end
		
		RECB:
		begin
			if (op_tb == FETCH) begin
				read_tb <= B;
				signal_tb <= 1;
				state_internal <= ADD;
			end
		end
		
		ADD:
		begin
			grant_tb <= 0;
			signal_tb <= 0;
			state_internal <= REQ3;
		end
		
		REQ3:
		begin
			if (req_tb) begin
				grant_tb <= 1;
				state_internal <= RSLT;
			end
		end
		
		RSLT:
		begin
			if (clk_count == 50) begin
				$stop;
			end
		end
	
	endcase
end

endmodule
