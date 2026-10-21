// BCD to 7-segment decoder
// Input:  4-bit BCD (8-4-2-1), digits 0-9
// Output: segments a-g, 1 = segment on
// Equations from my Logic Design K-maps (2024)

module seg7_decoder (
    input  wire [3:0] bcd,
    output wire [6:0] seg   // seg[6] = a ... seg[0] = g
);

    // same letters as the K-maps: A is the MSB, D is the LSB
    wire A = bcd[3];
    wire B = bcd[2];
    wire C = bcd[1];
    wire D = bcd[0];

    assign seg[6] = A | (~B & ~D) | (B & D) | C;                        // a: top
    assign seg[5] = ~B | A | (C & D) | (~C & ~D);                       // b: top right
    assign seg[4] = B | D | (~C & ~D);                                  // c: bottom right
    assign seg[3] = A | (~B & ~D) | (C & ~D) | (~B & C) | (B & ~C & D); // d: bottom
    assign seg[2] = (~B & ~D) | (C & ~D);                               // e: bottom left (fixed, report had B'C)
    assign seg[1] = A | (B & ~D) | (~C & ~D) | (B & ~C);                // f: top left
    assign seg[0] = A | (B & ~D) | (~B & C) | (B & ~C);                 // g: middle

endmodule
