// EE 454
// Spring 2015
// Lab 2 Part 2
// John Timms
// accumulator_top.v
//
// load wire is for testbench
//

`timescale 1 ns / 100 ps

module accumulator_top (bus_clk, proc_clk, reset, load, result);

// Signals for this module
input bus_clk, proc_clk, reset;
input [31:0] load;
output [31:0] result;

// Signals for the arbiter
wire [3:0] req;
wire [3:0] grant;

// Signals for the memory
wire [1:0] op;
wire signal;
wire [31:0] read;
wire [31:0] write;
wire load_signal, full;
wire [9:0] index;
wire [31:0] preview;
wire [4:0] state;

assign load_signal = (load != 0) ? 1'b1 : 1'b0;
assign write = (load != 0) ? load : 'bz;
assign read = (load != 0) ? load : 32'bz;
assign result = (state == 5'b10000 && read !== 'bx) ? read : 'bx;

// RoundRobinArbiter 			(clk, req, grant)
RoundRobinArbiter 		arbiter	(proc_clk, req, grant);
// accumulator_memory 			(clk, reset, op, signal, read, write, load, full, index, preview, state)
accumulator_memory		memory	(bus_clk, reset, op, signal, read, write, load_signal, full, index, preview, state);
// accumulator_processor 		(clk, reset, op, signal, read, write, req, grant)
accumulator_processor 	proc0 	(proc_clk, reset, op, signal, read, write, req[0], grant[0]);
accumulator_processor 	proc1 	(proc_clk, reset, op, signal, read, write, req[1], grant[1]);
accumulator_processor	proc2 	(proc_clk, reset, op, signal, read, write, req[2], grant[2]);
accumulator_processor 	proc3 	(proc_clk, reset, op, signal, read, write, req[3], grant[3]);

endmodule
 