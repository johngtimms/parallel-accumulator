onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -format Logic -radix binary sim:/accumulator_processor_tb/clk_tb
add wave -noupdate -format Logic -radix binary sim:/accumulator_processor_tb/reset_tb
add wave -noupdate -format Logic -radix decimal sim:/accumulator_processor_tb/clk_count
add wave -noupdate -format Logic -radix binary sim:/accumulator_processor_tb/op_tb
add wave -noupdate -format Logic -radix binary sim:/accumulator_processor_tb/req_tb
add wave -noupdate -format Logic -radix binary sim:/accumulator_processor_tb/grant_tb
add wave -noupdate -format Logic -radix hexadecimal sim:/accumulator_processor_tb/read_tb
add wave -noupdate -format Logic -radix hexadecimal sim:/accumulator_processor_tb/write_tb
add wave -noupdate -format Logic -radix binary sim:/accumulator_processor_tb/signal_tb
add wave -noupdate -format Logic -radix ascii sim:/accumulator_processor_tb/state_string
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {88 ns} 0} {{Cursor 2} {466 ns} 0}
configure wave -namecolwidth 150
configure wave -valuecolwidth 57
configure wave -justifyvalue left
configure wave -signalnamewidth 1
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
