onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib JW_BRAM_COLOR_opt

do {wave.do}

view wave
view structure
view signals

do {JW_BRAM_COLOR.udo}

run -all

quit -force
