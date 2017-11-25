onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib xy_bin_opt

do {wave.do}

view wave
view structure
view signals

do {xy_bin.udo}

run -all

quit -force
