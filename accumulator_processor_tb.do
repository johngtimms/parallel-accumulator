# EE 454
# Spring 2015
# Lab 2 Part 2
# John Timms
# accumulator_processor_tb.do

vlib work
vlog +acc "accumulator_processor.v"
vlog +acc "accumulator_processor_tb.v"
vsim -novopt -t 1ps -lib work accumulator_processor_tb
do {accumulator_processor_wave.do}
view wave
view structure
view signals
log -r *
run -all
WaveRestoreZoom {80 ns} {573 ns}
