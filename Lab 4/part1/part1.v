
module part1 (SW, KEY, HEX1, HEX0);

    input [1:0] SW;
    input [0:0] KEY;
    output [6:0] HEX1, HEX0;

    // T depends on SW. SW is like a toggle that turns T on/off.
    // Q0 only depends on T (SW1 Enable).
    // Q1 depends on T and Q0, etc.

    wire [7:0] Q; // Each Q is a bit in the counter.

    // Each bit flips when Enable is on AND all lower bits are 1.
    //           T input                                        Clock   Resetn  Q
    tff F0 (SW[1],                                          KEY[0], SW[0], Q[0]);
    tff F1 (SW[1] & Q[0],                                   KEY[0], SW[0], Q[1]);
    tff F2 (SW[1] & Q[0] & Q[1],                            KEY[0], SW[0], Q[2]);
    tff F3 (SW[1] & Q[0] & Q[1] & Q[2],                     KEY[0], SW[0], Q[3]);
    tff F4 (SW[1] & Q[0] & Q[1] & Q[2] & Q[3],              KEY[0], SW[0], Q[4]);
    tff F5 (SW[1] & Q[0] & Q[1] & Q[2] & Q[3] & Q[4],       KEY[0], SW[0], Q[5]);
    tff F6 (SW[1] & Q[0] & Q[1] & Q[2] & Q[3] & Q[4] & Q[5], KEY[0], SW[0], Q[6]);
    tff F7 (SW[1] & Q[0] & Q[1] & Q[2] & Q[3] & Q[4] & Q[5] & Q[6],
                                                            KEY[0], SW[0], Q[7]);

    // Show the count:
    // Lower 4 bits on HEX0, upper 4 bits on HEX1.
    hex7seg H0 (Q[3:0], HEX0);
    hex7seg H1 (Q[7:4], HEX1);

endmodule


// ========================================
// T FLIP-FLOP
// ========================================

// Used for each bit to determine when it flips.
// T is determined by the conditions from the counter.

module tff (T, Clock, Resetn, Q);

    input T, Clock, Resetn;
    output reg Q;

    always @(posedge Clock) begin

        if (Resetn == 0)
            Q <= 0;

        else begin
            if (T == 1)
                Q <= ~Q;  // Flip Q when T = 1.
        end

    end

endmodule


// ========================================
// HEX DISPLAY DECODER
// ========================================

module hex7seg (C, Display);

    input [3:0] C;
    output [6:0] Display; // Active-low display.

    // Each detector is 1 only for its corresponding digit.
    // No is8 is needed because 8 turns all segments on.

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

    // Segments: h = 1 means ON.
    // A segment is ON unless the current digit
    // is one of the digits that turns it OFF.

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
