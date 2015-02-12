// EE 454
// Spring 2015
// Lab 2 Part 1
// John Timms
// FixedPriorityArbiter.v

module FixedPriorityArbiter (req, grant);

  input [3:0] req;
  output [3:0] grant;
  
  wire G3 = req[3];
  wire G2 = req[2] & ~req[3];
  wire G1 = req[1] & ~req[2] & ~req[3];
  wire G0 = req[0] & ~req[1] & ~req[2] & ~req[3];
  
  assign grant = {G3,G2,G1,G0};
  
endmodule