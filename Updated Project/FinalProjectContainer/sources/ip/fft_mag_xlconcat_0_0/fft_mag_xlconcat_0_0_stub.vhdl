-- Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2016.2 (win64) Build 1577090 Thu Jun  2 16:32:40 MDT 2016
-- Date        : Thu Dec 07 01:48:57 2017
-- Host        : THINKPAD running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub {C:/Users/Aaron
--               Wubshet/Desktop/FinalProjectContainer/sources/ip/fft_mag_xlconcat_0_0/fft_mag_xlconcat_0_0_stub.vhdl}
-- Design      : fft_mag_xlconcat_0_0
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7a100tcsg324-3
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity fft_mag_xlconcat_0_0 is
  Port ( 
    In0 : in STD_LOGIC_VECTOR ( 2 downto 0 );
    In1 : in STD_LOGIC_VECTOR ( 11 downto 0 );
    In2 : in STD_LOGIC_VECTOR ( 0 to 0 );
    dout : out STD_LOGIC_VECTOR ( 15 downto 0 )
  );

end fft_mag_xlconcat_0_0;

architecture stub of fft_mag_xlconcat_0_0 is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "In0[2:0],In1[11:0],In2[0:0],dout[15:0]";
attribute X_CORE_INFO : string;
attribute X_CORE_INFO of stub : architecture is "xlconcat,Vivado 2016.2";
begin
end;
