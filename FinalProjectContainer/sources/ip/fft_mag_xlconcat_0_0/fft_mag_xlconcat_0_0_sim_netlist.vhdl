-- Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2016.2 (win64) Build 1577090 Thu Jun  2 16:32:40 MDT 2016
-- Date        : Thu Dec 07 01:48:57 2017
-- Host        : THINKPAD running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode funcsim {C:/Users/Aaron
--               Wubshet/Desktop/FinalProjectContainer/sources/ip/fft_mag_xlconcat_0_0/fft_mag_xlconcat_0_0_sim_netlist.vhdl}
-- Design      : fft_mag_xlconcat_0_0
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7a100tcsg324-3
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity fft_mag_xlconcat_0_0 is
  port (
    In0 : in STD_LOGIC_VECTOR ( 2 downto 0 );
    In1 : in STD_LOGIC_VECTOR ( 11 downto 0 );
    In2 : in STD_LOGIC_VECTOR ( 0 to 0 );
    dout : out STD_LOGIC_VECTOR ( 15 downto 0 )
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of fft_mag_xlconcat_0_0 : entity is true;
  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of fft_mag_xlconcat_0_0 : entity is "fft_mag_xlconcat_0_0,xlconcat,{}";
  attribute DowngradeIPIdentifiedWarnings : string;
  attribute DowngradeIPIdentifiedWarnings of fft_mag_xlconcat_0_0 : entity is "yes";
  attribute X_CORE_INFO : string;
  attribute X_CORE_INFO of fft_mag_xlconcat_0_0 : entity is "xlconcat,Vivado 2016.2";
end fft_mag_xlconcat_0_0;

architecture STRUCTURE of fft_mag_xlconcat_0_0 is
  signal \^in0\ : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal \^in1\ : STD_LOGIC_VECTOR ( 11 downto 0 );
  signal \^in2\ : STD_LOGIC_VECTOR ( 0 to 0 );
begin
  \^in0\(2 downto 0) <= In0(2 downto 0);
  \^in1\(11 downto 0) <= In1(11 downto 0);
  \^in2\(0) <= In2(0);
  dout(15) <= \^in2\(0);
  dout(14 downto 3) <= \^in1\(11 downto 0);
  dout(2 downto 0) <= \^in0\(2 downto 0);
end STRUCTURE;
