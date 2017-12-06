// Switch Debounce Module
// use your system clock for the clock input
// to produce a synchronous, debounced output
module debounce #(parameter DELAY=1000000)   // .01 sec with a 100Mhz clock
	        (input reset, clock, noisy,
	         output reg clean);

   reg [19:0] count;
   reg new_;

   always @(posedge clock)
     if (reset)
       begin
	  count <= 0;
	  new_ <= noisy;
	  clean <= noisy;
       end
     else if (noisy != new_)
       begin
	  new_ <= noisy;
	  count <= 0;
       end
     else if (count == DELAY)
       clean <= new_;
     else
       count <= count+1;
      
endmodule
