module mux4 #(parameter N = 64)
				(input logic [N-1:0] d0, d1, d2, d3,
				input logic s[1:0],
				output logic [N-1:0] y);

/*	logic [N-1:0] ds [3:0] = '{d0, d1, d2, d3};

	assign y = ds[s]; */
	
	always_comb begin
		case(s)
			2'b00: y <= d0;
			2'b01: y <= d1;
			2'b10: y <= d2;
			2'b11: y <= d3;
		endcase
	end

endmodule
