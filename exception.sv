module exception(
		input logic reset, clk, Exc, ERet,
		input logic [63:0] imem_addr_F, NextPC_F, PCBranch_E,
		input logic [31:0] IM_readData,
		input logic [3:0] EStatus,
		output logic ExcAck,
		output logic [63:0] readData3_E,
		output logic [63:0] PCBranch
	);

endmodule
