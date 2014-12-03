----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    00:29:20 12/01/2014 
-- Design Name: 
-- Module Name:    PC_MUX - RTL 
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

entity PC_MUX is
    Port ( PC_next : in  STD_LOGIC_VECTOR (15 downto 0);
		   Branch_PC : in  STD_LOGIC_VECTOR (15 downto 0);
		   PC_src : in  STD_LOGIC;
           NPC : out  STD_LOGIC_VECTOR (15 downto 0));
end PC_MUX;

architecture RTL of PC_MUX is

begin
	
	process (Branch_PC, PC_next, PC_src) begin
		if PC_src = '0' then 
			NPC <= PC_next;
		else
			NPC <= Branch_PC;
		end if;
	end process;

end RTL;

