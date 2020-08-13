onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib bram_fft_output_buffer_opt

do {wave.do}

view wave
view structure
view signals

do {bram_fft_output_buffer.udo}

run -all

quit -force
