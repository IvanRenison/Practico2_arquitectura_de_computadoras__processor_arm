// Testbench ProcessorPatterson
// Top-level Entity: processor_arm

module processor_tb();
	localparam  N = 64;
	logic CLOCK_50, reset, ExtIRQ, ExtlAck;
	logic DM_writeEnable;
	logic [N-1:0] DM_writeData, DM_addr;
	logic dump;

	// instantiate device under test
	processor_arm dut(
		.CLOCK_50(CLOCK_50), .reset(reset), .ExtIRQ(ExtIRQ),
		.DM_writeData(DM_writeData), .DM_addr(DM_addr),
		.ExtlAck(ExtlAck),
		.DM_writeEnable(DM_writeEnable),
		.dump(dump)
	);

	// generate clock
	always     // no sensitivity list, so it always executes
		begin
			#5ns CLOCK_50 = ~CLOCK_50;
		end


	initial
		begin
			ExtIRQ = 0;
			CLOCK_50 = 0; reset = 1; dump = 0;
			#20ns reset = 0;
			#5000ns dump = 1;
			#20ns $stop;
		end
endmodule

