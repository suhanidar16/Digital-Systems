`timescale 1ns / 1ps

module testbench ( );
	parameter CLOCK_PERIOD = 100;

	reg [1:0] SW;
    wire [9:0] LEDR;

	initial begin
		SW[1] <= 1'b0;
	end // initial

	always @ (*)
	begin : Clock_Generator
		#((CLOCK_PERIOD) / 2) SW[1] <= ~SW[1];
	end
	
	initial begin
		SW[0] <= 1'b0;
		#100 SW[0] <= 1'b1;
		#100 SW[0] <= 1'b0;
		#15 SW[0] <= 1'b1;
		#20 SW[0] <= 1'b0;
		#50 SW[0] <= 1'b1;
		#50 SW[0] <= 1'b0;
		#50 SW[0] <= 1'b1;
	end // initial

	part3 U1 (SW[1:0], LEDR);

endmodule
