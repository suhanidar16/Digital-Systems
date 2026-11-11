
module part3 (KEY, CLOCK_50, HEX0);

    input [0:0] KEY;     // KEY[0] = Reset (pressed = 0).
    input CLOCK_50;      // 50 MHz board clock.
    output [6:0] HEX0;

    // Large counter:
    // One complete cycle = 2^26 clock ticks ≈ 1.34 seconds.
    reg [25:0] Big;

    // Small counter storing the digit 0 to 9.
    reg [3:0] Digit;

    // Enable is HIGH for one clock tick per Big counter cycle.
    wire Enable;


    // ========================================
    // LARGE COUNTER
    // ========================================

    always @(posedge CLOCK_50) begin

        if (KEY[0] == 0)
            Big <= 0;

        else
            Big <= Big + 1;

    end


    // ========================================
    // ENABLE SIGNAL
    // ========================================

    // Enable = 1 when every bit of Big is zero.
    // This is the NOR logic from Figure 2.

    assign Enable = (Big == 0);


    // ========================================
    // DIGIT COUNTER
    // ========================================

    always @(posedge CLOCK_50) begin

        if (KEY[0] == 0)
            Digit <= 0;

        else if (Enable == 1) begin

            if (Digit == 9)
                Digit <= 0;        // Wrap from 9 back to 0.

            else
                Digit <= Digit + 1;

        end

        // If Enable = 0, Digit holds its value.

    end


    // ========================================
    // HEX DISPLAY
    // ========================================

    hex7seg H0 (Digit, HEX0);

endmodule
