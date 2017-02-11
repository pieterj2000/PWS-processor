module register_controller(chip_enable, write_enable, clock, address, valueIn, valueOut);

	input write_enable;
	input chip_enable;
	input clock;
	input address;
	input valueIn;
	
	output valueOut;
	
	wire write_enable;
	wire chip_enable;
	wire clock;
	wire[3:0] address;
	wire[15:0] valueIn;
	reg[15:0] valueOut;
	
	reg nigguh;
	reg[7:0] i;
	reg[7:0] j;
	
	reg[15:0] gpr[7:0];
	
	initial begin
	
		nigguh = 0;

		
		for(i = 0; i < 8; i = i + 1) begin
		
			for(j = 0; j < 16; j = j + 1) begin
			
				gpr[i][j] = 0;
			
			end
		
		end
	
	end
	
	
	always @ (*) begin
		nigguh = ~nigguh;
		if(chip_enable == 1) begin
			if(write_enable == 1) begin
				gpr[address] = valueIn;
			end
			else if(write_enable == 0) begin
				valueOut = gpr[address];
			end
		end
		

	
	end


endmodule
