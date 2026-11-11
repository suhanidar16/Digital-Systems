`timescale 1ns / 1ps

module testbench ( );

	parameter CLOCK_PERIOD = 20;

	reg Clk, D;
    wire Q;

	initial begin
		Clk <= 1'b0;
	end // initial
	always @ (*)
	begin : Clock_Generator
		#((CLOCK_PERIOD) / 2) Clk <= ~Clk;
	end
	
	initial begin
		D <= 0;
		#20 D <= 1;
		#20 D <= 0;
		#12 D <= 1;
		#5 D <= 0;
		#5 D <= 1;
		#5 D <= 0;
	end // initial

	D_latch U1 (Clk, D, Q);

endmodule
