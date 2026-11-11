part2.v

module part2 (SW, LEDR);

    input [1:0] SW;
    output [9:0] LEDR;

    // Port order: Clk, D, Q
    D_latch latch1 (SW[1], SW[0], LEDR[0]);

    // Unused LEDs stay off.
    assign LEDR[9:1] = 9'b0;

endmodule
