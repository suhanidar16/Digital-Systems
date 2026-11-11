module part1 (Clk, R, S, Qa, Qb);

    input Clk, R, S;
    output Qa, Qb;

    wire R_g, S_g;

    // Allow R and S through only when Clk is high.
    assign R_g = R & Clk;
    assign S_g = S & Clk;

    // Cross-coupled NOR gates store the bit.
    assign Qa = ~(R_g | Qb);
    assign Qb = ~(S_g | Qa);

endmodule