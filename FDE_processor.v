module FDE_proc(pc, clock, ir, out, pcOut);

	output pc;
	output ir;
	
	input pcOut;
	input clock;
	input out;
	
	reg[16:0] pc;
	reg[40:0] ir;
	reg[8:0] insIdentifier;
	reg[8:0] debugOut;
	
	wire[16:0] pcOut;
	wire[40:0] out;
	wire clock;
	
	initial begin
	
		pc = 16'b0000000000000000;
		
	end
	
	// Doe de opgehaalde instructie in de instruction register, en doe de program counter + 1
	always @ (posedge clock) begin
		ir = out;
		pc = pcOut;
		insIdentifier = ir[8:0];
	end
	
	instructie_decoder deca(insIdentifier, clock, debugOut);
	program_rom rom(pc, clock, out);
	ALUcontroller alu(pc, 1'b1, pcOut, 6'b001000);
	
endmodule
