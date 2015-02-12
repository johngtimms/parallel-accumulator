# EE 454
# Spring 2015
# Lab 2 Part 2
# John Timms
# accumulator_top_tb.do

vlib work
vlog +acc "accumulator_memory.v"
vlog +acc "accumulator_top.v"
vlog +acc "accumulator_top_tb.v"
vlog +acc "FixedPriorityArbiter.v"
vlog +acc "RoundRobinArbiter.v"
vlog +acc "accumulator_processor.v"
vsim -novopt -t 1ps -lib work accumulator_top_tb
view wave
log -r *
run -all
