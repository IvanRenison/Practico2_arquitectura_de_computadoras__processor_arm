// ALU CONTROL DECODER

module aludec (
		input  logic [10:0] funct,  
		input  logic [1:0]  aluop,  
		output logic [3:0] alucontrol
	);

	always_comb
		if (aluop == 2'b00) // LDUR or STUR
			alucontrol = 4'b0010;
		else if (aluop == 2'b01) // CBZ
			alucontrol = 4'b0111; 
		else if((aluop == 2'b10) & (funct == 11'b10001011000)) // ADD
			alucontrol = 4'b0010;
		else if((aluop == 2'b10) & (funct == 11'b11001011000)) // SUB
			alucontrol = 4'b0110;
		else if((aluop == 2'b10) & (funct == 11'b10001010000)) // AND
			alucontrol = 4'b0000;
		else if((aluop == 2'b10) & (funct == 11'b10101010000)) // OR
			alucontrol = 4'b0001;
		else
			alucontrol = 4'b0000;
endmodule
