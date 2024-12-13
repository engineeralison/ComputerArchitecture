onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /instruction_datapath_tb/dut/clk
add wave -noupdate /instruction_datapath_tb/dut/reset
add wave -noupdate /instruction_datapath_tb/dut/UncondBr
add wave -noupdate /instruction_datapath_tb/dut/BrTaken
add wave -noupdate /instruction_datapath_tb/dut/instruction
add wave -noupdate /instruction_datapath_tb/dut/PC
add wave -noupdate /instruction_datapath_tb/dut/nextPC
add wave -noupdate /instruction_datapath_tb/dut/added1
add wave -noupdate /instruction_datapath_tb/dut/added2
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 125
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 100
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {300000 ps}
