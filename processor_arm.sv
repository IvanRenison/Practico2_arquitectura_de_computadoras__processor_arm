// TOP-LEVEL PROCESSOR

module processor_arm #(parameter N = 64) (
		input logic CLOCK_50, reset, ExtIRQ,
		output logic [N-1:0] DM_writeData, DM_addr,
		output logic ExtlAck,
		output logic DM_writeEnable,
		input	logic dump
	);

	logic [31:0] q;
	logic [3:0] AluControl, EStatus;
	logic reg2loc, regWrite, Branch, memtoReg, memRead, memWrite;
	logic [1:0] AluSrc;
	logic [N-1:0] DM_readData, IM_address;  //DM_addr, DM_writeData
	logic DM_readEnable; //DM_writeEnable	
	logic ExcAck, Exc, ERet;

	controller c(
		.instr(q[31:21]),
		.reset(reset), .ExtIRQ(ExtIRQ), .ExcAck(ExcAck),
		.AluControl(AluControl),
		.reg2loc(reg2loc),
		.regWrite(regWrite),
		.AluSrc(AluSrc),
		.Branch(Branch),
		.memtoReg(memtoReg),
		.memRead(memRead),
		.memWrite(memWrite),
		.EStatus(EStatus),
		.Exc(Exc),
		.ERet(ERet)
	);

	datapath #(64) dp(
		.reset(reset),
		.clk(CLOCK_50),
		.Exc(Exc), .ERet(ERet),
		.reg2loc(reg2loc),
		.AluSrc(AluSrc),
		.AluControl(AluControl),
		.Branch(Branch),
		.memRead(memRead),
		.memWrite(memWrite),
		.regWrite(regWrite),
		.memtoReg(memtoReg),
		.EStatus(EStatus),
		.IM_readData(q),
		.DM_readData(DM_readData),
		.IM_addr(IM_address),
		.DM_addr(DM_addr),
		.DM_writeData(DM_writeData),
		.DM_writeEnable(DM_writeEnable),
		.DM_readEnable(DM_readEnable),
		.ExcAck(ExcAck)
	);

	imem instrMem(
		.addr(IM_address[7:2]),
		.q(q)
	);

	dmem dataMem(
		.clk(CLOCK_50),
		.memWrite(DM_writeEnable),
		.memRead(DM_readEnable),
		.address(DM_addr[8:3]),
		.writeData(DM_writeData),
		.readData(DM_readData),
		.dump(dump)
	);

endmodule
