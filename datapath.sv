// DATAPATH

module datapath #(parameter N = 64) (
		input logic reset, clk,
		input logic Exc, ERet,
		input logic reg2loc,
		input logic [1:0] AluSrc,
		input logic [3:0] AluControl,
		input logic	Branch,
		input logic memRead,
		input logic memWrite,
		input logic regWrite,	
		input logic memtoReg,
		input logic [3:0] EStatus,
		input logic [31:0] IM_readData,
		input logic [N-1:0] DM_readData,
		output logic [N-1:0] IM_addr, DM_addr, DM_writeData,
		output logic DM_writeEnable, DM_readEnable, ExcAck
	);

	logic PCSrc, EProc_F;
	logic [N-1:0] PCBranch, PCBranch_E, EVAddr_F, NextPC_F, writeData_E, writeData3;
	logic [N-1:0] signImm, readData1, readData2, readData3_E;
	logic zero;

	fetch #(64) FETCH(
		.PCSrc_F(PCSrc),
		.clk(clk),
		.reset(reset),
		.EProc_F(EProc_F),
		.PCBranch_F(PCBranch),
		.EVAddr_F(EVAddr_F),
		.imem_addr_F(IM_addr),
		.NextPC_F(NextPC_F)
	);

	decode #(64) DECODE(
		.regWrite_D(regWrite),
		.reg2loc_D(reg2loc), 
		.clk(clk),
		.writeData3_D(writeData3),
		.instr_D(IM_readData), 
		.signImm_D(signImm), 
		.readData1_D(readData1),
		.readData2_D(readData2)
	);

	execute #(64) EXECUTE(
		.AluSrc(AluSrc),
		.AluControl(AluControl),
		.PC_E(IM_addr), 
		.signImm_E(signImm), 
		.readData1_E(readData1), 
		.readData2_E(readData2), 
		.readData3_E(readData3_E),
		.PCBranch_E(PCBranch_E), 
		.aluResult_E(DM_addr), 
		.writeData_E(DM_writeData), 
		.zero_E(zero)
	);

	memory MEMORY(
		.Branch_M(Branch), 
		.zero_M(zero), 
		.PCSrc_M(PCSrc)
	);

	writeback #(64) WRITEBACK(
		.aluResult_W(DM_addr),
		.DM_readData_W(DM_readData), 
		.memtoReg(memtoReg), 
		.writeData3_W(writeData3)
	);

	exception EXCEPTION(
		.reset(reset), .clk(clk), .Exc(Exc), .ERet(ERet),
		.imem_addr_F(IM_addr), .NextPC_F(NextPC_F), .PCBranch_E(PCBranch_E),
		.IM_readData(IM_readData),
		.EStatus(EStatus),
		.ExcAck(ExcAck),
		.readData3_E(readData3_E),
		.PCBranch(PCBranch), .Exc_vector(EVAddr_F)
	);

	// Salida de señales de control:
	assign DM_writeEnable = memWrite;
	assign DM_readEnable = memRead;

endmodule
