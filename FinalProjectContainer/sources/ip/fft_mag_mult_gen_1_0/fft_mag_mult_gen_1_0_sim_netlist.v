// Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2016.2 (win64) Build 1577090 Thu Jun  2 16:32:40 MDT 2016
// Date        : Thu Dec 07 01:45:19 2017
// Host        : THINKPAD running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim {C:/Users/Aaron
//               Wubshet/Desktop/FinalProjectContainer/sources/ip/fft_mag_mult_gen_1_0/fft_mag_mult_gen_1_0_sim_netlist.v}
// Design      : fft_mag_mult_gen_1_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7a100tcsg324-3
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "fft_mag_mult_gen_1_0,mult_gen_v12_0_11,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "mult_gen_v12_0_11,Vivado 2016.2" *) 
(* NotValidForBitStream *)
module fft_mag_mult_gen_1_0
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
  fft_mag_mult_gen_1_0_mult_gen_v12_0_11 U0
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
module fft_mag_mult_gen_1_0_mult_gen_v12_0_11
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
  fft_mag_mult_gen_1_0_mult_gen_v12_0_11_viv i_mult
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
hsi8p9+HmHaWmsKxqpd0MUrDMc3OHbasuZvUJTGllTdjzciks6GbQYBfBv8N/b8mAzgdlKkbNq3X
VHIo7rYlpr1B1KXYGbUXygKE5L/aQaPvJo8AUW1rMncgXXK2R/4Xhg9Y4veV4BhQF7cJJeUghSoT
TzkqDLvjDuxlsaZlYAd5ShSK/dSb/Y2yYepnQbbrXXYFlNsbUhpaDYlOsDT3hauwKY1sudbgEkht
cx+AKGr51aLhekzBGOvL3DGFO41Hj7OBdkQiRC0n1ansfLC1MtMtG+xZBsD0TvnHDJWCSnK3Da4n
oLJ9yhWrYN+4LZ9IS/N1T/a/XDbsKPdALyXkug==

`pragma protect key_keyowner="Synplicity", key_keyname="SYNP05_001", key_method="rsa"
`pragma protect encoding = (enctype="base64", line_length=76, bytes=256)
`pragma protect key_block
FeWpHRaEMCwH65hZNk94xjKJtB+DCNloaHW0Hs3fNakHQ+JbBFB63zidvwnQ85Se/5U583bk5/dR
fpWkqGyGsjXihwUZQCAAwU2N6NbYg39gLEKF7GSfs1YByKn46JQFVsRcFWmX3P0POFNH/mWlG0YU
BcOHrNOjF/pm6OmdwTZWuo+z2vEmTMoCK87ob399L8q/TN8B32Er9zOAXZUq5xTik8ibA080rRx7
9KCpQvuamtE+b61LsTXr+rWRe2h7ABBw9ZKNia6629C0odBVsLhEoLBi4a4M93guN1/dbU5TyTl2
P036GsyL8f4yiQjjvRLvzxPJJ02m8Jiln1EEBA==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 7312)
`pragma protect data_block
ftN6+Fp+mfsRqCDuM3RFHrqI0IK6OWjTPgJg3jk++6wQwxfPCRE3qDK3EPyxsMHXREzueDJaEEFN
a148lfkBX0n6uwJCDemfuw6MSSDBuxxkfq9MmB/QitKJjQ2E6U4qznw0/iyiDgmMe7g9YFL42ut4
e4Oizsg2CXL9kSZcRrCMhFSwrOe7dqm1L19rrhBYQyGJXB+E0Tsxr9ygkEUNBrNftcbOkqah5vRR
zGflvYZBX+mxVHE/o42ymgKbjFiMBD8OBk9OedmAwrKr5mQqssMjDomj1tIL0Hs2vWQadH49b5oa
+8DXimlKAj1gehiCe2rZo2Tj3lFngxm+m8HnI5gkFPyks1TJq1RPr/qbrskuPnuUjWaBOHOEVcLm
FUQHhyYqxoMpxfLpfwjBEWDiEzrVIYRYnr4uMJvAUMq9Y9LsMcLq7sNWW4lIxO83PRk4Ci6LrUH+
4yiaIi1/nG1B9rqSl+LrLUbLwQC8w04Emr/SPeV2FTwW703YQhPM15jdWPwECm9/kAVLNaWDBLJP
WQi1cWSY5eEJARItt/hLZBpLvbTEzl3sOBoN5e0c0TVm09zVj+4p2PGs9eEdWrO8QMepf1ZOHYke
art+ngIrN8ijZOnLLvErbOG+v9d3XUyJmTid8oiCvcJxgG02bqf5svv5+Kzc4db6c+KkVEDFTgvA
aCCcv3a9gIFUoq5hqxV7seRw1SqcRJdtM1UzB2wbgwSlpvlICxrw11m1sZdDRnhCxGABPXVj+ldZ
5JytCThJkEQjHzup06ERq5p5n2MXQqpYp0iFLC2p9PgDVr3K6hIWt6PQZP5Oz5yWKXsEh2IW7zDn
4OJm7m3HGOaRo14ImEAE9lCGvNDCb/6lpZNiUg69SFwIZ3VUK/RqnWKD0DwQW6LdJmGt7svb0Ccn
1fs/TDvTYSo9OsN2l8Gab1nqXKFqoEEMiUBjQRvXMzEnFgzJcok4Yhfy2QHn7eDTuviW/e93o/7h
rXR7mMpWY77teiqeL8EdtRsXt3uXLYNd2f4e/XaiLtIiqieY39U2PAOC/7t3rDYidJ4RghqkSPY2
+KvBuj8JLjzpnc5HMSnQyxazo79e0uCkveq1i8qjon9RoMDMt1ptHG+r00dIbeGyPBm0sG9YOado
trDcSO0tFSrFk3GqWqeEL8yQxe5L+FSAHR/954OrbESe3Vwh7aEnFdB/rG0sbxx3bVLDC76SJ8l8
Q2H/wa1mZCLvT1LOU3t46j0iJZW1Zf/kL7LlEEh8lzmtg3q5MuArHd9l0hk1n4sou9oXQWYkmfVo
91pvGcK+WnYCiDHvN2Ie6mCh8L9RnvQspuJw3zYGpcFQORklvpxisgHV0dSeh6E+Yy5aKTCU+9Bb
0ScFivV77VXfDysMPKord+4+Rekziy+etfZ9/8j1/6nkr1B8VdGmyH8uvBJpMIq0R1jkrDMs4T4T
j+UfKulgU5dbUtZM/F4ZSwxoqtCJejE6KsFQxMrdgpeS8z0AMrICfNo49/KIgnIWlqP4OiYDuWlY
KL4e135Ey+ELWEoLrgBbkHfGIVwK1r49P+kjwsKuNm/+mIfI3hBtBiwAQxbDr1q7lww52q11k5d4
tYMHbULp/gvvg0Jxh/kRHwSvaLiCGbnMYz2RgQ7bawaeCvf1zNgpi7AyEi0BRYSZf8c/6g5uikqn
sVfRdKdt5Rfr8J8Vt47Gr1RIUpNemJLVlHYlZotwFoVNx9aTzRnPQW/tVj1Z2dD39oTgP03dSx/c
GwZLtrsbdGUxBELDs7ERdKq2A1aQznO3cFEZyy6Ue07VesyBjBpGKXbNzsjPJbCtJsnqgME9wNpm
RD1HTqNeDqViivDkagvcW6dd8CymLO4+qQfiQeu/gApGVrYiBK6CpxtPLG80r6ktuUnHkl2kQQ0z
ef4FQwNfZGX+9FD1YiGmibhlvyh0novCVOX7TBCQZncFDg9iXcpw/Klcvm/IFkUW1ZRT4z4VAtGQ
fbGi7WICXU6i2N6wREkdDIA4Flp9BXrsvxvAVQ09fQIfEun0K84KiuIUIMvODnMUcxSZtIl7ShYz
B70RSE7RFRmBu5PgbFVBT8yB0GBWQPTS+/LUhQuesyblXuypcf+4Wd/tPS09pO5OQilmqE+NYg6x
JD1i/kmrqPrMuXT7qO49EvT6bE8QVAUGAu7V9Hg61ifQB1cIpOnYD8LGnFmjhKiqi5cu+urrgT8k
eHOrO7fnLjKm3wjBKXwrzEpouzXQXMqoUIQJOGVMk61wr08cgKg03C7ucQTL/Lt8inlaNMoIrfgg
Q1Nwd9+d3PVJYAzl0SLTQ0qXXsemLMEg6QJQc8tc3ZhyEgvEDPS8FLb/YoUr1diQCAHdg+Xtt67E
NrksKOIRntuoI04hSapTDmn50e2OCVirEqrTATeF+KyR2A01jVbyjqGU+yt+ckMtfi/hkC8cODll
cstaaj+qo549ML8P5nCCR8CDhaMRwTZAn2ShJIw1v6jz4cq7kzvPjRgLH20Ja82jkGeJuWz9oHme
DgLLdei9IHnFiNXMWY0QscDCfaNxDZCwL0pxXsC5w5odli7EmTa3tJSVJlXJyR7QtGlQxrYUW1e+
hy2IaZxUfpcc3v3F3ml76dxl8UjQp/mMdclPca1EuW9qtMnNeC4i8OgXr0niIYC+M7W+oIC0YLgl
1J3ZJCZzWp16ieYbaJyLVi3J2W4gmq9gOtdaNovjArnkkl/P4C4fE/4sp/Qp+xvBPYFcehdQ+/+x
QaTbJwcyewRC5rKfxMyzHzR6fob3K8jI0jN4juEz+z70AY8j4ywKH8bQjz5B2zL5jyQrmu57/z2m
UU6OeVR0EQEqAghj0BZ6qFj2HrwNLiA2RGllI9KoKhM+JRyXzdpeBIm9AiQl3u5rMPCF1sh3+Osb
R2/F6ZKYOJjvbtumF6W+3F52ZC8zNpESI8wi51+lgZslGZ4jttIHFydOyYGF9vHh0x4CWIUab1LN
bj/gTtkmQl13fgkb3X3ceX8RkMGAQH8mvAnXDR84A/IXXcNvIABF0aMfoAw88Ph401ISjHhDd3jn
7SxA5NNtEXVLcRTNoXyMkZh9yu57xLnmC7keb3IJvwennO4zSEGnlHcsksVTkFvv/w0ch2uXElq9
Kiz7CvLVSnVttgqigvUR/z/g/rIUTz2/fW9OcdvmbuKo96K8q48oZxYgbjQy1SFOLJoyNt5CE7EJ
cwvDgAExAiFvkoQtBQjeWsOEx8BlX2xPjj84aVTQpGwwDdOTNnsci7LFCztq5zsebP5BYipXmscG
CgLlA51a3vi0BiHwcVz4W7iqKNznh707Le3X9pJsM/HC9hFKvtqRydJVh88nFuiNY83t8xnvro7a
P7gMW4595Dd82xFplnbiwt5j6nkU3moP+jKXrHZVXqjnOifTS2ScVNdvv9vOVXB5Ge2qxCApAJ2f
oa3clG85+fyj0SYrZSyaXv7KT/kQn0L0NcYFlk0TALav1ouWtaswFgKNRxNkUSaGDoYo50u820tI
vfCB5o8qBpwBc0eqLEz0LXDD41P4dcrrhlsryez78ReRNFE7kBZatC8bzuPTQyHKlHYlAQEpOUgh
6tYdQeY5/XecA2fHfhCmS8Fmh3lCR12RcytjsOZI6PMSxxSzE03juE75Lua1p0Ekb3dRlx6WI4aS
JrCadBqhTHC9r7SNNjLe6oHv6T8ODe43GoWTR8JHVJ2HY0kSUpWztrAbIAH5bzMtFuckdbFW8ItI
kyvSsm0RXdE0NH54BZWbnjNVLdJcjTMdMsX8eFHkXm4kyLlSgXo9lgCvDpUXW7dd9NUoEw+7XqZg
C74f/O+XVL8GsKTzhQoVSlFlRh5aS/otzp6umiwypcJVuvkCMLgsdpF0fvkFaj8ppgKAZA2jn1IJ
zaC8FLMQoSUj/CefUOxQEWI5MMETKKLe6iP2jhN91D1kEMbZB8/gtHQ0oLU+S6v5lDlk3aYmiRIQ
EVCbZixojo//+cIPkUtoXxYRpWX0ilnHagvj8PsoaXYaReUH7uFErL4yWh/EQq+8oNRG5YA3mS9q
vsp96M8rTqQ6g7N2yPVmHSdtWGkGeDgP5FfX4DuAlg9C80xKVauaXJKMpck2DPAA3SvFeiyl9lz9
V6bDT/4MHe2vMiiPKh9YGwHXeaJ4tLectqF5ID2h1l4IOvEgrFyMxYdLO1mbXpmEnhbwU8sQ/6B0
RjCP9//xtVH/42D+PJGp0KKxhPGFk+8nliVejYkVdM4rQtRWIxdd+uTmG9NOJZXOeiZV5rsRipla
SjKwLH1DQWuUl+Jq2w/BrHN5sEoOHTyxhadxhTnex1uYndh8OQL+P0tMBWQCp+Fq53chjkRWp9uO
hOLHwN2W+19D6/8JxVJuhgj0sp6cpdgJaM0yjkV1wxejH+eZ7GCJGfh7U8X7WT5gn4xn+1S3aCnL
mCuiTaWdd9Nx20plZRngP2lbSChlPsznZY+87E3UoJnmyyGSxAiaRqLd3zjz9COyFVKo1LzM0TB+
WwCBxDBQ5/o3/yB4pqiu61KUAKUspH4Urtmcr/cdbOlSmt3YWjDeyicKSvA8lBu7/y5kKTSxoFxr
u6g3GsBjm3dFlB1VskhNrb6TMaG3f5dkgrM8Yly6hvMmwi/0VnThuX7+2Q4YBRsp1/XJNpHubbti
zg9quyNPqmW++RgCbeCKxYbuIXe5dgLLDyTu7qdRW7J/sM3vHn7/1FErZHvneVobKqqZIhq1aHR4
jzwrNN6X9awYVbO8Qp9K13Z6YWHNm1/N2PJnrhTIYPRnE2rltB0kjBmb7VTCXOk5GTuRwKnbemp3
y5iZw7rrQTCB+9h9ngbvUukoIwUo1yK1T5LtZiG3kG0b8e7AJv0Sey76XastOKi7oy2T1siCfWH6
BRjI5TE6YFjTEZAralTm/4RFiF/zJSdzmWzIk8vVKCyqCfYPOSr4mO19NcVw8s2bIfIcs1cAfbyd
2k+IWE6YbvKEjR0AyZLJFVTPbVYIzaErq/itmlmg8Eq8WafVUcPhEVKn6Qphq2E0wFmGy8Ojw3Ku
c3DqPLmltryghe1pF2Y1js6QZTHCiM49eldAhCoXm+ZYi/1TXBsJtTDOuJvz2QzgMbeSlkKH58l+
yp7i532inyQpux2nBg7ntHrIheJI5dpbSapJu32sTHsJGlFDv5ubZEyRJlFjHeGBEZpEuBHZyoB/
q80opgI8lj2kmbyUxbptybi800j9y8C4go0J/8l3Zr4nRbQnf6NFY7WpoWADpV8mKdsbTeLe0rej
B0w3iHME0PqhLpitYeJ6ivia+PMqa+ZeQnRVBR83D+zYG9VQ0XMDCW7DM7IPQxacSOIvl5pqfw3y
6VCGlLD8t2p3Ir0tWdajsc4nw0oPcQ3D3O21TDLccmJ00sYVV+v3fy2R3Q8y2Oy32tBWdgBDr9Ux
+1oO6JvWgAkwK96n6FPPzqXNrcShaeNu2dBsx4YctFFHz7PNQ2zE0+ksb4tuSOysZ9s9g14kn9qj
nBHK+OjjwouvyWgfBbb3Uf9FW/ZGILhldHGj9p38aDtM0YR9xP8k9N8QvC8M3XVVUeOjUkFM+hSs
+Zn8VoTeyjf6d30qgwNC+lkE0WDQIvLSyNtyA7FrCPvZG9HsY9X02ZrmNWwHuMx/vF3zJekOWtY+
xT+GL4P2DkefUghZoEqNsiGFhp8e/05SSAwcMc36Zyf+6IXw0Lo0DXiGLQ1jNly5qeWKzWvWB6tX
9Y1fvm2F6rvffxK2nq2D/o6fdx/qinKDVV1S5VFjv68D3eiYC3gVD20jbruLTyDOAnSciL0BXfbi
so38g1UzlEybgCzKkaG6YCDSTEVMvF0lsm2Md525Y3uABaT6whSoymYbNZUxMumfnED7NbF+dxVe
rmOx6i53QGtlaevKRWfI5jX8bWgPAo0OSe0uhIpa65zrFtArc1WUJoa/VCix+s8do3kBI5QwmbLV
ufJuSOb/TekOUEv1KUQvIb0KJWFmfEZGlCk0Ck4InG2vGnjkq/4gnHw3eVwyRLNtxx/QFw1T1s5X
NtQfqDPAOGQnPOnynNGnS0Vw3v1CR8BlZjkcQX2BBxynOEY6659dHP+FMqj+CuRvjJB+MiJn9mdT
7uTSj3EE2Td6hYfc2csuOopZiyAkzQPS9GLIZy0ZwNdUDEfnSTxneozyYYLybS1fBi8sMTaAuBOJ
a4utOK2OqFjhCDZ5GOR/VuB1n2986HwqOZxuu/nlrD3sWstkLZFzL78bQwXkn8G0nqyxUY6kXGH3
B2pPP6a/TQThGZfrQu4HlECa6c1MLwi+eU2/j9a0H/eTvdpSCRg7VVmy8NIbE6qxfGmc0ZahLQB0
+ccWPDZXcjV2hJNmzG5egAESnRUat3RHgo87vNXhjPN4h5FVb7whv83+1R0AA8LyZmr/iXNQ5nbD
cJggbFRV5LnS8vEEfYiPOc7NdN7ltSpiWcayeUhJFve4vQYIxpeK1wP612WBAhOYkL3i4X/l82DA
HddeMCUh6015jzSfw7DISNBXt9Hbl+NvSJWxbvgV2eBzs8H8GsGrHV+4v302o6Kaa23bkrQph5at
0xYRPu5V5sUdA/lm853ScDZhti3zB+6dbsUMIlLOehpP/7UJwdPIc2WLB8IxP1aPtCpJ7vNf5xPt
VTXx9z2LpNUhx08kJV5qk4Ryu33CpkYBS2ZYfiyNcCvVA9iD63elIB9NqbtMOcGMl86SwjFCauPR
O2rM2cRus28NuxwTbTHQ5kleetOf4ERRQUlNQE7IUtyW8YKNv6bYMDkjKC7v3T6wmDuwlhw1X7Vq
LBXXkmaqqdL1oHXLelKg2UP2Kd7UDAmMzQ9CHOhypX9wsFaz5VKGi3InGg7eVdtpq70MGop1XPKb
e0xiJqLfOIe57Ixhx0QPVd4Ck9J3g7YBrUHR2O12RHvyjRmmI5PwY8pwQYxrxdrkwUvubX6bXkTb
uyIPB7/9FDJgAyL9z2RW76yoAsBI04MVAqvJQplO02yS0/1RO1be8pFPRB6aiqfOl1Cte91adiRz
V2zoRVAV/C1b5wwsaGuLsgrEhmauFFVlOEgolOedhJ9LFTV5oIu8QhydehcsNlLieReE/2PU3YzI
GRdYSqoOaGAIcxXOMWRZBfB8BlpbHU2jNYVpzLBqZXPTaHwmtD24TJ0rHxBVfJs0XT0xpA3mjFd4
UKzuOF43hntD93hf3dhf1P1eslhwZhDOIfFWZ83rS6C4Q5C4qOKpYAIaum/j4eoxz6Uhx5XtoVAS
gXzS/jsOnBABafj57XobVTlRscamEWT91SL+QEPNSm1E7XLmwnR6Q+0FNHC84AHjOnlwifvpEzn2
8xH7i2MRiVwVOiFO+RwlbycLvBoyEZKlOAQNM3Df8xcLB55d4ybv/08AE9LGgNHF9gQRAYnllu98
5bIoI6YkCDWFkSfuMY+UWCj77LdGwhMqcHPrJIgtkwJPaNJ9UnAPMlxJxpLaKmWeip3p+lISVZdl
gVNHhlgCXUZtii2f8a6H/7oXJ60eOUef7W6GzmJbwSg2nX2BY9pF/f7LbFvuYwdJl/V4yK11OjGK
WMtZyxsszXxoBFIzt9bvFT0EjMFfv2gXj65iMS28Vjmwy6mDh496ACoMewXTwmorHibzkHLwa9CB
VTF6rjaRKNaw2k9iG5lvgY+ysML07DB4WKA2RRQGlpvm9fHDNv965ryJACOxT5WmBxKjxCkkgdZY
mn2GVJoMcXw5IovcJFMJepAb3AkjXJh3kEHSrcjb3XboPbaHlQ1+/JpNkJpow9W6vjwP0vuiDD7/
4LX/XWndafWqnABdG7CoUKFdu2HLnK+YDFlGwe0VYWTIZ5WcsUsLCEmAOr8n+UO6hpMInVSn9/HI
lCEsukAPSzMieEkt5EX3ZeT9VcuH523cIxxWYNyOryvtVdIQXtTA0tg2PqSCe2MOgbHqdRzCRwfH
F6VbzRtPEKpIOt4U6xFexBO946Pe0Phpmn0bNHwPHGPLK8Ix9jW8jcRqCoQy760EsnFfFBpE3xju
P/dGAyvwnxiRyIOlnGucI17qYaHDYugZhjP3EsXyyO5y3C1Z3XbT3D41VxNjRGGQlfAX0Ui3HHhU
VwjPkkMcQK8les+1gGzQweAFu6hHNIKIlqLgOPdkyzycHmCVZIaoog3OXPcRcftjNUJvpROEyr5o
tYct6HFCsupJleAC5LvF+YpMy1V1E3iT/5AREXhDkJ23SsSizUfQPvjiadwkUuuQln9oVxYMPkcH
mQjnPVdYYwTc6ZMqHAk2Wsq+VWjtMSE8wOL8ocR+JDnVGY3j2Uh/6F9Lk48hZz+R8t6uzG3Hfrgh
Fuap97nKoO5nnWiGcpPgD+NgNcCnmoeJM9CtxKHhkF1oynRK3KW0JyAGhDIHXodsrilUjwFJjgT9
fxvtRaaEyw1C81C1CNhpKd0mQLvITTNqMv1ADGrqxB6fImbblkNZi5KtlaxRSC84jXGk5nMsziNs
63BV4f8PtLPyLSxi9/J6lY33naLvhRpRfa2eNAeFZ3ilAGm6Gcd3zIP1vi5fLrhQmbfItMLP8l3D
ZqIIPNUyarQs0lJm/W2wFs3y9cIGL1ZOQB3WJpctqpujfvoNQMcdWmjzPKp9Mkf749D/RNkdxLME
FskUJy/ukiNN56qwiyAip5z3Iyi73VjLGJUDuIpda9QR+gShnmJLHRjfc+n71O4A8KRkxKpc8CSV
denf1/W+jcmKZH81eblpCNVcGTKC5WLm7N47CyeRs3zRz9cTD9E7qmFwA+wRFJvIRVjsIzz5Lwyh
S1qgjYVPM5h8zqDynQH3kkoJrFU92uNajIrOpRMypvbgYyYKUbuL+TAByTJe4XZPzbfXUXPxkOAW
LgfILE3khjiIe1PNM4d5AIupJRhgJhTSynQzd8sgN760as3q8Rsn7eFUNwXIJChDQLOMBle/AzMy
JxlPiT/kbIK1I/zoZCNAynWbuRorowbYswOcmecu7ab1Y9b7wscEh66JOiW4ZmfVs2R+Tg+G7XaJ
BDd8w4q2RYf+4QYJUN1Iz3aHcKyd47a5C7JHs0MbBOzwKsPKFl3A0WqSsrS01OHVHTSW/9NHqpUs
WVUavWbXOaU5GDk2Sci1s5We1EJ2OEPS/7c/EFHy0xccolhzuz3Yp0eV92x+XpIiMGz8PnHMHBsv
eBtracCDYlBvRD21lkrAI42ok3i3Hd1r5qjDpxe7IsaRCc4t64sLglIy/oBscORg+FvbZT/7+nWh
DZNN3nrKMg712tja8alj2+p2cgxvMXnNe2BOr1GMK8Ff8pzqoTWlWQBO+ZseYk0z142pAUwOQPFs
rUyI9j6byCKGaoU+PmC16XTo6GPpXjyUwOs7ZUmCkh78A66jTZeOsGv+w4SOS4HNu2RxdZaQ+5a6
saD9zGD6KYepCd9K+mD+smIQVroNmEHbMdX0/3Ch+7kPADmI9LNmz4p/0kdnQD9gomRZQdaNi9cA
lF0yT8g4TNaN6W13xkCYQACMfBDNjm/FsYZiaV496q5KXGh+Xy99An5jTLCD19Xt4+BYi6KEo7bY
joOGxH/YRN8vZ9YbnHIf9UzS9a4TCV5cToUPCdN/HNF/3wSZcNeQ5m3HP7p3gNnEiRxQlvuqHaaw
2CBgb+o5yLGfemDgZe64ia2Nj4teIzQ+jHRn+anwdoOPYyao/DgfGCIGVTzx2ztQdxmYee7HamO2
N2NEEeDp0TG3k3TZ5du8lfpbN08ZXQRxvCEos3liMquIo6syVqHVY83sM4dQI8ih9tu1Bysnr1qA
tkHvwMX05R9PqYUoUaCMIw==
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
