# EE 454
# Spring 2015
# Lab 2 Part 2
# John Timms
# accumulator_memory_tb.do

vlib work
vlog +acc "accumulator_memory.v"
vsim -novopt -t 1ps -lib work accumulator_memory_tb
view wave
log -r *
run -all
