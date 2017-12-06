onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib clk_manager_opt

do {wave.do}

view wave
view structure
view signals

do {clk_manager.udo}

run -all

quit -force
