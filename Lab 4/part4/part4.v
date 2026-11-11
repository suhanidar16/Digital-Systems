
module part4 (KEY, CLOCK_50, HEX5, HEX4, HEX3, HEX2, HEX1, HEX0);

    input [0:0] KEY;  // KEY[0] = Reset (pressed = 0).
    input CLOCK_50;
    output [6:0] HEX5, HEX4, HEX3, HEX2, HEX1, HEX0;

    // ========================================
    // LARGE COUNTER
    // ========================================

    // Same timing method as Part III.
    reg [25:0] Big;
    wire Enable;

    always @(posedge CLOCK_50) begin

        if (KEY[0] == 0)
            Big <= 0;

        else
            Big <= Big + 1;

    end

    // Enable is HIGH when Big is zero.
    assign Enable = (Big == 0);


    // ========================================
    // CHARACTER REGISTERS
    // ========================================

    // Each register stores one character:
    // 00 = d
    // 01 = E
    // 10 = 1
    // 11 = blank

    reg [1:0] C5, C4, C3, C2, C1, C0;


    // ========================================
    // ROTATING DISPLAY
    // ========================================

    always @(posedge CLOCK_50) begin

        // Reset to the starting pattern:
        // HEX5 HEX4 HEX3 HEX2 HEX1 HEX0
        //   -    -    -    d    E    1

        if (KEY[0] == 0) begin

            C5 <= 2'b11;  // Blank
            C4 <= 2'b11;  // Blank
            C3 <= 2'b11;  // Blank
            C2 <= 2'b00;  // d
            C1 <= 2'b01;  // E
            C0 <= 2'b10;  // 1

        end

        // When Enable = 1, shift all characters left.
        else if (Enable == 1) begin

            C5 <= C4;
            C4 <= C3;
            C3 <= C2;
            C2 <= C1;
            C1 <= C0;

            C0 <= C5;  // Wrap around to the right.

        end

        // If Enable = 0, displays hold their values.

    end


    // ========================================
    // CHARACTER DECODERS
    // ========================================

    char_7seg D5 (C5, HEX5);
    char_7seg D4 (C4, HEX4);
    char_7seg D3 (C3, HEX3);
    char_7seg D2 (C2, HEX2);
    char_7seg D1 (C1, HEX1);
    char_7seg D0 (C0, HEX0);

endmodule


// ========================================
// CHARACTER 7-SEGMENT DECODER
// ========================================

// Character codes:
// 00 = d
// 01 = E
// 10 = 1
// 11 = blank

module char_7seg (C, Display);

    input [1:0] C;
    output [6:0] Display;

    wire c1, c0;
    wire [6:0] h;  // 1 = segment ON.

    assign c1 = C[1];
    assign c0 = C[0];

    // Determine which segments turn on.

    assign h[6] = ~c1;
    assign h[5] = ~c1 & c0;
    assign h[4] = ~c1;
    assign h[3] = ~c1;
    assign h[2] = ~c0;
    assign h[1] = ~c0;
    assign h[0] = ~c1 & c0;

    // Convert to active-low display.
    assign Display = ~h;

endmodule
