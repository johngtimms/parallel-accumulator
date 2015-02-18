onerror {resume}
quietly WaveActivateNextPane {} 0

add wave -group "testbench" -noupdate -format logic -radix binary sim:/accumulator_top_tb/clk_tb
add wave -group "testbench" -noupdate -format logic -radix binary sim:/accumulator_top_tb/reset_tb
add wave -group "testbench" -noupdate -format literal -radix unsigned sim:/accumulator_top_tb/clk_count
add wave -group "testbench" -noupdate -format literal -radix hexadecimal sim:/accumulator_top_tb/load
add wave -group "testbench" -noupdate -format literal -radix hexadecimal sim:/accumulator_top_tb/result

add wave -group "arbiter" -noupdate -format literal -radix binary sim:/accumulator_top_tb/UUT/arbiter/req
add wave -group "arbiter" -noupdate -format literal -radix binary sim:/accumulator_top_tb/UUT/arbiter/grant
add wave -group "arbiter" -noupdate -format literal -radix binary sim:/accumulator_top_tb/UUT/arbiter/mask

add wave -group "bus" -noupdate -format literal -radix binary sim:/accumulator_top_tb/UUT/op
add wave -group "bus" -noupdate -format logic -radix binary sim:/accumulator_top_tb/UUT/signal
add wave -group "bus" -noupdate -format literal -radix hexadecimal sim:/accumulator_top_tb/UUT/read
add wave -group "bus" -noupdate -format literal -radix hexadecimal sim:/accumulator_top_tb/UUT/write

add wave -group "memory" -noupdate -format logic -radix binary sim:/accumulator_top_tb/UUT/memory/load
add wave -group "memory" -noupdate -format literal -radix hexadecimal sim:/accumulator_top_tb/UUT/memory/preview
add wave -group "memory" -noupdate -format logic -radix binary sim:/accumulator_top_tb/UUT/memory/full
add wave -group "memory" -noupdate -format literal -radix unsigned sim:/accumulator_top_tb/UUT/memory/index
add wave -group "memory" -noupdate -format literal -radix ascii sim:/accumulator_top_tb/UUT/memory/state_string

add wave -group "proc0" -noupdate -format logic -radix binary sim:/accumulator_top_tb/UUT/proc0/req
add wave -group "proc0" -noupdate -format logic -radix binary sim:/accumulator_top_tb/UUT/proc0/grant
add wave -group "proc0" -noupdate -format literal -radix hexadecimal sim:/accumulator_top_tb/UUT/proc0/A
add wave -group "proc0" -noupdate -format literal -radix hexadecimal sim:/accumulator_top_tb/UUT/proc0/B
add wave -group "proc0" -noupdate -format literal -radix hexadecimal sim:/accumulator_top_tb/UUT/proc0/result
add wave -group "proc0" -noupdate -format literal -radix ascii sim:/accumulator_top_tb/UUT/proc0/state_string

add wave -group "proc1" -noupdate -format logic -radix binary sim:/accumulator_top_tb/UUT/proc1/req
add wave -group "proc1" -noupdate -format logic -radix binary sim:/accumulator_top_tb/UUT/proc1/grant
add wave -group "proc1" -noupdate -format literal -radix hexadecimal sim:/accumulator_top_tb/UUT/proc1/A
add wave -group "proc1" -noupdate -format literal -radix hexadecimal sim:/accumulator_top_tb/UUT/proc1/B
add wave -group "proc1" -noupdate -format literal -radix hexadecimal sim:/accumulator_top_tb/UUT/proc1/result
add wave -group "proc1" -noupdate -format literal -radix ascii sim:/accumulator_top_tb/UUT/proc1/state_string

add wave -group "proc2" -noupdate -format logic -radix binary sim:/accumulator_top_tb/UUT/proc2/req
add wave -group "proc2" -noupdate -format logic -radix binary sim:/accumulator_top_tb/UUT/proc2/grant
add wave -group "proc2" -noupdate -format literal -radix hexadecimal sim:/accumulator_top_tb/UUT/proc2/A
add wave -group "proc2" -noupdate -format literal -radix hexadecimal sim:/accumulator_top_tb/UUT/proc2/B
add wave -group "proc2" -noupdate -format literal -radix hexadecimal sim:/accumulator_top_tb/UUT/proc2/result
add wave -group "proc2" -noupdate -format literal -radix ascii sim:/accumulator_top_tb/UUT/proc2/state_string

add wave -group "proc3" -noupdate -format logic -radix binary sim:/accumulator_top_tb/UUT/proc3/req
add wave -group "proc3" -noupdate -format logic -radix binary sim:/accumulator_top_tb/UUT/proc3/grant
add wave -group "proc3" -noupdate -format literal -radix hexadecimal sim:/accumulator_top_tb/UUT/proc3/A
add wave -group "proc3" -noupdate -format literal -radix hexadecimal sim:/accumulator_top_tb/UUT/proc3/B
add wave -group "proc3" -noupdate -format literal -radix hexadecimal sim:/accumulator_top_tb/UUT/proc3/result
add wave -group "proc3" -noupdate -format literal -radix ascii sim:/accumulator_top_tb/UUT/proc3/state_string

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
