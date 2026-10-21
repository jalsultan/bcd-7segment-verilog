# BCD to 7-Segment Decoder in Verilog

A combinational BCD to 7-segment decoder, written in Verilog and verified with a self-checking testbench.

This is a rebuild of a gate-level design I made in my Logic Design course at King Khalid University (2024). The original was designed by hand (truth table, K-maps, Boolean minimization) and simulated in LogicWorks 5. This version describes the same logic in Verilog.

## What the testbench found

The testbench applies every valid BCD input (0 to 9) and compares the output with the truth table. On the first run it flagged digits 0, 3 and 8. All three failures were in segment `e`: the original K-map grouping gave `e = B'C + CD'`, but the correct minimized expression is `e = B'D' + CD'`. The error had gone unnoticed in the original project. After the fix, all 10 digits pass.

## Files

| File | What it is |
| --- | --- |
| `seg7_decoder.v` | The decoder: 4-bit BCD in, 7 segment outputs (abcdefg, active high) |
| `seg7_decoder_tb.v` | Self-checking testbench for digits 0 to 9 |
| `waveform.png` | Simulation waveform |

## How to run

With Icarus Verilog:

```
iverilog -o sim seg7_decoder.v seg7_decoder_tb.v
vvp sim
```

Or paste both files into [EDA Playground](https://www.edaplayground.com) with Icarus Verilog selected.

