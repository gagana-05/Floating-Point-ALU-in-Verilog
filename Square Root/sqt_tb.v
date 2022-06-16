module sqt_tb;

reg [31:0] a_operand;
wire [31:0] result;

reg clk = 1'b1;

SquareRoot dut(a_operand, result);

always clk = #5 ~clk;

initial
begin
iteration (32'h4b90_b28e,32'h4588_17c9,`__LINE__); // root 18965789 = 4354.97 

iteration (32'h44a6_6000,32'h4211_ee75,`__LINE__); // root 1331 = 36.482

iteration (32'h4580_0000,32'h427f_ffff,`__LINE__); // root 4096 = 64

iteration (32'h0000_0000,32'h0000_0000,`__LINE__); // root 0 = 0
$stop;

end

task iteration(
input [31:0] operand_a,
input [31:0] Expected_result,
input integer linenum 
);
begin
@(negedge clk)
begin
	a_operand = operand_a;
end

@(posedge clk)
begin
if ((Expected_result == result)) $display ("Test Passed - %d",linenum);
else $display ("Test failed - Expected_result = %h, Result = %h",Expected_result, result, linenum);
end
end
endtask
endmodule
