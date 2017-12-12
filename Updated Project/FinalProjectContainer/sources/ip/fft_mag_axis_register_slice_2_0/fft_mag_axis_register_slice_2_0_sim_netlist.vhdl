-- Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2016.2 (win64) Build 1577090 Thu Jun  2 16:32:40 MDT 2016
-- Date        : Thu Dec 07 01:43:54 2017
-- Host        : THINKPAD running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode funcsim {C:/Users/Aaron
--               Wubshet/Desktop/FinalProjectContainer/sources/ip/fft_mag_axis_register_slice_2_0/fft_mag_axis_register_slice_2_0_sim_netlist.vhdl}
-- Design      : fft_mag_axis_register_slice_2_0
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7a100tcsg324-3
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity fft_mag_axis_register_slice_2_0_axis_register_slice_v1_1_9_axisc_register_slice is
  port (
    Q : out STD_LOGIC_VECTOR ( 26 downto 0 );
    m_axis_tvalid : out STD_LOGIC;
    aclken : in STD_LOGIC;
    D : in STD_LOGIC_VECTOR ( 26 downto 0 );
    aclk : in STD_LOGIC;
    s_axis_tvalid : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of fft_mag_axis_register_slice_2_0_axis_register_slice_v1_1_9_axisc_register_slice : entity is "axis_register_slice_v1_1_9_axisc_register_slice";
end fft_mag_axis_register_slice_2_0_axis_register_slice_v1_1_9_axisc_register_slice;

architecture STRUCTURE of fft_mag_axis_register_slice_2_0_axis_register_slice_v1_1_9_axisc_register_slice is
begin
\NO_READY.m_valid_r_reg\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => aclken,
      D => s_axis_tvalid,
      Q => m_axis_tvalid,
      R => '0'
    );
\NO_READY.storage_data1_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => aclken,
      D => D(0),
      Q => Q(0),
      R => '0'
    );
\NO_READY.storage_data1_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => aclken,
      D => D(10),
      Q => Q(10),
      R => '0'
    );
\NO_READY.storage_data1_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => aclken,
      D => D(11),
      Q => Q(11),
      R => '0'
    );
\NO_READY.storage_data1_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => aclken,
      D => D(12),
      Q => Q(12),
      R => '0'
    );
\NO_READY.storage_data1_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => aclken,
      D => D(13),
      Q => Q(13),
      R => '0'
    );
\NO_READY.storage_data1_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => aclken,
      D => D(14),
      Q => Q(14),
      R => '0'
    );
\NO_READY.storage_data1_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => aclken,
      D => D(15),
      Q => Q(15),
      R => '0'
    );
\NO_READY.storage_data1_reg[16]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => aclken,
      D => D(16),
      Q => Q(16),
      R => '0'
    );
\NO_READY.storage_data1_reg[17]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => aclken,
      D => D(17),
      Q => Q(17),
      R => '0'
    );
\NO_READY.storage_data1_reg[18]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => aclken,
      D => D(18),
      Q => Q(18),
      R => '0'
    );
\NO_READY.storage_data1_reg[19]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => aclken,
      D => D(19),
      Q => Q(19),
      R => '0'
    );
\NO_READY.storage_data1_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => aclken,
      D => D(1),
      Q => Q(1),
      R => '0'
    );
\NO_READY.storage_data1_reg[20]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => aclken,
      D => D(20),
      Q => Q(20),
      R => '0'
    );
\NO_READY.storage_data1_reg[21]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => aclken,
      D => D(21),
      Q => Q(21),
      R => '0'
    );
\NO_READY.storage_data1_reg[22]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => aclken,
      D => D(22),
      Q => Q(22),
      R => '0'
    );
\NO_READY.storage_data1_reg[23]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => aclken,
      D => D(23),
      Q => Q(23),
      R => '0'
    );
\NO_READY.storage_data1_reg[24]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => aclken,
      D => D(24),
      Q => Q(24),
      R => '0'
    );
\NO_READY.storage_data1_reg[25]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => aclken,
      D => D(25),
      Q => Q(25),
      R => '0'
    );
\NO_READY.storage_data1_reg[26]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => aclken,
      D => D(26),
      Q => Q(26),
      R => '0'
    );
\NO_READY.storage_data1_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => aclken,
      D => D(2),
      Q => Q(2),
      R => '0'
    );
\NO_READY.storage_data1_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => aclken,
      D => D(3),
      Q => Q(3),
      R => '0'
    );
\NO_READY.storage_data1_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => aclken,
      D => D(4),
      Q => Q(4),
      R => '0'
    );
\NO_READY.storage_data1_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => aclken,
      D => D(5),
      Q => Q(5),
      R => '0'
    );
\NO_READY.storage_data1_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => aclken,
      D => D(6),
      Q => Q(6),
      R => '0'
    );
\NO_READY.storage_data1_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => aclken,
      D => D(7),
      Q => Q(7),
      R => '0'
    );
\NO_READY.storage_data1_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => aclken,
      D => D(8),
      Q => Q(8),
      R => '0'
    );
\NO_READY.storage_data1_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => aclken,
      D => D(9),
      Q => Q(9),
      R => '0'
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity fft_mag_axis_register_slice_2_0_axis_register_slice_v1_1_9_axis_register_slice is
  port (
    aclk : in STD_LOGIC;
    aresetn : in STD_LOGIC;
    aclken : in STD_LOGIC;
    s_axis_tvalid : in STD_LOGIC;
    s_axis_tready : out STD_LOGIC;
    s_axis_tdata : in STD_LOGIC_VECTOR ( 15 downto 0 );
    s_axis_tstrb : in STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axis_tkeep : in STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axis_tlast : in STD_LOGIC;
    s_axis_tid : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axis_tdest : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axis_tuser : in STD_LOGIC_VECTOR ( 9 downto 0 );
    m_axis_tvalid : out STD_LOGIC;
    m_axis_tready : in STD_LOGIC;
    m_axis_tdata : out STD_LOGIC_VECTOR ( 15 downto 0 );
    m_axis_tstrb : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axis_tkeep : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axis_tlast : out STD_LOGIC;
    m_axis_tid : out STD_LOGIC_VECTOR ( 0 to 0 );
    m_axis_tdest : out STD_LOGIC_VECTOR ( 0 to 0 );
    m_axis_tuser : out STD_LOGIC_VECTOR ( 9 downto 0 )
  );
  attribute C_AXIS_SIGNAL_SET : string;
  attribute C_AXIS_SIGNAL_SET of fft_mag_axis_register_slice_2_0_axis_register_slice_v1_1_9_axis_register_slice : entity is "32'b00000000000000000000000010010010";
  attribute C_AXIS_TDATA_WIDTH : integer;
  attribute C_AXIS_TDATA_WIDTH of fft_mag_axis_register_slice_2_0_axis_register_slice_v1_1_9_axis_register_slice : entity is 16;
  attribute C_AXIS_TDEST_WIDTH : integer;
  attribute C_AXIS_TDEST_WIDTH of fft_mag_axis_register_slice_2_0_axis_register_slice_v1_1_9_axis_register_slice : entity is 1;
  attribute C_AXIS_TID_WIDTH : integer;
  attribute C_AXIS_TID_WIDTH of fft_mag_axis_register_slice_2_0_axis_register_slice_v1_1_9_axis_register_slice : entity is 1;
  attribute C_AXIS_TUSER_WIDTH : integer;
  attribute C_AXIS_TUSER_WIDTH of fft_mag_axis_register_slice_2_0_axis_register_slice_v1_1_9_axis_register_slice : entity is 10;
  attribute C_FAMILY : string;
  attribute C_FAMILY of fft_mag_axis_register_slice_2_0_axis_register_slice_v1_1_9_axis_register_slice : entity is "artix7";
  attribute C_REG_CONFIG : integer;
  attribute C_REG_CONFIG of fft_mag_axis_register_slice_2_0_axis_register_slice_v1_1_9_axis_register_slice : entity is 1;
  attribute DowngradeIPIdentifiedWarnings : string;
  attribute DowngradeIPIdentifiedWarnings of fft_mag_axis_register_slice_2_0_axis_register_slice_v1_1_9_axis_register_slice : entity is "yes";
  attribute G_INDX_SS_TDATA : integer;
  attribute G_INDX_SS_TDATA of fft_mag_axis_register_slice_2_0_axis_register_slice_v1_1_9_axis_register_slice : entity is 1;
  attribute G_INDX_SS_TDEST : integer;
  attribute G_INDX_SS_TDEST of fft_mag_axis_register_slice_2_0_axis_register_slice_v1_1_9_axis_register_slice : entity is 6;
  attribute G_INDX_SS_TID : integer;
  attribute G_INDX_SS_TID of fft_mag_axis_register_slice_2_0_axis_register_slice_v1_1_9_axis_register_slice : entity is 5;
  attribute G_INDX_SS_TKEEP : integer;
  attribute G_INDX_SS_TKEEP of fft_mag_axis_register_slice_2_0_axis_register_slice_v1_1_9_axis_register_slice : entity is 3;
  attribute G_INDX_SS_TLAST : integer;
  attribute G_INDX_SS_TLAST of fft_mag_axis_register_slice_2_0_axis_register_slice_v1_1_9_axis_register_slice : entity is 4;
  attribute G_INDX_SS_TREADY : integer;
  attribute G_INDX_SS_TREADY of fft_mag_axis_register_slice_2_0_axis_register_slice_v1_1_9_axis_register_slice : entity is 0;
  attribute G_INDX_SS_TSTRB : integer;
  attribute G_INDX_SS_TSTRB of fft_mag_axis_register_slice_2_0_axis_register_slice_v1_1_9_axis_register_slice : entity is 2;
  attribute G_INDX_SS_TUSER : integer;
  attribute G_INDX_SS_TUSER of fft_mag_axis_register_slice_2_0_axis_register_slice_v1_1_9_axis_register_slice : entity is 7;
  attribute G_MASK_SS_TDATA : integer;
  attribute G_MASK_SS_TDATA of fft_mag_axis_register_slice_2_0_axis_register_slice_v1_1_9_axis_register_slice : entity is 2;
  attribute G_MASK_SS_TDEST : integer;
  attribute G_MASK_SS_TDEST of fft_mag_axis_register_slice_2_0_axis_register_slice_v1_1_9_axis_register_slice : entity is 64;
  attribute G_MASK_SS_TID : integer;
  attribute G_MASK_SS_TID of fft_mag_axis_register_slice_2_0_axis_register_slice_v1_1_9_axis_register_slice : entity is 32;
  attribute G_MASK_SS_TKEEP : integer;
  attribute G_MASK_SS_TKEEP of fft_mag_axis_register_slice_2_0_axis_register_slice_v1_1_9_axis_register_slice : entity is 8;
  attribute G_MASK_SS_TLAST : integer;
  attribute G_MASK_SS_TLAST of fft_mag_axis_register_slice_2_0_axis_register_slice_v1_1_9_axis_register_slice : entity is 16;
  attribute G_MASK_SS_TREADY : integer;
  attribute G_MASK_SS_TREADY of fft_mag_axis_register_slice_2_0_axis_register_slice_v1_1_9_axis_register_slice : entity is 1;
  attribute G_MASK_SS_TSTRB : integer;
  attribute G_MASK_SS_TSTRB of fft_mag_axis_register_slice_2_0_axis_register_slice_v1_1_9_axis_register_slice : entity is 4;
  attribute G_MASK_SS_TUSER : integer;
  attribute G_MASK_SS_TUSER of fft_mag_axis_register_slice_2_0_axis_register_slice_v1_1_9_axis_register_slice : entity is 128;
  attribute G_TASK_SEVERITY_ERR : integer;
  attribute G_TASK_SEVERITY_ERR of fft_mag_axis_register_slice_2_0_axis_register_slice_v1_1_9_axis_register_slice : entity is 2;
  attribute G_TASK_SEVERITY_INFO : integer;
  attribute G_TASK_SEVERITY_INFO of fft_mag_axis_register_slice_2_0_axis_register_slice_v1_1_9_axis_register_slice : entity is 0;
  attribute G_TASK_SEVERITY_WARNING : integer;
  attribute G_TASK_SEVERITY_WARNING of fft_mag_axis_register_slice_2_0_axis_register_slice_v1_1_9_axis_register_slice : entity is 1;
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of fft_mag_axis_register_slice_2_0_axis_register_slice_v1_1_9_axis_register_slice : entity is "axis_register_slice_v1_1_9_axis_register_slice";
  attribute P_TPAYLOAD_WIDTH : integer;
  attribute P_TPAYLOAD_WIDTH of fft_mag_axis_register_slice_2_0_axis_register_slice_v1_1_9_axis_register_slice : entity is 27;
end fft_mag_axis_register_slice_2_0_axis_register_slice_v1_1_9_axis_register_slice;

architecture STRUCTURE of fft_mag_axis_register_slice_2_0_axis_register_slice_v1_1_9_axis_register_slice is
  signal \<const0>\ : STD_LOGIC;
  signal \<const1>\ : STD_LOGIC;
begin
  m_axis_tdest(0) <= \<const0>\;
  m_axis_tid(0) <= \<const0>\;
  m_axis_tkeep(1) <= \<const1>\;
  m_axis_tkeep(0) <= \<const1>\;
  m_axis_tstrb(1) <= \<const0>\;
  m_axis_tstrb(0) <= \<const0>\;
  s_axis_tready <= \<const1>\;
GND: unisim.vcomponents.GND
     port map (
      G => \<const0>\
    );
VCC: unisim.vcomponents.VCC
     port map (
      P => \<const1>\
    );
axisc_register_slice_0: entity work.fft_mag_axis_register_slice_2_0_axis_register_slice_v1_1_9_axisc_register_slice
     port map (
      D(26 downto 17) => s_axis_tuser(9 downto 0),
      D(16) => s_axis_tlast,
      D(15 downto 0) => s_axis_tdata(15 downto 0),
      Q(26 downto 17) => m_axis_tuser(9 downto 0),
      Q(16) => m_axis_tlast,
      Q(15 downto 0) => m_axis_tdata(15 downto 0),
      aclk => aclk,
      aclken => aclken,
      m_axis_tvalid => m_axis_tvalid,
      s_axis_tvalid => s_axis_tvalid
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity fft_mag_axis_register_slice_2_0 is
  port (
    aclk : in STD_LOGIC;
    aresetn : in STD_LOGIC;
    s_axis_tvalid : in STD_LOGIC;
    s_axis_tdata : in STD_LOGIC_VECTOR ( 15 downto 0 );
    s_axis_tlast : in STD_LOGIC;
    s_axis_tuser : in STD_LOGIC_VECTOR ( 9 downto 0 );
    m_axis_tvalid : out STD_LOGIC;
    m_axis_tdata : out STD_LOGIC_VECTOR ( 15 downto 0 );
    m_axis_tlast : out STD_LOGIC;
    m_axis_tuser : out STD_LOGIC_VECTOR ( 9 downto 0 )
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of fft_mag_axis_register_slice_2_0 : entity is true;
  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of fft_mag_axis_register_slice_2_0 : entity is "fft_mag_axis_register_slice_2_0,axis_register_slice_v1_1_9_axis_register_slice,{}";
  attribute DowngradeIPIdentifiedWarnings : string;
  attribute DowngradeIPIdentifiedWarnings of fft_mag_axis_register_slice_2_0 : entity is "yes";
  attribute X_CORE_INFO : string;
  attribute X_CORE_INFO of fft_mag_axis_register_slice_2_0 : entity is "axis_register_slice_v1_1_9_axis_register_slice,Vivado 2016.2";
end fft_mag_axis_register_slice_2_0;

architecture STRUCTURE of fft_mag_axis_register_slice_2_0 is
  signal NLW_inst_s_axis_tready_UNCONNECTED : STD_LOGIC;
  signal NLW_inst_m_axis_tdest_UNCONNECTED : STD_LOGIC_VECTOR ( 0 to 0 );
  signal NLW_inst_m_axis_tid_UNCONNECTED : STD_LOGIC_VECTOR ( 0 to 0 );
  signal NLW_inst_m_axis_tkeep_UNCONNECTED : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal NLW_inst_m_axis_tstrb_UNCONNECTED : STD_LOGIC_VECTOR ( 1 downto 0 );
  attribute C_AXIS_SIGNAL_SET : string;
  attribute C_AXIS_SIGNAL_SET of inst : label is "32'b00000000000000000000000010010010";
  attribute C_AXIS_TDATA_WIDTH : integer;
  attribute C_AXIS_TDATA_WIDTH of inst : label is 16;
  attribute C_AXIS_TDEST_WIDTH : integer;
  attribute C_AXIS_TDEST_WIDTH of inst : label is 1;
  attribute C_AXIS_TID_WIDTH : integer;
  attribute C_AXIS_TID_WIDTH of inst : label is 1;
  attribute C_AXIS_TUSER_WIDTH : integer;
  attribute C_AXIS_TUSER_WIDTH of inst : label is 10;
  attribute C_FAMILY : string;
  attribute C_FAMILY of inst : label is "artix7";
  attribute C_REG_CONFIG : integer;
  attribute C_REG_CONFIG of inst : label is 1;
  attribute DowngradeIPIdentifiedWarnings of inst : label is "yes";
  attribute G_INDX_SS_TDATA : integer;
  attribute G_INDX_SS_TDATA of inst : label is 1;
  attribute G_INDX_SS_TDEST : integer;
  attribute G_INDX_SS_TDEST of inst : label is 6;
  attribute G_INDX_SS_TID : integer;
  attribute G_INDX_SS_TID of inst : label is 5;
  attribute G_INDX_SS_TKEEP : integer;
  attribute G_INDX_SS_TKEEP of inst : label is 3;
  attribute G_INDX_SS_TLAST : integer;
  attribute G_INDX_SS_TLAST of inst : label is 4;
  attribute G_INDX_SS_TREADY : integer;
  attribute G_INDX_SS_TREADY of inst : label is 0;
  attribute G_INDX_SS_TSTRB : integer;
  attribute G_INDX_SS_TSTRB of inst : label is 2;
  attribute G_INDX_SS_TUSER : integer;
  attribute G_INDX_SS_TUSER of inst : label is 7;
  attribute G_MASK_SS_TDATA : integer;
  attribute G_MASK_SS_TDATA of inst : label is 2;
  attribute G_MASK_SS_TDEST : integer;
  attribute G_MASK_SS_TDEST of inst : label is 64;
  attribute G_MASK_SS_TID : integer;
  attribute G_MASK_SS_TID of inst : label is 32;
  attribute G_MASK_SS_TKEEP : integer;
  attribute G_MASK_SS_TKEEP of inst : label is 8;
  attribute G_MASK_SS_TLAST : integer;
  attribute G_MASK_SS_TLAST of inst : label is 16;
  attribute G_MASK_SS_TREADY : integer;
  attribute G_MASK_SS_TREADY of inst : label is 1;
  attribute G_MASK_SS_TSTRB : integer;
  attribute G_MASK_SS_TSTRB of inst : label is 4;
  attribute G_MASK_SS_TUSER : integer;
  attribute G_MASK_SS_TUSER of inst : label is 128;
  attribute G_TASK_SEVERITY_ERR : integer;
  attribute G_TASK_SEVERITY_ERR of inst : label is 2;
  attribute G_TASK_SEVERITY_INFO : integer;
  attribute G_TASK_SEVERITY_INFO of inst : label is 0;
  attribute G_TASK_SEVERITY_WARNING : integer;
  attribute G_TASK_SEVERITY_WARNING of inst : label is 1;
  attribute P_TPAYLOAD_WIDTH : integer;
  attribute P_TPAYLOAD_WIDTH of inst : label is 27;
begin
inst: entity work.fft_mag_axis_register_slice_2_0_axis_register_slice_v1_1_9_axis_register_slice
     port map (
      aclk => aclk,
      aclken => '1',
      aresetn => aresetn,
      m_axis_tdata(15 downto 0) => m_axis_tdata(15 downto 0),
      m_axis_tdest(0) => NLW_inst_m_axis_tdest_UNCONNECTED(0),
      m_axis_tid(0) => NLW_inst_m_axis_tid_UNCONNECTED(0),
      m_axis_tkeep(1 downto 0) => NLW_inst_m_axis_tkeep_UNCONNECTED(1 downto 0),
      m_axis_tlast => m_axis_tlast,
      m_axis_tready => '1',
      m_axis_tstrb(1 downto 0) => NLW_inst_m_axis_tstrb_UNCONNECTED(1 downto 0),
      m_axis_tuser(9 downto 0) => m_axis_tuser(9 downto 0),
      m_axis_tvalid => m_axis_tvalid,
      s_axis_tdata(15 downto 0) => s_axis_tdata(15 downto 0),
      s_axis_tdest(0) => '0',
      s_axis_tid(0) => '0',
      s_axis_tkeep(1 downto 0) => B"11",
      s_axis_tlast => s_axis_tlast,
      s_axis_tready => NLW_inst_s_axis_tready_UNCONNECTED,
      s_axis_tstrb(1 downto 0) => B"11",
      s_axis_tuser(9 downto 0) => s_axis_tuser(9 downto 0),
      s_axis_tvalid => s_axis_tvalid
    );
end STRUCTURE;
