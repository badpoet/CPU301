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
    Port ( Clk_in : in  STD_LOGIC;
           Clk : out  STD_LOGIC;
           Clk_x2 : out  STD_LOGIC;
           Clk_x4 : out  STD_LOGIC);
end CLK_GEN;

architecture RTL of CLK_GEN is
	variable Cnt : STD_LOGIC;
	signal Clk_x2_s : STD_LOGIC;
	signal Clk_x4_s : STD_LOGIC;
begin
	Cnt := 0;
	process begin
		if (Clk_in'event and Clk_in = '1') then
			Cnt := Cnt + 1;
			if (Cnt = 2 or Cnt = 4) then
				Clk_x2_s <= !Clk_x2_s;
			end if;
			if (Cnt = 4) then
				Clk_x4_s <= !Clk_x4_s;
				Cnt := 0;
			end if;
		end if;
		Clk_x2 <= Clk_x2_s;
		Clk_x4 <= Clk_x4_s;
	end process;
end RTL;

