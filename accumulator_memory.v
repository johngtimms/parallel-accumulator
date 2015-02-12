// EE 454
// Spring 2015
// Lab 2 Part 2
// John Timms
// accumulator_memory.v
//
// load and full wires are only for the testbench's convenience
//
 
`timescale 1 ns / 100 ps
 
module accumulator_memory (clk, reset, op, data, load, full);
 
input clk, reset, load;
inout [1:0] op;
inout [31:0] data;
output full;
 
reg [1023:0] M [0:31];
reg [9:0] I;
reg [4:0] state;
reg [1:0] op_internal;
reg [31:0] data_internal;
 
localparam
	NOP	  = 2'b00, // No operation
	FETCH = 2'b01, // Fetch an operand from the memory
	SEND  = 2'b10, // Send a result to the memory
	END	  = 2'b11; // Memory has finished fetch/send
 
localparam 
	INI	  = 5'b00001, // Initial state - loads the memory from the testbench
	READ  = 5'b00010, // Read state - sends a number to the processor
	WRITE = 5'b00100, // Write state - writes a number received from the processor
	READY = 5'b01000, // Ready state - waits for the next processor contact
	DONE  = 5'b10000; // Done state - sends the result over the bus
	
assign op = (state == READ || state == WRITE) ? op_internal : 2'bz;
assign data = (state == READ || state == DONE) ? data_internal : 32'bz;
assign full = ( I == 10'b1111111111 );
	
always @(posedge clk, posedge reset) 
begin
	if (reset) begin
		state <= INI;
		I <= 0;
		op_internal <= NOP;
		data_internal <= 0;
	end
	else begin
		case (state)
		
			// Initial state
			INI	: 
			begin
				if (load && data != 0) begin
					M[I] <= data;
					I <= I + 1;
				end
				
				if (op == FETCH) begin
					op_internal <= FETCH;
					state <= READ;
				end
				
				if (op == SEND) begin
					op_internal <= SEND;
					state <= WRITE;
				end
			end
			
			// Read state
			// Finds an M[I] that is non-zero by traveling up the index
			// Puts M[I] on the bus, sets M[I] to zero, increments I
			// Always increments I because reads are 2x common as writes, so it should be faster
			// If I is terminal (i.e. equals 1023) and M[1023] has already been read then it just puts zero on the bus
			READ :
			begin 
				if (I == 1023 && M[I] == 0) begin
					data_internal <= 0;
					op_internal <= END;
					state <= READY;
				end
				else begin
					if (M[I] != 0) begin
						data_internal <= M[I];
						op_internal <= END;
						M[I] <= 0;
						I <= I + 1;
						state <= READY;
					end
					else begin
						I <= I + 1;
					end
				end
			end
				
			// Write state
			// Finds an M[I] that is zero by traveling down the index
			// Puts data into M[I]
			// If I is terminal (i.e. equals 1023) then go to the done state
			WRITE :
			begin
				if (I == 1023) begin
					op_internal <= END;
					state <= DONE;
				end
				else begin
					if (M[I] == 0) begin
						M[I] <= data;
						op_internal <= END;
						state <= READY;
					end
					else begin
						I <= I - 1;
					end
				end
			end
				
			// Ready state	
			READY :
			begin
				if (op == FETCH) begin
					op_internal <= FETCH;
					state <= READ;
				end
				
				if (op == SEND) begin
					op_internal <= SEND;
					state <= WRITE;
				end
			end
				
			// Done state
			// Puts M[I] on the bus. 
			// This state can only be reached when a processor writes and I = 1023.
			DONE :
			begin
				data_internal <= M[I];
			end   
		endcase
	end 
end 

endmodule
 