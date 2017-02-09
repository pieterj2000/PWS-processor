module instructie_decoder(instructie, clock, outInstructie);

input clock;
input instructie;
output outInstructie;

wire[8:0] instructie;
	wire clock;
reg[8:0] outInstructie;


	always @(negedge clock) begin

		// Hier instructies decoderen
		
		// Voor elke instructie zo'n mooi blokje (kutwerk)
		
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

	end



endmodule
