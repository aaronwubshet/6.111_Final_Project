// Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2016.2 (win64) Build 1577090 Thu Jun  2 16:32:40 MDT 2016
// Date        : Thu Dec 07 01:47:47 2017
// Host        : THINKPAD running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim {C:/Users/Aaron
//               Wubshet/Desktop/FinalProjectContainer/sources/ip/fft_mag_c_addsub_0_0/fft_mag_c_addsub_0_0_sim_netlist.v}
// Design      : fft_mag_c_addsub_0_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7a100tcsg324-3
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "fft_mag_c_addsub_0_0,c_addsub_v12_0_9,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "c_addsub_v12_0_9,Vivado 2016.2" *) 
(* NotValidForBitStream *)
module fft_mag_c_addsub_0_0
   (A,
    B,
    CE,
    S);
  (* x_interface_info = "xilinx.com:signal:data:1.0 a_intf DATA" *) input [15:0]A;
  (* x_interface_info = "xilinx.com:signal:data:1.0 b_intf DATA" *) input [15:0]B;
  (* x_interface_info = "xilinx.com:signal:clockenable:1.0 ce_intf CE" *) input CE;
  (* x_interface_info = "xilinx.com:signal:data:1.0 s_intf DATA" *) output [15:0]S;

  wire [15:0]A;
  wire [15:0]B;
  wire CE;
  wire [15:0]S;
  wire NLW_U0_C_OUT_UNCONNECTED;

  (* C_ADD_MODE = "0" *) 
  (* C_AINIT_VAL = "0" *) 
  (* C_A_TYPE = "0" *) 
  (* C_A_WIDTH = "16" *) 
  (* C_BORROW_LOW = "1" *) 
  (* C_BYPASS_LOW = "0" *) 
  (* C_B_CONSTANT = "0" *) 
  (* C_B_TYPE = "0" *) 
  (* C_B_VALUE = "0000000000000000" *) 
  (* C_B_WIDTH = "16" *) 
  (* C_CE_OVERRIDES_BYPASS = "1" *) 
  (* C_CE_OVERRIDES_SCLR = "0" *) 
  (* C_HAS_BYPASS = "0" *) 
  (* C_HAS_CE = "1" *) 
  (* C_HAS_C_IN = "0" *) 
  (* C_HAS_C_OUT = "0" *) 
  (* C_HAS_SCLR = "0" *) 
  (* C_HAS_SINIT = "0" *) 
  (* C_HAS_SSET = "0" *) 
  (* C_IMPLEMENTATION = "0" *) 
  (* C_LATENCY = "0" *) 
  (* C_OUT_WIDTH = "16" *) 
  (* C_SCLR_OVERRIDES_SSET = "1" *) 
  (* C_SINIT_VAL = "0" *) 
  (* C_VERBOSITY = "0" *) 
  (* C_XDEVICEFAMILY = "artix7" *) 
  (* KEEP_HIERARCHY = "true" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  fft_mag_c_addsub_0_0_c_addsub_v12_0_9 U0
       (.A(A),
        .ADD(1'b1),
        .B(B),
        .BYPASS(1'b0),
        .CE(CE),
        .CLK(1'b0),
        .C_IN(1'b0),
        .C_OUT(NLW_U0_C_OUT_UNCONNECTED),
        .S(S),
        .SCLR(1'b0),
        .SINIT(1'b0),
        .SSET(1'b0));
endmodule

(* C_ADD_MODE = "0" *) (* C_AINIT_VAL = "0" *) (* C_A_TYPE = "0" *) 
(* C_A_WIDTH = "16" *) (* C_BORROW_LOW = "1" *) (* C_BYPASS_LOW = "0" *) 
(* C_B_CONSTANT = "0" *) (* C_B_TYPE = "0" *) (* C_B_VALUE = "0000000000000000" *) 
(* C_B_WIDTH = "16" *) (* C_CE_OVERRIDES_BYPASS = "1" *) (* C_CE_OVERRIDES_SCLR = "0" *) 
(* C_HAS_BYPASS = "0" *) (* C_HAS_CE = "1" *) (* C_HAS_C_IN = "0" *) 
(* C_HAS_C_OUT = "0" *) (* C_HAS_SCLR = "0" *) (* C_HAS_SINIT = "0" *) 
(* C_HAS_SSET = "0" *) (* C_IMPLEMENTATION = "0" *) (* C_LATENCY = "0" *) 
(* C_OUT_WIDTH = "16" *) (* C_SCLR_OVERRIDES_SSET = "1" *) (* C_SINIT_VAL = "0" *) 
(* C_VERBOSITY = "0" *) (* C_XDEVICEFAMILY = "artix7" *) (* ORIG_REF_NAME = "c_addsub_v12_0_9" *) 
(* downgradeipidentifiedwarnings = "yes" *) 
module fft_mag_c_addsub_0_0_c_addsub_v12_0_9
   (A,
    B,
    CLK,
    ADD,
    C_IN,
    CE,
    BYPASS,
    SCLR,
    SSET,
    SINIT,
    C_OUT,
    S);
  input [15:0]A;
  input [15:0]B;
  input CLK;
  input ADD;
  input C_IN;
  input CE;
  input BYPASS;
  input SCLR;
  input SSET;
  input SINIT;
  output C_OUT;
  output [15:0]S;

  wire [15:0]A;
  wire ADD;
  wire [15:0]B;
  wire BYPASS;
  wire CE;
  wire CLK;
  wire C_IN;
  wire C_OUT;
  wire [15:0]S;
  wire SCLR;
  wire SINIT;
  wire SSET;

  (* C_ADD_MODE = "0" *) 
  (* C_AINIT_VAL = "0" *) 
  (* C_A_TYPE = "0" *) 
  (* C_A_WIDTH = "16" *) 
  (* C_BORROW_LOW = "1" *) 
  (* C_BYPASS_LOW = "0" *) 
  (* C_B_CONSTANT = "0" *) 
  (* C_B_TYPE = "0" *) 
  (* C_B_VALUE = "0000000000000000" *) 
  (* C_B_WIDTH = "16" *) 
  (* C_CE_OVERRIDES_BYPASS = "1" *) 
  (* C_CE_OVERRIDES_SCLR = "0" *) 
  (* C_HAS_BYPASS = "0" *) 
  (* C_HAS_CE = "1" *) 
  (* C_HAS_C_IN = "0" *) 
  (* C_HAS_C_OUT = "0" *) 
  (* C_HAS_SCLR = "0" *) 
  (* C_HAS_SINIT = "0" *) 
  (* C_HAS_SSET = "0" *) 
  (* C_IMPLEMENTATION = "0" *) 
  (* C_LATENCY = "0" *) 
  (* C_OUT_WIDTH = "16" *) 
  (* C_SCLR_OVERRIDES_SSET = "1" *) 
  (* C_SINIT_VAL = "0" *) 
  (* C_VERBOSITY = "0" *) 
  (* C_XDEVICEFAMILY = "artix7" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  fft_mag_c_addsub_0_0_c_addsub_v12_0_9_viv xst_addsub
       (.A(A),
        .ADD(ADD),
        .B(B),
        .BYPASS(BYPASS),
        .CE(CE),
        .CLK(CLK),
        .C_IN(C_IN),
        .C_OUT(C_OUT),
        .S(S),
        .SCLR(SCLR),
        .SINIT(SINIT),
        .SSET(SSET));
endmodule
`pragma protect begin_protected
`pragma protect version = 1
`pragma protect encrypt_agent = "XILINX"
`pragma protect encrypt_agent_info = "Xilinx Encryption Tool 2014"
`pragma protect key_keyowner="Cadence Design Systems.", key_keyname="cds_rsa_key", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=64)
`pragma protect key_block
A13f8tlz6UJG9JfCNcYl8NLUw8Tlctm35dCRvt/KCTpBFIuXlOawHL7sTHowWNnYPdFQNufThU2P
nq6r7CYRfg==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VERIF-SIM-RSA-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
oJAsCu5zl/OMFEQsA8TK81YQdELnJEDcFa6KQ0EHWxmJrxei82pUrFKy5/0YZah/J8433WTkuMYX
n4DxKRAShIrdY1X7G4VuvTy06p94vL5LjcHyEy4fxae5eyT8gPJ2ix4XQa8NTiv0ndfGQZyw3Nh2
G2fKlAI5x3f8zwZZQY8=

`pragma protect key_keyowner="Synopsys", key_keyname="SNPS-VCS-RSA-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
wvBGFVtHjRF0sOMF1pCWFAGskoPwO7T2ijyj/eL3cj3Mn4RaSun2E2ii2aHguV5ZVFP65oRsiH5d
RuZPDUKAsxBDhHSsGkFSPIwX9KivlJTo2FZHlBDTlkfDQbn+a3fWxc1HcR9KUBo8QndFpzMmqgOV
oDGrjFRMryCx3hlDJdU=

`pragma protect key_keyowner="Aldec", key_keyname="ALDEC15_001", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
UMkVtIsRH0SCXq8LQlXc2SFapNVFtJ6lm3Wp55oPh2JHEa2eDcLuSNAMzka2zwzCEXltR/XJthW1
e74yTmf22SChtep5vBZ+ajUd7h2t8MuWnhQAMciHkyF4IkU7ju3JOoQFlih3FqDO3aUJPcamhd7Q
ccMUMAhIvZFp44NdLzl8HbXnE1qh9bi1m8qU8jMCKESUZ7pg4lNlsQjd+Goa1H9iXaLEv3OfHZuq
AS/RQip05I1DUFL5hACAmmneYHUVM5S4EEaO3aHf1jZ3r/piru3ZRDHXxDir2Y9zXiL2oDUfsV5l
w+Pp691O/rBEAjBLQdevDcp/mZn7axrfo7gedQ==

`pragma protect key_keyowner="ATRENTA", key_keyname="ATR-SG-2015-RSA-3", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
BizuB2M20zTA5t6lHKGfnJrucOUdZ0HEVkxiYzkxLH0WP9VZIREBo09OejVavblw0lBdoToGD/Dx
ZN2JWgxB3v9b0Oe7EvwN3oB8w0TKm0RoqDmuPV8JuY7RwxtxkHcrVvcjXuOt8j2BPe5Ix86NYRxZ
8RqRFVGNyOVCKZuaFMVHI+ktnNU/xi6ZGsd+L0PEmNWeJ+y+7ubRYuJBTcZK6n0e0Rv144/nsqdy
X+40+rhcynqZUh14Jaqxwmyc8eu2wmo21it2TUiXXzLiWf9C/rPTasxTNu6GgF2yKIv/qtG5zsH5
iEI5vhFnzG+RShh+IHFb+FdSgnifLxcvxMZyfQ==

`pragma protect key_keyowner="Xilinx", key_keyname="xilinx_2016_05", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
WBEZpdyDr9NfPjFUCp37UUdIujNIa897wZZ58/x9eMPhksqlKdy3SYhoDdl4U5n1JXPWIonhbpyY
qfWTq0gV9NaH1PiTuV9w+nrQziNvPhnHnWOzNrltlMQ+uTbMRquXZffmAQGphp7ekw56wGNMIqvn
BRmPzqHv8wZfX/RCaFbjfXAJEmAF89kl5TL3IWnE72Kb9o1cSvFtKTxyRoh9m9E0ghJdkhnRh4Pm
wU/+pIGwon3nUS1E00edVC7apMYbKm+8akp/2UT8ovmuCYJtcE90yRZZaeiFNpLq2UTmaGHp3XHC
2ziTOAA9fjUjv2jhCi5RMA2D0eDmOlHleltm9Q==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-PREC-RSA", key_method="rsa"
`pragma protect encoding = (enctype="base64", line_length=76, bytes=256)
`pragma protect key_block
W5RPOpBgL9Q1ooVydKc7aCtiTlDVrTCo9AfsSOkewmyfZ6Q8Ml1luZxl2fExW6fIKM/TrndCZXu1
+dj4g/OOYpd//78pde5CLbMvtTLEAqUSgIRZoRDBIl6zA3aYkjY/j0KZzFRlfCE1v9iuIklihTcj
cXkiWfdyQfrxOKjzWNHRBfBN96f79vaRBKceD9kv1NwOgzxCOQ82eNy2FCc38eS3wqSn2WpSm03p
4sHMuE1M4ULbH05aPkZmbTB4tEnecnuyyjUvbcGzLf7YhRkTR1QjlwGXAgAEZH9B8v8sedWXEGuO
JZKgvp7P7v9a9aet4zk3So3aHcGB7utSM5QOgw==

`pragma protect key_keyowner="Synplicity", key_keyname="SYNP05_001", key_method="rsa"
`pragma protect encoding = (enctype="base64", line_length=76, bytes=256)
`pragma protect key_block
awRnLJnX/G8k1lmhCSljLQ8T53Nb1+sT26B18K+tdclQmyUB4dApNo6nGazbXRSn/oVmSlhWrS/U
q/aST4Nf93flAuBJfUJdi2x65agKmHaNP7QlVdzbbb7LRIsOfDlicMlTffwI13ZDG39VZgtzTr/G
96TDCqoDEdXbBV0J31GJWyZoWbDfUxuFjIs4oabzxevTsRuoEBoL+GoaKQT8GVlKSX6VTUfC3hOM
b4zQ25T0jCDcwysHHqCVXiZluYU6H2nBF56b318tbhl/H3o1meSIlBBp7MX/0PD5WxzXsPsQcPhw
jmT4wmIa6UK2+9VkaIE8hrQNkCi/2LtT1oR8Xw==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 10384)
`pragma protect data_block
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
5UJ74NVQ8fGtZQ==
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
