//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.06.2022 10:59:48
// Design Name: 
// Module Name: Mod
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Mod(
    input [31:0] a_operand,
	input [31:0] b_operand,
	input [3:0] Op,
	output Exception, 
	output Underflow,
	output Overflow,
	output [31:0] result
	);
	
	wire [31:0] A_add_sub, B_add_sub, A_Mul, B_Mul, A_Div, B_Div, A_Sqrt ;
	wire Add_Sub_Exception, Mul_Exception, Mul_Overflow, Mul_Underflow, Div_Exception, Sqrt_Exception;
	wire [31:0] Add_Sub_Output, Mul_Output, Div_Output, Sqrt_Output;
	
	wire addSubWire;
	
	//op = 1 for addition
	assign {A_add_sub,B_add_sub,addSubWire} = (Op == 4'd1) ? {a_operand,b_operand,1'b0} : 64'dz;
    //op = 2 for sub
    assign {A_add_sub,B_add_sub,addSubWire} = (Op == 4'd2) ? {a_operand,b_operand,1'b1} : 64'dz;
    //op = 3 for mul
    assign {A_Mul, B_Mul} = (Op == 4'd3) ? {a_operand,b_operand} : 64'dz;
    //op = 4 for div
    assign {A_Div, B_Div} = (Op == 4'd4) ? {a_operand,b_operand}: 64'dz;
    //op = 5 for sqrt
    assign {A_Sqrt} = (Op == 4'd5) ? {a_operand}: 32'dz;


    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    Addition_Subtraction AuI(A_add_sub,B_add_sub,addSubWire,Add_Sub_Exception,Add_Sub_Output);

    Multiplication MuI(A_Mul, B_Mul,Mul_Exception,Mul_Overflow,Mul_Underflow,Mul_Output);

    Division DuI(A_Div, B_Div,Div_Exception,Div_Output);
    
    SquareRoot SuI(A_Sqrt, Sqrt_Exception, Sqrt_Output);
    
    assign {Exception,Overflow,Underflow,result} = (Op == 4'd1) ? {Add_Sub_Exception,1'b0,1'b0,Add_Sub_Output}	: 35'dz;

    assign {Exception,Overflow,Underflow,result} = (Op == 4'd3) ? {Mul_Exception,Mul_Overflow,Mul_Underflow,Mul_Output}	: 35'dz;

    assign {Exception,Overflow,Underflow,result} = (Op == 4'd4) ? {Div_Exception,1'b0,1'b0,Div_Output}	: 35'dz;

    assign {Exception,Overflow,Underflow,result} = (Op == 4'd2) ? {Add_Sub_Exception,1'b0,1'b0,Add_Sub_Output}	: 35'dz;
	
	assign {Exception,Overflow,Underflow,result} = (Op == 4'd5) ? {Sqrt_Exception,1'b0,1'b0,Sqrt_Output} : 35'dz;
endmodule
