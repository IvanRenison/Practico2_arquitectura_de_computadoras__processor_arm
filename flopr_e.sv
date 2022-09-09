module flopr_e #(parameter N = 64) (
		input logic clk, reset, enable, input logic [N-1:0] d,
		output logic [N-1:0] q
	);

	always_ff @(posedge clk, posedge reset)
		if (reset) begin
			q <= '0;
		end
		else begin 
			if (enable) q <= d;
		end

endmodule
