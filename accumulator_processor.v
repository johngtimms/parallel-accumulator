// EE 454
// Spring 2015
// Lab 2 Part 2
// John Timms
// accumulator_processor.v
 
`timescale 1 ns / 100 ps
 
module accumulator_processor (clk, reset, op, data, req, grant);
 
input clk, reset, grant;
inout [1:0] op;
inout [31:0] data;
output req;

reg req_internal; 
reg [4:0] state;
reg [1:0] op_internal;
reg [31:0] A;
reg [31:0] B;
reg [31:0] result;
 
localparam
	NOP	  = 2'b00, // No operation
	FETCH = 2'b01, // Fetch an operand from the memory
	SEND  = 2'b10, // Send a result to the memory
	END	  = 2'b11; // Memory has finished fetch/send
 
localparam 
	REQ1 = 7'b0000001, // Request 1 state - requests the bus to receive A
	RECA = 7'b0000010, // Receive A state - receives A from the bus
	REQ2 = 7'b0000100, // Request 2 state - requests the bus to receive B
	RECB = 7'b0001000, // Receive B state - receives B from the bus
	ADD  = 7'b0010000, // Add state       - adds A and B
	REQ3 = 7'b0100000, // Request 3 state - requests the bus to send the result
	RSLT = 7'b1000000; // Result state    - sends the result over the bus
	
assign req = req_internal;
assign op = (op_internal == FETCH || op_internal == SEND) ? op_internal : 2'bz;
assign data = (state == RSLT) ? result : 32'bz;
	
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
				req_internal <= 1'b1;
				
				if (grant) begin
					op_internal <= FETCH;
					state <= RECA;
				end
			end
			
			RECA:
			begin
				op_internal <= NOP;
				A <= data;
				
				if (op == END) begin
					req_internal <= 1'b0;
					state <= REQ2;
				end
			end
			
			REQ2:
			begin
				req_internal <= 1'b1;
				
				if (grant) begin
					op_internal <= FETCH;
					state <= RECB;
				end
			end
			
			RECB:
			begin
				op_internal <= NOP;
				B <= data;
				
				if (op == END) begin
					req_internal <= 1'b0;
					state <= ADD;
				end
			end
			
			ADD:
			begin
				result <= A + B;
				state <= REQ3;
			end
			
			REQ3:
			begin
				req_internal <= 1'b1;
				
				if (grant) begin
					op_internal <= SEND;
					state <= RSLT;
				end
			end
			
			RSLT:
			begin
				op_internal <= NOP;
				
				if (op == END) begin
					req_internal <= 1'b0;
					state <= REQ1;
				end
			end
			
		endcase
	end
end

endmodule
 