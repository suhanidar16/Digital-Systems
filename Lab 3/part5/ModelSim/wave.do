onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -label KEY -radix binary -expand /testbench/KEY
add wave -noupdate -label SW -radix hexadecimal /testbench/SW
add wave -noupdate -label LEDR -radix hexadecimal /testbench/LEDR
add wave -noupdate -divider part2
add wave -noupdate -label A -radix hexadecimal /testbench/U1/A
add wave -noupdate -label B -radix hexadecimal /testbench/U1/B
add wave -noupdate -label S -radix hexadecimal /testbench/U1/S
add wave -noupdate -label HEX2 -radix hexadecimal /testbench/U1/HEX2
add wave -noupdate -label HEX3 -radix hexadecimal /testbench/U1/HEX3
add wave -noupdate -label HEX0 -radix hexadecimal /testbench/U1/HEX0
add wave -noupdate -label HEX1 -radix hexadecimal /testbench/U1/HEX1
add wave -noupdate -label HEX4 -radix hexadecimal /testbench/U1/HEX4
add wave -noupdate -label HEX5 -radix hexadecimal /testbench/U1/HEX5
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {10000 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 80
configure wave -valuecolwidth 40
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {500 ns}
