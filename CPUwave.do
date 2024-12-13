onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /CPU_tb/dut/clk
add wave -noupdate /CPU_tb/dut/reset
add wave -noupdate /CPU_tb/dut/PC
add wave -noupdate /CPU_tb/dut/instruction
add wave -noupdate /CPU_tb/dut/ZF
add wave -noupdate /CPU_tb/dut/NF
add wave -noupdate /CPU_tb/dut/OF
add wave -noupdate /CPU_tb/dut/CoF
add wave -noupdate /CPU_tb/dut/test3/reg32/regdata
add wave -noupdate /CPU_tb/dut/test3/MEMORY/mem
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
