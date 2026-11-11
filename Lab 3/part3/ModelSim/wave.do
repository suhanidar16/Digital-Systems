onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -label SW -radix binary testbench/SW
add wave -noupdate -label LEDR -radix binary /testbench/LEDR
add wave -noupdate -divider Outputs
add wave -noupdate -label Clock {/testbench/SW[1]}
add wave -noupdate -label D {/testbench/SW[0]}
add wave -noupdate -label Qm /testbench/U1/Qm
add wave -noupdate -label Qs /testbench/U1/Qs
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
WaveRestoreZoom {25 ns} {525 ns}
