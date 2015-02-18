// EE 454
// Spring 2015
// Lab 2 Part 2
// John Timms
// accumulator_memory.v
//
// clk, reset - self explanatory
// op - operation desired by the processor
// signal - memory tells the processor when it's done
// read -
// write -
// load - indicates that the testbench wants to load numbers
// full - goes high when the memory is full (i.e. index is 1023)
// index - reports the value of I
// preview - reports the value of M[I]
// state - reports the current state
// load, full, index, preview, and state wires are only for the testbench's convenience
//
 
`timescale 1 ns / 100 ps
 
module accumulator_memory (clk, reset, op, signal, read, write, load, full, index, preview, state);
 
input clk, reset, load;
input [1:0] op;
input [31:0] write;
output [31:0] read;
output [31:0] preview;
output signal, full, state;
output [9:0] index;
 
reg [31:0] M [0:1023];
reg [9:0] I;
reg [4:0] state;
reg signal;
reg [31:0] read;
 
localparam
	NOP	  = 2'b00, // No operation
	FETCH = 2'b01, // Fetch an operand from the memory
	SEND  = 2'b10; // Send a result to the memory
 
localparam 
	INI	  = 5'b00001, // Initial state - loads the memory from the testbench
	READ  = 5'b00010, // Read state - sends a number to the processor
	WRITE = 5'b00100, // Write state - writes a number received from the processor
	READY = 5'b01000, // Ready state - waits for the next processor contact
	DONE  = 5'b10000; // Done state - sends the result over the bus

assign preview = M[I];
assign full = ( I == 10'b1111111111 );
assign index = I;

reg [5*8:1] state_string;

always @(*)
begin
	case (state)
		5'b00001: state_string = "INI  ";
		5'b00010: state_string = "READ ";
		5'b00100: state_string = "WRITE";
		5'b01000: state_string = "READY";
		5'b10000: state_string = "DONE ";
		default: state_string = "UNKN ";
	endcase
end

always @(posedge clk, posedge reset) 
begin
	if (reset) begin
		state <= INI;
		I <= 0;
		signal <= 0;
	end
	else begin
		case (state)
		
			// Initial state
			INI	: 
			begin
				if (load && write != 0) begin
					M[I] <= write;
					I <= I + 1;
				end
				
				if (!load && op == FETCH) begin
					state <= READ;
				end
				
				if (!load && op == SEND) begin
					state <= WRITE;
				end
			end
			
			// Read state
			// Finds an M[I] that is non-zero by traveling up the index
			// Puts M[I] on the bus, sets M[I] to zero, increments I
			// Always increments I (if I is not terminal) because reads are 2x common as writes, so it should be faster
			// If I is terminal (i.e. equals 1023) and M[1023] has already been read then it just puts zero on the bus
			READ :
			begin 
				if (I == 1023 && M[I] == 0) begin
					read <= 0;
					signal <= 1;
					state <= READY;
				end
				else begin
					if (M[I] != 0) begin
						read <= M[I];
						signal <= 1;
						M[I] <= 0;
						if (I != 1023)
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
				if (I == 1023 && M[I] == 0) begin
					M[I] <= write;
					signal <= 1;
					I <= I - 1;
					state <= DONE;
				end
				else begin
					if (M[I] == 0) begin
						M[I] <= write;
						signal <= 1;
						state <= READY;
					end
					else begin
						I <= I - 1;
					end
				end
			end
				
			// Ready state
			// Sets signal low (signal is only ever high for one clock)
			// Erases the current read value (if any) to prevent confusion
			// Enforces a period of at least one clock before accepting another operation.
			READY :
			begin
				signal <= 0;
				read <= 'bx;
				
				if (signal == 0 && op == FETCH) begin
					state <= READ;
				end
				
				if (signal == 0 && op == SEND) begin
					state <= WRITE;
				end
			end
				
			// Done state
			// Puts M[I] on the bus. 
			// This state can only be reached when a processor writes and I = 1023.
			DONE :
			begin
				signal <= 0;
				read <= 'bx;
				
				if (signal == 0 && op == SEND && I == 1022) begin
					M[I] <= write;
					signal <= 1;
					I <= I - 1;
				end
				
				if (signal == 0 && op == SEND && I == 1021) begin
					M[I] <= write;
					signal <= 1;
					I <= I - 1;
				end
				
				if (signal == 0 && op == SEND && I == 1020) begin
					M[I] <= write;
					signal <= 1;
					I <= I - 1;
				end
				
				if (signal == 0 && I == 1019) begin
					read <= (M[1023] + M[1022] + M[1021] + M[1020]);
				end
			end   
		endcase
	end 
end 

endmodule
 