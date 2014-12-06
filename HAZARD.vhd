----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    02:48:52 12/05/2014 
-- Design Name: 
-- Module Name:    HAZARD - Behavioral 
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

entity HAZARD is
    Port ( MEM_op : in  STD_LOGIC_VECTOR (1 downto 0);
           REG_des : in  STD_LOGIC_VECTOR (3 downto 0);
           ALU_src_a : in  STD_LOGIC_VECTOR (3 downto 0);
           REG_src_b : in  STD_LOGIC_VECTOR (3 downto 0);
		   Bubble_in_branch : in  STD_LOGIC;
           bubble : out  STD_LOGIC);
end HAZARD;

architecture RTL of HAZARD is

begin

	bubble <= '1' when (MEM_op = "10" and (REG_des = ALU_src_a or REG_des = REG_src_b)) or Bubble_in_branch = '1'
		  else '0';

end RTL;