
module part2 (SW, KEY, HEX3, HEX2, HEX1, HEX0);

    input [1:0] SW;   // SW[1] = Enable, SW[0] = Clear.
    input [0:0] KEY;  // KEY[0] = Clock.
    output [6:0] HEX3, HEX2, HEX1, HEX0;

    // 16-bit counter.
    // reg because Q is assigned in an always block.
    reg [15:0] Q;

    always @(posedge KEY[0]) begin

        if (SW[0] == 0)
            Q <= 0;       // Synchronous active-low reset.

        else if (SW[1] == 1)
            Q <= Q + 1;   // Increment by 1.

        // If Enable = 0, Q holds its current value.

    end

    // 16 bits = 4 hexadecimal digits.
    // Each display shows 4 bits.

    hex7seg H0 (Q[3:0],   HEX0);
    hex7seg H1 (Q[7:4],   HEX1);
    hex7seg H2 (Q[11:8],  HEX2);
    hex7seg H3 (Q[15:12], HEX3);

endmodule


// ========================================
// HEX DISPLAY DECODER
// ========================================

module hex7seg (C, Display);

    input [3:0] C;
    output [6:0] Display; // Active-low display.

    // Each detector is 1 only for its corresponding digit.

    wire is0, is1, is2, is3, is4, is5, is6, is7;
    wire is9, isA, isB, isC, isD, isE, isF;

    assign is0 = ~C[3] & ~C[2] & ~C[1] & ~C[0];
    assign is1 = ~C[3] & ~C[2] & ~C[1] &  C[0];
    assign is2 = ~C[3] & ~C[2] &  C[1] & ~C[0];
    assign is3 = ~C[3] & ~C[2] &  C[1] &  C[0];
    assign is4 = ~C[3] &  C[2] & ~C[1] & ~C[0];
    assign is5 = ~C[3] &  C[2] & ~C[1] &  C[0];
    assign is6 = ~C[3] &  C[2] &  C[1] & ~C[0];
    assign is7 = ~C[3] &  C[2] &  C[1] &  C[0];
    assign is9 =  C[3] & ~C[2] & ~C[1] &  C[0];
    assign isA =  C[3] & ~C[2] &  C[1] & ~C[0];
    assign isB =  C[3] & ~C[2] &  C[1] &  C[0];
    assign isC =  C[3] &  C[2] & ~C[1] & ~C[0];
    assign isD =  C[3] &  C[2] & ~C[1] &  C[0];
    assign isE =  C[3] &  C[2] &  C[1] & ~C[0];
    assign isF =  C[3] &  C[2] &  C[1] &  C[0];

    // h = 1 means segment ON.

    wire [6:0] h;

    assign h[0] = ~(is1 | is4 | isB | isD);
    assign h[1] = ~(is5 | is6 | isB | isC | isE | isF);
    assign h[2] = ~(is2 | isC | isE | isF);
    assign h[3] = ~(is1 | is4 | is7 | isA | isF);
    assign h[4] = ~(is1 | is3 | is4 | is5 | is7 | is9);
    assign h[5] = ~(is1 | is2 | is3 | is7 | isD);
    assign h[6] = ~(is0 | is1 | is7 | isC);

    assign Display = ~h; // Convert to active-low.

endmodule
