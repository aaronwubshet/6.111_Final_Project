///////////////////////////////////////////////////////////////////////////////
//
// Coefficients for a 31-tap band-pass FIR filter with Wn=[0.05 .2] (eg, for a
// 32kHz sample rate).  Since we're doing integer arithmetic, we've scaled
// the coefficients by 2**10
// Matlab command: round(fir1(30,.125)*1024)
// going from about 1200 to 1700 hz
///////////////////////////////////////////////////////////////////////////////

module bpf2_coeffs(
  input wire [4:0] index,
  output reg signed [9:0] coeff
);
  // tools will turn this into a 31x10 ROM
  always @(index)
    case (index)
      5'd0:  coeff = -10'sd3;
      5'd1:  coeff = -10'sd6;
      5'd2:  coeff = -10'sd11;
      5'd3:  coeff = -10'sd18;
      5'd4:  coeff = -10'sd28;
      5'd5:  coeff = -10'sd37;
      5'd6:  coeff = -10'sd44;
      5'd7:  coeff = -10'sd44;
      5'd8:  coeff = -10'sd35;
      5'd9:  coeff = -10'sd17;
      5'd10: coeff = 10'sd9;
      5'd11: coeff = 10'sd41;
      5'd12: coeff = 10'sd74;
      5'd13: coeff = 10'sd102;
      5'd14: coeff = 10'sd122;
      5'd15: coeff = 10'sd128;
      5'd16: coeff = 10'sd122;
      5'd17: coeff = 10'sd102;
      5'd18: coeff = 10'sd74;
      5'd19: coeff = 10'sd41;
      5'd20: coeff = 10'sd9;
      5'd21: coeff = -10'sd17;
      5'd22: coeff = -10'sd35;
      5'd23: coeff = -10'sd44;
      5'd24: coeff = -10'sd44;
      5'd25: coeff = -10'sd37;
      5'd26: coeff = -10'sd28;
      5'd27: coeff = -10'sd18;
      5'd28: coeff = -10'sd11;
      5'd29: coeff = -10'sd6;
      5'd30: coeff = -10'sd3;
      default: coeff = 10'hXXX;
    endcase
endmodule
