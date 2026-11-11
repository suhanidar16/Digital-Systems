module D_latch (Clk, D, Q);

    input Clk, D;
    output Q;

    wire S_g, R_g;
    wire Qb;

    // NAND gates that enable the data input.
    assign S_g = ~(D & Clk);
    assign R_g = ~((~D) & Clk);

    // Cross-coupled NAND gates.
    assign Q  = ~(S_g & Qb);
    assign Qb = ~(R_g & Q);

endmodule
