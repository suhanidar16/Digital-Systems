module part3 (SW, LEDR);

    input [1:0] SW;
    output [9:0] LEDR;

    wire Qm;
    wire clock_n;

    assign clock_n = ~SW[1];

    // Master opens while the board clock is low.
    D_latch master (clock_n, SW[0], Qm);

    // Slave opens while the board clock is high.
    D_latch slave (SW[1], Qm, LEDR[0]);

    assign LEDR[9:1] = 9'b0;

endmodule
