// Testbench for seg7_decoder
// Tries every BCD digit 0-9 and checks the segments against
// the truth table from my Logic Design report

`timescale 1ns/1ps

module seg7_decoder_tb;

    reg  [3:0] bcd;
    wire [6:0] seg;
    reg  [6:0] expected [0:9];   // correct segments for each digit
    integer i;
    integer errors = 0;

    seg7_decoder dut (.bcd(bcd), .seg(seg));

    initial begin
        // truth table, bits in order abcdefg
        expected[0] = 7'b1111110;
        expected[1] = 7'b0110000;
        expected[2] = 7'b1101101;
        expected[3] = 7'b1111001;
        expected[4] = 7'b0110011;
        expected[5] = 7'b1011011;
        expected[6] = 7'b1011111;
        expected[7] = 7'b1110000;
        expected[8] = 7'b1111111;
        expected[9] = 7'b1111011;

        // save waveforms
        $dumpfile("seg7.vcd");
        $dumpvars(0, seg7_decoder_tb);

        // apply each digit, wait 10 ns, compare
        for (i = 0; i < 10; i = i + 1) begin
            bcd = i;
            #10;
            if (seg !== expected[i]) begin
                $display("FAIL digit %0d: got %b, expected %b", i, seg, expected[i]);
                errors = errors + 1;
            end else begin
                $display("ok   digit %0d: %b", i, seg);
            end
        end

        // summary
        if (errors == 0) $display("ALL 10 DIGITS PASS");
        else             $display("%0d DIGIT(S) FAILED", errors);
        $finish;
    end

endmodule
