module SquareRoot( input [31:0] a_operand, output [31:0] solution);

//wire [31:0] operand_a;
wire [7:0] exponent_a;
wire [31:0] temp, temp1, temp2;
wire [31:0] Iteration_X1;
wire [31:0] Iteration_X2;
wire [31:0] Iteration_X3;

wire [31:0] a_norm;
wire pos;
wire [7:0] Exp_2;
wire remainder;

localparam Seed = 32'h3F5A_827A, sqrt_1by05 = 32'h3FB5_04F3, sqrt_2 = 32'h3FB_04F3;

assign a_norm = {1'b0,8'd126,a_operand[22:0]};
assign exponent_a = a_operand[30:23];

Iteration_Sqt S1(a_norm,Seed,Iteration_X1);

Iteration_Sqt S2(a_norm, Iteration_X1,Iteration_X2);

Iteration_Sqt S3(a_norm,Iteration_X2,Iteration_X3);

Multiplication M1(Iteration_X3,sqrt_1by05,,,,temp);

assign pos = (exponent_a>=8'd127) ? 1'b1 : 1'b0;
assign Exp_2 = pos ? (exponent_a-8'd127)/2 : (exponent_a-8'd127-1)/2 ;
assign remainder = (exponent_a-8'd127)%2;
assign temp1 = {temp[31],Exp_2 + temp[30:23],temp[22:0]};

Multiplication M2(temp1,sqrt_2,,,,temp2);
assign solution = remainder ? temp2 : temp1;
endmodule


