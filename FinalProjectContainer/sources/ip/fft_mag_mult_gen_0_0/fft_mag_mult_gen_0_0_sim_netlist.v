// Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2016.2 (win64) Build 1577090 Thu Jun  2 16:32:40 MDT 2016
// Date        : Thu Dec 07 01:46:08 2017
// Host        : THINKPAD running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim {C:/Users/Aaron
//               Wubshet/Desktop/FinalProjectContainer/sources/ip/fft_mag_mult_gen_0_0/fft_mag_mult_gen_0_0_sim_netlist.v}
// Design      : fft_mag_mult_gen_0_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7a100tcsg324-3
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "fft_mag_mult_gen_0_0,mult_gen_v12_0_11,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "mult_gen_v12_0_11,Vivado 2016.2" *) 
(* NotValidForBitStream *)
module fft_mag_mult_gen_0_0
   (CLK,
    A,
    B,
    P);
  (* x_interface_info = "xilinx.com:signal:clock:1.0 clk_intf CLK" *) input CLK;
  (* x_interface_info = "xilinx.com:signal:data:1.0 a_intf DATA" *) input [7:0]A;
  (* x_interface_info = "xilinx.com:signal:data:1.0 b_intf DATA" *) input [7:0]B;
  (* x_interface_info = "xilinx.com:signal:data:1.0 p_intf DATA" *) output [15:0]P;

  wire [7:0]A;
  wire [7:0]B;
  wire CLK;
  wire [15:0]P;
  wire [47:0]NLW_U0_PCASC_UNCONNECTED;
  wire [1:0]NLW_U0_ZERO_DETECT_UNCONNECTED;

  (* C_A_TYPE = "0" *) 
  (* C_A_WIDTH = "8" *) 
  (* C_B_TYPE = "0" *) 
  (* C_B_VALUE = "10000001" *) 
  (* C_B_WIDTH = "8" *) 
  (* C_CCM_IMP = "0" *) 
  (* C_CE_OVERRIDES_SCLR = "0" *) 
  (* C_HAS_CE = "0" *) 
  (* C_HAS_SCLR = "0" *) 
  (* C_HAS_ZERO_DETECT = "0" *) 
  (* C_LATENCY = "1" *) 
  (* C_MODEL_TYPE = "0" *) 
  (* C_MULT_TYPE = "1" *) 
  (* C_OPTIMIZE_GOAL = "1" *) 
  (* C_OUT_HIGH = "15" *) 
  (* C_OUT_LOW = "0" *) 
  (* C_ROUND_OUTPUT = "0" *) 
  (* C_ROUND_PT = "0" *) 
  (* C_VERBOSITY = "0" *) 
  (* C_XDEVICEFAMILY = "artix7" *) 
  (* KEEP_HIERARCHY = "true" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  fft_mag_mult_gen_0_0_mult_gen_v12_0_11 U0
       (.A(A),
        .B(B),
        .CE(1'b1),
        .CLK(CLK),
        .P(P),
        .PCASC(NLW_U0_PCASC_UNCONNECTED[47:0]),
        .SCLR(1'b0),
        .ZERO_DETECT(NLW_U0_ZERO_DETECT_UNCONNECTED[1:0]));
endmodule

(* C_A_TYPE = "0" *) (* C_A_WIDTH = "8" *) (* C_B_TYPE = "0" *) 
(* C_B_VALUE = "10000001" *) (* C_B_WIDTH = "8" *) (* C_CCM_IMP = "0" *) 
(* C_CE_OVERRIDES_SCLR = "0" *) (* C_HAS_CE = "0" *) (* C_HAS_SCLR = "0" *) 
(* C_HAS_ZERO_DETECT = "0" *) (* C_LATENCY = "1" *) (* C_MODEL_TYPE = "0" *) 
(* C_MULT_TYPE = "1" *) (* C_OPTIMIZE_GOAL = "1" *) (* C_OUT_HIGH = "15" *) 
(* C_OUT_LOW = "0" *) (* C_ROUND_OUTPUT = "0" *) (* C_ROUND_PT = "0" *) 
(* C_VERBOSITY = "0" *) (* C_XDEVICEFAMILY = "artix7" *) (* ORIG_REF_NAME = "mult_gen_v12_0_11" *) 
(* downgradeipidentifiedwarnings = "yes" *) 
module fft_mag_mult_gen_0_0_mult_gen_v12_0_11
   (CLK,
    A,
    B,
    CE,
    SCLR,
    ZERO_DETECT,
    P,
    PCASC);
  input CLK;
  input [7:0]A;
  input [7:0]B;
  input CE;
  input SCLR;
  output [1:0]ZERO_DETECT;
  output [15:0]P;
  output [47:0]PCASC;

  wire [7:0]A;
  wire [7:0]B;
  wire CE;
  wire CLK;
  wire [15:0]P;
  wire [47:0]PCASC;
  wire SCLR;
  wire [1:0]ZERO_DETECT;

  (* C_A_TYPE = "0" *) 
  (* C_A_WIDTH = "8" *) 
  (* C_B_TYPE = "0" *) 
  (* C_B_VALUE = "10000001" *) 
  (* C_B_WIDTH = "8" *) 
  (* C_CCM_IMP = "0" *) 
  (* C_CE_OVERRIDES_SCLR = "0" *) 
  (* C_HAS_CE = "0" *) 
  (* C_HAS_SCLR = "0" *) 
  (* C_HAS_ZERO_DETECT = "0" *) 
  (* C_LATENCY = "1" *) 
  (* C_MODEL_TYPE = "0" *) 
  (* C_MULT_TYPE = "1" *) 
  (* C_OPTIMIZE_GOAL = "1" *) 
  (* C_OUT_HIGH = "15" *) 
  (* C_OUT_LOW = "0" *) 
  (* C_ROUND_OUTPUT = "0" *) 
  (* C_ROUND_PT = "0" *) 
  (* C_VERBOSITY = "0" *) 
  (* C_XDEVICEFAMILY = "artix7" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  fft_mag_mult_gen_0_0_mult_gen_v12_0_11_viv i_mult
       (.A(A),
        .B(B),
        .CE(CE),
        .CLK(CLK),
        .P(P),
        .PCASC(PCASC),
        .SCLR(SCLR),
        .ZERO_DETECT(ZERO_DETECT));
endmodule
`pragma protect begin_protected
`pragma protect version = 1
`pragma protect encrypt_agent = "XILINX"
`pragma protect encrypt_agent_info = "Xilinx Encryption Tool 2014"
`pragma protect key_keyowner="Cadence Design Systems.", key_keyname="cds_rsa_key", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=64)
`pragma protect key_block
gD7l84kB+WAh1ATog3H36h0/cMgn9QL5jGe9p9PjvP7N+FJAVvGVlrxcgBw6dZaWDNZqNANQuRFv
ZSE8fsSCFg==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VERIF-SIM-RSA-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
YQUcxim/tlzHeVlJ7otHN7u41KO3Yg5DFb1yF4GCsbXGLtUvWNlkFjY+UPIlgYImR4Zo4dTHJQ+j
3BaUNSUOqAVzT9CfyUelv2YD2ZTfAtzIe1Mboyb3+StKnuzxnZmIhVPiZlowdW5lQ1r7BjDPOsge
ztxOfUTbvYcTUE1ABIE=

`pragma protect key_keyowner="Synopsys", key_keyname="SNPS-VCS-RSA-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
eu4MFD/NMz3pssr62VCh1XDd9mthYydX9VaOq3lWUwHi5/7e5dl2SAWHtYwTnBgGPY+jCcMycJhy
WSlkhQxVj5BsMm2aAItwXFvH2mSbjlPggtI0/+DNGQ4x8LQSFLTDYnnQbBrHlJymsS+/asMkXACD
SJ2tF8LF5tMhAlMPZZ0=

`pragma protect key_keyowner="Aldec", key_keyname="ALDEC15_001", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
rNAzbNlIFUMjdhvgzZ2FokzvR4AuFtV+1AHGDKa9QgeBsZ1e0Fom48uKbJ9iakvqUoUcKKAvRzeY
OBkbx9P7Imx0gvIgzFsgiVw23cBYWOhbhSqVb7mef9aKx8yeF8T48n7gKldUkwBHIPeqaayRI9/Q
HCZO+k2+HCjRZE6L/Gzd+IOdEVUFOg3NtWFPk2JFkfZkxs8X7Vg/xxtvH7uvp+/EbVyiMbnwDT/p
NSqOyA+rJwBJYD3xRIPTFDI83XJLCF+1i4E8hyu7Y0F9MtjKugqEHwAG+JK3jde00nzNNaeLVUQ1
OfFMZJpkk0Cg66d2cvJY/G11oPkmvTq/JZ4+5g==

`pragma protect key_keyowner="ATRENTA", key_keyname="ATR-SG-2015-RSA-3", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
apuTRT8aJu0TR7Ciy6ONiGK4AT7TUEiokS4gFf1g+kDg6PdKk9VRun4HKszIadRtahjPQo0of9uS
yvu3GS4EQo+Y+T116wnAIXnZSa8EQaEsDkziOI+rCvXv8IgaPYN8Cq0aRlASFL7IHOWNI49V0c0A
FIG/+5U7ZyNQFCVwuE4gCgK/pA6apm5kY4FGJft/EdZ5YAbR/nCTzK4P53+XsKHrtGfw+/MthFWz
tI0OtloKqc7laKZWKOVFqWq8Qmq7UL6utFODtxEQqzczH+q+Gw4rkUyOosIY+cbB67hX+GlmXXEF
jMwvUcen9t6c+wiH6rmBDcUIiuUHHz6q+jCwJQ==

`pragma protect key_keyowner="Xilinx", key_keyname="xilinx_2016_05", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
dfDj35aI8y6zqcW/IHFxmCDw2mpyex25qQAUnsL+tIRxivv/85PqpCOrf3b7NWnwUKMrsxtw+JBY
mtlPsVxQKR1gn6VkaHwbEgwxXXxFe71Z+1nWQhfF8Nt55jGvq1joWKMrurSV7Mo+HkvHMSszXj3v
8ElD0S6sN91oml0nObejOhxzHf0ybK+sGag+CFA7aBr4k4rYglf7AzOYrPl3nNoCkyrFDQFa46/w
SXJm/os7zUHbsDI5GGUH3BU+NktHZV6GK3iyhtHTwrMgDtpGk6vKHMKULM1Gjv9g1/jp9Ao4cUhr
bCVOXM1v2e8A3564rmh3if78zTzCKamPRAB5Ig==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-PREC-RSA", key_method="rsa"
`pragma protect encoding = (enctype="base64", line_length=76, bytes=256)
`pragma protect key_block
lQ1SYrJbQQ2DzAHXnbicWPpvIyW5W6ZFmw+mEQoO0YE0FHGY+i3EGoCSslFGu0WX5d9yZstLW16z
qM5vK7LhN+Gsjp2CQuGZFye7vQuC7j+QI8esaSVwsapIXFkSYw9d2H+RwksdScoJvwtYVUvr0af0
GuKUK0eeYpvc3DdUN0BJic/vlOFSoTEayvUsatmrDq2+AIBiJXK755be4+z2ERs9e/KZjvOxcco0
oId3yhIV/a4rcJoldHqJIxViNYaOTzSN1W+IStRd4JuTOwjoOzBVcVeJezcSvj4gYOW758j+Qc+h
ijgu30DN0qKF6ntmT+2Ct4/eb1f06XKN2yaOpg==

`pragma protect key_keyowner="Synplicity", key_keyname="SYNP05_001", key_method="rsa"
`pragma protect encoding = (enctype="base64", line_length=76, bytes=256)
`pragma protect key_block
hcY0bbW6uwD2H4WVmTreBGA9Ay6WKkivCJLIAlssNWsxwIN+VjDQnkfmZK2OBwdwjZupWmMNoTRQ
0PiX5V7OIXietnngVq8vWCq4HCZ0SsIDgQ96B0cCg5rIC5C5fgtkYMBy0+dPO9EUvD8JUzExs8sn
UuadObTZHUoldHZ2BfdevNPjvF/HwWGPVeME78RzwpBPskmQeY49pe6XwC9QF+7axG/9+5YYFPX5
mrGuoCQaIfOzoe0uUVXL6zppW65va3D/o52epDhva/MBV3KOIAKa/D99Aexkb91lQZodNQzriIAx
/+ng3qVRZrGeSEFi5JmIMHkKT+7QBsDhArrJdQ==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 7312)
`pragma protect data_block
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
WuK1R/6HJ9CRhggpgrYcDQ==
`pragma protect end_protected
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (weak1, weak0) GSR = GSR_int;
    assign (weak1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

endmodule
`endif
