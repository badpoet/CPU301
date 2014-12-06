----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    02:22:39 12/01/2014 
-- Design Name: 
-- Module Name:    CLK_BASE - RTL 
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity CLK_BASE_GEN is
    Port ( Clk_in : in  STD_LOGIC;
           Rst : in  STD_LOGIC;
           Clk_base : out  STD_LOGIC);
end CLK_BASE_GEN;

architecture RTL of CLK_BASE_GEN is
	signal Tmp : STD_LOGIC;
	signal Cnt : INTEGER RANGE 0 TO 2147483647 := 0;
begin
	process (Clk_in, Rst, Cnt) begin
		if (Rst = '0') then
			Tmp <= '0';
		elsif (Clk_in'event and Clk_in = '1') then
			if (Cnt < 12500000) then
				Cnt <= Cnt + 1;
			else 
				Cnt <= 0;
				Tmp <= NOT(Tmp);
			end if;
		end if;
	end process;
	Clk_base <= Tmp;
end RTL;

