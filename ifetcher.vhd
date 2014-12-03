----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:27:22 11/29/2014 
-- Design Name: 
-- Module Name:    IFETCHER - RTL 
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

entity INST_FETCHER is
    Port ( Clk : in  STD_LOGIC;
		   Rst : in  STD_LOGIC;
           RAM2_we : out  STD_LOGIC;
           RAM2_oe : out  STD_LOGIC;
           RAM2_en : out  STD_LOGIC;
           PC : in  STD_LOGIC_VECTOR (15 downto 0);
           Inst : out  STD_LOGIC_VECTOR (15 downto 0);
           Clk2 : in  STD_LOGIC;
           RAM2_addr : out  STD_LOGIC_VECTOR (17 downto 0);
           RAM2_data : inout  STD_LOGIC_VECTOR (15 downto 0));
end INST_FETCHER;

architecture RTL of INST_FETCHER is
	signal Inst_reg : STD_LOGIC_VECTOR (15 downto 0);
begin
	RAM2_en <= '0';
	RAM2_oe <= '0';
	RAM2_we <= '1';
	process (Clk2, PC, Rst) begin
		if (Rst = '0') then
			RAM2_data <= "ZZZZZZZZZZZZZZZZ";
		elsif (Clk2'event and Clk2 = '1') then
			Inst_reg <= RAM2_data;
		end if;
		RAM2_addr (15 downto 0) <= PC;
		RAM2_addr (17 downto 16) <= "00";
	end process;
	Inst <= Inst_reg;
end RTL;

