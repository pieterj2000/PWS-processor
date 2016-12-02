
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

