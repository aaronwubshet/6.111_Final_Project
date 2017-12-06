onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib filter_input_buffer_opt

do {wave.do}

view wave
view structure
view signals

do {filter_input_buffer.udo}

run -all

quit -force
