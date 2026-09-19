#!/bin/bash
set -e
echo "Runnin Simulation"
iverilog -g2012 -o sim/i2s_rx/sim.out \
rtl/i2s_rx.sv \
tb/i2s_rx/i2s_rx_tb.sv 
vvp sim/i2s_rx/sim.out
echo "simulation finished successfully"

