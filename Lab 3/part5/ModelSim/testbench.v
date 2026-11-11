`timescale 1ns / 1ps

module testbench ( );

	reg [7:0] SW;
    reg [1:0] KEY;
    wire [0:6] HEX5, HEX4, HEX3, HEX2, HEX1, HEX0;
	wire [9:0] LEDR;

	initial begin
		KEY[1] <= 1'b0;
        #100 KEY[1] = 1'b1;
        #100 KEY[1] = 1'b0;
        #100 KEY[1] = 1'b1;
        #100 KEY[1] = 1'b0;
	end // initial

	initial begin
        KEY[0] <= 1'b0;
        #110 KEY[0] <= 1'b1;
    end // reset

	initial begin
		SW <= 8'H7f;
		#310 SW	<= 8'H01;
		#90 SW	<= 8'Hff;
	end // initial

	part5 U1 (SW, KEY, HEX5, HEX4, HEX3, HEX2, HEX1, HEX0, LEDR);

endmodule
