----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:09:12 11/29/2014 
-- Design Name: 
-- Module Name:    pcreg - Behavioral 
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

entity PC_REG is
    Port ( Clk : in  STD_LOGIC;
		   Rst : in  STD_LOGIC;
           Pc_d : in  STD_LOGIC_VECTOR (15 downto 0);
           Pc_q : out  STD_LOGIC_VECTOR (15 downto 0));
end PC_REG;

architecture RTL of PC_REG is
	signal Pc : STD_LOGIC_VECTOR (15 downto 0);
begin
	process (Clk, Rst, Pc) begin
		if (Rst = '0') then
			Pc <= (others => '0');
		elsif (Clk'event and Clk = '1') then
			Pc <= Pc_d;
		end if;
		Pc_q <= Pc;
	end process;
end RTL;

