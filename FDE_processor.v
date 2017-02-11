module FDE_processor(pc, clock);
	
	output pc;
	output clock;
	
	
	reg[15:0] pc;
	reg[39:0] ir;
	reg[7:0] insIdentifier;
	reg[15:0] argument1;
	reg[15:0] argument2;
	wire[15:0] outputArgument;
 	reg[7:0] debugOut;
	
	wire[15:0] pcOut;
	wire[39:0] out;
	reg clock;
	reg prevGedaan = 0;
	reg eersteKlok;
	initial begin
	
		clock = 0;
		pc = 16'b0000000000000000;
		eersteKlok = 0;
	
	end
	always begin
	
	#5	clock = ~clock;
	
	end
	// Doe de opgehaalde instructie in de instruction register, en doe de program counter + 1
	always @ (posedge clock) begin
		if(eersteKlok != 0) begin
				ir = out;
				insIdentifier = ir[39:32];
				argument1 = ir[31:16];
				argument2 = ir[15:0];
				if(prevGedaan == 0) begin
					pc = pcOut;
				end
				prevGedaan = ~prevGedaan;
		
		end
		else if(eersteKlok == 0) begin
		
			eersteKlok = 1;
		
		end
	end
	
	

	
	instructie_decoder deca(insIdentifier, clock, argument1, argument2, outputArgument);
	program_rom rom(pc, clock, out);
	ALUcontroller alu(pc, 16'b0000000000000001, pcOut, 6'b001000);
	
endmodule
