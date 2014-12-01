----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:29:57 12/01/2014 
-- Design Name: 
-- Module Name:    Pc_branch_calc - Behavioral 
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

entity Pc_branch_calc is
    Port ( Pc : in  STD_LOGIC_VECTOR (15 downto 0);
           Immediate : in  STD_LOGIC_VECTOR (15 downto 0);
           Reg : in  STD_LOGIC_VECTOR (15 downto 0);
			  Condition_jump : in  STD_LOGIC_VECTOR(1 downto 0);
           Branch_pc : out  STD_LOGIC_VECTOR (15 downto 0);
           Equal_zero : in  STD_LOGIC);
end Pc_branch_calc;

architecture RTL of Pc_branch_calc is
begin
	
	process (Condition_jump, Equal_zero) begin
		case Condition_jump is
			when "00" =>
				Branch_pc <= Reg;--0
			when "01" =>
				Branch_pc <= STD_LOGIC_VECTOR(UNSIGNED(pc) + UNSIGNED(Immediate));
			when "10" =>
				if (Equal_zero = '1') then
					Branch_pc <= STD_LOGIC_VECTOR(UNSIGNED(pc) + UNSIGNED(Immediate));
				else
					Branch_pc <= STD_LOGIC_VECTOR(UNSIGNED(pc) + 4);
				end if;
			when "11" =>
				if (Equal_zero = '0') then
					Branch_pc <= STD_LOGIC_VECTOR(UNSIGNED(pc) + UNSIGNED(Immediate));
				else
					Branch_pc <= STD_LOGIC_VECTOR(UNSIGNED(pc) + 4);
				end if;
			when others =>
		end case;
	end process;

end RTL;

