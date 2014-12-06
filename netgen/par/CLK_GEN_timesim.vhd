--------------------------------------------------------------------------------
-- Copyright (c) 1995-2013 Xilinx, Inc.  All rights reserved.
--------------------------------------------------------------------------------
--   ____  ____
--  /   /\/   /
-- /___/  \  /    Vendor: Xilinx
-- \   \   \/     Version: P.20131013
--  \   \         Application: netgen
--  /   /         Filename: CLK_GEN_timesim.vhd
-- /___/   /\     Timestamp: Sat Dec 06 01:11:51 2014
-- \   \  /  \ 
--  \___\/\___\
--             
-- Command	: -intstyle ise -s 4 -pcf CLK_GEN.pcf -rpw 100 -tpw 0 -ar Structure -tm CLK_GEN -insert_pp_buffers true -w -dir netgen/par -ofmt vhdl -sim CLK_GEN.ncd CLK_GEN_timesim.vhd 
-- Device	: 3s1200efg320-4 (PRODUCTION 1.27 2013-10-13)
-- Input file	: CLK_GEN.ncd
-- Output file	: C:\COA\cpu301\netgen\par\CLK_GEN_timesim.vhd
-- # of Entities	: 1
-- Design Name	: CLK_GEN
-- Xilinx	: C:\Xilinx\14.7\ISE_DS\ISE\
--             
-- Purpose:    
--     This VHDL netlist is a verification model and uses simulation 
--     primitives which may not represent the true implementation of the 
--     device, however the netlist is functionally correct and should not 
--     be modified. This file cannot be synthesized and should only be used 
--     with supported simulation tools.
--             
-- Reference:  
--     Command Line Tools User Guide, Chapter 23
--     Synthesis and Simulation Design Guide, Chapter 6
--             
--------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library SIMPRIM;
use SIMPRIM.VCOMPONENTS.ALL;
use SIMPRIM.VPACKAGE.ALL;

entity CLK_GEN is
  port (
    Clk : out STD_LOGIC; 
    Rst : in STD_LOGIC := 'X'; 
    Clk_x2 : out STD_LOGIC; 
    Clk_x4 : out STD_LOGIC; 
    Clk_base : in STD_LOGIC := 'X' 
  );
end CLK_GEN;

architecture Structure of CLK_GEN is
  signal Clk_x4_OBUF1 : STD_LOGIC; 
  signal Clk_x2_s_33 : STD_LOGIC; 
  signal Rst_IBUF_34 : STD_LOGIC; 
  signal Clk_s_35 : STD_LOGIC; 
  signal Clk_x4_OBUF_37 : STD_LOGIC; 
  signal Clk_base_INBUF : STD_LOGIC; 
  signal Clk_x2_O : STD_LOGIC; 
  signal Clk_x4_O : STD_LOGIC; 
  signal Rst_INBUF : STD_LOGIC; 
  signal Clk_O : STD_LOGIC; 
  signal Clk_x4_OBUF_BUFG_S_INVNOT : STD_LOGIC; 
  signal Clk_x4_OBUF_BUFG_I0_INV : STD_LOGIC; 
  signal Cnt_0_DYMUX_87 : STD_LOGIC; 
  signal Cnt_0_CLKINV_85 : STD_LOGIC; 
  signal Cnt_0_CEINV_84 : STD_LOGIC; 
  signal Clk_s_DYMUX_101 : STD_LOGIC; 
  signal Clk_s_CLKINV_98 : STD_LOGIC; 
  signal Clk_s_CEINVNOT : STD_LOGIC; 
  signal Clk_x2_s_DYMUX_116 : STD_LOGIC; 
  signal Clk_x2_s_CLKINV_113 : STD_LOGIC; 
  signal Clk_x2_s_FFY_RSTAND_121 : STD_LOGIC; 
  signal Clk_s_FFY_RSTAND_107 : STD_LOGIC; 
  signal GND : STD_LOGIC; 
  signal VCC : STD_LOGIC; 
  signal Cnt : STD_LOGIC_VECTOR ( 0 downto 0 ); 
begin
  Clk_base_IBUF : X_BUF
    generic map(
      LOC => "IPAD38",
      PATHPULSE => 798 ps
    )
    port map (
      I => Clk_base,
      O => Clk_base_INBUF
    );
  Clk_x2_OBUF : X_OBUF
    generic map(
      LOC => "PAD71"
    )
    port map (
      I => Clk_x2_O,
      O => Clk_x2
    );
  Clk_x4_OBUF : X_OBUF
    generic map(
      LOC => "PAD42"
    )
    port map (
      I => Clk_x4_O,
      O => Clk_x4
    );
  Rst_IBUF : X_BUF
    generic map(
      LOC => "PAD76",
      PATHPULSE => 798 ps
    )
    port map (
      I => Rst,
      O => Rst_INBUF
    );
  Rst_IFF_IMUX : X_BUF
    generic map(
      LOC => "PAD76",
      PATHPULSE => 798 ps
    )
    port map (
      I => Rst_INBUF,
      O => Rst_IBUF_34
    );
  Clk_OBUF : X_OBUF
    generic map(
      LOC => "PAD63"
    )
    port map (
      I => Clk_O,
      O => Clk
    );
  Clk_x4_OBUF_BUFG : X_BUFGMUX
    generic map(
      LOC => "BUFGMUX_X2Y10"
    )
    port map (
      I0 => Clk_x4_OBUF_BUFG_I0_INV,
      I1 => GND,
      S => Clk_x4_OBUF_BUFG_S_INVNOT,
      O => Clk_x4_OBUF_37
    );
  Clk_x4_OBUF_BUFG_SINV : X_INV
    generic map(
      LOC => "BUFGMUX_X2Y10",
      PATHPULSE => 798 ps
    )
    port map (
      I => '1',
      O => Clk_x4_OBUF_BUFG_S_INVNOT
    );
  Clk_x4_OBUF_BUFG_I0_USED : X_BUF
    generic map(
      LOC => "BUFGMUX_X2Y10",
      PATHPULSE => 798 ps
    )
    port map (
      I => Clk_x4_OBUF1,
      O => Clk_x4_OBUF_BUFG_I0_INV
    );
  Cnt_0_DYMUX : X_INV
    generic map(
      LOC => "SLICE_X75Y119",
      PATHPULSE => 798 ps
    )
    port map (
      I => Cnt(0),
      O => Cnt_0_DYMUX_87
    );
  Cnt_0_CLKINV : X_BUF
    generic map(
      LOC => "SLICE_X75Y119",
      PATHPULSE => 798 ps
    )
    port map (
      I => Clk_x4_OBUF_37,
      O => Cnt_0_CLKINV_85
    );
  Cnt_0_CEINV : X_BUF
    generic map(
      LOC => "SLICE_X75Y119",
      PATHPULSE => 798 ps
    )
    port map (
      I => Rst_IBUF_34,
      O => Cnt_0_CEINV_84
    );
  Clk_s_DYMUX : X_INV
    generic map(
      LOC => "SLICE_X74Y118",
      PATHPULSE => 798 ps
    )
    port map (
      I => Clk_s_35,
      O => Clk_s_DYMUX_101
    );
  Clk_s_CLKINV : X_BUF
    generic map(
      LOC => "SLICE_X74Y118",
      PATHPULSE => 798 ps
    )
    port map (
      I => Clk_x4_OBUF_37,
      O => Clk_s_CLKINV_98
    );
  Clk_s_CEINV : X_INV
    generic map(
      LOC => "SLICE_X74Y118",
      PATHPULSE => 798 ps
    )
    port map (
      I => Cnt(0),
      O => Clk_s_CEINVNOT
    );
  Clk_x2_s_DYMUX : X_INV
    generic map(
      LOC => "SLICE_X82Y119",
      PATHPULSE => 798 ps
    )
    port map (
      I => Clk_x2_s_33,
      O => Clk_x2_s_DYMUX_116
    );
  Clk_x2_s_CLKINV : X_BUF
    generic map(
      LOC => "SLICE_X82Y119",
      PATHPULSE => 798 ps
    )
    port map (
      I => Clk_x4_OBUF_37,
      O => Clk_x2_s_CLKINV_113
    );
  Clk_base_IFF_IMUX : X_BUF
    generic map(
      LOC => "IPAD38",
      PATHPULSE => 798 ps
    )
    port map (
      I => Clk_base_INBUF,
      O => Clk_x4_OBUF1
    );
  Clk_x2_s : X_FF
    generic map(
      LOC => "SLICE_X82Y119",
      INIT => '0'
    )
    port map (
      I => Clk_x2_s_DYMUX_116,
      CE => VCC,
      CLK => Clk_x2_s_CLKINV_113,
      SET => GND,
      RST => Clk_x2_s_FFY_RSTAND_121,
      O => Clk_x2_s_33
    );
  Clk_x2_s_FFY_RSTAND : X_INV
    generic map(
      LOC => "SLICE_X82Y119",
      PATHPULSE => 798 ps
    )
    port map (
      I => Rst_IBUF_34,
      O => Clk_x2_s_FFY_RSTAND_121
    );
  Cnt_0 : X_FF
    generic map(
      LOC => "SLICE_X75Y119",
      INIT => '0'
    )
    port map (
      I => Cnt_0_DYMUX_87,
      CE => Cnt_0_CEINV_84,
      CLK => Cnt_0_CLKINV_85,
      SET => GND,
      RST => GND,
      O => Cnt(0)
    );
  Clk_s : X_FF
    generic map(
      LOC => "SLICE_X74Y118",
      INIT => '0'
    )
    port map (
      I => Clk_s_DYMUX_101,
      CE => Clk_s_CEINVNOT,
      CLK => Clk_s_CLKINV_98,
      SET => GND,
      RST => Clk_s_FFY_RSTAND_107,
      O => Clk_s_35
    );
  Clk_s_FFY_RSTAND : X_INV
    generic map(
      LOC => "SLICE_X74Y118",
      PATHPULSE => 798 ps
    )
    port map (
      I => Rst_IBUF_34,
      O => Clk_s_FFY_RSTAND_107
    );
  Clk_x2_OUTPUT_OFF_OMUX : X_BUF
    generic map(
      LOC => "PAD71",
      PATHPULSE => 798 ps
    )
    port map (
      I => Clk_x2_s_33,
      O => Clk_x2_O
    );
  Clk_x4_OUTPUT_OFF_OMUX : X_BUF
    generic map(
      LOC => "PAD42",
      PATHPULSE => 798 ps
    )
    port map (
      I => Clk_x4_OBUF1,
      O => Clk_x4_O
    );
  Clk_OUTPUT_OFF_OMUX : X_BUF
    generic map(
      LOC => "PAD63",
      PATHPULSE => 798 ps
    )
    port map (
      I => Clk_s_35,
      O => Clk_O
    );
  NlwBlock_CLK_GEN_GND : X_ZERO
    port map (
      O => GND
    );
  NlwBlock_CLK_GEN_VCC : X_ONE
    port map (
      O => VCC
    );
  NlwBlockROC : X_ROC
    generic map (ROC_WIDTH => 100 ns)
    port map (O => GSR);
  NlwBlockTOC : X_TOC
    port map (O => GTS);

end Structure;

