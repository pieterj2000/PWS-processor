module instructie_decoder(instructie, clock, argument1, argument2, outputArgument, led_register, schakelaar_register, knoppen_register);

input clock;
input instructie;
input argument1;
input argument2;
input schakelaar_register;
input knoppen_register;

output led_register;
output outputArgument;

wire[7:0] instructie;
wire[15:0] argument1;
wire[15:0] argument2;

reg[7:0] led_register;

wire[7:0] schakelaar_register;
wire[3:0] knoppen_register;


reg[15:0] argumentBuffer;
reg[15:0] argument2Buffer;

reg[15:0] outputArgument;
wire[15:0] outputArgumentBuffer;

wire[7:0] led_register_buffer;

wire[5:0] flagRegister;

reg[7:0] instructieBuffer;
reg[7:0] gevondenInstructie;

reg[15:0] ram_data;
reg[12:0] ram_adres;
wire[15:0] ram_output;

reg ram_write_enable;

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
		ram_write_enable = 0;
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
							instructieOpCode = 9'b000001000;
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
							outputArgument = outputArgumentBuffer;
							valueIn = outputArgument;
							write_enable = 1;
							chip_enable = 1;
							#1
							chip_enable = 0;
							write_enable = 0;
					 end
		// ADD [BX], AX
		8'b10000001 : begin
							instructieOpCode = 9'b000001000;
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
							ram_adres = bufferVal;
							ram_write_enable = 0;
							#1
							bufferVal2 = ram_output;
							#1
							outputArgument = outputArgumentBuffer;
							ram_data = outputArgument;
							ram_write_enable = 1;
					 end
		// ADD [BX], C
		8'b11000001 : begin
							instructieOpCode = 9'b000001000;
							address = argument1[3:0];
							write_enable = 0;
							chip_enable = 1;
							#1
							chip_enable = 0;
							bufferVal = valueOut;
							address = bufferVal;
							bufferVal2 = argument2;
							ram_adres = bufferVal;
							ram_write_enable = 0;
							#1
							bufferVal = ram_output;
							#1
							outputArgument = outputArgumentBuffer;
							ram_data = outputArgument;
							ram_write_enable = 1;
					 end
		// ADD BX, [AX]
		8'b01000001 : begin
							instructieOpCode = 9'b000001000;
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
							ram_adres = bufferVal2;
							ram_write_enable = 0;
							#1
							bufferVal2 = ram_output;
							#1
							outputArgument = outputArgumentBuffer;
							address = argument1[3:0];
							write_enable = 1;
							chip_enable = 1;
							#1
							write_enable = 0;
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
							instructieOpCode = 9'b000001000;
							bufferVal2 = argument2;
							#1
							outputArgument = outputArgumentBuffer;
							valueIn = outputArgumentBuffer;
							address = argument1[3:0];
							write_enable = 1;
							chip_enable = 1;
							#1
							chip_enable = 0;
							write_enable = 0;
					  end
		// SUB A, B in A
	8'b00000010 : begin
							instructieOpCode = 9'b000010000;
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
							outputArgument = outputArgumentBuffer;
							valueIn = outputArgument;
							write_enable = 1;
							chip_enable = 1;
							#1
							chip_enable = 0;
							write_enable = 0;
					  end
		// SUB [BX], AX
		8'b10000001 : begin
							instructieOpCode = 9'b000010000;
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
							ram_adres = bufferVal;
							ram_write_enable = 0;
							#1
							bufferVal2 = ram_output;
							#1
							outputArgument = outputArgumentBuffer;
							ram_data = outputArgument;
							ram_write_enable = 1;
					 end
		// SUB [BX], C
		8'b11000010 : begin
							instructieOpCode = 9'b000010000;
							address = argument1[3:0];
							write_enable = 0;
							chip_enable = 1;
							#1
							chip_enable = 0;
							bufferVal = valueOut;
							address = bufferVal;
							bufferVal2 = argument2;
							ram_adres = bufferVal;
							ram_write_enable = 0;
							#1
							bufferVal = ram_output;
							#1
							outputArgument = outputArgumentBuffer;
							ram_data = outputArgument;
							ram_write_enable = 1;
					 end
		// SUB BX, [AX]
		8'b01000010 : begin
							instructieOpCode = 9'b000010000;
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
							ram_adres = bufferVal2;
							ram_write_enable = 0;
							#1
							bufferVal2 = ram_output;
							#1
							outputArgument = outputArgumentBuffer;
							address = argument1[3:0];
							write_enable = 1;
							chip_enable = 1;
							#1
							write_enable = 0;
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
							instructieOpCode = 9'b000010000;
							bufferVal2 = argument2;
							#1
							outputArgument = outputArgumentBuffer;
							valueIn = outputArgumentBuffer;
							address = argument1[3:0];
							write_enable = 1;
							chip_enable = 1;
							#1
							chip_enable = 0;
							write_enable = 0;
					  end
					// XOR A, B in A
		8'b00000011 : begin
							instructieOpCode = 9'b000100000;
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
							outputArgument = outputArgumentBuffer;
							valueIn = outputArgument;
							write_enable = 1;
							chip_enable = 1;
							#1
							chip_enable = 0;
							write_enable = 0;
					  end
		// OR A, B in A
	8'b00000100 : begin
							instructieOpCode = 9'b000000010;
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
							outputArgument = outputArgumentBuffer;
							valueIn = outputArgument;
							write_enable = 1;
							chip_enable = 1;
							#1
							chip_enable = 0;
							write_enable = 0;
					  end
					  // AND A, B in A
		8'b00000101 : begin
							instructieOpCode = 9'b000000100;
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
							outputArgument = outputArgumentBuffer;
							valueIn = outputArgument;
							write_enable = 1;
							chip_enable = 1;
							#1
							chip_enable = 0;
							write_enable = 0;
					  end
		// NOT A, B in A
	8'b00000110 : begin
							instructieOpCode = 9'b000000001;
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
							outputArgument = outputArgumentBuffer;
							valueIn = outputArgument;
							write_enable = 1;
							chip_enable = 1;
							#1
							chip_enable = 0;
							write_enable = 0;
					  end
	// MOV BX, AX
	8'b00000111 : begin
							address = argument2[3:0];
							write_enable = 0;
							chip_enable = 1;
							#1
							chip_enable = 0;
							bufferVal = valueOut;
							valueIn = bufferVal;
							address = argument1[3:0];
							write_enable = 1;
							chip_enable = 1;
							#1
							chip_enable = 0;
							write_enable = 0;
					  end
	// MOV BX, C
	8'b00000111 : begin
							address = argument1[3:0];
							valueIn = argument2;
							write_enable = 1;
							chip_enable = 1;
							#1
							chip_enable = 0;
							write_enable = 0;
					  end
	// MOV [BX], AX
	8'b10000111 : begin
							address = argument2[3:0];
							write_enable = 0;
							chip_enable = 1;
							#1
							chip_enable = 0;
							bufferVal = valueOut;
							address = argument1[3:0];
							chip_enable = 1;
							#1
							chip_enable = 0;
							ram_adres = valueOut;
							ram_data = bufferVal;
							ram_write_enable = 1;
					  end
	// MOV BX, [AX]
	8'b01000111 : begin
							address = argument2[3:0];
							write_enable = 0;
							chip_enable = 1;
							#1
							chip_enable = 0;
							ram_adres = valueOut;
							write_enable = 0;
							chip_enable = 0;
							ram_write_enable = 0;
							#1
							bufferVal = ram_output;
							valueIn = bufferVal;
							address = argument1[3:0];
							write_enable = 1;
							chip_enable = 1;
							#1
							write_enable = 0;
							chip_enable = 0;	
					  end
	// MOV [BX], C
	8'b01000111 : begin
							address = argument1[3:0];
							write_enable = 0;
							chip_enable = 1;
							ram_write_enable = 0;
							#1
							chip_enable = 0;
							bufferVal = valueOut;
							ram_adres = bufferVal;
							ram_data = argument2;
							ram_write_enable = 1;
					  end
	// JMP BX
	8'b00001001 : begin
							address = argument1[3:0];
							write_enable = 0;
							chip_enable = 1;
							#1
							chip_enable = 0;
							bufferVal = valueOut;
							outputArgument = bufferVal - 1;
					  end
	// JMP C
	8'b10001001 : begin
							outputArgument = argument1 - 1;
					  end
	// JNZ BX
	8'b01001001 : begin
							instructieOpCode = 9'b100000000;	
							address = argument1[3:0];
							write_enable = 0;
							chip_enable = 1;
							#1
							chip_enable = 0;
							bufferVal = valueOut;
							if(flagRegister[2] == 0) begin
								outputArgument = bufferVal;
							end
							
					  end
	// JNZ C
	8'b11001001 : begin
							if(flagRegister[2] == 0) begin
								outputArgument = argument1;
							end
							
					  end
	// JZ BX
	8'b00101001 : begin
							instructieOpCode = 9'b100000000;	
							address = argument1[3:0];
							write_enable = 0;
							chip_enable = 1;
							#1
							chip_enable = 0;
							bufferVal = valueOut;
							if(flagRegister[2] == 1) begin
								outputArgument = bufferVal;
							end
							
					  end
	// JZ C
	8'b10101001 : begin
							if(flagRegister[2] == 1) begin
								outputArgument = argument1;
							end
							
					  end
	// JG BX
	8'b01101001 : begin
							instructieOpCode = 9'b100000000;	
							address = argument1[3:0];
							write_enable = 0;
							chip_enable = 1;
							#1
							chip_enable = 0;
							bufferVal = valueOut;
							if(flagRegister[0] == 0 && flagRegister[1] == 1) begin
								outputArgument = bufferVal;
							end
							
					  end
	// JG C
	8'b11101001 : begin
							if(flagRegister[0] == 0 && flagRegister[1] == 1) begin
								outputArgument = argument1;
							end
							
					  end
	// JS BX
	8'b00011001 : begin
							instructieOpCode = 9'b100000000;	
							address = argument1[3:0];
							write_enable = 0;
							chip_enable = 1;
							#1
							chip_enable = 0;
							bufferVal = valueOut;
							if(flagRegister[0] == 0 && flagRegister[1] == 0) begin
								outputArgument = bufferVal;
							end
							
					  end		
	// JS C
	8'b10011001 : begin
							if(flagRegister[0] == 0 && flagRegister[1] == 0) begin
								outputArgument = argument1;
							end
							
					  end
	// JEQ BX
	8'b01011001 : begin
							instructieOpCode = 9'b100000000;	
							address = argument1[3:0];
							write_enable = 0;
							chip_enable = 1;
							#1
							chip_enable = 0;
							bufferVal = valueOut;
							if(flagRegister[0] == 1) begin
								outputArgument = bufferVal;
							end
							
					  end		
	// JEQ C
	8'b11011001 : begin
							if(flagRegister[0] == 1) begin
								outputArgument = argument1;
							end
					  end		
	// JNQ BX
	8'b00111001 : begin
							instructieOpCode = 9'b100000000;	
							address = argument1[3:0];
							write_enable = 0;
							chip_enable = 1;
							#1
							chip_enable = 0;
							bufferVal = valueOut;
							if(flagRegister[0] == 0) begin
								outputArgument = bufferVal;
							end
							
					  end	
	// JNQ C
	8'b10111001 : begin
							if(flagRegister[0] == 0) begin
								outputArgument = argument1;
							end
					  end	
	// JGQ BX
	8'b11111001 : begin
							instructieOpCode = 9'b100000000;	
							address = argument1[3:0];
							write_enable = 0;
							chip_enable = 1;
							#1
							chip_enable = 0;
							bufferVal = valueOut;
							if(flagRegister[0] == 1 || flagRegister[1] == 1) begin
								outputArgument = bufferVal;
							end
							
					  end	
	// JGQ C
	8'b00001010 : begin
							if(flagRegister[0] == 1 || flagRegister[1] == 1) begin
								outputArgument = argument1;
							end
					  end	
	// JSQ BX
	8'b10001010 : begin
							instructieOpCode = 9'b100000000;	
							address = argument1[3:0];
							write_enable = 0;
							chip_enable = 1;
							#1
							chip_enable = 0;
							bufferVal = valueOut;
							if(flagRegister[0] == 1 || flagRegister[1] == 0) begin
								outputArgument = bufferVal;
							end
							
					  end	
	// JSQ C
	8'b01001010 : begin
							if(flagRegister[0] == 1 || flagRegister[1] == 0) begin
								outputArgument = argument1;
							end
					  end	
	// CMP BX, AX
	8'b00001000 : begin
							instructieOpCode = 9'b100000000;	
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
					  end	
	// LSH BX
	8'b00001011 : begin
							instructieOpCode = 9'b001000000;	
							address = argument1[3:0];
							write_enable = 0;
							chip_enable = 1;
							#1
							chip_enable = 0;
							bufferVal = valueOut;
							#1
							outputArgument = outputArgumentBuffer;
							valueIn = outputArgument;
							address = argument1[3:0];
							write_enable = 1;
							chip_enable = 1;
							#1
							write_enable = 0;
							chip_enable = 0;
					  end	
	// LSH [BX]
	8'b10001011 : begin
							instructieOpCode = 9'b001000000;	
							address = argument1[3:0];
							write_enable = 0;
							chip_enable = 1;
							#1
							chip_enable = 0;
							bufferVal = valueOut;
							ram_adres = bufferVal;
							ram_write_enable = 0;
							#1
							outputArgument = ram_output;
							bufferVal = outputArgument;
							#1
							outputArgument = outputArgumentBuffer;
							ram_data = outputArgument;
							ram_write_enable = 1;
					  end	
	// RSH BX
	8'b00001100 : begin
							instructieOpCode = 9'b010000000;	
							address = argument1[3:0];
							write_enable = 0;
							chip_enable = 1;
							#1
							chip_enable = 0;
							bufferVal = valueOut;
							#1
							outputArgument = outputArgumentBuffer;
							valueIn = outputArgument;
							address = argument1[3:0];
							write_enable = 1;
							chip_enable = 1;
							#1
							write_enable = 0;
							chip_enable = 0;
					  end	
	// RSH [BX]
	8'b10001011 : begin
							instructieOpCode = 9'b010000000;	
							address = argument1[3:0];
							write_enable = 0;
							chip_enable = 1;
							#1
							chip_enable = 0;
							bufferVal = valueOut;
							ram_adres = bufferVal;
							ram_write_enable = 0;
							#1
							outputArgument = ram_output;
							bufferVal = outputArgument;
							#1
							outputArgument = outputArgumentBuffer;
							ram_data = outputArgument;
							ram_write_enable = 1;
					  end	
		endcase
	end
	
	always @ (*) begin
	//	led_register = led_register_buffer;
	//	led_register[0] = 1;
	end
	
	ALUcontroller alu(bufferVal, bufferVal2, outputArgumentBuffer, instructieOpCode, flagRegister);
	register_controller regControl(chip_enable, write_enable, clock, address, valueIn, valueOut,led_register_buffer, schakelaar_register, knoppen_register);
	program_ram  ram_controller(ram_adres, clock, ram_data, ram_write_enable, ram_output);
endmodule
