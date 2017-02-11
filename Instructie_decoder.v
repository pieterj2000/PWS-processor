module instructie_decoder(instructie, clock, argument1, argument2, outputArgument);

input clock;
input instructie;
input argument1;
input argument2;

output outputArgument;
wire[7:0] instructie;
wire[15:0] argument1;
wire[15:0] argument2;
reg[15:0] argumentBuffer;
reg[15:0] argument2Buffer;

reg[15:0] outputArgument;
wire[15:0] outputArgumentBuffer;

reg[7:0] instructieBuffer;
reg[7:0] gevondenInstructie;

wire clock;

reg[7:0] i;
reg[5:0] instructieOpCode;

reg[15:0] bufferVal;
reg[15:0] bufferVal2;

reg write_enable;
reg chip_enable; 

wire[15:0] valueOut;
reg[15:0] valueIn;
reg[3:0] address;

	always @(negedge clock) begin
		instructieBuffer = instructie;
		// Hier instructies decoderen
		
		// Voor elke instructie zo'n mooi blokje (kutwerk)
		// Decoder logic is exact zoals onze processor het zou doen!
		
	/*	
		if((instructie ^ 8'b00000000) == 0) begin
			outInstructie = 8'b00000001;
		end
		else if((instructie ^ 8'b00000001) == 0) begin
			outInstructie = 8'b00000010;
		end
		else if((instructie ^ 8'b00000010) == 0) begin
			outInstructie = 8'b00000011;
		end
		else if((instructie ^ 8'b00000011) == 0) begin
			outInstructie = 8'b00000100;
		end
		else if((instructie ^ 8'b00000100) == 0) begin
			outInstructie = 8'b00000101;
		end
		else if((instructie ^ 8'b00000101) == 0) begin
			outInstructie = 8'b00000110;
		end
		else if((instructie ^ 8'b00000110) == 0) begin
			outInstructie = 8'b00000111;
		end
	*/
	/*
	for(i = 0; i < 50; i = i + 1) begin
		
		reg b1Buf;
		reg b2Buf;
		reg b3Buf;
		reg b4Buf;
		reg b5Buf;
		reg b6Buf;
		reg b7Buf;
		reg b8Buf;
		reg finalBuf;
	
		b1Buf = instructieBuffer[0] ^ i[0];
		b2Buf = instructieBuffer[1] ^ i[1];
		b3Buf = instructieBuffer[2] ^ i[2];
		b4Buf = instructieBuffer[3] ^ i[3];
		b5Buf = instructieBuffer[4] ^ i[4];
		b6Buf = instructieBuffer[5] ^ i[5];
		b7Buf = instructieBuffer[6] ^ i[6];
		b8Buf = instructieBuffer[7] ^ i[7];
		
		finalBuf = (((b1Buf | b2Buf) | (b3Buf | b4Buf)) | ((b5Buf | b6Buf) | (b7Buf | b8Buf)));
		
		if(finalBuf == 0) begin
			break;
		end
		
	
	end
	*/
	case(instructie)
		// Add register B bij register A
		8'b00000001 : begin
							instructieOpCode = 6'b001000;
							address = argument1[3:0];
							write_enable = 0;
							chip_enable = 1;
							#1
							chip_enable = 0;
							bufferVal = valueOut;
							address = argument2[3:0];
							chip_enable = 1;
							#1
							chip_enable = 0;
							bufferVal2 = valueOut;
							#1
							address = argument1[3:0];
							valueIn = outputArgument;
							write_enable = 1;
							chip_enable = 1;
							#1
							chip_enable = 0;
					 end
		// Add constance B bij register A
	8'b00100001 : begin
							address = argument1[3:0];
							write_enable = 0;
							chip_enable = 1;
							#1
							chip_enable = 0;
							bufferVal = valueOut;
							instructieOpCode = 6'b001000;
							bufferVal2 = argument2[3:0];
							#1
							outputArgument = outputArgumentBuffer;
							valueIn = outputArgumentBuffer;
							address = argument1[3:0];
							write_enable = 1;
							chip_enable = 1;
							#1
							chip_enable = 0;
					  end
		// SUB A, B in A
	8'b00000010 : begin
							address = argument1[3:0];
							write_enable = 0;
							chip_enable = 1;
							#1
							chip_enable = 0;
							bufferVal = valueOut;
							instructieOpCode = 6'010000;
							bufferVal2 = argument2[3:0];
							#1
							outputArgument = outputArgumentBuffer;
							valueIn = outputArgumentBuffer;
							address = argument1[3:0];
							write_enable = 1;
							chip_enable = 1;
							#1
							chip_enable = 0;
					  end
		// SUB A, C in A
	8'b00100010 : begin
							address = argument1[3:0];
							write_enable = 0;
							chip_enable = 1;
							#1
							chip_enable = 0;
							bufferVal = valueOut;
							instructieOpCode = 6'b010000;
							bufferVal2 = argument2[3:0];
							#1
							outputArgument = outputArgumentBuffer;
							valueIn = outputArgumentBuffer;
							address = argument1[3:0];
							write_enable = 1;
							chip_enable = 1;
							#1
							chip_enable = 0;
					  end
					// XOR A, B in A
		8'b00000011 : begin
							address = argument1[3:0];
							write_enable = 0;
							chip_enable = 1;
							#1
							chip_enable = 0;
							bufferVal = valueOut;
							instructieOpCode = 6'100000;
							bufferVal2 = argument2[3:0];
							#1
							outputArgument = outputArgumentBuffer;
							valueIn = outputArgumentBuffer;
							address = argument1[3:0];
							write_enable = 1;
							chip_enable = 1;
							#1
							chip_enable = 0;
					  end
		// OR A, B in A
	8'b00000100 : begin
							address = argument1[3:0];
							write_enable = 0;
							chip_enable = 1;
							#1
							chip_enable = 0;
							bufferVal = valueOut;
							instructieOpCode = 6'000010;
							bufferVal2 = argument2[3:0];
							#1
							outputArgument = outputArgumentBuffer;
							valueIn = outputArgumentBuffer;
							address = argument1[3:0];
							write_enable = 1;
							chip_enable = 1;
							#1
							chip_enable = 0;
					  end
					  // AND A, B in A
		8'b00000101 : begin
							address = argument1[3:0];
							write_enable = 0;
							chip_enable = 1;
							#1
							chip_enable = 0;
							bufferVal = valueOut;
							instructieOpCode = 6'000100;
							bufferVal2 = argument2[3:0];
							#1
							outputArgument = outputArgumentBuffer;
							valueIn = outputArgumentBuffer;
							address = argument1[3:0];
							write_enable = 1;
							chip_enable = 1;
							#1
							chip_enable = 0;
					  end
		// NOT A, B in A
	8'b00000110 : begin
							address = argument1[3:0];
							write_enable = 0;
							chip_enable = 1;
							#1
							chip_enable = 0;
							bufferVal = valueOut;
							instructieOpCode = 6'000001;
							bufferVal2 = argument2[3:0];
							#1
							outputArgument = outputArgumentBuffer;
							valueIn = outputArgumentBuffer;
							address = argument1[3:0];
							write_enable = 1;
							chip_enable = 1;
							#1
							chip_enable = 0;
					  end
		endcase
	end
	ALUcontroller alu(bufferVal, bufferVal2, outputArgumentBuffer, instructieOpCode);
	register_controller regControl(chip_enable, write_enable, clock, address, valueIn, valueOut);
	
endmodule
