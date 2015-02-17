# EE 454
# Spring 2015
# Lab 2 Part 2
# John Timms
# accumulator_top_tb.do

vlib work
vlog +acc "accumulator_top.v"
vlog +acc "accumulator_top_tb.v"
vsim -novopt -t 1ps -lib work accumulator_top_tb
do {accumulator_top_wave.do}
view wave
log -r *
run -all
