# EE 454
# Spring 2015
# Lab 2 Part 2
# John Timms
# accumulator_memory_tb.do

vlib work
vlog +acc "accumulator_memory.v"
vlog +acc "accumulator_memory_tb.v"
vsim -novopt -t 1ps -lib work accumulator_memory_tb
do {accumulator_memory_wave.do}
view wave
view structure
view signals
log -r *
run -all
WaveRestoreZoom {80 ns} {573 ns}
