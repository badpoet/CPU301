----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:10:37 12/03/2014 
-- Design Name: 
-- Module Name:    ALU - Behavioral 
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

entity ALU is
    Port ( srcA : in  STD_LOGIC_VECTOR (15 downto 0);
           srcB : in  STD_LOGIC_VECTOR (15 downto 0);
           op : in  STD_LOGIC_VECTOR (3 downto 0);
           result : out  STD_LOGIC_VECTOR (15 downto 0));
end ALU;

architecture RTL of ALU is

begin

	process (op, srcB) begin
		case op is
			when "0000"=>
				result <= srcA + srcB;
			when "0001"=>
				result <= srcA and srcB;
			when "0010"=>
				result <= srcA /= srcB;
			when "0011"=>
				result <= srcA - srcB;
			when "0100"=>
				result <= not srcA;
			when "0101"=>
				result <= srcA or srcB;
			when "0110"=>
				if (srcB = "0000000000000000") then
					result <= to_stdlogicvector(to_bitvector(srcA) sll 8);
				else
					result <= to_stdlogicvector(to_bitvector(srcA) sll conv_integer(srcB));
				end if;
			when "0111"=>
				result <= to_stdlogicvector(to_bitvector(srcA) sll conv_integer(srcB));
			when "1000"=>
				if (srcB = "0000000000000000") then
					result <= to_stdlogicvector(to_bitvector(srcA) sra 8);
				else
					result <= to_stdlogicvector(to_bitvector(srcA) sra conv_integer(srcB));
				end if;
			when "1001"=>
				result <= to_stdlogicvector(to_bitvector(srcA) sra conv_integer(srcB));
			when others=>
				result <= (others => '0');
		end case;
	end process;

end RTL;

