`timescale 1ns/10ps

module aoutomat_tb;

reg i_en;
wire o_max;
reg i_clk;
reg i_rst;


aoutomat aoutomat_inst
(
	.i_en(i_en) ,	// input  i_en_sig
	.i_rst(i_rst), // input i_rst
	.i_clk(i_clk) ,	// input  i_clk_sig
	.o_max(o_max) 	// output  o_max_sig
);

initial begin 
i_clk = 0;
forever #2 i_clk = ~i_clk;

end

initial begin

i_rst = 0;
#2 i_rst = 1;
#3 i_rst = 0;
end

initial begin

i_en =0;
forever #4 i_en = ~i_en;

end 

initial begin 
#100 $finish;
end

defparam aoutomat_inst.state_A = 'b00;
defparam aoutomat_inst.state_B = 'b01;
defparam aoutomat_inst.state_C = 'b10;
defparam aoutomat_inst.state_D = 'b11;

endmodule
