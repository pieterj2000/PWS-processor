module FDE_processor(clock, led_pin, led_register, schakelaar_register, knoppen_register);
	
	input clock;
	input schakelaar_register;
	input knoppen_register;
	
	output led_register;
	output led_pin;
//	output clock;
	
	reg[15:0] pc;
	reg[15:0] pcBuffy;
	reg[39:0] ir;
	reg[7:0] insIdentifier;
	reg[15:0] argument1;
	reg[15:0] argument2;
	reg[7:0] debugOut;
	reg[30:0] counter;
	
	reg[7:0] led_register;
	reg led_pin;
	
	wire[7:0] schakelaar_register;
	wire[3:0] knoppen_register;
	
	wire[15:0] outputArgument;
 	
	wire[7:0] led_register_buffer;
	
	wire[15:0] pcOut;
	wire[39:0] out;
	
	wire clock;
//	reg clock;
	
	reg prevGedaan = 0;
	reg eersteKlok;
	initial begin
		led_pin = 1;
	//	clock = 0;
		pc = 16'b0000000000000000;
		eersteKlok = 0;
		
	end
/*	always begin
	
	#10	clock = ~clock;
	
	end */
	// Doe de opgehaalde instructie in de instruction register, en doe de program counter + 1
	always @ (posedge clock) begin
	//	if(eersteKlok != 0) begin
				if(insIdentifier == 8'b00001001) begin
					pc = pcBuffy;
					#1;
				end
				ir = out;
				insIdentifier = ir[39:32];
				argument1 = ir[31:16];
				argument2 = ir[15:0];
				pc = pcOut;
				
				if(counter == 25000000) begin
					led_pin = ~led_pin;
					counter = 0;
				end
				
				counter = counter + 1;
	//	end
	//	else if(eersteKlok == 0) begin
//		
	//		eersteKlok = 1;
		
	//	end
	end
	always @ (*) begin
		if(insIdentifier == 8'b00001001) begin
			pcBuffy = outputArgument;
		end
		led_register = led_register_buffer;
	//	led_register[0] = 1;
	end
	

	
	instructie_decoder deca(insIdentifier, clock, argument1, argument2, outputArgument,led_register_buffer, schakelaar_register, knoppen_register);
	program_rom rom(pc, clock, out);
	ALUcontroller alu(pc, 16'b0000000000000001, pcOut, 9'b000001000);
	
endmodule
