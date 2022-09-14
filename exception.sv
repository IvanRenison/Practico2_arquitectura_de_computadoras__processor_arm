module exception(
		input logic reset, clk, Exc, ERet,
		input logic [63:0] imem_addr_F, NextPC_F, PCBranch_E,
		input logic [31:0] IM_readData,
		input logic [3:0] EStatus,
		output logic ExcAck,
		output logic [63:0] readData3_E,
		output logic [63:0] PCBranch, Exc_vector
	);
	
	logic esync_out;
	logic [63:0] ELR_out, ERR_out, MUX4_out, MUX2_out;
	logic [3:0] ESR_out;
	
	assign Exc_vector = 64'hd8;
	assign ExcAsk = Exc_vector == imem_addr_F;
	
	ESync esync(
		.Exc(Exc), .resetEsync(ExcAck), .reset(reset),
		.out(esync_out)
	);
	
	flopr_e #(64) ELR(
		.clk(clk), .reset(reset), .enable(esync_out & ~reset), .d(imem_addr_F),
		.q(ELR_out)
	);

	flopr_e #(64) ERR(
		.clk(clk), .reset(reset), .enable(esync_out & ~reset), .d(NextPC_F),
		.q(ERR_out)
	);
	
	flopr_e #(4) ESR(
		.clk(clk), .reset(reset), .enable(esync_out & ~reset), .d(EStatus),
		.q(ESR_out)
	);
	
	mux4 #(64) MUX4(
		.d0(ERR_out), .d1(ELR_out), .d2({60'b0, ESR_out}), .d3(64'b0),
		.s('{IM_readData[13], IM_readData[12]}),
		.y(readData3_E)
	);
	
	mux2 #(64) MUX2(
		.d0(PCBranch_E), .d1(ERR_out),
		.s(ERet),
		.y(PCBranch)
	);

endmodule
