----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:29:57 12/01/2014 
-- Design Name: 
-- Module Name:    PC_branch_calc - Behavioral 
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

entity BRANCH_CALC is
    Port ( PC : in  STD_LOGIC_VECTOR (15 downto 0);
           Immediate : in  STD_LOGIC_VECTOR (15 downto 0);
           Rx_data : in  STD_LOGIC_VECTOR (15 downto 0);
		   T_data : in  STD_LOGIC_VECTOR (15 downto 0);
		   Condition_jump : in  STD_LOGIC_VECTOR(2 downto 0);
           Branch_PC : out  STD_LOGIC_VECTOR (15 downto 0);
		   PC_src : out  STD_LOGIC);
end BRANCH_CALC;

architecture RTL of BRANCH_CALC is
begin
	
	process (Condition_jump, Rx_data, PC, Immediate) begin
		case Condition_jump is
			when "001" =>
				Branch_PC <= STD_LOGIC_VECTOR(UNSIGNED(PC) + UNSIGNED(Immediate));
				PC_src <= '1';
			when "010" =>
				Branch_PC <= STD_LOGIC_VECTOR(UNSIGNED(PC) + UNSIGNED(Immediate));
				if Rx_data = (Rx_data'range => '0') then
					PC_src <= '1';
				else
					PC_src <= '0';
				end if;
			when "011" =>
				Branch_PC <= STD_LOGIC_VECTOR(UNSIGNED(PC) + UNSIGNED(Immediate));
				if Rx_data = (Rx_data'range => '0') then
					PC_src <= '0';
				else
					PC_src <= '1';
				end if;
			when "100" =>
				Branch_PC <= Rx_data; 
				PC_src <= '1';
			when others =>
				Branch_PC <= PC;
				PC_src <= '0';
		end case;
	end process;

end RTL;

