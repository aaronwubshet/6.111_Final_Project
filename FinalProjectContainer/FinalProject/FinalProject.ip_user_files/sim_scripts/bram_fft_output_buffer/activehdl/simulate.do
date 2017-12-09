onbreak {quit -force}
onerror {quit -force}

asim -t 1ps +access +r +m+bram_fft_output_buffer -L unisims_ver -L unimacro_ver -L secureip -L xil_defaultlib -L xpm -L blk_mem_gen_v8_3_3 -O5 xil_defaultlib.bram_fft_output_buffer xil_defaultlib.glbl

do {wave.do}

view wave
view structure
view signals

do {bram_fft_output_buffer.udo}

run -all

endsim

quit -force
