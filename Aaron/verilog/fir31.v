///////////////////////////////////////////////////////////////////////////////
//
// 31-tap FIR filter, 8-bit signed data, 10-bit signed coefficients.
// ready is asserted whenever there is a new sample on the X input,
// the Y output should also be sampled at the same time.  Assumes at
// least 32 clocks between ready assertions.  Note that since the
// coefficients have been scaled by 2**10, so has the output (it's
// expanded from 8 bits to 18 bits).  To get an 8-bit result from the
// filter just divide by 2**10, ie, use Y[17:10].
//
///////////////////////////////////////////////////////////////////////////////

module fir31(
  input wire clock,reset,ready,
  input wire [7:0] x,
  input wire signed [9:0] coeff,
  output wire [4:0] idx,
  output reg signed [17:0] y,
  output done
);


  reg [7:0] sample [31:0];  // 32 element array each 8 bits wide
  reg signed [17:0] accumulator;
  reg [4:0] idx_reg;
  reg flag;
  reg last_flag;
  reg [4:0] offset;
  assign idx = idx_reg;

  initial offset = 0;
  initial flag = 1;
  initial last_flag = 1;
  initial idx_reg = 0;

  initial sample[offset] = x;
  
  assign done = (last_flag == 0 && flag==1) ? 1:0;
  always @(posedge clock)
  begin
  //reset values each time output is updated
        last_flag <= flag;
		if(ready && flag)
		begin
			accumulator <= 0;
			sample[offset] <= x;
			flag <= 0;
			idx_reg <= 0;
			offset <= offset + 1;
		end
		if (idx_reg <32 && !flag)
		begin
			idx_reg <= idx_reg +1;
			if (offset-idx_reg <0)
			begin
			//make sure to cycle around for negative index values
				accumulator <= accumulator + coeff*sample[(offset-idx_reg + 32)];
			end
			else
			begin
				accumulator <= accumulator + coeff*sample[(offset-idx_reg)];
			end
		end
		if (idx_reg == 31)
		begin
		    //  y<=x;
			y <= accumulator;
			flag <=1;
		end
    end
endmodule
