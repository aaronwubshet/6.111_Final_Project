///////////////////////////////////////////////////////////////////////////////
//
// Coefficients for a 31-tap band-pass FIR filter with Wn=[.03125 .1] (eg, 500Hz to 1600Hz for a
// 48kHz sample rate).  Since we're doing integer arithmetic, we've scaled
// the coefficients by 2**10
// Matlab command: round(fir1(30,[.03125 .1])*1024)
//
///////////////////////////////////////////////////////////////////////////////

module bpf1_coeffs(
  input wire [4:0] index,
  output reg signed [9:0] coeff
);
  // tools will turn this into a 31x10 ROM
  always @(index)
    case (index)
      5'd0:  coeff = -10'sd6;
      5'd1:  coeff = -10'sd8;
      5'd2:  coeff = -10'sd10;
      5'd3:  coeff = -10'sd13;
      5'd4:  coeff = -10'sd15;
      5'd5:  coeff = -10'sd16;
      5'd6:  coeff = -10'sd12;
      5'd7:  coeff = -10'sd4;
      5'd8:  coeff = 10'sd9;
      5'd9:  coeff = 10'sd22;
      5'd10: coeff = 10'sd49;
      5'd11: coeff = 10'sd73;
      5'd12: coeff = 10'sd96;
      5'd13: coeff = 10'sd115;
      5'd14: coeff = 10'sd127;
      5'd15: coeff = 10'sd131;
      5'd16: coeff = 10'sd127;
      5'd17: coeff = 10'sd115;
      5'd18: coeff = 10'sd96;
      5'd19: coeff = 10'sd73;
      5'd20: coeff = 10'sd49;
      5'd21: coeff = 10'sd27;
      5'd22: coeff = 10'sd9;
      5'd23: coeff = -10'sd4;
      5'd24: coeff = -10'sd12;
      5'd25: coeff = -10'sd16;
      5'd26: coeff = -10'sd15;
      5'd27: coeff = -10'sd13;
      5'd28: coeff = -10'sd10;
      5'd29: coeff = -10'sd8;
      5'd30: coeff = -10'sd6;
      default: coeff = 10'hXXX;
    endcase
endmodule
