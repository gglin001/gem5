#!/bin/bash

M5_DEBUG_FLAG=1 gem5.opt configs/example/gem5_library/arm-hello.py 2>stubgen/m5.mods.csv
