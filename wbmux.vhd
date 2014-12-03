----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    03:47:48 12/04/2014 
-- Design Name: 
-- Module Name:    WB_MUX - RTL 
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

entity WB_MUX is
    Port ( ALU_out : in  STD_LOGIC_VECTOR (15 downto 0);
           Mem_out : in  STD_LOGIC_VECTOR (15 downto 0);
           Mem_op : in  STD_LOGIC_VECTOR (1 downto 0);
           WB_data : out  STD_LOGIC_VECTOR (15 downto 0));
end WB_MUX;

architecture RTL of WB_MUX is

begin
	process (ALU_out, Mem_out, Mem_op) begin
		case Mem_op is
			when "10" => WB_data <= Mem_out;
			when others => WB_data <= ALU_out;
		end case;
	end process;
end RTL;

