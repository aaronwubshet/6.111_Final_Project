///////////////////////////////////////////////////////////////////////////////
//
// 320hz low pass
//
///////////////////////////////////////////////////////////////////////////////

module lpf_coeffs(
  input wire [4:0] index,
  output reg signed [9:0] coeff
);
  // tools will turn this into a 31x10 ROM
  always @(index)
    case (index)
      5'd0:  coeff = 10'sd4;
      5'd1:  coeff = 10'sd5;
      5'd2:  coeff = 10'sd7;
      5'd3:  coeff = 10'sd10;
      5'd4:  coeff = 10'sd14;
      5'd5:  coeff = 10'sd19;
      5'd6:  coeff = 10'sd24;
      5'd7:  coeff = 10'sd30;
      5'd8:  coeff = 10'sd37;
      5'd9:  coeff = 10'sd43;
      5'd10: coeff = 10'sd49;
      5'd11: coeff = 10'sd54;
      5'd12: coeff = 10'sd58;
      5'd13: coeff = 10'sd62;
      5'd14: coeff = 10'sd64;
      5'd15: coeff = 10'sd64;
      5'd16: coeff = 10'sd64;
      5'd17: coeff = 10'sd62;
      5'd18: coeff = 10'sd58;
      5'd19: coeff = 10'sd54;
      5'd20: coeff = 10'sd49;
      5'd21: coeff = 10'sd43;
      5'd22: coeff = 10'sd37;
      5'd23: coeff = 10'sd30;
      5'd24: coeff = 10'sd24;
      5'd25: coeff = 10'sd19;
      5'd26: coeff = 10'sd14;
      5'd27: coeff = 10'sd10;
      5'd28: coeff = 10'sd7;
      5'd29: coeff = 10'sd5;
      5'd30: coeff = 10'sd4;
      default: coeff = 10'hXXX;
      
    endcase
endmodule
