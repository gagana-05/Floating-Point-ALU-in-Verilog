module Iteration_Sqt( input [31:0] operand_1, input[31:0] operand_2, output [31:0] solution);

localparam  val_05 = 32'h3F00_0000;
wire [31:0] Intermediate_Value1,Intermediate_Value2;

Division D1(operand_1,operand_2,,Intermediate_Value1);

Addition_Subtraction A1(operand_2,Intermediate_Value1,1'b0,,Intermediate_Value2);

assign solution = {Intermediate_Value2[31],Intermediate_Value2[30:23]-1,Intermediate_Value2[22:0]};

endmodule
