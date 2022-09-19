// CONTROLLER

module controller(
		input logic [10:0] instr,
		input logic reset, ExtIRQ, ExcAck,
		output logic [3:0] AluControl, EStatus,
		output logic reg2loc, regWrite, Branch, memtoReg, memRead, memWrite, Exc, ExtIAck, ERet,
		output logic [1:0] AluSrc
	);

	logic [1:0] AluOp_s;
	logic NotAnInstr;

	assign NotAnInstr = EStatus == 4'b0010;
	assign ExtIAck = ExcAck & ExtIRQ;
	assign Exc = ExtIRQ | NotAnInstr;

	maindec decPpal(
		.Op(instr),
		.reset(reset), .ExtIRQ(ExtIRQ),
		.Reg2Loc(reg2loc),
		.ALUSrc(AluSrc),
		.MemtoReg(memtoReg),
		.RegWrite(regWrite),
		.MemRead(memRead),
		.MemWrite(memWrite),
		.Branch(Branch),
		.ALUOp(AluOp_s),
		.EStatus(EStatus),
		.ERet(ERet)
	);

	aludec decAlu(
		.funct(instr),
		.aluop(AluOp_s),
		.alucontrol(AluControl)
	);

endmodule
