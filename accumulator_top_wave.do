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

add wave -group "memory" -noupdate -format logic -radix binary sim:/accumulator_top_tb/UUT/memory/load
add wave -group "memory" -noupdate -format literal -radix binary sim:/accumulator_top_tb/UUT/memory/op
add wave -group "memory" -noupdate -format literal -radix hexadecimal sim:/accumulator_top_tb/UUT/memory/write
add wave -group "memory" -noupdate -format literal -radix hexadecimal sim:/accumulator_top_tb/UUT/memory/read
add wave -group "memory" -noupdate -format literal -radix hexadecimal sim:/accumulator_top_tb/UUT/memory/preview
add wave -group "memory" -noupdate -format logic -radix binary sim:/accumulator_top_tb/UUT/memory/signal
add wave -group "memory" -noupdate -format logic -radix binary sim:/accumulator_top_tb/UUT/memory/full
add wave -group "memory" -noupdate -format literal -radix binary sim:/accumulator_top_tb/UUT/memory/state
add wave -group "memory" -noupdate -format literal -radix unsigned sim:/accumulator_top_tb/UUT/memory/index

add wave -group "proc0" -noupdate -format logic -radix binary sim:/accumulator_top_tb/UUT/proc0/signal
add wave -group "proc0" -noupdate -format logic -radix binary sim:/accumulator_top_tb/UUT/proc0/grant
add wave -group "proc0" -noupdate -format literal -radix binary sim:/accumulator_top_tb/UUT/proc0/op
add wave -group "proc0" -noupdate -format literal -radix hexadecimal sim:/accumulator_top_tb/UUT/proc0/read
add wave -group "proc0" -noupdate -format literal -radix hexadecimal sim:/accumulator_top_tb/UUT/proc0/write
add wave -group "proc0" -noupdate -format logic -radix binary sim:/accumulator_top_tb/UUT/proc0/req
add wave -group "proc0" -noupdate -format literal -radix binary sim:/accumulator_top_tb/UUT/proc0/state

add wave -group "proc1" -noupdate -format logic -radix binary sim:/accumulator_top_tb/UUT/proc1/signal
add wave -group "proc1" -noupdate -format logic -radix binary sim:/accumulator_top_tb/UUT/proc1/grant
add wave -group "proc1" -noupdate -format literal -radix binary sim:/accumulator_top_tb/UUT/proc1/op
add wave -group "proc1" -noupdate -format literal -radix hexadecimal sim:/accumulator_top_tb/UUT/proc1/read
add wave -group "proc1" -noupdate -format literal -radix hexadecimal sim:/accumulator_top_tb/UUT/proc1/write
add wave -group "proc1" -noupdate -format logic -radix binary sim:/accumulator_top_tb/UUT/proc1/req
add wave -group "proc1" -noupdate -format literal -radix binary sim:/accumulator_top_tb/UUT/proc1/state

add wave -group "proc2" -noupdate -format logic -radix binary sim:/accumulator_top_tb/UUT/proc2/signal
add wave -group "proc2" -noupdate -format logic -radix binary sim:/accumulator_top_tb/UUT/proc2/grant
add wave -group "proc2" -noupdate -format literal -radix binary sim:/accumulator_top_tb/UUT/proc2/op
add wave -group "proc2" -noupdate -format literal -radix hexadecimal sim:/accumulator_top_tb/UUT/proc2/read
add wave -group "proc2" -noupdate -format literal -radix hexadecimal sim:/accumulator_top_tb/UUT/proc2/write
add wave -group "proc2" -noupdate -format logic -radix binary sim:/accumulator_top_tb/UUT/proc2/req
add wave -group "proc2" -noupdate -format literal -radix binary sim:/accumulator_top_tb/UUT/proc2/state

add wave -group "proc3" -noupdate -format logic -radix binary sim:/accumulator_top_tb/UUT/proc3/signal
add wave -group "proc3" -noupdate -format logic -radix binary sim:/accumulator_top_tb/UUT/proc3/grant
add wave -group "proc3" -noupdate -format literal -radix binary sim:/accumulator_top_tb/UUT/proc3/op
add wave -group "proc3" -noupdate -format literal -radix hexadecimal sim:/accumulator_top_tb/UUT/proc3/read
add wave -group "proc3" -noupdate -format literal -radix hexadecimal sim:/accumulator_top_tb/UUT/proc3/write
add wave -group "proc3" -noupdate -format logic -radix binary sim:/accumulator_top_tb/UUT/proc3/req
add wave -group "proc3" -noupdate -format literal -radix binary sim:/accumulator_top_tb/UUT/proc3/state

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
