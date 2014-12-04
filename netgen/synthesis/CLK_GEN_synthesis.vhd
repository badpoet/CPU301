--------------------------------------------------------------------------------
-- Copyright (c) 1995-2013 Xilinx, Inc.  All rights reserved.
--------------------------------------------------------------------------------
--   ____  ____
--  /   /\/   /
-- /___/  \  /    Vendor: Xilinx
-- \   \   \/     Version: P.20131013
--  \   \         Application: netgen
--  /   /         Filename: CLK_GEN_synthesis.vhd
-- /___/   /\     Timestamp: Thu Dec 04 17:53:22 2014
-- \   \  /  \ 
--  \___\/\___\
--             
-- Command	: -intstyle ise -ar Structure -tm CLK_GEN -w -dir netgen/synthesis -ofmt vhdl -sim CLK_GEN.ngc CLK_GEN_synthesis.vhd 
-- Device	: xc3s1200e-4-fg320
-- Input file	: CLK_GEN.ngc
-- Output file	: C:\COA\cpu301\netgen\synthesis\CLK_GEN_synthesis.vhd
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
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
use UNISIM.VPKG.ALL;

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
  signal Clk_s_2 : STD_LOGIC; 
  signal Clk_s_not0001 : STD_LOGIC; 
  signal Clk_x2_s_5 : STD_LOGIC; 
  signal Clk_x2_s_not0001 : STD_LOGIC; 
  signal Clk_x4_OBUF_8 : STD_LOGIC; 
  signal Clk_x4_OBUF1 : STD_LOGIC; 
  signal Cnt_inv : STD_LOGIC; 
  signal Rst_IBUF_13 : STD_LOGIC; 
  signal Rst_inv : STD_LOGIC; 
  signal Cnt : STD_LOGIC_VECTOR ( 0 downto 0 ); 
begin
  Clk_x2_s : FDC
    port map (
      C => Clk_x4_OBUF_8,
      CLR => Rst_inv,
      D => Clk_x2_s_not0001,
      Q => Clk_x2_s_5
    );
  Cnt_0 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => Clk_x4_OBUF_8,
      CE => Rst_IBUF_13,
      D => Cnt_inv,
      Q => Cnt(0)
    );
  Clk_s : FDCE
    port map (
      C => Clk_x4_OBUF_8,
      CE => Cnt_inv,
      CLR => Rst_inv,
      D => Clk_s_not0001,
      Q => Clk_s_2
    );
  Clk_base_IBUF : IBUF
    port map (
      I => Clk_base,
      O => Clk_x4_OBUF1
    );
  Rst_IBUF : IBUF
    port map (
      I => Rst,
      O => Rst_IBUF_13
    );
  Clk_OBUF : OBUF
    port map (
      I => Clk_s_2,
      O => Clk
    );
  Clk_x2_OBUF : OBUF
    port map (
      I => Clk_x2_s_5,
      O => Clk_x2
    );
  Clk_x4_OBUF : OBUF
    port map (
      I => Clk_x4_OBUF1,
      O => Clk_x4
    );
  Clk_x4_OBUF_BUFG : BUFG
    port map (
      I => Clk_x4_OBUF1,
      O => Clk_x4_OBUF_8
    );
  Rst_inv1_INV_0 : INV
    port map (
      I => Rst_IBUF_13,
      O => Rst_inv
    );
  Clk_x2_s_not00011_INV_0 : INV
    port map (
      I => Clk_x2_s_5,
      O => Clk_x2_s_not0001
    );
  Clk_s_not00011_INV_0 : INV
    port map (
      I => Clk_s_2,
      O => Clk_s_not0001
    );
  Cnt_inv1_INV_0 : INV
    port map (
      I => Cnt(0),
      O => Cnt_inv
    );

end Structure;

