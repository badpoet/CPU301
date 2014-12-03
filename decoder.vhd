----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:51:38 12/02/2014 
-- Design Name: 
-- Module Name:    DECODER - RTL 
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

entity DECODER is
    Port ( Inst : in  STD_LOGIC_VECTOR (16 downto 0);
           PC_branch : out  STD_LOGIC_VECTOR (1 downto 0);
		   PC_src : out  STD_LOGIC_VECTOR;
           Rx : out  STD_LOGIC_VECTOR (1 downto 0);
           Ry : out  STD_LOGIC_VECTOR (1 downto 0);
           Rz : out  STD_LOGIC_VECTOR (1 downto 0);
           Imm : out  STD_LOGIC_VECTOR (15 downto 0);
           Mem_op : out  STD_LOGIC_VECTOR (1 downto 0);
           REG_write : out  STD_LOGIC;
           REG_des : out  STD_LOGIC_VECTOR (2 downto 0);
           ALU_src_a : out  STD_LOGIC_VECTOR (1 downto 0);
           ALU_src_b : out  STD_LOGIC_VECTOR (2 downto 0);
           ALU_op : out  STD_LOGIC_VECTOR (3 downto 0));
end DECODER;

architecture RTL of DECODER is

begin
	process (Inst) begin
		
		-- PC_branch
		case (Inst(15 downto 11)) is
			when "00010" | "11101" => PC_branch <= "01";
			when "00100" | "01100" => PC_branch <= "10";
			when "00101" => PC_branch <= "11";
			when others => PC_branch <= "00";
		end case;
		
		-- PC_src
		case (Inst(15 downto 11)) is
			when "11101" => PC_src <= '1';
			when others => PC_src <= '0';
		end case;
		
		-- Mem_op
		case (Inst(15 downto 11)) is
			when "10010" | "10011" => Mem_op <= "10";
			when "11011" | "11010" => Mem_op <= "01";
			when others => Mem_op <= "00";
		end case;
		
		-- REG_src
		case (Inst(15 downto 11)) is
			when "10011" | "10010" => REG_write <= '1';
			when others => '0';
		end case;
		
		-- REG_des
		case (Inst(15 downto 11)) is
			when "01001" | "01101" | "11110" | "11101" | 
				"00110" | "10010" => REG_ds

end RTL;

