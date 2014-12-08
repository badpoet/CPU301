----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:02:54 11/30/2014 
-- Design Name: 
-- Module Name:    CLK_CREATOR - RTL 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity CLK_GEN is
    Port ( Clk_base : in  STD_LOGIC;
		   Rst : in  STD_LOGIC;
           Clk : out  STD_LOGIC;
           Clk_x2 : out  STD_LOGIC;
           Clk_x4 : out  STD_LOGIC);
end CLK_GEN;

architecture RTL of CLK_GEN is
	signal Cnt : INTEGER RANGE 0 TO 1 := 0;
	signal Clk_x2_s : STD_LOGIC;
	signal Clk_s : STD_LOGIC;
begin
	process (Rst, Clk_base, Cnt) begin
		if (Rst = '0') then
			Clk_x2_s <= '0';
			Clk_s <= '0';
			Cnt <= 0;
		elsif (Clk_base'event and Clk_base = '1') then
			if (Cnt = 1) then
				Clk_x2_s <= NOT(Clk_x2_s);
				Cnt <= 0;
			else
				Clk_s <= NOT(Clk_s);
				Clk_x2_s <= NOT(Clk_x2_s);
				Cnt <= Cnt + 1;
			end if;
		end if;
	end process;
	Clk_x4 <= Clk_base;
	Clk_x2 <= clk_base;--Clk_x2_s;
	Clk <= clk_x2_s;--Clk_s;
end RTL;

