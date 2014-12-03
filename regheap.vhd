----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:32:45 12/02/2014 
-- Design Name: 
-- Module Name:    REGHEAP - RTL 
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity REG_HEAP is
    Port ( Clk : in  STD_LOGIC;
           Rst : in  STD_LOGIC;
           Rx : in  STD_LOGIC_VECTOR (2 downto 0);
           Ry : in  STD_LOGIC_VECTOR (2 downto 0);
		   Rw_en : in  STD_LOGIC;
           Rw : in  STD_LOGIC_VECTOR (2 downto 0);
           Rw_d : in  STD_LOGIC_VECTOR (15 downto 0);
           Rx_q : out  STD_LOGIC_VECTOR (15 downto 0);
           Ry_q : out  STD_LOGIC_VECTOR (15 downto 0));
end REG_HEAP;

architecture RTL of REG_HEAP is
	type Reg_t is ARRAY (0 to 7) of STD_LOGIC_VECTOR (15 downto 0);
	signal Reg : Reg_t;
begin
	process (Clk, Rst) begin
		if (Rst = '0') then
			Reg <= (others => (others => '0'));
		elsif (Clk'event and Clk = '1' and Rw_en = '1') then
			Reg(TO_INTEGER(unsigned(Rw))) <= Rw_d;
		end if;
	end process;
	Rx_q <= Reg(TO_INTEGER(unsigned(Rx)));
	Ry_q <= Reg(TO_INTEGER(unsigned(Ry)));
end RTL;

