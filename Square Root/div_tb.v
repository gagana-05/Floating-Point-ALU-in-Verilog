module div_tb;

	reg clk = 0;
	reg [31:0] a;
	reg [31:0] b;
	
	wire [31:0] result;
	wire Exception;

	Division dut(a, b, Exception, result);
	always clk = #5 ~clk;

initial
begin
#10 a = 32'h44b4_2000; b = 32'h4224_0000; // a = 1441 , b = 41;

#10 a = 32'h44f4_90d5; b = 32'h4322_8000; // a = 1956.526 , b = 162.5;

#10 a = 32'h45b2_11f7; b = 32'h41d4_7ae1; // a = 5698.2456 , b = 26.56;

#10 a = 32'h0000_0000; b = 32'h0000_0000; // a = 0 , b = 0;

$stop;
end
endmodule