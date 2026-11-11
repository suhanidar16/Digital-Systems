module part4 (Clk, D, Qa, Qb, Qc);

    input Clk, D;
    output Qa, Qb, Qc;

    D_latch latch1 (Clk, D, Qa);
    positive_D_ff ff1 (Clk, D, Qb);
    negative_D_ff ff2 (Clk, D, Qc);

endmodule


module positive_D_ff (Clk, D, Q);

    input Clk, D;
    output reg Q;

    // Capture D only at a rising clock edge.
    always @(posedge Clk)
        Q <= D;

endmodule


module negative_D_ff (Clk, D, Q);

    input Clk, D;
    output reg Q;

    // Capture D only at a falling clock edge.
    always @(negedge Clk)
        Q <= D;

endmodule

