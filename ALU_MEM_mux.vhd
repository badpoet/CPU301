----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    04:21:47 12/04/2014 
-- Design Name: 
-- Module Name:    ALU_MEM_mux - Behavioral 
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

entity ALU_MEM_mux is
    Port ( ALU_out : in  STD_LOGIC_VECTOR (15 downto 0);
           MEM_out : in  STD_LOGIC_VECTOR (15 downto 0);
           REG_src : in  STD_LOGIC;
           data : out  STD_LOGIC_VECTOR (15 downto 0));
end ALU_MEM_mux;

architecture RTL of ALU_MEM_mux is

begin

	data <= ALU_out when REG_src = '0'
		else MEM_out when REG_src = '1';

end RTL;