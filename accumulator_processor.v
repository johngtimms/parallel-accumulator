// EE 454
// Spring 2015
// Lab 2 Part 2
// John Timms
// accumulator_processor.v
 
`timescale 1 ns / 100 ps
 
module accumulator_processor (clk, reset, op, signal, read, write, req, grant, state);
 
input clk, reset, signal, grant;
input [1:0] op;
input [31:0] read;
output [31:0] write;
output req;
output [6:0] state;

reg req = 0; 
reg [6:0] state;
reg [1:0] op_internal;
reg [31:0] A;
reg [31:0] B;
reg [31:0] write_internal;
 
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
	
assign op = (op_internal == FETCH || op_internal == SEND) ? op_internal : 2'bz;
assign write = (state == RSLT) ? write_internal : 32'bz;

reg [4*8:1] state_string;

always @(*)
begin
	case (state)
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
	
always @(posedge clk, posedge reset) 
begin
	if (reset) begin
		state <= REQ1;
		op_internal <= NOP;
	end
	else begin
		case (state)
		
			REQ1:
			begin
				req <= 1'b1;
				
				if (grant) begin
					state <= RECA;
				end
			end
			
			RECA:
			begin
				op_internal <= FETCH;
				A <= read;
				
				if (signal) begin
					op_internal <= NOP;
					req <= 1'b0;
					state <= REQ2;
				end
			end
			
			REQ2:
			begin
				req <= 1'b1;
				
				if (grant) begin
					state <= RECB;
				end
			end
			
			RECB:
			begin
				op_internal <= FETCH;
				B <= read;
				
				if (signal) begin
					op_internal <= NOP;
					req <= 1'b0;
					state <= ADD;
				end
			end
			
			ADD:
			begin
				write_internal <= A + B;
				state <= REQ3;
			end
			
			REQ3:
			begin
				req <= 1'b1;
				
				if (grant) begin
					state <= RSLT;
				end
			end
			
			RSLT:
			begin
				op_internal <= SEND;	
				
				if (signal) begin
					op_internal <= NOP;
					req <= 1'b0;
					state <= REQ1;
				end
			end
			
		endcase
	end
end

endmodule
 