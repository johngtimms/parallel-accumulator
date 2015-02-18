// EE 454
// Spring 2015
// Lab 2 Part 2
// John Timms
// RoundRobinArbiter.v

module RoundRobinArbiter (clk, req, grant);

  input clk;
  input [3:0] req;
  output [3:0] grant;
  
  reg [3:0] grant = 4'b0000;
  reg [3:0] mask = 4'b0000;
  wire [3:0] unmasked_req, unmasked_grant, masked_req, masked_grant;
  
  assign unmasked_req = req;
  assign masked_req = req & mask;
  
  FixedPriorityArbiter unmasked_arbiter (unmasked_req, unmasked_grant);
  FixedPriorityArbiter masked_arbiter (masked_req, masked_grant);
  
  always @(negedge req[0], negedge req[1], negedge req[2], negedge req[3])
  begin
	grant <= ~|masked_req ? unmasked_grant : masked_grant;
  end
  
  always @(posedge clk)
  begin
	if (grant == 0 && req != 0) begin
		grant <= ~|masked_req ? unmasked_grant : masked_grant;
	end
	mask <= {grant[0],
			 grant[0] || grant[3],
			 grant[0] || grant[2] || grant[3],
			 grant[1] || grant[2] || grant[3]};
  end

endmodule 
