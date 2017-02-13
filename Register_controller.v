module register_controller(chip_enable, write_enable, clock, address, valueIn, valueOut, led_register, schakelaar_register, knoppen_register);

	input write_enable;
	input chip_enable;
	input clock;
	input address;
	input valueIn;
	input schakelaar_register;
	input knoppen_register;
	
	output led_register;
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
	
	reg[7:0] led_register;
	reg[15:0] gpr[7:0];
	
	wire[7:0] schakelaar_register;
	wire[3:0] knoppen_register;
	
	reg[7:0] reg_schakelaar_register;
	reg[3:0] reg_knoppen_register;
	
	reg[3:0] buffyAddress;
	
	initial begin
	
		nigguh = 0;
	
		
		for(i = 0; i < 8; i = i + 1) begin
		
			for(j = 0; j < 16; j = j + 1) begin
			
				gpr[i][j] = 0;
			
			end
		
		end
		for(i = 0; i < 8; i = i + 1) begin
			led_register[i] = 0;
		end
		for(i = 0; i < 4; i = i + 1) begin
			reg_knoppen_register[i] = 0;
		end
		for(i = 0; i < 8; i = i + 1) begin
			reg_schakelaar_register[i] = 0;
		end
		valueOut = 0;
	end
	
	
	always @ (*) begin
		reg_schakelaar_register = schakelaar_register;
		reg_knoppen_register = knoppen_register;
		buffyAddress = address;
		nigguh = ~nigguh;
		if(chip_enable == 1) begin
			if(write_enable == 1) begin
				if(address > 8 && address < 17) begin
					led_register[address - 9] = valueIn[0];
					buffyAddress = address - 9;
					led_register[buffyAddress] = 1;
					if(buffyAddress == 0) begin
					
						led_register[0] = 1;
					
					end
				end
				else begin
					gpr[address] = valueIn;
				end
			end
			else if(write_enable == 0) begin
				if(address >= 8 && address < 17) begin
					valueOut = 16'b0000000000000000;
		//			led_register[0] = 1;
				end
				else if(address > 17 && address < 22) begin
					valueOut = reg_knoppen_register[address - 18];
				end
				else if(address > 21 && address < 30) begin
					valueOut = reg_schakelaar_register[address - 22];
				end
				else if(address < 8) begin
					valueOut = gpr[address];
				end
				else begin
					valueOut = 16'b0000000000000000;
				end
			end
		end
		

	//	led_register[0] = 1;
	end


endmodule
