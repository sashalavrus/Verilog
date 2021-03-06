  
`timescale 1ns/10ps

`define SLL 3'b?00
`define SRL 3'b?01
`define ROL 3'b010
`define ROR 3'b011
`define SRA 3'b11?

module barrel_shifter(bs_opsel, shift_amount, data_in, result);

parameter WIDTH = 16;

input  [2:0]  bs_opsel;
input  [3:0]  shift_amount;
input  [WIDTH-1:0] data_in;
output reg[WIDTH-1:0] result;

wire [WIDTH*2:0] data_mod, data_mod2;
wire arithm, is_arithm_shift;	

assign data_mod = {data_in, data_in} << shift_amount;

assign is_arithm_shift = bs_opsel[2];					 
assign arithm = data_in[WIDTH-1] & is_arithm_shift;				
assign data_mod2 = $signed({arithm, data_in, data_in}) >>> shift_amount;	


always @* begin

	casez(bs_opsel)
		`SRL:  result = data_mod2[WIDTH*2-1:WIDTH-1];
		`SLL:	 result = data_mod[WIDTH-1:0];
		`ROL:  result = data_mod[WIDTH*2-1:WIDTH-1];
		`ROR:  result = data_mod2[WIDTH-1:0];
		`SRA:  result = data_mod2[WIDTH*2-1:WIDTH-1];
	endcase
end

endmodule
