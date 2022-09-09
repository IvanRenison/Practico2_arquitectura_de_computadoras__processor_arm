module comp_n #(parameter N = 64) (
		input logic [N-1:0] x, y,
		output logic res
	);

	assign res = (x == y);

endmodule
