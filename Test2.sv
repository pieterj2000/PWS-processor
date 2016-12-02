// Code your design here
// Code your design here
// Code your design here
// Code your design here
  
// ALU module, bevat alle andere module objecten voor de functies

// Operation flag, deze specificeerd welke operatie er uitgevoerd moet worden.
/*
                Operation flag: 

                NOT: 000001
                OR:  000010
                AND: 000100
                ADD: 001000
                SUB: 010000
                XOR: 100000

          */

//`include "ramtest.qip"
//`include "ramtest.v"

//`include "tmp.sv"

	 
module Tester(clock, wen, ren, out);
	input clock;
	//input [7:0] val1;
	//input [7:0] val2;
	
	input wen, ren;
	output [7:0] out;
	
	reg [7:0] address;
	reg [7:0] data;
	wire [7:0] out;
	
	//reg wen;
	//reg ren
	
	initial begin
		address = 8'b00100110;
		data = 8'b00110011;
	end
	
	always @(posedge clock)begin
			
	end


	ramtest ram(address, clock, data, wen, out);
	//asdf	hoi();
	//ALUcontroller alu(val1, val2, )
	
endmodule
			 

module ALUcontroller(val1, val2, output3, opFlag);


  input [15:0] val1;
  input [15:0] val2;
  
  reg [
  
  7:0] val3;
  reg [7:0] val4;
  reg [7:0] val5;
  reg [7:0] val6;
  
  wire cout;
  reg coutReg, endReg;
  wire endCout;
  
  wire [7:0] output1;
  wire [7:0] output2;
  
  reg [7:0] out1Buf;
  reg [7:0] out2Buf;
  
  output [15:0] output3;
  reg [15:0] output3;
  
  input [5:0] opFlag;
  reg [5:0] opBuffer;
  
  reg eFlag;
  
  initial begin
    
 //   $display("val1=%d val2=%d output3=%d opflat=%d", val1, val2, output3, opFlag);
    
    eFlag = 1;
    
  end
  
  
  
  ALU piet(val3,val4, output1, opBuffer, eFlag,1'b0,cout);
  ALU piet2(val5, val6, output2, opBuffer, eFlag,coutReg,endCout);
  
  always @ (*) begin
    
	 
	 
    val3 = val1[7:0];
    val5 = val1[15:8];
    
    val4 = val2[7:0];
    val6 = val2[15:8];
    
    
    opBuffer = opFlag;
    if(^opBuffer === 1'bX) begin
      opBuffer = 1;
    end
    
    coutReg = cout;
    endReg = endCout;
//    $display("De laatste carry is: %d, en de wire: %d", endReg, endCout);
    if(^coutReg === 1'bX) begin
      coutReg = 0;
    end
    if(^endReg === 1'bX) begin
      endReg = 0;
    end
    
    out1Buf = output1;
    out2Buf = output2;
    
    // Als de outputs niet undefined zijn ze naar de buffer schrijven
    if(^out1Buf === 1'bX) begin
      out1Buf = 0;
    end
    if(^out2Buf === 1'bX) begin
      out2Buf = 0;
    end
    
    output3 = 0;
	 
      // Als de outputs ook nog eens niet 0 zijn zijn ze valide, dan de totale output berekenen
   if((output1 != 0) || (output2 != 0)) begin
      // De eerste 8-bits van de totale output zijn de output van piet1
      output3 [7:0] = output1;
      // De tweede o-bits van de totale output zijn de output van piet2, dit is de uitkomst van val 2 + val 4 +         // de carry-out van val1 + val2
      output3 [15:8] = output2;
        
    end
    
    if(opFlag == 6'b010000) begin
      
		
      // 8-bits aftrekken
      if(val5 == 0 && val6 == 0 && endReg) begin
 //      $display("De output wordt slecht gedaan");
        output3[15:8] = 0;
        output3 = 256 - output3;   
      end
      // 16-bits aftrekken
      else if(endReg == 1) begin
  //      $display("De output wordt goed gedaan");
        output3 = 65536 - output3;      
      end
    end
//    $display("Ik kan rekenen en de output is: %d", output3); 
  end
  
endmodule






module ALU(
  a1, a2, out, opFlag, eFlag, cin, cout
);
  
  output [7:0] out;
  output cout;
  
  input [7:0] a1;
  input [7:0] a2;
  input eFlag;
  input cin;
  

  wire eFlag;
  input [5:0] opFlag;
  
  wire coSub;
  reg coSubBuffer;
  wire coAdd;
  reg coAddBuffer;
  wire [7:0] a1;
  wire [7:0] a2;
  wire [5:0] opFlag;
  wire cin;
  
  wire [7:0] poepynot;
  wire [7:0] poepyor;
  wire [7:0] poepyand;
  wire [7:0] poepyxor;
  wire [7:0] poepyadd;
  wire [7:0] poepysub;
  reg [7:0] poep;
  
  reg [7:0] out;
  
  reg bufnot;
  reg bufor;
  reg bufand;
  reg bufxor;
  reg bufadd;
  reg bufsub;
  reg eFlagBuffer;
  
  reg cout;
  
  // Deze buffers worden gebruikt bij de translatie van wires naar registers.
  reg [7:0] bufpoepynot;
  reg [7:0] bufpoepyor;
  reg [7:0] bufpoepyand;
  reg [7:0] bufpoepyxor;
  reg [7:0] bufpoepyadd;
  reg [7:0] bufpoepysub;
  
  reg cinBuffer;
  
  initial begin
    cinBuffer = cin;
 
    if(^cinBuffer === 1'bX) begin   
      cinBuffer = 0;
    end
 //   $display("De Cin is op het begin: %d", cinBuffer);
  end
  
  
  reg [7:0] bufpoep;
  
  always @ (*) begin
    
    cinBuffer = cin;
    if(cinBuffer != 1) begin   
      cinBuffer = 0;
    end 
  
    
    eFlagBuffer = eFlag;
    bufpoep = 8'b00000000;
    
    coSubBuffer = 0;
    coAddBuffer = 0;
    coSubBuffer = coSub;
    coAddBuffer = coAdd;
    
    // Anden van de aan bit van de opflag flag. Als deze 1 is is de bijbehorende buffer 1 dus weten we dat
    // we die operatie uit moeten voeren.
    bufnot = opFlag & 1'b1;
    bufor = (opFlag >> 1) & 1'b1;
    bufand = (opFlag >> 2) & 1'b1;
    bufadd = (opFlag >> 3) & 1'b1;
    bufsub = (opFlag >> 4) & 1'b1;
    bufxor = (opFlag >> 5) & 1'b1;
    

    // Makkelijke operaties uitvoeren
    bufpoepynot = ~a1;
    bufpoepyor = a1 | a2;
    bufpoepyxor = a1 ^ a2;

    bufpoepyand = a1 & a2;
    bufpoepyadd = poepyadd;
    bufpoepysub = poepysub;
	
    /* Bufpoep is de output. We hebben nu een output per operatie, maar we willen naar 1 gecentraliseerde output        toe. We orren dus al deze outputs met de bufpoep output, deze is de uiteindelijke output. Dit is mogelijk o      omdat maar alle tijdelijke operatie outputs behalve degene die we nodig hebben 0 zijn.  
       De bufpoep output wordt op deze manier altijd de output die we willen.
    */
    if(bufnot) begin
      bufpoep = bufpoep | bufpoepynot;
    end
    else if(bufor) begin
      bufpoep = bufpoep | bufpoepyor;
    end
    else if(bufand) begin
      bufpoep = bufpoep | bufpoepyand;
    end
    else if(bufadd) begin
      bufpoep = bufpoep | bufpoepyadd;
      cout = coAdd;
      if(^cout === 1'bX || ^cout === 1'bZ) begin
        cout = 0;
      end      
  //    $display("De cout waarde is: %d", cout);
    end
    else if(bufsub) begin
      bufpoep = bufpoep | bufpoepysub; 
           cout = coSub;
      if(^cout === 1'bX || ^cout === 1'bZ) begin
        cout = 0;
      end    
      
  //    $display("De aftrek cout is: %d", cout);
    end
    else if(bufxor) begin
      bufpoep = bufpoep | bufpoepyxor;
    end
    
    // We hebben een check om te kijken of we het al moeten uitrekenen. Anders voert de ALU de berekening uit         // voor hij input heeft gekregen dus krijg je ongedefinieerde output.
    if(eFlagBuffer) begin
         poep = bufpoep;
  		 out = poep;
        // Tijdelijke output van de output waarde
 //   	$display("De output is: %d", out);
    end

    
  end
 
  // De adder en subtractor instanties
  adder addy(.output_byte(poepyadd), .co(coAdd), .a1(a1), .a2(a2), .cinitial(cinBuffer));
  substractor subby (.output_byte(poepysub), .co(coSub), .a1(a1), .a2(a2), .cinitial(cinBuffer));
  
endmodule 




module adder(
  output_byte, co, a1, a2,  cinitial
);
  
  input [7:0] a1;
  input [7:0] a2;
 
  
  input cinitial;
  
  output [7:0] output_byte;
  
  output co;
  
  reg cinreg, coutbuffer;
  
  initial begin
    cinreg = cinitial;
    if(^cinreg === 1'bX) begin   
      cinreg = 0;
    end
 //   $display("De aankomende cin is: %d", cinreg);
  end
  
  always @ (*) begin
    cinreg = cinitial;
    if(^cinreg === 1'bX) begin   
      cinreg = 0;
    end
//    $display("De aankomende cin2 is: %d", cinreg);
  end
  
  

  
  
  
  wire c1, c2, c3, c4, c5, c6, c7, c8;
  wire out0, out1, out2, out3, out4, out5, out6, out7;
  
  // We hebben 8 1-bit adder instanties.
  bitadder ba0(.out(out0), .co(c1), .a1(a1[0]), .a2(a2[0]), .c1(cinreg));
  bitadder ba1(.out(out1), .co(c2), .a1(a1[1]), .a2(a2[1]), .c1(c1));
  bitadder ba2(.out(out2), .co(c3), .a1(a1[2]), .a2(a2[2]), .c1(c2));
  bitadder ba3(.out(out3), .co(c4), .a1(a1[3]), .a2(a2[3]), .c1(c3));
  bitadder ba4(.out(out4), .co(c5), .a1(a1[4]), .a2(a2[4]), .c1(c4));
  bitadder ba5(.out(out5), .co(c6), .a1(a1[5]), .a2(a2[5]), .c1(c5));
  bitadder ba6(.out(out6), .co(c7), .a1(a1[6]), .a2(a2[6]), .c1(c6));
  bitadder ba7(.out(out7), .co(c8), .a1(a1[7]), .a2(a2[7]), .c1(c7));
  
  assign output_byte[0] = out0;
  assign output_byte[1] = out1;
  assign output_byte[2] = out2;
  assign output_byte[3] = out3;
  assign output_byte[4] = out4;
  assign output_byte[5] = out5;
  assign output_byte[6] = out6;
  assign output_byte[7] = out7;
  assign co = c8;
  
  always @ (*) begin
    coutbuffer = co;
  //  $display("De coutbuffer is: %d", coutbuffer);
    if(^coutbuffer === 1'bX) begin
      coutbuffer = 0;
    end
  //  $display("De coutbuffer is: %d", coutbuffer);
    
  end


endmodule

module substractor(output_byte, co,  a1, a2,cinitial);
    input [7:0] a1;
  input [7:0] a2;
  output [7:0] output_byte;
  reg [7:0] output_byte;
  
  input cinitial;
  wire [7:0] bitbuffer;
  
  output co;
  
  reg coBuffer;
  reg cinreg;
  
  initial begin
    cinreg = cinitial;
    if(^cinreg === 1'bX) begin   
      cinreg = 0;
    end
  end
  always @ (*) begin
    cinreg = cinitial;
    if(^cinreg === 1'bX) begin   
      cinreg = 0;
    end
  end
  
  wire c1, c2, c3, c4, c5, c6, c7, c8;
  wire out0, out1, out2, out3, out4, out5, out6, out7;
  
  
  bitsubber ba0(.out(out0), .co(c1), .a1(a1[0]), .a2(a2[0]), .c1(cinreg));
  bitsubber ba1(.out(out1), .co(c2), .a1(a1[1]), .a2(a2[1]), .c1(c1));
  bitsubber ba2(.out(out2), .co(c3), .a1(a1[2]), .a2(a2[2]), .c1(c2));
  bitsubber ba3(.out(out3), .co(c4), .a1(a1[3]), .a2(a2[3]), .c1(c3));
  bitsubber ba4(.out(out4), .co(c5), .a1(a1[4]), .a2(a2[4]), .c1(c4));
  bitsubber ba5(.out(out5), .co(c6), .a1(a1[5]), .a2(a2[5]), .c1(c5));
  bitsubber ba6(.out(out6), .co(c7), .a1(a1[6]), .a2(a2[6]), .c1(c6));
  bitsubber ba7(.out(out7), .co(c8), .a1(a1[7]), .a2(a2[7]), .c1(c7));
    
  assign bitbuffer[0] = out0;
  assign bitbuffer[1] = out1;
  assign bitbuffer[2] = out2;
  assign bitbuffer[3] = out3;
  assign bitbuffer[4] = out4;
  assign bitbuffer[5] = out5;
  assign bitbuffer[6] = out6;
  assign bitbuffer[7] = out7;
   

  /* De laatste bit (9e bit) van een operatie is de carry-out bit. Deze gebruiken we bij het aftrekken om te     	  kijken of het output getal negatief is. Als de 9e bit 1 is is de output negatief. Zie het verslag voor de        complete uitleg hierbij maar het komt erop neer dat de echte output dan een - teken is gevolgd door de (256      - DeGekregenOutput).
  */
  always @(*) begin
    coBuffer = c8;
    output_byte = bitbuffer;
 
/*    if(coBuffer == 1) begin
     
      output_byte = 256 - bitbuffer;
    end    */
  end
  assign co = coBuffer; 
  
  
  //assign output_byte = (co == 1 ? (256 - output_byte) : output_byte);
  
  
endmodule




// Deze module is een 1-bits adder. 
module bitadder(out, co, a1, a2, c1);
  
  output out, co;
  input a1, a2, c1;
  
  
  wire xor_o1, xor_o2, and_o1, and_o2, or_o1;
  

  
  wire out, co;
  
  wire a1;
  wire a2;
  wire c1;
  
  /* Deze operaties zijn letterlijk overgenomen uit ons verslag. Dit is een 1:1 vertaling van een 1-bit adder
     op logic gate niveau.
  */
  assign xor_o1 = a1 ^ a2;
  assign xor_o2 = xor_o1 ^ c1;
  assign and_o1 = a1 & a2;
  assign and_o2 = c1 & xor_o1;
  assign or_o1 = and_o1 | and_o2;
  
  assign out = xor_o2;
  assign co = or_o1;
  // assign {co, out} = a1 + a2 + c1;
  
  
endmodule

module bitsubber(out, co, a1, a2, c1);
  
  output out, co;
  input a1, a2, c1;
  
  
  
  wire out, co;
  
  wire a1;
  wire a2;
  wire c1;
  
  /* De 1-bit subtractor is niet 1:1 vertaald. Dit is niet per se nodig en er wordt verwacht dat het concept          inmiddels gesnapt wordt. Misschien moeten we later nog een 1:1 vertaling toevoegen. 
  */
  
  wire xor1, xor2, and1, and2, not1, not2, or1;
  
  assign xor1 = a1 ^ a2;
  assign xor2 = xor1 ^ c1;
  assign not1 = ~a1;
  assign not2 = ~xor1;
  assign and1 = not1 & a2;
  assign and2 = not2 & c1;
  assign or1 = and1 | and2;
  
  assign out = xor2;
  assign co = or1;
  
  
  
endmodule
  
