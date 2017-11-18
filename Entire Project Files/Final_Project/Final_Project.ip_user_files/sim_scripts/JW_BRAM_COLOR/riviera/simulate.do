onbreak {quit -force}
onerror {quit -force}

asim -t 1ps +access +r +m+JW_BRAM_COLOR -L unisims_ver -L unimacro_ver -L secureip -L xil_defaultlib -L xpm -L blk_mem_gen_v8_3_3 -O5 xil_defaultlib.JW_BRAM_COLOR xil_defaultlib.glbl

do {wave.do}

view wave
view structure
view signals

do {JW_BRAM_COLOR.udo}

run -all

endsim

quit -force
