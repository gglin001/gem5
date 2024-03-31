#!/bin/bash

M5_DEBUG_FLAG=1 gem5.opt configs/example/gem5_library/arm-hello.py 2>stubgen/m5.mods.csv
# or
M5_DEBUG_FLAG=1 gem5.opt configs/learning_gem5/part1/simple-riscv.py 2>stubgen/m5.mods.csv
