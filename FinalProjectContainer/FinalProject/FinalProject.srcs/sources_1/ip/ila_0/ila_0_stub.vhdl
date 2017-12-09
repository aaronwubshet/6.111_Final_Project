-- Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2016.2 (win64) Build 1577090 Thu Jun  2 16:32:40 MDT 2016
-- Date        : Sat Dec 09 02:56:30 2017
-- Host        : THINKPAD running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub {c:/Users/Aaron
--               Wubshet/Desktop/FinalProjectContainer/FinalProject/FinalProject.srcs/sources_1/ip/ila_0/ila_0_stub.vhdl}
-- Design      : ila_0
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7a100tcsg324-3
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ila_0 is
  Port ( 
    clk : in STD_LOGIC;
    probe0 : in STD_LOGIC_VECTOR ( 18 downto 0 );
    probe1 : in STD_LOGIC_VECTOR ( 18 downto 0 );
    probe2 : in STD_LOGIC_VECTOR ( 2 downto 0 );
    probe3 : in STD_LOGIC_VECTOR ( 2 downto 0 );
    probe4 : in STD_LOGIC_VECTOR ( 11 downto 0 );
    probe5 : in STD_LOGIC_VECTOR ( 11 downto 0 );
    probe6 : in STD_LOGIC_VECTOR ( 2 downto 0 );
    probe7 : in STD_LOGIC_VECTOR ( 0 to 0 )
  );

end ila_0;

architecture stub of ila_0 is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "clk,probe0[18:0],probe1[18:0],probe2[2:0],probe3[2:0],probe4[11:0],probe5[11:0],probe6[2:0],probe7[0:0]";
attribute X_CORE_INFO : string;
attribute X_CORE_INFO of stub : architecture is "ila,Vivado 2016.2";
begin
end;