----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    04:26:27 12/01/2014 
-- Design Name: 
-- Module Name:    SEVEN_SEG_DISPLAY - RTL 
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

entity SEVEN_SEG_DISPLAY is
    Port ( Data : in  STD_LOGIC_VECTOR (7 downto 0);
           Output_l : out  STD_LOGIC_VECTOR (6 downto 0);
		   Output_h : out  STD_LOGIC_VECTOR (6 downto 0));
end SEVEN_SEG_DISPLAY;

architecture RTL of SEVEN_SEG_DISPLAY is
	
begin
	process (Data) begin
		case Data(3 downto 0) is
			when "0000" => Output_l <= "1111110";--0
			when "0001" => Output_l <= "0110000";--1
			when "0010" => Output_l <= "1101101";--2
			when "0011" => Output_l <= "1111001";--3
			when "0100" => Output_l <= "0110011";--4
			when "0101" => Output_l <= "1011011";--5
			when "0110" => Output_l <= "1011111";--6
			when "0111" => Output_l <= "1110000";--7
			when "1000" => Output_l <= "1111111";--8
			when "1001" => Output_l <= "1110011";--9
			when "1010" => Output_l <= "1110111";--A
			when "1011" => Output_l <= "0011111";--B
			when "1100" => Output_l <= "1001110";--C
			when "1101" => Output_l <= "0111101";--D
			when "1110" => Output_l <= "1001111";--E
			when "1111" => Output_l <= "1000111";--F
			when others => Output_l <= "0000000";
		end case;
		case Data(7 downto 4) is
			when "0000" => Output_h <= "1111110";--0
			when "0001" => Output_h <= "0110000";--1
			when "0010" => Output_h <= "1101101";--2
			when "0011" => Output_h <= "1111001";--3
			when "0100" => Output_h <= "0110011";--4
			when "0101" => Output_h <= "1011011";--5
			when "0110" => Output_h <= "1011111";--6
			when "0111" => Output_h <= "1110000";--7
			when "1000" => Output_h <= "1111111";--8
			when "1001" => Output_h <= "1110011";--9
			when "1010" => Output_h <= "1110111";--A
			when "1011" => Output_h <= "0011111";--B
			when "1100" => Output_h <= "1001110";--C
			when "1101" => Output_h <= "0111101";--D
			when "1110" => Output_h <= "1001111";--E
			when "1111" => Output_h <= "1000111";--F
			when others => Output_h <= "0000000";
		end case;
	end process;
end RTL;

